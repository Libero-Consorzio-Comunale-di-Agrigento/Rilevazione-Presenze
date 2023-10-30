unit C014UImpostazioneFiltroDtM;

interface

uses
  SysUtils, Classes, DB, Oracle, OracleData, A000UCostanti, A000USessione, A000UInterfaccia;

type
  TC014FImpostazioneFiltroDtM = class(TDataModule)
    selSQL: TOracleDataSet;
    testSQL: TOracleQuery;
    dsrI010: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    odsAppoggio:TOracleDataset;
  end;

var
  C014FImpostazioneFiltroDtM: TC014FImpostazioneFiltroDtM;

implementation

{$R *.dfm}

procedure TC014FImpostazioneFiltroDtM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
end;

procedure TC014FImpostazioneFiltroDtM.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
end;

end.
