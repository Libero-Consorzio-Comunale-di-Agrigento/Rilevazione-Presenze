unit A064UBudgetStraordinarioMW;

interface

uses
  System.SysUtils, System.Classes, Oracle, OracleData, Data.DB, Variants,
  Math, StrUtils, R005UDataModuleMW, C180FunzioniGenerali,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione;

type
  T064Dlg = procedure(msg,Chiave:String) of object;
  T064Prc = procedure of object;

  TMesi = record
    Minuti:Integer;
    MinFruito:Integer;
    Importo:Real;
    ImpFruito:Real;
  end;

  TA064FBudgetStraordinarioMW = class(TR005FDataModuleMW)
    selbV430: TOracleDataSet;
    selbV430MATRICOLA: TStringField;
    selbV430COGNOME: TStringField;
    selbV430NOME: TStringField;
    dsrV430: TDataSource;
    selT275: TOracleDataSet;
    selT275CODICE: TStringField;
    selT275DESCRIZIONE: TStringField;
    dsrT275: TDataSource;
    seleT713: TOracleDataSet;
    selV430: TOracleDataSet;
    selaT713: TOracleDataSet;
    selaV430: TOracleDataSet;
    updT714: TOracleQuery;
    updT713: TOracleQuery;
    delT714: TOracleQuery;
    updaT713: TOracleQuery;
    updaT714: TOracleQuery;
    selaT714: TOracleQuery;
    selbT713: TOracleDataSet;
    selcT713: TOracleDataSet;
    seldT713: TOracleDataSet;
    selT715: TOracleDataSet;
    delT715: TOracleQuery;
    insT715: TOracleQuery;
    selOperatori: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT275BeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    ArrMesi:Array[1..12] of TMesi;
    MinTotFruito:Integer;
    ImpTotFruito:Real;
    lstListaGruppi: TStringList;
    VariazioneOre,VariazioneImp:Boolean;
    ChiediAggiornaPeriodo,ChiediAggiornaOre,ChiediAggiornaImp,ChiediAggiornaFA:Boolean;
    StatoSelT713:String;
    AbilitatoOld:String;
    FiltroOkBP:Boolean;
    IniOld,FinOld:TDateTime;
    FResponsabileAutorizzatore: Boolean;
    procedure PutResponsabileAutorizzatore(const Value: boolean);
  public
    { Public declarations }
    DecIniOld,DecFinOld:TDateTime;
    wAnno:Integer;
    A064MWMsg:String;
    bFiltroAnnoDisallineato:Boolean;
    AggiornaPeriodo,AggiornaFA,AggiornaOre,AggiornaImp:Boolean;
    selT713: TOracleDataSet;
    selT714: TOracleDataSet;
    evtRichiesta:T064Dlg;
    evtMessaggio:T064Dlg;
    evtClearKeys:T064Prc;
    evtAumentaProgressBar:T064Prc;
    lstOperatoriSel: TStringList;
    lstAutorizzatoriSel: TStringList;
    function GetLstOperatori: TStringList;
    function GetLstOperatoriSelezionati: TStringList;
    procedure SetLstOperatoriSelezionati(pLstOperatori: TStringList);
    procedure CambioAnno(sAnno:String);
    procedure AperturaDettaglio;
    procedure CaricamentoMesi;
    procedure EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
    procedure StruttureDisponibili(pAnno:Integer;ListaGruppi:TStringList);
    procedure AperturaDipendenti;
    procedure selT713BeforePostNoStoricoInizio;
    procedure selT713BeforePostNoStoricoSalvaPrima;
    procedure selT713BeforePostNoStoricoSalvaDopo;
    procedure selT713BeforePostNoStoricoFine;
    procedure CaricaAggiornamenti;
    procedure AllineaDecorrenze;
    procedure selT713AfterPost;
    procedure selT713BeforeDelete;
    procedure selT713AfterDelete;
    procedure selT713AfterScroll;
    procedure selT713NewRecord(sAnno:String);
    procedure selT713AfterCancel;
    procedure selT713FilterRecord(var Accept: Boolean);
    procedure selT713CODGRUPPOValidate;
    procedure selT713DECORRENZAValidate;
    procedure selT713DECORRENZA_FINEValidate;
    function selT713FILTRO_ANAGRAFEValidate: Boolean;
    procedure selT714BeforeInsert;
    procedure selT714BeforeDelete;
    procedure selT714BeforePost;
    procedure selT714AfterPost;
    procedure selT714CalcFields;
    procedure selT714OREValidate(Sender: TField);
    procedure PulisciVariabili;
    function CaricaOperatori: String;
    property ResponsabileAutorizzatore:Boolean read FResponsabileAutorizzatore write PutResponsabileAutorizzatore;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses A063UBudgetGenerazioneMW;

{$R *.dfm}

procedure TA064FBudgetStraordinarioMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  lstListaGruppi:=TStringList.Create;
  selT275.Open;
  lstOperatoriSel:=TStringList.Create;
  lstAutorizzatoriSel:=TStringList.Create;
end;

procedure TA064FBudgetStraordinarioMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstListaGruppi);
  FreeAndNil(lstOperatoriSel);
  FreeAndNil(lstAutorizzatoriSel);
end;

procedure TA064FBudgetStraordinarioMW.CambioAnno(sAnno:String);
begin
  if Trim(Parametri.Inibizioni.Text) <> '' then
    StruttureDisponibili(StrToIntDef(sAnno,0),lstListaGruppi);
  R180SetVariable(selT713,'FiltroPeriodo','WHERE ANNO = ' + IfThen(sAnno = '','0',sAnno));
  selT713.Open;
end;

