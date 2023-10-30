unit A159UArchiviazioneCartelliniMW;

interface

uses
  A000USessione,
  C021UDocumentiManagerDM,
  A210URegoleArchiviazioneDocMW,
  C180FunzioniGenerali,
  R005UDataModuleMW,
  A000UCostanti,
  W009UStampaCartellinoDtm,
  {$IFDEF IRISWEB}IWGlobal,{$ENDIF}
  Winapi.Windows,
  Oracle, OracleData, Vcl.Forms, Math, Variants,
  System.SysUtils, System.StrUtils, System.Classes, System.IOUtils, Data.DB, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  System.Generics.Collections, Winapi.ActiveX, Winapi.ShellAPI;

const
  LUNG_COD_ANOM = 5;
  FUNC_NAME       = 'TA159FArchiviazioneCartelliniMW.GeneraPdf';
  ERR_MSG         = FUNC_NAME + ' - %s: %s (%s)';
  INFO_MSG        = FUNC_NAME + ': %s';

type
  TParametriAziendali = class
  public
    PathPdf: String;
    FilePdf: String;
    function ToString: String; override;
  end;

  TDatiC600SelAnagrafe = record
    Matricola: String;
    CodFiscale: String;
    Cognome: String;
    Nome: String;
    Inizio: TDateTime;
    Fine: TDateTime;
    Progressivo: Integer;
    Dal,Al: TDateTime;
    ParamCartellino: String;
  end;

  TA159FArchiviazioneCartelliniMW = class(TR005FDataModuleMW)
    D950: TDataSource;
    Q950Lista: TOracleDataSet;
    selT025: TOracleDataSet;
    selI210: TOracleDataSet;
    selT962: TOracleDataSet;
    selT960Registro: TOracleDataSet;
    dsrT960Registro: TDataSource;
    selScript: TOracleQuery;
    selVT860: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    TempoIni:TDateTime;
    InfoMsg:string;
    ParAziendaliList: TDictionary<String,TParametriAziendali>;
    W009DtM: TW009FStampaCartellinoDtm;
    A210MW: TA210FRegoleArchiviazioneDocMW;
    C021DM: TC021FDocumentiManagerDM;
    function AddAndSetParamAziendali(const PAzienda: String; var RParAz: TParametriAziendali): Boolean;
    function _CtrlFilePdf(const PParFile: String; const PDatiVista: TDatiC600SelAnagrafe; var RFilePdfSost, RErrMsg: String): Boolean;
    function CreaCartellinoPDF(pSessioneOracle: TOracleSession; pMatricola:String; pProgressivo:Integer; pDal, pAl:TDateTime; Parametrizzazione, FilePdf, CartelliniChiusi: String): String;
    function ShellExecute_AndWait(Operation, FileName, Parameter, Directory: string; Show: Word; bWait: Boolean): Longint;
    function  GetPathPdf(const PPath:String; const PDatiVista: TDatiC600SelAnagrafe):String;
    function  GetNomeFilePdf(const PParFilePdf: String; const PDatiVista: TDatiC600SelAnagrafe): String;
    function  CtrlPathPdf(const PPath: String; var RErrMsg: String): Boolean;
    function  CtrlFilePdf(const PParFilePdf: String; var RErrMsg: String): Boolean;
    function EsistonoAnomalie: Boolean;
    procedure CreaFileJSON(DatiC600SelAnagrafe: TDatiC600SelAnagrafe; RegolaSQL: String; DocumentoJSON: String);
    function SalvaSuDB(DatiC600SelAnagrafe: TDatiC600SelAnagrafe; InfoAvanzamento, NoteIter: String): Integer;
    procedure SalvaEInviaRegistroSuDB;
    function DownloadRegistroDaDB: String;
    function SalvaSuFileSystem(DatiC600SelAnagrafe: TDatiC600SelAnagrafe; CreaFileMetadati: Boolean; InfoAvanzamento, NoteIter: String): Integer;
    //script per la valutazione della validazione del documento
    function EseguiScriptValidazione(Progressivo: Integer; Data: TDateTime): Boolean;
    //script per estrarre le note dall'iter di validazione del cartellino
    function EseguiScriptNote(Progressivo: Integer; Data: TDateTime): String;
    //script da eseguire dopo l'archiviazione del documento
    function EseguiScriptArchiviazione(Progressivo, IdDocumento: Integer; Data: TDateTime): TResCtrl;
    function ValidazioneUltimoLivello(Progressivo: Integer; Data: TDateTime): Boolean;
    procedure DichiaraVariabiliScript;
  public
    Anomalie: string;
    SingoloMese, Sovrascrivi, TipoCartellino, AggiornamentoSchedaRiep, SalvaSuDocumentale, Versionabile, CreaNuovaVersione, SalvareSuDB, InviareRegistro, VerificaValidazione: Boolean;
    PeriodoDal, PeriodoAl: TDateTime;
    Parametrizzazione: string;
    LParAziendali: TParametriAziendali;
    ContaSalvataggi: Integer;
    isService: Boolean; //True se utilizzato nel B026
    function TotalRecordsElaborazione:integer;
    function CurrentRecordElaborazione:integer;
    procedure InizioElaborazione;
    procedure ElaboraElemento;
    function ElementoSuccessivo:Boolean;
    procedure FineCicloElaborazione;
    procedure EseguiBatchPostElaborazione(const PBaseDir: String; const PNomeFile: String);
    function VerificaFileEsistenti: Integer;
    function CheckSalvaSuDocumentale: Boolean;
    function CheckVersionabile: Boolean;
    function CheckSalvaSuDB: Boolean;
    procedure InviaRegistroSalvato;
  end;

var
  CSStampa, CSStampaCartellino: TmedpCriticalSection;

implementation

uses A000UInterfaccia;

{$R *.dfm}

procedure TA159FArchiviazioneCartelliniMW.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  // istanzia dictionary per parametri aziendali
  ParAziendaliList:=TDictionary<String,TParametriAziendali>.Create;
  //
  LParAziendali:=TParametriAziendali.Create;

  //apre il dataset per la scelta della paramtrizzazione
  Q950Lista.Open;
  selI210.Open;

  //trova i registri di archiviazione già salvati su db
  selT960Registro.SetVariable('TIPOLOGIA', selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString);
  selT960Registro.Open;

  W009DtM:=nil;

  A210MW:=TA210FRegoleArchiviazioneDocMW.Create(nil);
  A210MW.selI210:=selI210;

  SalvaSuDocumentale:=CheckSalvaSuDocumentale;
  Versionabile:=CheckVersionabile;
  SalvareSuDB:=CheckSalvaSuDB;

  InviareRegistro:=selI210.FieldByName('INVIA_REGISTRO').AsString = 'S';
  VerificaValidazione:=selI210.FieldByName('VERIFICA_VALIDAZIONE').AsString = 'S';

  ContaSalvataggi:=0;

  C021DM:=TC021FDocumentiManagerDM.Create(Self);

  isService:=False;
end;

procedure TA159FArchiviazioneCartelliniMW.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  // chiusura dei dataset
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
    begin
      TOracleDataSet(Components[i]).CloseAll;
    end;
  end;
  // distruzione oggetti
  FreeAndNil(ParAziendaliList);
  FreeAndNil(LParAziendali);
  FreeAndNil(A210MW);
  FreeAndNil(C021DM);
end;

//verifico se il cartellino deve essere inserito sul documentale
function TA159FArchiviazioneCartelliniMW.CheckSalvaSuDocumentale: Boolean;
begin
  Result:=(Parametri.ModuloInstallato['ARCHIVIAZIONE_SOSTITUTIVA']) and (selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString.Trim  <> '');
end;

//verifico se è richiesto il salvataggio su db
function TA159FArchiviazioneCartelliniMW.CheckSalvaSuDB: Boolean;
begin
  Result:=False;
  if CheckSalvaSuDocumentale then
    Result:=selI210.FieldByName('PATH_FILE').AsString = 'DB';
end;

//verifico se la tipologia di documento è versionabile
function TA159FArchiviazioneCartelliniMW.CheckVersionabile: Boolean;
begin
  Result:=False;
  if CheckSalvaSuDocumentale then
  begin
    // se è presente la tipologia in I210, devo salvarlo nel documentale
    selT962.Close;
    selT962.SetVariable('CODICE', selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString);
    selT962.Open;

    if selT962.RecordCount > 0 then
      Result:=selT962.FieldByName('VERSIONABILE').AsString = 'S'
    else
      raise Exception.Create('Tipo documento utilizzato per l''archiviazione inesistente');
  end;
