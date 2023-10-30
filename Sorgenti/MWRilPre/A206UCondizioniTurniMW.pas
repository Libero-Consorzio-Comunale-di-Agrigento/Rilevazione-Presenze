unit A206UCondizioniTurniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, Oracle,
  A000UMessaggi, A000UInterfaccia, A000USessione, Datasnap.DBClient, C180FunzioniGenerali,
  Variants, StrUtils, Math;

type

  TCondizioni = record
    Cod:String;  //Codice della condizione
    Gen,         //Condizione generale
    Ind,         //Condizione individuale
    Min,         //Gestione del valore Minimo
    Ott,         //Gestione del valore Ottimale
    Max:Boolean; //Gestione del valore Massimo
    Val:String;  //Tipologia del campo Valore: ''=non gestito, 'T020'=lista modelli orario, 'T265'=lista causali assenza, 'ANAG'=sql selezione anagrafica
  end;

  TA206FCondizioniTurniMW = class(TR005FDataModuleMW)
    selT603: TOracleDataSet;
    dsrT603: TDataSource;
    selT430: TOracleDataSet;
    dsrTipoOpe: TDataSource;
    selGiorni: TOracleDataSet;
    dsrGiorni: TDataSource;
    selT020: TOracleDataSet;
    dsrT020: TDataSource;
    selT021: TOracleDataSet;
    dsrT021: TDataSource;
    selT605: TOracleDataSet;
    dsrT605: TDataSource;
    selT603CODICE: TStringField;
    selT603DESCRIZIONE: TStringField;
    selGiorniCODICE: TStringField;
    selGiorniDESCRIZIONE: TStringField;
    selT020CODICE: TStringField;
    selT020DESCRIZIONE: TStringField;
    selT021SIGLATURNI: TStringField;
    selT605CODICE: TStringField;
    selT605DESCRIZIONE: TStringField;
    selGiorniORD: TFloatField;
    selT605a: TOracleDataSet;
    selT605aCODICE: TStringField;
    selT605aDESCRIZIONE: TStringField;
    selT605aGENERALE: TStringField;
    selT605aINDIVIDUALE: TStringField;
    selT605aSQUADRA_ABILITA: TStringField;
    selT605aTIPOOPE_ABILITA: TStringField;
    selT605aORARIO_ABILITA: TStringField;
    selT605aTURNO_ABILITA: TStringField;
    selT605aGIORNO_ABILITA: TStringField;
    selT605aMINIMO_ABILITA: TStringField;
    selT605aMINIMO_OBBLIGA: TStringField;
    selT605aOTTIMALE_ABILITA: TStringField;
    selT605aOTTIMALE_OBBLIGA: TStringField;
    selT605aMASSIMO_ABILITA: TStringField;
    selT605aMASSIMO_OBBLIGA: TStringField;
    selT605aVALORE_ABILITA: TStringField;
    selT605aVALORE_OBBLIGA: TStringField;
    selT605aVALORE_TIPO: TStringField;
    selTipoVal: TOracleDataSet;
    dsrTipoVal: TDataSource;
    selT021DESCRIZIONE: TStringField;
    selT430TIPOOPE: TStringField;
    selTipoOpe: TOracleDataSet;
    selTipoOpeTIPOOPE: TStringField;
    selTipoOpeDESCRIZIONE: TStringField;
    selT265: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT605FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
  public
    selT606: TOracleDataSet;
    TipoCond:String;
    CondOK:Boolean;
    procedure RefreshDataSet;
    procedure PulisciValori;
    procedure selT606AfterScroll;
    procedure selT606OnCalcFields;
    function selT606FilterRecord: Boolean;
    procedure selT606OnNewRecord(Prog:Integer);
    procedure selT606BeforePost;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA206FCondizioniTurniMW.DataModuleCreate(Sender: TObject);
