unit WA080UTipologieCartelliniDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWAdvRadioGroup, meTIWAdvRadioGroup,
  IWCompListbox, meIWDBComboBox, meIWGrid, medpIWTabControl, meIWLabel,
  meIWRegion, IWCompButton,
  meIWButton, IWCompCheckbox, meIWDBCheckBox, IWAdvCheckGroup,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, IWCompExtCtrls, IWCompGrids,
  IWCompJQueryWidget, meIWImageFile,DB,IWAppForm,WR100UBase,
  meTIWAdvCheckGroup, meIWDBLookupComboBox,
  WC007UFormContainerFM, WC013UCheckListFM, WC015USelEditGridFM,
  WA080URientriObbligatori, WA080USoglieStraordinario, medpIWMultiColumnComboBox,
  A000UCostanti;

type
  TWA080FTipologieCartelliniDettFM = class(TWR205FDettTabellaFM)
    dedtCodice: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    lblConteggioIstituti: TmeIWLabel;
    drgpConteggioIstituti: TmeIWDBRadioGroup;
    lblTipoConteggio: TmeIWLabel;
    dcmbTipoConteggio: TmeIWDBComboBox;
    lblScostamentoSettimanale: TmeIWLabel;
    dedtScostamentoSettimanale: TmeIWDBEdit;
    grdTabDetail: TmedpIWTabControl;
    TemplateRecuperiRG: TIWTemplateProcessorHTML;
    TemplateAbbattimentiRG: TIWTemplateProcessorHTML;
    TemplateOpzioniRG: TIWTemplateProcessorHTML;
    TemplateLimitiEccedenzeBancaOre: TIWTemplateProcessorHTML;
    WA080AbbattimentiRG: TmeIWRegion;
    dedtSaldoPos: TmeIWDBEdit;
    lblAbbattimentoMensile: TmeIWLabel;
    drgpAbbattimentoMensile: TmeIWDBRadioGroup;
    lblRiposiNonFruiti: TmeIWLabel;
    lblModalita: TmeIWLabel;
    drgpModalita: TmeIWDBRadioGroup;
    lblAbbattimentoLiquidabileMensile: TmeIWLabel;
    lblDescAbbattimentoLiquidabileMensile: TmeIWLabel;
    lblAbbattimentoEccedenza: TmeIWLabel;
    rgpLimiteEccedenzaCompensabile: TmeTIWAdvRadioGroup;
    rgpPeriodicitaAbbattimento: TmeTIWAdvRadioGroup;
    dchkRecuperaNegativo: TmeIWDBCheckBox;
    lblMesiPeriodicita: TmeIWLabel;
    dedtMesiPeriodicita: TmeIWDBEdit;
    lblAbbattimentoMassimo: TmeIWLabel;
    dedtAbbattimentoMassimo: TmeIWDBEdit;
    lblSaldiAnnui: TmeIWLabel;
    imgInvertiSaldiAnnui: TmeIWImageFile;
    cgpSaldiAnnui: TmeTIWAdvCheckGroup;
    lblSaldoRiferimento: TmeIWLabel;
    dcmbSaldoRiferimento: TmeIWDBComboBox;
    lblAbbattimentoOre: TmeIWLabel;
    btnMesiRiferimento: TmeIWButton;
    dchkSaldoLiquidabile: TmeIWDBCheckBox;
    dchkSaldoCompensabile: TmeIWDBCheckBox;
    dchkAbbattimentoEcced: TmeIWDBCheckBox;
    dchkSaldoMeseLordo: TmeIWDBCheckBox;
    WA080RecuperiRG: TmeIWRegion;
    lblOrdinePrelievo: TmeIWLabel;
    lblCompensabileAnnoPrecedente: TmeIWLabel;
    lblLiquidabileAnnoPrecedente: TmeIWLabel;
    lblCompensabileAnnoAttuale: TmeIWLabel;
    lblLiquidabileAnnoAttuale: TmeIWLabel;
    lblSaldiNegativiDaRecuperare: TmeIWLabel;
    dedtCompensabileAnnoPrecedente: TmeIWDBEdit;
    dedtLiquidabileAnnoPrecedente: TmeIWDBEdit;
    dedtCompensabileAnnoAttuale: TmeIWDBEdit;
    dedtLiquidabileAnnoAttuale: TmeIWDBEdit;
    lblFestivitaInfrasettimanali: TmeIWLabel;
    lblRecuperoDebitoPaghe: TmeIWLabel;
    lblMesiPrecedenti: TmeIWLabel;
    lblCausaliAssenzaTollerate: TmeIWLabel;
    dedtCausaliAssenzaTollerate: TmeIWDBEdit;
    dedtApplicaAnagrafiche: TmeIWDBEdit;
    lblApplicaAnagrafiche: TmeIWLabel;
    lblOreMassimeRecuperabili: TmeIWLabel;
    dedtMesiPrecedenti: TmeIWDBEdit;
    dedtOreMassimeRecuperabili: TmeIWDBEdit;
    lblArrotCompAnnoPrec: TmeIWLabel;
    lblArrotLiqAnnoPrec: TmeIWLabel;
    lblArrotCompAnnoAtt: TmeIWLabel;
    lblArrotLiqAnnoAtt: TmeIWLabel;
    dedtArrotCompAnnoPrec: TmeIWDBEdit;
    dedtArrotLiqAnnoPrec: TmeIWDBEdit;
    dedtArrotCompAnnoAtt: TmeIWDBEdit;
    dedtArrotLiqAnnoAtt: TmeIWDBEdit;
    lblOreUtilizzabili: TmeIWLabel;
    lblOreCausalizzateCompensabili: TmeIWLabel;
    dedtOreCausalizzateCompensabili: TmeIWDBEdit;
    lblCausaleRiposiCompensativi: TmeIWLabel;
    btnOreCausalizzateCompensabili: TmeIWButton;
    btnCausaliAssenzaTollerate: TmeIWButton;
    imgApplicaAnagrafiche: TmeIWImageFile;
    lblDescCausaleRiposiCompensativi: TmeIWLabel;
    WA080OpzioniRG: TmeIWRegion;
    lblRicalcoloIndennitaNotturna: TmeIWLabel;
    lblRicalcoloIndennitaPresenza: TmeIWLabel;
    lblOpzioniPassaggioAnno: TmeIWLabel;
    lblLimiteOreResiduabili: TmeIWLabel;
    dedtLimiteOreResiduabili: TmeIWDBEdit;
    lblLimiteOreResiduabiliAnnoCorrente: TmeIWLabel;
    dedtLimiteOreResiduabiliAnnoCorrente: TmeIWDBEdit;
    lblLimiteOreResiduabiliAnnoPrecedente: TmeIWLabel;
    dedtLimiteOreResiduabiliAnnoPrecedente: TmeIWDBEdit;
    lblOpzioniDebitoAggiuntivo: TmeIWLabel;
    dchkRiutilizzoStraordinario: TmeIWDBCheckBox;
    lblRegimeDebitoCredito: TmeIWLabel;
    rgpSaldoNegativo: TmeTIWAdvRadioGroup;
    dedtStabilitoAdOre: TmeIWDBEdit;
    lblSaldoCompensabileMassimo: TmeIWLabel;
    dedtSaldoCompensabileMassimo: TmeIWDBEdit;
    lblArrotondamentoLiquidabile: TmeIWLabel;
    dedtArrotondamentoLiquidabile: TmeIWDBEdit;
    lblArrotondamentoRecupero: TmeIWLabel;
    dedtArrotondamentoRecupero: TmeIWDBEdit;
    lblParametrizzazioneStampa: TmeIWLabel;
    lblDescParametrizzazioneStampa: TmeIWLabel;
    lblRipartizioneOre: TmeIWLabel;
    drgpRipartizioneOre: TmeIWDBRadioGroup;
    dcmbRicalcoloIndennitaNotturna: TmeIWDBComboBox;
    dcmbRicalcoloIndennitaPresenza: TmeIWDBComboBox;
    dchkGestioneAzzeramentoPeriodico: TmeIWDBCheckBox;
    dchkDebitoAggiuntivoMensile: TmeIWDBCheckBox;
    dchkConsideraOreResidue: TmeIWDBCheckBox;
    WA080LimitiEccedenzeBancaOreRG: TmeIWRegion;
    lblLimitiEccedenzaLiquidabile: TmeIWLabel;
    lblLimitiEccedenzaResiduabile: TmeIWLabel;
    dchkTrasformaSuperoTetto: TmeIWDBCheckBox;
    dchkGestioneBancaOre: TmeIWDBCheckBox;
    dchkEsclusioneOreNormali: TmeIWDBCheckBox;
    dchkEsclusioneAbbattimenti: TmeIWDBCheckBox;
    dchkLimiteSaldoComplessivo: TmeIWDBCheckBox;
    dchkLimiteStraordAnnuale: TmeIWDBCheckBox;
    dchkAbbatteCompensabile: TmeIWDBCheckBox;
    dchkRiportoResidui: TmeIWDBCheckBox;
    dchkConsideraResiduiAnnoPrecedente: TmeIWDBCheckBox;
    lblArrotondamentoMensile: TmeIWLabel;
    lblControllaFaseLiquidazione: TmeIWLabel;
    dedtArrotondamentoMensile: TmeIWDBEdit;
    drgpControllaFaseLiquidazione: TmeIWDBRadioGroup;
    lblApplicazioneLimitiEccedenzaLiquidabile: TmeIWLabel;
    drgpApplicazioneLimitiEccedenzaLiquidabile: TmeIWDBRadioGroup;
    lblApplicazioneLimitiEccedenzaResiduabile: TmeIWLabel;
    drgpApplicazioneLimitiEccedenzaResiduabile: TmeIWDBRadioGroup;
    dchkLiquidazioneDistribuita: TmeIWDBCheckBox;
    drgpSaldiNegativiDaRecuperare: TmeIWDBRadioGroup;
    drgpOreUtilizzabili: TmeIWDBRadioGroup;
    drgpCartellino: TmeIWDBRadioGroup;
    lblCartellino: TmeIWLabel;
    drgpOreRecuperate: TmeIWDBRadioGroup;
    lblOreRecuperate: TmeIWLabel;
    rgpTipoApplicazioneEccedenzaLiquidabile: TmeTIWAdvRadioGroup;
    rgpTipoApplicazioneEccedenzaResiduabile: TmeTIWAdvRadioGroup;
    lblRecDebitomaxtollerato: TmeIWLabel;
    dedtRecDebitomaxtollerato: TmeIWDBEdit;
    lblSalvaEccedenza: TmeIWLabel;
    lblSalvaEccedenzaSaldoAtt: TmeIWLabel;
    lblSalvaEccedenzaPrec: TmeIWLabel;
    lblRientriObbl: TmeIWLabel;
    lblCausRientriObbl: TmeIWLabel;
    dedtCausRientriObbl: TmeIWDBEdit;
    btnCausRientriObbl: TmeIWButton;
    btnRientri: TmeIWButton;
    btnSoglie: TmeIWButton;
    cmbAbbattimentoLiquidabileMensile: TMedpIWMultiColumnComboBox;
    cmbPARaggrLimite: TMedpIWMultiColumnComboBox;
    cmbPARaggrLimiteSaldoAtt: TMedpIWMultiColumnComboBox;
    cmbPARaggrLimiteSaldoPrec: TMedpIWMultiColumnComboBox;
    cmbParametrizzazioneStampa: TMedpIWMultiColumnComboBox;
    cmbCausaleRiposiCompensativi: TMedpIWMultiColumnComboBox;
    dchkIterEccGGCheckSaldo: TmeIWDBCheckBox;
    lblCausaliCompensabiliMensili: TmeIWLabel;
    dedtCausaliCompensabiliMensili: TmeIWDBEdit;
    btnCausaliCompensabiliMensili: TmeIWButton;
    lblLimitiCausali: TmeIWLabel;
    dEdtLimitiCausali: TmeIWDBEdit;
    btnLimitiCausali: TmeIWButton;
    rgpCausaliCompMensSaldo: TmeTIWAdvRadioGroup;
    rgpCausaliCompAnnAddebPaghe: TmeTIWAdvRadioGroup;
    dchkRipcomInclusiSaldo: TmeIWDBCheckBox;
    rgpCausaliCompAnnSaldo: TmeTIWAdvRadioGroup;
    lblXParam: TmeIWLabel;
    dedtXParam: TmeIWDBEdit;
    WA080IterAutStrRG: TmeIWRegion;
    lblIterAutStr: TmeIWLabel;
    lblIterRichStraord: TmeIWLabel;
    dcmbIterRichStraord: TmeIWDBLookupComboBox;
    lblIterAutStrArrotEcc: TmeIWLabel;
    dedtIterAutStrArrotEcc: TmeIWDBEdit;
    lblIterAutStrCausale: TmeIWLabel;
    cmbIterAutStrCausale: TMedpIWMultiColumnComboBox;
    lblDIterAutStrCausale: TmeIWLabel;
    dchkIterAutStrArrotLiqFasce: TmeIWDBCheckBox;
    lblIterAutStrArrotLiq: TmeIWLabel;
    dedtIterAutStrArrotLiq: TmeIWDBEdit;
    lblIterAutStrMinimoLiq: TmeIWLabel;
    dedtIterAutStrMinimoLiq: TmeIWDBEdit;
    TemplateIterAutStr: TIWTemplateProcessorHTML;
    lblRecuperoDebitoPeriodicita: TmeIWLabel;
    drgpRecuperoDebitoPeriodicita: TmeIWDBRadioGroup;
    rgpGGVuotoTurnista: TmeTIWAdvRadioGroup;
    rgpCausaliCompMeseRecNeg: TmeTIWAdvRadioGroup;
    lblRiepassCompensabiliAnno: TmeIWLabel;
    dedtRiepassCompensabiliAnno: TmeIWDBEdit;
    btnRiepassCompensabiliAnno: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbCausaleRiposiCompensativiAsyncChange(Sender: TObject;EventParams: TStringList; Index: Integer; Value: string);
    procedure btnCausaliAssenzaTollerateClick(Sender: TObject);
    procedure btnMesiRiferimentoClick(Sender: TObject);
    procedure cmbAbbattimentoLiquidabileMensile111AsyncChange(Sender: TObject;EventParams: TStringList; Index: Integer; Value: string);
    procedure rgpSaldoNegativoAsyncClick(Sender: TObject;EventParams: TStringList);
    procedure dchkGestioneBancaOreAsyncClick(Sender: TObject;EventParams: TStringList);
    procedure rgpLimiteEccedenzaCompensabileAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkEsclusioneOreNormaliAsyncClick(Sender: TObject;EventParams: TStringList);
    procedure dchkRiportoResiduiAsyncClick(Sender: TObject;EventParams: TStringList);
    procedure dchkLimiteStraordAnnualeAsyncClick(Sender: TObject;EventParams: TStringList);
    procedure rgpPeriodicitaAbbattimentoAsyncClick(Sender: TObject;EventParams: TStringList);
    procedure imgInvertiSaldiAnnuiClick(Sender: TObject);
    procedure dcmbTipoConteggioChange(Sender: TObject);
    procedure rgpTipoApplicazioneEccedenzaLiquidabileClick(Sender: TObject);
    procedure rgpTipoApplicazioneEccedenzaResiduabileClick(Sender: TObject);
    procedure drgpCartellinoClick(Sender: TObject);
    procedure imgSelAnagrafeClick(Sender: TObject);
    procedure btnCausRientriObblClick(Sender: TObject);
    procedure btnRientriClick(Sender: TObject);
    procedure btnOreCausalizzateCompensabiliClick(Sender: TObject);
    procedure btnSoglieClick(Sender: TObject);
    procedure cmbParametrizzazioneStampaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnLimitiCausaliClick(Sender: TObject);
    procedure cmbIterAutStrCausaleAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure dcmbIterRichStraordChange(Sender: TObject);
  private
    WC013:TWC013FCheckListFM;
    WC015:TWC015FSelEditGridFM;
    WA080FRientriObbligatori:TWA080FRientriObbligatori;
    WA080FSoglieStraordinario:TWA080FSoglieStraordinario;
    WC007FM:TWC007FFormContainerFM;
    EdtCausaleFieldRif: String;
    procedure RientriObbligatoriResultEvent(Sender: TObject);
    procedure SoglieStraordinarioResultEvent(Sender: TObject);
    procedure ckCausaliAssenzaTollerateResult(Sender: TObject; Result:Boolean);
    procedure ckCausLimitiResult(Sender: TObject; Result:Boolean);
    procedure ckCausRiebtriObblResult(Sender: TObject; Result:Boolean);
    procedure ckOreCausalizzateCompensabiliResult(Sender: TObject; Result:Boolean);
    procedure ImpostaComponentiVisible;
    procedure resultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure MostraLimiteCausali(Mostra:Boolean);
    procedure GestioneVisibilitaIterAutStr;
  public
    { Public declarations }
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnComboBox; override;
  end;

