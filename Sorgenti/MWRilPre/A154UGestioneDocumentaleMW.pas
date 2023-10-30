unit A154UGestioneDocumentaleMW;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  A000UCostanti,
  A000UMessaggi,
  A000USessione,
  C021UDocumentiManagerDM,
  C180FunzioniGenerali,
  C017UEMailDtM,
  R005UDataModuleMW,
  System.SysUtils, System.Classes, System.Types, Oracle, OracleData,
  Data.DB, System.StrUtils, Variants;

type

  TDestEMailAllegato = (UfficioToDipendente, DipdenenteToUfficio);

  TResultElaborazione = record
    Esito:boolean;
    MsgErrore:string;
  end;

  TValore = class(TObject)
  private
    FValore: String;
  public
    constructor Create(const PValore: String);
    property Valore: String read FValore;
  end;

  TA154FGestioneDocumentaleMW = class(TR005FDataModuleMW)
    selT962: TOracleDataSet;
    selT963: TOracleDataSet;
    dsrT962: TDataSource;
    dsrT963: TDataSource;
    selT962CODICE: TStringField;
    selT962DESCRIZIONE: TStringField;
    selT963CODICE: TStringField;
    selT963DESCRIZIONE: TStringField;
    selT962Lookup: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    selT963Lookup: TOracleDataSet;
    StringField3: TStringField;
    StringField4: TStringField;
    dsrT962Lookup: TDataSource;
    dsrT963Lookup: TDataSource;
    selT962CODICE_DEFAULT: TStringField;
    selT963CODICE_DEFAULT: TStringField;
    selT962EMAIL: TStringField;
    selT963EMAIL: TStringField;
    selT962LookupEMAIL: TStringField;
    selT963LookupEMAIL: TStringField;
    selSG101: TOracleDataSet;
    dsrSG101: TDataSource;
    selT962NoVersione: TOracleDataSet;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    selT960MaxVersione: TOracleQuery;
    selT962ORDINE: TFloatField;
    selT962VERSIONABILE: TStringField;
    selT962UM: TStringField;
    selT962QUANTITA: TIntegerField;
    selT962SCRIPT_TICKET_PDF: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dsrT962StateChange(Sender: TObject);
    procedure dsrT963StateChange(Sender: TObject);
    procedure selT962BeforeDelete(DataSet: TDataSet);
    procedure selT963BeforeDelete(DataSet: TDataSet);
    procedure selT962AfterDelete(DataSet: TDataSet);
    procedure selT962BeforePost(DataSet: TDataSet);
    procedure selT962AfterPost(DataSet: TDataSet);
    procedure selT963AfterPost(DataSet: TDataSet);
    procedure selT963AfterDelete(DataSet: TDataSet);
    procedure selT963BeforePost(DataSet: TDataSet);
    procedure selT962DeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure selT963DeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure selT962AfterScroll(DataSet: TDataSet);
    procedure selT963AfterScroll(DataSet: TDataSet);
  private
    OldDCartellaFile: String;
    OldselT960IdRefresh: Integer;
    IterMaxDimAllegatoMB: Integer;
    C017DM:TC017FEMailDtM;
    tmpBeforePost: procedure (Sender:TDataSet) of object;
    tmpAfterPost: procedure (Sender:TDataSet) of object;
    procedure SalvaDocumento;
    procedure CreaListe;
    procedure CaricaListe;
    procedure CaricaListaTipologie;
    procedure CaricaListaUffici;
    procedure DistruggiListe;
    function GetNomeCampoUtente: String;
  public
    selT960_Funzioni: TOracleDataSet;
    ListaTipologie: TStringList;
    ListaTipologieNoVersione: TStringList;
    CodTipologiaDefault: String;
    CodTipologiaDefaultChanged: Boolean;
    CodTipologiaDefaultDeleted: Boolean;
    ListaUffici: TStringList;
    CodUfficioDefault: String;
    CodUfficioDefaultChanged: Boolean;
    CodUfficioDefaultDeleted: Boolean;
    EditNomeFile:Boolean;
    EditTipologia: String;
    ModuloGestioneDocumentale:Boolean;
    C021DM: TC021FDocumentiManagerDM;
    DestEMailAllegato:TDestEMailAllegato;
    procedure OnCalcFields;
    procedure OnNewRecord;
    procedure BeforeEdit;
    procedure BeforeDelete;
    procedure BeforePost;
    procedure AfterPost;
    procedure BeforeRefresh;
    procedure AfterRefresh;
    procedure FiltraFamiliari(Progressivo:Integer);
    function SendMailAllegato(Destinatario:TDestEMailAllegato):TResultElaborazione;
    function ControllaCF(cf: String): String;
    function CheckVersioniPresenti: Boolean;
    function CheckVersionabile: Boolean;
    function CambioTipologia: Boolean;
  end;

implementation

uses A000UInterfaccia;

{$R *.dfm}

{ TA154FGestioneDocumentaleMW }

