unit W044UAcquistoTicketDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  FunzioniGenerali,
  C180FunzioniGenerali,
  QueryStorico,
  W000UMessaggi,
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  System.StrUtils,
  Data.DB,
  Oracle,
  OracleData;

type
  TTipoPasto = record
  const
    BuoniPasto = 'B';
    Ticket     = 'T';
  end;

  TRegolaTicket = record
    Esiste: Boolean;
    Codice: String;
    PastoTicket: String;
    RichiestaNomeDatoLibero: String;
    RichiestaValoreDatoLibero: String;
    RichiestaGGDal: Integer;
    RichiestaGGAl: Integer;
    RichiestaMaxTicketMese: Integer;
    function ToString: String; inline;
    procedure Clear; inline;
    function ControllaRegola: TResCtrl; inline;
    function ControllaValoreDatoLibero(const PValore: String): Boolean; inline;
    function ControllaAccessoFunzione(const PProgressivo: Integer; out RDataDecorrenzaAccesso: TDateTime): TResCtrl; inline;
    function IsDateInRangeConsentito: Boolean; inline;
    function GetDescPastoTicket: String; inline;
    function GetDatoPastoTicket: String; inline;
  end;

  TW044FAcquistoTicketDM = class(TDataModule)
    selT670: TOracleDataSet;
    selT690: TOracleDataSet;
    selT690PROGRESSIVO: TIntegerField;
    selT690DATA: TDateTimeField;
    selT690BUONIPASTO: TIntegerField;
    selT690TICKET: TIntegerField;
    selT690NOTE: TStringField;
    selT690SumTicket: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT690AfterPost(DataSet: TDataSet);
    procedure selT690NewRecord(DataSet: TDataSet);
    procedure selT690BeforePost(DataSet: TDataSet);
    procedure selT690BeforeEdit(DataSet: TDataSet);
  private
    FRegolaTicket: TRegolaTicket;
    FProgressivoIns: Integer;
    FDataIns: TDateTime;
    FOperazioneT690: String;
  public
    function LeggiRegolaTicket(const PProgressivo: Integer): TResCtrl;
    property RegolaTicket: TRegolaTicket read FRegolaTicket;
    property ProgressivoIns: Integer read FProgressivoIns write FProgressivoIns;
    property DataIns: TDateTime read FDataIns write FDataIns;
  end;

implementation

uses
  W044UAcquistoTicket;

{$R *.dfm}

{ TW044FAcquistoTicketDM }

procedure TW044FAcquistoTicketDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
end;

function TW044FAcquistoTicketDM.LeggiRegolaTicket(const PProgressivo: Integer): TResCtrl;
var
  LQSTicket: TQueryStorico;
  LDato: String;
  LMeseSuccIni: TDateTime;
  LMeseSuccFine: TDateTime;
const
  NOME_METODO = 'TW044FAcquistoTicketDM.LeggiRegolaTicket';
