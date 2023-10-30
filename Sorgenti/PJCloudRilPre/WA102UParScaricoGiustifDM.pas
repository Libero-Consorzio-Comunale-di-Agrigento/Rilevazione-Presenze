unit WA102UParScaricoGiustifDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione, ControlloVociPaghe, medpIWMessageDlg, C180FunzioniGenerali,meIWEdit,
  System.StrUtils;

type
  TWA102FParScaricoGiustifDM = class(TWR302FGestTabellaDM)
    selI090: TOracleDataSet;
    dsrI090: TDataSource;
    selTabellaCODICE: TStringField;
    selTabellaNOMEFILE: TStringField;
    selTabellaCORRENTE: TStringField;
    selTabellaMATRICOLA: TStringField;
    selTabellaBADGE: TStringField;
    selTabellaANNODA: TStringField;
    selTabellaMESEDA: TStringField;
    selTabellaGIORNODA: TStringField;
    selTabellaANNOA: TStringField;
    selTabellaMESEA: TStringField;
    selTabellaGIORNOA: TStringField;
    selTabellaORADA: TStringField;
    selTabellaMINDA: TStringField;
    selTabellaORAA: TStringField;
    selTabellaMINA: TStringField;
    selTabellaCAUSALE: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaDATADA: TStringField;
    selTabellaNUMGIORNI: TStringField;
    selTabellaCODICE_TIPOI: TStringField;
    selTabellaCODICE_TIPOM: TStringField;
    selTabellaCODICE_TIPOD: TStringField;
    selTabellaCODICE_TIPON: TStringField;
    selTabellaSEPARATORE: TStringField;
    selTabellaFORMATODATA: TStringField;
    selTabellaDESCCAUSALE: TStringField;
    selTabellaAZIENDA: TStringField;
    selTabellaMATRICOLA_NUMERICA: TStringField;
    selTabellaTIPOFILE: TStringField;
    selTabellaID: TStringField;
    selTabellaDATAA: TStringField;
    selTabellaTIPO_OPERAZIONE: TStringField;
    selTabellaFAMILIARE: TStringField;
    selTabellaMESSAGGIO: TStringField;
    selTabellaELABORATO: TStringField;
    selTabellaDATA_ELABORAZIONE: TStringField;
    selTabellaHHMMDA: TStringField;
    selTabellaHHMMA: TStringField;
    selTabellaANOMALIE_BLOCCANTI: TStringField;
    selTabellaCHIAVE: TStringField;
    selTabellaEXPR_CHIAVE: TStringField;
    selTabellaTRIGGER_BEFORE: TStringField;
    selTabellaTRIGGER_AFTER: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet);  override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    function CtrlExprChiave(const PExpr: String; var Err: String): Boolean;
  public
    function GetNomeCampo(idx:Integer):String;
  end;

implementation

uses WA102UParScaricoGiustif, WA102UParScaricoGiustifDettFM, WR100UBase;

{$R *.dfm}

