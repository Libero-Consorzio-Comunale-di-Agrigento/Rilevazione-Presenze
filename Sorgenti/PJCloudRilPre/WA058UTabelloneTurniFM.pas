unit WA058UTabelloneTurniFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, Oracle,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget, StrUtils, Math, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, OracleData, Data.DB, Datasnap.DBClient,
  IWContainerLayout, IW.Browser.InternetExplorer, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWApplication,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, meIWRegion,
  IWCompButton, meIWButton, IWCompExtCtrls, meIWImageFile, medpIWImageButton, IWCompCheckbox, meIWCheckBox,
  meIWRadioGroup, medpIWMultiColumnComboBox, IWCompLabel, meIWLabel, IWCompEdit, Datasnap.Win.MConnect, Vcl.Menus,
  meIWEdit, meIWGrid, medpIWTabControl, medpIWMessageDlg, A000UInterfaccia, A000UMessaggi, A000UCostanti, A000USessione, meIWComboBox,
  C700USelezioneAnagrafe, C004UParamForm, C180FunzioniGenerali, C190FunzioniGeneraliWeb, A058UPianifTurniDtm1, WC021URiepilogoAssenzeFM,
  IWHTMLControls, meIWLink, ActiveX, IWRenderContext, System.Generics.Collections,
  WA058UCopiaPianificazioneFM, WA058UElencoAnomalieFM, C021UDocumentiManagerDM, A210URegoleArchiviazioneDocMW;

