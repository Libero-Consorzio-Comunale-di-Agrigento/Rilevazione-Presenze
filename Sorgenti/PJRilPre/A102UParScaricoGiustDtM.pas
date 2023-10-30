unit A102UParScaricoGiustDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, A000UInterfaccia,
  C180FunzioniGenerali, StrUtils;

type
  TA102FParScaricoGiustDtM = class(TR004FGestStoricoDtM)
    selI150: TOracleDataSet;
    selI150CODICE: TStringField;
    selI150NOMEFILE: TStringField;
    selI150CORRENTE: TStringField;
    selI150MATRICOLA: TStringField;
    selI150BADGE: TStringField;
    selI150ANNODA: TStringField;
    selI150MESEDA: TStringField;
    selI150GIORNODA: TStringField;
    selI150ANNOA: TStringField;
    selI150MESEA: TStringField;
    selI150GIORNOA: TStringField;
    selI150ORADA: TStringField;
    selI150MINDA: TStringField;
    selI150ORAA: TStringField;
    selI150MINA: TStringField;
    selI150CAUSALE: TStringField;
    selI150TIPO: TStringField;
    selI150DATADA: TStringField;
    selI150NUMGIORNI: TStringField;
    selI150CODICE_TIPOI: TStringField;
    selI150CODICE_TIPOM: TStringField;
    selI150CODICE_TIPOD: TStringField;
    selI150CODICE_TIPON: TStringField;
    selI150SEPARATORE: TStringField;
    selI150FORMATODATA: TStringField;
    selI150DESCCAUSALE: TStringField;
    selI150AZIENDA: TStringField;
    selI090: TOracleDataSet;
    dsrI090: TDataSource;
    selI150MATRICOLA_NUMERICA: TStringField;
    selI150TIPOFILE: TStringField;
    selI150ID: TStringField;
    selI150TIPO_OPERAZIONE: TStringField;
    selI150FAMILIARE: TStringField;
    selI150MESSAGGIO: TStringField;
    selI150ELABORATO: TStringField;
    selI150DATA_ELABORAZIONE: TStringField;
    selI150DATAA: TStringField;
    selI150HHMMDA: TStringField;
    selI150HHMMA: TStringField;
    selI150ANOMALIE_BLOCCANTI: TStringField;
    selI150CHIAVE: TStringField;
    selI150EXPR_CHIAVE: TStringField;
    selI150TRIGGER_BEFORE: TStringField;
    selI150TRIGGER_AFTER: TStringField;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selI150NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    function CtrlExprChiave(const PExpr: String; var Err: String): Boolean;
    { Private declarations }
  public
    { Public declarations }
    function GetNomeCampo(idx:Integer):String;
  end;

var
  A102FParScaricoGiustDtM: TA102FParScaricoGiustDtM;

implementation

uses A102UParScaricoGiust;

{$R *.dfm}

procedure TA102FParScaricoGiustDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selI150,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  if Parametri.Azienda <> 'AZIN' then
  begin
    selI150.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selI150.Filtered:=True;
  end;
  selI150.Open;
  selI090.Open;
  if Parametri.Azienda <> 'AZIN' then
  begin
    selI090.Filtered:=False;
    selI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selI090.Filtered:=True;
  end;
end;

function TA102FParScaricoGiustDtM.GetNomeCampo(idx:Integer):String;
{idx = indice della cella}
begin
  Result:='';
  case idx of
     1:Result:='MATRICOLA';
     2:Result:='BADGE';
     3:Result:='ANNODA';
     4:Result:='MESEDA';
     5:Result:='GIORNODA';
     6:Result:='ANNOA';
     7:Result:='MESEA';
     8:Result:='GIORNOA';
     9:Result:='ORADA';
    10:Result:='MINDA';
    11:Result:='ORAA';
    12:Result:='MINA';
    13:Result:='CAUSALE';
    14:Result:='TIPO';
    15:Result:='DATADA';  //Lorena 11/08/2005
    16:Result:='DATAA';    //Norman 20/02/2007
    17:Result:='NUMGIORNI';  //Lorena 11/08/2005
    18:Result:='CHIAVE';
    // dati per tabella oracle
    19:Result:='ID';        //Norman 20/02/2007
    20:Result:='TIPO_OPERAZIONE';  //Norman 20/02/2007
    21:Result:='FAMILIARE';        //Norman 20/02/2007
    22:Result:='MESSAGGIO';        //Norman 20/02/2007
    23:Result:='ELABORATO';        //Norman 20/02/2007
    24:Result:='DATA_ELABORAZIONE';  //Norman 20/02/2007
    25:Result:='HHMMDA';  //Norman 05/03/2007
    26:Result:='HHMMA';  //Norman 05/03/2007
  end;
