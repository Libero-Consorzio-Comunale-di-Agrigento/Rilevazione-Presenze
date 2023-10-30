unit WA020UCausPresenzeDettFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, DB, OracleData,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompGrids, meIWGrid, medpIWTabControl, IWDBStdCtrls,
  meIWDBLabel, medpIWMultiColumnComboBox, IWHTMLControls, meIWLink, IWCompEdit, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, meIWRegion, IWCompExtCtrls,
  IWDBExtCtrls, meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox, IWCompListbox, meIWDBComboBox,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, IWDBGrids, medpIWDBGrid, IWAdvRadioGroup,
  meTIWAdvRadioGroup,meIWComboBox, A000UMessaggi, meIWCheckBox, meIWImageButton,
  IWCompButton, meIWButton, WA020UCausPresenzeStorico, WC007UFormContainerFM;

type
  TWA020FCausPresenzeDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lnkRaggruppamento: TmeIWLink;
    cmbCodRaggr: TMedpIWMultiColumnComboBox;
    dlblRaggruppamento: TmeIWDBLabel;
    grdTabDetail: TmedpIWTabControl;
    WA020RegoleConteggioRG: TmeIWRegion;
    TemplateRegoleConteggioRG: TIWTemplateProcessorHTML;
    drgpCausSuTimbrature: TmeIWDBRadioGroup;
    lblCausSuTimbrature: TmeIWLabel;
    drgpOreNormali: TmeIWDBRadioGroup;
    lblOreNormali: TmeIWLabel;
    dchkConsideraSceltaOrario: TmeIWDBCheckBox;
    dchkRipFasce: TmeIWDBCheckBox;
    dchkMaturaMensa: TmeIWDBCheckBox;
    dchkTimbPMDetraz: TmeIWDBCheckBox;
    dchkTimbPM: TmeIWDBCheckBox;
    dchkLiquidabile: TmeIWDBCheckBox;
    dchkSempreAppoggiata: TmeIWDBCheckBox;
    dchkLimiteDebitoGG: TmeIWDBCheckBox;
    dchkEInFlessibilita: TmeIWDBCheckBox;
    dchkUsaFlessibilita: TmeIWDBCheckBox;
    dchkContMezzanotte: TmeIWDBCheckBox;
    dchkAutoCompletamentoUE: TmeIWDBCheckBox;
    dchkScostPuntiNominali: TmeIWDBCheckBox;
    lblArrotondamento: TmeIWLabel;
    dedtArrotondamento: TmeIWDBEdit;
    lblMinutiScostamento: TmeIWLabel;
    dedtScostamento: TmeIWDBEdit;
    dchkStaccoMinimoScost: TmeIWDBCheckBox;
    dchkFlessibilitaOrario: TmeIWDBCheckBox;
    dchkForzaNotteSpezzata: TmeIWDBCheckBox;
    lblOreInterneLimitate: TmeIWLabel;
    drgpNoEccedenzaInFascia: TmeIWDBRadioGroup;
    lblIntersezioneTimbrature: TmeIWLabel;
    drgpIntersezioneTimbrature: TmeIWDBRadioGroup;
    dchkNoEccedInFasciaConsAss: TmeIWDBCheckBox;
    WA020OpzioniRG: TmeIWRegion;
    TemplateOpzioniRG: TIWTemplateProcessorHTML;
    lblMinMinuti: TmeIWLabel;
    dedtMinMinuti: TmeIWDBEdit;
    lblMaxMinuti: TmeIWLabel;
    dedtMaxMinuti: TmeIWDBEdit;
    lblTipoMinMinimi: TmeIWLabel;
    drgpTipoMinMinimi: TmeIWDBRadioGroup;
    lblArrGG: TmeIWLabel;
    LblArrotondamento2: TmeIWLabel;
    dedtArrotondamento2: TmeIWDBEdit;
    dchkPerdiArr: TmeIWDBCheckBox;
    dchkArrFascie: TmeIWDBCheckBox;
    dchkEsclusioneFasciaObb: TmeIWDBCheckBox;
    lblSogliaFasceObblFac: TmeIWLabel;
    dedtSogliaFasceObblFac: TmeIWDBEdit;
    lblFlexTimbrCaus: TmeIWLabel;
    dcmbFlexTimbrCaus: TmeIWDBComboBox;
    lblGettoni: TmeIWLabel;
    lblGettOre: TmeIWLabel;
    dedtGettOre: TmeIWDBEdit;
    lblGettoneDalle: TmeIWLabel;
    dedtGettoneDalle: TmeIWDBEdit;
    lblGettoneAlle: TmeIWLabel;
    dedtGettoneAlle: TmeIWDBEdit;
    cmbGettIndennita: TMedpIWMultiColumnComboBox;
    lblGettIndennita: TmeIWLabel;
    dchkGettSpezzoni: TmeIWDBCheckBox;
    lblGettOreInf: TmeIWLabel;
    dgrpGettOreInf: TmeIWDBRadioGroup;
    lblGettOreSup: TmeIWLabel;
    dgrpGettOreSup: TmeIWDBRadioGroup;
    lblAutoCausalizzazione: TmeIWLabel;
    lblLinkAssenza: TmeIWLabel;
    cmbLinkAssenza: TMedpIWMultiColumnComboBox;
    dlblLinkAssenza: TmeIWDBLabel;
    lblAutogiustDalleAlle: TmeIWLabel;
    drgpAutogiustDalleAlle: TmeIWDBRadioGroup;
    dchkCompetenzeAutoGiust: TmeIWDBCheckBox;
    dchkIncludiIndTurno: TmeIWDBCheckBox;
    dchkPercInail: TmeIWDBCheckBox;
    dchkCompCausOreMax: TmeIWDBCheckBox;
    lblUnInserimento: TmeIWLabel;
    dchkUnInserimentoH: TmeIWDBCheckBox;
    dchkUnInserimentoD: TmeIWDBCheckBox;
    dchkCausalizzaTimbIntersecanti: TmeIWDBCheckBox;
    dchkTimbFittizie: TmeIWDBCheckBox;
    lblCumulaRichiesteWeb: TmeIWLabel;
    drgpCumulaRichiesteWeb: TmeIWDBRadioGroup;
    dlblDGettIndennita: TmeIWDBLabel;
    WA020FasceAutorizzRG: TmeIWRegion;
    TemplateFasceAutorizzRG: TIWTemplateProcessorHTML;
    grdFasce: TmedpIWDBGrid;
    drgpTipoNonAutorizzate: TmeIWDBRadioGroup;
    lblTipoNonAutorizzate: TmeIWLabel;
    drgpTipoUNonAutorizzate: TmeIWDBRadioGroup;
    lblTipoUNonAutorizzate: TmeIWLabel;
    lblControlloTimbTurno: TmeIWLabel;
    drgpControlloTimbTurno: TmeIWDBRadioGroup;
    lblCausFuoriTurno: TmeIWLabel;
    cmbCausFuoriTurno: TMedpIWMultiColumnComboBox;
    lblTurniPianificati: TmeIWLabel;
    dchkTurniPianificati: TmeIWDBCheckBox;
    dlblCausFuoriTurno: TmeIWDBLabel;
    WA020RiepilogoRG: TmeIWRegion;
    TemplateRiepilogoRG: TIWTemplateProcessorHTML;
    lblRiepilogoCartellino: TmeIWLabel;
    drgpRiepilogoCartellino: TmeIWDBRadioGroup;
    lblInclBudget: TmeIWLabel;
    lblTipoRichiestaWeb: TmeIWLabel;
    drgpTipoRichiestaWeb: TmeIWDBRadioGroup;
    dchkNoLimiteMensileLiq: TmeIWDBCheckBox;
    lblSigla: TmeIWLabel;
    dedtSigla: TmeIWDBEdit;
    dchkInclusioneSaldiCausali: TmeIWDBCheckBox;
    lblOreMassime: TmeIWLabel;
    dedtOreMassime: TmeIWDBEdit;
    dchkResiduoLiquidabile: TmeIWDBCheckBox;
    lblPeriodicitaAbbattimento: TmeIWLabel;
    dedtPeriodicitaAbbattimento: TmeIWDBEdit;
    WA020VociPagheRG: TmeIWRegion;
    TemplateVociPagheRG: TIWTemplateProcessorHTML;
    lblOreRese: TmeIWLabel;
    dedtFascia1: TmeIWDBEdit;
    lblFascia1: TmeIWLabel;
    lblFascia2: TmeIWLabel;
    dedtFascia2: TmeIWDBEdit;
    lblFascia3: TmeIWLabel;
    dedtFascia3: TmeIWDBEdit;
    lblFascia4: TmeIWLabel;
    dedtFascia4: TmeIWDBEdit;
    lblOreLiquidate: TmeIWLabel;
    dedtPagheLiq1: TmeIWDBEdit;
    lblPagheLiq1: TmeIWLabel;
    lblPagheLiq2: TmeIWLabel;
    dedtPagheLiq2: TmeIWDBEdit;
    lblPagheLiq3: TmeIWLabel;
    dedtPagheLiq3: TmeIWDBEdit;
    lblPagheLiq4: TmeIWLabel;
    dedtPagheLiq4: TmeIWDBEdit;
    lblVociSuddivise: TmeIWLabel;
    grdVociSuddivise: TmedpIWDBGrid;
    rgpInclBudget: TmeTIWAdvRadioGroup;
    lblCausCompDebitoGG: TmeIWLabel;
    cmbCausCompDebitoGG: TMedpIWMultiColumnComboBox;
    dchkForzaCausEccedenza: TmeIWDBCheckBox;
    dchkLiquidazioneMesiPrec: TmeIWDBCheckBox;
    dchkNoLimiteAnnualeLiq: TmeIWDBCheckBox;
    dchkInserimentoTimb: TmeIWDBCheckBox;
    dchkInserimentoTimbVirt: TmeIWDBCheckBox;
    dchkTimbPMH: TmeIWDBCheckBox;
    WA020ParamStoricizRG: TmeIWRegion;
    btnDecParStorPrec: TmeIWImageButton;
    btnDecParStorSucc: TmeIWImageButton;
    cmbDecParStor: TmeIWComboBox;
    chkVistaPeriodoCorr: TmeIWCheckBox;
    btnModificaParStor: TmeIWButton;
    TemplateParamStoricizRG: TIWTemplateProcessorHTML;
    grdParamStoriciz: TmedpIWDBGrid;
    procedure lnkRaggruppamentoClick(Sender: TObject);
    procedure cmbCodRaggrAsyncChange(Sender: TObject; EventParams: TStringList;Index: Integer; Value: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbGettIndennitaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbLinkAssenzaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure grdFasceRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure cmbCausFuoriTurnoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dchkLiquidabileClick(Sender: TObject);
    procedure dchkUnInserimentoDClick(Sender: TObject);
    procedure dchkSempreAppoggiataClick(Sender: TObject);
    procedure dchkMaturaMensaClick(Sender: TObject);
    procedure drgpCausSuTimbratureClick(Sender: TObject);
    procedure dchkGettSpezzoniClick(Sender: TObject);
    procedure dchkLimiteDebitoGGClick(Sender: TObject);
    procedure dchkEsclusioneFasciaObbClick(Sender: TObject);
    procedure dedtGettoneDalleAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure rgpInclBudgetClick(Sender: TObject);
    procedure grdFasceDataSet2Componenti(Row: Integer);
    procedure grdFasceComponenti2DataSet(Row: Integer);
    procedure grdVociSuddiviseDataSet2Componenti(Row: Integer);
    procedure grdVociSuddiviseComponenti2DataSet(Row: Integer);
    procedure drgpOreNormaliClick(Sender: TObject);
    procedure drgpControlloTimbTurnoClick(Sender: TObject);
    procedure dchkCausalizzaTimbIntersecantiClick(Sender: TObject);
    procedure dchkTimbFittizieClick(Sender: TObject);
    procedure cmbCausCompDebitoGGAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure dchkInserimentoTimbClick(Sender: TObject);
    procedure btnDecParStorPrecClick(Sender: TObject);
    procedure btnDecParStorSuccClick(Sender: TObject);
    procedure cmbDecParStorChange(Sender: TObject);
    procedure chkVistaPeriodoCorrClick(Sender: TObject);
    procedure WA020ParamStoricizRGRender(Sender: TObject);
    procedure btnModificaParStorClick(Sender: TObject);
  private
    WC007FM: TWC007FFormContainerFM;
    WA020FCausPresenzeStorico:TWA020FCausPresenzeStorico;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnComboBox; override;
    procedure AbilitaComponenti;override;
    procedure AbilitaOggettiGrpGettoni(Abilita: boolean);
    procedure cmbFasceAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure AbilitaCausFuoriTurno;
    procedure CaricaComboBox(CmbBox: TMedpIWMultiColumnComboBox; DataSet: TOracleDataSet);
    procedure ToggleControlliSchedaParStor(Attiva:Boolean);
    procedure OnWC007FMClose(Sender:TObject);
  public
    procedure AbilitazioneControlli(Sender: TObject);
    procedure AggiornaGridParamStoricizzati;
    procedure EvtStateChange;
  end;

implementation

uses WR100UBase, WA020UCausPresenze, WA020UCausPresenzeDM;

{$R *.dfm}

procedure TWA020FCausPresenzeDettFM.IWFrameRegionCreate(Sender: TObject);
var
  A020DM:TWA020FCausPresenzeDM;
begin
  inherited;
  grdTabDetail.AggiungiTab('Regole di conteggio',WA020RegoleConteggioRG);
  grdTabDetail.AggiungiTab('Opzioni',WA020OpzioniRG);
  grdTabDetail.AggiungiTab('Fasce di autorizzazione',WA020FasceAutorizzRG);
  grdTabDetail.AggiungiTab('Riepilogo Mensile',WA020RiepilogoRG);
  grdTabDetail.AggiungiTab('Voci Paghe',WA020VociPagheRG);
  grdTabDetail.AggiungiTab('Parametri storicizzati',WA020ParamStoricizRG);
  grdTabDetail.ActiveTab:=WA020RegoleConteggioRG;
  R180SetComboItemsValues(dcmbFlexTimbrCaus.Items,(WR302DM as TWA020FCausPresenzeDM).A020MW.D_FlexSogliaObblFac,'IV');

  A020DM:=((Owner as TWA020FCausPresenze).WR302DM as TWA020FCausPresenzeDM);
  grdParamStoriciz.medpAttivaGrid(A020DM.A020StoricoMW.cdsStoriaParamStorizz,
                                  False,
                                  False,
                                  False);
end;

procedure TWA020FCausPresenzeDettFM.AbilitaComponenti;
begin
  inherited;
  with (WR302DM as TWA020FCausPresenzeDM) do
  begin
    grdFasce.medpAttivaGrid(A020MW.SelT277,(selTabella.State in [dsEdit]),(selTabella.State in [dsEdit]));
    grdVociSuddivise.medpAttivaGrid(A020MW.selT276,(selTabella.State in [dsEdit]),(selTabella.State in [dsEdit]));
  end;
  // Prepara componenti grdVociSuddivise
  grdVociSuddivise.medpCancellaRigaWR102;
  grdVociSuddivise.medpPreparaComponentiDefault;
  grdVociSuddivise.medpPreparaComponenteGenerico('WR102',grdVociSuddivise.medpIndexColonna('TIPOGIORNO'),0,DBG_CMB,'5','','','','S');
  // Prepara componenti grdFasce
  grdFasce.medpPreparaComponentiDefault;
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('TIPO_GIORNO'),0,DBG_MECMB,'5','2','null','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('DESC_GIORNO'),0,DBG_LBL,'20','','null','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('FASCE_PN'),0,DBG_CMB,'5','','','','S');
  drgpOreNormali.ItemIndex:=drgpOreNormali.Values.IndexOf((WR302DM as TWA020FCausPresenzeDM).SelTabella.FieldByName('OreNormali').AsString);
  drgpCausSuTimbrature.ItemIndex:=drgpCausSuTimbrature.Values.IndexOf((WR302DM as TWA020FCausPresenzeDM).SelTabella.FieldByName('TipoConteggio').AsString);
  drgpControlloTimbTurno.ItemIndex:=drgpControlloTimbTurno.Values.IndexOf((WR302DM as TWA020FCausPresenzeDM).SelTabella.FieldByName('PIANIFREP').AsString);
  AbilitazioneControlli(nil);
