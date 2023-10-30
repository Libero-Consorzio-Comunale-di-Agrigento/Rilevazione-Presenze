unit WA016UCausAssenzeDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,DB, Math, IWApplication,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, DBClient,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompCheckbox, meIWDBCheckBox,
  medpIWMultiColumnComboBox, meIWDBLabel, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, meIWRegion,
  IWCompListbox, meIWDBComboBox, IWCompGrids, meIWGrid, medpIWTabControl, IWCompButton, meIWButton,
  meIWCheckBox, meIWDBLookupComboBox, IWDBGrids, medpIWDBGrid, C180FunzioniGenerali, StdCtrls,
  WC013UCheckListFM, C190FunzioniGeneraliWeb, IWHTMLControls, meIWLink,
  A000UInterfaccia, A000UMessaggi, medpIWMessageDlg, meIWEdit, meIWImageFile,
  WC010UMemoEditFM, WC015USelEditGridFM, OracleData, Vcl.Menus, WA016UCausAssenzeStorico, WC007UFormContainerFM,
  meIWImageButton, meIWComboBox;

type
  TWA016FCausAssenzeDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblSiglaProspetto: TmeIWLabel;
    dedtSiglaCausale: TmeIWDBEdit;
    lblDescrizioneEstesa: TmeIWLabel;
    dedtDescrizioneEstesa: TmeIWDBEdit;
    cmbCodRaggr: TMedpIWMultiColumnComboBox;
    dchkAnnoSolare: TmeIWDBCheckBox;
    dlblRaggruppamento: TmeIWDBLabel;
    WA016CartellinoRG: TmeIWRegion;
    lblGgNonLavorativo: TmeIWLabel;
    drgpGNonLav: TmeIWDBRadioGroup;
    lblValGiornaliera: TmeIWLabel;
    drgpValorGior: TmeIWDBRadioGroup;
    drgpStampa: TmeIWDBRadioGroup;
    lblStampaSuCartellino: TmeIWLabel;
    drgpInfluenzaPO: TmeIWDBRadioGroup;
    lblDebAggiuntivo: TmeIWLabel;
    lblSovrappTimbrature: TmeIWLabel;
    drgpInterTimbrature: TmeIWDBRadioGroup;
    lblInfluenzaConteggi: TmeIWLabel;
    lblModRecupero: TmeIWLabel;
    dchkEccedLiq: TmeIWDBCheckBox;
    dchkValseTimb: TmeIWDBCheckBox;
    dchkEsclusione: TmeIWDBCheckBox;
    dchkIndpres: TmeIWDBCheckBox;
    dchkRecuperoFestivo: TmeIWDBCheckBox;
    lblDetReperib: TmeIWLabel;
    dchkDetReperibIntera: TmeIWDBCheckBox;
    dchkFlessibilitaOrario: TmeIWDBCheckBox;
    dchkTimbPM: TmeIWDBCheckBox;
    dchkTimbPMDetraz: TmeIWDBCheckBox;
    lblGgAssenza: TmeIWLabel;
    dedtHmAssenza: TmeIWDBEdit;
    lblRaggrAssenze: TmeIWLabel;
    drgpRaggrStat: TmeIWDBRadioGroup;
    TemplateCartellinoRG: TIWTemplateProcessorHTML;
    grdTabDetail: TmedpIWTabControl;
    WA016RegInserimentoRG: TmeIWRegion;
    TemplateRegInserimentoRG: TIWTemplateProcessorHTML;
    lblGSignific: TmeIWLabel;
    drgpGSignific: TmeIWDBRadioGroup;
    lblUMInserimento: TmeIWLabel;
    dchkUMInserimento: TmeIWDBCheckBox;
    dchkUMInserimentoMg: TmeIWDBCheckBox;
    dchkUMInserimentoH: TmeIWDBCheckBox;
    dchkUMInserimentoD: TmeIWDBCheckBox;
    lblVincoliFruizione: TmeIWLabel;
    lblFruizMin: TmeIWLabel;
    dedtFruizMin: TmeIWDBEdit;
    lblFruizMax: TmeIWLabel;
    dedtFruizMax: TmeIWDBEdit;
    lblFruizArr: TmeIWLabel;
    dedtFruizArr: TmeIWDBEdit;
    dchkFruizCompetenzeArr: TmeIWDBCheckBox;
    dchkFruizMaxDebito: TmeIWDBCheckBox;
    dchkFruibile: TmeIWDBCheckBox;
    dchkMaturFerie: TmeIWDBCheckBox;
    dchkNoSuperoCompetenze: TmeIWDBCheckBox;
    dchkNoSuperoCompWeb: TmeIWDBCheckBox;
    dchkAllungaProva: TmeIWDBCheckBox;
    dchkRegistraStorico: TmeIWDBCheckBox;
    dchkValidazione: TmeIWDBCheckBox;
    dchkRicorsione: TmeIWDBCheckBox;
    dchkVisitaFiscale: TmeIWDBCheckBox;
    dchkPeriodoLungo: TmeIWDBCheckBox;
    dchkMaternitaObbl: TmeIWDBCheckBox;
    dchkAbbatteGGSerTempoDet: TmeIWDBCheckBox;
    dchkAbbatteGgValutazione: TmeIWDBCheckBox;
    lblAbbattimentoInail: TmeIWLabel;
    dedtPercInail: TmeIWDBEdit;
    lblCausaleSuccessiva: TmeIWLabel;
    cmbCausaleSuccessiva: TMedpIWMultiColumnComboBox;
    lblCausale10Giorni: TmeIWLabel;
    cmbCausale10Giorni: TMedpIWMultiColumnComboBox;
    dlblCausaleSuccessiva: TmeIWDBLabel;
    dlblCodCaus3: TmeIWDBLabel;
    WA016RegCumuloRG: TmeIWRegion;
    TemplateRegCumuloRG: TIWTemplateProcessorHTML;
    WA016CompetenzeRG: TmeIWRegion;
    WA016FiniEconomiciRG: TmeIWRegion;
    TemplateFiniEconomiciRG: TIWTemplateProcessorHTML;
    lblCodiceVoce: TmeIWLabel;
    dchkScaricoPagheUMProp: TmeIWDBCheckBox;
    drgpUmScaricoPaghe: TmeIWDBRadioGroup;
    lblUnitaMisura: TmeIWLabel;
    dchkGLavInps: TmeIWDBCheckBox;
    TemplateCompetenzeRG: TIWTemplateProcessorHTML;
    drgpUMisura: TmeIWDBRadioGroup;
    lblUmisura: TmeIWLabel;
    drgpArrotOre2GG: TmeIWDBRadioGroup;
    lblArrotOre2GG: TmeIWLabel;
    drdgRapportiUniti: TmeIWDBRadioGroup;
    lblRapportiUniti: TmeIWLabel;
    lblMaxUnitario: TmeIWLabel;
    lblMaxOre: TmeIWLabel;
    dedtHMaxUnitario: TmeIWDBEdit;
    lblMaxGiorni: TmeIWLabel;
    dedtGMaxUnitario: TmeIWDBEdit;
    lblNumMaxFruizioni: TmeIWLabel;
    dedtFruizMaxNum: TmeIWDBEdit;
    lblAllarmePeriodo: TmeIWLabel;
    dedtAllarmeFruizCont: TmeIWDBEdit;
    lblAllarmegg: TmeIWLabel;
    lblFascia1: TmeIWLabel;
    dedtComp1: TmeIWDBEdit;
    dedtRetrib1: TmeIWDBEdit;
    lblFascia2: TmeIWLabel;
    dedtComp2: TmeIWDBEdit;
    dedtRetrib2: TmeIWDBEdit;
    lblFascia3: TmeIWLabel;
    dedtComp3: TmeIWDBEdit;
    dedtRetrib3: TmeIWDBEdit;
    lblFascia4: TmeIWLabel;
    dedtComp4: TmeIWDBEdit;
    dedtRetrib4: TmeIWDBEdit;
    lblFascia5: TmeIWLabel;
    dedtComp5: TmeIWDBEdit;
    dedtRetrib5: TmeIWDBEdit;
    lblFascia6: TmeIWLabel;
    dedtComp6: TmeIWDBEdit;
    dedtRetrib6: TmeIWDBEdit;
    lblCompetenze: TmeIWLabel;
    lblPercRetribuzione: TmeIWLabel;
    dchkCompetenzePersonalizzate: TmeIWDBCheckBox;
    lblProporzioneCompetenze: TmeIWLabel;
    dchkPropozionaPerServ: TmeIWDBCheckBox;
    dchkTempoDeterminato: TmeIWDBCheckBox;
    dChkPropAbilitazione: TmeIWDBCheckBox;
    lblPartTime: TmeIWLabel;
    chkPartTimeO: TmeIWCheckBox;
    chkPartTimeV: TmeIWCheckBox;
    chkPartTimeC: TmeIWCheckBox;
    drgpTipoProporzione: TmeIWDBRadioGroup;
    lblTipoProporzione: TmeIWLabel;
    lblCarCumulo: TmeIWLabel;
    lblConsideraCumulo: TmeIWLabel;
    dedtCausaliCollegate: TmeIWDBEdit;
    btnCausaliCollegate: TmeIWButton;
    lblCodCau2: TmeIWLabel;
    dedtCodCau2: TmeIWDBEdit;
    btnCodCau2: TmeIWButton;
    lblCumulaRichiesteWeb: TmeIWLabel;
    drgpCumulaRichiesteWeb: TmeIWDBRadioGroup;
    lblCumuloTipoOre: TmeIWLabel;
    dgrpCumuloTipoOre: TmeIWDBRadioGroup;
    lblCumuloGlobale: TmeIWLabel;
    dgrpCumuloGlobale: TmeIWDBRadioGroup;
    lblRaggr: TmeIWLabel;
    dcmbRaggruppamento: TmeIWDBLookupComboBox;
    lblUMCumulo: TmeIWLabel;
    drgpUMCumulo: TmeIWDBRadioGroup;
    lblDurataCumulo: TmeIWLabel;
    dedtDurataCumulo: TmeIWDBEdit;
    lblGMCumulo: TmeIWLabel;
    dedtGMCumulo: TmeIWDBEdit;
    dchkCumuloFamGGDopo: TmeIWDBCheckBox;
    lblCumuloFamiliari: TmeIWLabel;
    lblCausale: TmeIWLabel;
    cmbCodCauInizio: TMedpIWMultiColumnComboBox;
    lblDCausale: TmeIWDBLabel;
    lblAssenze: TmeIWLabel;
    dedtAssenze: TmeIWDBEdit;
    btnAssenze: TmeIWButton;
    dchkFestGiustif: TmeIWDBCheckBox;
    dchkProgressivo: TmeIWDBCheckBox;
    dchkDomeniche: TmeIWDBCheckBox;
    dchkFestivi: TmeIWDBCheckBox;
    dchkPianiFreper: TmeIWDBCheckBox;
    dedtCMDebSett: TmeIWDBEdit;
    lblCMDebSett: TmeIWLabel;
    lblGiorniNonLav: TmeIWLabel;
    dgrpGiorniNonLav: TmeIWDBRadioGroup;
    lblCausTollerate: TmeIWLabel;
    grdCausTollerate: TmedpIWDBGrid;
    dchkFruizione: TmeIWDBCheckBox;
    lblFruizioneDurata: TmeIWLabel;
    dedtDurata: TmeIWDBEdit;
    dedtOffsetFruizione: TmeIWDBEdit;
    lblFruizioneDopo: TmeIWLabel;
    dchkFruizioneFamGGDopo: TmeIWDBCheckBox;
    drgpUMFruizione: TmeIWDBRadioGroup;
    lblUMFruizione: TmeIWLabel;
    lblRiferimento: TmeIWLabel;
    lblFruizioneFamiliari: TmeIWLabel;
    cmbCauFruizione: TMedpIWMultiColumnComboBox;
    lblDCodCauFruizione: TmeIWDBLabel;
    lblFruizioneCausale: TmeIWLabel;
    cmbVocePaghe: TMedpIWMultiColumnComboBox;
    lblDescVoce: TmeIWDBLabel;
    lnkRaggruppamento: TmeIWLink;
    dcmbInfluCont: TmeIWDBComboBox;
    dcmbTipoRecupero: TmeIWDBComboBox;
    dcmbDetReperib: TmeIWDBComboBox;
    dcmbTipoCumulo: TmeIWDBComboBox;
    dcmbCumuloFamiliari: TmeIWDBComboBox;
    dcmbFruizioneFamiliari: TmeIWDBComboBox;
    dchkVarCompFruizMMInteri: TmeIWDBCheckBox;
    lblCompIndivConiugeEsistente: TmeIWLabel;
    dedtCompIndivConiugeEsistente: TmeIWDBEdit;
    lblMMContVarComp: TmeIWLabel;
    dedtMMContVarComp: TmeIWDBEdit;
    lblVarCompFruizMMCont: TmeIWLabel;
    dedtVarCompFruizMMCont: TmeIWDBEdit;
    dchkArrotCompetenze: TmeIWDBCheckBox;
    lblOreGGMaxInf6: TmeIWLabel;
    dedtOreGGMaxInf6: TmeIWDBEdit;
    lblOreGGMaxSup6: TmeIWLabel;
    dedtOreGGMaxSup6: TmeIWDBEdit;
    WA016CausaliIncompatibiliRG: TmeIWRegion;
    dgrdCausIncomp: TmedpIWDBGrid;
    TemplateCausaliIncompatibiliRG: TIWTemplateProcessorHTML;
    dcmbggnnLav: TmeIWDBComboBox;
    dChkCopreFasciaObb: TmeIWDBCheckBox;
    dchkPeriodoCumuloPersonalizzato: TmeIWDBCheckBox;
    lnkPeriodoCumuloPersonalizzato: TmeIWLink;
    lnkTipoCumulo: TmeIWLink;
    lnkCompetenzePersonalizzate: TmeIWLink;
    lnkArrotCompetenze: TmeIWLink;
    lblpropptvgg: TmeIWLabel;
    dcmbpropptvgg: TmeIWDBComboBox;
    dchkCTMantieniResidNeg: TmeIWDBCheckBox;
    dchkIterEccGG: TmeIWDBCheckBox;
    dchkFruizGGNeutra: TmeIWDBCheckBox;
    dchkIterIgnoraFineRapporto: TmeIWDBCheckBox;
    WA016ParamStoricizRG: TmeIWRegion;
    TemplateParamStoriciz: TIWTemplateProcessorHTML;
    chkVistaPeriodoCorr: TmeIWCheckBox;
    grdParamStoriciz: TmedpIWDBGrid;
    btnModificaParStor: TmeIWButton;
    btnDecParStorPrec: TmeIWImageButton;
    btnDecParStorSucc: TmeIWImageButton;
    cmbDecParStor: TmeIWComboBox;
    dedtCausaliCumuloL133: TmeIWDBEdit;
    lblCausaliCumuloL133: TmeIWLabel;
    btnCausaliCumuloL133: TmeIWButton;
    lblVocePaghe2: TmeIWLabel;
    dedtVocePaghe2: TmeIWDBEdit;
    procedure ReleaseOggetti;Override;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbCodRaggrAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCausaleSuccessivaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCausale10GiorniAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dchkTimbPMClick(Sender: TObject);
    procedure dgrpCumuloGlobaleClick(Sender: TObject);
    procedure btnCausaliCollegateClick(Sender: TObject);
    procedure btnCodCau2Click(Sender: TObject);
    procedure btnAssenzeClick(Sender: TObject);
    procedure cmbVocePagheAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure lnkRaggruppamentoClick(Sender: TObject);
    procedure drgpUMisuraClick(Sender: TObject);
    procedure drgpGSignificClick(Sender: TObject);
    procedure dchkRegistraStoricoClick(Sender: TObject);
    procedure dchkValidazioneClick(Sender: TObject);
    procedure chkPartTimeOClick(Sender: TObject);
    procedure grdCausTollerateRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure dgrdCausIncompRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdCausTollerateComponenti2DataSet(Row: Integer);
    procedure grdCausTollerateDataSet2Componenti(Row: Integer);
    procedure dcmbInfluContChange(Sender: TObject);
    procedure dcmbDetReperibChange(Sender: TObject);
    procedure dcmbTipoCumuloChange(Sender: TObject);
    procedure cmbCauFruizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dchkFruizioneClick(Sender: TObject);
    procedure cmbCodCauInizioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dgrdCausIncompDataSet2Componenti(Row: Integer);
    procedure dgrdCausIncompComponenti2DataSet(Row: Integer);
    procedure lnkPeriodoCumuloPersonalizzatoClick(Sender: TObject);
    procedure AbilitaTipoPropPtVGG;
    procedure RiAbilitaTipoPropPtVGG;
    procedure cmbCodRaggrChange(Sender: TObject; Index: Integer);
    procedure dchkUMInserimentoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkUMInserimentoHAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dchkNoSuperoCompetenzeAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkFruibileAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure chkVistaPeriodoCorrClick(Sender: TObject);
    procedure btnModificaParStorClick(Sender: TObject);
    procedure WA016ParamStoricizRGRender(Sender: TObject);
    procedure cmbDecParStorChange(Sender: TObject);
    procedure btnDecParStorPrecClick(Sender: TObject);
    procedure btnDecParStorSuccClick(Sender: TObject);
    procedure btnCausaliCumuloL133Click(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    WC015: TWC015FSelEditGridFM;
    WC007FM: TWC007FFormContainerFM;
    WA016FCausAssenzeStorico: TWA016FCausAssenzeStorico;
    procedure CaricaLista;
    procedure EvtDataChange;
    procedure CaricaCausaliAssPres;
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnComboBox; override;
    //procedure VisualizzaComponentiFasce(Visualizza: Boolean);
    procedure VisualizzaComponentiCumulo(Visualizza: Boolean);
    procedure VisualizzaComponentiRiposi(Visualizza: Boolean);
    procedure VisualizzaComponentiFestivita(Visualizza: Boolean);
    procedure VisualizzaComponentiCarattCumulo(Visualizza: Boolean);
    procedure VisualizzaComponentiInizioCumulo(Visualizza: Boolean);
    procedure VisualizzaComponentiAssenzeTollerate(Visualizza: Boolean);
    procedure VisualizzaTipoCumuloM(Visualizza: Boolean);
    procedure ResultCausaliCollegate(Sender: TObject; Result:Boolean);
    procedure ResultCodCau2(Sender: TObject; Result: Boolean);
    procedure ResultAssenze(Sender: TObject; Result: Boolean);
    procedure ResultRichiediValidazione(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure AbilitaGrigliaCompetenze(Abilitato:Boolean);
    procedure AbilitaGrpVincoliFruizione(Visualizza: Boolean);
    procedure imgCausaliClick(Sender: TObject);
    procedure imgCausaliResult(Sender: TObject; Result: Boolean);
    procedure OnWC007FMClose(Sender:TObject);
    procedure ToggleControlliSchedaParStor(Attiva:Boolean);
    procedure ResultCausaliCumuloL133(Sender: TObject; Result: Boolean);
   protected
     procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
   public
    procedure ImpostaPartTime;
    procedure EvtStateChange;
    procedure CodRaggrChange;
    procedure AggiornaGridParamStoricizzati;
  end;

implementation

uses WA016UCausAssenzeDM, WR100UBase,WA016UCausAssenze;

{$R *.dfm}

procedure TWA016FCausAssenzeDettFM.IWFrameRegionCreate(Sender: TObject);
var
  A016DM:TWA016FCausAssenzeDM;
begin
  inherited;
  //dchkAnnoSolare.DataSource:=(WR302DM as TWA016FCausAssenzeDM).A016MW.D260;
  dcmbRaggruppamento.ListSource:=(WR302DM as TWA016FCausAssenzeDM).A016MW.DCols;
  grdTabDetail.AggiungiTab('Cartellino',WA016CartellinoRG);
  grdTabDetail.AggiungiTab('Regole inserimento',WA016RegInserimentoRG);
  grdTabDetail.AggiungiTab('Regole cumulo/fruizione',WA016RegCumuloRG);
  grdTabDetail.AggiungiTab('Competenze',WA016CompetenzeRG);
  grdTabDetail.AggiungiTab('Fini economici',WA016FiniEconomiciRG);
  //grdTabDetail.AggiungiTab('Caus. incomp.',WA016CausaliIncompatibiliRG);
  grdTabDetail.AggiungiTab('Parametri storiciz.',WA016ParamStoricizRG);
  grdTabDetail.ActiveTab:=WA016CartellinoRG;

  R180SetComboItemsValues(dcmbCumuloFamiliari.Items,(WR302DM as TWA016FCausAssenzeDM).A016MW.D_FruizioneFamiliari,'IV');
  R180SetComboItemsValues(dcmbInfluCont.Items,(WR302DM as TWA016FCausAssenzeDM).A016MW.D_InfCont,'IV');
  R180SetComboItemsValues(dcmbTipoRecupero.Items,(WR302DM as TWA016FCausAssenzeDM).A016MW.D_ModRecupero,'IV');
  R180SetComboItemsValues(dcmbTipoCumulo.Items,(WR302DM as TWA016FCausAssenzeDM).A016MW.D_Cumulo,'IV');
  R180SetComboItemsValues(dcmbDetReperib.Items,(WR302DM as TWA016FCausAssenzeDM).A016MW.D_DetReperib,'IV');
  R180SetComboItemsValues(dcmbFruizioneFamiliari.Items,(WR302DM as TWA016FCausAssenzeDM).A016MW.D_FruizioneFamiliari,'IV');
  R180SetComboItemsValues(dcmbggnnLav.Items,(WR302DM as TWA016FCausAssenzeDM).A016MW.D_CopriGGNonLav,'IV');
  R180SetComboItemsValues(dcmbpropptvgg.Items,(WR302DM as TWA016FCausAssenzeDM).A016MW.D_PropPtVGG ,'IV');

  dchkFruizioneClick(nil);
  ImpostaPartTime;
  EvtDataChange;
  dgrpCumuloGlobaleClick(nil);
  drgpGSignificClick(nil);
  drgpInterTimbrature.Enabled:=False;
  A016DM:=((Owner as TWA016FCausAssenze).WR302DM as TWA016FCausAssenzeDM);
  grdParamStoriciz.medpAttivaGrid(A016DM.A016StoricoMW.cdsStoriaParamStorizz,
                                  False,
                                  False,
                                  False);

  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);
end;

procedure TWA016FCausAssenzeDettFM.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TWC013FCheckListFM) and (AComponent = WC013) then
      WC013:=nil
    else if (AComponent is TWC015FSelEditGridFM) and (AComponent = WC015) then
      WC015:=nil;
  end;
