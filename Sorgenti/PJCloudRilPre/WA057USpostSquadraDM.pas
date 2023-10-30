unit WA057USpostSquadraDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A057USpostSquadraMW, C190FunzioniGeneraliWeb;

type
  TWA057FSpostSquadraDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaSQUADRA: TStringField;
    selTabellaORARIO: TStringField;
    selTabellaTURNO1: TStringField;
    selTabellaTURNO2: TStringField;
    selTabellaDESC_SQUADRA: TStringField;
    selTabellaDESC_ORARIO: TStringField;
    selTabellaCOD_TIPOOPE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A057MW: TA057FSpostSquadraMW;
    procedure AggiornaComponenti;
  end;

implementation

uses WA057USpostSquadra, WA057USpostSquadraDettFM;

{$R *.dfm}

procedure TWA057FSpostSquadraDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  SelTabella.SetVariable('ORDERBY','ORDER BY DATA,SQUADRA');
  A057MW:=TA057FSpostSquadraMW.Create(Self);
  A057MW.selT630:=selTabella;
  inherited;
end;

procedure TWA057FSpostSquadraDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A057MW.selT630AfterScroll;
  AggiornaComponenti;
end;

procedure TWA057FSpostSquadraDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A057MW.selT630CalcFields;
end;

procedure TWA057FSpostSquadraDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A057MW.selT630NewRecord;
  AggiornaComponenti;
end;

procedure TWA057FSpostSquadraDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A057MW.selT630BeforePost;
end;

procedure TWA057FSpostSquadraDM.AggiornaComponenti;
begin
  inherited;
  if (Self.Owner as TWA057FSpostSquadra).WDettaglioFM = nil then exit;
  with ((Self.Owner as TWA057FSpostSquadra).WDettaglioFM as TWA057FSpostSquadraDettFM) do
  begin
    A057MW.PulisciValori;
    C190CaricaMepdMulticolumnComboBox(cmbCodSquadra,A057MW.selT603,'CODICE');
    C190CaricaMepdMulticolumnComboBox(cmbCodTipoOpe,A057MW.selT430,['TIPOOPE']);
    C190CaricaMepdMulticolumnComboBox(cmbCodOrario,A057MW.selT020,'CODICE');
    C190CaricaMepdMulticolumnComboBox(cmbSiglaTurno1,A057MW.selT021,['SIGLATURNI']);
    C190CaricaMepdMulticolumnComboBox(cmbSiglaTurno2,A057MW.selT021,['SIGLATURNI']);
    cmbCodSquadra.Text:=SelTabella.FieldByName('SQUADRA').AsString;
    lblDescSquadra.Caption:=SelTabella.FieldByName('DESC_SQUADRA').AsString;
    cmbCodTipoOpe.Text:=SelTabella.FieldByName('COD_TIPOOPE').AsString;
    cmbCodOrario.Text:=SelTabella.FieldByName('ORARIO').AsString;
    lblDescOrario.Caption:=SelTabella.FieldByName('DESC_ORARIO').AsString;
    cmbSiglaTurno1.Text:=SelTabella.FieldByName('TURNO1').AsString;
    cmbSiglaTurno2.Text:=SelTabella.FieldByName('TURNO2').AsString;
  end;
end;

end.

