unit B000UConfigWebServer;

interface

uses
  B000UConfigWebServerDM,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C180FunzioniGenerali, ImgList, ComCtrls, ToolWin, Tabs, StdCtrls,
  Registry, ShellAPI, StrUtils, Mask, ExtCtrls, Buttons, Math,
  A000UCostanti, Grids, DBGrids, CheckLst, Menus,
  IniFiles, System.IOUtils, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, Vcl.OleCtrls, SHDocVw, ActiveX, OracleCI, Data.DB,
  System.ImageList, Vcl.Samples.Spin, System.RegularExpressions, System.UITypes;

type
  TElementiForm = record
    Contenitore,
    Elementi: String;
  end;

  TAppInfo = record
    Nome: String;
    FileIni: String;
  end;

  TB000FConfigWebServer = class(TForm)
    imglstToolbarFiglio: TImageList;
    PageControl: TPageControl;
    tsParametri: TTabSheet;
    grpImpOper: TGroupBox;
    Label1: TLabel;
    lblTOOperatore: TLabel;
    lblTODipendente: TLabel;
    Label5: TLabel;
    Label24: TLabel;
    lblProfiloDefault: TLabel;
    edtTOOperatore: TMaskEdit;
    edtTODipendente: TMaskEdit;
    grpCampiInvisibili: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    cmbPagina: TComboBox;
    cmbComponente: TComboBox;
    btnAggiungiCI: TBitBtn;
    lstCampiInvisibili: TListBox;
    chkLoginEsterno: TCheckBox;
    edtAziendaDefault: TEdit;
    edtProfiloDefault: TEdit;
    grpImpSist: TGroupBox;
    Label6: TLabel;
    lblMaxOpenCursors: TLabel;
    lblCursoriLogin: TLabel;
    lblCursoriSessione: TLabel;
    grpLogAbil: TGroupBox;
    chkSessione: TCheckBox;
    chkAccesso: TCheckBox;
    chkTraccia: TCheckBox;
    chkErrore: TCheckBox;
    grpParAvanzati: TGroupBox;
    edtPort: TMaskEdit;
    edtCursoriLogin: TMaskEdit;
    edtCursoriSessione: TMaskEdit;
    edtMaxOpenCursors: TMaskEdit;
    ToolBar1: TToolBar;
    btnModifica: TToolButton;
    ToolButton4: TToolButton;
    btnAnnulla: TToolButton;
    btnSalva: TToolButton;
    tsComponenti: TTabSheet;
    lblMidasPath: TLabel;
    lblA077ComServer: TLabel;
    GroupBoxLibrerie: TGroupBox;
    Label12: TLabel;
    btnMidasReg: TButton;
    GroupBoxGenStampe: TGroupBox;
    Label13: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Shape3: TShape;
    btnRegA077PComServer: TButton;
    btnRegP077PComServer: TButton;
    btnUnRegP077PComServer: TButton;
    btnUnRegA077PComServer: TButton;
    GroupBox3: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    btnRegP714PComServer: TButton;
    btnUnRegP714PComServer: TButton;
    tsURL: TTabSheet;
    lblUrlWsAuth: TLabel;
    edtUrlWsAuth: TEdit;
    edtURLMan: TEdit;
    lblURLMan: TLabel;
    btnMidasUnreg: TButton;
    Label27: TLabel;
    StatusBar1: TStatusBar;
    tsMessaggi: TTabSheet;
    GroupBox4: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtPasswordMsg: TEdit;
    edtUtenteMsg: TEdit;
    btnLogon: TButton;
    GroupBox5: TGroupBox;
    dbgHead: TDBGrid;
    grpDett: TGroupBox;
    dgrdDettaglio: TDBGrid;
    Panel1: TPanel;
    chkFiltroErrore: TCheckBox;
    chkFiltroSessione: TCheckBox;
    chkFiltroAccesso: TCheckBox;
    chkFiltroTraccia: TCheckBox;
    Panel2: TPanel;
    edtDal: TMaskEdit;
    Label31: TLabel;
    edtAl: TMaskEdit;
    Label32: TLabel;
    btnFiltra: TButton;
    chkMemoria: TCheckBox;
    lblNumMsg: TLabel;
    chkFiltroMemoria: TCheckBox;
    Splitter1: TSplitter;
    Label36: TLabel;
    edtMaxProcessMemory: TMaskEdit;
    chkParametriAvanzati: TCheckListBox;
    pmnDettaglio: TPopupMenu;
    mnuFiltraIdSessione: TMenuItem;
    mnuFiltraIP: TMenuItem;
    GroupBox6: TGroupBox;
    Label38: TLabel;
    Button2: TButton;
    pnlInfo: TPanel;
    lblParRiavvio: TLabel;
    edtTabColPartenza: TEdit;
    edtNumLivelli: TMaskEdit;
    lblTabColPartenza: TLabel;
    lblNumLivelli: TLabel;
    grpAzioniUrl: TGroupBox;
    grpGenerazioneUrl: TGroupBox;
    lblAziendaGen: TLabel;
    edtUrlAzienda: TEdit;
    lblUtenteGen: TLabel;
    edtUrlUtente: TEdit;
    lblPasswordGen: TLabel;
    edtUrlPassword: TEdit;
    lblProfiloGen: TLabel;
    edtUrlProfilo: TEdit;
    lblDatabaseGen: TLabel;
    lblHomeGen: TLabel;
    edtUrlHome: TEdit;
    edtURLGenerato: TEdit;
    shp1: TShape;
    lblURL: TLabel;
    pnlTop: TPanel;
    cmbAzioni: TComboBox;
    grpGestioneSito: TGroupBox;
    lblMonitorSessioni: TLabel;
    lblVisParConfig: TLabel;
    btnEseguiAzione: TButton;
    IdHTTP1: TIdHTTP;
    memRisultato: TMemo;
    lblDescrizioneAzione: TLabel;
    edtUrlBase: TEdit;
    lblUrlBase: TLabel;
    lblAccessoSito: TLabel;
    pnlApplicativo: TPanel;
    pnlInfoApplicativo: TPanel;
    GroupBox1: TGroupBox;
    edtPathBase: TEdit;
    rgpApplicativo: TRadioGroup;
    GrpStampeCloud: TGroupBox;
    lblRegB028PComServer: TLabel;
    lblUnRegB028PComServer: TLabel;
    btnRegB028PComServer: TButton;
    btnUnRegB028PComServer: TButton;
    lblMaxSessioni: TLabel;
    edtMaxSessioni: TMaskEdit;
    lblUrlSuperoMaxSessioni: TLabel;
    edtHome: TEdit;
    edtUrlSuperoMaxSessioni: TEdit;
    Label2: TLabel;
    edtURLLoginErrato: TEdit;
    lblPaginaIniziale: TLabel;
    edtPaginaIniziale: TEdit;
    lblPaginaSingola: TLabel;
    edtPaginaSingola: TEdit;
    lblUrlIrisWebCloud: TLabel;
    edtUrlIrisWebCloud: TEdit;
    chkIrisWebCloudNewTab: TCheckBox;
    edtMainDir: TEdit;
    lblMainDir: TLabel;
    lblUrlWebApp: TLabel;
    edtUrlWebApp: TEdit;
    cmbURLDataBase: TComboBox;
    cmbDataBaseMsg: TComboBox;
    cmbDataBase: TComboBox;
    tsAltro: TTabSheet;
    ToolBar2: TToolBar;
    btnModifica2: TToolButton;
    ToolButton2: TToolButton;
    btnAnnulla2: TToolButton;
    btnSalva2: TToolButton;
    pnlAltroSettings: TPanel;
    chkEnableExcLog: TCheckBox;
    grpExceptionLogger: TGroupBox;
    pnlAltroInfo: TPanel;
    Label3: TLabel;
    lblELNomeFile: TLabel;
    lblELPathFile: TLabel;
    lblELPurge1: TLabel;
    grpELEcc: TGroupBox;
    edtELPathFile: TEdit;
    edtELNomeFile: TEdit;
    edtELNumGiorniPurge: TSpinEdit;
    lblELPurge2: TLabel;
    chkELEccPredefinite: TCheckListBox;
    lblELEccPredefinite: TLabel;
    lblELEccCustom: TLabel;
    edtELEccCustom: TEdit;
    memELHelp: TMemo;
    lblUrlBaseINI: TLabel;  // gc: 11/09/19
    edtUrlBaseINI: TEdit;
    rgpTipoInstallazione: TRadioGroup;
    grpIrisAPP: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label26: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label42: TLabel;
    Label44: TLabel;
    edtIATimeout: TMaskEdit;
    chkIALoginEsterno: TCheckBox;
    edtIAAzienda: TEdit;
    edtIAProfilo: TEdit;
    edtIAURLManutenzione: TEdit;
    edtIAMaxSessioni: TMaskEdit;
    edtIAHome: TEdit;
    edtIAURLSuperoMaxSessioni: TEdit;
    edtIAURLLoginErrato: TEdit;
    edtIAPaginaIniziale: TEdit;
    edtIAMainDir: TEdit;
    cmbIADatabase: TComboBox;
    edtIAURLBase: TEdit;
    chkIARegistraCredenziali: TCheckBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label9: TLabel;
    edtIAB110Host: TEdit;
    Label11: TLabel;
    edtIAB110Port: TEdit;
    chkIAB110Protocollo: TCheckBox;
    edtIAB110Url: TEdit;
    Label33: TLabel;
    Label34: TLabel;
    edtIAB110UrlTest: TEdit;
    btnIAB110Test: TButton;
    chkUGExceptionIndy: TCheckBox;
    chkUGExceptionIndySSL: TCheckBox;
    chkUGExceptionSession: TCheckBox;   // gc: 11/09/19
    chkIARecuperoPassword: TCheckBox;
    Label4: TLabel;
    edtIAMaxRequests: TMaskEdit;
    Label25: TLabel;
    edtIATitolo: TEdit;
    Label41: TLabel;
    cmbIAStatoProfilo: TComboBox;
    Label43: TLabel;
    cmbIAStatoAzienda: TComboBox;
    btnDebenuPDFReg: TButton;
    Label45: TLabel;
    btnDebenuPDFUnreg: TButton;
    Label46: TLabel;
    Shape1: TShape;
    grpIAReCAPTCHA: TGroupBox;
    lblIAUrlRECAPTCHA: TLabel;
    lblIASiteKeyRECAPTCHA: TLabel;
    lblIASecretKeyRECAPTCHA: TLabel;
    edtIAUrlRECAPTCHA: TEdit;
    edtIASiteKeyRECAPTCHA: TEdit;
    edtIASecretKeyRECAPTCHA: TEdit;
    grpReCAPTCHA: TGroupBox;
    lblUrlReCAPTCHA: TLabel;
    lblSiteKeyReCAPTCHA: TLabel;
    lblSecretKeyReCAPTCHA: TLabel;
    edtUrlReCAPTCHA: TEdit;
    edtSiteKeyReCAPTCHA: TEdit;
    edtSecretKeyReCAPTCHA: TEdit;
    rgpCom: TRadioGroup;
    tsIISConfig: TTabSheet;
    grpWebConfig: TGroupBox;
    edtDLLPath: TEdit;
    lblDLLProdotto: TLabel;
    chkHttps: TCheckBox;
    chkPaginaManutenzione: TCheckBox;
    chkMonitorPrivati: TCheckBox;
    bntSelezionaDLL: TButton;
    lblVirtualPath: TLabel;
    grpURLRewrite: TGroupBox;
    lblVirtualPathValue: TLabel;
    btnSalvaWebConfig: TButton;
    lstDirectoryPrivate: TListBox;
    grpHiddenSegments: TGroupBox;
    btnAggiungiHiddenSegments: TButton;
    btnRimuoviHiddenSegments: TButton;
    chkForzaDominioCookie: TCheckBox;
    lblModuloNonInstallato: TLabel;
    cblPagineErrore: TCheckListBox;
    grbPagineErroreCustom: TGroupBox;
    ToolBar3: TToolBar;
    btnModifica3: TToolButton;
    ToolButton3: TToolButton;
    btnAnnulla3: TToolButton;
    btnSalva3: TToolButton;
    btnScaricaURLRewrite: TButton;
    chkOverrideDefaultPage: TCheckBox;
    procedure edtUrlAziendaChange(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnMidasRegClick(Sender: TObject);
    procedure cmbPaginaChange(Sender: TObject);
    procedure btnAggiungiCIClick(Sender: TObject);
    procedure lstCampiInvisibiliKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lstCampiInvisibiliDblClick(Sender: TObject);
    procedure btnLogonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PageControlChange(Sender: TObject);
    procedure chkFiltroErroreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFiltraClick(Sender: TObject);
    procedure mnuFiltraIdSessioneClick(Sender: TObject);
    procedure mnuFiltraIPClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure rgpApplicativoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgpTipoInstallazioneClick(Sender: TObject);
    procedure lnkMonitorSessioniClick(Sender: TObject);
    procedure lnkVisParametriConfigClick(Sender: TObject);
    procedure btnEseguiAzioneClick(Sender: TObject);
    procedure btnClearMemoClick(Sender: TObject);
    procedure cmbAzioniChange(Sender: TObject);
    procedure lblAccessoSitoClick(Sender: TObject);
    procedure cmbURLDataBaseChange(Sender: TObject);
    procedure chkEnableExcLogClick(Sender: TObject);
    procedure edtUrlBaseINIChange(Sender: TObject);
    procedure btnIAB110TestClick(Sender: TObject);
    procedure chkIAB110ProtocolloClick(Sender: TObject);
    procedure edtIAB110HostChange(Sender: TObject);
    procedure bntSelezionaDLLClick(Sender: TObject);
    procedure btnAggiungiHiddenSegmentsClick(Sender: TObject);
    procedure btnRimuoviHiddenSegmentsClick(Sender: TObject);
    procedure btnSalvaWebConfigClick(Sender: TObject);
    procedure btnScaricaURLRewriteClick(Sender: TObject);
  private
    W000ParConfig: TParConfig;
    InModifica: Boolean;
    ItemIrisWeb: Integer;
    ItemIrisCloudRilpre: Integer;
    ItemIrisCloudStagiu: Integer;
    ItemIrisCloudPaghe:  Integer;
    ItemIrisApp: Integer;
    ItemX001: Integer;
    URLRewriteInstallato: Boolean;
    procedure ViewURL;
    procedure SetIrisAPPUrlTest;
    //procedure LeggiRegistro;
    procedure AttivaCampiParametri(Attiva: Boolean);
    procedure GetConfigurazione;
    procedure GetCampidaNonVisualizzare;
    procedure SetConfigurazione;
    function  CtrlDirectoryWriteable(const PDirName: String): Boolean;
    procedure CaricaParametriAvanzati;
    procedure ApriUrl(const PContesto: String);
    function  GetUrlBase: String;
    procedure AddToMemo(var PMemo: TMemo; const PLine: String);
  public
    FiltroMsg,
    FiltroPeriodo: String;
    DalOrig,
    AlOrig: TDateTime;
  end;

var
  B000FConfigWebServer: TB000FConfigWebServer;

const
  ITEM_NAME_IRISWEB          = 'IrisWeb';
  ITEM_NAME_IRISCLOUD_RILPRE = 'IrisCloud-Presenze';
  ITEM_NAME_IRISCLOUD_PAGHE  = 'IrisCloud-Stipendi';
  ITEM_NAME_IRISCLOUD_STAGIU = 'IrisCloud-Giuridico';
  ITEM_NAME_IRISAPP          = 'IrisAPP';
  ITEM_NAME_X001             = 'X001';

  ITEM_EXE_NAME_IRISWEB          = 'W000PIrisWeb.exe';
  ITEM_EXE_NAME_IRISCLOUD_RILPRE = 'IrisCloudRilPre.exe';
  ITEM_EXE_NAME_IRISCLOUD_PAGHE  = 'IrisCloudStipendi.exe';
  ITEM_EXE_NAME_IRISCLOUD_STAGIU = 'IrisCloudStagiu.exe';
  ITEM_EXE_NAME_X001             = 'X001PCentriCostoTOHM.exe';

  ITEM_DLL_NAME_IRISWEB          = 'W000PIrisWeb_IIS.dll';
  ITEM_DLL_NAME_IRISCLOUD_RILPRE = 'IrisCloudRilPre_IIS.dll';
  ITEM_DLL_NAME_IRISCLOUD_PAGHE  = 'IrisCloudStipendi_IIS.dll';
  ITEM_DLL_NAME_IRISCLOUD_STAGIU = 'IrisCloudStagiu_IIS.dll';
  ITEM_DLL_NAME_IRISAPP          = 'WM000PIrisAPP.dll';
  ITEM_DLL_NAME_X001             = 'X001PCentriCostoTOHM_IIS.dll';

  ITEM_SRV_NAME_IRISWEB   = 'IrisWeb';
  ITEM_SRV_NAME_IRISCLOUD_RILPRE = 'IrisCloudRilpre';
  ITEM_SRV_NAME_IRISCLOUD_PAGHE  = 'IrisCloudStipendi';
  ITEM_SRV_NAME_IRISCLOUD_STAGIU = 'IrisCloudStagiu';
  ITEM_SRV_NAME_IRISAPP   = 'IrisAPP';
  ITEM_SRV_NAME_X001      = 'X001';

  MOD_REWRITE_NON_TROVATO = '"URL base" non valido!';
  MOD_REWRITE_DOWNLOAD    = 'https://www.iis.net/downloads/microsoft/url-rewrite';

  // irisweb
  ElementiIrisWEB: array [0..32] of TElementiForm = (
    (Contenitore:'';                             Elementi:'lnkHelp'),
    (Contenitore:'W001FLogin';                   Elementi:'edtAzienda,edtUtente,edtPassword,edtDatabase,edtNomeProfilo,cmbNomeProfilo,lblAzienda,lblUtente,lblPassword,lblDatabase,lblNomeProfilo,btnAccedi'),
    (Contenitore:'W002FAnagrafeElenco';          Elementi:'chkDipendentiCessati'),
    (Contenitore:'W002FRicercaAnagrafe';         Elementi:'lnkRicercaSalvata,cmbSelezioni,lnkSQLSalvato'),
    (Contenitore:'W003FAnomalie';                Elementi:'chkLivello1,chkLivello2,chkLivello3'),
    (Contenitore:'W005FCartellino';              Elementi:'lblCausPresDisponibili,cmbCausPresDisponibili,lblCausAssDisponibili,cmbCausAssDisponibili'),
    //(Contenitore:'W007FGestioneSicurezza';       Elementi:'lblEMail,edtEMail'),
    (Contenitore:'W008FGiustificativi';          Elementi:'chkStampaRicevuta,chkFiltro'),
    (Contenitore:'W009FStampaCartellino';        Elementi:'chkAggiornamentoScheda,chkAutoGiustificazione,chkAggiornamentoBuoniPasto,chkAggiornamentoAccessiMensa'),
    (Contenitore:'W010FRichiestaAssenze';        Elementi:''),
    (Contenitore:'W011FMessaggi';                Elementi:''),
    (Contenitore:'W012FCurriculum';              Elementi:''),
    (Contenitore:'W013FPreferenze';              Elementi:''),
    (Contenitore:'W014FPianifCorsi';             Elementi:''),
    (Contenitore:'W015FServerStampe';            Elementi:''),
    (Contenitore:'W016FAccessiMensa';            Elementi:''),
    (Contenitore:'W017FStampaCedolino';          Elementi:''),
    (Contenitore:'W018FRichiestaTimbrature';     Elementi:'btnTuttiSi,btnTuttiNo'),
    (Contenitore:'W019FGestioneDeleghe';         Elementi:''),
    (Contenitore:'W020FCambioProfilo';           Elementi:''),
    (Contenitore:'W021FStampaCUD';               Elementi:'lnkIstrCUD'),
    (Contenitore:'W022FDettaglioValutazioni';    Elementi:''),
    (Contenitore:'W022FSchedaValutazioni';       Elementi:''),
    (Contenitore:'W023FPianifOrari';             Elementi:''),
    (Contenitore:'W024FRichiestaStraordinari';   Elementi:''),
    (Contenitore:'W026FRichiestaStrGG';          Elementi:''),
    (Contenitore:'W027FDetrazioniIRPEF';         Elementi:''),
    (Contenitore:'W028FChiamateReperibili';      Elementi:''),
    (Contenitore:'W029FPesatureIndividuali';     Elementi:''),
    (Contenitore:'W030FTabelloneTurni';          Elementi:''),
    (Contenitore:'W031FSchedeQuantIndividuali';  Elementi:''),
    (Contenitore:'W032FRichiestaMissioni';       Elementi:'tabMissioniTab0,tabMissioniTab1,tabMissioniTab2,tabMissioniTab3,lblProgettoEuropeo,memProgettoEuropeo,cgpMotivEstero,cgpIpotesiEstero'),
    (Contenitore:'W033FProspettoAssenze';        Elementi:''),
    (Contenitore:'WC023FCambioPasswordFM';       Elementi:'lblEMail,edtEMail,lblEMailPEC,edtEMailPEC')
  );

  // iriscloud
  ElementiIrisCloud: array [0..2] of TElementiForm = (
    (Contenitore:'';                             Elementi:'lnkHelp'),
    (Contenitore:'WA001FPaginaPrincipaleLogin';  Elementi:'edtAzienda,edtUtente,edtPassword,edtDatabase,edtNomeProfilo,cmbNomeProfilo,lblAzienda,lblUtente,lblPassword,lblDatabase,lblNomeProfilo,btnAccedi'),
    (Contenitore:'WC023FCambioPasswordFM';       Elementi:'lblEMail,edtEMail,lblEMailPEC,edtEMailPEC')
    );

implementation
{$R *.dfm}

procedure TB000FConfigWebServer.FormCreate(Sender: TObject);
var
  PathCorr: String;
  i: Integer;
begin
  // popola la checklistbox dei parametri avanzati
  CaricaParametriAvanzati;
  // caricamento alias database
  if OracleAliasList <> nil then
  begin
    cmbDataBase.Items.Assign(OracleAliasList);
    cmbIADataBase.Items.Assign(OracleAliasList);
    cmbURLDataBase.Items.Assign(OracleAliasList);
    cmbDataBaseMsg.Items.Assign(OracleAliasList);
  end;

  //parametri di configurazione applicativi web su file.ini
  //LeggiRegistro;
  PathCorr:=ExtractFilePath(Application.ExeName);
  edtPathBase.Text:=PathCorr;

  if not CtrlDirectoryWriteable(PathCorr) then
    raise Exception.Create('Non sono disponibili i diritti di scrittura sulla directory'#13#10 +
                           PathCorr +
                           #13#10'Impossibile modificare la configurazione degli applicativi web!');

  // aggiunge al radiogrup gli item degli applicativi in base alla presenza
  // dei file che li contraddistinguono
  rgpApplicativo.OnClick:=nil;
  rgpApplicativo.Items.Clear;
  if (Length(TDirectory.GetFiles(PathCorr,'W000*.exe')) = 0) and (Length(TDirectory.GetFiles(PathCorr,'W000*.dll')) = 0) then
    ItemIrisWeb:=-1
  else
    ItemIrisWeb:=rgpApplicativo.Items.Add(ITEM_NAME_IRISWEB);
  if Length(TDirectory.GetFiles(PathCorr,'IrisCloudRilpre*.*')) = 0 then
    ItemIrisCloudRilpre:=-1
  else
    ItemIrisCloudRilpre:=rgpApplicativo.Items.Add(ITEM_NAME_IRISCLOUD_RILPRE);
  if Length(TDirectory.GetFiles(PathCorr,'IrisCloudStipendi*.*')) = 0 then
    ItemIrisCloudPaghe:=-1
  else
    ItemIrisCloudPaghe:=rgpApplicativo.Items.Add(ITEM_NAME_IRISCLOUD_PAGHE);
  if Length(TDirectory.GetFiles(PathCorr,'IrisCloudStagiu*.*')) = 0 then
    ItemIrisCloudStagiu:=-1
  else
    ItemIrisCloudStagiu:=rgpApplicativo.Items.Add(ITEM_NAME_IRISCLOUD_STAGIU);
  if (Length(TDirectory.GetFiles(PathCorr,'WM000*.exe')) = 0) and (Length(TDirectory.GetFiles(PathCorr,'WM000*.dll')) = 0) then
    ItemIrisApp:=-1
  else
    ItemIrisApp:=rgpApplicativo.Items.Add(ITEM_NAME_IRISAPP);
  if Length(TDirectory.GetFiles(PathCorr,'X001*.*')) = 0 then
    ItemX001:=-1
  else
    ItemX001:=rgpApplicativo.Items.Add(ITEM_NAME_X001);

  // seleziona il primo applicativo con un file di configurazione esistente
  if TFile.Exists(PathCorr + FILE_CONFIG_IRISWEB) and (ItemIrisWeb >= 0) then
    rgpApplicativo.ItemIndex:=ItemIrisWeb
  else if TFile.Exists(PathCorr + FILE_CONFIG_IRISCLOUD) and (ItemIrisCloudRilpre >= 0) then
    rgpApplicativo.ItemIndex:=ItemIrisCloudRilpre
  else if TFile.Exists(PathCorr + FILE_CONFIG_IRISCLOUD) and (ItemIrisCloudPaghe >= 0) then
    rgpApplicativo.ItemIndex:=ItemIrisCloudPaghe
  else if TFile.Exists(PathCorr + FILE_CONFIG_IRISCLOUD) and (ItemIrisCloudStagiu >= 0) then
    rgpApplicativo.ItemIndex:=ItemIrisCloudStagiu
  else if TFile.Exists(PathCorr + FILE_CONFIG_IRISAPP) and (ItemIrisApp >= 0) then
    rgpApplicativo.ItemIndex:=ItemIrisApp
  else if TFile.Exists(PathCorr + FILE_CONFIG_X001) and (ItemX001 >= 0) then
    rgpApplicativo.ItemIndex:=ItemX001
  else if rgpApplicativo.Items.Count > 0 then
    rgpApplicativo.ItemIndex:=0
  else
  begin
    rgpApplicativo.ItemIndex:=-1;
    btnModifica.Enabled:=False;
  end;
  rgpApplicativo.OnClick:=rgpApplicativoClick;

  PageControl.TabIndex:=0;
  InModifica:=False;
  edtUrlAzienda.Text:='AZIN';

  // carica azioni sito
  cmbAzioni.Items.Clear;
  for i:=Low(A000AzioniSitoWeb) to High(A000AzioniSitoWeb) do
  begin
    cmbAzioni.Items.Add(A000AzioniSitoWeb[i].Nome);
  end;
  cmbAzioni.ItemIndex:=-1;

  rgpApplicativoClick(nil);
  (*
  GetConfigurazione;
  // parametri di configurazione applicativi web su file.fine

  GetCampidaNonVisualizzare;
  *)
  URLRewriteInstallato:=False;
  with TRegistry.Create do
  begin
   try
     RootKey:=HKEY_LOCAL_MACHINE;
     if OpenKeyReadOnly('\SOFTWARE\Microsoft\IIS Extensions\URL Rewrite') then
     begin
       try
         URLRewriteInstallato:=ValueExists('Version');
       except
         CloseKey;
         raise;
       end;
       CloseKey;
     end;
   finally
     Free;
   end;
  end;
  grpURLRewrite.Enabled:=URLRewriteInstallato;
  chkHttps.Enabled:=URLRewriteInstallato;
  chkPaginaManutenzione.Enabled:=URLRewriteInstallato;
  chkMonitorPrivati.Enabled:=URLRewriteInstallato;
  chkForzaDominioCookie.Enabled:=URLRewriteInstallato;
  lblModuloNonInstallato.Visible:=not(URLRewriteInstallato);
  btnScaricaURLRewrite.Visible:=not(URLRewriteInstallato);
end;

procedure TB000FConfigWebServer.FormShow(Sender: TObject);
begin
  lblUrlIrisWebCloud.Top:=309;
  edtUrlIrisWebCloud.Top:=306;
  chkIrisWebCloudNewTab.Top:=329;
  if rgpApplicativo.ItemIndex = -1 then
  begin
    PageControl.ActivePage:=tsComponenti;
    StatusBar1.Panels[0].Text:='Nessuna configurazione applicabile';
  end;
  AttivaCampiParametri(InModifica);
end;

procedure TB000FConfigWebServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with B000FConfigWebServerDM do
  begin
    if DbMessaggi.Connected then
    begin
      try selMsgDett.CloseAll; except end;
      try selMsgHead.CloseAll; except end;
      try DbMessaggi.LogOff; except end;
    end;
  end;
end;

procedure TB000FConfigWebServer.CaricaParametriAvanzati;
begin
  chkParametriAvanzati.Items.BeginUpdate;
  chkParametriAvanzati.Items.Clear;
  chkParametriAvanzati.Items.Add(INI_PAR_DISABLE_CHIUSURA_BROWSER);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_CRITICAL_SECTION_LOGIN);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_CRITICAL_SECTION_SESSIONE);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_SHARED_LOGIN);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_REGISTRA_MSG);
  chkParametriAvanzati.Items.Add(INI_PAR_RECUPERO_PASSWORD);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_ABILITAZIONI);
  chkParametriAvanzati.Items.Add(INI_PAR_USE_STANDARD_PRINTER);
  chkParametriAvanzati.Items.Add(INI_PAR_COMPRESSION);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_STAMPACARTELLINO);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_STAMPACEDOLINO);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_PDF);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_COINITIALIZE);
  chkParametriAvanzati.Items.Add(INI_PAR_CAPTION_LAYOUT);
  chkParametriAvanzati.Items.Add(INI_PAR_TRADUZIONE_CAPTION);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_DEL_TEMPFILE_ONCREATE);
  chkParametriAvanzati.Items.Add(INI_PAR_CACHED_FILES);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_UNIFIED_FILES);
  chkParametriAvanzati.Items.Add(INI_PAR_JQUERY_UNCOMPRESSED);
  chkParametriAvanzati.Items.Add(INI_PAR_FILE_INLINE);
  chkParametriAvanzati.Items.Add(INI_PAR_DB_STATEMENT_CACHE);
  chkParametriAvanzati.Items.Add(INI_PAR_DB_NO_CHECK_CONNECTION);
  chkParametriAvanzati.Items.Add(INI_PAR_DB_NO_RECONNECT);
  chkParametriAvanzati.Items.Add(INI_PAR_LOGOFF_DBPOOL);
  //chkParametriAvanzati.Items.Add(INI_PAR_C017_V430);
  //chkParametriAvanzati.Items.Add(INI_PAR_C018_LEADING_T030);
  //chkParametriAvanzati.Items.Add(INI_PAR_C018_NO_LEADING_T030);
  //chkParametriAvanzati.Items.Add(INI_PAR_C018_UNNEST);
  //chkParametriAvanzati.Items.Add(INI_PAR_C018_NO_UNNEST);
  //chkParametriAvanzati.Items.Add(INI_PAR_T050_CANCELLAZIONE);
  chkParametriAvanzati.Items.Add(INI_PAR_RAVEREPORT_IN_MEMORIA);
  chkParametriAvanzati.Items.Add(INI_PAR_TOLLERA_IE7);
  chkParametriAvanzati.Items.Add(INI_PAR_COOKIES_ENABLE_HTTPONLY);
  chkParametriAvanzati.Items.Add(INI_PAR_COOKIES_ENABLE_SECURE);
  chkParametriAvanzati.Items.Add(INI_PAR_COOKIES_ENABLE_SAMESITE_STRICT);
  chkParametriAvanzati.Items.Add(INI_PAR_SECURITY_ENABLE_FORM_ID_CHECK);
  chkParametriAvanzati.Items.Add(INI_PAR_SECURITY_ENABLE_SAME_UA_CHECK);
  chkParametriAvanzati.Items.Add(INI_PAR_SECURITY_ENABLE_SAME_IP_CHECK);
  chkParametriAvanzati.Items.Add(INI_PAR_IRISWEB_ENABLE_MULTISCHEDA);
  chkParametriAvanzati.Items.Add(INI_PAR_SECURITY_ENABLE_XSS_PROTECTION);
  chkParametriAvanzati.Items.Add(INI_PAR_SESSIONE_SINGOLA_PER_USR);
  chkParametriAvanzati.Items.EndUpdate;
