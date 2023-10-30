unit W001ULogin;

interface

uses
  R010UPaginaWeb, W000UMessaggi, L021Call, System.Contnrs,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdMessage, IdBaseComponent, IdComponent, IdSMTPBase, IdSMTP, System.NetEncoding,
  Oracle, DB, OracleData, DateUtils, Windows, System.Json,
  IWAppForm, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel, Classes, Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  Math, SysUtils, Variants, IWCompButton, meIWButton,
  A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi,
  A001UPasswordDtM1, C180FunzioniGenerali, C190FunzioniGeneraliWeb, RegistrazioneLog,
  IWCompListbox, StrUtils, IniFiles, IW.Common.System, WR010UBase,
  //JBFService, xmldom, msxmldom, XMLDoc, XMLIntf, Xml.xmldom, Xml.Win.msxmldom, Xml.XMLDoc,
  IWCompEdit, meIWLabel, meIWComboBox, meIWEdit, meIWLink, IWCompGrids, meIWGrid,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdHTTP;

type
  TW001FLogin = class(TR010FPaginaWeb)
    lblAzienda: TmeIWLabel;
    lblUtente: TmeIWLabel;
    lblPassword: TmeIWLabel;
    lblDatabase: TmeIWLabel;
    edtAzienda: TmeIWEdit;
    edtUtente: TmeIWEdit;
    edtPassword: TmeIWEdit;
    edtDatabase: TmeIWEdit;
    lblNomeProfilo: TmeIWLabel;
    edtNomeProfilo: TmeIWEdit;
    cmbNomeProfilo: TmeIWComboBox;
    lnkAccedi: TmeIWLink;
    btnAccedi: TmeIWButton;
    lnkRecuperaPassword: TmeIWLink;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    lblReCAPTCHA: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure lnkAccediClick(Sender: TObject);
    procedure edtAziendaSubmit(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure lnkRecuperaPasswordClick(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure IWAppFormRefreshForm(Sender: TObject);
  private
    ScriviDatabase: Boolean;
    ForzaAziendaVisibile: Boolean; // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6
    ParTicket,ParUID,ParTime,ParHash: String; //Possono servire sia nella fase di lettura parametri (create) che nel login
    W001FPasswordDtM:TA001FPasswordDtM1;
    VerifiedReCAPTCHA: Boolean;
    function  ConvertiHomeUrl(const PHome: String): String;
    procedure GetAbilitazioniModuli;
    procedure TraduzionePagina;
    function RichiestoReCAPTCHA: Boolean;
    procedure ReCAPTCHA_OnCallBack(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
    procedure ReCAPTCHA_OnCallBackExpired(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
  public
    LoginEsterno: String;
  end;

implementation

uses WR000UBaseDM, W001UIrisWebDtM, W002URicercaAnagrafe, WC023UCambioPasswordFM,
     IWApplication, IWGlobal, System.IOUtils;

{$R *.DFM}

procedure TW001FLogin.IWAppFormCreate(Sender: TObject);
var
  ParAzienda,ParUsr,ParPwd,ParProfilo,
  ParDatabase,ParLoginEsterno,
  ParHome,ParWSAuth,
  Anomalia, ParForwardedFor,
  ParURLMan,ParRemoteUser,STemp:String;
  AutSSO: Boolean;
  Risposta: TSSORisposta;
  ListaPar: TStrings;
  i: Integer;
  Base64: TBase64Encoding;
const
  PAR_REMOTE_USER_NAME = 'remoteuser';

  procedure SSORedirect;
  var AzioneForm:String;
      RedirectStr:String;
  begin
    Log('Traccia','GGetWebApplicationThreadVar.AppURLBase: ' + GGetWebApplicationThreadVar.AppURLBase);
    //Costruisco il token con l'utente, la data e la passphrase interna
    ParUsr:=RispoSta.Utente;
    ParUsr:=R180SSO_TokenUsr(ParUsr,A000SSO_UsrMask);
    ParUsr:=R180RDL_ECB_Encrypt(ParUsr,A000SSO_RDLPassphrase);
    //Poichè il parametro viene passato in get, viene codificato in base64 e passato comep parametro xusr64 invece che xusr
    Base64:=TBase64Encoding.Create(0);
    ParUsr:=Base64.Encode(ParUsr);
    Base64.Free;
    RedirectStr:='?azienda=' + edtAzienda.Text +
                 '&xusr64=' + ParUsr +
                 '&usr=' + Risposta.Utente +
                 '&profilo=' + Risposta.Profilo +
                 '&database=' + edtDatabase.Text +
                 '&loginesterno=' + 'S'; //LoginEsterno;
    // bugfix.ini iw 12.2.12.1
    // appurlbase contiene erroneamente il session id: occorre rimuoverlo
    RedirectStr:=StringReplace(GGetWebApplicationThreadVar.AppURLBase,'/' + GGetWebApplicationThreadVar.AppID,'',[]) + RedirectStr;
    // bugfix.fine
    Log('Traccia','Ticket autorizzato: accesso ad IrisWeb con redirect su: ' + RedirectStr);
    GGetWebApplicationThreadVar.Response.SendRedirect(RedirectStr);
  end;
  procedure SSOVisualizzaAnomalia(const PAnomalia: String);
  begin
    // visualizza anomalia
    MessaggioStatus(ERRORE,PAnomalia);

    // disabilita login
    edtAzienda.Enabled:=False;
    edtUtente.Enabled:=False;
    edtPassword.Enabled:=False;
    edtNomeProfilo.Enabled:=False;
    edtDatabase.Enabled:=False;

    // disabilita link di accesso
    lnkAccedi.Enabled:=False;

    // disabilita anche recupero password
    lnkRecuperaPassword.Enabled:=False;

    // ...
    //if Home <> '' then
    //  GGetWebApplicationThreadVar.Response.SendRedirect(Home);
  end;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - inizio metodo');

  // esce subito se la sessione è terminata (W001 è la main form, per cui viene comunque creata)
  if GGetWebApplicationThreadVar.Terminated then
    Exit;

  inherited;

  //Gestione eventuale pagina di manutenzione
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - gestione pagina di manutenzione');
  ParURLMan:=W000ParConfig.UrlManutenzione;
  if Trim(ParURLMan) <> '' then
  begin
    if Pos('http', LowerCase(ParURLMan)) > 0 then
      GGetWebApplicationThreadVar.Response.SendRedirect(AnsiString(ParURLMan))
    else
    begin
      edtAzienda.Visible:=False;
      edtUtente.Visible:=False;
      edtPassword.Visible:=False;
      edtDatabase.Visible:=False;
      edtNomeProfilo.Visible:=False;
      cmbNomeProfilo.Visible:=False;
      lblUtente.Css:='MsgManutenzione';
      lblUtente.Left:=(Self.Width div 2) - (lblUtente.Width div 2);
      lblUtente.Caption:=ParURLMan;
      lblAzienda.Visible:=False;
      lblPassword.Visible:=False;
      lblDatabase.Visible:=False;
      lblNomeProfilo.Visible:=False;
      btnAccedi.Visible:=False;
      lnkAccedi.Visible:=False;
      lnkRecuperaPassword.Visible:=False;
    end;
  end;

  // lettura parametri
  ListaPar:=nil;
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - lettura parametri');
  if GGetWebApplicationThreadVar.RunParams.Count >= 1 then
  begin
    // parametri passati con metodi propri di intraweb
    ListaPar:=GGetWebApplicationThreadVar.RunParams;
  end
  else if GGetWebApplicationThreadVar.Request.ContentFields.Count >= 1 then
  begin
    // metodo POST
    ListaPar:=GGetWebApplicationThreadVar.Request.ContentFields;
  end
  else if GGetWebApplicationThreadVar.Request.QueryFields.Count >= 1 then
  begin
    // metodo GET
    ListaPar:=GGetWebApplicationThreadVar.Request.QueryFields;
  end
  else
  begin
    // HEADER HTTP personalizzati
    ListaPar:=GGetWebApplicationThreadVar.Request.RawHeaders;
  end;

  // salva i parametri in variabili
  if Assigned(ListaPar) then
  begin

    if (Pos(INI_PAR_SECURITY_ENABLE_XSS_PROTECTION,W000ParConfig.ParametriAvanzati) > 0) then
    begin
      for i:=0 to ListaPar.Count - 1 do
      begin
        ListaPar[i]:=R180PulisciStringaPerInjection(ListaPar[i]);
      end;
    end;

    // parametri comuni a tutte le installazioni
    ParAzienda:=ListaPar.Values['azienda'];
    ParUsr:=ListaPar.Values['usr'];
    ParPwd:=ListaPar.Values['pwd'];
    ParProfilo:=ListaPar.Values['profilo'];
    ParDatabase:=ListaPar.Values['database'];
    ParLoginEsterno:=ListaPar.Values['loginesterno'];
    ParHome:=ListaPar.Values['home'];
    ParWSAuth:=ListaPar.Values['wsauth'];
    WR000DM.PaginaIniziale:=IfThen(ListaPar.Values['startpage'] <> '',ListaPar.Values['startpage'],W000ParConfig.PaginaIniziale);
    WR000DM.PaginaSingola:=IfThen(ListaPar.Values['singlepage'] <> '',ListaPar.Values['singlepage'],W000ParConfig.PaginaSingola);

    // SSO roma_hsantandrea
    ParTicket:=ListaPar.Values['ticket'];

    // COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.ini
    // SSO como_hsanna
    ParUID:=ListaPar.Values['uid'];
    ParTime:=ListaPar.Values['time'];
    ParHash:=ListaPar.Values['hash'];
    // COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.fine

    // VENEZIA_IUAV.ini
    ParRemoteUser:='';
    for i:=0 to ListaPar.Count - 1 do
    begin
      STemp:=ListaPar[i];
      if STemp.StartsWith(Format('%s:',[PAR_REMOTE_USER_NAME]),True) then
      begin
        ParRemoteUser:=STemp.Substring(PAR_REMOTE_USER_NAME.Length + 1).Trim;
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - trovato remoteuser = ' + ParRemoteUser);
      end;
    end;
    // VENEZIA_IUAV.fine

    //chiamata da X002 (VILLAFALLETTO_PERARIA)
    if (ListaPar.Values['xusr'] <> '') or (ListaPar.Values['xusr64'] <> '') then
    begin
      if ListaPar.Values['xusr'] <> '' then
        ParUsr:=ListaPar.Values['xusr']
      else
      begin
        //il parametro xusr64 è codificato in base64, per cui deve prima essere decodificato per poi seguire il normale flusso di ParUsr
        ParUsr:=ListaPar.Values['xusr64'];
        Base64:=TBase64Encoding.Create(0);
        ParUsr:=Base64.Decode(ParUsr);
        Base64.Free;
      end;
      Parametri.CampiRiferimento.C90_SSO_RDLPassphrase:=A000SSO_RDLPassphrase;
      Parametri.CampiRiferimento.C90_SSO_UsrMask:=A000SSO_UsrMask;
      Parametri.CampiRiferimento.C90_SSO_TimeOut:='600';//10 minuti
    end;

    //Inizio gestione header x-forwarded-for
    ParForwardedFor:='';
    for i:=0 to ListaPar.Count - 1 do
    begin
      STemp:=ListaPar[i];
      if STemp.StartsWith(Format('%s:',['x-forwarded-for']),True) then
      begin
        ParForwardedFor:=STemp.Substring('x-forwarded-for'.Length + 1).Trim;
        Break;
      end;
    end;
    //Fine gestione header x-forwarded-for

    WR000DM.IpAddressClient:=IfThen(ParForwardedFor <> '',ParForwardedFor,ListaPar.Values['ipclient']);
    WR000DM.ClientName:=ListaPar.Values['clientname'];
  end;

  // gestione login esterno e abilitazione campi
  LoginEsterno:=IfThen(ParLoginEsterno <> '',ParLoginEsterno,W000ParConfig.LoginEsterno);
  edtAzienda.Enabled:=(LoginEsterno = 'N');
  edtUtente.Enabled:=(LoginEsterno = 'N');
  edtPassword.Enabled:=(LoginEsterno = 'N');
  edtNomeProfilo.Enabled:=(LoginEsterno = 'N');
  edtDatabase.Enabled:=(LoginEsterno = 'N');

  // segnalazione di login in corso
  if LoginEsterno = 'S' then
    JavascriptBottom.Add('document.write("<div id=\"loginInProgress\">' + A000TraduzioneStringhe(A000MSG_MSG_ACCESSO_IN_CORSO) + '</div>");')
  else
    JavascriptBottom.Add('document.getElementById("loginForm").className = "";');

  // impostazione dati login
  // Nota: i parametri via http sovrascrivono le impostazioni di default su registro
  edtAzienda.Text:=IfThen(ParAzienda <> '',ParAzienda,W000ParConfig.Azienda);
  edtUtente.Text:=ParUsr;
  edtPassword.Text:=ParPwd;
  edtNomeProfilo.Text:=IfThen(ParProfilo <> '',ParProfilo,W000ParConfig.Profilo);
  edtDatabase.Text:=IfThen(ParDatabase <> '',ParDatabase,W000ParConfig.Database);
  {$WARN SYMBOL_PLATFORM OFF}
  ScriviDatabase:=((ParDatabase = '') and (W000ParConfig.Database = '')) or (DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  (GGetWebApplicationThreadVar.Data as TSessioneWeb).HomeUrl:=ConvertiHomeUrl(IfThen(ParHome <> '',ParHome,W000ParConfig.Home));
  //UrlWSAuth:=IfThen(ParWSAuth <> '',ParWSAuth,W000ParConfig.UrlWSAutenticazione);

  if (LoginEsterno = 'S') and ((ParUsr <> '') or (ParUID <> '')) and (ListaPar.Values['xusr'] = '') and (ListaPar.Values['xusr64'] = '') then
    //lettura parametri aziendali sso a meno che non stia gestendo xusr: in tal caso i parametri sso sono fissati internamente
    WR000DM.GetParametriSSO(edtAzienda.Text,edtDatabase.Text);

  Risposta.Utente:='';
  Risposta.Profilo:='';

  //Ticket + WebService SOAP: Engi ROMA_HSANTANDREA - BOLOGNA_ERGO - SSO.ini
  if ParTicket <> '' then
  begin
    // gestione del ticket
    try
      AutSSO:=WR000DM.SSOTicket(ParTicket,IfThen(ParWSAuth <> '',ParWSAuth,W000ParConfig.UrlWSAutenticazione),Anomalia,Risposta);
    except
      on E:Exception do
      begin
        AutSSO:=False;
        Anomalia:=E.Message;
      end;
    end;
    // ticket autorizzato -> accesso con nuovi parametri
    if AutSSO then
    begin
      SSORedirect;
      exit;
    end
    else
    begin
      SSOVisualizzaAnomalia(Anomalia);
      Exit;
    end;
  end
  // ROMA_HSANTANDREA.fine

  // COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.ini
  // implementazione sso per como_hsanna
  else if ParUID <> '' then
  begin
    // gestione del sso via confronto stringa sha1
    try
      AutSSO:=WR000DM.SSOSha1(ParUID,ParTime,ParHash,Anomalia,Risposta);//WR000DM.SSOComo(ParUID,ParTime,ParHash,Anomalia,Risposta);
    except
      on E:Exception do
      begin
        AutSSO:=False;
        Anomalia:=E.Message;
      end;
    end;

    // utente autorizzato -> accesso con nuovi parametri
    if AutSSO then
    begin
      edtUtente.Text:=Risposta.Utente;
    end
    else
    begin
      SSOVisualizzaAnomalia('Autenticazione con SSO fallita: ' + Anomalia);
      Exit;
    end;
  end
  // COMO_HSANNA.fine

  // ADS - Token criptato in RDL ECB
  else if (ParUsr <> '') and (Parametri.CampiRiferimento.C90_SSO_RDLPassphrase <> '') (*and (ParProfilo = '')*) then
  begin
    AutSSO:=WR000DM.SSORdl(ParUsr,Anomalia,Risposta);//SSOAds('CcFq1RCXLKuLAGFhFmtStzW3N5f0DBlGk9OmmLtTmcA=    ',Anomalia,Risposta);
    edtUtente.Text:=Risposta.Utente;
    if not AutSSO then
    begin
      SSOVisualizzaAnomalia('Autenticazione con SSO fallita: ' + Anomalia);
      Exit;
    end;
  end
  // ADS.FINE

  // VENEZIA_IUAV.ini
  else if ParRemoteUser <> '' then
  begin
    // l'utente è indicato nel parametro
    edtUtente.Text:=ParRemoteUser;
  end;
  // VENEZIA_IUAV.fine

  // avvio automatico login
  if (edtAzienda.Text <> '') and (edtUtente.Text <> '') then
  begin
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - avvio automatico login');
    AddToInitProc(Format('SubmitClickConfirm("%s","",true,"");',[lnkAccedi.HTMLName]));
  end;

  // gestione login esterno
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - gestione login esterno');
  if (LoginEsterno = 'S') and
     ((edtAzienda.Text = '') or (edtUtente.Text = '')) then
  begin
    Log('Traccia','Login esterno - uscita forzata: ' +
        IfThen(edtAzienda.Text = '','azienda non indicata;') +
        IfThen(edtUtente.Text = '','utente non indicato;'));
    edtAzienda.Required:=False;
    edtUtente.Required:=False;
    AddToInitProc(Format('SubmitClickConfirm("%s","",true,"");',[lnkEsci.HTMLName]));
  end;

  TraduzionePagina;

  // visibilità link di recupero password
  lnkRecuperaPassword.Visible:=(LoginEsterno <> 'S') and
                               (Pos(INI_PAR_RECUPERO_PASSWORD,W000ParConfig.ParametriAvanzati) > 0) and
                               (btnAccedi.Visible);

  //abilito ReCAPTCHA solo se richiesto da parametro su file di configurazione
  if RichiestoReCAPTCHA then
  begin
    if W000ParConfig.SiteKeyReCAPTCHA = '' then
      W000ParConfig.SiteKeyReCAPTCHA:='invalid';

    if W000ParConfig.SecretKeyReCAPTCHA = '' then
      W000ParConfig.SecretKeyReCAPTCHA:='invalid';

    lblReCAPTCHA.Visible:=True;
    VerifiedReCAPTCHA:=False;
    btnAccedi.Enabled:=False;
    //lnkRecuperaPassword.Enabled:=False; //qui mi crea l'elemento come span e quando lo abilito non funziona!!!
    ExtraHeader.Add('<script src="https://www.google.com/recaptcha/api.js"></script>');
    lblReCAPTCHA.Caption:='<div id="' + lblReCAPTCHA.HTMLName + '_recaptcha" class="g-recaptcha" data-sitekey="' + W000ParConfig.SiteKeyReCAPTCHA + '" data-callback="ReCAPTCHA_OnCallBack" data-expired-callback="ReCAPTCHA_OnCallBackExpired"></div>';
    Self.RegistraMetodoAJAX('ReCAPTCHA_OnCallBack',ReCAPTCHA_OnCallBack);
    Self.RegistraMetodoAJAX('ReCAPTCHA_OnCallBackExpired',ReCAPTCHA_OnCallBackExpired);
  end;

  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - fine metodo');
end;

procedure TW001FLogin.TraduzionePagina;
var
  Lingua: String;
  i,nsl: Integer;
begin
  // gestione traduzione
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - inizio metodo');
  if (Pos(INI_PAR_TRADUZIONE_CAPTION,W000ParConfig.ParametriAvanzati) > 0) and
     (LoginEsterno = 'N') and
     (edtAzienda.Text <> '') and
     (edtDatabase.Text <> '') then
  begin
    Lingua:='INGLESE';
    if W001FPasswordDtM = nil then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM: chiamata al costruttore');
      W001FPasswordDtM:=TA001FPasswordDtM1.Create((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM: creazione terminata');
    end;
    nsl:=-1;
    try
      W001FPasswordDtM.EseguiCheckConnection:=Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0;
      WR000DM.W001FPasswordDtM:=W001FPasswordDtM;
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - WR000DM.GetSessioneLogin(' + edtDatabase.Text + '): invocata');
      nsl:=WR000DM.GetSessioneLogin(edtDatabase.Text);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - WR000DM.GetSessioneLogin(' + edtDatabase.Text + '): terminata');
      if nsl = -1 then
        Abort;

      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: attesa per Enter');
      CSSessioneMondoEDP.Enter;
      try
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM.InizializzazioneSessione(' + edtDatabase.Text + '): invocata');
          W001FPasswordDtM.InizializzazioneSessione(edtDatabase.Text);
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM.InizializzazioneSessione(' + edtDatabase.Text + '): terminata');
      finally
        CSSessioneMondoEDP.Leave;
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: Leave effettuata');
      end;
      
      (**)
      with WR000DM do
      begin
        Parametri.CampiRiferimento.C90_Lingua:=Lingua;
        // utilizzo di clientdataset per localizzazione
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - selI015: inizio gestione');
        selI015.SetVariable('AZIENDA',edtAzienda.Text);
        selI015.SetVariable('LINGUA',UpperCase(Parametri.CampiRiferimento.C90_Lingua));
        selI015.SetVariable('APPLICAZIONE','W000');
        selI015.Session:=(lstSessioniMondoEDP[nsl] as TOracleSession);
        try
          selI015.Open;
          cdsI015.Close;
          cdsI015.FieldDefs.Assign(selI015.FieldDefs);
          cdsI015.FieldDefs.Find('CAPTION').Required:=False;
          cdsI015.CreateDataSet;
          cdsI015.LogChanges:=False;
          cdsI015.IndexDefs.Clear;
          cdsI015.IndexDefs.Add('Primario',('LINGUA;APPLICAZIONE;MASCHERA'),[]);
          selI015.First;
          while not selI015.Eof do
          begin
            cdsI015.Append;
            for i:=0 to selI015.FieldCount - 1 do
              cdsI015.Fields[i].Value:=selI015.Fields[i].Value;
            cdsI015.Post;
            selI015.Next;
          end;
          if cdsI015.RecordCOunt > 0 then
            Parametri.cdsI015:=cdsI015;
        except
        end;
        selI015.CloseAll;
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - selI015: fine gestione');
      end;
    finally
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM: inizio distruzione');
      FreeAndNil(W001FPasswordDtM);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM: fine distruzione');

      if nsl >= 0 then
      begin
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: attesa per Enter');
        CSSessioneMondoEDP.Enter;
        try
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: dentro la critical section');
          (lstSessioniMondoEDP[nsl] as TOracleSession).Tag:=max(1,(lstSessioniMondoEDP[nsl] as TOracleSession).Tag) - 1;
        finally
          CSSessioneMondoEDP.Leave;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: Leave effettuata');
        end;
      end;
    end;
  end;
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - fine metodo');
end;

procedure TW001FLogin.IWAppFormRefreshForm(Sender: TObject);
begin
  inherited;
  if RichiestoReCAPTCHA then
  begin
    btnAccedi.Enabled:=False;
    VerifiedReCAPTCHA:=False;
  end;
end;

procedure TW001FLogin.IWAppFormRender(Sender: TObject);
var idx:Integer;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormRender - inizio metodo');
  inherited;

  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.ini
  // se necessario forza visibilità campo azienda (e relativa label)
  // rimuove anche i campi dalla lista dei componenti invisibili
  if ForzaAziendaVisibile then
  begin
    // ripristina css per azienda e label relativa
    lblAzienda.Css:='intestazione';
    edtAzienda.Css:='width20chr spazio_sx';
    idx:=WR000DM.lstCompInvisibili.IndexOf(UpperCase(Self.Name + '.' + lblAzienda.Name));
    if idx >= 0 then
      WR000DM.lstCompInvisibili.Delete(idx);
    idx:=WR000DM.lstCompInvisibili.IndexOf(UpperCase(Self.Name + '.' + edtAzienda.Name));
    if idx >= 0 then
      WR000DM.lstCompInvisibili.Delete(idx);
  end;
  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.fine

  // focus sul primo campo non valorizzato
  if LoginEsterno <> 'S' then
  begin
    if (edtAzienda.Visible) and (not edtAzienda.Css.Contains('invisibile')) and (edtAzienda.Text = '') then
      Self.ActiveControl:=edtAzienda
    else if (edtUtente.Visible) and (not edtUtente.Css.Contains('invisibile')) and (edtUtente.Text = '') then
      Self.ActiveControl:=edtUtente
    else if (edtPassword.Visible) and (not edtPassword.Css.Contains('invisibile')) and (edtPassword.Text = '') then
      Self.ActiveControl:=edtPassword
    else if (edtNomeProfilo.Visible) and (not edtNomeProfilo.Css.Contains('invisibile')) and (edtNomeProfilo.Text = '') then
      Self.ActiveControl:=edtNomeProfilo
    else if (cmbNomeProfilo.Visible) and (not cmbNomeProfilo.Css.Contains('invisibile')) and (cmbNomeProfilo.Text = '') then
      Self.ActiveControl:=cmbNomeProfilo
    else if (edtDatabase.Visible) and (not edtDatabase.Css.Contains('invisibile')) and (edtDatabase.Text = '') then
      Self.ActiveControl:=edtDatabase;
  end;
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormRender - fine metodo');
end;

procedure TW001FLogin.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 14 OK }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormAfterRender - inizio metodo');
    inherited;
    RimuoviNotifiche;
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormAfterRender - fine metodo');
  end;
end;

function TW001FLogin.ConvertiHomeUrl(const PHome: String): String;
var
  ParUrlBase,Risultato: String;
begin
  Risultato:=PHome;

  // sostituzione variabili
  if Pos('(URLBASE)',Risultato) > 0 then
  begin
    // URLBASE = directory base applicazione
    ParUrlBase:=StringReplace(GGetWebApplicationThreadVar.AppURLBase,'/W000PIrisWEB_IIS.dll','',[rfIgnoreCase]);
    Risultato:=StringReplace(Risultato,'(URLBASE)',ParUrlBase,[rfIgnoreCase]);
  end;

  Result:=Risultato;
end;

procedure TW001FLogin.lnkAccediClick(Sender: TObject);
var
  W002:TW002FRicercaAnagrafe;
  WC023: TWC023FCambioPasswordFM;
  Sysdate:TDateTime;
  PwdScaduta,CSEnter,AuthDom:Boolean;
  ValProfilo,ElencoAziende,locDom,locPassword:String;
  ns,nsl:Integer;
  IniFile: TIniFile;
  SuffissoLDAP: string;

  function RichiediPassword:Boolean;
  begin
    Result:=True;
    if Parametri.CampiRiferimento.C90_SSO_RDLPassphrase <> '' then
      //In questo caso usr è passato criptato
      Result:=False;
    if (Parametri.CampiRiferimento.C90_SSO_SHA1Passphrase <> '') and (ParUID <> '') then
      Result:=False;
    if (Parametri.CampiRiferimento.C90_SSO_SHA1Passphrase = '') and (ParUID = '') then
      Result:=False;
  end;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - inizio metodo');

  // per sicurezza esco se ReCAPTCHA è richiesto e non è verificato
  if RichiestoReCAPTCHA and not VerifiedReCAPTCHA then
    Exit;

  nsl:=-1; // inizializzazione
  TRY
    //Autenticazione
    AuthDom:=False;
    if W001FPasswordDtM = nil then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM: chiamata al costruttore');
      W001FPasswordDtM:=TA001FPasswordDtM1.Create((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM: creazione terminata');
    end;
    try
      W001FPasswordDtM.EseguiCheckConnection:=Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0;
      WR000DM.W001FPasswordDtM:=W001FPasswordDtM;
      with W001FPasswordDtM do
      begin
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - GetSessioneLogin: invocato');
        nsl:=WR000DM.GetSessioneLogin(edtDatabase.Text);
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - GetSessioneLogin: terminato');
        Log('Sessione','GetSessioneLogin');
        if nsl = -1 then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_CONN_FALLITA));
          Abort;
        end;
        PwdScaduta:=False;
        try
          //Verifica alias databaseedtDatabase.Text
          if (Pos(INI_PAR_SECURITY_ENABLE_XSS_PROTECTION,W000ParConfig.ParametriAvanzati) > 0) then
            edtDatabase.Text:=R180PulisciStringaPerInjection(Trim(edtDatabase.Text))
          else
            edtDatabase.Text:=Trim(edtDatabase.Text);
          if not A001FPassWordDtM1.TestDBAlias(edtDatabase.Text) then
          begin
            edtDatabase.SetFocus;
            raise Exception.Create(A000TraduzioneStringhe(Format(A000MSG_ERR_ALIAS_DB_ERRATO,[edtDatabase.Text])));
          end;
          CSEnter:=False;
          if (Pos(INI_PAR_NO_SHARED_LOGIN,W000ParConfig.ParametriAvanzati) = 0) and
             (not W001FPasswordDtM.SessioneMondoEDP.Connected) then
          begin
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: attesa per Enter');
            CSSessioneMondoEDP.Enter;
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: dentro la critical section');
            CSEnter:=True;
          end;
          try
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - InizializzazioneSessione(' + edtDatabase.Text + '): invocato');
            InizializzazioneSessione(edtDatabase.Text);
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - InizializzazioneSessione(' + edtDatabase.Text + '): terminato');
          finally
            if CSEnter then
            begin
              CSSessioneMondoEDP.Leave;
              DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: Leave effettuata');
            end;
          end;
        except
          on E:Exception do
          begin
            Log('Errore','InizializzazioneSessione Respinta',E);
            GGetWebApplicationThreadVar.ShowMessage(Format('Errore durante l''inizializzazione della sessione di database:'#13#10'%s (%s)',[E.Message,E.ClassName]));
            Abort;
          end;
        end;
        Log('Sessione','SessioneLogin:' + IntToStr(nsl) + '/' + IntToStr(W001FPasswordDtM.SessioneMondoEDP.Tag));
        if ScriviDatabase then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSParConfig: attesa per Enter');
          CSParConfig.Enter;
          try
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSParConfig: dentro la critical section');
            { DONE : TEST IW 14 OK }
            IniFile:=TIniFile.Create(IncludeTrailingPathDelim(gsAppPath) + FILE_CONFIG);
            try
              IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_DATABASE,edtDatabase.Text);
            finally
              FreeAndNil(IniFile);
            end;
          finally
            CSParConfig.Leave;
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSParConfig: Leave effettuata');
          end;
        end;

        // richiesta indicazione nome utente
        if edtUtente.Text = '' then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_NON_INDICATO));
          edtUtente.SetFocus;
          raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_NON_INDICATO));
        end;

        // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.ini
        // in fase di login interattivo, se l'azienda non viene indicata,
        // il programma cerca di individuarla utilizzando solo il nome utente,
        // ricercando su I060 per le aziende con LOGIN_DIP_ABILITATO = 'S'
        // e su I070 per le aziende con LOGIN_USR_ABILITATO = 'S'
        ForzaAziendaVisibile:=False;
        if (LoginEsterno <> 'S') and (edtAzienda.Text = '') then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - ricerca automatica azienda iniziata');
          // azienda non indicata: ricerca tramite nome utente
          // estrae l'elenco delle aziende
          selDistAzienda.Close;
          selDistAzienda.ClearVariables;
          selDistAzienda.SetVariable('UTENTE',edtUtente.Text);
          selDistAzienda.SetVariable('I060','S');
          selDistAzienda.Open;
          // casi da gestire:
          // 0   record -> errore utente inesistente
          // 1   record -> ok (si rifà alla gestione precedente)
          // N>1 record -> proporre lista aziende da selezionare
          if selDistAzienda.RecordCount = 0 then
          begin
            // TORINO_CITTADELLASALUTE - chiamata 81857.ini
            // nel caso in cui l'utente non venga trovato nelle aziende con il riconoscimento automatico
            // dare il messaggio di utente inesistente
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
            ActiveControl:=edtUtente;
            raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
            {
            // ricerca azienda fallita -> chiede all'utente di indicare l'azienda
            // nel caso in cui l'azienda fosse non visibile, ne forza la visibilità
            ForzaAziendaVisibile:=True;
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_NON_INDICATA));
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_NON_INDICATA));
            }
            // TORINO_CITTADELLASALUTE - chiamata 81857.fine
          end
          else if selDistAzienda.RecordCount = 1 then
          begin
            // imposta l'azienda individuata
            edtAzienda.Text:=selDistAzienda.FieldByName('AZIENDA').AsString;
          end
          else if selDistAzienda.RecordCount > 1 then
          begin
            // il nome utente indicato è presente in più aziende:
            // propone la lista delle aziende da scegliere
            // nel caso in cui l'azienda fosse non visibile, ne forza la visibilità
            ForzaAziendaVisibile:=True;
            ElencoAziende:='';
            selDistAzienda.First;
            while not selDistAzienda.Eof do
            begin
              ElencoAziende:=ElencoAziende + selDistAzienda.FieldByName('AZIENDA').AsString.QuotedString + ',';
              selDistAzienda.Next;
            end;
            jqAutocomplete.OnReady.Text:=
              'var elementi = [' + ElencoAziende.Substring(0,ElencoAziende.Length - 1) + '];' + CRLF +
              '$("#' + edtAzienda.HTMLName + '").autocomplete({' + CRLF +
              '  source: elementi,' + CRLF +
              '  delay: 0,' + CRLF +
              '  minLength: 0' + CRLF +
              '}).focus(function(){ ' + CRLF +
              '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
              '}); ';
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_MSG_SEL_AZIENDA));
          end;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - ricerca automatica azienda terminata');
        end;
        // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.fine

        // azienda indicata: ricerca su database per estrarre informazioni
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - estrazione dati azienda');
        QI090.Close;
        QI090.SetVariable('Azienda',edtAzienda.Text);
        QI090.Open;
        if QI090.RecordCount = 0 then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_INESISTENTE));
          ActiveControl:=edtAzienda;
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_INESISTENTE));
        end
        else
          edtAzienda.Text:=QI090.FieldByName('AZIENDA').AsString;

        // salva parametri del dominio di autenticazione
        Parametri.AuthDomInfo.DominioDip:=QI090.FieldByName('DOMINIO_DIP').AsString;
        Parametri.AuthDomInfo.DominioDipTipo:=QI090.FieldByName('DOMINIO_DIP_TIPO').AsString;
        Parametri.AuthDomInfo.DominioUsr:=QI090.FieldByName('DOMINIO_USR').AsString;
        Parametri.AuthDomInfo.DominioUsrTipo:=QI090.FieldByName('DOMINIO_USR_TIPO').AsString;

        // ricerca record con lo username indicato
        // su I070 (supervisore) e su I060 (dipendente)
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - ricerca utente in I070 e I060');

        //Verifico se esiste il nome utente così come scritto
        OpenI060I070(['I060','I070'], edtUtente.Text);
        if (QI060.RecordCount = 0) and (GetSuffissoLDAP('I060') <> '') then
        begin //Ricerca con suffisso LDAP su I060
          SuffissoLDAP:=GetSuffissoLDAP('I060');
          //Anche se è stato trovato l'utente su I070 verifico se esiste su I060 con/senza suffisso.
          //In tal caso deve prevalere il profilo su I060
          if Uppercase(edtUtente.Text).IndexOf(UpperCase(SuffissoLDAP)) > 0 then
          begin
            //Verifico se esiste il nome utente senza il suffisso
            OpenI060I070(['I060'], StringReplace(edtUtente.Text, SuffissoLDAP, '', [rfReplaceAll, rfIgnoreCase]));
            if QI060.RecordCount > 0 then
              edtUtente.Text:=StringReplace(edtUtente.Text, SuffissoLDAP, '', [rfReplaceAll, rfIgnoreCase]);
          end
          else
          begin
            //Verifico se esiste il nome utente con il suffisso
            OpenI060I070(['I060'], edtUtente.Text + SuffissoLDAP);
            if QI060.RecordCount > 0 then
            begin
              edtUtente.Text:=edtUtente.Text + SuffissoLDAP;
              SuffissoLDAP:='';
            end;
          end;
        end;

        (* Se si vorrà estendere l'applicazione del suffisso anche su I070:
        if (QI060.RecordCount = 0) and (QI070.RecordCount = 0) and (GetSuffissoLDAP('I070') <> '') then
        begin
          ApplicoSuffisso(I070);//OpenI070...
        end;*)

        WR000DM.EsisteUtenteI070:=QI070.RecordCount > 0;
        // ricerca user fallita -> messaggio di errore
        if (QI070.RecordCount = 0) and (QI060.RecordCount = 0) then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
          ActiveControl:=edtUtente;
          raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
        end;

        if (QI070.RecordCount = 0) or (QI060.RecordCount > 0) then
        begin
          locPassword:=QI060.FieldByName('PassWord').AsString;
          // utente di irisweb
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione per utente web: iniziata');

          //Se viene usato l'alias NOME_UTENTE2, questo può essere autenticato solo nel dominio
          if (not QI090.FieldByName('DOMINIO_DIP').IsNull) and
             (UpperCase(edtUtente.Text) = UpperCase(QI060.FieldByName('Nome_Utente2').AsString)) then
          begin
            locPassword:='';
          end;
          //Alberto: autenticazione su dominio
          if (not QI090.FieldByName('DOMINIO_DIP').IsNull) and locPassword.IsEmpty and
             ((LoginEsterno = 'N') or RichiediPassword)
             //Nel caso di LoginEsterno = S, posso saltare il controllo se è attiva l'autenticazione SSORdl o SSOSha1 che prevedono un token a scadenza
          then
          begin
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione su dominio iniziata');
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: attesa per Enter');
            //MI_HSACCO: doppio dominio! ciclo sui domini separati da ';'
            AuthDom:=False;
            for locDom in QI090.FieldByName('DOMINIO_DIP').AsString.Split([';',',']) do
            begin
              CSAutenticazioneDominio.Enter;
              try
                DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: dentro la critical section');
                AuthDom:=AutenticazioneDominio(locDom, edtUtente.Text, edtPassword.Text, QI090.FieldByName('DOMINIO_DIP_TIPO').AsString, QI090.FieldByName('DOMINIO_LDAP_DN').AsString, SuffissoLDAP);
                Parametri.AuthDomInfo.DominioDip:=locDom;
                if AuthDom then
                  Break;
              finally
                CSAutenticazioneDominio.Leave;
                DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: Leave effettuata');
              end;
            end;
            if not AuthDom and ((edtPassword.Text = '') or (edtPassword.Text <> R180Decripta(locPassword,30011945))) then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
              ActiveControl:=edtUtente;
              raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA)); //Abort;
            end;
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione su dominio terminata');
          end
          //Fine autenticazione su dominio
          else if ((LoginEsterno = 'N') or RichiediPassword) and
                  (edtPassword.Text <> R180Decripta(locPassword,30011945)) then
          begin
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
            ActiveControl:=edtUtente;
            raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));       //
          end;

          //Registrazione parametri/inibizioni
          if edtNomeProfilo.Visible then
            ValProfilo:=edtNomeProfilo.Text
          else if cmbNomeProfilo.ItemIndex >= 0 then
            ValProfilo:=cmbNomeProfilo.Items[cmbNomeProfilo.ItemIndex]
          else if edtNomeProfilo.Text <> '' then
            ValProfilo:=edtNomeProfilo.Text;  // profilo specificato su registro - daniloc 09.03.2010
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioniInfo: iniziata');
          if Not RegistraInibizioniInfo(ValProfilo) then
          begin
            lblNomeProfilo.Css:='font_rosso';
            cmbNomeProfilo.Visible:=True;
            edtNomeProfilo.Visible:=False;
            cmbNomeProfilo.Items.Clear;
            selI061.First;
            while Not selI061.Eof do
            begin
              cmbNomeProfilo.Items.Add(selI061.FieldByName('NOME_PROFILO').AsString);
              selI061.Next;
            end;
            cmbNomeProfilo.ItemIndex:=0;
            if cmbNomeProfilo.Items.Count >= 1 then
            begin
              //raise Exception.Create(A000TraduzioneStringhe(A000MSG_MSG_SEL_PROFILO));
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_SEL_PROFILO));
              ActiveControl:=cmbNomeProfilo;
              Abort;
            end
            else
              raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PROFILO_NON_TROVATO));
          end;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioniInfo: terminata');

          // controllo lunghezza password (saltato se login esterno)
          if  (LoginEsterno = 'N')
          and (edtPassword.Text = '')
          //and (Parametri.LunghezzaPassword > 0)
          then
          begin
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_ACCESSO_NEGATO_NO_PSW));
            ActiveControl:=edtPassword;
            Abort;
          end;
          WR000DM.TipoUtente:='Dipendente';
          if Parametri.ProfiloFiltroAnagrafe = '' then
            GGetWebApplicationThreadVar.SessionTimeOut:=WR000DM.TimeoutDip
          else
            GGetWebApplicationThreadVar.SessionTimeOut:=WR000DM.TimeoutOper;
          A000SessioneWEB.TimeOutOriginale:=GGetWebApplicationThreadVar.SessionTimeOut;

          // controllo scadenza password (saltato se login esterno)
          Sysdate:=Trunc(R180Sysdate(QI090.Session));
          if (LoginEsterno = 'N') and
             (QI060.FindField('DATA_PW') <> nil) and
             (not AuthDom) then
            if ((Parametri.ValiditaPassword > 0) and
               (R180AddMesi(QI060.FieldByName('DATA_PW').AsDateTime,Parametri.ValiditaPassword) <= Sysdate)) or
               (QI060.FieldByName('DATA_PW').IsNull) then
              PwdScaduta:=True;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione per utente web: terminata');
        end
        else
        begin
          // utente di iriswin (supervisore)
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione per utente win: iniziata');
          //Autenticazione su dominio
          if (QI070.FieldByName('Utente').AsString <> 'SYSMAN') and
             (QI070.FieldByName('Utente').AsString <> 'MONDOEDP') and
             (not QI090.FieldByName('DOMINIO_USR').IsNull) then
          begin
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione su dominio iniziata');
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: attesa per Enter');
            //MI_HSACCO: doppio dominio! ciclo sui domini separati da ';'
            AuthDom:=False;
            for locDom in QI090.FieldByName('DOMINIO_USR').AsString.Split([';',',']) do
            begin
              CSAutenticazioneDominio.Enter;
              try
                DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: dentro la critical section');
                AuthDom:=AutenticazioneDominio(locDom, QI070.FieldByName('Utente').AsString, edtPassword.Text, QI090.FieldByName('DOMINIO_USR_TIPO').AsString, QI090.FieldByName('DOMINIO_LDAP_DN').AsString(*,SuffissoLDAP*));
                Parametri.AuthDomInfo.DominioUsr:=locDom;
                if AuthDom then
                  Break;
              finally
                CSAutenticazioneDominio.Leave;
                DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: Leave effettuata');
              end;
            end;
            if not AuthDom and ((edtPassword.Text = '') or (R180CriptaI070(edtPassword.Text) <> QI070.FieldByName('PassWd').AsString)) then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
              ActiveControl:=edtUtente;
              raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
            end;
          end
          //Fine autenticazione su dominio
          // verifica password
          else if ((LoginEsterno = 'N') or (R180In(QI070.FieldByName('Utente').AsString,['SYSMAN','MONDOEDP'])) and (Parametri.CampiRiferimento.C90_SSO_RDLPassphrase <> A000SSO_RDLPassphrase)) and
                   (R180CriptaI070(edtPassword.Text) <> QI070.FieldByName('PassWd').AsString) then
          begin
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
            ActiveControl:=edtUtente;
            raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
          end;

          //Registrazione parametri/inibizioni
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioni: iniziata');
          RegistraInibizioni;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioni: terminata');
          WR000DM.TipoUtente:='Supervisore';
          GGetWebApplicationThreadVar.SessionTimeOut:=WR000DM.TimeoutOper;
          A000SessioneWEB.TimeOutOriginale:=GGetWebApplicationThreadVar.SessionTimeOut;

          // controllo scadenza password (saltato se login esterno)
          Sysdate:=Trunc(R180Sysdate(QI090.Session));
          if (LoginEsterno = 'N') and
             (QI070.FindField('DATA_PW') <> nil) and
             (not AuthDom) then
            if (Parametri.ValiditaPassword > 0) and
               (R180AddMesi(QI070.FieldByName('DATA_PW').AsDateTime,Parametri.ValiditaPassword) <= Sysdate) then
              PwdScaduta:=True;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione per utente win: terminata');
        end;

        if Parametri.VersioneOracle = 0 then
          Parametri.VersioneOracle:=11;

        //IF FALSE THEN
        //Controllo allineamento versione db e versione applicativo
        if (Parametri.VersioneDB <> '') and (Parametri.VersionePJ <> Parametri.VersioneDB) then
        begin
          GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_MSG_ALLINEAMENTO_VERSIONE),[Parametri.VersioneDB,Parametri.VersionePJ]));
          Abort;
        end;

        Parametri.AuthDom:=AuthDom;
        if AuthDom then
          Parametri.PassOper:=edtPassword.Text;
        if WR000DM.TipoUtente = 'Supervisore' then
        begin
          //Verifica se il campo ACCESSO_NEGATO è N (significa che l'accesso è valido)
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - verifica ACCESSO_NEGATO: iniziata');
          if QI070.FindField('ACCESSO_NEGATO') <> nil then
          begin
            if QI070.FieldByName('ACCESSO_NEGATO').AsString = 'S' then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_ACCESSO_INIBITO));
              Abort;
            end;
          end;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - verifica ACCESSO_NEGATO: terminata');

          //Verifica se dall'ultimo accesso sono passati "VALID_UTENTE" mesi.In tal caso nega l'accesso
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - verifica scadenza password: iniziata');
          Sysdate:=Trunc(R180Sysdate(QI090.Session));
          if (QI070.FieldByName('Utente').AsString <> 'SYSMAN') and (QI070.FindField('DATA_ACCESSO') <> nil) then
            if (not QI070.FieldByName('DATA_ACCESSO').IsNull) and
               (QI090.FieldByName('VALID_UTENTE').AsInteger > 0) and
               (R180AddMesi(QI070.FieldByName('DATA_ACCESSO').AsDateTime,Parametri.ValiditaUtente) <= Sysdate) then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_USER_SCADUTA));
              Abort;
            end;
          //Testa il campo NUOVA_PASSWORD per vedere se l'utente deve cambiare la password
          if (not AuthDom) and (QI070.FindField('NUOVA_PASSWORD') <> nil) then
            if (Parametri.Applicazione <> '') and (QI070.FieldByName('NUOVA_PASSWORD').AsString = 'S') then
              PwdScaduta:=True;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - verifica scadenza password: terminata');
        end;
        if (WR000DM.TipoUtente = 'Supervisore') and (Parametri.Applicazione <> '') and (not PwdScaduta) then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - aggiornamento data accesso: iniziata');
          OperSQL.SQL.Clear;
          OperSQL.SQL.Add(Format('UPDATE I070_UTENTI SET NUOVA_PASSWORD = ''N'', DATA_ACCESSO = TRUNC(SYSDATE) WHERE AZIENDA = ''%s'' AND UTENTE = ''%s''',[QI090.FieldByName('Azienda').AsString,QI070.FieldByName('Utente').AsString]));
          OperSQL.Execute;
          OperSQL.Session.Commit;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - aggiornamento data accesso: terminata');
        end;
      end;
    finally
      try
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM: distruzione con FreeAndNil iniziata');
        if W001FPasswordDtM <> nil then
          FreeAndNil(W001FPasswordDtM);
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM: distruzione con FreeAndNil terminata');
        //Se la sessione oracle di autenticazione è condivisa,
        //diminuisco il tag per indicare che non è più in uso da questa sessione web
        if (nsl >= 0) and
           (Pos(INI_PAR_NO_SHARED_LOGIN,W000ParConfig.ParametriAvanzati) = 0) then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: attesa per Enter');
          CSSessioneMondoEDP.Enter;
          try
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: dentro la critical section');
            (lstSessioniMondoEDP[nsl] as TOracleSession).Tag:=max(1,(lstSessioniMondoEDP[nsl] as TOracleSession).Tag) - 1;
          finally
            CSSessioneMondoEDP.Leave;
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: Leave effettuata');
          end;
        end
        else if (nsl >= 0) and
                (Pos(INI_PAR_NO_SHARED_LOGIN,W000ParConfig.ParametriAvanzati) > 0) then
        begin
          //Se sessione di login non condivisa, la chiudo
          (lstSessioniMondoEDP[nsl] as TOracleSession).Logoff;
        end;
      except
        on E:Exception do
          Log('Errore',Format('Azienda:%s - Utente:%s ' + CRLF + 'Errore in fase di accesso',[edtAzienda.Text, edtUtente.Text]),E);
      end;
    end;
    //Fine Autenticazione

    //Ricerca e inizializzazione di SessioneOracle
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.GetSessioneLavoro: invocato');
    ns:=WR000DM.GetSessioneLavoro;
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.GetSessioneLavoro: terminato');
    Log('Sessione','GetSessioneLavoro');

    // registra accesso sui log
    Log('Accesso','Login utente ' + WR000DM.TipoUtente + ': ' + Parametri.Operatore);

    QueryPK1.Session:=SessioneOracle;
    RegistraLog.Session:=SessioneOracle;
    //Caratto 15/04/2013 Imposto sessione oracle corretta. Non uso la funzione RegistraMsg perchè mi restituirebbe il A000RegistraMsg
    ((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.RegistraMsg as TRegistraMsg).SessioneOracleApp:=SessioneOracle;
    RegistraMsgSessione.IniziaMessaggio(medpCodiceForm);

    // registra accesso sui log
    RegistraLog.SettaProprieta('A','','W001',nil,True);
    RegistraLog.InserisciDato('APPLICATIVO','',TPath.GetFileName(GetModuleName(HInstance)).ToUpper);
    RegistraLog.InserisciDato('TIPOUTENTE','',WR000DM.TipoUtente);
    RegistraLog.InserisciDato('OPERATORE','',Parametri.Operatore);
    RegistraLog.InserisciDato('PROFILO','',Parametri.ProfiloWEB);
    RegistraLog.InserisciDato('TIPO','','ACCESSO');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;

    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.DataModuleCreate: invocato');
    WR000DM.DataModuleCreate(nil);
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.DataModuleCreate: terminato');
    Log('Sessione','SessioneORACLE:' + IntToStr(ns) + ';SessioneWEB:' + IntToStr(SessioneOracle.Tag));

    //Inizializzazione del datamodule
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.InizializzazioneW001DtM: invocato');
    Log('Traccia','InizializzazioneW001DtM: inizio');
    WR000DM.InizializzazioneW001DtM;
    Log('Traccia','InizializzazioneW001DtM completata');
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.InizializzazioneW001DtM: terminato');

    if PwdScaduta then
    begin
      Log('Traccia','Password scaduta: gestione');
      WC023:=TWC023FCambioPasswordFM.Create(GGetWebApplicationThreadVar);
      //TODO WC023.MessaggioStatus(ESCLAMA,A000TraduzioneStringhe(A000MSG_MSG_PSW_SCADUTA));
      WC023.lblEMailAziendale.Visible:=False;
      WC023.edtEMailAziendale.Visible:=False;
      WC023.lblEMailPEC.Visible:=False;
      WC023.edtEMailPEC.Visible:=False;
      WC023.lblRicMail.Visible:=False;
      WC023.chkRicMail.Visible:=False;
      WC023.lblCellulareAziendale.Visible:=False;
      WC023.edtCellulareAziendale.Visible:=False;
      WC023.lblCellularePersonale.Visible:=False;
      WC023.edtCellularePersonale.Visible:=False;
      WC023.lblEMailPersonale.Visible:=False;
      WC023.edtEMailPersonale.Visible:=False;
      //WC023.btnAnnulla.Visible:=False;
      WC023.Visualizza;
      Exit;
    end;

    Log('Traccia','Determina accesso diretto valutatore');
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.AccessoValutatore: invocato');
    WR000DM.AccessoDirettoValutatore:=WR000DM.AccessoValutatore;
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.AccessoValutatore: terminato');

    // registra data e ora di accesso su I060 se dipendente
    if WR000DM.TipoUtente = 'Dipendente' then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - registrazione accesso dipendente: iniziato');
      Log('Traccia','Registrazione accesso dipendente');
      with WR000DM.updI061UltimoAccesso do
      begin
        SetVariable('AZIENDA',Parametri.Azienda);
        SetVariable('NOME_UTENTE',Parametri.Operatore);
        SetVariable('NOME_PROFILO',Parametri.ProfiloWEB);
        Execute;
        SessioneOracle.Commit;
      end;
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - registrazione accesso dipendente: terminato');

      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - impostazione parametri progressivo e matricola: iniziato');
      Log('Traccia','Impostazione progressivo e matricola dipendente');
      with TOracleDataSet.Create(nil) do
      try
        Session:=SessioneOracle;
        SQL.Text:=Format('select PROGRESSIVO,MATRICOLA,CODFISCALE from T030_ANAGRAFICO where MATRICOLA = (select MATRICOLA from MONDOEDP.I060_LOGIN_DIPENDENTE where AZIENDA = ''%s'' and NOME_UTENTE = ''%s'')',[Parametri.Azienda,AggiungiApice(Parametri.Operatore)]);
        Open;
        if RecordCount > 0 then
        begin
          Parametri.ProgressivoOper:=FieldByName('PROGRESSIVO').AsInteger;
          Parametri.MatricolaOper:=FieldByName('MATRICOLA').AsString;
          Parametri.CodFiscaleOper:=FieldByName('CODFISCALE').AsString;
        end;
      finally
        Free;
      end;
      Parametri.Inibizioni.Text:=StringReplace(Parametri.Inibizioni.Text,'<PROGRESSIVO_UTENTE>',Parametri.ProgressivoOper.ToString,[rfIgnoreCase]);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - impostazione parametri progressivo e matricola: terminato');
    end;

    // legge le abilitazioni dei moduli irisweb da FunzioniDisponibili
    Log('Traccia','Lettura abilitazioni');
    GetAbilitazioniModuli;

    // effettua automaticamente la ricerca dei dipendenti in base al filtro anagrafe
    // anche per l'operatore iriswin (supervisore)
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002: invocato costruttore');
    W002:=TW002FRicercaAnagrafe.Create(GGetWebApplicationThreadVar);
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002: creazione terminata');
    if WR000DM.AccessoDirettoValutatore <> 'N' then
      W002.VisualizzaCessati:=True
    else
      W002.VisualizzaCessati:=Parametri.InibizioneIndividuale;

    // se utente supervisore e filtro anagrafe non indicato richiede i criteri di ricerca
    if ((WR000DM.TipoUtente = 'Supervisore') and (Parametri.Inibizioni.Text = '') and (WR000DM.AccessoDirettoValutatore = 'N'))
       or
       ((WR000DM.TipoUtente = 'Dipendente') and (Parametri.Inibizioni.Text <> '') and (Parametri.SelezioneRichiestaPortale)) then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002.OpenPage: invocato');
      W002.OpenPage;
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002.OpenPage: terminato');
    end
    else
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002.btnRicercaTopClick invocato');
      W002.TipoRicerca:='';
      W002.btnRicercaTopClick(Self);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002.btnRicercaTopClick terminato');
    end;
  EXCEPT
    on E:Exception do
    begin
      if (not (E is EAbort)) and
         (E.Message <> A000TraduzioneStringhe(A000MSG_MSG_SEL_PROFILO)) and
         (E.Message <> A000TraduzioneStringhe(A000MSG_ERR_PROFILO_NON_TROVATO)) then
      begin
        Log('Errore',Format('Azienda:%s - Utente:%s ' + CRLF + 'Errore in fase di accesso',[edtAzienda.Text, edtUtente.Text]),E);
      end;

      // gestione errore in caso di login esterno
      if LoginEsterno = 'S' then
      begin
        // se fallito login esterno ed è specificato un url differente uso quello:
        if W000ParConfig.UrlLoginErrato <> '' then
          (GGetWebApplicationThreadVar.Data as TSessioneWeb).HomeUrl:=W000ParConfig.UrlLoginErrato;
        lnkEsciClick(nil);
      end
      else
      begin
        if not (E is EAbort) then
          MessaggioStatus(ERRORE,E.Message);
      end;
      Exit; // aggiunto per evitare la free
    end;
  END;

  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - fine metodo (prima di release)');
  Release;
end;

procedure TW001FLogin.GetAbilitazioniModuli;
// legge le abilitazioni dei moduli opzionali
var
  i: Integer;
  LAzienda: String;
  LModulo: String;
  LAbilitato: Boolean;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.GetAbilitazioniModuli - inizio metodo');
  WR000DM.ModuliAccessori.Clear;
  for i:=Low(FunzioniDisponibili) to High(FunzioniDisponibili) do
  begin
    // se la funzione è associata ad un modulo opzionale ne valuta l'abilitazione
    if FunzioniDisponibili[i].MIW <> '' then
    begin
      LAzienda:=Parametri.Azienda;
      for LModulo in FunzioniDisponibili[i].MIW.Split([',']) do
      begin
        if WR000DM.ModuliAccessori.Add(LAzienda,LModulo) then
        begin
          // traccia l'abilitazione (una volta sola per modulo)
          LAbilitato:=WR000DM.ModuliAccessori.IsAbilitato(LAzienda,LModulo);
          Log('Traccia',Format('Azienda %s: modulo %s %s',[LAzienda,LModulo,IfThen(LAbilitato,'abilitato','non abilitato')]));
        end;
      end;
    end;
  end;
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.GetAbilitazioniModuli - fine metodo');
end;

procedure TW001FLogin.edtAziendaSubmit(Sender: TObject);
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.edtAziendaSubmit - inizio metodo');
  lnkAccediClick(nil);
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.edtAziendaSubmit - fine metodo');
end;

procedure TW001FLogin.lnkRecuperaPasswordClick(Sender: TObject);
var
  nsl: Integer;
  ParDominioDip: String;
  ParEMailSMTPHost: String;
  ParEMailHeloName: string;
  ParEMailUserName: String;
  ParEMailPassWord: String;
  ParEMailPort: String;
  ParEMailSenderIndirizzo: String;
  ParEMailSender: String;
  ParEMailAuthType: String;
  ParEMailUseTLS: String;
  MailPwd: String;
  MailPwdDecifrata: String;
  MailIndirizzi: String;
  MailTestoHtml: String;
  MailTestoNormale: String; // AOSTA_ASL - chiamata 79156
  EsisteAzienda: Boolean;
  EsisteUtente: Boolean;
  ElencoAziende: String; // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6
  SuffissoLDAP: String;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkRecuperaPasswordClick - inizio metodo');

  // per sicurezza esco se ReCAPTCHA è richiesto e non è verificato
  if RichiestoReCAPTCHA and not VerifiedReCAPTCHA then
    Exit;

  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.ini
  // controllo indicazione limitato al nome utente

  // verifica che azienda e utente siano indicati
  // questi dati sono indispensabili per il recupero della password
  // (l'azienda è comunque impostata automaticamente)

  // controlla campo utente
  if edtUtente.Text = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W001_ERR_FMT_RECUPERO_PWD_INPUT),[lblUtente.Caption]));
    edtUtente.SetFocus;
    Exit;
  end;
  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.fine

  // avvia recupero password
  if W001FPasswordDtM = nil then
  begin
    W001FPasswordDtM:=TA001FPasswordDtM1.Create((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN);
  end;
  nsl:=-1;
  try
    WR000DM.W001FPasswordDtM:=W001FPasswordDtM;
    nsl:=WR000DM.GetSessioneLogin(edtDatabase.Text);
    if nsl = -1 then
      Abort;
    CSSessioneMondoEDP.Enter;
    try
      W001FPasswordDtM.InizializzazioneSessione(edtDatabase.Text);
    finally
      CSSessioneMondoEDP.Leave;
    end;

    // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.ini
    // in fase di login interattivo, se l'azienda non viene indicata,
    // il programma cerca di individuarla utilizzando solo il nome utente,
    // ricercando su I060 per le aziende con LOGIN_DIP_ABILITATO = 'S'
    // e su I070 per le aziende con LOGIN_USR_ABILITATO = 'S'
    ForzaAziendaVisibile:=False;
    if (edtAzienda.Text = '') and (edtUtente.Text <> '') then
    begin
      // azienda non indicata: ricerca tramite nome utente
      // estrae l'elenco delle aziende
      W001FPasswordDtM.selDistAzienda.Close;
      W001FPasswordDtM.selDistAzienda.ClearVariables;
      W001FPasswordDtM.selDistAzienda.SetVariable('UTENTE',edtUtente.Text);
      W001FPasswordDtM.selDistAzienda.SetVariable('I060','S');
      W001FPasswordDtM.selDistAzienda.Open;
      // casi da gestire:
      // 0   record -> errore azienda non indicata
      // 1   record -> ok (si rifà alla gestione precedente)
      // N>1 record -> proporre lista aziende da selezionare
      if W001FPasswordDtM.selDistAzienda.RecordCount = 0 then
      begin
        // ricerca azienda fallita -> chiede all'utente di indicare l'azienda
        // nel caso in cui l'azienda fosse non visibile, ne forza la visibilità
        ForzaAziendaVisibile:=True;
        GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_NON_INDICATA));
        Exit;
      end
      else if W001FPasswordDtM.selDistAzienda.RecordCount = 1 then
      begin
        // imposta l'azienda individuata
        edtAzienda.Text:=W001FPasswordDtM.selDistAzienda.FieldByName('AZIENDA').AsString;
      end
      else if W001FPasswordDtM.selDistAzienda.RecordCount > 1 then
      begin
        // il nome utente indicato è presente in più aziende:
        // propone la lista delle aziende da scegliere
        // nel caso in cui l'azienda fosse non visibile, ne forza la visibilità
        ForzaAziendaVisibile:=True;
        ElencoAziende:='';
        W001FPasswordDtM.selDistAzienda.First;
        while not W001FPasswordDtM.selDistAzienda.Eof do
        begin
          ElencoAziende:=ElencoAziende + W001FPasswordDtM.selDistAzienda.FieldByName('AZIENDA').AsString.QuotedString + ',';
          W001FPasswordDtM.selDistAzienda.Next;
        end;
        jqAutocomplete.OnReady.Text:=
          'var elementi = [' + ElencoAziende.Substring(0,ElencoAziende.Length - 1) + '];' + CRLF +
          '$("#' + edtAzienda.HTMLName + '").autocomplete({' + CRLF +
          '  source: elementi,' + CRLF +
          '  delay: 0,' + CRLF +
          '  minLength: 0' + CRLF +
          '}).focus(function(){ ' + CRLF +
          '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
          '}); ';
        GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_SEL_AZIENDA));
        Exit;
      end;
    end;
    // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.fine

    // inizializa variabili
    MailIndirizzi:='';
    MailPwd:='';
    MailPwdDecifrata:='';

    // estrae parametro per dominio di autenticazione
    // (verifica contestualmente esistenza dell'azienda)
    with W001FPasswordDtM.QI090 do
    begin
      Session:=(lstSessioniMondoEDP[nsl] as TOracleSession);
      Close;
      SetVariable('AZIENDA',edtAzienda.Text);
      Open;
      EsisteAzienda:=RecordCount > 0;
      if RecordCount > 0 then
      begin
        edtAzienda.Text:=W001FPasswordDtM.QI090.FieldByName('Azienda').AsString;
        ParDominioDip:=FieldByName('DOMINIO_DIP').AsString;
      end;
      SuffissoLDAP:=W001FPasswordDtM.GetSuffissoLDAP('I060');
      Close;
    end;

    if not EsisteAzienda then
    begin
      // utente inesistente
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W001_ERR_RECUPERO_PWD_NO_AZIENDA));
      Exit;
    end;

    // estrae dati utente da I060
    with W001FPasswordDtM.QI060 do
    begin
      Session:=(lstSessioniMondoEDP[nsl] as TOracleSession);
      Close;
      ClearVariables;
      SetVariable('AZIENDA',edtAzienda.Text);
      SetVariable('UTENTE',edtUtente.Text);
      Open;
      if RecordCount = 0 then
      begin
        Close;
        SetVariable('UTENTE',edtUtente.Text + IfThen(UpperCase(edtUtente.Text).IndexOf(UpperCase(SuffissoLDAP)) < 0, SuffissoLDAP));
        Open;
      end;
      EsisteUtente:=RecordCount > 0;
      if RecordCount > 0 then
      begin
        edtUtente.Text:=FieldByName('NOME_UTENTE').AsString;
        MailIndirizzi:=FieldByName('EMAIL').AsString;
        MailPwd:=FieldByName('PASSWORD').AsString;
      end;
      Close;
    end;

    if not EsisteUtente then
    begin
      (*
       * UTENTE INESISTENTE
       * Secondo le best practis OWASP (https://cheatsheetseries.owasp.org/cheatsheets/Forgot_Password_Cheat_Sheet.html)
       * Il messaggio in caso di utenza inesistente dev'essere coerente con una procedura andata a buon fine con un'utenza
       * effettivamente esistente
       *)
      TThread.Sleep(1000 * (Random(2) + 1)); // Simulazione tempo impiegato per invio email
      Notifica(A000TraduzioneStringhe(A000MSG_W001_MSG_RECUPERO_PWD_INVIATA_TITLE),A000TraduzioneStringhe(A000MSG_W001_MSG_RECUPERO_PWD_INVIATA),'../img/mail-icon-ok.png',False,False,10000);
      Exit;
    end;

    // gestione recupero password via mail
    // legge i parametri relativi al server smtp
    W001FPasswordDtM.QI091.Session:=(lstSessioniMondoEDP[nsl] as TOracleSession);
    W001FPasswordDtM.QI091.Close;
    W001FPasswordDtM.QI091.SetVariable('AZIENDA',edtAzienda.Text);
    W001FPasswordDtM.QI091.Open;

    ParEmailSMTPHost:=VarToStr(W001FPasswordDtM.QI091.Lookup('Tipo','C90_EMAIL_SMTPHOST','Dato'));
    ParEMailHeloName:=VarToStr(W001FPasswordDtM.QI091.LookUp('Tipo','C90_EMAIL_HELONAME','Dato'));
    ParEmailUserName:=VarToStr(W001FPasswordDtM.QI091.LookUp('Tipo','C90_EMAIL_USERNAME','Dato'));
    ParEmailPassWord:=R180Decripta(VarToStr(W001FPasswordDtM.QI091.Lookup('Tipo','C90_EMAIL_PASSWORD','Dato')),30011945);
    ParEmailPort:=VarToStr(W001FPasswordDtM.QI091.Lookup('Tipo','C90_EMAIL_PORT','Dato'));
    ParEmailSenderIndirizzo:=VarToStr(W001FPasswordDtM.QI091.Lookup('Tipo','C90_EMAIL_SENDER_INDIRIZZO','Dato'));
    ParEmailSender:=VarToStr(W001FPasswordDtM.QI091.Lookup('Tipo','C90_EMAIL_SENDER','Dato'));
    ParEMailAuthType:=VarToStr(W001FPasswordDtM.QI091.Lookup('Tipo','C90_EMAIL_AUTHTYPE','Dato'));
    ParEMailUseTLS:=VarToStr(W001FPasswordDtM.QI091.Lookup('Tipo','C90_EMAIL_USETLS','Dato'));

    W001FPasswordDtM.QI091.Close;
  finally
    FreeAndNil(W001FPasswordDtM);
    if nsl >= 0 then
    begin
      CSSessioneMondoEDP.Enter;
      try
        (lstSessioniMondoEDP[nsl] as TOracleSession).Tag:=max(1,(lstSessioniMondoEDP[nsl] as TOracleSession).Tag) - 1;
      finally
        CSSessioneMondoEDP.Leave;
      end;
    end;
  end;

  // se l'autenticazione avviene sul dominio e la password non è indicata
  // avvisa l'utente che la modifica della password non è consentita
  if (MailPwd = '') and
     (ParDominioDip <> '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W001_ERR_RECUPERO_PWD_AUT_ESTERNA));
    Exit;
  end;

  // avvisa se l'utente non ha una mail associata
  if MailIndirizzi = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W001_ERR_RECUPERO_PWD_NO_MAIL));
    Exit;
  end;

  // avvisa se non è indicato il server di posta
  if ParEmailSMTPHost = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W001_ERR_RECUPERO_PWD_NO_HOST));
    Exit;
  end;

  // decifra la password
  if MailPwd = '' then
    MailPwdDecifrata:='<vuota>'
  else
    MailPwdDecifrata:=R180Decripta(MailPwd,30011945);

  // imposta il testo della mail
  MailTestoHtml:='<div style="font-size: 13px; font-family: Arial">' +
                 '<p>' +
                 '  Gentile utente,<br>' +
                 '  ecco i dati di accesso a <b>IrisWeb</b> richiesti alle %s<br>' +
                 '  tramite la procedura di recupero password:' +
                 '</p>' +
                 '<table cellpadding="5" style="width: 200px; font-size: 12px; font-family: Courier New, Courier, mono; border-collapse: collapse;">' +
                 '  <tbody>' +
                 '    <tr>' +
                 '      <td style="border: 1px solid #AAAAAA;">Azienda</td>' +
                 '      <td style="border: 1px solid #AAAAAA;">%s</td>' +
                 '    </tr>' +
                 '    <tr>' +
                 '      <td style="border: 1px solid #AAAAAA;">Utente</td>' +
                 '      <td style="border: 1px solid #AAAAAA;">%s</td>' +
                 '    </tr>' +
                 '    <tr>' +
                 '      <td style="border: 1px solid #AAAAAA;">Password</td>' +
                 '      <td style="border: 1px solid #AAAAAA;">%s</td>' +
                 '    </tr>' +
                 '  </tbody>' +
                 '</table>' +
                 '<br><br>' +
                 '<p>' +
                 '  Avviso:<br>' +
                 '  La presente e-mail &egrave; stata generata automaticamente dal sistema IrisWEB.<br>' +
                 '  Si prega di non rispondere a questo indirizzo di posta,<br>' +
                 '  in quanto non &egrave; abilitato alla ricezione di messaggi.' +
                 '</p>' +
                 '</div>';
  MailTestoHtml:=Format(MailTestoHtml,[FormatDateTime('dd/mm/yyyy hhhh.mm',Now),edtAzienda.Text,edtUtente.Text,MailPwdDecifrata]);
  // AOSTA_ASL - chiamata 79156.ini
  // prepara il testo alternativo per i client che non supportano html
  MailTestoNormale:='Gentile utente,'#13#10 +
                    '  ecco i dati di accesso a IrisWeb richiesti alle %s'#13#10 +
                    'tramite la procedura di recupero password:'#13#10 +
                    #13#10 +
                    'Azienda: %s'#13#10 +
                    'Utente: %s'#13#10 +
                    'Password: %s'#13#10 +
                    #13#10 +
                    'Avviso:'#13#10 +
                    //'  versione in testo normale per i client di posta che non supportano html.'#13#10 +
                    '  La presente e-mail è stata generata automaticamente dal sistema IrisWEB.'#13#10 +
                    '  Si prega di non rispondere a questo indirizzo di posta,'#13#10 +
                    '  in quanto non è abilitato alla ricezione di messaggi.';
  MailTestoNormale:=Format(MailTestoNormale,[FormatDateTime('dd/mm/yyyy hhhh.mm',Now),edtAzienda.Text,edtUtente.Text,MailPwdDecifrata]);
  // AOSTA_ASL - chiamata 79156.fine

  // parametri ok
  IdSMTP.Host:=ParEmailSMTPHost;
  if ParEmailPort.Trim = '' then
    IdSMTP.Port:=25
  else
    IdSMTP.Port:=ParEmailPort.ToInteger;

  IdSMTP.AuthType:=satDefault;
  {Assegnazione e valorizzazione oggetto necessario per l'autenticazione TLS\SSL}
  if (ParEMailAuthType.Trim <> '') and
     (ParEMailAuthType.Trim.ToUpper <> 'NO AUTENTICAZIONE') then
  begin
    IdSMTP.IOHandler:=IdSSLIOHandlerSocketOpenSSL;
    with IdSSLIOHandlerSocketOpenSSL do
    begin
      IdSMTP.UseEhlo:=not ParEMailHeloName.Trim.IsEmpty;

      SSLOptions.Method:=sslvTLSv1;
      SSLOptions.SSLVersions:=[sslvTLSv1];
      if ParEMailAuthType.ToUpper = 'TLSV1_1' then
      begin
        SSLOptions.Method:=sslvTLSv1_1;
        SSLOptions.SSLVersions:=[sslvTLSv1_1];
      end
      else if ParEMailAuthType.ToUpper = 'TLSV1_2' then
      begin
        SSLOptions.Method:=sslvTLSv1_2;
        SSLOptions.SSLVersions:=[sslvTLSv1_2];
      end
      else if ParEMailAuthType.ToUpper = 'SSLV2' then
      begin
        SSLOptions.Method:=sslvSSLv2;
        SSLOptions.SSLVersions:=[sslvSSLv2];
      end
      else if ParEMailAuthType.ToUpper = 'SSLV23' then
      begin
        SSLOptions.Method:=sslvSSLv23;
        SSLOptions.SSLVersions:=[sslvSSLv23];
      end
      else if ParEMailAuthType.ToUpper = 'SSLV3' then
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
    if ParEMailUseTLS.ToUpper = 'NO' then
      IdSMTP.UseTLS:=utNoTLSSupport
    else if ParEMailUseTLS.ToUpper = 'IMPLICIT' then
      IdSMTP.UseTLS:=utUseImplicitTLS
    else if ParEMailUseTLS.ToUpper = 'EXPLICIT' then
      IdSMTP.UseTLS:=utUseExplicitTLS
    else if ParEMailUseTLS.ToUpper = 'REQUIRE' then
      IdSMTP.UseTLS:=utUseRequireTLS;
  end;

  // invia la password all'indirizzo di posta indicato
  try
    try
      // connessione smtp
      IdSMTP.HeloName:=Trim(ParEMailHeloName);
      IdSMTP.Connect;
      IdSMTP.Username:=Trim(ParEMailUserName);
      IdSMTP.Password:=Trim(ParEMailPassWord);

      // imposta i dati della mail
      IdMessage.From.Address:=ParEMailSenderIndirizzo;
      IdMessage.From.Name:=ParEMailSender;
      IdMessage.BccList.Clear;
      IdMessage.Recipients.Clear;
      IdMessage.Recipients.EmailAddresses:=MailIndirizzi;
      IdMessage.Subject:='Password di accesso a IrisWeb';

      // imposta il testo della mail
      IdMessage.MessageParts.Clear;
      // AOSTA_ASL - chiamata 79156.ini
      // gestione invio mail con testo alternativo (per client che non supportano html)
      // cfr. http://www.indyproject.org/sockets/blogs/rlebeau/2005_08_17_a.en.aspx

      {
      // v1. invio mail solo in html (versione da non usare, troppo debole)
      IdMessage.ContentType:='text/html';
      IdMessage.Body.Text:=MailTesto;
      }

      // v2: testo html + testo normale
      {
      // oggetto per testo normale (usato dai client che non supportano html)
      with TIdText.Create(IdMessage.MessageParts, nil) do
      begin
        Body.Text:=MailTestoNormale;
        ContentType:='text/plain';
      end;
      // oggetto per testo html
      with TIdText.Create(IdMessage.MessageParts, nil) do
      begin
        Body.Text:=MailTestoHtml;
        ContentType:='text/html';
      end;
      IdMessage.ContentType:='multipart/alternative';
      }
      // v2.fine
      // AOSTA_ASL - chiamata 79156.fine

      // AOSTA_ASL - chiamata 80050.ini
      // nonostante gli sforzi, i client di Aosta_Asl continuano a non visualizzare correttamente il testo della mail
      // la difficoltà è che non si riesce a riprodurre il problema: sono stati effettuati test
      // su diversi client di posta, anche molto vecchi (es. outlook 2003) ma senza riscontrare problemi
      // come soluzione si è deciso di inviare il testo in text/plain
      // nota: è stato copiato il content type da C017, compresa la specifica del character set iso-8859-15
      // v3: solo testo normale
      IdMessage.ContentType:='text/plain; charset=ISO-8859-15';
      IdMessage.Body.Text:=MailTestoNormale;
      // v3.fine
      // AOSTA_ASL - chiamata 80050.fine

      IdSMTP.Send(IdMessage);
      Log('Traccia','Recupero password utente ' + edtUtente.Text);

      // messaggio di invio della mail completato
      Notifica(A000TraduzioneStringhe(A000MSG_W001_MSG_RECUPERO_PWD_INVIATA_TITLE),A000TraduzioneStringhe(A000MSG_W001_MSG_RECUPERO_PWD_INVIATA),'../img/mail-icon-ok.png',False,False,10000);
    except
      on E:Exception do
      begin
        raise Exception.Create('Invio email fallito su host ' + IdSMTP.Host + ': ' + E.ClassName + '/' + E.Message);
      end;
    end;
  finally
    IdSMTP.Disconnect;
  end;
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkRecuperaPasswordClick - fine metodo');
end;

function TW001FLogin.RichiestoReCAPTCHA: Boolean;
var tempApplicationURL, tempUrlReCAPTCHA: String;
begin
  Result:=False;
  if W000ParConfig.UrlReCAPTCHA <> '' then
  begin
    tempApplicationURL:=LowerCase(GGetWebApplicationThreadVar.ApplicationURL).Replace('http://','').Replace('https://','');
    tempUrlReCAPTCHA:=LowerCase(W000ParConfig.UrlReCAPTCHA).Replace('http://','').Replace('https://','');

    if tempApplicationURL.StartsWith(tempUrlReCAPTCHA) then
    begin
      Result:=True;
      Exit;
    end;
  end;
end;

procedure TW001FLogin.ReCAPTCHA_OnCallBack(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
var
  IdHttp1: TIdHTTP;
  response: string;
begin
  IdHttp1:=TIdHTTP.Create(Self);
  try
    response:=IdHttp1.Get('https://www.google.com/recaptcha/api/siteverify?secret=' +
                              W000ParConfig.SecretKeyReCAPTCHA + '&response=' +
                              ((JSONInput as TJSONObject).Get('response').JsonValue as TJSONString).Value);

    if Pos('"success": true', response) > 0 then
    begin
      VerifiedReCAPTCHA:=True;
      btnAccedi.Enabled:=True;
      lnkRecuperaPassword.Enabled:=True;
    end
    else
      raise Exception.Create('Validazione ReCAPTCHA lato server fallita');
  finally
    IdHttp1.Free;
    TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(JSONOutput,nil);
  end;
end;

procedure TW001FLogin.ReCAPTCHA_OnCallBackExpired(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
begin
  VerifiedReCAPTCHA:=False;
  btnAccedi.Enabled:=False;
  lnkRecuperaPassword.Enabled:=False;
  TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(JSONOutput,nil);
end;

initialization
  TW001FLogin.SetAsMainForm;

end.