procedure TA064FBudgetStraordinarioMW.AperturaDettaglio;
begin
  R180SetVariable(selT714,'CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
  R180SetVariable(selT714,'TIPO',selT713.FieldByName('TIPO').AsString);
  R180SetVariable(selT714,'DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
  selT714.Open;
  selT714.First;
  CaricamentoMesi;
end;

procedure TA064FBudgetStraordinarioMW.CaricamentoMesi;
var i:Integer;
begin
  MinTotFruito:=0;
  ImpTotFruito:=0;
  for i:=1 to High(ArrMesi) do
  begin
    ArrMesi[i].Minuti:=R180OreMinutiExt(VarToStr(selT714.Lookup('MESE',VarArrayOf([i]),'ORE')));
    ArrMesi[i].MinFruito:=R180OreMinutiExt(VarToStr(selT714.Lookup('MESE',VarArrayOf([i]),'ORE_FRUITO')));
    ArrMesi[i].Importo:=StrToFloatDef(VarToStr(selT714.Lookup('MESE',VarArrayOf([i]),'IMPORTO')),0);
    ArrMesi[i].ImpFruito:=StrToFloatDef(VarToStr(selT714.Lookup('MESE',VarArrayOf([i]),'IMPORTO_FRUITO')),0);
    //
    if selT714.FieldByName('TIPO').AsString <> '#ECC#' then
    begin
      MinTotFruito:=MinTotFruito + ArrMesi[i].MinFruito;
      ImpTotFruito:=ImpTotFruito + ArrMesi[i].ImpFruito;
    end;
  end;
end;

function TA064FBudgetStraordinarioMW.CaricaOperatori: String;
var lst:TStringList;
begin
  selT715.Close;
  selT715.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
  selT715.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
  selT715.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
  selT715.Open;
  selT715.First;
  if ResponsabileAutorizzatore then
    lst:=lstAutorizzatoriSel
  else
    lst:=lstOperatoriSel;
  lst.Clear;
  Result:='';
  while not selT715.Eof do
  begin
    lst.Add(selT715.FieldByName('PROGRESSIVO').AsString);
    Result:=Result + selT715.FieldByName('OPERATORE').AsString + '; ';
    selT715.Next;
  end;
end;

procedure TA064FBudgetStraordinarioMW.EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
var S:String;
begin
  if Trim(Parametri.Inibizioni.Text) <> '' then
  begin
    if (pAnno > 0) and (pDaMese > 0) and (pAMese > 0) and
       (   (selV430.GetVariable('C700DATADAL') <> EncodeDate(pAnno,pDaMese,1))
        or (selV430.GetVariable('DATALAVORO') <> R180FineMese(EncodeDate(pAnno,pAMese,1)))) then
    begin
      selV430.Close;
      S:=StringReplace(QVistaOracle,
                       ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                       ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                       [rfIgnoreCase]);
      S:=StringReplace(S,
                       ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                       ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                       [rfIgnoreCase]);
      selV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
      selV430.SetVariable('C700DATADAL',EncodeDate(pAnno,pDaMese,1));
      selV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(pAnno,pAMese,1)));
      selV430.SetVariable('FILTRO',Parametri.Inibizioni.Text);
      if Pos(':NOME_UTENTE',Parametri.Inibizioni.Text) > 0  then
      begin
        try
          selV430.DeleteVariable('NOME_UTENTE');
        except
        end;
        selV430.DeclareVariable('NOME_UTENTE',otString);
        selV430.SetVariable('NOME_UTENTE',Parametri.Operatore);
      end;
      selV430.Open;
    end;
  end;
end;

function TA064FBudgetStraordinarioMW.GetLstOperatori: TStringList;
begin
  Result:=TStringList.Create;
  if R180SetVariable(selOperatori, 'DECORRENZA_FINE', Parametri.DataLavoro) then
    selOperatori.Open;

  selOperatori.First;
  while not selOperatori.Eof do
  begin
    Result.Add(selOperatori.FieldByName('OPERATORE').AsString);
    selOperatori.Next;
  end;
end;

function TA064FBudgetStraordinarioMW.GetLstOperatoriSelezionati: TStringList;
var
  i: integer;
  lst: TStringList;
begin //Dalla lista dei progressivi restituisce la lista di: MATRICOLA + ' - ' + COGNOME + ' ' + NOME
  Result:=TStringList.Create;
  if ResponsabileAutorizzatore then
    lst:=lstAutorizzatoriSel
  else
    lst:=lstOperatoriSel;
  for i:=0 to lst.Count-1 do
    if selOperatori.SearchRecord('PROGRESSIVO',lst[i], [srFromBeginning]) then
      Result.Add(selOperatori.FieldByName('OPERATORE').AsString);
end;

procedure TA064FBudgetStraordinarioMW.SetLstOperatoriSelezionati(pLstOperatori: TStringList);
var
  i: integer;
  lst: TStringList;
begin  //Aggiorna la lista dei progressivi degli operatori selezionati
  if ResponsabileAutorizzatore then
    lst:=lstAutorizzatoriSel
  else
    lst:=lstOperatoriSel;
  lst.Clear;
  for i:=0 to pLstOperatori.Count-1 do
    if selOperatori.SearchRecord('OPERATORE',pLstOperatori[i],[srFromBeginning]) then
      lst.Add(selOperatori.FieldByName('PROGRESSIVO').AsString);
end;

procedure TA064FBudgetStraordinarioMW.StruttureDisponibili(pAnno:Integer;ListaGruppi:TStringList);
//Estrazione delle strutture disponibili per l'operatore (FiltroAnagrafe e anno)
var
  FiltroOk: Boolean;
  s,FiltroOld: String;
  dDecIniOld,dDecFinOld: TDateTime;
begin
  if pAnno > 0 then
  begin
    selaT713.Close;
    selaT713.SetVariable('FiltroPeriodo','WHERE ANNO = ' + IntToStr(pAnno));
    selaT713.Open;
    ListaGruppi.Clear;
    FiltroOk:=False;
    FiltroOld:='*';
    dDecIniOld:=EncodeDate(pAnno,1,1) - 1;
    dDecFinOld:=EncodeDate(pAnno,1,1) - 1;
    while not selaT713.Eof do
    begin
      if (Trim(Parametri.Inibizioni.Text) <> '') then
      begin
        if (selaT713.FieldByName('FILTRO_ANAGRAFE').AsString <> FiltroOld)
        or (selaT713.FieldByName('DECORRENZA').AsDateTime <> dDecIniOld)
        or (selaT713.FieldByName('DECORRENZA_FINE').AsDateTime <> dDecFinOld) then
        begin
          FiltroOk:=False;
          EseguiFiltroAnagrafeUtente(pAnno,R180Mese(selaT713.FieldByName('DECORRENZA').AsDateTime),R180Mese(selaT713.FieldByName('DECORRENZA_FINE').AsDateTime));
          if selV430.Active and (selV430.RecordCount > 0) then
          begin
            selaV430.Close;
            S:=StringReplace(QVistaOracle,
                             ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                             ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                             [rfIgnoreCase]);
            S:=StringReplace(S,
                             ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                             ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                             [rfIgnoreCase]);
            selaV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
            selaV430.SetVariable('C700DATADAL',selaT713.FieldByName('DECORRENZA').AsDateTime);
            selaV430.SetVariable('DATALAVORO',selaT713.FieldByName('DECORRENZA_FINE').AsDateTime);
            selaV430.SetVariable('FILTRO',selaT713.FieldByName('FILTRO_ANAGRAFE').AsString);
            selaV430.Open;
            while not selaV430.Eof do
            begin
              if selV430.SearchRecord('PROGRESSIVO',selaV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
              begin
                FiltroOk:=True;
                Break;
              end;
              selaV430.Next;
            end;
          end;
          FiltroOld:=selaT713.FieldByName('FILTRO_ANAGRAFE').AsString;
          dDecIniOld:=selaT713.FieldByName('DECORRENZA').AsDateTime;
          dDecFinOld:=selaT713.FieldByName('DECORRENZA_FINE').AsDateTime;
        end
      end
      else
        FiltroOk:=True;
      if FiltroOk then
        ListaGruppi.Add(Format('%-10s %-5s %10s %-100s',[selaT713.FieldByName('CODGRUPPO').AsString, selaT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selaT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selaT713.FieldByName('DECORRENZA_FINE').AsDateTime), selaT713.FieldByName('DESCRIZIONE').AsString]));
      selaT713.Next;
    end;
  end;
