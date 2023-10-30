unit B110UCartelliniDM;
// http://localhost:89/datasnap/rest/TB110FServerMethodsDM/Cartellini/AZIN/casa/c/profilo/token/9999/false/2016-01-01/2017-01-01

interface

uses
  A000UCostanti,
  B110USharedTypes,
  B110USharedUtils,
  B110UUtils,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  Data.FireDACJSONReflect,
  System.StrUtils,
  Data.DB,
  OracleData;

type
  TB110FCartelliniDM = class(TR015FDatasnapRestDM)
    selCartellini: TOracleDataSet;
  private
    FSoloNumeroCartellini: Boolean;
    FDataInizio: TDateTime;
    FDataFine: TDateTime;
    procedure SetDataInizio(Value: TDateTime);
    procedure SetDataFine(Value: TDateTime);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property SoloNumeroCartellini: Boolean read FSoloNumeroCartellini write FSoloNumeroCartellini;
    property DataInizio: TDateTime write SetDataInizio;
    property DataFine: TDateTime write SetDataFine;
  end;

implementation

uses
  A000UInterfaccia;

{$R *.dfm}

{ TB110FCartelliniDM }

function TB110FCartelliniDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // verifica periodo
  if not TFunzioniGenerali.ControllaPeriodo(FDataInizio,FDataFine,Result.Messaggio) then
    Exit;

  // controlli ok
  Result.Ok:=True;
end;

procedure TB110FCartelliniDM.SetDataInizio(Value: TDateTime);
var
  LErrMsg: String;
begin
  if Value = DATE_NULL then
    raise EC200InvalidParameter.Create('La data di inizio periodo non è indicata!');

  if (Value < DATE_MIN) or (Value > DATE_MAX) then
    raise EC200InvalidParameter.Create('Indicare una data valida per l''inizio del periodo!');

  if FDataFine <> DATE_NULL then
  begin
    if not TFunzioniGenerali.ControllaPeriodo(Value,FDataFine,LErrMsg) then
      raise EC200InvalidParameter.Create(LErrMsg);
  end;

  FDataInizio:=Value;
end;

procedure TB110FCartelliniDM.SetDataFine(Value: TDateTime);
var
  LErrMsg: String;
begin
  if Value = DATE_NULL then
    raise EC200InvalidParameter.Create('La data di fine periodo non è indicata!');

  if (Value < DATE_MIN) or (Value > DATE_MAX) then
    raise EC200InvalidParameter.Create('Indicare una data valida per la fine del periodo!');

  if FDataInizio <> DATE_NULL then
  begin
    if not TFunzioniGenerali.ControllaPeriodo(FDataInizio,Value,LErrMsg) then
      raise EC200InvalidParameter.Create(LErrMsg);
  end;

  FDataFine:=Value;
end;

procedure TB110FCartelliniDM.Esegui(var RRisultato: TRisultato);
var
  LTable: TFDMemTable;
  LRes: TOutputCartellini;
begin
  // apre il dataset dei cartellini
  selCartellini.Close;
  selCartellini.ClearVariables;
  selCartellini.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
  selCartellini.SetVariable('DATA1',FDataInizio);
  selCartellini.SetVariable('DATA2',FDataFine);
  selCartellini.SetVariable('WEB_CARTELLINI_DATAMIN',Parametri.WEBCartelliniDataMin);
  selCartellini.SetVariable('WEB_CARTELLINI_MMPREC',Parametri.WEBCartelliniMMPrec);
  selCartellini.Open;

  if FSoloNumeroCartellini then
    LTable:=nil
  else
    LTable:=selCartellini.CloneDataset;

  // prepara risultato servizio
  RRisultato.Output:=TOutputCartellini.Create;
  LRes:=TOutputCartellini(RRisultato.Output);

  LRes.NumeroCartellini:=selCartellini.RecordCount;
  if not FSoloNumeroCartellini then
  begin
    LRes.JSONDatasets:=TFDJSONDataSets.Create;
    TFDJSONDataSetsWriter.ListAdd(LRes.JSONDataSets,LTable);

    //--------------------------------------------------------
    RRisultato.JSONDatasets:=LRes.JSONDatasets;
    RRisultato.MemTable:=LTable;
    //--------------------------------------------------------
  end;

  RRisultato.AddInfo(Format('%s dei cartellini disponibili per %s, dal %s al %s',
                            [IfThen(FSoloNumeroCartellini,'Numero','Elenco'),
                             Parametri.MatricolaOper,
                             FDataInizio.ToString,
                             FDataFine.ToString]));
end;

end.