end;

function TA159FArchiviazioneCartelliniMW.AddAndSetParamAziendali(const PAzienda: String;
  var RParAz: TParametriAziendali): Boolean;
// verifica se i parametri per l'azienda indicata sono già presenti nel dictionary
// in alternativa li legge da db (tabella I091 di MONDOEDP)
// valorizza la variabile RParAz con i valori dei parametri
// restituisce True se i parametri sono stati aggiunti al dictionary
// oppure False altrimenti
begin
  if RParAz = nil then
    raise Exception.Create('Parametro RParAz nullo!');
  if ParAziendaliList.ContainsKey(PAzienda) then
  begin
    // estrae i dati dal dictionary
    ParAziendaliList.TryGetValue(PAzienda,RParAz);
    Result:=False;
  end
  else
  begin
    // estrae i dati da db e quindi li aggiunge al dictionary
    ParAziendaliList.Add(PAzienda,RParAz);
    Result:=True;
  end;
end;

function TA159FArchiviazioneCartelliniMW.CtrlPathPdf(const PPath: String; var RErrMsg: String): Boolean;
// controlla il path di destinazione per i file pdf indicato come parametro aziendale
// se il path non esiste lo crea
begin
  Result:=False;
  RErrMsg:='';
  // controllo indicazione path
  if PPath.Trim = '' then
  begin
    RErrMsg:='la directory per i file pdf dei cartellini non è indicata!';
    Exit;
  end;
  // controllo esistenza path
  if not TDirectory.Exists(PPath) then
  begin
    // path inesistente: prova a crearlo
    try
      TDirectory.CreateDirectory(PPath);
    except
      on E: Exception do
      begin
        RErrMsg:='la directory per i file pdf dei cartellini non è accessibile!';
        Exit;
      end;
    end;
  end;
  // controllo permessi scrittura
  if not R180IsDirectoryWritable(PPath) then
  begin
    RErrMsg:='la directory per i file pdf dei cartellini non è accessibile in scrittura!';
    Exit;
  end;
  // tutti i controlli ok
  Result:=True;
end;

function TA159FArchiviazioneCartelliniMW._CtrlFilePdf(const PParFile: String; const PDatiVista: TDatiC600SelAnagrafe; var RFilePdfSost, RErrMsg: String): Boolean;
// verifica la sintassi file indicato e restituisce:
// - True
//     se la sintassi è ok
// - False
//     se ci sono errori (nel caso, valorizza RErrMsg con l'errore riscontrato)
// il nome file può contenere le seguenti variabili:
//   :AZIENDA
//   :PROGRESSIVO
//   :MATRICOLA
//   :CODFISCALE
//   :MESE_CARTELLINO
//   :PARAM_CARTELLINO
var
  OQ: TOracleQuery;
  Src: String;
begin
  Result:=False;
  RFilePdfSost:=PParFile;
  RErrMsg:='';
  // utilizza una query del tipo "select [PParFile] from dual"
  // per verificare la sintassi del nome file
  Src:=PParFile.ToUpper;
  OQ:=TOracleQuery.Create(nil);
  try
    try
      OQ.Session:=SessioneOracle;
      // stringa da estrarre
      OQ.DeclareVariable('S',otSubst);
      OQ.SetVariable('S',PParFile);
      // ricerca variabili conosciute
      // matricola
      if Pos(':MATRICOLA',Src) > 0 then
      begin
        OQ.DeclareVariable('MATRICOLA',otString);
        OQ.SetVariable('MATRICOLA',PDatiVista.Matricola);
      end;
      // codice fiscale
      if Pos(':CODFISCALE',Src) > 0 then
      begin
        OQ.DeclareVariable('CODFISCALE',otString);
        OQ.SetVariable('CODFISCALE',PDatiVista.CodFiscale);
      end;
      // progressivo
      if Pos(':PROGRESSIVO',Src) > 0 then
      begin
        OQ.DeclareVariable('PROGRESSIVO',otInteger);
        OQ.SetVariable('PROGRESSIVO',PDatiVista.Progressivo)
      end;
      // mese cartellino
      if Pos(':MESE_CARTELLINO',Src) > 0 then
      begin
        OQ.DeclareVariable('MESE_CARTELLINO',otDate);
        OQ.SetVariable('MESE_CARTELLINO',PDatiVista.Dal);
      end;
      // parametrizzazione cartellino
      if Pos(':PARAM_CARTELLINO',Src) > 0 then
      begin
        OQ.DeclareVariable('PARAM_CARTELLINO',otString);
        OQ.SetVariable('PARAM_CARTELLINO',PDatiVista.ParamCartellino);
      end;
      // esegue query
      OQ.SQL.Text:='select :S from DUAL';
      OQ.Execute;
      RFilePdfSost:=OQ.FieldAsString(0);
      Result:=True;
    except
      on E:Exception do
      begin
        RErrMsg:=Format('Errore nella sintassi del parametro aziendale "Web: nome file pdf per servizio stampa cartellini": %s (%s)',[E.Message,E.ClassName]);
        Exit;
      end;
    end;
  finally
    FreeAndNil(OQ);
  end;
end;

function TA159FArchiviazioneCartelliniMW.CtrlFilePdf(const PParFilePdf: String; var RErrMsg: String): Boolean;
// restituisce True se il parametro aziendale relativo al nome file pdf
// - è corretto a livello sintattico
// - e contiene solo variabili conosciute
// oppure False altrimenti
var
  DatiTest: TDatiC600SelAnagrafe;
  TempStr: String;
begin
  // controlla il nome file pdf utilizzando dati fittizi (ma sintatticamente ok)
  // per la sostituzione variabili
  DatiTest.Matricola:='99999999';
  DatiTest.Progressivo:=5000;
  DatiTest.Dal:=R180InizioMese(Date);
  DatiTest.ParamCartellino:='TEST';
  //
  Result:=_CtrlFilePdf(PParFilePdf,DatiTest,TempStr,RErrMsg);
end;

function TA159FArchiviazioneCartelliniMW.EsistonoAnomalie: Boolean;
var
  ErrMsg: string;
  i: Integer;
begin
  Result:=False;
  if Assigned(W009DtM) then
    for i:=0 to W009DtM.R400FCartellinoDtM.lstAnomalieMM.Count - 1 do
    begin
      if R180In(W009DtM.R400FCartellinoDtM.lstAnomalieMM[i].LivNum,Anomalie.Split([',']))
      or (W009DtM.R400FCartellinoDtM.lstAnomalieMM[i].Livello = 1)
      then
      begin
        ErrMsg:=Format('Anomalia: Data: %s, ID: %s, Descrizione: %s',[
                       FormatDateTime('dd/mm/yyyy', W009DtM.R400FCartellinoDtM.lstAnomalieMM[i].Data),
                       W009DtM.R400FCartellinoDtM.lstAnomalieMM[i].LivNum,
                       W009DtM.R400FCartellinoDtM.lstAnomalieMM[i].Descrizione]);
        RegistraMsg.InserisciMessaggio('A',ErrMsg,Parametri.Azienda,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        Result:=True;
      end;
    end;
end;

function TA159FArchiviazioneCartelliniMW.GetPathPdf(const PPath:String; const PDatiVista: TDatiC600SelAnagrafe):String;
begin
  Result:=PPath;
  Result:=Result.Replace(':ANNO',R180Anno(PDatiVista.Dal).ToString,[rfignoreCase,rfReplaceAll]);
  Result:=Result.Replace(':MESE',R180LPad(R180Mese(PDatiVista.Dal).ToString,2,'0'),[rfignoreCase,rfReplaceAll]);
end;

function TA159FArchiviazioneCartelliniMW.GetNomeFilePdf(const PParFilePdf: String; const PDatiVista: TDatiC600SelAnagrafe): String;
// restituisce il nome file sostituendo i dati variabili con i valori del record
// attuale della vista specificato in PDatiVista (usato sia per pdf che per metadati)
var
  ErrMsg: String;
begin
  // sostituisce le eventuali variabili contenute nel nome
  // con i valori del record attuale della vista
  if not _CtrlFilePdf(PParFilePdf,PDatiVista,Result,ErrMsg) then
    raise Exception.Create(ErrMsg);
end;

procedure TA159FArchiviazioneCartelliniMW.InizioElaborazione;
begin
  TempoIni:=Now;
  // log avvio elaborazione
  RegistraMsg.IniziaMessaggio('A159');
  InfoMsg:='avvio elaborazione';
  RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
  ParAziendaliList.Clear;
  InfoMsg:='verifica dei parametri aziendali: completata correttamente';
  RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
  InfoMsg:='produzione dei cartellini: inizio';
  RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));

  ContaSalvataggi:=0; //azzero il conteggio dei cartellini salvati (se al termine sarà zero non salvo il registro)

  if SalvareSuDB and (selI210.FieldByName('CAMPI_XML').AsString.Trim <> '') then  //se salvo su db ed è presente la regola per la creazione degli elementi del registro
    A210MW.CreaRegistroJSON('registro_archiviazione_cartellini', Now);  // creazione del registro

  SelAnagrafe.First;
  SelAnagrafe.EnableControls;
  if Assigned(ResettaProgressBar) then
    ResettaProgressBar;
  if Assigned(MaxProgressBar) then
    MaxProgressBar(SelAnagrafe.RecordCount);