end;

procedure TA064FBudgetStraordinarioMW.AperturaDipendenti;
var s:String;
begin
  if (selT713.FieldByName('DECORRENZA').AsDateTime <> selbV430.GetVariable('C700DATADAL'))
  or (selT713.FieldByName('DECORRENZA_FINE').AsDateTime <> selbV430.GetVariable('DATALAVORO'))
  or (selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> selbV430.GetVariable('FILTRO')) then
  begin
    selbV430.Close;
    //selbV430.SetVariable('QVISTAORACLE',QVistaOraclePeriodica + #10#13 + QVistaInServizioPeriodica);
    S:=StringReplace(QVistaOracle,
                     ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                     ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                     [rfIgnoreCase]);
    S:=StringReplace(S,
                     ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                     ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                     [rfIgnoreCase]);
    selbV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
    selbV430.SetVariable('C700DATADAL',selT713.FieldByName('DECORRENZA').AsDateTime);
    selbV430.SetVariable('DATALAVORO',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
    selbV430.SetVariable('FILTRO',IfThen(selT713.FieldByName('FILTRO_ANAGRAFE').IsNull,'1<>1',selT713.FieldByName('FILTRO_ANAGRAFE').AsString));
    selbV430.Open;
  end;
end;

procedure TA064FBudgetStraordinarioMW.selT713BeforePostNoStoricoInizio;
var Visualizza:Boolean;
    Riga,S,msg:String;
    OQ:TOracleQuery;
    i:Integer;
    ImpNew,ImpOld:Currency;
begin
  AbilitatoOld:='';
  if selT713.State in [dsEdit] then
    AbilitatoOld:=Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').medpOldValue, selT713.FieldByName('TIPO').medpOldValue, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').medpOldValue) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').medpOldValue), selT713.FieldByName('DESCRIZIONE').medpOldValue]);
  ChiediAggiornaPeriodo:=False;
  ChiediAggiornaFA:=False;
  ChiediAggiornaOre:=False;
  ChiediAggiornaImp:=False;
  AggiornaPeriodo:=False;
  AggiornaFA:=False;
  AggiornaOre:=False;
  AggiornaImp:=False;
  StatoSelT713:=IfThen(selT713.State in [dsEdit],'M','I');
  if Trim(selT713.FieldByName('CODGRUPPO').AsString) = '' then
  begin
    selT713.FieldByName('CODGRUPPO').FocusControl;
    raise exception.Create(A000MSG_A064_ERR_NO_CODICE);
  end;
  if Trim(selT713.FieldByName('TIPO').AsString) = '' then
  begin
    selT713.FieldByName('TIPO').FocusControl;
    raise exception.Create(A000MSG_A064_ERR_NO_TIPO);
  end;
  if Trim(selT713.FieldByName('ANNO').AsString) = '' then
  begin
    selT713.FieldByName('ANNO').FocusControl;
    raise exception.Create(A000MSG_A064_ERR_NO_ANNO);
  end
  else if bFiltroAnnoDisallineato then
  begin
    selT713.FieldByName('ANNO').FocusControl;
    raise exception.Create(A000MSG_A064_ERR_ANNO_UGUALE_FILTRO);
  end;
  if selT713.FieldByName('DECORRENZA').AsDateTime > selT713.FieldByName('DECORRENZA_FINE').AsDateTime then
    raise exception.Create(A000MSG_A064_ERR_INIZIO_FINE_VALIDITA);
  //Controllo che non sia stato inserito un codice gruppo che non si poteva visualizzare
  //if selT713.State in [dsInsert] then
  begin
    Visualizza:=False;
    selbT713.Close;
    selbT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    selbT713.SetVariable('DEC_INI',selT713.FieldByName('DECORRENZA').AsDateTime);
    selbT713.SetVariable('DEC_FIN',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
    selbT713.SetVariable('ID_RIGA',IfThen(selT713.State in [dsInsert],'ROWIDROWIDROWIDROW',selT713.Rowid));
    selbT713.Open;
    if (Trim(Parametri.Inibizioni.Text) <> '')
    and not selbT713.Eof then
    begin
      for i:=0 to lstListaGruppi.Count - 1 do
        if Trim(Copy(lstListaGruppi[i],1,10)) = selT713.FieldByName('CODGRUPPO').AsString then
        begin
          Visualizza:=True;
          Break;
        end;
    end
    else
      Visualizza:=True;
    if not Visualizza then
      raise exception.Create(Format(A000MSG_A064_ERR_FMT_GRUPPO_FA_NO_DIP,[IfThen(selT713.State in [dsInsert],'l''inserimento','la modifica')]));
  end;
  if Trim(selT713.FieldByName('FILTRO_ANAGRAFE').AsString) = '' then
  begin
    selT713.FieldByName('FILTRO_ANAGRAFE').FocusControl;
    raise exception.Create(A000MSG_A064_ERR_NO_FA);
  end
  else
  begin
    OQ:=TOracleQuery.Create(nil);
    try
      OQ.Session:=SessioneOracle;
      OQ.SQL.Text:=QVistaOracle;
      OQ.SQL.Insert(0,'SELECT COUNT(*) FROM');
      OQ.Sql.Add('AND (');
      Riga:=Trim(selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
      // sostituisce la parola riservata :NOME_UTENTE con un valore costante convenzionale
      // (l'execute ha infatti il solo fine di verificare la sintassi del filtro di selezione)
      Riga:=StringReplace(Riga,':NOME_UTENTE','''PROVA''',[rfReplaceAll,rfIgnoreCase]);
      OQ.Sql.Add(Riga);
      OQ.Sql.Add(')');
      //Imposto la data di lavoro per i dati storici
      OQ.DeclareVariable('DataLavoro',otDate);
      OQ.SetVariable('DataLavoro',Parametri.DataLavoro);
      try
        OQ.Execute;
      except
        on E:Exception do
          raise exception.Create(A000MSG_A064_ERR_SQL_FA + #13#10 + E.Message);
      end;
    finally
      OQ.Free;
    end;
    //Controllo che l'utente veda i dipendenti del filtro anagrafe
    EseguiFiltroAnagrafeUtente(selT713.FieldByName('ANNO').AsInteger,R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime),R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime));
    if selV430.Active and (selV430.RecordCount > 0) then
    begin
      FiltroOkBP:=False;
      selaV430.Close;
      S:=StringReplace(QVistaOracle,
                       ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                       ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                       [rfIgnoreCase]);
      S:=StringReplace(S,
                       ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                       ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                       [rfIgnoreCase]);
      selaV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
      selaV430.SetVariable('C700DATADAL',selT713.FieldByName('DECORRENZA').AsDateTime);
      selaV430.SetVariable('DATALAVORO',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
      selaV430.SetVariable('FILTRO',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
      selaV430.Open;
      while not selaV430.Eof do
      begin
        if selV430.SearchRecord('PROGRESSIVO',selaV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        begin
          FiltroOkBP:=True;
          Break;
        end;
        selaV430.Next;
      end;
      if not FiltroOkBP and (selT713.State in [dsInsert]) then
        raise exception.Create(A000MSG_A064_ERR_FA_NO_DIP);
    end;
  end;
  if (selT713.State in [dsEdit]) then
  begin
    if (selT713.FieldByName('DECORRENZA').AsDateTime <> DecIniOld)
    or (selT713.FieldByName('DECORRENZA_FINE').AsDateTime <> DecFinOld) then
    begin
      selaT714.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
      selaT714.SetVariable('DECORRENZA',DecIniOld);
      selaT714.Execute;
      if StrToIntDef(VarToStr(selaT714.Field(0)),0) > 0 then
      begin
        ChiediAggiornaPeriodo:=True;
        msg:=msg + IfThen(msg <> '',CRLF) + Format(A000MSG_A064_DLG_FMT_AGG_PERIODO,[selT713.FieldByName('CODGRUPPO').AsString,FormatDateTime('mm',DecIniOld),FormatDateTime('mm/yyyy',DecFinOld)]);
      end;
    end;
    if Trim(selT713.FieldByName('FILTRO_ANAGRAFE').AsString) <> Trim(VarToStr(selT713.FieldByName('FILTRO_ANAGRAFE').OldValue)) then
    begin
      ChiediAggiornaFA:=True;
      msg:=msg + IfThen(msg <> '',CRLF) + Format(A000MSG_A064_DLG_FMT_AGG_FA,[selT713.FieldByName('CODGRUPPO').AsString,FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime),FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime)]);
    end;
    if Trim(selT713.FieldByName('ORE').AsString) <> Trim(VarToStr(selT713.FieldByName('ORE').OldValue)) then
    begin
      ChiediAggiornaOre:=True;
      msg:=msg + IfThen(msg <> '',CRLF) + A000MSG_A064_DLG_AGG_ORE; //'Attenzione! E'' stato modificato il valore di Ore. Verrà sovrascritta l''assegnazione mensile del budget. Proseguire?';
    end;
    ImpNew:=selT713.FieldByName('IMPORTO').AsCurrency;
    ImpOld:=StrToFloatDef(VarToStr(selT713.FieldByName('IMPORTO').OldValue),0);
    if R180AzzeraPrecisione(ImpNew - ImpOld,2) <> 0 then //Se non si usa il Currency per entrambi i valori, a volte non funziona bene (es. old: 1201.56 --> new: 1201.57)
    begin
      ChiediAggiornaImp:=True;
      msg:=msg + IfThen(msg <> '',CRLF) + A000MSG_A064_DLG_AGG_IMPORTO;
    end;
    if msg <> '' then
      if Assigned(evtRichiesta) then
        evtRichiesta(msg,'Aggiornamenti'); //Se l'operatore decide di proseguire, viene richiamata CaricaAggiornamenti
  end;
end;

procedure TA064FBudgetStraordinarioMW.selT713BeforePostNoStoricoSalvaPrima;
var DecorrenzaUnica:Boolean;
    Decorrenze:String;
begin
  //Controllo che non esista la stessa chiave
  selcT713.Close;
  selcT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
  selcT713.SetVariable('DEC_INI',selT713.FieldByName('DECORRENZA').AsDateTime);
  selcT713.SetVariable('DEC_FIN',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
  selcT713.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
  if selT713.State in [dsInsert] then
    selcT713.SetVariable('ID_RIGA','ROWIDROWIDROWIDROW')
  else
    selcT713.SetVariable('ID_RIGA',selT713.Rowid);
  selcT713.Open;
  if selcT713.RecordCount > 0 then
    raise exception.Create(Format(A000MSG_A064_ERR_FMT_ESISTE_CHIAVE,[selcT713.FieldByName('DECORRENZA').AsString,selcT713.FieldByName('DECORRENZA_FINE').AsString]));
  if Assigned(evtAumentaProgressBar) then
    evtAumentaProgressBar;
  //Controllo che ci sia corrispondenza di filtri anagrafe per i diversi tipi dello stesso gruppo nello stesso periodo
  selbT713.Close;
  selbT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
  selbT713.SetVariable('DEC_INI',selT713.FieldByName('DECORRENZA').AsDateTime);
  selbT713.SetVariable('DEC_FIN',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
  selbT713.SetVariable('ID_RIGA','ROWIDROWIDROWIDROW');
  selbT713.Open;
  while not AggiornaFA and not selbT713.Eof do
  begin
    if selbT713.FieldByName('FILTRO_ANAGRAFE').AsString <> selT713.FieldByName('FILTRO_ANAGRAFE').AsString then
      if Assigned(evtRichiesta) then
        evtRichiesta(Format(A000MSG_A064_DLG_FMT_AGG_FA_2,[selT713.FieldByName('CODGRUPPO').AsString,FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime),FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime)]),'FADiversiTipiGruppo');
    selbT713.Next;
  end;
  if Assigned(evtAumentaProgressBar) then
    evtAumentaProgressBar;
  //Controllo che ci sia corrispondenza di periodi per i diversi tipi dello stesso gruppo
  selbT713.First;
  DecorrenzaUnica:=True;
  while not selbT713.Eof do
  begin
    if selbT713.RecNo = 1 then
    begin
      IniOld:=selbT713.FieldByName('DECORRENZA').AsDateTime;
      FinOld:=selbT713.FieldByName('DECORRENZA_FINE').AsDateTime;
    end
    else if (selbT713.FieldByName('DECORRENZA').AsDateTime <> IniOld)
         or (selbT713.FieldByName('DECORRENZA_FINE').AsDateTime <> FinOld) then
      DecorrenzaUnica:=False;
    if Pos(FormatDateTime('mm',selbT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selbT713.FieldByName('DECORRENZA_FINE').AsDateTime),Decorrenze) = 0 then
      Decorrenze:=IfThen(Decorrenze <> '',Decorrenze + Chr(10),Decorrenze) + FormatDateTime('mm',selbT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selbT713.FieldByName('DECORRENZA_FINE').AsDateTime);
    selbT713.Next;
  end;
  if not DecorrenzaUnica
  or (    (selT713.State in [dsInsert])
      and (selbT713.RecordCount > 0)
      and (   (IniOld <> selT713.FieldByName('DECORRENZA').AsDateTime)
           or (FinOld <> selT713.FieldByName('DECORRENZA_FINE').AsDateTime))) then
    raise exception.create(Format(A000MSG_A064_ERR_FMT_PERIODI_INTERSECANTI,[Decorrenze]))
  else if (selbT713.RecordCount > 1)
      and (   (IniOld <> selT713.FieldByName('DECORRENZA').AsDateTime)
           or (FinOld <> selT713.FieldByName('DECORRENZA_FINE').AsDateTime)) then
  begin
    if Assigned(evtRichiesta) then
      evtRichiesta(Format(A000MSG_A064_DLG_FMT_AGG_PERIODO_2,[Decorrenze]),'PeriodiDiversiTipiGruppo'); //Se l'operatore decide di proseguire, viene richiamata AllineaDecorrenze
  end
  else if not AggiornaPeriodo
      and (selT713.State in [dsEdit])
      and (   (selT713.FieldByName('DECORRENZA').AsDateTime <> DecIniOld)
           or (selT713.FieldByName('DECORRENZA_FINE').AsDateTime <> DecFinOld)) then
    if Assigned(evtRichiesta) then
      evtRichiesta(A000MSG_A064_DLG_FMT_AGG_PERIODO_3,'PeriodoModificato');
  if Assigned(evtAumentaProgressBar) then
    evtAumentaProgressBar;//prima dell'inherited
end;

procedure TA064FBudgetStraordinarioMW.selT713BeforePostNoStoricoSalvaDopo;
var A063MW:TA063FBudgetGenerazioneMW;
begin
  if Assigned(evtAumentaProgressBar) then
    evtAumentaProgressBar;//dopo l'inherited
  //Aggiorno la decorrenza del dettaglio mensile
  if AggiornaPeriodo then
  begin
    updT714.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    updT714.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
    updT714.SetVariable('DEC_NEW',selT713.FieldByName('DECORRENZA').AsDateTime);
    updT714.SetVariable('DEC_OLD',selT713.FieldByName('DECORRENZA').medpOldValue);
    updT714.Execute;
  end;
  if Assigned(evtAumentaProgressBar) then
    evtAumentaProgressBar;
  //Ricalcolo il dettaglio mensile di tutto il gruppo a parità di decorrenza
  if AggiornaPeriodo or AggiornaFA then
  begin
    seldT713.Close;
    seldT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    seldT713.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
    seldT713.Open;
    A063MW:=TA063FBudgetGenerazioneMW.Create(nil);
    while not seldT713.Eof do
    begin
      if AggiornaPeriodo then
        A063MW.CalcoloBudgetMensile(seldT713.FieldByName('CODGRUPPO').AsString,
                                    seldT713.FieldByName('TIPO').AsString,
                                    seldT713.FieldByName('DECORRENZA').AsDateTime,
                                    seldT713.FieldByName('DECORRENZA_FINE').AsDateTime,
                                    seldT713.FieldByName('DECORRENZA_FINE').AsDateTime,
                                    seldT713.FieldByName('ORE').AsString,
                                    seldT713.FieldByName('IMPORTO').AsFloat,
                                    True,
                                    True);
      updaT714.SetVariable('CODGRUPPO',seldT713.FieldByName('CODGRUPPO').AsString);
      updaT714.SetVariable('TIPO',seldT713.FieldByName('TIPO').AsString);
      updaT714.SetVariable('DECORRENZA',seldT713.FieldByName('DECORRENZA').AsDateTime);
      updaT714.Execute;
      seldT713.Next;
    end;
    FreeAndNil(A063MW);
  end;
  //Ricalcolo il dettaglio mensile del budget corrente
  if (selT713.State in [dsInsert]) or AggiornaPeriodo or AggiornaOre or AggiornaImp then
  begin
    A063MW:=TA063FBudgetGenerazioneMW.Create(nil);
    A063MW.CalcoloBudgetMensile(selT713.FieldByName('CODGRUPPO').AsString,
                                selT713.FieldByName('TIPO').AsString,
                                selT713.FieldByName('DECORRENZA').AsDateTime,
                                selT713.FieldByName('DECORRENZA_FINE').AsDateTime,
                                selT713.FieldByName('DECORRENZA_FINE').AsDateTime,
                                selT713.FieldByName('ORE').AsString,
                                selT713.FieldByName('IMPORTO').AsFloat,
                                (selT713.State in [dsInsert]) or AggiornaPeriodo or AggiornaOre,
                                (selT713.State in [dsInsert]) or AggiornaPeriodo or AggiornaImp);
    FreeAndNil(A063MW);
  end;
  if AggiornaPeriodo or AggiornaFA then
  begin
    updaT714.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    updaT714.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
    updaT714.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
    updaT714.Execute;
  end;
  if Assigned(evtAumentaProgressBar) then
    evtAumentaProgressBar;
  //Aggiorno il filtro anagrafe su tutto il gruppo a parità di decorrenza
  if AggiornaFA then
  begin
    updaT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    updaT713.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
    updaT713.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
    updaT713.SetVariable('FILTRO_ANAGRAFE',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
    updaT713.Execute;
  end;
  if Assigned(evtAumentaProgressBar) then
    evtAumentaProgressBar;
end;

procedure TA064FBudgetStraordinarioMW.selT713BeforePostNoStoricoFine;
var i:Integer;
begin
  if Trim(Parametri.Inibizioni.Text) <> '' then
  begin
    if selT713.State in [dsInsert] then
      lstListaGruppi.Add(Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').AsString, selT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime), selT713.FieldByName('DESCRIZIONE').AsString]))
    else if selT713.State in [dsEdit] then
      for i:=0 to lstListaGruppi.Count - 1 do
        if AbilitatoOld = lstListaGruppi[i] then
        begin
          lstListaGruppi[i]:=IfThen(FiltroOkBP,Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').AsString, selT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime), selT713.FieldByName('DESCRIZIONE').AsString]),'');
          Break;
        end;
  end;
  wAnno:=selT713.FieldByName('ANNO').AsInteger;
end;

procedure TA064FBudgetStraordinarioMW.CaricaAggiornamenti;
begin
  //Se l'operatore decide di proseguire, imposto le variabili per gli aggiornamenti
  if ChiediAggiornaPeriodo then
    AggiornaPeriodo:=True;
  if ChiediAggiornaFA then
    AggiornaFA:=True;
  if ChiediAggiornaOre then
    AggiornaOre:=True;
  if ChiediAggiornaImp then
    AggiornaImp:=True;
end;

procedure TA064FBudgetStraordinarioMW.AllineaDecorrenze;
begin
  updT713.SetVariable('DEC_INI_NEW',selT713.FieldByName('DECORRENZA').AsDateTime);
  updT713.SetVariable('DEC_FIN_NEW',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
  updT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
  updT713.SetVariable('DEC_OLD',IniOld);
  updT713.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
  updT713.Execute;
end;

procedure TA064FBudgetStraordinarioMW.selT713AfterPost;
var msg:String;
begin
  AperturaDettaglio;
  if (StatoSelT713 = 'I') or AggiornaPeriodo or AggiornaFA then
  begin
    if AggiornaPeriodo or AggiornaFA then
      msg:=Format(A000MSG_A064_MSG_FMT_FRUITO_AZZERATO,[selT713.FieldByName('CODGRUPPO').AsString,FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime),FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime)]);
    msg:=msg + IfThen(msg <> '',CRLF + CRLF) + A000MSG_A064_DLG_CONTROLLO_FA;
    if Assigned(evtRichiesta) then
      evtRichiesta(msg,'RichiamoA063');
  end;
end;

procedure TA064FBudgetStraordinarioMW.selT713BeforeDelete;
var i:Integer;
begin
  delT714.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
  delT714.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
  delT714.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
  delT714.Execute;
  wAnno:=selT713.FieldByName('ANNO').AsInteger;
  AbilitatoOld:=Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').medpOldValue, selT713.FieldByName('TIPO').medpOldValue, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').medpOldValue) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').medpOldValue), selT713.FieldByName('DESCRIZIONE').medpOldValue]);
  for i:=0 to lstListaGruppi.Count - 1 do
    if AbilitatoOld = lstListaGruppi[i] then
    begin
      lstListaGruppi[i]:='';
      Break;
    end;
end;

procedure TA064FBudgetStraordinarioMW.selT713AfterDelete;
begin
  AperturaDettaglio;
end;

procedure TA064FBudgetStraordinarioMW.selT713AfterScroll;
begin
  AperturaDettaglio;
end;

procedure TA064FBudgetStraordinarioMW.selT713NewRecord(sAnno:String);
begin
  if sAnno = '' then
    selT713.FieldByName('ANNO').AsInteger:=R180Anno(Parametri.DataLavoro)
  else
    selT713.FieldByName('ANNO').AsInteger:=StrToInt(sAnno);
  selT713.FieldByName('DECORRENZA').AsDateTime:=EncodeDate(selT713.FieldByName('ANNO').AsInteger,1,1);
  selT713.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(selT713.FieldByName('ANNO').AsInteger,12,31);
  selT713.FieldByName('ORE').AsString:='00.00';
  selT713.FieldByName('IMPORTO').AsFloat:=0;
end;

procedure TA064FBudgetStraordinarioMW.selT275BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  R180SetReadBuffer(TOracleDataSet(DataSet));
end;

procedure TA064FBudgetStraordinarioMW.selT713AfterCancel;
begin
  AperturaDettaglio;
end;

procedure TA064FBudgetStraordinarioMW.selT713FilterRecord(var Accept: Boolean);
var i: Integer;
begin
  if Trim(Parametri.Inibizioni.Text) <> '' then
  begin
    Accept:=False;
    for i:=0 to lstListaGruppi.Count - 1 do
      if Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').AsString, selT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime), selT713.FieldByName('DESCRIZIONE').AsString]) = lstListaGruppi[i] then
      begin
        Accept:=True;
        Break;
      end;
  end;
end;

procedure TA064FBudgetStraordinarioMW.selT713CODGRUPPOValidate;
var i:Integer;
  Assegna:Boolean;
begin
  inherited;
  if selT713.State in [dsInsert] then
  begin
    Assegna:=False;
    selbT713.Close;
    selbT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    selbT713.SetVariable('DEC_INI',selT713.FieldByName('DECORRENZA').AsDateTime);
    selbT713.SetVariable('DEC_FIN',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
    selbT713.SetVariable('ID_RIGA','ROWIDROWIDROWIDROW');
    selbT713.Open;
    if not selbT713.Eof and (selbT713.FieldByName('FILTRO_ANAGRAFE').AsString <> '') then
    begin
      if Trim(Parametri.Inibizioni.Text) <> '' then
      begin
        for i:=0 to lstListaGruppi.Count - 1 do
          if Trim(Copy(lstListaGruppi[i],1,10)) = selT713.FieldByName('CODGRUPPO').AsString then
          begin
            Assegna:=True;
            Break;
          end;
      end
      else
        Assegna:=True;
      if Assegna then
        selT713.FieldByName('FILTRO_ANAGRAFE').AsString:=selbT713.FieldByName('FILTRO_ANAGRAFE').AsString;
    end;
  end;
end;

procedure TA064FBudgetStraordinarioMW.selT713DECORRENZAValidate;
begin
  if selT713.State in [dsInsert] then
    DecIniOld:=selT713.FieldByName('DECORRENZA').AsDateTime;
end;

procedure TA064FBudgetStraordinarioMW.selT713DECORRENZA_FINEValidate;
begin
  if selT713.State in [dsInsert] then
    DecFinOld:=selT713.FieldByName('DECORRENZA_FINE').AsDateTime;
end;

procedure TA064FBudgetStraordinarioMW.selT714BeforeInsert;
begin
  abort;
end;

function TA064FBudgetStraordinarioMW.selT713FILTRO_ANAGRAFEValidate: Boolean;
begin
  Result:=Trim(selT713.FieldByName('FILTRO_ANAGRAFE').AsString) <> '';
end;

procedure TA064FBudgetStraordinarioMW.selT714BeforeDelete;
begin
  abort;
end;

procedure TA064FBudgetStraordinarioMW.selT714BeforePost;
begin
  VariazioneOre:=R180OreMinutiExt(selT714.FieldByName('ORE').AsString) <> ArrMesi[selT714.FieldByName('MESE').AsInteger].Minuti;
  VariazioneImp:=selT714.FieldByName('IMPORTO').AsFloat <> ArrMesi[selT714.FieldByName('MESE').AsInteger].Importo;
  selT714.FieldByName('ORE').AsString:=Trim(selT714.FieldByName('ORE').AsString);
  (*if VariazioneOre and (R180OreMinutiExt(selT714.FieldByName('ORE').AsString) < R180OreMinutiExt(selT714.FieldByName('ORE_FRUITO').AsString)) then
    raise exception.create('Non è possibile indicare un valore inferiore alle ore già fruite!');
  if VariazioneImp and (selT714.FieldByName('IMPORTO').AsFloat < selT714.FieldByName('IMPORTO_FRUITO').AsFloat) then
    raise exception.create('Non è possibile indicare un valore inferiore all''importo già fruito!');*)
end;

procedure TA064FBudgetStraordinarioMW.selT714AfterPost;
var
  Mese,i:Integer;
  MinDiff,MinInPiu,MinTot,MinTotPrec,MinTotFruitoSucc:Integer;
  ImpDiff,ImpInPiu,ImpTot,ImpTotPrec,ImpTotFruitoSucc:Real;
  BM:TBookMark;
begin
  A064MWMsg:='';
  with selT714 do
    try
      BM:=GetBookMark;
      Mese:=FieldByName('MESE').AsInteger;
      //Prelevo i valori totali e le differenze
      MinTot:=0;
      MinTotPrec:=0;
      MinTotFruitoSucc:=0;
      ImpTot:=0;
      ImpTotPrec:=0;
      ImpTotFruitoSucc:=0;
      if FieldByName('TIPO').AsString = '#ECC#' then
      begin
        First;
        while not Eof do
        begin
          MinTotFruito:=0;
          ImpTotFruito:=0;
          for i:=1 to FieldByName('MESE').AsInteger - 1 do
          begin
            if ArrMesi[i].MinFruito <> 0 then
              MinTotFruito:=ArrMesi[i].MinFruito;
            if ArrMesi[i].ImpFruito <> 0 then
              ImpTotFruito:=ArrMesi[i].ImpFruito;
          end;
          Edit;
          if VariazioneOre then
            if R180OreMinutiExt(FieldByName('ORE').AsString) > (R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - MinTotFruito) then
              FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - MinTotFruito);
          if VariazioneImp then
            if FieldByName('IMPORTO').AsFloat > (selT713.FieldByName('IMPORTO').AsFloat - ImpTotFruito) then
              FieldByName('IMPORTO').AsFloat:=selT713.FieldByName('IMPORTO').AsFloat - ImpTotFruito;
          Post;
          Next;
        end;
        if (VariazioneOre and (R180OreMinutiExt(FieldByName('ORE').AsString) < 0))
        or (VariazioneImp and (FieldByName('IMPORTO').AsFloat < 0)) then
          A064MWMsg:=A000MSG_A064_MSG_DISPONIBILITA_NEGATIVA;
      end
      else
      begin
        First;
        while not Eof do
        begin
          MinTot:=MinTot + R180OreMinutiExt(FieldByName('ORE').AsString);
          ImpTot:=ImpTot + FieldByName('IMPORTO').AsFloat;
          if FieldByName('MESE').AsInteger < Mese then
          begin
            MinTotPrec:=MinTotPrec + R180OreMinutiExt(FieldByName('ORE').AsString);
            ImpTotPrec:=ImpTotPrec + FieldByName('IMPORTO').AsFloat;
          end;
          if FieldByName('MESE').AsInteger > Mese then
          begin
            MinTotFruitoSucc:=MinTotFruitoSucc + R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString);
            ImpTotFruitoSucc:=ImpTotFruitoSucc + FieldByName('IMPORTO_FRUITO').AsFloat;
          end;
          Next;
        end;
        if VariazioneOre then
        begin
          GoToBookMark(BM);
          if R180OreMinutiExt(FieldByName('ORE').AsString) >= (Max(R180OreMinutiExt(selT713.FieldByName('ORE').AsString),MinTotFruito) - MinTotPrec - MinTotFruitoSucc) then
          begin
            Edit;
            MinTot:=MinTot + R180OreMinutiExt(FieldByName('ORE').AsString);
            FieldByName('ORE').AsString:=R180MinutiOre(Max(R180OreMinutiExt(selT713.FieldByName('ORE').AsString),MinTotFruito) - MinTotPrec - MinTotFruitoSucc);
            MinTot:=MinTot - R180OreMinutiExt(FieldByName('ORE').AsString);
            Post;
          end;
          MinDiff:=MinTot - Max(R180OreMinutiExt(selT713.FieldByName('ORE').AsString),MinTotFruito);
          //Incremento le ore sull'ultimo record, se negative
          if MinDiff < 0 then
          begin
            Last;
            if R180OreMinutiExt(FieldByName('ORE').AsString) < 0 then
            begin
              Edit;
              FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('ORE').AsString) - MinDiff);
              Post;
              if R180OreMinutiExt(FieldByName('ORE').AsString) < 0 then
                MinDiff:=0
              else
                MinDiff:=R180OreMinutiExt(FieldByName('ORE').AsString);
            end;
          end;
          //Giro per ricalcolo ore
          GoToBookMark(BM);
          if not Eof then
            Next;
          while not Eof and (MinDiff <> 0) do
          begin
            MinInPiu:=R180OreMinutiExt(FieldByName('ORE').AsString) - R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString);
            Edit;
            if (MinInPiu - MinDiff) < 0 then
            begin
              FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('ORE').AsString) - MinInPiu);
              MinDiff:=MinDiff - MinInPiu;
            end
            else
            begin
              FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('ORE').AsString) - MinDiff);
              MinDiff:=0;
            end;
            if R180OreMinutiExt(FieldByName('ORE').AsString) < 0 then
            begin
              MinDiff:=MinDiff - R180OreMinutiExt(FieldByName('ORE').AsString);
              FieldByName('ORE').AsString:='00.00';
            end;
            if R180OreMinutiExt(FieldByName('ORE').AsString) < R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString) then
            begin
              MinDiff:=MinDiff + R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString) - R180OreMinutiExt(FieldByName('ORE').AsString);
              FieldByName('ORE').AsString:=FieldByName('ORE_FRUITO').AsString;
            end;
            Post;
            Next;
          end;
        end;
        if VariazioneImp then
        begin
          GoToBookMark(BM);
          if FieldByName('IMPORTO').AsFloat >= (Max(selT713.FieldByName('IMPORTO').AsFloat,ImpTotFruito) - ImpTotPrec - ImpTotFruitoSucc) then
          begin
            Edit;
            ImpTot:=ImpTot + FieldByName('IMPORTO').AsFloat;
            FieldByName('IMPORTO').AsFloat:=Max(selT713.FieldByName('IMPORTO').AsFloat,ImpTotFruito) - ImpTotPrec - ImpTotFruitoSucc;
            ImpTot:=ImpTot - FieldByName('IMPORTO').AsFloat;
            Post;
          end;
          ImpDiff:=ImpTot - Max(selT713.FieldByName('IMPORTO').AsFloat,ImpTotFruito);
          //Incremento l'importo sull'ultimo record, se negativo
          if ImpDiff < 0 then
          begin
            Last;
            if FieldByName('IMPORTO').AsFloat < 0 then
            begin
              Edit;
              FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO').AsFloat - ImpDiff;
              Post;
              if FieldByName('IMPORTO').AsFloat < 0 then
                ImpDiff:=0
              else
                ImpDiff:=FieldByName('IMPORTO').AsFloat;
            end;
          end;
          //Giro per ricalcolo importo
          GoToBookMark(BM);
          if not Eof then
            Next;
          while not Eof and (ImpDiff <> 0) do
          begin
            ImpInPiu:=FieldByName('IMPORTO').AsFloat - FieldByName('IMPORTO_FRUITO').AsFloat;
            Edit;
            if (ImpInPiu - ImpDiff) < 0 then
            begin
              FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO').AsFloat - ImpInPiu;
              ImpDiff:=ImpDiff - ImpInPiu;
            end
            else
            begin
              FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO').AsFloat - ImpDiff;
              ImpDiff:=0;
            end;
            if FieldByName('IMPORTO').AsFloat < 0 then
            begin
              ImpDiff:=ImpDiff - FieldByName('IMPORTO').AsFloat;
              FieldByName('IMPORTO').AsFloat:=0;
            end;
            if FieldByName('IMPORTO').AsFloat < FieldByName('IMPORTO_FRUITO').AsFloat then
            begin
              ImpDiff:=ImpDiff + FieldByName('IMPORTO_FRUITO').AsFloat - FieldByName('IMPORTO').AsFloat;
              FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO_FRUITO').AsFloat;
            end;
            Post;
            Next;
          end;
        end;
        //Controllo i totali
        MinTot:=0;
        ImpTot:=0;
        First;
        while not Eof do
        begin
          MinTot:=MinTot + R180OreMinutiExt(FieldByName('ORE').AsString);
          ImpTot:=ImpTot + FieldByName('IMPORTO').AsFloat;
          Next;
        end;
        MinDiff:=MinTot - Max(R180OreMinutiExt(selT713.FieldByName('ORE').AsString),MinTotFruito);
        ImpDiff:=ImpTot - selT713.FieldByName('IMPORTO').AsFloat;
        Edit;
        if VariazioneOre and (MinDiff <> 0) then
          FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('ORE').AsString) - MinDiff);
        if VariazioneImp and (ImpDiff <> 0) then
          FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO').AsFloat - ImpDiff;
        Post;
        if (VariazioneOre and (R180OreMinutiExt(FieldByName('ORE').AsString) < 0))
        or (VariazioneImp and (FieldByName('IMPORTO').AsFloat < 0)) then
          A064MWMsg:=A000MSG_A064_MSG_DISPONIBILITA_NEGATIVA;
      end;
    finally
      CaricamentoMesi;
      GoToBookMark(BM);
      FreeBookMark(BM);
    end;
