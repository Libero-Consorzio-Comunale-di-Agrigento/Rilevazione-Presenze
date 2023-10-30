unit WA021UCausGiustifDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWMultiColumnComboBox,
  IWCompCheckbox, meIWDBCheckBox, IWCompButton,
  meIWButton, WA021UAssestamentoAnnuoFM, A000UInterfaccia, IWCompExtCtrls,
  IWCompJQueryWidget, meIWLabel, meIWImageFile, IWHTMLControls, meIWLink,
  medpIWMultiColumnComboBox;

type
  TWA021FCausGiustifDettFM = class(TWR205FDettTabellaFM)
    dedtCodice: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtFascia1: TmeIWDBEdit;
    lblVocePaghe: TmeIWLabel;
    lblFascia1: TmeIWLabel;
    dedtFascia2: TmeIWDBEdit;
    lblFascia2: TmeIWLabel;
    dedtFascia3: TmeIWDBEdit;
    lblFascia3: TmeIWLabel;
    dedtFascia4: TmeIWDBEdit;
    lblFascia4: TmeIWLabel;
    lblSiglaCartellino: TmeIWLabel;
    dedtSigla: TmeIWDBEdit;
    lblAssestamentoAnnuo: TmeIWLabel;
    dedtAssestamentoAnnuo: TmeIWDBEdit;
    lblConsideraScheda: TmeIWLabel;
    dedtConsideraScheda: TmeIWDBEdit;
    dchkInclusioneLiquidabile: TmeIWDBCheckBox;
    dchkAssestamentoNegativo: TmeIWDBCheckBox;
    dchkRendiNegativa: TmeIWDBCheckBox;
    btnAssestamentoAnnuo: TmeIWButton;
    lblDescRaggruppamento: TmeIWLabel;
    lnkRaggruppamento: TmeIWLink;
    cmbRaggruppamento: TMedpIWMultiColumnComboBox;
    dchkAumentaEccGiorn: TmeIWDBCheckBox;
    procedure cmbRaggruppamentoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure btnAssestamentoAnnuoClick(Sender: TObject);
    procedure imgAccediClick(Sender: TObject);
  private
    WAssestamento:TWA021FAssestamentoAnnuoFM;
  public
    procedure ResultAssestamento(Sender: TObject; Result: Boolean;Assestamento:Boolean; Ordine:String);
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnComboBox; override;
  end;

implementation

uses WA021UCausGiustif, WA021UCausGiustifDM, WA019URaggrGiustif, WR100UBase;

{$R *.dfm}

procedure TWA021FCausGiustifDettFM.DataSet2Componenti;
begin
  with TWA021FCausGiustifDM(WR302DM) do
  begin
    cmbRaggruppamento.ItemIndex:=-1;
    cmbRaggruppamento.Text:=selTabella.FieldByName('CODRAGGR').AsString;
    lblDescRaggruppamento.Caption:=VarToStr(TWA021FCausGiustifDM(WR302DM).Q300.LookUp('CODICE', cmbRaggruppamento.Text, 'DESCRIZIONE'));
  end;
end;

procedure TWA021FCausGiustifDettFM.Componenti2DataSet;
begin
  with TWA021FCausGiustifDM(WR302DM) do
    selTabella.FieldByName('CODRAGGR').AsString :=cmbRaggruppamento.Text;
end;

procedure TWA021FCausGiustifDettFM.btnAssestamentoAnnuoClick(Sender: TObject);
begin
  WAssestamento:=TWA021FAssestamentoAnnuoFM.Create(Self.Parent);
  with TWA021FCausGiustifDM(WR302DM) do
  begin
    if Trim(selTabella.FieldByName('ASSEST_ANNUO').AsString) <> '' then
    begin
      WAssestamento.OrderValue:=selTabella.FieldByName('ASSEST_ANNUO').AsString;
      WAssestamento.chkAssestamentoAnnuo.Checked:=True;
    end
    else
    begin
      WAssestamento.OrderValue:='CP,LP,CA,LA';
      WAssestamento.chkAssestamentoAnnuo.Checked:=False;
    end;
  end;
  WAssestamento.ResultEvent:=ResultAssestamento;
  WAssestamento.Visualizza;
end;

procedure TWA021FCausGiustifDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with TWA021FCausGiustifDM(WR302DM).Q300 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbRaggruppamento.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA021FCausGiustifDettFM.cmbRaggruppamentoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  Componenti2DataSet;
  lblDescRaggruppamento.Caption:=cmbRaggruppamento.Items[Index].RowData[1];
end;

procedure TWA021FCausGiustifDettFM.imgAccediClick(Sender: TObject);
begin
  TWA021FCausGiustif(Self.Parent).AccediForm(110,'CODICE='+TWA021FCausGiustifDM(WR302DM).selTabellaCodRaggr.AsString);
end;

procedure TWA021FCausGiustifDettFM.ResultAssestamento(Sender: TObject; Result: Boolean;Assestamento:Boolean; Ordine:String);
begin
  if Result then
    if Ordine <> '' then
      TWA021FCausGiustifDM(WR302DM).selTabella.FieldByName('ASSEST_ANNUO').AsString:=Ordine
    else
      TWA021FCausGiustifDM(WR302DM).selTabella.FieldByName('ASSEST_ANNUO').Clear;
end;

end.