end;

procedure TWA020FCausPresenzeDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWA020FCausPresenzeDM) do
  begin
    SelTabella.FieldByName('CodRaggr').AsString:=cmbCodRaggr.Text;
    SelTabella.FieldByName('GETTONE_INDENNITA').AsString:=cmbGettIndennita.Text;
    SelTabella.FieldByName('LINK_ASSENZA').AsString:=cmbLinkAssenza.Text;
    SelTabella.FieldByName('CAUS_FUORI_TURNO').AsString:=cmbCausFuoriTurno.Text;
    SelTabella.FieldByName('CAUSCOMP_DEBITOGG').AsString:=cmbCausCompDebitoGG.Text;
    if rgpInclBudget.ItemIndex = 0 then
      selTabella.FieldByName('Abbatte_Budget').AsString:='N'
    else if rgpInclBudget.ItemIndex = 1 then
      selTabella.FieldByName('Abbatte_Budget').AsString:='L'
    else if rgpInclBudget.ItemIndex = 2 then
      selTabella.FieldByName('Abbatte_Budget').AsString:='M'
    else if rgpInclBudget.ItemIndex = 2 then
      selTabella.FieldByName('Abbatte_Budget').AsString:='B';
  end;
end;

procedure TWA020FCausPresenzeDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWA020FCausPresenzeDM) do
  begin
    cmbCodRaggr.Text:=SelTabella.FieldByName('CodRaggr').AsString;
    cmbGettIndennita.Text:=SelTabella.FieldByName('GETTONE_INDENNITA').AsString;
    cmbLinkAssenza.Text:=SelTabella.FieldByName('LINK_ASSENZA').AsString;
    cmbCausFuoriTurno.Text:=SelTabella.FieldByName('CAUS_FUORI_TURNO').AsString;
    if selTabella.FieldByName('Abbatte_Budget'). AsString = 'N' then
      rgpInclBudget.ItemIndex:=0
    else if selTabella.FieldByName('Abbatte_Budget'). AsString = 'L' then
      rgpInclBudget.ItemIndex:=1
    else if selTabella.FieldByName('Abbatte_Budget'). AsString = 'M' then
      rgpInclBudget.ItemIndex:=2
    else if selTabella.FieldByName('Abbatte_Budget'). AsString = 'B' then
      rgpInclBudget.ItemIndex:=3;
    drgpOreNormali.ItemIndex:=drgpOreNormali.Values.IndexOf(SelTabella.FieldByName('OreNormali').AsString);
    drgpCausSuTimbrature.ItemIndex:=drgpCausSuTimbrature.Values.IndexOf(SelTabella.FieldByName('TipoConteggio').AsString);
    drgpControlloTimbTurno.ItemIndex:=drgpControlloTimbTurno.Values.IndexOf(SelTabella.FieldByName('PIANIFREP').AsString);
    cmbCausCompDebitoGG.Text:=SelTabella.FieldByName('CAUSCOMP_DEBITOGG').AsString;
  end;
  AbilitazioneControlli(nil);
  if grdFasce.medpDataSet <> nil then
    grdFasce.medpAggiornaCDS(True);
  if grdVociSuddivise.medpDataSet <> nil then
    grdVociSuddivise.medpAggiornaCDS(True);
