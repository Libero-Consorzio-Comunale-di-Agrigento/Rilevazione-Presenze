unit B110UDizionarioDM;

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
  FunzioniGenerali,
  R015UDatasnapRestDM,
  R016UDatasnapRestRichiesteDM,
  W010URichiestaAssenzeDM,
  System.SysUtils, System.Classes, FireDAC.Comp.Client,
  Data.FireDACJSONReflect, System.StrUtils, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, OracleData;

type
  TB110FDizionarioDM = class(TR015FDatasnapRestDM)
    selT275Abilitate: TOracleDataSet;
    selT361: TOracleDataSet;
    selT106: TOracleDataSet;
    selT257: TOracleDataSet;
    selT265: TOracleDataSet;
    selT275: TOracleDataSet;
    selSG101: TOracleDataSet;
    selT040Note: TOracleDataSet;
    selI096: TOracleDataSet;
    procedure selT275AbilitateFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT361FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT265FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    private FTabella: String;
    private FParam1: String;
    private FApplicaFiltroDizionario: Boolean;
    procedure SetTabella(const Value: String);
    procedure SetParam1(const Value: String);
    procedure SetApplicaFiltroDizionario(const Value: Boolean);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property Tabella: String write SetTabella;
    property Param1: String write SetParam1;
    property ApplicaFiltroDizionario: Boolean write SetApplicaFiltroDizionario;
  end;

implementation

{$R *.dfm}

{ TB110FDizionarioDM }

procedure TB110FDizionarioDM.SetTabella(const Value: String);
begin
  FTabella:=Value;
end;

procedure TB110FDizionarioDM.SetParam1(const Value: String);
begin
  FParam1:=Value;
end;

procedure TB110FDizionarioDM.SetApplicaFiltroDizionario(const Value: Boolean);
begin
  FApplicaFiltroDizionario:=Value;
end;

function TB110FDizionarioDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  if FTabella = '' then
  begin
    Result.Messaggio:='La tabella non è stata indicata!';
    Exit;
  end;

  if not TFunzioniGenerali._In(FTabella,B110_DIZ_TAB_ARR) then
  begin
    Result.Messaggio:=Format('La tabella richiesta non è valida: %s!',[FTabella]);
    Exit;
  end;

  Result.Ok:=True;
end;

procedure TB110FDizionarioDM.Esegui(var RRisultato: TRisultato);
var
  LRes: TOutputDizionario;
  LTable: TFDMemTable;
  LInfoDizionario: String;
