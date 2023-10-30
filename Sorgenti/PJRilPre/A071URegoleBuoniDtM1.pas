unit A071URegoleBuoniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants,A000UMessaggi;

type
  TA071FRegoleBuoniDtM1 = class(TDataModule)
    DSource: TDataSource;
    QTabs: TOracleDataSet;
    QSource: TOracleDataSet;
    Q670: TOracleDataSet;
    Q670CODICE: TStringField;
    Q670PASTO_TICKET: TStringField;
    Q670ASSENZA: TStringField;
    Q670PRESENZA: TStringField;
    Q670OREMINIME: TDateTimeField;
    Q670CAUS_TICKET: TStringField;
    Q670DA1: TDateTimeField;
    Q670A1: TDateTimeField;
    Q670DA2: TDateTimeField;
    Q670A2: TDateTimeField;
    Q670D_Codice: TStringField;
    Q670NONLAVORATIVO: TStringField;
    Q670FORZAMATURAZIONE: TStringField;
    Q670INIBMATURAZIONE: TStringField;
    Q670ORARISPEZZATI: TStringField;
    Q265: TOracleDataSet;
    Q275: TOracleDataSet;
    Q305: TOracleDataSet;
    Q670INTERVALLOMIN: TStringField;
    Q670INTERVALLOMAX: TStringField;
    Q670MESE_ASSENZE: TIntegerField;
    Q670ORE_MATTINA: TStringField;
    Q670ORE_POMERIGGIO: TStringField;
    Q670CONGUAGLIO_MAX: TIntegerField;
    Q670PERIODICITA_ACQUISTO: TStringField;
    Q670ACQUISTO_TEORICO: TStringField;
    Q670HHMIN_ACQUISTO: TStringField;
    Q670ASSENZE_ACQUISTO: TStringField;
    Q670MEDIAMAX_ACQUISTO: TIntegerField;
    Q670MEDIAMIN_ACQUISTO: TIntegerField;
    Q670ACCESSI_MENSA: TStringField;
    Q670ACQUISTO_MINIMO: TIntegerField;
    Q670RESTITUZIONE_MAX: TIntegerField;
    Q670PAUSA_MENSA: TStringField;
    Q670MISSIONI: TStringField;
    Q670DEBITO_GIORN_MIN: TStringField;
    Q670GIORNI_FISSI: TStringField;
    Q670ECCEDENZA_MIN: TStringField;
    Q670NUM_MAX_BUONI: TIntegerField;
    Q670CONGUAGLIO_PREC_MAX: TIntegerField;
    Q670RESIDUO_PRECEDENTE: TDateTimeField;
    Q670OREMIN_NETTOPM: TStringField;
    Q670INIZIO_POMERIGGIO: TStringField;
    Q670PAUSA_MENSA_GESTITA: TStringField;
    Q670OREMINIME_FASCE: TStringField;
    Q670INTERVALLO_EFFETTIVO: TStringField;
    Q670FASCIA1_ESCLUSIVA: TStringField;
    Q670REGOLA_SUCCESSIVA: TStringField;
    Q670D_RegolaSuccessiva: TStringField;
    selT670lkp: TOracleDataSet;
    dsrT670lkp: TDataSource;
    Q670FASCE_MATPOM_PMT: TStringField;
    Q670REGOLA_RIENTRO_POMERIDIANO: TStringField;
    Q670RIENTRO_MASSIMO_PM: TStringField;
    Q670TIPO_GIORNI_FISSI: TStringField;
    Q670DEBITO_MIN: TStringField;
    Q670DEBITO_MAX: TStringField;
    Q670ASSENZA_PM: TStringField;
    Q670GGLAV_SEMPRE_CALENDARIO: TStringField;
    Q670GGLAV_NOPIANIF_CALENDARIO: TStringField;
    Q670TURNILAV_GG: TIntegerField;
    Q670TURNILAV_ORE: TStringField;
    Q670RECUPERO_DEBITO_START: TDateTimeField;
    Q670RECUPERO_DEBITO_MM: TIntegerField;
    Q670SALDO_ANNUO_MINIMO: TStringField;
    Q670INTERVALLO_INTERNO_PMT: TStringField;
    dsrCols: TDataSource;
    selCols: TOracleDataSet;
    Q670RICHIESTA_NOME_DATO_LIBERO: TStringField;
    Q670RICHIESTA_VALORE_DATO_LIBERO: TStringField;
    Q670RICHIESTA_GG_DAL: TIntegerField;
    Q670RICHIESTA_GG_AL: TIntegerField;
    Q670RICHIESTA_MAX_TICKET_MESE: TIntegerField;
    Q670REGOLA_CUSTOM: TStringField;
    selT670RegolaCustom: TOracleQuery;
    Q670ACQUISTO_QUANTITA: TIntegerField;
    Q670NUM_MAX_BUONI_SETTIMANA: TIntegerField;
    procedure Q670OREMINIMEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure A071FRegoleBuoniDtM1Create(Sender: TObject);
    procedure Q670NewRecord(DataSet: TDataSet);
    procedure BDEQ670OREMINIMESetText(Sender: TField; const Text: String);
    procedure Q670AfterCancel(DataSet: TDataSet);
    procedure Q670AfterPost(DataSet: TDataSet);
    procedure Q670AfterDelete(DataSet: TDataSet);
    procedure Q670BeforePost(DataSet: TDataSet);
    procedure Q670BeforeDelete(DataSet: TDataSet);
    procedure Q670INTERVALLOMINValidate(Sender: TField);
    procedure Q670AfterScroll(DataSet: TDataSet);
    procedure Q670DEBITO_GIORN_MINValidate(Sender: TField);
    procedure Q670ECCEDENZA_MINValidate(Sender: TField);
    procedure Q670A2GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Q670RECUPERO_DEBITO_STARTGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Q670RECUPERO_DEBITO_STARTSetText(Sender: TField;
      const Text: string);
    procedure Q670TURNILAV_OREValidate(Sender: TField);
    procedure Q670SALDO_ANNUO_MINIMOValidate(Sender: TField);
  private
    { Private declarations }
    Elenco:TStringList;
    procedure GetPeriodicitaAcquisto;
    procedure TrovaVariabili;
    procedure ElaboraVariabili;
  public
    { Public declarations }
    procedure EseguiRegolaCustom;
  end;

