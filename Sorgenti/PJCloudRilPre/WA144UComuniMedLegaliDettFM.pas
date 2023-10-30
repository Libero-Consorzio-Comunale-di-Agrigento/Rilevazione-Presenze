unit WA144UComuniMedLegaliDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, Vcl.StdCtrls, IWHTMLControls,
  meIWLink, IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, meIWDBLabel, UIntfWebT480, OracleData, WR100UBase,
  medpIWMultiColumnComboBox;

type
  TWA144FComuniMedLegaliDettFM = class(TWR205FDettTabellaFM)
    dedtCodComune: TmeIWDBEdit;
    lblCodComune: TmeIWLabel;
    btnComuni: TmeIWButton;
    edtDescComune: TmeIWEdit;
    dlblDMedLegale: TmeIWDBLabel;
    lnkComuni: TmeIWLink;
    cmbCodMedLegale: TMedpIWMultiColumnComboBox;
    LnkCodice: TmeIWLink;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure lnkComuniClick(Sender: TObject);
    procedure cmbCodMedLegaleAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure LnkCodiceClick(Sender: TObject);
  private
    { Private declarations }
    IntfWebT480:TIntfWebT480;
    procedure DataSet2Componenti; override;
    procedure ReleaseOggetti; override;
    procedure CaricaMultiColumnCombobox; override;
  public
    { Public declarations }
  end;

implementation

uses WA144UComuniMedLegali, WA144UComuniMedLegaliDM, IWInit;

{$R *.dfm}

procedure TWA144FComuniMedLegaliDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  IntfWebT480:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480 do
  begin
    DataSource:=(WR302DM as TWA144FComuniMedLegaliDM).A144FComuniMedLegaliMW.dscT480;
    edtCitta:=edtDescComune;
    dedtCodice:=dedtCodComune;
    //dedtCap:=Self.dedtCap;
    btnLookup:=btnComuni;
  end;
  DataSet2Componenti;
end;

procedure TWA144FComuniMedLegaliDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA144FComuniMedLegaliDM).A144FComuniMedLegaliMW do
  begin
    selT485.First;
    cmbCodMedLegale.Items.Clear;
    while not selT485.Eof do
    begin
      cmbCodMedLegale.AddRow(selT485.FieldByName('CODICE').AsString + ';' +
                             selT485.FieldByName('DESCRIZIONE').AsString);
      selT485.Next;
    end;
  end;
end;

procedure TWA144FComuniMedLegaliDettFM.LnkCodiceClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='CODICE='+ cmbCodMedLegale.Text;
  (Self.Owner as TWR100FBase).AccediForm(64,Params);
end;

procedure TWA144FComuniMedLegaliDettFM.DataSet2Componenti;
begin
  with TWA144FComuniMedLegaliDM(WR302DM) do
  begin
    cmbCodMedLegale.Text:=selTabella.FieldByName('MED_LEGALE').AsString;
    edtDescComune.Text:='';
    if A144FComuniMedLegaliMW.selT480.SearchRecord('CODICE',selTabella.FieldByName('COD_COMUNE').AsString,[srFromBeginning]) then
      edtDescComune.Text:=A144FComuniMedLegaliMW.selT480.FieldByName('CITTA').AsString;
  end;
end;

procedure TWA144FComuniMedLegaliDettFM.lnkComuniClick(Sender: TObject);
begin
  TWR100FBase(Self.Parent).AccediForm(530,'CODICE=' + TWA144FComuniMedLegaliDM(WR302DM).A144FComuniMedLegaliMW.selT480.FieldByName('CODICE').AsString);
end;

procedure TWA144FComuniMedLegaliDettFM.cmbCodMedLegaleAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('MED_LEGALE').AsString:=cmbCodMedLegale.Text;
end;

procedure TWA144FComuniMedLegaliDettFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(IntfWebT480);
end;

end.
