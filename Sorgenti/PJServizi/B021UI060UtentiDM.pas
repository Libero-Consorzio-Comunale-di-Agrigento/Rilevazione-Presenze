unit B021UI060UtentiDM;

interface

uses
  A000UCostanti, A000USessione, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} R014URestDM,
  C200UWebServicesTypes, B021UUtils, C180FunzioniGenerali,
  RegistrazioneLog, SysUtils, StrUtils, Variants, Classes,
  Oracle, DB, OracleData, Math;

type
  TDailyShiftChange = class(TPersistent)
  private
    FNonSo: String;
  end;

  TI060Utenti = class(TPersistent)
  private
    //I060
    FMatricola: String;
    FCodFiscale: string;
    FNomeUtente: string;
    FPassword: string;
    FEMail: string;
    //I061
    FNomeProfilo: string;
    FPermessi: string;
    FFFunzioni: string;
    FFAnagrafe: string;
    FIter: string;
    FFDizionario: string;
    FInizioV: TDateTime;
    FFineV: TDateTime;
  end;

  TB021FUtentiDM = class(TR014FRestDM)
    selMatricola: TOracleQuery;
    InsI060: TOracleQuery;
    InsI061: TOracleQuery;
    selI07x: TOracleQuery;
  protected
    function RevertJSON(PJson: TJSONObject): TPersistent; override;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function UpdateDato: TJSONObject; override;   //Post
  end;

implementation

{$R *.dfm}

function TB021FUtentiDM.RevertJSON(PJson: TJSONObject): TPersistent;
var
  jPairGiust: TJSONPair;
  i: Integer;
begin
  // creazione oggetto turni
  Result:=TI060Utenti.Create;
  try
    for i:=0 to PJson.Size - 1  do
    begin
      jPairGiust:=TJSONPair(PJson.Get(i));

      if jPairGiust.JsonString.Value = 'Matricola' then
        TI060Utenti(Result).FMatricola:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'CodFiscale' then
        TI060Utenti(Result).FCodFiscale:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'NomeUtente' then
        TI060Utenti(Result).FNomeUtente:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'Password' then
        TI060Utenti(Result).FPassword:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'EMail' then
        TI060Utenti(Result).FEmail:=jPairGiust.JsonValue.Value

      else if jPairGiust.JsonString.Value = 'NomeProfilo' then
        TI060Utenti(Result).FNomeProfilo:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'Permessi' then
        TI060Utenti(Result).FPermessi:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'FiltroFunzioni' then
        TI060Utenti(Result).FFFunzioni:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'FiltroAnagrafe' then
        TI060Utenti(Result).FFAnagrafe:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'Iter' then
        TI060Utenti(Result).FIter:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'FiltroDizionario' then
        TI060Utenti(Result).FFDizionario:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'InizioValidita' then
        TB021FUtils.ConvertiStrDate(jPairGiust.JsonValue.Value,TI060Utenti(Result).FInizioV)
      else if jPairGiust.JsonString.Value = 'FineValidita' then
        TB021FUtils.ConvertiStrDate(jPairGiust.JsonValue.Value,TI060Utenti(Result).FFineV)
      else
      begin
        Log('RevertJSON',Format('errore nei parametri: "%s" non riconosciuto', [jPairGiust.JsonString.Value]));
        raise EC200InvalidParameter.Create(Format('errore nei parametri: "%s" non riconosciuto', [jPairGiust.JsonString.Value]));
      end;
    end;
  except
    on E: Exception do
      raise EC200UnmarshallingError.Create('Errore di conversione: ' + E.Message);
  end;
end;

function TB021FUtentiDM.ControlloParametri(var RErrMsg: String): Boolean;
var
 U: TI060Utenti;
