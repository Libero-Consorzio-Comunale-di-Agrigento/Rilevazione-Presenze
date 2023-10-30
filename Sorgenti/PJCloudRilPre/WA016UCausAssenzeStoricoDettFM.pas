unit WA016UCausAssenzeStoricoDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, OracleData,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompEdit, IWDBStdCtrls, meIWDBEdit,
  IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox, IWCompButton,
  meIWButton, meIWCheckBox, IWCompListbox, meIWDBComboBox,
  meIWDBLookupComboBox, WA016UCausAssenze, WA016UCausAssenzeDM, A016UCausAssenzeStoricoMW,
  A000UInterfaccia;

type
  TWA016FCausAssenzeStoricoDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    lblDescCausale: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    dedtDescCausale: TmeIWDBEdit;
    lblValorGior: TmeIWLabel;
    lblValorGiorOre: TmeIWLabel;
    dedtValorGiorOre: TmeIWDBEdit;
    lblValorGiorComp: TmeIWLabel;
    drgpValorGiorComp: TmeIWDBRadioGroup;
    lblValorGiorOreComp: TmeIWLabel;
    dedtValorGiorOreComp: TmeIWDBEdit;
    dchkValorGiorOrePropPT: TmeIWDBCheckBox;
    lblHMAssenza: TmeIWLabel;
    dedtHMAssenza: TmeIWDBEdit;
    lblCausaliCompatibili: TmeIWLabel;
    dedtCausaliCompatibili: TmeIWDBEdit;
    btnCausaliCompatibili: TmeIWButton;
    dchkHMAssenzaPropPT: TmeIWDBCheckBox;
    lblStatoCompatibilta: TmeIWLabel;
    lblCausaliCheckComp: TmeIWLabel;
    dedtCausaliCheckComp: TmeIWDBEdit;
    btnCausaliCheckComp: TmeIWButton;
    drgpValorGior: TmeIWDBRadioGroup;
    drgpStatoCompatibilta: TmeIWDBRadioGroup;
    lblVisualComp: TmeIWLabel;
    dcmbVisualCompetenze: TmeIWDBComboBox;
    lblGrpFruizAbilSP: TmeIWLabel;
    dchkFruizAbilSPGiorni: TmeIWDBCheckBox;
    dchkFruizAbilSPOre: TmeIWDBCheckBox;
    lblCausaleHMAssenza: TmeIWLabel;
    lblCausaleFruizOre: TmeIWLabel;
    dchkCheckSoloCompetenze: TmeIWDBCheckBox;
    dcmbCausaleHMAssenza: TmeIWDBLookupComboBox;
    dcmbCausaleFruizOre: TmeIWDBLookupComboBox;
    lblGrpPausaMensa: TmeIWLabel;
    dchkTimbPM: TmeIWDBCheckBox;
    dchkTimbPMDetraz: TmeIWDBCheckBox;
    dchkTimbPMH: TmeIWDBCheckBox;
    dchkPesoGiorDaOrario: TmeIWDBCheckBox;
    lblCartellino: TmeIWLabel;
    lblRegoleInserimento: TmeIWLabel;
    dedtCausCheckNoCompI: TmeIWDBEdit;
    lblCausCheckNoCompI: TmeIWLabel;
    lblCausCheckNoCompM: TmeIWLabel;
    lblCausCheckNoCompN: TmeIWLabel;
    lblCausCheckNoCompD: TmeIWLabel;
    dedtCausCheckNoCompM: TmeIWDBEdit;
    dedtCausCheckNoCompN: TmeIWDBEdit;
    dedtCausCheckNoCompD: TmeIWDBEdit;
    btnCausCheckNoCompI: TmeIWButton;
    btnCausCheckNoCompM: TmeIWButton;
    btnCausCheckNoCompN: TmeIWButton;
    btnCausCheckNoCompD: TmeIWButton;
    lblInserimentoImpeditoSeResiduo: TmeIWLabel;
    dchkGiustDaARecupFlex: TmeIWDBCheckBox;
    dchkAbbatteStrInd: TmeIWDBCheckBox;
    drgpConteggioTimbInterna: TmeIWDBRadioGroup;
    lblConteggioTimbInterna: TmeIWLabel;
    lblIntersezioneTimbrature: TmeIWLabel;
    drgpIntersezioneTimbrature: TmeIWDBRadioGroup;
    dchkSceltaOrario: TmeIWDBCheckBox;
    dchkIndPres: TmeIWDBCheckBox;
    dchkIndTurno: TmeIWDBCheckBox;
    dchkFruizInternaPN: TmeIWDBCheckBox;
    lblCMCausPresIncluse: TmeIWLabel;
    dedtCMCausPresIncluse: TmeIWDBEdit;
    btnCMCausPresIncluse: TmeIWButton;
    lblRegoleCumuloFruizione: TmeIWLabel;
    lblCondizioneAllegati: TmeIWLabel;
    drgpCondizioneAllegati: TmeIWDBRadioGroup;
    lblTipoGEDAP: TmeIWLabel;
    dgrpTipoGEDAP: TmeIWDBRadioGroup;
    lblGEDAP: TmeIWLabel;
    lblCausale: TmeIWLabel;
    dCmbCausaleGEDAP: TmeIWDBComboBox;
    dchkIndPresSuFestivo: TmeIWDBCheckBox;
    procedure drgpValorGiorClick(Sender: TObject);
    procedure drgpValorGiorCompClick(Sender: TObject);
    procedure SelezioneCausali(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dchkTimbPMAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure drgpIntersezioneTimbratureClick(Sender: TObject);
    procedure btnCMCausPresIncluseClick(Sender: TObject);
    procedure dchkIndPresAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    selT230,selT265:TOracleDataSet;
    WA016FCausAssenze:TWA016FCausAssenze;
    WA016FCausAssenzeDM:TWA016FCausAssenzeDM;
    WA016FCausAssenzeStoricoMW:TA016FCausAssenzeStoricoMW;
    procedure WC013RE_CausaliComp(Sender: TObject; Result: Boolean);
    procedure WC013RE_Competenze(Sender: TObject; Result: Boolean);
    procedure WC013RE_NoCompI(Sender: TObject; Result: Boolean);
    procedure WC013RE_NoCompM(Sender: TObject; Result: Boolean);
    procedure WC013RE_NoCompN(Sender: TObject; Result: Boolean);
    procedure WC013RE_NoCompD(Sender: TObject; Result: Boolean);
    procedure WC013CMCauspres_Incluse(Sender: TObject; Result: Boolean);
  public
    procedure AbilitaComponenti; override;
    procedure PopolaComboVisualCompetenze;
  end;

implementation

uses WA016UCausAssenzeStorico,WC013UCheckListFM,WA016UCausAssenzeStoricoDM, C180FunzioniGenerali;

{$R *.dfm}

procedure TWA016FCausAssenzeStoricoDettFM.SelezioneCausali(Sender: TObject);
var
  WA016MainForm:TWA016FCausAssenzeStorico;
  IDCausaleCorrente:Integer;
  CodiceCausale,TestoCausale,VecchioValore:String;
  ListaCodiciCausale,ListaTestoCausale,ListaVecchiValori:TStringList;
begin
  WA016MainForm:=(Owner as TWA016FCausAssenzeStorico);
  IDCausaleCorrente:=selT230.FieldByName('ID').AsInteger;
  ListaCodiciCausale:=TStringList.Create;
  ListaTestoCausale:=TStringList.Create;
  ListaVecchiValori:=TStringList.Create;
  try
    WA016MainForm.WC013FCheckListFM:=TWC013FCheckListFM.Create(WA016MainForm);  // Questa classe si occuperà di fare la Free()
    selT265.Filtered:=False;
    selT265.Filter:='(ID <> ' + IntToStr(IdCausaleCorrente) + ')';
    if Sender <> btnCausaliCompatibili then
      selT265.Filter:=selT265.Filter + ' and (TIPOCUMULO <> ''H'')';
    selT265.Filtered:=True;
    selT265.First;
    while not selT265.Eof do
    begin
      CodiceCausale:=selT265.FieldByName('CODICE').AsString;
      TestoCausale:=Format('%-5s - %s',[
                                      selT265.FieldByName('CODICE').AsString,
                                      selT265.FieldByName('DESCRIZIONE').AsString
                                     ]);
      ListaCodiciCausale.Add(CodiceCausale);
      ListaTestoCausale.Add(TestoCausale);
      selT265.Next;
    end;
    WA016MainForm.WC013FCheckListFM.CaricaLista(ListaTestoCausale,ListaCodiciCausale);

    if Sender = btnCausaliCompatibili then
    begin
      VecchioValore:=selT230.FieldByName('CAUSALI_COMPATIBILI').AsString;
      WA016MainForm.WC013FCheckListFM.ResultEvent:=WC013RE_CausaliComp;
    end
    else if Sender = btnCausaliCheckComp then
    begin
      VecchioValore:=selT230.FieldByName('CAUSALI_CHECKCOMPETENZE').AsString;
      WA016MainForm.WC013FCheckListFM.ResultEvent:=WC013RE_Competenze;
    end
    else if Sender = btnCausCheckNoCompI then
    begin
      VecchioValore:=selT230.FieldByName('CAUS_CHECKNOCOMP_I').AsString;
      WA016MainForm.WC013FCheckListFM.ResultEvent:=WC013RE_NoCompI;
    end
    else if Sender = btnCausCheckNoCompM then
    begin
      VecchioValore:=selT230.FieldByName('CAUS_CHECKNOCOMP_M').AsString;
      WA016MainForm.WC013FCheckListFM.ResultEvent:=WC013RE_NoCompM;
    end
    else if Sender = btnCausCheckNoCompN then
    begin
      VecchioValore:=selT230.FieldByName('CAUS_CHECKNOCOMP_N').AsString;
      WA016MainForm.WC013FCheckListFM.ResultEvent:=WC013RE_NoCompN;
    end
    else if Sender = btnCausCheckNoCompD then
    begin
      VecchioValore:=selT230.FieldByName('CAUS_CHECKNOCOMP_D').AsString;
      WA016MainForm.WC013FCheckListFM.ResultEvent:=WC013RE_NoCompD;
    end;
    ListaVecchiValori.StrictDelimiter:=True;
    ListaVecchiValori.CommaText:=VecchioValore;
    WA016MainForm.WC013FCheckListFM.ImpostaValoriSelezionati(ListaVecchiValori);
    WA016MainForm.WC013FCheckListFM.Visualizza;
  finally
    selT265.Filter:='';
    selT265.Filtered:=False;
    FreeAndNil(ListaCodiciCausale);
    FreeAndNil(ListaTestoCausale);
    FreeAndNil(ListaVecchiValori);
  end;
end;

procedure TWA016FCausAssenzeStoricoDettFM.AbilitaComponenti;
begin
  inherited;
  dedtValorGiorOre.Enabled:=(drgpValorGior.ItemIndex = 5);
  lblValorGiorOre.Enabled:=(drgpValorGior.ItemIndex = 5);
  {if not dedtValorGiorOre.Enabled then
    dedtValorGiorOre.Text:='00.00';}
  dedtValorGiorOreComp.Enabled:=(drgpValorGiorComp.ItemIndex = 6);
  lblValorGiorOreComp.Enabled:=(drgpValorGiorComp.ItemIndex = 6);
  {if not dedtValorGiorOreComp.Enabled then
    dedtValorGiorOreComp.Text:='00.00';}
  dchkValorGiorOrePropPT.Enabled:=(drgpValorGior.ItemIndex = 5) or (drgpValorGiorComp.ItemIndex = 6);
  dedtCausaliCompatibili.Enabled:=False;
  dedtCausaliCheckComp.Enabled:=False;
  dchkTimbPMDetraz.Enabled:=dchkTimbPM.Checked;
  dedtCausaliCheckComp.Enabled:=False;
  dedtCausCheckNoCompI.Enabled:=False;
  dedtCausCheckNoCompM.Enabled:=False;
  dedtCausCheckNoCompN.Enabled:=False;
  dedtCausCheckNoCompD.Enabled:=False;
  drgpConteggioTimbInterna.Enabled:=drgpIntersezioneTimbrature.ItemIndex = 1;

  dedtCMCausPresIncluse.Enabled:=False;
  btnCMCausPresIncluse.Enabled:=btnCMCausPresIncluse.Enabled and (selT265.Lookup('ID',selT230.FieldByName('ID').AsInteger,'TIPOCUMULO') = 'M');
  dchkIndPresSuFestivo.Enabled:=dchkIndPres.Checked and dchkIndPres.Enabled;
end;

procedure TWA016FCausAssenzeStoricoDettFM.btnCMCausPresIncluseClick(Sender: TObject);
var
  WA016MainForm:TWA016FCausAssenzeStorico;
  CodiceCausale,TestoCausale,VecchioValore:String;
  ListaCodiciCausale,ListaTestoCausale,ListaVecchiValori:TStringList;
begin
  inherited;
  WA016MainForm:=(Owner as TWA016FCausAssenzeStorico);
  ListaCodiciCausale:=TStringList.Create;
  ListaTestoCausale:=TStringList.Create;
  ListaVecchiValori:=TStringList.Create;
  ListaCodiciCausale.Add('<*>');
  ListaTestoCausale.Add(Format('%-5s - %s',['<*>','Causali standard']));
  try
    WA016MainForm.WC013FCheckListFM:=TWC013FCheckListFM.Create(WA016MainForm);  // Questa classe si occuperà di fare la Free()
    WA016FCausAssenzeStoricoMW.selT275.Filtered:=False;
    WA016FCausAssenzeStoricoMW.selT275.Open;
    WA016FCausAssenzeStoricoMW.selT275.First;
    while not WA016FCausAssenzeStoricoMW.selT275.Eof do
    begin
      CodiceCausale:=WA016FCausAssenzeStoricoMW.selT275.FieldByName('CODICE').AsString;
      TestoCausale:=Format('%-5s - %s',[
                                      CodiceCausale,
                                      WA016FCausAssenzeStoricoMW.selT275.FieldByName('DESCRIZIONE').AsString
                                     ]);
      ListaCodiciCausale.Add(CodiceCausale);
      ListaTestoCausale.Add(TestoCausale);
      WA016FCausAssenzeStoricoMW.selT275.Next;
    end;
    WA016MainForm.WC013FCheckListFM.CaricaLista(ListaTestoCausale,ListaCodiciCausale);

    VecchioValore:=selT230.FieldByName('CM_CAUSPRES_INCLUSE').AsString;
    WA016MainForm.WC013FCheckListFM.ResultEvent:=WC013CMCauspres_Incluse;

    ListaVecchiValori.StrictDelimiter:=True;
    ListaVecchiValori.CommaText:=VecchioValore;
    WA016MainForm.WC013FCheckListFM.ImpostaValoriSelezionati(ListaVecchiValori);
    WA016MainForm.WC013FCheckListFM.Visualizza;
  finally
    FreeAndNil(ListaCodiciCausale);
    FreeAndNil(ListaTestoCausale);
    FreeAndNil(ListaVecchiValori);
    WA016FCausAssenzeStoricoMW.selT275.Close;
  end;
end;

procedure TWA016FCausAssenzeStoricoDettFM.dchkIndPresAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dchkIndPresSuFestivo.Enabled:=dchkIndPres.Checked;
end;

procedure TWA016FCausAssenzeStoricoDettFM.dchkTimbPMAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  dchkTimbPMDetraz.Enabled:=dchkTimbPM.Checked;
end;

procedure TWA016FCausAssenzeStoricoDettFM.drgpIntersezioneTimbratureClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TWA016FCausAssenzeStoricoDettFM.drgpValorGiorClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TWA016FCausAssenzeStoricoDettFM.drgpValorGiorCompClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TWA016FCausAssenzeStoricoDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  // Il MW che contiene il dataset è sul DM del form dei dati non storicizzati
  WA016FCausAssenze:=(Owner as TWA016FCausAssenzeStorico).WA016FCausAssenze;
  WA016FCausAssenzeDM:=(WA016FCausAssenze.WR302DM as TWA016FCausAssenzeDM);
  WA016FCausAssenzeStoricoMW:=WA016FCausAssenzeDM.A016StoricoMW;
  selT230:=(WR302DM as TWA016FCausAssenzeStoricoDM).selTabella;
  selT265:=(WR302DM as TWA016FCausAssenzeStoricoDM).selT265;
  selT265.Open;
  dcmbCausaleFruizOre.ListSource:=WA016FCausAssenzeStoricoMW.dsrT265;
  dcmbCausaleHMAssenza.ListSource:=WA016FCausAssenzeStoricoMW.dsrT265;
  R180SetComboItemsValues(dCmbCausaleGEDAP.Items,WA016FCausAssenzeStoricoMW.D_CausaleGEDAP,'IV');
end;

procedure TWA016FCausAssenzeStoricoDettFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWA016FCausAssenzeStorico).ImpostaDataPeriodoIniziale;
end;

