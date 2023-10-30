unit P684UDefinizioneFondiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, A000UInterfaccia, OracleData,
  Data.DB, C180FunzioniGenerali, Variants, Oracle, A000UCostanti, A000UMessaggi;

type
  TselP690AAfterOpen = procedure of object;

  TP684FDefinizioneFondiMW = class(TR005FDataModuleMW)
    selP684Dec: TOracleDataSet;
    selP684Ricerca: TOracleDataSet;
    selP684RicercaCOD_FONDO: TStringField;
    selP684RicercaDESCRIZIONE: TStringField;
    selP680: TOracleDataSet;
    dsrP680: TDataSource;
    selP682: TOracleDataSet;
    dsrP682: TDataSource;
    selP686D: TOracleDataSet;
    selP686DCOD_FONDO: TStringField;
    selP686DDECORRENZA_DA: TDateTimeField;
    selP686DCLASS_VOCE: TStringField;
    selP686DCOD_VOCE_GEN: TStringField;
    selP686DDESCRIZIONE: TStringField;
    selP686DTIPO_VOCE: TStringField;
    selP686DORDINE_STAMPA: TFloatField;
    selP686DImporto: TFloatField;
    dsrP686D: TDataSource;
    selP688R: TOracleDataSet;
    selP688RCOD_FONDO: TStringField;
    selP688RDECORRENZA_DA: TDateTimeField;
    selP688RCLASS_VOCE: TStringField;
    selP688RCOD_VOCE_GEN: TStringField;
    selP688RDescVoceGen: TStringField;
    selP688RCOD_VOCE_DET: TStringField;
    selP688RDESCRIZIONE: TStringField;
    selP688RIMPORTO: TFloatField;
    selP688RQUANTITA: TFloatField;
    selP688RDATOBASE: TFloatField;
    selP688RMOLTIPLICATORE: TFloatField;
    selP688RCOD_ARROTONDAMENTO: TStringField;
    selP688RFILTRO_DIPENDENTI: TStringField;
    selP688RDATA_RIFERIMENTO: TDateTimeField;
    selP688RCODICI_ACCORPAMENTOVOCI: TStringField;
    dsrP688R: TDataSource;
    dsrP688D: TDataSource;
    selP688D: TOracleDataSet;
    selP688DCOD_FONDO: TStringField;
    selP688DDECORRENZA_DA: TDateTimeField;
    selP688DCLASS_VOCE: TStringField;
    selP688DCOD_VOCE_GEN: TStringField;
    selP688DDescVoceGen: TStringField;
    selP688DCOD_VOCE_DET: TStringField;
    selP688DDESCRIZIONE: TStringField;
    selP688DDATA_RIFERIMENTO: TDateTimeField;
    selP688DQUANTITA: TFloatField;
    selP688DDATOBASE: TFloatField;
    selP688DMOLTIPLICATORE: TFloatField;
    selP688DIMPORTO: TFloatField;
    selP688DFILTRO_DIPENDENTI: TStringField;
    selP688DCODICI_ACCORPAMENTOVOCI: TStringField;
    selP688DCOD_ARROTONDAMENTO: TStringField;
    selP688Tot: TOracleQuery;
    selP686Tipo: TOracleDataSet;
    dsrP050: TDataSource;
    selP050: TOracleDataSet;
    selP500: TOracleDataSet;
    selP690A: TOracleDataSet;
    dsrP690A: TDataSource;
    selP210: TOracleDataSet;
    selP210COD_CONTRATTO: TStringField;
    selP210DESCRIZIONE: TStringField;
    selP200: TOracleDataSet;
    selP215: TOracleDataSet;
    ScriptSQL: TOracleScript;
    selP684Controllo: TOracleQuery;
    selCheckAnagrafe: TOracleQuery;
    selP686R: TOracleDataSet;
    selP686RCOD_FONDO: TStringField;
    selP686RDECORRENZA_DA: TDateTimeField;
    selP686RCLASS_VOCE: TStringField;
    selP686RCOD_VOCE_GEN: TStringField;
    selP686RDESCRIZIONE: TStringField;
    selP686RTIPO_VOCE: TStringField;
    selP686RORDINE_STAMPA: TFloatField;
    selP686RImporto: TFloatField;
    dsrP686R: TDataSource;
    selP200COD_VOCE_SPECIALE: TStringField;
    selP200DESCRIZIONE: TStringField;
    selP200COD_VOCE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selP684RicercaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selP686RCalcFields(DataSet: TDataSet);
    procedure selP686DCalcFields(DataSet: TDataSet);
    procedure selP686RBeforeEdit(DataSet: TDataSet);
    procedure selP686RBeforeInsert(DataSet: TDataSet);
    procedure selP686RNewRecord(DataSet: TDataSet);
    procedure selP686DBeforeEdit(DataSet: TDataSet);
    procedure selP686DBeforeInsert(DataSet: TDataSet);
    procedure selP686DNewRecord(DataSet: TDataSet);
    procedure selP688DAfterDelete(DataSet: TDataSet);
    procedure selP688DBeforeDelete(DataSet: TDataSet);
    procedure selP688RBeforeEdit(DataSet: TDataSet);
    procedure selP688RBeforeInsert(DataSet: TDataSet);
    procedure selP688RBeforePost(DataSet: TDataSet);
    procedure selP688RNewRecord(DataSet: TDataSet);
    procedure selP688DBeforeEdit(DataSet: TDataSet);
    procedure selP688DBeforeInsert(DataSet: TDataSet);
    procedure selP688DBeforePost(DataSet: TDataSet);
    procedure selP688DNewRecord(DataSet: TDataSet);
    procedure selP690AAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    selP684: TOracleDataSet;
    selP690: TOracleDataSet;
    evtselP690AAfterOpen:TselP690AAfterOpen;
    TipoElabGen,FondoElabGen,FondoElabDettRis,FondoElabDettDes,FondoElabGrigliaDett,CodGenElabGrigliaDett,CodDetElabGrigliaDett:String;
    DataElabGen,DataElabDettRis,DataElabDettDes,DataElabGrigliaDett:TDateTime;
    procedure selP684AfterScroll;
    procedure selP684BeforePost;
    procedure selP688DAfterPost(DataSet: TDataSet);
    procedure selP688RAfterPost(DataSet: TDataSet);
    procedure selP690CalcFields;
    procedure selP690BeforePost;
    procedure selP690NewRecord;
    procedure selP690DataRetribuzioneGetText(Sender: TField; var Text: string);
    procedure selP690DataRetribuzioneSetText(Sender: TField; const Text: string);
    procedure LeggoSelP684Ricerca;
    procedure LeggoSelP686R(CodFondo,Decorrenza:String);
    procedure LeggoSelP686D(CodFondo,Decorrenza:String);
    procedure LeggoSelP688R(CodFondo,Decorrenza:String);
    procedure LeggoSelP688D(CodFondo,Decorrenza:String);
    procedure LeggoSelP690;
    procedure LeggoSelP690A(bDipendente,bMese,bVoce:Boolean);
    function MessaggioCancellazione(CodFondo,Decorrenza:String): String;
    function TrasformaV430(X:String):String;
    function ModifCodiceVoce(selP686:TOracleDataSet; CodFondo,Decorrenza,NewCodiceVoce:String):Boolean;
    procedure RinumOrdineStampa(selP686:TOracleDataSet);
    function AbilitaImportoPrevisto():Boolean;
    procedure ImpostaMoltiplicatore(DatoControllo:Boolean);
    procedure ImpostaImportoPrevisto;
    procedure ArrotImporto(TipoElab:String);
    function LetturaDettaglioImportoSpeso(CodFondo:String; Decorrenza:TDateTime; var ImportoSpeso:Real):Boolean;
    procedure ImpostaImportoSpeso(Importo:Real);
    function ElencoAccorpamenti: TElencoValoriChecklist;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TP684FDefinizioneFondiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selP680.Open;
  selP682.Open;
  ScriptSQL.Session:=SessioneOracle;