var
  A071FRegoleBuoniDtM1: TA071FRegoleBuoniDtM1;

implementation

uses A071URegoleBuoni;

{$R *.DFM}

procedure TA071FRegoleBuoniDtM1.A071FRegoleBuoniDtM1Create(
  Sender: TObject);
var i:Integer;
    //S,T,C,Storico:String;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  A071FRegoleBuoni.lblCodice.Caption:=Parametri.CampiRiferimento.C4_BuoniMensa;
  QSource.Close;
  if A000LookupTabella(Parametri.CampiRiferimento.C4_BuoniMensa,QSource) then
  begin
    if QSource.VariableIndex('DECORRENZA') >= 0 then
      QSource.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    QSource.Open;
  end
  else
  begin
    ShowMessage(A000MSG_A071_ERR_DATO_NON_SPECIF);
    Q670.ReadOnly:=True;
  end;
  selCols.Open;
  Q265.Open;
  Q275.Open;
  Q305.Open;
  A071FRegoleBuoni.DButton.DataSet:=Q670;
  Q670.Open;
end;

procedure TA071FRegoleBuoniDtM1.Q670NewRecord(DataSet: TDataSet);
begin
  Q670.FieldByName('PASTO_TICKET').AsString:='B';
  Q670.FieldByName('NONLAVORATIVO').AsString:='N';
  Q670.FieldByName('ORARISPEZZATI').AsString:='N';
  Q670.FieldByName('OREMINIME').AsDateTime:=EncodeDate(1900,1,1);
  A071FRegoleBuoni.edtResiduoPrecedente.DateTime:=Q670.FieldByName('RESIDUO_PRECEDENTE').AsDateTime;
end;

procedure TA071FRegoleBuoniDtM1.BDEQ670OREMINIMESetText(Sender: TField;
  const Text: String);
begin
  {$I CampoOra}
end;

procedure TA071FRegoleBuoniDtM1.Q670A2GetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' 
  else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA071FRegoleBuoniDtM1.Q670AfterCancel(DataSet: TDataSet);
begin
  Q670.CancelUpdates;
  GetPeriodicitaAcquisto;
  A071FRegoleBuoni.edtResiduoPrecedente.DateTime:=Q670.FieldByName('RESIDUO_PRECEDENTE').AsDateTime;
end;

procedure TA071FRegoleBuoniDtM1.Q670AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=Q670.FieldByName('CODICE').AsString;
  SessioneOracle.ApplyUpdates([Q670],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
  Q670.Locate('CODICE',S,[]);
end;

procedure TA071FRegoleBuoniDtM1.Q670AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q670],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA071FRegoleBuoniDtM1.Q670BeforePost(DataSet: TDataSet);
var
  i:Integer;
  S:String;
