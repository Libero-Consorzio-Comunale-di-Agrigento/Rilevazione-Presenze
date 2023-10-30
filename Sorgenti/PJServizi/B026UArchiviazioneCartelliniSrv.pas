unit B026UArchiviazioneCartelliniSrv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Oracle, IdMessage, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, C180FunzioniGenerali, A000UInterfaccia, A001UPassWordDtM1,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, A000USessione, A159UArchiviazioneCartellini, System.Variants,
  IdMessageClient, IdSMTPBase, IdSMTP, Data.DB, OracleData, A000Versione, StrUtils, C700USelezioneAnagrafe,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, A000UCostanti;

type
  TParametriSMTP = class(TObject)
  public
    SMTPHost: String;
    HeloName: String;
    Username: String;
    Password: String;
    Port: String;
    AuthType: String;
    UseTLS: String;
    Sender: String;
    SenderIndirizzo: String;
    constructor Create; overload;
  end;

  TB026FArchiviazioneCartelliniSrv = class(TService)
    SessioneMondoEDP: TOracleSession;
    selT941: TOracleDataSet;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    QI091: TOracleDataSet;

    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
  private
    FParametriSMTP: TParametriSMTP;
    ContaArchiviati: Integer;
    Azienda, FileLog, ParCartellino, SelezioneAnagrafica, ListaAnomalie: String;
    AggiornamentoSchede, FileMensile, TipoCartellino: Boolean;
    MesiIndietro, UltimoMese: Integer;
    MailToAddress, MailOggetto, MailTestoInizio, MailTestoFine: String;
    { Private declarations }
    procedure GetParametriDB;
    procedure LogParametri;
    procedure ArchiviazioneCartellini;
    function InviaMail(MailDest, Oggetto: String; Testo: TStringList): TResCtrl;
    function ImpostaParametriSMTP_SSL(PAzienda: String): TResCtrl;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  B026FArchiviazioneCartelliniSrv: TB026FArchiviazioneCartelliniSrv;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  B026FArchiviazioneCartelliniSrv.Controller(CtrlCode);
end;

function TB026FArchiviazioneCartelliniSrv.GetServiceController: TServiceController;
begin
  Result:=ServiceController;
end;

procedure TB026FArchiviazioneCartelliniSrv.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Started:=True;
end;

procedure TB026FArchiviazioneCartelliniSrv.ServiceCreate(Sender: TObject);
begin
  FParametriSMTP:=nil;
end;

procedure TB026FArchiviazioneCartelliniSrv.ServiceDestroy(Sender: TObject);
begin
  FreeAndNil(FParametriSMTP);
end;

procedure TB026FArchiviazioneCartelliniSrv.ServiceExecute(Sender: TService);
{Lanciarlo col comando NET START B026FARCHIVIAZIONECARTELLINISRV}
begin
  FileLog:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B026','FileLog','B026Srv.log');
  R180AppendFile(FileLog,'**********');
  R180AppendFile(FileLog,FormatDateTime('dd/mm/yyyy - hh.nn',Now) + ' Inizio');
  SessioneOracle.LogonDatabase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B026','Database','IRIS');

  try
    R180AppendFile(FileLog,'SessioneMondoEDP.LogonDatabase');
    SessioneMondoEDP.LogonDatabase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B026','Database','IRIS');
    R180AppendFile(FileLog,'A000LogonDBOracle');
    A000LogonDBOracle(SessioneMondoEDP);
    R180AppendFile(FileLog,'selT941.Open');
    selT941.Open;
  except
    on E:Exception do
      R180AppendFile(FileLog,'selT941.Open: ' + E.Message);
  end;

  while not selT941.Eof do
  begin
    R180AppendFile(FileLog,'GetParametriDB: ' + selT941.FieldByName('DESCRIZIONE').AsString);
    GetParametriDB;
    R180AppendFile(FileLog,'ArchiviazioneCartellini');
    ArchiviazioneCartellini;
    selT941.Next;
  end;
end;