end;

procedure TA159FArchiviazioneCartelliniMW.ElaboraElemento;
var
  DatiC600SelAnagrafe:TDatiC600SelAnagrafe;
  FilePdfOutput, InfoAvanzamento, ErrMsg:string;
  Data{,Dal,Al}:TDateTime;
  LPadding:integer;
  NoteIter: String;
  LResCtrl: TResCtrl;
  IdT960: Integer;
begin
  if Assigned(IncrementaProgressBar) then
    IncrementaProgressBar;
  Application.ProcessMessages;
  // imposta variabili per gestione
  DatiC600SelAnagrafe.Matricola:=SelAnagrafe.FieldByName('MATRICOLA').AsString;
  DatiC600SelAnagrafe.CodFiscale:=SelAnagrafe.FieldByName('CODFISCALE').AsString;
  DatiC600SelAnagrafe.Cognome:=SelAnagrafe.FieldByName('COGNOME').AsString;
  DatiC600SelAnagrafe.Nome:=SelAnagrafe.FieldByName('NOME').AsString;
  DatiC600SelAnagrafe.Inizio:=SelAnagrafe.FieldByName('T430INIZIO').AsDateTime;
  DatiC600SelAnagrafe.Fine:=SelAnagrafe.FieldByName('T430FINE').AsDateTime;
  DatiC600SelAnagrafe.Progressivo:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  DatiC600SelAnagrafe.Dal:=PeriodoDal;
  DatiC600SelAnagrafe.Al:=PeriodoAl;
  DatiC600SelAnagrafe.ParamCartellino:=Parametrizzazione;
  //ciclo per gestire i due tipi di generazione PDF: unico periodo o singolo mese
  data:=R180InizioMese(PeriodoDal);
  while data <= R180InizioMese(PeriodoAl) do
  try
    //se l'ultimo livello è validato non lo devo più archiviare
    if isService and VerificaValidazione and ValidazioneUltimoLivello(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger, data) then
    begin
      //se la generazione dei PDF è di un unico periodo esco dal ciclo degli anni, altrimenti passo al mese successivo
      if not SingoloMese then
        Break
      else
        Continue;   //esegue il finally
    end;

    //se la generazione dei PDF è per singolo mese, determino il primo e l'ultimo giorno del mese in considerazione, e aggiorno il mese del cartellino per rinominare correttamente i file
    if SingoloMese then
    begin
      DatiC600SelAnagrafe.Dal:=data;
      DatiC600SelAnagrafe.Al:=R180FineMese(data);
    end;
    if TipoCartellino then
    begin
      R180SetVariable(selT025,'PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      R180SetVariable(selT025,'DATA_CARTELLINO',IfThen(SingoloMese, R180FineMese(data), PeriodoAl));
      selT025.Open;
      if selT025.RecordCount > 0 then
        DatiC600SelAnagrafe.ParamCartellino:=selT025.FieldByName('PAR_CARTELLINO').AsString
      else
      begin
        DatiC600SelAnagrafe.ParamCartellino:=Parametrizzazione;
        InfoMsg:=FilePdfOutput + ' - La parametrizzazione di tipo cartellino non esiste, verrà usata di default';
        RegistraMsg.InserisciMessaggio('I',InfoMsg);
      end;
    end;

    InfoMsg:=Format('Matr. %s - %s - param. %s',[DatiC600SelAnagrafe.Matricola,FormatDateTime('mmmm yyyy',data),DatiC600SelAnagrafe.ParamCartellino]);
    if not isService then
      // info log
      RegistraMsg.InserisciMessaggio('I',InfoMsg,Parametri.Azienda,DatiC600SelAnagrafe.Progressivo);

    try
      //se è richiesta la validazione del cartellino e non è validato sull'ultimo livello, non lo salvo
      if VerificaValidazione then
        if not EseguiScriptValidazione(DatiC600SelAnagrafe.Progressivo, R180InizioMese(DatiC600SelAnagrafe.Dal)) then
        begin
          if not isService then
          begin
            InfoMsg:=Format(InfoMsg + ': Cartellino non validato, non è stato archiviato',[DatiC600SelAnagrafe.Matricola, FormatDateTime('mmmm yyyy',data)]);
            RegistraMsg.InserisciMessaggio('A', InfoMsg, Parametri.Azienda, DatiC600SelAnagrafe.Progressivo);
          end;

          if not SingoloMese then
            Break
          else
            Continue;      //esegue il finally
        end;
    except   //se c'è un errore nella valutazione della validazione lo registro e vado al documento successivo
      on E: Exception do
      begin
        ErrMsg:=InfoMsg + ': Errore durante la verifica della validazione del cartellino';
        RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,E.Message,E.ClassName]));

        if not SingoloMese then
          Break
        else
          Continue;      //esegue il finally
      end;
    end;

    // a. genera il cartellino pdf
    CSStampaCartellino.Enter;
    try
      try
        InfoAvanzamento:=Format('Matr. %s - %s - param. %s',[DatiC600SelAnagrafe.Matricola,FormatDateTime('mmmm yyyy',data),DatiC600SelAnagrafe.ParamCartellino]);
        if SalvaSuDocumentale then
        begin
          NoteIter:='';
          //se è richiesto il recupero delle note dall'iter da inserire nel documentale
          if selI210.FieldByName('SCRIPT_NOTE').AsString.Trim  <> '' then
            NoteIter:=EseguiScriptNote(DatiC600SelAnagrafe.Progressivo, R180InizioMese(DatiC600SelAnagrafe.Dal));

          if Versionabile then  //se la tipologia è versionabile, non dipende dal flag sovrascrivi
          begin
            if SalvareSuDB then
              IdT960:=SalvaSuDB(DatiC600SelAnagrafe, InfoAvanzamento, NoteIter)
            else
              raise Exception.Create('Impossibile salvare un documento con tipologia versionabile su file system');
          end
          else  //se la tipologia non è versionabile, dipende dal flag sovrascrivi
          begin
            if SalvareSuDB then
              IdT960:=SalvaSuDB(DatiC600SelAnagrafe, InfoAvanzamento, NoteIter)
            else
              IdT960:=SalvaSuFileSystem(DatiC600SelAnagrafe, False, InfoAvanzamento, NoteIter);
          end;
        end
        else   //non è presente la tipologia, salvo solo su FS, eventualmente con metadati
          IdT960:=SalvaSuFileSystem(DatiC600SelAnagrafe, True, InfoAvanzamento, '');

        //se è richiesta l'esecuzione dello script post archiviazione
        if selI210.FieldByName('SCRIPT_ARCHIVIAZIONE').AsString.Trim  <> '' then
        begin
          LResCtrl:=EseguiScriptArchiviazione(DatiC600SelAnagrafe.Progressivo, IdT960, R180InizioMese(DatiC600SelAnagrafe.Dal));
          if not LResCtrl.Ok then
            raise Exception.Create(LResCtrl.Messaggio);
        end;
      except
        on E: Exception do
        begin
          ErrMsg:=InfoAvanzamento + ': errore durante l''elaborazione';
          RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,E.Message,E.ClassName]));
        end;
      end;
    finally
      CSStampaCartellino.Leave;
      SessioneOracle.Commit;
    end;

    if not SingoloMese then
      Break
  finally
    //se la generazione dei PDF è di un unico periodo esco dal ciclo degli anni, altrimenti passo al mese successivo
    if SingoloMese then
      data:=R180AddMesi(data,1);
  end;
end;