var sCondTipoOpeT430:String;
begin
  inherited;
  TipoCond:='G';
  selTipoVal.Open;
  selT605a.Open;
  selT603.SetVariable('DECORRENZA',EncodeDate(1900,1,1));
  selT603.SetVariable('DECORRENZA_FINE',EncodeDate(3999,12,31));
  selT603.SetVariable('SQUADRA_ABILITA','S');
  selT603.Open;
  selT430.SetVariable('DECORRENZA',EncodeDate(1900,1,1));
  selT430.SetVariable('DECORRENZA_FINE',EncodeDate(3999,12,31));
  selT430.Open;
  while not selT430.Eof do
  begin
    sCondTipoOpeT430:=sCondTipoOpeT430 + ' union select ''' + selT430.FieldByName('TIPOOPE').AsString + ''' TIPOOPE, null DESCRIZIONE from dual';
    selT430.Next;
  end;
  selTipoOpe.SetVariable('TIPOOPE_ABILITA','S');
  selTipoOpe.SetVariable('COND_TIPIOPE_T430',sCondTipoOpeT430);
  selTipoOpe.FieldByName('TIPOOPE').Size:=5; //serve per non far ridurre a 1 il numero di caratteri estratti, dato che nel SQL iniziale estrae solo '*'
  selTipoOpe.Open;
  selT020.SetVariable('DECORRENZA_FINE',EncodeDate(3999,12,31));
  selT020.Open;
  selT021.SetVariable('CODICE','*');
  selT021.SetVariable('TURNO_ABILITA','S');
  selT021.Open;
  selGiorni.Open;
  selT605.Open;
  selT605.Filtered:=True;
  selT265.Open;
end;

procedure TA206FCondizioniTurniMW.RefreshDataSet;
var sCondTipoOpeT430:String;
begin
  if selT606 = nil then exit;
  CondOK:=selT605a.SearchRecord('CODICE',selT606.FieldByName('COD_CONDIZIONE').AsString,[srFromBeginning]);
  R180SetVariable(selT603,'DECORRENZA',selT606.FieldByName('DECORRENZA').AsDateTime);
  R180SetVariable(selT603,'DECORRENZA_FINE',selT606.FieldByName('DECORRENZA_FINE').AsDateTime);
  R180SetVariable(selT603,'SQUADRA_ABILITA',IfThen(CondOK,selT605a.FieldByName('SQUADRA_ABILITA').AsString,'N'));
  selT603.Open;
  if not selT606.FieldByName('DECORRENZA').IsNull
  and not selT606.FieldByName('DECORRENZA_FINE').IsNull then
  begin
    R180SetVariable(selT430,'DECORRENZA',selT606.FieldByName('DECORRENZA').AsDateTime);
    R180SetVariable(selT430,'DECORRENZA_FINE',selT606.FieldByName('DECORRENZA_FINE').AsDateTime);
  end;
  selT430.Open;
  selT430.First;
  while not selT430.Eof do
  begin
    sCondTipoOpeT430:=sCondTipoOpeT430 + ' union select ''' + selT430.FieldByName('TIPOOPE').AsString + ''' TIPOOPE, null DESCRIZIONE from dual';
    selT430.Next;
  end;
  R180SetVariable(selTipoOpe,'TIPOOPE_ABILITA',IfThen(CondOK,selT605a.FieldByName('TIPOOPE_ABILITA').AsString,'N'));
  R180SetVariable(selTipoOpe,'COND_TIPIOPE_T430',sCondTipoOpeT430); //serve a non rieseguire sempre la query pesante su T430
  if not selTipoOpe.Active then
    selTipoOpe.FieldByName('TIPOOPE').Size:=5; //serve per non far ridurre a 1 il numero di caratteri estratti, dato che nel SQL iniziale estrae solo '*'
  selTipoOpe.Open;
  R180SetVariable(selT020,'DECORRENZA_FINE',selT606.FieldByName('DECORRENZA_FINE').AsDateTime);
  selT020.Open;
  R180SetVariable(selT021,'CODICE',selT606.FieldByName('COD_ORARIO').AsString);
  R180SetVariable(selT021,'TURNO_ABILITA',IfThen(CondOK,selT605a.FieldByName('TURNO_ABILITA').AsString,'N'));
  selT021.Open;
end;

procedure TA206FCondizioniTurniMW.PulisciValori;
var ValNew:String;
begin
  if selT606 = nil then exit;
  if selT606.State in [dsEdit,dsInsert] then
  begin
    ValNew:=selT606.FieldByName('COD_SQUADRA').AsString;
    if not CondOK or (selT605a.FieldByName('SQUADRA_ABILITA').AsString = 'N') then
      ValNew:='*'
    else if VarToStr(selT603.Lookup('CODICE',selT606.FieldByName('COD_SQUADRA').AsString,'CODICE')) = '' then
      ValNew:='';
    if selT606.FieldByName('COD_SQUADRA').AsString <> ValNew then
      selT606.FieldByName('COD_SQUADRA').AsString:=ValNew;

    ValNew:=selT606.FieldByName('COD_TIPOOPE').AsString;
    if not CondOK or (selT605a.FieldByName('TIPOOPE_ABILITA').AsString = 'N') then
      ValNew:='*'
    else if VarToStr(selTipoOpe.Lookup('TIPOOPE',selT606.FieldByName('COD_TIPOOPE').AsString,'TIPOOPE')) = '' then
      ValNew:='';
    if selT606.FieldByName('COD_TIPOOPE').AsString <> ValNew then
      selT606.FieldByName('COD_TIPOOPE').AsString:=ValNew;

    ValNew:=selT606.FieldByName('COD_ORARIO').AsString;
    if not CondOK or (selT605a.FieldByName('ORARIO_ABILITA').AsString = 'N') then
      ValNew:='*'
    else if VarToStr(selT020.Lookup('CODICE',selT606.FieldByName('COD_ORARIO').AsString,'CODICE')) = '' then
      ValNew:='';
    if selT606.FieldByName('COD_ORARIO').AsString <> ValNew then
      selT606.FieldByName('COD_ORARIO').AsString:=ValNew;

    ValNew:=selT606.FieldByName('SIGLA_TURNO').AsString;
    if not CondOK or (selT605a.FieldByName('TURNO_ABILITA').AsString = 'N') then
      ValNew:='*'
    else if VarToStr(selT021.Lookup('SIGLATURNI',selT606.FieldByName('SIGLA_TURNO').AsString,'SIGLATURNI')) = '' then
      ValNew:='';
    if selT606.FieldByName('SIGLA_TURNO').AsString <> ValNew then
      selT606.FieldByName('SIGLA_TURNO').AsString:=ValNew;

    ValNew:=selT606.FieldByName('COD_GIORNO').AsString;
    if not CondOK or (selT605a.FieldByName('GIORNO_ABILITA').AsString = 'N') then
      ValNew:='*'
    else if VarToStr(selGiorni.Lookup('CODICE',selT606.FieldByName('COD_GIORNO').AsString,'CODICE')) = '' then
      ValNew:='';
    if selT606.FieldByName('COD_GIORNO').AsString <> ValNew then
      selT606.FieldByName('COD_GIORNO').AsString:=ValNew;

    if not CondOK
    or (    (selT605a.FieldByName('MINIMO_ABILITA').AsString = 'N')
        and (selT606.FieldByName('MINIMO').AsString <> '')) then
      selT606.FieldByName('MINIMO').AsString:='';

    if not CondOK
    or (    (selT605a.FieldByName('OTTIMALE_ABILITA').AsString = 'N')
        and (selT606.FieldByName('OTTIMALE').AsString <> '')) then
      selT606.FieldByName('OTTIMALE').AsString:='';

    if not CondOK
    or (    (selT605a.FieldByName('MASSIMO_ABILITA').AsString = 'N')
        and (selT606.FieldByName('MASSIMO').AsString <> '')) then
      selT606.FieldByName('MASSIMO').AsString:='';

    if not CondOK
    or (    (selT605a.FieldByName('VALORE_ABILITA').AsString = 'N')
        and (selT606.FieldByName('VALORE').AsString <> '')) then
      selT606.FieldByName('VALORE').AsString:='';
  end;
end;

procedure TA206FCondizioniTurniMW.selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=(DataSet.FieldByName('CODICE').AsString = '*') or A000FiltroDizionario('SQUADRE TURNI',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA206FCondizioniTurniMW.selT605FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=(TipoCond = 'E') or
          ((TipoCond = 'G') and (VarToStr(selT605a.Lookup('CODICE',selT605.FieldByName('CODICE').AsString,'GENERALE')) = 'S')) or
          ((TipoCond = 'I') and (VarToStr(selT605a.Lookup('CODICE',selT605.FieldByName('CODICE').AsString,'INDIVIDUALE')) = 'S'));
end;

procedure TA206FCondizioniTurniMW.selT606AfterScroll;
begin
  RefreshDataSet;
end;

procedure TA206FCondizioniTurniMW.selT606OnCalcFields;
begin
  if selT606 = nil then exit;
  RefreshDataSet;
  selT606.FieldByName('DESC_SQUADRA').AsString:=VarToStr(selT603.Lookup('CODICE',selT606.FieldByName('COD_SQUADRA').AsString,'DESCRIZIONE'));
  selT606.FieldByName('DESC_TIPOOPE').AsString:=VarToStr(selTipoOpe.Lookup('TIPOOPE',selT606.FieldByName('COD_TIPOOPE').AsString,'DESCRIZIONE'));
  selT606.FieldByName('DESC_ORARIO').AsString:=VarToStr(selT020.Lookup('CODICE',selT606.FieldByName('COD_ORARIO').AsString,'DESCRIZIONE'));
  selT606.FieldByName('DESC_SIGLATURNO').AsString:=VarToStr(selT021.Lookup('SIGLATURNI',selT606.FieldByName('SIGLA_TURNO').AsString,'DESCRIZIONE'));
end;

function TA206FCondizioniTurniMW.selT606FilterRecord: Boolean;
begin
  Result:=(selT606.GetVariable('PROGRESSIVO') <> -2) or
          (selT606.FieldByName('PROGRESSIVO').AsInteger = -1) or
          (VarToStr(selAnagrafe.Lookup('PROGRESSIVO',selT606.FieldByName('PROGRESSIVO').AsInteger,'PROGRESSIVO')) = selT606.FieldByName('PROGRESSIVO').AsString);
  Result:=Result and ((selT606.FieldByName('COD_SQUADRA').AsString = '*') or A000FiltroDizionario('SQUADRE TURNI',selT606.FieldByName('COD_SQUADRA').AsString));
end;

procedure TA206FCondizioniTurniMW.selT606OnNewRecord(Prog:Integer);
begin
  selT606.FieldByName('PROGRESSIVO').AsInteger:=Prog;
  selT606.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(3999,12,31);
end;

procedure TA206FCondizioniTurniMW.selT606BeforePost;
begin
  CondOK:=selT605a.SearchRecord('CODICE',selT606.FieldByName('COD_CONDIZIONE').AsString,[srFromBeginning]);
  if not CondOK then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('COD_CONDIZIONE').DisplayLabel]));
  PulisciValori;
  if Trim(selT606.FieldByName('COD_SQUADRA').AsString) = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('COD_SQUADRA').DisplayLabel]));
  if Trim(selT606.FieldByName('COD_TIPOOPE').AsString) = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('COD_TIPOOPE').DisplayLabel]));
  if Trim(selT606.FieldByName('COD_ORARIO').AsString) = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('COD_ORARIO').DisplayLabel]));
  if Trim(selT606.FieldByName('SIGLA_TURNO').AsString) = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('SIGLA_TURNO').DisplayLabel]));
  if Trim(selT606.FieldByName('COD_GIORNO').AsString) = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('COD_GIORNO').DisplayLabel]));
  if (selT605a.FieldByName('MINIMO_OBBLIGA').AsString = 'S') and (Trim(selT606.FieldByName('MINIMO').AsString) = '') then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('MINIMO').DisplayLabel]));
  if (selT605a.FieldByName('OTTIMALE_OBBLIGA').AsString = 'S') and (Trim(selT606.FieldByName('OTTIMALE').AsString) = '') then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('OTTIMALE').DisplayLabel]));
  if (selT605a.FieldByName('MASSIMO_OBBLIGA').AsString = 'S') and (Trim(selT606.FieldByName('MASSIMO').AsString) = '') then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('MASSIMO').DisplayLabel]));
  if (selT605a.FieldByName('VALORE_OBBLIGA').AsString = 'S') and (Trim(selT606.FieldByName('VALORE').AsString) = '') then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT606.FieldByName('VALORE').DisplayLabel]));
end;

end.