implementation

uses WA080UTipologieCartelliniDM,WA080UTipologieCartellini,WA080USoglieStraordinarioBrowseFM,WA080USoglieStraordinarioDM,WA080URientriObbligatoriBrowseFM;

{$R *.dfm}

procedure TWA080FTipologieCartelliniDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  grdTabDetail.AggiungiTab('Recuperi',WA080RecuperiRG);
  grdTabDetail.AggiungiTab('Abbattimenti',WA080AbbattimentiRG);
  grdTabDetail.AggiungiTab('Opzioni',WA080OpzioniRG);
  grdTabDetail.AggiungiTab('Limiti eccedenze/Banca ore',WA080LimitiEccedenzeBancaOreRG);
  grdTabDetail.AggiungiTab('Iter autorizzativo straordinari',WA080IterAutStrRG);

  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA080RecuperiRG;

  inherited;

  dcmbIterRichStraord.ListSource:=TWA080FTipologieCartelliniDM(WR302DM).dsrTipiRichStraord;

  dcmbTipoConteggio.Items.Values['Standard']:='1';
  dcmbTipoConteggio.Items.Values['Gestione recuperi']:='4';

  with TWA080FTipologieCartelliniDM(WR302DM).selTabella do
  begin
    lblScostamentoSettimanale.visible:=FieldByName('CARTELLINO').AsString='S';
    dedtScostamentoSettimanale.visible:=FieldByName('CARTELLINO').AsString='S';
  end;


  dcmbSaldoRiferimento.Items.Values['Saldo mensile']:='0';
  dcmbSaldoRiferimento.Items.Values['Saldo mensile e annuale']:='1';
  dcmbSaldoRiferimento.Items.Values['Saldo annuale']:='2';

  dcmbRicalcoloIndennitaNotturna.Items.Values['Nessuno']:='0';
  dcmbRicalcoloIndennitaNotturna.Items.Values['Separazione dal liquidabile']:='1';
  dcmbRicalcoloIndennitaNotturna.Items.Values['Separazione ind.notturna']:='2';
  dcmbRicalcoloIndennitaNotturna.Items.Values['Separazione ind.festiva']:='3';

  dcmbRicalcoloIndennitaPresenza.Items.Values['Nessuno']:='0';
  dcmbRicalcoloIndennitaPresenza.Items.Values['Controllo ciclicità turni']:='1';

