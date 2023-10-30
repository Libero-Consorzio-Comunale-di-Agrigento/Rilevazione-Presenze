unit B027UCartellinoSrv;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ExtCtrls, C180FunzioniGenerali, OracleData, Variants,
  Printers, A000Versione, A000UInterfaccia, A027UCarMen, A027UStampaTimb, A027UStampaTesto,
  C700USelezioneAnagrafe, A000USessione, A001UPasswordDtM1, L021Call,
  IdMessage, IdAntiFreezeBase, IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, IdExplicitTLSClientServerBase, IdSMTPBase, Data.DB, Oracle;

type
  TB027FCartellinoSrv = class(TService)
    IdSMTP: TIdSMTP;
    IdAntiFreeze1: TIdAntiFreeze;
    IdMessage: TIdMessage;
    selT940: TOracleDataSet;
    SessioneMondoEDP: TOracleSession;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceExecute(Sender: TService);
  private
    FileIn,FileOut,FileSemaforo,FileLog:String;
    RotturaChiave,ParCartellino,SelezioneAnagrafica:String;
    SaltoPagina,InizioPagina,StrappoPagina:String;
    NumRighe,MesiIndietro,UltimoMese,CarattereFOB:Integer;
    SoloAggiornamento,AggiornamentoSchede,AutoGiustificazione,IgnoraAnomalie,EseguiFreeAndNil:Boolean;
    ParametriDB:Boolean;
    MailServer,MailUser,MailPassword,MailFromAddress,MailToAddress,MailOggetto,MailTestoInizio,MailTestoFine:String;
    procedure ElaborazioneCartellini;
    procedure GetParametriDB;
    procedure GetParametriRegistro;
    procedure InviaMail(Stato:String);
    procedure LogParametri;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  B027FCartellinoSrv: TB027FCartellinoSrv;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  B027FCartellinoSrv.Controller(CtrlCode);
end;

procedure TB027FCartellinoSrv.ElaborazioneCartellini;
var ADevice,ADriver,APort:array [0..255] of Char;
    DevMode:PDeviceMode;
    DeviceHandle: THandle;
    ModuloAbilitato:Boolean;
    A001FPasswordDtM:TA001FPasswordDtM1;
    Azienda:String;