end;

procedure TWA020FCausPresenzeDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with (WR302DM as TWA020FCausPresenzeDM).A020MW do
  begin
    CaricaComboBox(cmbCodRaggr,SelT270);
    CaricaComboBox(cmbGettIndennita,SelT162);
    CaricaComboBox(cmbLinkAssenza,SelT265);
    CaricaComboBox(cmbCausFuoriTurno,SelT275lkp);
    CaricaComboBox(cmbCausCompDebitoGG,selT275lkpOreNorm);
  end;
end;

procedure TWA020FCausPresenzeDettFM.AbilitazioneControlli(Sender:TObject);
begin
  //Opzioni - arrotondamento, fascia obbl/fac
  dedtArrotondamento.Enabled:=drgpOreNormali.ItemIndex = 0;
  lblArrotondamento.Enabled:=drgpOreNormali.ItemIndex = 0;
  dchkLimiteDebitoGG.Enabled:=drgpOreNormali.ItemIndex > 0;
  dchkNoLimiteMensileLiq.Enabled:=drgpOreNormali.ItemIndex in [1,3];
  drgpNoEccedenzaInFascia.Enabled:=(drgpCausSuTimbrature.ItemIndex in [0,4]) and (drgpOreNormali.ItemIndex > 0) and (not dchkLimiteDebitoGG.Checked);
  dchkNoEccedInFasciaConsAss.Enabled:=drgpNoEccedenzaInFascia.Enabled;
  dchkEsclusioneFasciaObb.Enabled:=(drgpOreNormali.ItemIndex = 0);// and (drgpCausSuTimbrature.ItemIndex in [0,4]);
  lblSogliaFasceObblFac.Enabled:=(drgpCausSuTimbrature.ItemIndex in [0,4]) and (drgpOreNormali.ItemIndex = 0);// and (not dchkEsclusioneFasciaObb.Checked);
  dedtSogliaFasceObblFac.Enabled:=lblSogliaFasceObblFac.Enabled;
  lblFlexTimbrCaus.Enabled:=(drgpCausSuTimbrature.ItemIndex in [0,4]) and (drgpOreNormali.ItemIndex = 0);// and (not dchkEsclusioneFasciaObb.Checked);
  dcmbFlexTimbrCaus.Enabled:=lblFlexTimbrCaus.Enabled;
  dchkPercInail.Enabled:=drgpOreNormali.ItemIndex = 0;
  dchkForzaCausEccedenza.Enabled:=drgpCausSuTimbrature.ItemIndex = 3;
  dchkCausalizzaTimbIntersecanti.Enabled:=dchkUnInserimentoD.Checked;
  dchkTimbFittizie.Enabled:=(dchkUnInserimentoD.Checked) (*and (DBRadioGroup1.ItemIndex in [1,2,3])*);
  if not dchkTimbFittizie.Enabled then
    dchkTimbFittizie.Checked:=False;
  dchkTimbPMDetraz.Enabled:=dchkMaturaMensa.Checked;
  //Abilitazione conteggio a cavallo di mezzanotte
  dchkContMezzanotte.Enabled:=drgpCausSuTimbrature.ItemIndex in [0,4];
  dchkUsaFlessibilita.Enabled:=drgpCausSuTimbrature.ItemIndex = 0;
  dchkEInFlessibilita.Enabled:=(drgpCausSuTimbrature.ItemIndex = 0) or
                               ((drgpCausSuTimbrature.ItemIndex in [1,2]) and dchkLiquidabile.Checked);
  if drgpCausSuTimbrature.ItemIndex in [1,2] then
    dchkEInFlessibilita.Caption:='Non considerare l''Entrata nella flessibilità'
  else
    dchkEInFlessibilita.Caption:='Entrata posticipata in flessibilità';
  dchkScostPuntiNominali.Enabled:=drgpCausSuTimbrature.ItemIndex = 0;
  dchkLiquidabile.Enabled:=not (drgpCausSuTimbrature.ItemIndex in [0,4]);
  dchkSempreAppoggiata.Enabled:=not (drgpCausSuTimbrature.ItemIndex in [0,4]);
  dchkAutoCompletamentoUE.Enabled:=drgpCausSuTimbrature.ItemIndex = 0;
  (*Alberto 30/10/2018: auto-causalizzazione disponibile per tutti i tipi di conteggio
  //Abilitazione Auto-causalizzazione
  lblLinkAssenza.Enabled:=drgpCausSuTimbrature.ItemIndex in [0,4];
  cmbLinkAssenza.Enabled:=drgpCausSuTimbrature.ItemIndex in [0,4];
  dlblLinkAssenza.Enabled:=drgpCausSuTimbrature.ItemIndex in [0,4];
  dchkCompetenzeAutoGiust.Enabled:=drgpCausSuTimbrature.ItemIndex in [0,4];
  *)
  //Abilitazione Integrazione con turni reperibilità
  with (WR302DM as TWA020FCausPresenzeDM) do
  begin
    if A020MW.selT270.SearchRecord('CODICE',VarArrayOf([A020MW.selT275.FieldByName('CODRAGGR').AsString]),[srFromBeginning]) then
      drgpControlloTimbTurno.Enabled:=(drgpCausSuTimbrature.ItemIndex in [1,2,3]) and
      ((A020MW.selT270.FieldByName('CODINTERNO').AsString = 'C') or (A020MW.selT270.FieldByName('CODINTERNO').AsString = 'D')or (A020MW.selT270.FieldByName('CODINTERNO').AsString = 'G'))
    else
      drgpControlloTimbTurno.Enabled:=drgpCausSuTimbrature.ItemIndex in [1,2,3];
  end;
  //Abilitazione gettoni
  AbilitaOggettiGrpGettoni(drgpCausSuTimbrature.ItemIndex in [1,2,3]);
  if drgpCausSuTimbrature.ItemIndex in [1,2,3] then
    dgrpGettOreInf.Enabled:=(not dchkGettSpezzoni.Checked) and (R180OreMinutiExt(dedtGettoneDalle.Text) = R180OreMinutiExt(dedtGettoneAlle.Text));
  with (WR302DM as TWA020FCausPresenzeDM) do
    if SelTabella.State in [dsEdit,dsInsert] then
    begin
      if not drgpNoEccedenzaInFascia.Enabled then
        SelTabella.FieldByName('NO_ECCEDENZA_IN_FASCIA').AsString:='N';
      if not dedtArrotondamento.Enabled then
        SelTabella.FieldByName('Arrotondamento').AsString:='';
      if not dchkEsclusioneFasciaObb.Enabled then
        SelTabella.FieldByName('ESCLUSIONE_FASCIA_OBB').AsString:='N';
      if not(drgpCausSuTimbrature.ItemIndex in [0,4]) then
      begin
        SelTabella.FieldByName('LFSCAVMEZ').AsString:='N';
        SelTabella.FieldByName('SENZA_FLESSIBILITA').AsString:='N';
        SelTabella.FieldByName('SCOST_PUNTI_NOMINALI').AsString:='N';
      end;
      if not dchkEInFlessibilita.Enabled then
        SelTabella.FieldByName('E_IN_FLESSIBILITA').AsString:='N';
      if not dchkLiquidabile.Enabled then
        SelTabella.FieldByName('LIQUIDABILE').AsString:='A';
      if not dchkSempreAppoggiata.Enabled then
        SelTabella.FieldByName('SEMPRE_APPOGGIATA').AsString:='N';
      if (Sender <> nil) and (Sender = dchkLiquidabile) and dchkLiquidabile.Checked then
        SelTabella.FieldByName('SEMPRE_APPOGGIATA').AsString:='N';
      if (Sender <> nil) and (Sender = dchkSempreAppoggiata) and dchkSempreAppoggiata.Checked then
        SelTabella.FieldByName('LIQUIDABILE').AsString:='A';
      if not drgpControlloTimbTurno.Enabled then
        SelTabella.FieldByName('PIANIFREP').AsString:='N';
    end;
  if (rgpInclBudget.ItemIndex >= 0) then
    if (rgpInclBudget.Values[rgpInclBudget.ItemIndex] = 'B') then
      lblOreRese.Caption:='Voce da fasce contrattuali - ore rese in banca ore'
    else
      lblOreRese.Caption:='Voce da fasce contrattuali - ore rese';
  if drgpOreNormali.ItemIndex >= 0 then
  begin
    (*Alberto 19/08/2014: Arrotondamento abilitato anche per causali incluse nelle normali
    DedtArrotondamento2.Enabled:=drgpOreNormali.Values[drgpOreNormali.ItemIndex] = 'A';
    dchkArrFascie.Enabled:=drgpOreNormali.Values[drgpOreNormali.ItemIndex] = 'A';
    dchkPerdiArr.Enabled:=drgpOreNormali.Values[drgpOreNormali.ItemIndex] = 'A';
    LblArrotondamento2.Enabled:=drgpOreNormali.Values[drgpOreNormali.ItemIndex] = 'A';
    *)

    if drgpOreNormali.Values[drgpOreNormali.ItemIndex] = 'A' then
      rgpInclBudget.EnabledItems[3]:=1
    else
      rgpInclBudget.EnabledItems[3]:=0;

    dchkInclusioneSaldiCausali.Enabled:=drgpOreNormali.Values[drgpOreNormali.ItemIndex] = 'A';
    if not dchkInclusioneSaldiCausali.Enabled then
      (WR302DM as TWA020FCausPresenzeDM).A020MW.selT275.FieldByName('INCLUSIONE_SALDI_CAUSALI').AsString:='N';
  end;
  dchkEsclusioneFasciaObb.Enabled:=(drgpOreNormali.ItemIndex = 0);
  lblPeriodicitaAbbattimento.Enabled:=(drgpOreNormali.ItemIndex = 0);
  dedtPeriodicitaAbbattimento.Enabled:=(drgpOreNormali.ItemIndex = 0);
  dchkLiquidazioneMesiPrec.Enabled:=(drgpOreNormali.ItemIndex = 0);

  dchkInserimentoTimbVirt.Enabled:=dchkInserimentoTimb.Checked;
  if WR302DM.selTabella.FieldByName('INSERIMENTO_TIMB').AsString = 'N' then //not dchkInserimentoTimb.Checked then
  begin
    dchkInserimentoTimbVirt.Checked:=False;
    WR302DM.selTabella.FieldByName('INSERIMENTO_TIMBVIRT').AsString:='N';
  end;

  //Massimo 23/05/2013: su Win 'AbilitaCausFuoriTurno' è legato anche all'evento change del radioGroup;
  //sul componente web quell'evento non esiste allora 'AbilitaCausFuoriTurno'
  //viene richiamata in questo punto e nel clik del RadioGroup.
  AbilitaCausFuoriTurno;