end;

procedure TP684FDefinizioneFondiMW.selP684RicercaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=VarToStr(selP684.Lookup('COD_FONDO',selP684Ricerca.FieldByName('COD_FONDO').AsString,'COD_FONDO')) = selP684Ricerca.FieldByName('COD_FONDO').AsString;
end;

procedure TP684FDefinizioneFondiMW.selP686RCalcFields(DataSet: TDataSet);
begin
  inherited;
  selP688Tot.SetVariable('COD',selP686R.FieldByName('COD_FONDO').AsString);
  selP688Tot.SetVariable('DEC',selP686R.FieldByName('DECORRENZA_DA').AsDateTime);
  selP688Tot.SetVariable('FILTRO',' AND CLASS_VOCE =''R'' AND COD_VOCE_GEN = ''' + selP686R.FieldByName('COD_VOCE_GEN').AsString + '''');
  selP688Tot.Execute;
  selP686R.FieldByName('IMPORTO').AsFloat:=StrToFloatDef(VarToStr(selP688Tot.Field(0)),0);
end;

procedure TP684FDefinizioneFondiMW.selP686DCalcFields(DataSet: TDataSet);
begin
  inherited;
  selP688Tot.SetVariable('COD',selP686D.FieldByName('COD_FONDO').AsString);
  selP688Tot.SetVariable('DEC',selP686D.FieldByName('DECORRENZA_DA').AsDateTime);
  selP688Tot.SetVariable('FILTRO',' AND CLASS_VOCE =''D'' AND COD_VOCE_GEN = ''' + selP686D.FieldByName('COD_VOCE_GEN').AsString + '''');
  selP688Tot.Execute;
  selP686D.FieldByName('IMPORTO').AsFloat:=StrToFloatDef(VarToStr(selP688Tot.Field(1)),0);
end;

procedure TP684FDefinizioneFondiMW.selP686RBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  selP686RCOD_VOCE_GEN.ReadOnly:=True;
end;

procedure TP684FDefinizioneFondiMW.selP686RBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  selP686RCOD_VOCE_GEN.ReadOnly:=False;
end;

procedure TP684FDefinizioneFondiMW.selP686RNewRecord(DataSet: TDataSet);
begin
  inherited;
  selP686R.FieldByName('COD_FONDO').AsString:=FondoElabGen;
  selP686R.FieldByName('DECORRENZA_DA').AsDateTime:=DataElabGen;
  selP686R.FieldByName('CLASS_VOCE').AsString:=TipoElabGen;
end;

procedure TP684FDefinizioneFondiMW.selP686DBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  selP686DCOD_VOCE_GEN.ReadOnly:=True;
end;

procedure TP684FDefinizioneFondiMW.selP686DBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  selP686DCOD_VOCE_GEN.ReadOnly:=False;
end;

procedure TP684FDefinizioneFondiMW.selP686DNewRecord(DataSet: TDataSet);
begin
  inherited;
  selP686D.FieldByName('COD_FONDO').AsString:=FondoElabGen;
  selP686D.FieldByName('DECORRENZA_DA').AsDateTime:=DataElabGen;
  selP686D.FieldByName('CLASS_VOCE').AsString:=TipoElabGen;
end;

procedure TP684FDefinizioneFondiMW.selP688DAfterDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP684FDefinizioneFondiMW.selP688DAfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP684FDefinizioneFondiMW.selP688DBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TP684FDefinizioneFondiMW.selP688RBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  selP688RCOD_VOCE_GEN.ReadOnly:=True;
  selP688RCOD_VOCE_DET.ReadOnly:=True;
end;

procedure TP684FDefinizioneFondiMW.selP688RBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  selP688RCOD_VOCE_GEN.ReadOnly:=False;
  selP688RCOD_VOCE_DET.ReadOnly:=False;
end;

procedure TP684FDefinizioneFondiMW.selP688RNewRecord(DataSet: TDataSet);
begin
  inherited;
  selP688R.FieldByName('COD_FONDO').AsString:=FondoElabDettRis;
  selP688R.FieldByName('DECORRENZA_DA').AsDateTime:=DataElabDettRis;
  selP688R.FieldByName('CLASS_VOCE').AsString:='R';
end;

procedure TP684FDefinizioneFondiMW.selP688RAfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP684FDefinizioneFondiMW.selP688DBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  selP688DCOD_VOCE_GEN.ReadOnly:=True;
  selP688DCOD_VOCE_DET.ReadOnly:=True;
end;

procedure TP684FDefinizioneFondiMW.selP688DBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  selP688DCOD_VOCE_GEN.ReadOnly:=False;
  selP688DCOD_VOCE_DET.ReadOnly:=False;
end;

procedure TP684FDefinizioneFondiMW.selP688DNewRecord(DataSet: TDataSet);
begin
  inherited;
  selP688D.FieldByName('COD_FONDO').AsString:=FondoElabDettDes;
  selP688D.FieldByName('DECORRENZA_DA').AsDateTime:=DataElabDettDes;
  selP688D.FieldByName('CLASS_VOCE').AsString:='D';
end;

procedure TP684FDefinizioneFondiMW.selP684AfterScroll;
begin
  selP500.Close;
  selP500.SetVariable('Anno',R180Anno(selP684.FieldByName('DECORRENZA_DA').AsDateTime));
  selP500.Open;
  selP050.Close;
  selP050.SetVariable('CODVALUTA',selP500.FieldByName('COD_VALUTA').AsString);
  selP050.SetVariable('DECORRENZA',selP684.FieldByName('DECORRENZA_DA').AsDateTime);
  selP050.Open;
  selP688Tot.SetVariable('COD',selP684.FieldByName('COD_FONDO').AsString);
  selP688Tot.SetVariable('DEC',selP684.FieldByName('DECORRENZA_DA').AsDateTime);
  selP688Tot.SetVariable('FILTRO',' ');
  selP688Tot.Execute;
end;

procedure TP684FDefinizioneFondiMW.selP684BeforePost;
begin
  if selP684.FieldByName('COD_FONDO').IsNull then
    raise exception.Create(A000MSG_P684_ERR_COD_FONDO);
  if selP684.FieldByName('DECORRENZA_DA').IsNull then
    raise exception.Create(A000MSG_ERR_DATA_DECORRENZA);
  if selP684.FieldByName('DECORRENZA_A').IsNull then
    raise exception.Create(A000MSG_ERR_DATA_SCADENZA);
  if selP684.FieldByName('DECORRENZA_A').AsDateTime < selP684.FieldByName('DECORRENZA_DA').AsDateTime then
    raise exception.Create(A000MSG_ERR_DECORR_NON_SUCC_SCAD);
  if Trim(selP684.FieldByName('FILTRO_DIPENDENTI').AsString) <> '' then
  begin
    selCheckAnagrafe.SetVariable('FILTRO_DIPENDENTI',
      StringReplace(StringReplace(selP684.FieldByName('FILTRO_DIPENDENTI').AsString,'T430.','V430.T430',[rfReplaceAll]),'P430.','V430.P430',[rfReplaceAll]));
    selCheckAnagrafe.Execute;
    if VarToStr(selCheckAnagrafe.Field(0)) = 'E' then
      raise Exception.Create(A000MSG_P000_ERR_FILTRO_DIP); //Filtro dipendenti errato!
  end;
  //Controllo intersezione decorrenze
  selP684Controllo.SetVariable('COD',selP684.FieldByName('COD_FONDO').AsString);
  selP684Controllo.SetVariable('DEC',selP684.FieldByName('DECORRENZA_DA').AsDateTime);
  selP684Controllo.SetVariable('FINE',selP684.FieldByName('DECORRENZA_A').AsDateTime);
  if selP684.State = dsInsert then
    selP684Controllo.SetVariable('RIGA','0')
  else
    selP684Controllo.SetVariable('RIGA',selP684.RowId);
  selP684Controllo.Execute;
  if StrToIntDef(VarToStr(selP684Controllo.Field(0)),0) > 0 then
    raise exception.Create(A000MSG_ERR_PERIODI_INTERSECANTI);
end;

procedure TP684FDefinizioneFondiMW.selP688RBeforePost(DataSet: TDataSet);
begin
  inherited;
  if ((not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('MOLTIPLICATORE').IsNull)) and
      (selP688R.FieldByName('DATOBASE').IsNull) then
    raise exception.Create(A000MSG_P684_ERR_DATO_BASE);
  if ((not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('DATOBASE').IsNull)) and
      (selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
    raise exception.Create(A000MSG_P684_ERR_MOLTIPLICATORE);
  if ((not selP688R.FieldByName('DATOBASE').IsNull) or (not selP688R.FieldByName('MOLTIPLICATORE').IsNull)) and
      (selP688R.FieldByName('QUANTITA').IsNull) then
    raise exception.Create(A000MSG_P684_ERR_QUANTITA);
  if (not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('DATOBASE').IsNull) or
     (not selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
    selP688R.FieldByName('IMPORTO').AsFloat:=selP688R.FieldByName('QUANTITA').AsFloat *
     selP688R.FieldByName('DATOBASE').AsFloat * selP688R.FieldByName('MOLTIPLICATORE').AsFloat;
  if selP688R.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
  begin
    if selP050.SearchRecord('Cod_Arrotondamento',selP688R.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
      (selP688R.FieldByName('IMPORTO').AsFloat <> 0) then
      selP688R.FieldByName('IMPORTO').AsFloat:=
        R180Arrotonda(selP688R.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TP684FDefinizioneFondiMW.selP688DBeforePost(DataSet: TDataSet);
begin
  inherited;
  if selP688D.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
  begin
    if selP050.SearchRecord('Cod_Arrotondamento',selP688D.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
      (selP688D.FieldByName('IMPORTO').AsFloat <> 0) then
      selP688D.FieldByName('IMPORTO').AsFloat:=
        R180Arrotonda(selP688D.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
  end;
  if Trim(selP688D.FieldByName('FILTRO_DIPENDENTI').AsString) <> '' then
  begin
    selCheckAnagrafe.SetVariable('FILTRO_DIPENDENTI',
      StringReplace(StringReplace(selP688D.FieldByName('FILTRO_DIPENDENTI').AsString,'T430.','V430.T430',[rfReplaceAll]),'P430.','V430.P430',[rfReplaceAll]));
    selCheckAnagrafe.Execute;
    if VarToStr(selCheckAnagrafe.Field(0)) = 'E' then
      raise Exception.Create(A000MSG_P000_ERR_FILTRO_DIP); //Filtro dipendenti errato!
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TP684FDefinizioneFondiMW.selP690CalcFields;
begin
  inherited;
  selP200.Close;
  selP200.SetVariable('Cod_Contratto',selP690.FieldByName('COD_CONTRATTO').AsString);
  selP200.SetVariable('Cod_Voce',selP690.FieldByName('COD_VOCE').AsString);
  selP200.SetVariable('Decorrenza',selP690.FieldByName('DECORRENZA_DA').AsDateTime);
  selP200.Open;
  if selP200.RecordCount > 0 then
    selP690.FieldByName('Descrizione').AsString:=selP200.FieldByName('DESCRIZIONE').AsString
  else
    selP690.FieldByName('Descrizione').AsString:='';
end;

procedure TP684FDefinizioneFondiMW.selP690AAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if VarToStr(selP690A.GetVariable('DATI')) = ''' ''' then
    //Si è nella fase di lettura dettaglio importo speso
    exit;
  if Assigned(evtselP690AAfterOpen) then
    evtselP690AAfterOpen();
end;

procedure TP684FDefinizioneFondiMW.selP690BeforePost;
begin
  inherited;
  if selP690.FieldByName('DATA_RETRIBUZIONE').IsNull then
    raise exception.Create(A000MSG_P684_ERR_MESE_RETRIBUZIONE);
  if selP690.FieldByName('COD_CONTRATTO').IsNull then
    raise exception.Create(A000MSG_P684_ERR_COD_CONTRATTO);
  if (selP690.FieldByName('COD_VOCE').IsNull) or (selP690.FieldByName('Descrizione').IsNull) then
    raise exception.Create(A000MSG_P684_ERR_COD_VOCE);
end;

procedure TP684FDefinizioneFondiMW.selP690NewRecord;
begin
  inherited;
  selP690.FieldByName('COD_FONDO').AsString:=selP688D.FieldByName('COD_FONDO').AsString;
  selP690.FieldByName('DECORRENZA_DA').AsDateTime:=selP688D.FieldByName('DECORRENZA_DA').AsDateTime;
  selP690.FieldByName('CLASS_VOCE').AsString:='D';
  selP690.FieldByName('COD_VOCE_GEN').AsString:=selP688D.FieldByName('COD_VOCE_GEN').AsString;
  selP690.FieldByName('COD_VOCE_DET').AsString:=selP688D.FieldByName('COD_VOCE_DET').AsString;
end;

procedure TP684FDefinizioneFondiMW.selP690DataRetribuzioneGetText(Sender: TField; var Text: string);
begin
  inherited;
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('mm/yyyy',Sender.AsDateTime);
end;

procedure TP684FDefinizioneFondiMW.selP690DataRetribuzioneSetText(Sender: TField; const Text: string);
begin
  inherited;
  if Trim(Text) <> '/' then
    Sender.AsString:=FormatDateTime('dd/mm/yyyy',R180FineMese(StrToDate('01/' + Text)))
  else
    Sender.Clear;
end;

procedure TP684FDefinizioneFondiMW.LeggoSelP684Ricerca;
begin
  selP684Ricerca.Close;
  selP684Ricerca.SetVariable('DEC',selP684Dec.FieldByName('DECORRENZA').AsDateTime);
  selP684Ricerca.Open;
end;

procedure TP684FDefinizioneFondiMW.LeggoSelP686R(CodFondo,Decorrenza:String);
begin
  selP686R.Close;
  selP686R.SetVariable('COD',CodFondo);
  selP686R.SetVariable('DEC',StrToDateTimeDef(Decorrenza,StrToDate('30/12/1899')));
  selP686R.Open;
end;

procedure TP684FDefinizioneFondiMW.LeggoSelP686D(CodFondo,Decorrenza:String);
begin
  selP686D.Close;
  selP686D.SetVariable('COD',CodFondo);
  selP686D.SetVariable('DEC',StrToDateTimeDef(Decorrenza,StrToDate('30/12/1899')));
  selP686D.Open;
end;

procedure TP684FDefinizioneFondiMW.LeggoSelP688R(CodFondo,Decorrenza:String);
begin
  selP688R.Close;
  selP688R.SetVariable('COD',CodFondo);
  selP688R.SetVariable('DEC',StrToDateTimeDef(Decorrenza,StrToDate('30/12/1899')));
  selP688R.Open;
end;

procedure TP684FDefinizioneFondiMW.LeggoSelP688D(CodFondo,Decorrenza:String);
begin
  selP688D.Close;
  selP688D.SetVariable('COD',CodFondo);
  selP688D.SetVariable('DEC',StrToDateTimeDef(Decorrenza,StrToDate('30/12/1899')));
  selP688D.Open;
end;

procedure TP684FDefinizioneFondiMW.LeggoSelP690;
begin
  selP690.Close;
  selP690.SetVariable('COD',FondoElabGrigliaDett);
  selP690.SetVariable('DEC',DataElabGrigliaDett);
  if Trim(CodGenElabGrigliaDett) <> '' then
    selP690.SetVariable('CODGEN','and P690.cod_voce_gen = ''' + CodGenElabGrigliaDett + '''')
  else
    selP690.SetVariable('CODGEN','');
  if Trim(CodDetElabGrigliaDett) <> '' then
    selP690.SetVariable('CODDET','and P690.cod_voce_det = ''' + CodDetElabGrigliaDett + '''')
  else
    selP690.SetVariable('CODDET','');
  selP690.Open;
end;

procedure TP684FDefinizioneFondiMW.LeggoSelP690A(bDipendente,bMese,bVoce:Boolean);
var s:String;
begin
  selP690A.Close;
  selP690A.SetVariable('COD',selP690.FieldByName('COD_FONDO').AsString);
  selP690A.SetVariable('DEC',selP690.FieldByName('DECORRENZA_DA').AsDateTime);
  if Trim(CodGenElabGrigliaDett) <> '' then
    selP690A.SetVariable('CODGEN','and P690.cod_voce_gen = ''' + selP690.FieldByName('COD_VOCE_GEN').AsString + '''')
  else
    selP690A.SetVariable('CODGEN','');
  if Trim(CodDetElabGrigliaDett) <> '' then
    selP690A.SetVariable('CODDET','and P690.cod_voce_det = ''' + selP690.FieldByName('COD_VOCE_DET').AsString + '''')
  else
    selP690A.SetVariable('CODDET','');
  s:='';
  if bDipendente then
    s:='T030.COGNOME, T030.NOME, T030.MATRICOLA, P430.COD_POSIZIONE_ECONOMICA';
  if bMese then
  begin
    if s <> '' then
      s:=s + ',';
    s:=s + 'DATA_RETRIBUZIONE';
  end;
  if bVoce then
  begin
    if s <> '' then
      s:=s + ',';
    s:=s + 'P690.COD_CONTRATTO, P690.COD_VOCE, P200.DESCRIZIONE';
  end;
  selP690A.SetVariable('DATI',s);
  selP690A.Open;
end;

function TP684FDefinizioneFondiMW.MessaggioCancellazione(CodFondo,Decorrenza:String): String;
var R,D:Integer;
begin
  LeggoSelP686R(CodFondo,Decorrenza);
  R:=selP686R.RecordCount;
  LeggoSelP686D(CodFondo,Decorrenza);
  D:=selP686D.RecordCount;
  Result:=Format(A000MSG_P664_DLG_FMT_CANCELLA_FONDO,[IntToStr(R),IntToStr(D)]);
end;

function TP684FDefinizioneFondiMW.TrasformaV430(X:String):String;
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

function TP684FDefinizioneFondiMW.ModifCodiceVoce(selP686:TOracleDataSet; CodFondo,Decorrenza,NewCodiceVoce:String):Boolean;
begin
  Result:=False;
  if selP686.SearchRecord('COD_VOCE_GEN',NewCodiceVoce,[srFromBeginning]) then
    raise Exception.Create(A000MSG_P684_ERR_MODIFICA_COD_VOCE);
  ScriptSQL.Lines.Clear;
  ScriptSQL.Output.Clear;
  ScriptSQL.Lines.Add('alter table p688_risdestdet disable constraint P688_FK_P686;');
  ScriptSQL.Lines.Add('alter table p690_fondispeso disable constraint P690_FK_P688;');
  ScriptSQL.Lines.Add('update p686_risdestgen p686 set cod_voce_gen = ''' + NewCodiceVoce + '''');
  ScriptSQL.Lines.Add(' where cod_fondo = ''' + CodFondo + '''');
  ScriptSQL.Lines.Add('   and decorrenza_da = to_date(''' + Decorrenza + ''',''dd/mm/yyyy'')');
  ScriptSQL.Lines.Add('   and class_voce = ''' + selP686.FieldByName('CLASS_VOCE').AsString + '''');
  ScriptSQL.Lines.Add('   and cod_voce_gen = ''' + selP686.FieldByName('COD_VOCE_GEN').AsString + ''';');
  ScriptSQL.Lines.Add('update p688_risdestdet p688 set cod_voce_gen = ''' + NewCodiceVoce + '''');
  ScriptSQL.Lines.Add(' where cod_fondo = ''' + CodFondo + '''');
  ScriptSQL.Lines.Add('   and decorrenza_da = to_date(''' + Decorrenza + ''',''dd/mm/yyyy'')');
  ScriptSQL.Lines.Add('   and class_voce = ''' + selP686.FieldByName('CLASS_VOCE').AsString + '''');
  ScriptSQL.Lines.Add('   and cod_voce_gen = ''' + selP686.FieldByName('COD_VOCE_GEN').AsString + ''';');
  ScriptSQL.Lines.Add('update p690_fondispeso p690 set cod_voce_gen = ''' + NewCodiceVoce + '''');
  ScriptSQL.Lines.Add(' where cod_fondo = ''' + CodFondo + '''');
  ScriptSQL.Lines.Add('   and decorrenza_da = to_date(''' + Decorrenza + ''',''dd/mm/yyyy'')');
  ScriptSQL.Lines.Add('   and class_voce = ''' + selP686.FieldByName('CLASS_VOCE').AsString + '''');
  ScriptSQL.Lines.Add('   and cod_voce_gen = ''' + selP686.FieldByName('COD_VOCE_GEN').AsString + ''';');
  ScriptSQL.Lines.Add('alter table p688_risdestdet enable constraint P688_FK_P686;');
  ScriptSQL.Lines.Add('alter table p690_fondispeso enable constraint P690_FK_P688;');
  ScriptSQL.Execute;
  if (Pos('ERR',ScriptSQL.Output.Text) <= 0) and (Pos('ORA-',ScriptSQL.Output.Text) <= 0) then
  begin
    SessioneOracle.Commit;
    selP686.Refresh;
    Result:=True;
  end
  else
  begin
    SessioneOracle.Rollback;
    Result:=False;
  end;
end;

procedure TP684FDefinizioneFondiMW.RinumOrdineStampa(selP686:TOracleDataSet);
var i:Integer;
begin
  //Rinumerazione ORDINE_STAMPA partendo da 10 con incremento di 5
  selP686.DisableControls;
  selP686.First;
  i:=0;
  while not selP686.Eof do
  begin
    selP686.Edit;
    selP686.FieldByName('ORDINE_STAMPA').AsInteger:=10 + i;
    selP686.Post;
    i:=i + 5;
    selP686.Next;
  end;
  SessioneOracle.Commit;
  selP686.Refresh;
  selP686.First;
  selP686.EnableControls;
end;

function TP684FDefinizioneFondiMW.AbilitaImportoPrevisto():Boolean;
begin
  Result:=False;
  if (not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('DATOBASE').IsNull) or
     (not selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
    Result:=True;
end;

procedure TP684FDefinizioneFondiMW.ImpostaMoltiplicatore(DatoControllo:Boolean);
begin
  if (not DatoControllo) and (selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
    selP688R.FieldByName('MOLTIPLICATORE').AsFloat:=1;
end;

procedure TP684FDefinizioneFondiMW.ImpostaImportoPrevisto;
begin
  selP688R.FieldByName('IMPORTO').AsFloat:=selP688R.FieldByName('QUANTITA').AsFloat *
    selP688R.FieldByName('DATOBASE').AsFloat * selP688R.FieldByName('MOLTIPLICATORE').AsFloat;
end;

procedure TP684FDefinizioneFondiMW.ArrotImporto(TipoElab:String);
var selP688:TOracleDataSet;
begin
  if TipoElab = 'R' then
    selP688:=selP688R
  else
    selP688:=selP688D;
  if selP688.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
  begin
    if selP050.SearchRecord('Cod_Arrotondamento',selP688.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
      (selP688.FieldByName('IMPORTO').AsFloat <> 0) then
      selP688.FieldByName('IMPORTO').AsFloat:=
        R180Arrotonda(selP688.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
  end;
end;

function TP684FDefinizioneFondiMW.LetturaDettaglioImportoSpeso(CodFondo:String; Decorrenza:TDateTime; var ImportoSpeso:Real):Boolean;
begin
  Result:=True;
  selP690A.Close;
  selP690A.SetVariable('COD',CodFondo);
  selP690A.SetVariable('DEC',Decorrenza);
  selP690A.SetVariable('CODGEN','and P690.cod_voce_gen = ''' + selP688D.FieldByName('COD_VOCE_GEN').AsString + '''');
  selP690A.SetVariable('CODDET','and P690.cod_voce_det = ''' + selP688D.FieldByName('COD_VOCE_DET').AsString + '''');
  selP690A.SetVariable('DATI',''' ''');
  selP690A.Open;
  ImportoSpeso:=0;
  if selP690A.RecordCount > 0 then  //Arrotondo la somma
  begin
    ImportoSpeso:=selP690A.FieldByName('Importo').AsFloat;
    if selP688D.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
    begin
      if selP050.SearchRecord('Cod_Arrotondamento',selP688D.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
        (ImportoSpeso <> 0) then
        ImportoSpeso:=R180Arrotonda(ImportoSpeso,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
    end;
  end;
  Result:=R180AzzeraPrecisione(ImportoSpeso - selP688D.FieldByName('IMPORTO').AsFloat,2) <> 0;
end;

procedure TP684FDefinizioneFondiMW.ImpostaImportoSpeso(Importo:Real);
begin
  selP688D.Edit;
  selP688D.FieldByName('IMPORTO').AsFloat:=Importo;
  selP688D.Post;
  SessioneOracle.Commit;
end;

function TP684FDefinizioneFondiMW.ElencoAccorpamenti: TElencoValoriChecklist;
var Codice: String;
begin
  Result:=TElencoValoriChecklist.Create;
  with selP215 do
  begin
    Open;
    First;
    while not Eof do
    begin
      Codice:=FieldByName('CODICE').AsString;
      Result.lstCodice.Add(Codice);
      Result.lstDescrizione.Add(Format('%-21s %s',[Codice, FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

end.
