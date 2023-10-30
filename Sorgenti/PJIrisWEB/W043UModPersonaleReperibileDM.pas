unit W043UModPersonaleReperibileDM;

interface

uses
  System.SysUtils, System.Classes, Oracle, OracleData, Data.DB, System.Variants,
  Datasnap.DBClient, System.StrUtils, A000UInterfaccia, A000USessione, A000UCostanti,
  C180FunzioniGenerali, QueryStorico;

type
  TW043ParametriFiltro = record
    DataPianificazione:TDateTime;
    DatoLibero1,ValoreDatoLibero1:String;
    DatoLibero2,ValoreDatoLibero2:String;
    ValoreDatoAreaSquadra:String;
    FiltroDip:String; // Filtro anagrafe
  end;

  TW043Pianificazione = record
    Progressivo: Integer;
    DataPianif: TDateTime;
    Turno1,Turno2,Turno3:String;
  end;

  TW043Spostamenti = record
    ProgDip1: Integer;
    DataPianif: TDateTime;
    CodiceTurno:String;
    Recapito:String;
  end;

  W043Spostamenti = array of TW043Spostamenti;

  TW043FModPersonaleReperibileDM = class(TDataModule)
    selT380: TOracleDataSet;
    cdsTurniDip1: TClientDataSet;
    dsrTurniDip1: TDataSource;
    dsrTurniDip2: TDataSource;
    cdsTurniDip1DATA: TDateField;
    cdsTurniDip1RECAPITO_EXTRA: TStringField;
    cdsTurniDip1D_MODIFICA_RECAPITO: TStringField;
    cdsTurniDip1ID: TIntegerField;
    selAnagrafeDipRep: TOracleDataSet;
    cdsTurniDip1D_TURNO: TStringField;
    cdsTurniDip2: TClientDataSet;
    IntegerField1: TIntegerField;
    DateField1: TDateField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    cdsTurniDip2TURNO: TStringField;
    cdsTurniDip1TURNO: TStringField;
    cdsTurniDip1SIGLA: TStringField;
    cdsTurniDip2SIGLA: TStringField;
    selT350: TOracleDataSet;
    selT385: TOracleDataSet;
    selT380TurniIntersecati: TOracleDataSet;
    selT380RowId: TOracleDataSet;
    cdsTurniDip1NUMERO_TURNO: TIntegerField;
    cdsTurniDip2NUMERO_TURNO: TIntegerField;
    cdsTurniDip1PROGRESSIVO: TIntegerField;
    cdsTurniDip2PROGRESSIVO: TIntegerField;
    // Questo DM ha un selDatoLibero proprio per evitare di doverlo ripreparare ad ogni
    // cambio del turno - così viene impostato una sola volta.
    selDatoLibero: TOracleDataSet;
    cdsTurniDip1DATOAGG1: TStringField;
    cdsTurniDip1DATOAGG2: TStringField;
    cdsTurniDip2DATOAGG1: TStringField;
    cdsTurniDip2DATOAGG2: TStringField;
    selT030: TOracleDataSet;
    cdsTurniDip1D_DATOAGG1: TStringField;
    cdsTurniDip1D_DATOAGG2: TStringField;
    cdsTurniDip2D_DATOAGG1: TStringField;
    cdsTurniDip2D_DATOAGG2: TStringField;
    selSQLDatoAgg1: TOracleDataSet;
    selSQLDatoAgg2: TOracleDataSet;
    cdsTurniDip1PRIORITA: TStringField;
    cdsTurniDip2PRIORITA: TStringField;
    selT650Lookup: TOracleDataSet;
    selT651: TOracleDataSet;
    selT030DatoLibero: TOracleDataSet;
    selT430Recapito: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    ArrSpostamenti: W043Spostamenti;
    //FDatoLibero1,FValoreDatoLibero1:String;
    //FDatoLibero2,FValoreDatoLibero2:String; // Per il filtro sui dati liberi
    CodiceFormOwner:String;
    procedure LeggiPianificazione(Progressivo:Integer;
                                  DataPianif:TDateTime;
                                  ResClientDataSet:TClientDataSet);

  public
    UsaEMailDatoLibero,UsaTelefonoDatoLibero:Boolean;
    DatoLiberoStorico:Boolean;
    AccessoDaDipendente:Boolean;
    QSDatiDip:TQueryStorico;
    function GetDipendentiReperibili(ParametriFiltro:TW043ParametriFiltro):TStringList;
    procedure ApriSelT380(Progressivo:Integer; DataPianif:TDateTime);
    procedure ApriSelT380RowId(Progressivo:Integer; DataPianif:TDateTime);
    procedure LeggiPianificazioneDip1(Progressivo:Integer;
                                      DataPianif:TDateTime);
    procedure LeggiPianificazioneDip2(Progressivo:Integer;
                                      DataPianif:TDateTime);
    // Controlli validità
    function CheckSlotTurniLiberi:Boolean;
    function CheckEsisteCodiceTurno(CodiceTurno:String):Boolean;
    function CheckDatoBloccato(Progressivo:Integer;DataPianif:TDateTime):String;
    function CheckVincoliIndividuali(Progressivo:Integer;DataPianif:TDateTime;CodiceTurno:String):String;
    function CheckOrarioCutOff(DataPianif:TDateTime;CodiceTurno:String):String;
    function CheckTurnoFinito(DataPianif:TDateTime;CodiceTurno:String):String;
    function CheckIntersezioneTurni(Progressivo:Integer; DataPianif:TDateTime; CodiceTurno:String):String;
    // Modifica pianificazione esistente
    procedure AggiungiPianificazioneTurno(Progressivo:Integer;DataPianif:TDateTime;CodiceTurno,Priorita,Recapito,DatoAgg1,DatoAgg2:String);
    procedure RimuoviPianificazioneTurno(Progressivo:Integer;DataPianif:TDateTime;CodiceTurno:String);
    procedure AddSpostamento(ProgDip1:Integer;DataPianif:TDateTime;CodiceTurno,Recapito:String);
    procedure RemSpostamento(ProgDip1:Integer;DataPianif:TDateTime;CodiceTurno:String);
    function GetListaProgDipSpostamento(DataPianif:TDateTime):String;
    function GetProgDipSpostamento(CodiceTurno:String;DataPianif:TDateTime):Integer;
    function GetNomeDipSpostamento(ProgDip1:Integer):String;
    function GetRecapitoDipSpostamento(ProgDip1:Integer;CodiceTurno:String;DataPianif:TDateTime):String;
    function GetRecapitoProposto(ProgDip:Integer;Campo:String;DataPianif:TDateTime):String;
    // Modifica recapito alternativo
    procedure ModificaRecapitoExtra(Progressivo:Integer;DataPianif:TDateTime;NumeroTurno:Integer;NuovoRecapitoExtra:String);
    // Per invio mail
    procedure ImpostaODSDatoLibero;
    procedure CreaStringheMessaggio(ProgDipDa:Integer;ProgDipA:Integer;DataPianif:TDateTime;CodiceTurno:String;
                                    var Oggetto:String;var Corpo:String);
    function  GetEMailDatoLibero(Progressivo:Integer;DataPianif:TDateTime):String;
    function SalvaEMailsAvviso(ProgDipDa,ProgDipA:Integer;DataPianif:TDateTime;CodiceTurno:String):String;
    procedure GetAreeAfferenza(Area:String);

  end;

implementation

{$R *.dfm}

uses WR010UBase;

