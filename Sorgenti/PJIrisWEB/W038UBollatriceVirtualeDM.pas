unit W038UBollatriceVirtualeDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, OracleData, Oracle, A000USessione,
  A000UInterfaccia;

type
  TW038FBollatriceVirtualeDM = class(TDataModule)
    selT361: TOracleDataSet;
    selT275Abilitate: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT275AbilitateFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TW038FBollatriceVirtualeDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
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
  selT361.Open;
end;

procedure TW038FBollatriceVirtualeDM.selT275AbilitateFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
  if DataSet.FieldByName('TIPO').AsString = 'T275' then
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet.FieldByName('TIPO').AsString = 'T305' then
    Accept:=A000FiltroDizionario('CAUSALI GIUSTIFICAZIONE',DataSet.FieldByName('CODICE').AsString);
end;

end.
