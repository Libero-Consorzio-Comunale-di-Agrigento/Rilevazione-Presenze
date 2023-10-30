unit B110USharedTypes;

interface

uses
  A000UCostanti,
  C200UWebServicesTypes,
  System.Classes,
  System.DateUtils,
  System.StrUtils,
  System.SysUtils,
  System.Generics.Collections,
  DBXJSONReflect,
  System.JSON,
  Data.FireDACJSONReflect;

type
  // classe per informazioni sulla versione del software
  TInfoVersioneSW = class(TPersistent)
  public
    Versione: String;
    Build: String;
    constructor Create(PVersione: String; PBuild: String); overload;
    procedure Assign(APersistent: TPersistent); override;
    procedure Clear;
    function Equals(Obj: TObject): Boolean; override;
    function ToString: String; override;
    function Clone: TInfoVersioneSW;
  const
    TIPO_VERSIONE_PA = 'PA';
    TIPO_VERSIONE_AM = 'AM';
  end;

  // classe per informazioni sul client (da inviare al server)
  TInfoClient = class(TPersistent)
  public
    // dati di versione dell'app
    VersioneApp: TInfoVersioneSW;
    VersioneAppCompatibile: TInfoVersioneSW;
    constructor Create(PVersione, PBuild, PVersioneCompatibile, PBuildCompatibile: String); reintroduce; overload;
    destructor Destroy; override;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TInfoClient;
    function PrepareForServer: TInfoClient;
  end;

  // classe per dati di login ai servizi B110
  TParametriLogin = class(TPersistent)
  private
    FAzienda: String;
    FUtente: String;
    FPassword: String;
    FRicordaPassword: Boolean;
    FProfilo: String;
    FToken: String;
    FTimestamp: Int64;
    function CheckTimestamp(const PTimeoutToken: Integer): TResCtrl;
    function CheckToken: TResCtrl;
    function GeneraTokenAutenticazione: String;
    procedure GeneraDatiAutenticazione;
  public
    // azienda su cui effettuare il login (doppione di FInfoAzienda.Azienda)
    property Azienda: String read FAzienda write FAzienda;
    // utente web (tabella I060) con cui accedere
    property Utente: String read FUtente write FUtente;
    // password dell'utente con cui accedere
    property Password: String read FPassword write FPassword;
    // indica se ricordare la password dopo l'uscita dall'app
    property RicordaPassword: Boolean read FRicordaPassword write FRicordaPassword;
    // profilo con cui accedere
    property Profilo: String read FProfilo write FProfilo;
    // token sha1 di controllo
    property Token: String read FToken;
    // timestamp della request (unix time - ora UTC)
    property Timestamp: Int64 read FTimestamp;
    constructor Create;
    procedure Clear;
    procedure ClearAfterLogout;
    procedure SetDatiAutenticazione(PToken: String; PTimeStamp: Int64);
    function CheckDatiLogin: TResCtrl;
    function CheckDati(const PTimeoutToken: Integer): TResCtrl;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
    function Clone: TParametriLogin;
    function PrepareForServer: TParametriLogin;
  end;

  TTipoServer = (tsMondoEdp,
                 tsAziendale);

  TTipoServerRec = record
  const
    MondoEdp  = TTipoServer.tsMondoEdp;
    Aziendale = TTipoServer.tsAziendale;
  end;

  TTipoServerRecHelper = record helper for TTipoServer
    function ToString: string;
  end;

  // classe per informazioni per connessione al server rest (cfr. tabella R010_WS_ENTI)
  TRestConnectionInfo = class(TPersistent)
  public
    TipoServer: TTipoServer;
    Host: String;
    Port: Integer;
    Protocol: String;
    UrlPath: String;
    constructor Create; overload;
    constructor Create(PTipoServer: TTipoServer; PHost: String; PPort: Integer; PProtocol: String; PUrlPath: String); reintroduce; overload;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  // classi specifiche per servizi

  // ###########################################################################
  // ### Servizio: DatiGenerali
  // ###########################################################################

  TAbilitazioneFunzione = class(TPersistent)
  public
    Tag: Integer;
    Abilitazione: String;
    constructor Create(PTag: Integer; PAbilitazione: String);
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  TAbilitazioneFunzioneArr = array of TAbilitazioneFunzione;

  TDatiAnagraficiUtente = class(TPersistent)
  public
    Progressivo: Integer;
    Matricola: String;
    Nome: String;
    Cognome: String;
    Sesso: String;
    CodFiscale: String;
    [JSONReflect(ctString,rtString,TC200DateTimeInterceptor,nil,True)]
    DataNascita: TDateTime;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  TNomeValore = class(TPersistent)
  public
    Nome: String;
    Valore: String;
    constructor Create(PNome: String; PValore: String);
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  TNomeValoreArr = array of TNomeValore;

  TRangePeriodo = class(TPersistent)
  public
    Min: TDateTime;
    Max: TDateTime;
    constructor Create(PMin, PMax: TDateTime);
    procedure Assign(APersistent: TPersistent); override;
    procedure Clear;
    function ToString: String; override;
  end;

  TParametriServizi = class(TPersistent)
  public
    // stampa cartellino
    CodiciT950: TNomeValoreArr;
    // stampa cedolino
    DataUltimoCedolinoChiuso: TDateTime;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  TDatiDipendenti = class(TPersistent)
  public
    NumDipendenti: Integer;
    NumDipendentiDiversiDaProgressivo: Integer;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  TCampiRiferimentoMobile = record
    C23_InsNegCatena,
    C31_NoteGiustificativi,
    C90_W010CausPres,
    C90_W038Tolleranza_E,
    C90_W038Tolleranza_U,
    C90_W038RilevatoreMobile,
    C90_W038TimbCausalizzabile
    :String;
    procedure AssignParametri(PCampiRiferimento: TCampiRiferimento); inline;
  end;

  TParamMobile = class(TPersistent)
  public
    CampiRiferimento: TCampiRiferimentoMobile;
    HostName: String;
    HostIPAddress: String;
    ClientIPInfo: TIPInfo;
    Path:String;
    VersioneOracle:Integer;
    TimeSeparatorDef:String;
    Applicazione:String;
    Azienda:String;
    DAzienda:String;
    RagioneSociale:String;
    Alias:String;
    Username:String;
    Password:String;
    PasswordMondoEDP:String;
    Operatore:String;
    ProfiloWEB:String;
    ProfiloFiltroPermessi:String;
    ProfiloFiltroAnagrafe:String;
    ProfiloFiltroFunzioni:String;
    ProfiloFiltroDizionario:String;
    TipoOperatore:String;
    ProfiloWEBDelegatoDa:String; // MONZA_HSGERARDO - chiamata 88132
    ProfiloWEBIterAutorizzativi:String;
    PassOper:String;
    ProgressivoOper:Integer;
    MatricolaOper:String;
    CodFiscaleOper:String;
    AuthDom:Boolean;
    AuthDomInfo:TAuthDomInfo;
    LogTabelle:String;
    Database:String;
    NomePJ:String;
    VersionePJ:String;
    BuildPJ:String;
    DataPJ:String;
    VersioneDB:String;
    BuildDB:String;
    DBUnicode:Boolean;
    TimbOrig_Verso:String;
    TimbOrig_Causale:String;
    ValiditaPassword:Word;
    LunghezzaPassword:Word;
    //RegolePassword:TRegolePassword;
    GruppoBadge:String;
    ValiditaUtente:Word;
    ValiditaCessati:Word;
    ProgOper:Word;
    OperBloc:Boolean;
    V430:String;
    Lingua:String;
    //cdsI015:TClientDataSet;
    IntegrazioneAnagrafe:String;
    CodiceIntegrazione:String;
    CodContrattoVoci:String;
    T040_Validazione:String;
    T100_Ora:String;
    T100_Rilevatore:String;
    T100_Causale:String;
    T100_CancTimbOrig:String;
    CancellaTimbrature:String;
    InserisciTimbrature:String;
    AbilitaSchedeChiuse:String;
    A029_Saldi:String;
    A029_Indennita:String;
    A029_Straordinario:String;
    A029_CauPresenza:String;
    A037_EliminaDataCassa:String;
    A037_RicreaScaricoPaghe:String;
    A058_PianifOperativa:String;
    A058_PianifNonOperativa:String;
    A094_Mese:String;
    A094_Anno:String;
    A094_Raggr:String;
    LiquidazioneForzata:String;
    Layout:String;
    Storicizzazione:String;
    ModificaDecorrenza:String;
    EliminaStorici:String;
    InserimentoMatricole:String;
    DefTipoPersonale:String;
    ModPersonaleEsterno:String;
    RipristinoTimbOri:String;
    AggiornamentoBaseDati:String;
    MonitorIntegrAnagra:String;
    C700_SalvaSelezioni:String;
    DatiC700:String;
    ApplicativiDisponibili:String;
    ModuliInstallati:String;
    DataLavoro:TDateTime;
    TSLavoro:String;
    TSIndici:String;
    TSAusiliario:String;
    FileAnomalie:String;
    CampiAnagraficiNonVisibili:String;
    A131_AnticipiGestibili:String;
    I035_ModificaAbbinamenti:String;
    InibizioneIndividuale:Boolean;
    UseStandardPrinter:Boolean;
    Inibizioni:TStringList;
    SelezioneRichiestaPortale:Boolean;
    NomiTabelleLog:TStringList;
    ColonneStruttura:TStringList;
    TipiStruttura:TStringList;
    AbilitazioniFunzioni:array of TAbilitazioniFunzioni;
    FiltroDizionario:array of TFiltroDizionario;
    A139_ServiziComandati:String;
    A139_ServiziBlocco:String;
    A139_ServiziSblocco:String;
    S710_SupervisoreValut:String;
    S710_ModValutatore:String;
    S710_ValidaStato:String;
    WEBIterAssGGPrec:Integer;
    WEBIterAssGGSucc:Integer;
    WEBIterTimbGGPrec:Integer;
    WEBCartelliniDataMin:TDateTime;
    WEBCartelliniMMPrec:Integer;
    WEBCartelliniMMSucc:Integer;
    WEBCartelliniChiusi:String;
    WEBCedoliniDataMin:TDateTime;
    WEBCedoliniMMPrec:Integer;
    WEBCedoliniGGEmiss:Integer;
    WEBCedoliniFilePDF:String;
    ModificaDatiProtetti:Boolean;
    WEBRichiestaConsegnaCed:String;
    WEBRegistraConsegnaVal:String;
    I060_Password: Boolean;
    I070_Password: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
    procedure AssignParametri(Parametri: TParametri);
  end;

  // ###########################################################################
  // ### Servizio: VersioneServer
  // ###########################################################################
  TOutputVersioneServer = class(TPersistent)
  public
    Versione: TInfoVersioneSW;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TOutputVersioneServer;
    function ToString: String; override;
  end;


  // ###########################################################################
  // ### Servizio: DatiGenerali
  // ###########################################################################

  TOutputDatiGenerali = class(TPersistent)
  public
    Profilo: String;
    AbilitazioniArr: TAbilitazioneFunzioneArr;
    ProfiliArr: array of String;
    DatiAnagraficiUtente: TDatiAnagraficiUtente;
    // nota ParametriServizi:
    //   sono stati provati i seguenti tipi
    //   ma non vengono serializzati correttamente (più correttamente non funziona l'unmarshalling)
    // - TDictionary<String,String>
    // - TStringList
    ParametriServizi: TParametriServizi;
    Responsabile: Boolean;
    DatiDipendenti: TDatiDipendenti;
    Parametri: TParamMobile;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
    function GetAbilitazioneTag(const PTag: Integer): String;
  end;

  // ###########################################################################
  // ### Servizio: WebServiceEnte
  // ###########################################################################

  TOutputWebServiceEnte = class(TPersistent)
  public
    IdAzienda: String;
    Azienda: String;
    WSInfo: TRestConnectionInfo;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: RichiesteXXX (classe padre per richieste iter autorizzativi)
  // ###########################################################################

  TFiltriRichieste = class(TPersistent)
  public
    FiltroVis: String;
    PeriodoDa: TDateTime;
    PeriodoA: TDateTime;
    PeriodoDaOriginale: TDateTime;
    PeriodoAOriginale: TDateTime;
    LimiteRecord: Integer;
    constructor Create; reintroduce; overload;
    constructor Create(PFiltroVis: String; PPeriodoDa, PPeriodoA, PPeriodoOrigDa, PPeriodoOrigA: TDateTime; PLimiteRecord: Integer); overload;
    constructor Create(PFiltroVis: String; PPeriodoDa, PPeriodoA: TDateTime; PLimiteRecord: Integer); overload;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TFiltriRichieste;
  end;

  TOutputRichieste = class(TPersistent)
  public
    RichiesteTotali: Integer;
    JSONDatasets: TFDJSONDataSets;
    C018Revocabile: Boolean;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  TOutputInsRichiesta = class(TPersistent)
  public
    RisposteMsg: TRisposteMsg;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(APersistent: TPersistent); override;
    procedure Clear;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: RichiesteGiust
  // ###########################################################################

  TOutputRichiesteGiust = class(TOutputRichieste)
  end;

  TOutputRichiesteGiustDip = class(TOutputRichieste)
  end;

  TOutputInsRichiestaGiust = class(TOutputInsRichiesta)
  end;

  TOutputCancRichiestaGiust = class(TOutputInsRichiesta)
  end;

  TOutputRevocaRichiestaGiust = class(TOutputInsRichiesta)
  end;


  // ###########################################################################
  // ### Servizio: RichiesteTimb
  // ###########################################################################

  TOutputRichiesteTimb = class(TOutputRichieste)
  end;

  TOutputRichiesteTimbDip = class(TOutputRichieste)
  end;

  TOutputInsRichiestaTimb = class(TOutputInsRichiesta)
  end;

  TOutputTimbModificabili = class(TPersistent)
  public
    JSONDatasets: TFDJSONDataSets;
  end;

  // ###########################################################################
  // ### Servizio: NoteRichiesta
  // ###########################################################################

  TNoteLivello = class(TPersistent)
  public
    Livello: Integer;
    DescLivello: String;
    Note: String;
    Autorizzazione: String;
    AutorizzAutomatica: String;
    Nominativo: String;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TNoteLivello;
    function ToString: String; override;
    function Check: TResCtrl;
    function GetAutorizzazione: String; inline;
    function GetDescLivello: String; inline;
    function GetIntestazione: String; inline;
    function GetNoteVis: String; inline;
  end;

  TNoteRichiesta = class(TPersistent)
  public
    NoteArr: array of TNoteLivello;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: RiepilogoAssenze
  // ###########################################################################

  TOutputRiepilogoAssenze = class(TPersistent)
  public
    Data: TDateTime;
    CausaleCod: String;
    CausaleDesc: String;
    UMisura: String;
    UMisuraDesc: String;
    CompPrec: String;
    CompCorr: String;
    CompTot: String;
    FruitoPrec: String;
    FruitoCorr: String;
    FruitoTot: String;
    FruitoRich: String;
    FruitoAut: String;
    ResiduoPrec: String;
    ResiduoCorr: String;
    Residuo: String;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: Cartellini
  // ###########################################################################

  TOutputCartellini = class(TPersistent)
  public
    JSONDatasets: TFDJSONDataSets;
    NumeroCartellini: Integer;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: Cedolini
  // ###########################################################################

  TOutputCedolini = class(TPersistent)
  public
    JSONDatasets: TFDJSONDataSets;
    NumeroCedolini: Integer;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: StampaCedolino
  // ###########################################################################

  TOutputStampaCedolino = class(TPersistent)
  public
    Azione: TAzioneCedolino;
    FileCedolino: TByteDynArrayWrapper;
    MeseCedolino: TDateTime;
    destructor Destroy; override;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: DatiGiornalieri
  // ###########################################################################

  TOutputDatiGiornalieri = class(TPersistent)
  public
    // orario teorico / effettivo, timbrature, assenze...
    Data:TDateTime;
    TimbNominali:String;                //Timbrature nominali + sigla turno
    DebitoGG:String;
    ResoGG:String;
    SaldoGG:String;
    OreEscluseGG:String;
    Timbrature:String;
    Giustificativi:String;
    TurniReperibilita:String;          //Turni reperibilità assegnati
    lstTimbrature:array of String;     //Timbrature dettagliate
    lstGiustificativi:array of String; //Giustificativi dettagliati
    lstAnomalie:array of TItemsValues; //List anomalie ultimi 7 gg (data - anomalia)
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: ElencoDipendenti
  // ###########################################################################

  TOutputElencoDipendenti = class(TPersistent)
  public
    JSONDatasets: TFDJSONDataSets;
    DisplayLabels:String;
    VisibleFields:String;
    NumeroDipendenti: Integer;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: Timbrature
  // ###########################################################################

  TOutputTimbrature = class(TPersistent)
  public
    JSONDatasets: TFDJSONDataSets;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

  TOutputInsTimbratura = class(TPersistent)
  public
    RisposteMsg: TRisposteMsg;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(APersistent: TPersistent); override;
    procedure Clear;
    function ToString: String; override;
  end;

  // ###########################################################################
  // ### Servizio: Dizionario
  // ###########################################################################

  TOutputDizionario = class(TPersistent)
  public
    JSONDatasets: TFDJSONDataSets;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
  end;

