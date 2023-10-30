unit C017UEMailDtM;

interface

uses
  SysUtils, Classes, Oracle, Variants, DB, OracleData, StrUtils, Math,
  C180FunzioniGenerali, A000UInterfaccia, A000Usessione, A000UCostanti,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdMessage, IDAttachmentFile;

type
  TC017FEMailDtM = class(TDataModule)
    scrEMailResponsabile: TOracleQuery;
    scrEMailDipendente: TOracleQuery;
    selI060MailResp: TOracleDataSet;
    updI061UltimoInvio: TOracleQuery;
    selI060NomiResp: TOracleDataSet;
    selI091: TOracleDataSet;
    IdSMTP: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    IdMessage: TIdMessage;
  private
    FQueryDest: TOracleQuery;
    FDestResponsabile,
    FSollevaEccezioni: Boolean;
    FSessione: TOracleSession;
    FTagFunzione,
    FProgressivo: Integer;
    FDestinatari: String;
    FDestinatariDeleganti: String;
    FNomiDestinatari: String;
    FCercaDestinatari: Boolean;
    FDestinatariCC: String;
    FDestinatariCCN: String;
    FOggetto: String;
    FAllegato: String;
    FTesto: String;
    FFiltroAgg: String;
    FFiltroAggDeleganti: String;
    FIter: String;
    FCodIter: String;
    FLivelliDest: String;
    FDisclaimer: String;
    FTraccia: String;
    FWebParametriAvanzati: String;
    FMailInviata:Boolean;
    ParametriC017:TParametri;
    //FStatoSMTP: Boolean;  //PALERMO_POLICLINICO - 163352
    // variabili per i dati di "Parametri.XXX" non leggibili dal thread
    ParAzienda,
    ParV430,
    ParHintT030V430,
    ParC90_EMailRespOttimizzata, ParC90_EMailRespGGReinvio,
    ParC90_EMailSMTPHost, ParC90_EMailUserName, ParC90_EMailHeloName,
    ParC90_EMailPassword, ParC90_EMailPort, ParC90_EMailSenderIndirizzo,
    ParC90_EMailSender, ParC90_EMailAuthType, ParC90_EMailUseTLS:string;
    function ConvertiFiltro(const PFiltro: String): String;
    procedure AggiornaOraInvio;
    procedure AddTraccia(const Funzione, Messaggio: String);
    procedure PutCercaDestinatari(const Value: Boolean);
    const
      MAIL_DISCLAIMER = CRLF + CRLF + 'Avviso:' + CRLF +
                        'La presente e-mail e'' stata generata automaticamente dal sistema IrisWEB.' + CRLF +
                        'Si prega di non rispondere a questo indirizzo di posta,' + CRLF +
                        'in quanto non è abilitato alla ricezione di messaggi.%s';
  public
    constructor Create(AOwner: TComponent); override;
    procedure GetDestinatari;
    (*PALERMO_POLICLINICO - 163352: per invio mail senza chiusura dell'SMTP chiamare PreparazioneSendMail e ChiusuraSendMail
    prima e dopo di SendMail; StatoSMPT permette la retrocompatibilità SendMail
    procedure PreparazioneSendMail;
    procedure ChiusuraSendMail;
    property StatoSMPT: Boolean read FStatoSMTP;*)

    procedure SendMail;
    procedure InviaEmail; overload;
    procedure InviaEMail(PSessione:TOracleSession; PDestResponsabile:Boolean; PProgressivo: Integer;
      POggetto,PTesto:String; PTag:Integer; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = ''); overload;
    //Se CercaDestinatari = False, non usare Progressivo e/o DestResponsabile in quanto si dà per scontato che Destinatari è già valorizzato
    property CercaDestinatari: Boolean read FCercaDestinatari write PutCercaDestinatari;
    property Destinatari: String read FDestinatari write FDestinatari;
    property DestinatariDeleganti: String read FDestinatariDeleganti write FDestinatariDeleganti;
    property NomiDestinatari: String read FNomiDestinatari write FNomiDestinatari;
    property DestinatariCC: String read FDestinatariCC write FDestinatariCC;
    property DestinatariCCN: String read FDestinatariCCN write FDestinatariCCN;
    property DestResponsabile: Boolean read FDestResponsabile write FDestResponsabile;
    property Disclaimer: String read FDisclaimer write FDisclaimer;
    property FiltroAgg: String read FFiltroAgg write FFiltroAgg;
    property FiltroAggDeleganti: String read FFiltroAggDeleganti write FFiltroAggDeleganti;
    property Iter: String read FIter write FIter;
    property CodIter: String read FCodIter write FCodIter;
    property LivelliDest: String read FLivelliDest write FLivelliDest;
    property Oggetto: String read FOggetto write FOggetto;
    property Allegato: String read FAllegato write FAllegato;
    property Progressivo: Integer read FProgressivo write FProgressivo;
    property Sessione: TOracleSession read FSessione write FSessione;
    property SollevaEccezioni: Boolean read FSollevaEccezioni write FSollevaEccezioni;
    property TagFunzione: Integer read FTagFunzione write FTagFunzione;
    property Testo: String read FTesto write FTesto;
    property Traccia: String read FTraccia;
    property WebParametriAvanzati: String read FWebParametriAvanzati write FWebParametriAvanzati;
    property MailInviata: Boolean read FMailInviata;
  end;