function TA159FArchiviazioneCartelliniMW.SalvaSuDB(DatiC600SelAnagrafe: TDatiC600SelAnagrafe; InfoAvanzamento, NoteIter: String): Integer;
var FilePdfOutput, LTempFilePath, LTempFileName, ErrMsg: String;
    IdT960: Integer;
    LDoc: TDocumento;
    LResCtrl: TResCtrl;
begin
  Result:=-1;
  //nome del file che comparirà sul db
  FilePdfOutput:=GetNomeFilePdf(LParAziendali.FilePdf, DatiC600SelAnagrafe);

  if not Versionabile and not Sovrascrivi then
  begin
    //se il file è già presente su db e non lo devo sovrascrivere, registro l'anomalia ed esco
    if C021DM.CheckFileEsistente(DatiC600SelAnagrafe.Progressivo,
                                 TPath.GetFileNameWithoutExtension(FilePdfOutput),
                                 TPath.GetExtension(FilePdfOutput).Replace(TPath.ExtensionSeparatorChar,''),
                                 selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString.Trim) then
    begin
      InfoMsg:=InfoAvanzamento + ': ' + FilePdfOutput + ' - File già esistente: non sovrascritto';
      RegistraMsg.InserisciMessaggio('A', InfoMsg, Parametri.Azienda, DatiC600SelAnagrafe.Progressivo);
      Exit;
    end;
  end;

  if Versionabile and not CreaNuovaVersione then
  begin
    if C021DM.GetMaxVersione(DatiC600SelAnagrafe.Progressivo,
                             TPath.GetFileNameWithoutExtension(FilePdfOutput),
                             TPath.GetExtension(FilePdfOutput).Replace(TPath.ExtensionSeparatorChar,''),
                             selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString.Trim) > 0 then
    begin
      InfoMsg:=InfoAvanzamento + ': ' + FilePdfOutput + ' - Versione precedente già esistente: non è stata creata una nuova versione';
      RegistraMsg.InserisciMessaggio('I', InfoMsg, Parametri.Azienda, DatiC600SelAnagrafe.Progressivo);
      Exit;
    end;
  end;

  //nome e percorso di salvataggio del file temporaneo
  LTempFilePath:=TPath.GetTempPath;
  LTempFileName:=TPath.Combine(LTempFilePath,TPath.GetRandomFileName);

  ErrMsg:=CreaCartellinoPDF(SessioneOracle, DatiC600SelAnagrafe.Matricola, DatiC600SelAnagrafe.Progressivo, DatiC600SelAnagrafe.Dal, DatiC600SelAnagrafe.Al, DatiC600SelAnagrafe.ParamCartellino, LTempFileName, 'N');
  if ErrMsg = '' then //se il file è stato creato correttamente
  begin
    //inserimento su T960 eventualmente con versione
    LDoc:=TDocumento.Create;
    try
      LDoc.Id:=0;
      LDoc.DataCreazione:=Now;
      LDoc.NomeUtente:='';
      LDoc.Utente:=Parametri.Operatore;
      LDoc.Progressivo:=DatiC600SelAnagrafe.Progressivo;
      LDoc.Tipologia:=selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString.Trim;
      LDoc.Ufficio:='*';
      LDoc.NomeFile:=TPath.GetFileNameWithoutExtension(FilePdfOutput);
      LDoc.ExtFile:=TPath.GetExtension(FilePdfOutput);
      LDoc.TempFile:=LTempFileName;
      LDoc.PeriodoDal:=DatiC600SelAnagrafe.Dal;
      LDoc.PeriodoAl:=DatiC600SelAnagrafe.Al;
      LDoc.Dimensione:=R180GetFileSize(LTempFileName);
      LDoc.CFFamiliare:='';
      LDoc.Note:=NoteIter;
      LDoc.Provenienza:='I';
      LDoc.PathStorage:=DOC_STORAGE_DB;

      LResCtrl:=C021DM.Save(LDoc, Sovrascrivi, Versionabile, True, IdT960);

      if LResCtrl.Ok then
      begin
        if selI210.FieldByName('CAMPI_XML').AsString.Trim <> '' then //se è presente la regola per la creazione dell'elemento nel registro
          A210MW.AddDocumentoJSON(IdT960);
        ContaSalvataggi:=ContaSalvataggi+1;
        Result:=IdT960;

        InfoMsg:=Format('%s: cartellino pdf salvato su database',[InfoAvanzamento]);
        RegistraMsg.InserisciMessaggio('I',InfoMsg,Parametri.Azienda,DatiC600SelAnagrafe.Progressivo);
      end
      else
      begin
        InfoMsg:=Format('%s: errore durante caricamento su gestione documentale: %s',[InfoAvanzamento, LResCtrl.Messaggio]);
        RegistraMsg.InserisciMessaggio('A',InfoMsg,Parametri.Azienda,DatiC600SelAnagrafe.Progressivo);
      end;
    finally
      FreeAndNil(LDoc);
    end;
  end
  else
  begin
    // elaborazione con errori
    InfoMsg:=Format('%s: errore durante produzione cartellino: %s',[InfoAvanzamento,ErrMsg]);
    RegistraMsg.InserisciMessaggio('A',InfoMsg,Parametri.Azienda,DatiC600SelAnagrafe.Progressivo);
  end;
end;

function TA159FArchiviazioneCartelliniMW.SalvaSuFileSystem(DatiC600SelAnagrafe: TDatiC600SelAnagrafe; CreaFileMetadati: Boolean; InfoAvanzamento, NoteIter: String): Integer;
var FullPathPdfOutput, PathPdfOutput, FileMetadatiOutput, RegolaSQL, ErrMsg: String;
    LDoc: TDocumento;
    LResCtrl: TResCtrl;
    IdT960: Integer;
begin
  Result:=-1;
  //determina il nome del file pdf del cartellino
  PathPdfOutput:=GetPathPdf(LParAziendali.PathPdf, DatiC600SelAnagrafe);
  FullPathPdfOutput:=TPath.Combine(PathPdfOutput, GetNomeFilePdf(LParAziendali.FilePdf, DatiC600SelAnagrafe));
  //
  if (TFile.Exists(FullPathPdfOutput)) and not Sovrascrivi then
  begin
    InfoMsg:=InfoAvanzamento + ': ' + FullPathPdfOutput + ' - File già esistente: non sovrascritto';
    RegistraMsg.InserisciMessaggio('A', InfoMsg, Parametri.Azienda, DatiC600SelAnagrafe.Progressivo);
  end
  else
  begin
    //se salvo su file system ed è già esistente, sovrascrivo e rimpiazzo il record nella T960!!!!!
    ErrMsg:=CreaCartellinoPDF(SessioneOracle, DatiC600SelAnagrafe.Matricola, DatiC600SelAnagrafe.Progressivo, DatiC600SelAnagrafe.Dal, DatiC600SelAnagrafe.Al, DatiC600SelAnagrafe.ParamCartellino, FullPathPdfOutput, 'N');

    if ErrMsg = '' then
    begin
      ContaSalvataggi:=ContaSalvataggi+1;
      InfoMsg:=Format('%s: cartellino pdf salvato in %s', [InfoAvanzamento, FullPathPdfOutput]);
      RegistraMsg.InserisciMessaggio('I', InfoMsg, Parametri.Azienda, DatiC600SelAnagrafe.Progressivo);

      //Se è richiesta la creazione del file di metadati in formato json
      if CreaFileMetadati and (selI210.FieldByName('FILE_XML').AsString.Trim <> '') and (selI210.FieldByName('TIPO_FILE_METADATI').AsString = 'J') then
      begin
        // determina il nome e regole del file di metadati
        FileMetadatiOutput:=GetNomeFilePdf(selI210.FieldByName('FILE_XML').AsString,DatiC600SelAnagrafe);
        FileMetadatiOutput:=TPath.Combine(PathPdfOutput,FileMetadatiOutput);
        RegolaSQL:=selI210.FieldByName('CAMPI_XML').AsString;
        //Crea il file json
        CreaFileJSON(DatiC600SelAnagrafe, RegolaSQL, FileMetadatiOutput);
      end;

      if SalvaSuDocumentale then  //inserimento su T960
      begin
        LDoc:=TDocumento.Create;
        try
          LDoc.Id:=0;
          LDoc.DataCreazione:=Now;
          LDoc.NomeUtente:='';
          LDoc.Utente:=Parametri.Operatore;
          LDoc.Progressivo:=DatiC600SelAnagrafe.Progressivo;
          LDoc.Tipologia:=selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString;
          LDoc.Ufficio:='*';
          LDoc.NomeFile:=TPath.GetFileNameWithoutExtension(FullPathPdfOutput);
          LDoc.ExtFile:=TPath.GetExtension(FullPathPdfOutput);
          LDoc.TempFile:='';
          LDoc.PeriodoDal:=DatiC600SelAnagrafe.Dal;
          LDoc.PeriodoAl:=DatiC600SelAnagrafe.Al;
          LDoc.Dimensione:=R180GetFileSize(FullPathPdfOutput);
          LDoc.CFFamiliare:='';
          LDoc.Note:=NoteIter;
          LDoc.Provenienza:='E';   //richiesto per TORINO_ASLCITTA che salva su file system
          LDoc.PathStorage:=PathPdfOutput;

          LResCtrl:=C021DM.Save(LDoc, Sovrascrivi, False, False, IdT960);
          if LResCtrl.Ok then
            Result:=IdT960
          else
          begin
            InfoMsg:=Format('%s: errore durante caricamento su gestione documentale: %s',[InfoAvanzamento, LResCtrl.Messaggio]);
            RegistraMsg.InserisciMessaggio('A',InfoMsg,Parametri.Azienda,DatiC600SelAnagrafe.Progressivo);
          end;
        finally
          FreeAndNil(LDoc);
        end;
      end;
    end
    else
    begin
      // elaborazione con errori
      InfoMsg:=Format('%s: errore durante produzione cartellino: %s', [InfoAvanzamento, ErrMsg]);
      RegistraMsg.InserisciMessaggio('A', InfoMsg,Parametri.Azienda, DatiC600SelAnagrafe.Progressivo);
    end;
  end;