end;

procedure TWA080FTipologieCartelliniDettFM.MostraLimiteCausali(Mostra:Boolean);
begin
  Mostra:=True;//Sempre visibile!

  btnLimitiCausali.Css:=C190ImpostaCssInvisibile(btnLimitiCausali.Css, Mostra);
  dEdtLimitiCausali.Css:=C190ImpostaCssInvisibile(dEdtLimitiCausali.Css, Mostra);
  lblLimitiCausali.Css:=C190ImpostaCssInvisibile(lblLimitiCausali.Css, Mostra);
  C190VisualizzaElemento(JQuery,'grpLimitiCausali',Mostra);
end;

procedure TWA080FTipologieCartelliniDettFM.ImpostaComponentiVisible;
begin
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    grdTabDetail.Visible:=selTabella.FieldByName('CONTEGGIO').AsString = '4';
    if not grdTabDetail.Visible then
    begin
      WA080RecuperiRG.Visible:=false;
      WA080AbbattimentiRG.Visible:=false;
      WA080OpzioniRG.Visible:=false;
      WA080LimitiEccedenzeBancaOreRG.Visible:=false;
    end
    else
    begin
      //reimposto activeTab. serve per rendere visibile il pannello selezionato
      //se non impostato setto il primo, altrimenti imposto se stesso in modo da
      //forzare la visibilita
      if grdTabDetail.ActiveTab = nil then
        grdTabDetail.ActiveTab:=WA080RecuperiRG
      else
        grdTabDetail.ActiveTab:=grdTabDetail.ActiveTab;
    end;
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.DataSet2Componenti;
var
  i: Integer;
  LCausale: String;
