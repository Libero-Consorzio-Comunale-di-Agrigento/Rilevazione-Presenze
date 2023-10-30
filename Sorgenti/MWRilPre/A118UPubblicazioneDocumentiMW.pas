unit A118UPubblicazioneDocumentiMW;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  C180FunzioniGenerali,
  FunzioniGenerali,
  R005UDataModuleMW,
  StrUtils, IOUtils, Math, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Oracle, DB, OracleData, Datasnap.DBClient;

type

  // tipologie di confronto sui livelli e campi
  TTipoTest = (
    // test sul dominio delle variabili predefinite
    Formale,
    // effettua test Formale + verifica che le variabili che identificano il dipendente siano valorizzate con i dati del dipendente corrente
    Dipendente
  );

  TVariabile = record
    // nome variabile
    Nome: String;
    // tipo variabile (nel dataset per valutazione filtro)
    Tipo: Integer;
    // tipo campo (utilizzato nella costruzione del clientdataset)
    TipoCampo: TFieldType;
    // indica se la variabile è riferita ad un valore data
    RifData: Boolean;
    // indica se la variabile identifica un valore anagrafico
    RifAnag: Boolean;
    // valore della variabile da utilizzare nelle valutazioni
    // (nelle sue declinazioni in base al "Tipo")
    ValoreStr: String;
    ValoreInt: Integer;
    ValoreDate: TDateTime;
  end;

  TVariabiliAnagrafiche = record
    NomeUtente: String;
    Matricola: String;
    CodFiscale: String;
    Progressivo: Integer;
    procedure Clear;
  end;

  TA118FPubblicazioneDocumentiMW = class;

  TCampo = class
  private
    // puntatore al middleware contenitore
    FMyA118MW: TA118FPubblicazioneDocumentiMW;
    // dati del campo
    FCampo: String;
    FVariabile: Boolean;
    FDal: Integer;
    FLung: Integer;
    FExt: String;
    FVisibile: String;
    FRifData: Boolean;
    FRifAnag: Boolean;
    FTipoVariabile: Integer;
    FTipoCampo: TFieldType;
    FSizeCampo: Integer;
    FValore: String;
    FValoreInt: Integer;
    FValoreDate: TDateTime;
    procedure SetCampo(const Value: String);
    function GetTipoVariabileStr: String; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
  public
    constructor Create(PMyA118MW: TA118FPubblicazioneDocumentiMW);
    function MatchTipoVariabile: Boolean;
    function MatchTipoField: Boolean;
    function Match(const PTipoTest: TTipoTest): TResCtrl;
    property Campo: String read FCampo write SetCampo;
    property Variabile: Boolean read FVariabile;
    property Dal: Integer read FDal write FDal;
    property Lung: Integer read FLung write FLung;
    property Ext: String read FExt write FExt;
    property Visibile: String read FVisibile write FVisibile;
    property RifData: Boolean read FRifData;
    property RifAnag: Boolean read FRifAnag;
    property Valore: String read FValore write FValore;
    property TipoVariabile: Integer read FTipoVariabile;
    property TipoVariabileStr: String read GetTipoVariabileStr;
    property TipoCampo: TFieldType read FTipoCampo;
    property SizeCampo: Integer read FSizeCampo;
  end;

  TLivello = class
  private
    // puntatore al middleware contenitore
    FMyA118MW: TA118FPubblicazioneDocumentiMW;
    // dati della struttura
    FLivello: Integer;
    FNomeI201: String;
    FSeparatoreI201: String;
    FFiltroI201: String;
    FExtI201: String;
    FCampoArr: array of TCampo;
    FselFiltro: TOracleQuery;
    // dati del file
    FPathFile: String;
    FNomeFile: String;
    FExtFile: String;
    procedure SetNomeFile(const Value: String);
  public
    constructor Create(PMyA118MW: TA118FPubblicazioneDocumentiMW);
    destructor Destroy; override;
    procedure AddStrutturaCampo(const PCampo: String; const PDal, PLung: Integer; const PVisibile, PExt: String);
    function  GetCampo(const PCampo: String): TCampo;
    function  MatchNome(const PTipoTest: TTipoTest): TResCtrl;
    function  MatchFiltro(const PTipoTest: TTipoTest): TResCtrl;
    function GetNomeFileCompleto: String;
    function ToString: String; override;
    property Livello: Integer read FLivello;
    property ExtI201: String read FExtI201;
    property FiltroI201: String read FFiltroI201;
    property PathFile: String read FPathFile write FPathFile;
    property NomeFile: String read FNomeFile write SetNomeFile;
    property ExtFile: String read FExtFile;
  end;

  TVariabiliArr = array[0..8] of TVariabile;

  TA118FPubblicazioneDocumentiMW = class(TR005FDataModuleMW)
    selFiltro: TOracleQuery;
    selI200: TOracleDataSet;
    selI201: TOracleDataSet;
    selI202: TOracleDataSet;
    cdsI200Sorgente: TClientDataSet;
    cdsI200SorgenteCODICE: TStringField;
    cdsI200SorgenteDESCRIZIONE: TStringField;
    dsrI200Sorgente: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    // codice tipologia documento
    FCodice: String;
    // directory radice per i documenti di questa tipologia
    FRootDir: String;
    // struttura dati per livelli di directory / file
    FLivArr: array of TLivello;
    // livello della directory più profonda
    FLivMaxDir: Integer;
    // livello dei file (verranno considerati i livelli >= di questo nella ricerca)
    FLivFile: Integer;
    function GetCodice: String;
    procedure SetCodice(const Value: String);
    function GetRootDir: String;
    procedure SetRootDir(const Value: String);
    function  GetLivello(const PLiv: Integer): TLivello;
    procedure SetVariabiliAnagrafiche(const Value: TVariabiliAnagrafiche);
    function GetVariabiliAnagrafiche: TVariabiliAnagrafiche;
  public
    // variabili con i dati da verificare
    Variabili: TVariabiliArr;
    function  CheckFiltroDocumenti(const PFiltro: String): TResCtrl;
    procedure Clear;
    function  AddLivello(const PLiv: Integer; const PNome, PExt, PSeparatore, PFiltro: String): TLivello;
    function  GetValoreCampo(const PCampo: String; const PLiv: Integer; const PMatchTipoField: Boolean = True): String;
    procedure ImpostaVariabiliAnagraficheDaUtente;
    procedure ImpostaVariabiliDaFileCorrente;
    property Codice: String read GetCodice write SetCodice;
    property RootDir: String read GetRootDir write SetRootDir;
    property LivMaxDir: Integer read FLivMaxDir write FLivMaxDir;
    property LivFile: Integer read FLivFile write FLivFile;
    property Livello[const PLiv:Integer]: TLivello read GetLivello;
    property VariabiliAnagrafiche: TVariabiliAnagrafiche read GetVariabiliAnagrafiche;
  end;

