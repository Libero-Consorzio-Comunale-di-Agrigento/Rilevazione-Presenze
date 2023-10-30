unit WP032UCambiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, DB,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWDBStdCtrls, meIWDBLabel,
  IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompEdit, medpIWMultiColumnComboBox, meIWDBEdit, IWHTMLControls,
  meIWLink, WR100UBase;

type
  TWP032FCambiDettFM = class(TWR205FDettTabellaFM)
    dcmbCodVal1: TMedpIWMultiColumnComboBox;
    dlblDescrCodVal1: TmeIWDBLabel;
    dcmbCodVal2: TMedpIWMultiColumnComboBox;
    dlblDescrCodVal2: TmeIWDBLabel;
    lblCoeffCalcoli: TmeIWLabel;
    dedtCoeffCalcoli: TmeIWDBEdit;
    lnkDaValuta: TmeIWLink;
    lnkAValuta: TmeIWLink;
    procedure lnkDaValutaClick(Sender: TObject);
    procedure lnkAValutaClick(Sender: TObject);
    procedure dcmbCodVal1AsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure dcmbCodVal2AsyncChange(Sender: TObject; EventParams: TStringList;
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

uses WP032UCambiDM, WR102UGestTabella;

procedure TWP032FCambiDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with (WR302DM as TWP032FCambiDM).P032FCambiMW.selP030 do
  begin
    Refresh;
    First;
    dcmbCodVal1.Items.Clear;
    dcmbCodVal2.Items.Clear;
    while not Eof do
    begin
      if FieldByName('COD_VALUTA').AsString <> '' then
      begin
        dcmbCodVal1.AddRow(FieldByName('COD_VALUTA').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
        dcmbCodVal2.AddRow(FieldByName('COD_VALUTA').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      end;
      Next;
    end;
  end;
end;

procedure TWP032FCambiDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWP032FCambiDM) do
  begin
    selTabella.FieldByName('COD_VALUTA1').AsString:=dcmbCodVal1.Text;
    selTabella.FieldByName('COD_VALUTA2').AsString:=dcmbCodVal2.Text;
  end;
end;

procedure TWP032FCambiDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWP032FCambiDM) do
  begin
    dcmbCodVal1.Text:=selTabella.FieldByName('COD_VALUTA1').AsString;
    dcmbCodVal2.Text:=selTabella.FieldByName('COD_VALUTA2').AsString;
  end;
end;

procedure TWP032FCambiDettFM.dcmbCodVal1AsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWP032FCambiDM) do
  begin
    selTabella.FieldByName('COD_VALUTA1').AsString:=dcmbCodVal1.Text;
  end;
end;

procedure TWP032FCambiDettFM.dcmbCodVal2AsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWP032FCambiDM) do
  begin
    selTabella.FieldByName('COD_VALUTA2').AsString:=dcmbCodVal2.Text;
  end;
end;

procedure TWP032FCambiDettFM.lnkAValutaClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(517,'COD_VALUTA=' + dcmbCodVal2.Text);
end;

procedure TWP032FCambiDettFM.lnkDaValutaClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(517,'COD_VALUTA=' + dcmbCodVal1.Text);
end;

procedure TWP032FCambiDettFM.AbilitaComponenti;
begin
  inherited;
  if (WR302DM.selTabella.State = dsEdit) or
     (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso then
  begin
    dcmbCodVal1.Enabled:=False;
    dcmbCodVal2.Enabled:=False;
  end;
end;

end.
