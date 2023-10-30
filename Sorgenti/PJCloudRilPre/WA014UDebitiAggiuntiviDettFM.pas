unit WA014UDebitiAggiuntiviDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup,
  meIWLabel, WC015USelEditGridFM, IWCompExtCtrls,
  IWCompJQueryWidget, meIWImageFile, IWHTMLControls, meIWLink,
  medpIWMultiColumnComboBox, IWCompCheckbox, meIWDBCheckBox;

type
  TWA014FDebitiAggiuntiviDettFM = class(TWR205FDettTabellaFM)
    lblDebito: TmeIWLabel;
    lblAnno: TmeIWLabel;
    drgpDebito: TmeIWDBRadioGroup;
    lblDebitoAggiuntivo: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    dedtGennaio: TmeIWDBEdit;
    dedtFebbraio: TmeIWDBEdit;
    dedtMarzo: TmeIWDBEdit;
    dedtAprile: TmeIWDBEdit;
    dedtMaggio: TmeIWDBEdit;
    dedtGiugno: TmeIWDBEdit;
    dedtAgosto: TmeIWDBEdit;
    dedtLuglio: TmeIWDBEdit;
    dedtSettembre: TmeIWDBEdit;
    dedtOttobre: TmeIWDBEdit;
    dedtNovembre: TmeIWDBEdit;
    dedtDicembre: TmeIWDBEdit;
    lblGennaio: TmeIWLabel;
    lblFebbraio: TmeIWLabel;
    lblMarzo: TmeIWLabel;
    lblAprile: TmeIWLabel;
    lblMaggio: TmeIWLabel;
    lblGiugno: TmeIWLabel;
    lblLuglio: TmeIWLabel;
    lblAgosto: TmeIWLabel;
    lblSettembre: TmeIWLabel;
    lblOttobre: TmeIWLabel;
    lblNovembre: TmeIWLabel;
    lblDicembre: TmeIWLabel;
    lblDescCodice: TmeIWLabel;
    lnkCodice: TmeIWLink;
    dcmbCodice: TMedpIWMultiColumnComboBox;
    dchkGestAnticipo: TmeIWDBCheckBox;
    procedure dcmbCodiceAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure imgAccediClick(Sender: TObject);
  private
    WC015:TWC015FSelEditGridFM;
  public
    { Public declarations }
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnComboBox; override;
  end;

implementation

uses WA014UDebitiAggiuntiviDM;

{$R *.dfm}

procedure TWA014FDebitiAggiuntiviDettFM.DataSet2Componenti;
begin
  with TWA014FDebitiAggiuntiviDM(WR302DM) do
  begin
    dcmbCodice.ItemIndex:=-1;
    dcmbCodice.Text:=selTabella.FieldByName('CODICE').AsString;
    lblDescCodice.Caption:=VarToStr(T060.LookUp('CODICE', dcmbCodice.Text, 'DESCRIZIONE'));
  end;
end;

procedure TWA014FDebitiAggiuntiviDettFM.CaricaMultiColumnComboBox;
begin
  TWA014FDebitiAggiuntiviDM(WR302DM).T060.Refresh;
  TWA014FDebitiAggiuntiviDM(WR302DM).T060.First;
  while not TWA014FDebitiAggiuntiviDM(WR302DM).T060.Eof do
  begin
    dcmbCodice.AddRow(TWA014FDebitiAggiuntiviDM(WR302DM).T060.FieldByName('CODICE').AsString + ';' + TWA014FDebitiAggiuntiviDM(WR302DM).T060.FieldByName('DESCRIZIONE').AsString);;
    TWA014FDebitiAggiuntiviDM(WR302DM).T060.Next;
  end;
end;

procedure TWA014FDebitiAggiuntiviDettFM.Componenti2DataSet;
begin
  with TWA014FDebitiAggiuntiviDM(WR302DM) do
    selTabella.FieldByName('CODICE').AsString:=dcmbCodice.Text;
end;

procedure TWA014FDebitiAggiuntiviDettFM.dcmbCodiceAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  lblDescCodice.Caption:=VarToStr(TWA014FDebitiAggiuntiviDM(WR302DM).T060.LookUp('CODICE', dcmbCodice.Items[Index].RowData[0], 'DESCRIZIONE'));
end;

procedure TWA014FDebitiAggiuntiviDettFM.imgAccediClick(Sender: TObject);
begin
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  WC015.Visualizza('Categorie di Plus Orario',TWA014FDebitiAggiuntiviDM(WR302DM).T060);
end;

end.