procedure TA154FGestioneDocumentaleMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ModuloGestioneDocumentale:=Parametri.ModuloInstallato['GESTIONE_DOCUMENTALE'];
  //ModuloGestioneDocumentale:=DebugHook = 0;
  // crea datamodulo di servizio per allegati
  C021DM:=TC021FDocumentiManagerDM.Create(Owner);
  C021DM.Maschera:={$IFDEF WEBPJ}'W' + {$ENDIF} 'A154';

  // variabile per riposizionamento refresh
  OldselT960IdRefresh:=-1;

  // apertura dataset
  selT962.Open;
  selT962NoVersione.Open;
  selT963.Open;
  selT962Lookup.Open;
  selT963Lookup.Open;

  // crea e popola le liste di appoggio
  CreaListe;
  CaricaListe;

  // dimensione max allegati
  IterMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);
end;

procedure TA154FGestioneDocumentaleMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(C021DM);
  FreeAndNil(C017DM);
  DistruggiListe;
  inherited;
end;

function TA154FGestioneDocumentaleMW.GetNomeCampoUtente: String;
begin
  Result:=IfThen(Parametri.TipoOperatore = 'I070','UTENTE','NOME_UTENTE');
end;

procedure TA154FGestioneDocumentaleMW.CreaListe;
begin
  ListaTipologie:=TStringList.Create;
  ListaTipologie.OwnsObjects:=True;
  ListaTipologie.StrictDelimiter:=True;

  ListaTipologieNoVersione:=TStringList.Create;
  ListaTipologieNoVersione.OwnsObjects:=True;
  ListaTipologieNoVersione.StrictDelimiter:=True;

  ListaUffici:=TStringList.Create;
  ListaUffici.OwnsObjects:=True;
  ListaUffici.StrictDelimiter:=True;
end;

procedure TA154FGestioneDocumentaleMW.CaricaListe;
begin
  CaricaListaTipologie;
  CaricaListaUffici;
end;

function TA154FGestioneDocumentaleMW.CheckVersioniPresenti: Boolean;
begin
  selT960MaxVersione.SetVariable('PROGRESSIVO', selT960_Funzioni.FieldByName('PROGRESSIVO').AsString);
  selT960MaxVersione.SetVariable('NOME_FILE', selT960_Funzioni.FieldByName('NOME_FILE').AsString);
  selT960MaxVersione.SetVariable('EXT_FILE', selT960_Funzioni.FieldByName('EXT_FILE').AsString);
  selT960MaxVersione.SetVariable('TIPOLOGIA', selT960_Funzioni.FieldByName('TIPOLOGIA').AsString);
  selT960MaxVersione.Execute;

  Result:=selT960MaxVersione.Field(0) > 1;
end;

function TA154FGestioneDocumentaleMW.CheckVersionabile: Boolean;
begin
  Result:=False;

  selT962.Close;
  //selT962.SetVariable('CODICE', selT960_Funzioni.FieldByName('TIPOLOGIA').AsString);
  selT962.Open;
  selT962.Locate('CODICE', selT960_Funzioni.FieldByName('TIPOLOGIA').AsString, []);
  if selT962.Locate('CODICE', selT960_Funzioni.FieldByName('TIPOLOGIA').AsString, []) then
    Result:=selT962.FieldByName('VERSIONABILE').AsString = 'S'
  else
    raise Exception.Create('Tipo documento utilizzato per l''archiviazione inesistente');
end;

procedure TA154FGestioneDocumentaleMW.DistruggiListe;
begin
  FreeAndNil(ListaTipologieNoVersione);
  FreeAndNil(ListaTipologie);
  FreeAndNil(ListaUffici);
end;

function TA154FGestioneDocumentaleMW.CambioTipologia: Boolean;
begin
  Result:=False;

  if (selT960_Funzioni.State = dsEdit) and (selT960_Funzioni.FieldByName('TIPOLOGIA').AsString <> EditTipologia) then
    Result:=True;
end;

procedure TA154FGestioneDocumentaleMW.CaricaListaTipologie;
// carica la lista delle tipologie da T962
var
  i: Integer;
begin
  // se non è specificato un default, utilizza la tipologia predefinita
  CodTipologiaDefault:=DOC_TIPOL_PREDEF;
  ListaTipologie.Clear;

  selT962.Open;
  selT962.First;
  while not selT962.Eof do
  begin
    ListaTipologie.Add(Format('%s=%s',[selT962.FieldByName('DESCRIZIONE').AsString,selT962.FieldByName('CODICE').AsString]));
    // codice default
    if selT962.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      CodTipologiaDefault:=selT962.FieldByName('CODICE').AsString;
    selT962.Next;
  end;
  for i:=0 to ListaTipologie.Count - 1 do
  begin
    ListaTipologie.Objects[i]:=TValore.Create(ListaTipologie.ValueFromIndex[i]);
    ListaTipologie.Strings[i]:=ListaTipologie.Names[i];
  end;

  //carica la lista delle tipologie non versionabili
  ListaTipologieNoVersione.Clear;

  selT962NoVersione.Open;
  selT962NoVersione.First;
  while not selT962NoVersione.Eof do
  begin
    ListaTipologieNoVersione.Add(Format('%s=%s',[selT962NoVersione.FieldByName('DESCRIZIONE').AsString,selT962NoVersione.FieldByName('CODICE').AsString]));
    selT962NoVersione.Next;
  end;
  for i:=0 to ListaTipologieNoVersione.Count - 1 do
  begin
    ListaTipologieNoVersione.Objects[i]:=TValore.Create(ListaTipologieNoVersione.ValueFromIndex[i]);
    ListaTipologieNoVersione.Strings[i]:=ListaTipologieNoVersione.Names[i];
  end;
