unit WP150USetupDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB, OracleData,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  A000UInterfaccia, IWDBStdCtrls, IWCompEdit, medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, meIWDBEdit, IWCompCheckbox, meIWDBCheckBox, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup,
  meIWDBLabel, IWHTMLControls, meIWLink, C180FunzioniGenerali, UIntfWebT480,
  IWCompButton, meIWButton, meIWEdit;

type
  TWP150FSetupDettFM = class(TWR205FDettTabellaFM)
    cmbPagamento: TMedpIWMultiColumnComboBox;
    cmbValutaCalcolo: TMedpIWMultiColumnComboBox;
    cmbValutaStampa: TMedpIWMultiColumnComboBox;
    cmbValutaContabilita: TMedpIWMultiColumnComboBox;
    lblNumDecPerc: TmeIWLabel;
    dedtNumDecPerc: TmeIWDBEdit;
    lblNumDecQuantita: TmeIWLabel;
    dedtNumDecQuantita: TmeIWDBEdit;
    drgpTipoOre: TmeIWDBRadioGroup;
    lblTipoOre: TmeIWLabel;
    dchkBloccoIrpef: TmeIWDBCheckBox;
    lblCodComuneINAIL: TmeIWLabel;
    dedtUltAnnoRecup: TmeIWDBEdit;
    lblUltAnnoRecup: TmeIWLabel;
    dedtCodComuneINAIL: TmeIWDBEdit;
    dlblDPagamento: TmeIWDBLabel;
    dlblValutaCalcolo: TmeIWDBLabel;
    dlblValutaStampa: TmeIWDBLabel;
    dlblValutaContabilita: TmeIWDBLabel;
    lnkPagamento: TmeIWLink;
    lnkValutaCalcoli: TmeIWLink;
    lnkValutaStampa: TmeIWLink;
    lnkValutaContabilita: TmeIWLink;
    edtDescComune: TmeIWEdit;
    btnComuni: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbPagamentoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbValutaCalcoloAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbValutaStampaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbValutaContabilitaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure lnkPagamentoClick(Sender: TObject);
    procedure lnkValutaClick(Sender: TObject);
    procedure lnkValutaCalcoliClick(Sender: TObject);
    procedure lnkValutaStampaClick(Sender: TObject);
    procedure lnkValutaContabilitaClick(Sender: TObject);
  private
    IntfWebT480:TIntfWebT480;
    procedure Componenti2DataSet;override;
    procedure DataSet2Componenti;override;
    procedure CaricaMultiColumnCombobox; Override;
    procedure ReleaseOggetti; override;
  public
    { Public declarations }
  end;

implementation

uses WP150USetup, WP150USetupDM, WR100UBase;

{$R *.dfm}

procedure TWP150FSetupDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  IntfWebT480:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480 do
  begin
    Chiave:='CODCATASTALE';
    DataSource:=(WR302DM as TWP150FSetupDM).P150FSetupMW.D480;
    edtCitta:=edtDescComune;
    dedtCodice:=dedtCodComuneINAIL;
    btnLookup:=btnComuni;
  end;
  CaricaMultiColumnCombobox;
  if Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S' then
  begin
    cmbValutaContabilita.Visible:=False;
    lnkValutaContabilita.Visible:=False;
    dlblValutaContabilita.Visible:=False;
  end;
end;

procedure TWP150FSetupDettFM.lnkPagamentoClick(Sender: TObject);
begin
  (Self.Owner as TWR100FBase).AccediForm(514,'COD_PAGAMENTO=' + cmbPagamento.Text);
end;

procedure TWP150FSetupDettFM.lnkValutaCalcoliClick(Sender: TObject);
begin
  lnkValutaClick(cmbValutaCalcolo);
end;

procedure TWP150FSetupDettFM.lnkValutaClick(Sender: TObject);
begin
  //link WP030FValute
  (Self.Owner as TWR100FBase).AccediForm(517,'COD_VALUTA=' + (Sender as TMedpIWMultiColumnComboBox).Text);
end;

