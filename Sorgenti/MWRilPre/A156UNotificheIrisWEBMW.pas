unit A156UNotificheIrisWEBMW;

interface

uses
  A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali,
  System.SysUtils, System.Classes, R005UDataModuleMW, Datasnap.DBClient,
  Data.DB, OracleData;

type

  TArgument = record
    Name: String;
    DataType: String;
    Mode: String;
    class operator Equal(ALeftOp, ARightOp: TArgument): Boolean;
    class operator NotEqual(ALeftOp, ARightOp: TArgument): Boolean;
  end;

  TA156FNotificheIrisWEBMW = class(TR005FDataModuleMW)
    selElencoProc: TOracleDataSet;
    selArgomentiProc: TOracleDataSet;
    cdsProc: TClientDataSet;
    cdsProcNOME: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure CaricaListaProcedure;
    function GetArgument(PName, PDataType, PMode: String): TArgument;
  public
    selI040_Funzioni: TOracleDataSet;
    procedure selI040BeforePost;
    procedure selI040NewRecord;
  end;

var
  A156FNotificheIrisWEBMW: TA156FNotificheIrisWEBMW;

const
  NUM_ARG_PROC = 12;

  // inserire gli argomenti in ordine di Position
  // un parametro di procedure è identificato da:
  // - Name
  // - Data type
  // - Mode (IN, OUT, o IN OUT)
  // cfr. http://docs.oracle.com/cd/B19306_01/appdev.102/b14261/subprograms.htm#sthref1640
  TIPO_ARG_ARR: array [1..NUM_ARG_PROC] of TArgument = (
    ({Position: 1; } Name: 'P_TIPOOPERATORE';     DataType: 'VARCHAR2'; Mode: 'IN'),
    ({Position: 2; } Name: 'P_OPERATORE';         DataType: 'VARCHAR2'; Mode: 'IN'),
    ({Position: 3; } Name: 'P_PROGRESSIVOOPER';   DataType: 'VARCHAR2'; Mode: 'IN'),
    ({Position: 4; } Name: 'P_MATRICOLAOPER';     DataType: 'VARCHAR2'; Mode: 'IN'),
    ({Position: 5; } Name: 'P_CODFISCALEOPER';    DataType: 'VARCHAR2'; Mode: 'IN'),
    ({Position: 6; } Name: 'P_PROFILOWEB';        DataType: 'VARCHAR2'; Mode: 'IN'),
    ({Position: 7; } Name: 'P_MODULIINSTALLATI';  DataType: 'VARCHAR2'; Mode: 'IN'),
    ({Position: 8; } Name: 'P_DIPENDENTICESSATI'; DataType: 'VARCHAR2'; Mode: 'IN'),
    ({Position: 9; } Name: 'P_SELANAGRAFE';       DataType: 'VARCHAR2'; Mode: 'IN'),
    ({Position: 10;} Name: 'P_TITOLO';            DataType: 'VARCHAR2'; Mode: 'OUT'),
    ({Position: 11;} Name: 'P_TESTO';             DataType: 'VARCHAR2'; Mode: 'OUT'),
    ({Position: 12;} Name: 'P_ICONA';             DataType: 'VARCHAR2'; Mode: 'OUT')
  );

implementation

{$R *.dfm}

procedure TA156FNotificheIrisWEBMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  CaricaListaProcedure;
end;

procedure TA156FNotificheIrisWEBMW.DataModuleDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TA156FNotificheIrisWEBMW.CaricaListaProcedure;
var
  LNomeProc: String;
  LPosition: Integer;
  LArgument: TArgument;
  LProcOk: Boolean;
