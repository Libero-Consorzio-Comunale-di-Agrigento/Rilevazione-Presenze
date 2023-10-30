unit A155URicercaDocumentaleMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Oracle, OracleData,
  Data.DB, System.StrUtils, Variants,
  C021UDocumentiManagerDM, A000UMessaggi, C180FunzioniGenerali,
  System.Generics.Collections;

type
  TValore = class(TObject)
  private
    FValore: String;
  public
    constructor Create(const PValore: String);
    property Valore: String read FValore;
  end;

  TRangeDimensione = record
    MinKB: Integer;
    MaxKB: Integer;
  end;
  TPeriodo = record
    Inizio: TDateTime;
    Fine: TDateTime;
  end;

  TInfoUtente = class
  private
    FNomeUtente: String;
    FOperatore: Boolean;
  public
    constructor Create(const POperatore: Boolean; const PNomeUtente: String);
    property NomeUtente: String read FNomeUtente;
    property IsOperatore: Boolean read FOperatore;
  end;

  TFiltroDocumenti = class
  private
    function CheckDati(var RErrMsg: String): Boolean;
    function GetConfrontoSQL(PCampo: String; PListaValori: TStringList; const PCaseSensitive: Boolean = True): String;
  public
    NomeFile: String;
    CodFiscale: String;
    ListEstensioni: TStringList;
    ListUtenti: TObjectList<TInfoUtente>;
    Periodo: TPeriodo;
    Creazione: TPeriodo;
    Dimensione: TRangeDimensione;
    ListTipologie: TStringList;
    ListUffici: TStringList;
    DocRichiedere,
    DocRichiesti,
    DocRicevuti:boolean;
    Note: String;
    constructor Create;
    destructor Destroy; override;
    function GetFiltroSQL: String;
  end;

  // liste di elementi presenti nella tabella T960
  TElencoListe = record
    ListaEstensioniT960: TStringList;
    ListaUtentiT960: TStringList;
    ListaTipologieT960: TStringList;
    ListaUfficiT960: TStringList;
  end;

  TA155FRicercaDocumentaleMW = class(TR005FDataModuleMW)
    selT960ExtFile: TOracleDataSet;
    selT960: TOracleDataSet;
    selT960ID: TFloatField;
    selT960DATA_CREAZIONE: TDateTimeField;
    selT960UTENTE: TStringField;
    selT960NOME_UTENTE: TStringField;
    selT960PROGRESSIVO: TFloatField;
    selT960TIPOLOGIA: TStringField;
    selT960UFFICIO: TStringField;
    selT960NOME_FILE: TStringField;
    selT960EXT_FILE: TStringField;
    selT960DIMENSIONE: TFloatField;
    selT960PERIODO_DAL: TDateTimeField;
    selT960PERIODO_AL: TDateTimeField;
    selT960NOTE: TStringField;
    selT960D_NOME_FILE: TStringField;
    selT960D_DIMENSIONE: TStringField;
    selT960WEB_MATRICOLA: TStringField;
    selT960D_PROPRIETARIO: TStringField;
    selT960D_TIPOLOGIA: TStringField;
    selT960D_UFFICIO: TStringField;
    selT960Tipologie: TOracleDataSet;
    selT960Uffici: TOracleDataSet;
    selT960Operatori: TOracleDataSet;
    selT960UtentiWeb: TOracleDataSet;
    selT960MATRICOLA: TStringField;
    selT960NOMINATIVO: TStringField;
    selT960WEB_NOMINATIVO: TStringField;
    selT960UTENTE_ACCESSO: TStringField;
    selT960DATA_ACCESSO: TDateTimeField;
    selT960D_DATI_ACCESSO: TStringField;
    selT960ACCESSO_RESPONSABILE: TStringField;
    selT960D_ACCESSO_RESPONSABILE: TStringField;
    selT960DATA_LETTURA_PROGRESSIVO: TDateTimeField;
    selT960DATA_RILASCIO: TDateTimeField;
    selT960CF_FAMILIARE: TStringField;
    selT960HASH: TStringField;
    selT960VERSIONE: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT960CalcFields(DataSet: TDataSet);
    procedure selT960BeforeRefresh(DataSet: TDataSet);
    procedure selT960AfterRefresh(DataSet: TDataSet);
  private
    OldselT960IdRefresh: Integer;
    procedure CaricaListaEstensioniT960;
    procedure CaricaListaTipologieT960;
    procedure CaricaListaUfficiT960;
    procedure CaricaListaUtentiT960;
    procedure CreaListe;
    procedure DistruggiListe;
  public
    C021DM: TC021FDocumentiManagerDM;
    FiltroDoc: TFiltroDocumenti;
    Liste: TElencoListe;
    ModuloGestioneDocumentale:Boolean;
    procedure CaricaListe;
    procedure OnCalcFields;
  end;