end;

procedure TWA016FCausAssenzeDettFM.ReleaseOggetti;
begin
  inherited;
  if WC013 <> nil then
    FreeAndNil(WC013);
  if WC015 <> nil then
    FreeAndNil(WC015);
end;

procedure TWA016FCausAssenzeDettFM.lnkPeriodoCumuloPersonalizzatoClick(Sender: TObject);
var ObjPlSql:string;
begin
  inherited;
  with (WR302DM as TWA016FCausAssenzeDM).A016MW do
  begin
    ObjPlSql:='';
    if (Sender = lnkPeriodoCumuloPersonalizzato) or (Sender = lnkTipoCumulo) then
      ObjPlSql:='T265P_GETPERIODOCUMULO'
    else if Sender = lnkCompetenzePersonalizzate then
      ObjPlSql:='T265P_GETCOMPETENZE'
    else if Sender = lnkArrotCompetenze then
      ObjPlSql:='T265P_ARROTCOMPETENZE';
    if ObjPlSql = '' then
      exit;

    GetSourceSQL(ObjPlSql);
    if lstSourceSQL.Count > 0 then
    with TWC010FMemoEditFM.Create(Self.Owner) do
    begin
      memValore.Lines.Clear;
      memValore.Lines.AddStrings(lstSourceSQL);
      Width:=600;
      Height:=350;
      Visualizza(ObjPlSql);
    end;
  end;