end;

function TB000FConfigWebServer.CtrlDirectoryWriteable(const PDirName: String): Boolean;
// determina se si hanno i diritti di scrittura sulla directory specificata
var
  FileName: String;
  H: THandle;
begin
  FileName:=IncludeTrailingPathDelimiter(PDirName) + 'chk.tmp';
  H:=CreateFile(PChar(FileName),GENERIC_READ or GENERIC_WRITE,0,nil,
       CREATE_NEW, FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE, 0);
  Result:=H <> INVALID_HANDLE_VALUE;
  if Result then
    CloseHandle(H);
end;

procedure TB000FConfigWebServer.rgpApplicativoClick(Sender: TObject);
begin
  if rgpApplicativo.ItemIndex >= 0 then
    StatusBar1.Panels[0].Text:='Configurazione ' + rgpApplicativo.Items[rgpApplicativo.ItemIndex];
  StatusBar1.Repaint;
  GetConfigurazione;
  GetCampidaNonVisualizzare;
  rgpTipoInstallazioneClick(rgpTipoInstallazione);
end;

procedure TB000FConfigWebServer.rgpTipoInstallazioneClick(Sender: TObject);
begin
  // url base applicativo selezionato
  if edtUrlBaseINI.Text = '' then
    edtUrlBaseINI.Text:=GetUrlBase;
