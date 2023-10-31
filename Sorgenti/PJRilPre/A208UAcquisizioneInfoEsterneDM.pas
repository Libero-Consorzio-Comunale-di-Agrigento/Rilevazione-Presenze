unit A208UAcquisizioneInfoEsterneDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione, A000UInterfaccia, OracleData, Oracle,
  Variants, DBClient, A208UAcquisizioneInfoEsterneMW;

type
  TA208FAcquisizioneInfoEsterneDM = class(TDataModule)
    selT036: TOracleDataSet;
    selT036TIMESTAMP: TDateTimeField;
    selT036CODFISCALE: TStringField;
    selT036TIPO: TStringField;
    selT036DATO: TStringField;
    selT036VALORE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A208MW: TA208FAcquisizioneInfoEsterneMW;
  end;

var
  A208FAcquisizioneInfoEsterneDM: TA208FAcquisizioneInfoEsterneDM;

implementation

uses A208UAcquisizioneInfoEsterne;

{$R *.DFM}

procedure TA208FAcquisizioneInfoEsterneDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;

  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;

  A208MW:=TA208FAcquisizioneInfoEsterneMW.Create(Self);
  A208MW.selT036:=selT036;
  A208MW.MaxProgressBar:=A208FAcquisizioneInfoEsterne.MaxProgressBar;
  A208MW.IncrementaProgressBar:=A208FAcquisizioneInfoEsterne.IncrementaProgressBar;
end;

procedure TA208FAcquisizioneInfoEsterneDM.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;

  FreeAndNil(A208MW);
end;

end.