begin
  inherited;

  ImpostaComponentiVisible;

  //Impostazione di partenza della list box
  if cgpSaldiAnnui.Values[0] = 'L' then
  begin
    cgpSaldiAnnui.Items.Move(1,0);
    cgpSaldiAnnui.Values.Move(1,0);
  end;

  //Lettura dei valori selezionati e ordinamento degli elementi
  if(R180CarattereDef(WR302DM.selTabella.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString,1,' ') = 'C') and (cgpSaldiAnnui.Values[0] = 'L') or
    (R180CarattereDef(WR302DM.selTabella.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString,1,' ') = 'L') and (cgpSaldiAnnui.Values[0] = 'C')
     then
  begin
    cgpSaldiAnnui.Items.Move(1,0);
    cgpSaldiAnnui.Values.Move(1,0);
  end;

  for i:=0 to cgpSaldiAnnui.Items.Count - 1 do
    if pos(cgpSaldiAnnui.Values[i], WR302DM.selTabella.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString) > 0 then
      cgpSaldiAnnui.IsChecked[i]:=true
    else
      cgpSaldiAnnui.IsChecked[i]:=false;

  if WR302DM.selTabella.FieldByName('CAUSALI_COMP_MENS_SALDO').AsString = 'M' then
    rgpCausaliCompMensSaldo.ItemIndex:=0
  else if WR302DM.selTabella.FieldByName('CAUSALI_COMP_MENS_SALDO').AsString = 'A' then
    rgpCausaliCompMensSaldo.ItemIndex:=1;

  if WR302DM.selTabella.FieldByName('CAUSALI_COMP_MESE_RECNEG').AsString = 'P' then
    rgpCausaliCompMeseRecNeg.ItemIndex:=0
  else if WR302DM.selTabella.FieldByName('CAUSALI_COMP_MESE_RECNEG').AsString = 'D' then
    rgpCausaliCompMeseRecNeg.ItemIndex:=1;

  if WR302DM.selTabella.FieldByName('CAUSALI_COMP_ANN_SALDO').AsString = 'M' then
    rgpCausaliCompAnnSaldo.ItemIndex:=0
  else if WR302DM.selTabella.FieldByName('CAUSALI_COMP_ANN_SALDO').AsString = 'A' then
    rgpCausaliCompAnnSaldo.ItemIndex:=1;

  if WR302DM.selTabella.FieldByName('CAUSALI_COMP_ANN_ADDEB_PAGHE').AsString = 'P' then
    rgpCausaliCompAnnAddebPaghe.ItemIndex:=0
  else if WR302DM.selTabella.FieldByName('CAUSALI_COMP_ANN_ADDEB_PAGHE').AsString = 'D' then
    rgpCausaliCompAnnAddebPaghe.ItemIndex:=1;

  cmbCausaleRiposiCompensativi.ItemIndex:=-1;
  cmbCausaleRiposiCompensativi.Text:=WR302DM.selTabella.FieldByName('CAUSRIPCOM_FASCE').AsString;
  lblDescCausaleRiposiCompensativi.Caption:=VarToStr(TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm.Lookup('CODICE', WR302DM.selTabella.FieldByName('CAUSRIPCOM_FASCE').AsString, 'DESCRIZIONE'));

  cmbAbbattimentoLiquidabileMensile.ItemIndex:=-1;
  cmbAbbattimentoLiquidabileMensile.Text:=WR302DM.selTabella.FieldByName('RIPOSO_NONFRUITO').AsString;
  lblDescAbbattimentoLiquidabileMensile.Caption:=VarToStr(TWA080FTipologieCartelliniDM(WR302DM).selT265.LookUp('CODICE', WR302DM.selTabella.FieldByName('RIPOSO_NONFRUITO').AsString, 'DESCRIZIONE'));

  cmbParametrizzazioneStampa.ItemIndex:=-1;
  cmbParametrizzazioneStampa.Text:=WR302DM.selTabella.FieldByName('PAR_CARTELLINO').AsString;
  lblDescParametrizzazioneStampa.Caption:=VarToStr(TWA080FTipologieCartelliniDM(WR302DM).selT950.LookUp('CODICE', WR302DM.selTabella.FieldByName('PAR_CARTELLINO').AsString, 'DESCRIZIONE'));

  cmbPARaggrLimite.ItemIndex:=-1;
  cmbPARaggrLimite.Text:=WR302DM.selTabella.FieldByName('PA_RAGGR_LIMITE').AsString;

  cmbPARaggrLimiteSaldoPrec.ItemIndex:=-1;
  cmbPARaggrLimiteSaldoPrec.Text:=WR302DM.selTabella.FieldByName('PA_RAGGR_LIMITESALDOPREC').AsString;

  cmbPARaggrLimiteSaldoAtt.ItemIndex:=-1;
  cmbPARaggrLimiteSaldoAtt.Text:=WR302DM.selTabella.FieldByName('PA_RAGGR_LIMITESALDOATT').AsString;

  if WR302DM.selTabella.FieldByName('TIPOLIMITECOMPA').AsString = 'N' then
    rgpLimiteEccedenzaCompensabile.ItemIndex:=0
  else if WR302DM.selTabella.FieldByName('TIPOLIMITECOMPA').AsString = 'M' then
    rgpLimiteEccedenzaCompensabile.ItemIndex:=1
  else if WR302DM.selTabella.FieldByName('TIPOLIMITECOMPA').AsString = 'H' then
    rgpLimiteEccedenzaCompensabile.ItemIndex:=2
  else if WR302DM.selTabella.FieldByName('TIPOLIMITECOMPA').AsString = 'C' then
    rgpLimiteEccedenzaCompensabile.ItemIndex:=3;

  if WR302DM.selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString = 'F' then
    rgpPeriodicitaAbbattimento.ItemIndex:=0
  else
    rgpPeriodicitaAbbattimento.ItemIndex:=1;

  if WR302DM.selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString = '0' then
    rgpSaldoNegativo.ItemIndex:=0
  else if WR302DM.selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString = '1' then
    rgpSaldoNegativo.ItemIndex:=1
  else//3
    rgpSaldoNegativo.ItemIndex:=2;

  if WR302DM.selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString = 'CL' then
    rgpTipoApplicazioneEccedenzaLiquidabile.ItemIndex:=0
  else if WR302DM.selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString = 'LM' then
    rgpTipoApplicazioneEccedenzaLiquidabile.ItemIndex:=1
  else//EG
    rgpTipoApplicazioneEccedenzaLiquidabile.ItemIndex:=2;

  if WR302DM.selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString = 'CL' then
    rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex:=0
  else if WR302DM.selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString = 'LL' then
    rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex:=1
  else//EG
    rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex:=2;
  MostraLimiteCausali(rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex = 2);

  if WR302DM.selTabella.FieldByName('GGVUOTO_TURNISTA').AsString = 'R' then
    rgpGGVuotoTurnista.ItemIndex:=0
  else if WR302DM.selTabella.FieldByName('GGVUOTO_TURNISTA').AsString = 'L' then
    rgpGGVuotoTurnista.ItemIndex:=1;

  // iter straordinario mensile
  GestioneVisibilitaIterAutStr;
  cmbIterAutStrCausale.ItemIndex:=-1;
  LCausale:=WR302DM.selTabella.FieldByName('ITER_AUTSTR_CAUSALE').AsString;
  cmbIterAutStrCausale.Text:=LCausale;
  lblDIterAutStrCausale.Caption:=VarToStr(TWA080FTipologieCartelliniDM(WR302DM).selT275Lookup.LookUp('CODICE',LCausale,'DESCRIZIONE'));
end;

procedure TWA080FTipologieCartelliniDettFM.GestioneVisibilitaIterAutStr;
var
  LIterAutStr: string;
  LIsStraordAnnuoCausPagComp: Boolean;
begin
  LIterAutStr:=WR302DM.selTabella.FieldByName('ITER_AUTORIZZATIVO_STR').AsString;
  LIsStraordAnnuoCausPagComp:=(LIterAutStr = TTipoRichStrRec.StraordAnnuoCausPagComp);

  // causale iter straordinari
  lblIterAutStrCausale.Visible:=LIsStraordAnnuoCausPagComp;
  cmbIterAutStrCausale.Visible:=LIsStraordAnnuoCausPagComp;
  lblDIterAutStrCausale.Visible:=LIsStraordAnnuoCausPagComp;

  // arrot. eccedenze
  lblIterAutStrArrotEcc.Visible:=not R180In(LIterAutStr,[TTipoRichStrRec.Nessuna,TTipoRichStrRec.StraordAnnuoCausPagComp]);
  dedtIterAutStrArrotEcc.Visible:=not R180In(LIterAutStr,[TTipoRichStrRec.Nessuna,TTipoRichStrRec.StraordAnnuoCausPagComp]);

  // arrot. liquidabile
  lblIterAutStrArrotLiq.Visible:=LIsStraordAnnuoCausPagComp;
  dedtIterAutStrArrotLiq.Visible:=LIsStraordAnnuoCausPagComp;

  // arrot. liquidabile sulle singole fasce
  dchkIterAutStrArrotLiqFasce.Visible:=LIsStraordAnnuoCausPagComp;

  // minimo liquidabile
  lblIterAutStrMinimoLiq.Visible:=LIsStraordAnnuoCausPagComp;
  dedtIterAutStrMinimoLiq.Visible:=LIsStraordAnnuoCausPagComp;
