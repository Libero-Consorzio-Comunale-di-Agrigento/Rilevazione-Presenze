unit WA057USpostSquadraDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWDBStdCtrls, meIWDBLabel,
  medpIWMultiColumnComboBox, IWCompEdit, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel,
  IWHTMLControls, meIWLink, IWApplication, IWCompButton, meIWButton;

type
  TWA057FSpostSquadraDettFM = class(TWR205FDettTabellaFM)
    lblData: TmeIWLabel;
    dedtData: TmeIWDBEdit;
    cmbCodSquadra: TMedpIWMultiColumnComboBox;
    cmbCodOrario: TMedpIWMultiColumnComboBox;
    lblSiglaTurno1: TmeIWLabel;
    cmbSiglaTurno1: TMedpIWMultiColumnComboBox;
    lblSiglaTurno2: TmeIWLabel;
    cmbSiglaTurno2: TMedpIWMultiColumnComboBox;
    lnkCodSquadra: TmeIWLink;
    lnkCodOrario: TmeIWLink;
    btnCambioData: TmeIWButton;
    lblDescSquadra: TmeIWLabel;
    lblDescOrario: TmeIWLabel;
    cmbCodTipoOpe: TMedpIWMultiColumnComboBox;
    lblCodTipoOpe: TmeIWLabel;
    procedure dedtDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCambioDataClick(Sender: TObject);
    procedure lnkCodSquadraClick(Sender: TObject);
    procedure cmbCodSquadraChange(Sender: TObject; Index: Integer);
    procedure cmbCodTipoOpeChange(Sender: TObject; Index: Integer);
    procedure cmbCodOrarioChange(Sender: TObject; Index: Integer);
    procedure cmbSiglaTurno1Change(Sender: TObject; Index: Integer);
    procedure cmbSiglaTurno2Change(Sender: TObject; Index: Integer);
    procedure lnkCodOrarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA057USpostSquadra, WA057USpostSquadraDM;

{$R *.dfm}

procedure TWA057FSpostSquadraDettFM.dedtDataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA057FSpostSquadraDettFM.btnCambioDataClick(Sender: TObject);
begin
  inherited;
  WR302DM.selTabella.FieldByName('DATA').AsDateTime:=StrToDate(dedtData.Text);
  (WR302DM as TWA057FSpostSquadraDM).AggiornaComponenti;
end;

procedure TWA057FSpostSquadraDettFM.lnkCodSquadraClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWA057FSpostSquadra).AccediForm(128,'CODICE='+ cmbCodSquadra.Text);
end;

procedure TWA057FSpostSquadraDettFM.cmbCodSquadraChange(Sender: TObject; Index: Integer);
begin
  inherited;
  WR302DM.selTabella.FieldByName('SQUADRA').AsString:=cmbCodSquadra.Text;
  (WR302DM as TWA057FSpostSquadraDM).AggiornaComponenti;
end;

procedure TWA057FSpostSquadraDettFM.cmbCodTipoOpeChange(Sender: TObject; Index: Integer);
begin
  inherited;
  WR302DM.selTabella.FieldByName('COD_TIPOOPE').AsString:=cmbCodTipoOpe.Text;
  (WR302DM as TWA057FSpostSquadraDM).AggiornaComponenti;
end;

procedure TWA057FSpostSquadraDettFM.lnkCodOrarioClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWA057FSpostSquadra).AccediForm(103,'CODICE='+ cmbCodOrario.Text);
end;

procedure TWA057FSpostSquadraDettFM.cmbCodOrarioChange(Sender: TObject; Index: Integer);
begin
  inherited;
  WR302DM.selTabella.FieldByName('ORARIO').AsString:=cmbCodOrario.Text;
  (WR302DM as TWA057FSpostSquadraDM).AggiornaComponenti;
end;

procedure TWA057FSpostSquadraDettFM.cmbSiglaTurno1Change(Sender: TObject; Index: Integer);
begin
  inherited;
  WR302DM.selTabella.FieldByName('TURNO1').AsString:=cmbSiglaTurno1.Text;
end;

procedure TWA057FSpostSquadraDettFM.cmbSiglaTurno2Change(Sender: TObject; Index: Integer);
begin
  inherited;
  WR302DM.selTabella.FieldByName('TURNO2').AsString:=cmbSiglaTurno2.Text;
end;

end.