end;

function TA159FArchiviazioneCartelliniMW.CreaCartellinoPDF(pSessioneOracle:TOracleSession; pMatricola: String; pProgressivo: Integer; pDal,pAl:TDateTime; Parametrizzazione,FilePdf,CartelliniChiusi: String): String;
// Stessa procedura utilizzata in IrisWEB in W009UStampaCartellino
var DataI,DataF:TDateTime;
    A,M,G,A2,M2,G2:Word;
    iSQL:Integer;
    S,SQLText:String;
    CodiceT950:String;
    lst:TStringList;
    FS:TFormatSettings;
    PathModelliRave: String;
begin
  W009Dtm:=TW009FStampaCartellinoDtm.Create(SessioneOracle);
  Result:='';
  // verifica e impostazione path modelli corretto
  {$IFNDEF IRISWEB}
  PathModelliRave:=ExtractFilePath(Application.ExeName);
  PathModelliRave:=IncludeTrailingPathDelimiter(PathModelliRave) + RAVE_MODEL_REL_PATH;
  {$ELSE}
  PathModelliRave:=IncludeTrailingPathDelimiter(gSC.ContentPath) + 'report';
  {$ENDIF}
  if not TDirectory.Exists(PathModelliRave) then
    PathModelliRave:=A000GetHomePath;
  if not TDirectory.Exists(PathModelliRave) then
  begin
    Result:=Format('Il path dei modelli di stampa indicato è invalido o non accessibile: "%s". Verificare la variabile di ambiente HKLM\Software\IrisWin\HOME',[PathModelliRave]);
    exit;
  end;
  {$WARN SYMBOL_PLATFORM OFF}
  FS:=TFormatSettings.Create(MAKELCID(MAKELANGID(LANG_ITALIAN, SUBLANG_ITALIAN), SORT_DEFAULT));  //non serve fare il free
  {$WARN SYMBOL_PLATFORM ON}
  FS.ShortDateFormat:='dd/mm/yyyy';
  W009DtM.Sessione:=pSessioneOracle;
  W009DtM.selAnagrafeW:=W009DtM.selAnagrafeApp;//W009DtM.selAnagrafeProgr;
  W009DtM.selAnagrafeW.Session:=pSessioneOracle;
  W009DtM.CartelliniChiusi:=CartelliniChiusi = 'S';
  W009DtM.Stampa:=True;
  W009DtM.RegLog:=False;
  W009DtM.RaveProjectFile:=IncludeTrailingPathDelimiter(PathModelliRave) + RAVE_MODEL_CARTELLINO;
  W009DtM.NomeFile:=FilePDF;
  W009DtM.RaveOutputFileName:=FilePDF;
  DataI:=pDal;
  DataF:=pAl;
  if DataF < DataI then
  begin
    Result:='Date non corrette!';
    exit;
  end;
  if R180Anno(DataI) <> R180Anno(DataF) then
  begin
    Result:='Le date devono essere riferite allo stesso anno!';
    exit;
  end;
  if DataI < Parametri.WEBCartelliniDataMin then
  begin
    Result:=Format('Non è possibile elaborare il cartellino prima del %s!',[DateToStr(Parametri.WEBCartelliniDataMin)]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMPrec >= 0) and (R180AddMesi(R180InizioMese(DataI),Parametri.WEBCartelliniMMPrec) < R180InizioMese(Date)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino antecedente di %d mesi!',[Parametri.WEBCartelliniMMPrec]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMSucc >= 0) and (R180InizioMese(DataF) > R180AddMesi(R180InizioMese(Date),Parametri.WEBCartelliniMMSucc)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino successivo a %d mesi!',[Parametri.WEBCartelliniMMSucc]);
    exit;
  end;
  SQLText:=W009DtM.selAnagrafeW.SQL.Text;
  CodiceT950:=Parametrizzazione;
  DecodeDate(DataI,A,M,G);
  DecodeDate(DataF,A2,M2,G2);
  //Se le date differiscono di mese o di anno, allora i giorni vanno
  //da 1 all'ultimo del mese
  if (M <> M2) or (A <> A2) then
  begin
    G:=1;
    G2:=R180GiorniMese(DataF);
    DataI:=EncodeDate(A,M,G);
    DataF:=EncodeDate(A2,M2,G2);
    pDal:=DataI;
    pAl:=DataF;
  end;
  try
    W009DtM.CreazioneR400(pSessioneOracle); //W009FStampaCartellinoDtm.W009FStampaCartellinoDtM.R400FCartellinoDtM:=TW009FStampaCartellinoDtM.R400FCartellinoDtM.Create(Self);
    W009DtM.R400FCartellinoDtM.R450DtM1.Name:=''; //Altrimenti duplicazione sul nome quando viene creata la R450 dalla R600 per i conteggi di alcune assenze
    W009DtM.R400FCartellinoDtM.R600DtM1.Name:='';
    W009DtM.R400FCartellinoDtM.R410FAutoGiustificazioneDtM.Name:='';
  except
    on E:Exception do
    begin
      Result:=E.Message;
      exit;
    end;
  end;
  //RegistraMsg.IniziaMessaggio('W009');
  if False then
    W009DtM.CreazioneR350;
  if False then
    W009DtM.CreazioneR300(DataI,DataF);
  try
    try
      with W009DtM.R400FCartellinoDtM.Q950Int do
      begin
        Close;
        SetVariable('Codice',CodiceT950);
        Open;
      end;
      W009DtM.R400FCartellinoDtM.selDatiBloccati.Close;
      W009DtM.R400FCartellinoDtM.SoloAggiornamento:=False;
      W009DtM.R400FCartellinoDtM.AggiornamentoScheda:=AggiornamentoSchedaRiep;
      W009DtM.R400FCartellinoDtM.AutoGiustificazione:=False;
      W009DtM.R400FCartellinoDtM.CalcoloCompetenze:=False;
      W009DtM.R400FCartellinoDtM.IgnoraAnomalie:=False;
      W009DtM.R400FCartellinoDtM.AnomalieBloccantiExtra:=Anomalie;
      W009DtM.R400FCartellinoDtM.lstDettaglio.Clear;
      W009DtM.R400FCartellinoDtM.lstRiepilogo.Clear;

      if (not W009DtM.R400FCartellinoDtM.CheckAggiornamentoAbilitato(pProgressivo,R180InizioMese(DataI))) then
        raise Exception.Create('Aggiornamento non abilitato - file non generato');

      W009DtM.R400FCartellinoDtM.LeggiDatiRichiesti('Intestazione');
      W009DtM.R400FCartellinoDtM.LeggiDatiRichiesti('Dettaglio');
      W009DtM.R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');
      if W009DtM.selAnagrafeW.VariableIndex('MATRICOLA') >= 0 then
        W009DtM.selAnagrafeW.SetVariable('MATRICOLA',pMatricola)
      else
        W009DtM.selAnagrafeW.SetVariable('PROGRESSIVO',pProgressivo);
      W009DtM.selAnagrafeW.SetVariable('DATALAVORO',DataF);
      W009DtM.selAnagrafeW.Close;
      if (Pos(W009DtM.R400FCartellinoDtM.CampiIntestazione,W009DtM.SelAnagrafeW.SQL.Text) = 0) and
         ((Pos('T030.*',W009DtM.SelAnagrafeW.SQL.Text) = 0) or (Pos('V430.*',W009DtM.SelAnagrafeW.SQL.Text) = 0)) and
         (W009DtM.R400FCartellinoDtM.CampiIntestazione <> '') then
      begin
        S:=W009DtM.SelAnagrafeW.SQL.Text;
        iSQL:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
        if iSQL > 0 then
          Insert(',' + W009DtM.R400FCartellinoDtM.CampiIntestazione + ' ',S,iSQL);
        W009DtM.SelAnagrafeW.SQL.Text:=S;
      end;
      W009DtM.selAnagrafeW.Open;
      lst:=TStringList.Create;
      with W009DtM.R400FCartellinoDtM do
      try
        SetLength(VetDatiLiberiSQL,0);
        selT951.Close;
        selT951.SetVariable('Codice',Q950Int.FieldByName('CODICE').AsString);
        selT951.Open;
        while not selT951.Eof do
        begin
          lst.Add(Trim(selT951.FieldByName('RIGA').AsString));
          selT951.Next;
        end;
        selT951.Close;
        W009DtM.GetLabels(lst,'Riepilogo2001',nil);
        //Devo già avere l'elenco dei dati liberi 2001
        CreaClientDataSet(W009DtM.selAnagrafeW);
      finally
        lst.Free;
      end;
      W009DtM.R400FCartellinoDtM.A027SelAnagrafe:=W009DtM.selAnagrafeW;
      //Posizionamento sulla matricola correntemente selezionata
      //if W009DtM.selAnagrafeW.SearchRecord('PROGRESSIVO',pProgressivo,[srFromBeginning]) then
      if W009DtM.selAnagrafeW.SearchRecord('MATRICOLA',pMatricola,[srFromBeginning]) then
        Result:=W009DtM.CalcoloCartellini(A,M,G,A2,M2,G2)
      else
      begin
        //GetDipendentiDisponibili(DataF);
        Result:='Anagrafico non disponibile';
        Abort;
      end;
      W009DtM.ChiusuraQuery(W009DtM.R400FCartellinoDtM);
      with W009DtM.R400FCartellinoDtM do
      begin
        //Chiudo subito le query e le unit dei conteggi, salvo Q950Int che serve in stampa
        Q950Int.Open;
        selT004.Open;
        W009DtM.ChiusuraQuery(R450DtM1);
        FreeAndNil(W009DtM.R400FCartellinoDtM.R450DtM1);
        FreeAndNil(W009DtM.R400FCartellinoDtM.R600DtM1);
      end;
      try
       if W009DtM.R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0 then
       begin
         //se non esistono anomalie tra quelle selezionate nella maschera si procedere alla produzione del pdf
         if EsistonoAnomalie then
         begin
           Result:='Riscontrate anomalie bloccanti - file non generato';
         end
         //else if W009DtM.R400FCartellinoDtM.AggiornamentoScheda and (not W009DtM.R400FCartellinoDtM.AggiornamentoEseguito) then
         else if W009DtM.R400FCartellinoDtM.AggiornamentoScheda and
                 (not W009DtM.R400FCartellinoDtM.ExistsSchedeAggiornate(pProgressivo,R180InizioMese(DataI))) then
         begin
           Result:='Aggiornamento scheda non effettuato - file non generato'
         end
         else
         begin
           W009DtM.W009CSStampa:=CSStampa;
           W009DtM.RPDefine_DataID(Copy(Self.Name,1,4));
           Result:=W009DtM.EsecuzioneStampa;
         end;
       end
       else
         Result:='Nessun cartellino disponibile nel periodo specificato';
      except
        on E:Exception do
          Result:=E.Message;
      end;
      with W009DtM.R400FCartellinoDtM do
      begin
        cdsRiepilogo.Close;
        cdsDettaglio.Close;
        cdsSettimana.Close;
        cdsAssenze.Close;
        cdsPresenze.Close;
        Q950Int.CloseAll;
      end;
    finally
      W009DtM.R400FCartellinoDtM.Q950Int.CloseAll;
      W009DtM.selAnagrafeW.CloseAll;
      //W009FStampaCartellinoDtm.selAnagrafeW.SQL.Text:=SQLText;
      if W009DtM.R400FCartellinoDtM <> nil then
      begin
        W009DtM.R400FCartellinoDtM.Q950Int.CloseAll;
        W009DtM.R400FCartellinoDtM.A027SelAnagrafe:=nil;
        FreeAndNil(W009DtM.R400FCartellinoDtM);
      end;
      W009DtM.DistruggiLstRaveComp;
      FreeAndNil(W009DtM);
    end;
  except
    on E:Exception do
      Result:=E.Message;
  end;
