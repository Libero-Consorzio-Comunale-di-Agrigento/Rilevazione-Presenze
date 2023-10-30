unit W050URichiestaDocumentaleDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, A000UInterfaccia, Oracle, OracleData, A000UMessaggi,
  C180FunzioniGenerali, A154UGestioneDocumentaleMW, A155URicercaDocumentaleMW, StrUtils;

type
  TW050FRichiestaDocumentaleDM = class(TDataModule)
    selT960: TOracleDataSet;
    selT960ID: TFloatField;
    selT960ID_RICHIESTA: TFloatField;
    selT960ID_REVOCA: TFloatField;
    selT960ID_REVOCATO: TFloatField;
    selT960NOMINATIVO: TStringField;
    selT960PROGRESSIVO: TFloatField;
    selT960MATRICOLA: TStringField;
    selT960SESSO: TStringField;
    selT960COD_ITER: TStringField;
    selT960TIPO_RICHIESTA: TStringField;
    selT960AUTORIZZ_AUTOMATICA: TStringField;
    selT960REVOCABILE: TStringField;
    selT960DATA_RICHIESTA: TDateTimeField;
    selT960LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT960DATA_AUTORIZZAZIONE: TDateTimeField;
    selT960AUTORIZZAZIONE: TStringField;
    selT960NOMINATIVO_RESP: TStringField;
    selT960AUTORIZZ_AUTOM_PREV: TStringField;
    selT960AUTORIZZ_PREV: TStringField;
    selT960RESPONSABILE_PREV: TStringField;
    selT960AUTORIZZ_UTILE: TStringField;
    selT960AUTORIZZ_REVOCA: TStringField;
    selT960D_TIPO_RICHIESTA: TStringField;
    selT960D_RESPONSABILE: TStringField;
    selT960D_AUTORIZZAZIONE: TStringField;
    selT960D_CARTELLA_FILE: TStringField;
    selT960WEB_MATRICOLA: TStringField;
    selT960WEB_NOMINATIVO: TStringField;
    selT960D_TIPOLOGIA: TStringField;
    selT960D_UFFICIO: TStringField;
    selT960D_NOME_FILE: TStringField;
    selT960D_DIMENSIONE: TStringField;
    selT960D_DATI_ACCESSO: TStringField;
    selT960D_PROPRIETARIO: TStringField;
    selT960D_ACCESSO_RESPONSABILE: TStringField;
    selT960MSGAUTO_SI: TStringField;
    selT960MSGAUT_NO: TStringField;
    selT960NOME_UTENTE: TStringField;
    selT960UTENTE: TStringField;
    selT960TIPOLOGIA: TStringField;
    selT960UFFICIO: TStringField;
    selT960NOME_FILE: TStringField;
    selT960EXT_FILE: TStringField;
    selT960DIMENSIONE: TFloatField;
    selT960NOTE: TStringField;
    selT960UTENTE_ACCESSO: TStringField;
    selT960ACCESSO_RESPONSABILE: TStringField;
    selT960AUTOCERTIFICAZIONE: TStringField;
    selT960RICHIEDERE_ENTE: TStringField;
    selT960PATH_STORAGE: TStringField;
    selT960PROVENIENZA: TStringField;
    selT960ACCESSO_PORTALE: TStringField;
    selT960CF_FAMILIARE: TStringField;
    selT960VERSIONE: TFloatField;
    selT960DATA_NOTIFICA: TDateTimeField;
    selT960DATA_RILASCIO: TDateTimeField;
    selT960DATA_LETTURA_PROGRESSIVO: TDateTimeField;
    selT960DATA_ACCESSO: TDateTimeField;
    selT960PERIODO_AL: TDateTimeField;
    selT960PERIODO_DAL: TDateTimeField;
    selT960DATA_CREAZIONE: TDateTimeField;
    selT960HASH: TStringField;
    selT960DATA_RICHIESTA_ENTE: TDateTimeField;
    selT960DATA_RICEZIONE_ENTE: TDateTimeField;
    selI060: TOracleDataSet;
    selT960D_AUTOCERTIFICAZIONE: TStringField;
    selQueryT960: TOracleQuery;
    selT962: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT960CalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT960AfterPost(DataSet: TDataSet);
    procedure selT960AfterScroll(DataSet: TDataSet);
    procedure selT960BeforeDelete(DataSet: TDataSet);
    procedure selT960BeforeInsert(DataSet: TDataSet);
    procedure selT960BeforeEdit(DataSet: TDataSet);
    procedure selT960BeforePost(DataSet: TDataSet);
    procedure selT960NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    TuttiDipSelezionato:Boolean;
    A154MW: TA154FGestioneDocumentaleMW;
    A155MW: TA155FRicercaDocumentaleMW;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses W050URichiestaDocumentale;

