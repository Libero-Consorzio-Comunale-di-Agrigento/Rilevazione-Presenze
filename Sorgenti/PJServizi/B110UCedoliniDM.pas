unit B110UCedoliniDM;

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
  System.StrUtils;

type
  TB110FCedoliniDM = class(TR015FDatasnapRestDM)
  private
    FSoloNumeroCedolini: Boolean;
    FDataInizio: TDateTime;
    FDataFine: TDateTime;
    procedure SetDataInizio(Value: TDateTime);
    procedure SetDataFine(Value: TDateTime);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property SoloNumeroCedolini: Boolean read FSoloNumeroCedolini write FSoloNumeroCedolini;
    property DataInizio: TDateTime write SetDataInizio;
    property DataFine: TDateTime write SetDataFine;
  end;

implementation

uses
  A000UInterfaccia,
  W017UStampaCedolinoDM;

{$R *.dfm}

{ TB110FCedoliniDM }

procedure TB110FCedoliniDM.SetDataInizio(Value: TDateTime);
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

procedure TB110FCedoliniDM.SetDataFine(Value: TDateTime);
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

function TB110FCedoliniDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // verifica periodo
  if not TFunzioniGenerali.ControllaPeriodo(FDataInizio,FDataFine,Result.Messaggio) then
    Exit;

  // controlli ok
  Result.Ok:=True;
end;

procedure TB110FCedoliniDM.Esegui(var RRisultato: TRisultato);
var
  W017DM: TW017FStampaCedolinoDM;
  LTable: TFDMemTable;
  LRes: TOutputCedolini;
begin
  W017DM:=TW017FStampaCedolinoDM.Create(nil);
  try
    // apertura del dataset dei cedolini
    W017DM.selP441.Close;
    W017DM.selP441.ClearVariables;
    W017DM.selP441.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
    W017DM.selP441.SetVariable('DATA_CEDOLINO1',FDataInizio);
    W017DM.selP441.SetVariable('DATA_CEDOLINO2',FDataFine);
    W017DM.selP441.SetVariable('WEB_CEDOLINI_GGEMISS',Parametri.WEBCedoliniGGEmiss);
    W017DM.selP441.SetVariable('WEB_CEDOLINI_DATAMIN',Parametri.WEBCedoliniDataMin);
    W017DM.selP441.SetVariable('WEB_CEDOLINI_MMPREC',Parametri.WEBCedoliniMMPrec);
    W017DM.selP441.Open;
    W017DM.selP441.Filtered:=Parametri.WEBCedoliniFilePDF = 'S';

    if FSoloNumeroCedolini then
      LTable:=nil
    else
      LTable:=W017DM.selP441.CloneDataset;

    // prepara risultato servizio
    RRisultato.Output:=TOutputCedolini.Create;
    LRes:=TOutputCedolini(RRisultato.Output);

    if not FSoloNumeroCedolini then
    begin
      LRes.JSONDatasets:=TFDJSONDataSets.Create;
      TFDJSONDataSetsWriter.ListAdd(LRes.JSONDataSets,LTable);

      //--------------------------------------------------------
      RRisultato.JSONDatasets:=LRes.JSONDatasets;
      RRisultato.MemTable:=LTable;
      //--------------------------------------------------------
    end;

    RRisultato.AddInfo(Format('%s dei cedolini disponibili per %s, dal %s al %s',
                              [IfThen(FSoloNumeroCedolini,'Numero','Elenco'),
                               Parametri.MatricolaOper,
                               FDataInizio.ToString,
                               FDataFine.ToString]));
  finally
    FreeAndNil(W017DM);
  end;
end;

end.
