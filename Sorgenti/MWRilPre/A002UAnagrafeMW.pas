unit A002UAnagrafeMW;

interface

uses
  Windows, Messages, SysUtils, Math, Variants, Classes, Graphics, Controls, Forms, C006UStoriaDati,
  Dialogs, R005UDataModuleMW, Oracle, DB, OracleData,A000UCostanti, A000USessione,C180FunzioniGenerali,
  A000UInterfaccia, Datasnap.DBClient, medpBackupOldValue;

type
  TSQLAppoggio = record
    Colonna:String;
    DecIni:TDateTime;
    OQ:TOracleQuery;
  end;

  TDatiInpShortTerm = record
    Progressivo:Integer;
    TipoRichiamo:String;
    TipoRapporto:String;
    DataRiferimento:TDateTime;
    StartDate:TDateTime;
    CessDate:TDateTime;
  end;

  TPeriodiShortTerm = record
    Tipo:String;
    TipoContratto:String;
    Inizio:TDateTime;
    Fine:TDateTime;
    Giorni:Integer;
    DataFineContrEff:TDateTime;
    DataRegola35Eff:TDateTime;
    DataPensioneEff:TDateTime;
    DataShifEff:TDateTime;
  end;

  TDatiOutShortTerm = record
    Messaggio:String;
    MessaggioBloccante:String;
    NumPeriodi:Integer;
    Periodi:array of TPeriodiShortTerm;
    MessFineContrPrev:String;
    MessRegola35Prev:String;
    MessPensionePrev:String;
    MessShifPrev:String;
  end;

  TA002FAnagrafeMW = class(TR005FDataModuleMW)
    updP430: TOracleQuery;
    UpdT430_IndMat: TOracleQuery;
    GetNuovaMatricola: TOracleQuery;
    QBadgeLibero: TOracleDataSet;
    selT010: TOracleDataSet;
    dsrT010: TDataSource;
    selT220: TOracleDataSet;
    dsrT261: TDataSource;
    dsrT220: TDataSource;
    selT261: TOracleDataSet;
    selT025: TOracleDataSet;
    dsrT025: TDataSource;
    selCodFisc: TOracleDataSet;
    selT430_IntIndMat: TOracleDataSet;
    selI060: TOracleDataSet;
    selT603: TOracleDataSet;
    dsrT603: TDataSource;
    selI500: TOracleDataSet;
    selT485: TOracleDataSet;
    dsrT485: TDataSource;
    selT430_IntPRapp: TOracleDataSet;
    selT470: TOracleDataSet;
    dsrT470: TDataSource;
    selT460: TOracleDataSet;
    dsrT460: TDataSource;
    selT450: TOracleDataSet;
    dsrT450: TDataSource;
    selT270: TOracleDataSet;
    dsrT270: TDataSource;
    selT265: TOracleDataSet;
    dsrT265: TDataSource;
    selP430_count: TOracleDataSet;
    selT430_Decorrenze: TOracleDataSet;
    selT200: TOracleDataSet;
    dsrT200: TDataSource;
    selT163: TOracleDataSet;
    dsrT163: TDataSource;
    selT060: TOracleDataSet;
    dsrT060: TDataSource;
    selT035: TOracleDataSet;
    selVerificaBadge: TOracleDataSet;
    updFine: TOracleQuery;
    selT433: TOracleDataSet;
    selT433_count: TOracleDataSet;
    updT433: TOracleQuery;
    UpdT430Mat: TOracleQuery;
    scrT430: TOracleQuery;
    scrP430: TOracleQuery;
    selT430_InizioFine: TOracleDataSet;
    selT430_PeriodiInvertiti: TOracleDataSet;
    selT430_DatePeriodi: TOracleDataSet;
    selT033_campoDecode: TOracleDataSet;
    scrT030NoTrigger: TOracleQuery;
    selI030: TOracleDataSet;
    selI035: TOracleDataSet;
    selCOLS: TOracleDataSet;
    selI090_GruppoBadge: TOracleDataSet;
    dsrT440: TDataSource;
    selT440: TOracleDataSet;
    selT430_AziendaPrec: TOracleDataSet;
    selT430_ShortTerm: TOracleDataSet;
    cdsShortTerm: TClientDataSet;
    dsrShortTerm: TDataSource;
    GetCatena: TOracleQuery;
    selT030Lock: TOracleQuery;
    selCountI060: TOracleQuery;
    selI060Prog: TOracleDataSet;
    selI060ProgAZIENDA: TStringField;
    selI060ProgMATRICOLA: TStringField;
    selI060ProgNOME_UTENTE: TStringField;
    selI060ProgD_PASSWORD: TStringField;
    selI060ProgPASSWORD: TStringField;
    selI060ProgDATA_PW: TDateTimeField;
    selI060ProgEMAIL: TStringField;
    selI060ProgEMAIL_PEC: TStringField;
    selI060ProgCELLULARE: TStringField;
    dsrI060Prog: TDataSource;
    selI061: TOracleDataSet;
    dsrI061: TDataSource;
    selI061AZIENDA: TStringField;
    selI061NOME_UTENTE: TStringField;
    selI061NOME_PROFILO: TStringField;
    selI061PERMESSI: TStringField;
    selI061FILTRO_FUNZIONI: TStringField;
    selI061FILTRO_ANAGRAFE: TStringField;
    selI061FILTRO_DIZIONARIO: TStringField;
    selI061INIZIO_VALIDITA: TDateTimeField;
    selI061FINE_VALIDITA: TDateTimeField;
    selI061DELEGATO_DA: TStringField;
    selI061ULTIMO_ACCESSO: TDateTimeField;
    selI061ULTIMO_INVIO_MAIL: TDateTimeField;
    selI061ITER_AUTORIZZATIVI: TStringField;
    selI061RICEZIONE_MAIL: TStringField;
    selI061LOGIN_DEFAULT: TStringField;
    selI061PROFILO_DELEGATO: TStringField;
    selI061DELEGA_INSERITA_DA: TStringField;
    selI061AUTO_ESCLUSIONE: TStringField;
    selP441: TOracleDataSet;
    updRapportiUnificati: TOracleQuery;
    selI060ProgCELLULARE_PERSONALE: TStringField;
    selI060ProgEMAIL_PERSONALE: TStringField;
    procedure selT010AfterOpen(DataSet: TDataSet);
    procedure selT035AfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selI030FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure selI060ProgAfterScroll(DataSet: TDataSet);
    procedure selI060ProgCalcFields(DataSet: TDataSet);
  private
    (*Dataset su T030 e T430.
      IrisWIn e WebPJ li definiscono in modo leggermente diverso e non è possibile definirli in questa classe.
      Vengono impostati in fase di creazione e usati per le funzioni esposte dal MW
    *)
    FselT030_Funzioni: TOracleDataset;
    FselT430_Funzioni: TOracleDataset;
    VSQLAppoggio:array of TSQLAppoggio;
    function ControlloBadge(Dal,Al:TDateTime): TStringList;
    procedure CompletaSQLRelazione(var RelSQL:String);
    function RicercaPrimoPeriodo(DatiOutShortTerm: TDatiOutShortTerm; MaxPausa:Integer): Integer;
    procedure AllineaDatasetI060Prog_I061;
  public
    selT430OldValues:TmedpBackupOldValue;
    function CountAnagraficheStipendiali(Progressivo: Integer; DataOld,DataNew: TDateTime) :Integer;
    function GetReadBuffer(NomeTabella,Storico:String):Integer;
    function NuovoProgressivo:Integer;
    function VerificaCFCambiato(CodCatastale: String): String;
    function VerificaCFUsato: String;
    function VerificaCampiNonAbilitati(Prog:Integer;DataOld:TDateTime):String;
    function VerificaCampiNonStoricizzabili:String;
    function VerificaIntersezionePeriodiIndMat: String;
    function VerificaIntersezionePeriodiRappIndMat: String;
    function VerificaBadge(Inserimento,Storicizza: Boolean; PrimaDecorrenza: TDateTime; StoriciPrec,StoriciSucc: Boolean): TStringList;
    function VerificaBadgeServizio: Boolean;
    function VerificaInizioRapportoInterseca(var sDate: String): Boolean;
    function VerificaPeriodiInvertiti(var sDate: String): Boolean;
    function VerificaDatePeriodi(var sDate: String): Boolean;
    function VerificaCedAntePrimoStoricoStip(): Boolean;
    procedure AggiornaDecorrenzaStipendiale (NewDate: TDateTime);
    procedure AggiornaPeriodoIndMat;
    procedure AggiornaFine(Storicizza: String);
    procedure AggiornaRapportiUnificati(Storicizza: String);
    function VerificaCdCPercentualizzati(StoriciPrec,StoriciSucc: Boolean; PrimaDecorrenza:TDateTime; var DataDecMod:TDateTime;var Automatismo: Boolean): Boolean;
    function AggiornaPeriodiStorici :Boolean;
    procedure NoTrigger(Istante: TDateTime;Inserisci: String);
    function CreaSQLRelazione(bData: Boolean):String;
    function EseguiSQLRelazione(SqlRelazione: String): TOracleQuery;
    procedure RefreshVSQLAppoggio;
    function ImpostaValoreRelazione: Boolean;
    procedure FiltroDizionarioBeforePost(Campo,Dizionario,Caption:String);
    function ShortTerm(DatiInpShortTerm: TDatiInpShortTerm): TDatiOutShortTerm;
    procedure CaricaCdsShortTerm(DatiOutShortTerm: TDatiOutShortTerm);
    function FormattaEMail(pMatricola, pI060Mail:string):string;
    function GetDatoI060(const PMatricola, PNomeDato: string; const PSeparatore: string = '; '): string;
    function TryLockRecordT030(const PProgressivo: Integer): Boolean;
    procedure UnlockRecordT030Rollback;
    function EsistonoLoginWeb(const PProg: Integer): Boolean;
    procedure ApriDatasetLoginProfili(const PProg: Integer);
    procedure SetVisioneCorrenteProfili(const PVisioneCorrente: Boolean);
    property selT030_Funzioni: TOracleDataset read FselT030_Funzioni write FselT030_Funzioni;
    property selT430_Funzioni: TOracleDataset read FselT430_Funzioni write FselT430_Funzioni;
  end;

