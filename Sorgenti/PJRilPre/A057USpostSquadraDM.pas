unit A057USpostSquadraDM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, Data.DB, OracleData,
  A057USpostSquadraMW;

type
  TA057FSpostSquadraDM = class(TR004FGestStoricoDtM)
    Q630: TOracleDataSet;
    Q630PROGRESSIVO: TFloatField;
    Q630DATA: TDateTimeField;
    Q630SQUADRA: TStringField;
    Q630ORARIO: TStringField;
    Q630TURNO1: TStringField;
    Q630TURNO2: TStringField;
    Q630DESC_SQUADRA: TStringField;
    Q630DESC_ORARIO: TStringField;
    Q630COD_TIPOOPE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure Q630CalcFields(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure Q630NewRecord(DataSet: TDataSet);
    procedure Q630AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A057MW: TA057FSpostSquadraMW;
  end;

var
  A057FSpostSquadraDM: TA057FSpostSquadraDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA057FSpostSquadraDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(Q630,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePostNoStorico,
                           evBeforeDelete,
                           evAfterPost,
                           evOnTranslateMessage]);
  A057MW:=TA057FSpostSquadraMW.Create(Self);
  A057MW.selT630:=Q630;
  Q630.SetVariable('PROGRESSIVO',0);
  Q630.Open;
end;

procedure TA057FSpostSquadraDM.Q630AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A057MW.selT630AfterScroll;
end;

procedure TA057FSpostSquadraDM.Q630CalcFields(DataSet: TDataSet);
begin
  inherited;
  A057MW.selT630CalcFields;
end;

procedure TA057FSpostSquadraDM.Q630NewRecord(DataSet: TDataSet);
begin
  inherited;
  A057MW.selT630NewRecord;
end;

procedure TA057FSpostSquadraDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A057MW.selT630BeforePost;
end;

end.
