unit B110UUtils;

interface

uses
  A000UCostanti,
  A000USessione,
  B110USharedTypes,
  C200UWebServicesTypes,
  C180FunzioniGenerali,
  CodeSiteLogging,
  FunzioniGenerali,
  System.IniFiles,
  System.StrUtils,
  System.SysUtils,
  System.IOUtils,
  Data.DB,
  FireDAC.Comp.Client,
  System.Classes,
  Data.DBXPlatform;

type

  TB110FUtils = class
  public
    class function GetTempFilePath: String; static;
    class function GetSessioneIrisWin(var RDatiLogin: TParametriLogin; var RErrMsg: String; Chiamante:String = 'B110'): TSessioneIrisWIN; static;
  end;

  TB110FParametriServer = class
  private
    // porta sulla quale mettersi in ascolto (solo eseguibile standalone, NO versione dll)
    class var FImpostazioni_Port: Integer;
    // numero di thread da prevedere nel pool iniziale (0 = nessun pool)
    class var FImpostazioni_PoolSize: Integer;
    // numero max di connessioni concorrenti
    class var FImpostazioni_MaxConnections: Integer;
    // timeout di sessione (espresso in ms)
    class var FImpostazioni_SessionTimeout: Integer;
    // indica se eseguire immediatamente la closesession dopo l'esecuzione del metodo richiamato
    class var FImpostazioni_CloseSessionImmediata: Boolean;
    // indica il tempo di validità del token di accesso (espresso in ms)
    class var FImpostazioni_TimeoutToken: Integer;
    // indica se effettuare il log su file
    class var FImpostazioni_FileLog: Boolean;
    // indica se effettuare il log su liveview
    class var FImpostazioni_LiveViewLog: Boolean;

    // valore di default per l'azienda (qualora non venga indicata)
    class var FDefault_Azienda: String;
    // valore di default per il database (qualora non venga indicato)
    class var FDefault_Database: String;
    // valore di default per il profilo utente (qualora non esista il default)
    class var FDefault_Profilo: String;
    // valore di default per il parametro LoginEsterno
    class var FDefault_LoginEsterno: String;
  public
    class constructor Create;
    class destructor Destroy;
    class function ToString: String; static;
    class property Impostazioni_Port: Integer read FImpostazioni_Port;
    class property Impostazioni_PoolSize: Integer read FImpostazioni_PoolSize;
    class property Impostazioni_MaxConnections: Integer read FImpostazioni_MaxConnections;
    class property Impostazioni_SessionTimeout: Integer read FImpostazioni_SessionTimeout;
    class property Impostazioni_CloseSessionImmediata: Boolean read FImpostazioni_CloseSessionImmediata;
    class property Impostazioni_TimeoutToken: Integer read FImpostazioni_TimeoutToken;
    class property Impostazioni_FileLog: Boolean read FImpostazioni_FileLog;
    class property Impostazioni_LiveViewLog: Boolean read FImpostazioni_LiveViewLog;
    class property Default_Azienda: String read FDefault_Azienda;
    class property Default_Database: String read FDefault_Database;
    class property Default_Profilo: String read FDefault_Profilo;
  end;

var
  GCSAutenticazioneDominio: TmedpCriticalSection;

const
  CATEGORIA_DATASNAP = 'Metodi Datasnap';
  CATEGORIA_MONDOEDP = 'Metodi MondoEdp';

implementation

uses
  A000Versione,
  A000UInterfaccia,
  A001UPasswordDtm1,
  RegistrazioneLog,
  Datasnap.DSSession,
  Oracle,
  Web.HTTPApp,
  WinApi.Windows;

{ TB110FUtils }

class function TB110FUtils.GetTempFilePath: String;
begin
  Result:=TPath.Combine(TFunzioniGenerali.GetInstallationPath,'archivi\temp');
end;

class function TB110FUtils.GetSessioneIrisWin(var RDatiLogin: TParametriLogin; var RErrMsg: String; Chiamante:String = 'B110'): TSessioneIrisWIN;
// restituisce oggetto SessioneIrisWin oppure nil in caso di errore
var
  A001DtM: TA001FPasswordDtM1;
  LCurrentDSSession: TDSSession;
  OQ: TOracleQuery;
  LoginEsterno,locPassword,locDom,SuffissoLDAP: String;
  AuthDom: Boolean;
  LResCtrl: TResCtrl;
const
  NOME_PROC  = 'TB110FUtils.GetSessioneIrisWin';
  ERROR_TEXT = 'Errore in fase di accesso: %s';