begin
  // PRE: Parametri.CampiRiferimento.C4_BuoniMensa <> ''

  Result.Clear;
  FRegolaTicket.Clear;

  TLogger.EnterMethod(NOME_METODO);
  try

    // imposta le date di riferimento per cercare il codice della regola dei buoni pasto / ticket
    // il periodo considerato è l'intero mese successivo
    LMeseSuccIni:=Date.StartOfMonth.AddMonths(1);
    LMeseSuccFine:=LMeseSuccIni.EndOfMonth.Date;

    // crea il dataset per estrarre i dati della regola ticket
    LQSTicket:=TQueryStorico.Create(nil);
    try
      LQSTicket.Session:=SessioneOracle;

      LDato:=Format('T430%s',[Parametri.CampiRiferimento.C4_BuoniMensa]);
      TLogger.Debug(Format('Lettura dei codici regola ticket (%s) associati al progressivo %d nel mese successivo (%s - %s)',[LDato,PProgressivo,LMeseSuccIni.ToString('dd/mm/yyyy'),LMeseSuccFine.ToString('dd/mm/yyyy')]));
      LQSTicket.GetDatiStorici(LDato,PProgressivo,LMeseSuccIni,LMeseSuccFine);
      TLogger.Debug('Storicizzazioni trovate nel periodo',LQSTicket.RecordCount);

      // verifica il valore del codice regola alla fine del mese successivo
      // (l'idea è quella di valutare la situazione più aggiornata)
      TLogger.Debug(Format('Ricerca del valore del codice regola ticket (%s) alla fine del mese successivo (%s)',[LDato,LMeseSuccFine.ToString('dd/mm/yyyy')]));
      if not LQSTicket.LocDatoStorico(LMeseSuccFine) then
      begin
        TLogger.Error('Nessuna storicizzazione valida a fine mese successivo');
        Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_NO_DATO_REGOLA),
                                 [LMeseSuccFine.ToString('dd/mm/yyyy'),
                                  Parametri.CampiRiferimento.C4_BuoniMensa]);
        Exit;
      end;

      // estrae i dati della regola e li salva in una variabile
      FRegolaTicket.Codice:=LQSTicket.FieldByName(LDato).AsString;
      TLogger.Debug(Format('Codice regola ticket (%s) trovato',[LDato]),FRegolaTicket.Codice);
      selT670.Close;
      selT670.SetVariable('CODICE',FRegolaTicket.Codice);
      selT670.Open;

      // anomalia se il codice regola non è presente sul database
      if selT670.RecordCount = 0 then
      begin
        TLogger.Error(Format('Codice regola ticket (%s) non presente su tabella T670: %s',[LDato,FRegolaTicket.Codice]));
        Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_NO_REGOLA),
                                 [Parametri.CampiRiferimento.C4_BuoniMensa,
                                  FRegolaTicket.Codice]);
        Exit;
      end;

      // regola trovata: salva i dati in una variabile
      FRegolaTicket.Esiste:=True;
      FRegolaTicket.PastoTicket:=selT670.FieldByName('PASTO_TICKET').AsString;
      FRegolaTicket.RichiestaNomeDatoLibero:=selT670.FieldByName('RICHIESTA_NOME_DATO_LIBERO').AsString;
      FRegolaTicket.RichiestaValoreDatoLibero:=selT670.FieldByName('RICHIESTA_VALORE_DATO_LIBERO').AsString;
      FRegolaTicket.RichiestaGGDal:=selT670.FieldByName('RICHIESTA_GG_DAL').AsInteger;
      FRegolaTicket.RichiestaGGAl:=selT670.FieldByName('RICHIESTA_GG_AL').AsInteger;
      FRegolaTicket.RichiestaMaxTicketMese:=selT670.FieldByName('RICHIESTA_MAX_TICKET_MESE').AsInteger;

      TLogger.Debug(Format('Dati regola ticket (%s)',[LDato]),FRegolaTicket.ToString);

      // verifica i dati della regola
      Result:=FRegolaTicket.ControllaRegola;

      if not Result.Ok then
        TLogger.Warning(Format('Regola ticket (%s) non valida: %s. Verificare le impostazioni!',[LDato,Result.Messaggio]));

      // imposta abilitazioni campi
      selT690.FieldByName('BUONIPASTO').ReadOnly:=(FRegolaTicket.PastoTicket <> TTipoPasto.BuoniPasto);
      selT690.FieldByName('TICKET').ReadOnly:=(FRegolaTicket.PastoTicket <> TTipoPasto.Ticket);
    finally
      FreeAndNil(LQSTicket);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TW044FAcquistoTicketDM.selT690NewRecord(DataSet: TDataSet);
begin
  // valorizza dati di default
  selT690.FieldByName('PROGRESSIVO').AsInteger:=FProgressivoIns;
  // data acquisto: prima data valida della regola
  selT690.FieldByName('DATA').AsDateTime:=FDataIns;
  // note
  selT690.FieldByName('NOTE').AsString:=Format(A000MSG_W044_MSG_FMT_NOTE,[Date.ToString('dd/mm/yyyy')]);
end;

procedure TW044FAcquistoTicketDM.selT690BeforeEdit(DataSet: TDataSet);
begin
  // data acquisto: prima data valida della regola
  selT690.FieldByName('DATA').AsDateTime:=FDataIns;
  // note
  selT690.FieldByName('NOTE').AsString:=Format(A000MSG_W044_MSG_FMT_NOTE,[Date.ToString('dd/mm/yyyy')]);
end;

