unit R015UDatasnapRestDM;

interface

uses
  A000UCostanti,
  A000USessione,
  A000UInterfaccia,
  A000Versione,
  B110USharedTypes,
  B110UUtils,
  FunzioniGenerali,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  C200UWebServicesServerUtils,
  DatiBloccati,
  System.SysUtils,
  System.Classes,
  System.TypInfo,
  Generics.Collections,
  Datasnap.DSSession,
  Web.HTTPApp,
  Oracle,
  OracleData;

type
  TR015FDatasnapRestDM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    // info su app client
    FInfoClient: TInfoClient;
    // parametri di login
    FParametriLogin: TParametriLogin;
    // indica se è necessario verificare i parametri di login
    FVerificaLogin: Boolean;
    // risultato di esecuzione del metodo
    FRisultato: TRisultato;
    // verifica blocco riepiloghi
    FDatiBloccati: TDatiBloccati;
    procedure FaseVerificaLogin;
    procedure FaseVerificaParametri;
    procedure FaseVerificaAutenticazione;
    procedure FaseEsecuzione;
  protected
    // dati della sessione iriswin
    SIW: TSessioneIrisWin;
    function ControlloParametri: TResCtrl; virtual; abstract;
    function IsDatoBloccato(PProgressivo: Integer; PData: TDateTime; PRiepilogo: String): Boolean;
    procedure Esegui(var RRisultato: TRisultato); virtual; abstract;
  public
    // tipo di operazione da eseguire nel metodo Esegui
    Operazione: TOperazione;
    procedure Clear; virtual;
    procedure SetSessioneOracle(POracleSession: TOracleSession);
    procedure SetParametriLogin(const PDatiLogin: TParametriLogin); inline;
    function GetParametriLogin: TParametriLogin; inline;
    procedure SetInfoClient(const PInfoClient: TInfoClient); inline;
    function GetInfoClient: TInfoClient; inline;
    procedure EseguiMetodo; virtual; final;
    function GetRisultato: TRisultato; inline;
  end;

implementation

uses
  System.Diagnostics;

{$R *.dfm}

procedure TR015FDatasnapRestDM.DataModuleCreate(Sender: TObject);
const
  NOME_METODO = '%s.DataModuleCreate';
begin
  // dati app
  FInfoClient:=TInfoClient.Create;

  // parametri per il login
  FParametriLogin:=TParametriLogin.Create;

  // crea l'oggetto da restituire come risultato dell'operazione richiesta
  FRisultato:=TRisultato.Create;

  // inizializza variabili
  FVerificaLogin:=False;
end;

procedure TR015FDatasnapRestDM.DataModuleDestroy(Sender: TObject);
const
  NOME_METODO = '%s.DataModuleDestroy';
begin
  // variabili create nel datamodulecreate
  try FreeAndNil(FInfoClient); except end;
  //if FVerificaLogin then
    try FreeAndNil(FParametriLogin); except end;

  // IMPORTANTE
  //   non distruggere l'oggetto FRisultato
  //   perché si tratta dell'oggetto restituito dai vari metodi del B110UServerMethodsDM
  //   questa operazione viene effettuata automaticamente dal framework dopo il marshalling dell'oggetto stesso
  // try FreeAndNil(FRisultato); except end; // NON FARLO!!!
end;

procedure TR015FDatasnapRestDM.Clear;
begin
  try FreeAndNil(FInfoClient); except end;
  try FreeAndNil(FParametriLogin); except end;
  try FreeAndNil(FRisultato); except end;
  try FreeAndNil(FDatiBloccati); except end;
  FVerificaLogin:=False;
end;

function TR015FDatasnapRestDM.IsDatoBloccato(PProgressivo: Integer; PData: TDateTime; PRiepilogo: String): Boolean;
begin
  if FDatiBloccati = nil then
    Result:=False
  else
    Result:=FDatiBloccati.CheckDatoBloccato(PProgressivo,PData,PRiepilogo);
end;

function TR015FDatasnapRestDM.GetParametriLogin: TParametriLogin;
begin
  Result:=FParametriLogin;
end;

procedure TR015FDatasnapRestDM.SetParametriLogin(const PDatiLogin: TParametriLogin);
begin
  FParametriLogin.Assign(PDatiLogin);

  // una volta impostati indica anche l'attivazione del controllo sui dati di login
  FVerificaLogin:=True;
end;

function TR015FDatasnapRestDM.GetInfoClient: TInfoClient;
begin
  Result:=FInfoClient;
end;

procedure TR015FDatasnapRestDM.SetInfoClient(const PInfoClient: TInfoClient);
begin
  FInfoClient.Assign(PInfoClient);
end;

procedure TR015FDatasnapRestDM.SetSessioneOracle(POracleSession: TOracleSession);
// assegna la sessione oracle indicata agli oggetti presenti nel datamodule di tipo:
// - TOracleQuery
// - TOracleDataSet
// - TOracleScript
var
  i: Integer;
  LComp: TComponent;
begin
  for i:=0 to ComponentCount - 1 do
  begin
    LComp:=Components[i];
    if LComp is TOracleQuery then
      try (LComp as TOracleQuery).Session:=POracleSession; except end
    else if LComp is TOracleDataSet then
      try (LComp as TOracleDataSet).Session:=POracleSession; except end
    else if LComp is TOracleScript then
      try (LComp as TOracleScript).Session:=POracleSession; except end;
  end;
end;

procedure TR015FDatasnapRestDM.FaseVerificaLogin;
var
  LResCtrl: TResCtrl;
