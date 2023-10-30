unit W041UQueryServizioDM;

interface

uses
  System.SysUtils, System.Classes, StrUtils, Oracle, OracleData, A000UInterfaccia,
  A062UQueryServizioMW, Data.DB, A000USessione;

type
  TW041FQueryServizioDM = class(TDataModule)
    selT002: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    procedure W041C700MergeSelAnagrafe(ODS:TOracleDataSet);
  public
    { Public declarations }
    Progressivo:Integer;
    TuttiDipSelezionato:Boolean;
    A062MW:TA062FQueryServizioMW;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TW041FQueryServizioDM.DataModuleCreate(Sender: TObject);
var
  i:integer;
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
  A062MW:=TA062FQueryServizioMW.Create(Self);
  A062MW.W041MergeSelAnagrafe:=W041C700MergeSelAnagrafe;
  A062MW.selT002:=selT002;

  A062MW.SelAnagrafe:=nil;
end;

procedure TW041FQueryServizioDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A062MW);
end;

procedure TW041FQueryServizioDM.W041C700MergeSelAnagrafe(ODS:TOracleDataSet);
var FiltroAnag:String;
begin
  if ODS.VariableIndex('C700SelAnagrafe') = -1 then
    exit;
  FiltroAnag:=IfThen(TuttiDipSelezionato,
                     WR000DM.FiltroRicerca,
                     'and T030.PROGRESSIVO = ' + Progressivo.ToString);
  ODS.SetVariable('C700SelAnagrafe',QVistaOracle + ' ' + FiltroAnag);
  if ODS.VariableIndex('DataLavoro') = -1 then
    ODS.DeclareAndSet('DataLavoro',otDate,Parametri.DataLavoro)
  else
    ODS.SetVariable('DataLavoro',Parametri.DataLavoro);
end;

procedure TW041FQueryServizioDM.selT002FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('NOME').AsString);
end;

end.