begin
  RErrMsg:='';
  Result:=nil;

  // controllo parametri

  // azienda
  if RDatiLogin.Azienda = AZIENDA_DEFAULT then
    RDatiLogin.Azienda:=TB110FParametriServer.Default_Azienda;

  // se i parametri per l'accesso sono formalmente errati esce restituendo nil
  LResCtrl:=RDatiLogin.CheckDati(TB110FParametriServer.Impostazioni_TimeoutToken);
  if (Chiamante = 'B110') and not LResCtrl.Ok then
  begin
    RErrMsg:=Format(ERROR_TEXT,[LResCtrl.Messaggio]);
    Exit;
  end;

  // creazione sessione IrisWin
  if Chiamante = 'B110' then
    Result:=TSessioneIrisWIN.Create(nil)
  else
    Result:=A000SessioneIrisWIN;

  if Chiamante = 'B110' then
  begin
    // IMPORTANTE
    // l'oggetto sessioneiriswin viene immediatamente associato alla sessione datasnap
    // questo viene utilizzato nella function globale A000SessioneIrisWIN definita in A000UInterfaccia
    LCurrentDSSession:=TDSSessionManager.GetThreadSession;
    //if LCurrentDSSession.IsValid then
    LCurrentDSSession.PutObject(DS_OBJECT_SESSIONE_IRISWIN,Result);
  end;

  // imposta proprietà dell'oggetto sessioneiriswin

  // sessione oracle
  Result.SessioneOracle.Preferences.UseOCI7:=False;
  //Result.SessioneOracle.ThreadSafe:=True;//Già definito in A000ParamDBOracleMultiThread
  Result.SessioneOracle.StatementCache:=True;
  Result.SessioneOracle.StatementCacheSize:=20;
  Result.SessioneOracle.Pooling:=spNone; // con spInternal ci sono problemi (probabili deadlock)

  // parametri
  Result.Parametri.VersionePJ:=VersionePA;
  Result.Parametri.Database:=TB110FParametriServer.Default_Database;
  Result.Parametri.Azienda:=RDatiLogin.Azienda;
  Result.Parametri.Operatore:=RDatiLogin.Utente;

  Result.Name:=SIGLA_SERVIZIO;
  A001DtM:=TA001FPasswordDtM1.Create(Result);
  try
    try
      A001DtM.InizializzazioneSessione(TB110FParametriServer.Default_Database);
      // verifica azienda su I090
      // PRE: RDatiLogin.Azienda <> ''
      A001DtM.QI090.Close;
      A001DtM.QI090.SetVariable('AZIENDA',RDatiLogin.Azienda);
      A001DtM.QI090.Open;
      if A001DtM.QI090.RecordCount = 0 then
        RErrMsg:=Format('azienda inesistente [%s]',[RDatiLogin.Azienda]);

      // verifica utente su I060
      if RErrMsg = '' then
      begin
        // PRE:
        //   RDatiLogin.Azienda <> ''
        //   RDatiLogin.Utente <> ''
        with A001DtM do
        begin
          OpenI060I070(['I060'], RDatiLogin.Utente);
          if (QI060.RecordCount = 0) and (GetSuffissoLDAP('I060') <> '') then
          begin //Ricerca con suffisso LDAP su I060
            SuffissoLDAP:=GetSuffissoLDAP('I060');
            //Anche se è stato trovato l'utente su I070 verifico se esiste su I060 con/senza suffisso.
            //In tal caso deve prevalere il profilo su I060
            if Uppercase(RDatiLogin.Utente).IndexOf(UpperCase(SuffissoLDAP)) > 0 then
            begin
              //Verifico se esiste il nome utente senza il suffisso
              OpenI060I070(['I060'], StringReplace(RDatiLogin.Utente, SuffissoLDAP, '', [rfReplaceAll, rfIgnoreCase]));
              if QI060.RecordCount > 0 then
                RDatiLogin.Utente:=StringReplace(RDatiLogin.Utente, SuffissoLDAP, '', [rfReplaceAll, rfIgnoreCase]);
            end
            else
            begin
              //Verifico se esiste il nome utente con il suffisso
              OpenI060I070(['I060'], RDatiLogin.Utente + SuffissoLDAP);
              if QI060.RecordCount > 0 then
              begin
                RDatiLogin.Utente:=RDatiLogin.Utente + SuffissoLDAP;
                SuffissoLDAP:='';
              end;
            end;
          end;
        end;

        if (A001DtM.QI060.RecordCount = 0) and ((RDatiLogin.Utente <> '') or (Chiamante = 'B110')) then
          RErrMsg:=Format('utente inesistente [%s]',[RDatiLogin.Utente]);
      end;

      // controllo autenticazione utente/password
      if (RErrMsg = '') and (RDatiLogin.Utente <> '') then
      begin
        if Chiamante = 'B110' then
          LoginEsterno:=TB110FParametriServer.FDefault_LoginEsterno
        else
          LoginEsterno:='S';

        locPassword:=A001DtM.QI060.FieldByName('PassWord').AsString;
        //Se viene usato l'alias NOME_UTENTE2, questo può essere autenticato solo nel dominio
        if (not A001DtM.QI090.FieldByName('DOMINIO_DIP').IsNull) and
           (UpperCase(RDatiLogin.Utente) = UpperCase(A001DtM.QI060.FieldByName('Nome_Utente2').AsString)) then
        begin
          locPassword:='';
        end;
        //Alberto: autenticazione su dominio
        if (not A001DtM.QI090.FieldByName('DOMINIO_DIP').IsNull) and locPassword.IsEmpty and
           ((LoginEsterno = 'N') or (Result.Parametri.CampiRiferimento.C90_SSO_RDLPassphrase = '')) //Nel caso di LoginEsterno = S, posso saltare il controllo se è attiva l'autenticazione SSOAds che prevede il parametro usr criptato
        then
        begin
          //MI_HSACCO: doppio dominio! ciclo sui domini separati da ';'
          AuthDom:=False;
          for locDom in A001DtM.QI090.FieldByName('DOMINIO_DIP').AsString.Split([';',',']) do
          begin
            GCSAutenticazioneDominio.Enter;
            try
              AuthDom:=A001DtM.AutenticazioneDominio(locDom, RDatiLogin.Utente, RDatiLogin.Password, A001DtM.QI090.FieldByName('DOMINIO_DIP_TIPO').AsString, A001DtM.QI090.FieldByName('DOMINIO_LDAP_DN').AsString, SuffissoLDAP);
              Parametri.AuthDomInfo.DominioDip:=locDom;
              if AuthDom then
                Break;
            finally
              GCSAutenticazioneDominio.Leave;
            end;
          end;
          if not AuthDom and ((RDatiLogin.Password = '') or (RDatiLogin.Password <> TFunzioniGenerali.Decripta(locPassword,30011945))) then
            RErrMsg:='autenticazione fallita';
        end
        //Fine autenticazione su dominio
        else if (LoginEsterno = 'N') and (RDatiLogin.Password <> TFunzioniGenerali.Decripta(A001DtM.QI060.FieldByName('PassWord').AsString,30011945)) then
        begin
          RErrMsg:=Format('password errata',[]);
        end;
        if RErrMsg <> '' then
          RErrMsg:=Format('Azienda:%s - Utente:%s' + CRLF + RErrMsg,[Result.Parametri.Azienda,Result.Parametri.Operatore]);
        Parametri.AuthDom:=AuthDom;
      end;

      // accesso con il profilo
      if RErrMsg = '' then
      begin
        if RDatiLogin.Profilo = '' then
          RDatiLogin.Profilo:=IfThen(TB110FParametriServer.Default_Profilo = '','DIPENDENTE',TB110FParametriServer.Default_Profilo);
        //if not A001DtM.RegistraInibizioniInfo(RDatiLogin.Profilo) then
        //  RErrMsg:=Format('profilo inesistente [%s]',[RDatiLogin.Profilo]);
        A001DtM.RegistraInibizioniInfo(RDatiLogin.Profilo,False);
        RDatiLogin.Profilo:=Result.Parametri.ProfiloWEB;
      end;

      //Controllo allineamento versione db e versione applicativo
      {
      if (Result.Parametri.VersioneDB <> '') and (Result.Parametri.VersionePJ <> Result.Parametri.VersioneDB) then
        raise Exception.Create(Format('La versione del database (%s) non corrisponde alla versione del prodotto (%s).',[Result.Parametri.VersioneDB,Result.Parametri.VersionePJ]));
      }

      if RErrMsg <> '' then
        RErrMsg:=Format(ERROR_TEXT,[RErrMsg])
      else
        //aggiorna l'ultimo accesso al profilo
        A001DtM.UpdUltimoAccessoProfilo;
    except
      on E: Exception do
      begin
        RErrMsg:=Format('connessione al database [%s] fallita: %s',[TB110FParametriServer.Default_Database,E.Message]);
      end;
    end;
  finally
    FreeAndNil(A001DtM);
  end;

  // verifica risultato autenticazione
  if RErrMsg = '' then
  begin
    // autenticazione ok

    //Ricerca e inizializzazione di SessioneOracle
    A000ParamDBOracleMultiThread(Result);
    //Result.RegistraMsg.Session:=Result.SessioneOracle;
    //TRegistraMsg(Result.RegistraMsg).IniziaMessaggio('B110');
    //TRegistraMsg(Result.RegistraMsg).InserisciMessaggio('I','SessionPool.Count:' + SessionPool.Count.ToString,Result.Parametri.Azienda);

    // estrae informazioni sull'utente e le salva nei parametri
    OQ:=TOracleQuery.Create(nil);
    try
      OQ.Session:=Result.SessioneOracle;
      OQ.SQL.Text:=Format('select PROGRESSIVO, MATRICOLA, CODFISCALE '#13#10 +
                          'from   T030_ANAGRAFICO '#13#10 +
                          'where  MATRICOLA = (select MATRICOLA'#13#10 +
                          '                    from   MONDOEDP.I060_LOGIN_DIPENDENTE'#13#10 +
                          '                    where  AZIENDA = ''%s'''#13#10 +
                          '                    and    NOME_UTENTE = ''%s'')',
                          [Result.Parametri.Azienda,
                           TFunzioniGenerali.AggiungiApice(Result.Parametri.Operatore)]);
      OQ.Execute;
      if OQ.RowCount > 0 then
      begin
        Result.Parametri.ProgressivoOper:=OQ.FieldAsInteger(0);
        Result.Parametri.MatricolaOper:=OQ.FieldAsString(1);
        Result.Parametri.CodFiscaleOper:=OQ.FieldAsString(2);
        Result.Parametri.Inibizioni.Text:=StringReplace(Parametri.Inibizioni.Text,'<PROGRESSIVO_UTENTE>',Parametri.ProgressivoOper.ToString,[rfIgnoreCase]);
      end;
    finally
      OQ.Free;
    end;
  end
  else
  begin
    // in caso di errore pulisce il puntatore alla sessioneiriswin
    if Chiamante = 'B110' then
      LCurrentDSSession.RemoveObject(DS_OBJECT_SESSIONE_IRISWIN);

    { TODO 1 -cAnalisi tecnica : Verificare se la DSSession distrugge il result }
    //FreeAndNil(Result); // alternativa 1
    Result:=nil;          // alternativa 2
  end;
