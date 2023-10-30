unit W028UChiamateReperibiliDM;

interface

uses
  A000UCostanti,
  A000USessione,
  A000UInterfaccia,
  C180FunzioniGenerali,
  FunzioniGenerali,
  System.DateUtils,
  SysUtils,
  Classes,
  DB,
  Oracle,
  OracleData,
  DBClient;

type
  TW028FChiamateReperibiliDM = class(TDataModule)
    selT380: TOracleDataSet;
    selT390: TOracleDataSet;
    selT390DATA: TDateTimeField;
    selT390UTENTE: TStringField;
    selT390PROGRESSIVO_REPER: TFloatField;
    selT390ESITO: TStringField;
    selT390NOTE: TStringField;
    selT390DATA_TURNO: TDateTimeField;
    selT390TURNO: TStringField;
    selT390D_SCHEDAANAG: TStringField;
    selT390D_INFO: TStringField;
    selT390OPERATORE: TStringField;
    selT390DIPENDENTE: TStringField;
    selT390D_ESITO: TStringField;
    selT390MATRICOLA: TStringField;
    selT390SIGLA: TStringField;
    selT390InfoChiamate: TOracleDataSet;
    selDatoAgg1Lookup: TOracleDataSet;
    selDatoAgg2Lookup: TOracleDataSet;
    selT651: TOracleDataSet;
    selT650Lookup: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT390AfterOpen(DataSet: TDataSet);
    procedure selT390BeforePost(DataSet: TDataSet);
    procedure selT390AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetAreeAfferenza(Squadra,Operatore:String);
  end;

implementation

{$R *.dfm}

procedure TW028FChiamateReperibiliDM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
  LDataOracle: TDateTime;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  // imposta costante QVistaOracle
  selT380.SetVariable('QVISTAORACLE',StringReplace(QVistaOracle,':DATALAVORO','T380.DATA',[rfReplaceAll,rfIgnoreCase]));
  selT390InfoChiamate.SetVariable('QVISTAORACLE',StringReplace(QVistaOracle,':DATALAVORO','trunc(T390.DATA)',[rfReplaceAll,rfIgnoreCase]));

  // estrae la data dal database server
  LDataOracle:=R180SysDate(SessioneOracle).Date;

  // lookup per dato aggiuntivo 1
  if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '' then
  begin
    if A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1,selDatoAgg1Lookup) then
    begin
      if selDatoAgg1Lookup.VariableIndex('DECORRENZA') >= 0 then
        selDatoAgg1Lookup.SetVariable('DECORRENZA',LDataOracle);
      selDatoAgg1Lookup.Open;
    end;
  end;

  // lookup per dato aggiuntivo 2
  if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '' then
  begin
    if A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2,selDatoAgg2Lookup) then
    begin
      if selDatoAgg2Lookup.VariableIndex('DECORRENZA') >= 0 then
        selDatoAgg2Lookup.SetVariable('DECORRENZA',LDataOracle);
      selDatoAgg2Lookup.Open;
    end;
  end;

  // apro tabella associazione squadre - aree
  selT651.Open;
  selT650Lookup.Open;
end;

procedure TW028FChiamateReperibiliDM.GetAreeAfferenza(Squadra, Operatore: String);
var FiltroT651:String;
begin
  //Filtro DataSet con Aree previste per Squadra / Operatore
  FiltroT651:='((CODICE_SQUADRA = ''' + Squadra + ''')';
  FiltroT651:=FiltroT651 + ' AND (CODICE_OPERATORE = ''' + Operatore + '''))';
  FiltroT651:=FiltroT651 + ' OR ((CODICE_SQUADRA = ''' + Squadra + ''')';
  FiltroT651:=FiltroT651 + ' AND (CODICE_OPERATORE = ''<*>''))';
  selT651.Filtered:=False;
  selT651.Filter:=FiltroT651;
  selT651.Filtered:=True;
end;

procedure TW028FChiamateReperibiliDM.selT390AfterOpen(DataSet: TDataSet);
begin
  (selT390.FieldByName('DATA') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';
end;

procedure TW028FChiamateReperibiliDM.selT390AfterPost(DataSet: TDataSet);
begin
  // salva log
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TW028FChiamateReperibiliDM.selT390BeforePost(DataSet: TDataSet);
begin
  // info per log
  case DataSet.State of
    dsInsert:
      RegistraLog.SettaProprieta('I','T390_CHIAMATE_REPERIB','W028',DataSet,True);
    dsEdit:
      RegistraLog.SettaProprieta('M','T390_CHIAMATE_REPERIB','W028',DataSet,True);
  end;
end;

end.
