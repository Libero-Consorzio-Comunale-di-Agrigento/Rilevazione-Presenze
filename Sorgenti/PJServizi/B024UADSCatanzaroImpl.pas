{ Invokable implementation File for TB024ServiceName which implements IB024ServiceName }

unit B024UADSCatanzaroImpl;

interface

uses
  A000UCostanti,
  A000USessione,
  B024UADSCatanzaroIntf,
  B024UADSCatanzaroDM,
  FunzioniGenerali,
  C180FunzioniGenerali,
  Oracle,
  OracleData,
  IdSoapIntfRegistry,
  IdSoapTypeRegistry,
  System.SysUtils,
  System.Variants,
  System.StrUtils,
  IdSoapDateTime;

type

  { TB024ServiceName }
  TB024FADSCatanzaroImpl = class(TIdSoapBaseImplementation, IProfilazioneUtente)
    FSessioneOracle: TOracleSession;
    procedure EseguiOperazioniIniziali;
    function getListaApplicativiUtente(filtri : listaApplicativiUtenteGetRequest) : listaApplicativiUtenteGetResponseArray; stdcall;
    procedure getListaUnita(filtri : listaUnitaRequest; out unita : listaUnitaResponseArray); stdcall;
    procedure getListaRuoli(filtri : listaRuoliRequest; out ruolo : listaRuoliResponseArray); stdcall;
    procedure getAbilitazioniSoggetto(filtri : abilitazioniSoggettoGetRequest; out abilitazione : abilitazioniSoggettoGetResponseArray); stdcall;
    procedure setAbilitazioniSoggetto(abilitazione: abilitazioniSoggettoSetRequest); stdcall;
    procedure modificaAnagrafica(oldSoggetto: WSSoggetto; newSoggetto: WSSoggetto); stdcall;
  end;

const
  COMPONENTE_IRISWEB   = 'IRISWEB';
  COMPONENTE_IRISCLOUD = 'IRISCLOUD';

  TIPOAUTORIZZAZIONE_ABILITA = 1;
  TIPOAUTORIZZAZIONE_REVOCA  = 0;

implementation

//uses
//  B024UWebModule;

{ TB024FADSCatanzaroImpl }

procedure TB024FADSCatanzaroImpl.EseguiOperazioniIniziali;
const
  NOME_METODO = 'TB024FADSCatanzaroImpl.EseguiOperazioniIniziali';
begin
  TLogger.EnterMethod(NOME_METODO);
  try
    TLogger.Debug(Format('Metodo eseguito sull''azienda %s del database %s',[GConfig.Database,GConfig.Azienda]));

    // impostazioni generali
    A000SettaVariabiliAmbiente;

    // estrae e salva la sessione oracle
    FSessioneOracle:=B024FADSCatanzaroDM.EstraiSessioneOracle(GConfig.Database,GConfig.Azienda);

    TLogger.Debug('Connessione al database effettuata.');
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;


// ########################################################################## //
// ###                      M E T O D I   E S P O S T I                       //
// ########################################################################## //

function TB024FADSCatanzaroImpl.getListaApplicativiUtente(filtri: listaApplicativiUtenteGetRequest): listaApplicativiUtenteGetResponseArray;
// restituisce l'elenco degli applicativi accessibili dall'utente indicato
//   estraendo i dati dalla tabella SISR_APPLICATIVI
// parametri
//   filtri.codiceAmministrazione
//     codice azienda di riferimento - ridondante (ignorato)
//   filtri.identificativoUtente
//     nome utente (= codice fiscale)
var
  i: Integer;
  LDS: TOracleDataset;
const
  NOME_METODO = 'TB024FADSCatanzaroImpl.getListaApplicativiUtente';