const
  // tipo sorgente documento
  SORGENTE_FS_EXT        = 'FS_EXT';
  SORGENTE_T960          = 'T960';
  SORGENTE_WS_ENGI_CU    = 'WS_ENGI_CU';
  SORGENTE_WS_ENGI_CEDOL = 'WS_ENGI_CEDOL';

  ROOT_DIR_DEFAULT       = 'Archivi\usr_files\';
  FILLER_POSIZIONALE     = '_';
  ESTENSIONE_QUALSIASI   = '*';

  // variabili speciali
  PREFISSO_VAR: String   = ':';
  VAR_FILLER             = 'FILLER';
  VAR_ANNO               = 'ANNO';
  VAR_MESE               = 'MESE';
  VAR_GIORNO             = 'GIORNO';
  VAR_DATA               = 'DATA';
  VAR_PROGRESSIVO        = 'PROGRESSIVO';
  VAR_MATRICOLA          = 'MATRICOLA';
  VAR_NOME_UTENTE        = 'NOME_UTENTE';
  VAR_CODFISCALE         = 'CODFISCALE';

  // vincoli sui domini delle variabili
  LUNGHEZZA_CODFISCALE = 16;

  SEPARATORI_TOKEN = ',;()=<>|!/+-*';

implementation

{$R *.dfm}

procedure TA118FPubblicazioneDocumentiMW.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;

  // inizializzazioni
  FCodice:='';
  FRootDir:='';
  SetLength(FLivArr,0);
  FLivMaxDir:=-1;
  FLivFile:=-1;

  // variabili
  i:=0;
  Variabili[i].Nome:=VAR_FILLER;
  Variabili[i].Tipo:=otString;
  Variabili[i].TipoCampo:=ftString;
  Variabili[i].RifData:=False;
  Variabili[i].RifAnag:=False;
  Variabili[i].ValoreStr:='';
  Variabili[i].ValoreInt:=0;
  Variabili[i].ValoreDate:=0;
  inc(i);

  Variabili[i].Nome:=VAR_ANNO;
  Variabili[i].Tipo:=otInteger;
  Variabili[i].TipoCampo:=ftInteger;
  Variabili[i].RifData:=True;
  Variabili[i].RifAnag:=False;
  Variabili[i].ValoreStr:='';
  Variabili[i].ValoreInt:=0;
  Variabili[i].ValoreDate:=0;
  inc(i);

  Variabili[i].Nome:=VAR_MESE;
  Variabili[i].Tipo:=otInteger;
  Variabili[i].TipoCampo:=ftString;
  Variabili[i].RifData:=True;
  Variabili[i].RifAnag:=False;
  Variabili[i].ValoreStr:='';
  Variabili[i].ValoreInt:=0;
  Variabili[i].ValoreDate:=0;
  inc(i);

  Variabili[i].Nome:=VAR_GIORNO;
  Variabili[i].Tipo:=otInteger;
  Variabili[i].TipoCampo:=ftInteger;
  Variabili[i].RifData:=True;
  Variabili[i].RifAnag:=False;
  Variabili[i].ValoreStr:='';
  Variabili[i].ValoreInt:=0;
  Variabili[i].ValoreDate:=0;
  inc(i);

  Variabili[i].Nome:=VAR_DATA;
  Variabili[i].Tipo:=otString;
  Variabili[i].TipoCampo:=ftDateTime;
  Variabili[i].RifData:=True;
  Variabili[i].RifAnag:=False;
  Variabili[i].ValoreStr:='';
  Variabili[i].ValoreInt:=0;
  Variabili[i].ValoreDate:=0;
  inc(i);

  Variabili[i].Nome:=VAR_PROGRESSIVO;
  Variabili[i].Tipo:=otInteger;
  Variabili[i].TipoCampo:=ftInteger;
  Variabili[i].RifData:=False;
  Variabili[i].RifAnag:=True;
  Variabili[i].ValoreStr:='';
  Variabili[i].ValoreInt:=0;
  Variabili[i].ValoreDate:=0;
  inc(i);

  Variabili[i].Nome:=VAR_MATRICOLA;
  Variabili[i].Tipo:=otString;
  Variabili[i].TipoCampo:=ftString;
  Variabili[i].RifData:=False;
  Variabili[i].RifAnag:=True;
  Variabili[i].ValoreStr:='';
  Variabili[i].ValoreInt:=0;
  Variabili[i].ValoreDate:=0;
  inc(i);

  Variabili[i].Nome:=VAR_CODFISCALE;
  Variabili[i].Tipo:=otString;
  Variabili[i].TipoCampo:=ftString;
  Variabili[i].RifData:=False;
  Variabili[i].RifAnag:=True;
  Variabili[i].ValoreStr:='';
  Variabili[i].ValoreInt:=0;
  Variabili[i].ValoreDate:=0;
  inc(i);

  Variabili[i].Nome:=VAR_NOME_UTENTE;
  Variabili[i].Tipo:=otString;
  Variabili[i].TipoCampo:=ftString;
  Variabili[i].RifData:=False;
  Variabili[i].RifAnag:=True;
  Variabili[i].ValoreStr:='';
  Variabili[i].ValoreInt:=0;
  Variabili[i].ValoreDate:=0;

  // carica il clientdataset con le decodifiche della sorgente documento
  cdsI200Sorgente.DisableControls;
  cdsI200Sorgente.Append;
  cdsI200Sorgente.FieldByName('CODICE').AsString:=SORGENTE_FS_EXT;
  cdsI200Sorgente.FieldByName('DESCRIZIONE').AsString:='Cartella esterna';
  cdsI200Sorgente.Post;
  cdsI200Sorgente.Append;
  cdsI200Sorgente.FieldByName('CODICE').AsString:=SORGENTE_T960;
  cdsI200Sorgente.FieldByName('DESCRIZIONE').AsString:='Gestione Documentale';
  cdsI200Sorgente.Post;
  cdsI200Sorgente.Append;
  cdsI200Sorgente.FieldByName('CODICE').AsString:=SORGENTE_WS_ENGI_CU;
  cdsI200Sorgente.FieldByName('DESCRIZIONE').AsString:='CU Engi';
  cdsI200Sorgente.Post;
  cdsI200Sorgente.Append;
  cdsI200Sorgente.FieldByName('CODICE').AsString:=SORGENTE_WS_ENGI_CEDOL;
  cdsI200Sorgente.FieldByName('DESCRIZIONE').AsString:='Cedolini Engi';
  cdsI200Sorgente.Post;
  cdsI200Sorgente.EnableControls;

  // apertura dataset
  selI200.Close;
  selI200.Open;
