unit A174UParPianifTurniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, uselI010,
  A000UInterfaccia, A000UCostanti, Data.DB, Generics.Collections, Oracle,
  Variants;

type

  RecOrdinamento = record
    Codice, Descrizione:string;
  end;

  TA174FParPianifTurniMW = class(TR005FDataModuleMW)
    dsrI010: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    ListaOrdinamento:TList<RecOrdinamento>;
    function AddOrdinamento(Codice,Descrizione:string):RecOrdinamento;
  public
    selT082:TOracleDataSet;
    selI010:TselI010;
    ListaCols:TStringList;
    procedure AfterInsert;
    procedure BeforePost;
    procedure CaricaListaDatiOrdinamento(ListaOrd:TStrings);
    procedure CaricaOrdinamento(Campo:string;ListaOrd:TStrings);
    function SalvaOrdinamento(ListaOrd:TStrings):string;
    function SqlCausali: String;
    const
      Orientamento:array[0..2] of TItemsValues = ((Item:'Automatico';  Value:'A'),
                                                  (Item:'Orizzontale'; Value:'O'),
                                                  (Item:'Verticale';   Value:'V'));
  end;

implementation

{$R *.dfm}

function TA174FParPianifTurniMW.AddOrdinamento(Codice,Descrizione:string):RecOrdinamento;
begin
  Result.Codice:=Codice;
  Result.Descrizione:=Descrizione;
end;

procedure TA174FParPianifTurniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  //Lista dei dati anagrafici per ricerca sostituto, escludendo quelli di T030, le descrizioni e squadra e tipo operatore (che vengono visualizzati sempre)
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'','TABLE_NAME = ''V430_STORICO'' AND NOME_CAMPO NOT IN (''T430SQUADRA'',''T430TIPOOPE'') AND INSTR(NOME_CAMPO,''430D_'') = 0','NVL(POSIZIONE,999),NOME_LOGICO');
  ListaCols:=TStringList.Create;
  while not selI010.Eof do
  begin
    ListaCols.Add(Format('%-40s %s',[selI010.FieldByName('NOME_CAMPO').AsString,selI010.FieldByName('NOME_LOGICO').AsString]));
    selI010.Next;
  end;
  FreeAndNil(selI010);

  selI010:=TselI010.Create(Self);
  //Lista di tutti i dati anagrafici per raggruppamento in stampa
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO');
  dsrI010.DataSet:=selI010;

  ListaOrdinamento:=TList<RecOrdinamento>.create;
  ListaOrdinamento.Add(AddOrdinamento('N','Nominativo'));
  ListaOrdinamento.Add(AddOrdinamento('S','Operatore'));
  ListaOrdinamento.Add(AddOrdinamento('T','Turno di partenza'));
  ListaOrdinamento.Add(AddOrdinamento('P','Turno Pianificato'));
  ListaOrdinamento.Add(AddOrdinamento('O','Orario Pianificato'));
end;

function TA174FParPianifTurniMW.SalvaOrdinamento(ListaOrd:TStrings):string;
var
  i,j:integer;
begin
  Result:='';
  for i:=0 to ListaOrd.Count - 1 do
  begin
    for j:=0 to ListaOrdinamento.Count - 1 do
      if ListaOrd[i] = ListaOrdinamento[j].Descrizione then
      begin
        if not Result.IsEmpty then
          Result:=Result + ',';
        Result:=Result + ListaOrdinamento[j].Codice;
      end;
  end;
end;

procedure TA174FParPianifTurniMW.CaricaOrdinamento(Campo:string;ListaOrd:TStrings);
var
  TempList:TstringList;
  i, j:integer;
begin
  TempList:=TStringList.Create;
  try
    TempList.CommaText:=selT082.FieldByName(Campo).AsString;
    ListaOrd.Clear;
    for i:=0 to TempList.Count - 1 do
    begin
      for j:=0 to ListaOrdinamento.Count - 1 do
        if TempList[i] = ListaOrdinamento[j].Codice then
          ListaOrd.Add(ListaOrdinamento[j].Descrizione);
    end;
  finally
    FreeAndNil(TempList);
  end;
end;

procedure TA174FParPianifTurniMW.CaricaListaDatiOrdinamento(ListaOrd:TStrings);
var
  i:integer;
begin
  ListaOrd.Clear;
  for i:=0 to ListaOrdinamento.Count - 1 do
    ListaOrd.Add(ListaOrdinamento[i].Descrizione);
end;

procedure TA174FParPianifTurniMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selI010);
  FreeAndNil(ListaOrdinamento);
  FreeAndNil(ListaCols);//.Free;
end;


function TA174FParPianifTurniMW.SqlCausali: String;
begin
  Result:='select '''' as CODICE, ''*********** Causali di giustificazione ***********'' as DESCRIZIONE, ''GIUSTIFICAZION0'' as TIPO'+
      '  from dual'+
      ' union'+
      ' select T305.CODICE, T305.DESCRIZIONE, ''GIUSTIFICAZIONE'' as TIPO'+
      '  from T305_CAUGIUSTIF T305'+
      ' union'+
      ' select '''' as CODICE, ''************* Causali di presenza *************'' as DESCRIZIONE, ''PRESENZ0'' as TIPO'+
      '  from dual'+
      ' union'+
      ' select T275.CODICE, T275.DESCRIZIONE, ''PRESENZA'' as TIPO'+
      '  from T275_CAUPRESENZE T275'+
      ' order by TIPO, CODICE';
end;

procedure TA174FParPianifTurniMW.AfterInsert;
var
  Valore:String;
begin
  Valore:='N';
  if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    Valore:='S';
  selT082.FieldByName('GENERAZIONE').AsString:=Valore;
  selT082.FieldByName('INIZIALE').AsString:=Valore;
  selT082.FieldByName('CORRENTE').AsString:=Valore;
end;

procedure TA174FParPianifTurniMW.BeforePost;
begin
  inherited;
  if (selT082.FieldByName('DIMENSIONE_FONT').AsInteger < 6) or
     (selT082.FieldByName('DIMENSIONE_FONT').AsInteger > 13) then
    Raise Exception.Create('La dimensione dei font deve essere compreso tra 6 e 13!');
end;

end.
