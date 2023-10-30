unit WS746UStatiAvanzamentoDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup,
  IWCompCheckbox, meIWDBCheckBox, meIWDBLabel, medpIWMultiColumnComboBox, DB;

type
  TWS746FStatiAvanzamentoDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblCodRegola: TmeIWLabel;
    dcmbCodRegola: TMedpIWMultiColumnComboBox;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    dchkChiuso: TmeIWDBCheckBox;
    lblDataDa: TmeIWLabel;
    lblDataA: TmeIWLabel;
    dedtDataDa: TmeIWDBEdit;
    dedtDataA: TmeIWDBEdit;
    lblPeriodoDiCompilazione: TmeIWLabel;
    lblPeriodoRegistraVisione: TmeIWLabel;
    lblDataDaRegistraVisione: TmeIWLabel;
    dedtDataDaRegistraVisione: TmeIWDBEdit;
    lblDataARegistraVisione: TmeIWLabel;
    dedtDataARegistraVisione: TmeIWDBEdit;
    lblValutazioneIntermedia: TmeIWLabel;
    dchkValIntermModificabile: TmeIWDBCheckBox;
    dchkValIntermObbligatoria: TmeIWDBCheckBox;
    lblAbilitaModifica: TmeIWLabel;
    drgpModificabile: TmeIWDBRadioGroup;
    lblCodStampa: TmeIWLabel;
    dcmbCodStampa: TMedpIWMultiColumnComboBox;
    lblDescCodRegola: TmeIWLabel;
    lblDescCodStampa: TmeIWLabel;
    procedure dedtDataDaRegistraVisioneAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure drgpModificabileClick(Sender: TObject);
    procedure dedtCodiceAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dcmbCodRegolaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dcmbCodStampaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
    { Private declarations }
  public
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure AbilitaComponenti; override;
  end;

implementation

uses WS746UStatiAvanzamentoDM;

{$R *.dfm}

procedure TWS746FStatiAvanzamentoDettFM.DataSet2Componenti;
begin
  inherited;
  (WR302DM as TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW.RecuperaListaRegole;
  (WR302DM as TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW.RecuperaListaStampa;
  dcmbCodRegola.Text:=WR302DM.SelTabella.FieldByName('CODREGOLA').AsString;
  dcmbCodStampa.Text:=WR302DM.SelTabella.FieldByName('CODSTAMPA').AsString;
  lblDescCodRegola.Text:=VarToStr((WR302DM as TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW.selSG741.Lookup('CODICE',dcmbCodRegola.Text,'DESCRIZIONE'));
  lblDescCodStampa.Text:=VarToStr((WR302DM as TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW.selSG746.Lookup('CODICE',StrToIntDef(dcmbCodStampa.Text,-1),'DESCRIZIONE'));
end;

procedure TWS746FStatiAvanzamentoDettFM.Componenti2DataSet;
begin
  inherited;
  WR302DM.SelTabella.FieldByName('CODREGOLA').AsString:=dcmbCodRegola.Text;
  WR302DM.SelTabella.FieldByName('CODSTAMPA').AsString:=dcmbCodStampa.Text;
end;

procedure TWS746FStatiAvanzamentoDettFM.dcmbCodRegolaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  lblDescCodRegola.Text:=(WR302DM as TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW.selSG741.Lookup('CODICE',dcmbCodRegola.Text,'DESCRIZIONE');
end;

procedure TWS746FStatiAvanzamentoDettFM.dcmbCodStampaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  lblDescCodStampa.Text:=(WR302DM as TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW.selSG746.Lookup('CODICE',StrToIntDef(dcmbCodStampa.Text,-1),'DESCRIZIONE');
end;

procedure TWS746FStatiAvanzamentoDettFM.dedtCodiceAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  (WR302DM AS TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW.SG746CODICEValidate;
end;

procedure TWS746FStatiAvanzamentoDettFM.dedtDataDaRegistraVisioneAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
    (WR302DM AS TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW.ResetPeriodoRegistraPresaVisione;
end;

procedure TWS746FStatiAvanzamentoDettFM.drgpModificabileClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
  with WR302DM.selTabella do
    if drgpModificabile.ItemIndex = 1 then
      FieldByName('CODSTAMPA').AsInteger:=FieldByName('CODICE').AsInteger - 1;
end;

procedure TWS746FStatiAvanzamentoDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM AS TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW do
  begin
    dcmbCodRegola.Items.Clear;
    selSG741.First;
    while not selSG741.Eof do
    begin
      dcmbCodRegola.AddRow(Format('%s;%s',[selSG741.FieldByName('CODICE').AsString,selSG741.FieldByName('DESCRIZIONE').AsString]));
      selSG741.Next;
    end;
  end;

  with (WR302DM AS TWS746FStatiAvanzamentoDM).S746FStatiAvanzamentoMW do
  begin
    dcmbCodStampa.Items.Clear;
    selSG746.First;
    while not selSG746.Eof do
    begin
      dcmbCodStampa.AddRow(Format('%s;%s',[selSG746.FieldByName('CODICE').AsString, selSG746.FieldByName('DESCRIZIONE').AsString]));
      selSG746.Next;
    end;
  end;

end;

procedure TWS746FStatiAvanzamentoDettFM.AbilitaComponenti;
begin
  drgpModificabile.Enabled:=StrToIntDef(dedtCodice.Text,0) <> 1;
  dcmbCodStampa.Enabled:=drgpModificabile.ItemIndex <> 1;
  lblDescCodStampa.Visible:=dcmbCodStampa.Text <> null;
  dchkValIntermObbligatoria.Enabled:=dchkValIntermModificabile.Checked;
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
    if not dchkValIntermModificabile.Checked then
      dchkValIntermObbligatoria.Checked:=False;
end;

end.
