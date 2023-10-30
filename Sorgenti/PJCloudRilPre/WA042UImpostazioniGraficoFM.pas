unit WA042UImpostazioniGraficoFM;

interface

uses
  Windows, Messages, SysUtils,Math, Variants, Classes, Graphics, Controls, Forms, OracleData,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, medpIWMultiColumnComboBox, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompCheckbox, meIWCheckBox, IWCompExtCtrls, meIWImageFile, medpIWImageButton, IWCompButton, meIWButton, meIWEdit;

type
  TWA042FImpostazioniGraficoFM = class(TWR200FBaseFM)
    lblCausPresenza: TmeIWLabel;
    cmbPresenza: TMedpIWMultiColumnComboBox;
    lblDescrPresenza: TmeIWLabel;
    lblGrpPresenza: TmeIWLabel;
    lblCausAssenza: TmeIWLabel;
    cmbAssenza: TMedpIWMultiColumnComboBox;
    lblDescrAssenza: TmeIWLabel;
    lblGrpAssenza: TmeIWLabel;
    ChkCausaliNonAbbinate: TmeIWCheckBox;
    BtnSalvaPresenze: TmedpIWImageButton;
    BtnCancellaPresenze: TmedpIWImageButton;
    BtnImportaPresenze: TmedpIWImageButton;
    BtnImportaAssenze: TmedpIWImageButton;
    BtnCancellaAssenze: TmedpIWImageButton;
    BtnSalvaAssenze: TmedpIWImageButton;
    btnChiudi: TmeIWButton;
    lblColorePresenza: TmeIWLabel;
    edtColorePresenza: TmeIWEdit;
    edtColoreAssenza: TmeIWEdit;
    lblColoreAssenza: TmeIWLabel;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure BtnSalvaPresenzeAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnSalvaAssenzeAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure ChkCausaliNonAbbinateAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure edtColorePresenzaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtColoreAssenzaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbPresenzaChange(Sender: TObject; Index: Integer);
    procedure cmbAssenzaChange(Sender: TObject; Index: Integer);
    procedure BtnCancellaPresenzeClick(Sender: TObject);
    procedure BtnCancellaAssenzeClick(Sender: TObject);
    procedure BtnImportaPresenzeClick(Sender: TObject);
    procedure BtnImportaAssenzeClick(Sender: TObject);
  private
    procedure AggiornaLabel;
    function rgbToBgr(rgbColor: String): String;
    function bgrToRgb(bgrColor: String): String;
  public
    procedure Visualizza;
  end;

implementation

uses WR100UBase, WA042UStampaPreAss;

{$R *.dfm}

procedure TWA042FImpostazioniGraficoFM.Visualizza;
begin
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,500,400,400,'(WA042) Impostazione colori del grafico','#WA042_ImpostazioniGrafico',False,True);
end;