end;

procedure TA154FGestioneDocumentaleMW.CaricaListaUffici;
// carica lista uffici
var
  i: Integer;
begin
  // se non è specificato un default, utilizza l'ufficio predefinito
  CodUfficioDefault:=DOC_UFFICIO_PREDEF;
  ListaUffici.Clear;

  selT963.Open;
  selT963.First;
  while not selT963.Eof do
  begin
    ListaUffici.Add(Format('%s=%s',[selT963.FieldByName('DESCRIZIONE').AsString,selT963.FieldByName('CODICE').AsString]));
    // codice default
    if selT963.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      CodUfficioDefault:=selT963.FieldByName('CODICE').AsString;
    selT963.Next;
  end;
  for i:=0 to ListaUffici.Count - 1 do
  begin
    ListaUffici.Objects[i]:=TValore.Create(ListaUffici.ValueFromIndex[i]);
    ListaUffici.Strings[i]:=ListaUffici.Names[i];
  end;
end;

procedure TA154FGestioneDocumentaleMW.dsrT962StateChange(Sender: TObject);
begin
  inherited;
  selT962.FieldByName('CODICE').ReadOnly:=dsrT962.State = dsEdit;
end;

procedure TA154FGestioneDocumentaleMW.dsrT963StateChange(Sender: TObject);
begin
  inherited;
  selT963.FieldByName('CODICE').ReadOnly:=dsrT963.State = dsEdit;
end;

procedure TA154FGestioneDocumentaleMW.FiltraFamiliari(Progressivo: Integer);
begin
  //Filtro familiari per "progressivo"
  R180SetVariable(selSG101,'PROGRESSIVO',Progressivo);
  selSG101.Open;
end;

procedure TA154FGestioneDocumentaleMW.OnCalcFields;
var
  LNomeFile, LExtFile, LUtenteProprietario, LAccessoResp, LAccessoPortale: String;
begin
  // campo nome file (nome + estensione)
  LNomeFile:=selT960_Funzioni.FieldByName('NOME_FILE').AsString;
  LExtFile:=selT960_Funzioni.FieldByName('EXT_FILE').AsString;
  if (LNomeFile <> '') and (LExtFile <> '') then
    LNomeFile:=Format('%s.%s',[LNomeFile,LExtFile]);
  selT960_Funzioni.FieldByName('D_NOME_FILE').AsString:=LNomeFile;

  // dimensione file
  if LNomeFile = '' then
    selT960_Funzioni.FieldByName('D_DIMENSIONE').AsString:=''
  else
    selT960_Funzioni.FieldByName('D_DIMENSIONE').AsString:=R180GetFileSizeStr(selT960_Funzioni.FieldByName('DIMENSIONE').AsLargeInt);

  // proprietario documento
  if selT960_Funzioni.FieldByName('UTENTE').AsString = '' then
  begin
    // utente web
    LUtenteProprietario:=selT960_Funzioni.FieldByName('NOME_UTENTE').AsString;
    if selT960_Funzioni.FieldByName('WEB_NOMINATIVO').AsString <> '' then
    begin
      LUtenteProprietario:=Format('%s (%s)',
                                  [LUtenteProprietario,
                                   selT960_Funzioni.FieldByName('WEB_NOMINATIVO').AsString]);
    end;
  end
  else
  begin
    // utente win
    LUtenteProprietario:=selT960_Funzioni.FieldByName('UTENTE').AsString;
  end;
  selT960_Funzioni.FieldByName('D_PROPRIETARIO').AsString:=LUtenteProprietario;

  // accesso responsabile
  if selT960_Funzioni.FindField('D_ACCESSO_RESPONSABILE') <> nil then
  begin
    LAccessoResp:=selT960_Funzioni.FieldByName('ACCESSO_RESPONSABILE').AsString;
    if LAccessoResp = 'S' then
      LAccessoResp:='Si'
    else if LAccessoResp = 'N' then
      LAccessoResp:='No';
    selT960_Funzioni.FieldByName('D_ACCESSO_RESPONSABILE').AsString:=LAccessoResp;
  end;

  // accesso da portale IrisWeb
  if selT960_Funzioni.FindField('D_ACCESSO_PORTALE') <> nil then
  begin
    LAccessoPortale:=selT960_Funzioni.FieldByName('ACCESSO_PORTALE').AsString;
    if LAccessoPortale = 'S' then
      LAccessoPortale:='Si'
    else if LAccessoPortale = 'N' then
      LAccessoPortale:='No';
    selT960_Funzioni.FieldByName('D_ACCESSO_PORTALE').AsString:=LAccessoPortale;
  end;

  // dati accesso
  if not selT960_Funzioni.FieldByName('UTENTE_ACCESSO').IsNull then
  begin
    selT960_Funzioni.FieldByName('D_DATI_ACCESSO').AsString:=Format('%s (%s)',
    [selT960_Funzioni.FieldByName('UTENTE_ACCESSO').AsString,
     FormatDateTime('dd/mm/yyyy hh.mm.ss',selT960_Funzioni.FieldByName('DATA_ACCESSO').AsDateTime)]);
  end;
end;

procedure TA154FGestioneDocumentaleMW.OnNewRecord;
var
  CampoUser: String;
