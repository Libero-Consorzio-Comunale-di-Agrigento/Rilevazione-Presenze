unit WM000UMain;

interface

uses
  uMain,
  L021Call,
  B110USharedTypes,
  WM000UConstants,
  WM000UTypes,
  System.SysUtils,
  System.StrUtils,
  Variants, Classes,
  uniGUITypes, uniGUIAbstractClasses, uniGUIBaseClasses,
  uniGUIClasses, uniGUImForm, uniGUImJSForm,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, Data.SqlExpr, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.FireDACJSONReflect, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin,
  uniImageList, uniGUIFrame, uniTreeView, unimNestedList,
  Vcl.Forms, Vcl.Controls, WM018UMessaggisticaMW, WM001UCambioPasswordMW,
  A000UCostanti, uniTreeMenu, unimTreeMenu, Generics.Defaults,
  Generics.Collections, Contnrs, System.Actions, Vcl.ActnList, WM000UFrameBase,
  unimPanel, MedpUnimPanelBase, WM009UNotifiche, uniTimer, unimTimer, A000UInterfaccia,
  uniLabel, unimLabel, MedpUnimLabel, MedpUnimMainMenu;

type

  TMenuItem = class(TObject)
    private
      FTag: Integer;
      FS: String;
      FTitolo: String;
      FClasse: String;
      FEnabled: Boolean;
      FVisible: Boolean;
    public
      property Tag: Integer read FTag;
      property S: String read FS;
      property Titolo: String read FTitolo;
      property Classe: String read FClasse;
      property Enabled: Boolean read FEnabled;
      property Visible: Boolean read FVisible;
      constructor Create(PTag: Integer; PS: String; PTitolo, PClasse: String; PEnabled, PVisible: Boolean);
  end;

  TMenu = class(TObject)
    private
      FListaMenuItem: TObjectList;
      function GetCount: Integer;
      function GetMenuItem(Index: integer): TMenuItem;
      class function CompareTag(Item1, Item2: Pointer): Integer; static;
    public
      property Count : Integer read GetCount;
      property Lista[Index: integer]: TMenuItem read GetMenuItem;
      constructor Create;
      destructor Destroy; override;
      procedure Refresh(const PDatiGenerali: TOutputDatiGenerali);
      function GetMenuItemByTag(PTag: Integer): TMenuItem;
      function GetMenuItemByTitolo(PTitolo: String): TMenuItem;
      function GetMenuItemByCodiceClasse(PCodiceClasse: String): TMenuItem;
  end;


  TWM000FMain = class(TUnimForm)
    ActionList: TActionList;
    CambioProfilo: TAction;
    MainPanel: TMedpUnimPanelBase;
    pnlFrameBase: TMedpUnimPanelBase;
    pnlFrame: TMedpUnimPanelBase;
    pnlMainMenu: TMedpUnimMainMenu;
    lblFrameTitle: TMedpUnimLabel;

    procedure UnimFormCreate(Sender: TObject);
    procedure pnlMenuItemClick(Sender: TObject);
    procedure UnimFormDestroy(Sender: TObject);
    procedure CambioProfiloExecute(Sender: TObject);
    procedure UnimFormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblFrameTitleAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    FIsPhone: Boolean;
    FLastFrame: TUniFrame;
    FLastClassName: String;

    FMenu: TMenu;

    procedure ShowFrame(const ACaption: string);
    procedure ShowFrameForm(AClass: TUniFrameClass; const ACaption: string; ATag: Integer);
    procedure CreaMenu;
    function AggiornaTitolo(PTitolo: String): String;
    procedure CambioProfiloCallBack(Sender: TComponent; AResult: Integer);
    procedure ApriFrame(PMenuItem: TMenuItem);
    procedure GestioneIconeAndroidIOS(PCartellaFiles: String); //uguale a form di login
    procedure ClearCookies;
    procedure AggiornaNotifiche;
  public
  end;

function WM000FMain: TWM000FMain;

implementation

{$R *.dfm}

uses
  uniGUIVars,
  uniGUIApplication,
  WM000UMainModule,
  WM000UServerModule,
  WM000UFrameForm, WM002UInfo;