procedure TWA042FImpostazioniGraficoFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  // Carico comboBox --- ini
  with (Self.Owner as TWA042FStampaPreAss).A042MW.selT275 do
  begin
    First;
    Filtered:=False;
    while not Eof do
    begin
      cmbPresenza.AddRow(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    if SearchRecord('Codice', (Self.Owner as TWA042FStampaPreAss).A042MW.sPb_CausaleEU, [srFromBeginning]) then
      cmbPresenza.Text:=FieldByName('CODICE').AsString;
  end;
  with (Self.Owner as TWA042FStampaPreAss).A042MW.selT265 do
  begin
    First;
    while not Eof do
    begin
      cmbAssenza.AddRow(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    if SearchRecord('Codice', (Self.Owner as TWA042FStampaPreAss).A042MW.sPb_CausaleEU, [srFromBeginning]) then
      cmbAssenza.Text:=FieldByName('CODICE').AsString;
  end;
  // Carico comboBox --- fine
  chkCausaliNonAbbinate.Checked:=(Self.Owner as TWA042FStampaPreAss).A042MW.bPb_MostraCausaliNonAbbinate;
  AggiornaLabel;
end;

procedure TWA042FImpostazioniGraficoFM.AggiornaLabel;
begin
  lblDescrPresenza.Caption:='';
  if cmbPresenza.ItemIndex <> -1 then
    lblDescrPresenza.Caption:=cmbPresenza.Items[cmbPresenza.ItemIndex].RowData[1];
  lblDescrAssenza.Caption:='';
  if cmbAssenza.ItemIndex <> -1 then
    lblDescrAssenza.Caption:=cmbAssenza.Items[cmbAssenza.ItemIndex].RowData[1];
end;

procedure TWA042FImpostazioniGraficoFM.BtnCancellaAssenzeClick(Sender: TObject);
var
  i:integer;
begin
  with (Self.Owner as TWA042FStampaPreAss).A042MW do
  begin
    for i:=0 to High(aPb_CausaliAssenza) do
      aPb_CausaliAssenza[i].xColore:=clWhite;
  end;
  cmbAssenzaChange(nil,0);
end;

procedure TWA042FImpostazioniGraficoFM.BtnCancellaPresenzeClick(Sender: TObject);
var
  i:integer;
begin
  with (Self.Owner as TWA042FStampaPreAss).A042MW do
  begin
    for i:=0 to High(aPb_CausaliPresenza) do
      aPb_CausaliPresenza[i].xColore:=clWhite;
  end;
  cmbPresenzaChange(nil,0);
end;

procedure TWA042FImpostazioniGraficoFM.btnChiudiClick(Sender: TObject);
begin
  BtnSalvaAssenzeAsyncClick(nil,nil);
  BtnSalvaPresenzeAsyncClick(nil,nil);
  //Richiamando PutParametriFunzione inserisco i colori tra i parametri funzione. Così quando e se viene
  //richiamato il B028 per la stampa del grafico, questi parametri li posso leggere tra i parametri funzione di WA042
  (Self.Owner as TWA042FStampaPreAss).PutParametriFunzione;
  ReleaseOggetti;
  Free;
end;

procedure TWA042FImpostazioniGraficoFM.BtnImportaAssenzeClick(Sender: TObject);
var
  i:integer;
begin
  with (Self.Owner as TWA042FStampaPreAss).A042MW do
  begin
    SetLength(aPb_CausaliAssenza,0);
    for i:=0 to High(aPb_CausaliAssenzaDb) do
    begin
      SetLength(aPb_CausaliAssenza, length(aPb_CausaliAssenza) + 1);
      aPb_CausaliAssenza[i].sCodice:=aPb_CausaliAssenzaDb[i].sCodice;
      aPb_CausaliAssenza[i].sDescrizione:=aPb_CausaliAssenzaDb[i].sDescrizione;
      aPb_CausaliAssenza[i].xColore:=aPb_CausaliAssenzaDb[i].xColore;
    end;
  end;
  cmbAssenzaChange(nil,0);
end;

procedure TWA042FImpostazioniGraficoFM.BtnImportaPresenzeClick(Sender: TObject);
var
  i:integer;
begin
  with (Self.Owner as TWA042FStampaPreAss).A042MW do
  begin
    SetLength(aPb_CausaliPresenza,0);
    for i:=0 to High(aPb_CausaliPresenzaDb) do
    begin
      SetLength(aPb_CausaliPresenza, length(aPb_CausaliPresenza) + 1);
      aPb_CausaliPresenza[i].sCodice:=aPb_CausaliPresenzaDb[i].sCodice;
      aPb_CausaliPresenza[i].sDescrizione:=aPb_CausaliPresenzaDb[i].sDescrizione;
      aPb_CausaliPresenza[i].xColore:=aPb_CausaliPresenzaDb[i].xColore;
    end;
  end;
  cmbPresenzaChange(nil,0);
end;

procedure TWA042FImpostazioniGraficoFM.BtnSalvaAssenzeAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i:integer;
begin
  with (Self.Owner as TWA042FStampaPreAss).A042MW do
  begin
    SetLength(aPb_CausaliAssenzaDb,0);
    for i:=0 to High(aPb_CausaliAssenza) do
    begin
      SetLength(aPb_CausaliAssenzaDb, length(aPb_CausaliAssenzaDb) + 1);
      aPb_CausaliAssenzaDb[i].sCodice:=aPb_CausaliAssenza[i].sCodice;
      aPb_CausaliAssenzaDb[i].sDescrizione:=aPb_CausaliAssenza[i].sDescrizione;
      aPb_CausaliAssenzaDb[i].xColore:=aPb_CausaliAssenza[i].xColore;
    end;
  end;
end;

procedure TWA042FImpostazioniGraficoFM.BtnSalvaPresenzeAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i:integer;
begin
  with (Self.Owner as TWA042FStampaPreAss).A042MW do
  begin
    SetLength(aPb_CausaliPresenzaDb,0);
    for i:=0 to High(aPb_CausaliPresenza) do
    begin
      SetLength(aPb_CausaliPresenzaDb, length(aPb_CausaliPresenzaDb) + 1);
      aPb_CausaliPresenzaDb[i].sCodice:=aPb_CausaliPresenza[i].sCodice;
      aPb_CausaliPresenzaDb[i].sDescrizione:=aPb_CausaliPresenza[i].sDescrizione;
      aPb_CausaliPresenzaDb[i].xColore:=aPb_CausaliPresenza[i].xColore;
    end;
  end;
end;

procedure TWA042FImpostazioniGraficoFM.ChkCausaliNonAbbinateAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  (Self.Owner as TWA042FStampaPreAss).A042MW.bPb_MostraCausaliNonAbbinate:=ChkCausaliNonAbbinate.Checked;
end;

procedure TWA042FImpostazioniGraficoFM.cmbAssenzaChange(Sender: TObject; Index: Integer);
begin
  (Self.Owner as TWA042FStampaPreAss).A042MW.selT265.SearchRecord('Codice', cmbAssenza.Text, [srFromBeginning]);
  edtColoreAssenza.Text:=bgrToRgb(IntToHex((Self.Owner as TWA042FStampaPreAss).A042MW.aPb_CausaliAssenza[(Self.Owner as TWA042FStampaPreAss).A042MW.selT265.FieldByName('NUMERO_RIGA').asInteger - 1].xColore,6));
  AggiornaLabel;
end;

procedure TWA042FImpostazioniGraficoFM.cmbPresenzaChange(Sender: TObject; Index: Integer);
begin
  (Self.Owner as TWA042FStampaPreAss).A042MW.selT275.SearchRecord('Codice', cmbPresenza.Text, [srFromBeginning]);
  edtColorePresenza.Text:=bgrToRgb(IntToHex((Self.Owner as TWA042FStampaPreAss).A042MW.aPb_CausaliPresenza[(Self.Owner as TWA042FStampaPreAss).A042MW.selT275.FieldByName('NUMERO_RIGA').asInteger - 1].xColore,6));
  AggiornaLabel;
end;

procedure TWA042FImpostazioniGraficoFM.edtColoreAssenzaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  (Self.Owner as TWA042FStampaPreAss).A042MW.aPb_CausaliAssenza[(Self.Owner as TWA042FStampaPreAss).A042MW.selT265.FieldByName('NUMERO_RIGA').asInteger - 1].xColore:=StrToInt('$'+rgbToBgr(edtColoreAssenza.Text)); //HexToInt
end;

procedure TWA042FImpostazioniGraficoFM.edtColorePresenzaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  (Self.Owner as TWA042FStampaPreAss).A042MW.aPb_CausaliPresenza[(Self.Owner as TWA042FStampaPreAss).A042MW.selT275.FieldByName('NUMERO_RIGA').asInteger - 1].xColore:=StrToInt('$'+rgbToBgr(edtColorePresenza.Text)); //HexToInt
end;

function TWA042FImpostazioniGraficoFM.rgbToBgr(rgbColor: String):String;
begin
  //Devo invertire il colore perchè in delphi viene mappato il colore al contrario dello standard
  //(es: #0000FF per delphi è rosso mentre invece lo standard HTML è rosso = #FF0000)
  Result:=Copy(rgbColor, 5, 2)+Copy(rgbColor, 3, 2)+Copy(rgbColor, 1, 2);
end;

function TWA042FImpostazioniGraficoFM.bgrToRgb(bgrColor: String):String;
begin
  //Devo invertire il colore perchè in delphi viene mappato il colore al contrario dello standard
  //(es: #0000FF per delphi è rosso mentre invece lo standard HTML è rosso = #FF0000)
  Result:=Copy(bgrColor, 5, 2)+Copy(bgrColor, 3, 2)+Copy(bgrColor, 1, 2);
end;


end.