procedure TW043FModPersonaleReperibileDM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  CodiceFormOwner:=(Owner as TWR010FBase).medpCodiceForm;
  UsaEMailDatoLibero:=False;
  UsaTelefonoDatoLibero:=False;
  AccessoDaDipendente:=Parametri.InibizioneIndividuale;
  SetLength(ArrSpostamenti,0);

  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  if AccessoDaDipendente then
  begin
    QSDatiDip:=TQueryStorico.Create(nil);
    QSDatiDip.Session:=SessioneOracle;
    A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1,selSQLDatoAgg1);
    A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2,selSQLDatoAgg2);
  end;
  selAnagrafeDipRep.SetVariable('QVISTAORACLE',QVistaOracle);
  selT350.Open;
  // apro tabella associazione squadre - aree
  selT651.Open;
  selT650Lookup.Open;

  ImpostaODSDatoLibero;

  cdsTurniDip1.CreateDataSet;
  cdsTurniDip2.CreateDataSet;
end;

procedure TW043FModPersonaleReperibileDM.DataModuleDestroy(Sender: TObject);
begin
  if AccessoDaDipendente then
    FreeAndNil(QSDatiDip);
  selAnagrafeDipRep.Close;
  selT380.Close;
  selT350.Close;
end;

function TW043FModPersonaleReperibileDM.GetDipendentiReperibili(ParametriFiltro:TW043ParametriFiltro):TStringList;
var
  ListaDipendenti:TStringList;
  Nome,Valore:String;
begin

  selAnagrafeDipRep.Close;
  selAnagrafeDipRep.SetVariable('FILTRODIP',ParametriFiltro.FiltroDip);
  selAnagrafeDipRep.SetVariable('DATALAVORO',ParametriFiltro.DataPianificazione);
  selAnagrafeDipRep.SetVariable('FILTRO_DATO1',null);
  selAnagrafeDipRep.SetVariable('FILTRO_DATO2',null);
  selAnagrafeDipRep.SetVariable('FILTRO_AREASQUADRA',null);

  // Filtro sui dati liberi
  if (ParametriFiltro.DatoLibero1 <> '') and (ParametriFiltro.ValoreDatoLibero1 <> '') then
  begin
    selAnagrafeDipRep.SetVariable('FILTRO_DATO1',Format('and %s=''%s''',[ParametriFiltro.DatoLibero1,ParametriFiltro.ValoreDatoLibero1]));
  end;
  if (ParametriFiltro.DatoLibero2 <> '') and (ParametriFiltro.ValoreDatoLibero2 <> '') then
  begin
    selAnagrafeDipRep.SetVariable('FILTRO_DATO2',Format('and %s=''%s''',[ParametriFiltro.DatoLibero2,ParametriFiltro.ValoreDatoLibero2]));
  end;
  // filtro su area squadra selezionata
  if (selT651.RecordCount > 0) and (ParametriFiltro.ValoreDatoAreaSquadra <> '') then
  begin
    selAnagrafeDipRep.SetVariable('FILTRO_AREASQUADRA',Format('and T651F_ESISTESQUADRA(T430SQUADRA, T430TIPOOPE, ''%s'') = ''S''',[ParametriFiltro.ValoreDatoAreaSquadra]));
  end;

  selAnagrafeDipRep.Open;

  ListaDipendenti:=TStringList.Create;
  ListaDipendenti.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  try
    while not selAnagrafeDipRep.Eof do
    begin
      Nome:=Format('%-8s %s %s',
                   [selAnagrafeDipRep.FieldByName('MATRICOLA').AsString,
                    selAnagrafeDipRep.FieldByName('COGNOME').AsString,
                    selAnagrafeDipRep.FieldByName('NOME').AsString]);
      Valore:=selAnagrafeDipRep.FieldByName('PROGRESSIVO').AsString;
      ListaDipendenti.AddPair(Nome,Valore);
      selAnagrafeDipRep.Next;
    end;
    Result:=ListaDipendenti;
  except
    on E:Exception do
    begin
      Result:=nil;
      FreeAndNil(ListaDipendenti);
      raise Exception.Create(E.Message);
    end;
  end;
  // selAnagrafeDipRep resta aperto con queste variabili
  // fino alla prossima lettura (cambio data pianificazione o filtri)
end;

