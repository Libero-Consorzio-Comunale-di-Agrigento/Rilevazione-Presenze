unit WA110UParametriConteggioDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompEdit,
  medpIWMultiColumnComboBox, WA110UParametriConteggioDM, IWDBStdCtrls,
  meIWDBLabel, C190FunzioniGeneraliWeb, meIWDBEdit, IWCompCheckbox,
  meIWDBCheckBox, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, meIWRadioGroup, DB,
  meIWRegion, IWCompGrids, meIWGrid, medpIWTabControl, IWDBGrids, meIWDBGrid,
  medpIWDBGrid, WR102UGestTabella, IWCompButton, meIWButton, WC013UCheckListFM,
  C180FunzioniGenerali,
  IWHTMLControls, meIWLink, IWCompListbox, meIWDBLookupComboBox, meIWEdit;

type
  TWA110FParametriConteggioDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    cmbCodice: TMedpIWMultiColumnComboBox;
    dlblDescCodice: TmeIWDBLabel;
    lblTipoMissione: TmeIWLabel;
    cmbTipoMissione: TMedpIWMultiColumnComboBox;
    dlblDescTipoMissione: TmeIWDBLabel;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    dChkTabTariff: TmeIWDBCheckBox;
    lblArrotondamentoOre: TmeIWLabel;
    dedtArrotondamentoOre: TmeIWDBEdit;
    lblValore: TmeIWLabel;
    dRgpTipoArrotondamento: TmeIWDBRadioGroup;
    lblTipo: TmeIWLabel;
    cmbArrTotaleImportiPerDatiPaghe: TMedpIWMultiColumnComboBox;
    dLblArrTotaleImportiPerDatiPaghe: TmeIWDBLabel;
    lblNMaxRimb: TmeIWLabel;
    DEdtNMaxRimb: TmeIWDBEdit;
    cmbArrTariffaDopoRiduzione: TMedpIWMultiColumnComboBox;
    dLblTariffaDopoRiduzione: TmeIWDBLabel;
    lblGiustificazioneAutomatica: TmeIWLabel;
    rgpCausali: TmeIWRadioGroup;
    lblTipoCausale: TmeIWLabel;
    cmbCausale: TMedpIWMultiColumnComboBox;
    lblCausale: TmeIWLabel;
    dLblCalcCausale: TmeIWDBLabel;
    dchkGiustifCopreDebitoGg: TmeIWDBCheckBox;
    lblGiustifOreMaxGg: TmeIWLabel;
    dedtGiustifOreMaxGg: TmeIWDBEdit;
    lblIndennitaTrasfertaIntera: TmeIWLabel;
    lblTariffaIndennita: TmeIWLabel;
    dedtTariffaIntera: TmeIWDBEdit;
    lblOreMinimePerIndennita: TmeIWLabel;
    dedtOreMinimePerIndennita: TmeIWDBEdit;
    drgpTipoIndennita: TmeIWDBRadioGroup;
    lblTipoIndennita: TmeIWLabel;
    WA110IndennitaOrarieRG: TmeIWRegion;
    dChkRiduzioneRimbPasto: TmeIWDBCheckBox;
    TemplateIndennitaOrarieRG: TIWTemplateProcessorHTML;
    grdTabDetail: TmedpIWTabControl;
    LblPercdiRetrRimbPasto: TmeIWLabel;
    dedtPercdiRetrRimbPasto: TmeIWDBEdit;
    LblLimiteOreRetribuiteIntere: TmeIWLabel;
    dedtLimiteOreRetribuiteIntere: TmeIWDBEdit;
    LblPercDiRetrDopoIlSuperOre: TmeIWLabel;
    dedtPercdiRetrDopoIlSuperoOre: TmeIWDBEdit;
    lblNMaxGgInteriNelMese: TmeIWLabel;
    dedtNMaxGgRetrInteriNelMese: TmeIWDBEdit;
    LblPercDiRetrDopoIlSuperoGg: TmeIWLabel;
    dedtPercdiretrDopoIlSuperoGG: TmeIWDBEdit;
    WA110RimborsoPastoRG: TmeIWRegion;
    TemplateRimborsoPastoRG: TIWTemplateProcessorHTML;
    WA110IndennitaKmRG: TmeIWRegion;
    TemplateIndennitaKmRG: TIWTemplateProcessorHTML;
    WA110CodiciVociPagheRG: TmeIWRegion;
    TemplateCodiciVociPagheRG: TIWTemplateProcessorHTML;
    drgrpTipoPasto: TmeIWDBRadioGroup;
    lblTipoRimborsoPasto: TmeIWLabel;
    lblImportoPastoSingolo: TmeIWLabel;
    dedtImporto: TmeIWDBEdit;
    dLblDescImpPasto: TmeIWDBLabel;
    lblSogliaMaturazionePranzo: TmeIWLabel;
    dedtNumeroOre: TmeIWDBEdit;
    LblSogliaCena: TmeIWLabel;
    dedtNumeroOre2: TmeIWDBEdit;
    grdScaglioni: TmedpIWDBGrid;
    lblScaglioni: TmeIWLabel;
    dEdtIndennita: TmeIWDBEdit;
    btnListaCodiciIndennita: TmeIWButton;
    dEdtRimborsi: TmeIWDBEdit;
    btnListaCodiciRimborsi: TmeIWButton;
    lblIndennitaIntera: TmeIWLabel;
    dEdtCodPagheIndIntera: TmeIWDBEdit;
    lblRiduzione: TmeIWLabel;
    dEdtCodPagheSupHH: TmeIWDBEdit;
    lblIndennitaRid: TmeIWLabel;
    dEdtCodPagheSupGG: TmeIWDBEdit;
    lblIndennitaRidhh: TmeIWLabel;
    dEdtCodPagheSupHHGG: TmeIWDBEdit;
    dRgpDataRif: TmeIWDBRadioGroup;
    lblCompetenzaPaghe: TmeIWLabel;
    LnkArrTotaleImportiPerDatiPaghe: TmeIWLink;
    lnkTariffaDopoRiduzione: TmeIWLink;
    lnkIndennitaKM: TmeIWLink;
    lnkRimborsi: TmeIWLink;
    dchkRimbKmAuto: TmeIWDBCheckBox;
    lblIndKmAuto: TmeIWLabel;
    dlblIndKmAuto: TmeIWDBLabel;
    lblRimbKmAutoMinimo: TmeIWLabel;
    dedtRimbKmAutoMinimo: TmeIWDBEdit;
    lblRimbKmAutoMinimoKm: TmeIWLabel;
    dcmbIndKmAuto: TmeIWDBLookupComboBox;
    procedure cmbCodiceAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbTipoMissioneAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbArrTotaleImportiPerDatiPagheAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbArrTariffaDopoRiduzioneAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure rgpCausaliAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdScaglioniRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnListaCodiciIndennitaClick(Sender: TObject);
    procedure btnListaCodiciRimborsiClick(Sender: TObject);
    procedure drgrpTipoPastoClick(Sender: TObject);
    procedure drgpTipoIndennitaClick(Sender: TObject);
    procedure dChkTabTariffAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure dChkRiduzioneRimbPastoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure LnkArrTotaleImportiPerDatiPagheClick(Sender: TObject);
    procedure lnkTariffaDopoRiduzioneClick(Sender: TObject);
    procedure lnkIndennitaKMClick(Sender: TObject);
    procedure lnkRimborsiClick(Sender: TObject);
    procedure dcmbIndKmAutoAsyncChange(Sender: TObject;
      EventParams: TStringList);
  private
    WC013: TWC013FCheckListFM;
    procedure IndennitaKMResult(Sender: TObject; Result: Boolean);
    procedure RimborsiResult(Sender: TObject; Result: Boolean);
  public
    procedure CaricaCmbArr;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaComponenti; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure AggiornaTipiMissione;
  end;