end;

procedure TA118FPubblicazioneDocumentiMW.DataModuleDestroy(Sender: TObject);
begin
  Clear;
  inherited;
end;

function TA118FPubblicazioneDocumentiMW.GetVariabiliAnagrafiche: TVariabiliAnagrafiche;
// restituisce i valori delle variabili di tipo anagrafico in una struttura dati
var
  i: Integer;
  LVarNome: String;
begin
  Result.Clear;

  for i:=Low(VARIABILI) to High(VARIABILI) do
  begin
    if not VARIABILI[i].RifAnag then
      Continue;

    LVarNome:=VARIABILI[i].Nome;

    // estrae il valore della corrispondente variabile anagrafica
    if LVarNome = VAR_PROGRESSIVO then
      Result.Progressivo:=VARIABILI[i].ValoreInt
    else if LVarNome = VAR_MATRICOLA then
      Result.Matricola:=VARIABILI[i].ValoreStr
    else if LVarNome = VAR_CODFISCALE then
      Result.CodFiscale:=VARIABILI[i].ValoreStr
    else if LVarNome = VAR_NOME_UTENTE then
      Result.NomeUtente:=VARIABILI[i].ValoreStr;
  end;
end;

procedure TA118FPubblicazioneDocumentiMW.SetVariabiliAnagrafiche(const Value: TVariabiliAnagrafiche);
// imposta i valori delle variabili di tipo anagrafico nella corrispondente struttura dati
var
  i: Integer;
  LVarNome: String;
begin
  for i:=Low(VARIABILI) to High(VARIABILI) do
  begin
    if not VARIABILI[i].RifAnag then
      Continue;

    LVarNome:=VARIABILI[i].Nome;

    // imposta il valore della corrispondente variabile anagrafica
    if LVarNome = VAR_PROGRESSIVO then
      VARIABILI[i].ValoreInt:=Value.Progressivo
    else if LVarNome = VAR_MATRICOLA then
      VARIABILI[i].ValoreStr:=Value.Matricola
    else if LVarNome = VAR_CODFISCALE then
      VARIABILI[i].ValoreStr:=Value.CodFiscale
    else if LVarNome = VAR_NOME_UTENTE then
      VARIABILI[i].ValoreStr:=Value.NomeUtente;
  end;
end;

function TA118FPubblicazioneDocumentiMW.CheckFiltroDocumenti(const PFiltro: String): TResCtrl;
// valuta il filtro di visualizzazione del tipo documento
// IMPORTANTE
//   il filtro può contenere *esclusivamente* variabili anagrafiche
// restituisce
//   True se il filtro è verificato
//   False se il filtro non è verificato o contiene errori / variabili illecite
var
  LFiltroSrc: String;
  LVar: TVariabile;
  LNomeVar: String;
  i: Integer;
begin
  Result.Ok:=PFiltro = '';
  Result.Messaggio:='';

  // se il filtro è indicato lo valuta
  if not Result.Ok then
  begin
    try
      selFiltro.ClearVariables;
      selFiltro.DeleteVariables;
      selFiltro.SQL.Text:=Format('select count(*) from dual where %s',[PFiltro]);

      LFiltroSrc:=PFiltro.ToUpper;

      // ricerca le variabili di tipo anagrafico e le aggiunge all'oraclequery
      for i:=Low(VARIABILI) to High(VARIABILI) do
      begin
        LVar:=VARIABILI[i];
        if not LVar.RifAnag then
          Continue;

        LNomeVar:=LVar.Nome;
        if R180CercaParolaIntera(PREFISSO_VAR + LNomeVar,LFiltroSrc,SEPARATORI_TOKEN) > 0 then
        begin
          selFiltro.DeclareVariable(LNomeVar,LVar.Tipo);
          case LVar.Tipo of
            otDate:
              selFiltro.SetVariable(LNomeVar,LVar.ValoreDate);
            otInteger:
              selFiltro.SetVariable(LNomeVar,LVar.ValoreInt);
            otString:
              selFiltro.SetVariable(LNomeVar,LVar.ValoreStr);
          else
            begin
              Result.Messaggio:=Format('il tipo di variabile non è previsto: %d',[LVar.Tipo]);
              Exit;
            end;
          end;
          LFiltroSrc:=StringReplace(LFiltroSrc,PREFISSO_VAR + LNomeVar,'',[rfReplaceAll,rfIgnoreCase]);
        end;
      end;

      // se sono presenti altre variabili segnala errore
      if Pos(PREFISSO_VAR,LFiltroSrc) > 0 then
      begin
        Result.Messaggio:='è stata utilizzata una variabile non prevista.';
        Exit;
      end;

      // valuta il filtro
      selFiltro.Execute;
      Result.Ok:=selFiltro.FieldAsInteger(0) > 0;
    except
      on E: Exception do
      begin
        Result.Messaggio:=E.Message;
        Exit;
      end;
    end;
  end;
end;

