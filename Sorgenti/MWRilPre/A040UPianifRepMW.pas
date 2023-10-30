unit A040UPianifRepMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, checklst,
  Dialogs, OracleData, DB, DBClient, Oracle, StrUtils, R005UDataModuleMW, USelI010,
  A000UMessaggi, A000USessione, A000UInterfaccia, C180FunzioniGenerali, A000UCostanti, DatiBloccati,
  QRPrntr, Generics.Collections;

type
  T040Msg = procedure(msg:String) of object;
  T040Dlg = procedure(msg,Chiave:String) of object;
  T040DlgFunc = function(msg:String):Boolean of object;
  T040KeyCtrl = function(Chiave:String):Boolean of object;
  T040Merge = procedure(ODS:TOracleDataSet) of object;
  T380Merge = procedure(ODS:TOracleDataSet) of object;
  T040ClearKeys = procedure of object;
  T040FineElaborazioneMensile = procedure(VisualizzaMsg:Boolean = True) of object;

  TElencoDate = record
    Data:TDateTime;
    Colorata:Boolean;
  end;

TA040FPianifRepMW = class(TR005FDataModuleMW)
    D350: TDataSource;
    Q350: TOracleDataSet;
    Q350CODICE: TStringField;
    Q350DESCRIZIONE: TStringField;
    Q350ORAINIZIO: TDateTimeField;
    Q350ORAFINE: TDateTimeField;
    Q350TIPOORE: TStringField;
    Q350ORENORMALI: TDateTimeField;
    Q350ORECOMPRESENZA: TDateTimeField;
    Q350TIPOTURNO: TStringField;
    Q350RAGGRUPPAMENTO: TStringField;
    Q350PIANIF_MAX_MESE: TIntegerField;
    Q350PIANIF_MAX_MESE_TURNI_INTERI: TStringField;
    Q350ORE_MIN_INDENNITA: TStringField;
    Q350TURNO_INTERO: TStringField;
    Q350BLOCCA_MAX_MESE: TStringField;
    Q350Opposto: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField3: TStringField;
    DateTimeField3: TDateTimeField;
    DateTimeField4: TDateTimeField;
    StringField4: TStringField;
    StringField5: TStringField;
    Q270: TOracleDataSet;
    QControllo: TOracleDataSet;
    Q040: TOracleDataSet;
    Q430Contratto: TOracleDataSet;
    selT380a: TOracleDataSet;
    dsrDatoLibero: TDataSource;
    selDatoLibero: TOracleDataSet;
    cdsParametri: TClientDataSet;
    cdsParametriTurno1: TStringField;
    cdsParametriTurno2: TStringField;
    cdsParametriTurno3: TStringField;
    dsrParametri: TDataSource;
    insT380: TOracleQuery;
    delT380: TOracleQuery;
    selT385: TOracleDataSet;
    selSumTurniAtt: TOracleQuery;
    selT380SumTurniMese: TOracleQuery;
    cdsParametriDatoLibero: TStringField;
    selTurni: TOracleDataSet;
    selT350Cod: TOracleDataSet;
    D010: TDataSource;
    D010B: TDataSource;
    D010C: TDataSource;
    selT355: TOracleDataSet;
    drsT355: TDataSource;
    selNumMaxTurni: TOracleDataSet;
    selPermutazioniDatiAgg: TOracleDataSet;
    SelAnagrafeLookUp: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FiltroDizionario(DataSet:TDataSet;var Accept:Boolean);
  private
    pT380FiltraSelAnagrafe:Boolean;
    procedure SetT380FiltraSelAnagrafe(Value:Boolean);
  public
    StampaTurniOttimizzata:Boolean; //Ottimizza le colonne stampate per Prospetto Dipendente
    LstTurniEsclusi:String; //Lista dei turni esclusi dalla stampa (per Prospetto Dipendente, perchè superato MAX_CODICI)
    selT380:TOracleDataSet;
    RecordT380Cancellati:Boolean;
    RecapitoAlternativo: Boolean; //Usa il recapito alternativo nel dettaglio COMO_ASL Commessa: 2021/084 SVILUPPO#1
    CodTipologia,sTipo,Filtro,Dipendente:String;
    sGiornataAssenza,sTurnoNonInserito:String;
    ProceduraChiamante,IMax,ProgGM:Integer;
    Turno1Value,Turno2Value,Turno3Value,DatoLiberoValue,Priorita1Value,Priorita2Value,Priorita3Value:Variant;
    Recapito1Value, Recapito2Value, Recapito3Value: Variant;
    DatoAgg1T1Value,DatoAgg1T2Value,DatoAgg1T3Value,DatoAgg2T1Value,DatoAgg2T2Value,DatoAgg2T3Value:Variant;
    DatoAreaSquadraT1Value,DatoAreaSquadraT2Value,DatoAreaSquadraT3Value:Variant;
    DataInizio,DataFine,DataControllo,DataSt:TDateTime;
    NonContDipPian:Boolean;
    ListaGiorniSel:TStringList;
    selI010,selI010B,selI010C: TselI010;
    selDatiBloccati:TDatiBloccati;
    ElencoDate:array [1..31] of TElencoDate;
    evtMessaggio:T040Msg;
    evtRichiesta:T040Dlg;
    evtRichiestaRefresh:T040Dlg;
    evtGiornataAssenza:T040DlgFunc;
    evtTurnoNonInserito:T040DlgFunc;
    evtRaggrAbilitati:T040Dlg;
    evtKeyCtrl:T040KeyCtrl;
    evtClearKeys:T040ClearKeys;
    evtFineElaborazioneMensile:T040FineElaborazioneMensile;
    evtMergeSelAnagrafe:T040Merge;
    evtT380MergeSelAnagrafe:T380Merge;
    lstSystemFonts: TList<String>;
    PaperSizeStampa,PaperSizeStampa2:TQRPaperSize;
    const MAX_CODICI = 4;
      NONIMPOSTATO='(non impostato)';
      VERTICALE='Verticale';
      ORIZZONTALE='Orizzontale';
      RECAPITO='RECAPITO';
      DATIAGG='#DATIAGG';
    procedure ImpostaTipologiaDataSet;
    procedure VisualizzaCampi;
    procedure AfterPost;
    procedure BeforeDelete;
    procedure BeforeInsert;
    procedure BeforePost;
    procedure NewRecord(Data:TDateTime);
    procedure selT380ValidaData;
    procedure selT380ValidaTurno(Sender:TField);
    procedure selT380ValidaDatoLibero;
    procedure selT380ImpostaTesto(Sender:TField;const Text:String;Lung:Integer);
    function RaggruppamentiAbilitati(Prog:Integer;DataRif:TDateTime):Boolean;
    procedure CercaContratto(Prog:Integer;DataRif:TDateTime);
    function GiornataAssenza(Data:TDateTime;Progressivo:LongInt):Boolean;
    function TurnoNonInserito(C1,C2,C3:String;Data:TDateTime;Prog:Integer):Boolean; overload;
    function TurnoNonInserito(C1,C2,C3:String;Data:TDateTime;Prog:Integer; var ErrMsg:String):Boolean; overload;
    procedure ControlloVincoliIndividuali(Turno:String);
    procedure TurniIntersecati(T1,T2:String);
    procedure RefreshT380;
    procedure CaricaElencoDate;
    procedure TurniIntersecatiTipologieDiverse(T1,T2:String;DataRif:TDateTime);
    procedure VerificaLimiteMese(const Turni:array of String;DataAttuale:TDateTime;Stato:TDataSetState;RigaID:String;Prog:Integer);
    procedure ImpostaFiltro(Testo:String);
    procedure ImpostaCampiLookup;
    function GetHint(ConsideraDatoLibero:Boolean):String;
    procedure InserisciGestioneMensile;
    procedure CancellaGestioneMensile;
    procedure CancellaTurniEsistenti;
    procedure Controlli(Modo: String);
    procedure PulisciVariabili(VisualizzaMessaggioFineElaborazione:Boolean = False);
    function GetCodiciTurnoUtilizzati(pTurni,pDataDa,pDataA:String;pTipoStampa,pSelTurni:Integer): String;
    function GetCodiciTurnoUtilizzatiRaggruppamento(pTabellaCampoRaggr1, pNomeCampoRaggr1, pGruppo, pTurni: String): String;
    function GetNumMaxTurniUtilizzati(pRaggruppamento: string; pDataDa,pDataA: TDateTime):Integer;
    procedure RecuperaTurni(pSelTurni:Integer);
    function RefreshSelDatoLibero(Data:TDateTime):Boolean;
    procedure ControlliStampa(pDataDa,pDataA,pTurni,pValCampo:String;pTipoStampa,pDatiAssenza:Integer;pDettCodice,pDettOrario,pDettDatoLibero,pDettDatiAggiuntivi:Boolean);
    property T380FiltraSelAnagrafe:Boolean read pT380FiltraSelAnagrafe write SetT380FiltraSelAnagrafe;
    const
      Orientamento:array[0..2] of TItemsValues = ((Item:'(non impostato)'; Value:'A'),
                                                  (Item:'Orizzontale';   Value:'O'),
                                                  (Item:'Verticale';     Value:'V'));
  end;

