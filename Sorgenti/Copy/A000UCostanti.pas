unit A000UCostanti;

interface

uses
  DBXJSONReflect,
  //C200UWebServicesTypes,
  A000Versione, RegolePassword, DBClient,
  SysUtils, System.Classes, StrUtils, UITypes;

type
  TResCtrl = record
    Ok: Boolean;
    Messaggio: String;
    procedure Clear; inline;
  end;

  TDato = record
    Codice: String;
    Descrizione: String;
    procedure Clear; inline;
    function ToString: String; inline;
    function ToComboItem: String; inline;
  end;

  { DONE : TEST IW 14 OK }
  TCampiRiferimento = record//class(TComponent)
  //public
    C1_CedoliniConValuta,
    C2_Budget,
    C2_Capitolo,
    C2_Articolo,
    C2_Costo_Orario,
    C2_WebSrv_Bilancio,
    C2_Livello,
    C2_Facoltativo,
    C3_IndPres,
    C3_IndPres2,
    C3_DatoPianificabile,
    C3_RiepTurni_IndPres,
    C3_DettGG_TipoI,
    C4_BuoniMensa,
    C5_IntegrazAnag,
    C5_Office,
    C6_InizioProva,
    C6_DurataProva,
    C7_Dato1,
    C7_Dato2,
    C7_Dato3,
    C7_InizioSospensione,
    C7_EscludeIncentivo,
    C8_Missione,
    C8_MissioneCommessa,
    C8_Sede,
    C8_GestioneMensile,
    C8_W032RichiediTipoMissione,
    C8_W032RichiediTipoRimborso,
    C8_W032DettaglioGG,
    C8_W032CheckPercorso,
    C8_W032DocumentoMissioni,
    C8_W032RimborsiDett,
    C8_W032RiapriMissione,
    C8_W032TappeSoloSuDistanziometro,
    C8_W032MessaggioTappeInesistenti,
    C8_W032NoteRimbEditabili,
    C8_W032StatoMissioneAutorizzata,
    C8_W032BloccaDate,
    C9_ScaricoPaghe,
    C10_FormazioneProfiloCrediti,
    C10_FormazioneProfiloCorso,
    C11_PianifOrariProg,
    C11_PianifOrari_DebGG,
    C11_PianifOrari_No_CopiaGiustif,
    C12_PreferenzeDestinazione,
    C12_PreferenzeCompetenza,
    C13_CdcPercentualizzati,
    C13_CdcPersConv,
    C14_ProvvSede,
    C15_LimitiMensCaus,
    C16_InsRiposi,
    C17_PostiLetto,
    C18_AccessiMensa,
    C20_IncaricoUnitaOrg,
    C21_ValutazioniLiv1,
    C21_ValutazioniLiv2,
    C21_ValutazioniLiv3,
    C21_ValutazioniLiv4,
    C21_ValutazioniRsp1,
    C21_ValutazioniRsp2,
    C21_ValutazioniPnt1,
    C21_EMailDestIndirizzo,
    C22_EnteGiuridico,
    C22_InizioRapGiuridico,
    C22_FineRapGiuridico,
    C22_QualificaGiuridico,
    C22_DisciplinaGiuridico,
    C23_ContrCompetenze,
    C23_InsNegCatena,
    C23_VMHCumuloTriennio,
    C23_VMHFruizGG,
    C24_AziendaTipoBudget,
    C25_TimbIrr_Auto,
    C26_HintT030V430,
    C26_HintT030V430_NC,
    C26_V430Materializzata,
    C26_C018_Hint,
    C26_C018_Unnest,
    C27_TablespaceFree,
    C28_CancellaAnnoLog,
    C29_ChiamateRepFiltro1,
    C29_ChiamateRepFiltro2,
    C29_ChiamateRepDatiVis,
    C29_ChiamateRepDatiModif,
    C29_W043_ModReperNumGiorni,
    C29_W043_ModReperOraCutOff,
    C29_ChiamateRepDatoAgg1,
    C29_ChiamateRepDatoAgg2,
    C29_ChiamateRepDatoMod,
    C30_WebSrv_A004_URL,
    C30_WebSrv_A004_Dati,
    C30_WebSrv_A025_URL_GET,
    C30_WebSrv_A025_URL_PUT,
    C30_WebSrv_B021_URL,
    C30_WebSrv_B021_TOKEN,
    C30_WebSrv_B021_PASSPHRASE,
    C30_WebSrv_B021_TIMEOUT,
    C30_WebSrv_X004_URL,
    C31_NoteGiustificativi,
    C31_Giustif_GGMG,
    C32_CheckAggSchedaAbil,
    C32_ScriptAggSchedaAfter,
    C32_SaldoMeseCompensato,
    C33_Link_I070_T030,
    C33_ProxyServer,
    C33_ProxyUser,
    C33_ProxyPassword,
    C34_CriptaSingoliCedolini,
    C35_ResiduiTriggerBefore,
    C35_ResiduiTriggerAfter,
    C36_OrdProfSanCodice,
    C36_OrdProfSanEmailVar,
    C36_OrdProfSan_Campi_Obb,
    C40_WebSrv_User,
    C40_WebSrv_Pwd,
    C40_EnteL104,
    C40_WebSrv_URLL104,
    C40_EnteGedap,
    C40_WebSrv_URLGedap,
    C40_InvioGedap,
    C40_Qualifica,
    C40_DistaccoSede_ComuneDef,
    C40_DistaccoSede_Comune,
    C40_DistaccoSede_Indirizzo,
    C90_WebAutorizCurric,
    C90_EMailW010Uff,
    C90_EMailW018Uff,
    C90_EMailSMTPHost,
    C90_EMailUserName,
    C90_EMailPassWord,
    C90_EMailPort,
    C90_EMailRespOttimizzata,
    C90_EMailRespGGReinvio,
    C90_EMailRespOggetto,
    C90_EMailRespTesto,
    C90_EMailSenderIndirizzo,
    C90_EMailSender,
    C90_EMailHeloName,
    C90_EMailAuthType,
    C90_EMailUseTLS,

    C90_EMail_DatiP430,

    C90_WebRighePag,
    C90_WebTipoCambioOrario,
    C90_WebSettCambioOrario,
    C90_W005Settimane,
    C90_W009AnomBloccanti,
    C90_W010CausPres,
    C90_W010Cancellazione,
    C90_W010AnomNonBloccanti,
    C90_W010AcquisizioneAuto,
    C90_W018AcquisizioneAuto,
    C90_W024MMIndietro,
    C90_W024MMIndietroRitardo,
    C90_W026CausE,
    C90_W026CausU,
    C90_W026TipoRichiesta,
    C90_W026Spezzoni,
    C90_W026IncludiSpezzoniFuoriOrario,
    C90_W026TipoAutorizzazione,
    C90_W026TipoStraord,
    C90_W026UtilizzoDal,
    C90_W026UtilizzoAl,
    C90_W026EccedGGTutta,
    C90_W026CheckSaldoDisponibile,
    C90_W026MMIndietroDal,
    C90_W026MMIndietroAl,
    C90_W026Arrotondamento,
    C90_W026SpezzoneMinimo,
    C90_W026SogliaEccedenza,
    C90_W026EccedOltreDebito,
    C90_W026DatiInvisibili,
    C90_W026AutorizzObbl,
    C90_W026CausAbbattGiustAss,
    C90_W026AccorpaSpezzoni,
    C90_W026ConfermaAutorizzazioni,
    C90_W026ModificaTutto,
    C90_W026PianifForzata,
    C90_NomeProfiloDelega,
    C90_EmailThread,
    C90_Lingua,
    C90_FiltroDeleghe,
    C90_CronologiaNote,
    C90_PathAllegati,
    C90_IterMaxAllegati,
    C90_IterMaxDimAllegatoMB,
    C90_IterEstensioneAllegato,
    C90_IterOrdinaDataRichiesta,
    C90_IterDimMaxDownloadMassivoMB,
    C90_IterNrMaxDownloadMassivo,
    C90_NotificatoreAttivita,
    C90_FiltroAnagrafeConsideraRichiesteCessati,
    C90_EmailSincrDominio,
    C90_CellulareLunghMin,
    C90_W034GiornoMeseDispCedolino,
    C90_W034WSUser,
    C90_W034WSPassword,
    C90_W009_WA027_UsaB028,
    C90_MessaggisticaReply,
    C90_MessaggisticaObbligoLettura,
    C90_MessaggisticaApriDettaglio,
    C90_MessaggiObbligatoriBloccanti,
    C90_W035MaxDimAllegatoMB,
    C90_W035MaxAllegati,
    C90_W035QuotaAllegatiMB,
    C90_W035ModalitaCancMessaggiInviati,
    C90_W035MesiDopoInvioCancMessaggi,
    C90_W038Tolleranza_E,
    C90_W038Tolleranza_U,
    C90_W038Rilevatore,
    C90_W038RilevatoreMobile,
    C90_W038FiltroAnagRilevatoreMobile,
    C90_W038NumGGVisibili,
    C90_W038TimbCausalizzabile,
    C90_W038CheckIP,
    C90_W038TriggerBefore,
    //Parametri per decritazione RDL EBC (ADS)
    C90_SSO_Tipo,
    C90_SSO_OAUTH2Passphrase,
    C90_SSO_OAUTH2ClientID,
    C90_SSO_OAUTH2UrlGetToken,
    C90_SSO_OAUTH2UrlGetUser,
    C90_SSO_OAUTH2InfoUser,
    C90_SSO_SHA1Passphrase,
    C90_SSO_RDLPassphrase,
    C90_SSO_UsrMask,
    C90_SSO_TimeOut,
    //Parametri per archiviazione documentale LArchive
    C45_LArchive_ProducerId,
    C45_LArchive_TokenJWT,
    C45_LArchive_Scadenza_TokenJWT,
    C45_LArchive_URL_Versamento,
    C45_LArchive_URL_Stato,
    C90_Contatti_Aziendali,
    C90_Contatti_Personali
    :String;
    //procedure Assign(APersistent: TPersistent); override;
  end;

  TAbilitazioniFunzioni = record
    Descrizione,Funzione:String;
    Tag:Integer;
    Inibizione:Char;
    AccessoBrowse: String;
    RighePagina: Integer;
  end;

  TFiltroDizionario = record
    Tabella,Codice:String;
    Abilitato,Cestino:Boolean;
  end;

  TAuthDomInfo = record
    DominioDip,
    DominioDipTipo,
    DominioUsr,
    DominioUsrTipo: String;
  end;

  TIPStatus = (isUndefined,isOk,isError);

  TIPInfo = record
    Status: TIPStatus;
    IP: String;
    IPLocale: String;
    IPClient: String;
  end;

  TParametri = class(TComponent)
  private
    function GetModuloInstallato(Modulo:String):Boolean; inline;
    function GetCharSetUnicode: Boolean; inline;
  public
    HostName: String;
    HostIPAddress: String;
    ClientIPInfo: TIPInfo;
    Path:String;
    VersioneOracle:Integer;
    CharSetOracle:String;
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
    RegolePassword:TRegolePassword;
    GruppoBadge:String;
    ValiditaUtente:Word;
    ValiditaCessati:Word;
    ProgOper:Word;
    OperBloc:Boolean;
    V430:String;
    Lingua:String;
    cdsI015:TClientDataSet;
    IntegrazioneAnagrafe:String;
    CodiceIntegrazione:String;
    CodContrattoVoci:String;
    CodContrattoConvenzionati:String;
    CodContrattoSanita:String;
    T040_Validazione:String;
    T100_Ora:String;
    T100_Rilevatore:String;
    T100_Causale:String;
    T100_CancTimbOrig:String;
    T380_AutoPianificazione:String;
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
    AccessibilitaNonVedenti:String;
    InserimentoMatricole:String;
    InserimentoMatricoleP430:String;
    Storicizzazione:String;
    StoricizzazioneP430:String;
    ModificaDecorrenza:String;
    ModificaDecorrenzaP430:String;
    EliminaStorici:String;
    EliminaStoriciP430:String;
    StoriaInizioFine:String;
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
    CampiRiferimento:TCampiRiferimento;
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
    DownloadMassivoAllegati: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ModuloInstallato[Modulo:String]:Boolean read GetModuloInstallato;
    property CharSetUnicode:Boolean read GetCharSetUnicode;
  end;
  //*)

  TMedpCriticalSection = class(TObject)
  private
    {$HINTS OFF}
    // deve esserci, pertanto l'hint è da ignorare
    dummy : Array[1..96] of Byte;
    {$HINTS ON}
  public
    procedure Enter;
    procedure Leave;
  end;

  TSelAnagrafeBridge = record
    SQLCreato:String;
    Progressivo:Integer;
    SelezionePeriodica,SoloPersonaleInterno:Boolean;
    SelezionePeriodicaVal:Byte;
    SoloPersonaleInternoVal:Boolean;
    AncheDipendentiCessatiVal:Boolean;
  end;

  TElencoValoriChecklist = class
  public
    lstCodice: TStringList;
    lstDescrizione: TStringList;
    constructor Create;
    destructor Destroy; override;
  end;

  TDataBaseDrv = (dbInterBase, dbOracle, dbStandard);

  TAzioneCedolino = (
    acNessuna,
    acImpostaConsegna,
    acRichiediImpostazioneConsegna
  );

  TTabelleDizionario = record
    Tabella, DescTabella:String;
  end;

  TItemsValues = record
    Item:String;
    Value:String;
  end;

  {$IFDEF IRISWEB}
  TStringFilterType = (injXSS, injSQL);
  TStringFilterTypeSet = set of TStringFilterType;

  TStringFilter = record
    InjTypes: TStringFilterTypeSet;
    Enable: Boolean;
    Role:String;
    Description:String;
  end;
  {$ENDIF IRISWEB}

  // tipo record per parametri di configurazione
  TParConfig = record
    // parametri di configurazione impostati sul file
    Database: String;              // database da proporre come default in fase di login
    Azienda: String;               // azienda da proporre di default in fase di login
    Profilo: String;               // profilo da proporre di default in fase di login
    TimeoutOper: Integer;          // timeout di sessione web per l'operatore (utente di I070) espresso in minuti
    TimeoutDip: Integer;           // timeout di sessione web per il dipendente (utente di I060) espresso in minuti
    MaxSessioni: Integer;          // numero massimo di sessioni web accettate
    UrlSuperoMaxSessioni: String;  // url per il redirect nel caso di supero max sessioni accettate
    Home: String;                  // url per il redirect dopo il logout dalla sessione web
    UrlLoginErrato: String;        // url per il redirect se il login esterno fallisce
    UrlWSAutenticazione: String;   // url per il webservice di autenticazione (utilizzato da ROMA_HSANDREA)
    UrlManutenzione: String;       // url da impostare se il sito è in manutenzione
    UrlIrisWebCloud: String;       // url per richiamare IrisWeb da IrisCloud e viceversa
    IrisWebCloudNewTab: String;    // S = apre nuova pagina quando richiama IrisWeb->IrisCloud o viceversa, N = sostituisce la sessione corrente quando richiama IrisWeb->IrisCloud o viceversa
    UrlWebApp: String;             // url contenente variabili per richiamare una web app esterna preceduta dal nome (es. TOM=https://formazione.fbf.milano.it/tom_fbf_mi/externalAuth.html?uid=:UTENTE&time=:UNIX_TIME&hash=:HASH)
    LoginEsterno: String;          // S = gestione con login esterno (preautenticazione), N = gestione con login interattivo
    PaginaIniziale: String;        // sigla della pagina da visualizzare automaticamente all'accesso in IrisWEB
    PaginaSingola:String;          // sigla della singola pagina da rendere disponibile, oscurando tutte le altre
    CampiInvisibili: String;       // elenco di campi da non visualizzare separati da virgola ed espressi nella forma [NomeForm.NomeComponente]
    Port: Integer;                 // porta su cui risponde il webserver
    CursoriLogin: Integer;         //
    CursoriSessione: Integer;      //
    MaxOpenCursors: Integer;       //
    MaxWorkingMemMb: Integer;      // se impostato indica il valore max di memoria da utilizzare per il processo espresso in Mb
    LogAbilitati: String;          // elenco dei log abilitati separati da virgola e scelti fra le costanti INI_LOG_*
    LogFile: String;               // file di log per i trace che non riescono ad essere salvati su database
    ParametriAvanzati: String;     // elenco dei parametri avanzati separati da virgola e scelti fra le costanti INI_PAR_*
    UrlReCAPTCHA: String;          // url su cui attivare il ReCAPTCHA nella form di login
    SiteKeyReCAPTCHA: String;      // sitekey usata in fase di verifica lato client del ReCAPTCHA
    SecretKeyReCAPTCHA: String;    // secretkey usata in fase di verifica lato server del ReCAPTCHA
    Url_Base: String;              // url di base  (gc: 11/09/19)
    Tipo_Installazione: String;    // Tipo installazione IIS ; SRV=Service (gc: 11/09/19)
    // parametri per X001
    TabColPartenza: String;        // ...
    NumLivelli: Integer;           // ...
    // parametri per IrisAPP
    RegistraCredenziali:String;
    // parametri derivati dalle impostazioni di configurazione
    // introdotti per semplicità di utilizzo
    ReconnectSession: Boolean;     // parametro boolean da utilizzare in CheckConnection
    LogoffDbPool:Boolean;          // parametro boolean per consentire/impedire il logoff delle sessioni inutilizzate
    MaxWorkingMemByte: Cardinal;   // se impostato indica il valore max di memorya da utilizzare per il processo espresso in byte
    ComInitialization: String;     // tipo di com initialization, scelto fra le costanti INI_COM_*
    RaveStreamMode: String;        // tipo di stream mode per rave report, scelto fra le costanti INI_RAVE_STREAM_MODE_*
    // IW Exception Logger
    IWExcLogAbilitato: Boolean;    // true se il log abilitato, false altrimenti.
    IWExcLogPathFile: String;      // path dei file di log, se non specificato IW usa "ErrorLog" nell'application path.
    IWExcLogNomeFile: String;      // prefisso nome file di log, se non specificato sarà usato il nome dell'applicazione.
    IWExcLogGiorniRimoz: Integer;  // età minima in giorni dei file di log che saranno cancellati allo shutdown del server. 0 = nessuna cancellazione
    IWExcLogEccezIgnorate: String; // elenco delle classi delle eccezioni da ignorare separate da ','.
  end;

  // informazioni utente estratte da active directory
  TActiveDirectoryUserInfo = record
    User: string;
    FullName: string;
    Email: string;
    procedure Clear; inline;
  end;

  TIterAutorizzativi = record
    Cod,Desc:String;
  end;

  TFasiIterAutorizzativi = record
    Cod:String;
    Fase:Integer;
    Desc:String;
  end;

  TDatiEnte = record
    Nome,
    Crypt, //S/N
    Gruppo,
    Lista,
    Desc:String;
  end;

  TColori = record
    Nome:String;
    Numero:Integer;
    StyleWEB:String;
    ClassWEB:String;
    Testo:String;
    Sfondo:String;
  end;

  TStruttT430 = record
    Campo:String;
    Tabella:String;
    Codice:String;
    Storico:String;
  end;

  TArrString = array of String;
  TCampiT030 = Array [1..13] of String;
  TCampiT480 = Array [1..5] of String;

  TAzioniSitoWeb = record
    Nome: String;
    Comando: String;
    Descrizione: String;
  end;

  //Usata da A023 e A047 e relativi progetti cloud
  TTimbrature = record
    Progressivo: Integer; //+++
    Data: TDateTime;      //+++
    Ora: Variant;
    Verso: String;
    Flag: String;
    Rilevatore: String;
    Causale: String;
    IDRichiesta: Integer;
    procedure Clear; inline;
  end;

  TAccessiMensa = record
    PranzoCena: String;
    Accessi: Integer;
    Causale: String;
    Rilevatore: String;
  end;

  //Usata da A023 e A047 e relativi progetti cloud
  TGiustificativi = record
    Progressivo: Integer; //+++
    Data: TDateTime;      //+++
    Causale:String;
    DataNas:TDateTime;
    ProgCaus:Integer;
    Tipo:String;
    DaOre,AOre:TDateTime;
    FlagScheda:Char;
    NuovoPeriodo:Boolean;
    Validata:String;//S:Assenza Validata, N:Assenza da Validare,  :Assenza senza bisogno di validazione
    Note:String;
    IDRichiesta:integer;
    IDCertificato: String;
    procedure Clear;
  end;

  //usata da WA023 E WA047
  TGiorniCartellino = record
    Data:TDateTime;
    NonImpostato:Boolean;
    Lavorativo:Boolean;
    Festivo:Boolean;
    Domenica:Boolean;
  end;

  TVociPaghe = record
    CodInt     :String;
    Descrizione:String;
    Ordine     :Word;
    VocePaghe  :String;
    Misura     :String;
  end;
  TVettVociPaghe = array [1..54] of TVociPaghe;
  TAnomScaricoPaghe = array [1..19] of String;

  TTipoCausale = (tcNullo,
                  tcAssenza,
                  tcPresenza);

  TTipoCausaleRec = record
  const
    Nullo    = tcNullo;
    Assenza  = tcAssenza;
    Presenza = tcPresenza;
  end;

  TTipoCausaleRecHelper = record helper for TTipoCausale
    function ToString: String;
  end;

  // tipologia di ore normali delle causali di presenza
  //   (valori di T275_CAUPRESENZE.ORENORMALI)
  TTipoInclusioneOreNormaliRec = record
  const
    Esclusa            = 'A'; // esclusione dalle Ore Normali
    Inclusa            = 'B'; // inclusione nelle Ore Normali
    InclusaSoloComp    = 'C'; // inclusione nelle Ore Normali solo compensabili
    InclusaOltreSoglia = 'D'; // inclusione nelle Ore Normali oltre la soglia
    class function IsEsclusa(const POreNormali: String): Boolean; static; inline;
    class function IsInclusa(const POreNormali: String): Boolean; static; inline;
  end;

  // tipo di richiesta straordinario
  //   (valori di T025_CONTMENSILI.ITER_AUTORIZZATIVO_STR)
  TTipoRichStrRec = record
  const
    Nessuna                 = '0'; // nessuna tipologia
    BancaOre                = '1'; // Banca ore (AOSTA_REGIONE),
    StraordAnnuo            = '2'; // Straordinario annuo (TORINO_REGIONE)
    StraordAnnuoCaus        = '3'; // Straordinario annuo con possibilità di destinare le ore su causale specifica (GENOVA_COMUNE)
    OreCausalizzate         = '4'; // Ore causalizzate (TORINO_CSI_PRV)
    StraordAnnuoCausPagComp = '5'; // Straordinario annuo con possibilità di liquidare le ore rese con una certa causale (SAVONA_ASL2)
  end;

  TItemRiposteMsg = record
    Cod:String;
    Msg:String;
    Risposta:String;
    Bloccante:Boolean;
  end;

  TCodiciFiles = (Supporto);
  TFileInsallati = record
    Id: integer;
    NomeFile: string;
    Descrizione: string;
    Codice: TCodiciFiles;
  end;
  TVettFileInsallati = array [1..1] of TFileInsallati;

  TRisposteMsg = class(TPersistent)
  private
    lstRisposteMsg: array of TItemRiposteMsg;
    FErrCod:String;
    FErrMsg:String;
    FErrTitolo:String;
    FBloccante:Boolean;
    FAttributo:String;
    //procedure PutErrMsg(const Value: String);
    function GetRisposta(Cod: String): String;
    procedure SetAttributo(const Value: String);
  public
    constructor Create;
    destructor  Destroy; override;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TRisposteMsg;
    procedure Clear;
    function  GetMsg:TItemRiposteMsg;
    procedure AddErr(Cod,Msg:String); overload;
    procedure AddErr(Cod,Titolo,Msg:String); overload;
    procedure AddMsg(Cod,Msg:String); overload;
    procedure AddMsg(Cod,Titolo,Msg:String); overload;
    procedure AddRisposta(Cod,Risposta:String);
    property ErrCod:String read FErrCod;
    property ErrMsg:String read FErrMsg;
    property ErrTitolo:String read FErrTitolo;
    property Bloccante:Boolean read FBloccante;
    property Risposta[Cod:String]:String read GetRisposta;
    property Attributo:String read FAttributo write SetAttributo;
  end;

  // interceptor per formati datetime standard mondoedp
  TDateTimeInputInterceptor = class(TJSONInterceptor)
  private
    FDateTimeIsUTC: Boolean;
  public
    constructor Create(ADateTimeIsUTC: Boolean); reintroduce;
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
    property DateTimeIsUTC: Boolean read FDateTimeIsUTC write FDateTimeIsUTC;
  end;

  TDatiRichiesta = class(TPersistent)
  public
    Motivazione: String;
    NoteIns: String;
    IdRevocato: Integer;
    RisposteMsg: TRisposteMsg;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TDatiRichiesta;
    function ToString: String; override;
  end;

  TDatiRichiestaGiust = class(TDatiRichiesta)
  public
    Progressivo: Integer;
    TipoCausale: TTipoCausale;
    TipoRichiesta: String;
    Causale: String;
    TipoGiust: String;
    Dal: TDateTime;
    Al: TDateTime;
    NumeroOre: String;
    NumeroOrePrev: String;
    AOre: String;
    AOrePrev: String;
    Minuti:Integer;
    AMinuti:Integer;
    [JSONReflect(ctString,rtString,TDateTimeInputInterceptor,nil,True)]
    Datanas: TDateTime;
    NoteGiustificativo: String;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TDatiRichiestaGiust;
    function ToString: String; override;
    function ValidaPeriodoOrario: TResCtrl;
  end;

  TDatiRichiestaTimb = class(TDatiRichiesta)
  public
    Progressivo: Integer;
    Operazione: String;
    Data: TDateTime;
    Ora: String;
    Verso: String;
    VersoOrig: String;
    Causale: String;
    CausaleOrig: String;
    Rilevatore: String;
    RilevatoreOrig: String;
    FunzioneRilevatore: String;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TDatiRichiestaTimb;
    function ToString: String; override;
    function GetDataOra: TDateTime;
    function GetOraDateTime: TDateTime;
    function IsVersoModificato: Boolean;
    function IsCausaleModificata: Boolean;
    function IsRilevatoreModificato: Boolean;
  end;

  TDatiTimbratura = class(TPersistent)
  public
    Progressivo: Integer;
    // data e ora del server al momento della timbratura
    DataOra: TDateTime;
    // data da riportare su T100 (comprensiva della tolleranza)
    Data: TDateTime;
    // ora da riportare su T100 (comprensiva della tolleranza)
    Ora: TDateTime;
    Verso: String;
    Causale: String;
    Rilevatore: String;
    // opzioni di timbratura
    TimbCausalizzabile: Boolean;
    EsistonoTolleranze: Boolean;
    RisposteMsg: TRisposteMsg;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TDatiTimbratura;
    function ToString: String; override;
    function GetVersoDesc: String; inline;
    function GetOraT100: String;
    function Check: TResCtrl;
  end;

  TTipoModuloRec = record
  const
    ClientServer = 'CS';  // client / server
    COM          = 'COM';           // COM server
  end;

  ExceptionNoLog = class(Exception);

  function A000selDizionarioSicurezzaRiepiloghi:String;
  function A000DatiEnteCrypt(Nome:String):String;
  function A000GetCodIter(pDesc: String): String;
  function A000GetDescIter(pCod:String):String;