end;

procedure TWA080FTipologieCartelliniDettFM.AbilitaComponenti;
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    if (selTabella.State in [dsInsert, dsEdit]) then
    begin
      dedtSaldoPos.Enabled:=selTabella.FieldByName('TIPOLIMITECOMPA').AsString = 'H';

      dedtStabilitoAdOre.Enabled:=selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString = '1';
      dedtArrotondamentoRecupero.Enabled:=selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString = '2';
      lblArrotondamentoRecupero.Enabled:=selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString = '2';

      dchkEsclusioneOreNormali.Enabled:=selTabella.FieldByName('BANCAORE').AsString = 'S';
      dchkConsideraResiduiAnnoPrecedente.Enabled:=selTabella.FieldByName('BANCAORE').AsString = 'S';
      dchkEsclusioneAbbattimenti.Enabled:=(selTabella.FieldByName('BANCAORE').AsString = 'S') and (selTabella.FieldByName('BANCA_ORE_ESCLUSA_SALDI').AsString ='N');
      dchkLimiteStraordAnnuale.Enabled:=selTabella.FieldByName('BANCAORE').AsString = 'S';
      dchkAbbatteCompensabile.Enabled:=(selTabella.FieldByName('BANCAORE').AsString = 'S') and (selTabella.FieldByName('BANCA_ORE_ESCLUSA_SALDI').AsString ='N');
      dchkRiportoResidui.Enabled:=selTabella.FieldByName('BANCAORE').AsString = 'S';
      dchkLimiteSaldoComplessivo.Enabled:=(selTabella.FieldByName('BANCAORE').AsString = 'S') and (selTabella.FieldByName('BANCA_ORE_ESCLUSA_SALDI').AsString ='N');
      dchkLimiteStraordAnnuale.Enabled:=selTabella.FieldByName('BANCAORE').AsString = 'S';
      drgpControllaFaseLiquidazione.Enabled:=(selTabella.FieldByName('BANCAORE').AsString = 'S') and (selTabella.FieldByName('BANCA_ORE_LIMITATA_STR_LIQ').AsString = 'S');
      dedtArrotondamentoMensile.Enabled:=selTabella.FieldByName('BANCAORE').AsString = 'S';
      lblArrotondamentoMensile.Enabled:=selTabella.FieldByName('BANCAORE').AsString = 'S';

      dchkEsclusioneAbbattimenti.Enabled:=(selTabella.FieldByName('BANCA_ORE_ESCLUSA_SALDI').AsString = 'N') and (selTabella.FieldByName('BANCAORE').AsString = 'S');
      dchkAbbatteCompensabile.Enabled:=(selTabella.FieldByName('BANCA_ORE_ESCLUSA_SALDI').AsString = 'N') and (selTabella.FieldByName('BANCAORE').AsString = 'S');
      dchkLimiteSaldoComplessivo.Enabled:=(selTabella.FieldByName('BANCA_ORE_ESCLUSA_SALDI').AsString = 'N') and (selTabella.FieldByName('BANCAORE').AsString = 'S');

      dchkConsideraResiduiAnnoPrecedente.Enabled:=selTabella.FieldByName('BANCAORE_RESID').AsString = 'S';
      drgpControllaFaseLiquidazione.Enabled:=(selTabella.FieldByName('BANCAORE').AsString = 'S') and (selTabella.FieldByName('BANCA_ORE_LIMITATA_STR_LIQ').AsString = 'S');

      dedtSaldoPos.Enabled:=selTabella.FieldByName('TIPOLIMITECOMPA').AsString = 'H';
      dchkAbbattimentoEcced.Enabled:=selTabella.FieldByName('TIPOLIMITECOMPA').AsString = 'H';
      dchkSaldoMeseLordo.Enabled:=(selTabella.FieldByName('TIPOLIMITECOMPA').AsString ='M') or (selTabella.FieldByName('TIPOLIMITECOMPA').AsString ='C');

      if not dchkSaldoMeseLordo.Enabled then
        selTabella.FieldByName(dchkSaldoMeseLordo.DataField).AsString:='N';

      dedtAbbattimentoMassimo.Enabled:=selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString = 'M' ;
      lblAbbattimentoMassimo.Enabled:=selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString = 'M' ;
      cgpSaldiAnnui.Enabled:=selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString = 'M' ;
      lblSaldiAnnui.Enabled:=selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString = 'M' ;
      imgInvertiSaldiAnnui.Enabled:=selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString = 'M' ;
      dcmbSaldoRiferimento.Enabled:=selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString = 'M' ;
      lblSaldoRiferimento.Enabled:=selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString = 'M' ;
      dchkRecuperaNegativo.Enabled:=selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString = 'F' ;

      dedtStabilitoAdOre.Enabled:=selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString = '1';
      dedtArrotondamentoRecupero.Enabled:=selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString = '2';
      lblArrotondamentoRecupero.Enabled:=selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString = '2';
    end;
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.Componenti2DataSet;
var
  i : Integer;
