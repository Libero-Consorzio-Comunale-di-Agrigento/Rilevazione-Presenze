unit B017UCheckWebServices;

interface

uses
  A000UCostanti,
  C180FunzioniGenerali,
  FunzioniGenerali,
  Generics.Collections,
  IdHTTP,
  System.Classes,
  System.IniFiles,
  System.IOUtils,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.Net.URLClient,
  System.SysUtils,
  System.Win.Registry,
  Vcl.SvcMgr,
  Winapi.Messages,
  Winapi.ShellAPI,
  Winapi.Windows;

type

  // parametri di configurazione del monitor di un servizio
  TMonitorConfig = record
    PollingInterval: Integer;
    Url: String;
    Timeout: Integer;
    TimeoutAction: String;
    function ToString: String;
  end;

  // monitor di un servizio
  TServiceMonitor = class(TObject)
  private
    FConfig: TMonitorConfig;
    HTTPClient: TNetHTTPClient;
    HTTPRequest: TNetHTTPRequest;
    function PingConnection: TResCtrl;
    function DoTimeoutAction: TResCtrl;
    procedure SetConfig(Value: TMonitorConfig);
  public
    constructor Create(PConfig: TMonitorConfig);
    destructor Destroy; override;
    procedure CheckConnection;
    property Config: TMonitorConfig read FConfig write SetConfig;
  end;

  // thread che si occupa di monitorare un servizio
  TB017SvcThread = class(TThread)
  private
    FMonitor: TServiceMonitor;
  protected
    procedure Execute; override;
  public
    constructor Create(PMonitor: TServiceMonitor);
    property Monitor: TServiceMonitor read FMonitor write FMonitor;
  end;

  TB017FCheckWebServices = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceAfterInstall(Sender: TService);
  private
    FMonitorList: TObjectList<TServiceMonitor>;
    FThreadList: TObjectList<TB017SvcThread>;
    procedure ReadConfiguration;
    procedure StopShutDown;
    procedure CreateThreadList;
    const
      FILE_CONFIGURAZIONE = 'B017.ini';
      INI_ID_POLLING_INTERVAL = 'PollingInterval';
      INI_ID_POLLING_INTERVAL_DEFAULT = 60;
      INI_ID_URL = 'Url';
      INI_ID_TIMEOUT = 'Timeout';
      INI_ID_TIMEOUT_DEFAULT = 20;
      INI_ID_AZIONE = 'TimeoutAction';
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  B017FCheckWebServices: TB017FCheckWebServices;

const
 FILE_LOG = 'B017.log';

function B017ScriviMsgLog(const Msg:String):Boolean;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  B017FCheckWebServices.Controller(CtrlCode);
end;

function TB017FCheckWebServices.GetServiceController: TServiceController;
begin
  Result:=ServiceController;
end;

procedure TB017FCheckWebServices.ServiceAfterInstall(Sender: TService);
// imposta la descrizione del servizio (visibile da services.msc di windows)
var
  Reg: TRegistry;
begin
  Reg:=TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, False) then
    begin
      Reg.WriteString('Description', 'Questo servizio effettua il monitoraggio dello stato di altri servizi Iris.');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TB017FCheckWebServices.ServiceStart(Sender: TService; var Started: Boolean);
const
  NOME_METODO = 'TB017FCheckWebServices.ServiceStart';
begin
  TLogger.EnterMethod(NOME_METODO);
  B017ScriviMsgLog('Enter:' + NOME_METODO);
  try
    // legge la configurazione dei servizi da monitorare
    ReadConfiguration;

    // crea e avvia i thread che si occupano del monitoraggio
    CreateThreadList;
  finally
    TLogger.ExitMethod(NOME_METODO);
    B017ScriviMsgLog('Exit:' + NOME_METODO);
  end;
end;

procedure TB017FCheckWebServices.ServiceStop(Sender: TService; var Stopped: Boolean);
const
  NOME_METODO = 'TB017FCheckWebServices.ServiceStop';
begin
  TLogger.EnterMethod(NOME_METODO);
  B017ScriviMsgLog('Enter:' + NOME_METODO);
  try
    StopShutDown;
  finally
    TLogger.ExitMethod(NOME_METODO);
    B017ScriviMsgLog('Exit:' + NOME_METODO);
  end;
end;