implementation

{$R *.dfm}

function TA002FAnagrafeMW.FormattaEMail(pMatricola, pI060Mail:string):string;
var
  EMail1, Email2:String;
begin
  Result:='';
  R180SetVariable(selI060,'Azienda',Parametri.Azienda);
  R180SetVariable(selI060,'Matricola',pMatricola);
  try
    selI060.Open;
    selI060.First;
    while not selI060.Eof do //potrebbero esserci più account per la stessa matricola
    begin
      EMail1:=Trim(selI060.FieldByName(pI060Mail).AsString) + ';';
      while Pos(';',EMail1) > 0 do //potrebbero esserci più email per lo stesso account
      begin
        EMail2:=Trim(Copy(EMail1,1,Pos(';',EMail1) - 1));
        if (EMail2 <> '')
        and (Pos(';' + EMail2 + ';',';' + Result) = 0) then
          Result:=Result + EMail2 + ';';
        EMail1:=Copy(EMail1,Pos(';',EMail1) + 1);
      end;
      selI060.Next;
    end;
  except
    //Se fallisce l'apertura della I060 annullo l'eccezione
  end;
  Result:=Copy(Result,1,Length(Result) - 1);
  Result:=StringReplace(Result,';','; ',[rfReplaceAll]);
end;

function TA002FAnagrafeMW.GetDatoI060(const PMatricola, PNomeDato: string; const PSeparatore: string = '; '): string;
var
  LDato: string;
begin
  Result:='';
  try
    // ciclo sugli account legati alla matricola per estrarre il dato
    R180SetVariable(selI060,'Azienda',Parametri.Azienda);
    R180SetVariable(selI060,'Matricola',PMatricola);
    selI060.Open;
    selI060.First;
    while not selI060.Eof do
    begin
      LDato:=selI060.FieldByName(PNomeDato).AsString.Trim;
      if LDato <> '' then
        Result:=Result + LDato + PSeparatore;
      selI060.Next;
    end;
  except
    // eccezione silenziosa
  end;
  if Result.EndsWith(PSeparatore) then
    Result:=Result.Substring(0,Result.Length - PSeparatore.Length);
end;

procedure TA002FAnagrafeMW.AggiornaDecorrenzaStipendiale(NewDate: TDateTime);
begin
  //Aggiorno la minima data decorrenza stipendiale, in modo che la Allinea_Periodi_Storici non annulli la posticipazione
  updP430.SetVariable('DATA_NEW',R180InizioMese(NewDate));
  updP430.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  updP430.Execute;
end;

procedure TA002FAnagrafeMW.AggiornaFine(Storicizza: String);
begin
  if (FselT430_Funzioni.State = dsEdit) and (FselT430_Funzioni.FieldByName('FINE').AsDateTime <> FselT430_Funzioni.FieldByName('FINE').medpOldValue) then
    with updFine do
    begin
      ClearVariables;
      SetVariable('PROGRESSIVO',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('RIGAID',FselT430_Funzioni.RowID);
      SetVariable('STORICIZZA',Storicizza);
      SetVariable('INIZIO',FselT430_Funzioni.FieldByName('INIZIO').AsDateTime);
      if not FselT430_Funzioni.FieldByName('FINE').IsNull then
        SetVariable('FINE',FselT430_Funzioni.FieldByName('FINE').AsDateTime);
      Execute;
    end;
end;

procedure TA002FAnagrafeMW.AggiornaRapportiUnificati(Storicizza: String);
begin
  if (FselT430_Funzioni.State = dsEdit) and (FselT430_Funzioni.FieldByName('RAPPORTI_UNIFICATI').AsString <> FselT430_Funzioni.FieldByName('RAPPORTI_UNIFICATI').medpOldValue) then
    with updRapportiUnificati do
    begin
      ClearVariables;
      SetVariable('PROGRESSIVO',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('RIGAID',FselT430_Funzioni.RowID);
      SetVariable('STORICIZZA',Storicizza);
      SetVariable('INIZIO',FselT430_Funzioni.FieldByName('INIZIO').AsDateTime);
      SetVariable('RAPPORTI_UNIFICATI',FselT430_Funzioni.FieldByName('RAPPORTI_UNIFICATI').AsString);
      Execute;
    end;
end;

procedure TA002FAnagrafeMW.AggiornaPeriodoIndMat;
begin
  UpdT430_IndMat.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  UpdT430_IndMat.SetVariable('INIZIO_IND_MAT_OLD',selT430OldValues.FieldByName('INIZIO_IND_MAT').Value);
  UpdT430_IndMat.SetVariable('INIZIO_IND_MAT',FselT430_Funzioni.FieldByName('INIZIO_IND_MAT').Value);
  UpdT430_IndMat.SetVariable('FINE_IND_MAT_OLD',selT430OldValues.FieldByName('FINE_IND_MAT').Value);
  UpdT430_IndMat.SetVariable('FINE_IND_MAT',FselT430_Funzioni.FieldByName('FINE_IND_MAT').Value);
  UpdT430_IndMat.SetVariable('ROWID',FselT430_Funzioni.RowId);
  UpdT430_IndMat.Execute;
end;

function TA002FAnagrafeMW.AggiornaPeriodiStorici: Boolean;
//Compatta ed espande i periodi storici considerando anche gli storici dei dati liberi
begin
  scrT430.SetVariable('Progressivo',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  scrT430.Execute;
  Result:=True;

  //Segnalazione errore di dipendente occupato
  if  VarToStr(scrT430.GetVariable('Errore')) = 'OC' then
    Result:=False
  else
  begin
    scrP430.SetVariable('Progressivo',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    try
      scrP430.Execute;
    except
    end;
    //Segnalazione errore di dipendente occupato
    if VarToStr(scrP430.GetVariable('Errore')) = 'OC' then
      Result:=False;
  end;
end;

function TA002FAnagrafeMW.CountAnagraficheStipendiali(Progressivo: Integer; DataOld,DataNew: TDateTime): Integer;
begin
  with selP430_count do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA_OLD',DataOld);
    SetVariable('DATA_NEW',DataNew);
    Open;
    Result:=FieldByName('ANAGRAFICHE_STIPENDIALI').AsInteger;
  end;
end;

function TA002FAnagrafeMW.GetReadBuffer(NomeTabella,Storico:String):Integer;
begin
  Result:=100;
  try
    with TOracleQuery.Create(nil) do
    try
      Session:=SessioneOracle;
      if Storico = 'S' then
        SQL.Add('select max(count(*)) from ' + NomeTabella + ' group by DECORRENZA_FINE')
      else
        SQL.Add('select count(*) from ' + NomeTabella);
      Execute;
      Result:=FieldAsInteger(0);
      Result:=max(Result,10);
      Result:=Result + trunc(Result * 0.1);
    finally
      Free;
    end;
  except
  end;
end;

function TA002FAnagrafeMW.CreaSQLRelazione(bData: Boolean): String;
var
  SqlRelazione: String;
  OldColonna: String;
  OldDecorrenza: TDateTime;
begin
  with selI035 do
  begin
    SqlRelazione:='';
    if SearchRecord('COLONNA;DECORRENZA',VarArrayOf([selI030.FieldByName('COLONNA').AsString,selI030.FieldByName('DECORRENZA').AsDateTime]),[srFromBeginning]) then
    begin
      OldColonna:=FieldByName('COLONNA').AsString;
      OldDecorrenza:=FieldByName('DECORRENZA').AsDateTime;
      while not Eof do
      begin
        if (OldColonna = FieldByName('COLONNA').AsString) and
           (OldDecorrenza = FieldByName('DECORRENZA').AsDateTime) then
        begin
          SqlRelazione:=SqlRelazione + ' ' + FieldByName('RELAZIONE').AsString;
          if (bData) and (Pos('ORDER BY',FieldByName('RELAZIONE').AsString) = 0) then
            SqlRelazione:=SqlRelazione + ' AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE';
        end
        else
          Break;
        OldColonna:=FieldByName('COLONNA').AsString;
        OldDecorrenza:=FieldByName('DECORRENZA').AsDateTime;
        Next;
      end;
    end;
  end;
  if Trim(SqlRelazione) <> '' then
    CompletaSQLRelazione(SqlRelazione);

  Result:=SqlRelazione;
end;

procedure TA002FAnagrafeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;

  selI030.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selI030),'N');
  selI035.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selI035),'N');
  selT010.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT010),'N');
  selT025.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT025),'N');
  selT060.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT060),'N');
  selT163.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT163),'N');
  selT200.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT200),'N');
  selT220.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT220),'S');
  selT261.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT261),'N');
  selT270.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT270),'N');
  selT450.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT450),'N');
  selT460.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT460),'N');
  selT470.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT470),'N');
  selT485.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT485),'N');
  selT603.ReadBuffer:=GetReadBuffer(R180Query2NomeTabella(selT603),'N');

  selT035.Open;
  selT440.SetVariable('DESCRIZIONE_BASE',Parametri.RagioneSociale);
  selCOLS.Open;
  cdsShortTerm.CreateDataSet;
  cdsShortTerm.LogChanges:=False;

  selT430OldValues:=TmedpBackupOldValue.Create(Self);