function WM000FMain: TWM000FMain;
begin
  Result:=TWM000FMain(WM000FMainModule.GetFormInstance(TWM000FMain));
end;

procedure TWM000FMain.UnimFormCreate(Sender: TObject);
var LMenuItem: TMenuItem;
    WM018MW: TWM018FMessaggisticaMW;
    WM001MW: TWM001FCambioPasswordMW;
    LMessObbligatoriPresenti: Boolean;
    LPasswordScaduta: Boolean;
begin
  GestioneIconeAndroidIOS(WM000FServerModule.FilesFolderURL);

  LPasswordScaduta:=False;
  //verifico l'obbligo del cambio password solo se non è previsto un login esterno o l'autenticazione su dominio
  if not ((WM000FServerModule.ParConfig.LoginEsterno = 'S') or A000SessioneIrisWIN.Parametri.AuthDom) then
  begin
    SessioneOracle.Preferences.UseOci7:=False;
    SessioneOracle.LogOn;
    SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
    try
      WM001MW:=TWM001FCambioPasswordMW.Create(A000SessioneIrisWIN, WM000FServerModule.ParConfig.LoginEsterno);
      try
        LPasswordScaduta:=WM001MW.GetPasswordScaduta;
      finally
        FreeAndNil(WM001MW);
      end;
    finally
      SessioneOracle.LogOff;
    end;
  end;

  FMenu:=TMenu.Create;
  CreaMenu;
  AggiornaNotifiche;
  pnlMainMenu.Title:=WM000FMainModule.InfoLogin.DatiGenerali.Parametri.RagioneSociale;
  with WM000FMainModule.InfoClient.VersioneApp do
    Self.Caption:=AggiornaTitolo('IrisAPP ' + Versione + '(' + Build+  ')');

  FIsPhone:=(upPhone in UniSession.UniPlatform);

  // in caso di dispositivo mobile il navigator risulta a tutto schermo
  if FIsPhone then
    pnlMainMenu.LayoutConfig.Width:='100%'
  else
  begin
    with pnlMainMenu.BoxModel.CSSMargin do
    begin
      Top:='1px';
      Right:='1px';
    end;
  end;

  if not LPasswordScaduta then //se la password è scaduta, non apro le altre funzionalità
  begin
    //se sono presenti messaggi obbligatori da visualizzare, la funzionalità è abilitata ed è previsto il blocco da
    //parametro aziendale, apre il frame dei messaggi
    if (WM000FMainModule.InfoLogin.DatiGenerali.GetAbilitazioneTag(445) <> 'N')
        and (Parametri.CampiRiferimento.C90_MessaggiObbligatoriBloccanti = 'S') then
    begin
      WM018MW:=TWM018FMessaggisticaMW.Create(A000SessioneIrisWIN);
      try
        SessioneOracle.Preferences.UseOci7:=False;
        SessioneOracle.LogOn;
        SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
        try
          LMessObbligatoriPresenti:=WM018MW.ObbligatoriDaLeggerePresentiAgg;
        finally
          SessioneOracle.LogOff;
        end;
        if LMessObbligatoriPresenti then
        begin
          LMenuItem:=FMenu.GetMenuItemByTag(445);
          if Assigned(LMenuItem) then
            if LMenuItem.Enabled then
            begin
              ApriFrame(LMenuItem);
              Exit;
            end;
        end;
      finally
        FreeAndNil(WM018MW);
      end;
    end;

    //Avvio della pagina iniziale da file ini
    if WM000FServerModule.ParConfig.PaginaIniziale <> '' then
    begin
      LMenuItem:=FMenu.GetMenuItemByCodiceClasse(WM000FServerModule.ParConfig.PaginaIniziale);

      if Assigned(LMenuItem) then
        if LMenuItem.Enabled then
          ApriFrame(LMenuItem);
    end
    else if not FIsPhone then  //se sono su tablet, apro il frame con tag 0 abilitato
    begin
      LMenuItem:=FMenu.GetMenuItemByTag(0);
      if Assigned(LMenuItem) then
        if LMenuItem.Enabled then
          ApriFrame(LMenuItem);
    end;
  end
  else //ma solo il cambio password
  begin
    WM002FInfo.ObbligoCambioPassword:=True;
    WM002FInfo.Show(CambioProfiloCallBack);
  end;