procedure TA118FPubblicazioneDocumentiMW.Clear;
// pulisce la struttura dati dei livelli
var
  i: Integer;
begin
  for i:=Low(FLivArr) to High(FLivArr) do
  begin
    if FLivArr[i].FselFiltro <> nil then
      FreeAndNil(FLivArr[i].FselFiltro);
    FreeAndNil(FLivArr[i]);
  end;
  SetLength(FLivArr,0);
end;

function TA118FPubblicazioneDocumentiMW.GetCodice: String;
begin
  Result:=FCodice;
end;

procedure TA118FPubblicazioneDocumentiMW.SetCodice(const Value: String);
var
  LLiv: Integer;
  LIsLivelloFile: Boolean;
  LExt: String;
  LLivObj: TLivello;
begin
  // carica la struttura dati per la tipologia indicata
  if not selI200.SearchRecord('CODICE',Value,[srFromBeginning]) then
    raise Exception.Create('La tipologia selezionata è inesistente!');

  FCodice:=Value;

  // imposta la directory base (se non indicata utilizza la directory predefinita)
  SetRootDir(selI200.FieldByName('ROOT').AsString);

  // distrugge la struttura preesistente
  Clear;

  // apre il dataset delle informazioni di dettaglio sui campi
  selI202.Close;
  selI202.Filtered:=False;
  selI202.SetVariable('CODICE',Value);
  selI202.Open;

  // ciclo sui livelli della struttura
  selI201.Close;
  selI201.SetVariable('CODICE',FCodice);
  selI201.Open;
  while not selI201.Eof do
  begin
    // aggiunge il livello alla struttura dati
    LLiv:=selI201.FieldByName('LIVELLO').AsInteger;
    LIsLivelloFile:=not selI201.FieldByName('EXT').IsNull;
    LLivObj:=AddLivello(LLiv,
                        selI201.FieldByName('NOME').AsString,
                        selI201.FieldByName('EXT').AsString,
                        selI201.FieldByName('SEPARATORE').AsString,
                        selI201.FieldByName('FILTRO').AsString);

    // filtra la struttura dei campi sul livello attuale
    selI202.Filtered:=False;
    selI202.Filter:=Format('LIVELLO = %d',[LLiv]);
    selI202.Filtered:=True;

    // ciclo per impostare la struttura dei campi sul livello
    selI202.First;
    while not selI202.Eof do
    begin
      LExt:=IfThen(LIsLivelloFile,LLivObj.FExtI201,'');
      LLivObj.AddStrutturaCampo(selI202.FieldByName('CAMPO').AsString,
                                selI202.FieldByName('DAL').AsInteger,
                                selI202.FieldByName('LUNG').AsInteger,
                                selI202.FieldByName('VISIBILE').AsString,
                                LExt);
      selI202.Next;
    end;

    // salva il livello massimo delle directory e il livello dei file
    if LIsLivelloFile then
      FLivFile:=LLiv
    else if LLiv > FLivMaxDir then
      FLivMaxDir:=LLiv;

    // livello successivo
    selI201.Next;
  end;
end;

function TA118FPubblicazioneDocumentiMW.GetRootDir: String;
begin
  Result:=FRootDir;
end;

procedure TA118FPubblicazioneDocumentiMW.SetRootDir(const Value: String);
// imposta la directory radice
//   se non indicata utilizza la ROOT_DIR_DEFAULT all'interno
//   della cartella base di installazione dell'applicativo di riferimento
begin
  if Value.Trim = '' then
    FRootDir:=TPath.Combine(TFunzioniGenerali.GetInstallationPath,ROOT_DIR_DEFAULT)
  else
    FRootDir:=Value;
end;

function TA118FPubblicazioneDocumentiMW.AddLivello(const PLiv: Integer;
  const PNome, PExt, PSeparatore, PFiltro: String): TLivello;
// aggiunge alla struttura i dati del livello PLiv
var
  i: Integer;
begin
  i:=Length(FLivArr);
  SetLength(FLivArr,i + 1);

  // crea un nuovo livello e ne imposta le proprietà
  FLivArr[i]:=TLivello.Create(Self);
  FLivArr[i].FLivello:=PLiv;
  FLivArr[i].FNomeI201:=PNome;
  FLivArr[i].FExtI201:=PExt;
  FLivArr[i].FSeparatoreI201:=PSeparatore;
  FLivArr[i].FFiltroI201:=PFiltro;

  // crea oracle query per valutare il filtro dinamicamente
  if PFiltro <> '' then
  begin
    FLivArr[i].FselFiltro:=TOracleQuery.Create(nil);
    FLivArr[i].FselFiltro.Session:=SessioneOracle;
    FLivArr[i].FselFiltro.ReadBuffer:=2;
    FLivArr[i].FselFiltro.SQL.Text:=Format('select count(*) TOT from DUAL where %s',[PFiltro]);
  end;

  Result:=FLivArr[i];
end;

function TA118FPubblicazioneDocumentiMW.GetLivello(const PLiv: Integer): TLivello;
begin
  if (PLiv < Low(FLivArr)) or (PLiv > High(FLivArr)) then
    raise Exception.Create(Format('Livello di directory %d non presente nella struttura',[PLiv]));
  Result:=FLivArr[PLiv];
end;

function TA118FPubblicazioneDocumentiMW.GetValoreCampo(const PCampo: String;
  const PLiv: Integer; const PMatchTipoField: Boolean = True): String;
// estrae il valore del campo indicato (cercandolo a ritroso dal livello PLiv eventualmente fino al livello 0)
// se PMatchTipoField = True
//   risale la struttura fino a dare un valore coerente con il tipo
//   (serve per il campo Mese, che può essere numerico oppure string)
var
  LLiv: Integer;
  LCampo: TCampo;
begin
  Result:='';

  // risale i livelli per cercare il valore del campo richiesto
  for LLiv:=PLiv downto Low(FLivArr) do
  begin
    LCampo:=GetLivello(LLiv).GetCampo(PCampo);
    if LCampo <> nil then
    begin
      if (not PMatchTipoField) or (LCampo.MatchTipoField) then
      begin
        Result:=LCampo.FValore;
        Break;
      end;
    end;
  end;