implementation

uses A000UInterfaccia;

{$R *.dfm}

{ TA155FRicercaDocumentaleMW }

procedure TA155FRicercaDocumentaleMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ModuloGestioneDocumentale:=Parametri.ModuloInstallato['GESTIONE_DOCUMENTALE'];
  //ModuloGestioneDocumentale:=DebugHook = 0;
  selT960.FieldByName('D_NOME_FILE').Visible:=ModuloGestioneDocumentale;
  selT960.FieldByName('D_DIMENSIONE').Visible:=ModuloGestioneDocumentale;

  // crea datamodulo di servizio per allegati
  C021DM:=TC021FDocumentiManagerDM.Create(nil);
  C021DM.Maschera:={$IFDEF WEBPJ}'W' + {$ENDIF} 'A155';

  // variabile per riposizionamento refresh
  OldselT960IdRefresh:=-1;

  // oggetto di servizio per filtro
  FiltroDoc:=TFiltroDocumenti.Create;

  // crea e popola le liste di appoggio
  CreaListe;
  CaricaListe;
end;

procedure TA155FRicercaDocumentaleMW.DataModuleDestroy(Sender: TObject);
begin
  DistruggiListe;
  FreeAndNil(FiltroDoc);
  FreeAndNil(C021DM);
  inherited;
end;

procedure TA155FRicercaDocumentaleMW.CreaListe;
begin
  Liste.ListaEstensioniT960:=TStringList.Create;
  Liste.ListaEstensioniT960.OwnsObjects:=True;
  Liste.ListaEstensioniT960.StrictDelimiter:=True;

  Liste.ListaUtentiT960:=TStringList.Create;
  Liste.ListaUtentiT960.OwnsObjects:=True;
  Liste.ListaUtentiT960.StrictDelimiter:=True;

  Liste.ListaTipologieT960:=TStringList.Create;
  Liste.ListaTipologieT960.OwnsObjects:=True;
  Liste.ListaTipologieT960.StrictDelimiter:=True;

  Liste.ListaUfficiT960:=TStringList.Create;
  Liste.ListaUfficiT960.OwnsObjects:=True;
  Liste.ListaUfficiT960.StrictDelimiter:=True;
end;

procedure TA155FRicercaDocumentaleMW.DistruggiListe;
begin
  FreeAndNil(Liste.ListaEstensioniT960);
  FreeAndNil(Liste.ListaUtentiT960);
  FreeAndNil(Liste.ListaTipologieT960);
  FreeAndNil(Liste.ListaUfficiT960);
end;

procedure TA155FRicercaDocumentaleMW.CaricaListe;
begin
  CaricaListaEstensioniT960;
  CaricaListaUtentiT960;
  CaricaListaTipologieT960;
  CaricaListaUfficiT960;
end;

procedure TA155FRicercaDocumentaleMW.CaricaListaEstensioniT960;
// carica lista estensioni (distinct di quelle disponibili)
var
  i: Integer;
begin
  Liste.ListaEstensioniT960.Clear;

  selT960ExtFile.Close;
  selT960ExtFile.Open;
  while not selT960ExtFile.Eof do
  begin
    Liste.ListaEstensioniT960.Add(Format('%s=%s',[selT960ExtFile.FieldByName('EXT_FILE').AsString,selT960ExtFile.FieldByName('EXT_FILE').AsString]));
    selT960ExtFile.Next;
  end;
  for i:=0 to Liste.ListaEstensioniT960.Count - 1 do
  begin
    Liste.ListaEstensioniT960.Objects[i]:=TValore.Create(Liste.ListaEstensioniT960.ValueFromIndex[i]);
    Liste.ListaEstensioniT960.Strings[i]:=Liste.ListaEstensioniT960.Names[i];
  end;
  selT960ExtFile.Close;