end;

procedure TB000FConfigWebServer.GetCampidaNonVisualizzare;
var i:Integer;
begin
  // carica combo pagine
  cmbPagina.Items.BeginUpdate;
  cmbPagina.Items.Clear;
  if rgpApplicativo.ItemIndex = ItemIrisWeb then
  begin
    for i:=0 to High(ElementiIrisWeb) do
      cmbPagina.Items.Add(ElementiIrisWeb[i].Contenitore);
  end
  else if R180In(rgpApplicativo.ItemIndex,[ItemIrisCloudRilpre,ItemIrisCloudPaghe,ItemIrisCloudStagiu]) then
  begin
    for i:=0 to High(ElementiIrisCloud) do
      cmbPagina.Items.Add(ElementiIrisCloud[i].Contenitore);
  end;
  cmbPagina.Items.EndUpdate;
end;

procedure TB000FConfigWebServer.GetConfigurazione;
var
  NomeFileConfig, PathFileConfig: String;
  IniFile: TIniFile;

  procedure GetConfigWeb;
  var i,j: Integer;
      LogAbilitati, ParamAvanzati: TStringList;
      StringList:TStringList;
  begin
    LogAbilitati:=TStringList.Create;
    ParamAvanzati:=TStringList.Create;
    try
      //impostazioni operative
      cmbDatabase.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_DATABASE,'');
      edtAziendaDefault.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_AZIENDA,'');
      edtProfiloDefault.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_PROFILO,'');
      edtMaxSessioni.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_MAX_SESSIONI,0));
      if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
        edtUrlSuperoMaxSessioni.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS_RILPRE,IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,''))
      else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
        edtUrlSuperoMaxSessioni.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS_STAGIU,IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,''))
      else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
        edtUrlSuperoMaxSessioni.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS_PAGHE,IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,''))
      else
        edtUrlSuperoMaxSessioni.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,'');
      edtTOOperatore.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_OPER,30));
      edtTODipendente.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_DIP,15));
      if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
        edtHome.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME_RILPRE,IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,''))
      else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
        edtHome.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME_STAGIU,IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,''))
      else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
        edtHome.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME_PAGHE,IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,''))
      else
        edtHome.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,'');
      edtURLLoginErrato.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_LOGINERR,'');
      //edtPathLog.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_PATH_LOG,'C:\IrisWIN\Archivi');
      edtUrlWsAuth.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_WS_AUT,'');
      edtURLMan.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_MANUTENZIONE,'');
      edtUrlIrisWebCloud.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_IRISWEBCLOUD,'');
      chkIrisWebCloudNewTab.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_IRISWEBCLOUD_NEWTAB,'N') = 'S';
      edtUrlWebApp.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_WEBAPP,'');
      chkLoginEsterno.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_LOGIN_ESTERNO,'N') = 'S';
      lstCampiInvisibili.Items.CommaText:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_CAMPI_INVISIBILI,'');
      edtTabColPartenza.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_TAB_COL_PARTENZA,'');
      edtNumLivelli.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_NUM_LIVELLI,0));
      edtPaginaIniziale.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_STARTPAGE,'');
      edtPaginaSingola.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SINGLEPAGE,'');
      // gestione parametri ReCAPTCHA
      edtUrlRECAPTCHA.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URLRECAPTCHA,'');
      edtSiteKeyRECAPTCHA.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SITEKEYRECAPTCHA,'');
      edtSecretKeyRECAPTCHA.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SECRETKEYRECAPTCHA,'');
      //impostazioni di sistema
      if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
        edtPort.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT_RILPRE,IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT,5000)))
      else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
        edtPort.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT_STAGIU,IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT,5000)))
      else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
        edtPort.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT_PAGHE,IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT,5000)))
      else
        edtPort.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT,5000));
      edtCursoriLogin.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_LOGIN,12));
      edtCursoriSessione.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_SESSIONE,10));
      edtMaxOpenCursors.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_OPEN_CURSORS,1000));
      edtMaxProcessMemory.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_WORKING_MEMORY,0));
      edtMainDir.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','');
      // iw exception log
      chkEnableExcLog.Checked:=(IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ABILITATO,'N') = 'S');
      edtELPathFile.Text:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_PATH_FILE_LOG,'');
      edtELNomeFile.Text:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_NOME_FILE_LOG,'');
      edtELNumGiorniPurge.Value:=IniFile.ReadInteger(INI_SEZ_IMPOST_IW_LOG,INI_EL_GIORNI_RIMOZIONE,1);
      edtELPathFile.Text:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_PATH_FILE_LOG,'');
      StringList:=TStringList.Create();
      chkELEccPredefinite.CheckAll(TCheckBoxState.cbUnchecked);
      edtELEccCustom.Text:='';
      try
        StringList.CaseSensitive:=False;
        StringList.Sorted:=True;
        StringList.Duplicates:=TDuplicates.dupIgnore;
        StringList.StrictDelimiter:=True;
        StringList.DelimitedText:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ECCEZ_IGNORATE,'');
        for i:=0 to (StringList.Count - 1) do
        begin
          j:=chkELEccPredefinite.Items.IndexOf(StringList[i]);
          if j >= 0 then
            chkELEccPredefinite.Checked[j]:=True
          else
            edtELEccCustom.Text:=edtELEccCustom.Text +
                                 IfThen(edtELEccCustom.Text <> '',',','') +
                                 StringList[i];
        end;
      finally
        StringList.Free;
      end;
      LogAbilitati.CommaText:=IniFile.ReadString(INI_SEZ_IMPOST_SIST,INI_ID_LOG_ABILITATI,'');
      chkErrore.Checked:=False;
      chkMemoria.Checked:=False;
      chkSessione.Checked:=False;
      chkAccesso.Checked:=False;
      chkTraccia.Checked:=False;
      if LogAbilitati.Count <> 0 then
      begin
        for i:=0 to LogAbilitati.Count - 1 do
        begin
          if LogAbilitati[i] = INI_LOG_ERRORE then
            chkErrore.Checked:=True
          else if LogAbilitati[i] = INI_LOG_MEMORIA then
            chkMemoria.Checked:=True
          else if LogAbilitati[i] = INI_LOG_SESSIONE then
            chkSessione.Checked:=True
          else if LogAbilitati[i] = INI_LOG_ACCESSO then
            chkAccesso.Checked:=True
          else if LogAbilitati[i] = INI_LOG_TRACCIA then
            chkTraccia.Checked:=True;
        end;
      end;

      ParamAvanzati.CommaText:=IniFile.ReadString(INI_SEZ_IMPOST_SIST,INI_ID_PARAMETRI_AVANZATI,'');
      rgpCom.ItemIndex:=0;
      chkParametriAvanzati.CheckAll(cbUnchecked);
      if ParamAvanzati.Count <> 0 then
      begin
        R180PutCheckList(ParamAvanzati.CommaText,50,chkParametriAvanzati);

        for i:=0 to ParamAvanzati.Count - 1 do
        begin
          if ParamAvanzati[i] = INI_COM_NONE then
          begin
            rgpCom.ItemIndex:=1;
            Break;
          end
          else if ParamAvanzati[i] = INI_COM_NORMAL then
          begin
            rgpCom.ItemIndex:=2;
            Break;
          end
          else if ParamAvanzati[i] = INI_COM_MULTI then
          begin
            rgpCom.ItemIndex:=3;
            Break;
          end;
        end;
      end;
      // gc: 11/09/19 (URL di base e Tipo installazione)
      // nb: l'istruzione rgpTipoInstallazione.ItemIndex scatena l'evento onClic
      if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
        edtUrlBaseINI.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE_RILPRE,IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE,''))
      else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
        edtUrlBaseINI.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE_STAGIU,IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE,''))
      else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
        edtUrlBaseINI.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE_PAGHE,IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE,''))
      else
        edtUrlBaseINI.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE,'');
      rgpTipoInstallazione.ItemIndex:=-1;
      rgpTipoInstallazione.ItemIndex:=IfThen(IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_TIPO_INSTALLAZIONE,'IIS') = 'IIS',0,1);

      // sezione impostazioni server IIS
      edtDLLPath.Text:=IniFile.ReadString(INI_SEZ_IMPOST_IIS,INI_IIS_DLL_PATH,'');
      chkOverrideDefaultPage.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_IIS,INI_IIS_DEFAULT_PAGE,'N') = 'S';
      if URLRewriteInstallato then
      begin
        chkHttps.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_IIS,INI_IIS_HTTPS_ONLY,'N') = 'S';
        chkPaginaManutenzione.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_IIS,INI_IIS_IN_MANUTENZIONE,'N') = 'S';
        chkMonitorPrivati.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_IIS,INI_IIS_MONITOR_PRIVATI,'N') = 'S';
        chkForzaDominioCookie.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_IIS,INI_IIS_DOMINIO_COOKIE,'N') = 'S';
      end;
      lstDirectoryPrivate.Items.CommaText:=IniFile.ReadString(INI_SEZ_IMPOST_IIS,INI_IIS_HIDDEN_DIRECORY,'');
      StringList:=TStringList.Create();
      cblPagineErrore.CheckAll(TCheckBoxState.cbUnchecked);
      try
        StringList.CaseSensitive:=False;
        StringList.Sorted:=True;
        StringList.Duplicates:=TDuplicates.dupIgnore;
        StringList.StrictDelimiter:=True;
        StringList.DelimitedText:=IniFile.ReadString(INI_SEZ_IMPOST_IIS,INI_IIS_CUSTOM_ERROR,'');
        for i:=0 to (StringList.Count - 1) do
        begin
          j:=cblPagineErrore.Items.IndexOf(StringList[i]);
          if j >= 0 then
            cblPagineErrore.Checked[j]:=True
        end;
      finally
        StringList.Free;
      end;
    finally
      FreeAndNil(LogAbilitati);
      FreeAndNil(ParamAvanzati);
    end;
  end;

  procedure GetConfigApp;
  var IniB110: TIniFile; Valore: String;
  begin
    try
      //B110.ini (Database)
      IniB110:=TIniFile.Create(ExtractFilePath(Application.ExeName) + 'B110.ini');
      try
        cmbIADatabase.Text:=IniB110.ReadString('Default',INI_ID_DATABASE,'');
        chkIALoginEsterno.Checked:=IniB110.ReadString('Default',INI_ID_LOGIN_ESTERNO,'N') = 'S';
      finally
        FreeAndNil(IniB110);
      end;
      //impostazioni operative
      edtIAAzienda.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_AZIENDA,'');
      edtIAProfilo.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_PROFILO,'');
      edtIAMaxSessioni.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_MAX_SESSIONI,0));
      edtIAMaxRequests.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_MAX_REQUESTS,50));
      edtIAUrlSuperoMaxSessioni.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,'');
      edtIATimeOut.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_DIP,15));
      edtIATitolo.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_TITOLO_IRISAPP,'');
      edtIAHome.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,'');
      edtIAURLLoginErrato.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_LOGINERR,'');
      edtIAURLManutenzione.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_MANUTENZIONE,'');
      edtIAPaginaIniziale.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_STARTPAGE,'');
      chkIARegistraCredenziali.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_REG_CREDENZIALI,'N') = 'S';
      chkIARecuperoPassword.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_RECUPERO_PASSWORD,'N') = 'S';
      edtIAUrlBase.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE,'');
      edtIAUrlRECAPTCHA.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URLRECAPTCHA,'');
      edtIASiteKeyRECAPTCHA.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SITEKEYRECAPTCHA,'');
      edtIASecretKeyRECAPTCHA.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SECRETKEYRECAPTCHA,'');

      Valore:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_STATO_AZIENDA,'');
      if (Valore = 'S') then
        cmbIAStatoAzienda.ItemIndex:=1
      else if (Valore = 'N') then
        cmbIAStatoAzienda.ItemIndex:=2
      else if (Valore = 'R') then
        cmbIAStatoAzienda.ItemIndex:=3
      else
        cmbIAStatoAzienda.ItemIndex:=0;

      Valore:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_STATO_PROFILO,'');
      if (Valore = 'S') then
        cmbIAStatoProfilo.ItemIndex:=1
      else if (Valore = 'N') then
        cmbIAStatoProfilo.ItemIndex:=2
      else if (Valore = 'R') then
        cmbIAStatoProfilo.ItemIndex:=3
      else
        cmbIAStatoProfilo.ItemIndex:=0;

      //impostazioni di sistema
      chkIAB110Protocollo.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_SIST,INI_ID_B110PROTOCOLLO,'N') = 'https';
      edtIAB110Host.Text:=IniFile.ReadString(INI_SEZ_IMPOST_SIST,INI_ID_B110HOST,'localhost');
      edtIAB110Port.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_B110PORT,80));
      edtIAB110Url.Text:=IniFile.ReadString(INI_SEZ_IMPOST_SIST,INI_ID_B110URL,'IrisAPP/WM000PIrisAPP.dll');
      SetIrisAPPUrlTest;

      chkUGExceptionIndy.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_UG_LOG,INI_UGEL_INDY,'N') = 'S';
      chkUGExceptionIndySSL.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_UG_LOG,INI_UGEL_INDYSSL,'N') = 'S';
      chkUGExceptionSession.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_UG_LOG,INI_UGEL_SESSION,'N') = 'S';

      edtIAMainDir.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','');
    finally
    end;
  end;