end;

procedure TWA020FCausPresenzeDettFM.AbilitaOggettiGrpGettoni(Abilita: boolean);
begin
  dedtGettOre.Enabled:=Abilita;
  dedtGettoneDalle.Enabled:=Abilita;
  dedtGettoneAlle.Enabled:=Abilita;
  cmbGettIndennita.Enabled:=Abilita;
  dchkGettSpezzoni.Enabled:=Abilita;
  dgrpGettOreInf.Enabled:=Abilita;
  dgrpGettOreSup.Enabled:=Abilita;
end;

procedure TWA020FCausPresenzeDettFM.lnkRaggruppamentoClick(Sender: TObject);
begin
  TWR100FBase(Self.Parent).AccediForm(108,'CODICE=' + cmbCodRaggr.Text); // OpenA018RaggrPres
end;

procedure TWA020FCausPresenzeDettFM.rgpInclBudgetClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.chkVistaPeriodoCorrClick(Sender: TObject);
var
  WA016DM:TWA020FCausPresenzeDM;
begin
  WA016DM:=(WR302DM as TWA020FCausPresenzeDM);
  if (WA016DM.selTabella.State = dsBrowse) and (WR302DM.selTabella.RecordCount > 0) then
  begin
    if chkVistaPeriodoCorr.Checked then
    begin
      cmbDecParStor.ItemIndex:=WA016DM.A020StoricoMW.IndiceDecorrenzaCorrente;
      cmbDecParStor.Enabled:=False;
      btnDecParStorPrec.Enabled:=False;
      btnDecParStorSucc.Enabled:=False;
      cmbDecParStor.OnChange(nil);
    end
    else
    begin
      cmbDecParStor.Enabled:=True;
      btnDecParStorPrec.Enabled:=True;
      btnDecParStorSucc.Enabled:=True;
    end;
  end;