const
  SIGLA_SERVIZIO                 = 'B110';

  // dati del file .ini di configurazione
  // nome del file
  FILE_CONFIGURAZIONE            = 'B110.ini';
  // sezione impostazioni
  INI_SEZIONE_IMPOSTAZIONI       = 'Impostazioni';
  // porta
  INI_ID_PORT                    = 'Port';
  //   relativo default
  INI_DEF_PORT                   = 8080;
  // dimensione del pool di thread
  INI_ID_POOL_SIZE               = 'PoolSize';
  //   relativo default
  INI_DEF_POOL_SIZE              = 0;
  // numero max di connessioni concorrenti
  INI_ID_MAX_CONNECTIONS         = 'MaxConnections';
  //   relativo default
  INI_DEF_MAX_CONNECTIONS        = 0;
  // timeout di sessione (espresso in ms)
  INI_ID_SESSION_TIMEOUT         = 'SessionTimeout';
  //   relativo default
  INI_DEF_SESSION_TIMEOUT        = 1200000;
  // chiusura sessione immediata dopo l'esecuzione del metodo (S/N)
  INI_ID_CLOSESESSION_IMMEDIATA  = 'CloseSessionImmediata';
  //   relativo default
  INI_DEF_CLOSESESSION_IMMEDIATA = 'N';
  // tempo di validità del token di accesso (espresso in ms)
  INI_ID_TIMEOUT_TOKEN           = 'TimeoutToken';
  //   relativo default
  INI_DEF_TIMEOUT_TOKEN           = 120000;
  // log su file (S/N)
  INI_ID_FILE_LOG                = 'FileLog';
  //   relativo default
  INI_DEF_FILE_LOG               = 'N';
  // log su codesite live view (S/N)
  INI_ID_LIVEVIEW_LOG            = 'LiveViewLog';
  //   relativo default
  INI_DEF_LIVEVIEW_LOG           = 'N';

  // sezione valori di default
  INI_SEZIONE_DEFAULT            = 'Default';
  // database di default
  INI_ID_DATABASE                = 'Database';
  // azienda di default
  INI_ID_AZIENDA                 = 'Azienda';
  // carattere jolly per indicare l'azienda di default
  AZIENDA_DEFAULT                = '*';

  // nomi della tabella locale AM001_PARAMETRI
  AM001_T950CODICE               = 'T950CODICE';
  AM001_P441DATAMAX              = 'P441DATAMAX';
  AM001_T070DATAMIN              = 'T070DATAMIN';
  AM001_T070DATAMAX              = 'T070DATAMAX';

  // passphrase condivisa per autenticazione
  B110_AUTH_PASSPHRASE           = '1234567890';

  // tabelle per servizio dizionario
  B110_DIZ_TAB_I096              = 'I096';
  B110_DIZ_TAB_SG101             = 'SG101';
  B110_DIZ_TAB_T040_NOTE         = 'T040_NOTE';
  B110_DIZ_TAB_T106              = 'T106';
  B110_DIZ_TAB_T257              = 'T257';
  B110_DIZ_TAB_T265              = 'T265';
  B110_DIZ_TAB_T275              = 'T275';
  B110_DIZ_TAB_T275_RICHIEDIBILI = 'T275_RICHIEDIBILI';
  B110_DIZ_TAB_T361              = 'T361';

  B110_DIZ_TAB_ARR: array [0..8] of String = (
    B110_DIZ_TAB_I096,
    B110_DIZ_TAB_SG101,
    B110_DIZ_TAB_T040_NOTE,
    B110_DIZ_TAB_T106,
    B110_DIZ_TAB_T257,
    B110_DIZ_TAB_T265,
    B110_DIZ_TAB_T275,
    B110_DIZ_TAB_T275_RICHIEDIBILI,
    B110_DIZ_TAB_T361
  );

implementation