begin
  if rgpApplicativo.ItemIndex = ItemIrisWeb then
    NomeFileConfig:=FILE_CONFIG_IRISWEB
  else if R180In(rgpApplicativo.ItemIndex,[ItemIrisCloudRilpre,ItemIrisCloudPaghe,ItemIrisCloudStagiu]) then
    NomeFileConfig:=FILE_CONFIG_IRISCLOUD
  else if rgpApplicativo.ItemIndex = ItemIrisApp then
    NomeFileConfig:=FILE_CONFIG_IRISAPP
  else if rgpApplicativo.ItemIndex = ItemX001 then
    NomeFileConfig:=FILE_CONFIG_X001;

  // *** visibilità elementi in base all'applicativo

  grpImpOper.Visible:=rgpApplicativo.ItemIndex <> ItemIrisAPP;
  grpImpSist.Visible:=rgpApplicativo.ItemIndex <> ItemIrisAPP;
  grpImpSist.Top:=grpImpOper.Top + grpImpOper.Height + 1;
  grpIrisAPP.Visible:=rgpApplicativo.ItemIndex = ItemIrisAPP;
  grpIrisAPP.Align:=alTop;
  grpIrisAPP.Parent:=tsParametri;
  Toolbar1.Top:=0;

  // profilo: solo per irisweb
  lblProfiloDefault.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  edtProfiloDefault.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  // max sessioni: sempre visibile
  edtMaxSessioni.Visible:=True;
  edtUrlSuperoMaxSessioni.Visible:=True;
  // timeout operatore: solo per irisweb e iriscloud
  lblTOOperatore.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtTOOperatore.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // timeout dipendente: solo per irisweb e x001
  lblTODipendente.Visible:=not R180In(rgpApplicativo.ItemIndex,[ItemIrisCloudRilpre,ItemIrisCloudPaghe,ItemIrisCloudStagiu]);
  edtTODipendente.Visible:=lblTODipendente.Visible;
  // url ws autenticazione: solo per irisweb
  lblUrlWsAuth.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  edtUrlWsAuth.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  // login esterno: solo per irisweb e iriscloud
  chkLoginEsterno.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  lblPaginaSingola.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtPaginaSingola.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  lblPaginaIniziale.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  edtPaginaIniziale.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  // url richiamo IrisWeb/IrisCloud: solo per irisweb e iriscloud
  lblUrlIrisWebCloud.Caption:='URL richiamo ' + IfThen(rgpApplicativo.ItemIndex = ItemIrisWeb,ITEM_NAME_IRISCLOUD_RILPRE,ITEM_NAME_IRISWEB);
  lblUrlIrisWebCloud.Visible:=R180In(rgpApplicativo.ItemIndex,[ItemIrisWeb,ItemIrisCloudRilpre]);
  edtUrlIrisWebCloud.Visible:=lblUrlIrisWebCloud.Visible;
  // richiamo IrisWeb/IrisCloud in un'altra finestra: solo per irisweb e iriscloud
  chkIrisWebCloudNewTab.Caption:='Apri ' + IfThen(rgpApplicativo.ItemIndex = ItemIrisWeb,ITEM_NAME_IRISCLOUD_RILPRE,ITEM_NAME_IRISWEB) + ' in un''altra finestra';
  chkIrisWebCloudNewTab.Visible:=(rgpApplicativo.ItemIndex <> ItemX001) and (ItemIrisWeb <> -1) and (ItemIrisCloudRilpre <> -1);
  // url richiamo altra web app: solo per irisweb
  lblUrlWebApp.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  edtUrlWebApp.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  // tab. col partenza: solo per x001
  lblTabColPartenza.Visible:=(rgpApplicativo.ItemIndex = ItemX001);
  edtTabColPartenza.Visible:=(rgpApplicativo.ItemIndex = ItemX001);
  // num. livelli: solo per x001
  lblNumLivelli.Visible:=(rgpApplicativo.ItemIndex = ItemX001);
  edtNumLivelli.Visible:=(rgpApplicativo.ItemIndex = ItemX001);
  // cursori login: solo per irisweb e iriscloud
  lblCursoriLogin.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtCursoriLogin.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // cursori sessione: solo per irisweb e iriscloud
  lblCursoriSessione.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtCursoriSessione.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // max open cursors: solo per irisweb e iriscloud
  lblMaxOpenCursors.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtMaxOpenCursors.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // iw exception logger
  chkEnableExcLog.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  grpExceptionLogger.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // URL base "da file INI": solo per irisweb e iriscloud  (gc: 11/09/19)
  lblUrlBaseINI.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtUrlBaseINI.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // Tipo Installazione "da file INI": solo per irisweb e iriscloud  (gc: 11/09/19)
  rgpTipoInstallazione.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // Gestione ReCAPTCHA visibile solo per irisweb
  grpReCAPTCHA.Visible:=False and (rgpApplicativo.ItemIndex = ItemIrisWeb);

  grpWebConfig.Visible:=(rgpApplicativo.ItemIndex <> ItemX001) and (rgpApplicativo.ItemIndex <> ItemIrisApp);

  // determina il file ini di configurazione dell'applicativo
  PathFileConfig:=ExtractFilePath(Application.ExeName) + NomeFileConfig;
  IniFile:=TIniFile.Create(PathFileConfig);

  try
    if NomeFileConfig = FILE_CONFIG_IRISAPP then
      GetConfigApp
    else
      GetConfigWeb;
  finally
    FreeAndNil(IniFile);
  end;
end;

procedure TB000FConfigWebServer.SetIrisAPPUrlTest;
begin
  edtIAB110UrlTest.Text:=IfThen(chkIAB110Protocollo.Checked,'https://','http://') +
                         StringReplace(edtIAB110Host.Text + IfThen(edtIAB110Port.Text <> '',':' + edtIAB110Port.Text) + '/' +
                                       edtIAB110Url.Text +
                                       '/datasnap/rest/TB110FServerMethodsDM/Echo/Chiamata al servizio B110 riuscita!',
                                       '//','/',[rfReplaceAll]);
                         ;
end;

procedure TB000FConfigWebServer.SetConfigurazione;
var
  NomeFileConfig: String;
  IniFile: TIniFile;
  procedure SetConfigApp;
  var IniB110: TIniFile;
      Valore: String;
      ValoreInt: Integer;
  begin
    //B110.ini (Database)
    IniB110:=TIniFile.Create(ExtractFilePath(Application.ExeName) + 'B110.ini');
    try
      W000ParConfig.Database:=Trim(cmbIADatabase.Text);
      IniB110.WriteString('Default',INI_ID_DATABASE,W000ParConfig.Database);
      W000ParConfig.LoginEsterno:=IfThen(chkIALoginEsterno.Checked,'S','N');
      IniB110.WriteString('Default',INI_ID_LOGIN_ESTERNO,W000ParConfig.LoginEsterno);
    finally
      FreeAndNil(IniB110);
    end;
    // sezione impostazioni operative
    W000ParConfig.Azienda:=Trim(edtIAAzienda.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_AZIENDA,W000ParConfig.Azienda);

    W000ParConfig.Profilo:=Trim(edtIAProfilo.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_PROFILO,W000ParConfig.Profilo);

    Valore:=Trim(edtIAMaxSessioni.Text);
    if not TryStrToInt(Valore,W000ParConfig.MaxSessioni) then
      raise Exception.Create('Il numero massimo di sessioni indicato non è valido.'#13#10'Indicare un valore intero compreso fra 0 e 9999');
    IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_MAX_SESSIONI,W000ParConfig.MaxSessioni);

    W000ParConfig.UrlSuperoMaxSessioni:=Trim(edtIAUrlSuperoMaxSessioni.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,W000ParConfig.UrlSuperoMaxSessioni);

    Valore:=Trim(edtIATimeOut.Text);
    if not TryStrToInt(Valore,W000ParConfig.TimeoutDip) then
      raise Exception.Create('Il valore del timeout non è valido.'#13#10'Indicare un valore intero compreso fra 1 e 999');
    IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_DIP,W000ParConfig.TimeoutDip);

    W000ParConfig.Home:=Trim(edtIAHome.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,W000ParConfig.Home);

    W000ParConfig.UrlLoginErrato:=Trim(edtIAUrlLoginErrato.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_LOGINERR,W000ParConfig.UrlLoginErrato);

    W000ParConfig.UrlManutenzione:=Trim(edtIAURLManutenzione.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_MANUTENZIONE,W000ParConfig.UrlManutenzione);

    W000ParConfig.RegistraCredenziali:=IfThen(chkIARegistraCredenziali.Checked,'S','N');
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_REG_CREDENZIALI,W000ParConfig.RegistraCredenziali);

    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_RECUPERO_PASSWORD, IfThen(chkIARecuperoPassword.Checked,'S','N'));

    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_STATO_AZIENDA, cmbIAStatoAzienda.Text);

    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_STATO_PROFILO, cmbIAStatoProfilo.Text);

    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_TITOLO_IRISAPP, edtIATitolo.Text);

    if not TryStrToInt(Trim(edtIAMaxRequests.Text), ValoreInt) then
      raise Exception.Create('Il valore del parametro MaxRequests indicato non è valido.'#13#10'Indicare un valore intero compreso fra 0 e 9999');
    IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_MAX_REQUESTS, ValoreInt);

    if edtIAPaginaIniziale.Visible then
    begin
      W000ParConfig.PaginaIniziale:=Trim(edtIAPaginaIniziale.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_STARTPAGE,W000ParConfig.PaginaIniziale);
    end;

    W000ParConfig.Url_Base:=edtIAUrlBase.Text;
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE,W000ParConfig.Url_Base);

    if R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','') <> Trim(edtIAMainDir.Text) then
      R180PutRegistro(HKEY_LOCAL_MACHINE,'','HOME',Trim(edtIAMainDir.Text));

    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URLRECAPTCHA, edtIAUrlRECAPTCHA.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_SITEKEYRECAPTCHA, edtIASiteKeyRECAPTCHA.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_SECRETKEYRECAPTCHA, edtIASecretKeyRECAPTCHA.Text);

    //[ImpostazioniSistema]
    W000ParConfig.Url_Base:=edtIAUrlBase.Text;
    IniFile.WriteString(INI_SEZ_IMPOST_SIST,INI_ID_B110PROTOCOLLO,IfThen(chkIAB110Protocollo.Checked,'https','http'));
    IniFile.WriteString(INI_SEZ_IMPOST_SIST,INI_ID_B110PORT,edtIAB110Port.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_SIST,INI_ID_B110HOST,edtIAB110Host.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_SIST,INI_ID_B110URL,edtIAB110Url.Text);

    //[UGExceptionLogger]
    IniFile.WriteString(INI_SEZ_IMPOST_UG_LOG,INI_UGEL_INDY,IfThen(chkUGExceptionIndy.Checked,'S','N'));
    IniFile.WriteString(INI_SEZ_IMPOST_UG_LOG,INI_UGEL_INDYSSL,IfThen(chkUGExceptionIndySSL.Checked,'S','N'));
    IniFile.WriteString(INI_SEZ_IMPOST_UG_LOG,INI_UGEL_SESSION,IfThen(chkUGExceptionSession.Checked,'S','N'));
  end;
  procedure SetConfigWeb;
  var i:Integer;
      Valore, ComInit:String;
      StringList:TStringList;
  begin
    // sezione impostazioni operative
    W000ParConfig.Database:=Trim(cmbDatabase.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_DATABASE,W000ParConfig.Database);

    W000ParConfig.Azienda:=Trim(edtAziendaDefault.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_AZIENDA,W000ParConfig.Azienda);

    if edtProfiloDefault.Visible then
    begin
      W000ParConfig.Profilo:=Trim(edtProfiloDefault.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_PROFILO,W000ParConfig.Profilo);
    end;

    if edtMaxSessioni.Visible then
    begin
      Valore:=Trim(edtMaxSessioni.Text);
      if not TryStrToInt(Valore,W000ParConfig.MaxSessioni) then
        raise Exception.Create('Il numero massimo di sessioni web indicato non è valido.'#13#10'Indicare un valore intero compreso fra 0 e 9999');
      IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_MAX_SESSIONI,W000ParConfig.MaxSessioni);
    end;

    if edtUrlSuperoMaxSessioni.Visible then
    begin
      W000ParConfig.UrlSuperoMaxSessioni:=Trim(edtUrlSuperoMaxSessioni.Text);
      if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
        IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS_RILPRE,W000ParConfig.UrlSuperoMaxSessioni)
      else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
        IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS_PAGHE,W000ParConfig.UrlSuperoMaxSessioni)
      else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
        IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS_STAGIU,W000ParConfig.UrlSuperoMaxSessioni)
      else
        IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,W000ParConfig.UrlSuperoMaxSessioni);
    end;

    if edtTOOperatore.Visible then
    begin
      Valore:=Trim(edtTOOperatore.Text);
      if not TryStrToInt(Valore,W000ParConfig.TimeoutOper) then
        raise Exception.Create('Il valore del timeout operatore non è valido.'#13#10'Indicare un valore intero compreso fra 1 e 9999');
      IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_OPER,W000ParConfig.TimeoutOper);
    end;

    if edtTODipendente.Visible then
    begin
      Valore:=Trim(edtTODipendente.Text);
      if not TryStrToInt(Valore,W000ParConfig.TimeoutDip) then
        raise Exception.Create('Il valore del timeout dipendente non è valido.'#13#10'Indicare un valore intero compreso fra 1 e 99');
      IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_DIP,W000ParConfig.TimeoutDip);
    end;

    W000ParConfig.Home:=Trim(edtHome.Text);
    if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_HOME_RILPRE,W000ParConfig.Home)
    else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_HOME_PAGHE,W000ParConfig.Home)
    else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_HOME_STAGIU,W000ParConfig.Home)
    else
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,W000ParConfig.Home);

    W000ParConfig.UrlLoginErrato:=Trim(edtUrlLoginErrato.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_LOGINERR,W000ParConfig.UrlLoginErrato);

    //W000ParConfig.PathLog:=Trim(edtPathLog.Text);
    //IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_PATH_LOG,W000ParConfig.PathLog);

    if edtUrlWsAuth.Visible then
    begin
      W000ParConfig.UrlWSAutenticazione:=Trim(edtUrlWsAuth.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_WS_AUT,W000ParConfig.UrlWSAutenticazione);
    end;

    W000ParConfig.UrlManutenzione:=Trim(edtURLMan.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_MANUTENZIONE,W000ParConfig.UrlManutenzione);

    if edtUrlIrisWebCloud.Visible then
    begin
      W000ParConfig.UrlIrisWebCloud:=Trim(edtUrlIrisWebCloud.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_IRISWEBCLOUD,W000ParConfig.UrlIrisWebCloud);
    end;

    if chkIrisWebCloudNewTab.Visible then
    begin
      W000ParConfig.IrisWebCloudNewTab:=IfThen(chkIrisWebCloudNewTab.Checked,'S','N');
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_IRISWEBCLOUD_NEWTAB,W000ParConfig.IrisWebCloudNewTab);
    end;

    if edtUrlWebApp.Visible then
    begin
      W000ParConfig.UrlWebApp:=Trim(edtUrlWebApp.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_WEBAPP,W000ParConfig.UrlWebApp);
    end;

    if chkLoginEsterno.Visible then
    begin
      W000ParConfig.LoginEsterno:=IfThen(chkLoginEsterno.Checked,'S','N');
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_LOGIN_ESTERNO,W000ParConfig.LoginEsterno);
    end;

    if edtPaginaIniziale.Visible then
    begin
      W000ParConfig.PaginaIniziale:=Trim(edtPaginaIniziale.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_STARTPAGE,W000ParConfig.PaginaIniziale);
    end;

    if edtPaginaSingola.Visible then
    begin
      W000ParConfig.PaginaSingola:=Trim(edtPaginaSingola.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_SINGLEPAGE,W000ParConfig.PaginaSingola);
    end;

    W000ParConfig.CampiInvisibili:=lstCampiInvisibili.Items.CommaText;
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_CAMPI_INVISIBILI,W000ParConfig.CampiInvisibili);

    if edtTabColPartenza.Visible then
    begin
      W000ParConfig.TabColPartenza:=edtTabColPartenza.Text;
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_TAB_COL_PARTENZA,W000ParConfig.TabColPartenza);
    end;

    if edtNumLivelli.Visible then
    begin
      Valore:=Trim(edtNumLivelli.Text);
      if not TryStrToInt(Valore,W000ParConfig.NumLivelli) then
        raise Exception.Create('Il numero di livelli indicato non è valido.'#13#10'Indicare un valore intero compreso fra 0 e 999');
      IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_NUM_LIVELLI,W000ParConfig.NumLivelli);
    end;

    // gc: 11/09/19  (Tipo Installazione e URL di base)
    if rgpTipoInstallazione.Visible then
    begin
      W000ParConfig.Tipo_Installazione:=IfThen(rgpTipoInstallazione.ItemIndex = 0,'IIS','SRV');
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_TIPO_INSTALLAZIONE,W000ParConfig.Tipo_Installazione);
    end;
    if edtUrlBaseINI.Visible then
    begin
      W000ParConfig.Url_Base:=Trim(edtUrlBaseINI.Text);
      if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
        IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE_RILPRE,W000ParConfig.Url_Base)
      else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
        IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE_PAGHE,W000ParConfig.Url_Base)
      else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
        IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE_STAGIU,W000ParConfig.Url_Base)
      else
        IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_BASE,W000ParConfig.Url_Base);
    end;
    // gestione parametri ReCAPTCHA
    if grpReCAPTCHA.Visible then
    begin
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URLRECAPTCHA, edtUrlRECAPTCHA.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_SITEKEYRECAPTCHA, edtSiteKeyRECAPTCHA.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_SECRETKEYRECAPTCHA, edtSecretKeyRECAPTCHA.Text);
    end;

    // sezione impostazioni di sistema
    Valore:=Trim(edtPort.Text);
    if not TryStrToInt(Valore,W000ParConfig.Port) then
      raise Exception.Create('Il numero di porta indicato non è valido.'#13#10'Indicare un valore intero.');
    if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT_RILPRE,W000ParConfig.Port)
    else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT_PAGHE,W000ParConfig.Port)
    else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT_STAGIU,W000ParConfig.Port)
    else
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT,W000ParConfig.Port);

    if edtCursoriLogin.Visible then
    begin
      Valore:=Trim(edtCursoriLogin.Text);
      if not TryStrToInt(Valore,W000ParConfig.CursoriLogin) then
        raise Exception.Create('Il numero di cursori per il login indicato non è valido.'#13#10'Indicare un valore intero.');
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_LOGIN,W000ParConfig.CursoriLogin);
    end;

    if edtCursoriSessione.Visible then
    begin
      Valore:=Trim(edtCursoriSessione.Text);
      if not TryStrToInt(Valore,W000ParConfig.CursoriSessione) then
        raise Exception.Create('Il numero di cursori per sessione indicato non è valido.'#13#10'Indicare un valore intero.');
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_SESSIONE,W000ParConfig.CursoriSessione);
    end;

    if edtMaxOpenCursors.Visible then
    begin
      Valore:=Trim(edtMaxOpenCursors.Text);
      if not TryStrToInt(Valore,W000ParConfig.MaxOpenCursors) then
        raise Exception.Create('Il numero massimo di open cursor indicato non è valido.'#13#10'Indicare un valore intero.');
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_OPEN_CURSORS,W000ParConfig.MaxOpenCursors);
    end;

    Valore:=Trim(edtMaxProcessMemory.Text);
    if not TryStrToInt(Valore,W000ParConfig.MaxWorkingMemMb) then
      raise Exception.Create('La memoria massima per il processo indicata non è valida.'#13#10'Indicare 0 per disabilitare il controllo'#13#10'oppure un valore maggiore di 0.');
    IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_WORKING_MEMORY,W000ParConfig.MaxWorkingMemMb);

    // log abilitati
    W000ParConfig.LogAbilitati:=IfThen(chkErrore.Checked,INI_LOG_ERRORE + ',') +
                                IfThen(chkMemoria.Checked,INI_LOG_MEMORIA + ',') +
                                IfThen(chkSessione.Checked,INI_LOG_SESSIONE + ',') +
                                IfThen(chkAccesso.Checked,INI_LOG_ACCESSO + ',') +
                                IfThen(chkTraccia.Checked,INI_LOG_TRACCIA + ',');
    if Length(W000ParConfig.LogAbilitati) > 0 then
      W000ParConfig.LogAbilitati:=Copy(W000ParConfig.LogAbilitati,1,Length(W000ParConfig.LogAbilitati) - 1);
    IniFile.WriteString(INI_SEZ_IMPOST_SIST,INI_ID_LOG_ABILITATI,W000ParConfig.LogAbilitati);

    // parametri avanzati
    W000ParConfig.ParametriAvanzati:=R180GetCheckList(50,chkParametriAvanzati);
    case rgpCom.ItemIndex of
      0: ComInit:='';
      1: ComInit:=',' + INI_COM_NONE;
      2: ComInit:=',' + INI_COM_NORMAL;
      3: ComInit:=',' + INI_COM_MULTI;
    end;
    W000ParConfig.ParametriAvanzati:=W000ParConfig.ParametriAvanzati + ComInit;
    IniFile.WriteString(INI_SEZ_IMPOST_SIST,INI_ID_PARAMETRI_AVANZATI,W000ParConfig.ParametriAvanzati);

    if R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','') <> Trim(edtMainDir.Text) then
      R180PutRegistro(HKEY_LOCAL_MACHINE,'','HOME',Trim(edtMainDir.Text));

    // sezione impostazioni server IIS
    IniFile.WriteString(INI_SEZ_IMPOST_IIS,INI_IIS_DLL_PATH,edtDLLPath.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_IIS,INI_IIS_DEFAULT_PAGE,IfThen(chkOverrideDefaultPage.Checked,'S','N'));
    if URLRewriteInstallato then
    begin
      IniFile.WriteString(INI_SEZ_IMPOST_IIS,INI_IIS_HTTPS_ONLY,IfThen(chkHttps.Checked,'S','N'));
      IniFile.WriteString(INI_SEZ_IMPOST_IIS,INI_IIS_IN_MANUTENZIONE,IfThen(chkPaginaManutenzione.Checked,'S','N'));
      IniFile.WriteString(INI_SEZ_IMPOST_IIS,INI_IIS_MONITOR_PRIVATI,IfThen(chkMonitorPrivati.Checked,'S','N'));
      IniFile.WriteString(INI_SEZ_IMPOST_IIS,INI_IIS_DOMINIO_COOKIE,IfThen(chkForzaDominioCookie.Checked,'S','N'));
    end;
    IniFile.WriteString(INI_SEZ_IMPOST_IIS,INI_IIS_HIDDEN_DIRECORY,lstDirectoryPrivate.Items.CommaText);
    StringList:=TStringList.Create;
    try
      StringList.CaseSensitive:=False;
      StringList.Sorted:=True;
      stringList.Duplicates:=TDuplicates.dupIgnore;
      StringList.StrictDelimiter:=True;
      for i:=0 to (cblPagineErrore.Items.Count - 1) do
      begin
        if cblPagineErrore.Checked[i] then
          StringList.Add(cblPagineErrore.Items[i]);
        end;
      IniFile.WriteString(INI_SEZ_IMPOST_IIS,INI_IIS_CUSTOM_ERROR,StringList.DelimitedText);
    finally
        FreeAndNil(StringList);
    end;

    // IW Exception logger
    if grpExceptionLogger.Visible then
    begin
      IniFile.WriteString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ABILITATO,
                          IfThen(chkEnableExcLog.Checked,'S','N'));
      IniFile.WriteString(INI_SEZ_IMPOST_IW_LOG,INI_EL_PATH_FILE_LOG,Trim(edtELPathFile.Text));
      IniFile.WriteString(INI_SEZ_IMPOST_IW_LOG,INI_EL_NOME_FILE_LOG,Trim(edtELNomeFile.Text));
      IniFile.WriteInteger(INI_SEZ_IMPOST_IW_LOG,INI_EL_GIORNI_RIMOZIONE,edtELNumGiorniPurge.Value);
      StringList:=TStringList.Create;
      try
        StringList.CaseSensitive:=False;
        StringList.Sorted:=True;
        StringList.Duplicates:=TDuplicates.dupIgnore;
        StringList.StrictDelimiter:=True;
        StringList.DelimitedText:=Trim(edtELEccCustom.Text);
        for i:=0 to (chkELEccPredefinite.Items.Count - 1) do
        begin
          if chkELEccPredefinite.Checked[i] then
            StringList.Add(chkELEccPredefinite.Items[i]);
        end;
        IniFile.WriteString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ECCEZ_IGNORATE,StringList.DelimitedText);
      finally
        FreeAndNil(StringList);
      end;
    end;
  end;
