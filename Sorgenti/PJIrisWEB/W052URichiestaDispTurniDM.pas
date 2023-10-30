unit W052URichiestaDispTurniDM;

interface

uses
  SysUtils, StrUtils, Classes, Oracle, DB, OracleData, Variants,
  A000UInterfaccia, C180FunzioniGenerali;

type
  TW052FRichiestaDispTurniDM = class(TDataModule)
    selT600: TOracleDataSet;
    selT600DATA: TDateTimeField;
    selT600MESSAGGI: TStringField;
    selaT600: TOracleQuery;
    selT600ID: TFloatField;
    selT600ID_REVOCA: TFloatField;
    selT600ID_REVOCATO: TFloatField;
    selT600PROGRESSIVO: TIntegerField;
    selT600NOMINATIVO: TStringField;
    selT600MATRICOLA: TStringField;
    selT600SESSO: TStringField;
    selT600COD_ITER: TStringField;
    selT600TIPO_RICHIESTA: TStringField;
    selT600AUTORIZZ_AUTOMATICA: TStringField;
    selT600REVOCABILE: TStringField;
    selT600DATA_RICHIESTA: TDateTimeField;
    selT600LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT600DATA_AUTORIZZAZIONE: TDateTimeField;
    selT600AUTORIZZAZIONE: TStringField;
    selT600NOMINATIVO_RESP: TStringField;
    selT600AUTORIZZ_AUTOM_PREV: TStringField;
    selT600AUTORIZZ_PREV: TStringField;
    selT600RESPONSABILE_PREV: TStringField;
    selT600AUTORIZZ_UTILE: TStringField;
    selT600AUTORIZZ_REVOCA: TStringField;
    selT600D_TIPO_RICHIESTA: TStringField;
    selT600D_RESPONSABILE: TStringField;
    selT600D_AUTORIZZAZIONE: TStringField;
    selT080: TOracleDataSet;
    selT600MSGAUT_SI: TStringField;
    selT600MSGAUT_NO: TStringField;
    selT600DAORE: TStringField;
    selT600AORE: TStringField;
    selT600SQUADRE: TStringField;
    selT600CF_SQUADRE: TStringField;
    selT603: TOracleDataSet;
    selT040: TOracleQuery;
    selT600a: TOracleDataSet;
    procedure selT600CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT600NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    FLstDescSquadre,FLstValSquadre: TStringList;
    function GetCFSquadre(Squadre:String): String;
  end;

implementation

uses W052URichiestaDispTurni;

{$R *.dfm}

procedure TW052FRichiestaDispTurniDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  selT603.Open;
  // estrae lista squadre
  FLstDescSquadre:=TStringList.Create;
  FLstValSquadre:=TStringList.Create;
  while not selT603.Eof do
  begin
    FLstDescSquadre.Add(Format('%-5s %s',[selT603.FieldByName('CODICE').AsString,selT603.FieldByName('DESCRIZIONE').AsString]));
    FLstValSquadre.Add(selT603.FieldByName('CODICE').AsString);
    selT603.Next;
  end;
end;

procedure TW052FRichiestaDispTurniDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FLstDescSquadre);
  FreeAndNil(FLstValSquadre);
end;

procedure TW052FRichiestaDispTurniDM.selT600CalcFields(DataSet: TDataSet);
var S:String;
begin
  with selT600 do
  begin
    // D_AUTORIZZAZIONE: descr. autorizzazione
    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      S:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=S;
    FieldByName('D_RESPONSABILE').AsString:=Trim(FieldByName('NOMINATIVO_RESP').AsString);
    // CF_SQUADRE: elenco squadre
    FieldByName('CF_SQUADRE').AsString:=GetCFSquadre(FieldByName('SQUADRE').AsString);
  end;
end;

procedure TW052FRichiestaDispTurniDM.selT600NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=(Self.Owner as TW052FRichiestaDispTurni).selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  //ultima squadra richiesta
  with selT600a do
  begin
    Close;
    SetVariable('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').AsInteger);
    Open;
    if RecordCount > 0 then
      DataSet.FieldByName('SQUADRE').AsString:=FieldByName('SQUADRE').AsString
    else
      DataSet.FieldByName('SQUADRE').AsString:=(Self.Owner as TW052FRichiestaDispTurni).selAnagrafeW.FieldByName('T430SQUADRA').AsString;
  end;
end;

function TW052FRichiestaDispTurniDM.GetCFSquadre(Squadre:String): String;
var S,Cod:String;
begin
  Result:='';
  S:=Squadre + ',';
  while Pos(',',S) > 0 do
  begin
    Cod:=Trim(Copy(S,1,Pos(',',S) - 1));
    if selT603.SearchRecord('CODICE',Cod,[srFromBeginning]) then
      Result:=Result + IfThen(Result <> '',CRLF) + Cod + ' - ' + selT603.FieldByName('DESCRIZIONE').AsString;
    S:=Copy(S,Pos(',',S) + 1);
  end;
end;

end.
