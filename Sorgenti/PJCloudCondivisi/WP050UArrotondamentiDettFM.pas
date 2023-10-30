unit WP050UArrotondamentiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls, meIWDBEdit, DB,
  meIWDBLabel, medpIWMultiColumnComboBox, IWHTMLControls, meIWLink,
  WR100UBase, WR102UGestTabella, meIWEdit;

type
  TWP050FArrotondamentiDettFM = class(TWR205FDettTabellaFM)
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    drgpTipo: TmeIWDBRadioGroup;
    lblTipo: TmeIWLabel;
    lblCodArrotondamento: TmeIWLabel;
    dedtValore: TmeIWDBEdit;
    lblValore: TmeIWLabel;
    lnkValuta: TmeIWLink;
    cmbCodValuta: TMedpIWMultiColumnComboBox;
    dlblDescrCodValuta: TmeIWDBLabel;
    edtCodArrotondamento: TmeIWEdit;
    procedure lnkValutaClick(Sender: TObject);
    procedure cmbCodValutaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
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

uses WP050UArrotondamentiDM;

procedure TWP050FArrotondamentiDettFM.lnkValutaClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(517,'COD_VALUTA=' + cmbCodValuta.Text);
end;

procedure TWP050FArrotondamentiDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with (WR302DM as TWP050FArrotondamentiDM).P050FArrotondamentiMW.Q030 do
  begin
    Refresh;
    First;
    cmbCodValuta.Items.Clear;
    while not Eof do
    begin
      if FieldByName('COD_VALUTA').AsString <> '' then
        cmbCodValuta.AddRow(FieldByName('COD_VALUTA').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWP050FArrotondamentiDettFM.cmbCodValutaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWP050FArrotondamentiDM) do
  begin
    selTabella.FieldByName('COD_VALUTA').AsString:=cmbCodValuta.Text;
  end;
end;

procedure TWP050FArrotondamentiDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWP050FArrotondamentiDM) do
  begin
    selTabella.FieldByName('COD_VALUTA').AsString:=cmbCodValuta.Text;
    selTabella.FieldByName('COD_ARROTONDAMENTO').AsString:=edtCodArrotondamento.Text;
  end;
end;

procedure TWP050FArrotondamentiDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWP050FArrotondamentiDM) do
  begin
    cmbCodValuta.Text:=selTabella.FieldByName('COD_VALUTA').AsString;
    edtCodArrotondamento.Text:=selTabella.FieldByName('COD_ARROTONDAMENTO').AsString;
  end;
end;

procedure TWP050FArrotondamentiDettFM.AbilitaComponenti;
begin
  inherited;
  if (WR302DM.selTabella.State = dsEdit) or
     (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso then
  begin
    cmbCodValuta.Enabled:=False;
  end;
end;

end.