end;

procedure TA118FPubblicazioneDocumentiMW.ImpostaVariabiliAnagraficheDaUtente;
// imposta i parametri da utilizzare per la sostituzione delle variabili nei filtri struttura / livello
var
  LVarAnag: TVariabiliAnagrafiche;
begin
  LVarAnag.Clear;

  {$IFDEF IRISWEB}
  // su irisweb può ridefinire le variabili anagrafiche con il dipendente selezionato
  // nella selezione anagrafica principale
  if (DebugHook <> 0) or R180In(Parametri.Operatore,['SYSMAN','MONDOEDP']) then
  begin
    // imposta le variabili anagrafiche in base al dipendente attualmente selezionato
    LVarAnag.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    LVarAnag.Matricola:=WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString;
    if WR000DM.cdsAnagrafe.FindField('CODFISCALE') <> nil then
      LVarAnag.CodFiscale:=WR000DM.cdsAnagrafe.FieldByName('CODFISCALE').AsString;
    if R180In(Parametri.Operatore,['SYSMAN','MONDOEDP']) then
      LVarAnag.NomeUtente:='' // informazione non disponibile
    else
      LVarAnag.NomeUtente:=Parametri.Operatore;
  end
  else
  {$ENDIF IRISWEB}
  begin
    LVarAnag.Progressivo:=Parametri.ProgressivoOper;
    LVarAnag.Matricola:=Parametri.MatricolaOper;
    LVarAnag.CodFiscale:=Parametri.CodFiscaleOper;
    LVarAnag.NomeUtente:=Parametri.Operatore;
  end;

  // imposta i dati anagrafici dell'utente collegato nei valori delle variabili anagrafiche
  SetVariabiliAnagrafiche(LVarAnag);
end;

procedure TA118FPubblicazioneDocumentiMW.ImpostaVariabiliDaFileCorrente;
// riconosce i valori delle variabili a partire dal livello file
// (cercando a ritroso eventualmente fino al livello 0)
var
  LLiv: Integer;
  LCampo: TCampo;
  i: Integer;
  LNomeVar: String;
  LTipoVar: Integer;
  LValoreInt: Integer;
  LValoreDate: TDateTime;
begin
  for i:=Low(VARIABILI) to High(VARIABILI) do
  begin
    LNomeVar:=VARIABILI[i].Nome;
    LTipoVar:=VARIABILI[i].Tipo;

    for LLiv:=FLivFile downto Low(FLivArr) do
    begin
      // estrae la struttura dati del campo corrispondente alla variabile
      LCampo:=GetLivello(LLiv).GetCampo(LNomeVar);
      if Assigned(LCampo) then
      begin
        // imposta il valore del campo
        case LTipoVar of
          otDate:
            begin
              if TryStrToDate(LCampo.FValore,LValoreDate) then
                VARIABILI[i].ValoreDate:=LValoreDate;
            end;
          otInteger:
            begin
              if TryStrToInt(LCampo.FValore,LValoreInt) then
                VARIABILI[i].ValoreInt:=LValoreInt
              else if (LNomeVar = VAR_MESE) then
              begin
                // il campo mese può essere valorizzato anche in lettere,
                // pertanto prova a determinare il mese numerico
                LValoreInt:=TFunzioniGenerali.NumeroMese(LCampo.FValore);
                if LValoreInt > -1 then
                  VARIABILI[i].ValoreInt:=LValoreInt;
              end;
            end;
          otString:
            VARIABILI[i].ValoreStr:=LCampo.FValore;
        end;
        Break;
      end;
    end;
  end;
end;

{ TLivello }

constructor TLivello.Create(PMyA118MW: TA118FPubblicazioneDocumentiMW);
begin
  inherited Create;
  FMyA118MW:=PMyA118MW;
  SetLength(FCampoArr,0);
end;

destructor TLivello.Destroy;
var
  i: Integer;
begin
  if Assigned(FselFiltro) then
    FreeAndNil(FselFiltro);

  for i:=Low(FCampoArr) to High(FCampoArr) do
    FreeAndNil(FCampoArr[i]);
  SetLength(FCampoArr,0);

  inherited;
end;

function TLivello.ToString: String;
begin
  Result:=Format('Livello %d, nome file: %s',[FLivello,GetNomeFileCompleto]);
end;

function TLivello.GetNomeFileCompleto: String;
begin
  Result:=TPath.Combine(FPathFile,Format('%s.%s',[FNomeFile,FExtFile]));
end;

procedure TLivello.AddStrutturaCampo(const PCampo: String; const PDal,PLung: Integer; const PVisibile, PExt: String);
// aggiunge la descrizione del campo alla struttura dati
var
  i: Integer;
begin
  i:=Length(FCampoArr);
  SetLength(FCampoArr,i + 1);

  // crea un nuovo oggetto con i dati del campo
  FCampoArr[i]:=TCampo.Create(FMyA118MW);
  FCampoArr[i].Campo:=PCampo;
  FCampoArr[i].Dal:=PDal;
  FCampoArr[i].Lung:=PLung;
  FCampoArr[i].Visibile:=PVisibile;
  FCampoArr[i].Ext:=PExt;
end;

function TLivello.GetCampo(const PCampo: String): TCampo;
// estrae il valore del campo indicato
var
  i: Integer;
begin
  Result:=nil;
  for i:=Low(FCampoArr) to High(FCampoArr) do
  begin
    if PCampo = FCampoArr[i].Campo then
    begin
      Result:=FCampoArr[i];
      Break;
    end;
  end;
end;

procedure TLivello.SetNomeFile(const Value: String);
// imposta il nome file indicato, suddividendolo in NomeFile / ExtFile
// valorizza i singoli campi della struttura con i relativi valori
var
  i: Integer;
  LLimite: Integer;
  LLstNomeFile: TStringList;
  LNomePosizionale: Boolean;