begin
  TLogger.EnterMethod(NOME_METODO);
  try
    EseguiOperazioniIniziali;

    TLogger.Debug(Format('Lettura lista applicativi disponibili per l''utente %s',[filtri.identificativoUtente]));

    // elenco applicativi cui l'utente è abilitato
    LDS:=TOracleDataSet.Create(nil);
    try
      try
        LDS.Session:=FSessioneOracle;
        LDS.SQL.Text:='select A.CODICE, A.DESCRIZIONE, A.URL        '#13#10 +
                      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060, '#13#10 +
                      '       SISR_APPLICATIVI A '#13#10 +
                      'where  I060.AZIENDA = :AZIENDA '#13#10 +
                      'and    I060.NOME_UTENTE = :UTENTE '#13#10 +
                      'and    A.CODICE = :COMP_IRISWEB '#13#10 +
                      'union all '#13#10 +
                      'select B.CODICE, B.DESCRIZIONE, B.URL '#13#10 +
                      'from   MONDOEDP.I070_UTENTI I070, '#13#10 +
                      '       SISR_APPLICATIVI B '#13#10 +
                      'where  I070.AZIENDA = :AZIENDA '#13#10 +
                      'and    I070.UTENTE = :UTENTE '#13#10 +
                      'and    B.CODICE = :COMP_IRISCLOUD '#13#10;
        LDS.DeclareAndSet('AZIENDA',otString,filtri.codiceAmministrazione);
        LDS.DeclareAndSet('UTENTE',otString,filtri.identificativoUtente);
        LDS.DeclareAndSet('COMP_IRISWEB',otString,COMPONENTE_IRISWEB);
        LDS.DeclareAndSet('COMP_IRISCLOUD',otString,COMPONENTE_IRISCLOUD);
        LDS.Open;
        TLogger.Debug('Numero applicativi disponibili',LDS.RecordCount);
        SetLength(Result,LDS.RecordCount);
        i:=0;
        while not LDS.Eof do
        begin
          Result[i]:=listaApplicativiUtenteGetResponse.Create;
          Result[i].codice:=LDS.FieldByName('CODICE').AsString;
          Result[i].descrizione:=LDS.FieldByName('DESCRIZIONE').AsString;
          Result[i].url:=LDS.FieldByName('URL').AsString;

          inc(i);
          LDS.Next;
        end;
      except
        SetLength(Result,0);
      end;
    finally
      FreeAndNil(LDS);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TB024FADSCatanzaroImpl.getListaUnita(filtri : listaUnitaRequest; out unita : listaUnitaResponseArray); stdcall;
// restituisce i filtri anagrafe dell'azienda impostata nel file .ini
// parametri
//   filtri.codiceAmministrazione
//     codice azienda di riferimento - ridondante (ignorato)
//   filtri.codiceruolo
//     ignorato
var
  i: Integer;
  LDS: TOracleDataset;
const
  NOME_METODO = 'TB024FADSCatanzaroImpl.getListaUnita';
begin
  TLogger.EnterMethod(NOME_METODO);
  try
    EseguiOperazioniIniziali;

    TLogger.Debug('Lettura lista unità organizzative (filtro anagrafe)');

    // elenco unità operative
    LDS:=TOracleDataSet.Create(nil);
    try
      LDS.Session:=FSessioneOracle;
      LDS.ReadBuffer:=500;
      LDS.SQL.Text:='select I072.PROFILO                       '#13#10 +
                    'from   MONDOEDP.I072_FILTROANAGRAFE I072  '#13#10 +
                    'where  I072.AZIENDA = :AZIENDA            '#13#10 +
                    'and    I072.PROGRESSIVO = 0               '#13#10 +
                    'order by 1                                '#13#10;
      LDS.DeclareAndSet('AZIENDA',otString,GConfig.Azienda);
      try
        LDS.Open;
        TLogger.Debug('Numero unità organizzative disponibili',LDS.RecordCount);
        SetLength(unita,LDS.RecordCount);
        LDS.First;
        i:=0;
        while not LDS.Eof do
        begin
          unita[i]:=listaUnitaResponse.Create;
          unita[i].codiceUnita:=LDS.FieldByName('PROFILO').AsString;
          unita[i].descrizioneUnita:='';

          inc(i);
          LDS.Next;
        end;
      except
        on E: Exception do
        begin
          TLogger.Error('Errore durante la lettura delle unità organizzative',E);
        end;
      end;
    finally
      FreeAndNil(LDS);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TB024FADSCatanzaroImpl.getListaRuoli(filtri : listaRuoliRequest; out ruolo : listaRuoliResponseArray);
// restituisce i filtri funzione dell'azienda impostata nel file .ini,
//   filtrati in base al codice componente indicato
// parametri
//   filtri.codiceComponente
//     codice del componente: COMPONENTE_IRISWEB / COMPONENTE_IRISCLOUD
var
  i: Integer;
  LDS: TOracleDataset;
