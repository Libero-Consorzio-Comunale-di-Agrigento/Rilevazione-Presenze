unit W039UGestioneDocumentaleDM;

interface

uses
  A154UGestioneDocumentaleMW, A155URicercaDocumentaleMW,
  A000UInterfaccia, A000UCostanti,
  System.SysUtils, System.Classes, Data.DB, Oracle, OracleData, Variants,
  C180FunzioniGenerali, A000UMessaggi;

type
  TW039FGestioneDocumentaleDM = class(TDataModule)
    selT960: TOracleDataSet;
    selT960ID: TFloatField;
    selT960NOMINATIVO: TStringField;
    selT960MATRICOLA: TStringField;
    selT960D_TIPOLOGIA: TStringField;
    selT960D_UFFICIO: TStringField;
    selT960D_NOME_FILE: TStringField;
    selT960D_DIMENSIONE: TStringField;
    selT960PERIODO_DAL: TDateTimeField;
    selT960PERIODO_AL: TDateTimeField;
    selT960D_PROPRIETARIO: TStringField;
    selT960DATA_CREAZIONE: TDateTimeField;
    selT960NOTE: TStringField;
    selT960UTENTE: TStringField;
    selT960NOME_UTENTE: TStringField;
    selT960PROGRESSIVO: TFloatField;
    selT960TIPOLOGIA: TStringField;
    selT960UFFICIO: TStringField;
    selT960NOME_FILE: TStringField;
    selT960EXT_FILE: TStringField;
    selT960DIMENSIONE: TFloatField;
    selT960WEB_MATRICOLA: TStringField;
    selT960WEB_NOMINATIVO: TStringField;
    selT960D_CARTELLA_FILE: TStringField;
    selT960DATA_ACCESSO: TDateTimeField;
    selT960UTENTE_ACCESSO: TStringField;
    selT960D_DATI_ACCESSO: TStringField;
    selT960ACCESSO_RESPONSABILE: TStringField;
    selT960D_ACCESSO_RESPONSABILE: TStringField;
    selT960DATA_LETTURA_PROGRESSIVO: TDateTimeField;
    selT960AUTOCERTIFICAZIONE: TStringField;
    selT960DATA_RILASCIO: TDateTimeField;
    selT960DATA_RICHIESTA_ENTE: TDateTimeField;
    selT960DATA_RICEZIONE_ENTE: TDateTimeField;
    selT960PATH_STORAGE: TStringField;
    selT960DATA_NOTIFICA: TDateTimeField;
    selT960PROVENIENZA: TStringField;
    selT960CF_FAMILIARE: TStringField;
    selT960HASH: TStringField;
    selT960VERSIONE: TFloatField;
    selT960D_AUTOCERTIFICAZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT960CalcFields(DataSet: TDataSet);
    procedure selT960AfterScroll(DataSet: TDataSet);
  public
    TuttiDipSelezionato:Boolean;
    A154MW: TA154FGestioneDocumentaleMW;
    A155MW: TA155FRicercaDocumentaleMW;
  end;

implementation

uses W039UGestioneDocumentale;

{$R *.dfm}

procedure TW039FGestioneDocumentaleDM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;

  // imposta costante QVistaOracle
  selT960.SetVariable('QVISTAORACLE',QVistaOracle);

  // imposta il readonly delle descrizioni di ufficio e tipologia in modo che sia identico ai campi di riferimento
  selT960.FieldByName('D_TIPOLOGIA').ReadOnly:=selT960.FieldByName('TIPOLOGIA').ReadOnly;
  selT960.FieldByName('D_UFFICIO').ReadOnly:=selT960.FieldByName('UFFICIO').ReadOnly;

  // crea i middleware
  A154MW:=TA154FGestioneDocumentaleMW.Create(Self);
  A154MW.selT960_Funzioni:=selT960;
  //A154MW.selSG101:=selSG101;
  A155MW:=TA155FRicercaDocumentaleMW.Create(Self);
end;

procedure TW039FGestioneDocumentaleDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A154MW);
  FreeAndNil(A155MW);
end;

procedure TW039FGestioneDocumentaleDM.selT960AfterScroll(DataSet: TDataSet);
begin
  // gestione dataset CF Familiari
  R180SetVariable(A154MW.selSG101,'PROGRESSIVO',selT960.FieldByName('PROGRESSIVO').AsInteger);
  A154MW.selSG101.Open;
end;

procedure TW039FGestioneDocumentaleDM.selT960CalcFields(DataSet: TDataSet);
var S: String;
begin
  A154MW.OnCalcFields;

  with selT960 do
  begin
    if FieldByName('AUTOCERTIFICAZIONE').AsString = '' then
      S:=''
    else if FieldByName('AUTOCERTIFICAZIONE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_AUTOCERTIFICAZIONE').AsString:=S;
  end;
end;

end.
