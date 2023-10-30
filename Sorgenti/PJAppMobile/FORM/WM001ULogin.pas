unit WM001ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIRegClasses, uniGUIForm, uniGUImForm, uniGUImJSForm,
  uniGUIBaseClasses, unimPanel, MedpUnimPanelBase, uniLabel, unimLabel,
  MedpUnimLabel, uniEdit, unimEdit, MedpUnimEdit, unimToggle, A000UCostanti,
  uniButton, uniBitBtn, unimBitBtn, MedpUnimButton, WM000UMessageDlg, uniImage,
  unimImage, Vcl.Imaging.pngimage, WM001ULoginOAuth2MW, WM000UConstants, WM001URecuperoPasswordMW,
  A000UInterfaccia, A000USessione, C180FunzioniGenerali, uniPanel, uniHTMLFrame,
  unimHTMLFrame, MedpUnimHTMLFrame, MedpUnimReCAPTCHA;

type
  TWM001FLogin = class(TUnimLoginForm)
    MainPanel: TMedpUnimPanelBase;
    pnlCentrato: TMedpUnimPanelBase;
    btnAccedi: TMedpUnimButton;
    pnlSessioneAttiva: TMedpUnimPanelBase;
    lblSessioneAttiva: TMedpUnimLabel;
    tglSessioneAttiva: TUnimToggle;
    pnlAzienda: TMedpUnimPanelBase;
    lblAzienda: TMedpUnimLabel;
    edtAzienda: TMedpUnimEdit;
    pnlUtente: TMedpUnimPanelBase;
    lblUtente: TMedpUnimLabel;
    edtUtente: TMedpUnimEdit;
    pnlPassword: TMedpUnimPanelBase;
    lblPassword: TMedpUnimLabel;
    edtPassword: TMedpUnimEdit;
    pnlProfilo: TMedpUnimPanelBase;
    lblProfilo: TMedpUnimLabel;
    edtProfilo: TMedpUnimEdit;
    imgLogo: TUnimImage;
    lblRecuperaPassword: TMedpUnimLabel;
    lblTitolo: TMedpUnimLabel;
    pnlReCAPTCHA: TMedpUnimPanelBase;
    frmReCAPTCHA: TMedpUnimReCAPTCHA;
    procedure UnimLoginFormCreate(Sender: TObject);
    procedure btnAccediClick(Sender: TObject);
    procedure RecuperaPasswordClick(Sender: TObject);
    procedure frmReCAPTCHAExpired(Sender: TObject);
    procedure frmReCAPTCHAVerified(Sender: TObject);
  private
    procedure LoginInterno;
    procedure LoginOAuth2;
    function RichiestoReCAPTCHA: Boolean;
    procedure GestioneIconeAndroidIOS(PCartellaFiles: String);
  public
    { Public declarations }
  end;

function WM001FLogin: TWM001FLogin;

implementation

{$R *.dfm}

uses
  uniGUIVars, WM000UMainModule, uniGUIApplication, WM000UServerModule;

function WM001FLogin: TWM001FLogin;
begin
  Result := TWM001FLogin(WM000FMainModule.GetFormInstance(TWM001FLogin));
end;

procedure TWM001FLogin.UnimLoginFormCreate(Sender: TObject);
begin
  with WM000FServerModule do
  begin
     //gestisco visibilità del titolo
    if ParConfig.TitoloIrisAPP <> '' then
    begin
      lblTitolo.Visible:=True;
      lblTitolo.Caption:=ParConfig.TitoloIrisAPP;
    end
    else
      lblTitolo.Visible:=False;

    //gestisco visibilità/abilitazione dell'azienda
    if ParConfig.StatoAzienda = 'N' then
      pnlAzienda.Visible:=False
    else if ParConfig.StatoAzienda = 'R' then
      edtAzienda.Enabled:=False;

    //gestisco visibilità/abilitazione del profilo
    if ParConfig.StatoProfilo = 'N' then
      pnlProfilo.Visible:=False
    else if ParConfig.StatoAzienda = 'R' then
      edtProfilo.Enabled:=False;

    //disabilito la possibilità di salvare le credenziali nei cookie
    pnlSessioneAttiva.Visible:=ParConfig.CookieCredenziali;
    //abilito il link di recupero della password
    lblRecuperaPassword.Visible:=ParConfig.RecuperoPassword;

    edtAzienda.Text:=ParConfig.Azienda;
    edtProfilo.Text:=ParConfig.Profilo;

    //abilito ReCAPTCHA solo se richiesto da parametro su file di configurazione
    if RichiestoReCAPTCHA then
    begin
      pnlReCAPTCHA.Visible:=True;
      frmReCAPTCHA.SiteKey:=WM000FServerModule.ParConfig.SiteKeyReCAPTCHA;
      frmReCAPTCHA.SecretKey:=WM000FServerModule.ParConfig.SecretKeyReCAPTCHA;
      frmReCAPTCHAExpired(Self);
    end;

    GestioneIconeAndroidIOS(FilesFolderURL);
  end;