procedure TWA016FCausAssenzeStoricoDettFM.WC013CMCauspres_Incluse(Sender: TObject; Result: Boolean);
var
  ListaValoriSelezionati:TStringList;
begin
  if Result then
  begin
    ListaValoriSelezionati:=(Owner as TWA016FCausAssenzeStorico).WC013FCheckListFM.LeggiValoriSelezionati;
    try
      selT230.FieldByName('CM_CAUSPRES_INCLUSE').AsString:=ListaValoriSelezionati.CommaText;
    finally
      ListaValoriSelezionati.Free;
    end;
  end;
end;

procedure TWA016FCausAssenzeStoricoDettFM.WC013RE_CausaliComp(Sender: TObject; Result: Boolean);
var
  ListaValoriSelezionati:TStringList;
begin
  if Result then
  begin
    ListaValoriSelezionati:=(Owner as TWA016FCausAssenzeStorico).WC013FCheckListFM.LeggiValoriSelezionati;
    try
      selT230.FieldByName('CAUSALI_COMPATIBILI').AsString:=ListaValoriSelezionati.CommaText;
    finally
      ListaValoriSelezionati.Free;
    end;
  end;
end;

procedure TWA016FCausAssenzeStoricoDettFM.WC013RE_Competenze(Sender: TObject; Result: Boolean);
var
  ListaValoriSelezionati:TStringList;
