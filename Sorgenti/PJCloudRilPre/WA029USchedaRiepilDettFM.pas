unit WA029USchedaRiepilDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, StrUtils,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid,
  medpIWTabControl, meIWRegion, IWCompEdit, IWDBStdCtrls, meIWDBEdit, meIWEdit,
  C180FunzioniGenerali, A029USchedaRiepilMW, IWCompButton, meIWButton,
  IWDBGrids, meIWDBGrid, medpIWDBGrid, IWCompCheckbox, meIWDBCheckBox, DB,
  IWCompListbox, meIWDBLookupComboBox, medpIWMultiColumnComboBox, IWApplication,
  C190FunzioniGeneraliWeb, meIWImageFile, A000UInterfaccia, A000UMessaggi,
  MedpIWMessageDlg,MeIWComBoBox, Math, WR100UBase, WA029URecuperiMobiliFM,
  WC015USelEditGridFM, WC020UinputDataOreFM, IWHTMLControls, meIWLink;

type
  TWA029FSchedaRiepilDettFM = class(TWR205FDettTabellaFM)
    grdTabDetail: TmedpIWTabControl;
    WA029SaldiRG: TmeIWRegion;
    TemplateSaldiRG: TIWTemplateProcessorHTML;
    lblDebitoContr: TmeIWLabel;
    dEdtDebitoContr: TmeIWDBEdit;
    lblDebitoCompl: TmeIWLabel;
    lblOreLavorate: TmeIWLabel;
    lblOrePresenza: TmeIWLabel;
    lblOreAssenza: TmeIWLabel;
    lblOreInail: TmeIWLabel;
    lblSaldoMese: TmeIWLabel;
    lblMesePrec: TmeIWLabel;
    edtDebitoCompl: TmeIWEdit;
    edtOreLavorate: TmeIWEdit;
    edtOrePresenza: TmeIWEdit;
    dEdtOreAssenza: TmeIWDBEdit;
    dEdtOreInail: TmeIWDBEdit;
    edtSaldoMese: TmeIWEdit;
    edtMesePrec: TmeIWEdit;
    lblScostNeg: TmeIWLabel;
    lblRecAnnoPrec: TmeIWLabel;
    lblRecAnnoCorr: TmeIWLabel;
    lblSaldoAnnoPrec: TmeIWLabel;
    lblSaldoAnnoCorr: TmeIWLabel;
    lblSaldoAnno: TmeIWLabel;
    dEdtScostNeg: TmeIWDBEdit;
    dEdtRecAnnoPrec: TmeIWDBEdit;
    dEdtRecLiqPrec: TmeIWDBEdit;
    dEdtRecAnnoCorr: TmeIWDBEdit;
    dEdtRecLiqCorr: TmeIWDBEdit;
    edtSaldoAnnoPrec: TmeIWEdit;
    edtSaldoAnnoCorr: TmeIWEdit;
    edtSaldoAnno: TmeIWEdit;
    edtOrePerse: TmeIWEdit;
    lblOrePerse: TmeIWLabel;
    lblOreTroncate: TmeIWLabel;
    edtOreTroncate: TmeIWEdit;
    edtOreAddebitate: TmeIWEdit;
    lblOreAddebitate: TmeIWLabel;
    edtOreEsclComp: TmeIWEdit;
    lblOreEsclComp: TmeIWLabel;
    edtVariazioneSaldo: TmeIWEdit;
    lblVariazioneSaldo: TmeIWLabel;
    lblData: TmeIWLabel;
    btnOreLiqAnniPrec: TmeIWButton;
    edtLiqOreAnniPrec: TmeIWEdit;
    lblLiqOreAnniPrec: TmeIWLabel;
    btnSaldiMobili: TmeIWButton;
    grdFasce: TmedpIWDBGrid;
    lblRiposiCompensativi: TmeIWLabel;
    lblRipComMaturati: TmeIWLabel;
    dEdtRipCom: TmeIWDBEdit;
    lblRipComNonFruiti: TmeIWLabel;
    edtRipComNonFruiti: TmeIWEdit;
    edtAbbRipComMes: TmeIWEdit;
    lblAbbRipComMes: TmeIWLabel;
    edtSaldoRipCom: TmeIWEdit;
    lblSaldoRipCom: TmeIWLabel;
    lblDebitoAggiuntivo: TmeIWLabel;
    dChkGestioneAnticipo: TmeIWDBCheckBox;
    dEdtDebitoPO: TmeIWDBEdit;
    lblDebitoPO: TmeIWLabel;
    edtDebPOAnno: TmeIWEdit;
    lblDebPOAnno: TmeIWLabel;
    edtResiduoPOAnno: TmeIWEdit;
    lblResiduoPOAnno: TmeIWLabel;
    edtResoPOMese: TmeIWEdit;
    lblResoPOMese: TmeIWLabel;
    edtResoPOAnno: TmeIWEdit;
    lblResoPOAnno: TmeIWLabel;
    cmbCausale1MinAss: TMedpIWMultiColumnComboBox;
    cmbCausale2MinAss: TMedpIWMultiColumnComboBox;
    lblDatiInFasce: TmeIWLabel;
    lblOreAssestamento: TmeIWLabel;
    grdTotaliFasce: TmeIWGrid;
    lblRipComFasce: TmeIWLabel;
    WA029IndennitaRG: TmeIWRegion;
    TemplateIndennitaRG: TIWTemplateProcessorHTML;
    lblIndennitaFestive: TmeIWLabel;
    lblFestivIntera: TmeIWLabel;
    dedtFestivIntera: TmeIWDBEdit;
    dedtFestivInteraVar: TmeIWDBEdit;
    lblFestivInteraVar: TmeIWLabel;
    dedtFestivRidotta: TmeIWDBEdit;
    dedtFestivRidottaVar: TmeIWDBEdit;
    lblFestivRidotta: TmeIWLabel;
    lblFestivRidottaVar: TmeIWLabel;
    dedtRiposiNonFruiti: TmeIWDBEdit;
    lblRiposiNonFruiti: TmeIWLabel;
    lblIndennitaTurno: TmeIWLabel;
    lblIndTurnoNum: TmeIWLabel;
    dedtIndTurnoNum: TmeIWDBEdit;
    dedtIndTurnoNumVar: TmeIWDBEdit;
    lblIndTurnoNumVar: TmeIWLabel;
    dedtIndTurnoOre: TmeIWDBEdit;
    dedtIndTurnoOreVar: TmeIWDBEdit;
    lblIndTurnoOre: TmeIWLabel;
    lblIndTurnoOreVar: TmeIWLabel;
    lblRiepilogoTurni: TmeIWLabel;
    lblTurni1: TmeIWLabel;
    dedtTurni1: TmeIWDBEdit;
    lblTurni2: TmeIWLabel;
    dedtTurni2: TmeIWDBEdit;
    lblTurni3: TmeIWLabel;
    dedtTurni3: TmeIWDBEdit;
    lblTurni4: TmeIWLabel;
    dedtTurni4: TmeIWDBEdit;
    grdIndennitaPresenza: TmedpIWDBGrid;
    lblContratto: TmeIWLabel;
    lblPartTime: TmeIWLabel;
    grdIndennita: TmedpIWDBGrid;
    lblOreLavorateTurno: TmeIWLabel;
    grdDatiScheda: TmedpIWDBGrid;
    lblDatiAtipici: TmeIWLabel;
    WA029StraordinarioRG: TmeIWRegion;
    TemplateStraordinarioRG: TIWTemplateProcessorHTML;
    lblVarManEccLiq: TmeIWLabel;
    dedtOreVariazEcc: TmeIWDBEdit;
    lblVarResidua: TmeIWLabel;
    edtVarEccLiqAnno: TmeIWEdit;
    lblStraordLiqfb: TmeIWLabel;
    dedtLiqFuoriBudget: TmeIWDBEdit;
    lblLiqEntroDisp: TmeIWLabel;
    edtLiquidazioniAnnue: TmeIWEdit;
    lblLimitiEccOr: TmeIWLabel;
    lblLiqAnno: TmeIWLabel;
    edtStrAutAnn: TmeIWEdit;
    lblLiqMese: TmeIWLabel;
    edtStrAutMen: TmeIWEdit;
    lblResMese: TmeIWLabel;
    edtEccResAutMen: TmeIWEdit;
    btnLimitiIndividuali: TmeIWButton;
    lblLiqAutLim: TmeIWLabel;
    lblOreCausalizzate: TmeIWLabel;
    edtOreCausalizzateEsterneLiq: TmeIWEdit;
    lblStaordEst: TmeIWLabel;
    edtStrEst: TmeIWEdit;
    lblEccComp: TmeIWLabel;
    lblMaturataMese: TmeIWLabel;
    dedtOreEccedComp: TmeIWDBEdit;
    lblCausalizzata: TmeIWLabel;
    dedtOreEccedCompOltreSoglia: TmeIWDBEdit;
    lblResiduaMese: TmeIWLabel;
    edtEccCompMese: TmeIWEdit;
    lblMaturataAnno: TmeIWLabel;
    edtEccCompAnno: TmeIWEdit;
    lblResiduaAnno: TmeIWLabel;
    edtEccResidua: TmeIWEdit;
    btnLiquidazioneAutomatica: TmeIWButton;
    lblLiquidStrBloccata: TmeIWLabel;
    grdStraord: TmedpIWDBGrid;
    grdTotaliStraord: TmeIWGrid;
    WA029StraordinarioEsternoRG: TmeIWRegion;
    TemplateStraordinarioEsternoRG: TIWTemplateProcessorHTML;
    grdStraordinarioEsterno: TmedpIWDBGrid;
    lblStraordinarioEsterno: TmeIWLabel;
    lblStraordLiquid: TmeIWLabel;
    edtStraordLiquid: TmeIWEdit;
    lblStraordEsterno: TmeIWLabel;
    edtStraordEsterno: TmeIWEdit;
    lblBancaOre: TmeIWLabel;
    grdOreCompensabili: TmeIWGrid;
    grdTotOreCompensabili: TmeIWGrid;
    lblDatiMensili: TmeIWLabel;
    lblDaCausaliEscluse: TmeIWLabel;
    edtBancaOreCausEsc: TmeIWEdit;
    lblRecupCaus: TmeIWLabel;
    dedtOreCompRecuparate: TmeIWDBEdit;
    lblRecupNeg: TmeIWLabel;
    edtBancaOreRecInterna: TmeIWEdit;
    lblLiquidata: TmeIWLabel;
    dedtOreCompLiq: TmeIWDBEdit;
    lblBancaOreLiqVar: TmeIWLabel;
    dedtBancaOreLiqVar: TmeIWDBEdit;
    lblLIquidCompBloccata: TmeIWLabel;
    lblDatiAnnuali: TmeIWLabel;
    lblMaturata: TmeIWLabel;
    edtBancaOreMaturata: TmeIWEdit;
    lblResiduaPrec: TmeIWLabel;
    edtBancaOreResiduaPrec: TmeIWEdit;
    lblRecuperata: TmeIWLabel;
    edtBancaOreRecuperata: TmeIWEdit;
    edtBancaOreResiduaCorr: TmeIWEdit;
    lblResiduaCorr: TmeIWLabel;
    lblBancaOreLiquidata: TmeIWLabel;
    edtBancaOreLiquidata: TmeIWEdit;
    lblResidua: TmeIWLabel;
    edtBancaOreResidua: TmeIWEdit;
    lblMaturataCaus: TmeIWLabel;
    edtBancaOreCausEscAnno: TmeIWEdit;
    WA029RiepPresenzeRG: TmeIWRegion;
    TemplateRiepPresenzeRG: TIWTemplateProcessorHTML;
    grdFascePresenza: TmedpIWDBGrid;
    grdCauPresPaghe: TmedpIWDBGrid;
    cmbCausPresenza: TMedpIWMultiColumnComboBox;
    lblCausPresenza: TmeIWLabel;
    btnSaldiMobiliCausale: TmeIWButton;
    lblOreEscluseIncluse: TmeIWLabel;
    lblAnno: TmeIWLabel;
    lblCompRegis: TmeIWLabel;
    edtOreEsclCompAnno: TmeIWEdit;
    lblCompEffettivo: TmeIWLabel;
    edtOreEsclCompAnnoEff: TmeIWEdit;
    lblRipComp: TmeIWLabel;
    edtRecuperoAnno: TmeIWEdit;
    grdPresAnnue: TmeIWGrid;
    lblMese: TmeIWLabel;
    lblCompRegisMese: TmeIWLabel;
    dedtOreEsclCompMese: TmeIWDBEdit;
    lblCompEffettivoMese: TmeIWLabel;
    edtOreEsclCompMeseEff: TmeIWEdit;
    lblOreGettoneResidue: TmeIWLabel;
    dedtGettoneResiduo: TmeIWDBEdit;
    lblLiquidazioneBloccata: TmeIWLabel;
    grdPresAnnueTot: TmeIWGrid;
    btnAttivaLiquidazione: TmeIWButton;
    grdPresLiq: TmedpIWDBGrid;
    grdPresLiqTot: TmeIWGrid;
    btnLiquidazioniAnnue: TmeIWButton;
    lnkIndennitaPresenza: TmeIWLink;
    btnOnChangeCompensabile: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbCausaleMinAssAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure grdIndennitaPresenzaDataSet2Componenti(Row: Integer);
    procedure RenderGrid(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdStraordinarioEsternoDataSet2Componenti(Row: Integer);
    procedure grdOreCompensabiliRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdTotaliRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdFascePresenzaDataSet2Componenti(Row: Integer);
    procedure grdCauPresPagheDataSet2Componenti(Row: Integer);
    procedure cmbCausPresenzaChange(Sender: TObject; Index: Integer);
    procedure grdPresAnnueRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure btnAttivaLiquidazioneClick(Sender: TObject);
    procedure btnSaldiMobiliCausaleClick(Sender: TObject);
    procedure btnSaldiMobiliClick(Sender: TObject);
    procedure btnLiquidazioniAnnueClick(Sender: TObject);
    procedure btnLiquidazioneAutomaticaClick(Sender: TObject);
    procedure lnkIndennitaPresenzaClick(Sender: TObject);
    procedure grdTabDetailTabControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure dedtOreEsclCompMeseAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure btnOnChangeCompensabileClick(Sender: TObject);
    procedure edtAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnOreLiqAnniPrecClick(Sender: TObject);
    procedure btnLimitiIndividualiClick(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure grdIndennitaPresenzaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdFascePresenzaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdPresLiqDataSet2Componenti(Row: Integer);
    procedure grdPresLiqComponenti2DataSet(Row: Integer);
    procedure grdPresLiqAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    OreLiq: Integer;
    ImpLiq: Real;
    WA029FRecuperiMobiliFM: TWA029FRecuperiMobiliFM;
    procedure cmbCodIndPresAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodStrEstAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCausPresenzeAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCauPresPagheAsyncChange(Sender: TObject;EventParams: TStringList);
    procedure IntestazioneGrdPresAnnue;
    procedure ImpostaHintComboCausaleAssenza;
    procedure LiquidazioneAutomaticaBudget;
    procedure ResultOreLiquidazione(Sender: TObject; Result: Boolean;Valore: String);
    procedure ResultConfermaLiquidazioneAutomatica(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultConfermaLiquidazioneAutomaticaBudget(Sender: TObject;
      Res: TmeIWModalResult; KeyID: String);
    procedure VisualizzaDatiBloccati;
    function DimensionaGridTotali(Tabella, TabellaTotali: String;
      HideFirst: boolean): String;
  public
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaComponenti; override;
    procedure OnConfermaGrdFasce(Sender: TObject);
    procedure OnConfermaGrdIndennita(Sender: TObject);
    procedure OnConfermaGrdStraord(Sender: TObject);
    function VerificaGrdPending: Boolean;
    //richiamate da MW
    procedure VisualizzaDatiCalcolati(totali: TTotali);
    procedure ImpostaContrattoEPartTime(ContrPartTime: TContrattoPartTime; EsisteContratto: Boolean);
    procedure ImpostaStraordinarioEsterno(SE: Integer);
    procedure CaricaComboCausaliPresenza;
    procedure AggiornaDettaglioCausalePresenza;
    procedure GetTotaliPresenza;
  end;

implementation

uses WA029USchedaRiepilDM;

{$R *.dfm}

{ TWA029FSchedaRiepilDettFM }
procedure TWA029FSchedaRiepilDettFM.IWFrameRegionCreate(Sender: TObject);
var s: String;
begin
  grdFasce.medpPaginazione:=False;
  grdFasce.medpElencoCampiVisibili('D_FASCIA,ORELAVORATE,ORE1ASSEST,ORE2ASSEST,TOTALE');
  grdFasce.OnConferma:=OnConfermaGrdFasce;
  //medpAttivaGrid eseguito in abilitacomponenti (INHERITED richiama abilita componenti che esegue l'attiva grid)
  grdIndennita.medpElencoCampiVisibili('D_FASCIA,OREINDTURNO');
  grdIndennita.OnConferma:=OnConfermaGrdIndennita;

  grdStraord.medpElencoCampiVisibili('D_FASCIA,OREECCEDGIORN,STRMESE,ORESTRAORDLIQ,LIQUIDNELMESE,STRANNOAUT,STRANNOLIQ,STRDALIQ');
  grdStraord.OnConferma:=OnConfermaGrdStraord;
  inherited;

  //MultiColumnCombo con medpAutoResetItems = false. caricamento solo all'inizio
  cmbCausale1MinAss.Items.Clear;
  cmbCausale2MinAss.Items.Clear;
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW.selT305 do
  begin
    First;
    while not Eof do
    begin
      s:=FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString;
      cmbCausale1MinAss.AddRow(s);
      cmbCausale2MinAss.AddRow(s);
      Next;
    end;
  end;
  with (WR302DM as TWA029FSchedaRiepilDM) do
  begin
    dedtOreEsclCompMese.DataSource:=A029FSchedaRiepilMW.dsrT073Comp;
    dedtGettoneResiduo.DataSource:=A029FSchedaRiepilMW.dsrT073Comp;
  end;

  //Fasce
  //Si aggiunge +1 perchè in modifica compare la colonna con i bottoni di editing
  //Formati gestiti da editMask del Campo del dataset
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('ORELAVORATE')+1,0,DBG_EDT,'','','','','D');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('ORE1ASSEST')+1,0,DBG_EDT,'','','','','D');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('ORE2ASSEST')+1,0,DBG_EDT,'','','','','D');
  //Indennita presenza
  if (not Parametri.ModuloInstallato['TORINO_CSI']) then
  begin
    lnkIndennitaPresenza.CSS:='intestazione';
    lnkIndennitaPresenza.OnClick:=nil;
  end;
  grdIndennitaPresenza.medpPreparaComponenteGenerico('WR102',grdIndennitaPresenza.medpIndexColonna('D_INDPRES')+1,0,DBG_LBL,'20','1','null','','S');
  grdIndennitaPresenza.medpPreparaComponenteGenerico('WR102',grdIndennitaPresenza.medpIndexColonna('CODINDPRES')+1,0,DBG_MECMB,'5','2','','','S');
  grdIndennitaPresenza.medpPreparaComponenteGenerico('WR102',grdIndennitaPresenza.medpIndexColonna('INDPRES')+1,0,DBG_EDT,'','','','','S');
  grdIndennitaPresenza.medpPreparaComponenteGenerico('WR102',grdIndennitaPresenza.medpIndexColonna('INDSUPP_RESTO')+1,0,DBG_EDT,'','','','','S');
  //Indennita
  grdIndennita.medpPreparaComponenteGenerico('WR102',grdIndennita.medpIndexColonna('OREINDTURNO')+1,0,DBG_EDT,'','','','','S');
  //Straordinario
  grdStraord.medpPreparaComponenteGenerico('WR102',grdStraord.medpIndexColonna('OREECCEDGIORN')+1,0,DBG_EDT,'','','','','S');
  grdStraord.medpPreparaComponenteGenerico('WR102',grdStraord.medpIndexColonna('LIQUIDNELMESE')+1,0,DBG_EDT,'','','','','S');
  //Straordinario esterno
  grdStraordinarioEsterno.medpPreparaComponenteGenerico('WR102',grdStraordinarioEsterno.medpIndexColonna('CENTROCOSTO')+1,0,DBG_MECMB,'5','2','','','S');
  grdStraordinarioEsterno.medpPreparaComponenteGenerico('WR102',grdStraordinarioEsterno.medpIndexColonna('D_CENTROCOSTO')+1,0,DBG_LBL,'20','1','null','','S');
  grdStraordinarioEsterno.medpPreparaComponenteGenerico('WR102',grdStraordinarioEsterno.medpIndexColonna('ORESTRAORD')+1,0,DBG_EDT,'','','','','S');
  //Riep Presenze
  grdCauPresPaghe.medpPreparaComponenteGenerico('WR102',grdCauPresPaghe.medpIndexColonna('VOCEPAGHE')+1,0,DBG_CMB,'10','','','','S');
  grdCauPresPaghe.medpPreparaComponenteGenerico('WR102',grdCauPresPaghe.medpIndexColonna('CAUSALE')+1,0,DBG_LBL,'20','1','null','','S');
  grdCauPresPaghe.medpPreparaComponenteGenerico('WR102',grdCauPresPaghe.medpIndexColonna('ORE')+1,0,DBG_EDT,'','','','','S');

  IntestazioneGrdPresAnnue;
  grdPresAnnueTot.Cell[0,0].Text:='Totali';
  grdPresLiqTot.Cell[0,0].Text:='';
  grdPresLiqTot.Cell[0,1].Text:='Totali';

  (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW.CalcolaDati;
  //tabs
  grdTabDetail.AggiungiTab('Saldi',WA029SaldiRG);
  grdTabDetail.AggiungiTab('Indennità',WA029IndennitaRG);
  grdTabDetail.AggiungiTab('Straordinario',WA029StraordinarioRG);
  grdTabDetail.AggiungiTab('Straordinario esterno/Banca ore',WA029StraordinarioEsternoRG);
  grdTabDetail.AggiungiTab('Riep. presenze',WA029RiepPresenzeRG);
  grdTabDetail.ActiveTab:=WA029SaldiRG;
  grdTabDetail.Tabs[WA029SaldiRG].Enabled:=Parametri.A029_Saldi = 'S';
  grdTabDetail.Tabs[WA029IndennitaRG].Enabled:=Parametri.A029_Indennita = 'S';
  grdTabDetail.Tabs[WA029StraordinarioRG].Enabled:=Parametri.A029_Straordinario = 'S';
  grdTabDetail.Tabs[WA029StraordinarioEsternoRG].Enabled:=Parametri.A029_Straordinario = 'S';
  grdTabDetail.Tabs[WA029RiepPresenzeRG].Enabled:=Parametri.A029_CauPresenza = 'S';
end;

procedure TWA029FSchedaRiepilDettFM.IWFrameRegionRender(Sender: TObject);
var
  LCodeJs: String;
begin
  inherited;

  // correzioni grid
  LCodeJs:=DimensionaGridTotali(grdFasce.HTMLName,grdTotaliFasce.HTMLName,not grdFasce.medpComandiEdit) + #13#10 +
           DimensionaGridTotali(grdStraord.HTMLName,grdTotaliStraord.HTMLName, not grdStraord.medpComandiEdit) + #13#10 +
           DimensionaGridTotali(grdOreCompensabili.HTMLName,grdTotOreCompensabili.HTMLName, False) + #13#10 +
           DimensionaGridTotali(grdPresAnnue.HTMLName,grdPresAnnueTot.HTMLName, False) + #13#10;
           //DimensionaGridTotali(grdPresLiq.HTMLName,grdPresLiqTot.HTMLName, not grdPresLiq.medpComandiEdit);

  // v1.
  JQuery.OnReady.Text:=LCodeJs;
  // v2.
  (*
  LCodeJs:=Format('$(window).load(function() { alert("window.load!"); %s });',[LCodeJs]);
  (Owner as TWR100FBase).AddToInitProc(LCodeJs);
  *)

  C190VisualizzaElemento(JQuery,'divOreLavorateTurno', grdIndennita.Visible);
end;

//In caso di tabelle autoedit, la realtiva tabella dei totali ha una colonna in più
//per paddare nel caso ci sia la colonna comandi
//quando sono in browse la prima colonna va nascosta
function TWA029FSchedaRiepilDettFM.DimensionaGridTotali(Tabella,TabellaTotali:String; HideFirst:boolean): String;
var sInc: String;
begin
  sInc:='';
 if HideFirst then
 begin
  sInc:='+1';
  Result:=' $("table#TBL' + TabellaTotali + ' tr").eq(0).find("td").eq(0).hide(); ';
 end;

 Result:=Result + ' $("table#TBL' + Tabella + ' tr:first th").each(function( index ) { $("table#TBL' + TabellaTotali + ' tr").eq(0).find("td").eq(index' + sinc + ').width($(this).width() + "px");}) ';
end;

procedure TWA029FSchedaRiepilDettFM.AbilitaComponenti;
var editSelTabella,
    tmpEdit: Boolean;
    i: Integer;
begin
  inherited;
  with (WR302DM as TWA029FSchedaRiepilDM) do
  begin
    editSelTabella:=selTabella.State in [dsEdit,dsInsert];
    grdFasce.medpAttivaGrid(A029FSchedaRiepilMW.selT071,editSelTabella,False,False);
    tmpEdit:=(editSelTabella) and (not A029FSchedaRiepilMW.selT072.ReadOnly);
    grdIndennitaPresenza.medpAttivaGrid(A029FSchedaRiepilMW.selT072, tmpEdit,tmpEdit,tmpEdit);
    grdIndennita.medpAttivaGrid(A029FSchedaRiepilMW.selT071,editSelTabella,False,False);
    tmpEdit:=(editSelTabella) and (not A029FSchedaRiepilMW.selT077.ReadOnly);
    grdDatiScheda.medpAttivaGrid(A029FSchedaRiepilMW.selT077,tmpEdit,False,False);
    grdStraord.medpAttivaGrid(A029FSchedaRiepilMW.selT071,editSelTabella,False,False);

    btnLiquidazioneAutomatica.Enabled:=(not editSelTabella) and (not A029FSchedaRiepilMW.LiquidBloccata) and (not A029FSchedaRiepilMW.BloccoT071S);

    tmpEdit:=(editSelTabella) and (not A029FSchedaRiepilMW.selT075.ReadOnly);
    grdStraordinarioEsterno.medpAttivaGrid(A029FSchedaRiepilMW.selT075,tmpEdit,tmpEdit,tmpEdit);

    //Riepilogo presenze
    //i componenti cambiano per ogni record. non posso fare preparacomponente generico in create ma lo devo fare di volta in volta
    if Trim(A029FSchedaRiepilMW.selT074.SQL.Text) = '' then
      A029FSchedaRiepilMW.FascePresenza;
    //Caratto. devo inibire l'eventi di scroll altrimenti si scatena in cascata
    A029FSchedaRiepilMW.selT074.AfterScroll:=nil;
    tmpEdit:=(SelTabella.State in [dsEdit,dsInsert]) and (not A029FSchedaRiepilMW.selT074.ReadOnly);
    grdFascePresenza.medpAttivaGrid(A029FSchedaRiepilMW.selT074,tmpEdit,tmpEdit,tmpEdit);
    A029FSchedaRiepilMW.selT074.AfterScroll:=A029FSchedaRiepilMW.selT074AfterScroll;

    grdFascePresenza.medpCancellaRigaWR102;
    // i campi sono dinamici.
    for i:=0 to grdFascePresenza.medpDataSet.Fields.Count - 1 do
    begin
      if UpperCase(grdFascePresenza.medpDataSet.Fields[i].FieldName) = 'CAUSALE' then
        grdFascePresenza.medpPreparaComponenteGenerico('WR102',grdFascePresenza.medpIndexColonna('CAUSALE'),0,DBG_MECMB,'5','2','','','S')
      else if UpperCase(grdFascePresenza.medpDataSet.Fields[i].FieldName) = 'D_CAUSALE' then
        grdFascePresenza.medpPreparaComponenteGenerico('WR102',grdFascePresenza.medpIndexColonna('D_CAUSALE'),0,DBG_LBL,'20','1','null','','S')
      else if UpperCase(grdFascePresenza.medpDataSet.Fields[i].FieldName) <> 'TOTALE' then
        grdFascePresenza.medpPreparaComponenteGenerico('WR102',grdFascePresenza.medpIndexColonna(grdFascePresenza.medpDataSet.Fields[i].FieldName),0,DBG_EDT,'input_hour_hhhhmm','1','null','','S')
    end;

    //Riep presenze liquidate
    tmpEdit:=(editSelTabella) and (not A029FSchedaRiepilMW.selT074Liq.ReadOnly);
    grdPresLiq.medpAttivaGrid(A029FSchedaRiepilMW.selT074Liq,tmpEdit,False,False);

    //Riep presenze riepilogate a blocchi per fasce orarie
    tmpEdit:=(editSelTabella) and (not A029FSchedaRiepilMW.selT076.ReadOnly);
    grdCauPresPaghe.medpAttivaGrid(A029FSchedaRiepilMW.selT076,tmpEdit,tmpEdit,tmpEdit);

    cmbCausPresenza.ReadOnly:=False;
    cmbCausPresenza.Enabled:=True;

    btnLimitiIndividuali.Enabled:=not editSelTabella;
    btnOreLiqAnniPrec.Enabled:=not editSelTabella;
    btnSaldiMobiliCausale.Enabled:=btnSaldiMobiliCausale.Visible;
    btnLiquidazioniAnnue.Enabled:=True;
    //Caratto. devo inibire l'eventi di scroll altrimenti si scatena in cascata
    A029FSchedaRiepilMW.selT074.AfterScroll:=nil;
    btnAttivaLiquidazione.Enabled:=(not editSelTabella) and
                                   (cmbCausPresenza.Text <> '') and
                                   (A029FSchedaRiepilMW.TipoOreCausalizzate in [tocEscluse,tocIncluse]) and
                                   (A029FSchedaRiepilMW.selT074.Lookup('Causale',cmbCausPresenza.Text,'Causale') = null);

    A029FSchedaRiepilMW.selT074.AfterScroll:=A029FSchedaRiepilMW.selT074AfterScroll;

    //eseguito sia qui che in visualizzadati;
    //va abilitato/disabilitato in base al record corrente.
    //i pulsanti vengono automaticamente abilitati se in modifica, quindi inibisco se non abiliutato
    btnSaldiMobili.Enabled:=(A029FSchedaRiepilMW.R450DtM1.MesiSaldoPrec >= 0) and (A029FSchedaRiepilMW.R450DtM1.PeriodicitaAbbattimento = 'M');
  end;
  //campi readOnly anche in modifica
  edtDebitoCompl.ReadOnly:=True;
  edtOreLavorate.ReadOnly:=True;
  edtOrePresenza.ReadOnly:=True;
  edtSaldoMese.ReadOnly:=True;
  edtMesePrec.ReadOnly:=True;
  edtSaldoAnnoPrec.ReadOnly:=True;
  edtSaldoAnnoCorr.ReadOnly:=True;
  edtSaldoAnno.ReadOnly:=True;
  edtOrePerse.ReadOnly:=True;
  edtOreTroncate.ReadOnly:=True;
  edtOreAddebitate.ReadOnly:=True;
  edtOreEsclComp.ReadOnly:=True;
  edtVariazioneSaldo.ReadOnly:=True;
  edtLiqOreAnniPrec.ReadOnly:=True;
  edtRipComNonFruiti.ReadOnly:=True;
  edtAbbRipComMes.ReadOnly:=True;
  edtSaldoRipCom.ReadOnly:=True;
  edtDebPOAnno.ReadOnly:=True;
  edtResiduoPOAnno.ReadOnly:=True;
  edtResoPOMese.ReadOnly:=True;
  edtResoPOAnno.ReadOnly:=True;
  edtVarEccLiqAnno.ReadOnly:=True;
  edtLiquidazioniAnnue.ReadOnly:=True;
  edtStrAutAnn.ReadOnly:=True;
  edtStrAutMen.ReadOnly:=True;
  edtEccResAutMen.ReadOnly:=True;
  edtOreCausalizzateEsterneLiq.ReadOnly:=True;
  edtEccCompMese.ReadOnly:=True;
  edtEccCompAnno.ReadOnly:=True;
  edtEccResidua.ReadOnly:=True;
  edtStraordLiquid.ReadOnly:=True;
  edtStraordEsterno.ReadOnly:=True;
  edtBancaOreCausEsc.ReadOnly:=True;
  edtBancaOreRecInterna.ReadOnly:=True;
  edtBancaOreMaturata.ReadOnly:=True;
  edtBancaOreResiduaPrec.ReadOnly:=True;
  edtBancaOreRecuperata.ReadOnly:=True;
  edtBancaOreResiduaCorr.ReadOnly:=True;
  edtBancaOreLiquidata.ReadOnly:=True;
  edtBancaOreResidua.ReadOnly:=True;
  edtBancaOreCausEscAnno.ReadOnly:=True;
  edtOreEsclCompMeseEff.ReadOnly:=True;
  edtRecuperoAnno.ReadOnly:=True;
  edtOreEsclCompAnnoEff.ReadOnly:=True;
  edtOreEsclCompAnno.ReadOnly:=True;
  lnkIndennitaPresenza.Enabled:=True;
end;

procedure TWA029FSchedaRiepilDettFM.cmbCauPresPagheAsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  cmb: TMeIWComboBox;
begin
  cmb:=(Sender as TMeIWComboBox);
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    grdCauPresPaghe.medpDataset.FieldByName('VOCEPAGHE').AsString:=cmb.Items[cmb.ItemIndex];
   (grdCauPresPaghe.medpCompCella(cmb.Tag,grdCauPresPaghe.medpIndexColonna('CAUSALE'),0) as TmeIWLabel).Caption:=grdCauPresPaghe.medpDataset.FieldByName('CAUSALE').AsString;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.cmbCausaleMinAssAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  //necessario l'evento async perchè se si modifica grdFasce si scatena l'evento
  //BDEQ070DEBITOORARIOValidate in seguito all'impostazione dei campi ORE1ASSEST
  //e ORE2ASSEST di selT071.
  // Esso controlla che siano valorizzato CAUSALE1MINASS se si imposta ORE1ASSEST e
  //che sia valorizzato CAUSALE2MINASS se si imposta ORE2ASSEST
  with (WR302DM AS TWA029FSchedaRiepilDM).selTabella do
  begin
    FieldByName('CAUSALE1MINASS').AsString:=cmbCausale1MinAss.Text;
    FieldByName('CAUSALE2MINASS').AsString:=cmbCausale2MinAss.Text;
  end;
  ImpostaHintComboCausaleAssenza;
end;

procedure TWA029FSchedaRiepilDettFM.ImpostaHintComboCausaleAssenza;
begin
  if cmbCausale1MinAss.ItemIndex = -1 then
    cmbCausale1MinAss.Hint:=''
  else
    cmbCausale1MinAss.Hint:=cmbCausale1MinAss.Items[cmbCausale1MinAss.ItemIndex].RowData[1];
  if cmbCausale2MinAss.ItemIndex = -1 then
    cmbCausale2MinAss.Hint:=''
  else
    cmbCausale2MinAss.Hint:=cmbCausale2MinAss.Items[cmbCausale2MinAss.ItemIndex].RowData[1];
end;

procedure TWA029FSchedaRiepilDettFM.cmbCausPresenzaChange(Sender: TObject;
  Index: Integer);
var
  CodiceCausPresenza,
  OreNormali: String;
  tmpEdit: Boolean;
begin
  with (WR302DM AS TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    CodiceCausPresenza:=cmbCausPresenza.Text;
    OreNormali:=CambioCausPresenza(CodiceCausPresenza);

    lblOreEscluseIncluse.Caption:=CaptionOreIncluseEscluse(OreNormali);
    btnSaldiMobiliCausale.Visible:=(OreNormali = 'A') and (selT275.Lookup('Codice',CodiceCausPresenza,'Periodicita_Abbattimento') >= 0);
    lblLiquidazioneBloccata.Visible:=PresenzaLiquidataSuccessiva;
    btnAttivaLiquidazione.Enabled:=LiquidazioneAttiva(CodiceCausPresenza);
    //su webpj aggiornare grdPresLiq
    grdPresLiq.medpAggiornaCDS(True);
    GetTotaliPresenza;
    selT073Comp.ReadOnly:=(selT073Comp.RecordCount = 0) or
                         (TipoOreCausalizzate in [tocCompensabili,tocIncluse]) or
                          (PresenzaLiquidataSuccessiva) or
                           BloccoT074 ;

    if (WR302DM.selTabella.State in [dsInsert, dsEdit]) and
       (not selT073Comp.ReadOnly) then
      selT073Comp.Edit;

    //Riep presenze liquidate - bugfix: ripete medpAttivaGrid al cambio di causale
    tmpEdit:=((WR302DM AS TWA029FSchedaRiepilDM).selTabella.State in [dsEdit,dsInsert]) and (not selT074Liq.ReadOnly);
    grdPresLiq.medpAttivaGrid(selT074Liq,tmpEdit,False,False);
  end;
end;

procedure TWA029FSchedaRiepilDettFM.cmbCausPresenzeAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var cmb: TMedpIWMultiColumnComboBox;
begin
  cmb:=(Sender as TMedpIWMultiColumnComboBox);
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    grdFascePresenza.medpDataset.FieldByName('CAUSALE').AsString:=cmb.Text;
   (grdFascePresenza.medpCompCella(cmb.Tag,grdFascePresenza.medpIndexColonna('D_CAUSALE'),0) as TmeIWLabel).Caption:=grdFascePresenza.medpDataset.FieldByName('D_CAUSALE').AsString;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.DataSet2Componenti;
begin
  //Per la visualizzazione si usa VisualizzaDatiCalcolati.
  //Fatto qui perchè alucni settaggi eseguiti dopo calcoladati su mw e quindi nella procedura
  //VisualizzaDatiCalcolati le variabili booleane di controllo non sono ancora impostatre
  with (WR302DM AS TWA029FSchedaRiepilDM) do
  begin
    lblLiquidStrBloccata.Visible:=A029FSchedaRiepilMW.LiquidBloccata;
    btnLiquidazioneAutomatica.Enabled:=(not A029FSchedaRiepilMW.LiquidBloccata) and (not A029FSchedaRiepilMW.BloccoT071S);
    dedtBancaOreLiqVar.Visible:=A029FSchedaRiepilMW.BancaOreVariazioneLiqVisibile;
    lblBancaOreLiqVar.Visible:=dedtBancaOreLiqVar.Visible;
    lblLiquidCompBloccata.Visible:=A029FSchedaRiepilMW.LiquidCompBloccata;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.dedtOreEsclCompMeseAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  //devo forzare un submit per aggiornare
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnOnChangeCompensabile.HTMLName]));
end;