begin
  FNomeFile:=Value;

  // se si tratta del livello file (ovvero se è definita l'estensione)
  // divide il nome file nelle due componenti (nome privo di estensione + estensione)
  // per i successivi confronti
  if FExtI201 <> '' then
  begin
    FExtFile:=TPath.GetExtension(FNomeFile).Substring(1); // rimuove il punto
    FNomeFile:=TPath.GetFileNameWithoutExtension(FNomeFile);
  end;

  LNomePosizionale:=(FSeparatoreI201 = '') and (Length(FCampoArr) > 1);
  if LNomePosizionale then
  begin
    // divide il nome del file / directory in parti in base a posizione e lunghezza
    for i:=Low(FCampoArr) to High(FCampoArr) do
    begin
      FCampoArr[i].Valore:=FNomeFile.Substring(FCampoArr[i].Dal - 1,FCampoArr[i].Lung).Replace(FILLER_POSIZIONALE,'',[rfReplaceAll]);
    end;
  end
  else
  begin
    // divide il nome del file / directory in parti in base al separatore
    LLstNomeFile:=TStringList.Create;
    try
      R180Tokenize(LLstNomeFile,FNomeFile,FSeparatoreI201);
      // nome directory e struttura devono avere lo stesso numero di parti
      // se questo non avviene imposta comunque dei valori nulli per eventuali verifiche
      LLimite:=Min(LLstNomeFile.Count,Length(FCampoArr));
      for i:=Low(FCampoArr) to LLimite - 1 do
        FCampoArr[i].Valore:=LLstNomeFile[i];
      for i:=LLimite to High(FCampoArr) do
        FCampoArr[i].Valore:='';
    finally
      FreeAndNil(LLstNomeFile);
    end;
  end;
end;

function TLivello.MatchNome(const PTipoTest: TTipoTest): TResCtrl;
// verifica che il nome del file / directory rispetti la struttura definita per il livello corrente
// il confronto sui campi che compongono il nome avviene in questo modo:
// per i campi variabili:
//   - verifica che il tipo sia coerente
//   - per le variabili predefinite verifica il dominio (es. ANNO, MESE)
//   - se PTipoTest = Dipendente
//     -> verifica che le variabili anagrafiche presenti nella struttura
//        siano *tutte* uguali ai valori del dipendente considerato
// per i campi costanti::
//   - verifica che il valore sia uguale (confronto case-insensitive)
var
  i: Integer;
  LCampo: TCampo;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // controlla la struttura del nome file (verificando i campi da cui è composto)
  for i:=Low(FCampoArr) to High(FCampoArr) do
  begin
    LCampo:=FCampoArr[i];
    Result:=LCampo.Match(PTipoTest);
    if not Result.Ok then
      Break;
  end;

  // se per il livello è definita l'estensione (e quindi si tratta del livello file),
  // ne effettua il controllo
  if Result.Ok then
  begin
    if FExtI201 <> '' then
    begin
      Result.Ok:=(FExtI201 = ESTENSIONE_QUALSIASI) or
                 (FExtI201.ToUpper = FExtFile.ToUpper);
      if not Result.Ok then
      begin
        Result.Messaggio:=Format('estensione file non corretta: "%s"',[FExtFile]);
        Exit;
      end;
    end;
  end;
end;

function TLivello.MatchFiltro(const PTipoTest: TTipoTest): TResCtrl;
// verifica che il filtro indicato per il livello sia corretto
// il filtro è un'espressione sql-like valutata come "select [filtro] from dual"
// - se PTipoTest = Formale
//   verifica che il filtro sia sintatticamente valido (sia cioè eseguito senza errori)
// - se PTipoTest = Dipendente
//   valuta il filtro sostituendo le variabili anagrafiche e verifica che restituisca un conteggio di almeno un record
var
  i:Integer;
  LFiltroSrc: String;
  LVar: TVariabile;
  LNomeVar: String;
  LValoreVar: Variant;
begin
  Result.Ok:=(FFiltroI201 = '');
  Result.Messaggio:='';

  // se il filtro è vuoto allora è ok
  if Result.Ok then
    Exit;

  // valuta il filtro
  try
    FselFiltro.ClearVariables;
    FselFiltro.DeleteVariables;

    // ricerca ed impostazione variabili

    // fase 1/2
    //   ricerca all'interno del filtro i campi variabili previsti nella struttura
    //   valorizza le variabili con il relativo valore mappato dal nome file
    LFiltroSrc:=FFiltroI201.ToUpper;
    for i:=Low(FCampoArr) to High(FCampoArr) do
    begin
      if not FCampoArr[i].Variabile then
        Continue;

      LNomeVar:=FCampoArr[i].Campo;
      LValoreVar:=FCampoArr[i].Valore;
      if (R180CercaParolaIntera(PREFISSO_VAR + LNomeVar,LFiltroSrc,SEPARATORI_TOKEN) > 0) then
      begin
        FselFiltro.DeclareVariable(LNomeVar,FCampoArr[i].TipoVariabile);
        FselFiltro.SetVariable(LNomeVar,LValoreVar);
      end;
    end;

    // fase 2/2
    //   ricerca variabili anagrafiche
    //   valorizza le variabili con i dati dell'utente collegato
    for i:=Low(FMyA118MW.Variabili) to High(FMyA118MW.Variabili) do
    begin
      LVar:=FMyA118MW.Variabili[i];

      if not LVar.RifAnag then
        Continue;

      LNomeVar:=LVar.Nome;
      if R180CercaParolaIntera(PREFISSO_VAR + LNomeVar,LFiltroSrc,SEPARATORI_TOKEN) > 0 then
      begin
        FselFiltro.DeclareVariable(LNomeVar,LVar.Tipo);
        case LVar.Tipo of
          otDate:
            FselFiltro.SetVariable(LNomeVar,LVar.ValoreDate);
          otInteger:
            FselFiltro.SetVariable(LNomeVar,LVar.ValoreInt);
          otString:
            FselFiltro.SetVariable(LNomeVar,LVar.ValoreStr);
        else
          raise Exception.Create('Tipo variabile non previsto!');
        end;
      end;
    end;

    // esegue il filtro via sql
    FselFiltro.Execute;

    // se il test è solo formale allora restituisce True
    // altrimenti verifica che il filtro valutato restituisca almeno un record
    if PTipoTest = TTipoTest.Formale then
      Result.Ok:=True
    else
    begin
      Result.Ok:=(FselFiltro.FieldAsInteger('TOT') > 0);
      if not Result.Ok then
        Result.Messaggio:=Format('filtro del livello %d [%s] non soddisfatto',[FLivello,FFiltroI201]);
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format('errore nel filtro del livello %d [%s]: %s',[FLivello,FFiltroI201,E.Message]);
      Exit;
    end;
  end;