end;

procedure TWM001FLogin.btnAccediClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  //per sicurezza esco se ReCAPTCHA è richiesto e non è verificato
  if RichiestoReCAPTCHA and not frmReCAPTCHA.Verified then
    Exit;

  with WM000FMainModule.InfoLogin do
  begin
    LResCtrl:=AggiornaSessioneIrisWin(edtAzienda.Text);

    if not LResCtrl.Ok then
    begin
      ShowMessage(LResCtrl.Messaggio);
      Exit;
    end;

    if SessioneIrisWin.Parametri.CampiRiferimento.C90_SSO_Tipo = 'OAUTH2' then  //se è richiesta l'aut. OAuth 2.0
      LoginOAuth2
    else
      LoginInterno;
  end;
end;

procedure TWM001FLogin.LoginOAuth2;
var LLoginOAuth2: TWM001FLoginOAuth2MW;
    LResCtrl: TResCtrl;
    LInfoUser: String;
    LAccessToken: String;
    LTokenType: String;
    LRefreshToken: String;
begin
  try
    with WM000FMainModule.InfoLogin.SessioneIrisWin.Parametri.CampiRiferimento do
    begin
      LLoginOAuth2:=TWM001FLoginOAuth2MW.Create(C90_SSO_OAUTH2ClientID,
                                                C90_SSO_OAUTH2Passphrase,
                                                C90_SSO_OAUTH2UrlGetToken,
                                                C90_SSO_OAUTH2UrlGetUser,
                                                C90_SSO_OAUTH2InfoUser);
    end;

    LResCtrl:=LLoginOAuth2.Login(edtUtente.Text, edtPassword.Text, LInfoUser, LAccessToken, LRefreshToken, LTokenType);

    if LResCtrl.Ok then
    begin
      with WM000FMainModule do   //faccio il login su B110
      begin
        LResCtrl:=InfoLogin.LoginB110(B110ClientModule,
                                      InfoClient,
                                      edtAzienda.Text,
                                      LInfoUser,
                                      PASSWORD_LOGIN_ESTERNO,
                                      edtProfilo.Text);
      end;

      if LResCtrl.Ok then      //salvo i dati nei cookies per il login automatico
      begin
        with UniApplication.Cookies do
        begin
          SetCookie(COOKIE_AZIENDA, edtAzienda.Text, Date+999);
          SetCookie(COOKIE_OAUTH2_ACCESSTOKEN, LAccessToken, Date+999);
          SetCookie(COOKIE_OAUTH2_REFRESHTOKEN, LRefreshToken, Date+999);
          SetCookie(COOKIE_OAUTH2_TOKENTYPE, LTokenType, Date+999);
        end;

        ModalResult:=mrOK;
      end
      else
        ShowMessage(LResCtrl.Messaggio)
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  finally
    FreeAndNil(LLoginOAuth2);
  end;
end;

procedure TWM001FLogin.LoginInterno;
var LResCtrl: TResCtrl;
    LScadenzaCookie: Double;
begin
  //login su B110
  with WM000FMainModule do
  begin
    LResCtrl:=InfoLogin.LoginB110(B110ClientModule,
                                  InfoClient,
                                  edtAzienda.Text,
                                  edtUtente.Text,
                                  edtPassword.Text,
                                  edtProfilo.Text);
  end;

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
  begin
    //salvataggio delle credenziali nei cookie se richiesto
    if tglSessioneAttiva.Toggled then
    begin
      if WM000FMainModule.InfoLogin.DatiGenerali.Parametri.ValiditaPassword <> 0 then
        LScadenzaCookie:=Date+(WM000FMainModule.InfoLogin.DatiGenerali.Parametri.ValiditaPassword *30)
      else
        LScadenzaCookie:=Date+999;

      with UniApplication.Cookies do   //salvo i dati nei cookies per il login automatico
      begin
        SetCookie(COOKIE_AZIENDA, Trim(edtAzienda.Text), LScadenzaCookie);
        SetCookie(COOKIE_TOKEN, R180RDL_ECB_Encrypt(Trim(edtUtente.Text) + COOKIE_SEP + edtPassword.Text, COOKIE_PASSPHRASE), LScadenzaCookie);
      end;
    end;

    ModalResult:=mrOK;
  end;
end;

procedure TWM001FLogin.RecuperaPasswordClick(Sender: TObject);
var LRecuperoPassword: TWM001FRecuperoPasswordMW;
    LResCtrl: TResCtrl;
