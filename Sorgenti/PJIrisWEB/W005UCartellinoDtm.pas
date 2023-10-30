unit W005UCartellinoDtm;

interface

uses
  SysUtils, Classes, DB, OracleData,
  Graphics, SyncObjs, Oracle, A000UInterfaccia,
  A000USessione;

type
  TW005FCartellinoDtm = class(TDataModule)
    selT100: TOracleDataSet;
    selT040: TOracleDataSet;
    selV010: TOracleDataSet;
    selT080: TOracleDataSet;
    Timbrature: TOracleQuery;
    selT050: TOracleDataSet;
    T010F_GGSIGNIFICATIVO: TOracleQuery;
    selT275: TOracleDataSet;
    selT305: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT305FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  end;

implementation

{$R *.dfm}

procedure TW005FCartellinoDtm.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
  selT275.Open;
  selT305.Open;
end;

procedure TW005FCartellinoDtm.selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TW005FCartellinoDtm.selT305FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI GIUSTIFICAZIONE',DataSet.FieldByName('CODICE').AsString);
end;

end.
