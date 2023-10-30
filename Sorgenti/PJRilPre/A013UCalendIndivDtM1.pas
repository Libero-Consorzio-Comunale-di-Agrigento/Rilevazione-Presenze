unit A013UCalendIndivDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C700USelezioneAnagrafe, Variants, C180FunzioniGenerali, A013UCalendIndivMW;

type
  TA013FCalendIndivDtM1 = class(TDataModule)
    procedure A013FCalendIndivDtM1Create(Sender: TObject);
    procedure A013FCalendIndivDtM1Destroy(Sender: TObject);
  private
  public
    A013MW:TA013FCalendIndivMW;
  end;

var
  A013FCalendIndivDtM1: TA013FCalendIndivDtM1;

implementation

uses A013UCalendIndiv;

{$R *.DFM}

procedure TA013FCalendIndivDtM1.A013FCalendIndivDtM1Create(Sender: TObject);
{Registro il progressivo del dipendente}
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
  A013MW:=TA013FCalendIndivMW.Create(Self);
end;

procedure TA013FCalendIndivDtM1.A013FCalendIndivDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
