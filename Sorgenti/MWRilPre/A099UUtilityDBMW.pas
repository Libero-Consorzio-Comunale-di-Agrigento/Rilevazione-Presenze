unit A099UUtilityDBMW;

interface

uses
  SysUtils, Classes, Oracle, DB, OracleData, Variants,
  IOUtils, A000UInterfaccia, A000UCostanti, A000USessione,
  R005UDataModuleMW, Math, StrUtils, C180FunzioniGenerali;

type
  TMyFileStream = class(TFileStream)
  public
    procedure Append(MyStr:string);
  end;

  TExpDati = class
    private
      selCols, //DataSet contenente info sulle colonne
      selTabDati, //DataSet usato per l'estrazione dati
      selTabelleProgressivo, //Elenco tabelle da filtrare per progressivo
      CountTabDati:TOracleDataSet; //Conta numero di record
      ArrInsert:array of string; //"Buffer" x scrittura su HDisk
      PBuffer, OffSetRec:integer; //Dimensione del "Buffer"
      SQLLength, PDimTextLine:integer;
      PPathFile, PFiltroTabella:string;//Percorso file
      LstVariabili:TStringList;
      PSQLDefine:Boolean;
      //procedure d'inizializzazione dei dataset dell'oggetto
      procedure IniSelCols;
      procedure IniSelTabDati;
      procedure IniCountTabDati;
      procedure IniSelTabelleProgressivo;
      //=====================================================
      procedure PutFile_ArrInsert;
      procedure SetFiltroTabella(Val:string);
      procedure SetSQLDefine(Value:boolean);
      function NomiColonne:string;
      function ValoriColonne:string;
      function FormattaValore(Tipo, Valore:string):string;
      function TBLSQL(NomeTabella:string; OffSet:Boolean):string;
    public
      property SQLDefine:boolean read PSQLDefine write SetSQLDefine;
      property DimTextLine:integer read PDimTextLine write PDimTextLine;
      property Buffer:integer read PBuffer write PBuffer;
      property PathFile:string read PPathFile write PPathFile;
      property FiltroTabella:string read PFiltroTabella write SetFiltroTabella;
      function RetCountTabDati(NomeTabella:string):integer; //Function ritorna il totale dei record della tabella
      function Esporta(Tabella:string):string;
      constructor Create;
      destructor Destroy; Override;
  end;

  TExpDB = class
    private
      QrySetProperty:TOracleQuery;
      selInds, selFKeys,
      selObject, selPackAge,
      selKeys, selTabs:TOracleDataSet;
      PPathFileCreate, PPathFileConstr,
      PPathFilePLSql, PPathFileLog:string;
      PFiltroTabelle:string;
      TxtFile:TFile;
      procedure IniQrySetProperty;
      procedure IniSelTabs;
      procedure IniSelInds;
      procedure IniSelFKey;
      procedure IniSelKey;
      procedure IniSelObject;
      procedure IniSelPackAge;
      procedure AttivaFiltroTabelle(ODS:TOracleDataSet);
      procedure SetExpProperty(NomeParametro:string;Valore:Boolean);
      procedure SetPathFile(setParam:string);
      procedure ScriviSuFile(Path,SQL:string);
      procedure SetFiltroTabelle(Valore:string);
      function FormattaFiltroTabelle(Val:string):string;
    public
      ExpDati:TExpDati;
      property Pathfile:string write SetPathFile;
      property PathFileCreate:string read PPathFileCreate;
      property PathFileConstr:string read PPathFileConstr;
      property PathFilePLSql:string read PPathFilePLSql;
      property PathFileLOG:string read PPathFileLog;
      property FiltroTabelle:string read PFiltroTabelle write SetFiltroTabelle;
      procedure RegistraLOG(Testo:string);
      function ExportTables:string;
      function ExportIndexes:string;
      function ExportKeys:string;
      function ExportForeignKeys:string;
      function ExportObjects(OType:string):string;
      function ExportPackages:string;
      constructor Create;
      destructor Destroy; override;
  end;

  TA099FUtilityDBMW = class(TR005FDataModuleMW)
    selTablespace: TOracleDataSet;
    selTablespaceTABLESPACE: TStringField;
    selTablespaceALLOCATO: TStringField;
    selTablespaceUSATO: TStringField;
    selTablespaceDISPONIBILE: TStringField;
    selTablespaceUSATO2: TStringField;
    selTablespaceDISPONIBILE2: TStringField;
    selUserObjects: TOracleDataSet;
    Script: TOracleScript;
    selInd: TOracleDataSet;
    selTabs: TOracleDataSet;
    selSortSegment: TOracleDataSet;
    selLogMsg: TOracleDataSet;
    selIndV430: TOracleDataSet;
    scrIndV430: TOracleScript;
    OperSQL: TOracleQuery;
    selColsP430: TOracleDataSet;
    selCOlsT430: TOracleDataSet;
    selDataFiles: TOracleDataSet;
    selExpAllTab: TOracleDataSet;
    selMEDPV_EXPTAB_DATI: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selDataFilesAfterOpen(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure PreparaIndiciV430Materializzata;
    procedure CreaIndiciV430Materializzata;
  public
    ExportDB:TExpDB;
    procedure OpenSelExpAllTab(Filtro:string = '');
    procedure CostruisciV430(ParametriV430:String = 'DEFAULT');
    procedure LoadLstTabelle(Index:Integer;List:TStrings);
    function ShrinkTable(Table:String):TStrings;
    function DeleteStatistics(Table:String): TStrings;
    function AnalyzeTable(Table:String): TStrings;
    function TableNoParallel(Table:String): TStrings;
    function AnalyzeColumns(Table:String): TStrings;
    function AnalyzeIndexes(Table:String): TStrings;
    function MoveTablespace(Table:String): TStrings;
    function RebuildIndexes(Table:String): TStringList;
    function IndexNoParallel(Table:String): TStringList;
    function GatherTableStats(Table:String): TStrings;
    function GatherSchemaStats: TStrings;
    function DeleteSchemaStats: TStrings;
    function RicompilaOggetto(Tipo,Oggetto:String;Debug,Interpreted,Native,Reuse:Boolean): TStrings;
  end;

implementation

{$R *.dfm}

{Begin Class MyFileStream}

procedure TMyFileStream.Append(MyStr: string);
var
  Buff:TBytes;
begin
  try
    Buff:=TEncoding.ANSI.GetBytes(MyStr);
    Self.Seek(0, TSeekOrigin.soEnd);
    Self.WriteBuffer(Buff, Length(Buff));
  except
    on E: EFileStreamError do
      raise EInOutError.Create(E.Message);
  end;
end;

{End Class MyFileStream}

{Begin Class TExpDB}

procedure TExpDati.IniSelCols;
begin
  selCols:=TOracleDataSet.Create(nil);
  selCols.Session:=SessioneOracle;
  selCols.SQL.Add('select C.COLUMN_NAME, C.DATA_TYPE, C.DATA_LENGTH, C.DATA_PRECISION, C.DATA_SCALE');
  selCols.SQL.Add('  from user_tab_cols C');
  selCols.SQL.Add(' where C.TABLE_NAME = :TABLE_NAME');
  selCols.SQL.Add('   and C.DATA_TYPE not in (''LONG'',''BLOB'',''CLOB'',''RAW'')');
  selCols.SQL.Add('   and C.COLUMN_ID is not null');
  selCols.SQL.Add(' order by C.COLUMN_ID');
  selCols.DeclareVariable('TABLE_NAME',otString);
end;

procedure TExpDati.IniSelTabelleProgressivo;
begin
  selTabelleProgressivo:=TOracleDataSet.Create(nil);
  selTabelleProgressivo.Session:=SessioneOracle;
  selTabelleProgressivo.SQL.Add('select T.TABLE_NAME');
  selTabelleProgressivo.SQL.Add('  from MEDPV_EXPTAB_PROG T');
  selTabelleProgressivo.SQL.Add(' order by T.TABLE_NAME');
end;

function TExpDati.TBLSQL(NomeTabella:string; OffSet:Boolean):string;
//OffSet = False :quando creo SQL per count, ho bisogno del totale record della tabella
var
  ConsideraFiltro:Boolean;
begin
  //Verifico che tabbella sia censita nella vista MEDPV_EXPTAB_PROG(contiene le tabelle da filtrare per progressivo)
  ConsideraFiltro:=selTabelleProgressivo.SearchRecord('TABLE_NAME',NomeTabella,[srFromBeginning]);
  //Selezione anagrafica
  if Not PFiltroTabella.IsEmpty and ConsideraFiltro then
    Result:=NomeTabella + ' T, ' + QVistaOracle + ' and T.PROGRESSIVO = V430.T430PROGRESSIVO and ' + PFiltroTabella
  //Filtro anagrafe - No selezione anagrafica
  else if (Parametri.Inibizioni.Count > 0) and ConsideraFiltro then
    Result:=NomeTabella + ' T, ' + QVistaOracle + ' and T.PROGRESSIVO = V430.T430PROGRESSIVO and ' + Parametri.Inibizioni.Text
  else
  //No filtro anagrafe - No selezione anagrafica
    Result:=NomeTabella + ' T where 1 = 1';
  //Paginazione dati tabella
  if OffSet then
    Result:=Result + ' and ROWNUM < :OFFSET * :CONST';
end;

procedure TExpDati.IniSelTabDati; //Procedure d'inizializzazione dataset *selTabDati*
begin
  selTabDati:=TOracleDataSet.Create(nil);
  selTabDati.Session:=SessioneOracle;
  selTabDati.ReadBuffer:=5000;
  selTabDati.SQL.Add('select *');
  selTabDati.SQL.Add('  from (select T.*, ROWNUM as RNUM');
  selTabDati.SQL.Add('          from :TABELLA)');
  selTabDati.SQL.Add(' where RNUM >= (:OFFSET -1) * :CONST');
  selTabDati.QueryAllRecords:=True;
  //selTabDati.Debug:=DebugHook <> 0;
end;

procedure TExpDati.IniCountTabDati; //Ritorna il numero di record della query
begin
  CountTabDati:=TOracleDataSet.Create(nil);
  CountTabDati.Session:=SessioneOracle;
  CountTabDati.SQL.Add('select count(*) as NUMREC');
  CountTabDati.SQL.Add('  from :TABELLA');
end;

constructor TExpDati.create;
begin
  PBuffer:=1000; //Dimensione array contenente le insert pre inserimento
  PDimTextLine:=2000;
  PSQLDefine:=True;
  OffSetRec:=50000;
  IniSelTabDati;
  IniSelCols;
  IniCountTabDati;
  IniSelTabelleProgressivo;
  try
    selTabelleProgressivo.Open;
  except
  end;
end;

destructor TExpDati.destroy;
begin
  SetLength(ArrInsert,0);
  FreeAndNil(selTabelleProgressivo);
  FreeAndNil(LstVariabili);
  FreeAndNil(CountTabDati);
  FreeAndNil(selTabDati);
  FreeAndNil(selCols);
  inherited;
end;

procedure TExpDati.SetSQLDefine(Value:boolean);
begin
  if Value then
    TFile.AppendAllText(PathFile,'set define on;' + CRLF,TEncoding.ANSI)
  else
    TFile.AppendAllText(PathFile,'set define off;' + CRLF,TEncoding.ANSI);
  PSQLDefine:=Value;
end;

procedure TExpDati.SetFiltroTabella(Val:string);
begin
  PFiltroTabella:=Val.Trim;
end;

function TExpDati.RetCountTabDati(NomeTabella:string):integer;
var
  MySQL:string;
begin
  CountTabDati.Close;
  CountTabDati.DeleteVariables;
  MySQL:=TBLSQL(NomeTabella,False);
  LstVariabili:=FindVariables(MySQL,False);
  CountTabDati.DeclareAndSet('TABELLA',otSubst,MySQL);
  if LstVariabili.IndexOf('DataLavoro') >= 0 then //Gestisco :DataLavoro se c'è una seleezione anagrafica
    CountTabDati.DeclareAndSet('Datalavoro',otDate,Date);
  CountTabDati.Open;
  Result:=CountTabDati.FieldByName('NUMREC').AsInteger;
end;

function TExpDati.NomiColonne:string;
var
  SQLParte:string;
begin
  Result:='';
  SQLParte:='';
  selCols.First;
  while Not selCols.Eof do
  begin
    SQLParte:=selCols.FieldByName('COLUMN_NAME').AsString;
    //Result:=Result + selCols.FieldByName('COLUMN_NAME').AsString;
    selCols.Next;
    //Gestione virgola e a capo automatico se length riga è maggiore di PDimTextLine
    if Not selCols.Eof then
      SQLParte:=SQLParte + ', ';

    SQLLength:=SQLLength + Length(SQLParte);
    if SQLLength + Length(selCols.FieldByName('COLUMN_NAME').AsString + ', ') >= PDimTextLine then
    begin
      SQLParte:=SQLParte + CRLF;
      SQLLength:=0;
    end;
    //==========================================================================
    Result:=Result + SQLParte;
  end;
end;

function TExpDati.FormattaValore(Tipo, Valore:string):string;
begin
  Result:=Valore.Trim;
  if Not Valore.IsEmpty then
  begin
    if Tipo = 'DATE' then
    begin
      if Valore.Length <= 10 then
        Result:='to_date(''' + Valore + ''',''DD/MM/YYYY'')'
      else
        Result:='to_date(''' + Valore + ''',''DD/MM/YYYY HH24.MI.SS'')';
    end
    else if Tipo = 'VARCHAR2' then
    begin
      Result:='''' + Valore.Replace('''','''''',[rfReplaceAll]) + '''';
      Result:=Result.Replace(CRLF,'''' + CRLF + '||chr(13)||chr(10)||''',[rfReplaceAll]); //Sostituisco ritorno a capo con spazi
    end
    else if Tipo = 'NUMBER' then
      Result:=Result.Replace(',','.',[rfReplaceAll]);
  end
  else
    Result:='null';
end;

function TExpDati.ValoriColonne:string;
var
  SQLParte, SQLValore:string;
begin
  Result:='';
  SQLParte:='';
  SQLValore:='';
  selCols.First;
  while Not selCols.Eof do
  begin
    SQLValore:=selTabDati.FieldByName(selCols.FieldByName('COLUMN_NAME').AsString).AsString;
    SQLParte:=FormattaValore(selCols.FieldByName('DATA_TYPE').AsString, SQLValore);
    selCols.Next;
    if Not selCols.Eof then
      SQLParte:=SQLParte + ', ';

    SQLLength:=SQLLength + Length(SQLParte);
    SQLValore:=selTabDati.FieldByName(selCols.FieldByName('COLUMN_NAME').AsString).AsString;
    if SQLLength + Length(FormattaValore(selCols.FieldByName('DATA_TYPE').AsString, SQLValore) + ', ') >= PDimTextLine then
    begin
      SQLParte:=SQLParte + CRLF;
      SQLLength:=0;
    end;
    Result:=Result + SQLParte;
  end;
end;

procedure TExpDati.PutFile_ArrInsert;
var
  i:integer;
  MyStream:TMyFileStream;
  TempStr:string;
  ErroreFile:boolean;
begin
  try
    i:=0;
    repeat
      ErroreFile:=False;
      try
        MyStream:=TMyFileStream.Create(PPathFile,fmOpenReadWrite);
      except
        ErroreFile:=True;
        inc(i);
        Sleep(1000);
      end;
    until (Not ErroreFile) or (i >= 10);

    if i >= 10 then
      raise Exception.Create('Impossibile aprire il file.');
    i:=Low(ArrInsert);
    while (i <= High(ArrInsert)) and
          (Not ArrInsert[i].IsEmpty) do
    begin
      TempStr:=ArrInsert[i] + CRLF;
      MyStream.Append(TempStr);
      inc(i);
    end;
    TempStr:='commit;' + CRLF;
    MyStream.Append(TempStr);
  finally
    FreeAndNil(MyStream);
  end;
end;

function TExpDati.Esporta(Tabella:string):string;
var
  SQL:string;
  i, PagRec ,TotRecord,
  TotaleParziale:integer;
begin
  Result:='';
  try
    SetLength(ArrInsert,PBuffer); //Inizializzo lunghezza "Buffer"
    TotRecord:=RetCountTabDati(Tabella); //Numero totale di record
    //Gestione inizializzazione e apertura DataSet selTabDati
    selTabDati.Close;
    selTabDati.DeleteVariables;
    SQL:=TBLSQL(Tabella,True); //SQL parziale join SQL fisso e SQL dinamico
    selTabDati.DeclareAndSet('TABELLA',otSubst,SQL);
    selTabDati.DeclareAndSet('CONST',otInteger,OffSetRec); //Numero MAX di record da estrarre ogni volta
    selTabDati.DeclareAndSet('OFFSET',otInteger,1); //Variabile scorrimento offset
    //Inizializzazione DataSet selTabDati(query paginata)
    LstVariabili:=FindVariables(SQL,False); //Scan variabili
    if LstVariabili.IndexOf('DataLavoro') >= 0 then
      selTabDati.DeclareAndSet('DataLavoro',otDate,Date);
    //DataSet contenente informazioni necessarie per esportare le colonne
    selCols.Close;
    selCols.SetVariable('TABLE_NAME',Tabella);
    selCols.Open;
    //FileCreate(PathFile);
    PagRec:=1;
    TotaleParziale:=0;
    while TotaleParziale < TotRecord do
    begin
      selTabDati.Close;
      selTabDati.SetVariable('OFFSET',PagRec); //Variabile scorrimento offset
      selTabDati.Open;
      TotaleParziale:=TotaleParziale + selTabDati.RecordCount;
      i:=Low(ArrInsert);
      while Not selTabDati.Eof do
      begin
        SQLLength:=Length('insert into ' + Tabella.ToUpper + '(');
        SQL:='insert into ' + Tabella.ToUpper + '(' + NomiColonne + ') ';
        SQLLength:=SQLLength + Length(')' + CRLF + 'values(');
        SQL:=SQL + 'values(' + ValoriColonne + ');';
        ArrInsert[i]:=SQL;
        inc(i);
        if i > High(ArrInsert) then
        begin
          PutFile_ArrInsert;
          SetLength(ArrInsert,0);
          SetLength(ArrInsert,PBuffer);
          i:=Low(ArrInsert);
        end;
        selTabDati.Next;
      end;
      PutFile_ArrInsert;
      inc(PagRec);
    end;
    SetLength(ArrInsert,0);
    Result:=Format('    %d righe esportate.',[TotRecord]);
  except
  on e:exception do
    Result:=e.Message;
  end;
end;

{End Class TExpDB}

{Begin Class TExpDB}

constructor TExpDB.Create;
begin
  inherited;
  IniQrySetProperty;
  //Disabilita tutti i parametri di storage
  SetExpProperty('SEGMENT_ATTRIBUTES',False);
  //Aggiunge ";" alla fine dell'istruzione SQL
  SetExpProperty('SQLTERMINATOR',True);
  //Non esporta le chiavi
  SetExpProperty('CONSTRAINTS',False);
  //Non esporta le foreign key
  SetExpProperty('REF_CONSTRAINTS',False);
  ExpDati:=TExpDati.Create;
  IniSelTabs;
  IniSelInds;
  IniSelKey;
  IniSelFKey;
  IniSelObject;
  IniSelPackAge;
end;

destructor TExpDB.Destroy;
begin
  FreeAndNil(ExpDati);
  FreeAndNil(selTabs);
  FreeAndNil(selInds);
  FreeAndNil(selFKeys);
  FreeAndNil(selKeys);
  FreeAndNil(selObject);
  FreeAndNil(selPackAge);
  FreeAndNil(QrySetProperty);
  inherited;
end;

procedure TExpDB.IniQrySetProperty;
begin
  QrySetProperty:=TOracleQuery.Create(nil);
  QrySetProperty.Session:=SessioneOracle;
  QrySetProperty.SQL.Add('begin');
  QrySetProperty.SQL.Add('  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,:NOME_PARAMETRO,:VALORE_PARAMETRO);');
  QrySetProperty.SQL.Add('end;');
  QrySetProperty.DeclareVariable('NOME_PARAMETRO',otString);
  QrySetProperty.DeclareVariable('VALORE_PARAMETRO',otSubst);
end;

procedure TExpDB.SetExpProperty(NomeParametro:string;Valore:boolean);
begin
  QrySetProperty.SetVariable('NOME_PARAMETRO',NomeParametro);
  if Valore then
    QrySetProperty.SetVariable('VALORE_PARAMETRO','true')
  else
    QrySetProperty.SetVariable('VALORE_PARAMETRO','false');
  QrySetProperty.Execute;
end;

procedure TExpDB.IniSelKey;
begin
  selKeys:=TOracleDataSet.Create(nil);
  selKeys.Session:=SessioneOracle;
  selKeys.QueryAllRecords:=False;
  selKeys.SQL.Add('select T.CONSTRAINT_NAME, DBMS_METADATA.GET_DDL(''CONSTRAINT'', T.CONSTRAINT_NAME) DDL_CONSTRAINT');
  selKeys.SQL.Add('  from user_constraints T');
  selKeys.SQL.Add(' where T.CONSTRAINT_TYPE <> ''R''');
  selKeys.SQL.Add('   and not exists (select ''X''');
  selKeys.SQL.Add('                     from user_recyclebin');
  selKeys.SQL.Add('                    where OBJECT_NAME = T.TABLE_NAME)');
  selKeys.SQL.Add('      :FILTRO');
  selKeys.SQL.Add(' order by T.CONSTRAINT_NAME');
  selKeys.DeclareVariable('FILTRO',otSubst);
end;

procedure TExpDB.IniSelFKey;
begin
  selFKeys:=TOracleDataSet.Create(nil);
  selFKeys.Session:=SessioneOracle;
  selFKeys.SQL.Add('select T.CONSTRAINT_NAME, DBMS_METADATA.GET_DDL(''REF_CONSTRAINT'',T.CONSTRAINT_NAME) DDL_CONSTRAINT');
  selFKeys.SQL.Add('  from user_constraints T');
  selFKeys.SQL.Add(' where T.CONSTRAINT_TYPE = ''R''');
  selFKeys.SQL.Add('   and not exists (select ''X''');
  selFKeys.SQL.Add('                     from user_recyclebin');
  selFKeys.SQL.Add('                    where OBJECT_NAME = T.TABLE_NAME)');
  selFKeys.SQL.Add('       :FILTRO');
  selFKeys.SQL.Add(' order by T.CONSTRAINT_NAME');
  selFKeys.DeclareVariable('FILTRO',otSubst);
end;

procedure TExpDB.IniSelTabs;
begin
  selTabs:=TOracleDataSet.Create(nil);
  selTabs.QueryAllRecords:=False;
  selTabs.Session:=SessioneOracle;
  selTabs.SQL.Add('select T.TABLE_NAME, DBMS_METADATA.GET_DDL(''TABLE'',T.TABLE_NAME) DDL_TABLE');
  selTabs.SQL.Add('  from user_tables T');
  selTabs.SQL.Add(' where not exists(select ''X''');
  selTabs.SQL.Add('                    from user_recyclebin');
  selTabs.SQL.Add('                   where OBJECT_NAME = T.TABLE_NAME)');
  selTabs.SQL.Add('       :FILTRO');
  selTabs.SQL.Add(' order by T.TABLE_NAME');
  selTabs.DeclareVariable('FILTRO',otSubst);
  //selTabs.Debug:=DebugHook <> 0;
end;

procedure TExpDB.IniSelInds;
begin
  selInds:=TOracleDataSet.Create(nil);
  selInds.Session:=SessioneOracle;
  selInds.SQL.Add('select T.INDEX_NAME, DBMS_METADATA.GET_DDL(''INDEX'',T.INDEX_NAME) DDL_INDEX');
  selInds.SQL.Add('  from user_indexes T');
  selInds.SQL.Add(' where T.GENERATED = ''N''');
  selInds.SQL.Add('       :FILTRO');
  selInds.SQL.Add(' order by T.INDEX_NAME');
  selInds.DeclareVariable('FILTRO',otSubst);
end;

procedure TExpDB.IniSelObject;
begin
  selObject:=TOracleDataSet.Create(nil);
  selObject.Session:=SessioneOracle;
  selObject.SQL.Add('select T.OBJECT_NAME, T.OBJECT_TYPE, DBMS_METADATA.GET_DDL(T.OBJECT_TYPE, T.OBJECT_NAME) DLL_OBJECT');
  selObject.SQL.Add('  from user_objects T');
  selObject.SQL.Add(' where T.OBJECT_TYPE = :OBJECT_TYPE');
  selObject.SQL.Add(' order by T.OBJECT_NAME');
  selObject.DeclareVariable('OBJECT_TYPE',otString);
end;

procedure TExpDB.IniSelPackAge;
begin
  selPackAge:=TOracleDataSet.Create(nil);
  selPackAge.Session:=SessioneOracle;
  selPackAge.SQL.Add('select T.OBJECT_NAME, T.OBJECT_TYPE,');
  selPackAge.SQL.Add('       DBMS_METADATA.GET_DDL(''PACKAGE_BODY'', T.OBJECT_NAME) DLL_PACKAGE_BODY,');
  selPackAge.SQL.Add('       DBMS_METADATA.GET_DDL(''PACKAGE'', T.OBJECT_NAME) DLL_PACKAGE');
  selPackAge.SQL.Add('  from user_objects T');
  selPackAge.SQL.Add(' where T.OBJECT_TYPE in (''PACKAGE_BODY'',''PACKAGE'')');
  selPackAge.SQL.Add(' order by T.OBJECT_NAME')
end;

function TExpDB.FormattaFiltroTabelle(Val:string):string;
begin
  Result:='''' + Val.Replace(',',''',''',[rfReplaceAll]) + '''';
end;

procedure TExpDB.SetPathFile(setParam:string);
var
  MyExt, Value:string;
begin
  Value:=setParam.Trim;
  if not DirectoryExists(ExtractFilePath(Value)) then
    raise Exception.Create('Percorso file inesistente.');
  MyExt:=ExtractFileExt(Value);

  PPathFileCreate:=Value;
  PPathFileCreate.Insert(pos(MyExt,Value) - 1,'_CREATE');

  ExpDati.PPathFile:=Value;
  ExpDati.PPathFile.Insert(pos(MyExt,Value) - 1,'_DATI');

  PPathFileConstr:=Value;
  PPathFileConstr.Insert(pos(MyExt,Value) - 1,'_CONSTRAINT');

  PPathFilePLSql:=Value;
  PPathFilePLSql.Insert(pos(MyExt,Value) - 1,'_PLSQL');

  PPathFileLog:=Value.Replace(MyExt,'') + '_LOG.log'
end;

procedure TExpDB.AttivaFiltroTabelle(ODS:TOracleDataSet);
begin
  ODS.Close;
  if Not PFiltroTabelle.IsEmpty then
    ODS.SetVariable('FILTRO','and T.TABLE_NAME in (' + FormattaFiltroTabelle(PFiltroTabelle) + ')')
  else
    ODS.SetVariable('FILTRO','and T.TABLE_NAME in (select TABLE_NAME from MEDPV_EXPTAB_DDL)');
  try
    ODS.Open;
  except
    on e:exception do
      RegistraLOG(Format('Errore %s: %s',[ODS.Name, e.Message]));
  end;
end;

procedure TExpDB.ScriviSuFile(Path,SQL:string);
begin
  SQL:=StringReplace(SQL,'"' + Parametri.Username.ToUpper + '".','',[rfReplaceAll]);
  TxtFile.AppendAllText(Path,SQL,TEncoding.ANSI);
end;

procedure TExpDB.RegistraLOG(Testo:string);
begin
  if Not PPathFileLog.IsEmpty then
  begin
    try
      TFile.AppendAllText(PPathFileLog,Format('%s %s' + CRLF,[FormatDateTime('DD-MM-YYYY HH.MM.SS',Now), Testo]),TEncoding.ANSI);
    except
    end;
  end;
end;

procedure TExpDB.SetFiltroTabelle(Valore:string);
begin
  PFiltroTabelle:=Valore.Trim;
  if Not PFiltroTabelle.IsEmpty then
    RegistraLOG('Filtro tabelle applicato: ' + PFiltroTabelle)
  else
    RegistraLOG('Filtro tabelle applicato: TUTTE');
end;

function TExpDB.ExportTables:string;
var
  DDL_Table:string;
begin
  AttivaFiltroTabelle(selTabs);
  while Not selTabs.Eof do
  begin
    RegistraLOG(Format('  Esportazione tabella: %s',[selTabs.FieldByName('TABLE_NAME').AsString]));
    try
      DDL_Table:=selTabs.FieldByName('DDL_TABLE').AsString;
      DDL_Table:=StringReplace(DDL_Table,'/*--NOLOG--*/','',[rfReplaceAll]);
      DDL_Table:=StringReplace(DDL_Table,CRLF + CRLF,CRLF,[rfReplaceAll]);
      ScriviSuFile(PPathFileCreate,DDL_Table);
    except
    on e:Exception do
      RegistraLOG(Format('  Errore %s: %s',[selTabs.FieldByName('TABLE_NAME').AsString, e.Message]));
    end;
    selTabs.Next;
  end;
end;

function TExpDB.ExportIndexes:string;
begin
  RegistraLOG('<Inizio esportazione indici>');
  AttivaFiltroTabelle(selInds);
  while not selInds.Eof do
  begin
    RegistraLOG(Format('  Esportazione indice: %s', [selInds.FieldByName('INDEX_NAME').AsString]));
    try
      ScriviSuFile(PPathFileConstr,selInds.FieldByName('DDL_INDEX').AsString);
    except
    on e:Exception do
      RegistraLOG(Format('  Errore %s: %s',[selInds.FieldByName('INDEX_NAME').AsString, e.Message]));
    end;
    selInds.Next;
  end;
  RegistraLOG('<Fine esportazione indici>');
end;

function TExpDB.ExportKeys:string;
begin
  RegistraLOG('<Inizio esportazione chiavi>');
  AttivaFiltroTabelle(selKeys);
  while not selKeys.Eof do
  begin
    RegistraLOG(Format('  Esportazione chiave: %s', [selKeys.FieldByName('CONSTRAINT_NAME').AsString]));
    try
      ScriviSuFile(PPathFileConstr,selKeys.FieldByName('DDL_CONSTRAINT').AsString);
    except
    on e:exception do
      RegistraLOG(Format('  Errore %s: %s',[selInds.FieldByName('CONSTRAINT_NAME').AsString, e.Message]));
    end;
    selKeys.Next;
  end;
  RegistraLOG('<Fine esportazione chiavi>');
end;

function TExpDB.ExportforeignKeys:string;
begin
  RegistraLOG('<Inizio esportazione chiavi esterne>');
  AttivaFiltroTabelle(selFKeys);
  while not selFKeys.Eof do
  begin
    RegistraLOG(Format('  Esportazione chiave esterna: %s', [selFKeys.FieldByName('CONSTRAINT_NAME').AsString]));
    try
      ScriviSuFile(PPathFileConstr,selFKeys.FieldByName('DDL_CONSTRAINT').AsString);
    except
    on e:exception do
      RegistraLOG(Format('  Errore %s: %s',[selInds.FieldByName('CONSTRAINT_NAME').AsString, e.Message]));
    end;
    selFKeys.Next;
  end;
  RegistraLOG('<Fine esportazione chiavi esterne>');
end;

function TExpDB.ExportObjects(OType:string):string;
begin
  RegistraLOG(Format('<Inizio esportazione %s>',[OType]));
  try
    selObject.Close;
    selObject.SetVariable('OBJECT_TYPE',OType.ToUpper);
    selObject.Open;
  except
  on e:exception do
    RegistraLOG(Format('Errore %s: %s',[selObject.Name, e.Message]));
  end;
  while Not selObject.Eof do
  begin
    RegistraLOG(Format('  Esportazione %s: %s', [OType, selObject.FieldByName('OBJECT_NAME').AsString]));
    try
      ScriviSuFile(PPathFilePLSql,selObject.FieldByName('DLL_OBJECT').AsString);
    except
    on e:exception do
      RegistraLOG(Format('  Errore %s: %s',[selObject.FieldByName('COBJECT_NAME').AsString, e.Message]));
    end;
    selObject.Next;
  end;
  RegistraLOG(Format('<Fine esportazione %s>',[OType]));
end;

function TExpDB.ExportPackAges:string;
begin
  RegistraLOG('<Inizio esportazione PACKAGE>');
  try
    selPackAge.Open;
  except
  on e:exception do
    RegistraLOG(Format('Errore %s: %s',[selPackAge.Name, e.Message]));
  end;
  selPackAge.First;
  while not selPackAge.Eof do
  begin
    RegistraLOG(Format('  Esportazione package: %s', [selPackAge.FieldByName('OBJECT_NAME').AsString]));
    try
      ScriviSuFile(PPathFilePLSql,selPackAge.FieldByName('DLL_PACKAGE').AsString);
      ScriviSuFile(PPathFilePLSql,selPackAge.FieldByName('DLL_PACKAGE_BODY').AsString);
    except
    on e:exception do
      RegistraLOG(Format('  Errore package: %s',[e.Message]));
    end;
    selPackAge.Next;
  end;
  RegistraLOG('<Fine esportazione PACKAGE>');
end;

{End Class TExpDB}

procedure TA099FUtilityDBMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ExportDB:=TExpDB.Create;
  Script.Session:=SessioneOracle;
  OpenSelExpAllTab;
end;

procedure TA099FUtilityDBMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ExportDB);
end;