const
  NOME_METODO = 'TB024FADSCatanzaroImpl.getListaRuoli';
begin
  TLogger.EnterMethod(NOME_METODO);
  try
    EseguiOperazioniIniziali;

    if filtri.codiceComponente = COMPONENTE_IRISWEB then
    begin
      // ...
      LDS:=TOracleDataSet.Create(nil);
      try
        LDS.Session:=FSessioneOracle;
        LDS.ReadBuffer:=1000;
        LDS.SQL.Text:='select distinct I073.PROFILO              '#13#10 +
                      'from   MONDOEDP.I073_FILTROFUNZIONI I073  '#13#10 +
                      'where  I073.AZIENDA = :AZIENDA            '#13#10 +
                      //'and    I073.APPLICAZIONE = :APPLICAZIONE  '#13#10 +
                      'order by 1                                '#13#10;
        LDS.DeclareAndSet('AZIENDA',otString,GConfig.Azienda);
        try
          LDS.Open;
          TLogger.Debug('Numero ruoli disponibili',LDS.RecordCount);
          SetLength(ruolo,LDS.RecordCount);
          i:=0;
          LDS.First;
          while not LDS.Eof do
          begin
            ruolo[i]:=listaRuoliResponse.Create;
            ruolo[i].codiceRuolo:=LDS.FieldByName('PROFILO').AsString;
            ruolo[i].descrizioneRuolo:='';
            ruolo[i].areeAccessibili:='';

            inc(i);
            LDS.Next;
          end;
        except
          on E: Exception do
          begin
            TLogger.Error('Errore durante la lettura dei ruoli',E);
          end;
        end;
      finally
        FreeAndNil(LDS);
      end;
    end
    else if filtri.codiceComponente = COMPONENTE_IRISCLOUD then
    begin
      // elenco filtri funzione
      LDS:=TOracleDataSet.Create(nil);
      try
        LDS.Session:=FSessioneOracle;
        LDS.ReadBuffer:=1000;
        LDS.SQL.Text:='select distinct I073.PROFILO              '#13#10 +
                      'from   MONDOEDP.I073_FILTROFUNZIONI I073  '#13#10 +
                      'where  I073.AZIENDA = :AZIENDA            '#13#10 +
                      //'and    I073.APPLICAZIONE = :APPLICAZIONE  '#13#10 +
                      'order by 1                                '#13#10;
        LDS.DeclareAndSet('AZIENDA',otString,GConfig.Azienda);
        LDS.Open;
        SetLength(ruolo,LDS.RecordCount);
        i:=0;
        LDS.First;
        while not LDS.Eof do
        begin
          ruolo[i]:=listaRuoliResponse.Create;
          ruolo[i].codiceRuolo:=LDS.FieldByName('NOME_PROFILO').AsString;
          ruolo[i].descrizioneRuolo:='';
          ruolo[i].areeAccessibili:='';

          inc(i);
          LDS.Next;
        end;
      finally
        FreeAndNil(LDS);
      end;
    end
    else
    begin
      raise Exception.CreateFmt('Il codice componente indicato è inesistente: %s',[filtri.codiceComponente]);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TB024FADSCatanzaroImpl.getAbilitazioniSoggetto(filtri : abilitazioniSoggettoGetRequest; out abilitazione : abilitazioniSoggettoGetResponseArray);
// restituisce l'elenco delle abilitazioni per l'utente indicato,
//   filtrato in base al codice componente indicato
// parametri
//   filtri.codFiscaleSoggettoDaAbilitare
//     nome utente (= codice fiscale)
//   filtri.codiceAmministrazione
//     codice azienda di riferimento - ridondante (ignorato)
// filtri.codiceComponente
// filtri.codiceSistema
var
  i: Integer;
  LDS: TOracleDataset;
const
  NOME_METODO = 'TB024FADSCatanzaroImpl.getAbilitazioniSoggetto';