begin
  inherited;

  WR302DM.selTabella.FieldByName('CAUSRIPCOM_FASCE').AsString:=cmbCausaleRiposiCompensativi.Text;
  WR302DM.selTabella.FieldByName('RIPOSO_NONFRUITO').AsString:=cmbAbbattimentoLiquidabileMensile.Text;
  WR302DM.selTabella.FieldByName('PAR_CARTELLINO').AsString:=cmbParametrizzazioneStampa.Text;
  WR302DM.selTabella.FieldByName('PA_RAGGR_LIMITE').AsString:=cmbPARaggrLimite.Text;
  WR302DM.selTabella.FieldByName('PA_RAGGR_LIMITESALDOPREC').AsString:=cmbPARaggrLimiteSaldoPrec.Text;
  WR302DM.selTabella.FieldByName('PA_RAGGR_LIMITESALDOATT').AsString:=cmbPARaggrLimiteSaldoAtt.Text;

  WR302DM.selTabella.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString:='';
  if cgpSaldiAnnui.enabled then
  begin
    for i:=0 to cgpSaldiAnnui.Items.Count - 1 do
      if cgpSaldiAnnui.IsChecked[i] then
        WR302DM.selTabella.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString:=WR302DM.selTabella.FieldByName('ABBATTIMENTO_MOBILE_SALDI').AsString + cgpSaldiAnnui.Values[i];
  end;

  case rgpCausaliCompMensSaldo.ItemIndex of
    0: WR302DM.selTabella.FieldByName('CAUSALI_COMP_MENS_SALDO').AsString:='M';
    1: WR302DM.selTabella.FieldByName('CAUSALI_COMP_MENS_SALDO').AsString:='A';
  end;

  case rgpCausaliCompMeseRecNeg.ItemIndex of
    0: WR302DM.selTabella.FieldByName('CAUSALI_COMP_MESE_RECNEG').AsString:='P';
    1: WR302DM.selTabella.FieldByName('CAUSALI_COMP_MESE_RECNEG').AsString:='D';
  end;

  case rgpCausaliCompAnnSaldo.ItemIndex of
    0: WR302DM.selTabella.FieldByName('CAUSALI_COMP_ANN_SALDO').AsString:='M';
    1: WR302DM.selTabella.FieldByName('CAUSALI_COMP_ANN_SALDO').AsString:='A';
  end;

  case rgpCausaliCompAnnAddebPaghe.ItemIndex of
    0: WR302DM.selTabella.FieldByName('CAUSALI_COMP_ANN_ADDEB_PAGHE').AsString:='P';
    1: WR302DM.selTabella.FieldByName('CAUSALI_COMP_ANN_ADDEB_PAGHE').AsString:='D';
  end;

  //Rgp della TMS non funzionano con i Values...
  case rgpLimiteEccedenzaCompensabile.ItemIndex of
    0: WR302DM.selTabella.FieldByName('TIPOLIMITECOMPA').AsString:='N';
    1: WR302DM.selTabella.FieldByName('TIPOLIMITECOMPA').AsString:='M';
    2: WR302DM.selTabella.FieldByName('TIPOLIMITECOMPA').AsString:='H';
    3: WR302DM.selTabella.FieldByName('TIPOLIMITECOMPA').AsString:='C';
  end;

  case rgpPeriodicitaAbbattimento.ItemIndex of
    0: WR302DM.selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString:='F';
    1: WR302DM.selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString:='M';
  end;

  WR302DM.selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString:= IntToStr(rgpSaldoNegativo.ItemIndex);

  case rgpTipoApplicazioneEccedenzaLiquidabile.ItemIndex of
    0: WR302DM.selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString:='CL';
    1: WR302DM.selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString:='LM';
    2: WR302DM.selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString:='EG';
  end;

  case rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex of
    0: WR302DM.selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString:='CL';
    1: WR302DM.selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString:='LL';
    2: WR302DM.selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString:='EG';
  end;

  case rgpGGVuotoTurnista.ItemIndex of
    0: WR302DM.selTabella.FieldByName('GGVUOTO_TURNISTA').AsString:='R';
    1: WR302DM.selTabella.FieldByName('GGVUOTO_TURNISTA').AsString:='L';
  end;

  // iter straordinario mensile
  WR302DM.selTabella.FieldByName('ITER_AUTSTR_CAUSALE').AsString:=cmbIterAutStrCausale.Text;
end;

procedure TWA080FTipologieCartelliniDettFM.btnMesiRiferimentoClick(
  Sender: TObject);
begin
  inherited;
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  TWA080FTipologieCartelliniDM(WR302DM).Q026.Close;
  TWA080FTipologieCartelliniDM(WR302DM).Q026.SetVariable('Codice',TWA080FTipologieCartelliniDM(WR302DM).selTabella.FieldByName('Codice').AsString);
  TWA080FTipologieCartelliniDM(WR302DM).Q026.Open;
  WC015.Visualizza('Abbattimento saldi',TWA080FTipologieCartelliniDM(WR302DM).Q026);
end;

procedure TWA080FTipologieCartelliniDettFM.btnOreCausalizzateCompensabiliClick(Sender: TObject);
var F,Titolo:String;
begin
 inherited;
  EdtCausaleFieldRif:='';
  if Sender = btnCausaliCompensabiliMensili then
  begin
    F:=dedtCausaliCompensabiliMensili.Text;
    EdtCausaleFieldRif:=dedtCausaliCompensabiliMensili.DataField;
    Titolo:=lblCausaliCompensabiliMensili.Caption;
  end
  else if Sender = btnOreCausalizzateCompensabili then
  begin
    F:=dedtOreCausalizzateCompensabili.Text;
    EdtCausaleFieldRif:=dedtOreCausalizzateCompensabili.DataField;
    Titolo:=lblOreCausalizzateCompensabili.Caption;
  end
  else if Sender = btnRiepassCompensabiliAnno then
  begin
    F:=dedtRiepassCompensabiliAnno.Text;
    EdtCausaleFieldRif:=dedtRiepassCompensabiliAnno.DataField;
    Titolo:=lblRiepassCompensabiliAnno.Caption;
  end;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    if R180In(Sender,[btnCausaliCompensabiliMensili,btnOreCausalizzateCompensabili]) then
    begin
      TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm.Close;
      TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm.Open;
      while not TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm.Eof do
      begin
        ckList.Items.Add(Format('%-5s %s',[TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm.FieldByName('CODICE').AsString,TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm.FieldByName('DESCRIZIONE').AsString]));
        ckList.Values.Add(Trim(TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm.FieldByName('CODICE').AsString));
        TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm.Next;
      end;
    end
    else if R180In(Sender,[btnRiepassCompensabiliAnno]) then
    begin
      TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Close;
      TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Open;
      while not TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Eof do
      begin
        if TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('UMISURA').AsString = 'O' then
        begin
          ckList.Items.Add(Format('%-5s %s',[TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('CODICE').AsString,TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('DESCRIZIONE').AsString]));
          ckList.Values.Add(Trim(TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('CODICE').AsString));
        end;
        TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Next;
      end;
    end;
    ResultEvent:=ckOreCausalizzateCompensabiliResult;
    C190PutCheckList(F,5,ckList);
    WC013.Visualizza(0,0,Titolo);
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.ckOreCausalizzateCompensabiliResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(EdtCausaleFieldRif).AsString:=C190GetCheckList(5,WC013.ckList);
end;

procedure TWA080FTipologieCartelliniDettFM.btnRientriClick(Sender: TObject);
//var WA080Storico:TWA080FGestStorico;
begin
  inherited;
  WA080FRientriObbligatori:=TWA080FRientriObbligatori.Create(TWA080FTipologieCartellini(Self.Owner).Owner,False);
  TWA080FRientriObbligatoriBrowseFM(WA080FRientriObbligatori.WBrowseFM).PutTipoCartellino(TWA080FTipologieCartelliniDM(WR302DM).SelTabella.FieldByName('CODICE').AsString);
  WC007FM:=TWC007FFormContainerFM.Create(Self.Parent);
  WC007FM.TemplateProcessor.Templates.Default:='WA080FRientriObbligatoriFM.html';
  WC007FM.ResultEvent:=RientriObbligatoriResultEvent;
  WA080FRientriObbligatori.grdNavigatorBar.Parent:=WC007FM.IWFrameRegion;
  WA080FRientriObbligatori.grdToolBarStorico.Parent:=WC007FM.IWFrameRegion;
  WA080FRientriObbligatori.WBrowseFM.Parent:=WC007FM.IWFrameRegion;
  WC007FM.Visualizza('Gestione Rientri Obbligatori');
end;