uses
  B110USharedUtils,
  A000Versione, 
  FunzioniGenerali;

{ TParametriLogin }

constructor TParametriLogin.Create;
begin
  Clear;
end;

procedure TParametriLogin.Assign(APersistent: TPersistent);
begin
  if APersistent is TParametriLogin then
  begin
    FAzienda:=TParametriLogin(APersistent).Azienda;
    FUtente:=TParametriLogin(APersistent).Utente;
    FPassword:=TParametriLogin(APersistent).Password;
    FProfilo:=TParametriLogin(APersistent).Profilo;
    FToken:=TParametriLogin(APersistent).Token;
    FTimestamp:=TParametriLogin(APersistent).Timestamp;
  end
  else
    inherited Assign(APersistent);
end;

function TParametriLogin.Clone: TParametriLogin;
begin
  Result:=TParametriLogin.Create;
  Result.Assign(Self);
end;

procedure TParametriLogin.Clear;
begin
  // dato relativo all'azienda
  FAzienda:='';

  // credenziali utente
  FUtente:='';
  FPassword:='';
  FRicordaPassword:=False;
  FProfilo:='';
  FToken:='';
  FTimestamp:=0;
end;

procedure TParametriLogin.ClearAfterLogout;
begin
  // dato relativo all'azienda
  //FAzienda:=''; // non viene eliminato

  // credenziali utente
  //FUtente:=''; // non viene eliminato
  FPassword:='';
  FRicordaPassword:=False;
  FProfilo:='';
  FToken:='';
  FTimestamp:=0;
end;

procedure TParametriLogin.SetDatiAutenticazione(PToken: String; PTimeStamp: Int64);
begin
  FToken:=PToken;
  FTimestamp:=PTimestamp;
end;

function TParametriLogin.GeneraTokenAutenticazione: String;
var
  LDato: String;
begin
  // prepara il pacchetto di informazione da cifrare
  // [azienda] | [utente] | [timestamp] | [PASSPHRASE_CONDIVISA]
  LDato:=Format('%s|%s|%d|%s',
                [Azienda,
                 Utente,
                 Timestamp,
                 B110_AUTH_PASSPHRASE]);

  // restituisce il token di autenticazione cifrato con SHA1
  Result:=TB110FSharedUtils.SHA1Encrypt(LDato);
end;

function TParametriLogin.PrepareForServer: TParametriLogin;
begin
  // clona per passaggio al server
  Result:=Self.Clone;

  // genera i dati per l'autenticazione (token e timestamp)
  Result.GeneraDatiAutenticazione;
end;

procedure TParametriLogin.GeneraDatiAutenticazione;
var
  LOraCorrente: TDateTime;
begin
  // determina ora corrente di sistema
  LOraCorrente:=TTimeZone.Local.ToUniversalTime(Now);

  // imposta il timestamp in formato unix time
  FTimestamp:=DateTimeToUnix(LOraCorrente);

  // genera il token in base ai parametri di login
  FToken:=GeneraTokenAutenticazione;
end;

function TParametriLogin.CheckTimestamp(const PTimeoutToken: Integer): TResCtrl;
// controlla che il timestamp della richiesta sia congruente con l'orario del server
// con una tolleranza definita nel file di configurazione del server B110.ini
// IMPORTANTE
//   gli orari sono considerati in UTC
var
  LOraCorrenteUnix: Int64;
  LOraCorrenteUTC: TDateTime;
  //LOraRequestUTC: TDateTime;
  LDeltaSecondi: Integer;
  LTimeoutSecondi: Integer;
  LDeltaMin: Integer;
begin
  Result.Clear;

  // ora della richiesta (UTC)
  //LOraRequestUTC:=UnixToDateTime(Timestamp);
  //TLogger.Debug('Orario client (universal time)',FormatDateTime('hh.mm.ss',LOraRequestUTC));

  // ora corrente
  LOraCorrenteUTC:=TTimeZone.Local.ToUniversalTime(Now);
  //TLogger.Debug('Orario server (universal time)',FormatDateTime('hh.mm.ss',LOraCorrenteUTC));
  LOraCorrenteUnix:=DateTimeToUnix(LOraCorrenteUTC);

  // controlla la differenza fra [ora attuale] e [ora richiesta] sia <= soglia specificata
  // per evitare che il token possa essere riutilizzato
  LDeltaSecondi:=LOraCorrenteUnix - Timestamp;
  LTimeoutSecondi:=Trunc(PTimeoutToken / 1000);
  if (Abs(LDeltaSecondi) > LTimeoutSecondi) then
  begin
    LDeltaMin:=Abs(LDeltaSecondi) div 60;
    if LDeltaSecondi > LTimeoutSecondi then
    begin
      // token scaduto
      Result.Messaggio:=Format('token di autenticazione scaduto (%d minuti)',[LDeltaMin]);
      Exit;
    end
    else if LDeltaSecondi < 0 then
    begin
      // orari client / server non congruenti
      Result.Messaggio:=Format('ora della richiesta non congruente (differenza: %d minuti)',[LDeltaMin]);
      Exit;
    end;
  end;

  // controllo ok
  Result.Ok:=True;
end;

function TParametriLogin.CheckToken: TResCtrl;
var
  LToken: String;
begin
  Result.Clear;

  // ricompone hash dei dati per confronto
  LToken:=GeneraTokenAutenticazione;

  // confronta l'hash per verificare che il token sia valido
  if Token <> LToken then
  begin
    Result.Messaggio:='Token di autenticazione non valido!';
    Exit;
  end;

  // controllo ok
  Result.Ok:=True;
end;

function TParametriLogin.CheckDatiLogin: TResCtrl;
begin
  Result.Clear;

  // verifica l'indicazione di tutti i parametri
  if (Azienda = '') or
     (Utente = '') or
     (Password = '') { or
     (Profilo = '')} then
  begin
    if Azienda = '' then
    begin
      Result.Messaggio:=Format('%s, %s',[Result.Messaggio,'azienda non indicata']);
    end;
    if Utente = '' then
    begin
      Result.Messaggio:=Format('%s, %s',[Result.Messaggio,'utente non indicato!']);
    end;
    if Password = '' then
    begin
      Result.Messaggio:=Format('%s, %s',[Result.Messaggio,'password non indicata']);
    end;
    {
    if Profilo = '' then
    begin
      Result.Messaggio:=Format('%s, %s',[Result.Messaggio,'profilo di accesso non indicato']);
    end;
    }
    if Result.Messaggio <> '' then
      Result.Messaggio:=Result.Messaggio.Substring(2);

    Result.Messaggio:=Format('parametri di login incompleti: %s',[Result.Messaggio]);
    Exit;
  end;

  // controllo ok
  Result.Ok:=True;
end;

function TParametriLogin.CheckDati(const PTimeoutToken: Integer): TResCtrl;
var
  LResCtrl: TResCtrl;
begin
  Result.Clear;

  // verifica l'indicazione di tutti i parametri di login
  LResCtrl:=CheckDatiLogin;
  if not LResCtrl.Ok then
  begin
    Result.Messaggio:=LResCtrl.Messaggio;
    Exit;
  end;

  // verifica indicazione di token e timestamp
  if (Token = '') or
     (Timestamp = 0) then
  begin
    if Token = '' then
    begin
      Result.Messaggio:=Format('%s, %s',[Result.Messaggio,'token di sicurezza non indicato']);
    end;
    if Timestamp = 0 then
    begin
      Result.Messaggio:=Format('%s, %s',[Result.Messaggio,'timestamp non indicato']);
    end;

    if Result.Messaggio <> '' then
      Result.Messaggio:=Result.Messaggio.Substring(2);

    Result.Messaggio:=Format('parametri di login incompleti: %s',[Result.Messaggio]);
    Exit;
  end;

  // verifica timestamp
  LResCtrl:=CheckTimestamp(PTimeoutToken);
  if not LResCtrl.Ok then
  begin
    Result.Messaggio:=LResCtrl.Messaggio;
    Exit;
  end;

  // verifica token di autenticazione
  LResCtrl:=CheckToken;
  if not LResCtrl.Ok then
  begin
    Result.Messaggio:=LResCtrl.Messaggio;
    Exit;
  end;

  // controllo parametri ok
  Result.Ok:=True;
end;

function TParametriLogin.ToString: String;
begin
  Result:=Format('Azienda = %s',[Azienda]) + #13#10 +
          Format('Utente = %s',[Utente]) + #13#10 +
          Format('Password = %s',[Password]) + #13#10 +
          Format('Profilo = %s',[Profilo]) + #13#10;
end;

{ TOutputStampaCedolino }

procedure TOutputStampaCedolino.Assign(APersistent: TPersistent);
begin
  if APersistent is TOutputStampaCedolino then
  begin
    Azione:=TOutputStampaCedolino(APersistent).Azione;
    FileCedolino.Assign(TOutputStampaCedolino(APersistent).FileCedolino);
    MeseCedolino:=TOutputStampaCedolino(APersistent).MeseCedolino;
  end
  else
    inherited Assign(APersistent);
end;

destructor TOutputStampaCedolino.Destroy;
begin
  // è necessario effettuare la free dell'oggetto ByteArrayWrapper
  if FileCedolino <> nil then
    try FreeAndNil(FileCedolino); except end;
  inherited;
end;

function TOutputStampaCedolino.ToString: String;
begin
  Result:=inherited;
end;

{ TRestConnectionInfo }

constructor TRestConnectionInfo.Create;
begin
  Host:='localhost';
  Port:=8080;
  Protocol:='http';
  UrlPath:='';
end;

constructor TRestConnectionInfo.Create(PTipoServer: TTipoServer; PHost: String; PPort: Integer; PProtocol,
  PUrlPath: String);
begin
  TipoServer:=PTipoServer;
  Host:=PHost;
  Port:=PPort;
  Protocol:=PProtocol;
  UrlPath:=PUrlPath;
end;

procedure TRestConnectionInfo.Assign(APersistent: TPersistent);
begin
  if APersistent is TRestConnectionInfo then
  begin
    TipoServer:=TRestConnectionInfo(APersistent).TipoServer;
    Host:=TRestConnectionInfo(APersistent).Host;
    Port:=TRestConnectionInfo(APersistent).Port;
    Protocol:=TRestConnectionInfo(APersistent).Protocol;
    UrlPath:=TRestConnectionInfo(APersistent).UrlPath;
  end
  else
    inherited Assign(APersistent);
end;

procedure TRestConnectionInfo.Clear;
begin
  TipoServer:=tsMondoEdp;
  Host:='';
  Port:=0;
  Protocol:='';
  UrlPath:='';
end;