begin
  // imposta automaticamente il valore di alcuni dati
  // data di creazione
  selT960_Funzioni.FieldByName('DATA_CREAZIONE').AsDateTime:=Now;
  // utente proprietario
  CampoUser:=GetNomeCampoUtente;
  selT960_Funzioni.FieldByName(CampoUser).AsString:=Parametri.Operatore;
  // periodo
  selT960_Funzioni.FieldByName('PERIODO_DAL').Value:=null;
  selT960_Funzioni.FieldByName('PERIODO_AL').Value:=null;
  // tipologia
  selT960_Funzioni.FieldByName('TIPOLOGIA').AsString:=CodTipologiaDefault;
  // ufficio
  selT960_Funzioni.FieldByName('UFFICIO').AsString:=CodUfficioDefault;
end;

procedure TA154FGestioneDocumentaleMW.BeforeEdit;
// controlli per modifica
begin
  EditNomeFile:=selT960_Funzioni.FieldByName('NOME_FILE').IsNull;
  EditTipologia:=selT960_Funzioni.FieldByName('TIPOLOGIA').AsString;
end;

procedure TA154FGestioneDocumentaleMW.BeforeDelete;
// controlli per cancellazione
var
  LCampoUser: String;
  LCampoUserAltro: String;
  LPath: String;
  LResCtrl: TResCtrl;