procedure TW044FAcquistoTicketDM.selT690BeforePost(DataSet: TDataSet);
var
  LDatoNumBuoni: String;
  LDescTipo: String;
  LInizioMese: TDateTime;
  LTicketRichiesti: Integer;
  LTicketPresenti: Integer;
begin
  LDatoNumBuoni:=FRegolaTicket.GetDatoPastoTicket;
  LDescTipo:=FRegolaTicket.GetDescPastoTicket;
  LInizioMese:=selT690.FieldByName('DATA').AsDateTime.StartOfMonth;

  // verifica il numero di buoni / ticket richiesti per l'acquisto

  // il numero di ticket è obbligatorio
  if selT690.FieldByName(LDatoNumBuoni).IsNull then
    raise Exception.CreateFmt(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_NUM_TICKET_OBBL),[LDescTipo]);

  // il numero di ticket deve essere >= 0
  LTicketRichiesti:=selT690.FieldByName(LDatoNumBuoni).AsInteger;
  if LTicketRichiesti < 0 then
    raise Exception.CreateFmt(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_NUM_TICKET_GE0),[LDescTipo]);

  // il numero di ticket non deve superare il max mensile indicato sulla regola
  if selT690.FieldByName(LDatoNumBuoni).AsInteger > FRegolaTicket.RichiestaMaxTicketMese then
    raise Exception.CreateFmt(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_NUM_TICKET_LTSOGLIA),[FRegolaTicket.RichiestaMaxTicketMese,LDescTipo]);

  // la somma dei ticket del mese non deve superare il max mensile indicato sulla regola
  try
    // determina la somma dei ticket / buoni pasto acquistati nel mese
    selT690SumTicket.SetVariable('PROGRESSIVO',selT690.FieldByName('PROGRESSIVO').AsInteger);
    selT690SumTicket.SetVariable('DATARIF',LInizioMese);
    selT690SumTicket.SetVariable('FILTRO_ESCLUDI_RECORD',Format('AND T690.ROWID <> ''%s''',[selT690.Rowid]));
    selT690SumTicket.Execute;
  except
    on E: Exception do
      raise Exception.CreateFmt('Si è verificato un errore durante la verifica dei %s già acquistati a %s: %s',[LDescTipo,LInizioMese.ToString('mmmm yyyy'),E.Message]);
  end;

  LTicketPresenti:=selT690SumTicket.FieldAsInteger(LDatoNumBuoni);
  if LTicketRichiesti + LTicketPresenti > FRegolaTicket.RichiestaMaxTicketMese then
    raise Exception.CreateFmt(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_NUM_TICKET_TOT_LTSOGLIA),[LInizioMese.ToString('mmmm yyyy'),FRegolaTicket.RichiestaMaxTicketMese,LDescTipo]);

  // reimposta le note in modo da allineare la data attuale
  selT690.FieldByName('NOTE').AsString:=Format(A000MSG_W044_MSG_FMT_NOTE,[Date.ToString('dd/mm/yyyy')]);

  // imposta proprietà log
  FOperazioneT690:=IfThen(DataSet.State = dsInsert,'I','M');
  RegistraLog.SettaProprieta(IfThen(DataSet.State = dsInsert,'I','M'),'T690_ACQUISTOBUONI','W044',DataSet,True);
  RegistraLog.InserisciDato('DATA_OPERAZIONE','',Date.ToString);
end;

procedure TW044FAcquistoTicketDM.selT690AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;

  // refresh del dataset in caso di inserimento (per via dell'ordinamento)
  if FOperazioneT690 = 'I' then
  begin
    // refresh del dataset per rieffettuare l'ordinamento dei record
    selT690.Refresh;

    // in seguito all'inserimento disattiva l'inserimento sulla grid
    (Self.Owner as TW044FAcquistoTicket).OnAfterInserimento;
  end;
end;

{ TRegolaTicket }

procedure TRegolaTicket.Clear;
begin
  Esiste:=False;
  Codice:='';
  PastoTicket:='';
  RichiestaNomeDatoLibero:='';
  RichiestaValoreDatoLibero:='';
  RichiestaGGDal:=0;
  RichiestaGGAl:=0;
  RichiestaMaxTicketMese:=0;
end;

