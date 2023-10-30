unit B024UADSCatanzaroDM;

interface

uses
  A000UCostanti,
  A000USessione,
  B024UADSCatanzaroIntf,
  FunzioniGenerali,
  C180FunzioniGenerali,
  Oracle,
  OracleData,
  System.IniFiles,
  System.SysUtils,
  System.Classes, System.IOUtils, IdCustomTCPServer, IdCustomHTTPServer,
  IdSoapServerHTTP, IdBaseComponent, IdComponent, IdSoapComponent,
  IdSoapITIProvider, IdSoapServer, System.StrUtils;

type
  TB024Config = record
    Port: Integer;
    Database: String;
    Azienda: String;
    FileLog: Boolean;
    LiveViewLog: Boolean;
    ServerURL: String;
  end;

  TB024FADSCatanzaroDM = class(TDataModule)
    selI090: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSessioneIrisWIN: TSessioneIrisWin;
    lstSessioniMondoEDP: array of TOracleSession;
    lstSessioniOracle: array of TOracleSession;
    function GetSessioneOracle(LogonDB, LogonUsr, LogonPwd: String): Integer;
  public
    function EstraiSessioneOracle(const PDatabase, PAzienda: String): TOracleSession;
    property SessioneIrisWIN: TSessioneIrisWin read FSessioneIrisWIN;
  end;

var
  B024FADSCatanzaroDM: TB024FADSCatanzaroDM;
  GInstallPath: String;
  GFileServerConfigPath: String;
  GFileClientConfigPath: String;
  GIniFileServer: TIniFile;
  GIniFileClient: TIniFile;
  GConfig: TB024Config;

const
  B024_SERVER_INI = 'B024.ini';
  B024_SERVER_INI_SEZIONE_IMPOSTAZIONI = 'Impostazioni';
  B024_SERVER_INI_SEZIONE_DEBUG = 'Debug';
  B024_CLIENT_INI = 'B024.client.ini';
  B024_CLIENT_INI_SEZIONE_SERVER = 'Server';
  B024_CLIENT_INI_SEZIONE_VALORI = 'ValoriMemorizzati';

implementation

{$R *.dfm}

procedure TB024FADSCatanzaroDM.DataModuleCreate(Sender: TObject);
begin
  FSessioneIrisWIN:=TSessioneIrisWin.Create(nil);
end;

procedure TB024FADSCatanzaroDM.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  // distruzione liste di oracle session
  for i:=0 to High(lstSessioniMondoEDP) do
  begin
    try lstSessioniMondoEDP[i].LogOff; except end;
    FreeAndNil(lstSessioniMondoEDP[i]);
  end;
  SetLength(lstSessioniMondoEDP,0);

  for i:=0 to High(lstSessioniOracle) do
  begin
    try lstSessioniOracle[i].LogOff; except end;
    FreeAndNil(lstSessioniOracle[i]);
  end;
  SetLength(lstSessioniOracle,0);

  FreeAndNil(FSessioneIrisWIN);
end;

function TB024FADSCatanzaroDM.EstraiSessioneOracle(const PDatabase, PAzienda: String): TOracleSession;
var
  LIndice: Integer;
  LLogonDB,LLogonUsr,LLogonPwd: WideString;
const
  NOME_METODO = 'TB024FADSCatanzaroDM.EstraiSessioneOracle';
begin
  Result:=nil;
  TLogger.EnterMethod(NOME_METODO);

  try
    //Cerco la sessione oracle corrispondente a DB e Azienda specificati
    LLogonDB:=IfThen(PDatabase = '',GConfig.Database,PDatabase);
    LLogonUsr:='MONDOEDP';
    //LLogonPwd:=A000GetPassword;

    //TLogger.Debug(Format('SessioneMONDOEDP:%s %s %s ',[LLogonDB,LLogonUsr,LLogonPwd]));

    LIndice:=GetSessioneOracle(LLogonDB,LLogonUsr,''(*LLogonPwd*));
    if LIndice = -1 then
    begin
      TLogger.Error('Connessione al database MONDOEDP non riuscita');
      raise Exception.Create('Connessione al db MONDOEDP non riuscita');
    end;
    TLogger.Debug('Indice SessioneOracle MondoEDP',LIndice);

    // estrae i dati dell'azienda dalla tabella I090 di MONDOEDP
    try
      selI090.Session:=lstSessioniOracle[LIndice];
      selI090.SetVariable('AZIENDA',PAzienda);
      selI090.Execute;
      LLogonUsr:=selI090.FieldAsString(0);
      LLogonPwd:=TFunzioniGenerali.Decripta(selI090.FieldAsString(1),21041974);
    except
      on E: Exception do
      begin
        TLogger.Error(Format('L''azienda "%s" non è presente nel database',[PAzienda]),E);
        raise Exception.CreateFmt('L''azienda "%s" non è presente nel database',[PAzienda]);
      end;
    end;
    selI090.Close;

    // estrae l'indice della oracle session
    LIndice:=GetSessioneOracle(LLogonDB,LLogonUsr,LLogonPwd);
    TLogger.Debug('Indice SessioneOracle aziendale',LIndice);

    // valuta errore ricerca sessione
    if LIndice = -1 then
    begin
      TLogger.Error(Format('Connessione al database %s non riuscita',[LLogonDB]));
      raise Exception.Create('Connessione al db dell''azienda non riuscita');
    end;

    // restituisce la sessione oracle individuata
    Result:=lstSessioniOracle[LIndice];
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