procedure TWA029FSchedaRiepilDettFM.edtAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  with (WR302DM AS TWA029FSchedaRiepilDM) do
  begin
    if (SelTabella.State in [dsInsert,dsEdit]) then
      A029FSchedaRiepilMW.CalcolaDati;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.GetTotaliPresenza;
var i: Integer;
  PresenzeAnnue: TPresenzeAnnue;
begin
  //Lettura ore liquidate e calcolo totale
  PresenzeAnnue:=(WR302DM AS TWA029FSchedaRiepilDM).A029FSchedaRiepilMW.TotaliPresenza(cmbCausPresenza.Text, True, dedtOreEsclCompMese.Text);
  if Length(PresenzeAnnue.FascePresenza) = 0 then
  begin
    edtOreEsclCompAnno.Text:='';
    edtOreEsclCompAnnoEff.Text:='';
    edtOreEsclCompMeseEff.Text:='';
    edtRecuperoAnno.Text:='';
    Exit;
  end;

  edtOreEsclCompAnno.Text:=R180MinutiOre(PresenzeAnnue.CompensabileAnno);
  edtOreEsclCompAnnoEff.Text:=R180MinutiOre(PresenzeAnnue.CompensabileAnnoEff);
  edtOreEsclCompMeseEff.Text:=R180MinutiOre(PresenzeAnnue.CompensabileMeseEff);
  edtRecuperoAnno.Text:=R180MinutiOre(PresenzeAnnue.RecuperoAnno);

  with grdPresAnnue do
  begin
    RowCount:=Length(PresenzeAnnue.FascePresenza) + 1;
    for i:=0 to Length(PresenzeAnnue.FascePresenza) - 1 do
    begin
      //Webpj ha una colonna in meno che win (la prima cella vuota non viene creata)
      Cell[i+1,0].Text:=PresenzeAnnue.FascePresenza[i].Fascia;
      Cell[i+1,1].Text:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].OreRese);
      Cell[i+1,2].Text:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].AnnoPrec);
      Cell[i+1,3].Text:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].Liquidabile);
      Cell[i+1,4].Text:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].Liquidato);
      Cell[i+1,5].Text:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].Residuo);
      Cell[i+1,6].Text:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].OrePerse);
      Cell[i+1,7].Text:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].BancaOre);
    end;
  end;

  grdPresLiqTot.Cell[0,2].Text:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.LiquidatoMese);

  with grdPresAnnueTot do
  begin
    //Webpj ha una colonna in meno che win (la prima cella vuota non viene creata)
    Cell[0,1].Text:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Ore);
    Cell[0,2].Text:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.AnnoPrec);
    Cell[0,3].Text:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Liquidabile);
    Cell[0,4].Text:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Liquidato);
    Cell[0,5].Text:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Residuo);
    Cell[0,6].Text:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Abbattimento);
    Cell[0,7].Text:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.OreBO);
  end;