procedure TWA102FParScaricoGiustifDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  if Parametri.Azienda <> 'AZIN' then
  begin
    selTabella.Filter:='AZIENDA = ''' +   Parametri.Azienda + '''';
    selTabella.Filtered:=True;
  end;
  inherited;
  selI090.Open;
end;

function TWA102FParScaricoGiustifDM.GetNomeCampo(idx:Integer):String;
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

procedure TWA102FParScaricoGiustifDM.AfterScroll(DataSet: TDataSet);
var
  LDettFM: TWA102FParScaricoGiustifDettFM;
begin
  inherited;
  if Self.Owner <> nil then
  begin
    if (Self.Owner as TWA102FParScaricoGiustif).WDettaglioFM <> nil then
    begin
      LDettFM:=((Self.Owner as TWA102FParScaricoGiustif).WDettaglioFM as TWA102FParScaricoGiustifDettFM);
      LDettFM.chkExprChiave.Checked:=DataSet.FieldByName('EXPR_CHIAVE').AsString <> '';
      LDettFM.chkExprChiaveClick(nil);
    end;
  end;
end;

procedure TWA102FParScaricoGiustifDM.BeforePostNoStorico(DataSet: TDataSet);
var
  LMatricolaVuota, LChiaveVuota, LErrore: String;
begin
  inherited;

  // trim dell'espressione per la chiave
  selTabella.FieldByName('EXPR_CHIAVE').AsString:=Trim(selTabella.FieldByName('EXPR_CHIAVE').AsString);

  // controllo indicazione chiave in alternativa alla matricola
  LMatricolaVuota:=IfThen(selTabella.FieldByName('TIPOFILE').AsString = 'F','0,0','');
  LChiaveVuota:=IfThen(selTabella.FieldByName('TIPOFILE').AsString = 'F','0,0','');

  if (selTabella.FieldByName('MATRICOLA').AsString <> LMatricolaVuota) and
     (selTabella.FieldByName('CHIAVE').AsString <> LChiaveVuota) then
  begin
    raise Exception.Create('La parametrizzazione del dato Chiave è ammessa solo in alternativa a Matricola!');
  end;

  // se il dato chiave è indicato richiede obbligatoriamente l'espressione relativa
  if (selTabella.FieldByName('CHIAVE').AsString <> LChiaveVuota) and
     (selTabella.FieldByName('EXPR_CHIAVE').AsString = '') then
  begin
    raise Exception.Create('E'' necessario indicare obbligatoriamente l''espressione per la chiave!');
  end;

  // controllo indicazione espressione chiave
  if selTabella.FieldByName('EXPR_CHIAVE').AsString <> '' then
  begin
    // l'espressione è ammessa solo se è parametrizzato il dato Chiave
    if selTabella.FieldByName('CHIAVE').AsString = LChiaveVuota then
    begin
      raise Exception.Create('L''espressione per la chiave è da indicare solo se è parametrizzato il corrispondente dato!');
    end;

    // controlli sull'espressione SQL per la chiave
    if not CtrlExprChiave(selTabella.FieldByName('EXPR_CHIAVE').AsString,LErrore) then
      raise Exception.Create(LErrore);
  end;
end;

function TWA102FParScaricoGiustifDM.CtrlExprChiave(const PExpr: String; var Err: String): Boolean;
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
                  'il campo selezionato "%s" non è di tipo numerico!',[OQ.FieldName(0)]);
      Exit;
    end;
  finally
    FreeAndNil(Lst);
    FreeAndNil(OQ);
  end;
end;

procedure TWA102FParScaricoGiustifDM.OnNewRecord(DataSet: TDataSet);
begin
  if selTabella.FieldByName('TIPOFILE').AsString = 'F' then
  begin
    selTabella.FieldByName('MATRICOLA').AsString:='0,0';
    selTabella.FieldByName('BADGE').AsString:='0,0';
    selTabella.FieldByName('ANNODA').AsString:='0,0';
    selTabella.FieldByName('MESEDA').AsString:='0,0';
    selTabella.FieldByName('GIORNODA').AsString:='0,0';
    selTabella.FieldByName('ANNOA').AsString:='0,0';
    selTabella.FieldByName('MESEA').AsString:='0,0';
    selTabella.FieldByName('GIORNOA').AsString:='0,0';
    selTabella.FieldByName('ORADA').AsString:='0,0';
    selTabella.FieldByName('MINDA').AsString:='0,0';
    selTabella.FieldByName('ORAA').AsString:='0,0';
    selTabella.FieldByName('MINA').AsString:='0,0';
    selTabella.FieldByName('CAUSALE').AsString:='0,0';
    selTabella.FieldByName('TIPO').AsString:='0,0';
    selTabella.FieldByName('DATADA').AsString:='0,0';
    selTabella.FieldByName('DATAA').AsString:='0,0';
    selTabella.FieldByName('NUMGIORNI').AsString:='0,0';
    selTabella.FieldByName('CHIAVE').AsString:='0,0';
  end;
  inherited;  //scatena il dataset2componenti;
end;

end.