begin
  TLogger.EnterMethod(NOME_METODO);
  try
    EseguiOperazioniIniziali;

    TLogger.Debug(Format('Lettura abilitazioni %s per l''utente %s',[filtri.codiceComponente,filtri.codFiscaleSoggettoDaAbilitare]));
    if filtri.codiceComponente = COMPONENTE_IRISWEB then
    begin
      // elenco info I061
      LDS:=TOracleDataSet.Create(nil);
      try
        LDS.Session:=FSessioneOracle;
        LDS.SQL.Text:='select distinct I061.FILTRO_FUNZIONI, I061.FILTRO_ANAGRAFE, I061.INIZIO_VALIDITA, I061.FINE_VALIDITA '#13#10 +
                      'from   MONDOEDP.I061_PROFILI_DIPENDENTE I061 '#13#10 +
                      'where  I061.AZIENDA = :AZIENDA '#13#10 +
                      'and    I061.NOME_UTENTE = :UTENTE '#13#10 +
                      'and    trunc(sysdate) between I061.INIZIO_VALIDITA and I061.FINE_VALIDITA '#13#10 +
                      'order by 1';
        LDS.DeclareAndSet('AZIENDA',otString,GConfig.Azienda);
        LDS.DeclareAndSet('UTENTE',otString,filtri.codFiscaleSoggettoDaAbilitare);
        try
          LDS.Open;
          TLogger.Debug(Format('Numero abilitazioni disponibili oggi %s',[Date.ToString]),LDS.RecordCount);
          SetLength(abilitazione,LDS.RecordCount);
          i:=0;
          LDS.First;
          while not LDS.Eof do
          begin
            abilitazione[i]:=abilitazioniSoggettoGetResponse.Create;
            abilitazione[i].codiceRuolo:=LDS.FieldByName('FILTRO_FUNZIONI').AsString;
            abilitazione[i].descrizioneRuolo:='';
            abilitazione[i].codiceTipoAutorizzazione:=1;
            abilitazione[i].codiceUnita:=LDS.FieldByName('FILTRO_ANAGRAFE').AsString;
            abilitazione[i].descrizioneUnita:='';
            abilitazione[i].dataDecorrenza:=TIdSoapDateTime.Create;
            abilitazione[i].dataDecorrenza.AsDateTime:=LDS.FieldByName('INIZIO_VALIDITA').AsDateTime;
            abilitazione[i].dataScadenza:=TIdSoapDateTime.Create;
            abilitazione[i].dataScadenza.AsDateTime:=LDS.FieldByName('FINE_VALIDITA').AsDateTime;

            inc(i);
            LDS.Next;
          end;
        except
          on E: Exception do
          begin
            TLogger.Error(Format('Errore durante la lettura delle abilitazioni dell''utente %s',[filtri.codFiscaleSoggettoDaAbilitare]),E);
          end;
        end;
      finally
        FreeAndNil(LDS);
      end;
    end
    else if filtri.codiceComponente = COMPONENTE_IRISCLOUD then
    begin
      // elenco info I070
      LDS:=TOracleDataSet.Create(nil);
      try
        LDS.Session:=FSessioneOracle;
        LDS.ReadBuffer:=2;
        LDS.SQL.Text:='select I070.FILTRO_FUNZIONI, I070.FILTRO_ANAGRAFE '#13#10 +
                      'from   MONDOEDP.I070_UTENTI I070 '#13#10 +
                      'where  I070.AZIENDA = :AZIENDA '#13#10 +
                      'and    I070.UTENTE = :UTENTE '#13#10 +
                      'order by 1 ';
        LDS.DeclareAndSet('AZIENDA',otString,GConfig.Azienda);
        LDS.DeclareAndSet('UTENTE',otString,filtri.codFiscaleSoggettoDaAbilitare);
        try
          LDS.Open;
          TLogger.Debug(Format('Numero abilitazioni disponibili oggi %d',[Date.ToString]),LDS.RecordCount);
          SetLength(abilitazione,LDS.RecordCount);
          i:=0;
          LDS.First;
          if not LDS.Eof then
          begin
            abilitazione[i]:=abilitazioniSoggettoGetResponse.Create;
            abilitazione[i].codiceRuolo:=LDS.FieldByName('FILTRO_FUNZIONI').AsString;
            abilitazione[i].descrizioneRuolo:='';
            abilitazione[i].codiceTipoAutorizzazione:=1;
            abilitazione[i].codiceUnita:=LDS.FieldByName('FILTRO_ANAGRAFE').AsString;
            abilitazione[i].descrizioneUnita:='';
            abilitazione[i].dataDecorrenza:=TIdSoapDateTime.Create;
            abilitazione[i].dataDecorrenza.AsDateTime:=DATE_MIN;
            abilitazione[i].dataScadenza:=TIdSoapDateTime.Create;
            abilitazione[i].dataScadenza.AsDateTime:=DATE_MAX;
          end;
        except
          on E: Exception do
          begin
            TLogger.Error(Format('Errore durante la lettura delle abilitazioni dell''utente %s',[filtri.codFiscaleSoggettoDaAbilitare]),E);
          end;
        end;
      finally
        FreeAndNil(LDS);
      end;
    end
    else
    begin
      raise Exception.CreateFmt('Il codice componente indicato è inesistente: %s',[filtri.codiceComponente]);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TB024FADSCatanzaroImpl.setAbilitazioniSoggetto(abilitazione: abilitazioniSoggettoSetRequest);