end;

procedure TA064FBudgetStraordinarioMW.selT714CalcFields;
var OreMese: String;
  ImpMese: Real;
  RigaMese: Integer;
begin
  if selT714.RecordCount > 0 then
  begin
    RigaMese:=selT714.FieldByName('MESE').AsInteger - R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime) + 1;
    OreMese:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) div selT714.RecordCount);
    ImpMese:=R180Arrotonda(selT713.FieldByName('IMPORTO').AsFloat / selT714.RecordCount,0.01,'P');
    if RigaMese = selT714.RecordCount then
    begin
      if selT714.FieldByName('TIPO').AsString = '#ECC#' then
      begin
        OreMese:=selT713.FieldByName('ORE').AsString;
        ImpMese:=selT713.FieldByName('IMPORTO').AsFloat;
      end
      else
      begin
        OreMese:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - (R180OreMinutiExt(OreMese) * (selT714.RecordCount - 1)));
        ImpMese:=selT713.FieldByName('IMPORTO').AsFloat - (ImpMese * (selT714.RecordCount - 1));
      end;
    end
    else if selT714.FieldByName('TIPO').AsString = '#ECC#' then
    begin
      OreMese:=R180MinutiOre(R180OreMinutiExt(OreMese) * RigaMese);
      ImpMese:=ImpMese * RigaMese;
    end;
    selT714.FieldByName('ORE_AUTO').AsString:=OreMese;
    selT714.FieldByName('ORE_RESIDUO_AUTO').AsString:=R180MinutiOre(R180OreMinutiExt(selT714.FieldByName('ORE_AUTO').AsString) - R180OreMinutiExt(selT714.FieldByName('ORE_FRUITO').AsString));
    selT714.FieldByName('ORE_RESIDUO').AsString:=R180MinutiOre(R180OreMinutiExt(selT714.FieldByName('ORE').AsString) - R180OreMinutiExt(selT714.FieldByName('ORE_FRUITO').AsString));
    selT714.FieldByName('IMPORTO_AUTO').AsFloat:=ImpMese;
    selT714.FieldByName('IMPORTO_RESIDUO_AUTO').AsFloat:=selT714.FieldByName('IMPORTO_AUTO').AsFloat - selT714.FieldByName('IMPORTO_FRUITO').AsFloat;
    selT714.FieldByName('IMPORTO_RESIDUO').AsFloat:=selT714.FieldByName('IMPORTO').AsFloat - selT714.FieldByName('IMPORTO_FRUITO').AsFloat;
  end;