implementation

{$R *.dfm}

procedure TA040FPianifRepMW.DataModuleCreate(Sender: TObject);
var LstDatiVis: TStringList;
    i:Integer;
    DatiVis:String;
begin
  inherited;
  lstSystemFonts:=TList<String>.Create;
  selT350Cod.OnFilterRecord:=FiltroDizionario;
  CodTipologia:='R';
  ImpostaTipologiaDataSet;
  if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,selDatoLibero) then
  begin
    if selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
      selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
    selDatoLibero.Open;
  end;
  cdsParametri.CreateDataSet;
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='M';
  ListaGiorniSel:=TStringList.Create;
  PulisciVariabili;
  //campo raggruppamento
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '' then
  begin
    selI010.Close;
    selI010.SQL.Text:='SELECT ''#DATIAGG'' NOME_CAMPO, ''_Dati aggiuntivi pianificati'' NOME_LOGICO, NULL POSIZIONE FROM DUAL UNION ' + selI010.SQL.Text;
    selI010.Open;
  end;
  D010.DataSet:=selI010;
  //campo dettaglio
  selI010B:=TselI010.Create(Self);
  selI010B.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  D010B.DataSet:=selI010B;
  //campo con nominativo
  selI010C:=TselI010.Create(Self);
  LstDatiVis:=TStringList.Create;
  LstDatiVis.CommaText:=Parametri.CampiRiferimento.C29_ChiamateRepDatiVis;
  DatiVis:='''MATRICOLA''';
  for i:=0 to LstDatiVis.Count - 1 do
    DatiVis:=DatiVis + Format(',''T430%s''',[LstDatiVis[i]]);
  FreeAndNil(LstDatiVis);
  selI010C.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','NOME_CAMPO IN (' + DatiVis + ')' ,'NOME_LOGICO');
  D010C.DataSet:=selI010C;
  //Inizializzazione a False - controllo su tutti i dipendenti se turno è già pianificato
  T380FiltraSelAnagrafe:=False;
  selT355.Open;
  LstTurniEsclusi:='';
end;

procedure TA040FPianifRepMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstSystemFonts);
  FreeAndNil(selI010);
  FreeAndNil(selI010B);
  FreeAndNil(ListaGiorniSel);//.Free;
  FreeAndNil(selDatiBloccati);//.Free;
end;

procedure TA040FPianifRepMW.SetT380FiltraSelAnagrafe(Value:Boolean);
begin
  pT380FiltraSelAnagrafe:=Value;
  if Assigned(evtT380MergeSelAnagrafe) and Value then
  begin
    evtT380MergeSelAnagrafe(QControllo);
  end
  else
  begin
    if QControllo.VariableIndex('DataLavoro') >= 0 then
      QControllo.DeleteVariable('DataLavoro');
    QControllo.SetVariable('C700SelAnagrafe','dual where 1 = 1');
  end;
end;

procedure TA040FPianifRepMW.ImpostaTipologiaDataSet;
begin
  R180SetVariable(Q270,'CODINTERNO',IfThen(CodTipologia = 'R','C','D'));
  Q270.Open;
  R180SetVariable(Q350,'TIPOLOGIA',CodTipologia);
  Q350.Open;
  R180SetVariable(Q350Opposto,'TIPOLOGIA',CodTipologia);
  Q350Opposto.Open;
  sTipo:=IfThen(CodTipologia = 'R','reperibilità','guardia');
end;

procedure TA040FPianifRepMW.VisualizzaCampi;
begin
  selT380.FieldByName('PRIORITA1').Visible:=CodTipologia = 'R';
  selT380.FieldByName('PRIORITA2').Visible:=CodTipologia = 'R';
  selT380.FieldByName('PRIORITA3').Visible:=CodTipologia = 'R';
  selT380.FieldByName('RECAPITO1').Visible:=CodTipologia = 'R';
  selT380.FieldByName('RECAPITO2').Visible:=CodTipologia = 'R';
  selT380.FieldByName('RECAPITO3').Visible:=CodTipologia = 'R';
  selT380.FieldByName('DATOLIBERO').Visible:=A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,selDatoLibero);
end;

procedure TA040FPianifRepMW.AfterPost;
var RowID:String;
begin
  RowID:=selT380.RowID;
  selT380.Refresh;
  selT380.SearchRecord('ROWID',RowID,[srFromBeginning]);
  CaricaElencoDate;
end;

procedure TA040FPianifRepMW.BeforeDelete;
begin
  if selDatiBloccati.DatoBloccato(selT380.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(selT380.FieldByName('DATA').AsDateTime),'T380') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA040FPianifRepMW.BeforeInsert;
begin
  if SelAnagrafe.RecordCount = 0 then Abort;
end;