end;

procedure TWA020FCausPresenzeDettFM.cmbCausCompDebitoGGAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  (WR302DM as TWA020FCausPresenzeDM).SelTabella.FieldByName('CAUSCOMP_DEBITOGG').AsString:=cmbCausCompDebitoGG.Text;
end;

procedure TWA020FCausPresenzeDettFM.cmbCausFuoriTurnoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWA020FCausPresenzeDM).SelTabella.FieldByName('CAUS_FUORI_TURNO').AsString:=cmbCausFuoriTurno.Text;
end;

procedure TWA020FCausPresenzeDettFM.cmbCodRaggrAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWA020FCausPresenzeDM).SelTabella.FieldByName('CodRaggr').AsString:=cmbCodRaggr.Text;
end;

procedure TWA020FCausPresenzeDettFM.cmbDecParStorChange(Sender: TObject);
var
  DataPeriodo:TDateTime;
begin
  (WR302DM as TWA020FCausPresenzeDM).A020StoricoMW.SvuotaCDSStoriaDati;
  if (WR302DM.selTabella.State = dsBrowse) then
  begin
    DataPeriodo:=StrToDate(cmbDecParStor.Text);
    (WR302DM as TWA020FCausPresenzeDM).AggiornaCDSParamStoriciz(DataPeriodo);
    AggiornaGridParamStoricizzati;
  end;
