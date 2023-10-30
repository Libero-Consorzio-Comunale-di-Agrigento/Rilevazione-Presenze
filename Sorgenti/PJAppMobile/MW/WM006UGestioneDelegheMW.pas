unit WM006UGestioneDelegheMW;

interface

uses
  A000UCostanti,
  A000Versione,
  A000USessione,
  B110USharedTypes,
  C200UWebServicesTypes,
  B110UClientModule,
  FunzioniGenerali,
  SysUtils,
  Classes, WM000UConstants, WM006UGestioneDelegheDM,  Oracle,
  OracleData,
  Generics.Collections,
  StrUtils;

type

  TWM006FGestioneDelegheMW = class(TObject)
    private
      WM006DM: TWM006FGestioneDelegheDM;

      FUtenteDelegante: TUtenteDelegante;
      FDelegaInModifica: TDelega;
      FRowIdDelegaEsistente: String;  //da usare nel caso sia necessario eliminare una delega esistente in caso di inserimento/modifica
      FListaDeleghe: TObjectList<TDelega>;
      FListaUtentiFiltrati: TObjectList<TUtenteDelegato>;
      FC90_FiltroDeleghe: String;
      FC90_NomeProfiloDelega: String;

      function GetFiltroUtentiDelegabili(PFiltroCognome, PFiltroMatricola, PFiltroUtente: String): String;
      function GetListaVariabiliFiltroPersonalizzate: TObjectList<TVarPers>;
    public
      property ListaDeleghe: TObjectList<TDelega> read FListaDeleghe;
      property ListaUtenti: TObjectList<TUtenteDelegato> read FListaUtentiFiltrati;
      property DelegaInModifica: TDelega read FDelegaInModifica;
      property UtenteDelegante: TUtenteDelegante read FUtenteDelegante;
      property C90_FiltroDeleghe: String read FC90_FiltroDeleghe;
      property C90_NomeProfiloDelega: String read FC90_NomeProfiloDelega;

      constructor Create(PSessioneIrisWin: TSessioneIrisWin);
      destructor Destroy; override;

      procedure AggiornaListaDeleghe(PAzienda, PUtente: String);
      procedure AggiornaListaUtenti(PFiltroCognome, PFiltroMatricola, PFiltroUtente: String);
      function GetProfiloDefault(PSessioneOracle: TOracleSession; PUtenteDelegato: String; PInizioValidita, PFineValidita: TDateTime): String;
      function SelezionaDelegaInModifica(PId: String): Boolean;
      function ModificaDelega(PProfilo: String; PInizioValidita, PFineValidita: TDateTime; PAutoEsclusione: Boolean): TResCtrl;
      function InserisciDelega(PUtenteDelegato, PProfilo: String; PInizioValidita, PFineValidita: TDateTime; PAutoEsclusione: Boolean): TResCtrl;
      function EliminaDelegaInModifica: TResCtrl;
      function EliminaDelegaEsistente: TResCtrl;
      function ControlliInserimentoOK(PUtenteDelegato, PProfilo: String; PDataDal, PDataAl: TDateTime): TResCtrl;
      function ControlliModificaOK(PUtenteDelegato, PProfilo: String; PDataDal, PDataAl: TDateTime): TResCtrl;
    end;

implementation

{ TWM006FGestioneDelegheMW }

constructor TWM006FGestioneDelegheMW.Create(PSessioneIrisWin: TSessioneIrisWin);
begin
  inherited Create;

  if not PSessioneIrisWin.SessioneOracle.Connected then
    raise Exception.Create('Sessione Oracle non connessa');

  WM006DM:=TWM006FGestioneDelegheDM.Create(PSessioneIrisWin);

  FListaDeleghe:=TObjectList<TDelega>.Create(True);
  FListaUtentiFiltrati:=TObjectList<TUtenteDelegato>.Create(True);

  with PSessioneIrisWin.Parametri do
  begin
    FDelegaInModifica:=nil;
    FRowIdDelegaEsistente:='';
    FC90_FiltroDeleghe:=CampiRiferimento.C90_FiltroDeleghe;
    FC90_NomeProfiloDelega:=CampiRiferimento.C90_NomeProfiloDelega;
    FUtenteDelegante:=WM006DM.GetUtenteDelegante(Azienda, ProgressivoOper, MatricolaOper, Operatore, ProfiloWEB);
  end;