end;

procedure TWA016FCausAssenzeDettFM.lnkRaggruppamentoClick(Sender: TObject);
{Gestione Raggruppamenti assenze WA017}
begin
  TWR100FBase(Self.Parent).AccediForm(106,'CODICE=' + cmbCodRaggr.Text);
end;

procedure TWA016FCausAssenzeDettFM.btnModificaParStorClick(Sender: TObject);
var
  IDCausale:Integer;
begin
  if (not (WR302DM.selTabella.State in [dsInsert,dsEdit])) and
      (WR302DM.selTabella.RecordCount > 0) then // per sicurezza
  begin
    IDCausale:=WR302DM.selTabella.FieldByName('ID').AsInteger;
    WA016FCausAssenzeStorico:=TWA016FCausAssenzeStorico.Create(Self.Owner.Owner,
                                                               False,
                                                               IDCausale,
                                                               Self.Owner as TWA016FCausAssenze);
    WA016FCausAssenzeStorico.WA016StoricoDataLavoro:=StrToDate(cmbDecParStor.Text);
    WC007FM:=TWC007FFormContainerFM.Create(Self.Parent);
    WC007FM.TemplateProcessor.Templates.Default:='WA016FCausAssenzeStoricoFM.html';
    WC007FM.ResultEvent:=OnWC007FMClose;
    WC007FM.popupWidth:=730;
    WC007FM.popupHeigth:=805;
    WA016FCausAssenzeStorico.grdStatusBar.Parent:=WC007FM.IWFrameRegion;
    WA016FCausAssenzeStorico.grdNavigatorBar.Parent:=WC007FM.IWFrameRegion;
    WA016FCausAssenzeStorico.grdToolBarStorico.Parent:=WC007FM.IWFrameRegion;
    WA016FCausAssenzeStorico.grdTabControl.Parent:=WC007FM.IWFrameRegion;
    WA016FCausAssenzeStorico.WBrowseFM.Parent:=WC007FM.IWFrameRegion;
    WA016FCausAssenzeStorico.WDettaglioFM.Parent:=WC007FM.IWFrameRegion;
    WC007FM.Visualizza('Parametri storicizzati');
  end;
end;

procedure TWA016FCausAssenzeDettFM.EvtDataChange;
{Abilito/disabilito i controlli in scorrimento}
var cmbInfluContId:String;
begin
  dcmbTipoCumuloChange(dcmbTipoCumulo);
  dchkUMInserimentoHAsyncChange(nil,nil);
  with (WR302DM as TWA016FCausAssenzeDM) do
  begin
    CodRaggrChange;
    //cmbInfluContId:=dcmbInfluCont.SelectedValue;
    cmbInfluContId:=dcmbInfluCont.Items.ValueFromIndex[dcmbInfluCont.ItemIndex];
  end;
  dchkFruizGGNeutra.Enabled:=dchkUMInserimento.Checked;
  dedtDurata.Enabled:=dchkFruizione.Checked;
  drgpUMFruizione.Enabled:=dchkFruizione.Checked;
  cmbCauFruizione.Enabled:=dchkFruizione.Checked;
  dedtOffsetFruizione.Enabled:=dchkFruizione.Checked;
  dcmbFruizioneFamiliari.Enabled:=dchkFruizione.Checked;
  dchkFruizioneFamGGDopo.Enabled:=dchkFruizione.Checked;
  dchkEccedLiq.Visible:= cmbInfluContId = 'B';
  dcmbTipoRecupero.Enabled:=(cmbInfluContId = 'A') or (cmbInfluContId = 'C') or (cmbInfluContId = 'G') or (cmbInfluContId = 'H') or (cmbInfluContId = 'I');
  lblDetReperib.Enabled:=(cmbInfluContId <> 'B') and (cmbInfluContId <> 'D');
  dcmbDetReperib.Enabled:=(cmbInfluContId <> 'B') and (cmbInfluContId <> 'D');
  //dchkDetReperibIntera.Enabled:=R180CarattereDef(dcmbDetReperib.SelectedValue) in ['1','2'];
  dchkDetReperibIntera.Enabled:=R180CarattereDef(dcmbDetReperib.Items.ValueFromIndex[dcmbDetReperib.ItemIndex]) in ['1','2'];
  // TODO: il legame si è perso in seguito alla storicizzazione di ABBATTE_STRIND
  // dchkAbbatteStrInd.Enabled:=cmbInfluContId = 'D';
  dchkIterEccGG.Enabled:=cmbInfluContId = 'A';
  dchkTimbPMClick(nil);
end;

procedure TWA016FCausAssenzeDettFM.dchkTimbPMClick(Sender: TObject);
begin
  inherited;
  //dchkTimbPMDetraz.Enabled:=dchkTimbPM.Checked;
end;

procedure TWA016FCausAssenzeDettFM.dchkUMInserimentoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dchkFruizGGNeutra.Enabled:=dchkUMInserimento.Checked;
end;

