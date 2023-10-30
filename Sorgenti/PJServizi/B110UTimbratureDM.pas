unit B110UTimbratureDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  B110USharedTypes,
  B110USharedUtils,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  R015UDatasnapRestDM,
  R016UDatasnapRestRichiesteDM,
  W018URichiestaTimbratureDM,
  System.SysUtils, System.Classes, System.Math, FireDAC.Comp.Client,
  Data.FireDACJSONReflect, System.StrUtils, Data.DB, OracleData;

type
  TB110FTimbratureDM = class(TR015FDatasnapRestDM)
    selVT100: TOracleDataSet;
  private
    FDal: TDateTime;
    FAl: TDateTime;
    procedure SetDal(Value: TDateTime);
    procedure SetAl(Value: TDateTime);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property Dal: TDateTime read FDal write SetDal;
    property Al: TDateTime read FAl write SetAl;
  end;

implementation

{$R *.dfm}

{ TB110FTimbratureDM }

procedure TB110FTimbratureDM.SetAl(Value: TDateTime);
begin
  FAl:=Value;
end;

procedure TB110FTimbratureDM.SetDal(Value: TDateTime);
begin
  FDal:=Value;
end;

function TB110FTimbratureDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=True;
  Result.Messaggio:='';
end;

procedure TB110FTimbratureDM.Esegui(var RRisultato: TRisultato);
var
  LRes: TOutputTimbrature;
  LTableT100: TFDMemTable;
begin
  // elenco timbrature nel periodo richiesto
  selVT100.Close;
  selVT100.ReadBuffer:=Min(500,Trunc(FAl - FDal + 1) * 10);
  selVT100.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
  selVT100.SetVariable('DAL',FDal);
  selVT100.SetVariable('AL',FAl);
  selVT100.Open;
  LTableT100:=selVT100.CloneDataset;

  // prepara risultato servizio
  RRisultato.Output:=TOutputTimbrature.Create;
  LRes:=TOutputTimbrature(RRisultato.Output);
  LRes.JSONDatasets:=TFDJSONDataSets.Create;

  // elenco timbrature
  TFDJSONDataSetsWriter.ListAdd(LRes.JSONDatasets,LTableT100);

  //--------------------------------------------------------
  RRisultato.JSONDatasets:=LRes.JSONDatasets;
  RRisultato.MemTable:=LTableT100;
  //--------------------------------------------------------

  RRisultato.AddInfo(Format('Elenco timbrature: %d record',[LTableT100.RecordCount]));
end;

end.
