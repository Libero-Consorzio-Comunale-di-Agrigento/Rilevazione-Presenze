unit WA017URaggrAsseDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, IWMultiColumnComboBox,
  meIWLabel,
  meIWDBRadioGroup, meIWDBEdit,meIWDBCheckBox,
  IWCompCheckbox, Db, IWCompExtCtrls,
  IWCompJQueryWidget, medpIWMultiColumnComboBox;

type
  TWA017FRaggrAsseDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    drgpInquadramento: TmeIWDBRadioGroup;
    lblInquadramento: TmeIWLabel;
    dchkConteggioAnnoSolare: TmeIWDBCheckBox;
    dchkResiduabile: TmeIWDBCheckBox;
    lblResTotale: TmeIWLabel;
    dedtMaxResiduo: TmeIWDBEdit;
    lblRaggruppamento: TmeIWLabel;
    lblResiduiAnnoPrec: TmeIWLabel;
    dchkResiduoCumulabile: TmeIWDBCheckBox;
    lblRaggruppamentoResiduo: TmeIWLabel;
    lblRaggrResiduoPrec: TmeIWLabel;
    dedtMaxResiduoCorr: TmeIWDBEdit;
    lblResCorr: TmeIWLabel;
    dedtMaxResiduoPrec: TmeIWDBEdit;
    lblResPrec: TmeIWLabel;
    dcmbRaggruppamentoResiduo: TMedpIWMultiColumnComboBox;
    dcmbRaggrResiduoPrec: TMedpIWMultiColumnComboBox;
    procedure dchkResiduabileClick(Sender: TObject);
    procedure dcmbRaggruppamentoResiduoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dcmbRaggrResiduoPrecAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnComboBox; override;
  end;

implementation

uses WA017URaggrAsseDM;

{$R *.dfm}

procedure TWA017FRaggrAsseDettFM.AbilitaComponenti;
var
  isResiduabile : boolean;
begin
  with TWA017FRaggrAsseDM(WR302DM) do
  begin
    if selTabella.State in [dsInsert,dsEdit] then
    begin
      isResiduabile:=selTabella.FieldByName('RESIDUABILE').AsString = 'S';

      dcmbRaggruppamentoResiduo.Enabled:= isResiduabile;
      dcmbRaggrResiduoPrec.Enabled:=isResiduabile;
      if not isResiduabile then
      begin
        selTabella.FieldByName('MAXRESIDUO').AsString:='';
        dcmbRaggruppamentoResiduo.Text:='';
        lblRaggruppamentoResiduo.Caption:='';
        dcmbRaggrResiduoPrec.Text:='';
        lblRaggrResiduoPrec.Caption:='';
      end;

      dedtMaxResiduo.Enabled:=isResiduabile;
      dedtMaxResiduoCorr.Enabled:=isResiduabile;
      dedtMaxResiduoPrec.Enabled:=isResiduabile;
      lblRaggruppamento.Enabled:=isResiduabile;
      dcmbRaggruppamentoResiduo.Enabled:=isResiduabile;
      lblResiduiAnnoPrec.Enabled:=isResiduabile;
      dcmbRaggrResiduoPrec.Enabled:=isResiduabile;
      dchkResiduoCumulabile.Enabled:= isResiduabile and (dcmbRaggruppamentoResiduo.Text = '');
      if not dchkResiduoCumulabile.Enabled then
      begin
            dchkResiduoCumulabile.Checked:=False;
        TWA017FRaggrAsseDM(WR302DM).selTabella.FieldByName(dchkResiduoCumulabile.DataField).AsString:='N';
      end;
      end;
  end;
end;

procedure TWA017FRaggrAsseDettFM.DataSet2Componenti;
begin
  with TWA017FRaggrAsseDM(WR302DM) do
  begin
    dcmbRaggruppamentoResiduo.ItemIndex:=-1;
    dcmbRaggruppamentoResiduo.Text:=selTabella.FieldByName('RAGGRUPPAMENTO_RESIDUO').AsString;
    lblRaggruppamentoResiduo.Caption:=VarToStr(selT260.LookUp('CODICE',selTabella.fieldByName('RAGGRUPPAMENTO_RESIDUO').AsString, 'DESCRIZIONE'));

    dcmbRaggrResiduoPrec.ItemIndex:=-1;
    dcmbRaggrResiduoPrec.Text:=selTabella.FieldByName('RAGGR_RESIDUO_PREC').AsString;
    lblRaggrResiduoPrec.Caption:=VarToStr(selT260.LookUp('CODICE',selTabella.fieldByName('RAGGR_RESIDUO_PREC').AsString, 'DESCRIZIONE'));
  end;
end;

procedure TWA017FRaggrAsseDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with TWA017FRaggrAsseDM(WR302DM).selT260 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      dcmbRaggruppamentoResiduo.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      dcmbRaggrResiduoPrec.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
       Next;
    end;
  end;
end;

procedure TWA017FRaggrAsseDettFM.Componenti2DataSet;
begin
  with TWA017FRaggrAsseDM(WR302DM) do
  begin
    selTabella.FieldByName('RAGGRUPPAMENTO_RESIDUO').AsString:=dcmbRaggruppamentoResiduo.Text;
    selTabella.FieldByName('RAGGR_RESIDUO_PREC').AsString:=dcmbRaggrResiduoPrec.Text;
  end;
end;

procedure TWA017FRaggrAsseDettFM.dchkResiduabileClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TWA017FRaggrAsseDettFM.dcmbRaggrResiduoPrecAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA017FRaggrAsseDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.fieldByName('RAGGR_RESIDUO_PREC').AsString:=dcmbRaggrResiduoPrec.Text;
      lblRaggrResiduoPrec.Caption:=dcmbRaggrResiduoPrec.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.fieldByName('RAGGR_RESIDUO_PREC').AsString:='';
      lblRaggrResiduoPrec.Caption:='';
    end;
  end;
end;

procedure TWA017FRaggrAsseDettFM.dcmbRaggruppamentoResiduoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA017FRaggrAsseDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.fieldByName('RAGGRUPPAMENTO_RESIDUO').AsString:=dcmbRaggruppamentoResiduo.Text;
      lblRaggruppamentoResiduo.Caption:=dcmbRaggruppamentoResiduo.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.fieldByName('RAGGRUPPAMENTO_RESIDUO').AsString:='';
      lblRaggruppamentoResiduo.Caption:='';
    end;
  end;
end;

end.