begin
  S:='NNNNNNNNNNNN';
  for i:=0 to A071FRegoleBuoni.chklstMesiAcq.Items.Count - 1 do
  begin
    if A071FRegoleBuoni.chklstMesiAcq.Checked[i] then
      S[i + 1]:='S';
  end;
  Q670PERIODICITA_ACQUISTO.AsString:=S;
  S:='';
  for i:=0 to A071FRegoleBuoni.clbGiorniFissi.Items.Count - 1 do
  begin
    if A071FRegoleBuoni.clbGiorniFissi.Checked[i] then
      S:=S + IntToStr(i + 1);
  end;
  Q670GIORNI_FISSI.AsString:=S;
  Q670NUM_MAX_BUONI.AsString:=A071FRegoleBuoni.edtNumMaxBuoni.Text;
  Q670NUM_MAX_BUONI_SETTIMANA.AsString:=A071FRegoleBuoni.edtNumMaxBuoniSett.Text;
  Q670TURNILAV_GG.AsString:=A071FRegoleBuoni.edtTurniLavGG.Text;
  Q670RECUPERO_DEBITO_MM.AsString:=A071FRegoleBuoni.edtRecupDebitoMM.Text;
  if not Q670RECUPERO_DEBITO_START.IsNull then
    Q670RECUPERO_DEBITO_START.AsDateTime:=R180InizioMese(Q670RECUPERO_DEBITO_START.AsDateTime);
  if A071FRegoleBuoni.edtResiduoPrecedente.Date = 0 then
    Q670Residuo_Precedente.Clear
  else
    Q670Residuo_Precedente.AsDateTime:=R180InizioMese(Trunc(A071FRegoleBuoni.edtResiduoPrecedente.Date));
  if QueryPK1.EsisteChiave('T670_REGOLEBUONI',Q670.RowId,Q670.State,['CODICE'],[Q670Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  if not(Q670Da1.IsNull) and not(Q670A1.IsNull) then
    if Q670Da1.AsDateTime >= Q670A1.AsDateTime then
      raise Exception.Create('L''intervallo della 1°fascia di maturazione non è valido!');
  if not(Q670Da2.IsNull) and not(Q670A2.IsNull) then
    if Q670Da2.AsDateTime >= Q670A2.AsDateTime then
      raise Exception.Create('L''intervallo della 2°fascia di maturazione non è valido!');
  if R180OreMinutiExt(Q670IntervalloMin.AsString) >
     R180OreMinutiExt(Q670IntervalloMax.AsString) then
    raise Exception.Create('I limiti dell''Intervallo Mensa non sono validi!');

  if (A071FRegoleBuoni.DButton.State in [dsBrowse,dsEdit,dsInsert]) and (A071FRegoleBuoni.DA1.Field <> nil) then
    if (Q670.FieldByName('OREMINIME_FASCE').AsString = 'S') or (Q670.FieldByName('OREMINIME_FASCE').AsString = 'E') then
      if (A071FRegoleBuoni.DA1.Field.IsNull or A071FRegoleBuoni.A1.Field.IsNull) and
         (A071FRegoleBuoni.DA2.Field.IsNull or A071FRegoleBuoni.A2.Field.IsNull) then
        raise Exception.Create('Fascia/e non valorizzate.');

  // richieste online

  // dato libero per attivazione richieste online
  if Q670.FieldByName('RICHIESTA_NOME_DATO_LIBERO').IsNull then
  begin
    // se il dato libero non è indicato pulisce il valore
    Q670.FieldByName('RICHIESTA_VALORE_DATO_LIBERO').AsString:='';
  end
  else
  begin
    // se il dato libero è indicato richiede obbligatoriamente un valore per il confronto
    if Q670.FieldByName('RICHIESTA_VALORE_DATO_LIBERO').AsString.Trim = '' then
      raise Exception.CreateFmt('Il valore del dato anagrafico %s deve essere indicato!',[Q670.FieldByName('RICHIESTA_NOME_DATO_LIBERO').AsString]);
  end;

  // periodo di validità per inserimento richieste
  // se non indicato non effettua controlli
  if (not Q670.FieldByName('RICHIESTA_GG_DAL').IsNull) or
     (not Q670.FieldByName('RICHIESTA_GG_AL').IsNull) then
  begin
    // è indicato almeno un dato del periodo: richiede che siano indicati entrambi
    if Q670.FieldByName('RICHIESTA_GG_DAL').IsNull then
      raise Exception.Create('È necessario indicare il primo giorno del periodo di inserimento richieste!')
    else if Q670.FieldByName('RICHIESTA_GG_AL').IsNull then
      raise Exception.Create('È necessario indicare l''ultimo giorno del periodo di inserimento richieste!');

    // verifica che il periodo indicato sia valido
    if Q670.FieldByName('RICHIESTA_GG_DAL').AsInteger > Q670.FieldByName('RICHIESTA_GG_AL').AsInteger then
      raise Exception.Create('Il periodo di inserimento richieste indicato non è valido!');
  end;

  // log
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA071FRegoleBuoniDtM1.Q670BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA071FRegoleBuoniDtM1.Q670INTERVALLOMINValidate(Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA071FRegoleBuoniDtM1.GetPeriodicitaAcquisto;
var i,y:Integer;
begin
  with A071FRegoleBuoni.chklstMesiAcq do
    for i:=0 to Items.Count - 1 do
      Checked[i]:=R180CarattereDef(Q670PERIODICITA_ACQUISTO.AsString,i + 1,'N') = 'S';
  with A071FRegoleBuoni.clbGiorniFissi do
  begin
    for i:=0 to Items.Count - 1 do
      Checked[i]:=False;
    for i:=0 to Items.Count - 1 do
      for y:=1 to Length(Q670GIORNI_FISSI.AsString) do
        if (i + 1) = StrToIntDef(Q670GIORNI_FISSI.AsString[y],0) then
          Checked[i]:=True;
  end;
  A071FRegoleBuoni.edtNumMaxBuoni.Text:=Q670NUM_MAX_BUONI.AsString;
  A071FRegoleBuoni.edtNumMaxBuoniSett.Text:=Q670NUM_MAX_BUONI_SETTIMANA.AsString;
end;

procedure TA071FRegoleBuoniDtM1.TrovaVariabili;
var
  Stringa,S:String;
  i,x:Integer;
begin
  FreeAndNil(Elenco);
  Stringa:=Q670.FieldByName('REGOLA_CUSTOM').AsString;
  Elenco:=FindVariables(Stringa, False);
end;

procedure TA071FRegoleBuoniDtM1.ElaboraVariabili;
var i:integer;
begin
  selT670RegolaCustom.DeleteVariables;
  if Elenco.Count > 0 then
  begin
    for i:=0 to Elenco.Count - 1 do
    begin
      if Elenco[i].ToUpper = 'PROGRESSIVO' then
      begin
        selT670RegolaCustom.DeclareVariable(Elenco[i],otInteger);
      end
      else if Elenco[i].ToUpper = 'DATA' then
        begin
        selT670RegolaCustom.DeclareVariable(Elenco[i],otDate);
        end
      else if Elenco[i].ToUpper = 'ORE_GG' then
        begin
        selT670RegolaCustom.DeclareVariable(Elenco[i],otInteger);
        end
      else
      begin
        selT670RegolaCustom.DeclareVariable(Elenco[i],otString);
      end;
    end;
  end;
end;

procedure TA071FRegoleBuoniDtM1.EseguiRegolaCustom;
begin
  if (Q670.FindField('REGOLA_CUSTOM') <> nil) and
     (not Q670.FieldByName('REGOLA_CUSTOM').AsString.IsEmpty) then
  begin
    // cerco le variabili dichiarate nello script
    selT670RegolaCustom.Close;
    selT670RegolaCustom.SQL.Clear;
    selT670RegolaCustom.SQL.Text:='select ' + Q670.FieldByName('REGOLA_CUSTOM').AsString + ' from dual';
    TrovaVariabili;
    ElaboraVariabili;
    // esegue richiamo alla funzione oracle
    try
      selT670RegolaCustom.Execute;
    except
      on E:Exception do
        raise Exception.Create(Format('REGOLA_CUSTOM eseguita con errori: %s',[E.Message]));
    end;
  end;
end;

procedure TA071FRegoleBuoniDtM1.Q670AfterScroll(DataSet: TDataSet);
begin
  A071FRegoleBuoni.edtResiduoPrecedente.DateTime:=Q670.FieldByName('RESIDUO_PRECEDENTE').AsDateTime;
  GetPeriodicitaAcquisto;
  A071FRegoleBuoni.edtTurniLavGG.Text:=Q670TURNILAV_GG.AsString;
  A071FRegoleBuoni.edtRecupDebitoMM.Text:=Q670RECUPERO_DEBITO_MM.AsString;
  selT670lkp.Close;
  selT670lkp.SetVariable('CODICE',Q670.FieldByName('CODICE').AsString);
  selT670lkp.Open;
end;

procedure TA071FRegoleBuoniDtM1.Q670DEBITO_GIORN_MINValidate(Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA071FRegoleBuoniDtM1.Q670ECCEDENZA_MINValidate(Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA071FRegoleBuoniDtM1.Q670OREMINIMEGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA071FRegoleBuoniDtM1.Q670RECUPERO_DEBITO_STARTGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('mm/yyyy',Sender.AsDateTime);
end;

procedure TA071FRegoleBuoniDtM1.Q670RECUPERO_DEBITO_STARTSetText(Sender: TField;
  const Text: string);
begin
  if Trim(Text) <> '/' then
    Sender.AsString:=FormatDateTime('dd/mm/yyyy',StrToDate('01/' + Text))
  else
    Sender.Clear;
end;

procedure TA071FRegoleBuoniDtM1.Q670SALDO_ANNUO_MINIMOValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA071FRegoleBuoniDtM1.Q670TURNILAV_OREValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

end.