function TRestConnectionInfo.ToString: String;
begin
  if Host = '' then
    Result:=''
  else
  begin
    // formatta il dato
    Result:=Format('%s://%s',[Protocol,Host]);
    if (Port <> 80) and (Port <> 443) then
      Result:=Result + Format(':%d',[Port]);
    Result:=Result + UrlPath;
  end;
end;

{ TOutputWebServiceEnte }

constructor TOutputWebServiceEnte.Create;
begin
  inherited Create;
  IdAzienda:='';
  Azienda:='';
  WSInfo:=TRestConnectionInfo.Create;
end;

destructor TOutputWebServiceEnte.Destroy;
begin
  FreeAndNil(WSInfo);
  inherited;
end;

procedure TOutputWebServiceEnte.Assign(APersistent: TPersistent);
begin
  if APersistent is TOutputWebServiceEnte then
  begin
    IdAzienda:=TOutputWebServiceEnte(APersistent).IdAzienda;
    Azienda:=TOutputWebServiceEnte(APersistent).Azienda;
    WSInfo.Assign(TOutputWebServiceEnte(APersistent).WSInfo);
  end
  else
    inherited Assign(APersistent);
end;

function TOutputWebServiceEnte.ToString: String;
begin
  Result:=Format('Azienda = %s (id = %s)',[Azienda,IdAzienda]) + #13#10 +
          Format('WSInfo = %s',[WSInfo.ToString]);
end;

{ TOutputDatiGenerali }

constructor TOutputDatiGenerali.Create;
begin
  SetLength(AbilitazioniArr,0);
  SetLength(ProfiliArr,0);
  DatiAnagraficiUtente:=TDatiAnagraficiUtente.Create;
  DatiDipendenti:=TDatiDipendenti.Create;
  Parametri:=TParamMobile.Create;
  ParametriServizi:=TParametriServizi.Create;

  Clear;
end;