end;

{ TCampo }

procedure TCampo.SetCampo(const Value: String);
var
  i: Integer;
  LVar: TVariabile;
begin
  FVariabile:=Value.StartsWith(PREFISSO_VAR);
  if FVariabile then
    FCampo:=Value.Substring(PREFISSO_VAR.Length).ToUpper
  else
    FCampo:=Value;

  // imposta valori di default
  FTipoVariabile:=otString;
  FTipoCampo:=ftString;
  FSizeCampo:=260;
  FRifData:=False;
  FRifAnag:=False;

  // imposta dati specifici per campo variabile
  if FVariabile then
  begin
    for i:=Low(FMyA118MW.Variabili) to High(FMyA118MW.Variabili) do
    begin
      LVar:=FMyA118MW.Variabili[i];
      if FCampo = LVar.Nome then
      begin
        FTipoVariabile:=LVar.Tipo;
        FTipoCampo:=LVar.TipoCampo;
        FRifData:=LVar.RifData;
        FRifAnag:=LVar.RifAnag;
        if FTipoCampo = ftString then
          FSizeCampo:=IfThen(FLung = 0,260,FLung)
        else
          FSizeCampo:=0;
        Break;
      end;
    end;
  end;
end;

function TCampo.MatchTipoVariabile: Boolean;
// restituisce True se il campo è variabile e il valore è coerente con il tipo della variabile
// restituisce False negli altri casi
begin
  /// se il dato non è variabile restituisce False
  Result:=FVariabile;

  if Result then
  begin
    // verifica che il tipo della variabile sia coerente
    case FTipoVariabile of
      otDate:
        Result:=TryStrToDate(FValore,FValoreDate);
      otInteger:
        Result:=TryStrToInt(FValore,FValoreInt);
      otString:
        Result:=True;
    else
      Result:=False;
    end;
  end;
end;

function TCampo.MatchTipoField: Boolean;
// se il campo è variabile
//   restituisce True se il valore del campo corrisponde al tipo
//   del campo definito sul dataset
//   oppure False altrimenti
// se il campo è costante
//   restituisce False sempre
var
  LValoreInt: Integer;
  LValoreDate: TDateTime;
begin
  // verifica che il tipo sia coerente con la definizione del campo del dataset
  case FTipoCampo of
    ftDateTime:
      Result:=TryStrToDateTime(FValore,LValoreDate);
    ftInteger:
      Result:=TryStrToInt(FValore,LValoreInt);
    ftString:
      Result:=True;
  else
    Result:=False;
  end;
end;

constructor TCampo.Create(PMyA118MW: TA118FPubblicazioneDocumentiMW);
begin
  inherited Create;
  FMyA118MW:=PMyA118MW;
end;

function TCampo.GetTipoVariabileStr: String;
// restituisce una stringa che indica il tipo della variabile
begin
  case FTipoVariabile of
    otDate:
      Result:='data';
    otInteger:
      Result:='intero';
    otString:
      Result:='stringa';
  else
    Result:='non definito';
  end;
end;