procedure TWA080FTipologieCartelliniDettFM.btnSoglieClick(Sender: TObject);
begin
  inherited;
  WA080FSoglieStraordinario:=TWA080FSoglieStraordinario.Create(TWA080FTipologieCartellini(Self.Owner).Owner,False);
  TWA080FSoglieStraordinarioBrowseFM(WA080FSoglieStraordinario.WBrowseFM).PutTipoCartellino(TWA080FTipologieCartelliniDM(WR302DM).SelTabella.FieldByName('CODICE').AsString);
  WC007FM:=TWC007FFormContainerFM.Create(Self.Parent);
  WC007FM.TemplateProcessor.Templates.Default:='WA080FSoglieStraordinarioFM.html';
  WC007FM.ResultEvent:=SoglieStraordinarioResultEvent;
  WC007FM.popupWidth:=880;
  WC007FM.popupHeigth:=560;
  WA080FSoglieStraordinario.grdNavigatorBar.Parent:=WC007FM.IWFrameRegion;
  WA080FSoglieStraordinario.grdToolBarStorico.Parent:=WC007FM.IWFrameRegion;
  WA080FSoglieStraordinario.WBrowseFM.Parent:=WC007FM.IWFrameRegion;
  WA080FSoglieStraordinario.WA080FSoglieStraordinarioOutputFM.Parent:=WC007FM.IWFrameRegion;
  WA080FSoglieStraordinario.WA080FSoglieStraordinarioOutputFM.grdDetailNavBar.Parent:=WC007FM.IWFrameRegion;
  WA080FSoglieStraordinario.grdC700.Parent:=WC007FM.IWFrameRegion;
  WA080FSoglieStraordinario.grdC700.WC700FM.Parent:=TWA080FTipologieCartellini(Self.Owner);
  WC007FM.Visualizza('Gestione Soglie delle eccedenze');
end;

procedure TWA080FTipologieCartelliniDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbCausaleRiposiCompensativi.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;

  with TWA080FTipologieCartelliniDM(WR302DM).selT265 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbAbbattimentoLiquidabileMensile.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;

  with TWA080FTipologieCartelliniDM(WR302DM).selT950 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbParametrizzazioneStampa.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;

  with TWA080FTipologieCartelliniDM(WR302DM).selT260 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbPARaggrLimite.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbPARaggrLimiteSaldoAtt.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbPARaggrLimiteSaldoPrec.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;

  // iter straordinario mensile
  // combobox causali di presenza
  C190CaricaMepdMulticolumnComboBox(cmbIterAutStrCausale,TWA080FTipologieCartelliniDM(WR302DM).selT275Lookup);
end;

procedure TWA080FTipologieCartelliniDettFM.ckCausaliAssenzaTollerateResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtCausaliAssenzaTollerate.DataField).AsString:=C190GetCheckList(5,WC013.ckList);
end;

procedure TWA080FTipologieCartelliniDettFM.ckCausLimitiResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName('LIMITE_MM_ECCRES_CAUSALI').AsString:=C190GetCheckList(5,WC013.ckList);
end;

procedure TWA080FTipologieCartelliniDettFM.ckCausRiebtriObblResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtCausRientriObbl.DataField).AsString:=C190GetCheckList(5,WC013.ckList);
end;

procedure TWA080FTipologieCartelliniDettFM.cmbAbbattimentoLiquidabileMensile111AsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('RIPOSO_NONFRUITO').AsString:=cmbAbbattimentoLiquidabileMensile.Text;
      lblDescAbbattimentoLiquidabileMensile.Caption:=VarToStr(TWA080FTipologieCartelliniDM(WR302DM).selT265.LookUp('CODICE', TWA080FTipologieCartelliniDM(WR302DM).selTabella.FieldByName('RIPOSO_NONFRUITO').AsString, 'DESCRIZIONE'));
    end
    else
    begin
      selTabella.FieldByName('RIPOSO_NONFRUITO').AsString:='';
      lblDescAbbattimentoLiquidabileMensile.Caption:='';
    end;
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.cmbCausaleRiposiCompensativiAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('CAUSRIPCOM_FASCE').AsString:=cmbCausaleRiposiCompensativi.Text;
      lblDescCausaleRiposiCompensativi.Caption:=VarToStr(TWA080FTipologieCartelliniDM(WR302DM).selT275EsclNorm.LookUp('CODICE', TWA080FTipologieCartelliniDM(WR302DM).selTabella.FieldByName('CAUSRIPCOM_FASCE').AsString, 'DESCRIZIONE'));
    end
    else
    begin
      selTabella.FieldByName('CAUSRIPCOM_FASCE').AsString:='';
      lblDescCausaleRiposiCompensativi.Caption:='';
    end;
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.cmbIterAutStrCausaleAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  LCausale: String;
begin
  if Index <> -1 then
  begin
    LCausale:=cmbIterAutStrCausale.Text;
    WR302DM.selTabella.FieldByName('ITER_AUTSTR_CAUSALE').AsString:=LCausale;
    lblDIterAutStrCausale.Caption:=VarToStr(TWA080FTipologieCartelliniDM(WR302DM).selT275Lookup.Lookup('CODICE', LCausale, 'DESCRIZIONE'));
  end
  else
  begin
    WR302DM.selTabella.FieldByName('ITER_AUTSTR_CAUSALE').AsString:='';
    lblDIterAutStrCausale.Caption:='';
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.cmbParametrizzazioneStampaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('PAR_CARTELLINO').AsString:=cmbParametrizzazioneStampa.Text;
      lblDescParametrizzazioneStampa.Caption:=VarToStr(selT950.LookUp('CODICE', selTabella.FieldByName('PAR_CARTELLINO').AsString, 'DESCRIZIONE'));
    end
    else
    begin
      selTabella.FieldByName('PAR_CARTELLINO').AsString:='';
      lblDescParametrizzazioneStampa.Caption:='';
    end;
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.dchkEsclusioneOreNormaliAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  abilitaComponenti;
end;

procedure TWA080FTipologieCartelliniDettFM.dchkGestioneBancaOreAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  abilitaComponenti;
end;

procedure TWA080FTipologieCartelliniDettFM.dchkLimiteStraordAnnualeAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  abilitaComponenti;
end;

procedure TWA080FTipologieCartelliniDettFM.dchkRiportoResiduiAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  abilitaComponenti;
end;

procedure TWA080FTipologieCartelliniDettFM.dcmbIterRichStraordChange(Sender: TObject);
begin
  GestioneVisibilitaIterAutStr;
end;

procedure TWA080FTipologieCartelliniDettFM.dcmbTipoConteggioChange(Sender: TObject);
begin
  inherited;
  ImpostaComponentiVisible;
  if grdTabDetail.Visible then
    grdTabDetail.ActiveTab:=WA080RecuperiRG;
end;

procedure TWA080FTipologieCartelliniDettFM.drgpCartellinoClick(Sender: TObject);
begin
  lblScostamentoSettimanale.visible:=drgpCartellino.ItemIndex=1;
  dedtScostamentoSettimanale.visible:=drgpCartellino.ItemIndex=1;
end;