end;

procedure TA155FRicercaDocumentaleMW.CaricaListaUtentiT960;
// carica la lista degli utenti
var
  i, idxFrom: Integer;
begin
  Liste.ListaUtentiT960.Clear;

  // a. operatori win
  selT960Operatori.Close;
  selT960Operatori.Open;
  while not selT960Operatori.Eof do
  begin
    Liste.ListaUtentiT960.Add(Format('%s=%s',[selT960Operatori.FieldByName('UTENTE').AsString,selT960Operatori.FieldByName('UTENTE').AsString]));
    selT960Operatori.Next;
  end;
  for i:=0 to Liste.ListaUtentiT960.Count - 1 do
  begin
    Liste.ListaUtentiT960.Objects[i]:=TInfoUtente.Create(True,Liste.ListaUtentiT960.ValueFromIndex[i]);
    Liste.ListaUtentiT960.Strings[i]:=Liste.ListaUtentiT960.Names[i];
  end;
  selT960Operatori.Close;

  // b. utenti web
  idxFrom:=Liste.ListaUtentiT960.Count;
  selT960UtentiWeb.Close;
  selT960UtentiWeb.Open;
  while not selT960UtentiWeb.Eof do
  begin
    Liste.ListaUtentiT960.Add(Format('%s (%s %s)=%s',
                          [selT960UtentiWeb.FieldByName('NOME_UTENTE').AsString,
                           selT960UtentiWeb.FieldByName('COGNOME').AsString,
                           selT960UtentiWeb.FieldByName('NOME').AsString,
                           selT960UtentiWeb.FieldByName('NOME_UTENTE').AsString]));
    selT960UtentiWeb.Next;
  end;
  for i:=idxFrom to Liste.ListaUtentiT960.Count - 1 do
  begin
    Liste.ListaUtentiT960.Objects[i]:=TInfoUtente.Create(False,Liste.ListaUtentiT960.ValueFromIndex[i]);
    Liste.ListaUtentiT960.Strings[i]:=Liste.ListaUtentiT960.Names[i];
  end;
  selT960UtentiWeb.Close;
end;

procedure TA155FRicercaDocumentaleMW.CaricaListaTipologieT960;
// carica la lista delle tipologie da T962
var
  i: Integer;
begin
  Liste.ListaTipologieT960.Clear;

  selT960Tipologie.Close;
  selT960Tipologie.Open;
  while not selT960Tipologie.Eof do
  begin
    Liste.ListaTipologieT960.Add(Format('%s=%s',[selT960Tipologie.FieldByName('DESCRIZIONE').AsString,selT960Tipologie.FieldByName('CODICE').AsString]));
    selT960Tipologie.Next;
  end;
  for i:=0 to Liste.ListaTipologieT960.Count - 1 do
  begin
    Liste.ListaTipologieT960.Objects[i]:=TValore.Create(Liste.ListaTipologieT960.ValueFromIndex[i]);
    Liste.ListaTipologieT960.Strings[i]:=Liste.ListaTipologieT960.Names[i];
  end;
  selT960Tipologie.Close;
end;

procedure TA155FRicercaDocumentaleMW.CaricaListaUfficiT960;
// carica lista uffici
var
  i: Integer;
begin
  Liste.ListaUfficiT960.Clear;

  selT960Uffici.Close;
  selT960Uffici.Open;
  while not selT960Uffici.Eof do
  begin
    Liste.ListaUfficiT960.Add(Format('%s=%s',[selT960Uffici.FieldByName('DESCRIZIONE').AsString,selT960Uffici.FieldByName('CODICE').AsString]));
    selT960Uffici.Next;
  end;
  for i:=0 to Liste.ListaUfficiT960.Count - 1 do
  begin
    Liste.ListaUfficiT960.Objects[i]:=TValore.Create(Liste.ListaUfficiT960.ValueFromIndex[i]);
    Liste.ListaUfficiT960.Strings[i]:=Liste.ListaUfficiT960.Names[i];
  end;
  selT960Uffici.Close;
end;

procedure TA155FRicercaDocumentaleMW.OnCalcFields;
var
  LNomeFile, LExtFile, LUtenteProprietario: String;