function TCampo.Match(const PTipoTest: TTipoTest): TResCtrl;
// determina se il valore indicato per il campo corrisponde
// a quanto definito a livello di struttura
// per i campi variabili:
//   - verifica che il tipo sia coerente
//   - per le variabili predefinite verifica il dominio (es. ANNO, MESE)
//   - se PTipoTest = Dipendente
//     -> verifica che le variabili PROGRESSIVO, MATRICOLA, CODFISCALE e NOME_UTENTE siano uguali ai valori del dipendente considerato
// per i campi costanti::
//   - verifica che il valore sia uguale (confronto case-insensitive)
var
  LMIni: Integer;
  LGIni: Integer;
  A: String;
  M: String;
  G: String;
  LOldCampo: String;
  LOldValore: String;
  i: Integer;
  function GeneraErrore(const PErrMsg: String): String;
  const
    ERR_MSG_CONST = 'costante "%s" <> "%s": %s';
    ERR_MSG_VAR   = 'variabile %s = "%s": %s';
  begin
    if FVariabile then
      Result:=Format(ERR_MSG_VAR,[FCampo,FValore,PErrMsg])
    else
      Result:=Format(ERR_MSG_CONST,[FValore,FCampo,PErrMsg]);
  end;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // campo costante
  if not FVariabile then
  begin
    // confronto case insensitive
    Result.Ok:=(FCampo.ToUpper = FValore.ToUpper);
    if not Result.Ok then
      Result.Messaggio:=GeneraErrore('il valore riconosciuto è differente');
    Exit;
  end;

  // campo variabile

  // verifica che il tipo della variabile sia coerente
  Result.Ok:=MatchTipoVariabile;

  // il campo mese è trattato in modo particolare (ammette sia valori integer che string)
  if (not Result.Ok) and (FCampo <> VAR_MESE) then
  begin
    Result.Messaggio:=GeneraErrore(Format('tipo non corrispondente a %s',[GetTipoVariabileStr]));
    Exit;
  end;

  // tipo ok: verifica il dominio
  if FCampo = VAR_ANNO then
  begin
    // anno
    //   valore intero 1900 <= x <= 3999
    Result.Ok:=R180Between(FValoreInt,Low(TAnnoInt),High(TAnnoInt));
    if not Result.Ok then
      Result.Messaggio:=GeneraErrore(Format('valore fuori dal range previsto [%d - %d]',[Low(TAnnoInt),High(TAnnoInt)]));
  end
  else if FCampo = VAR_MESE then
  begin
    // mese
    //   valore intero 1 <= x <= 12
    //   oppure
    //   valore in lettere (gennaio, febbraio, ... oppure gen, feb, ...)
    if Result.Ok then
    begin
      Result.Ok:=R180Between(FValoreInt,Low(TMeseInt),High(TMeseInt));
      if not Result.Ok then
        Result.Messaggio:=GeneraErrore(Format('valore fuori dal range previsto [%d - %d]',[Low(TMeseInt),High(TMeseInt)]));
    end
    else
    begin
      Result.Ok:=(TFunzioniGenerali.NumeroMese(FValore) > -1);
      if not Result.Ok then
        Result.Messaggio:=GeneraErrore('valore mese non riconosciuto fra quelli previsti');
    end;
  end
  else if FCampo = VAR_GIORNO then
  begin
    // giorno
    // valore intero 1 <= x <= 31 (il mese non è noto)
    Result.Ok:=R180Between(FValoreInt,Low(TGiornoInt),High(TGiornoInt));
    if not Result.Ok then
      Result.Messaggio:=GeneraErrore(Format('valore fuori dal range previsto [%d - %d]',[Low(TGiornoInt),High(TGiornoInt)]));
  end
  else if FCampo = VAR_DATA then
  begin
    // data
    // valore data in un formato predefinito: yyyymmgg oppure yyyy-mm-gg
    Result.Ok:=(FValore.Length = 10) or (FValore.Length = 8);
    if Result.Ok then
    begin
      LMIni:=IfThen(FValore.Length = 10,5,4);
      LGIni:=IfThen(FValore.Length = 10,8,6);

      // separa le informazioni di giorno, mese e anno
      A:=FValore.Substring(0,4);
      M:=FValore.Substring(LMIni,2);
      G:=FValore.Substring(LGIni,2);

      LOldCampo:=Campo;
      LOldValore:=FValore;

      // controllo anno
      Campo:=VAR_ANNO;
      FValore:=A;
      Result:=Match(PTipoTest);

      // controllo mese
      if Result.Ok then
      begin
        Campo:=VAR_MESE;
        FValore:=M;
        Result:=Match(PTipoTest);
      end;

      // controllo giorno
      if Result.Ok then
      begin
        Campo:=VAR_GIORNO;
        FValore:=G;
        Result:=Match(PTipoTest);
      end;

      Campo:=LOldCampo;
      FValore:=LOldValore;
    end;
  end
  // variabili di tipo anagrafico
  else if FCampo = VAR_PROGRESSIVO then
  begin
    // progressivo
    // controllo effettuato solo per tipo test = dipendente
    // il valore deve corrispondere al progressivo del dipendente
    if PTipoTest = TTipoTest.Dipendente then
    begin
      for i:=Low(TA118FPubblicazioneDocumentiMW(FMyA118MW).VARIABILI) to High(TA118FPubblicazioneDocumentiMW(FMyA118MW).VARIABILI) do
      begin
        if FCampo = TA118FPubblicazioneDocumentiMW(FMyA118MW).VARIABILI[i].Nome then
        begin
          Result.Ok:=(FValoreInt = TA118FPubblicazioneDocumentiMW(FMyA118MW).VARIABILI[i].ValoreInt);
          Break;
        end;
      end;
      if not Result.Ok then
        Result.Messaggio:=GeneraErrore('il progressivo non corrisponde a quello del dipendente');
    end;
  end
  else if FCampo = VAR_MATRICOLA then
  begin
    // matricola
    // controllo effettuato solo per tipo test = dipendente
    // il valore deve corrispondere alla matricola del dipendente
    if PTipoTest = TTipoTest.Dipendente then
    begin
      for i:=Low(FMyA118MW.Variabili) to High(FMyA118MW.Variabili) do
      begin
        if FCampo = FMyA118MW.Variabili[i].Nome then
        begin
          Result.Ok:=(FValore = FMyA118MW.Variabili[i].ValoreStr);
          Break;
        end;
      end;
      if not Result.Ok then
        Result.Messaggio:=GeneraErrore('la matricola non corrisponde a quella del dipendente');
    end;
  end
  else if FCampo = VAR_CODFISCALE then
  begin
    // codice fiscale
    // verifica lunghezza 16 caratteri
    Result.Ok:=(FValore.Length = LUNGHEZZA_CODFISCALE);
    if not Result.Ok then
      Result.Messaggio:=GeneraErrore(Format('valore di lunghezza errata (previsto: %d caratteri)',[LUNGHEZZA_CODFISCALE]))
    else
    begin
      // controllo effettuato solo per tipo test = dipendente
      // il valore deve corrispondere al codice fiscale del dipendente
      if PTipoTest = TTipoTest.Dipendente then
      begin
        for i:=Low(FMyA118MW.Variabili) to High(FMyA118MW.Variabili) do
        begin
          if FCampo = FMyA118MW.Variabili[i].Nome then
          begin
            Result.Ok:=(FValore = FMyA118MW.Variabili[i].ValoreStr);
            Break;
          end;
        end;
        if not Result.Ok then
          Result.Messaggio:=GeneraErrore('il codice fiscale non corrisponde a quello del dipendente');
      end;
    end;
  end
  else if FCampo = VAR_NOME_UTENTE then
  begin
    // controllo effettuato solo per tipo test = dipendente
    // il valore deve corrispondere al nome utente del dipendente
    if PTipoTest = TTipoTest.Dipendente then
    begin
      for i:=Low(FMyA118MW.Variabili) to High(FMyA118MW.Variabili) do
      begin
        if FCampo = FMyA118MW.Variabili[i].Nome then
        begin
          Result.Ok:=(FValore = FMyA118MW.Variabili[i].ValoreStr);
          Break;
        end;
      end;
      if not Result.Ok then
        Result.Messaggio:=GeneraErrore('il nome utente non corrisponde a quello del dipendente');
    end;
  end
  else if Campo = VAR_FILLER then
  begin
    // filler
    //   valore qualsiasi
    Result.Ok:=True;
  end
  else
  begin
    // variabile non riconosciuta
    //   valore qualsiasi
    Result.Ok:=True;
  end;
end;

{ TVariabiliAnagrafiche }

procedure TVariabiliAnagrafiche.Clear;
begin
  NomeUtente:='';
  Matricola:='';
  CodFiscale:='';
  Progressivo:=0;
end;

end.
