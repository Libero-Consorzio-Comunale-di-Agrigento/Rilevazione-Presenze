unit A101URaggrInterrogazioniMW;

interface

uses
  R005UDataModuleMW, System.Classes, Data.DB, SysUtils, OracleData, Oracle, C180FunzioniGenerali,
  A000USessione, A000UInterfaccia
  {$IFDEF ISO},LDBInterno{$ENDIF}
  ;

type
  TA101FRaggrInterrogazioniMW = class(TR005FDataModuleMW)
    selT002: TOracleDataSet;
    seqT005: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    procedure SetSessioneOracle(POracleSession: TOracleSession);
  public
    { Public declarations }
    function GetSeqT005:integer;
  end;

var
  A101FRaggrInterrogazioniMW: TA101FRaggrInterrogazioniMW;

implementation

{$R *.dfm}

procedure TA101FRaggrInterrogazioniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
{$IFDEF ISO}
  SessioneOracleR005:=DBInterno;
  SetSessioneOracle(SessioneOracleR005);
{$ENDIF}
  if Parametri.Applicazione = '' then
    Parametri.Applicazione:={$IFNDEF ISO}'RILPRE'{$ELSE}'ISO'{$ENDIF};
  R180SetVariable(selT002,'APPLICAZIONE',Parametri.Applicazione);
  selT002.Open;
end;

function TA101FRaggrInterrogazioniMW.GetSeqT005:integer;
begin
  seqT005.ClearVariables;
  seqT005.Execute;
  Result:=seqT005.GetVariable('T005ID');
end;

procedure TA101FRaggrInterrogazioniMW.selT002FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('NOME').AsString);
end;

procedure TA101FRaggrInterrogazioniMW.SetSessioneOracle(POracleSession: TOracleSession);
// assegna la sessione oracle indicata agli oggetti di tipo
// - TOracleDataset
// - TOracleQuery
// - TOracleScript
var
  i: Integer;
begin
{$IFNDEF ISO}
  exit;
{$ENDIF}
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
    begin
      // dataset: assegna sessione oracle
      (Components[i] as TOracleDataSet).Session:=POracleSession;
    end
    else if Components[i] is TOracleQuery then
    begin
      // oracle query
      // assegna sessione oracle
     (Components[i] as TOracleQuery).Session:=POracleSession;
    end
    else if Components[i] is TOracleScript then
    begin
      // oracle script
      // assegna sessione oracle
     (Components[i] as TOracleScript).Session:=POracleSession;
    end;
  end;
end;

end.