begin
  LCampoUser:=GetNomeCampoUtente;
  LCampoUserAltro:=IfThen(LCampoUser = 'NOME_UTENTE','UTENTE','NOME_UTENTE');

  // impedisce cancellazione di documenti caricati da altri utenti
  (*Controllo originale per EMPOLI: non si può cancellare un documento se creato da qualsiasi altro operatore
  if (selT960_Funzioni.FieldByName(LCampoUserAltro).AsString <> '') or
     (selT960_Funzioni.FieldByName(LCampoUser).AsString <> Parametri.Operatore) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_CANC_DOC_ALTRO_USER));
  *)

  //Se creato da IrisWEB non posso cancellarlo da backOffice o viceversa
  if (selT960_Funzioni.FieldByName(LCampoUserAltro).AsString <> '') then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_CANC_DOC_ALTRO_USER));

  //Se creato da IrisWEB non può essere cancellato da altro operatore
  if (Parametri.TipoOperatore = 'I060') and
     (selT960_Funzioni.FieldByName(LCampoUser).AsString <> Parametri.Operatore) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_CANC_DOC_ALTRO_USER));


  // impedisce cancellazione di documenti legati a richieste web
  if selT960_Funzioni.FieldByName('TIPOLOGIA').AsString = DOC_TIPOL_ITER then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_CANC_TIPO_ITER));

  // impedisce cancellazione di documenti già visualizzati (aperti o scaricati)
  if (not selT960_Funzioni.FieldByName('DATA_ACCESSO').IsNull) or
     (not selT960_Funzioni.FieldByName('UTENTE_ACCESSO').IsNull) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_CANC_DOC_VISUALIZZATO));

  LPath:=selT960_Funzioni.FieldByName('PATH_STORAGE').AsString;
  if LPath <> DOC_STORAGE_DB then
  begin
    // cancellazione documento via webservice B021
    // se la provenienza del file è interna cancella per id, altrimenti per nome file
    if selT960_Funzioni.FieldByName('PROVENIENZA').AsString = DOC_PROVENIENZA_INTERNA then
      LResCtrl:=C021DM.DeleteJson(LPath,selT960_Funzioni.FieldByName('ID').AsInteger)
    else
      LResCtrl:=C021DM.DeleteJson(LPath,Format('%s.%s',[selT960_Funzioni.FieldByName('NOME_FILE').AsString,selT960_Funzioni.FieldByName('EXT_FILE').AsString]));

    if not LResCtrl.Ok then
      raise Exception.CreateFmt('Errore durante la cancellazione del documento:'#13#10'%s',[LResCtrl.Messaggio]);
  end;
end;

procedure TA154FGestioneDocumentaleMW.BeforePost;
var
  LDataInizio, LDataFine: TDateTime;
  LFile,ErroreCF: String;
  LDimensione: Int64;
  LDimMB: double;
begin
  // verifica indicazione file
  {Bruno: 08/04/2016
  if selT960_Funzioni.FieldByName('NOME_FILE').AsString = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_FILE_NON_INDICATO));}

  // verifica correttezza periodo
  LDataInizio:=selT960_Funzioni.FieldByName('PERIODO_DAL').AsDateTime;
  LDataFine:=selT960_Funzioni.FieldByName('PERIODO_AL').AsDateTime;
  if (LDataInizio <> DATE_NULL) or
     (LDataFine <> DATE_NULL) then
  begin
    // data inizio periodo
    // controlla validità nel range convenzionale
    if (LDataInizio < DATE_MIN) or (LDataInizio > DATE_MAX) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO));
    // data fine periodo
    // controlla validità nel range convenzionale
    if (LDataFine < DATE_MIN) or (LDataFine > DATE_MAX) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO));
    // controlla consecutività periodo
    if LDataInizio > LDataFine then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO));
  end;

  // verifica indicazione tipologia
  if selT960_Funzioni.FieldByName('TIPOLOGIA').AsString = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_TIPOLOGIA_NON_INDICATA));

  // tipologia iter
  // - in inserimento non è consentita
  // - in modifica è valida solo se l'utente non è un operatore
  if selT960_Funzioni.FieldByName('TIPOLOGIA').AsString = DOC_TIPOL_ITER then
  begin
    if selT960_Funzioni.State = dsInsert then
      raise Exception.Create(A000TraduzioneStringhe(Format(A000MSG_A154_ERR_FMT_TIPOLOGIA_ITER_INS,[D_DOC_TIPOL_ITER])))
    else if (selT960_Funzioni.State = dsEdit) and
            (selT960_Funzioni.FieldByName('UTENTE').AsString <> '') then
      raise Exception.Create(A000TraduzioneStringhe(Format(A000MSG_A154_ERR_FMT_TIPOLOGIA_ITER_VAR,[D_DOC_TIPOL_ITER])))
  end;

  // verifica indicazione ufficio
  if selT960_Funzioni.FieldByName('UFFICIO').AsString = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_UFFICIO_NON_INDICATO));

  // Valorizzazione RICHIEDERE_ENTE = N se DATA_RICHIESTA_ENTE o DATA_RICEZIONE_ENTE sono diversi da null
  if (not selT960_Funzioni.FieldByName('DATA_RICHIESTA_ENTE').isNull) or (not selT960_Funzioni.FieldByName('DATA_RICEZIONE_ENTE').isNull) then
  begin
    selT960_Funzioni.FieldByName('RICHIEDERE_ENTE').asString:='N';
  end;

  // i campi di tipologia e ufficio non devono essere modificati
  if selT960_Funzioni.State = dsInsert then
  begin
    selT960_Funzioni.FieldByName('D_TIPOLOGIA').Value:=null;
    selT960_Funzioni.FieldByName('D_UFFICIO').Value:=null;
  end
  else
  begin
    selT960_Funzioni.FieldByName('D_TIPOLOGIA').Value:=selT960_Funzioni.FieldByName('D_TIPOLOGIA').medpOldValue;
    selT960_Funzioni.FieldByName('D_UFFICIO').Value:=selT960_Funzioni.FieldByName('D_UFFICIO').medpOldValue;
  end;

  // il campo cartella è fittizio
  OldDCartellaFile:=selT960_Funzioni.FieldByName('D_CARTELLA_FILE').AsString;
  selT960_Funzioni.FieldByName('D_CARTELLA_FILE').AsString:='';

  // controllo dimensione file
  LFile:=IncludeTrailingPathDelimiter(OldDCartellaFile) + selT960_Funzioni.FieldByName('D_NOME_FILE').AsString;
  LDimensione:=R180GetFileSize(LFile);
  LDimMB:=LDimensione / BYTES_MB;
  if LDimMB > IterMaxDimAllegatoMB then
  begin
    // solleva eccezione
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_DIM_ALLEGATO),[IterMaxDimAllegatoMB,LDimMB]));
  end;

  if (not selT960_Funzioni.FieldByName('NOME_FILE').IsNull) and
     ((selT960_Funzioni.State = dsInsert) or (selT960_Funzioni.FieldByName('NOME_FILE').medpOldValue = null)) then
    selT960_Funzioni.FieldByName('PATH_STORAGE').AsString:=Parametri.CampiRiferimento.C90_PathAllegati;

  // controllo formale codice fiscale (solo se scritto e no se selezionato)
  if not (selSG101.SearchRecord('CODFISCALE',selT960_Funzioni.FieldByName('CF_FAMILIARE').AsString,[srFromBeginning])) then
  begin
    selT960_Funzioni.FieldByName('CF_FAMILIARE').AsString:=selT960_Funzioni.FieldByName('CF_FAMILIARE').AsString.ToUpper;
    ErroreCF:=ControllaCF(selT960_Funzioni.FieldByName('CF_FAMILIARE').AsString);
    if  ErroreCF <> '' then
      raise Exception.Create(ErroreCF);
  end;

  //se sono in insert inserisco il numero di versione solo se la tipologia è versionabile, trovo in nuovo numero di versione
  if ((selT960_Funzioni.State = dsInsert) and not selT962NoVersione.Locate('CODICE', selT960_Funzioni.FieldByName('TIPOLOGIA').AsString, [])) or
  //se sono in edit, la nuova tipologia è versionabile ed è diversa dalla precedente, trovo in nuovo numero di versione
     ((selT960_Funzioni.State = dsEdit) and not selT962NoVersione.Locate('CODICE', selT960_Funzioni.FieldByName('TIPOLOGIA').AsString, []) and (selT960_Funzioni.FieldByName('TIPOLOGIA').AsString <> EditTipologia))
  then
  begin
    selT960MaxVersione.SetVariable('PROGRESSIVO', selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    selT960MaxVersione.SetVariable('NOME_FILE', selT960_Funzioni.FieldByName('NOME_FILE').AsString);
    selT960MaxVersione.SetVariable('EXT_FILE', selT960_Funzioni.FieldByName('EXT_FILE').AsString);
    selT960MaxVersione.SetVariable('TIPOLOGIA', selT960_Funzioni.FieldByName('TIPOLOGIA').AsString);
    selT960MaxVersione.Execute;

    selT960_Funzioni.FieldByName('VERSIONE').AsInteger:=selT960MaxVersione.Field(0);
  end
  //se sono in edit e la nuova tipologia non è versionabile, svuoto la versione
  else if (selT960_Funzioni.State = dsEdit) and selT962NoVersione.Locate('CODICE', selT960_Funzioni.FieldByName('TIPOLOGIA').AsString, []) then
  begin
    selT960_Funzioni.FieldByName('VERSIONE').Clear;
  end;
end;

function TA154FGestioneDocumentaleMW.SendMailAllegato(Destinatario:TDestEMailAllegato):TResultElaborazione;
var
  DestEMail, EMailTipo, EMailUfficio:string;
  selT960_StatePrev:TDataSetState;
begin
  Result.Esito:=False;
  Result.MsgErrore:='';
  try
    C017DM:=TC017FEMailDtM.Create(nil);
    try
      C017DM.Sessione:=SessioneOracle;
      if Destinatario = TDestEMailAllegato.UfficioToDipendente then
      begin
        //Gestione notifica Da:Uffico A:Dipendente
        C017DM.CercaDestinatari:=True;
        C017DM.Progressivo:=selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger;
        Result.Esito:=True;
      end
      else if Destinatario = TDestEMailAllegato.DipdenenteToUfficio then
      begin
        //Gestione notifica Da:Dipendente A:Ufficio\Responsabile
        C017DM.CercaDestinatari:=False;
        //Composizione elenco E-Mail dei destinatari
        //E-Mail tipologia
        EMailTipo:=VarToStr(selT962Lookup.Lookup('CODICE',selT960_Funzioni.FieldByName('TIPOLOGIA').AsString,'EMAIL'));
        //E-Mail ufficio
        EMailUfficio:=VarToStr(selT963.Lookup('CODICE',selT960_Funzioni.FieldByName('UFFICIO').AsString,'EMAIL'));
        DestEMail:=EMailTipo;
        //Composizione E-Mail Tipologia-Ufficio
        if not EMailUfficio.IsEmpty then
        begin
          if not DestEMail.IsEmpty then
          begin
            DestEMail:=DestEMail + ';';
          end;
          DestEMail:=DestEMail + EMailUfficio;
        end;
        C017DM.Destinatari:=DestEMail.Trim;
        if not DestEMail.IsEmpty then
        begin
          Result.Esito:=True;
        end;
      end;
      if Result.Esito then
      begin
        C017DM.DestResponsabile:=False;
        C017DM.Oggetto:='Notifica di caricamento documento';
        C017DM.Testo:=Format('E'' disponibile nel sistema IrisWEB il documento %s.%s',[selT960_Funzioni.FieldByName('NOME_FILE').AsString,selT960_Funzioni.FieldByName('EXT_FILE').AsString]);
        C017DM.InviaEMail;
        //Se l'invio e-mail è andato a buon fine valorizzo il campo DATA_NOTIFICA
        selT960_StatePrev:=selT960_Funzioni.State;
        if not (selT960_StatePrev in [dsInsert,dsEdit]) then
        begin
          selT960_Funzioni.Edit;
        end;
        selT960_Funzioni.FieldByName('DATA_NOTIFICA').AsDateTime:=Now;
        if not (selT960_StatePrev in [dsInsert,dsEdit]) then
        begin
          selT960_Funzioni.Post;
        end;
      end;
    finally
      FreeAndNil(C017DM);
    end;
  except
    on e:exception do
    begin
      Result.Esito:=False;
      Result.MsgErrore:=e.Message;
    end;
  end;
end;

function TA154FGestioneDocumentaleMW.ControllaCF(cf: String): String;
const SetDisp : array [0..25] of Integer = (1, 0, 5, 7, 9, 13, 15, 17, 19, 21, 2, 4, 18, 20,
		11, 3, 6, 8, 12, 14, 16, 10, 22, 25, 24, 23);
var	i, n, s : Integer;
    cf2 : String;
begin
  Result:='';
	if Length(cf)=0 then Exit;
	if Length(cf)<>16 then
   begin
    Result:='La lunghezza del codice fiscale non è corretta: il codice '+
            'fiscale dovrebbe essere lungo esattamente 16 caratteri.';
    Exit;
   end;

	cf2 := UpperCase(cf);
  for I:=1 to 16 do
   if not(((cf2[I]>='0')and(cf2[I]<='9'))or((cf2[I]>='A')And(cf2[I]<='Z'))) then
   begin
     Result:='Il codice fiscale contiene dei caratteri non validi: '+
		         'i soli caratteri validi sono le lettere e le cifre.';
     Exit;
   end;

	s := 0;
  for I:=2 to 14 do
    if not Odd(I) then
    begin
      n := Ord(cf2[I]);
      if ((cf2[I] >= '0') and (cf2[I] <= '9')) then
        s := s + n - Ord('0')
      else
        s := s + n - Ord('A');
    end;

  for I:=1 to 15 do
  if Odd(I) then
  begin
     n := Ord(cf2[I]);
     if ((cf2[I] >= '0') and (cf2[I] <= '9')) then
       n := n - Ord('0') + Ord('A');
     s := s + SetDisp[n-Ord('A')];
  end;

  n := (s Mod 26) + Ord('A');
  if Chr(n) <> cf2[16] then
    Result:='Il codice fiscale non è corretto: il codice di controllo non corrisponde.';
end;

procedure TA154FGestioneDocumentaleMW.AfterPost;
begin
  // in caso di inserimento salva il documento nel corrispondente campo blob di T961
  if EditNomeFile then
  begin
    SalvaDocumento;
    EditNomeFile:=False;
    //SendMailAllegato(DestEMailAllegato);
  end;
  // aggiorna per rileggere i dati
  //selT960_Funzioni.Refresh;
end;

procedure TA154FGestioneDocumentaleMW.BeforeRefresh;
begin
  // salva ID per successivo riposizionamento
  if (selT960_Funzioni.Active) and
     (selT960_Funzioni.RecordCount > 0) then
    OldselT960IdRefresh:=selT960_Funzioni.FieldByName('ID').AsInteger
  else
    OldselT960IdRefresh:=-1;
end;

procedure TA154FGestioneDocumentaleMW.AfterRefresh;
begin
  if (selT960_Funzioni.Active) and
     (selT960_Funzioni.RecordCount > 0) and
     (OldselT960IdRefresh > -1) then
  begin
    selT960_Funzioni.SearchRecord('ID',OldselT960IdRefresh,[srFromBeginning]);
  end;
end;

procedure TA154FGestioneDocumentaleMW.SalvaDocumento;
// operazioni in fase di aggiunta del documento
var
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  LDoc:=TDocumento.Create;
  try
    LDoc.Id:=selT960_Funzioni.FieldByName('ID').AsInteger;
    LDoc.TempFile:=IncludeTrailingPathDelimiter(OldDCartellaFile) + selT960_Funzioni.FieldByName('D_NOME_FILE').AsString;
    LDoc.PathStorage:=selT960_Funzioni.FieldByName('PATH_STORAGE').AsString;
    try
      LResCtrl:=C021DM.Upload(LDoc);
      if not LResCtrl.ok then
        raise Exception.Create(LResCtrl.Messaggio);
      SessioneOracle.Commit;
    except
      SessioneOracle.Commit;
      tmpBeforePost:=selT960_Funzioni.BeforePost;
      tmpAfterPost:=selT960_Funzioni.AfterPost;
      selT960_Funzioni.BeforePost:=nil;
      selT960_Funzioni.AfterPost:=nil;
      try
        selT960_Funzioni.Edit;
        selT960_Funzioni.FieldByName('NOME_FILE').AsString:='';
        selT960_Funzioni.Post;
        selT960_Funzioni.Edit;
      finally
        selT960_Funzioni.BeforePost:=tmpBeforePost;
        selT960_Funzioni.AfterPost:=tmpAfterPost;
      end;
      raise;
    end;
  finally
    FreeAndNil(LDoc);
  end;
end;

procedure TA154FGestioneDocumentaleMW.selT962BeforeDelete(DataSet: TDataSet);
begin
  // impedisce eliminazione di tipologie particolari
  if DataSet.FieldByName('CODICE').AsString = DOC_TIPOL_PREDEF then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A154_ERR_FMT_CANC_TIPOL_PREDEF),[DataSet.FieldByName('DESCRIZIONE').AsString]));

  if DataSet.FieldByName('CODICE').AsString = DOC_TIPOL_ITER then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A154_ERR_FMT_CANC_TIPOL_ITER),[DOC_TIPOL_ITER]));

  if DataSet.FieldByName('CODICE').AsString = DOC_TIPOL_INPS then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A154_ERR_FMT_CANC_TIPOL_ITER),[DOC_TIPOL_INPS]));

  // indica se si sta eliminando la tipologia di default
  CodTipologiaDefaultDeleted:=DataSet.FieldByName('CODICE_DEFAULT').AsString = 'S';

  RegistraLog.SettaProprieta('C','T962_TIPO_DOCUMENTI',NomeOwner,DataSet,True);
