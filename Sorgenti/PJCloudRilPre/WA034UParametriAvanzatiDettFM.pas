unit WA034UParametriAvanzatiDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompListbox, IWDBStdCtrls,
  meIWDBLookupComboBox, IWCompLabel, meIWLabel, IWCompEdit, meIWDBEdit,
  IWCompExtCtrls, meIWImageFile, medpIWImageButton, IWCompCheckbox,
  meIWDBCheckBox, meIWDBLabel,
  WA034UParametriAvanzatiDM, meIWEdit,medpIWMessageDlg,C180FunzioniGenerali,A000UInterfaccia,
  medpIWMultiColumnComboBox;

type
  TWA034FParametriAvanzatiDettFM = class(TWR205FDettTabellaFM)
    dedtFormula: TmeIWDBEdit;
    lblFormula: TmeIWLabel;
    imgVerificaFormula: TmeIWImageFile;
    lblVocePaghe: TmeIWLabel;
    dedtVocePaghe: TmeIWDBEdit;
    lblArrotondamento: TmeIWLabel;
    dEdtArrotondamento: TmeIWDBEdit;
    dchkSpostaValImp: TmeIWDBCheckBox;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    lblDescVocePagheNegativa: TmeIWDBLabel;
    lblDescVocePagheCedolino: TmeIWDBLabel;
    lblVocePagheCedolino: TmeIWLabel;
    lblAttivaDal: TmeIWLabel;
    lblAttivaAl: TmeIWLabel;
    dChkAutoIncDal: TmeIWDBCheckBox;
    dChkAutoIncAl: TmeIWDBCheckBox;
    lblVocePagheNegativa: TmeIWLabel;
    dedtAttivaDal: TmeIWDBEdit;
    dedtAttivaAl: TmeIWDBEdit;
    cmbVocePagheCedolino: TMedpIWMultiColumnComboBox;
    cmbVocePagheNegativa: TMedpIWMultiColumnComboBox;
    lblDescrizioneInterfaccia: TmeIWLabel;
    procedure cmbVocePagheCedolinooldAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbVocePagheNegativaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure imgVerificaFormulaClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CaricaMultiColumnCombobox; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
  end;

implementation

{$R *.dfm}

{ TWA034FParametriAvanzatiDettFM }

procedure TWA034FParametriAvanzatiDettFM.DataSet2Componenti;
begin
  with (WR302DM as TWA034FParametriAvanzatiDM) do
  begin
    lblDescrizioneInterfaccia.Caption:=DescrizioneInterfaccia;
    cmbVocePagheCedolino.Text:=selTabella.FieldByName('VOCE_PAGHE_CEDOLINO').AsString;
    cmbVocePagheNegativa.Text:=selTabella.FieldByName('VOCE_PAGHE_NEGATIVA').AsString;
  end;
end;

procedure TWA034FParametriAvanzatiDettFM.imgVerificaFormulaClick(
  Sender: TObject);
var
  Msg: String;
begin
  Msg:='';
  with (WR302DM as TWA034FParametriAvanzatiDM) do
  begin
    if selTabella.FieldByName('FORMULA').AsString <> '' then
    begin
      if A034FParametriAvanzatiMW.VerificaFormula(selTabella.FieldByName('FORMULA').AsString,Msg) then
        MsgBox.WebMessageDlg(Msg,mtInformation,[mbOk],nil,'')
      else

        MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
    end;
  end;
end;

procedure TWA034FParametriAvanzatiDettFM.CaricaMultiColumnCombobox;
var
  cmbRow: String;
begin
  inherited;
  cmbVocePagheCedolino.Items.Clear;
  cmbVocePagheNegativa.Items.Clear;
  with (WR302DM as TWA034FParametriAvanzatiDM).A034FParametriAvanzatiMW.selP200 do
  begin
    First;
    while not Eof do
    begin
      cmbRow:=FieldByName('COD_VOCE').AsString + ';'+ FieldByName('DESCRIZIONE').AsString;
      cmbVocePagheCedolino.AddRow(cmbRow);
      cmbVocePagheNegativa.AddRow(cmbRow);
      Next;
    end;
  end;
end;

procedure TWA034FParametriAvanzatiDettFM.cmbVocePagheCedolinooldAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWA034FParametriAvanzatiDM) do
  begin
    selTabella.FieldByName('VOCE_PAGHE_CEDOLINO').AsString:=cmbVocePagheCedolino.Text;
  end;
end;

procedure TWA034FParametriAvanzatiDettFM.cmbVocePagheNegativaAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWA034FParametriAvanzatiDM) do
  begin
    selTabella.FieldByName('VOCE_PAGHE_NEGATIVA').AsString:=cmbVocePagheNegativa.Text;
  end;
end;

procedure TWA034FParametriAvanzatiDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWA034FParametriAvanzatiDM) do
  begin
    selTabella.FieldByName('VOCE_PAGHE_CEDOLINO').AsString:=cmbVocePagheCedolino.Text;
    selTabella.FieldByName('VOCE_PAGHE_NEGATIVA').AsString:=cmbVocePagheNegativa.Text;
  end;
end;
end.