end;

procedure TWA029FSchedaRiepilDettFM.VisualizzaDatiCalcolati(Totali: TTotali);
var i: Integer;
    tmpEdit: Boolean;
begin
  with (WR302DM AS TWA029FSchedaRiepilDM) do
  begin
    if selTabella.FieldByName('DATA').AsDateTime <> 0 then
      lblData.Caption:=FormatDateTime('mmmm yyyy',selTabella.FieldByName('DATA').AsDateTime)
    else
      lblData.Caption:='';

    //Pagina 'Saldi'
    edtDebitoCompl.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.DebTotMes);
    edtOreLavorate.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.TotOreRes);
    edtOrePresenza.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.TotOreRes - R180OreMinutiExt(selTabella.FieldByName('OreAssenze').AsString));
    edtSaldoMese.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.SalMeseAtt);
    edtMesePrec.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.salfmprec);
    edtSaldoAnnoPrec.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.salcompannoprec + A029FSchedaRiepilMW.R450DtM1.salliqannoprec);
    edtSaldoAnnoCorr.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.salcompannoatt + A029FSchedaRiepilMW.R450DtM1.salliqannoatt);
    edtSaldoAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.SalAnnoAtt);
    edtOrePerse.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.OrePersePeriodiche);
    edtOreTroncate.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.OreTroncate);
    edtOreAddebitate.Text:=Format('%s (%s)',[R180MinutiOre(R180OreMinutiExt(selTabella.FieldByName('AddebitoPaghe').AsString)),R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.AddebitoPaghe)]);
    edtOreEsclComp.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.OreEsclComp);
    edtVariazioneSaldo.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.VariazioneSaldo);
    edtLiqOreAnniPrec.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.LiqOreAnniPrec);
    btnSaldiMobili.Enabled:=(A029FSchedaRiepilMW.R450DtM1.MesiSaldoPrec >= 0) and (A029FSchedaRiepilMW.R450DtM1.PeriodicitaAbbattimento = 'M');
    edtRipComNonFruiti.Text:=FloatToStr(A029FSchedaRiepilMW.R450DtM1.RiposiNonFruitiGG) + ' (' + R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.RiposiNonFruitiOre) + ')';
    edtAbbRipComMes.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.abbripcommes + A029FSchedaRiepilMW.R450DtM1.RipComLiqMes);
    edtSaldoRipCom.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.salripcom);
    edtdebPOAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.DebPOAnno);
    edtResiduoPOAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.debpoannores);
    edtResoPOMese.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.debpoeff);
    edtResoPOAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.DebPOAnno - A029FSchedaRiepilMW.R450DtM1.debpoannores);

    cmbCausale1MinAss.Text:=selTabella.FieldByName('CAUSALE1MINASS').AsString;
    cmbCausale2MinAss.Text:=selTabella.FieldByName('CAUSALE2MINASS').AsString;
    ImpostaHintComboCausaleAssenza;
    lblRipComFasce.Visible:=Trim(A029FSchedaRiepilMW.R450DtM1.CausRipComFasce) <> '';
    lblRipComFasce.Caption:='per il riepilogo/liquid. in fasce vedere caus. ' + A029FSchedaRiepilMW.R450DtM1.CausRipComFasce;

    grdTotaliFasce.Cell[0,0].Text:='';
    grdTotaliFasce.Cell[0,1].Text:='Totali fasce';
    grdTotaliFasce.Cell[0,2].Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.TotOreResOri);
    grdTotaliFasce.Cell[0,3].Text:=R180MinutiOre(totali.TotAss1);
    grdTotaliFasce.Cell[0,4].Text:=R180MinutiOre(totali.TotAss2);
    grdTotaliFasce.Cell[0,5].Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.TotOreResOri + totali.TotAss1 + totali.TotAss2);

    //Pagina 'Straordinario'
    edtVarEccLiqAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.VarEccLiqAnno);
    edtStrAutAnn.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.EccAutAnno['LIQUIDABILE']);
    edtStrAutMen.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.StrAutMenNoCau);
    edtEccResAutMen.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.EccResAutMen);
    edtOreCausalizzateEsterneLiq.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.OreCausLiqSenzaLimiti);
    edtEccCompMese.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.CompensabileMensileNettoRiposi);
    edtEccCompAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.EccSoloCompAnno);
    edtEccResidua.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.EccSoloCompRes);

    with A029FSchedaRiepilMW.A029FLiquidazione do
    begin
      GetOreLiquidate(selTabella.FieldByname('Progressivo').AsInteger, selTabella.FieldByname('Data').AsDateTime);
      edtLiquidazioniAnnue.Text:=R180MinutiOre(LiqT070 + LiqT071Anno + LiqT074Anno + AssT071Anno);
    end;

    grdTotaliStraord.Cell[0,0].Text:='';
    grdTotaliStraord.Cell[0,1].Text:='Totali fasce';
    grdTotaliStraord.Cell[0,2].Text:=R180MinutiOre(totali.TotStrEcc);
    grdTotaliStraord.Cell[0,3].Text:=R180MinutiOre(totali.TotStrMes);
    grdTotaliStraord.Cell[0,4].Text:=R180MinutiOre(totali.TotStrLiq);
    grdTotaliStraord.Cell[0,5].Text:=R180MinutiOre(totali.TotLiqNelMese);
    grdTotaliStraord.Cell[0,6].Text:=R180MinutiOre(totali.TotStrAut);
    grdTotaliStraord.Cell[0,7].Text:=R180MinutiOre(totali.TotStrAnn);
    grdTotaliStraord.Cell[0,8].Text:=R180MinutiOre(totali.TotStrAut - totali.TotStrAnn);
    edtStraordLiquid.Text:=R180MinutiOre(totali.TotStrMes);

    //Pagina 'Straordinario esterno'

    grdOreCompensabili.RowCount:=A029FSchedaRiepilMW.R450DtM1.NFasceMese + 1;

    grdOreCompensabili.Cell[0,0].Text:='Fasce';
    grdOreCompensabili.Cell[0,1].Text:='Ore';
    for i:=1 to A029FSchedaRiepilMW.R450DtM1.NFasceMese do
    begin
      grdOreCompensabili.Cell[i,0].Text:=Format('%s (%d%%)',[A029FSchedaRiepilMW.R450DtM1.tFasce[i],A029FSchedaRiepilMW.R450DtM1.tMaggioraz[i]]);
      grdOreCompensabili.Cell[i,1].Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.tbancaore[i]);
    end;
    grdTotOreCompensabili.Cell[0,0].Text:='Totale';
    grdTotOreCompensabili.Cell[0,1].Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreMese);

    edtBancaOreCausEsc.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BOMaturataCausEsterne);
    edtBancaOreRecInterna.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreRecInternaMensile);
    edtBancaOreMaturata.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreAnno);
    edtBancaOreResiduaPrec.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreResiduaPrec);
    edtBancaOreRecuperata.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreRecuperata);
    edtBancaOreResiduaCorr.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreResidua);
    edtBancaOreLiquidata.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreLiquidata);
    edtBancaOreResidua.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreResidua + A029FSchedaRiepilMW.R450DtM1.BancaOreResiduaPrec);
    edtBancaOreCausEscAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BOMaturataCausEsterneAnno);

    //metodo richiamato anche su asyn change. in quel caso non posso aggiornare le grid che causerebbero errore
    if not GGetWebApplicationThreadVar.IsCallBack then
    begin
      //Caricamento solo se non sono in modifica della grid
      //su medpconferma imposta i campi sul dataset e scatena l'ìenvento dataChange che ricalcola e rivisualizza i dati
      if (grdFasce.medpStato = msBrowse) then
        grdFasce.medpAggiornaCDS(True);

      if (grdStraord.medpStato = msBrowse) then
        grdStraord.medpAggiornaCDS(True);

      if (grdIndennita.medpStato = msBrowse) then
        grdIndennita.medpAggiornaCDS(True);

      //Pagina 'Indennità'
      if (not A029FSchedaRiepilMW.selT072.CachedUpdates) then
        grdIndennitaPresenza.medpAggiornaCDS(True);
      //il selT077 è sempre in cachedUpdate
      if grdDatiScheda.medpStato = msBrowse then
        grdDatiScheda.medpAggiornaCDS(True);
      //il selT075 è sempre in cachedUpdate
      if grdStraordinarioEsterno.medpStato = msBrowse then
        grdStraordinarioEsterno.medpAggiornaCDS(True);
      //Pagina 'Riep presenze'
      if Trim(A029FSchedaRiepilMW.selT074.SQL.Text) = '' then
        A029FSchedaRiepilMW.FascePresenza;
      //Caratto. devo inibire l'eventi di scroll altrimenti si scatena in cascata
      A029FSchedaRiepilMW.selT074.AfterScroll:=nil;
      //le colonne di questa grid cambiano per ogni record. quindi ripeto qui attiva grid
      tmpEdit:=(SelTabella.State in [dsEdit,dsInsert]) and (not A029FSchedaRiepilMW.selT074.ReadOnly);
      grdFascePresenza.medpAttivaGrid(A029FSchedaRiepilMW.selT074,tmpEdit,tmpEdit,tmpEdit);
      A029FSchedaRiepilMW.selT074.AfterScroll:=A029FSchedaRiepilMW.selT074AfterScroll;

      if grdCauPresPaghe.medpStato = msBrowse then
        grdCauPresPaghe.medpAggiornaCDS(True);

      if grdPresLiq.medpStato = msBrowse then
        grdPresLiq.medpAggiornaCDS(True);
    end;

    GetTotaliPresenza;
    VisualizzaDatiBloccati;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.ImpostaContrattoEPartTime(
  ContrPartTime: TContrattoPartTime; EsisteContratto: Boolean);