begin
  RErrMsg:='';
  Result:=False;

  if Operazione = OPER_CREATE then
  begin

  end
  else if Operazione = OPER_UPDATE then
  begin
    U:=TI060Utenti(RevertJSON(JObject));
    //Controllo parametri minimi
    if (U.FMatricola = '') and (u.FCodFiscale = '') then
    begin
      RErrMsg:='Parametri incompleti (Matricola, CodFiscale) ';
      Exit;
    end;
    if U.FNomeUtente = '' then
    begin
      RErrMsg:='Parametri incompleti (NomeUtente) ';
      Exit;
    end;

    //Controllo periodo
    if (U.FFineV < U.FInizioV) and (U.FFineV > 0) then
    begin
      RErrMsg:='Parametri non validi (Perido di validita non valido) ';
      Exit;
    end;

    //Controllo esistenza profili
    selI07x.ClearVariables;
    selI07x.SetVariable('AZIENDA', TSessioneIrisWIN(Self.Owner).Parametri.Azienda);

    if U.FPermessi <> '' then
    begin
      selI07x.SetVariable('TABELLA', 'I071_PERMESSI');
      selI07x.SetVariable('PROFILO', U.FPermessi);
      selI07x.Execute;
      if selI07x.FieldAsInteger(0) = 0 then
      begin
        RErrMsg:='Parametri non validi (Permessi) ';
        Exit;
      end;
    end;

    if U.FFAnagrafe <> '' then
    begin
      selI07x.SetVariable('TABELLA', 'I072_FILTROANAGRAFE');
      selI07x.SetVariable('PROFILO', U.FFAnagrafe);
      selI07x.Execute;
      if selI07x.FieldAsInteger(0) = 0 then
      begin
        RErrMsg:='Parametri non validi (FiltroAnagrafe) ';
        Exit;
      end;
    end;

    if U.FFFunzioni <> '' then
    begin
      selI07x.SetVariable('TABELLA', 'I073_FILTROFUNZIONI');
      selI07x.SetVariable('PROFILO', U.FFFunzioni);
      selI07x.Execute;
      if selI07x.FieldAsInteger(0) = 0 then
      begin
        RErrMsg:='Parametri non validi (FiltroFunzioni) ';
        Exit;
      end;
    end;

    if U.FFDizionario <> '' then
    begin
      selI07x.SetVariable('TABELLA', 'I074_FILTRODIZIONARIO');
      selI07x.SetVariable('PROFILO', U.FFDizionario);
      selI07x.Execute;
      if selI07x.FieldAsInteger(0) = 0 then
      begin
        RErrMsg:='Parametri non validi (FiltroDizionario) ';
        Exit;
      end;
    end;

    if U.FIter <> '' then
    begin
      selI07x.SetVariable('TABELLA', 'I075_ITER_AUTORIZZATIVI');
      selI07x.SetVariable('PROFILO', U.FIter);
      selI07x.Execute;
      if selI07x.FieldAsInteger(0) = 0 then
      begin
        RErrMsg:='Parametri non validi (Iter) ';
        Exit;
      end;
    end;
  end;

  Result:=True;
end;

function TB021FUtentiDM.UpdateDato: TJSONObject;
var
  I060Utenti: TI060Utenti;
  i,j,Prog: Integer;
begin
  Result:=nil;
  I060Utenti:=TI060Utenti(RevertJSON(JObject));

  if I060Utenti.FMatricola = '' then
  begin
    selMatricola.SetVariable('FILTRO', Format('CODFISCALE = ''%s''',[I060Utenti.FCodFiscale]));
    selMatricola.Execute;
    if selMatricola.RowCount = 0 then
    begin
      Log('UpdateDato',('errore nei parametri: CODFISCALE - nessuna matricola associata'));
      raise EC200InvalidParameter.Create('CODFISCALE - nessuna matricola associata');
    end;
    I060Utenti.FMatricola:=selMatricola.FieldAsString(0);
  end;

  selMatricola.SetVariable('FILTRO', Format('MATRICOLA = ''%s''',[I060Utenti.FMatricola]));
  selMatricola.Execute;
  if selMatricola.RowCount = 0 then
  begin
    Log('UpdateDato',('errore nei parametri: MATRICOLA - valore non trovato'));
    raise EC200InvalidParameter.Create('MATRICOLA - valore non trovato');
  end;

  InsI060.ClearVariables;
  InsI060.SetVariable('AZIENDA', TSessioneIrisWIN(Self.Owner).Parametri.Azienda);
  InsI060.SetVariable('MATRICOLA', I060Utenti.FMatricola);
  InsI060.SetVariable('NOME_UTENTE', I060Utenti.FNomeUtente);
  InsI060.SetVariable('PASSWORD', R180Cripta(I060Utenti.FPassword,30011945));
  InsI060.SetVariable('EMAIL', I060Utenti.FEMail);
  InsI060.Execute;

  if I060Utenti.FNomeProfilo <> '' then
  begin
    InsI061.ClearVariables;
    InsI061.SetVariable('AZIENDA', TSessioneIrisWIN(Self.Owner).Parametri.Azienda);
    InsI061.SetVariable('NOME_UTENTE', I060Utenti.FNomeUtente);
    InsI061.SetVariable('NOME_PROFILO', I060Utenti.FNomeProfilo);
    InsI061.SetVariable('PERMESSI', I060Utenti.FPermessi);
    InsI061.SetVariable('FILTRO_FUNZIONI', I060Utenti.FFFunzioni);
    InsI061.SetVariable('FILTRO_ANAGRAFE', I060Utenti.FFAnagrafe);
    InsI061.SetVariable('ITER_AUTORIZZATIVI', I060Utenti.FIter);
    InsI061.SetVariable('FILTRO_DIZIONARIO', I060Utenti.FFDizionario);
    if I060Utenti.FInizioV > 0 then
      InsI061.SetVariable('INIZIO_VALIDITA', I060Utenti.FInizioV);
    if I060Utenti.FFineV > 0 then
      InsI061.SetVariable('FINE_VALIDITA', I060Utenti.FFineV);
    InsI061.Execute;
  end;

  InsI060.Session.Commit;
end;

end.
