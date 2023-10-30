unit B110UTimbModificabiliDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  B110USharedTypes,
  B110USharedUtils,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  R016UDatasnapRestRichiesteDM,
  W018URichiestaTimbratureDM,
  System.SysUtils,
  System.Classes,
  Data.DB,
  OracleData,
  FireDAC.Comp.Client,
  Data.FireDACJSONReflect;

type
  TB110FTimbModificabiliDM = class(TR015FDatasnapRestDM)
    selT100ModifTimb: TOracleDataSet;
    selT100ModifTimbDATA: TDateTimeField;
    selT100ModifTimbORA: TStringField;
    selT100ModifTimbVERSO: TStringField;
    selT100ModifTimbFLAG: TStringField;
    selT100ModifTimbCAUSALE: TStringField;
    selT100ModifTimbRILEVATORE: TStringField;
    selT100ModifTimbMATRICOLA: TStringField;
    selT100ModifTimbNOMINATIVO: TStringField;
    selT100ModifTimbDESC_VERSO: TStringField;
    selT100ModifTimbDESC_CAUSALE: TStringField;
    selT100ModifTimbMOTIVAZIONE: TStringField;
    selT100ModifTimbPROGRESSIVO: TFloatField;
    selT100ModifTimbNOTE: TStringField;
    selT100ModifTimbID: TStringField;
  private
    FDataRif: TDateTime;
    procedure SetDataRif(Value: TDateTime);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property DataRif: TDateTime write SetDataRif;
  end;

implementation

{$R *.dfm}

{ TB110FTimbModificabiliDM }

procedure TB110FTimbModificabiliDM.SetDataRif(Value: TDateTime);
begin
  FDataRif:=Value;
end;

function TB110FTimbModificabiliDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=True;
  Result.Messaggio:='';
end;

procedure TB110FTimbModificabiliDM.Esegui(var RRisultato: TRisultato);
var
  LRes: TOutputTimbModificabili;
  LTableT100: TFDMemTable;
begin
  // timbrature modificabili per la data indicata
  selT100ModifTimb.Close;
  selT100ModifTimb.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
  selT100ModifTimb.SetVariable('DATA_RIF',FDataRif);
  selT100ModifTimb.Open;

  LTableT100:=selT100ModifTimb.CloneDataset;

  // prepara risultato servizio
  RRisultato.Output:=TOutputTimbModificabili.Create;
  LRes:=TOutputTimbModificabili(RRisultato.Output);
  LRes.JSONDatasets:=TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(LRes.JSONDatasets,LTableT100);
  RRisultato.AddInfo(Format('Elenco timbrature modificabili del %s: %d record',[FDataRif.ToString,LTableT100.RecordCount]));

  //--------------------------------------------------------
  RRisultato.JSONDatasets:=LRes.JSONDatasets;
  RRisultato.MemTable:=LTableT100;
  //--------------------------------------------------------
end;

end.