procedure TWP150FSetupDettFM.lnkValutaContabilitaClick(Sender: TObject);
begin
  lnkValutaClick(cmbValutaContabilita);
end;

procedure TWP150FSetupDettFM.lnkValutaStampaClick(Sender: TObject);
begin
  lnkValutaClick(cmbValutaStampa);
end;

procedure TWP150FSetupDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  // load cmbPagamento --ini
  with (WR302DM as TWP150FSetupDM).P150FSetupMW.Q130 do
  begin
    Refresh;
    First;
    cmbPagamento.Items.Clear;
    while not Eof do
    begin
      cmbPagamento.AddRow(FieldByName('COD_PAGAMENTO').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  cmbValutaStampa.Text:=(WR302DM as TWP150FSetupDM).SelTabella.FieldByName('COD_PAGAMENTO').AsString;
  with (WR302DM as TWP150FSetupDM).P150FSetupMW.Q030 do
  begin
    Refresh;
    First;
    cmbValutaContabilita.Items.Clear;
    cmbValutaStampa.Items.Clear;
    cmbValutaCalcolo.Items.Clear;
    while not Eof do
    begin
      cmbValutaContabilita.AddRow(FieldByName('COD_VALUTA').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbValutaStampa.AddRow(FieldByName('COD_VALUTA').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbValutaCalcolo.AddRow(FieldByName('COD_VALUTA').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  cmbValutaContabilita.Text:=(WR302DM as TWP150FSetupDM).SelTabella.FieldByName('COD_VALUTA_CONT').AsString;
  cmbValutaStampa.Text:=(WR302DM as TWP150FSetupDM).SelTabella.FieldByName('COD_VALUTA_STAMPA').AsString;
  cmbValutaCalcolo.Text:=(WR302DM as TWP150FSetupDM).SelTabella.FieldByName('COD_VALUTA_BASE').AsString;
end;

procedure TWP150FSetupDettFM.cmbPagamentoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWP150FSetupDM).SelTabella.FieldByName('COD_PAGAMENTO').AsString:=cmbPagamento.Text;
end;

procedure TWP150FSetupDettFM.cmbValutaCalcoloAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWP150FSetupDM).SelTabella.FieldByName('COD_VALUTA_BASE').AsString:=cmbValutaCalcolo.Text;
end;

procedure TWP150FSetupDettFM.cmbValutaContabilitaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWP150FSetupDM).SelTabella.FieldByName('COD_VALUTA_CONT').AsString:=cmbValutaContabilita.Text;
end;

procedure TWP150FSetupDettFM.cmbValutaStampaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  (WR302DM as TWP150FSetupDM).SelTabella.FieldByName('COD_VALUTA_STAMPA').AsString:=cmbValutaStampa.Text;
end;

procedure TWP150FSetupDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWP150FSetupDM) do
  begin
    selTabella.FieldByName('COD_PAGAMENTO').AsString:=cmbPagamento.Text;
    selTabella.FieldByName('COD_VALUTA_CONT').AsString:=cmbValutaContabilita.Text;
    selTabella.FieldByName('COD_VALUTA_STAMPA').AsString:=cmbValutaStampa.Text;
    selTabella.FieldByName('COD_VALUTA_BASE').AsString:=cmbValutaCalcolo.Text;
  end;
end;

procedure TWP150FSetupDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWP150FSetupDM) do
  begin
    cmbPagamento.Text:=SelTabella.FieldByName('COD_PAGAMENTO').AsString;
    edtDescComune.Text:=SelTabella.FieldByName('C_Desc_Comune').AsString;
    cmbValutaContabilita.Text:=SelTabella.FieldByName('COD_VALUTA_CONT').AsString;
    cmbValutaStampa.Text:=SelTabella.FieldByName('COD_VALUTA_STAMPA').AsString;
    cmbValutaCalcolo.Text:=SelTabella.FieldByName('COD_VALUTA_BASE').AsString;
  end;
end;

procedure TWP150FSetupDettFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(IntfWebT480);
end;

end.