begin
  if rgpApplicativo.ItemIndex = ItemIrisWeb then
    NomeFileConfig:=FILE_CONFIG_IRISWEB
  else if R180In(rgpApplicativo.ItemIndex,[ItemIrisCloudRilpre,ItemIrisCloudPaghe,ItemIrisCloudStagiu]) then
    NomeFileConfig:=FILE_CONFIG_IRISCLOUD
  else if rgpApplicativo.ItemIndex = ItemIrisApp then
    NomeFileConfig:=FILE_CONFIG_IRISAPP
  else if rgpApplicativo.ItemIndex = ItemX001 then
    NomeFileConfig:=FILE_CONFIG_X001;
  IniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName) + NomeFileConfig);
  try
    if rgpApplicativo.ItemIndex = ItemIrisApp then
      SetConfigApp
    else
      SetConfigWeb;
  finally
    FreeAndNil(IniFile);
  end;
end;

// 9.1 - eliminata gestione su registro.fine

procedure TB000FConfigWebServer.AttivaCampiParametri(Attiva: Boolean);
begin
  rgpApplicativo.Enabled:=not Attiva;

  if rgpApplicativo.ItemIndex = ItemIrisApp then
  begin
    cmbIADatabase.Enabled:=Attiva;
    edtIAAzienda.ReadOnly:=not Attiva;
    cmbIAStatoAzienda.Enabled:=Attiva;
    edtIAProfilo.ReadOnly:=not Attiva;
    cmbIAStatoProfilo.Enabled:=Attiva;
    edtIAMaxSessioni.ReadOnly:=not Attiva;
    edtIAMaxRequests.ReadOnly:=not Attiva;
    edtIAUrlSuperoMaxSessioni.ReadOnly:=not Attiva;
    edtIATimeOut.ReadOnly:=not Attiva;
    edtIATitolo.ReadOnly:=not Attiva;
    edtIAHome.ReadOnly:=not Attiva;
    edtIAURLLoginErrato.ReadOnly:=not Attiva;
    edtIAURLManutenzione.ReadOnly:=not Attiva;
    chkIALoginEsterno.Enabled:=Attiva;
    edtIAPaginaIniziale.ReadOnly:=not Attiva;
    chkIARegistraCredenziali.Enabled:=Attiva;
    chkIARecuperoPassword.Enabled:=Attiva;
    edtIAUrlBase.ReadOnly:=not Attiva;
    edtIAUrlRECAPTCHA.ReadOnly:=not Attiva;
    edtIASiteKeyRECAPTCHA.ReadOnly:=not Attiva;
    edtIASecretKeyRECAPTCHA.ReadOnly:=not Attiva;

    //impostazioni di sistema
    chkIAB110Protocollo.Enabled:=Attiva;
    edtIAB110Host.ReadOnly:=not Attiva;
    edtIAB110Port.ReadOnly:=not Attiva;
    edtIAB110Url.ReadOnly:=not Attiva;

    chkUGExceptionIndy.Enabled:=Attiva;
    chkUGExceptionIndySSL.Enabled:=Attiva;
    chkUGExceptionSession.Enabled:=Attiva;

    edtIAMainDir.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','');
  end
  else
  begin
    // impostazioni operative
    cmbDatabase.Enabled:=Attiva;
    edtAziendaDefault.ReadOnly:=not Attiva;
    edtProfiloDefault.ReadOnly:=not Attiva;
    edtMaxSessioni.ReadOnly:=not Attiva;
    edtUrlSuperoMaxSessioni.ReadOnly:=not Attiva;
    edtTOOperatore.ReadOnly:=not Attiva;
    edtTODipendente.ReadOnly:=not Attiva;
    edtHome.ReadOnly:=not Attiva;
    edtUrlLoginErrato.ReadOnly:=not Attiva;
    //edtPathLog.ReadOnly:=not Attiva;
    edtUrlWsAuth.ReadOnly:=not Attiva;
    edtURLMan.ReadOnly:=not Attiva;
    edtUrlIrisWebCloud.ReadOnly:=not Attiva;
    chkIrisWebCloudNewTab.Enabled:=Attiva;
    edtUrlWebApp.ReadOnly:=not Attiva;
    chkLoginEsterno.Enabled:=Attiva;
    edtTabColPartenza.ReadOnly:=not Attiva;
    edtNumLivelli.ReadOnly:=not Attiva;
    edtPaginaIniziale.ReadOnly:=not Attiva;
    edtPaginaSingola.ReadOnly:=not Attiva;
    edtMainDir.ReadOnly:=not Attiva;
    rgpTipoInstallazione.Enabled:= Attiva;  // gc: 11/09/19
    edtUrlBaseINI.ReadOnly:=not Attiva;  // gc: 11/09/2019
    edtUrlRECAPTCHA.ReadOnly:=not Attiva;
    edtSiteKeyRECAPTCHA.ReadOnly:=not Attiva;
    edtSecretKeyRECAPTCHA.ReadOnly:=not Attiva;

    // impostazioni di sistema
    edtPort.ReadOnly:=not Attiva;
    edtCursoriLogin.ReadOnly:=not Attiva;
    edtCursoriSessione.ReadOnly:=not Attiva;
    edtMaxOpenCursors.ReadOnly:=not Attiva;
    edtMaxProcessMemory.ReadOnly:=not Attiva;

    // campi da non visualizzare
    cmbPagina.Enabled:=Attiva;
    cmbComponente.Enabled:=Attiva;
    btnAggiungiCI.Enabled:=Attiva;
    lstCampiInvisibili.Enabled:=Attiva;

    // log abilitati
    chkErrore.Enabled:=Attiva;
    chkMemoria.Enabled:=Attiva;
    chkSessione.Enabled:=Attiva;
    chkAccesso.Enabled:=Attiva;
    chkTraccia.Enabled:=Attiva;

    // parametri avanzati
    chkParametriAvanzati.Enabled:=Attiva;
    rgpCom.Enabled:=Attiva;

    // Configurazione IIS
    edtDLLPath.Enabled:=Attiva;
    bntSelezionaDLL.Enabled:=Attiva;
    chkOverrideDefaultPage.Enabled:=Attiva;
    if URLRewriteInstallato then
    begin
      chkHttps.Enabled:=Attiva;
      chkPaginaManutenzione.Enabled:=Attiva;
      chkMonitorPrivati.Enabled:=Attiva;
      chkForzaDominioCookie.Enabled:=Attiva;
    end;
    cblPagineErrore.Enabled:=Attiva;
    lstDirectoryPrivate.Enabled:=Attiva;
    btnAggiungiHiddenSegments.Enabled:=Attiva;
    btnRimuoviHiddenSegments.Enabled:=Attiva;

    // altro - exception logger
    chkEnableExcLog.Enabled:=Attiva;
    lblELPathFile.Enabled:=Attiva and chkEnableExcLog.Checked;
    edtELPathFile.Enabled:=Attiva and chkEnableExcLog.Checked;
    lblELNomeFile.Enabled:=Attiva and chkEnableExcLog.Checked;
    edtELNomeFile.Enabled:=Attiva and chkEnableExcLog.Checked;
    lblELPurge1.Enabled:=Attiva and chkEnableExcLog.Checked;
    lblELPurge2.Enabled:=Attiva and chkEnableExcLog.Checked;
    edtELNumGiorniPurge.Enabled:=Attiva and chkEnableExcLog.Checked;
    memELHelp.Enabled:=Attiva and chkEnableExcLog.Checked;
    grpELEcc.Enabled:=Attiva and chkEnableExcLog.Checked;
    lblELEccPredefinite.Enabled:=Attiva and chkEnableExcLog.Checked;
    chkELEccPredefinite.Enabled:=Attiva and chkEnableExcLog.Checked;
    lblELEccCustom.Enabled:=Attiva and chkEnableExcLog.Checked;
    edtELEccCustom.Enabled:=Attiva and chkEnableExcLog.Checked;
  end;
end;

procedure TB000FConfigWebServer.btnModificaClick(Sender: TObject);
begin
  InModifica:=True;
  btnModifica.Enabled:=False;
  btnModifica2.Enabled:=False;
  btnModifica3.Enabled:=False;
  btnAnnulla.Enabled:=True;
  btnAnnulla2.Enabled:=True;
  btnAnnulla3.Enabled:=True;
  btnSalva.Enabled:=True;
  btnSalva2.Enabled:=True;
  btnSalva3.Enabled:=True;
  AttivaCampiParametri(True);
end;

