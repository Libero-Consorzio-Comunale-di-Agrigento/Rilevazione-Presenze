unit A059UContSquadreDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, Oracle,  Variants,
  A059UContSquadraMW;

type
  TA059FContSquadreDtM1 = class(TDataModule)
    selT080: TOracleDataSet;
    selT081: TOracleDataSet;
    selT041a: TOracleDataSet;
    selT041b: TOracleDataSet;
    selT603: TOracleDataSet;
    selT606: TOracleDataSet;
    selT021: TOracleDataSet;
    procedure A059FContSquadreDtM1Create(Sender: TObject);
    procedure A059FContSquadreDtM1Destroy(Sender: TObject);
    procedure selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    A059MW: TA059FContSquadraMW;
  end;

var
  A059FContSquadreDtM1: TA059FContSquadreDtM1;

implementation

uses A059UContSquadre;

{$R *.DFM}

procedure TA059FContSquadreDtM1.A059FContSquadreDtM1Create(Sender: TObject);
var i:Integer;
begin
  if not SessioneOracle.Connected then
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
  A059MW:=TA059FContSquadraMW.Create(Self);
  //Max min squadra / tipo operatore
  selT606.Close;
  selT606.SetVariable('PROGRESSIVO',-1); //Non individuale
  selT606.SetVariable('COD_SQUADRA','');
  selT606.SetVariable('COD_ORARIO','*'); //Tutti gli orari
  selT606.SetVariable('COD_CONDIZIONE','00001'); //Numero teste
  selT606.SetVariable('DATA',Parametri.DataLavoro);
  selT606.SetVariable('COD_GIORNO','*'); //Qualsiasi giorno
  selT606.Open;//Se lo apro solo quando mi serve nella stampa, non vengono stampate le DBText collegate alla prima esecuzione

  selT021.Open;
  with A059FContSquadre do
  begin
    DataInizio:=Parametri.DataLavoro;
    edtDataDa.Text:=DateToStr(DataInizio);
    DataFine:=Parametri.DataLavoro;
    edtDataA.Text:=DateToStr(DataFine);
    A059MW.RefreshDataSet(DataInizio,DataFine);
    dlblDescSquadraDa.DataSource:=A059MW.dsrT603a;
    cmbCodSquadraDa.ListSource:=A059MW.dsrT603a;
    cmbCodSquadraDa.KeyValue:=A059MW.selT603a.FieldByName('Codice').AsString;
    dlblDescSquadraA.DataSource:=A059MW.dsrT603b;
    cmbCodSquadraA.ListSource:=A059MW.dsrT603b;
    cmbCodSquadraA.KeyValue:=A059MW.selT603b.FieldByName('Codice').AsString;
  end;
end;

procedure TA059FContSquadreDtM1.A059FContSquadreDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA059FContSquadreDtM1.selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('SQUADRE TURNI',DataSet.FieldByName('CODICE').AsString);
end;

end.