end;

function TA159FArchiviazioneCartelliniMW.VerificaFileEsistenti: Integer;
var Data: TDateTime;
    DatiC600SelAnagrafe: TDatiC600SelAnagrafe;
    PathPdfOutput, FilePdfOutput: String;
begin
  Result:=0;
  SelAnagrafe.DisableControls;
  try
    SelAnagrafe.First;
    while not SelAnagrafe.Eof do
    begin
      try
        Data:=R180InizioMese(PeriodoDal);

        DatiC600SelAnagrafe.Matricola:=SelAnagrafe.FieldByName('MATRICOLA').AsString;
        DatiC600SelAnagrafe.CodFiscale:=SelAnagrafe.FieldByName('CODFISCALE').AsString;
        DatiC600SelAnagrafe.Cognome:=SelAnagrafe.FieldByName('COGNOME').AsString;
        DatiC600SelAnagrafe.Nome:=SelAnagrafe.FieldByName('NOME').AsString;
        DatiC600SelAnagrafe.Inizio:=SelAnagrafe.FieldByName('T430INIZIO').AsDateTime;
        DatiC600SelAnagrafe.Fine:=SelAnagrafe.FieldByName('T430FINE').AsDateTime;
        DatiC600SelAnagrafe.Progressivo:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        DatiC600SelAnagrafe.Dal:=PeriodoDal;
        DatiC600SelAnagrafe.Al:=PeriodoAl;
        DatiC600SelAnagrafe.ParamCartellino:=Parametrizzazione;

        while Data <= R180InizioMese(PeriodoAl) do
        begin
          //se la generazione dei PDF è per singolo mese, determino il primo e l'ultimo giorno del mese in considerazione, e aggiorno il mese del cartellino per rinominare correttamente i file
          if SingoloMese then
          begin
            DatiC600SelAnagrafe.Dal:=Data;
            DatiC600SelAnagrafe.Al:=R180FineMese(Data);
          end;

          FilePdfOutput:=GetNomeFilePdf(LParAziendali.FilePdf,DatiC600SelAnagrafe);
          PathPdfOutput:=GetPathPdf(LParAziendali.PathPdf, DatiC600SelAnagrafe);

          if not SalvareSuDB then     //verifico se è già presente su file system
          begin
            if TFile.Exists(TPath.Combine(PathPdfOutput, FilePdfOutput)) and Sovrascrivi then
              Result:=Result+1;
          end
          else if SalvareSuDB and not Versionabile then //verifico se il file è già stato salvato senza versione
          begin
            if Sovrascrivi then
            begin
              if C021DM.CheckFileEsistente(DatiC600SelAnagrafe.Progressivo,
                                 TPath.GetFileNameWithoutExtension(FilePdfOutput),
                                 TPath.GetExtension(FilePdfOutput).Replace(TPath.ExtensionSeparatorChar,''),
                                 selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString.Trim) then
                Result:=Result+1;
            end;
          end
          else if SalvareSuDB and Versionabile then //verifico se è già presente una versione
          begin
            if C021DM.GetMaxVersione(DatiC600SelAnagrafe.Progressivo,
                                     TPath.GetFileNameWithoutExtension(FilePdfOutput),
                                     TPath.GetExtension(FilePdfOutput).Replace(TPath.ExtensionSeparatorChar,''),
                                     selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString.Trim) > 0 then
              Result:=Result+1;
          end;

          //se la generazione dei PDF è di un unico periodo esco dal ciclo degli anni, altrimenti passo al mese successivo
          if not SingoloMese then
            Break
          else
            data:=R180AddMesi(data,1);
        end;
      finally
        SelAnagrafe.Next;
      end;
    end;
  finally
    SelAnagrafe.EnableControls;
  end;