const
  NOME_METODO = 'FaseVerificaLogin';
begin
  TLogger.EnterMethod(NOME_METODO);

  try
    // controllo formale dei parametri
    LResCtrl:=FParametriLogin.CheckDati(TB110FParametriServer.Impostazioni_TimeoutToken);

    // log operazione
    if LResCtrl.Ok then
    begin
      TLogger.Debug('parametri di login ok');
    end
    else
    begin
      TLogger.Error(Format('errore parametri login: %s',[LResCtrl.Messaggio]));
      raise EC200AuthError.Create(LResCtrl.Messaggio);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TR015FDatasnapRestDM.FaseVerificaParametri;
var
  LResCtrl: TResCtrl;
const
  NOME_METODO = 'FaseVerificaParametri';
begin
  TLogger.EnterMethod(NOME_METODO);

  try
    try
      LResCtrl:=ControlloParametri;
    except
      on E: Exception do
      begin
        // la function è sovrascritta in ogni datamodule, se solleva un'eccezione dà segnalazione
        TLogger.Error('il metodo ControlloParametri ha sollevato un''eccezione',E);
        raise EC200ExecutionError.Create(E.Message,'Errore durante la verifica dei parametri');
      end;
    end;

    if LResCtrl.Ok then
    begin
      TLogger.Debug('parametri della richiesta ok');
    end
    else
    begin
      TLogger.Error(Format('errore nei parametri della richiesta: %s',[LResCtrl.Messaggio]));
      raise EC200InvalidParameter.Create(LResCtrl.Messaggio);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TR015FDatasnapRestDM.FaseVerificaAutenticazione;
var
  LErrore: String;
const
  NOME_METODO = 'FaseVerificaAutenticazione';
begin
  TLogger.EnterMethod(NOME_METODO);
  try
    try
      SIW:=TB110FUtils.GetSessioneIrisWin(FParametriLogin,LErrore);

      if SIW <> nil then
      begin
        // sessione iriswin estratta correttamente
        // assegna la sessione oracle agli oggetti di accesso ai dati
        SetSessioneOracle(SIW.SessioneOracle);
        TLogger.Debug('autenticazione ok');
      end
      else
      begin
        // segnala l'anomalia
        TLogger.Error(Format('errore durante il recupero della sessione iriswin: %s',[LErrore]));
        raise EC200NoConnection.Create(LErrore);
      end;
    except
      on E: Exception do
      begin
        TLogger.Error('eccezione durante la verifica dell''autenticazione',E);
        raise EC200ExecutionError.Create(E.Message,'Errore durante l''autenticazione');
      end;
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TR015FDatasnapRestDM.FaseEsecuzione;
const
  NOME_METODO = 'FaseEsecuzione';
begin
  TLogger.EnterMethod(NOME_METODO);
  try
    // oggetto per verifica blocco riepiloghi
    if SIW <> nil then
      FDatiBloccati:=TDatiBloccati.Create(nil);
    try
      try
        Esegui(FRisultato);
        TLogger.Debug('esecuzione ok');
      except
        on E: Exception do
        begin
          TLogger.Error('eccezione durante l''elaborazione',E);
          raise EC200ExecutionError.Create(E.Message,'Errore durante l''elaborazione');
        end;
      end;
    finally
      // oggetto per verifica blocco riepiloghi
      if FDatiBloccati <> nil then
        try FreeAndNil(FDatiBloccati); except end;
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TR015FDatasnapRestDM.EseguiMetodo;
// esegue l'operazione richiesta
var
  LStopWatch: TStopWatch;
const
  NOME_METODO = 'EseguiMetodo';
begin
  TLogger.SetCategory(CATEGORIA_MONDOEDP);
  TLogger.EnterMethod(NOME_METODO,Self);

  // crea e avvia il timer
  LStopWatch:=TStopwatch.StartNew;

  try
    try
      // 1. effettua controlli pre-esecuzione

      // - 1a. controlla parametri di login e verifica autenticazione
      if FVerificaLogin then
      begin
        // controlla parametri di login a livello formale
        FaseVerificaLogin;

        // controlla autenticazione ed imposta la sessione iriswin SIW
        FaseVerificaAutenticazione;
      end;

      // - 1b. controlla i parametri specifici del metodo richiamato
      FaseVerificaParametri;

      // 2. esegue il metodo richiesto
      FaseEsecuzione;

      // il logoff sessione viene già fatto in TSessioneIrisWIN.Destroy
    except
      // blocco generale di gestione eccezioni per EseguiMetodo
      on E1: EC200Exception do
      begin
        // eccezione contemplata a livello di C200 (già loggata)
        TLogger.Error('Errore durante l''elaborazione',E1);
        FRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
        Exit;
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non gestiti
        TLogger.Error('Errore imprevisto durante l''elaborazione',E2);
        FRisultato.AddError(TErrorCode.Generic,Format('%s (%s)',[E2.Message,E2.ClassName]),'Errore imprevisto durante l''elaborazione');
        Exit;
      end;
    end;
  finally
    // timer di esecuzione
    LStopWatch.Stop;
    FRisultato.SetDurataMetodo(LStopWatch.ElapsedMilliseconds);
    //FreeAndNil(LStopWatchFase); // sembra farlo automaticamente, perché non dà memory leak
    //FreeAndNil(LStopWatch);     // sembra farlo automaticamente, perché non dà memory leak

    TLogger.ExitMethod(NOME_METODO,Self);
  end;
end;

function TR015FDatasnapRestDM.GetRisultato: TRisultato;
begin
  Result:=FRisultato;
end;

end.