end;

{ TB110FParametriServer }

class constructor TB110FParametriServer.Create;
// legge la configurazione iniziale del server dal file B110.ini presente nella cartella di installazione
var
  IniFile: TIniFile;
  LPathInst,LPathFileConfig: String;
begin
  // determina il file ini di configurazione dell'applicativo
  LPathInst:=TPath.GetDirectoryName(GetModuleName(HInstance));
  LPathFileConfig:=TPath.Combine(LPathInst,FILE_CONFIGURAZIONE);

  // verifica che il file sia esistente
  if not TFile.Exists(LPathFileConfig) then
    raise Exception.CreateFmt('Il file di configurazione non è presente oppure non è accessibile:'#13#10'%s',[LPathFileConfig]);

  IniFile:=TIniFile.Create(LPathFileConfig);
  try
    try
      // impostazioni server
      FImpostazioni_Port:=IniFile.ReadInteger(INI_SEZIONE_IMPOSTAZIONI,INI_ID_PORT,INI_DEF_PORT);
      FImpostazioni_PoolSize:=IniFile.ReadInteger(INI_SEZIONE_IMPOSTAZIONI,INI_ID_POOL_SIZE,INI_DEF_POOL_SIZE);
      FImpostazioni_MaxConnections:=IniFile.ReadInteger(INI_SEZIONE_IMPOSTAZIONI,INI_ID_MAX_CONNECTIONS,INI_DEF_MAX_CONNECTIONS);
      FImpostazioni_SessionTimeout:=IniFile.ReadInteger(INI_SEZIONE_IMPOSTAZIONI,INI_ID_SESSION_TIMEOUT,INI_DEF_SESSION_TIMEOUT);
      FImpostazioni_CloseSessionImmediata:=IniFile.ReadString(INI_SEZIONE_IMPOSTAZIONI,INI_ID_CLOSESESSION_IMMEDIATA,INI_DEF_CLOSESESSION_IMMEDIATA) = 'S';
      FImpostazioni_TimeoutToken:=IniFile.ReadInteger(INI_SEZIONE_IMPOSTAZIONI,INI_ID_TIMEOUT_TOKEN,INI_DEF_TIMEOUT_TOKEN);
      FImpostazioni_FileLog:=IniFile.ReadString(INI_SEZIONE_IMPOSTAZIONI,INI_ID_FILE_LOG,INI_DEF_FILE_LOG) = 'S';
      FImpostazioni_LiveViewLog:=IniFile.ReadString(INI_SEZIONE_IMPOSTAZIONI,INI_ID_LIVEVIEW_LOG,INI_DEF_LIVEVIEW_LOG) = 'S';

      // valori default
      FDefault_Database:=IniFile.ReadString(INI_SEZIONE_DEFAULT,INI_ID_DATABASE,'');
      FDefault_Azienda:=IniFile.ReadString(INI_SEZIONE_DEFAULT,INI_ID_AZIENDA,'');
      FDefault_Profilo:=IniFile.ReadString(INI_SEZIONE_DEFAULT,INI_ID_PROFILO,'');
      FDefault_LoginEsterno:=IniFile.ReadString(INI_SEZIONE_DEFAULT,INI_ID_LOGIN_ESTERNO,'N');
    except
      on E: Exception do
      begin
        raise Exception.CreateFmt('Errore durante la lettura del file di configurazione'#13#10'%s'#13#10'%s',[LPathFileConfig,E.Message]);
      end;
    end;
  finally
    FreeAndNil(IniFile);
  end;
end;

class destructor TB110FParametriServer.Destroy;
begin
  //
end;

class function TB110FParametriServer.ToString: String;
const
  PREF_MODIF   = '*';
  PREF_DEFAULT = ' ';
begin
  Result:=
    // sezione impostazioni
    Format('[%s]'#13#10,[INI_SEZIONE_IMPOSTAZIONI]) +
    Format('%s %s = %d'#13#10,
           [IfThen(INI_DEF_PORT = FImpostazioni_Port,PREF_DEFAULT,PREF_MODIF),
            INI_ID_PORT,
            FImpostazioni_Port]) +
    Format('%s %s = %d'#13#10,
           [IfThen(INI_DEF_POOL_SIZE = FImpostazioni_PoolSize,PREF_DEFAULT,PREF_MODIF),
            INI_ID_POOL_SIZE,
            FImpostazioni_PoolSize]) +
    Format('%s %s = %d'#13#10,
           [IfThen(INI_DEF_MAX_CONNECTIONS = FImpostazioni_MaxConnections,PREF_DEFAULT,PREF_MODIF),
            INI_ID_MAX_CONNECTIONS,
            FImpostazioni_MaxConnections]) +
    Format('%s %s = %d'#13#10,
           [IfThen(INI_DEF_SESSION_TIMEOUT = FImpostazioni_SessionTimeout,PREF_DEFAULT,PREF_MODIF),
            INI_ID_SESSION_TIMEOUT,
            FImpostazioni_SessionTimeout]) +
    Format('%s %s = %s'#13#10,
           [IfThen(INI_DEF_CLOSESESSION_IMMEDIATA = IfThen(FImpostazioni_CloseSessionImmediata,'S','N'),PREF_DEFAULT,PREF_MODIF),
            INI_ID_CLOSESESSION_IMMEDIATA,
            IfThen(FImpostazioni_CloseSessionImmediata,'S','N')]) +
    Format('%s %s = %d'#13#10,
           [IfThen(INI_DEF_TIMEOUT_TOKEN = FImpostazioni_TimeoutToken,PREF_DEFAULT,PREF_MODIF),
            INI_ID_TIMEOUT_TOKEN,
            FImpostazioni_TimeoutToken]) +
    Format('%s %s = %s'#13#10,
           [IfThen(INI_DEF_FILE_LOG = IfThen(FImpostazioni_FileLog,'S','N'),PREF_DEFAULT,PREF_MODIF),
            INI_ID_FILE_LOG,
            IfThen(FImpostazioni_FileLog,'S','N')]) +
    Format('%s %s = %s'#13#10,
           [IfThen(INI_DEF_LIVEVIEW_LOG = IfThen(FImpostazioni_LiveViewLog,'S','N'),PREF_DEFAULT,PREF_MODIF),
            INI_ID_LIVEVIEW_LOG,
            IfThen(FImpostazioni_LiveViewLog,'S','N')]) +
    // sezione default
    Format('[%s]'#13#10,[INI_SEZIONE_DEFAULT]) +
    Format('%s = %s'#13#10,[INI_ID_AZIENDA,FDefault_Azienda]) +
    Format('%s = %s'#13#10,[INI_ID_DATABASE,FDefault_Database]) +
    Format('%s = %s'#13#10,[INI_ID_PROFILO,FDefault_Profilo]);
end;

initialization
  GCSAutenticazioneDominio:=TMedpCriticalSection.Create;

finalization
  FreeAndNil(GCSAutenticazioneDominio);

end.