begin
  // campo nome file (nome + estensione)
  LNomeFile:=selT960.FieldByName('NOME_FILE').AsString;
  LExtFile:=selT960.FieldByName('EXT_FILE').AsString;
  if (LNomeFile <> '') and (LExtFile <> '') then
    LNomeFile:=Format('%s.%s',[LNomeFile,LExtFile]);
  selT960.FieldByName('D_NOME_FILE').AsString:=LNomeFile;

  // dimensione file
  if LNomeFile = '' then
    selT960.FieldByName('D_DIMENSIONE').AsString:=''
  else
    selT960.FieldByName('D_DIMENSIONE').AsString:=R180GetFileSizeStr(selT960.FieldByName('DIMENSIONE').AsLargeInt);

  // proprietario documento
  if selT960.FieldByName('UTENTE').AsString = '' then
  begin
    // utente web
    LUtenteProprietario:=selT960.FieldByName('NOME_UTENTE').AsString;
    if selT960.FieldByName('WEB_NOMINATIVO').AsString <> '' then
    begin
      LUtenteProprietario:=Format('%s (%s)',
                                  [LUtenteProprietario,
                                   selT960.FieldByName('WEB_NOMINATIVO').AsString]);
    end;
  end
  else
  begin
    // utente win
    LUtenteProprietario:=selT960.FieldByName('UTENTE').AsString;
  end;
  selT960.FieldByName('D_PROPRIETARIO').AsString:=LUtenteProprietario;
end;

procedure TA155FRicercaDocumentaleMW.selT960BeforeRefresh(DataSet: TDataSet);
begin
  // salva ID per successivo riposizionamento
  if (selT960.Active) and
     (selT960.RecordCount > 0) then
    OldselT960IdRefresh:=selT960.FieldByName('ID').AsInteger
  else
    OldselT960IdRefresh:=-1;
end;

procedure TA155FRicercaDocumentaleMW.selT960AfterRefresh(DataSet: TDataSet);
begin
  if (selT960.Active) and
     (selT960.RecordCount > 0) and
     (OldselT960IdRefresh > -1) then
  begin
    selT960.SearchRecord('ID',OldselT960IdRefresh,[srFromBeginning]);
  end;
end;

procedure TA155FRicercaDocumentaleMW.selT960CalcFields(DataSet: TDataSet);
var
  LNomeFile, LExtFile, LUtenteProprietario, LAccessoResp: String;
begin
  // campo nome file (nome + estensione)
  LNomeFile:=selT960.FieldByName('NOME_FILE').AsString;
  LExtFile:=selT960.FieldByName('EXT_FILE').AsString;
  if (LNomeFile <> '') and (LExtFile <> '') then
    LNomeFile:=Format('%s.%s',[LNomeFile,LExtFile]);
  selT960.FieldByName('D_NOME_FILE').AsString:=LNomeFile;

  // dimensione file
  if LNomeFile = '' then
    selT960.FieldByName('D_DIMENSIONE').AsString:=''
  else
    selT960.FieldByName('D_DIMENSIONE').AsString:=R180GetFileSizeStr(selT960.FieldByName('DIMENSIONE').AsLargeInt);

  // proprietario documento
  if selT960.FieldByName('UTENTE').AsString = '' then
  begin
    // utente web
    LUtenteProprietario:=selT960.FieldByName('NOME_UTENTE').AsString;
    if selT960.FieldByName('WEB_NOMINATIVO').AsString <> '' then
      LUtenteProprietario:=Format('%s (%s)',[LUtenteProprietario,selT960.FieldByName('WEB_NOMINATIVO').AsString]);
  end
  else
  begin
    // utente win
    LUtenteProprietario:=selT960.FieldByName('UTENTE').AsString;
  end;
  selT960.FieldByName('D_PROPRIETARIO').AsString:=LUtenteProprietario;

  // accesso responsabile
  LAccessoResp:=selT960.FieldByName('ACCESSO_RESPONSABILE').AsString;
  if LAccessoResp = 'S' then
    LAccessoResp:='Si'
  else if LAccessoResp = 'N' then
    LAccessoResp:='No';
  selT960.FieldByName('D_ACCESSO_RESPONSABILE').AsString:=LAccessoResp;

  // dati accesso
  if not selT960.FieldByName('UTENTE_ACCESSO').IsNull then
  begin
    selT960.FieldByName('D_DATI_ACCESSO').AsString:=Format('%s (%s)',
    [selT960.FieldByName('UTENTE_ACCESSO').AsString,
     FormatDateTime('dd/mm/yyyy hh.mm.ss',selT960.FieldByName('DATA_ACCESSO').AsDateTime)]);
  end;