end;

procedure TA159FArchiviazioneCartelliniMW.CreaFileJSON(DatiC600SelAnagrafe: TDatiC600SelAnagrafe; RegolaSQL: String; DocumentoJSON: String);
var ErrMsg: String;
begin
  RegolaSQL:=RegolaSQL.Replace(':PROGRESSIVO', DatiC600SelAnagrafe.Progressivo.ToString);
  RegolaSQL:=RegolaSQL.Replace(':MESE', '''' + R180Mese(DatiC600SelAnagrafe.Al).ToString + '''');
  RegolaSQL:=RegolaSQL.Replace(':ANNO', '''' + R180Anno(DatiC600SelAnagrafe.Al).ToString + '''');

  A210MW.CreaFileJSON(RegolaSQL, DocumentoJSON, ErrMsg);
  if ErrMsg <> '' then
  begin
    // elaborazione con errori
    InfoMsg:=Format('matr. %s - errore durante produzione del file di metadati: %s',[DatiC600SelAnagrafe.Matricola,ErrMsg]);
    RegistraMsg.InserisciMessaggio('A',InfoMsg,Parametri.Azienda,DatiC600SelAnagrafe.Progressivo);
  end;
end;

function TA159FArchiviazioneCartelliniMW.ShellExecute_AndWait(Operation, FileName, Parameter, Directory: string;
  Show: Word; bWait: Boolean): Longint;
var
  bOK: Boolean;
  Info: TShellExecuteInfo;
begin
  FillChar(Info, SizeOf(Info), Chr(0));
  Info.cbSize:=SizeOf(Info);
  Info.fMask:=SEE_MASK_NOCLOSEPROCESS;
  Info.lpVerb:=PChar(Operation);
  Info.lpFile:=PChar(FileName);
  Info.lpParameters:=PChar(Parameter);
  Info.lpDirectory:=PChar(Directory);
  Info.nShow:=Show;
  CoInitializeEx(nil,COINIT_APARTMENTTHREADED);
  bOK:=Boolean(ShellExecuteEx(@Info));
  if bOK then
  begin
    if bWait then
    begin
      while WaitForSingleObject(Info.hProcess, 100) = WAIT_TIMEOUT do
        Application.ProcessMessages;
      bOK:=GetExitCodeProcess(Info.hProcess, DWORD(Result));
    end
    else
      Result:=0;
  end;
  CoUninitialize;
  if not bOK then
    Result:=-1;
end;

function TA159FArchiviazioneCartelliniMW.ElementoSuccessivo:Boolean;
begin
  Result:=False;
  selAnagrafe.Next;
  if not selAnagrafe.Eof then //richiama calcolo su nuovo dipendente
  begin
    Result:=True;
  end;
end;

procedure TA159FArchiviazioneCartelliniMW.FineCicloElaborazione;
begin
  try
    if SalvareSuDB and (selI210.FieldByName('CAMPI_XML').AsString.Trim <> '') and (ContaSalvataggi > 0) then
    begin
      SalvaEInviaRegistroSuDB;
      //aggiorno l'elenco dei registri per vedere anche quello appena inserito
      selT960Registro.Close;
      selT960Registro.Open;
    end;
  except
    on E: Exception do
      RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,['Errore durante il salvataggio del registro di archiviazione',E.Message,E.ClassName]));
  end;

  SelAnagrafe.First;
  if Assigned(ResettaProgressBar) then
    ResettaProgressBar;
  // log di fine elaborazione
  InfoMsg:=Format('fine elaborazione, durata complessiva: %s',[FormatDateTime('hh.mm.ss.zzz',Now - TempoIni)]);
  RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
end;

function TA159FArchiviazioneCartelliniMW.TotalRecordsElaborazione:integer;
begin
  Result:=SelAnagrafe.RecordCount;
end;

function TA159FArchiviazioneCartelliniMW.CurrentRecordElaborazione:integer;
begin
  Result:=SelAnagrafe.RecNo;
end;

procedure TA159FArchiviazioneCartelliniMW.EseguiBatchPostElaborazione(const PBaseDir: String;
  const PNomeFile: String);
// se presente esegue il file batch per le eventuali operazioni post-elaborazione
// il file batch ha come nome [BATCH_POST_EXEC], ed è contenuto
// nella cartella dell'eseguibile
// questa procedura viene eseguita a rottura di azienda o mese
// Parametri:
//   PBaseDir
//     cartella base in cui sono presenti i file pdf
//   PNomeFile
//     nome del file finale secondo le richieste del CSI
// PRE: RegistraMsg.IniziaMessaggio è stato richiamato
var
  lstCmd: TStringList;
  FileBatPostElab: String;
  i: Integer;
  Cmd: string;
  CmdPar: string;
  posSpazio: Integer;
  ExecReturn: Integer;
  OldCurrentDir: string;
  InfoAvanzamento: String;
  InfoMsg: String;
  ErrMsg: String;
  LPadding: Integer;
  FilePresente: Boolean;
const
  FUNC_NAME       = 'TA159FArchiviazioneCartelliniMW.EseguiBatchPostElaborazione';
  ERR_MSG         = FUNC_NAME + ' - %s';
  INFO_MSG        = FUNC_NAME + ': %s';
  BATCH_POST_EXEC = 'A159_FineElaborazione.bat';
begin
  // salva cartella corrente
  OldCurrentDir:=GetCurrentDir;
  // cerca il file batch nella directory in cui è presente l'eseguibile (vale anche per il servizio)
  FileBatPostElab:=IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0))) + BATCH_POST_EXEC;

  FilePresente:=TFile.Exists(FileBatPostElab);
  InfoMsg:=Format('file batch di post-elaborazione [%s] %s',
                  [FileBatPostElab,IfThen(FilePresente,'presente','non presente')]);
  RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));

  if FilePresente then
  begin
    InfoMsg:='esecuzione comandi di post-elaborazione: inizio';
    RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
    // carica stringlist con comandi batch da eseguire
    lstCmd:=TStringList.Create;
    try
      lstCmd.LoadFromFile(FileBatPostElab);
      // imposta la directory corrente
      SetCurrentDir(PBaseDir);
      InfoMsg:=Format('impostata la directory corrente: %s',[PBaseDir]);
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
      //
      LPadding:=Trunc(R180Arrotonda(Math.Log10(lstCmd.Count),1,'E'));
      for i:=0 to lstCmd.Count - 1 do
      begin
        Cmd:=lstCmd[i];
        InfoAvanzamento:=Format('riga %.*d:',[LPadding,i + 1]);
        // log comando originale
        InfoMsg:=Format('%s [%s]',[InfoAvanzamento,Cmd]);
        RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
        // sostituzione variabili
        if Pos('<NOME_FILE>',Cmd) > 0 then
        begin
          Cmd:=StringReplace(Cmd,'<NOME_FILE>',PNomeFile,[rfReplaceAll,rfIgnoreCase]);
          // log comando modificato
          InfoMsg:=Format('%s [%s] (variabile sostituita)',[InfoAvanzamento,Cmd]);
          RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
        end;
        // divide il comando dagli eventuali parametri
        CmdPar:='';
        posSpazio:=Pos(' ',Cmd);
        if posSpazio > 1 then
        begin
          CmdPar:=Copy(Cmd,posSpazio,Length(Cmd));
          Cmd:=Copy(Cmd,1,posSpazio);
        end;
        // richiama la shellexecuteandwait
        ExecReturn:=ShellExecute_AndWait('open',Cmd,CmdPar,'',SW_HIDE{SW_NORMAL},True);
        if ExecReturn = 0 then
        begin
          InfoMsg:=Format('%s comando eseguito correttamente',[InfoAvanzamento]);
          RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
        end
        else
        begin
          // se c'è un errore termina senza considerare i comandi successivi
          ErrMsg:=Format('%s errore in fase di esecuzione del comando: exit code %d',[InfoAvanzamento,ExecReturn]);
          RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg]));
          if i < lstCmd.Count - 1 then
          begin
            ErrMsg:=Format('%s l''esecuzione del file batch viene interrotta',[InfoAvanzamento]);
            RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg]));
          end;
          Break;
        end;
      end;
      //
      InfoMsg:='esecuzione comandi di post-elaborazione: terminata';
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
    finally
      FreeAndNil(lstCmd);
      SetCurrentDir(OldCurrentDir);
    end;
  end
  else
  begin
    // notifica file batch non presente
    InfoMsg:='nessuna operazione da effettuare';
    RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
  end;
