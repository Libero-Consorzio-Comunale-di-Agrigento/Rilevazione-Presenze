unit R016UDatasnapRestRichiesteDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  R015UDatasnapRestDM,
  C200UWebServicesTypes,
  B110USharedTypes,
  B110UUtils,
  C018UIterAutDM,
  FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  System.SysUtils, System.Classes, FireDAC.Comp.Client, Data.FireDACJSONReflect,
  OracleData;

type
  TR016FDatasnapRestRichiesteDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
  private
    FSoloNumeroRichieste: Boolean;
    FFiltroRichieste: TFiltriRichieste;
    procedure SetFiltroRichieste(Value: TFiltriRichieste);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure DataSetAfterFetchRecord(Sender: TOracleDataSet; FilterAccept: Boolean; var Action: TAfterFetchRecordAction);
  public
    property SoloNumeroRichieste: Boolean read FSoloNumeroRichieste write FSoloNumeroRichieste;
    property FiltroRichieste: TFiltriRichieste read FFiltroRichieste write SetFiltroRichieste;
  end;

implementation

{$R *.dfm}

procedure TR016FDatasnapRestRichiesteDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FSoloNumeroRichieste:=False;
end;

procedure TR016FDatasnapRestRichiesteDM.SetFiltroRichieste(Value: TFiltriRichieste);
begin
  if Value.FiltroVis = '' then
    raise EC200InvalidParameter.Create('Il filtro richieste non è indicato!');

  if not TFunzioniGenerali._In(Value.FiltroVis,['trDaAutorizzare','trAutorizzate','trNegate']) then
    raise EC200InvalidParameter.CreateFmt('Il valore del filtro richieste indicato non è valido: %s',[Value.FiltroVis]);

  // periodo da
  if (Value.PeriodoDa <> DATE_NULL) and
     (not TFunzioniGenerali.Between(Value.PeriodoDa,DATE_MIN,DATE_MAX)) then
    raise EC200InvalidParameter.CreateFmt('La data di inizio periodo indicata non è valida: %s!',[DateToStr(Value.PeriodoDa)]);

  // periodo a
  if (Value.PeriodoA <> DATE_NULL) and
     (not TFunzioniGenerali.Between(Value.PeriodoA,DATE_MIN,DATE_MAX)) then
    raise EC200InvalidParameter.CreateFmt('La data di fine periodo indicata non è valida: %s!',[DateToStr(Value.PeriodoA)]);

  // limite record
  if Value.LimiteRecord < 0 then
    raise EC200InvalidParameter.CreateFmt('Il limite di richieste indicato non è valido: %d!',[Value.LimiteRecord]);

  FFiltroRichieste:=Value;
end;

procedure TR016FDatasnapRestRichiesteDM.DataSetAfterFetchRecord(Sender: TOracleDataSet;
  FilterAccept: Boolean; var Action: TAfterFetchRecordAction);
begin
  if Sender.RecordCount >= FFiltroRichieste.LimiteRecord then
    Action:=afStop;
end;

function TR016FDatasnapRestRichiesteDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  if FFiltroRichieste = nil then
  begin
    Result.Messaggio:=Format('Le impostazioni per il filtro delle richieste non sono indicate!',[]);
    Exit;
  end;

  // filtro richieste
  if not TFunzioniGenerali._In(FFiltroRichieste.FiltroVis,['trDaAutorizzare','trAutorizzate','trNegate']) then
  begin
    Result.Messaggio:=Format('Il valore del filtro richieste indicato non è valido: %s',[FFiltroRichieste.FiltroVis]);
    Exit;
  end;

  // periodo (solo per richieste autorizzate e negate)
  if TFunzioniGenerali._In(FFiltroRichieste.FiltroVis,['trAutorizzate','trNegate']) then
  begin
    if not TFunzioniGenerali.ControllaPeriodo(FFiltroRichieste.PeriodoDa,FFiltroRichieste.PeriodoA,Result.Messaggio) then
      Exit;
  end;

  // limite numero richieste
  if FFiltroRichieste.LimiteRecord < 0 then
  begin
    Result.Messaggio:=Format('Il limite di richieste indicato non è valido: %d!',[FFiltroRichieste.LimiteRecord]);
    Exit;
  end;

  Result.Ok:=True;
end;

end.