procedure TB026FArchiviazioneCartelliniSrv.GetParametriDB;
begin
  try
    SessioneOracle.LogonUsername:=selT941.FieldByName('I090UTENTE').AsString;
    SessioneOracle.LogonPassword:=R180Decripta(selT941.FieldByName('I090PAROLACHIAVE').AsString, 21041974);

    Azienda:=selT941.FieldByName('Azienda').AsString;
    MesiIndietro:=selT941.FieldByName('MesiIndietro').AsInteger;
    UltimoMese:=selT941.FieldByName('UltimoMese').AsInteger;
    AggiornamentoSchede:=selT941.FieldByName('AggiornamentoSchede').AsString = 'S';
    ParCartellino:=selT941.FieldByName('ParCartellino').AsString;
    TipoCartellino:=selT941.FieldByName('TipoCartellino').AsString = 'S';
    SelezioneAnagrafica:=selT941.FieldByName('SelezioneAnagrafica').AsString;
    FileMensile:=selT941.FieldByName('FileMensile').AsString = 'S';
    ListaAnomalie:=selT941.FieldByName('ListaAnomalie').AsString;
    MailToAddress:=selT941.FieldByName('MailToAddress').AsString;
    MailOggetto:=selT941.FieldByName('MailOggetto').AsString;
    MailTestoInizio:=selT941.FieldByName('MailTestoInizio').AsString;
    MailTestoFine:=selT941.FieldByName('MailTestoFine').AsString;
  except
    on E:Exception do
      R180AppendFile(FileLog,'GetParametriDB: ' + E.Message);
  end;
  LogParametri;
end;

procedure TB026FArchiviazioneCartelliniSrv.LogParametri;
begin
  //Scrittura parametri su log
  R180AppendFile(FileLog,'  Azienda=' + Azienda);
  R180AppendFile(FileLog,'  MesiIndietro=' + IntToStr(MesiIndietro));
  R180AppendFile(FileLog,'  UltimoMese=' + IntToStr(UltimoMese));
  R180AppendFile(FileLog,'  AggiornamentoSchede=' + IfThen(AggiornamentoSchede,'S','N'));
  R180AppendFile(FileLog,'  FileMensile=' + IfThen(FileMensile,'S','N'));
  R180AppendFile(FileLog,'  ParCartellino=' + ParCartellino);
  R180AppendFile(FileLog,'  TipoCartellino=' + IfThen(TipoCartellino,'S','N'));
  R180AppendFile(FileLog,'  ListaAnomalie=' + ListaAnomalie);
  R180AppendFile(FileLog,'  SelezioneAnagrafica=' + SelezioneAnagrafica);
  R180AppendFile(FileLog,'  Database=' + SessioneOracle.LogonDatabase);
  R180AppendFile(FileLog,'  Username=' + SessioneOracle.LogonUsername);
end;

procedure TB026FArchiviazioneCartelliniSrv.ArchiviazioneCartellini;
var ModuloAbilitato:Boolean;
    A001FPasswordDtM: TA001FPasswordDtM1;
    LResCtrl: TResCtrl;
    TestoMail: TStringList;