end;

destructor TWM006FGestioneDelegheMW.Destroy;
begin
  FreeAndNil(WM006DM);
  FreeAndNil(FUtenteDelegante);
  FreeAndNil(FListaDeleghe);
  FreeAndNil(FListaUtentiFiltrati);
  inherited;
end;

procedure TWM006FGestioneDelegheMW.AggiornaListaUtenti(PFiltroCognome, PFiltroMatricola, PFiltroUtente: String);
var LFiltroUtentiDelegabili: String;
    LVarPersonalizzate: TObjectList<TVarPers>;
begin
  FreeAndNil(FListaUtentiFiltrati);

  try
    LFiltroUtentiDelegabili:=GetFiltroUtentiDelegabili(PFiltroCognome, PFiltroMatricola, PFiltroUtente);
    LVarPersonalizzate:=GetListaVariabiliFiltroPersonalizzate;

    FListaUtentiFiltrati:=WM006DM.GetListaUtentiDelegabili(FUtenteDelegante.Azienda, FUtenteDelegante.Utente, LFiltroUtentiDelegabili, FC90_FiltroDeleghe, LVarPersonalizzate);
  finally
    FreeAndNil(LVarPersonalizzate);
  end;
end;

procedure TWM006FGestioneDelegheMW.AggiornaListaDeleghe(PAzienda, PUtente: String);
begin
  FreeAndNil(FListaDeleghe);

  FListaDeleghe:=WM006DM.GetListaDeleghe(PAzienda, Putente);
end;

//questo è brutto ma per il momento rimane come l'ho copiato da irisweb
function TWM006FGestioneDelegheMW.GetProfiloDefault(PSessioneOracle: TOracleSession; PUtenteDelegato: String; PInizioValidita, PFineValidita: TDateTime): String;
var ODS: TOracleDataset;
begin
  // determina il profilo da proporre in fase di inserimento
  if FC90_NomeProfiloDelega = '' then
    Result:=FUtenteDelegante.ProfiloDelegato
  else
  begin
    Result:=FC90_NomeProfiloDelega;
    ODS:=TOracleDataSet.Create(nil);
    try
      try
        ODS.Session:=PSessioneOracle;

        // stringa da estrarre
        ODS.DeclareVariable('S',otSubst);
        ODS.SetVariable('S',Result);

        // delegante
        if Pos(':DELEGANTE',Result) > 0 then
        begin
          ODS.DeclareVariable('DELEGANTE',otString);
          ODS.SetVariable('DELEGANTE',FUtenteDelegante.DelegatoDa);
        end;
        // delegato
        if Pos(':DELEGATO',Result) > 0 then
        begin
          ODS.DeclareVariable('DELEGATO',otString);
          ODS.SetVariable('DELEGATO',PUtenteDelegato);
        end;
        // profilo
        if Pos(':PROFILO',Result) > 0 then
        begin
          ODS.DeclareVariable('PROFILO',otString);
          ODS.SetVariable('PROFILO',FUtenteDelegante.ProfiloDelegato);
        end;
        // dal
        if Pos(':DAL',Result) > 0 then
        begin
          ODS.DeclareVariable('DAL',otDate);
          ODS.SetVariable('DAL',PInizioValidita);
        end;
        // al
        if Pos(':AL',Result) > 0 then
        begin
          ODS.DeclareVariable('AL',otDate);
          ODS.SetVariable('AL', PFineValidita);
        end;
        ODS.SQL.Add('select :S from DUAL');
        ODS.Open;
        if ODS.RecordCount > 0 then
          Result:=ODS.Fields[0].AsString;
        ODS.Close;
        Result:=Copy(Result,1,30);
      except
        on E:Exception do
        begin
          Result:=FUtenteDelegante.Profilo
        end;
      end;
    finally
      FreeAndNil(ODS);
    end;
  end;
end;

function TWM006FGestioneDelegheMW.SelezionaDelegaInModifica(PId: String): Boolean;
var tempDelega: TDelega;
begin
  for tempDelega in FListaDeleghe do
    if tempDelega.Id = PId then
      FDelegaInModifica:=tempDelega;

  Result:=Assigned(FDelegaInModifica);