end;

procedure TA154FGestioneDocumentaleMW.selT962AfterDelete(DataSet: TDataSet);
begin
  // se è stata eliminata la tipologia di default la resetta
  if CodTipologiaDefaultDeleted then
    CodTipologiaDefault:=DOC_TIPOL_PREDEF;

  RegistraLog.RegistraOperazione;
  RegistraLog.Session.Commit;
end;

procedure TA154FGestioneDocumentaleMW.selT962DeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  // integrità referenziale non rispettata
  if Pos('ORA-02292',E.Message) > 0 then
  begin
    R180MessageBox(A000TraduzioneStringhe(A000MSG_A154_ERR_CANC_TIPOL_FK),ESCLAMA);
    Action:=daAbort;
  end;
end;

procedure TA154FGestioneDocumentaleMW.selT962BeforePost(DataSet: TDataSet);
begin
  // verifica valore di CODICE_DEFAULT
  if not R180In(DataSet.FieldByName('CODICE_DEFAULT').AsString,['S','N']) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_CODICE_DEFAULT));

  // verifica che il default sia impostato su un solo record per tipo
  if DataSet.FieldByName('CODICE_DEFAULT').AsString = 'S' then
  begin
    if QueryPK1.EsisteChiave('T962_TIPO_DOCUMENTI',TOracleDataSet(DataSet).RowID,DataSet.State,['CODICE_DEFAULT'],['S']) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_CODICE_DEFAULT_MULT));
  end;

  // indica se il default è cambiato
  CodTipologiaDefaultChanged:=(DataSet.State = dsEdit) and
                              (DataSet.FieldByName('CODICE_DEFAULT').medpOldValue <> DataSet.FieldByName('CODICE_DEFAULT').Value);

  // info per log
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T962_TIPO_DOCUMENTI',NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M','T962_TIPO_DOCUMENTI',NomeOwner,DataSet,True);
  end;
