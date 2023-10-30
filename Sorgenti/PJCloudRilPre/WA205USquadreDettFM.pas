unit WA205USquadreDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompButton, meIWButton,
  IWCompEdit, meIWEdit, IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel,
  WC013UCheckListFM, A000UCostanti, medpIWMultiColumnComboBox, IWHTMLControls,
  meIWLink;

type
  TWA205FSquadreDettFM = class(TWR205FDettTabellaFM)
    lblInizioValidita: TmeIWLabel;
    dedtInizioValidita: TmeIWDBEdit;
    lblFineValidita: TmeIWLabel;
    dedtFineValidita: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizioneLunga: TmeIWLabel;
    dedtDescrizioneLunga: TmeIWDBEdit;
    btnCodiciTurnazione: TmeIWButton;
    cmbCausRiposo: TMedpIWMultiColumnComboBox;
    dedtCodiciTurnazione: TmeIWDBEdit;
    lnkCausRiposo: TmeIWLink;
    lnkCodiciTurnazione: TmeIWLink;
    procedure lnkCausRiposoClick(Sender: TObject);
    procedure lnkCodiciTurnazioneClick(Sender: TObject);
    procedure btnCodiciTurnazioneClick(Sender: TObject);
  private
    { Private declarations }
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnComboBox; override;
    procedure CodTurnazResult(Sender: TObject; Result: Boolean);
    function GetListT640:TElencoValoriChecklist;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses WA205USquadreDM, WR100UBase;

procedure TWA205FSquadreDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWA205FSquadreDM) do
    selTabella.FieldByName('CAUS_RIPOSO').AsString:=cmbCausRiposo.Text;
end;

procedure TWA205FSquadreDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWA205FSquadreDM) do
    cmbCausRiposo.Text:=selTabella.FieldByName('CAUS_RIPOSO').AsString;
end;

procedure TWA205FSquadreDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  cmbCausRiposo.Items.Clear;
  with (WR302DM as TWA205FSquadreDM).A205MW.selT265 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbCausRiposo.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA205FSquadreDettFM.lnkCausRiposoClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(105,'CODICE=' + cmbCausRiposo.Text);
end;

procedure TWA205FSquadreDettFM.lnkCodiciTurnazioneClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(127,'CODICE=' + Copy(dedtCodiciTurnazione.Text,1,Pos(',',dedtCodiciTurnazione.Text + ',') - 1));
end;

procedure TWA205FSquadreDettFM.btnCodiciTurnazioneClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  listT640: TElencoValoriChecklist;
  LstSel: TStringList;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  listT640:=GetListT640;
  WC013.CaricaLista(listT640.lstDescrizione,listT640.lstCodice);
  FreeAndNil(listT640);
  LstSel:=TStringList.Create;
  LstSel.CommaText:=dedtCodiciTurnazione.Text;
  WC013.ImpostaValoriSelezionati(LstSel);
  FreeAndNil(LstSel);
  WC013.ResultEvent:=CodTurnazResult;
  WC013.Visualizza(0,0,'<WC013> Codici turnazioni');
end;

function TWA205FSquadreDettFM.GetListT640:TElencoValoriChecklist;
begin
  Result:=TElencoValoriChecklist.Create;
  with (WR302DM as TWA205FSquadreDM).A205MW.selT640 do
  begin
    First;
    while not Eof do
    begin
      Result.lstCodice.Add(FieldByName('CODICE').AsString);
      Result.lstDescrizione.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

procedure TWA205FSquadreDettFM.CodTurnazResult(Sender: TObject; Result: Boolean);
var lst: TStringList;
begin
  if Result then
  begin
    lst:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      dedtCodiciTurnazione.DataSource.DataSet.FieldByName(dedtCodiciTurnazione.DataField).AsString:=lst.CommaText;
    finally
      FreeAndNil(lst);
    end;
  end;
end;

end.