begin
  if Result then
  begin
    ListaValoriSelezionati:=(Owner as TWA016FCausAssenzeStorico).WC013FCheckListFM.LeggiValoriSelezionati;
    try
      selT230.FieldByName('CAUSALI_CHECKCOMPETENZE').AsString:=ListaValoriSelezionati.CommaText;
      PopolaComboVisualCompetenze;
    finally
      ListaValoriSelezionati.Free;
    end;
  end;
end;

procedure TWA016FCausAssenzeStoricoDettFM.WC013RE_NoCompI(Sender: TObject; Result: Boolean);
var
  ListaValoriSelezionati:TStringList;
begin
  if Result then
  begin
    ListaValoriSelezionati:=(Owner as TWA016FCausAssenzeStorico).WC013FCheckListFM.LeggiValoriSelezionati;
    try
      selT230.FieldByName('CAUS_CHECKNOCOMP_I').AsString:=ListaValoriSelezionati.CommaText;
    finally
      ListaValoriSelezionati.Free;
    end;
  end;
end;

procedure TWA016FCausAssenzeStoricoDettFM.WC013RE_NoCompM(Sender: TObject; Result: Boolean);
var
  ListaValoriSelezionati:TStringList;
begin
  if Result then
  begin
    ListaValoriSelezionati:=(Owner as TWA016FCausAssenzeStorico).WC013FCheckListFM.LeggiValoriSelezionati;
    try
      selT230.FieldByName('CAUS_CHECKNOCOMP_M').AsString:=ListaValoriSelezionati.CommaText;
    finally
      ListaValoriSelezionati.Free;
    end;
  end;