begin
  lblContratto.Caption:='Contratto: ';
  lblPartTime.Caption:='Part time: ';

  if ContrPartTime.CodContratto <> '' then
  begin
    lblContratto.Caption:=lblContratto.Caption + Format('%s %s',[ContrPartTime.CodContratto,ContrPartTime.DescContratto]);
    lblPartTime.Caption:=lblPartTime.Caption + Format('%s %s',[ContrPartTime.CodPartTime,ContrPartTime.DescPartTime]);
  end;

  if EsisteContratto then
  begin
    try
      with (WR302DM AS TWA029FSchedaRiepilDM) do
      begin
        grdIndennita.Visible:=A029FSchedaRiepilMW.selT200.FieldByName('Tipo').AsString <> 'USL';
        lblOreLavorateTurno.Visible:=grdIndennita.Visible;
        if A029FSchedaRiepilMW.selT200.FieldByName('Tipo').AsString = 'USL' then
          lblIndennitaTurno.Caption:='Indennità notturna'
        else
          lblIndennitaTurno.Caption:='Indennità di turno';
      end;
    //Gestisco il caso che non sia stato aperto il contratto
    except
      grdIndennita.Visible:=False;
      lblOreLavorateTurno.Visible:=grdIndennita.Visible;
      lblIndennitaTurno.Caption:='Indennità di turno';
    end;
  end
  else
  begin
    grdIndennita.Visible:=False;
    lblOreLavorateTurno.Visible:=grdIndennita.Visible;
    lblIndennitaTurno.Caption:='Indennità di turno';
  end;
  //FATTO SU RENDER C190VisualizzaElemento(JQuery,'divOreLavorateTurno', grdIndennita.Visible);