procedure TB017FCheckWebServices.ServiceShutdown(Sender: TService);
const
  NOME_METODO = 'TB017FCheckWebServices.ServiceShutdown';
begin
  TLogger.EnterMethod(NOME_METODO);
  B017ScriviMsgLog('Enter:' + NOME_METODO);
  try
    StopShutDown;
  finally
    TLogger.ExitMethod(NOME_METODO);
    B017ScriviMsgLog('Exit:' + NOME_METODO);
  end;
end;

procedure TB017FCheckWebServices.ReadConfiguration;
// legge la configurazione dei servizi da monitorare
// dal file B017.ini presente nella cartella di installazione
var
  LIniFile: TIniFile;
  LPathInst,LPathFileConfig: String;
  LSectionList: TStringList;
  LSection: String;
  LConfig: TMonitorConfig;
  LMonitor: TServiceMonitor;
  i: Integer;
const
  NOME_METODO = 'TB017FCheckWebServices.ReadConfiguration';
begin
  TLogger.EnterMethod(NOME_METODO);
  B017ScriviMsgLog('Enter:' + NOME_METODO);
  try
    // determina il file ini di configurazione dell'applicativo
    LPathInst:=TPath.GetDirectoryName(GetModuleName(HInstance));
    LPathFileConfig:=TPath.Combine(LPathInst,FILE_CONFIGURAZIONE);

    // verifica che il file sia esistente
    if not TFile.Exists(LPathFileConfig) then
    begin
      TLogger.Error('File di configurazione non trovato o non accessibile: ' + LPathFileConfig);
      B017ScriviMsgLog('File di configurazione non trovato o non accessibile: ' + LPathFileConfig);
      raise Exception.CreateFmt('Il file di configurazione non è presente oppure non è accessibile:'#13#10'%s',[LPathFileConfig]);
    end;

    FMonitorList:=TObjectList<TServiceMonitor>.Create;

    LSectionList:=TStringList.Create;
    LIniFile:=TIniFile.Create(LPathFileConfig);
    try
      try
        LIniFile.ReadSections(LSectionList);

        TLogger.Debug('Numero di servizi da monitorare',LSectionList.Count);
        B017ScriviMsgLog(Format('Numero di servizi da monitorare %d', [LSectionList.Count]));

        for i:=0 to LSectionList.Count - 1 do
        begin
          LSection:=LSectionList[i];

          // impostazioni monitor
          LConfig.Url:=LIniFile.ReadString(LSection,INI_ID_URL,'');
          LConfig.PollingInterval:=LIniFile.ReadInteger(LSection,INI_ID_POLLING_INTERVAL,INI_ID_POLLING_INTERVAL_DEFAULT);
          LConfig.Timeout:=LIniFile.ReadInteger(LSection,INI_ID_TIMEOUT,INI_ID_TIMEOUT_DEFAULT);
          LConfig.TimeoutAction:=LIniFile.ReadString(LSection,INI_ID_AZIONE,'');

          // log delle impostazioni
          TLogger.Debug(Format('#%.2d [%s]',[i + 1,LSection]));
          TLogger.Debug(Format('#%.2d Url',[i + 1]),LConfig.Url);
          TLogger.Debug(Format('#%.2d PollingInterval',[i + 1]),LConfig.PollingInterval);
          TLogger.Debug(Format('#%.2d Timeout',[i + 1]),LConfig.Timeout);
          TLogger.Debug(Format('#%.2d TimeoutAction',[i + 1]),LConfig.TimeoutAction);

          // crea l'oggetto che si occupa del monitoraggio e lo aggiunge alla relativa objectlist
          LMonitor:=TServiceMonitor.Create(LConfig);
          FMonitorList.Add(LMonitor);
        end;
      except
        on E: Exception do
        begin
          TLogger.Error('Errore durante lettura configurazione', E);
          B017ScriviMsgLog(Format('Errore durante lettura configurazione %s', [E.Message]));
          raise Exception.CreateFmt('Errore durante la lettura del file di configurazione'#13#10'%s'#13#10'%s',[LPathFileConfig,E.Message]);
        end;
      end;
    finally
      FreeAndNil(LIniFile);
      FreeAndNil(LSectionList);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
    B017ScriviMsgLog('Exit:' + NOME_METODO);
  end;
end;

procedure TB017FCheckWebServices.CreateThreadList;
// crea la lista di thread che si occupano di monitorare i servizi
var
  LThread: TB017SvcThread;
  LMonitor: TServiceMonitor;
const
  NOME_METODO = 'TB017FCheckWebServices.CreateThreadList';
begin
  TLogger.EnterMethod(NOME_METODO);
  B017ScriviMsgLog('Enter:' + NOME_METODO);
  try
    FThreadList:=TObjectList<TB017SvcThread>.Create(False);

    for LMonitor in FMonitorList do
    begin
      // crea istanza del thread che contiene il codice del servizio
      LThread:=TB017SvcThread.Create(LMonitor);

      // impostare altre proprietà del thread in questo blocco
      // LThread.xxx:=yyy;
      // ...

      // avvia thread
      LThread.Start;

      TLogger.Debug(Format('Thread avviato per il servizio %s',[LMonitor.Config.Url]),LThread.ThreadID);

      // aggiunge il thread alla lista
      FThreadList.Add(LThread);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
    B017ScriviMsgLog('Exit:' + NOME_METODO);
  end;
end;

procedure TB017FCheckWebServices.StopShutDown;
// metodo che si occupa di arrestare il servizio
var
  LThread: TB017SvcThread;
const
  NOME_METODO = 'TB017FCheckWebServices.StopShutDown';
begin
  TLogger.EnterMethod(NOME_METODO);
  B017ScriviMsgLog('Enter:' + NOME_METODO);
  try
    try
      // termina e distrugge i thread
      if Assigned(FThreadList) then
      begin
        TLogger.Debug(Format('Distruzione di n. %d thread presenti nella lista',[FThreadList.Count]));
        B017ScriviMsgLog(Format('Distruzione di n. %d thread presenti nella lista',[FThreadList.Count]));
        for LThread in FThreadList do
        begin
          // il servizio deve attendere la terminazione del thread ed effettuarne la free
          TLogger.Debug('Invio richiesta di terminazione al thread',LThread.ThreadID);
          B017ScriviMsgLog(Format('Invio richiesta di terminazione al thread %d',[LThread.ThreadID]));
          LThread.Terminate;

          TLogger.Debug('Attesa di terminazione del thread',LThread.ThreadID);
          B017ScriviMsgLog(Format('Attesa di terminazione del thread %d',[LThread.ThreadID]));
          LThread.WaitFor;

          // distruzione del thread
          TLogger.Debug('Distruzione del thread',LThread.ThreadID);
          B017ScriviMsgLog(Format('Distruzione del thread %d',[LThread.ThreadID]));
          LThread.Free;
        end;

        TLogger.Debug('Distruzione della lista dei thread');
        B017ScriviMsgLog('Distruzione della lista dei thread');
        FreeAndNil(FThreadList);
      end;

      // distrugge la lista dei monitor
      TLogger.Debug('Distruzione della lista dei monitor (ownsobject = true)');
      B017ScriviMsgLog('Distruzione della lista dei monitor (ownsobject = true)');
      FreeAndNil(FMonitorList);
    except
      on E: Exception do
      begin
        TLogger.Error('Errore durante lo stop del servizio',E);
        B017ScriviMsgLog(Format('Errore durante lo stop del servizio %s',[E.Message]));
      end;
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
    B017ScriviMsgLog('Exit:' + NOME_METODO);
  end;
end;

{ TB017SvcThread }

constructor TB017SvcThread.Create(PMonitor: TServiceMonitor);
// crea il thread Suspended in modo da poter impostare proprietà prima di effettuare lo start
begin
  // la free viene effettuata manualmente
  FreeOnTerminate:=False;

  // crea il thread suspended
  inherited Create(True);

  // imposta il service monitor
  Monitor:=PMonitor;
end;

procedure TB017SvcThread.Execute;
var
  LCount: Integer;
begin
  LCount:=0;

  while not Terminated do
  begin
    LCount:=LCount + 1;
    if LCount >= FMonitor.Config.PollingInterval then
    begin
      LCount:=0;

      // monitora la connessione
      FMonitor.CheckConnection;
    end;

    Sleep(1000);
  end;
end;

{ TServiceMonitor }

constructor TServiceMonitor.Create(PConfig: TMonitorConfig);
begin
  SetConfig(PConfig);
end;

destructor TServiceMonitor.Destroy;
begin
  inherited;
end;

procedure TServiceMonitor.SetConfig(Value: TMonitorConfig);
begin
  // salva la configurazione indicata
  FConfig:=Value;
end;

procedure TServiceMonitor.CheckConnection;
var
  LRes: TResCtrl;
begin
  // verifica la connessione
  LRes:=PingConnection;
  if not LRes.Ok then
  begin
    TLogger.Error(Format('Ping fallito su %s: %s',[FConfig.Url,LRes.Messaggio]));
    B017ScriviMsgLog(Format('Ping fallito su %s: %s',[FConfig.Url,LRes.Messaggio]));

    // azione in risposta al timeout
    LRes:=DoTimeoutAction;
    if not LRes.Ok then
    begin
      TLogger.Error(Format('Errore esecuzione azione %s: %s',[FConfig.TimeoutAction,LRes.Messaggio]));
      B017ScriviMsgLog(Format('Errore esecuzione azione %s: %s',[FConfig.TimeoutAction,LRes.Messaggio]));
    end;
  end
  else
    B017ScriviMsgLog(Format('Ping andato a buon fine %s',[FConfig.Url]));
end;

function TServiceMonitor.PingConnection: TResCtrl;
// effettua il ping del servizio indicato nella configurazione
var
  LResp: String;
  HTTPResponse: IHTTPResponse;
begin
  Result.Ok:=False;
  Result.Messaggio:='';
  try
    try
      HTTPClient:=TNetHTTPClient.Create(nil);
      HTTPClient.HandleRedirects:=True;
      HTTPClient.ConnectionTimeout:=FConfig.Timeout;
      HTTPClient.ResponseTimeout:=FConfig.Timeout;
      HTTPClient.UserAgent:='Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)';

      HTTPRequest:=TNetHTTPRequest.Create(nil);
      HTTPRequest.Client:=HTTPClient;
      HTTPRequest.ConnectionTimeout:=FConfig.Timeout;
      HTTPRequest.ResponseTimeout:=FConfig.Timeout;

      // effettua una get della url indicata
      HTTPResponse:=HTTPRequest.Get(FConfig.Url);
      if (HTTPResponse.StatusCode = 200) then
      begin
        // se è stata ottenuta una risposta assume che il servizio sia up
        Result.Ok:=True;
      end;
    finally
      if Assigned(HTTPClient) then
        FreeAndNil(HTTPClient);
      if Assigned(HTTPRequest) then
        FreeAndNil(HTTPRequest);
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format('%s (%s)',[E.Message, E.ClassName]);
      Exit;
    end;
  end;
end;

function TServiceMonitor.DoTimeoutAction: TResCtrl;
// esegue l'azione prevista in caso di timeout della connessione
// (presumibilmente un riavvio del servizio)
var
  LExecRes: T180SyncProcessExecResults;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // esegue il comando e ne attende il risultato
  TLogger.Debug('Esecuzione azione di timeout',FConfig.TimeoutAction);
  B017ScriviMsgLog(Format('Esecuzione azione di timeout %s',[FConfig.TimeoutAction]));
  LExecRes:=R180SyncProcessExec(FConfig.TimeoutAction,TFunzioniGenerali.GetInstallationPath,'');

  // valuta il risultato del comando
  Result.Ok:=LExecRes.CodiceUscita = 0;
  if not Result.Ok then
    Result.Messaggio:=LExecRes.DatiStdErr;
end;

{ TMonitorConfig }

function TMonitorConfig.ToString: String;
begin
  Result:=Format('PollingInterval: %d'#13#10,[PollingInterval]) +
          Format('Url: %s'#13#10,[Url]) +
          Format('Timeout: %d'#13#10,[Timeout]) +
          Format('TimeoutAction: %s'#13#10,[TimeoutAction]);
end;

function B017ScriviMsgLog(const Msg:String):Boolean;
var
  sPath: String;
begin
  Result:=True;
  try
    sPath:=Trim(R180GetRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG','c:\IrisWIN\Archivi'));
    if sPath = '' then
      exit;
    if Copy(sPath,Length(sPath),1) <> '\' then
      sPath:=sPath + '\';
    if ForceDirectories(sPath) then
    begin
      R180AppendFile(sPath + FILE_LOG, Format('[%s %s] %s', [DateToStr(Now), TimeToStr(Now), Msg]));
      Result:=True;
    end;
  except
  end;
end;

initialization
  // configura il logger
  TLogger.Configure(TLogOptions.Create('servizio B017',True,True,R180GetPathLog));

end.