begin
  if (MailTestoInizio <> '') or (MailTestoFine <> '') then
  begin
    LResCtrl:=ImpostaParametriSMTP_SSL(Azienda);
    if not LResCtrl.Ok then
    begin
      R180AppendFile(FileLog, LResCtrl.Messaggio);
      Exit;
    end;
  end;

  if MailTestoInizio <> '' then
  begin
    TestoMail:=TStringList.Create;
    try
      TestoMail.Add(FormatDateTime('dd/mm/yyyy hh.nn',Now));
      TestoMail.Add(MailTestoInizio);
      LResCtrl:=InviaMail(MailToAddress, MailOggetto, TestoMail);
      if not LResCtrl.Ok then
        R180AppendFile(FileLog, LResCtrl.Messaggio);
    finally
      FreeAndNil(TestoMail);
    end;
  end;

  ModuloAbilitato:=True;
  try
    SessioneOracle.LogOff;
    SessioneOracle.Logon;
    with TOracleDataSet.Create(nil) do
    try
      Session:=SessioneOracle;
      SQL.Add('SELECT VERSIONEDB,AZIENDA FROM MONDOEDP.I090_ENTI WHERE UPPER(UTENTE) = ''' + UpperCase(SessioneOracle.LogonUsername) + '''');
      Open;
      if (not FieldByName('VERSIONEDB').IsNull) and (FieldByName('VERSIONEDB').AsString <> VersionePA) then
      begin
        R180AppendFile(FileLog,Format('La versione del database (%s) non corrisponde alla versione del prodotto(%s). Elaborazione interrotta!',[FieldByName('VERSIONEDB').AsString,VersionePA]));
        ModuloAbilitato:=False;
      end
      else
        R180AppendFile(FileLog,'La versione del database corrisponde alla versione del prodotto.');
    finally
      Free;
    end;

    A001FPasswordDtM:=TA001FPasswordDtM1.Create(A000SessioneIrisWIN);
    try
      with A001FPasswordDtM do
      begin
        R180AppendFile(FileLog,'Inizializzazione.');
        InizializzazioneSessione(SessioneOracle.LogonDatabase);
        R180AppendFile(FileLog,'Inizializzazione fine.');
        // azienda indicata: ricerca su database per estrarre informazioni
        QI090.Close;
        QI090.SetVariable('Azienda',Azienda);
        QI090.Open;
        QI070.Close;
        QI070.SetVariable('Azienda',Azienda);
        QI070.SetVariable('Utente','SYSMAN');
        QI070.Open;
        R180AppendFile(FileLog,'RegistraInibizioni.');
        //Forzo l'applicazione per leggere correttamente i moduli abilitati
        Parametri.Applicazione:='RILPRE';
        RegistraInibizioni;
        R180AppendFile(FileLog,'RegistraInibizioni fine');
        if Parametri.VersioneOracle = 0 then
          Parametri.VersioneOracle:=11;
      end;
    finally
      FreeAndNil(A001FPasswordDtM);
    end;

  except
    on E:Exception do
    begin
      R180AppendFile(FileLog,E.Message);
      Exit;
    end;
  end;
  //Lo controllo qui perchè prima va in errore, non so perchè
  if not ModuloAbilitato then
  begin
    R180AppendFile(FileLog,'Modulo non abilitato');
    Exit;
  end;

  try
    R180AppendFile(FileLog,'Inizio Archiviazione');
    A159FArchiviazioneCartellini:=TA159FArchiviazioneCartellini.Create(nil);
    with A159FArchiviazioneCartellini do
    begin
      A159MW.isService:=True;

      R180AppendFile(FileLog,'A159.Show');
      FormShow(A159FArchiviazioneCartellini);

      R180AppendFile(FileLog,'A159: set parameter');
      chkAggSchedaRiep.Checked:=AggiornamentoSchede;
      DataI:=R180InizioMese(R180AddMesi(Date,-MesiIndietro));
      DataF:=R180FineMese(R180AddMesi(Date,-UltimoMese));
      dcmbParametrizzazione.KeyValue:=ParCartellino;
      chkParametrizzazioniTipoCartellino.Checked:=TipoCartellino;
      if FileMensile then
        rgpGenerazionePDF.ItemIndex:=1
      else
        rgpGenerazionePDF.ItemIndex:=0;
      R180PutCheckList(ListaAnomalie, 5, lstAnomalie);

      C600frmSelAnagrafe.C600FSelezioneAnagrafe.DataLavoro:=Date;
      C600frmSelAnagrafe.C600FSelezioneAnagrafe.cmbSelezione.Text:=SelezioneAnagrafica;
      C600frmSelAnagrafe.C600FSelezioneAnagrafe.actApriSelezioneExecute(C600frmSelAnagrafe.C600FSelezioneAnagrafe.actConferma);
      C600frmSelAnagrafe.C600FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;

      //avvio elaborazione con click su pulsante
      actAvvioExecute(btnStart);
      //R180AppendFile(FileLog,FormatDateTime('dd/mm/yyyy - hh.nn',Now) + ' Archiviati ' + IntToStr(A159FArchiviazioneCartellini.ContaElaborati) + ' cartellini');
      R180AppendFile(FileLog,'Fine Archiviazione');
      ContaArchiviati:=A159MW.ContaSalvataggi;
    end;
  except
    on E:Exception do
      R180AppendFile(FileLog,E.Message);
  end;

  if A159FArchiviazioneCartellini = nil then
    R180AppendFile(FileLog,'A159 = nil')
  else
  begin
    //R180AppendFile(FileLog,'A159: FreeAndNil');
    try
      FreeAndNil(A159FArchiviazioneCartellini);
    except
      on E:Exception do
        R180AppendFile(FileLog,E.Message);
    end;
  end;
  R180AppendFile(FileLog,FormatDateTime('dd/mm/yyyy - hh.nn',Now) + ' Fine - ' + ContaArchiviati.toString + ' documenti archiviati');

  if MailTestoFine <> '' then
  begin
    TestoMail:=TStringList.Create;
    try
      TestoMail.Add(FormatDateTime('dd/mm/yyyy hh.nn',Now));
      TestoMail.Add(ContaArchiviati.toString + ' documenti archiviati - ' + MailTestoFine);
      LResCtrl:=InviaMail(MailToAddress, MailOggetto, TestoMail);
      if not LResCtrl.Ok then
        R180AppendFile(FileLog, LResCtrl.Messaggio);
    finally
      FreeAndNil(TestoMail);
    end;
  end;
end;

function TB026FArchiviazioneCartelliniSrv.ImpostaParametriSMTP_SSL(PAzienda: String): TResCtrl;
begin
  Result.Clear;

  FreeAndNil(FParametriSMTP);
  FParametriSMTP:=TParametriSMTP.Create;

  // legge i parametri relativi al server smtp
  try
    with QI091 do
    begin
      Close;
      SetVariable('AZIENDA', PAzienda);
      Open;

      FParametriSMTP.SMTPHost:=VarToStr(Lookup('Tipo','C90_EMAIL_SMTPHOST','Dato'));
      FParametriSMTP.HeloName:=VarToStr(LookUp('Tipo','C90_EMAIL_HELONAME','Dato'));
      FParametriSMTP.Username:=VarToStr(LookUp('Tipo','C90_EMAIL_USERNAME','Dato'));
      FParametriSMTP.Password:=R180Decripta(VarToStr(Lookup('Tipo','C90_EMAIL_PASSWORD','Dato')),30011945);
      FParametriSMTP.AuthType:=VarToStr(Lookup('Tipo','C90_EMAIL_AUTHTYPE','Dato'));
      FParametriSMTP.UseTLS:=VarToStr(Lookup('Tipo','C90_EMAIL_USETLS','Dato'));
      FParametriSMTP.SenderIndirizzo:=VarToStr(Lookup('Tipo','C90_EMAIL_SENDER_INDIRIZZO','Dato'));
      FParametriSMTP.Sender:=VarToStr(Lookup('Tipo','C90_EMAIL_SENDER','Dato'));

      Close;
    end;
  except
    on e: Exception do
    begin
      Result.Messaggio:='Errore durante l''acquisizione dei parametri SMTP: ' + E.Message;
      Exit;
    end;
  end;

  // avvisa se non è indicato il server di posta
  if FParametriSMTP.SMTPHost = '' then
  begin
    Result.Messaggio:='Non è stato indicato nessun server di posta per l''invio mail, contattare l''amministratore dell''applicativo.';
    Exit;
  end;

  // parametri ok
  IdSMTP.Host:=FParametriSMTP.SMTPHost;
  if FParametriSMTP.Port.Trim = '' then
    IdSMTP.Port:=25
  else
    IdSMTP.Port:=FParametriSMTP.Port.ToInteger;

  IdSMTP.AuthType:=satDefault;
  {Assegnazione e valorizzazione oggetto necessario per l'autenticazione TLS\SSL}
  if (FParametriSMTP.AuthType.Trim <> '') and
     (FParametriSMTP.AuthType.Trim.ToUpper <> 'NO AUTENTICAZIONE') then
  begin
    IdSMTP.IOHandler:=IdSSLIOHandlerSocketOpenSSL;

    IdSMTP.UseTLS:=utUseImplicitTLS;
    if FParametriSMTP.UseTLS.ToUpper = 'NO' then
      IdSMTP.UseTLS:=utNoTLSSupport
    else if FParametriSMTP.UseTLS.ToUpper = 'IMPLICIT' then
      IdSMTP.UseTLS:=utUseImplicitTLS
    else if FParametriSMTP.UseTLS.ToUpper = 'EXPLICIT' then
      IdSMTP.UseTLS:=utUseExplicitTLS
    else if FParametriSMTP.UseTLS.ToUpper = 'REQUIRE' then
      IdSMTP.UseTLS:=utUseRequireTLS
  end;

  with IdSSLIOHandlerSocketOpenSSL do
    begin
    IdSMTP.UseEhlo:=not FParametriSMTP.HeloName.Trim.IsEmpty;

    SSLOptions.Method:=sslvTLSv1;
    SSLOptions.SSLVersions:=[sslvTLSv1];
    if FParametriSMTP.AuthType.ToUpper = 'TLSV1_1' then
    begin
      SSLOptions.Method:=sslvTLSv1_1;
      SSLOptions.SSLVersions:=[sslvTLSv1_1];
    end
    else if FParametriSMTP.AuthType.ToUpper = 'TLSV1_2' then
    begin
      SSLOptions.Method:=sslvTLSv1_2;
      SSLOptions.SSLVersions:=[sslvTLSv1_2];
    end
    else if FParametriSMTP.AuthType.ToUpper = 'SSLV2' then
    begin
      SSLOptions.Method:=sslvSSLv2;
      SSLOptions.SSLVersions:=[sslvSSLv2];
    end
    else if FParametriSMTP.AuthType.ToUpper = 'SSLV23' then
    begin
      SSLOptions.Method:=sslvSSLv23;
      SSLOptions.SSLVersions:=[sslvSSLv23];
    end
    else if FParametriSMTP.AuthType.ToUpper = 'SSLV3' then
    begin
      SSLOptions.Method:=sslvSSLv3;
      SSLOptions.SSLVersions:=[sslvSSLv3];
    end;

    SSLOptions.RootCertFile:='';
    SSLOptions.Mode:=sslmUnassigned;
    SSLOptions.VerifyMode:=[];
    SSLOptions.VerifyDepth:=0;
    ConnectTimeout:=0;
  end;

  Result.Ok:=True;
end;

function TB026FArchiviazioneCartelliniSrv.InviaMail(MailDest, Oggetto: String; Testo: TStringList): TResCtrl;
begin
  if Assigned(FParametriSMTP) then
  begin
    try
      try
        // connessione smtp
        with IdSMTP do
        begin
          HeloName:=Trim(FParametriSMTP.HeloName);
          Connect;
          Username:=Trim(FParametriSMTP.Username);
          Password:=Trim(FParametriSMTP.Password);
        end;

        // imposta i dati della mail
        with IdMessage do
        begin
          From.Address:=FParametriSMTP.SenderIndirizzo;
          From.Name:=FParametriSMTP.Sender;
          BccList.Clear;
          Recipients.Clear;
          Recipients.EmailAddresses:=MailDest;
          Subject:=Oggetto;

          // imposta il testo della mail
          MessageParts.Clear;
          Body.Clear;
          // nota: è stato copiato il content type da C017, compresa la specifica del character set iso-8859-15
          ContentType:='text/plain; charset=ISO-8859-15';
          Body:=Testo;
        end;
        IdSMTP.Send(IdMessage);

        // invio della mail completato
        Result.Ok:=True;
      except
        on E:Exception do
        begin
          Result.Ok:=False;
          Result.Messaggio:='Invio email fallito su host ' + IdSMTP.Host + ': ' + E.Message;
        end;
      end;
    finally
      IdSMTP.Disconnect;
    end;
  end
  else
    Result.Messaggio:='Impossibile inviare email: parametri email/SMTP non presenti';
end;

{ TParametriSMTP }

constructor TParametriSMTP.Create;
begin
  inherited Create;

  SMTPHost:='';
  HeloName:='';
  Username:='';
  Password:='';
  Port:='';
  AuthType:='';
  UseTLS:='';
  Sender:='';
  SenderIndirizzo:='';
end;


end.