end;

procedure TWA029FSchedaRiepilDettFM.OnConfermaGrdFasce(Sender: TObject);
var r: Integer;
begin
  r:=grdFasce.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  // comportamento standard
  grdFasce.medpConferma(r);
  with (WR302DM AS TWA029FSchedaRiepilDM) do
    OnChangeSelT071;
end;

procedure TWA029FSchedaRiepilDettFM.OnConfermaGrdIndennita(Sender: TObject);
var r: Integer;
begin
  r:=grdIndennita.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  // comportamento standard
  grdIndennita.medpConferma(r);
  with (WR302DM AS TWA029FSchedaRiepilDM) do
    OnChangeSelT071;
end;

procedure TWA029FSchedaRiepilDettFM.OnConfermaGrdStraord(Sender: TObject);
var r: Integer;
begin
  r:=grdStraord.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  // comportamento standard
  grdStraord.medpConferma(r);
  with (WR302DM AS TWA029FSchedaRiepilDM) do
    OnChangeSelT071;
end;

procedure TWA029FSchedaRiepilDettFM.RenderGrid(ACell: TIWGridCell; const ARow,
  AColumn: Integer);
var NumColonna, LCol: Integer;
    Agrid: TmedpIWDBGrid;
begin
  Agrid:=TmedpIWDBGrid(ACell.Grid);
  if not Agrid.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=Agrid.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(Agrid.medpCompGriglia) + 1) and (Agrid.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=Agrid.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  // dimensionamento fisso grid liquidaz. fasce
  if Agrid = grdPresLiq then
  begin
    LCol:=AColumn + IfThen(not grdPresLiq.medpComandiEdit,1);
    case LCol of
      0: ACell.Width:='50';
      1: ACell.Width:='70';
      2: ACell.Width:='70';
    end;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.Componenti2DataSet;
begin
  with (WR302DM as TWA029FSchedaRiepilDM).selTabella do
  begin
    FieldByName('CAUSALE1MINASS').AsString:=cmbCausale1MinAss.Text;
    FieldByName('CAUSALE2MINASS').AsString:=cmbCausale2MinAss.Text;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.grdCauPresPagheDataSet2Componenti(
  Row: Integer);
var combo: TMeIWComBoBox;
    idx: Integer;
begin
  inherited;
  combo:=(grdCauPresPaghe.medpCompCella(Row,grdCauPresPaghe.medpIndexColonna('VOCEPAGHE'),0) as TMeIWComBoBox );
  combo.Tag:=Row;
  combo.Items.Clear;
  combo.NoSelectionText:='';
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    selT276.First;
    while not selT276.Eof do
    begin
      if combo.Items.IndexOf(selT276.FieldByName('VOCEPAGHE').AsString) = -1 then
      begin
        idx:=combo.Items.Add(selT276.FieldByName('VOCEPAGHE').AsString);
        if selT276.FieldByName('VOCEPAGHE').AsString = grdCauPresPaghe.medpDataSet.FieldByName('VOCEPAGHE').AsString then
          combo.ItemIndex:=idx;
      end;
      selT276.Next;
    end;
    combo.OnAsyncChange:=cmbCauPresPagheAsyncChange;
  end;
  //Descrizione
  (grdCauPresPaghe.medpCompCella(Row,grdCauPresPaghe.medpIndexColonna('CAUSALE'),0) as TmeIWLabel).Caption:=grdCauPresPaghe.medpValoreColonna(Row, 'CAUSALE');
end;

procedure TWA029FSchedaRiepilDettFM.grdFascePresenzaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var c,i:Integer;
begin
  inherited;
  c:=grdFascePresenza.medpIndexColonna('DBG_COMANDI');
  if c <> -1 then
    for i:=0 to High(grdFascePresenza.medpCompGriglia) do
      if grdFascePresenza.medpValoreColonna(i,'TIPO_RECORD') = 'A' then
        if grdFascePresenza.medpCompGriglia[i].CompColonne[c] <> nil then
          FreeAndNil(grdFascePresenza.medpCompGriglia[i].CompColonne[c]);
end;

procedure TWA029FSchedaRiepilDettFM.grdFascePresenzaDataSet2Componenti(
  Row: Integer);
var combo: TMedpIWMultiColumnComboBox;
begin
  inherited;
  //il campo causale è modificabile solo in inserimento. in modifica viene messo a readonly da dsrT074.StateChange
  //Quindi la combo non è istanziata
  if not grdFascePresenza.medpDataSet.FieldByName('CAUSALE').ReadOnly then
  begin
    combo:=(grdFascePresenza.medpCompCella(Row,grdFascePresenza.medpIndexColonna('CAUSALE'),0) as TMedpIWMultiColumnComboBox );
    combo.Tag:=Row;
    combo.Items.Clear;
    combo.PopupHeight:=10;

    with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
    begin
      selT275.First;
      while not selT275.Eof do
      begin
        combo.AddRow(selT275.FieldByName('CODICE').AsString + ';' + selT275.FieldByName('DESCRIZIONE').AsString);
        selT275.Next;
      end;
      combo.Text:=grdStraordinarioEsterno.medpDataSet.FieldByName('CENTROCOSTO').AsString;
      combo.OnAsyncChange:=cmbCausPresenzeAsyncChange;
    end;
  end;
  //Descrizione
  (grdFascePresenza.medpCompCella(Row,grdFascePresenza.medpIndexColonna('D_CAUSALE'),0) as TmeIWLabel).Caption:=grdFascePresenza.medpValoreColonna(Row, 'D_CAUSALE');
end;

procedure TWA029FSchedaRiepilDettFM.grdIndennitaPresenzaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i,c:Integer;
begin
  inherited;
  c:=grdIndennitaPresenza.medpIndexColonna('DBG_COMANDI');
  if c <> -1 then
    for i:=0 to High(grdIndennitaPresenza.medpCompGriglia) do
      if grdIndennitaPresenza.medpValoreColonna(i,'TIPO_RECORD') = 'A' then
        if grdIndennitaPresenza.medpCompGriglia[i].CompColonne[c] <> nil then
          FreeAndNil(grdIndennitaPresenza.medpCompGriglia[i].CompColonne[c]);
end;

procedure TWA029FSchedaRiepilDettFM.grdIndennitaPresenzaDataSet2Componenti(
  Row: Integer);
var combo: TMedpIWMultiColumnComboBox;
begin
  inherited;
  combo:=(grdIndennitaPresenza.medpCompCella(Row,grdIndennitaPresenza.medpIndexColonna('CODINDPRES'),0) as TMedpIWMultiColumnComboBox );
  combo.Tag:=Row;
  combo.Items.Clear;
  combo.PopupHeight:=10;

  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    selT162.First;
    while not selT162.Eof do
    begin
      combo.AddRow(selT162.FieldByName('CODICE').AsString + ';' + selT162.FieldByName('DESCRIZIONE').AsString);
      selT162.Next;
    end;
    combo.Text:=grdIndennitaPresenza.medpDataSet.FieldByName('CODINDPRES').AsString;
    combo.OnAsyncChange:=cmbCodIndPresAsyncChange;
  end;
  //Descrizione
  (grdIndennitaPresenza.medpCompCella(Row,grdIndennitaPresenza.medpIndexColonna('D_INDPRES'),0) as TmeIWLabel).Caption:=grdIndennitaPresenza.medpValoreColonna(Row, 'D_INDPRES');
end;

procedure TWA029FSchedaRiepilDettFM.grdOreCompensabiliRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if not C190RenderCell(ACell,ARow,AColumn,True,False,False) then
    Exit;

  if AColumn = 0 then
    ACell.Css:='riga_intestazione';
end;

procedure TWA029FSchedaRiepilDettFM.grdPresAnnueRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  if not C190RenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;
end;

procedure TWA029FSchedaRiepilDettFM.grdPresLiqAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
begin
  inherited;
  cmbCauspresenza.Enabled:=True;
end;

procedure TWA029FSchedaRiepilDettFM.grdPresLiqComponenti2DataSet(Row: Integer);
begin
  inherited;
  cmbCauspresenza.Enabled:=True;
end;

procedure TWA029FSchedaRiepilDettFM.grdPresLiqDataSet2Componenti(Row: Integer);
begin
  inherited;
  cmbCauspresenza.Enabled:=False;
end;

procedure TWA029FSchedaRiepilDettFM.grdStraordinarioEsternoDataSet2Componenti(
  Row: Integer);
var combo: TMedpIWMultiColumnComboBox;
begin
  inherited;
  combo:=(grdStraordinarioEsterno.medpCompCella(Row,grdStraordinarioEsterno.medpIndexColonna('CENTROCOSTO'),0) as TMedpIWMultiColumnComboBox );
  combo.Tag:=Row;
  combo.Items.Clear;
  combo.PopupHeight:=10;

  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    QLook75.First;
    while not QLook75.Eof do
    begin
      combo.AddRow(QLook75.FieldByName('CODICE').AsString + ';' + QLook75.FieldByName('DESCRIZIONE').AsString);
      QLook75.Next;
    end;
    combo.Text:=grdStraordinarioEsterno.medpDataSet.FieldByName('CENTROCOSTO').AsString;
    combo.OnAsyncChange:=cmbCodStrEstAsyncChange;
  end;
  //Descrizione
  (grdStraordinarioEsterno.medpCompCella(Row,grdStraordinarioEsterno.medpIndexColonna('D_CENTROCOSTO'),0) as TmeIWLabel).Caption:=grdStraordinarioEsterno.medpValoreColonna(Row, 'D_CENTROCOSTO');
end;

procedure TWA029FSchedaRiepilDettFM.grdTabDetailTabControlChange(
  Sender: TObject);
begin
  //VisualizzaDatiCalcolati serve per aggiornare le griD che in async non possono essere aggiornate
  VisualizzaDatiCalcolati((WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW.TotaliCalcolati);
  VisualizzaDatiBloccati;
end;

procedure TWA029FSchedaRiepilDettFM.VisualizzaDatiBloccati;
var S:String;
begin
  S:='';
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    if grdTabDetail.ActiveTab = WA029SaldiRG then
    begin
      if BloccoT070 then
        S:=S + 'Scheda';
      if BloccoT071A then
        S:=S + StringReplace(R180Spaces('',Min(Length(S),1)),' ',', ',[]) + 'Assestamento';
    end;
    if grdTabDetail.ActiveTab = WA029IndennitaRG then
      if BloccoT070 then
        S:=S + 'Scheda';
    if grdTabDetail.ActiveTab = WA029StraordinarioRG then
    begin
      if BloccoT070 then
        S:=S + 'Scheda';
      if BloccoT071S then
        S:=S + StringReplace(R180Spaces('',Min(Length(S),1)),' ',', ',[]) + 'Liquid. straordinario';
    end;
    if grdTabDetail.ActiveTab = WA029StraordinarioEsternoRG then
      if BloccoT070 then
        S:=S + 'Scheda';
    if grdTabDetail.ActiveTab = WA029RiepPresenzeRG then
    begin
      if BloccoT070 then
        S:=S + 'Scheda';
      if BloccoT074 then
        S:=S + StringReplace(R180Spaces('',Min(Length(S),1)),' ',', ',[]) + 'Liquid. ore causalizzate';
    end;
    if S <> '' then
      S:='Dati bloccati: ' + S;
  end;

  (Self.Owner as TWR100FBase).MessaggioStatus(INFORMA,S);
end;

function TWA029FSchedaRiepilDettFM.VerificaGrdPending : Boolean;
begin
  Result:=False;

  if(grdFasce.medpStato <> msBrowse) or
    (grdIndennita.medpStato <> msBrowse) or
    (grdIndennitaPresenza.medpStato <> msBrowse) or
    (grdDatiScheda.medpStato <> msBrowse) or
    (grdStraord.medpStato <> msBrowse) or
    (grdStraordinarioEsterno.medpStato <> msBrowse) or
    (grdFascePresenza.medpStato <> msBrowse) or
    (grdCauPresPaghe.medpStato <> msBrowse) or
    (grdPresLiq.medpStato <> msBrowse) then
    Result:=True;

end;
procedure TWA029FSchedaRiepilDettFM.grdTabDetailTabControlChanging(
  Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  //Verifico che le tabelle non siano in fase di edit;
  //questo perchè vi sono tabelle che operano sullo stesso dataset e quindi
  //non posso modificare contemporaneamente i dati
  if VerificaGrdPending then
  begin
    AllowChange:=False;
    MsgBox.WebMessageDlg(A000MSG_ERR_GRID_PENDING,mtInformation,[mbOk],nil,'');
  end;
end;

procedure TWA029FSchedaRiepilDettFM.grdTotaliRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  procedure SetCSSAlign(dgrd:TmedpIWDBGrid);
  var NumColonna:Integer;
  begin
    if (WR302DM as TWA029FSchedaRiepilDM).selTabella.State = dsBrowse then
      NumColonna:=dgrd.medpNumColonna(AColumn - 1)
    else
      NumColonna:=dgrd.medpNumColonna(AColumn);
    if (dgrd.medpColonna(NumColonna) <> nil) and (dgrd.medpClientDataSet.FindField(dgrd.medpColonna(NumColonna).DataField) <> nil) then
      if dgrd.medpClientDataSet.FindField(dgrd.medpColonna(NumColonna).DataField).Alignment = taCenter then
        ACell.Css:=ACell.Css + ' align_center'
      else if dgrd.medpClientDataSet.FindField(dgrd.medpColonna(NumColonna).DataField).Alignment = taRightJustify then
        ACell.Css:=ACell.Css + ' align_right';
  end;
begin
  inherited;
  ACell.Css:=StringReplace(ACell.Css,'riga_intestazione','',[rfReplaceAll]);
  ACell.Css:=Trim(ACell.Css + ' riga_intestazione');

  ACell.Css:=StringReplace(ACell.Css,'align_left','',[rfReplaceAll]);
  ACell.Css:=StringReplace(ACell.Css,'align_right','',[rfReplaceAll]);
  ACell.Css:=StringReplace(ACell.Css,'align_center','',[rfReplaceAll]);
  if ACell.Grid = grdTotaliFasce then
    SetCSSAlign(grdFasce)
  else if ACell.Grid = grdTotaliStraord then
    SetCSSAlign(grdStraord)
  else if ACell.Grid = grdPresLiqTot then
    SetCSSAlign(grdPresLiq);

  // dimensionamento fisso grid liquidaz. fasce
  if ACell.Grid = grdPresLiqTot then
  begin
    case AColumn of
      0: if grdPresLiq.medpComandiEdit then
         begin
           ACell.Css:=StringReplace(ACell.Css,'invisibile','',[rfReplaceAll]);
           ACell.Width:='50';
         end
         else
           ACell.Css:='invisibile';
      1: ACell.Width:='70';
      2: ACell.Width:='70';
    end;
  end;
end;

//cambio label sul cambio della combo
procedure TWA029FSchedaRiepilDettFM.cmbCodIndPresAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var cmb: TMedpIWMultiColumnComboBox;
begin
  cmb:=(Sender as TMedpIWMultiColumnComboBox);
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    grdIndennitaPresenza.medpDataset.FieldByName('CODINDPRES').AsString:=cmb.Text;
   (grdIndennitaPresenza.medpCompCella(cmb.Tag,grdIndennitaPresenza.medpIndexColonna('D_INDPRES'),0) as TmeIWLabel).Caption:=grdIndennitaPresenza.medpDataset.FieldByName('D_INDPRES').AsString;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.cmbCodStrEstAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var cmb: TMedpIWMultiColumnComboBox;
begin
  cmb:=(Sender as TMedpIWMultiColumnComboBox);
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    grdStraordinarioEsterno.medpDataset.FieldByName('CENTROCOSTO').AsString:=cmb.Text;
   (grdStraordinarioEsterno.medpCompCella(cmb.Tag,grdStraordinarioEsterno.medpIndexColonna('D_CENTROCOSTO'),0) as TmeIWLabel).Caption:=grdStraordinarioEsterno.medpDataset.FieldByName('D_CENTROCOSTO').AsString;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.ImpostaStraordinarioEsterno(SE: Integer);
begin
  edtStraordEsterno.Text:=R180MinutiOre(SE);
  edtStrEst.Text:=R180MinutiOre(SE);

  if R180OreMinutiExt(edtStraordEsterno.Text) > R180OreMinutiExt(edtStraordLiquid.Text) then
    MsgBox.WebMessageDlg(A000MSG_A029_ERR_STRAORD_EST,mtError,[mbOk],nil,'');
end;

procedure TWA029FSchedaRiepilDettFM.CaricaComboCausaliPresenza;
var S: String;
    i: Integer;
begin
  cmbCausPresenza.Items.Clear;
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    for i:=0 to High(R450DtM1.RiepPres) do
    begin
      if R450DtM1.RiepPres[i].Causale = '' then
        Break;
      cmbCausPresenza.AddRow(R450DtM1.RiepPres[i].Causale + ';' + VarToStr(selT275.Lookup('Codice',R450DtM1.RiepPres[i].Causale,'Descrizione')));
    end;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.AggiornaDettaglioCausalePresenza;
var i:Integer;
begin
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    if selT074Liq.State = dsEdit then
      exit;

    lblOreEscluseIncluse.Caption:='';

    TipoOreCausalizzate:=tocCompensabili;
    selT074Liq.ReadOnly:=True;
    selT073Comp.ReadOnly:=True;
    lblLiquidazioneBloccata.Visible:=False;
    btnAttivaLiquidazione.Enabled:=False;

    grdPresAnnue.RowCount:=2;
    grdPresAnnue.Clear;
    IntestazioneGrdPresAnnue;

    grdPresAnnueTot.Cell[0,1].Text:='00.00';
    grdPresAnnueTot.Cell[0,2].Text:='00.00';
    grdPresAnnueTot.Cell[0,3].Text:='00.00';
    grdPresAnnueTot.Cell[0,4].Text:='00.00';
    grdPresAnnueTot.Cell[0,5].Text:='00.00';
    grdPresAnnueTot.Cell[0,6].Text:='00.00';
    grdPresAnnueTot.Cell[0,7].Text:='00.00';
    grdPresLiqTot.Cell[0,2].Text:='00.00';

    cmbCausPresenza.ItemIndex:=-1;
    for i:=0 to cmbCausPresenza.Items.Count - 1 do
    begin
      if cmbCausPresenza.Items[i].RowData[0] =  selT074.FieldByName('Causale').AsString then
      begin
        cmbCausPresenza.ItemIndex:=i;
        cmbCausPresenzaChange(nil,cmbCausPresenza.ItemIndex);
        Break;
      end;
    end;
    if (cmbCausPresenza.ItemIndex = -1) and (cmbCausPresenza.Items.Count > 0) then
    begin
      cmbCausPresenza.ItemIndex:=0;
      cmbCausPresenzaChange(nil,cmbCausPresenza.ItemIndex);
    end;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.btnAttivaLiquidazioneClick(Sender: TObject);
begin
  with (WR302DM as TWA029FSchedaRiepilDM) do
  begin
    A029FSchedaRiepilMW.AttivaLiquidazione(cmbCausPresenza.Text);
    //Caratto 30/05/2013 Su applyrecord setta i campi a 00.00 ma la griglia
    //fasce presenza viene caricata su afterpost di T074. quindi devo forzare ricaricamento
    grdFascePresenza.medpAggiornaCDS(True);
  end;
end;

procedure TWA029FSchedaRiepilDettFM.btnLimitiIndividualiClick(Sender: TObject);
var
  Progressivo: Integer;
begin
  Progressivo:=(WR302DM as TWA029FSchedaRiepilDM).selTabella.FieldByName('PROGRESSIVO').AsInteger;
  (Self.Parent as TWR100FBase).AccediForm(43,'PROGRESSIVO='+IntToStr(Progressivo),True);
end;

procedure TWA029FSchedaRiepilDettFM.btnLiquidazioneAutomaticaClick(Sender: TObject);
//var WA029FInputValoreFM : TWA029FInputValoreFM;
  var WC020FInputDataOreFM : TWC020FInputDataOreFM;
begin
  (* Massimo 22/07/2013 : utilizzo della maschera generica WC020
  WA029FInputValoreFM:=TWA029FInputValoreFM.Create(Self.Parent);
  WA029FInputValoreFM.InputOre(grdTotaliStraord.Cell[0,8].Text);
  WA029FInputValoreFM.ResultEvent:=ResultOreLiquidazione;
  WA029FInputValoreFM.Visualizza;
  *)
  WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self.Parent);
  WC020FInputDataOreFM.ImpostaCampiOre('Ore di straordinario da liquidare:',grdTotaliStraord.Cell[0,8].Text);
  WC020FInputDataOreFM.ResultEvent:=ResultOreLiquidazione;
  WC020FInputDataOreFM.Visualizza('Liquidazione automatica per fasce');
end;

procedure TWA029FSchedaRiepilDettFM.btnLiquidazioniAnnueClick(Sender: TObject);
begin
  WA029FRecuperiMobiliFM:=TWA029FRecuperiMobiliFM.Create(Self.Parent);
  with (WR302DM as TWA029FSchedaRiepilDM) do
    WA029FRecuperiMobiliFM.LiquidazioniAnnue(A029FSchedaRiepilMW.A029FLiquidazione);
  WA029FRecuperiMobiliFM.Visualizza;
end;

procedure TWA029FSchedaRiepilDettFM.btnOnChangeCompensabileClick(
  Sender: TObject);
begin
  if dedtOreEsclCompMese.DataSource.State = dsEdit then
  begin
    dedtOreEsclCompMese.DataSource.DataSet.Post;
    dedtOreEsclCompMese.DataSource.DataSet.Edit;
  end;

end;

procedure TWA029FSchedaRiepilDettFM.btnOreLiqAnniPrecClick(Sender: TObject);
var
  Progressivo: Integer;
begin
  Progressivo:=(WR302DM as TWA029FSchedaRiepilDM).selTabella.FieldByName('PROGRESSIVO').AsInteger;
  (Self.Parent as TWR100FBase).AccediForm(168,'PROGRESSIVO='+IntToStr(Progressivo),True);
end;

procedure TWA029FSchedaRiepilDettFM.btnSaldiMobiliCausaleClick(Sender: TObject);
begin
  WA029FRecuperiMobiliFM:=TWA029FRecuperiMobiliFM.Create(Self.Parent);
  with (WR302DM as TWA029FSchedaRiepilDM) do
    WA029FRecuperiMobiliFM.SaldiMobiliCausale(cmbCausPresenza.Text, selTabella.FieldByName('DATA').AsDateTime,A029FSchedaRiepilMW.R450DtM1);
  WA029FRecuperiMobiliFM.Visualizza;
end;

procedure TWA029FSchedaRiepilDettFM.btnSaldiMobiliClick(Sender: TObject);
begin
  WA029FRecuperiMobiliFM:=TWA029FRecuperiMobiliFM.Create(Self.Parent);
  with (WR302DM as TWA029FSchedaRiepilDM) do
    WA029FRecuperiMobiliFM.SaldiMobili(selTabella.FieldByName('DATA').AsDateTime,A029FSchedaRiepilMW.R450DtM1);
  WA029FRecuperiMobiliFM.Visualizza;
end;

procedure TWA029FSchedaRiepilDettFM.IntestazioneGrdPresAnnue;
begin
  with grdPresAnnue do
  begin
    ColumnCount:=8;
    Cell[0,0].Text:='Fascia';
    Cell[0,1].Text:='Ore rese';
    Cell[0,2].Text:='Anno prec.';
    Cell[0,3].Text:='Liquidabile';
    Cell[0,4].Text:='Liquidato';
    Cell[0,5].Text:='Residuo';
    Cell[0,6].Text:='Ore perse';
    Cell[0,7].Text:='Banca Ore';
    Cell[0,0].Width:='50';
    Cell[0,1].Width:='48';
    Cell[0,2].Width:='56';
    Cell[0,3].Width:='56';
    Cell[0,4].Width:='50';
    Cell[0,5].Width:='50';
    Cell[0,6].Width:='48';
    Cell[0,7].Width:='56';
  end;
end;

procedure TWA029FSchedaRiepilDettFM.ResultOreLiquidazione(Sender: TObject;Result: Boolean; Valore: String);
var Msg: String;
begin
  if (not Result) then
    Exit;
  try
    OreLiq:=R180OreMinutiExt(Valore);
  except
    raise Exception.Create(A000MSG_A029_ERR_ORE_LIQ);
  end;

  if OreLiq = 0 then
    exit;

  //Controllo supero della disponibilità calcolata
  if OreLiq > R180OreMinutiExt(grdTotaliStraord.Cell[0,8].Text) then
    raise Exception.Create(A000MSG_A029_ERR_SUPERO_LIQ);

  //Controllo il supero dei limiti annuali e mensili individuali
  with (WR302DM as TWA029FSchedaRiepilDM) do
  begin
    Msg:=A029FSchedaRiepilMW.A029FLiquidazione.LimiteIndividualeStraordinario(selTabella.FieldByName('PROGRESSIVO').AsInteger,OreLiq,OreLiq,0,selTabella.FieldByName('DATA').AsDateTime);
    if Msg <> '' then
    begin
      if Parametri.LiquidazioneForzata = 'S' then
      begin
        Msg:=Msg + 'Confermare?';
        MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaLiquidazioneAutomatica,'');
      end
      else
        MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
  LiquidazioneAutomaticaBudget;
end;

procedure TWA029FSchedaRiepilDettFM.ResultConfermaLiquidazioneAutomatica(
  Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    LiquidazioneAutomaticaBudget;
end;

procedure TWA029FSchedaRiepilDettFM.LiquidazioneAutomaticaBudget;
begin
  with (WR302DM as TWA029FSchedaRiepilDM) do
  begin
    // controlli sul budget
    if A029FSchedaRiepilMW.Budget then
    begin
      // simula la liquidazione per calcolare l'importo da confrontare con il budget
      // la funzione carica la struttura dati in A029FBudgetDtM1 per effettuare il calcolo dell'importo
      // richiesto in base alla distribuzione delle ore in fasce
      A029FSchedaRiepilMW.ImpostaLiquidazione;
      A029FSchedaRiepilMW.A029FLiquidazione.Liquidazione(True,selTabella.FieldByName('DATA').AsDateTime,selTabella.FieldByName('PROGRESSIVO').AsInteger,-1,OreLiq,'');
      ImpLiq:=A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.CtrlLiqGetImporto(selTabella.FieldByName('PROGRESSIVO').AsInteger,selTabella.FieldByName('DATA').AsDateTime);
      if Parametri.CampiRiferimento.C2_Facoltativo = 'N' then
      begin
        A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(True,selTabella.FieldByName('PROGRESSIVO').AsInteger,selTabella.FieldByName('DATA').AsDateTime,OreLiq,ImpLiq);
      end
      else if Parametri.CampiRiferimento.C2_Facoltativo = 'S' then
      begin
        MsgBox.WebMessageDlg(A000MSG_A029_DLG_GEST_BUDGET,mtConfirmation,[mbYes,mbNo],ResultConfermaLiquidazioneAutomaticaBudget,'');
        Abort;
      end;
    end;
    A029FSchedaRiepilMW.LiquidazioneAutomatica(False,OreLiq,ImpLiq);
  end;
end;

procedure TWA029FSchedaRiepilDettFM.lnkIndennitaPresenzaClick(Sender: TObject);
var WC015FSelEditGridFM:TWC015FSelEditGridFM;
begin
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    if OpenDettaglioGG then
    begin
      WC015FSelEditGridFM:=TWC015FSelEditGridFM.Create(Self.Parent);
      WC015FSelEditGridFM.Visualizza('Dettaglio giornaliero maturazione indennità',selUsrT072,False,False,False);
    end;
  end;
end;

procedure TWA029FSchedaRiepilDettFM.ResultConfermaLiquidazioneAutomaticaBudget(
  Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  with (WR302DM as TWA029FSchedaRiepilDM) do
    A029FSchedaRiepilMW.LiquidazioneAutomatica(Res = mrYes,OreLiq,ImpLiq);
end;

end.
