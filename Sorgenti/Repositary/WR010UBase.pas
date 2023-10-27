unit WR010UBase;

interface

uses
  {$IFDEF madExcept}
  madExcept,
  {$ENDIF madExcept}
  A000UMessaggi,
  {$IFNDEF INTRAWEBSVC}WC012UVisualizzaFileFM,{$ENDIF}
  C180FunzioniGenerali, FunzioniGenerali, C190FunzioniGeneraliWeb,
  A000UInterfaccia, A000USessione, A000UCostanti, L021Call, Math, Variants,
  IW.Browser.Browser, IW.Browser.Chrome, IW.Browser.Firefox,
  IW.Browser.InternetExplorer, IW.Browser.Opera, IW.Browser.Safari, IW.Browser.Edge,
  IW.Browser.ChromeMobile, IW.Browser.FirefoxMobile, IW.Browser.SafariMobile,
  IWGlobal, IWAppForm,
  IWApplication, IWRegion, IWBaseLayoutComponent,
  IWContainerLayout, IWTemplateProcessorHTML,
  Classes, Forms, Controls, OracleData, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, IWCompLabel, IWCompEdit, IWCompListBox,
  meIWLink,  medpIWMessageDlg, IWCompGridCommon, meIWCheckBox,
  SysUtils, StrUtils, TypInfo, IWCompJQueryWidget, IWCompGrids, ActnList, Menus,
  meIWRadioGroup, RegistrazioneLog, IWBaseContainerLayout, IWVCLComponent,
  IWCompButton, meIWButton, IWCompExtCtrls, meIWImageFile, medpIWImageButton,
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  meIWGrid, meIWComboBox, meIWMemo, meIWEdit, DateUtils, IWTypes,
  meIWFileUploader, Rtti, IWAppCache;

const
  INFO_COOKIES =  'Utilizzo dei cookie' + #13#10 + #13#10 +
                  'Informativa sull''utilizzo dei cookie in IrisWEB, in ottemperanza alle prescrizioni contenute nel Provvedimento ' +
                  'del Garante Privacy dell''8 maggio 2014, emanato ai sensi dell''art. 122 del decreto legislativo 30 giugno 2003 ' +
                  'n° 196 a seguito delle modifiche intervenute con il Decreto Legislativo 69 del 28 maggio 2012 in attuazione ' +
                  'delle direttive europee 2009/136/CE e 2009/140/CE.' + #13#10 + #13#10 +
                  'I cookie sono piccoli file di testo che il server web deposita sul dispositivo con cui l''utente naviga, senza ' +
                  'identificarlo. Un cookie non può leggere dati personali salvati sul disco fisso o file di cookie creati da altri siti, ' +
                  'poiché le sole informazioni che può contenere sono quelle fornite dall''utente stesso. ' +
                  'Sul sito di IrisWEB non viene fatto uso di cookie per la trasmissione di informazioni di carattere personale, né ' +
                  'vengono utilizzati cosiddetti cookie per il tracciamento degli utenti.' + #13#10 + #13#10 +
                  'L''uso di cookie di sessione (che non vengono memorizzati in modo persistente sul computer dell''utente) è ' +
                  'strettamente limitato alla trasmissione di identificativi di sessione (costituiti da numeri casuali generati dal ' +
                  'server) necessari per consentire l''esplorazione sicura ed efficiente del sito. L''utilizzo di tali cookie di sessione ' +
                  'in questo sito viene fatto in modo da evitare il ricorso ad altre tecniche informatiche potenzialmente ' +
                  'pregiudizievoli per la riservatezza della navigazione degli utenti, non consentendo l''acquisizione di dati ' +
                  'personali identificativi dell''utente.' + #13#10 + #13#10 +
                  'La navigazione sul sito di IrisWEB comporta l’accettazione delle condizioni d''uso, comprese le funzionalità ' +
                  'legate ai cookie che possono essere disabilitati utilizzando le opzioni specifiche presenti nei vari tipi di ' +
                  'browser. Salvo quanto sopra indicato, il sito web di IrisWEB non fa uso di altri cookie per la trasmissione di ' +
                  'informazioni di carattere personale e non utilizza altri sistemi per il tracciamento degli utenti.';

type
  TLoginInfo = record
    Azienda: String;
    Utente: string;
    TipoUtente: String;
    Timeout: Integer;
    ProfiloWeb: String;
    ProfiloIter: String;
    ProfiloFiltroPermessi: String;
    ProfiloFiltroAnagrafe: String;
    ProfiloFiltroFunzioni: String;
    ProfiloFiltroDizionario: String;
    Layout: String;
  end;

  {$IFDEF INTRAWEBSVC}
  TmedpDirectory = (fdUser,    // [UserCacheDir]      (cartella utente)
                    fdGlobal,  // [FilesDir]            (cartella Files)
                    fdHelp);   // [FilesDir]\ PATH_HELP (sottodirectory di Files)
  {$ENDIF}

  // MONDOEDP - commessa MAN/07 SVILUPPO#0.ini
  // dati sui browser disponibili per il download
  TDatiBrowser = record
    Nome: String;  // nome del browser
    Hint: String;  // tooltip da visualizzare
    Link: String;  // URL per il download
  end;

  // informazioni sul supporto per il browser in uso
  TInfoSupportoBrowser = record
    TipoCompatibile: Boolean;     // indica se il tipo di browser (IE, Firefox, ...) è supportato (True) oppure no (False)
    VersioneCompatibile: Boolean; // indica se la versione del browser è supportata (True) oppure no (False)
    Info: String;                 // informazioni descrittive di compatibilità
  end;
  // MONDOEDP - commessa MAN/07 SVILUPPO#0.fine

  //ScrollBarManager - gestione delle scrollbar della pagina
  TScrollBarManager = record
    divName:String;
    Top:Integer;
    Left:Integer;
    HFTop:String;
    HFLeft:String;
  end;

  TI076Info = record
    Enabled: Boolean; // maschera abilitata in base all'IP
    Message: String;  // informazioni sullo stato di abilitazione
  end;

  // GiorgioC 2019-10-23:
  TprocSender = procedure(Sender: TObject) of object;

  // Gallizio 2017-07-21: supporto per chiamare AJAX
  TMetodoAJAX = procedure(JSONInput:TJSONValue; var JSONOutput:TJSONObject) of object;
  TEsitoChiamataAJAX = (ecaSuccess, ecaWarning, ecaError);
  TGestoreChiamataAJAX = class
    private
      procedure GestioneErroreChiamata(var RispostaJSON:TJSONObject; Eccezione:Exception);
    protected
      OwnerIWAppForm:TIWAppForm;
      IDMetodoJS:String;
      IDInputHTMLParametri:String;
      MetodoAJAX:TMetodoAJAX;
    public
      // Function e procedure di utilità
      class procedure ValorizzaRispostaAJAX(RispostaDaValor:TJSONObject; Esito:TEsitoChiamataAJAX;Dati:TJSONValue;Avvisi:TJSONArray;Errori:TJSONArray);
      class procedure ValorizzaRispostaAJAXSuccess(RispostaDaValor:TJSONObject;Dati:TJSONValue);
      class procedure ValorizzaRispostaAJAXWarning(RispostaDaValor:TJSONObject; Dati:TJSONValue; Avvisi:array of String);
      class procedure ValorizzaRispostaAJAXError(RispostaDaValor:TJSONObject; Errori:array of String);
      class function EscapeJS(const S:String):String;
      class function CreaJSONBoolean(const B:Boolean):TJSONValue;
      class function CreaJSONPair(const Chiave,Valore:String):TJSONPair;
      // Proprietà e metodi di istanza
      constructor Create(OwnerIWAppForm:TIWAppForm;IDMetodoJS:String; IDInputHTMLParametri:String; MetodoDelphiAJAX:TMetodoAJAX); overload;
      constructor Create(OwnerIWAppForm:TIWAppForm;IDMetodoJS:String; MetodoDelphiAJAX:TMetodoAJAX); overload;
      procedure Registra;
      procedure DeRegistra;
      procedure Esegui(EventParams:TStringList);
      procedure ChiamaCallbackJS(RispostaJSON:TJSONObject; NomeFunzioneCallbackJS:String);
      destructor Destroy; override;
  end;

  {$REGION 'Gestione periodo'}

  TGestPeriodoAsyncClick = procedure(Sender: TObject; EventParams: TStringList) of object;

  TGestPeriodoAsyncMouseMove = procedure (Sender: TObject; EventParams: TStringList) of object;

  TGestPeriodoClick = procedure(Sender: TObject) of object;

  TCompPeriodo = record
    EditInizio: TmeIWEdit;
    EditFine: TmeIWEdit;
    ImgPrec: TmeIWImageFile;
    ImgPrecAzioneCustomOnClick: TGestPeriodoClick;
    ImgSucc: TmeIWImageFile;
    ImgSuccAzioneCustomOnClick: TGestPeriodoClick;
    EdtPeriodoAzioneCustomOnChange: TGestPeriodoClick;
    EseguiSubmit:Boolean;
    function GetPeriodo: TPeriodo;
    procedure SetPeriodoHint(const PHint: String);
  end;

  TCompPeriodoArr = array of TCompPeriodo;

  {$ENDREGION 'Gestione periodo'}

  TPluginJavaScript = record
    ID, ErrVersioneBrowser: String;
  end;

  TWR010FBase = class(TIWAppForm)
    lnkIndietro: TmeIWLink;
    lnkHelp: TmeIWLink;
    lnkEsci: TmeIWLink;
    lnkChiudiSchede: TmeIWLink;
    TemplateProcessor: TIWTemplateProcessorHTML;
    btnSendFile: TmeIWButton;
    grdMemoAJAX: TmeIWGrid;
    edtAJAXFormID: TmeIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure lnkHelpClick(Sender: TObject);
    procedure lnkEsciClick(Sender: TObject);
    procedure lnkIWICClick(Sender: TObject);
    procedure lnkChiudiSchedeClick(Sender: TObject);
    procedure lnkIndietroClick(Sender: TObject); virtual;
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure TemplateProcessorUnknownTag(const AName: string; var VValue: string);
    procedure btnSendFileClick(Sender: TObject);
  private
    FOpenerTag: Integer;
    FCreateTime: TDateTime;
    FRenderTime: TDateTime;
    ParametriList: TStringList;
    lstFrameOpen: TStringList;
    lnkRefreshPage: TmeIWLink;
    lnkContextMenu: TmeIWLink;
    FProcSiMsg,
    FProcNoMsg: TProcObject;
    FJSCallbackName: String;
    FBrowserStr: String;
    FCodiceForm: String;
    FNomeForm: String;
    FNomeFunzione: String;
    TagPopupMenuHtml: String;
    FInfoSupportoBrowser: TInfoSupportoBrowser; // MONDOEDP - commessa MAN/07 SVILUPPO#0
    FAddToHistory: Boolean;
    FFissa: Boolean;
    FModale: Boolean;
    FCompError: Boolean;
    FPageClosing: Boolean;
    FDebugList: TStringList;
    OldIdxClose,
    FTagAbilitazioni: Integer; // tag valutato per l'abilitazione form
    FRegionArr: array of TIWRegion;
    GestoriChiamateAJAX: array of TGestoreChiamataAJAX;
    FCompPeriodoArr: TCompPeriodoArr;
    procedure imgIWInfoCookiesClick(Sender: TObject);
    procedure CreazioneImgIntestazione;
    procedure CreaJQuery;
    procedure DistruggiJQuery;
    function  IsModale: Boolean;
    procedure SetModale(const Val: Boolean);
    function  IsFissa: Boolean;
    procedure SetFissa(const Val: Boolean);
    procedure CtrlAddHistory;
    function  GetInfoSupportoBrowser: TInfoSupportoBrowser; // MONDOEDP - commessa MAN/07 SVILUPPO#0
    procedure lnkContextMenuClick(Sender: TObject);
    procedure OnContextMenu(const PMenuItem, PSenderName: String; const PMenuItemComp: TMenuItem = nil);
    procedure OnAsyncContextMenu(EventParams: TStringList);
    procedure lnkRefreshPageClick(Sender: TObject);
    procedure OnDebugInfo(EventParams: TStringList);
    procedure OnJsErrore(EventParams: TStringList);
    procedure OnPublicIPRicevuto(EventParams: TStringList);
    procedure OnInviaBugReport(EventParams: TStringList);
    procedure OnRispostaMessaggio(Sender: TObject; PRes: TmeIWModalResult; PKeyID: String);
    procedure AbilitaFunzioni;
    function  EsisteControlloI076(PComp: TComponent): Boolean;
    procedure ImpostaAbilitazioneI076(PComp: TComponent);
    procedure ImpostaAbilitazioniI076;
    procedure LeggiAbilitazioneForm;
    function  IsClassOK(PComp: TComponent): Boolean;
    function  GetContextMenu(PControl: TControl): TPopupMenu;
    procedure ElaboraComp(PComp: TComponent);
    procedure CicloComponenti;
    procedure GestioneScrollBar;
    function  FindFrame(const PName: String; const PCaseSensitive: Boolean = False): TFrame;
    procedure DistruggiFrame;
    function  GetWaterMarkEnabled:Boolean;
    procedure SetWaterMarkEnabled(Value:Boolean);
    function  GetIsCampoNascosto(Comp:String):Boolean;
    procedure OnConfermaFormNotEnabled(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    function  GetCompPeriodoByControl(PControl: TObject): TCompPeriodo; inline;
    procedure OnGestPeriodoSpostaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure OnGestPeriodoAsyncMouseMove(Sender: TObject; EventParams: TStringList);
    procedure OnGestPeriodoClick(Sender: TObject);
    procedure OnGestPeriodoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure GetDatiNotificaCustom(Procedura:String; var Titolo,Testo,Icona:String);
    function  HtmlNameIcona(pTag:Integer):String;
  protected
    imgIndietro, imgChiudiSchede, imgEsci, imgIWIC, imgHelp, imgSceltaRapida, imgInfoCookies: TmeIWImageFile;
    TagLoginTooltip,
    ErroreCreate: String;
    WMenuFM: TFrame;
    {$IFNDEF INTRAWEBSVC}
    FileBox: TWC012FVisualizzaFileFM;
    {$ENDIF}
    JavascriptBottom: TStringList;
    jqInit,
    jqAccordion,
    jqAlert,
    jqAutocomplete,
    jqCalendario,
    jqCalendarioPeriodo,
    jqContextMenu,
    jqDebug,
    jqFixedHeader,
    jqFrame,
    jqMask,
    jqMessaggio,
    jqGritter,
    jqPublicIP,
    jqTemp,
    jqTooltip,
    jqUtility,
    jqWatermark,
    jqReplaceCache: TIWJqueryWidget;
    LoginInfo: TLoginInfo;
    FrameArr: array of TFrame;
    FRegistraMsg: TRegistraMsg;
    PrimoRender: Boolean;
    PathRelJSSpecifico,PathRelCSSSpecifico: String;
    PluginsJavaScript: array of TPluginJavaScript;
    IconeAccessoRapidoArr: array of TmeIWImageFile;
    function  GetNomeForm: String; // nome form pulito di eventuali suffissi (caso di form duplicate nella history)
    function  GetFunzioneDisponibileByTag(const PTag: Integer): TFunzioniDisponibili;
    function  GetNomeFunzione: String; virtual;   // nome della funzione estratto da L021Call
    function  GetInfoFunzione: String; virtual;   // informazioni da visualizzare come tooltip sul tab
    function  GetProgressivo: Integer; virtual;   // progressivo del dipendente attualmente selezionato
    procedure ImpostaTemplate; virtual;
    procedure GestioneMenu; virtual;
    procedure NascondiMenu; virtual;
    procedure RefreshPage; virtual; // eseguita dopo aver cambiato tab nella history
    procedure AggiornaIconeAccessoRapido; virtual;
    procedure AggiornaIconaAccessoRapido; virtual;
    procedure DistruggiOggetti; virtual; // eseguita in fase di destroy della form
    function  GeneraFile(PDirectory: TmedpDirectory; const PExt, PTesto: String; var ErrStr: String): String; overload;
    function  GeneraFile(PDirectory: TmedpDirectory; const PExt: String; PContenuto: TStream; var ErrStr: String): String; overload;
    procedure TraduzioneElementi(Sender: TComponent);
    procedure TraduciSingoloElemento(Elem: TPersistent(*TComponent*); Proprieta,Traduzione,NomeField: String; RttiContext:TRttiContext);
    procedure VerificaCompatibilitaBrowser; // MONDOEDP - commessa MAN/07 SVILUPPO#0
    function  GetInfoDebug: String; virtual;
    procedure LogConsole(PTesto: String; const PDebugOnly: Boolean = True);
    procedure LogConsoleTime(const PTesto: String; PStartTime: TDateTime; const PDebugOnly: Boolean = True);
    procedure DebugAdd(const PTipo, PTesto: String; const PNomeComp: String = ''); overload;
    procedure DebugAdd(const PTesto: String); overload;
    procedure DebugShow;
    procedure DebugClear;
    procedure CampiNascosti;
    procedure AddScrollBarManager(DivName:String; PageName:String = '');
    property  IsCampoNascosto[Comp:String]:Boolean read GetIsCampoNascosto;
    procedure NotificheCustom;
  public
    RefreshPageAttivo: Boolean;
    DatiAbilitazioni: TAbilitazioniFunzioni; // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161
    AccessoAbilitato: Boolean;
    SolaLettura: Boolean;
    jqHistory: TIWJQueryWidget;
    TagJsHistory: String; // impostato dal datamodulo (history)
    DCOMNomeFile: String;
    FMsgBox: TmedpIWMessageDlg;
    lstScrollBar: array of TScrollBarManager; //Deve essere accessibile anche dai frames
    medpI076Info: TI076Info;
    // variabili usate per il salvataggio temporaneo del file da scaricare da menu contestuale
    streamDownload: TStream;
    csvDownload: String;
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; const PAddToHistory: Boolean); reintroduce; overload;
    //procedure AddScrollBar(DivName:String; PageName:String = '');
    procedure InviaFile(const PNomeFile: String; const PContenuto: String); overload;  //caratto 03/01/2013 spostata da protected a public per poterla usare anche nei frame
    procedure InviaFile(const PNomeFile: String; const PStream: TStream); overload;
    procedure VisualizzaFileWeb;
    function  InizializzaAccesso:Boolean; virtual;
    procedure OpenPage; virtual;
    procedure ClosePage;
    procedure SetTag(const PTag: Integer);
    procedure SetParam(const Chiave, Valore: String); overload; virtual;
    procedure SetParam(const Chiave: String; const Valore: Integer); overload;
    procedure SetParam(const Chiave: String; const Valore: TDateTime); overload;
    procedure SetParam(const Chiave: String; const Valore: Boolean); overload;
    function  GetParam(const Chiave: String): String;
    function  IsLoginForm: Boolean; virtual;  // indica se la form attuale è quella di login
    function  IsPageClosing: Boolean; // indica se la form attuale è in fase di chiusura
    procedure OnTabChanging(var AllowChange: Boolean; var Conferma: String); virtual; // eseguita prima di cambiare tab nella history
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); virtual;   // eseguita prima di chiudere tab nella history
    procedure OnConfermaTabAction(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure actLinkSelect(Sender:TObject);
    procedure actLinkClose(Sender:TObject);
    procedure Log(const PTipo: String; const PMessaggio:String = ''; const PException: Exception = nil);
    procedure Messaggio(const Titolo, Testo: String; PProcSi, PProcNo: TProcObject);
    procedure MessaggioStatus(const PTipo, PTesto, PTestoPopup: String; const PDurataPopup: Integer = 5000; const PDurataTesto: Integer = -1); overload; virtual;
    procedure Notifica(const PTitolo, PTesto: String; const PImageUrl: String; const PAccoda, PSticky: Boolean; const PDurata: Integer = 0);
    procedure RimuoviNotifiche;
    procedure MessaggioStatus(const PTipo, PTesto: String; const PDurataTesto: Integer = -1); overload;
    procedure MessaggioPopup(const PTesto: String);
    procedure VisualizzajQMessaggio(jqWidget:TIWJQueryWidget; PWidth,PHeight,PHeightIE6: Integer; const PTitle:String;
      const PObjName:String = '.frm'; PCloseButton:Boolean = True; PResizable:Boolean = True; PZIndex:Integer = -1;
      const Position:String = ''; const JSonOpen: String = ''; const PCloseControlHTMLName: String = ''); overload;
    procedure VisualizzajQMessaggio(jqWidget:TIWJQueryWidget; PWidth,PMinHeight,PHeight,PHeightIE6:Integer; const PTitle:String;
      const PObjName:String = '.frm'; PCloseButton:Boolean = True; PResizable:Boolean = True; PZIndex:Integer = -1;
      const Position:String = ''; const JSonOpen: String = ''; const PCloseControlHTMLName: String = ''); overload;
    function  GetNomeFile(PExt: String; const PDirectory: TmedpDirectory = fdUser): String;
    procedure VisualizzaFile(const PNomeFile, PTitolo: String; POnShow, POnClose: TProcObject; const PDirectory: TmedpDirectory = fdUser);
    function  RenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer; const Intestazione,RigheAlterne:Boolean; const EvidenziaRigaSel:Boolean = True): Boolean;
    function  GetRighePaginaTabella: Integer;
    procedure AssegnaGestPeriodo(PEditInizio, PEditFine: TmeIWEdit); overload;
    procedure AssegnaGestPeriodo(PEditInizio, PEditFine: TmeIWEdit; PImgPrec, PImgSucc: TmeIWImageFile); overload;
    procedure AssegnaGestPeriodo(PEditInizio, PEditFine: TmeIWEdit; PImgPrec, PImgSucc: TmeIWImageFile; PImgPrecAzioneCustomOnClick, PImgSuccAzioneCustomOnClick: TGestPeriodoClick; PEdtPeriodoAzioneCustomOnChange: TGestPeriodoClick = nil); overload;
    procedure SetCompPeriodo_EseguiSubmit(PControl: TObject; const PValue: Boolean);
    property  medpAddToHistory: Boolean read FAddToHistory;
    property  medpCodiceForm: String read FCodiceForm;
    property  medpFissa: Boolean read IsFissa write SetFissa;
    property  medpJSCallbackName: String read FJSCallbackName;
    property  medpNomeForm: String read FNomeForm;
    property  medpNomeFunzione: String read FNomeFunzione;
    property  medpInfoFunzione: String read GetInfoFunzione;
    property  medpModale: Boolean read IsModale write SetModale;
    property  medpProgressivo: Integer read GetProgressivo;
    property  WR010RegistraMsg: TRegistraMsg read FRegistraMsg;
    property  OpenerTag:Integer read FOpenerTag write FOpenerTag;
    property  WatermarkEnabled:Boolean read GetWaterMarkEnabled write SetWaterMarkEnabled;
    function  ScrollBarIndexOf(DivName:String):Integer;
    // SUPPORTO AJAX PER INTRAWEB
    function  GetAJAXFormID:String;
    procedure RegistraMetodoAJAX(IDMetodoJS:String; MetodoDelphi:TMetodoAJAX);
    // IMPORT JAVASCRIPT FACOLTATIVO
    procedure AggiungiPluginJavaScript(const IDPlugin:String; CustomErrMsgVerBrowser:String = '');
    procedure CreaNavigatorBar(actlstNavBar: TActionList; grdNavBar: TmeIWGrid; cmbIncollaOpzioni: TmeIWComboBox; _onClick: TprocSender);
    procedure AggiornaToolBar(ToolBarGrid:TIWGrid;ActionList:TActionList);
    procedure AbilitaToolBar(ToolBarGrid:TIWGrid;Abilitazione:Boolean;ActionList:TActionList);
  end;

implementation

uses WR000UBaseDM,
     {$IFNDEF INTRAWEBSVC}
     {$IFDEF WEBPJ}
       {$IFDEF RILPRE}WC502UMenuRilPreFM,{$ENDIF}
       {$IFDEF PAGHE} WC503UMenuPagheFM, {$ENDIF}
       {$IFDEF STAGIU}WC504UMenuStagiuFM,{$ENDIF}
     {$ELSE}
       {$IFNDEF X001} WC501UMenuIrisWebFM,{$ENDIF}
       {$ENDIF}
     {$ENDIF}
     WR200UBaseFM,
     IWDBGrids,
     medpIWDBGrid, meIWDBGrid,
     meTIWAdvCheckGroup;

{$R *.dfm}

// TGestoreChiamataAJAX

procedure TGestoreChiamataAJAX.GestioneErroreChiamata(var RispostaJSON:TJSONObject; Eccezione:Exception);
var
  LCodFormAttiva,LErrMsg:String;
  {$IFDEF madExcept}
  LBugReport: UnicodeString;
  {$ENDIF madExcept}
begin
  LErrMsg:=Trim(A000TraduzioneEccezioni(Eccezione.Message));
  // La risposta potrebbe essere già stata in parte valorizzata prima dell'eccezione. Tento di distruggerla e la ricreo vuota.
  try FreeAndNil(RispostaJSON); except end;
  RispostaJSON:=TJSONObject.Create;
  ValorizzaRispostaAJAXError(RispostaJSON, LErrMsg);

  // Informazioni aggiuntive in caso di debug con MadExcept
  {$IFDEF madExcept}
  HandleException(etNormal, Eccezione, nil, True, Esp, Ebp, nil, {esISAPI} esIntraweb, OwnerIWAppForm.WebApplication, 0, @LBugReport);
  RispostaJSON.AddPair('infoDebug',TGestoreChiamataAJAX.EscapeJS(LBugReport));
  {$ENDIF madExcept}

  LCodFormAttiva:=R180DimLung((OwnerIWAppForm as TWR010FBase).medpCodiceForm,5);
  // messaggio di log
  W000RegistraLog('Errore',Format('%s[%s]%s(%s)',[GetTestoLog('A000',OwnerIWAppForm.WebApplication),LCodFormAttiva,LErrMsg,Eccezione.ClassName]));
end;

class procedure TGestoreChiamataAJAX.ValorizzaRispostaAJAX(RispostaDaValor:TJSONObject; Esito:TEsitoChiamataAJAX;Dati:TJSONValue;Avvisi:TJSONArray;Errori:TJSONArray);
begin
  if Esito = ecaSuccess then
    RispostaDaValor.AddPair('esito','success')
  else if Esito = ecaWarning then
    RispostaDaValor.AddPair('esito','warning')
  else
    RispostaDaValor.AddPair('esito','fail');
  if dati <> nil then
    RispostaDaValor.AddPair('dati',Dati);
  if avvisi <> nil then
    RispostaDaValor.AddPair('avvisi',Avvisi);
  if errori <> nil then
    RispostaDaValor.AddPair('errori',Errori);
end;

class procedure TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(RispostaDaValor:TJSONObject;Dati:TJSONValue);
begin
  TGestoreChiamataAJAX.ValorizzaRispostaAJAX(RispostaDaValor,ecaSuccess,Dati,nil,nil);
end;

class procedure TGestoreChiamataAJAX.ValorizzaRispostaAJAXWarning(RispostaDaValor:TJSONObject;Dati:TJSONValue; Avvisi:array of String);
var
  AvvisiJSON:TJSONArray;
  i:Integer;
begin
  AvvisiJSON:=TJSONArray.Create;
  for i:=Low(Avvisi) to High(Avvisi) do
    AvvisiJSON.Add(TGestoreChiamataAJAX.EscapeJS(C190ConvertiSimboliHtml(Avvisi[i])));
  TGestoreChiamataAJAX.ValorizzaRispostaAJAX(RispostaDaValor,ecaWarning,Dati,AvvisiJSON,nil);
end;

class procedure TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(RispostaDaValor:TJSONObject; Errori:array of String);
var
  ErroriJSON:TJSONArray;
  i:Integer;
begin
  ErroriJSON:=TJSONArray.Create;
  for i:=Low(Errori) to High(Errori) do
    ErroriJSON.Add(TGestoreChiamataAJAX.EscapeJS(C190ConvertiSimboliHtml(Errori[i])));
  TGestoreChiamataAJAX.ValorizzaRispostaAJAX(RispostaDaValor,ecaError,nil,nil,ErroriJSON);
end;