begin
  cdsProc.EmptyDataSet;

  // imposta il readbuffer per i parametri
  selArgomentiProc.ReadBuffer:=NUM_ARG_PROC + 1;

  // estrae le procedure con stato valido con un numero di argomenti = NUM_ARG_PROC
  // e per ognuna verifica che la signature sia coerente con quella prevista
  selElencoProc.Close;
  selElencoProc.SetVariable('NUMERO_PARAMETRI',NUM_ARG_PROC);
  try
    selElencoProc.Open;
  except
    on E:Exception do
      if Pos('OBJECT_TYPE',E.Message) > 0 then
      begin
        selElencoProc.SQL.Text:=selElencoProc.SQL.Text.Replace('p.object_type','''PROCEDURE''',[rfIgnoreCase]);
        selElencoProc.Open;
      end;
  end;
  while not selElencoProc.Eof do
  begin
    // imposta nome procedura da verificare
    LNomeProc:=selElencoProc.FieldByName('OBJECT_NAME').AsString;

    // confronta gli argomenti della procedure per verificare se la signature è coerente
    LProcOk:=True;
    selArgomentiProc.Close;
    selArgomentiProc.SetVariable('NOME_PROCEDURA',LNomeProc);
    selArgomentiProc.Open;
    while not selArgomentiProc.Eof do
    begin
      LPosition:=selArgomentiProc.FieldByName('POSITION').AsInteger;
      LArgument:=GetArgument(selArgomentiProc.FieldByName('ARGUMENT_NAME').AsString,
                             selArgomentiProc.FieldByName('DATA_TYPE').AsString,
                             selArgomentiProc.FieldByName('IN_OUT').AsString);

      // se position è fuori range, esclude la procedure (dovrebbe essere impossibile)
      if not R180Between(LPosition,Low(TIPO_ARG_ARR),High(TIPO_ARG_ARR)) then
      begin
        LProcOk:=False;
        Break;
      end;

      // se l'argomento non è coerente con quanto atteso, esclude la procedure
      // cfr. il class operator TArgument.NotEqual
      if LArgument <> TIPO_ARG_ARR[LPosition] then
      begin
        LProcOk:=False;
        Break;
      end;

      selArgomentiProc.Next;
    end;

    // se la procedure è ok, la aggiunge alla lista
    if LProcOk then
    begin
      cdsProc.Append;
      cdsProc.FieldByName('NOME').AsString:=LNomeProc;
      cdsProc.Post;
    end;

    // prossima procedura
    selElencoProc.Next;
  end;
end;

function TA156FNotificheIrisWEBMW.GetArgument(PName, PDataType, PMode: String): TArgument;
begin
  Result.Name:=PName;
  Result.DataType:=PDataType;
  Result.Mode:=PMode;
end;

procedure TA156FNotificheIrisWEBMW.selI040BeforePost;
begin
  // descrizione deve essere valorizzato
  if selI040_Funzioni.FieldByName('DESCRIZIONE').AsString.Trim = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A156_ERR_DESCRIZIONE_VUOTA));

  // notifica deve essere valorizzato
  if selI040_Funzioni.FieldByName('NOTIFICA').AsString.Trim = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A156_ERR_NOTIFICA_VUOTA));

  //Il campo Attivo può contenere solo i valori "S" o "N"
  if not R180In(selI040_Funzioni.FieldByName('ATTIVO').AsString,['S','N']) then
    raise exception.Create(A000TraduzioneStringhe(A000MSG_A156_ERR_ATTIVO));
end;

procedure TA156FNotificheIrisWEBMW.selI040NewRecord;
begin
  selI040_Funzioni.FieldByName('ATTIVO').AsString:='S';
end;

{ TArgument }
// cfr. http://docs.oracle.com/cd/B19306_01/appdev.102/b14261/subprograms.htm#sthref1640

class operator TArgument.Equal(ALeftOp, ARightOp: TArgument): Boolean;
// due argomenti sono considerati uguali se hanno stesso datatype e mode (in/out)
begin
  Result:=(ALeftOp.DataType.ToUpper = ARightOp.DataType.ToUpper) and
          (ALeftOp.Mode.ToUpper = ARightOp.Mode.ToUpper);
end;

class operator TArgument.NotEqual(ALeftOp, ARightOp: TArgument): Boolean;
// due argomenti sono considerati diversi se hanno datatype differente oppure mode (in/out) differente
begin
  Result:=(ALeftOp.DataType.ToUpper <> ARightOp.DataType.ToUpper) or
          (ALeftOp.Mode.ToUpper <> ARightOp.Mode.ToUpper);
end;

end.