begin
  if MailServer <> '' then
    InviaMail('I');
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
      begin
        R180AppendFile(FileLog,'La versione del database corrisponde alla versione del prodotto.');
        Azienda:=FieldByName('AZIENDA').AsString;
      end;
    finally
      Free;
    end;

    A001FPasswordDtM:=TA001FPasswordDtM1.Create(A000SessioneIrisWIN);
    with A001FPasswordDtM do
    begin
      InizializzazioneSessione(SessioneOracle.LogonDatabase);
      // azienda indicata: ricerca su database per estrarre informazioni
      QI090.Close;
      QI090.SetVariable('Azienda',Azienda);
      QI090.Open;
      QI070.Close;
      QI070.SetVariable('Azienda',Azienda);
      QI070.SetVariable('Utente','SYSMAN');
      QI070.Open;
      RegistraInibizioni;
      if Parametri.VersioneOracle = 0 then
        Parametri.VersioneOracle:=11;
    end;
    FreeAndNil(A001FPasswordDtM);
    IndennitaTurno:=True;

    if not SoloAggiornamento then
    begin
      //Leggo le impostazioni per assegnarle al QuickReport
      Printer.GetPrinter(ADevice,ADriver,APort,DeviceHandle);
      if DeviceHandle = 0 then
      begin
        Printer.PrinterIndex:=Printer.PrinterIndex;
        Printer.GetPrinter(ADevice,ADriver,APort,DeviceHandle);
      end;
      if DeviceHandle <> 0 then
        DevMode:=GlobalLock(DeviceHandle);
      GlobalUnlock(DeviceHandle);
    end;
  except
    on E:Exception do
    begin
      R180AppendFile(FileLog,E.Message);
      exit;
    end;
  end;
  //Lo controllo qui perchè prima va in errore, non so perchè
  if not ModuloAbilitato then
    exit;

  try
    R180AppendFile(FileLog,'A027.Create');
    A027FCarMen:=TA027FCarmen.Create(nil);
    R180AppendFile(FileLog,'A027.Show');
    A027FCarMen.FormShow(A027FCarMen);
    R180AppendFile(FileLog,'A027: set parameter');
    A027FCarMen.frmInputPeriodo.DataInizio:=R180InizioMese(R180AddMesi(Date,-MesiIndietro));
    A027FCarMen.frmInputPeriodo.DataFine:=R180FineMese(R180AddMesi(Date,-UltimoMese));
    A027FCarMen.chkAutoGiustificazione.Checked:=AutoGiustificazione;
    A027FCarMen.chkIgnoraAnomalie.Checked:=IgnoraAnomalie;
    A027FCarMen.chkIgnoraAnomalieStampa.Checked:=IgnoraAnomalie;
    A027FCarMen.chkParametrizzazioniTipoCartellino.Checked:=False;
    A027FCarMen.CAggiornamento.Checked:=AggiornamentoSchede;
    A027FCarMen.NomeStampa.KeyValue:=ParCartellino;
    A027FCarMen.NomefileTesto:=FileIn;
    //A027FCarMen.frmSelAnagrafe.SelezionaProgressivo(4);
    R180AppendFile(FileLog,'C700.actApriSelezioneExecute');
    C700FSelezioneAnagrafe.cmbSelezione.Text:=SelezioneAnagrafica;
    C700FSelezioneAnagrafe.actApriSelezioneExecute(C700FSelezioneAnagrafe.actConferma);
    C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
    //QuickReport
    A027FCarMen.A027StampaTimb.bndGruppoFileSeq.Enabled:=RotturaChiave <> '';
    A027FCarMen.A027StampaTimb.bndGruppoFileSeq.Expression:=RotturaChiave;
    A027FCarMen.A027StampaTimb.lblStrappoPagina.Caption:=StrappoPagina;
    //Parametri per File Testo
    A027FCarMen.sParametri.sFileTesto:=FileIn;
    A027FCarMen.sParametri.sCarCon:='';
    A027FCarMen.sParametri.sNumRighe:=IntToStr(NumRighe);
    A027FCarMen.sParametri.sNumRigheHeader:=IntToStr(0);
    A027FCarMen.sParametri.sNumRigheFooter:=IntToStr(0);
    A027FCarMen.sParametri.sSaltoPagina:=SaltoPagina;
    if SoloAggiornamento then
    begin
      R180AppendFile(FileLog,'A027FCarMen.BitBtn4Click');
      A027FCarMen.BitBtn4Click(A027FCarMen.BitBtn4);
    end
    else
    begin
      R180AppendFile(FileLog,'A027FCarMen.BitBtn1Click');
      A027FCarMen.BitBtn1Click(A027FCarMen.BitBtn5);
    end;
    R180AppendFile(FileLog,FormatDateTime('dd/mm/yyyy - hh.nn',Now) + ' Elaborati ' + IntToStr(A027FCarMen.A027StampaTimb.(*QRep.*)DataSet.RecordCount) + ' cartellini');
    if (not SoloAggiornamento) and (FileIn <> '') then
    begin
      A027FStampaTesto:=TA027FStampaTesto.Create(nil);
      try
        A027FStampaTesto.FormShow(nil);
        A027FStampaTesto.StampaSuFile:=True;
        A027FStampaTesto.InizioPagina:=InizioPagina;
        A027FStampaTesto.FileOut:=FileOut;
        A027FStampaTesto.FileSemaforo:=FileSemaforo;
        A027FStampaTesto.CarattereFOB:=CarattereFOB;
        A027FStampaTesto.BtnStampaClick(nil);
      finally
        FreeAndNil(A027FStampaTesto);
      end;
    end;
  except
    on E:Exception do
      R180AppendFile(FileLog,E.Message);
  end;

  //A COMO_HSANNA il FreeAndNil finale dà problemi: il processo rimane appeso
  if EseguiFreeAndNil then
  begin
    R180AppendFile(FileLog,'A027: FreeAndNil');
    try
      FreeAndNil(A027FCarMen);
    except
      on E:Exception do
        R180AppendFile(FileLog,E.Message);
    end;
  end;

  if MailServer <> '' then
  begin
    R180AppendFile(FileLog,FormatDateTime('dd/mm/yyyy - hh.nn',Now) + ' Invio mail di fine elaborazione');
    InviaMail('F');
  end;

  (*
  if (not EseguiFreeAndNil) and (not ParametriDB) then
  begin
    R180AppendFile(FileLog,'A000SessioneIrisWIN: FreeAndNil');
    FreeAndNil(A000SessioneIrisWIN);
  end;
  *)
  R180AppendFile(FileLog,FormatDateTime('dd/mm/yyyy - hh.nn',Now) + ' Fine');