destructor TOutputDatiGenerali.Destroy;
var i:Integer;
begin
  //distruzione array...
  for i:=High(AbilitazioniArr) downto 0 do
    try FreeAndNil(AbilitazioniArr[i]); except end;
  SetLength(AbilitazioniArr,0);
  SetLength(ProfiliArr,0);

  try FreeAndNil(DatiAnagraficiUtente); except end;
  try FreeAndNil(DatiDipendenti); except end;
  (*//****) try FreeAndNil(Parametri); except end;
  try FreeAndNil(ParametriServizi); except end;

  inherited;
end;

function TOutputDatiGenerali.GetAbilitazioneTag(const PTag: Integer): String;
var
  i: Integer;
begin
  if PTag = 0 then
  begin
    Result:='S';
  end
  else
  begin
    Result:='N';
    for i:=Low(AbilitazioniArr) to High(AbilitazioniArr) do
    begin
      if PTag = AbilitazioniArr[i].Tag then
      begin
        Result:=AbilitazioniArr[i].Abilitazione;
        Break;
      end;
    end;
  end;
end;

procedure TOutputDatiGenerali.Clear;
begin
  Profilo:='';
  SetLength(AbilitazioniArr,0);
  SetLength(ProfiliArr,0);
  DatiAnagraficiUtente.Clear;
  ParametriServizi.Clear;
  Responsabile:=False;
  DatiDipendenti.Clear;
  if Assigned(Parametri) then
    FreeAndNil(Parametri);
  Parametri:=TParamMobile.Create;
end;

procedure TOutputDatiGenerali.Assign(APersistent: TPersistent);
var
  i: Integer;
begin
  if APersistent is TOutputDatiGenerali then
  begin
    // data ora server
    //DataOraCorrente:=TOutputDatiGenerali(APersistent).DataOraCorrente;

    // profilo
    Profilo:=TOutputDatiGenerali(APersistent).Profilo;

    // array abilitazioni
    SetLength(AbilitazioniArr,Length(TOutputDatiGenerali(APersistent).AbilitazioniArr));
    for i:=Low(AbilitazioniArr) to High(AbilitazioniArr) do
    begin
      FreeAndNil(AbilitazioniArr[i]);
      AbilitazioniArr[i]:=TAbilitazioneFunzione.Create(0,'');
      AbilitazioniArr[i].Assign(TOutputDatiGenerali(APersistent).AbilitazioniArr[i]);
    end;

    // array dei profili disponibili (e validi)
    SetLength(ProfiliArr,Length(TOutputDatiGenerali(APersistent).ProfiliArr));
    for i:=Low(ProfiliArr) to High(ProfiliArr) do
      ProfiliArr[i]:=TOutputDatiGenerali(APersistent).ProfiliArr[i];

    // dati anagrafici utente
    if DatiAnagraficiUtente = nil then
      DatiAnagraficiUtente:=TDatiAnagraficiUtente.Create;
    DatiAnagraficiUtente.Assign(TOutputDatiGenerali(APersistent).DatiAnagraficiUtente);

    // dati dei dipendenti
    if DatiDipendenti = nil then
      DatiDipendenti:=TDatiDipendenti.Create;
    DatiDipendenti.Assign(TOutputDatiGenerali(APersistent).DatiDipendenti);

    // parametri dei servizi
    if ParametriServizi = nil then
      ParametriServizi:=TParametriServizi.Create;
    ParametriServizi.Assign(TOutputDatiGenerali(APersistent).ParametriServizi);

    // altri parametri
    Responsabile:=TOutputDatiGenerali(APersistent).Responsabile;

    // parametri
    // Parametri:=TOutputDatiGenerali(APersistent).Parametri;
    if Parametri = nil then
      Parametri:=TParamMobile.Create;
    Parametri.Assign(TOutputDatiGenerali(APersistent).Parametri);
  end
  else
    inherited Assign(APersistent);
end;

function TOutputDatiGenerali.ToString: String;
begin
  Result:=inherited;
end;

{ TNomeValore }

constructor TNomeValore.Create(PNome, PValore: String);
begin
  Nome:=PNome;
  Valore:=PValore;
end;

procedure TNomeValore.Assign(APersistent: TPersistent);
begin
  if APersistent is TNomeValore then
  begin
    Nome:=TNomeValore(APersistent).Nome;
    Valore:=TNomeValore(APersistent).Valore;
  end
  else
    inherited Assign(APersistent);
end;

function TNomeValore.ToString: String;
begin
  Result:=Format('%s %s',[Nome,Valore]);
end;

{ TRangePeriodo }

constructor TRangePeriodo.Create(PMin, PMax: TDateTime);
begin
  Min:=PMin;
  Max:=PMax;
end;

procedure TRangePeriodo.Assign(APersistent: TPersistent);
begin
  if APersistent is TRangePeriodo then
  begin
    Min:=TRangePeriodo(APersistent).Min;
    Max:=TRangePeriodo(APersistent).Max;
  end
  else
    inherited Assign(APersistent);
end;

procedure TRangePeriodo.Clear;
begin
  Min:=DATE_NULL;
  Max:=DATE_NULL;
end;

function TRangePeriodo.ToString: String;
begin
  Result:=Format('%s - %s',[FormatDateTime('mmmm yyyy',Min),FormatDateTime('mmmm yyyy',Max)]);
end;

{ TParametriServizi }

constructor TParametriServizi.Create;
begin
  Clear;
end;

destructor TParametriServizi.Destroy;
var
  i: Integer;
begin
  Clear;
  inherited;
end;

procedure TParametriServizi.Clear;
var i:Integer;
begin
  for i:=High(CodiciT950) downto Low(CodiciT950) do
    FreeAndNil(CodiciT950[i]);
  SetLength(CodiciT950,0);

  DataUltimoCedolinoChiuso:=DATE_NULL;
end;

procedure TParametriServizi.Assign(APersistent: TPersistent);
var
  i: Integer;
begin
  if APersistent is TParametriServizi then
  begin
    Clear;
    SetLength(CodiciT950,Length(TParametriServizi(APersistent).CodiciT950));
    for i:=Low(CodiciT950) to High(CodiciT950) do
    begin
      CodiciT950[i]:=TNomeValore.Create('','');
      CodiciT950[i].Assign(TParametriServizi(APersistent).CodiciT950[i]);
    end;

    DataUltimoCedolinoChiuso:=TParametriServizi(APersistent).DataUltimoCedolinoChiuso;
  end
  else
    inherited Assign(APersistent);
end;

function TParametriServizi.ToString: String;
begin
  Result:=inherited;
end;

{ TDatiAnagraficiUtente }

procedure TDatiAnagraficiUtente.Clear;
begin
  Progressivo:=0;
  Matricola:='';
  Nome:='';
  Cognome:='';
  Sesso:='';
  CodFiscale:='';
  DataNascita:=DATE_NULL;
end;

procedure TDatiAnagraficiUtente.Assign(APersistent: TPersistent);
begin
  if APersistent is TDatiAnagraficiUtente then
  begin
    Progressivo:=TDatiAnagraficiUtente(APersistent).Progressivo;
    Matricola:=TDatiAnagraficiUtente(APersistent).Matricola;
    Nome:=TDatiAnagraficiUtente(APersistent).Nome;
    Cognome:=TDatiAnagraficiUtente(APersistent).Cognome;
    Sesso:=TDatiAnagraficiUtente(APersistent).Sesso;
    CodFiscale:=TDatiAnagraficiUtente(APersistent).CodFiscale;
    DataNascita:=TDatiAnagraficiUtente(APersistent).DataNascita;
  end
  else
    inherited Assign(APersistent);
end;

function TDatiAnagraficiUtente.ToString: String;
begin
  Result:=Format('Progressivo = %d',[Progressivo]) + #13#10 +
          Format('Matricola = %s',[Matricola]) + #13#10 +
          Format('Nome = %s',[Nome]) + #13#10 +
          Format('Cognome = %s',[Cognome]) + #13#10 +
          Format('Sesso = %s',[Sesso]) + #13#10 +
          Format('CodFiscale = %s',[CodFiscale]) + #13#10 +
          Format('DataNascita = %s',[FormatDateTime('dd/mm/yyyy',DataNascita)]) + #13#10;
end;

{ TOutputRichieste }

procedure TOutputRichieste.Assign(APersistent: TPersistent);
begin
  if APersistent is TOutputRichieste then
  begin
    RichiesteTotali:=TOutputRichieste(APersistent).RichiesteTotali;
    C018Revocabile:=TOutputRichieste(APersistent).C018Revocabile;
  end
  else
    inherited Assign(APersistent);
end;

function TOutputRichieste.ToString: String;
begin
  Result:=inherited;
end;

{ TOutputCedolini }

procedure TOutputCedolini.Assign(APersistent: TPersistent);
begin
  if APersistent is TOutputCedolini then
  begin
    NumeroCedolini:=TOutputCedolini(APersistent).NumeroCedolini;
  end
  else
    inherited Assign(APersistent);
end;

function TOutputCedolini.ToString: String;
begin
  Result:=inherited;
end;

{ TAbilitazioneFunzione }


constructor TAbilitazioneFunzione.Create(PTag: Integer; PAbilitazione: String);
begin
  Tag:=PTag;
  Abilitazione:=PAbilitazione;
end;

procedure TAbilitazioneFunzione.Assign(APersistent: TPersistent);
begin
  if APersistent is TAbilitazioneFunzione then
  begin
    Tag:=TAbilitazioneFunzione(APersistent).Tag;
    Abilitazione:=TAbilitazioneFunzione(APersistent).Abilitazione;
  end
  else
    inherited Assign(APersistent);
end;

function TAbilitazioneFunzione.ToString: String;
begin
  Result:=Format('%d: %s',[Tag,Abilitazione]);
end;

{ TNoteLivello }

procedure TNoteLivello.Assign(APersistent: TPersistent);
begin
  if APersistent is TNoteLivello then
  begin
    Livello:=TNoteLivello(APersistent).Livello;
    DescLivello:=TNoteLivello(APersistent).DescLivello;
    Note:=TNoteLivello(APersistent).Note;
    Autorizzazione:=TNoteLivello(APersistent).Autorizzazione;
    AutorizzAutomatica:=TNoteLivello(APersistent).AutorizzAutomatica;
    Nominativo:=TNoteLivello(APersistent).Nominativo;
  end
  else
    inherited Assign(APersistent);
end;

function TNoteLivello.ToString: String;
begin
  Result:=Format('Livello %d'#13#10 +
                 'Autorizzazione: %s'#13#10 +
                 '%s',
                 [Livello,Autorizzazione,Note]);
end;

function TNoteLivello.Check: TResCtrl;
begin
  Result.Clear;

  // verifica livello
  if Livello <= 0 then
  begin
    Result.Messaggio:=Format('Il livello indicato non è valido: %d',[Livello]);
    Exit;
  end;

  // controlli ok
  Result.Ok:=True;
end;

function TNoteLivello.Clone: TNoteLivello;
begin
  Result:=TNoteLivello.Create;
  Result.Livello:=Self.Livello;
  Result.DescLivello:=Self.DescLivello;
  Result.Note:=Self.Note;
  Result.Autorizzazione:=Self.Autorizzazione;
  Result.AutorizzAutomatica:=Self.AutorizzAutomatica;
  Result.Nominativo:=Self.Nominativo;
end;

function TNoteLivello.GetAutorizzazione: String;
// riporta lo stato di autorizzazione
begin
  if Livello = 0 then
  begin
    Result:='';
  end
  else
  begin
    if (Autorizzazione = 'S') or (Autorizzazione = 'Si') then
      Result:='Autorizzata'
    else if (Autorizzazione = 'N') or (Autorizzazione = 'No') then
      Result:='Negata'
    else
      Result:='Da autorizzare';
  end;
end;

function TNoteLivello.GetDescLivello: String;
begin
  if Livello = 0 then
    Result:='Richiedente'
  else
    Result:=IfThen(DescLivello.Trim = '',
                   Format('Autorizzazione livello %d',[Livello]),
                   DescLivello);
end;

function TNoteLivello.GetIntestazione: String;
begin
  Result:=Format('%s: %s',[GetDescLivello,Nominativo]);
end;

function TNoteLivello.GetNoteVis: String;
begin
  if Note = '' then
    Result:='(nessuna nota)'
  else
    Result:=Note;
end;

{ TOutputRiepilogoAssenze }

procedure TOutputRiepilogoAssenze.Assign(APersistent: TPersistent);
begin
  if APersistent is TOutputRiepilogoAssenze then
  begin
    Data:=TOutputRiepilogoAssenze(APersistent).Data;
    CausaleCod:=TOutputRiepilogoAssenze(APersistent).CausaleCod;
    CausaleDesc:=TOutputRiepilogoAssenze(APersistent).CausaleDesc;
    UMisura:=TOutputRiepilogoAssenze(APersistent).UMisura;
    UMisuraDesc:=TOutputRiepilogoAssenze(APersistent).UMisuraDesc;
    CompPrec:=TOutputRiepilogoAssenze(APersistent).CompPrec;
    CompCorr:=TOutputRiepilogoAssenze(APersistent).CompCorr;
    CompTot:=TOutputRiepilogoAssenze(APersistent).CompTot;
    FruitoPrec:=TOutputRiepilogoAssenze(APersistent).FruitoPrec;
    FruitoCorr:=TOutputRiepilogoAssenze(APersistent).FruitoCorr;
    FruitoTot:=TOutputRiepilogoAssenze(APersistent).FruitoTot;
    FruitoRich:=TOutputRiepilogoAssenze(APersistent).FruitoRich;
    FruitoAut:=TOutputRiepilogoAssenze(APersistent).FruitoAut;
    ResiduoPrec:=TOutputRiepilogoAssenze(APersistent).ResiduoPrec;
    ResiduoCorr:=TOutputRiepilogoAssenze(APersistent).ResiduoCorr;
    Residuo:=TOutputRiepilogoAssenze(APersistent).Residuo;
  end
  else
    inherited Assign(APersistent);
end;

function TOutputRiepilogoAssenze.ToString: String;
begin
  Result:=
    Format('Data = %d',[Data]) + #13#10 +
    Format('CausaleCod = %s',[CausaleCod]) + #13#10 +
    Format('CausaleDesc = %s',[CausaleDesc]) + #13#10 +
    Format('UMisura = %s',[UMisura]) + #13#10 +
    Format('UMisuraDesc = %s',[UMisuraDesc]) + #13#10 +
    Format('CompPrec = %f',[CompPrec]) + #13#10 +
    Format('CompCorr = %f',[CompCorr]) + #13#10 +
    Format('CompTot = %f',[CompTot]) + #13#10 +
    Format('FruitoPrec = %f',[FruitoPrec]) + #13#10 +
    Format('FruitoCorr = %f',[FruitoCorr]) + #13#10 +
    Format('FruitoTot = %f',[FruitoTot]) + #13#10 +
    Format('FruitoRich = %f',[FruitoRich]) + #13#10 +
    Format('FruitoAut = %f',[FruitoAut]) + #13#10 +
    Format('ResiduoPrec = %f',[ResiduoPrec]) + #13#10 +
    Format('ResiduoCorr = %f',[ResiduoCorr]) + #13#10 +
    Format('Residuo = %f',[Residuo]) + #13#10;
end;

{ TNoteRichiesta }

procedure TNoteRichiesta.Assign(APersistent: TPersistent);
var
  i: Integer;
begin
  if APersistent is TNoteRichiesta then
  begin
    // array note
    for i:=Low(NoteArr) to High(NoteArr) do
      FreeAndNil(NoteArr[i]);

    SetLength(NoteArr,Length(TNoteRichiesta(APersistent).NoteArr));
    for i:=Low(NoteArr) to High(NoteArr) do
    begin
      NoteArr[i]:=TNoteLivello.Create;
      NoteArr[i].Assign(TNoteRichiesta(APersistent).NoteArr[i]);
    end;
  end
  else
    inherited Assign(APersistent);
end;

constructor TNoteRichiesta.Create;
begin
  SetLength(NoteArr, 0);
end;

destructor TNoteRichiesta.Destroy;
var i: Integer;
begin
  for i:=Low(NoteArr) to High(NoteArr) do
    FreeAndNil(NoteArr[i]);
  SetLength(NoteArr, 0);
  inherited;
end;

function TNoteRichiesta.ToString: String;
var
  i: Integer;
  LNoteLiv: TNoteLivello;
begin
  Result:='';
  for i:=Low(NoteArr) to High(NoteArr) do
  begin
    LNoteLiv:=NoteArr[i];
    Result:=Result +
            Format('%s %s'#13#10'%s'#13#10#13#10,
                   [LNoteLiv.Nominativo,
                    IfThen(LNoteLiv.Autorizzazione = '','',IfThen(LNoteLiv.Autorizzazione = 'S','(Sì)','(No)')),
                    IfThen(LNoteLiv.Note = '','(nessuna nota)',LNoteLiv.Note)
                   ]);
  end;
end;

{ TOutputDatiGiornalieri }

procedure TOutputDatiGiornalieri.Assign(APersistent: TPersistent);
var i:Integer;
begin
  if APersistent is TOutputDatiGiornalieri then
  begin
    Data:=TOutputDatiGiornalieri(APersistent).Data;
    TimbNominali:=TOutputDatiGiornalieri(APersistent).TimbNominali;
    DebitoGG:=TOutputDatiGiornalieri(APersistent).DebitoGG;
    ResoGG:=TOutputDatiGiornalieri(APersistent).ResoGG;
    SaldoGG:=TOutputDatiGiornalieri(APersistent).SaldoGG;
    OreEscluseGG:=TOutputDatiGiornalieri(APersistent).OreEscluseGG;
    Timbrature:=TOutputDatiGiornalieri(APersistent).Timbrature;
    Giustificativi:=TOutputDatiGiornalieri(APersistent).Giustificativi;
    TurniReperibilita:=TOutputDatiGiornalieri(APersistent).TurniReperibilita;

    SetLength(lstTimbrature,Length(TOutputDatiGiornalieri(APersistent).lstTimbrature));
    for i:=0 to High(lstTimbrature) do
      lstTimbrature[i]:=TOutputDatiGiornalieri(APersistent).lstTimbrature[i];

    SetLength(lstGiustificativi,Length(TOutputDatiGiornalieri(APersistent).lstGiustificativi));
    for i:=0 to High(lstGiustificativi) do
      lstGiustificativi[i]:=TOutputDatiGiornalieri(APersistent).lstGiustificativi[i];

    SetLength(lstAnomalie,Length(TOutputDatiGiornalieri(APersistent).lstAnomalie));
    for i:=0 to High(lstAnomalie) do
      lstAnomalie[i]:=TOutputDatiGiornalieri(APersistent).lstAnomalie[i];
  end
  else
    inherited Assign(APersistent);
end;

procedure TOutputDatiGiornalieri.Clear;
begin
  SetLength(lstAnomalie,0);
  SetLength(lstTimbrature,0);
  SetLength(lstGiustificativi,0);
  TimbNominali:='';
  TurniReperibilita:='';
  DebitoGG:='';
  ResoGG:='';
  SaldoGG:='';
  OreEscluseGG:='';
  Timbrature:='';
  Giustificativi:='';
end;

constructor TOutputDatiGiornalieri.Create;
begin
  inherited;
  SetLength(lstAnomalie,0);
  SetLength(lstTimbrature,0);
  SetLength(lstGiustificativi,0);
end;

destructor TOutputDatiGiornalieri.Destroy;
begin
  SetLength(lstAnomalie,0);
  SetLength(lstTimbrature,0);
  SetLength(lstGiustificativi,0);
  inherited;
end;

function TOutputDatiGiornalieri.ToString: String;
begin
  Result:='';
end;

{ TOutputElencoDipendenti }

procedure TOutputElencoDipendenti.Assign(APersistent: TPersistent);
begin
  if APersistent is TOutputElencoDipendenti then
  begin
    NumeroDipendenti:=TOutputElencoDipendenti(APersistent).NumeroDipendenti;
    DisplayLabels:=TOutputElencoDipendenti(APersistent).DisplayLabels;
    VisibleFields:=TOutputElencoDipendenti(APersistent).VisibleFields;
  end
  else
    inherited Assign(APersistent);
end;

function TOutputElencoDipendenti.ToString: String;
begin
  Result:=Format('dipendenti: %d',[NumeroDipendenti]) + #13#10 +
          Format('DisplayLabels: %s',[DisplayLabels]) + #13#10 +
          Format('VisibleFields: %s',[VisibleFields]);
end;

{ TOutputCartellini }

procedure TOutputCartellini.Assign(APersistent: TPersistent);
begin
  inherited;
  if APersistent is TOutputCartellini then
  begin
    NumeroCartellini:=TOutputCartellini(APersistent).NumeroCartellini;
  end
  else
    inherited Assign(APersistent);
end;

function TOutputCartellini.ToString: String;
begin
  inherited;
end;

{ TFiltriRichieste }

constructor TFiltriRichieste.Create;
begin
  inherited;
end;

constructor TFiltriRichieste.Create(PFiltroVis: String; PPeriodoDa,
  PPeriodoA, PPeriodoOrigDa, PPeriodoOrigA: TDateTime; PLimiteRecord: Integer);
begin
  Create;

  FiltroVis:=PFiltroVis;
  PeriodoDa:=PPeriodoDa;
  PeriodoA:=PPeriodoA;
  PeriodoDaOriginale:=PPeriodoOrigDa;
  PeriodoAOriginale:=PPeriodoOrigA;
  LimiteRecord:=PLimiteRecord;
end;

constructor TFiltriRichieste.Create(PFiltroVis: String; PPeriodoDa,
  PPeriodoA: TDateTime; PLimiteRecord: Integer);
begin
  Create(PFiltroVis,PPeriodoDa,PPeriodoA,DATE_NULL,DATE_NULL,PLimiteRecord);
end;

procedure TFiltriRichieste.Assign(APersistent: TPersistent);
begin
  if APersistent is TFiltriRichieste then
  begin
    FiltroVis:=TFiltriRichieste(APersistent).FiltroVis;
    PeriodoDa:=TFiltriRichieste(APersistent).PeriodoDa;
    PeriodoA:=TFiltriRichieste(APersistent).PeriodoA;
    PeriodoDaOriginale:=TFiltriRichieste(APersistent).PeriodoDaOriginale;
    PeriodoAOriginale:=TFiltriRichieste(APersistent).PeriodoAOriginale;
    LimiteRecord:=TFiltriRichieste(APersistent).LimiteRecord;
  end
  else
    inherited Assign(APersistent);
end;

function TFiltriRichieste.Clone: TFiltriRichieste;
begin
  Result:=TFiltriRichieste.Create;
  Result.Assign(Self);
end;

{ TInfoVersioneSW }

constructor TInfoVersioneSW.Create(PVersione, PBuild: String);
begin
  Versione:=PVersione;
  Build:=PBuild;
end;

function TInfoVersioneSW.Equals(Obj: TObject): Boolean;
begin
  Result:=(Obj is TInfoVersioneSW) and
          (Versione = TInfoVersioneSW(Obj).Versione) and
          (Build = TInfoVersioneSW(Obj).Build);
end;

procedure TInfoVersioneSW.Assign(APersistent: TPersistent);
begin
  if APersistent is TInfoVersioneSW then
  begin
    Versione:=TInfoVersioneSW(APersistent).Versione;
    Build:=TInfoVersioneSW(APersistent).Build;
  end
  else
    inherited Assign(APersistent);
end;

procedure TInfoVersioneSW.Clear;
begin
  Versione:='';
  Build:='';
end;

function TInfoVersioneSW.Clone: TInfoVersioneSW;
begin
  Result:=TInfoVersioneSW.Create;
  Result.Assign(Self);
end;

function TInfoVersioneSW.ToString: String;
begin
  Result:=Format('%s(%s)',[Versione,Build]);
end;

{ TInfoClient }

constructor TInfoClient.Create(PVersione, PBuild, PVersioneCompatibile, PBuildCompatibile: String);
begin
  Create;
  VersioneApp:=TInfoVersioneSW.Create(PVersione,PBuild);
  VersioneAppCompatibile:=TInfoVersioneSW.Create(PVersioneCompatibile,PBuildCompatibile);
end;

destructor TInfoClient.Destroy;
begin
  try FreeAndNil(VersioneApp); except end;
  try FreeAndNil(VersioneAppCompatibile); except end;
  inherited;
end;

procedure TInfoClient.Assign(APersistent: TPersistent);
begin
  if APersistent is TInfoClient then
  begin
    VersioneApp:=TInfoVersioneSW.Create;
    VersioneApp.Assign(TInfoClient(APersistent).VersioneApp);
  end
  else
    inherited Assign(APersistent);
end;

function TInfoClient.Clone: TInfoClient;
begin
  Result:=TInfoClient.Create;
  Result.Assign(Self);
end;

function TInfoClient.PrepareForServer: TInfoClient;
begin
  // clona per passaggio al server
  Result:=Self.Clone;
end;

{ TOutputInsRichieste }

procedure TOutputInsRichiesta.Assign(APersistent: TPersistent);
begin
  if APersistent is TOutputInsRichiesta then
  begin
    RisposteMsg:=TOutputInsRichiesta(APersistent).RisposteMsg;
  end
  else
    inherited Assign(APersistent);
end;

procedure TOutputInsRichiesta.Clear;
begin
  RisposteMsg.Clear;
end;

constructor TOutputInsRichiesta.Create;
begin
  inherited;
  RisposteMsg:=TRisposteMsg.Create;
end;

destructor TOutputInsRichiesta.Destroy;
begin
  FreeAndNil(RisposteMsg);
  inherited;
end;

function TOutputInsRichiesta.ToString: String;
begin
  Result:='';
end;

{ TTipoServerRecHelper }

function TTipoServerRecHelper.ToString: string;
begin
  case Self of
    TTipoServerRec.Mondoedp:
      Result:='server MondoEdp';
    TTipoServerRec.Aziendale:
      Result:='server aziendale';
  else
    Result:='server non definito';
  end;
end;

{ TDatiDipendenti }

procedure TDatiDipendenti.Assign(APersistent: TPersistent);
begin
  if APersistent is TDatiDipendenti then
  begin
    NumDipendenti:=TDatiDipendenti(APersistent).NumDipendenti;
    NumDipendentiDiversiDaProgressivo:=TDatiDipendenti(APersistent).NumDipendentiDiversiDaProgressivo;
  end
  else
    inherited Assign(APersistent);
end;

procedure TDatiDipendenti.Clear;
begin
  NumDipendenti:=0;
  NumDipendentiDiversiDaProgressivo:=0;
end;

constructor TDatiDipendenti.Create;
begin
  Clear;
end;

destructor TDatiDipendenti.Destroy;
begin
  //
  inherited;
end;

function TDatiDipendenti.ToString: String;
begin
  Result:=Format('NumDipendenti = %s, NumDipendentiDiversiDaProgressivo = %d',
                 [NumDipendenti,
                  NumDipendentiDiversiDaProgressivo]);
end;

{ TOutputTimbrature }

procedure TOutputTimbrature.Assign(APersistent: TPersistent);
begin
  inherited;
end;

function TOutputTimbrature.ToString: String;
begin
  Result:='';
end;

{ TOutputDizionario }

procedure TOutputDizionario.Assign(APersistent: TPersistent);
begin
  inherited;
end;

function TOutputDizionario.ToString: String;
begin
  Result:='';
end;

{ TParamMobile }

procedure TParamMobile.Assign(APersistent: TPersistent);
var i:Integer;
begin
  if APersistent is TParamMobile then
  begin
    //dati non ancora gestiti:
      //RegolePassword:=TParamMobile(APersistent).RegolePassword;
      //cdsI015:=TParamMobile(APersistent).cdsI015;
      //Inibizioni:=TParamMobile(APersistent).Inibizioni;
      //NomiTabelleLog:=TParamMobile(APersistent).NomiTabelleLog;
      //ColonneStruttura:=TParamMobile(APersistent).ColonneStruttura;
      //TipiStruttura:=TParamMobile(APersistent).TipiStruttura;
    CampiRiferimento:=TParamMobile(APersistent).CampiRiferimento;
    SetLength(AbilitazioniFunzioni,Length(TParamMobile(APersistent).AbilitazioniFunzioni));
    for i:=0 to High(TParamMobile(APersistent).AbilitazioniFunzioni) do
      AbilitazioniFunzioni[i]:=TParamMobile(APersistent).AbilitazioniFunzioni[i];
    SetLength(FiltroDizionario,Length(TParamMobile(APersistent).FiltroDizionario));
    for i:=0 to High(TParamMobile(APersistent).FiltroDizionario) do
      FiltroDizionario:=TParamMobile(APersistent).FiltroDizionario;
    HostName:=TParamMobile(APersistent).HostName;
    HostIPAddress:=TParamMobile(APersistent).HostIPAddress;
    ClientIPInfo:=TParamMobile(APersistent).ClientIPInfo;
    Path:=TParamMobile(APersistent).Path;
    VersioneOracle:=TParamMobile(APersistent).VersioneOracle;
    TimeSeparatorDef:=TParamMobile(APersistent).TimeSeparatorDef;
    Applicazione:=TParamMobile(APersistent).Applicazione;
    Azienda:=TParamMobile(APersistent).Azienda;
    DAzienda:=TParamMobile(APersistent).DAzienda;
    RagioneSociale:=TParamMobile(APersistent).RagioneSociale;
    Alias:=TParamMobile(APersistent).Alias;
    Username:=TParamMobile(APersistent).Username;
    Password:=TParamMobile(APersistent).Password;
    PasswordMondoEDP:=TParamMobile(APersistent).PasswordMondoEDP;
    Operatore:=TParamMobile(APersistent).Operatore;
    ProfiloWEB:=TParamMobile(APersistent).ProfiloWEB;
    ProfiloFiltroPermessi:=TParamMobile(APersistent).ProfiloFiltroPermessi;
    ProfiloFiltroAnagrafe:=TParamMobile(APersistent).ProfiloFiltroAnagrafe;
    ProfiloFiltroFunzioni:=TParamMobile(APersistent).ProfiloFiltroFunzioni;
    ProfiloFiltroDizionario:=TParamMobile(APersistent).ProfiloFiltroDizionario;
    TipoOperatore:=TParamMobile(APersistent).TipoOperatore;
    ProfiloWEBDelegatoDa:=TParamMobile(APersistent).ProfiloWEBDelegatoDa;
    ProfiloWEBIterAutorizzativi:=TParamMobile(APersistent).ProfiloWEBIterAutorizzativi;
    PassOper:=TParamMobile(APersistent).PassOper;
    ProgressivoOper:=TParamMobile(APersistent).ProgressivoOper;
    MatricolaOper:=TParamMobile(APersistent).MatricolaOper;
    CodFiscaleOper:=TParamMobile(APersistent).CodFiscaleOper;
    AuthDom:=TParamMobile(APersistent).AuthDom;
    AuthDomInfo:=TParamMobile(APersistent).AuthDomInfo;
    LogTabelle:=TParamMobile(APersistent).LogTabelle;
    Database:=TParamMobile(APersistent).Database;
    NomePJ:=TParamMobile(APersistent).NomePJ;
    VersionePJ:=TParamMobile(APersistent).VersionePJ;
    BuildPJ:=TParamMobile(APersistent).BuildPJ;
    DataPJ:=TParamMobile(APersistent).DataPJ;
    VersioneDB:=TParamMobile(APersistent).VersioneDB;
    BuildDB:=TParamMobile(APersistent).BuildDB;
    DBUnicode:=TParamMobile(APersistent).DBUnicode;
    TimbOrig_Verso:=TParamMobile(APersistent).TimbOrig_Verso;
    TimbOrig_Causale:=TParamMobile(APersistent).TimbOrig_Causale;
    ValiditaPassword:=TParamMobile(APersistent).ValiditaPassword;
    LunghezzaPassword:=TParamMobile(APersistent).LunghezzaPassword;
    GruppoBadge:=TParamMobile(APersistent).GruppoBadge;
    ValiditaUtente:=TParamMobile(APersistent).ValiditaUtente;
    ValiditaCessati:=TParamMobile(APersistent).ValiditaCessati;
    ProgOper:=TParamMobile(APersistent).ProgOper;
    OperBloc:=TParamMobile(APersistent).OperBloc;
    V430:=TParamMobile(APersistent).V430;
    Lingua:=TParamMobile(APersistent).Lingua;
    IntegrazioneAnagrafe:=TParamMobile(APersistent).IntegrazioneAnagrafe;
    CodiceIntegrazione:=TParamMobile(APersistent).CodiceIntegrazione;
    CodContrattoVoci:=TParamMobile(APersistent).CodContrattoVoci;
    T040_Validazione:=TParamMobile(APersistent).T040_Validazione;
    T100_Ora:=TParamMobile(APersistent).T100_Ora;
    T100_Rilevatore:=TParamMobile(APersistent).T100_Rilevatore;
    T100_Causale:=TParamMobile(APersistent).T100_Causale;
    T100_CancTimbOrig:=TParamMobile(APersistent).T100_CancTimbOrig;
    CancellaTimbrature:=TParamMobile(APersistent).CancellaTimbrature;
    InserisciTimbrature:=TParamMobile(APersistent).InserisciTimbrature;
    AbilitaSchedeChiuse:=TParamMobile(APersistent).AbilitaSchedeChiuse;
    A029_Saldi:=TParamMobile(APersistent).A029_Saldi;
    A029_Indennita:=TParamMobile(APersistent).A029_Indennita;
    A029_Straordinario:=TParamMobile(APersistent).A029_Straordinario;
    A029_CauPresenza:=TParamMobile(APersistent).A029_CauPresenza;
    A037_EliminaDataCassa:=TParamMobile(APersistent).A037_EliminaDataCassa;
    A037_RicreaScaricoPaghe:=TParamMobile(APersistent).A037_RicreaScaricoPaghe;
    A058_PianifOperativa:=TParamMobile(APersistent).A058_PianifOperativa;
    A058_PianifNonOperativa:=TParamMobile(APersistent).A058_PianifNonOperativa;
    A094_Mese:=TParamMobile(APersistent).A094_Mese;
    A094_Anno:=TParamMobile(APersistent).A094_Anno;
    A094_Raggr:=TParamMobile(APersistent).A094_Raggr;
    LiquidazioneForzata:=TParamMobile(APersistent).LiquidazioneForzata;
    Layout:=TParamMobile(APersistent).Layout;
    Storicizzazione:=TParamMobile(APersistent).Storicizzazione;
    ModificaDecorrenza:=TParamMobile(APersistent).ModificaDecorrenza;
    EliminaStorici:=TParamMobile(APersistent).EliminaStorici;
    InserimentoMatricole:=TParamMobile(APersistent).InserimentoMatricole;
    DefTipoPersonale:=TParamMobile(APersistent).DefTipoPersonale;
    ModPersonaleEsterno:=TParamMobile(APersistent).ModPersonaleEsterno;
    RipristinoTimbOri:=TParamMobile(APersistent).RipristinoTimbOri;
    AggiornamentoBaseDati:=TParamMobile(APersistent).AggiornamentoBaseDati;
    MonitorIntegrAnagra:=TParamMobile(APersistent).MonitorIntegrAnagra;
    C700_SalvaSelezioni:=TParamMobile(APersistent).C700_SalvaSelezioni;
    DatiC700:=TParamMobile(APersistent).DatiC700;
    ApplicativiDisponibili:=TParamMobile(APersistent).ApplicativiDisponibili;
    ModuliInstallati:=TParamMobile(APersistent).ModuliInstallati;
    DataLavoro:=TParamMobile(APersistent).DataLavoro;
    TSLavoro:=TParamMobile(APersistent).TSLavoro;
    TSIndici:=TParamMobile(APersistent).TSIndici;
    TSAusiliario:=TParamMobile(APersistent).TSAusiliario;
    FileAnomalie:=TParamMobile(APersistent).FileAnomalie;
    CampiAnagraficiNonVisibili:=TParamMobile(APersistent).CampiAnagraficiNonVisibili;
    A131_AnticipiGestibili:=TParamMobile(APersistent).A131_AnticipiGestibili;
    I035_ModificaAbbinamenti:=TParamMobile(APersistent).I035_ModificaAbbinamenti;
    InibizioneIndividuale:=TParamMobile(APersistent).InibizioneIndividuale;
    UseStandardPrinter:=TParamMobile(APersistent).UseStandardPrinter;
    A139_ServiziComandati:=TParamMobile(APersistent).A139_ServiziComandati;
    A139_ServiziBlocco:=TParamMobile(APersistent).A139_ServiziBlocco;
    A139_ServiziSblocco:=TParamMobile(APersistent).A139_ServiziSblocco;
    S710_SupervisoreValut:=TParamMobile(APersistent).S710_SupervisoreValut;
    S710_ModValutatore:=TParamMobile(APersistent).S710_ModValutatore;
    S710_ValidaStato:=TParamMobile(APersistent).S710_ValidaStato;
    WEBIterAssGGPrec:=TParamMobile(APersistent).WEBIterAssGGPrec;
    WEBIterAssGGSucc:=TParamMobile(APersistent).WEBIterAssGGSucc;
    WEBIterTimbGGPrec:=TParamMobile(APersistent).WEBIterTimbGGPrec;
    WEBCartelliniDataMin:=TParamMobile(APersistent).WEBCartelliniDataMin;
    WEBCartelliniMMPrec:=TParamMobile(APersistent).WEBCartelliniMMPrec;
    WEBCartelliniMMSucc:=TParamMobile(APersistent).WEBCartelliniMMSucc;
    WEBCartelliniChiusi:=TParamMobile(APersistent).WEBCartelliniChiusi;
    WEBCedoliniDataMin:=TParamMobile(APersistent).WEBCedoliniDataMin;
    WEBCedoliniMMPrec:=TParamMobile(APersistent).WEBCedoliniMMPrec;
    WEBCedoliniGGEmiss:=TParamMobile(APersistent).WEBCedoliniGGEmiss;
    WEBCedoliniFilePDF:=TParamMobile(APersistent).WEBCedoliniFilePDF;
    ModificaDatiProtetti:=TParamMobile(APersistent).ModificaDatiProtetti;
    WEBRichiestaConsegnaCed:=TParamMobile(APersistent).WEBRichiestaConsegnaCed;
    WEBRegistraConsegnaVal:=TParamMobile(APersistent).WEBRegistraConsegnaVal;
    I060_Password:=TParamMobile(APersistent).I060_Password;
    I070_Password:=TParamMobile(APersistent).I070_Password;
  end
  else
    inherited Assign(APersistent);
end;

procedure TParamMobile.AssignParametri(Parametri: TParametri);
var i:Integer;
begin
  //Dati non ancora gestiti:
    //RegolePassword:=TParamMobile(APersistent).RegolePassword;
    //cdsI015:=TParamMobile(APersistent).cdsI015;
    //Inibizioni:=TParamMobile(APersistent).Inibizioni;
    //NomiTabelleLog:=TParamMobile(APersistent).NomiTabelleLog;
    //ColonneStruttura:=TParamMobile(APersistent).ColonneStruttura;
    //TipiStruttura:=TParamMobile(APersistent).TipiStruttura;

  // imposta i soli campi riferimento mobile
  CampiRiferimento.AssignParametri(Parametri.CampiRiferimento);

  SetLength(AbilitazioniFunzioni,Length(Parametri.AbilitazioniFunzioni));
  for i:=0 to High(Parametri.AbilitazioniFunzioni) do
    AbilitazioniFunzioni[i]:=Parametri.AbilitazioniFunzioni[i];
  SetLength(FiltroDizionario,Length(Parametri.FiltroDizionario));
  for i:=0 to High(Parametri.FiltroDizionario) do
    FiltroDizionario[i]:=Parametri.FiltroDizionario[i];
  HostName:=Parametri.HostName;
  HostIPAddress:=Parametri.HostIPAddress;
  ClientIPInfo:=Parametri.ClientIPInfo;
  Path:=Parametri.Path;
  VersioneOracle:=Parametri.VersioneOracle;
  TimeSeparatorDef:=Parametri.TimeSeparatorDef;
  Applicazione:=Parametri.Applicazione;
  Azienda:=Parametri.Azienda;
  DAzienda:=Parametri.DAzienda;
  RagioneSociale:=Parametri.RagioneSociale;
  Alias:=Parametri.Alias;
  Username:=Parametri.Username;
  Password:=Parametri.Password;
  PasswordMondoEDP:=Parametri.PasswordMondoEDP;
  Operatore:=Parametri.Operatore;
  ProfiloWEB:=Parametri.ProfiloWEB;
  ProfiloFiltroPermessi:=Parametri.ProfiloFiltroPermessi;
  ProfiloFiltroAnagrafe:=Parametri.ProfiloFiltroAnagrafe;
  ProfiloFiltroFunzioni:=Parametri.ProfiloFiltroFunzioni;
  ProfiloFiltroDizionario:=Parametri.ProfiloFiltroDizionario;
  TipoOperatore:=Parametri.TipoOperatore;
  ProfiloWEBDelegatoDa:=Parametri.ProfiloWEBDelegatoDa;
  ProfiloWEBIterAutorizzativi:=Parametri.ProfiloWEBIterAutorizzativi;
  PassOper:=Parametri.PassOper;
  ProgressivoOper:=Parametri.ProgressivoOper;
  MatricolaOper:=Parametri.MatricolaOper;
  CodFiscaleOper:=Parametri.CodFiscaleOper;
  AuthDom:=Parametri.AuthDom;
  AuthDomInfo:=Parametri.AuthDomInfo;
  LogTabelle:=Parametri.LogTabelle;
  Database:=Parametri.Database;
  NomePJ:=Parametri.NomePJ;
  VersionePJ:=Parametri.VersionePJ;
  BuildPJ:=Parametri.BuildPJ;
  DataPJ:=Parametri.DataPJ;
  VersioneDB:=Parametri.VersioneDB;
  BuildDB:=Parametri.BuildDB;
  DBUnicode:=Parametri.DBUnicode;
  TimbOrig_Verso:=Parametri.TimbOrig_Verso;
  TimbOrig_Causale:=Parametri.TimbOrig_Causale;
  ValiditaPassword:=Parametri.ValiditaPassword;
  LunghezzaPassword:=Parametri.LunghezzaPassword;
  GruppoBadge:=Parametri.GruppoBadge;
  ValiditaUtente:=Parametri.ValiditaUtente;
  ValiditaCessati:=Parametri.ValiditaCessati;
  ProgOper:=Parametri.ProgOper;
  OperBloc:=Parametri.OperBloc;
  V430:=Parametri.V430;
  Lingua:=Parametri.Lingua;
  IntegrazioneAnagrafe:=Parametri.IntegrazioneAnagrafe;
  CodiceIntegrazione:=Parametri.CodiceIntegrazione;
  CodContrattoVoci:=Parametri.CodContrattoVoci;
  T040_Validazione:=Parametri.T040_Validazione;
  T100_Ora:=Parametri.T100_Ora;
  T100_Rilevatore:=Parametri.T100_Rilevatore;
  T100_Causale:=Parametri.T100_Causale;
  T100_CancTimbOrig:=Parametri.T100_CancTimbOrig;
  CancellaTimbrature:=Parametri.CancellaTimbrature;
  InserisciTimbrature:=Parametri.InserisciTimbrature;
  AbilitaSchedeChiuse:=Parametri.AbilitaSchedeChiuse;
  A029_Saldi:=Parametri.A029_Saldi;
  A029_Indennita:=Parametri.A029_Indennita;
  A029_Straordinario:=Parametri.A029_Straordinario;
  A029_CauPresenza:=Parametri.A029_CauPresenza;
  A037_EliminaDataCassa:=Parametri.A037_EliminaDataCassa;
  A037_RicreaScaricoPaghe:=Parametri.A037_RicreaScaricoPaghe;
  A058_PianifOperativa:=Parametri.A058_PianifOperativa;
  A058_PianifNonOperativa:=Parametri.A058_PianifNonOperativa;
  A094_Mese:=Parametri.A094_Mese;
  A094_Anno:=Parametri.A094_Anno;
  A094_Raggr:=Parametri.A094_Raggr;
  LiquidazioneForzata:=Parametri.LiquidazioneForzata;
  Layout:=Parametri.Layout;
  Storicizzazione:=Parametri.Storicizzazione;
  ModificaDecorrenza:=Parametri.ModificaDecorrenza;
  EliminaStorici:=Parametri.EliminaStorici;
  InserimentoMatricole:=Parametri.InserimentoMatricole;
  DefTipoPersonale:=Parametri.DefTipoPersonale;
  ModPersonaleEsterno:=Parametri.ModPersonaleEsterno;
  RipristinoTimbOri:=Parametri.RipristinoTimbOri;
  AggiornamentoBaseDati:=Parametri.AggiornamentoBaseDati;
  MonitorIntegrAnagra:=Parametri.MonitorIntegrAnagra;
  C700_SalvaSelezioni:=Parametri.C700_SalvaSelezioni;
  DatiC700:=Parametri.DatiC700;
  ApplicativiDisponibili:=Parametri.ApplicativiDisponibili;
  ModuliInstallati:=Parametri.ModuliInstallati;
  DataLavoro:=Parametri.DataLavoro;
  TSLavoro:=Parametri.TSLavoro;
  TSIndici:=Parametri.TSIndici;
  TSAusiliario:=Parametri.TSAusiliario;
  FileAnomalie:=Parametri.FileAnomalie;
  CampiAnagraficiNonVisibili:=Parametri.CampiAnagraficiNonVisibili;
  A131_AnticipiGestibili:=Parametri.A131_AnticipiGestibili;
  I035_ModificaAbbinamenti:=Parametri.I035_ModificaAbbinamenti;
  InibizioneIndividuale:=Parametri.InibizioneIndividuale;
  UseStandardPrinter:=Parametri.UseStandardPrinter;
  A139_ServiziComandati:=Parametri.A139_ServiziComandati;
  A139_ServiziBlocco:=Parametri.A139_ServiziBlocco;
  A139_ServiziSblocco:=Parametri.A139_ServiziSblocco;
  S710_SupervisoreValut:=Parametri.S710_SupervisoreValut;
  S710_ModValutatore:=Parametri.S710_ModValutatore;
  S710_ValidaStato:=Parametri.S710_ValidaStato;
  WEBIterAssGGPrec:=Parametri.WEBIterAssGGPrec;
  WEBIterAssGGSucc:=Parametri.WEBIterAssGGSucc;
  WEBIterTimbGGPrec:=Parametri.WEBIterTimbGGPrec;
  WEBCartelliniDataMin:=Parametri.WEBCartelliniDataMin;
  WEBCartelliniMMPrec:=Parametri.WEBCartelliniMMPrec;
  WEBCartelliniMMSucc:=Parametri.WEBCartelliniMMSucc;
  WEBCartelliniChiusi:=Parametri.WEBCartelliniChiusi;
  WEBCedoliniDataMin:=Parametri.WEBCedoliniDataMin;
  WEBCedoliniMMPrec:=Parametri.WEBCedoliniMMPrec;
  WEBCedoliniGGEmiss:=Parametri.WEBCedoliniGGEmiss;
  WEBCedoliniFilePDF:=Parametri.WEBCedoliniFilePDF;
  ModificaDatiProtetti:=Parametri.ModificaDatiProtetti;
  WEBRichiestaConsegnaCed:=Parametri.WEBRichiestaConsegnaCed;
  WEBRegistraConsegnaVal:=Parametri.WEBRegistraConsegnaVal;
  I060_Password:=Parametri.I060_Password;
  I070_Password:=Parametri.I070_Password;
end;

constructor TParamMobile.Create;
begin
  //inherited Create;
end;

destructor TParamMobile.Destroy;
begin
  inherited;
end;

function TParamMobile.ToString: String;
begin
  Result:='';
end;

{ TOutputInsTimbratura }

procedure TOutputInsTimbratura.Assign(APersistent: TPersistent);
begin
  if APersistent is TOutputInsTimbratura then
  begin
    RisposteMsg:=TOutputInsTimbratura(APersistent).RisposteMsg;
  end
  else
    inherited Assign(APersistent);
end;

procedure TOutputInsTimbratura.Clear;
begin
  RisposteMsg.Clear;
end;

constructor TOutputInsTimbratura.Create;
begin
  RisposteMsg:=TRisposteMsg.Create;
  Clear;
end;

destructor TOutputInsTimbratura.Destroy;
begin
  FreeAndNil(RisposteMsg);
  inherited;
end;

function TOutputInsTimbratura.ToString: String;
begin
  Result:='';
end;

{ TOutputVersioneServer }

constructor TOutputVersioneServer.Create;
begin
  Versione:=TInfoVersioneSW.Create(VersionePA,BuildPA);
end;

procedure TOutputVersioneServer.Clear;
begin
  Versione.Clear;
end;

function TOutputVersioneServer.Clone: TOutputVersioneServer;
begin
  Result:=TOutputVersioneServer.Create;
  Result.Assign(Self);
end;

procedure TOutputVersioneServer.Assign(APersistent: TPersistent);
begin
  if APersistent is TOutputVersioneServer then
  begin
    if Versione = nil then
      Versione:=TInfoVersioneSW.Create('','');
    Versione.Assign(TOutputVersioneServer(APersistent).Versione);
  end
  else
    inherited Assign(APersistent);
end;

destructor TOutputVersioneServer.Destroy;
begin
  FreeAndNil(Versione);
  inherited;
end;

function TOutputVersioneServer.ToString: String;
begin
  Result:=Versione.ToString;
end;

{ TCampiRiferimentoMobile }

procedure TCampiRiferimentoMobile.AssignParametri(PCampiRiferimento: TCampiRiferimento);
begin
  C23_InsNegCatena:=PCampiRiferimento.C23_InsNegCatena;
  C31_NoteGiustificativi:=PCampiRiferimento.C31_NoteGiustificativi;
  C90_W010CausPres:=PCampiRiferimento.C90_W010CausPres;
  C90_W038Tolleranza_E:=PCampiRiferimento.C90_W038Tolleranza_E;
  C90_W038Tolleranza_U:=PCampiRiferimento.C90_W038Tolleranza_U;
  C90_W038RilevatoreMobile:=PCampiRiferimento.C90_W038RilevatoreMobile;
  C90_W038TimbCausalizzabile:=PCampiRiferimento.C90_W038TimbCausalizzabile;
end;

end.
