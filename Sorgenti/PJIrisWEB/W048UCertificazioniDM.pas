unit W048UCertificazioniDM;

interface

uses
  SysUtils, Classes, StrUtils, DB, DBClient, Oracle, OracleData, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, C018UIterAutDM, C180FunzioniGenerali;

type
  TDatoPersonalizzato = class
    //private
    //ID
    CodCategoria: String;               // codice categoria di riferimento su SG236_CATEGORIE_CERTIFICAZIONI
    Codice: String;                     // codice del dato personalizzato da SG237_DATI_CERTIFICAZIONI
    Descrizione: String;                // descrizione del dato personalizzato
    //ORDINE
    Obbligatorio: Boolean;              // indica se la valorizzazione del dato personalizzato è obbligatoria
    //RIGHE
    Formato: String;                    // formato del dato (S = stringa, N = numerico, D = data)
    LungMax: Integer;                   // lunghezza max del dato (se Formato = S / N)
    //VALORI
    DatoAnagrafico: String;             // dato anagrafico associato, se presente
    QueryValore: String;                // codice dell'interrogazione di servizio da usare per reperire l'elenco dei valori
    ElencoFisso: String;                // indica se l'elenco dei valori è fisso o è possibile indicare un valore libero (S/N)
    ValoreDefault: String;              // valore di default da impostare in inserimento
    Hint: string;                       // contenuto del fumetto di suggerimento
    SQLValidazione: String;             // istruzione SQL per ricavare la condiczione di validità del dato

    Elenco: Boolean;                    // indica se il dato è selezionabile da elenco oppure no
    ElencoTabellare: Boolean;           // indica se il dato anagrafico associato / query valore è tabellare o meno
    LungCodice: Integer;                // in caso di elenco tabellare, indica la lunghezza del codice

    AbilitaModifica: Boolean;           // indica se è abilitata la modifica dati per l'autorizzatore
    ValoreStr: String;                  // valore del dato espresso in formato string
  end;

  TW048FCertificazioniDM = class(TDataModule)
    selSG230: TOracleDataSet;
    selSG230AUTORIZZAZIONE: TStringField;
    selSG230DATA_RICHIESTA: TDateTimeField;
    selSG230DATA_AUTORIZZAZIONE: TDateTimeField;
    selSG230MATRICOLA: TStringField;
    selSG230NOMINATIVO: TStringField;
    selSG230NOMINATIVO_RESP: TStringField;
    selSG230AUTORIZZ_AUTOMATICA: TStringField;
    selSG230ID: TFloatField;
    selSG230SESSO: TStringField;
    selSG230TIPO_RICHIESTA: TStringField;
    selSG230AUTORIZZ_UTILE: TStringField;
    selSG230AUTORIZZ_REVOCA: TStringField;
    selSG230COD_ITER: TStringField;
    selSG230AUTORIZZ_AUTOM_PREV: TStringField;
    selSG230RESPONSABILE_PREV: TStringField;
    selSG230LIVELLO_AUTORIZZAZIONE: TFloatField;
    selSG230REVOCABILE: TStringField;
    selSG230AUTORIZZ_PREV: TStringField;
    selSG230MSGAUT_SI: TStringField;
    selSG230MSGAUT_NO: TStringField;
    selSG231: TOracleDataSet;
    selSG230ID_REVOCA: TFloatField;
    selSG230ID_REVOCATO: TFloatField;
    selSG230PROGRESSIVO: TFloatField;
    selSG235: TOracleDataSet;
    selSG236SG237: TOracleDataSet;
    selSG236SG237CODICE: TStringField;
    selSG236SG237DESCRIZIONE: TStringField;
    selSG236SG237ORDINE: TIntegerField;
    selSG236SG237OBBLIGATORIO: TStringField;
    selSG236SG237RIGHE: TIntegerField;
    selSG236SG237FORMATO: TStringField;
    selSG236SG237LUNG_MAX: TIntegerField;
    selSG236SG237VALORI: TStringField;
    selSG236SG237DATO_ANAGRAFICO: TStringField;
    selSG236SG237QUERY_VALORE: TStringField;
    selSG236SG237ELENCO_FISSO: TStringField;
    selSG236SG237VALORE_DEFAULT: TStringField;
    selSG236SG237HINT: TStringField;
    selSG236SG237COD_CAT: TStringField;
    selSG236SG237DESC_CAT: TStringField;
    selSG236SG237ORDINE_CAT: TIntegerField;
    selSG236SG237ID: TFloatField;
    selSG230DAL: TDateTimeField;
    selSG230AL: TDateTimeField;
    selSG230COD_MODELLO: TStringField;
    selSG230DESC_MODELLO: TStringField;
    selSG230D_TIPO_RICHIESTA: TStringField;
    selSG230D_RESPONSABILE: TStringField;
    selSG230D_AUTORIZZAZIONE: TStringField;
    selSG230D_STATO: TStringField;
    selSG230DESCRIZIONE: TStringField;
    selSG230ID_CERTIFICAZIONE: TFloatField;
    delT850: TOracleQuery;
    selQueryValore: TOracleQuery;
    selQueryPeriodo: TOracleQuery;
    selQueryVSG230: TOracleQuery;
    selSG237CampiInput: TOracleQuery;
    selSG235b: TOracleDataSet;
    selSG235c: TOracleDataSet;
    selSG236SG237VALIDAZIONE: TStringField;
    selT430: TOracleDataSet;
    procedure selSG230CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure selSG230ALGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure selSG230FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    C018:TC018FIterAutDM;
  end;

implementation

{$R *.dfm}

procedure TW048FCertificazioniDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;

  // imposta costante QVistaOracle
  selSG230.SetVariable('QVISTAORACLE',QVistaOracle);

  // elenco certificazioni
  selSG231.Open;
  // elenco modelli
  selSG235c.Open;
end;

procedure TW048FCertificazioniDM.selSG230ALGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsDateTime = 0 then
    Text:=''
  else
    Text:=Sender.AsString;
end;

procedure TW048FCertificazioniDM.selSG230CalcFields(DataSet: TDataSet);
var S:String;
begin
  with selSG230 do
  begin
    if FieldByName('TIPO_RICHIESTA').AsString='' then
      FieldByName('D_TIPO_RICHIESTA').AsString:='Da confermare'
    else if FieldByName('TIPO_RICHIESTA').AsString='D' then
      FieldByName('D_TIPO_RICHIESTA').AsString:='Definitiva';
    // D_AUTORIZZAZIONE: descr. autorizzazione
    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      S:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=S;

    // D_RESPONSABILE: nominativo responsabile
    FieldByName('D_RESPONSABILE').AsString:=Trim(FieldByName('NOMINATIVO_RESP').AsString);

    // D_STATO: descr. stato
    if FieldByName('AUTORIZZAZIONE').AsString = '' then
      S:=''
    else if FieldByName('AUTORIZZAZIONE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_STATO').AsString:=S;
  end;
end;

procedure TW048FCertificazioniDM.selSG230FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('MODELLI DI CERTIFICAZIONE',DataSet.FieldByName('COD_MODELLO').AsString);
end;

end.