end;

{ TFiltroDocumenti }

constructor TFiltroDocumenti.Create;
begin
  inherited;
  ListUtenti:=TObjectList<TInfoUtente>.Create;
  ListUtenti.OwnsObjects:=False;
  ListEstensioni:=TStringList.Create;
  ListTipologie:=TStringList.Create;
  ListUffici:=TStringList.Create;
  // nome file
  NomeFile:='';
  // codice fiscale
  CodFiscale:='';
  // periodo
  Periodo.Inizio:=DATE_NULL;
  Periodo.Fine:=DATE_NULL;
  // creazione
  Creazione.Inizio:=DATE_NULL;
  Creazione.Fine:=DATE_NULL;
  // dimensione
  Dimensione.MinKB:=0;
  Dimensione.MaxKB:=0;
  // note
  Note:='';
end;

destructor TFiltroDocumenti.Destroy;
begin
  FreeAndNil(ListUtenti);
  FreeAndNil(ListEstensioni);
  FreeAndNil(ListTipologie);
  FreeAndNil(ListUffici);
  inherited;
end;

function TFiltroDocumenti.CheckDati(var RErrMsg: String): Boolean;
// controlla la validità dei dati per il filtro
begin
  Result:=False;
  RErrMsg:='';

  // nome file

  // estensioni

  // utenti win / web


  // periodo
  if (Periodo.Inizio <> DATE_NULL) or
     (Periodo.Fine <> DATE_NULL) then
  begin
    if not R180ControllaPeriodo(Periodo.Inizio,Periodo.Fine,RErrMsg) then
      Exit;
  end;

  // data creazione
  if (Creazione.Inizio <> DATE_NULL) or
     (Creazione.Fine <> DATE_NULL) then
  begin
    if not R180ControllaPeriodo(Creazione.Inizio,Creazione.Fine,RErrMsg) then
      Exit;
    // errore se data di creazione futura
    if Creazione.Inizio > Date then
    begin
      RErrMsg:='Il periodo di creazione del documento è successivo alla data odierna!';
      Exit;
    end;
  end;

  // dimensione
  if Dimensione.MinKB > Dimensione.MaxKB then
  begin
    RErrMsg:=Format('Il range di dimensione specificato non è valido:'#13#10'[%d KB - %d KB]',[Dimensione.MinKB,Dimensione.MaxKB]);
    Exit;
  end;

  // tipologie

  // uffici

  // note

  Result:=True;
end;

function TFiltroDocumenti.GetConfrontoSQL(PCampo: String;
  PListaValori: TStringList; const PCaseSensitive: Boolean = True): String;
var
  i: Integer;
  LVal, LElenco: String;
begin
  if PCampo = '' then
    raise Exception.Create('Campo non indicato!');
  if PListaValori = nil then
    raise Exception.Create('Lista di valori non indicata!');

  // gestione del campo case sensitive
  if not PCaseSensitive then
    PCampo:=Format('upper(%s)',[PCampo]);

  case PListaValori.Count of
    0: Result:='';
    1:
      begin
        // confronto con valore singolo
        LVal:=PListaValori[0];
        if not PCaseSensitive then
          LVal:=LVal.ToUpper;
        Result:=Format('%s = ''%s''',[PCampo,LVal]);
      end;
    2..ORACLE_MAX_IN_VALUES:
      begin
        // confronto con lista di valori nel limite di quelli ammessi dalla "in" oracle
        LVal:=PListaValori.CommaText;
        if not PCaseSensitive then
          LVal:=LVal.ToUpper;
        LVal:=LVal.Replace(',',''',''',[rfReplaceAll]);
        Result:=Format('%s in (''%s'')',[PCampo,LVal]);
      end;
    else
    begin
      // confronto con lista di valori oltre il limite di quelli ammessi dalla "in" oracle
      Result:='';
      i:=0;
      while i < PListaValori.Count do
      begin
        if (i > 0) and (i mod ORACLE_MAX_IN_VALUES = 0) then
        begin
          Result:=Result + Format('%s in (%s) or ',[PCampo,LElenco.Substring(0,LElenco.Length - 1)]);
          LElenco:='';
        end;
        // determina il singolo dato
        LVal:=PListaValori[i];
        if not PCaseSensitive then
          LVal:=LVal.ToUpper;
        LVal:=LVal.QuotedString;
        // accoda il dato all'elenco
        LElenco:=LElenco + LVal + ',';
        i:=i + 1;
      end;
      if LElenco <> '' then
        Result:=Result + Format('%s in (%s)',[PCampo,LElenco.Substring(0,LElenco.Length - 1)]);
      Result:=Format('(%s)',[Result]);
    end;
  end;
end;

function TFiltroDocumenti.GetFiltroSQL: String;
// estrae il filtro sql per i documenti in base ai parametri indicati
var
  LDato, LFiltroTemp, LFiltroUtentiI060, LFiltroUtentiI070, LErr: String;
  LListOperatori, LListUtentiWeb: TStringList;
  LUtente: TInfoUtente;
const
  ALIAS_T960 = 'T960.';
begin
  Result:='';

  // controllo dati
  if not CheckDati(LErr) then
    raise Exception.Create(LErr);

  // filtro su nome file
  LDato:=Format('%sNOME_FILE',[ALIAS_T960]);
  if NomeFile = '' then
    LFiltroTemp:=''
  else
    LFiltroTemp:=Format('and    upper(%s) like ''%%%s%%''',[LDato,NomeFile.ToUpper]);
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + LFiltroTemp;

  // filtro su codice fiscale
  LDato:=Format('%sCF_FAMILIARE',[ALIAS_T960]);
  if CodFiscale = '' then
    LFiltroTemp:=''
  else
    LFiltroTemp:=Format('and    upper(%s) like ''%%%s%%''',[LDato,CodFiscale.ToUpper]);
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + LFiltroTemp;

  // filtro estensioni
  LDato:=Format('%sEXT_FILE',[ALIAS_T960]);
  LFiltroTemp:=GetConfrontoSql(LDato,ListEstensioni,False);
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + 'and    ' + LFiltroTemp;

  // filtro utenti win / web
  LListOperatori:=TStringList.Create;
  LListUtentiWeb:=TStringList.Create;
  try
    for LUtente in ListUtenti do
    begin
      if LUtente.IsOperatore then
        LListOperatori.Add(LUtente.NomeUtente)
      else
        LListUtentiWeb.Add(LUtente.NomeUtente);
    end;

    // operatori I070
    LDato:=Format('%sUTENTE',[ALIAS_T960]);
    LFiltroUtentiI070:=GetConfrontoSql(LDato,LListOperatori);

    // utenti web I060
    LDato:=Format('%sNOME_UTENTE',[ALIAS_T960]);
    LFiltroUtentiI060:=GetConfrontoSQL(LDato,LListUtentiWeb);

    // compone filtro
    if (LFiltroUtentiI070 <> '') and (LFiltroUtentiI060 <> '') then
      LFiltroTemp:=Format('and    (%s or %s)',[LFiltroUtentiI070,LFiltroUtentiI060])
    else if LFiltroUtentiI070 <> '' then
      LFiltroTemp:=Format('and    %s',[LFiltroUtentiI070])
    else if LFiltroUtentiI060 <> '' then
      LFiltroTemp:=Format('and    %s',[LFiltroUtentiI060])
    else
      LFiltroTemp:='';

    if LFiltroTemp <> '' then
      Result:=Result + CRLF + LFiltroTemp;
  finally
    FreeAndNil(LListOperatori);
    FreeAndNil(LListUtentiWeb);
  end;

  // filtro periodo (intersezione)
  if (Periodo.Inizio = DATE_NULL) and (Periodo.Fine = DATE_NULL) then
    LFiltroTemp:=''
  else if (Periodo.Inizio = Periodo.Fine) then
    LFiltroTemp:=Format('and    to_date(''%s'',''dd/mm/yyyy'') between %sPERIODO_DAL and %sPERIODO_AL',
                        [FormatDateTime('dd/mm/yyyy',Periodo.Inizio),ALIAS_T960,ALIAS_T960])
  else
    LFiltroTemp:=Format('and    least(%sPERIODO_AL,to_date(''%s'',''dd/mm/yyyy'')) - greatest(%sPERIODO_DAL,to_date(''%s'',''dd/mm/yyyy'')) >= 0',
                        [ALIAS_T960,FormatDateTime('dd/mm/yyyy',Periodo.Fine),ALIAS_T960,FormatDateTime('dd/mm/yyyy',Periodo.Inizio)]);
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + LFiltroTemp;

  // filtro data creazione
  LDato:=Format('%sDATA_CREAZIONE',[ALIAS_T960]);
  if (Creazione.Inizio = DATE_NULL) and (Creazione.Fine = DATE_NULL) then
    LFiltroTemp:=''
  else if (Creazione.Inizio = Creazione.Fine) then
    LFiltroTemp:=Format('and    trunc(%s) = to_date(''%s'',''dd/mm/yyyy'')',
                        [LDato,FormatDateTime('dd/mm/yyyy',Creazione.Inizio)])
  else
    LFiltroTemp:=Format('and    trunc(%s) between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy'')',
                        [LDato,FormatDateTime('dd/mm/yyyy',Creazione.Inizio),FormatDateTime('dd/mm/yyyy',Creazione.Fine)]);
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + LFiltroTemp;

  // filtro dimensione (KB)
  // il dato su db è in byte, quindi viene eseguita la conversione
  LDato:=Format('%sDIMENSIONE',[ALIAS_T960]);
  if (Dimensione.MinKB = 0) and (Dimensione.MaxKB = 0) then
    LFiltroTemp:=''
  else if (Dimensione.MinKB = Dimensione.MaxKB) then
    LFiltroTemp:=Format('and    trunc(%s / 1024) = %d',[LDato,Dimensione.MinKB])
  else if (Dimensione.MinKB = 0) then
    LFiltroTemp:=Format('and    trunc(%s / 1024) <= %d',[LDato,Dimensione.MaxKB])
  else
    LFiltroTemp:=Format('and    trunc(%s / 1024) between %d and %d',[LDato,Dimensione.MinKB,Dimensione.MaxKB]);
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + LFiltroTemp;

  // filtro tipologie
  LDato:=Format('%sTIPOLOGIA',[ALIAS_T960]);
  LFiltroTemp:=GetConfrontoSql(LDato,ListTipologie);
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + 'and    ' + LFiltroTemp;

  // filtro uffici
  LDato:=Format('%sUFFICIO',[ALIAS_T960]);
  LFiltroTemp:=GetConfrontoSql(LDato,ListUffici);
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + 'and    ' + LFiltroTemp;

  // filtro note
  LDato:=Format('upper(%sNOTE)',[ALIAS_T960]);
  if Note = '' then
    LFiltroTemp:=''
  else
    LFiltroTemp:=Format('and   %s like ''%%%s%%''',[LDato,Note.ToUpper]);
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + LFiltroTemp;

  // filtri autocertificazioni
  // filtro documenti da richiedere
  if DocRichiedere then
  begin
    LFiltroTemp:=Format('and ((%sRICHIEDERE_ENTE = ''S'') and (%sDATA_RICHIESTA_ENTE is null) and (%sDATA_RICEZIONE_ENTE is null))',[ALIAS_T960,ALIAS_T960,ALIAS_T960]);
  end;
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + LFiltroTemp;
  // filtro documenti richiesti
  if DocRichiesti then
  begin
    LFiltroTemp:=Format('and ((%sDATA_RICHIESTA_ENTE is not null) and (%sDATA_RICEZIONE_ENTE is null))',[ALIAS_T960,ALIAS_T960]);
  end;
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + LFiltroTemp;
  // filtro documenti ricevuti
  if DocRicevuti then
  begin
    LFiltroTemp:=Format('and (%sDATA_RICEZIONE_ENTE is not null)',[ALIAS_T960]);
  end;
  if LFiltroTemp <> '' then
    Result:=Result + CRLF + LFiltroTemp;

  // rimuove CRLF iniziale se presente
  if Result.StartsWith(CRLF) then
    Result:=Result.Replace(CRLF,'',[]);
end;

{ TValore }

constructor TValore.Create(const PValore: String);
begin
  FValore:=PValore;
end;

{ TInfoUtente }

constructor TInfoUtente.Create(const POperatore: Boolean; const PNomeUtente: String);
begin
  FOperatore:=POperatore;
  FNomeUtente:=PNomeUtente;
end;

end.