end;

procedure TA002FAnagrafeMW.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  selT035.Close;
  for i:=High(VSQLAppoggio) downto 0 do
    VSQLAppoggio[i].OQ.Free;
  SetLength(VSQLAppoggio,0);
inherited;
end;

function TA002FAnagrafeMW.EseguiSQLRelazione(SqlRelazione: String): TOracleQuery;
var
  TrovRel: Boolean;
  i: Integer;
  SqlOriginale: String;
begin
  TrovRel:=False;
  Result:=nil;
  for i:=0 to High(VSQLAppoggio) do
    if  (VSQLAppoggio[i].Colonna = selI030.FieldByName('COLONNA').AsString)
         and (VSQLAppoggio[i].DecIni  = selI030.FieldByName('DECORRENZA').AsDateTime) then
    begin
      TrovRel:=True;
      Break;
    end;
    if TrovRel then
    begin
      with VSQLAppoggio[i].OQ do
      begin
        if (Trim(SqlRelazione) <> Trim(Sql.Text)) then
        begin
          SqlOriginale:=Sql.Text;
          Sql.Text:=SqlRelazione;
          try
            Execute;
          except
            Sql.Text:=SqlOriginale;
            Execute;
          end;
        end;
        Result:=VSQLAppoggio[i].OQ;
      end;
    end;
end;

function TA002FAnagrafeMW.ImpostaValoreRelazione: Boolean;
var
  ValoreDefault,SqlRelazione: String;
  OQ: TOracleQuery;
begin
  Result:=False;
  if (selI030.FieldByName('TIPO').AsString = 'S')
     or (
       (selI030.FieldByName('TIPO').AsString = 'L')
       and (
         (FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString = '')
          or (FselT430_Funzioni.State in [dsInsert])
       )
     ) then
  begin
    SqlRelazione:=CreaSQLRelazione(False);
    if Trim(SqlRelazione) <> '' then
    begin
      //Cerco la relazione salvata
      OQ:=EseguiSQLRelazione(SqlRelazione);
      if OQ <> nil then
      begin
        Result:=True;
        if OQ.RowCount = 0 then
          FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString:=''
        else
        begin
          OQ.First;
          if (OQ.FieldAsString(0) = '') and (OQ.RowsProcessed > 1) then
            OQ.Next;
          FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString:=OQ.FieldAsString(0);
        end;

        if FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString = '' then
          if selCOLS.SearchRecord('COLUMN_NAME',VarArrayOf([selI030.FieldByName('COLONNA').AsString]),[srFromBeginning]) then
          begin
            ValoreDefault:=Trim(selCOLS.FieldByName('DATA_DEFAULT').AsString);
            if (Copy(ValoreDefault,1,1) = '''') and (Copy(ValoreDefault,Length(ValoreDefault),1) = '''') then
              ValoreDefault:=Copy(ValoreDefault,2,Length(ValoreDefault)-2);
            FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString:=ValoreDefault;
          end;
      end;
    end;
  end;
end;

procedure TA002FAnagrafeMW.NoTrigger(Istante: TDateTime;Inserisci: String);
begin
  try
    scrT030NoTrigger.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('Progressivo').AsInteger);
    scrT030NoTrigger.SetVariable('ISTANTE',Istante);
    scrT030NoTrigger.SetVariable('INSERISCI',Inserisci);
    scrT030NoTrigger.Execute;
  except
  
  end;
end;

function TA002FAnagrafeMW.NuovoProgressivo: Integer;
begin
  with selT035 do
  begin
    Refresh;
    Edit;
    if FieldByName('Progressivo').IsNull then
      FieldByName('Progressivo').AsInteger:=1
    else
      FieldByName('Progressivo').AsInteger:=FieldByName('Progressivo').AsInteger + 1;
    Post;
    Result:=FieldByName('Progressivo').AsInteger;
  end;
end;

procedure TA002FAnagrafeMW.RefreshVSQLAppoggio;
var i:Integer;
begin
  selI030.First;
  for i:=High(VSQLAppoggio) downto 0 do
    VSQLAppoggio[i].OQ.Free;
  SetLength(VSQLAppoggio,0);
  while not selI030.Eof do
  begin
    SetLength(VSQLAppoggio,Length(VSQLAppoggio) + 1);
    i:=High(VSQLAppoggio);
    VSQLAppoggio[i].Colonna:=selI030.FieldByName('COLONNA').AsString;
    VSQLAppoggio[i].DecIni:=selI030.FieldByName('DECORRENZA').AsDateTime;
    VSQLAppoggio[i].OQ:=TOracleQuery.Create(nil);
    VSQLAppoggio[i].OQ.ReadBuffer:=2;
    VSQLAppoggio[i].OQ.Scrollable:=True;
    VSQLAppoggio[i].OQ.Session:=SessioneOracle;
    selI030.Next;
  end;
  selI030.First;
end;

procedure TA002FAnagrafeMW.selI030FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if FselT430_Funzioni.Active then
    if FselT430_Funzioni.FieldByName('DATAFINE').IsNull then
      Accept:=selI030.FieldByName('DECORRENZA_FINE').AsDateTime = EncodeDate(3999,12,31)
    else
      Accept:=(selI030.FieldByName('DECORRENZA').AsDateTime <= FselT430_Funzioni.FieldByName('DATAFINE').AsDateTime) and
              (selI030.FieldByName('DECORRENZA_FINE').AsDateTime >= FselT430_Funzioni.FieldByName('DATAFINE').AsDateTime);
end;

procedure TA002FAnagrafeMW.selI060ProgAfterScroll(DataSet: TDataSet);
begin
  AllineaDatasetI060Prog_I061;
end;

procedure TA002FAnagrafeMW.selI060ProgCalcFields(DataSet: TDataSet);
begin
  if selI060Prog.FieldByName('PASSWORD').IsNull then
    selI060Prog.FieldByName('D_PASSWORD').AsString:='<No password>'
  else
    selI060Prog.FieldByName('D_PASSWORD').AsString:=StringReplace(Format('%*s',[Length(selI060Prog.FieldByName('PASSWORD').AsString),'*']),' ','*',[rfReplaceAll]);
end;

procedure TA002FAnagrafeMW.selT010AfterOpen(DataSet: TDataSet);
begin
  if DataSet = selT470 then
    DataSet.Fields[0].DisplayWidth:=10
  else
    DataSet.Fields[0].DisplayWidth:=Trunc(DataSet.Fields[0].Size * 1.5) + 1;
end;

procedure TA002FAnagrafeMW.selT035AfterOpen(DataSet: TDataSet);
begin
  inherited;
  if selT035.RecordCount = 0 then
    selT035.AppendRecord([0,0,0]);
end;

