unit WR101ULogin;

interface

uses
  WR100UBase, ActnList,
  Oracle, DB, OracleData, DateUtils, Windows, System.Contnrs,
  IWAppForm, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel, Classes, Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  Math, SysUtils, Variants, IWCompButton, meIWButton,
  A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi,
  A001UPasswordDtM1, C180FunzioniGenerali, RegistrazioneLog,
  IWCompListbox, StrUtils, IniFiles, IW.Common.System,
  JBFService, xmldom, msxmldom, XMLDoc,
  IWCompEdit, meIWLabel, meIWComboBox, meIWEdit, meIWLink, XMLIntf,
  IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompGrids, meIWGrid, medpIWStatusBar;

type
  (*
  TSSORisposta = record
    Utente,
    Profilo: String;
  end;
  *)

  TWR101FLogin = class(TWR100FBase)
    xmlDoc: TXMLDocument;
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
    procedure IWAppFormCreate(Sender: TObject);
    procedure lnkAccediClick(Sender: TObject);
    procedure edtAziendaSubmit(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
  private
//    UrlWSAuth: String;
    FScriviDatabase: Boolean;
    W001FPasswordDtM:TA001FPasswordDtM1;
    FForzaAziendaVisibile: Boolean;
    function  ConvertiHomeUrl(const PHome: String): String;
    procedure TraduzionePagina;
    procedure SSOVisualizzaAnomalia(const PAnomalia: String);
    procedure RicercaAutomaticaAzienda;
    //function  SSOTicket(const PTicket:String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
    //function  SSOComo(const PUID, PTime, PHash: String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
  protected
    procedure LanciaMainForm; virtual; abstract;
  public
    LoginEsterno: String;
  end;

const HKEY_LOCAL_MACHINE = $80000002;

implementation

uses WR000UBaseDM, WC023UCambioPasswordFM,
     IWApplication, IWGlobal, System.IOUtils;

{$R *.DFM}

procedure TWR101FLogin.IWAppFormCreate(Sender: TObject);
var
  ParAzienda,ParUsr,ParPwd,ParProfilo,
  ParDatabase,ParLoginEsterno,
  ParHome,ParWSAuth,ParTicket,
  Anomalia,RedirectStr,
  ParURLMan,ParUID,ParTime,ParHash,ParRemoteUser,STemp:String;
  AutSSO: Boolean;
  Risposta: TSSORisposta;
  ListaPar: TStrings;
  i: Integer;
const
  PAR_REMOTE_USER_NAME = 'remoteuser';
begin
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormCreate - inizio metodo');
  
  // esce subito se la sessione è terminata (W001 è la main form, per cui viene comunque creata)
  if GGetWebApplicationThreadVar.Terminated then
    Exit;

  inherited;

  //Gestione eventuale pagina di manutenzione
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormCreate - gestione pagina di manutenzione');
  ParURLMan:=W000ParConfig.UrlManutenzione;
  if Trim(ParURLMan) <> '' then
  begin
    if Pos('http', LowerCase(ParURLMan)) > 0 then
      GGetWebApplicationThreadVar.Response.SendRedirect(ParURLMan)
    else
    begin
      edtAzienda.Visible:=False;
      edtUtente.Visible:=False;
      edtPassword.Visible:=False;
      edtDatabase.Visible:=False;
      edtNomeProfilo.Visible:=False;
      cmbNomeProfilo.Visible:=False;
      lblAzienda.Css:='MsgManutenzione';
      lblAzienda.Left:=(Self.Width div 2) - (lblAzienda.Width div 2);
      lblAzienda.Caption:=ParURLMan;
      lblUtente.Visible:=False;
      lblPassword.Visible:=False;
      lblDatabase.Visible:=False;
      lblNomeProfilo.Visible:=False;
      lnkAccedi.Visible:=False;
      (*IrisWEB+ 
      lnkRecuperaPassword.Visible:=False;
      *)
    end;
  end;

  // lettura parametri
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormCreate - lettura parametri');
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
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormCreate - trovato remoteuser = ' + ParRemoteUser);
      end;
    end;
    // VENEZIA_IUAV.fine

    //chiamata da X002 (VILLAFALLETTO_PERARIA)
    if ListaPar.Values['xusr'] <> '' then
    begin
      //ParUsr:=R180DecriptaI070(ListaPar.Values['xusr']);
      ParUsr:=ListaPar.Values['xusr'];
      Parametri.CampiRiferimento.C90_SSO_RDLPassphrase:=A000SSO_RDLPassphrase;
      Parametri.CampiRiferimento.C90_SSO_UsrMask:=A000SSO_UsrMask;
      Parametri.CampiRiferimento.C90_SSO_TimeOut:='600';//10 minuti
    end;
    WR000DM.IpAddressClient:=ListaPar.Values['ipclient'];
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
  FScriviDatabase:=((ParDatabase = '') and (W000ParConfig.Database = '')) or (DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  (GGetWebApplicationThreadVar.Data as TSessioneWeb).HomeUrl:=ConvertiHomeUrl(IfThen(ParHome <> '',ParHome,W000ParConfig.Home));
  //UrlWSAuth:=IfThen(ParWSAuth <> '',ParWSAuth,W000ParConfig.UrlWSAutenticazione);

  if (LoginEsterno = 'S') and ((ParUsr <> '') or (ParUID <> '')) and (ListaPar.Values['xusr'] = '') then
    //lettura parametri aziendali sso a meno che non stia gestendo xusr: in tal caso i parametri sso sono fissati internamente
    WR000DM.GetParametriSSO(edtAzienda.Text,edtDatabase.Text);

  Risposta.Utente:='';
  Risposta.Profilo:='';
  // ROMA_HSANTANDREA - SSO.ini
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
      Log('Traccia','GGetWebApplicationThreadVar.AppURLBase: ' + GGetWebApplicationThreadVar.AppURLBase);
      RedirectStr:='?azienda=' + edtAzienda.Text +
                   '&usr=' + Risposta.Utente +
                   '&profilo=' + Risposta.Profilo +
                   '&database=' + edtDatabase.Text +
                   '&loginesterno=' + LoginEsterno;
      // bugfix.ini iw 12.2.12.1
      // appurlbase contiene erroneamente il session id: occorre rimuoverlo
      RedirectStr:=StringReplace(GGetWebApplicationThreadVar.AppURLBase,'/' + GGetWebApplicationThreadVar.AppID,'',[]) + RedirectStr;
      // bugfix.fine
      Log('Traccia','Ticket autorizzato: accesso ad IrisWeb con redirect su: ' + RedirectStr);
      GGetWebApplicationThreadVar.Response.SendRedirect(RedirectStr);
    end
    else
    begin
      SSOVisualizzaAnomalia(Anomalia);
      Exit;
    end;
  end
  // ROMA_HSANTANDREA - SSO.fine
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
      (*
      Log('Traccia','GGetWebApplicationThreadVar.AppURLBase: ' + GGetWebApplicationThreadVar.AppURLBase);
      RedirectStr:='?azienda=' + edtAzienda.Text +
                   '&usr=' + Risposta.Utente +
                   '&profilo=' + Risposta.Profilo +
                   '&database=' + edtDatabase.Text +
                   '&loginesterno=' + LoginEsterno;
      // bugfix.ini iw 12.2.12.1
      // appurlbase contiene erroneamente il session id: occorre rimuoverlo
      RedirectStr:=StringReplace(GGetWebApplicationThreadVar.AppURLBase,'/' + GGetWebApplicationThreadVar.AppID,'',[]) + RedirectStr;
      // bugfix.fine
      Log('Traccia','Token autorizzato: accesso ad IrisWeb con redirect su: ' + RedirectStr);
      GGetWebApplicationThreadVar.Response.SendRedirect(RedirectStr);
      *)
    end
    else
    begin
      SSOVisualizzaAnomalia('Autenticazione con SSO fallita: ' + Anomalia);
      Exit;
    end;
  end
  // COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.fine
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
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormCreate - avvio automatico login');
    AddToInitProc(Format('SubmitClickConfirm("%s","",true,"");',[lnkAccedi.HTMLName]));
  end;

  // gestione login esterno
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormCreate - gestione login esterno');
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

  // per i progetti singoli viene proposto il login con l'account SYSMAN
  {$WARN SYMBOL_PLATFORM OFF}
  if (DebugHook <> 0) and (edtUtente.Text = '') then
  {$WARN SYMBOL_PLATFORM ON}
  begin
    edtUtente.Text:='SYSMAN';
    edtPassword.Text:='LEADER';
  end;

  TraduzionePagina;

  {$IFDEF WEBPJ}
  edtNomeProfilo.Visible:=False;
  lblNomeProfilo.Visible:=False;
  {$ENDIF}

  (*IriswEB+ 
  // visibilità link di recupero password
  lnkRecuperaPassword.Visible:=(LoginEsterno <> 'S') and
                               (Pos(INI_PAR_RECUPERO_PASSWORD,W000ParConfig.ParametriAvanzati) > 0);
  *)
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormCreate - fine metodo');
end;

procedure TWR101FLogin.TraduzionePagina;
var
  Lingua: String;
  i,nsl: Integer;
begin
  // gestione traduzione
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - inizio metodo');
  if (Pos(INI_PAR_TRADUZIONE_CAPTION,W000ParConfig.ParametriAvanzati) > 0) and
     (LoginEsterno = 'N') and
     (edtAzienda.Text <> '') and
     (edtDatabase.Text <> '') then
  begin
    Lingua:='INGLESE';
    nsl:=-1;
    if W001FPasswordDtM = nil then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - W001FPasswordDtM: chiamata al costruttore');
      W001FPasswordDtM:=TA001FPasswordDtM1.Create((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN);
      DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - W001FPasswordDtM: creazione terminata');
    end;
    try
      W001FPasswordDtM.EseguiCheckConnection:=Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0;
      WR000DM.W001FPasswordDtM:=W001FPasswordDtM;
      DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - WR000DM.GetSessioneLogin(' + edtDatabase.Text + '): invocata');
      nsl:=WR000DM.GetSessioneLogin(edtDatabase.Text);
      DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - WR000DM.GetSessioneLogin(' + edtDatabase.Text + '): terminata');
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
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - selI015: inizio gestione');
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
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - selI015: fine gestione');
      end;
    finally
      DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - W001FPasswordDtM: inizio distruzione');
      FreeAndNil(W001FPasswordDtM);
      DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - W001FPasswordDtM: fine distruzione');

      if nsl >= 0 then
      begin
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - CSSessioneMondoEDP: attesa per Enter');
        CSSessioneMondoEDP.Enter;
        try
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - CSSessioneMondoEDP: dentro la critical section');
          (lstSessioniMondoEDP[nsl] as TOracleSession).Tag:=max(1,(lstSessioniMondoEDP[nsl] as TOracleSession).Tag) - 1;
        finally
          CSSessioneMondoEDP.Leave;
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - CSSessioneMondoEDP: Leave effettuata');
        end;
      end;
    end;
  end;
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.TraduzionePagina - fine metodo');
end;

procedure TWR101FLogin.IWAppFormRender(Sender: TObject);
var idx:Integer;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormRender - inizio metodo');
  inherited;

  // se necessario forza visibilità campo azienda (e relativa label)
  // rimuove anche i campi dalla lista dei componenti invisibili
  if FForzaAziendaVisibile then
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
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormRender - fine metodo');
end;

procedure TWR101FLogin.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 14 OK }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormAfterRender - inizio metodo');
    inherited;
    RimuoviNotifiche;
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.IWAppFormAfterRender - fine metodo');
  end;
end;

procedure TWR101FLogin.SSOVisualizzaAnomalia(const PAnomalia: String);
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

  (*IrisWEB+
  // disabilita anche recupero password
  lnkRecuperaPassword.Enabled:=False;
  *)

  // ...
  //if Home <> '' then
  //  GGetWebApplicationThreadVar.Response.SendRedirect(Home);
end;
// COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.fine

function TWR101FLogin.ConvertiHomeUrl(const PHome: String): String;
var
  ParUrlBase,Risultato: String;
begin
  Risultato:=PHome;

  // sostituzione variabili
  if Pos('(URLBASE)',Risultato) > 0 then
  begin
    // URLBASE = directory base applicazione
    ParUrlBase:=StringReplace(GGetWebApplicationThreadVar.AppURLBase,'/IrisCloudRilPre_IIS.dll','',[rfIgnoreCase]);
    Risultato:=StringReplace(Risultato,'(URLBASE)',ParUrlBase,[rfIgnoreCase]);
  end;

  Result:=Risultato;
end;

procedure TWR101FLogin.lnkAccediClick(Sender: TObject);
var
  WC023: TWC023FCambioPasswordFM;
  Sysdate:TDateTime;
  PwdScaduta,CSEnter,AuthDom:Boolean;
  ValProfilo,ElencoAziende,locDom:String;
  ns,nsl:Integer;
  IniFile: TIniFile;
  LRicercaAzienda: Boolean;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - inizio metodo');
  nsl:=-1; // inizializzazione
  TRY
    //Autenticazione
    AuthDom:=False;
    if W001FPasswordDtM = nil then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - W001FPasswordDtM: chiamata al costruttore');
      W001FPasswordDtM:=TA001FPasswordDtM1.Create((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN);
      DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - W001FPasswordDtM: creazione terminata');
    end;
    try
      WR000DM.W001FPasswordDtM:=W001FPasswordDtM;
      with W001FPasswordDtM do
      begin
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - GetSessioneLogin: invocato');
        nsl:=WR000DM.GetSessioneLogin(edtDatabase.Text);
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - GetSessioneLogin: terminato');
        Log('Sessione','GetSessioneLogin');
        if nsl = -1 then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_CONN_FALLITA));
          Abort;
        end;
        PwdScaduta:=False;
        try
          //Verifica alias database
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
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSSessioneMondoEDP: attesa per Enter');
            CSSessioneMondoEDP.Enter;
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSSessioneMondoEDP: dentro la critical section');
            CSEnter:=True;
          end;
          try
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - InizializzazioneSessione(' + edtDatabase.Text + '): invocato');
            InizializzazioneSessione(edtDatabase.Text);
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - InizializzazioneSessione(' + edtDatabase.Text + '): terminato');
          finally
            if CSEnter then
            begin
              CSSessioneMondoEDP.Leave;
              DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSSessioneMondoEDP: Leave effettuata');
            end;
          end;
        except
          on E:Exception do
          begin
            Log('Errore','InizializzazioneSessione Respinta',E);
            GGetWebApplicationThreadVar.ShowMessage(E.Message);
            Abort;
          end;
        end;
        Log('Sessione','SessioneLogin:' + IntToStr(nsl) + '/' + IntToStr(W001FPasswordDtM.SessioneMondoEDP.Tag));

        if FScriviDatabase then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSParConfig: attesa per Enter');
          CSParConfig.Enter;
          try
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSParConfig: dentro la critical section');
            { DONE : TEST IW 14 OK }
            //IniFile:=TIniFile.Create(IncludeTrailingPathDelim(gSC.AppPath) + FILE_CONFIG);
            IniFile:=TIniFile.Create(IncludeTrailingPathDelim(gsAppPath) + FILE_CONFIG);
            try
              IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_DATABASE,edtDatabase.Text);
            finally
              FreeAndNil(IniFile);
            end;
          finally
            CSParConfig.Leave;
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSParConfig: Leave effettuata');
          end;
        end;

        // richiesta indicazione nome utente
        if edtUtente.Text = '' then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_NON_INDICATO));
          edtUtente.SetFocus;
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_NON_INDICATO));
        end;

        // effettua la ricerca automatica di un'azienda valida per il login nei seguenti casi:
        // - l'azienda non è specificata
        // - l'azienda è specificata ma l'utente indicato non è valido
        // IMPORTANTE: la ricerca è effettuata sulle aziende con LOGIN_USR_ABILITATO = 'S'
        RicercaAutomaticaAzienda;

        // se l'azienda non è indicata dà un errore specifico
        if edtAzienda.Text = '' then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_NON_INDICATA));
          ActiveControl:=edtAzienda;
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_NON_INDICATA));
        end;

        // ricerca l'azienda su database per estrarre informazioni
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - estrazione dati azienda');
        QI090.Close;
        QI090.SetVariable('Azienda',edtAzienda.Text);
        QI090.Open;
        if QI090.RecordCount = 0 then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_INESISTENTE));
          ActiveControl:=edtAzienda;
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_INESISTENTE));
        end;

        // salva parametri del dominio di autenticazione
        Parametri.AuthDomInfo.DominioDip:=QI090.FieldByName('DOMINIO_DIP').AsString;
        Parametri.AuthDomInfo.DominioDipTipo:=QI090.FieldByName('DOMINIO_DIP_TIPO').AsString;
        Parametri.AuthDomInfo.DominioUsr:=QI090.FieldByName('DOMINIO_USR').AsString;
        Parametri.AuthDomInfo.DominioUsrTipo:=QI090.FieldByName('DOMINIO_USR_TIPO').AsString;

        // ricerca record con lo username indicato
        // su I070 (supervisore) e su I060 (dipendente)
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - ricerca utente in I070 e I060');
        with selI070Doppi do
        begin
          Close;
          SetVariable('Azienda',QI090.FieldByName('Azienda').AsString);
          SetVariable('Utente',edtUtente.Text);
          Open;
        end;
        QI070.Close;
        QI070.SetVariable('Azienda',QI090.FieldByName('Azienda').AsString);
        QI070.SetVariable('CampoUtente',IfThen(selI070Doppi.RecordCount > 0,'UTENTE','UPPER(UTENTE)'));
        QI070.SetVariable('Utente',IfThen(selI070Doppi.RecordCount > 0,edtUtente.Text,UpperCase(edtUtente.Text)));
        QI070.Open;
        QI060.Close;
        QI060.ClearVariables;
        QI060.SetVariable('Azienda',QI090.FieldByName('Azienda').AsString);
        {$IFDEF WEBPJ}
        QI060.SetVariable('Utente',null);
        {$ELSE}
        QI060.SetVariable('Utente',edtUtente.Text);
        {$ENDIF}
        QI060.Open;

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
          // utente di irisweb
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - autenticazione per utente web: iniziata');
          //Alberto: autenticazione su dominio
          if (not QI090.FieldByName('DOMINIO_DIP').IsNull) and QI060.FieldByName('PassWord').IsNull then
          begin
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - autenticazione su dominio iniziata');
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSAutenticazioneDominio: attesa per Enter');
            //MI_HSACCO: doppio dominio! ciclo sui domini separati da ';'
            AuthDom:=False;
            for locDom in QI090.FieldByName('DOMINIO_DIP').AsString.Split([';',',']) do
            begin
              CSAutenticazioneDominio.Enter;
              try
                DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: dentro la critical section');
                AuthDom:=AutenticazioneDominio(locDom, QI060.FieldByName('Nome_Utente').AsString, edtPassword.Text, QI090.FieldByName('DOMINIO_DIP_TIPO').AsString, QI090.FieldByName('DOMINIO_LDAP_DN').AsString);
                Parametri.AuthDomInfo.DominioDip:=locDom;
                if AuthDom then
                  Break;
              finally
                CSAutenticazioneDominio.Leave;
                DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: Leave effettuata');
              end;
            end;
            if not AuthDom and ((edtPassword.Text = '') or (edtPassword.Text <> R180Decripta(QI060.FieldByName('PassWord').AsString,30011945))) then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
              ActiveControl:=edtUtente;
              raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA)); //Abort;
            end;
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - autenticazione su dominio terminata');
          end
          //Fine autenticazione su dominio
          else if (LoginEsterno = 'N') and (edtPassword.Text <> R180Decripta(QI060.FieldByName('PassWord').AsString,30011945)) then
          begin
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
            ActiveControl:=edtUtente;
            raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
          end;

          //Registrazione parametri/inibizioni
          if edtNomeProfilo.Visible then
            ValProfilo:=edtNomeProfilo.Text
          else if cmbNomeProfilo.ItemIndex >= 0 then
            ValProfilo:=cmbNomeProfilo.Items[cmbNomeProfilo.ItemIndex]
          else if edtNomeProfilo.Text <> '' then
            ValProfilo:=edtNomeProfilo.Text;  // profilo specificato su registro - daniloc 09.03.2010
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioniInfo: iniziata');
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
              ActiveControl:=cmbNomeProfilo;
              raise Exception.Create(A000TraduzioneStringhe(A000MSG_MSG_SEL_PROFILO));
            end
            else
              raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PROFILO_NON_TROVATO));
          end;
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioniInfo: terminata');

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
          GGetWebApplicationThreadVar.SessionTimeOut:=WR000DM.TimeoutDip;
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
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - autenticazione per utente web: terminata');
        end
        else
        begin
          // utente di iriswin (supervisore)
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - autenticazione per utente win: iniziata');
          //Autenticazione su dominio
          if (QI070.FieldByName('Utente').AsString <> 'SYSMAN') and
             (QI070.FieldByName('Utente').AsString <> 'MONDOEDP') and
             (not QI090.FieldByName('DOMINIO_USR').IsNull) then
          begin
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - autenticazione su dominio iniziata');
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSAutenticazioneDominio: attesa per Enter');
            //MI_HSACCO: doppio dominio! ciclo sui domini separati da ';'
            AuthDom:=False;
            for locDom in QI090.FieldByName('DOMINIO_USR').AsString.Split([';',',']) do
            begin
              CSAutenticazioneDominio.Enter;
              try
                DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: dentro la critical section');
                if QI090.FindField('DOMINIO_LDAP_DN') <> nil then
                  AuthDom:=AutenticazioneDominio(locDom, QI070.FieldByName('Utente').AsString, edtPassword.Text, QI090.FieldByName('DOMINIO_USR_TIPO').AsString, QI090.FieldByName('DOMINIO_LDAP_DN').AsString)
                else
                  AuthDom:=AutenticazioneDominio(locDom, QI070.FieldByName('Utente').AsString, edtPassword.Text, QI090.FieldByName('DOMINIO_USR_TIPO').AsString);
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
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioni: iniziata');
          RegistraInibizioni;
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioni: terminata');
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
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - autenticazione per utente win: terminata');
        end;

        if Parametri.VersioneOracle = 0 then
          Parametri.VersioneOracle:=11;

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
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - verifica ACCESSO_NEGATO: iniziata');
          if QI070.FindField('ACCESSO_NEGATO') <> nil then
          begin
            if QI070.FieldByName('ACCESSO_NEGATO').AsString = 'S' then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_ACCESSO_INIBITO));
              Abort;
            end;
          end;
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - verifica ACCESSO_NEGATO: terminata');

          //Verifica se dall'ultimo accesso sono passati "VALID_UTENTE" mesi.In tal caso nega l'accesso
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - verifica scadenza password: iniziata');
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
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - verifica scadenza password: terminata');
        end;
        if (WR000DM.TipoUtente = 'Supervisore') and (Parametri.Applicazione <> '') and (not PwdScaduta) then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - aggiornamento data accesso: iniziata');
          OperSQL.SQL.Clear;
          OperSQL.SQL.Add(Format('UPDATE I070_UTENTI SET NUOVA_PASSWORD = ''N'', DATA_ACCESSO = TRUNC(SYSDATE) WHERE AZIENDA = ''%s'' AND UTENTE = ''%s''',[QI090.FieldByName('Azienda').AsString,QI070.FieldByName('Utente').AsString]));
          OperSQL.Execute;
          OperSQL.Session.Commit;
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - aggiornamento data accesso: terminata');
        end;
      end;
    finally
      try
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - W001FPasswordDtM: distruzione con FreeAndNil iniziata');
        if W001FPasswordDtM <> nil then
          FreeAndNil(W001FPasswordDtM);
        DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - W001FPasswordDtM: distruzione con FreeAndNil terminata');
        //Se la sessione oracle di autenticazione è condivisa,
        //diminuisco il tag per indicare che non è più in uso da questa sessione web
        if (nsl >= 0) and
           (Pos(INI_PAR_NO_SHARED_LOGIN,W000ParConfig.ParametriAvanzati) = 0) then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSSessioneMondoEDP: attesa per Enter');
          CSSessioneMondoEDP.Enter;
          try
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSSessioneMondoEDP: dentro la critical section');
            (lstSessioniMondoEDP[nsl] as TOracleSession).Tag:=max(1,(lstSessioniMondoEDP[nsl] as TOracleSession).Tag) - 1;
          finally
            CSSessioneMondoEDP.Leave;
            DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - CSSessioneMondoEDP: Leave effettuata');
          end;
        end;
      except
        on E:Exception do
          Log('Errore',Format('Azienda:%s - Utente:%s ' + CRLF + 'Errore in fase di accesso',[edtAzienda.Text, edtUtente.Text]),E);
      end;
    end;
    //Fine Autenticazione

    //Ricerca e inizializzazione di SessioneOracle
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - WR000DM.GetSessioneLavoro: invocato');
    ns:=WR000DM.GetSessioneLavoro;
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - WR000DM.GetSessioneLavoro: terminato');
    Log('Sessione','GetSessioneLavoro');

    // registra accesso sui log
    Log('Accesso','Login utente ' + WR000DM.TipoUtente + ': ' + Parametri.Operatore);

    QueryPK1.Session:=SessioneOracle;
    RegistraLog.Session:=SessioneOracle;
    //Caratto 15/04/2013 Imposto sessione oracle corretta. Non uso la funzione RegistraMsgSessione perchè mi restituirebbe il A000RegistraMsg
    ((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.RegistraMsg as TRegistraMsg).SessioneOracleApp:=SessioneOracle;
    RegistraMsgSessione.IniziaMessaggio(medpCodiceForm);

    // registra accesso sui log
    RegistraLog.SettaProprieta('A','',medpCodiceForm,nil,True);
    RegistraLog.InserisciDato('APPLICATIVO','',TPath.GetFileName(GetModuleName(HInstance)).ToUpper);
    RegistraLog.InserisciDato('TIPOUTENTE','',WR000DM.TipoUtente);
    RegistraLog.InserisciDato('OPERATORE','',Parametri.Operatore);
    RegistraLog.InserisciDato('TIPO','','ACCESSO');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;

    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - WR000DM.DataModuleCreate: invocato');
    WR000DM.DataModuleCreate(nil);
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - WR000DM.DataModuleCreate: terminato');
    Log('Sessione','SessioneORACLE:' + IntToStr(ns) + ';SessioneWEB:' + IntToStr(SessioneOracle.Tag));

    //Inizializzazione del datamodule
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - WR000DM.InizializzazioneW001DtM: invocato');
    Log('Traccia','InizializzazioneW001DtM: inizio');
    WR000DM.InizializzazioneW001DtM;
    Log('Traccia','InizializzazioneW001DtM completata');
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - WR000DM.InizializzazioneW001DtM: terminato');

    if PwdScaduta then
    begin
      Log('Traccia','Password scaduta: gestione');
      WC023:=TWC023FCambioPasswordFM.Create(GGetWebApplicationThreadVar);
      //TODO WC023.MessaggioStatus(ESCLAMA,A000TraduzioneStringhe(A000MSG_R101_MSG_PSW_SCADUTA));
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
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - WR000DM.AccessoValutatore: invocato');
    WR000DM.AccessoDirettoValutatore:=WR000DM.AccessoValutatore;
    DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - WR000DM.AccessoValutatore: terminato');

    LanciaMainForm;
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
        MessaggioStatus(ERRORE,E.Message);
      end;
      Exit; // aggiunto per evitare la free
    end;
  END;

  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.lnkAccediClick - fine metodo (prima di release)');
  // in debug non chiude la form di login se la history è vuota
  // se si verifica questa situazione è infatti possibile che debba
  // essere visualizzato un messaggio di errore
  if (DebugHook = 0) or (WR000DM.History.Count > 0) then
    Release;

  if (Parametri.Applicazione = 'STAGIU') and (A000GetInibizioni('TAG','346') <> 'N') then
  begin
    with WR000DM do
    begin
      OperSQL.SQL.Clear;
      OperSQL.SQL.Text:='select count(*) from SG310_INCALLINEAMENTI where STATO = ''D''';
      OperSQL.Execute;
      if (OperSQL.RowCount > 0) and (StrToIntDef(VarToStr(OperSQL.Field(0)),0) > 0) then
        R180MessageBox('Attenzione: sono state apportate modifiche alle strutture aziendali degli incarichi. Procedere all''allineamento tramite la funzione Ambiente\Allineamento incarichi.','INFORMA');
    end;
  end;
end;

procedure TWR101FLogin.RicercaAutomaticaAzienda;
// effettua la ricerca automatica di un'azienda valida per il login nei seguenti casi:
// - l'azienda non è specificata
// - l'azienda è specificata ma l'utente indicato non è valido
// IMPORTANTE: la ricerca è effettuata sulle aziende con LOGIN_USR_ABILITATO = 'S'
var
  LRicercaAzienda: Boolean;
  LElencoAziende: String;
begin
  FForzaAziendaVisibile:=False;

  // determina se è necessario effettuare la ricerca automatica dell'azienda di accesso
  if edtAzienda.Text = '' then
  begin
    // se l'azienda non è specificata imposta il flag per cercare un'azienda valida
    LRicercaAzienda:=True;
  end
  else
  begin
    // l'azienda è specificata
    // verifica se l'utente indicato è valido oppure no
    LRicercaAzienda:=False;
    W001FPasswordDtM.selAziendaUtente.Close;
    W001FPasswordDtM.selAziendaUtente.SetVariable('AZIENDA',edtAzienda.Text);
    W001FPasswordDtM.selAziendaUtente.SetVariable('UTENTE',edtUtente.Text);
    W001FPasswordDtM.selAziendaUtente.Open;

    // se l'azienda non esiste oppure l'utente non esiste sull'azienda indicata
    // imposta il flag per cercare un'azienda valida
    LRicercaAzienda:=W001FPasswordDtM.selAziendaUtente.RecordCount = 0;

    W001FPasswordDtM.selAziendaUtente.Close;
  end;

  if not LRicercaAzienda then
    Exit;

  // estrae le aziende con riconoscimento automatico in cui è presente l'utente indicato
  W001FPasswordDtM.selDistAzienda.Close;
  W001FPasswordDtM.selDistAzienda.ClearVariables;
  W001FPasswordDtM.selDistAzienda.SetVariable('UTENTE',edtUtente.Text);
  W001FPasswordDtM.selDistAzienda.SetVariable('I060','N');
  W001FPasswordDtM.selDistAzienda.Open;

  // valuta il tipo di impostazione automatica a seconda del login interattivo / da portale esterno
  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.ini
  if LoginEsterno <> 'S' then
  begin
    // casistiche:
    // 0   record -> errore utente inesistente
    // 1   record -> ok (si rifà alla gestione precedente)
    // N>1 record -> proporre lista aziende da selezionare
    if W001FPasswordDtM.selDistAzienda.RecordCount = 0 then
    begin
      // utente inesistente
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
      ActiveControl:=edtUtente;
      raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_FALLITA));
    end
    else if W001FPasswordDtM.selDistAzienda.RecordCount = 1 then
    begin
      // imposta automaticamente l'unica azienda valida
      edtAzienda.Text:=W001FPasswordDtM.selDistAzienda.FieldByName('AZIENDA').AsString;
    end
    else if W001FPasswordDtM.selDistAzienda.RecordCount > 1 then
    begin
      // utente presente in più aziende

      // nel caso in cui l'azienda fosse non visibile, ne forza la visibilità
      FForzaAziendaVisibile:=True;

      // propone la lista delle aziende da scegliere
      LElencoAziende:='';
      W001FPasswordDtM.selDistAzienda.First;
      while not W001FPasswordDtM.selDistAzienda.Eof do
      begin
        LElencoAziende:=LElencoAziende + W001FPasswordDtM.selDistAzienda.FieldByName('AZIENDA').AsString.QuotedString + ',';
        W001FPasswordDtM.selDistAzienda.Next;
      end;
      jqAutocomplete.OnReady.Text:=
        'var elementi = [' + LElencoAziende.Substring(0,LElencoAziende.Length - 1) + '];' + CRLF +
        '$("#' + edtAzienda.HTMLName + '").autocomplete({' + CRLF +
        '  source: elementi,' + CRLF +
        '  delay: 0,' + CRLF +
        '  minLength: 0' + CRLF +
        '}).focus(function(){ ' + CRLF +
        '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
        '}); ';
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_MSG_SEL_AZIENDA));
    end;
  end
  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.fine
  else if LoginEsterno = 'S' then
  begin
    // propone un'azienda valida per l'accesso: viene impostata la prima azienda valida
    if W001FPasswordDtM.selDistAzienda.RecordCount > 0 then
    begin
      edtAzienda.Text:=W001FPasswordDtM.selDistAzienda.FieldByName('AZIENDA').AsString;
    end;
  end;

  W001FPasswordDtM.selDistAzienda.Close;
end;

procedure TWR101FLogin.edtAziendaSubmit(Sender: TObject);
begin
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.edtAziendaSubmit - inizio metodo');
  lnkAccediClick(nil);
  DebugToFile(GGetWebApplicationThreadVar,'TWR101FLogin.edtAziendaSubmit - fine metodo');
end;

end.