procedure TB000FConfigWebServer.btnAnnullaClick(Sender: TObject);
begin
  InModifica:=False;
  btnModifica.Enabled:=True;
  btnModifica2.Enabled:=True;
  btnModifica3.Enabled:=True;
  btnAnnulla.Enabled:=False;
  btnAnnulla2.Enabled:=False;
  btnAnnulla3.Enabled:=False;
  btnSalva.Enabled:=False;
  btnSalva2.Enabled:=False;
  btnSalva3.Enabled:=False;
  AttivaCampiParametri(False);
  GetConfigurazione;
end;

procedure TB000FConfigWebServer.btnClearMemoClick(Sender: TObject);
begin
  memRisultato.Clear;
end;

procedure TB000FConfigWebServer.chkEnableExcLogClick(Sender: TObject);
begin
  AttivaCampiParametri(InModifica);
end;

procedure TB000FConfigWebServer.chkFiltroErroreClick(Sender: TObject);
begin
  FiltroMsg:='';
  if chkFiltroErrore.Checked then
    FiltroMsg:='(MSG = ''<Er>*'')';
  if chkFiltroSessione.Checked then
    FiltroMsg:=IfThen(FiltroMsg <> '',FiltroMsg + ' or ') + '(MSG = ''<Se>*'')';
  if chkFiltroAccesso.Checked then
    FiltroMsg:=IfThen(FiltroMsg <> '',FiltroMsg + ' or ') + '(MSG = ''<Ac>*'')';
  if chkFiltroTraccia.Checked then
    FiltroMsg:=IfThen(FiltroMsg <> '',FiltroMsg + ' or ') + '(MSG = ''<Tr>*'')';
  if chkFiltroMemoria.Checked then
    FiltroMsg:=IfThen(FiltroMsg <> '',FiltroMsg + ' or ') + '(MSG = ''<Me>*'')';

  if B000FConfigWebServerDM.selMsgDett.Active then
  begin
    B000FConfigWebServerDM.selMsgDett.Filtered:=False;
    B000FConfigWebServerDM.selMsgDett.Filter:=FiltroMsg;
    B000FConfigWebServerDM.selMsgDett.Filtered:=(FiltroMsg <> '');
  end;
end;

procedure TB000FConfigWebServer.chkIAB110ProtocolloClick(Sender: TObject);
begin
  SetIrisAPPUrlTest;
end;

procedure TB000FConfigWebServer.cmbAzioniChange(Sender: TObject);
begin
  if cmbAzioni.ItemIndex < 0 then
    lblDescrizioneAzione.Caption:=''
  else
    lblDescrizioneAzione.Caption:=A000AzioniSitoWeb[cmbAzioni.ItemIndex].Descrizione;
end;

procedure TB000FConfigWebServer.cmbPaginaChange(Sender: TObject);
var
  i: Integer;
  CompList: TStringList;
begin
  cmbComponente.Clear;
  if cmbPagina.ItemIndex < 0 then
    Exit;

  CompList:=TStringList.Create;
  try
    if rgpApplicativo.ItemIndex = ItemIrisWeb then
      CompList.CommaText:=ElementiIrisWEB[cmbPagina.ItemIndex].Elementi
    else
      CompList.CommaText:=ElementiIrisCloud[cmbPagina.ItemIndex].Elementi;
    cmbComponente.Items.BeginUpdate;
    for i:=0 to CompList.Count - 1 do
      cmbComponente.Items.Add(CompList[i]);
    cmbComponente.Items.EndUpdate;
  finally
    FreeAndNil(CompList);
  end;
end;

procedure TB000FConfigWebServer.cmbURLDataBaseChange(Sender: TObject);
begin
  ViewURL;
end;

procedure TB000FConfigWebServer.bntSelezionaDLLClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
  try
    if DirectoryExists(edtPathBase.Text) then
      InitialDir:=edtPathBase.Text
    else
      InitialDir:='';
    FileName:='';
    Filter:='DLL - Dynamic-Link Library|*.dll';
    if Execute then
      edtDLLPath.Text:=FileName;
  finally
    Free;
  end;
end;

procedure TB000FConfigWebServer.btnAggiungiCIClick(Sender: TObject);
var
  S,SUp: String;
  i: Integer;
  Found: Boolean;
begin
  if cmbComponente.Text <> '' then
  begin
    S:=IfThen(trim(cmbPagina.Text) <> '',trim(cmbPagina.Text) + '.','') + trim(cmbComponente.Text);
    SUp:=UpperCase(S);
    Found:=False;
    for i:=0 to lstCampiInvisibili.Count - 1 do
      if UpperCase(lstCampiInvisibili.Items[i]) = SUp then
      begin
        Found:=True;
        break;
      end;
    if not Found then
      lstCampiInvisibili.Items.Add(S);
  end
  else
    beep;
end;

procedure TB000FConfigWebServer.btnAggiungiHiddenSegmentsClick(Sender: TObject);
var
  Selezione:String;
begin
  with TFileOpenDialog.Create(nil) do
  try
    if edtDLLPath.Text = '' then
      DefaultFolder:=ExtractFilePath(Application.Exename)
    else
      DefaultFolder:=ExtractFilePath(edtDLLPath.Text);
    Options:=[fdoPickFolders];
    if Execute then
    begin
      Selezione:=ExtractRelativePath(DefaultFolder, FileName);
      if lstDirectoryPrivate.Items.IndexOf(Selezione) = -1 then
        lstDirectoryPrivate.Items.Add(Selezione)
      else
        R180MessageBox('Elemento già presente!',ESCLAMA);
    end;
  finally
    Free;
  end;
end;

procedure TB000FConfigWebServer.btnRimuoviHiddenSegmentsClick(Sender: TObject);
var i:Integer;
begin
  i:=lstDirectoryPrivate.ItemIndex;
  if i >= 0 then
  begin
    lstDirectoryPrivate.Items.Delete(i);
  end;
  if lstDirectoryPrivate.Items.Count = i then
    lstDirectoryPrivate.ItemIndex:=i - 1
  else if lstDirectoryPrivate.Items.Count >= i then
    lstDirectoryPrivate.ItemIndex:=i;
end;

procedure TB000FConfigWebServer.AddToMemo(var PMemo: TMemo; const PLine: String);
var
  LLine, Ora, Sep: String;