{$R *.dfm}

procedure TW050FRichiestaDocumentaleDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  // imposta il readonly delle descrizioni di ufficio e tipologia in modo che sia identico ai campi di riferimento
  selT960.FieldByName('D_TIPOLOGIA').ReadOnly:=selT960.FieldByName('TIPOLOGIA').ReadOnly;
  selT960.FieldByName('D_UFFICIO').ReadOnly:=selT960.FieldByName('UFFICIO').ReadOnly;

  // crea i middleware
  A154MW:=TA154FGestioneDocumentaleMW.Create(Self);
  A154MW.selT960_Funzioni:=selT960;

  A155MW:=TA155FRicercaDocumentaleMW.Create(Self);
end;

procedure TW050FRichiestaDocumentaleDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A154MW);
  FreeAndNil(A155MW);
end;

procedure TW050FRichiestaDocumentaleDM.selT960AfterPost(DataSet: TDataSet);
begin
  // noop
end;

procedure TW050FRichiestaDocumentaleDM.selT960AfterScroll(DataSet: TDataSet);
begin
  // gestione dataset CF Familiari
  R180SetVariable(A154MW.selSG101,'PROGRESSIVO',selT960.FieldByName('PROGRESSIVO').AsInteger);
  A154MW.selSG101.Open;
end;

procedure TW050FRichiestaDocumentaleDM.selT960BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A154MW.BeforeDelete;
end;

procedure TW050FRichiestaDocumentaleDM.selT960BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  A154MW.BeforeEdit;
end;

procedure TW050FRichiestaDocumentaleDM.selT960BeforeInsert(DataSet: TDataSet);
begin
  if TuttiDipSelezionato then
    Abort;
end;

procedure TW050FRichiestaDocumentaleDM.selT960BeforePost(DataSet: TDataSet);
begin
  //Se IrisWEB non è possibile inserire un record senza allegato
  if selT960.FieldByName('NOME_FILE').AsString = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A154_ERR_FILE_NON_INDICATO));
  A154MW.BeforePost;
end;

procedure TW050FRichiestaDocumentaleDM.selT960CalcFields(DataSet: TDataSet);
var S: String;
begin
  with selT960 do
  begin
    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      S:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=S;

    if FieldByName('AUTOCERTIFICAZIONE').AsString = '' then
      S:=''
    else if FieldByName('AUTOCERTIFICAZIONE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_AUTOCERTIFICAZIONE').AsString:=S;

    if FieldByName('TIPO_RICHIESTA').AsString='' then
      FieldByName('D_TIPO_RICHIESTA').AsString:='Da confermare'
    else if FieldByName('TIPO_RICHIESTA').AsString='D' then
      FieldByName('D_TIPO_RICHIESTA').AsString:='Definitiva';

    FieldByName('D_RESPONSABILE').AsString:=Trim(FieldByName('NOMINATIVO_RESP').AsString);
    FieldByName('D_CARTELLA_FILE').AsString:='';
  end;

  with selI060 do
  begin
    Close;
    ClearVariables;
    SetVariable('AZIENDA', Parametri.Azienda);
    SetVariable('ID', selT960.FieldByName('ID').AsInteger);
    Open;
    selT960.FieldByName('WEB_MATRICOLA').AsString:=selI060.FieldByName('WEB_MATRICOLA').AsString;
    selT960.FieldByName('WEB_NOMINATIVO').AsString:=selI060.FieldByName('WEB_NOMINATIVO').AsString;
    selT960.FieldByName('D_TIPOLOGIA').AsString:=selI060.FieldByName('D_TIPOLOGIA').AsString;
    selT960.FieldByName('D_UFFICIO').AsString:=selI060.FieldByName('D_UFFICIO').AsString;
    Close;
  end;

  A154MW.OnCalcFields;
end;

procedure TW050FRichiestaDocumentaleDM.selT960NewRecord(DataSet: TDataSet);
begin
  // imposta automaticamente il valore di alcuni dati
  A154MW.OnNewRecord; // dati comuni
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=(Self.Owner as TW050FRichiestaDocumentale).selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  // se l'utente web carica il documento associato a se stesso, imposta automaticamente la data di lettura
  if (Parametri.TipoOperatore = 'I060') and
     (Parametri.ProgressivoOper = DataSet.FieldByName('PROGRESSIVO').AsInteger) then
    DataSet.FieldByName('DATA_LETTURA_PROGRESSIVO').AsDateTime:=DataSet.FieldByName('DATA_CREAZIONE').AsDateTime;
end;

end.