end;

procedure TB027FCartellinoSrv.GetParametriDB;
begin
  try
    FileIn:=selT940.FieldByName('FILEIN').AsString;
    FileOut:=selT940.FieldByName('FileOut').AsString;
    FileSemaforo:=selT940.FieldByName('FileSemaforo').AsString;
    RotturaChiave:=selT940.FieldByName('RotturaChiave').AsString;
    SaltoPagina:=selT940.FieldByName('SaltoPagina').AsString;
    StrappoPagina:=selT940.FieldByName('StrappoPagina').AsString;
    InizioPagina:=selT940.FieldByName('InizioPagina').AsString;
    NumRighe:=selT940.FieldByName('NumRighe').AsInteger;
    MesiIndietro:=selT940.FieldByName('MesiIndietro').AsInteger;
    UltimoMese:=selT940.FieldByName('UltimoMese').AsInteger;//,IntToStr(MesiIndietro)),1);
    AggiornamentoSchede:=selT940.FieldByName('AggiornamentoSchede').AsString = 'S';
    SoloAggiornamento:=selT940.FieldByName('SoloAggiornamento').AsString = 'S';
    AutoGiustificazione:=selT940.FieldByName('AutoGiustificazione').AsString = 'S';
    IgnoraAnomalie:=selT940.FieldByName('IgnoraAnomalie').AsString = 'S';
    ParCartellino:=selT940.FieldByName('ParCartellino').AsString;
    SelezioneAnagrafica:=selT940.FieldByName('SelezioneAnagrafica').AsString;
    CarattereFOB:=selT940.FieldByName('CarattereFOB').AsInteger;
    MailServer:=selT940.FieldByName('MailServer').AsString;
    MailUser:=selT940.FieldByName('MailUser').AsString;
    MailPassword:=selT940.FieldByName('MailPassword').AsString;
    MailFromAddress:=selT940.FieldByName('MailFromAddress').AsString;
    MailToAddress:=selT940.FieldByName('MailToAddress').AsString;
    MailOggetto:=selT940.FieldByName('MailOggetto').AsString;
    MailTestoInizio:=selT940.FieldByName('MailTestoInizio').AsString;
    MailTestoFine:=selT940.FieldByName('MailTestoFine').AsString;
    EseguiFreeAndNil:=selT940.FieldByName('ChiusuraStandard').AsString <> 'N';
    SessioneOracle.LogonUsername:=selT940.FieldByName('I090UTENTE').AsString;
    SessioneOracle.LogonPassword:=R180Decripta(selT940.FieldByName('I090PAROLACHIAVE').AsString,21041974);
  except
    on E:Exception do
      R180AppendFile(FileLog,'GetParametriDB: ' + E.Message);
  end;
  LogParametri;
end;