const
  COMO_HSANNA        = 'ASST LARIANA';
  TORINO_ASLTO1      = 'AZIENDA SANITARIA LOCALE TO1 - REGIONE PIEMONTE';
  TORINO_HCOTTOLENGO = 'PICCOLA CASA DELLA DIVINA PROVVIDENZA';
  AOSTA_ASL          = 'AOSTA_ASL';

  A000PasswordFissa = Chr(84) + Chr(73) + Chr(77) + Chr(79) + Chr(84) + Chr(69) + Chr(79);
  A000PasswordFissa2 = Chr(116) + Chr(49) + Chr(77) + Chr(79) + Chr(84) + Chr(51) + Chr(48) + Chr(43) + Chr(33) + Chr(82) + Chr(105) + Chr(36);

  A000FilePwdApplication = 'APPLICATION';
  A000FilePwdHost = 'HOST';

  A000SSO_UsrMask = 'user#ddmmyyyyhhnnss';
  A000SSO_RDLPassphrase = 'abc def ghi lmn opq rst uvz';

  QVistaOracle_Const = 'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #13#10 +
                       'WHERE T030.Progressivo = V430.T430Progressivo AND' + #13#10 +
                       'T030.ComuneNas = T480.Codice(+) AND' + #13#10 +
                       ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine';

  QVistaInServizio          = 'AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430PROGRESSIVO AND :DataLavoro BETWEEN T430INIZIO AND NVL(T430FINE,:DataLavoro))';
  QVistaInServizioPeriodica = 'AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430PROGRESSIVO AND :DataLavoro >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DataLavoro))';
  QDipInServizio            = '/*A000*/:DataLavoro BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),%s)/*\A000*/';            //Passare Parametri.ValiditaCessati
  QDipInServizioPeriodica   = '/*A000*/:DataLavoro >= T430INIZIO AND :C700DATADAL <= ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),%s)/*\A000*/'; //Passare Parametri.ValiditaCessati
  TAG_FILTRO_ANAG_INIZIO    = '/*I072*/';
  TAG_FILTRO_ANAG_FINE      = '/*\I072*/';

  CR                        = #13;
  LF                        = #10;
  CRLF                      = #13#10;
  TAB                       = #9;
  ESC_KEY                   = #27;
  SPACE                     = #32;
  SPAZI_SET                 = [LF,CR,SPACE];
  DATE_NULL: TDateTime      = 0;                 // 30/12/1899
  DATE_MIN : TDateTime      = 2;                 // 01/01/1900
  DATE_MAX : TDateTime      = 767010;            // 31/12/3999
  SPECIAL_CHAR              = '/\*:"&<>?|~';
  NEW_SPECIAL_CHAR          = ' !"#$%&''()*+,-./:;<=>?@[\]^_`{|}~';
  ORACLE_MAX_IN_VALUES      = 1000;
  C700NEO_ASSUNTO           = $0055AA00;
  NAME_VALUE_SEPARATOR      = #177;

  MaxFasce = 28;       //Numero massimo di fasce nel Mese

  // selezione anagrafica
  CONDIZIONE_IN_SERVIZIO_STANDARD   = ':DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO)';
  CONDIZIONE_IN_SERVIZIO_PERIODICA  = ':DATALAVORO >= T430INIZIO AND :DATADAL <= NVL(LAST_DAY(T430FINE),:DATADAL)';
  CONDIZIONE_CONSIDERA_RICHIESTE    = 'EXISTS (SELECT ''X'' ' +
                                      '        FROM   VT050_ITER_RICHIESTEASSENZA ' +
                                      '        WHERE  PROGRESSIVO = T030.PROGRESSIVO ' +
                                      '        AND    T850STATO IS NULL ' +
                                      '        AND    T850DATA >= T430INIZIO))';
  FILTRO_IN_SERVIZIO                = 'AND ' + CONDIZIONE_IN_SERVIZIO_STANDARD;
  FILTRO_IN_SERVIZIO_PERIODICA      = 'AND ' + CONDIZIONE_IN_SERVIZIO_PERIODICA;
  FILTRO_IN_SERVIZIO_CON_RICHIESTE  = 'AND ((' + CONDIZIONE_IN_SERVIZIO_STANDARD + ') OR (' + CONDIZIONE_CONSIDERA_RICHIESTE + ')';

  FasceOracle = 'SELECT DISTINCT T210.Codice,T210.Maggiorazione' + #13#10 +
                'FROM T210_Maggiorazioni T210, T201_Maggiorazioni T201' + #13#10 +
                'WHERE (T210.Codice = T201.Maggior1 OR T210.Codice = T201.Maggior2 OR' + #13#10 +
                'T210.Codice = T201.Maggior3 OR T210.Codice = T201.Maggior4) AND' + #13#10 +
                'T201.Codice = :Codice' + #13#10 +
                'ORDER BY T210.Maggiorazione,T210.Codice';

  A000selDizionario = 'SELECT ''CAUSALI ASSENZA'' TABELLA,CODICE FROM T265_CAUASSENZE UNION' + #13#10 +
                      'SELECT ''RAGGRUPPAMENTI ASSENZA'' TABELLA,CODICE FROM T260_RAGGRASSENZE UNION' + #13#10 +
                      'SELECT ''PROFILI ASSENZA'' TABELLA,CODICE FROM T261_DESCPROFASS UNION' + #13#10 +
                      'SELECT ''CAUSALI PRESENZA'' TABELLA,CODICE FROM T275_CAUPRESENZE UNION' + #13#10 +
                      'SELECT ''RAGGRUPPAMENTI PRESENZA'' TABELLA,CODICE FROM T270_RAGGRPRESENZE UNION' + #13#10 +
                      'SELECT ''CAUSALI GIUSTIFICAZIONE'' TABELLA,CODICE FROM T305_CAUGIUSTIF UNION' + #13#10 +
                      'SELECT ''CAUSALI SUL CARTELLINO'' TABELLA,CODICE FROM T265_CAUASSENZE UNION' + #13#10 +
                      'SELECT ''CAUSALI SUL CARTELLINO'' TABELLA,CODICE FROM T275_CAUPRESENZE UNION' + #13#10 +
                      'SELECT ''CAUSALI SUL CARTELLINO'' TABELLA,CODICE FROM T305_CAUGIUSTIF UNION' + #13#10 +
                      'SELECT ''MODELLI ORARIO'' TABELLA,CODICE FROM T020_ORARI UNION' + #13#10 +
                      'SELECT ''PROFILI ORARIO'' TABELLA,CODICE FROM T220_PROFILIORARI UNION' + #13#10 +
                      'SELECT ''CALENDARI'' TABELLA,CODICE FROM T010_CALENDIMPOSTAZ UNION' + #13#10 +
                      'SELECT ''TURNI REPERIBILITA'' TABELLA,CODICE FROM T350_REGREPERIB UNION' + #13#10 +
                      'SELECT ''GENERATORE DI STAMPE'' TABELLA,CODICE FROM T910_RIEPILOGO WHERE CODICE NOT IN (SELECT ID FROM I025_CESTINO WHERE TABELLA = ''T910_RIEPILOGO'') UNION' + #13#10 +
                      'SELECT ''PARAMETRIZZAZIONI CARTELLINO'' TABELLA,CODICE FROM T950_STAMPACARTELLINO UNION' + #13#10 +
                      'SELECT ''TIPOLOGIA TRASFERTA'' TABELLA,CODICE FROM M011_TIPOMISSIONE UNION' + #13#10 +
                      'SELECT DISTINCT ''INTERROGAZIONI DI SERVIZIO'' TABELLA, NOME AS CODICE FROM T002_QUERYPERSONALIZZATE WHERE NOME NOT IN (SELECT ID FROM I025_CESTINO WHERE TABELLA = ''T002_QUERYPERSONALIZZATE'') UNION' + #13#10 +
                      'SELECT DISTINCT ''GRUPPI BUDGET STRAORDINARIO'' TABELLA, CODGRUPPO AS CODICE FROM T713_BUDGETANNO UNION' + #13#10 +
                      'SELECT DISTINCT ''GRUPPI PESATURE INDIVIDUALI'' TABELLA, CODGRUPPO AS CODICE FROM T773_PESATUREGRUPPO UNION' + #13#10 +
                      'SELECT DISTINCT ''GRUPPI SC.QUANTITATIVE IND.'' TABELLA, CODGRUPPO AS CODICE FROM T767_INCQUANTGRUPPO UNION' + #13#10 +
                      'SELECT DISTINCT ''SELEZIONI ANAGRAFICHE'' TABELLA, NOME AS CODICE FROM T003_SELEZIONIANAGRAFE UNION' + #13#10 +
                      'SELECT ''RIMBORSI MISSIONI'' TABELLA, CODICE FROM M020_TIPIRIMBORSI UNION' + #13#10 +
                      'SELECT ''PROFILI INDENNITA'' TABELLA, CODICE FROM T163_CODICIINDENNITA UNION' + #13#10 +
                      'SELECT ''PROFILI PIANIF. TURNI'' TABELLA, CODICE FROM T082_PAR_PIANIFORARI UNION' + #13#10 +
                      'SELECT ''MODELLI DI CERTIFICAZIONE'' TABELLA, CODICE FROM SG235_MODELLI_CERTIFICAZIONI UNION' + #13#10 +
                      'SELECT ''OROLOGI DI TIMBRATURA'' TABELLA, CODICE FROM T361_OROLOGI UNION' + #13#10 +
                      'SELECT ''AUTOCERTIFICAZIONI: TIPI RAPPORTO'' TABELLA, CODICE FROM T450_TIPORAPPORTO UNION' + #13#10 +
                      'SELECT ''AUTOCERTIFICAZIONI: PART TIME'' TABELLA, CODICE FROM T460_PARTTIME UNION' + #13#10 +
                      'SELECT ''AUTOCERTIFICAZIONI: CAUSALI ASPETTATIVA'' TABELLA, CODICE FROM T460_PARTTIME UNION' + #13#10 +
                      'SELECT ''ITER AUTORIZZATIVI'' TABELLA, ITER CODICE FROM MONDOEDP.I093_BASE_ITER_AUT WHERE AZIENDA = I090F_GETAZIENDACORRENTE UNION' + #13#10 +
                      'SELECT ''TIPO ACCORPAMENTO VOCI'' TABELLA, COD_TIPOACCORPAMENTOVOCI CODICE FROM P214_TIPOACCORPAMENTOVOCI UNION' + #13#10 +
                      'SELECT DISTINCT ''REGOLE CONTABILITA'' TABELLA, TIPO_CONTAB CODICE FROM P590_CONTABREGOLE UNION' + #13#10 +
                      'SELECT DISTINCT ''DATI ATIPICI'' TABELLA, DATO CODICE FROM I011_DIZIONARIO_DATISCHEDA UNION' + #13#10 +
                      'SELECT ''SQUADRE TURNI'' TABELLA, CODICE FROM T603_SQUADRE'
                      (*
                      'SELECT ''AUTOCERTIFICAZIONI: ENTI'' TABELLA, CODICE FROM <C22_ENTI>'
                      'SELECT ''AUTOCERTIFICAZIONI: QUALIFICHE'' TABELLA, CODICE FROM <C22_QUALIFICHE>'
                      'SELECT ''AUTOCERTIFICAZIONI: DISCIPLINE'' TABELLA, CODICE FROM <C22_DISCIPLINE>'
                      *)
                      ;//+ subquery dinamica di A000selDizionarioSicurezzaRiepiloghi

  TabelleDizionario:array[1..37] of TTabelleDizionario = (
    (Tabella:'T265_CAUASSENZE';             DescTabella:'CAUSALI ASSENZA'),
    (Tabella:'T260_RAGGRASSENZE';           DescTabella:'RAGGRUPPAMENTI ASSENZA'),
    (Tabella:'T261_DESCPROFASS';            DescTabella:'PROFILI ASSENZA'),
    (Tabella:'T275_CAUPRESENZE';            DescTabella:'CAUSALI PRESENZA'),
    (Tabella:'T270_RAGGRPRESENZE';          DescTabella:'RAGGRUPPAMENTI PRESENZA'),
    (Tabella:'T305_CAUGIUSTIF';             DescTabella:'CAUSALI GIUSTIFICAZIONE'),
    (Tabella:'-';                           DescTabella:'CAUSALI SUL CARTELLINO'),
    (Tabella:'T020_ORARI';                  DescTabella:'MODELLI ORARIO'),
    (Tabella:'T220_PROFILIORARIO';          DescTabella:'PROFILI ORARIO'),
    (Tabella:'T010_CALENDIMPOSTAZ';         DescTabella:'CALENDARI'),
    (Tabella:'T380_PIANIFREPERIB';          DescTabella:'TURNI REPERIBILITA'),
    (Tabella:'T163_CODICIINDENNITA';        DescTabella:'PROFILI INDENNITA'),
    (Tabella:'T082_PAR_PIANIFORARI';        DescTabella:'PROFILI PIANIF. TURNI'),
    (Tabella:'T361_OROLOGI';                DescTabella:'OROLOGI DI TIMBRATURA'),
    (Tabella:'T950_STAMPACARTELLINO';       DescTabella:'PARAMETRIZZAZIONI CARTELLINO'),
    (Tabella:'T101_ANOMALIE';               DescTabella:'ANOMALIE DEI CONTEGGI'),
    (Tabella:'T910_RIEPILOGO';              DescTabella:'GENERATORE DI STAMPE'),
    (Tabella:'T002_QUERYPERSONALIZZATE';    DescTabella:'INTERROGAZIONI DI SERVIZIO'),
    (Tabella:'T003_SELEZIONIANAGRAFE';      DescTabella:'SELEZIONI ANAGRAFICHE'),
    (Tabella:'-';                           DescTabella:'SICUREZZA RIEPILOGHI'),
    (Tabella:'M011_TIPOMISSIONE';           DescTabella:'TIPOLOGIA TRASFERTA'),
    (Tabella:'M050_RIMBORSI';               DescTabella:'RIMBORSI MISSIONI'),
    (Tabella:'SG235_MODELLI_CERTIFICAZIONI';DescTabella:'MODELLI DI CERTIFICAZIONE'),
    (Tabella:'T713_BUDGETANNO';             DescTabella:'GRUPPI BUDGET STRAORDINARIO'),
    (Tabella:'T773_PESATUREGRUPPO';         DescTabella:'GRUPPI PESATURE INDIVIDUALI'),
    (Tabella:'P070_MISUREQUANTITA';         DescTabella:'GRUPPI SC.QUANTITATIVE IND.'),
    (Tabella:'T450_TIPORAPPORTO';           DescTabella:'AUTOCERTIFICAZIONI: TIPI RAPPORTO'),
    (Tabella:'T460_PARTTIME';               DescTabella:'AUTOCERTIFICAZIONI: PART TIME'),
    (Tabella:'-';                           DescTabella:'AUTOCERTIFICAZIONI: ENTI'),
    (Tabella:'-';                           DescTabella:'AUTOCERTIFICAZIONI: QUALIFICHE'),
    (Tabella:'-';                           DescTabella:'AUTOCERTIFICAZIONI: DISCIPLINE'),
    (Tabella:'-';                           DescTabella:'CAMBIO TURNI REPERIBILITA'),
    (Tabella:'-';                           DescTabella:'ITER AUTORIZZATIVI'),
    (Tabella:'P214_TIPOACCORPAMENTOVOCI';   DescTabella:'TIPO ACCORPAMENTO VOCI'),
    (Tabella:'P590_CONTABREGOLE';           DescTabella:'REGOLE CONTABILITA'),
    (Tabella:'I011_DIZIONARIO_DATISCHEDA';  DescTabella:'DATI ATIPICI'),
    (Tabella:'T603_SQUADRE';                DescTabella:'SQUADRE TURNI')
    );

  A000T433 = 'select t433.progressivo, decorrenza, decorrenza_fine, t433.codice, t433.percentuale' + #13#10 +
             '  from t433_cdc_percent t433' + #13#10 +
             'union' + #13#10 +
             'select t430.progressivo, greatest(t430.datadecorrenza,t433a.decorrenza_fine + 1) decorrenza, least(t430.datafine,t433b.decorrenza - 1) scadenza, t430.:centro_costo, 100' + #13#10 +
             '  from t430_storico t430, t433_cdc_percent t433a,  t433_cdc_percent t433b' + #13#10 +
             '  where t430.progressivo = t433a.progressivo' + #13#10 +
             '  and t430.datadecorrenza <= t433b.decorrenza - 1 and t430.datafine >=  t433a.decorrenza_fine + 1' + #13#10 +
             '  and t433a.progressivo = t433b.progressivo and t433b.decorrenza =' + #13#10 +
             '    (select  min(decorrenza) from t433_cdc_percent t433c' + #13#10 +
             '     where t433c.progressivo = t433b.progressivo and t433c.decorrenza > t433a.decorrenza)' + #13#10 +
             '  and greatest(t430.datadecorrenza,t433a.decorrenza_fine + 1) <= least(t430.datafine,t433b.decorrenza - 1)' + #13#10 +
             'union' + #13#10 +
             'select t430.progressivo, t430.datadecorrenza,least(t430.datafine,(select  nvl(min(decorrenza - 1),t430.datafine) from t433_cdc_percent t433c where t433c.progressivo = t430.progressivo)),t430.:centro_costo, 100' + #13#10 +
             '  from t430_storico t430' + #13#10 +
             '  where datadecorrenza < (select  nvl(min(decorrenza),t430.datafine + 1) from t433_cdc_percent t433c where t433c.progressivo = t430.progressivo)' + #13#10 +
             'union' + #13#10 +
             'select t430.progressivo, greatest(t430.datadecorrenza,(select  nvl(max(decorrenza_fine + 1),t430.datadecorrenza) from t433_cdc_percent t433c where t433c.progressivo = t430.progressivo)),t430.datafine,t430.:centro_costo, 100' + #13#10 +
             '  from t430_storico t430' + #13#10 +
             '  where datafine > (select  nvl(max(decorrenza_fine),t430.datadecorrenza - 1) from t433_cdc_percent t433c where t433c.progressivo = t430.progressivo)';


  I091CryptKey = 30011945;
  DatiEnte:array [1..232] of TDatiEnte = (
    (Nome:'C6_INIZIOPROVA';                           Crypt:'N'; Gruppo:'Anagrafico';          Lista:'T430';              Desc:'Inizio del periodo di prova'),
    (Nome:'C6_DURATAPROVA';                           Crypt:'N'; Gruppo:'Anagrafico';          Lista:'T430';              Desc:'Durata del periodo di prova'),
    (Nome:'C13_CDC_PERCENT';                          Crypt:'N'; Gruppo:'Anagrafico';          Lista:'T430';              Desc:'Centro di costo percentualizzato'),
    (Nome:'C13_CDC_PERSCONV';                         Crypt:'N'; Gruppo:'Anagrafico';          Lista:'T430';              Desc:'Centro di costo personale convenzionato'),
    (Nome:'C4_BUONIMENSA';                            Crypt:'N'; Gruppo:'Varie';               Lista:'T430';              Desc:'Buoni pasto/Ticket'),
    (Nome:'C9_SCARICOPAGHE';                          Crypt:'N'; Gruppo:'Varie';               Lista:'T430';              Desc:'Scarico paghe: interfaccia'),
    (Nome:'C16_INSRIPOSI';                            Crypt:'N'; Gruppo:'Varie';               Lista:'T430';              Desc:'Inserimento automatico riposi'),
    (Nome:'C17_POSTILETTO';                           Crypt:'N'; Gruppo:'Varie';               Lista:'T430';              Desc:'Posti letto'),
    (Nome:'C18_ACCESSIMENSA';                         Crypt:'N'; Gruppo:'Varie';               Lista:'T430';              Desc:'Accessi mensa'),
    (Nome:'C23_CONTR_COMPETENZE';                     Crypt:'N'; Gruppo:'Varie';               Lista:'SN';                Desc:'Riallineamento causali concatenate'),
    (Nome:'C23_INSNEG_CATENA';                        Crypt:'N'; Gruppo:'Varie';               Lista:'SN';                Desc:'Inserimento negato per causali concatenate'),
    (Nome:'C23_VMH_FRUIZGG';                          Crypt:'N'; Gruppo:'Varie';               Lista:'SN';                Desc:'La Visita medica ad ore considera le fruizioni a gg'),
    (Nome:'C23_VMH_CUMULO_TRIENNIO';                  Crypt:'N'; Gruppo:'Varie';               Lista:'SN';                Desc:'La Visita medica ad ore è cumulata nel triennio della malattia'),
    (Nome:'C25_TIMBIRR_AUTO';                         Crypt:'N'; Gruppo:'Varie';               Lista:'SN';                Desc:'Ripristino automatico timbr.irregolari'),
    (Nome:'C29_CHIAMATEREP_FILTRO1';                  Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'T430';              Desc:'Reperibilità: filtro 1'),
    (Nome:'C29_CHIAMATEREP_FILTRO2';                  Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'T430';              Desc:'Reperibilità: filtro 2'),
    (Nome:'C29_CHIAMATEREP_DATIVIS';                  Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'T430_MULTI';        Desc:'Reperibilità: dati da visualizzare nelle info'),
    (Nome:'C29_CHIAMATEREP_DATIMODIF';                Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'C29_CHIAMATEREP_DATIVIS_MULTI'; Desc:'Reperibilità: dati modificabili dalle chiamate'),
    (Nome:'C29_CHIAMATEREP_DATOMOD';                  Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'C29_CHIAMATEREP_DATIVIS';       Desc:'Reperibilità: dato di default del recapito alternativo'),
    (Nome:'C29_W043_MODREPER_NUMGIORNI';              Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'NUMERICO';          Desc:'Reperibilità: giorni futuri modificabili in Modifica pers. reper.'),
    (Nome:'C29_W043_MODREPER_ORA_CUTOFF';             Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'ORA';               Desc:'Reperibilità: orario di cut-off in Modifica pers. reper.'),
    (Nome:'C29_CHIAMATEREP_DATOAGG1';                 Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'T430';              Desc:'Reperibilità: dato aggiuntivo 1 in pianificazione turno'),
    (Nome:'C29_CHIAMATEREP_DATOAGG2';                 Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'T430';              Desc:'Reperibilità: dato aggiuntivo 2 in pianificazione turno'),
    (Nome:'C31_NOTEGIUSTIFICATIVI';                   Crypt:'N'; Gruppo:'Varie';               Lista:'SN';                Desc:'Note per i giustificativi'),
    (Nome:'C31_GIUSTIF_GGMG';                         Crypt:'N'; Gruppo:'Varie';               Lista:'SN';                Desc:'Intersezione giustif. a giornata e mezza giornata'),
    (Nome:'C32_CHECK_AGGSCHEDA_ABIL';                 Crypt:'N'; Gruppo:'Varie';               Lista:'';                  Desc:'Condizione SQL di controllo per agg.to cartellino'),
    (Nome:'C32_SCRIPT_AGGSCHEDA_AFTER';               Crypt:'N'; Gruppo:'Varie';               Lista:'';                  Desc:'Procedura pl/sql post agg.to cartellino'),
    (Nome:'C32_SALDO_MESE_COMPENSATO';                Crypt:'N'; Gruppo:'Varie';               Lista:'';                  Desc:'Saldi mensili compensati con causali escluse'),
    (Nome:'C90_W009_WA027_USA_B028';                  Crypt:'N'; Gruppo:'Varie';               Lista:'SN';                Desc:'W009/WA027: stampa cartellino mediante B028 (no rave report)'),
    (Nome:'C2_BUDGET';                                Crypt:'N'; Gruppo:'Budget straord.';     Lista:'T430';              Desc:'B.S.: livello strutturale'),
    (Nome:'C2_CAPITOLO';                              Crypt:'N'; Gruppo:'Budget straord.';     Lista:'T430';              Desc:'Budget esterno - capitolo'),
    (Nome:'C2_ARTICOLO';                              Crypt:'N'; Gruppo:'Budget straord.';     Lista:'T430';              Desc:'Budget esterno - articolo'),
    (Nome:'C2_COSTO_ORARIO';                          Crypt:'N'; Gruppo:'Budget straord.';     Lista:'T430';              Desc:'Budget esterno - costo orario'),
    (Nome:'C2_WEBSRV_BILANCIO';                       Crypt:'N'; Gruppo:'Budget straord.';     Lista:'';                  Desc:'Budget esterno - web service'),
    (Nome:'C2_LIVELLO';                               Crypt:'N'; Gruppo:'Budget straord.';     Lista:'T430';              Desc:'B.S.: livello per monetizzazione'),
    (Nome:'C2_FACOLTATIVO';                           Crypt:'N'; Gruppo:'Budget straord.';     Lista:'SNL';               Desc:'B.S.: uso facoltativo del Budget'),
    (Nome:'C15_LIMITIMENSCAUS';                       Crypt:'N'; Gruppo:'Budget straord.';     Lista:'SN';                Desc:'Limiti mensili causalizzati'),
    (Nome:'C3_INDPRES';                               Crypt:'N'; Gruppo:'Profili indennità';   Lista:'T430';              Desc:'Indennità di presenza (Liv.1)'),
    (Nome:'C3_INDPRES2';                              Crypt:'N'; Gruppo:'Profili indennità';   Lista:'T430';              Desc:'Indennità di presenza (Liv.2)'),
    (Nome:'C3_DATOPIANIFICABILE';                     Crypt:'N'; Gruppo:'Profili indennità';   Lista:'C3_INDPRES';        Desc:'Indennità di presenza - Liv.pianificabile'),
    (Nome:'C3_RIEPTURNI_INDPRES';                     Crypt:'N'; Gruppo:'Profili indennità';   Lista:'SN';                Desc:'Riepilogo turni solo se maturazione indennità'),
    (Nome:'C3_DETTGG_TIPOI';                          Crypt:'N'; Gruppo:'Profili indennità';   Lista:'SN';                Desc:'Salvataggio dettaglio GG per ind.oraria'),
    (Nome:'C7_DATO1';                                 Crypt:'N'; Gruppo:'Incentivi';           Lista:'T430';              Desc:'Incentivi: dato 1'),
    (Nome:'C7_DATO2';                                 Crypt:'N'; Gruppo:'Incentivi';           Lista:'T430';              Desc:'Incentivi: dato 2'),
    (Nome:'C7_DATO3';                                 Crypt:'N'; Gruppo:'Incentivi';           Lista:'T430';              Desc:'Incentivi: dato 3'),
    (Nome:'C7_INIZIO_SOSPENSIONE';                    Crypt:'N'; Gruppo:'Incentivi';           Lista:'T430';              Desc:'Incentivi: inizio del periodo di sospensione prioritario'),
    (Nome:'C7_ESCLUDE_INCENTIVO';                     Crypt:'N'; Gruppo:'Incentivi';           Lista:'T430';              Desc:'Incentivi: esclude maturazione incentivo'),
    (Nome:'C8_MISSIONE';                              Crypt:'N'; Gruppo:'Missioni';            Lista:'T430';              Desc:'Trasferte: regole'),
    (Nome:'C8_MISSIONECOMMESSA';                      Crypt:'N'; Gruppo:'Missioni';            Lista:'T430';              Desc:'Trasferte: commessa'),
    (Nome:'C8_SEDE';                                  Crypt:'N'; Gruppo:'Missioni';            Lista:'T430';              Desc:'Trasferte: sede di riferimento'),
    (Nome:'C8_GESTIONEMENSILE';                       Crypt:'N'; Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte: gestione mensile'),
    (Nome:'C8_W032_RICHIEDI_TIPOMISSIONE';            Crypt:'N'; Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: richiesta del tipo trasferta'),
    (Nome:'C8_W032_RICHIEDI_TIPORIMBORSO';            Crypt:'N'; Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: richiesta del tipo rimborso'),
    (Nome:'C8_W032_DETTAGLIOGG';                      Crypt:'N'; Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: gestione servizio attivo'),
    (Nome:'C8_W032_DOCUMENTO_MISSIONI';               Crypt:'N'; Gruppo:'Missioni';            Lista:'';                  Desc:'Trasferte web: path documento informativo'),
    (Nome:'C8_W032_RIMBORSIDETT';                     Crypt:'N'; Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: dettaglio rimborsi'),
    (Nome:'C8_W032_RIAPRI_MISSIONE';                  Crypt:'N'; Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: riapertura trasferte liquidate'),
    (Nome:'C8_W032_TAPPE_SOLO_SU_DISTANZIOMETRO';     Crypt:'N'; Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: scelta tappe solo da distanziometro'),
    (Nome:'C8_W032_MESSAGGIO_TAPPE_INESISTENTI';      Crypt:'N'; Gruppo:'Missioni';            Lista:'';                  Desc:'Trasferte web: messaggio per tappe non previste'),
    (Nome:'C8_W032_CHECK_PERCORSO';                   Crypt:'N'; Gruppo:'Missioni';            Lista:'';                  Desc:'Trasferte web: funzione pl/sql di controllo del percorso'),
    (Nome:'C8_W032_NOTERIMB_EDITABILI';               Crypt:'N'; Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: note dei rimborsi editabili'),
    (Nome:'C8_W032_STATOMISSIONE_AUORIZZATA';         Crypt:'N'; Gruppo:'Missioni';            Lista:'DS';                Desc:'Trasferte web: stato della missione (D)a liquidare - (S)ospesa'),
    (Nome:'C8_W032_BLOCCA_DATE';                      Crypt:'N'; Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: blocca la modifica del periodo'),
    (Nome:'C11_PIANIFORARIPROG';                      Crypt:'N'; Gruppo:'Pianificazione turni';Lista:'SN';                Desc:'Pianificazione orari progressiva'),
    (Nome:'C11_PIANIFORARI_DEBGG';                    Crypt:'N'; Gruppo:'Pianificazione turni';Lista:'C11_MODORA_PUNTNOM';Desc:'Pianificazione orari: Debito GG'), //MODELLO ORARIO / PUNTI NOMINALI
    (Nome:'C11_PIANIFORARI_NO_COPIAGIUSTIF';          Crypt:'N'; Gruppo:'Pianificazione turni';Lista:'C11_NO_SOVR_AGG';   Desc:'Pianificazione orari no oper: copia giustificativi'), //NO / SOVRASCRIVI / AGGIUNGI
    (Nome:'C22_ENTE_GIURIDICO';                       Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Autocertificazione dati giuridici: Ente'),
    (Nome:'C22_INIZIO_RAP_GIURIDICO';                 Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Autocertificazione dati giuridici: Inizio rapp.'),
    (Nome:'C22_FINE_RAP_GIURIDICO';                   Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Autocertificazione dati giuridici: Fine rapp.'),
    (Nome:'C22_QUALIFICA_GIURIDICO';                  Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Autocertificazione dati giuridici: Qualifica'),
    (Nome:'C22_DISCIPLINA_GIURIDICO';                 Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Autocertificazione dati giuridici: Disciplina'),
    (Nome:'C1_CEDOLINICONVALUTA';                     Crypt:'N'; Gruppo:'Economico';           Lista:'SN';                Desc:'Gestione cedolini con valuta'),
    (Nome:'C34_CRIPTA_SINGOLI_CEDOLINI';              Crypt:'N'; Gruppo:'Economico';           Lista:'SN';                Desc:'Cifratura singoli cedolini / CU in formato PDF'),
    (Nome:'C5_OFFICE';                                Crypt:'N'; Gruppo:'Giuridico';           Lista:'OFFICE';            Desc:'Stampa certificati: pacchetto office'),
    (Nome:'C12_PREFERENZADEST';                       Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Preferenze destinazione'),
    (Nome:'C12_PREFERENZACOMP';                       Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Preferenze competenza'),
    (Nome:'C14_PROVVSEDE';                            Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Provvedimenti: sede'),
    (Nome:'C20_INCARICOUNITAORG';                     Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Incarichi: unità organizzativa'),
    (Nome:'C10_FORMAZPROFCRED';                       Crypt:'N'; Gruppo:'Formazione';          Lista:'T430';              Desc:'Formazione: profili crediti'),
    (Nome:'C10_FORMAZPROFCORSO';                      Crypt:'N'; Gruppo:'Formazione';          Lista:'T430';              Desc:'Formazione: filtro partecipanti'),
    (Nome:'C21_VALUTAZIONI_LIV1';                     Crypt:'N'; Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: livello 1'),
    (Nome:'C21_VALUTAZIONI_LIV2';                     Crypt:'N'; Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: livello 2'),
    (Nome:'C21_VALUTAZIONI_LIV3';                     Crypt:'N'; Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: livello 3'),
    (Nome:'C21_VALUTAZIONI_LIV4';                     Crypt:'N'; Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: livello 4'),
    (Nome:'C21_VALUTAZIONI_RSP1';                     Crypt:'N'; Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: raggrupp.responsabili Livello 1'),
    (Nome:'C21_VALUTAZIONI_RSP2';                     Crypt:'N'; Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: raggrupp.responsabili Livello 2'),
    (Nome:'C21_VALUTAZIONI_PNT1';                     Crypt:'N'; Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: raggrupp. scale punteggi'),
    (Nome:'C21_EMAIL_DEST_INDIRIZZO';                 Crypt:'N'; Gruppo:'Valutazioni';         Lista:'';                  Desc:'Valutazioni: email del destinatario per notifiche'),
    (Nome:'C5_INTEGRAZANAG';                          Crypt:'N'; Gruppo:'Sistema';             Lista:'NFT';               Desc:'Integrazione anagrafica'),
    (Nome:'C24_AZIENDABUDGET';                        Crypt:'N'; Gruppo:'Sistema';             Lista:'SN';                Desc:'Azienda di tipo budget'),
    (Nome:'C26_HINTT030V430';                         Crypt:'N'; Gruppo:'Sistema';             Lista:'';                  Desc:'Hint da usare nelle query su V430_STORICO'),
    (Nome:'C26_C018_HINT';                            Crypt:'N'; Gruppo:'Sistema';             Lista:'';                  Desc:'Hint LEADING/ORDERED da usare nelle query degli iter autorizzativi'),
    (Nome:'C26_C018_UNNEST';                          Crypt:'N'; Gruppo:'Sistema';             Lista:'SN';                Desc:'Hint UNNEST da usare nelle query degli iter autorizzativi'),
    (Nome:'C26_V430MATERIALIZZATA';                   Crypt:'N'; Gruppo:'Sistema';             Lista:'SN';                Desc:'V430_STORICO materializzata'),
    (Nome:'C27_TABLESPACE_FREE';                      Crypt:'N'; Gruppo:'Sistema';             Lista:'';                  Desc:'Limite minimo di spazio libero sui tablespace (MB)'),
    (Nome:'C28_CANCELLA_ANNO_LOG';                    Crypt:'N'; Gruppo:'Sistema';             Lista:'NUMERICO';          Desc:'Numero di anni di mantenimento dei log'),
    (Nome:'C90_PATH_ALLEGATI';                        Crypt:'N'; Gruppo:'Sistema';             Lista:'';                  Desc:'Path dello storage dove registrare gli allegati'),
    (Nome:'C90_ITER_MAX_DIM_ALLEGATO_MB';             Crypt:'N'; Gruppo:'Sistema';             Lista:'NUMERICO';          Desc:'Dimensione massima dei documenti (MB)'),
    (Nome:'C33_LINK_I070_T030';                       Crypt:'N'; Gruppo:'Varie';               Lista:'NOF';               Desc:'Operatori collegati alle anagrafiche'),
    (Nome:'C33_PROXY_SERVER';                         Crypt:'N'; Gruppo:'Sistema';             Lista:'';                  Desc:'Proxy (host:port)'),
    (Nome:'C33_PROXY_USER';                           Crypt:'N'; Gruppo:'Sistema';             Lista:'';                  Desc:'Proxy user'),
    (Nome:'C33_PROXY_PASSWORD';                       Crypt:'S'; Gruppo:'Sistema';             Lista:'';                  Desc:'Proxy password'),
    (Nome:'C30_WEBSRV_B021_URL';                      Crypt:'N'; Gruppo:'Web services';        Lista:'';                  Desc:'URL web service B021'),
    (Nome:'C30_WEBSRV_A004_URL';                      Crypt:'N'; Gruppo:'Web services';        Lista:'';                  Desc:'URL Inserimento giustificativi'),
    (Nome:'C30_WEBSRV_A004_DATI';                     Crypt:'N'; Gruppo:'Web services';        Lista:'';                  Desc:'Dati per inserimento giustificativi'),
    (Nome:'C30_WEBSRV_A025_URL_GET';                  Crypt:'N'; Gruppo:'Web services';        Lista:'';                  Desc:'URL lettura turni'),
    (Nome:'C30_WEBSRV_A025_URL_PUT';                  Crypt:'N'; Gruppo:'Web services';        Lista:'';                  Desc:'URL pianificazione turni'),
    (Nome:'C30_WEBSRV_B021_TOKEN';                    Crypt:'N'; Gruppo:'Web services';        Lista:'SN';                Desc:'Autenticazione richiesta per i servizi web'),
    (Nome:'C30_WEBSRV_B021_PASSPHRASE';               Crypt:'S'; Gruppo:'Web services';        Lista:'';                  Desc:'Passphrase SHA1 per il token di accesso'),
    (Nome:'C30_WEBSRV_B021_TIMEOUT';                  Crypt:'N'; Gruppo:'Web services';        Lista:'NUMERICO';          Desc:'Timeout del token di accesso (secondi)'),
    (Nome:'C30_WEBSRV_X004_URL';                      Crypt:'N'; Gruppo:'Web services';        Lista:'';                  Desc:'URL portale ECM'),
    (Nome:'C35_RESIDUI_TRIGGER_BEFORE';               Crypt:'N'; Gruppo:'Passaggio di anno';   Lista:'SN';                Desc:'Esecuzione procedura Oracle prima dell''elaborazione'),
    (Nome:'C35_RESIDUI_TRIGGER_AFTER';                Crypt:'N'; Gruppo:'Passaggio di anno';   Lista:'SN';                Desc:'Esecuzione procedura Oracle dopo l''elaborazione'),
    (Nome:'C36_ORDPROFSAN_CODICE';                    Crypt:'N'; Gruppo:'Giuridico';           Lista:'T430';              Desc:'Individua ordine professionale'),
    (Nome:'C36_ORDPROFSAN_EMAIL_VAR';                 Crypt:'N'; Gruppo:'Giuridico';           Lista:'';                  Desc:'Indirizzo Email per comunicazione delle variazioni Iscr.Ordine'),
    (Nome:'C36_ORDPROFSAN_CAMPI_OBB';                 Crypt:'N'; Gruppo:'Giuridico';           Lista:'SG220';             Desc:'Altri campi obbligatori iscrizione ordine professionale'),
    (Nome:'C40_WEBSRV_USER';                          Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'';                  Desc:'PerlaPA: username per invio dati tramite WebService'),
    (Nome:'C40_WEBSRV_PWD';                           Crypt:'S'; Gruppo:'Interfaccia PerlaPA'; Lista:'';                  Desc:'PerlaPA: password per invio dati tramite WebService'),
    (Nome:'C40_ENTEL104';                             Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'';                  Desc:'L104: codice ente per invio dati tramite WebService'),
    (Nome:'C40_WEBSRV_URLL104';                       Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'';                  Desc:'L104: URL per invio dati tramite WebService'),
    (Nome:'C40_ENTEGEDAP';                            Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'';                  Desc:'Gedap: codice ente per invio permessi sindacali tramite WebService'),
    (Nome:'C40_WEBSRV_URLGEDAP';                      Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'';                  Desc:'Gedap: URL per invio permessi sindacali tramite WebService'),
    (Nome:'C40_INVIOGEDAP';                           Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'SN';                Desc:'Gedap: invio permessi sindacali tramite WebService'),
    (Nome:'C40_QUALIFICA';                            Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'T430';              Desc:'Gedap: qualifica'),
    (Nome:'C40_DISTACCOSEDE_COMUNEDEF';               Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'';                  Desc:'Gedap: distaccamento sede: comune di default'),
    (Nome:'C40_DISTACCOSEDE_COMUNE';                  Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'T430';              Desc:'Gedap: distaccamento sede: comune'),
    (Nome:'C40_DISTACCOSEDE_INDIRIZZO';               Crypt:'N'; Gruppo:'Interfaccia PerlaPA'; Lista:'T430';              Desc:'Gedap: distaccamento sede: indirizzo'),
    (Nome:'C90_LINGUA';                               Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Lingua dizionario'),
    (Nome:'C90_NOMEPROFILODELEGA';                    Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Nome profilo da delegare'),
    (Nome:'C90_FILTRO_DELEGHE';                       Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Filtro anagrafiche da delegare'),
    (Nome:'C90_WEBAUTORIZCURRIC';                     Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'SN';                Desc:'Autorizzazione curriculum'),
    (Nome:'C90_WEBRIGHEPAG';                          Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'NUMERICO';          Desc:'Numero di righe per tabella'),
    (Nome:'C90_W005SETTIMANE';                        Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'NUMERICO';          Desc:'Periodo di visualizzazione cartellino'),
    (Nome:'C90_NOTIFICATORE_ATTIVITA';                Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'SN';                Desc:'Notificatore delle attività'),
    (Nome:'C90_FILTROANAG_CONSIDERA_RICH_CESSATI';    Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'SN';                Desc:'Considera richieste personale cessato'),
    (Nome:'C90_EMAIL_SINCR_DOMINIO';                  Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'SN';                Desc:'Email sincronizzata con account di dominio'),
    (Nome:'C90_CELLULARE_LUNGHMIN';                   Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'NUMERICO';          Desc:'Lungh.minima numero di cellulare'),
    (Nome:'C90_CONTATTI_AZIENDALI';                   Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'SNR';               Desc:'Contatti aziendali accessibili nella Gestione credenziali'),
    (Nome:'C90_CONTATTI_PERSONALI';                   Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'SNR';               Desc:'Contatti personali accessibili nella Gestione credenziali'),
    (Nome:'C90_W034GIORNO_MESE_DISP_CEDOLINO';        Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'GIORNO_MESE';       Desc:'Giorno del mese di disponibilità dei cedolini in Pubblicazione Documenti'),
    (Nome:'C90_W034WS_USER';                          Crypt:'N'; Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'User per l''accesso al webservice per cedolini e CU in Pubblicazione Documenti'),
    (Nome:'C90_W034WS_PASSWORD';                      Crypt:'S'; Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Password per l''accesso al webservice per cedolini e CU in Pubblicazione Documenti'),
    (Nome:'C90_EMAIL_SMTPHOST';                       Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Host SMTP per servizio mail'),
    (Nome:'C90_EMAIL_USERNAME';                       Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'UserName per servizio mail'),
    (Nome:'C90_EMAIL_PASSWORD';                       Crypt:'S'; Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'PassWord per servizio mail'),
    (Nome:'C90_EMAIL_PORT';                           Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'NUMERICO';          Desc:'Porta per servizio mail'),
    (Nome:'C90_EMAIL_HELONAME';                       Crypt:'N'; Gruppo:'IrisWEB-EMail';       Lista:'';                  Desc:'HeloName per servizio mail'),
    (Nome:'C90_EMAIL_AUTHTYPE';                       Crypt:'N'; Gruppo:'IrisWEB-EMail';       Lista:'C90_AUTENTICAZIONI';Desc:'Tipo di autenticazione mail'),
    (Nome:'C90_EMAIL_USETLS';                         Crypt:'N'; Gruppo:'IrisWEB-EMail';       Lista:'C90_USETLS';        Desc:'Uso di TLS per servizio mail'),
    (Nome:'C90_EMAIL_SENDER_INDIRIZZO';               Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Indirizzo mail del mittente per notifiche'),
    (Nome:'C90_EMAIL_SENDER';                         Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Nome del mittente per notifiche'),
    (Nome:'C90_EMAIL_W010UFF';                        Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'SN';                Desc:'Servizio mail per elaborazione assenze'),
    (Nome:'C90_EMAIL_W018UFF';                        Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'SN';                Desc:'Servizio mail per elaborazione timbrature'),
    (Nome:'C90_EMAIL_THREAD';                         Crypt:'N'; Gruppo:'IrisWEB-EMail';       Lista:'SN';                Desc:'Servizio mail con invio asincrono'),
    (Nome:'C90_EMAIL_RESP_OTTIMIZZATA';               Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'SN';                Desc:'Servizio mail ottimizzato per le richieste'),
    (Nome:'C90_EMAIL_RESP_GG_REINVIO';                Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'NUMERICO';          Desc:'Limite di GG per servizio mail ottimizzato'),
    (Nome:'C90_EMAIL_RESP_OGGETTO';                   Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Oggetto mail ottimizzata'),
    (Nome:'C90_EMAIL_RESP_TESTO';                     Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Testo mail ottimizzata'),
    (Nome:'C90_EMAIL_DATIP430';                       Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'SN';                Desc:'Filtro anagrafe responsabili referenzia dati di P430'),
    (Nome:'C90_W026UTILIZZO_DAL';                     Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'GIORNO_MESE';       Desc:'Primo giorno del mese per richiedere ecced.gg'),
    (Nome:'C90_W026UTILIZZO_AL';                      Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'GIORNO_MESE';       Desc:'Ultimo giorno del mese per richiedere ecced.gg'),
    (Nome:'C90_W026MMINDIETRODAL';                    Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'NUMERICO';          Desc:'Primo mese antecedente al corrente per richiesta ecced.gg'),
    (Nome:'C90_W026MMINDIETROAL';                     Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'NUMERICO';          Desc:'Ultimo mese antecedente al corrente per richiesta ecced.gg'),
    (Nome:'C90_W026TIPO_RICHIESTA';                   Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'RA';                Desc:'Iter ecced.gg con Richiesta o solo Autorizzazione'),
    (Nome:'C90_W026CAUS_E';                           Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'T275';              Desc:'Causale per straordinario su entrata'),
    (Nome:'C90_W026CAUS_U';                           Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'T275';              Desc:'Causale per straordinario su uscita'),
    (Nome:'C90_W026TIPO_AUTORIZZAZIONE';              Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'GP';                Desc:'Tipo autorizzazione ecced.gg (causali Pianificate o Giustificativi)'),
    (Nome:'C90_W026SPEZZONI';                         Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'EUT';               Desc:'Tipo spezzoni ecced.gg (Entrata/Uscita/Tutti)'),
    (Nome:'C90_W026INCLUDISPEZZONIFUORIORARIO';       Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Considera anche gli spezzoni fuori orario come ecced.gg'),
    (Nome:'C90_W026TIPO_STRAORD';                     Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'NA';                Desc:'Tipo ore ecced.gg (Abilitate/Non abilitate)'),
    (Nome:'C90_W026ECCEDOLTREDEBITO';                 Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Ecced.gg deve superare il debito gg'),
    (Nome:'C90_W026ECCEDGG_TUTTA';                    Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Iter ecced.gg deve usare tutta l''eccedenza disponibile'),
    (Nome:'C90_W026ARROTONDAMENTO';                   Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'NUMERICO';          Desc:'Arrotondamento dell''ecced.gg richiesta'),
    (Nome:'C90_W026SPEZZONEMINIMO';                   Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'NUMERICO';          Desc:'Ecced.gg minima autorizzabile'),
    (Nome:'C90_W026SOGLIAECCEDENZA';                  Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'NUMERICO';          Desc:'Soglia eccedenza sotto la quale viene tolto lo Spezzone Minimo'),
    (Nome:'C90_W026CHECKSALDODISPONIBILE';            Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Iter ecced.gg verifica il saldo mensile disponibile'),
    (Nome:'C90_W026DATIINVISIBILI';                   Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'';                  Desc:'Iter ecced.gg - dati invisibili'),
    (Nome:'C90_W026AUTORIZZ_OBBL';                    Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Ecced.gg richiede autorizzazione obbligatoria'),
    (Nome:'C90_W026CAUSABBATT_GIUSTASS';              Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'T265';              Desc:'Causale di abbattimento se eccedenza da giustificativi'),
    (Nome:'C90_W026ACCORPA_SPEZZONI';                 Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Gli spezzoni contigui vengono accorpati'),
    (Nome:'C90_W026PIANIF_FORZATA';                   Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Gli spezzoni non causalizzati rimangono sul turno originale'),
    (Nome:'C90_W026CONFERMA_AUTORIZZAZIONI';          Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Autorizzazione in due passaggi'),
    (Nome:'C90_W026MODIFICA_TUTTO';                   Crypt:'N'; Gruppo:'IrisWEB-Ecced.gg';    Lista:'NARE';              Desc:'Modalità di modifica dell''intera pagina'),
    (Nome:'C90_CRONOLOGIA_NOTE';                      Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Cronologia note negli iter autorizzativi'),
    (Nome:'C90_ITER_MAX_ALLEGATI';                    Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Max allegati consentiti per richiesta'),
    (Nome:'C90_ITER_ESTENSIONE_ALLEGATO';             Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'';                  Desc:'Web: estensioni ammesse per gli allegati'),
    (Nome:'C90_ITER_ORDINA_DATA_RICHIESTA';           Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Ordina le richieste da autorizzare per data richiesta'),
    (Nome:'C90_W009ANOM_BLOCCANTI';                   Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'R502ANM';           Desc:'Anomalie che impediscono la validazione dei cartellini'),
    (Nome:'C90_W010CAUS_PRES';                        Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Richiesta giustificativi di presenza'),
    (Nome:'C90_W010CANCELLAZIONE';                    Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Cancellazione parziale del periodo di assenza richiesto'),
    (Nome:'C90_W010ANOM_NONBLOCCANTI';                Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'R600ANM';           Desc:'Anomalie da ignorare nell''acquisizione assenze sul cartellino'),
    (Nome:'C90_W010ACQUISIZIONE_AUTO';                Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Acquisizione automatica assenze sul cartellino'),
    (Nome:'C90_W018ACQUISIZIONE_AUTO';                Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Acquisizione automatica timbrature sul cartellino'),
    (Nome:'C90_W024MMINDIETRO';                       Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Mese antecedente al corrente per richiesta straord.'),
    (Nome:'C90_W024MMINDIETRORITARDO';                Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Mesi di ritardo tollerabili per autorizzazione straord.'),
    (Nome:'C90_WEBTIPOCAMBIOORARIO';                  Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'ICE';               Desc:'Tipologia cambio orario'),
    (Nome:'C90_WEBSETTCAMBIOORARIO';                  Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Settimane per cambio orario'),
    (Nome:'C90_ITER_DIM_MAX_ALLEGATI_DOWNLOAD';       Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Dimensione massima degli allegati scaricabile massivamente [MB]'),
    (Nome:'C90_ITER_NR_MAX_ALLEGATI_DOWNLOAD';        Crypt:'N'; Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Numero massimo degli allegati scaricabili massivamente'),
    (Nome:'C90_MESSAGGISTICA_REPLY';                  Crypt:'N'; Gruppo:'IrisWEB-Messaggistica';Lista:'SN';               Desc:'Abilita risposte'),
    (Nome:'C90_MESSAGGISTICA_APRIDETTAGLIO';          Crypt:'N'; Gruppo:'IrisWEB-Messaggistica';Lista:'SN';               Desc:'Apertura automatica dettaglio messaggi'),
    (Nome:'C90_MESSAGGISTICA_OBBLIGOLETTURA';         Crypt:'N'; Gruppo:'IrisWEB-Messaggistica';Lista:'SN';               Desc:'Messaggi con lettura obbligatoria'),
    (Nome:'C90_MESSAGGI_OBBLIGATORI_BLOCCANTI';       Crypt:'N'; Gruppo:'IrisWEB-Messaggistica';Lista:'SN';               Desc:'Accesso bloccato se messaggi con lettura obbligatoria'),
    (Nome:'C90_W035MAX_DIM_ALLEGATO_MB';              Crypt:'N'; Gruppo:'IrisWEB-Messaggistica';Lista:'NUMERICO';         Desc:'Dimensione massima di ogni allegato (MB)'),
    (Nome:'C90_W035MAX_ALLEGATI';                     Crypt:'N'; Gruppo:'IrisWEB-Messaggistica';Lista:'NUMERICO';         Desc:'Numero massimo di allegati per messaggio'),
    (Nome:'C90_W035QUOTA_ALLEGATI_MB';                Crypt:'N'; Gruppo:'IrisWEB-Messaggistica';Lista:'NUMERICO';         Desc:'Quota di spazio assegnata per gli allegati (MB)'),
    (Nome:'C90_W035MODALITA_CANC_MESSAGGI_INVIATI';   Crypt:'N'; Gruppo:'IrisWEB-Messaggistica';Lista:'W035_NAT';         Desc:'Modalità cancellazione messaggi inviati: (N)o / (A)llegati / (T)utto'),
    (Nome:'C90_W035MESI_DOPO_INVIO_CANC_MESSAGGI';    Crypt:'N'; Gruppo:'IrisWEB-Messaggistica';Lista:'NUMERICO';         Desc:'Mesi dopo invio per consentire cancellazione messaggi'),
    (Nome:'C90_W038TOLLERANZA_E';                     Crypt:'N'; Gruppo:'IrisWEB-Timbratura virtuale'; Lista:'NUMERICO';  Desc:'Tolleranza timbratura virtuale in E'),
    (Nome:'C90_W038TOLLERANZA_U';                     Crypt:'N'; Gruppo:'IrisWEB-Timbratura virtuale'; Lista:'NUMERICO';  Desc:'Tolleranza timbratura virtuale in U'),
    (Nome:'C90_W038RILEVATORE';                       Crypt:'N'; Gruppo:'IrisWEB-Timbratura virtuale'; Lista:'';          Desc:'Codice Rilevatore Virtuale IrisWeb'),
    (Nome:'C90_W038RILEVATORE_MOBILE';                Crypt:'N'; Gruppo:'IrisWEB-Timbratura virtuale'; Lista:'';          Desc:'Codice Rilevatore Virtuale mobile'),
    (Nome:'C90_W038FILTRO_ANAG_RILEVATORE_MOBILE';    Crypt:'N'; Gruppo:'IrisWEB-Timbratura virtuale'; Lista:'SN';        Desc:'Rilevatori virtuali mobili da abilitazione anagrafica'),
    (Nome:'C90_W038NUMGGVISIBILI';                    Crypt:'N'; Gruppo:'IrisWEB-Timbratura virtuale'; Lista:'NUMERICO';  Desc:'gg visibili in Timbratura Virtuale'),
    (Nome:'C90_W038TIMBCAUSALIZZABILE';               Crypt:'N'; Gruppo:'IrisWEB-Timbratura virtuale'; Lista:'SN';        Desc:'Timbratura virtuale con causale'),
    (Nome:'C90_W038CHECKIP';                          Crypt:'N'; Gruppo:'IrisWEB-Timbratura virtuale'; Lista:'SN';        Desc:'Controllo accesso alla Timbratura Virtuale'),
    (Nome:'C90_W038TRIGGERBEFORE';                    Crypt:'N'; Gruppo:'IrisWEB-Timbratura virtuale'; Lista:'SN';        Desc:'Attivazione procedura TIMBVIRT_TRIGGER_BEFORE'),
    (Nome:'C90_SSO_TIPO';                             Crypt:'n'; Gruppo:'IrisWEB-SSO';         Lista:'SSO';               Desc:'Tipo SSO'),
    (Nome:'C90_SSO_OAUTH2_PASSPHRASE';                Crypt:'S'; Gruppo:'IrisWEB-SSO';         Lista:'';                  Desc:'Passphrase OAuth2'),
    (Nome:'C90_SSO_OAUTH2_CLIENTID';                  Crypt:'N'; Gruppo:'IrisWEB-SSO';         Lista:'';                  Desc:'ID Client OAuth2'),
    (Nome:'C90_SSO_OAUTH2_URLGETTOKEN';               Crypt:'N'; Gruppo:'IrisWEB-SSO';         Lista:'';                  Desc:'URL OAuth2 per ottenere Token'),
    (Nome:'C90_SSO_OAUTH2_URLGETUSER';                Crypt:'N'; Gruppo:'IrisWEB-SSO';         Lista:'';                  Desc:'URL OAuth2 per ottenere User'),
    (Nome:'C90_SSO_OAUTH2_INFOUSER';                  Crypt:'N'; Gruppo:'IrisWEB-SSO';         Lista:'';                  Desc:'Riferimento dello user OAuth2'),
    (Nome:'C90_SSO_SHA1PASSPHRASE';                   Crypt:'S'; Gruppo:'IrisWEB-SSO';         Lista:'';                  Desc:'Passphrase SHA1'),
    (Nome:'C90_SSO_RDLPASSPHRASE';                    Crypt:'S'; Gruppo:'IrisWEB-SSO';         Lista:'';                  Desc:'Passphrase RDL'),
    (Nome:'C90_SSO_USRMASK';                          Crypt:'N'; Gruppo:'IrisWEB-SSO';         Lista:'';                  Desc:'Mask User/Timestamp'),
    (Nome:'C90_SSO_TIMEOUT';                          Crypt:'N'; Gruppo:'IrisWEB-SSO';         Lista:'NUMERICO';          Desc:'Timeout token (secondi)'),
    (Nome:'C45_LARCHIVE_PRODUCERID';                  Crypt:'N'; Gruppo:'Archiviazione LArchive';Lista:'';                Desc:'Identificativo dell''ente produttore'),
    (Nome:'C45_LARCHIVE_TOKENJWT';                    Crypt:'S'; Gruppo:'Archiviazione LArchive';Lista:'';                Desc:'Token JWT per HTTP Bearer Authentication'),
    (Nome:'C45_LARCHIVE_SCADENZA_TOKENJWT';           Crypt:'N'; Gruppo:'Archiviazione LArchive';Lista:'';                Desc:'Data di scadenza token JWT (dd/MM/yyyy)'),
    (Nome:'C45_LARCHIVE_URL_VERSAMENTO';              Crypt:'N'; Gruppo:'Archiviazione LArchive';Lista:'';                Desc:'URL di versamento'),
    (Nome:'C45_LARCHIVE_URL_STATO';                   Crypt:'N'; Gruppo:'Archiviazione LArchive';Lista:'';                Desc:'URL di verifica stato Pdv')
  );

  lstRiepiloghi: array[0..31] of String =
      ('T040 - Giustificativi',
       'T080 - Pianificazione',
       'T081I- Pianificazione iniziale',
       'T081C- Pianificazione corrente',
       'T100 - Timbrature',
       'T070 - Scheda riepilogativa',
       'T077 - Dati atipici',
       'T071A- Ore di assestamento',
       'T071S- Liquidazione straordinario',
       'T074 - Liquidazione ore causalizzate',
       'T134 - Liquidazione ore anni prec.',
       'T195 - Scarico paghe',
       'T320 - Libera professione',
       'T332 - Prestazioni aggiuntive',
       'T340 - Reperibilità',
       'T380 - Pianificazione reperibilità',
       'T410 - Pasti',
       'T370 - Timbrature mensa',
       'T375 - Accessi mensa',
       'T680 - Buoni pasto',
       'T690 - Acquisto buoni',
       'T762 - Incentivi',
       'T130 - Residui saldi',
       'T131 - Residui presenze',
       'T264 - Residui assenze',
       'T692 - Residuo buoni',
       'SG656- Residuo crediti formativi',
       'T820 - Limiti individuali mensili',
       'T825 - Limiti individuali annuali',
       'M040 - Missioni liquidate',
       'T860 - Validazione cartellini',
       'T250 - Notifica scioperi'
      );

  lstColori: array[0..22] of TColori = (
    (Nome:'arancio chiaro'; Numero:TColors.Burlywood;    StyleWEB:'#DEB887';  ClassWEB:'bg_arancio_chiaro';  Testo:'';    Sfondo:'S'),
    (Nome:'arancio';        Numero:TColors.Orange;       StyleWEB:'#FFA500';  ClassWEB:'bg_arancio';         Testo:'';    Sfondo:'S'),
    (Nome:'azzurro';        Numero:TColors.Aqua;         StyleWEB:'#00FFFF';  ClassWEB:'bg_aqua';            Testo:'S';   Sfondo:'S'),
    (Nome:'bianco';         Numero:TColors.White;        StyleWEB:'#FFFFFF';  ClassWEB:'bg_white';           Testo:'S';   Sfondo:'S'),
    (Nome:'blu';            Numero:TColors.Blue;         StyleWEB:'#0000FF';  ClassWEB:'bg_blu';             Testo:'S';   Sfondo:''),
    (Nome:'blu scuro';      Numero:TColors.Navy;         StyleWEB:'#000080';  ClassWEB:'bg_navy';            Testo:'S';   Sfondo:''),
    (Nome:'bordeaux';       Numero:TColors.Maroon;       StyleWEB:'#800000';  ClassWEB:'bg_bordeaux';        Testo:'S';   Sfondo:''),
    (Nome:'celeste';        Numero:TColors.Deepskyblue;  StyleWEB:'#A0E4FF';  ClassWEB:'bg_celeste';         Testo:'';    Sfondo:'S'),
    (Nome:'fucsia';         Numero:TColors.Fuchsia;      StyleWEB:'#F400A1';  ClassWEB:'bg_fucsia';          Testo:'S';   Sfondo:'S'),
    (Nome:'giallo';         Numero:TColors.Yellow;       StyleWEB:'#FFFF00';  ClassWEB:'bg_giallo';          Testo:'S';   Sfondo:'S'),
    (Nome:'grigio';         Numero:TColors.Gray;         StyleWEB:'#B1B1B1';  ClassWEB:'bg_grigio';          Testo:'S';   Sfondo:'S'),
    (Nome:'grigio chiaro';  Numero:TColors.LtGray;       StyleWEB:'#F0F0F0';  ClassWEB:'bg_grigio_chiaro';   Testo:'S';   Sfondo:''),
    (Nome:'lime';           Numero:TColors.Limegreen;    StyleWEB:'#32CD32';  ClassWEB:'bg_limegreen';       Testo:'';    Sfondo:'S'),
    (Nome:'nero';           Numero:TColors.Black;        StyleWEB:'#000000';  ClassWEB:'bg_black';           Testo:'S';   Sfondo:''),
    (Nome:'prugna';         Numero:TColors.Plum;         StyleWEB:'#DDA0DD';  ClassWEB:'bg_prugna';          Testo:'';    Sfondo:'S'),
    (Nome:'rosso';          Numero:TColors.Red;          StyleWEB:'#FF0000';  ClassWEB:'bg_rosso';           Testo:'S';   Sfondo:'S'),
    (Nome:'rosso scuro';    Numero:TColors.Brown;        StyleWEB:'#A52A2A';  ClassWEB:'bg_rosso_scuro';     Testo:'';    Sfondo:'S'),
    (Nome:'turchese scuro'; Numero:TColors.Lightblue;    StyleWEB:'#ADD8E6';  ClassWEB:'bg_turchese_scuro';  Testo:'';    Sfondo:'S'),
    (Nome:'verde';          Numero:TColors.Green;        StyleWEB:'#00FF00';  ClassWEB:'bg_verde';           Testo:'S';   Sfondo:''),
    (Nome:'verde oliva';    Numero:TColors.Olive;        StyleWEB:'#808000';  ClassWEB:'bg_olive';           Testo:'S';   Sfondo:''),
    (Nome:'verde acqua';    Numero:TColors.Teal;         StyleWEB:'#00FF00';  ClassWEB:'bg_verde5';          Testo:'S';   Sfondo:''),
    (Nome:'verde limone';   Numero:TColors.Lime;         StyleWEB:'#00FF00';  ClassWEB:'bg_lime';            Testo:'S';   Sfondo:''),
    (Nome:'viola';          Numero:TColors.Purple;       StyleWEB:'#8F00FF';  ClassWEB:'bg_viola';           Testo:'S';   Sfondo:'')
  );

  //Usato da TR600DtM1.ControlliRichiestaGiust
  ERR_DATIGIUST_001 = 'E001';
  ERR_DATIGIUST_002 = 'E002';
  ERR_DATIGIUST_003 = 'E003';
  ERR_DATIGIUST_004 = 'E004';
  ERR_DATIGIUST_005 = 'E005';
  ERR_DATIGIUST_006 = 'E006';
  ERR_DATIGIUST_007 = 'E007';
  ERR_DATIGIUST_008 = 'E008';
  ERR_DATIGIUST_009 = 'E009';
  ERR_DATIGIUST_010 = 'E010';
  ERR_DATIGIUST_011 = 'E011';
  ERR_DATIGIUST_012 = 'E012';
  ERR_DATIGIUST_013 = 'E013';
  ERR_DATIGIUST_014 = 'E014';
  ERR_DATIGIUST_015 = 'E015';
  ERR_DATIGIUST_016 = 'E016';
  ERR_DATIGIUST_017 = 'E017';
  ERR_DATIGIUST_018 = 'E018';
  ERR_DATIGIUST_019 = 'E019';
  ERR_DATIGIUST_020 = 'E020';
  ERR_DATIGIUST_021 = 'E021';
  ERR_DATIGIUST_022 = 'E022';
  ERR_DATIGIUST_023 = 'E023';
  ERR_DATIGIUST_024 = 'E024';
  ERR_DATIGIUST_025 = 'E025';
  ERR_DATIGIUST_026 = 'E026';
  ERR_DATIGIUST_027 = 'E027';
  ERR_DATIGIUST_028 = 'E028';
  ERR_DATIGIUST_029 = 'E029';
  ERR_DATIGIUST_030 = 'E030';
  ERR_DATIGIUST_031 = 'E031';
  ERR_DATIGIUST_032 = 'E032';
  ERR_DATIGIUST_033 = 'E033';
  ERR_DATIGIUST_034 = 'E034';
  ERR_DATIGIUST_035 = 'E035';

  MSG_DATIGIUST_001 = 'M001';
  MSG_DATIGIUST_002 = 'M002';
  MSG_DATIGIUST_003 = 'M003';
  MSG_DATIGIUST_004 = 'M004';
  MSG_DATIGIUST_009 = 'M009';

  RSP_DATIGIUST_SI = 'SI';
  RSP_DATIGIUST_NO = 'NO';
  //

  //Usato da A023FTimbratureMW.ControlliRichiestaTimb
  ERR_DATIRICTIMB_001 = 'E001';
  ERR_DATIRICTIMB_002 = 'E002';
  ERR_DATIRICTIMB_003 = 'E003';
  ERR_DATIRICTIMB_004 = 'E004';
  ERR_DATIRICTIMB_005 = 'E005';

  MSG_DATIRICTIMB_001 = 'M001';

  // usato da A023FTimbratureMW.CtrlRegistraTimbratura
  MSG_DATITIMB_001    = 'M001';
  MSG_DATITIMB_002    = 'M002';
  MSG_DATITIMB_003    = 'M003';

  ERR_DATITIMB_001    = 'E001';
  ERR_DATITIMB_002    = 'E002';

  //File installati su DB  (assegnare Id < -500)
  VettFileInstallati : TVettFileInsallati =
                 ((Id:-501; NomeFile:'TMVW_MEDP.EXE'; Descrizione:'Supporto remoto'; Codice: Supporto));

  //Voci per scarico paghe
  VettConst : TVettVociPaghe =
                 ((CodInt:'010';Descrizione:'Saldo mese negativo      ';Ordine:010;VocePaghe:'S';Misura:'H'),
                  (CodInt:'020';Descrizione:'Saldo mese positivo      ';Ordine:020;VocePaghe:'S';Misura:'H'),
                  (CodInt:'022';Descrizione:'Saldo mes.pos. senza ass.';Ordine:022;VocePaghe:'S';Misura:'H'),
                  (CodInt:'030';Descrizione:'Ore lavorate in fasce    ';Ordine:030;VocePaghe:'N';Misura:'H'),
                  (CodInt:'040';Descrizione:'Ore ind.turno in fasce   ';Ordine:040;VocePaghe:'N';Misura:'H'),
                  (CodInt:'060';Descrizione:'Ore straordinario        ';Ordine:050;VocePaghe:'N';Misura:'H'),
                  (CodInt:'200';Descrizione:'Ore assestamento         ';Ordine:060;VocePaghe:'N';Misura:'H'),
                  (CodInt:'205';Descrizione:'Ore liquidate anni prec. ';Ordine:065;VocePaghe:'S';Misura:'H'),
                  (CodInt:'032';Descrizione:'Banca ore in fasce       ';Ordine:070;VocePaghe:'N';Misura:'H'),
                  (CodInt:'034';Descrizione:'Banca ore liquidata      ';Ordine:072;VocePaghe:'S';Misura:'H'),
                  (CodInt:'080';Descrizione:'Recupero debito          ';Ordine:080;VocePaghe:'S';Misura:'H'),
                  (CodInt:'082';Descrizione:'Permessi non recuperati  ';Ordine:082;VocePaghe:'N';Misura:'H'),
                  (CodInt:'190';Descrizione:'Festività non godute     ';Ordine:083;VocePaghe:'S';Misura:'N'),
                  (CodInt:'090';Descrizione:'Totale ore lavorate      ';Ordine:090;VocePaghe:'S';Misura:'H'),
                  (CodInt:'092';Descrizione:'Ore rese INAIL           ';Ordine:092;VocePaghe:'S';Misura:'H'),
                  (CodInt:'230';Descrizione:'Ore causalizzate         ';Ordine:100;VocePaghe:'N';Misura:'H'),
                  (CodInt:'160';Descrizione:'Ore causalizzate liquid. ';Ordine:110;VocePaghe:'N';Misura:'H'),
                  (CodInt:'250';Descrizione:'Ore causalizz. a blocchi ';Ordine:120;VocePaghe:'N';Misura:'H'),
                  (CodInt:'170';Descrizione:'Giustificativi assenza   ';Ordine:130;VocePaghe:'N';Misura:'H'),
                  (CodInt:'180';Descrizione:'Periodi di assenza       ';Ordine:140;VocePaghe:'N';Misura:'H'),
                  (CodInt:'110';Descrizione:'Ind.Notturna in ore      ';Ordine:150;VocePaghe:'S';Misura:'H'),
                  (CodInt:'120';Descrizione:'Ind.Notturna in numero   ';Ordine:160;VocePaghe:'S';Misura:'N'),
                  (CodInt:'130';Descrizione:'Ind.Festive intere       ';Ordine:170;VocePaghe:'S';Misura:'N'),
                  (CodInt:'140';Descrizione:'Ind.Festive ridotte      ';Ordine:180;VocePaghe:'S';Misura:'N'),
                  (CodInt:'150';Descrizione:'Ind.Presenza             ';Ordine:190;VocePaghe:'N';Misura:'N'),
                  (CodInt:'240';Descrizione:'Incentivi                ';Ordine:200;VocePaghe:'N';Misura:'V'),
                  (CodInt:'242';Descrizione:'Quota quantitativa       ';Ordine:202;VocePaghe:'N';Misura:'H'),
                  (CodInt:'244';Descrizione:'Penalizzazioni           ';Ordine:204;VocePaghe:'N';Misura:'V'),
                  (CodInt:'260';Descrizione:'Turni rep.interi         ';Ordine:210;VocePaghe:'S';Misura:'N'),
                  (CodInt:'270';Descrizione:'Turni rep.in ore         ';Ordine:220;VocePaghe:'S';Misura:'H'),
                  (CodInt:'280';Descrizione:'Turni rep.ore maggiorate ';Ordine:230;VocePaghe:'S';Misura:'H'),
                  (CodInt:'290';Descrizione:'Turni rep.ore non magg.  ';Ordine:240;VocePaghe:'S';Misura:'H'),
                  (CodInt:'295';Descrizione:'Turni rep.gett chiamata  ';Ordine:245;VocePaghe:'S';Misura:'N'),
                  (CodInt:'297';Descrizione:'Turni rep.eccedenti      ';Ordine:247;VocePaghe:'S';Misura:'N'),
                  (CodInt:'300';Descrizione:'1° turni                 ';Ordine:250;VocePaghe:'S';Misura:'N'),
                  (CodInt:'310';Descrizione:'2° turni                 ';Ordine:260;VocePaghe:'S';Misura:'N'),
                  (CodInt:'320';Descrizione:'3° turni                 ';Ordine:270;VocePaghe:'S';Misura:'N'),
                  (CodInt:'330';Descrizione:'4° turni                 ';Ordine:280;VocePaghe:'S';Misura:'N'),
                  (CodInt:'100';Descrizione:'Numero pasti             ';Ordine:290;VocePaghe:'N';Misura:'N'),
                  (CodInt:'210';Descrizione:'Buoni pasto maturati     ';Ordine:300;VocePaghe:'S';Misura:'N'),
                  (CodInt:'220';Descrizione:'Ticket maturati          ';Ordine:310;VocePaghe:'S';Misura:'N'),
                  (CodInt:'215';Descrizione:'Buoni pasto acquistati   ';Ordine:320;VocePaghe:'S';Misura:'N'),
                  (CodInt:'225';Descrizione:'Ticket acquistati        ';Ordine:330;VocePaghe:'S';Misura:'N'),
                  (CodInt:'400';Descrizione:'Trasferte:indennità intera           ';Ordine:340;VocePaghe:'N';Misura:'V'),
                  (CodInt:'402';Descrizione:'Trasferte:indennità rid.supero hh    ';Ordine:350;VocePaghe:'N';Misura:'V'),
                  (CodInt:'404';Descrizione:'Trasferte:indennità rid.supero gg    ';Ordine:360;VocePaghe:'N';Misura:'V'),
                  (CodInt:'406';Descrizione:'Trasferte:indennità rid.supero hhgg  ';Ordine:370;VocePaghe:'N';Misura:'V'),
                  (CodInt:'408';Descrizione:'Trasferte:indennità km               ';Ordine:380;VocePaghe:'N';Misura:'V'),
                  (CodInt:'410';Descrizione:'Trasferte:quota esente tassazione    ';Ordine:390;VocePaghe:'N';Misura:'V'),
                  (CodInt:'412';Descrizione:'Trasferte:quota assoggetta tassazione';Ordine:400;VocePaghe:'N';Misura:'V'),
                  (CodInt:'424';Descrizione:'Trasferte:Rimborso spese           ';Ordine:460;VocePaghe:'N';Misura:'V'),
                  (CodInt:'426';Descrizione:'Trasferte:Rimborso spese-ind.suppl.';Ordine:470;VocePaghe:'N';Misura:'V'),
                  (CodInt:'428';Descrizione:'Trasferte:Anticipo recuperato      ';Ordine:480;VocePaghe:'S';Misura:'V'),
                  (CodInt:'450';Descrizione:'Dati atipici                       ';Ordine:480;VocePaghe:'N';Misura:'V')
                  );

  //Anomalie scarico paghe
  VettAnom : TAnomScaricoPaghe =
                 (('Conteggi non abilitati'),
                  ('Anomalia nel conteggio delle assenze'),
                  ('Tabella assenze non disponibile'),
                  ('Causale di assenza inesistente : '),
                  ('Ore lavorate non disponibili'),
                  ('Dati scheda non disponibili'),
                  ('Dati ore lavorate in fasce non disponibili'),
                  ('Dati indennità di presenza non disponibili'),
                  ('Dati ore reperibilità non disponibili'),
                  ('Dati assestamento Causali 1 non disponibili'),
                  ('Dati assestamento Causali 2 non disponibili'),
                  ('Dati assestamento fasce non disponibili'),
                  ('Dati straordinari in fasce non disponibili'),
                  ('Contratto inesistente'),
                  ('Interfaccia paghe inesistente'),
                  ('Dati anagarafici non disponibili'),
                  (''),
                  (''),
                  (''));

  ITER_ATTIVO     = 'S';

  // elenco degli iter autorizzativi gestiti
  ITER_MISSIONI       = 'M140';
  ITER_GIUSTIF        = 'T050';
  ITER_STRMESE        = 'T065';
  ITER_ORARIGG        = 'T085';
  ITER_TIMBR          = 'T105';
  ITER_STRGIORNO      = 'T325';
  ITER_CARTELLINO     = 'T860';
  ITER_SCIOPERI       = 'T251';
  ITER_CERTIFICAZIONI = 'SG230';
  ITER_DOCUMENTALE    = 'T960';
  ITER_BUDGET_STRAORD = 'T700';
  ITER_DISPTURNI      = 'T600';

  ITER_SCIOPERI_DEFAULT_SCRIPT =  'begin'#13#10 +
                                  '  T250P_ANNULLA_RICHIESTA(:ID,:LIVELLO,:STATO,:RESPONSABILE,:AUTORIZZ_AUTOMATICA); '#13#10 +
                                  'end;';
  // descrizioni degli iter autorizzativi
  A000IterAutorizzativi:array [0..11] of TIterAutorizzativi = (
    (Cod:ITER_GIUSTIF;        Desc:'Giustificativi'),
    (Cod:ITER_TIMBR;          Desc:'Timbrature'),
    (Cod:ITER_CARTELLINO;     Desc:'Cartellino'),
    (Cod:ITER_STRGIORNO;      Desc:'Eccedenze giornaliere'),
    (Cod:ITER_STRMESE;        Desc:'Straordinario mensile'),
    (Cod:ITER_ORARIGG;        Desc:'Orario giornaliero'),
    (Cod:ITER_MISSIONI;       Desc:'Missioni'),
    (Cod:ITER_SCIOPERI;       Desc:'Scioperi'),
    (Cod:ITER_CERTIFICAZIONI; Desc:'Certificazioni'),
    (Cod:ITER_DOCUMENTALE;    Desc:'Documentale'),
    (Cod:ITER_BUDGET_STRAORD; Desc:'Budget straordinario'),
    (Cod:ITER_DISPTURNI;      Desc:'Disponibilità turni')
    );

   A000FasiIterAutorizzativi:array [0..4] of TFasiIterAutorizzativi = (
    (Cod:ITER_MISSIONI; Fase:1; Desc:'Missione e anticipi in attesa di autorizzazione'), //missioni e anticipi autorizzati e non più modificabili; non si possono ancora importare su M040
    (Cod:ITER_MISSIONI; Fase:2; Desc:'Missione e anticipi in attesa di caricamento'),    //missioni e anticipi visibili alla fase di importazione (cassa economale)
    (Cod:ITER_MISSIONI; Fase:3; Desc:'Missione e anticipi caricati'),                    //missioni e anticipi importati su M040
    (Cod:ITER_MISSIONI; Fase:4; Desc:'Rimborsi in attesa di autorizzazione'),            //rimborsi già autorizzati ma in attesa di validazione da uff.missioni
    (Cod:ITER_MISSIONI; Fase:5; Desc:'Autorizzazione rimborsi')                          //rimborsi validati da uff.misisoni importati su M050
    );

   D_TipoDipendente: array [0..10] of TItemsValues = (
        (item:'RU  Tempo indeterminato'; value:'RU'),
        (item:'IN  Tempo determinato'; value:'IN'),
        (item:'ER  Erede'; value:'ER'),
        (item:'BO  Borsista'; value:'BO'),
        (item:'CO  Parasubordinato - Gestione separata INPS'; value:'CO'),
        (item:'AS  Altro assimilato'; value:'AS'),
        (item:'LU  L.S.U'; value:'LU'),
        (item:'LA  Sanitario convenzionato - Lav. autonomo'; value:'LA'),
        (item:'SR  Sanitario convenzionato tempo indeterminato'; value:'SR'),
        (item:'SI  Sanitario convenzionato tempo determinato'; value:'SI'),
        (item:'CP  Creditore pignoratizio'; value:'CP')
      );

  D_ProfessioneONAOSI: array [0..3] of TItemsValues = (
        (item:'M  Medici'; value:'M'),
        (item:'F  Farmacisti'; value:'F'),
        (item:'V  Veterinari'; value:'V'),
        (item:'O  Odontoiatri'; value:'O')
      );

  A000LimiteMensileLiquidabile = '* L';
  A000LimiteMensileResiduabile = '* B';

  //Sigla pagina principale IrisCloud
  WA001PaginaPrincipale = 'WA001';

  BYTES_KB = 1024;
  BYTES_MB = 1024 * BYTES_KB;
  BYTES_GB = 1024 * BYTES_MB;

  EXT_PDF = 'pdf';
  EXT_XLS = 'xls';

  I011RIENTRIPOM_TEORICI      = 'RIENTRIPOM_TEORICI';
  I011RIENTRIPOM_REALI        = 'RIENTRIPOM_REALI';
  I011RIENTRIPOM_RESI         = 'RIENTRIPOM_RESI';
  I011RIENTRIPOM_SALDO        = 'RIENTRIPOM_SALDO';
  I011BLOCCO_T860             = 'BLOCCO_T860';
  I011PT_ORE_STR              = 'PT_ORE_STR';
  I011PT_ORE_SUPPL            = 'PT_ORE_SUPPL';
  I011COMPMM_EFF              = 'COMPMM_EFF';
  I011CSN_SALDO_ANNO          = 'CSN_SALDO_ANNO';
  I011CSN_OREDISPONIBILI_ANNO = 'CSN_OREDISPONIBILI_ANNO';
  I011CSN_COMPENSAZIONE_ANNO  = 'CSN_COMPENSAZIONE_ANNO';
  I011CSN_SALDO_MESE          = 'CSN_SALDO_MESE';
  I011CSN_OREDISPONIBILI_MESE = 'CSN_OREDISPONIBILI_MESE';
  I011CSN_COMPENSAZIONE_MESE  = 'CSN_COMPENSAZIONE_MESE';
  I011_NEGATIVI_COMPENSABILI  = 'NEGATIVI_COMPENSABILI';

  I090MONDOEDP       = 'MONDOEDP';
  I090NONAUTORIZZATA = 'VERSIONE NON AUTORIZZATA';

  M020TIPO_PASTO    = 'PASTO';
  M020TIPO_MEZZO    = 'MEZZO';
  M020TIPO_PEDAGGIO = 'PEDAG';

  P441Passphrase = '19841012';

  HASHTYPE_NoHash = 'NO';
  HASHTYPE_Sha1   = 'SHA1';
  HASHTYPE_Sha256 = 'SHA256';

  A210PSW_CRYPT_PASSPHRASE = 25842112;

  T102STRAOSETTIMANALE = 'STRAOSETTIMANALE';
  T102RIEPPRES_EU      = 'RIEPPRES_EU';
  T102STRAOGG          = 'STRAOGG';

  T440AZIENDA_BASE  = 'BASE';
  T440AZIENDA_TUTTE = '*';

  C90_W035MODALITACANCMESSAGGIINVIATI_NO       = 'N';
  C90_W035MODALITACANCMESSAGGIINVIATI_ALLEGATI = 'A';
  C90_W035MODALITACANCMESSAGGIINVIATI_TUTTO    = 'T';


  CampiT030:TCampiT030 = ('MATRICOLA','PROGRESSIVO','COGNOME','NOME','SESSO','DATANAS',
                          'COMUNENAS','CAPNAS','CODFISCALE','INIZIOSERVIZIO','TIPO_PERSONALE','TIPO_SOGGETTO_BASE',
                          'RAPPORTI_UNITI'//obsoleto, sostituito da T430.RAPPORTI_UNIFICATI ma mantenuto per retro-compatibilità con query customizzate
                         );
  CampiT480:TCampiT480 = ('CODICE','CITTA','CAP','PROVINCIA','CODCATASTALE');

  ParamDelimiter: Char = '|';

  IPV4_SEPARATOR: Char = '.';
  PUBLIC_IP_UNKNOWN    = 'unknown';

  // azioni particolari degli applicativi web, richiamabili via querystring
  // formato:
  //   http://url_sito?[nome_azione]
  // esempio:
  //   http://localhost:5000?ping
  //
  // gestire le azioni in A000UInterfaccia.IWServerControllerBaseNewSession
  WEB_ACT_PING           = 'ping';
  WEB_ACT_GETFILECONFIG  = 'getfileconfig';
  WEB_ACT_DEBUG_TO_FILE  = 'debug';
  WEB_FLAG_DEBUG_TO_FILE = 'MEdp_DebugToFileEnabled';

  A000AzioniSitoWeb: array [0..4] of TAzioniSitoWeb = (
    (Nome: 'Riavvio sito web';          Comando: '#01';                          Descrizione: 'Riavvio del sito web (può richiedere privilegi di amministrazione)'; ),
    (Nome: 'Arresto sito web';          Comando: '#02';                          Descrizione: 'Arresto del sito web (può richiedere privilegi di amministrazione)'; ),
    (Nome: 'Avvio sito web';            Comando: '#03';                          Descrizione: 'Avvio del sito web (può richiedere privilegi di amministrazione)'; ),
    (Nome: 'Ping sito web';             Comando: '?' + WEB_ACT_PING;             Descrizione: 'Ping del sito web'; ),
    (Nome: 'Aggiornamento parametri';   Comando: '?' + WEB_ACT_GETFILECONFIG;    Descrizione: 'Lettura e aggiornamento dei parametri di configurazione da file .ini'; )
  );

  // ### parametri di configurazione applicativi web.ini ###
  FILE_CONFIG_IRISWEB   = 'IrisWeb.ini';
  FILE_CONFIG_IRISCLOUD = 'IrisCloud.ini';
  FILE_CONFIG_IRISAPP   = 'IrisApp.ini';
  FILE_CONFIG_X001      = 'X001.ini';
  {$IF DEFINED(WEBPJ)}
  FILE_CONFIG = FILE_CONFIG_IRISCLOUD;
  {$ELSEIF DEFINED(X001)}
  FILE_CONFIG = FILE_CONFIG_X001;
  {$ELSEIF DEFINED(IRISWEB)}
  FILE_CONFIG = FILE_CONFIG_IRISWEB;
  {$ELSE}
  FILE_CONFIG = FILE_CONFIG_IRISAPP;
  {$ENDIF}

  // sezioni file configurazione
  INI_SEZ_IMPOST_OPER        = 'ImpostazioniOperative';
  INI_SEZ_IMPOST_SIST        = 'ImpostazioniSistema';
  INI_SEZ_IMPOST_IIS         = 'ImpostazioniIIS';
  INI_SEZ_IMPOST_IW_LOG      = 'IWExceptionLogger';
  INI_SEZ_IMPOST_UG_LOG      = 'UGExceptionLogger';
  // identificativi per file di configurazione
  INI_ID_DATABASE            = 'Database';
  INI_ID_AZIENDA             = 'Azienda';
  INI_ID_STATO_AZIENDA       = 'StatoAzienda';
  INI_ID_PROFILO             = 'Profilo';
  INI_ID_STATO_PROFILO       = 'StatoProfilo';
  INI_ID_TITOLO_IRISAPP      = 'TitoloIrisAPP';
  INI_ID_TIMEOUT_OPER        = 'TimeoutOperatore';
  INI_ID_TIMEOUT_DIP         = 'TimeoutDipendente';
  INI_ID_MAX_SESSIONI        = 'MaxSessioni';
  INI_ID_MAX_REQUESTS        = 'MaxRequests';
  INI_ID_URL_SUP_MAX_SESS    = 'URL_Supero_MaxSessioni';
  INI_ID_URL_SUP_MAX_SESS_RILPRE = 'URL_Supero_MaxSessioni_Rilpre';
  INI_ID_URL_SUP_MAX_SESS_STAGIU = 'URL_Supero_MaxSessioni_Stagiu';
  INI_ID_URL_SUP_MAX_SESS_PAGHE  = 'URL_Supero_MaxSessioni_Paghe';
  INI_ID_HOME                = 'Home';
  INI_ID_HOME_RILPRE         = 'Home_Rilpre';
  INI_ID_HOME_STAGIU         = 'Home_Stagiu';
  INI_ID_HOME_PAGHE          = 'Home_Paghe';
  INI_ID_URL_LOGINERR        = 'URL_LoginErrato';
  INI_ID_URL_WS_AUT          = 'URL_WS_Autenticazione';
  INI_ID_URL_WS_TOKEN2USER   = 'URL_WS_Token2User';
  INI_ID_URL_MANUTENZIONE    = 'URL_Manutenzione';
  INI_ID_URL_IRISWEBCLOUD    = 'URL_IrisWEBCLOUD';
  INI_ID_IRISWEBCLOUD_NEWTAB = 'IrisWEBCLOUD_NewTab';
  INI_ID_URL_WEBAPP          = 'URL_WebApp';
  INI_ID_LOGIN_ESTERNO       = 'LoginEsterno';
  INI_ID_CAMPI_INVISIBILI    = 'CampiInvisibili';
  INI_ID_TAB_COL_PARTENZA    = 'TabColPartenza';
  INI_ID_STRUTTURA           = 'Struttura';
  INI_ID_SLR_COL_PILOTA      = 'SLRColPilota';
  INI_ID_SLR_COL_PILOTATA1   = 'SLRColPilotata1';
  INI_ID_SLR_COL_PILOTATA2   = 'SLRColPilotata2';
  INI_ID_VERSIONEDB          = 'VersioneDB';
  INI_ID_NUM_LIVELLI         = 'NumLivelli';
  INI_ID_CURSORI_LOGIN       = 'CursoriLogin';
  INI_ID_PORT                = 'Port';
  INI_ID_PORT_RILPRE         = 'Port_Rilpre';
  INI_ID_PORT_STAGIU         = 'Port_Stagiu';
  INI_ID_PORT_PAGHE          = 'Port_Paghe';
  INI_ID_CURSORI_SESSIONE    = 'CursoriSessione';
  INI_ID_MAX_OPEN_CURSORS    = 'MaxOpenCursors';
  INI_ID_MAX_WORKING_MEMORY  = 'MaxWorkingMemory';
  INI_ID_LOG_ABILITATI       = 'LogAbilitati';
  INI_ID_PARAMETRI_AVANZATI  = 'ParametriAvanzati';
  INI_ID_SINGLEPAGE          = 'PaginaSingola';
  INI_ID_STARTPAGE           = 'PaginaIniziale';
  INI_ID_REG_CREDENZIALI     = 'CookieCredenziali';
  INI_ID_RECUPERO_PASSWORD   = 'RecuperoPassword';
  INI_ID_URLRECAPTCHA        = 'UrlReCAPTCHA';
  INI_ID_SITEKEYRECAPTCHA    = 'SiteKeyReCAPTCHA';
  INI_ID_SECRETKEYRECAPTCHA  = 'SecretKeyReCAPTCHA';
  INI_ID_URL_BASE            = 'URL_Base';
  INI_ID_URL_BASE_RILPRE     = 'URL_Base_Rilpre';
  INI_ID_URL_BASE_STAGIU     = 'URL_Base_Stagiu';
  INI_ID_URL_BASE_PAGHE      = 'URL_Base_Paghe';
  INI_ID_TIPO_INSTALLAZIONE  = 'Tipo_Installazione';
  INI_ID_B110PORT            = 'PortB110';
  INI_ID_B110HOST            = 'HostB110';
  INI_ID_B110URL             = 'UrlB110';
  INI_ID_B110PROTOCOLLO      = 'ProtocolB110';
  // tipologie di log abilitati
  INI_LOG_ERRORE             = 'ERRORE';
  INI_LOG_MEMORIA            = 'MEMORIA';
  INI_LOG_SESSIONE           = 'SESSIONE';
  INI_LOG_ACCESSO            = 'ACCESSO';
  INI_LOG_TRACCIA            = 'TRACCIA';

  // tipologie di com initialization
  INI_COM_NONE               = 'COM_NONE';
  INI_COM_NORMAL             = 'COM_NORMAL';
  INI_COM_MULTI              = 'COM_MULTI';

  // tipologie di stream mode per rave report
  INI_RAVE_STREAM_MODE_TEMPFILE  = 'SM_TEMPFILE';
  INI_RAVE_STREAM_MODE_MEMORY    = 'SM_MEMORY';

  // nomi dei parametri avanzati
  INI_PAR_DISABLE_CHIUSURA_BROWSER        = 'DISABLE_CHIUSURA_BROWSER';
  INI_PAR_NO_CRITICAL_SECTION_LOGIN       = 'NO_CRITICAL_SECTION_LOGIN';
  INI_PAR_NO_CRITICAL_SECTION_SESSIONE    = 'NO_CRITICAL_SECTION_SESSIONE';
  INI_PAR_NO_SHARED_LOGIN                 = 'NO_SHARED_LOGIN';
  INI_PAR_NO_REGISTRA_MSG                 = 'NO_REGISTRA_MSG';
  INI_PAR_RECUPERO_PASSWORD               = 'RECUPERO_PASSWORD';
  INI_PAR_NO_ABILITAZIONI                 = 'NO_ABILITAZIONI';
  INI_PAR_USE_STANDARD_PRINTER            = 'USE_STANDARD_PRINTER';
  INI_PAR_COMPRESSION                     = 'COMPRESSION';
  INI_PAR_NO_STAMPACARTELLINO             = 'NO_STAMPACARTELLINO';
  INI_PAR_NO_STAMPACEDOLINO               = 'NO_STAMPACEDOLINO';
  INI_PAR_NO_PDF                          = 'NO_PDF';
  INI_PAR_NO_COINITIALIZE                 = 'NO_COINITIALIZE';
  INI_PAR_CAPTION_LAYOUT                  = 'CAPTION_LAYOUT';
  INI_PAR_TRADUZIONE_CAPTION              = 'TRADUZIONE_CAPTION';
  INI_PAR_NO_DEL_TEMPFILE_ONCREATE        = 'NO_DEL_TEMPFILE_ONCREATE';
  INI_PAR_CACHED_FILES                    = 'CACHED_FILES';
  INI_PAR_NO_UNIFIED_FILES                = 'NO_UNIFIED_FILES';
  INI_PAR_JQUERY_UNCOMPRESSED             = 'JQUERY_UNCOMPRESSED';
  INI_PAR_FILE_INLINE                     = 'FILE_INLINE';
  INI_PAR_DB_STATEMENT_CACHE              = 'DB_STATEMENT_CACHE';
  INI_PAR_DB_NO_CHECK_CONNECTION          = 'DB_NO_CHECK_CONNECTION';
  INI_PAR_LOGOFF_DBPOOL                   = 'LOGOFF_DBPOOL';
  INI_PAR_DB_NO_RECONNECT                 = 'DB_NO_RECONNECT';
  //INI_PAR_C017_V430                       = 'C017_V430=P430';
  //INI_PAR_C018_LEADING_T030               = 'C018_LEADING_T030';
  //INI_PAR_C018_NO_LEADING_T030            = 'C018_NO_LEADING_T030';
  //INI_PAR_C018_UNNEST                     = 'C018_UNNEST';
  //INI_PAR_C018_NO_UNNEST                  = 'C018_NO_UNNEST';
  //INI_PAR_T050_CANCELLAZIONE              = 'T050_CANCELLAZIONE';
  INI_PAR_RAVEREPORT_IN_MEMORIA           = 'RAVEREPORT_IN_MEMORIA';
  INI_PAR_TOLLERA_IE7                     = 'TOLLERA_IE7';
  INI_PAR_COOKIES_ENABLE_HTTPONLY         = 'COOKIES_ENABLE_HTTPONLY';
  INI_PAR_COOKIES_ENABLE_SECURE           = 'COOKIES_ENABLE_SECURE';
  INI_PAR_COOKIES_ENABLE_SAMESITE_STRICT  = 'COOKIES_ENABLE_SAMESITE_STRICT';
  INI_PAR_SECURITY_ENABLE_FORM_ID_CHECK   = 'SECURITY_ENABLE_FORM_ID_CHECK';
  INI_PAR_SECURITY_ENABLE_SAME_IP_CHECK   = 'SECURITY_ENABLE_SAME_IP_CHECK';
  INI_PAR_SECURITY_ENABLE_SAME_UA_CHECK   = 'SECURITY_ENABLE_SAME_UA_CHECK';
  INI_PAR_IRISWEB_ENABLE_MULTISCHEDA      = 'IRISWEB_ENABLE_MULTISCHEDA';
  INI_PAR_SECURITY_ENABLE_XSS_PROTECTION  = 'SECURITY_ENABLE_XSS_PROTECTION';
  INI_PAR_SESSIONE_SINGOLA_PER_USR        = 'SESSIONE_SINGOLA_PER_USR';

  // configurazioni web.config
  INI_IIS_DLL_PATH        = 'DllPath';
  INI_IIS_DEFAULT_PAGE    = 'DefaultPage';
  INI_IIS_HTTPS_ONLY      = 'HttpsOnly';
  INI_IIS_IN_MANUTENZIONE = 'SitoInManutenzione';
  INI_IIS_MONITOR_PRIVATI = 'MonitoPrivati';
  INI_IIS_DOMINIO_COOKIE  = 'DominioCookie';
  INI_IIS_HIDDEN_DIRECORY = 'DirectoryPrivate';
  INI_IIS_CUSTOM_ERROR    = 'PagineDiErrorePersonalizzate';

  // Intraweb Exception Logger
  INI_EL_ABILITATO              = 'Abilitato';
  INI_EL_PATH_FILE_LOG          = 'PathFileLog';
  INI_EL_NOME_FILE_LOG          = 'NomeFileLog';
  INI_EL_GIORNI_RIMOZIONE       = 'RimuoviDopoGiorni';
  INI_EL_ECCEZ_IGNORATE         = 'EccezioniIgnorate';

  // UniGUI Exception Logger
  INI_UGEL_INDY                 = 'IndyExceptions';
  INI_UGEL_INDYSSL              = 'IndySSLExceptions';
  INI_UGEL_SESSION              = 'SessionExceptions';

  // ### parametri di configurazione applicativi web.fine ###

  // ### url responder.ini  ###
  URL_RESPONDER_ERROR_RESP    = 'IWERROR: ';
  URL_RESPONDER_PARAM_ID      = 'id';
  URL_RESPONDER_VALUE_ID      = 'mondoedp';
  URL_RESPONDER_PARAM_ACTION  = 'action';
  URL_RESPONDER_PARAM_SID     = 'sid';
  // ### url responder.fine ###

  DEBIT                       = 'DEBIT';
  COD_MISSIONE_DA_LIQUIDARE   = 'D';
  COD_MISSIONE_LIQUIDATA      = 'L';
  COD_MISSIONE_PARZ_LIQUIDATA = 'P';
  COD_MISSIONE_SOSPESA        = 'S';

  DESC_MISSIONE_DA_LIQUIDARE  = 'Da Liquidare';
  DESC_MISSIONE_LIQUIDATA     = 'Liquidata';
  DESC_MISSIONE_PARZ_LIQUIDATA= 'Parzialmente Liquidata';
  DESC_MISSIONE_SOSPESA       = 'Sospesa';

  MISSIONE_COD_CAT_ESTERO_MOTIVAZIONI  = 'EST01';
  MISSIONE_COD_CAT_ESTERO_IPOTESI      = 'EST02';
  MISSIONE_COD_CAT_DATI_LIBERI         = 'DET01';

  MaxAccessi=10;

  FLUSSO_INPDAP             = 'DMA';
  FLUSSO_FLUPER             = 'FLUPER';
  FLUSSO_CREDITI            = 'CREDITI';

  RAVE_MODEL_REL_PATH   = 'wwwroot\report';
  RAVE_MODEL_CARTELLINO = 'W009StampaCartellino.rav';

  GOOGLE_MAPS_API_KEY = 'AIzaSyCWNZW68FwUw_zxJ-MvS5I0IvYbYQzCxXc';

  // ### parametri specifici per clienti.inizio ###

  TORINO_COMUNE_STRUTT_EVENTI_STR = 'CODICE_SERVIZIO';

  TO_CSI_AUT_STR = 'AUTST';     //Causale straordinario da autorizzare tramite richiesta del responsabile
  TO_CSI_STR_AUT = 'STAUT';     //Causale straordinario autorizzato dal responsabile
  TO_CSI_STR_ESC = 'STESC';     //Causale straordinario sab/dom/festivi, generato dai modelli orari ed escluso dalle ore normali
  TO_CSI_STR_PAG = 'STPAG,STMAG,HSPAG,HSMAG'; //Causali straordinario usate per liquidazione completa (esclusa dalle normali)
  TO_CSI_ABB_BANCAORE = '9103'; //Causale abbattimento giornaliero banca ore
  TO_CSI_ABB_ECCSETT  = '9104';  //Causale abbattimento giornaliero da recupero ecc.settimanale TO_CSI_REC_SETT
  TO_CSI_RICH_RECHH   = 'RECOR'; //Causale di richiesta rcupero ore da IrisWEB: capolista della catena TO_CSI_RICH_RECHH->TO_CSI_REC_SETT->TO_CSI_REC_BANCAORE
  TO_CSI_REC_SETT     = '1110'; //Causale recupero eccedenza settimanale
  TO_CSI_REC_BANCAORE = '1100'; //Causale recupero banca ore
  TO_CSI_MIN_BANCAORE = -360;   //Min Banca ore tollerata dalla fruizione assenze
  TO_CSI_MAX_BANCAORE = 1200;   //Max Banca ore riportabile da un mese all'altro
  TO_CSI_GIUST_AUMENTAFLEX = '1007'; //Giustificativi che aumentano la flessibilità
  TO_CSI_GIUST_REPE        = '2090,2091'; //Giustificativi di reperibilità su cui non applicare i controlli di intersezione con altri giustificativi
  TO_CSI_GIUST_LIMITATI    = '1007,1025,1100,1110,RECOR'; //Giustificativi da limitare entro i punti nominali + flex ed esternamente alla PMT
  TO_CSI_GIUST_VISITAMED   = '##1025'; //Tempo viaggio per visita medica (1025)
  TO_CSI_TEMPO_VISITAMED   = 30;     //Tempo viaggio per visita medica (1025)

  // ### parametri specifici per clienti.fine ###

  // formati standard di visualizzazione
  FMT_DURATA_ELABORAZIONE  = 'hh"h:"nn"m:"ss"s."zzz';

  {$IFDEF IRISWEB}
  // https://owasp.org/www-pdf-archive//Xenotix_XSS_Protection_CheatSheet_For_Developers.pdf
  // https://raw.githubusercontent.com/PHPIDS/PHPIDS/master/lib/IDS/default_filter.json
  FILTRI_INJECTION:array[1..75] of TStringFilter = (
    (InjTypes: [injXSS]; Enable: True; Role: '<\/?\s*(!DOCTYPE|a|abbr|acronym|address|applet|area|article|aside|audio|b|base|basefont|bdo|bdi|bgsound|big|blink|blockquote|body|br|button|canvas|caption|' + 'center|cite|code|col|colgroup|comment|datalist|dd|del|dfn|dialog|dir|div|dl|dt|em|embed|fieldset|figcaption|figure|font|footer|' + 'form|frame|frameset|h1|h2|h3|h4|h5|h6|head|header|hr|html|i|iframe|ilayer|img|input|ins|isindex|kbd|keygen|' + 'label|layer|legend|li|link|main|map|mark|marquee|menu|menuitem|meta|meter|multicol|nav|nobr|noembed|noframes|noscript|object|ol|optgroup|option|' + 'output|p|param|plaintext|pre|progress|q|rp|rt|ruby|s|samp|script|section|select|spacer|small|source|span|strike|strong|style|sub|summary|sup|table|' + 'tbody|td|textarea|tfoot|th|thead|time|title|tr|track|tt|u|ul|var|video|wbr|xmp)\s*\/?>'; Description: 'HTML5 Tags'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\"[^\"]*[^-]?>)|(?:[^\w\s]\s*\/>)|(?:>\")'; Description: 'finds html breaking injections including whitespace attacks'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\"+.*[<=]\s*\"[^\"]+\")|(?:\"\s*\w+\s*=)|(?:>\w=\/)|(?:#.+\)[\"\s]*>)|(?:\"\s*(?:src|style|on\w+)\s*=\s*\")|(?:[^\"]?\"[,;\s]+\w*[\[\(])'; Description: 'finds attribute breaking injections including whitespace attacks'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:^>[\w\s]*<\/?\w{2,}>)'; Description: 'finds unquoted attribute breaking injections'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:[+\/]\s*name[\W\d]*[)+])|(?:;\W*url\s*=)|(?:[^\w\s\/?:>]\s*(?:location|referrer|name)\s*[^\/\w\s-])'; Description: 'Detects url-, name-, JSON, and referrer-contained payload attacks'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\W\s*hash\s*[^\w\s-])|(?:\w+=\W*[^,]*,[^\s(]\s*\()|(?:\?\"[^\s\"]\":)|(?:(?<!\/)__[a-z]+__)|(?:(?:^|[\s)\]\}])(?:s|g)etter\s*=)'; Description: 'Detects hash-contained xss payload attacks, setter usage and property overloading'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:with\s*\(\s*.+\s*\)\s*\w+\s*\()|(?:(?:do|while|for)\s*\([^)]*\)\s*\{)|(?:\/[\w\s]*\[\W*\w)'; Description: 'Detects self contained xss via with(), common loops and regex to string conversion'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:[=(].+\?.+:)|(?:with\([^)]*\)\))|(?:\.\s*source\W)'; Description: 'Detects JavaScript with(), ternary operators and XML predicate attacks'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\/\w*\s*\)\s*\()|(?:\([\w\s]+\([\w\s]+\)[\w\s]+\))|(?:(?<!(?:mozilla\/\d\.\d\s))\([^)[]+\[[^\]]+\][^)]*\))|(?:[^\s!][{([][^({[]+[{([][^}\])]+[}\])][\s+\",\d]*[}\])])|(?:\"\)?\]\W*\[)|(?:=\s*[^\s:;]+\s*[{([][^}\])]+[}\])];)'; Description: 'Detects self-executing JavaScript functions'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\\u00[a-f0-9]{2})|(?:\\x0*[a-f0-9]{2})|(?:\\\d{2,3})'; Description: 'Detects the IE octal, hex and unicode entities'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:(?:\/|\\)?\.+(\/|\\)(?:\.+)?)|(?:\w+\.exe\??\s)|(?:;\s*\w+\s*\/[\w*-]+\/)|(?:\d\.\dx\|)|(?:%(?:c0\.|af\.|5c\.))|(?:\/(?:%2e){2})'; Description: 'Detects basic directory traversal'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:%c0%ae\/)|(?:(?:\/|\\)(home|conf|usr|etc|proc|opt|s?bin|local|dev|tmp|kern|[br]oot|sys|system|windows|winnt|program|%[a-z_-]{3,}%)(?:\/|\\))|(?:(?:\/|\\)inetpub|localstart\.asp|boot\.ini)'; Description: 'Detects specific directory and path traversal'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:etc\/\W*passwd)'; Description: 'Detects etc/passwd inclusion attempts'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:%u(?:ff|00|e\d)\w\w)|(?:(?:%(?:e\w|c[^3\W]|))(?:%\w\w)(?:%\w\w)?)'; Description: 'Detects halfwidth/fullwidth encoded unicode HTML breaking attempts'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:#@~\^\w+)|(?:\w+script:|@import[^\w]|;base64|base64,)|(?:\w\s*\([\w\s]+,[\w\s]+,[\w\s]+,[\w\s]+,[\w\s]+,[\w\s]+\))'; Description: 'Detects possible includes, VBSCript/JScript encodeed and packed functions'),
    (InjTypes: [injXSS]; Enable: True; Role: '([^*:\s\w,.\/?+-]\s*)?(?<![a-z]\s)(?<![a-z\/_@\-\|])(\s*return\s*)?(?:create(?:element|attribute|textnode)|[a-z]+events?|setattribute|getelement\w+|appendchild|createrange|createcontextualfragment|removenode|parentnode|decodeuricomponent' + '|\wettimeout|(?:ms)?setimmediate|option|useragent)(?(1)[^\w%\"]|(?:\s*[^@\s\w%\",.+\-]))'; Description: 'Detects JavaScript DOM/miscellaneous properties and methods'),
    (InjTypes: [injXSS]; Enable: True; Role: '([^*\s\w,.\/?+-]\s*)?(?<![a-mo-z]\s)(?<![a-z\/_@])(\s*return\s*)?(?:alert|inputbox|showmod(?:al|eless)dialog|showhelp|infinity|isnan|isnull|iterator|msgbox|executeglobal|expression|prompt|write(?:ln)?|confirm|dialog|urn|(?:un)?eval|exec|' + 'execscript|tostring|status|execute|window|unescape|navigate|jquery|getscript|extend|prototype)(?(1)[^\w%\"]|(?:\s*[^@\s\w%\",.:\/+\-]))'; Description: 'Detects possible includes and typical script methods'),
    (InjTypes: [injXSS]; Enable: True; Role: '([^*:\s\w,.\/?+-]\s*)?(?<![a-z]\s)(?<![a-z\/_@])(\s*return\s*)?(?:hash|name|href|navigateandfind|source|pathname|close|constructor|port|protocol|assign|replace|back|forward|document|ownerdocument|window|top|this|self|parent|frames|_?content|' + 'date|cookie|innerhtml|innertext|csstext+?|outerhtml|print|moveby|resizeto|createstylesheet|stylesheets)(?(1)[^\w%\"]|(?:\s*[^@\/\s\w%.+\-]))'; Description: 'Detects JavaScript object properties and methods'),
    (InjTypes: [injXSS]; Enable: True; Role: '([^*:\s\w,.\/?+-]\s*)?(?<![a-z]\s)(?<![a-z\/_@\-\|])(\s*return\s*)?(?:join|pop|push|reverse|reduce|concat|map|shift|sp?lice|sort|unshift)(?(1)[^\w%\"]|(?:\s*[^@\s\w%,.+\-]))'; Description: 'Detects JavaScript array properties and methods'),
    (InjTypes: [injXSS]; Enable: True; Role: '([^*:\s\w,.\/?+-]\s*)?(?<![a-z]\s)(?<![a-z\/_@\-\|])(\s*return\s*)?(?:set|atob|btoa|charat|charcodeat|charset|concat|crypto|frames|fromcharcode|indexof|lastindexof|match|navigator|toolbar|menubar|replace|regexp|slice|split|substr|substring|escape' + '|\w+codeuri\w*)(?(1)[^\w%\"]|(?:\s*[^@\s\w%,.+\-]))'; Description: 'Detects JavaScript string properties and methods'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\)\s*\[)|([^*\":\s\w,.\/?+-]\s*)?(?<![a-z]\s)(?<![a-z_@\|])(\s*return\s*)?(?:globalstorage|sessionstorage|postmessage|callee|constructor|content|domain|prototype|try|catch|top|call|apply|url|function|object|array|string|math|if|for\s*' + '(?:each)?|elseif|case|switch|regex|boolean|location|(?:ms)?setimmediate|settimeout|setinterval|void|setexpression|namespace|while)(?(1)[^\w%\"]|(?:\s*[^@\s\w%\".+\-\/]))'; Description: 'Detects JavaScript language constructs'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:,\s*(?:alert|showmodaldialog|eval)\s*,)|(?::\s*eval\s*[^\s])|([^:\s\w,.\/?+-]\s*)?(?<![a-z\/_@])(\s*return\s*)?(?:(?:document\s*\.)?(?:.+\/)?(?:alert|eval|msgbox|showmod(?:al|eless)dialog|showhelp|prompt|write(?:ln)?|confirm|dialog|open))' + '\s*(?:[^.a-z\s\-]|(?:\s*[^\s\w,.@\/+-]))|(?:java[\s\/]*\.[\s\/]*lang)|(?:\w\s*=\s*new\s+\w+)|(?:&\s*\w+\s*\)[^,])|(?:\+[\W\d]*new\s+\w+[\W\d]*\+)|(?:document\.\w)'; Description: 'Detects very basic XSS probings'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:=\s*(?:top|this|window|content|self|frames|_content))|(?:\/\s*[gimx]*\s*[)}])|(?:[^\s]\s*=\s*script)|(?:\.\s*constructor)|(?:default\s+xml\s+namespace\s*=)|(?:\/\s*\+[^+]+\s*\+\s*\/)'; Description: 'Detects advanced XSS probings via Script(), RexExp, constructors and XML namespaces'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\.\s*\w+\W*=)|(?:\W\s*(?:location|document)\s*\W[^({[;]+[({[;])|(?:\(\w+\?[:\w]+\))|(?:\w{2,}\s*=\s*\d+[^&\w]\w+)|(?:\]\s*\(\s*\w+)'; Description: 'Detects JavaScript location/document property access and window access obfuscation'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:[\".]script\s*\()|(?:\$\$?\s*\(\s*[\w\"])|(?:\/[\w\s]+\/\.)|(?:=\s*\/\w+\/\s*\.)|(?:(?:this|window|top|parent|frames|self|content)\[\s*[(,\"]*\s*[\w\$])|(?:,\s*new\s+\w+\s*[,;)])'; Description: 'Detects basic obfuscated JavaScript script injections'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:=\s*[$\w]\s*[\(\[])|(?:\(\s*(?:this|top|window|self|parent|_?content)\s*\))|(?:src\s*=s*(?:\w+:|\/\/))|(?:\w+\[(\"\w+\"|\w+\|\|))|(?:[\d\W]\|\|[\d\W]|\W=\w+,)|(?:\/\s*\+\s*[a-z\"])|(?:=\s*\$[^([]*\()|(?:=\s*\(\s*\")'; Description: 'Detects obfuscated JavaScript script injections'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:[^:\s\w]+\s*[^\w\/](href|protocol|host|hostname|pathname|hash|port|cookie)[^\w])'; Description: 'Detects JavaScript cookie stealing and redirection attempts'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:(?:vbs|vbscript|data):.*[,+])|(?:\w+\s*=\W*(?!https?)\w+:)|(jar:\w+:)|(=\s*\"?\s*vbs(?:ript)?:)|(language\s*=\s?\"?\s*vbs(?:ript)?)|on\w+\s*=\*\w+\-\"?'; Description: 'Detects data: URL injections, VBS injections and common URI schemes'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:firefoxurl:\w+\|)|(?:(?:file|res|telnet|nntp|news|mailto|chrome)\s*:\s*[%&#xu\/]+)|(wyciwyg|firefoxurl\s*:\s*\/\s*\/)'; Description: 'Detects IE firefoxurl injections, cache poisoning attempts and local file inclusion/execution'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:binding\s?=|moz-binding|behavior\s?=)|(?:[\s\/]style\s*=\s*[-\\])'; Description: 'Detects bindings and behavior injections'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:=\s*\w+\s*\+\s*\")|(?:\+=\s*\(\s\")|(?:!+\s*[\d.,]+\w?\d*\s*\?)|(?:=\s*\[s*\])|(?:\"\s*\+\s*\")|(?:[^\s]\[\s*\d+\s*\]\s*[;+])|(?:\"\s*[&|]+\s*\")|(?:\/\s*\?\s*\")|(?:\/\s*\)\s*\[)|(?:\d\?.+:\d)|(?:]\s*\[\W*\w)|(?:[^\s]\s*=\s*\/)'; Description: 'Detects common XSS concatenation patterns 1/2'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:=\s*\d*\.\d*\?\d*\.\d*)|(?:[|&]{2,}\s*\")|(?:!\d+\.\d*\?\")|(?:\/:[\w.]+,)|(?:=[\d\W\s]*\[[^]]+\])|(?:\?\w+:\w+)'; Description: 'Detects common XSS concatenation patterns 2/2'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:[^\w\s=]on(?!g\&gt;)\w+[^=_+-]*=[^$]+(?:\W|\&gt;)?)'; Description: 'Detects possible event handlers'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\<\w*:?\s(?:[^\>]*)t(?!rong))|(?:\<scri)|(<\w+:\w+)'; Description: 'Detects obfuscated script tags and XML wrapped HTML'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\<\/\w+\s\w+)|(?:@(?:cc_on|set)[\s@,\"=])'; Description: 'Detects attributes in closing tags and conditional compilation tokens'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:--[^\n]*$)|(?:\<!-|-->)|(?:[^*]\/\*|\*\/[^*])|(?:(?:[\W\d]#|--|{)$)|(?:\/{3,}.*$)|(?:<!\[\W)|(?:\]!>)'; Description: 'Detects common comment types'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\<base\s+)|(?:<!(?:element|entity|\[CDATA))'; Description: 'Detects base href injections and XML entity injections'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\<[\/]?(?:[i]?frame|applet|isindex|marquee|keygen|script|audio|video|input|button|textarea|style|base|body|meta|link|object|embed|param|plaintext|xm\w+|image|im(?:g|port)))'; Description: 'Detects possibly malicious html elements including some attributes'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\\x[01fe][\db-ce-f])|(?:%[01fe][\db-ce-f])|(?:&#[01fe][\db-ce-f])|(?:\\[01fe][\db-ce-f])|(?:&#x[01fe][\db-ce-f])'; Description: 'Detects nullbytes and other dangerous characters'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:\)\s*when\s*\d+\s*then)|(?:\"\s*(?:#|--|{))|(?:\/\*!\s?\d+)|(?:ch(?:a)?r\s*\(\s*\d)|(?:(?:(n?and|x?or|not)\s+|\|\||\&\&)\s*\w+\()'; Description: 'Detects MySQL comments, conditions and ch(a)r injections'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:[\s()]case\s*\()|(?:\)\s*like\s*\()|(?:having\s*[^\s]+\s*[^\w\s])|(?:if\s?\([\d\w]\s*[=<>~])'; Description: 'Detects conditional SQL injection attempts'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:\"\s*or\s*\"?\d)|(?:\\x(?:23|27|3d))|(?:^.?\"$)|(?:(?:^[\"\\]*(?:[\d\"]+|[^\"]+\"))+\s*(?:n?and|x?or|not|\|\||\&\&)\s*[\w\"[+&!@(),.-])|(?:[^\w\s]\w+\s*[|-]\s*\"\s*\w)|(?:@\w+\s+(and|or)\s*[\"\d]+)|(?:@[\w-]+\s(and|or)\s*[^\w\s])|(?:[^\w\s:]' + '\s*\d\W+[^\w\s]\s*\".)|(?:\Winformation_schema|table_name\W)'; Description: 'Detects classic SQL injection probings 1/2'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:\"\s*\*.+(?:or|id)\W*\"\d)|(?:\^\")|(?:^[\w\s\"-]+(?<=and\s)(?<=or\s)(?<=xor\s)(?<=nand\s)(?<=not\s)(?<=\|\|)(?<=\&\&)\w+\()|(?:\"[\s\d]*[^\w\s]+\W*\d\W*.*[\"\d])|(?:\"\s*[^\w\s?]+\s*[^\w\s]+\s*\")|(?:\"\s*[^\w\s]+\s*[\W\d].*(?:#|--))|(?:' + '\".*\*\s*\d)|(?:\"\s*or\s[^\d]+[\w-]+.*\d)|(?:[()*<>%+-][\w-]+[^\w\s]+\"[^,])'; Description: 'Detects classic SQL injection probings 2/2'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:\d\"\s+\"\s+\d)|(?:^admin\s*\"|(\/\*)+\"+\s?(?:--|#|\/\*|{)?)|(?:\"\s*or[\w\s-]+\s*[+<>=(),-]\s*[\d\"])|(?:\"\s*[^\w\s]?=\s*\")|(?:\"\W*[+=]+\W*\")|(?:\"\s*[!=|][\d\s!=+-]+.*[\"(].*$)|(?:\"\s*[!=|][\d\s!=]+.*\d+$)|(?:\"\s*like\W+[\w\"(])|' + '(?:\sis\s*0\W)|(?:where\s[\s\w\.,-]+\s=)|(?:\"[<>~]+\")'; Description: 'Detects basic SQL authentication bypass attempts 1/3'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:union\s*(?:all|distinct|[(!@]*)\s*[([]*\s*select)|(?:\w+\s+like\s+\\")|(?:like\s*\"\%)|(?:\"\s*like\W*[\"\d])|(?:\"\s*(?:n?and|x?or|not |\|\||\&\&)\s+[\s\w]+=\s*\w+\s*having)|(?:\"\s*\*\s*\w+\W+\")|(?:\"\s*[^?\w\s=.,;)(]+\s*[(@\"]*\s*\w+\W+\w)|' + '(?:select\s*[\[\]()\s\w\.,\"-]+from)|(?:find_in_set\s*\()'; Description: 'Detects basic SQL authentication bypass attempts 2/3'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:in\s*\(+\s*select)|(?:(?:n?and|x?or|not |\|\||\&\&)\s+[\s\w+]+(?:regexp\s*\(|sounds\s+like\s*\"|[=\d]+x))|(\"\s*\d\s*(?:--|#))|(?:\"[%&<>^=]+\d\s*(=|or))|(?:\"\W+[\w+-]+\s*=\s*\d\W+\")|(?:\"\s*is\s*\d.+\"?\w)|(?:\"\|?[\w-]{3,}[^\w\s.,]+\")|' + '(?:\"\s*is\s*[\d.]+\s*\W.*\")'; Description: 'Detects basic SQL authentication bypass attempts 3/3'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:[\d\W]\s+as\s*[\"\w]+\s*from)|(?:^[\W\d]+\s*(?:union|select|create|rename|truncate|load|alter|delete|update|insert|desc))|(?:(?:select|create|rename|truncate|load|alter|delete|update|insert|desc)\s+(?:(?:group_)concat|char|load_file)\s?\(?)|' + '(?:end\s*\);)|(\"\s+regexp\W)|(?:[\s(]load_file\s*\()'; Description: 'Detects concatenated basic SQL injection and SQLLFI attempts'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:@.+=\s*\(\s*select)|(?:\d+\s*or\s*\d+\s*[\-+])|(?:\/\w+;?\s+(?:having|and|or|select)\W)|(?:\d\s+group\s+by.+\()|(?:(?:;|#|--)\s*(?:drop|alter))|(?:(?:;|#|--)\s*(?:update|insert)\s*\w{2,})|(?:[^\w]SET\s*@\w+)|(?:(?:n?and|x?or|not |\|\||\&\&)' + '[\s(]+\w+[\s)]*[!=+]+[\s\d]*[\"=()])'; Description: 'Detects chained SQL injection attempts 1/2'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:\"\s+and\s*=\W)|(?:\(\s*select\s*\w+\s*\()|(?:\*\/from)|(?:\+\s*\d+\s*\+\s*@)|(?:\w\"\s*(?:[-+=|@]+\s*)+[\d(])|(?:coalesce\s*\(|@@\w+\s*[^\w\s])|(?:\W!+\"\w)|(?:\";\s*(?:if|while|begin))|(?:\"[\s\d]+=\s*\d)|(?:order\s+by\s+if\w*\s*\()|(?:' + '[\s(]+case\d*\W.+[tw]hen[\s(])'; Description: 'Detects chained SQL injection attempts 2/2'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:(select|;)\s+(?:benchmark|if|sleep)\s*?\(\s*\(?\s*\w+)'; Description: 'Detects SQL benchmark and sleep injection attempts including conditional queries'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:create\s+function\s+\w+\s+returns)|(?:;\s*(?:select|create|rename|truncate|load|alter|delete|update|insert|desc)\s*[\[(]?\w{2,})'; Description: 'Detects MySQL UDF injection and other data/structure manipulation attempts'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:alter\s*\w+.*character\s+set\s+\w+)|(\";\s*waitfor\s+time\s+\")|(?:\";.*:\s*goto)'; Description: 'Detects MySQL charset switch and MSSQL DoS attempts'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:procedure\s+analyse\s*\()|(?:;\s*(declare|open)\s+[\w-]+)|(?:create\s+(procedure|function)\s*\w+\s*\(\s*\)\s*-)|(?:declare[^\w]+[@#]\s*\w+)|(exec\s*\(\s*@)'; Description: 'Detects MySQL and PostgreSQL stored procedure/function injections'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:select\s*pg_sleep)|(?:waitfor\s*delay\s?\"+\s?\d)|(?:;\s*shutdown\s*(?:;|--|#|\/\*|{))'; Description: 'Detects Postgres pg_sleep injection, waitfor delay attacks and database shutdown attempts'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:\sexec\s+xp_cmdshell)|(?:\"\s*!\s*[\"\w])|(?:from\W+information_schema\W)|(?:(?:(?:current_)?user|database|schema|connection_id)\s*\([^\)]*)|(?:\";?\s*(?:select|union|having)\s*[^\s])|' + '(?:\wiif\s*\()|(?:exec\s+master\.)|(?:union select @)|(?:union[\w(\s]*select)|(?:select.*\w?user\()|(?:into[\s+]+(?:dump|out)file\s*\")'; Description: 'Detects MSSQL code execution and information gathering attempts'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:merge.*using\s*\()|(execute\s*immediate\s*\")|(?:\W+\d*\s*having\s*[^\s\-])|(?:match\s*[\w(),+-]+\s*against\s*\()'; Description: 'Detects MATCH AGAINST, MERGE, EXECUTE IMMEDIATE and HAVING injections'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:,.*[)\da-f\"]\"(?:\".*\"|\Z|[^\"]+))|(?:\Wselect.+\W*from)|((?:select|create|rename|truncate|load|alter|delete|update|insert|desc)\s*\(\s*space\s*\()'; Description: 'Detects MySQL comment-/space-obfuscated injections and backtick termination'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:@[\w-]+\s*\()|(?:]\s*\(\s*[\"!]\s*\w)|(?:<[?%](?:php)?.*(?:[?%]>)?)|(?:;[\s\w|]*\$\w+\s*=)|(?:\$\w+\s*=(?:(?:\s*\$?\w+\s*[(;])|\s*\".*\"))|(?:;\s*\{\W*\w+\s*\()'; Description: 'Detects code injection attempts 1/3'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:(?:[;]+|(<[?%](?:php)?)).*(?:define|eval|file_get_contents|include|require|require_once|set|shell_exec|phpinfo|system|passthru|preg_\w+|execute)\s*[\"(@])'; Description: 'Detects code injection attempts 2/3'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:(?:[;]+|(<[?%](?:php)?)).*[^\w](?:echo|print|print_r|var_dump|[fp]open))|(?:;\s*rm\s+-\w+\s+)|(?:;.*{.*\$\w+\s*=)|(?:\$\w+\s*\[\]\s*=\s*)'; Description: 'Detects code injection attempts 3/3'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:function[^(]*\([^)]*\))|(?:(?:delete|void|throw|instanceof|new|typeof)[^\w.]+\w+\s*[([])|([)\]]\s*\.\s*\w+\s*=)|(?:\(\s*new\s+\w+\s*\)\.)'; Description: 'Detects common function declarations and special JS operators'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:[\w.-]+@[\w.-]+%(?:[01][\db-ce-f])+\w+:)'; Description: 'Detects common mail header injections'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\.pl\?\w+=\w?\|\w+;)|(?:\|\(\w+=\*)|(?:\*\s*\)+\s*;)'; Description: 'Detects perl echo shellcode injection and LDAP vectors'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:(^|\W)const\s+[\w\-]+\s*=)|(?:(?:do|for|while)\s*\([^;]+;+\))|(?:(?:^|\W)on\w+\s*=[\w\W]*(?:on\w+|alert|eval|print|confirm|prompt))|(?:groups=\d+\(\w+\))|(?:(.)\1{128,})'; Description: 'Detects basic XSS DoS attempts'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:\({2,}\+{2,}:{2,})|(?:\({2,}\+{2,}:+)|(?:\({3,}\++:{2,})|(?:\$\[!!!\])'; Description: 'Detects unknown attack vectors based on PHPIDS Centrifuge detection'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:[\s\/\"]+[-\w\/\\\*]+\s*=.+(?:\/\s*>))'; Description: 'Finds attribute breaking injections including obfuscated attributes'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:(?:msgbox|eval)\s*\+|(?:language\s*=\*vbscript))'; Description: 'Finds basic VBScript injection attempts'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:\[\$(?:ne|eq|lte?|gte?|n?in|mod|all|size|exists|type|slice|or)\])'; Description: 'Finds basic MongoDB SQL injection attempts'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:[\s\d\/\"]+(?:on\w+|style|poster|background)=[$\"\w])|(?:-type\s*:\s*multipart)'; Description: 'finds malicious attribute injection attempts and MHTML attacks'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:(sleep\((\s*)(\d*)(\s*)\)|benchmark\((.*)\,(.*)\)))'; Description: 'Detects blind sqli tests using sleep() or benchmark().'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:(\%SYSTEMROOT\%))'; Description: 'An attacker is trying to locate a file to read or write.'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:(((.*)\%[c|d|i|e|f|g|o|s|u|x|p|n]){8}))'; Description: 'Looking for a format string attack'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:(union(.*)select(.*)from))'; Description: 'Looking for basic sql injection. Common attack string for mysql, oracle and others.'),
    (InjTypes: [injSQL]; Enable: True; Role: '(?:^(-0000023456|4294967295|4294967296|2147483648|2147483647|0000012345|-2147483648|-2147483649|0000023456|2.2250738585072007e-308|1e309)$)'; Description: 'Looking for intiger overflow attacks, these are taken from skipfish, except 2.2250738585072007e-308 is the \"magic number\" crash'),
    (InjTypes: [injXSS]; Enable: True; Role: '(?:%23.*?%0A)'; Description: 'Detects SQL comment filter evasion')
  );
  {$ENDIF IRISWEB}

  // ### parametri Rp502Pro ###

  //Costanti usate in XParam
  XP_ANTICIPA_FLEXPM_CAUS      = '<ANTICIPA_FLEXPM_CAUS>';
  XP_APPOGGIO_FLEXPM_CAUS      = '<APPOGGIO_FLEXPM_CAUS>';
  XP_APPOGGIO_FLEXPM_NOCAUS    = '<APPOGGIO_FLEXPM_NOCAUS>';
  XP_ARROTNEGPOS_FINALE        = '<ARROTNEGPOS_FINALE>';
  XP_COHSA_FERIE_SUMAI         = '<COHSA_FERIE_SUMAI>';
  XP_COTO_ORECAUS_DETPM        = '<COTO_ORECAUS_DETPM>';
  XP_COTO_SPEZZNONCAUS_DETPM   = '<COTO_SPEZZNONCAUS_DETPM>';
  XP_CRV_ALLARGA_PMT           = '<CRV_ALLARGA_PMT>';
  XP_CRV_STR_GIUSDAA           = '<CRV_STR_GIUSDAA>';
  XP_DETRAZ_CAUSESC_PMA        = '<DETRAZ_CAUSESC_PMA>'; //GENOVA_HGALLIERA,PALERMO_ARPA: Detrazione PMA con priorità su causali escluse
  XP_GEST_ANTIC_CAUS_UE        = '<GEST_ANTIC_CAUS_UE>';
  XP_GIUST_PAUMENDET           = '<GIUST_PAUMENDET>';
  XP_GOLGI_ENTRATA_RIT         = '<GOLGI_ENTRATA_RIT>';
  XP_INTERSEZPMT_ESTERNA       = '<INTERSEZPMT_ESTERNA>';
  XP_LIBPROF_SUMAI             = '<LIBPROF_SUMAI>';
  XP_LIBPROF_FLEXPOM           = '<LIBPROF_FLEXPOM>';
  XP_LIBPROF_CAUS              = '<LIBPROF_CAUS>';
  XP_PARMA_INDTURNO            = '<PARMA_INDTURNO>';
  XP_INDTURNO_CAUSALIZZATA     = '<INDTURNO_CAUSALIZZATA>';
  XP_PROLUNGA_TIMB_SPEZZATE    = '<PROLUNGA_TIMB_SPEZZATE>';
  XP_RAVDA_FESTLAV_DEBITO0     = '<RAVDA_FESTLAV_DEBITO0>';
  XP_RAVDA_STRAOINFASCE        = '<RAVDA_STRAOINFASCE>';
  XP_REC_PSICOFISICO           = '<REC_PSICOFISICO>';
  XP_REC_SPEZZATO_PM_AUTO      = '<REC_SPEZZATO_PM_AUTO>';
  XP_REC_SPEZZATO_PM_MINIMA    = '<REC_SPEZZATO_PM_MINIMA>';
  XP_SGM_CAUSARR_FASCE         = '<SGM_CAUSARR_FASCE>';
  XP_TC_FLEX_EXTRAPN           = '<TC_FLEX_EXTRAPN>';
  XP_TC_NO_PROLUNG_PMT         = '<TC_NO_PROLUNG_PMT>';
  XP_TC_RIPOCOM_GIUSTIF        = '<TC_RIPOCOM_GIUSTIF>';
  //XP_TC_TURNOPIANIFICATO       = '<TC_TURNOPIANIFICATO>';
  XP_TURNO_NOTTURNO            = '<TURNO_NOTTURNO>';
  XP_Z044_NOAPPOGGIO           = '<Z044_NOAPPOGGIO>';
  XP_Z061_HHMINIME_APPOGGIO_PM = '<Z061_HHMINIME_APPOGGIO_PM>';
  XP_Z062_APPOGGIO_TIMBORIG    = '<Z062_APPOGGIO_TIMBORIG>';
  XP_Z062_APPOGGIO_TURNONOTT   = '<Z062_APPOGGIO_TURNONOTT>';
  XP_Z062_PENALIZZA_OREESTERNE = '<Z062_PENALIZZA_OREESTERNE>';
  XP_Z088_INTERVALLO_FLEX      = '<Z088_INTERVALLO_FLEX>';
  XP_Z094_SOLO1TURNO           = '<Z094_SOLO1TURNO>';
  XP_Z142_OREESCL_NO_PM        = '<Z142_OREESCL_NO_PM>';
  XP_Z145                      = '<Z145>';       //attivazione del limite al debito gg sulle ore fatte nei punti nominali
  XP_Z068_NO83                 = '<Z068_NO83>';  //Messina università: causale 83 no su orario D9
  XP_Z212_TUTTE_TIMB           = '<Z212_TUTTE_TIMB>';
  XP_Z750_COMP_UNONCAUS        = '<Z750_COMP_UNONCAUS>';
  XP_Z780_DETRAZ_CAUS_PMA      = '<Z780_DETRAZ_CAUS_PMA>';

  XParamList: Array [1..43] of String = (
    XP_ANTICIPA_FLEXPM_CAUS,
    XP_APPOGGIO_FLEXPM_CAUS,
    XP_APPOGGIO_FLEXPM_NOCAUS,
    XP_ARROTNEGPOS_FINALE,
    XP_COHSA_FERIE_SUMAI,
    XP_COTO_ORECAUS_DETPM,
    XP_COTO_SPEZZNONCAUS_DETPM,
    XP_CRV_ALLARGA_PMT,
    XP_CRV_STR_GIUSDAA,
    XP_DETRAZ_CAUSESC_PMA,
    XP_GEST_ANTIC_CAUS_UE,
    XP_GIUST_PAUMENDET,
    XP_GOLGI_ENTRATA_RIT,
    XP_INTERSEZPMT_ESTERNA,
    XP_LIBPROF_SUMAI,
    XP_LIBPROF_FLEXPOM,
    XP_LIBPROF_CAUS,
    XP_PARMA_INDTURNO,
    XP_INDTURNO_CAUSALIZZATA,
    XP_PROLUNGA_TIMB_SPEZZATE,
    XP_RAVDA_FESTLAV_DEBITO0,
    XP_RAVDA_STRAOINFASCE,
    XP_REC_PSICOFISICO,
    XP_REC_SPEZZATO_PM_AUTO,
    XP_REC_SPEZZATO_PM_MINIMA,
    XP_SGM_CAUSARR_FASCE,
    XP_TC_FLEX_EXTRAPN,
    XP_TC_NO_PROLUNG_PMT,
    XP_TC_RIPOCOM_GIUSTIF,
    //XP_TC_TURNOPIANIFICATO,
    XP_TURNO_NOTTURNO,
    XP_Z044_NOAPPOGGIO,
    XP_Z061_HHMINIME_APPOGGIO_PM,
    XP_Z062_APPOGGIO_TIMBORIG,
    XP_Z062_APPOGGIO_TURNONOTT,
    XP_Z062_PENALIZZA_OREESTERNE,
    XP_Z088_INTERVALLO_FLEX,
    XP_Z094_SOLO1TURNO,
    XP_Z142_OREESCL_NO_PM,
    XP_Z145,XP_Z068_NO83,
    XP_Z212_TUTTE_TIMB,
    XP_Z750_COMP_UNONCAUS,
    XP_Z780_DETRAZ_CAUS_PMA
  );

  //XParam per mantenimento compatibilità con vecchie versioni
  XP_V77_Z082                  = '<v77_z082>';       //Compatibilità con versioni <= 7.7
  XP_V77_Z560                  = '<v77_z560>';       //Compatibilità con versioni <= 7.7
  XP_V99_Z144                  = '<V99_Z144>';       //Compatibilità con versioni <= 9.9
  XP_V1044_Z148                = '<v1044_z148>';     //Compatibilità con versioni <= 10.4(4)
  XP_V1064_Z550                = '<v1064_z550>';     //Compatibilità con versioni <= 10.6(4)
  XP_V1067_Z570                = '<v1067_z570>';     //Compatibilità con versioni <= 10.6(7)

  XParamCompList: Array [1..6] of String = (
    XP_V77_Z082,
    XP_V77_Z560,
    XP_V99_Z144,
    XP_V1044_Z148,
    XP_V1064_Z550,
    XP_V1067_Z570
  );

  // ### parametri Rp502Pro fine ###

implementation

uses
    FunzioniGenerali
  , System.Variants
  , System.Rtti
  {$IFDEF MSWINDOWS}
  , C180FunzioniGenerali
  {$ENDIF}
  ;

constructor TParametri.Create(AOwner: TComponent);
{$IFDEF MSWINDOWS}
{$IFNDEF IRISWEB}
var
  TempHost, TempIP, Err: String;
{$ENDIF}
{$ENDIF MSWINDOWS}
begin
  inherited Create(AOwner);
  //CampiRiferimento:=TCampiRiferimento.Create(nil);
  Inibizioni:=TStringList.Create;
  NomiTabelleLog:=TStringList.Create;
  ColonneStruttura:=TStringList.Create;
  TipiStruttura:=TStringList.Create;
  SetLength(AbilitazioniFunzioni,0);
  DBUnicode:=False;
  V430:='';
  Lingua:='I';
  FileAnomalie:='';
  ValiditaPassword:=6;
  LunghezzaPassword:=8;
  InibizioneIndividuale:=False;
  ProgressivoOper:=-1;
  MatricolaOper:='';
  CodFiscaleOper:='';
  TipoOperatore:='';
  ProfiloWEB:='';
  ProfiloWEBDelegatoDa:=''; // MONZA_HSGERARDO - chiamata 88132
  ProfiloWEBIterAutorizzativi:='';
  UseStandardPrinter:=False;
  cdsI015:=nil;
  RegolePassword:=TRegolePassword.Create(AOwner);
  // daniloc.ini 28.09.2011
  // host non viene impostato qui per irisweb
  // l'impostazione viene effettuata su A000UInterfaccia - IWServerControllerBaseNewSession
  HostName:='';
  HostIPAddress:='';
  VersionePJ:=VersionePA;
  BuildPJ:=BuildPA;
  DataPJ:=DataPA;
  {$IFDEF MSWINDOWS}
  {$IFNDEF IRISWEB}
  if R180GetIPFromHost(TempHost,TempIP,Err) then
  begin
    HostName:=TempHost;
    HostIPAddress:=TempIP;
  end
  else
  begin
    HostName:='localhost';
    HostIPAddress:='127.0.0.1';
  end;
  {$ENDIF}
  {$ENDIF}
  // daniloc.fine
end;

destructor TParametri.Destroy;
begin
  FreeAndNil(Inibizioni);//.Free;
  FreeAndNil(NomiTabelleLog);//.Free;
  FreeAndNil(ColonneStruttura);//.Free;
  FreeAndNil(TipiStruttura);//.Free;
  SetLength(AbilitazioniFunzioni,0);
  //FreeAndNil(CampiRiferimento);
  if cdsI015 <> nil then
    FreeAndNil(cdsI015);
  inherited Destroy;
end;

function TParametri.GetCharSetUnicode: Boolean;
begin
  Result:=CharSetOracle.ToUpper.Contains('UTF');
end;

function TParametri.GetModuloInstallato(Modulo:String):Boolean;
begin
  Result:=Pos(Modulo + #13,ModuliInstallati) > 0;
end;

{ TMedpCriticalSection }
procedure TMedpCriticalSection.Enter;
begin
  TMonitor.Enter(Self);
end;

procedure TMedpCriticalSection.Leave;
begin
  TMonitor.Exit(Self);
end;

{ TElencoValoriChecklist }

constructor TElencoValoriChecklist.create;
begin
  inherited;
  lstCodice:=TStringList.Create;
  lstDescrizione:=TStringList.Create;
end;

destructor TElencoValoriChecklist.destroy;
begin
  FreeAndNil(lstCodice);
  FreeAndNil(lstDescrizione);
  inherited;
end;

function A000selDizionarioSicurezzaRiepiloghi:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to High(lstRiepiloghi) do
    Result:=Result + ' UNION' + #13#10 + 'SELECT ''SICUREZZA RIEPILOGHI'' TABELLA, ''' + Trim(Copy(lstRiepiloghi[i],1,5)) + ''' CODICE FROM DUAL';
end;

function A000DatiEnteCrypt(Nome:String):String;
var i:Integer;
begin
  Result:='N';
  for i:=1 to High(DatiEnte) do
    if UpperCase(Nome) = UpperCase(DatiEnte[i].Nome) then
    begin
      Result:=DatiEnte[i].Crypt;
      Break;
    end;
end;

function A000GetCodIter(pDesc: String): String;
var i:Integer;
begin
  //Restituisce il codice dell'iter
  Result:=pDesc;
  if pDesc = '' then
    Exit;
  i:=0;
  while (i <= High(A000IterAutorizzativi)) and (A000IterAutorizzativi[i].Desc <> pDesc) do
    inc(i);
  if i <= High(A000IterAutorizzativi) then
    Result:=A000IterAutorizzativi[i].Cod;
end;

function A000GetDescIter(pCod:String):String;
var i:Integer;
begin
  //Restituisce la descrizione dell'iter
  Result:=pCod;
  if pCod = '' then
    Exit;
  i:=0;
  while (i <= High(A000IterAutorizzativi)) and (A000IterAutorizzativi[i].Cod <> pCod) do
    inc(i);
  if i <= High(A000IterAutorizzativi) then
    Result:=A000IterAutorizzativi[i].Desc;
end;


{ TTipoCausaleRecHelper }

function TTipoCausaleRecHelper.ToString: String;
begin
  case Self of
    tcNullo:    Result:='';
    tcAssenza:  Result:='assenza';
    tcPresenza: Result:='presenza';
  else
    raise Exception.Create('Tipo causale sconosciuto');
  end;
end;

{ TRiposteMsg }

constructor TRisposteMsg.Create;
begin
  SetLength(lstRisposteMsg,0);
end;

destructor TRisposteMsg.Destroy;
begin
  SetLength(lstRisposteMsg,0);
  inherited;
end;

procedure TRisposteMsg.Clear;
begin
  SetLength(lstRisposteMsg,0);
  FErrCod:='';
  FErrMsg:='';
  FErrTitolo:='';
  FAttributo:='';
  FBloccante:=False;
end;

procedure TRisposteMsg.AddErr(Cod, Msg: String);
begin
  AddMsg(Cod,Msg);
  FBloccante:=True;
end;

procedure TRisposteMsg.AddErr(Cod, Titolo, Msg: String);
begin
  AddErr(Cod,Msg);
  FErrTitolo:=Titolo;
end;

procedure TRisposteMsg.AddMsg(Cod, Msg: String);
var i,idx:Integer;
begin
  FErrCod:=Cod;
  FErrMsg:=Msg;
  FErrTitolo:='';
  FAttributo:='';
  FBloccante:=False;
  if Cod = '' then
    exit;

  idx:=-1;
  //Ricerco se esiste già Cod
  for i:=0 to High(lstRisposteMsg) do
  begin
    if lstRisposteMsg[i].Cod = Cod then
    begin
      idx:=i;
      Break;
    end;
  end;
  //Se non esiste aggiungo elemento
  if idx = -1 then
    idx:=High(lstRisposteMsg) + 1;

  //Limito array in modo che questo sia l'ultimo elemento
  SetLength(lstRisposteMsg,idx + 1);
  //Inizializzo il messaggio
  lstRisposteMsg[idx].Cod:=Cod;
  lstRisposteMsg[idx].Msg:=Msg;
  lstRisposteMsg[idx].Risposta:='';
end;

procedure TRisposteMsg.AddMsg(Cod, Titolo, Msg: String);
begin
  AddMsg(Cod,Msg);
  FErrTitolo:=Titolo;
end;

procedure TRisposteMsg.AddRisposta(Cod, Risposta: String);
var i,idx:Integer;
begin
  idx:=-1;
  //Ricerco Cod
  for i:=0 to High(lstRisposteMsg) do
  begin
    if lstRisposteMsg[i].Cod = Cod then
    begin
      idx:=i;
      Break;
    end;
  end;
  if idx = -1 then
    raise Exception.Create(Format('Elemento %s non trovato',[Cod]))
  else
    lstRisposteMsg[idx].Risposta:=Risposta;
end;

procedure TRisposteMsg.Assign(APersistent: TPersistent);
var
  i:Integer;
begin
  if APersistent is TRisposteMsg then
  begin
    FErrCod:=TRisposteMsg(APersistent).FErrCod;
    FErrMsg:=TRisposteMsg(APersistent).FErrMsg;
    FErrTitolo:=TRisposteMsg(APersistent).FErrTitolo;
    FAttributo:=TRisposteMsg(APersistent).FAttributo;
    FBloccante:=TRisposteMsg(APersistent).FBloccante;
    SetLength(lstRisposteMsg,Length(TRisposteMsg(APersistent).lstRisposteMsg));
    for i:=Low(lstRisposteMsg) to High(lstRisposteMsg) do
    begin
      lstRisposteMsg[i]:=TRisposteMsg(APersistent).lstRisposteMsg[i];
    end;
  end
  else
    inherited Assign(APersistent);
end;

function TRisposteMsg.Clone: TRisposteMsg;
begin
  Result:=TRisposteMsg.Create;
  Result.Assign(Self);
end;

function TRisposteMsg.GetMsg: TItemRiposteMsg;
var LRisposteMsg:TItemRiposteMsg;
begin
  if High(lstRisposteMsg) >= 0 then
    Result:=lstRisposteMsg[High(lstRisposteMsg)]
  else
    Result:=LRisposteMsg;
end;

function TRisposteMsg.GetRisposta(Cod: String): String;
var i:Integer;
begin
  Result:='';
  //Ricerco Cod
  for i:=0 to High(lstRisposteMsg) do
  begin
    if lstRisposteMsg[i].Cod = Cod then
    begin
      Result:=lstRisposteMsg[i].Risposta;
      Break;
    end;
  end;
end;

{
procedure TRisposteMsg.PutErrMsg(const Value: String);
begin
  FErrMsg:=Value;
  FBloccante:=Value <> '';
end;
}

procedure TRisposteMsg.SetAttributo(const Value: String);
begin
  FAttributo:=Value;
end;

{ TDatiRichiesta }

procedure TDatiRichiesta.Assign(APersistent: TPersistent);
begin
  if APersistent is TDatiRichiesta then
  begin
    Motivazione:=TDatiRichiesta(APersistent).Motivazione;
    NoteIns:=TDatiRichiesta(APersistent).NoteIns;
    IdRevocato:=TDatiRichiesta(APersistent).IdRevocato;
    if RisposteMsg = nil then
      RisposteMsg:=TRisposteMsg.Create;
    RisposteMsg.Assign(TDatiRichiesta(APersistent).RisposteMsg);
  end
  else
    inherited Assign(APersistent);
end;

procedure TDatiRichiesta.Clear;
begin
  Motivazione:='';
  NoteIns:='';
  IdRevocato:=0;
  if Assigned(RisposteMsg) then
    RisposteMsg.Clear;
end;

function TDatiRichiesta.Clone: TDatiRichiesta;
begin
  Result:=TDatiRichiestaGiust.Create;
  Result.Assign(Self);
end;

constructor TDatiRichiesta.Create;
begin
  RisposteMsg:=TRisposteMsg.Create;
  Clear;
end;

destructor TDatiRichiesta.Destroy;
begin
  FreeAndNil(RisposteMsg);
  inherited;
end;

function TDatiRichiesta.ToString: String;
begin

end;

{ TDatiRichiestaGiust }

constructor TDatiRichiestaGiust.Create;
begin
  inherited;
end;

destructor TDatiRichiestaGiust.Destroy;
begin
  inherited;
end;

procedure TDatiRichiestaGiust.Clear;
begin
  inherited;
  Progressivo:=0;
  TipoCausale:=TTipoCausaleRec.Nullo;
  TipoRichiesta:='';
  Causale:='';
  TipoGiust:='';
  Dal:=DATE_NULL;
  Al:=DATE_NULL;
  NumeroOre:='';
  NumeroOrePrev:='';
  AOre:='';
  AOrePrev:='';
  Minuti:=0;
  AMinuti:=0;
  NoteGiustificativo:='';
  Datanas:=DATE_NULL;
end;

procedure TDatiRichiestaGiust.Assign(APersistent: TPersistent);
begin
  inherited Assign(APersistent);
  if APersistent is TDatiRichiestaGiust then
  begin
    Progressivo:=TDatiRichiestaGiust(APersistent).Progressivo;
    TipoCausale:=TDatiRichiestaGiust(APersistent).TipoCausale;
    TipoRichiesta:=TDatiRichiestaGiust(APersistent).TipoRichiesta;
    Causale:=TDatiRichiestaGiust(APersistent).Causale;
    TipoGiust:=TDatiRichiestaGiust(APersistent).TipoGiust;
    Dal:=TDatiRichiestaGiust(APersistent).Dal;
    Al:=TDatiRichiestaGiust(APersistent).Al;
    NumeroOre:=TDatiRichiestaGiust(APersistent).NumeroOre;
    NumeroOrePrev:=TDatiRichiestaGiust(APersistent).NumeroOrePrev;
    AOre:=TDatiRichiestaGiust(APersistent).Aore;
    AOrePrev:=TDatiRichiestaGiust(APersistent).AOrePrev;
    Minuti:=TDatiRichiestaGiust(APersistent).Minuti;
    AMinuti:=TDatiRichiestaGiust(APersistent).AMinuti;
    NoteGiustificativo:=TDatiRichiestaGiust(APersistent).NoteGiustificativo;
    Datanas:=TDatiRichiestaGiust(APersistent).Datanas;
  end;
end;

function TDatiRichiestaGiust.Clone: TDatiRichiestaGiust;
begin
  Result:=TDatiRichiestaGiust.Create;
  Result.Assign(Self);
end;

function TDatiRichiestaGiust.ToString: String;
begin
  Result:=Format('Richiesta di %s'#13#10,[TipoCausale.ToString]) +
          Format('Progressivo: %d'#13#10,[Progressivo]) +
          Format('Causale: %s'#13#10,[Causale]) +
          Format('Tipo giust: %s'#13#10,[TipoGiust]) +
          Format('Dal: %s'#13#10,[DateToStr(Dal)]) +
          Format('Al: %s'#13#10,[DateToStr(Al)]) +
          Format('Numero ore: %s'#13#10,[NumeroOre]) +
          Format('Numero ore prev.: %s'#13#10,[NumeroOrePrev]) +
          Format('A ore: %s'#13#10,[AOre]) +
          Format('A ore prev.: %s'#13#10,[AOrePrev]) +
          Format('Note mezza gg: %s'#13#10,[NoteGiustificativo]) +
          Format('Familiare: %s'#13#10,[IfThen(Datanas = DATE_NULL,'<null>',DateTimeToStr(Datanas))]) +
          StringOfChar('-',50) + #13#10 +
          Format('Motivazione: %s'#13#10,[Motivazione]) +
          Format('Note: %s'#13#10,[NoteIns]) +
          Format('Tipo richiesta: %s'#13#10,[TipoRichiesta]) +
          Format('IdRevocato: %d'#13#10,[IdRevocato]);
end;

function TDatiRichiestaGiust.ValidaPeriodoOrario: TResCtrl;
var
  LDaOre: Integer;
  LAOre: Integer;
begin
  Result.Clear;

  // controlla periodo da ore - a ore
  LDaOre:=TFunzioniGenerali.OreMinuti(NumeroOre);
  LAOre:=TFunzioniGenerali.OreMinuti(AOre);

  // è consentito il periodo hh.mm - 00.00
  if (TipoGiust = 'D') and (LDaOre > LAOre) and (LAOre <> 0) then
  begin
    Result.Messaggio:='L''ora finale deve essere successiva all''ora iniziale!';
    Exit;
  end;
  if TipoGiust <> 'I' then
    Minuti:=LDaOre;
  if TipoGiust = 'D' then
    AMinuti:=LAOre;
  if (TipoGiust = 'N') and (Minuti = 0) then
  begin
    Result.Messaggio:='Indicare un valore orario maggiore di 0';
    Exit;
  end;
  if (TipoGiust = 'D') and (Minuti = AMinuti) and (AMinuti <> 0) then
  begin
    Result.Messaggio:='L''ora finale deve essere successiva all''ora iniziale';
    Exit;
  end;

  Result.Ok:=True;
end;


{ TDatiRichiestaTimb }

constructor TDatiRichiestaTimb.Create;
begin
  inherited;
end;

destructor TDatiRichiestaTimb.Destroy;
begin
  inherited;
end;

function TDatiRichiestaTimb.GetDataOra: TDateTime;
begin
  Result:=Data + GetOraDateTime;
end;

function TDatiRichiestaTimb.GetOraDateTime: TDateTime;
begin
  Result:=EncodeTime(Ora.Substring(0,2).ToInteger,Ora.Substring(3,2).ToInteger,0,0);
end;

function TDatiRichiestaTimb.IsCausaleModificata: Boolean;
begin
  Result:=Causale <> CausaleOrig;
end;

function TDatiRichiestaTimb.IsRilevatoreModificato: Boolean;
begin
  Result:=Rilevatore <> RilevatoreOrig;
end;

function TDatiRichiestaTimb.IsVersoModificato: Boolean;
begin
  Result:=Verso <> VersoOrig;
end;

procedure TDatiRichiestaTimb.Assign(APersistent: TPersistent);
begin
  inherited Assign(APersistent);
  if APersistent is TDatiRichiestaTimb then
  begin
    Progressivo:=TDatiRichiestaTimb(APersistent).Progressivo;
    Operazione:=TDatiRichiestaTimb(APersistent).Operazione;
    Data:=TDatiRichiestaTimb(APersistent).Data;
    Ora:=TDatiRichiestaTimb(APersistent).Ora;
    Verso:=TDatiRichiestaTimb(APersistent).Verso;
    VersoOrig:=TDatiRichiestaTimb(APersistent).VersoOrig;
    Causale:=TDatiRichiestaTimb(APersistent).Causale;
    CausaleOrig:=TDatiRichiestaTimb(APersistent).CausaleOrig;
    Rilevatore:=TDatiRichiestaTimb(APersistent).Rilevatore;
    RilevatoreOrig:=TDatiRichiestaTimb(APersistent).RilevatoreOrig;
  end;
end;

procedure TDatiRichiestaTimb.Clear;
begin
  inherited;

  Progressivo:=0;
  Operazione:='';
  Data:=DATE_NULL;
  Ora:='';
  Verso:='';
  VersoOrig:='';
  Causale:='';
  CausaleOrig:='';
  Rilevatore:='';
  RilevatoreOrig:='';
end;

function TDatiRichiestaTimb.Clone: TDatiRichiestaTimb;
begin
  Result:=TDatiRichiestaTimb.Create;
  Result.Assign(Self);
end;

function TDatiRichiestaTimb.ToString: String;
var
  LDataFmt: String;
begin
  if Data = Date then
    LDataFmt:='oggi '
  else if Data = Date - 1 then
    LDataFmt:='ieri '
  else
    LDataFmt:=FormatDateTime('dddd ',Data);
  LDataFmt:=LDataFmt + FormatDateTime('dd/mm/yyyy',Data);

  Result:=Format('timbratura di %s'#13#10,[IfThen(Verso = 'E','entrata','uscita')]) +
          Format('effettuata %s'#13#10,[LDataFmt]) +
          Format('alle %s',[Ora]) +
          IfThen(Causale <> '',Format(#13#10'con causale %s',[Causale])) +
          IfThen(Rilevatore <> '',Format(#13#10'sul rilevatore %s'#13#10,[Rilevatore]));
  if Result.EndsWith(#13#10) then
    Result:=Result.Substring(0,Result.Length - 2);
end;

{ TDatiTimbratura }

procedure TDatiTimbratura.Assign(APersistent: TPersistent);
begin
  if APersistent is TDatiTimbratura then
  begin
    Progressivo:=TDatiTimbratura(APersistent).Progressivo;
    DataOra:=TDatiTimbratura(APersistent).DataOra;
    Data:=TDatiTimbratura(APersistent).Data;
    Ora:=TDatiTimbratura(APersistent).Ora;
    Verso:=TDatiTimbratura(APersistent).Verso;
    Causale:=TDatiTimbratura(APersistent).Causale;
    Rilevatore:=TDatiTimbratura(APersistent).Rilevatore;
    TimbCausalizzabile:=TDatiTimbratura(APersistent).TimbCausalizzabile;
    EsistonoTolleranze:=TDatiTimbratura(APersistent).EsistonoTolleranze;
    if RisposteMsg = nil then
      RisposteMsg:=TRisposteMsg.Create;
    RisposteMsg.Assign(TDatiTimbratura(APersistent).RisposteMsg);
  end
  else
    inherited Assign(APersistent);
end;

function TDatiTimbratura.Check: TResCtrl;
begin
  Result.Clear;

  // data
  if Data = DATE_NULL then
  begin
    Result.Messaggio:='la data non è indicata!';
    Exit;
  end;

  // ora
  if Ora = DATE_NULL then
  begin
    Result.Messaggio:='l''ora non è indicata!';
    Exit;
  end;

  // verso
  if Verso = '' then
  begin
    Result.Messaggio:=Format('il verso non è indicato!',[]);
    Exit;
  end;

  if not TFunzioniGenerali._In(Verso,['E','U']) then
  begin
    Result.Messaggio:=Format('il verso indicato non è valido: "%s"',[Verso]);
    Exit;
  end;

  Result.Ok:=True;
end;

procedure TDatiTimbratura.Clear;
begin
  Progressivo:=0;
  DataOra:=DATE_NULL;
  Data:=DATE_NULL;
  Ora:=DATE_NULL;
  Verso:='';
  Causale:='';
  Rilevatore:='';
  TimbCausalizzabile:=False;
  EsistonoTolleranze:=False;
  if Assigned(RisposteMsg) then
    RisposteMsg.Clear;
end;

function TDatiTimbratura.Clone: TDatiTimbratura;
begin
  Result:=TDatiTimbratura.Create;
  Result.Assign(Self);
end;

constructor TDatiTimbratura.Create;
begin
  RisposteMsg:=TRisposteMsg.Create;
  Clear;
end;

destructor TDatiTimbratura.Destroy;
begin
  FreeAndNil(RisposteMsg);
  inherited;
end;

function TDatiTimbratura.GetOraT100: String;
begin
  Result:=Ora.ToString('hh.nn.ss');
end;

function TDatiTimbratura.GetVersoDesc: String;
begin
  if Verso = 'E' then
    Result:='entrata'
  else if Verso = 'U' then
    Result:='uscita'
  else
    Result:='sconosciuto: ' + Verso;
end;

function TDatiTimbratura.ToString: String;
begin
  Result:='';
end;

{ TDato }

procedure TDato.Clear;
begin
  Codice:='';
  Descrizione:='';
end;

function TDato.ToString: String;
// restituisce il dato nel formato [codice] - [descrizione]
begin
  Result:=Codice;
  if Descrizione <> '' then
    Result:=Result + ' - ' + Descrizione;
end;

function TDato.ToComboItem: String;
// restituisce la stringa per la combo codice / valore
begin
  Result:=Codice + NAME_VALUE_SEPARATOR + Descrizione;
end;

{ TGiustificativi }

procedure TGiustificativi.Clear;
begin
  Progressivo:=0;
  Data:=DATE_NULL;
  Causale:='';
  DataNas:=DATE_NULL;
  ProgCaus:=0;
  Tipo:='';
  DaOre:=0;
  AOre:=0;
  NuovoPeriodo:=False;
  Validata:='';
  Note:='';
  IDRichiesta:=0;
  IDCertificato:='';
end;

{ TTimbrature }

procedure TTimbrature.Clear;
begin
  Progressivo:=0;
  Data:=DATE_NULL;
  Ora:=Null;
  Verso:='';
  Flag:='';
  Rilevatore:='';
  Causale:='';
  IDRichiesta:=0;
end;

{ TActiveDirectoryUserInfo }

procedure TActiveDirectoryUserInfo.Clear;
begin
  Self.User:='';
  Self.FullName:='';
  Self.Email:='';
end;

{ TResCtrl }

procedure TResCtrl.Clear;
begin
  Self.Ok:=False;
  Self.Messaggio:='';
end;

{ TDateTimeInputInterceptor }

constructor TDateTimeInputInterceptor.Create(ADateTimeIsUTC: Boolean);
begin
  ConverterType:=ctString;
  ReverterType:=rtString;
  FDateTimeIsUTC:=True;
end;

function TDateTimeInputInterceptor.StringConverter(Data: TObject; Field: string): string;
var
  ctx: TRTTIContext;
  date: TDateTime;
  LI64: Int64;
begin
  date:=ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
  LI64:=PInt64(@date)^;
  Result:=Format('%.16X',[LI64]);
end;

procedure TDateTimeInputInterceptor.StringReverter(Data: TObject; Field, Arg: string);
var
  ctx: TRTTIContext;
  datetime: TDateTime;
  LI64: Int64;
  LDouble: double;
begin
  LI64:=StrToInt64('$' + Arg);
  LDouble:=PDouble(@LI64)^;
  datetime:=TDateTime(LDouble);
  ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, datetime);
end;

{ TTipoInclusioneOreNormali }

class function TTipoInclusioneOreNormaliRec.IsEsclusa(const POreNormali: String): Boolean;
// restituisce true se il flag OreNormali indicato rappresenta una causale esclusa dalle ore normali
begin
  Result:=(POreNormali = TTipoInclusioneOreNormaliRec.Esclusa);
end;

class function TTipoInclusioneOreNormaliRec.IsInclusa(const POreNormali: String): Boolean;
// restituisce true se il flag OreNormali indicato rappresenta una causale inclusa nelle ore normali
begin
  Result:=(POreNormali <> TTipoInclusioneOreNormaliRec.Esclusa);
end;

end.