class function TGestoreChiamataAJAX.EscapeJS(const S: String): String;
// trasforma una stringa effetuando l'escape dei caratteri non effettuati da TJSONString.ToString.
begin
  Result:=S;
  // Backslash
  Result:=StringReplace(Result,'\','\\',[rfReplaceAll]);
  // caratteri CR e LF
  Result:=StringReplace(Result,LF,'\n',[rfReplaceAll]);
  Result:=StringReplace(Result,CR,'\r',[rfReplaceAll]);
end;

class function TGestoreChiamataAJAX.CreaJSONBoolean(const B:Boolean):TJSONValue;
begin
  if B then
    Result:=TJSONTrue.Create
  else
    Result:=TJSONFalse.Create;
end;

{ Questo metodo ritorna un oggetto di tipo TJSONPair (coppia chiave<->valore stringa) con la chiave e la stringa
  specificati. Della stringa viene inoltre effettuato l'escape di caratteri riservati usati in JS .
  Utile in fase di creazione di un TJSONObject dato che TJSONObject.AddPair(const Str: string; const Val: string)
  NON aggiunge la chiave nel caso in cui il Val sia una stringa vuota.
}
class function TGestoreChiamataAJAX.CreaJSONPair(const Chiave,Valore:String):TJSONPair;
begin
  Result:=TJSONPair.Create(Chiave,TGestoreChiamataAJAX.EscapeJS(Valore));
end;

constructor TGestoreChiamataAJAX.Create(OwnerIWAppForm:TIWAppForm; IDMetodoJS:String; IDInputHTMLParametri:String; MetodoDelphiAJAX:TMetodoAJAX);
begin
  if (OwnerIWAppForm = nil) or (Trim(IDMetodoJS) = '') or (@MetodoDelphiAJAX = nil) or (Trim(IDInputHTMLParametri) = '') then
    raise Exception.Create('Parametri del costruttore di TGestoreChiamataAJAX non validi.');
  Self.OwnerIWAppForm:=OwnerIWAppForm;
  Self.IDMetodoJS:=IDMetodoJS;
  Self.IDInputHTMLParametri:=Uppercase(IDInputHTMLParametri);
  Self.MetodoAJAX:=MetodoDelphiAJAX;
end;

constructor TGestoreChiamataAJAX.Create(OwnerIWAppForm:TIWAppForm;IDMetodoJS:String; MetodoDelphiAJAX:TMetodoAJAX);
begin
  Create(OwnerIWAppForm, IDMetodoJS, Uppercase(IDMetodoJS),MetodoDelphiAJAX);
end;

procedure TGestoreChiamataAJAX.Registra;
begin
  // Associo l'id del metodo lato JS con il relativo metodo Delphi del gestore chiamate
  OwnerIWAppForm.WebApplication.RegisterCallBack(IDMetodoJS, Self.Esegui);
end;

procedure TGestoreChiamataAJAX.DeRegistra;
begin
  // Non è possibile cancellare un callback su IW, per ovviare impostiamo un callback ad una funzione nop
  OwnerIWAppForm.WebApplication.RegisterCallBack(IDMetodoJS, WR000DM.AJAXIWCallbackNOP);
end;

procedure TGestoreChiamataAJAX.Esegui(EventParams:TStringList);
var
  ParametriSpec,FnCallbackJS:String;
  ParametriJSON:TJSONValue;
  RispostaJSON:TJSONObject;
  NestEcc:Exception;
begin
  ParametriJSON:=nil;
  RispostaJSON:=TJSONObject.Create;
  try
    try
      // Imposto il nome della funzione JS di callback (se è vuota o non passata resta a '' e non viene eseguita)
      FnCallbackJS:=EventParams.Values['medpCallbackJS'];
      // Estraggo i parametri della mia chiamata
      ParametriSpec:=EventParams.Values[Self.IDInputHTMLParametri];
      if Trim(ParametriSpec)='' then
      begin
        // Non sono presenti i parametri della chiamata
        ValorizzaRispostaAJAXError(RispostaJSON,['La chiamata non contiene alcun parametro per questa funzione!']);
        Self.ChiamaCallbackJS(RispostaJSON, FnCallbackJS);
        Exit;
      end;
      // Parsifico il JSON con i parametri
      ParametriJSON:= TJSONObject.ParseJSONValue(ParametriSpec);
      if ParametriJSON = nil then
      begin
        // Parsificazione JSON fallita
        ValorizzaRispostaAJAXError(RispostaJSON,['Il JSON indicato come parametro non è valido.']);
        Self.ChiamaCallbackJS(RispostaJSON, FnCallbackJS);
        Exit;
      end;
      try
        // Eseguo il metodo dell'utente
        Self.MetodoAJAX(ParametriJSON, RispostaJSON);
      except
        on E:Exception do
        begin
          Self.GestioneErroreChiamata(RispostaJSON,E);
        end;
      end;
      // Chiamo la callback
      Self.ChiamaCallbackJS(RispostaJSON, FnCallbackJS);
    except
      on E:Exception do
      begin
        NestEcc:=Exception.Create('Errore durante l''esecuzione della funzione remota: ' + E.Message);
        Self.GestioneErroreChiamata(RispostaJSON, NestEcc);
        Self.ChiamaCallbackJS(RispostaJSON, FnCallbackJS);
        FreeAndNil(NestEcc);
      end;
    end;
  finally
    if (ParametriJSON <> nil) then
      try FreeAndNil(ParametriJSON); except end;
    try FreeAndNil(RispostaJSON); except end;
  end;

end;

procedure TGestoreChiamataAJAX.ChiamaCallbackJS(RispostaJSON:TJSONObject; NomeFunzioneCallbackJS:String);
var
  CodiceJS,NomeVarPCallbackJS,RispostaJSONTesto:String;
  JSONTest:TJSONValue;
  NestEcc:Exception;
begin
  try
    { Prima di generare il codice della callback mi assicuro di essere in grado di convertire il TJSONObject in JSON
      e che il JSON sia parsificabile. Se così non fosse vuol dire che la risposta è stata mal costruita nel payload. }
    RispostaJSONTesto:=RispostaJSON.ToString;
    JSONTest:=TJSONObject.ParseJSONValue(RispostaJSONTesto);
    if (JSONTest = nil) then
    begin
      // Il JSON di risposta non è valido. Molto probabilmente RispostaJSON è invalida (es. punta ad oggetti deallocati).
      raise Exception.Create('JSON malformato.');
    end;
    FreeAndNil(JSONTest);
  except
    on E:Exception do
    begin
      // In caso di errore (es. RispostaJSON mal costruita)
      NestEcc:=Exception.Create('Errore in finalizzazione durante l''esecuzione della funzione remota: ' + E.Message);
      Self.GestioneErroreChiamata(RispostaJSON, NestEcc);
      RispostaJSONTesto:=RispostaJSON.ToString;
      FreeAndNil(NestEcc);
    end;
  end;

  CodiceJS:='/* PLACEHOLDER SESSIONE VALIDA */' + #13#10;
  // Compongo il codice JS per eseguire la callback (in caso di anomalie il JSON di risposta conterrà la descrizione dell'errore).
  // Il nome della variabile JS che punta alla funzione di callback utente è casuale per evitare sovrapposizioni (cosa molto improbabile comunque).
  NomeVarPCallbackJS:='fnCallbackUtente' + (IntToStr(Random(98999) + 1000)) + IntToStr(MilliSecondOf(Time));
  CodiceJS:=CodiceJS + 'var ' + NomeVarPCallbackJS + '=null;' + #13#10; // Caso base: lo sviluppatore non ha definito una funzione di callback lato JS
  if Trim(NomeFunzioneCallbackJS) <> '' then
  begin
    // In questo caso lo sviluppatore ha definito una funzione JS di callback. La faremo eseguire nella callback di default.
    CodiceJS:=CodiceJS + NomeVarPCallbackJS + '=function(rispostaRemota){ ' + #13#10 +
                         '                       ' + NomeFunzioneCallbackJS + '(rispostaRemota);' + #13#10 +
                         '                     };' + #13#10;
  end;
  // Eseguo la callback di default
  CodiceJS:=CodiceJS + 'eseguiCallbackChiamataAJAX(' + RispostaJSONTesto + ',' + NomeFunzioneCallbackJS + ');' + #13#10;
  // Una volta terminata eseguiCallbackChiamataAJAX()  faccio puntare la variabile del callback JS a null.
  CodiceJS:=CodiceJS + nomeVarPCallbackJS + '=null;';
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(CodiceJS);
end;

destructor TGestoreChiamataAJAX.Destroy;
begin
  if Trim(Self.IDMetodoJS) <> '' then
    Self.DeRegistra;
end;

// TWR010FBase


constructor TWR010FBase.Create(AOwner: TComponent);
begin
  if not (AOwner is TIWApplication) then
    raise Exception.Create(Format('Errore interno: %s.Owner non è TIWApplication',[Name]));

  FAddToHistory:=True;
  try
    inherited Create(AOwner); // richiama IWAppFormCreate
    SetLength(Self.PluginsJavaScript,0);
  except
    on E: Exception do
    begin
      ErroreCreate:=Format('Si è verificato un errore in fase di apertura della funzione "%s"%sErrore:%s%s',
                           [Title,CRLF,CRLF,E.Message]);
    end;
  end;
end;

constructor TWR010FBase.Create(AOwner: TComponent; const PAddToHistory: Boolean);
// costruttore in overload per gestire l'aggiunta alla history
begin
  if not (AOwner is TIWApplication) then
    raise Exception.Create(Format('Errore interno: %s.Owner non è TIWApplication',[Name]));

  FAddToHistory:=PAddToHistory;
  try
    inherited Create(AOwner); // richiama IWAppFormCreate
    SetLength(Self.PluginsJavaScript,0);
  except
    on E: Exception do
    begin
      ErroreCreate:=Format('Si è verificato un errore in fase di apertura della funzione "%s"%sErrore:%s%s',
                           [Title,CRLF,CRLF,E.Message]);
    end;
  end;
end;

//############################################//
//###            EVENTI FORM               ###//
//############################################//

procedure TWR010FBase.IWAppFormCreate(Sender: TObject);
var
  GestAbil,CaricaPluginJS,PluginJSConfigFound: Boolean;
  msAttuali:Word;
  PluginJS: TPluginJavaScript;
  PluginJSConfig: TPluginJavaScriptConfig;
  CaricaPluginsJSErr,sClassName:String;
const
  FUNZIONE = 'WR010.IWAppFormCreate';
begin
  // cronometro
  FCreateTime:=Now;
  FOpenerTag:=-1;
  // inizializza proprietà form
  FBrowserStr:=GetBrowserStr;
  FCodiceForm:=Copy(Name,1,5);
  if not R180IsDigit(FCodiceForm,5) then
    FCodiceForm:=Copy(FCodiceForm,1,4);
  FInfoSupportoBrowser:=GetInfoSupportoBrowser; // MONDOEDP - commessa MAN/07 SVILUPPO#0
  FCompError:=False;
  {$WARN SYMBOL_PLATFORM OFF}
  if DebugHook <> 0 then
    FDebugList:=TStringList.Create;
  {$WARN SYMBOL_PLATFORM ON}
  FTagAbilitazioni:=Tag;
  FModale:=False;
  FNomeForm:=GetNomeForm;
  FNomeFunzione:=GetNomeFunzione;
  // gestione controlli basati su IP.ini
  medpI076Info.Enabled:=True;
  medpI076Info.Message:='';
  // gestione controlli basati su IP.fine
  FPageClosing:=False;
  RefreshPageAttivo:=False;
  SetLength(FCompPeriodoArr,0);

  // per i browser < IE8 introduce un metatag per la compatibilità
  if (GetBrowser is TInternetExplorer) and
     (GetBrowser.MajorVersion < 9) then
  begin
    PreHeader.Add(META_HTML_IE8);
  end;

  { DONE : TEST IW 14 OK }
  { Aggiungo un metatag per chiedere al browser di disattivare il format automatico
    dei numeri di telefono, per ora questa funzione di default viene automaticamente attivata
    solo su Microsoft Edge. Gli altri browser ignorano questo tag.
    (https://msdn.microsoft.com/en-us/library/dn265018(v=vs.85).aspx) }
  PreHeader.Add(META_HTML_NO_FORMAT_TELEPHONE);
  
  // Aggiungo l'icona sulla pagina del browser
  if FileExists(IncludeTrailingPathDelimiter(gSC.ContentPath) + WEB_BROWSER_ICON) then
    PreHeader.Add(Format('<link rel="icon" type="image/x-icon" href="%s"/>', [WEB_BROWSER_ICON]));

  // titolo form: se non impostato utilizza medpNomeFunzione
  if Title.Trim = '' then
  begin
    Title:=Format('(%s) %s',[FCodiceForm,FNomeFunzione]);
  end;

  if not IsLoginForm then // la form di login usa RegistraMsg (su A000UIUnterfaccia che restituisce il logger generico)
  begin
    FRegistraMsg:=TRegistraMsg.Create(SessioneOracle);
  end;

  //Creazione imgfile per i pulanti sull'intestazione
  CreazioneImgIntestazione;

  //HiddenFields utilizzati per mantenere lo scroll della pagina
  HiddenFields.Add('WR010SCROLLTOP=0');
  HiddenFields.Add('WR010SCROLLLEFT=0');
  JavaScript.Add('window.onscroll = onscrollWR010;');

  //Inizializzazione elenco dei div di cui gestire gli scrollbar
  SetLength(lstScrollBar,0);

  // salva log di accesso
  Log('Accesso');

  JavascriptBottom:=TStringList.Create;

  // stringlist dei parametri
  ParametriList:=TStringList.Create;

  // comandi jQuery di .dialog(open)
  lstFrameOpen:=TStringList.Create;

  // ATTENZIONE!
  // il codice di jqInit dovrebbe essere caricato prima di tutto.
  // gli oggetti msgbox e filebox utilizzano codice jquery,
  // pertanto sarebbe opportuno modificare l'ordine di creazione;
  // non è però possibile chiamare prima il metodo CreaJQuery, perché ci sono
  // problemi con l'ordine di visualizzazione dei frame

  // crea oggetto per messagebox
  FMsgBox:=TmedpIWMessageDlg.Create(Self);

  // crea oggetto frame per visualizzazione file
  {$IFNDEF INTRAWEBSVC}FileBox:=TWC012FVisualizzaFileFM.Create(Self);{$ENDIF}

  // la registercallback deve utilizzare un prefisso per discriminare la form
  // altrimenti verrebbero definite funzioni uguali per form diverse
  FJSCallbackName:=UpperCase(Name);

  // (richiamato in Templates/T000Intestazione.html)
  GGetWebApplicationThreadVar.RegisterCallBack(FJSCallbackName + '.OnDebugInfoJs',OnDebugInfo);

  // (richiamato in wwwroot/js/FunzioniGenerali.js)
  GGetWebApplicationThreadVar.RegisterCallBack(FJSCallbackName + '.OnJsErroreJs',OnJsErrore);

  // (richiamato in wwwroot/js/jquery-iw/jqContextMenu.js)
  GGetWebApplicationThreadVar.RegisterCallBack(FJSCallbackName + '.OnContextMenuJs',OnAsyncContextMenu);

  // (richiamato in wwwroot/js/jquery-iw/jqPublicIP.js)
  if FAddToHistory then
    GGetWebApplicationThreadVar.RegisterCallBack(FJSCallbackName + '.OnPublicIPRicevutoJs',OnPublicIPRicevuto);

  // (richiamato in TA000FInterfaccia.IWServerControllerBaseException)
  GGetWebApplicationThreadVar.RegisterCallBack(FJSCallbackName + '.OnInviaBugReport',OnInviaBugReport);

  // crea link per gestire menu contestuale con submit completo
  lnkContextMenu:=TmeIWLink.Create(Self);
  lnkContextMenu.Name:='lnkContextMenu';
  lnkContextMenu.Text:='azione';
  lnkContextMenu.Css:='invisibile';
  lnkContextMenu.Parent:=Self;
  lnkContextMenu.OnClick:=lnkContextMenuClick;

  // crea link per gestire refresh pagina (richiamo generico da eventi async)
  lnkRefreshPage:=TmeIWLink.Create(Self);
  lnkRefreshPage.Name:='lnkRefreshPage';
  lnkRefreshPage.Text:='refresh pagina';
  lnkRefreshPage.Css:='invisibile';
  lnkRefreshPage.Parent:=Self;
  lnkRefreshPage.OnClick:=lnkRefreshPageClick;

  // lettura abilitazione form in base al tag
  LeggiAbilitazioneForm;

  // crea oggetto per gestione jquery
  CreaJQuery;

  // forza variabili di ambiente
  Log('Traccia','A000SettaVariabiliAmbiente.Inizio');
  A000SettaVariabiliAmbiente;
  Log('Traccia','A000SettaVariabiliAmbiente.Fine');

  // aggiunge form alla history
  CtrlAddHistory;

  // gestione del menu
  GestioneMenu;

  // gestione delle abilitazioni dei componenti
  GestAbil:=Pos(INI_PAR_NO_ABILITAZIONI,W000ParConfig.ParametriAvanzati) = 0;
  Log('Traccia',Format('%s %s',[INI_PAR_NO_ABILITAZIONI,IfThen(GestAbil,'disattivo: abilitazioni verificate','attivo: abilitazioni non verificate')]));
  if GestAbil and Assigned(WMenuFM) and WMenuFM.Visible then // abilita funzioni solo se menu visibile
    AbilitaFunzioni;

  // se il controllo ip è attivo verifica le abilitazioni
  if Parametri.CampiRiferimento.C90_W038CheckIP = 'S' then
    ImpostaAbilitazioniI076;

  // informazioni di login
  if not IsLoginForm then
  begin
    LoginInfo.Azienda:=Parametri.Azienda;
    LoginInfo.Utente:=Parametri.Operatore;
    LoginInfo.TipoUtente:=IfThen(Parametri.ProfiloWEB = '','Operatore IrisWin','Utente web');
    LoginInfo.TimeOut:=GGetWebApplicationThreadVar.SessionTimeOut;
    LoginInfo.ProfiloWeb:=Parametri.ProfiloWeb;
    LoginInfo.ProfiloFiltroPermessi:=Parametri.ProfiloFiltroPermessi;
    LoginInfo.ProfiloFiltroAnagrafe:=Parametri.ProfiloFiltroAnagrafe;
    LoginInfo.ProfiloFiltroFunzioni:=Parametri.ProfiloFiltroFunzioni;
    LoginInfo.ProfiloFiltroDizionario:=Parametri.ProfiloFiltroDizionario;
    LoginInfo.ProfiloIter:='';
    LoginInfo.Layout:=Parametri.Layout;
  end;

  // preload immagini fisse (v. FunzioniGenerali.js)
  AddToInitProc('try { preloadImgFisse(); } catch(err) {} ');

  // (Gallizio 2017-10-04) Import di JS in base al form e controllo versione browser
  { DONE : TEST IW 14 OK }
  CaricaPluginsJSErr:='';
  if Length(Self.PluginsJavaScript) > 0 then
  begin
    for PluginJS in Self.PluginsJavaScript do
    begin
      PluginJSConfigFound:=false;
      // Cerco i dettagli per il plugin indicato
      for PluginJSConfig in PLUGINS_JAVASCRIPT do
      begin
        if PluginJSConfig.ID = PluginJS.ID then
        begin
          PluginJSConfigFound:=true;
          break;
        end;
      end;
      if (PluginJSConfigFound) then
      begin
        // Abbiamo trovato la configurazione per questo plugin. Vediamo se il file JS esiste.
        if FileExists(IncludeTrailingPathDelimiter(gSC.ContentPath) + PATH_BASE_JS_LOCAL +
                      StringReplace(PluginJSConfig.PathFileJS,'/','\',[rfReplaceAll])) then
        begin
          CaricaPluginJS:=true;
          // Controllo versione browser minima.
          if ((PluginJSConfig.VerMinIE >= 0) and (GetBrowser is TInternetExplorer) and (GetBrowser.MajorVersion < PluginJSConfig.VerMinIE)) or
             ((PluginJSConfig.VerMinChrome >= 0) and (GetBrowser is TChrome) and (GetBrowser.MajorVersion < PluginJSConfig.VerMinChrome)) or
             ((PluginJSConfig.VerMinFirefox >= 0) and (GetBrowser is TFirefox) and (GetBrowser.MajorVersion < PluginJSConfig.VerMinFirefox)) or
             ((PluginJSConfig.VerMinEdge >= 0) and (GetBrowser is TMSEdge) and (GetBrowser.MajorVersion < PluginJSConfig.VerMinEdge)) then
            CaricaPluginJS:=false;
          if (CaricaPluginJS) then
            Self.ContentFiles.Add(PATH_BASE_JS + PluginJSConfig.PathFileJS)
          else if PluginJS.ErrVersioneBrowser <> '' then // messaggio personalizzato
            CaricaPluginsJSErr:=CaricaPluginsJSErr + '<b>' + PluginJSConfig.Descrizione + ':</b>' + PluginJS.ErrVersioneBrowser + '<br>'
          else if PluginJSConfig.ErrVersioneBrowser <> '' then
            CaricaPluginsJSErr:=CaricaPluginsJSErr + '<b>' + PluginJSConfig.Descrizione + ':</b>' + PluginJSConfig.ErrVersioneBrowser + '<br>'
          else
            CaricaPluginsJSErr:=CaricaPluginsJSErr + '<b>' + PluginJSConfig.Descrizione + ':</b>' + A000MSG_ERR_PLUGIN_JS_BROWSER_NO_SUPP + '<br>';
        end
        else
          CaricaPluginsJSErr:=CaricaPluginsJSErr + '<b>' + PluginJSConfig.Descrizione + ':</b>' + A000MSG_ERR_PLUGIN_JS_NO_TROV + '<br>';
      end;
    end;
    if CaricaPluginsJSErr <> '' then
      AddToInitProc(Format('mostraDialogErrore("%s");',[CaricaPluginsJSErr]));      
  end;

  // (Gallizio 2017-07-11) Import del file JS specifico per form
  sClassName:=StringReplace(Self.ClassName,'TW030FTabelloneTurni','TWA058FPianifTurni',[]);//WA058FPianifTurni.css e WA058FPianifTurni.js vengono usati anche per W030

  PathRelJSSpecifico:=IncludeTrailingPathDelimiter(gSC.ContentPath) + PATH_BASE_JS_SPEC_LOCAL + Copy(sClassName,2) + '.js';
  if FileExists(PathRelJSSpecifico) then
  begin
    // il '.js' finale è necessario ad Intraweb per determinare se si sta importando uno script o un css
    PathRelJSSpecifico:=PATH_BASE_JS_SPEC + Copy(sClassName,2) + '.js?v=' + Parametri.VersionePJ + '.js';
    Self.ContentFiles.Add(PathRelJSSpecifico)
  end
  else
  begin
    PathRelJSSpecifico:='';
  end;

  // (Gallizio 2017-11-02) Import del foglio di stile specifico per form
  PathRelCSSSpecifico:=IncludeTrailingPathDelimiter(gSC.ContentPath) + PATH_BASE_CSS_SPEC_LOCAL + Copy(sClassName,2) + '.css';
  if FileExists(PathRelCSSSpecifico) then
  begin
    // il '.css' finale è necessario ad Intraweb per determinare se si sta importando uno script o un css
    PathRelCSSSpecifico:=PATH_BASE_CSS_SPEC + Copy(sClassName,2) + '.css?v=' + Parametri.VersionePJ + '.css';
    Self.ContentFiles.Add(PathRelCSSSpecifico)
  end
  else
  begin
    PathRelCSSSpecifico:='';
  end;

  // (Gallizio 2017-07-31) Identificativo per univoco per campi e callback IW
  // Randomize() è già richiamato all'avvio del server
  msAttuali:=MilliSecondOf(Time);
  edtAJAXFormID.Text:=Copy(Self.ClassName,2) + (IntToStr(Random(98999) + 1000)) + IntToStr(msAttuali);

  {$WARN SYMBOL_PLATFORM OFF}
  if DebugHook <> 0 then
  begin
    LogConsoleTime(FUNZIONE,FCreateTime);
  end;
  {$WARN SYMBOL_PLATFORM ON}

  // gestione errori nel formcreate della unit ereditata
  ErroreCreate:='';

  // valorizza variabile utilizzata per determinare la prima esecuzione di IWAppFormRender
  PrimoRender:=True;
end;

procedure TWR010FBase.CreazioneImgIntestazione;
var NomeWebApp:String;
const CssImg = 'immagine_link';
begin
  // indietro
  imgIndietro:=TmeIWImageFile.Create(Self);
  with imgIndietro do
  begin
    Parent:=Self;
    Name:='imgIndietro';
    ImageFile.FileName:=filebtnIndietro;
    Hint:=A000TraduzioneStringhe('Indietro');
    AltText:=Hint;
    OnClick:=lnkIndietroClick;
    css:=CssImg;
  end;
  imgChiudiSchede:=TmeIWImageFile.Create(Self);
  with imgChiudiSchede do
  begin
    Parent:=Self;
    Name:='imgChiudiSchede';
    ImageFile.FileName:=filebtnChiudiSchede;
    Hint:=A000TraduzioneStringhe('Chiudi schede');
    AltText:=Hint;
    OnClick:=lnkChiudiSchedeClick;
    css:=CssImg;
  end;
  imgEsci:=TmeIWImageFile.Create(Self);
  with imgEsci do
  begin
    Parent:=Self;
    Name:='imgEsci';
    ImageFile.FileName:=filebtnEsci;
    Hint:=A000TraduzioneStringhe('Esci');
    AltText:=Hint;
    OnClick:=lnkEsciClick;
    css:=CssImg;
  end;
  imgIWIC:=TmeIWImageFile.Create(Self);
  with imgIWIC do
  begin
    Parent:=Self;
    Name:='imgIWIC';
    if Trim(W000ParConfig.UrlWebApp) <> '' then
    begin
      NomeWebApp:=Copy(Trim(W000ParConfig.UrlWebApp),1,Pos('=',Trim(W000ParConfig.UrlWebApp)) - 1);
      ImageFile.FileName:='img\btnWebApp' + NomeWebApp + '.png';
      Hint:=A000TraduzioneStringhe('Accedi a ' + NomeWebApp);
    end
    else
    begin
      ImageFile.FileName:={$IFDEF WEBPJ}filebtnIW{$ELSE}filebtnIC{$ENDIF};
      Hint:=A000TraduzioneStringhe(IfThen(W000ParConfig.IrisWebCloudNewTab = 'N','Esci e a','A') + 'ccedi a ' + {$IFDEF WEBPJ}'IrisWeb'{$ELSE}'IrisCloud'{$ENDIF});
    end;
    AltText:=Hint;
    OnClick:=lnkIWICClick;
    css:=CssImg;
  end;
  imgInfoCookies:=TmeIWImageFile.Create(Self);
  with imgInfoCookies do
  begin
    Parent:=Self;
    Name:='imgInfoCookies';
    ImageFile.FileName:=filebtnInfoCookies;
    Hint:=A000TraduzioneStringhe('Informativa cookies');
    AltText:=Hint;
    OnClick:=imgIWInfoCookiesClick;
    css:=CssImg;
  end;
  imgHelp:=TmeIWImageFile.Create(Self);
  with imgHelp do
  begin
    Parent:=Self;
    Name:='imgHelp';
    ImageFile.FileName:=filebtnHelp;
    Hint:=A000TraduzioneStringhe('Help');
    AltText:=Hint;
    OnClick:=lnkHelpClick;
    css:=CssImg;
  end;
  imgSceltaRapida:=TmeIWImageFile.Create(Self);
  with imgSceltaRapida do
  begin
    Parent:=Self;
    Name:='imgSceltaRapida';
    ImageFile.FileName:=filebtnSceltaRapida;
    Hint:=A000TraduzioneStringhe('Accesso rapido');
    AltText:=Hint;
    css:=CssImg;
  end;
end;

//procedure TWR010FBase.AddScrollBar(DivName, PageName: String);
//begin
//  AddScrollBarManager(DivName, PageName);
//end;

procedure TWR010FBase.AddScrollBarManager(DivName:String; PageName:String = '');
{aggiunge elemento per la gestione delle scroll bar dei div:
 Nome del div a cui si riferiscono le scrollbar
 HiddenFields per registrare l'attuale posizione
 coordinate Top/Left per eventuale forzatura da codice}
var h:Integer;
    n:String;
begin
  h:=High(lstScrollBar) + 1;
  SetLength(lstScrollBar,h + 1);
  lstScrollBar[h].divName:=DivName;
  lstScrollBar[h].Top:=-1;
  lstScrollBar[h].Left:=-1;
  if PageName = '' then
    PageName:=medpCodiceForm;
  //Hidden field TOP
  n:=(PageName + DivName + 'SCROLLTOP').ToUpper;
  HiddenFields.Add(Format('%s=0',[n]));
  lstScrollBar[h].HFTop:='HIDDEN_' + n;
  //Hidden field LEFT
  n:=(PageName + DivName + 'SCROLLLEFT').ToUpper;
  HiddenFields.Add(Format('%s=0',[n]));
  lstScrollBar[h].HFLeft:='HIDDEN_' + n;
end;

function TWR010FBase.ScrollBarIndexOf(DivName:String):Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=0 to High(lstScrollBar) do
    if lstScrollBar[i].divName.ToUpper = DivName.ToUpper then
    begin
      Result:=i;
      Break;
    end;
end;

procedure TWR010FBase.GestioneScrollBar;
{chiamate javascript per effettuare il riposizionamento in base al contenuto degli hiddenfields}
var i:Integer;
    s:String;
begin
  //Scrollbar principale della pagina
  AddToInitProc('window.scrollTo(document.getElementById("HIDDEN_WR010SCROLLLEFT").value,document.getElementById("HIDDEN_WR010SCROLLTOP").value);');

  //Scrollbar dei div personalizzati
  for i:=0 to High(lstScrollBar) do
  begin
    if lstScrollBar[i].Top >= 0 then
    begin
      AddToInitProc(Format('document.getElementById("%s").value=%d;',[lstScrollBar[i].HFTop,lstScrollBar[i].Top]));
      lstScrollBar[i].Top:=-1;
    end;
    if lstScrollBar[i].Left >= 0 then
    begin
      AddToInitProc(Format('document.getElementById("%s").value=%d;',[lstScrollBar[i].HFLeft,lstScrollBar[i].Left]));
      lstScrollBar[i].Left:=-1;
    end;
    s:=Format('$("#%s").scrollTop(document.getElementById("%s").value);',[lstScrollBar[i].divName,lstScrollBar[i].HFTop]);
    AddToInitProc(s);
    s:=Format('$("#%s").scrollLeft(document.getElementById("%s").value);',[lstScrollBar[i].divName,lstScrollBar[i].HFLeft]);
    AddToInitProc(s);
  end;
end;

procedure TWR010FBase.IWAppFormRender(Sender: TObject);
var
  Riga, RigaSep, LMsg: String;
  procedure WR010RenderWidgets(Sender: TWinControl);
  var
    i,j,x: Integer;
  begin
    for i:=0 to Sender.ControlCount - 1 do
      if (Sender.Controls[i] is TFrame) then
      begin
        x:=-1;
        //Controllo che il frame non sia già stato considerato nel ciclo su Components della form stessa
        for j:=0 to ComponentCount - 1 do
          if Sender.Controls[i] = Components[j] then
          begin
            x:=j;
            Break;
          end;
        if x = - 1 then
          RenderWidgets(Sender.Controls[i], PageContext);
      end;
  end;
const
  FUNZIONE = 'WR010.IWAppFormRender';
begin
  // cronometro
  FRenderTime:=Now;

  // in debug abilita tutti i widget jquery, per diagnosticare eventuali problemi
  {$WARN SYMBOL_PLATFORM OFF}
  if DebugHook <> 0 then
  {$WARN SYMBOL_PLATFORM ON}
  begin
    jqInit.Enabled:=True;
    jqAccordion.Enabled:=True;
    jqAlert.Enabled:=True;
    jqAutocomplete.Enabled:=True;
    jqCalendario.Enabled:=True;
    jqCalendarioPeriodo.Enabled:=True;
    jqContextMenu.Enabled:=True;
    jqDebug.Enabled:=True;
    jqFixedHeader.Enabled:=True;
    jqFrame.Enabled:=True;
    jqGritter.Enabled:=True;
    jqHistory.Enabled:=True;
    jqMask.Enabled:=True;
    jqMessaggio.Enabled:=True;
    //jqPublicIP.Enabled:=True; // no, vedi blocco seguente
    jqTemp.Enabled:=True;
    jqTooltip.Enabled:=True;
    jqUtility.Enabled:=True;
    jqWatermark.Enabled:=True;
  end;

  // lo script che si occupa di estrarre l'ip pubblico è attivo in base al
  // relativo parametro aziendale e fino a che l'ip viene determinato
  jqPublicIP.Enabled:=(not IsLoginForm) and
                      (Parametri <> nil) and
                      (Parametri.CampiRiferimento.C90_W038CheckIP = 'S') and
                      (Parametri.ClientIPInfo.Status = isUndefined);

  //Inibizione drag e drop di elementi
  //Caratto 06/052014 il drag deve essere abilitato se no le dialogbox non sono più spostabili
  //PageContext.BodyTag.AddStringParam('ondragstart','return false;');
  PageContext.BodyTag.AddStringParam('ondrop','return false;');

  // se la form è modale nasconde il menu e le immagini di accesso rapido
  if FModale then
  begin
    Log('Traccia',Format('Menu principale nascosto: form %s modale',[FCodiceForm]));
    NascondiMenu;
  end;

  if RefreshPageAttivo then
  begin
    // 1. aggiorna il menu
    if not medpModale then
      GestioneMenu;

    // 2. effettua refresh dati pagina (form già creata precedentemente)
    try
      Log('Traccia','RefreshPage.inizio');
      RefreshPage;
      Log('Traccia','RefreshPage.fine');
    except
      on E: Exception do
        Log(ERRORE,'RefreshPage',E);
    end;
    RefreshPageAttivo:=False;

    // aggiorna le icone di accesso rapido
    AggiornaIconeAccessoRapido;

    // se il controllo ip è attivo verifica le abilitazioni
    // serve in caso di gestione con pagina iniziale
    if Parametri.CampiRiferimento.C90_W038CheckIP = 'S' then
      ImpostaAbilitazioniI076;
  end;

  // disegno history
  if (not IsLoginForm) and (medpCodiceForm <> 'X001') then
  begin
    WR000DM.History.Disegna((Self as TIWAppForm));
  end;

  // info utente
  if not IsLoginForm then
  begin
    Riga:='<tr><td>%s:</td><td>%s</td></tr>';
    RigaSep:='<tr style="height: 4px;"><td colspan="2"></td></tr>';
    TagLoginTooltip:=Format(Riga,['Azienda',LoginInfo.Azienda]) +
                     Format(Riga,['Utente',LoginInfo.Utente,Format(' (%s)',[LoginInfo.TipoUtente])]) +
                     IfThen(LoginInfo.ProfiloWEB <> '',
                            Format(Riga,['Profilo web',LoginInfo.ProfiloWEB])) +
                     RigaSep +
                     Format(Riga,['Filtro permessi',Parametri.ProfiloFiltroPermessi]) +
                     Format(Riga,['Filtro anagrafe',Parametri.ProfiloFiltroAnagrafe]) +
                     Format(Riga,['Filtro funzioni',Parametri.ProfiloFiltroFunzioni]) +
                     Format(Riga,['Filtro dizionario',Parametri.ProfiloFiltroDizionario]) +
                     IfThen(LoginInfo.ProfiloIter <> '',
                            Format(Riga,['Filtro iter',LoginInfo.ProfiloIter])) +
                     RigaSep +
                     Format(Riga,['Timeout',Format('%d min.', [IfThen(TSessioneWeb(GGetWebApplicationThreadVar.Data).TimeOutOriginale > 0,TSessioneWeb(GGetWebApplicationThreadVar.Data).TimeOutOriginale, GGetWebApplicationThreadVar.SessionTimeOut)])]) +
                     Format(Riga,['Layout',LoginInfo.Layout]) +
                     RigaSep +
                     Format(Riga,['Server',Trim(Parametri.HostIPAddress + ' ' + Parametri.HostName)]) +
                     Format(Riga,['IP locale',Parametri.ClientIPInfo.IPLocale]) +
                     IfThen(Parametri.ClientIPInfo.IP <> '',
                            Format(Riga,['IP internet',Parametri.ClientIPInfo.IP]));
  end;

  // controlli di debug
  {$WARN SYMBOL_PLATFORM OFF}
  if DebugHook <> 0 then
  begin
    if HandleTabs then
      DebugAdd('W','Impostare la proprietà <b>HandleTabs</b> = False',Self.Name);
    if HelpKeyword = '' then
      DebugAdd('W','Impostare la proprietà <b>HelpKeyword</b>: attualmente è nulla',Self.Name);
    if (Tag = 0) and
       (not R180In(medpCodiceForm,['WA002','X001'])) and
       (not IsLoginForm)  then
      DebugAdd('W','Impostare la proprietà <b>Tag</b>: attualmente vale 0',Self.Name);
    if Trim(Title) = '' then
      DebugAdd('W','Impostare la proprietà <b>Title</b>: attualmente è nulla',Self.Name);
  end;
  {$WARN SYMBOL_PLATFORM ON}

  // gestione controlli basati su IP.ini
  // effettuare queste operazioni prima di CicloComponenti
  // se sono presenti controlli basati su IP, verifica se la maschera stessa è abilitata
  if EsisteControlloI076(Self) then
  begin
    ImpostaAbilitazioneI076(Self);

    // se la form non è abilitata rimuove il blocco del contenuto
    if not Self.medpI076Info.Enabled then
    begin
      // potrebbe dare problemi agli script previsti per la pagina, pertanto non attivare questa gestione
      //jqTemp.OnReady.Add('$("#T000contenuto").remove();');

      // se la form è disabilitata visualizza un messaggio di warning con
      // un testo esplicativo, contenuto in medpNotEnabledReason
      LMsg:=Self.medpI076Info.Message;
      if LMsg <> '' then
      begin
        MsgBox.WebMessageDlg(LMsg,mtError,[mbOk],OnConfermaFormNotEnabled,'',Self.medpNomeFunzione);
      end;
    end;
  end;
  // gestione controlli basati su IP.fine

  // elaborazione componenti interfaccia
  CicloComponenti;

  // impostazione dei template di default, in particolare di frame e region dinamici
  ImpostaTemplate;

  // traduzione elementi interfaccia
  TraduzioneElementi(Self);

  //Ciclo su frame che hanno questa form come Parent ma non come Owner per considerare il loro JQueryWidget e renderizzarlo
  //Alberto 17/01/2013: questo ciclo è stato testato inizialmente su "procedure TIWForm.RenderWidgets"
  WR010RenderWidgets(Self);

  // gestione dei campi nascosti
  CampiNascosti;

  //riposizionamento scrollbar sulle posizioni precedenti
  GestioneScrollBar;

  (* MAN/07 SVILUPPO#84 - Funzione per intercettare la chiusura *)
  if Assigned(GGetWebApplicationThreadVar) and
    (not GGetWebApplicationThreadVar.Browser.IsMobile) and
    (Pos(INI_PAR_DISABLE_CHIUSURA_BROWSER,W000ParConfig.ParametriAvanzati) = 0)
  then
    AddToInitProc('window.onbeforeunload = medpunload;');   //medpunload in FunzioniGenerali.js

  // errori e warning visualizzati in fase di debug
  {$WARN SYMBOL_PLATFORM OFF}
  if DebugHook <> 0 then
  begin
    DebugShow;

    // cronometro render
    LogConsoleTime(FUNZIONE,FRenderTime);

    // cronometro create + render
    if PrimoRender then
    begin
      LogConsoleTime('WR010.IWAppFormCreate + FormRender',FCreateTime);
    end;

    // segnala errori formali
    if FCompError then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Messaggio visibile solo in debug' + CRLF + 'Sono presenti errori bloccanti che impediscono il corretto funzionamento di questa funzione.' + CRLF +
                                 'Verificare le anomalie segnalate nel riquadro in basso a dx e correggerle!');
    end;
  end;
  {$WARN SYMBOL_PLATFORM ON}

  PrimoRender:=False;
end;

procedure TWR010FBase.OnConfermaFormNotEnabled(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
// risposta al messaggio di form non abilitata
begin
  if WR000DM.PaginaSingola <> '' then
  begin
    // in modalità "pagina singola" effettua il logout
    lnkEsciClick(nil);
  end
  else
  begin
    // se non si è in modalita "pagina singola" chiude semplicemente la maschera
    ClosePage;
  end;
end;

procedure TWR010FBase.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 14 OK }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    lstFrameOpen.Clear;

    // pulizia jquery widget
    if Assigned(jqAlert) then
      jqAlert.OnReady.Clear;
    if Assigned(jqFrame) then
      jqFrame.OnReady.Clear;
    if Assigned(jqTemp) then
      jqTemp.OnReady.Clear;

    // cancella messaggi di debug
    if FDebugList <> nil then
      FDebugList.Clear;
  end
end;

procedure TWR010FBase.IWAppFormDestroy(Sender: TObject);
var
  i:Integer;
begin
  Log('Traccia','IWAppFormDestroy.ini');
  try DistruggiFrame; except end;
  FProcSiMsg:=nil;
  FProcNoMsg:=nil;
  try FreeAndNil(FMsgBox); except end;
  try FreeAndNil(lnkContextMenu); except end;
  try FreeAndNil(lnkRefreshPage); except end;
  try FreeAndNil(JavascriptBottom); except end;
  try FreeAndNil(ParametriList); except end;
  try FreeAndNil(lstFrameOpen); except end;
  {$WARN SYMBOL_PLATFORM OFF}
  if DebugHook <> 0 then
    try FreeAndNil(FDebugList); except end;
  {$WARN SYMBOL_PLATFORM ON}
  {$IFNDEF INTRAWEBSVC}try FreeAndNil(FileBox); except end;{$ENDIF}
  SetLength(FrameArr,0);
  SetLength(FRegionArr,0);
  DistruggiJQuery; // non può sollevare eccezioni
  // distruzione degli oggetti creati a runtime
  try DistruggiOggetti; except end;
  try FreeAndNil(FRegistraMsg); except end;
  //pusanti sull'intestazone
  try FreeAndNil(imgIndietro); except end;
  try FreeAndNil(imgChiudiSchede); except end;
  try FreeAndNil(imgEsci); except end;
  try FreeAndNil(imgIWIC); except end;
  try FreeAndNil(imgHelp); except end;
  try FreeAndNil(imgSceltaRapida); except end;
  // Distruggo eventuali gestori chiamate AJAX creati
  for i:=0 to Length(GestoriChiamateAJAX) - 1 do
  begin
    try FreeAndNil(GestoriChiamateAJAX[i]); except end;
  end;
  Log('Traccia','IWAppFormDestroy.fine');
end;


//############################################//
//###           GESTIONE FORM              ###//
//############################################//

procedure TWR010FBase.OpenPage;
// procedura pubblica di open
begin
  try
    if ErroreCreate = '' then
    begin
      // se il tag della form è diverso da quello iniziale utilizzato per estrarre
      // le informazioni sull'abilitazione della form, allora rilegge le abilitazioni
      if Tag <> FTagAbilitazioni then
      begin
        LeggiAbilitazioneForm;
      end;

      if AccessoAbilitato and InizializzaAccesso then
      begin
        // gestione tab di default

        //Caratto 14/03/2014 getione funzione non abilitata
        //se la funzione è abilita annullo openerTag.
        //Se impostato alla chiusura rimanda alla form da dove è stata aperta
        FOpenerTag:=-1;

        // visualizza la form solo se l'utente è abilitato alla funzione
        // e la funzione di inizializzazione è andata a buon fine
        Show;

        // aggiorna le icone di accesso rapido
        AggiornaIconeAccessoRapido;
      end
      else
      begin
        // chiude immediatamente la form
        if not AccessoAbilitato then //solo in caso di non AccessoAbilitato. se non InizializzaAccesso è la funzione stessa a dare il messaggio
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        end;

        ClosePage;
      end;
    end
    else
    begin
      // se si è verificato un errore nella IWAppFormCreate,
      // dà la segnalazione e chiude la form
      GGetWebApplicationThreadVar.ShowMessage(ErroreCreate);

      // chiude immediatamente la form
      ClosePage;
    end;
  except
    // in caso di errore chiude la form e rilancia l'eccezione
    ClosePage;
    raise;
  end;
end;

procedure TWR010FBase.SetTag(const PTag: Integer);
begin
  // imposta il nuovo tag e rilegge le abilitazioni
  Tag:=PTag;
  LeggiAbilitazioneForm;
end;

procedure TWR010FBase.LeggiAbilitazioneForm;
var
  LAbilitazione: String;
  JsCode: String;
  i: Integer;
const
  WR010_READONLY   = '/*WR010_READONLY*/';
  WR010_FILTROFUNZ = '/*WR010_READONLY*/';
begin
  // imposta nome funzione
  FNomeFunzione:=GetNomeFunzione;

  // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161
  // estrae dati di abilitazione maschera
  DatiAbilitazioni:=A000GetAbilitazioniFunzioni('Tag',Tag.ToString);
  // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161

  // abilitazione funzione
  if Pos(INI_PAR_NO_ABILITAZIONI,W000ParConfig.ParametriAvanzati) = 0 then
    LAbilitazione:=A000GetInibizioni('Tag',IntToStr(Tag))
  else
    LAbilitazione:='S';

  // in caso di pagina singola disabilita tutte le altre funzioni
  if (LAbilitazione <> 'N') and
     (WR000DM.PaginaSingola <> '') and
     (Tag >= 0) and
     (L021SiglaByTag(Tag).ToUpper <> WR000DM.PaginaSingola.ToUpper) then
    LAbilitazione:='N';

  {$IFDEF WEBPJ}
  //Lettura funzioni abilitate su I081
  if Pos(INI_PAR_NO_ABILITAZIONI,W000ParConfig.ParametriAvanzati) = 0 then
  begin
    if (LAbilitazione <> 'N') and (Tag >= 0) and (not Parametri.ModuloInstallato['IRIS_CLOUD_FULL']) then
    try
      WR000DM.selI081.Open;
      if not WR000DM.selI081.SearchRecord('TAG',Tag,[srFromBeginning]) then
        LAbilitazione:='N';
    except
      LAbilitazione:='N';
    end;

    // in alcuni casi particolari l'abilitazione della funzione viene *COMPLETAMENTE* bypassata
    case Tag of
      158: // cambio azienda: abilitato se l'utente è presente in più aziende con flag di ricerca attivato
        begin
          LAbilitazione:=IfThen(WR000DM.IsCambioAziendaAbilitato,'S','N');
        end;
    end;
  end;
  {$ENDIF}

  AccessoAbilitato:=LAbilitazione <> 'N';
  SolaLettura:=LAbilitazione = 'R';

  // rimuove impostazioni js particolari
  for i:=0 to JavascriptBottom.Count - 1 do
  begin
    if (Pos(WR010_READONLY,JavascriptBottom[i]) > 0) or
       (Pos(WR010_FILTROFUNZ,JavascriptBottom[i]) > 0) then
    begin
      JavascriptBottom.Delete(i);
      Break;
    end;
  end;

  // imposta classe css per form di sola lettura
  if SolaLettura then
  begin
    JsCode:=WR010_READONLY +
            'document.getElementById("nomeForm").className = "readOnlyForm"; ' +
            'document.getElementById("paginaCorrente").title = "pagina corrente (sola lettura)"; ';
    JavascriptBottom.Add(JsCode);
  end;

  // in debug aggiunge info sul tooltip
  {$WARN SYMBOL_PLATFORM OFF}
  if DebugHook <> 0 then
  {$WARN SYMBOL_PLATFORM ON}
  begin
    // reimposta il tooltip in modo da visualizzare più informazioni
    JsCode:=Format('[tag = %d] ',[DatiAbilitazioni.Tag]) +
            Format('[inibizione = %s] ',[DatiAbilitazioni.Inibizione]) +
            Format('[accesso browse = %s] ',[DatiAbilitazioni.AccessoBrowse]) +
            Format('[righe pagina = %d] ',[DatiAbilitazioni.RighePagina]);
    JsCode:=WR010_FILTROFUNZ +
            Format('document.getElementById("paginaCorrente").title = "%s"; ',[JsCode.Trim]);
    JavascriptBottom.Add(JsCode);
  end;

  // salva il tag considerato per l'abilitazione
  FTagAbilitazioni:=Tag;
end;

function TWR010FBase.InizializzaAccesso: Boolean;
begin
  Result:=True;

  // per impedire l'accesso effettuare queste operazioni:
  //   1. restituire False
  //   2. richiamare la funzione "MsgBox.MessageBox" indicando il motivo dell'accesso negato

  // !!! EVITARE di sollevare eccezioni in questa function !!!
end;

procedure TWR010FBase.CtrlAddHistory;
// verifica se è possibile aggiungere la form alla history
var
  Add: Boolean;
  i: Integer;
begin
  if (WR000DM <> nil) and
     (not IsLoginForm) then
  begin
    // caso speciale di ricerca anagrafe
    if FNomeForm = 'W002FRicercaAnagrafe' then
      Add:=FAddToHistory and ((WR000DM.Responsabile) or (not Parametri.InibizioneIndividuale))
    else
      Add:=FAddToHistory;

    if Add then
      i:=WR000DM.History.FormAdd(Self)
    else
      i:=-1;

    // visibilità link "indietro" e "chiudi schede"
    lnkIndietro.Visible:=Add and (i > 0);
    imgIndietro.Visible:=Add and (i > 0);
    lnkChiudiSchede.Visible:=Add;
    imgChiudiSchede.Visible:=Add;
    imgSceltaRapida.Visible:=Add;
    imgIWIC.Visible:=Add and ((Trim(W000ParConfig.UrlWebApp) <> '') or (WR000DM.EsisteUtenteI070 and (Trim(W000ParConfig.UrlIrisWebCloud) <> '')));
  end
  else
  begin
    lnkIndietro.Visible:=False;
    imgIndietro.Visible:=False;
    lnkChiudiSchede.Visible:=False;
    imgChiudiSchede.Visible:=False;
    imgSceltaRapida.Visible:=False;
    imgIWIC.Visible:=False;
  end;
end;

procedure TWR010FBase.ClosePage;
begin
  if FAddToHistory then
  begin
    // gestione rimozione form dalla history e release
    actLinkClose(Self);
  end
  else
  begin
    // la form non è nella history -> release immediato
    Self.Release;
  end;
end;

procedure TWR010FBase.RefreshPage;
// questa procedura viene richiamata sul IWAppFormRender quando si torna
// sulla form corrente da un'altra form della history se RefreshPageAttivo = True
// indicare le azioni da eseguire per effettuare eventuali refresh dei dataset ecc...
begin
  // ridefinire
end;

procedure TWR010FBase.AggiornaIconeAccessoRapido;
begin
  // ridefinire
end;

procedure TWR010FBase.AggiornaIconaAccessoRapido;
begin
  // ridefinire
end;

procedure TWR010FBase.ImpostaTemplate;
var
  i,j: Integer;
  procedure CtrlAssegnaTemplate(PLayoutMgr: TIWContainerLayout; const PContainerName, PContainerClassName: String);
  // assegna il template di default al layoutmanager
  var
    TP: TIWTemplateProcessorHTML;
  begin
    // Nota: LayoutMgr è una property che non è ereditata, ma definita su ogni unit su cui serve
    if Assigned(PLayoutMgr) and
       (PLayoutMgr is TIWTemplateProcessorHTML) and
       (PLayoutMgr.Enabled) then
    begin
      TP:=(PLayoutMgr as TIWTemplateProcessorHTML);
      if TP.Templates.Default = '' then
      begin
        // TWnnnNomeFunzione -> WnnnNomeFunzione.html
        TP.Templates.Default:=Format('W%s.html',[Copy(PContainerClassName,3)]);
      end;
      // in debug verifica esistenza template
      {$WARN SYMBOL_PLATFORM OFF}
      if DebugHook <> 0 then
      {$WARN SYMBOL_PLATFORM ON}
      begin
        if not FileExists(gSC.TemplateDir + TP.Templates.Default) then
        begin
          raise Exception.Create(Format('%s: il template %s è inesistente',[PContainerName,TP.Templates.Default]));
        end;
      end;
    end;
  end;
begin
  // template processor della form
  CtrlAssegnaTemplate(LayoutMgr,Self.Name,Self.ClassName);

  // template processor dei frame
  for i:=0 to High(FrameArr) do
  begin
    if Assigned(FrameArr[i]) then
    begin
      if FrameArr[i].ControlCount > 1 then
      begin
        // se ci sono controlli visuali associati al frame non vengono visualizzati
        // se i controlli non sono visuali ignorare il warning
        DebugAdd('W','Potrebbero essere presenti componenti visuali associati al Frame: spostarli sulla IWFrameRegion',FrameArr[i].Name);
      end;
      for j:=0 to FrameArr[i].ComponentCount - 1 do
      begin
        if (FrameArr[i].Components[j] is TIWRegion) then
          CtrlAssegnaTemplate((FrameArr[i].Components[j] as TIWRegion).LayoutMgr,FrameArr[i].Name,FrameArr[i].ClassName);
      end;
    end;
  end;

  // template processor delle region
  for i:=0 to High(FRegionArr) do
  begin
    if Assigned(FRegionArr[i]) then
      CtrlAssegnaTemplate(FRegionArr[i].LayoutMgr,FRegionArr[i].Name,FRegionArr[i].ClassName);
  end;
end;

procedure TWR010FBase.CreaJQuery;
var
  CodLingua,DatePickerStrLocal: String;
begin
  // creazione dei componenti
  jqInit:=TIWJQueryWidget.Create(Self);
  jqInit.Name:='jqInit';
  jqInit.Tag:=-1;
  jqInit.OnReady.Text:=W000JQ_Init;

  // traduzione datepicker.ini
  // il codice di impostazione delle impostazioni locali è eseguito nella Initialize
  // per avere la garanzia che tutto il javascript sia stato caricato
  CodLingua:='it';
  if Parametri.CampiRiferimento.C90_Lingua = 'INGLESE' then
    CodLingua:='en-GB';
  DatePickerStrLocal:=Format('try { $.datepicker.setDefaults($.datepicker.regional["%s"]); } catch (err) { }',[CodLingua]);
  jqInit.OnReady.Add(DatePickerStrLocal);
  // traduzione datepicker.fine

  jqAccordion:=TIWJQueryWidget.Create(Self);
  jqAccordion.Name:='jqAccordion';
  jqAccordion.Tag:=-1;
  jqAccordion.OnReady.Text:=W000JQ_Accordion;
  jqAccordion.Enabled:=False;

  jqAlert:=TIWJQueryWidget.Create(Self);
  jqAlert.Name:='jqAlert';
  jqAlert.Tag:=-1;

  jqAutocomplete:=TIWJQueryWidget.Create(Self);
  jqAutocomplete.Name:='jqAutocomplete';
  jqAutocomplete.Tag:=-1;
  jqAutocomplete.OnReady.Text:=W000JQ_Autocomplete;
  jqAutocomplete.Enabled:=False;

  jqCalendario:=TIWJQueryWidget.Create(Self);
  jqCalendario.Name:='jqCalendario';
  jqCalendario.Tag:=-1;
  jqCalendario.OnReady.Text:=W000JQ_Calendario;
  jqCalendario.Enabled:=False;

  jqCalendarioPeriodo:=TIWJQueryWidget.Create(Self);
  jqCalendarioPeriodo.Name:='jqCalendarioPeriodo';
  jqCalendarioPeriodo.Tag:=-1;
  jqCalendarioPeriodo.Enabled:=False;

  jqContextMenu:=TIWJQueryWidget.Create(Self);
  jqContextMenu.Name:='jqContextMenu';
  jqContextMenu.Tag:=-1;
  jqContextMenu.Enabled:=(not IsLoginForm);

  jqDebug:=TIWJQueryWidget.Create(Self);
  jqDebug.Name:='jqDebug';
  jqDebug.Tag:=-1;
  {$WARN SYMBOL_PLATFORM OFF}
  jqDebug.Enabled:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  jqFixedHeader:=TIWJQueryWidget.Create(Self);
  jqFixedHeader.Name:='jqFixedHeader';
  jqFixedHeader.Tag:=-1;
  jqFixedHeader.Enabled:=False;

  jqFrame:=TIWJQueryWidget.Create(Self);
  jqFrame.Tag:=-1;
  jqFrame.Name:='jqFrame';

  jqGritter:=TIWJQueryWidget.Create(Self);
  jqGritter.Tag:=-1;
  jqGritter.Name:='jqGritter';

  jqHistory:=TIWJQueryWidget.Create(Self);
  jqHistory.Tag:=-1;
  jqHistory.Name:='jqHistory';

  jqMask:=TIWJQueryWidget.Create(Self);
  jqMask.Tag:=-1;
  jqMask.Name:='jqMask';
  jqMask.OnReady.Text:=W000JQ_Mask;
  jqMask.Enabled:=False;

  jqMessaggio:=TIWJQueryWidget.Create(Self);
  jqMessaggio.Tag:=-1;
  jqMessaggio.Name:='jqMessaggio';

  jqPublicIP:=TIWJQueryWidget.Create(Self);
  jqPublicIP.Tag:=-1;
  jqPublicIP.Name:='jqPublicIP';
  jqPublicIP.OnReady.Text:=Format(W000JQ_PublicIP,[FJSCallbackName]);

  jqTemp:=TIWJQueryWidget.Create(Self);
  jqTemp.Tag:=-1;
  jqTemp.Name:='jqTemp';

  jqTooltip:=TIWJQueryWidget.Create(Self);
  jqTooltip.Tag:=-1;
  jqTooltip.Name:='jqTooltip';
  jqTooltip.Enabled:=(not IsLoginForm);
  jqTooltip.OnReady.Text:=W000JQ_Tooltip;

  jqUtility:=TIWJQueryWidget.Create(Self);
  jqUtility.Tag:=-1;
  jqUtility.Name:='jqUtility';

  jqWatermark:=TIWJQueryWidget.Create(Self);
  jqWatermark.Tag:=-1;
  jqWatermark.Name:='jqWatermark';
  jqWatermark.Enabled:=False;

  jqReplaceCache:=TIWJQueryWidget.Create(Self);
  jqReplaceCache.Tag:=-1;
  jqReplaceCache.Name:='jqReplaceCache';
  jqReplaceCache.Enabled:=not IsLibrary;
  jqReplaceCache.OnReady.Text:=W000JQ_ReplaceCache;
end;

procedure TWR010FBase.CreaNavigatorBar(actlstNavBar: TActionList; grdNavBar: TmeIWGrid; cmbIncollaOpzioni: TmeIWComboBox; _onClick: TprocSender);
var
  i, k:Integer;
  PrecCategory: String;
begin
  grdNavBar.RowCount:=1;
  grdNavBar.ColumnCount:=actlstNavBar.ActionCount;

  if actlstNavBar.ActionCount > 0 then
    PrecCategory:=TAction(actlstNavBar.Actions[0]).Category;

  k:=0;
  for i:=0 to actlstNavBar.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(actlstNavBar.Actions[i]).Category  then
    begin
      grdNavBar.Cell[0,k].Css:='x';
      grdNavBar.Cell[0,k].Text:='';
      k:=k + 1;
      grdNavBar.ColumnCount:=grdNavBar.ColumnCount + 1;
      PrecCategory:=TAction(actlstNavBar.Actions[i]).Category;
    end;

    if ((actlstNavBar.Actions[i] as TAction).Name = 'actIncollaOpzioni') and (cmbIncollaOpzioni <> nil) then
    begin
      grdNavBar.Cell[0,k].Css:='x';
      grdNavBar.Cell[0,k].Control:=cmbIncollaOpzioni;
    end
    else
    begin
      grdNavBar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
      with TmeIWImageFile(grdNavBar.Cell[0,k].Control) do
      begin
        Name:=C190CreaNomeComponente(TAction(actlstNavBar.Actions[i]).Name,Self);
        //OnClick:=imgNavBarClick;
        OnClick:=_onClick;
        Tag:=i;
      end;

      grdNavBar.Cell[0,k].Css:='x';
      grdNavBar.Cell[0,k].Text:='';
    end;

    k:=k + 1;
  end;
  AggiornaToolBar(grdNavBar,actlstNavBar);
end;

procedure TWR010FBase.AggiornaToolBar(ToolBarGrid:TIWGrid;ActionList:TActionList);
// Imposta le proprietà Visible e Enabled dei pulsanti legati alle Action delle ToolBar
var
  i, k:Integer;
  PrecCategory,NomeFile: String;
  img: TmeIWImageFile;
  act: TAction;
begin
  if ActionList.ActionCount > 0 then
    PrecCategory:=TAction(ActionList.Actions[0]).Category;

  k:=0;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(ActionList.Actions[i]).Category  then
    begin
      k:=k + 1;
      PrecCategory:=TAction(ActionList.Actions[i]).Category;
    end;
    if k > ToolBarGrid.ColumnCount - 1 then
      Break;

    //img:=TmeIWImageFile(ToolBarGrid.Cell[0,k].Control);
    act:=TAction(ActionList.Actions[i]);

    ToolBarGrid.Cell[0,k].Visible:=act.Visible;
    //if act.Tag < 1000 then
    if (ToolBarGrid.Cell[0,k].Control is TmeIWImageFile) and not(ToolBarGrid.Cell[0,k].Control is TmedpIWImageButton) then
    begin
      if act.Visible then
      begin
        img:=TmeIWImageFile(ToolBarGrid.Cell[0,k].Control);
        img.Hint:=act.Hint;
        img.Enabled:=act.Enabled;
        NomeFile:=act.Caption + IfThen(not act.Enabled,'_Disabled') + IfThen(act.Checked,'_Checked');
        img.ImageFile.FileName:=Format('img/%s.png',[NomeFile]);
      end;
    end
    else
    begin
      if ToolBarGrid.Cell[0,k].Control <> nil then
        TIWCustomControl(ToolBarGrid.Cell[0,k].Control).Enabled:=act.Enabled;
    end;
    k:=k + 1;
  end;

  if not ToolBarGrid.Enabled then
    AbilitaToolBar(ToolBarGrid,False,ActionList);
end;

procedure TWR010FBase.AbilitaToolBar(ToolBarGrid:TIWGrid;Abilitazione:Boolean;ActionList:TActionList);
var i:Integer;
  NomeFile: String;
  img :TmeIWImageFile;
begin
  ToolBarGrid.Enabled:=Abilitazione;
  for i:=0 to ToolBarGrid.ColumnCount - 1 do
    if ToolBarGrid.Cell[0,i].Control <> nil then
    begin
      (ToolBarGrid.Cell[0,i].Control as TIWCustomControl).Enabled:=Abilitazione;
      if ToolBarGrid.Cell[0,i].Control is TmeIWImageFile then
      begin
        img:=(ToolBarGrid.Cell[0,i].Control as TmeIWImageFile);
        NomeFile:=LowerCase(img.ImageFile.FileName);

        if not Abilitazione then
        begin
          if pos('_disabled',NomeFile) = 0 then
          begin
            if pos('_checked',NomeFile) = 0 then
              NomeFile:=StringReplace(NomeFile,'.png','_disabled.png',[rfReplaceAll])
            else
              NomeFile:=StringReplace(NomeFile,'_checked','_disabled_checked',[rfReplaceAll]);
          end;
        end;

        img.ImageFile.FileName:=NomeFile;
      end;

    end;
  //if Abilitazione then
  if ToolBarGrid.Enabled then
    if (ActionList <> nil) and (ToolBarGrid.ColumnCount > 1) then
      AggiornaToolBar(ToolBarGrid,ActionList);
end;

function TWR010FBase.GetWaterMarkEnabled:Boolean;
begin
  Result:=jqWaterMark.Enabled;
end;

procedure TWR010FBase.SetWaterMarkEnabled(Value:Boolean);
begin
  jqWaterMark.Enabled:=Value;
end;

procedure TWR010FBase.DistruggiJQuery;
begin
  try FreeAndNil(jqInit); except end;
  try FreeAndNil(jqAccordion) except end;
  try FreeAndNil(jqAlert); except end;
  try FreeAndNil(jqAutocomplete); except end;
  try FreeAndNil(jqCalendario); except end;
  try FreeAndNil(jqCalendarioPeriodo); except end;
  try FreeAndNil(jqContextMenu); except end;
  try FreeAndNil(jqDebug); except end;
  try FreeAndNil(jqFixedHeader); except end;
  try FreeAndNil(jqGritter); except end;
  try FreeAndNil(jqFrame); except end;
  try FreeAndNil(jqHistory); except end;
  try FreeAndNil(jqMask); except end;
  try FreeAndNil(jqMessaggio); except end;
  try FreeAndNil(jqPublicIP); except end;
  try FreeAndNil(jqTemp); except end;
  try FreeAndNil(jqTooltip); except end;
  try FreeAndNil(jqUtility); except end;
  try FreeAndNil(jqWatermark); except end;
  try FreeAndNil(jqReplaceCache); except end;
end;

procedure TWR010FBase.DistruggiFrame;
var
  FM: TWR200FBaseFM;
  i: Integer;
begin
  for i:=ControlCount - 1 downto 0 do
  begin
    if Controls[i] is TWR200FBaseFM then
    begin
      FM:=(Controls[i] as TWR200FBaseFM);
      try
        FM.ReleaseOggetti;
      except
      end;
    end;
  end;
end;

procedure TWR010FBase.SetParam(const Chiave, Valore: String);
begin
  ParametriList.Values[UpperCase(Chiave)]:=Valore;
end;

procedure TWR010FBase.SetParam(const Chiave: String; const Valore: Integer);
begin
  SetParam(Chiave,IntToStr(Valore));
end;

procedure TWR010FBase.SetParam(const Chiave: String; const Valore: TDateTime);
begin
  SetParam(Chiave,DateToStr(Valore));
end;

procedure TWR010FBase.SetParam(const Chiave: String; const Valore: Boolean);
begin
  SetParam(Chiave,BoolToStr(Valore));
end;

function TWR010FBase.GetParam(const Chiave: String): String;
var
  ChiaveUpper: String;
begin
  ChiaveUpper:=UpperCase(Chiave);
  if ParametriList.IndexOfName(ChiaveUpper) < 0 then
    Result:=''
  else
    Result:=ParametriList.Values[ChiaveUpper];
end;

function TWR010FBase.IsLoginForm: Boolean;
// ridefinire opportunamente per IrisWeb / IrisCloud
begin
  Result:=False;
end;

function TWR010FBase.IsPageClosing: Boolean;
begin
  Result:=FPageClosing;
end;

procedure TWR010FBase.TemplateProcessorUnknownTag(const AName: string; var VValue: string);
var
  S: String;
begin
  if (Pos('(X001)',Title) = 0) and (WR000DM = nil) then
    Exit;

  S:=UpperCase(AName);
  if (Pos('(X001)',Title) > 0) or (WR000DM.lstCompInvisibili.IndexOf('<' + S + '>') = -1) then
  begin
    if S = 'HISTORY' then
    begin
      // history
      VValue:=TagJsHistory;
    end
    else if S = 'CONTENUTO' then
    begin
      // contenuto proprio della maschera
      // se la form è disabilitata (Form.Enabled = False) il contenuto viene nascosto per sicurezza
      VValue:=Format('<div id="T000contenuto" %s>',[IfThen(not Self.medpI076Info.Enabled,'class="invisibile"')]);
    end
    else if S = 'LOGINTOOLTIP' then
    begin
      VValue:=TagLoginTooltip;
    end
    else if S = 'JAVASCRIPTBOTTOM' then
    begin
      if (Assigned(JavascriptBottom)) and
         (JavascriptBottom.Count > 0) then
      begin
        VValue:=Format('<script type="text/javascript">%s</script>',[JavascriptBottom.Text]);
      end
    end
    else if S = 'POPUPMENU' then
    begin
      VValue:=TagPopupMenuHtml;
    end
    else
      VValue:=A000GetTagSconosciuti(Title,AName);
  end;
end;

function TWR010FBase.IsFissa: Boolean;
// indica se la form è fissa nella history (cioè se non può essere chiusa)
begin
  Result:=FFissa;
end;

procedure TWR010FBase.SetFissa(const Val: Boolean);
// determina se la form è fissa nella history (cioè se non può essere chiusa)
begin
  FFissa:=Val;
end;

function TWR010FBase.IsModale: Boolean;
// determina se la form è modale
begin
  Result:=FModale;
end;

procedure TWR010FBase.SetModale(const Val: Boolean);
begin
  FModale:=Val;
end;

function TWR010FBase.GetNomeForm: String;
 // se esistono più istanze della stessa form, intraweb aggiunge
 // automaticamente il suffisso "_n" al nome
 // es. W005FCartellino, W005FCartellino_1, ...
 // questa funzione restituisce il nome form privato del suffisso
var
  x: Integer;
begin
  x:=Pos('_',Name);
  if x > 0 then
    Result:=Copy(Name,1,x - 1)
  else
    Result:=Name;
end;

function TWR010FBase.GetNomeFunzione: String;
var
  i:Integer;
begin
  Result:=StringReplace(Title,Format('(%s) ',[FCodiceForm]),'',[rfIgnoreCase]);
  for i:=1 to High(FunzioniDisponibili) do
  begin
    if (Tag = FunzioniDisponibili[i].T) and
       ((FunzioniDisponibili[i].M = 'IRIS_WEB') or
         L021VerificaApplicazione(Parametri.Applicazione,i)) then
    begin
      Result:=FunzioniDisponibili[i].N;
      Break;
    end;
  end;
end;

function TWR010FBase.GetInfoFunzione: String;
// restituisce l'informazione da visualizzare come tooltip sul tab della history
begin
  // ridefinire
  Result:='';
end;

function TWR010FBase.GetProgressivo: Integer;
// per le form in cui è significativo, restituisce il progressivo
// del dipendente attualmente selezionato
begin
  // ridefinire
  Result:=-1;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#0.ini
function TWR010FBase.GetInfoSupportoBrowser: TInfoSupportoBrowser;
// restituisce informazioni strutturate relative alla compatibilità
// del browser in uso con i nostri applicativi web
var
  TmpBrowser: TBrowser;
  NomeBrowser, SupportoOk, SupportoErr, Nome, Hint, Link, LinkDownload: String;
  i: Integer;
const
  LINK_CODE   = '<a href="%s" target="_blank" title="%s">%s</a>';
  { DONE : TEST IW 14 OK }
  BROWSER_ARR: array [0..5] of TDatiBrowser = (
    (Nome: 'Firefox';           Hint: 'Mozilla Firefox';   Link: 'https://www.mozilla.org/it/firefox/new/'),
    (Nome: 'Chrome';            Hint: 'Google Chrome';     Link: 'https://www.google.com/intl/it_IT/chrome/browser'),
    (Nome: 'Opera';             Hint: 'Opera';             Link: 'https://www.opera.com/it'),
    (Nome: 'Safari';            Hint: 'Safari';            Link: 'https://www.apple.com/it/safari/'),
    (Nome: 'Internet Explorer'; Hint: 'Internet Explorer'; Link: 'https://windows.microsoft.com/it-it/internet-explorer/download-ie'),
    (Nome: 'Edge';              Hint: 'Microsoft Edge';    Link: 'https://www.microsoft.com/it-it/windows/microsoft-edge')
  );
begin
  TmpBrowser:=GetBrowser;
  NomeBrowser:=Format('%s %d',[TmpBrowser.BrowserName,TmpBrowser.MajorVersion]);

  // info sui browser supportati
  for i:=0 to High(BROWSER_ARR) do
  begin
    Nome:=BROWSER_ARR[i].Nome;
    Hint:=BROWSER_ARR[i].Hint;
    Link:=BROWSER_ARR[i].Link;
    LinkDownload:=LinkDownload + Format(LINK_CODE,[Link,Hint,Nome]) + '<br/>';
  end;

  SupportoOk:=Format(A000TraduzioneStringhe(A000MSG_MSG_FMT_BROWSER_SUPPORTATO),[NomeBrowser]);
  SupportoErr:=Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_BROWSER_NON_SUPPORTATO),[NomeBrowser,{$IFDEF WEBPJ}'IrisCloud'{$ELSE}'IrisWeb'{$ENDIF},LinkDownload]);

  if TmpBrowser = nil then
  begin
    // errore nel riconoscimento del browser dallo user-agent
    Result.TipoCompatibile:=False;
    Result.VersioneCompatibile:=False;
    Result.Info:='Il browser in uso è sconosciuto';
  end
  else
  begin
    // browser supportati ufficialmente:
    // - FireFox
    // - Chrome
    // - Opera
    // - Safari
    // - IE8 e superiori
    // - Edge (riconosciuto a partire da IW 14)
    // per i browser mobile non è garantito il supporto al 100%, ma non
    // segnaliamo che si tratta di un browser obsoleto.

    if TmpBrowser is TFirefox then
    begin
      // Firefox: ok da versione 3.6+
      Result.TipoCompatibile:=True;
      Result.VersioneCompatibile:=TmpBrowser.MajorVersion > 3;
    end
    else if TmpBrowser is TFirefoxMobile then
    begin
      // Firefox Mobile: ok
      Result.TipoCompatibile:=True;
      Result.VersioneCompatibile:=True;
    end
    else if TmpBrowser is TChrome then
    begin
      // Chrome: ok
      Result.TipoCompatibile:=True;
      Result.VersioneCompatibile:=True;
    end
    else if TmpBrowser is TChromeMobile then
    begin
      // Chrome Mobile: ok
      Result.TipoCompatibile:=True;
      Result.VersioneCompatibile:=True;
    end
    else if TmpBrowser is TOpera then
    begin
      // Opera: ok
      Result.TipoCompatibile:=True;
      Result.VersioneCompatibile:=True;
    end
    else if TmpBrowser is TSafari then
    begin
      // Safari: ok
      Result.TipoCompatibile:=True;
      Result.VersioneCompatibile:=True;
    end
    else if TmpBrowser is TSafariMobile then
    begin
      // Safari Mobile: ok
      Result.TipoCompatibile:=True;
      Result.VersioneCompatibile:=True;
    end
    else if TmpBrowser is TInternetExplorer then
    begin
      // IE: da versione 8+ o da versione 7+ se abilitato INI_PAR_TOLLERA_IE7
      Result.TipoCompatibile:=True;
      Result.VersioneCompatibile:=TmpBrowser.MajorVersion >= 8;
      if not Result.VersioneCompatibile then
        Result.VersioneCompatibile:=(TmpBrowser.MajorVersion = 7) and (Pos(INI_PAR_TOLLERA_IE7,W000ParConfig.ParametriAvanzati) > 0);
    end
    else if TmpBrowser is TMSEdge then  { DONE : TEST IW 14 OK }
    begin
      // Microsoft Edge: ok
      Result.TipoCompatibile:=True;
      Result.VersioneCompatibile:=True;
    end
    else
    begin
      // altri browser non sono ufficialmente supportati
      Result.TipoCompatibile:=False;
      Result.VersioneCompatibile:=False;
    end;

    // informazioni descrittive sulla compatibilità
    if (Result.TipoCompatibile and Result.VersioneCompatibile) then
    begin
      // browser e versione supportati
      Result.Info:=SupportoOk;
    end
    else
    begin
      // browser non supportato
      Result.Info:=SupportoErr;
    end;
  end;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#0.fine

function TWR010FBase.GetFunzioneDisponibileByTag(const PTag: Integer): TFunzioniDisponibili;
var
  i: Integer;
  Found: Boolean;
begin
  Found:=False;
  for i:=Low(FunzioniDisponibili) to High(FunzioniDisponibili) do
    if (FunzioniDisponibili[i].T = PTag) and
       ((FunzioniDisponibili[i].M = 'IRIS_WEB') or L021VerificaApplicazione(Parametri.Applicazione,i))
    then
    begin
      //if FunzioniDisponibili[i].T = PTag then
      begin
        Result:=FunzioniDisponibili[i];
        Found:=True;
        Break;
      end;
    end;

  if not Found then
  begin
    Result.A:='';   //Nome dell'applicazione
    Result.S:='';   //Nome della scheda
    Result.N:='';   //Nome della funzione a Menu
    Result.G:='';   //Gruppo di menu
    Result.T:=0;    //Tag del TMenuItem e eventualmente dello SpeedButton
    Result.F:='';   //Nome della funzione/procedura da richiamare
    Result.M:='';   //Nome del modulo opzionale criptato su I080 (qua è sempre IrisWEB)
    Result.MIW:=''; //Nome del modulo opzionale criptato su I080 al'interno di IrisWEB
  end;
end;

function TWR010FBase.GetContextMenu(PControl: TControl): TPopupMenu;
var
  PropInfo: PPropInfo;
begin
  // utilizza RTTI per estrarre la property
  PropInfo:=GetPropInfo(PControl.ClassInfo,'medpContextMenu');
  if Assigned(PropInfo) then
    Result:=TPopupMenu(GetOrdProp(PControl,PropInfo))
  else
    Result:=nil;
end;

procedure TWR010FBase.AbilitaFunzioni;
// l'abilitazione dei componenti avviene modificando la visibilità degli
// elementi per l'accesso alle funzioni, in questo modo:
// - form
//   componenti con Tag > 0 di tipo [TmeIWImageFile]
// - WMenuFM
//   componenti con tag > 0 di tipo [TmeIWImageFile,TAction]
var
  i:Integer;
  Vis: Boolean;
  CompF: TComponent;
  function IsCompAbilitato(PComp: TComponent): Boolean;
  {$IFNDEF WEBPJ}
  var
    ModuloAbil,ModuloNuovo: Boolean;
    Modulo,DescFunz: String;
  {$ENDIF}
  begin
    Result:=A000GetInibizioni('Tag',IntToStr(PComp.Tag)) <> 'N';
    if Result and
       (WR000DM.PaginaSingola <> '') and
       (PComp.Tag >= 0) and
       (L021SiglaByTag(PComp.Tag).ToUpper <> WR000DM.PaginaSingola.ToUpper) then
      Result:=False;

    {$IFDEF WEBPJ}
    //Per IrisCloud: Lettura funzioni abilitate su I081
    if Result and (PComp.Tag >=0) and (not Parametri.ModuloInstallato['IRIS_CLOUD_FULL']) then
    try
      WR000DM.selI081.Open;
      Result:=WR000DM.selI081.SearchRecord('TAG',PComp.Tag,[srFromBeginning]);
    except
      Result:=False;
    end;

    // in alcuni casi particolari l'abilitazione della funzione viene *COMPLETAMENTE* bypassata
    case PComp.Tag of
      158: // cambio azienda: abilitato se l'utente è presente in più aziende con flag di ricerca attivato
        begin
          Result:=WR000DM.IsCambioAziendaAbilitato;
        end;
    end;
    {$ELSE}
    // per irisweb
    // abilitazione modulo
    if GetFunzioneDisponibileByTag(PComp.Tag).MIW <> '' then
    begin
      ModuloAbil:=False;
      for Modulo in GetFunzioneDisponibileByTag(PComp.Tag).MIW.Split([',']) do
      begin
        ModuloNuovo:=WR000DM.ModuliAccessori.GetIndex(Parametri.Azienda,Modulo) = -1;
        ModuloAbil:=ModuloAbil or WR000DM.ModuliAccessori.IsAbilitato(Parametri.Azienda,Modulo);
        if ModuloNuovo then
          Log('Traccia',Format('Azienda %s: modulo %s %s',[Parametri.Azienda,Modulo,IfThen(ModuloAbil,'abilitato','non abilitato')]));
      end;
      Result:=Result and ModuloAbil;
    end;

    // inibisce iter autorizzativi per responsabile se lo user è un operatore iriswin
    if (WR000DM <> nil) and
       (WR000DM.TipoUtente = 'Supervisore') then
    begin
      if PComp is TAction then
        DescFunz:=(PComp as TAction).Caption
      else if PComp is TmeIWImageFile then
        DescFunz:=(PComp as TmeIWImageFile).AltText;
      // se il nome della funzione inizia per "Autorizzazione..."
      // o se è "Validazione cartellino"
      // si assume che la relativa form sia legata all'iter autorizzativo
      if (Pos('Autorizzazione',DescFunz) = 1) or
         (DescFunz = 'Validazione cartellino') then
        Result:=False;
    end;

    {$IFNDEF X001}{$IFNDEF INTRAWEBSVC}
    // in alcuni casi particolari l'abilitazione della funzione viene *COMPLETAMENTE* bypassata
    case PComp.Tag of
      421: // cambio profilo: abilitato se l'utente ha più profili
        begin
          Result:=False;
          if (WR000DM <> nil) and (WR000DM.TipoUtente <> 'Supervisore') then
          begin
            R180SetVariable(WR000DM.selI061,'AZIENDA',Parametri.Azienda);
            R180SetVariable(WR000DM.selI061,'NOME_UTENTE',Parametri.Operatore);
            WR000DM.selI061.Open;
            Result:=WR000DM.selI061.RecordCount > 1;
          end;
        end;
      453: // cambio azienda: abilitato se l'utente è presente in più aziende con flag di ricerca attivato
        begin
          Result:=WR000DM.IsCambioAziendaAbilitato;
        end;
    end;
    {$ENDIF INTRAWEBSVC}{$ENDIF X001}
    {$ENDIF WEBPJ}
  end;
const
  FUNZIONE = 'WR010.AbilitaFunzioni';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  try
    try
      // se sono presenti controlli basati su IP, verifica se la maschera stessa è abilitata
      // potrebbe infatti essere
      if EsisteControlloI076(Self) then
        ImpostaAbilitazioneI076(Self);

      // abilitazione componenti form (solo immagini)
      for i:=0 to ComponentCount - 1 do
      begin
        CompF:=Components[i];
        if (CompF.Tag > 0) and
           (CompF is TmeIWImageFile) then
        begin
          Vis:=IsCompAbilitato(CompF);

          // imposta visibilità elemento
          (CompF as TmeIWImageFile).Visible:=Vis;

          // se il componente è visibile (abilitato all'accesso)
          // verifica se per esso è attivo il controllo basato sull'ip
          // nel caso lo esegue e determina la proprietà Enabled del componente
          // nel caso verrà eventualmente riabilitato in ImpostaAbilitazioniI076 in async
          if (Vis) and
             (EsisteControlloI076(CompF)) then
          begin
            ImpostaAbilitazioneI076(CompF);
          end;
        end;
      end;

      // abilitazione componenti menu (action e immagini)
      if WMenuFM <> nil then
      begin
        for i:=0 to WMenuFM.ComponentCount - 1 do
        begin
          CompF:=WMenuFM.Components[i];
          if (CompF.Tag > 0) and
             ((CompF is TAction) or (CompF is TmeIWImageFile)) then
          begin
            Vis:=IsCompAbilitato(CompF);
            if (Vis) and (Parametri.Applicazione = 'PAGHE') then
              case CompF.Tag of
                619: //Controllo tetto accessorie
                  Vis:=(Pos('AOSTA',UpperCase(Parametri.RagioneSociale)) > 0) or (Pos('TORINO',UpperCase(Parametri.RagioneSociale)) > 0);
                620: //Regole sostituzioni convenzionati
                  Vis:=(Pos('AOSTA',UpperCase(Parametri.RagioneSociale)) > 0) or (Pos('CN1',UpperCase(Parametri.RagioneSociale)) > 0) or (Pos('TORINO',UpperCase(Parametri.RagioneSociale)) > 0);
                621: //Sostituzioni convenzionati
                  Vis:=(Pos('AOSTA',UpperCase(Parametri.RagioneSociale)) > 0) or (Pos('CN1',UpperCase(Parametri.RagioneSociale)) > 0) or (Pos('TORINO',UpperCase(Parametri.RagioneSociale)) > 0);
              end;

            // imposta abilitazione elemento (per webproject) / visibilità elemento (per irisweb)
            //Caratto 24/03/2014 Utente: MONDOEDP chiamata:82153 menu non abilitati resi invisibili

            //Gallizio 06/02/2018: la property Visible su TmeIWImageFile serve solo su IrisWeb
            //perchè non viene considerata da IW se il componente è all'interno di una grid
            //(come succede sul menù di scelta rapida sugli applicativi IrisCloud)
            //Per IrisCloud il menù viene creato successivamente con le sole icone abilitate.
            //(vedi evento IWFrameRegionRender di TWR207FMenuWebPJFM)
            if CompF is TAction then
              (CompF as TAction).Visible:=Vis
            else if CompF is TmeIWImageFile then
              (CompF as TmeIWImageFile).Visible:=Vis; //Caratto 21/03/2014 Utente: CUNEO_CSAC Chiamata: 82339

            // se il componente è visibile (abilitato all'accesso)
            // verifica se per esso è attivo il controllo basato sull'ip
            // nel caso lo esegue e determina la proprietà Enabled del componente
            // nel caso verrà eventualmente riabilitato in ImpostaAbilitazioniI076 in async
            if (Vis) and
               (EsisteControlloI076(CompF)) then
            begin
              ImpostaAbilitazioneI076(CompF);
            end;
          end;
        end;
      end;
    except
      on E: Exception do
        Log('Errore',FUNZIONE,E);
    end;
  finally
    Log('Traccia',Format('%s - fine',[FUNZIONE]));
  end;
end;

function TWR010FBase.EsisteControlloI076(PComp: TComponent): Boolean;
begin
  Result:=False;

  if Parametri.CampiRiferimento.C90_W038CheckIP <> 'S' then
    Exit;

  if WR000DM = nil then
    Exit;

  if not WR000DM.selI076.Active then
    Exit;

  // se esiste un record per il tag indicato, allora è necessario effettuare i controlli sull'IP
  Result:=WR000DM.selI076.SearchRecord('TAG',PComp.Tag,[srFromBeginning]);
end;

procedure TWR010FBase.ImpostaAbilitazioneI076(PComp: TComponent);
var
  LTag: Integer;
  LIsIPOk: Boolean;
  LEsisteRegolaLocale: Boolean;
  LNotEnabledReason, LIPErrMsg: String;
  function MatchIPv4(const IPRegola,IPSelf: String): Boolean;
  var
    LIPRegolaArr, LIPCorrenteArr: TArray<String>;
    i: Integer;
  const
    CARATTERE_JOLLY = '*';
    IP_GRUPPI = 4;
  begin
    Result:=False;

    // confronto diretto
    if IPRegola = IPSelf(*Parametri.ClientIPInfo.IP*) then
    begin
      Result:=True;
      Exit;
    end;

    // confonto con maschera che utilizza il carattere jolly *
    if IPRegola.Contains(CARATTERE_JOLLY) then
    begin
      if IPSelf(*Parametri.ClientIPInfo.IP*) <> PUBLIC_IP_UNKNOWN then
      begin
        // split degli ipv4 in 4 stringhe
        LIPRegolaArr:=IPRegola.Split([IPV4_SEPARATOR]);
        LIPCorrenteArr:=(*Parametri.ClientIPInfo.IP*)IPSelf.Split([IPV4_SEPARATOR]);
        if (Length(LIPRegolaArr) = IP_GRUPPI) and
           (Length(LIPCorrenteArr) = IP_GRUPPI) then
        begin
          Result:=True;
          for i:=0 to IP_GRUPPI - 1 do
          begin
            if (LIPRegolaArr[i] <> CARATTERE_JOLLY) and
               (LIPRegolaArr[i] <> LIPCorrenteArr[i]) then
            begin
              Result:=False;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
begin
  // determina il tag del componente per il controllo ip
  // il componente può essere:
  // - TWR010FBase
  // - TAction
  // - TmeIWImageFile
  if PComp is TWR010FBase then
    LTag:=(PComp as TWR010FBase).Tag
  else if PComp is TAction then
    LTag:=(PComp as TAction).Tag
  else if PComp is TmeIWImageFile then
    LTag:=(PComp as TmeIWImageFile).Tag
  else
    Exit;

  //regole IP locale + IP pubblico:
  //se esiste regola per IP locale e questa non consente l'accesso,
  //non si guarda neanche la regola dell'IP pubblico

  //se non esiste regola IP locale, oppure accesso consentito, si guarda anche la regola dell'IP pubblico
  //se non esiste nessuna regola dell'IP pubblico rimane il permesso precedente, a seconda che esistesse o no la regola locale
  //se esiste la regola dell'IP pubblico si considera quest'ultima.

  LEsisteRegolaLocale:=False;
  LIsIPOk:=False;
  LIPErrMsg:='';

  if (WR000DM <> nil) and
     (WR000DM.selI076.Active) then
  begin
    try
      // determina se l'ip Locale è abilitato alla funzione legata al componente
      // se non ci sono regole per l'ip, l'accesso è negato
      WR000DM.selI076.Filtered:=False;
      WR000DM.selI076.Filter:=Format('(TAG = %d) and (IP_ESTERNO = ''N'')',[LTag]);
      WR000DM.selI076.Filtered:=True;
      WR000DM.selI076.First;
      while not WR000DM.selI076.Eof do
      begin
        if MatchIPv4(WR000DM.selI076.FieldByName('IP').AsString,Parametri.ClientIPInfo.IPLocale) then
        begin
          LEsisteRegolaLocale:=True;
          LIsIPOk:=WR000DM.selI076.FieldByName('CONSENTITO').AsString = 'S';
          // testo esplicativo se l'ip non è consentito
          if not LIsIPOk then
            LIPErrMsg:=Format('accesso non consentito per IP %s',[WR000DM.selI076.FieldByName('IP').AsString]);
          Break;
        end;
        WR000DM.selI076.Next;
      end;

      // determina se l'ip Pubblico è abilitato alla funzione legata al componente
      // se non ci sono regole per l'ip, l'accesso rimane definito dalle regole locali
      // se l'ip non è ancora determinato, l'accesso è negato
      if (not LEsisteRegolaLocale) or (LIsIPOk) then
      begin
        WR000DM.selI076.Filtered:=False;
        WR000DM.selI076.Filter:=Format('(TAG = %d) and (IP_ESTERNO = ''S'')',[LTag]);
        WR000DM.selI076.Filtered:=True;
        if WR000DM.selI076.RecordCount > 0 then
        begin
          LIsIPOk:=False;
          LIPErrMsg:='';
        end;
        if Parametri.ClientIPInfo.Status <> isUndefined then
        begin
          WR000DM.selI076.First;
          while not WR000DM.selI076.Eof do
          begin
            if MatchIPv4(WR000DM.selI076.FieldByName('IP').AsString,Parametri.ClientIPInfo.IP) then
            begin
              LIsIPOk:=WR000DM.selI076.FieldByName('CONSENTITO').AsString = 'S';
              // testo esplicativo se l'ip non è consentito
              if not LIsIPOk then
                LIPErrMsg:=Format('accesso non consentito per IP %s',[WR000DM.selI076.FieldByName('IP').AsString]);
              Break;
            end;
            WR000DM.selI076.Next;
          end;
        end;
      end;

    finally
      WR000DM.selI076.Filtered:=False;
    end;
  end;

  // se l'ip è bannato, compone un testo esplicativo da visualizzare
  if (not LIsIPOk) and
     ((Parametri.ClientIPInfo.Status <> isUndefined) or LEsisteRegolaLocale) then
  begin
    if LIPErrMsg = '' then
      LIPErrMsg:='non è prevista una regola di accesso per l''IP indicato';
    LNotEnabledReason:=Format('L''accesso effettuato da questo dispositivo non è consentito '#13#10 +
                              'L''utilizzo di questa funzione è subordinato all''indirizzo IP '#13#10 +
                              'dal quale viene effettuato l''accesso.'#13#10 +
                              IfThen(Parametri.ClientIPInfo.Status = isOk,
                                Format('Il suo IP è il seguente: %s',[Parametri.ClientIPInfo.IP]),
                                'Il suo IP non è stato determinato a causa di un errore'
                              ) + #13#10 +
                              'Dettagli tecnici: %s',
                              [LIPErrMsg]);
  end;

  // imposta la proprietà enabled
  if PComp is TWR010FBase then
  begin
    // form stessa (non usa la property Enabled, perché dà problemi di AV...)
    // (se disabilitata viene nascosto il div "T000Contenuto"
    //  cfr. TWR010FBase.TemplateProcessorUnknownTag)
    TWR010FBase(PComp).medpI076Info.Enabled:=LIsIPOk;
    TWR010FBase(PComp).medpI076Info.Message:=IfThen(LIsIPOk,'',LNotEnabledReason);
  end
  else if PComp is TAction then
  begin
    // azione (menu)
    TAction(PComp).Enabled:=LIsIPOk;
  end
  else if PComp is TmeIWImageFile then
  begin
    // icona di accesso rapido
    TmeIWImageFile(PComp).Enabled:=LIsIPOk;
    TmeIWImageFile(PComp).Css:='icona_sez3 ' + IfThen(not LIsIPOk,'disab');
  end;
end;

procedure TWR010FBase.ImpostaAbilitazioniI076;
// l'abilitazione dei componenti in base all'IP (I076) avviene modificando
// la proprietà Enabled degli elementi per l'accesso alle funzioni, in questo modo:
// - form
//   componenti con Tag > 0 di tipo [TmeIWImageFile]
// - WMenuFM
//   componenti con tag > 0 di tipo [TmeIWImageFile,TAction]
var
  i:Integer;
  CompF: TComponent;
const
  FUNZIONE = 'WR010.ImpostaAbilitazioniI076';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  try
    // controlli iniziali per verifica abilitazioni basate su IP
    if WR000DM = nil then
      Exit;

    if not WR000DM.selI076.Active then
      Exit;

    // verifica parametro aziendale per attivazione abilitazioni basate su IP
    if Parametri.CampiRiferimento.C90_W038CheckIP <> 'S' then
      Exit;

    // effettua gestione abilitazioni
    try
      // se sono presenti controlli basati su IP, verifica se la maschera stessa è abilitata
      // potrebbe infatti essere
      if EsisteControlloI076(Self) then
        ImpostaAbilitazioneI076(Self);

      // abilitazione componenti form (solo immagini)
      for i:=0 to Self.ComponentCount - 1 do
      begin
        CompF:=Self.Components[i];
        if (CompF.Tag > 0) and
           (CompF is TmeIWImageFile) then
        begin
          if EsisteControlloI076(CompF) then
          begin
            ImpostaAbilitazioneI076(CompF);
          end;
        end;
      end;

      // abilitazione componenti menu (action e immagini)
      if WMenuFM <> nil then
      begin
        for i:=0 to WMenuFM.ComponentCount - 1 do
        begin
          CompF:=WMenuFM.Components[i];
          if (CompF.Tag > 0) and
             ((CompF is TAction) or (CompF is TmeIWImageFile)) then
          begin
            if EsisteControlloI076(CompF) then
            begin
              ImpostaAbilitazioneI076(CompF);
            end;
          end;
        end;
      end;
    except
      on E: Exception do
        Log('Errore',FUNZIONE,E);
    end;
  finally
    Log('Traccia',Format('%s - fine',[FUNZIONE]));
  end;
end;

function TWR010FBase.IsClassOK(PComp: TComponent): Boolean;
// verifica utilizzo componenti ridefiniti (TmeXXX)
begin
  Result:=not R180In(PComp.ClassName,
                     ['TIWButton',
                      'TIWCheckBox',
                      'TIWComboBox',
                      'TIWDBCheckBox',
                      'TIWDBComboBox',
                      'TIWDBEdit',
                      'TIWDBGrid',
                      'TIWDBImage',
                      'TIWDBLabel',
                      'TIWEdit',
                      'TIWGrid',
                      'TIWImage',
                      'TIWImageFile',
                      'TIWLabel',
                      'TIWLink']);
end;

procedure TWR010FBase.ElaboraComp(PComp: TComponent);
var
  NomeComp,TooltipStr,WatermarkStr,CssStr,
  MCaption,MCss,Code,S: String;
  Ctrl: TIWCustomControl;
  TmpMenu: TPopupMenu;
  MItem: TMenuItem;
  i: Integer;
  ElementiTuttiNascosti: Boolean;
begin
  if PComp is TIWCustomControl then
  begin
    Ctrl:=(PComp as TIWCustomControl);
    NomeComp:=Ctrl.Name;
    if (Ctrl.Owner <> nil) and
       (Ctrl.Owner is TFrame) then
      NomeComp:=Format('%s.%s',[Ctrl.Owner.Name,NomeComp]);
    // gestione menu contestuale
    if jqContextMenu.Enabled then
    begin
      TmpMenu:=GetContextMenu(Ctrl);
      if Assigned(TmpMenu) then
      begin
        Code:=Format(W000JQ_ContextMenu,[Ctrl.HTMLName,TmpMenu.Name,FJSCallbackName]);
        jqContextMenu.OnReady.Add(Code);
      end;
    end;

    // controllo css
    CssStr:=Trim(TIWCustomControl(PComp).Css);
    if (CssStr <> '') and
       (LeftStr(CssStr,1) = UpperCase(LeftStr(CssStr,1))) then
      DebugAdd('W','La proprietà <b>Css</b> è potenzialmente errata (<b>' + CssStr + '</b>): lo standard impone l''iniziale minuscola',NomeComp);

    // hint in formato html
    if (jqTooltip.Enabled) and
       (Ctrl.Hint <> '') and
       (Ctrl.ShowHint) then
    begin
      TooltipStr:=Ctrl.Hint;
      if Copy(TooltipStr,1,6) = '<html>' then
      begin
        TooltipStr:=C190ConvertiSimboliHtml(Copy(TooltipStr,7,MAXINT));
        Ctrl.Hint:=TooltipStr;
        Ctrl.Css:=Ctrl.Css + ' tooltipHtml';
      end;
    end;

    // testo tipo "watermark" (testo esplicativo del campo in colore grigio)
    if (jqWatermark.Enabled) and
       (Ctrl is TmeIWEdit) then
    begin
      WatermarkStr:=Trim(TmeIWEdit(Ctrl).medpWatermark);
      if WatermarkStr <> '' then
      begin
        Code:=Format(W000JQ_Watermark,[Ctrl.HTMLName,C190EscapeJS(WatermarkStr)]);
        jqWatermark.OnReady.Add(Code);
      end;
    end;

    // impostazioni legate alle tipologie di control
    if (Ctrl is TIWCustomLabel) and
       ((Ctrl as TIWCustomLabel).Hint = '') and
       ((Ctrl as TIWCustomLabel).ForControl <> nil) and
       ((Ctrl as TIWCustomLabel).ForControl is TIWCustomEdit) then
    begin
      // impostazione hint automatico su label per edit con formato data / ora
      // se non specificato
      S:=((Ctrl as TIWCustomLabel).ForControl as TIWCustomEdit).Css;
      if Pos('input_data_dmy',S) > 0 then
        (Ctrl as TIWCustomLabel).Hint:='Formato gg mm aaaa'
      else if Pos('input_data_my',S) > 0 then
        (Ctrl as TIWCustomLabel).Hint:='Formato mm aaaa'
      else if Pos('input_hour_hhmm',S) > 0 then
        (Ctrl as TIWCustomLabel).Hint:='Formato hh mm';
    end
    else if Ctrl is TIWCustomEdit then
    begin
      if (Pos('input_',(Ctrl as TIWCustomEdit).Css) > 0) then
      begin
        jqCalendario.Enabled:=True;
        jqMask.Enabled:=True;
      end;
    end
    else if Ctrl is TIWCustomComboBox then
    begin
      jQAutocomplete.Enabled:=True;
    end
    else if Ctrl is TIWGrid then
    begin
      if (Ctrl as TIWGrid).Css.Substring(1,4) = 'grid' then
      begin
        // funzionamento: proprietà Border nulla se Css = 'grid%'
        if (Ctrl as TIWGrid).BorderStyle <> tfVoid then
          DebugAdd('E','Impostare la proprietà <b>BorderStyle</b> = tfVoid',NomeComp);

        if (Ctrl as TIWGrid).BorderSize <> 0 then
          DebugAdd('E','Impostare la proprietà <b>BorderSize</b> = 0',NomeComp);

        // funzionamento: UseFrame e UseSize a False
        if not (Ctrl as TIWGrid).UseFrame then
          DebugAdd('E','Impostare la proprietà <b>UseFrame</b> = True',NomeComp);

        if not (Ctrl as TIWGrid).UseSize then
          DebugAdd('E','Impostare la proprietà <b>UseSize</b> = True',NomeComp);
      end;
    end
    else if Ctrl is TIWDBGrid then
    begin
      // verifica dbgrid

      // funzionamento: proprietà specifiche delle celle da non utilizzare
      if (Ctrl as TIWDBGrid).CellPadding <> 0 then
        DebugAdd('E','Impostare la proprietà <b>CellPadding</b> = 0',NomeComp);
      if (Ctrl as TIWDBGrid).CellSpacing <> 0 then
        DebugAdd('E','Impostare la proprietà <b>CellSpacing</b> = 0',NomeComp);
      if (Ctrl as TIWDBGrid).CellRenderOptions <> [] then
        DebugAdd('E','Impostare le proprietà <b>CellRenderOptions</b> tutte a False',NomeComp);

      // accessibilità: summary
      if (Ctrl as TIWDBGrid).ExtraTagParams.Text = '' then
      begin
        if (Ctrl as TIWDBGrid).Summary = '' then
          DebugAdd('A','Impostare la proprietà <b>Summary</b>, valorizzandola con una breve descrizione del contenuto della tabella',NomeComp)
        else
        begin
          // attenzione:
          //   in questo modo il summary non viene impostato come attributo di <table>
          //   ma sul tag <div> che la circonda!
          //   non è ugualmente corretto, quindi se qualcuno trova una soluzione
          //   a questo problema sarà riempito di gloria
          //   (si potrebbe fare via javascript, ma ci sono già talmente tanti workaround che mi vergogno)
          (Ctrl as TIWDBGrid).ExtraTagParams.Text:=Format('summary=%s',[(Ctrl as TIWDBGrid).Summary]);
        end;
      end;
      // non è W3C-compliant ciò che esce impostando questa property!
      (Ctrl as TIWDBGrid).Summary:='';

      if (Ctrl as TIWDBGrid).Css.Substring(1,4) = 'grid' then
      begin
        // funzionamento: proprietà Border nulla se Css = 'grid%'
        if (Ctrl as TIWDBGrid).BorderStyle <> tfVoid then
          DebugAdd('E','Impostare la proprietà <b>BorderStyle</b> = tfVoid',NomeComp);

        if (Ctrl as TIWDBGrid).BorderSize <> 0 then
          DebugAdd('E','Impostare la proprietà <b>BorderSize</b> = 0',NomeComp);

        // funzionamento: UseFrame e UseSize a False
        if not (Ctrl as TIWDBGrid).UseFrame then
          DebugAdd('E','Impostare la proprietà <b>UseFrame</b> = True',NomeComp);

        if not (Ctrl as TIWDBGrid).UseSize then
          DebugAdd('E','Impostare la proprietà <b>UseSize</b> = True',NomeComp);
      end;

      // controlli per medpIWDBGrid
      if Ctrl is TmedpIWDBGrid then
      begin
        // funzionamento: property FromStart a True
        if not (Ctrl as TmedpIWDBGrid).FromStart then
          DebugAdd('E','Impostare la proprietà <b>FromStart</b> = True',NomeComp);

        // accessibilità: caption
        //if (Ctrl as TmedpIWDBGrid).Caption = '' then
        //  DebugAdd('A','Impostare la proprietà <b>Caption</b>',NomeComp);
      end;
    end
    else if Ctrl is TmeIWFileUploader then
      (Ctrl as TmeIWFileUploader).ImpostaDefaultMaxFileSize(50 * BYTES_MB, True);

    // convenzione: utilizzo componenti "Medp IW"
    if not IsClassOk(Ctrl) then
      DebugAdd('E','Il componente non può ereditare dalla classe ' + Ctrl.ClassName + '. Utilizzare UNICAMENTE i componenti visuali del package "Medp IW"',NomeComp);
  end
  else if PComp is TPopupMenu then
  begin
    // popup menu
    NomeComp:=PComp.Name;
    Code:='';
    TmpMenu:=(PComp as TPopupMenu);
    ElementiTuttiNascosti:=True;
    // ciclo sugli elementi del popup menu per comporre l'html corrispondente
    for i:=0 to TmpMenu.Items.Count - 1 do
    begin
      MItem:=TmpMenu.Items[i];
      // se il menu item è visibile ne predispone il codice html relativo
      if MItem.Caption = '-' then
      begin
        // separatore (nessuna azione collegata)
        MCaption:='';
        MCss:='separator';
      end
      else
      begin
        // voce di menu
        MCaption:=Format('<a href="#%s">%s</a>',[MItem.Name,MItem.Caption]);
        MCss:=MItem.Hint; //??? in assenza di altre property utilizzo hint come css!
      end;
      // gestione checked / unchecked
      if MItem.Checked then
        MCss:=MCss + ' checked';
      // gestione enabled / disabled
      if not MItem.Enabled then
        MCss:=MCss + ' font_disabilitato';
      // gestione visible / invisible
      if MItem.Visible then
      begin
        ElementiTuttiNascosti:=False;
      end
      else
      begin
        MCss:=MCss + ' invisibile';
      end;

      // prepara elemento li con id = nome del menu item
      Code:=Format('%s%s<li id="%s" class="%s">%s</li>',[Code,CRLF,MItem.Name,MCss,MCaption]);
    end;
    // predispone il codice del popup menu se almeno un elemento risulta visibile
    if not ElementiTuttiNascosti then
    begin
      Code:=Format('<ul id="%s" class="%s">%s%s%s</ul>',
                   [NomeComp,'contextMenu',CRLF,Code,CRLF]);
    end;
    TagPopupMenuHtml:=TagPopupMenuHtml + Code;
  end;
end;

function TWR010FBase.FindFrame(const PName: String; const PCaseSensitive: Boolean = False): TFrame;
// restituisce il puntatore al frame indicato da PName e contenuto nella form
// oppure nil se inesistente
// PCaseSensitive indica se la ricerca per nome deve avvenire con il case sensitive
var
  i: Integer;
  NomeSrc,NomeFrame: String;
begin
  Result:=nil;
  NomeSrc:=PName;
  if not PCaseSensitive then
    NomeSrc:=UpperCase(NomeSrc);

  //Ricerca in Components (owner = PName)
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TFrame then
    begin
      NomeFrame:=Components[i].Name;
      if not PCaseSensitive then
        NomeFrame:=UpperCase(NomeFrame);

      if NomeSrc = NomeFrame then
      begin
        Result:=(Components[i] as TFrame);
        Break;
      end;
    end;
  end;

  if Result <> nil  then
    exit;

  //Ricerca in Controls (parent = PName)
  for i:=0 to ControlCount - 1 do
  begin
    if Controls[i] is TFrame then
    begin
      NomeFrame:=Controls[i].Name;
      if not PCaseSensitive then
        NomeFrame:=UpperCase(NomeFrame);

      if NomeSrc = NomeFrame then
      begin
        Result:=(Controls[i] as TFrame);
        Break;
      end;
    end;
  end;

end;

procedure TWR010FBase.CicloComponenti;
// effettua un loop su tutti i componenti della form
// per effettuare impostazioni specifiche
var
  i,j,x:Integer;
  TmpComp: TComponent;
  TmpFrame: TFrame;
  TmpRegion: TIWRegion;
  T1: TDateTime;
  procedure GestisciJqWidget(PWidget: TIWJQueryWidget);
  var
    i, j: Integer;
  begin
    // i widget con tag < 0 sono quelli definiti a livello di WR010
    if (PWidget = nil) or (PWidget.Tag < 0) then
      Exit;

    for i:=0 to PWidget.OnReady.Count - 1 do
    begin
      if Pos('//SPOSTA//$',UpperCase(PWidget.OnReady[i])) > 0 then
      begin
        for j:=lstFrameOpen.Count - 1 to PWidget.Tag do
          lstFrameOpen.Add('');
        lstFrameOpen[PWidget.Tag]:=StringReplace(PWidget.OnReady[i],'//SPOSTA//$','$',[rfIgnoreCase,rfReplaceAll]);
        PWidget.Enabled:=False;
        jqFrame.OnReady.AddStrings(PWidget.OnReady);
        Break;
      end;
    end;
  end;
  procedure GestisciTFrame(FFrame: TFrame;ChiamaElaboraComp:Boolean);
  var
    k,x,y{,z}:Integer;
    TmpCompF: TComponent;
  begin
    // gestione array di frame
    x:=Length(FrameArr);
    SetLength(FrameArr,x + 1);
    FrameArr[x]:=FFrame;

    for k:=0 to FFrame.ComponentCount - 1 do
    begin
      TmpCompF:=FFrame.Components[k];
      if TmpCompF is TIWJQueryWidget then
      begin
        //Alberto 21/01/2013: i comandi .dialog(open) devono essere messi in fondo ai jquery di definizione, e in ordine di visibilità (tag)
        GestisciJqWidget(TmpCompF as TIWJQueryWidget);
      end
      else if TmpCompF is TIWRegion then
      begin
        for y:=0 to (TmpCompF as TIWRegion).ControlCOunt - 1 do
        begin
          if (TmpCompF as TIWRegion).Controls[y] is TFrame then
            GestisciTFrame(((TmpCompF as TIWRegion).Controls[y] as TFrame),ChiamaElaboraComp);
        end;
      end
      else if ChiamaElaboraComp then
        ElaboraComp(FFrame.Components[k]);
    end;
  end;
const
  FUNZIONE = 'WR010.CicloComponenti';
begin
  T1:=Now;

  // inizializzazione jquery widget legati ai componenti
  if jqContextMenu.Enabled then
    jqContextMenu.OnReady.Text:='/* jqContextMenu */';

  if jqFixedHeader.Enabled then
    jqFixedHeader.OnReady.Text:='/* jqFixedHeader */';

  if jqWatermark.Enabled then
    jqWatermark.OnReady.Text:='/* jqWatermark */';

  // unknown tag da sostituire
  TagPopupMenuHtml:='';

  // ciclo sui componenti della form
  SetLength(FrameArr,0);
  SetLength(FRegionArr,0);
  for i:=0 to ComponentCount - 1 do
  begin
    TmpComp:=Components[i];
    if TmpComp is TFrame then
    begin
      // frame -> ciclo sui componenti del frame
      TmpFrame:=(TmpComp as TFrame);
      GestisciTFrame(TmpFrame,True);
    end
    else if TmpComp is TIWRegion then
    begin
      // region -> ciclo sui componenti della region
      TmpRegion:=(TmpComp as TIWRegion);
      // gestione array di region
      x:=Length(FRegionArr);
      SetLength(FRegionArr,x + 1);
      FRegionArr[x]:=TmpRegion;
      if not Assigned(TmpRegion.LayoutMgr) then
        DebugAdd('E','Nessun layout manager impostato: verificare!',TmpRegion.Name);
      // NON ESEGUIRE il ciclo su Controls: vengono già considerati nel ciclo principale
      //for j:=0 to TmpRegion.ControlCount - 1 do
      //  ElaboraControl(TmpRegion.Controls[j]);
    end
    else
    begin
      // gestione particolare jquery widget
      if TmpComp is TIWJQueryWidget then
      begin
        GestisciJqWidget(TmpComp as TIWJQueryWidget);
      end;
      ElaboraComp(TmpComp);
    end;
  end;

  //Alberto 17/01/2013: cerco i TFrame anche fra i Controls, nel caso che abbiano il Parent = Self, ma l'Owner diverso
  for i:=0 to ControlCount - 1 do
  begin
    if Controls[i] is TFrame then
    begin
      TmpFrame:=TFrame(Controls[i]);
      //Cerco in FrameArr se esiste il frame e lo elaboro solo se non esiste
      x:=-1;
      for j:=0 to High(FrameArr) do
      begin
        if FrameArr[j] = TmpFrame then
        begin
          x:=j;
          Break;
        end;
      end;
      if x = -1 then
        GestisciTFrame(TmpFrame,True);
    end;
  end;

  // gestione particolare del messagebox
  if MsgBox.IsActive then
    lstFrameOpen.Add(Format('$("%s").dialog("open");',['#msgDialog'])); //Format('setTimeout(function(){$("%s").dialog("open");},1);',['#msgDialog'])

  jqFrame.OnReady.AddStrings(lstFrameOpen);

  LogConsoleTime(FUNZIONE,T1);
end;

procedure TWR010FBase.TraduzioneElementi(Sender: TComponent);
// gestione della traduzione (localizzazione) di alcuni componenti delle pagine web
var
  i,x: Integer;
  NomeComp,NomeField,Traduzione,Proprieta,FilterOriginale: String;
  Elem: TComponent;
  RttiContext:TRttiContext;
  ListaNomiClassi:TStringList;
begin
  if WR000DM = nil then
    Exit;

  // al momento è questo parametro che guida la traduzione in lingua inglese
  //if (Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S') or
  if (Parametri.CampiRiferimento.C90_Lingua = '') or
     (not WR000DM.cdsI015.Active) then
    Exit;

  Log('Traccia','Traduzione componenti interfaccia');

  // filtro del clientdataset sui componenti della maschera attuale + comp. ereditati
  if Sender is TWR010FBase then
    FilterOriginale:=Format('((MASCHERA = ''%s'') or (MASCHERA = ''R010''))',[Copy(Sender.ClassName,2,Length(Sender.ClassName))])
  else
    FilterOriginale:=Format('MASCHERA = ''%s''',[Copy(Sender.ClassName,2,Length(Sender.ClassName))]);

  // Prima di proseguire verifico se sono previste traduzioni per questa pagina
  with WR000DM do
  begin
    cdsI015.Filtered:=False;
    cdsI015.Filter:=FilterOriginale;
    cdsI015.Filtered:=True;
    if (cdsI015.RecordCount = 0) then
      Exit;
  end;

  RttiContext:=TRttiContext.Create; // Informazioni sui tipi
  ListaNomiClassi:=TStringList.Create; // Conterrà le classi dei componenti nel form/frame
  ListaNomiClassi.CaseSensitive:=False;

   try
    // Ricavo i nomi delle classi dei componenti. Mi serve per evitare cicli inutili
    // se il form non contiene alcun oggetto di una classe di cui si richiede la traduzione
    for i:=0 to (Sender.ComponentCount - 1) do
    begin
      if (ListaNomiClassi.IndexOf(Sender.Components[i].ClassName) = -1) then
        ListaNomiClassi.Add(Sender.Components[i].ClassName);
    end;


    // Effettuo due cicli sui componenti: nel primo effettuo la traduzione in base al
    // nome della classe
    with WR000DM do
    begin
      cdsI015.Filtered:=False;
      cdsI015.Filter:=FilterOriginale + ' AND COMPONENTE LIKE ''[%]%''';
      cdsI015.Filtered:=True;
    end;

    // Primo ciclo
    WR000DM.cdsI015.First;
    while not WR000DM.cdsI015.Eof do
    begin
      NomeComp:=UpperCase(WR000DM.cdsI015.FieldByName('COMPONENTE').AsString);
      Traduzione:=WR000DM.cdsI015.FieldByName('CAPTION').AsString;
      Proprieta:=Trim(UpperCase(WR000DM.cdsI015.FieldByName('PROPRIETA').AsString));
      NomeField:='';
      if (Traduzione <> '') and (NomeComp <> '')  then
      begin
        x:=Pos('.',NomeComp);
        if x > 0 then
        begin
          // si tratta del formato [grid].[datafield] oppure [componente].[property]
          NomeField:=Copy(NomeComp,x + 1,Length(NomeComp));
          NomeComp:=Copy(NomeComp,1,x - 1);
        end;
        // Dato che sto indicando una classe, devo rimuovere i delimitatori '[' e ']'
        NomeComp:=Copy(NomeComp,2,(Length(NomeComp) - 2));
        // Ciclo tra i componenti solo se so già che il form contiene un oggetto di questo
        // tipo.
        if (ListaNomiClassi.IndexOf(NomeComp) > 0) then
        begin
          for i:=0 to Sender.ComponentCount - 1 do
          begin
            Elem:=Sender.Components[i];
            if (Uppercase(Elem.ClassName) = NomeComp) then
              TraduciSingoloElemento(Elem,Proprieta,Traduzione,NomeField,RttiContext)
          end;
        end;
      end;
      WR000DM.cdsI015.Next;
    end;

    // Nel secondo ciclo traduco i componenti in base al name. In tal modo
    // questo tipo di traduzione può "scavalcare" quella per nome di classe.
    with WR000DM do
    begin
      cdsI015.Filtered:=False;
      cdsI015.Filter:=FilterOriginale + ' AND NOT (COMPONENTE LIKE ''[%]%'')';
      cdsI015.Filtered:=True;
    end;

    // Secondo ciclo
    WR000DM.cdsI015.First;
    while not WR000DM.cdsI015.Eof do
    begin
      NomeComp:=UpperCase(WR000DM.cdsI015.FieldByName('COMPONENTE').AsString);
      Traduzione:=WR000DM.cdsI015.FieldByName('CAPTION').AsString;
      Proprieta:=Trim(UpperCase(WR000DM.cdsI015.FieldByName('PROPRIETA').AsString));
      NomeField:='';
      if (Traduzione <> '') and (NomeComp <> '')  then
      begin
        if UpperCase(Traduzione) = '<NULL>' then
          Traduzione:='';
        if (NomeComp = 'TITLE') and (Sender is TWR010FBase) then
          Self.Title:=Traduzione
        else
        begin
          x:=Pos('.',NomeComp);
          if x > 0 then
          begin
            // si tratta del formato [grid].[datafield]  oppure [componente].[property]
            NomeField:=Copy(NomeComp,x + 1,Length(NomeComp));
            NomeComp:=Copy(NomeComp,1,x - 1);
          end;
          Elem:=Sender.FindComponent(NomeComp);
          if Elem <> nil then
            TraduciSingoloElemento(Elem,Proprieta,Traduzione,NomeField,RttiContext);
        end;
      end;
      WR000DM.cdsI015.Next;
    end;
  finally
    RttiContext.Free;
    FreeAndNil(ListaNomiClassi);
    WR000DM.cdsI015.Filtered:=False;
    WR000DM.cdsI015.Filter:='';
  end;

  for i:=0 to Sender.ComponentCount - 1 do
    if Sender.Components[i] is TFrame then
      TraduzioneElementi(Sender.Components[i]);
end;

procedure TWR010FBase.TraduciSingoloElemento(Elem: TPersistent(*TComponent*); Proprieta,Traduzione,NomeField: String; RttiContext:TRttiContext);
var
  i:Integer;
  PropInfo: PPropInfo;
  RttiProperty:TRttiProperty;
  RttiValue:TValue;
  OggettoProp:TObject;

  procedure SetCellText(G:TIWGrid;Coord,Testo:String);
  var R,C:Integer;
  begin
    if (Copy(Coord,1,1) = '"') and (Copy(Coord,Length(Coord),1) = '"') then
    begin
      Coord:=Copy(Coord,2,Length(Coord) - 2);
      for R:=0 to G.RowCount - 1 do
        for C:=0 to G.ColumnCount - 1 do
          if UpperCase(G.Cell[R,C].Text) = UpperCase(Coord) then
            G.Cell[R,C].Text:=Testo;
    end
    else
    begin
      R:=-1;
      C:=-1;
      Coord:=StringReplace(Coord,'[','',[rfReplaceAll]);
      Coord:=StringReplace(Coord,']','',[rfReplaceAll]);
      Coord:=StringReplace(Coord,'(','',[rfReplaceAll]);
      Coord:=StringReplace(Coord,')','',[rfReplaceAll]);
      if Pos(',',Coord) > 0 then
      begin
        R:=StrToIntDef(Copy(Coord,1,Pos(',',Coord) - 1),-1);
        C:=StrToIntDef(Copy(Coord,Pos(',',Coord) + 1,Length(Coord)),-1);
      end;
      if (R >= 0) and (C >= 0) and (R < G.RowCount) and (C < G.ColumnCount) then
      begin
        if G.Cell[R,C].Control = nil then
          G.Cell[R,C].Text:=Testo
        else
          Elem:=G.Cell[R,C].Control;
      end;
    end;
  end;
begin
  if Elem is TIWGrid then
  begin
    // grid - senza else per riconoscere eventuali altri elementi dentro la cella indicata
    SetCellText(TIWGrid(Elem),NomeField,Traduzione);
  end
  else if Elem is TIWDBGRID then
  begin
    // ciclo per ricercare eventuale colonna della dbgrid
    for i:=0 to TIWDBGrid(Elem).Columns.Count - 1 do
      if (UpperCase(TIWDBGridColumn(TIWDBGrid(Elem).Columns.Items[i]).DataField) = NomeField) then
      begin
        Elem:=TIWDBGrid(Elem).Columns.Items[i];
        Break;
      end;
  end;

  //Setto proprietà generica
  PropInfo:=GetPropInfo(Elem.ClassInfo, Proprieta);
  if Assigned(PropInfo) then
  begin
    if R180In(Proprieta,['CHECKED','VISIBLE']) then
      SetPropValue(Elem, PropInfo, Traduzione.ToUpper = 'TRUE')
    else
      SetStrProp(Elem, PropInfo, Traduzione);
  end
  else if Elem is TIWDBGrid then
  begin
    TIWDBGrid(Elem).Caption:=Traduzione
  end
  else if Elem is TIWDBGridColumn then
  begin
    TIWDBGridColumn(Elem).Title.Text:=Traduzione;
  end
  else if Elem is TmeIWRadioGroup then
  begin
    // radio group
    TmeIWRadioGroup(Elem).Items.StrictDelimiter:=True;
    TmeIWRadioGroup(Elem).Items.DelimitedText:=Traduzione;
  end
  else if Elem is TmeIWCheckBox then
  begin
    TmeIWCheckBox(Elem).Caption:=Traduzione;
  end
  else if Elem is TmeTIWAdvCheckGroup then
  begin
    // check group
    TmeTIWAdvCheckGroup(Elem).Items.StrictDelimiter:=True;
    TmeTIWAdvCheckGroup(Elem).Items.DelimitedText:=Traduzione;
  end
  else if Elem is TmeIWFileUploader then
  begin
    if NomeField <> '' then
    begin
      // Leggo info sulla property Elem.[NomeField]
      RttiProperty:=RttiContext.GetType(Elem.ClassType).GetProperty(NomeField);
      if Assigned(RttiProperty) then
      begin
        // La property indicata esiste in Elem. E' leggibile?
        if RttiProperty.IsReadable then
        begin
          // Leggo il TValue della property sull'oggetto Elem
          RttiValue:=RttiProperty.GetValue(Elem);
          // Il valore è un oggetto?
          if RttiValue.IsObject then
          begin
            OggettoProp:=RttiValue.AsObject;
            // Leggo le info sulla property [Proprieta] della classe di OggettoProp
            RttiProperty:=RttiContext.GetType(OggettoProp.ClassType).GetProperty(Proprieta);
            if Assigned(RttiProperty) then
            begin
              // Anche la property [Proprietà] esiste. E' una stringa scrivibile?
              if ((RttiProperty.IsWritable) and (
                   (RttiProperty.PropertyType.TypeKind = tkString) or
                   (RttiProperty.PropertyType.TypeKind = tkLString) or
                   (RttiProperty.PropertyType.TypeKind = tkWString) or
                   (RttiProperty.PropertyType.TypeKind = tkUString))) then
                RttiProperty.SetValue(OggettoProp,Traduzione);
            end;
          end;
        end;
      end;
    end;
  end;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#0.ini
procedure TWR010FBase.VerificaCompatibilitaBrowser;
// verifica se il browser in uso è compatibile con irisweb
// e nel caso di problemi dà una notifica all'utente
begin
  if not (FInfoSupportoBrowser.TipoCompatibile and FInfoSupportoBrowser.VersioneCompatibile) then
  begin
    Notifica('Browser obsoleto',FInfoSupportoBrowser.Info,'',True,True);
  end;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#0.fine

procedure TWR010FBase.DistruggiOggetti;
// questa procedure deve contenere il codice di distruzione
// degli eventuali oggetti creati a runtime
begin
  // ridefinire
end;

//############################################//
//###         GESTIONE LINK COMUNI         ###//
//############################################//
procedure TWR010FBase.lnkIndietroClick(Sender: TObject);
var
  F: TIWAppForm;
  LCambiaTab: Boolean;
  LMsgConferma: String;
begin
  Log('Traccia','Click su Indietro');
  if medpModale then
  begin
    // se la form è modale il click su "Indietro" equivale
    // alla chiusura della form stessa
    // N.B.: si usa actLinkClose al posto di History.FormRemove che generava AV
    TWR010FBase(Self).actLinkClose(Self);
  end
  else
  begin
    // bugfix.ini
    // verifica se è possibile passare ad un'altra funzione
    // gestendo l'evento ontabchanging
    LCambiaTab:=True;
    LMsgConferma:='';
    OnTabChanging(LCambiaTab,LMsgConferma);
    if not LCambiaTab then
    begin
      if LMsgConferma <> '' then
        MsgBox.WebMessageDlg(LMsgConferma,mtWarning,[mbOk],nil,'');
      Exit;
    end
    else
    begin
      if LMsgConferma <> '' then
      begin
        // chiede conferma
        MsgBox.WebMessageDlg(LMsgConferma,mtConfirmation,[mbYes,mbNo],OnConfermaTabAction,'TAB_CHANGING');
        Exit;
      end;
    end;
    // bugfix.fine

    // determina la form precedente, che sarà quella da attivare
    F:=WR000DM.History.FormPrev(TIWAppForm(Self));
    if (F <> nil) and (F is TWR010FBase) then
    begin
      TWR010FBase(F).RefreshPageAttivo:=True;
      TWR010FBase(F).Show;
    end;
  end;
end;

procedure TWR010FBase.lnkChiudiSchedeClick(Sender: TObject);
// chiude tutte le schede attive
var
  i: Integer;
  AllowClose: Boolean;
  Conferma: String;
  F: TWR010FBase;
begin
  if (WR000DM <> nil) and
     (WR000DM.History <> nil) then
  begin
    // esegue ClosePage su tutte le form della history.
    // In questo modo viene scatenato OnTabClosing che verifica se la form può essere chiusa
    // ed eventualmente presenta un messaggio di avviso
    for i:=WR000DM.History.Count - 1 downto 0 do
    begin
      F:=(WR000DM.History.FormByIndex(i) as TWR010FBase);
      if not F.medpFissa then
      begin
        AllowClose:=True;
        Conferma:='';
        F.OnTabClosing(AllowClose,Conferma);
        if AllowClose and (Conferma = '') then
          F.ClosePage;
      end;
    end;
    Log('Traccia','Click su Chiudi schede');
  end;
end;

procedure TWR010FBase.imgIWInfoCookiesClick(Sender: TObject);
begin
  {$IFDEF WEBPJ}
  MsgBox.MessageBox(StringReplace(INFO_COOKIES,'IrisWEB','IrisCloud',[rfreplaceAll,rfIgnoreCase]),INFORMA,'Informativa cookie.');
  {$ELSE}
  MsgBox.MessageBox(INFO_COOKIES,INFORMA,'Informativa cookie.');
  {$ENDIF}
end;

procedure TWR010FBase.lnkHelpClick(Sender: TObject);
// accesso all'help contestuale
begin
  {$IFNDEF INTRAWEBSVC}
  if (HelpKeyword = '') or (Pos('W001',HelpKeyword.ToUpper) = 1) then
    exit;
  FileBox.Directory:=fdHelp;
  FileBox.NomeFile:=HelpKeyword + '.htm';
  FileBox.Titolo:='Help in linea: ' + FNomeFunzione;
  FileBox.OnShowFile:=nil;
  FileBox.OnCloseFile:=nil;
  if not FileBox.EsisteFile then
    GGetWebApplicationThreadVar.ShowMessage(Format('L''help in linea per la funzione %s non è presente!',[Title]))
  else
    FileBox.Visualizza;

  Log('Traccia','Visualizzazione help');
  {$ENDIF}
end;

procedure TWR010FBase.lnkEsciClick(Sender: TObject);
// uscita dalla sessione (logout)
var
  RedirectUrl,InfoUsr: String;
  i: Integer;
  AbilitaLogout: Boolean;
begin
  // COMO_HSANNA - commessa 2011/178.ini
  // forza chiusura schede per verificare evento OnTabClosing
  AbilitaLogout:=True;
  if (WR000DM <> nil) and
     (WR000DM.History <> nil) then
  begin
    // chiama l'evento "chiudi schede"
    lnkChiudiSchedeClick(nil);

    // se dopo la chiamata a "chiudi schede" rimangono aperte
    // delle form non fisse, impedisce il logout
    for i:=WR000DM.History.Count - 1 downto 0 do
    begin
      if not (WR000DM.History.FormByIndex(i) as TWR010FBase).medpFissa then
      begin
        AbilitaLogout:=False;
        Break;
      end;
    end;
  end;
  // COMO_HSANNA - commessa 2011/178.fine

  if not AbilitaLogout then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_LOGOUT_IMPEDITO),ESCLAMA,'Logout');
    Exit;
  end;

  // estrae eventuale url per fare il redirect dopo la chiusura sessione
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) and
     (GGetWebApplicationThreadVar.Data is TSessioneWeb) then
  begin
    RedirectUrl:=(GGetWebApplicationThreadVar.Data as TSessioneWeb).HomeUrl;
  end
  else
  begin
    RedirectUrl:='';
  end;

  // log uscita sessione irisweb
  if Pos('ACCESSO',W000ParConfig.LogAbilitati) > 0 then
  begin
    InfoUsr:='';
    if Parametri <> nil then
    begin
      try
        InfoUsr:=Parametri.Operatore;
      except
      end;
    end;
    Log('Accesso','Logout utente ' + InfoUsr);
  end;

  // chiusura della sessione web
  if GGetWebApplicationThreadVar <> nil then
  begin
    if RedirectUrl = '' then
      GGetWebApplicationThreadVar.Terminate(gSC.Description + ': fine sessione')
    else
      GGetWebApplicationThreadVar.TerminateAndRedirect(RedirectUrl);
  end;