end;

procedure TA064FBudgetStraordinarioMW.selT714OREValidate(Sender: TField);
{Controllo che i minuti siano minori di 60}
var Minuti,Posiz:Byte;
begin
  if Sender.IsNull then
    exit;
  if Pos(' ',Trim(Sender.AsString)) > 1 then
    raise Exception.Create(A000MSG_ERR_DATO_NON_VALIDO);
  Posiz:=Pos('.',Sender.AsString);
  if Posiz = 0 then
    Posiz:=Pos(':',Sender.AsString);
  if Posiz = 0 then
    exit;
  Minuti:=StrToInt(IfThen(Trim(Copy(Sender.AsString,Posiz + 1,2))='', '0' ,Trim(Copy(Sender.AsString,Posiz + 1,2))));
  if Minuti > 59 then
    raise Exception.Create(A000MSG_ERR_MINUTI);
end;

procedure TA064FBudgetStraordinarioMW.PulisciVariabili;
begin
  if Assigned(evtClearKeys) then
    evtClearKeys;
end;

procedure TA064FBudgetStraordinarioMW.PutResponsabileAutorizzatore(const Value: Boolean);
begin
  FResponsabileAutorizzatore := Value;
  if Value then
  begin
    selT715.Filter:='AUTORIZZATORE = ''S''';
    selOperatori.Filter:='TAG = 460';
  end
  else
  begin
    selT715.Filter:='AUTORIZZATORE = ''N''';
    selOperatori.Filter:='TAG = 461';
  end;
  selT715.Filtered:=True;
  selOperatori.Filtered:=True;
end;

end.