procedure TA040FPianifRepMW.BeforePost;
begin
  ProceduraChiamante:=0;//BeforePost
  if not RaggruppamentiAbilitati(selT380.FieldByName('PROGRESSIVO').AsInteger,selT380.FieldByName('DATA').AsDateTime) then
    raise Exception.Create(Format(A000MSG_A040_ERR_DLG_FMT_NO_RAGGR,[sTipo,FormatDateTime('DD/MM/YYYY',selT380.FieldByName('DATA').AsDateTime),'']));
  if selDatiBloccati.DatoBloccato(selT380.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(selT380.FieldByName('DATA').AsDateTime),'T380') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if selT380.FieldByName('TURNO1').AsString = '' then
    raise ExceptionNoLog.Create(A000MSG_A040_ERR_NO_TURNO_1);
  if (selT380.FieldByName('TURNO1').AsString = selT380.FieldByName('TURNO2').AsString) or
     ((selT380.FieldByName('TURNO1').AsString <> '') and
     (selT380.FieldByName('TURNO1').AsString = selT380.FieldByName('TURNO3').AsString)) or
     ((selT380.FieldByName('TURNO2').AsString <> '') and
     (selT380.FieldByName('TURNO2').AsString = selT380.FieldByName('TURNO3').AsString)) then
    raise ExceptionNoLog.Create(A000MSG_A040_ERR_TURNO_RIPETUTO);
  if (selT380.FieldByName('TURNO2').AsString = '') and (selT380.FieldByName('TURNO3').AsString <> '') then
    raise ExceptionNoLog.Create(A000MSG_A040_ERR_NO_TURNO_2);
  if QueryPK1.EsisteChiave('T380_PIANIFREPERIB',selT380.RowId,selT380.State,['PROGRESSIVO','DATA','TIPOLOGIA'],[selT380.FieldByName('PROGRESSIVO').AsString,selT380.FieldByName('DATA').AsString,CodTipologia]) then
    raise ExceptionNoLog.Create(A000MSG_A040_ERR_ESISTE_PIANIFICAZIONE);
  if (not GiornataAssenza(selT380.FieldByName('DATA').AsDateTime,selT380.FieldByName('PROGRESSIVO').AsInteger)) or
    ((not NonContDipPian) and (not TurnoNonInserito(selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO3').AsString,selT380.FieldByName('DATA').AsDateTime,selT380.FieldByName('PROGRESSIVO').AsInteger))) then
  begin
    PulisciVariabili;
    Abort;
  end;
  if (selT380.State = dsInsert) or
     (selT380.FieldByName('TURNO1').medpOldValue <> selT380.FieldByName('TURNO1').Value) or
     (selT380.FieldByName('TURNO2').medpOldValue <> selT380.FieldByName('TURNO2').Value) or
     (selT380.FieldByName('TURNO3').medpOldValue <> selT380.FieldByName('TURNO3').Value) then
  begin
    // controllo vincoli individuali
    R180SetVariable(selT385,'PROGRESSIVO',selT380.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT385,'TIPO',CodTipologia);
    R180SetVariable(selT385,'DATA',selT380.FieldByName('DATA').AsDateTime);
    selT385.Open;
    if (selT380.State = dsInsert) or (selT380.FieldByName('TURNO1').medpOldValue <> selT380.FieldByName('TURNO1').Value) then
      ControlloVincoliIndividuali(selT380.FieldByName('TURNO1').AsString);
    if (selT380.State = dsInsert) or (selT380.FieldByName('TURNO2').medpOldValue <> selT380.FieldByName('TURNO2').Value) then
      ControlloVincoliIndividuali(selT380.FieldByName('TURNO2').AsString);
    if (selT380.State = dsInsert) or (selT380.FieldByName('TURNO3').medpOldValue <> selT380.FieldByName('TURNO3').Value) then
      ControlloVincoliIndividuali(selT380.FieldByName('TURNO3').AsString);
    // intersezione turni
    if (selT380.State = dsInsert) or
       (selT380.FieldByName('TURNO1').medpOldValue <> selT380.FieldByName('TURNO1').Value) or
       (selT380.FieldByName('TURNO2').medpOldValue <> selT380.FieldByName('TURNO2').Value) then
      TurniIntersecati(selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO2').AsString);
    if (selT380.State = dsInsert) or
       (selT380.FieldByName('TURNO1').medpOldValue <> selT380.FieldByName('TURNO1').Value) or
       (selT380.FieldByName('TURNO3').medpOldValue <> selT380.FieldByName('TURNO3').Value) then
      TurniIntersecati(selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO3').AsString);
    if (selT380.State = dsInsert) or
       (selT380.FieldByName('TURNO2').medpOldValue <> selT380.FieldByName('TURNO2').Value) or
       (selT380.FieldByName('TURNO3').medpOldValue <> selT380.FieldByName('TURNO3').Value) then
      TurniIntersecati(selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO3').AsString);
    with selT380a do
    begin
      Close;
      SetVariable('PROGRESSIVO',selT380.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',selT380.FieldByName('DATA').AsDateTime);
      SetVariable('TIPOLOGIA',CodTipologia);
      Open;
      if RecordCount > 0 then
      begin
        if (selT380.FieldByName('TURNO1').OldValue <> selT380.FieldByName('TURNO1').Value) then
        begin
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('DATA').AsDateTime);
        end;
        if (selT380.FieldByName('TURNO2').OldValue <> selT380.FieldByName('TURNO2').Value) then
        begin
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('DATA').AsDateTime);
        end;
        if (selT380.FieldByName('TURNO3').OldValue <> selT380.FieldByName('TURNO3').Value) then
        begin
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO3').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO3').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,selT380.FieldByName('TURNO3').AsString,selT380.FieldByName('DATA').AsDateTime);
        end;
      end;
    end;
    VerificaLimiteMese([selT380.FieldByName('TURNO1').AsString,
                        selT380.FieldByName('TURNO2').AsString,
                        selT380.FieldByName('TURNO3').AsString],
                        selT380.FieldByName('DATA').AsDateTime,
                        selT380.State,selT380.Rowid,
                        selT380.FieldByName('PROGRESSIVO').AsInteger);
  end;
  selT380ValidaDatoLibero;
  if selT380.FieldByName('TURNO2').IsNull then
    selT380.FieldByName('PRIORITA2').Clear;
  if selT380.FieldByName('TURNO3').IsNull then
    selT380.FieldByName('PRIORITA3').Clear;
  if selT380.FieldByName('TURNO1').IsNull then
    selT380.FieldByName('RECAPITO1').Clear;
  if selT380.FieldByName('TURNO2').IsNull then
    selT380.FieldByName('RECAPITO2').Clear;
  if selT380.FieldByName('TURNO3').IsNull then
    selT380.FieldByName('RECAPITO3').Clear;
end;

procedure TA040FPianifRepMW.NewRecord(Data:TDateTime);
begin
  selT380.FieldByName('DATA').AsDateTime:=Data;
  selT380.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  selT380.FieldByName('TIPOLOGIA').AsString:=CodTipologia;
end;

procedure TA040FPianifRepMW.selT380ValidaData;
begin
  if (selT380.FieldByName('DATA').AsDateTime < DataInizio) or
     (selT380.FieldByName('DATA').AsDateTime > DataFine) then
    raise Exception.Create(A000MSG_A040_ERR_DATA_ESTERNA_MESE);
end;

procedure TA040FPianifRepMW.selT380ValidaTurno(Sender:TField);
begin
  if selT380.FieldByName((Sender as TField).FieldName).AsString <> '' then
    if VarToStr(Q350.Lookup('CODICE',selT380.FieldByName((Sender as TField).FieldName).AsString,'CODICE')) = '' then
      raise Exception.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[(Sender as TField).DisplayLabel]));
end;

procedure TA040FPianifRepMW.selT380ValidaDatoLibero;
begin
  if selT380.FieldByName('DATOLIBERO').AsString <> '' then
  begin
    RefreshSelDatoLibero(selT380.FieldByName('DATA').AsDateTime);
    if VarToStr(selDatoLibero.Lookup('CODICE',selT380.FieldByName('DATOLIBERO').AsString,'CODICE')) = '' then
      raise Exception.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('DATOLIBERO').DisplayLabel]));
  end;
end;

procedure TA040FPianifRepMW.selT380ImpostaTesto(Sender:TField;const Text:String;Lung:Integer);
begin
  Sender.AsString:=Trim(Copy(Text,1,Lung));
end;

procedure TA040FPianifRepMW.FiltroDizionario(DataSet:TDataSet;var Accept:Boolean);
begin
  Accept:=A000FiltroDizionario('TURNI REPERIBILITA',DataSet.FieldByName('CODICE').AsString)
end;

function TA040FPianifRepMW.RaggruppamentiAbilitati(Prog:Integer;DataRif:TDateTime):Boolean;
var i:Integer;
begin
  //Controllo se il dipendente ha delle causali di presenza adeguate abilitate in data
  Result:=False;
  CercaContratto(Prog,DataRif);
  with TStringList.Create do
  begin
    CommaText:=Q430Contratto.FieldByName('AbPresenza1').AsString;
    for i:=0 to Count - 1 do
      if Q270.Locate('Codice',Strings[i],[]) then
      begin
        Result:=True;
        Break;
      end;
    Free;
  end;
end;

procedure TA040FPianifRepMW.CercaContratto(Prog:Integer;DataRif:TDateTime);
begin
  with Q430Contratto do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',DataRif);
    Open;
  end;
end;