end;

procedure TWA016FCausAssenzeStoricoDettFM.WC013RE_NoCompN(Sender: TObject; Result: Boolean);
var
  ListaValoriSelezionati:TStringList;
begin
  if Result then
  begin
    ListaValoriSelezionati:=(Owner as TWA016FCausAssenzeStorico).WC013FCheckListFM.LeggiValoriSelezionati;
    try
      selT230.FieldByName('CAUS_CHECKNOCOMP_N').AsString:=ListaValoriSelezionati.CommaText;
    finally
      ListaValoriSelezionati.Free;
    end;
  end;
end;

procedure TWA016FCausAssenzeStoricoDettFM.WC013RE_NoCompD(Sender: TObject; Result: Boolean);
var
  ListaValoriSelezionati:TStringList;
begin
  if Result then
  begin
    ListaValoriSelezionati:=(Owner as TWA016FCausAssenzeStorico).WC013FCheckListFM.LeggiValoriSelezionati;
    try
      selT230.FieldByName('CAUS_CHECKNOCOMP_D').AsString:=ListaValoriSelezionati.CommaText;
    finally
      ListaValoriSelezionati.Free;
    end;
  end;
end;

procedure TWA016FCausAssenzeStoricoDettFM.PopolaComboVisualCompetenze;
var
  CausaliCheckComp:String;
  CausaliCheckCompSplit:TArray<String>;
  CausaleCorr:String;
  IdxCausaleCorr:Integer;
begin
  dcmbVisualCompetenze.Items.Clear;
  CausaliCheckComp:=WR302DM.selTabella.FieldByName('CAUSALI_CHECKCOMPETENZE').AsString;
  if (Trim(CausaliCheckComp) <> '') then
  begin
    CausaliCheckCompSplit:=CausaliCheckComp.Split([',']);
    for CausaleCorr in CausaliCheckCompSplit do
    begin
      dcmbVisualCompetenze.Items.Add(CausaleCorr);
    end;
    CausaleCorr:=WR302DM.selTabella.FieldByName('CAUSALE_VISUALCOMPETENZE').AsString;
    IdxCausaleCorr:=dcmbVisualCompetenze.Items.IndexOf(CausaleCorr);
    dcmbVisualCompetenze.ItemIndex:=IdxCausaleCorr;
  end
  else
  begin
    WR302DM.selTabella.FieldByName('CAUSALE_VISUALCOMPETENZE').AsString:='';
  end;
end;


end.