end;

function TWM006FGestioneDelegheMW.ModificaDelega(PProfilo: String; PInizioValidita, PFineValidita: TDateTime; PAutoEsclusione: Boolean): TResCtrl;
begin
  Result.Clear;

  if Assigned(DelegaInModifica) then
  begin
    try
      WM006DM.ModificaDelega(DelegaInModifica.Id, PInizioValidita, PFineValidita, PAutoEsclusione);
      Result.Ok:=True;
    except
      on e: Exception do
      begin
        Result.Ok:=False;
        Result.Messaggio:='Modifica della delega esistente fallita: ' + e.Message;
      end;
    end;
  end
  else
    Result.Messaggio:='Delega da modificare non trovata.';
end;

function TWM006FGestioneDelegheMW.InserisciDelega(PUtenteDelegato,PProfilo: String; PInizioValidita, PFineValidita: TDateTime; PAutoEsclusione: Boolean): TResCtrl;
begin
  Result.Clear;

  try
    WM006DM.InserisciDelega(FUtenteDelegante, PUtenteDelegato, PProfilo, PInizioValidita, PFineValidita, PAutoEsclusione);
    Result.Ok:=True;
  except
    on e: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:='Inserimento della delega fallito: ' + e.Message;
    end;
  end;
end;

function TWM006FGestioneDelegheMW.EliminaDelegaInModifica: TResCtrl;
begin
  Result.Clear;

  if Assigned(DelegaInModifica) then
  begin
    if DelegaInModifica.UltimoAccesso <> DATE_NULL then
    begin
      Result.Messaggio:=Format('Impossibile eliminare la delega selezionata in quanto l''utente delegato ha già effettuato accessi con tale profilo. Ultimo accesso effettuato: %s', [DelegaInModifica.UltimoAccesso]);
    end
    else
    begin
      try
        WM006DM.EliminaDelegaUtente(DelegaInModifica.Id);
        Result.Ok:=True;
      except
        on e: Exception do
        begin
          Result.Ok:=False;
          Result.Messaggio:='Cancellazione della delega in modifica fallita: ' + e.Message;
        end;
      end;
    end;
  end
  else
    Result.Messaggio:='Delega in modifica da eliminare non trovata.';
end;

function TWM006FGestioneDelegheMW.EliminaDelegaEsistente: TResCtrl;
begin
  Result.Clear;

  if FRowIdDelegaEsistente <> '' then
  begin
    try
      WM006DM.EliminaDelegaEsistente(FRowIdDelegaEsistente);
      Result.Ok:=True;
    except
      on e: Exception do
      begin
        Result.Ok:=False;
        Result.Messaggio:='Cancellazione della delega esistente fallita: ' + e.Message;
      end;
    end;
  end
  else
    Result.Messaggio:='Delega esistente da eliminare non trovata.';
end;

function TWM006FGestioneDelegheMW.GetFiltroUtentiDelegabili(PFiltroCognome, PFiltroMatricola, PFiltroUtente: String): String;
var LOperatore: String;
begin
  Result:='';
  // prepara il filtro su cognome, matricola e username (filtri in "or")
  if Trim(PFiltroCognome) <> '' then
  begin
    LOperatore:=IfThen(Pos('%',PFiltroCognome) > 0,'LIKE','=');
    Result:=Format('(upper(T030.COGNOME) %s upper(''%s''))',[LOperatore,PFiltroCognome]);
  end;
  if Trim(PFiltroMatricola) <> '' then
  begin
    LOperatore:=IfThen(Pos('%',PFiltroMatricola) > 0,'LIKE','=');
    Result:=IfThen(Result <> '',Result + ' OR ') +
            Format('(upper(I060.MATRICOLA) %s upper(''%s''))',[LOperatore,PFiltroMatricola]);
  end;
  if Trim(PFiltroUtente) <> '' then
  begin
    LOperatore:=IfThen(Pos('%',PFiltroUtente) > 0,'LIKE','=');
    Result:=IfThen(Result <> '',Result + ' OR ') +
            Format('(upper(I060.NOME_UTENTE) %s upper(''%s''))',[LOperatore,PFiltroUtente]);
  end;
  Result:=IfThen(Result <> '','AND (' + Result + ')');