implementation

{$R *.dfm}

constructor TC017FEMailDtM.Create(AOwner: TComponent);
var locMailDisclaimer:String;
begin
  inherited Create(AOwner);
  ParametriC017:=Parametri;
  if (AOwner <> nil) and (AOwner is TSessioneIrisWIN) then
    ParametriC017:=(AOwner as TSessioneIrisWIN).Parametri;
  // inizializza proprietà default
  DestResponsabile:=True;
  Destinatari:='';
  DestinatariDeleganti:='';
  DestinatariCC:='';
  DestinatariCCN:='';
  CercaDestinatari:=True;
  Disclaimer:=Format(MAIL_DISCLAIMER,[CRLF + '[versione applicativo: ' + ParametriC017.VersionePJ + ']']);
  if ParametriC017.CampiRiferimento.C90_Lingua = 'INGLESE' then
  begin
    locMailDisclaimer:=CRLF + CRLF +
                       'Note:' + CRLF +
                       'This email was automatically generated by the IrisWEB system.' + CRLF +
                       'This is a post-only email. Please do not reply to this message.';
    Disclaimer:=Format(locMailDisclaimer,[CRLF + '[application version: ' + ParametriC017.VersionePJ + ']']);
  end;

  FiltroAgg:='';
  Iter:='';
  CodIter:='';
  LivelliDest:='';
  Oggetto:='';
  Allegato:='';
  Progressivo:=0;
  Sessione:=nil;
  SollevaEccezioni:=False;
  TagFunzione:=-1;
  Testo:='';
  FTraccia:='';
  FWebParametriAvanzati:='';
  FMailInviata:=False;

  // inizializza parametri ("Parametri.XXX" non leggibili dal thread)
  ParAzienda:=ParametriC017.Azienda;
  ParV430:=ParametriC017.V430;
  ParHintT030V430:=ParametriC017.CampiRiferimento.C26_HintT030V430;
  ParC90_EMailRespOttimizzata:=ParametriC017.CampiRiferimento.C90_EMailRespOttimizzata;
  ParC90_EMailRespGGReinvio:=ParametriC017.CampiRiferimento.C90_EMailRespGGReinvio;
  ParC90_EMailSMTPHost:=ParametriC017.CampiRiferimento.C90_EMailSMTPHost;
  ParC90_EMailUserName:=ParametriC017.CampiRiferimento.C90_EMailUserName;
  ParC90_EMailHeloName:=ParametriC017.CampiRiferimento.C90_EMailHeloName;
  ParC90_EMailPassword:=ParametriC017.CampiRiferimento.C90_EMailPassWord;
  ParC90_EMailPort:=ParametriC017.CampiRiferimento.C90_EMailPort;
  ParC90_EMailSenderIndirizzo:=ParametriC017.CampiRiferimento.C90_EMailSenderIndirizzo;
  ParC90_EMailSender:=ParametriC017.CampiRiferimento.C90_EMailSender;
  ParC90_EMailAuthType:=ParametriC017.CampiRiferimento.C90_EMailAuthType;
  ParC90_EMailUseTLS:=ParametriC017.CampiRiferimento.C90_EMailUseTLS;
  //FStatoSMTP:=False;
end;

procedure TC017FEMailDtM.AddTraccia(const Funzione,Messaggio: String);
var
  Ora: String;
const
  APP_ID = '0000000000000000000000000000';