procedure TB027FCartellinoSrv.GetParametriRegistro;
begin
  try
    FileIn:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','FileIn','Cartellino_In.txt');
    FileOut:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','FileOut','Cartellino_Out.txt');
    FileSemaforo:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','FileSemaforo','Cartellino_Out.ok');
    RotturaChiave:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','RotturaChiave','T430CONTRATTO');
    SaltoPagina:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','SaltoPagina','Stampa del');
    StrappoPagina:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','StrappoPagina','OGGETTO');
    InizioPagina:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','InizioPagina','1');
    NumRighe:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','NumRighe','66'),66);
    MesiIndietro:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','MesiIndietro','12'),12);
    UltimoMese:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','UltimoMese',IntToStr(MesiIndietro)),1);
    AggiornamentoSchede:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','AggiornamentoSchede','N') = 'S';
    SoloAggiornamento:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','SoloAggiornamento','S') = 'S';
    AutoGiustificazione:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','AutoGiustificazione','N') = 'S';
    IgnoraAnomalie:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','IgnoraAnomalie','S') = 'S';
    ParCartellino:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','ParCartellino','');
    SelezioneAnagrafica:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','SelezioneAnagrafica','B027');
    CarattereFOB:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','CarattereFOB','2'),2);
    MailServer:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Mail_Server','');
    MailUser:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Mail_User','');
    MailPassword:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Mail_Password','');
    MailFromAddress:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Mail_FromAddress','');
    MailToAddress:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Mail_ToAddress','');
    MailOggetto:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Mail_Oggetto','Elaborazione Cartellini B027');
    MailTestoInizio:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Mail_Testo_Inizio','Elaborazione Iniziata');
    MailTestoFine:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Mail_Testo_Fine','Elaborazione Terminata');
    EseguiFreeAndNil:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','ChiusuraStandard','S') = 'S';
    SessioneOracle.LogonUsername:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Username','MONDOEDP');
    SessioneOracle.LogonPassword:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Password','TIMOTEO');
  except
    on E:Exception do
      R180AppendFile(FileLog,'GetParametriRegistro: ' + E.Message);
  end;
  LogParametri;
end;

function TB027FCartellinoSrv.GetServiceController: TServiceController;
begin
  Result:=ServiceController;
end;

procedure TB027FCartellinoSrv.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  Started:=True;
end;

procedure TB027FCartellinoSrv.ServiceExecute(Sender: TService);
{Lanciarlo col comando NET START B027FCARTELLINOSRV}
var
  strTest: String;
begin
  FileLog:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','FileLog','B027Srv.log');
  R180AppendFile(FileLog,'**********');
  R180AppendFile(FileLog,FormatDateTime('dd/mm/yyyy - hh.nn',Now) + ' Inizio');

  //Parametri di stampa
  SessioneOracle.LogonDatabase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Database','IRIS');

  try
    R180AppendFile(FileLog,'SessioneMondoEDP.LogonDatabase');
    SessioneMondoEDP.LogonDatabase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B027','Database','IRIS');
    R180AppendFile(FileLog,'A000LogonDBOracle');
    A000LogonDBOracle(SessioneMondoEDP);
    R180AppendFile(FileLog,'selT940.Open');
    selT940.Open;
  except
    on E:Exception do
      R180AppendFile(FileLog,'selT940.Open: ' + E.Message);
  end;
  ParametriDB:=selT940.Active and (selT940.RecordCount > 0);
  try
    if not ParametriDB then
    begin
      R180AppendFile(FileLog,'GetParametriRegistro');
      GetParametriRegistro;
      R180AppendFile(FileLog,'ElaborazioneCartellini');
      ElaborazioneCartellini;
    end
    else
    begin
      while not selT940.Eof do
      begin
        R180AppendFile(FileLog,'GetParametriDB: ' + selT940.FieldByName('DESCRIZIONE').AsString);
        GetParametriDB;
        R180AppendFile(FileLog,'ElaborazioneCartellini');
        ElaborazioneCartellini;
        selT940.Next;
      end;
    end;
  finally
    R180AppendFile(FileLog,'A000SessioneIrisWIN: FreeAndNil');
    try if Assigned(A000SessioneIrisWIN) then FreeAndNil(A000SessioneIrisWIN); except end;
  end;