begin
  if FTabella = B110_DIZ_TAB_I096 then
  begin
    // elenco familiari
    LInfoDizionario:=Format('Elenco livelli per azienda %s, iter %s',[Parametri.Azienda,FParam1]);
    selI096.Close;
    selI096.SetVariable('AZIENDA',Parametri.Azienda);
    selI096.SetVariable('ITER',FParam1);
    selI096.Open;
    LTable:=selI096.CloneDataset;
  end
  else if FTabella = B110_DIZ_TAB_SG101 then
  begin
    // elenco familiari
    LInfoDizionario:=Format('Elenco familiari attivi per il progressivo %d al %s',[Parametri.ProgressivoOper,Date.ToString]);
    selSG101.Close;
    selSG101.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
    selSG101.Open;
    LTable:=selSG101.CloneDataset;
  end
  else if FTabella = B110_DIZ_TAB_T040_NOTE then
  begin
    // note giustificativi
    LInfoDizionario:=Format('Elenco note per richiesta giustificativi',[]);
    //if Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S' then
    begin
      selT040Note.Close;
      selT040Note.Open;
    end;
    LTable:=selT040Note.CloneDataset;
  end
  else if FTabella = B110_DIZ_TAB_T106 then
  begin
    // motivazioni
    if FParam1 = 'T' then
      LInfoDizionario:=Format('Elenco motivazioni per richiesta timbrature',[])
    else if FParam1 = 'T050' then
      LInfoDizionario:=Format('Elenco motivazioni per causali di assenza',[])
    else
      LInfoDizionario:=Format('Elenco motivazioni per dato sconosciuto (%s)',[FParam1]);

    selT106.Close;
    selT106.SetVariable('TIPO',FParam1);
    selT106.Open;
    LTable:=selT106.CloneDataset;
  end
  else if FTabella = B110_DIZ_TAB_T257 then
  begin
    // raggruppamenti di causali
    LInfoDizionario:=Format('Elenco accorpamenti causali alla data di lavoro %s',[Parametri.DataLavoro.ToString]);

    selT257.Close;
    selT257.SetVariable('INDATA',Parametri.DataLavoro);
    selT257.Open;
    LTable:=selT257.CloneDataset;
  end
  else if FTabella = B110_DIZ_TAB_T265 then
  begin
    // causali di assenza
    LInfoDizionario:=Format('Elenco causali di assenza',[]);

    selT265.Close;
    selT265.Filtered:=FApplicaFiltroDizionario;
    selT265.Open;
    LTable:=selT265.CloneDataset;
  end
  else if FTabella = B110_DIZ_TAB_T275 then
  begin
    // causali di presenza
    LInfoDizionario:=Format('Elenco causali di presenza',[]);

    selT275.Close;
    selT275.Filtered:=FApplicaFiltroDizionario;
    selT275.Open;
    LTable:=selT275.CloneDataset;
  end
  else if FTabella = B110_DIZ_TAB_T275_RICHIEDIBILI then
  begin
    // causali di presenza
    LInfoDizionario:=Format('Elenco causali di presenza richiedibili per il progressivo %d alla data di lavoro %s',[Parametri.ProgressivoOper,Parametri.DataLavoro.ToString]);

    selT275Abilitate.Close;
    selT275Abilitate.Filtered:=FApplicaFiltroDizionario;
    selT275Abilitate.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
    selT275Abilitate.SetVariable('DATA',Parametri.DataLavoro);
    selT275Abilitate.Open;
    LTable:=selT275Abilitate.CloneDataset;
  end
  else if FTabella = B110_DIZ_TAB_T361 then
  begin
    // rilevatori
    LInfoDizionario:=Format('Elenco rilevatori',[]);

    selT361.Close;
    selT361.Filtered:=FApplicaFiltroDizionario;
    selT361.Open;
    LTable:=selT361.CloneDataset;
  end
  else
  begin
    LInfoDizionario:='';
    RRisultato.AddError(TErrorCode.InvalidParameter,Format('Il dizionario per la tabella %s non è previsto!',[FTabella]));
    LTable:=nil;
  end;

  // prepara risultato servizio
  RRisultato.Output:=TOutputDizionario.Create;
  LRes:=TOutputDizionario(RRisultato.Output);
  LRes.JSONDatasets:=TFDJSONDataSets.Create;

  // tabella dizionario richiesta
  if Assigned(LTable) and (LTable.Active) then
  begin
    TFDJSONDataSetsWriter.ListAdd(LRes.JSONDatasets,LTable);
    RRisultato.AddInfo(Format('%s: %d record',[LInfoDizionario,LTable.RecordCount]));

    //--------------------------------------------------------
    RRisultato.JSONDatasets:=LRes.JSONDatasets;
    RRisultato.MemTable:=LTable;
    //--------------------------------------------------------
  end;
end;

procedure TB110FDizionarioDM.selT265FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
end;

procedure TB110FDizionarioDM.selT275AbilitateFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if DataSet.FieldByName('TIPO').AsString = 'T275' then
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet.FieldByName('TIPO').AsString = 'T305' then
    Accept:=A000FiltroDizionario('CAUSALI GIUSTIFICAZIONE',DataSet.FieldByName('CODICE').AsString);
end;

procedure TB110FDizionarioDM.selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TB110FDizionarioDM.selT361FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('OROLOGI DI TIMBRATURA',DataSet.FieldByName('CODICE').AsString);
end;

end.
