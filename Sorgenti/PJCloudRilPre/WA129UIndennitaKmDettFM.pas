unit WA129UIndennitaKmDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, meIWDBLabel, WA129UIndennitaKmDM,
  medpIWMultiColumnComboBox, IWHTMLControls, meIWLink, WR100UBase, C190FunzioniGeneraliWeb;

type
  TWA129FIndennitaKmDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    LblIndennitaKmNelComune: TmeIWLabel;
    dedtImporto: TmeIWDBEdit;
    dLblValuta: TmeIWDBLabel;
    cmbArrotondamento: TMedpIWMultiColumnComboBox;
    dLblArrImportiKmNelComune: TmeIWDBLabel;
    lblCodiceVocePaghe: TmeIWLabel;
    dEdtCodicePaghe: TmeIWDBEdit;
    lnkArrImportiKmNelComune: TmeIWLink;
    CmbCategRimborso: TMedpIWMultiColumnComboBox;
    lblCategRimborso: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbArrotondamentoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure lnkArrImportiKmNelComuneClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation

{$R *.dfm}

procedure TWA129FIndennitaKmDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  dLblValuta.DataSource:=(WR302DM as TWA129FIndennitaKmDM).A129FIndennitaKmMW.dsrP050;
end;

procedure TWA129FIndennitaKmDettFM.lnkArrImportiKmNelComuneClick(
  Sender: TObject);
var Params: String;
begin
  Params:='CODICE='+ cmbArrotondamento.Text;
  (Self.Owner as TWR100FBase).AccediForm(519,Params);
end;

procedure TWA129FIndennitaKmDettFM.cmbArrotondamentoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('ARROTONDAMENTO').AsString:=cmbArrotondamento.Text;
  //Aggiorna DBLabel
end;

procedure TWA129FIndennitaKmDettFM.DataSet2Componenti;
begin
  inherited;
  with WR302DM.selTabella do
  begin
    cmbArrotondamento.Text:=FieldByName('ARROTONDAMENTO').AsString;
    CmbCategRimborso.Text:=FieldByName('ARROTONDAMENTO').AsString;
  end;
end;

procedure TWA129FIndennitaKmDettFM.Componenti2DataSet;
begin
  WR302DM.selTabella.FieldByName('ARROTONDAMENTO').AsString:=CmbCategRimborso.Text;
end;

procedure TWA129FIndennitaKmDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA129FIndennitaKmDM).A129FIndennitaKmMW do
  begin
    C190CaricaMepdMulticolumnComboBox(CmbCategRimborso,selM022);
    selP050.First;
    cmbArrotondamento.Items.Clear;
    while not selP050.Eof do
    begin
      cmbArrotondamento.AddRow(selP050.FieldByName('COD_ARROTONDAMENTO').AsString + ';' +
                               selP050.FieldByName('DESCRIZIONE').AsString + ';' +
                               selP050.FieldByName('VALORE').AsString);
      selP050.Next;
    end;
  end;
end;

end.