implementation
uses WA110UParametriConteggio;
{$R *.dfm}

{ TWA110FParametriConteggioDettFM }

procedure TWA110FParametriConteggioDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  //Non usare la variabile WR302DM del frame perchè prima di inherited non ancora valorizzata.
  //Non spostare dopo inherited perchè richiama Dataset2Componenti e deve già essere stato eseguito medpAttivaGrid
  with ((Self.Owner as TWR102FGestTabella).WR302DM as TWA110FParametriConteggioDM) do
  begin
    dLblDescImpPasto.DataSource:=A110FParametriConteggioMW.DsrP030;
    grdScaglioni.medpAttivaGrid(A110FParametriConteggioMW.selM013,False,False,False);
    // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
    // imposta gli item di selezione per il codice di indennità km
    dcmbIndKmAuto.ListSource:=A110FParametriConteggioMW.dsrM021RimbAuto;
    // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
  end;
  inherited;
  grdTabDetail.AggiungiTab('Indennità orarie',WA110IndennitaOrarieRG);
  grdTabDetail.AggiungiTab('Rimborso pasto',WA110RimborsoPastoRG);
  grdTabDetail.AggiungiTab('Indennità Km e Rimborsi abilitati',WA110IndennitaKmRG);
  grdTabDetail.AggiungiTab('Codici voci paghe',WA110CodiciVociPagheRG);

  grdTabDetail.ActiveTab:=WA110IndennitaOrarieRG;