//   filtri.codiceAmministrazione
//     codice azienda di riferimento - ridondante (ignorato)
{
      codiceFiscale: nome_utente di I070 / I060 (a seconda del componente)
      email: I060.EMAIL (se componente = IrisWEB)
      telefono: I060.CELLULARE (se componente = IrisWEB)
       codiceAmministrazione:    (ignorato)
       codiceSistema:                 (ignorato)
       codiceComponente:         (IrisWEB / IrisCloud)
       codiceRuolo:                   (filtroFunzioni)
       codiceUnita:                    (filtroAnagrafe)
       codiceTipoAutorizzazione: (0 = revocato,  1 = abilitato)
       dataDecorrenzaORevoca:  (I061.INIZIO_VALIDITA / FINE_VALIDITA)
}
var
  LDS: TOracleDataset;
  LOperazione: String;
  LFmt: TFormatSettings;
  LDataDecorrenzaORevoca: TDateTime;
const
  NOME_METODO = 'TB024FADSCatanzaroImpl.setAbilitazioniSoggetto';
begin
  TLogger.EnterMethod(NOME_METODO);
  try
    EseguiOperazioniIniziali;

    LOperazione:=IfThen(abilitazione.profilo.codiceTipoAutorizzazione = TIPOAUTORIZZAZIONE_ABILITA,'abilitazione','revoca');
    TLogger.Debug(Format('%s ruolo %s per l''utente %s',[LOperazione,abilitazione.profilo.codiceRuolo,abilitazione.codiceFiscale]));

    // converte data abilitazione / revoca
    LFmt:=TFormatSettings.Create;
    LFmt.DateSeparator:='-';
    LFmt.ShortDateFormat:='yyyy-mm-dd';
    if not TryStrToDate(abilitazione.profilo.dataDecorrenzaORevoca,LDataDecorrenzaORevoca,LFmt) then
      raise Exception.CreateFmt('Data %s profilo non valida: %s',[LOperazione,abilitazione.profilo.dataDecorrenzaORevoca]);

    if abilitazione.profilo.codiceComponente = COMPONENTE_IRISWEB then
    begin
      // verifica esistenza abilitazione
      LDS:=TOracleDataSet.Create(nil);
      try
        try
          LDS.CommitOnPost:=False;
          LDS.Session:=FSessioneOracle;
          LDS.SQL.Text:='select I061.*, I061.ROWID                                                 '#13#10 +
                        'from   MONDOEDP.I061_PROFILI_DIPENDENTE I061                              '#13#10 +
                        'where  I061.AZIENDA = :AZIENDA                                            '#13#10 +
                        'and    I061.NOME_UTENTE = :UTENTE                                         '#13#10 +
                        'and    I061.FILTRO_FUNZIONI = :RUOLO                                      '#13#10 +
                        'and    trunc(sysdate) between I061.INIZIO_VALIDITA and I061.FINE_VALIDITA '#13#10;
          LDS.DeclareAndSet('AZIENDA',otString,GConfig.Azienda);
          LDS.DeclareAndSet('UTENTE',otString,abilitazione.codiceFiscale);
          LDS.DeclareAndSet('RUOLO',otString,abilitazione.profilo.codiceRuolo);
          LDS.Open;
          if abilitazione.profilo.codiceTipoAutorizzazione = TIPOAUTORIZZAZIONE_ABILITA then
          begin
            if LDS.RecordCount = 0 then
            begin
              LDS.Append;
              LDS.FieldByName('AZIENDA').AsString:=GConfig.Azienda;
              lds.FieldByName('NOME_UTENTE').AsString:=abilitazione.codiceFiscale;
              LDS.FieldByName('NOME_PROFILO').AsString:=abilitazione.profilo.codiceRuolo;
              //LDS.FieldByName('PERMESSI').AsString:=???;
              LDS.FieldByName('FILTRO_FUNZIONI').AsString:=abilitazione.profilo.codiceRuolo;
              LDS.FieldByName('FILTRO_ANAGRAFE').AsString:=abilitazione.profilo.codiceUnita;
              //LDS.FieldByName('FILTRO_DIZIONARIO').AsString:=???;
              LDS.FieldByName('INIZIO_VALIDITA').AsDateTime:=LDataDecorrenzaORevoca;
              LDS.FieldByName('FINE_VALIDITA').AsDateTime:=DATE_MAX;
              //LDS.FieldByName('DELEGATO_DA').AsString:='';
              //LDS.FieldByName('ULTIMO_ACCESSO').Value:=null;
              //LDS.FieldByName('ULTIMO_INVIO_MAIL').Value:=null;
              //LDS.FieldByName('ITER_AUTORIZZATIVI').AsString:=???;
              //LDS.FieldByName('RICEZIONE_MAIL').AsString:='S';
              //LDS.FieldByName('LOGIN_DEFAULT').AsString:=???;
              //LDS.FieldByName('PROFILO_DELEGATO').AsString:='';
              //LDS.FieldByName('DELEGA_INSERITA_DA').AsString:='';
              //LDS.FieldByName('AUTO_ESCLUSIONE').AsString:=???;
              LDS.Post;
            end
            else
            begin
              // se necessario aggiorna l'inizio validità
              LDS.Edit;
              LDS.FieldByName('INIZIO_VALIDITA').AsDateTime:=LDataDecorrenzaORevoca;
              LDS.FieldByName('FINE_VALIDITA').AsDateTime:=DATE_MAX;
              LDS.Post;
            end;
          end
          else
          begin
            // revoca
            // imposta la fine abilitazione
            if LDS.RecordCount > 0 then
            begin
              LDS.Edit;
              LDS.FieldByName('FINE_VALIDITA').AsDateTime:=LDataDecorrenzaORevoca;
              LDS.Post;
            end;
          end;
          FSessioneOracle.Commit;
        except
          on E: Exception do
          begin
            TLogger.Error(Format('Errore in fase di %s profilo %s',[LOperazione,abilitazione.profilo.codiceComponente]),E);
            FSessioneOracle.Rollback;
          end;
        end;
      finally
        FreeAndNil(LDS);
      end;
    end
    else if abilitazione.profilo.codiceComponente = COMPONENTE_IRISCLOUD then
    begin
      // inserimento o modifica in base all'esistenza dell'utente (codice fiscale) su I070
      //   FILTRO_FUNZIONI = codiceRuolo
      //   FILTRO_ANAGRAFE = codiceUnita
      //   ACCESSO_NEGATO  = decode(TipoAutorizzazione, 0,'N', 1,'S')

      // verifica esistenza abilitazione
      LDS:=TOracleDataSet.Create(nil);
      try
        try
          LDS.CommitOnPost:=False;
          LDS.Session:=FSessioneOracle;
          LDS.ReadBuffer:=2;
          LDS.SQL.Text:='select I070.*, I070.ROWID         '#13#10 +
                        'from   MONDOEDP.I070_UTENTI I070  '#13#10 +
                        'where  I070.AZIENDA = :AZIENDA    '#13#10 +
                        'and    I070.UTENTE = :UTENTE      '#13#10;
          LDS.DeclareAndSet('AZIENDA',otString,GConfig.Azienda);
          LDS.DeclareAndSet('UTENTE',otString,abilitazione.codiceFiscale);
          LDS.Open;
          if abilitazione.profilo.codiceTipoAutorizzazione = TIPOAUTORIZZAZIONE_ABILITA then
          begin
            if LDS.RecordCount = 0 then
            begin
              LDS.Append;
              LDS.FieldByName('AZIENDA').AsString:=GConfig.Azienda;
              LDS.FieldByName('UTENTE').AsString:=abilitazione.codiceFiscale;
              //LDS.FieldByName('PROGRESSIVO').AsInteger:=???;
              //LDS.FieldByName('PASSWD').AsString:=???;
              //LDS.FieldByName('OCCUPATO').AsString:=???;
              //LDS.FieldByName('SBLOCCO').AsString:=???;
              //LDS.FieldByName('INTEGRAZIONEANAGRAFE').AsString:=???;
              //LDS.FieldByName('PERMESSI').AsString:=???;
              LDS.FieldByName('FILTRO_ANAGRAFE').AsString:=abilitazione.profilo.codiceUnita;
              LDS.FieldByName('FILTRO_FUNZIONI').AsString:=abilitazione.profilo.codiceRuolo;
              //LDS.FieldByName('FILTRO_DIZIONARIO').AsString:=???;
              //LDS.FieldByName('DATA_PW').AsDateTime:=???;
              //LDS.FieldByName('NUOVA_PASSWORD').AsString:='';
              //LDS.FieldByName('DATA_ACCESSO').AsDateTime:=???;
              LDS.FieldByName('ACCESSO_NEGATO').AsString:='N';
              //LDS.FieldByName('VALIDITA_CESSATI').AsString:=???;
              //LDS.FieldByName('T030_PROGRESSIVO').AsInteger:=???;
              LDS.Post;
            end
            else
            begin
              // l'utente è già abilitato: nessuna operazione
            end;
          end
          else
          begin
            // revoca -> imposta ACCESSO_NEGATO
            if LDS.RecordCount > 0 then
            begin
              LDS.Edit;
              LDS.FieldByName('ACCESSO_NEGATO').AsString:='S';
              LDS.Post;
            end;
          end;
          FSessioneOracle.Commit;
        except
          on E: Exception do
          begin
            TLogger.Error(Format('Errore in fase di %s profilo %s',[LOperazione,abilitazione.profilo.codiceComponente]),E);
            FSessioneOracle.Rollback;
          end;
        end;
      finally
        FreeAndNil(LDS);
      end;
    end
    else
    begin
      raise Exception.CreateFmt('Il codice componente indicato è inesistente: %s',[abilitazione.profilo.codiceComponente]);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