end;

procedure TWR010FBase.lnkIWICClick(Sender: TObject);
var sURL,Cod:String;
begin
  if Trim(W000ParConfig.UrlWebApp) <> '' then
    sURL:=WR000DM.FormattaUrlWebApp
  else
    sURL:=W000ParConfig.UrlIrisWebCloud + '?' +
          'azienda=' + Parametri.Azienda +
          '&usr=' + Parametri.Operatore +
          '&pwd=' + Parametri.PassOper +
          '&database=' + Parametri.Database +
          '&home=' + W000ParConfig.UrlIrisWebCloud;

  if (W000ParConfig.IrisWebCloudNewTab = 'N') and (Trim(W000ParConfig.UrlWebApp) = '') then
    //metodo 1:
    //sostituisce la sessione con quella dell'altro applicativo:
    GGetWebApplicationThreadVar.TerminateAndRedirect(sURL)
  else
  begin
    //metodo 2:
    //apre una nuova sessione in un'altra finestra con l'altro applicativo senza chiudere quella corrente
    Cod:=Format('wNewWin = window.open("%s","","resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no"); ' +
    //Cod:=Format('wNewWin = window.open("%s","_blank","resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no"); ' +
                // controllo popup bloccati
                'if (!wNewWin || (typeof wNewWin == ''undefined'')) { ' +
                '  /*alert("Verificare che il blocco popup non sia attivo e quindi riprovare!"); */ ' +
                '} ' +
                'else { ' +
                '  wNewWin.focus();' +
                '}',
                [sURL]);
    // fix IE: a volte la finestra con il pdf va in background
    // soluzione: si introduce un breve ritardo nell'apertura della finestra
    if GetBrowser is TInternetExplorer then
      Cod:=Format('window.setTimeout(function () { %s }, 300); ',[Cod]);
    // esegue il codice javascript
    AddToInitProc(Cod);

    (*//metodo 3:
    //apre una nuova sessione in un altro tab con l'altro applicativo senza chiudere quella corrente
    //VEDI https://developer.mozilla.org/en-US/Add-ons/Code_snippets/Tabbed_browser#Getting_access_to_the_browser
    Cod:=Format('var mainWindow = window.QueryInterface(Components.interfaces.nsIInterfaceRequestor) ' +
                       '.getInterface(Components.interfaces.nsIWebNavigation) ' +
                       '.QueryInterface(Components.interfaces.nsIDocShellTreeItem) ' +
                       '.rootTreeItem ' +
                       '.QueryInterface(Components.interfaces.nsIInterfaceRequestor) ' +
                       '.getInterface(Components.interfaces.nsIDOMWindow); ' +
                'mainWindow.gBrowser.selectedTab = mainWindow.gBrowser.addTab("%s");',[sURL]);
    // esegue il codice javascript
    AddToInitProc(Cod); *)
  end;