end;

procedure TWA110FParametriConteggioDettFM.DataSet2Componenti;
begin
  inherited;
  with WR302DM.selTabella do
  begin
    cmbCodice.Text:=FieldByName('CODICE').AsString;
    cmbTipoMissione.Text:=FieldByName('TIPO_MISSIONE').AsString;
    cmbArrTotaleImportiPerDatiPaghe.Text:=FieldByName('ARROTTOTIMPORTIDATIPAGHE').AsString;
    cmbArrTariffaDopoRiduzione.Text:=FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString;
    cmbCausale.Text:=FieldByName('CAUSALE_MISSIONE').AsString;

    if (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW.IsCausalePresenza then
      rgpCausali.ItemIndex:=0
    else
      rgpCausali.ItemIndex:=1;
    //imposta visibile/ invisibile dchkGiustifCopreDebitoGg in base a tipo causale
    rgpCausaliAsyncChange(nil,nil);
    grdScaglioni.medpAggiornaCDS(True);

    if RecordCount > 0 then
      (Self.Owner as TWA110FParametriConteggio).AbilitazioneTabScaglioni(R180In(FieldByName('TIPO_RIMBORSOPASTO').AsInteger,[0,1]))
    else
      (Self.Owner as TWA110FParametriConteggio).AbilitazioneTabScaglioni(False);
  end;
end;

procedure TWA110FParametriConteggioDettFM.AbilitaComponenti;
var
  optStato,
  optStatoGen: Boolean;
begin
  inherited;
  //campi non modificabili direttamente
  dEdtIndennita.ReadOnly:=True;
  dEdtRimborsi.ReadOnly:=True;

  if WR302DM.selTabella.State in [dsInsert, dsEdit] then
  begin
    grdScaglioni.Enabled:=R180In(drgrpTipoPasto.ItemIndex,[0,1]);
    //in cloud non disabilitare label
    //lblScaglioni.Enabled:=grdScaglioni.Enabled;
    (Self.Owner as TWA110FParametriConteggio).AbilitazioneTabScaglioni(R180In(drgrpTipoPasto.ItemIndex,[0,1]));
    //lblImportoPastoSingolo.Enabled:=drgrpTipoPasto.ItemIndex = 2;
    dedtImporto.Enabled:=lblImportoPastoSingolo.Enabled;
    //lblSogliaMaturazionePranzo.Enabled:=lblImportoPastoSingolo.Enabled;
    dedtNumeroOre.Enabled:=lblImportoPastoSingolo.Enabled;
    //LblSogliaCena.Enabled:=lblImportoPastoSingolo.Enabled;
    dedtNumeroOre2.Enabled:=lblImportoPastoSingolo.Enabled;

    OptStato:=True;
    if (dchkRiduzioneRimbPasto.Checked) or (dChkTabTariff.Checked) or
       ((not dChkRiduzioneRimbPasto.Checked) and (drgpTipoIndennita.ItemIndex = 1)) then
    begin
      (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW.PulisciCampiIndOr;
      OptStato:=False;
    end;
    dedtLimiteOreRetribuiteIntere.Enabled:=OptStato;
    //LblLimiteOreRetribuiteIntere.Enabled:=OptStato;
    dedtNMaxGgRetrInteriNelMese.Enabled:=OptStato;
    //lblNMaxGgInteriNelMese.Enabled:=OptStato;
    dedtPercdiRetrDopoIlSuperoOre.Enabled:=OptStato;
    //LblPercDiRetrDopoIlSuperOre.Enabled:=OptStato;
    dedtPercdiretrDopoIlSuperoGG.Enabled:=OptStato;
    //LblPercDiRetrDopoIlSuperoGg.Enabled:=OptStato;

    OptStatoGen:=Not(DChkTabTariff.Checked);
    //==================================================
    //BLOCCO RIFERITO ALL'INDENNITA' DI TRASFERTA INTERA
    //==================================================
    //lblTariffaIndennita.Enabled:=OptStatoGen;
    //lblOreMinimePerIndennita.Enabled:=OptStatoGen;
    dEdtTariffaIntera.Enabled:=OptStatoGen;
    dedtOreMinimePerIndennita.Enabled:=OptStatoGen;
    drgpTipoIndennita.Enabled:=OptStatoGen;
    if Not(OptStatoGen) then
      (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW.PulisciCampiStatoGen;
    //==================================================
    //BLOCCO RIFERITO AI CODICI VOCE PAGHE
    //====================================
    //su web uso disabled al posto di visible. se si vuole rendere invisibile
    //aggiungere l'impostazione anche in Dataset2Componenti per visualizzare correttamente quando si scorrono i record

    dEdtCodPagheSupGG.Enabled:=OptStatoGen;
    dEdtCodPagheSupHHGG.Enabled:=OptStatoGen;
    dEdtCodPagheIndIntera.Enabled:=OptStatoGen;
    dEdtCodPagheSupHH.Enabled:=OptStatoGen;
    //lblIndennitaRid.Enabled:=OptStatoGen;
    //lblIndennitaRidhh.Enabled:=OptStatoGen;
    //lblIndennitaIntera.Enabled:=OptStatoGen;
    //lblRiduzione.Enabled:=OptStatoGen;
    //====================================
    //lblOreMinimePerIndennita.Enabled:=OptStatoGen;
    LnkTariffaDopoRiduzione.Enabled:=OptStatoGen;
    cmbArrTariffaDopoRiduzione.Enabled:=OptStatoGen;
    //dLblTariffaDopoRiduzione.Enabled:=OptStatoGen;
    //dChkRiduzioneRimbPasto.Enabled:=OptStatoGen;
    if DChkTabTariff.Checked then
      (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW.ResetRiduzionePasto;

    //LblPercdiRetrRimbPasto.Enabled:=dChkRiduzioneRimbPasto.Checked;
    dedtPercdiRetrRimbPasto.Enabled:=dChkRiduzioneRimbPasto.Checked;
  end;
end;

procedure TWA110FParametriConteggioDettFM.Componenti2DataSet;
begin
  inherited;
  //Le multicolumnCombo impostano il valore in selTabella già nell'AsyncChange
end;

procedure TWA110FParametriConteggioDettFM.dChkRiduzioneRimbPastoAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA110FParametriConteggioDettFM.dChkTabTariffAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA110FParametriConteggioDettFM.dcmbIndKmAutoAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dcmbIndKmAuto.Invalidate;
end;

procedure TWA110FParametriConteggioDettFM.drgpTipoIndennitaClick(
  Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA110FParametriConteggioDettFM.drgrpTipoPastoClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA110FParametriConteggioDettFM.grdScaglioniRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  grdScaglioni.medpRenderCell(ACell,ARow,AColumn,True,False,False);
  if (not grdScaglioni.Enabled) and (ARow = 0) then
  begin
    ACell.Css:=ACell.Css + ' lblDisabled';
  end;
end;

procedure TWA110FParametriConteggioDettFM.lnkRimborsiClick(Sender: TObject);
var Params: String;
begin
  inherited;
  //aggancio WA120
  Params:='CODICE='+ dEdtRimborsi.Text;
  (Self.Owner as TWA110FParametriConteggio).AccediForm(156,Params);
end;

procedure TWA110FParametriConteggioDettFM.LnkArrTotaleImportiPerDatiPagheClick(
  Sender: TObject);
var Params: String;
begin
  Params:='CODICE='+ cmbArrTotaleImportiPerDatiPaghe.Text;
  (Self.Owner as TWA110FParametriConteggio).AccediForm(519,Params);
end;

procedure TWA110FParametriConteggioDettFM.lnkIndennitaKMClick(Sender: TObject);
var Params: String;
begin
  //aggancio WA120
  Params:='CODICE='+ dEdtIndennita.Text;
  (Self.Owner as TWA110FParametriConteggio).AccediForm(157,Params);
end;

procedure TWA110FParametriConteggioDettFM.lnkTariffaDopoRiduzioneClick(
  Sender: TObject);
var Params: String;
begin
  Params:='CODICE='+ cmbArrTariffaDopoRiduzione.Text;
  (Self.Owner as TWA110FParametriConteggio).AccediForm(519,Params);
end;

procedure TWA110FParametriConteggioDettFM.rgpCausaliAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  with (WR302DM as TWA110FParametriConteggioDM) do
  begin
    if SelTabella.State in [dsEdit,dsInsert] then
    begin
      if rgpCausali.ItemIndex = 0 then
      begin
        C190CaricaMepdMulticolumnComboBox(cmbCausale,A110FParametriConteggioMW.selT275);
        SelTabella.FieldByName('GIUSTIF_COPRE_DEBITOGG').AsString:='N';
      end
      else
        C190CaricaMepdMulticolumnComboBox(cmbCausale,A110FParametriConteggioMW.selT265);
    end;
    dchkGiustifCopreDebitoGg.Visible:=rgpCausali.ItemIndex = 1;
  end;
end;

procedure TWA110FParametriConteggioDettFM.AggiornaTipiMissione;
begin
  with (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW do
  begin
    C190CaricaMepdMulticolumnComboBox(cmbTipoMissione,selM011);
  end;
end;

procedure TWA110FParametriConteggioDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW do
  begin
    C190CaricaMepdMulticolumnComboBox(cmbCodice,QSource);
    C190CaricaMepdMulticolumnComboBox(cmbTipoMissione,selM011);
    if (rgpCausali.ItemIndex = 0) then
      C190CaricaMepdMulticolumnComboBox(cmbCausale,selT275)
    else
      C190CaricaMepdMulticolumnComboBox(cmbCausale,selT265);
    CaricaCmbArr;
  end;
end;

//Caricamento combo partendo da Q050;
//richiamate anche al cambio di data decorrenza

procedure TWA110FParametriConteggioDettFM.btnListaCodiciIndennitaClick(
  Sender: TObject);
var
  LstCausaliSelezionate : TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with (WR302DM as TWA110FParametriConteggioDM) do
  begin
    WC013.CaricaLista(A110FParametriConteggioMW.LstDescIndennita, A110FParametriConteggioMW.LstCodIndennita);
    LstCausaliSelezionate:=TStringList.Create;
    LstCausaliSelezionate.CommaText:=SelTabella.FieldByName('CODICI_INDENNITAKM').AsString;
    WC013.ImpostaValoriSelezionati(LstCausaliSelezionate);
    FreeAndNil(LstCausaliSelezionate);
    WC013.ResultEvent:=IndennitaKMResult;
    WC013.Visualizza(0,0,'<WC013> Codici Indennita Km');
  end;
end;

procedure TWA110FParametriConteggioDettFM.btnListaCodiciRimborsiClick(
  Sender: TObject);
var
  LstCausaliSelezionate : TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with (WR302DM as TWA110FParametriConteggioDM) do
  begin
    WC013.CaricaLista(A110FParametriConteggioMW.LstDescRimborsi, A110FParametriConteggioMW.LstCodRimborsi);
    LstCausaliSelezionate:=TStringList.Create;
    LstCausaliSelezionate.CommaText:=SelTabella.FieldByName('CODICI_RIMBORSI').AsString;
    WC013.ImpostaValoriSelezionati(LstCausaliSelezionate);
    FreeAndNil(LstCausaliSelezionate);
    WC013.ResultEvent:=RimborsiResult;
    WC013.Visualizza(0,0,'<WC013> Codici Rimborsi');
  end;
end;

procedure TWA110FParametriConteggioDettFM.IndennitaKMResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    (WR302DM as TWA110FParametriConteggioDM).SelTabella.FieldByName('CODICI_INDENNITAKM').AsString:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
   // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
   // filtra dataset per indennità km automatica
   (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW.OpenselM021RimbAuto;
   // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.fine
  end;
end;

procedure TWA110FParametriConteggioDettFM.RimborsiResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
   (WR302DM as TWA110FParametriConteggioDM).SelTabella.FieldByName('CODICI_RIMBORSI').AsString:=lstTmp.CommaText;
   FreeAndNil(lstTmp);
  end;
end;

procedure TWA110FParametriConteggioDettFM.CaricaCmbArr;
var s: String;
begin
  with (WR302DM as TWA110FParametriConteggioDM).A110FParametriConteggioMW do
  begin
    selP050.First;
    cmbArrTotaleImportiPerDatiPaghe.Items.Clear;
    cmbArrTariffaDopoRiduzione.Items.Clear;
    while not selP050.Eof do
    begin
      s:=selP050.FieldByName('COD_ARROTONDAMENTO').AsString + ';' +
         selP050.FieldByName('DESCRIZIONE').AsString  + ';' +
         selP050.FieldByName('VALORE').AsString;
      cmbArrTotaleImportiPerDatiPaghe.AddRow(s);
      cmbArrTariffaDopoRiduzione.AddRow(s);
      selP050.Next;
    end;
  end;
end;

procedure TWA110FParametriConteggioDettFM.cmbArrTariffaDopoRiduzioneAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString:=cmbArrTariffaDopoRiduzione.Text;
  //AGGIORNA LA LABEL DESCRIZIONE CHE è UNA DBLABEL
end;

procedure TWA110FParametriConteggioDettFM.cmbArrTotaleImportiPerDatiPagheAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('ARROTTOTIMPORTIDATIPAGHE').AsString:=cmbArrTotaleImportiPerDatiPaghe.Text;
  //AGGIORNA LA LABEL DESCRIZIONE CHE è UNA DBLABEL
end;

procedure TWA110FParametriConteggioDettFM.cmbCausaleAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('CAUSALE_MISSIONE').AsString:=cmbCausale.Text;
  //AGGIORNA LA LABEL DESCRIZIONE CHE è UNA DBLABEL
end;

procedure TWA110FParametriConteggioDettFM.cmbCodiceAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('CODICE').AsString:=cmbCodice.Text;
  //AGGIORNA LA LABEL DESCRIZIONE CHE è UNA DBLABEL
end;

procedure TWA110FParametriConteggioDettFM.cmbTipoMissioneAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('TIPO_MISSIONE').AsString:=cmbTipoMissione.Text;
  //AGGIORNA LA LABEL DESCRIZIONE CHE è UNA DBLABEL
end;

end.