end;

procedure TA159FArchiviazioneCartelliniMW.DichiaraVariabiliScript;
begin
  selScript.DeleteVariables;

  if Pos(':PROGRESSIVO',selScript.SQL.Text) > 0 then
    selScript.DeclareVariable('PROGRESSIVO',otInteger);
  if Pos(':DATA',selScript.SQL.Text) > 0 then
    selScript.DeclareVariable('DATA',otDate);
  if Pos(':ID',selScript.SQL.Text) > 0 then
    selScript.DeclareVariable('ID',otInteger);
  if Pos(':RESULT',selScript.SQL.Text) > 0 then
    selScript.DeclareVariable('RESULT',otString);
end;

function TA159FArchiviazioneCartelliniMW.EseguiScriptValidazione(Progressivo: Integer; Data: TDateTime): Boolean;
var StatoVar: Variant;
begin
  if selI210.FieldByName('SCRIPT_VALIDAZIONE').AsString <> '' then
  begin
    selScript.SQL.Text:=selI210.FieldByName('SCRIPT_VALIDAZIONE').AsString;
    DichiaraVariabiliScript;

    selScript.SetVariable('PROGRESSIVO', Progressivo);
    selScript.SetVariable('DATA', Data);
    selScript.Execute;

    StatoVar:=selScript.GetVariable('RESULT');

    if VarIsNull(StatoVar) then
      Result:=False
    else
      Result:=StatoVar = 'S';
  end
  else
    raise Exception.Create('Script di verifica della validazione non valorizzato');
end;

function TA159FArchiviazioneCartelliniMW.EseguiScriptNote(Progressivo: Integer; Data: TDateTime): String;
var NoteVar: Variant;
begin
  if selI210.FieldByName('SCRIPT_NOTE').AsString <> '' then
  begin
    Result:='';
    selScript.SQL.Text:=selI210.FieldByName('SCRIPT_NOTE').AsString;
    DichiaraVariabiliScript;

    selScript.SetVariable('PROGRESSIVO', Progressivo);
    selScript.SetVariable('DATA', Data);
    selScript.Execute;

    NoteVar:=selScript.GetVariable('RESULT');

    if VarIsNull(NoteVar) then
      Result:=''
    else
      Result:=NoteVar;
  end
  else
    raise Exception.Create('Script per l''estrazione delle note non valorizzato');
end;

function TA159FArchiviazioneCartelliniMW.EseguiScriptArchiviazione(Progressivo, IdDocumento: Integer; Data: TDateTime): TResCtrl;
var error: Variant;
begin
  if selI210.FieldByName('SCRIPT_ARCHIVIAZIONE').AsString <> '' then
  begin
    Result.Clear;
    selScript.SQL.Text:=selI210.FieldByName('SCRIPT_ARCHIVIAZIONE').AsString;
    DichiaraVariabiliScript;

    selScript.SetVariable('PROGRESSIVO', Progressivo);
    selScript.SetVariable('DATA', Data);
    selScript.SetVariable('ID', IdDocumento);
    selScript.Execute;

    error:=selScript.GetVariable('RESULT');
    if VarIsNull(error)then
      Result.Ok:=True
    else
      Result.Messaggio:=error;
  end
  else
    raise Exception.Create('Script post archiviazione non valorizzato');
end;


function TA159FArchiviazioneCartelliniMW.ValidazioneUltimoLivello(Progressivo: Integer; Data: TDateTime): Boolean;
begin
  selVT860.SetVariable('PROGRESSIVO', Progressivo);
  selVT860.SetVariable('DATA', Data);

  selVT860.Execute;

  Result:=selVT860.GetVariable('RESULT') <> 0;
end;

//----------------- GESTIONE REGISTRO DI ARCHIVIAZIONE -----------------------------------
procedure TA159FArchiviazioneCartelliniMW.SalvaEInviaRegistroSuDB;
var LFileName, LTempFilePath, LTempFileName: String;
    IdT960: Integer;
    LDoc: TDocumento;
    LResCtrl: TResCtrl;
begin
  IdT960:=0;
  //nome e percorso di salvataggio del file temporaneo
  LTempFilePath:=TPath.GetTempPath;
  LTempFileName:=TPath.Combine(LTempFilePath, TPath.GetRandomFileName);
  LFileName:='registro_' + FormatDateTime('yyyymmdd_hhnnss', A210MW.GetDataCreazioneRegistro) + '.txt';

  if A210MW.SalvaRegistroSuFile(LTempFileName) then
  begin
    try
      //inserimento su T960 eventualmente con versione
      LDoc:=TDocumento.Create;
      try
        LDoc.Id:=0;
        LDoc.DataCreazione:=Now;
        LDoc.NomeUtente:='';
        LDoc.Utente:=Parametri.Operatore;
        LDoc.Progressivo:=0;
        LDoc.Tipologia:=selI210.FieldByName('TIPOLOGIA_DOCUMENTI').AsString;
        LDoc.Ufficio:='*';
        LDoc.NomeFile:=TPath.GetFileNameWithoutExtension(LFileName);
        LDoc.ExtFile:=TPath.GetExtension(LFileName);
        LDoc.TempFile:=LTempFileName;
        LDoc.PeriodoDal:=PeriodoDal;
        LDoc.PeriodoAl:=PeriodoAl;
        LDoc.Dimensione:=R180GetFileSize(LTempFileName);
        LDoc.CFFamiliare:='';
        LDoc.Note:='';
        LDoc.Provenienza:='I';
        LDoc.PathStorage:=DOC_STORAGE_DB;

        LResCtrl:=C021DM.Save(LDoc, Sovrascrivi, Versionabile, False, IdT960);
        if not LResCtrl.Ok then
        begin
          InfoMsg:=Format('Errore nel salvataggio del registro di archiviazione su gestione documentale: %s', [LResCtrl.Messaggio]);
          RegistraMsg.InserisciMessaggio('A', InfoMsg,Parametri.Azienda, Parametri.ProgressivoOper);
        end;
      finally
        FreeAndNil(LDoc);
      end;

      //se è richiesto l'invio del registro salvato
      if InviareRegistro and (selI210.FieldByName('CAMPI_XML').AsString.Trim <> '') and (IdT960 <> 0) then
        A210MW.InviaRegistro(LTempFileName, IdT960);
    finally
      if TFile.Exists(LTempFileName) then
        TFile.Delete(LTempFileName);
    end;
  end;
end;

procedure TA159FArchiviazioneCartelliniMW.InviaRegistroSalvato;
var FullPath, ErrMsg: String;
begin
  RegistraMsg.IniziaMessaggio('A159');
  try
    FullPath:=DownloadRegistroDaDB; //scarica il registro e lo salva su un file temporaneo
    try
      A210MW.InviaRegistro(FullPath, selT960Registro.FieldByName('ID').AsInteger);
    finally
      TFile.Delete(FullPath);
    end;
  except
    on E: Exception do
    begin
      ErrMsg:='Errore durante l''invio del registro di archiviazione';
      RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg, E.Message, E.ClassName]));
    end;
  end;
end;

function TA159FArchiviazioneCartelliniMW.DownloadRegistroDaDB: String;
var BlobStream: TStream;
    FileStream: TFileStream;
begin
  Result:=TPath.Combine(TPath.GetTempPath, TPath.GetRandomFileName); //percorso + nome file temporaneo per il salvataggio

  BlobStream:=nil;
  FileStream:=TFileStream.Create(Result, fmCreate);
  try
    BlobStream:=selT960Registro.CreateBlobStream(selT960Registro.FieldByName('DOCUMENTO'), bmRead);
    FileStream.CopyFrom(BlobStream, BlobStream.Size);
  finally
    FreeAndNil(BlobStream);
    FreeAndNil(FileStream);
  end;
end;

{ TParametriAziendali }

function TParametriAziendali.ToString: String;
begin
  Result:=Format('Path pdf = [%s] | File pdf = [%s]',[PathPdf,FilePdf]);
end;

initialization
  // critical section per stampa cartellino
  CSStampa:=TMedpCriticalSection.Create;
  CSStampaCartellino:=TMedpCriticalSection.Create;

finalization
  // distruzione critical section
  FreeAndNil(CSStampa);
  FreeAndNil(CSStampaCartellino);

end.