end;

procedure TWR010FBase.lnkRefreshPageClick(Sender: TObject);
begin
  RefreshPage;
end;

//############################################//
//###    GESTIONE AZIONI MENU / HISTORY    ###//
//############################################//

procedure TWR010FBase.OnTabChanging(var AllowChange: Boolean; var Conferma: String);
// detetermina se è possibile creare / spostarsi su un altro tab della history
// per impedire lo spostamento impostare AllowChange a False
// per consentire lo spostamento previo messaggio di conferma impostare AllowChange a True e Conferma
begin
  // ridefinire
end;

procedure TWR010FBase.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
// determina se è possibile chiudere la form attiva nella history
// per impedire la chiusura impostare AllowClose a False
// per consentire la chiusura previo messaggio di conferma impostare AllowClose a True e Conferma
begin
  // ridefinire
end;

procedure TWR010FBase.OnConfermaTabAction(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
// risposta del messaggio modale di conferma
begin
  if KeyID = 'TAB_CHANGING' then
  begin
    case Res of
      mrYes:
        begin
          actLinkSelect(nil);
          MsgBox.ClearKeys; // verificare
        end;
      mrNo:
        MsgBox.ClearKeys;
    end;
  end
  else if KeyID = 'TAB_CLOSING' then
  begin
    case Res of
      mrYes:
        actLinkClose(nil);
      mrNo:
        MsgBox.ClearKeys;
    end;
  end;
end;

procedure TWR010FBase.actLinkSelect(Sender:TObject);
// questa funzione viene richiamata da
// - click su un tab della history
// - dopo la chiusura di un tab della history
// richiama la procedura actExecute del menu principale
begin
{$IFNDEF X001}{$IFNDEF INTRAWEBSVC}
  if Sender = nil then
    Log('Traccia',Format('actLinkSelect: chiusura del tab "%s"',[medpNomeFunzione]))
  else if Sender is TmeIWLink then
    Log('Traccia',Format('actLinkSelect: passaggio dal tab "%s" a "%s"',[medpNomeFunzione,TmeIWLink(Sender).Caption]));
  {$IFDEF WEBPJ}
    {$IFDEF RILPRE}TWC502FMenuRilPreFM{$ENDIF}
    {$IFDEF PAGHE}TWC503FMenuPagheFM{$ENDIF}
    {$IFDEF STAGIU}TWC504FMenuStagiuFM{$ENDIF}
  {$ELSE}
    TWC501FMenuIrisWebFM
  {$ENDIF}
  (WMenuFM).actExecute(Sender);
{$ENDIF}{$ENDIF}
end;

procedure TWR010FBase.actLinkClose(Sender: TObject);
// chiusura di una form dalla history
var
  FClose,FPrev,FNext: TIWAppForm;
  ChiudiTab: Boolean;
  Conferma: String;
  i: Integer;
begin
  Log('Traccia',Format('actLinkClose: chiusura del tab "%s"',[medpNomeFunzione]));

  // verifica se è possibile chiudere la funzione
  if not MsgBox.KeyExists('TAB_CLOSING') then
  begin
    ChiudiTab:=True;
    OnTabClosing(ChiudiTab,Conferma);
    if not ChiudiTab then //chiusura inibita
    begin
      if Conferma <> '' then //messaggio avviso
        MsgBox.WebMessageDlg(Conferma,mtWarning,[mbOk],nil,'');
      Exit;
    end
    else
    begin
      //chiusura consentita
      if Conferma <> '' then //richiesta conferma
      begin
        //richiesta conferma forzatura
        if Sender is TmeIWLink then
          OldIdxClose:=TmeIWLink(Sender).Tag
        else
          OldIdxClose:=-1;
        MsgBox.WebMessageDlg(Conferma,mtConfirmation,[mbYes,mbNo],OnConfermaTabAction,'TAB_CLOSING');
        Exit;
      end;
    end;
  end;

  FPageClosing:=True;

  // rimosso per evitare cicli.ini
  {
  // se la form in chiusura è l'unica nella history -> termina
  if (WR000DM.History.Count = 1) and (UpperCase(WR000DM.History.FormByIndex(0).ClassName) <> 'TW007FGESTIONESICUREZZA') then
    lnkEsciClick(nil);
  }
  // rimosso per evitare cicli.fine

  // questo evento può essere innescato da due operazioni:
  // 1. click sul pulsante di chiusura tab  -> Sender is TmeIWLink
  // 2. richiamo di ClosePage               -> Sender is TIWAppForm
  if Sender is TmeIWLink then
  begin
    // click sul link di chiusura tab
    // meIWLink.Tag è l'indice della form nella history
    i:=TmeIWLink(Sender).Tag;
    FClose:=WR000DM.History.FormByIndex(i);
  end
  else if Sender is TIWAppForm then
  begin
    // richiamato da ClosePage
    FClose:=TIWAppForm(Sender)
  end
  else
  begin
    // richiamato da messaggio di conferma
    // OldIdxClose è l'indice della form nella history
    FClose:=WR000DM.History.FormByIndex(OldIdxClose);
  end;

  if FClose = Self then
  begin

    //Caratto 14/03/2014 getione funzione non abilitata
    //se arrivo da accedi di un'altra form e non abilitato, ritorno sulla form origine
    if FOpenerTag > -1 then
      FPrev:=WR000DM.History.FormByTag(FOpenerTag)
    else
      FPrev:=WR000DM.History.FormPrev(FClose);
    // se esiste, seleziona la form precedente nella history
    // altrimenti seleziona la form successiva

    if FPrev <> nil then
      actLinkSelect(FPrev)
    else
    begin
      // form successiva
      FNext:=WR000DM.History.FormNext(FClose);
      if FNext <> nil then
        actLinkSelect(FNext);
    end;
  end;
  // SERVE???
  //else
  //  actLinkSelect(Self);

  // rimuove la form dalla history e la distrugge
  WR000DM.History.FormRemove(FClose,True);
end;

procedure TWR010FBase.GestioneMenu;
// gestione del menu principale
begin
  // ridefinire
end;

procedure TWR010FBase.NascondiMenu;
// procedura per nascondere il menu
begin
  if WMenuFM <> nil then
    WMenuFM.Visible:=False;
end;

//############################################//
//###       GESTIONE MENU CONTESTUALE      ###//
//############################################//

procedure TWR010FBase.OnAsyncContextMenu(EventParams: TStringList);
var
  Azione,SenderName,Tipo,ResponseFunc: String;
  MenuComp: TComponent;
  i: Integer;
begin
  // azione è il nome del TMenuItem
  Azione:=EventParams.Values['azione'];
  // sendername è il nome del componente che ha attivato il menu contestuale
  SenderName:=EventParams.Values['sender'];

  // cerca il menu item nella form per estrarne l'hint
  MenuComp:=FindComponent(Azione);

  // se non lo trova, cerca nei frame all'interno della form
  // utilizzando un array che contiene i frame stessi
  if not Assigned(MenuComp) then
  begin
    for i:=0 to High(FrameArr) do
    begin
      if Assigned(FrameArr[i]) then
      begin
        try MenuComp:=FrameArr[i].FindComponent(Azione); except end;
        if Assigned(MenuComp) then
          Break;
      end;
    end;
  end;

  // gestione proprietà menu item
  ResponseFunc:='';
  if Assigned(MenuComp) and (MenuComp is TMenuItem) then
  begin
    with (MenuComp as TMenuItem) do
    begin
      // tipo = hint del menu item (classe css utilizzata per scopi diversi)
      Tipo:=Hint;

      // gestione autocheck
      if AutoCheck then
        Checked:=not Checked;

      // gestione classe checked per eventi async
      ResponseFunc:=Format('$elem = jQuery.root.find("#%s"); ' +
                           'if ($elem.length) { ' +
                           '  $elem.toggleClass("checked",%s); ' +
                           '} ',[Name,IfThen(Checked,'true','false')]);
    end;
  end
  else
  begin
    Tipo:='';
  end;

  if (R180CercaParolaIntera('submit',Tipo,'') > 0) or
     (Tipo = 'file_xls') or (Tipo = 'file_pdf') or (Tipo = 'file_csv') then
  begin
    // eseguo l'evento OnClick del MenuItem (anticipo l'elaborazione lunga in modo da vedere il cursore di caricamento nel browser)
    if Assigned((MenuComp as TMenuItem).OnClick) and ((Tipo = 'file_xls') or (Tipo = 'file_csv')) then
      (MenuComp as TMenuItem).OnClick(nil);
    // forza un submit
    // la GGetWebApplicationThreadVar.SendStream non funziona in async!
    ResponseFunc:=ResponseFunc + Format('SubmitClick("%s","%s&%s",true); ShowBusy(false); ',[lnkContextMenu.HTMLName, Azione,SenderName]);
  end
  else
  begin
    OnContextMenu(Azione,SenderName,TMenuItem(MenuComp));
    ResponseFunc:=ResponseFunc + 'ShowBusy(false);';
  end;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(ResponseFunc);
end;

procedure TWR010FBase.OnContextMenu(const PMenuItem, PSenderName: String; const PMenuItemComp: TMenuItem = nil);
// procedura eseguita in risposta al click sul menu contestuale
var
  MenuItemComp,PopupComp: TComponent;
  MenuComp: TPopupMenu;
  S: String;
  i: Integer;
begin
  // 1. se non impostato cerca il menu item all'interno della form
  if PMenuItemComp = nil then
  begin
    MenuItemComp:=FindComponent(PMenuItem);

    // se non lo trova, cerca nei frame all'interno della form
    // utilizzando un array che contiene i frame stessi
    if not Assigned(MenuItemComp) then
    begin
      for i:=0 to High(FrameArr) do
      begin
        if Assigned(FrameArr[i]) then
        begin
          try MenuItemComp:=FrameArr[i].FindComponent(PMenuItem); except end;
          if Assigned(MenuItemComp) then
            Break;
        end;
      end;
    end;
  end
  else
    MenuItemComp:=PMenuItemComp;

  // 2. cerca il componente che ha richiamato il menu
  // e lo associa come property PopupComponent al TPopupMenu
  try
    PopupComp:=FindComponent(PSenderName);
    if not Assigned(PopupComp) then
    begin
      for i:=0 to High(FrameArr) do
      begin
        if Assigned(FrameArr[i]) then
        begin
          // all'interno di un frame al nome del componente viene
          // concatenato come suffisso il nome del frame
          // la FindComponent non vuole il suffisso (cerca il nome originale del componente)
          S:=StringReplace(PSenderName,FrameArr[i].Name,'',[rfIgnoreCase]);
          try PopupComp:=FrameArr[i].FindComponent(S); except end;
          if Assigned(PopupComp) then
            Break;
        end;
      end;
    end;
    MenuComp:=((MenuItemComp as TMenuItem).GetParentMenu as TPopupMenu);
    if MenuComp <> nil then
      MenuComp.PopupComponent:=PopupComp;
  except
  end;

  // 3. esegue la procedura OnClick
  if Assigned(MenuItemComp) and (MenuItemComp is TMenuItem) then
  begin
    // esegue procedure OnClick
    if Assigned((MenuItemComp as TMenuItem).OnClick) then
    begin
      try
        (MenuItemComp as TMenuItem).OnClick(MenuItemComp);
      except
        on E: Exception do
        begin
          Log('Errore','OnContextMenu;' + (MenuItemComp as TMenuItem).Name,E);
          //Casi particolari in cui far risalire l'eccezione per visualizzarla all'utente
          if R180In((MenuItemComp as TMenuItem).Name,['mnuCompetenzeResidui']) then
            raise;
        end;
      end;
    end;
  end;
end;

procedure TWR010FBase.lnkContextMenuClick(Sender: TObject);
var
  ParStr, NomeAzione, NomeSender: String;
  p: Integer;
begin
  if not (Sender is TmeIWLink) then
    Exit;

  // parametro inviato via javascript
  ParStr:=(Sender as TmeIWLink).GetSubmitParam;

  p:=Pos('&',ParStr);
  NomeAzione:=Copy(ParStr,1,p - 1);
  NomeSender:=Copy(ParStr,p + 1,MAXINT);

  OnContextMenu(NomeAzione,NomeSender);
end;

//############################################//
//###      GESTIONE MESSAGGIO MODALE       ###//
//############################################//

procedure TWR010FBase.VisualizzajQMessaggio(jqWidget:TIWJQueryWidget; PWidth,PHeight,PHeightIE6: Integer; const PTitle:String;
  const PObjName:String = '.frm'; PCloseButton:Boolean = True; PResizable:Boolean = True; PZIndex:Integer = -1;
  const Position:String = ''; const JSonOpen: String = ''; const PCloseControlHTMLName: String = '');
// predispone e imposta il codice javascript per visualizzare un dialog modale
// (utilizzare per visualizzazione frame)
begin
  VisualizzajQMessaggio(jqWidget,PWidth,60,PHeight,PHeightIE6,PTitle,PObjName,PCloseButton,PResizable,PZIndex,Position,JSonOpen,PCloseControlHTMLName);
end;

procedure TWR010FBase.VisualizzajQMessaggio(jqWidget:TIWJQueryWidget; PWidth,PMinHeight,PHeight,PHeightIE6: Integer; const PTitle:String;
  const PObjName:String = '.frm'; PCloseButton:Boolean = True; PResizable:Boolean = True; PZIndex:Integer = -1;
  const Position:String = ''; const JSonOpen: String = ''; const PCloseControlHTMLName: String = '');
// predispone e imposta il codice javascript per visualizzare un dialog modale
// (utilizzare per visualizzazione frame)
var
  OptShow,
  OptHide,
  S,S2,SOpen: String;
  IsMsgBox: Boolean;
begin
  //Alberto 17/01/2013: forzo la visualizzazione del frame sulla pagina attiva
  if jqWidget.Owner is TFrame then
    (jqWidget.Owner as TFrame).Parent:=(GGetWebApplicationThreadVar.ActiveForm as TIWAppForm);

  //Alberto 17/01/2013: tengo traccia dell'ultimo messaggio visualizzato (tag più alto)
  //per successiva impostazione della proprietà jquery 'modal' in CicloComponenti
  inc(WR000DM.NumFrameVisualizzati);
  jqWidget.Tag:=WR000DM.NumFrameVisualizzati;

  // se altezza automatica e IE6 utilizza altezza definita
  if (PHeight = -1) and
     (GetBrowser is TInternetExplorer) and
     (GetBrowser.MajorVersion = 6) then
  begin
    PHeight:=PHeightIE6;
  end;

  //MinHeight:=60;

  IsMsgBox:=(PObjName = '#msgDialog');

  // effetto in fase di show solo per msgbox (dà fastidio in presenza di dialog multipli)
  OptShow:=IfThen(IsMsgBox,'"highlight"','');
  // effetto in fase di close: è inutile al momento (full submit)
  OptHide:=IfThen(IsMsgBox,'','"fade"'); // '"fade"';

  S:='var maxW = $(window).width() - 45; var maxH = $(window).height() - 45; ' +
     'var dialW = ' + IntToStr(PWidth) + '; ' +
     'var dialH = ' + IntToStr(PHeight) + '; ' +
     'if (dialW > maxW) {dialW = maxW;} ' +
     'if (dialH > maxH) {dialH = maxH;} ' +
     '$("' + PObjName + '").dialog({ ' +
     '  autoOpen: false,' +                                        // auto apertura dialog sempre false
     IfThen(PWidth >= 0,' width: dialW,') +                        // width
     IfThen(PHeight >= 0,' height: dialH,') +                      // height
     '  minHeight: ' + IntToStr(PMinHeight) + ',' +                 // height: fix problema jquery (se altezza effettiva minore di min-height il risultato è mediocre)
     '  modal: true,' +                                            // modale: sempre true
     IfThen(OptShow <> '',
     '  show: ' + OptShow + ',') +                                 // effetto in apertura
     IfThen(OptHide <> '',
     '  hide: ' + OptHide + ',') +                                 // effetto in chiusura
     //Bruno: 17/06/2016
     //Sostituisco nel title il carattere "%" sembra che il plugin jq faccia delle valutazioni su di esso
     //compromettendo il fuzionamento
     '  title: "' + C190EscapeJS(PTitle).Replace('%','',[rfReplaceAll]) + '",' +  // titolo dialog
     '  closeOnEscape: false,' +                                   // disabilita chiusura con tasto ESC
     '  resizable: ' + IfThen(PResizable,'true','false') + ',' +   // ridimensionamento
     (*// jquery UI 1.10.0 - proprietà zIndex e stack rimosse: attenzione
     IfThen(PZIndex <> -1,
     '  zIndex: ' + IntToStr(PZIndex) + ',') +                     // z-index
     '  stack: ' + IfThen(IsMsgBox,'true','false') +',' +          // stack
     *)
     IfThen (Position <> '',' position: ' + Position + ',','') +
     '  dialogClass: ''' + IfThen(PCloseButton,'','no-closeButton') + ''' ' +    //close button
     '  %s ' +
     '})' +
     // bind dell'evento beforeclose: si può associare un evento OnClick di un pulsante
     IfThen(PCloseButton and (PCloseControlHTMLName <> ''),
     '.bind("dialogbeforeclose", function(event, ui) { ' +
     '   SubmitClick("' + PCloseControlHTMLName + '", "", true); ' +
     ' })') +
     '; ';

  // operazioni speciali
  S2:='';
  if (PTitle = '') or (JSonOpen <> '') then
  begin
    S2:=', open: function(event, ui) { ';
    S2:=S2 + JSonOpen;
    // nasconde barra del titolo
    if PTitle = '' then
      S2:=S2 + ' $(".ui-dialog-titlebar").hide()';
    S2:=S2 + ';}';
  end;
  S:=Format(S,[S2]);

  // fix modal dialog + primo elemento input con datepicker
  // inserisce un input non visibile che riceve il focus ed evita che il datepicker
  // venga visualizzato inizialmente
  S:=S + Format('$("%s").prepend("<input type=\"text\" style=\"width: 0; height: 0; top: -100px; position: absolute;\"\/> "); ',[PObjName]);

  // fix html: gli elementi "input" devono avere come nodo genitore il tag <form>
  S:=S + Format('$("%s").wrap("<form><\/form>"); ',[PObjName]);

  // fix modal dialog
  if (not IsMsgBox) then
  begin
    (*
    SOpen:=Format('//POST//setTimeout(function(){ ' +
                  '  $("%s").dialog("open"); ' +
                  '}, %d); ',
                  //[PObjName,IfThen(IsMsgBox,100,jqWidget.Tag)]);
                  [PObjName,1]);
    *)
    SOpen:=Format('//SPOSTA//$("%s").dialog("open");',[PObjName]);
    S:=S + CRLF + SOpen;
  end;

  jqWidget.OnReady.Text:=S;
end;

procedure TWR010FBase.Messaggio(const Titolo, Testo: String; PProcSi, PProcNo: TProcObject);
// funzione immediata per visualizzare un messagebox di conferma
// PProcSi: viene eseguita in caso di risposta si / ok
// PProcNo: viene eseguita in caso di risposta no
begin
  // salva i parametri procedura in variabili private del form
  FProcSiMsg:=PProcSi;
  FProcNoMsg:=PProcNo;
  MsgBox.WebMessageDlg(Testo,mtConfirmation,[mbYes,mbNo],OnRispostaMessaggio,'',Titolo);
end;

procedure TWR010FBase.OnRispostaMessaggio(Sender: TObject; PRes: TmeIWModalResult; PKeyID: String);
// risposta del messaggio modale
// nota: PKeyID viene ignorato
begin
  case PRes of
    mrYes:
      if @FProcSiMsg <> nil then
        try
          FProcSiMsg;
        except
          on E:Exception do
            Log('Errore','OnRispostaMessaggio;mrYes: ' + MethodName(@FProcSiMsg),E);
        end;
    mrNo:
      if @FProcNoMsg <> nil then
      try
        FProcNoMsg;
      except
        on E:Exception do
          Log('Errore','OnRispostaMessaggio;mrNo: ' + MethodName(@FProcNoMsg),E);
      end;
  end;
end;

procedure TWR010FBase.MessaggioStatus(const PTipo,PTesto: String; const PDurataTesto: Integer = -1);
// messaggio da visualizzare nella barra di stato / errore
begin
  MessaggioStatus(PTipo,PTesto,'',0,PDurataTesto);
end;

procedure TWR010FBase.MessaggioStatus(const PTipo, PTesto, PTestoPopup: String; const PDurataPopup: Integer = 5000; const PDurataTesto: Integer = -1);
// messaggio da visualizzare nella barra di stato / errore
begin
  // ridefinire
end;

procedure TWR010FBase.MessaggioPopup(const PTesto: String);
// imposta o nasconde un popup a scomparsa (elemento div in primo piano)
var
  LJSCode: String;
const
  CSS_CLASS_POPUP = 'popup';
begin
  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    if PTesto = '' then
    begin
      // fadeout del messaggio
      LJSCode:='$("#avviso").fadeOut(400);';
    end
    else
    begin
      // fadein del messaggio
      if GetBrowser is TInternetExplorer then
        LJSCode:='$("#avviso").attr("class","").attr("class","%s")'
      else
        LJSCode:='$("#avviso").attr("class","").addClass("%s")';
      LJSCode:=LJSCode + '.hide().text("%s").fadeIn(800);';
      LJSCode:=Format(LJSCode,[CSS_CLASS_POPUP,PTesto]);
    end;
    GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(LJSCode);
  end;
end;

//############################################//
//###          GESTIONE NOTIFICHE          ###//
//############################################//
procedure TWR010FBase.NotificheCustom;
{Visualizza notifiche custom indicate nella tabella I040_NOTIFICHE_IRISWEB}
var Titolo,Testo,Icona:String;
begin
  with WR000DM.selI040 do
  begin
    try
      Open;
    except
      exit;
    end;
    try
      while not Eof do
      begin
        GetDatiNotificaCustom(FieldByName('NOTIFICA').AsString,Titolo,Testo,Icona);
        if Testo <> '' then
          Notifica(Titolo,Testo,Icona,True,True);
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TWR010FBase.GetDatiNotificaCustom(Procedura:String; var Titolo,Testo,Icona:String);
{per ogni notifica, estrae Titolo, Testo e Icona, gestendo eventuale link a funzione della toolbar}
  function GetTag2HtmlName(Testo:String):String;
  var i,x:Integer;
      sTag,HtmlName:String;
  begin
    //Cerco parte numerica prima di .HtmlName: è il tag della funzione da richiamare
    Result:=Testo;
    sTag:='';
    x:=Pos('.htmlname',LowerCase(Testo));
    for i:=x - 1 downto 1 do
      if not (Testo[i] in ['0'..'9']) then
        Break
      else
        sTag:=Testo[i] + sTag;
    if sTag <> '' then
    begin
      HtmlName:=HtmlNameIcona(sTag.ToInteger);
      Result:=StringReplace(Testo,sTag + '.htmlname',HtmlName,[rfIgnoreCase]);
    end;
  end;
begin
  Titolo:='';
  Testo:='';
  Icona:='';
  with WR000DM.scrI040 do
  begin
    ClearVariables;
    SetVariable('PROCEDURA',Procedura);
    SetVariable('TIPOOPERATORE',Parametri.TipoOperatore);
    SetVariable('OPERATORE',Parametri.Operatore);
    SetVariable('PROGROPER',Parametri.ProgressivoOper);
    SetVariable('MATROPER',Parametri.MatricolaOper);
    SetVariable('CODFISOPER',Parametri.CodFiscaleOper);
    SetVariable('PROFILO',Parametri.ProfiloWEB);
    SetVariable('MODULI',StringReplace(Parametri.ModuliInstallati,#13,',',[rfReplaceAll]));
    SetVariable('CESSATI','N');
    if Self.FindComponent('chkDipendentiCessati') <> nil then
      SetVariable('CESSATI',IfThen(TmeIWCheckBox(Self.FindComponent('chkDipendentiCessati')).Checked,'S','N'));

    (*Essendo che selAnagrafe.SubstitutedSQL può essere molto lungo, se il db usa codifica unicode si possono
      facilmente raggiungere i limiti di lunghezza della variabile (max 2000 car), per cui in tal caso non si passa nulla
      Per le altre codifiche non unicode invece il limite è 4000 car.
    *)
    SetVariable('SELANAGRAFE',null);
    if (not Parametri.CharSetUnicode) and (WR000DM.selAnagrafe.SubstitutedSQL.Length <= 4000) then
      SetVariable('SELANAGRAFE',WR000DM.selAnagrafe.SubstitutedSQL);
    try
      Execute;
      Titolo:=VarToStr(GetVariable('TITOLO'));
      Testo:=VarToStr(GetVariable('TESTO'));
      //Gestisce riferimento fisso a lnkNotifica
      if Self.FindComponent('lnkNotifica') <> nil then
        Testo:=StringReplace(Testo,'lnkNotifica.HTMLName',TmeIWLink(Self.FindComponent('lnkNotifica')).HTMLName,[rfIgnoreCase]);
      //Gestisce riferimento generico a un Tag di una delle funzioni della toolbar
      if Pos('.htmlname',LowerCase(Testo)) > 0 then
        Testo:=GetTag2HtmlName(Testo);
      Icona:=VarToStr(GetVariable('ICONA'));
    except
    end;
  end;
end;

function  TWR010FBase.HtmlNameIcona(pTag:Integer):String;
var i:Integer;
begin
  Result:='';
  for i:=0 to High(IconeAccessoRapidoArr) do
  begin
    if IconeAccessoRapidoArr[i].Tag = pTag then
    begin
      Result:=IconeAccessoRapidoArr[i].HTMLName;
      Break;
    end;
  end;
end;

procedure TWR010FBase.Notifica(const PTitolo, PTesto: String; const PImageUrl: String;
  const PAccoda, PSticky: Boolean; const PDurata: Integer = 0);
// aggiunge una notifica in style growl
var
  Code, Stile, StickyStr, TestoJS: String;
begin
  if Trim(PTesto) = '' then
    Exit;

  // testo messaggio
  TestoJS:=C190EscapeJS(PTesto);

  // sticky: indica se il messaggio è persistente o scompare dopo la durata indicata
  StickyStr:=IfThen(PSticky,'true','false');

  // stile: al momento non indicato
  Stile:='';

  // codice per attivare il plugin
  Code:=Format(W000JQ_Gritter,[PTitolo,TestoJS,PImageUrl,StickyStr,PDurata,Stile]);

  // MONDOEDP -commessa MAN/07 SVILUPPO#0.ini
  // fix per notifiche su IE6
  if (GetBrowser is TInternetExplorer) and
     (GetBrowser.Version < 8) then
  begin
    // forza il posizionamento assoluto del div di notifica, che altrimenti sarebbe fixed
    Code:=Code + #13#10'document.getElementById("gritter-notice-wrapper").style.position="absolute"; ';
  end;
  // MONDOEDP -commessa MAN/07 SVILUPPO#0.fine

  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    // gestione in async
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Code);
  end
  else
  begin
    // pulisce le altre notifiche se necessario
    if not PAccoda then
      jqGritter.OnReady.Clear;
    // accoda la notifica
    jqGritter.OnReady.Add(Code);
  end;
end;

procedure TWR010FBase.RimuoviNotifiche;
// rimuove tutte le notifiche presenti
var
  S: String;
begin
  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    S:='$.gritter.removeAll(); ' +
       'return false; ';
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(S)
  end
  else
  begin
    jqGritter.OnReady.Clear;
  end;
end;

//############################################//
//###  GENERAZIONE E VISUALIZZAZIONE FILE  ###//
//############################################//

function TWR010FBase.GetNomeFile(PExt: String; const PDirectory: TmedpDirectory = fdUser): String;
var
  FPath,FPrefisso,Ora: String;
begin
  // determina il path dove generare il file
  try
    case PDirectory of
      fdUser:   begin
                  { DONE : TEST IW 14 OK }
                  (*Result:=StringReplace(TIWAppCache.NewTempFileName,'.tmp','.pdf',[rfReplaceAll]); exit;//TEST_IW_XIV//*)
                  FPath:=GGetWebApplicationThreadVar.UserCacheDir;
                  FPrefisso:=medpCodiceForm;
                end;
      fdGlobal: begin
                  { DONE : TEST IW 14 OK }
                  FPath:=Format('%s%s\',[TA000FInterfaccia(gSC).MEDPFilesDir,medpCodiceForm]); // sottodirectory di Files
                  FPrefisso:=GGetWebApplicationThreadVar.AppId;
                end;
      fdHelp:   begin
                  { DONE : TEST IW 14 OK }
                  FPath:=Format('%s%s\',[TA000FInterfaccia(gSC).MEDPFilesDir,PATH_HELP]);      // sottodirectory Help di Files
                  FPrefisso:='';
                end;
    end;
    Ora:=FormatDateTime('hhhhnnss',Now);
    if Copy(PExt,1,1) = '.' then
      PExt:=Copy(PExt,2);
    Result:=Format('%s%s_%s.%s',[FPath,FPrefisso,Ora,PExt]);
  except
    on E: Exception do
    begin
      Result:='';
      Log('Errore','Errore durante generazione file',E);
    end;
  end;
end;

procedure TWR010FBase.InviaFile(const PNomeFile: String; const PContenuto: String);
// utilizza la sendstream per inviare al client il file indicato
// PNomeFile  = nome del file con estensione (viene visualizzato dal browser)
// PContenuto = contenuto del file (testo)
// IMPORTANTE: il memory stream viene distrutto automaticamente da delphi
//             al termine della sendstream
var
  MemStream: TMemoryStream;
  L: TStringList;
begin
  try
    MemStream:=TMemoryStream.Create;
    L:=TStringList.Create;
    L.Text:=PContenuto;
    L.SaveToStream(MemStream);
    GGetWebApplicationThreadVar.SendStream(MemStream,True,'application/x-download',PNomeFile);
    TA000FInterfaccia(gSC).SegnaSessioneAttiva;
  except
    on E: Exception do
    begin
      Log('Errore','Errore durante InviaFile',E);
    end;
  end;
  FreeAndNil(L);
end;

procedure TWR010FBase.InviaFile(const PNomeFile: String; const PStream: TStream);
// utilizza la sendstream per inviare al client il file presente nello stream di input
// PNomeFile  = nome del file con estensione (viene visualizzato dal browser)
// PStream    = contenuto del file (TStream)
// IMPORTANTE: lo stream viene distrutto automaticamente da delphi
//             al termine della sendstream
begin
  try
    GGetWebApplicationThreadVar.SendStream(PStream,True,'application/x-download',PNomeFile);
    TA000FInterfaccia(gSC).SegnaSessioneAttiva;
  except
    on E: Exception do
    begin
      Log('Errore','Errore durante InviaFile',E);
    end;
  end;
end;

function TWR010FBase.GeneraFile(PDirectory: TmedpDirectory; const PExt, PTesto: String; var ErrStr: String): String;
// genera e salva nella directory indicata il nome del file di testo
// restituisce il nome file completo di path
var
  ListCsv: TStringList;
begin
  Result:='';
  ListCsv:=TStringList.Create;
  try
    // imposta il nome del file
    Result:=GetNomeFile(PExt,PDirectory);
    if not ForceDirectories(ExtractFileDir(Result)) then
    begin
      Result:='';
      ErrStr:=Format('Errore in fase di esportazione: impossibile creare directory "%s"',[ExtractFileDir(Result)]);
      Exit;
    end;
    ListCsv.Text:=PTesto;
    ListCsv.SaveToFile(Result);
  finally
    FreeAndNil(ListCsv);
  end;
end;

function TWR010FBase.GeneraFile(PDirectory: TmedpDirectory; const PExt: String; PContenuto: TStream; var ErrStr: String): String;
// genera e salva nella directory indicata il nome del file contenuto nello stream PContenuto
// restituisce il nome file completo di path
var
  FileStream: TFileStream;
begin
  // imposta il nome del file
  Result:=GetNomeFile(PExt,PDirectory);
  if not ForceDirectories(ExtractFileDir(Result)) then
  begin
    Result:='';
    ErrStr:=Format('Errore in fase di esportazione: impossibile creare directory "%s"',[ExtractFileDir(Result)]);
    Exit;
  end;
  FileStream:=TFileStream.Create(Result, fmCreate);
  try
    FileStream.CopyFrom(PContenuto, 0);
  finally
    FreeAndNil(FileStream);
    FreeAndNil(PContenuto);
  end;
end;

procedure TWR010FBase.VisualizzaFile(const PNomeFile, PTitolo: String; POnShow, POnClose: TProcObject; const PDirectory: TmedpDirectory = fdUser);
begin
  {$IFNDEF INTRAWEBSVC}
  FileBox.Directory:=PDirectory;
  FileBox.NomeFile:=PNomeFile;
  FileBox.Titolo:=PTitolo;
  FileBox.OnShowFile:=POnShow;
  FileBox.OnCloseFile:=POnClose;
  FileBox.Visualizza;
  {$ENDIF}
end;

//############################################//
//###      GESTIONE ERRORI JAVASCRIPT      ###//
//############################################//

procedure TWR010FBase.OnJsErrore(EventParams: TStringList);
// procedura richiamata dalla funzione "gestioneErrori",
// che è il gestore generico degli errori javascript ed è
// dichiarata nel file "Files/js/FunzioniGenerali.js"
var
  Msg: String;
begin
  Msg:=EventParams.Values['err'];
  Log('Errore','Errore javascript: ' + Msg);
end;

//############################################//
//###               VARIE                  ###//
//############################################//

function TWR010FBase.RenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer; const Intestazione,RigheAlterne:Boolean; const EvidenziaRigaSel:Boolean = True): Boolean;
begin
  Result:=C190RenderCell(ACell,ARow,AColumn,Intestazione,RigheAlterne,EvidenziaRigaSel);
end;

function TWR010FBase.GetRighePaginaTabella: Integer;
// restituisce il numero di righe per pagina da impostare sulle tabelle
// considera l'impostazione su filtro funzioni e il parametro aziendale
var
  NumRighe: Integer;
begin
  // verifica che i dati di abilitazione siano stati letti
  if DatiAbilitazioni.Inibizione = #0 then
    DatiAbilitazioni:=A000GetAbilitazioniFunzioni('Tag',Tag.ToString);

  // NOTA: nel caso in cui il tag non venga trovato (ovvero i casi particolari)
  // il valore di RighePagina è 0, quindi viene utilizzato il parametro aziendale

  // valuta impostazione su filtro funzioni
  NumRighe:=DatiAbilitazioni.RighePagina;
  case NumRighe of
    -1: // nessuna paginazione
        begin
          Result:=-1;
        end;
    0:  // utilizza il valore del parametro aziendale
        begin
          Result:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
        end;
    1..MaxInt:
        // paginazione personalizzata
        begin
          Result:=NumRighe;
        end;
    else
    begin
      // valore non lecito: nessuna paginazione
      Result:=-1;
    end;
  end;
end;

//############################################//
//###        REPERIMENTO IP PUBBLICO       ###//
//############################################//

procedure TWR010FBase.OnPublicIPRicevuto(EventParams: TStringList);
// procedura richiamata nello script in jqPublicIP.js
// dichiarata nel file "wwwroot/js/jquery-iw/jqPublicIP.js"
var
  LMyForm, LStatus, LPublicIP, LTextStatus, LError, ResponseFunc: String;
  LStatusPar: TIPStatus;
const
  FUNZIONE = 'OnPublicIPRicevuto';
  STATUS_OK = 'OK';
  STATUS_ERR = 'ERR';
begin
  Log('Traccia',Format('%s: inizio',[FUNZIONE]));

  // estrae i parametri passati da javascript
  LMyForm:=EventParams.Values['myForm'];
  LStatus:=EventParams.Values['status'];
  LPublicIP:=EventParams.Values['publicIp'];
  LTextStatus:=EventParams.Values['textStatus'];
  LError:=EventParams.Values['error'];

  // logga i parametri per debug
  Log('Traccia',Format('%s: Parametri.ClientIPInfo.Status (prima) = [%s]',[FUNZIONE,GetEnumName(TypeInfo(TIPStatus),Integer(Parametri.ClientIPInfo.Status))]));
  Log('Traccia',Format('%s: myForm = [%s]',[FUNZIONE,LMyForm]));
  Log('Traccia',Format('%s: status = [%s]',[FUNZIONE,LStatus]));
  Log('Traccia',Format('%s: publicIp = [%s]',[FUNZIONE,LPublicIP]));
  Log('Traccia',Format('%s: textStatus = [%s]',[FUNZIONE,LTextStatus]));
  Log('Traccia',Format('%s: error = [%s]',[FUNZIONE,LError]));

  // se l'ip pubblico del client non è ancora stato determinato lo imposta
  if Parametri.ClientIPInfo.Status = isUndefined then
  begin
    if LStatus = STATUS_OK then
      LStatusPar:=isOk
    else if LStatus = STATUS_ERR then
      LStatusPar:=isError
    else
      raise Exception.Create(Format('%s: parametro "status" non valido: [%s]!',[FUNZIONE,LStatus]));

    // imposta i parametri per utilizzo lato server
    // il settaggio avviene in critical section per sicurezza
    CSParametri.Enter;
    try
      Parametri.ClientIPInfo.Status:=LStatusPar;
      Parametri.ClientIPInfo.IP:=IfThen(LStatusPar = isOk,LPublicIP,PUBLIC_IP_UNKNOWN);
    finally
      CSParametri.Leave;
    end;

    Log('Traccia',Format('%s: Parametri.ClientIPInfo.Status (dopo) = [%s]',[FUNZIONE,GetEnumName(TypeInfo(TIPStatus),Integer(Parametri.ClientIPInfo.Status))]));

    // se il controllo ip è attivo verifica abilitazioni
    if Parametri.CampiRiferimento.C90_W038CheckIP = 'S' then
    begin
      ImpostaAbilitazioniI076;
    end;

    // forza full submit per 2 motivi:
    // 1. visualizzare l'ip
    // e/o
    // 2. far recepire le abilitazioni sul menu e sulle icone di acesso rapido
    if GGetWebApplicationThreadVar.IsCallBack then
    begin
      Log('Traccia',Format('%s: callback',[FUNZIONE]));

      // il submit component è il link di refreshpage della form
      if lnkRefreshPage <> nil then
      begin
        // submitclick sul link di refreshpage
        ResponseFunc:=Format('SubmitClick("%s","",true); ',[lnkRefreshPage.HTMLName]);
        GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(ResponseFunc);
        Log('Traccia',Format('%s: %s',[FUNZIONE,ResponseFunc]));
      end;
    end;
  end;

  Log('Traccia',Format('%s: fine',[FUNZIONE]));
end;

//############################################//
//###         INFORMAZIONI DI DEBUG        ###//
//############################################//

procedure TWR010FBase.Log(const PTipo: String; const PMessaggio:String = ''; const PException: Exception = nil);
// registra il messaggio del tipo indicato nelle tabelle di log I005 / I006
var
  Ext,TestoLog: String;
begin
  if GGetWebApplicationThreadVar = nil then
    Exit;

  // blocco interamente protetto
  try
    // determina il codice form
    if FCodiceForm = 'W002' then
    begin
      // distinzione per W002
      if FNomeForm = 'W002FAnagrafeElenco' then
        Ext:='E'
      else if FNomeForm = 'W002FAnagrafeScheda' then
        Ext:='S'
      else if FNomeForm = 'W002FRicercaAnagrafe' then
        Ext:='R';
    end
    else
      Ext:=' ';

    TestoLog:=GetTestoLog(FCodiceForm + Ext,GGetWebApplicationThreadVar) + PMessaggio;

    // aggiunge dati eccezione
    if Assigned(PException) then
    begin
      TestoLog:=TestoLog +
                IfThen(PMessaggio <> '',' - ') +
                Format('%s(%s)',[PException.Message,PException.ClassName]);
    end;

    W000RegistraLog(PTipo,TestoLog.Trim,PException);
  except
  end;
end;

procedure TWR010FBase.LogConsole(PTesto: String; const PDebugOnly: Boolean = True);
// effettua il log del testo nella console del browser
// tramite il metodo javascript "console.log(...)"
var
  S: String;
const
  SOURCE_PREFIX = '[delphi] ';
begin
  {$WARN SYMBOL_PLATFORM OFF}
  if (not PDebugOnly) or (DebugHook <> 0) then
  {$WARN SYMBOL_PLATFORM ON}
  begin
    // non logga testo vuoto
    if PTesto.Trim = '' then
      Exit;

    if not PTesto.StartsWith(SOURCE_PREFIX) then
      PTesto:=SOURCE_PREFIX + PTesto;
    S:=Format('try { console.log("%s"); } catch(errore) {}',[PTesto]);
    if GGetWebApplicationThreadVar.CallBackProcessing then
      GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(S)
    else
      AddToInitProc(S);
  end;
end;

procedure TWR010FBase.LogConsoleTime(const PTesto: String; PStartTime: TDateTime; const PDebugOnly: Boolean = True);
var
  LTempo,LStr: String;
const
  SOURCE_PREFIX = '[delphi] ';
  TEXT_LENGTH   = 60;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  if (not PDebugOnly) or (DebugHook <> 0) then
  {$WARN SYMBOL_PLATFORM ON}
  begin
    LTempo:=FormatDateTime('ss.zzz',Now - PStartTime);
    LStr:=Format('%-*s: %s s',[TEXT_LENGTH,SOURCE_PREFIX + PTesto,LTempo]);
    LogConsole(LStr,PDebugOnly);
  end;
end;

procedure TWR010FBase.OnDebugInfo(EventParams: TStringList);
// procedura richiamata da codice javascript
// per estrarre informazioni di debug
var
  S: String;
begin
  if GGetWebApplicationThreadVar.CallbackProcessing then
  begin
    S:=GetInfoDebug;
    if Trim(S) = '' then
      S:='Nessuna informazione di debug specificata';
    //GGetWebApplicationThreadVar.ShowMessage(S);
    DebugClear;
    DebugAdd(S);
    DebugShow;
    DebugClear;
  end;
end;

function TWR010FBase.GetInfoDebug: String;
// ridefinire
begin
  Result:='';
end;

procedure TWR010FBase.DebugAdd(const PTipo, PTesto: String; const PNomeComp: String = '');
var
  S, Msg: String;
begin
  if Assigned(FDebugList) then
  begin
    // testo messaggio
    Msg:=PTesto;
    if PNomeComp <> '' then
      Msg:=Format('%s: %s',[PNomeComp,Msg]);

    // determina errori bloccanti
    FCompError:=PTipo = 'E';

    // span per visualizzazione
    if PTipo = 'A' then
      S:='acc'
    else if PTipo = 'W' then
      S:='warn'
    else if PTipo = 'E' then
      S:='err'
    else if PTipo = 'I' then
      S:='info';
    Msg:=StringReplace(Msg,' ','&nbsp;',[rfReplaceAll]);
    Msg:=Format('<span class="%s">%s</span>',[S,Msg]);

    FDebugList.Add(Msg);
  end;
end;

procedure TWR010FBase.DebugAdd(const PTesto: String);
begin
  DebugAdd('I',PTesto);
end;

procedure TWR010FBase.DebugShow;
var
  Code, S: String;
begin
  if (jqDebug.Enabled) and
     (Assigned(FDebugList)) and
     (FDebugList.Count > 0) then
  begin
    Code:=CRLF +
      '/* jqDebug */' + CRLF +
      '$("<div id=\"r010_debug\" class=\"invisibile\"><div id=\"r010_img_close\" onClick=\"$(''#r010_debug'').toggle();\"/>%s<\/div>").insertBefore("#separa_footer").fadeIn(); ';
    S:=StringReplace(FDebugList.Text,CRLF,'<br>',[rfReplaceAll]);
    Code:=Format(Code,[C190EscapeJs(S)]);

    // gestione in base al tipo di chiamata (async / full submit)
    if GGetWebApplicationThreadVar.CallbackProcessing then
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Code)
    else
      jqDebug.OnReady.Text:=Code;
  end;
end;

procedure TWR010FBase.DebugClear;
begin
  if Assigned(FDebugList) then
    FDebugList.Clear;
end;

procedure TWR010FBase.OnInviaBugReport(EventParams: TStringList);
// procedura richiamata nello script prodotto in
// TA000FInterfaccia.IWServerControllerBaseException
var
  LBugReport, ResponseFunc: String;
const
  FUNZIONE = 'TWR010FBase.OnInviaBugReport';
begin
  Log('Traccia',Format('%s: inizio',[FUNZIONE]));

  // estrae i parametri passati da javascript
  LBugReport:=EventParams.Values['report'];

  if GGetWebApplicationThreadVar.CallbackProcessing then
  begin
    //ResponseFunc:=Format('SubmitClick("%s","",true); ',[lnkRefreshPage.HTMLName]);
    ResponseFunc:=Format('$("#btn-inviareport").button("option","label","Segnalazione inviata" );',[]);
    GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(ResponseFunc);
  end;
  Log('Traccia',Format('%s: fine',[FUNZIONE]));
end;

//############################################//
//###        INVIO DI FILE AL CLIENT       ###//
//############################################//

procedure TWR010FBase.btnSendFileClick(Sender: TObject);
begin
  GGetWebApplicationThreadVar.SendFile(DCOMNomeFile,true,'application/x-download',ExtractFileName(DCOMNomeFile))
end;

procedure TWR010FBase.VisualizzaFileWeb;
begin
  //invio il pdf, se esiste, al browser
  if FileExists(DCOMNomeFile) then
  begin
    Msgbox.MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
    addToInitProc(Format('SubmitClick("%s", "", true);',[btnSendFile.HTMLname]));
  end
  else
    Msgbox.MessageBox(A000MSG_ERR_FILE_NON_CREATO,ERRORE)
end;

procedure TWR010FBase.CampiNascosti;
var
  i,j,p: Integer;
  S,NomeComp,NomeContenitore: String;
  CercaInForm,CercaInFrame: Boolean;
  IWC: TComponent;
  IWF: TFrame;
begin
  // campi nascosti
  if (WR000DM <> nil) and
     (WR000DM.lstCompInvisibili <> nil) and
     (WR000DM.lstCompInvisibili.Count > 0) then
  begin
    for i:=0 to WR000DM.lstCompInvisibili.Count - 1 do
    begin
      S:=WR000DM.lstCompInvisibili[i];
      p:=Pos('.',S);
      if p = 0 then
      begin
        // formato [componente]
        NomeContenitore:='';
        NomeComp:=S;
      end
      else
      begin
        // formato [contenitore.componente]
        NomeContenitore:=Copy(S,1,p - 1);
        NomeComp:=Copy(S,p + 1);
      end;

      // determina il campo di ricerca del nome componente
      CercaInForm:=(NomeContenitore = '') or (UpperCase(NomeContenitore) = UpperCase(medpNomeForm));
      CercaInFrame:=(NomeContenitore = '') or (not CercaInForm);

      // effettua ricerca del componente
      IWC:=nil;

      // 1. cerca nel form (form + region + grid)
      if CercaInForm then
      begin
        IWC:=Self.FindComponent(NomeComp);
        if (IWC <> nil) and (IWC is TIWCustomControl) then
          (IWC as TIWCustomControl).Css:='invisibile';
      end;

      // 2. cerca nei frame (o se definito in un frame specifico)
      if CercaInFrame then
      begin
        if NomeContenitore = '' then
        begin
          // cerca il nome componente in tutti i frame della form
          // (per comodità cerca in FrameArr)
          for j:=0 to High(FrameArr) do
          begin
            if Assigned(FrameArr[j]) then
            begin
              IWC:=FrameArr[j].FindComponent(NomeComp);
              if (IWC <> nil) and (IWC is TIWCustomControl) then
                (IWC as TIWCustomControl).Css:='invisibile';
            end;
          end;
        end
        else
        begin
          // cerca il componente in un frame specifico
          IWF:=Self.FindFrame(NomeContenitore);
          if IWF <> nil then
            IWC:=IWF.FindComponent(NomeComp);
            if (IWC <> nil) and (IWC is TIWCustomControl) then
              (IWC as TIWCustomControl).Css:='invisibile';
        end;
      end;
    end;
  end;
end;

function TWR010FBase.GetIsCampoNascosto(Comp:String):Boolean;
var i,p:Integer;
    S,NomeContenitore,NomeComp:String;
begin
  Result:=False;
  // campi nascosti
  if (WR000DM <> nil) and
     (WR000DM.lstCompInvisibili <> nil) and
     (WR000DM.lstCompInvisibili.Count > 0) then
  begin
    for i:=0 to WR000DM.lstCompInvisibili.Count - 1 do
    begin
      S:=WR000DM.lstCompInvisibili[i];

      p:=Pos('.',S);
      if p = 0 then
      begin
        // formato [componente]
        NomeContenitore:='';
        NomeComp:=S;
      end
      else
      begin
        // formato [contenitore.componente]
        NomeContenitore:=Copy(S,1,p - 1);
        NomeComp:=Copy(S,p + 1);
      end;

      if UpperCase(Comp) = UpperCase(NomeComp) then
      begin
        Result:=(NomeContenitore = '') or (UpperCase(NomeContenitore) = UpperCase(medpNomeForm));
        if Result then
          Break;
      end;
    end;
  end;
end;

procedure TWR010FBase.AssegnaGestPeriodo(PEditInizio, PEditFine: TmeIWEdit);
begin
  // Su XE4 non compila se non effettuo il cast di nil a TGestPeriodoClick
  AssegnaGestPeriodo(PEditInizio,PEditFine,nil,nil,TGestPeriodoClick(nil),TGestPeriodoClick(nil));
end;

procedure TWR010FBase.AssegnaGestPeriodo(PEditInizio, PEditFine: TmeIWEdit; PImgPrec, PImgSucc: TmeIWImageFile);
begin
  // Su XE4 non compila se non effettuo il cast di nil a TGestPeriodoClick
  AssegnaGestPeriodo(PEditInizio,PEditFine,PImgPrec,PImgSucc,TGestPeriodoClick(nil),TGestPeriodoClick(nil));
end;

procedure TWR010FBase.AssegnaGestPeriodo(PEditInizio, PEditFine: TmeIWEdit; PImgPrec, PImgSucc: TmeIWImageFile; PImgPrecAzioneCustomOnClick, PImgSuccAzioneCustomOnClick: TGestPeriodoClick; PEdtPeriodoAzioneCustomOnChange: TGestPeriodoClick = nil);
var
  i: Integer;
  LFromName: String;
  LToName: String;
  LJSCode: String;
  LCss: String;
  LErrOnClickMsg:String;
  LPulsantiNavigazione,LGestioneSync,LErrore: Boolean;
begin
  LErrOnClickMsg:='Non è possibile specificare direttamente l''handler di OnClick per questo elemento.' +
                  ' Se si vuole specificare un''azione sull''evento OnClick specificare il puntatore a metodo' +
                  'come parametro %s e lasciare vuoto l''evento OnClick del componente.';
  LErrore:=False;
  // Su IW12 se sono specificati sia l'evento OnClick che OnAsyncClick la chiamata JS per OnClick veniva sovrascritta
  // e restava attiva solo quella sfruttata da OnAsyncClick. Successivamente veniva manualmente generata la richiesta
  // di un submit del form nel caso fosse specificato l'evento OnClick, tutto quindi funzionava regolarmente.
  // Su IW14 si ottenevano invece comportamenti inattesi, perchè lato JS entrambi gli eventi sono registrati sull'evento click e
  // sono entrambi attivi. Alle volte capitava che la chiamata callback partisse e venisse troncata a causa del submit, altre volte non veniva eseguita
  // affatto.
  // La nuova gestione prevede che:
  // - se non sono presenti eventi da eseguire su OnClick, avviene tutto via AJAX
  // - nel caso contrario la gestione diviene sync (full submit)

  if Assigned(PImgPrec) then // Boolean short-circuit evaluation potrebbe non essere abilitata
  begin
    if Assigned(PImgPrec.OnClick) then
    begin
      DebugAdd('E',Format(LErrOnClickMsg,['PImgPrecAzioneCustomOnClick']),PImgPrec.Name);
      LErrore:=True;
    end;
  end;
  if Assigned(PImgSucc) then // Boolean short-circuit evaluation potrebbe non essere abilitata
  begin
    if Assigned(PImgSucc.OnClick) then
    begin
      DebugAdd('E',Format(LErrOnClickMsg,['PImgSuccAzioneCustomOnClick']),PImgSucc.Name);
      LErrore:=True;
    end;
  end;
  if LErrore then
    Exit;

  // prepara il nuovo elemento della struttura dati che contiene le info sul periodo
  SetLength(FCompPeriodoArr, Length(FCompPeriodoArr) + 1);
  i:=High(FCompPeriodoArr);

  LPulsantiNavigazione:=Assigned(PImgPrec) and Assigned(PImgSucc);
  LGestioneSync:=(Assigned(PImgPrecAzioneCustomOnClick)) or (Assigned(PImgSuccAzioneCustomOnClick));

  // assegna i componenti del periodo ad una apposita struttura dati

  // data inizio periodo
  FCompPeriodoArr[i].EditInizio:=PEditInizio;
  FCompPeriodoArr[i].EditInizio.Tag:=i;
  LCss:=FCompPeriodoArr[i].EditInizio.Css.Trim;
  if not LCss.Contains('input_data_dmy') then
    LCss:=LCss + 'input_data_dmy';
  if (LPulsantiNavigazione) and (not LCss.Contains('periodoInizio')) then
    LCss:=LCss + ' periodoInizio';
  FCompPeriodoArr[i].EditInizio.Css:=LCss.Trim;

  // data fine periodo
  FCompPeriodoArr[i].EditFine:=PEditFine;
  FCompPeriodoArr[i].EditFine.Tag:=i;
  LCss:=FCompPeriodoArr[i].EditFine.Css.Trim;
  if not LCss.Contains('input_data_dmy') then
    LCss:=LCss + 'input_data_dmy';
  if (LPulsantiNavigazione) and (not LCss.Contains('periodoFine')) then
    LCss:=LCss + ' periodoFine';
  FCompPeriodoArr[i].EditFine.Css:=LCss.Trim;

  if Assigned(PEdtPeriodoAzioneCustomOnChange) then
  begin
    if not Assigned(FCompPeriodoArr[i].EditInizio.OnAsyncChange) and not Assigned(FCompPeriodoArr[i].EditFine.OnAsyncChange) then
    begin
      FCompPeriodoArr[i].EdtPeriodoAzioneCustomOnChange:=PEdtPeriodoAzioneCustomOnChange;
      FCompPeriodoArr[i].EditInizio.OnAsyncChange:=OnGestPeriodoAsyncChange;
      FCompPeriodoArr[i].EditFine.OnAsyncChange:=OnGestPeriodoAsyncChange;
    end;
  end;

  // pulsante / immagine per navigazione periodo precedente
  FCompPeriodoArr[i].ImgPrec:=PImgPrec;
  if Assigned(PImgPrec) then
  begin
    FCompPeriodoArr[i].ImgPrec.Tag:=i;
    FCompPeriodoArr[i].ImgPrecAzioneCustomOnClick:=PImgPrecAzioneCustomOnClick;
    if not LGestioneSync then
    begin
      // Nessuna azione che richiede submit, gestisco tutto via callback
      FCompPeriodoArr[i].ImgPrec.OnAsyncClick:=OnGestPeriodoSpostaAsyncClick;
      FCompPeriodoArr[i].ImgPrec.OnAsyncMouseMove:=OnGestPeriodoAsyncMouseMove;
    end
    else
    begin
      // Azione custom sull'evento OnClick, si passa a gestione via submit
      FCompPeriodoArr[i].ImgPrec.OnClick:=OnGestPeriodoClick;
    end;
    if (Trim(FCompPeriodoArr[i].ImgPrec.ImageFile.Filename) = '') and (FCompPeriodoArr[i].ImgPrec.ImageFile.URL.Trim = '') then
      FCompPeriodoArr[i].ImgPrec.ImageFile.Filename:=filebtnPrec;
    FCompPeriodoArr[i].ImgPrec.AltText:='Periodo precedente';
    FCompPeriodoArr[i].ImgPrec.Css:='imgSpostaPeriodo';
    FCompPeriodoArr[i].ImgPrec.Hint:='Periodo precedente';
    FCompPeriodoArr[i].ImgPrec.ShowHint:=True;
  end;

  // pulsante / immagine per navigazione periodo successivo
  FCompPeriodoArr[i].ImgSucc:=PImgSucc;
  if Assigned(PImgSucc) then
  begin
    FCompPeriodoArr[i].ImgSucc.Tag:=i;
    FCompPeriodoArr[i].ImgSuccAzioneCustomOnClick:=PImgSuccAzioneCustomOnClick;
    if not LGestioneSync then
    begin
      // Nessuna azione che richiede submit, gestisco tutto via callback
      FCompPeriodoArr[i].ImgSucc.OnAsyncClick:=OnGestPeriodoSpostaAsyncClick;
      FCompPeriodoArr[i].ImgSucc.OnAsyncMouseMove:=OnGestPeriodoAsyncMouseMove;
    end
    else
    begin
      // Azione custom sull'evento OnClick, si passa a gestione via submit
      FCompPeriodoArr[i].ImgSucc.OnClick:=OnGestPeriodoClick;
    end;
    if (Trim(FCompPeriodoArr[i].ImgSucc.ImageFile.Filename) = '') and (FCompPeriodoArr[i].ImgSucc.ImageFile.URL.Trim = '') then
      FCompPeriodoArr[i].ImgSucc.ImageFile.Filename:=filebtnSucc;
    FCompPeriodoArr[i].ImgSucc.AltText:='Periodo successivo';
    FCompPeriodoArr[i].ImgSucc.Css:='imgSpostaPeriodo';
    FCompPeriodoArr[i].ImgSucc.Hint:='Periodo successivo';
    FCompPeriodoArr[i].ImgSucc.ShowHint:=True;
  end;

  LFromName:=Format('from%s',[FCompPeriodoArr[i].EditInizio.HTMLName]);
  LToName:=Format('to%s',[FCompPeriodoArr[i].EditInizio.HTMLName]);

  LJSCode:=
    // data inizio periodo
    Format(
    'var %s = jQuery.root.find("#%s:not([readonly])") '#13#10, [LFromName, FCompPeriodoArr[i].EditInizio.HTMLName]) +
    '  .datepicker(pickerOpts) '#13#10 +
    '  .datepicker("option","onSelect",function(selectedDate){ ' + #13#10 +
    Format(
    '    if ((%s) && (%s.length)) { '#13#10, [LToName, LToName]) +
    Format(
    //     se la data fine è vuota, la imposta uguale alla data inizio
    '      if ((%s.val() == "") || (%s.val() == "__/__/____")) { '#13#10 +
    '        %s.val(selectedDate); '#13#10 +
    '      } '#13#10, [LToName, LToName, LToName]) +
    //     associa il datepicker alla data di fine periodo, impostando il vincolo sulla minDate
    Format(
    '      %s.datepicker("option", "minDate", selectedDate); '#13#10, [LToName]) +
    '    } '#13#10 +
    '  }); '#13#10 +

    // data fine periodo
    Format(
    'var %s = jQuery.root.find("#%s:not([readonly])") '#13#10, [LToName, FCompPeriodoArr[i].EditFine.HTMLName]) +
    '  .datepicker(pickerOpts) '#13#10 +
    '  .datepicker("option","onSelect",function(selectedDate){ ' + #13#10 +
    Format(
    '    if ((%s) && (%s.length)) { '#13#10, [LFromName, LFromName]) +
    //     associa il datepicker alla data di inizio periodo, impostando il vincolo sulla maxDate
    Format(
    '      %s.datepicker("option", "maxDate", selectedDate); '#13#10, [LFromName]) +
    '    } '#13#10 +
    '  }); '#13#10;

  // protegge il codice in un blocco try - catch
  LJSCode:=Format(
    'try { '#13#10 +
    '  %s '#13#10 +
    '} '#13#10 +
    'catch(err) { '#13#10 +
    '  gestioneErrori(err.message + "|" + "jqCalendarioPeriodo","",0); '#13#10 +
    '} '#13#10,
    [LJSCode]);
  jqCalendarioPeriodo.Enabled:=True;
  jqCalendarioPeriodo.OnReady.Add(LJSCode);
end;

function TWR010FBase.GetCompPeriodoByControl(PControl: TObject): TCompPeriodo;
var
  x: Integer;
begin
  // verifica dati input
  if not ((PControl is TmeIWEdit) or (PControl is TmeIWImageFile)) then
    Exit;

  x:=(PControl as TIWCustomControl).Tag;
  if not R180Between(x,Low(FCompPeriodoArr),High(FCompPeriodoArr)) then
    Exit;

  // estrae info periodo corrispondente
  Result:=FCompPeriodoArr[x];
end;

procedure TWR010FBase.SetCompPeriodo_EseguiSubmit(PControl: TObject; const PValue: Boolean);
var
  x: Integer;
begin
  // verifica dati input
  if not ((PControl is TmeIWEdit) or (PControl is TmeIWImageFile)) then
    Exit;

  x:=(PControl as TIWCustomControl).Tag;
  if not R180Between(x,Low(FCompPeriodoArr),High(FCompPeriodoArr)) then
    Exit;

  // estrae info periodo corrispondente
  FCompPeriodoArr[x].EseguiSubmit:=PValue;
end;

procedure TWR010FBase.OnGestPeriodoAsyncMouseMove(Sender: TObject; EventParams: TStringList);
var
  LCompPeriodo: TCompPeriodo;
  LOffset: TOffsetPeriodo;
begin
  LCompPeriodo:=GetCompPeriodoByControl(Sender);
  LOffset:=LCompPeriodo.GetPeriodo.GetPatternPeriodo;
  LCompPeriodo.SetPeriodoHint(LOffset.ToString);
end;

procedure TWR010FBase.OnGestPeriodoSpostaAsyncClick(Sender: TObject; EventParams: TStringList);
var
  LCompPeriodo: TCompPeriodo;
  LSpostaAvanti: Boolean;
  LPeriodoNew: TPeriodo;
  LJSCode: String;
  LComponents: String;
  LComp: String;
const
  HIGHLIGHT_TIME = 2000;
begin
  if not (Sender is TmeIWImageFile) then
    Exit;

  // estrae info periodo corrispondente
  LCompPeriodo:=GetCompPeriodoByControl(Sender);
  LSpostaAvanti:=(Sender = LCompPeriodo.ImgSucc);

  // calcola il nuovo periodo dopo lo shift
  LPeriodoNew:=LCompPeriodo.GetPeriodo.ShiftPeriodo(LSpostaAvanti,True);

  // riporta il nuovo periodo nei corrispondenti edit
  LCompPeriodo.EditInizio.Text:=LPeriodoNew.Inizio.ToString('dd/mm/yyyy');
  LCompPeriodo.EditFine.Text:=LPeriodoNew.Fine.ToString('dd/mm/yyyy');


  // Se siamo in modalità sync entrambi i pulsanti hanno un handler registrato per OnClick.
  // In tal caso non eseguiamo JS via callback.
  if Assigned((Sender as TmeIWImageFile).OnClick) then
    Exit;

  // Siamo in modalità async, generiamo il JS e chiediamo al client di eseguirlo.
  LJSCode:=Format('$("#%s").trigger("change"); '#13#10 +
                  '$("#%s").trigger("change"); '#13#10,
                  [LCompPeriodo.EditInizio.HTMLName,
                   LCompPeriodo.EditFine.HTMLName]);

  // effetto highlight sui campi di testo per evidenziare il cambio periodo
  // (il metodo stop è richiesto per fermare l'eventuale animazione già in corso)
  LComponents:=LCompPeriodo.EditInizio.HTMLName + ',' + LCompPeriodo.EditFine.HTMLName;
  for LComp in LComponents.Split([',']) do
    LJSCode:=LJSCode + Format('$("#%s").stop(true, true).effect("highlight",%d);'#13#10,[LComp,HIGHLIGHT_TIME]);

  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(LJsCode);
end;

procedure TWR010FBase.OnGestPeriodoClick(Sender: TObject);
var
  LCompPeriodo: TCompPeriodo;
  LSpostaAvanti:Boolean;
  CustomOnClickDaEseguire:TGestPeriodoClick;
begin
  // Modalita sync
  if not (Sender is TmeIWImageFile) then
    Exit;
  LCompPeriodo:=GetCompPeriodoByControl(Sender);
  LSpostaAvanti:=(Sender = LCompPeriodo.ImgSucc);

  OnGestPeriodoSpostaAsyncClick(Sender,nil);
  OnGestPeriodoAsyncMouseMove(Sender,nil);

  // Se abbiamo handler custom li eseguiamo.
  CustomOnClickDaEseguire:=nil;
  if not LSpostaAvanti then
    CustomOnClickDaEseguire:=LCompPeriodo.ImgPrecAzioneCustomOnClick
  else
    CustomOnClickDaEseguire:=LCompPeriodo.ImgSuccAzioneCustomOnClick;
  if Assigned(CustomOnClickDaEseguire) then
    CustomOnClickDaEseguire(Sender);
end;

procedure TWR010FBase.OnGestPeriodoAsyncChange(Sender: TObject; EventParams: TStringList);
var
  dApp: TDateTime;
  LCompPeriodo: TCompPeriodo;
begin
  if not TryStrToDate(TmeIWEdit(Sender).Text,dApp) then
    exit;
  SetCompPeriodo_EseguiSubmit(Sender,True);
  LCompPeriodo:=GetCompPeriodoByControl(Sender);
  LCompPeriodo.EdtPeriodoAzioneCustomOnChange(Sender);
  LCompPeriodo:=GetCompPeriodoByControl(Sender);
  if LCompPeriodo.EseguiSubmit then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[TmeIWEdit(Sender).HTMLName]));
end;

function TWR010FBase.GetAJAXFormID:String;
begin
  Result:=edtAJAXFormID.Text;
end;

procedure TWR010FBase.RegistraMetodoAJAX(IDMetodoJS:String; MetodoDelphi:TMetodoAJAX);
var
  NumElem:Integer;
  NuovaMemoAjax:TmeIWMemo;
  GestoreChiamata:TGestoreChiamataAJAX;
  MetodoEsistente:Boolean;
  i:Integer;
begin
  // Verifico che non esista già un gestore per questo metodo
  IDMetodoJS:=GetAJAXFormID + IDMetodoJS;
  MetodoEsistente:=false;
  for i:=0 to (Length(GestoriChiamateAJAX) - 1) do
  begin
    if (Lowercase(GestoriChiamateAJAX[i].IDMetodoJS)=Lowercase(IDMetodoJS)) then
    begin
        MetodoEsistente:=true;
        break;
    end;
  end;
  if MetodoEsistente then
    raise Exception.Create(Format('Impossibile registrare il metodo AJAX "%s". Nome del metodo già in uso in questa form!',[IDMetodoJS]));

  // Creo la memo nascosta che contiene i parametri della chiamata
  NumElem:=grdMemoAjax.RowCount;
  grdMemoAjax.RowCount:=NumElem + 1;
  NuovaMemoAjax:=TmeIWMemo.Create(Self);
  NuovaMemoAjax.Name:=IDMetodoJS;
  NuovaMemoAjax.Editable:=false;
  grdMemoAjax.Cell[NumElem,0].Control:=NuovaMemoAjax;
  // Creo il gestore per questa chiamata AJAX
  GestoreChiamata:=TGestoreChiamataAJAX.Create(Self, IDMetodoJS, MetodoDelphi);
  // Aggiungo il gestore all'array interno
  NumElem:=Length(GestoriChiamateAJAX);
  SetLength(GestoriChiamateAJAX, NumElem + 1);
  GestoriChiamateAJAX[NumElem]:=GestoreChiamata;
  // Associo l'ID JS con il metodo Delphi
  GestoreChiamata.Registra;
end;

procedure TWR010FBase.AggiungiPluginJavaScript(const IDPlugin:String; CustomErrMsgVerBrowser:String = '');
begin
  SetLength(Self.PluginsJavaScript, Length(Self.PluginsJavaScript) + 1);
  Self.PluginsJavaScript[Length(Self.PluginsJavaScript)-1].ID:=IDPlugin;
  Self.PluginsJavaScript[Length(Self.PluginsJavaScript)-1].ErrVersioneBrowser:=CustomErrMsgVerBrowser;
end;

{ TCompPeriodo }

function TCompPeriodo.GetPeriodo: TPeriodo;
// estrae il periodo contenuto negli edit
begin
  // data di inizio
  if Trim(EditInizio.Text) = '' then
    Result.Inizio:=DATE_NULL
  else if not TryStrToDate(EditInizio.Text,Result.Inizio) then
    raise ExceptionNoLog.CreateFmt('La data di inizio periodo non è valida: %s',[EditInizio.Text]);

  // data di fine periodo
  if Trim(EditFine.Text) = '' then
    Result.Fine:=DATE_NULL
  else if not TryStrToDate(EditFine.Text,Result.Fine) then
    raise ExceptionNoLog.CreateFmt('La data di fine periodo non è valida: %s',[EditFine.Text]);
end;

procedure TCompPeriodo.SetPeriodoHint(const PHint: String);
begin
  ImgPrec.Hint:=Format('%s prec.',[PHint]);
  ImgSucc.Hint:=Format('%s succ.',[PHint]);
end;

end.
