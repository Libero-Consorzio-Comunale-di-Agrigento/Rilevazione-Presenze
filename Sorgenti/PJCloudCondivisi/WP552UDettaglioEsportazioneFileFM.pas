unit WP552UDettaglioEsportazioneFileFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, WR100UBase,
  IWCompEdit, IWDBStdCtrls, meIWDBEdit, Data.DB, WP552uRegoleContoAnnualeDM,
  OracleData, IWCompLabel, meIWLabel, IWCompListbox, meIWDBComboBox, Generics.Collections,
  A000UCostanti, meIWDBLabel, WC013UCheckListFM;

type
  TWP552FDettaglioEsportazioneFileFM = class(TWR200FBaseFM)
    btnConferma: TmeIWButton;
    btnChiudi: TmeIWButton;
    dedtNumCampo: TmeIWDBEdit;
    lblNumCampo: TmeIWLabel;
    dcmbTipoCampo: TmeIWDBComboBox;
    lblTipoCampo: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dcmbFormato: TmeIWDBComboBox;
    lblFormato: TmeIWLabel;
    dedtLunghezza: TmeIWDBEdit;
    lblLunghezza: TmeIWLabel;
    lblLungProg: TmeIWLabel;
    dlblLungProg: TmeIWDBLabel;
    dedtFormula: TmeIWDBEdit;
    lblFormula: TmeIWLabel;
    btnFormula: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dcmbTipoCampoAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure btnFormulaClick(Sender: TObject);
  private
    ODS: TOracleDataset;
    procedure AbilitaFormula;
    procedure FormulaResult(Sender: TObject; Result: Boolean);
  public
    procedure Visualizza;
  end;

implementation
uses WP552URegoleContoAnnuale;
{$R *.dfm}

procedure TWP552FDettaglioEsportazioneFileFM.dcmbTipoCampoAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if Trim(ODS.FieldByName('DESCRIZIONE').AsString) = '' then
    ODS.FieldByName('DESCRIZIONE').AsString:=Copy(dcmbTipoCampo.Text,14,Length(dcmbTipoCampo.Text)-13);
  AbilitaFormula;
  if not dedtFormula.Enabled then
    ODS.FieldByName('FORMULA').AsString:='';
end;

procedure TWP552FDettaglioEsportazioneFileFM.AbilitaFormula;
begin
  dedtFormula.Enabled:=ODS.FieldByName('TIPO_CAMPO').ASString = 'FORMULA';
  btnFormula.Enabled:=dedtFormula.Enabled;
end;

procedure TWP552FDettaglioEsportazioneFileFM.IWFrameRegionCreate(Sender: TObject);
var
  dsr: TDataSource;
  lstElencoCampi: TList<TItemsValues>;
  ItemValue: TItemsValues;
begin
  inherited;
  dsr:=(WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.dsrP551;
  ODS:=(dsr.Dataset as TOracleDataSet);
  dedtNumCampo.DataSource:=dsr;
  dcmbTipoCampo.DataSource:=dsr;
  dedtDescrizione.DataSource:=dsr;
  dcmbFormato.DataSource:=dsr;
  dedtLunghezza.DataSource:=dsr;
  dlblLungProg.DataSource:=dsr;
  dedtFormula.DataSource:=dsr;
  lstElencoCampi:=TList<TItemsValues>.Create();
  try
    (WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.getLstTipoCampo(WR302DM.SelTabella.FieldByName('COD_TABELLA').AsString,IntToStr(WR302DM.SelTabella.FieldByName('ANNO').AsInteger), lstElencoCampi);
    for ItemValue in lstElencoCampi do
      dcmbTipoCampo.Items.Add(Format('%s=%s',[ItemValue.Item,ItemValue.Value]));
  finally
    FreeAndNil(lstElencoCampi);
  end;

  lstElencoCampi:=TList<TItemsValues>.Create();
  try
    (WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.getLstFormato(lstElencoCampi);
    for ItemValue in lstElencoCampi do
      dcmbFormato.Items.Add(Format('%s=%s',[ItemValue.Item,ItemValue.Value]));
  finally
    FreeAndNil(lstElencoCampi);
  end;
  AbilitaFormula;

  dedtNumCampo.Enabled:=ODS.State = dsInsert;
  if ODS.State = dsInsert then
  begin
    ODS.FieldByName('NUM_CAMPO').AsInteger:=(WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.NextNumCampo(WR302DM.SelTabella.FieldByName('COD_TABELLA').AsString,IntToStr(WR302DM.SelTabella.FieldByName('ANNO').AsInteger));
  end;
end;

procedure TWP552FDettaglioEsportazioneFileFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  if (Sender = btnConferma) then
  begin
    (Self.Owner as TWP552FRegoleContoAnnuale).EsportazioneFileFM.actConfermaExecute(nil)
  end
  else
  begin
    (Self.Owner as TWP552FRegoleContoAnnuale).EsportazioneFileFM.actAnnullaExecute(nil)
  end;

  ReleaseOggetti;
  Free;
end;

procedure TWP552FDettaglioEsportazioneFileFM.btnFormulaClick(Sender: TObject);
var
  ElencoCampiFormula: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
  S: String;
  LstSel: TStringList;
begin
  try
    ElencoCampiFormula:=(WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.ElencoCampiFormula;

    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(ElencoCampiFormula.LstDescrizione, ElencoCampiFormula.lstCodice);

    S:=dedtFormula.Text;
    S:=StringReplace(StringReplace(dedtFormula.Text,'+',',',[rfReplaceAll]),'-',',',[rfReplaceAll]);

    LstSel:=TStringList.Create;
    LstSel.StrictDelimiter:=True;
    LstSel.CommaText:=S;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=FormulaResult;
    WC013.Visualizza(0,0,'<WC013> Elenco colonne');
  finally
    FreeAndNil(ElencoCampiFormula);
    if LstSel <> nil then
      FreeAndNil(LstSel);
  end;
end;

procedure TWP552FDettaglioEsportazioneFileFM.FormulaResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
  val, S,SOld: string;
begin
  if Result then
  begin
    try
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    S:=lsttMP.CommaText;
    SOld:=ODS.FieldByName('FORMULA').AsString;
    //preso da win as is...
    if lstTmp.Count > 0 then
    begin
      S:=StringReplace(S,',','+',[rfReplaceAll]);
      for val in lstTmp do
        if (Pos(Trim(val),SOld) > 1)
        and (Trim(Copy(SOld,Pos(Trim(val),SOld) - 1,1)) = '-') then
          if Pos(Trim(val),S) = 1 then
            S:='-' + S
          else
            S:=StringReplace(S,'+' + Trim(val),'-' + Trim(val),[rfReplaceAll]);
    end;
    ODS.FieldByName('FORMULA').AsString:=S;
    finally
      FreeAndNil(lstTmp);
    end;
  end;
end;

procedure TWP552FDettaglioEsportazioneFileFM.Visualizza;
begin
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,710,-1,450,'Esportazione su file','#' + Self.Name,False,False);
end;

end.