begin
  Ora:=FormatDateTime('dd/mm/yyyy hh.nn.ss',Now);
  if FTraccia <> '' then
    FTraccia:=FTraccia + '|';
  FTraccia:=FTraccia + Format('%s;%s;%s;%s - %s',[Ora,APP_ID,'    ;C017 ',Funzione,Messaggio]);
end;

function TC017FEMailDtM.ConvertiFiltro(const PFiltro: String): String;
const
  FUNZIONE = 'ConvertiFiltro';
begin
  AddTraccia(FUNZIONE,'inizio');
  Result:=AggiungiApice(PFiltro); // gestione carattere apice nel nome profilo - daniloc. 26.03.2012
  Result:=StringReplace(Result,'<U>','I061.NOME_UTENTE = ''',[rfReplaceAll]);
  Result:=StringReplace(Result,'<P>',''' and I061.NOME_PROFILO = ''',[rfReplaceAll]);
  if Pos(';',Result) = 0 then
    Result:='and ' + Result + ''''
  else
  begin
    Result:=StringReplace(Result,';',''') or (',[rfReplaceAll]);
    Result:='and ((' + Result + '''))';
  end;
  AddTraccia(FUNZIONE,'fine');
end;

procedure TC017FEMailDtM.GetDestinatari;
// estrae l'elenco dei destinatari in base alle informazioni sotto riportate.
// Nota: l'elenco viene eventualmente filtrato se la mail è rivolta
//       al responsabile ed è attivo il parametro di ottimizzazione
// parametri per estrazione destinatari:
// - Progressivo:       progressivo del dipendente
// - DestResponsabile:  direzione mail (a responsabile / a dipendente)
// - TagFunzione:       tag di abilitazione funzione (facoltativo)
const
  FUNZIONE = 'GetDestinatari';
begin
  AddTraccia(FUNZIONE,'inizio');
  AddTraccia(FUNZIONE,Format('destinatario=%s,azienda=%s,progressivo=%d,tag=%d,v430=%s,iter=%s,coditer=%s,livelli=%s',
                             [IfThen(DestResponsabile,'responsabile','dipendente'),ParAzienda,Progressivo,TagFunzione,ParV430,Iter,CodIter,LivelliDest]));
  FDestinatari:='';
  FDestinatariDeleganti:='';
  FNomiDestinatari:='';
  try
    // controllo proprietà
    if DestResponsabile and (Iter <> '') and (CodIter = '') then
      raise Exception.Create('Recupero indirizzo email: codice iter non specificato per iter ' + CodIter + '!');

    // 1. estrae i dati dei destinatari della mail di avviso
    if DestResponsabile then
      FQueryDest:=scrEMailResponsabile
    else
      FQueryDest:=scrEMailDipendente;

    // i parametri avanzati sono impostati dal chiamante perché non accessibili da qui
    // (v. WR000UBaseDM, A023UTimbratureMW, A004UGiustifAssPresMW)
    //if Pos(INI_PAR_C017_V430,WebParametriAvanzati) > 0 then
    if ParametriC017.CampiRiferimento.C90_EMail_DatiP430 = 'S' then
      ParV430:='P430';
    if (ParV430 = 'P430') and (ParHintT030V430 = '') then
      ParHintT030V430:='/*+ ordered */';
    FQueryDest.Session:=Sessione;
    FQueryDest.ClearVariables;
    FQueryDest.SetVariable('AZIENDA',ParAzienda);
    FQueryDest.SetVariable('PROGRESSIVO',Progressivo);
    if TagFunzione <> -1 then
      FQueryDest.SetVariable('TAG',TagFunzione);
    if DestResponsabile then
    begin
      // variabili specifiche per la mail verso il responsabile
      FQueryDest.SetVariable('hintT030V430',ParHintT030V430);
      FQueryDest.SetVariable('V430',ParV430);
      FQueryDest.SetVariable('ITER',Iter);
      FQueryDest.SetVariable('COD_ITER',CodIter);
      FQueryDest.SetVariable('ELENCO_LIVELLI',LivelliDest);
    end;
    try
      FQueryDest.Execute;
      FDestinatari:=Trim(VarToStr(FQueryDest.GetVariable('EMAIL')));
      if DestResponsabile and (FQueryDest.VariableIndex('EMAIL_DELEGANTI') <> -1) then
        FDestinatariDeleganti:=Trim(VarToStr(FQueryDest.GetVariable('EMAIL_DELEGANTI')));
      AddTraccia(FUNZIONE,'mail destinatari: ' + FDestinatari);
      AddTraccia(FUNZIONE,'mail destinatari deleganti: ' + FDestinatariDeleganti);
      if (FDestinatari = '') and (FDestinatariDeleganti = '') then
        Exit;
      if DestResponsabile and (FQueryDest.VariableIndex('FILTRO_AGG') <> -1) then
      begin
        FFiltroAgg:=Trim(VarToStr(FQueryDest.GetVariable('FILTRO_AGG')));
        FFiltroAggDeleganti:=Trim(VarToStr(FQueryDest.GetVariable('FILTRO_AGG_DELEGANTI')));
        if FFiltroAggDeleganti <> '' then
          FFiltroAgg:=FFiltroAgg + IfThen(FFiltroAgg <> '',';') + FFiltroAggDeleganti;
        AddTraccia(FUNZIONE,'filtro agg.: ' + FFiltroAgg);
        FFiltroAgg:=ConvertiFiltro(FFiltroAgg);
        AddTraccia(FUNZIONE,'filtro agg. convertito: ' + FFiltroAgg);
      end
      else
        FFiltroAgg:='';
    except
      on E:Exception do
        raise Exception.Create('Recupero indirizzo email: ' + E.ClassName + '/' + E.Message);
    end;

    AddTraccia(FUNZIONE,'gestione ottimizzata ' + IfThen(ParC90_EMailRespOttimizzata = 'S','attiva','disattiva'));

    // 2. se mail diretta a responsabile e parametro ottimizzazione attivo
    //    elabora gli indirizzi dei destinatari
    if DestResponsabile and (ParC90_EMailRespOttimizzata = 'S') then
    begin
      AddTraccia(FUNZIONE,'elaborazione indirizzi destinatari.ini');
      // imposta oggetto e corpo della mail con diciture predefinite
      Oggetto:='Notifica presenza richieste da autorizzare';
      Testo:='Si avvisa che sono presenti richieste' + CRLF +
             'in attesa di autorizzazione.';

      // elabora indirizzi mail dei destinatari
      selI060MailResp.Session:=Sessione;
      selI060MailResp.Close;
      selI060MailResp.SetVariable('AZIENDA',ParAzienda);
      selI060MailResp.SetVariable('GG_REINVIO_MAIL',StrToFloatDef(ParC90_EMailRespGGReinvio,0));
      selI060MailResp.SetVariable('FILTRO_AGG',FFiltroAgg);
      try
        selI060MailResp.Open;
        FDestinatari:='';
        while not selI060MailResp.Eof do
        begin
          FDestinatari:=FDestinatari + selI060MailResp.FieldByName('EMAIL').AsString + ';';
          selI060MailResp.Next;
        end;
        AddTraccia(FUNZIONE,'mail destinatari dopo filtro: ' + FDestinatari);
        AddTraccia(FUNZIONE,'elaborazione indirizzi destinatari.fine');
        if FDestinatari = '' then
          Exit;
        FDestinatari:=Copy(FDestinatari,1,Length(FDestinatari) - 1);
      except
        on E:Exception do
          raise Exception.Create('Filtro destinatari per invio ottimizzato: ' + E.ClassName + '/' + E.Message);
      end;
    end;

    // 3. recupera i nomi dei responsabili per successiva notifica
    //    (al momento non implementata)
    if False and DestResponsabile and (FDestinatari <> '') then
    begin
      AddTraccia(FUNZIONE,'estrazione nomi destinatari.ini');

      // estrae nominativi dei responsabili
      selI060NomiResp.Session:=Sessione;
      selI060NomiResp.Close;
      selI060NomiResp.SetVariable('AZIENDA',ParAzienda);
      selI060NomiResp.SetVariable('FILTRO_AGG',FFiltroAgg);
      try
        selI060NomiResp.Open;
        FNomiDestinatari:='';
        while not selI060NomiResp.Eof do
        begin
          FNomiDestinatari:=FNomiDestinatari + selI060NomiResp.FieldByName('NOMINATIVO').AsString + ',';
          selI060NomiResp.Next;
        end;
        FNomiDestinatari:=Copy(FNomiDestinatari,1,Length(FNomiDestinatari) - 1);
      except
        on E:Exception do
          raise Exception.Create('Estrazione nomi destinatari: ' + E.ClassName + '/' + E.Message);
      end;
      AddTraccia(FUNZIONE,'estrazione nomi destinatari.fine');
    end;
  finally
    AddTraccia(FUNZIONE,'fine');
  end;
end;

procedure TC017FEMailDtM.SendMail;
// esegue l'invio effettivo della mail con i parametri impostato
var
  TestoDeleganti:String;
  //DisconnettiSMTP:Boolean;
const
  FUNZIONE = 'SendMail';
begin
  (*DisconnettiSMTP:=not FStatoSMTP;
  if not FStatoSMTP then
    PreparazioneSendMail;*)

  AddTraccia(FUNZIONE,'inizio');
  AddTraccia(FUNZIONE,'mail server: ' + ParC90_EMailSMTPHost);
  FMailInviata:=False;
  //PreparazioneSendMail inizio
  IdSMTP.Host:=ParC90_EMailSMTPHost;
  IdSSLIOHandlerSocketOpenSSL.ReadTimeout:=5000;
  IdSSLIOHandlerSocketOpenSSL.ConnectTimeout:=5000;
  IdSMTP.ReadTimeout:=5000;
  IdSMTP.ConnectTimeout:=5000;
  if ParC90_EMailPort.Trim = '' then
    IdSMTP.Port:=25
  else
    IdSMTP.Port:=ParC90_EMailPort.ToInteger;
  IdSMTP.AuthType:=satDefault;
  TestoDeleganti:='(Copia del messaggio inviato al suo delegato)' + CRLF + CRLF;
  if ParametriC017.CampiRiferimento.C90_Lingua = 'INGLESE' then
    TestoDeleganti:='(Copy of the message sent to the delegated official)' + CRLF + CRLF;
  {Assegnazione e valorizzazione oggetto necessario per l'autenticazione TLS\SSL}
  if (ParC90_EMailAuthType.Trim <> '') and
     (ParC90_EMailAuthType.Trim.ToUpper <> 'NO AUTENTICAZIONE') then
  begin
    IdSMTP.IOHandler:=IdSSLIOHandlerSocketOpenSSL;
    with IdSSLIOHandlerSocketOpenSSL do
    begin
      IdSMTP.UseEhlo:=not ParC90_EMailHeloName.Trim.IsEmpty;

      SSLOptions.Method:=sslvTLSv1;
      SSLOptions.SSLVersions:=[sslvTLSv1];
      if ParC90_EMailAuthType.ToUpper = 'TLSV1_1' then
      begin
        SSLOptions.Method:=sslvTLSv1_1;
        SSLOptions.SSLVersions:=[sslvTLSv1_1];
      end
      else if ParC90_EMailAuthType.ToUpper = 'TLSV1_2' then
      begin
        SSLOptions.Method:=sslvTLSv1_2;
        SSLOptions.SSLVersions:=[sslvTLSv1_2];
      end
      else if ParC90_EMailAuthType.ToUpper = 'SSLV2' then
      begin
        SSLOptions.Method:=sslvSSLv2;
        SSLOptions.SSLVersions:=[sslvSSLv2];
      end
      else if ParC90_EMailAuthType.ToUpper = 'SSLV23' then
      begin
        SSLOptions.Method:=sslvSSLv23;
        SSLOptions.SSLVersions:=[sslvSSLv23];
      end
      else if ParC90_EMailAuthType.ToUpper = 'SSLV3' then
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
    IdSMTP.UseTLS:=utUseImplicitTLS;
    if ParC90_EMailUseTLS.ToUpper = 'NO' then
      IdSMTP.UseTLS:=utNoTLSSupport
    else if ParC90_EMailUseTLS.ToUpper = 'IMPLICIT' then
      IdSMTP.UseTLS:=utUseImplicitTLS
    else if ParC90_EMailUseTLS.ToUpper = 'EXPLICIT' then
      IdSMTP.UseTLS:=utUseExplicitTLS
    else if ParC90_EMailUseTLS.ToUpper = 'REQUIRE' then
      IdSMTP.UseTLS:=utUseRequireTLS;
  end;
  try
    try
      AddTraccia(FUNZIONE,'EMailAuthType=' + ParC90_EMailAuthType.ToUpper);
      AddTraccia(FUNZIONE,'EMailUseTLS=' + ParC90_EMailUseTLS.ToUpper);
      AddTraccia(FUNZIONE,'EMailPort=' + ParC90_EMailPort);
      AddTraccia(FUNZIONE,'heloname=' + ParC90_EMailHeloName);
      AddTraccia(FUNZIONE,'username=' + ParC90_EMailUserName);
      AddTraccia(FUNZIONE,'password=' + ParC90_EMailPassword);
      AddTraccia(FUNZIONE,'fromAddress=' + ParC90_EMailSenderIndirizzo);
      AddTraccia(FUNZIONE,'emailAddresses=' + Destinatari);
      AddTraccia(FUNZIONE,'oggetto=' + Oggetto);
      AddTraccia(FUNZIONE,'testo=' + Testo);
      IdSMTP.HeloName:=Trim(ParC90_EMailHeloName);
      IdSMTP.Connect;
      IdSMTP.Username:=Trim(ParC90_EMailUserName);
      IdSMTP.Password:=Trim(ParC90_EMailPassword);
      AddTraccia(FUNZIONE,'connessione all''host per l''invio mail riuscita');
      //PreparazioneSendMail fine
      if Allegato = '' then
        IdMessage.ContentType:='text/plain; charset=ISO-8859-15';
      IdMessage.From.Address:=ParC90_EMailSenderIndirizzo; // 'irisweb@mondoedp.com' è il default
      IdMessage.From.Name:='IrisWEB';
      IdMessage.Recipients.Clear;
      IdMessage.Recipients.EmailAddresses:=Destinatari;
      IdMessage.CCList.Clear;
      IdMessage.CCList.EmailAddresses:=DestinatariCC;
      IdMessage.BccList.Clear;
      IdMessage.BccList.EmailAddresses:=DestinatariCCN;
      IdMessage.Subject:=Oggetto;
      IdMessage.MessageParts.Clear;
      if Allegato <> '' then
      begin
        IdMessage.MessageParts.Add;
        TIdAttachmentFile.Create(IdMessage.MessageParts,Allegato);
      end;
      IdMessage.Body.Text:=Testo + Disclaimer;
      // MILANO_HSACCO - chiamata <119679> - bugfix.ini
      // invia la mail se almeno una lista di destinatari è significativa
      if (Destinatari <> '') or (DestinatariCC <> '') or (DestinatariCCN <> '') then
      begin
        IdSMTP.Send(IdMessage);
        FMailInviata:=True;
        AddTraccia(FUNZIONE,'mail inviata correttamente');
      end;
      // MILANO_HSACCO - chiamata <119679> - bugfix.fine
      if DestinatariDeleganti <> ''  then
      begin
        AddTraccia(FUNZIONE,'emailDelegantiAddresses=' + DestinatariDeleganti);
        IdMessage.Recipients.Clear;
        IdMessage.Recipients.EmailAddresses:=DestinatariDeleganti;
        IdMessage.Body.Text:=TestoDeleganti + Testo + Disclaimer;
        IdSMTP.Send(IdMessage);
        AddTraccia(FUNZIONE,'mail per i deleganti inviata correttamente');
      end;
    finally
      //if DisconnettiSMTP then  //Disconnette solo se si è connnesso in apertura
      IdSMTP.Disconnect;
    end;
  except
    on E:Exception do
      raise Exception.Create('Invio email fallito su host ' + IdSMTP.Host + ': ' + E.ClassName + '/' + E.Message);
  end;
  AddTraccia(FUNZIONE,'fine');
end;

procedure TC017FEMailDtM.AggiornaOraInvio;
// aggiorna l'ora di ultimo invio mail su profili responsabile (tabella I061)
const
  FUNZIONE = 'AggiornaOraInvio';
begin
  if Sessione = nil then
    exit;
  AddTraccia(FUNZIONE,'inizio');
  selI091.Session:=Sessione;
  R180SetVariable(selI091,'AZIENDA',ParAzienda);
  selI091.Open;
  if selI091.RecordCount = 0 then
    exit;
  with updI061UltimoInvio do
  begin
    // pragma autonomous transaction
    Session:=Sessione;
    SetVariable('AZIENDA',ParAzienda);
    SetVariable('GG_REINVIO_MAIL',StrToFloatDef(ParC90_EMailRespGGReinvio,0));
    SetVariable('FILTRO_AGG',FiltroAgg);
    try
      Execute;
      AddTraccia(FUNZIONE,'aggiornamento ora invio eseguito correttamente');
    except
      on E:Exception do
        raise Exception.Create('Aggiornamento ora ultimo invio email fallito: ' + E.ClassName + '/' + E.Message);
    end;
  end;
  AddTraccia(FUNZIONE,'fine');
end;

procedure TC017FEMailDtM.InviaEmail;
// invia mail utilizzando il server SMTP specificato nei parametri aziendali
// in base alle informazioni contenute nelle proprietà
//   Sessione:           sessione oracle da utilizzare per estrazione dati dei destinatari
//   DestResponsabile:   indica se il destinatario della mail è un responsabile / dipendente
//                       - True:  destinatario = responsabile
//                       - False: destinatario = dipendente
//   Destinatari         elenco degli indirizzi mail dei destinatari
//   Disclaimer          testo fisso da includere in calce al corpo della mail
//   Oggetto:            oggetto (subject) della mail
//   SollevaEccezioni:   indica se è necessario sollevare eccezione in caso di errori
//                       - True: in caso di errori effettua una raise con il dettaglio dell'eccezione
//                       - False: in caso di errori l'eccezione è sempre silenziosa
//   Progressivo:        progressivo del dipendente
//   TagFunzione:        se indicato verifica l'abilitazione del/i destinatario/i alla funzione indicata dal tag
//                       (l'abilitazione si intende verificata quando INIBIZIONE vale 'S' oppure 'R')
//   Testo:              corpo body) della mail
const
  FUNZIONE = 'InviaEmail';
begin
  if Sessione = nil then
    exit;
  //Sessione.Commit;//Test di carico CSI 2014
  AddTraccia(FUNZIONE,'inizio');
  try
    // 1. estrae elenco destinatari, eventualmente filtrato se la mail è rivolta
    //    al responsabile ed è attivo il parametro di ottimizzazione
    if CercaDestinatari then
      GetDestinatari;

    if (Destinatari <> '') or (DestinatariDeleganti <> '') or (DestinatariCC <> '') or (DestinatariCCN <> '') then
    begin
      // 2. gestisce invio email
      SendMail;

      // 3. aggiorna data ultimo invio mail su profili responsabile (tabella I061)
      if DestResponsabile then
        AggiornaOraInvio;
    end;
  except
    on E: Exception do
      if SollevaEccezioni then
        raise Exception.Create('Errore di invio mail al ' + IfThen(DestResponsabile,'responsabile','dipendente') + #13#10 +
                               'Dettaglio: ' + E.Message);
  end;
  AddTraccia(FUNZIONE,'fine');
end;

procedure TC017FEMailDtM.InviaEMail(PSessione:TOracleSession; PDestResponsabile:Boolean; PProgressivo: Integer;
  POggetto,PTesto:String; PTag:Integer; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '');
begin
  // impostazione proprietà
  Sessione:=PSessione;
  DestResponsabile:=PDestResponsabile;
  Progressivo:=PProgressivo;
  Oggetto:=POggetto;
  Testo:=PTesto;
  TagFunzione:=PTag;
  Iter:=PIter;
  CodIter:=PCodIter;
  LivelliDest:=PLivelliDest;

  InviaEmail;
end;

procedure TC017FEMailDtM.PutCercaDestinatari(const Value: Boolean);
begin
  FCercaDestinatari:=Value;
  if not Value then
  begin
    Progressivo:=0;
    DestResponsabile:=False;
  end;
end;

(* PALERMO_POLICLINICO - 163352 - invio mail senza chiusura di SMTP (DA COMPLETARE)
procedure TC017FEMailDtM.PreparazioneSendMail;
var
  TestoDeleganti:String;
const
  FUNZIONE = 'PreparazioneSendMail';
begin
  AddTraccia(FUNZIONE,'inizio');
  AddTraccia(FUNZIONE,'mail server: ' + ParC90_EMailSMTPHost);
  FMailInviata:=False;
  IdSMTP.Host:=ParC90_EMailSMTPHost;
  IdSSLIOHandlerSocketOpenSSL.ReadTimeout:=5000;
  IdSSLIOHandlerSocketOpenSSL.ConnectTimeout:=5000;
  IdSMTP.ReadTimeout:=5000;
  IdSMTP.ConnectTimeout:=5000;
  if ParC90_EMailPort.Trim = '' then
    IdSMTP.Port:=25
  else
    IdSMTP.Port:=ParC90_EMailPort.ToInteger;
  IdSMTP.AuthType:=satDefault;
  TestoDeleganti:='(Copia del messaggio inviato al suo delegato)' + CRLF + CRLF;
  if ParametriC017.CampiRiferimento.C90_Lingua = 'INGLESE' then
    TestoDeleganti:='(Copy of the message sent to the delegated official)' + CRLF + CRLF;
  {Assegnazione e valorizzazione oggetto necessario per l'autenticazione TLS\SSL}
  if (ParC90_EMailAuthType.Trim <> '') and
     (ParC90_EMailAuthType.Trim.ToUpper <> 'NO AUTENTICAZIONE') then
  begin
    IdSMTP.IOHandler:=IdSSLIOHandlerSocketOpenSSL;
    with IdSSLIOHandlerSocketOpenSSL do
    begin
      IdSMTP.UseEhlo:=not ParC90_EMailHeloName.Trim.IsEmpty;

      SSLOptions.Method:=sslvTLSv1;
      SSLOptions.SSLVersions:=[sslvTLSv1];
      if ParC90_EMailAuthType.ToUpper = 'TLSV1_1' then
      begin
        SSLOptions.Method:=sslvTLSv1_1;
        SSLOptions.SSLVersions:=[sslvTLSv1_1];
      end
      else if ParC90_EMailAuthType.ToUpper = 'TLSV1_2' then
      begin
        SSLOptions.Method:=sslvTLSv1_2;
        SSLOptions.SSLVersions:=[sslvTLSv1_2];
      end
      else if ParC90_EMailAuthType.ToUpper = 'SSLV2' then
      begin
        SSLOptions.Method:=sslvSSLv2;
        SSLOptions.SSLVersions:=[sslvSSLv2];
      end
      else if ParC90_EMailAuthType.ToUpper = 'SSLV23' then
      begin
        SSLOptions.Method:=sslvSSLv23;
        SSLOptions.SSLVersions:=[sslvSSLv23];
      end
      else if ParC90_EMailAuthType.ToUpper = 'SSLV3' then
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
    IdSMTP.UseTLS:=utUseImplicitTLS;
    if ParC90_EMailUseTLS.ToUpper = 'NO' then
      IdSMTP.UseTLS:=utNoTLSSupport
    else if ParC90_EMailUseTLS.ToUpper = 'IMPLICIT' then
      IdSMTP.UseTLS:=utUseImplicitTLS
    else if ParC90_EMailUseTLS.ToUpper = 'EXPLICIT' then
      IdSMTP.UseTLS:=utUseExplicitTLS
    else if ParC90_EMailUseTLS.ToUpper = 'REQUIRE' then
      IdSMTP.UseTLS:=utUseRequireTLS;
  end;

  try
    AddTraccia(FUNZIONE,'EMailAuthType=' + ParC90_EMailAuthType.ToUpper);
    AddTraccia(FUNZIONE,'EMailUseTLS=' + ParC90_EMailUseTLS.ToUpper);
    AddTraccia(FUNZIONE,'EMailPort=' + ParC90_EMailPort);
    AddTraccia(FUNZIONE,'heloname=' + ParC90_EMailHeloName);
    AddTraccia(FUNZIONE,'username=' + ParC90_EMailUserName);
    AddTraccia(FUNZIONE,'password=' + ParC90_EMailPassword);
    AddTraccia(FUNZIONE,'fromAddress=' + ParC90_EMailSenderIndirizzo);
    AddTraccia(FUNZIONE,'emailAddresses=' + Destinatari);
    AddTraccia(FUNZIONE,'oggetto=' + Oggetto);
    AddTraccia(FUNZIONE,'testo=' + Testo);
    IdSMTP.HeloName:=Trim(ParC90_EMailHeloName);
    IdSMTP.Connect;
    IdSMTP.Username:=Trim(ParC90_EMailUserName);
    IdSMTP.Password:=Trim(ParC90_EMailPassword);
    AddTraccia(FUNZIONE,'connessione all''host per l''invio mail riuscita');
  except
    on E:Exception do
      raise Exception.Create('Invio email fallito su host ' + IdSMTP.Host + ': ' + E.ClassName + '/' + E.Message);
  end;
  AddTraccia(FUNZIONE,'fine');
  FStatoSMTP:=True;
end;

procedure TC017FEMailDtM.ChiusuraSendMail;
begin
  try
    IdSMTP.Disconnect;
    FStatoSMTP:=False;
  except
    on E:Exception do
      raise Exception.Create('Chiusura SMTP su host ' + IdSMTP.Host + ' fallita: ' + E.ClassName + '/' + E.Message);
  end;
end;*)

end.