function TRegolaTicket.ToString: String;
begin
  Result:=Format('Esiste: %s'#13#10,
                 [IfThen(Esiste,'true','false')]) +
          Format('Codice: %s'#13#10,
                 [Codice]) +
          Format('Tipo (buoni pasto / ticket): %s'#13#10,
                 [PastoTicket]) +
          Format('Controllo accesso: nome dato libero: %s'#13#10,
                 [RichiestaNomeDatoLibero]) +
          Format('Controllo accesso: valori dato libero: %s'#13#10,
                 [RichiestaValoreDatoLibero]) +
          Format('Periodo del mese per variazioni: %s'#13#10,
                 [IfThen((RichiestaGGDal = 0) and (RichiestaGGAl = 0),
                         'mese intero',
                         Format('dal %d al %d',[RichiestaGGDal,RichiestaGGAl]))]) +
          Format('Max ticket richiedibili mensilmente: %d',
                 [RichiestaMaxTicketMese]);
end;

function TRegolaTicket.ControllaRegola: TResCtrl;
begin
  Result.Clear;

  // verifica che se è indicato il dato libero, sia indicato anche il valore per il confronto
  if RichiestaNomeDatoLibero <> '' then
  begin
    if RichiestaValoreDatoLibero = '' then
    begin
      Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_DATO_LIBERO_VALORE_VUOTO),[RichiestaNomeDatoLibero]);
      Exit;
    end;
  end;

  // controlla validità periodo inserimento acquisti
  if (RichiestaGGDal <> 0) or (RichiestaGGAl <> 0) then
  begin
    if RichiestaGGDal > RichiestaGGAl then
    begin
      Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_PERIODO_INS_INVALIDO),[RichiestaGGDal,RichiestaGGAl]);
      Exit;
    end;
  end;

  // dati regola ok
  Result.Ok:=True;
end;

function TRegolaTicket.ControllaValoreDatoLibero(const PValore: String): Boolean;
// verifica che il valore indicato sia quello previsto dalla regola
// - se esso contiene il carattere virgola (,):
//   restituisce True se il valore è uguale ad uno di quelli del "commatext"
// - se non contiene il carattere virgola:
//   restituisce True se il valore è uguale a quello della regola
var
  LDato: String;
begin
  if RichiestaValoreDatoLibero.Contains(',') then
  begin
    // valori separati da virgola
    //   verifica se il valore indicato corrisponde ad uno di essi
    Result:=False;
    for LDato in RichiestaValoreDatoLibero.Split([',']) do
    begin
      Result:=(PValore = LDato);
      if Result then
        Break;
    end;
  end
  else
  begin
    // valore singolo: confronto diretto
    Result:=(PValore = RichiestaValoreDatoLibero);
  end;
end;

function TRegolaTicket.GetDescPastoTicket: String;
begin
  if PastoTicket = TTipoPasto.BuoniPasto then
    Result:='buoni pasto'
  else if PastoTicket = TTipoPasto.Ticket then
    Result:='ticket'
  else
    Result:=Format('tipo buoni pasto sconosciuto (%s)',[PastoTicket]);
end;

function TRegolaTicket.GetDatoPastoTicket: String;
begin
 if PastoTicket = TTipoPasto.BuoniPasto then
    Result:='BUONIPASTO'
  else if PastoTicket = TTipoPasto.Ticket then
    Result:='TICKET'
  else
    Result:=Format('tipo buoni pasto sconosciuto (%s)',[PastoTicket]);
end;

function TRegolaTicket.ControllaAccessoFunzione(const PProgressivo: Integer; out RDataDecorrenzaAccesso: TDateTime): TResCtrl;
var
  LQSDatoLibero: TQueryStorico;
  LDato: String;
  LMeseSuccIni: TDateTime;
  LMeseSuccFine: TDateTime;
const
  NOME_METODO = 'TRegolaTicket.ControllaAccessoFunzione';