begin
  Ora:=FormatDateTime('hhhh.mm.ss',Now);
  Sep:=' - ';
  if PLine.Contains(#13#10) then
    LLine:=StringReplace(PLine,#13#10,#13#10 + StringOfChar(' ',Length(Ora) + Length(Sep)),[rfReplaceAll])
  else
    LLine:=PLine;
  PMemo.Lines.Add(Format('%s%s%s',[Ora,Sep,LLine]));
  PMemo.Repaint;
end;

procedure TB000FConfigWebServer.btnEseguiAzioneClick(Sender: TObject);
var
  Comando, NomeSrv, Url, Html: String;
begin
  memRisultato.Clear;
  if cmbAzioni.ItemIndex < 0 then
  begin
    R180MessageBox('Selezionare un''azione da eseguire',INFORMA);
  end
  else
  begin
    cmbAzioni.Enabled:=False;
    btnEseguiAzione.Enabled:=False;

    AddToMemo(memRisultato,Format('%s: attendere...',[cmbAzioni.Text]));

    // determina eventuale comando
    Comando:=A000AzioniSitoWeb[cmbAzioni.ItemIndex].Comando;
    if Copy(Comando,1,1) = '#' then
    begin
      // 1. azioni personalizzate
      //    #1 = riavvio sito
      //    #2 = arresto sito
      //    #3 = avvio sito
      try
        case rgpTipoInstallazione.ItemIndex of
          0: begin
               // IIS
               if (Comando = '#01') or (Comando = '#02') then
               begin
                 // riavvio oppure arresto
                 AddToMemo(memRisultato,'Arresto di IIS con iisreset...');
                 //ExecuteAndWait('cmd.exe /C iisreset -stop');
                 R180SyncProcessExec('cmd.exe','','/C iisreset -stop',nil);
               end;
               if (Comando = '#01') or (Comando = '#03') then
               begin
                 // riavvio oppure avvio
                 AddToMemo(memRisultato,'Avvio di IIS con iisreset...');
                 //ExecuteAndWait('cmd.exe /C iisreset -start');
                 R180SyncProcessExec('cmd.exe','','/C iisreset -start',nil);
               end;
             end;
          1: begin
               // Windows service
               if rgpApplicativo.ItemIndex = ItemIrisWeb then
                 NomeSrv:=ITEM_SRV_NAME_IRISWEB
               else if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
                 NomeSrv:=ITEM_SRV_NAME_IRISCLOUD_RILPRE
               else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
                 NomeSrv:=ITEM_SRV_NAME_IRISCLOUD_PAGHE
               else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
                 NomeSrv:=ITEM_SRV_NAME_IRISCLOUD_STAGIU
               else if rgpApplicativo.ItemIndex = ItemX001 then
                 NomeSrv:=ITEM_SRV_NAME_X001;

               if (Comando = '#01') or (Comando = '#02') then
               begin
                 // riavvio oppure arresto
                 AddToMemo(memRisultato,Format('Arresto del servizio %s in corso...',[NomeSrv]));
                 //ExecuteAndWait('cmd.exe /C net stop ' + NomeSrv);
                 R180SyncProcessExec('cmd.exe','','/C net stop ' + NomeSrv,nil);
               end;
               if (Comando = '#01') or (Comando = '#03') then
               begin
                 // riavvio oppure avvio
                 AddToMemo(memRisultato,Format('Avvio del servizio %s in corso...',[NomeSrv]));
                 //ExecuteAndWait('cmd.exe /C net start ' + NomeSrv);
                 R180SyncProcessExec('cmd.exe','','/C net start ' + NomeSrv,nil);
               end;
             end;
        end;
        AddToMemo(memRisultato,Format('%s completato',[cmbAzioni.Text]));
      except
        on E: Exception do
        begin
          AddtoMemo(memRisultato,Format('Errore: %s (%s)',[E.Message,E.ClassName]));
          AddToMemo(memRisultato,Format('%s non completato correttamente',[cmbAzioni.Text]));
        end;
      end;
    end
    else
    begin
      // 2. comandi standard

      // determina url
      Url:=edtUrlBaseINI.Text + Comando;

      AddToMemo(memRisultato,Format('Comando %s',[Copy(Comando,2)]));
      AddToMemo(memRisultato,Url);

      try
        AddToMemo(memRisultato,'...');
        Html:=IdHTTP1.Get(Url);
        AddToMemo(memRisultato,Format('%s eseguito correttamente',[cmbAzioni.Text]));
      except
        on E: Exception do
        begin
          AddtoMemo(memRisultato,Format('Errore: %s (%s)',[E.Message,E.ClassName]));
          AddToMemo(memRisultato,Format('%s non eseguito correttamente',[cmbAzioni.Text]));
        end;
      end;
    end;

    // abilita interfaccia
    cmbAzioni.Enabled:=True;
    btnEseguiAzione.Enabled:=True;
  end;
end;

procedure TB000FConfigWebServer.ApriUrl(const PContesto: String);
begin
  ShellExecute(0,'OPEN',PChar(edtUrlBaseINI.Text + PContesto),'','', SW_SHOWNORMAL);
end;

procedure TB000FConfigWebServer.lblAccessoSitoClick(Sender: TObject);
begin
  ApriUrl('?loginesterno=N');
end;

procedure TB000FConfigWebServer.lnkMonitorSessioniClick(Sender: TObject);
begin
  ApriUrl('/iwmonitor?id=mondoedp');
end;

procedure TB000FConfigWebServer.lnkVisParametriConfigClick(Sender: TObject);
begin
  ApriUrl('/iwconfig?id=mondoedp');
end;

procedure TB000FConfigWebServer.lstCampiInvisibiliDblClick(Sender: TObject);
begin
  if lstCampiInvisibili.ItemIndex > -1 then
    lstCampiInvisibili.DeleteSelected;
end;

procedure TB000FConfigWebServer.lstCampiInvisibiliKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 46) and (lstCampiInvisibili.ItemIndex <> -1) then
    lstCampiInvisibili.DeleteSelected;
end;

procedure TB000FConfigWebServer.mnuFiltraIdSessioneClick(Sender: TObject);
begin
  //
end;

procedure TB000FConfigWebServer.mnuFiltraIPClick(Sender: TObject);
begin
  //
end;

procedure TB000FConfigWebServer.btnMidasRegClick(Sender: TObject);
var
  FN,Par: String;
  Ret: Integer;
  Registra: Boolean;
  function DecodeErr(ErrCode: Integer): String;
  begin
    case Ret of
     0: Result:='not enough memory';
     2: Result:='file not found';
     3: Result:='path not found';
     5: Result:='access denied (Windows 95)';
     8: Result:='not enough memory (Windows 95)';
    10: Result:='wrong Windows version';
    11: Result:='.EXE file is invalid (non-Win32 .EXE or error in .EXE image).';
    12: Result:='application was designed for a different operating system';
    13: Result:='application was designed for MS-DOS 4.0';
    15: Result:='attempt to load a real-mode program';
    16: Result:='attempt to load a second instance of an application with non-readonly data segments';
    19: Result:='attempt to load a compressed application file';
    20: Result:='dynamic-link library (DLL) file failure';
    26: Result:='sharing violation';
    27: Result:='filename association incomplete or invalid';
    28: Result:='DDE request timed out';
    29: Result:='DDE transaction failed';
    30: Result:='DDE busy';
    31: Result:='no application associated with the given filename extension';
    32: Result:='dynamic-link library not found';
    else
      Result:='undocumented';
  end;
  end;
begin
  if (Sender = btnMidasReg) or (Sender = btnMidasUnReg) then
  begin
    // Midas.dll
    FN:='regsvr32';
    Par:=IfThen(Sender = btnMidasReg,ExtractFilePath(Application.Exename) + 'midas.dll','/u ' + ExtractFilePath(Application.Exename) + 'midas.dll');
    if FileExists('midas.dll') then
    begin
      Ret:=ShellExecute(0,'runas',PChar(FN),PChar(Par),nil,SW_NORMAL);
      if R180Between(Ret,0,32) then
        R180MessageBox('L''operazione non è andata a buon fine.' + #13#10 +
                       'Codice di errore ' + IntToStr(Ret) + ': ' + DecodeErr(Ret),ESCLAMA);
    end
    else
      R180MessageBox('Attenzione! Il file midas.dll non è stato trovato.',INFORMA);
  end
  else if (Sender = btnDebenuPDFReg) or (Sender = btnDebenuPDFUnreg) then
  begin
    // DebenuPDFLibrary.dll
    FN:='regsvr32';
    Par:=IfThen(Sender = btnDebenuPDFReg,ExtractFilePath(Application.Exename) + 'DebenuPDFLibrary.dll','/u ' + ExtractFilePath(Application.Exename) + 'DebenuPDFLibrary.dll');
    if FileExists(ExtractFilePath(Application.Exename) + 'DebenuPDFLibrary.dll') then
    begin
      Ret:=ShellExecute(0,'runas',PChar(FN),PChar(Par),nil,SW_NORMAL);
      if R180Between(Ret,0,32) then
        R180MessageBox('L''operazione non è andata a buon fine.' + #13#10 +
                       'Codice di errore ' + IntToStr(Ret) + ': ' + DecodeErr(Ret),ESCLAMA);
    end
    else
      R180MessageBox('Attenzione! Il file DebenuPDFLibrary.dll non è stato trovato.',INFORMA);
  end
  else
  begin
    // componenti per le stampe
    if Sender = btnRegA077PComServer then
      FN:='A077PCOMServer.exe'
    else if Sender = btnRegP077PComServer then
      FN:='P077PCOMServer.exe'
    else if Sender = btnRegP714PCOMServer then
      FN:='P714PCOMServer.exe'
    else if Sender = btnUnRegA077PComServer then
      FN:='A077PCOMServer.exe'
    else if Sender = btnUnRegP077PComServer then
      FN:='P077PCOMServer.exe'
    else if Sender = btnUnRegP714PCOMServer then
      FN:='P714PCOMServer.exe'
    else if Sender = btnRegB028PComServer then
      FN:='B028PPrintServer_COM.exe'
    else if Sender = btnUnRegB028PComServer then
      FN:='B028PPrintServer_COM.exe';
    Registra:=(Sender = btnRegA077PComServer) or
              (Sender = btnRegP077PComServer) or
              (Sender = btnRegP714PCOMServer) or
              (Sender = btnRegB028PCOMServer);
    Par:=IfThen(Registra,'/regserver','/unregserver');
    if FileExists(FN) then
    begin
      Ret:=ShellExecute(0,'runas',PChar(ExtractFilePath(Application.Exename) + FN),PChar(Par),nil,SW_HIDE);
      if R180Between(Ret,0,32) then
        R180MessageBox('L''operazione non è andata a buon fine.' + #13#10 +
                       'Codice di errore ' + IntToStr(Ret) + ': ' + DecodeErr(Ret),ESCLAMA)
      else
      begin
        if Registra then
          R180MessageBox('Il componente ' + FN + ' è stato registrato.',INFORMA)
        else
          R180MessageBox('La registrazione del componente ' + FN + ' è stata annullata.' + #13#10 +
                         'Potrebbe essere necessario eseguire una nuova registrazione.',INFORMA);
      end
    end
    else
      R180MessageBox('Attenzione! Il file ' + FN + ' non è stato trovato.',INFORMA);
  end;
end;

procedure TB000FConfigWebServer.ViewURL;
var
  UrlPar: String;
  procedure AddPar(const Nome, Valore: String);
  var
    LVal: String;
  begin
    LVal:=Trim(Valore);
    if LVal <> '' then
      UrlPar:=UrlPar + IfThen(UrlPar = '','?','&') + Format('%s=%s',[Nome,LVal])
  end;
begin
  if (edtUrlAzienda.Text = '') or ((edtUrlAzienda.Text <> '') and ((edtUrlUtente.Text = '') and (edtUrlPassword.Text <> ''))) then
    edtURLGenerato.Text:=''
  else
  begin
    edtUrlBase.Text:=edtUrlBaseINI.Text;
    UrlPar:='';
    AddPar('azienda',edtUrlAzienda.Text);
    AddPar('usr',edtUrlUtente.Text);
    AddPar('pwd',edtUrlPassword.Text);
    AddPar('profilo',edtUrlProfilo.Text);
    AddPar('database',cmbUrlDatabase.Text);
    AddPar('home',edtUrlHome.Text);
    edtURLGenerato.Text:=edtUrlBaseINI.Text + UrlPar;
  end;
end;

procedure TB000FConfigWebServer.edtIAB110HostChange(Sender: TObject);
begin
  SetIrisAPPUrlTest;
end;

procedure TB000FConfigWebServer.edtUrlAziendaChange(Sender: TObject);
begin
  ViewURL;
end;

procedure TB000FConfigWebServer.edtUrlBaseINIChange(Sender: TObject);
begin
  ViewURL;
end;

procedure TB000FConfigWebServer.btnSalvaClick(Sender: TObject);
begin
  SetConfigurazione;

  AttivaCampiParametri(False);
  InModifica:=False;
  btnModifica.Enabled:=True;
  btnModifica2.Enabled:=True;
  btnModifica3.Enabled:=True;
  btnAnnulla.Enabled:=False;
  btnAnnulla2.Enabled:=False;
  btnAnnulla3.Enabled:=False;
  btnSalva.Enabled:=False;
  btnSalva2.Enabled:=False;
  btnSalva3.Enabled:=False;
end;

procedure TB000FConfigWebServer.btnSalvaWebConfigClick(Sender: TObject);
var
  Template,Segments,ErrorPages1,ErrorPages2,FileContent:String;
  I,Preference:Integer;
  CustomErrorPage:Boolean;
const
  CUSTOM_CONFIG_FILE      = 'web.config';
  CUSTOM_CONFIG_FILE_SIGN = 'MONDO_EDP_WEBCONFIG';
begin

  if lblVirtualPathValue.Caption = MOD_REWRITE_NON_TROVATO then
  begin
    R180MessageBox('Percorso virtuale applicazione non valido', ESCLAMA);
    Exit;
  end;

  if not(FileExists(edtDLLPath.Text)) then
  begin
    R180MessageBox('La DLL indicata non esiste', ESCLAMA);
    Exit;
  end;

  Template:='<?xml version="1.0" encoding="UTF-8"?>' + CRLF +
  '<!--' + CUSTOM_CONFIG_FILE_SIGN + '-->' + CRLF +
  '<configuration>' + CRLF +
  '    <system.web>' + CRLF +
  '        {{cblPagineErrore-1}}' + CRLF +
  '        <httpRuntime enableVersionHeader="false" />' + CRLF +
  '    </system.web>' + CRLF +
  '    <system.webServer>' + CRLF +
  '        <handlers accessPolicy="Read, Execute, Script">' + CRLF +
  '            <remove name="ISAPI-dll" />' + CRLF +
  '            <add name="ISAPI-dll" path="*.dll" verb="*" modules="IsapiModule" scriptProcessor="{{edtDLLPath}}" resourceType="File" requireAccess="Execute" allowPathInfo="true" preCondition="bitness32" />' + CRLF +
  '        </handlers>' + CRLF;
  if chkOverrideDefaultPage.Checked then
  begin
    Template:=Template + '        <defaultDocument>' + CRLF +
    '             <files>' + CRLF +
    '                <clear />' + CRLF +
    '                <add value="index.html" />' + CRLF +
    '                <add value="{{defaultDocumentPage}}" />' + CRLF +
    '             </files>' + CRLF +
    '        </defaultDocument>' + CRLF;
  end;
  Template:=Template + '        {{cblPagineErrore-2}}' + CRLF +
  '        <directoryBrowse enabled="false" />' + CRLF +
  '        <httpProtocol>' + CRLF +
  '            <customHeaders>' + CRLF +
  '                <!-- # Cache-Control' + CRLF +
  '                The ''Cache-Control'' response header controls how pages can be cached' + CRLF +
  '                either by proxies or the users browser.' + CRLF +
  '                This response header can provide enhanced privacy by not caching' + CRLF +
  '                sensitive pages in the users browser cache. -->' + CRLF +
  '                <remove name="Cache-Control" />' + CRLF +
  '                <add name="Cache-Control" value="no-store, no-cache" />' + CRLF +
  '                <!-- # Strict-Transport-Security' + CRLF +
  '                The HTTP Strict Transport Security header is used to control' + CRLF +
  '                if the browser is allowed to only access a site over a secure connection' + CRLF +
  '                and how long to remember the server response for, forcing continued usage.' + CRLF +
  '                Note* Currently a draft standard which only Firefox and Chrome support. But is supported by sites like PayPal. -->' + CRLF +
  '                <remove name="Strict-Transport-Security" />' + CRLF +
  '                <add name="Strict-Transport-Security" value="max-age=31536000; includeSubDomains;" />' + CRLF +
  '                <!-- # X-Frame-Options' + CRLF +
  '                The X-Frame-Options header indicates whether a browser should be allowed' + CRLF +
  '                to render a page within a frame or iframe.' + CRLF +
  '                The valid options are DENY (deny allowing the page to exist in a frame)' + CRLF +
  '                or SAMEORIGIN (allow framing but only from the originating host)' + CRLF +
  '                Without this option set the site is at a higher risk of click-jacking. -->' + CRLF +
  '                <remove name="X-Frame-Options" />' + CRLF +
  '                <add name="X-Frame-Options" value="SAMEORIGIN" />' + CRLF +
  '                <!-- # X-XSS-Protection' + CRLF +
  '                The X-XSS-Protection header is used by Internet Explorer version 8+' + CRLF +
  '                The header instructs IE to enable its inbuilt anti-cross-site scripting filter.' + CRLF +
  '                If enabled, without ''mode=block'', there is an increased risk that' + CRLF +
  '                otherwise non-exploitable cross-site scripting vulnerabilities may potentially become exploitable -->' + CRLF +
  '                <remove name="X-XSS-Protection" />' + CRLF +
  '                <add name="X-XSS-Protection" value="1; mode=block;" />' + CRLF +
  '                <!-- # MIME type sniffing security protection' + CRLF +
  '                Enabled by default as there are very few edge cases where you wouldn''t want this enabled.' + CRLF +
  '                Theres additional reading below; but the tldr, it reduces the ability of the browser (mostly IE)' + CRLF +
  '                being tricked into facilitating driveby attacks.' + CRLF +
  '                http://msdn.microsoft.com/en-us/library/ie/gg622941(v=vs.85).aspx' + CRLF +
  '                http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx -->' + CRLF +
  '                <remove name="X-Content-Type-Options" />' + CRLF +
  '                <add name="X-Content-Type-Options" value="nosniff" />' + CRLF +
  '                <!-- A little extra security (by obscurity), removings fun but adding your own is better -->' + CRLF +
  '                <remove name="X-Powered-By" />' + CRLF +
  '                <remove name="Server" />' + CRLF +
  '                 <!-- With Content Security Policy (CSP) enabled (and a browser that supports it (http://caniuse.com/#feat=contentsecuritypolicy),' + CRLF +
  '                 you can tell the browser that it can only download content from the domains you explicitly allow' + CRLF +
  '                 CSP can be quite difficult to configure, and cause real issues if you get it wrong' + CRLF +
  '                 There is website that helps you generate a policy here http://cspisawesome.com/' + CRLF +
  '                 NB: La mancanza di questo header viene segnalata da ZAP come un problema di sicurezza purtroppo però ' + CRLF +
  '                 se lo si mette le chiamate ajax non funzionano quando cercano di richiamare la funzione eval()' + CRLF +
  '                <remove name="Content-Security-Policy" />' + CRLF +
  '                <add name="Content-Security-Policy" value="default-src ''self''; style-src ''self'' ''unsafe-inline''; script-src ''self'' ''unsafe-inline'';" /> -->' + CRLF +
  '            </customHeaders>' + CRLF +
  '        </httpProtocol>' + CRLF;

  if URLRewriteInstallato then
  begin
    Template:=Template + '        <!--' + MOD_REWRITE_DOWNLOAD + '-->' + CRLF +
    '        <rewrite>' + CRLF +
    '            <outboundRules rewriteBeforeCache="true">' + CRLF +
    '                <rule name="Rimuovi X-Powered-By">' + CRLF +
    '                    <match serverVariable="RESPONSE_X-POWERED-BY" pattern="Intra.*" />' + CRLF +
    '                    <action type="Rewrite" value="Mondo EDP s.r.l." />' + CRLF +
    '                </rule>' + CRLF +
    '                <rule name="Rimuovi Server">' + CRLF +
    '                    <match serverVariable="RESPONSE_Server" pattern=".+" />' + CRLF +
    '                    <action type="Rewrite" value="Mondo EDP s.r.l. server" />' + CRLF +
    '                </rule>' + CRLF +
    '                <!-- https://developpaper.com/setting-method-of-cookie-domain-when-iis-implements-reverse-proxy/ -->' + CRLF +
    '                <rule name="Aggiungi dominio cookie" preCondition="DominioCookieNonSpecificato">' + CRLF +
    '                    <match serverVariable="RESPONSE_Set_Cookie" pattern=".*" negate="false" />' + CRLF +
    '                    <action type="Rewrite" value="{R:0}; domain={HTTP_HOST}" />' + CRLF +
    '                </rule>' + CRLF +
    '                <preConditions>' + CRLF +
    '                    <preCondition name="DominioCookieNonSpecificato">' + CRLF +
    '                     <add input="enable={{chkForzaDominioCookie}}" pattern="enable=true" ignoreCase="true" /> <!-- Per disabilitazione -->' + CRLF +
    '                        <add input="{RESPONSE_Set_Cookie}" pattern="." />' + CRLF +
    '                        <add input="{RESPONSE_Set_Cookie}" pattern="; domain=.*" negate="true" />' + CRLF +
    '                    </preCondition>' + CRLF +
    '                </preConditions>' + CRLF +
    '            </outboundRules>' + CRLF +
    '            <rules>' + CRLF +
    '                 <!-- Pagina di manutenzione' + CRLF +
    '                    Se il sito è in manutenzione tutte le url mi riportano su ".../maintenance.html"!' + CRLF +
    '                    Impostare a false se la regola sotto è attiva -->' + CRLF +
    '                <rule name="Sito in manutenzione" stopProcessing="true">' + CRLF +
    '                    <match url="^.*$" />' + CRLF +
    '                    <action type="Redirect" url="/{{lblVirtualPathValue}}/maintenance.html" appendQueryString="false" redirectType="Temporary" />' + CRLF +
    '                    <conditions>' + CRLF +
    '                        <add input="enable={{chkPaginaManutenzione-1}}" pattern="enable=true" ignoreCase="true" /> <!-- Per disabilitazione -->' + CRLF +
    '                        <add input="{REQUEST_FILENAME}" pattern="maintenance.html" negate="true" />' + CRLF +
    '                    </conditions>' + CRLF +
    '                </rule>' + CRLF +
    '                <!-- Se il sito non è in manutenzione ma si raggiunge l''url ' + CRLF +
    '                ".../maintenance.html" ritorno automaticamente sulla home! ' + CRLF +
    '                Impostare a false se la regola sopra è attiva -->' + CRLF +
    '                <rule name="Sito non in manutenzione" stopProcessing="true">' + CRLF +
    '                    <match url="^.*$" />' + CRLF +
    '                    <action type="Redirect" url="/{{lblVirtualPathValue}}/" appendQueryString="false" />' + CRLF +
    '                    <conditions>' + CRLF +
    '                        <add input="enable={{chkPaginaManutenzione-2}}" pattern="enable=true" ignoreCase="true" /> <!-- Per disabilitazione -->' + CRLF +
    '                        <add input="{REQUEST_FILENAME}" pattern="maintenance.html" />' + CRLF +
    '                    </conditions>' + CRLF +
    '                </rule>' + CRLF +
    '                <!-- Console sessioni attive diponibile solo per sviluppo e MondoEDP -->' + CRLF +
    '                <rule name="Console monitor privato" stopProcessing="true">' + CRLF +
    '                    <match url="^.*iw(?:monitor|config).*$" />' + CRLF +
    '                    <conditions>' + CRLF +
    '                     <add input="enable={{chkMonitorPrivati}}" pattern="enable=true" ignoreCase="true" /> <!-- Per disabilitazione -->' + CRLF +
    '                        <add input="{REMOTE_ADDR}" pattern="212.210.151.210" negate="true" /> <!-- MondoEDP public IP -->' + CRLF +
    '                        <add input="{REMOTE_ADDR}" pattern="127.0.0.1" negate="true" /> <!-- localhost -->' + CRLF +
    '                        <add input="{REMOTE_ADDR}" pattern="192.0.0.*" negate="true" /> <!-- Installazione locale -->' + CRLF +
    '                    </conditions>' + CRLF +
    '                    <action type="CustomResponse" statusCode="403" />' + CRLF +
    '                </rule>' + CRLF +
    '                <!--  Se è disponibile la connessione HTTPS imposto un redirect automatico da HTTP ad HTTPS -->' + CRLF +
    '                <rule name="HTTPS Redirect" stopProcessing="true">' + CRLF +
    '                    <match url="^.*$" />' + CRLF +
    '                    <conditions>' + CRLF +
    '                     <add input="enable={{chkHttps}}" pattern="enable=true" ignoreCase="true" /> <!-- Per disabilitazione -->' + CRLF +
    '                        <add input="{HTTPS}" pattern="^OFF$" />' + CRLF +
    '                    </conditions>' + CRLF +
    '                    <action type="Redirect" url="https://{HTTP_HOST}{REQUEST_URI}" appendQueryString="true" />' + CRLF +
    '                </rule>   ' + CRLF +
    '            </rules> ' + CRLF +
    '        </rewrite>' + CRLF;
  end;
  Template:=Template + '        <!-- Deny TRACE HTTP verb - more information: https://www.owasp.org/index.php/Test_HTTP_Methods_(OTG-CONFIG-006) -->' + CRLF +
  '        <security>' + CRLF +
  '            <requestFiltering>' + CRLF +
  '                <verbs>' + CRLF +
  '                    <add verb="TRACE" allowed="false" />' + CRLF +
  '                </verbs>' + CRLF +
  '                {{lstDirectoryPrivate}}' + CRLF +
  '            </requestFiltering>' + CRLF +
  '        </security>' + CRLF +
  '    </system.webServer>' + CRLF +
  '</configuration>';
  Template:=StringReplace(Template,'{{edtDLLPath}}',edtDLLPath.Text,[rfReplaceAll]);
  Template:=StringReplace(Template,'{{defaultDocumentPage}}',ExtractFileName(edtDLLPath.Text),[rfReplaceAll]);
  Template:=StringReplace(Template,'{{chkForzaDominioCookie}}',IfThen(chkForzaDominioCookie.Checked, 'True', 'False'),[rfReplaceAll]);
  Template:=StringReplace(Template,'{{lblVirtualPathValue}}',lblVirtualPathValue.Caption,[rfReplaceAll]);
  Template:=StringReplace(Template,'{{chkMonitorPrivati}}',IfThen(chkMonitorPrivati.Checked, 'True', 'False'),[rfReplaceAll]);
  Template:=StringReplace(Template,'{{chkPaginaManutenzione-1}}',IfThen(chkPaginaManutenzione.Checked, 'True', 'False'),[rfReplaceAll]);
  Template:=StringReplace(Template,'{{chkPaginaManutenzione-2}}',IfThen(chkPaginaManutenzione.Checked, 'False', 'True'),[rfReplaceAll]);
  Template:=StringReplace(Template,'{{chkHttps}}',IfThen(chkHttps.Checked, 'True', 'False'),[rfReplaceAll]);
  Segments:='';
  if lstDirectoryPrivate.Count > 0 then
  begin
    Segments:='<hiddenSegments>' + CRLF;
    for I:=0 to lstDirectoryPrivate.Items.Count - 1 do
    begin
      Segments:=Segments + Format('                    <add segment="%s" />' + CRLF, [lstDirectoryPrivate.Items[i]]);
    end;
    Segments:=Segments + '                </hiddenSegments>'
  end;
  Template:=StringReplace(Template,'{{lstDirectoryPrivate}}',Segments,[rfReplaceAll]);

  CustomErrorPage:=False;
  for i:=0 to cblPagineErrore.Items.Count - 1 do
    if cblPagineErrore.Checked[i] then CustomErrorPage:=True;

  ErrorPages1:='';
  ErrorPages2:='';
  if CustomErrorPage then
  begin
    ErrorPages1:='<customErrors mode="On">' + CRLF;
    for i:=0 to cblPagineErrore.Items.Count - 1 do
    begin
      if cblPagineErrore.Checked[i] then ErrorPages1:=ErrorPages1 + Format('           <error redirect="err_httpstatus.html" statusCode="%s" />', [cblPagineErrore.Items[i]]) + CRLF;
    end;
    ErrorPages1:=ErrorPages1 + '        </customErrors>';

    ErrorPages2:='<httpErrors errorMode="Custom" existingResponse="Replace" defaultResponseMode="ExecuteURL">' + CRLF;
    ErrorPages2:=ErrorPages2 + '            <!-- Catch IIS 404 error due to paths that exist but shouldn''t be served (e.g. /controllers, /global.asax) ' + CRLF;
    ErrorPages2:=ErrorPages2 + '            or IIS request filtering (e.g. bin, web.config, app_code, app_globalresources, app_localresources, ' + CRLF;
    ErrorPages2:=ErrorPages2 + '            app_webreferences, app_data, app_browsers) ' + CRLF;
    ErrorPages2:=ErrorPages2 + '            https://it.wikipedia.org/wiki/Codici_di_stato_HTTP -->' + CRLF;
    for i:=0 to cblPagineErrore.Items.Count - 1 do
    begin
      if cblPagineErrore.Checked[i] then
      begin
        ErrorPages2:=ErrorPages2 + Format('            <remove statusCode="%s" />', [cblPagineErrore.Items[i]]) + CRLF;
        ErrorPages2:=ErrorPages2 + Format('            <error path="err_httpstatus.html" statusCode="%s" />', [cblPagineErrore.Items[i]]) + CRLF;
      end;
    end;
    ErrorPages2:=ErrorPages2 + '        </httpErrors>';
  end;
  Template:=StringReplace(Template,'{{cblPagineErrore-1}}',ErrorPages1,[rfReplaceAll]);
  Template:=StringReplace(Template,'{{cblPagineErrore-2}}',ErrorPages2,[rfReplaceAll]);

  if FileExists(CUSTOM_CONFIG_FILE) then
  begin
    FileContent:=TFile.ReadAllText(CUSTOM_CONFIG_FILE);
    if ContainsText(FileContent, CUSTOM_CONFIG_FILE_SIGN) then
    begin
      DeleteFile(CUSTOM_CONFIG_FILE);
    end;
  end;

  if FileExists(CUSTOM_CONFIG_FILE) then
    RenameFile(CUSTOM_CONFIG_FILE, ChangeFileExt(ExtractFileName(CUSTOM_CONFIG_FILE), '') +
      Format('_backup_%s%s', [FormatDateTime('dd-mm-yyyy_hh-nn-ss-zzz', Now), ExtractFileExt(CUSTOM_CONFIG_FILE)]));

  with TStringList.Create do
  try
    Add(Template);
    SaveToFile(CUSTOM_CONFIG_FILE, TEncoding.UTF8);
    Preference:=MessageDlg(Format('File generato in "%s", desideri aprirlo?', [edtPathBase.Text + CUSTOM_CONFIG_FILE]),mtConfirmation, [mbYes, mbNo], 0);
    if Preference = mrYes then
      ShellExecute(0, 'OPEN', PChar(CUSTOM_CONFIG_FILE), '', '', SW_SHOWNORMAL);
  finally
    Free;
  end;
end;

procedure TB000FConfigWebServer.btnScaricaURLRewriteClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(MOD_REWRITE_DOWNLOAD), nil, nil, SW_SHOWNORMAL);
end;