end;

procedure TWA020FCausPresenzeDettFM.cmbGettIndennitaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWA020FCausPresenzeDM).SelTabella.FieldByName('GETTONE_INDENNITA').AsString:=cmbGettIndennita.Text;
end;

procedure TWA020FCausPresenzeDettFM.cmbLinkAssenzaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWA020FCausPresenzeDM).SelTabella.FieldByName('LINK_ASSENZA').AsString:=cmbLinkAssenza.Text;
end;

procedure TWA020FCausPresenzeDettFM.grdFasceComponenti2DataSet(Row: Integer);
begin
  inherited;
  grdFasce.medpDataSet.FieldByName('TIPO_GIORNO').AsString:=TMedpIWMultiColumnComboBox(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('TIPO_GIORNO'),0)).Text;
  grdFasce.medpDataSet.FieldByName('FASCE_PN').AsString:=TmeIWComboBox(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCE_PN'),0)).Text;
end;

procedure TWA020FCausPresenzeDettFM.grdFasceDataSet2Componenti(Row: Integer);
var i:Integer;
begin
  inherited;
  with TMedpIWMultiColumnComboBox(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('TIPO_GIORNO'),0)) do
  begin
    ColCount:=2;
    Items.Clear;
    for i:=0 to High((WR302DM as TWA020FCausPresenzeDM).A020MW.D_TipoGiorno) do
      AddRow((WR302DM as TWA020FCausPresenzeDM).A020MW.D_TipoGiorno[i].Value+';'+(WR302DM as TWA020FCausPresenzeDM).A020MW.D_TipoGiorno[i].Item);
    OnAsyncChange:=cmbFasceAsyncChange;
    Text:=grdFasce.medpValoreColonna(Row, 'TIPO_GIORNO');
  end;
  with TmeIWComboBox(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCE_PN'),0)) do
  begin
    Items.Clear;
    NoSelectionText:= ' ';
    R180SetComboItemsValues(Items,(WR302DM as TWA020FCausPresenzeDM).A020MW.D_FascePN,'V');
    ItemIndex:=StrToInt(ifthen(Row>0,IntToStr(Items.IndexOf(grdFasce.medpValoreColonna(Row, 'FASCE_PN'))),'-1'));
  end;
  TmeIWLabel(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('DESC_GIORNO'),0)).Caption:=grdFasce.medpDataSet.FieldByName('DESC_GIORNO').AsString;