end;

function TWM006FGestioneDelegheMW.GetListaVariabiliFiltroPersonalizzate: TObjectList<TVarPers>;
begin
  Result:=TObjectList<TVarPers>.Create(True);// prepara la lista di variabili

  if FC90_FiltroDeleghe <> '' then
  begin
    with Result do
    begin
      Add(TVarPers.Create('PROGRESSIVO',otInteger, FUtenteDelegante.Progressivo));
      Add(TVarPers.Create('MATRICOLA',otString, FUtenteDelegante.Matricola));
      Add(TVarPers.Create('NOME_UTENTE',otString, FUtenteDelegante.Utente));
      Add(TVarPers.Create('NOME_PROFILO',otString, FUtenteDelegante.Profilo));
      Add(TVarPers.Create('DELEGATO',otString, FUtenteDelegante.ProfiloDelegato));
    end;
  end;
end;

function TWM006FGestioneDelegheMW.ControlliInserimentoOK(PUtenteDelegato, PProfilo: String; PDataDal, PDataAl: TDateTime): TResCtrl;
// Controlli per la validazione dell'inserimento
var
  OldDataDal, OldDataAl: TDateTime;
  LNumDeleghe: Integer;
begin
  Result.Clear;

  if PUtenteDelegato = '' then
  begin
    Result.Messaggio:='Selezionare l''utente cui si desidera delegare il proprio profilo!';
    Exit;
  end;

  // profilo rinominato
  if Trim(PProfilo) = '' then
  begin
    Result.Messaggio:='Specificare il nome del profilo da assegnare al delegato! Nota: è possibile mantenere il nome del profilo originale.';
    Exit;
  end;

  // cerca il profilo tra quelli disponibili nell'azienda (che potrebbe essere stato digitato a mano)
  PProfilo:=WM006DM.GetProfiloAssegnato(FUtenteDelegante.Azienda, PProfilo);

  // verifica se il profilo appartiene originariamente all'operatore delegato
  // non considera il periodo di validità ma è voluto così
  if WM006DM.VerificaProfiloAssegnato(FUtenteDelegante.Azienda, PUtenteDelegato, PProfilo) then
  begin
    Result.Messaggio:=Format('Il profilo risulta già assegnato all''utente "%s".'#13#10'Impossibile procedere!', [PUtenteDelegato]);
    Exit;
  end;

  // validità periodo: consecutività delle date
  if PDataDal > PDataAl then
  begin
    Result.Messaggio:='Il periodo indicato non è corretto!';
    Exit;
  end;

  // validità periodo: il periodo non deve essere passato
  if PDataDal < Date then
  begin
    Result.Messaggio:='Il periodo di delega non può iniziare prima della data odierna!';
    Exit;
  end;

  // validità periodo: il periodo delegato non deve essere esterno al proprio periodo di validità attuale
  if (PDataDal < FUtenteDelegante.InizioValidita) or (PDataAl > FUtenteDelegante.FineValidita) then
  begin
    Result.Messaggio:=Format('Il proprio profilo non può essere delegato per il periodo specificato, in quanto ha validità dal %s al %s.', [DateToStr(FUtenteDelegante.InizioValidita),DateToStr(FUtenteDelegante.FineValidita)]);
    Exit;
  end;

  LNumDeleghe:=WM006DM.VerificaDelegheEsistenti(FUtenteDelegante.Azienda, PUtenteDelegato, PProfilo, PDataDal, PDataAl, OldDataDal, OldDataAl, FRowIdDelegaEsistente);

  // verifica se esiste già una delega dello stesso profilo in un periodo intersecante
  if LNumDeleghe = 1 then
  begin
    // il profilo è già stato delegato all'utente in uno (e uno solo) periodo intersecante
    Result.Messaggio:=Format('Il profilo risulta già delegato all''utente "%s" dal %s al %s',[PUtenteDelegato,DateToStr(OldDataDal),DateToStr(OldDataAl)]);

    // verifica modifiche al periodo
    if (PDataDal = OldDataDal) and (PDataAl = OldDataAl) then
    begin
      // stesso periodo: errore!
      Result.Messaggio:=Result.Messaggio + '!';
      Exit;
    end
    else if PDataDal = OldDataDal then
    begin
      // data inizio uguale: chiede conferma
      Result.Ok:=True;
      Result.Messaggio:=Result.Messaggio + Format('. Proseguendo, la delega esistente verrà sovrascritta e il termine di validità sarà %s al %s. Vuoi continuare?',
                                                  [IfThen(PDataAl > OldDataAl, 'posticipato', 'anticipato'), DateToStr(PDataAl)]);
      Exit;
    end
    else if PDataAl = OldDataAl then
    begin
      // data fine uguale:
      // blocca se si sta posticipando una delega attualmente in corso di validità
      // altrimenti chiede conferma
      if (Date >= OldDataDal) and
         (Date < PDataDal) then
      begin
        Result.Messaggio:=Result.Messaggio + Format('. Impossibile posticipare l''inizio di questo periodo al %s, poiché la delega è attualmente in corso di validità!',[DateToStr(PDataDal)]);
        Exit;
      end
      else
      begin
        Result.Ok:=True;
        Result.Messaggio:=Result.Messaggio + Format('. Proseguendo, la delega esistente verrà sovrascritta e l''inizio di validità sarà %s al %s. Vuoi continuare?',
                                                    [IfThen(PDataDal > OldDataDal, 'posticipato', 'anticipato'), DateToStr(PDataDal)]);
        Exit;
      end;
    end
    else
    begin
      // periodo interno / esterno
      // blocca se si sta posticipando una delega attualmente in corso di validità
      if (Date >= OldDataDal) and
         (Date < PDataDal) then
      begin
        Result.Messaggio:=Result.Messaggio + Format('. Impossibile posticipare l''inizio di questo periodo al %s, poiché la delega è attualmente in corso di validità!',[DateToStr(PDataDal)]);
        Exit;
      end
      else
      begin
        Result.Ok:=True;
        Result.Messaggio:=Result.Messaggio + '. Proseguendo, la delega esistente verrà sovrascritta ed il periodo di validità sarà modificato. Vuoi continuare?';
        Exit;
      end;
    end;
  end
  else if LNumDeleghe > 1 then
  begin
    // il periodo interseca più deleghe dello stesso profilo: nessuna azione possibile
    Result.Messaggio:=Format('Il profilo risulta già delegato all''utente "%s" per n. %s volte nel periodo dal %s al %s. Considerare la possibilità cancellare manualmente questi periodi prima di inserirne uno solo.', [PUtenteDelegato,IntToStr(LNumDeleghe),DateToStr(PDataDal),DateToStr(PDataAl)]);
    Exit;
  end;

  // controlli ok (nessuna delega esistente)
  Result.Ok:=True;
end;

function TWM006FGestioneDelegheMW.ControlliModificaOK(PUtenteDelegato, PProfilo: String; PDataDal, PDataAl: TDateTime): TResCtrl;
var
  OldDataDal, OldDataAl: TDateTime;
  LNumDeleghe: Integer;
begin
  Result.Clear;

  // validità periodo: consecutività delle date
  if PDataDal > PDataAl then
  begin
    Result.Messaggio:='Il periodo indicato non è corretto!';
    Exit;
  end;

  // validità periodo: il periodo non deve essere passato
  if PDataDal < Date then
  begin
    Result.Messaggio:='Il periodo di delega non può iniziare prima della data odierna!';
    Exit;
  end;

  // validità periodo: il periodo delegato non deve essere esterno al proprio periodo di validità attuale
  if (PDataDal < FUtenteDelegante.InizioValidita) or (PDataAl > FUtenteDelegante.FineValidita) then
  begin
    Result.Messaggio:=Format('Il proprio profilo non può essere delegato per il periodo specificato, in quanto ha validità dal %s al %s.', [DateToStr(FUtenteDelegante.InizioValidita),DateToStr(FUtenteDelegante.FineValidita)]);
    Exit;
  end;

  LNumDeleghe:=WM006DM.VerificaDelegheEsistenti(FUtenteDelegante.Azienda, PUtenteDelegato, PProfilo, PDataDal, PDataAl, OldDataDal, OldDataAl, FRowIdDelegaEsistente);

  // verifica se esiste già una delega dello stesso profilo in un periodo intersecante
  if LNumDeleghe = 1 then
  begin
    if DelegaInModifica.Id <> FRowIdDelegaEsistente then
    begin
      // il profilo è già stato delegato all'utente in uno (e uno solo) periodo intersecante
      Result.Messaggio:=Format('Il profilo risulta già delegato all''utente "%s" dal %s al %s',[PUtenteDelegato,DateToStr(OldDataDal),DateToStr(OldDataAl)]);

      // verifica modifiche al periodo
      if (PDataDal = OldDataDal) and (PDataAl = OldDataAl) then
      begin
        // stesso periodo: errore!
        Result.Messaggio:=Result.Messaggio + '!';
        Exit;
      end
      else if PDataDal = OldDataDal then
      begin
        // data inizio uguale: chiede conferma
        Result.Ok:=True;
        Result.Messaggio:=Result.Messaggio + Format('. Proseguendo, la delega esistente verrà sovrascritta e il termine di validità sarà %s al %s. Vuoi continuare?',
                                                    [IfThen(PDataAl > OldDataAl, 'posticipato', 'anticipato'), DateToStr(PDataAl)]);
        Exit;
      end
      else if PDataAl = OldDataAl then
      begin
        // data fine uguale:
        // blocca se si sta posticipando una delega attualmente in corso di validità
        // altrimenti chiede conferma
        if (Date >= OldDataDal) and
           (Date < PDataDal) then
        begin
          Result.Messaggio:=Result.Messaggio + Format('. Impossibile posticipare l''inizio di questo periodo al %s, poiché la delega è attualmente in corso di validità!',[DateToStr(PDataDal)]);
          Exit;
        end
        else
        begin
          Result.Ok:=True;
          Result.Messaggio:=Result.Messaggio + Format('. Proseguendo, la delega esistente verrà sovrascritta e l''inizio di validità sarà %s al %s. Vuoi continuare?',
                                                      [IfThen(PDataDal > OldDataDal, 'posticipato', 'anticipato'), DateToStr(PDataDal)]);
          Exit;
        end;
      end
      else
      begin
        // periodo interno / esterno
        // blocca se si sta posticipando una delega attualmente in corso di validità
        if (Date >= OldDataDal) and
           (Date < PDataDal) then
        begin
          Result.Messaggio:=Result.Messaggio + Format('. Impossibile posticipare l''inizio di questo periodo al %s, poiché la delega è attualmente in corso di validità!',[DateToStr(PDataDal)]);
          Exit;
        end
        else
        begin
          Result.Ok:=True;
          Result.Messaggio:=Result.Messaggio + '. Proseguendo, la delega esistente verrà sovrascritta ed il periodo di validità sarà modificato. Vuoi continuare?';
          Exit;
        end;
      end;
    end;
  end
  else if LNumDeleghe > 1 then
  begin
    // il periodo interseca più deleghe dello stesso profilo: nessuna azione possibile
    Result.Messaggio:=Format('Il profilo risulta già delegato all''utente "%s" per n. %s volte nel periodo dal %s al %s. Considerare la possibilità cancellare manualmente questi periodi prima di inserirne uno solo.', [PUtenteDelegato,IntToStr(LNumDeleghe),DateToStr(PDataDal),DateToStr(PDataAl)]);
    Exit;
  end;

  if FDelegaInModifica.UltimoAccesso <> DATE_NULL then
  begin
    if PDataDal <> FDelegaInModifica.InizioValidita then
    begin
      Result.Messaggio:=Format('Impossibile modificare la data di inizio validità! L''utente delegato ha già effettuato accessi con tale profilo. Ultimo accesso effettuato: %s',[FDelegaInModifica.UltimoAccesso]);
      Exit;
    end
    else if PDataAl < Trunc(FDelegaInModifica.UltimoAccesso) then
    begin
      Result.Messaggio:=Format('L''utente delegato ha già effettuato accessi con questo profilo. La data di fine validità non può essere precedente alla data di ultimo accesso effettuato: %s',[FDelegaInModifica.UltimoAccesso]);
      Exit;
    end;
  end;

  // controlli ok
  Result.Ok:=True;
end;

end.
