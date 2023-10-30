unit WP651URelazioniTabelleDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, DB, WR100UBase,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWHTMLControls, meIWLink,
  IWCompLabel, IWDBStdCtrls, meIWDBLabel, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, medpIWMultiColumnComboBox, meIWLabel,
  meIWDBEdit;

type
  TWP651FRelazioniTabelleDettFM = class(TWR205FDettTabellaFM)
    dcmbCodDato1: TMedpIWMultiColumnComboBox;
    dlblDescrCodDato1: TmeIWDBLabel;
    dcmbCodDato2: TMedpIWMultiColumnComboBox;
    dlblDescrCodDato2: TmeIWDBLabel;
    lblDato2: TmeIWLabel;
    lblDato1: TmeIWLabel;
    lblPercentuale: TmeIWLabel;
    dedtPercentuale: TmeIWDBEdit;
    procedure dcmbCodDato1AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dcmbCodDato2AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
    { Private declarations }
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaComponenti; override;
  public
    { Public declarations }
    procedure CaricaMultiColumnComboBox; override;
  end;

implementation

{$R *.dfm}

uses WP651URelazioniTabelleDM, WR102UGestTabella;

{ TWP651FRelazioniTabelleDettFM }

procedure TWP651FRelazioniTabelleDettFM.AbilitaComponenti;
begin
  inherited;
  if WR302DM.selTabella.State <> dsBrowse then
    dcmbCodDato1.Enabled:=not (WR302DM as TWP651FRelazioniTabelleDM).selTabella.FieldByName('COD_DATO1').ReadOnly;
  if WR302DM.selTabella.State <> dsBrowse then
    dcmbCodDato2.Enabled:=not (WR302DM as TWP651FRelazioniTabelleDM).selTabella.FieldByName('COD_DATO2').ReadOnly;
end;

procedure TWP651FRelazioniTabelleDettFM.CaricaMultiColumnComboBox;
var i:Integer;
begin
  inherited;
  with (WR302DM as TWP651FRelazioniTabelleDM).P651FRelazioniTabelleMW do
  begin
    dcmbCodDato1.Items.Clear;
    dcmbCodDato2.Items.Clear;
    for i:=0 to lstDati1.Count - 1 do
      dcmbCodDato1.AddRow(Copy(lstDati1[i],1,LungTipoQuota1) + ';' + Copy(lstDati1[i],LungTipoQuota1+1));
    for i:=0 to lstDati2.Count - 1 do
      dcmbCodDato2.AddRow(Copy(lstDati2[i],1,LungTipoQuota2) + ';' + Copy(lstDati2[i],LungTipoQuota2+1));
  end;
end;

procedure TWP651FRelazioniTabelleDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWP651FRelazioniTabelleDM) do
  begin
    selTabella.FieldByName('COD_DATO1').AsString:=Trim(dcmbCodDato1.Text);
    selTabella.FieldByName('COD_DATO2').AsString:=Trim(dcmbCodDato2.Text);
  end;
end;

procedure TWP651FRelazioniTabelleDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWP651FRelazioniTabelleDM) do
  begin
    dcmbCodDato1.Text:=selTabella.FieldByName('COD_DATO1').AsString;
    dcmbCodDato2.Text:=selTabella.FieldByName('COD_DATO2').AsString;
  end;
end;

procedure TWP651FRelazioniTabelleDettFM.dcmbCodDato1AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWP651FRelazioniTabelleDM) do
    selTabella.FieldByName('COD_DATO1').AsString:=Trim(dcmbCodDato1.Text);
end;

procedure TWP651FRelazioniTabelleDettFM.dcmbCodDato2AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWP651FRelazioniTabelleDM) do
    selTabella.FieldByName('COD_DATO2').AsString:=Trim(dcmbCodDato2.Text);
end;

end.