procedure TW043FModPersonaleReperibileDM.GetAreeAfferenza(Area: String);
var FiltroArea:String;
begin
  //Filtro DataSet con Aree previste per Squadra / Operatore
  FiltroArea:='(AREASQUADRA_T1 = ''' + Area + ''')';
  FiltroArea:=FiltroArea + ' OR (AREASQUADRA_T2 = ''' + Area + ''')';
  FiltroArea:=FiltroArea + ' OR (AREASQUADRA_T3 = ''' + Area + ''')';
  selAnagrafeDipRep.Filtered:=False;
  selAnagrafeDipRep.Filter:=FiltroArea;
  selAnagrafeDipRep.Filtered:=True;
end;

procedure TW043FModPersonaleReperibileDM.ApriSelT380(Progressivo:Integer; DataPianif:TDateTime);
begin
  selT380.Close;
  selT380.ClearVariables;
  selT380.SetVariable('DATA_PIANIFICAZIONE',DataPianif);
  selT380.SetVariable('PROGRESSIVO',Progressivo);
  selT380.Open;
end;

procedure TW043FModPersonaleReperibileDM.ApriSelT380RowId(Progressivo:Integer; DataPianif:TDateTime);
begin
  selT380RowId.Close;
  selT380RowId.ClearVariables;
  selT380RowId.SetVariable('DATA_PIANIFICAZIONE',DataPianif);
  selT380RowId.SetVariable('PROGRESSIVO',Progressivo);
  selT380RowId.Open;
end;

procedure TW043FModPersonaleReperibileDM.LeggiPianificazioneDip1(Progressivo:Integer;
                                                                 DataPianif:TDateTime);
begin
  LeggiPianificazione(Progressivo,DataPianif,cdsTurniDip1);
end;

procedure TW043FModPersonaleReperibileDM.LeggiPianificazioneDip2(Progressivo:Integer;
                                                                 DataPianif:TDateTime);
begin
  LeggiPianificazione(Progressivo,DataPianif,cdsTurniDip2);
end;


procedure TW043FModPersonaleReperibileDM.LeggiPianificazione(Progressivo:Integer;
                                                             DataPianif:TDateTime;
                                                             ResClientDataSet:TClientDataSet);
var
  i,IdRiga:Integer;
  Codice,Sigla,IdentTurno,DescTurno:String;
begin
  ResClientDataSet.EmptyDataSet;
  ApriSelT380(Progressivo,DataPianif);
  try
    IdRiga:=0;
    while not selT380.Eof do
    begin
      for i:=1 to 3 do
      begin
        if selT380.FieldByName('TURNO' + IntToStr(i)).AsString <> '' then
        begin
          ResClientDataSet.Insert;
          ResClientDataSet.FieldByName('ID').AsInteger:=IdRiga;
          ResClientDataSet.FieldByName('PROGRESSIVO').AsInteger:=selT380.FieldByName('PROGRESSIVO').AsInteger;
          ResClientDataSet.FieldByName('NUMERO_TURNO').AsInteger:=i;
          ResClientDataSet.FieldByName('TURNO').AsString:=selT380.FieldByName('TURNO' + IntToStr(i)).AsString;
          ResClientDataSet.FieldByName('SIGLA').AsString:=selT380.FieldByName('SIGLA_TURNO' + IntToStr(i)).AsString;
          ResClientDataSet.FieldByName('DATA').AsDateTime:=selT380.FieldByName('DATA').AsDateTime;

          Codice:=selT380.FieldByName('TURNO' + IntToStr(i)).AsString;
          Sigla:=selT380.FieldByName('SIGLA_TURNO' + IntToStr(i)).AsString;
          IdentTurno:=IfThen(Sigla <> '',Sigla,Codice);
          // Descrizione turno: <ORA_INIZIO> - <ORA_FINE> <SIGLA/CODICE> <DESCRIZIONE>
          DescTurno:=Format('%s - %s %s %s',
                            [selT380.FieldByName('DALLE_TURNO' + IntToStr(i)).AsString,
                             selT380.FieldByName('ALLE_TURNO' + IntToStr(i)).AsString,
                             R180RPad(IdentTurno,5,' ').Replace(' ','&nbsp;'),
                             selT380.FieldByName('DESCRIZIONE_TURNO' + IntToStr(i)).AsString]);
          ResClientDataSet.FieldByName('D_TURNO').AsString:=DescTurno;
          ResClientDataSet.FieldByName('PRIORITA').AsString:=selT380.FieldByName('PRIORITA' + IntToStr(i)).AsString;
          ResClientDataSet.FieldByName('RECAPITO_EXTRA').AsString:=selT380.FieldByName('RECAPITO' + IntToStr(i)).AsString;
          ResClientDataSet.FieldByName('DATOAGG1').AsString:=selT380.FieldByName('DATOAGG1_T' + IntToStr(i)).AsString;
          if selSQLDatoAgg1.SQL.Text <> '' then
          begin
            if selSQLDatoAgg1.VariableIndex('DECORRENZA') >= 0 then
              selSQLDatoAgg1.SetVariable('DECORRENZA',selT380.FieldByName('DATA').AsDateTime);
            try
              selSQLDatoAgg1.Open;
              ResClientDataSet.FieldByName('D_DATOAGG1').AsString:=VarToStr(selSQLDatoAgg1.Lookup('CODICE',ResClientDataSet.FieldByName('DATOAGG1').AsString,'DESCRIZIONE'));
            except
            end;
          end;
          ResClientDataSet.FieldByName('DATOAGG2').AsString:=selT380.FieldByName('DATOAGG2_T' + IntToStr(i)).AsString;
          if selSQLDatoAgg2.SQL.Text <> '' then
          begin
            if selSQLDatoAgg2.VariableIndex('DECORRENZA') >= 0 then
              selSQLDatoAgg2.SetVariable('DECORRENZA',selT380.FieldByName('DATA').AsDateTime);
            try
              selSQLDatoAgg2.Open;
              ResClientDataSet.FieldByName('D_DATOAGG2').AsString:=VarToStr(selSQLDatoAgg2.Lookup('CODICE',ResClientDataSet.FieldByName('DATOAGG2').AsString,'DESCRIZIONE'));
            except
            end;
          end;
          ResClientDataSet.Post;
          Inc(IdRiga);
        end;
      end;
      selT380.Next;
    end;
  finally
    selT380.Close;
  end;
end;

{ Verifica che il dipendente indicato abbia almeno uno slot libero per il nuovo turno nella
  tabella dei turni (tipo turno: reperibilità). Questo metodo si aspetta che selT380 sia già aperto e
  popolato con la pianificazione del dipendente desiderato nella data desiderata}
function TW043FModPersonaleReperibileDM.CheckSlotTurniLiberi:Boolean;
begin
  Result:=False;
  if not selT380.Active then
    raise Exception.Create('Errore interno - selT380 chiuso!'); // TODO

  if selT380.RecordCount = 0 then
    Result:=True
  else if selT380.RecordCount = 1 then
    Result:=(selT380.FieldByName('TURNO1').AsString = '') or
            (selT380.FieldByName('TURNO2').AsString = '') or
            (selT380.FieldByName('TURNO3').AsString = '');
  // Per PK sulla T380 non può esserci più di un record
end;

{ Verifica che la turnazione con il codice specificato esista nella configurazione. }
function TW043FModPersonaleReperibileDM.CheckEsisteCodiceTurno(CodiceTurno:String):Boolean;
begin
  Result:=(VarToStr(selT350.Lookup('CODICE',CodiceTurno,'CODICE')) = CodiceTurno);
end;

{ Verifica che la tabella T380 non sia bloccata da blocco riepiloghi. Ritorna stringa vuota se il blocco
  non è presente o il messaggio di errore se è bloccata. }
function TW043FModPersonaleReperibileDM.CheckDatoBloccato(Progressivo:Integer;DataPianif:TDateTime):String;
begin
  Result:='';
  if WR000DM.selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(DataPianif),'T380') then
    Result:=WR000DM.selDatiBloccati.MessaggioLog;
end;

function TW043FModPersonaleReperibileDM.CheckVincoliIndividuali(Progressivo:Integer;
                                                                DataPianif:TDateTime;
                                                                CodiceTurno:String):String;
var
  ErrMessage,Messaggio:String;
begin
  // controllo vincoli individuali
  Result:='';
  selT385.Close;
  R180SetVariable(selT385,'PROGRESSIVO',Progressivo);
  R180SetVariable(selT385,'TIPO','R');
  R180SetVariable(selT385,'DATA',DataPianif);
  selT385.Open;
  try
    selT385.First;
    ErrMessage:='';
    Messaggio:='';
    if Trim(CodiceTurno) = '' then
      Exit; // Result resta a ''
    //Priorità: FS/PF - (1..7) - *
    //se il giorno del vincolo è FS e la data pianif. è un festivo
    if (selT385.SearchRecord('GIORNO','FS',[srFromBeginning])) and
       (selT385.FieldByName('DTFESTIVO').AsString = 'S') then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + CodiceTurno + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + CodiceTurno + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + CodiceTurno + ' non è disponibile nei vincoli di pianificazione dei giorni festivi';
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
      exit;
    end;
    //se il giorno del vincolo è PF e la data pianif. è un prefestivo
    if (selT385.SearchRecord('GIORNO','PF',[srFromBeginning])) and
       (selT385.FieldByName('DTPREFESTIVO').AsString = 'S') then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + CodiceTurno + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + CodiceTurno + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + CodiceTurno + ' non è disponibile nei vincoli di pianificazione dei giorni prefestivi';
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
      exit;
    end;
    //se il giorno del vincolo è uguale al giorno della data pianif.
    if selT385.SearchRecord('GIORNO',DayOfWeek(selT385.GetVariable('DATA') - 1),[srFromBeginning]) then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + CodiceTurno + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + CodiceTurno + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + CodiceTurno + ' non è disponibile nei vincoli di pianificazione del ' + R180NomeGiorno(StrToDate(VarToStr(selT385.GetVariable('DATA'))));
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
      exit;
    end;
    //se il giorno del vincolo è Tutti
    if selT385.SearchRecord('GIORNO','*',[srFromBeginning]) then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + CodiceTurno + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + CodiceTurno + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + CodiceTurno + ' non è disponibile nei vincoli di pianificazione generali!';
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
    end;

    Result:=ErrMessage;
  finally
    selT385.Close;
  end;
end;

function TW043FModPersonaleReperibileDM.CheckOrarioCutOff(DataPianif:TDateTime;CodiceTurno:String):String;
var DataSys,DataCutOff:TDateTime;
begin
  //Lo spostamento di turni tra dipendenti verrà impedito se l'orario attuale è uguale o successivo
  //all'orario di cut-off che si verifica nelle 24 ore precedenti all'orario di inizio del turno
  Result:='';
  if Trim(Parametri.CampiRiferimento.C29_W043_ModReperOraCutOff) = '' then
    exit;
  //Leggo le informazioni sul nuovo turno
  selT350.Locate('CODICE',CodiceTurno,[]);
  //Recupero la data di cut-off nel giorno pianificato
  DataCutOff:=StrToDateTime(FormatDateTime('dd/mm/yyyy',DataPianif) + ' ' + Parametri.CampiRiferimento.C29_W043_ModReperOraCutOff);
  //Retrocedo di un giorno la data di cut-off se l'orario di inizio turno è minore o uguale all'orario di cut-off (altrimenti non si troverebbe nelle 24 ore precedenti)
  if FormatDateTime('hh.nn',selT350.FieldByName('ORAINIZIO').AsDateTime) <= Parametri.CampiRiferimento.C29_W043_ModReperOraCutOff then
    DataCutOff:=DataCutOff - 1;
  //Verifico se in questo momento ho raggiunto (maggiore o uguale) la data di cut-off
  DataSys:=R180Sysdate(SessioneOracle);
  if DataSys >= DataCutOff then
  begin
    Result:='Il turno non è più disponibile perché è stato raggiunto l''orario limite consentito per l''operazione di scambio tramite IrisWeb! (Cut-off: ' + FormatDateTime('dd/mm/yyyy hh.nn',DataCutOff) + ')' +
            CRLF + 'Procedere con le altre modalità previste dalle direttive aziendali.';
    exit;
  end;
end;

function TW043FModPersonaleReperibileDM.CheckTurnoFinito(DataPianif:TDateTime;CodiceTurno:String):String;
var DataSys:TDateTime;
begin
  //Posso prendere il turno di un altro dipendente solo se il turno non è già finito
  Result:='';
  if not AccessoDaDipendente then
    exit;
  DataSys:=R180Sysdate(SessioneOracle);
  //Se la pianificazione avviene su un giorno futuro lo scambio è sempre possibile
  if DataPianif > Trunc(DataSys) then
    exit;
  //Assunto: La data minima per la pianificazione non può mai essere precedente a quella odierna,
  //perciò da questo punto in poi si ragiona sulla data odierna.

  //Leggo le informazioni sul nuovo turno
  selT350.Locate('CODICE',CodiceTurno,[]);
  //Se il turno finisce a mezzanotte lo scambio è sempre possibile
  if FormatDateTime('hh.nn',selT350.FieldByName('ORAFINE').AsDateTime) = '00.00' then
    exit;
  //Se il turno è a scavalco di mezzanotte non effettuare il controllo:
  //prima di mezzanotte lo scambio è sempre possibile, dopo la mezzanotte i turni del giorno prima non sono più visibili
  if selT350.FieldByName('ORAFINE').AsDateTime < selT350.FieldByName('ORAINIZIO').AsDateTime then
    exit;
  //Controllo se ho passato l'orario di fine turno
  if FormatDateTime('hh.nn',selT350.FieldByName('ORAFINE').AsDateTime) < FormatDateTime('hh.nn',DataSys) then
  begin
    Result:='Il turno non è più disponibile perché l''orario è ormai terminato!';
    exit;
  end;
end;

function TW043FModPersonaleReperibileDM.CheckIntersezioneTurni(Progressivo:Integer; DataPianif:TDateTime; CodiceTurno:String):String;
var
  OraInizio,OraFine:TDateTime;
  TurniIntersecati:String;
  CodiceSiglaTurno:String;
begin
  Result:='';
  // Leggo le informazioni sul nuovo turno
  if not selT350.Locate('CODICE',CodiceTurno,[]) then   // Ho già controllato prima, non può accadere
    raise Exception.Create('Errore interno, codice turno non trovato!');
  OraInizio:=selT350.FieldByName('ORAINIZIO').AsDateTime;
  OraFine:=selT350.FieldByName('ORAFINE').AsDateTime;
  // Eseguo la query per determinare le intersezioni
  selT380TurniIntersecati.Close;
  selT380TurniIntersecati.ClearVariables;
  selT380TurniIntersecati.SetVariable('PROGRESSIVO',Progressivo);
  selT380TurniIntersecati.SetVariable('DATA_TURNO',DataPianif);
  selT380TurniIntersecati.SetVariable('ORA_INIZIO_TURNO',OraInizio);
  selT380TurniIntersecati.SetVariable('ORA_FINE_TURNO',OraFine);
  selT380TurniIntersecati.Open;
  TurniIntersecati:='';
  try
    if selT380TurniIntersecati.RecordCount > 0 then // TODO: eventuale localizzazione?
    begin
      while not selT380TurniIntersecati.Eof do
      begin
        CodiceSiglaTurno:=IfThen(selT380TurniIntersecati.FieldByName('SIGLA_TURNO').AsString <> '',
                             selT380TurniIntersecati.FieldByName('SIGLA_TURNO').AsString,
                             selT380TurniIntersecati.FieldByName('CODICE_TURNO').AsString);
        if TurniIntersecati <> '' then
          TurniIntersecati:=TurniIntersecati + CRLF;
        TurniIntersecati:=TurniIntersecati + Format('%s: %s: %s - %s',
                                                   [IfThen(selT380TurniIntersecati.FieldByName('TIPOLOGIA').AsString = 'R','Reperibilità','Guardia'),
                                                    CodiceSiglaTurno,
                                                    R180MinutiOre(selT380TurniIntersecati.FieldByName('MINUTI_INIZIO').AsInteger),
                                                    R180MinutiOre(selT380TurniIntersecati.FieldByName('MINUTI_FINE').AsInteger)]);
        selT380TurniIntersecati.Next;
      end;
      Result:='Nella nuova pianificazione si verificano le seguenti intersezioni con il nuovo turno' + CRLF + TurniIntersecati;
    end;
  finally
    selT380TurniIntersecati.Close;
  end;
end;

procedure TW043FModPersonaleReperibileDM.AggiungiPianificazioneTurno(Progressivo:Integer;
                                                                     DataPianif:TDateTime;
                                                                     CodiceTurno,Priorita,Recapito,DatoAgg1,DatoAgg2:String);
begin
  ApriSelT380RowId(Progressivo,DataPianif);
  try
    try
      if SelT380RowId.RecordCount = 0 then
      begin
        // Non esiste nessuna pianificazione per questa giornata. La creiamo.
        SelT380RowId.Insert;
        SelT380RowId.FieldByName('DATA').AsDateTime:=DataPianif;
        SelT380RowId.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
        SelT380RowId.FieldByName('TIPOLOGIA').AsString:='R';
        SelT380RowId.FieldByName('TURNO1').AsString:=CodiceTurno;
        SelT380RowId.FieldByName('PRIORITA1').AsString:=Priorita;
        SelT380RowId.FieldByName('RECAPITO1').AsString:=Recapito;
        SelT380RowId.FieldByName('DATOAGG1_T1').AsString:=DatoAgg1;
        SelT380RowId.FieldByName('DATOAGG2_T1').AsString:=DatoAgg2;

        RegistraLog.SettaProprieta('I','T380_PIANIFREPERIB',CodiceFormOwner,SelT380RowId,True);
        RegistraLog.RegistraOperazione;

        SelT380RowId.Post;
      end
      else if SelT380RowId.RecordCount = 1 then
      begin
        SelT380RowId.Edit;
        // Può esserci 1 sola pianificazione a causa della PK. Aggiungiamo il nuovo turno.
        // Turno1 deve essere per forza già valorizzato
        if SelT380RowId.FieldByName('TURNO2').AsString <> '' then
        begin
          // Turno 2 occupato, turno 3 deve essere per forza libero se no ci sono problemi prima
          if SelT380RowId.FieldByName('TURNO3').AsString <> '' then
            // Questo non dovrebbe mai succedere a questo punto del codice.
            raise Exception.Create('Il dipendente su cui si sta cercando di spostare il turno ha già raggiunto il numero massimo di turni pianificabili'); // TODO
          // Il turno 3 è libero, aggiungo qui
          SelT380RowId.FieldByName('TURNO3').AsString:=CodiceTurno;
          SelT380RowId.FieldByName('PRIORITA3').AsString:=Priorita;
          SelT380RowId.FieldByName('RECAPITO3').AsString:=Recapito;
          SelT380RowId.FieldByName('DATOAGG1_T3').AsString:=DatoAgg1;
          SelT380RowId.FieldByName('DATOAGG2_T3').AsString:=DatoAgg2;
        end
        else  // Il turno 2 libero, aggiungo qui
        begin
          SelT380RowId.FieldByName('TURNO2').AsString:=CodiceTurno;
          SelT380RowId.FieldByName('PRIORITA2').AsString:=Priorita;
          SelT380RowId.FieldByName('RECAPITO2').AsString:=Recapito;
          SelT380RowId.FieldByName('DATOAGG1_T2').AsString:=DatoAgg1;
          SelT380RowId.FieldByName('DATOAGG2_T2').AsString:=DatoAgg2;
        end;
        RegistraLog.SettaProprieta('M','T380_PIANIFREPERIB',CodiceFormOwner,SelT380RowId,True);
        RegistraLog.RegistraOperazione;
        SelT380RowId.Post;
      end
      else
        raise Exception.Create('Errore grave, base dati inconsistente!'); // TODO
    except
      on E:Exception do
      begin
        // Errore. Annullo le modifiche. Inoltre effetto il rollback della sessione nel metodo chiamante
        if SelT380RowId.State in [dsEdit,dsInsert] then
          SelT380RowId.Cancel;
        RegistraLog.AnnullaOperazione;
        raise Exception.Create(Format('Errore durante la modifica della nuova pianificazione: %s',[e.Message]));        // TODO
      end;
    end;
  finally
    SelT380RowId.Close;
  end;
end;

procedure TW043FModPersonaleReperibileDM.RimuoviPianificazioneTurno(Progressivo:Integer;
                                                                    DataPianif:TDateTime;
                                                                    CodiceTurno:String);
var
  Turno1,Turno2,Turno3:String;
begin
  ApriSelT380RowId(Progressivo,DataPianif);
  try
    try
      if SelT380RowId.RecordCount = 0 then // Non dovrebbe mai succedere, a meno che qualcuno non chi ha modificato la T380 sotto
        raise Exception.Create('Errore durante la modifica della vecchia pianificazione, ----') // TODO
      else if  SelT380RowId.RecordCount > 1 then
        raise Exception.Create('Errore grave, base dati inconsistente!');

      Turno1:=Trim(SelT380RowId.FieldByName('TURNO1').AsString);
      Turno2:=Trim(SelT380RowId.FieldByName('TURNO2').AsString);
      Turno3:=Trim(SelT380RowId.FieldByName('TURNO3').AsString);
      // Caso base: unico turno pianificato è quello che dobbiamo cancellare
      if (Turno1 = CodiceTurno) and (Turno2 = '') and (Turno3 = '') then
      begin
        // Cancelliamo la pianificazione.
        RegistraLog.SettaProprieta('C','T380_PIANIFREPERIB',CodiceFormOwner,SelT380RowId,True);
        RegistraLog.RegistraOperazione;
        SelT380RowId.Delete;
        Exit;
      end;

      SelT380RowId.Edit;
      // Ci sono più turni pianificati. In quale slot si trova il nostro turno?
      if Turno3 = CodiceTurno then
      begin
        // Ci basta svuotare TURNO3
        SelT380RowId.FieldByName('TURNO3').AsString:='';
        SelT380RowId.FieldByName('PRIORITA3').Value:=null;
        SelT380RowId.FieldByName('RECAPITO3').AsString:='';
        SelT380RowId.FieldByName('DATOAGG1_T3').AsString:='';
        SelT380RowId.FieldByName('DATOAGG2_T3').AsString:='';
      end
      else if Turno2 = CodiceTurno then
      begin
        // Porto Turno3 in Turno2.
        SelT380RowId.FieldByName('TURNO2').Value:=SelT380RowId.FieldByName('TURNO3').Value;
        SelT380RowId.FieldByName('PRIORITA2').Value:=SelT380RowId.FieldByName('PRIORITA3').Value;
        SelT380RowId.FieldByName('RECAPITO2').Value:=SelT380RowId.FieldByName('RECAPITO3').Value;
        SelT380RowId.FieldByName('DATOAGG1_T2').Value:=SelT380RowId.FieldByName('DATOAGG1_T3').Value;
        SelT380RowId.FieldByName('DATOAGG2_T2').Value:=SelT380RowId.FieldByName('DATOAGG2_T3').Value;
        // ...e svuoto Turno3. Se è già vuoto questo non cambia nulla.
        SelT380RowId.FieldByName('TURNO3').AsString:='';
        SelT380RowId.FieldByName('PRIORITA3').Value:=null;
        SelT380RowId.FieldByName('RECAPITO3').AsString:='';
        SelT380RowId.FieldByName('DATOAGG1_T3').AsString:='';
        SelT380RowId.FieldByName('DATOAGG2_T3').AsString:='';
      end
      else if Turno1 = CodiceTurno then
      begin
        // Shifto Turno2 in Turno1.
        SelT380RowId.FieldByName('TURNO1').Value:=SelT380RowId.FieldByName('TURNO2').Value;
        SelT380RowId.FieldByName('PRIORITA1').Value:=SelT380RowId.FieldByName('PRIORITA2').Value;
        SelT380RowId.FieldByName('RECAPITO1').Value:=SelT380RowId.FieldByName('RECAPITO2').Value;
        SelT380RowId.FieldByName('DATOAGG1_T1').Value:=SelT380RowId.FieldByName('DATOAGG1_T2').Value;
        SelT380RowId.FieldByName('DATOAGG2_T1').Value:=SelT380RowId.FieldByName('DATOAGG2_T2').Value;
        // Ora Turno3 in Turno2.
        SelT380RowId.FieldByName('TURNO2').Value:=SelT380RowId.FieldByName('TURNO3').Value;
        SelT380RowId.FieldByName('PRIORITA2').Value:=SelT380RowId.FieldByName('PRIORITA3').Value;
        SelT380RowId.FieldByName('RECAPITO2').Value:=SelT380RowId.FieldByName('RECAPITO3').Value;
        SelT380RowId.FieldByName('DATOAGG1_T2').Value:=SelT380RowId.FieldByName('DATOAGG1_T3').Value;
        SelT380RowId.FieldByName('DATOAGG2_T2').Value:=SelT380RowId.FieldByName('DATOAGG2_T3').Value;
        // Posso svuotare Turno3
        SelT380RowId.FieldByName('TURNO3').AsString:='';
        SelT380RowId.FieldByName('PRIORITA3').Value:=null;
        SelT380RowId.FieldByName('RECAPITO3').AsString:='';
        SelT380RowId.FieldByName('DATOAGG1_T3').AsString:='';
        SelT380RowId.FieldByName('DATOAGG2_T3').AsString:='';
      end
      else
        // Questo è un problema
        raise Exception.Create('Il turno non esiste!'); // TODO
      RegistraLog.SettaProprieta('M','T380_PIANIFREPERIB',CodiceFormOwner,SelT380RowId,True);
      RegistraLog.RegistraOperazione;
      SelT380RowId.Post;
    except
      on E:Exception do
      begin
        // Errore. Annullo le modifiche. Inoltre nel metodo chiamante effetto il rollback.
        if SelT380RowId.State in [dsEdit,dsInsert] then
          SelT380RowId.Cancel;
        RegistraLog.AnnullaOperazione;
        raise Exception.Create(Format('Errore durante la modifica della vecchia pianificazione: %s',[e.Message])); // TODO
      end;
    end;
  finally
    SelT380RowId.Close;
  end;
end;

procedure TW043FModPersonaleReperibileDM.AddSpostamento(ProgDip1:Integer;DataPianif:TDateTime;CodiceTurno,Recapito:String);
// aggiunge un nuovo spostamento all'array
var x: Integer;
begin
  x:=Length(ArrSpostamenti);
  SetLength(ArrSpostamenti,x + 1);
  ArrSpostamenti[x].ProgDip1:=ProgDip1;
  ArrSpostamenti[x].DataPianif:=DataPianif;
  ArrSpostamenti[x].CodiceTurno:=CodiceTurno;
  ArrSpostamenti[x].Recapito:=Recapito;
end;

procedure TW043FModPersonaleReperibileDM.RemSpostamento(ProgDip1:Integer;DataPianif:TDateTime;CodiceTurno:String);
// aggiunge un nuovo spostamento all'array
var x: Integer;
begin
  for x:=0 to High(ArrSpostamenti) do
    if (ArrSpostamenti[x].ProgDip1 = ProgDip1)
    and (ArrSpostamenti[x].DataPianif = DataPianif)
    and (ArrSpostamenti[x].CodiceTurno = CodiceTurno) then
    begin
      ArrSpostamenti[x].ProgDip1:=-1;
      ArrSpostamenti[x].DataPianif:=0;
      ArrSpostamenti[x].CodiceTurno:='';
      ArrSpostamenti[x].Recapito:='';
      Break;
    end;
end;

function TW043FModPersonaleReperibileDM.GetListaProgDipSpostamento(DataPianif:TDateTime):String;
var x: Integer;
begin
  Result:='';
  for x:=0 to High(ArrSpostamenti) do
    if ArrSpostamenti[x].DataPianif = DataPianif then
      Result:=Result + IfThen(Result <> '',',') + IntToStr(ArrSpostamenti[x].ProgDip1);
  if Result <> '' then
    Result:=' or T030.progressivo in (' + Result + ')';
end;

function TW043FModPersonaleReperibileDM.GetProgDipSpostamento(CodiceTurno:String;DataPianif:TDateTime):Integer;
var x: Integer;
begin
  Result:=0;
  if not AccessoDaDipendente then
    exit;
  Result:=-1;
  for x:=0 to High(ArrSpostamenti) do
    if (ArrSpostamenti[x].DataPianif = DataPianif)
    and (ArrSpostamenti[x].CodiceTurno = CodiceTurno) then
    begin
      Result:=ArrSpostamenti[x].ProgDip1;
      Break;
    end;
end;

function TW043FModPersonaleReperibileDM.GetNomeDipSpostamento(ProgDip1:Integer):String;
begin
  Result:='';
  R180SetVariable(selT030,'PROGRESSIVO',ProgDip1);

  selT030.Open;
  if selT030.RecordCount = 1 then
    Result:=Format('%-8s %s %s',
                   [selT030.FieldByName('MATRICOLA').AsString,
                    selT030.FieldByName('COGNOME').AsString,
                    selT030.FieldByName('NOME').AsString]);
end;

function TW043FModPersonaleReperibileDM.GetRecapitoDipSpostamento(ProgDip1:Integer;CodiceTurno:String;DataPianif:TDateTime):String;
var x: Integer;
begin
  Result:='';
  for x:=0 to High(ArrSpostamenti) do
    if (ArrSpostamenti[x].ProgDip1 = ProgDip1)
    and (ArrSpostamenti[x].DataPianif = DataPianif)
    and (ArrSpostamenti[x].CodiceTurno = CodiceTurno) then
    begin
      Result:=ArrSpostamenti[x].Recapito;
      Break;
    end;
end;

function TW043FModPersonaleReperibileDM.GetRecapitoProposto(ProgDip: Integer; Campo: String; DataPianif: TDateTime): String;
begin
  with selT430Recapito do
  begin
    ClearVariables;
    SetVariable('PROGRESSIVO', ProgDip);
    SetVariable('DATA', DataPianif);
    SetVariable('RECAPITO', Campo);
    Execute;
    Result:=FieldAsString(0);
  end;
end;

procedure TW043FModPersonaleReperibileDM.ModificaRecapitoExtra(Progressivo:Integer;
                                                               DataPianif:TDateTime;
                                                               NumeroTurno:Integer;
                                                               NuovoRecapitoExtra:String);
begin
  ApriSelT380RowId(Progressivo,DataPianif);
  if selT380RowId.RecordCount = 0 then
    raise Exception.Create('La pianificazione di questo turno non esiste più')
  else if selT380RowId.RecordCount > 1 then
    raise Exception.Create('Errore grave, base dati inconsistente!')
  else
  begin
    try
      selT380RowId.Edit;
      selT380RowId.FieldByName('RECAPITO' + IntToStr(NumeroTurno)).AsString:=NuovoRecapitoExtra;
      selT380RowId.Post;
      selT380RowId.Session.Commit;
    finally
      selT380RowId.Close;
    end;
  end;
end;

{ Verifica se la definizione il primo dato libero scelto per il filtro comprende le
  informazioni sulla mail e sul telefono; se sì, prepara il dataset per la successiva estrazione
  dei dati }
procedure TW043FModPersonaleReperibileDM.ImpostaODSDatoLibero;
var
  DatoLibero,TabellaDL,CodiceDL,StoricoDL:String;
  DatoLiberoSQL:String;
begin
  UsaEMailDatoLibero:=False;
  UsaTelefonoDatoLibero:=False;
  DatoLiberoStorico:=False;
  selDatoLibero.SQL.Clear;
  selDatoLibero.ClearVariables;
  if Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 <> '' then
  begin
    DatoLibero:=Parametri.CampiRiferimento.C29_ChiamateRepFiltro1;
    // Su quale tabella è descritto il dato libero?
    A000GetTabella(DatoLibero,TabellaDL,CodiceDL,StoricoDL);
    if (TabellaDL <> '') and (Copy(TabellaDL,1,4) = 'I501') then
    begin
      // La tabella del dato libero include le colonne TELEFONO e EMAIL?
      WR000DM.selCOLS.Close;
      WR000DM.selCOLS.ClearVariables;
      WR000DM.selCOLS.SetVariable('TABELLA',TabellaDL);
      WR000DM.selCOLS.Open;
      UsaEMailDatoLibero:=(WR000DM.selCOLS.Lookup('COLUMN_NAME','EMAIL','COLUMN_NAME') = 'EMAIL');
      UsaTelefonoDatoLibero:=(WR000DM.selCOLS.Lookup('COLUMN_NAME','TELEFONO','COLUMN_NAME') = 'TELEFONO');
      if UsaEMailDatoLibero or UsaTelefonoDatoLibero then
      begin
        // Impostiamo la query per la tabella del dato libero
        DatoLiberoSQL:='select ' + CodiceDL;
        if UsaEMailDatoLibero then
          DatoLiberoSQL:=DatoLiberoSQL + ', EMAIL';
        if UsaTelefonoDatoLibero then
          DatoLiberoSQL:=DatoLiberoSQL + ', TELEFONO';
        DatoLiberoSQL:=DatoLiberoSQL + ' from ' + TabellaDL + ' T1 where T1.' + CodiceDL + ' = :CODICE';
        if StoricoDL = 'S' then
          DatoLiberoSQL:=DatoLiberoSQL + ' and :DECORRENZA between DECORRENZA and DECORRENZA_FINE';
        SelDatoLibero.SQL.Text:=DatoLiberoSQL;

        selDatoLibero.DeclareVariable('CODICE',otString);
        if StoricoDL = 'S' then
          selDatoLibero.DeclareVariable('DECORRENZA',otDate);
        DatoLiberoStorico:=(StoricoDL = 'S');
      end;
    end;
  end;
end;

procedure TW043FModPersonaleReperibileDM.CreaStringheMessaggio(ProgDipDa:Integer;
                                                               ProgDipA:Integer;
                                                               DataPianif:TDateTime;
                                                               CodiceTurno:String;
                                                               var Oggetto:String;
                                                               var Corpo:String);

var
  CodiceSiglaTurno:String;
  DescrDipDa,DescrDipA:String;
  i:Integer;
begin
  // Cognome Nome (Matricola) - Dipendente 1
  {if not selAnagrafeDipRep.Locate('PROGRESSIVO',ProgDipDa,[]) then
    raise Exception.Create('Errore interno: dipendente sorgente non trovato!'); // TODO
  DescrDipDa:=Format('%s %s (%s)',
                     [selAnagrafeDipRep.FieldByName('COGNOME').AsString,
                      selAnagrafeDipRep.FieldByName('NOME').AsString,
                      selAnagrafeDipRep.FieldByName('MATRICOLA').AsString]);}
  if GetNomeDipSpostamento(ProgDipDa) = '' then
    raise Exception.Create('Errore interno: dipendente sorgente non trovato!'); // TODO
  DescrDipDa:=Format('%s %s (%s)',
                     [selT030.FieldByName('COGNOME').AsString,
                      selT030.FieldByName('NOME').AsString,
                      selT030.FieldByName('MATRICOLA').AsString]);

  // Cognome Nome (Matricola) - Dipendente 2
  {if not selAnagrafeDipRep.Locate('PROGRESSIVO',ProgDipA,[]) then
    raise Exception.Create('Errore interno: dipendente destinazione non trovato!'); // TODO
  DescrDipA:=Format('%s %s (%s)',
                     [selAnagrafeDipRep.FieldByName('COGNOME').AsString,
                      selAnagrafeDipRep.FieldByName('NOME').AsString,
                      selAnagrafeDipRep.FieldByName('MATRICOLA').AsString]);}
  if GetNomeDipSpostamento(ProgDipA) = '' then
    raise Exception.Create('Errore interno: dipendente destinazione non trovato!'); // TODO
  DescrDipA:=Format('%s %s (%s)',
                     [selT030.FieldByName('COGNOME').AsString,
                      selT030.FieldByName('NOME').AsString,
                      selT030.FieldByName('MATRICOLA').AsString]);

  if not selT350.Locate('CODICE',CodiceTurno,[]) then
    raise Exception.Create('Errore interno: codice turno non trovato!'); // TODO
  CodiceSiglaTurno:=IfThen(selT350.FieldByName('SIGLA').AsString <> '',
                           selT350.FieldByName('SIGLA').AsString,
                           selT350.FieldByName('CODICE').AsString);

  // Inizio a comporre il messaggio. Prima l'oggetto.
  Oggetto:=DateToStr(DataPianif) + ': turno ' + CodiceSiglaTurno + ' da ' + DescrDipDa + ' a ' + DescrDipA;

  // Ora il corpo
  Corpo:='Si avvisa che è stata spostata la pianificazione del seguente turno' + CRLF +
         '    Data: ' + DateToStr(DataPianif) + CRLF +
         '    Fascia oraria: ' + selT350.FieldByName('ORAINIZIOSTR').AsString + ' - ' + selT350.FieldByName('ORAFINESTR').AsString + CRLF +
         '    Turno: ' + CodiceSiglaTurno + ' (' + selT350.FieldByName('DESCRIZIONE').AsString + ')' + CRLF + CRLF +
         'dal dipendente ' + DescrDipDa + CRLF +
         'al dipendente  ' + DescrDipA;

  Corpo:=Corpo + CRLF  + CRLF +
         'L''operazione è stata effettuata dall''operatore ' + Parametri.Operatore + '.';

  try
    // Pianificazione dipendente da
    ApriSelT380(ProgDipDa,DataPianif);
    if selT380.RecordCount > 1 then
      raise Exception.Create('Errore grave, base dati inconsistente!');  // TODO
    Corpo:=Corpo + CRLF + CRLF +
           'Riepilogo turni di ' + DescrDipDa + ' del ' + DateToStr(DataPianif) + CRLF;
    if selT380.RecordCount = 0 then
      Corpo:=Corpo + '    Nessuna pianificazione esistente' + CRLF
    else
    begin
      for i:=1 to 3 do
      begin
        if selT380.FieldByName('TURNO' + IntToStr(i)).AsString <> '' then
        begin
          Corpo:=Corpo + '    Turno ' + IntToStr(i) + ': ' +
                 IfThen(selT380.FieldByName('SIGLA_TURNO' + IntToStr(i)).AsString <> '', // Sigla o codice turno
                        selT380.FieldByName('SIGLA_TURNO' + IntToStr(i)).AsString,
                        selT380.FieldByName('TURNO' + IntToStr(i)).AsString) +
                 ' ' + selT380.FieldByName('DESCRIZIONE_TURNO' + IntToStr(i)).AsString +
                 '   fascia oraria: ' +
                 selT380.FieldByName('DALLE_TURNO' + IntToStr(i)).AsString + ' - ' +
                 selT380.FieldByName('ALLE_TURNO' + IntToStr(i)).AsString + CRLF;
        end;
      end;
    end;

    // Pianificazione del dipendente a
    ApriSelT380(ProgDipA,DataPianif);
    if selT380.RecordCount > 1 then
      raise Exception.Create('Errore grave, base dati inconsistente!');  // TODO
    Corpo:=Corpo + CRLF +
           'Riepilogo turni di ' + DescrDipA + ' del ' + DateToStr(DataPianif) + CRLF;
    if selT380.RecordCount = 0 then
      Corpo:=Corpo + '    Nessuna pianificazione esistente' // Impossibile
    else
    begin
      for i:=1 to 3 do
      begin
        if selT380.FieldByName('TURNO' + IntToStr(i)).AsString <> '' then
        begin
          Corpo:=Corpo + '    Turno ' + IntToStr(i) + ': ' +
                 IfThen(selT380.FieldByName('SIGLA_TURNO' + IntToStr(i)).AsString <> '', // Sigla o codice turno
                        selT380.FieldByName('SIGLA_TURNO' + IntToStr(i)).AsString,
                        selT380.FieldByName('TURNO' + IntToStr(i)).AsString) +
                 ' ' + selT380.FieldByName('DESCRIZIONE_TURNO' + IntToStr(i)).AsString +
                 '   fascia oraria: ' +
                 selT380.FieldByName('DALLE_TURNO' + IntToStr(i)).AsString + ' - ' +
                 selT380.FieldByName('ALLE_TURNO' + IntToStr(i)).AsString + CRLF;
        end;
      end;
    end;
  finally
    selT380.Close;
  end;

end;

function TW043FModPersonaleReperibileDM.GetEMailDatoLibero(Progressivo:Integer;
                                                           DataPianif:TDateTime):String;
var
  ColonnaT430DatoLibero:String;
  //ValoreDLVar:Variant;
  ValoreDLString:String;
begin
  Result:='';
  if UsaEMailDatoLibero then
  begin
    R180SetVariable(selT030DatoLibero,'DATOL',Parametri.CampiRiferimento.C29_ChiamateRepFiltro1);
    R180SetVariable(selT030DatoLibero,'PROGRESSIVO',Progressivo);
    R180SetVariable(selT030DatoLibero,'DATA_LAVORO',DataPianif);
    selT030DatoLibero.Open;

    if selT030DatoLibero.RecordCount <> 1 then
      raise Exception.Create('Errore grave: dipendente non trovato!'); // Impossibile, TODO
    ValoreDLString:=selT030DatoLibero.FieldByName('DATOL').AsString;

    {ColonnaT430DatoLibero:='T430' + Parametri.CampiRiferimento.C29_ChiamateRepFiltro1;
    ValoreDLVar:=selAnagrafeDipRep.Lookup('PROGRESSIVO',Progressivo,ColonnaT430DatoLibero);
    if (VarType(ValoreDLVar) and varTypeMask) = varBoolean  then
      raise Exception.Create('Errore grave: dipendente non trovato!'); // Impossibile, TODO
    ValoreDLString:=VarToStr(ValoreDLVar);}

    R180SetVariable(selDatoLibero,'CODICE',ValoreDLString);
    if DatoLiberoStorico then
      R180SetVariable(selDatoLibero,'DECORRENZA',DataPianif);

    selDatoLibero.Open;
    if selDatoLibero.RecordCount = 1 then
    begin
      Result:=Trim(selDatoLibero.FieldByName('EMAIL').AsString);
    end
    else
      Result:='';
  end;
end;

function TW043FModPersonaleReperibileDM.SalvaEMailsAvviso(ProgDipDa,ProgDipA:Integer;
                                                           DataPianif:TDateTime;
                                                           CodiceTurno:String):String;
var
  Oggetto,Corpo:String;
  EMailRespDipDa,EMailRespDipA:String;
  DatoLiberoVariant:Variant;
  DatoLiberoDipDa,DatoLiberoDipA:String;
  ColonnaT430DatoLibero:String;
begin
  Result:='';
  if Parametri.CampiRiferimento.C90_EMailSMTPHost <> '' then
    try
      // Compongo il messaggio
      CreaStringheMessaggio(ProgDipDa,ProgDipA,DataPianif,CodiceTurno,Oggetto,Corpo);

      // Salvo su DB i messaggi
      WR000DM.RegistraMailT280(ProgDipDa,Oggetto,Corpo);
      WR000DM.RegistraMailT280(ProgDipA,Oggetto,Corpo);

      if not UsaEMailDatoLibero then
      begin
        // Non abbiamo altri destinatari a cui inviare le mail informative. Fine.
        Result:='Sono state inviate notifiche ai dipendenti interessati.';
        Exit;
      end
      else // Sulla tabella I051* potrebbero essere state definite mail aggiuntive
      begin
        // Ricavo gli indirizzi mail dei supervisori dai dati liberi
        EMailRespDipDa:=GetEMailDatoLibero(ProgDipDa,DataPianif);
        EMailRespDipA:=GetEMailDatoLibero(ProgDipA,DataPianif);
        if EMailRespDipDa <> '' then
          WR000DM.RegistraMailT280(-1,Oggetto,Corpo,EMailRespDipDa);
        if (EMailRespDipA <> '') and (EMailRespDipDa <> EMailRespDipA) then
          WR000DM.RegistraMailT280(-1,Oggetto,Corpo,EMailRespDipA);

        // Esito salvataggio messaggi
        ColonnaT430DatoLibero:='T430' + Parametri.CampiRiferimento.C29_ChiamateRepFiltro1;
        DatoLiberoVariant:=selAnagrafeDipRep.Lookup('PROGRESSIVO',ProgDipDa,ColonnaT430DatoLibero);
        if (VarType(DatoLiberoVariant) and varTypeMask) = varBoolean  then
          raise Exception.Create('Errore grave: dipendente DA non trovato'); // Impossibile, TODO
        DatoLiberoDipDa:=VarToStr(DatoLiberoVariant);
        DatoLiberoVariant:=selAnagrafeDipRep.Lookup('PROGRESSIVO',ProgDipA,ColonnaT430DatoLibero);
        if (VarType(DatoLiberoVariant) and varTypeMask) = varBoolean  then
          raise Exception.Create('Errore grave: dipendente A non trovato'); // Impossibile, TODO
        DatoLiberoDipA:=VarToStr(DatoLiberoVariant);

        if (EMailRespDipDa <> '') and (EMailRespDipA <> '') then
          Result:=Format('Sono state inviate notifiche a tutti i soggetti coinvolti (dipendenti e casella di %s).',
                         [Parametri.CampiRiferimento.C29_ChiamateRepFiltro1])
        else if (EMailRespDipDa <> '') and (EMailRespDipA = '') then
          Result:=Format('Sono state inviate notifiche ai dipendenti coinvolti e alla casella di %s del dipendente di origine. ' + CRLF +
                         'NON è stato possibile inviare il messaggio alla casella di %s del dipendente di destinazione poichè non è stato associato un indirizzo email ' +
                         ' al %s %s.',
                         [Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                          Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                          Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                          DatoLiberoDipA])
        else if (EMailRespDipDa = '') and (EMailRespDipA <> '') then
          Result:=Format('Sono state inviate notifiche ai dipendenti coinvolti e alla casella di %s del dipendente di destinazione. ' + CRLF +
                         'NON è stato possibile inviare il messaggio alla casella di %s del dipendente di origine poichè non è stato associato un indirizzo email ' +
                         ' al %s %s.',
                         [Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                          Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                          Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                          DatoLiberoDipDa])
        else if (EMailRespDipDa = '') and (EMailRespDipA = '') then
        begin
          if DatoLiberoDipDa <> DatoLiberoDipA then
            Result:=Format('Sono state inviate notifiche ai dipendenti coinvolti. ' + CRLF +
                           'NON è stato possibile inviare il messaggio nè alla casella di %s del dipendente di origine nè a quella del dipendente ' +
                           'di destinazione poichè non sono stati associati indirizzi email ' +
                           ' ai %s %s e %s.',
                           [Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                            Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                            DatoLiberoDipDa,
                            DatoLiberoDipA])
          else
            Result:=Format('Sono state inviate notifiche ai dipendenti coinvolti.' + CRLF +
                           'NON è stato possibile inviare il messaggio nè alla casella di %s del dipendente di origine nè a quella del dipendente di destinazione poichè ' +
                           'non è stato associato un indirizzo email ' +
                           ' al %s %s.',
                           [Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                            Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                            DatoLiberoDipDa]);

        end;
      end;
    except
      on E:Exception do
      begin
        // Il rollback della transazione lo faccio nel chiamante
        Result:=Format('Errore l''invio dei messaggi mail di notifica: %s',[E.Message]); // TODO
        Exit;
      end;
    end;
end;

end.
