unit A001UPassWordDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Oracle, OracleData, Variants, ActiveX, StrUtils,
  A000UCostanti, A000USessione, A000Versione, A001USSPIValidatePassword, A001UActiveDs_TLB,
  A001UADsHlp, C180FunzioniGenerali, L021Call, RegolePassword;

type
  TA001FPassWordDtM1 = class(TDataModule)
    QI090: TOracleDataSet;
    QI091: TOracleDataSet;
    QI092: TOracleDataSet;
    QI070: TOracleDataSet;
    QI071: TOracleDataSet;
    QI072: TOracleDataSet;
    OperSQL: TOracleQuery;
    I070Count: TOracleDataSet;
    QI073: TOracleDataSet;
    QI074: TOracleDataSet;
    selI070Utenti: TOracleDataSet;
    scrAllineamentoVersione: TOracleScript;
    selI080: TOracleDataSet;
    selT033: TOracleDataSet;
    QI060: TOracleDataSet;
    selI061: TOracleDataSet;
    selTablespace: TOracleDataSet;
    selDistAzienda: TOracleDataSet;
    selP210: TOracleDataSet;
    selT002: TOracleDataSet;
    selI070Doppi: TOracleDataSet;
    selI081: TOracleDataSet;
    selAziendaUtente: TOracleDataSet;
    updI061UltimoAccesso: TOracleQuery;
    scrI091ParametriAvanzatiB000: TOracleQuery;
    procedure A001FPassWordDtM1Create(Sender: TObject);
    procedure A001FPassWordDtM1Destroy(Sender: TObject);
    procedure QI073AfterOpen(DataSet: TDataSet);
    procedure QI074AfterOpen(DataSet: TDataSet);
    procedure ImpostaParametriStandard;
  private
    SessioneIWA001:TSessioneIrisWIN;
    function GetCodContrattoVoci(TipoGetCodContratto:String):String;
    procedure Log(Tipo,S:String);
  public
    SessioneMondoEDP:TOracleSession;
    EseguiCheckConnection: Boolean;
    procedure OpenI060I070(pTabelle: Array of String; pUtente: string);
    procedure RegistraInibizioni;
    procedure InizializzazioneSessione(DB:String);
    procedure UpdUltimoAccessoProfilo;
    function TestDBAlias(NomeAlias:string):boolean;
    function RegistraInibizioniInfo(NomeProfilo:String = ''; ProfiloObbligatorio:Boolean = True):boolean;
    function AutenticazioneDominio(const DomainName, UserName, Password:String; TipoAutenticazione:String = 'NTLM'; LDAP_DN:String = ''; SuffissoLDAP:String = ''):Boolean;
    function GetSuffissoLDAP(pTipo: string): string;
  end;

var
  A001FPassWordDtM1: TA001FPassWordDtM1;

implementation

{$R *.DFM}

uses
  A000UInterfaccia
  {$IFDEF IRISWEB}
  {$IFNDEF WEBSVC}
  ,IWApplication, WR010UBase
  {$ELSE}
  ,C200UWebServicesUtils, Datasnap.DSSession
  {$ENDIF}
  {$ENDIF};

procedure TA001FPassWordDtM1.A001FPassWordDtM1Create(Sender: TObject);
begin
  SessioneIWA001:=A000SessioneIrisWIN;
  if Self.Owner <> nil then
    if Self.Owner is TSessioneIrisWIN then
      SessioneIWA001:=Self.Owner as TSessioneIrisWIN;
  ForceDirectories(ExtractFilePath(Application.ExeName) + 'Archivi\Temp');
  QI073.SetVariable('Applicazione',SessioneIWA001.Parametri.Applicazione);
  SessioneMondoEDP:=nil;
  EseguiCheckConnection:=True;
end;

function TA001FPassWordDtM1.TestDBAlias(NomeAlias:string):boolean;
//Verifica l'esistenza dell'alias inserito
var
  i:integer;
  StrOracleAliasList:TStringList;
begin
  StrOracleAliasList:=OracleAliasList;
  //Se la StringList risulta vuota restituisco True(comse se l'alias esistesse)
  if (StrOracleAliasList = nil) or (StrOracleAliasList.Count <= 0) then
  begin
    Result:=True;
    Exit;
  end;
  //Verifico se l'alias è presente all'interno del TNSNAMES
  Result:=StrOracleAliasList.IndexOf(NomeAlias) >= 0;
  //Se no
  //Verifico l'esistenza dell'alias NomeAlias + '.' all'interno del TNSNAMES
  if not Result then
  begin
    i:=0;
    while (i < StrOracleAliasList.Count - 1) and
          (StrOracleAliasList[i].IndexOf(NomeAlias + '.') < 0) do
    begin
      inc(i);
    end;
    Result:=StrOracleAliasList[i].IndexOf(NomeAlias + '.') >= 0;
  end;
end;

procedure TA001FPassWordDtM1.UpdUltimoAccessoProfilo;
begin
  with updI061UltimoAccesso do
  begin
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('NOME_UTENTE',Parametri.Operatore);
    SetVariable('NOME_PROFILO',Parametri.ProfiloWEB);
    Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TA001FPasswordDtM1.InizializzazioneSessione(DB:String);