end;

procedure TWA020FCausPresenzeDettFM.cmbFasceAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  grdFasce.medpDataSet.FieldByName('TIPO_GIORNO').AsString:=(Sender as TmedpIWMultiColumnComboBox).Text;
  TmeIWLabel(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('DESC_GIORNO'),0)).Caption:=grdFasce.medpDataSet.FieldByName('DESC_GIORNO').AsString;
end;

procedure TWA020FCausPresenzeDettFM.grdFasceRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=TmedpIWDBGrid(ACell.Grid).medpNumColonna(AColumn);
  if (ARow > 0) and (ARow <= High(TmedpIWDBGrid(ACell.Grid).medpCompGriglia) + 1) and (TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA020FCausPresenzeDettFM.grdVociSuddiviseComponenti2DataSet(Row: Integer);
begin
  inherited;
  grdVociSuddivise.medpDataSet.FieldByName('TIPOGIORNO').AsString:=TmeIWComboBox(grdVociSuddivise.medpCompCella(Row,grdVociSuddivise.medpIndexColonna('TIPOGIORNO'),0)).Text;
end;

procedure TWA020FCausPresenzeDettFM.grdVociSuddiviseDataSet2Componenti(Row: Integer);
begin
  inherited;
  with TmeIWComboBox(grdVociSuddivise.medpCompCella(Row,grdVociSuddivise.medpIndexColonna('TIPOGIORNO'),0)) do
  begin
    Items.Clear;
    NoSelectionText:= ' ';
    R180SetComboItemsValues(Items,(WR302DM as TWA020FCausPresenzeDM).A020MW.D_VociSuddiviseTipoGiorno,'V');
    ItemIndex:=StrToInt(ifthen(Row>0,IntToStr(Items.IndexOf(grdVociSuddivise.medpValoreColonna(Row, 'TIPOGIORNO'))),'-1'));
  end;
end;

procedure TWA020FCausPresenzeDettFM.dchkCausalizzaTimbIntersecantiClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA020FCausPresenzeDM) do
  if SelTabella.State in [dsEdit,dsInsert] then
    if dchkCausalizzaTimbIntersecanti.Checked then
      SelTabella.FieldByName('GIUST_DAA_TIMB').AsString:='N';
end;

procedure TWA020FCausPresenzeDettFM.dchkTimbFittizieClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA020FCausPresenzeDM) do
  if SelTabella.State in [dsEdit,dsInsert] then
    if dchkTimbFittizie.Checked then
      SelTabella.FieldByName('CAUSALIZZA_TIMB_INTERSECANTI').AsString:='N';
end;

procedure TWA020FCausPresenzeDettFM.dchkEsclusioneFasciaObbClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.dchkGettSpezzoniClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.dchkInserimentoTimbClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.dchkLimiteDebitoGGClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.dchkLiquidabileClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.dchkMaturaMensaClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.dchkSempreAppoggiataClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.dchkUnInserimentoDClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.dedtGettoneDalleAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  dgrpGettOreInf.Enabled:=R180OreMinutiExt(dedtGettoneDalle.Text) = R180OreMinutiExt(dedtGettoneAlle.Text);
  dgrpGettOreSup.Enabled:=R180OreMinutiExt(dedtGettoneDalle.Text) = R180OreMinutiExt(dedtGettoneAlle.Text);
end;

procedure TWA020FCausPresenzeDettFM.drgpCausSuTimbratureClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TWA020FCausPresenzeDettFM.drgpControlloTimbTurnoClick(Sender: TObject);
begin
  AbilitaCausFuoriTurno;
end;

procedure TWA020FCausPresenzeDettFM.AbilitaCausFuoriTurno;
begin
  cmbCausFuoriTurno.Enabled:=drgpControlloTimbTurno.ItemIndex in [1,2];
  lblCausFuoriTurno.Enabled:=drgpControlloTimbTurno.ItemIndex in [1,2];
end;

procedure TWA020FCausPresenzeDettFM.drgpOreNormaliClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
  if drgpOreNormali.ItemIndex >= 0 then
    with (WR302DM as TWA020FCausPresenzeDM) do
      if (SelTabella.state in [dsInsert,dsEdit]) and (drgpOreNormali.Values[drgpOreNormali.ItemIndex] <> 'A') then
        SelTabella.FieldByName('Abbatte_Budget').AsString:='N';
end;

procedure TWA020FCausPresenzeDettFM.CaricaComboBox(CmbBox: TMedpIWMultiColumnComboBox; DataSet: TOracleDataSet);
begin
  with DataSet do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      CmbBox.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA020FCausPresenzeDettFM.AggiornaGridParamStoricizzati;
begin
  grdParamStoriciz.medpCaricaCDS;
end;

procedure TWA020FCausPresenzeDettFM.btnDecParStorPrecClick(Sender: TObject);
begin
  if (WR302DM.selTabella.State = dsBrowse) and (cmbDecParStor.ItemIndex > 0) and
     (WR302DM.selTabella.RecordCount > 0) then
  begin
    cmbDecParStor.ItemIndex:=(cmbDecParStor.ItemIndex - 1);
    cmbDecParStorChange(nil);
  end;