procedure TA099FUtilityDBMW.OpenSelExpAllTab(Filtro:string = '');
begin
  selExpAllTab.Close;
  if not Filtro.IsEmpty then
    selExpAllTab.SetVariable('FILTRO',Filtro)
  else
    selExpAllTab.SetVariable('FILTRO',null);
  try
    selExpAllTab.Open;
  except
  end;
end;

function TA099FUtilityDBMW.ShrinkTable(Table:String):TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;
   Script.Lines.Add('ALTER TABLE ' + Table + ' ENABLE ROW MOVEMENT;');
   Script.Lines.Add('ALTER TABLE ' + Table + ' SHRINK SPACE CASCADE;');
   Script.Lines.Add('ALTER TABLE ' + Table + ' DISABLE ROW MOVEMENT;');
   Script.Execute;
   Result:=Script.Output;
end;

procedure TA099FUtilityDBMW.LoadLstTabelle(Index:Integer;List:TStrings);
begin
  List.Clear;
  with selTabs do
  begin
    Close;
    SQL.Clear;
    case Index of
      0:SQL.Add('SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME');
      1:SQL.Add('SELECT TABLE_NAME FROM TABS MINUS SELECT TABLE_NAME FROM IND ORDER BY TABLE_NAME');
      2:SQL.Add('SELECT TABLE_NAME FROM TABS MINUS SELECT TABLE_NAME FROM USER_CONSTRAINTS WHERE CONSTRAINT_TYPE = ''P'' ORDER BY TABLE_NAME');
      3:SQL.Add('SELECT TABLE_NAME FROM TABS WHERE TABLESPACE_NAME <> ''' + Parametri.TSLavoro + ''' ORDER BY TABLE_NAME');
      4:SQL.Add('SELECT DISTINCT TABLE_NAME FROM IND WHERE TABLESPACE_NAME <> ''' + Parametri.TSIndici + ''' ORDER BY TABLE_NAME');
    end;
    Open;
    while not Eof do
    begin
      List.Add(FieldByName('TABLE_NAME').AsString);
      Next;
    end;
  end;
end;

function TA099FUtilityDBMW.DeleteStatistics(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ANALYZE TABLE ' + Table + ' DELETE STATISTICS;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.TableNoParallel(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ALTER TABLE ' + Table + ' NOPARALLEL;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.AnalyzeTable(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ANALYZE TABLE ' + Table + ' COMPUTE  STATISTICS FOR TABLE;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.AnalyzeColumns(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ANALYZE TABLE ' + Table + ' COMPUTE  STATISTICS FOR ALL COLUMNS;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.AnalyzeIndexes(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ANALYZE TABLE ' + Table + ' COMPUTE  STATISTICS FOR ALL INDEXES;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.MoveTablespace(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;
   Script.Lines.Add('ALTER TABLE ' + Table + ' MOVE TABLESPACE ' + Parametri.TSLavoro + ';');
   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.RebuildIndexes(Table:String): TStringList;
begin
  Result:=TStringList.Create;
  with selInd do
  begin
    SetVariable('TABLE_NAME',Table);
    Close;
    Open;
    while not Eof do
    begin
      Script.Lines.Clear;
      Script.Output.Clear;
      Script.Lines.Add('ALTER INDEX ' + FieldByName('INDEX_NAME').AsString + ' REBUILD NOPARALLEL TABLESPACE ' + Parametri.TSIndici);
      Script.Execute;
      Result.AddStrings(Script.Output);
      Next;
    end;
  end
end;

function TA099FUtilityDBMW.IndexNoParallel(Table:String): TStringList;
begin
  Result:=TStringList.Create;
  with selInd do
  begin
    SetVariable('TABLE_NAME',Table);
    Close;
    Open;
    while not Eof do
    begin
      Script.Lines.Clear;
      Script.Output.Clear;
      Script.Lines.Add('ALTER INDEX ' + FieldByName('INDEX_NAME').AsString + ' NOPARALLEL');
      Script.Execute;
      Result.AddStrings(Script.Output);
      Next;
    end;
  end
end;

function TA099FUtilityDBMW.GatherTableStats(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add(Format('begin dbms_stats.gather_table_stats(ownname=>''%s'',tabname=>''%s'',cascade=>True); end;',[Parametri.Username,Table]));

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.GatherSchemaStats: TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add(Format('begin dbms_stats.gather_schema_stats(ownname=>''%s'',cascade=>True); end;',[Parametri.Username]));

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.DeleteSchemaStats: TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add(Format('begin dbms_stats.delete_schema_stats(ownname=>''%s''); end;',[Parametri.Username]));

   Script.Execute;
   Result:=Script.Output;
end;


function TA099FUtilityDBMW.RicompilaOggetto(Tipo,Oggetto:String;Debug,Interpreted,Native,Reuse:Boolean): TStrings;
begin
  Script.Lines.Clear;
  Script.Output.Clear;
  Script.Lines.Add(Format('ALTER %s %s COMPILE%s%s%s%s;',[Trim(Tipo),Trim(Oggetto),IfThen(Debug,' DEBUG',''),IfThen(Native,' PLSQL_CODE_TYPE=NATIVE',''),IfThen(Interpreted,' PLSQL_CODE_TYPE=INTERPRETED',''),IfThen(Reuse,' REUSE SETTINGS','')]));
  Script.Execute;
  Result:=Script.Output;
end;

procedure TA099FUtilityDBMW.selDataFilesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  selDataFiles.FieldByName('FILE_NAME').DisplayWidth:=80;
end;

procedure TA099FUtilityDBMW.CostruisciV430(ParametriV430:String = 'DEFAULT');
var i,IDQ,IDCA,IDC,IDT,IDJ:SmallInt;
    Campo,CampoPos,Alias,AliasPos:String;
    NomeColonna,Tabella,Codice,Storico:String;
    (*Q430Campi,*)CampiAlias,Campi,Tabelle,Join:array of String;
    Suf:Char;
  function NonEsisteInArray(S:String; A:array of String):Boolean;
  var i:Integer;
  begin
    Result:=True;
    for i:=0 to High(A) do
     if Pos(S,A[i] + ',') > 0 then
     begin
       Result:=False;
       Break;
     end;
  end;
{Costruisco la frase SQL per costruire la vista dei dati storici sulla base della struttura di Q430}
begin
  if ParametriV430 = 'DEFAULT' then
    ParametriV430:=Parametri.V430;
  IDCA:=0;
  IDC:=0;
  IDT:=0;
  IDQ:=0;
  IDJ:=0;
  //SetLength(Q430Campi,1);
  SetLength(CampiAlias,1);
  SetLength(Campi,1);
  SetLength(Tabelle,1);
  SetLength(Join,1);
  //Q430Campi[0]:='';
  CampiAlias[0]:='';
  Campi[0]:='';
  Tabelle[0]:='';
  Join[0]:='';
  selColsT430.Close;
  selColsT430.Open;
  //for i:=0 to Q430.FieldCount - 1 do
  while not selColsT430.Eof do
  begin
    NomeColonna:=selColsT430.FieldByName('COLUMN_NAME').AsString;
    A000GetTabella(NomeColonna,Tabella,Codice,Storico);
    if Tabella = '' then
    begin
      selColsT430.Next;
      Continue;
    end;

    if Length(CampiAlias[IDCA]) > 800 then
    begin
      Inc(IDCA);
      SetLength(CampiAlias,IDCA + 1);
    end;
    CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430' + NomeColonna;
    if Tabella <> 'T430_STORICO' then
    begin
      if NomeColonna = 'PERSELASTICO' then
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430D_TIPOCART'
      else
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430D_' + NomeColonna;
      // per il comune di residenza e di domicilio aggiunge anche la provincia
      if NomeColonna = 'COMUNE' then
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430D_PROVINCIA'
      else if NomeColonna = 'COMUNE_DOM_BASE' then
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430D_PROVINCIA_DOM_BASE';
    end;
    //Alberto 21/12/2005: uniformazione delle decorrenze tra T430 e P430
    if (ParametriV430 = 'P430') and (UpperCase(NomeColonna) = 'DATADECORRENZA') then
      Campo:='NVL(GREATEST(T430.DATADECORRENZA,P430.DECORRENZA),T430.DATADECORRENZA)'
    else if (ParametriV430 = 'P430') and (UpperCase(NOmeColonna) = 'DATAFINE') then
      Campo:='NVL(LEAST(T430.DATAFINE,P430.DECORRENZA_FINE),T430.DATAFINE)'
    else
      Campo:='T430.' + NomeColonna;
    //if Length(Q430Campi[IDQ]) > 800 then
    if Length(Campi[IDQ]) > 800 then
    begin
      Inc(IDQ);
      //SetLength(Q430Campi,IDQ + 1);
      SetLength(Campi,IDQ + 1);
    end;
    //Q430Campi[IDQ]:=Q430Campi[IDQ] + ',' + Campo; //View//
    Campi[IDQ]:=Campi[IDQ] + ',' + Campo; //View//
    if Tabella <> 'T430_STORICO' then
    begin
      //,Tabella.Campo
      Suf:='A';
      repeat
        Alias:=Tabella + Suf;  //Alias = Table.Name + A,B,C...
        if Tabella = 'T480_COMUNI' then
          Campo:=Alias + '.CITTA,' + Alias + '.PROVINCIA'
        else
          Campo:=Alias + '.DESCRIZIONE';
        Suf:=Succ(Suf);
        CampoPos:=',' + Campo + ',';
      until NonEsisteInArray(CampoPos,Campi);
      if Length(Campi[IDC]) > 800 then
      begin
        Inc(IDC);
        SetLength(Campi,IDC + 1);
      end;
      Campi[IDC]:=Campi[IDC] + ',' + Campo; //View//
      AliasPos:=' ' + Alias + ',';
      if NonEsisteInArray(AliasPos,Tabelle) then
      begin
        if Length(Tabelle[IDT]) > 780 then
        begin
          Inc(IDT);
          SetLength(Tabelle,IDT + 1);
        end;
        //FROM .... Tabella Alias
        Tabelle[IDT]:=Tabelle[IDT] + ',' + Tabella + ' ' + Alias;
        if Length(Join[IDJ]) > 800 then
        begin
          Inc(IDJ);
          SetLength(Join,IDJ + 1);
        end;
        //WHERE .... T430.Campo = Tabella.Campo(+) - Sintassi Oracle
        if Length(Join[0]) > 0 then Join[IDJ]:=Join[IDJ] + ' AND ';
        Join[IDJ]:=Join[IDJ] + 'T430.' + NomeColonna + '=' + Alias + '.' + Codice + '(+)';
        //Testo se il campo di T430 è tra quelli storici
        if Storico = 'S' then
          //Nel caso di dato libero storicizzato nella query della vista deve essere considerata anche la data di decorrenza
          Join[IDJ]:=Join[IDJ] + ' AND T430.DATAFINE BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
      end;
    end;
    selColsT430.Next;
  end;
  {P430} //Anagrafico stipendiale
  if ParametriV430 = 'P430' then
  begin
    with selColsP430 do
    begin
      Open;
      while not Eof do
      begin
        if Length(CampiAlias[IDCA]) > 800 then
        begin
          inc(IDCA);
          SetLength(CampiAlias,IDCA + 1);
        end;
        if Length(Campi[IDC]) > 800 then
        begin
          inc(IDC);
          SetLength(Campi,IDC + 1);
        end;
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430' + FieldByName('COLUMN_NAME').AsString;
        //Alberto 21/12/2005: uniformazione delle decorrenze tra T430 e P430
        if UpperCase(FieldByName('COLUMN_NAME').AsString) = 'DECORRENZA' then
          Campi[IDC]:=Campi[IDC] + ',NVL(GREATEST(T430.DATADECORRENZA,P430.DECORRENZA),T430.DATADECORRENZA)'
        else if UpperCase(FieldByName('COLUMN_NAME').AsString) = 'DECORRENZA_FINE' then
          Campi[IDC]:=Campi[IDC] + ',NVL(LEAST(T430.DATAFINE,P430.DECORRENZA_FINE),T430.DATAFINE)'
        else
          Campi[IDC]:=Campi[IDC] + ',P430.' + FieldByName('COLUMN_NAME').AsString; //View//
        if FieldByName('TABELLA').AsString <> '' then
        begin
          Alias:=Copy(FieldByName('TABELLA').AsString,1,Pos('_',FieldByName('TABELLA').AsString) - 1);
          if Alias = '' then
            Alias:=FieldByName('TABELLA').AsString;
          CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430D_' + FieldByName('COLUMN_NAME').AsString;
          Campi[IDC]:=Campi[IDC] + ',' + Alias + '.DESCRIZIONE'; //View//
          if Alias = 'P010' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430ABI_BANCA,P430CAB_BANCA,P430AGENZIA_BANCA,P430IBAN';
            Campi[IDC]:=Campi[IDC] + ',P010.ABI,P010.CAB,P010.AGENZIA,NVL(P430.IBAN_ESTERO,LPAD(NVL(P010.COD_NAZIONE,'' ''),2,'' '')||''-''||' +
                                     'LPAD(NVL(P430.CIN_EUROPA,''0''),2,''0'')||''-''||LPAD(NVL(P430.CIN_ITALIA,''0''),1,''0'')||''-''||' +
                                     'LPAD(NVL(P010.ABI,''0''),5,''0'')||''-''||LPAD(NVL(P010.CAB,''0''),5,''0'')||''-''||LPAD(NVL(P430.CONTO_CORRENTE,''0''),12,''0''))';
          end
          else if Alias = 'P040' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430FRAZIONE_PARTTIME,P430PERC_PARTTIME';
            Campi[IDC]:=Campi[IDC] + ',NVL(P040.PERCENTUALE/100,1),NVL(P040.PERCENTUALE,100)'; //View//
          end
          else if Alias = 'P240' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430TFR';
            Campi[IDC]:=Campi[IDC] + ',NVL(P240.TFR,''N'')'; //View//
          end;
          if Length(Tabelle[IDT]) > 800 then
          begin
            inc(IDT);
            SetLength(Tabelle,IDT + 1);
          end;
          Tabelle[IDT]:=Tabelle[IDT] + ',' + FieldByName('TABELLA').AsString + ' ' + StringReplace(Alias,FieldByName('TABELLA').AsString,'',[]);
          if Length(Join[IDJ]) > 800 then
          begin
            Inc(IDJ);
            SetLength(Join,IDJ + 1);
          end;
          if Length(Join[0]) > 0 then Join[IDJ]:=Join[IDJ] + ' AND ';
          Join[IDJ]:=Join[IDJ] + 'P430.' + FieldByName('COLUMN_NAME').AsString + '=' + Alias + '.' + FieldByName('COLONNA_TABELLA').AsString + '(+)';
          if Alias = 'P240' then
            Join[IDJ]:=Join[IDJ] + ' AND P430.COD_CONTRATTO = P240.COD_CONTRATTO(+)';
          if FieldByName('DECORRENZA').AsString = 'S' then
            Join[IDJ]:=Join[IDJ] + ' AND P430.DECORRENZA BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
        end;
        Next;
      end;
      Close;
    end;
  {P430}end;
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('drop table V430_STORICO');
    try
      Execute;
    except
    end;
    //CREATE VIEW V430_STORICO (Col1,Col2,Col3,...)
    SQL.Clear;

    //AS SELECT T430.Col1, T430.Col2, T430.Col3, ...
    if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      SQL.Add('CREATE OR REPLACE VIEW V430_STORICO_VIEW (')
    else
      SQL.Add('CREATE OR REPLACE VIEW V430_STORICO (');

    SQL.Add(Copy(CampiAlias[0],2,Length(CampiAlias[0])));
    for i:=1 to High(CampiAlias) do
      if CampiAlias[i] <> '' then
        SQL.Add(CampiAlias[i]);
    SQL.Add(')');

    SQL.Add('AS SELECT');
    if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      SQL.Add('/*+ ordered */');
    (*
    SQL.Add(Copy(Q430Campi[0],2,Length(Q430Campi[0])));
    for i:=1 to High(Q430Campi) do
      if Q430Campi[i] <> '' then
        SQL.Add(Q430Campi[i]);
    *)
    // Tab1.Col1, Tab2.Col2, Tab3.Col3, ...
    SQL.Add(Copy(Campi[0],2,Length(Campi[0])));
    for i:=1 to High(Campi) do
      if Campi[i] <> '' then
        SQL.Add(Campi[i]);
    //FROM T430_STORICO T430 LEFT JOIN Tab1 Alias1 LEFT JOIN Tab2 Alias2 ...
    SQL.Add('FROM T430_Storico T430');
    {P430}if ParametriV430 = 'P430' then SQL.Add(',P430_ANAGRAFICO P430');
    SQL.Add(Tabelle[0]);
    for i:=1 to High(Tabelle) do
      if Tabelle[i] <> '' then
        SQL.Add(Tabelle[i]);
    //WHERE
    SQL.Add('WHERE');
    SQL.Add(Join[0]);
    for i:=1 to High(Join) do
    begin
      if Join[i] <> '' then
        SQL.Add(Join[i]);
    end;
    {P430}if ParametriV430 = 'P430' then
    begin
      SQL.Add('AND P430.PROGRESSIVO(+) = T430.PROGRESSIVO');
      SQL.Add('AND P430.DECORRENZA(+) <= T430.DATAFINE AND P430.DECORRENZA_FINE(+) >= T430.DATADECORRENZA');
    end;{P430}
    try
      Execute;
      if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      begin
        SQL.Clear;
        SQL.Add('drop view V430_STORICO');
        try
          Execute;
        except
        end;
        PreparaIndiciV430Materializzata;
        SQL.Clear;
        SQL.Add('drop table V430_STORICO');
        try
          Execute;
        except
        end;
        SQL.Clear;
        SQL.Add('create table V430_STORICO tablespace ' + IfThen(Parametri.TSAusiliario = '',Parametri.TSLavoro, Parametri.TSAusiliario) + ' as select * from V430_STORICO_VIEW');
        Execute;
        CreaIndiciV430Materializzata;
      end;
      SQL.Clear;
      SQL.Add('grant select on V430_STORICO to public');
      Execute;
    except
    end;
  end;
end;

procedure TA099FUtilityDBMW.PreparaIndiciV430Materializzata;
var
  OldIndx, CampiIndx:String;
  Unico:Boolean;
  procedure CreaIndice(Nome:String; Unico:Boolean; LCampi:String);
  begin
    with scrIndV430 do
    begin
      Lines.Add('DROP INDEX ' + Nome + ';');
      Lines.Add('CREATE ');
      if Unico then
        Lines.Add('UNIQUE ');
      Lines.Add('INDEX ' + OldIndx + ' ON V430_STORICO (' + CampiIndx + ') NOPARALLEL TABLESPACE ' + Parametri.TSIndici + ';');
    end;
  end;
begin
  OldIndx:='';
  CampiIndx:='';
  Unico:=False;
  scrIndV430.Lines.Clear;
  with selIndV430 do
  begin
    Close;
    Open;
    while not Eof do
    begin
      if OldIndx <> FieldByName('INDEX_NAME').AsString then
      begin
        if OldIndx <> '' then
          CreaIndice(OldIndx,Unico,CampiIndx);
        OldIndx:=FieldByName('INDEX_NAME').AsString;
        Unico:=FieldByName('UNIQUENESS').AsString = 'UNIQUE';
        CampiIndx:='';
      end;
      if CampiIndx <> '' then
        CampiIndx:=CampiIndx + ',';
      CampiIndx:=CampiIndx + FieldByName('COLUMN_NAME').AsString;
      Next;
    end;
    Close;
  end;
  if OldIndx <> '' then
    CreaIndice(OldIndx,Unico,CampiIndx);
end;

procedure TA099FUtilityDBMW.CreaIndiciV430Materializzata;
begin
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('create index V430_PROGRESSIVO on V430_STORICO (T430PROGRESSIVO) tablespace ' + Parametri.TSIndici);
    Execute;
  end;
  if scrIndV430.Lines.Count > 0  then
    scrIndV430.Execute;
end;

end.