procedure TA002FAnagrafeMW.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  (*
  Accept:=True;
  if FselT430_Funzioni.State <> dsEdit then
    exit;
  *)
  if DataSet = selT010 then
    Accept:=A000FiltroDizionario('CALENDARI',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT163 then
    Accept:=A000FiltroDizionario('PROFILI INDENNITA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT220 then
    Accept:=A000FiltroDizionario('PROFILI ORARIO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT261 then
    Accept:=A000FiltroDizionario('PROFILI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT603 then
    Accept:=A000FiltroDizionario('SQUADRE TURNI',DataSet.FieldByName('CODICE').AsString);
end;

//Controllo che il badge assegnato non sia già utilizzato da altri dipendenti
function TA002FAnagrafeMW.VerificaInizioRapportoInterseca(var sDate: String): Boolean;
begin
  Result:=True;
  with selT430_InizioFine do
  begin
    SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    Close;
    Open;
    if not FieldByName('INIZIO').IsNull then
    begin
      sDate:=DateToStr(FieldByName('INIZIO').AsDateTime);
      Result:=False;
    end;
    Close;
  end;
end;

function TA002FAnagrafeMW.VerificaPeriodiInvertiti(var sDate: String): Boolean;
begin
  Result:=True;
  with selT430_PeriodiInvertiti do
  begin
    SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    Close;
    Open;
    if not FieldByName('INIZIO').IsNull then
    begin
      Result:=False;
      sDate:=DateToStr(FieldByName('INIZIO').AsDateTime);
    end;
    Close;
  end;

end;

function TA002FAnagrafeMW.VerificaBadge(Inserimento,Storicizza: Boolean; PrimaDecorrenza: TDateTime; StoriciPrec,StoriciSucc: Boolean): TStringList;
var
  DataInizio,DataFine: TDateTime;
begin
  Result:=nil;
  with FselT430_Funzioni do
  begin
    if (Inserimento and not FieldByName('BADGE').IsNull) or
       (not Inserimento and
       ((selT430OldValues.FieldByName('BADGE').Value <> FieldByName('BADGE').Value) or
        (selT430OldValues.FieldByName('DATADECORRENZA').Value > FieldByName('DATADECORRENZA').Value) or
        (selT430OldValues.FieldByName('INIZIO').Value <> FieldByName('INIZIO').Value) or
        (selT430OldValues.FieldByName('FINE').Value <> FieldByName('FINE').Value))) then
    begin
      if Inserimento then //Inserimento nuovo dipendente
      begin
        if not FieldByName('INIZIO').IsNull then
          DataInizio:=FieldByName('INIZIO').AsDateTime
        else
          DataInizio:=FieldByName('DATADECORRENZA').AsDateTime;
        DataFine:=EncodeDate(3999,12,31);
      end
      else if Storicizza then  //Storicizzazione dati di un dipendente
      begin
        if FieldByName('INIZIO').AsDateTime > FieldByName('DATADECORRENZA').AsDateTime then
          DataInizio:=FieldByName('INIZIO').AsDateTime
        else
          DataInizio:=FieldByName('DATADECORRENZA').AsDateTime;
        if StoriciPrec then
          DataInizio:=PrimaDecorrenza;
        if StoriciSucc then
          DataFine:=EncodeDate(3999,12,31)
        else
          DataFine:=FieldByName('DATAFINE').AsDateTime;
      end
      else  //Modifica dati di un dipendente
      begin
        if FieldByName('INIZIO').AsDateTime > FieldByName('DATADECORRENZA').AsDateTime then
          DataInizio:=FieldByName('INIZIO').AsDateTime
        else
          DataInizio:=FieldByName('DATADECORRENZA').AsDateTime;

        if StoriciSucc then
          DataFine:=EncodeDate(3999,12,31)
        else
          DataFine:=FieldByName('DataFine').AsDateTime;
      end;

      Result:=ControlloBadge(DataInizio,DataFine);
    end;
  end;
end;

function TA002FAnagrafeMW.VerificaBadgeServizio: Boolean;
begin
  //Controllo edizione badge <> 'BS' usata per i badge di servizio   //Lorena 31/08/2006
  Result:=True;
  with TStringList.Create do
  try
    Clear;
    CommaText:=FselT430_Funzioni.FieldByName('EDBADGE').AsString;
    if IndexOf('BS') <> -1 then
      Result:=False;
  finally
    Free;
  end;
end;

function TA002FAnagrafeMW.VerificaCdCPercentualizzati(StoriciPrec,StoriciSucc: Boolean; PrimaDecorrenza:TDateTime;var DataDecMod:TDateTime; var Automatismo: Boolean): Boolean;
var
  DataFinMod:TDateTime;
begin
  Result:=False;
  //Se è cambiato il valore del centro di costo
  if (Parametri.CampiRiferimento.C13_CdcPercentualizzati <> '')
  and (FselT430_Funzioni.FieldByName(Parametri.CampiRiferimento.C13_CdcPercentualizzati).Value <> selT430OldValues.FieldByName(Parametri.CampiRiferimento.C13_CdcPercentualizzati).Value) then
  begin
    //Inizializzo le variabili
    Automatismo:=False;
    DataDecMod:=FselT430_Funzioni.FieldByName('DATADECORRENZA').AsDateTime;
    if StoriciPrec then
      DataDecMod:=PrimaDecorrenza;
    DataFinMod:=FselT430_Funzioni.FieldByName('DATAFINE').AsDateTime;
    if StoriciSucc then
      DataFinMod:=EncodeDate(3999,12,31);
    //Estraggo le percentualizzazioni intersecate
    selT433.Close;
    selT433.SetVariable('PROGRESSIVO',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    selT433.SetVariable('DATADECORRENZA_MOD',DataDecMod);
    selT433.SetVariable('DATAFINE_MOD',DataFinMod);
    selT433.Open;
    //Se non interseco niente, esco
    if selT433.RecordCount = 0 then
      exit
    //Se interseco una sola percentualizzazione, verifico che non ce ne siano di successive
    else if selT433.RecordCount = 1 then
    begin
      selT433_count.Close;
      selT433_count.SetVariable('PROGRESSIVO',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
      selT433_count.SetVariable('DECORRENZA',selT433.FieldByName('Decorrenza').AsDateTime);
      selT433_count.Open;
      Automatismo:=selT433_count.FieldByName('Successive').AsInteger = 0;
    end;
    Result:=True;
  end;
end;

procedure TA002FAnagrafeMW.CompletaSQLRelazione(var RelSQL: String);
var
  NewCampo,OldCampo:String;
begin
  RelSQL:=Trim(RelSQL);
  while Pos('<#>',RelSQL) <> 0 do
  begin
    OldCampo:=Copy(RelSQL,Pos('<#>',RelSQL)+3,Pos('<#>',Copy(RelSQL,Pos('<#>',RelSQL)+3))-1);
    if OldCampo = 'DECORRENZA' then
      NewCampo:='DATADECORRENZA'
    else if OldCampo = 'DECORRENZA_FINE' then
      NewCampo:='DATAFINE'
    else if OldCampo = ';' then
      NewCampo:=' UNION SELECT '
    else if OldCampo = 'W' then
      NewCampo:=' FROM DUAL WHERE '
    else if OldCampo = 'D' then
      NewCampo:=' FROM DUAL '
    else
      NewCampo:=OldCampo;
    if (OldCampo <> ';') and (OldCampo <> 'W') and (OldCampo <> 'D') then
      RelSQL:=StringReplace(RelSQL,'<#>'+OldCampo+'<#>',''''+StringReplace(FselT430_Funzioni.FieldByName(NewCampo).AsString,'''','''''',[rfReplaceAll])+'''',[rfReplaceAll,rfIgnoreCase])
    else
      RelSQL:=StringReplace(RelSQL,'<#>'+OldCampo+'<#>',NewCampo,[rfReplaceAll,rfIgnoreCase]);
  end;
  if Copy(RelSQL,Length(RelSQL)-13,14) = ' UNION SELECT ' then
    RelSQL:=Copy(RelSQL,1,Length(RelSQL)-14);
  if Length(RelSQL) > 0 then
  begin
    if Copy(RelSQL,1,6) <> 'SELECT' then
      RelSQL:='SELECT '+RelSQL;
    if Pos(' FROM ',RelSQL) = 0 then
      RelSQL:=RelSQL+' FROM DUAL';
  end;
  RelSQL:=Trim(RelSQL);
end;

function TA002FAnagrafeMW.ControlloBadge(Dal,Al:TDateTime):TStringList;
{Controllo se il Badge esiste anche per altri dipendenti e lo segnalo}
var D1,D2,sAzienda: String;
    iProgressivo: Integer;
begin
  Result:=nil;
  if FselT430_Funzioni.FieldByName('BADGE').IsNull then exit;
  //Cerco tutte le aziende che hanno il GruppoBadge corrente
  with selI090_GruppoBadge do
  begin
    Close;
    SetVariable('UTENTE',Parametri.Username);
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('GRUPPO',Parametri.GruppoBadge);
    Open;
  end;
  while not selI090_GruppoBadge.Eof do
  begin
    //Se cerco il badge sull'azienda corrente...
    if Parametri.Azienda = selI090_GruppoBadge.FieldByName('AZIENDA').AsString then
    begin
      sAzienda:='';
      iProgressivo:=FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger;
    end
    else //se cerco il badge su un'azienda diversa da quella corrente...
    begin
      sAzienda:='Azienda: ' + selI090_GruppoBadge.FieldByName('AZIENDA').AsString + '. ';
      iProgressivo:=0;
    end;
    with selVerificaBadge do
    begin
      Close;
      SetVariable('BADGE',FselT430_Funzioni.FieldByName('BADGE').Value);
      SetVariable('PROGRESSIVO',iProgressivo);
      SetVariable('DAL',Dal);
      SetVariable('AL',Al);
      SetVariable('UTENTE',selI090_GruppoBadge.FieldByName('UTENTE').AsString);
      Open;
      if RecordCount > 0 then
      begin
        if Result = nil then
          Result:=TStringList.Create;
        //Ho trovato altre occorrenze di questo badge
        while not Eof do
        begin
          D1:=DateToStr(FieldByName('DATADECORRENZA').AsDateTime);
          if FormatDateTime('dd/mm/yyyy',FieldByName('DATAFINE').AsDateTime) = '31/12/3999' then
            D2:='Corrente'
          else
            D2:=DateToStr(FieldByName('DataFine').AsDateTime);
          Result.Add(sAzienda +
                     Format('%s %s %s (%s) dal %s al %s',
                            [FieldByName('TIPOBADGE').AsString,FieldByName('COGNOME').AsString,FieldByName('NOME').AsString,FieldByName('MATRICOLA').AsString,D1,D2]));
          Next;
        end;
      end;
    end;
    selI090_GruppoBadge.Next;
  end;
end;

function TA002FAnagrafeMW.VerificaCFCambiato(CodCatastale: String): String;
var
  CF: String;
begin
  Result:='';
  with FselT030_Funzioni do
  begin
    if (State = dsEdit) and
       (not FieldByName('CODFISCALE').IsNull) and
       ((FieldByName('COGNOME').medpOldValue <> FieldByName('COGNOME').Value) or
        (FieldByName('NOME').medpOldValue <> FieldByName('NOME').Value) or
        (FieldByName('SESSO').medpOldValue <> FieldByName('SESSO').Value) or
        (FieldByName('COMUNENAS').medpOldValue <> FieldByName('COMUNENAS').Value) or
        (FieldByName('DATANAS').medpOldValue <> FieldByName('DATANAS').Value)) then
    begin
      CF:=R180CalcoloCodiceFiscale(FieldByName('COGNOME').AsString,
                              FieldByName('NOME').AsString,
                              FieldByName('SESSO').AsString,
                              CodCatastale,
                              FieldByName('DATANAS').AsDateTime);
      if FieldByName('CODFISCALE').AsString <> CF then
        Result:=CF;
    end;
  end;
end;

function TA002FAnagrafeMW.VerificaCFUsato: String;
begin
  Result:='';
  if (FselT030_Funzioni.State in [dsInsert]) or
     (FselT030_Funzioni.FieldByName('CODFISCALE').medpOldValue <> FselT030_Funzioni.FieldByName('CODFISCALE').AsString) then
  begin
    selCodFisc.SetVariable('CODFISC',FselT030_Funzioni.FieldByName('CODFISCALE').AsString);
    selCodFisc.SetVariable('INIZIO',FselT430_Funzioni.FieldByName('INIZIO').Value);
    selCodFisc.SetVariable('FINE',FselT430_Funzioni.FieldByName('FINE').Value);
    selCodFisc.SetVariable('PROG',FselT030_Funzioni.FieldByName('PROGRESSIVO').Value);
    selCodFisc.Close;
    selCodFisc.Open;
    if selCodFisc.RecordCount > 0 then
    begin
      while Not selCodFisc.Eof do
      begin
        if Result <> '' then
          Result:=Result + #13#10;
        Result:=Result + selCodFisc.FieldByName('COGNOME').AsString + ' ' +
                   selCodFisc.FieldByName('NOME').AsString;
        selCodFisc.Next;
      end;
    end;
  end;
end;

function TA002FAnagrafeMW.VerificaCampiNonAbilitati(Prog:Integer;DataOld:TDateTime):String;
var i:Integer;
    C006FStoriaDati: TC006FStoriaDati;
begin
  Result:='';
  //1) Identificare i campi variati alla decorrenza originale
  //2) Per ogni campo variato, controllare se è visibile e abilitato in scrittura nel layout dell'operatore
  //3) Se almeno un campo non è visibile o abilitato in scrittura, segnalare e bloccare
  Screen.Cursor:=crHourGlass;
  C006FStoriaDati:=TC006FStoriaDati.Create(nil);
  try
    C006FStoriaDati.LeggiDescrizioni:=False;
    C006FStoriaDati.GetStoriaDato(Prog,'*',DataOld);
    for i:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
      if not selT033_campoDecode.SearchRecord('CAMPODB',RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo,[srFromBeginning])
      or (selT033_campoDecode.FieldByName('ACCESSO').AsString <> 'S') then
        if (RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo <> 'DATADECORRENZA')
        and (RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo <> 'DATAFINE') then
          if Pos(',' + RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo + ',',Result + ',') <= 0 then
            Result:=Result + ',' + RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo;
  finally
    Result:=StringReplace(Result,',',CRLF,[rfReplaceAll]);
    C006FStoriaDati.Free;
    Screen.Cursor:=crDefault;
  end;
end;

function TA002FAnagrafeMW.VerificaCampiNonStoricizzabili:String;
begin
  Result:='';
  //1) Identificare i campi non storicizzabili
  //2) Per ogni campo non storicizzabile, controllare se è variato
  //3) Se almeno un campo è variato, segnalare e bloccare
  Screen.Cursor:=crHourGlass;
  try
    selI500.First;
    while not selI500.Eof do
    begin
      if selI500.FieldByName('STORICIZZABILE').AsString = 'N' then
        if selT430_Funzioni.FieldByName(selI500.FieldByName('NOMECAMPO').AsString).Value <> selT430OldValues.FieldByName(selI500.FieldByName('NOMECAMPO').AsString).Value then
          if Pos(',' + selI500.FieldByName('NOMECAMPO').AsString + ',',Result + ',') <= 0 then
            Result:=Result + ',' + selI500.FieldByName('NOMECAMPO').AsString;
      selI500.Next;
    end;
  finally
    Result:=StringReplace(Result,',',CRLF,[rfReplaceAll]);
    Screen.Cursor:=crDefault;
  end;
end;

function TA002FAnagrafeMW.VerificaDatePeriodi(var sDate: String): Boolean;
begin
  Result:=True;
  with selT430_DatePeriodi do
  begin
    SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    Close;
    Open;
    if not FieldByName('INIZIO').IsNUll then
    begin
      Result:=False;
      sDate:='dal ' + FieldByName('INIZIO').AsString + ' al ' + FieldByName('FINE').AsString;
    end;
  end;
end;

function TA002FAnagrafeMW.VerificaCedAntePrimoStoricoStip(): Boolean;
begin
  Result:=True;
  with selP441 do
  begin
    SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    Close;
    Open;
    if FieldByName('NUM_CED').AsInteger > 0 then
      Result:=False;
  end;
end;

{Controllo che non avvengano intersezioni tra periodi d'indennità maternità}

function TA002FAnagrafeMW.VerificaIntersezionePeriodiIndMat: String;
begin
  selT430_IntIndMat.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  selT430_IntIndMat.SetVariable('INIZIO_IND_MAT_OLD',selT430OldValues.FieldByName('INIZIO_IND_MAT').Value);
  selT430_IntIndMat.SetVariable('FINE_IND_MAT_OLD',selT430OldValues.FieldByName('FINE_IND_MAT').Value);
  selT430_IntIndMat.SetVariable('INIZIO_IND_MAT',FselT430_Funzioni.FieldByName('INIZIO_IND_MAT').Value);
  selT430_IntIndMat.SetVariable('FINE_IND_MAT',FselT430_Funzioni.FieldByName('FINE_IND_MAT').Value);
  selT430_IntIndMat.Close;
  selT430_IntIndMat.Open;
  Result:='';
  if selT430_IntIndMat.RecordCount > 0 then
    while Not (selT430_IntIndMat.Eof) do
    begin
      Result:=Result +
              selT430_IntIndMat.FieldByName('INIZIO_IND_MAT').AsString + ' - ' +
              selT430_IntIndMat.FieldByName('FINE_IND_MAT').AsString;
      selT430_IntIndMat.Next;
      if Not selT430_IntIndMat.Eof then
        Result:=Result + ',' + #13#10;
    end;
end;

{Controllo che non avvengano intersezioni tra periodi di rapporto e periodi di maturazione indennità maternità}
function TA002FAnagrafeMW.VerificaIntersezionePeriodiRappIndMat: String;
begin
  Result:='';
  selT430_IntPRapp.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  selT430_IntPRapp.SetVariable('INIZIO_IND_MAT',FselT430_Funzioni.FieldByName('INIZIO_IND_MAT').Value);
  selT430_IntPRapp.SetVariable('FINE_IND_MAT',FselT430_Funzioni.FieldByName('FINE_IND_MAT').Value);
  selT430_IntPRapp.SetVariable('INIZIO_IND_MAT_OLD',selT430OldValues.FieldByName('INIZIO_IND_MAT').Value);
  selT430_IntPRapp.SetVariable('FINE_IND_MAT_OLD',selT430OldValues.FieldByName('FINE_IND_MAT').Value);
  selT430_IntPRapp.SetVariable('INIZIO',FselT430_Funzioni.FieldByName('INIZIO').Value);
  selT430_IntPRapp.SetVariable('INIZIO_OLD',selT430OldValues.FieldByName('INIZIO').Value);
  selT430_IntPRapp.SetVariable('FINE',FselT430_Funzioni.FieldByName('FINE').Value);
  selT430_IntPRapp.SetVariable('FINE_OLD',selT430OldValues.FieldByName('FINE').Value);
  selT430_IntPRapp.Close;
  selT430_IntPRapp.Open;

  if selT430_IntPRapp.RecordCount > 0 then
   while Not (selT430_IntPRapp.Eof) do
    begin
      Result:=Result + selT430_IntPRapp.FieldByName('INIZIO').AsString + ' - ' +
              selT430_IntPRapp.FieldByName('FINE').AsString;
      selT430_IntPRapp.Next;
      if Not selT430_IntPRapp.Eof then
        Result:=Result + ',' + #13#10;
    end;
end;

procedure TA002FAnagrafeMW.FiltroDizionarioBeforePost(Campo,Dizionario,Caption:String);
begin
  with selT430_Funzioni do
    if (not FieldByName(Campo).IsNull) and
       (FieldByName(Campo).Value <> selT430OldValues.FieldByName(Campo).Value) and
       (not A000FiltroDizionario(Dizionario,FieldByName(Campo).Value)) then
    raise Exception.Create(Format('Codice %s non disponibile nel proprio filtro dizionario!',[Caption]));
end;

function TA002FAnagrafeMW.ShortTerm(DatiInpShortTerm: TDatiInpShortTerm): TDatiOutShortTerm;
//Gestione contratti Short Term
var DatiOutShortTerm:TDatiOutShortTerm;
    NuovoEvento,PresenzaPausa:Boolean;
    PrimoPeriodo,GiorniConteggio,GiorniConteggioPrec,GiorniPrev:Integer;
    DataInizioConteggio,DataFineConteggio:TDateTime;
    i,j:Integer;
begin
  DatiOutShortTerm.Messaggio:='';
  DatiOutShortTerm.MessaggioBloccante:='';
  DatiOutShortTerm.NumPeriodi:=0;
  DatiOutShortTerm.MessFineContrPrev:='';
  DatiOutShortTerm.MessRegola35Prev:='';
  DatiOutShortTerm.MessPensionePrev:='';
  DatiOutShortTerm.MessShifPrev:='';
  SetLength(DatiOutShortTerm.Periodi,0);
  Result:=DatiOutShortTerm;
  if (DatiInpShortTerm.TipoRapporto <> '3.5') and (DatiInpShortTerm.TipoRapporto <> 'D3.5') and
     (DatiInpShortTerm.TipoRapporto <> 'DST') and (DatiInpShortTerm.TipoRapporto <> 'MST') then
  begin
    if DatiInpShortTerm.TipoRichiamo = 'Variazione' then
    begin
      Result:=DatiOutShortTerm;
      exit;
    end
    else
    begin
      DatiOutShortTerm.MessaggioBloccante:='Richiesta l''analisi per un tipo di rapporto non relativo ad un contratto short term (3.5, D3.5, DST, MST)';
      Result:=DatiOutShortTerm;
      exit;
    end;
  end;
  //Lettura di tutti i periodi di servizio START_DATE_HR-CESS_DATE_HR
  selT430_ShortTerm.SetVariable('Progressivo',DatiInpShortTerm.Progressivo);
  selT430_ShortTerm.Close;
  selT430_ShortTerm.Open;
  if selT430_ShortTerm.Eof then
  begin
    DatiOutShortTerm.MessaggioBloccante:='Non esistono periodi START_DATE_HR-CESS_DATE_HR significativi';
    Result:=DatiOutShortTerm;
    exit;
  end;
  while not selT430_ShortTerm.Eof do
  begin
    inc(DatiOutShortTerm.NumPeriodi);
    SetLength(DatiOutShortTerm.Periodi,DatiOutShortTerm.NumPeriodi + 1);
    with DatiOutShortTerm.Periodi[DatiOutShortTerm.NumPeriodi] do
    begin
      Tipo:='Servizio';
      TipoContratto:=selT430_ShortTerm.FieldByName('TIPORAPPORTO').AsString;
      Inizio:=selT430_ShortTerm.FieldByName('START_DATE_HR').AsDateTime;
      Fine:=selT430_ShortTerm.FieldByName('CESS_DATE_HR').AsDateTime;
      Giorni:=Trunc(Fine) - Trunc(Inizio) + 1;
    end;
    selT430_ShortTerm.Next;
  end;
  //Verifica presenza di periodi di servizio sovrapposti o errati
  for i:=1 to DatiOutShortTerm.NumPeriodi do
  begin
    if (DatiOutShortTerm.Periodi[i].Inizio = StrToDate('31/12/3999')) or
       (DatiOutShortTerm.Periodi[i].Inizio > DatiOutShortTerm.Periodi[i].Fine) or
       ((i > 1) and (DatiOutShortTerm.Periodi[i].Inizio <= DatiOutShortTerm.Periodi[i - 1].Fine)) then
    begin
      DatiOutShortTerm.MessaggioBloccante:='Esistono dei periodi START_DATE_HR-CESS_DATE_HR che si sovrappongono oppure con START_DATE_HR non valorizzata o maggiore di CESS_DATE_HR: analisi del contratto short term impossibile';
      Result:=DatiOutShortTerm;
      exit;
    end;
  end;
  //Analisi dei soli periodi di servizio antecedenti alla data di riferimento
  for i:=1 to DatiOutShortTerm.NumPeriodi do
  begin
    if DatiOutShortTerm.Periodi[i].Inizio > DatiInpShortTerm.DataRiferimento then
    begin
      DatiOutShortTerm.NumPeriodi:=i - 1;
      SetLength(DatiOutShortTerm.Periodi,DatiOutShortTerm.NumPeriodi + 1);
      break;
    end;
  end;
  //Inserimento eventuali pause dal servizio
  i:=2;
  while i <= DatiOutShortTerm.NumPeriodi do
  begin
    if DatiOutShortTerm.Periodi[i].Inizio > DatiOutShortTerm.Periodi[i - 1].Fine + 1 then
    begin
      inc(DatiOutShortTerm.NumPeriodi);
      SetLength(DatiOutShortTerm.Periodi,DatiOutShortTerm.NumPeriodi + 1);
      for j:=DatiOutShortTerm.NumPeriodi downto i + 1 do
        DatiOutShortTerm.Periodi[j]:=DatiOutShortTerm.Periodi[j - 1];
      with DatiOutShortTerm.Periodi[i] do
      begin
        Tipo:='Pausa';
        TipoContratto:='';
        Inizio:=DatiOutShortTerm.Periodi[i - 1].Fine + 1;
        Fine:=DatiOutShortTerm.Periodi[i + 1].Inizio - 1;
        Giorni:=Trunc(Fine) - Trunc(Inizio) + 1;
      end;
    end;
    inc(i);
  end;
  //Azzeramento date degli eventi
  for i:=1 to DatiOutShortTerm.NumPeriodi do
  begin
    DatiOutShortTerm.Periodi[i].DataFineContrEff:=0;
    DatiOutShortTerm.Periodi[i].DataRegola35Eff:=0;
    DatiOutShortTerm.Periodi[i].DataPensioneEff:=0;
    DatiOutShortTerm.Periodi[i].DataShifEff:=0;
  end;
  //Verifica durata contrattuale
  GiorniConteggio:=0;
  GiorniConteggioPrec:=0;
  PrimoPeriodo:=RicercaPrimoPeriodo(DatiOutShortTerm,180);
  DataInizioConteggio:=DatiOutShortTerm.Periodi[PrimoPeriodo].Inizio;
  for i:=PrimoPeriodo to DatiOutShortTerm.NumPeriodi do
  begin
    if DatiOutShortTerm.Periodi[i].Tipo = 'Servizio' then
    begin
      GiorniConteggio:=GiorniConteggioPrec + DatiOutShortTerm.Periodi[i].Giorni;
      if GiorniConteggio > 364 then
      begin
        DatiOutShortTerm.Periodi[i].DataFineContrEff:=DatiOutShortTerm.Periodi[i].Inizio + 364 - GiorniConteggioPrec - 1;
        DatiOutShortTerm.MessaggioBloccante:='Attenzione: il giorno ' + FormatDateTime('dd/mm/yyyy',DatiOutShortTerm.Periodi[i].DataFineContrEff) + ' è stata raggiunta la massima durata contrattuale per un contratto short term';
        break;
      end;
      GiorniConteggioPrec:=GiorniConteggio;
    end;
  end;
  if DatiOutShortTerm.MessaggioBloccante = '' then
  begin
    if GiorniConteggio = 364 then
    begin
      DatiOutShortTerm.Messaggio:='Il giorno ' +
      FormatDateTime('dd/mm/yyyy',DatiOutShortTerm.Periodi[DatiOutShortTerm.NumPeriodi].Fine) +
      ' è stata raggiunta la massima durata contrattuale';
    end;
    GiorniPrev:=364 - GiorniConteggio;
    DatiOutShortTerm.MessFineContrPrev:='prevista il ' +
      FormatDateTime('dd/mm/yyyy',DatiOutShortTerm.Periodi[DatiOutShortTerm.NumPeriodi].Fine + GiorniPrev) +
      ' (' + IntToStr(GiorniPrev) + ' giorni) in quanto al ' +
      FormatDateTime('dd/mm/yyyy',DatiOutShortTerm.Periodi[DatiOutShortTerm.NumPeriodi].Fine) +
      ' sono stati lavorati ' + IntToStr(GiorniConteggio) +
      ' giorni a decorrere dal ' + FormatDateTime('dd/mm/yyyy',DataInizioConteggio);
  end;
  //Verifica regola 3.5
  NuovoEvento:=False;
  PresenzaPausa:=False;
  GiorniConteggio:=0;
  GiorniConteggioPrec:=0;
  PrimoPeriodo:=RicercaPrimoPeriodo(DatiOutShortTerm,31);
  DataInizioConteggio:=DatiOutShortTerm.Periodi[PrimoPeriodo].Inizio;
  for i:=PrimoPeriodo to DatiOutShortTerm.NumPeriodi do
  begin
    if DatiOutShortTerm.Periodi[i].Tipo = 'Pausa' then
      PresenzaPausa:=True;
    GiorniConteggio:=GiorniConteggioPrec + DatiOutShortTerm.Periodi[i].Giorni;
    if (DatiOutShortTerm.Periodi[i].Tipo = 'Servizio') and (GiorniConteggio >= 365) then
    begin
      DatiOutShortTerm.Periodi[i].DataRegola35Eff:=DatiOutShortTerm.Periodi[i].Inizio;
      NuovoEvento:=True;
      break;
    end;
    GiorniConteggioPrec:=GiorniConteggio;
  end;
  if not NuovoEvento then
  begin
    GiorniPrev:=365 - GiorniConteggio;
    if not PresenzaPausa then
      DatiOutShortTerm.MessRegola35Prev:='prevista dopo il '
    else
      DatiOutShortTerm.MessRegola35Prev:='prevista il ';
    DatiOutShortTerm.MessRegola35Prev:=DatiOutShortTerm.MessRegola35Prev +
      FormatDateTime('dd/mm/yyyy',DatiOutShortTerm.Periodi[DatiOutShortTerm.NumPeriodi].Fine + GiorniPrev) +
      ' (' + IntToStr(GiorniPrev) + ' giorni) in quanto al ' +
      FormatDateTime('dd/mm/yyyy',DatiOutShortTerm.Periodi[DatiOutShortTerm.NumPeriodi].Fine) +
      ' sono stati conteggiati ' + IntToStr(GiorniConteggio) +
      ' giorni a decorrere dal ' + FormatDateTime('dd/mm/yyyy',DataInizioConteggio);
    if not PresenzaPausa then
      DatiOutShortTerm.MessRegola35Prev:=DatiOutShortTerm.MessRegola35Prev + ' ma non sono presenti pause';
  end
  else if (DatiInpShortTerm.TipoRichiamo = 'Variazione') and
          (DatiOutShortTerm.Periodi[i].DataRegola35Eff >= DatiInpShortTerm.StartDate) and
          (DatiOutShortTerm.Periodi[i].DataRegola35Eff <= DatiInpShortTerm.CessDate) then
  begin
    DatiOutShortTerm.Messaggio:='Nel periodo ' +
      FormatDateTime('dd/mm/yyyy',DatiInpShortTerm.StartDate) + ' - ' +
      FormatDateTime('dd/mm/yyyy',DatiInpShortTerm.CessDate) + ' sono intervenuti nuovi eventi';
  end;
  //Verifica ingresso nel sistema pensionistico
  NuovoEvento:=False;
  GiorniConteggio:=0;
  PrimoPeriodo:=RicercaPrimoPeriodo(DatiOutShortTerm,31);
  DataInizioConteggio:=DatiOutShortTerm.Periodi[PrimoPeriodo].Inizio;
  DataFineConteggio:=R180AddMesi(DataInizioConteggio,6);
  for i:=PrimoPeriodo to DatiOutShortTerm.NumPeriodi do
  begin
    if DatiOutShortTerm.Periodi[i].Tipo = 'Servizio' then
    begin
      if DatiOutShortTerm.Periodi[i].Fine >= R180AddMesi(DatiOutShortTerm.Periodi[i].Inizio,6) - 1 then
      begin
        DatiOutShortTerm.Periodi[i].DataPensioneEff:=DatiOutShortTerm.Periodi[i].Inizio;
        NuovoEvento:=True;
        break;
      end
      else if (DataFineConteggio >= DatiOutShortTerm.Periodi[i].Inizio) and
              (DataFineConteggio <= DatiOutShortTerm.Periodi[i].Fine) then
      begin
        DatiOutShortTerm.Periodi[i].DataPensioneEff:=DataFineConteggio;
        NuovoEvento:=True;
        break;
      end;
    end
    else
    begin
      DataFineConteggio:=DataFineConteggio + DatiOutShortTerm.Periodi[i].Giorni;
      GiorniConteggio:=GiorniConteggio + DatiOutShortTerm.Periodi[i].Giorni;
    end;
  end;
  if not NuovoEvento then
  begin
    DatiOutShortTerm.MessPensionePrev:='prevista il ' +
      FormatDateTime('dd/mm/yyyy',DataFineConteggio) +
      ' (' + IntToStr(Trunc(DataFineConteggio) - Trunc(DatiOutShortTerm.Periodi[DatiOutShortTerm.NumPeriodi].Fine)) + ' giorni) in quanto al ' +
      FormatDateTime('dd/mm/yyyy',DataInizioConteggio) +
      ' sono stati sommati sei mesi e ' + IntToStr(GiorniConteggio) +
      ' giorni di pausa';
  end
  else if (DatiInpShortTerm.TipoRichiamo = 'Variazione') and
          (DatiOutShortTerm.Periodi[i].DataPensioneEff >= DatiInpShortTerm.StartDate) and
          (DatiOutShortTerm.Periodi[i].DataPensioneEff <= DatiInpShortTerm.CessDate) then
  begin
    DatiOutShortTerm.Messaggio:='Nel periodo ' +
      FormatDateTime('dd/mm/yyyy',DatiInpShortTerm.StartDate) + ' - ' +
      FormatDateTime('dd/mm/yyyy',DatiInpShortTerm.CessDate) + ' sono intervenuti nuovi eventi';
  end;
  //Verifica ingresso nell shif
  NuovoEvento:=False;
  GiorniConteggio:=0;
  PrimoPeriodo:=RicercaPrimoPeriodo(DatiOutShortTerm,61);
  while (not NuovoEvento) and (PrimoPeriodo <= DatiOutShortTerm.NumPeriodi) do
  begin
    if DatiOutShortTerm.Periodi[PrimoPeriodo].Fine >= R180AddMesi(DatiOutShortTerm.Periodi[PrimoPeriodo].Inizio,6) - 1 then
    begin
      i:=PrimoPeriodo;
      DatiOutShortTerm.Periodi[i].DataShifEff:=DatiOutShortTerm.Periodi[i].Inizio;
      NuovoEvento:=True;
    end
    else
    begin
      DataInizioConteggio:=DatiOutShortTerm.Periodi[PrimoPeriodo].Inizio;
      DataFineConteggio:=R180AddMesi(DataInizioConteggio,6) - 1;
      for i:=PrimoPeriodo to DatiOutShortTerm.NumPeriodi do
      begin
        if (DatiOutShortTerm.Periodi[i].Tipo = 'Pausa') and (DatiOutShortTerm.Periodi[i].Giorni >= 31) then
          break
        else if DatiOutShortTerm.Periodi[i].Tipo = 'Pausa' then
          DataFineConteggio:=DataFineConteggio + DatiOutShortTerm.Periodi[i].Giorni
        else
        begin
          if (DataFineConteggio >= DatiOutShortTerm.Periodi[i].Inizio) and
             (DataFineConteggio <= DatiOutShortTerm.Periodi[i].Fine) then
          begin
            if (R180Giorno(DatiOutShortTerm.Periodi[i].Inizio) = 1) or
               ((i > 1) and (DatiOutShortTerm.Periodi[i - 1].Tipo = 'Pausa')) then
              DatiOutShortTerm.Periodi[i].DataShifEff:=DatiOutShortTerm.Periodi[i].Inizio
            else
              DatiOutShortTerm.Periodi[i].DataShifEff:=R180InizioMese(R180AddMesi(DatiOutShortTerm.Periodi[i].Inizio,1));
            NuovoEvento:=True;
            break;
          end;
        end;
      end;
      if not NuovoEvento then
        PrimoPeriodo:=i + 1;
    end;
  end;
  if not NuovoEvento then
  begin
    PrimoPeriodo:=RicercaPrimoPeriodo(DatiOutShortTerm,31);
    GiorniConteggio:=0;
    for i:=PrimoPeriodo to DatiOutShortTerm.NumPeriodi do
    begin
      if DatiOutShortTerm.Periodi[i].Tipo = 'Pausa' then
        GiorniConteggio:=GiorniConteggio + DatiOutShortTerm.Periodi[i].Giorni;
    end;
    DataInizioConteggio:=DatiOutShortTerm.Periodi[PrimoPeriodo].Inizio;
    DataFineConteggio:=R180AddMesi(DataInizioConteggio,6) - 1 + GiorniConteggio;
    DatiOutShortTerm.MessShifPrev:='prevista il ' +
      FormatDateTime('dd/mm/yyyy',DataFineConteggio) +
      ' (' + IntToStr(Trunc(DataFineConteggio) - Trunc(DatiOutShortTerm.Periodi[DatiOutShortTerm.NumPeriodi].Fine)) + ' giorni) in quanto al ' +
      FormatDateTime('dd/mm/yyyy',DataInizioConteggio) +
      ' sono stati sommati sei mesi, meno un giorno, e ' + IntToStr(GiorniConteggio) +
      ' giorni di pausa';
  end
  else if (DatiInpShortTerm.TipoRichiamo = 'Variazione') and
          (DatiOutShortTerm.Periodi[i].DataShifEff >= DatiInpShortTerm.StartDate) and
          (DatiOutShortTerm.Periodi[i].DataShifEff <= DatiInpShortTerm.CessDate) then
  begin
    DatiOutShortTerm.Messaggio:='Nel periodo ' +
      FormatDateTime('dd/mm/yyyy',DatiInpShortTerm.StartDate) + ' - ' +
      FormatDateTime('dd/mm/yyyy',DatiInpShortTerm.CessDate) + ' sono intervenuti nuovi eventi';
  end;
  Result:=DatiOutShortTerm;
end;

function TA002FAnagrafeMW.RicercaPrimoPeriodo(DatiOutShortTerm: TDatiOutShortTerm; MaxPausa:Integer): Integer;
//Ricerca primo periodo da considerare contratti Short Term
var i:Integer;
begin
  Result:=1;
  for i:=DatiOutShortTerm.NumPeriodi downto 1 do
    if (DatiOutShortTerm.Periodi[i].Tipo = 'Pausa') and (DatiOutShortTerm.Periodi[i].Giorni >= MaxPausa) then
    begin
      Result:=i + 1;
      break;
    end;
end;

procedure TA002FAnagrafeMW.CaricaCdsShortTerm(DatiOutShortTerm: TDatiOutShortTerm);
var i:Integer;
begin
  cdsShortTerm.EmptyDataSet;
  for i:=1 to DatiOutShortTerm.NumPeriodi do
  begin
    cdsShortTerm.Append;
    cdsShortTerm.FieldByName('TIPO').AsString:=DatiOutShortTerm.Periodi[i].Tipo;
    cdsShortTerm.FieldByName('TIPOCONTRATTO').AsString:=DatiOutShortTerm.Periodi[i].TipoContratto;
    if DatiOutShortTerm.Periodi[i].Inizio <> StrToDate('31/12/3999') then
      cdsShortTerm.FieldByName('INIZIO').AsDateTime:=DatiOutShortTerm.Periodi[i].Inizio;
    if DatiOutShortTerm.Periodi[i].Fine <> StrToDate('31/12/3999') then
      cdsShortTerm.FieldByName('FINE').AsDateTime:=DatiOutShortTerm.Periodi[i].Fine;
    if DatiOutShortTerm.Periodi[i].Tipo = 'Servizio' then
      cdsShortTerm.FieldByName('GGSERVIZIO').AsInteger:=DatiOutShortTerm.Periodi[i].Giorni
    else
      cdsShortTerm.FieldByName('GGPAUSA').AsInteger:=DatiOutShortTerm.Periodi[i].Giorni;
    if DatiOutShortTerm.Periodi[i].DataFineContrEff <> 0 then
      cdsShortTerm.FieldByName('DATAFINECONTREFF').AsDateTime:=DatiOutShortTerm.Periodi[i].DataFineContrEff;
    if DatiOutShortTerm.Periodi[i].DataRegola35Eff <> 0 then
      cdsShortTerm.FieldByName('DATAREGOLA35EFF').AsDateTime:=DatiOutShortTerm.Periodi[i].DataRegola35Eff;
    if DatiOutShortTerm.Periodi[i].DataPensioneEff <> 0 then
      cdsShortTerm.FieldByName('DATAPENSIONEEFF').AsDateTime:=DatiOutShortTerm.Periodi[i].DataPensioneEff;
    if DatiOutShortTerm.Periodi[i].DataShifEff <> 0 then
      cdsShortTerm.FieldByName('DATASHIFEFF').AsDateTime:=DatiOutShortTerm.Periodi[i].DataShifEff;
    cdsShortTerm.Post;
  end;
end;

function TA002FAnagrafeMW.TryLockRecordT030(const PProgressivo: Integer): Boolean;
// tenta di acquisire il lock del record di T030 relativo al progressivo indicato
// restituisce:
// - true  se il lock viene acquisito
// - false se il record è già in lock
begin
  selT030Lock.SetVariable('PROGRESSIVO', PProgressivo);
  try
    selT030Lock.Execute;
    Result:=True;
  except
    on E: Exception do
    begin
      Result:=False;
      Exit;
    end;
  end;
end;

procedure TA002FAnagrafeMW.UnlockRecordT030Rollback;
// rimuove il lock effettuando una rollback
begin
  selT030Lock.Session.Rollback;
end;

function TA002FAnagrafeMW.EsistonoLoginWeb(const PProg: Integer): Boolean;
// indica se sono presenti dei record su I060 per il progressivo indicato sull'azienda corrente
begin
  try
    selCountI060.SetVariable('AZIENDA',Parametri.Azienda);
    selCountI060.SetVariable('PROGRESSIVO',PProg);
    selCountI060.Execute;
    Result:=selCountI060.FieldAsInteger(0) > 0;
  except
    Result:=False;
  end;
end;

procedure TA002FAnagrafeMW.ApriDatasetLoginProfili(const PProg: Integer);
// apre il dataset dei login dipendente selI060Prog e il dataset di dettaglio selI061
var
  LDataRifStr: String;
begin
  // imposta data di riferimento per visione corrente
  LDataRifStr:=FloatToStr(Parametri.DataLavoro);

  selI060Prog.DisableControls;
  selI061.DisableControls;
  try
    // chiude dataset per impostare proprietà
    selI061.Close;
    selI061.Filtered:=False;
    selI061.Filter:=Format('(INIZIO_VALIDITA <= %s) and (FINE_VALIDITA >= %s)',[LDataRifStr,LDataRifStr]);

    // apre il dataset degli utenti web associati al progressivo
    selI060Prog.Close;
    selI060Prog.SetVariable('AZIENDA',Parametri.Azienda);
    selI060Prog.SetVariable('PROGRESSIVO',PProg);
    selI060Prog.Open;

    if selI060Prog.RecordCount = 0 then
      AllineaDatasetI060Prog_I061;
  finally
    selI060Prog.EnableControls;
    selI061.EnableControls;
  end;
end;

procedure TA002FAnagrafeMW.SetVisioneCorrenteProfili(const PVisioneCorrente: Boolean);
begin
  selI061.DisableControls;
  try
    selI061.Filtered:=PVisioneCorrente;
  finally
    selI061.EnableControls;
  end;
end;

procedure TA002FAnagrafeMW.AllineaDatasetI060Prog_I061;
begin
  if not selI060Prog.Active then
    Exit;

  selI061.DisableControls;
  try
    // imposta proprietà e apre il dataset dei profili
    R180SetVariable(selI061,'AZIENDA',selI060Prog.FieldByName('AZIENDA').AsString);
    R180SetVariable(selI061,'NOME_UTENTE',selI060Prog.FieldByName('NOME_UTENTE').AsString);
    selI061.Open;
  finally
    selI061.EnableControls;
  end;
end;

end.