begin
  //per sicurezza esco se ReCAPTCHA è richiesto e non è verificato
  if RichiestoReCAPTCHA and not frmReCAPTCHA.Verified then
    Exit;

  LRecuperoPassword:=nil;

  with WM000FMainModule.InfoLogin do
  begin
    LResCtrl:=AggiornaSessioneIrisWin(edtAzienda.Text, edtUtente.Text);

    if not LResCtrl.Ok then
    begin
      ShowMessage(LResCtrl.Messaggio);
      Exit;
    end;

    SessioneOracle.Preferences.UseOci7:=False;
    SessioneOracle.LogOn;
    SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
    try
      LRecuperoPassword:=TWM001FRecuperoPasswordMW.Create(SessioneIrisWin);
      LResCtrl:=LRecuperoPassword.RecuperaPassword(edtAzienda.Text, edtUtente.Text);

      if LResCtrl.Ok then
        ShowMessage('La password è stata inoltrata via email. Controllare la propria casella di posta elettronica registrata su IrisWeb')
      else
        ShowMessage(LResCtrl.Messaggio);
    finally
      FreeAndNil(LRecuperoPassword);
      SessioneOracle.LogOff;
    end;
  end;
end;

function TWM001FLogin.RichiestoReCAPTCHA: Boolean;
var tempApplicationURL, tempUrlReCAPTCHA: String;
begin
  Result:=False;
  with WM000FServerModule.ParConfig do
  begin
    if UrlReCAPTCHA <> '' then
    begin
      tempApplicationURL:=LowerCase(UniSession.Url).Replace('http://','').Replace('https://','');
      tempUrlReCAPTCHA:=LowerCase(UrlReCAPTCHA).Replace('http://','').Replace('https://','');

      if tempApplicationURL.StartsWith(tempUrlReCAPTCHA) then
      begin
        Result:=True;
        Exit;
      end;
    end;
  end;
end;

procedure TWM001FLogin.frmReCAPTCHAExpired(Sender: TObject);
begin
  btnAccedi.Enabled:=frmReCAPTCHA.Verified;
  lblRecuperaPassword.Enabled:=frmReCAPTCHA.Verified;
  lblRecuperaPassword.OnClick:=nil;
  lblRecuperaPassword.ScreenMask.Enabled:=frmReCAPTCHA.Verified;
end;

procedure TWM001FLogin.frmReCAPTCHAVerified(Sender: TObject);
begin
  btnAccedi.Enabled:=frmReCAPTCHA.Verified;
  lblRecuperaPassword.Enabled:=frmReCAPTCHA.Verified;
  lblRecuperaPassword.OnClick:=RecuperaPasswordClick;
  lblRecuperaPassword.ScreenMask.Enabled:=frmReCAPTCHA.Verified;
end;

procedure TWM001FLogin.GestioneIconeAndroidIOS(PCartellaFiles: String);
const ExtJSCreateChild = 'Ext.get(document.getElementsByTagName("head")[0]).createChild';
begin
  // gestione icone browser/android/ios
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/apple-icon-57x57.png", rel: "apple-touch-icon", sizes: "57x57"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/apple-icon-60x60.png", rel: "apple-touch-icon", sizes: "60x60"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/apple-icon-72x72.png", rel: "apple-touch-icon", sizes: "72x72"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/apple-icon-76x76.png", rel: "apple-touch-icon", sizes: "76x76"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/apple-icon-114x114.png", rel: "apple-touch-icon", sizes: "114x114"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/apple-icon-120x120.png", rel: "apple-touch-icon", sizes: "120x120"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/apple-icon-144x144.png", rel: "apple-touch-icon", sizes: "144x144"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/apple-icon-152x152.png", rel: "apple-touch-icon", sizes: "152x152"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/apple-icon-180x180.png", rel: "apple-touch-icon", sizes: "180x180"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/android-icon-192x192.png", rel: "icon", sizes: "192x192", type: "image/png"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/favicon-32x32.png", rel: "icon", sizes: "32x32", type: "image/png"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/favicon-96x96.png", rel: "icon", sizes: "96x96", type: "image/png"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/favicon-16x16.png", rel: "icon", sizes: "16x16", type: "image/png"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "link", href: "' + PCartellaFiles + 'favicon/manifest.json", rel: "manifest"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "meta", name: "msapplication-TileColor", content: "#ffffff"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "meta", name: "msapplication-TileImage", content: "' + PCartellaFiles + 'favicon/ms-icon-144x144.png"});');
  UniSession.AddJS(ExtJSCreateChild +'({ tag: "meta", name: "theme-color", content: "#157fcc"});');
end;

initialization
  RegisterAppFormClass(TWM001FLogin);

end.
