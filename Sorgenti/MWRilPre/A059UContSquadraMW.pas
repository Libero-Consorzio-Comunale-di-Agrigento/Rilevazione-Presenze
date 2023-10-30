unit A059UContSquadraMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  C180FunzioniGenerali, A000USessione;

type
  TA059FContSquadraMW = class(TR005FDataModuleMW)
    dsrT603b: TDataSource;
    selT603a: TOracleDataSet;
    selT603aCODICE: TStringField;
    selT603aDESCRIZIONE: TStringField;
    dsrT603a: TDataSource;
    selT603b: TOracleDataSet;
    selT603bCODICE: TStringField;
    selT603bDESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshDataSet(DataDa,DataA:TDateTime);
  end;

implementation

{$R *.dfm}

procedure TA059FContSquadraMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT603a.SetVariable('DATADA',EncodeDate(1900,1,1));
  selT603a.SetVariable('DATAA',EncodeDate(3999,12,31));
  selT603a.Open;
  selT603b.SetVariable('DATADA',EncodeDate(1900,1,1));
  selT603b.SetVariable('DATAA',EncodeDate(3999,12,31));
  selT603b.Open;
end;

procedure TA059FContSquadraMW.RefreshDataSet(DataDa,DataA:TDateTime);
begin
  R180SetVariable(selT603a,'DATADA',DataDa);
  R180SetVariable(selT603a,'DATAA',DataA);
  selT603a.Open;
  R180SetVariable(selT603b,'DATADA',DataDa);
  R180SetVariable(selT603b,'DATAA',DataA);
  selT603b.Open;
end;

procedure TA059FContSquadraMW.selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('SQUADRE TURNI',DataSet.FieldByName('CODICE').AsString);
end;

end.