procedure TWA016FCausAssenzeDettFM.dchkUMInserimentoHAsyncChange(Sender: TObject; EventParams: TStringList);
var i:Integer;
begin
  inherited;
  with (WR302DM as TWA016FCausAssenzeDM).A016MW do
  begin
    AbilitaGrpVincoliFruizione((T265.FieldByName('UM_INSERIMENTO_H').AsString = 'S') or (T265.FieldByName('UM_INSERIMENTO_D').AsString = 'S'));
  end;
end;

procedure TWA016FCausAssenzeDettFM.dchkValidazioneClick(Sender: TObject);
var
  Selezione,MedLeg,s: String;
begin
  if ((WR302DM as TWA016FCausAssenzeDM).SelTabella.State = dsEdit) and dchkValidazione.Checked then
  begin
    MsgBox.WebMessageDlg(A000MSG_A016_DLG_RICHIEDI_VALIDAZIONE,mtConfirmation,[mbYes,mbNo],ResultRichiediValidazione,'');
    Abort;
  end
  else
  begin
    if (WR302DM as TWA016FCausAssenzeDM).SelTabella.State = dsEdit then
      with (WR302DM as TWA016FCausAssenzeDM).A016MW do
      begin
        selAssDaValidare.Close;
        selAssDaValidare.SetVariable('CODICE',T265.FieldByName('CODICE').AsString);
        selAssDaValidare.Open;
        if selAssDaValidare.RecordCount > 0 then
        begin
          MsgBox.WebMessageDlg(A000MSG_A016_MSG_ASSENZE_DA_VALIDARE,mtInformation,[mbOk],nil,'');
          WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
          WC015.Visualizza('Assenze da validare',selAssDaValidare,False,False);
          (WR302DM as TWA016FCausAssenzeDM).SelTabella.FieldByName('VALIDAZIONE').AsString:='S';
        end;
      end;
  end;
end;

procedure TWA016FCausAssenzeDettFM.dcmbDetReperibChange(Sender: TObject);
begin
  dchkDetReperibIntera.Enabled:=dcmbDetReperib.ItemIndex in [1,2];
  EvtDataChange;
end;

procedure TWA016FCausAssenzeDettFM.dcmbInfluContChange(Sender: TObject);
var cmbInfluContId:String;
begin
  inherited;
  with (WR302DM as TWA016FCausAssenzeDM) do
  begin
    //cmbInfluContId:=dcmbInfluCont.SelectedValue;
    cmbInfluContId:=dcmbInfluCont.Items.ValueFromIndex[dcmbInfluCont.ItemIndex];
    dchkEccedLiq.Visible:=cmbInfluContId = 'B';
    if (SelTabella.State in [dsInsert,dsEdit]) and (cmbInfluContId <> 'B') then
      SelTabella.FieldByName('EccedLiq').AsString:='B';
    dcmbTipoRecupero.Enabled:=(cmbInfluContId = 'A') or (cmbInfluContId = 'C') or (cmbInfluContId = 'G') or (cmbInfluContId = 'H') or (cmbInfluContId = 'I');
    if (SelTabella.State in [dsInsert,dsEdit]) and (not dcmbTipoRecupero.Enabled) then
      SelTabella.FieldByName('TipoRecupero').AsString:='0';
    dcmbDetReperib.Enabled:=(cmbInfluContId <> 'B') and (cmbInfluContId <> 'D');
    lblDetReperib.Enabled:=dcmbDetReperib.Enabled;
    if (SelTabella.State in [dsInsert,dsEdit]) and (not dcmbDetReperib.Enabled) then
      SelTabella.FieldByName('DetReperib').AsString:='0';
    // TODO: il legame si è perso in seguito alla storicizzazione di ABBATTE_STRIND
    {
    dchkAbbatteStrInd.Enabled:=cmbInfluContId = 'D';
    if (SelTabella.State in [dsInsert,dsEdit]) and (not dchkAbbatteStrInd.Enabled) then
      SelTabella.FieldByName('ABBATTE_STRIND').AsString:='N';
    }
    dchkIterEccGG.Enabled:=cmbInfluContId = 'A';
    if (SelTabella.State in [dsInsert,dsEdit]) then
    begin
      dchkEsclusione.Enabled:=not (cmbInfluContId = 'I');
      if cmbInfluContId = 'I' then
        SelTabella.FieldByName('ESCLUSIONE').AsString:='N';
    end;
    EvtDataChange;
  end;
end;

procedure TWA016FCausAssenzeDettFM.dcmbTipoCumuloChange(Sender: TObject);
{Abilito/disabilito i dati di cumulo in base al tipo}
var Cod:Char;
begin
  with (WR302DM as TWA016FCausAssenzeDM) do
  begin
    if Trim(SelTabella.FieldByName('TipoCumulo').AsString) = '' then exit;
    Cod:=SelTabella.FieldByName('TipoCumulo').AsString[1];
    A016MW.AllineaFieldTipoCumulo(Cod);
    VisualizzaComponentiCarattCumulo(not(Cod in ['H']));
    //VisualizzaComponentiFasce(not(Cod in ['H','N','P','Q','R','S','T']));
    AbilitaGrigliaCompetenze(not(Cod in ['H','N','P','Q','R','S','T']));
    drdgRapportiUniti.Enabled:=(A016MW.T265.FieldByName('C_CONTASOLARE').AsString = 'N') and (Cod <> 'H');
    lblCausaleSuccessiva.Enabled:=not(Cod in ['H']);
    dlblCausaleSuccessiva.Enabled:=not(Cod in ['H']);
    cmbCausaleSuccessiva.Enabled:=not(Cod in ['H']);
    lnkTipoCumulo.Enabled:=Cod in ['Z'];
    lnkPeriodoCumuloPersonalizzato.Visible:=not(Cod in ['H','Z']);
    dchkPeriodoCumuloPersonalizzato.Visible:=not(Cod in ['H','Z']);
    C190VisualizzaElemento(JQuery,'grpProporzioneCompetenze',not(Cod in ['H']));
    dchkTempoDeterminato.Enabled:=(Cod in ['C','I','O']);
    VisualizzaComponentiCumulo(Cod in ['B','C','D','G','I','O','T','Q']);
    if Cod = 'Q' then
    begin
      drgpUMCumulo.Caption:='Parametri di maturazione primi riposi';
      drgpUMCumulo.Items.Clear;
      drgpUMCumulo.Items.Add('Domeniche da inizio anno');
      drgpUMCumulo.Items.Add('Domeniche del mese');
      drgpUMCumulo.Items.Add('No Domeniche');
      drgpUMCumulo.Values.Clear;
      drgpUMCumulo.Values.Add('A');
      drgpUMCumulo.Values.Add('M');
      drgpUMCumulo.Values.Add('N');
      drgpUMCumulo.Width:=450;
    end
    else
    begin
      drgpUMCumulo.Caption:='Unità di misura';
      drgpUMCumulo.Items.Clear;
      drgpUMCumulo.Items.Add('Anni');
      drgpUMCumulo.Items.Add('Mesi');
      drgpUMCumulo.Values.Clear;
      drgpUMCumulo.Values.Add('A');
      drgpUMCumulo.Values.Add('M');
      drgpUMCumulo.Width:=120;
    end;
    drgpUMCumulo.ItemIndex:=drgpUMCumulo.Values.IndexOf(SelTabella.FieldByName('UMCumulo').AsString);
    drgpUMCumulo.Enabled:=not (Cod in ['B','T']);
    dedtDurataCumulo.Visible:=Cod in ['B','C','D','G','I','O','T'];
    dedtGMCumulo.Visible:=Cod in ['D'];
    VisualizzaComponentiRiposi(Cod in ['Q']);
    VisualizzaComponentiFestivita(Cod in ['P']);
    VisualizzaComponentiInizioCumulo(not(Cod in ['H']));
    dchkCumuloFamGGDopo.Visible:=Cod in ['G'];
    dchkCTMantieniResidNeg.Visible:=Cod in ['T'];
    cmbCodCauInizio.Visible:=Cod in ['F','G'];
    lblDCausale.Visible:=Cod in ['F','G'];
    lblCausale.Visible:=Cod in ['F','G'];
    // AOSTA_REGIONE - commessa 2012/152.ini
    C190VisualizzaElemento(JQuery,'pnlCongParentali',Cod in ['F']);
    // AOSTA_REGIONE - commessa 2012/152.fine
    VisualizzaComponentiAssenzeTollerate(Cod in ['P','S','T','U']);
    VisualizzaTipoCumuloM(Cod in ['M']);
    if Cod in ['M'] then
      dchkProgressivo.Visible:=True
    else
      dchkProgressivo.Visible:=Cod in ['Q'];
    lblDurataCumulo.Visible:=dedtDurataCumulo.Visible;
    lblGMCumulo.Visible:=dedtGMCumulo.Visible;
    if Cod in ['M','P','U'] then
      lblAssenze.Caption:='Causali tollerate:'
    else
      lblAssenze.Caption:='Causali considerate:';
  end;
end;