procedure TWA080FTipologieCartelliniDettFM.btnCausaliAssenzaTollerateClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Open;
    while not TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Eof do
    begin
      ckList.Items.Add(Format('%-5s %s',[TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('CODICE').AsString,TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('DESCRIZIONE').AsString]));
      ckList.Values.Add(Trim(TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('CODICE').AsString));
      TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Next;
    end;
    TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Close;
    ResultEvent:=ckCausaliAssenzaTollerateResult;
    C190PutCheckList(dedtCausaliAssenzaTollerate.Text,30,ckList);
    WC013.Visualizza(0,0,lblCausaliAssenzaTollerate.Caption);
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.btnCausRientriObblClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Open;
    while not TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Eof do
    begin
      ckList.Items.Add(Format('%-5s %s',[TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('CODICE').AsString,TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('DESCRIZIONE').AsString]));
      ckList.Values.Add(Trim(TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.FieldByName('CODICE').AsString));
      TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Next;
    end;
    TWA080FTipologieCartelliniDM(WR302DM).selT265RNF.Close;
    ResultEvent:=ckCausRiebtriObblResult;
    C190PutCheckList(dedtCausRientriObbl.Text,30,ckList);
    WC013.Visualizza(0,0,lblCausRientriObbl.Caption);
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.btnLimitiCausaliClick(
  Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    TWA080FTipologieCartelliniDM(WR302DM).selT275LimiteCaus.Open;
    while not TWA080FTipologieCartelliniDM(WR302DM).selT275LimiteCaus.Eof do
    begin
      ckList.Items.Add(Format('%-5s %s',[TWA080FTipologieCartelliniDM(WR302DM).selT275LimiteCaus.FieldByName('CODICE').AsString,
                                         TWA080FTipologieCartelliniDM(WR302DM).selT275LimiteCaus.FieldByName('DESCRIZIONE').AsString]));
      ckList.Values.Add(Trim(TWA080FTipologieCartelliniDM(WR302DM).selT275LimiteCaus.FieldByName('CODICE').AsString));
      TWA080FTipologieCartelliniDM(WR302DM).selT275LimiteCaus.Next;
    end;
    TWA080FTipologieCartelliniDM(WR302DM).selT275LimiteCaus.Close;
    ResultEvent:=ckCausLimitiResult;
    C190PutCheckList(dEdtLimitiCausali.Text,5,ckList);
    WC013.Visualizza(0,0,lblLimitiCausali.Caption);
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.imgSelAnagrafeClick(Sender: TObject);
begin
  with TWA080FTipologieCartelliniDM(WR302DM).selTabella do
  begin
  if State in [dsEdit,dsInsert] then
    with TWA080FTipologieCartellini(Self.Owner).grdC700 do
    begin
      WC700FM.ResultEvent:=resultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.resultSelAnagrafe(Sender: TObject; Result: Boolean);
  function TrasformaV430(X:String):String;
    var Apice:Boolean;
        i:Integer;
    begin
      Result:='';
      i:=1;
      Apice:=False;
      while i <= Length(X) do
      begin
        if X[i] = '''' then
          Apice:=not Apice;
        if (not Apice) and (Copy(X,i,5) = 'V430.') then
        begin
          X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
          inc(i,5);
        end;
        inc(i);
      end;
      Result:=EliminaRitornoACapo(Trim(X));
    end;
var S:string;
begin
  if result then
  begin
    S:=Trim(TWA080FTipologieCartellini(Self.Owner).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    TWA080FTipologieCartelliniDM(WR302DM).selTabella.FieldByName('RNF_FILTRO').AsString:=TrasformaV430(S);
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.imgInvertiSaldiAnnuiClick(
  Sender: TObject);
var
  Index0Checked:Boolean;
begin
  inherited;
  Index0Checked:=cgpSaldiAnnui.IsChecked[0];
  cgpSaldiAnnui.Items.Move(1,0);
  cgpSaldiAnnui.Values.Move(1,0);
  cgpSaldiAnnui.IsChecked[0]:=cgpSaldiAnnui.IsChecked[1];
  cgpSaldiAnnui.IsChecked[1]:=Index0Checked;
end;

procedure TWA080FTipologieCartelliniDettFM.rgpLimiteEccedenzaCompensabileAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    if rgpLimiteEccedenzaCompensabile.ItemIndex = 0 then
      selTabella.FieldByName('TIPOLIMITECOMPA').AsString:='N'
    else if rgpLimiteEccedenzaCompensabile.ItemIndex = 1 then
      selTabella.FieldByName('TIPOLIMITECOMPA').AsString:='M'
    else if rgpLimiteEccedenzaCompensabile.ItemIndex = 2 then
      selTabella.FieldByName('TIPOLIMITECOMPA').AsString:= 'H'
    else if rgpLimiteEccedenzaCompensabile.ItemIndex = 3 then
      selTabella.FieldByName('TIPOLIMITECOMPA').AsString:='C';
  end;
  abilitaComponenti;
end;

procedure TWA080FTipologieCartelliniDettFM.rgpPeriodicitaAbbattimentoAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    if rgpPeriodicitaAbbattimento.ItemIndex = 0 then
      selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString:='F'
    else if rgpPeriodicitaAbbattimento.ItemIndex = 1 then
      selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString:= 'M';
  end;
  abilitaComponenti;
end;

procedure TWA080FTipologieCartelliniDettFM.rgpSaldoNegativoAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    if rgpSaldoNegativo.ItemIndex = 0 then
      selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString:='0'
    else if rgpSaldoNegativo.ItemIndex = 1 then
      selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString:='1'
    else
      selTabella.FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString:='2';
  end;

  abilitaComponenti;
end;

procedure TWA080FTipologieCartelliniDettFM.rgpTipoApplicazioneEccedenzaLiquidabileClick(
  Sender: TObject);
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    if rgpTipoApplicazioneEccedenzaLiquidabile.ItemIndex = 0 then
      selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString:='CL'
    else if rgpTipoApplicazioneEccedenzaLiquidabile.ItemIndex = 1 then
      selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString:='LM'
    else if rgpTipoApplicazioneEccedenzaLiquidabile.ItemIndex = 2 then
      selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString:='EG';

    if rgpTipoApplicazioneEccedenzaLiquidabile.ItemIndex = 2 then
    begin
      selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString:='EG';
      rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex:=2;
      MostraLimiteCausali(True);
    end;
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.rgpTipoApplicazioneEccedenzaResiduabileClick(
  Sender: TObject);
begin
  inherited;
  with TWA080FTipologieCartelliniDM(WR302DM) do
  begin
    if rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex = 0 then
      selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString:='CL'
    else if rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex = 1 then
      selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString:='LL'
    else if rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex = 2 then
      selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString:='EG';

    if rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex = 2 then
    begin
      selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString:='EG';
      rgpTipoApplicazioneEccedenzaLiquidabile.ItemIndex:=2;
    end;
    MostraLimiteCausali(rgpTipoApplicazioneEccedenzaResiduabile.ItemIndex = 2);
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.RientriObbligatoriResultEvent(Sender: TObject);
begin
  if WA080FRientriObbligatori <> nil then
  begin
    WA080FRientriObbligatori.grdNavigatorBar.Parent:=WA080FRientriObbligatori;
    WA080FRientriObbligatori.grdToolBarStorico.Parent:=WA080FRientriObbligatori;
    WA080FRientriObbligatori.WBrowseFM.Parent:=WA080FRientriObbligatori;
    FreeAndNil(WA080FRientriObbligatori);
  end;
end;

procedure TWA080FTipologieCartelliniDettFM.SoglieStraordinarioResultEvent(Sender: TObject);
begin
  if WA080FSoglieStraordinario <> nil then
  begin
    WA080FSoglieStraordinario.grdNavigatorBar.Parent:=WA080FSoglieStraordinario;
    WA080FSoglieStraordinario.grdTabControl.Parent:=WA080FSoglieStraordinario;
    WA080FSoglieStraordinario.grdToolBarStorico.Parent:=WA080FSoglieStraordinario;
    WA080FSoglieStraordinario.WA080FSoglieStraordinarioOutputFM.Parent:=WA080FSoglieStraordinario;
    WA080FSoglieStraordinario.WA080FSoglieStraordinarioOutputFM.grdDetailNavBar.Parent:=WA080FSoglieStraordinario;
    WA080FSoglieStraordinario.WBrowseFM.Parent:=WA080FSoglieStraordinario;
    WA080FSoglieStraordinario.grdC700.WC700FM.Parent:=WA080FSoglieStraordinario;
    FreeAndNil(WA080FSoglieStraordinario);
  end;
end;

end.