end;

procedure TWM000FMain.lblFrameTitleAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  AggiornaNotifiche; //aggiornamento asincrono delle notifiche
end;

procedure TWM000FMain.UnimFormClose(Sender: TObject; var Action: TCloseAction);
begin
  //se è presente la pagina Home nel file ini ci vado
  if WM000FServerModule.ParConfig.Home <> '' then
  begin
    Action:=caNone;
    UniApplication.Terminate(Format('<script>window.location.href = "%s";</script>',[WM000FServerModule.ParConfig.Home]));
  end
  //altrimenti, se sono presenti i cookie salvati vado su una pagina bianca
  else if UniApplication.Cookies.GetCookie(COOKIE_AZIENDA) <> '' then
  begin
    Action:=caNone;
    UniApplication.Terminate(Format('<script>window.location.href = "%s";</script>',['about:blank']));
  end;
  //se non sono presenti i cookie salvati vado normalmente alla pagina di login
end;

procedure TWM000FMain.UnimFormDestroy(Sender: TObject);
begin
  FreeAndNil(FLastFrame);
  FreeAndNil(FMenu);
end;

procedure TWM000FMain.AggiornaNotifiche;
var SessioneConnessa: Boolean;
    i: Integer;
begin
  with WM000FMainModule do
  begin
    SessioneConnessa:=SessioneOracle.Connected;
    //se entro con una sessione oracle già connessa, uso quella e non la chiudo al termine
    if not SessioneConnessa then
    begin
      SessioneOracle.Preferences.UseOci7:=False;
      SessioneOracle.LogOn;
      SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
    end;
    try
      Notifiche.AggiornaNotifiche(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, InfoLogin.DatiGenerali, A000SessioneIrisWIN);

      //aggiornamento delle notifiche nel menu principale
      for i:=0 to FMenu.Count-1 do
      begin
        if FMenu.Lista[i].Visible then
          pnlMainMenu.UpdateNotifica(FMenu.Lista[i].Tag, Notifiche.NotificheByTag[FMenu.Lista[i].Tag]);
      end;

    finally
      if not SessioneConnessa then
        SessioneOracle.LogOff;
    end;
  end;
end;

function TWM000FMain.AggiornaTitolo(PTitolo: String): String;
begin
  Result:='<span style="display: flex; align-items: center;"><img src="' + WM000FServerModule.FilesFolderURL + 'favicon/favicon-96x96.png" width="35" height="35"><p>&nbsp&nbsp' + PTitolo + '</p></span>';
end;

procedure TWM000FMain.CambioProfiloExecute(Sender: TObject);
begin
  WM002FInfo.ObbligoCambioPassword:=False;
  WM002FInfo.Show(CambioProfiloCallBack);
end;

procedure TWM000FMain.CambioProfiloCallBack(Sender: TComponent; AResult: Integer);
var LMenuItem: TMenuItem;
begin
  if AResult = mrOk then
  begin
    CreaMenu;
    AggiornaNotifiche;

    with WM000FMainModule.InfoClient.VersioneApp do
      Self.Caption:=AggiornaTitolo('IrisAPP ' + Versione + '(' + Build+  ')');

    if not FIsPhone then
    begin
      LMenuItem:=FMenu.GetMenuItemByTag(0);
      if Assigned(LMenuItem) then
        if LMenuItem.Enabled then
          ApriFrame(LMenuItem);
    end
    else
      FreeAndNil(FLastFrame);
  end;
end;

procedure TWM000FMain.ClearCookies;
begin
  with UniApplication.Cookies do
  begin
    SetCookie(COOKIE_AZIENDA, '', Date-10);
    SetCookie(COOKIE_UTENTE, '', Date-10);
    SetCookie(COOKIE_PASSWORD, '', Date-10);
    SetCookie(COOKIE_TOKEN, '', Date-10);
    SetCookie(COOKIE_OAUTH2_ACCESSTOKEN, '', Date-10);
    SetCookie(COOKIE_OAUTH2_REFRESHTOKEN, '', Date-10);
    SetCookie(COOKIE_OAUTH2_TOKENTYPE, '', Date-10);
  end;