procedure TWA016FCausAssenzeDettFM.ResultRichiediValidazione(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrNo then
    (WR302DM as TWA016FCausAssenzeDM).SelTabella.FieldByName('VALIDAZIONE').AsString:='N';
end;

procedure TWA016FCausAssenzeDettFM.dgrpCumuloGlobaleClick(Sender: TObject);
begin
  with (WR302DM as TWA016FCausAssenzeDM) do
    if (SelTabella.State in [dsEdit,dsInsert]) and (dgrpCumuloGlobale.ItemIndex <> 2) then
      SelTabella.FieldByName('CAMPOGLOBALE').Clear;
  dcmbRaggruppamento.Enabled:=dgrpCumuloGlobale.ItemIndex = 2;
end;

procedure TWA016FCausAssenzeDettFM.drgpGSignificClick(Sender: TObject);
begin
  inherited;
  if drgpGSignific.ItemIndex >= 0 then
  begin
    dcmbggnnLav.Enabled:=drgpGSignific.Items[drgpGSignific.ItemIndex] = 'Giorni di Calendario';
    if drgpGSignific.Items[drgpGSignific.ItemIndex] <> 'Giorni di Calendario' then
      (WR302DM as TWA016FCausAssenzeDM).A016MW.T265.FieldByName('COPRI_GGNONLAV').AsString:='N';
  end;
end;

procedure TWA016FCausAssenzeDettFM.drgpUMisuraClick(Sender: TObject);
{Cambio la picture dei campi Competenze a seconda che si lavori in Ore o in Giorni}
var i:Byte;
    RadioValue:Integer;
begin
  RadioValue:=Max(0,drgpUMisura.ItemIndex); //Se vale -1 lo porto a 0
  drgpArrotOre2GG.Enabled:=(RadioValue = 0) or ((WR302DM as TWA016FCausAssenzeDM).A016MW.T265.FieldByName('C_CONTASOLARE').AsString = 'S');
  {Max Unitario e Competenze G/H}
  dedtHMaxUnitario.Enabled:=(not drgpUMisura.Enabled) or (RadioValue = 0);
  dedtGMaxUnitario.Enabled:=(not drgpUMisura.Enabled) or (RadioValue = 1);
  lblMaxOre.Enabled:=(not drgpUMisura.Enabled) or (RadioValue = 0);
  lblMaxGiorni.Enabled:=(not drgpUMisura.Enabled) or (RadioValue = 1);
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.T265 do
  begin
    if State in [dsInsert,dsEdit] then
    begin
      if not dedtHMaxUnitario.Enabled then FieldByName('HMaxUnitario').Clear;
      if not dedtGMaxUnitario.Enabled then FieldByName('GMaxUnitario').Clear;
    end;
    i:=20;
  end;
  RiAbilitaTipoPropPtVGG;
end;

procedure TWA016FCausAssenzeDettFM.cmbVocePagheAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
 (WR302DM as TWA016FCausAssenzeDM).selTabella.FieldByName('VocePaghe').AsString:=cmbVocePaghe.Text;
 //Utente: VENEZIA_IUAV Chiamata: 94562; in caso di nessun elemento della combo deve essere consentito l'elemento custom;
 //Miglioramenti grafici
 C190VisualizzaElementoAsync(JQuery,'grpUmScaricoPaghe',cmbVocePaghe.Text <> '');
end;

procedure TWA016FCausAssenzeDettFM.chkPartTimeOClick(Sender: TObject);
begin
  drgpTipoProporzione.Enabled:=chkPartTimeO.Checked or chkPartTimeV.Checked or chkPartTimeC.Checked;
  RiAbilitaTipoPropPtVGG;
end;

procedure TWA016FCausAssenzeDettFM.chkVistaPeriodoCorrClick(
  Sender: TObject);
var
  WA016DM:TWA016FCausAssenzeDM;
begin
  WA016DM:=(WR302DM as TWA016FCausAssenzeDM);
  if (WA016DM.selTabella.State = dsBrowse) and (WR302DM.selTabella.RecordCount > 0) then
  begin
    if chkVistaPeriodoCorr.Checked then
    begin
      cmbDecParStor.ItemIndex:=WA016DM.A016StoricoMW.IndiceDecorrenzaCorrente;
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

procedure TWA016FCausAssenzeDettFM.cmbCauFruizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWA016FCausAssenzeDM).SelTabella.FieldByName('CodCauFruizione').AsString:=cmbCauFruizione.Text;
end;

procedure TWA016FCausAssenzeDettFM.cmbCausale10GiorniAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
 (WR302DM as TWA016FCausAssenzeDM).SelTabella.FieldByName('CodCau3').AsString:=cmbCausale10Giorni.Text;
end;

procedure TWA016FCausAssenzeDettFM.cmbCausaleSuccessivaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWA016FCausAssenzeDM).SelTabella.FieldByName('Causale_Successiva').AsString:=cmbCausaleSuccessiva.Text;
end;

procedure TWA016FCausAssenzeDettFM.cmbCodCauInizioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWA016FCausAssenzeDM).SelTabella.FieldByName('CodCauInizio').AsString:=cmbCodCauInizio.Text;
end;

procedure TWA016FCausAssenzeDettFM.cmbCodRaggrAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWA016FCausAssenzeDM).SelTabella.FieldByName('CodRaggr').AsString:=cmbCodRaggr.Text;
end;

procedure TWA016FCausAssenzeDettFM.cmbCodRaggrChange(Sender: TObject; Index: Integer);
begin
  inherited;
  (WR302DM as TWA016FCausAssenzeDM).A016MW.Q260.SearchRecord('CODICE',cmbCodRaggr.Text,[srFromBeginning]);
  AbilitaTipoPropPtVGG;
end;

procedure TWA016FCausAssenzeDettFM.cmbDecParStorChange(Sender: TObject);
var
  DataPeriodo:TDateTime;
begin
  (WR302DM as TWA016FCausAssenzeDM).A016StoricoMW.SvuotaCDSStoriaDati;
  if (WR302DM.selTabella.State = dsBrowse) then
  begin
    DataPeriodo:=StrToDate(cmbDecParStor.Text);
    (WR302DM as TWA016FCausAssenzeDM).AggiornaCDSParamStoriciz(DataPeriodo);
    AggiornaGridParamStoricizzati;
  end;
end;

procedure TWA016FCausAssenzeDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWA016FCausAssenzeDM) do
  begin
    selTabella.FieldByName('VocePaghe').AsString:=cmbVocePaghe.Text;
    SelTabella.FieldByName('CodRaggr').AsString:=cmbCodRaggr.Text;
    SelTabella.FieldByName('Causale_Successiva').AsString:=cmbCausaleSuccessiva.Text;
    SelTabella.FieldByName('CodCau3').AsString:=cmbCausale10Giorni.Text;
    SelTabella.FieldByName('CodCauFruizione').AsString:=cmbCauFruizione.Text;
    SelTabella.FieldByName('CodCauInizio').AsString:=cmbCodCauInizio.Text;
  end;
end;

procedure TWA016FCausAssenzeDettFM.DataSet2Componenti;
var i:Integer;
begin
  inherited;
  with (WR302DM as TWA016FCausAssenzeDM) do
  begin
    cmbVocePaghe.Text:=SelTabella.FieldByName('VocePaghe').AsString;
    cmbCodRaggr.Text:=SelTabella.FieldByName('CodRaggr').AsString;
    cmbCausaleSuccessiva.Text:=SelTabella.FieldByName('Causale_Successiva').AsString;
    cmbCausale10Giorni.Text:=SelTabella.FieldByName('CodCau3').AsString;
    cmbCauFruizione.Text:=SelTabella.FieldByName('CodCauFruizione').AsString;
    cmbCodCauInizio.Text:=SelTabella.FieldByName('CodCauInizio').AsString;
  end;
  if grdCausTollerate.medpDataSet <> nil then
    grdCausTollerate.medpAggiornaCDS;
  if dgrdCausIncomp.medpDataSet <> nil then
    dgrdCausIncomp.medpAggiornaCDS;
  EvtDataChange;
  AbilitaTipoPropPtVGG;
end;

procedure TWA016FCausAssenzeDettFM.dchkFruibileAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dChkPropAbilitazione.Enabled:=not dchkFruibile.Checked;
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.T265 do
    if (not dChkPropAbilitazione.Enabled) and (State in [dsEdit, dsInsert]) then
      FieldByName('PROPORZIONA_ABILITAZIONE').AsString:='N';
end;

procedure TWA016FCausAssenzeDettFM.dchkFruizioneClick(Sender: TObject);
begin
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.T265 do
  begin
    lblFruizioneDurata.Enabled:=dchkFruizione.Checked;
    lblFruizioneDopo.Enabled:=dchkFruizione.Checked;
    lblFruizioneCausale.Enabled:=dchkFruizione.Checked;
    dedtDurata.Enabled:=dchkFruizione.Checked;
    dedtOffsetFruizione.Enabled:=dchkFruizione.Checked;
    drgpUMFruizione.Enabled:=dchkFruizione.Checked;
    cmbCauFruizione.Enabled:=dchkFruizione.Checked;
    dchkFruizioneFamGGDopo.Enabled:=dchkFruizione.Checked;
    lblFruizioneFamiliari.Enabled:=dchkFruizione.Checked;
    dcmbFruizioneFamiliari.Enabled:=dchkFruizione.Checked;
    FieldByName('DurataFruizione').Required:=dchkFruizione.Checked;
    if not(State in [dsInsert,dsEdit]) then exit;
    if not dchkFruizione.Checked then
    begin
      FieldByName('DurataFruizione').Clear;
      FieldByName('CodCauFruizione').Clear;
      FieldByName('Fruizione_Familiari').AsString:='N';
    end;
  end;
  EvtDataChange;
end;

procedure TWA016FCausAssenzeDettFM.dchkNoSuperoCompetenzeAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dchkNoSuperoCompWeb.Enabled:=not dchkNoSuperoCompetenze.Checked;
  if not dchkNoSuperoCompWeb.Enabled then
    (WR302DM as TWA016FCausAssenzeDM).SelTabella.FieldByName('NO_SUPERO_COMPETENZE_WEB').AsString:='S';
end;