procedure TB024FADSCatanzaroImpl.modificaAnagrafica(oldSoggetto, newSoggetto: WSSoggetto);
// modifica i dati email e cellulare su tabella I060
//   in caso di utente web (oldSoggetto.codiceFiscale) presente
// non effettua nessuna operazione in tutti gli altri casi
var
  LDS: TOracleDataset;
const
  NOME_METODO = 'TB024FADSCatanzaroImpl.modificaAnagrafica';
begin
  TLogger.EnterMethod(NOME_METODO);
  try
    EseguiOperazioniIniziali;

    LDS:=TOracleDataSet.Create(nil);
    try
      try
        // ricerca l'utente web da aggiornare
        LDS.CommitOnPost:=False;
        LDS.Session:=FSessioneOracle;
        LDS.ReadBuffer:=5;
        LDS.SQL.Text:='select I060.EMAIL, I060.CELLULARE, I060.ROWID '#13#10 +
                      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060    '#13#10 +
                      'where  I060.AZIENDA = :AZIENDA                '#13#10 +
                      'and    I060.NOME_UTENTE = :UTENTE             '#13#10;
        LDS.DeclareAndSet('AZIENDA',otString,GConfig.Azienda);
        LDS.DeclareAndSet('UTENTE',otString,oldSoggetto.codiceFiscale);
        LDS.Open;
        if LDS.RecordCount > 0 then
        begin
          LDS.Edit;
          LDS.FieldByName('EMAIL').AsString:=newSoggetto.email;
          LDS.FieldByName('CELLULARE').AsString:=newSoggetto.telefono;
          LDS.Post;
          FSessioneOracle.Commit;
        end;

        // utente cloud -> ignorato: nessuna modifica effettuabile
      except
        on E: Exception do
        begin
          TLogger.Error(Format('Errore in fase di aggiornamento dati anagrafici dell''utente %s',[oldSoggetto.codiceFiscale]),E);
          FSessioneOracle.Rollback;
        end;
      end;
    finally
      FreeAndNil(LDS);
    end;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

initialization
  // registra interfaccia
  IdSoapRegisterInterfaceClass('IProfilazioneUtente', TypeInfo(TB024FADSCatanzaroImpl), TB024FADSCatanzaroImpl);

  // configura il logger
  TLogger.Configure(TLogOptions.Create('server B024',GConfig.FileLog,GConfig.LiveViewLog,R180GetPathLog));

end.

