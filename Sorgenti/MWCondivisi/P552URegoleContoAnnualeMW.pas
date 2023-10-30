unit P552URegoleContoAnnualeMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, USelI010,
  A000UInterfaccia, OracleData, A000UMessaggi, C180FunzioniGenerali,
  A000UCostanti, Generics.Collections, Oracle, Variants;

type
  TDettaglioRegole = record
    TabTredicesimaAC: String;
    RigheTredicesimaAC: String;
    TabTredicesimaAP: String;
    RigheTredicesimaAP: String;
    TabArretratiAC: String;
    RigheArretratiAC: String;
    TabArretratiAP: String;
    RigheArretratiAP: String;
    TabElab: String;
    AnnoElab:Integer;
    bAccorpamento: boolean;
    bTabSostitutive: boolean;
  end;

  TP552FRegoleContoAnnualeMW = class(TR005FDataModuleMW)
    dsrI010: TDataSource;
    selP050: TOracleDataSet;
    dsrP050: TDataSource;
    selP552Righe: TOracleDataSet;
    selP552RigheRIGA: TIntegerField;
    selP552RigheDESCRIZIONE: TStringField;
    selP552RigheVALORE_COSTANTE: TStringField;
    selP552RigheCOD_ARROTONDAMENTO: TStringField;
    selP552RigheDesc_Data_Accorp: TStringField;
    selP552RigheCODICI_ACCORPAMENTOVOCI: TStringField;
    selP552RigheNUMERO_TREDCORR: TStringField;
    selP552RigheNUMERO_TREDPREC: TStringField;
    selP552RigheNUMERO_ARRCORR: TStringField;
    selP552RigheNUMERO_ARRPREC: TStringField;
    selP552RigheREGOLA_MODIFICABILE: TStringField;
    selP552RigheREGOLA_CALCOLO_MANUALE: TStringField;
    selP552RigheANNO: TIntegerField;
    selP552RigheCOD_TABELLA: TStringField;
    selP552RigheCOLONNA: TIntegerField;
    selP552RigheTIPO_TABELLA_RIGHE: TStringField;
    selP552RigheREGOLA_CALCOLO_AUTOMATICA: TStringField;
    selP552RigheDATA_ACCORPAMENTO: TStringField;
    selP552RigheFILTRO_DIPENDENTI: TStringField;
    dsrP552Righe: TDataSource;
    selP552Colonne: TOracleDataSet;
    selP552ColonneCOLONNA: TIntegerField;
    selP552ColonneDESCRIZIONE: TStringField;
    selP552ColonneVALORE_COSTANTE: TStringField;
    selP552ColonneCOD_ARROTONDAMENTO: TStringField;
    selP552ColonneDesc_Data_Accorp: TStringField;
    selP552ColonneNUMERO_TREDCORR: TStringField;
    selP552ColonneNUMERO_TREDPREC: TStringField;
    selP552ColonneNUMERO_ARRCORR: TStringField;
    selP552ColonneNUMERO_ARRPREC: TStringField;
    selP552ColonneREGOLA_MODIFICABILE: TStringField;
    selP552ColonneREGOLA_CALCOLO_MANUALE: TStringField;
    selP552ColonneANNO: TIntegerField;
    selP552ColonneCOD_TABELLA: TStringField;
    selP552ColonneRIGA: TIntegerField;
    selP552ColonneTIPO_TABELLA_RIGHE: TStringField;
    selP552ColonneCODICI_ACCORPAMENTOVOCI: TStringField;
    selP552ColonneREGOLA_CALCOLO_AUTOMATICA: TStringField;
    selP552ColonneDATA_ACCORPAMENTO: TStringField;
    selP552ColonneFILTRO_DIPENDENTI: TStringField;
    dsrP552Colonne: TDataSource;
    QSQL: TOracleDataSet;
    selP551: TOracleDataSet;
    selP551ANNO: TIntegerField;
    selP551COD_TABELLA: TStringField;
    selP551NUM_CAMPO: TIntegerField;
    selP551TIPO_CAMPO: TStringField;
    selP551DESCRIZIONE: TStringField;
    selP551FORMATO: TStringField;
    selP551LUNGHEZZA: TIntegerField;
    selP551LungProg: TIntegerField;
    selP551FORMULA: TStringField;
    dsrP551: TDataSource;
    selP215: TOracleDataSet;
    selP552Ricerca: TOracleDataSet;
    delP552: TOracleQuery;
    delP551: TOracleQuery;
    selCheckAnagrafe: TOracleQuery;
    selP552RigheSCRIPT_INIZIALE: TStringField;
    selP552ColonneSCRIPT_INIZIALE: TStringField;
    selP552RighePARAMETRO_2: TStringField;
    selP552ColonnePARAMETRO_2: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selP552RigheColonneCalcFields(DataSet: TDataSet);
    procedure selP552RigheColonneAfterDelete(DataSet: TDataSet);
    procedure selP552RigheColonneAfterPost(DataSet: TDataSet);
    procedure selP552RigheColonneBeforeDelete(DataSet: TDataSet);
    procedure selP551AfterDelete(DataSet: TDataSet);
    procedure selP551AfterPost(DataSet: TDataSet);
    procedure selP551BeforeDelete(DataSet: TDataSet);
    procedure selP551CalcFields(DataSet: TDataSet);
    procedure selP551NewRecord(DataSet: TDataSet);
  private
    FselP552_Funzioni: TOracleDataset;
  public
    selI010:TselI010;
    bLogRigheColone:boolean;
    function GetMaxAnno: Integer;
    procedure DeleteP552(TabElab, AnnoElab: String);
    function NextNumCampo(TabElab, AnnoElab: String): Integer;
    function ElencoCampiFormula: TElencoValoriChecklist;
    procedure getLstFormato(var lstElenco: TList<TItemsValues>);
    procedure selP552RigheColonneBeforePost(Dataset: TDataset; DettaglioRegole: TDettaglioRegole);
    procedure getElementiCombo(TipoElab: String; AnnoElab: String; Tabella: String; var lstElenco: TList<TItemsValues>);
    procedure ImpostaAnnoSelP552Ricerca(Anno: Integer);
    function TrasformaV430(X: String): String;
    procedure selP552AfterScroll;
    procedure selP552NewRecord(Anno: Integer);
    procedure selP552BeforePost;
    procedure ImpostaSelP552Righe;
    procedure ImpostaSelP552Colonne;
    procedure ImpostaSelP551;
    procedure getLstTabelleDettaglio(var lstElenco: TList<TItemsValues>);
    procedure getLstTipoCampo(TabElab: String; AnnoElab: String;var lstElenco: TList<TItemsValues>);
    function ElencoAccorpamenti: TElencoValoriChecklist;
    property SelP552_Funzioni: TOracleDataset read FselP552_Funzioni write FselP552_Funzioni;
  end;

  const
    TIPO_ELAB_RIGA    = 'Riga';
    TIPO_ELAB_COLONNA = 'Colonna';
implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TP552FRegoleContoAnnualeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,
    'DECODE(SUBSTR(NOME_CAMPO,1,4),''T430'',''T430_STORICO'',''P430'',''P430_ANAGRAFICO'','''') TABELLA, ' +
      'REPLACE(REPLACE(NOME_CAMPO,''T430'',''''),''P430'','''') NOME_CAMPO, ' +
      'NOME_LOGICO',
    'TABLE_NAME = ''V430_STORICO'' AND SUBSTR(NOME_CAMPO,5,2) <> ''D_''' +
      ' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''PROGRESSIVO'' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''DATADECORRENZA''' +
      ' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''DATAFINE'' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''PROGRESSIVO''' +
      ' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''DECORRENZA'' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''DECORRENZA_FINE''',
    'NOME_LOGICO');
  dsrI010.DataSet:=selI010;
  bLogRigheColone:=True;
end;

function TP552FRegoleContoAnnualeMW.TrasformaV430(X:String):String;
var Apice:Boolean;
    i:Integer;
begin
  Result:='';
  i:=1;
  Apice:=False;
  while i <= Length(X) do
  begin
    if X[i] = '''' then
      Apice:=not Apice;
    if (not Apice) and (Copy(X,i,5) = 'V430.') then
    begin
      X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
      inc(i,5);
    end;
    inc(i);
  end;
  Result:=X;
end;

procedure TP552FRegoleContoAnnualeMW.selP551AfterDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP552FRegoleContoAnnualeMW.selP551AfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP552FRegoleContoAnnualeMW.selP551BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TP552FRegoleContoAnnualeMW.selP551CalcFields(DataSet: TDataSet);
begin
  if (selP551.RecordCount > 0) and (selP551.State <> dsInsert) then
  begin
    QSQL.Close;
    QSQL.SQL.Clear;
    QSQL.SQL.Text:='SELECT SUM(LUNGHEZZA) LUNG FROM P551_CONTOANNFILE ' +
                   ' WHERE COD_TABELLA = ''' + selP551.FieldByName('COD_TABELLA').AsString + '''' +
                   '   AND ANNO = ' + IntToStr(selP551.FieldByName('ANNO').AsInteger) +
                   '   AND NUM_CAMPO <= ' + selP551.FieldByName('NUM_CAMPO').AsString;
    QSQL.Open;
    selP551.FieldByName('LungProg').AsInteger:=QSQL.FieldByName('LUNG').AsInteger;
  end
  else
    selP551.FieldByName('LungProg').AsInteger:=0;
end;

procedure TP552FRegoleContoAnnualeMW.selP551NewRecord(DataSet: TDataSet);
begin
  inherited;
  selP551.FieldByName('ANNO').AsInteger:=FselP552_Funzioni.FieldByName('ANNO').AsInteger;
  selP551.FieldByName('COD_TABELLA').AsString:=FselP552_Funzioni.FieldByName('COD_TABELLA').AsString;
end;

procedure TP552FRegoleContoAnnualeMW.selP552AfterScroll;
var
  Anno: Integer;
begin
  selP050.Close;
  Anno:=1899;
  if FselP552_Funzioni.FieldByName('ANNO').AsInteger > 0 then
    Anno:=FselP552_Funzioni.FieldByName('ANNO').AsInteger;
  selP050.SetVariable('DECORRENZA',EncodeDate(Anno,12,31));
  selP050.Open;
end;

procedure TP552FRegoleContoAnnualeMW.selP552NewRecord(Anno: Integer);
begin
  FselP552_Funzioni.FieldByName('ANNO').AsInteger:=Anno;
  FselP552_Funzioni.FieldByName('TIPO_TABELLA_RIGHE').AsString:='0';
end;

procedure TP552FRegoleContoAnnualeMW.selP552RigheColonneAfterPost(DataSet: TDataSet);
begin
  inherited;
  if bLogRigheColone then
    RegistraLog.RegistraOperazione;
end;

procedure TP552FRegoleContoAnnualeMW.selP552RigheColonneBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if bLogRigheColone then
    RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TP552FRegoleContoAnnualeMW.selP552RigheColonneAfterDelete(DataSet: TDataSet);
begin
  inherited;
  if bLogRigheColone then
    RegistraLog.RegistraOperazione;
end;

procedure TP552FRegoleContoAnnualeMW.selP552RigheColonneCalcFields(DataSet: TDataSet);
begin
  if DataSet.FieldByName('DATA_ACCORPAMENTO').AsString = 'NA' then
    DataSet.FieldByName('Desc_Data_Accorp').AsString:='Nessun accorpamento'
  else if DataSet.FieldByName('DATA_ACCORPAMENTO').AsString = 'DC' then
    DataSet.FieldByName('Desc_Data_Accorp').AsString:='Data cedolino'
  else if DataSet.FieldByName('DATA_ACCORPAMENTO').AsString = 'DR' then
    DataSet.FieldByName('Desc_Data_Accorp').AsString:='Data retribuzione'
  else if DataSet.FieldByName('DATA_ACCORPAMENTO').AsString = 'CM' then
    DataSet.FieldByName('Desc_Data_Accorp').AsString:='Data competenza';
end;

procedure TP552FRegoleContoAnnualeMW.selP552BeforePost;
begin
  if Trim(FselP552_Funzioni.FieldByName('COD_TABELLA').AsString)  = '' then
    raise exception.Create(A000MSG_P552_ERR_NO_COD_TABELLA);
  if (FselP552_Funzioni.FieldByName('TIPO_TABELLA_RIGHE').AsString = '1') and
     (Trim(FselP552_Funzioni.FieldByName('VALORE_COSTANTE').AsString) = '') then
    raise exception.Create(A000MSG_P552_ERR_NO_DATO_LIBERO);
  if (FselP552_Funzioni.FieldByName('TIPO_TABELLA_RIGHE').AsString = '3') and
     (Trim(FselP552_Funzioni.FieldByName('VALORE_COSTANTE').AsString) = '') then
    raise exception.Create(A000MSG_P552_ERR_NO_FUNZ_ORACLE);
  if Trim(FselP552_Funzioni.FieldByName('FILTRO_DIPENDENTI').AsString) <> '' then
  begin
    selCheckAnagrafe.SetVariable('FILTRO_DIPENDENTI',
      StringReplace(StringReplace(FselP552_Funzioni.FieldByName('FILTRO_DIPENDENTI').AsString,'T430.','V430.T430',[rfReplaceAll]),'P430.','V430.P430',[rfReplaceAll]));
    selCheckAnagrafe.Execute;
  end;
  FselP552_Funzioni.FieldByName('RIGA').AsInteger:=0;
  FselP552_Funzioni.FieldByName('COLONNA').AsInteger:=0;
end;

procedure TP552FRegoleContoAnnualeMW.ImpostaSelP552Colonne;
var
  bAccorpVisible: Boolean;
begin
  selP552Colonne.Close;
  selP552Colonne.SetVariable('Anno',FselP552_Funzioni.FieldByName('ANNO').AsInteger);
  selP552Colonne.SetVariable('CodTabella',FselP552_Funzioni.FieldByName('COD_TABELLA').AsString);
  selP552Colonne.Open;
  //Se Tipo_Tabella_Righe = 'Accorp.Voci' per le Colonne non faccio vedere dati di dettaglio
  bAccorpVisible:=FselP552_Funzioni.FieldByName('TIPO_TABELLA_RIGHE').AsString <> '2';
  selP552Colonne.FieldByName('VALORE_COSTANTE').Visible:=bAccorpVisible;
  selP552Colonne.FieldByName('Desc_Data_Accorp').Visible:=bAccorpVisible;
  selP552Colonne.FieldByName('COD_ARROTONDAMENTO').Visible:=bAccorpVisible;
  selP552Colonne.FieldByName('PARAMETRO_2').Visible:=bAccorpVisible;
  selP552Colonne.FieldByName('NUMERO_TREDCORR').Visible:=bAccorpVisible;
  selP552Colonne.FieldByName('NUMERO_TREDPREC').Visible:=bAccorpVisible;
  selP552Colonne.FieldByName('NUMERO_ARRCORR').Visible:=bAccorpVisible;
  selP552Colonne.FieldByName('NUMERO_ARRPREC').Visible:=bAccorpVisible;
  selP552Colonne.FieldByName('REGOLA_MODIFICABILE').Visible:=bAccorpVisible;
  selP552Colonne.FieldByName('REGOLA_CALCOLO_MANUALE').Visible:=bAccorpVisible;
  QSQL.Close;
  QSQL.SQL.Clear;
  QSQL.SQL.Add('SELECT DISTINCT DATA_ACCORPAMENTO FROM P552_CONTOANNREGOLE');
  QSQL.SQL.Add(' WHERE COD_TABELLA = ''' + FselP552_Funzioni.FieldByName('COD_TABELLA').AsString + '''');
  QSQL.SQL.Add('   AND ANNO = ' + IntToStr(FselP552_Funzioni.FieldByName('ANNO').AsInteger));
  QSQL.SQL.Add('   AND RIGA = 0 AND COLONNA > 0');
  QSQL.Open;
  if (QSQL.RecordCount = 1) and (QSQL.FieldByName('DATA_ACCORPAMENTO').AsString = 'NA') then
  begin
    selP552Colonne.FieldByName('NUMERO_TREDCORR').Visible:=False;
    selP552Colonne.FieldByName('NUMERO_TREDPREC').Visible:=False;
    selP552Colonne.FieldByName('NUMERO_ARRCORR').Visible:=False;
    selP552Colonne.FieldByName('NUMERO_ARRPREC').Visible:=False;
  end;
end;

procedure TP552FRegoleContoAnnualeMW.ImpostaSelP551;
begin
  selP551.Close;
  selP551.SetVariable('Anno',FselP552_Funzioni.FieldByName('ANNO').AsInteger);
  selP551.SetVariable('CodTabella',FselP552_Funzioni.FieldByName('COD_TABELLA').AsString);
  selP551.Open;
end;

procedure TP552FRegoleContoAnnualeMW.ImpostaSelP552Righe;
var
  bAccorpVisible: Boolean;
begin
  selP552Righe.Close;
  selP552Righe.SetVariable('Anno',FselP552_Funzioni.FieldByName('ANNO').AsInteger);
  selP552Righe.SetVariable('CodTabella',FselP552_Funzioni.FieldByName('COD_TABELLA').AsString);
  selP552Righe.Open;
  //Se Tipo_Tabella_Righe <> 'Accorp.Voci' per le Righe non faccio vedere dati di Accorp.voci
  bAccorpVisible:=FselP552_Funzioni.FieldByName('TIPO_TABELLA_RIGHE').AsString = '2';
  selP552Righe.FieldByName('CODICI_ACCORPAMENTOVOCI').Visible:=bAccorpVisible;
  selP552Righe.FieldByName('Desc_Data_Accorp').Visible:=bAccorpVisible;
  selP552Righe.FieldByName('COD_ARROTONDAMENTO').Visible:=bAccorpVisible;
  selP552Righe.FieldByName('PARAMETRO_2').Visible:=bAccorpVisible;
  selP552Righe.FieldByName('NUMERO_TREDCORR').Visible:=bAccorpVisible;
  selP552Righe.FieldByName('NUMERO_TREDPREC').Visible:=bAccorpVisible;
  selP552Righe.FieldByName('NUMERO_ARRCORR').Visible:=bAccorpVisible;
  selP552Righe.FieldByName('NUMERO_ARRPREC').Visible:=bAccorpVisible;
  selP552Righe.FieldByName('REGOLA_MODIFICABILE').Visible:=bAccorpVisible;
  selP552Righe.FieldByName('REGOLA_CALCOLO_MANUALE').Visible:=bAccorpVisible;
  QSQL.Close;
  QSQL.SQL.Clear;
  QSQL.SQL.Add('SELECT DISTINCT DATA_ACCORPAMENTO FROM P552_CONTOANNREGOLE');
  QSQL.SQL.Add(' WHERE COD_TABELLA = ''' + FselP552_Funzioni.FieldByName('COD_TABELLA').AsString + '''');
  QSQL.SQL.Add('   AND ANNO = ' + IntToStr(FselP552_Funzioni.FieldByName('ANNO').AsInteger));
  QSQL.SQL.Add('   AND RIGA > 0 AND COLONNA = 0');
  QSQL.Open;
  if (QSQL.RecordCount = 1) and (QSQL.FieldByName('DATA_ACCORPAMENTO').AsString = 'NA') then
  begin
    selP552Righe.FieldByName('NUMERO_TREDCORR').Visible:=False;
    selP552Righe.FieldByName('NUMERO_TREDPREC').Visible:=False;
    selP552Righe.FieldByName('NUMERO_ARRCORR').Visible:=False;
    selP552Righe.FieldByName('NUMERO_ARRPREC').Visible:=False;
//        selP552Righe.FieldByName('CODICI_ACCORPAMENTOVOCI').Visible:=False;
  end;
end;

function TP552FRegoleContoAnnualeMW.ElencoCampiFormula: TElencoValoriChecklist;
var
  codice: String;
begin
  Result:=TElencoValoriChecklist.Create;
  with selP552Colonne do
  begin
    First;
    while not Eof do
    begin
      codice:='C' + Format('%3.3d',[FieldByName('COLONNA').AsInteger]);
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%s - %s',[codice, FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

function TP552FRegoleContoAnnualeMW.ElencoAccorpamenti: TElencoValoriChecklist;
var
  codice: String;
begin
  Result:=TElencoValoriChecklist.Create;
  with selP215 do
  begin
    Open;
    First;
    while not Eof do
    begin
      codice:=FieldByName('CODICE').AsString;
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-21s %s',[codice, FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

procedure TP552FRegoleContoAnnualeMW.getLstTabelleDettaglio(var lstElenco: TList<TItemsValues>);
var SalvaPos:TBookmark;
  var ItemValue: TItemsValues;
begin
  ItemValue.Value:='NC';
  ItemValue.Item:=Format('%-10s',['NC']) + '-' + 'Non conteggiare';
  lstElenco.add(ItemValue);
  with selP552Ricerca do
  begin
    DisableControls;
    SalvaPos:=GetBookmark;
    First;
    while not Eof do
    begin
      ItemValue.Value:=FieldByName('COD_TABELLA').AsString;
      ItemValue.Item:=Format('%-10s',[FieldByName('COD_TABELLA').AsString]) + '-' + FieldByName('DESCRIZIONE').AsString;
      lstElenco.Add(ItemValue);
      Next;
    end;
    GotoBookmark(SalvaPos);
    EnableControls;
  end;
end;

procedure TP552FRegoleContoAnnualeMW.ImpostaAnnoSelP552Ricerca(Anno: Integer);
begin
  selP552Ricerca.Close;
  selP552Ricerca.SetVariable('Anno',Anno);
  selP552Ricerca.Open;
end;

procedure TP552FRegoleContoAnnualeMW.getLstFormato(var lstElenco: TList<TItemsValues>);
var
  ItemValue: TItemsValues;
begin
  lstElenco.Clear;
  ItemValue.Value:='N';
  ItemValue.Item:=Format('%-3s - %s',[ItemValue.Value,'Numerico intero']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='NV2';
  ItemValue.Item:=Format('%-3s - %s',[ItemValue.Value,'Numerico con 2 cifre decimali']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='NV3';
  ItemValue.Item:=Format('%-3s - %s',[ItemValue.Value,'Numerico con 3 cifre decimali']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='X';
  ItemValue.Item:=Format('%-3s - %s',[ItemValue.Value,'Alfanumerico']);
  lstElenco.add(ItemValue);
end;

procedure TP552FRegoleContoAnnualeMW.getLstTipoCampo(TabElab:String; AnnoElab:String;var lstElenco: TList<TItemsValues>);
var
  ItemValue: TItemsValues;
begin
  lstElenco.Clear;
  ItemValue.Value:='ANNO';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Anno di riferimento']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='AZIENDA';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Codice azienda sanitaria']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='FILLER';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Campo Filler']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='FORMULA';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Campo Formula']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='IDCATEG';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Codice identificativo della categoria']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='IDCOMPARTO';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Codice identificativo del comparto di contr.collettiva']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='IDDSM';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Codice identificativo del dipartimento di salute mentale']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='IDFIGURA';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Codice identificativo della figura']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='IDISTITUTO';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Codice identificativo dell''istituto di ricovero']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='REGIONE';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Codice regione']);
  lstElenco.add(ItemValue);
  ItemValue.Value:='TIPOOPERAZ';
  ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,'Indicatore del tipo operazione effettuata']);
  lstElenco.add(ItemValue);

  with selP552Colonne do
  begin
    Close;
    SetVariable('CODTABELLA',TabElab);
    SetVariable('ANNO',AnnoElab);
    Open;
    First;
    while not Eof do
    begin
      ItemValue.Value:='C' + Format('%3.3d',[FieldByName('COLONNA').AsInteger]);
      ItemValue.Item:=Format('%-10s - %s',[ItemValue.Value,FieldByName('DESCRIZIONE').AsString]);
      lstElenco.add(ItemValue);
      Next;
    end;
  end;
end;

procedure TP552FRegoleContoAnnualeMW.getElementiCombo(TipoElab:String; AnnoElab:String; Tabella:String;var lstElenco: TList<TItemsValues>);
var
  ItemValue: TItemsValues;
begin
  lstElenco.Clear;
  with QSQL do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT ' + TipoElab + ',DESCRIZIONE FROM P552_CONTOANNREGOLE');
    SQL.Add(' WHERE COD_TABELLA = ''' + Tabella + '''');
    SQL.Add('   AND ANNO = ' + AnnoElab);
    SQL.Add('   AND ' + TipoElab + ' <> 0');
    Open;
    First;
    while not Eof do
    begin
      ItemValue.Value:=FieldByName(TipoElab).AsString;
      ItemValue.Item:=Format('%-3s',[FieldByName(TipoElab).AsString]) + '-' + FieldByName('DESCRIZIONE').AsString;
      lstElenco.Add(ItemValue);
      Next;
    end;
  end;
end;

procedure TP552FRegoleContoAnnualeMW.selP552RigheColonneBeforePost(Dataset: TDataset;DettaglioRegole: TDettaglioRegole);
begin
  if (DettaglioRegole.TabTredicesimaAC <> '') and (Trim(Copy(DettaglioRegole.TabTredicesimaAC,1,10)) <> 'NC') and
     (Trim(DettaglioRegole.RigheTredicesimaAC) = '') then
    raise exception.Create('Specificare la colonna sostitutiva della Tredicesima AA Corr.!');
  if (Trim(DettaglioRegole.TabTredicesimaAP) <> '') and (Trim(Copy(DettaglioRegole.TabTredicesimaAP,1,10)) <> 'NC') and
     (Trim(DettaglioRegole.RigheTredicesimaAP) = '') then
    raise exception.Create('Specificare la colonna sostitutiva della Tredicesima AA Prec.!');
  if (Trim(DettaglioRegole.TabArretratiAC) <> '') and (Trim(Copy(DettaglioRegole.TabArretratiAC,1,10)) <> 'NC') and
     (Trim(DettaglioRegole.RigheArretratiAC) = '') then
    raise exception.Create('Specificare la colonna sostitutiva degli Arretrati AA Corr.!');
  if (Trim(DettaglioRegole.TabArretratiAP) <> '') and (Trim(Copy(DettaglioRegole.TabArretratiAP,1,10)) <> 'NC') and
     (Trim(DettaglioRegole.RigheArretratiAP) = '') then
    raise exception.Create('Specificare la colonna sostitutiva degli Arretrati AA Prec.!');
  DataSet.FieldByName('COD_TABELLA').AsString:=DettaglioRegole.TabElab;
  DataSet.FieldByName('ANNO').AsInteger:=DettaglioRegole.AnnoElab;
  if DataSet = selP552Righe then
    Dataset.FieldByName('COLONNA').AsInteger:=0
  else if DataSet = selP552Colonne then
    Dataset.FieldByName('RIGA').AsInteger:=0;
  if not DettaglioRegole.bAccorpamento then
    Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString:='';
  DataSet.FieldByName('NUMERO_TREDCORR').AsString:='';
  if DettaglioRegole.bTabSostitutive then
  begin
    if Trim(Copy(DettaglioRegole.TabTredicesimaAC,1,10)) = 'NC' then
      DataSet.FieldByName('NUMERO_TREDCORR').AsString:='NC'
    else if Trim(DettaglioRegole.TabTredicesimaAC) <> '' then
      DataSet.FieldByName('NUMERO_TREDCORR').AsString:=TrimRight(Copy(DettaglioRegole.TabTredicesimaAC,1,10)) + '.' +
                                                       TrimRight(Copy(DettaglioRegole.RigheTredicesimaAC,1,3));
  end;
  DataSet.FieldByName('NUMERO_TREDPREC').AsString:='';
  if DettaglioRegole.bTabSostitutive then
  begin
    if Trim(Copy(DettaglioRegole.TabTredicesimaAP,1,10)) = 'NC' then
      DataSet.FieldByName('NUMERO_TREDPREC').AsString:='NC'
    else if Trim(DettaglioRegole.TabTredicesimaAP) <> '' then
      DataSet.FieldByName('NUMERO_TREDPREC').AsString:=TrimRight(Copy(DettaglioRegole.TabTredicesimaAP,1,10)) + '.' +
                                                       TrimRight(Copy(DettaglioRegole.RigheTredicesimaAP,1,3));
  end;
  DataSet.FieldByName('NUMERO_ARRCORR').AsString:='';
  if DettaglioRegole.bTabSostitutive then
  begin
    if Trim(Copy(DettaglioRegole.TabArretratiAC,1,10)) = 'NC' then
      DataSet.FieldByName('NUMERO_ARRCORR').AsString:='NC'
    else if Trim(DettaglioRegole.TabArretratiAC) <> '' then
      DataSet.FieldByName('NUMERO_ARRCORR').AsString:=TrimRight(Copy(DettaglioRegole.TabArretratiAC,1,10)) + '.' +
                                                      TrimRight(Copy(DettaglioRegole.RigheArretratiAC,1,3));
  end;
  DataSet.FieldByName('NUMERO_ARRPREC').AsString:='';
  if DettaglioRegole.bTabSostitutive then
  begin
    if Trim(Copy(DettaglioRegole.TabArretratiAP,1,10)) = 'NC' then
      DataSet.FieldByName('NUMERO_ARRPREC').AsString:='NC'
    else if Trim(DettaglioRegole.TabArretratiAP) <> '' then
      DataSet.FieldByName('NUMERO_ARRPREC').AsString:=TrimRight(Copy(DettaglioRegole.TabArretratiAP,1,10)) + '.' +
                                                      TrimRight(Copy(DettaglioRegole.RigheArretratiAP,1,3));
  end;
end;

function TP552FRegoleContoAnnualeMW.NextNumCampo(TabElab: String; AnnoElab: String):Integer;
begin
  QSQL.Close;
  QSQL.SQL.Clear;
  QSQL.SQL.Text:='SELECT MAX(NUM_CAMPO) NUM FROM P551_CONTOANNFILE WHERE ANNO = ' + AnnoElab + ' AND COD_TABELLA = ''' + TabElab + '''';
  QSQL.Open;
  Result:=QSQL.FieldByName('NUM').AsInteger + 1;
end;

procedure TP552FRegoleContoAnnualeMW.DeleteP552(TabElab: String; AnnoElab: String);
begin
  delP552.SetVariable('Anno',AnnoElab);
  delP552.SetVariable('Tabella',TabElab);
  delP552.Execute;
  delP551.SetVariable('Anno',AnnoElab);
  delP551.SetVariable('Tabella',TabElab);
  delP551.Execute;
  SessioneOracle.Commit;
  FselP552_Funzioni.Refresh;
end;

function TP552FRegoleContoAnnualeMW.GetMaxAnno:Integer;
begin
  QSQL.Close;
  QSQL.SQL.Clear;
  QSQL.SQL.Add('SELECT MAX(ANNO) ANNO FROM P552_CONTOANNREGOLE');
  QSQL.Open;
  Result:=QSQL.FieldByName('ANNO').AsInteger;
end;

procedure TP552FRegoleContoAnnualeMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selI010);
  inherited;
end;

end.
