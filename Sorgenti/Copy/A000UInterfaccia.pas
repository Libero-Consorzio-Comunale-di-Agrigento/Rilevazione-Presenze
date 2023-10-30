unit A000UInterfaccia;

{$IFDEF IRISWEB}
{$IFNDEF WEBSVC}
interface

uses
  {$IFDEF madExcept}
  madExcept,
  {$ENDIF madExcept}
  A000Versione, A000UCostanti, A000USessione, A000UMessaggi,
  FunzioniGenerali, C180FunzioniGenerali, C190FunzioniGeneraliWeb, medpIWMessageDlg,
  {$IFDEF WEBPJ}A000UIrisWebDM,
  {$ELSE}
    {$IFDEF X001}X001UCentriCostoDtM,
    {$ELSE}
      {$IFDEF INTRAWEBSVC}
      {$ELSE}W001UIrisWebDtM,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  WR000UBaseDM,
  WC000UServerAdmin,
  WC000UConfigIni,
  WC000UErrLimiteSessioni,
  WC000UFiles,
  QueryPK, RegistrazioneLog,
  Windows, SysUtils, Classes, Math, StrUtils, IOUtils,
  Forms, //Alberto 26/02/2021: Serve per gestire l'oggetto Application, che a sua volta serve per gestire le eccezioni sul destroy dei datamodule
  IW.Http.Request, IW.Http.Reply,
  IWServerControllerBase, IWBaseForm, RpDefine,
  IWApplication, IWInit, IW.Common.System, Data.DB, Oracle, OracleData, OracleCI,
  SyncObjs, Variants, ActiveX, Contnrs, PsAPI, System.TypInfo,
  IW.Browser.Browser,IW.Browser.InternetExplorer,IW.Browser.Safari,
  IW.Browser.Chrome, IW.Browser.Firefox, IW.Browser.Opera, IW.Browser.Edge,
  IniFiles, Generics.Collections, Winapi.Messages, IW.Http.Cookie
  { DONE : TEST IW 14 OK }
  (*IWURLResponderBase, IWURLResponder*),IW.Content.Handlers,IWMimeTypes,
  System.Rtti, IW.Parser.Files
  {$IFDEF INTRAWEBSVC}
  ,B021UContentHandler
  {$ENDIF}
  (* MAN/07 SVILUPPO#84*) , HTTPApp;

type
  TPluginJavaScriptConfig = record
    ID,Descrizione,PathFileJS,ErrVersioneBrowser: String;
    VerMinIE, VerMinChrome, VerMinFirefox, VerMinEdge: Integer;
  end;

  TmedpFieldHelper = class helper for TField
  public
    function medpOldValue: Variant;
  end;

const
  SPAZIO: String = ' ';

  // ricerca anagrafica
  RICERCA_NULL   = 99999999;
  POSIZIONE_NULL = 99999999;
  ELEMENTI_HISTORY = 7;
  DOCTYPE_HTML = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">';

  // path relativi per gestione interna
  PATH_BASE_CSS            = 'css/';
  PATH_BASE_JS             = 'js/';
  PATH_BASE_JS_LOCAL       = 'js\';
  PATH_BASE_JS_SPEC        = 'js/spec/';
  PATH_BASE_JS_SPEC_LOCAL  = 'js\spec\';
  PATH_BASE_CSS_SPEC       = 'css/spec/';
  PATH_BASE_CSS_SPEC_LOCAL = 'css\spec\';
  PATH_CACHE               = 'Archivi\Cache';
  PATH_HELP                = {$IFDEF WEBPJ}
                               {$IFDEF PAGHE}
                               'helpCloudStipendi'
                               {$ELSE}
                               'helpCloudRilPre'
                               {$ENDIF}
                             {$ELSE}
                             'help'
                             {$ENDIF};
  PATH_TEMPLATE            = {$IFDEF X001}
                             'TemplatesX001'
                             {$ELSE}{$IFDEF WEBPJ}
                             'TemplatesCloud\Templates'
                             {$ELSE}
                             'TemplatesWeb\Templates'
                             {$ENDIF}
                             {$ENDIF};
  PATH_TEMPLATE_CONDIVISI  = 'TemplatesCondivisi\';
  PATH_USR_FILES           = 'Archivi\usr_files\';

  JQUERY_UI_VER = '1.10.3';
  FILES_CSS: array [1..2] of String = (
    'cupertino/jquery-ui-%JQUERY_UI_VER%.custom.min.css',  // css del tema selezionato per jquery-ui
    {$IFDEF WEBPJ}
    'webplus_nc.min.css'                                   // file css per i progetti web (dettaglio qui sotto)
    {$ELSE}
    'webbase_nc.min.css'                                   // file css per Irisweb (dettaglio qui sotto. Nota: viene escluso IrisWeb02.css)
    {$ENDIF}
    );
  FILES_CSS_DEBUG: array [1..{$IFDEF WEBPJ}9{$ELSE}8{$ENDIF}] of String = (
    'cupertino/jquery-ui-%JQUERY_UI_VER%.custom.min.css',  // css del tema selezionato per jquery-ui
    'IrisWeb01.css',                                       // css generici per irisweb e webproject
    {$IFDEF WEBPJ} 'IrisWeb02.css',{$ENDIF}                // css propri di webproject
    'IrisWeb_jquery-ui.css',                               // classi ridefinite per ritoccare i default di jquery ui
    //                                                     // css per i plugin jquery (in ordine alfabetico)
    'jquery.medp.dropdown.css',                            //   - jQuery Dropdown
    'jquery.gritter.css',                                  //   - gritter
    'jPicker-1.1.6.css',                                   //   - jpicker
    'jquery.watermarkinput.css',                           //   - watermark
    'ui.jqgrid.css'                                        //   - jqGrid
    );

  FILES_JS: array [1..1] of String = (
    'web_nc.min.js'                                        // funzioni javascript accorpate (dettaglio qui sotto)
    );
  FILES_JS_DEBUG: array [1..20] of String = (
    'jquery-migrate-1.4.1.min.js',                         // jquery Migrate
    'jquery-ui-%JQUERY_UI_VER%.custom.min.js',             // jquery UI
    'FunzioniGenerali.js',                                 // funzioni mondoedp
    'common.js',                                           // funzioni comuni mondoedp
    'date-it-IT.js',                                       // utility per data/ora formato italiano           - http://code.google.com/p/datejs
    'medpIWMultiColumnComboBox.js',                        // funzioni componente medpIWMultiColumnComboBox
    //                                                     // javascript dei plugin jquery (in ordine alfabetico)
    'jquery-plugins/autoNumeric-1.7.4-B.js',               //   - input per numeri (autonumeric)              - http://www.decorplanit.com/plugin/
    'jquery-plugins/jquery.capitalize.js',                 //   - testo maiuscolo / minuscolo
    'jquery-plugins/jquery.contextMenu.js',                //   - menu contestuale                            - http://www.abeautifulsite.net/blog/2008/09/jquery-context-menu-plugin/#features - non esiste pi� :-(
    'jquery-plugins/jquery.cookie.js',                     //   - cookie persistence
    'jquery-plugins/jquery.easing.1.3.js',                 //   - jquery easing plugin                        - http://gsgd.co.uk/sandbox/jquery/easing/
    'jquery-plugins/jquery.gritter.js',                    //   - notifiche stile growl (mac)                 - http://boedesign.com/blog/2009/07/11/growl-for-jquery-gritter/
    // 'jquery-plugins/jquery.maskedinput-1.3.js',         //   - masked edit (INTEGRATO DA IW 12.2.6)        - http://digitalbush.com/projects/masked-input-plugin/
    'jquery-plugins/jquery.metadata.js',                   //   - propedeutico per autonumeric
    'jquery-plugins/jquery.mousewheel.js',                 //   - mousewheel                                  - https://github.com/brandonaaron/jquery-mousewheel
    'jquery-plugins/jquery.tools.min.js',                  //   - tooltip jqueryTools                         - http://flowplayer.org/tools/tooltip/index.html
    'jquery-plugins/jquery.ui.combobox.js',                //   - jquery ui autocomplete con funzione combo   - http://jqueryui.com/demos/autocomplete/#combobox
    'jquery-plugins/jquery.validator.js',                  //   - validazione dati (email, date, ...)         - http://igorgladkov.com/jquery/validator.html
    'jquery-plugins/jquery.watermarkinput.js',             //   - watermark                                   - http://digitalbush.com/projects/watermark-input-plugin/
    'jquery-plugins/jpicker-1.1.6.js',                     //   - color picker
    'clockscript.js'                                       //   - data + ora                                  - http://tutorialzine.com/2013/06/digital-clock/
    );

  WEB_BROWSER_ICON = {$IFDEF WEBPJ}
    'img\webicon_iriscloud.png'
  {$ELSE}
    'img\webicon_irisweb.png'
  {$ENDIF WEBPJ};

  META_HTML_IE8 : String = '<meta http-equiv="X-UA-Compatible" content="IE=8" />';
  PLUGINS_JAVASCRIPT: array[0..3] of TPluginJavaScriptConfig = (
    (ID: 'JQGRID_LOCALE_IT';       Descrizione: 'Localizzazione italiana per jqGrid';     PathFileJS: 'jquery-plugins-opt/jqgrid.locale-it.js';
     ErrVersioneBrowser: 'Non caricato in quanto il browser in uso &egrave; obsoleto e non supporta jqGrid.';
     VerMinIE: 9;         VerMinChrome:-1;         VerMinFirefox: -1;      VerMinEdge: -1;),
    (ID: 'JQGRID';                 Descrizione: 'jqGrid';                                 PathFileJS: 'jquery-plugins-opt/jquery.jqGrid.min.js';
     ErrVersioneBrowser: 'Il browser in uso &egrave; obsoleto e non supporta questo plugin.';
     VerMinIE: 9;         VerMinChrome:-1;         VerMinFirefox: -1;      VerMinEdge: -1;),
    (ID: 'JQ_MEDP_DROPDOWN';            Descrizione: 'MEDP jQuery Dropdown';              PathFileJS: 'jquery-plugins-opt/jquery.medp.dropdown.min.js';
     ErrVersioneBrowser: '';
     VerMinIE: -1;        VerMinChrome:-1;         VerMinFirefox: -1;      VerMinEdge: -1;),
    (ID: 'JQ_EASYPIECHART';             Descrizione: 'Grafico quota allegati (easyPieChart)';          PathFileJS: 'jquery-plugins-opt/jquery.easypiechart.min.js'; //   - grafico a torta (percentuale circolare)     - https://github.com/rendro/easy-pie-chart
     ErrVersioneBrowser: 'Il browser in uso &egrave; obsoleto e non supporta questo plugin.';
     VerMinIE: 9;         VerMinChrome:-1;         VerMinFirefox: -1;      VerMinEdge: -1;)
  );
  ANTI_XSS_CHECKED_TAGS : array[1..20] of String = (
    '<script>','<embed>','<applet>','<frameset>','<form>','<iframe>','<meta>','<layer>','<object>','<img>','<link>','<div>','javascript:',
    'src=','href=','eval()','expression()','vbscript:','url=','url()'
  );
  SAFE_USER_AGENT : String = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36';
  META_HTML_NO_FORMAT_TELEPHONE : String = '<meta name="format-detection" content="telephone=no"/>';

type
  // ####     THREAD DI ELABORAZIONE PER GESTIONE ALTERNATIVA MESSAGEBOX     ###
  // tipo per la procedura di elaborazione
  TProcElaborazione = procedure(Sender: TObject) of object;

  TProcAfter = procedure of object;

  // stato del thread
  TStatoThreadElaborazione = (teReady,       // thread pronto per l'esecuzione
                              teRunning,     // procedura Execute in esecuzione
                              teSuspended,   // thread sospeso in attesa di input utente
                              teTimeout);    // thread andato in timeout

  // classe di eccezioni propria
  EThreadElaborazioneException = class(Exception);

  ThreadElaborazioneExceptionHelper = class helper for EThreadElaborazioneException
  public
    function DescrizioneContesto: String;
  end;

  TThreadElaborazione = class(TThread)
  private
    FEvent: THandle;                     // handle per gestire la suspend / resume del thread
    CSStato: TMedpCriticalSection;           // semaforo per gestione della propriet� Stato
    FSuspendTimeout: Cardinal;           // timeout sospensione thread espresso in millisecondi
    FStato: TStatoThreadElaborazione;    // stato del thread
    function GetStato: TStatoThreadElaborazione;
    procedure SetStato(const Val: TStatoThreadElaborazione);
    function GetSuspendTimeout: Cardinal;
    procedure SetSuspendTimeout(const Val: Cardinal);
  protected
    procedure Execute; override;
  public
    AppID: String;                       // appid per impostare l'oggetto GGetWebApplicationThreadVar
    ProcElaborazione: TProcElaborazione; // procedura da eseguire nel thread separato
    Sender: TObject;                     // oggetto passato come parametro alla procedura di elaborazione
    RispostaMsg: TmeIWModalResult;       // risposta utente impostata dal message dialog medpIWMessageDlg
    procedure MedpResume;                // metodo per riprendere l'esecuzione del thread
    procedure MedpSuspend;               // metodo per sospendere il thread
    procedure AfterConstruction; override;
    destructor Destroy; override;
    property SuspendTimeout: Cardinal read GetSuspendTimeout write SetSuspendTimeout;
    property Stato: TStatoThreadElaborazione read GetStato write SetStato;
    const
      MEDP_SUSPEND_TIMEOUT = 1{min} * 60000; // timeout di suspend (attesa messaggio) in ms
  end;
  // ###########################################################################

  ETentativoXSSException = class(Exception);

  TA000FInterfaccia = class(TIWServerControllerBase)
    procedure IWServerControllerBaseCreate(Sender: TObject);
    procedure IWServerControllerBaseCloseSession(ASession: TIWApplication);
    procedure IWServerControllerBaseNewSession(ASession: TIWApplication);
    procedure IWServerControllerBaseDestroy(Sender: TObject);
    procedure IWServerControllerBaseException(AApplication: TIWApplication; AException: Exception; var Handled: Boolean);
    procedure IWServerControllerBaseBrowserCheck(aSession: TIWApplication; var rBrowser: TBrowser);
    procedure IWServerControllerBaseBeforeDispatch(Request: THttpRequest;
      aReply: THttpReply);
	  procedure IWServerControllerBaseConfig(Sender: TObject);
    procedure IWServerControllerBaseSessionRestarted(aSession: TIWApplication);
    procedure IWServerControllerBaseAfterRender(ASession: TIWApplication; AForm: TIWBaseForm);
  private
    lstIdSessioniAttive:TStringList;   (* MAN/07 SVILUPPO#84*) //elenco delle sessioni attive
    FCustomFilesDir: String;
    procedure PulisciTemplatesDir;
    procedure InizializzaTemplatesDir(TDInput:String);
    procedure CopiaFilePersonalizzati;
    procedure GetFileEsterni;
    function  GetHtmlHeaders: String;
    function  CartellaSuperiore(Cartella:String):String;
    procedure VerificaPermessiCartelle;
    procedure CaricaJQuery;
    procedure CtrlGeneraFileConfig; // solo per 9.1
    function  EseguiTestHeaderAntiXSS(Request:THttpRequest): Boolean;
    procedure ApplicationException(Sender: TObject; E: Exception);
  protected
    procedure Loaded; override;
  public
    MEDPFilesDir:String;
    ExcLoggerEccezioniIgnorate:TStringList;
    procedure SegnaSessioneAttiva;
    procedure A000GetFileConfig; // richiamato anche da WC000UCOnfigIni
    procedure ImpostaSecurityServerController; // richiamato anche da WC000UCOnfigIni
    procedure ImpostaExcLoggerEccezioniIgnorate;
    property CustomFilesDir: String read FCustomFilesDir write FCustomFilesDir;
  end;

  // TSessioneWeb rappresenta l'oggetto TIWUserSession di intraweb
  TSessioneWeb = class(TComponent)
  public
    // debug su file
    bDebugToFile: Boolean;
    SessioneIrisWIN: TSessioneIrisWIN;
    WR000DM: {$IFDEF WEBPJ}TA000FIrisWebDM{$ELSE}{$IFDEF X001}TX001FCentriCostoDtM{$ELSE}{$IFDEF INTRAWEBSVC}TWR000FBaseDM{$ELSE}TW001FIrisWebDtM{$ENDIF}{$ENDIF}{$ENDIF};
    HomeUrl: String;
    TimeOutOriginale:Integer;
    FThreadElaborazione: TThreadElaborazione;
    procAfterThreadElaborazione: TProcAfter;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AnnullaTimeOut;
    procedure RiduciTimeOut;
    procedure RipristinaTimeOut;
    function IsTimeoutRidotto: Boolean;
  end;

var
  {$IFDEF X001}
  OracleSession1:TOracleSession;
  selI090:TOracleDataSet;
  {$ENDIF}
  lstSessioniMondoEDP:TObjectList;
  lstSessioniOracle:TObjectList;
  W000NumSessioni: Integer;
  W000NumMaxSessioni: Integer;
  // debug su file: definizione stringlist per salvataggio su file
  lstDebugToFile: TStringList;
  lstDebugServer: TStringList;
  LastTimeDebugToFile: TDateTime;
  // parametri di configurazione
  W000ParConfig: TParConfig;
  // stringhe per codice jquery
  W000JQ_Init: String;
  W000JQ_PublicIP: String;
  W000JQ_Accordion: String;
  W000JQ_Autocomplete: String;
  W000JQ_Calendario: String;
  W000JQ_ContextMenu: String;
  W000JQ_Gritter: String;
  W000JQ_Mask: String;
  W000JQ_Tabs: String;
  W000JQ_Tooltip: String;
  W000JQ_Validator: String;
  W000JQ_Watermark: String;
  W000JQ_ReplaceCache: String;
  // critical section
  CSSessioniOracle: TMedpCriticalSection;
  CSSessioneMondoEDP: TMedpCriticalSection;
  CSFileLog: TMedpCriticalSection;
  CSFileTemporanei: TMedpCriticalSection;
  CSStampa: TMedpCriticalSection;
  CSAutenticazioneDominio: TMedpCriticalSection;
  CSFormatSettings: TMedpCriticalSection;
  CSNumSessioni: TMedpCriticalSection;
  CSClearMemory: TMedpCriticalSection;
  CSParConfig: TMedpCriticalSection;
  CSFontList: TMedpCriticalSection;
  CSDebugServer: TMedpCriticalSection;
  CSParametri: TMedpCriticalSection;
  CSSessioniAttive: TMedpCriticalSection;
  // altro
  SOA000RegistraMSG: TOracleSession;
  A000RegistraMsg: TRegistraMsg;

(*procedure PatchMakeObjectInstance;*)
function  A000GetTagSconosciuti(const Pagina,Tag:String):String;
function  A000TraduzioneStringhe(Stringa:String):String;
function  A000SessioneWEB:TSessioneWEB;
function  A000SessioneIrisWIN:TSessioneIrisWIN;
function  QVistaOracle:String;
function  SessioneOracle:TOracleSession;
function  QueryPK1:TQueryPK;
function  RegistraLog:TRegistraLog;
function  Parametri:TParametri;
function  WR000DM:{$IFDEF WEBPJ}TA000FIrisWebDM{$ELSE}{$IFDEF X001}TX001FCentriCostoDtM{$ELSE}{$IFDEF INTRAWEBSVC}TWR000FBaseDM{$ELSE}TW001FIrisWebDtM{$ENDIF}{$ENDIF}{$ENDIF};
procedure W000RegistraLog(const Tipo,S:String; E:Exception = nil);
function  GetBrowser: TBrowser;
function  GetBrowserStr: String;
function  GetTestoLog(PCodForm: String = 'A000'; PApp: TIWApplication = nil): String;
function  GetElencoFormAttive: String;
function  MsgBox: TmedpIWMessageDlg;
function  Password(Intestazione:String):Integer;
function  RegistraMsg:TRegistraMsg;
function  RegistraMsgSessione:TRegistraMsg;
procedure LoadFontList(FontList: TList<String>);
procedure DebugServer(Msg:String);
// debug su file
procedure DebugToFile(PApp: TIWApplication; const PLine: String; const PClearLog: Boolean = False);
function getProcAfterThreadElaborazione: TProcAfter;
procedure setProcAfterThreadElaborazione(proc: TProcAfter);
// thread elaborazione.ini
function  ThreadElaborazione: TThreadElaborazione;
procedure StartThreadElaborazione(PProcElaborazione: TProcElaborazione; PSender: TObject);
procedure GestioneThreadElaborazione;
// thread elaborazione.fine

implementation

{$R *.DFM}

{IFNDEF INTRAWEBSVC}
uses WR010UBase;
{ENDIF}

{ TmedpFieldHelper }
function TmedpFieldHelper.medpOldValue: Variant;
{$IFNDEF WEBPJ}
{var
  LInfo: string;}
{$ENDIF !WEBPJ}
begin
  Result:=Self.OldValue;
  if Self.DataSet.State = dsInsert then
  begin
    // v1: standard, sollevo un'eccezione bloccante
    raise Exception.Create('medpOldValue non accessibile!' + #13#10 + 'Notificare al servizio di assistenza del software.');

    // v2: alternativa, non sollevo alcuna eccezione, registro su log l'errore e ritorno null.
    // Solo IrisWeb. Non � mai stata utilizzata.
    //raise Exception.Create('medpOldValue non accessibile!' + #13#10 + 'Notificare al servizio di assistenza del software.');
    {$IFNDEF WEBPJ}
    {if Assigned(DataSet) then
      LInfo:=DataSet.Name
    else
      LInfo:='';
    TLogger.Warning(Format('%s: %s.medpOldValue non accessibile',[LInfo,FieldName]));}
    {$ENDIF !WEBPJ}
    //Result:=null;
  end;
end;

function Password(Intestazione:String):Integer;
begin
  Result:=-1;
end;

(*
procedure PatchMakeObjectInstance;
const
 CodeSize = $200;
var
 Addr: pointer;
 OldProtect: DWORD;
begin
   Addr:= @Classes.MakeObjectInstance;
   if not VirtualProtect(Addr,CodeSize,PAGE_EXECUTE_READWRITE,OldProtect) then
      RaiseLastOSError;
   try
                                               inc(integer(Addr),$000B); {bytes}
      byte(Addr^)    := $B8;      {mov ax,   } inc(integer(Addr),$0001);
      cardinal(Addr^):= $00000000;{,00000000}  inc(integer(Addr),$0004);
      byte(Addr^)    := $5F;      {pop edi}    inc(integer(Addr),$0001);
      byte(Addr^)    := $5E;      {pop esi}    inc(integer(Addr),$0001);
      byte(Addr^)    := $5B;      {pop ebx}    inc(integer(Addr),$0001);
      byte(Addr^)    := $5D;      {pop ebp}    inc(integer(Addr),$0001);
      byte(Addr^)    := $C2;      {ret    }    inc(integer(Addr),$0001);
      word(Addr^)    := $0008;    {  $0008}    inc(integer(Addr),$0002);
      cardinal(Addr^):= $90909090;{nop x 4}    inc(integer(Addr),$0004);
      word(Addr^)    := $9090;    {nop x 2}    inc(integer(Addr),$0002);
      byte(Addr^)    := $90;      {nop x 1}    inc(integer(Addr),$0001);
                         {call VirtualAlloc}
   finally
      if not VirtualProtect(Addr,CodeSize,OldProtect,OldProtect) then
         RaiseLastOSError;
      if not FlushInstructionCache(GetCurrentProcess,Addr,CodeSize) then
         Sleep(0); // Debug Pruposes
   end;
end;
*)

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
var
  S: TList<String>;
  Temp: string;
begin
  S:=TList<String>(Data);
  if LogFont.lfOrientation = 0 then
  begin
    Temp:=LogFont.lfFaceName;
(*
    FF_ROMAN
    FF_SWISS
  FF_MODERN
  FF_SCRIPT
  FF_DECORATIVE
*)
    if FontType and TRUETYPE_FONTTYPE = TRUETYPE_FONTTYPE then
      if ((S.Count = 0) or (AnsiCompareText(S[S.Count-1], Temp) <> 0)) and temp.StartsWith('@') = false then
        S.Add(Temp);
  end;
  Result:=1;
end;

procedure LoadFontList(FontList: TList<String>);
var
  DC: HDC;
  LFont: TLogFont;
begin
  try
    CSFontList.Enter;
    DC:=GetDC(0);
    FillChar(LFont, sizeof(LFont), 0);
    LFont.lfCharset:=ANSI_CHARSET;
    EnumFontFamiliesEx(DC, LFont, @EnumFontsProc, Winapi.Windows.LPARAM(FontList), 0);
    ReleaseDC(0, DC);
  finally
    CSFontList.Leave;
  end;
end;

function A000GetTagSconosciuti(const Pagina,Tag:String):String;
var
  LDB, LVersione, LBuild{$IFDEF WEBPJ}, app{$ENDIF}: String;
begin
  Result:='';

  {$IFNDEF INTRAWEBSVC}
  if Tag = 'PaginaCorrente' then
  begin
    // nome della form
    Result:=Format('<span id="nomeForm">%s</span>',[Pagina]);
  end
  else if Tag = 'ContenutoPagina1' then
  begin
    // ancora per pagina corrente
    Result:=Format('<a id="contenuto_pagina_1" class="font_nascosto">Pagina corrente: %s Selezione del dipendente corrente</a>',[Pagina]);
  end
  else if Tag = 'DataLavoro' then
  begin
    // data di lavoro
    if Parametri <> nil then
      Result:=FormatDateTime('dddd dd/mm/yyyy',IfThen(Parametri.DataLavoro = 0,Date,Parametri.DataLavoro));
  end
  else if Tag = 'DataCorrente' then
  begin
    // data corrente
    Result:=FormatDateTime('dddd dd/mm/yyyy',Date);
  end
  else if Tag = 'Versione' then
  begin
    // versione del prodotto
    LVersione:={$IFDEF WEBPJ}
                 {$IFDEF RILPRE}VersionePA{$ENDIF}
                 {$IFDEF PAGHE}VersioneGE{$ENDIF}
                 {$IFDEF STAGIU}VersioneSG{$ENDIF}
               {$ELSE}VersionePA{$ENDIF};
    LBuild:={$IFDEF WEBPJ}
              {$IFDEF RILPRE}BuildPA{$ENDIF}
              {$IFDEF PAGHE}BuildGE{$ENDIF}
              {$IFDEF STAGIU}BuildSG{$ENDIF}
            {$ELSE}BuildPA{$ENDIF};

    {$IFDEF WEBPJ}
    //Caratto 21/03/2014 Utente: CUNEO_CSAC Chiamata: 82374
    if Parametri.Applicazione = 'RILPRE' then
      app:='Presenze-assenze'
    else if Parametri.Applicazione = 'STAGIU' then
      app:='Gestione giuridica'
    else if Parametri.Applicazione = 'PAGHE' then
      app:='Gestione economica';

    Result:=Format('<span class="testo1">%s</span><span class="testo1">%s(%s)</span>',
                   [app,LVersione,LBuild]);
    {$ELSE}
    Result:=Format('<span class="testo1">%s</span><span class="testo2">%s</span><span class="testo1">%s(%s)</span>',
                   ['Iris','WEB',LVersione,LBuild]);
    {$ENDIF}
    // eventuale segnalazioni per debug
    {$WARN SYMBOL_PLATFORM OFF}
    if DebugHook <> 0 then
    begin
      // eventuale segnalazione NO_ABILITAZIONI attivo
      Result:=Result + Format('<span class="dbg">DEBUG %s</span>',
                              [IfThen(Pos(INI_PAR_NO_ABILITAZIONI,W000ParConfig.ParametriAvanzati) > 0,'[NO_ABILITAZIONI]')]);
    end;
    {$WARN SYMBOL_PLATFORM ON}
    // indicazione di debug su file
    try
      if Assigned(GGetWebApplicationThreadVar) and
         Assigned(GGetWebApplicationThreadVar.Data) then
      begin
        if (GGetWebApplicationThreadVar.Data as TSessioneWeb).bDebugToFile then
        begin
          Result:=Result + Format('<span class="logfile">Log attivit� in %sdebug.log</span>',[gsAppPath]);
        end;
      end;
    except
    end;
  end
  else if Tag = 'Login' then
  begin
    // dati di login
    LDB:='';
    {$IFDEF WEBPJ}
    if Parametri.Database <> '' then
      LDB:=' (' + Parametri.Database + ')';
    {$ENDIF}
    Result:='<span>';
    Result:=Result + Format('<span id="azienda">%s %s%s</span>',
                            [Parametri.Azienda,Parametri.Operatore,LDB]);
    if Parametri.ProfiloWEB <> '' then
      Result:=Result + Format('<span id="profilo">%s</span>',[Parametri.ProfiloWEB]);
    Result:=Result + '</span>';
  end
  else if Tag = 'DefinizioneDebug' then
  begin
    // informazioni di debug fornite dalla funzione TWR010FBase.GetInfoDebug
    Result:='';
    if Assigned(GGetWebApplicationThreadVar) and
       Assigned(GGetWebApplicationThreadVar.ActiveForm) and
       (GGetWebApplicationThreadVar.ActiveForm is TWR010FBase) then
    begin
      Result:='<script type="text/javascript"> ' + CRLF +
              'function getDebugInfo() { ' + CRLF +
              '  processAjaxEvent("&cid=T000",null,"%s.OnDebugInfoJs",false,null,false); ' + CRLF +
              '  return true; ' + CRLF +
              '} ' + CRLF +
              'try { ' + CRLF +
              '  document.getElementById("paginaCorrente").ondblclick=getDebugInfo; ' + CRLF +
              '} ' + CRLF +
              'catch (err) { ' + CRLF +
              '  alert(err); ' + CRLF +
              '} ' + CRLF +
              '</script> ';
      Result:=Format(Result,[UpperCase((GGetWebApplicationThreadVar.ActiveForm as TWR010FBase).Name)]);
    end;
  end
  else if Tag = 'IPInfo' then
  begin
    // informazioni sull'ip pubblico
    try
      if (Parametri <> nil) and
         (Parametri.CampiRiferimento.C90_W038CheckIP = 'S') then
      begin
        Result:=Format('<div id="ipInfo" class="%s">%s</div>',
                       [GetEnumName(TypeInfo(TIPStatus),Integer(Parametri.ClientIPInfo.Status)),
                        Parametri.ClientIPInfo.IP]);
      end;
    except
    end;
  end;
  {$ENDIF}
end;

function A000TraduzioneStringhe(Stringa:String):String;
// Gestione della traduzione (localizzazione) delle stringhe
var NomeComp,Traduzione: String;
begin
  Result:=Stringa;

  if (Parametri = nil) or
     (Parametri.CampiRiferimento.C90_Lingua = '') or
     (Parametri.cdsI015 = nil) or
     (not Parametri.cdsI015.Active) then
    Exit;

  // filtro del clientdataset sui componenti della maschera attuale + comp. ereditati
  with Parametri.cdsI015 do
  begin
    Filtered:=False;
    Filter:='MASCHERA = ''W000UMessaggi''';
    Filtered:=True;
    // ciclo di traduzione
    First;
    while not Eof do
    begin
      NomeComp:=Trim(UpperCase(FieldByName('COMPONENTE').AsString));
      Traduzione:=FieldByName('CAPTION').AsString;
      if (Trim(Traduzione) <> '') and (NomeComp = Trim(UpperCase(Stringa))) then
      begin
        Result:=Traduzione;
        Break;
      end;
      Next;
    end;
  end;
  if Result = '<NULL>' then
    Result:='';
end;

function MsgBox: TmedpIWMessageDlg;
// restituisce l'oggetto MsgBox della form attualmente attiva
begin
  // IMPORTANTE:
  //   la funzione potrebbe essere chiamata anche nel caso in cui � in corso una
  //   elaborazione su thread separato (v. ThreadElaborazione)
  //   nel caso di thread separato, GGetWebApplicationThreadVar sarebbe nil,
  //   ma viene settato in fase di creazione del thread
  Result:=(GGetWebApplicationThreadVar.ActiveForm as TWR010FBase).FMsgBox;
end;

function RegistraMsg:TRegistraMsg;
begin
  try
    //se TIWApplication non ancora presente o su form di login ,
    //si logga su RegistraMsgSessione; Vale anche per la form di login perch�
    //non ancora connessa a oracle e non potrebbe loggare su WR010RegistraMsg
    if (GGetWebApplicationThreadVar <> nil) and
       (GGetWebApplicationThreadVar.ActiveForm <> nil) and
       (not (GGetWebApplicationThreadVar.ActiveForm as TWR010FBase).IsLoginForm) then
    begin
      Result:=(GGetWebApplicationThreadVar.ActiveForm as TWR010FBase).WR010RegistraMsg;
      if (Result.SessioneOracleApp = nil) or (not Result.SessioneOracleApp.Connected) then //Appena creato dalla sessioneIrisWIn non � ancora connesso
        Result:=RegistraMsgSessione;
    end
    else
      Result:=RegistraMsgSessione;
  except
    Result:=RegistraMsgSessione;
  end;
end;

function RegistraMsgSessione:TRegistraMsg;
begin
  try
    if (GGetWebApplicationThreadVar <> nil) and
       (GGetWebApplicationThreadVar.Data <> nil)  and
       ((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN <> nil) then
    begin
      Result:=((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.RegistraMsg as TRegistraMsg);
      //if Result.SessioneOracleApp.CheckConnection(False) = ccError then //Appena creato dalla sessioneIrisWIn non � ancora connesso
      if (Result.SessioneOracleApp = nil) or (not Result.SessioneOracleApp.Connected) then //Appena creato dalla sessioneIrisWIn non � ancora connesso
        Result:=A000RegistraMsg;
    end
    else
      Result:=A000RegistraMsg;
  except
    Result:=A000RegistraMsg;
  end;
end;

function A000SessioneWEB:TSessioneWEB;
begin
  Result:=(GGetWebApplicationThreadVar.Data as TSessioneWeb);
end;

function A000SessioneIrisWIN:TSessioneIrisWIN;
begin
  Result:=(GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN;
end;

function QVistaOracle:String;
begin
  Result:=(GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.QVistaOracle;
end;

function SessioneOracle:TOracleSession;
begin
  {$IFNDEF X001}
  Result:=(GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle;

  {$ELSE}
  Result:=OracleSession1;
  {$ENDIF}
end;

function QueryPK1:TQueryPK;
begin
  Result:=((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.QueryPK1 as TQueryPK);
end;

function RegistraLog:TRegistraLog;
begin
  Result:=((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.RegistraLog as TRegistraLog);
end;

function Parametri:TParametri;
begin
  if GGetWebApplicationThreadVar = nil then
    Result:=nil
  else if GGetWebApplicationThreadVar.Data = nil then
  begin
    Result:=nil;
    //Result:=TParametri.Create(GGetWebApplicationThreadVar);
  end
  else if (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN = nil then
    Result:=nil
  else
    Result:=(GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.Parametri;
end;

function WR000DM:{$IFDEF WEBPJ}TA000FIrisWebDM{$ELSE}{$IFDEF X001}TX001FCentriCostoDtM{$ELSE}{$IFDEF INTRAWEBSVC}TWR000FBaseDM{$ELSE}TW001FIrisWebDtM{$ENDIF}{$ENDIF}{$ENDIF};
begin
  Result:=nil;
  {$IFNDEF X001}
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
    Result:=((GGetWebApplicationThreadVar.Data as TSessioneWeb).WR000DM as {$IFDEF WEBPJ}TA000FIrisWebDM{$ELSE}{$IFDEF X001}TX001FCentriCostoDtM{$ELSE}{$IFDEF INTRAWEBSVC}TWR000FBaseDM{$ELSE}TW001FIrisWebDtM{$ENDIF}{$ENDIF}{$ENDIF});
  {$ENDIF}
end;

procedure DebugServer(Msg:String);
var
  Ora: TDateTime;
  OraStr, Riga: String;
begin
  CSDebugServer.Enter();
  try
    if lstDebugServer = nil then
      lstDebugServer:=TStringList.Create;

    // formatta la riga in modo da aggiungere ora, ecc..
    Ora:=Now;
    OraStr:=FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz',Ora);
    // formatta la riga in modo posizionale
    // ora:    23 caratteri (10 + 12)
    Riga:=Format('%-23s | %s',[OraStr,Msg]);

    lstDebugServer.Add(Riga);
    lstDebugServer.SaveToFile(gsAppPath + 'debugServer.log');
  finally
    CSDebugServer.Leave();
  end;
end;

procedure DebugToFile(PApp: TIWApplication; const PLine: String; const PClearLog: Boolean = False);
// se � stato specificato il parametro "debug" nella querystring
// scrive la stringa indicata al file
// formattata in modo opportuno (corredata di ora, ecc..)
var
  Ora: TDateTime;
  OraStr, OffsetStr, Riga: String;
  Scrivi: Boolean;
begin
  if PApp <> nil then
  begin
    try
      { DONE : TEST IW 14 OK }
      {if PApp.Data = nil then
        Scrivi:=(PApp.RedirectURL = WEB_ACT_DEBUG_TO_FILE)
      else
        Scrivi:=(PApp.Data as TSessioneWeb).bDebugToFile;}

      if PApp.Data = nil then
      begin
        if PApp.Request <> nil then
          Scrivi:=(PApp.Request.ContentFields.IndexOfName(WEB_FLAG_DEBUG_TO_FILE) >= 0) and
                  (PApp.Request.ContentFields.Values[WEB_FLAG_DEBUG_TO_FILE] = 'S')
        else
          Scrivi:=False;
      end
      else
        Scrivi:=(PApp.Data as TSessioneWeb).bDebugToFile;

      if Scrivi then
      begin
        // al primo passaggio crea stringlist di debug
        if lstDebugToFile = nil then
          lstDebugToFile:=TStringList.Create;

        // formatta la riga in modo da aggiungere ora, ecc..
        Ora:=Now;
        OraStr:=FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz',Ora);
        OffsetStr:=FormatDateTime('nn:ss.zzz',Ora - LastTimeDebugToFile);

        // se richiesto pulisce la stringlist con i dati di log
        if PClearLog then
        begin
          lstDebugToFile.Clear;
          lstDebugToFile.Add(Format('%-23s | %-11s | %s',['Ora messaggio','Time offset','Messaggio']));

          // l'offset iniziale non � significativo
          OffsetStr:=StringOfChar(' ',9);
        end;

        // formatta la riga in modo posizionale
        // ora:    23 caratteri (10 + 12)
        // offset: 11 caratteri  (9 + 2)
        Riga:=Format('%-23s | %-11s | %s',[OraStr,OffsetStr,PLine]);

        // salva ora di ultimo debug
        LastTimeDebugToFile:=Now;

        // accoda la stringa e scrive file
        lstDebugToFile.Add(Riga);
        lstDebugToFile.SaveToFile(gsAppPath + 'debug.log');
      end;
    except
    end;
  end;
end;

function getProcAfterThreadElaborazione: TProcAfter;
begin
  Result:=(GGetWebApplicationThreadVar.Data as TSessioneWeb).procAfterThreadElaborazione;
end;

procedure setProcAfterThreadElaborazione(proc: TProcAfter);
begin
  (GGetWebApplicationThreadVar.Data as TSessioneWeb).procAfterThreadElaborazione:=proc;
end;

// ### Thread elaborazione.ini
function ThreadElaborazione: TThreadElaborazione;
begin
  Result:=(GGetWebApplicationThreadVar.Data as TSessioneWeb).FThreadElaborazione;
end;

procedure StartThreadElaborazione(PProcElaborazione: TProcElaborazione; PSender: TObject);
begin
  if ThreadElaborazione <> nil then
    raise EThreadElaborazioneException.Create('impossibile avviare due elaborazioni contemporanee!');

  if @PProcElaborazione = nil then
    raise EThreadElaborazioneException.Create('nessuna procedure di elaborazione indicata!');

  // impostazione del thread di elaborazione
  with (GGetWebApplicationThreadVar.Data as TSessioneWeb) do
  begin
    // 1. creazione del thread (sospeso) e annullamento del timeout per impedire la scadenza della sessione durante l'esistenza del thread
    FThreadElaborazione:=TThreadElaborazione.Create(True);
    A000SessioneWEB.AnnullaTimeOut;

    // 2. impostazione parametri per thread di elaborazione

    // appid per impostazione GGetWebApplicationThreadVar
    FThreadElaborazione.AppID:=GGetWebApplicationThreadVar.AppID;

    // timeout sospensione thread
    // impostato pari al timeout di sessione diminuito di 1 minuto
    FThreadElaborazione.SuspendTimeout:=Max(1,(GGetWebApplicationThreadVar.SessionTimeOut - 1)) * 60000;

    // procedura di elaborazione e relativo parametro sender
    FThreadElaborazione.ProcElaborazione:=PProcElaborazione;
    FThreadElaborazione.Sender:=PSender;
  end;

  // avvio del thread di elaborazione
  GestioneThreadElaborazione;
end;

procedure GestioneThreadElaborazione;
var
  PProc: TProcAfter;
begin
  case ThreadElaborazione.Stato of
    teReady:
      begin
        ThreadElaborazione.Start;
      end;
    teTimeout:
      begin
        // timeout: il thread viene rimosso e viene data eccezione all'utente
        ThreadElaborazione.AppID:='';
        ThreadElaborazione.ProcElaborazione:=nil;
        ThreadElaborazione.Sender:=nil;
        FreeAndNil((GGetWebApplicationThreadVar.Data as TSessioneWeb).FThreadElaborazione);
        raise EThreadElaborazioneException.Create('timeout');
      end;
    else
    begin
      ThreadElaborazione.MedpResume;
    end;
  end;

  while not ThreadElaborazione.Finished do
  begin
    if ThreadElaborazione.Stato = teSuspended then
    begin
      Exit;
    end;

    // gestire eventuale timeout
    Sleep(500);
  end;

  // pulisce puntatori e riferimenti
  ThreadElaborazione.AppID:='';
  ThreadElaborazione.ProcElaborazione:=nil;
  ThreadElaborazione.Sender:=nil;

  FreeAndNil((GGetWebApplicationThreadVar.Data as TSessioneWeb).FThreadElaborazione);
  PProc:=getProcAfterThreadElaborazione();
  if Assigned(PProc) then
    PProc();
end;

{ TSessioneWeb }

constructor TSessioneWeb.Create(AOwner: TComponent);
begin
  DebugToFile(AOwner as TIWApplication,'TSessioneWeb.Create: inherited');
  inherited;
  DebugToFile(AOwner as TIWApplication,'TSessioneWeb.Create: TSessioneIrisWIN.Create');
  SessioneIrisWIN:=TSessioneIrisWIN.Create(AOwner);
  DebugToFile(AOwner as TIWApplication,'TSessioneWeb.Create: HomeUrl');
  HomeUrl:='';
  {$IFDEF WEBPJ}//IrisCloud
  DebugToFile(AOwner as TIWApplication,'TSessioneWeb.Create: TA000FIrisWebDM.Create');
  WR000DM:=TA000FIrisWebDM.Create(AOwner);
  {$ELSE}
  {$IFNDEF X001}
  {$IFDEF INTRAWEBSVC}
  WR000DM:=TWR000FBaseDM.Create(AOwner);
  {$ELSE}//IrisWEB
  WR000DM:=TW001FIrisWebDtM.Create(AOwner);
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  // il thread di elaborazione non viene creato in questo momento,
  // perch� ogni elaborazione effettuata richiede che il thread venga ricreato
  // pertanto la creazione viene delegata alla function StartThreadElaborazione del servercontroller
  DebugToFile(AOwner as TIWApplication,'TSessioneWeb.Create: FThreadElaborazione');
  FThreadElaborazione:=nil;
  DebugToFile(AOwner as TIWApplication,'TSessioneWeb.Create: end');
end;

destructor TSessioneWeb.Destroy;
begin
  {Alberto-Dario 09/06/2015: Attenzione!
     CSSessioniOracle viene usata sulla CloseSession per decrementare il Tag della SessioneOracle.
     Poi viene riutilizzata qui per valutare il tag ed eventualmente fare il logoff.
     Ma tra i 2 eventi, potrebbe capitare che altri la utilizzino per cercare la sessione di lavoro, incrementando il tag.
     Per es: CloseSesson: tag:=tag - 1 --> tag = 0
               NewSession (altro utente): tag:=tag + 1
             SessioneWeb.Destroy: tag = 1 (e non pi� 0)
     La cosa per� non sembra creare problemi alle transazioni o alla integrit� di lstSessioniOracle
  }

  //Alberto 09/06/2015: aggiunto commit per evitare lock sulle transazioni nel caso non avvenga il logoff
  if (SessioneIrisWIN <> nil) and
     (SessioneIrisWIN.SessioneOracle <> nil) and
     (SessioneIrisWIN.SessioneOracle.Connected) then
  try
    SessioneIrisWIN.SessioneOracle.Commit;
  except
  end;

  if CSSessioniOracle <> nil then
  try
    try
      CSSessioniOracle.Enter;
      if SessioneIrisWIN.SessioneOracle.Tag <= 0 then
      begin
        {$IFDEF WEBPJ}
        //IrisCloud: si forza sempre il logoff (il parametro LogoffDbPool non � significativo, da togliere)
        SessioneIrisWIN.SessioneOracle.Logoff;
        {$ELSE}
        //IrisWEB: si forza il logoff se richiesto dal parametro o se c'� una sessione db per ogni sessione web
        if W000ParConfig.LogoffDbPool or (W000ParConfig.CursoriSessione >= W000ParConfig.MaxOpenCursors) then
          SessioneIrisWIN.SessioneOracle.Logoff;
        {$ENDIF}
      end;
    finally
      CSSessioniOracle.Leave;
    end;
  except
  end;
  try FreeAndNil(SessioneIrisWIN); except end;
  try FreeAndNil(WR000DM); except end;
  inherited;
end;

procedure TSessioneWeb.AnnullaTimeOut;
begin
  GGetWebApplicationThreadVar.SessionTimeOut:=9999;
end;

procedure TSessioneWeb.RiduciTimeOut;
// riduce il timeout di sessione
const
  SOGLIA = 15;
begin
  // se il timeout corrente � gi� inferiore alla soglia, termina immediatamente
  if GGetWebApplicationThreadVar.SessionTimeOut <= SOGLIA then
    Exit;

  // riduce il timeout di sessione
  GGetWebApplicationThreadVar.SessionTimeOut:=SOGLIA;
end;

function TSessioneWeb.IsTimeoutRidotto: Boolean;
// restituisce true se il timeout di sessione � ridotto rispetto al valore originale
// oppure false altrimenti
begin
  Result:=GGetWebApplicationThreadVar.SessionTimeOut < TimeoutOriginale;
end;

procedure TSessioneWeb.RipristinaTimeOut;
begin
  if (ThreadElaborazione = nil) and
     (TimeOutOriginale > 0) then
    GGetWebApplicationThreadVar.SessionTimeOut:=TimeOutOriginale;
end;

{ TA000FInterfaccia }

procedure TA000FInterfaccia.Loaded;
var
  LCacheDir,
  LTemplateDir: String;
begin
  { DONE : TEST IW 14 OK }
  // directory cache
  LCacheDir:=gsAppPath + PATH_CACHE;
  ForceDirectories(LCacheDir);
  CacheDir:=LCacheDir;

  // directory per i file
  // Su IW12 era usata la property FilesDir, anche se si faceva un set il valore non veniva modificato
  // e corrisponeva al percorso della directory Files compreso il separatore '\' finale
  MEDPFilesDir:=IncludeTrailingPathDelim(ContentPath + 'Files');

  // directory per i file personalizzati
  CustomFilesDir:=gsAppPath + PATH_USR_FILES;

  // directory per i template
  LTemplateDir:=PATH_TEMPLATE;
  {$IFNDEF X001}
  // per irisweb e iriscloud � richiesto un forcedirectories per evitare access violation
  // dovuto alla non presenza della cartella
  ForceDirectories(gsAppPath + LTemplateDir);
  {$ENDIF}
  TemplateDir:=LTemplateDir;

  inherited;
end;

procedure TA000FInterfaccia.CaricaJQuery;
// caricamento codice jquery per utilizzo plugin
var
  LJQBase: String;
  LCurrJsFile: String;
begin
  LJQBase:=TPath.Combine(ContentPath,'js\jquery-iw\');
  try
    // jqInit
    LCurrJsFile:=TPath.Combine(LJQBase,'jqInit.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Init:=TFile.ReadAllText(LCurrJsFile);

    // IMPORTANTE
    // da qui in poi utilizzare l'ordine alfabetico per i file, in modo da facilitare la ricerca

    // jqAccordion
    LCurrJsFile:=TPath.Combine(LJQBase,'jqAccordion.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Accordion:=TFile.ReadAllText(LCurrJsFile);

    // jqAutocomplete
    LCurrJsFile:=TPath.Combine(LJQBase,'jqAutocomplete.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Autocomplete:=TFile.ReadAllText(LCurrJsFile);

    // jqCalendario
    LCurrJsFile:=TPath.Combine(LJQBase,'jqCalendario.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Calendario:=TFile.ReadAllText(LCurrJsFile);

    // jqContextMenu
    LCurrJsFile:=TPath.Combine(LJQBase,'jqContextMenu.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_ContextMenu:=TFile.ReadAllText(LCurrJsFile);

    // jqGritter
    LCurrJsFile:=TPath.Combine(LJQBase,'jqGritter.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Gritter:=TFile.ReadAllText(LCurrJsFile);

    // jqMask
    LCurrJsFile:=TPath.Combine(LJQBase,'jqMask.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Mask:=TFile.ReadAllText(LCurrJsFile);

    // jqMask per irisweb / iriscloud
    LCurrJsFile:=TPath.Combine(LJQBase,{$IFDEF WEBPJ}'jqMask02.js'{$ELSE}'jqMask01.js'{$ENDIF});
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Mask:=W000JQ_Mask + TFile.ReadAllText(LCurrJsFile);

    // jqPublicIP
    LCurrJsFile:=TPath.Combine(LJQBase,'jqPublicIP.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_PublicIP:=TFile.ReadAllText(LCurrJsFile);

    // jqReplaceCache
    LCurrJsFile:=TPath.Combine(LJQBase,'jqReplaceCache.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_ReplaceCache:=TFile.ReadAllText(LCurrJsFile);

    // jqTabs
    LCurrJsFile:=TPath.Combine(LJQBase,'jqTabs.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Tabs:=TFile.ReadAllText(LCurrJsFile);

    // jqTooltip
    LCurrJsFile:=TPath.Combine(LJQBase,'jqTooltip.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Tooltip:=TFile.ReadAllText(LCurrJsFile);

    // jqValidator
    LCurrJsFile:=TPath.Combine(LJQBase,'jqValidator.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Validator:=TFile.ReadAllText(LCurrJsFile);

    // jqWatermark
    LCurrJsFile:=TPath.Combine(LJQBase,'jqWatermark.js');
    if not TFile.Exists(LCurrJsFile) then
      raise Exception.CreateFmt('Il seguente file javascript non � presente'#13#10'%s',[LCurrJsFile]);
    W000JQ_Watermark:=TFile.ReadAllText(LCurrJsFile);
  except
    on E: Exception do
      raise Exception.CreateFmt('Si � verificato un errore durante la fase di avvio:'#13#10'%s',[E.Message]);
  end;
end;

procedure TA000FInterfaccia.CtrlGeneraFileConfig;
// funzione di migrazione da valori su registro a valori su file ini
// se non presente genera il file .ini di configurazione dell'applicativo web,
// in base alla configurazione attualmente presente su registro
// solo per passaggio a versione 9.1
var
  PathFileIni, ChiaveReg: String;
  Sezione, Ident, ValoreStr, ValoreDefaultStr: String;
  ValoreInt, ValoreDefaultInt: Integer;
  IniFile: TIniFile;
begin
  // determina il file ini di configurazione dell'applicativo
  { DONE : TEST IW 14 OK }
  PathFileIni:=IncludeTrailingPathDelim(gsAppPath) + FILE_CONFIG;

  // se il file di configurazione � gi� esistente non effettua operazioni
  if TFile.Exists(PathFileIni) then
  begin
    Exit;
  end;

  // determina la sottochiave di registro per le informazioni specifiche del progetto
  ChiaveReg:={$IFDEF X001}'X001'{$ELSE}'W001'{$ENDIF};

  // crea l'oggetto per la manipolazione del file ini di configurazione
  IniFile:=TIniFile.Create(PathFileIni);
  try
    // ###  sezione impostazioni operative ###
    Sezione:=INI_SEZ_IMPOST_OPER;

    // database (irisweb, cloud, x001)
    // default irisweb e iriscloud = vuoto
    // default x001 = 'IRIS'
    Ident:=INI_ID_DATABASE;
    ValoreDefaultStr:={$IFDEF X001}'IRIS'{$ELSE}''{$ENDIF};
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'DATABASE',ValoreDefaultStr);

    IniFile.WriteString(Sezione,Ident,ValoreStr);

    // azienda (irisweb, cloud, x001)
    // default irisweb e iriscloud = vuoto
    // default x001 = 'AZIN'
    Ident:=INI_ID_AZIENDA;
    ValoreDefaultStr:={$IFDEF X001}'AZIN'{$ELSE}''{$ENDIF};
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'AZIENDA',ValoreDefaultStr);
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    {$IFNDEF X001} {$IFNDEF WEBPJ}
    // profilo (irisweb)
    // default = vuoto
    Ident:=INI_ID_PROFILO;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'PROFILO','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);
    {$ENDIF WEBPJ} {$ENDIF X001}

    // max sessioni web (irisweb, cloud, x001)
    // default = 0 (nessun limite)
    Ident:=INI_ID_MAX_SESSIONI;
    ValoreInt:=0;
    IniFile.WriteInteger(Sezione,Ident,ValoreInt);

    // URL per redirect in caso di supero max sessioni web (irisweb, cloud, x001)
    // default = vuoto
    Ident:=INI_ID_URL_SUP_MAX_SESS;
    ValoreStr:='';
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    {$IFNDEF X001}
    // timeout operatore (irisweb, iriscloud)
    // default = 30 (minuti)
    Ident:=INI_ID_TIMEOUT_OPER;
    ValoreDefaultInt:={$IFDEF WEBPJ}120{$ELSE}30{$ENDIF};
    ValoreDefaultStr:=IntToStr(ValoreDefaultInt);
    ValoreInt:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'TIMEOUT_OPERATORE',ValoreDefaultStr),ValoreDefaultInt);
    IniFile.WriteInteger(Sezione,Ident,ValoreInt);
    {$ENDIF X001}

    {$IFNDEF WEBPJ}
    // timeout dipendente (irisweb, x001)
    // default irisweb = 15 (minuti)
    // default x001    =  5 (minuti)
    Ident:=INI_ID_TIMEOUT_DIP;
    ValoreDefaultInt:={$IFDEF X001}5{$ELSE}5{$ENDIF};
    ValoreDefaultStr:=IntToStr(ValoreDefaultInt);
    ValoreInt:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'TIMEOUT_DIPENDENTE',ValoreDefaultStr),ValoreDefaultInt);
    IniFile.WriteInteger(Sezione,Ident,ValoreInt);
    {$ENDIF WEBPJ}

    // home (irisweb, iriscloud, x001)
    // default = vuoto
    Ident:=INI_ID_HOME;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'HOME','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    {$IFNDEF X001} {$IFNDEF WEBPJ}
    // url webservice di autenticazione (irisweb)
    // default = vuoto
    Ident:=INI_ID_URL_WS_AUT;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'URL_WS_AUTH','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);
    {$ENDIF WEBPJ} {$ENDIF X001}

    // url pagina di manutenzione (irisweb, iriscloud, x001)
    // default = vuoto
    Ident:=INI_ID_URL_MANUTENZIONE;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'URL_MANUTENZIONE','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    {$IFNDEF X001} {$IFNDEF WEBPJ}
    // login esterno (irisweb)
    // default = 'N'
    Ident:=INI_ID_LOGIN_ESTERNO;
    ValoreDefaultStr:='N';
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'LOGIN_ESTERNO',ValoreDefaultStr);
    IniFile.WriteString(Sezione,Ident,ValoreStr);
    {$ENDIF WEBPJ} {$ENDIF X001}

    // campi invisibili (irisweb, iriscloud, x001)
    // default = vuoto
    Ident:=INI_ID_CAMPI_INVISIBILI;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'CAMPI_INVISIBILI','');
    if ValoreStr = '' then
      ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'CAMPIINVISIBILI','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    {$IFDEF X001}
    // impostazioni operative per X001

    Ident:=INI_ID_TAB_COL_PARTENZA;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'TABCOLPARTENZA','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    Ident:=INI_ID_STRUTTURA;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'STRUTTURA','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    Ident:=INI_ID_SLR_COL_PILOTA;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'SLRCOLPILOTA','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    Ident:=INI_ID_SLR_COL_PILOTATA1;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'SLRCOLPILOTATA1','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    Ident:=INI_ID_SLR_COL_PILOTATA2;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'SLRCOLPILOTATA2','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    Ident:=INI_ID_VERSIONEDB;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'VERSIONEDB','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    Ident:=INI_ID_NUM_LIVELLI;
    ValoreDefaultInt:=0;
    ValoreDefaultStr:=IntToStr(ValoreDefaultInt);
    ValoreInt:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'NUMLIVELLI',ValoreDefaultStr),ValoreDefaultInt);
    IniFile.WriteInteger(Sezione,Ident,ValoreInt);
    {$ENDIF}


    // ### sezione impostazioni di sistema ###
    Sezione:=INI_SEZ_IMPOST_SIST;

    // porta (irisweb, iriscloud, x001)
    // default = 5000 (solo in ambito standalone / windows service)
    Ident:=INI_ID_PORT;
    ValoreDefaultInt:=5000;
    ValoreDefaultStr:=IntToStr(ValoreDefaultInt);
    ValoreInt:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'PORT',ValoreDefaultStr),ValoreDefaultInt);
    IniFile.WriteInteger(Sezione,Ident,ValoreInt);

    {$IFNDEF X001}
    // cursori login (irisweb, iriscloud)
    // default = 12
    Ident:=INI_ID_CURSORI_LOGIN;
    ValoreDefaultInt:=12;
    ValoreDefaultStr:=IntToStr(ValoreDefaultInt);
    ValoreInt:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'CURSORI_LOGIN',ValoreDefaultStr),ValoreDefaultInt);
    IniFile.WriteInteger(Sezione,Ident,ValoreInt);

    // cursori sessione (irisweb, iriscloud)
    // default = 10
    Ident:=INI_ID_CURSORI_SESSIONE;
    ValoreDefaultInt:=10;
    ValoreDefaultStr:=IntToStr(ValoreDefaultInt);
    ValoreInt:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'CURSORI_SESSIONE',ValoreDefaultStr),ValoreDefaultInt);
    IniFile.WriteInteger(Sezione,Ident,ValoreInt);

    // max open cursors (irisweb, iriscloud)
    // default = 1000
    Ident:=INI_ID_MAX_OPEN_CURSORS;
    ValoreDefaultInt:=1000;
    ValoreDefaultStr:=IntToStr(ValoreDefaultInt);
    ValoreInt:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'MAX_OPEN_CURSORS',ValoreDefaultStr),ValoreDefaultInt);
    IniFile.WriteInteger(Sezione,Ident,ValoreInt);
    {$ENDIF X001}

    // max working memory (irisweb, iriscloud, x001)
    // default = 0 (Mb)
    // valore > 0
    Ident:=INI_ID_MAX_WORKING_MEMORY;
    ValoreDefaultInt:=0;
    ValoreDefaultStr:=IntToStr(ValoreDefaultInt);
    ValoreInt:=Max(0,StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'MAX_WORKING_MEMORY',ValoreDefaultStr),ValoreDefaultInt));
    IniFile.WriteInteger(Sezione,Ident,ValoreInt);

    // log abilitati (irisweb, iriscloud, x001)
    // default = vuoto
    Ident:=INI_ID_LOG_ABILITATI;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'LOG_ABILITATI','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);

    // parametri avanzati
    // default = vuoto
    Ident:=INI_ID_PARAMETRI_AVANZATI;
    ValoreStr:=R180GetRegistro(HKEY_LOCAL_MACHINE,ChiaveReg,'PARAMETRI_AVANZATI','');
    IniFile.WriteString(Sezione,Ident,ValoreStr);
  finally
    FreeAndNil(IniFile);
  end;
end;

{ Controlla se in alcuni campi dell'header della richiesta sono presenti possibili tentativi
  di effettuare un attacco XSS. Ritorna true se il test � superato (nessun tentativo),
  false altrimenti (tentativo presente)
}
{ TODO : su IW15 dovrebbe gi� essere implementato, pensare se si pu� rimuovere }
function TA000FInterfaccia.EseguiTestHeaderAntiXSS(Request:THttpRequest): Boolean;
  var
    ElencoValori:array [0..8] of String;
    i:Integer;
  function TestCampoHeader(CampoHeader:String):Boolean;
  var
    ElementoCorrente:String;
  begin
    Result:=True;
    for ElementoCorrente in ANTI_XSS_CHECKED_TAGS do
    begin
      if Pos(Lowercase(ElementoCorrente),CampoHeader) > 0 then
      begin
        Result:=False; // test fallito, c'� un possibile tentativo di attacco XSS
        Break;
      end;
    end;
  end;
begin
  Result:=True;
  i:=0;
  try
    ElencoValori[0]:=Lowercase(Request.UserAgent);
    ElencoValori[1]:=Lowercase(Request.Referer);
    ElencoValori[2]:=Lowercase(Request.Host);
    ElencoValori[3]:=Lowercase(Request.AcceptLanguage);
    ElencoValori[4]:=Lowercase(Request.Authorization);
    ElencoValori[5]:=Lowercase(Request.URL);
    ElencoValori[6]:=Lowercase(Request.PathInfo);
    ElencoValori[7]:=Lowercase(Request.ForwardedFor);
    ElencoValori[8]:=Lowercase(Request.IfModifiedSince);
    if (Pos(INI_PAR_SECURITY_ENABLE_XSS_PROTECTION,W000ParConfig.ParametriAvanzati) > 0) then
    begin
      while (i <= 8) and (Result) do
      begin
        Result:= not R180VerificaStringaPerInjection(ElencoValori[i]);
        Inc(i);
      end;
    end
    else
    begin
      while (i <= 8) and (Result) do
      begin
        Result:=TestCampoHeader(ElencoValori[i]);
        Inc(i);
      end;
    end;
  except
    on E:Exception do
      Result:=False; // in via precauzionale indichiamo il test come fallito in caso di errore
  end;
  if not Result then
  begin
    if (Pos(INI_PAR_SECURITY_ENABLE_XSS_PROTECTION,W000ParConfig.ParametriAvanzati) > 0) then
    begin
      for i:=Low(ElencoValori) to High(ElencoValori) do
        ElencoValori[i]:=R180PulisciStringaPerInjection(ElencoValori[i]);
    end
    else
      Request.UserAgent:=SAFE_USER_AGENT;
  end;
end;

procedure TA000FInterfaccia.ImpostaSecurityServerController;
begin
  CookieOptions.HttpOnly:=Pos(INI_PAR_COOKIES_ENABLE_HTTPONLY,W000ParConfig.ParametriAvanzati) > 0;
  CookieOptions.Secure:=Pos(INI_PAR_COOKIES_ENABLE_SECURE,W000ParConfig.ParametriAvanzati) > 0;
  if Pos(INI_PAR_COOKIES_ENABLE_SAMESITE_STRICT,W000ParConfig.ParametriAvanzati) > 0 then
    CookieOptions.SameSite:=TIWCookieSameSiteOption.ssoStrict
  else
    CookieOptions.SameSite:=TIWCookieSameSiteOption.ssoNone;
  SecurityOptions.CheckFormId:=(Pos(INI_PAR_SECURITY_ENABLE_FORM_ID_CHECK,W000ParConfig.ParametriAvanzati) > 0);
  SecurityOptions.CheckSameIP:=(Pos(INI_PAR_SECURITY_ENABLE_SAME_IP_CHECK,W000ParConfig.ParametriAvanzati) > 0);
  SecurityOptions.CheckSameUA:=(Pos(INI_PAR_SECURITY_ENABLE_SAME_UA_CHECK,W000ParConfig.ParametriAvanzati) > 0);
end;

procedure TA000FInterfaccia.ImpostaExcLoggerEccezioniIgnorate;
var
  StringList:TStringList;
  i,j:Integer;
  RttiContext:TRttiContext;
  RttiType:TRttiType;
  ArrayRttiType: TArray<TRttiType>;
  ExcClass: TClass;
begin
  if (ExceptionLogger.Enabled) and (W000ParConfig.IWExcLogEccezIgnorate <> '') then
  begin
    // W000ParConfig.IWExcLogEccezIgnorate contiene i nomi delle classi delle eccezioni
    // separati da ','
    StringList:=TStringList.Create;
    RttiContext:=TRttiContext.Create;
    ArrayRttiType:=RttiContext.GetTypes;
    try
      StringList.CaseSensitive:=False;
      StringList.Sorted:=True;
      StringList.Duplicates:=TDuplicates.dupIgnore;
      StringList.StrictDelimiter:=True;
      StringList.DelimitedText:=W000ParConfig.IWExcLogEccezIgnorate;
      for i:=0 to (StringList.Count - 1) do
      begin
        // Per ogni nome di classe: determiniamo se esiste.
        // FindType richiede il nome completo: <Unit>.<NomeClasse>.
        RttiType:=RttiContext.FindType(StringList[i]);
        if RttiType = nil then
        begin
          // Classe non trovata. Pu� essere che non il nome non sia completo.
          // Vediamo se troviamo una classe con quel nome (prendo la prima che trovo).
          for j:=0 to (Length(ArrayRttiType) - 1) do
          begin
            if ArrayRttiType[j].Name.ToLower = StringList[i].ToLower then
            begin
              RttiType:=ArrayRttiType[j];
              break;
            end;
          end;
        end;
        if RttiType <> nil then
        begin
          // Abbiamo le informazioni sulla classe. Estende la classe padre delle eccezioni?
          ExcClass:=RttiType.AsInstance.MetaclassType;
          if ExcClass.InheritsFrom(Exception) then
          begin
            // La classe specificata � una eccezione. Verifichiamo che non sia gi� stata aggiunta.
            if ExcLoggerEccezioniIgnorate.IndexOf(ExcClass.ClassName) < 0 then
            begin
              // Passiamo il tipo classe a ExceptionLogger.RegisterIgnoreException() (prende un class of Exception).
              // La posso castare forzatamente perch� sono certo del tipo e perch� internamente
              // ExceptionLogger usa una lista di puntatori per mantenere le eccezioni escluse.
              // Notare che TIWExceptionLogger.RegisterIgnoreException � dichiarato come thread safe.
              ExceptionLogger.RegisterIgnoreException(ExceptClass(ExcClass));
              ExcLoggerEccezioniIgnorate.Add(ExcClass.ClassName)
            end;
          end;
        end;
      end;
    finally
      StringList.Free;
      RttiContext.Free;
    end;
  end;
end;

procedure TA000FInterfaccia.ApplicationException(Sender: TObject; E: Exception);
{Alberto 26/02/2021: Serve per gestire le eccezioni sul destroy dei datamodule, che NON vengono intercettate automaticamente da IntraWEB}
var Handled:Boolean;
begin
  IWServerControllerBaseException(nil, E, Handled);
end;

procedure TA000FInterfaccia.IWServerControllerBaseCreate(Sender: TObject);
// inizializzazione variabili globali
var
  locDataID:String;
  i: Integer;
  {$IFDEF X001}
  Azienda,Utente,Pwd:String;
  {$ENDIF}
  function GetPassword(PosFilePwd:String):String;
  // restituisce la password criptata su file
  var L:TStringList;
      HomePath:String;
  begin
    Result:=A000PasswordFissa;
    L:=TStringList.Create;
    try
      try
        if PosFilePwd = A000FilePwdHost then
        begin
          HomePath:=IncludeTrailingPathDelimiter(A000GetHomePath);
          if FileExists(HomePath + 'IrisWIN.INI') then
            L.LoadFromFile(HomePath + 'IrisWIN.INI');
        end
        else if PosFilePwd = A000FilePwdApplication then
        begin
          if FileExists(gsAppPath + 'IrisWIN.INI') then
            L.LoadFromFile(gsAppPath + 'IrisWIN.INI');
        end;
        if L.Count > 0 then
          Result:=R180Decripta(L[0],20111972);
      except
      end;
    finally
      L.Free;
    end;
  end;
begin
  //Alberto 26/02/2021: Serve per gestire le eccezioni sul destroy dei datamodule, che NON vengono intercettate automaticamente da IntraWEB
  Application.OnException:=ApplicationException;

  // log delle info sul client oracle utilizzato
  try
    TLogger.Debug('Oracle home disponibili (chiavi di registro ORACLE_HOME_NAME)',OracleHomeList.Count);
    for i:=0 to OracleHomeList.Count - 1 do
    begin
      TLogger.Debug(Format('Oracle home #%d',[i + 1]),OracleHomeList[i]);
    end;
  except
  end;

  // creazione critical section
  CSSessioniOracle:=TMedpCriticalSection.Create;
  CSSessioneMondoEDP:=TMedpCriticalSection.Create;
  CSFileLog:=TMedpCriticalSection.Create;
  CSStampa:=TMedpCriticalSection.Create;
  CSFileTemporanei:=TMedpCriticalSection.Create;
  CSAutenticazioneDominio:=TMedpCriticalSection.Create;
  CSFormatSettings:=TMedpCriticalSection.Create;
  CSNumSessioni:=TMedpCriticalSection.Create;
  CSClearMemory:=TMedpCriticalSection.Create;
  CSFontList:=TMedpCriticalSection.Create;
  CSDebugServer:=TMedpCriticalSection.Create;
  CSParametri:=TMedpCriticalSection.Create;
  CSSessioniAttive:=TMedpCriticalSection.Create;
  CtrlGeneraFileConfig; // solo per passaggio a 9.1

  {$IFDEF X001}
  OracleSession1:=TOracleSession.Create(nil);
  OracleSession1.NullValue:=nvNull;
  OracleSession1.Preferences.ZeroDateIsNull:=False;
  OracleSession1.Preferences.TrimStringFields:=False;
  OracleSession1.Preferences.UseOCI7:=False;
  OracleSession1.ThreadSafe:=True;
  OracleSession1.BytesPerCharacter:=bc1Byte;
  (* Solo per test
  OracleSession1.LogonDataBase:='IRIS9.world';
  OracleSession1.LogonUsername:='CUNEO1';
  OracleSession1.LogonPassword:='CUNEO1';
  OracleSession1.Logon;
  *)
  Azienda:=W000ParConfig.Azienda;
  OracleSession1.LogonDataBase:=W000ParConfig.Database;

  A000LogonDBOracle(OracleSession1);
  OracleSession1.Logon;
  selI090:=TOracleDataSet.Create(nil);
  with selI090 do
  begin
    Session:=OracleSession1;
    SQL.Text:='select utente, parolachiave from mondoedp.i090_enti t where t.azienda = ''' + Azienda + '''';
    Open;
    if RecordCount > 0 then
    begin
      Utente:=FieldByName('Utente').AsString;
      Pwd:=FieldByName('parolachiave').AsString;
    end;
  end;
  FreeAndNil(selI090);
  OracleSession1.Logoff;
  OracleSession1.LogonUsername:=Utente;
  OracleSession1.LogonPassword:=R180Decripta(Pwd,21041974);
  OracleSession1.Logon;
  {$ENDIF}

  { DONE : TEST IW 14 OK }
  (*IW_XIV//Spostato in OnConfig
  {$IFDEF WEBPJ}
  AppName:='IrisCloud';
    {$IFDEF RILPRE}AppName:=AppName + 'RILPRE';{$ENDIF}
    {$IFDEF PAGHE}AppName:=AppName + 'PAGHE';{$ENDIF}
    {$IFDEF STAGIU}AppName:=AppName + 'STAGIU';{$ENDIF}
  Description:='IrisCloud'; // usato nel titolo della finestra del browser
  DisplayName:='IrisCloud_Display';
  {$ELSE}
  AppName:='IrisWEB';
  Description:='IrisWEB'; // usato nel titolo della finestra del browser
  DisplayName:='IrisWEB_Display';
  {$ENDIF}
  *)

  W000NumSessioni:=0;
  W000NumMaxSessioni:=0;
  Compression.Enabled:=Pos(INI_PAR_COMPRESSION,W000ParConfig.ParametriAvanzati) > 0;

  {$IFNDEF INTRAWEBSVC}
  CaricaJQuery;
  {$ENDIF}

  SOA000RegistraMSG:=TOracleSession.Create(nil);
  SOA000RegistraMSG.LogonDataBase:=W000ParConfig.Database;
  SOA000RegistraMSG.LogonUsername:='MONDOEDP';
  SOA000RegistraMSG.Preferences.ZeroDateIsNull:=False;
  SOA000RegistraMSG.Preferences.TrimStringFields:=False;
  SOA000RegistraMSG.ThreadSafe:=True;
  SOA000RegistraMSG.BytesPerCharacter:=bc1Byte;
  SOA000RegistraMSG.StatementCache:=Pos(INI_PAR_DB_STATEMENT_CACHE,W000ParConfig.ParametriAvanzati) > 0;
  if SOA000RegistraMSG.StatementCache then
    SOA000RegistraMSG.StatementCacheSize:=10;
  R180SetOracleInstantClient;
  A000SettaVariabiliAmbiente;
  {$IFNDEF INTRAWEBSVC}
  try
    SOA000RegistraMSG.LogonPassword:=GetPassword(A000FilePwdApplication);
    SOA000RegistraMSG.Logon;
  except
    try
      SOA000RegistraMSG.LogonPassword:=GetPassword(A000FilePwdHost);
      SOA000RegistraMSG.Logon;
    except
      try
        SOA000RegistraMSG.LogonPassword:=A000PasswordFissa;
        SOA000RegistraMSG.Logon;
      except
      end;
    end;
  end;
  SOA000RegistraMSG.UseOCI80:=not SOA000RegistraMSG.Preferences.UseOCI7;
  A000RegistraMsg:=TRegistraMsg.Create(SOA000RegistraMSG);
  A000RegistraMsg.IniziaMessaggio('W000-' + Self.AppName);
  {$ENDIF}

  W000RegistraLog('Traccia',GetTestoLog + 'Inizializzazione servercontroller');

  if W000ParConfig.ComInitialization = INI_COM_NONE then
    ComInitialization:=ciNone
  else if W000ParConfig.ComInitialization = INI_COM_NORMAL then
    ComInitialization:=ciNormal
  else if W000ParConfig.ComInitialization = INI_COM_MULTI then
    ComInitialization:=ciMultiThreaded;

  W000RegistraLog('Sessione',GetTestoLog + 'Inizio nuova sessione di IrisWEB');

  { DONE : TEST IW 14 OK }
  (*IW_XIV //Spostato in OnConfig
  {$IFDEF WEBPJ}
  if not IsLibrary then
    URLBase:='/iriscloud';
  {$ENDIF}
  *)

  // porta di ascolto (solo servizio)
  {$IFDEF INTRAWEBSVC}
  Port:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','PORT','8081'),8081);
  {$ELSE}
  Port:=W000ParConfig.Port;
  {$ENDIF}

  // debug dei progetti singoli
  if StrToIntDef(Copy(gsAppName,3,3),-1) > 0 then
    Port:=6000 + StrToInt(Copy(gsAppName,3,3));

  // verifica permessi sottocartelle
  VerificaPermessiCartelle;

  lstSessioniOracle:=TObjectList.Create;
  lstSessioniOracle.OwnsObjects:=False;
  lstSessioniMondoEDP:=TObjectList.Create;
  lstSessioniMondoEDP.OwnsObjects:=False;

  // copia file personalizzati da wwwroot/Files nella cartella base di installazione
  CopiaFilePersonalizzati;

  // determina i file esterni da includere nelle pagine html
  GetFileEsterni;
  HTMLHeaders.Text:=GetHtmlHeaders;

  {$IFNDEF X001}
  {$IFNDEF INTRAWEBSVC}
  // pulizia vecchi templates W*.html
  PulisciTemplatesDir;
  //creazione nuovi templates W*.html
  InizializzaTemplatesDir(CartellaSuperiore(TemplateDir));
  InizializzaTemplatesDir(CartellaSuperiore(CartellaSuperiore(TemplateDir)) + PATH_TEMPLATE_CONDIVISI);
  {$ENDIF}
  {$ENDIF}

  locDataID:=IntToStr(HInstance) + FloatToStr(Now).Replace(',','');
  W000RegistraLog('Traccia',GetTestoLog + 'RpDefine.DataID=' + locDataID);
  RpDefine.DataID:=locDataID;//'W000'

  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then
  begin
    CoInitialize(nil);
  end;

  // inizializza il generatore di numeri casuali
  Randomize;

  lstIdSessioniAttive:=TStringList.Create;
  lstIdSessioniAttive.Sorted:=True;
  lstIdSessioniAttive.Duplicates:=dupIgnore;

  W000RegistraLog('Traccia',GetTestoLog + 'Inizializzazione servercontroller completata');
end;

procedure TA000FInterfaccia.PulisciTemplatesDir;
var
  ErrDel:Boolean;
  F:TSearchRec;
begin
  ErrDel:=False;
  if FindFirst(TemplateDir + 'W*.html',faAnyFile,F) = 0 then
  begin
    repeat
      if not DeleteFile(TemplateDir + F.Name) then
        ErrDel:=True;
    until FindNext(F) <> 0;
    FindClose(F);
  end;
  if ErrDel then
    W000RegistraLog('Errore',GetTestoLog + 'Errore durante pulizia templates');
end;

procedure TA000FInterfaccia.SegnaSessioneAttiva;
begin
  (* MAN/07 SVILUPPO#84 *)
  if Assigned(GGetWebApplicationThreadVar) and
     (not GGetWebApplicationThreadVar.Browser.IsMobile) and
     (Pos(INI_PAR_DISABLE_CHIUSURA_BROWSER,W000ParConfig.ParametriAvanzati) = 0)
  then
  begin
    TSessioneWeb(GGetWebApplicationThreadVar.Data).RipristinaTimeOut;
    try
      CSSessioniAttive.Enter;
      lstIdSessioniAttive.Add(GGetWebApplicationThreadVar.AppID);
    finally
      CSSessioniAttive.Leave;
    end;
    if (DebugHook <> 0) or TSessioneWeb(GGetWebApplicationThreadVar.Data).bDebugToFile then
      W000RegistraLog('Traccia',GGetWebApplicationThreadVar.AppID + ' --- session.timeout ripristinato in SegnaSessioneAttiva');
  end;
end;

procedure TA000FInterfaccia.InizializzaTemplatesDir(TDInput:String);
var
  i:Integer;
  Line,FrmTag,ReplaceFrmTag,ModelliDir:String;
  TagIntestazione: Boolean;
  LIntestazione,lstFileIncluso:TStringList;
  F:TSearchRec;
  function IncludiFile(const PFileIncluso: String): String;
  // restituisce il contenuto del file indicato
  var S:String;
  begin
    Result:='';
    {$IFNDEF X001}
    if PFileIncluso <> '' then
    begin
      if FileExists(PFileIncluso) then
      begin
        try
          lstFileIncluso.LoadFromFile(PFileIncluso{,TEncoding.UTF8});
          S:=lstFileIncluso.Text;
          //Pulizia dei caratteri 'strani' per evitare errori
          S:=StringReplace(S,'�','',[rfReplaceAll]);
          Result:=S;
        except
        end;
      end;
    end;
    {$ENDIF}
  end;
  procedure IncludiIntestazioneCustom;
  var T000IntSez1:String;
      i:Integer;
  const INTSEZ1 = 'T000_int_sez1.html';
  begin
    T000IntSez1:=IncludiFile(ModelliDir + INTSEZ1);
    if Trim(T000IntSez1) = '' then
      exit;
    for i:=0 to LIntestazione.Count - 1 do
      if Trim(LIntestazione[i]).ToUpper = Format('<!--%s.INIZIO-->',[INTSEZ1.ToUpper]) then
      begin
        repeat
          LIntestazione.Delete(i + 1);
        until (i + 1 > LIntestazione.Count - 1) or (Trim(LIntestazione[i + 1]).ToUpper = Format('<!--%s.FINE-->',[INTSEZ1.ToUpper]));
        LIntestazione.Insert(i + 1,T000IntSez1);
        Break;
      end;
  end;
begin
  try
    try
      // creazione dei template nuovi
      lstFileIncluso:=TStringList.Create;
      ModelliDir:=CartellaSuperiore(TemplateDir);
      LIntestazione:=TStringList.Create;
      LIntestazione.LoadFromFile(ModelliDir + 'T000Intestazione.html'{,TEncoding.UTF8});
      IncludiIntestazioneCustom;
      LIntestazione.Add('    {%Contenuto%}');
      if FindFirst(TDInput + 'T*.html',faAnyFile,F) = 0 then
        repeat
          // esclude il file di intestazione dal meccanismo
          if F.Name = 'T000Intestazione.html' then
            Continue;
          TagIntestazione:=False;
          with TStringList.Create do
          try
            LoadFromFile(TDInput + F.Name);
            for i:=0 to Count - 1 do
            begin
              Line:=Strings[i];
              // doctype
              if Pos('{%DocType%}',Line) > 0 then
                Strings[i]:=StringReplace(Line,'{%DocType%}',DOCTYPE_HTML,[]);
              if Pos('{%T000Intestazione%}',Line) > 0 then
              begin
                // intestazione e file P01_xxx
                Strings[i]:=StringReplace(Line,'{%T000Intestazione%}',LIntestazione.Text,[]) + CRLF +
                            IncludiFile(TDInput + 'P01_' + F.Name);
                TagIntestazione:=True;
              end;
              // frame da includere
              if Pos('{%<frm>',Line) > 0 then
              begin
                FrmTag:=Copy(Line,Pos('{%<frm>',Line) + 7,Pos('</frm>%}',Line) - Pos('{%<frm>',Line) -7);
                // per alleggerire il disegno della pagina i frame vengono inizialmente nascosti
                // (vedere file css principale: gli id dei frame hanno come style "display: none")
                ReplaceFrmTag:=Format(' <div id="%s">{%s}</div>',[FrmTag,'%' + FrmTag + '%']);
                if UpperCase(FrmTag) = 'WC002FDATIANAGRAFICIFM' then
                  ReplaceFrmTag:=ReplaceFrmTag + '<div class="frm" id="WC002FStoriaDipendenteFM">{%WC002FStoriaDipendenteFM%}</div>';
                Strings[i]:=StringReplace(Line,'{%<frm>' + FrmTag + '</frm>%}', ReplaceFrmTag,[]);
              end;
              if TagIntestazione and (Pos('</body>',Trim(Line)) > 0) then
              begin
                // file P02_xxx chiusura html
                Strings[i]:=IncludiFile(TDInput + 'P02_' + F.Name) + CRLF +
                            '    </div>' + CRLF +
                            '    <!--  fine contenuto -->' + CRLF +
                            '    <div id="separa_footer"></div>' + CRLF +
                            '    {%JavascriptBottom%} ' + CRLF +
                            '  </body>';
                TagIntestazione:=False;
              end;
            end;
            SaveToFile(TemplateDir + StringReplace(F.Name,'T','W',[]));
          finally
            Free;
          end;
        until FindNext(F) <> 0;
    finally
      FindClose(F);
      LIntestazione.Free;
      lstFileIncluso.Free;
    end;
  except
    on E:Exception do
      W000RegistraLog('Errore',GetTestoLog + 'TA000FInterfaccia.InizializzaTemplatesDir:' + E.Message);
  end;
end;

function  TA000FInterfaccia.CartellaSuperiore(Cartella:String):String;
begin
  if Cartella[length(Cartella)] = '\' then
    Cartella:=Copy(Cartella,1,Length(Cartella) - 1);
  Result:=TDirectory.GetParent(Cartella);
  if Result[length(Result)] <> '\' then
    Result:=Result + '\';
end;

procedure TA000FInterfaccia.VerificaPermessiCartelle;
// verifica permessi cartelle ai soli fini di log
var
  ElencoDir: array[0..4,0..3] of String;
  NomeFile: String;
  i: Integer;
  F: Integer;
const
  NOME_FILE_TEST = 'testWrite.txt';
begin
  { DONE : TEST IW 14 OK }
  ElencoDir[0,0]:=MEDPFilesDir; // path della directory da verificare
  ElencoDir[0,1]:='Files';  // nome parlante per la directory
  ElencoDir[0,2]:='S';      // S = considera, N = non considerare
  ElencoDir[0,3]:='N';      // S = forza creazione se non esistente, N = non creare se non esistente
  ElencoDir[1,0]:=TemplateDir;
  ElencoDir[1,1]:='Template';
  ElencoDir[1,2]:='S';
  ElencoDir[1,3]:='S';
  ElencoDir[2,0]:=CartellaSuperiore(TemplateDir);
  ElencoDir[2,1]:='Modelli html';
  ElencoDir[2,2]:='S';
  ElencoDir[2,3]:='N';
  ElencoDir[3,0]:=CartellaSuperiore(CartellaSuperiore(TemplateDir)) + PATH_TEMPLATE_CONDIVISI;
  ElencoDir[3,1]:='Modelli html condivisi';
  ElencoDir[3,2]:='S';
  ElencoDir[3,3]:='N';
  ElencoDir[4,0]:=CacheDir;
  ElencoDir[4,1]:='Cache';
  ElencoDir[4,2]:=IfThen(IsLibrary,'N','S');
  ElencoDir[4,3]:='N';

  // verifica permessi su directory utilizzate da irisweb
  for i:=0 to High(ElencoDir) do
  begin
    if ElencoDir[i,2] <> 'S' then
      Continue;

    // esistenza directory
    W000RegistraLog('Traccia',GetTestoLog + 'Cartella ' + ElencoDir[i,1] + ': ' + ElencoDir[i,0]);
    if not DirectoryExists(ElencoDir[i,0]) then
    begin
      if ElencoDir[i,3] = 'S' then
      begin
        if not ForceDirectories(ElencoDir[i,0]) then
        begin
          W000RegistraLog('Errore',GetTestoLog + 'Cartella ' + ElencoDir[i,1] + ': directory inesistente');
          Continue;
        end;
      end
      else
      begin
        W000RegistraLog('Errore',GetTestoLog + 'Cartella ' + ElencoDir[i,1] + ': directory inesistente');
        Continue;
      end;
    end;

    // creazione file
    NomeFile:=ElencoDir[i,0] + NOME_FILE_TEST;
    F:=FileCreate(NomeFile);
    if F = -1 then
      W000RegistraLog('Errore',GetTestoLog + 'Cartella ' + ElencoDir[i,1] + ': no permessi di scrittura [creazione file]')
    else
      W000RegistraLog('Traccia',GetTestoLog + 'Cartella ' + ElencoDir[i,1] + ': permessi di scrittura ok [creazione file]');
    FileClose(F);

    // cancellazione file
    if not DeleteFile(NomeFile) then
      W000RegistraLog('Errore',GetTestoLog + 'Cartella ' + ElencoDir[i,1] + ': no permessi di scrittura [cancellazione file]')
    else
      W000RegistraLog('Traccia',GetTestoLog + 'Cartella ' + ElencoDir[i,1] + ':permessi di scrittura ok [cancellazione file]');
  end;
end;

procedure TA000FInterfaccia.CopiaFilePersonalizzati;
// effettua la copia dei file personalizzati da wwwroot/Files
// alla cartella base di installazione
var
  i: Integer;
  PathSorg,FileSorg,Sorgente,
  PathDest,FileDest,Destinazione: String;
const
  FILES_PERSONALIZZATI: array[1..3] of String = (
    'err_limitesessioni.html',     // file di errore per supero sessioni max
    'err_httpstatus.html',  // pagina di errore personalizzata
    'maintenance.html' // pagina server in manutenzione
  );
begin
  try
    // imposta i path sorgente e destinazione
    { DONE : TEST IW 14 OK }
    PathSorg:=MEDPFilesDir;
    PathDest:=IncludeTrailingPathDelimiter(gsAppPath);

    // ciclo sui file personalizzati
    for i:=Low(FILES_PERSONALIZZATI) to High(FILES_PERSONALIZZATI) do
    begin
      // determina nome file sorgente e destinazione
      FileSorg:=FILES_PERSONALIZZATI[i];
      FileDest:=FileSorg;

      // determina path completi di sorgente e destinazione
      Sorgente:=PathSorg + FileSorg;
      Destinazione:=PathDest + FileDest;

      // se il file personalizzato non � presente effettua la copia
      // altrimenti lo lascia inalterato, per non sovrascrivere eventuali personalizzazioni
      if not TFile.Exists(Destinazione) then
      begin
        // controllo esistenza file sorgente
        if not TFile.Exists(Sorgente) then
          raise Exception.Create(Format('Verifica file personalizzati:'#13#10'file %s non presente.',[Sorgente]));

        // effettua copia
        TFile.Copy(Sorgente,Destinazione);
      end;
    end;
  except
    on E:Exception do
      W000RegistraLog('Errore',GetTestoLog + 'TA000FInterfaccia.CopiaFilePersonalizzati:' + E.Message);
  end;
end;

function TA000FInterfaccia.GetHtmlHeaders: String;
begin
  Result:='<title>' + Description + '</title>' + CRLF;
  (*
  Result:=Result + CRLF +
          META_HTML + CRLF +
          '<script type="text/javascript"> ' +
          '  var now = new Date(); ' +
          '  window.onload = function() { ' +
          '    document.getElementById("dataLavoro").innerHTML = (new Date()).getTime() - now.getTime(); ' +
          '  } ' +
          '  window.onerror = gestioneErrori; ' +
          '</script> ';
  *)
end;

procedure TA000FInterfaccia.GetFileEsterni;
// imposta il codice per includere i file javascript e css esterni
var
  i: Integer;
  S, JqueryExt: String;
  function ReplaceVersions(const S: String): String;
  begin
    Result:=StringReplace(S,'%JQUERY_UI_VER%',JQUERY_UI_VER,[]);
  end;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  if (DebugHook <> 0) or
     (Pos(INI_PAR_NO_UNIFIED_FILES,W000ParConfig.ParametriAvanzati) > 0) then
  begin
    // modalit� utilizzo file normali
    // in debug viene questa modalit� viene forzata!

    // determina file di jquery (minified / uncompressed)
    JqueryExt:=IfThen(Pos('JQUERY_UNCOMPRESSED',W000ParConfig.ParametriAvanzati) = 0,'.min','');

    // file css
    for i:=Low(FILES_CSS_DEBUG) to High(FILES_CSS_DEBUG) do
    begin
      S:=PATH_BASE_CSS + ReplaceVersions(FILES_CSS_DEBUG[i]);
      ContentFiles.Add(S);
    end;

    // file javascript
    for i:=Low(FILES_JS_DEBUG) to High(FILES_JS_DEBUG) do
    begin
      S:=PATH_BASE_JS + ReplaceVersions(FILES_JS_DEBUG[i]);
      ContentFiles.Add(S);
    end;
  end
  else
  begin
    // modalit� produzione - utilizzo file unificati e compressi
    // file css
    for i:=Low(FILES_CSS) to High(FILES_CSS) do
    begin
      S:=PATH_BASE_CSS + ReplaceVersions(FILES_CSS[i]);
      ContentFiles.Add(S);
    end;

    // file javascript
    for i:=Low(FILES_JS) to High(FILES_JS) do
    begin
      S:=PATH_BASE_JS + ReplaceVersions(FILES_JS[i]);
      ContentFiles.Add(S);
    end;
  end;
  {$WARN SYMBOL_PLATFORM ON}
end;

procedure TA000FInterfaccia.IWServerControllerBaseNewSession(ASession: TIWApplication);
var
  S,ParUrlBase,
  TempHost,TempIP,Err,ParForwardedFor: String;
  //MemoriaProc: Cardinal;
  Valida, AzioneGestita, Consenti, bDebugToFileEnabled: Boolean;
  lst:TList;
  i:Integer;
const
  IMG_FOLDER = 'img\';
{}function GetParam2String(Par:TStrings):String;
  var i:Integer;
  begin
    Result:='';
    for i:=0 to Par.Count - 1 do
      Result:=Result + IfThen(Result <> '','&') + Par[i];
  end;
begin
  // sessione temporanea: termina subito
  Valida:=GSessions.IsValidSession(ASession);
  if not Valida then
    Exit;

  if Pos('medpendsession',ASession.Request.PathInfo.ToLower) > 0 then
  begin
    ASession.Terminate;
    exit;
  end;
  // controllo supero max sessioni web accettate.ini
  if (W000ParConfig.MaxSessioni > 0) then
  begin
    lst:=GSessions.LockList;
    with lst do
    begin
      try
        try
          S:=Count.ToString; // non servirebbe, se il debugger funzionasse
          Consenti:=(Count <= W000ParConfig.MaxSessioni);
        except
          Consenti:=False;
        end;
      finally
        GSessions.UnLockList(lst);
      end;
    end;
    if not Consenti then
    begin
      // redirect su url responder
      if (Pos('http',W000ParConfig.UrlSuperoMaxSessioni.ToLower) = 1) and (WebApplication.ApplicationURL.ToLower <> W000ParConfig.UrlSuperoMaxSessioni.ToLower) then
      begin
        S:=W000ParConfig.UrlSuperoMaxSessioni;
        if (ASession.RunParams.Count >= 1) then
        begin
          // parametri passati con metodi propri di intraweb
          //ListaPar:=GGetWebApplicationThreadVar.RunParams;
          S:=S + '?' + GetParam2String(GGetWebApplicationThreadVar.RunParams);
        end
        else if (GGetWebApplicationThreadVar.Request.ContentFields.Count >= 1) then
        begin
          // metodo POST
          //ListaPar:=GGetWebApplicationThreadVar.Request.ContentFields;
        end
        else if GGetWebApplicationThreadVar.Request.QueryFields.Count >= 1 then
        begin
          // metodo GET
          //ListaPar:=GGetWebApplicationThreadVar.Request.QueryFields;
        end
        else
        begin
          // HEADER HTTP personalizzati
          //ListaPar:=GGetWebApplicationThreadVar.Request.RawHeaders;
        end;
      end
      else if (Pos('about:',W000ParConfig.UrlSuperoMaxSessioni.ToLower) = 1) then
        S:=W000ParConfig.UrlSuperoMaxSessioni
      else
        S:=WebApplication.ApplicationURL + '/' + WC000UErrLimiteSessioni.URL_PATH;

      ASession.TerminateAndRedirect(S);
      exit;
    end;
  end;
  // controllo supero max sessioni web accettate.fine

  bDebugToFileEnabled:=False;
  // operazioni di supporto all'applicazione.ini
  if ASession.RunParams.Count >= 1 then
  begin
    if ASession.RunParams.IndexOf(WEB_ACT_DEBUG_TO_FILE) > -1 then
    begin
      // indica all'applicativo di eseguire un debug su file
      { DONE : TEST IW 14 OK }
      (*TEST_IW_XIV//ASession.RedirectURL:=WEB_ACT_DEBUG_TO_FILE;*)
      bDebugToFileEnabled:=True;
      ASession.Request.ContentFields.Add(WEB_FLAG_DEBUG_TO_FILE + '=S');
      DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - inizio metodo',True);
    end;
    if ASession.RunParams.Count = 1 then
    begin
      // parametro singolo per azioni specifiche
      AzioneGestita:=False;
      S:=UpperCase(ASession.RunParams[0]);

      if S = UpperCase(WEB_ACT_PING) then
      begin
        // semplice ping dell'applicativo
        AzioneGestita:=True;
      end
      else if S = UpperCase(WEB_ACT_GETFILECONFIG) then
      begin
        // rilettura parametri di configurazione
        A000GetFileConfig;
        ImpostaSecurityServerController;
        ImpostaExcLoggerEccezioniIgnorate;
        AzioneGestita:=True;
      end;

      // se � stata gestita un'azione particolare che non richiede ulteriori azioni
      // restituisce un messaggio di ok e termina immediatamente
      if AzioneGestita then
      begin
        ASession.Terminate(Format('%s: ok',[S]));
        Exit;
      end;
    end;
  end;
  // operazioni di supporto all'applicazione.fine

  W000RegistraLog('Sessione',GetTestoLog('A000',ASession) + 'NewSession');

  (*annullato
  // log utilizzo memoria
  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - CSClearMemory: attesa per Enter');
  CSClearMemory.Enter;
  try
    DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - CSClearMemory: dentro la critical section');
    MemoriaProc:=C190GetMemoriaUsata;
    W000RegistraLog('Memoria',GetTestoLog('A000',ASession) + 'NewSession;Utilizzo: ' + IntToStr(trunc(MemoriaProc / 1024)) + ' Kb');
  finally
    CSClearMemory.Leave;
    DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - CSClearMemory: Leave effettuata');
  end;
  *)

  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - ASession.Data: prima di creazione');
  ASession.Data:=TSessioneWeb.Create(ASession);
  { DONE : TEST IW 14 OK }
  //ASession.Data as TSessioneWeb).bDebugToFile:=(ASession.RedirectURL = WEB_ACT_DEBUG_TO_FILE);*)
  (ASession.Data as TSessioneWeb).bDebugToFile:=bDebugToFileEnabled;
  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - ASession.Data: creazione completata');

  //Inizio gestione header x-forwarded-for
  ParForwardedFor:='';
  if ASession <> nil then
  begin
    try
      if Assigned(ASession.Request) then
      begin
        for i:=0 to ASession.Request.RawHeaders.Count - 1 do
        begin
          if ASession.Request.RawHeaders[i].StartsWith(Format('%s:',['x-forwarded-for']),True) then
          begin
            ParForwardedFor:=ASession.Request.RawHeaders[i].Substring('x-forwarded-for'.Length + 1).Trim;
            Break;
          end;
        end;
      end;
    except end;
  end;
  if ParForwardedFor <> '' then
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.ClientIPInfo.IPClient:=ParForwardedFor
  else
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.ClientIPInfo.IPClient:=Asession.Request.RemoteAddr;
  //Fine gestione header x-forwarded-for

  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.ClientIPInfo.IPLocale:=Asession.Request.RemoteAddr;
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Name:='IRISWEB';

  //Default (RILPRE)
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.Applicazione:='RILPRE';
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.NomePJ:='Presenze-Assenze';
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.VersionePJ:=VersionePA;
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.BuildPJ:=BuildPA;
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.DataPJ:=DataPA;
  {$IFDEF PAGHE}
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.Applicazione:='PAGHE';
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.NomePJ:='Gestione economica';
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.VersionePJ:=VersioneGE;
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.BuildPJ:=BuildGE;
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.DataPJ:=DataGE;
  {$ENDIF}
  {$IFDEF STAGIU}
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.Applicazione:='STAGIU';
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.NomePJ:='Stato giuridico';
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.VersionePJ:=VersioneSG;
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.BuildPJ:=BuildSG;
  (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.DataPJ:=DataSG;
  {$ENDIF}

  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - R180GetIPFromHost: invocata');
  if R180GetIPFromHost(TempHost,TempIP,Err) then
  begin
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.HostName:=TempHost;
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.HostIPAddress:=TempIP;
  end
  else
  begin
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.HostName:='localhost';
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.HostIPAddress:='127.0.0.1';
  end;
  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - R180GetIPFromHost: effettuata');
  {$IFDEF WEBPJ}
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Name:='WEBPJ';
    {$IFDEF PAGHE}
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.Applicazione:='PAGHE';
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.NomePJ:='Gestione economica';
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.VersionePJ:=VersioneGE;
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.DataPJ:=DataGE;
    {$ENDIF}
    {$IFDEF STAGIU}
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.Applicazione:='STAGIU';
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.NomePJ:='Gestione giuridica';
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.VersionePJ:=VersioneSG;
    (ASession.Data as TSessioneWeb).SessioneIrisWIN.Parametri.DataPJ:=DataSG;
    {$ENDIF};
  {$ENDIF};

  {$IFNDEF X001}
  //TSessioneWeb(ASession.Data).W001FIrisWebDtM:=TW001FIrisWebDtM.Create(ASession);

  // timeout di sessione e caricamento icone della toolbar
  with (ASession.Data as TSessioneWeb).WR000DM do
  begin
    TimeoutDip:=W000ParConfig.TimeoutDip;
    TimeoutOper:=W000ParConfig.TimeoutOper;
    UsrFolder:=CustomFilesDir + IMG_FOLDER;
    BaseFolder:=ContentPath + IMG_FOLDER;
    try
      CaricaImmagini;
    except
      on E:Exception do
        W000RegistraLog('Errore',GetTestoLog + E.Message);
    end;
  end;

  // il timeout � impostato inizialmente a 2 minuti (per login)
  // tranne che in debug
  {$WARN SYMBOL_PLATFORM OFF}
  if DebugHook <> 0 then
  {$WARN SYMBOL_PLATFORM ON}
    ASession.SessionTimeOut:=999
  else
    ASession.SessionTimeOut:=2;
  {$ELSE}
  // X001: il timeout di sessione � quello dell'utente web
  ASession.SessionTimeOut:=W000ParConfig.TimeoutDip;
  {$ENDIF}

  // url per redirect dopo logout (utilizzato anche nel redirect dopo timeout)
  S:=W000ParConfig.Home;
  if Trim(S) <> '' then
  begin
    // gestione variabili
    if Pos('(URLBASE)',UpperCase(S)) > 0 then
    begin
      // URLBASE = directory base applicazione
      ParUrlBase:=StringReplace(ASession.AppURLBase,'/W000PIrisWEB_IIS.dll','',[rfIgnoreCase]);
      S:=StringReplace(S,'(URLBASE)',ParUrlBase,[rfIgnoreCase]);
      W000RegistraLog('Traccia',GetTestoLog('A000',ASession) + 'NewSession;HomeUrl = ' + IfThen(S = '','non impostata',S));
    end;
    (ASession.Data as TSessioneWeb).HomeUrl:=S;
  end;

  // incrementa numero sessioni
  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - CSNumSessioni: attesa per Enter');
  CSNumSessioni.Enter;
  try
    DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - CSNumSessioni: dentro la critical section');
    W000NumSessioni:=W000NumSessioni + 1;
    if W000NumSessioni > W000NumMaxSessioni then
      W000NumMaxSessioni:=W000NumSessioni;
  finally
    CSNumSessioni.Leave;
    DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - CSNumSessioni: Leave effettuata');
  end;
  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseNewSession - fine metodo');
end;

procedure TA000FInterfaccia.IWServerControllerBaseAfterRender(ASession: TIWApplication; AForm: TIWBaseForm);
begin
  (* MAN/07 SVILUPPO#84 *)
  SegnaSessioneAttiva;
end;

procedure TA000FInterfaccia.IWServerControllerBaseBeforeDispatch(Request: THttpRequest; aReply: THttpReply);
var
  Session: TIWApplication;
  fs: TFileStream;
  LstRequest: TStringList;
  S: string;
  sLog: string;
begin
(* MAN/07 SVILUPPO#84 *)
  if (Pos(INI_PAR_DISABLE_CHIUSURA_BROWSER,W000ParConfig.ParametriAvanzati) = 0) and
     (Pos('/medpendsession', Lowercase(Request.PathInfo)) > 0) then
  begin
    //Lettura dati della Request
    S:=Request.ContentFields.Values['GAppID']; //ContentFields: funziona solo in IIS (testato su tutti i browser desktop)
    if S <> '' then
      sLog:='Request.ContentFields --- ' + S
    else if Request.Files.Count > 0 then      //Files: funziona solo in modalit� stand-alone (testato su tutti i browser desktop tranne IE)
    try
      fs:=TFileStream.Create(Request.Files[0].TempPathName, fmOpenRead or fmShareDenyNone);
      LstRequest:=TStringList.Create;
      LstRequest.LoadFromStream(fs);
      S:=LstRequest.values['GAppID'];
      if S <> '' then
        sLog:='Request.Files --- ' + S;
    finally
      fs.Free;
      FreeAndNil(LstRequest);
    end
    else                                      //per IE si legge direttamente la sessione da Request.PathInfo, che andrebbe bene anche negli altri casi sopra, ma l'info non � molto strutturata e non varrebbe per dati diversi dall'id di sessione.
    begin
      S:=Request.PathInfo.substring(Pos('/',Request.PathInfo));
      S:=AnsiLeftStr(S,S.length-S.substring(Pos('/$/',S)).length-1);
      if S <> '' then
        sLog:='Request.PathInfo --- ' + S;
    end;

    if S <> '' then
    begin
      //lstIdSessioniAttive per controllare se l'AfterRender � scattato prima della fine del BeforeDispatch
      if lstIdSessioniAttive.IndexOf(S) >= 0 then
      try
        CSSessioniAttive.Enter;
        lstIdSessioniAttive.Delete(lstIdSessioniAttive.IndexOf(S));
      finally
        CSSessioniAttive.Leave;
      end;

      Session:=GSessions.LookupAndLock(S);
      if Assigned(Session) then
      begin
        try
          if lstIdSessioniAttive.IndexOf(S) < 0 then //se > 0 � scattato l'AfterRender (in anticipo) quindi il TimeOut non deve essere ridotto
          begin
            Session.MarkAccess;         // Necessario forzare l'aggiornamento dell'ora di ultimo accesso per evitare che la sessione sia erroneamente vista come scaduta (--> TIWSessions.RemoveExpiredSessions)
            Session.SessionTimeOut:=2;  // Session.SessionTimeOut:=1 NON funziona! (bug)
          end;
        finally
          Session.Unlock;
        end;
        sLog:=sLog + ' --- session.timeout = ' + inttostr(Session.SessionTimeOut);
        if (DebugHook <> 0) or TSessioneWEB(Session.Data).bDebugToFile then
        begin
          if sLog <> '' then
            W000RegistraLog('Traccia',sLog);
        end;
      end;
    end;
  end;
  (* MAN/07 SVILUPPO#84 - fine *)

  if not EseguiTestHeaderAntiXSS(Request) then
  begin
    raise ETentativoXSSException.Create(A000MSG_ERR_GENERICO);
  end;
end;

procedure TA000FInterfaccia.IWServerControllerBaseSessionRestarted(aSession: TIWApplication);
begin
  { DONE : TEST IW 14 OK }
  (* Nuovo metodo *)
  //Imposto l'url da raggiungere in caso di timeout
  if W000ParConfig.UrlLoginErrato.Trim <> '' then
    ASession.TerminateAndRedirect(W000ParConfig.UrlLoginErrato)
  else if W000ParConfig.Home.Trim <> '' then
    ASession.TerminateAndRedirect(W000ParConfig.Home);
end;

procedure TA000FInterfaccia.IWServerControllerBaseBrowserCheck(ASession: TIWApplication; var rBrowser: TBrowser);
var
  MinVersion: single;
begin
  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseBrowserCheck - inizio metodo');
  rBrowser.AllowOlderBrowsers:=True;

  // chiamata 73338.ini
  // workaround per funzione SendFile con https su IE7
  // IE7 finge di essere IE8
  if (ASession.SecureMode) and           // SecureMode = true se si � in https
     (rBrowser is TInternetExplorer) and
     (rBrowser.Version = 7) then
  begin
    MinVersion:=rBrowser.MinSupportedVersion;
    rBrowser.Free;
    rBrowser:=TInternetExplorer.Create(MinVersion);
  end;

  //in caso di ws rest forzo il browser chrome per evitare incompatibilit� con intraweb
  {$IFDEF INTRAWEBSVC}
  if ASession.Request.PathInfo.StartsWith(URL_WS_B021) then
  begin
    rBrowser.Free;
    rBrowser:=TChrome.Create(TChrome.MIN_VERSION);
  end;
  {$ENDIF}

  // chiamata 73338.fine
  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseBrowserCheck - fine metodo');
end;

procedure TA000FInterfaccia.IWServerControllerBaseCloseSession(ASession: TIWApplication);
//var MemoriaProcByte: Cardinal;
begin
  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - inizio metodo');
  W000RegistraLog('Sessione',GetTestoLog('A000',ASession) + 'CloseSession');

  (*annullato
  // log utilizzo memoria e controllo max limite memoria
  if (CSClearMemory <> nil) and (W000ParConfig.MaxWorkingMemMb > 0) then
  try
    // log utilizzo memoria
    DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - CSClearMemory: attesa per Enter');
    CSClearMemory.Enter;
    DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - CSClearMemory: dentro la critical section');
    MemoriaProcByte:=C190GetMemoriaUsata;
    W000RegistraLog('Memoria',GetTestoLog('A000',ASession) + 'CloseSession;Utilizzo: ' + IntToStr(trunc(MemoriaProcByte / 1024)) + ' Kb');

    // controllo limite memoria
    if MemoriaProcByte > (W000ParConfig.MaxWorkingMemByte) then
    begin
      DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - EmptyWorkingSet iniziato');
      EmptyWorkingSet(GetCurrentProcess);
      DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - EmptyWorkingSet completato');
    end;
  finally
    CSClearMemory.Leave;
    DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - CSClearMemory: Leave effettuata');
  end;
  *)

  if (ASession <> nil) and
     (ASession.Data <> nil) and
     (ASession.Data is TSessioneWeb)  then
  begin
    // thread elaborazione.ini
    if (ASession.Data as TSessioneWeb).FThreadElaborazione <> nil then
    begin
      DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - Distruzione thread elaborazione');
      // distruzione thread elaborazione se presente
      try
        if (ASession.Data as TSessioneWeb).FThreadElaborazione.Stato = teSuspended then
        begin
          (*Capita quando la sessione viene chiusa non per timeout ma per cause esterne.
            E' necessario eseguire il Terminate e poi il Resume, altrimenti il FreeAndNil attende il Timeout del Thread
          *)
          (ASession.Data as TSessioneWeb).FThreadElaborazione.Terminate;
          try
            (ASession.Data as TSessioneWeb).FThreadElaborazione.MedpResume;
          except
          end;
        end;
        (*Si deve gestire la corretta chiusura delle procedure che sono state richiamate dal thread,
          che in questo caso verrano interrotte dall'eccezione EThreadElaborazioneException
        *)
        FreeAndNil((ASession.Data as TSessioneWeb).FThreadElaborazione);
      except
      end;
    end;
    // thread elaborazione.fine

    if ((ASession.Data as TSessioneWeb).SessioneIrisWIN <> nil) then
    begin
      if CSSessioniOracle <> nil then
      try
        DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - CSSessioniOracle: attesa per Enter');
        CSSessioniOracle.Enter;
        try
          DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - CSSessioniOracle: dentro la critical section');
          {$IFDEF WEBPJ}//IrisCloud: tag fisso a 0
          (ASession.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Tag:=0;
          {$ELSE}        //IrisWEB: tag fisso a 0 se una sessione db per ogni sessione web, altrimenti decremento il tag
          if (W000ParConfig.CursoriSessione >= W000ParConfig.MaxOpenCursors) then
            (ASession.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Tag:=0
          else if (ASession.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Tag > 0 then
          begin
            (ASession.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Tag:=(ASession.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Tag - 1;
            W000RegistraLog('Sessione',GetTestoLog('A000',ASession) + 'Chiusura SessioneOracle - tag=' + IntToStr((ASession.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Tag));
          end;
          {$ENDIF WEBPJ}
        finally
          CSSessioniOracle.Leave;
          DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - CSSessioniOracle: Leave effettuata');
        end;
      except
        on E:Exception do
          W000RegistraLog('Errore',GetTestoLog('A000',ASession) + 'CloseSessionB' + E.ClassName + '/' + E.Message);
      end;

      if CSNumSessioni <> nil then
      try
        DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - CSNumSessioni: attesa per Enter');
        CSNumSessioni.Enter;
        DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - CSNumSessioni: dentro la critical section');
        W000NumSessioni:=W000NumSessioni - 1;
      finally
        CSNumSessioni.Leave;
        DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - CSNumSessioni: Leave effettuata');
      end;
    end;
  end;

  (*!BUG FIX! (Alberto 01/09/2016)
    Distruggo esplicitamente i datamodule che hanno owner = nil:
    Nel caso di elaborazione cartellino mensile W009/WA027,
    se durante l'elaborazione chiudo il browser,
    quando la sessione va in timeout il Server Controller si blocca.

  Sembra che sia dovuto ai datamoduli ma in produzione d� ancora pi� problemi
  Al momento l'unica soluzione � aumentare il timeout al massimo (per es. 999)

  for i:=ASession.FormCount - 1 downto 0 do
    if ASession.Forms[i] is TDataModule then
      if ASession.Forms[i].Owner = nil then
        if Copy(ASession.Forms[i].Name,1,4) = 'C004' then
          (ASession.Forms[i] as TDataModule).Free;
  *)

  DebugToFile(ASession,'TA000FInterfaccia.IWServerControllerBaseCloseSession - fine metodo');
end;

procedure TA000FInterfaccia.IWServerControllerBaseConfig(Sender: TObject);
begin
  // OnConfig viene richiamato prima di OnCreate.
  CSParConfig:=TMedpCriticalSection.Create;
  A000GetFileConfig;
  ImpostaSecurityServerController;

  (*
   * Se impostato a true consente di aprire pi� sessioni anche con utenze diverse dallo stesso browser
   * (Vedi http://docs.atozed.com/docs.dll/Classes/TIWServerControllerBase.html default=True)
   * ma il codice identificativo della sessione sar� messo nelle url delle richieste, se impostato a false
   * sar� consentita una sola connessione per browser ma l'identificativo non verr� visualizzato nelle url
   *)
  AllowMultipleSessionsPerUser:=not(Pos(INI_PAR_SESSIONE_SINGOLA_PER_USR,W000ParConfig.ParametriAvanzati) > 0);

  { DONE : TEST IW 14 OK }
  { Nuovo metodo }
  {$IFDEF WEBPJ}
  AppName:='IrisCloud';
    {$IFDEF RILPRE}AppName:=AppName + 'RILPRE';{$ENDIF}
    {$IFDEF PAGHE}AppName:=AppName + 'PAGHE';{$ENDIF}
    {$IFDEF STAGIU}AppName:=AppName + 'STAGIU';{$ENDIF}
  Description:='IrisCloud'; // usato nel titolo della finestra del browser
  DisplayName:='IrisCloud_Display';
  {$ELSE}
  AppName:='IrisWEB';
  Description:='IrisWEB'; // usato nel titolo della finestra del browser
  DisplayName:='IrisWEB_Display';
  {$ENDIF}
  {$IFDEF INTRAWEBSVC}
  AppName:='B021FServerContainer';//'B021FServerContainer';
  Description:='B021FIrisRestSvc';
  DisplayName:='B021FIrisRestSvc_Display';
  {$ENDIF}

  {$IFDEF WEBPJ}
  if not IsLibrary then
    URLBase:='/iriscloud';
  {$ENDIF}

  // Per ottenere file statici senza passare per la gestione delle sessioni
  // bisogna registrare il tipo di file. Da TIWMimeTypes.Init() vengono
  // gi� registrati come statici:
  // JS,CSS,PNG,JPG,JPEG,JPE,GIF,WAV,OGG,MP3,WMV,MOV,AVI,MPG,MPEG,SWF,ZIP,PDF,
  // XML,ICO,TXT,RSS,GZ,GZIP,WOFF,WOFF2,EOT,TTF,OTF,SVG.
  TIWMimeTypes.RegisterType('.bmp','image/bmp',True);
  TIWMimeTypes.RegisterType('.rtf','application/rtf',True);
  TIWMimeTypes.RegisterType('.xls','application/vnd.ms-excel',True);
  TIWMimeTypes.RegisterType('.xlsx','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',True);
  TIWMimeTypes.RegisterType('.doc','application/msword',True);
  TIWMimeTypes.RegisterType('.docx','application/vnd.openxmlformats-officedocument.wordprocessingml.document',True);
  TIWMimeTypes.RegisterType('.reg','application/octet-stream',True);
  RegisterContentType('application/json');
  RegisterContentType('text/plain'); (* MAN/07 SVILUPPO#84 - Necessario per leggere Request.Files in IWServerControllerBaseBeforeDispatch *)

  // Abilitazione dell'exception logger integrato
  // Le property di ExceptionLogger devono necessariamente essere modificate qui.
  // La scrittura delle property di questo oggetto non � thread safe.
  ExcLoggerEccezioniIgnorate:=nil;
  if W000ParConfig.IWExcLogAbilitato then
  begin
    ExcLoggerEccezioniIgnorate:=TStringList.Create;
    ExcLoggerEccezioniIgnorate.CaseSensitive:=False;

    if (W000ParConfig.IWExcLogPathFile <> '') then
      ExceptionLogger.FilePath:=W000ParConfig.IWExcLogPathFile;
    if W000ParConfig.IWExcLogNomeFile <> '' then
      ExceptionLogger.FileName:=W000ParConfig.IWExcLogNomeFile;
    if W000ParConfig.IWExcLogGiorniRimoz > 0 then
      ExceptionLogger.PurgeAfterDays:=W000ParConfig.IWExcLogGiorniRimoz;

    // In teoria IW dovrebbe cancellare i log pi� vecchi di <ExceptionLogger.PurgeAfterDays>
    // giorni all'arresto del server, dato che alle volte IW non sembra terminare correttamente,
    // effettuiamo la pulizia anche adesso
    ExceptionLogger.PurgeFiles;

    ExceptionLogger.Enabled:=True;

    ImpostaExcLoggerEccezioniIgnorate;
  end;
end;

procedure TA000FInterfaccia.IWServerControllerBaseDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to lstSessioniMondoEDP.Count - 1 do
  try
    if lstSessioniMondoEDP[i] <> nil then
      TOracleSession(lstSessioniMondoEDP[i]).Free;
  except
  end;
  for i:=0 to lstSessioniOracle.Count - 1 do
  try
    if lstSessioniOracle[i] <> nil then
      TOracleSession(lstSessioniOracle[i]).Free;
  except
  end;
  // dealloca oggetti list
  try FreeAndNil(lstSessioniOracle); except end;
  try FreeAndNil(lstSessioniMondoEDP); except end;
  // debug su file
  if lstDebugToFile <> nil then
    try FreeAndNil(lstDebugToFile); except end;
  if lstDebugServer <> nil then
    try FreeAndNil(lstDebugServer); except end;
  // dealloca criticalsection
  try FreeAndNil(CSSessioniOracle); except end;
  try FreeAndNil(CSSessioneMondoEDP); except end;
  try FreeAndNil(CSFileLog); except end;
  try FreeAndNil(CSStampa); except end;
  try FreeAndNil(CSFileTemporanei); except end;
  try FreeAndNil(CSAutenticazioneDominio); except end;
  try FreeAndNil(CSFormatSettings); except end;
  try FreeAndNil(CSNumSessioni); except end;
  try FreeAndNil(CSClearMemory); except end;
  try FreeAndNil(CSParConfig); except end;
  try FreeAndNil(CSFontList); except end;
  try FreeAndNil(CSDebugServer); except end;
  try FreeAndNil(CSParametri); except end;
  try FreeAndNil(CSSessioniAttive); except end;
  // dealloca oraclesession
  try FreeAndNil(SOA000RegistraMSG); except end;
  try FreeAndNil(A000RegistraMsg); except end;
  if ExcLoggerEccezioniIgnorate <> nil then
    FreeAndNil(ExcLoggerEccezioniIgnorate);
  FreeAndNil(lstIdSessioniAttive);
end;

procedure TA000FInterfaccia.IWServerControllerBaseException(AApplication: TIWApplication; AException: Exception; var Handled: Boolean);
var
  LActiveForm: TWR010FBase;
  LCodFormAttiva: String;
  LErrMsg: String;
  LCode: String;
{$IFDEF madExcept}
  LBugReport: UnicodeString;
const
  LBL_APPERRORDETAILS = 'Dettagli errore';
  BTN_DETTAGLI        = 'Dettagli';
  (*
  // vedere in future release
  BTN_INVIAREPORT     = 'Invia segnalazione';
  *)
{$ENDIF madExcept}
begin
  {$IFDEF madExcept}
  HandleException(etNormal, AException, nil, True, Esp, Ebp, nil, {esISAPI} esIntraweb, AApplication, 0, @LBugReport);
  {$ENDIF madExcept}

  if (AApplication = nil) or (AException is ETentativoXSSException) then
  begin
    Handled:=False;
    Exit;
  end;

  LCodFormAttiva:='#N/D#';

  // messaggio di errore
  LErrMsg:=A000TraduzioneEccezioni(AException.Message);
  if AException is EThreadElaborazioneException then
    LErrMsg:=Format('Elaborazione in corso: %s'#13#10'(thread elaborazione)',[LErrMsg]);
  LErrMsg:=LErrMsg.Trim;

  try
    if Assigned(AApplication) then
    begin
      // determina la form sulla quale si � verificato l'errore
      if Assigned(AApplication.ActiveForm) then
      begin
        // visualizza segnalazione di errore sulla form attiva
        LActiveForm:=(AApplication.ActiveForm as TWR010FBase);
        LCodFormAttiva:=R180DimLung(LActiveForm.medpCodiceForm,5);

        LCode:=Format(
               // popola i messaggi di errore
               '$("#txtAppError").text("%s");                              '#13#10 +
               {$IFDEF madExcept}
               '$("#lblAppErrorDetails").text("%s");                       '#13#10 +
               '$("#txtAppErrorDetails").html("%s");                       '#13#10 +
               {$ENDIF madExcept}

               // prepara e visualizza la dialog di errore
               '$("#dlgAppError").dialog({                                 '#13#10 +
               '  modal: true,                                             '#13#10 +
               '  height: "auto",                                          '#13#10 +
               '  width: 400,                                              '#13#10 +
               '  closeOnEscape: false,                                    '#13#10 +
               '  open: function(event, ui) {                              '#13#10 +
               '    $(".ui-dialog-titlebar-close", ui.dialog | ui).hide(); '#13#10 +
               '  },                                                       '#13#10 +
               '  buttons:  [                                              '#13#10 +
               {$IFDEF madExcept}
               '    {                                                      '#13#10 +
               '      id: "btn-dettagli",                                  '#13#10 +
               '      text: "%s",                                          '#13#10 +
               '      class: "pulsante",                                   '#13#10 +
               '      click: function() {                                  '#13#10 +
               '        $("#bugReport").toggle();                          '#13#10 +
               '      }                                                    '#13#10 +
               '    },                                                     '#13#10 +
               (*
               // vedere in future release
               '    {                                                      '#13#10 +
               '      id: "btn-inviareport",                               '#13#10 +
               '      text: "%s",                                          '#13#10 +
               '      class: "pulsante",                                   '#13#10 +
               '      click: function() {                                  '#13#10 +
               '        $("#btn-inviareport").button("disable").button("option","label","Invio in corso..." );                   '#13#10 +
               '        var myForm = "%s";                                 '#13#10 +
               '        var callbackFn = myForm + "." + "OnInviaBugReport";'#13#10 +
               '        var idBugReport = %d                               '#13#10 +
               '        processAjaxEvent("&idBugReport=" + idBugReport,null,callbackFn,false,null,false);  '#13#10 +
               '        //$("#btn-inviareport").button("disable");         '#13#10 +
               '      }                                                    '#13#10 +
               '    },                                                     '#13#10 +
               *)
               {$ENDIF madExcept}
               '    {                                                      '#13#10 +
               '       text: "OK",                                         '#13#10 +
               '       class: "pulsante",                                  '#13#10 +
               '       click: function() {                                 '#13#10 +
               '         $(this).dialog("close");                          '#13#10 +
               '       }                                                   '#13#10 +
               '    }                                                      '#13#10 +
               '  ]                                                        '#13#10 +
               '});                                                        '#13#10,
               [C190EscapeJS(A000TraduzioneEccezioni(LErrMsg))
                {$IFDEF madExcept}
                ,
                LBL_APPERRORDETAILS,
                C190EscapeJS(LBugReport),
                BTN_DETTAGLI
                (*
                // vedere in future release
                BTN_INVIAREPORT,
                LActiveForm.medpJSCallbackName
                IdBugReport
                *)
                {$ENDIF madExcept}
               ]);
        if AApplication.IsCallBack then
          AApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA(LCode)
        else
          LActiveForm.AddToInitProc(LCode);
      end
      else
      begin
        // non esiste una form attiva
        // il problema potrebbe essere legato al datamodulo condiviso
        if Assigned(AApplication.Data) and
           Assigned((AApplication.Data as TSessioneWeb).WR000DM) then
        begin
          LCodFormAttiva:='W001D';
        end;
      end;
    end;

    if AException is EThreadElaborazioneException then
      LErrMsg:=LErrMsg + ' ' + (AException as EThreadElaborazioneException).DescrizioneContesto;
    if AException is EInvalidPointer then
      LErrMsg:=LErrMsg + ', ' + GetElencoFormAttive;
    if AException is EAccessViolation then
      LErrMsg:=LErrMsg + ', ' + GetElencoFormAttive;

    // messaggio di log
    W000RegistraLog('Errore',Format('%s[%s]%s(%s)',[GetTestoLog('A000',AApplication),LCodFormAttiva,LErrMsg,AException.ClassName]), AException);
  except
  end;
  Handled:=True;
end;

procedure TA000FInterfaccia.A000GetFileConfig;
// lettura thread-safe dei parametri di configurazione dell'applicativo
// per info sui parametri v. dichiarazione del tipo record TParConfig
var
  IniFile: TIniFile;
begin
  CSParConfig.Enter;
  try
    { DONE : TEST IW 14 OK }
    IniFile:=TIniFile.Create(IncludeTrailingPathDelim(gsAppPath) + FILE_CONFIG);
    try
      // ### 1. parametri salvati su file ###

      // sezione impostazioni operative
      W000ParConfig.Database:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_DATABASE,'');
      W000ParConfig.Azienda:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_AZIENDA,'');
      W000ParConfig.Profilo:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_PROFILO,'');
      W000ParConfig.MaxSessioni:=IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_MAX_SESSIONI,0);
      W000ParConfig.UrlSuperoMaxSessioni:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,'');
      {$IFDEF RILPRE}W000ParConfig.UrlSuperoMaxSessioni:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS_RILPRE,'');{$ENDIF}
      {$IFDEF PAGHE}W000ParConfig.UrlSuperoMaxSessioni:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS_PAGHE,'');{$ENDIF}
      {$IFDEF STAGIU}W000ParConfig.UrlSuperoMaxSessioni:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS_STAGIU,'');{$ENDIF}
      W000ParConfig.TimeoutOper:=IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_OPER,30);
      // Su IW14/15 effettuare il set della property SessionTimeout non ha effetto (resta il vecchio valore)
      // Imposto a 2 minuti nel caso sia stato impostato 1 nel file di configurazione
      if W000ParConfig.TimeoutOper = 1 then
        W000ParConfig.TimeoutOper:=2;

      W000ParConfig.TimeoutDip:=IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_DIP,15);
      if W000ParConfig.TimeoutDip = 1 then
        W000ParConfig.TimeoutDip:=2;

      W000ParConfig.Home:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,'');
      {$IFDEF RILPRE}W000ParConfig.Home:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME_RILPRE,'');{$ENDIF}
      {$IFDEF PAGHE}W000ParConfig.Home:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME_PAGHE,'');{$ENDIF}
      {$IFDEF STAGIU}W000ParConfig.Home:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME_STAGIU,'');{$ENDIF}
      W000ParConfig.UrlLoginErrato:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_LOGINERR,'');
      W000ParConfig.UrlWSAutenticazione:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_WS_AUT,'');
      W000ParConfig.UrlManutenzione:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_MANUTENZIONE,'');
      W000ParConfig.URLIrisWebCloud:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_IRISWEBCLOUD,'');
      W000ParConfig.IrisWebCloudNewTab:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_IRISWEBCLOUD_NEWTAB,'');
      W000ParConfig.URLWebApp:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_WEBAPP,'');
      W000ParConfig.LoginEsterno:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_LOGIN_ESTERNO,'N');
      W000ParConfig.PaginaIniziale:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_STARTPAGE,'');
      W000ParConfig.PaginaSingola:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SINGLEPAGE,'');
      W000ParConfig.CampiInvisibili:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_CAMPI_INVISIBILI,'');

      //W000LivelloAccesso:=UpperCase(R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REGISTRO,'LIVELLO_ACCESSO','')); ??? cos'�??

      {$IFDEF X001}
      // impostazioni operative per X001
      W000ParConfig.TabColPartenza:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_TAB_COL_PARTENZA,'');
      W000ParConfig.NumLivelli:=IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_NUM_LIVELLI,0);
      {$ENDIF}

      // sezione impostazioni di sistema
      W000ParConfig.Port:=IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT,5000);
      {$IFDEF RILPRE}W000ParConfig.Port:=IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT_RILPRE,5000);{$ENDIF}
      {$IFDEF PAGHE}W000ParConfig.Port:=IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT_PAGHE,5000);{$ENDIF}
      {$IFDEF STAGIU}W000ParConfig.Port:=IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT_STAGIU,5000);{$ENDIF}

      W000ParConfig.CursoriLogin:=IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_LOGIN,12);
      W000ParConfig.CursoriSessione:=IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_SESSIONE,10);
      W000ParConfig.MaxOpenCursors:=IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_OPEN_CURSORS,1000);
      W000ParConfig.MaxWorkingMemMb:=IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_WORKING_MEMORY,0);
      if W000ParConfig.MaxOpenCursors div W000ParConfig.CursoriSessione > 20 then
        W000ParConfig.CursoriSessione:=W000ParConfig.MaxOpenCursors div 20;
      if W000ParConfig.MaxOpenCursors div W000ParConfig.CursoriLogin > 50 then
        W000ParConfig.CursoriLogin:=W000ParConfig.MaxOpenCursors div 50;


      W000ParConfig.LogAbilitati:=IniFile.ReadString(INI_SEZ_IMPOST_SIST,INI_ID_LOG_ABILITATI,'');
      W000ParConfig.LogFile:='W000.log';

      W000ParConfig.ParametriAvanzati:=IniFile.ReadString(INI_SEZ_IMPOST_SIST,INI_ID_PARAMETRI_AVANZATI,'');

      // parametri ReCAPTCHA
      W000ParConfig.UrlReCAPTCHA:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_URLRECAPTCHA, '');
      W000ParConfig.SiteKeyReCAPTCHA:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_SITEKEYRECAPTCHA, '');
      W000ParConfig.SecretKeyReCAPTCHA:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_SECRETKEYRECAPTCHA, '');

      // ### 2. parametri "calcolati" a partire da quelli salvati su file ###
      // ###   per comodit� di gestione                                   ###
      // reconnect session
      W000ParConfig.ReconnectSession:=Pos(INI_PAR_DB_NO_RECONNECT,W000ParConfig.ParametriAvanzati) = 0;
      W000ParConfig.LogoffDbPool:=Pos(INI_PAR_LOGOFF_DBPOOL,W000ParConfig.ParametriAvanzati) > 0;
      W000ParConfig.MaxWorkingMemByte:=W000ParConfig.MaxWorkingMemMb * 1024 * 1024;
      // com initialization
      if Pos(INI_COM_NONE,W000ParConfig.ParametriAvanzati) > 0 then
        W000ParConfig.COMInitialization:=INI_COM_NONE
      else if Pos(INI_COM_NORMAL,W000ParConfig.ParametriAvanzati) > 0 then
        W000ParConfig.COMInitialization:=INI_COM_NORMAL
      else if Pos(INI_COM_MULTI,W000ParConfig.ParametriAvanzati) > 0 then
        W000ParConfig.COMInitialization:=INI_COM_MULTI;
      // rave stream mode
      W000ParConfig.RaveStreamMode:=IfThen(Pos(INI_PAR_RAVEREPORT_IN_MEMORIA,W000ParConfig.ParametriAvanzati) = 0,
                                           INI_RAVE_STREAM_MODE_TEMPFILE,
                                           INI_RAVE_STREAM_MODE_MEMORY);
      // iw exception logger
      W000ParConfig.IWExcLogAbilitato:=(IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ABILITATO,'N') = 'S');
      W000ParConfig.IWExcLogPathFile:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_PATH_FILE_LOG,'');
      W000ParConfig.IWExcLogNomeFile:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_NOME_FILE_LOG,'');
      W000ParConfig.IWExcLogGiorniRimoz:=IniFile.ReadInteger(INI_SEZ_IMPOST_IW_LOG,INI_EL_GIORNI_RIMOZIONE,1);
      W000ParConfig.IWExcLogEccezIgnorate:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ECCEZ_IGNORATE,'');
    finally
      IniFile.Free;
    end;
  finally
    CSParConfig.Leave;
  end;
end;

procedure W000RegistraLog(const Tipo,S:String; E:Exception = nil);
//Tipo: DB, Memoria, Errore, Sessione, Accesso, Traccia
var
  Azienda,Messaggio: String;
  procedure RegistraSuFile;
  begin
    // scrittura su file commentata
    // R180ScriviMsgLog(W000LogFile,Messaggio);
  end;
begin
  {$IFNDEF WEBPJ}
  // per IrisWEB verifica il parametro avanzato che inibisce la registrazione messaggi
  // per IrisCloud sempre abilitato
  if Pos(INI_PAR_NO_REGISTRA_MSG,W000ParConfig.ParametriAvanzati) > 0 then
    Exit;
  {$ENDIF}

  if Trim(W000ParConfig.LogAbilitati) = '' then
    exit;
  if (UpperCase(Tipo) <> 'ERRORE') and (Pos(UpperCase(Tipo),W000ParConfig.LogAbilitati) = 0) then
    exit;
  if (E <> nil) and ((E is EAbort) or (E is ExceptionNoLog)) then
    exit;

  //CSFileLog.Enter;
  try
    // W000NumSessioni: non viene utilizzato il semaforo
    // -> potrebbe per� essere letto un valore non aggiornato
    Messaggio:=Format('<%s>[%.5d]%s',[Copy(Tipo,1,2),W000NumSessioni,S]);

    try
      // tenta scrittura log su db
      if RegistraMsgSessione = nil then
      begin
        RegistraSuFile; // tenta scrittura su file
        Exit;
      end;
      if (Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0) and
         //(RegistraMsgSessione.SessioneOracleApp.CheckConnection(False) = ccError) then
         ((RegistraMsgSessione.SessioneOracleApp = nil) or (not RegistraMsgSessione.SessioneOracleApp.Connected)) then
         //Caratto 15/04/2013 se ResistraMsg creata ma non ancora iniziato messaggio, allora session � ancora null
//       (RegistraMsg.Session.CheckConnection(W000ReconnectSession) = ccError) then
      begin
        RegistraSuFile;
        Exit;
      end;
      if RegistraMsgSessione = A000RegistraMsg then
        Azienda:='AZIN'
      else
        Azienda:='';

      if UpperCase(Tipo) <> 'ERRORE' then
        RegistraMsgSessione.InserisciMessaggio('I',Messaggio,Azienda)
      else
        RegistraMsgSessione.InserisciMessaggio('A',Messaggio,Azienda);
    except
      // se fallisce su db, tenta su file
      RegistraSuFile;
    end;
  finally
    //CSFileLog.Leave;
  end;
end;

function GetBrowser: TBrowser;
// restituisce il browser rilevato
begin
  if GGetWebApplicationThreadVar <> nil then
    Result:=GGetWebApplicationThreadVar.Browser
  else
    Result:=nil;
end;

function GetBrowserStr: String;
// restituisce una stringa che determina il tipo di browser in uso
var
  TmpBrowser: TBrowser;
begin
  TmpBrowser:=GetBrowser;
  if TmpBrowser = nil then
    Result:=StringOfChar(' ',4)
  else
  begin
    if TmpBrowser is TFirefox then
    begin
      Result:='FF';
    end
    else if TmpBrowser is TChrome then
    begin
      Result:='CH';
    end
    else if TmpBrowser is TOpera then
    begin
      Result:='OP';
    end
    else if TmpBrowser is TSafari then
    begin
      Result:='SA';
    end
    else if TmpBrowser is TInternetExplorer then
    begin
      Result:='IE';
    end
    else if TmpBrowser is TMSEdge then
    begin
      Result:='ED';
    end
    else
    begin
      Result:='??';
    end;
    Result:=Format('%s%.2d',[Result,TmpBrowser.MajorVersion])
  end;
end;

function GetTestoLog(PCodForm: String = 'A000'; PApp: TIWApplication = nil): String;
var
  Ora,IdApp,IpClient,Browser,ParForwardedFor: String;
  i: Integer;
begin
  // utilizza variabili di appoggio per l'informazione di log
  Ora:=FormatDateTime('dd/mm/yyyy hhhh.nn.ss',Now);
  IdApp:=StringOfChar(' ',28);
  IpClient:=StringOfChar(' ',39);
  Browser:=StringOfChar(' ',4);
  if PApp <> nil then
  begin
    try
      IdApp:=PApp.AppID;
    except end;
    try
      if Assigned(PApp.Request) then
      begin
        //Inizio gestione header x-forwarded-for
        for i:=0 to PApp.Request.RawHeaders.Count - 1 do
        begin
          if PApp.Request.RawHeaders[i].StartsWith(Format('%s:',['x-forwarded-for']),True) then
          begin
            ParForwardedFor:=PApp.Request.RawHeaders[i].Substring('x-forwarded-for'.Length + 1).Trim;
            Break;
          end;
        end;
        //Fine gestione header x-forwarded-for
        IpClient:=Format('%-39s',[IfThen(ParForwardedFor <> '', ParForwardedFor, PApp.Request.RemoteAddr)]);
      end;
    except end;
    Browser:=GetBrowserStr;
  end;
  PCodForm:=R180DimLung(PCodForm,5);

  Result:=Format('%s;%s;%s;%s;%s;',[Ora,IdApp,IpClient,Browser,PCodForm]);
end;

function GetElencoFormAttive: String;
var
  i: Integer;
  forms : TStringList;
begin
  Result:='#N/D#';
  if GGetWebApplicationThreadVar.ActiveFormCount > 0 then
  begin
    forms:=TStringList.Create;
    i:=0;
    while i < GGetWebApplicationThreadVar.ActiveFormCount do
    begin
      if Pos(GGetWebApplicationThreadVar.ActiveForms[i].Name, forms.Text) = 0 then
        forms.Add(Format('%s%s', [GGetWebApplicationThreadVar.ActiveForms[i].Name,
                  IfThen(GGetWebApplicationThreadVar.ActiveForms[i].Name = GGetWebApplicationThreadVar.ActiveForm.Name, ' (attiva)', '')]));
      Inc(i);
    end;
    Result:=Format('FinestreAttive: [%s]', [forms.CommaText]);
    FreeAndNil(forms);
  end;
end;

{ThreadElaborazioneExceptionHelper}
function ThreadElaborazioneExceptionHelper.DescrizioneContesto: String;
var
  Desc: String;
  i: Integer;
begin
  Desc:='';
  if ThreadElaborazione <> nil then
  begin
    Desc:=Format('AppID: %s, Stato: %d, SuspendTimeout: %s', [ThreadElaborazione.AppID,
    Ord(ThreadElaborazione.Stato), UIntToStr(ThreadElaborazione.SuspendTimeout)]);
    Desc:=Desc + ', ' + GetElencoFormAttive;
  end
  else
    Desc:='ThreadElaborazione uguale a nil';
  Result:=Desc;
end;

{ TThreadElaborazione }

// inizializzazioni post-costruttore
procedure TThreadElaborazione.AfterConstruction;
begin
  inherited;
  // crea semaforo per impostazione stato
  CSStato:=TMedpCriticalSection.Create;

  // cfr. http://msdn.microsoft.com/en-us/library/windows/desktop/ms682396%28v=vs.85%29.aspx
  FEvent:=CreateEvent(nil,      // ignorato: deve essere NULL
                      False,    // auto reset
                      False,    // initial state (true = signaled, false = not signaled)
                      nil);     // puntatore a una stringa null-terminated che specifica il nome dell'oggetto (NULL = senza nome)

  // default per timeout di sospensione
  FSuspendTimeout:=MEDP_SUSPEND_TIMEOUT;

  // stato thread: ready!
  Stato:=teReady;
end;

// distruttore
destructor TThreadElaborazione.Destroy;
begin
  // distrugge semaforo
  FreeAndNil(CSStato);

  // non distrugge l'oggetto FEvent
  //FreeAndNil(FEvent);

  inherited;
end;

// @override
// procedura di elaborazione thread
procedure TThreadElaborazione.Execute;
var
  i: Integer;
  lst: TList;
begin
  //NameThreadForDebugging('Thread elaborazione per sessione ' + AppID);
  if Assigned(ProcElaborazione) then
  begin
    // 1. imposta la variabile GGetWebApplicationThreadVar
    { TODO : TEST IW 14 - Sembra OK }
    lst:=GSessions.LockList;
    with lst do
    begin
      try
        for i:=0 to Count - 1 do
        begin
          if AppID = (TObject(Items[i]) as TIWApplication).AppID then
          begin
            GSetWebApplicationThreadVar((TObject(Items[i]) as TIWApplication));
            Break;
          end;
        end;
      finally
        GSessions.UnLockList(lst);
      end;
    end;

    // 2. esegue la procedura di elaborazione indicata
    try
      ProcElaborazione(Sender);
    except
      // si � verificato un errore legato al thread di elaborazione
      on E: EThreadElaborazioneException do
      begin
        // eccezione silenziosa
      end;
      on E: EAbort do
      begin
        // eccezione silenziosa
      end;
      // altre eccezioni non sono previste!
      on E: Exception do
      begin
        // ??? prevedere raise ???
        R180MessageBox(E.Message,ESCLAMA);
        exit;
      end;
    end;
  end;
end;

function TThreadElaborazione.GetStato: TStatoThreadElaborazione;
begin
  if CSStato <> nil then
  try
    CSStato.Enter;
    Result:=FStato;
  finally
    CSStato.Leave;
  end;
end;

procedure TThreadElaborazione.SetStato(const Val: TStatoThreadElaborazione);
begin
  if CSStato <> nil then
  try
    CSStato.Enter;
    FStato:=Val;
  finally
    CSStato.Leave;
  end;
end;

function TThreadElaborazione.GetSuspendTimeout: Cardinal;
begin
  Result:=FSuspendTimeout;
end;

procedure TThreadElaborazione.SetSuspendTimeout(const Val: Cardinal);
begin
  // il timeout di sospensione del thread non pu� essere inferiore a MEDP_SUSPEND_TIMEOUT
  if Val > MEDP_SUSPEND_TIMEOUT then
  begin
    FSuspendTimeout:=Val;
  end;
end;

procedure TThreadElaborazione.MedpSuspend;
// sospende il thread
begin
  // imposta lo Stato sospeso
  Stato:=teSuspended;

  // attende di essere sbloccato
  if WaitForSingleObject(FEvent,SuspendTimeout) = WAIT_TIMEOUT then
  begin
    Stato:=teTimeout;
    raise EThreadElaborazioneException.Create('timeout');
  end;

  // un eventuale timeout di sessione potrebbe aver terminato il thread
  if Terminated then
  begin
    Stato:=teTimeout;
    raise EThreadElaborazioneException.Create('thread terminato da chiamata esterna');
  end;
end;

procedure TThreadElaborazione.MedpResume;
// riprende esecuzione thread
begin
  Stato:=teRunning;
  SetEvent(FEvent);
end;

initialization
  TA000FInterfaccia.SetServerControllerClass;
  THandlers.Add('', WC000UServerAdmin.URL_PATH, TIWURLMonitorResponder.Create);
  THandlers.Add('', WC000UConfigIni.URL_PATH, TIWURLConfigIniResponder.Create);
  THandlers.Add('', WC000UErrLimiteSessioni.URL_PATH, TIWURLErrLimiteSessioniResponder.Create);
  {$IFDEF INTRAWEBSVC}
  THandlers.Add('', URL_WS_B021, TB021FContentHandler.Create);
  {$ENDIF}

  // impostazione per madExcept (alternativa all'utilizzo della unit madIWSupport
  {$IFDEF madExcept}
  AmHttpServer:=True;
  {$ENDIF madExcept}

  // configura il logger
  TLogger.Configure(FunzioniGenerali.TLogOptions.Create('Server IrisWeb',True,True,R180GetPathLog));

{$ELSE}
//Se definito WEBSVC...

interface

uses
  A000UCostanti,
  A000USessione,
  {$IFDEF WS_SOAP}
  B020UIrisWebSvc01Dtm,
  //B024UADSCatanzaroDM,
  {$ENDIF}
  C180FunzioniGenerali,
  Datasnap.DSSession,
  Classes,
  SysUtils,
  SyncObjs,
  Data.DB,
  Oracle,
  OracleData,
  QueryPK,
  RegistrazioneLog,
  Variants;

type
  TmedpFieldHelper = class helper for TField
  public
    function medpOldValue: Variant;
  end;

const
  RICERCA_NULL   = 99999999;
  POSIZIONE_NULL = 99999999;

var
  CSFormatSettings: TMedpCriticalSection;

function A000SessioneIrisWIN: TSessioneIrisWin;
function _ControllaSessioneIrisWin(const PMetodoChiamante: String; var RErrMsg: String): Boolean; inline;
function QVistaOracle:String;
function SessioneOracle:TOracleSession;
function QueryPK1:TQueryPK;
function RegistraLog:TRegistraLog;
function RegistraMsg:TRegistraMsg;
function Parametri:TParametri;
function A000TraduzioneStringhe(Stringa:String):String;
function Password(Intestazione:String):Integer;

function  GetTestoLog(PCodForm: String = 'A000'): String;
procedure W000RegistraLog(const Tipo,S:String; E:Exception = nil);

implementation

uses
  C200UWebServicesTypes;

{ TmedpFieldHelper }
function TmedpFieldHelper.medpOldValue: Variant;
begin
  Result:=Self.OldValue;
  if Self.DataSet.State = dsInsert then
    raise Exception.Create('medpOldValue non accessibile!' + #13#10 + 'Notificare al servizio di assistenza del software.');
end;

function A000SessioneIrisWIN: TSessioneIrisWin;
// servizi datansap:
//   restituisce l'oggetto TSessioneIrisWin associato alla sessione datasnap corrente
// servizi soap
//   restituisce l'oggetto unico B020FIrisWebSvc01Dtm.A000SessioneIrisWIN
// in caso di errore restituisce nil
var
  LMyDSSess: TDSSession;
  LMySIWObj: TObject;
begin
  Result:=nil;

  LMyDSSess:=TDSSessionManager.GetThreadSession;
  if LMyDSSess <> nil then
  begin
    // servizi datasnap
    try
      // alla propria sessione datasnap � associato un oggetto di tipo TSessioneIrisWin
      // questo blocco di codice si occupa di estrarlo e restituirlo
      if (LMyDSSess.IsValid) and
         (LMyDSSess.HasObject(DS_OBJECT_SESSIONE_IRISWIN)) then
      begin
        LMySIWObj:=LMyDSSess.GetObject(DS_OBJECT_SESSIONE_IRISWIN);
        if (Assigned(LMySIWObj)) and
           (LMySIWObj is TSessioneIrisWin) then
        begin
          Result:=TSessioneIrisWin(LMySIWObj);
        end;
      end;
    except
    end;
  end
  {$IFDEF WS_SOAP}
  else if B020FIrisWebSvc01Dtm <> nil then
  begin
    // web services SOAP
    Result:=B020FIrisWebSvc01Dtm.SessioneIrisWIN;
  end
  //else if B024FADSCatanzaroDM <> nil then
  //begin
  //  // web services SOAP per Catanzaro
  //  Result:=B024FADSCatanzaroDM.SessioneIrisWIN;
  //end
  {$ENDIF}
  ;
end;

function _ControllaSessioneIrisWin(const PMetodoChiamante: String; var RErrMsg: String): Boolean;
begin
  Result:=False;
  RErrMsg:='';

  // verifica che la sessione iriswin non sia nulla
  if A000SessioneIrisWIN = nil then
  begin
    RErrMsg:=Format('Unit A000UInterfaccia: metodo %s non accessibile: A000SessioneIrisWIN non inizializzato!',[PMetodoChiamante]);
    Exit;
  end;

  // tutto ok
  Result:=True;
end;

function Password(Intestazione:String):Integer;
{Richiesta Azienda,Operatore,Password}
begin
  Result:=-1;
end;

function QVistaOracle:String;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('QVistaOracle',LErrore) then
    raise Exception.Create(LErrore);
  Result:=A000SessioneIrisWIN.QVistaOracle;
end;

function SessioneOracle:TOracleSession;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('SessioneOracle',LErrore) then
    raise Exception.Create(LErrore);
  Result:=A000SessioneIrisWIN.SessioneOracle;
end;

function QueryPK1:TQueryPK;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('QueryPK1',LErrore) then
    raise Exception.Create(LErrore);
  Result:=(A000SessioneIrisWIN.QueryPK1 as TQueryPK);
end;

function RegistraLog:TRegistraLog;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('RegistraLog',LErrore) then
    raise Exception.Create(LErrore);
  Result:=(A000SessioneIrisWIN.RegistraLog as TRegistraLog);
end;

function RegistraMsg:TRegistraMsg;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('RegistraMsg',LErrore) then
    raise Exception.Create(LErrore);
  Result:=(A000SessioneIrisWIN.RegistraMsg as TRegistraMsg);
end;

function Parametri:TParametri;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('Parametri',LErrore) then
    raise Exception.Create(LErrore);
  Result:=A000SessioneIrisWIN.Parametri;
end;

function A000TraduzioneStringhe(Stringa:String):String;
// Gestione della traduzione (localizzazione) delle stringhe
var NomeComp,Traduzione: String;
begin
  Result:=Stringa;

  if (Parametri = nil) or
     (Parametri.CampiRiferimento.C90_Lingua = '') or
     (Parametri.cdsI015 = nil) or
     (not Parametri.cdsI015.Active) then
    Exit;

  // filtro del clientdataset sui componenti della maschera attuale + comp. ereditati
  with Parametri.cdsI015 do
  begin
    Filtered:=False;
    Filter:='MASCHERA = ''W000UMessaggi''';
    Filtered:=True;
    // ciclo di traduzione
    First;
    while not Eof do
    begin
      NomeComp:=Trim(UpperCase(FieldByName('COMPONENTE').AsString));
      Traduzione:=FieldByName('CAPTION').AsString;
      if (Trim(Traduzione) <> '') and (NomeComp = Trim(UpperCase(Stringa))) then
      begin
        Result:=Traduzione;
        Break;
      end;
      Next;
    end;
  end;
  if Result = '<NULL>' then
    Result:='';
end;

function  GetTestoLog(PCodForm: String = 'A000'): String;
var
  Ora,IdApp,IpClient,Browser: String;
begin
  // utilizza variabili di appoggio per l'informazione di log
  Ora:=FormatDateTime('dd/mm/yyyy hhhh.nn.ss',Now);
  IdApp:=StringOfChar(' ',28);
  IpClient:=StringOfChar(' ',39);
  Browser:=StringOfChar(' ',4);
  PCodForm:=R180DimLung(PCodForm,5);

  Result:=Format('%s;%s;%s;%s;%s;',[Ora,IdApp,IpClient,Browser,PCodForm]);
end;

procedure W000RegistraLog(const Tipo,S:String; E:Exception = nil);
begin
  //...da implementare...
end;

// MONDOEDP - commessa MAN/09 SVILUPPO#1.ini
// A000SessioneIrisWIN � ora una function con scope globale
{
initialization
  A000SessioneIrisWIN:=TSessioneIrisWIN.Create(nil);

finalization
  A000SessioneIrisWIN.Free;
}
// MONDOEDP - commessa MAN/09 SVILUPPO#1.fine

{$ENDIF WEBSVC}
{$ENDIF IRISWEB}

{$IFDEF BPL}
interface

uses Data.DB, System.SysUtils, Oracle, SyncObjs, A000UCostanti, A000USessione, RegistrazioneLog;

function SessioneOracle:TOracleSession;
function RegistraLog:TRegistraLog;
function Parametri:TParametri;
function  A000TraduzioneStringhe(Stringa:String):String;

type
  TmedpFieldHelper = class helper for TField
  public
    function medpOldValue: Variant;
  end;

var CSFormatSettings: TMedpCriticalSection;

implementation

{ TmedpFieldHelper }
function TmedpFieldHelper.medpOldValue: Variant;
begin
  Result:=Self.OldValue;
  if Self.DataSet.State = dsInsert then
    raise Exception.Create('medpOldValue non accessibile!' + #13#10 + 'Notificare al servizio di assistenza del software.');
end;

function RegistraLog:TRegistraLog;
begin
end;
function A000TraduzioneStringhe(Stringa:String):String;
begin
end;
function SessioneOracle:TOracleSession;
begin
end;
function Parametri:TParametri;
begin
end;
{$ELSE}//{NOT DEF BPL}
{$IFNDEF IRISWEB}{$IFNDEF IRISAPP}
interface

uses Windows, Controls, SyncObjs, Data.DB,
     Classes, SysUtils, Oracle, OracleData, A000UCostanti, A000USessione,
     QueryPK, RegistrazioneLog, Variants;

type
  TmedpFieldHelper = class helper for TField
  public
    function medpOldValue: Variant;
  end;

var CSFormatSettings: TMedpCriticalSection;

function SessioneOracle:TOracleSession;
function QueryPK1:TQueryPK;
function RegistraLog:TRegistraLog;
function RegistraMsg:TRegistraMsg;
function Parametri:TParametri;
function A000TraduzioneStringhe(Stringa:String):String;
function Password(Intestazione:String):Integer;
function QVistaOracle:String;
// B020UTest bugfix: utilizzata per risolvere problema dei parametri di configurazione
function W000ParConfig: TParConfig;

implementation

uses C180FunzioniGenerali, A001UPassWord, A001UPassWordDtM1;

{ TmedpFieldHelper }
function TmedpFieldHelper.medpOldValue: Variant;
begin
  Result:=Self.OldValue;
  if Self.DataSet.State = dsInsert then
    raise Exception.Create('medpOldValue non accessibile!' + #13#10 + 'Notificare al servizio di assistenza del software.');
end;

function W000ParConfig: TParConfig;
// B020UTest bugfix: utilizzata per risolvere problema dei parametri di configurazione
begin
  Result.Database:='';
  Result.Azienda:='';
  Result.Profilo:='';
  Result.TimeoutOper:=0;
  Result.TimeoutDip:=0;
  Result.MaxSessioni:=0;
  Result.UrlSuperoMaxSessioni:='';
  Result.Home:='';
  Result.UrlLoginErrato:='';
  Result.UrlWSAutenticazione:='';
  Result.UrlManutenzione:='';
  Result.UrlIrisWebCloud:='';
  Result.IrisWebCloudNewTab:='';
  Result.UrlWebApp:='';
  Result.LoginEsterno:='';
  Result.PaginaIniziale:='';
  Result.PaginaSingola:='';
  Result.CampiInvisibili:='';
  Result.Port:=0;
  Result.CursoriLogin:=0;
  Result.CursoriSessione:=0;
  Result.MaxOpenCursors:=0;
  Result.MaxWorkingMemMb:=0;
  Result.LogAbilitati:='';
  Result.LogFile:='';
  Result.ParametriAvanzati:='';
  Result.TabColPartenza:='';
  Result.NumLivelli:=0;
  Result.ReconnectSession:=False;
  Result.LogoffDbPool:=False;
  Result.MaxWorkingMemByte:=0;
  Result.ComInitialization:='';
  Result.RaveStreamMode:=INI_RAVE_STREAM_MODE_TEMPFILE;
  Result.IWExcLogAbilitato:=False;
  Result.IWExcLogPathFile:='';
  Result.IWExcLogNomeFile:='';
  Result.IWExcLogGiorniRimoz:=1;
  Result.IWExcLogEccezIgnorate:='';
end;

function QVistaOracle:String;
begin
  Result:=A000SessioneIrisWIN.QVistaOracle;
end;

function Password(Intestazione:String):Integer;
{Richiesta Azienda,Operatore,Password}
begin
  Result:=-1;
  A001FPassword:=TA001FPassword.Create(nil);
  A001FPasswordDtM1:=TA001FPasswordDtM1.Create(nil);
  with A001FPassword do
    try
    Caption:=Intestazione;
    if Caption = '' then
    begin
      Azienda.Text:='AZIN';
      Utente.Text:='SYSMAN';
      Password.Text:='LEADER';
    end;
    if ParamCount >= 3 then
    begin
      Azienda.Text:=ParamStr(1);
      Utente.Text:=ParamStr(2);
      Password.Text:=ParamStr(3);
      if ParamCount >= 4 then
        cmbDatabase.Text:=ParamStr(4)
      else
        cmbDatabase.Text:=R180GetRegistro(HKEY_CURRENT_USER,'A001','Database','IRIS');
      try
        BitBtn1Click(nil);
      except
        ModalResult:=mrNone;
        Result:=-1;
        //Abort;
      end;
      if ModalResult = mrOk then
        Result:=Parametri.ProgOper;
    end;
    if Result = -1 then
    begin
      if ShowModal = mrOk then
        Result:=Parametri.ProgOper
      else
        Result:=-1;
    end;
    finally
      Release;
      A001FPasswordDtM1.Free;
    end;
end;

function SessioneOracle:TOracleSession;
begin
  Result:=A000SessioneIrisWIN.SessioneOracle;
end;

function QueryPK1:TQueryPK;
begin
  Result:=(A000SessioneIrisWIN.QueryPK1 as TQueryPK);
end;

function RegistraLog:TRegistraLog;
begin
  Result:=(A000SessioneIrisWIN.RegistraLog as TRegistraLog);
end;

function RegistraMsg:TRegistraMsg;
begin
  Result:=(A000SessioneIrisWIN.RegistraMsg as TRegistraMsg);
end;

function Parametri:TParametri;
begin
  Result:=A000SessioneIrisWIN.Parametri;
end;

function A000TraduzioneStringhe(Stringa:String):String;
// Gestione della traduzione (localizzazione) delle stringhe
var NomeComp,Traduzione: String;
begin
  Result:=Stringa;

  if (Parametri = nil) or
     (Parametri.CampiRiferimento.C90_Lingua = '') or
     (Parametri.cdsI015 = nil) or
     (not Parametri.cdsI015.Active) then
    Exit;

  // filtro del clientdataset sui componenti della maschera attuale + comp. ereditati
  with Parametri.cdsI015 do
  begin
    Filtered:=False;
    Filter:='MASCHERA = ''W000UMessaggi''';
    Filtered:=True;
    // ciclo di traduzione
    First;
    while not Eof do
    begin
      NomeComp:=Trim(UpperCase(FieldByName('COMPONENTE').AsString));
      Traduzione:=FieldByName('CAPTION').AsString;
      if (Trim(Traduzione) <> '') and (NomeComp = Trim(UpperCase(Stringa))) then
      begin
        Result:=Traduzione;
        Break;
      end;
      Next;
    end;
  end;
  if Result = '<NULL>' then
    Result:='';
end;

initialization
  A000SessioneIrisWIN:=TSessioneIrisWIN.Create(nil);

finalization
  A000SessioneIrisWIN.Free;
{$ENDIF IRISAPP}
{$ENDIF IRISWEB}
{$ENDIF BPL}

{$IFDEF IRISAPP}
interface

uses
  A000UCostanti,
  A000USessione,
  C180FunzioniGenerali,
  RegistrazioneLog,
  WM000UMainModule,
  Classes,
  SysUtils,
  SyncObjs,
  Data.DB,
  Oracle,
  OracleData,
  QueryPK,
  Variants;

type
  TmedpFieldHelper = class helper for TField
  public
    function medpOldValue: Variant;
  end;

const
  RICERCA_NULL   = 99999999;
  POSIZIONE_NULL = 99999999;

var
  CSFormatSettings: TMedpCriticalSection;

function _ControllaSessioneIrisWin(const PMetodoChiamante: String; var RErrMsg: String): Boolean; inline;
function A000SessioneIrisWIN: TSessioneIrisWin;
function QVistaOracle:String;
function SessioneOracle: TOracleSession;
function QueryPK1:TQueryPK;
function RegistraLog:TRegistraLog;
function RegistraMsg:TRegistraMsg;
function Parametri:TParametri;
function A000TraduzioneStringhe(Stringa:String):String;
function Password(Intestazione:String):Integer;
function  GetTestoLog(PCodForm: String = 'A000'): String;
procedure W000RegistraLog(const Tipo,S:String; E:Exception = nil);

implementation

uses
  C200UWebServicesTypes;

{ TmedpFieldHelper }
function TmedpFieldHelper.medpOldValue: Variant;
begin
  Result:=Self.OldValue;
  if Self.DataSet.State = dsInsert then
    raise Exception.Create('medpOldValue non accessibile!' + #13#10 + 'Notificare al servizio di assistenza del software.');
end;

function A000SessioneIrisWIN: TSessioneIrisWin;
begin
  Result:=WM000FMainModule.Infologin.SessioneIrisWin;
end;

function _ControllaSessioneIrisWin(const PMetodoChiamante: String; var RErrMsg: String): Boolean;
begin
  Result:=False;
  RErrMsg:='';

  // verifica che la sessione iriswin non sia nulla
  if A000SessioneIrisWIN = nil then
  begin
    RErrMsg:=Format('Unit A000UInterfaccia: metodo %s non accessibile: A000SessioneIrisWIN non inizializzato!',[PMetodoChiamante]);
    Exit;
  end;

  // tutto ok
  Result:=True;
end;

function QVistaOracle:String;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('QVistaOracle',LErrore) then
    raise Exception.Create(LErrore);
  Result:=A000SessioneIrisWIN.QVistaOracle;
end;

function SessioneOracle:TOracleSession;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('SessioneOracle',LErrore) then
    raise Exception.Create(LErrore);
  Result:=A000SessioneIrisWIN.SessioneOracle;
end;

function QueryPK1:TQueryPK;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('QueryPK1',LErrore) then
    raise Exception.Create(LErrore);
  Result:=(A000SessioneIrisWIN.QueryPK1 as TQueryPK);
end;

function RegistraLog:TRegistraLog;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('RegistraLog',LErrore) then
    raise Exception.Create(LErrore);
  Result:=(A000SessioneIrisWIN.RegistraLog as TRegistraLog);
end;

function RegistraMsg:TRegistraMsg;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('RegistraMsg',LErrore) then
    raise Exception.Create(LErrore);
  Result:=(A000SessioneIrisWIN.RegistraMsg as TRegistraMsg);
end;

function Parametri:TParametri;
var
  LErrore: String;
begin
  if not _ControllaSessioneIrisWin('Parametri',LErrore) then
    raise Exception.Create(LErrore);
  Result:=A000SessioneIrisWIN.Parametri;
end;

function A000TraduzioneStringhe(Stringa:String):String;
// Gestione della traduzione (localizzazione) delle stringhe
var NomeComp,Traduzione: String;
begin
  Result:=Stringa;

  if (Parametri = nil) or
     (Parametri.CampiRiferimento.C90_Lingua = '') or
     (Parametri.cdsI015 = nil) or
     (not Parametri.cdsI015.Active) then
    Exit;

  // filtro del clientdataset sui componenti della maschera attuale + comp. ereditati
  with Parametri.cdsI015 do
  begin
    Filtered:=False;
    Filter:='MASCHERA = ''W000UMessaggi''';
    Filtered:=True;
    // ciclo di traduzione
    First;
    while not Eof do
    begin
      NomeComp:=Trim(UpperCase(FieldByName('COMPONENTE').AsString));
      Traduzione:=FieldByName('CAPTION').AsString;
      if (Trim(Traduzione) <> '') and (NomeComp = Trim(UpperCase(Stringa))) then
      begin
        Result:=Traduzione;
        Break;
      end;
      Next;
    end;
  end;
  if Result = '<NULL>' then
    Result:='';
end;

function  GetTestoLog(PCodForm: String = 'A000'): String;
var
  Ora,IdApp,IpClient,Browser: String;
begin
  // utilizza variabili di appoggio per l'informazione di log
  Ora:=FormatDateTime('dd/mm/yyyy hhhh.nn.ss',Now);
  IdApp:=StringOfChar(' ',28);
  IpClient:=StringOfChar(' ',39);
  Browser:=StringOfChar(' ',4);
  PCodForm:=R180DimLung(PCodForm,5);

  Result:=Format('%s;%s;%s;%s;%s;',[Ora,IdApp,IpClient,Browser,PCodForm]);
end;

procedure W000RegistraLog(const Tipo,S:String; E:Exception = nil);
begin
  //...da implementare...
end;

function Password(Intestazione:String):Integer;
{Richiesta Azienda,Operatore,Password}
begin
  Result:=-1;
end;

{$ENDIF IRISAPP}

end.