end;

procedure TWA020FCausPresenzeDettFM.btnDecParStorSuccClick(Sender: TObject);
begin
  if (WR302DM.selTabella.State = dsBrowse) and
     (cmbDecParStor.ItemIndex < cmbDecParStor.Items.Count - 1) and
     (WR302DM.selTabella.RecordCount > 0) then
  begin
    cmbDecParStor.ItemIndex:=(cmbDecParStor.ItemIndex + 1);
    cmbDecParStorChange(nil);
  end;
end;

procedure TWA020FCausPresenzeDettFM.btnModificaParStorClick(Sender: TObject);
var
  IDCausale:Integer;
begin
  if (not (WR302DM.selTabella.State in [dsInsert,dsEdit])) and
      (WR302DM.selTabella.RecordCount > 0) then // per sicurezza
  begin
    IDCausale:=WR302DM.selTabella.FieldByName('ID').AsInteger;
    WA020FCausPresenzeStorico:=TWA020FCausPresenzeStorico.Create(Self.Owner.Owner,
                                                                 False,
                                                                 IDCausale,
                                                                 Self.Owner as TWA020FCausPresenze);
    WA020FCausPresenzeStorico.WA020StoricoDataLavoro:=StrToDate(cmbDecParStor.Text);
    WC007FM:=TWC007FFormContainerFM.Create(Self.Parent);
    WC007FM.TemplateProcessor.Templates.Default:='WA020FCausPresenzeStoricoFM.html';
    WC007FM.ResultEvent:=OnWC007FMClose;
    WC007FM.popupWidth:=770;
    WC007FM.popupHeigth:=-1;//Altezza automatica;
    WA020FCausPresenzeStorico.grdStatusBar.Parent:=WC007FM.IWFrameRegion;
    WA020FCausPresenzeStorico.grdNavigatorBar.Parent:=WC007FM.IWFrameRegion;
    WA020FCausPresenzeStorico.grdToolBarStorico.Parent:=WC007FM.IWFrameRegion;
    WA020FCausPresenzeStorico.grdTabControl.Parent:=WC007FM.IWFrameRegion;
    WA020FCausPresenzeStorico.WBrowseFM.Parent:=WC007FM.IWFrameRegion;
    WA020FCausPresenzeStorico.WDettaglioFM.Parent:=WC007FM.IWFrameRegion;
    WC007FM.Visualizza('Parametri storicizzati');
  end;
end;

procedure TWA020FCausPresenzeDettFM.ToggleControlliSchedaParStor(Attiva:Boolean);
begin
  btnDecParStorPrec.Enabled:=Attiva and (not chkVistaPeriodoCorr.Checked);
  btnDecParStorSucc.Enabled:=Attiva and (not chkVistaPeriodoCorr.Checked);
  cmbDecParStor.Enabled:=Attiva and (not chkVistaPeriodoCorr.Checked);
  chkVistaPeriodoCorr.Enabled:=Attiva;
  btnModificaParStor.Enabled:=Attiva;
end;

procedure TWA020FCausPresenzeDettFM.WA020ParamStoricizRGRender(Sender: TObject);
begin
  ToggleControlliSchedaParStor(not (WR302DM.SelTabella.State in [dsInsert,dsEdit]));
end;

procedure TWA020FCausPresenzeDettFM.OnWC007FMClose(Sender:TObject);
var
  IDCausale:Integer;
  NuovaDataDecorrenzaStr:String;
begin
  NuovaDataDecorrenzaStr:='';
  if WA020FCausPresenzeStorico <> nil then
  begin
    // Leggo l'ultima data selezionata dal form dei parametri storicizzati
    NuovaDataDecorrenzaStr:=WA020FCausPresenzeStorico.cmbDecorrenza.Text;

    { In IW il parent degli oggetti tenta di distruggerli, ma questi oggetti
      hanno anche riferimenti ad altri che a loro volta tentano di distruggerli.
      IW causa AV dato che tenta di distruggere oggetti già deallocati.
      Ripristiamo il parent naturale per evitare dispose incrociate. }
    WA020FCausPresenzeStorico.grdStatusBar.Parent:=WA020FCausPresenzeStorico;
    WA020FCausPresenzeStorico.grdNavigatorBar.Parent:=WA020FCausPresenzeStorico;
    WA020FCausPresenzeStorico.grdToolBarStorico.Parent:=WA020FCausPresenzeStorico;
    WA020FCausPresenzeStorico.grdTabControl.Parent:=WA020FCausPresenzeStorico;
    WA020FCausPresenzeStorico.WBrowseFM.Parent:=WA020FCausPresenzeStorico;
    WA020FCausPresenzeStorico.WDettaglioFM.Parent:=WA020FCausPresenzeStorico;
    FreeAndNil(WA020FCausPresenzeStorico);
  end;
  IDCausale:=WR302DM.selTabella.FieldByName('ID').AsInteger;
  WR302DM.selTabella.Refresh;
  WR302DM.selTabella.Locate('ID',IDCausale,[]);
  if (NuovaDataDecorrenzaStr <> '') then
  begin
    cmbDecParStor.ItemIndex:=cmbDecParStor.Items.IndexOf(NuovaDataDecorrenzaStr);
    cmbDecParStorChange(nil);
  end;
end;

procedure TWA020FCausPresenzeDettFM.EvtStateChange;
begin
  // Richiamato dall'evento OnStateChange di dsrTabella sul DM
  lblCausCompDebitoGG.Enabled:=False;
  cmbCausCompDebitoGG.Enabled:=False;
  dchkMaturaMensa.Enabled:=False;
  dchkTimbPMDetraz.Enabled:=False;
  dchkTimbPM.Enabled:=False;
  dchkTimbPMH.Enabled:=False;
  dchkAutoCompletamentoUE.Enabled:=False;
  drgpIntersezioneTimbrature.Enabled:=False;
end;

end.