end;

procedure TWM000FMain.CreaMenu;
var i : integer;
begin
  Fmenu.Refresh(WM000FMainModule.InfoLogin.DatiGenerali);

  pnlMainMenu.Clear;

  for i := 0 to FMenu.Count-1 do
  begin
    if FMenu.Lista[i].Visible then
      pnlMainMenu.Add(FMenu.Lista[i].Titolo, 0, FMenu.Lista[i].Tag, pnlMenuItemClick); //aggiornamento delle notifiche fatto a parte
  end;

  pnlMainMenu.Visible:=True;
end;

procedure TWM000FMain.pnlMenuItemClick(Sender: TObject);
var
  LMenuItem: TMenuItem;
begin
  //------------------------------------------------------------------------------------------------
  //[TEMP] transizione da password a token cifrato [10.8(0)] da eliminare in futuro
  if UniApplication.Cookies.Values[COOKIE_PASSWORD] <> '' then
  begin
    UniApplication.Cookies.SetCookie(COOKIE_UTENTE, '0', Date-10);
    UniApplication.Cookies.SetCookie(COOKIE_PASSWORD, '0', Date-10);
  end;
  //------------------------------------------------------------------------------------------------

  // estrae le info della funzione selezionata
  LMenuItem:=FMenu.GetMenuItemByTag((Sender as TComponent).Tag);

  if Assigned(LMenuItem) then
    ApriFrame(LMenuItem);
end;

//Gestione frame desktop
procedure TWM000FMain.ShowFrame(const ACaption: string);
begin
  // titolo frame: nome funzione selezionata
  lblFrameTitle.Caption:=ACaption;
  FLastFrame.Parent:=pnlFrame;
end;

//Gestione frame mobile
procedure TWM000FMain.ShowFrameForm(AClass: TUniFrameClass; const ACaption: string; ATag: Integer);
var
  LFrameForm: TUnimForm;
  LFrame: TUniFrame;
begin
  // salva il riferimento del form contenitore
  LFrameForm:=WM000FFrameForm;

  // crea un frame e lo inserisce nel form contenitore
  LFrame:=AClass.Create(LFrameForm);
  LFrame.Parent:=LFrameForm;
  if LFrame is TWM000FFrameBase then
    (LFrame as TWM000FFrameBase).AbilitazioneFunzione:=WM000FMainModule.InfoLogin.DatiGenerali.GetAbilitazioneTag(ATag);

  // imposta caption form e la visualizza
  LFrameForm.Caption:=AggiornaTitolo(ACaption);
  LFrameForm.Show;
end;

procedure TWM000FMain.ApriFrame(PMenuItem: TMenuItem);
var LFMClass : TUniFrameClass;
    LFMClassName: String;
begin
  // istanzia il frame creando un oggetto della classe associata al menu item
  LFMClassName:=PMenuItem.Classe;
  LFMClass:=TUniFrameClass(FindClass(LFMClassName));

  if FIsPhone then
    ShowFrameForm(LFMClass, PMenuItem.Titolo, PMenuItem.Tag)
  else if LFMClassName <> FLastClassName then
  begin
    FLastFrame.Free;
    FLastClassName:=LFMClassName;
    FLastFrame:=LFMClass.Create(Self);
    if FLastFrame is TWM000FFrameBase then
      (FLastFrame as TWM000FFrameBase).AbilitazioneFunzione:=WM000FMainModule.InfoLogin.DatiGenerali.GetAbilitazioneTag(PMenuItem.Tag);

    ShowFrame('(' + PMenuItem.S + ') ' + PMenuItem.Titolo);
  end;
end;

procedure TWM000FMain.GestioneIconeAndroidIOS(PCartellaFiles: String);  //uguale a form di login
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

{$region 'TMenuItem'}
constructor TMenuItem.Create(PTag: Integer; PS: String; PTitolo, PClasse: String; PEnabled, PVisible: Boolean);
begin
  FTag:=PTag;
  FS:=PS;
  FTitolo:=PTitolo;
  FClasse:=PClasse;
  FEnabled:=PEnabled;
  FVisible:=PVisible;