begin
  Result.Clear;
  RDataDecorrenzaAccesso:=DATE_NULL;

  TLogger.EnterMethod(NOME_METODO);
  try
    // verifica se esiste il codice regola ticket
    if not Esiste then
    begin
      Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_NO_REGOLA),[Codice,Parametri.CampiRiferimento.C4_BuoniMensa]);
      TLogger.Error(Result.Messaggio);
      Exit;
    end;

    // se non è previsto il controllo di accesso basato sul dato libero restituisce true
    if RichiestaNomeDatoLibero = '' then
    begin
      Result.Ok:=True;
      TLogger.Debug(Format('Accesso consentito: non è previsto il controllo di accesso basato su dato libero. Data di acquisto ticket: %s',[RDataDecorrenzaAccesso.ToString('dd/mm/yyyy')]));
      Exit;
    end;

    // imposta il nome del dato libero
    LDato:=Format('T430%s',[RichiestaNomeDatoLibero]);

    // imposta le date di riferimento per cercare il valore del dato libero
    // il periodo considerato è l'intero mese successivo
    LMeseSuccIni:=Date.StartOfMonth.AddMonths(1);
    LMeseSuccFine:=LMeseSuccIni.EndOfMonth.Date;

    TLogger.Debug('Dato libero per il controllo di accesso',LDato);

    // crea il dataset per estrarre il dato libero per il controllo di accesso
    LQSDatoLibero:=TQueryStorico.Create(nil);
    try
      LQSDatoLibero.Session:=SessioneOracle;

      TLogger.Debug(Format('Lettura dei valori di %s associati al progressivo %d nel mese successivo (%s - %s)',[LDato,PProgressivo,LMeseSuccIni.ToString('dd/mm/yyyy'),LMeseSuccFine.ToString('dd/mm/yyyy')]));
      LQSDatoLibero.GetDatiStorici(LDato,PProgressivo,LMeseSuccIni,LMeseSuccFine);


       // se non sono presenti storicizzazioni dà anomalia
      if LQSDatoLibero.RecordCount = 0 then
      begin
        TLogger.Error('Nessuna storicizzazione trovata nel periodo del mese successivo. Verificare la scheda anagrafica!');
        Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_NO_DATOLIBERO),
                                 [RichiestaNomeDatoLibero,
                                 LMeseSuccIni.ToString('dd/mm/yyyy')]);
        Exit;
      end;

      TLogger.Debug('Storicizzazioni trovate nel periodo',LQSDatoLibero.RecordCount);

      // verifica che il valore del dato libero corrisponda a quello richiesto dalla regola
      // in ALMENO una delle storicizzazioni presenti nel mese successivo
      while not LQSDatoLibero.Eof do
      begin
        // estrae il valore del dato libero alla data odierna
        Result.Ok:=ControllaValoreDatoLibero(LQSDatoLibero.FieldByName(LDato).AsString);
        if Result.Ok then
        begin
          // imposta la prima data di storicizzazione per cui la condizione è verificata
          RDataDecorrenzaAccesso:=LQSDatoLibero.FieldByName('T430DATADECORRENZA').AsDateTime;
          TLogger.Debug(Format('Accesso consentito: il dato %s corrisponde al valore previsto nella storicizzazione del %s. Data di acquisto ticket = data di storicizzazione',[LDato,RDataDecorrenzaAccesso.ToString('dd/mm/yyyy')]));
          Break;
        end;

        LQSDatoLibero.Next;
      end;

      // se il dato libero non è quello atteso segnala anomalia
      if not Result.Ok then
      begin
        TLogger.Error(Format('Accesso non consentito: il dato %s non corrisponde al valore previsto in nessuna storicizzazione del periodo',[LDato]));

        // differenzia il messaggio di errore in base al progressivo di accesso
        if Parametri.ProgressivoOper = PProgressivo then
          Result.Messaggio:=A000TraduzioneStringhe(A000MSG_W044_ERR_ABILITAZIONE_TICKET_UTENTE)
        else
          Result.Messaggio:=A000TraduzioneStringhe(A000MSG_W044_ERR_ABILITAZIONE_TICKET_ALTRO);
        Exit;
      end;
    finally
      FreeAndNil(LQSDatoLibero);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

function TRegolaTicket.IsDateInRangeConsentito: Boolean;
begin
  // se non è indicato un range di validità restituisce immediatamente true
  if (RichiestaGGDal = 0) and (RichiestaGGAl = 0) then
    Result:=True
  else
    Result:=R180Between(Date.Day,RichiestaGGDal,RichiestaGGAl);
end;

end.