end;

procedure TA154FGestioneDocumentaleMW.selT962AfterPost(DataSet: TDataSet);
begin
  // se è cambiato il codice di default lo ridetermina
  if CodTipologiaDefaultChanged then
  begin
    if DataSet.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      CodTipologiaDefault:=DataSet.FieldByName('CODICE').AsString
    else
      CodTipologiaDefault:=DOC_TIPOL_PREDEF;
  end;

  // ripristina il readonly dei campi
  DataSet.FieldByName('DESCRIZIONE').ReadOnly:=False;

  RegistraLog.RegistraOperazione;
  RegistraLog.Session.Commit;
end;

procedure TA154FGestioneDocumentaleMW.selT962AfterScroll(DataSet: TDataSet);
var
  LIsTipologiaSpeciale: Boolean;
begin
  // impedisce modifica dei dati della tipologia per alcuni codici
  LIsTipologiaSpeciale:=R180In(DataSet.FieldByName('CODICE').AsString,[DOC_TIPOL_PREDEF,DOC_TIPOL_ITER,DOC_TIPOL_INPS]);

  // imposta eventualmente il readonly dei campi
  DataSet.FieldByName('DESCRIZIONE').ReadOnly:=LIsTipologiaSpeciale;
end;

// UFFICIO

procedure TA154FGestioneDocumentaleMW.selT963BeforeDelete(DataSet: TDataSet);
begin
  // impedisce cancellazione di uffici particolari
  if DataSet.FieldByName('CODICE').AsString = DOC_UFFICIO_PREDEF then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A154_ERR_FMT_CANC_UFFICIO_PREDEF),[DataSet.FieldByName('DESCRIZIONE').AsString]));

  // indica se si sta eliminando l'ufficio di default
  CodUfficioDefaultDeleted:=DataSet.FieldByName('CODICE_DEFAULT').AsString = 'S';

  RegistraLog.SettaProprieta('C','T963_UFFICIO_DOCUMENTI',NomeOwner,DataSet,True);