procedure TWA016FCausAssenzeDettFM.dchkRegistraStoricoClick(Sender: TObject);
begin
  if (WR302DM as TWA016FCausAssenzeDM).SelTabella.State = dsEdit then
    MsgBox.WebMessageDlg(A000MSG_A016_MSG_REGISTRA_STORICO,mtInformation,[mbOk],nil,'');
end;

procedure TWA016FCausAssenzeDettFM.btnAssenzeClick(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with (WR302DM as TWA016FCausAssenzeDM).SelTabella do
    if (FieldByName('TipoCumulo').AsString = 'M') or (FieldByName('TipoCumulo').AsString = 'T') or (FieldByName('TipoCumulo').AsString = 'U') then
      CaricaLista
    else
      CaricaCausaliAssPres;
  with WC013 do
  begin
    C190PutCheckList(dedtAssenze.Text,5,ckList);
    ResultEvent:=ResultAssenze;
    Visualizza;
  end;
end;

procedure TWA016FCausAssenzeDettFM.btnCausaliCollegateClick(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  CaricaLista;
  with WC013 do
  begin
    C190PutCheckList(dedtCausaliCollegate.Text,5,ckList);
    ResultEvent:=ResultCausaliCollegate;
    Visualizza;
  end;
end;

procedure TWA016FCausAssenzeDettFM.btnCodCau2Click(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  CaricaLista;
  with WC013 do
  begin
    C190PutCheckList(dedtCodCau2.Text,5,ckList);
    ResultEvent:=ResultCodCau2;
    Visualizza;
  end;
end;

procedure TWA016FCausAssenzeDettFM.btnCausaliCumuloL133Click(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  CaricaLista;
  with WC013 do
  begin
    C190PutCheckList(dedtCausaliCumuloL133.Text,5,ckList);
    ResultEvent:=ResultCausaliCumuloL133;
    Visualizza;
  end;
end;

procedure TWA016FCausAssenzeDettFM.btnDecParStorPrecClick(Sender: TObject);
begin
  if (WR302DM.selTabella.State = dsBrowse) and (cmbDecParStor.ItemIndex > 0) and
     (WR302DM.selTabella.RecordCount > 0) then
  begin
    cmbDecParStor.ItemIndex:=(cmbDecParStor.ItemIndex - 1);
    cmbDecParStorChange(nil);
  end;
end;

procedure TWA016FCausAssenzeDettFM.btnDecParStorSuccClick(Sender: TObject);
begin
  if (WR302DM.selTabella.State = dsBrowse) and
     (cmbDecParStor.ItemIndex < cmbDecParStor.Items.Count) and
     (WR302DM.selTabella.RecordCount > 0) then
  begin
    cmbDecParStor.ItemIndex:=(cmbDecParStor.ItemIndex + 1);
    cmbDecParStorChange(nil);
  end;
end;

procedure TWA016FCausAssenzeDettFM.ResultAssenze(Sender: TObject; Result:Boolean);
begin
  if Result then
  begin
    WR302DM.selTabella.FieldByName(dedtAssenze.DataField).AsString:=C190GetCheckList(5,WC013.ckList);
    with (WR302DM as TWA016FCausAssenzeDM).SelTabella do
      if (FieldByName('TipoCumulo').AsString = 'T') and (Pos(',',FieldByName('TipoCumulo').AsString) > 0) then
        FieldByName('TipoCumulo').AsString:=Copy(FieldByName('TipoCumulo').AsString,1,Pos(',',WR302DM.selTabella.FieldByName(dedtAssenze.DataField).AsString) - 1);
  end;
end;

procedure TWA016FCausAssenzeDettFM.ResultCodCau2(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtCodCau2.DataField).AsString:=C190GetCheckList(5,WC013.ckList);
end;

procedure TWA016FCausAssenzeDettFM.ResultCausaliCumuloL133(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtCausaliCumuloL133.DataField).AsString:=C190GetCheckList(5,WC013.ckList);
end;

procedure TWA016FCausAssenzeDettFM.ResultCausaliCollegate(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtCausaliCollegate.DataField).AsString:=C190GetCheckList(5,WC013.ckList);
end;

procedure TWA016FCausAssenzeDettFM.CaricaLista;
begin
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.Q265A do
  begin
    First;
    while not Eof do
    begin
      WC013.ckList.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      WC013.ckList.Values.Add(Trim(FieldByName('CODICE').AsString));
      Next;
    end;
  end;
end;

procedure TWA016FCausAssenzeDettFM.CaricaCausaliAssPres;
var P:Boolean;
begin
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.selT265T275 do
  begin
    P:=False;
    WC013.ckList.Items.Add('     * ASSENZE *');
    First;
    while not Eof do
    begin
      if (not P) and (FieldByName('TIPO').AsString = 'P') then
      begin
        WC013.ckList.Items.Add('     * PRESENZE *');
        P:=True;
      end;
      WC013.ckList.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

procedure TWA016FCausAssenzeDettFM.CaricaMultiColumnComboBox;
var i:Integer;
begin
  inherited;
  // load cmbCodRaggr
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.Q260 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbCodRaggr.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  //load cmbVocePaghe
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.selP200 do
  begin
    First;
    while not Eof do
    begin
      cmbVocePaghe.AddRow(FieldByName('COD_VOCE').AsString + ';'+ FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  //Utente: VENEZIA_IUAV Chiamata: 94562; in caso di nessun elemento della combo deve essere consentito l'elemento custom;
  cmbVocePaghe.CustomElement:=cmbVocePaghe.Items.Count = 0;

  // load cmbCausaleSuccessiva, cmbCausale10Giorni, cmbCauFruizione
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.Q265A do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbCausaleSuccessiva.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbCausale10Giorni.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbCauFruizione.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbCodCauInizio.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA016FCausAssenzeDettFM.AbilitaComponenti;
begin
  inherited;
  with (WR302DM as TWA016FCausAssenzeDM) do
  begin
    grdCausTollerate.medpAttivaGrid(A016MW.SelT266,(selTabella.State in [dsInsert,dsEdit]),(selTabella.State in [dsInsert,dsEdit]));
    dgrdCausIncomp.medpAttivaGrid(A016MW.SelT259,(selTabella.State in [dsInsert,dsEdit]),(selTabella.State in [dsInsert,dsEdit]));
  end;
  grdCausTollerate.medpCancellaRigaWR102;
  grdCausTollerate.medpPreparaComponentiDefault;
  grdCausTollerate.medpPreparaComponenteGenerico('WR102',grdCausTollerate.medpIndexColonna('CAUSALI'),1,DBG_IMG,'','PUNTINI','','','');
  dgrdCausIncomp.medpCancellaRigaWR102;
  dgrdCausIncomp.medpPreparaComponentiDefault;
end;

procedure TWA016FCausAssenzeDettFM.AbilitaGrigliaCompetenze(Abilitato:Boolean);
begin
  dedtComp1.Enabled:=Abilitato;
  dedtComp2.Enabled:=Abilitato;
  dedtComp3.Enabled:=Abilitato;
  dedtComp4.Enabled:=Abilitato;
  dedtComp5.Enabled:=Abilitato;
  dedtComp6.Enabled:=Abilitato;
  dedtRetrib1.Enabled:=Abilitato;
  dedtRetrib2.Enabled:=Abilitato;
  dedtRetrib3.Enabled:=Abilitato;
  dedtRetrib4.Enabled:=Abilitato;
  dedtRetrib5.Enabled:=Abilitato;
  dedtRetrib6.Enabled:=Abilitato;
  dchkCompetenzePersonalizzate.Enabled:=(WR302DM as TWA016FCausAssenzeDM).selTabella.FieldByName('TipoCumulo').AsString <> 'H';
  dchkArrotCompetenze.Enabled:=(WR302DM as TWA016FCausAssenzeDM).selTabella.FieldByName('TipoCumulo').AsString <> 'H';
  lblFascia1.Enabled:=Abilitato;
  lblFascia2.Enabled:=Abilitato;
  lblFascia3.Enabled:=Abilitato;
  lblFascia4.Enabled:=Abilitato;
  lblFascia5.Enabled:=Abilitato;
  lblFascia6.Enabled:=Abilitato;
  lblCompetenze.Enabled:=Abilitato;
  lblPercRetribuzione.Enabled:=Abilitato;
end;

procedure TWA016FCausAssenzeDettFM.ImpostaPartTime;
begin
  with (WR302DM as TWA016FCausAssenzeDM).A016MW do
    if T265.State = dsBrowse then
    begin
      chkPartTimeO.Checked:=Pos('O',T265.FieldByName('PARTTIME').AsString) > 0;
      chkPartTimeV.Checked:=Pos('V',T265.FieldByName('PARTTIME').AsString) > 0;
      chkPartTimeC.Checked:=Pos('C',T265.FieldByName('PARTTIME').AsString) > 0;
    end;
end;

procedure TWA016FCausAssenzeDettFM.VisualizzaComponentiCarattCumulo(Visualizza: Boolean);
var i:Integer;
begin
 for i:=0 to WA016RegCumuloRG.ControlCount -1 do
   if WA016RegCumuloRG.Controls[i] is TComponent then
    WA016RegCumuloRG.Controls[i].Visible:=Visualizza;
 lnkTipoCumulo.Visible:=True;
 dcmbTipoCumulo.Visible:=True;
end;

{
procedure TWA016FCausAssenzeDettFM.VisualizzaComponentiFasce(Visualizza: Boolean);
begin
  lblFascia1.Visible:=Visualizza;
  lblFascia2.Visible:=Visualizza;
  lblFascia3.Visible:=Visualizza;
  lblFascia4.Visible:=Visualizza;
  lblFascia5.Visible:=Visualizza;
  lblFascia6.Visible:=Visualizza;
  dedtComp1.Visible:=Visualizza;
  dedtComp2.Visible:=Visualizza;
  dedtComp3.Visible:=Visualizza;
  dedtComp4.Visible:=Visualizza;
  dedtComp5.Visible:=Visualizza;
  dedtComp6.Visible:=Visualizza;
  dedtRetrib1.Visible:=Visualizza;
  dedtRetrib2.Visible:=Visualizza;
  dedtRetrib3.Visible:=Visualizza;
  dedtRetrib4.Visible:=Visualizza;
  dedtRetrib5.Visible:=Visualizza;
  dedtRetrib6.Visible:=Visualizza;
  lblCompetenze.Visible:=Visualizza;
  lblPercRetribuzione.Visible:=Visualizza;
  dchkCompetenzePersonalizzate.Visible:=Visualizza;
  dchkArrotCompetenze.Visible:=Visualizza;
end;
}

procedure TWA016FCausAssenzeDettFM.CodRaggrChange;
var AnnoS:string;
{Abilita/disabilita i controlli a seconda del Conteggio Anno Solare}
begin
  with (WR302DM as TWA016FCausAssenzeDM).A016MW do
  begin
    Q265B.Filtered:=False;
    Q265B.Filtered:=True;
    AnnoS:=T265.FieldByName('C_CONTASOLARE').AsString;//Q260.FieldByName('ContASolare').AsString;
    drgpUMisura.Enabled:=AnnoS = 'N';
    //Massimo: sostituisce R180AbilitaOggetti(grpFasce,(AnnoS = 'N') and (not (R180CarattereDef(T265.FieldByName('TipoCumulo').AsString,1,'H') in ['H','N','P','Q','R','S','T'])));
    AbilitaGrigliaCompetenze((AnnoS = 'N') and (not (R180CarattereDef(T265.FieldByName('TipoCumulo').AsString,1,'H') in ['H','N','P','Q','R','S','T'])));
    drdgRapportiUniti.Enabled:=(AnnoS = 'N') and (T265.FieldByName('TipoCumulo').AsString <> 'H');
    dedtHMaxUnitario.Enabled:=(AnnoS = 'S') or (T265.FieldByName('UMisura').AsString = 'O');
    dedtGMaxUnitario.Enabled:=(AnnoS = 'S') or (T265.FieldByName('UMisura').AsString = 'G');
    lblMaxOre.Enabled:=(AnnoS = 'S') or (T265.FieldByName('UMisura').AsString = 'O');
    lblMaxGiorni.Enabled:=(AnnoS = 'S') or (T265.FieldByName('UMisura').AsString = 'G');
    dcmbTipoCumulo.Enabled:=AnnoS = 'N';
    drgpArrotOre2GG.Enabled:=(T265.FieldByName('UMisura').AsString = 'O') or (AnnoS = 'S');
    if T265.State in [dsEdit,dsInsert] then
    begin
      if not dedtHMaxUnitario.Enabled then T265.FieldByName('HMaxUnitario').Clear;
      if not dedtGMaxUnitario.Enabled then T265.FieldByName('GMaxUnitario').Clear;
      if AnnoS = 'S' then T265.FieldByName('TipoCumulo').AsString:='A';
    end;
  end;
end;

procedure TWA016FCausAssenzeDettFM.EvtStateChange;
begin
  with (WR302DM as TWA016FCausAssenzeDM) do
  begin
    // Massimo: Commentato perchè il campo è ora una multiColumnComboBox con gestione standard
    //btnVocePaghe.Enabled:=(DButton.State in [dsInsert,dsEdit]) and (A016FCausAssenzeDtM1.A016MW.selP200.RecordCount > 0);
    cmbVocePaghe.Enabled:=(SelTabella.State in [dsInsert,dsEdit]);// and (A016MW.selP200.RecordCount > 0);
    // Massimo: impostato a False perchè rientra nella gestione standard della medpGrid collegata
    //selT266.ReadOnly:=not(SelTabella.State in [dsEdit,dsInsert]);
    A016MW.selT266.ReadOnly:=False;
    //dchkEsclusione.Enabled:=not (dcmbInfluCont.SelectedValue = 'I');
    dchkEsclusione.Enabled:=not (dcmbInfluCont.Items.ValueFromIndex[dcmbInfluCont.ItemIndex] = 'I');
    //Paolo: 14/09/2015
    //C190VisualizzaElemento(JQuery,'grpPartTime',(SelTabella.State in [dsInsert,dsEdit]));
    //Bruno: 11/02/2015
    dcmbggnnLav.Enabled:=(SelTabella.State in [dsInsert,dsEdit]) and (drgpGSignific.Items[drgpGSignific.ItemIndex] = 'Giorni di Calendario');
    btnModificaParStor.Enabled:=(not(SelTabella.State in [dsInsert,dsEdit]));
    ImpostaPartTime;
    EvtDataChange;
  end;
  dedtHmAssenza.Enabled:=False;
  lblGgAssenza.Enabled:=False;
  drgpValorGior.Enabled:=False;
  dchkTimbPM.Enabled:=False;
  dchkTimbPMDetraz.Enabled:=False;
end;

procedure TWA016FCausAssenzeDettFM.grdCausTollerateComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.selT266 do
    FieldByName('CAUSALI').AsString:=TmeIWEdit(grdCausTollerate.medpCompCella(grdCausTollerate.medpClientDataSet.RecNo-1,grdCausTollerate.medpIndexColonna('CAUSALI'),0)).Text;
end;

procedure TWA016FCausAssenzeDettFM.grdCausTollerateDataSet2Componenti(Row: Integer);
var r : Integer;
    img : TmeIWImageFile;
begin
  inherited;
  for r := ifthen(grdCausTollerate.medpDataSet.state in [dsInsert],0,1) to High(grdCausTollerate.medpCompGriglia) do
    if grdCausTollerate.medpCompCella(r,grdCausTollerate.medpIndexColonna('CAUSALI'),1) <> nil then
    begin
      img:=TmeIWImageFile(grdCausTollerate.medpCompCella(r,grdCausTollerate.medpIndexColonna('CAUSALI'),1));
      img.OnClick:=imgCausaliClick;
    end;
end;

procedure TWA016FCausAssenzeDettFM.imgCausaliClick(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  CaricaLista;
  with WC013 do
  begin
    ResultEvent:=imgCausaliResult;
    C190PutCheckList(TmeIWEdit(grdCausTollerate.medpCompCella(grdCausTollerate.medpClientDataSet.RecNo-1,grdCausTollerate.medpIndexColonna('CAUSALI'),0)).Text,5,ckList);
    Visualizza;
  end;
end;

procedure TWA016FCausAssenzeDettFM.imgCausaliResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    TmeIWEdit(grdCausTollerate.medpCompCella(grdCausTollerate.medpClientDataSet.RecNo-1,grdCausTollerate.medpIndexColonna('CAUSALI'),0)).Text:=Trim(C190GetCheckList(5,WC013.ckList));
end;

procedure TWA016FCausAssenzeDettFM.grdCausTollerateRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=TmedpIWDBGrid(ACell.Grid).medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(TmedpIWDBGrid(ACell.Grid).medpCompGriglia) + 1) and (TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA016FCausAssenzeDettFM.dgrdCausIncompComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA016FCausAssenzeDM).A016MW.selT259,dgrdCausIncomp do
  begin
    FieldByName('TIPO_CONTROLLO').AsString:=(medpCompCella(Row,medpIndexColonna('TIPO_CONTROLLO'),0) as TMedpIWMultiColumnComboBox).Text;
    FieldByName('SEX_FRUITORE').AsString:=(medpCompCella(Row,medpIndexColonna('SEX_FRUITORE'),0) as TMedpIWMultiColumnComboBox).Text;
    FieldByName('CAU_INCOMPATIBILE').AsString:=(medpCompCella(Row,medpIndexColonna('CAU_INCOMPATIBILE'),0) as TMedpIWMultiColumnComboBox).Text;
    FieldByName('SEX_CAU_INCOMP').AsString:=(medpCompCella(Row,medpIndexColonna('SEX_CAU_INCOMP'),0) as TMedpIWMultiColumnComboBox).Text;
    FieldByName('INCLUDI_FAM').AsString:=(medpCompCella(Row,medpIndexColonna('INCLUDI_FAM'),0) as TMedpIWMultiColumnComboBox).Text;
  end;
end;

procedure TWA016FCausAssenzeDettFM.dgrdCausIncompDataSet2Componenti(Row: Integer);
var i,j,c:Integer;
begin
  inherited;
  with dgrdCausIncomp do
  begin
    i:=Row;
    // Tipo
    c:=medpIndexColonna('TIPO_CONTROLLO');
    medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'1','2','','','S');
    medpCreaComponenteGenerico(i,c,Componenti);
    with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
    begin
      with (WR302DM as TWA016FCausAssenzeDM).A016MW do
      for j:=0 to High(D_Incomp_TipoContr) do
        AddRow(D_Incomp_TipoContr[j].Value + ';' + Copy(D_Incomp_TipoContr[j].Item,5));
      Text:=medpValoreColonna(i,'TIPO_CONTROLLO');
    end;
    // Genere
    c:=medpIndexColonna('SEX_FRUITORE');
    medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'1','2','','','S');
    medpCreaComponenteGenerico(i,c,Componenti);
    with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
    begin
      with (WR302DM as TWA016FCausAssenzeDM).A016MW do
      for j:=0 to High(D_Incomp_Genere) do
        AddRow(D_Incomp_Genere[j].Value + ';' + Copy(D_Incomp_Genere[j].Item,5));
      Text:=medpValoreColonna(i,'SEX_FRUITORE');
    end;
    // Caus. incomp.
    (WR302DM as TWA016FCausAssenzeDM).A016MW.CaricaListaCausIncomp;
    c:=medpIndexColonna('CAU_INCOMPATIBILE');
    medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'5','2','','','S');
    medpCreaComponenteGenerico(i,c,Componenti);
    with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
    begin
      with (WR302DM as TWA016FCausAssenzeDM).A016MW do
      for j:=0 to High(D_Incomp_Caus) do
        AddRow(D_Incomp_Caus[j].Value + ';' + Copy(D_Incomp_Caus[j].Item,5));
      Text:=medpValoreColonna(i,'CAU_INCOMPATIBILE');
    end;
    // Genere incomp.
    c:=medpIndexColonna('SEX_CAU_INCOMP');
    medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'1','2','','','S');
    medpCreaComponenteGenerico(i,c,Componenti);
    with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
    begin
      with (WR302DM as TWA016FCausAssenzeDM).A016MW do
      for j:=0 to High(D_Incomp_Genere) do
        AddRow(D_Incomp_Genere[j].Value + ';' + Copy(D_Incomp_Genere[j].Item,5));
      Text:=medpValoreColonna(i,'SEX_CAU_INCOMP');
    end;
    // Incl. fam.
    c:=medpIndexColonna('INCLUDI_FAM');
    medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'1','2','','','S');
    medpCreaComponenteGenerico(i,c,Componenti);
    with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
    begin
      with (WR302DM as TWA016FCausAssenzeDM).A016MW do
      for j:=0 to High(D_Incomp_InclFam) do
        AddRow(D_Incomp_InclFam[j].Value + ';' + Copy(D_Incomp_InclFam[j].Item,5));
      Text:=medpValoreColonna(i,'INCLUDI_FAM');
    end;
  end;