end;

procedure TB027FCartellinoSrv.InviaMail(Stato:String);
var sDep, sDep2:string;
begin
  try
    if IdSMTP.Connected then
      IdSMTP.Disconnect;
    //Impostazione parametri di connessione
      if MailServer = 'mondoedp' then
      begin
        IdSMTP.Host:='mail.mondoedp.com';
        IdSMTP.HeloName:='smtpext';
        IdSMTP.Connect;
        //IdSMTP.AuthenticationType:=atLogin;
        IdSMTP.AuthType:=satDefault;
        IdSMTP.Username:='smtpext';
        IdSMTP.Password:='$mTp3xT2k2o!';
      end
      else
      begin
        IdSMTP.Host:=MailServer;
        IdSMTP.Username:=MailUser;
        IdSMTP.HeloName:=IdSMTP.Username;
        IdSMTP.Password:=MailPassword;
      end;
    //Connessione
    IdSMTP.Connect;
  except
  end;
  with IdMessage do
  begin
    //Valorizzo il campo Mittente
    From.Address:=MailFromAddress;//'a.pilat@mondoedp.com';
    Sender.Address:=From.Address;
    Recipients.EmailAddresses:=MailToAddress;
    //Valorizzo il campo Oggetto
    Subject:=MailOggetto;//'Elaborazione B027';
    // Valorizzo gli allegati
    MessageParts.Clear;
    //Valorizzo il campo Corpo
    Body.Clear;
    Body.Add(FormatDateTime('dd/mm/yyyy hh.nn',Now));
    if Stato = 'I' then
      Body.Add(MailTestoInizio)
    else if Stato = 'F' then
      Body.Add(MailTestoFine);
   end;
   try
     IdSMTP.Send(IdMessage);
     IdSMTP.Disconnect;
   except
   end;
end;

procedure TB027FCartellinoSrv.LogParametri;
begin
  R180AppendFile(FileLog,'  FileIn=' + FileIn);
  R180AppendFile(FileLog,'  FileOut=' + FileOut);
  R180AppendFile(FileLog,'  FileSemaforo=' + FileSemaforo);
  R180AppendFile(FileLog,'  RotturaChiave=' + RotturaChiave);
  R180AppendFile(FileLog,'  SaltoPagina=' + SaltoPagina);
  R180AppendFile(FileLog,'  StrappoPagina=' + StrappoPagina);
  R180AppendFile(FileLog,'  InizioPagina=' + InizioPagina);
  R180AppendFile(FileLog,'  NumRighe=' + IntToStr(NumRighe));
  R180AppendFile(FileLog,'  MesiIndietro=' + IntToStr(MesiIndietro));
  R180AppendFile(FileLog,'  UltimoMese=' + IntToStr(UltimoMese));
  R180AppendFile(FileLog,'  AggiornamentoSchede=' + IfThen(AggiornamentoSchede,'S','N'));
  R180AppendFile(FileLog,'  SoloAggiornamento=' + IfThen(SoloAggiornamento,'S','N'));
  R180AppendFile(FileLog,'  AutoGiustificazione=' + IfThen(AutoGiustificazione,'S','N'));
  R180AppendFile(FileLog,'  IgnoraAnomalie=' + IfThen(IgnoraAnomalie,'S','N'));
  R180AppendFile(FileLog,'  ParCartellino=' + ParCartellino);
  R180AppendFile(FileLog,'  CarattereFOB=' + IntToStr(CarattereFOB));
  R180AppendFile(FileLog,'  SelezioneAnagrafica=' + SelezioneAnagrafica);
  R180AppendFile(FileLog,'  Database=' + SessioneOracle.LogonDatabase);
  R180AppendFile(FileLog,'  Username=' + SessioneOracle.LogonUsername);
end;

end.