end;

procedure TA154FGestioneDocumentaleMW.selT963AfterDelete(DataSet: TDataSet);
begin
  // se è stato eliminato il codice di default lo resetta
  if CodUfficioDefaultDeleted then
    CodUfficioDefault:=DOC_UFFICIO_PREDEF;

  RegistraLog.RegistraOperazione;
  RegistraLog.Session.Commit;
end;

procedure TA154FGestioneDocumentaleMW.selT963DeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  // integrità referenziale non rispettata
  if Pos('ORA-02292',E.Message) > 0 then
  begin
    R180MessageBox(A000TraduzioneStringhe(A000MSG_A154_ERR_CANC_UFFICIO_FK),ESCLAMA);
    Action:=daAbort;
  end;
end;

procedure TA154FGestioneDocumentaleMW.selT963BeforePost(DataSet: TDataSet);
begin
  // verifica valore di CODICE_DEFAULT
  if not R180In(DataSet.FieldByName('CODICE_DEFAULT').AsString,['S','N']) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_CODICE_DEFAULT));

  // verifica che il default sia impostato su un solo record per tipo
  if DataSet.FieldByName('CODICE_DEFAULT').AsString = 'S' then
  begin
    if QueryPK1.EsisteChiave('T963_UFFICIO_DOCUMENTI',TOracleDataSet(DataSet).RowID,DataSet.State,['CODICE_DEFAULT'],['S']) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_CODICE_DEFAULT_MULT));
  end;

  // indica se il default è cambiato
  CodUfficioDefaultChanged:=(DataSet.State = dsEdit) and
                            (DataSet.FieldByName('CODICE_DEFAULT').medpOldValue <> DataSet.FieldByName('CODICE_DEFAULT').Value);

  // info per log
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T963_UFFICIO_DOCUMENTI',NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M','T963_UFFICIO_DOCUMENTI',NomeOwner,DataSet,True);
  end;
end;

procedure TA154FGestioneDocumentaleMW.selT963AfterPost(DataSet: TDataSet);
begin
  // se è cambiato il codice di default lo ridetermina
  if CodUfficioDefaultChanged then
  begin
    if DataSet.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      CodUfficioDefault:=DataSet.FieldByName('CODICE').AsString
    else
      CodUfficioDefault:=DOC_UFFICIO_PREDEF;
  end;

  // ripristina il readonly dei campi
  DataSet.FieldByName('DESCRIZIONE').ReadOnly:=False;

  RegistraLog.RegistraOperazione;
  RegistraLog.Session.Commit;
end;

procedure TA154FGestioneDocumentaleMW.selT963AfterScroll(DataSet: TDataSet);
var
  LIsUfficioPredef: Boolean;
begin
  // impedisce modifica di ufficio predefinito
  LIsUfficioPredef:=DataSet.FieldByName('CODICE').AsString = DOC_UFFICIO_PREDEF;

  // imposta eventualmente il readonly dei campi
  DataSet.FieldByName('CODICE').ReadOnly:=LIsUfficioPredef;
  DataSet.FieldByName('DESCRIZIONE').ReadOnly:=LIsUfficioPredef;
end;

{ TValore }

constructor TValore.Create(const PValore: String);
begin
  FValore:=PValore;
end;

end.