function TA040FPianifRepMW.GiornataAssenza(Data:TDateTime;Progressivo:LongInt):Boolean;
{Controllo se nel giorno corrente e' presente una giornata di assenza}
begin
  Result:=True;
  if sGiornataAssenza = '' then
  begin
    with Q040 do
    begin
      Close;
      SetVariable('Progressivo',Progressivo);
      SetVariable('Data',Data);
      Open;
      if RecordCount > 0 then
        if Assigned(evtGiornataAssenza) then
          Result:=evtGiornataAssenza(Format(A000MSG_A040_DLG_FMT_ESISTE_ASSENZA,[DateToStr(Data),FieldByName('Causale').AsString]));
    end;
  end
  else
    Result:=sGiornataAssenza = 'S';
end;

function TA040FPianifRepMW.TurnoNonInserito(C1,C2,C3:String;Data:TDateTime;Prog:Integer):Boolean;
begin
  Result:=True;
  if sTurnoNonInserito = '' then
  begin
    QControllo.Close;
    QControllo.SetVariable('DATA',Data);
    QControllo.SetVariable('T1',C1);
    QControllo.SetVariable('T2',C2);
    QControllo.SetVariable('T3',C3);
    QControllo.SetVariable('PROGRESSIVO',Prog);
    QControllo.SetVariable('TIPOLOGIA',CodTipologia);
    QControllo.Open;
    Result:=(QControllo.Fields[0].Value = 0);  //Esiste un turno pianificato
    if not Result then
    begin
      if (Trim(C1) <> '') and (Trim(C2) <> '') then
        C1:=C1 + ' o ';
      C1:=C1 + C2;
      if (Trim(C1) <> '') and (Trim(C3) <> '') then
        C1:=C1 + ' o ';
      C1:=C1 + C3;
      if Assigned(evtTurnoNonInserito) then
        Result:=evtTurnoNonInserito(Format(A000MSG_A040_DLG_FMT_TURNO_PIANIFICATO,[C1,DateToStr(Data)]));
    end;
  end
  else
    Result:=sTurnoNonInserito = 'S';
end;

function TA040FPianifRepMW.TurnoNonInserito(C1,C2,C3:String;Data:TDateTime;Prog:Integer; var ErrMsg:String):Boolean;
//Valorizza ErrMsg per utilizzo successivo
begin
  ErrMsg:='';
  Result:=TurnoNonInserito(C1,C2,C3,Data,Prog);
  if not Result then
  begin
    if (Trim(C1) <> '') and (Trim(C2) <> '') then
      C1:=C1 + ' o ';
    C1:=C1 + C2;
    if (Trim(C1) <> '') and (Trim(C3) <> '') then
      C1:=C1 + ' o ';
    C1:=C1 + C3;
    ErrMsg:=Format(A000MSG_A040_DLG_FMT_TURNO_PIANIFICATO,[C1,DateToStr(Data)]);
  end;
end;

procedure TA040FPianifRepMW.ControlloVincoliIndividuali(Turno:String);
var Messaggio:String;
begin
  if Trim(Turno) = '' then
    Exit;
  //Priorità: FS/PF - (1..7) - *
  //se il giorno del vincolo è FS e la data pianif. è un festivo
  if (selT385.SearchRecord('GIORNO','FS',[srFromBeginning]) and
     (selT385.FieldByName('DTFESTIVO').AsString = 'S'))
  //se il giorno del vincolo è PF e la data pianif. è un prefestivo
  or (selT385.SearchRecord('GIORNO','PF',[srFromBeginning]) and
     (selT385.FieldByName('DTPREFESTIVO').AsString = 'S'))
  //se il giorno del vincolo è uguale al giorno della data pianif.
  or selT385.SearchRecord('GIORNO',DayOfWeek(selT385.GetVariable('DATA') - 1),[srFromBeginning])
  //se il giorno del vincolo è Tutti
  or selT385.SearchRecord('GIORNO','*',[srFromBeginning]) then
  begin
    if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and
       (Pos(',' + Turno + ',', ',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or
       ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and
       (Pos(',' + Turno + ',', ',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
    begin
      Messaggio:=Format(A000MSG_A040_DLG_FMT_TURNO_NON_DISP,[VarToStr(selT385.GetVariable('DATA')),Turno,IfThen(selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S','','Vuoi continuare?')]);
      if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
      begin
        PulisciVariabili;
        raise exception.Create(Messaggio);
      end
      else
        if Assigned(evtRichiesta) then
          evtRichiesta(Messaggio,IntToStr(IMax) + 'ControlloVincoli ' + Turno);
    end;
  end;
end;

procedure TA040FPianifRepMW.TurniIntersecati(T1,T2:String);
var I1,I2,F1,F2,F1Ori,F2Ori:Integer;
    ConfigOK:Boolean;
begin
  if (T1 <> '') and (T2 <> '') then
  begin
    try
      ConfigOK:=True;
      I1:=R180OreMinuti(R180VarToDateTime(Q350.Lookup('CODICE',T1,'ORAINIZIO')));
      F1Ori:=R180OreMinuti(R180VarToDateTime(Q350.Lookup('CODICE',T1,'ORAFINE')));
      F1:=F1Ori;
      if F1 <= I1 then
        inc(F1,1440);
      if T2 <> '' then
      begin
        I2:=R180OreMinuti(R180VarToDateTime(Q350.Lookup('CODICE',T2,'ORAINIZIO')));
        F2Ori:=R180OreMinuti(R180VarToDateTime(Q350.Lookup('CODICE',T2,'ORAFINE')));
        F2:=F2Ori;
        if F2 <= I2 then
          inc(F2,1440);
      end;
    except
      ConfigOK:=False;
      if Assigned(evtRichiestaRefresh) then
        evtRichiestaRefresh(Format(A000MSG_A040_DLG_FMT_CONFIGURAZIONE_KO,['','']),IntToStr(IMax) + 'TurniIntersConfigKO ' + T1 + ' ' + T2);
    end;
    if ConfigOK then
      if ((I2 >= I1) and (I2 < F1)) or ((F2 > I1) and (F2 <= F1)) or
         ((I2 <= I1) and (F2 >= F1)) then
        if Assigned(evtRichiestaRefresh) then
          evtRichiestaRefresh(Format(A000MSG_A040_DLG_FMT_TURNI_SOVRAPPOSTI,['',
                                                                             T1,R180MinutiOre(I1),R180MinutiOre(F1Ori),
                                                                             T2,R180MinutiOre(I2),R180MinutiOre(F2Ori)]),
                              IntToStr(IMax) + 'TurniIntersecati ' + T1 + ' ' + T2);
  end;
end;

function TA040FPianifRepMW.RefreshSelDatoLibero(Data:TDateTime):Boolean;
begin
  Result:=False;
  if selDatoLibero.Active and (selDatoLibero.VariableIndex('DECORRENZA') >= 0) and (Data > 0) then
  begin
    R180SetVariable(selDatoLibero,'DECORRENZA',Data);
    if not selDatoLibero.Active then
    begin
      Result:=True;
      selDatoLibero.Open;
    end;
  end;
end;

procedure TA040FPianifRepMW.RefreshT380;
begin
  with selT380 do
  begin
    Close;
    SetVariable('DATADA',DataInizio);
    SetVariable('DATAA',DataFine);
    SetVariable('FILTRO',Filtro);
    SetVariable('TIPOLOGIA',CodTipologia);
    if VariableIndex('DATALAVORO') >= 0 then
      DeleteVariable('DATALAVORO');
    if VariableIndex('C700DATADAL') >= 0 then
      DeleteVariable('C700DATADAL');
    if Pos(':DATALAVORO',UpperCase(Filtro)) > 0 then
      DeclareAndSet('DATALAVORO',otDate,DataFine);
    if Pos(':C700DATADAL',UpperCase(Filtro)) > 0 then
      DeclareAndSet('C700DATADAL',otDate,DataInizio);
    Open;
  end;
  CaricaElencoDate;
end;

procedure TA040FPianifRepMW.CaricaElencoDate;
var i:integer;
    Puntatore:TBookmark;
begin
  for i:=1 to 31 do
  begin
    ElencoDate[i].Data:=0;
    ElencoDate[i].Colorata:=False;
  end;
  i:=1;
  with selT380 do
  begin
    Puntatore:=GetBookmark;
 	  try
      DisableControls;
      First;
      ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
      inc(i);
      while not Eof do
      begin
        if ElencoDate[i - 1].Data <> FieldByName('DATA').AsDateTime then
        begin
          ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
          ElencoDate[i].Colorata:=not ElencoDate[i - 1].Colorata;
          inc(i);
        end;
        Next;
      end;
      GotoBookmark(Puntatore);
	  finally
      FreeBookmark(Puntatore);
	  end;
    EnableControls;
  end;
end;

procedure TA040FPianifRepMW.TurniIntersecatiTipologieDiverse(T1,T2:String;DataRif:TDateTime);
var I1,I2,F1,F2,F1Ori,F2Ori:Integer;
  Tipo1,Tipo2:String;
  ConfigOK:Boolean;
begin
  if (T1 <> '') and (T2 <> '') then
  begin
    try
      ConfigOk:=True;
      if CodTipologia = 'R' then
      begin
        Tipo1:='Guardia';
        Tipo2:='Reperibilità';
      end
      else if CodTipologia = 'G' then
      begin
        Tipo1:='Reperibilità';
        Tipo2:='Guardia';
      end;
      I1:=R180OreMinuti(R180VarToDateTime(Q350Opposto.Lookup('CODICE',T1,'ORAINIZIO')));
      F1Ori:=R180OreMinuti(R180VarToDateTime(Q350Opposto.Lookup('CODICE',T1,'ORAFINE')));
      F1:=F1Ori;
      if F1 <= I1 then
        inc(F1,1440);
      if T2 <> '' then
      begin
        I2:=R180OreMinuti(R180VarToDateTime(Q350.Lookup('CODICE',T2,'ORAINIZIO')));
        F2Ori:=R180OreMinuti(R180VarToDateTime(Q350.Lookup('CODICE',T2,'ORAFINE')));
        F2:=F2Ori;
        if F2 <= I2 then
          inc(F2,1440);
      end;
    except
      ConfigOK:=False;
      if Assigned(evtRichiestaRefresh) then
        evtRichiestaRefresh(Format(A000MSG_A040_DLG_FMT_CONFIGURAZIONE_KO,['di reperibilità/guardia','in data ' + FormatDateTime('dd/mm/yyyy',DataRif)]),
                            IntToStr(IMax) + 'TurniIntersTipiDivConfigKO ' + T1 + ' ' + T2);
    end;
    if ConfigOK then
      if ((I2 >= I1) and (I2 < F1)) or ((F2 > I1) and (F2 <= F1)) or
         ((I2 <= I1) and (F2 >= F1)) then
        if Assigned(evtRichiestaRefresh) then
          evtRichiestaRefresh(Format(A000MSG_A040_DLG_FMT_TURNI_SOVRAPPOSTI,['tra Reperibilità e Guardia in data ' + FormatDateTime('dd/mm/yyyy',DataRif),
                                                                             Tipo1 + ': ' + T1,R180MinutiOre(I1),R180MinutiOre(F1Ori),
                                                                             Tipo2 + ': ' + T2,R180MinutiOre(I2),R180MinutiOre(F2Ori)]),
                              IntToStr(IMax) + 'TurniIntersTipiDiv ' + T1 + ' ' + T2);
  end;
end;

procedure TA040FPianifRepMW.VerificaLimiteMese(const Turni:array of String;DataAttuale:TDateTime;Stato:TDataSetState;RigaID:String;Prog:Integer);
var
  i,MaxMese,TotMese:Integer;
  TotMeseTurniInteri: Real;
  Messaggio: String;
  BloccaMaxMese:Boolean;
begin
  if (StrToIntDef(VarToStr(Q350.Lookup('CODICE',Turni[0],'PIANIF_MAX_MESE')),0) = 0) and
     (StrToIntDef(VarToStr(Q350.Lookup('CODICE',Turni[1],'PIANIF_MAX_MESE')),0) = 0) and
     (StrToIntDef(VarToStr(Q350.Lookup('CODICE',Turni[2],'PIANIF_MAX_MESE')),0) = 0) then
    exit;
  // 1. considera i turni della riga attuale (in fase di insert / edit)
  with selSumTurniAtt do
  try
    ClearVariables;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('TIPOLOGIA',CodTipologia);
    SetVariable('DATARIF',DataAttuale);
    SetVariable('TURNO1',Turni[0]);
    SetVariable('TURNO2',Turni[1]);
    SetVariable('TURNO3',Turni[2]);
    Execute;

    // incrementa i totali: turni interi / numero turni assoluto
    TotMeseTurniInteri:=FieldAsFloat(0);
    TotMese:=FieldAsInteger(1);
  except
    TotMeseTurniInteri:=0;
    TotMese:=0;
  end;

  // 2. considera i turni del mese, esclusa riga attuale
  with selT380SumTurniMese do
  try
    ClearVariables;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('TIPOLOGIA',CodTipologia);
    SetVariable('DATADA',DataInizio);
    SetVariable('DATAA',DataFine);
    if Stato = dsEdit then
      SetVariable('FILTRO',Format('and    t380.rowid <> ''%s''',[RigaID]));
    Execute;

    // incrementa i totali: turni interi / numero turni assoluto
    TotMeseTurniInteri:=TotMeseTurniInteri + FieldAsFloat(0);
    TotMese:=TotMese + FieldAsInteger(1);
  except
  end;

  // verifica i limiti per i turni
  for i:=0 to High(Turni) do
  begin
    if Trim(Turni[i]) = '' then
      Continue;

    Q350.SearchRecord('CODICE',Turni[i],[srFromBeginning]);
    // se non è specificato un limite passa al prossimo turno
    if Q350.FieldByName('PIANIF_MAX_MESE').IsNull then
      MaxMese:=0
    else
      MaxMese:=Q350.FieldByName('PIANIF_MAX_MESE').AsInteger;
    if MaxMese = 0 then
      Continue;
    BloccaMaxMese:=Q350.FieldByName('BLOCCA_MAX_MESE').AsString = 'S';
    // verifica limiti in base al parametro turni interi
    if Q350.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').AsString = 'S' then
    begin
      if TotMeseTurniInteri > MaxMese then
      begin
        Messaggio:=Format(A000MSG_A040_DLG_FMT_LIMITE_SUPERATO,[Turni[i],
                                                                'interi',Format('%f',[TotMeseTurniInteri]),
                                                                'interi',MaxMese,
                                                                IfThen(BloccaMaxMese,'','Vuoi continuare?')]);
        if BloccaMaxMese then
        begin
          PulisciVariabili;
          raise exception.Create(Messaggio);
        end
        else
          if Assigned(evtRichiesta) then
            evtRichiesta(Messaggio,IntToStr(IMax) + 'LimiteMeseTurniInteri ' + Turni[i])
      end;
    end
    else
    begin
      if TotMese > MaxMese then
      begin
        Messaggio:=Format(A000MSG_A040_DLG_FMT_LIMITE_SUPERATO,[Turni[i],
                                                                '',Format('%d',[TotMese]),
                                                                '',MaxMese,
                                                                IfThen(BloccaMaxMese,'','Vuoi continuare?')]);
        if BloccaMaxMese then
        begin
          PulisciVariabili;
          raise Exception.Create(Messaggio);
        end
        else
          if Assigned(evtRichiesta) then
            evtRichiesta(Messaggio,IntToStr(IMax) + 'LimiteMeseTurni ' + Turni[i])
      end;
    end;
  end; // => end for
end;

procedure TA040FPianifRepMW.ImpostaFiltro(Testo:String);
begin
  Filtro:='';
  if (Testo <> '') and (Pos('ORDER BY',Testo) <> 1) then
    if Pos('ORDER BY',Testo) > 0 then
      Filtro:=' AND ' + StringReplace(Copy(Testo,Pos('WHERE ',Testo) + 6,Pos('ORDER BY', Testo) - (Pos('WHERE ',Testo) + 6)),':DataLavoro','T380.DATA',[rfIgnoreCase,rfReplaceAll])
    else
      Filtro:=' AND ' + StringReplace(Copy(Testo,Pos('WHERE ',Testo) + 6,Length(Testo) - (Pos('WHERE ',Testo) + 6)),':DataLavoro','T380.DATA',[rfIgnoreCase,rfReplaceAll]);
  if Filtro = ' AND ' then
    Filtro:='';
end;

procedure TA040FPianifRepMW.ImpostaCampiLookup;
begin
  selT380.FieldByName('D_MATRICOLA').FieldKind:=fkLookup;
  selT380.FieldByName('D_MATRICOLA').LookupDataSet:=SelAnagrafeLookUp;
  selT380.FieldByName('D_MATRICOLA').LookupKeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_MATRICOLA').LookupResultField:='MATRICOLA';
  selT380.FieldByName('D_MATRICOLA').KeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_BADGE').FieldKind:=fkLookup;
  selT380.FieldByName('D_BADGE').LookupDataSet:=SelAnagrafeLookUp;
  selT380.FieldByName('D_BADGE').LookupKeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_BADGE').LookupResultField:='T430BADGE';
  selT380.FieldByName('D_BADGE').KeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_NOMINATIVO').FieldKind:=fkLookup;
  selT380.FieldByName('D_NOMINATIVO').LookupDataSet:=SelAnagrafeLookUp;
  selT380.FieldByName('D_NOMINATIVO').LookupKeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_NOMINATIVO').LookupResultField:='NOMINATIVO';
  selT380.FieldByName('D_NOMINATIVO').KeyFields:='PROGRESSIVO';
end;

function TA040FPianifRepMW.GetHint(ConsideraDatoLibero:Boolean):String;
var DescT1,DescT2,DescT3: String;
  function GetDescrizioneTurno(const CodTurno : String):String;
  begin
    Result:='';
    if Q350.Locate('CODICE',CodTurno,[loCaseInsensitive]) then
      Result:=Q350.FieldByName('DESCRIZIONE').AsString + ': ' +
        FormatDateTime('hh.mm',Q350.FieldByName('OraInizio').AsDateTime) + '-' +
        FormatDateTime('hh.mm',Q350.FieldByName('OraFine').AsDateTime);
  end;
  function GetDescrizioneDatoLibero(const Codice: String):String;
  begin
    Result:='';
    RefreshSelDatoLibero(selT380.FieldByName('DATA').AsDateTime);
    if selDatoLibero.Locate('CODICE',Codice,[loCaseInsensitive]) then
      Result:=selDatoLibero.FieldByName('DESCRIZIONE').AsString;
  end;
begin
  Result:=selT380.FieldByName('D_NOMINATIVO').AsString;
  DescT1:=GetDescrizioneTurno(selT380.FieldByName('Turno1').AsString);
  if DescT1 <> '' then
    Result:=Result + #13#10 + selT380.FieldByName('Turno1').AsString + ': ' + DescT1;
  if not selT380.FieldByName('PRIORITA1').IsNull then
    Result:=Result + Format(' (%d)',[selT380.FieldByName('PRIORITA1').AsInteger]);
  if selT380.FieldByName('Recapito1').AsString <> '' then
    Result:=Result + #13#10 + 'Rec. alt. 1: ' + selT380.FieldByName('Recapito1').AsString;
  DescT2:=GetDescrizioneTurno(selT380.FieldByName('Turno2').AsString);
  if DescT2 <> '' then
    Result:=Result + #13#10 + selT380.FieldByName('Turno2').AsString + ': ' + DescT2;
  if not selT380.FieldByName('PRIORITA2').IsNull then
    Result:=Result + Format(' (%d)',[selT380.FieldByName('PRIORITA2').AsInteger]);
  if selT380.FieldByName('Recapito2').AsString <> '' then
    Result:=Result + #13#10 + 'Rec. alt. 2: ' + selT380.FieldByName('Recapito2').AsString;
  DescT3:=GetDescrizioneTurno(selT380.FieldByName('Turno3').AsString);
  if GetDescrizioneTurno(selT380.FieldByName('Turno3').AsString) <> '' then
    Result:=Result + #13#10 + selT380.FieldByName('Turno3').AsString + ': ' + DescT3;
  if not selT380.FieldByName('PRIORITA3').IsNull then
    Result:=Result + Format(' (%d)',[selT380.FieldByName('PRIORITA3').AsInteger]);
  if selT380.FieldByName('Recapito3').AsString <> '' then
    Result:=Result + #13#10 + 'Rec. alt. 3: ' + selT380.FieldByName('Recapito3').AsString;
  if ConsideraDatoLibero and (selT380.FieldByName('DATOLIBERO').AsString <> '') then
    Result:=Result + #13#10 + R180Capitalize(selT380.FieldByName('DATOLIBERO').DisplayLabel) + ' : ' +
            Trim(selT380.FieldByName('DATOLIBERO').AsString) + ' ' +
            GetDescrizioneDatoLibero(selT380.FieldByName('DATOLIBERO').AsString);
end;

procedure TA040FPianifRepMW.InserisciGestioneMensile;
var C1,C2,C3,C4,P1,P2,P3,DA1T1,DA1T2,DA1T3,DA2T1,DA2T2,DA2T3,R1,R2,R3:String;
    AST1,AST2,AST3:String;
    i:Integer;
    DataRif:TDateTime;
  procedure SettaQuery(Data:TDateTime);
  begin
    insT380.ClearVariables;
    insT380.SetVariable('Progressivo',ProgGM);
    insT380.SetVariable('Data',Data);
    insT380.SetVariable('Tipologia',CodTipologia);
    insT380.SetVariable('Turno1',C1);
    insT380.SetVariable('Turno2',C2);
    insT380.SetVariable('Turno3',C3);
    insT380.SetVariable('DatoLibero',C4);
    if P1 <> '' then
      insT380.SetVariable('Priorita1',P1);
    if P2 <> '' then
      insT380.SetVariable('Priorita2',P2);
    if P3 <> '' then
      insT380.SetVariable('Priorita3',P3);
    insT380.SetVariable('DatoAgg1_T1',DA1T1);
    insT380.SetVariable('DatoAgg1_T2',DA1T2);
    insT380.SetVariable('DatoAgg1_T3',DA1T3);
    insT380.SetVariable('DatoAgg2_T1',DA2T1);
    insT380.SetVariable('DatoAgg2_T2',DA2T2);
    insT380.SetVariable('DatoAgg2_T3',DA2T3);
    insT380.SetVariable('AreaSquadra_T1',AST1);
    insT380.SetVariable('AreaSquadra_T2',AST2);
    insT380.SetVariable('AreaSquadra_T3',AST3);
    insT380.SetVariable('Recapito1',R1);
    insT380.SetVariable('Recapito2',R2);
    insT380.SetVariable('Recapito3',R3);
    try
      insT380.Execute;
      RegistraLog.SettaProprieta('I','T380_PIANIFREPERIB',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(insT380.GetVariable('Progressivo')));
      RegistraLog.InserisciDato('DATA','',VarToStr(insT380.GetVariable('Data')));
      RegistraLog.InserisciDato('TIPOLOGIA','',CodTipologia);
      RegistraLog.InserisciDato('TURNO1','',VarToStr(insT380.GetVariable('Turno1')));
      if C2 <> '' then
        RegistraLog.InserisciDato('TURNO2','',VarToStr(insT380.GetVariable('Turno2')));
      if C3 <> '' then
        RegistraLog.InserisciDato('TURNO3','',VarToStr(insT380.GetVariable('Turno3')));
      if C4 <> '' then
        RegistraLog.InserisciDato('DATOLIBERO','',VarToStr(insT380.GetVariable('DATOLIBERO')));
      if P1 <> '' then
        RegistraLog.InserisciDato('PRIORITA1','',VarToStr(insT380.GetVariable('Priorita1')));
      if P2 <> '' then
        RegistraLog.InserisciDato('PRIORITA2','',VarToStr(insT380.GetVariable('Priorita2')));
      if P3 <> '' then
        RegistraLog.InserisciDato('PRIORITA3','',VarToStr(insT380.GetVariable('Priorita3')));
      if DA1T1 <> '' then
        RegistraLog.InserisciDato('DATOAGG1_T1','',VarToStr(insT380.GetVariable('DatoAgg1_T1')));
      if DA1T2 <> '' then
        RegistraLog.InserisciDato('DATOAGG1_T2','',VarToStr(insT380.GetVariable('DatoAgg1_T2')));
      if DA1T3 <> '' then
        RegistraLog.InserisciDato('DATOAGG1_T3','',VarToStr(insT380.GetVariable('DatoAgg1_T3')));
      if DA2T1 <> '' then
        RegistraLog.InserisciDato('DATOAGG2_T1','',VarToStr(insT380.GetVariable('DatoAgg2_T1')));
      if DA2T2 <> '' then
        RegistraLog.InserisciDato('DATOAGG2_T2','',VarToStr(insT380.GetVariable('DatoAgg2_T2')));
      if DA2T3 <> '' then
        RegistraLog.InserisciDato('DATOAGG2_T3','',VarToStr(insT380.GetVariable('DatoAgg2_T3')));
      if AST1 <> '' then
        RegistraLog.InserisciDato('AREASQUADRA_T1','',VarToStr(insT380.GetVariable('AreaSquadra_T1')));
      if AST2 <> '' then
        RegistraLog.InserisciDato('AREASQUADRA_T2','',VarToStr(insT380.GetVariable('AreaSquadra_T2')));
      if AST3 <> '' then
        RegistraLog.InserisciDato('AREASQUADRA_T3','',VarToStr(insT380.GetVariable('AreaSquadra_T3')));

      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
    end;
  end;
begin
  ProceduraChiamante:=1;//InserisciGestioneMensile
  try
    Controlli('I');
    C1:=Turno1Value;
    if (C1 <> '') and (StrToIntDef(VarToStr(Priorita1Value),0) <> 0) then
      P1:=Priorita1Value;
    if (C1 <> '') and (DatoAgg1T1Value <> null) then
      DA1T1:=DatoAgg1T1Value;
    if (C1 <> '') and (DatoAgg2T1Value <> null) then
      DA2T1:=DatoAgg2T1Value;
    if (C1 <> '') and (DatoAreaSquadraT1Value <> null) then
      AST1:=DatoAreaSquadraT1Value;
    if (C1 <> '') and (Recapito1Value <> null) then
      R1:=Recapito1Value;

    if Turno2Value <> null then
      C2:=Turno2Value
    else
      C2:='';
    if (C2 <> '') and (StrToIntDef(VarToStr(Priorita2Value),0) <> 0) then
      P2:=Priorita2Value;
    if (C2 <> '') and (DatoAgg1T2Value <> null) then
      DA1T2:=DatoAgg1T2Value;
    if (C2 <> '') and (DatoAgg2T2Value <> null) then
      DA2T2:=DatoAgg2T2Value;
    if (C2 <> '') and (DatoAreaSquadraT2Value <> null) then
      AST2:=DatoAreaSquadraT2Value;
    if (C1 <> '') and (Recapito2Value <> null) then
      R2:=Recapito2Value;

    if Turno3Value <> null then
      C3:=Turno3Value
    else
      C3:='';
    if (C3 <> '') and (StrToIntDef(VarToStr(Priorita3Value),0) <> 0) then
      P3:=Priorita3Value;
    if (C3 <> '') and (DatoAgg1T3Value <> null) then
      DA1T3:=DatoAgg1T3Value;
    if (C3 <> '') and (DatoAgg2T3Value <> null) then
      DA2T3:=DatoAgg2T3Value;
    if (C3 <> '') and (DatoAreaSquadraT3Value <> null) then
      AST3:=DatoAreaSquadraT3Value;
    if (C3 <> '') and (Recapito3Value <> null) then
      R3:=Recapito3Value;

    if DatoLiberoValue <> null then
      C4:=DatoLiberoValue
    else
      C4:='';

    for i:=0 to ListaGiorniSel.Count - 1 do
    begin
      if i < IMax then
        Continue;
      IMax:=i;
      DataRif:=StrToDate(Copy(ListaGiorniSel[i],5,10));
      if QueryPK1.EsisteChiave('T380_PIANIFREPERIB',selT380.RowId,selT380.State,['PROGRESSIVO','DATA','TIPOLOGIA'],[IntToStr(ProgGM),DateToStr(DataRif),CodTipologia]) then
      begin
        PulisciVariabili;
        raise ExceptionNoLog.Create(A000MSG_A040_ERR_ESISTE_PIANIFICAZIONE);
      end;
      R180SetVariable(selT385,'PROGRESSIVO',ProgGM);
      R180SetVariable(selT385,'TIPO',CodTipologia);
      R180SetVariable(selT385,'DATA',DataRif);
      selT385.Open;
      ControlloVincoliIndividuali(C1);
      ControlloVincoliIndividuali(C2);
      ControlloVincoliIndividuali(C3);
      VerificaLimiteMese([C1,C2,C3],DataRif,selT380.State,selT380.Rowid,ProgGM);
      if (GiornataAssenza(DataRif,ProgGM)) and
        (NonContDipPian or (TurnoNonInserito(C1,C2,C3,DataRif,ProgGM))) then
      begin
        if not RaggruppamentiAbilitati(ProgGM,DataRif) then
        begin
          if Assigned(evtRaggrAbilitati) then
            evtRaggrAbilitati(Format(A000MSG_A040_ERR_DLG_FMT_NO_RAGGR,[sTipo,FormatDateTime('dd/mm/yyyy',DataRif),'Proseguire con la pianificazione mensile?']),IntToStr(IMax) + 'RaggrAbilitati');
        end
        else
        begin
          with selT380a do
          begin
            Close;
            SetVariable('PROGRESSIVO',ProgGM);
            SetVariable('DATA',DataRif);
            SetVariable('TIPOLOGIA',CodTipologia);
            Open;
            if RecordCount > 0 then
            begin
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,VarToStr(Turno1Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,VarToStr(Turno2Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,VarToStr(Turno3Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,VarToStr(Turno1Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,VarToStr(Turno2Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,VarToStr(Turno3Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,VarToStr(Turno1Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,VarToStr(Turno2Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,VarToStr(Turno3Value),DataRif);
            end;
          end;
          SettaQuery(DataRif);
        end;
      end;
      sGiornataAssenza:='';
      sTurnoNonInserito:='';
    end;
    PulisciVariabili(True);
  except
    on E:Exception do
      if not(E is EAbort) then
      begin
        PulisciVariabili;
        raise;
      end;
  end;
end;

procedure TA040FPianifRepMW.CancellaGestioneMensile;
var
  i:Integer;
  Where:String;
begin
  ProceduraChiamante:=2;//CancellaGestioneMensile
  try
    Controlli('E');
    if IMax = 0 then
      if Assigned(evtRichiesta) then
        evtRichiesta(A000MSG_DLG_CANCELLAZIONE_MASSIVA,IntToStr(IMax) + 'ConfermaCancellazione');
    Where:='';
    if VarToStr(Turno1Value) <> '' then
      Where:=' AND TURNO1 = ''' + VarToStr(Turno1Value) + '''';
    if VarToStr(Turno2Value) <> '' then
      Where:=Where + ' AND TURNO2 = ''' + VarToStr(Turno2Value)  + '''';
    if VarToStr(Turno3Value) <> '' then
      Where:=Where + ' AND TURNO3 = ''' + VarToStr(Turno3Value)  + '''';
    if VarToStr(DatoLiberoValue) <> '' then
      Where:=Where + ' AND DATOLIBERO = ''' + VarToStr(DatoLiberoValue)  + '''';
    RecordT380Cancellati:=False;
    for i:=0 to ListaGiorniSel.Count - 1 do
    begin
      if i < IMax then
        Continue;
      IMax:=i;
      delT380.SetVariable('PROGRESSIVO',ProgGM);
      delT380.SetVariable('DATA',StrToDate(Copy(ListaGiorniSel[i],5,10)));
      delT380.SetVariable('TIPOLOGIA',CodTipologia);
      delT380.SetVariable('WHERE',Where);
      delT380.Execute;
      if delT380.RowsProcessed > 0 then
      begin
        RegistraLog.SettaProprieta('C','T380_PIANIFREPERIB',NomeOwner,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(delT380.GetVariable('Progressivo')));
        RegistraLog.InserisciDato('DATA','',VarToStr(delT380.GetVariable('Data')));
        if VarToStr(Turno1Value) <> '' then
          RegistraLog.InserisciDato('TURNO1','',VarToStr(Turno1Value));
        if VarToStr(Turno2Value) <> '' then
          RegistraLog.InserisciDato('TURNO2','',VarToStr(Turno2Value));
        if VarToStr(Turno3Value) <> '' then
          RegistraLog.InserisciDato('TURNO3','',VarToStr(Turno3Value));
        if VarToStr(DatoLiberoValue) <> '' then
          RegistraLog.InserisciDato('DATOLIBERO','',VarToStr(DatoLiberoValue));
        RegistraLog.RegistraOperazione;
        //Se vengono cancellati dei record
        //committo e aggiorno lista reperibilità
        RecordT380Cancellati:=True;
      end;
    end;
    if RecordT380Cancellati then
    begin
      SessioneOracle.Commit;
    end;
    PulisciVariabili;
  except
    on E:Exception do
      if not(E is EAbort) then
      begin
        PulisciVariabili;
        raise;
      end;
  end;
end;

procedure TA040FPianifRepMW.CancellaTurniEsistenti;
begin
  with selT380 do
  begin
    First;
    while not Eof do
      Delete;
  end;
end;

procedure TA040FPianifRepMW.Controlli(Modo:String);
  procedure ControllaPriorita(NTurno:Integer;TurnoValue,PrioritaValue:Variant);
  begin
    if (TurnoValue <> '') and (TurnoValue <> null)
    and (PrioritaValue <> '') and (PrioritaValue <> null)
    and ((StrToIntDef(VarToStr(PrioritaValue),0) < 1) or (StrToIntDef(VarToStr(PrioritaValue),0) > 9)) then
      raise Exception.Create(Format(A000MSG_A040_ERR_FMT_RANGE_PRIORITA,[IntToStr(NTurno)]));
  end;
begin
  if Trim(Dipendente) = '' then
    raise ExceptionNoLog.Create(A000MSG_ERR_NO_DIP);
  if selDatiBloccati.DatoBloccato(ProgGM,DataControllo,'T380') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if ListaGiorniSel.Count <= 0 then
    raise ExceptionNoLog.Create(A000MSG_ERR_NO_LISTA_GIORNI);
  if Modo = 'I' then
  begin
    if (Turno1Value = '') or (Turno1Value = null) then
      raise ExceptionNoLog.Create(A000MSG_A040_ERR_NO_TURNO_1);
    if (Turno1Value = Turno2Value) or
       (Turno1Value = Turno3Value) then
      raise ExceptionNoLog.Create(A000MSG_A040_ERR_TURNO_RIPETUTO);
    if (Turno2Value <> null) and (Turno2Value <> '') and (Turno2Value = Turno3Value) then
      raise ExceptionNoLog.Create(A000MSG_A040_ERR_TURNO_RIPETUTO);
    if ((Turno3Value <> '') and (Turno3Value <> null)) and
       ((Turno2Value = '') or (Turno2Value = null)) then
      raise ExceptionNoLog.Create(A000MSG_A040_ERR_NO_TURNO_2);
    if (Turno1Value <> '') and (Turno1Value <> null) then
      if VarToStr(Q350.Lookup('CODICE',Turno1Value,'CODICE')) = '' then
        raise ExceptionNoLog.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('TURNO1').DisplayLabel]));
    if (Turno2Value <> '') and (Turno2Value <> null) then
      if VarToStr(Q350.Lookup('CODICE',Turno2Value,'CODICE')) = '' then
        raise ExceptionNoLog.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('TURNO2').DisplayLabel]));
    if (Turno3Value <> '') and (Turno3Value <> null) then
      if VarToStr(Q350.Lookup('CODICE',Turno3Value,'CODICE')) = '' then
        raise ExceptionNoLog.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('TURNO3').DisplayLabel]));
    if (DatoLiberoValue <> '') and (DatoLiberoValue <> null) then
      if VarToStr(selDatoLibero.Lookup('CODICE',DatoLiberoValue,'CODICE')) = '' then
        raise ExceptionNoLog.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('DATOLIBERO').DisplayLabel]));
    ControllaPriorita(1,Turno1Value,Priorita1Value);
    ControllaPriorita(2,Turno2Value,Priorita2Value);
    ControllaPriorita(3,Turno3Value,Priorita3Value);
    if IMax = 0 then
    begin
      TurniIntersecati(VarToStr(Turno1Value),VarToStr(Turno2Value));
      TurniIntersecati(VarToStr(Turno1Value),VarToStr(Turno3Value));
      TurniIntersecati(VarToStr(Turno2Value),VarToStr(Turno3Value));
    end;
  end;
end;

procedure TA040FPianifRepMW.PulisciVariabili(VisualizzaMessaggioFineElaborazione:Boolean = False);
begin
  sGiornataAssenza:='';
  sTurnoNonInserito:='';
  IMax:=0;
  if Assigned(evtClearKeys) then
    evtClearKeys;
  //Solo per gestione mensile: chiusura elaborazione ed eventuale messaggio di Elaborazione Terminata
  if R180In(ProceduraChiamante,[1,2]) and Assigned(evtFineElaborazioneMensile) then
    evtFineElaborazioneMensile(VisualizzaMessaggioFineElaborazione);
end;

function TA040FPianifRepMW.GetCodiciTurnoUtilizzati(pTurni,pDataDa,pDataA:String;pTipoStampa,pSelTurni:Integer): String;
// estrae l'elenco dei codici turno utilizzati nel periodo
var S,S2,Turno: String;
    L: TStringList;
    i,conta: Integer;
begin
  Result:=pTurni;
  // COMO_HSANNA
  if (pTipoStampa > 0) and (pSelTurni = 0) then
  begin
    // salva in una stringlist i turni già proposti per verificare che siano tutti pianificati nel mese
    L:=TStringList.Create;
    try
      L.CommaText:=pTurni;

      // estrae i turni pianificati nel mese
      if Assigned(evtMergeSelAnagrafe) then
        evtMergeSelAnagrafe(selTurni);
      selTurni.Close;
      selTurni.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
      selTurni.SetVariable('TIPOLOGIA',CodTipologia);
      selTurni.SetVariable('DATA1',StrToDate(pDataDa));
      selTurni.SetVariable('DATA2',StrToDate(pDataA));
      selTurni.SetVariable('RAGGRUPPAMENTO','');
      selTurni.Open;

      // verifica che tutti i turni proposti nella casella siano pianificati nel mese
      for i:=0 to L.Count - 1 do
        if not VarIsNull(selTurni.Lookup('TURNO',L[i],'TURNO')) then
          S:=S + L[i] + ',';
      conta:=L.Count;

      // completa l'elenco con i turni pianificati nel mese
      // se prospetto per dipendente dà segnalazione se i turni superano quelli disponibili
      S2:='';
      while not selTurni.Eof do
      begin
        Turno:=selTurni.FieldByName('TURNO').AsString;
        if L.IndexOf(Turno) < 0 then
        begin
          if (pTipoStampa <> 2) or (conta < MAX_CODICI) or (StampaTurniOttimizzata) then
            S:=S + Turno + ','
          else
            S2:=S2 + Turno + ', ';
          inc(conta);
        end;
        selTurni.Next;
      end;
      S:=Copy(S,1,Length(S) - 1);
      Result:=S;

      if S2 <> '' then
      begin
        S2:=Copy(S2,1,Length(S2) - 2);
        if Assigned(evtMessaggio) then
          evtMessaggio(Format(A000MSG_A040_MSG_FMT_TURNI_ESCLUSI,[S2,IntToStr(MAX_CODICI)]));
      end;
    finally
      FreeAndNil(L);
    end;
  end;
end;

function TA040FPianifRepMW.GetCodiciTurnoUtilizzatiRaggruppamento(pTabellaCampoRaggr1, pNomeCampoRaggr1, pGruppo, pTurni: String): String;
// estrae l'elenco dei codici turno utilizzati nel periodo
var S,S2,Turno: String;
    L, LRaggr, LUser: TStringList;
    i: Integer;
    Gruppo: Boolean;
    Raggruppamento:String;
begin
  Raggruppamento:='AND ' + pTabellaCampoRaggr1 + '.' + pNomeCampoRaggr1 + ' = ''' + pGruppo + '''';
  Result:=pTurni;
  // salva in una stringlist i turni già proposti per verificare che siano tutti pianificati nel mese
  Gruppo:=False;
  L:=TStringList.Create;
  LUser:=TStringList.Create;
  LRaggr:=TStringList.Create;
  LRaggr.Sorted:=True;
  LRaggr.Duplicates:=dupIgnore;
  try
    L.CommaText:=pTurni;
    LUser.CommaText:=pTurni;

    // estrae i turni pianificati nel mese
    if Assigned(evtMergeSelAnagrafe) then
      evtMergeSelAnagrafe(selTurni);
    selTurni.Close;
    selTurni.SetVariable('RAGGRUPPAMENTO',Raggruppamento);
    selTurni.Open;

    // verifica che tutti i turni proposti nella casella siano pianificati nel mese
    for i:=0 to L.Count - 1 do
      if not VarIsNull(selTurni.Lookup('TURNO',L[i],'TURNO')) then
        S:=S + L[i] + ',';

    // completa l'elenco con i turni pianificati nel mese
    // se prospetto per dipendente dà segnalazione se i turni superano quelli disponibili
    while not selTurni.Eof do
    begin
      Turno:=selTurni.FieldByName('TURNO').AsString;
      if L.IndexOf(Turno) < 0 then
        S:=S + Turno + ',';
      selTurni.Next;
    end;
    S:=Copy(S,1,Length(S) - 1);
    L.CommaText:=S;
    if L.Count > MAX_CODICI then
    begin
      S:='';
      for i:=0 to MAX_CODICI-1 do
        S:=S + L[i] + ',';
      S2:='';
      for i:=MAX_CODICI to L.Count-1 do
        if LUser.IndexOf(L[i]) > 0 then
          LRaggr.Add(L[i]);   //Crea lista per messaggio a fine elaborazione [SAVONA_ASL2 - Chiamata: 170770 -> segnalati solo i turni indicati dall'utente che non possono stare nel report]
      S:=Copy(S,1,Length(S) - 1);
    end;

    if LRaggr.Count > 0 then
    begin
      LstTurniEsclusi:=LstTurniEsclusi + chr(10) +
                       selI010.FieldByName('NOME_LOGICO').AsString + ' ''' + pGruppo + ''':';
      for i:=0 to LRaggr.Count-1 do
        LstTurniEsclusi:=LstTurniEsclusi + ' ' + LRaggr[i] + IfThen(i < LRaggr.Count-1, ',', ';');
    end;
    Result:=S;
  finally
    FreeAndNil(L);
    FreeAndNil(LUser);
    FreeAndNil(LRaggr);
  end;
end;

function TA040FPianifRepMW.GetNumMaxTurniUtilizzati(pRaggruppamento: string; pDataDa,pDataA: TDateTime):Integer;
// estrae il numero di turni nel periodo
begin
  if Assigned(evtMergeSelAnagrafe) then
    evtMergeSelAnagrafe(selNumMaxTurni);
  selNumMaxTurni.Close;
  selNumMaxTurni.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  selNumMaxTurni.SetVariable('TIPOLOGIA',CodTipologia);
  selNumMaxTurni.SetVariable('DATA1',pDataDa);
  selNumMaxTurni.SetVariable('DATA2',pDataA);
  if pRaggruppamento = DATIAGG then
  begin
    selNumMaxTurni.SetVariable('RAGGRUPPAMENTO1','DATOAGG1_T1 || DATOAGG2_T1');
    selNumMaxTurni.SetVariable('RAGGRUPPAMENTO2','DATOAGG1_T2 || DATOAGG2_T2');
    selNumMaxTurni.SetVariable('RAGGRUPPAMENTO3','DATOAGG1_T3 || DATOAGG2_T3');
  end
  else
  begin
    selNumMaxTurni.SetVariable('RAGGRUPPAMENTO1',IfThen(pRaggruppamento <> '.', pRaggruppamento, 'NULL'));
    selNumMaxTurni.SetVariable('RAGGRUPPAMENTO2',IfThen(pRaggruppamento <> '.', pRaggruppamento, 'NULL'));
    selNumMaxTurni.SetVariable('RAGGRUPPAMENTO3',IfThen(pRaggruppamento <> '.', pRaggruppamento, 'NULL'));
  end;

  selNumMaxTurni.Open;
  Result:=selNumMaxTurni.Fields[0].AsInteger;
end;

procedure TA040FPianifRepMW.RecuperaTurni(pSelTurni:Integer);
begin
  // apre dataset dei turni da visualizzare
  selT350Cod.Close;
  selT350Cod.SetVariable('TIPOLOGIA',CodTipologia);
  selT350Cod.SetVariable('ORDERBY',IfThen(pSelTurni <> 0,'3, 4, ') + '1');
  selT350Cod.Open;
end;

procedure TA040FPianifRepMW.ControlliStampa(pDataDa,pDataA,pTurni,pValCampo:String;pTipoStampa,pDatiAssenza:Integer;pDettCodice,pDettOrario,pDettDatoLibero,pDettDatiAggiuntivi:Boolean);
var DataDaApp,DataAApp:TDateTime;
begin
  // controllo sul periodo
  if not TryStrToDate(pDataDa,DataDaApp) then
    raise exception.Create(A000MSG_A040_ERR_DATA_INIZIO);
  if not TryStrToDate(pDataA,DataAApp) then
    raise exception.Create(A000MSG_A040_ERR_DATA_FINE);
  if DataDaApp > DataAApp then
    raise exception.Create(A000MSG_A040_ERR_DATE_INVERTITE);
  if R180Anno(DataDaApp) <> R180Anno(DataAApp) then
    raise exception.Create(A000MSG_A040_ERR_DATE_STESSO_ANNO);
  // controlli specifici per tipo stampa
  case pTipoStampa of
    1:begin
        //tabellone
        if (pDatiAssenza = 0) and not (pDettCodice or pDettOrario or pDettDatoLibero or pDettDatiAggiuntivi) then
          if Assigned(evtRichiesta) then
            evtRichiesta(A000MSG_A040_DLG_NO_DETTAGLIO_STAMPA,'');
      end;
    2:begin
        // prospetto verticale
        if pTurni = '' then
          raise ExceptionNoLog.Create(A000MSG_A040_ERR_NO_TURNO);
      end;
    3:begin
        if pValCampo = '' then
          raise ExceptionNoLog.Create(A000MSG_A040_ERR_NO_CAMPO);
      end;
  end;
end;

end.