procedure TB000FConfigWebServer.Button2Click(Sender: TObject);
var Registro:TRegistry;
begin
  if MessageDlg('Lanciare RegEdit ed eseguire il salvataggio della chiave "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion".' + #13#10 +
                'Continuare con la configurazione della stampante?',
                mtConfirmation,[mbYes,mbNo],0,mbNo) = mrNo then
    exit;

  Registro:=TRegistry.Create;
  try
    Registro.RootKey:=HKEY_USERS;
    if Registro.OpenKey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion',False) then
    begin
      try
        Registro.DeleteKey('Devices');
        Registro.DeleteKey('PrinterPorts');
        //Registro.DeleteKey('Windows');
        Registro.CreateKey('Devices');
        Registro.CreateKey('PrinterPorts');
        //Registro.CreateKey('Windows');
        Registro.CloseKey;

        Registro.OpenKey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\Devices',False);
        Registro.WriteString('Microsoft XPS Document Writer','winspool,LPT1:');
        Registro.CloseKey;
        Registro.OpenKey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\PrinterPorts',False);
        Registro.WriteString('Microsoft XPS Document Writer','winspool,LPT1:');
        Registro.CloseKey;
        Registro.OpenKey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\Windows',False);
        Registro.DeleteValue('Device');
        Registro.DeleteValue('UserSelectedDefault');
        Registro.WriteString('Device','Microsoft XPS Document Writer,winspool,LPT1:');
        Registro.WriteInteger('UserSelectedDefault',0);
        Registro.CloseKey;
      except
        Registro.CloseKey;
        raise;
      end;
    end;
  finally
    FreeAndNil(Registro);
  end;
  ShowMessage('Effettuata configurazione delle chiavi Devices, PrinterPorts e Windows in "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion"');
end;

procedure TB000FConfigWebServer.btnLogonClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  with B000FConfigWebServerDM do
  begin
    if btnLogon.Caption = 'Connetti' then
    begin
      if DbMessaggi.Connected then
        DbMessaggi.LogOff;
      DbMessaggi.LogonUsername:=edtUtenteMsg.Text;
      DbMessaggi.LogonPassword:=edtPasswordMsg.Text;
      DbMessaggi.LogonDatabase:=cmbDatabaseMsg.Text;
      try
        StatusBar1.Panels[1].Text:='Connessione...';
        StatusBar1.Repaint;
        DbMessaggi.Logon;
      except
        R180MessageBox('Connessione non riuscita!',ERRORE);
        Screen.Cursor:=crDefault;
        Exit;
      end;

      if DbMessaggi.Connected then
      begin
        btnFiltra.Enabled:=True;
        grpDett.Visible:=True;
        selMsgHead.AfterScroll:=nil;
        selMsgHead.Close;
        try
          // apertura dataset
          if (Trim(StringReplace(edtDal.Text,'/','',[rfReplaceAll])) = '') or
             (Trim(StringReplace(edtAl.Text,'/','',[rfReplaceAll])) = '') then
          begin
            selMsgHead.ClearVariables;
            selMsgHead.Open;
          end
          else
          begin
            btnFiltraClick(nil);
          end;
          // salva data del primo messaggio
          selMsgHead.Last;
          DalOrig:=Trunc(selMsgHead.FieldByName('DATA').AsDateTime);
          selMsgHead.First;
          AlOrig:=Date;
          lblNumMsg.Caption:=Format('Num. messaggi: %d',[selMsgHead.RecordCount]);
          edtDal.Text:=DateToStr(DalOrig);
          edtAl.Text:=DateToStr(AlOrig);
        finally
          selMsgHead.AfterScroll:=selMsgHeadAfterScroll;
          selMsgHeadAfterScroll(nil);
          btnLogon.Caption:='Disconnetti';
          Screen.Cursor:=crDefault;
        end;
      end;
    end
    else
    begin
      StatusBar1.Panels[1].Text:='Disconnessione...';
      StatusBar1.Repaint;
      btnFiltra.Enabled:=False;
      grpDett.Visible:=False;
      // chiusura dataset
      try selMsgDett.CloseAll; except end;
      try selMsgHead.CloseAll; except end;
      try DbMessaggi.LogOff;  except end;
      btnLogon.Caption:='Connetti';
      Screen.Cursor:=crDefault;
    end;
  end;

  if B000FConfigWebServerDM.DbMessaggi.Connected then
  begin
    StatusBar1.Panels[1].Text:='Connesso';
    StatusBar1.Panels[2].Text:=B000FConfigWebServerDM.DbMessaggi.ServerVersion;
  end
  else
  begin
    StatusBar1.Panels[1].Text:='Non connesso';
    StatusBar1.Panels[2].Text:='';
  end;
  StatusBar1.Repaint;
end;

procedure TB000FConfigWebServer.btnFiltraClick(Sender: TObject);
var
  Dal,Al: TDateTime;
begin
  if not TryStrToDateTime(edtDal.Text,Dal) then
  begin
    R180MessageBox('La data di inizio periodo non è valida!',INFORMA);
    Exit;
  end;
  if not TryStrToDateTime(edtAl.Text,Al) then
  begin
    R180MessageBox('La data di fine periodo non è valida!',INFORMA);
    Exit;
  end;
  if Dal > Al then
  begin
    R180MessageBox('Il periodo indicato non è valido!',INFORMA);
    Exit;
  end;
  // determina il filtro periodo
  if (Dal = DalOrig) and (Al = AlOrig) then
    FiltroPeriodo:=''
  else if Dal = Al then
    FiltroPeriodo:=Format('having to_date(''%s'',''ddmmyyyy'') between trunc(min(I006.DATA_MSG)) and max(I006.DATA_MSG)',[FormatDateTime('ddmmyyyy',Dal)])
  else
    FiltroPeriodo:=Format('having max(I006.DATA_MSG) >= to_date(''%s'',''ddmmyyyy'') and trunc(min(I006.DATA_MSG)) <= to_date(''%s'',''ddmmyyyy'')',
                          [FormatDateTime('ddmmyyyy',Dal),FormatDateTime('ddmmyyyy',Al)]);

  // applica il filtro periodo
  B000FConfigWebServerDM.selMsgDett.Close;
  grpDett.Visible:=False;

  B000FConfigWebServerDM.selMsgHead.Close;
  B000FConfigWebServerDM.selMsgHead.SetVariable('FILTRO_PERIODO',FiltroPeriodo);
  B000FConfigWebServerDM.selMsgHead.Open;
  lblNumMsg.Caption:=Format('Num. messaggi: %d',[B000FConfigWebServerDM.selMsgHead.RecordCount]);
end;

procedure TB000FConfigWebServer.btnIAB110TestClick(Sender: TObject);
begin
  ShellExecute(0,'OPEN',PChar(edtIAB110UrlTest.Text),'','', SW_SHOWNORMAL);
end;

function TB000FConfigWebServer.GetUrlBase: String;
var
  MyHostName: String;
  MyIP: String;
  MYWSError: String;
begin
  // url base
  if R180GetIPFromHost(MyHostName,MyIP,MyWSError) then
    Result:=Format('http://%s',[MyIP])
  else
    Result:='http://localhost';

  if (rgpApplicativo.ItemIndex >= 0) and (rgpTipoInstallazione.ItemIndex = 0) then
  begin
    // iis
    Result:=Format('%s/%s',[Result,rgpApplicativo.Items[rgpApplicativo.ItemIndex]]);
    if rgpApplicativo.ItemIndex = ItemIrisWeb then
      Result:=Format('%s/%s',[Result,ITEM_DLL_NAME_IRISWEB])
    else if rgpApplicativo.ItemIndex = ItemIrisCloudRilpre then
      Result:=Format('%s/%s',[Result,ITEM_DLL_NAME_IRISCLOUD_RILPRE])
    else if rgpApplicativo.ItemIndex = ItemIrisCloudPaghe then
      Result:=Format('%s/%s',[Result,ITEM_DLL_NAME_IRISCLOUD_PAGHE])
    else if rgpApplicativo.ItemIndex = ItemIrisCloudStagiu then
      Result:=Format('%s/%s',[Result,ITEM_DLL_NAME_IRISCLOUD_STAGIU])
    else if rgpApplicativo.ItemIndex = ItemIrisApp then
      Result:=Format('%s/%s',[Result,ITEM_DLL_NAME_IRISAPP])
    else if rgpApplicativo.ItemIndex = ItemX001 then
      Result:=Format('%s/%s',[Result,ITEM_DLL_NAME_X001]);
  end
  else
  begin
    // service
    Result:=Format('%s:%d',[Result,StrToInt(Trim(edtPort.Text))]);
  end;
end;

procedure TB000FConfigWebServer.PageControlChange(Sender: TObject);
var
  regexpr : TRegEx;
  match   : TMatch;
begin
  case PageControl.TabIndex of
    2: begin
         // Tab "Generazione URL"

         // url base applicativo selezionato
         edtUrlBase.Text:=edtUrlBaseINI.Text;

         // generazione url con parametri
         edtUrlAzienda.Text:=edtAziendaDefault.Text;
         edtUrlProfilo.Text:=edtProfiloDefault.Text;
         cmbUrlDatabase.Text:=cmbDatabase.Text;
         edtUrlHome.Text:=edtHome.Text;
       end;
    3: begin
         cmbDatabaseMsg.Text:=cmbDatabase.Text;
         edtPasswordMsg.SetFocus;
       end;
    4: begin
         regexpr:=TRegEx.Create('^.*\/(.*)\/.*\.dll$',[roIgnoreCase]);
         match:=regexpr.Match(edtUrlBaseINI.Text);
         if (match.Success) and (match.Groups.Count > 0) then
         begin
           lblVirtualPathValue.Font.Color:=TColorRec.Green;
           lblVirtualPathValue.Caption:=match.Groups.Item[1].Value;
         end
         else
         begin
           lblVirtualPathValue.Font.Color:=TColorRec.Red;
           lblVirtualPathValue.Caption:=MOD_REWRITE_NON_TROVATO;
         end;
       end;
  end;
end;

procedure TB000FConfigWebServer.PageControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if InModifica or (rgpApplicativo.ItemIndex = -1) then
    AllowChange:=False;
end;

end.