type
  TWA058Dip = procedure (Dal,Al: TDateTime) of Object;

  TColonna = class
  public
    Name, TitleLabel, Classes, ClassiHeader:String;
    Key, Frozen, Hidden: Boolean;
    Width: Integer;
    constructor Create;
  end;

  TWA058AbilitazioniContrParametri = record
    rgpTipoEnabled,chkIniCorrEnabled,btnEseguiEnabled:Boolean;
  end;

  TWA058FTabelloneTurniFM = class(TWR200FBaseFM)
    WA058TabelloneRG: TmeIWRegion;
    WA058ParametriRG: TmeIWRegion;
    edtDataDa: TmeIWEdit;
    lblInizio: TmeIWLabel;
    edtDataA: TmeIWEdit;
    lblSquadra: TmeIWLabel;
    cmbSquadra: TMedpIWMultiColumnComboBox;
    cmbProfili: TMedpIWMultiColumnComboBox;
    lblCopiaAss: TmeIWLabel;
    rgpTipo: TmeIWRadioGroup;
    btnGeneraPDF: TmedpIWImageButton;
    btnVisualizza: TmeIWButton;
    btnEsegui: TmedpIWImageButton;
    LblDescrSquadra: TmeIWLabel;
    LblDescrProfilo: TmeIWLabel;
    lblTipo: TmeIWLabel;
    TemplateParametriRG: TIWTemplateProcessorHTML;
    TemplateTabelloneRG: TIWTemplateProcessorHTML;
    grdTabControl: TmedpIWTabControl;
    chkVisSaldiOre: TmeIWCheckBox;
    chkVisRiposi: TmeIWCheckBox;
    chkVisTotTurni: TmeIWCheckBox;
    DCOMConnection: TDCOMConnection;
    chkVisRigaTurni: TmeIWCheckBox;
    chkVisMatricola: TmeIWCheckBox;
    chkVisTabSint: TmeIWCheckBox;
    lnkProfilo: TmeIWLink;
    btnSalva: TmeIWButton;
    btnCancella: TmeIWButton;
    btnOperativa: TmeIWButton;
    chkIniCorr: TmeIWCheckBox;
    JQueryTabellone: TIWJQueryWidget;
    pmnMenuCella: TPopupMenu;
    ModificaItem: TMenuItem;
    CopiaPianItem: TMenuItem;
    N1: TMenuItem;
    VisCompResAssItem: TMenuItem;
    InsCancGiustItem: TMenuItem;
    PianifRepItem: TMenuItem;
    btnHdnCopiaPianif: TmeIWButton;
    edtHdnRigaSel: TmeIWEdit;
    edtHdnColonnaSel: TmeIWEdit;
    btnHdnVisCompResAss: TmeIWButton;
    btnHdnInsCancGiustif: TmeIWButton;
    btnHdnPianifReper: TmeIWButton;
    edtHdnScrollTop: TmeIWEdit;
    edtHdnScrollLeft: TmeIWEdit;
    edtHdnPaginaAttuale: TmeIWEdit;
    chkVisAssenzeMezzaGiorn: TmeIWCheckBox;
    chkVisAssenzeAdOre: TmeIWCheckBox;
    chkElaborazioneAnnuale: TmeIWCheckBox;
    btnFiltroAnomalie: TmeIWButton;
    lblModificheInCorso: TmeIWLabel;
    btnChiudi: TmeIWButton;
    N2: TMenuItem;
    ProgTurnazioneItem: TMenuItem;
    btnHdnVisProgresTurn: TmeIWButton;
    EsportaInExcelItem: TMenuItem;
    btnHdnEsportaExcel: TmeIWButton;
    btnRicercaAnomalie: TmeIWButton;
    imgPeriodoPrec: TmeIWImageFile;
    imgPeriodoSucc: TmeIWImageFile;
    btnBlocca: TmeIWButton;
    btnSblocca: TmeIWButton;
    chkArchiviaTabellone: TmeIWCheckBox;
    chkIncludiDipCS: TmeIWCheckBox;
    lblFine: TmeIWLabel;
    Riposo0Item: TMenuItem;
    Turno1Item: TMenuItem;
    Turno2Item: TMenuItem;
    Turno3Item: TMenuItem;
    Turno4Item: TMenuItem;
    NoTurnoItem: TMenuItem;
    N3: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabControlTabControlChange(Sender: TObject);
    procedure cmbSquadraAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure lnkProfiloClick(Sender: TObject);
    procedure cmbProfiliAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure rgpTipoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure btnOperativaClick(Sender: TObject);
    procedure btnBloccaSbloccaClick(Sender: TObject);
    procedure CambioStatoVisDatiOpzionali(Sender: TObject; EventParams: TStringList);
    procedure CambiaStatoVisDatiOpzionaliReload(Sender: TObject; EventParams: TStringList);
    procedure btnRicercaAnomalieClick(Sender: TObject);
    procedure chkElaborazioneAnnualeAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnFiltroAnomalieClick(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure btnHdnCopiaPianifClick(Sender: TObject);
    procedure btnHdnVisCompResAssClick(Sender: TObject);
    procedure btnHdnInsCancGiustifClick(Sender: TObject);
    procedure btnHdnPianifReperClick(Sender: TObject);
    procedure btnHdnEsportaExcelClick(Sender: TObject);
    procedure btnHdnVisProgresTurnClick(Sender: TObject);
  private
    C004DM:TC004FParamForm;
    FNComp: String;
    WA058FCopiaPianificazioneFM: TWA058FCopiaPianificazioneFM;
    WA058FElencoAnomalieFM: TWA058FElencoAnomalieFM;
    AbilitazioniContrParametri:TWA058AbilitazioniContrParametri;
    ChkIniCorrVisibileSuClient,PianifNonOperativa,AbilitazioneA126,GeneraPDF:Boolean;
    abilitaBlocca,abilitaSblocca:Boolean;
    C021DM: TC021FDocumentiManagerDM;
    procedure CambioDate(Sender: TObject);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure CaricaComboBox;
    procedure AggiornaLabel;
    procedure ImpostaContrParametri;
    procedure ResultShowTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ElaboraTabellone_2;
    procedure ResultElabTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ElaboraTabellone;
    procedure CaricaLista(Crea: Boolean);
    function CreateJSonString: String;
    function SalvaSuGestioneDocumentale: TResCtrl;
    procedure ResultGeneraPDF(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultRegistraTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure RegistraTabellone;
    procedure ResultCancellaTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CancellaTabellone;
    procedure ResultRendiOperativa(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultBloccaSblocca(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure OnChiudiDialogClick(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
    procedure VisualizzaRiepilogo;
    function DimLungHTML(S: String; D: Integer): String;
    // JQGrid - inizio
    procedure ValorizzaJSONRiga(const i:Integer; RigaJSON,ClassiCelleRigaJSON,CelleEditabiliRigaJSON:TJSONObject; GetCellaUIOpzioni:TGetCellaUIOpzioni);
    procedure ValorizzaJSONRigaIntestazione(JSONRiga:TJSONObject;const Squadra,TipoOpe:String);
    procedure ValorizzaJSONTooltipRiga(i:Integer; RigaTooltipJSON:TJSONObject; GetCellaUIOpzioni:TGetCellaUIOpzioni);
    procedure ValorizzaJSONTurno(ListaItems:TJSONArray; CodiceOrario: String; DataDec:TDateTime; var ValueSelComboT1: Integer; ValT1:String; var ValueSelComboT2: Integer; ValT2: String);
    procedure ValorizzaItemComboJSON(JSONElem:TJSONObject; Valore:Integer; Etichetta:String);
    // JQGrid - fine
  public
    A058DM: TA058FPianifTurniDtm1;
    WA058SelAnagrafe: TOracleDataSet;
    WA058SolaLettura: Boolean;
    AggiornaDipendentiDisponibili: TWA058Dip;
    // JQGrid - inizio
    ClientBtnSalvaVisibile:Boolean;
    ClientBtnCancellaVisibile:Boolean;
    ClientBtnOperativaVisibile:Boolean;
    ClientBtnBloccaVisibile:Boolean;
    ClientBtnSbloccaVisibile:Boolean;
    // JQGrid - fine
    const
      NRIGHEBLOCCATE = 1;
      NUM_COLONNE_FISSE = 5; //JQGrid
    procedure ReleaseOggetti; override;
    procedure Inizializza;
    procedure Abilitazioni;
    function ElaboraStampa: TResCtrl;
    procedure ImpostaFiltroAnomalie(ListaTipiAnomalieSel:TStringList);
    // JQGrid - inizio
    procedure GetDatiTabellaJQGrid(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
    procedure GetDatiDialogModificaTurno(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
    procedure GetDatiTurno(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
    procedure ConfermaDatiTurno(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
    procedure ConfermaDatiTurnoRapido(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
    procedure GetContatoriOperatore(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
    // JQGrid - fine
    procedure RefreshTabellone;
    function ModificheInCorso: String;
  end;

implementation

uses WR010UBase {$IFDEF WEBPJ}, WA058UPianifTurni, WR100UBase, System.TypInfo {$ELSE},W008UGiustificativi, W004UReperibilita,
  System.TypInfo,W030UTabelloneTurni{$ENDIF};

{$R *.dfm}

constructor TColonna.Create;
begin
  Self.Name:='';
  Self.TitleLabel:='';
  Self.Classes:='';
  Self.ClassiHeader:='';
  Self.Key:=False;
  Self.Frozen:=False;
  Self.Hidden:=False;
  Self.Width:=100;
end;

procedure TWA058FTabelloneTurniFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  FNComp:='';
  C004DM:=CreaC004(SessioneOracle,'WA058',Parametri.ProgOper,False);
  AbilitazioniContrParametri.rgpTipoEnabled:=True;
  AbilitazioniContrParametri.chkIniCorrEnabled:=True;
  AbilitazioniContrParametri.btnEseguiEnabled:=True;
  ChkIniCorrVisibileSuClient:=True;
  GeneraPDF:=False;
  A058DM:=TA058FPianifTurniDtm1.Create(Self);
  grdTabControl.AggiungiTab('Pianificazione',WA058ParametriRG);
  grdTabControl.AggiungiTab('Tabellone',WA058TabelloneRG);
  grdTabControl.ActiveTab:=WA058ParametriRG;

  // imposta la gestione automatica degli spostamenti di periodo
  (Self.Owner as TWR010FBase).AssegnaGestPeriodo(edtDataDa,edtDataA,imgPeriodoPrec,imgPeriodoSucc,CambioDate,CambioDate,CambioDate);//TEMPORANEO
  C021DM:=TC021FDocumentiManagerDM.Create(Self);
end;

procedure TWA058FTabelloneTurniFM.ReleaseOggetti;
begin
  PutParametriFunzione;
  FreeAndNil(C004DM);
  inherited;
end;

procedure TWA058FTabelloneTurniFM.Inizializza;
var
  NumRighePagJQGrid:Integer;
begin
  btnEsegui.Enabled:=Not WA058SolaLettura and ((Parametri.A058_PianifOperativa = 'S') or (Parametri.A058_PianifNonOperativa = 'S'));
  AbilitazioniContrParametri.btnEseguiEnabled:=btnEsegui.Enabled;
  GetParametriFunzione;
  A058DM.selAnagrafeA058:=WA058SelAnagrafe;
  cmbSquadra.Text:=A058DM.GetSquadraPiuAssegnata(cmbSquadra.Text);
  cmbSquadraAsyncChange(nil,nil,0,'');
  ClientBtnSalvaVisibile:=False;
  ClientBtnCancellaVisibile:=False;
  ClientBtnOperativaVisibile:=False;
  chkElaborazioneAnnuale.Visible:=(DebugHook = 1);
  ClientBtnBloccaVisibile:=False;
  ClientBtnSbloccaVisibile:=False;

  // Impostazione jqgrid
  NumRighePagJQGrid:=(Owner as TWR010FBase).GetRighePaginaTabella;//StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
  if NumRighePagJQGrid > 0 then
    JQueryTabellone.OnReady.Add(Format('parametriTabellone.jqGridRowNum=%d;',[NumRighePagJQGrid]))
  else
    JQueryTabellone.OnReady.Add('parametriTabellone.jqGridRowNum=false;');
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.NUM_COLONNE_FISSE=%d;',[NUM_COLONNE_FISSE]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.NRIGHEBLOCCATE=%d;',[NRIGHEBLOCCATE]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.edtHdnRigaSelHTMLName="%s";',[edtHdnRigaSel.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.edtHdnColonnaSelHTMLName="%s";', [edtHdnColonnaSel.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.edtHdnPaginaAttualeHTMLName="%s";',[edtHdnPaginaAttuale.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.edtHdnScrollTopHTMLName="%s";', [edtHdnScrollTop.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.edtHdnScrollLeftHTMLName="%s";', [edtHdnScrollLeft.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.btnHdnCopiaPianifHTMLName="%s";',[btnHdnCopiaPianif.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.btnHdnVisCompResAssHTMLName="%s";',[btnHdnVisCompResAss.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.btnHdnInsCancGiustifHTMLName="%s";', [btnHdnInsCancGiustif.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.btnHdnPianifReperHTMLName="%s";',[btnHdnPianifReper.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.btnHdnVisProgresTurnHTMLName="%s";',[btnHdnVisProgresTurn.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.btnHdnEsportaExcelHTMLName="%s";',[btnHdnEsportaExcel.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.chkVisRigaTurniHTMLName="%s";',[chkVisRigaTurni.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.chkVisTotTurniHTMLName="%s";',[chkVisTotTurni.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.chkVisRiposiHTMLName="%s";',[chkVisRiposi.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.chkVisMatricolaHTMLName="%s";',[chkVisMatricola.HTMLName]));
  JQueryTabellone.OnReady.Add(Format('parametriTabellone.solaLettura=%s;',[IfThen(WA058SolaLettura,'true','false')]));
  // Applico lo stile disattivato alla voce di menù contestuale "Copia pianificazione",se necessario
  if WA058SolaLettura then
    JQueryTabellone.OnReady.Add(Format('$("#%s").addClass("disabled");',[CopiaPianItem.Name]));
  JQueryTabellone.OnReady.Add('richiediDatiTabelloneJQGrid();');
  (Owner as TWR010FBase).RegistraMetodoAJAX('GetDatiTabellaJQGrid', GetDatiTabellaJQGrid);
  (Owner as TWR010FBase).RegistraMetodoAJAX('GetDatiDialogModificaTurno', GetDatiDialogModificaTurno);
  (Owner as TWR010FBase).RegistraMetodoAJAX('GetDatiTurno', GetDatiTurno);
  (Owner as TWR010FBase).RegistraMetodoAJAX('ConfermaDatiTurno', ConfermaDatiTurno);
  (Owner as TWR010FBase).RegistraMetodoAJAX('GetContatoriOperatore', GetContatoriOperatore);
  (Owner as TWR010FBase).RegistraMetodoAJAX('ConfermaDatiTurnoRapido', ConfermaDatiTurnoRapido);
  btnFiltroAnomalie.Hint:=Format('Elenco anomalie attive: %s',[A058DM.Vista.PropElencoAnomalie.GetAnomalieAttive]);
end;

procedure TWA058FTabelloneTurniFM.GetParametriFunzione;
{Leggo i parametri della form}
begin
  with A058DM do
  begin
    DataInizio:=R180InizioMese(Parametri.DataLavoro);
    //SOLO PER TEST: DataInizio:=EncodeDate(2018,1,1);
    edtDataDa.Text:=DateToStr(DataInizio);
    DataFine:=R180FineMese(Parametri.DataLavoro);
    //SOLO PER TEST: DataFine:=EncodeDate(2018,1,10);
    edtDataA.Text:=DateToStr(DataFine);
    {$IFDEF WEBPJ} // In IrisCloud
    (Self.Owner as TWA058FPianifTurni).grdC700.WC700FM.C700DataDal:=DataInizio;
    (Self.Owner as TWA058FPianifTurni).grdC700.WC700FM.C700DataLavoro:=DataFine;
    {$ENDIF}
    RefreshSquadre;
    CaricaComboBox;
    cmbSquadra.Text:=C004DM.GetParametro('SQUADRA','');
    chkIncludiDipCS.Checked:=C004DM.GetParametro(UpperCase(chkIncludiDipCS.Name),'N') = 'S';
    cmbProfili.Text:=C004DM.GetParametro('PROFILO','');
    AggiornaLabel;
    RgpTipo.ItemIndex:=StrToInt(C004DM.GetParametro('TIPOPIANIFICAZIONE','0'));
    chkVisRigaTurni.Checked:=C004DM.GetParametro(UpperCase(chkVisRigaTurni.Name),'N') = 'S';
    chkVisMatricola.Checked:=C004DM.GetParametro(UpperCase(chkVisMatricola.Name),'S') = 'S';
    chkVisTabSint.Checked:=C004DM.GetParametro(UpperCase(chkVisTabSint.Name),'N') = 'S';
    chkVisTotTurni.Checked:=C004DM.GetParametro(UpperCase(chkVisTotTurni.Name),'N') = 'S';
    chkVisRiposi.Checked:=C004DM.GetParametro(UpperCase(chkVisRiposi.Name),'N') = 'S';
    chkVisSaldiOre.Checked:=C004DM.GetParametro(UpperCase(chkVisSaldiOre.Name),'N') = 'S';
    chkVisAssenzeMezzaGiorn.Checked:=C004DM.GetParametro(UpperCase(chkVisAssenzeMezzaGiorn.Name),'S') = 'S';
    chkVisAssenzeAdOre.Checked:=C004DM.GetParametro(UpperCase(chkVisAssenzeAdOre.Name),'S') = 'S';
    chkArchiviaTabellone.Checked:=C004DM.GetParametro(UpperCase(chkArchiviaTabellone.Name),'N') = 'S';
    selT082.SearchRecord('CODICE',cmbProfili.Text,[srFromBeginning]);
    Abilitazioni;
  end;
end;

procedure TWA058FTabelloneTurniFM.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004DM.Cancella001;
  with A058DM do
  begin
    C004DM.PutParametro('SQUADRA',VarToStr(cmbSquadra.Text));
    C004DM.PutParametro(UpperCase(UpperCase(chkIncludiDipCS.Name)),IfThen(chkIncludiDipCS.Checked,'S','N'));
    C004DM.PutParametro('PROFILO',VarToStr(cmbProfili.Text));
    C004DM.PutParametro('TIPOPIANIFICAZIONE',IntToStr(RgpTipo.ItemIndex));
    C004DM.PutParametro(UpperCase(UpperCase(chkVisTotTurni.Name)),IfThen(chkVisTotTurni.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisRiposi.Name),IfThen(chkVisRiposi.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisSaldiOre.Name),IfThen(chkVisSaldiOre.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisRigaTurni.Name),IfThen(chkVisRigaTurni.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisMatricola.Name),IfThen(chkVisMatricola.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisTabSint.Name),IfThen(chkVisTabSint.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisAssenzeMezzaGiorn.Name),IfThen(chkVisAssenzeMezzaGiorn.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisAssenzeAdOre.Name),IfThen(chkVisAssenzeAdOre.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkArchiviaTabellone.Name),IfThen(chkArchiviaTabellone.Checked,'S','N'));
  end;
  try SessioneOracle.Commit; except end;
end;

procedure TWA058FTabelloneTurniFM.CambioDate(Sender: TObject);
begin
  with A058DM do
  begin
    (Self.Owner as TWR010FBase).SetCompPeriodo_EseguiSubmit(Sender,False);
    if (DataInizio <> StrToDate(edtDataDa.Text)) or
       (DataFine <> StrToDate(edtDataA.Text)) then
    begin
      (Self.Owner as TWR010FBase).SetCompPeriodo_EseguiSubmit(Sender,True);
      DataInizio:=StrToDate(edtDataDa.Text);
      DataFine:=StrToDate(edtDataA.Text);
      {$IFDEF WEBPJ} // In IrisCloud
      (Self.Owner as TWA058FPianifTurni).grdC700.WC700FM.C700DataDal:=DataInizio;
      (Self.Owner as TWA058FPianifTurni).grdC700.WC700FM.C700DataLavoro:=DataFine;
      {$ENDIF}
      RefreshSquadre;
      CaricaComboBox;
      AggiornaLabel;
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.CaricaComboBox;
begin
  with A058DM.selT603 do
  begin
    cmbSquadra.Items.Clear;
    First;
    while not Eof do
    begin
      cmbSquadra.AddRow(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  with A058DM.selT082 do
  begin
    cmbProfili.Items.Clear;
    First;
    while not Eof do
    begin
      cmbProfili.AddRow(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.AggiornaLabel;
begin
  LblDescrSquadra.Caption:='';
  LblDescrProfilo.Caption:='';
  if Trim(cmbSquadra.Text) <> '' then
    LblDescrSquadra.Caption:=VarToStr(A058DM.selT603.Lookup('CODICE',Trim(cmbSquadra.Text),'DESCRIZIONE'));
  if Trim(cmbProfili.Text) <> '' then
    LblDescrProfilo.Caption:=VarToStr(A058DM.selT082.Lookup('CODICE',Trim(cmbProfili.Text),'DESCRIZIONE'));
end;

procedure TWA058FTabelloneTurniFM.Abilitazioni;
var
  s:String;
begin
  // Generali e tab Prospetto
  with A058DM do
  begin
    //Applico le abilitazioni previste nel tab Permessi della form <A008> Profilo utenti
    AssenzeOperative:=selT082.FieldByName('ASSENZE_OPERATIVE').AsString = 'S';
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    begin
      AbilitazioniContrParametri.rgpTipoEnabled:=(selT082.FieldByName('MODALITA_LAVORO').AsString = 'N') and
                                            ((selT082.FieldByName('INIZIALE').AsString = 'S') or (selT082.FieldByName('CORRENTE').AsString = 'S'));
      rgpTipo.Editable:=(selT082.FieldByName('INIZIALE').AsString = 'S') and (selT082.FieldByName('CORRENTE').AsString = 'S');
      ChkIniCorrVisibileSuClient:=(selT082.FieldByName('MODALITA_LAVORO').AsString = 'O') or (RgpTipo.ItemIndex = 0);
      if not rgpTipo.Editable then
        if selT082.FieldByName('CORRENTE').AsString = 'S' then
          RgpTipo.ItemIndex:=1
        else if selT082.FieldByName('INIZIALE').AsString = 'S' then
          RgpTipo.ItemIndex:=0;
      if (selT082.FieldByName('MODALITA_LAVORO').AsString = 'N') and (RgpTipo.ItemIndex = 0) then
        AssenzeOperative:=False
      else if (selT082.FieldByName('MODALITA_LAVORO').AsString = 'O') then
        AssenzeOperative:=True;
    end;

    if not WA058SolaLettura then
    begin
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        //PIANIFICAZIONE PROGRESSIVA
        AbilitazioniContrParametri.btnEseguiEnabled:=(selT082.FieldByName('GENERAZIONE').AsString = 'S') and (Parametri.A058_PianifOperativa <> 'N') and
                                                ((RgpTipo.ItemIndex = 0) or (selT082.FieldByName('MODALITA_LAVORO').AsString = 'O'));
        AbilitazioniContrParametri.chkIniCorrEnabled:=AbilitazioniContrParametri.btnEseguiEnabled;
      end
      else
      begin
        //PIANIFICAZIONE STANDARD - NON PROGRESSIVA
        AbilitazioniContrParametri.rgpTipoEnabled:=False;
        ChkIniCorrVisibileSuClient:=False;
        if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
          AbilitazioniContrParametri.btnEseguiEnabled:=Parametri.A058_PianifOperativa <> 'N'
        else
          AbilitazioniContrParametri.btnEseguiEnabled:=Parametri.A058_PianifNonOperativa <> 'N';
      end;
    end;
    if not ChkIniCorrVisibileSuClient then
      chkIniCorr.Checked:=False;

    //Gestione Visualizzazione assenze
    lblCopiaAss.Caption:='';
    if ((Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') or AssenzeOperative) and
       (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') then
    begin
      if AssenzeOperative then
        lblCopiaAss.Caption:='Gestione assenze: OPERATIVA'
      else
      begin
        lblCopiaAss.Caption:='Gestione assenze: NON OPERATIVA';
        //Specifico la copia assenze solo se la gestione è "NON OPERATIVA"
        if (Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') and (lblCopiaAss.Caption <> '') then
          lblCopiaAss.Caption:=lblCopiaAss.Caption + #13#10;
        if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'AGGIUNGI' then
          lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Aggiungi assenze da modalità operativa'
        else if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'SOVRASCRIVI' then
          lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Sovrascrivi assenze da modalità operativa';
      end;
    end;
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
      lnkProfilo.Caption:='Profilo pianificazione - NON operativo:'
    else
      lnkProfilo.Caption:='Profilo pianificazione - operativo:';
  end;

  if not ChkIniCorrVisibileSuClient then
  begin
    s:='$("#' + chkIniCorr.HTMLName + '").addClass("invisibile"); ';
    chkIniCorr.Css:=chkIniCorr.Css + ' invisibile';
  end
  else
  begin
    s:='$("#' + chkIniCorr.HTMLName + '").removeClass("invisibile"); ';
    chkIniCorr.Css:=StringReplace(chkIniCorr.Css,' invisibile','',[rfReplaceAll]);
  end;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(s);

  // Tab Tabellone
  if A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  begin
    btnSalva.Enabled:=Parametri.A058_PianifOperativa <> 'N';
    btnCancella.Enabled:=Parametri.A058_PianifOperativa = 'S';
  end
  else if A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
  begin
    btnSalva.Enabled:=Parametri.A058_PianifNonOperativa <> 'N';
    btnCancella.Enabled:=Parametri.A058_PianifNonOperativa = 'S';
    btnOperativa.Enabled:=(Parametri.A058_PianifOperativa <> 'N') and (Parametri.A058_PianifNonOperativa <> 'N');
  end;

  //PIANIFICAZIONE PROGRESSIVA
  if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
  begin
    //PIANIFICAZIONE OPERATIVA
    with A058DM do
    begin
      if (RgpTipo.ItemIndex = 0) and (selT082.FieldByName('GENERAZIONE').AsString = 'N') or
         (RgpTipo.ItemIndex = 0) and (selT082.FieldByName('INIZIALE').AsString = 'N') or
         (RgpTipo.ItemIndex = 1) and (selT082.FieldByName('CORRENTE').AsString = 'N') then
      begin
        btnSalva.Enabled:=False;
        btnCancella.Enabled:=False;
        btnBlocca.Enabled:=False;
        btnSblocca.Enabled:=False;
      end;
      ClientBtnOperativaVisibile:=(selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (RgpTipo.ItemIndex = 1) and
                                  (selT082.FieldByName('RENDI_OPERATIVA').AsString = 'S');
    end;
  end
  else if WA058SolaLettura then
  begin
    btnSalva.Enabled:=False;
    btnCancella.Enabled:=False;
    btnOperativa.Enabled:=False;
    btnBlocca.Enabled:=False;
    btnSblocca.Enabled:=False;
  end;

  //si può utilizzare l'archiviazione solo se è presente il modulo ARCHIVIAZIONE_SOSTITUTIVA
  if not Parametri.ModuloInstallato['ARCHIVIAZIONE_SOSTITUTIVA'] then
  begin
    s:='$("#' + chkArchiviaTabellone.HTMLName + '").addClass("invisibile"); ';
    chkArchiviaTabellone.Css:=chkArchiviaTabellone.Css + ' invisibile';
  end
  else
  begin
    s:='$("#' + chkArchiviaTabellone.HTMLName + '").removeClass("invisibile"); ';
    chkArchiviaTabellone.Css:=StringReplace(chkArchiviaTabellone.Css,' invisibile','',[rfReplaceAll]);
  end;

  ImpostaContrParametri;
end;

procedure TWA058FTabelloneTurniFM.ImpostaContrParametri;
begin
  if A058DM.Vista.Count = 0 then
  begin
    // Tab sbloccato
    lblModificheInCorso.Visible:=False;
    imgPeriodoPrec.Enabled:=True;
    imgPeriodoPrec.ImageFile.FileName:=filebtnPrec;
    edtDataDa.Enabled:=True;
    edtDataA.Enabled:=True;
    imgPeriodoSucc.Enabled:=True;
    imgPeriodoSucc.ImageFile.FileName:=filebtnSucc;
    cmbSquadra.Enabled:=True;
    chkIncludiDipCS.Enabled:=True;
    cmbProfili.Enabled:=True;
    lblTipo.Enabled:=AbilitazioniContrParametri.rgpTipoEnabled;
    rgpTipo.Enabled:=AbilitazioniContrParametri.rgpTipoEnabled;
    chkIniCorr.Enabled:=AbilitazioniContrParametri.chkIniCorrEnabled;
    chkArchiviaTabellone.Enabled:=True;
    lnkProfilo.Enabled:=True;
    btnVisualizza.Enabled:=True;
    btnGeneraPDF.Enabled:=True;
    btnEsegui.Enabled:=AbilitazioniContrParametri.btnEseguiEnabled;
  end
  else
  begin
    // Tab bloccato
    lblModificheInCorso.Visible:=True;
    imgPeriodoPrec.Enabled:=False;
    imgPeriodoPrec.ImageFile.FileName:=filebtnPrecDisab;
    edtDataDa.Enabled:=False;
    edtDataA.Enabled:=False;
    imgPeriodoSucc.Enabled:=False;
    imgPeriodoSucc.ImageFile.FileName:=filebtnSuccDisab;
    cmbSquadra.Enabled:=False;
    chkIncludiDipCS.Enabled:=False;
    cmbProfili.Enabled:=False;
    lblTipo.Enabled:=False;
    rgpTipo.Enabled:=False;
    chkIniCorr.Enabled:=False;
    chkArchiviaTabellone.Enabled:=False;
    lnkProfilo.Enabled:=False;
    btnVisualizza.Enabled:=False;
    btnGeneraPDF.Enabled:=False;
    btnEsegui.Enabled:=False;
  end;
end;

procedure TWA058FTabelloneTurniFM.grdTabControlTabControlChange(Sender: TObject);
var
   ActiveTabIndex:Integer;
begin
  inherited;
  ActiveTabIndex:=grdTabControl.ActiveTabIndex;
  JQueryTabellone.Enabled:=(ActiveTabIndex=1);
  ImpostaContrParametri;
end;

procedure TWA058FTabelloneTurniFM.cmbSquadraAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  AggiornaLabel;
  Abilitazioni;
end;

procedure TWA058FTabelloneTurniFM.lnkProfiloClick(Sender: TObject);
begin
  inherited;
  {$IFDEF WEBPJ}
    //IrisCloud link a WA174
    (Self.Parent as TWR100FBase).AccediForm(213,'CODICE=' + cmbProfili.Text);

    A058DM.selT082.Close;
    A058DM.selT082.Open;
    A058DM.selT082.SearchRecord('CODICE',cmbProfili.Text,[srFromBeginning]);

    A058DM.AssenzeOperative:=A058DM.selT082.FieldByName('ASSENZE_OPERATIVE').AsString = 'S';
    Abilitazioni;
  {$ENDIF}
end;

procedure TWA058FTabelloneTurniFM.cmbProfiliAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  //if Trim(cmbProfili.Text) <> '' then
    A058DM.selT082.SearchRecord('CODICE',cmbProfili.Text,[srFromBeginning]);
  AggiornaLabel;
  Abilitazioni;
  ClientBtnSalvaVisibile:=False;
  ClientBtnCancellaVisibile:=False;
  ClientBtnOperativaVisibile:=False;
  ClientBtnBloccaVisibile:=False;
  ClientBtnSbloccaVisibile:=False;
end;

procedure TWA058FTabelloneTurniFM.rgpTipoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Abilitazioni;
end;

procedure TWA058FTabelloneTurniFM.btnEseguiClick(Sender: TObject);
var CodProfPianif:String;
begin
  with A058DM do
    try
      DataInizio:=StrToDate(edtDataDa.Text);
      DataFine:=StrToDate(edtDataA.Text);
      NuovaPianif:=Sender = btnEsegui;
      TipoPianif:=rgpTipo.ItemIndex;
      SquadraRiferimento:=cmbSquadra.Text;
      IncludiDipCambioSquadra:=chkIncludiDipCS.Checked;

      CodProfPianif:=cmbProfili.Text;
      if CodProfPianif = '' then
        raise Exception.Create(A000MSG_A058_ERR_PROFILO_MANCANTE);
      if not A058DM.selT082.SearchRecord('CODICE',CodProfPianif,[srFromBeginning]) then
        raise Exception.Create(A000MSG_A058_ERR_PROFILO_ERRATO);
      if DataFine < DataInizio then
        raise Exception.Create(A000MSG_A058_ERR_PERIODO);
      if R180FineMese(DataFine) > R180AddMesi(R180FineMese(DataInizio),11,True) then
        raise Exception.Create('Non è possibile specificare un periodo afferente a più di 12 mesi!');
      if Trim(A058DM.SquadraRiferimento) = '' then
        raise Exception.Create('E'' necessario indicare la squadra di riferimento!');

      if Assigned(AggiornaDipendentiDisponibili) then
        AggiornaDipendentiDisponibili(DataInizio,DataFine);
    except
      on E:Exception do
        raise Exception.Create(E.Message);
    end;

  if A058DM.Vista.Modificato then
  begin
    MsgBox.WebMessageDlg(A000MSG_A058_DLG_MODIFICHE_NON_SALVATE,mtConfirmation,[mbYes, mbNo],ResultShowTabellone,'');
    Abort;
  end
  else
    ElaboraTabellone_2;
end;

procedure TWA058FTabelloneTurniFM.ResultShowTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    ElaboraTabellone_2;
end;

procedure TWA058FTabelloneTurniFM.ElaboraTabellone_2;
var
  s:String;
  i:Integer;
begin
  with A058DM do
  begin
    {$IFDEF WEBPJ} // In IrisCloud
    (Self.Owner as TWA058FPianifTurni).grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataInizio,DataFine);
    {$ENDIF}
    WA058SelAnagrafe.Close;
    EditSQLC700;
    WA058SelAnagrafe.Open;
    if WA058SelAnagrafe.RecordCount <= 0 then
      raise Exception.Create(A000MSG_ERR_NO_DIP);

    selT620.Close;
    selT620.SetVariable('DATAA',DataFine);
    selT620.Open;
    R502ProDtM.PeriodoConteggi(DataInizio,DataFine);
    R502ProDtM.Conteggi('APERTURA',0,DataInizio);
    ConteggiaDebito:=False;
    PulisciVista;

    if NuovaPianif then
    begin
      //Primo scorrimento per verificare se esiste già una pianificazione
      S:='';
      i:=0;
      WA058SelAnagrafe.First;
      while not WA058SelAnagrafe.Eof do
      begin
        LeggiPianificazione(WA058SelAnagrafe.FieldByName('Progressivo').AsInteger,DataInizio,DataFine,False);
        if ((selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') and (Q080Gest.RecordCount > 0)) or
           ((selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (Q081Gest.RecordCount > 0)) then
        begin
          inc(i);
          if i > 20 then
          begin
            S:=S + 'ecc...' + CRLF;
            Break;
          end
          else
            S:=S + Format('%-8s %s %s',[WA058SelAnagrafe.FieldByName('MATRICOLA').AsString,WA058SelAnagrafe.FieldByName('COGNOME').AsString,WA058SelAnagrafe.FieldByName('NOME').AsString]) + CRLF;
        end;
        WA058SelAnagrafe.Next;
      end;

      if S <> '' then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_A058_DLG_FMT_PIANIF_ESISTENTE,[S]),mtConfirmation,[mbYes, mbNo],ResultElabTabellone,'');
        Abort;
      end;
    end;
    ElaboraTabellone;
  end;
end;

procedure TWA058FTabelloneTurniFM.ResultElabTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    ElaboraTabellone;
end;

procedure TWA058FTabelloneTurniFM.ElaboraTabellone;
//var abilitaBlocca,abilitaSblocca:Boolean;
begin
  try
    {if (Self.Owner is TWR010FBase) then
    with (Self.Owner as TWR010FBase) do
    begin
      lstScrollBar[ScrollBarIndexOf('divtable')].Top:=0;      //TODO: serve?
      lstScrollBar[ScrollBarIndexOf('divtable')].Top:=0;
    end;}
    CaricaLista(A058DM.NuovaPianif);
    ClientBtnSalvaVisibile:=(A058DM.Vista.Count >= 0) and A058DM.NuovaPianif;
    ClientBtnCancellaVisibile:=(A058DM.Vista.Count >= 0);

    PianifNonOperativa:=(A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and
                                {(A058DM.TipoPianif = 0) and}
                                (Parametri.CampiRiferimento.C11_PianifOrariProg = 'S');
    AbilitazioneA126:={$IFDEF WEBPJ}
                      (A000GetInibizioni('Funzione','OpenA126BloccoRiepiloghi') = 'S') and
                      {$ENDIF}
                      (A058DM.DataInizio = R180InizioMese(A058DM.DataInizio)) and
                      (A058DM.DataFine = R180FineMese(A058DM.DataFine));
    A058DM.AbilitaBloccaSblocca(abilitaBlocca,abilitaSblocca);
    if GeneraPDF then
    begin
      A058DM.PulisciVista;
      exit;
    end;

    ClientBtnBloccaVisibile:=PianifNonOperativa and AbilitazioneA126;
    ClientBtnSbloccaVisibile:=PianifNonOperativa and AbilitazioneA126;
    btnBlocca.Enabled:=PianifNonOperativa and AbilitazioneA126 and abilitaBlocca;
    btnSblocca.Enabled:=PianifNonOperativa and AbilitazioneA126 and abilitaSblocca;
    // Se proveniamo da un'altra scheda e abbiamo richiesto una nuova elaborazione cerchiamo di mantenere
    // la posizione precedente.
    if FNComp = '' then
    begin
      edtHdnScrollTop.Text:='0';
      edtHdnScrollLeft.Text:='0';
      edtHdnPaginaAttuale.Text:='1';
    end;
    Abilitazioni;
    grdTabControl.ActiveTab:=WA058TabelloneRG;
  except
    on E:Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TWA058FTabelloneTurniFM.CaricaLista(Crea:Boolean);
begin
  with A058DM do
  begin
    WA058SelAnagrafe.First;
    while Not WA058SelAnagrafe.Eof do
    begin
      if Not AssenzeOperative then
      begin
        if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'SOVRASCRIVI' then
        begin
          SovrascriviT041.SetVariable('PROGRESSIVO',WA058SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          SovrascriviT041.SetVariable('DATADA',DataInizio);
          SovrascriviT041.SetVariable('DATAA',DataFine);
          SovrascriviT041.Execute;
        end
        else if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'AGGIUNGI' then
        begin
          InserisciT041.SetVariable('PROGRESSIVO',WA058SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          InserisciT041.SetVariable('DATADA',DataInizio);
          InserisciT041.SetVariable('DATAA',DataFine);
          InserisciT041.Execute;
        end;
        InserisciT041.Session.Commit;
      end;
      if Not A058DM.NuovaPianif then
        LeggiPianificazione(WA058SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataInizio,DataFine)
      else
        PianificaDipendente(WA058SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      if Vista.Count > 0 then
        DebitoDipendente(Vista[Vista.Count - 1],0,Trunc(DataFine - DataInizio));
      WA058SelAnagrafe.Next;
    end;
    Vista.Controllo_TurnoAntincendio(DataInizio, DataFine);
    Vista.Controllo_Referente(DataInizio, DataFine);
  end;
end;

procedure TWA058FTabelloneTurniFM.btnGeneraPDFClick(Sender: TObject);
var //abilitaBlocca,abilitaSblocca:Boolean;
    LResCtrl: TResCtrl;
    DatiVariabili: TDatiVariabili;
    NomeFile, ErrMsg: String;
begin
  GeneraPDF:=True;
  try
    btnEseguiClick(Sender);
  finally
    GeneraPDF:=False;
  end;

  //verifico se procedere anche con l'achiviazione del pdf creato
  if chkArchiviaTabellone.Checked then
  begin
    if Parametri.ProgressivoOper = -1 then
      raise Exception.Create(Format(A000MSG_A058_ERR_FMT_GENERICO_ARCH, ['è richiesta l''associazione dell''operatore ad un''anagrafica']));
    DatiVariabili.Matricola:=Parametri.MatricolaOper;
    DatiVariabili.Progressivo:=Parametri.ProgressivoOper;
    DatiVariabili.CodFiscale:=Parametri.CodFiscaleOper;
    DatiVariabili.Dal:=StrToDateTime(edtDataDa.Text);

    //trovo il nome del file in base ai parametri nella configurazione
    if not A058DM.A210MW.CtrlFile(A058DM.selI210.FieldByName('FILE_PDF').AsString, DatiVariabili, NomeFile, ErrMsg) then
      raise Exception.Create(Format(A000MSG_A058_ERR_FMT_GENERICO_ARCH, [ErrMsg]));

    //trovo la tipologia (per verificare se è versionabile)
    A058DM.selT962.Close;
    A058DM.selT962.SetVariable('CODICE', A058DM.selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString);
    A058DM.selT962.Open;

    if A058DM.selT962.RecordCount < 1 then
      raise Exception.Create(Format(A000MSG_A058_ERR_FMT_NO_TIPOLOGIA, [A058DM.selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString]));

    if C021DM.CheckFileEsistente(Parametri.ProgressivoOper, TPath.GetFileNameWithoutExtension(NomeFile), 'PDF', A058DM.selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString) then
    begin
      if A058DM.selT962.FieldByName('VERSIONABILE').AsString = 'S' then
      begin
        MsgBox.WebMessageDlg(A000MSG_A058_DLG_NUOVA_VERSIONE, mtConfirmation, [mbYes, mbNo], ResultGeneraPDF, '');
        Exit;
      end
      else if A058DM.selI210.FieldByName('SOSTITUZIONE_FILE').AsString = 'S' then
      begin
        MsgBox.WebMessageDlg(A000MSG_A058_DLG_SOVRASCRIVI, mtConfirmation, [mbYes, mbNo], ResultGeneraPDF, '');
        Exit;
      end
      else
        raise Exception.Create(Format(A000MSG_A058_ERR_FMT_GENERICO_ARCH, ['documento già esistente, impossibile proseguire']));
    end;
  end;

  ResultGeneraPDF(Self, mrYes, '');
end;

procedure TWA058FTabelloneTurniFM.ResultGeneraPDF(Sender: TObject; R: TmeIWModalResult; KI: String);
var LResCtrl: TResCtrl;
begin
  if R = mrYes then
  begin
  {$IFDEF WEBPJ}
    //IrisCloud
    (Self.Parent as TWR100FBase).StartElaborazioneServer(btnGeneraPDF.HTMLName);
  {$ELSE}
    //IrisWeb
    LResCtrl:=ElaboraStampa;
    if LResCtrl.Ok then
      (Self.Parent as TWR010FBase).VisualizzaFileWeb
    else
      Msgbox.MessageBox(LResCtrl.Messaggio, ERRORE);
  {$ENDIF}
  end;
end;

function TWA058FTabelloneTurniFM.ElaboraStampa: TResCtrl;
var
  DettaglioLog:OleVariant;
  DatiUtente: String;
begin
  Result.Clear;
  //Chiamo Servizio COM B028 per creare il pdf su server
  with (Self.Parent as TWR010FBase) do
  begin
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
    DatiUtente:=CreateJSonString;

    if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
      CoInitialize(nil);
    if not DCOMConnection.Connected then
      DCOMConnection.Connected:=True;
    try
      A000SessioneWEB.AnnullaTimeOut;
      DCOMConnection.AppServer.PrintA058(WA058selAnagrafe.SubstitutedSQL,
                                         DCOMNomeFile,
                                         Parametri.Operatore,
                                         Parametri.Azienda,
                                         WR000DM.selAnagrafe.Session.LogonDataBase,
                                         DatiUtente,
                                         DettaglioLog);
    finally
      DCOMConnection.Connected:=False;
      A000SessioneWEB.RipristinaTimeOut;
    end;
  end;

  //Archiviazione del tabellone turni
  if chkArchiviaTabellone.Checked then
  begin
    if (A058DM.selI210.FieldByName('PATH_FILE').AsString.Trim <> '') and (A058DM.selI210.FieldByName('FILE_PDF').AsString.Trim <> '') then
    begin
      if PianifNonOperativa then
      begin
        if AbilitazioneA126 then
        begin
          if abilitaSblocca then
          begin
            Result:=SalvaSuGestioneDocumentale;
            Exit;
          end
          else
            Result.Messaggio:=Format(A000MSG_A058_ERR_FMT_GENERICO_ARCH, ['Pianificazione corrente non Bloccata']);
        end
        else
          Result.Messaggio:=Format(A000MSG_A058_ERR_FMT_GENERICO_ARCH, ['Operatore non abilitato al blocco della Pianificazione, oppure mese non intero']);
      end
      else
        Result.Messaggio:=Format(A000MSG_A058_ERR_FMT_GENERICO_ARCH, ['Pianificazione deve essere Non Operativa']);
    end
    else
      Result.Messaggio:=Format(A000MSG_A058_ERR_FMT_GENERICO_ARCH, ['Parametri di configurazione non presenti in <A210> Regole archiviazione documentale']);
  end
  else
    Result.Ok:=True;
end;

function TWA058FTabelloneTurniFM.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
  C190Comp2JsonString(edtDataDa,json);
  C190Comp2JsonString(edtDataA,json);
  C190Comp2JsonString(rgpTipo,json);
  C190Comp2JsonString(cmbSquadra,json,'dcmbsquadra');
  C190Comp2JsonString(chkIncludiDipCS,json);
  C190Comp2JsonString(cmbProfili,json,'dcmbProfili');
  Result:=json.ToString;
  FreeAndNil(json);
end;

function TWA058FTabelloneTurniFM.SalvaSuGestioneDocumentale: TResCtrl;
var IdT960: Integer;
    LDoc: TDocumento;
    ErrMsg, NomeFile: String;
    DatiVariabili: TDatiVariabili;
begin
  Result.Clear;
  try
    LDoc:=TDocumento.Create;
    try
      LDoc.Id:=0;
      LDoc.DataCreazione:=Now;
      LDoc.NomeUtente:=Parametri.Operatore;
      LDoc.Utente:='';
      LDoc.Progressivo:=Parametri.ProgressivoOper;
      LDoc.Tipologia:=A058DM.selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString;
      LDoc.Ufficio:='*';
      LDoc.ExtFile:='PDF';
      LDoc.TempFile:=(Self.Parent as TWR010FBase).DCOMNomeFile;
      LDoc.PeriodoDal:=StrToDateTime(edtDataDa.Text);
      LDoc.PeriodoAl:=StrToDateTime(edtDataA.Text);
      LDoc.Dimensione:=R180GetFileSize((Self.Parent as TWR010FBase).DCOMNomeFile);
      LDoc.CFFamiliare:='';
      LDoc.Note:='';
      LDOc.Provenienza:='I';
      LDoc.PathStorage:=A058DM.selI210.FieldByName('PATH_FILE').AsString;

      DatiVariabili.Matricola:=Parametri.MatricolaOper;
      DatiVariabili.Progressivo:=Parametri.ProgressivoOper;
      DatiVariabili.CodFiscale:=Parametri.CodFiscaleOper;
      DatiVariabili.Dal:=StrToDateTime(edtDataDa.Text);

      //trovo il nome del file in base ai parametri nella configurazione
      if A058DM.A210MW.CtrlFile(A058DM.selI210.FieldByName('FILE_PDF').AsString, DatiVariabili, NomeFile, ErrMsg) then
        LDoc.NomeFile:=NomeFile
      else
      begin
        Result.Messaggio:=ErrMsg;
        Exit;
      end;

      //trovo la tipologia (per verificare se è versionabile)
      A058DM.selT962.Close;
      A058DM.selT962.SetVariable('CODICE', A058DM.selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString);
      A058DM.selT962.Open;

      if A058DM.selT962.RecordCount < 1 then
      begin
        Result.Messaggio:=Format(A000MSG_A058_ERR_FMT_NO_TIPOLOGIA, [A058DM.selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString]);
        Exit;
      end;
      //salvo il tabellone sul documentale
      Result:=C021DM.Save(LDoc, A058DM.selI210.FieldByName('SOSTITUZIONE_FILE').AsString = 'S',
                                  A058DM.selT962.FieldByName('VERSIONABILE').AsString = 'S', False, IdT960);

      if not Result.Ok then
        Result.Messaggio:=Format(A000MSG_A058_ERR_FMT_GENERICO_ARCH,[Result.Messaggio]);
    finally
      FreeAndNil(LDoc);
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format(A000MSG_A058_ERR_FMT_GENERICO_ARCH,[E.Message]);
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.btnSalvaClick(Sender: TObject);
begin
  inherited;
  if (Parametri.CampiRiferimento.C11_PianifOrariProg = 'S') and (A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') then
  begin
    MsgBox.WebMessageDlg(A000MSG_A058_DLG_REG_PIANIF,mtConfirmation,[mbYes, mbNo],ResultRegistraTabellone,'');
    Exit;
  end;
  RegistraTabellone;
end;

procedure TWA058FTabelloneTurniFM.ResultRegistraTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    RegistraTabellone;
end;

procedure TWA058FTabelloneTurniFM.RegistraTabellone;
var
  i:Integer;
begin
  inherited;
  //selDatiBloccati.FileLog:='';
  RegistraMsg.IniziaMessaggio('WA058');
  A058DM.GeneraIniCorr:=chkIniCorr.Checked;
  //Scorro Vista (elenco dipendenti)
  for i:=0 to A058DM.Vista.Count - 1 do
  begin
    A058DM.EseguiPianificazione(i,-1);
  end;
  A058DM.A058PCKT080TURNO.CopiaTurnazione;
  A058DM.Vista.ResetModifica;
  ClientBtnSalvaVisibile:=False;
  Abilitazioni;
end;

procedure TWA058FTabelloneTurniFM.btnCancellaClick(Sender: TObject);
var
  MsgCanc:string;
begin
  inherited;
  MsgCanc:='';
  if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    MsgCanc:=A000MSG_A058_DLG_CANC_PIANIF_PROG
  else
    MsgCanc:=A000MSG_A058_DLG_CANC_PIANIF;
  MsgBox.WebMessageDlg(MsgCanc,mtConfirmation,[mbYes, mbNo],ResultCancellaTabellone,'');
end;

procedure TWA058FTabelloneTurniFM.ResultCancellaTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    CancellaTabellone;
end;

procedure TWA058FTabelloneTurniFM.CancellaTabellone;
var
  i:integer;
begin
  RegistraMsg.IniziaMessaggio('WA058');
  with A058DM do
  begin
    //Scorro Vista (elenco dipendenti)
    for i:=0 to Vista.Count - 1 do
      CancellaPianificazione(Vista[i].Prog);
  end;
  CaricaLista(False);
end;

procedure TWA058FTabelloneTurniFM.btnOperativaClick(Sender: TObject);
var
  i:Integer;
begin
  if A058DM.Vista.Modificato then
    raise exception.Create(A000MSG_A058_ERR_REGISTRA_MODIFICHE);
  if not MsgBox.KeyExists('BTNOPERATIVA') then
  begin
    MsgBox.WebMessageDlg(A000MSG_A058_DLG_RENDI_OPERATIVA,mtConfirmation,[mbYes, mbNo],ResultRendiOperativa,'BTNOPERATIVA');
    Abort;
  end;
  MsgBox.ClearKeys;
  with A058DM do
  begin
    //Scorro Vista (elenco dipendenti)
    for i:=0 to Vista.Count - 1 do
      RendiOperativa(i);
  end;
end;

procedure TWA058FTabelloneTurniFM.ResultRendiOperativa(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    btnOperativaClick(btnOperativa)
  else
    MsgBox.ClearKeys;
end;

procedure TWA058FTabelloneTurniFM.btnBloccaSbloccaClick(Sender: TObject);
var Operazione,dOperazione,MsgText:string; // 'B' Blocca; 'S' Sblocca
begin
  if Sender = btnBlocca then
  begin
    Operazione:='B';
    dOperazione:='BLOCCATI';
  end
  else
  begin
    Operazione:='S';
    dOperazione:='SBLOCCATI';
  end;

  MsgText:=Format(A000MSG_A058_DLG_BLOCCA_SBLOCCA,[dOperazione]);
  MsgBox.WebMessageDlg(MsgText,mtConfirmation,[mbYes, mbNo],ResultBloccaSblocca,Operazione);
end;

procedure TWA058FTabelloneTurniFM.ResultBloccaSblocca(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
var Operazione:string; // 'B' Blocca; 'S' Sblocca
    //abilitaBlocca,abilitaSblocca:Boolean;
begin
  try
    if Res = mrYes then
      begin
        if KeyID='B' then
          Operazione:='B'
        else
          Operazione:='S';

        A058DM.EseguiBloccaSblocca(Operazione);
        A058DM.AbilitaBloccaSblocca(abilitaBlocca,abilitaSblocca);

        btnBlocca.Enabled:=PianifNonOperativa and AbilitazioneA126 and abilitaBlocca;
        btnSblocca.Enabled:=PianifNonOperativa and AbilitazioneA126 and abilitaSblocca;
      end;
  finally
    MsgBox.ClearKeys;
  end;
end;

procedure TWA058FTabelloneTurniFM.CambioStatoVisDatiOpzionali(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  // CambioStatoVisDatiOpzionali() è richiamata per consentire ad IW di aggiornare lo stato dei controlli lato server
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA('modificaVisDatiOpzionali();');
end;

procedure TWA058FTabelloneTurniFM.CambiaStatoVisDatiOpzionaliReload(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  // CambiaStatoVisDatiOpzionaliReload() è richiamata per consentire ad IW di aggiornare lo stato dei controlli lato server
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA('distruggiERicaricaTabellone();');
end;

procedure TWA058FTabelloneTurniFM.btnRicercaAnomalieClick(Sender: TObject);
begin
  A058DM.ControlloAnnualeAnomalie:=chkElaborazioneAnnuale.Checked;
  A058DM.VerificaPianificazione(A058DM.DataInizio,A058DM.DataFine);
  WA058FElencoAnomalieFM:=TWA058FElencoAnomalieFM.Create(Self.Owner,A058DM);
  WA058FElencoAnomalieFM.Visualizza;
end;

procedure TWA058FTabelloneTurniFM.chkElaborazioneAnnualeAsyncChange(Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  // chkElaborazioneAnnualeAsyncChange() è richiamata per consentire ad IW di aggiornare lo stato dei controlli lato server
  i:=0;
end;

procedure TWA058FTabelloneTurniFM.btnFiltroAnomalieClick(Sender: TObject);
var
  ListaTipiAnomalie,ListaTipiAnomalieSel:TStringList;
  i:TTipiAnomalie;
begin
  inherited;
  ListaTipiAnomalie:=TStringList.Create;
  ListaTipiAnomalieSel:=TStringList.Create;
  ListaTipiAnomalieSel.StrictDelimiter:=True;
  try
    for i:=Low(TTipiAnomalie) to High(TTipiAnomalie) do
    begin
      ListaTipiAnomalie.Add(i.toString);
    end;
    ListaTipiAnomalieSel.CommaText:=A058DM.Vista.PropElencoAnomalie.GetAnomalieAttive;
    {$IFDEF WEBPJ} // In IrisCloud
    (Owner as TWA058FPianifTurni).VisualizzaDialogFiltroAnomalie(ListaTipiAnomalie,ListaTipiAnomalieSel);
    {$ELSE} // In IrisWeb
    (Owner as TW030FTabelloneTurni).VisualizzaDialogFiltroAnomalie(ListaTipiAnomalie,ListaTipiAnomalieSel);
    {$ENDIF}
  finally
    try FreeAndNil(ListaTipiAnomalie); except end;
    try FreeAndNil(ListaTipiAnomalieSel); except end;
  end;

end;

procedure TWA058FTabelloneTurniFM.ImpostaFiltroAnomalie(ListaTipiAnomalieSel:TStringList);
var
  j:Integer;
begin
  A058DM.Vista.PropElencoAnomalie.SetAnomalieAttive(ListaTipiAnomalieSel.CommaText);
  for j:=0 to A058DM.Vista.Count - 1 do
  begin
    A058DM.AnomalieXDipendente(A058DM.Vista[j]);
  end;
  A058DM.Vista.Controllo_TurnoAntincendio(A058DM.Vista[0].Giorni[0].Data,
                                          A058DM.Vista[0].Giorni[A058DM.Vista[0].Giorni.Count - 1].Data);
  A058DM.Vista.Controllo_Referente(A058DM.Vista[0].Giorni[0].Data,
                                   A058DM.Vista[0].Giorni[A058DM.Vista[0].Giorni.Count - 1].Data);
  btnFiltroAnomalie.Hint:=Format('Elenco anomalie attive: %s',[A058DM.Vista.PropElencoAnomalie.GetAnomalieAttive]);
end;

procedure TWA058FTabelloneTurniFM.btnChiudiClick(Sender: TObject);
begin
  if A058DM.Vista.Modificato then
    MsgBox.WebMessageDlg('Sono presenti modifiche non salvate. Procedendo tali modifiche andranno perse. Continuare?',
                         mtConfirmation,[mbYes,mbNo],OnChiudiDialogClick,'')
  else
  begin
    A058DM.PulisciVista;
    grdTabControl.ActiveTabIndex:=0;
  end;
end;

procedure TWA058FTabelloneTurniFM.OnChiudiDialogClick(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
begin
  if ModalResult = mrYes then
  begin
    A058DM.PulisciVista;
    grdTabControl.ActiveTabIndex:=0;
  end;
end;

procedure TWA058FTabelloneTurniFM.btnHdnCopiaPianifClick(Sender: TObject);
var
  i,RighePaginaTabella:Integer;
begin
  inherited;
  if WA058SolaLettura then
    raise Exception.Create('Funzione non disponibile in modalità di sola lettura.');
  RighePaginaTabella:=(Owner as TWR010FBase).GetRighePaginaTabella;
  try
    i:=StrToInt(edtHdnRigaSel.Text);
    if (StrToInt(edtHdnPaginaAttuale.Text) > 1) and (RighePaginaTabella > 0) then
      i:=i + RighePaginaTabella * (StrToInt(edtHdnPaginaAttuale.Text) - 1);
  except
    on E:EConvertError do
      raise Exception.Create('Parametro riga selezionata non valido');
  end;
  WA058FCopiaPianificazioneFM:=TWA058FCopiaPianificazioneFM.Create(Self.Owner);
  WA058FCopiaPianificazioneFM.WA058SelAnagrafe:=WA058SelAnagrafe;
  with WA058FCopiaPianificazioneFM do
  begin
    A058DettDM:=A058DM;
    WA058TabFM:=Self;
    CurrProg:=IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog);
    edtDataDa.Text:=DateToStr(A058DM.DataInizio);
    edtDataA.Text:=DateToStr(A058DM.DataFine);
    Visualizza;
  end;
end;

procedure TWA058FTabelloneTurniFM.btnHdnVisCompResAssClick(Sender: TObject);
var
  WC021FRiepilogoAssenzeFM: TWC021FRiepilogoAssenzeFM;
  i,j,RighePaginaTabella:Integer;
begin
  inherited;
  RighePaginaTabella:=(Owner as TWR010FBase).GetRighePaginaTabella;
  try
    i:=StrToInt(edtHdnRigaSel.Text);
    if (StrToInt(edtHdnPaginaAttuale.Text) > 1) and (RighePaginaTabella > 0) then
      i:=i + RighePaginaTabella * (StrToInt(edtHdnPaginaAttuale.Text) - 1);
    j:=StrToInt(edtHdnColonnaSel.Text) - NUM_COLONNE_FISSE;
  except
    on E:EConvertError do
      raise Exception.Create('Parametri riga e colonna selezionate non valido');
  end;

  if A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1 = '' then
  begin
    MsgBox.MessageBox('Nessun giustificativo di assenza trovato nel giorno corrente.',ESCLAMA);
    abort;
  end;

  WC021FRiepilogoAssenzeFM:=TWC021FRiepilogoAssenzeFM.Create(Self.Owner);
  WC021FRiepilogoAssenzeFM.VisualizzaFrame:=VisualizzaRiepilogo;
  WC021FRiepilogoAssenzeFM.CaricaDati(A058DM.Vista[i - NRIGHEBLOCCATE].Prog,
                                      A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1,
                                      A058DM.DataInizio + j, 0);
end;

procedure TWA058FTabelloneTurniFM.VisualizzaRiepilogo;
begin
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,770,-1,570, 'Riepilogo','#wc021_container',False,True);
end;

procedure TWA058FTabelloneTurniFM.btnHdnInsCancGiustifClick(Sender: TObject);
var
  Params, PCausale: String;
  i, j,RighePaginaTabella:Integer;
  {$IFNDEF WEBPJ}W008: TW008FGiustificativi;{$ENDIF}
begin
  inherited;
  RighePaginaTabella:=(Owner as TWR010FBase).GetRighePaginaTabella;
  {$IFDEF WEBPJ}
  if ((A000GetInibizioni('Funzione','OpenA004GiustifAssPres') = 'N') or
     ((A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString <> 'O') and not A058DM.AssenzeOperative)) then
  begin
    MsgBox.MessageBox(A000MSG_ERR_FUNZ_NON_ABILITATA,ERRORE);
    abort;
  end;
  {$ELSE}
  if ((A000GetInibizioni('Funzione','OpenW008Giustificativi') = 'N') or
     ((A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString <> 'O') and not A058DM.AssenzeOperative)) then
  begin
    MsgBox.MessageBox(A000MSG_ERR_FUNZ_NON_ABILITATA,ERRORE);
    abort;
  end;
  {$ENDIF}


  if A058DM.Vista.Modificato then
  begin
    MsgBox.MessageBox(A000MSG_A058_ERR_MODIFICHE_PENDENTI,ERRORE);
    Abort;
  end;

  try
    i:=StrToInt(edtHdnRigaSel.Text);
    if (StrToInt(edtHdnPaginaAttuale.Text) > 1) and (RighePaginaTabella > 0) then
      i:=i + RighePaginaTabella * (StrToInt(edtHdnPaginaAttuale.Text) - 1);
    j:=StrToInt(edtHdnColonnaSel.Text) - NUM_COLONNE_FISSE;
  except
    on E:EConvertError do
      raise Exception.Create('Parametro riga selezionata non valido');
  end;

  FNComp:='InsCancGiust'; // serve solo per determinare se è necessario effettuare il refresh
  PCausale:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1;
  if PCausale = '' then
    PCausale:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2;

  //Gestisco link a Giustificativi da Cloud/Web
  {$IFDEF WEBPJ}
    //IrisCloud
    Params:='PROGRESSIVO=' + IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog) + ParamDelimiter +
           'DATA=' + DateToStr(A058DM.DataInizio + j) + ParamDelimiter +
           'CAUSALE=' + PCausale + ParamDelimiter +
           'CARTEL=S';
    (Self.Parent as TWR100FBase).accediForm(2,Params);
  {$ELSE}
    //IrisWeb
    W008:=TW008FGiustificativi.Create(GGetWebApplicationThreadVar);
    W008.SetParam('CHIAMANTE','W030');
    W008.SetParam('PROGRESSIVO',IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog));
    W008.SetParam('DAL',DateToStr(A058DM.DataInizio + j));
    W008.SetParam('AL',DateToStr(A058DM.DataInizio + j));
    W008.OpenPage;
  {$ENDIF}
end;

procedure TWA058FTabelloneTurniFM.btnHdnPianifReperClick(Sender: TObject);
var
  Params, PCausale: String;
  i, j,RighePaginaTabella:Integer;
  {$IFNDEF WEBPJ}W004: TW004FReperibilita;{$ENDIF}
begin
  inherited;
  RighePaginaTabella:=(Owner as TWR010FBase).GetRighePaginaTabella;
  {$IFDEF WEBPJ}
  if (A000GetInibizioni('Funzione','OpenA040PianifRep') = 'N') then
  begin
    MsgBox.MessageBox(A000MSG_ERR_FUNZ_NON_ABILITATA,ERRORE);
    abort;
  end;
  {$ELSE}
  if (A000GetInibizioni('Funzione','OpenW004Reperibilita') = 'N') then
  begin
    MsgBox.MessageBox(A000MSG_ERR_FUNZ_NON_ABILITATA,ERRORE);
    abort;
  end;
  {$ENDIF}

   try
    i:=StrToInt(edtHdnRigaSel.Text);
    j:=StrToInt(edtHdnColonnaSel.Text) - NUM_COLONNE_FISSE;
    if (StrToInt(edtHdnPaginaAttuale.Text) > 1) and (RighePaginaTabella > 0) then
      i:=i + RighePaginaTabella * (StrToInt(edtHdnPaginaAttuale.Text) - 1);
  except
    on E:EConvertError do
      raise Exception.Create('Parametro riga selezionata non valido');
  end;

  FNComp:='PianifReper';
  PCausale:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1;
  if PCausale = '' then
      PCausale:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2;

  //Gestisco link a Giustificativi da Cloud/Web
  {$IFDEF WEBPJ}
    //IrisCloud
    Params:='PROGRESSIVO=' + IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog) + ParamDelimiter +
           'DATA=' + DateToStr(A058DM.DataInizio + j) + ParamDelimiter +
           'TIPOLOGIA=REPERIB';
    (Self.Parent as TWR100FBase).accediForm(16,Params,True);
  {$ELSE}
    //IrisWeb
    W004:=TW004FReperibilita.Create(GGetWebApplicationThreadVar);
    W004.SetParam('CHIAMANTE','W030');
    W004.SetParam('PROGRESSIVO',IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog));
    W004.SetParam('DAL',DateToStr(A058DM.DataInizio + j));
    W004.SetParam('AL',DateToStr(A058DM.DataFine + j));
    W004.OpenPage;
  {$ENDIF}
end;

procedure TWA058FTabelloneTurniFM.btnHdnEsportaExcelClick(Sender: TObject);
begin
  (Owner as TWR010FBase).InviaFile('pianificazione_turni.xls',A058DM.GetVistaInCSV(chkVisTabSint.Checked));
end;

procedure TWA058FTabelloneTurniFM.btnHdnVisProgresTurnClick(Sender: TObject);
var
  j:Integer;
  ParData: TDateTime;
  TitoloDialog:String;
begin
  try
    j:=StrToInt(edtHdnColonnaSel.Text) - NUM_COLONNE_FISSE;
  except
    on E:EConvertError do
      raise Exception.Create('Parametro colonna selezionata non valido');
  end;
  ParData:=A058DM.DataInizio + j;
  A058DM.EstraiTurnazioni(ParData);
  TitoloDialog:='Turnazioni riconosciute al ' + DateToStr(ParData);
  {$IFDEF WEBPJ} // In IrisCloud
  (Owner as TWA058FPianifTurni).VisualizzaDialogProgTurnazione(TitoloDialog,A058DM.cdsT611);
  {$ELSE} // In IrisWeb
  (Owner as TW030FTabelloneTurni).VisualizzaDialogProgTurnazione(TitoloDialog,A058DM.cdsT611);
  {$ENDIF}
end;

procedure TWA058FTabelloneTurniFM.GetDatiTabellaJQGrid(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
var
  DefinizColonneJSON,RigheTabellaJSON:TJSONArray;
  DefinizColonna: TColonna;
  DefinizColonne: TList<TColonna>;
  DefinizColonnaJSON,RigaJSON,DatiTabellaJSON,ClassiCelleTabellaJSON,ClassiCelleRigaJSON,RigaIntestazioneJSON,
    CelleEditabiliRigaJSON,CelleEditabiliTabellaJSON,TooltipCelleTabellaJSON,TooltipRigaJSON:TJSONObject;
  Successo:Boolean;
  strDDate,StrHTML,CaptionJqGrid,sDep,sDep2,CellTurn,CellSpanClass,CellTempColore:String;
  i,j,NGiorni:Integer;
  GGDate:TDate;
  EsitoEstrazione:TEsitoChiamataAJAX;
  DescSquadraRif:Variant;
  GetCellaUIOpzioni: TGetCellaUIOpzioni;
  procedure ValorizzaDefinizioniColonneJSON;
  var
    idxLista: Integer;
  begin
    for idxLista:=0 to (DefinizColonne.Count -  1) do
    begin
      DefinizColonnaJSON:=TJSONObject.Create;
      DefinizColonnaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('name', DefinizColonne[idxLista].Name));
      DefinizColonnaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('label',DefinizColonne[idxLista].TitleLabel));
      if DefinizColonne[idxLista].Key then
        DefinizColonnaJSON.AddPair('key', TJSONTrue.Create);
      DefinizColonnaJSON.AddPair('width', TJSONNumber.Create(DefinizColonne[idxLista].Width));
      DefinizColonnaJSON.AddPair('frozen', TGestoreChiamataAJAX.CreaJSONBoolean(DefinizColonne[idxLista].Frozen));
      DefinizColonnaJSON.AddPair('hidden', TGestoreChiamataAJAX.CreaJSONBoolean(DefinizColonne[idxLista].Hidden));
      DefinizColonnaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('medpClasseHeader',DefinizColonne[idxLista].ClassiHeader));
      DefinizColonnaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('classes', DefinizColonne[idxLista].Classes));
      DefinizColonnaJSON.AddPair('title', TGestoreChiamataAJAX.CreaJSONBoolean(false));
      DefinizColonneJSON.Add(DefinizColonnaJSON);
      DefinizColonnaJSON:=nil;
    end;
  end;
begin
  DefinizColonna:=nil;
  DefinizColonne:=TList<TColonna>.Create;
  DefinizColonneJSON:=TJSONArray.Create;
  RigheTabellaJSON:=TJSONArray.Create;
  DatiTabellaJSON:=nil;
  ClassiCelleTabellaJSON:=TJSONObject.Create;
  CelleEditabiliTabellaJSON:=TJSONObject.Create;
  TooltipCelleTabellaJSON:=TJSONObject.Create;
  RigaJSON:=nil;
  ClassiCelleRigaJSON:=nil;
  RigaIntestazioneJSON:=nil;
  TooltipRigaJSON:=nil;
  CaptionJqGrid:='';
  Successo:=true;
  try
    try
      if (A058DM.Vista.Count > 0) then
      begin
        DescSquadraRif:=A058DM.selT603.Lookup('CODICE',Trim(A058DM.SquadraRiferimento),'DESCRIZIONE');
        if A058DM.NuovaPianif then
          CaptionJqGrid:='Sviluppo pianificazione '
        else
          CaptionJqGrid:='Visualizzazione pianificazione ';
        if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
          CaptionJqGrid:=CaptionJqGrid + 'progressiva '
        else
          CaptionJqGrid:=CaptionJqGrid + 'statica ';
        if A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
          CaptionJqGrid:=CaptionJqGrid + 'operativa '
        else
        begin
          CaptionJqGrid:=CaptionJqGrid + 'non operativa ';
          if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
          begin
            if A058DM.TipoPianif = 0 then
              CaptionJqGrid:=CaptionJqGrid + 'iniziale'
            else
              CaptionJqGrid:=CaptionJqGrid + 'corrente';
          end;
        end;
        CaptionJqGrid:=CaptionJqGrid + Format(' dal %s al %s. Squadra: %s - %s',[DateToStr(A058DM.DataInizio),DateToStr(A058DM.DataFine),A058DM.SquadraRiferimento,DescSquadraRif]);

        // Definizione colonne fisse
        // - Matricola
        DefinizColonna:=TColonna.Create;
        DefinizColonna.Name:='MATRICOLA';
        DefinizColonna.TitleLabel:='Matricola';
        DefinizColonna.Key:=True;
        DefinizColonna.Width:=65;
        DefinizColonna.Frozen:=True;
        DefinizColonna.Hidden:=not chkVisMatricola.Checked;
        DefinizColonne.Add(DefinizColonna);
        DefinizColonna:=nil;
        // - Nominativo
        DefinizColonna:=TColonna.Create;
        DefinizColonna.Name:='NOMINATIVO';
        DefinizColonna.TitleLabel:='Cognome<br>Nome';
        DefinizColonna.Frozen:=True;
        DefinizColonna.Width:=85;
        DefinizColonne.Add(DefinizColonna);
        DefinizColonna:=nil;
        // - Situazione ore
        DefinizColonna:=TColonna.Create;
        DefinizColonna.Name:='SITUAZIONE_ORE';
        DefinizColonna.TitleLabel:='Situazione<br>ore';
        DefinizColonna.Frozen:=True;
        DefinizColonna.Hidden:=not chkVisSaldiOre.Checked;
        DefinizColonna.Width:=115;
        DefinizColonne.Add(DefinizColonna);
        DefinizColonna:=nil;
        // - Tot. turni
        DefinizColonna:=TColonna.Create;
        DefinizColonna.Name:='TOTTURNIDIP';
        DefinizColonna.TitleLabel:='Tot.<br>turni';
        DefinizColonna.Frozen:=True;
        DefinizColonna.Hidden:=not chkVisTotTurni.Checked;
        DefinizColonna.Width:=45;
        DefinizColonne.Add(DefinizColonna);
        DefinizColonna:=nil;
        // - Rip. / Fest. Lav.
        DefinizColonna:=TColonna.Create;
        DefinizColonna.Name:='RIP_FES_TLAV';
        DefinizColonna.TitleLabel:='Riposi<br>Fest.lavorate';
        DefinizColonna.Frozen:=True;
        DefinizColonna.Hidden:=not chkVisRiposi.Checked;
        DefinizColonna.Width:=105;
        DefinizColonne.Add(DefinizColonna);
        DefinizColonna:=nil;
        // Colonne giorni
        for i := 0 to Trunc(A058DM.DataFine - A058DM.DataInizio) do
        begin
          DefinizColonna:=TColonna.Create;
          DefinizColonna.Name:='GG' + IntToStr(i);
          GGDate:=A058DM.DataInizio + i;
          strDDate:=A058DM.GetTipoGiornoServizio(GGDate);
          if strDDate <> '' then
            strDDate:='(' + strDDate + ')';
          strDDate:=FormatDateTime('dd/mm', GGDate) + strDDate;
          strDDate:=strDDate + '<br>' + IfThen(chkVisTabSint.Checked,copy(R180NomeGiorno(GGDate),1,3),R180NomeGiorno(GGDate));
          DefinizColonna.TitleLabel:=strDDate;
          DefinizColonna.Width:=IfThen(chkVisTabSint.Checked, 57, 79);
          A058DM.GetCalend.SetVariable('PROG',A058DM.Vista[0].Prog);
          A058DM.GetCalend.SetVariable('D',GGDate);
          A058DM.GetCalend.Execute;
          if (DayOfWeek(GGDate) = 1) or (VarToStr(A058DM.GetCalend.GetVariable('F')) = 'S') then
          begin
            DefinizColonna.Classes:='sfondo_festivo bordo_festivo';
            DefinizColonna.ClassiHeader:='font_rosso';
          end;
          DefinizColonne.Add(DefinizColonna);
          DefinizColonna:=nil;
        end;

        GetCellaUIOpzioni:=[];
        if chkVisAssenzeMezzaGiorn.Checked then Include(GetCellaUIOpzioni,coIncludiAssMezzGior);
        if chkVisAssenzeAdOre.Checked then Include(GetCellaUIOpzioni,coIncludiAssOrarie);

        // Abilito i conteggi per la colonna "Saldi ore"
        if chkVisSaldiOre.Checked then
        begin
          A058DM.ConteggiaDebito:=True;
          NGiorni:=Trunc(A058DM.DataFine - A058DM.DataInizio);
          // Potrebbe essere necessario (ri)effettuare i calcoli per alcuni dipendenti.
          for i:=0 to A058DM.Vista.Count - 1 do
          begin
            if not A058DM.Vista[i].ConteggiSingoliGiorniAggiornati then
            begin
              for j:=0 to NGiorni do
                A058DM.ConteggiGiornalieri(A058DM.DataInizio + j,A058DM.Vista[i],A058DM.OffsetVista + j);
              A058DM.DebitoDipendente(A058DM.Vista[i],A058DM.OffsetVista,A058DM.OffsetVista + NGiorni);
            end;
          end;
        end
        else
        begin
          A058DM.ConteggiaDebito:=False; // Non saranno aggiornati i conteggi neanche durante la modifica dei turni
        end;

        // Valorizzo il contenuto della celle dei giorni
        for i:=0 to A058DM.Vista.Count - 1 do
        begin
          RigaJSON:=TJSONObject.Create;
          ClassiCelleRigaJSON:=TJSONObject.Create;
          CelleEditabiliRigaJSON:=TJSONObject.Create;
          ValorizzaJSONRiga(i, RigaJSON,ClassiCelleRigaJSON,CelleEditabiliRigaJSON,GetCellaUIOpzioni);
          RigheTabellaJSON.Add(RigaJSON);
          RigaJSON:=nil;
          ClassiCelleTabellaJSON.AddPair(A058DM.Vista[i].Matricola.Trim, ClassiCelleRigaJSON);
          ClassiCelleRigaJSON:=nil;
          CelleEditabiliTabellaJSON.AddPair(A058DM.Vista[i].Matricola.Trim, CelleEditabiliRigaJSON);
          CelleEditabiliRigaJSON:=nil;
          // Valorizzo le informazioni per i tooltip di questa riga
          TooltipRigaJSON:=TJSONObject.Create;
          TooltipRigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('OPER',A058DM.Vista[i].TipoOpe));
          ValorizzaJSONTooltipRiga(i, TooltipRigaJSON,GetCellaUIOpzioni);
          TooltipCelleTabellaJSON.AddPair(A058DM.Vista[i].Matricola.Trim, TooltipRigaJSON);
          TooltipRigaJSON:=nil;
        end;

        // Riga con i conteggi
        RigaIntestazioneJSON:=TJSONObject.Create;
        ValorizzaJSONRigaIntestazione(RigaIntestazioneJSON,A058DM.Vista[0].Squadra,A058DM.Vista[0].TipoOpe);

        // Valorizzo l'array JSON con la definizione delle colonne
        ValorizzaDefinizioniColonneJSON;
      end;
      // Valorizzo l'oggetto JSON di risposta
      DatiTabellaJSON:=TJSONObject.Create;
      DatiTabellaJSON.AddPair(TJSONPair.Create('caption', CaptionJqGrid));
      DatiTabellaJSON.AddPair('colonne',DefinizColonneJSON);
      DatiTabellaJSON.AddPair('righe',RigheTabellaJSON);
      DatiTabellaJSON.AddPair('classiCelle', ClassiCelleTabellaJSON);
      DatiTabellaJSON.AddPair('modificabilitaCelle',CelleEditabiliTabellaJSON);
      DatiTabellaJSON.AddPair('datiTooltip',TooltipCelleTabellaJSON);
      DatiTabellaJSON.AddPair('registrazioneVisibile', TGestoreChiamataAJAX.CreaJSONBoolean(Self.ClientBtnSalvaVisibile));
      DatiTabellaJSON.AddPair('registrazioneAbilitata', TGestoreChiamataAJAX.CreaJSONBoolean(btnSalva.Enabled));
      DatiTabellaJSON.AddPair('cancellazioneVisibile', TGestoreChiamataAJAX.CreaJSONBoolean(Self.ClientBtnCancellaVisibile));
      DatiTabellaJSON.AddPair('rendiOperativaVisibile', TGestoreChiamataAJAX.CreaJSONBoolean(Self.ClientBtnOperativaVisibile));
      DatiTabellaJSON.AddPair('bloccoVisibile', TGestoreChiamataAJAX.CreaJSONBoolean(Self.ClientBtnBloccaVisibile));
      DatiTabellaJSON.AddPair('sbloccoVisibile', TGestoreChiamataAJAX.CreaJSONBoolean(Self.ClientBtnSbloccaVisibile));

      if RigaIntestazioneJSON <> nil then
        DatiTabellaJSON.AddPair('intestazione', RigaIntestazioneJSON)
      else
        DatiTabellaJSON.AddPair('intestazione', TJSONNull.Create);

      if (A058DM.Vista.Count > 0) then
        TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(JSONOutput, DatiTabellaJSON)
      else
        TGestoreChiamataAJAX.ValorizzaRispostaAJAXWarning(JSONOutput, DatiTabellaJSON, ['Nessun dato da visualizzare.']);
    except
      on E:Exception do
      begin
        try FreeAndNil(JSONOutput); except end;
        JSONOutput:=TJSONObject.Create;
        TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput, ['Errore durante la conversione dei dati per il tabellone: ' + E.Message]);
        Successo:=false;
      end;
    end;
  finally
    for i:=(DefinizColonne.Count - 1) downto 0 do
    begin
      try if Assigned(DefinizColonne.Items[i]) then DefinizColonne.Items[i].Free; except end;
      DefinizColonne.Items[i]:=nil;
    end;
    FreeAndNil(DefinizColonne);

    if not Successo then
    begin
      if DefinizColonna <> nil then
        try FreeAndNil(DefinizColonna); except end;
      if DefinizColonnaJSON <> nil then
        try FreeAndNil(DefinizColonnaJSON); except end;
      if RigaJSON <> nil then
        try FreeAndNil(RigaJSON); except end;
      if ClassiCelleRigaJSON <> nil then
        try FreeAndNil(ClassiCelleRigaJSON); except end;
      if CelleEditabiliRigaJSON <> nil then
        try FreeAndNil(CelleEditabiliRigaJSON); except end;
      if TooltipRigaJSON <> nil then
        try FreeAndNil(TooltipRigaJSON); except end;
      if (DatiTabellaJSON <> nil) then
        try FreeAndNil(DatiTabellaJSON); except end;
      try FreeAndNil(DefinizColonneJSON); except end;
      try FreeAndNil(RigheTabellaJSON); except end;
      try FreeAndNil(ClassiCelleTabellaJSON); except end;
      try FreeAndNil(CelleEditabiliTabellaJSON); except end;
      try FreeAndNil(TooltipCelleTabellaJSON); except end;
      //if RigaIntestazioneJSON <> nil then
      try FreeAndNil(RigaIntestazioneJSON); except end;
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.GetDatiDialogModificaTurno(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
var
  i, j, Row, ComboBoxItemValue, CmbOrarioSelectedItem, CmbTurno1SelectedItem,
  CmbTurnoEU1SelectedItem, CmbTurno2SelectedItem,CmbTurnoEU2SelectedItem,ComboAss1SelectedItem,
  ComboAss2SelectedItem,CmbAreaSelectedItem:Integer;
  O, DialogCaptionTitolo:String;
  Successo,CmbAss1Enabled,CmbAss2Enabled, RiepBloccato:Boolean;
  JSONObjectInput, JSONDatiDialogModificaTurno, JSONComboOrarioItem, JSONComboAreaItem:TJSONObject;
  JSONComboOrarioItems,JSONComboTurnoItems, JSONComboTurnoEUItems, JSONComboAssItems,JSONComboAreaItems:TJSONArray;

    procedure CaricaTurnoEU(ListaItems:TJSONArray; var ValueSelComboT1EU:Integer; ValT1EU:String;
                            var ValueSelComboT2EU:Integer; ValT2EU:String);
    var
      JSONCaricaTurnoEUComboElem:TJSONObject;
    begin
      JSONCaricaTurnoEUComboElem:=nil;
      ValueSelComboT1EU:=0;
      ValueSelComboT2EU:=0;
      try
        JSONCaricaTurnoEUComboElem:=TJSONObject.Create;
        Self.ValorizzaItemComboJSON(JSONCaricaTurnoEUComboElem, -1, '');
        ListaItems.Add(JSONCaricaTurnoEUComboElem);
        JSONCaricaTurnoEUComboElem:=TJSONObject.Create;
        Self.ValorizzaItemComboJSON(JSONCaricaTurnoEUComboElem, 0, 'E');
        ListaItems.Add(JSONCaricaTurnoEUComboElem);
        JSONCaricaTurnoEUComboElem:=TJSONObject.Create;
        Self.ValorizzaItemComboJSON(JSONCaricaTurnoEUComboElem, 1, 'U');
        ListaItems.Add(JSONCaricaTurnoEUComboElem);
        JSONCaricaTurnoEUComboElem:=nil;

        ValueSelComboT1EU:=-1;
        if ValT1EU = 'E' then
          ValueSelComboT1EU:=0
        else if ValT1EU = 'U' then
          ValueSelComboT1EU:=1;

        ValueSelComboT2EU:=-1;
        if ValT2EU = 'E' then
          ValueSelComboT2EU:=0
        else if ValT2EU = 'U' then
          ValueSelComboT2EU:=1;
      finally
        if JSONCaricaTurnoEUComboElem <> nil then
          FreeAndNil(JSONCaricaTurnoEUComboElem);
      end;
    end;

    procedure CaricaAssenze(ListaItems:TJSONArray; var ValueSelComboAss1:Integer; ValAss1:String;
                            var ValueSelComboAss2:Integer; ValAss2:String);
    var
      ValueItemCombo:Integer;
      JSONComboAssenzeItem:TJSONObject;

      function CercaValueComboAssenzeJSON(JSONCombo: TJSONArray; Etichetta: String): Integer;
      var
        i:Integer;
        EtichettaElem:String;
        ValoreElem:Integer;
        Elem:TJSONObject;
      begin
        Result:=-1;
        if JSONCombo <> nil then
        begin
          for i:=0 to (JSONCombo.Count - 1) do
          begin
            Elem:=(JSONCombo.Items[i] as TJSONObject);
            EtichettaElem:=C190ConvertiInversoSimboliHtml((Elem.Get('label').JsonValue as TJSONString).Value);
            EtichettaElem:=Trim(Copy(EtichettaElem, 1, 5));
            ValoreElem:=StrToInt((Elem.Get('value').JsonValue as TJSONString).Value);
            if (EtichettaElem = Etichetta) then
            begin
              Result:=ValoreElem;
              break;
            end;
          end;
        end;
      end;
    begin
      JSONComboAssenzeItem:=nil;
      ValueItemCombo:=-1;
      try
        with A058DM do
        begin
          JSONComboAssenzeItem:=TJSONObject.Create;
          Self.ValorizzaItemComboJSON(JSONComboAssenzeItem, ValueItemCombo, '');
          ListaItems.Add(JSONComboAssenzeItem);
          inc(ValueItemCombo);
          JSONComboAssenzeItem:=nil;

          Q265.Filtered:=ValAss1 = '';
          Q265.First;
          Q265B.Filtered:=ValAss2 = '';
          Q265B.First;
          while not Q265.Eof do
          begin
            JSONComboAssenzeItem:=TJSONObject.Create;
            Self.ValorizzaItemComboJSON(JSONComboAssenzeItem, ValueItemCombo,Format('%-5s %s',[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('DESCRIZIONE').AsString]));
            ListaItems.Add(JSONComboAssenzeItem);
            inc(ValueItemCombo);
            JSONComboAssenzeItem:=nil;
            Q265.Next;
          end;
          { Imposto il value delle assenze già impostate. Se non trovo questa assenza (può capitare che non sia visibile
            con i filtri usati in WA058, ma che lo sia in A058), la aggiungo alla select e il value come selezionato.
            La select sarà comunque disabled in questi casi. }
          ValueSelComboAss1:=-1;
          if Trim(ValAss1) <> '' then
          begin
            ValueSelComboAss1:=CercaValueComboAssenzeJSON(ListaItems, Trim(ValAss1));
            if ValueSelComboAss1 = -1 then // valorizzato, ma non trovato nel nostro elenco
            begin
              Q265.Filtered:=False;
              Q265.Filter:=Format('CODICE = ''%s''',[Trim(ValAss1)]);
              Q265.Filtered:=True;
              if Q265.RecordCount = 1 then
              begin
                JSONComboAssenzeItem:=TJSONObject.Create;
                Self.ValorizzaItemComboJSON(JSONComboAssenzeItem, ValueItemCombo,Format('%-5s %s',[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('DESCRIZIONE').AsString]));
                ListaItems.Add(JSONComboAssenzeItem);
                ValueSelComboAss1:=ValueItemCombo;
                inc(ValueItemCombo);
                JSONComboAssenzeItem:=nil;
              end;
            end;
          end;

          ValueSelComboAss2:=-1;
          if Trim(ValAss2) <> '' then
          begin
            ValueSelComboAss2:=CercaValueComboAssenzeJSON(ListaItems, Trim(ValAss2));
            if ValueSelComboAss2 = -1 then // valorizzato, ma non trovato nel nostro elenco
            begin
              Q265.Filtered:=False;
              Q265.Filter:=Format('CODICE = ''%s''',[Trim(ValAss2)]);
              Q265.Filtered:=True;
              if Q265.RecordCount = 1 then
              begin
                JSONComboAssenzeItem:=TJSONObject.Create;
                Self.ValorizzaItemComboJSON(JSONComboAssenzeItem, ValueItemCombo,Format('%-5s %s',[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('DESCRIZIONE').AsString]));
                ListaItems.Add(JSONComboAssenzeItem);
                ValueSelComboAss2:=ValueItemCombo;
                inc(ValueItemCombo); // Non sarà più usato, mantenuto per eventuale uso futuro
                JSONComboAssenzeItem:=nil;
              end;
            end;
          end;
          Q265.Filtered:=False;
        end;
      finally
        A058DM.Q265.Filtered:=False;
        A058DM.Q265B.Filtered:=False;

        if JSONComboAssenzeItem <> nil then
          FreeAndNil(JSONComboAssenzeItem);
      end;
    end;
    function CercaValueComboOrarioJSON(JSONCombo: TJSONArray; Etichetta: String): Integer;
      var
        i:Integer;
        EtichettaElem:String;
        ValoreElem:Integer;
        Elem:TJSONObject;
      begin
        Result:=-1;
        if JSONCombo <> nil then
        begin
          for i:=0 to (JSONCombo.Count - 1) do
          begin
            Elem:=(JSONCombo.Items[i] as TJSONObject);
            EtichettaElem:=(Elem.Get('label').JsonValue as TJSONString).Value;
            EtichettaElem:=Trim(Copy(EtichettaElem, 1, 5));
            ValoreElem:=StrToInt((Elem.Get('value').JsonValue as TJSONString).Value);
            if (EtichettaElem = Etichetta) then
            begin
              Result:=ValoreElem;
              break;
            end;
          end;
        end;
      end;
    function CercaValueComboAreaJSON(JSONCombo: TJSONArray; Etichetta: String): Integer;
      var
        i:Integer;
        EtichettaElem:String;
        ValoreElem:Integer;
        Elem:TJSONObject;
      begin
        Result:=-1;
        if JSONCombo <> nil then
        begin
          for i:=0 to (JSONCombo.Count - 1) do
          begin
            Elem:=(JSONCombo.Items[i] as TJSONObject);
            EtichettaElem:=(Elem.Get('label').JsonValue as TJSONString).Value;
            EtichettaElem:=Trim(Copy(EtichettaElem, 1, 2));
            ValoreElem:=StrToInt((Elem.Get('value').JsonValue as TJSONString).Value);
            if (EtichettaElem = A058DM.GetSiglaArea(Etichetta)) then
            begin
              Result:=ValoreElem;
              break;
            end;
          end;
        end;
      end;

begin
  if (Parametri.A058_PianifOperativa = 'N') and (Parametri.CampiRiferimento.C11_PianifOrariProg = 'S') and
     (((RgpTipo.ItemIndex = 0) and (A058DM.selT082.FieldByName('GENERAZIONE').AsString = 'N')) or
     ((RgpTipo.ItemIndex = 0) and (A058DM.selT082.FieldByName('INIZIALE').AsString = 'N')) or
     ((RgpTipo.ItemIndex = 1) and (A058DM.selT082.FieldByName('CORRENTE').AsString = 'N'))) then
  begin
    TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,[A000MSG_ERR_FUNZ_NON_ABILITATA]);
    Exit;
  end;

  JSONDatiDialogModificaTurno:=TJSONObject.Create;
  JSONComboOrarioItems:=TJSONArray.Create;
  JSONComboTurnoItems:=TJSONArray.Create;
  JSONComboTurnoEUItems:=TJSONArray.Create;
  JSONComboAssItems:=TJSONArray.Create;
  JSONComboAreaItems:=TJSONArray.Create;
  Successo:=false;
  try
    try
      JSONObjectInput:=JSONInput as TJSONObject;
      i:=(JSONObjectInput.Get('rowNum').JsonValue as TJSONNumber).AsInt;
      j:=(JSONObjectInput.Get('colIdx').JsonValue as TJSONNumber).AsInt - NUM_COLONNE_FISSE;

      with A058DM do
      begin
        Row:=i-1;
        RiepBloccato:=PianifNonOperativa and PianifBloccata(Vista[Row].Prog,DataInizio + j);
        if RiepBloccato then
          raise exception.Create('Cella bloccata!');
      end;

      // Effettuo nuovamente il controllo anche lato server per sicurezza.
      if (btnSalva.Enabled and
        (A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Squadra = A058DM.SquadraRiferimento)) then
      begin
        with A058DM do
        begin
          O:=Vista[i - NRIGHEBLOCCATE].Giorni[j].Ora;
          ImpostaFiltroOrariSquadra(DataInizio + j);
          if (not A000FiltroDizionario('MODELLI ORARIO',O)) and (not O.IsEmpty)  then
          begin
            Q020.Filtered:=False;
            JSONDatiDialogModificaTurno.AddPair('cmbOrarioEnabled', TJSONFalse.Create);
          end
          else
          begin
            Q020.Filtered:=True;
            JSONDatiDialogModificaTurno.AddPair('cmbOrarioEnabled', TJSONTrue.Create);
          end;

          ComboBoxItemValue:=-1;
          JSONComboOrarioItem:=TJSONObject.Create;
          Self.ValorizzaItemComboJSON(JSONComboOrarioItem, ComboBoxItemValue, '');
          JSONComboOrarioItems.Add(JSONComboOrarioItem);
          inc(ComboBoxItemValue);
          JSONComboOrarioItem:=nil;
          Q020.First;
          while Not Q020.Eof do
          begin
            JSONComboOrarioItem:=TJSONObject.Create;
            Self.ValorizzaItemComboJSON(JSONComboOrarioItem, ComboBoxItemValue, Format('%-5s %s',[Q020.FieldByName('CODICE').AsString, AggiungiApice(Q020.FieldByName('DESCRIZIONE').AsString)]));
            JSONComboOrarioItems.Add(JSONComboOrarioItem);
            inc(ComboBoxItemValue);
            JSONComboOrarioItem:=nil;
            Q020.Next;
          end;
          CmbOrarioSelectedItem:=-1;
          if Vista[i - NRIGHEBLOCCATE].Giorni[j].Ora <> '' then
            CmbOrarioSelectedItem:=CercaValueComboOrarioJSON(JSONComboOrarioItems ,Vista[i - NRIGHEBLOCCATE].Giorni[j].Ora);

          Self.ValorizzaJSONTurno(JSONComboTurnoItems, Vista[i - NRIGHEBLOCCATE].Giorni[j].Ora, DataInizio + j, CmbTurno1SelectedItem, Vista[i - NRIGHEBLOCCATE].Giorni[j].T1,
                                  CmbTurno2SelectedItem, Vista[i - NRIGHEBLOCCATE].Giorni[j].T2);
          CaricaTurnoEU(JSONComboTurnoEUItems, CmbTurnoEU1SelectedItem, Vista[i - NRIGHEBLOCCATE].Giorni[j].T1EU,
                        CmbTurnoEU2SelectedItem, Vista[i - NRIGHEBLOCCATE].Giorni[j].T2EU);
          CaricaAssenze(JSONComboAssItems, ComboAss1SelectedItem, Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1,
                        ComboAss2SelectedItem, Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2);

          // gestisco combo Area
          GetAreeAfferenza(Vista[i - NRIGHEBLOCCATE].Giorni[j].Squadra,Vista[i - NRIGHEBLOCCATE].Giorni[j].Oper);
          if selT651.RecordCount>0 then
            JSONDatiDialogModificaTurno.AddPair('cmbAreaEnabled', TJSONTrue.Create)
          else
            JSONDatiDialogModificaTurno.AddPair('cmbAreaEnabled', TJSONFalse.Create);

          ComboBoxItemValue:=-1;
          JSONComboAreaItem:=TJSONObject.Create;
          Self.ValorizzaItemComboJSON(JSONComboAreaItem, ComboBoxItemValue, '');
          JSONComboAreaItems.Add(JSONComboAreaItem);
          inc(ComboBoxItemValue);
          JSONComboAreaItem:=nil;
          selT651.First;
          while Not selT651.Eof do
          begin
            JSONComboAreaItem:=TJSONObject.Create;
            Self.ValorizzaItemComboJSON(JSONComboAreaItem, ComboBoxItemValue, Format('%-2s (%-10s) %s',[selT651.FieldByName('SIGLA').AsString, selT651.FieldByName('CODICE_AREA').AsString, AggiungiApice(selT651.FieldByName('DESCRIZIONE').AsString)]));
            JSONComboAreaItems.Add(JSONComboAreaItem);
            inc(ComboBoxItemValue);
            JSONComboAreaItem:=nil;
            selT651.Next;
          end;
          CmbAreaSelectedItem:=-1;
          if Vista[i - NRIGHEBLOCCATE].Giorni[j].Area <> '' then
            CmbAreaSelectedItem:=CercaValueComboAreaJSON(JSONComboAreaItems ,Vista[i - NRIGHEBLOCCATE].Giorni[j].Area);
          // -------------------

          {$IFDEF WEBPJ}
          if (A000GetInibizioni('Funzione','OpenA004GiustifAssPres') <> 'S') and
             (A058DM.selT082.FieldByName('MODALITA_LAVORO').AsString <> 'N') then
          {$ELSE}
          if (A000GetInibizioni('Funzione','OpenW008Giustificativi') <> 'S') and
             (A058DM.selT082.FieldByName('MODALITA_LAVORO').AsString <> 'N') then
          {$ENDIF}
          begin
            CmbAss1Enabled:=False;
            CmbAss2Enabled:=False;
          end
          else
          begin
            CmbAss1Enabled:=Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1Modif;
            if Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1 <> '' then
              CmbAss1Enabled:=CmbAss1Enabled and
                              A000FiltroDizionario('CAUSALI ASSENZA', Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1);
            CmbAss2Enabled:=Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2Modif;
            if Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2 <> '' then
              CmbAss2Enabled:=CmbAss2Enabled and
                              A000FiltroDizionario('CAUSALI ASSENZA', Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2);
          end;
          JSONDatiDialogModificaTurno.AddPair('cmbAss1Enabled',TGestoreChiamataAJAX.CreaJSONBoolean(CmbAss1Enabled));
          JSONDatiDialogModificaTurno.AddPair('cmbAss2Enabled',TGestoreChiamataAJAX.CreaJSONBoolean(CmbAss2Enabled));

          DialogCaptionTitolo:=Vista[i - NRIGHEBLOCCATE].Cognome + ' ' + Vista[i - NRIGHEBLOCCATE].Nome +
                               ' (' + DateToStr(Vista[i - NRIGHEBLOCCATE].Giorni[j].Data) + ')';

          JSONDatiDialogModificaTurno.AddPair('cmbOrarioItems', JSONComboOrarioItems);
          JSONDatiDialogModificaTurno.AddPair('cmbOrarioSelectedItem', TJSONNumber.Create(CmbOrarioSelectedItem));

          JSONDatiDialogModificaTurno.AddPair('cmbTurnoItems', JSONComboTurnoItems);
          JSONDatiDialogModificaTurno.AddPair('cmbTurno1SelectedItem', TJSONNumber.Create(CmbTurno1SelectedItem));
          JSONDatiDialogModificaTurno.AddPair('cmbTurno2SelectedItem', TJSONNumber.Create(CmbTurno2SelectedItem));

          JSONDatiDialogModificaTurno.AddPair('cmbTurnoEUItems', JSONComboTurnoEUItems);
          JSONDatiDialogModificaTurno.AddPair('cmbTurnoEU1SelectedItem', TJSONNumber.Create(CmbTurnoEU1SelectedItem));
          JSONDatiDialogModificaTurno.AddPair('cmbTurnoEU2SelectedItem', TJSONNumber.Create(CmbTurnoEU2SelectedItem));

          JSONDatiDialogModificaTurno.AddPair('cmbAssItems', JSONComboAssItems);
          JSONDatiDialogModificaTurno.AddPair('cmbAss1SelectedItem', TJSONNumber.Create(ComboAss1SelectedItem));
          JSONDatiDialogModificaTurno.AddPair('cmbAss2SelectedItem', TJSONNumber.Create(ComboAss2SelectedItem));
          JSONDatiDialogModificaTurno.AddPair(TGestoreChiamataAJAX.CreaJSONPair('dialogCaptionTitolo', DialogCaptionTitolo));
          JSONDatiDialogModificaTurno.AddPair('indDipendente', TJSONNumber.Create(i - NRIGHEBLOCCATE));
          JSONDatiDialogModificaTurno.AddPair('indGiorno', TJSONNumber.Create(j));

          JSONDatiDialogModificaTurno.AddPair('cmbAreaItems', JSONComboAreaItems);
          JSONDatiDialogModificaTurno.AddPair('cmbAreaSelectedItem', TJSONNumber.Create(CmbAreaSelectedItem));

          JSONDatiDialogModificaTurno.AddPair('chkAntincendio', TGestoreChiamataAJAX.CreaJSONBoolean(Vista[i - NRIGHEBLOCCATE].Giorni[j].Antincendio = 'S'));
          JSONDatiDialogModificaTurno.AddPair('chkReferente', TGestoreChiamataAJAX.CreaJSONBoolean(Vista[i - NRIGHEBLOCCATE].Giorni[j].Referente = 'S'));
          JSONDatiDialogModificaTurno.AddPair('chkRichiestoDaTurnista', TGestoreChiamataAJAX.CreaJSONBoolean(Vista[i - NRIGHEBLOCCATE].Giorni[j].RichiestoDaTurnista = 'S'));
          JSONDatiDialogModificaTurno.AddPair(TGestoreChiamataAJAX.CreaJSONPair('memoNote', Vista[i - NRIGHEBLOCCATE].Giorni[j].Note));
          TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(JSONOutput, JSONDatiDialogModificaTurno);
          Successo:=true;
        end;
      end
      else
        TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,['Dato non modificabile.']);
    except
      on E:Exception do
      begin
        try FreeAndNil(JSONOutput); except end;
        JSONOutput:=TJSONObject.Create;
        TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,['Errore durante l''apertura del dettaglio turno: ' + E.Message]);
      end;
    end;
  finally
    if not Successo then
    begin
      try FreeAndNil(JSONDatiDialogModificaTurno); except end;
      try FreeAndNil(JSONComboOrarioItems); except end;
      if JSONComboOrarioItem <> nil then
        try FreeAndNil(JSONComboOrarioItem); except end;
      try FreeAndNil(JSONComboTurnoItems); except end;
      try FreeAndNil(JSONComboTurnoEUItems); except end;
      try FreeAndNil(JSONComboAssItems); except end;
      try FreeAndNil(JSONComboAreaItems); except end;
      if JSONComboAreaItem <> nil then
        try FreeAndNil(JSONComboAreaItem); except end;
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.GetDatiTurno(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
var
  IndGiorno, Dummy1, Dummy2:Integer;
  OrarioSel:String;
  JSONObjectInput:TJSONObject;
  JSONComboTurnoItems:TJSONArray;
  Successo:Boolean;
begin
  JSONObjectInput:=JSONInput as TJSONObject;
  try
    IndGiorno:=(JSONObjectInput.Get('indGiorno').JsonValue as TJSONNumber).AsInt;
    OrarioSel:=(JSONObjectInput.Get('orarioSel').JsonValue as TJSONString).Value;
  except
    on E:Exception do
    begin
      TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,['Errore durante l''elaborazione dei parametri in ingresso: ' + E.Message]);
      Exit;
    end;
  end;
  JSONComboTurnoItems:=TJSONArray.Create;
  Successo:=false;
  try
    try
      Self.ValorizzaJSONTurno(JSONComboTurnoItems, Trim(copy(OrarioSel,1,5)), A058DM.DataInizio + IndGiorno, Dummy1, '', Dummy2, '');
      TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(JSONOutput,JSONComboTurnoItems);
      Successo:=true;
    except
      on E:Exception do
      begin
        try FreeAndNil(JSONOutput); except end;
        JSONOutput:=TJSONObject.Create;
        TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,['Errore durante la lettura dei dati del turno: ' + E.Message]);
      end;
    end;
  finally
    if not Successo then
      try FreeAndNil(JSONComboTurnoItems); except end;
  end;
end;

procedure TWA058FTabelloneTurniFM.ConfermaDatiTurno(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
var
  IndDipendente,IndGiorno,i:Integer;
  CmbOrarioSelText,CmbTurno1SelText,CmbTurnoEU1SelText,CmbTurno2SelText,CmbTurnoEU2SelText,
  CmbAss1SelText,CmbAss2SelText,CmbAreaSelText,MemoNoteText:String;
  JSONObjectInput,DatiTabellaJSON,RigaJSON,ClassiCelleRigaJSON,CelleEditabiliRigaJSON,ClassiCelleTabellaJSON,CelleEditabiliTabellaJSON,
    TooltipRigaJSON,TooltipCelleTabellaJSON,RigaIntestazioneJSON:TJSONObject;
  RigheTabellaJSON:TJSONArray;
  Giorno:TGiorno;
  DCorr:TDateTime;
  ChkAntincendioValue,ChkReferenteValue,ChkRichiestoDaTurnistaValue,Success:Boolean;
  GetCellaUIOpzioni:TGetCellaUIOpzioni;

  function GiornoSignificativo(Caus:String):Boolean;
  var
    GS:String;
  begin
    GS:=VarToStr(A058DM.Q265.Lookup('CODICE',Caus,'GSIGNIFIC'));
    Result:=False;
    if GS = '' then
      exit;
    if (GS = 'GT') and (A058DM.Vista[IndDipendente].Giorni[IndGiorno].T1.Trim = '0') then
      exit;
    if (GS = 'GL') and (DayOfWeek(DCorr) in [1,7]) then
      exit;
    if (GS = 'G6') and (DayOfWeek(DCorr) in [1]) then
      exit;
    Result:=True;
  end;

begin
  try
    JSONObjectInput:=JSONInput as TJSONObject;
    IndDipendente:=(JSONObjectInput.Get('indDipendente').JsonValue as TJSONNumber).AsInt;
    IndGiorno:=(JSONObjectInput.Get('indGiorno').JsonValue as TJSONNumber).AsInt;
    CmbOrarioSelText:=(JSONObjectInput.Get('cmbOrario').JsonValue as TJSONString).Value;
    CmbTurno1SelText:=(JSONObjectInput.Get('cmbTurno1').JsonValue as TJSONString).Value;
    CmbTurno2SelText:=(JSONObjectInput.Get('cmbTurno2').JsonValue as TJSONString).Value;
    CmbTurnoEU1SelText:=(JSONObjectInput.Get('cmbTurnoEU1').JsonValue as TJSONString).Value;
    CmbTurnoEU2SelText:=(JSONObjectInput.Get('cmbTurnoEU2').JsonValue as TJSONString).Value;
    CmbAss1SelText:=(JSONObjectInput.Get('cmbAss1').JsonValue as TJSONString).Value;
    CmbAss2SelText:=(JSONObjectInput.Get('cmbAss2').JsonValue as TJSONString).Value;
    MemoNoteText:=(JSONObjectInput.Get('memoNote').JsonValue as TJSONString).Value;
    if JSONObjectInput.Get('cmbArea') <> nil then
      CmbAreaSelText:=(JSONObjectInput.Get('cmbArea').JsonValue as TJSONString).Value
    else
      CmbAreaSelText:='';
    ChkAntincendioValue:=(JSONObjectInput.Get('chkAntincendio').JsonValue is TJSONTrue);
    ChkReferenteValue:=(JSONObjectInput.Get('chkReferente').JsonValue is TJSONTrue);
    ChkRichiestoDaTurnistaValue:=(JSONObjectInput.Get('chkRichiestoDaTurnista').JsonValue is TJSONTrue);
    DCorr:=A058DM.DataInizio + IndGiorno;
    CmbOrarioSelText:=Trim(copy(CmbOrarioSelText,1,5));
    CmbTurno1SelText:=Trim(CmbTurno1SelText);
    CmbTurno2SelText:=Trim(CmbTurno2SelText);
    CmbAss1SelText:=Trim(copy(CmbAss1SelText,1,5));
    CmbAss2SelText:=Trim(copy(CmbAss2SelText,1,5));
    CmbAreaSelText:=Trim(copy(CmbAreaSelText,5,10)); // estraggo dal testo il codice area (pos 5 x 10 car)
  except
    on E:Exception do
    begin
      TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,['Errore durante l''elaborazione dei parametri in ingresso: ' + E.Message]);
      Exit;
    end;
  end;

  try
    // Validazione
    if (CmbTurno1SelText <> '') and (CmbTurno1SelText = CmbTurno2SelText) and (CmbTurnoEU1SelText = CmbTurnoEU2SelText) then
      //Non permetto i due turni uguali
      raise Exception.Create('Non si può pianificare 2 volte lo stesso turno!');
    if (CmbTurno1SelText = '') and (CmbTurno2SelText <> '') then
      //Non permetto di pianificare il secondo turno senza aver pianificato il primo
      raise Exception.Create('Non si può pianificare il secondo turno senza aver pianificato il primo!');
    if ((Trim(CmbTurnoEU1SelText) <> '') and (CmbTurnoEU1SelText <> 'E') and (CmbTurnoEU1SelText <> 'U') or
        (Trim(CmbTurnoEU2SelText) <> '') and (CmbTurnoEU2SelText <> 'E') and (CmbTurnoEU2SelText <> 'U')) then
      //Il tipo di turno può essere solo E od U
     raise Exception.Create('I valori ammessi sono solo E ed U!');
    //Controllo sul tipo cumulo se le assenze vengono registrate sulla tabella T040
    if ((A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058DM.AssenzeOperative) and
       (A058DM.Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> CmbAss1SelText) and (A058DM.R502ProDtM.ValStrT265[CmbAss1SelText,'TIPOCUMULO'] <> 'H') and
       (CmbAss1SelText <> '') then
      raise Exception.Create('Non è consentito specificare una causale che prevede delle regole di cumulo!');
    if ((A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058DM.AssenzeOperative) and
       (A058DM.Vista[IndDipendente].Giorni[IndGiorno].Ass2 <> CmbAss2SelText) and (A058DM.R502ProDtM.ValStrT265[CmbAss2SelText,'TIPOCUMULO'] <> 'H') and
       (CmbAss2SelText <> '') then
      raise Exception.Create('Non è consentito specificare una causale che prevede delle regole di cumulo!');
    if CmbTurno1SelText <> '' then
      CmbTurno1SelText:=IntToStr(StrToInt(Trim(Copy(CmbTurno1SelText,1,2))));
    if CmbTurno2SelText <> '' then
      CmbTurno2SelText:=IntToStr(StrToInt(Trim(Copy(CmbTurno2SelText,1,2))));
  except
    on E:Exception do
    begin
      TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput, E.Message);
      Exit;
    end;
  end;

  RigheTabellaJSON:=TJSONArray.Create;
  ClassiCelleTabellaJSON:=TJSONObject.Create;
  CelleEditabiliTabellaJSON:=TJSONObject.Create;
  TooltipCelleTabellaJSON:=TJSONObject.Create;
  DatiTabellaJSON:=nil;
  RigaIntestazioneJSON:=nil;
  Success:=false;
  try
    try
      with A058DM do
      begin
        LeggiValoriCella(IndDipendente,IndGiorno);
        Giorno:=Vista[IndDipendente].Giorni[IndGiorno];
        // Salvo i dati attuali, i primi sono usati nel controllo di eventuali modifiche
        xValoreOrigine.ParentDipendente:=Giorno.ParentDipendente;
        xValoreOrigine.Ora:=Giorno.Ora;
        xValoreOrigine.T1:=Giorno.T1;
        xValoreOrigine.T2:=Giorno.T2;
        xValoreOrigine.SiglaT1:=Giorno.SiglaT1;
        xValoreOrigine.NumTurno1:=Giorno.NumTurno1;
        xValoreOrigine.SiglaT2:=Giorno.SiglaT2;
        xValoreOrigine.NumTurno2:=Giorno.NumTurno2;
        xValoreOrigine.T1EU:=Giorno.T1EU;
        xValoreOrigine.T2EU:=Giorno.T2EU;
        xValoreOrigine.ValorGior:=Giorno.ValorGior;
        xValoreOrigine.Ass1:=Giorno.Ass1;
        xValoreOrigine.Ass2:=Giorno.Ass2;
        xValoreOrigine.Ass1Competenza:=Giorno.Ass1Competenza;
        xValoreOrigine.Ass2Competenza:=Giorno.Ass2Competenza;
        xValoreOrigine.Flag:=Giorno.Flag;
        xValoreOrigine.Squadra:=Giorno.Squadra;
        xValoreOrigine.DSquadra:=Giorno.DSquadra;
        xValoreOrigine.Oper:=Giorno.Oper;
        xValoreOrigine.Modificato:=Giorno.Modificato;
        xValoreOrigine.Note:=Giorno.Note;
        xValoreOrigine.Area:=Giorno.Area;
        xValoreOrigine.DArea:=Giorno.DArea;
        xValoreOrigine.Antincendio:=Giorno.Antincendio;
        xValoreOrigine.Referente:=Giorno.Referente;
        xValoreOrigine.RichiestoDaTurnista:=Giorno.RichiestoDaTurnista;

        if (CmbTurnoEU1SelText <> '') and
           ((CmbTurno1SelText = '') or (CmbTurno1SelText < '1') or (CmbTurno1SelText > '99')) then
          CmbTurnoEU1SelText:='';
         if (CmbTurnoEU2SelText <> '') and
           ((CmbTurno2SelText = '') or (CmbTurno2SelText < '1') or (CmbTurno2SelText > '99')) then
          CmbTurnoEU2SelText:='';
        //Modifico i dati in Vista. Giorno è una classe, sia dalla vista che con Giorno punto allo stesso oggetto
        Vista[IndDipendente].Giorni[IndGiorno].Antincendio:=IfThen(ChkAntincendioValue,'S','N');
        Vista[IndDipendente].Giorni[IndGiorno].Referente:=IfThen(ChkReferenteValue,'S','');
        Vista[IndDipendente].Giorni[IndGiorno].RichiestoDaTurnista:=IfThen(ChkRichiestoDaTurnistaValue,'S','');
        Vista[IndDipendente].Giorni[IndGiorno].Ora:=CmbOrarioSelText;
        Vista[IndDipendente].Giorni[IndGiorno].T1EU:=CmbTurnoEU1SelText;
        Vista[IndDipendente].Giorni[IndGiorno].T2EU:=CmbTurnoEU2SelText;
        Vista[IndDipendente].Giorni[IndGiorno].T1:=Format('%2s',[CmbTurno1SelText]);
        Vista[IndDipendente].Giorni[IndGiorno].T2:=Format('%2s',[CmbTurno2SelText]);
        if (Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> CmbAss1SelText) then
          Vista[IndDipendente].Giorni[IndGiorno].Ass1Competenza:=caPianificazione;
        if (Vista[IndDipendente].Giorni[IndGiorno].Ass2 <> CmbAss2SelText) then
          Vista[IndDipendente].Giorni[IndGiorno].Ass2Competenza:=caPianificazione;
        Vista[IndDipendente].Giorni[IndGiorno].Area:=CmbAreaSelText;
        Vista[IndDipendente].Giorni[IndGiorno].DArea:=ReperisciDArea(CmbAreaSelText);

        //Leggo la sigla dei turni, in più imposto le fasce d'orario
        {Come su WIN "Bruno: 31/10/2017"
        GetDatiTurno(Giorno);
        Vista[IndDipendente].Giorni[IndGiorno].SiglaT1:=Giorno.SiglaT1;
        Vista[IndDipendente].Giorni[IndGiorno].SiglaT2:=Giorno.SiglaT2;
        Vista[IndDipendente].Giorni[IndGiorno].NumTurno1:=Giorno.NumTurno1;}
        //Fine lettura sigla dei turni
        if (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) = '') and (CmbOrarioSelText <> '') then
          Vista[IndDipendente].Giorni[IndGiorno].T1:=' M';
        if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
        begin
          //Se è specificato solo l'orario senza turni imposto il turno a 'M'
          Vista[IndDipendente].Giorni[IndGiorno].ValorGior:='';
          Vista[IndDipendente].Giorni[IndGiorno].Ass1:=CmbAss1SelText;
          Vista[IndDipendente].Giorni[IndGiorno].Ass2:=CmbAss2SelText;
          if Vista[IndDipendente].Giorni[IndGiorno].Ass1 = '' then
          //Prima assenza nulla e seconda assenza valida
          begin
            Vista[IndDipendente].Giorni[IndGiorno].Ass1:=CmbAss2SelText;
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:='';
          end;
          //Se le 2 assenze sono uguali elimino la seconda
          if Vista[IndDipendente].Giorni[IndGiorno].Ass1 = Vista[IndDipendente].Giorni[IndGiorno].Ass2 then
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:='';
          //Se è specificata solo l'assenza imposto il turno ad 'A'
          if ((Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) = '') or (Vista[IndDipendente].Giorni[IndGiorno].T1 = ' M'))
            and (Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> '') then
              Vista[IndDipendente].Giorni[IndGiorno].T1:=' A';
          //Se è pianificato il turno ma manca l'orario lo ricerco nello storico
          if (CmbOrarioSelText = '') and (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) <> '') then
            Vista[IndDipendente].Giorni[IndGiorno].Ora:=GetOrarioStorico(DCorr,Vista[IndDipendente].Prog);
          {Come su WIN: "Bruno: 31/10/2017"
          if Giorno.T1 <> '' then}
          if not Vista[IndDipendente].Giorni[IndGiorno].T1.IsEmpty then
            Vista[IndDipendente].Giorni[IndGiorno].Flag:='M';
        end
        else
        begin
          if (CmbAss1SelText = '') or GiornoSignificativo(CmbAss1SelText) then
          begin
            if Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> CmbAss1SelText then
              Vista[IndDipendente].Giorni[IndGiorno].Modificato:=True;
            Vista[IndDipendente].Giorni[IndGiorno].Ass1:=CmbAss1SelText;
          end;
          if (CmbAss2SelText = '') or GiornoSignificativo(CmbAss2SelText) then
          begin
            if Vista[IndDipendente].Giorni[IndGiorno].Ass2 <> CmbAss2SelText then
              Vista[IndDipendente].Giorni[IndGiorno].Modificato:=True;
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:=CmbAss2SelText;
          end;
          if Vista[IndDipendente].Giorni[IndGiorno].Ass1 = '' then
          //Prima assenza nulla e seconda assenza valida
          begin
            Vista[IndDipendente].Giorni[IndGiorno].Ass1:=CmbAss2SelText;
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:='';
          end;
          //Se le 2 assenze sono uguali elimino la seconda
          if Vista[IndDipendente].Giorni[IndGiorno].Ass1 = Vista[IndDipendente].Giorni[IndGiorno].Ass2 then
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:='';
          //Se è specificata solo l'assenza imposto il turno ad 'A'
          if ((Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) = '') or (Vista[IndDipendente].Giorni[IndGiorno].T1 = ' M'))
            and (Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> '') then
              Vista[IndDipendente].Giorni[IndGiorno].T1:=' A';
        end;
        if (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) < '1') or (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) > '99') then
          Vista[IndDipendente].Giorni[IndGiorno].T1EU:='';
        if (Trim(Vista[IndDipendente].Giorni[IndGiorno].T2) < '1') or (Trim(Vista[IndDipendente].Giorni[IndGiorno].T2) > '99') then
          Vista[IndDipendente].Giorni[IndGiorno].T2EU:='';
        if (CmbOrarioSelText = '') and (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) <> '') then
          Vista[IndDipendente].Giorni[IndGiorno].Ora:=A058DM.GetOrarioStorico(DCorr, Vista[IndDipendente].Prog);
        {Come su WIN "Bruno: 31/10/2017"
        if Giorno.T1 <> '' then}
        if not  Vista[IndDipendente].Giorni[IndGiorno].T1.IsEmpty then
          Vista[IndDipendente].Giorni[IndGiorno].Flag:='M';
        // Le note vanno impostate sono se il modello orario è diverso da stringa vuota. In caso contrario le svuoto.
        if Vista[IndDipendente].Giorni[IndGiorno].Ora <> '' then
          Vista[IndDipendente].Giorni[IndGiorno].Note:=MemoNoteText.Trim
        else
          Vista[IndDipendente].Giorni[IndGiorno].Note:='';
        if (xValoreOrigine.T1 <> Vista[IndDipendente].Giorni[IndGiorno].T1) or
           (xValoreOrigine.T2 <> Vista[IndDipendente].Giorni[IndGiorno].T2) or
           (xValoreOrigine.SiglaT1 <> Vista[IndDipendente].Giorni[IndGiorno].SiglaT1) or
           (xValoreOrigine.SiglaT2 <> Vista[IndDipendente].Giorni[IndGiorno].SiglaT2) or
           (xValoreOrigine.T1EU <> Vista[IndDipendente].Giorni[IndGiorno].T1EU) or
           (xValoreOrigine.T2EU <> Vista[IndDipendente].Giorni[IndGiorno].T2EU) or
           (xValoreOrigine.Ora <> Vista[IndDipendente].Giorni[IndGiorno].Ora) or
           (xValoreOrigine.ValorGior <> Vista[IndDipendente].Giorni[IndGiorno].ValorGior) or
           (xValoreOrigine.Ass1 <> Vista[IndDipendente].Giorni[IndGiorno].Ass1) or
           (xValoreOrigine.Ass2 <> Vista[IndDipendente].Giorni[IndGiorno].Ass2) or
           (xValoreOrigine.Flag <> Vista[IndDipendente].Giorni[IndGiorno].Flag) or
           (xValoreOrigine.Squadra <> Vista[IndDipendente].Giorni[IndGiorno].Squadra) or
           (xValoreOrigine.DSquadra <> Vista[IndDipendente].Giorni[IndGiorno].DSquadra) or
           (xValoreOrigine.Oper <> Vista[IndDipendente].Giorni[IndGiorno].Oper) or
           (xValoreOrigine.Note <> Vista[IndDipendente].Giorni[IndGiorno].Note) or
           (xValoreOrigine.Area <> Vista[IndDipendente].Giorni[IndGiorno].Area) or
           (xValoreOrigine.Antincendio <> Vista[IndDipendente].Giorni[IndGiorno].Antincendio) or
           (xValoreOrigine.Referente <> Vista[IndDipendente].Giorni[IndGiorno].Referente) or
           (xValoreOrigine.RichiestoDaTurnista <> Vista[IndDipendente].Giorni[IndGiorno].RichiestoDaTurnista) then
        begin
          Vista[IndDipendente].Giorni[IndGiorno].Modificato:=True; //Setto il flag che indica che la cella è stata modificata
        end;
        AnomalieXDipendente(Vista[IndDipendente]);
	      Vista.Controllo_TurnoAntincendio(Vista[IndDipendente].Giorni[IndGiorno].Data,
                                         Vista[IndDipendente].Giorni[IndGiorno].Data);
        Vista.Controllo_Referente(Vista[IndDipendente].Giorni[IndGiorno].Data,
                                  Vista[IndDipendente].Giorni[IndGiorno].Data);
        ConteggiGiornalieri(DCorr,Vista[IndDipendente],IndGiorno);
        DebitoDipendente(Vista[IndDipendente],0,Trunc(DataFine - DataInizio));
        AggiornaContatoriTurni(IndDipendente,IndGiorno);
      end;

      // Genero i JSON con l'intero contenuto della griglia
      GetCellaUIOpzioni:=[];
      if chkVisAssenzeMezzaGiorn.Checked then Include(GetCellaUIOpzioni,coIncludiAssMezzGior);
      if chkVisAssenzeAdOre.Checked then Include(GetCellaUIOpzioni,coIncludiAssOrarie);
      // Valorizzo il contenuto della celle dei giorni
      for i:=0 to A058DM.Vista.Count - 1 do
      begin
        RigaJSON:=TJSONObject.Create;
        ClassiCelleRigaJSON:=TJSONObject.Create;
        CelleEditabiliRigaJSON:=TJSONObject.Create;
        ValorizzaJSONRiga(i, RigaJSON,ClassiCelleRigaJSON,CelleEditabiliRigaJSON,GetCellaUIOpzioni);
        RigheTabellaJSON.Add(RigaJSON);
        RigaJSON:=nil;
        ClassiCelleTabellaJSON.AddPair(A058DM.Vista[i].Matricola.Trim, ClassiCelleRigaJSON);
        ClassiCelleRigaJSON:=nil;
        CelleEditabiliTabellaJSON.AddPair(A058DM.Vista[i].Matricola.Trim, CelleEditabiliRigaJSON);
        CelleEditabiliRigaJSON:=nil;
        // Valorizzo le informazioni per i tooltip di questa riga
        TooltipRigaJSON:=TJSONObject.Create;
        TooltipRigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('OPER',A058DM.Vista[i].TipoOpe));
        ValorizzaJSONTooltipRiga(i, TooltipRigaJSON,GetCellaUIOpzioni);
        TooltipCelleTabellaJSON.AddPair(A058DM.Vista[i].Matricola.Trim, TooltipRigaJSON);
        TooltipRigaJSON:=nil;
      end;

      if chkVisRigaTurni.Checked then
      begin
        // Se richiesta la riga di intestazione la aggiungo come oggetto a parte
        RigaIntestazioneJSON:=TJSONObject.Create;
        ValorizzaJSONRigaIntestazione(RigaIntestazioneJSON,A058DM.Vista[IndDipendente].Squadra,A058DM.Vista[IndDipendente].TipoOpe);
      end;

      ClientBtnSalvaVisibile:=true;

      DatiTabellaJSON:=TJSONObject.Create;
      DatiTabellaJSON.AddPair('righe',RigheTabellaJSON);
      DatiTabellaJSON.AddPair('classiCelle', ClassiCelleTabellaJSON);
      DatiTabellaJSON.AddPair('modificabilitaCelle',CelleEditabiliTabellaJSON);
      DatiTabellaJSON.AddPair('datiTooltip',TooltipCelleTabellaJSON);
      DatiTabellaJSON.AddPair('registrazioneVisibile', TGestoreChiamataAJAX.CreaJSONBoolean(ClientBtnSalvaVisibile));
      if RigaIntestazioneJSON <> nil then
        DatiTabellaJSON.AddPair('intestazione', RigaIntestazioneJSON)
      else
        DatiTabellaJSON.AddPair('intestazione', TJSONNull.Create);

      TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(JSONOutput,DatiTabellaJSON);
      Success:=true;
    except
      on E:Exception do
        begin
          try FreeAndNil(JSONOutput); except end;
          JSONOutput:=TJSONObject.Create;
          TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,['Errore durante l''aggiornamento del tabellone ' + E.Message]);
        end;
    end;
  finally
    if not Success then // errore
    begin
      if RigaJSON <> nil then
        try FreeAndNil(RigaJSON); except end;
      if ClassiCelleRigaJSON <> nil then
        try FreeAndNil(ClassiCelleRigaJSON); except end;
      if CelleEditabiliRigaJSON <> nil then
        try FreeAndNil(CelleEditabiliRigaJSON); except end;
      if TooltipRigaJSON <> nil then
        try FreeAndNil(TooltipRigaJSON); except end;
      try FreeAndNil(ClassiCelleTabellaJSON); except end;
      try FreeAndNil(CelleEditabiliTabellaJSON); except end;
      try FreeAndNil(TooltipCelleTabellaJSON); except end;
      if RigaIntestazioneJSON <> nil then
        try FreeAndNil(RigaIntestazioneJSON); except end;
      try FreeAndNil(RigheTabellaJSON); except end;
      if DatiTabellaJSON <> nil then
        try FreeAndNil(DatiTabellaJSON); except end;
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.ConfermaDatiTurnoRapido(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
var
  i,j,numTurno,Row:Integer;
  RiepBloccato:Boolean;
  IndDipendente,IndGiorno:Integer;
  CmbOrarioSelText,CmbTurno1SelText,CmbTurnoEU1SelText,CmbTurno2SelText,CmbTurnoEU2SelText,
  CmbAss1SelText,CmbAss2SelText,CmbAreaSelText,MemoNoteText:String;
  JSONObjectInput,DatiTabellaJSON,RigaJSON,ClassiCelleRigaJSON,CelleEditabiliRigaJSON,ClassiCelleTabellaJSON,CelleEditabiliTabellaJSON,
    TooltipRigaJSON,TooltipCelleTabellaJSON,RigaIntestazioneJSON:TJSONObject;
  RigheTabellaJSON:TJSONArray;
  Giorno:TGiorno;
  DCorr:TDateTime;
  ChkAntincendioValue,ChkReferenteValue,ChkRichiestoDaTurnistaValue,Success:Boolean;
  GetCellaUIOpzioni:TGetCellaUIOpzioni;

  function GiornoSignificativo(Caus:String):Boolean;
  var
    GS:String;
  begin
    GS:=VarToStr(A058DM.Q265.Lookup('CODICE',Caus,'GSIGNIFIC'));
    Result:=False;
    if GS = '' then
      exit;
    if (GS = 'GT') and (A058DM.Vista[IndDipendente].Giorni[IndGiorno].T1.Trim = '0') then
      exit;
    if (GS = 'GL') and (DayOfWeek(DCorr) in [1,7]) then
      exit;
    if (GS = 'G6') and (DayOfWeek(DCorr) in [1]) then
      exit;
    Result:=True;
  end;

begin
  if (Parametri.A058_PianifOperativa = 'N') and (Parametri.CampiRiferimento.C11_PianifOrariProg = 'S') and
     (((RgpTipo.ItemIndex = 0) and (A058DM.selT082.FieldByName('GENERAZIONE').AsString = 'N')) or
     ((RgpTipo.ItemIndex = 0) and (A058DM.selT082.FieldByName('INIZIALE').AsString = 'N')) or
     ((RgpTipo.ItemIndex = 1) and (A058DM.selT082.FieldByName('CORRENTE').AsString = 'N'))) then
  begin
    TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,[A000MSG_ERR_FUNZ_NON_ABILITATA]);
    Exit;
  end;

  try
    JSONObjectInput:=JSONInput as TJSONObject;
    i:=(JSONObjectInput.Get('rowNum').JsonValue as TJSONNumber).AsInt;
    j:=(JSONObjectInput.Get('colIdx').JsonValue as TJSONNumber).AsInt - NUM_COLONNE_FISSE;
    numTurno:=(JSONObjectInput.Get('numTurno').JsonValue as TJSONNumber).AsInt;

    Row:=i-1;
    RiepBloccato:=PianifNonOperativa and A058DM.PianifBloccata(A058DM.Vista[Row].Prog,A058DM.DataInizio + j);
    if RiepBloccato then
      raise exception.Create('Cella bloccata!');

    // Effettuo nuovamente il controllo anche lato server per sicurezza.
    if not (btnSalva.Enabled and (A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Squadra = A058DM.SquadraRiferimento)) then
    begin
      TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,['Dato non modificabile.']);
      exit;
    end;

    if numTurno = -1 then
      CmbTurno1SelText:=''
    else
    begin
      CmbOrarioSelText:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ora;
      if Trim(CmbOrarioSelText) <> '' then
      begin
        A058DM.RefreshQ021(A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Data);
        A058DM.Q021.Filter:='CODICE = ''' + CmbOrarioSelText + '''';
        A058DM.Q021.Filtered:=True;
        if numTurno <= A058DM.Q021.RecordCount then
          CmbTurno1SelText:=numTurno.ToString;
      end
      else
        CmbTurno1SelText:=numTurno.ToString;
    end;

    IndDipendente:=i - NRIGHEBLOCCATE;
    IndGiorno:=j;
    DCorr:=A058DM.DataInizio + IndGiorno;
    CmbOrarioSelText:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ora;
    CmbTurno2SelText:=Trim(A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].T2);
    CmbTurnoEU1SelText:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].T1EU;
    CmbTurnoEU2SelText:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].T2EU;
    CmbAss1SelText:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1;
    CmbAss2SelText:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2;
    MemoNoteText:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Note;
    CmbAreaSelText:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Area;
    ChkAntincendioValue:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Antincendio = 'S';
    ChkReferenteValue:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Referente = 'S';
    ChkRichiestoDaTurnistaValue:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].RichiestoDaTurnista = 'S';
  except
    on E:Exception do
    begin
      TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,['Errore durante l''elaborazione dei parametri in ingresso: ' + E.Message]);
      Exit;
    end;
  end;

  try
    // Validazione
    if (CmbTurno1SelText <> '') and (CmbTurno1SelText = CmbTurno2SelText) and (CmbTurnoEU1SelText = CmbTurnoEU2SelText) then
      //Non permetto i due turni uguali
      raise Exception.Create('Non si può pianificare 2 volte lo stesso turno!');
    if (CmbTurno1SelText = '') and (CmbTurno2SelText <> '') then
      //Non permetto di pianificare il secondo turno senza aver pianificato il primo
      raise Exception.Create('Non si può pianificare il secondo turno senza aver pianificato il primo!');
    if ((Trim(CmbTurnoEU1SelText) <> '') and (CmbTurnoEU1SelText <> 'E') and (CmbTurnoEU1SelText <> 'U') or
        (Trim(CmbTurnoEU2SelText) <> '') and (CmbTurnoEU2SelText <> 'E') and (CmbTurnoEU2SelText <> 'U')) then
      //Il tipo di turno può essere solo E od U
     raise Exception.Create('I valori ammessi sono solo E ed U!');
    //Controllo sul tipo cumulo se le assenze vengono registrate sulla tabella T040
    if ((A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058DM.AssenzeOperative) and
       (A058DM.Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> CmbAss1SelText) and (A058DM.R502ProDtM.ValStrT265[CmbAss1SelText,'TIPOCUMULO'] <> 'H') and
       (CmbAss1SelText <> '') then
      raise Exception.Create('Non è consentito specificare una causale che prevede delle regole di cumulo!');
    if ((A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058DM.AssenzeOperative) and
       (A058DM.Vista[IndDipendente].Giorni[IndGiorno].Ass2 <> CmbAss2SelText) and (A058DM.R502ProDtM.ValStrT265[CmbAss2SelText,'TIPOCUMULO'] <> 'H') and
       (CmbAss2SelText <> '') then
      raise Exception.Create('Non è consentito specificare una causale che prevede delle regole di cumulo!');
  except
    on E:Exception do
    begin
      TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput, E.Message);
      Exit;
    end;
  end;

  RigheTabellaJSON:=TJSONArray.Create;
  ClassiCelleTabellaJSON:=TJSONObject.Create;
  CelleEditabiliTabellaJSON:=TJSONObject.Create;
  TooltipCelleTabellaJSON:=TJSONObject.Create;
  DatiTabellaJSON:=nil;
  RigaIntestazioneJSON:=nil;
  Success:=false;
  try
    try
      with A058DM do
      begin
        LeggiValoriCella(IndDipendente,IndGiorno);
        Giorno:=Vista[IndDipendente].Giorni[IndGiorno];
        // Salvo i dati attuali, i primi sono usati nel controllo di eventuali modifiche
        xValoreOrigine.ParentDipendente:=Giorno.ParentDipendente;
        xValoreOrigine.Ora:=Giorno.Ora;
        xValoreOrigine.T1:=Giorno.T1;
        xValoreOrigine.T2:=Giorno.T2;
        xValoreOrigine.SiglaT1:=Giorno.SiglaT1;
        xValoreOrigine.NumTurno1:=Giorno.NumTurno1;
        xValoreOrigine.SiglaT2:=Giorno.SiglaT2;
        xValoreOrigine.NumTurno2:=Giorno.NumTurno2;
        xValoreOrigine.T1EU:=Giorno.T1EU;
        xValoreOrigine.T2EU:=Giorno.T2EU;
        xValoreOrigine.ValorGior:=Giorno.ValorGior;
        xValoreOrigine.Ass1:=Giorno.Ass1;
        xValoreOrigine.Ass2:=Giorno.Ass2;
        xValoreOrigine.Ass1Competenza:=Giorno.Ass1Competenza;
        xValoreOrigine.Ass2Competenza:=Giorno.Ass2Competenza;
        xValoreOrigine.Flag:=Giorno.Flag;
        xValoreOrigine.Squadra:=Giorno.Squadra;
        xValoreOrigine.DSquadra:=Giorno.DSquadra;
        xValoreOrigine.Oper:=Giorno.Oper;
        xValoreOrigine.Modificato:=Giorno.Modificato;
        xValoreOrigine.Note:=Giorno.Note;
        xValoreOrigine.Area:=Giorno.Area;
        xValoreOrigine.DArea:=Giorno.DArea;
        xValoreOrigine.Antincendio:=Giorno.Antincendio;
        xValoreOrigine.Referente:=Giorno.Referente;
        xValoreOrigine.RichiestoDaTurnista:=Giorno.RichiestoDaTurnista;

        if (CmbTurnoEU1SelText <> '') and
           ((CmbTurno1SelText = '') or (CmbTurno1SelText < '1') or (CmbTurno1SelText > '99')) then
          CmbTurnoEU1SelText:='';
         if (CmbTurnoEU2SelText <> '') and
           ((CmbTurno2SelText = '') or (CmbTurno2SelText < '1') or (CmbTurno2SelText > '99')) then
          CmbTurnoEU2SelText:='';
        //Modifico i dati in Vista. Giorno è una classe, sia dalla vista che con Giorno punto allo stesso oggetto
        Vista[IndDipendente].Giorni[IndGiorno].Antincendio:=IfThen(ChkAntincendioValue,'S','N');
        Vista[IndDipendente].Giorni[IndGiorno].Referente:=IfThen(ChkReferenteValue,'S','');
        Vista[IndDipendente].Giorni[IndGiorno].RichiestoDaTurnista:=IfThen(ChkRichiestoDaTurnistaValue,'S','');
        Vista[IndDipendente].Giorni[IndGiorno].Ora:=CmbOrarioSelText;
        Vista[IndDipendente].Giorni[IndGiorno].T1EU:=CmbTurnoEU1SelText;
        Vista[IndDipendente].Giorni[IndGiorno].T2EU:=CmbTurnoEU2SelText;
        Vista[IndDipendente].Giorni[IndGiorno].T1:=Format('%2s',[CmbTurno1SelText]);
        Vista[IndDipendente].Giorni[IndGiorno].T2:=Format('%2s',[CmbTurno2SelText]);
        if (Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> CmbAss1SelText) then
          Vista[IndDipendente].Giorni[IndGiorno].Ass1Competenza:=caPianificazione;
        if (Vista[IndDipendente].Giorni[IndGiorno].Ass2 <> CmbAss2SelText) then
          Vista[IndDipendente].Giorni[IndGiorno].Ass2Competenza:=caPianificazione;
        Vista[IndDipendente].Giorni[IndGiorno].Area:=CmbAreaSelText;
        Vista[IndDipendente].Giorni[IndGiorno].DArea:=ReperisciDArea(CmbAreaSelText);

        //Leggo la sigla dei turni, in più imposto le fasce d'orario
        {Come su WIN "Bruno: 31/10/2017"
        GetDatiTurno(Giorno);
        Vista[IndDipendente].Giorni[IndGiorno].SiglaT1:=Giorno.SiglaT1;
        Vista[IndDipendente].Giorni[IndGiorno].SiglaT2:=Giorno.SiglaT2;
        Vista[IndDipendente].Giorni[IndGiorno].NumTurno1:=Giorno.NumTurno1;}
        //Fine lettura sigla dei turni
        if (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) = '') and (CmbOrarioSelText <> '') then
          Vista[IndDipendente].Giorni[IndGiorno].T1:=' M';
        if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
        begin
          //Se è specificato solo l'orario senza turni imposto il turno a 'M'
          Vista[IndDipendente].Giorni[IndGiorno].ValorGior:='';
          Vista[IndDipendente].Giorni[IndGiorno].Ass1:=CmbAss1SelText;
          Vista[IndDipendente].Giorni[IndGiorno].Ass2:=CmbAss2SelText;
          if Vista[IndDipendente].Giorni[IndGiorno].Ass1 = '' then
          //Prima assenza nulla e seconda assenza valida
          begin
            Vista[IndDipendente].Giorni[IndGiorno].Ass1:=CmbAss2SelText;
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:='';
          end;
          //Se le 2 assenze sono uguali elimino la seconda
          if Vista[IndDipendente].Giorni[IndGiorno].Ass1 = Vista[IndDipendente].Giorni[IndGiorno].Ass2 then
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:='';
          //Se è specificata solo l'assenza imposto il turno ad 'A'
          if ((Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) = '') or (Vista[IndDipendente].Giorni[IndGiorno].T1 = ' M'))
            and (Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> '') then
              Vista[IndDipendente].Giorni[IndGiorno].T1:=' A';
          //Se è pianificato il turno ma manca l'orario lo ricerco nello storico
          if (CmbOrarioSelText = '') and (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) <> '') then
            Vista[IndDipendente].Giorni[IndGiorno].Ora:=GetOrarioStorico(DCorr,Vista[IndDipendente].Prog);
          {Come su WIN: "Bruno: 31/10/2017"
          if Giorno.T1 <> '' then}
          if not Vista[IndDipendente].Giorni[IndGiorno].T1.IsEmpty then
            Vista[IndDipendente].Giorni[IndGiorno].Flag:='M';
        end
        else
        begin
          if (CmbAss1SelText = '') or GiornoSignificativo(CmbAss1SelText) then
          begin
            if Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> CmbAss1SelText then
              Vista[IndDipendente].Giorni[IndGiorno].Modificato:=True;
            Vista[IndDipendente].Giorni[IndGiorno].Ass1:=CmbAss1SelText;
          end;
          if (CmbAss2SelText = '') or GiornoSignificativo(CmbAss2SelText) then
          begin
            if Vista[IndDipendente].Giorni[IndGiorno].Ass2 <> CmbAss2SelText then
              Vista[IndDipendente].Giorni[IndGiorno].Modificato:=True;
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:=CmbAss2SelText;
          end;
          if Vista[IndDipendente].Giorni[IndGiorno].Ass1 = '' then
          //Prima assenza nulla e seconda assenza valida
          begin
            Vista[IndDipendente].Giorni[IndGiorno].Ass1:=CmbAss2SelText;
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:='';
          end;
          //Se le 2 assenze sono uguali elimino la seconda
          if Vista[IndDipendente].Giorni[IndGiorno].Ass1 = Vista[IndDipendente].Giorni[IndGiorno].Ass2 then
            Vista[IndDipendente].Giorni[IndGiorno].Ass2:='';
          //Se è specificata solo l'assenza imposto il turno ad 'A'
          if ((Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) = '') or (Vista[IndDipendente].Giorni[IndGiorno].T1 = ' M'))
            and (Vista[IndDipendente].Giorni[IndGiorno].Ass1 <> '') then
              Vista[IndDipendente].Giorni[IndGiorno].T1:=' A';
        end;
        if (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) < '1') or (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) > '99') then
          Vista[IndDipendente].Giorni[IndGiorno].T1EU:='';
        if (Trim(Vista[IndDipendente].Giorni[IndGiorno].T2) < '1') or (Trim(Vista[IndDipendente].Giorni[IndGiorno].T2) > '99') then
          Vista[IndDipendente].Giorni[IndGiorno].T2EU:='';
        if (CmbOrarioSelText = '') and (Trim(Vista[IndDipendente].Giorni[IndGiorno].T1) <> '') then
          Vista[IndDipendente].Giorni[IndGiorno].Ora:=A058DM.GetOrarioStorico(DCorr, Vista[IndDipendente].Prog);
        {Come su WIN "Bruno: 31/10/2017"
        if Giorno.T1 <> '' then}
        if not  Vista[IndDipendente].Giorni[IndGiorno].T1.IsEmpty then
          Vista[IndDipendente].Giorni[IndGiorno].Flag:='M';
        // Le note vanno impostate sono se il modello orario è diverso da stringa vuota. In caso contrario le svuoto.
        if Vista[IndDipendente].Giorni[IndGiorno].Ora <> '' then
          Vista[IndDipendente].Giorni[IndGiorno].Note:=MemoNoteText.Trim
        else
          Vista[IndDipendente].Giorni[IndGiorno].Note:='';
        if (xValoreOrigine.T1 <> Vista[IndDipendente].Giorni[IndGiorno].T1) or
           (xValoreOrigine.T2 <> Vista[IndDipendente].Giorni[IndGiorno].T2) or
           (xValoreOrigine.SiglaT1 <> Vista[IndDipendente].Giorni[IndGiorno].SiglaT1) or
           (xValoreOrigine.SiglaT2 <> Vista[IndDipendente].Giorni[IndGiorno].SiglaT2) or
           (xValoreOrigine.T1EU <> Vista[IndDipendente].Giorni[IndGiorno].T1EU) or
           (xValoreOrigine.T2EU <> Vista[IndDipendente].Giorni[IndGiorno].T2EU) or
           (xValoreOrigine.Ora <> Vista[IndDipendente].Giorni[IndGiorno].Ora) or
           (xValoreOrigine.ValorGior <> Vista[IndDipendente].Giorni[IndGiorno].ValorGior) or
           (xValoreOrigine.Ass1 <> Vista[IndDipendente].Giorni[IndGiorno].Ass1) or
           (xValoreOrigine.Ass2 <> Vista[IndDipendente].Giorni[IndGiorno].Ass2) or
           (xValoreOrigine.Flag <> Vista[IndDipendente].Giorni[IndGiorno].Flag) or
           (xValoreOrigine.Squadra <> Vista[IndDipendente].Giorni[IndGiorno].Squadra) or
           (xValoreOrigine.DSquadra <> Vista[IndDipendente].Giorni[IndGiorno].DSquadra) or
           (xValoreOrigine.Oper <> Vista[IndDipendente].Giorni[IndGiorno].Oper) or
           (xValoreOrigine.Note <> Vista[IndDipendente].Giorni[IndGiorno].Note) or
           (xValoreOrigine.Area <> Vista[IndDipendente].Giorni[IndGiorno].Area) or
           (xValoreOrigine.Antincendio <> Vista[IndDipendente].Giorni[IndGiorno].Antincendio) or
           (xValoreOrigine.Referente <> Vista[IndDipendente].Giorni[IndGiorno].Referente) or
           (xValoreOrigine.RichiestoDaTurnista <> Vista[IndDipendente].Giorni[IndGiorno].RichiestoDaTurnista) then
        begin
          Vista[IndDipendente].Giorni[IndGiorno].Modificato:=True; //Setto il flag che indica che la cella è stata modificata
        end;
        AnomalieXDipendente(Vista[IndDipendente]);
	      Vista.Controllo_TurnoAntincendio(Vista[IndDipendente].Giorni[IndGiorno].Data,
                                         Vista[IndDipendente].Giorni[IndGiorno].Data);
        Vista.Controllo_Referente(Vista[IndDipendente].Giorni[IndGiorno].Data,
                                  Vista[IndDipendente].Giorni[IndGiorno].Data);
        ConteggiGiornalieri(DCorr,Vista[IndDipendente],IndGiorno);
        DebitoDipendente(Vista[IndDipendente],0,Trunc(DataFine - DataInizio));
        AggiornaContatoriTurni(IndDipendente,IndGiorno);
      end;

      // Genero i JSON con l'intero contenuto della griglia
      GetCellaUIOpzioni:=[];
      if chkVisAssenzeMezzaGiorn.Checked then Include(GetCellaUIOpzioni,coIncludiAssMezzGior);
      if chkVisAssenzeAdOre.Checked then Include(GetCellaUIOpzioni,coIncludiAssOrarie);
      // Valorizzo il contenuto della celle dei giorni
      for i:=0 to A058DM.Vista.Count - 1 do
      begin
        RigaJSON:=TJSONObject.Create;
        ClassiCelleRigaJSON:=TJSONObject.Create;
        CelleEditabiliRigaJSON:=TJSONObject.Create;
        ValorizzaJSONRiga(i, RigaJSON,ClassiCelleRigaJSON,CelleEditabiliRigaJSON,GetCellaUIOpzioni);
        RigheTabellaJSON.Add(RigaJSON);
        RigaJSON:=nil;
        ClassiCelleTabellaJSON.AddPair(A058DM.Vista[i].Matricola.Trim, ClassiCelleRigaJSON);
        ClassiCelleRigaJSON:=nil;
        CelleEditabiliTabellaJSON.AddPair(A058DM.Vista[i].Matricola.Trim, CelleEditabiliRigaJSON);
        CelleEditabiliRigaJSON:=nil;
        // Valorizzo le informazioni per i tooltip di questa riga
        TooltipRigaJSON:=TJSONObject.Create;
        TooltipRigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('OPER',A058DM.Vista[i].TipoOpe));
        ValorizzaJSONTooltipRiga(i, TooltipRigaJSON,GetCellaUIOpzioni);
        TooltipCelleTabellaJSON.AddPair(A058DM.Vista[i].Matricola.Trim, TooltipRigaJSON);
        TooltipRigaJSON:=nil;
      end;

      if chkVisRigaTurni.Checked then
      begin
        // Se richiesta la riga di intestazione la aggiungo come oggetto a parte
        RigaIntestazioneJSON:=TJSONObject.Create;
        ValorizzaJSONRigaIntestazione(RigaIntestazioneJSON,A058DM.Vista[IndDipendente].Squadra,A058DM.Vista[IndDipendente].TipoOpe);
      end;

      ClientBtnSalvaVisibile:=true;

      DatiTabellaJSON:=TJSONObject.Create;
      DatiTabellaJSON.AddPair('righe',RigheTabellaJSON);
      DatiTabellaJSON.AddPair('classiCelle', ClassiCelleTabellaJSON);
      DatiTabellaJSON.AddPair('modificabilitaCelle',CelleEditabiliTabellaJSON);
      DatiTabellaJSON.AddPair('datiTooltip',TooltipCelleTabellaJSON);
      DatiTabellaJSON.AddPair('registrazioneVisibile', TGestoreChiamataAJAX.CreaJSONBoolean(ClientBtnSalvaVisibile));
      if RigaIntestazioneJSON <> nil then
        DatiTabellaJSON.AddPair('intestazione', RigaIntestazioneJSON)
      else
        DatiTabellaJSON.AddPair('intestazione', TJSONNull.Create);

      TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(JSONOutput,DatiTabellaJSON);
      Success:=true;
    except
      on E:Exception do
        begin
          try FreeAndNil(JSONOutput); except end;
          JSONOutput:=TJSONObject.Create;
          TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,['Errore durante l''aggiornamento del tabellone ' + E.Message]);
        end;
    end;
  finally
    if not Success then // errore
    begin
      if RigaJSON <> nil then
        try FreeAndNil(RigaJSON); except end;
      if ClassiCelleRigaJSON <> nil then
        try FreeAndNil(ClassiCelleRigaJSON); except end;
      if CelleEditabiliRigaJSON <> nil then
        try FreeAndNil(CelleEditabiliRigaJSON); except end;
      if TooltipRigaJSON <> nil then
        try FreeAndNil(TooltipRigaJSON); except end;
      try FreeAndNil(ClassiCelleTabellaJSON); except end;
      try FreeAndNil(CelleEditabiliTabellaJSON); except end;
      try FreeAndNil(TooltipCelleTabellaJSON); except end;
      if RigaIntestazioneJSON <> nil then
        try FreeAndNil(RigaIntestazioneJSON); except end;
      try FreeAndNil(RigheTabellaJSON); except end;
      if DatiTabellaJSON <> nil then
        try FreeAndNil(DatiTabellaJSON); except end;
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.GetContatoriOperatore(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
var
  RowNum:Integer;
  Squadra,TipoOpe:String;
  RigaIntestazioneJSON:TJSONObject;
begin
  RigaIntestazioneJSON:=nil;
  try
    RowNum:=((JSONInput as TJSONObject).Get('rowNum').JsonValue as TJSONNumber).AsInt;
    TipoOpe:=A058DM.Vista[RowNum - NRIGHEBLOCCATE].TipoOpe;
    Squadra:=A058DM.Vista[RowNum - NRIGHEBLOCCATE].Squadra;
    RigaIntestazioneJSON:=TJSONObject.Create;
    ValorizzaJSONRigaIntestazione(RigaIntestazioneJSON,Squadra,TipoOpe);
    TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(JSONOutput,RigaIntestazioneJSON);
  except
    on E:Exception do
    begin
      if RigaIntestazioneJSON <> nil then
        try FreeAndNil(RigaIntestazioneJSON); except end;
      try FreeAndNil(JSONOutput) except end;
      JSONOutput:=TJSONObject.Create;
      TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,[E.Message]);
    end;
  end;
end;

function TWA058FTabelloneTurniFM.DimLungHTML(S:String; D:Integer):String;
var
  i,L:Integer;
begin
  if D = 0 then
    D:=S.Length;
  Result:=Copy(S,1,D);
  L:=Length(Result);
  for i:=L to D - 1 do
    Result:=Result + '&nbsp;';
end;

// i = indice della riga in Vista (pianificazione di un dipendente)
procedure TWA058FTabelloneTurniFM.ValorizzaJSONRiga(const i:Integer; RigaJSON,ClassiCelleRigaJSON,CelleEditabiliRigaJSON:TJSONObject; GetCellaUIOpzioni:TGetCellaUIOpzioni);
var
  sDep,CellTurn:String;
  j,iSgOp,iOpDip,iSgDip:Integer;
  CellaUI:TCellaUI;
  ElementoCellaUI,SottoElementoCellaUI:TElementoCellaUI;
  StileElementoCella:TStileElementoCellaUI;
  IndicatoreCellaUI: TIndicatoreCellaUI;
begin
  RigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('MATRICOLA', C190ConvertiSimboliHtml(A058DM.Vista[i].Matricola.Trim)));
  RigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('NOMINATIVO', C190ConvertiSimboliHtml(A058DM.Vista[i].Cognome) + '</br>' +
                                                                   C190ConvertiSimboliHtml(A058DM.Vista[i].Nome) + '</br>' +
                                                                   C190ConvertiSimboliHtml(A058DM.Vista[i].TipoOpe)));

  sDep:='';
  with A058DM do
  begin
    AggiornaTotPagDip(Vista[i],0,Trunc(DataFine - DataInizio)); //necessario per il successivo richiamo a GetSimboloOperatore
    for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
      if not TotTabGio[iSgOp].TotaleOperatore then
        for iOpDip:=Low(Vista[i].TotDip.Operatori) to High(Vista[i].TotDip.Operatori) do
          if Vista[i].TotDip.Operatori[iOpDip].Operatore = TotTabGio[iSgOp].Operatore then
            for iSgDip:=Low(Vista[i].TotDip.Operatori[iOpDip].Sigle) to High(Vista[i].TotDip.Operatori[iOpDip].Sigle) do
              if Vista[i].TotDip.Operatori[iOpDip].Sigle[iSgDip].Sigla = TotTabGio[iSgOp].Sigla then
                if Vista[i].TotDip.Operatori[iOpDip].Sigle[iSgDip].Totale > 0 then
                begin
                  sDep:=sDep + IfThen(sDep <> '','<br>') + Format('%-3s%3d',[C190ConvertiSimboliHtml(TotTabGio[iSgOp].Sigla + IfThen(TotTabGio[iSgOp].Operatore <> Vista[i].TipoOpe.Replace('(','').Replace(')','').Trim,GetSimboloOperatore(TotTabGio[iSgOp].Operatore,TotTabGio[iSgOp].Sigla,TotPagDip))),Vista[i].TotDip.Operatori[iOpDip].Sigle[iSgDip].Totale]);
                  Break;
                end;
  end;
  RigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TOTTURNIDIP',sDep));

  RigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('SITUAZIONE_ORE', DimLungHTML('Deb.con. ',9) + R180MinutiOre(A058DM.Vista[i].Debito) + '</br>' +
                                                      DimLungHTML('Pianif. ',9) + R180MinutiOre(A058DM.Vista[i].Assegnato) + '</br>' +
                                                      DimLungHTML('Scost. ',9) + R180MinutiOre(A058DM.Vista[i].Assegnato - A058DM.Vista[i].Debito)));

  sDep:='Riposi: ' + Format('%d+%d',[A058DM.Vista[i].TotDip.Riposi,A058DM.Vista[i].RiposiPrec]);
  sDep:=sDep + '<br>' + Format('F.l.corr.:%3s',[IntToStr(A058DM.Vista[i].FestiviLavMeseCorr)]);
  sDep:=sDep + '<br>' + Format('F.l.%s:%3s',[FormatDateTime('mm/yy',A058DM.DataInizio - 1),IntToStr(A058DM.Vista[i].FestiviLavMesePrec)]);
  RigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('RIP_FES_TLAV',sDep));

  for j:=0 to Trunc(A058DM.DataFine - A058DM.DataInizio) do
  begin
    // Contenuto della cella
    CellTurn:='';
    CellaUI:=A058DM.GetCellaUI(i,j,GetCellaUIOpzioni);
    try
      for IndicatoreCellaUI in CellaUI.Indicatori do
        CellTurn:=CellTurn + '<div style="position: relative; height: 0px;">' +
                             '  <img src="' + STILI_INDICATORE_CELLA[IndicatoreCellaUI.TipoStileIndicatoreCellaUI].ImmagineWeb + '" style="position: absolute;' +
                                   StrUtils.IfThen(IndicatoreCellaUI.TopWeb <> '','top: ' + IndicatoreCellaUI.TopWeb + ';') +
                                   StrUtils.IfThen(IndicatoreCellaUI.RightWeb <> '','right: ' + IndicatoreCellaUI.RightWeb + ';') +
                                   StrUtils.IfThen(IndicatoreCellaUI.BottomWeb <> '','bottom: ' + IndicatoreCellaUI.BottomWeb + ';') +
                                   StrUtils.IfThen(IndicatoreCellaUI.LeftWeb <> '','left: ' + IndicatoreCellaUI.LeftWeb + ';') +
                             '"></div>';
      for ElementoCellaUI in CellaUI.Elementi do
      begin
        if ElementoCellaUI.WebProprieta.Invisibile then
          continue;
        if not ElementoCellaUI.TipoComplesso then
        begin
          // Elemento semplice: un div unico con testo
          StileElementoCella:=STILI_ELEMENTO_CELLA[ElementoCellaUI.TipoStileElementoCellaUI];
          CellTurn:=CellTurn + '<div style="';
          if StileElementoCella.StileWeb.ColoreSfondo <> '' then
            CellTurn:=CellTurn + 'background-color:' + StileElementoCella.StileWeb.ColoreSfondo + ';';
          CellTurn:=CellTurn + 'color:' + StileElementoCella.StileWeb.ColoreTesto  + ';text-align:' + StileElementoCella.StileWeb.AllineamentoTesto + ';';
          if ElementoCellaUI.WebProprieta.StiliCarattere <> '' then
            CellTurn:=CellTurn + 'font-style:' + ElementoCellaUI.WebProprieta.StiliCarattere + ';';
          CellTurn:=CellTurn + '">';
          if not chkVisTabSint.Checked then
            CellTurn:=CellTurn + C190ConvertiSimboliHtml(ElementoCellaUI.WebProprieta.Testo)
          else
            CellTurn:=CellTurn + C190ConvertiSimboliHtml(ElementoCellaUI.WebProprieta.TestoSintetico);
          CellTurn:=CellTurn + '</div>';
        end
        else
        begin
          // Elemento composto: è un div contenente un insieme di span
          CellTurn:=CellTurn + '<div style="text-align: center;padding: 1px;">';
          for SottoElementoCellaUI in ElementoCellaUI.ListaSottoElementi do
          begin
            StileElementoCella:=STILI_ELEMENTO_CELLA[SottoElementoCellaUI.TipoStileElementoCellaUI];
            CellTurn:=CellTurn + '<span style="padding: 1px;';
            if not SottoElementoCellaUI.WebProprieta.Invisibile then
            begin
              // cambio colore di sfondo per sottoelemento tsecSiglaArea
              if (SottoElementoCellaUI.TipoStileElementoCellaUI = tsecSiglaArea)
              and (A058DM.Vista[i].Giorni[j].Area <> '')
              and (A058DM.selT651.SearchRecord('CODICE_AREA',A058DM.Vista[i].Giorni[j].Area,[srFromBeginning])) then
                StileElementoCella.StileWeb.ColoreSfondo:=A058DM.getColoreStyleWEB(A058DM.selT651.FieldByName('COLORE').AsString);
              if StileElementoCella.StileWeb.ColoreSfondo <> '' then
                CellTurn:=CellTurn + 'background-color:' + StileElementoCella.StileWeb.ColoreSfondo + ';';
              CellTurn:=CellTurn + 'color:' + StileElementoCella.StileWeb.ColoreTesto  + ';';
              if ElementoCellaUI.WebProprieta.StiliCarattere <> '' then
                CellTurn:=CellTurn + 'font-style:' + ElementoCellaUI.WebProprieta.StiliCarattere + ';';
            end;
            CellTurn:=CellTurn + '">';
            if not SottoElementoCellaUI.WebProprieta.Invisibile then
            begin
              if not chkVisTabSint.Checked then
                CellTurn:=CellTurn + C190ConvertiSimboliHtml(SottoElementoCellaUI.WebProprieta.Testo)
              else
                CellTurn:=CellTurn + C190ConvertiSimboliHtml(SottoElementoCellaUI.WebProprieta.TestoSintetico);
            end
            else
            begin
              if not chkVisTabSint.Checked then
                CellTurn:=CellTurn + R180DimLung('',Length(SottoElementoCellaUI.WebProprieta.Testo))
              else
                CellTurn:=CellTurn + R180DimLung('',Length(SottoElementoCellaUI.WebProprieta.TestoSintetico))
            end;
            CellTurn:=CellTurn + '</span>' + '&nbsp;';
          end;
          CellTurn:=CellTurn + '</div>';
        end;
      end;
      if CellTurn = '' then
        CellTurn:=' '; // necessario per aggiornamento cella via jqGrid.setCell()

      RigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('GG' + IntToStr(j), CellTurn));

      // Informazioni sulla cella (classi css, editabilità)
      if (CellaUI.ClasseSfondoWeb <> '') then
        ClassiCelleRigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('GG' + IntToStr(j), CellaUI.ClasseSfondoWeb));

      // Cella modificabile?
      if A058DM.Vista[i].Giorni[j].Squadra = A058DM.SquadraRiferimento then
        CelleEditabiliRigaJSON.AddPair('GG' + IntToStr(j), TGestoreChiamataAJAX.CreaJSONBoolean(True))
      else
        CelleEditabiliRigaJSON.AddPair('GG' + IntToStr(j), TGestoreChiamataAJAX.CreaJSONBoolean(False));
    finally
      FreeAndNil(CellaUI);
    end;

  end;
end;

procedure TWA058FTabelloneTurniFM.ValorizzaJSONRigaIntestazione(JSONRiga:TJSONObject;const Squadra,TipoOpe:String);
var
  idxCol,iSgOp:Integer;
  dDataCella: TDateTime;
  StrHTML,NomeCampo,ValoreCampo:String;
  ColonneAltriDati: array[0..4] of String;

  procedure ScriviMinMax(TipoOperatore,SiglaTurno:String; var StrHTMLCella: String);
  var
    LimiteMin,LimiteMax,Totale:Integer;
    MaxMinFormat:String;
    MaxMin:TMaxMin;
  begin
    if not chkVisTabSint.Checked then
      MaxMinFormat:='%3s%'
    else
      MaxMinFormat:='%2s%';

    MaxMin:=A058DM.GetConteggioTurni(dDataCella,TipoOperatore,SiglaTurno);
    LimiteMin:=MaxMin.Min;
    LimiteMax:=MaxMin.Max;
    Totale:=MaxMin.Totale;

    StrHTMLCella:=StrHTMLCella + '<div>';
    // minimo
    StrHTMLCella:=StrHTMLCella + StringReplace(Format(MaxMinFormat,[IfThen(LimiteMin > 0,LimiteMin.ToString,'')]),' ','&nbsp;',[rfReplaceAll]) + ' ';
    // assegnato
    StrHTMLCella:=StrHTMLCella + '<span';
    if Totale < LimiteMin then
      StrHTMLCella:=StrHTMLCella + ' class="font_rosso"'
    else if Totale > LimiteMax then
      StrHTMLCella:=StrHTMLCella + ' class="font_blu"'
    else
      StrHTMLCella:=StrHTMLCella + ' class="font_verde"';
    StrHTMLCella:=StrHTMLCella + '>' + StringReplace(Format(MaxMinFormat,[IfThen((Totale > 0) or (LimiteMin > 0) or (LimiteMax > 0),Totale.ToString,'')]),' ','&nbsp;',[rfReplaceAll]) + '</span>' + ' ';
    // massimo
    StrHTMLCella:=StrHTMLCella + StringReplace(Format(MaxMinFormat,[IfThen((LimiteMax > 0) and (LimiteMax < 99),LimiteMax.ToString,'')]),' ','&nbsp;',[rfReplaceAll]) + '</div>';
  end;
begin
  ColonneAltriDati[0]:='MATRICOLA';
  ColonneAltriDati[1]:='NOMINATIVO';
  ColonneAltriDati[2]:='TOTTURNIDIP';
  ColonneAltriDati[3]:='SITUAZIONE_ORE';
  ColonneAltriDati[4]:='RIP_FES_TLAV';

  with A058DM do
  begin
    AggiornaTotPagGio(0,Trunc(DataFine - DataInizio)); //necessario per il successivo richiamo a GetSimboloOperatore
    // Aggiungo le colonne vuote
    for idxCol:=0 to High(ColonneAltriDati) do
    begin
      NomeCampo:=ColonneAltriDati[idxCol];
      if idxCol = 1 then
      begin
        StrHTML:='<div><span>Oper.</span> <span>Sigle</span></div>';
        for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
          if not TotTabGio[iSgOp].TotaleOperatore then
            StrHTML:=StrHTML +
                     '<div><span>' +
                     DimLungHTML(C190ConvertiSimboliHtml(TotTabGio[iSgOp].Operatore),5) +
                     '</span> <span>' +
                     DimLungHTML(C190ConvertiSimboliHtml(TotTabGio[iSgOp].Sigla + GetSimboloOperatore(TotTabGio[iSgOp].Operatore,TotTabGio[iSgOp].Sigla,TotTabGio)),5) +
                     '</span></div>';
      end
      else if idxCol = 2 then
      begin
        StrHTML:='<div><span>Asseg.</span></div>';
        for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
          if not TotTabGio[iSgOp].TotaleOperatore then
            StrHTML:=StrHTML +
                     '<div><span>' +
                     StringReplace(Format('%6s',[IntToStr(TotTabGio[iSgOp].Totale)]),' ','&nbsp;',[rfReplaceAll]) +
                     '</span></div>';
      end
      else
      begin
        StrHTML:=' ';
        for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
          if not TotTabGio[iSgOp].TotaleOperatore then
            StrHTML:=StrHTML + '<br> ';
      end;
      JSONRiga.AddPair(TGestoreChiamataAJAX.CreaJSONPair(NomeCampo,StrHTML));
    end;
    for idxCol:=0 to Trunc(DataFine - DataInizio) do
    begin
      if not chkVisTabSint.Checked then
        StrHTML:='<div>MIN ASS MAX</div>'
      else
        StrHTML:='<div>mn As MX</div>';
      dDataCella:=DataInizio + idxCol;
      //Ciclo sulle sigle usate per tipo operatore
      for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
        if not TotTabGio[iSgOp].TotaleOperatore then
          ScriviMinMax(TotTabGio[iSgOp].Operatore,TotTabGio[iSgOp].Sigla,StrHTML);
      NomeCampo:='GG' + IntToStr(idxCol);
      ValoreCampo:=StrHTML;
      JSONRiga.AddPair(TGestoreChiamataAJAX.CreaJSONPair(NomeCampo, ValoreCampo));
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.ValorizzaJSONTooltipRiga(i:Integer; RigaTooltipJSON: TJSONObject; GetCellaUIOpzioni:TGetCellaUIOpzioni);
var
  j,anomIdx:Integer;
  CellaTooltipJSON:TJSONObject;
  CellaTurniMezzGiorOreJSON,CellaAnomalieJSON:TJSONArray;
  CurrAssOre:TAssenzaOre;
begin
  CellaTooltipJSON:=nil;
  CellaTurniMezzGiorOreJSON:=nil;
  CellaAnomalieJSON:=nil;
  try
    for j:=0 to Trunc(A058DM.DataFine - A058DM.DataInizio) do
    begin
      // Contenuto della cella
      CellaTooltipJSON:=TJSONObject.Create;
      CellaTurniMezzGiorOreJSON:=TJSONArray.Create;
      CellaAnomalieJSON:=TJSONArray.Create;
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('Ora',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].Ora)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('T1',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].T1)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('T1EU',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].T1EU)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('T2',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].T2)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('T2EU',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].T2EU)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('SiglaT1',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].SiglaT1)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('SiglaT2',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].SiglaT2)));
      if (Trim(A058DM.Vista[i].Giorni[j].T1) <> '') and (Trim(A058DM.Vista[i].Giorni[j].T1) <> 'A')
          and (Trim(A058DM.Vista[i].Giorni[j].T1) <> 'M') then
      begin
        CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('T1OraInizio',R180MinutiOre(A058DM.Vista[i].Giorni[j].MinutiEntrata1)));
        CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('T1OraFine',R180MinutiOre(A058DM.Vista[i].Giorni[j].MinutiUscita1)));
      end
      else
      begin
        CellaTooltipJSON.AddPair('T1OraInizio',TJSONNull.Create);
        CellaTooltipJSON.AddPair('T1OraFine',TJSONNull.Create);
      end;
      if (Trim(A058DM.Vista[i].Giorni[j].T2) <> '') then
      begin
        CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('T2OraInizio',R180MinutiOre(A058DM.Vista[i].Giorni[j].MinutiEntrata2)));
        CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('T2OraFine',R180MinutiOre(A058DM.Vista[i].Giorni[j].MinutiUscita2)));
      end
      else
      begin
        CellaTooltipJSON.AddPair('T2OraInizio',TJSONNull.Create);
        CellaTooltipJSON.AddPair('T2OraFine',TJSONNull.Create);
      end;
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('Ass1',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].Ass1)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('Ass2',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].Ass2)));

      if A058DM.Vista[i].Giorni[j].AssOre <> nil then
      begin
        for CurrAssOre in A058DM.Vista[i].Giorni[j].AssOre do
          CellaTurniMezzGiorOreJSON.Add(CurrAssOre.Causale + ' ' + CurrAssOre.Orario);
      end;
      CellaTooltipJSON.AddPair('AssOre',CellaTurniMezzGiorOreJSON);
      CellaTurniMezzGiorOreJSON:=nil;
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep1',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[1].Turno)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep1Sigla',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[1].Sigla)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep1OraInizio',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[1].OraInizio)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep1OraFine',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[1].OraFine)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep2',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[2].Turno)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep2Sigla',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[2].Sigla)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep2OraInizio',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[2].OraInizio)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep2OraFine',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[2].OraFine)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep3',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[3].Turno)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep3Sigla',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[3].Sigla)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep3OraInizio',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[3].OraInizio)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('TurnoRep3OraFine',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].TurniRep[3].OraFine)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('Area',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].Area)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('dArea',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].dArea)));
      CellaTooltipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('sArea',C190ConvertiSimboliHtml(A058DM.GetSiglaArea(A058DM.Vista[i].Giorni[j].Area))));
      CellaToolTipJSON.AddPair('Antincendio', TGestoreChiamataAJAX.CreaJSONBoolean(A058DM.Vista[i].Giorni[j].Antincendio = 'S'));
      CellaToolTipJSON.AddPair('Referente', TGestoreChiamataAJAX.CreaJSONBoolean(A058DM.Vista[i].Giorni[j].Referente = 'S'));
      CellaToolTipJSON.AddPair('RichiestoDaTurnista', TGestoreChiamataAJAX.CreaJSONBoolean(A058DM.Vista[i].Giorni[j].RichiestoDaTurnista = 'S'));
      CellaToolTipJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('Note',C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].Note)));
      for anomIdx:=0 to (A058DM.Vista[i].Giorni[j].Anomalie.Count - 1) do
        CellaAnomalieJSON.Add(C190ConvertiSimboliHtml(A058DM.Vista[i].Giorni[j].Anomalie[anomIdx].Testo));
      CellaTooltipJSON.AddPair('Anomalie',CellaAnomalieJSON);
      CellaAnomalieJSON:=nil;
      RigaTooltipJSON.AddPair('GG' + IntToStr(j), CellaTooltipJSON);
      CellaTooltipJSON:=nil;
    end;
  finally
    //L'eccezione sollevata viene gestita dal metodo chiamante.
    if CellaTurniMezzGiorOreJSON <> nil then
      try FreeAndNil(CellaTurniMezzGiorOreJSON) except end;
    if CellaAnomalieJSON <> nil then
      try FreeAndNil(CellaAnomalieJSON); except end;
    if CellaTooltipJSON <> nil then
      try FreeAndNil(CellaTooltipJSON) except end;
  end;
end;

procedure TWA058FTabelloneTurniFM.ValorizzaJSONTurno(ListaItems:TJSONArray; CodiceOrario: String; DataDec:TDateTime; var ValueSelComboT1: Integer; ValT1:String; var ValueSelComboT2: Integer; ValT2: String);
var
  ValueItemCombo:Integer;
  MyTLabel:String;
  JSONCaricaTurnoComboElem:TJSONObject;
begin
  JSONCaricaTurnoComboElem:=nil;
  ValueItemCombo:=0;
  ValueSelComboT1:=0;
  ValueSelComboT2:=0;
  try
    with A058DM do
    begin
      // Imposto il dataset con i turni per ogni modello orario
      Q021.Filter:='';
      Q021.Filtered:=False;
      Q021.SetVariable('DECORRENZA', DataDec);
      Q021.Close;
      Q021.Open;

      ValueItemCombo:=-1;
      // Campo vuoto (se questa giornata non ha mai avuto turni impostati)
      JSONCaricaTurnoComboElem:=TJSONObject.Create;
      Self.ValorizzaItemComboJSON(JSONCaricaTurnoComboElem, ValueItemCombo, '');
      ListaItems.Add(JSONCaricaTurnoComboElem);
      JSONCaricaTurnoComboElem:=nil;

      inc(ValueItemCombo);
      JSONCaricaTurnoComboElem:=TJSONObject.Create;
      Self.ValorizzaItemComboJSON(JSONCaricaTurnoComboElem, ValueItemCombo, '0 - Riposo');
      ListaItems.Add(JSONCaricaTurnoComboElem);
      JSONCaricaTurnoComboElem:=nil;

      if (CodiceOrario <> '') then
      begin
        with Q021 do
          if SearchRecord('CODICE',CodiceOrario,[srFromBeginning]) then
          repeat
            inc(ValueItemCombo);
            if Not FieldByName('SIGLATURNI').IsNull then
              MyTLabel:='(' + FieldByName('SIGLATURNI').AsString + ')'
            else
              MyTLabel:='(' + FieldByName('NUMTURNO').AsString + ')';
            JSONCaricaTurnoComboElem:=TJSONObject.Create;
            Self.ValorizzaItemComboJSON(JSONCaricaTurnoComboElem, ValueItemCombo, ValueItemCombo.ToString + ' - ' + MyTLabel);
            ListaItems.Add(JSONCaricaTurnoComboElem);
            JSONCaricaTurnoComboElem:=nil;
          until not SearchRecord('CODICE',CodiceOrario,[]);
      end
      else
      begin
        for ValueItemCombo:=1 to 9 do
        begin
          JSONCaricaTurnoComboElem:=TJSONObject.Create;
          Self.ValorizzaItemComboJSON(JSONCaricaTurnoComboElem, ValueItemCombo, ValueItemCombo.ToString);
          ListaItems.Add(JSONCaricaTurnoComboElem);
          JSONCaricaTurnoComboElem:=nil;
        end;
      end;

      ValT1:=ValT1.Trim;
      if ValT1.IsEmpty or R180In(ValT1,['M','A']) then
        ValueSelComboT1:=-1
      else
      begin
        try
          if ValT1.ToInteger <= Q021.RecordCount then
            ValueSelComboT1:=StrToInt(ValT1);
        except
          ValueSelComboT1:=-1
        end;
      end;

      ValT2:=ValT2.Trim;
      if ValT2.IsEmpty or R180In(ValT2,['M','A']) then
        ValueSelComboT2:=-1
      else
      begin
        try
          if ValT2.ToInteger <= Q021.RecordCount then
            ValueSelComboT2:=StrToInt(ValT2);
        except
          ValueSelComboT2:=-1
        end;
      end;
    end;
  finally
    if JSONCaricaTurnoComboElem <> nil then
      try FreeAndNil(JSONCaricaTurnoComboElem) except end;
  end;
end;

procedure TWA058FTabelloneTurniFM.ValorizzaItemComboJSON(JSONElem:TJSONObject; Valore:Integer; Etichetta:String);
begin
  JSONElem.AddPair(TGestoreChiamataAJAX.CreaJSONPair('value',IntToStr(Valore)));
  JSONElem.AddPair(TGestoreChiamataAJAX.CreaJSONPair('label',C190ConvertiSimboliHtml(Etichetta)));
end;

procedure TWA058FTabelloneTurniFM.RefreshTabellone;
begin
  // Se arrivo dai giustificativi devo aggiornare il tabellone
  if FNComp <> '' then
  begin
    Abilitazioni;
    ClientBtnSalvaVisibile:=True;
    btnEseguiClick(btnVisualizza);
    FNComp:='';
  end;
end;

function TWA058FTabelloneTurniFM.ModificheInCorso: String;
begin
  Result:='';
  if A058DM.Vista.Modificato then
    Result:='Le modifiche apportate non sono state salvate! Uscire comunque?';
end;

end.