end;

procedure TWA016FCausAssenzeDettFM.dgrdCausIncompRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=TmedpIWDBGrid(ACell.Grid).medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(TmedpIWDBGrid(ACell.Grid).medpCompGriglia) + 1) and (TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA016FCausAssenzeDettFM.VisualizzaComponentiRiposi(Visualizza: Boolean);
begin
  dchkProgressivo.Visible:=Visualizza;
  dchkFestivi.Visible:=Visualizza;
  C190VisualizzaElemento(JQuery,'grpGiorniNonLav',Visualizza);
end;

procedure TWA016FCausAssenzeDettFM.VisualizzaTipoCumuloM(Visualizza: Boolean);
begin
  C190VisualizzaElemento(JQuery,'grpCausTollerate',Visualizza);
  lblCMDebSett.Visible:=Visualizza;
  dedtCMDebSett.Visible:=Visualizza;
end;

procedure TWA016FCausAssenzeDettFM.WA016ParamStoricizRGRender(
  Sender: TObject);
begin
  ToggleControlliSchedaParStor(not (WR302DM.SelTabella.State in [dsInsert,dsEdit]));
end;

procedure TWA016FCausAssenzeDettFM.VisualizzaComponentiFestivita(Visualizza: Boolean);
begin
  dchkFestGiustif.Visible:=Visualizza;
  dchkDomeniche.Visible:=Visualizza;
  dchkPianiFreper.Visible:=Visualizza;
end;

procedure TWA016FCausAssenzeDettFM.VisualizzaComponentiAssenzeTollerate(Visualizza: Boolean);
begin
  lblAssenze.Visible:=Visualizza;
  dedtAssenze.Visible:=Visualizza;
  btnAssenze.Visible:=Visualizza;
end;

procedure TWA016FCausAssenzeDettFM.VisualizzaComponentiInizioCumulo(Visualizza: Boolean);
begin
  lblCumuloFamiliari.Visible:=Visualizza;
  dcmbCumuloFamiliari.Visible:=Visualizza;
  lblCausale.Visible:=Visualizza;
  cmbCodCauInizio.Visible:=Visualizza;
  lblDCausale.Visible:=Visualizza;
end;

procedure TWA016FCausAssenzeDettFM.VisualizzaComponentiCumulo(Visualizza: Boolean);
begin
  C190VisualizzaElemento(JQuery,'grpUMCumulo',Visualizza);
  lblDurataCumulo.Visible:=Visualizza;
  dedtDurataCumulo.Visible:=Visualizza;
  lblGMCumulo.Visible:=Visualizza;
  dchkCumuloFamGGDopo.Visible:=Visualizza;
  dedtGMCumulo.Visible:=Visualizza;
end;

procedure TWA016FCausAssenzeDettFM.AbilitaGrpVincoliFruizione(Visualizza: Boolean);
begin
  dedtFruizMin.Enabled:=Visualizza;
  dedtFruizMax.Enabled:=Visualizza;
  dedtFruizArr.Enabled:=Visualizza;
  lblFruizMin.Enabled:=Visualizza;
  lblFruizMax.Enabled:=Visualizza;
  lblFruizArr.Enabled:=Visualizza;
  dchkFruizCompetenzeArr.Enabled:=Visualizza;
  dchkFruizMaxDebito.Enabled:=Visualizza;
  lblOreGGMaxInf6.Enabled:=Visualizza;
  dedtOreGGMaxInf6.Enabled:=Visualizza;
  lblOreGGMaxSup6.Enabled:=Visualizza;
  dedtOreGGMaxSup6.Enabled:=Visualizza;
end;

procedure TWA016FCausAssenzeDettFM.AbilitaTipoPropPtVGG;
var visibilita: Boolean;
begin
  visibilita:=( Pos('V',(WR302DM as TWA016FCausAssenzeDM).A016MW.T265.FieldByName('PARTTIME').AsString) > 0 )
  and ((WR302DM as TWA016FCausAssenzeDM).SelTabella.FieldByName('UMisura').AsString='G')
  and ((WR302DM as TWA016FCausAssenzeDM).A016MW.Q260.FieldByName('CONTASOLARE').AsString = 'N')
  and ((WR302DM as TWA016FCausAssenzeDM).A016MW.Q260.FieldByName('RESIDUABILE').AsString = 'N');
  lblpropptvgg.Visible:=visibilita;
  dcmbpropptvgg.Visible:=visibilita;
  if not dcmbpropptvgg.Visible then
  begin
    dcmbpropptvgg.ItemIndex:=0;
    if ((WR302DM as TWA016FCausAssenzeDM).A016MW.T265.State in [dsEdit,dsInsert]) then
      (WR302DM as TWA016FCausAssenzeDM).A016MW.T265.FieldByName('PropPtVGG').AsString:='A';
  end;
end;

procedure TWA016FCausAssenzeDettFM.RiAbilitaTipoPropPtVGG;
var visibilita: Boolean;
begin
  visibilita:=chkPartTimeV.Checked and (drgpUMisura.ItemIndex = 1)
  and (TWA016FCausAssenzeDM(WR302DM).A016MW.Q260.FieldByName('CONTASOLARE').AsString = 'N')
  and (TWA016FCausAssenzeDM(WR302DM).A016MW.Q260.FieldByName('RESIDUABILE').AsString = 'N');
  lblpropptvgg.Visible:=visibilita;
  dcmbpropptvgg.Visible:=visibilita;
  if not dcmbpropptvgg.Visible then
  begin
    dcmbpropptvgg.ItemIndex:=0;
    if ((WR302DM as TWA016FCausAssenzeDM).A016MW.T265.State in [dsEdit,dsInsert]) then
      (WR302DM as TWA016FCausAssenzeDM).A016MW.T265.FieldByName('PropPtVGG').AsString:='A';
  end;
end;

procedure TWA016FCausAssenzeDettFM.AggiornaGridParamStoricizzati;
begin
  grdParamStoriciz.medpCaricaCDS;
end;

procedure TWA016FCausAssenzeDettFM.OnWC007FMClose(Sender:TObject);
var
  IDCausale:Integer;
  NuovaDataDecorrenzaStr:String;
begin
  NuovaDataDecorrenzaStr:='';
  if WA016FCausAssenzeStorico <> nil then
  begin
    // Leggo l'ultima data selezionata dal form dei parametri storicizzati
    NuovaDataDecorrenzaStr:=WA016FCausAssenzeStorico.cmbDecorrenza.Text;

    { In IW il parent degli oggetti tenta di distruggerli, ma questi oggetti
      hanno anche riferimenti ad altri che a loro volta tentano di distruggerli.
      IW causa AV dato che tenta di distruggere oggetti già deallocati.
      Ripristiamo il parent naturale per evitare dispose incrociate. }
    WA016FCausAssenzeStorico.grdStatusBar.Parent:=WA016FCausAssenzeStorico;
    WA016FCausAssenzeStorico.grdNavigatorBar.Parent:=WA016FCausAssenzeStorico;
    WA016FCausAssenzeStorico.grdToolBarStorico.Parent:=WA016FCausAssenzeStorico;
    WA016FCausAssenzeStorico.grdTabControl.Parent:=WA016FCausAssenzeStorico;
    WA016FCausAssenzeStorico.WBrowseFM.Parent:=WA016FCausAssenzeStorico;
    WA016FCausAssenzeStorico.WDettaglioFM.Parent:=WA016FCausAssenzeStorico;
    FreeAndNil(WA016FCausAssenzeStorico);
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

procedure TWA016FCausAssenzeDettFM.ToggleControlliSchedaParStor(Attiva:Boolean);
begin
  btnDecParStorPrec.Enabled:=Attiva and (not chkVistaPeriodoCorr.Checked);
  btnDecParStorSucc.Enabled:=Attiva and (not chkVistaPeriodoCorr.Checked);
  cmbDecParStor.Enabled:=Attiva and (not chkVistaPeriodoCorr.Checked);
  chkVistaPeriodoCorr.Enabled:=Attiva;
  btnModificaParStor.Enabled:=Attiva;
end;

end.