end;
{$endregion}

{$region 'TMenu'}
constructor TMenu.Create;
begin
  FListaMenuItem:=TObjectList.Create(true);
end;

destructor TMenu.Destroy;
begin
  FreeAndNil(FListaMenuItem);
  inherited;
end;

function TMenu.GetCount: Integer;
begin
   Result:= FListaMenuItem.Count;
end;

function TMenu.GetMenuItem(Index: integer): TMenuItem;
begin
  if (Index >=0) and (Index < FListaMenuItem.Count) then
    Result:=FListaMenuItem[Index] as TMenuItem
  else
    Result:=nil;
end;

function TMenu.GetMenuItemByTag(PTag: Integer): TMenuItem;
var LMenuItem: TMenuItem;
begin
  Result:=nil;

  for LMenuItem in FListaMenuItem do
  begin
    if (LMenuItem.Tag = PTag) and LMenuItem.Visible then
    begin
      Result:=LMenuItem;
      Break;
    end;
  end;
end;

function TMenu.GetMenuItemByTitolo(PTitolo: String): TMenuItem;
var LMenuItem: TMenuItem;
begin
  Result:=nil;

  for LMenuItem in FListaMenuItem do
  begin
    if (LMenuItem.Titolo = PTitolo) and LMenuItem.Visible then
      Result:=LMenuItem;
  end;
end;

function TMenu.GetMenuItemByCodiceClasse(PCodiceClasse: String): TMenuItem;
var LMenuItem: TMenuItem;
begin
  Result:=nil;

  for LMenuItem in FListaMenuItem do
  begin
    if LMenuItem.Classe.Substring(1, 5) = PCodiceClasse then
      Result:=LMenuItem;
  end;
end;

procedure TMenu.Refresh(const PDatiGenerali: TOutputDatiGenerali);
var LProfiloResp, LFiltroAnagIndividuale: Boolean;
    LFunzione: TFunzioneMenu;
    LAbil, LTitolo: String;
    LElemL021: TFunzioniDisponibili;
    LEnabled, LVisible: Boolean;
    LMenuItem: TMenuItem;
begin

  FListaMenuItem.Clear;

  if (PDatiGenerali <> nil) then
  begin
    LProfiloResp:=PDatiGenerali.Responsabile;
    LFiltroAnagIndividuale:=PDatiGenerali.DatiDipendenti.NumDipendentiDiversiDaProgressivo = 0;
  end
  else
  begin
    LProfiloResp:=False;
    LFiltroAnagIndividuale:=False;
  end;

  for LFunzione in FUNZIONI_MENU do
  begin
    if LFunzione.Tag <= 0 then
    begin
      LTitolo:=LFunzione.Titolo;
      LAbil:='S';
    end
    else
    begin
      LElemL021:=L021ElementoByTag(LFunzione.Tag);
      LTitolo:=IfThen(LFunzione.Titolo<>'', LFunzione.Titolo, LElemL021.N);

      if PDatiGenerali <> nil then
        LAbil:=PDatiGenerali.GetAbilitazioneTag(LFunzione.Tag) //N, S, R=Read-only
      else
        LAbil:='N';
    end;

    LEnabled:=(LAbil <> 'N') and (LFunzione.Abilitazione.IsOk(LFiltroAnagIndividuale,LProfiloResp));
    LVisible:=LEnabled;

    LMenuItem:=TMenuItem.Create(LFunzione.Tag, LFunzione.S, LTitolo, LFunzione.Classe, LEnabled, LVisible);
    FListaMenuItem.Add(LMenuItem);
  end;

  FListaMenuItem.Sort((@TMenu.CompareTag));  //ordino gli elementi per tag
end;

class function TMenu.CompareTag(Item1, Item2: Pointer): Integer;
begin
  if TMenuItem(Item1).Tag=TMenuItem(Item2).Tag then
    Result:=0
  else if TMenuItem(Item1).Tag< TMenuItem(Item2).Tag then
    Result:=-1
  else
    Result:=1;
end;

{$endregion}

initialization
  RegisterAppFormClass(TWM000FMain);

end.