end;

function TA102FParScaricoGiustDtM.CtrlExprChiave(const PExpr: String; var Err: String): Boolean;
var
  Lst: TStringList;
  i: Integer;
  NomeVar: String;
  OQ: TOracleQuery;
begin
  Result:=True;
  Err:='';

  Lst:=TStringList.Create;
  OQ:=TOracleQuery.Create(Self);
  try
    // 1. l'espressione deve contenere la variabile :CHIAVE (tipo alfanumerico)
    //    e opzionalmente la variabile :DATA (tipo date)
    OQ.Session:=SessioneOracle;
    OQ.SQL.Text:=PExpr;

    Lst:=FindVariables(PExpr,False); // non considera i duplicati
    Lst.CaseSensitive:=False;

    // controllo presenza obbligatoria della variabile "chiave"
    if Lst.IndexOf('CHIAVE') = -1  then
    begin
      Result:=False;
      Err:='L''espressione per la chiave deve necessariamente contenere una variabile denominata ":CHIAVE"!';
      Exit;
    end;

    for i:=0 to Lst.Count - 1 do
    begin
      NomeVar:=UpperCase(Lst[i]);
      if NomeVar = 'CHIAVE' then
      begin
        OQ.DeclareAndSet(NomeVar,otString,'1');
      end
      else if NomeVar = 'DATA' then
      begin
        OQ.DeclareAndSet(NomeVar,otDate,DATE_NULL);
      end
      else
      begin
        Result:=False;
        Err:=Format('L''espressione per la chiave non ammette l''utilizzo della variabile "%s"!',[NomeVar]);
        Exit;
      end;
    end;

    // 2. l'espressione deve essere formalmente corretta
    try
      OQ.Execute;
    except
      on E: Exception do
      begin
        Result:=False;
        Err:=Format('L''espressione per la chiave non è corretta:'#13#10'%s',[E.Message]);
        Exit;
      end;
    end;

    // 3. l'espressione deve estrarre una sola colonna di tipo number (il progressivo)
    if OQ.FieldCount > 1 then
    begin
      Result:=False;
      Err:='L''espressione per la chiave deve selezionare unicamente il progressivo del dipendente!';
      Exit;
    end;
    if (OQ.FieldType(0) <> otInteger) and
       (OQ.FieldType(0) <> otFloat) then
    begin
      Result:=False;
      Err:=Format('L''espressione per la chiave deve selezionare il progressivo del dipendente: ' +
                  'il dato selezionato "%s" non è di tipo numerico!',[OQ.FieldName(0)]);
      Exit;
    end;
  finally
    FreeAndNil(Lst);
    FreeAndNil(OQ);
  end;
end;

procedure TA102FParScaricoGiustDtM.selI150NewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('CODICE_TIPOI').AsString:='I';
  DataSet.FieldByName('CODICE_TIPOM').AsString:='M';
  DataSet.FieldByName('CODICE_TIPOD').AsString:='D';
  DataSet.FieldByName('CODICE_TIPON').AsString:='N';
  DataSet.FieldByName('CORRENTE').AsString:='N';
  if selI150.FieldByName('TIPOFILE').AsString = 'F' then
  begin
    DataSet.FieldByName('MATRICOLA').AsString:='0,0';
    DataSet.FieldByName('BADGE').AsString:='0,0';
    DataSet.FieldByName('ANNODA').AsString:='0,0';
    DataSet.FieldByName('MESEDA').AsString:='0,0';
    DataSet.FieldByName('GIORNODA').AsString:='0,0';
    DataSet.FieldByName('ANNOA').AsString:='0,0';
    DataSet.FieldByName('MESEA').AsString:='0,0';
    DataSet.FieldByName('GIORNOA').AsString:='0,0';
    DataSet.FieldByName('ORADA').AsString:='0,0';
    DataSet.FieldByName('MINDA').AsString:='0,0';
    DataSet.FieldByName('ORAA').AsString:='0,0';
    DataSet.FieldByName('MINA').AsString:='0,0';
    DataSet.FieldByName('CAUSALE').AsString:='0,0';
    DataSet.FieldByName('TIPO').AsString:='0,0';
    DataSet.FieldByName('DATADA').AsString:='0,0';  //Lorena 12/08/2005
    DataSet.FieldByName('DATAA').AsString:='0,0';
    DataSet.FieldByName('NUMGIORNI').AsString:='0,0'; //Lorena 12/08/2005
    DataSet.FieldByName('CHIAVE').AsString:='0,0';
  end;
end;

procedure TA102FParScaricoGiustDtM.BeforePostNoStorico(DataSet: TDataSet);
{Copio i dati della griglia nei campi corrispondenti prima di confermare le modifiche}
var
  i:Byte;
  P,L:Word;
  LMatricolaVuota, LChiaveVuota, LErrore: String;
begin
  inherited;
  with A102FParScaricoGiust do
  begin
    for i:=1 to StringGrid1.ColCount - 1 do
    begin
      if selI150.FieldByName('TIPOFILE').AsString = 'F' then
      begin
        P:=StrToIntDef(StringGrid1.Cells[i,1],0);
        L:=StrToIntDef(StringGrid1.Cells[i,2],0);
        selI150.FieldByName(GetNomeCampo(i)).AsString:=IntToStr(P) + ',' + IntToStr(L);
      end
      else if selI150.FieldByName('TIPOFILE').AsString = 'T' then
        selI150.FieldByName(GetNomeCampo(i)).AsString:=StringGrid1.Cells[i,1]
      else if selI150.FieldByName('TIPOFILE').AsString = 'R' then
      begin
        selI150.FieldByName('NOMEFILE').AsString:='(na)';
        selI150.FieldByName('CAUSALE').AsString:='(na)';
        selI150.FieldByName('MATRICOLA').AsString:='(na)';
        selI150.FieldByName('CHIAVE').Clear;
        selI150.FieldByName('EXPR_CHIAVE').Clear;
      end;
    end;

    // trim dell'espressione per la chiave
    selI150.FieldByName('EXPR_CHIAVE').AsString:=Trim(selI150.FieldByName('EXPR_CHIAVE').AsString);

    // controllo indicazione chiave in alternativa alla matricola
    LMatricolaVuota:=IfThen(selI150.FieldByName('TIPOFILE').AsString = 'F','0,0','');
    LChiaveVuota:=IfThen(selI150.FieldByName('TIPOFILE').AsString = 'F','0,0','');

    if (selI150.FieldByName('MATRICOLA').AsString <> LMatricolaVuota) and
       (selI150.FieldByName('CHIAVE').AsString <> LChiaveVuota) then
    begin
      raise Exception.Create('La parametrizzazione del dato Chiave è ammessa solo in alternativa a Matricola!');
    end;

    // se il dato chiave è indicato richiede obbligatoriamente l'espressione relativa
    if (selI150.FieldByName('CHIAVE').AsString <> LChiaveVuota) and
       (selI150.FieldByName('EXPR_CHIAVE').AsString = '') then
    begin
      raise Exception.Create('E'' necessario indicare obbligatoriamente l''espressione per la chiave!');
    end;

    // controllo indicazione espressione chiave
    if selI150.FieldByName('EXPR_CHIAVE').AsString <> '' then
    begin
      // l'espressione è ammessa solo se è parametrizzato il dato Chiave
      if selI150.FieldByName('CHIAVE').AsString = LChiaveVuota then
      begin
        raise Exception.Create('L''espressione per la chiave è da indicare solo se è parametrizzato il corrispondente dato!');
      end;

      // controlli sull'espressione SQL per la chiave
      if not CtrlExprChiave(selI150.FieldByName('EXPR_CHIAVE').AsString,LErrore) then
        raise Exception.Create(LErrore);
    end;
  end;
end;

procedure TA102FParScaricoGiustDtM.AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=selI150Codice.AsString;
  inherited;
  selI150.Locate('Codice',S,[]);
end;

end.
