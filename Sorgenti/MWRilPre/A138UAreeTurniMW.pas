unit A138UAreeTurniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Oracle, Data.DB, Graphics,
  OracleData, A000UInterfaccia, A000USessione, A000UCostanti;

type
  TA138StrList = procedure (lista :TStringList) of object;

  TA138FAreeTurniMW = class(TR005FDataModuleMW)
  private
    {$IFDEF IRISWEB}
    SolaLettura:Boolean;
    {$ENDIF}
    Max:Integer;
  public
    selT650: TOracleDataSet;
    procedure selT650BeforeOpen;
    function getColoreCellaWIN(Colore:String):integer;
  end;

implementation

{$R *.dfm}

function TA138FAreeTurniMW.getColoreCellaWIN(Colore: String): integer;
var i:integer;
begin
  Result:=clNone;
  for i:=0 to High(lstColori) do
    if (lstColori[i].Nome = Colore) then
    begin
      Result:=lstColori[i].Numero;
      Break;
    end;
end;

procedure TA138FAreeTurniMW.selT650BeforeOpen;
begin
end;

end.