function TB024FADSCatanzaroDM.GetSessioneOracle(LogonDB, LogonUsr, LogonPwd: String): Integer;
var
  i,k:Integer;
const
  NOME_METODO = 'TB024FADSCatanzaroDM.GetSessioneOracle';
begin
  Result:=-1;
  TLogger.EnterMethod(NOME_METODO);
  try
    for i:=0 to High(lstSessioniOracle) do
    begin
      if (lstSessioniOracle[i].LogonDatabase = LogonDB) and
         (lstSessioniOracle[i].LogonUserName = LogonUsr) and
         (1 = 1)(*(lstSessioniOracle[i].LogonPassword = LogonPwd)*) then
      begin
        Result:=i;
        Break;
      end;
    end;
    if Result = -1 then
    begin
      TLogger.Debug('Creazione di una nuova SessioneOracle: inizio');
      SetLength(lstSessioniOracle,Length(lstSessioniOracle) + 1);
      Result:=High(lstSessioniOracle);
      k:=Result;
      lstSessioniOracle[k]:=TOracleSession.Create(nil);
      lstSessioniOracle[k].LogonDatabase:=LogonDB;
      lstSessioniOracle[k].LogonUserName:=LogonUsr;
      lstSessioniOracle[k].NullValue:=nvNull;
      lstSessioniOracle[k].Preferences.ZeroDateIsNull:=False;
      lstSessioniOracle[k].Preferences.TrimStringFields:=False;
      lstSessioniOracle[k].Preferences.UseOCI7:=False;
      lstSessioniOracle[k].ThreadSafe:=True;
      lstSessioniOracle[k].Name:='SessioneOracleB024_' + IntToStr(k);
      try
        if LogonPwd = '' then
          LogonPwd:=A000GetPassword(A000FilePwdApplication);
        lstSessioniOracle[k].LogonPassword:=LogonPwd;
        lstSessioniOracle[k].Logon;
      except
        try
          lstSessioniOracle[k].LogonPassword:=A000GetPassword(A000FilePwdHost);
          lstSessioniOracle[k].Logon;
        except
          lstSessioniOracle[k].LogonPassword:=A000PasswordFissa;
          lstSessioniOracle[k].Logon;
        end;
      end;
      TLogger.Debug('Creazione di una nuova SessioneOracle: terminata');
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

initialization

  GInstallPath:=TPath.GetDirectoryName(GetModuleName(HInstance));
  GFileServerConfigPath:=TPath.Combine(GInstallPath,B024_SERVER_INI);
  GFileClientConfigPath:=TPath.Combine(GInstallPath,B024_CLIENT_INI);

  // estrae parametri da file di configurazione
  GIniFileServer:=TIniFile.Create(GFileServerConfigPath);
  try
    // impostazioni
    GConfig.Port:=GIniFileServer.ReadInteger(B024_SERVER_INI_SEZIONE_IMPOSTAZIONI,'Port',80);
    GConfig.Database:=GIniFileServer.ReadString(B024_SERVER_INI_SEZIONE_IMPOSTAZIONI,'Database','');
    GConfig.Azienda:=GIniFileServer.ReadString(B024_SERVER_INI_SEZIONE_IMPOSTAZIONI,'Azienda','');

    // debug
    GConfig.FileLog:=GIniFileServer.ReadString(B024_SERVER_INI_SEZIONE_DEBUG,'FileLog','N') = 'S';
    GConfig.LiveViewLog:=GIniFileServer.ReadString(B024_SERVER_INI_SEZIONE_DEBUG,'LiveViewLog','N') = 'S';
  finally
    FreeAndNil(GIniFileServer);
  end;

  // estrae parametri da file di configurazione del client
  GIniFileClient:=TIniFile.Create(GFileClientConfigPath);
  try
    GConfig.ServerURL:=GIniFileClient.ReadString(B024_CLIENT_INI_SEZIONE_SERVER,'URL','');
  finally
    FreeAndNil(GIniFileClient);
  end;

end.