var i:Integer;
begin
  {$IFNDEF IRISWEB}R180SetOracleInstantClient;{$ENDIF}
  if SessioneMondoEDP = nil then
  begin
    SessioneMondoEDP:=TOracleSession.Create(nil);
    SessioneMondoEDP.Preferences.UseOCI7:=False;
    SessioneMOndoEDP.BytesPerCharacter:=bc1Byte;
    SessioneMondoEDP.NullValue:=nvNull;
    SessioneMondoEDP.Preferences.ZeroDateIsNull:=False;
    SessioneMondoEDP.Preferences.TrimStringFields:=False;
    SessioneMondoEDP.Cursor:=crSQLWait;
    SessioneMondoEDP.StatementCache:=True;
    SessioneMondoEDP.StatementCacheSize:=20;
    {$IFDEF IRISWEB}SessioneMondoEDP.ThreadSafe:=True;{$ENDIF}
    {$IFDEF IRISAPP}SessioneMondoEDP.ThreadSafe:=True;{$ENDIF}
    if (SessioneIWA001 <> nil) and (R180In(SessioneIWA001.Name,['B021','B110'])) then
    begin
      //SessioneMondoEDP.Pooling:=spInternal;
      SessioneMondoEDP.Pooling:=spNone; // con spInternal ci sono problemi (probabili deadlock)
    end;
    SessioneMondoEDP.Name:='SessioneMondoEDPA001';
  end;
  if SessioneMondoEDP.LogonDataBase <> DB then
  begin
    if not R180In(SessioneIWA001.Name,['B021','B110']) then
      SessioneMondoEDP.Logoff;
    SessioneMondoEDP.LogonDataBase:=DB;
    SessioneMondoEDP.LogonUsername:='MONDOEDP';
  end;
  if (R180In(SessioneIWA001.Name,['B021','B110'])) and (not SessioneMondoEDP.Connected) then
  try
    A000LogonDBOracle(SessioneMondoEDP);
  except
  end
  else if (not R180In(SessioneIWA001.Name,['B021','B110'])) and
          ((not SessioneMondoEDP.Connected) or
           (EseguiCheckConnection and (SessioneMondoEDP.CheckConnection(True) = ccError))
          )
  then
  begin
    SessioneMondoEDP.LogonDataBase:=DB;
    SessioneMondoEDP.LogonUsername:='MONDOEDP';
    try
      A000LogonDBOracle(SessioneMondoEDP);
    except
      on E:Exception do
      begin
        {$IFDEF IRISWEB}{$IFNDEF WEBSVC}W000RegistraLog('Errore','A001:' + E.Message);{$ENDIF}{$ENDIF}
        raise;
      end;
    end;
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      try (Components[i] as TOracleQuery).Session:=SessioneMondoEDP; except {$IFDEF IRISWEB}{$IFNDEF WEBSVC}on E:Exception do begin W000RegistraLog('Errore','A001:(251)' + E.Message); end;{$ENDIF}{$ENDIF} end;
    if Components[i] is TOracleDataSet then
      try (Components[i] as TOracleDataSet).Session:=SessioneMondoEDP; except {$IFDEF IRISWEB}{$IFNDEF WEBSVC}on E:Exception do begin W000RegistraLog('Errore','A001:(252)' + E.Message); end;{$ENDIF}{$ENDIF} end;
    if Components[i] is TOracleScript then
      try (Components[i] as TOracleScript).Session:=SessioneMondoEDP; except {$IFDEF IRISWEB}{$IFNDEF WEBSVC}on E:Exception do begin W000RegistraLog('Errore','A001:(253)' + E.Message); end;{$ENDIF}{$ENDIF} end;
  end;
  SessioneIWA001.Parametri.PasswordMondoEDP:=SessioneMondoEDP.LogonPassword;
  SessioneIWA001.Parametri.Database:=SessioneMondoEDP.LogonDatabase;
  selI070Utenti.Open;
  if selI070Utenti.FieldByName('NUM').AsInteger = 0 then
  begin
    QI070.SQL.Text:=StringReplace(QI070.SQL.Text,'I070_UTENTI','I070_OPERATORI',[rfReplaceAll,rfIgnoreCase]);
    I070Count.SQL.Text:='SELECT 0 FROM DUAL';
  end;
  I070Count.Open;
  //Controllo se esiste azienda AZIN
  with QI090 do
    begin
    SetVariable('Azienda','AZIN');
    Open;
    if RecordCount = 0 then
      with OperSQL do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO I090_ENTI (AZIENDA,UTENTE,PAROLACHIAVE,STORIAINTERVENTO,TSLAVORO,TSINDICI) ' +
                'VALUES (''AZIN'',''MONDOEDP'',''' + R180Cripta(A000PasswordFissa,21041974) + ''',''N'',''LAVORO'',''INDICI'')');
        try
          Execute;
          SessioneMondoEDP.Commit;
        except
          SessioneMondoEDP.RollBack;
        end;
      end;
    end;
  //Controllo se esiste operatore SYSMAN
  with QI070 do
    begin
    Close;
    SetVariable('Azienda','AZIN');
    SetVariable('CampoUtente','UTENTE');
    SetVariable('Utente','SYSMAN');
    Open;
    if RecordCount = 0 then
      with OperSQL do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO I070_UTENTI (AZIENDA,UTENTE,PROGRESSIVO,PASSWD,OCCUPATO,INTEGRAZIONEANAGRAFE,SBLOCCO) ' +
                'VALUES (''AZIN'',''SYSMAN'',0,''' + R180CriptaI070('LEADER') + ''',''N'',''S'',''N'')');
        if selI070Utenti.FieldByName('NUM').AsInteger = 0 then
          SQL.Text:=StringReplace(SQL.Text,'I070_UTENTI','I070_OPERATORI',[rfReplaceAll,rfIgnoreCase]);
        try
          Execute;
          SessioneMondoEDP.Commit;
        except
          SessioneMondoEDP.RollBack;
        end;
      end;
    end;
end;

procedure TA001FPassWordDtM1.ImpostaParametriStandard;
  function CheckOracleHint(S:String; Condiz:String = ''):String;
  begin
    if (Condiz <> '') and (UpperCase(Copy(S,Length(S) - Length(Condiz) + 1,Length(Condiz))) <> UpperCase(Condiz)) then
    begin
      Result:='';
      exit;
    end;
    if UpperCase(Copy(S,Length(S) - 2,3)) = '+NC' then
      S:=Copy(S,1,Length(S) - 3);
    Result:=S;
    if Pos('/*+',S) <> 1 then
      Result:=''
    else if Pos('*/',S) <> Length(S) - 1 then
      Result:=''
    else
    begin
      S:=StringReplace(S,'/*+','',[]);
      S:=StringReplace(S,'*/','',[]);
      if (Pos('/*+',S) > 0) or (Pos('*/',S) > 0) then
        Result:='';
    end;
  end;
begin
  Log('Traccia','ImpostaParametriStandard.Inizio');
  SessioneIWA001.Parametri.Azienda:=QI090.FieldByName('Azienda').AsString;
  SessioneIWA001.Parametri.DAzienda:=QI090.FieldByName('Descrizione').AsString;
  SessioneIWA001.Parametri.Alias:=QI090.FieldByName('Alias').AsString;
  SessioneIWA001.Parametri.Username:=QI090.FieldByName('Utente').AsString;
  SessioneIWA001.Parametri.Password:=QI090.FieldByName('ParolaChiave').AsString;
  SessioneIWA001.Parametri.CodiceIntegrazione:=QI090.FieldByName('Codice_Integrazione').AsString;
  SessioneIWA001.Parametri.TSLavoro:=QI090.FieldByName('TSLavoro').AsString;
  SessioneIWA001.Parametri.TSIndici:=QI090.FieldByName('TSIndici').AsString;
  SessioneIWA001.Parametri.TSAusiliario:='';
  SessioneIWA001.Parametri.CodContrattoVoci:=GetCodContrattoVoci('Contratto base');
  SessioneIWA001.Parametri.CodContrattoConvenzionati:=GetCodContrattoVoci('Contratto convenzionati');
  SessioneIWA001.Parametri.CodContrattoSanita:=GetCodContrattoVoci('Contratto sanita');
  try SessioneIWA001.Parametri.TSAusiliario:=Trim(QI090.FieldByName('TSAusiliario').AsString); except end;
  if SessioneIWA001.Parametri.TSAusiliario = '' then
    SessioneIWA001.Parametri.TSAusiliario:=SessioneIWA001.Parametri.TSLavoro;
  try SessioneIWA001.Parametri.LogTabelle:=QI090.FieldByName('StoriaIntervento').AsString; except end;
  try SessioneIWA001.Parametri.TimbOrig_Verso:=QI090.FieldByName('TimbOrig_Verso').AsString; except end;
  try SessioneIWA001.Parametri.TimbOrig_Causale:=QI090.FieldByName('TimbOrig_Causale').AsString; except end;
  try SessioneIWA001.Parametri.LunghezzaPassword:=QI090.FieldByName('Lung_Password').AsInteger; except end;
  try SessioneIWA001.Parametri.ValiditaPassword:=QI090.FieldByName('Valid_Password').AsInteger; except end;
  //Regole robustezza password
  SessioneIWA001.Parametri.RegolePassword.PasswordI060:=SessioneIWA001.Parametri.ProfiloWEB <> '';
  try SessioneIWA001.Parametri.RegolePassword.Lunghezza:=QI090.FieldByName('Lung_Password').AsInteger; except end;
  try SessioneIWA001.Parametri.RegolePassword.MesiValidita:=QI090.FieldByName('Valid_Password').AsInteger; except end;
  try SessioneIWA001.Parametri.RegolePassword.Cifre:=QI090.FieldByName('Password_Cifre').AsInteger; except end;
  try SessioneIWA001.Parametri.RegolePassword.Maiuscole:=QI090.FieldByName('Password_Maiuscole').AsInteger; except end;
  try SessioneIWA001.Parametri.RegolePassword.CarSpeciali:=QI090.FieldByName('Password_CarSpeciali').AsInteger; except end;
  //
  try SessioneIWA001.Parametri.GruppoBadge:=QI090.FieldByName('GRUPPO_BADGE').AsString; except end;
  try SessioneIWA001.Parametri.ValiditaUtente:=QI090.FieldByName('VALID_UTENTE').AsInteger; except end;
  try SessioneIWA001.Parametri.RagioneSociale:=R180Decripta(QI090.FieldByName('Ragione_Sociale').AsString,14091943); except end;
  try SessioneIWA001.Parametri.VersioneDB:=QI090.FieldByName('VersioneDB').AsString; except end;
  try SessioneIWA001.Parametri.BuildDB:=QI090.FieldByName('PatchDB').AsString; except end;

  //Registro versione oracle in uso
  with TOracleQuery.Create(Self) do
  try
    Session:=SessioneMondoEDP;
    SQL.Text:='select version from v$instance';
    try
      Execute;
      SessioneIWA001.Parametri.VersioneOracle:=StrToIntDef(Copy(FieldAsString(0),1,Pos('.',FieldAsString(0))-1),0);
    except
      SessioneIWA001.Parametri.VersioneOracle:=0;
    end;
    SQL.Text:='select VALUE from NLS_DATABASE_PARAMETERS where PARAMETER = ''NLS_CHARACTERSET''';
    try
      Execute;
      SessioneIWA001.Parametri.CharSetOracle:=FieldAsString(0);
    except
        SessioneIWA001.Parametri.CharSetOracle:='';
    end;
  finally
    Free;
  end;

  {Bruno(10/04/2018)}
  SessioneIWA001.Parametri.ModuliInstallati:='';
  SessioneIWA001.Parametri.ApplicativiDisponibili:='';
  R180SetVariable(selI080,'AZIENDA',QI090.FieldByName('Azienda').AsString);
  selI080.Open;
  selI080.First;
  while not selI080.Eof do
  begin
    try
      if R180Decripta(selI080.FieldByName('APPLICAZIONE').AsString,14091943) = IfThen(SessioneIWA001.Parametri.Applicazione <> '',SessioneIWA001.Parametri.Applicazione,'RILPRE') then
      begin
        SessioneIWA001.Parametri.ModuliInstallati:=SessioneIWA001.Parametri.ModuliInstallati + R180Decripta(selI080.FieldByName('MODULO').AsString,14091943) + #13 ;
      end;
      if Pos(R180Decripta(selI080.FieldByName('APPLICAZIONE').AsString,14091943),SessioneIWA001.Parametri.ApplicativiDisponibili) <= 0 then
      begin
        SessioneIWA001.Parametri.ApplicativiDisponibili:=SessioneIWA001.Parametri.ApplicativiDisponibili + R180Decripta(selI080.FieldByName('APPLICAZIONE').AsString,14091943) + #13;
      end;
    except
    end;
    selI080.Next;
  end;

  if SessioneIWA001.Parametri.RagioneSociale = I090MONDOEDP then
    SessioneIWA001.Parametri.RagioneSociale:=SessioneIWA001.Parametri.DAzienda
  else if Trim(SessioneIWA001.Parametri.RagioneSociale) = '' then
    SessioneIWA001.Parametri.RagioneSociale:=I090NONAUTORIZZATA;
  //Permessi
  try
    QI071.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    QI071.Open;
    SessioneIWA001.Parametri.AggiornamentoBaseDati:=QI071.FieldByName('CANCELLAZIONE_DATI').AsString;
  except
    SessioneIWA001.Parametri.AggiornamentoBaseDati:='S';
  end;
  //Nel caso di uso del B005, leggo solamente l'abilitazione alla funzione tramite il flag CANCELLAZIONE_DATI, quindi esco perchè i parametri potrebbero non più validi con l'aggiornamento
  if Copy(ExtractFileName(Application.ExeName),1,4) = 'B005' then
  begin
    QI071.Close;
    exit;
  end;
  try SessioneIWA001.Parametri.CancellaTimbrature:=QI071.FieldByName('CANCELLA_TIMBRATURE').AsString; except end;
  try SessioneIWA001.Parametri.T100_CancTimbOrig:=QI071.FieldByName('T100_CANC_ORIGINALI').AsString; except end;
  try SessioneIWA001.Parametri.InserisciTimbrature:=QI071.FieldByName('INSERISCI_TIMBRATURE').AsString; except end;
  try SessioneIWA001.Parametri.AbilitaSchedeChiuse:=QI071.FieldByName('ABILITA_SCHEDE_CHIUSE').AsString; except end;
  try SessioneIWA001.Parametri.T100_Ora:=QI071.FieldByName('T100_ORA').AsString; except end;
  try SessioneIWA001.Parametri.T100_Rilevatore:=QI071.FieldByName('T100_RILEVATORE').AsString; except end;
  try SessioneIWA001.Parametri.T100_Causale:=QI071.FieldByName('T100_CAUSALE').AsString; except end;
  try SessioneIWA001.Parametri.T380_AutoPianificazione:=QI071.FieldByName('T380_AUTO_PIANIFICAZIONE').AsString; except end;
  try SessioneIWA001.Parametri.A029_Saldi:=QI071.FieldByName('A029_SALDI').AsString; except end;
  try SessioneIWA001.Parametri.A029_Indennita:=QI071.FieldByName('A029_INDENNITA').AsString; except end;
  try SessioneIWA001.Parametri.A029_Straordinario:=QI071.FieldByName('A029_STRAORDINARIO').AsString; except end;
  try SessioneIWA001.Parametri.A029_CauPresenza:=QI071.FieldByName('A029_CAUPRESENZA').AsString; except end;
  try SessioneIWA001.Parametri.LiquidazioneForzata:=QI071.FieldByName('LIQUIDAZIONE_FORZATA').AsString; except end;
  try SessioneIWA001.Parametri.InserimentoMatricole:=QI071.FieldByName('INSERIMENTO_MATRICOLE').AsString; except end;
  try SessioneIWA001.Parametri.InserimentoMatricoleP430:=QI071.FieldByName('INSERIMENTO_MATRICOLE_P430').AsString; except end;
  try SessioneIWA001.Parametri.Storicizzazione:=QI071.FieldByName('STORICIZZAZIONE').AsString; except end;
  try SessioneIWA001.Parametri.StoricizzazioneP430:=QI071.FieldByName('STORICIZZAZIONE_P430').AsString; except end;
  try SessioneIWA001.Parametri.ModificaDecorrenza:=QI071.FieldByName('MODIFICA_DECORRENZA').AsString; except end;
  try SessioneIWA001.Parametri.ModificaDecorrenzaP430:=QI071.FieldByName('MODIFICA_DECORRENZA_P430').AsString; except end;
  try SessioneIWA001.Parametri.EliminaStorici:=QI071.FieldByName('ELIMINA_STORICI').AsString; except end;
  try SessioneIWA001.Parametri.EliminaStoriciP430:=QI071.FieldByName('ELIMINA_STORICI_P430').AsString; except end;
  try SessioneIWA001.Parametri.StoriaInizioFine:=QI071.FieldByName('STORIA_INIZIO_FINE').AsString; except end;
  try SessioneIWA001.Parametri.DefTipoPersonale:=QI071.FieldByName('DEF_TIPO_PERSONALE').AsString; except end;
  try SessioneIWA001.Parametri.ModPersonaleEsterno:=QI071.FieldByName('MOD_PERSONALE_ESTERNO').AsString; except end;
  try SessioneIWA001.Parametri.RipristinoTimbOri:=QI071.FieldByName('RIPRISTINO_TIMB_ORI').AsString; except end;
  try SessioneIWA001.Parametri.MonitorIntegrAnagra:=QI071.FieldByName('MONITOR_INTEGRANAGRA').AsString; except end;
  try SessioneIWA001.Parametri.Layout:=QI071.FieldByName('LAYOUT').AsString; except end;
  try SessioneIWA001.Parametri.AccessibilitaNonVedenti:=QI071.FieldByName('ACCESSIBILITA_NONVEDENTI').AsString; except end;
  try SessioneIWA001.Parametri.A037_EliminaDataCassa:=QI071.FieldByName('ELIMINA_DATA_CASSA').AsString; except end;
  try SessioneIWA001.Parametri.A037_RicreaScaricoPaghe:=QI071.FieldByName('RICREA_SCARICO_PAGHE').AsString; except end;
  try SessioneIWA001.Parametri.C700_SalvaSelezioni:=QI071.FieldByName('C700_SALVASELEZIONI').AsString; except end;
  try SessioneIWA001.Parametri.DatiC700:=QI071.FieldByName('DATIC700').AsString; except end;
  if SessioneIWA001.Parametri.DatiC700 = '' then
    SessioneIWA001.Parametri.DatiC700:='MATRICOLA,T430BADGE,COGNOME,NOME';
  try SessioneIWA001.Parametri.A058_PianifOperativa:=QI071.FieldByName('A058_OPERATIVA').AsString; except end;
  try SessioneIWA001.Parametri.A058_PianifNonOperativa:=QI071.FieldByName('A058_NONOPERATIVA').AsString; except end;
  try SessioneIWA001.Parametri.A094_Mese:=QI071.FieldByName('A094_MESE').AsString; except end;
  try SessioneIWA001.Parametri.A094_Anno:=QI071.FieldByName('A094_ANNO').AsString; except end;
  try SessioneIWA001.Parametri.A094_Raggr:=QI071.FieldByName('A094_RAGGR').AsString; except end;
  try SessioneIWA001.Parametri.A131_AnticipiGestibili:=QI071.FieldByName('A131_ANTICIPIGESTIBILI').AsString; except end;
  try SessioneIWA001.Parametri.A139_ServiziComandati:=QI071.FieldByName('SERVIZI_COMANDATI').AsString; except end;
  try SessioneIWA001.Parametri.A139_ServiziBlocco:=QI071.FieldByName('SERVIZI_BLOCCO').AsString; except end;
  try SessioneIWA001.Parametri.A139_ServiziSblocco:=QI071.FieldByName('SERVIZI_SBLOCCO').AsString; except end;
  try SessioneIWA001.Parametri.S710_SupervisoreValut:=QI071.FieldByName('S710_SUPERVISOREVALUT').AsString; except end;
  try SessioneIWA001.Parametri.S710_ValidaStato:=QI071.FieldByName('S710_VALIDA_STATO').AsString; except end;
  try SessioneIWA001.Parametri.S710_ModValutatore:=QI071.FieldByName('S710_MOD_VALUTATORE').AsString; except end;
  try SessioneIWA001.Parametri.T040_Validazione:=QI071.FieldByName('T040_VALIDAZIONE').AsString; except end;
  try SessioneIWA001.Parametri.WEBIterAssGGPrec:=QI071.FieldByName('WEB_ITERASS_GGPREC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBIterAssGGSucc:=QI071.FieldByName('WEB_ITERASS_GGSUCC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBIterTimbGGPrec:=QI071.FieldByName('WEB_ITERTIMB_GGPREC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCartelliniDataMin:=QI071.FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime; except end;
  try SessioneIWA001.Parametri.WEBCartelliniMMPrec:=QI071.FieldByName('WEB_CARTELLINI_MMPREC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCartelliniMMSucc:=QI071.FieldByName('WEB_CARTELLINI_MMSUCC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCartelliniChiusi:=QI071.FieldByName('WEB_CARTELLINI_CHIUSI').AsString; except end;
  try SessioneIWA001.Parametri.WEBCedoliniDataMin:=QI071.FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime; except end;
  try SessioneIWA001.Parametri.WEBCedoliniMMPrec:=QI071.FieldByName('WEB_CEDOLINI_MMPREC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCedoliniGGEmiss:=QI071.FieldByName('WEB_CEDOLINI_GGEMISS').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCedoliniFilePDF:=QI071.FieldByName('WEB_CEDOLINI_FILEPDF').AsString; except end;
  try SessioneIWA001.Parametri.ModificaDatiProtetti:=QI071.FieldByName('MODIFICA_DATI_PROTETTI').AsString = 'S'; except end;
  try SessioneIWA001.Parametri.WEBRichiestaConsegnaCed:=QI071.FieldByName('WEB_RICHIESTA_CONSEGNA_CED').AsString; except end;
  try SessioneIWA001.Parametri.WEBRegistraConsegnaVal:=QI071.FieldByName('WEB_RICHIESTA_CONSEGNA_VAL').AsString; except end;
  try SessioneIWA001.Parametri.I060_Password:=QI071.FieldByName('I060_PASSWORD').AsString = 'S'; except end;
  try SessioneIWA001.Parametri.I070_Password:=QI071.FieldByName('I070_PASSWORD').AsString = 'S'; except end;
  try SessioneIWA001.Parametri.DownloadMassivoAllegati:=QI071.FieldByName('DOWNLOAD_MASSIVO').AsString = 'S'; except end;

  QI071.Close;
  //Filtro Funzioni
  QI073.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  try
    QI073.Open;
  except
  end;
  QI073.Close;
  if Trim(SessioneIWA001.Parametri.ModuliInstallati) = '' then
    SessioneIWA001.Parametri.RagioneSociale:=I090NONAUTORIZZATA;

  //Filtro Dizionario
  QI074.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  try
    QI074.Open;
  except
  end;
  QI074.Close;

  //Alberto 05/04/2005: il layout deve essere letto sull'azienda di lavoro, e non su MONDOEDP!!!!!!!!
  //(Parametri.Layout viene valorizzato dall'applicativo, su A002UAnagrafeDTM1 e su W001ULogin)
  //T033_LAYOUT di qualsiasi altro utente deve essere disponibile in lettura a MONDOEDP
  //Imposto layout della scheda anagrafica
  A000GetLayout(SessioneIWA001,SessioneMondoEDP);
  selT033.Close;
  //Registro i dati dell'ente
  {$IFDEF IRISWEB}{$IFNDEF WEBPJ}{$IFNDEF INTRAWEBSVC}{$IFNDEF WEBSVC}
  if W000ParConfig.ParametriAvanzati <> '' then
  begin
    with scrI091ParametriAvanzatiB000 do
    begin
      SetVariable('PARAMETRIAVANZATI',W000ParConfig.ParametriAvanzati);
      SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
      SetVariable('VERDB',SessioneIWA001.Parametri.VersioneOracle);
      Execute;
      SessioneMondoEDP.Commit;
    end;
  end;
  {$ENDIF}{$ENDIF}{$ENDIF}{$ENDIF}
  try
    with QI091 do
    begin
      Close;
      SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
      Open;
      SessioneIWA001.Parametri.CampiRiferimento.C1_CedoliniConValuta:=VarToStr(Lookup('Tipo','C1_CEDOLINICONVALUTA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Budget:=VarToStr(Lookup('Tipo','C2_BUDGET','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Livello:=VarToStr(Lookup('Tipo','C2_LIVELLO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Capitolo:=VarToStr(Lookup('Tipo','C2_CAPITOLO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Articolo:=VarToStr(Lookup('Tipo','C2_ARTICOLO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Costo_Orario:=VarToStr(Lookup('Tipo','C2_COSTO_ORARIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_WebSrv_Bilancio:=VarToStr(Lookup('Tipo','C2_WEBSRV_BILANCIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Facoltativo:=VarToStr(Lookup('Tipo','C2_FACOLTATIVO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_IndPres:=VarToStr(Lookup('Tipo','C3_INDPRES','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_IndPres2:=VarToStr(Lookup('Tipo','C3_INDPRES2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_DatoPianificabile:=VarToStr(Lookup('Tipo','C3_DATOPIANIFICABILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_DettGG_TipoI:=VarToStr(Lookup('Tipo','C3_DETTGG_TIPOI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_RiepTurni_IndPres:=VarToStr(Lookup('Tipo','C3_RIEPTURNI_INDPRES','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C4_BuoniMensa:=VarToStr(Lookup('Tipo','C4_BUONIMENSA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C5_IntegrazAnag:=VarToStr(Lookup('Tipo','C5_INTEGRAZANAG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C5_Office:=VarToStr(Lookup('Tipo','C5_OFFICE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C6_InizioProva:=VarToStr(Lookup('Tipo','C6_INIZIOPROVA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C6_DurataProva:=VarToStr(Lookup('Tipo','C6_DURATAPROVA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C7_DATO1:=VarToStr(Lookup('Tipo','C7_DATO1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C7_DATO2:=VarToStr(Lookup('Tipo','C7_DATO2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C7_DATO3:=VarToStr(Lookup('Tipo','C7_DATO3','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C7_InizioSospensione:=VarToStr(Lookup('Tipo','C7_INIZIO_SOSPENSIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C7_EscludeIncentivo:=VarToStr(Lookup('Tipo','C7_ESCLUDE_INCENTIVO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_Missione:=VarToStr(Lookup('Tipo','C8_MISSIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_MissioneCommessa:=VarToStr(Lookup('Tipo','C8_MISSIONECOMMESSA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_Sede:=VarToStr(Lookup('Tipo','C8_SEDE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_GestioneMensile:=VarToStr(Lookup('Tipo','C8_GESTIONEMENSILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032RichiediTipoMissione:=VarToStr(Lookup('Tipo','C8_W032_RICHIEDI_TIPOMISSIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032RichiediTipoRimborso:=VarToStr(Lookup('Tipo','C8_W032_RICHIEDI_TIPORIMBORSO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032DettaglioGG:=VarToStr(Lookup('Tipo','C8_W032_DETTAGLIOGG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032DocumentoMissioni:=VarToStr(Lookup('Tipo','C8_W032_DOCUMENTO_MISSIONI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032RimborsiDett:=VarToStr(Lookup('Tipo','C8_W032_RIMBORSIDETT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032RiapriMissione:=VarToStr(Lookup('Tipo','C8_W032_RIAPRI_MISSIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032TappeSoloSuDistanziometro:=VarToStr(Lookup('Tipo','C8_W032_TAPPE_SOLO_SU_DISTANZIOMETRO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032MessaggioTappeInesistenti:=VarToStr(Lookup('Tipo','C8_W032_MESSAGGIO_TAPPE_INESISTENTI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032CheckPercorso:=VarToStr(Lookup('Tipo','C8_W032_CHECK_PERCORSO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032NoteRimbEditabili:=VarToStr(Lookup('Tipo','C8_W032_NOTERIMB_EDITABILI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032StatoMissioneAutorizzata:=VarToStr(Lookup('Tipo','C8_W032_STATOMISSIONE_AUORIZZATA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032BloccaDate:=VarToStr(Lookup('Tipo','C8_W032_BLOCCA_DATE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C9_ScaricoPaghe:=VarToStr(Lookup('Tipo','C9_SCARICOPAGHE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti:=VarToStr(Lookup('Tipo','C10_FORMAZPROFCRED','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C10_FormazioneProfiloCorso:=VarToStr(Lookup('Tipo','C10_FORMAZPROFCORSO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrariProg:=VarToStr(Lookup('Tipo','C11_PIANIFORARIPROG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_DebGG:=VarToStr(Lookup('Tipo','C11_PIANIFORARI_DEBGG','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_DebGG = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_DebGG:='MODELLO ORARIO';
      SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_NO_CopiaGiustif:=VarToStr(Lookup('Tipo','C11_PIANIFORARI_NO_COPIAGIUSTIF','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_NO_CopiaGiustif = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_NO_CopiaGiustif:='NO';
      SessioneIWA001.Parametri.CampiRiferimento.C12_PreferenzeDestinazione:=VarToStr(Lookup('Tipo','C12_PREFERENZADEST','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C12_PreferenzeCompetenza:=VarToStr(Lookup('Tipo','C12_PREFERENZACOMP','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C13_CdcPercentualizzati:=VarToStr(Lookup('Tipo','C13_CDC_PERCENT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C13_CdcPersConv:=VarToStr(Lookup('Tipo','C13_CDC_PERSCONV','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C14_ProvvSede:=VarToStr(Lookup('Tipo','C14_PROVVSEDE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C15_LimitiMensCaus:=VarToStr(Lookup('Tipo','C15_LIMITIMENSCAUS','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C16_InsRiposi:=VarToStr(Lookup('Tipo','C16_INSRIPOSI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C17_PostiLetto:=VarToStr(Lookup('Tipo','C17_POSTILETTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C18_AccessiMensa:=VarToStr(Lookup('Tipo','C18_ACCESSIMENSA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C20_IncaricoUnitaOrg:=VarToStr(Lookup('Tipo','C20_INCARICOUNITAORG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniLiv1:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_LIV1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniLiv2:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_LIV2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniLiv3:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_LIV3','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniLiv4:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_LIV4','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniRsp1:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_RSP1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniRsp2:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_RSP2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniPnt1:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_PNT1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_EMailDestIndirizzo:=VarToStr(Lookup('Tipo','C21_EMAIL_DEST_INDIRIZZO','Dato'));

      SessioneIWA001.Parametri.CampiRiferimento.C22_EnteGiuridico:=VarToStr(Lookup('Tipo','C22_ENTE_GIURIDICO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C22_InizioRapGiuridico:=VarToStr(Lookup('Tipo','C22_INIZIO_RAP_GIURIDICO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C22_FineRapGiuridico:=VarToStr(Lookup('Tipo','C22_FINE_RAP_GIURIDICO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C22_QualificaGiuridico:=VarToStr(Lookup('Tipo','C22_QUALIFICA_GIURIDICO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C22_DisciplinaGiuridico:=VarToStr(Lookup('Tipo','C22_DISCIPLINA_GIURIDICO','Dato'));
      if R180In(SessioneIWA001.Parametri.CampiRiferimento.C22_InizioRapGiuridico,['','INIZIO']) or
         R180In(SessioneIWA001.Parametri.CampiRiferimento.C22_FineRapGiuridico,['','FINE'])
      then
      begin
        SessioneIWA001.Parametri.CampiRiferimento.C22_InizioRapGiuridico:='';
        SessioneIWA001.Parametri.CampiRiferimento.C22_FineRapGiuridico:='';
      end;

      SessioneIWA001.Parametri.CampiRiferimento.C23_ContrCompetenze:=VarToStr(Lookup('Tipo','C23_CONTR_COMPETENZE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C23_InsNegCatena:=VarToStr(Lookup('Tipo','C23_INSNEG_CATENA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C23_VMHFruizGG:=VarToStr(Lookup('Tipo','C23_VMH_FRUIZGG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C23_VMHCumuloTriennio:=VarToStr(Lookup('Tipo','C23_VMH_CUMULO_TRIENNIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C24_AziendaTipoBudget:=VarToStr(Lookup('Tipo','C24_AZIENDABUDGET','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C25_TimbIrr_Auto:=VarToStr(Lookup('Tipo','C25_TIMBIRR_AUTO','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C25_TimbIrr_Auto = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C25_TimbIrr_Auto:='N';
      SessioneIWA001.Parametri.CampiRiferimento.C26_HintT030V430:=CheckOracleHint(VarToStr(Lookup('Tipo','C26_HINTT030V430','Dato')));
      SessioneIWA001.Parametri.CampiRiferimento.C26_HintT030V430_NC:=CheckOracleHint(VarToStr(Lookup('Tipo','C26_HINTT030V430','Dato')),'+NC');
      SessioneIWA001.Parametri.CampiRiferimento.C26_V430Materializzata:=VarToStr(Lookup('Tipo','C26_V430MATERIALIZZATA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C27_TablespaceFree:=VarToStr(Lookup('Tipo','C27_TABLESPACE_FREE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C28_CancellaAnnoLog:=VarToStr(Lookup('Tipo','C28_CANCELLA_ANNO_LOG','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C28_CancellaAnnoLog = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C28_CancellaAnnoLog:='99';
      SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepFiltro1:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_FILTRO1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepFiltro2:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_FILTRO2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepDatiVis:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_DATIVIS','Dato'));
      // dati modificabili solo se esistono dati visualizzati
      if SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
        SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepDatiModif:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_DATIMODIF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C29_W043_ModReperNumGiorni:=VarToStr(Lookup('Tipo','C29_W043_MODREPER_NUMGIORNI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C29_W043_ModReperOraCutOff:=VarToStr(Lookup('Tipo','C29_W043_MODREPER_ORA_CUTOFF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_DATOAGG1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_DATOAGG2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepDatoMod:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_DATOMOD','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_B021_URL:=VarToStr(Lookup('Tipo','C30_WEBSRV_B021_URL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_A004_URL:=VarToStr(Lookup('Tipo','C30_WEBSRV_A004_URL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_A004_Dati:=VarToStr(Lookup('Tipo','C30_WEBSRV_A004_DATI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_A025_URL_GET:=VarToStr(Lookup('Tipo','C30_WEBSRV_A025_URL_GET','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_A025_URL_PUT:=VarToStr(Lookup('Tipo','C30_WEBSRV_A025_URL_PUT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_B021_TOKEN:=VarToStr(Lookup('Tipo','C30_WEBSRV_B021_TOKEN','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_B021_PASSPHRASE:=R180Decripta(VarToStr(Lookup('Tipo','C30_WEBSRV_B021_PASSPHRASE','Dato')),I091CryptKey);
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_B021_TIMEOUT:=VarToStr(Lookup('Tipo','C30_WEBSRV_B021_TIMEOUT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_X004_URL:=VarToStr(Lookup('Tipo','C30_WEBSRV_X004_URL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C31_NoteGiustificativi:=VarToStr(Lookup('Tipo','C31_NOTEGIUSTIFICATIVI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C31_Giustif_GGMG:=VarToStr(Lookup('Tipo','C31_GIUSTIF_GGMG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C32_CheckAggSchedaAbil:=VarToStr(Lookup('Tipo','C32_CHECK_AGGSCHEDA_ABIL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C32_ScriptAggSchedaAfter:=VarToStr(Lookup('Tipo','C32_SCRIPT_AGGSCHEDA_AFTER','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C32_SaldoMeseCompensato:=VarToStr(Lookup('Tipo','C32_SALDO_MESE_COMPENSATO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C33_Link_I070_T030:=VarToStr(Lookup('Tipo','C33_LINK_I070_T030','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C33_ProxyServer:=VarToStr(Lookup('Tipo','C33_PROXY_SERVER','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C33_ProxyUser:=VarToStr(QI091.Lookup('Tipo','C33_PROXY_USER','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C33_ProxyPassword:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C33_PROXY_PASSWORD','Dato')),I091CryptKey);
      SessioneIWA001.Parametri.CampiRiferimento.C34_CriptaSingoliCedolini:=VarToStr(Lookup('Tipo','C34_CRIPTA_SINGOLI_CEDOLINI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C35_ResiduiTriggerBefore:=VarToStr(Lookup('Tipo','C35_RESIDUI_TRIGGER_BEFORE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C35_ResiduiTriggerAfter:=VarToStr(Lookup('Tipo','C35_RESIDUI_TRIGGER_AFTER','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C36_OrdProfSanCodice:=VarToStr(Lookup('Tipo','C36_ORDPROFSAN_CODICE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C36_OrdProfSanEmailVar:=VarToStr(Lookup('Tipo','C36_ORDPROFSAN_EMAIL_VAR','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C36_OrdProfSan_Campi_Obb:=VarToStr(Lookup('Tipo','C36_ORDPROFSAN_CAMPI_OBB','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_WebSrv_User:=VarToStr(Lookup('Tipo','C40_WEBSRV_USER','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_WebSrv_Pwd:=R180Decripta(VarToStr(Lookup('Tipo','C40_WEBSRV_PWD','Dato')),I091CryptKey);
      SessioneIWA001.Parametri.CampiRiferimento.C40_EnteL104:=VarToStr(Lookup('Tipo','C40_ENTEL104','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_WebSrv_URLL104:=VarToStr(Lookup('Tipo','C40_WEBSRV_URLL104','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_EnteGedap:=VarToStr(Lookup('Tipo','C40_ENTEGEDAP','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_WebSrv_URLGedap:=VarToStr(Lookup('Tipo','C40_WEBSRV_URLGEDAP','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_InvioGedap:=VarToStr(Lookup('Tipo','C40_INVIOGEDAP','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_Qualifica:=VarToStr(Lookup('Tipo','C40_QUALIFICA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_DistaccoSede_ComuneDef:=VarToStr(Lookup('Tipo','C40_DISTACCOSEDE_COMUNEDEF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_DistaccoSede_Comune:=VarToStr(Lookup('Tipo','C40_DISTACCOSEDE_COMUNE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C40_DistaccoSede_Indirizzo:=VarToStr(Lookup('Tipo','C40_DISTACCOSEDE_INDIRIZZO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WebAutorizCurric:=VarToStr(Lookup('Tipo','C90_WEBAUTORIZCURRIC','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailW010Uff:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_W010UFF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailW018Uff:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_W018UFF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailSMTPHost:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SMTPHOST','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailUserName:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_USERNAME','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailHeloName:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_HELONAME','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailPassWord:=R180Decripta(VarToStr(QI091.LookUp('Tipo','C90_EMAIL_PASSWORD','Dato')),30011945);
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailPort:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_PORT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailRespOttimizzata:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_OTTIMIZZATA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailRespGGReinvio:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_GG_REINVIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailRespOggetto:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_OGGETTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailRespTesto:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_TESTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailSenderIndirizzo:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SENDER_INDIRIZZO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailSender:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SENDER','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C90_EMailSender = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C90_EMailSender:='IrisWEB';
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailAuthType:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_AUTHTYPE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailUseTLS:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_USETLS','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WebRighePag:=VarToStr(QI091.Lookup('Tipo','C90_WEBRIGHEPAG','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C90_WebRighePag = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C90_WebRighePag:='10';
      SessioneIWA001.Parametri.CampiRiferimento.C90_WebTipoCambioOrario:=VarToStr(QI091.Lookup('Tipo','C90_WEBTIPOCAMBIOORARIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WebSettCambioOrario:=VarToStr(QI091.Lookup('Tipo','C90_WEBSETTCAMBIOORARIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W005Settimane:=VarToStr(QI091.Lookup('Tipo','C90_W005SETTIMANE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W009AnomBloccanti:=VarToStr(QI091.Lookup('Tipo','C90_W009ANOM_BLOCCANTI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W010CausPres:=VarToStr(QI091.Lookup('Tipo','C90_W010CAUS_PRES','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W010AnomNonBloccanti:=VarToStr(QI091.Lookup('Tipo','C90_W010ANOM_NONBLOCCANTI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W010AcquisizioneAuto:=VarToStr(QI091.Lookup('Tipo','C90_W010ACQUISIZIONE_AUTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W018AcquisizioneAuto:=VarToStr(QI091.Lookup('Tipo','C90_W018ACQUISIZIONE_AUTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W024MMIndietro:=VarToStr(QI091.Lookup('Tipo','C90_W024MMINDIETRO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W024MMIndietroRitardo:=VarToStr(QI091.Lookup('Tipo','C90_W024MMINDIETRORITARDO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026CausE:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUS_E','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026CausU:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUS_U','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026TipoRichiesta:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_RICHIESTA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026Spezzoni:=VarToStr(QI091.Lookup('Tipo','C90_W026SPEZZONI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026IncludiSpezzoniFuoriOrario:=VarToStr(QI091.Lookup('Tipo','C90_W026INCLUDISPEZZONIFUORIORARIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026TipoAutorizzazione:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_AUTORIZZAZIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026TipoStraord:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_STRAORD','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026PianifForzata:=VarToStr(QI091.Lookup('Tipo','C90_W026PIANIF_FORZATA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026UtilizzoDal:=VarToStr(QI091.Lookup('Tipo','C90_W026UTILIZZO_DAL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026UtilizzoAl:=VarToStr(QI091.Lookup('Tipo','C90_W026UTILIZZO_AL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026EccedGGTutta:=VarToStr(QI091.Lookup('Tipo','C90_W026ECCEDGG_TUTTA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026CheckSaldoDisponibile:=VarToStr(QI091.Lookup('Tipo','C90_W026CHECKSALDODISPONIBILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026MMIndietroDal:=VarToStr(QI091.Lookup('Tipo','C90_W026MMINDIETRODAL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026MMIndietroAl:=VarToStr(QI091.Lookup('Tipo','C90_W026MMINDIETROAL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026Arrotondamento:=VarToStr(QI091.Lookup('Tipo','C90_W026ARROTONDAMENTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026SpezzoneMinimo:=VarToStr(QI091.Lookup('Tipo','C90_W026SPEZZONEMINIMO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026SogliaEccedenza:=VarToStr(QI091.Lookup('Tipo','C90_W026SOGLIAECCEDENZA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026EccedOltreDebito:=VarToStr(QI091.Lookup('Tipo','C90_W026ECCEDOLTREDEBITO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026DatiInvisibili:=VarToStr(QI091.Lookup('Tipo','C90_W026DATIINVISIBILI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026AutorizzObbl:=VarToStr(QI091.Lookup('Tipo','C90_W026AUTORIZZ_OBBL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026CausAbbattGiustAss:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUSABBATT_GIUSTASS','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026AccorpaSpezzoni:=VarToStr(QI091.Lookup('Tipo','C90_W026ACCORPA_SPEZZONI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni:=VarToStr(QI091.Lookup('Tipo','C90_W026CONFERMA_AUTORIZZAZIONI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026ModificaTutto:=VarToStr(QI091.Lookup('Tipo','C90_W026MODIFICA_TUTTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_NomeProfiloDelega:=VarToStr(QI091.Lookup('Tipo','C90_NOMEPROFILODELEGA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EmailThread:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_THREAD','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_Lingua:=VarToStr(QI091.Lookup('Tipo','C90_LINGUA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_FiltroDeleghe:=VarToStr(QI091.Lookup('Tipo','C90_FILTRO_DELEGHE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_CronologiaNote:=VarToStr(QI091.Lookup('Tipo','C90_CRONOLOGIA_NOTE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_PathAllegati:=VarToStr(QI091.Lookup('Tipo','C90_PATH_ALLEGATI','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C90_PathAllegati = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C90_PathAllegati:='DB';
      SessioneIWA001.Parametri.CampiRiferimento.C90_IterMaxAllegati:=VarToStr(QI091.Lookup('Tipo','C90_ITER_MAX_ALLEGATI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB:=VarToStr(QI091.Lookup('Tipo','C90_ITER_MAX_DIM_ALLEGATO_MB','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_IterEstensioneAllegato:=VarToStr(QI091.Lookup('Tipo','C90_ITER_ESTENSIONE_ALLEGATO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_IterDimMaxDownloadMassivoMB:=VarToStr(QI091.Lookup('Tipo','C90_ITER_DIM_MAX_ALLEGATI_DOWNLOAD','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_IterNrMaxDownloadMassivo:=VarToStr(QI091.Lookup('Tipo','C90_ITER_NR_MAX_ALLEGATI_DOWNLOAD','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_IterOrdinaDataRichiesta:=VarToStr(QI091.Lookup('Tipo','C90_ITER_ORDINA_DATA_RICHIESTA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_MessaggisticaReply:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_REPLY','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_MessaggisticaObbligoLettura:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_OBBLIGOLETTURA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_MessaggisticaApriDettaglio:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_APRIDETTAGLIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_MessaggiObbligatoriBloccanti:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGI_OBBLIGATORI_BLOCCANTI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W035MaxDimAllegatoMB:=VarToStr(QI091.Lookup('Tipo','C90_W035MAX_DIM_ALLEGATO_MB','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W035MaxAllegati:=VarToStr(QI091.Lookup('Tipo','C90_W035MAX_ALLEGATI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W035QuotaAllegatiMB:=VarToStr(QI091.Lookup('Tipo','C90_W035QUOTA_ALLEGATI_MB','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W035ModalitaCancMessaggiInviati:=VarToStr(QI091.Lookup('Tipo','C90_W035MODALITA_CANC_MESSAGGI_INVIATI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W035MesiDopoInvioCancMessaggi:=VarToStr(QI091.Lookup('Tipo','C90_W035MESI_DOPO_INVIO_CANC_MESSAGGI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_NotificatoreAttivita:=VarToStr(QI091.Lookup('Tipo','C90_NOTIFICATORE_ATTIVITA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_FiltroAnagrafeConsideraRichiesteCessati:=VarToStr(QI091.Lookup('Tipo','C90_FILTROANAG_CONSIDERA_RICH_CESSATI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EmailSincrDominio:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SINCR_DOMINIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_CellulareLunghMin:=VarToStr(QI091.Lookup('Tipo','C90_CELLULARE_LUNGHMIN','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C90_CellulareLunghMin = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C90_CellulareLunghMin:='10';
      SessioneIWA001.Parametri.CampiRiferimento.C90_W034GiornoMeseDispCedolino:=VarToStr(QI091.Lookup('Tipo','C90_W034GIORNO_MESE_DISP_CEDOLINO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W034WSUser:=VarToStr(QI091.Lookup('Tipo','C90_W034WS_USER','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W034WSPassword:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C90_W034WS_PASSWORD','Dato')),I091CryptKey);
      SessioneIWA001.Parametri.CampiRiferimento.C90_W009_WA027_UsaB028:=VarToStr(QI091.Lookup('Tipo','C90_W009_WA027_USA_B028','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038Tolleranza_E:=VarToStr(QI091.Lookup('Tipo','C90_W038TOLLERANZA_E','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038Tolleranza_U:=VarToStr(QI091.Lookup('Tipo','C90_W038TOLLERANZA_U','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038Rilevatore:=VarToStr(QI091.Lookup('Tipo','C90_W038RILEVATORE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038RilevatoreMobile:=VarToStr(QI091.Lookup('Tipo','C90_W038RILEVATORE_MOBILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038FiltroAnagRilevatoreMobile:=VarToStr(QI091.Lookup('Tipo','C90_W038FILTRO_ANAG_RILEVATORE_MOBILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038NumGGVisibili:=VarToStr(QI091.Lookup('Tipo','C90_W038NUMGGVISIBILI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038TimbCausalizzabile:=VarToStr(QI091.Lookup('Tipo','C90_W038TIMBCAUSALIZZABILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038CheckIP:='N';
      {$IFNDEF WEBPJ}
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038CheckIP:=VarToStr(QI091.Lookup('Tipo','C90_W038CHECKIP','Dato'));
      {$ENDIF}
      SessioneIWA001.Parametri.CampiRiferimento.C90_W038TriggerBefore:=VarToStr(QI091.Lookup('Tipo','C90_W038TRIGGERBEFORE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C26_C018_Hint:='N';
      if VarToStr(QI091.Lookup('Tipo','C26_C018_HINT','Dato')) <> '' then
        SessioneIWA001.Parametri.CampiRiferimento.C26_C018_Hint:=VarToStr(QI091.Lookup('Tipo','C26_C018_HINT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C26_C018_Unnest:='N';
      if VarToStr(QI091.Lookup('Tipo','C26_C018_UNNEST','Dato')) <> '' then
        SessioneIWA001.Parametri.CampiRiferimento.C26_C018_Unnest:=VarToStr(QI091.Lookup('Tipo','C26_C018_UNNEST','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_Email_DatiP430:='N';
      if VarToStr(QI091.Lookup('Tipo','C90_EMAIL_DATIP430','Dato')) <> '' then
        SessioneIWA001.Parametri.CampiRiferimento.C90_Email_DatiP430:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_DATIP430','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W010Cancellazione:='N';
      if VarToStr(QI091.Lookup('Tipo','C90_W010CANCELLAZIONE','Dato')) <> '' then
        SessioneIWA001.Parametri.CampiRiferimento.C90_W010Cancellazione:=VarToStr(QI091.Lookup('Tipo','C90_W010CANCELLAZIONE','Dato'));
      //SSO
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_Tipo:=VarToStr(QI091.Lookup('Tipo','C90_SSO_TIPO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_OAUTH2Passphrase:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_PASSPHRASE','Dato')),I091CryptKey);
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_OAUTH2ClientID:=VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_CLIENTID','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_OAUTH2UrlGetToken:=VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_URLGETTOKEN','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_OAUTH2UrlGetUser:=VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_URLGETUSER','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_OAUTH2InfoUser:=VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_INFOUSER','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_SHA1Passphrase:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C90_SSO_SHA1PASSPHRASE','Dato')),I091CryptKey);
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_RDLPassphrase:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C90_SSO_RDLPASSPHRASE','Dato')),I091CryptKey);
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_UsrMask:=VarToStr(QI091.Lookup('Tipo','C90_SSO_USRMASK','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_SSO_TimeOut:=VarToStr(QI091.Lookup('Tipo','C90_SSO_TIMEOUT','Dato'));
      //LArchive
      SessioneIWA001.Parametri.CampiRiferimento.C45_LArchive_ProducerId:=VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_PRODUCERID','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C45_LArchive_TokenJWT:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_TOKENJWT','Dato')),30011945);
      SessioneIWA001.Parametri.CampiRiferimento.C45_LArchive_Scadenza_TokenJWT:=VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_SCADENZA_TOKENJWT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C45_LArchive_URL_Versamento:=VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_URL_VERSAMENTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C45_LArchive_URL_Stato:=VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_URL_STATO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_Contatti_Aziendali:=VarToStr(QI091.Lookup('Tipo','C90_CONTATTI_AZIENDALI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_Contatti_Personali:=VarToStr(QI091.Lookup('Tipo','C90_CONTATTI_PERSONALI','Dato'));
      Close;
    end;
  except
  end;
  //Registro le tabelle su cui è attivato il Log
  try
    with QI092 do
    begin
      Close;
      SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
      Open;
      SessioneIWA001.Parametri.NomiTabelleLog.Clear;
      while not Eof do
      begin
        SessioneIWA001.Parametri.NomiTabelleLog.Add(FieldByName('SCHEDA').AsString);
        Next;
      end;
      Close;
    end;
  except
  end;

  Log('Traccia','ImpostaParametriStandard.Fine');
end;

function TA001FPassWordDtM1.GetCodContrattoVoci(TipoGetCodContratto:String):String;
begin
  if TipoGetCodContratto = 'Contratto base' then
    Result:='EDP'
  else
    Result:='N';
  try
    R180SetVariable(selP210,'SCHEMA',SessioneIWA001.Parametri.Username);
    selP210.Open;
    if not selP210.Eof then
    begin
      if TipoGetCodContratto = 'Contratto base' then
      begin
        if selP210.RecordCount = 1 then
          Result:=selP210.FieldByName('COD_CONTRATTO').AsString
        else if selP210.SearchRecord('COD_CONTRATTO','EDP',[srFromBeginning]) then
          Result:='EDP'
        else if selP210.SearchRecord('COD_CONTRATTO','EDPEL',[srFromBeginning]) then
          Result:='EDPEL';
      end
      else if TipoGetCodContratto = 'Contratto convenzionati' then
        Result:=IfThen(selP210.SearchRecord('COD_CONTRATTO','EDPSC',[srFromBeginning]),'S','N')
      else if TipoGetCodContratto = 'Contratto sanita' then
        Result:=IfThen(selP210.SearchRecord('COD_CONTRATTO','EDP',[srFromBeginning]),'S','N');
    end;
  except
  end;
  selP210.Close;
end;

procedure TA001FPassWordDtM1.OpenI060I070(pTabelle: Array of String; pUtente: string);
  //Valori attesi in pTabelle: 'I060' , 'I070'
var i: integer;
begin
  for i:=0 to High(pTabelle) do
  begin
    if UpperCase(pTabelle[i]) = 'I070' then
    begin
      R180SetVariable(selI070Doppi, 'Azienda', QI090.FieldByName('Azienda').AsString);
      R180SetVariable(selI070Doppi, 'Utente', pUtente);
      selI070Doppi.Open;

      R180SetVariable(QI070, 'Azienda', QI090.FieldByName('Azienda').AsString);
      R180SetVariable(QI070, 'CampoUtente', IfThen(selI070Doppi.RecordCount > 0,'UTENTE','UPPER(UTENTE)'));
      R180SetVariable(QI070, 'Utente', IfThen(selI070Doppi.RecordCount > 0,pUtente,UpperCase(pUtente)));
      QI070.Open;
    end
    else if UpperCase(pTabelle[i]) = 'I060' then
    begin
      R180SetVariable(QI060, 'Azienda', QI090.FieldByName('Azienda').AsString);
      R180SetVariable(QI060, 'Utente', pUtente);
      QI060.Open;
    end;
  end;
end;

function TA001FPassWordDtM1.GetSuffissoLDAP(pTipo: string): string;
  //Valori ammessi per pTipo: I060, I070
begin
  if not R180In(pTipo,['I060','I070']) then
    Exception.Create('GetSuffissoLDAP - Parametro non valido ' + pTipo);
  pTipo:=IfThen(pTipo = 'I060','DIP','USR');
  if QI090.Active and
    (QI090.FieldByName(Format('DOMINIO_%s_TIPO',[pTipo])).AsString = 'LDAP') and
    (not QI090.FieldByName(Format('DOMINIO_%s',[pTipo])).IsNull)
  then
    Result:=QI090.FieldByName('DOMINIO_LDAP_SUFFISSO').AsString
  else
    Result:='';
end;

procedure TA001FPassWordDtM1.RegistraInibizioni;
var
  Riga: String;
begin
  SessioneIWA001.Parametri.Inibizioni.Clear;
  SessioneIWA001.Parametri.SelezioneRichiestaPortale:=False;
  SessioneIWA001.Parametri.OperBloc:=I070Count.Fields[0].AsInteger > 0;
  SessioneIWA001.Parametri.Operatore:=QI070.FieldByName('Utente').AsString;
  SessioneIWA001.Parametri.Azienda:=QI090.FieldByName('Azienda').AsString;
  SessioneIWA001.Parametri.PassOper:=R180DecriptaI070(QI070.FieldByName('PassWD').AsString);
  SessioneIWA001.Parametri.ProgOper:=QI070.FieldByName('Progressivo').AsInteger;
  if QI070.FindField('T030_PROGRESSIVO') <> nil then
    SessioneIWA001.Parametri.ProgressivoOper:=QI070.FieldByName('T030_PROGRESSIVO').AsInteger;
  SessioneIWA001.Parametri.TipoOperatore:='I070';
  try SessioneIWA001.Parametri.IntegrazioneAnagrafe:=QI070.FieldByName('IntegrazioneAnagrafe').AsString; except end;
  try SessioneIWA001.Parametri.ValiditaCessati:=QI070.FieldByName('Validita_cessati').AsInteger; except end;

  QI071.SetVariable('PROFILO',QI070.FieldByName('PERMESSI').AsString);
  QI071.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  QI072.SetVariable('PROFILO',QI070.FieldByName('FILTRO_ANAGRAFE').AsString);
  QI072.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  QI073.SetVariable('PROFILO',QI070.FieldByName('FILTRO_FUNZIONI').AsString);
  QI073.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  QI074.SetVariable('PROFILO',QI070.FieldByName('FILTRO_DIZIONARIO').AsString);
  QI074.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);

  SessioneIWA001.Parametri.ProfiloFiltroPermessi:=QI070.FieldByName('PERMESSI').AsString;
  SessioneIWA001.Parametri.ProfiloFiltroAnagrafe:=QI070.FieldByName('FILTRO_ANAGRAFE').AsString;
  SessioneIWA001.Parametri.ProfiloFiltroFunzioni:=QI070.FieldByName('FILTRO_FUNZIONI').AsString;
  SessioneIWA001.Parametri.ProfiloFiltroDizionario:=QI070.FieldByName('FILTRO_DIZIONARIO').AsString;

  //Filtro Anagrafe
  try
    QI072.Open;
    with QI072 do
    begin
      First;
      SessioneIWA001.Parametri.SelezioneRichiestaPortale:=FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString = 'S';
      while not Eof do
      begin
        Riga:=FieldByName('Filtro').AsString;
        // sostituzione variabili
        Riga:=StringReplace(Riga,':NOME_UTENTE','''' + SessioneIWA001.Parametri.Operatore + '''',[rfReplaceAll,rfIgnoreCase]);
        Riga:=StringReplace(Riga,':UTENTE_AUTENTICATO','''' + SessioneIWA001.Parametri.Operatore + '''',[rfReplaceAll,rfIgnoreCase]);
        if (Pos('--',Riga) > 0) and (R180NumOccorrenzeCar(Copy(Riga,1,Pos('--',Riga) - 1),'''') mod 2 = 0) then
          Riga:=Copy(Riga,1,Pos('--',Riga) - 1);
        SessioneIWA001.Parametri.Inibizioni.Add(Riga);
        Next;
      end;
      SessioneIWA001.Parametri.Inibizioni.Text:=Trim(SessioneIWA001.Parametri.Inibizioni.Text);
      if SessioneIWA001.Parametri.Inibizioni.Text <> '' then
        SessioneIWA001.Parametri.Inibizioni.Text:='(' + SessioneIWA001.Parametri.Inibizioni.Text + ')';
    end;
    QI072.Close;
  except
  end;
  //Imposta SessioneIWA001.Parametri standard
  ImpostaParametriStandard;
end;

function TA001FPassWordDtM1.RegistraInibizioniInfo(NomeProfilo:String = ''; ProfiloObbligatorio:Boolean = True):boolean;
{Profilo obbligatorio: per IrisAPP, se false, consente di andare avanti leggendo tutti i dati anche con profilo nullo}
var
  Riga: String;
begin
  Log('Traccia','RegistraInibizioniInfo.Inizio');
  //Result:=False;

  QI071.Close;
  QI072.Close;
  QI073.Close;
  QI074.Close;

  SessioneIWA001.Parametri.Inibizioni.Clear;
  SessioneIWA001.Parametri.SelezioneRichiestaPortale:=False;
  SessioneIWA001.Parametri.Operatore:=QI060.FieldByName('Nome_Utente').AsString;
  SessioneIWA001.Parametri.Azienda:=QI090.FieldByName('Azienda').AsString;
  SessioneIWA001.Parametri.PassOper:=R180Decripta(QI060.FieldByName('PassWord').AsString,30011945);
  SessioneIWA001.Parametri.ProfiloWEB:='';
  SessioneIWA001.Parametri.TipoOperatore:='I060';

  selI061.Close;
  selI061.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  selI061.SetVariable('NOME_UTENTE',SessioneIWA001.Parametri.Operatore);
  selI061.Open;

  //Ricerco profilo indicato, oppure l'unico esistente
  Result:=selI061.SearchRecord('NOME_PROFILO',NomeProfilo,[srFromBeginning,srIgnoreCase]) or (selI061.RecordCount = 1);
  //Se ci sono più profili, ma nessuno è quello indicato, vedo se ne esiste uno marcato come default
  if not Result then
    Result:=selI061.SearchRecord('LOGIN_DEFAULT','S',[srFromBeginning]);
  if (not Result) and ProfiloObbligatorio then
    exit;

  if Result then
  begin
    SessioneIWA001.Parametri.ProfiloWEB:=selI061.FieldByName('NOME_PROFILO').AsString;
    // MONZA_HSGERARDO - chiamata 88132.ini
    // salva il nome del delegante, se presente
    SessioneIWA001.Parametri.ProfiloWEBDelegatoDa:=selI061.FieldByName('DELEGATO_DA').AsString;
    // MONZA_HSGERARDO - chiamata 88132.fine
    QI071.SetVariable('PROFILO',selI061.FieldByName('PERMESSI').AsString);
    QI071.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    QI072.SetVariable('PROFILO',selI061.FieldByName('FILTRO_ANAGRAFE').AsString);
    QI072.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    QI073.SetVariable('PROFILO',selI061.FieldByName('FILTRO_FUNZIONI').AsString);
    QI073.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    QI074.SetVariable('PROFILO',selI061.FieldByName('FILTRO_DIZIONARIO').AsString);
    QI074.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    SessioneIWA001.Parametri.ProfiloWebIterAutorizzativi:=selI061.FieldByName('ITER_AUTORIZZATIVI').AsString;
    SessioneIWA001.Parametri.ProfiloFiltroPermessi:=selI061.FieldByName('PERMESSI').AsString;
    SessioneIWA001.Parametri.ProfiloFiltroAnagrafe:=selI061.FieldByName('FILTRO_ANAGRAFE').AsString;
    SessioneIWA001.Parametri.ProfiloFiltroFunzioni:=selI061.FieldByName('FILTRO_FUNZIONI').AsString;
    SessioneIWA001.Parametri.ProfiloFiltroDizionario:=selI061.FieldByName('FILTRO_DIZIONARIO').AsString;
  end;

  //Filtro Anagrafe
  QI072.Open;
  with QI072 do
  begin
    First;
    if RecordCount > 0 then
    begin
      SessioneIWA001.Parametri.SelezioneRichiestaPortale:=FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString = 'S';
      while not Eof do
      begin
        Riga:=Trim(FieldByName('Filtro').AsString);
        // sostituzione variabile :NOME_UTENTE: se delegato, è il nome utente del delegante
        if selI061.FieldByName('DELEGATO_DA').IsNull then
          Riga:=StringReplace(Riga,':NOME_UTENTE','''' + SessioneIWA001.Parametri.Operatore + '''',[rfReplaceAll,rfIgnoreCase])
        else
          Riga:=StringReplace(Riga,':NOME_UTENTE','''' + selI061.FieldByName('DELEGATO_DA').AsString + '''',[rfReplaceAll,rfIgnoreCase]);
        // sostituzione variabile :UTENTE_AUTENTICATO: è sempre l'operatore corrente
        Riga:=StringReplace(Riga,':UTENTE_AUTENTICATO','''' + SessioneIWA001.Parametri.Operatore + '''',[rfReplaceAll,rfIgnoreCase]);
        if (Pos('--',Riga) > 0) and (R180NumOccorrenzeCar(Copy(Riga,1,Pos('--',Riga) - 1),'''') mod 2 = 0) then
          Riga:=Copy(Riga,1,Pos('--',Riga) - 1);
        if Trim(Riga) <> '' then
          SessioneIWA001.Parametri.Inibizioni.Add(Riga);
        Next;
      end;
      SessioneIWA001.Parametri.Inibizioni.Text:=Trim(SessioneIWA001.Parametri.Inibizioni.Text);
      if SessioneIWA001.Parametri.Inibizioni.Text <> '' then
        SessioneIWA001.Parametri.Inibizioni.Text:='(' + SessioneIWA001.Parametri.Inibizioni.Text + ')';
      if selI061.FieldByName('AUTO_ESCLUSIONE').AsString = 'S' then
        SessioneIWA001.Parametri.Inibizioni.Text:='(' + IfThen(SessioneIWA001.Parametri.Inibizioni.Text <> '',SessioneIWA001.Parametri.Inibizioni.Text,'1=1') + ' and T030.PROGRESSIVO <> <PROGRESSIVO_UTENTE>)';
    end
    else
    begin
      SessioneIWA001.Parametri.InibizioneIndividuale:=True;
      SessioneIWA001.Parametri.Inibizioni.Add('(MATRICOLA = ''' + QI060.FieldByName('MATRICOLA').AsString + ''')');
    end;
  end;
  QI072.Close;

  //Imposta SessioneIWA001.Parametri standard
  ImpostaParametriStandard;
  Log('Traccia','RegistraInibizioniInfo.Fine');
end;

procedure TA001FPassWordDtM1.QI073AfterOpen(DataSet: TDataSet);
{Registro le inibizioni sulle funzioni}
  function CheckElencoModuli(Applicazione,Moduli:String):Boolean;
  var S:String;
  begin
    Result:=False;
    for S in Moduli.Split([',']) do
      if Applicazione = '' then
        Result:=Result or selI080.SearchRecord('MODULO',R180Cripta(S,14091943),[srFromBeginning])
      else
        Result:=Result or selI080.SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Applicazione,14091943),R180Cripta(S,14091943)]),[srFromBeginning]);
  end;

  function ModuloEsistente(T:Integer):Boolean;
  var i:Integer;
  begin
    Result:=False;
    for i:=1 to High(FunzioniDisponibili) do
      //if ((FunzioniDisponibili[i].A = SessioneIWA001.Parametri.Applicazione) or (FunzioniDisponibili[i].M = 'IRIS_WEB')) and
      if (FunzioniDisponibili[i].T = T) and
         ((FunzioniDisponibili[i].M = 'IRIS_WEB') or L021VerificaApplicazione(SessioneIWA001.Parametri.Applicazione,i))
      then
      begin
        if (Trim(FunzioniDisponibili[i].M) = '')  //non è modulo accessorio
           or
           //funzioni comuni (iris e web): verifico esistenza modulo accessorio (IRIS_WEB, MONITORAGGIO_LOG)
            (R180In(FunzioniDisponibili[i].A,['IRIS','FUNWEB']) and
             //selI080.SearchRecord('MODULO',R180Cripta(FunzioniDisponibili[i].M,14091943),[srFromBeginning])
             CheckElencoModuli('',FunzioniDisponibili[i].M)
            )
           or
           //funzioni specifiche: verifico essitenza modulo accessorio per l'applicativo di riferimento
           ((FunzioniDisponibili[i].A <> 'FUNWEB') and (FunzioniDisponibili[i].A <> 'IRIS') and
            //selI080.SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(FunzioniDisponibili[i].A,14091943),R180Cripta(FunzioniDisponibili[i].M,14091943)]),[srFromBeginning])
            CheckElencoModuli(FunzioniDisponibili[i].A,FunzioniDisponibili[i].M)
           ) then
        begin
          Result:=True;
          {$IFDEF IRISWEB}{$IFNDEF WEBPJ}
            //Funzioni di IrisWEB + Ins.Riposi, Cartoline Mensa e Buoni Pasto
            if (FunzioniDisponibili[i].M <> 'IRIS_WEB') and (not R180In(T,[17,28,36])) then
              Result:=False;//Continue;
          {$ENDIF}{$ENDIF}
        end
        else if (T = 137) and (FunzioniDisponibili[i].S = 'A071') then
        begin
          Result:=selI080.SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(FunzioniDisponibili[i].A,14091943),R180Cripta('CONTEGGIO_PASTI',14091943)]),[srFromBeginning]);
        end;
        Break;
      end;
  end;
  procedure AddModuloInstallato(Modulo:String);
  begin
    if (Pos(#13 + Modulo + #13,#13 + SessioneIWA001.Parametri.ModuliInstallati) = 0) then
      SessioneIWA001.Parametri.ModuliInstallati:=SessioneIWA001.Parametri.ModuliInstallati + Modulo + #13;
  end;
  function CheckInibizione(Value:Char;T:Integer):Char;
  var Modulo:String;
  begin
    Result:=Value;
    if SessioneIWA001.Name = 'B110' then
      Modulo:='IRIS_APP'
    else if SessioneIWA001.Name = 'WEBPJ' then
      Modulo:='IRIS_CLOUD';
    if (not SessioneIWA001.Parametri.ModuloInstallato[Modulo + '_FULL']) then
    try
      R180SetVariable(selI081,'APPLICAZIONE',Modulo);
      selI081.Open;
      if not selI081.SearchRecord('TAG',T,[srFromBeginning]) then
        Result:='N';
    except
      Result:='N';
    end;
  end;
begin
  with selI080 do
  begin
    SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    Open;
    SessioneIWA001.Parametri.ModuliInstallati:='';
    First;
    while not Eof do
    begin
      if R180Decripta(FieldByName('APPLICAZIONE').AsString,14091943) = IfThen(SessioneIWA001.Parametri.Applicazione <> '',SessioneIWA001.Parametri.Applicazione,'RILPRE') then
        AddModuloInstallato(R180Decripta(FieldByName('MODULO').AsString,14091943));
      //per IrisWEB considero i moduli accessori di tutti gli applicativi
      {$IFDEF IRISWEB}{$IFNDEF WEBPJ}
        if R180Decripta(FieldByName('APPLICAZIONE').AsString,14091943) = 'STAGIU' then
          AddModuloInstallato(R180Decripta(FieldByName('MODULO').AsString,14091943));
        if R180Decripta(FieldByName('APPLICAZIONE').AsString,14091943) = 'PAGHE' then
          AddModuloInstallato(R180Decripta(FieldByName('MODULO').AsString,14091943));
      {$ENDIF}{$ENDIF}
      Next;
    end;
  end;

  with QI073 do
  begin
    Filtered:=False;
    SetLength(SessioneIWA001.Parametri.AbilitazioniFunzioni,0);
    //Filter:='GRUPPO <> ''Funzioni WEB''';
    Filter:='(TAG = 100) or (TAG = 83) or (TAG = 84) or (TAG = 87)';
    Filtered:=True;
    if (RecordCount = 0) and (SessioneIWA001.Parametri.Applicazione <> '') and (SessioneIWA001.Parametri.Operatore = 'SYSMAN') then
    begin
      SetLength(SessioneIWA001.Parametri.AbilitazioniFunzioni,4);
      with SessioneIWA001.Parametri.AbilitazioniFunzioni[0] do
      begin
        Funzione:='OpenA008Operatori';
        Descrizione:='Aziende/Operatori';
        Tag:=100;
        Inibizione:='S';
        AccessoBrowse:='S';
        RighePagina:=0;
      end;
      with SessioneIWA001.Parametri.AbilitazioniFunzioni[1] do
      begin
        Funzione:='OpenWA180';
        Descrizione:='Operatori';
        Tag:=83;
        Inibizione:='S';
        AccessoBrowse:='S';
        RighePagina:=0;
      end;
      with SessioneIWA001.Parametri.AbilitazioniFunzioni[2] do
      begin
        Funzione:='OpenWA181';
        Descrizione:='Aziende';
        Tag:=84;
        Inibizione:='S';
        AccessoBrowse:='S';
        RighePagina:=0;
      end;
      with SessioneIWA001.Parametri.AbilitazioniFunzioni[3] do
      begin
        Funzione:='OpenWA184';
        Descrizione:='Filtro funzioni';
        Tag:=87;
        Inibizione:='S';
        AccessoBrowse:='S';
        RighePagina:=0;
      end;
      Filtered:=False;
    end;
    Filtered:=False;
    First;
    //SetLength(SessioneIWA001.Parametri.AbilitazioniFunzioni,0);
    while not Eof do
    begin
      if ModuloEsistente(FieldByName('Tag').AsInteger) then
      begin
        SetLength(SessioneIWA001.Parametri.AbilitazioniFunzioni,Length(SessioneIWA001.Parametri.AbilitazioniFunzioni) + 1);
        with SessioneIWA001.Parametri.AbilitazioniFunzioni[High(SessioneIWA001.Parametri.AbilitazioniFunzioni)] do
        begin
          Funzione:=UpperCase(FieldByName('Funzione').AsString);
          Descrizione:=UpperCase(FieldByName('Descrizione').AsString);
          Tag:=FieldByName('Tag').AsInteger;
          Inibizione:=R180CarattereDef(FieldByName('Inibizione').AsString,1,'N');
          AccessoBrowse:=FieldByName('ACCESSO_BROWSE').AsString;
          RighePagina:=FieldByName('RIGHE_PAGINA').AsInteger;
          //Verifica disponibilità funzione in base alla I081, se applicativo CLOUD o APP e non esiste il corrispodnente modulo FULL
          if (Inibizione <> 'N') and (Tag >= 0) and R180In(SessioneIWA001.Name,['B110','WEBPJ']) then
            Inibizione:=CheckInibizione(Inibizione,Tag);
        end;
      end;
      Next;
    end;
  end;
end;

procedure TA001FPassWordDtM1.QI074AfterOpen(DataSet: TDataSet);
begin
  SetLength(SessioneIWA001.Parametri.FiltroDizionario,0);
  with QI074 do
    while not Eof do
    begin
      SetLength(SessioneIWA001.Parametri.FiltroDizionario,High(SessioneIWA001.Parametri.FiltroDizionario) + 2);
      with SessioneIWA001.Parametri.FiltroDizionario[High(SessioneIWA001.Parametri.FiltroDizionario)] do
      begin
        Tabella:=FieldByName('TABELLA').AsString;
        Codice:=FieldByName('CODICE').AsString;
        Abilitato:=FieldByName('ABILITATO').AsString = 'S';
        Cestino:=False;
      end;
      Next;
    end;
end;

function TA001FPassWordDtM1.AutenticazioneDominio(const DomainName, UserName, Password:String; TipoAutenticazione:String = 'NTLM'; LDAP_DN:String = ''; SuffissoLDAP:String = ''):Boolean;
var AdsOO:Integer;
    Obj:IADs;
    dom:IADsContainer;
    lUser:String;
begin
  // originale
  Result:=False;
  if TipoAutenticazione = 'NTLM' then
    Result:=SSPLogonUser(DomainName, UserName, Password)
  else if TipoAutenticazione = 'AD' then
  begin
     if (not IsLibrary) then
       CoInitialize(nil);
     try
       ADsOO:=ADsOpenObject('WinNT://'+DomainName,UserName,Password,ADS_SECURE_AUTHENTICATION,IADs,Obj);
       Result:=Succeeded(ADsOO);
     except
       Result:=False;
     end;
     if (not IsLibrary) then
       CoUninitialize;
  end
  else if TipoAutenticazione = 'LDAP' then
  begin
     if (not IsLibrary) then
       CoInitialize(nil);
     try
       if Pos(':nome_utente',LDAP_DN.ToLower) = 0 then
         ADsOO:=ADsOpenObject('LDAP://' + DomainName, UserName + IfThen(UpperCase(UserName).IndexOf(UpperCase(SuffissoLDAP)) < 0, SuffissoLDAP), Password,ADS_SECURE_AUTHENTICATION,IADs,dom)
       else
       begin
         lUser:=StringReplace(LDAP_DN,':nome_utente',UserName + IfThen(UpperCase(UserName).IndexOf(UpperCase(SuffissoLDAP)) < 0, SuffissoLDAP),[rfIgnoreCase]);
         ADsOO:=ADsOpenObject('LDAP://' + DomainName,lUser,Password,0,IADs,dom)
       end;
       Result:=ADsOO = S_OK;
     except
       Result:=False;
     end;
     if (not IsLibrary) then
       CoUninitialize;
  end;
end;

procedure TA001FPassWordDtM1.Log(Tipo,S:String);
begin
  {$IFDEF IRISWEB}{$IFNDEF WEBSVC}
  if GGetWebApplicationThreadVar.ActiveForm <> nil then
    (GGetWebApplicationThreadVar.ActiveForm as TWR010FBase).Log(Tipo,S);
  {$ENDIF}{$ENDIF}
end;

procedure TA001FPassWordDtM1.A001FPassWordDtM1Destroy(Sender: TObject);
begin
  QI090.Close;
  QI070.Close;
  QI071.Close;
  QI072.Close;
  QI073.Close;
  QI074.Close;
  I070Count.Close;
  //SessioneMondoEDP.LogOff;
  try
    if (SessioneMondoEDP <> nil) and (SessioneMondoEDP.Name = 'SessioneMondoEDPA001') then
    begin
      SessioneMondoEDP.LogOff;
      FreeAndNil(SessioneMondoEDP);
    end;
  except
  end;
end;

end.

