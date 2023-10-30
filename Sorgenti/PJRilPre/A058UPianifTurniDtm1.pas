unit A058UPianifTurniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione, A000UInterfaccia, Oracle, OracleData,
  C180FunzioniGenerali, R500Lin, Rp502Pro, R600, (*Midaslib,*) Crtl,
  DBClient, Variants, DatiBloccati, Math, QueryStorico, StrUtils, USelI010,
  Generics.Collections, A000UMessaggi, FunzioniGenerali, A210URegoleArchiviazioneDocMW;

const
  COD_RIEPILOGO_INIZIALE = 'T081I';
  COD_RIEPILOGO_CORRENTE = 'T081C';

type
  // tipi proc. generiche
  TprocNone = procedure of object;
  TprocNumRecords = procedure(DataSet: TDataSet) of object;

  TFiltroT606 = record
    Data:TDateTime;
    Condizione:String;
    Giorno:String;
  end;

  TPianifDipInSquadra = record
    CodiceSquadra,
    DescSquadra,
    Operatore:string;
  end;

  TPianificazione = record
    xDatasetPianif:TOracleDataSet;
    xDatasetGiust:TOracleDataSet;
    xQueryPianif:TOracleQuery;
    xQueryGiust:TOracleQuery;
    sFlagAgg:string;
  end;

  TMaxMin = record
    Min,Max,Totale:Integer;
  end;

  TSigle = record
    Sigla,Min,Max:String;
    Totale:Integer;
  end;

  TArrSigle = array of TSigle;

  TOperatori = record
    Operatore:String;
    Totale:Integer;
    Sigle: TArrSigle;
  end;

  TArrOperatori = array of TOperatori;

  TTotGio = record
    Operatori:TArrOperatori;
    OreLiquid:Integer;
  end;

  TTotDip = record
    Operatori:TArrOperatori;
    Riposi:Integer;
  end;

  TTotGenGio = record
    Operatore:String;
    Sigla:String;
    TotaleOperatore:Boolean;
    VisualizzaSempre:Boolean;
    OraEntrata:String;
    Totale:Integer;
  end;

  TArrTotGenGio = array of TTotGenGio;

  TTurnoRep = record
    Turno: String;
    Sigla: String;
    OraInizio: String;
    OraFine: String;
    procedure Clear;
  end;

  TTurno = record
    Turno, TurnoEU, Sigla:string;
    Entrata, Uscita:integer;
    NumTurno:string;
  end;

  TCompetenzaAssenza = ( // Competenza gestione assenza, ovvero: come è gestita l'assenza?
    caVuota,         // Nessuna assenza
    caCartellino,    // Assenza su cartellino (es. gestita da Giustificativi ass./pres. o richiesta di assenza già approvata)
    caIter,          // In gestione su iter autorizzativo
    caPianificazione // Gestita direttamente sul tabellone
  );

  TAssenzaOre = class
    Causale, TipoGiust, Orario: String;
  end;

  TDipSostituto = record
    Progressivo,Badge:LongInt;
    Matricola,Cognome,Nome,Squadra,TipoOpe:String;
    Pianificato:Boolean;
  end;

  //*****************
  //Gestione anomalie
  //*****************
  TTipiAnomalie = (ta11Ore, ta35Ore, taIntersezReperibilita, taIntegritaTNotturni, taAntincendio,
                   taMinFestivitaMese, taMaxNottiMese, taReferente);

  TTipiAnomalieHelper = record Helper for TTipiAnomalie
    function toString:string;
  end;

  TPropAnomalia = class
  public
    Visible:Boolean;
    NomeAnomalia:TTipiAnomalie;
  end;

  TPropElencoAnomalie = class(TObjectList<TPropAnomalia>)
  public
    RegistraAnomalieDB:Boolean;
    function GetAnomalieAttive:string;
    procedure SetAnomalieAttive(const ValueAnomalie:string);
    function GetPropAnomalia(const ValueAnomalia:TTipiAnomalie):TPropAnomalia; overload;
    function GetPropAnomalia(const ValueAnomalia:string):TPropAnomalia; overload;
    constructor Create(AOwnsObjects: Boolean = True);
  end;

  TAnomalia = class
  public
    Testo:string;
    TipoAnomalia:TTipiAnomalie;
    function CopyAnomalia:TAnomalia;
  end;

  TListaAnomalie = class(TObjectList<TAnomalia>)
  private
    Progressivo:integer;
  public
    ParentGiorno:TObject;
    procedure CancellaAnomalie(const inTipoAnomalia:TTipiAnomalie);
    procedure AddAnomalia(const TestoAnomalia:string; const inTipoAnomalia:TTipiAnomalie);
    function GetPropElencoAnomalie:TPropElencoAnomalie;
    function TextAnomalie:string;
  end;
  //*****************

  TNumeroTurno = (ntTurno1 = 1, ntTurno2 = 2);

  TGiorno = class
  private
    SensibilitaModifica:Boolean;
    pModificato:Boolean;
    pT1,pT2,pOra,pAss1,pAss2,pT1EU,pT2EU,pAntincendio,pReferente,pRichiestoDaTurnista:string;
    pMinutiEntrata1, pMinutiUscita1, pMinutiEntrata2, pMinutiUscita2:integer;
    pAss1Competenza, pAss2Competenza: TCompetenzaAssenza;
    procedure setT1(val:string);
    procedure setT2(val:string);
    procedure setAss1(val:string);
    procedure setAss2(val:string);
    procedure setOra(val:string);
    procedure setT1EU(val:string);
    procedure setT2EU(val:string);
    procedure setAntincendio(val:string);
    procedure setModificato(val:Boolean);
    procedure setReferente(Val:string);
    procedure setRichiestoDaTurnista(Val:string);
    function GetInfoTurno(NT12:TNumeroTurno):TTurno;
    function IsTurnoRepPresente:Boolean;
    function GetMinutiUscita1: Integer;
    function GetMinutiUscita2: Integer;
  public
    Data:TDateTime;
    SiglaT1:String;
    SiglaT2:String;
    NumTurno1:String;
    NumTurno2:String;
    ValorGior:String;
    AssOre:TObjectList<TAssenzaOre>;
    VAss:String;
    Flag:String;     //Flag:O = Da pianificazione; M = Pianific.esistente; CS = Cambio Squadra; NT = No pianificazione
    Squadra:String;
    DSquadra:String;
    Oper:String;
    Area:String;
    DArea:String;
    CodServizio:String;
    DescServizio:String;
    VerTurni:String;
    VerRiposi:String;
    Note:String;
    TurniRep: array[1..3] of TTurnoRep; // Turni di reperibilità
    Ass1Modif:Boolean;
    Ass2Modif:Boolean;
    GGFestivo:Boolean;
    Debito:Integer;
    Assegnato:Integer;
    NTimbTurno:Integer; //Timbrature che non escludono il turno
    Anomalie:TListaAnomalie;
    ParentDipendente:TObject;
    ConteggiAggiornati: Boolean; // Indica se i conteggi dei debiti orari del giorno sono aggiornati
    DetDip:TTotDip;
    constructor create;
    destructor destroy; override;
    //Controllo_11ore
    function GetA058Dtm:TDataModule;
    function GetPropElencoAnomalie:TPropElencoAnomalie;
    function Presenza(const ValutaRiposo:Boolean = False):Boolean;
    function RiposoAss1:Boolean;
    function RiposoAss2:Boolean;
    function GetPrimaEntrata:integer;
    function GetUltimaUscita:integer;
    function GetUltimaEntrata:integer;
    function GetPrimaUscita:integer;
    function CopyGiorno:TGiorno;
    function TurnoNotturnoT1:Boolean;
    function TurnoNotturnoT2:Boolean;
    procedure ClearAnomalie;
    procedure SensibilitaModificaOFF;
    procedure SensibilitaModificaON;
    procedure ClearTurniRep;
    property Modificato:Boolean read pModificato write setModificato;
    property MinutiEntrata1:integer read pMinutiEntrata1;
    property MinutiUscita1:integer read GetMinutiUscita1;
    property MinutiEntrata2:integer read pMinutiEntrata2;
    property MinutiUscita2:integer read GetMinutiUscita2;
    property T1:string read pT1 write setT1;
    property T2:string read pT2 write setT2;
    property Ass1:string read pAss1 write setAss1;
    property Ass1Competenza:TCompetenzaAssenza read pAss1Competenza write pAss1Competenza;
    property Ass2:string read pAss2 write setAss2;
    property Ass2Competenza:TCompetenzaAssenza read pAss2Competenza write pAss2Competenza;
    property Ora:string read pOra write setOra;
    property T1EU:string read pT1EU write setT1EU;
    property T2EU:string read pT2EU write setT2EU;
    property Antincendio:string read pAntincendio write setAntincendio;
    property TurnoRepPresente:Boolean read IsTurnoRepPresente;
    property Referente:string read pReferente write setReferente;
    property RichiestoDaTurnista:string read pRichiestoDaTurnista write setRichiestoDaTurnista;
  end;

  TDipendente = class
  private
    pModificato:Boolean;
    procedure setModificato(val:Boolean);
    procedure TestPNTurniInfTurniRep(const Indgg, EntrataInf, UscitaInf:integer);
    function GetConteggiSingoliGiorniAggiornati:Boolean;
  public
    Prog, Badge,TurnoPartenza,
    Debito,Assegnato,RiposiPrec,FestiviLavMeseCorr,FestiviLavMesePrec,FestiviLavAnnoPrec,CompRip,
    ConstMinFestMese,ConstMaxNottiMese:Integer;
    Cognome,Nome,Squadra,TipoOpe,CausRip,Matricola:String;
    TotDip:TTotDip;
    Giorni,GiorniOld:TObjectList<TGiorno>;
    ParentListDip:TObjectList<TDipendente>;
    function GetPropElencoAnomalie:TPropElencoAnomalie;
    function GetA058Dtm:TDataModule;
    function CopyDipendente:TDipendente;
    function GetDayByDate(const Day:TDateTime):TGiorno;
    procedure CancellaAnomalieDipendente(const inTipoAnomalia:TTipiAnomalie);
    procedure ClearAnomalie;
    procedure Controllo_35Ore(const DataElabDa,DataElabA:TDateTime);
    procedure Controllo_11ore(const DataElabDa,DataElabA:TDateTime);
    procedure Controllo_IntersezioneReperibilita(const DataElabDa,DataElabA:TDateTime);
    procedure Controllo_IntegritaTurniNotturni(const DataElabDa,DataElabA:TDateTime);
    procedure Controllo_MinFestivitaMese(const DataElabDa,DataElabA:TDateTime);
    procedure Controllo_MaxNottiMese(const DataElabDa,DataElabA:TDateTime);
    property Modificato:Boolean read pModificato write SetModificato;
    // Indica se tutti i giorni del dipendente hanno i conteggi aggiornati.
    // Notare che è diverso dai conteggi del dipendente, potrei avere tutti i conteggi dei singoli
    // giorni aggiornati ma i conteggi del dipendente no.
    property ConteggiSingoliGiorniAggiornati:Boolean read GetConteggiSingoliGiorniAggiornati;
    constructor create;
    destructor destroy; override;
  end;

  //TListDip<T> = class(TList<T>)
  TListDip = class(TObjectList<TDipendente>)
  private
    pModificato:Boolean;
    procedure SetModificato(val:Boolean);
  public
    Parent:TDataModule;
    PropElencoAnomalie:TPropElencoAnomalie;
    function GetA058Dtm:TDataModule;
    function CopyListaDipendenti:TListDip;
    procedure Controllo_TurnoAntincendio(const DataElabDa,DataElabA:TDateTime);
    procedure Controllo_Referente(const DataElabDa,DataElabA:TDateTime);
    procedure CancellaAnomalieVista(const inTipoAnomalia:TTipiAnomalie);
    procedure ClearAnomalie;
    procedure ResetModifica;
    property Modificato:Boolean read pModificato write setModificato;
    constructor Create(AOwnsObjects: Boolean = True); overload;
    destructor Destroy; override;
  end;

  {Interfaccia package ORACLE(T080PCKTURNO)}
  T080PCKTURNO = class
  private
    AbilitaCopia:Boolean;
    pckT080COPIATURNO:TOracleQuery;
    pckT080GETDATOGENERICO:TOracleQuery;
    pckT080GETTIPOGIORNO:TOracleQuery;
    procedure IniPckT080COPIATURNO;
    procedure InipckT080GETDATOGENERICO;
    procedure IniPckT080GETTIPOGIORNO;
  public
    constructor create;
    destructor destroy; override;
    procedure SetVariabiliCopiaTurnazione(ProgOrig, ProgDest:integer; DataInizio, DataFine:TDateTime);
    function SeEsisteDatoT620(Progr:integer;DataInizio:TDateTime):integer;
    function CopiaTurnazione(EseguiCommit:Boolean = True):string;
    procedure CalcolaDatiADATA(Progr:integer; DataDest:TDateTime);
    function CalcolaTipoGiorno(Progr:Integer; Data:TDateTime; DomenicaFestiva:String):String;
    function GetPartenza:integer;
  end;

  // Tipi per definire i dati da rappresentare nelle griglie WIN e WEB/CLOUD - Inizio
  { Ogni cella contiene una lista di elementi (ovvero i riquadri che contengono turni, assenze, ecc) e una lista di indicatori (
    i triangoli che compaiono a lato della cella per indicare presenza di note o anomalie).
    Ogni elemento e indicatore ha associato uno stile che determina colori di sfondo e testo (quest'ultimo solo per gli elementi).
    Per gli indicatori gli stili sono costituiti dal colore da utilizzare per il riempimento della forma (Win) e il path dell'immagine
    che contiene la freccia (Web).
    Gli stili sono definiti negli array constant STILI_ELEMENTO_CELLA e STILI_INDICATORE_CELLA.
    Ogni elemento contiene inoltre le informazioni necessarie per essere renderizzato in ambiente Windows (testo, area di
    disegno e invisibilità) e Web (testo e invisibilità). Discorso analogo per gli indicatori, che contengono i vertici dell'area
    da disegnare (Windows) e la posizione relativamente al div che li contiene (Web).
    Le celle vengono istanziate e valorizzate nel metodo A058FPianifTurniDtM1.GetCellaUI().
  }
  TTipoStileElementoCellaUI = (tsecModificato=0, tsecTurno=1, tsecAssenza=2, tsecAssenzaVal=3, tsecAssenzaOre=4, tsecTurnoRep=5,
                               tsecAntincendio=6, tsecAssenzaOreVal=7, tsecRiposo=8, tsecAssenzaRichiesta=9,
                               tsecReferente=10, tsecRichiestoDaTurnista=11, tsecSiglaArea=12);
  TTipoElementoCellaUI = (tecModelloOrario, tecTurno, tecAssenza, tecAssenzaOre, tecTurnoRep, tecCompostoFlag,
                          tecAntincendio, tecReferente, tecRichiestoDaTurnista, tecSiglaArea);

  TStileElementoCellaUIWin = record
    ColoreTesto, ColoreSfondo: Integer;  // intero del colore o -1 per trasparente
  end;

  TStileElementoCellaUIWeb = record
    ColoreTesto, ColoreSfondo: String;  // stringa con intero in esadecimale o nome colore oppure '' per trasparente
    AllineamentoTesto: String;
  end;

  TStileElementoCellaUI = record
    StileWin: TStileElementoCellaUIWin;
    StileWeb: TStileElementoCellaUIWeb;
  end;

  TTipoStileIndicatoreCellaUI = (tsicNota=0, tsicAnomalia=1);

  TStileIndicatoreCellaUI = record
    ColoreWin: Integer;
    ImmagineWeb: String;
  end;

  TWinPropElementoCella = record
    Invisibile: Boolean;
    Testo, TestoSintetico:String;
    RectDisegno: TRect;
    StiliCarattere: TFontStyles;
  end;

  TWebPropElementoCella = record
    Invisibile: Boolean;
    Testo, TestoSintetico:String;
    StiliCarattere:String;
  end;

  TElementoCellaUI = class
  public
    TipoElementoCellaUI: TTipoElementoCellaUI;
    TipoStileElementoCellaUI: TTipoStileElementoCellaUI;
    WinProprieta: TWinPropElementoCella;
    WebProprieta: TWebPropElementoCella;
    TipoComplesso:Boolean;
    ListaSottoElementi:TObjectList<TElementoCellaUI>;
    constructor Create;
    destructor Destroy; override;
  end;

  TIndicatoreCellaUI = class
  public
    TipoStileIndicatoreCellaUI: TTipoStileIndicatoreCellaUI;
    VerticiWin: array of TPoint;
    TopWeb,RightWeb,BottomWeb,LeftWeb:String;
  end;

  TCellaUI = class
  public
    Elementi: TObjectList<TElementoCellaUI>;
    Indicatori: TObjectList<TIndicatoreCellaUI>;
    SfondoWin: Integer;
    NumRigheElementiWin: Integer;
    ClasseSfondoWeb: String;
    constructor Create;
    destructor Destroy; override;
  end;

  TWinUITabellaInfo = class
  public
    RectCella: TRect;
    AltezzaRiga: Integer;
    CurrentRowHeight: Integer;
    CurrentColWidth: Integer;
    constructor Create(rRectCella:TRect;iAltezzaRiga,iCurrentRowHeight,iCurrentColWidth:Integer); overload;
  end;

  TGetCellaUIOpzione = (coIncludiAssMezzGior, coIncludiAssOrarie);
  TGetCellaUIOpzioni = set of TGetCellaUIOpzione;
  // Tipi per definire i dati da rappresentare nelle griglie WIN e WEB/CLOUD - Fine

  TStileCampiFissiRicercaSostituti = record
    NomeCampo,
    Etichetta,
    Griglia: String;
  end;

  TselSostitutiVar = record
    Data,
    TabPianif,
    FlagAgg,
    Progressivo,
    Orario,
    DaOre,
    AOre,
    Squadra,
    Azienda,
    Campi,
    OrderBy:String;
  end;

  TA058FPianifTurniDtM1 = class(TDataModule)
    Q020: TOracleDataSet;
    Q020Turni: TOracleDataSet;
    Q040: TOracleDataSet;
    Q080: TOracleDataSet;
    Q221: TOracleDataSet;
    Q265: TOracleDataSet;
    Q265B: TOracleDataSet;
    Q430: TOracleDataSet;
    Q080Gest: TOracleDataSet;
    Q040Gest: TOracleDataSet;
    Q081Gest: TOracleDataSet;
    Q041Gest: TOracleDataSet;
    Q611: TOracleDataSet;
    Q620: TOracleDataSet;
    Q630: TOracleDataSet;
    Q641: TOracleDataSet;
    CancAllT080: TOracleQuery;
    CancT080: TOracleQuery;
    CancT081: TOracleQuery;
    CancT040: TOracleQuery;
    CancT041: TOracleQuery;
    T058Stampa: TClientDataSet;
    QT021: TOracleDataSet;
    dsrT603: TDataSource;
    GetCalend: TOracleQuery;
    _SelQ040: TOracleDataSet;
    Q021: TOracleDataSet;
    D021: TDataSource;
    Q021CODICE: TStringField;
    Q021NUMTURNO: TIntegerField;
    Q021SIGLATURNI: TStringField;
    Q021ENTRATA: TStringField;
    Q021USCITA: TStringField;
    Q021numfascia: TStringField;
    selRiposi: TOracleDataSet;
    selFestLav: TOracleDataSet;
    dsrT606a: TDataSource;
    V430Colonne: TOracleDataSet;
    SovrascriviT041: TOracleQuery;
    InserisciT041: TOracleQuery;
    selT620: TOracleDataSet;
    UpdT040: TOracleQuery;
    selT040: TOracleDataSet;
    selT530: TOracleDataSet;
    selT011: TOracleDataSet;
    selT380: TOracleDataSet;
    selT430: TOracleDataSet;
    selT082: TOracleDataSet;
    dtsT082: TDataSource;
    AusT058: TClientDataSet;
    dtsAusT058: TDataSource;
    selT100: TOracleDataSet;
    selV430: TOracleDataSet;
    selGetSquadraDip: TOracleDataSet;
    selT265Esclusione: TOracleDataSet;
    selV010: TOracleDataSet;
    Q021ID_TURNO: TIntegerField;
    cdsT611: TClientDataSet;
    selAnomalie: TOracleDataSet;
    selAnomalieMSG: TStringField;
    selAnomalieMATRICOLA: TStringField;
    selAnomalieNOMINATIVO: TStringField;
    selT650: TOracleDataSet;
    selT651: TOracleDataSet;
    selT603: TOracleDataSet;
    selT603CODICE: TStringField;
    selT603DESCRIZIONE: TStringField;
    selT606: TOracleDataSet;
    selT603CAUS_RIPOSO: TStringField;
    selT606a: TOracleDataSet;
    selT606b: TOracleDataSet;
    selI210: TOracleDataSet;
    selT962: TOracleDataSet;
    selT606c: TOracleDataSet;
    selTipoOpe: TOracleDataSet;
    selT430TIPOOPE: TStringField;
    selSostituti: TOracleDataSet;
    dsrSostituti: TDataSource;
    scrT630: TOracleQuery;
    selT630: TOracleDataSet;
    selT430B: TOracleDataSet;
    procedure A058FPianifTurniDtM1Create(Sender: TObject);
    procedure A058FPianifTurniDtM1Destroy(Sender: TObject);
    procedure SelAnagrafeFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure ImpostaFiltroOrariSquadra(DataRif:TDateTime);
    procedure Q020AfterOpen(DataSet: TDataSet);
    procedure ReadBufferBeforeOpen(DataSet: TDataSet);
    procedure Q265BeforeOpen(DataSet: TDataSet);
    procedure Q265BBeforeOpen(DataSet: TDataSet);
    procedure selT265EsclusioneBeforeOpen(DataSet: TDataSet);
    procedure FilterRecordT606(DataSet: TDataSet; var Accept: Boolean);
    procedure selSostitutiAfterOpen(DataSet: TDataSet);
    procedure selSostitutiAfterScroll(DataSet: TDataSet);
    procedure selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    TurnazSucc:TDateTime;
    TurnazioneOld:String;
    R600DtM:TR600DtM1;
    ListaCicli,Turno1,Turno2,Orario,Causale:TStringList;
    QSSquadra:TQueryStorico;
    selSostitutiVar: TselSostitutiVar;
    procedure GetPianificazione(inData:TDateTime; Prog,Posizione:LongInt;
                                var T1,T2,T1EU,T2EU,Ora,Ass1,Ass2,ValorGior,Flag,VAss,Antincendio,Note,Referente,RichiestoDaTurnista,Area:String;
                                var Ass1Modif,Ass2Modif:boolean; var AssOre:TObjectList<TAssenzaOre>;
                                var Ass1Competenza,Ass2Competenza:TCompetenzaAssenza);
    function PianifDipInSquadra(inProgressivo:integer;inDataCorr,inDataDa,inDataA:TDateTime):TPianifDipInSquadra;
    function GetTipoGiorno(Data:TDateTime; Prog:LongInt; Calendario:String; DomNonLav:Boolean = False):String;
    function ControlloSuccTurn(ProgDip:Integer;DataIn:TDateTime;TurnoOggi:String):Boolean;
    function TestAssenza(Ass:String):Boolean;
    function TestRiposo(Ass:String):Boolean;
    function TestRiposoComp(Ass:String):Boolean;
    function TestSmontoNotte(Giorno:TGiorno):Boolean;
    function CreaDipendente(Prog,Badge:LongInt;Matricola,Cognome,Nome:String):TDipendente;
    procedure CreaGiorno(MyDip:TDipendente; Data:TDateTime; Posizione:LongInt);
    procedure SviluppoTurnazione(Turnazione:String; Lista:TStringList);
    procedure SviluppoCicli(Lista,Turno1,Turno2,Orario,Causale:TStringList);
    function GetPartenza(Prog:LongInt; var Posizione:LongInt):Boolean;
    procedure GetAssegnazioneTurnazione(Progressivo:Integer;Data:TDate);
    procedure GetTurnazione(var Posizione:LongInt);
    procedure PianificaGiorno(NDip,G:LongInt; BloccoT040,BloccoT080:Boolean; xArrayPianif:TPianificazione);
    procedure PianificaOrario(NDip,G:LongInt; Giorno:TGiorno;xArrayPianif:TPianificazione);
    procedure PianificaAssenza(NDip,G:LongInt; A1,A2:String; xArrayPianif:TPianificazione);
    function IsIntervalloMensile(DataDa,DataA:TDateTime):Boolean;
    function ModificaData(InDate:TDateTime;AA,MM,GG:Word):TDateTime;
    function EsisteRiposo(ValNumTurno1,ValT1,ValT1EU,ValAss1,ValNumTurno2,ValT2,ValAss2:String):Boolean;
    procedure AggiornaRipDip(var TotDip:TTotDip; ValInc,ValDec:Integer);
    procedure AggiornaTotOpe(var TotOpe:Integer; ValInc,ValDec:Integer);
    procedure AggiornaTotDip(var arrSigle:TArrSigle; iSg:Integer; ValInc,ValDec:Integer);
    procedure AggiornaTotGio(var arrSigle:TArrSigle; iSg:Integer; ValInc,ValDec:Integer);
    procedure AggiornaTotGenGio(var arrTotali:TArrTotGenGio; sOper,sSigla:String;nMinutiEntrata,ValInc,ValDec:Integer;TotOpe,VisSempre:Boolean);
    function  DecodeCompetenzaAssenza(Stringa:String):TCompetenzaAssenza;
  public
    { Public declarations }
    A058PCKT080TURNO:T080PCKTURNO;
    OldInizio,OldFine,DataInizio,DataFine:TDateTime;
    SalvaSQLOriginale:String;
    ElaborazioneInterrotta,AnomaliePianif,NuovaPianif,EscludiTipoCumulo,
    AssenzeOperative,ConteggiaDebito,GeneraIniCorr,ControlloAnnualeAnomalie:Boolean;
    R502ProDtM:TR502ProDtM1;
    A210MW: TA210FRegoleArchiviazioneDocMW;
    Vista:TListDip;
    xValoreOrigine:TGiorno;
    TotGio: array of TTotGio;
    TotTabGio: TArrTotGenGio;
    TotPagGio: TArrTotGenGio;
    TotPagDip: TArrTotGenGio;
    OffsetVista,TipoPianif,LungCella:Integer;
    SelAnagrafeA058:TOracleDataSet;
    selDatiBloccatiA058:TDatiBloccati;
    sOperatore,sNumTurno1,sSiglaT1,sT1,sT1EU,sAss1,sNumTurno2,sSiglaT2,sT2,sT2EU,sAss2:string;
    SquadraRiferimento:String;
    IncludiDipCambioSquadra:Boolean;
    procProgressBarInizio:TprocNone;
    procProgressBarNext:TprocNone;
    procProgressBarFine:TprocNone;
    procRichiediAggiornaSostituti:TprocNone;
    procNumRecords:TprocNumRecords;
    FiltroT606:TFiltroT606;
    RicercaSostituti:Boolean;
    DipSostituto: TDipSostituto;
    selI010:TSelI010;
    procedure FiltraT606(ODS:TOracleDataset; Data:TDateTime; Condizione,Giorno:String);
    function GetTipoOpe(Prog:integer):string;
    function GetSquadra(Prog:integer):string;
    function GetTipoGiornoServizio(D:TDateTime):String;
    function GetOrarioStorico(Data:TDateTime; Prog:LongInt):String;
    function GetSquadraPiuAssegnata(SquadraIniziale:String):String;
    function GetDatoPiuAssegnato(Campo:String;Data:TDateTime):String;
    function GetConteggioTurni(Data:TDateTime; TipoOpe,SiglaTurno:String):TMaxMin;
    function OrdinamentoStampa:string;
    procedure CreateVarSpostamentoSquadra(Dts:TOracleDataSet);
    procedure ClearVarSpostamentoSquadra(Dts:TOracleDataSet);
    procedure RefreshReperibilità;
    procedure RefreshSquadre;
    procedure selSostitutiVarImposta(DataRif:TDateTime;ProgressivoOrigine:LongInt;Orario,DalleAlle,Campi:String);
    function selSostitutiVarCambiate:Boolean;
    procedure AvviaRicercaSostituti;
    procedure selSostitutiApplicaFiltro(Filtra:Boolean;Filtro:String = '--');
    procedure OpenSelV430(OutDato:String);
    procedure OpenSelT100(Prog:Integer;DaData,AData:TDateTime);
    procedure EditSQLC700;
    procedure EstraiTurnazioni(Data:TDateTime);
    procedure AggiornaContatoriTurni(nRiga:integer;nColonna:integer;DopoElabTurni:Boolean = False);
    procedure LeggiPianificazione(Prog:LongInt;DataIniElab,DataFinElab:TDateTime; CreaPianif:Boolean = True);
    procedure PianificaDipendente(Prog:LongInt);
    procedure PulisciVista;
    procedure PulisciDipSostituto;
    procedure InizializzaGiorno(MyDip:TDipendente; iGg:Integer);
    function InizializzaOperatore(Operatore:String; var arrOperatori:TArrOperatori):Integer;
    function InizializzaSigla(MyDip:TDipendente; iGg:Integer; Operatore,SiglaTurno:String; var arrSigle:TArrSigle; PrelevaMinMax:Boolean):Integer;
    procedure AggiornaTotaleTurni(MyDip:TDipendente; iGg:Integer; ValPrecedenti:Boolean);
    procedure AggiornaTotPagGio(IndiceGiornoPartenza,NumeroGiorni:Integer);
    procedure AggiornaTotPagDip(MyDip:TDipendente; IndiceGiornoPartenza,NumeroGiorni:Integer);
    function GetSimboloOperatore(Operatore,Sigla:String;ArrCercaSigla:TArrTotGenGio):String;
    procedure DebitoDipendente(MyDip:TDipendente; Dal,Al:Integer);
    procedure RefreshAssenze(DataDa,DataA:TDateTime);
    procedure VerificaPianificazione(DataElabDa,DataElabA:TDateTime);
    procedure LeggiValoriCella(iDipendente:Integer;iGiorno:Integer);
    {begin Conteggi giornalieri}
    procedure InizializzaConteggiGIornalieri(MyDip:TDipendente; IGiorno:Integer; var ConteggioNormale:Boolean);
    procedure ConteggiGiornalieri(Data:TDateTime; MyDip:TDipendente; IGiorno:Integer);
    {end Conteggi giornalieri}
    {begin 35Ore - 11Ore - IntersezioniReperibilità - Integrita turni notturni}
    procedure AnomalieXDipendente(Dipendente:TDipendente);
    {end}
    procedure CreaTabStampaAss;
    procedure CaricaTabStampaAss;
    procedure RefreshQ021(D:TDateTime);
    procedure EseguiPianificazione(NDip:LongInt;DataRif:TDateTime);
    procedure RendiOperativa(NDip:LongInt);
    procedure CancellaPianificazione(Prog:LongInt);
    function  GetCellaUI(IndDipendente, IndGiorno: Integer; Opzioni:TGetCellaUIOpzioni; WinUITabellaInfo: TWinUITabellaInfo=nil):TCellaUI;
    function  GetVistaInCSV(Sintetico:Boolean):String;
    function  PianifBloccata(Progressivo: Integer; Data: TDateTime): Boolean;
    procedure EseguiBloccaSblocca(Operazione:String);
    procedure AbilitaBloccaSblocca(var AbilitaBlocca, AbilitaSblocca: Boolean);
    function ReperisciDArea(Area:String):String;
    procedure GetAreeAfferenza(Squadra,Operatore:String);
    function GetSiglaArea(Area:String):String;
    function getColoreCellaWIN(Colore:String):integer;
    function getColoreStyleWEB(Colore:String):String;
    function getColoreClassWEB(Colore:String):String;
  end;

{$IFNDEF IRISWEB}
var
  A058FPianifTurniDtM1: TA058FPianifTurniDtM1;
{$ENDIF}

const
   STILI_ELEMENTO_CELLA: array[Low(TTipoStileElementoCellaUI)..High(TTipoStileElementoCellaUI)] of TStileElementoCellaUI = (
    (// tsecModificato
     StileWin:                (ColoreTesto: clRed;       ColoreSfondo: clNone);
     StileWeb:                (ColoreTesto: '#FF0000';   ColoreSfondo: '';        AllineamentoTesto: 'left')),
     (// tsecTurno;
     StileWin:                (ColoreTesto: clBlack;     ColoreSfondo: clNone);
     StileWeb:                (ColoreTesto: '#000000';   ColoreSfondo: '';        AllineamentoTesto: 'left')),
     (// tsecAssenza;
     StileWin:                (ColoreTesto: clWhite;     ColoreSfondo: clRed);
     StileWeb:                (ColoreTesto: '#FFFFFF';   ColoreSfondo: '#FF0000'; AllineamentoTesto: 'left')),
     (// tsecAssenzaVal;
     StileWin:                (ColoreTesto: clBlack;     ColoreSfondo: clAqua);
     StileWeb:                (ColoreTesto: '#000000';   ColoreSfondo: '#00FFFF'; AllineamentoTesto: 'left')),
     (// tsecAssenzaOre;
     StileWin:                (ColoreTesto: clBlack;     ColoreSfondo: $00DCB9FF);
     StileWeb:                (ColoreTesto: '#000000';   ColoreSfondo: '#FFB9DC'; AllineamentoTesto: 'left')),
     (// tsecTurnoRep;
     StileWin:                (ColoreTesto: clYellow;    ColoreSfondo: clBlue);
     StileWeb:                (ColoreTesto: '#FFFF00';   ColoreSfondo: '#0000FF'; AllineamentoTesto: 'left')),
     (// tsecAntincendio;
     StileWin:                (ColoreTesto: clWhite;     ColoreSfondo: clWebOrange);
     StileWeb:                (ColoreTesto: '#FFFFFF';   ColoreSfondo: '#FFA500'; AllineamentoTesto: '')),
     (// tsecAssenzaOreVal
     StileWin:                (ColoreTesto: clBlack;     ColoreSfondo: $00FFFFCC);
     StileWeb:                (ColoreTesto: '#000000';   ColoreSfondo: '#CCFFFF'; AllineamentoTesto: 'left')),
     (// tsecRiposo
     StileWin:                (ColoreTesto: clBlack;     ColoreSfondo: clNone);
     StileWeb:                (ColoreTesto: '#000000';   ColoreSfondo: '';        AllineamentoTesto: 'left')),
     (// tsecAssenzaRichiesta
     StileWin:                (ColoreTesto: clBlack;     ColoreSfondo: $00D900);
     StileWeb:                (ColoreTesto: '#000000';   ColoreSfondo: '#00D900'; AllineamentoTesto: 'left')),
     (// tsecReferente
     StileWin:                (ColoreTesto: clWhite;     ColoreSfondo: $FF00FF);
     StileWeb:                (ColoreTesto: '#FFFFFF';   ColoreSfondo: '#FF00FF'; AllineamentoTesto: '')),
     (//tsecRichiestoDaTurnista
     StileWin:                (ColoreTesto: clBlack;     ColoreSfondo: $00FF00);
     StileWeb:                (ColoreTesto: '#000000';   ColoreSfondo: '#00FF00'; AllineamentoTesto: '')),
     (//tsecSiglaArea
     StileWin:                (ColoreTesto: clBlack;     ColoreSfondo: $00FF00);
     StileWeb:                (ColoreTesto: '#000000';   ColoreSfondo: '#00FF00'; AllineamentoTesto: ''))
  );

  STILI_INDICATORE_CELLA: array[Low(TTipoStileIndicatoreCellaUI)..High(TTipoStileIndicatoreCellaUI)] of TStileIndicatoreCellaUI = (
    (ColoreWin: clBlue;        ImmagineWeb: './img/nota_corner.png'),
    (ColoreWin: clRed;         ImmagineWeb: './img/anomalia_corner.png')
  );

  CAMPI_FISSI_RICERCA_SOSTITUTI: array[0..31] of TStileCampiFissiRicercaSostituti = (
    (NomeCampo: 'MATRICOLA';        Etichetta: 'Matricola';                                   Griglia: 'Matricola'),               //00
    (NomeCampo: 'COGNOME';          Etichetta: 'Cognome';                                     Griglia: 'Cognome'),                 //01
    (NomeCampo: 'NOME';             Etichetta: 'Nome';                                        Griglia: 'Nome'),                    //02
    (NomeCampo: 'ETA_ANNI';         Etichetta: 'Età';                                         Griglia: 'Età'),                     //03
    (NomeCampo: 'RL_ANNI';          Etichetta: 'Anzianità di servizio';                       Griglia: 'Anz. servizio'),           //04
    (NomeCampo: 'ULTIMO_TR_GGPREC'; Etichetta: 'Ultimo turno pianificato giorno precedente';  Griglia: 'Tr. prec.'),               //05
    (NomeCampo: 'ULTIMA_USCITA';    Etichetta: 'Ultima uscita';                               Griglia: 'Ultima uscita'),           //06
    (NomeCampo: 'CAUSALE_ASS';      Etichetta: 'Causale di assenza';                          Griglia: 'Assenza'),                 //07
    (NomeCampo: 'D_CAUSALE_ASS';    Etichetta: 'Descrizione causale di assenza';              Griglia: 'Descr. assenza'),          //08
    (NomeCampo: 'TIPOGIUST_ASS';    Etichetta: 'Tipo giustificativo';                         Griglia: 'Tipo'),                    //09
    (NomeCampo: 'DURATA_ASS';       Etichetta: 'Durata giustificativo';                       Griglia: 'Durata'),                  //10
    (NomeCampo: 'SQ_PIANIF';        Etichetta: 'Squadra pianificata';                         Griglia: 'Sq. pianif.'),             //11
    (NomeCampo: 'D_SQ_PIANIF';      Etichetta: 'Descr. squadra pianificata';                  Griglia: 'Descr. squadra pianif.'),  //12
    (NomeCampo: 'OP_PIANIF';        Etichetta: 'Operatore pianificato';                       Griglia: 'Op. pianif.'),             //13
    (NomeCampo: 'TR_PIANIF';        Etichetta: 'Turno pianificato';                           Griglia: 'Tr. pianif.'),             //14
    (NomeCampo: 'ETR_PIANIF';       Etichetta: 'Entrata turno pianificato';                   Griglia: 'E. Tr.'),                  //15
    (NomeCampo: 'UTR_PIANIF';       Etichetta: 'Uscita turno pianificato';                    Griglia: 'U. Tr.'),                  //16
    (NomeCampo: 'SG_PIANIF';        Etichetta: 'Sigla turno pianificato';                     Griglia: 'Sg. Tr.'),                 //17
    (NomeCampo: 'N_MIN_PIANIF';     Etichetta: 'Copertura minima';                            Griglia: 'Min.'),                    //18
    (NomeCampo: 'N_DIP_PIANIF';     Etichetta: 'Dipendenti pianificati';                      Griglia: 'Dip.'),                    //19
    (NomeCampo: 'N_MAX_PIANIF';     Etichetta: 'Copertura massima';                           Griglia: 'Max.'),                    //20
    (NomeCampo: 'N_ESUBERO_MIN';    Etichetta: 'Esuberi su copertura minima';                 Griglia: 'Esub. min'),               //21
    (NomeCampo: 'N_ESUBERO_MAX';    Etichetta: 'Esuberi su copertura massima';                Griglia: 'Esub. max'),               //22
    (NomeCampo: 'SQ_DISP';          Etichetta: 'Disponibile per squadre';                     Griglia: 'Disponibile per squadre'), //23
    (NomeCampo: 'DA_DISP';          Etichetta: 'Disponibilità dalle ore';                     Griglia: 'Dalle'),                   //24
    (NomeCampo: 'A_DISP';           Etichetta: 'Disponibilità alle ore';                      Griglia: 'Alle'),                    //25
    (NomeCampo: 'NT_DISP';          Etichetta: 'Note disponibilità';                          Griglia: 'Note disponibilità'),      //26
    (NomeCampo: 'T430SQUADRA';      Etichetta: 'Squadra';                                     Griglia: 'Squadra'),                 //27
    (NomeCampo: 'T430D_SQUADRA';    Etichetta: 'Descr. squadra';                              Griglia: 'Descr. squadra'),          //28
    (NomeCampo: 'T430SQUADRA_ANNI'; Etichetta: 'Anzianità squadra';                           Griglia: 'Anz. Squadra'),            //29
    (NomeCampo: 'T430TIPOOPE';      Etichetta: 'Operatore';                                   Griglia: 'Operatore'),               //30
    (NomeCampo: 'T430TIPOOPE_ANNI'; Etichetta: 'Anzianità operatore';                         Griglia: 'Anz. Operatore')           //31
  );

  COMPETENZA_ASSENZA_CARTELLINO:String     = 'CART';
  COMPETENZA_ASSENZA_ITER:String           = 'ITER';
  COMPETENZA_ASSENZA_PIANIFICAZIONE:String = 'PIAN';

implementation

{$IFNDEF IRISWEB}
uses A058UPianifTurni, A058UGrigliaPianif, SelAnagrafe;
{$ENDIF}

{$R *.DFM}

{begin TListDip}

constructor TListDip.Create(AOwnsObjects: Boolean = True);
begin
  inherited;
  Self.PropElencoAnomalie:=TPropElencoAnomalie.Create;
  Self.PropElencoAnomalie.RegistraAnomalieDB:=False;
end;

destructor TListDip.Destroy;
begin
  FreeAndNil(Self.PropElencoAnomalie);
  inherited;
end;

function TListDip.GetA058Dtm:TDataModule;
begin
  Result:=(Self.Parent as TA058FPianifTurniDtM1);
end;

procedure TListDip.Controllo_TurnoAntincendio(const DataElabDa,DataElabA:TDateTime);
var
  DataScorr:TDateTime;
  i, NTurno:integer;
  NTurniAntincendio:array of integer;
begin
  //Cancello SOLO le anomalie antincendio per il periodo selezionato
  DataScorr:=DataElabDa;
  while DataScorr <= DataElabA do
  begin
    for i:=0 to Self.Count - 1 do
    begin
      Self[i].GetDayByDate(DataScorr).Anomalie.CancellaAnomalie(taAntincendio);
    end;
    DataScorr:=DataScorr + 1;
  end;
  if not Self.PropElencoAnomalie.GetPropAnomalia(taAntincendio).Visible then
  begin
    Exit;
  end;
  //Verifico che all'interno della squadra sia pianificato un solo turno antincendio x turno infermieristico
  DataScorr:=DataElabDa;
  while DataScorr <= DataElabA do
  begin
    SetLength(NTurniAntincendio,0);
    for i:=0 to Self.Count - 1 do
    begin
      //Alberto 22/02/2018: Come mai può capitare che T1 = E/U??? (Capita solo se si chiede il ricalcolo dei turni)
      if not R180In(Self[i].GetDayByDate(DataScorr).T1.Trim,['A','M','','0','E','U']) and
         Self[i].GetDayByDate(DataScorr).Presenza then
      begin
        NTurno:=Self[i].GetDayByDate(DataScorr).T1.Trim.ToInteger;
        if NTurno > High(NTurniAntincendio) then
        begin
          SetLength(NTurniAntincendio,NTurno + 1);
        end;
        if Self[i].GetDayByDate(DataScorr).Antincendio = 'S' then
        begin
          Inc(NTurniAntincendio[NTurno]);
          if NTurniAntincendio[NTurno] > 1 then
          begin
            Self[i].GetDayByDate(DataScorr).Anomalie.AddAnomalia(Format('Data:[%s] è già stato specificato un turno antincendio per questa giornata.',[DataScorr.ToString]), taAntincendio);
          end;
        end;
      end;
    end;
    DataScorr:=DataScorr + 1;
  end;
end;

procedure TListDip.Controllo_Referente(const DataElabDa,DataElabA:TDateTime);
var
  DataScorr:TDateTime;
  i,j,NumTurno:integer;
  NOperatoriTurno: array of Integer; // Numero di operatori attivi nel turno i-esimo
  NTurniReferente:array of Integer;  // Numero di operatori attivi e referenti nel turno i-esimo
  TurniNoReferenti: String;          // Elenco turni senza referenti, come stringhe separate da virgola
  TestoAnomalia:String;
begin
  //Cancello SOLO le anomalie referente per il periodo selezionato
  DataScorr:=DataElabDa;
  while DataScorr <= DataElabA do
  begin
    for i:=0 to Self.Count - 1 do
    begin
      Self[i].GetDayByDate(DataScorr).Anomalie.CancellaAnomalie(taReferente);
    end;
    DataScorr:=DataScorr + 1;
  end;
  if not Self.PropElencoAnomalie.GetPropAnomalia(taReferente).Visible then
  begin
    Exit;
  end;
  // Verifico che per ogni turno in ogni giornata ci sia un solo referente
  DataScorr:=DataElabDa;
  while DataScorr <= DataElabA do
  begin
    SetLength(NOperatoriTurno,0);
    SetLength(NTurniReferente,0);
    TurniNoReferenti:='';
    for i:=0 to Self.Count - 1 do
    begin
      if (not R180In(Self[i].GetDayByDate(DataScorr).T1.Trim,['A','M','','0','E','U'])) and
         (Self[i].GetDayByDate(DataScorr).Presenza) and (Self[i].GetDayByDate(DataScorr).NumTurno1.Trim <> '') then
      begin
        // Se è presente NumTurno è sempre numerico (sul DB è un NUMBER(1))
        NumTurno:=StrToInt(Self[i].GetDayByDate(DataScorr).NumTurno1.Trim);
        if NumTurno > High(NOperatoriTurno) then
        begin
          SetLength(NOperatoriTurno,NumTurno + 1);
          SetLength(NTurniReferente,NumTurno + 1);
        end;
        Inc(NOperatoriTurno[NumTurno]); // Incremento il numero di dipendenti attivi nel turno NTurno
        if Self[i].GetDayByDate(DataScorr).Referente = 'S' then
        begin
          Inc(NTurniReferente[NumTurno]); // Incremento il numero di dipendenti attivi e referenti nel turno NTurno
          if NTurniReferente[NumTurno] > 1 then // Più di un referente specificato
          begin
            Self[i].GetDayByDate(DataScorr).Anomalie.AddAnomalia(Format('Data:[%s] è già stato specificato un referente per questa giornata.',[DataScorr.ToString]), taReferente);
          end;
        end;
      end;
    end;

    // Verifico se è stato specificato almeno un referente per ogni turno "attivo"
    for j:=0 to (Length(NOperatoriTurno) - 1) do
    begin
      if (NOperatoriTurno[j] > 0) and (NTurniReferente[j] = 0) then
      begin
        // Aggiungo il turno come "problematico"
        if Length(TurniNoReferenti) > 0 then
          TurniNoReferenti:=TurniNoReferenti + ', ';
        TurniNoReferenti:=TurniNoReferenti + IntToStr(j);
      end;
    end;
    // Se la stringa dei turni attivi senza referenti è valorizzata, aggiungo un anomalia per il primo dipendente.
    if Length(TurniNoReferenti) > 0 then
    begin
       TestoAnomalia:=Format('Data:[%s] per il/i turno/i [%s] non è stato specificato alcun referente.',
                             [DataScorr.ToString,TurniNoReferenti]);
         Self[0].GetDayByDate(DataScorr).Anomalie.AddAnomalia(TestoAnomalia,taReferente);
    end;

    DataScorr:=DataScorr + 1;
  end;
end;

function TListDip.CopyListaDipendenti:TListDip;
var
  i:integer;
begin
  Result:=TListDip.Create;
  Result.Parent:=Self.Parent;
  for i:=0 to Self.Count - 1 do
  begin
    Result.Add(Self[i].CopyDipendente);
  end;
end;

procedure TListDip.CancellaAnomalieVista(const inTipoAnomalia:TTipiAnomalie);
var
  i:integer;
begin
  for i:=0 to Self.Count - 1 do
  begin
    Self[i].CancellaAnomalieDipendente(inTipoAnomalia);
  end;
end;

procedure TListDip.ClearAnomalie;
var
  i:integer;
begin
  for i:=0 to Self.Count - 1 do
  begin
    Self[i].ClearAnomalie;
  end;
end;

procedure TListDip.ResetModifica;
var
  i,k:integer;
begin
  for i:=0 to Self.Count - 1 do
  begin
    for k:=0 to Self[i].Giorni.Count - 1 do
    begin
      Self[i].Giorni[k].pModificato:=False;
    end;
    Self[i].pModificato:=False;
  end;
  Self.pModificato:=False;
end;

procedure TListDip.SetModificato(Val:Boolean);
var
  i:integer;
  VistaModificato:Boolean;
begin
  if val then
  begin
    // Se un figlio (Dipendente) è stato modificato, sicuramente lo è anche le vista
    Self.pModificato:=True;
  end
  else
  begin
    // Un Dipendente è stato modificato, per sapere se non siamo più in stato Modificato verifichiamo che tutti i
    // nostri figli non siano Modificati.
    VistaModificato:=False;
    for i:=0 to Self.Count - 1 do
    begin
      if Self[i].Modificato then
      begin
        VistaModificato:=True;
        Break;
      end;
    end;
    if not VistaModificato then
    begin
      // Non ci sono modifiche pendenti nei nostri figli. L'intera vistà non ha modifiche pendenti.
      Self.pModificato:=False;
    end;
  end;
end;

{end TListDip}

{end TDipendente}

constructor TDipendente.Create;
begin
  Self.Giorni:=TObjectList<TGiorno>.Create(True);
  Self.GiorniOld:=TObjectList<TGiorno>.Create(True);
end;

destructor TDipendente.Destroy;
begin
  FreeAndNil(Self.Giorni);
  FreeAndNil(Self.GiorniOld);
end;

procedure TDipendente.setModificato(val:Boolean);
var
  i:integer;
  DipModificato:Boolean;
begin
  if val then
  begin
    // Se un figlio è stato modificato, sicuramente lo è anche il Dipendente e la ListaDipendenti
    Self.pModificato:=True;
    (Self.ParentListDip as TListDip).Modificato:=True;
  end
  else
  begin
    // Un figlio è stato modificato, per sapere se non siamo più in stato Modificato verifichiamo che tutti i
    // nostri figli non siano Modificati.
    DipModificato:=False;
    for i:=0 to Self.Giorni.Count - 1 do
    begin
      if Self.Giorni[i].Modificato then
      begin
        DipModificato:=True;
        Break;
      end;
    end;
    if not DipModificato then
    begin
      // Non ci sono modifiche pendenti nei nostri figli. Questo dipendente non è modificato.
      Self.pModificato:=False;
      // Segnaliamo alla ListaDipendenti che è stata abortita una modifica. Verrà effettutato un ulteriore controllo
      // dalla ListaDipendenti.
      (Self.ParentListDip as TListDip).Modificato:=False;
    end;
  end;
end;

function TDipendente.GetPropElencoAnomalie:TPropElencoAnomalie;
begin
  Result:=(Self.ParentListDip as TListDip).PropElencoAnomalie;
end;

function TDipendente.GetA058Dtm:TDataModule;
begin
  Result:=(Self.ParentListDip as TListDip).GetA058Dtm;
end;

function TDipendente.GetDayByDate(const Day:TDateTime):TGiorno;
begin
  Result:=Self.Giorni[Trunc(Day - Self.Giorni[0].Data)];
end;

function TDipendente.CopyDipendente;
var
  i:integer;
begin
  Result:=TDipendente.create;
  Result.ParentListDip:=Self.ParentListDip;
  Result.Prog:=Self.Prog;
  Result.Badge:=Self.Badge;
  Result.TurnoPartenza:=Self.TurnoPartenza;
  Result.Debito:=Self.Debito;
  Result.Assegnato:=Self.Assegnato;
  Result.RiposiPrec:=Self.RiposiPrec;
  Result.FestiviLavMeseCorr:=Self.FestiviLavMeseCorr;
  Result.FestiviLavMesePrec:=Self.FestiviLavMesePrec;
  Result.FestiviLavAnnoPrec:=Self.FestiviLavAnnoPrec;
  Result.CompRip:=Self.CompRip;
  Result.Cognome:=Self.Cognome;
  Result.Nome:=Self.Nome;
  Result.Squadra:=Self.Squadra;
  Result.TipoOpe:=Self.TipoOpe;
  Result.CausRip:=Self.CausRip;
  Result.Matricola:=Self.Matricola;
  Result.TotDip:=Self.TotDip;
  for i:=0 to Self.Giorni.Count - 1 do
  begin
    Result.Giorni.Add(Self.Giorni[i].CopyGiorno);
    Result.GiorniOld.Add(Self.GiorniOld[i].CopyGiorno);
  end;
end;

procedure TDipendente.CancellaAnomalieDipendente(const inTipoAnomalia:TTipiAnomalie);
var
  i:integer;
begin
  for i:=0 to Self.Giorni.Count - 1 do
  begin
    Self.Giorni[i].Anomalie.CancellaAnomalie(inTipoAnomalia);
  end;
end;

procedure TDipendente.ClearAnomalie;
var
  i:integer;
begin
  for i:=0 to Self.Giorni.Count - 1 do
  begin
    Self.Giorni[i].ClearAnomalie;
  end;
end;

procedure TDipendente.TestPNTurniInfTurniRep(const IndGG, EntrataInf, UscitaInf:integer);
var
  i, EntrataRep, UscitaRep:integer;
  MsgAnomalia:string;
begin
  if IndGG <= 0 then
  begin
    Exit;
  end;

  //Giorno prima
  for i:=low(Self.Giorni[IndGG - 1].TurniRep) to High(Self.Giorni[IndGG - 1].TurniRep) do
  begin
    //Verifico che il turno di riperibilità sia pianificato
    if (not Self.Giorni[IndGG - 1].TurniRep[i].Turno.Trim.IsEmpty) then
    begin
      //Valorizzo punti nominali della reperibilità
      EntrataRep:=R180OreMinuti(Self.Giorni[IndGG-1].TurniRep[i].OraInizio);
      UscitaRep:=R180OreMinuti(Self.Giorni[IndGG-1].TurniRep[i].OraFine);
      if EntrataRep >= UscitaRep then
      begin
        EntrataRep:=0;
        if (EntrataInf < UscitaRep) and (UscitaInf > EntrataRep) then
        begin
          MsgAnomalia:=Format('Data:[%s] il turno di servizio[%s - %s] interseca il turno di reperibilità[%s - %s].',
                              [Self.Giorni[IndGG].Data.ToString,
                               R180MinutiOre(EntrataInf),
                               R180MinutiOre(UscitaInf),
                               Self.Giorni[IndGG-1].TurniRep[i].OraInizio,
                               Self.Giorni[IndGG-1].TurniRep[i].OraFine]);
          Self.Giorni[Indgg].Anomalie.AddAnomalia(MsgAnomalia,taIntersezReperibilita);
        end;
      end;
    end;
  end;

  //Ciclo sui turni di reperibilità [1..3]
  for i:=low(Self.Giorni[IndGG].TurniRep) to High(Self.Giorni[IndGG].TurniRep) do
  begin
    //Verifico che il turno di riperibilità sia pianificato
    if (not Self.Giorni[IndGG].TurniRep[i].Turno.Trim.IsEmpty) then
    begin
      //Valorizzo punti nominali della reperibilità
      EntrataRep:=R180OreMinuti(Self.Giorni[IndGG].TurniRep[i].OraInizio);
      UscitaRep:=R180OreMinuti(Self.Giorni[IndGG].TurniRep[i].OraFine);
      if EntrataRep >= UscitaRep then
      begin
        UscitaRep:=1440;
      end;
      if (EntrataInf < UscitaRep) and (UscitaInf > EntrataRep) then
      begin
        MsgAnomalia:=Format('Data:[%s] il turno di servizio[%s - %s] interseca il turno di reperibilità[%s - %s].',
                            [Self.Giorni[IndGG].Data.ToString,
                             R180MinutiOre(EntrataInf),
                             R180MinutiOre(UscitaInf),
                             Self.Giorni[IndGG].TurniRep[i].OraInizio,
                             Self.Giorni[IndGG].TurniRep[i].OraFine]);
        Self.Giorni[Indgg].Anomalie.AddAnomalia(MsgAnomalia,taIntersezReperibilita);
      end;
    end;
  end;
end;

function TDipendente.GetConteggiSingoliGiorniAggiornati:Boolean;
var
  i:Integer;
begin
  Result:=True;
  for i:=0 to (Giorni.Count - 1) do
  begin
    if not Giorni[i].ConteggiAggiornati then
    begin
      Result:=False;
      Break;
    end;
  end;
end;

procedure TDipendente.Controllo_IntersezioneReperibilita(const DataElabDa,DataElabA:TDateTime);
var
  IndScorr:integer;
  DataScorr:TDateTime;
  EntrataPN, UscitaPN:integer;
begin
  //Cancello SOLO le anomalie relative alle intersezioni con i turni di reperibilità
  Self.CancellaAnomalieDipendente(taIntersezReperibilita);
  if not Self.GetPropElencoAnomalie.GetPropAnomalia(taIntersezReperibilita).Visible then
  begin
    Exit;
  end;
  DataScorr:=DataElabDa;
  while DataScorr <= DataElabA do
  begin
    IndScorr:=Trunc(DataScorr - Self.Giorni[0].Data);
    //Test turno 1
    if (not Self.Giorni[IndScorr].NumTurno1.Trim.isEmpty) then
    begin
      //Valorizzo punti nominali del turno infermieristico
      EntrataPN:=Self.Giorni[IndScorr].pMinutiEntrata1;
      UscitaPN:=IfThen(Self.Giorni[IndScorr].pMinutiUscita1 = 0,1440,Self.Giorni[IndScorr].pMinutiUscita1);
      //Uscita(dichiarata) turno a cavallo di mezzanotte
      if (Self.Giorni[IndScorr].pMinutiEntrata1 >= Self.Giorni[IndScorr].pMinutiUscita1) then
      begin
        if (Self.Giorni[IndScorr].T1EU.Trim.IsEmpty) or (Self.Giorni[IndScorr].T1EU.Trim = 'U') then
        begin
          EntrataPN:=0;
          if Self.Giorni[IndScorr].T1EU.Trim.IsEmpty then
          begin
            Self.TestPNTurniInfTurniRep(IndScorr,EntrataPN,UscitaPN);
            EntrataPN:=Self.Giorni[IndScorr].pMinutiEntrata1;
          end;
        end;      //Entrata(dichirate a non) turno a cavallo di mezzanotte
        if (Self.Giorni[IndScorr].T1EU.Trim.IsEmpty) or (Self.Giorni[IndScorr].T1EU.Trim = 'E') then
        begin
          UscitaPN:=1440;
        end;
      end;
      //Verifica intersezione turno Infermiristico - turno di reperibilità
      Self.TestPNTurniInfTurniRep(IndScorr, EntrataPN,UscitaPN);
    end;

    //Test turno 2
    if (not Self.Giorni[IndScorr].NumTurno2.Trim.isEmpty) then
    begin
      //Valorizzo punti nominali del turno infermieristico
      EntrataPN:=Self.Giorni[IndScorr].pMinutiEntrata2;
      UscitaPN:=IfThen(Self.Giorni[IndScorr].pMinutiUscita2 = 0,1440,Self.Giorni[IndScorr].pMinutiUscita2);
      //Uscita(dichiarata) turno a cavallo di mezzanotte
      if (Self.Giorni[IndScorr].pMinutiEntrata2 >= Self.Giorni[IndScorr].pMinutiUscita2) then
      begin
        if (Self.Giorni[IndScorr].T2EU.Trim.IsEmpty) or (Self.Giorni[IndScorr].T2EU.Trim = 'U') then
        begin
          EntrataPN:=0;
          if Self.Giorni[IndScorr].T2EU.Trim.IsEmpty then
          begin
            Self.TestPNTurniInfTurniRep(IndScorr,EntrataPN,UscitaPN);
            EntrataPN:=Self.Giorni[IndScorr].pMinutiEntrata2;
          end;
        end;      //Entrata(dichirate a non) turno a cavallo di mezzanotte
        if (Self.Giorni[IndScorr].T2EU.Trim.IsEmpty) or (Self.Giorni[IndScorr].T2EU.Trim = 'E') then
        begin
          UscitaPN:=1440;
        end;
      end;
      //Verifica intersezione turno Infermiristico - turno di reperibilità
      Self.TestPNTurniInfTurniRep(IndScorr, EntrataPN,UscitaPN);
    end;
    DataScorr:=DataScorr + 1;
  end;
end;

procedure TDipendente.Controllo_IntegritaTurniNotturni(const DataElabDa,DataElabA:TDateTime);
var
  DataScorr:TDateTime;
  MsgAnomalia:string;

  function EsisteUscita(GG:TDateTime):Boolean;
  begin
    Result:=(Self.GetDayByDate(GG).T1EU.Trim = 'U') or (Self.GetDayByDate(GG).T2EU.Trim = 'U');
  end;

  function EsisteEntrata(GG:TDateTime):Boolean;
  begin
    Result:=(Self.GetDayByDate(GG).T1EU.Trim = 'E') or (Self.GetDayByDate(GG).T2EU.Trim = 'E');
  end;

  function TEUSpecificato(GG:TDateTime):Boolean;
  begin
    Result:=EsisteEntrata(GG) or EsisteUscita(GG);
  end;

  function TurnoNotturno(GG:TDateTime):Boolean;
  begin
    Result:=Self.GetDayByDate(GG).TurnoNotturnoT1 or Self.GetDayByDate(GG).TurnoNotturnoT2;
  end;

begin
  //Cancello SOLO le anomalie relative all'integrità dei turni notturni
  Self.CancellaAnomalieDipendente(taIntegritaTNotturni);
  if not GetPropElencoAnomalie.GetPropAnomalia(taIntegritaTNotturni).Visible then
  begin
    Exit;
  end;
  //Controllo turni notturni
  DataScorr:=DataElabDa;
  while DataScorr <= DataElabA do
  begin
    //Controllo turni sullo stesso giorno
    if Self.GetDayByDate(DataScorr).TurnoNotturnoT1 and
       Self.GetDayByDate(DataScorr).TurnoNotturnoT2 and
       Self.GetDayByDate(DataScorr).Presenza(True) then
    begin
      if not TEUSpecificato(DataScorr) then
      begin
        MsgAnomalia:=Format('Data:[%s] due turni notturni interi nello stesso giorno.',[DataScorr.ToString]);
        Self.GetDayByDate(DataScorr).Anomalie.AddAnomalia(MsgAnomalia,taIntegritaTNotturni);
      end;
      if (Self.GetDayByDate(DataScorr).T1EU.Trim = 'E') and (Self.GetDayByDate(DataScorr).T2EU.Trim = 'E') then
      begin
        MsgAnomalia:=Format('Data:[%s] due turni notturni in entrata.',[DataScorr.ToString]);
        Self.GetDayByDate(DataScorr).Anomalie.AddAnomalia(MsgAnomalia,taIntegritaTNotturni);
      end;
      if (Self.GetDayByDate(DataScorr).T1EU.Trim = 'U') and (Self.GetDayByDate(DataScorr).T2EU.Trim = 'U') then
      begin
        MsgAnomalia:=Format('Data:[%s] due turni notturni in uscita.',[DataScorr.ToString]);
        Self.GetDayByDate(DataScorr).Anomalie.AddAnomalia(MsgAnomalia,taIntegritaTNotturni);
      end;
    end;
    if TurnoNotturno(DataScorr) and
       Self.GetDayByDate(DataScorr).Presenza(True) then
    begin
      //Controllo turni se esiste entrata nel giorno successivo
      if DataScorr > Self.Giorni[0].Data then
      begin
        if (EsisteUscita(DataScorr) {Se viene specificata un'uscita} or not TEUSpecificato(DataScorr) {E\U non specificate}) then
        begin
          if False(*(not Self.GetDayByDate(DataScorr - 1).Presenza(True))*) or
             (not TurnoNotturno(DataScorr - 1) or
             (not EsisteEntrata(DataScorr - 1) {Entrata gg prec non specificata} and TEUSpecificato(DataScorr - 1) {U gg prec specificata})) then
          begin
            MsgAnomalia:=Format('Data:[%s] nessun turno notturno in entrata specificato nel giorno precedente.',[DataScorr.ToString]);
            Self.GetDayByDate(DataScorr).Anomalie.AddAnomalia(MsgAnomalia,taIntegritaTNotturni);
          end;
        end;
      end;
      //Controllo turni se esiste uscita nel giorno successivo
      if DataScorr < Self.Giorni[Self.Giorni.Count - 1].Data then
      begin
        if (EsisteEntrata(DataScorr) {Se viene specificata l'entrata} or not TEUSpecificato(DataScorr) {E\U non specificate}) then
        begin
          if False(*(not Self.GetDayByDate(DataScorr + 1).Presenza(True))*) or
             (not TurnoNotturno(DataScorr + 1) or
             (not EsisteUscita(DataScorr + 1) {Uscita gg Succ non specificata} and TEUSpecificato(DataScorr + 1) {E gg succ specificata})) then
          begin
            MsgAnomalia:=Format('Data:[%s] nessun turno notturno in uscita specificato nel giorno successivo.',[DataScorr.ToString]);
            Self.GetDayByDate(DataScorr).Anomalie.AddAnomalia(MsgAnomalia,taIntegritaTNotturni);
          end;
        end;
      end;
    end;
    DataScorr:=DataScorr + 1;
  end;
end;

procedure TDipendente.Controllo_35Ore(const DataElabDa,DataElabA:TDateTime);
const
  GG_PERIODO=14;
  HH_RIPOSO=35*60;
var
  DataScorr, DataInizio14gg:TDateTime;
  IndScorr, Count14gg, Count35HH, NumGG:integer;
  MsgAnomalia:string;

  function TrovaPrimoGiornoInServizio(D:TDatetime):TDateTime;
  var i: Integer;
  begin
    Result:=D;
    while Result <= DataElabA do
    begin
        i:=Trunc(Result - Self.Giorni[0].Data);
        if (Self.Giorni[i].Flag.Trim.ToUpper <> 'NT') and
           (Self.Giorni[i].T1.Trim <> 'M') and
           (Self.Giorni[i].T2.Trim <> 'M') and
           ((Not Self.Giorni[i].NumTurno1.Trim.IsEmpty) or (Not Self.Giorni[i].NumTurno2.Trim.IsEmpty)) and
           (Self.Giorni[i].Presenza) then
         Break;
      Result:=Result + 1;
    end;
  end;

begin
  //Cancello SOLO le anomalie relative alle 35 Ore
  Self.CancellaAnomalieDipendente(ta35Ore);
  if not Self.GetPropElencoAnomalie.GetPropAnomalia(ta35Ore).Visible then
  begin
    Exit;
  end;
  DataInizio14gg:=TrovaPrimoGiornoInServizio(DataElabDa);
  while DataInizio14gg + GG_PERIODO - 1 <= DataElabA do
  begin
    Count35HH:=0;
    Count14gg:=0;
    NumGG:=1;
    DataScorr:=DataInizio14gg;
    while DataScorr <= DataInizio14gg + GG_PERIODO - 1 do//DataElabA do
    begin
      IndScorr:=Trunc(DataScorr - Self.Giorni[0].Data);
      if (Self.Giorni[IndScorr].Flag.Trim.ToUpper <> 'NT') and
         (Self.Giorni[IndScorr].T1.Trim <> 'M') and
         (Self.Giorni[IndScorr].T2.Trim <> 'M') then
      begin
        if ((Not Self.Giorni[IndScorr].NumTurno1.Trim.IsEmpty) or (Not Self.Giorni[IndScorr].NumTurno2.Trim.IsEmpty)) and
           (Self.Giorni[IndScorr].Presenza) then
        begin
          //Spezzone dalla mezzanotte fino all'entrata
          Count35HH:=Count35HH + Self.Giorni[IndScorr].GetPrimaEntrata;
          //Se il conteggio delle è maggiore di 0(già iniziato), ma non soddisfa le 35hh
          //azzero il contatore
          if Count35HH > 0 then
          begin
            if Count35HH >= HH_RIPOSO then
            begin
              Inc(Count14gg);
              //Se assenza lunga quanto metà del periodo, non si dà anomalia e si passa al periodo successivo
              if Count35HH >= (GG_PERIODO div 2) * 1440 then
              begin
                Break;
              end;
            end;
            Count35HH:=0;
          end;
          //Spezzone dall'uscita fino a mezzanotte
          Count35HH:=Count35HH + max(0,1440 - Self.Giorni[IndScorr].GetUltimaUscita);
        end
        else
        begin
          //Giornata intera non lavorata sommo 24hh
          Count35HH:=Count35HH + 1440;
        end;
        if NumGG >= GG_PERIODO then
        begin
          NumGG:=0;
          //Trovato lo stacco di 35 ore
          if Count35HH >= HH_RIPOSO then
          begin
            Inc(Count14gg);
            //Se assenza lunga quanto metà del periodo, non si dà anomalia e si passa al periodo successivo
            if Count35HH >= (GG_PERIODO div 2)*1440 then
            begin
              Break;
            end;
          end;
          if Count14GG < 2 then
          begin
            MsgAnomalia:=Format('Data:[%s - %s] Non sono stati raggiunti i due stacchi di 35 ore all''interno dei 14 giorni.',
                                [DataInizio14gg.toString,
                                 Self.Giorni[IndScorr].Data.ToString]);
            Self.Giorni[IndScorr].Anomalie.AddAnomalia(MsgAnomalia,ta35Ore);
            //RegistraMsg.InserisciMessaggio('A', MsgAnomalia, Parametri.Azienda, Self.Prog);
          end;
        end;
        inc(NumGG);
      end;
      DataScorr:=DataScorr + 1;
    end;

    if Count14GG < 2 then
    begin
      DataInizio14gg:=DataInizio14gg + GG_PERIODO
    end
    else if Count14GG >= 2 then
    begin
      DataInizio14gg:=DataInizio14gg + 1;
    end;
    DataInizio14gg:=TrovaPrimoGiornoInServizio(DataInizio14gg);
  end;
end;

procedure TDipendente.Controllo_11ore(const DataElabDa,DataElabA:TDateTime);
var
  IndScorr, StaccoOre:integer;
  MsgAnomalia:string;
  DataScorr:TDateTime;
  EntrataPN, UscitaPN:integer;
begin
  //Cancello SOLO le anomalie relative alle 11 Ore
  Self.CancellaAnomalieDipendente(ta11Ore);
  if not Self.GetPropElencoAnomalie.GetPropAnomalia(ta11Ore).Visible then
  begin
    Exit;
  end;
  DataScorr:=DataElabDa;
  while DataScorr <= DataElabA do
  begin
    IndScorr:=Trunc(DataScorr - Self.Giorni[0].Data);
    //Se è specificato il turno 1
    if ((not Self.Giorni[IndScorr].NumTurno1.Trim.IsEmpty) or (not Self.Giorni[IndScorr].NumTurno2.Trim.IsEmpty)) and
       (Self.Giorni[IndScorr].Presenza) then
    begin
      //Controllo turni T1 e T2 nello stesso giorno
      StaccoOre:=-1;
      EntrataPN:=Self.Giorni[IndScorr].GetUltimaEntrata;
      UScitaPN:=Self.Giorni[IndScorr].GetPrimaUscita;
      if (EntrataPN >= 0) and (UscitaPN >= 0) then
      begin
        StaccoOre:=EntrataPN - UscitaPN;
      end;
      if R180Between(StaccoOre,0,659) then
      begin
        MsgAnomalia:=Format('Data:[%s] Intervallo ore minore delle 11 previste:[%s] [U:%s - E:%s]',
                                                          [Self.Giorni[IndScorr].Data.ToString,
                                                           R180MinutiOre(StaccoOre),
                                                           R180MinutiOre(UscitaPN),
                                                           R180MinutiOre(EntrataPN)]);
        Self.Giorni[IndScorr].Anomalie.AddAnomalia(MsgAnomalia,ta11Ore);
        //RegistraMsg.InserisciMessaggio('A',MsgAnomalia,Parametri.Azienda, Self.Prog);
      end;
      //Evito il controllo sull'ultimo giorno del periodo per evitare di coninvolgere
      //il periodo successivo del quale non c'è l'elaborazione
      if (IndScorr < self.Giorni.Count - 1) and (Self.Giorni[IndScorr + 1].Presenza) and
         //Verifico che almeno un turno del giorno successivo sia valorizzato
         ((not Self.Giorni[IndScorr + 1].NumTurno1.Trim.IsEmpty) or (not Self.Giorni[IndScorr + 1].NumTurno2.Trim.IsEmpty)) then
      begin
        //Controllo turni tra giorno e giorno successivo
        StaccoOre:=1440 - Self.Giorni[IndScorr].GetUltimaUscita;
        //Se StaccoOre < 0 vuol dire che l'ultima uscita finisce nel giorno successivo e i controlli li farò direttamente nel giorno successivo
        if StaccoOre >= 0 then
        begin
          StaccoOre:=StaccoOre + Self.Giorni[IndScorr + 1].GetPrimaEntrata;
          if R180Between(StaccoOre,0,659) then
          begin
            MsgAnomalia:=Format('Date:[%s - %s] Intervallo ore minore delle 11 previste:[%s] [U:%s - E:%s]',
                                [Self.Giorni[IndScorr].Data.ToString,
                                 Self.Giorni[IndScorr + 1].Data.ToString,
                                 R180MinutiOre(StaccoOre),
                                 R180MinutiOre(Self.Giorni[IndScorr].GetUltimaUscita),
                                 R180MinutiOre(Self.Giorni[IndScorr + 1].GetPrimaEntrata)]);
            Self.Giorni[IndScorr].Anomalie.AddAnomalia(MsgAnomalia,ta11Ore);
          end;
        end;
      end;
    end;
    DataScorr:=DataScorr + 1;
  end;
end;

procedure TDipendente.Controllo_MinFestivitaMese(const DataElabDa,DataElabA:TDateTime);
var
  DataScorr:TDateTime;
  GiornoRiposo,GiornoFestivo:Boolean;
  Giorno:TGiorno;
  IndScorr,IndPrimoGiornoFestivo,NumGiorniFestiviMese:Integer;
  MsgAnomalia:String;
begin
  Self.CancellaAnomalieDipendente(taMinFestivitaMese);
  if not Self.GetPropElencoAnomalie.GetPropAnomalia(taMinFestivitaMese).Visible then
  begin
    Exit;
  end;
  if Self.ConstMinFestMese <= 0 then
    Exit;
  // TODO: controllo se l'intervallo è un mese
  DataScorr:=DataElabDa;
  NumGiorniFestiviMese:=0;
  IndPrimoGiornoFestivo:=-1;
  while DataScorr <= DataElabA do
  begin
    IndScorr:=Trunc(DataScorr - Self.Giorni[0].Data);
    Giorno:=Self.Giorni[IndScorr];
    GiornoFestivo:=False;
    // E' un giorno di riposo?
    GiornoRiposo:=(
                   (Giorno.RiposoAss1) or // Assenza 1
                   (Giorno.RiposoAss2) or // Assenza 2
                   ((Giorno.NumTurno1.Trim = '') and (Giorno.T1.Trim = '0')) or // Turno 1 di riposo
                   ((Giorno.NumTurno2.Trim = '') and (Giorno.T2.Trim = '0'))    // Turno 2 di riposo
                  )
                  and
                  ((Giorno.T1EU <> 'U') and (Giorno.T2EU <> 'U')); // Nessuno dei due turni è uno smonto notte
    // E' un giorno festivo?
    GiornoFestivo:=Giorno.GGFestivo or (DayOfWeek(Giorno.Data) = 1);
    if (GiornoRiposo and GiornoFestivo) then
      Inc(NumGiorniFestiviMese);
    // Salvo l'indice del primo giorno festivo incontrato
    if (GiornoFestivo) and (IndPrimoGiornoFestivo = -1) then
      IndPrimoGiornoFestivo:=IndScorr;
    DataScorr:=DataScorr + 1;
  end;

  // Controllo: se il numero di riposi in giorni festivi è minore del valore minimo scatta l'anomalia
  if (NumGiorniFestiviMese < Self.ConstMinFestMese) then
  begin
   MsgAnomalia:=Format('Date:[%s - %s] Numero di giorni di riposo festivi inferiore al limite minimo: impostati [%d] - limite [%d]',
                       [DataElabDa.ToString,
                        DataElabA.ToString,
                        NumGiorniFestiviMese,
                        Self.ConstMinFestMese
                       ]);
   Self.Giorni[IndPrimoGiornoFestivo].Anomalie.AddAnomalia(MsgAnomalia,taMinFestivitaMese);
  end;
end;

procedure TDipendente.Controllo_MaxNottiMese(const DataElabDa,DataElabA:TDateTime);
var
  DataScorr:TDateTime;
  GiornoConTurnoNotte:Boolean;
  Giorno:TGiorno;
  IndScorr,NumTurniNotteMese:Integer;
  MsgAnomalia:String;
begin
  Self.CancellaAnomalieDipendente(taMaxNottiMese);
  if not Self.GetPropElencoAnomalie.GetPropAnomalia(taMaxNottiMese).Visible then
  begin
    Exit;
  end;
  if Self.ConstMaxNottiMese <= 0 then
    Exit;
  // TODO: controllo se l'intervallo è un mese
  DataScorr:=DataElabDa;
  NumTurniNotteMese:=0;
  while DataScorr <= DataElabA do
  begin
    IndScorr:=Trunc(DataScorr - Self.Giorni[0].Data);
    Giorno:=Self.Giorni[IndScorr];
    GiornoConTurnoNotte:=(
                          ((Giorno.TurnoNotturnoT1) and (Giorno.T1EU.Trim <> 'U')) or // Turno 1 notturno
                          ((Giorno.TurnoNotturnoT2) and (Giorno.T2EU.Trim <> 'U'))    // Turno 2 notturno
                         )
                         and
                         (Giorno.Presenza(True)); // Il dipendente è presente
    if GiornoConTurnoNotte then
    begin
      //Se questo giorno ha un turno notturno incremento il contatore.
      Inc(NumTurniNotteMese);
      // Inoltre se siamo anche oltre limite scatta l'anomalia.
      if NumTurniNotteMese > Self.ConstMaxNottiMese then
      begin
        MsgAnomalia:=Format('Date:[%s - %s] Numero di turni notturni superiore al limite massimo: impostati [%d] - limite [%d]',
                     [DataElabDa.ToString,
                      DataElabA.ToString,
                      NumTurniNotteMese,
                      Self.ConstMaxNottiMese
                     ]);
        Self.Giorni[IndScorr].Anomalie.AddAnomalia(MsgAnomalia,taMaxNottiMese);
      end;
    end;
    DataScorr:=DataScorr + 1;
  end;
end;

{end TDipendente}

{begin TTipoAnomalia}

function TTipiAnomalieHelper.ToString;
begin
  case Self of
    ta11Ore: Result:='11 ore';
    ta35Ore: Result:='35 ore';
    taIntersezReperibilita: Result:='Intersezioni con turni di reperibilità';
    taIntegritaTNotturni: Result:='Integrità turni notturni';
    taAntincendio: Result:='Antincendio';
    taMinFestivitaMese: Result:='Festività mensili minime';
    taMaxNottiMese: Result:='Numero massimo di turni notturni mensili';
    taReferente: Result:='Referente turno';
  else
    Result:='errore';
  end;
end;

{end TTipoAnomalia}

{begin TProElencoAnomalie}

constructor TPropElencoAnomalie.Create(AOwnsObjects: Boolean = True);
var
  i:TTipiAnomalie;
  MyAnomalia:TPropAnomalia;
begin
  inherited;
  for i:=TTipiAnomalie.ta11Ore to  TTipiAnomalie.taReferente do
  begin
    MyAnomalia:=TPropAnomalia.Create;
    MyAnomalia.NomeAnomalia:=i;
    MyAnomalia.Visible:=True;
    Self.Add(MyAnomalia);
  end;
end;

function TPropElencoAnomalie.GetPropAnomalia(const ValueAnomalia:TTipiAnomalie):TPropAnomalia;
var
  i:integer;
begin
  Result:=nil;
  i:=0;
  while (i <= Self.Count - 1) and (Self[i].NomeAnomalia <> ValueAnomalia) do
  begin
    inc(i);
  end;
  Result:=Self[i];
end;

function TPropElencoAnomalie.GetPropAnomalia(const ValueAnomalia:string):TPropAnomalia;
var
  i:integer;
begin
  Result:=nil;
  i:=0;
  while (i <= Self.Count - 1) and (Self[i].NomeAnomalia.toString <> ValueAnomalia) do
  begin
    inc(i);
  end;
  Result:=Self[i];
end;

function TPropElencoAnomalie.GetAnomalieAttive:string;
var
  i:integer;
begin
  Result:='';
  for i:=0 to Self.Count - 1 do
  begin
    if Self[i].Visible then
    begin
      if not Result.IsEmpty then
      begin
        Result:=Result + ',';
      end;
      Result:=Result + Self[i].NomeAnomalia.toString;
    end;
  end;
end;

procedure TPropElencoAnomalie.SetAnomalieAttive(const ValueAnomalie:string);
var
  i:integer;
  MyValueAnomalie:string;
begin
  MyValueAnomalie:=',' + ValueAnomalie.Trim + ',';
  for i:=0 to Self.Count - 1 do
  begin
    Self[i].Visible:=MyValueAnomalie.IndexOf(Self[i].NomeAnomalia.toString) > 0;
  end;
end;

{endTProElencoAnomalie}

{begin TAnomalia}

function TAnomalia.CopyAnomalia:TAnomalia;
begin
  Result:=TAnomalia.Create;
  Result.Testo:=Self.Testo;
  Result.TipoAnomalia:=Self.TipoAnomalia;
end;

{end TAnomalia}

{begin TListaAnomalie}

procedure TListaAnomalie.CancellaAnomalie(const inTipoAnomalia:TTipiAnomalie);
var
  i:integer;
begin
  for i:=Self.Count - 1 downto 0 do
  begin
    if Self[i].TipoAnomalia = inTipoAnomalia then
    begin
      Self.Delete(i);
    end;
  end;
end;

procedure TListaAnomalie.AddAnomalia(const TestoAnomalia:string; const inTipoAnomalia:TTipiAnomalie);
var
  MyAnomalia:TAnomalia;
begin
  MyAnomalia:=TAnomalia.Create;
  MyAnomalia.Testo:=TestoAnomalia;
  MyAnomalia.TipoAnomalia:=inTipoAnomalia;
  Self.Add(MyAnomalia);
  if Self.GetPropElencoAnomalie.RegistraAnomalieDB then
  begin
    RegistraMsg.InserisciMessaggio('A', TestoAnomalia, Parametri.Azienda, Self.Progressivo);
  end;
end;

function TListaAnomalie.GetPropElencoAnomalie:TPropElencoAnomalie;
begin

  Result:=(Self.ParentGiorno as TGiorno).GetPropElencoAnomalie;
end;

function TListaAnomalie.TextAnomalie:string;
var
  i:integer;
begin
  Result:='';
  for i:=0 to Self.Count - 1 do
  begin
    if i > 0 then
    begin
      Result:=Result + #13#10;
    end;
    Result:=Result + Self[i].Testo;
  end;
end;

{end TListaAnomalie}

{begin TGiorno}

function TGiorno.TurnoNotturnoT1:Boolean;
var
  EntrataPN, UscitaPN:integer;
begin
  Result:=False;
  if not Self.T1.IsEmpty then
  begin
    EntrataPN:=Self.pMinutiEntrata1;
    UscitaPN:=Self.GetMinutiUscita1;
    Result:=UscitaPN < EntrataPN;
  end;
end;

function TGiorno.TurnoNotturnoT2:Boolean;
var
  EntrataPN, UscitaPN:integer;
begin
  Result:=False;
  if not Self.T2.IsEmpty then
  begin
    EntrataPN:=Self.pMinutiEntrata2;
    UscitaPN:=Self.GetMinutiUscita2;
    Result:=UscitaPN < EntrataPN;
  end;
end;

function TGiorno.RiposoAss1:Boolean;
begin
  Result:=(Self.GetA058Dtm as TA058FPianifTurniDtM1).TestRiposo(Self.Ass1.Trim);
end;

function TGiorno.RiposoAss2:Boolean;
begin
  Result:=(Self.GetA058Dtm as TA058FPianifTurniDtM1).TestRiposo(Self.Ass2.Trim);
end;

function TGiorno.GetA058Dtm:TDataModule;
begin
  Result:=(Self.ParentDipendente as TDipendente).GetA058Dtm;
end;

function TGiorno.GetPropElencoAnomalie:TPropElencoAnomalie;
begin
  Result:=(Self.ParentDipendente as TDipendente).GetPropElencoAnomalie;
end;

function TGiorno.Presenza(const ValutaRiposo:Boolean = False):Boolean;
begin
  Result:=(Self.Ass1.Trim.IsEmpty or (Self.RiposoAss1 and ValutaRiposo))
          and
          (Self.Ass2.Trim.IsEmpty or (Self.RiposoAss2 and ValutaRiposo));
end;

function TGiorno.GetPrimaEntrata:integer;
begin
  Result:=0;
  if Self.T1.Trim = 'R' then
  begin
    Exit;
  end;
  if Not Self.NumTurno1.Trim.IsEmpty then
  begin
    if (Self.T1EU.Trim = 'E') or (Self.MinutiEntrata1 < Self.MinutiUScita1) (*or Self.T1EU.Trim.IsEmpty*) then
    begin
      Result:=Self.MinutiEntrata1;
    end;
  end;
  if Not Self.NumTurno2.Trim.IsEmpty then
  begin
    if (Self.T2EU.Trim = 'E') or (Self.MinutiEntrata2 < Self.MinutiUscita2) (*or Self.T2EU.Trim.IsEmpty*) then
    begin
      Result:=Min(Result,Self.MinutiEntrata2)
    end
    else
    begin
      Result:=Min(Result,0);
    end;
  end;
end;

function TGiorno.GetUltimaUscita:integer;
begin
  Result:=0;
  if Self.T1.Trim = 'R' then
  begin
    Exit;
  end;
  if Not Self.NumTurno1.Trim.IsEmpty then
  begin
    if (Self.MinutiEntrata1 < Self.MinutiUscita1) or (*Self.T1EU.Trim.IsEmpty or*) (Self.T1EU.Trim = 'U') then
    begin
      Result:=Self.MinutiUscita1;
    end
    else
    begin
      Result:=1440 + Self.MinutiUscita1;
    end;
  end;
  if Not Self.NumTurno2.Trim.IsEmpty then
  begin
    if (Self.MinutiEntrata2 < Self.MinutiUscita2) or (*Self.T2EU.Trim.IsEmpty or*) (Self.T2EU.Trim = 'U') then
    begin
      Result:=Max(Result,Self.MinutiUscita2);
    end
    else
    begin
      Result:=Max(Result,1440 + Self.MinutiUscita2);
    end;
  end;
end;

function TGiorno.GetUltimaEntrata:integer;
begin
  Result:=0;
  if Self.T1.Trim = 'R' then
  begin
    Exit;
  end;
  if Not Self.NumTurno1.Trim.IsEmpty then
  begin
    if (Self.T1EU.Trim = 'E') or (Self.MinutiEntrata1 < Self.MinutiUscita1) or Self.T1EU.Trim.IsEmpty then
    begin
      Result:=Self.MinutiEntrata1;
    end;
  end;
  if Not Self.NumTurno2.Trim.IsEmpty then
  begin
    if (Self.T2EU.Trim = 'E') or (Self.MinutiEntrata2 < Self.MinutiUscita2) or Self.T2EU.Trim.IsEmpty then
    begin
      Result:=Max(Result,Self.MinutiEntrata2);
    end
    else
    begin
      Result:=Max(Result,0);
    end
  end;
end;

function TGiorno.GetPrimaUscita:integer;
begin
  Result:=0;
  if Self.T1.Trim = 'R' then
  begin
    Exit;
  end;
  if Not Self.NumTurno1.Trim.IsEmpty then
  begin
    if (Self.T1EU.Trim = 'U') or (Self.MinutiEntrata1 < Self.MinutiUscita1) or Self.T1EU.Trim.IsEmpty then
    begin
      Result:=Self.MinutiUScita1;
    end
    else
    begin
      Result:=1440;
    end
  end;
  if Not Self.NumTurno2.Trim.IsEmpty then
  begin
    if (Self.T2EU.Trim = 'U') or (Self.MinutiEntrata2 < Self.MinutiUscita2) or Self.T2EU.Trim.IsEmpty then
    begin
      Result:=Min(Result,Self.MinutiUScita2);
    end
    else
    begin
      Result:=Min(Result,1440);
    end;
  end;
end;

procedure TGiorno.ClearAnomalie;
begin
  Self.Anomalie.Clear;
end;

constructor TGiorno.Create;
begin
  Self.ParentDipendente:=nil;
  SensibilitaModifica:=True;
  ClearTurniRep;
  Anomalie:=TListaAnomalie.Create(True);
  Anomalie.ParentGiorno:=Self;
  AssOre:=nil;
  ConteggiAggiornati:=False;
end;

destructor TGiorno.Destroy;
begin
  FreeAndNil(Anomalie);
  if (AssOre <> nil) then
    FreeAndNil(AssOre);
end;

procedure TGiorno.SensibilitaModificaON;
begin
  SensibilitaModifica:=True;
end;

procedure TGiorno.SensibilitaModificaOFF;
begin
  SensibilitaModifica:=False;
end;

procedure TGiorno.ClearTurniRep;
var
  I:Integer;
begin
  for I:=Low(TurniRep) to High(TurniRep) do
    TurniRep[I].Clear;
end;

function TGiorno.GetInfoTurno(NT12:TNumeroTurno):TTurno;
var
  FiltroT021:string;
  G:TGiorno;
  n:integer;
  lstOrari:TStringList;
  MyDtm:TA058FPianifTurniDtM1;
begin
  if NT12 = ntTurno1 then
  begin
    Result.Turno:=Self.T1;
    Result.TurnoEU:=Self.T1EU;
  end
  else if NT12 = ntTurno2 then
  begin
    Result.Turno:=Self.T2;
    Result.TurnoEU:=Self.T2EU;
  end;
  try
    MyDtm:=(Self.GetA058DTM as TA058FPianifTurniDtM1);
    Result.Entrata:=0;
    Result.Uscita:=0;
    Result.Sigla:='';
    Result.NumTurno:='';
    //Alberto 22/02/2018: Come mai può capitare che Turno = E/U??? (Capita solo se si chiede il ricalcolo dei turni)
    if not R180In(Result.Turno.Trim,['','M','A','E','U']) then
    begin

      lstOrari:=TStringList.Create;
      lstOrari.Sorted:=True;
      try
        if Self.Ora <> '' then
          lstOrari.Add('''' + Self.Ora + '''');
        with TDipendente(Self.ParentDipendente) do
          for G in Giorni do
          begin
            if (G.Ora <> '') and (lstOrari.IndexOf('''' + G.Ora + '''') = -1) then
              lstOrari.Add('''' + G.Ora + '''');
          end;
        if lstOrari.Count = 0 then
        begin
          if MyDtm.QT021.GetVariable('ORARI') = null then
            R180SetVariable(MyDtm.QT021,'ORARI','null');
        end
        else if R180GetCsvIntersect(VarToStr(MyDtm.QT021.GetVariable('ORARI')),lstOrari.CommaText) <> lstOrari.CommaText then
          R180SetVariable(MyDtm.QT021,'ORARI',lstOrari.CommaText);
        MyDtm.QT021.Open;
      finally
        lstOrari.Free;
      end;

      FiltroT021:='(CODICE = ''' + Self.Ora + ''')';
      FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Self.Data) + ' >= DECORRENZA)';
      FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Self.Data) + ' <= DECORRENZA_FINE)';
      MyDtm.QT021.Filtered:=False;
      MyDtm.QT021.Filter:=FiltroT021;
      MyDtm.QT021.Filtered:=True;
      if Result.Turno.ToInteger > 0 then
      begin
        if MyDtm.QT021.RecordCount >= Result.Turno.ToInteger then
        begin
          n:=1;
          MyDtm.QT021.First;
          //Posizionamento sul punto nominale corretto
          while n < Result.Turno.ToInteger do
          begin
            MyDtm.QT021.Next;
            inc(n);
          end;
          //Valorizzo entrata uscita turno 1
          Result.Entrata:=R180OreMinuti(MyDtm.QT021.FieldByName('ENTRATA').AsString);
          Result.Uscita:=R180OreMinuti(MyDtm.QT021.FieldByName('USCITA').AsString);
          if Result.Entrata < Result.Uscita then
          begin
            Result.TurnoEU:='';
          end;
          if not MyDtm.QT021.FieldByName('NUMTURNO').AsString.Trim.IsEmpty then
          begin
            if Result.TurnoEU.Trim.IsEmpty or (Result.TurnoEU = 'E') then
            begin
              Result.NumTurno:=MyDtm.QT021.FieldByName('NUMTURNO').AsString;
            end;
          end;
          if not MyDtm.QT021.FieldByName('SIGLATURNI').AsString.Trim.IsEmpty then
          begin
            Result.Sigla:='(' + MyDtm.QT021.FieldByName('SIGLATURNI').AsString + ')';
          end;
          if Result.Sigla.Trim.IsEmpty and (not MyDtm.QT021.FieldByName('NUMTURNO').AsString.Trim.IsEmpty) then
          begin
            Result.Sigla:='[' + MyDtm.QT021.FieldByName('NUMTURNO').AsString + ']';
          end;
          if Result.TurnoEU = 'U' then
          begin
            Result.Sigla:='(Sn)';
          end;
        end;
      end
      else if Result.Turno.ToInteger = 0 then
      begin
        Result.Sigla:='(R)';
      end;
    end;
  except
  end;
end;

function TGiorno.GetMinutiUscita1: Integer;
begin
  Result:=IfThen(pMinutiUscita1 = 0,1440,pMinutiUscita1);
end;

function TGiorno.GetMinutiUscita2: Integer;
begin
  Result:=IfThen(pMinutiUscita2 = 0,1440,pMinutiUscita2);
end;

procedure TGiorno.setT1(val:string);
var
  InfoTurno:TTurno;
begin
  //if pT1.Trim <> Val.Trim then
  //Alberto: eseguo sempre GetInfoTurno per aggiornare la sigla dello smonto notte
  begin
    Self.pT1:=Val;
    Self.NumTurno1:='';
    Self.pMinutiEntrata1:=0;
    Self.pMinutiUscita1:=0;
    Self.SiglaT1:='';
    InfoTurno:=GetInfoTurno(ntTurno1);
    Self.pMinutiEntrata1:=InfoTurno.Entrata;
    Self.pMinutiUscita1:=InfoTurno.Uscita;
    Self.SiglaT1:=InfoTurno.Sigla;
    Self.NumTurno1:=InfoTurno.NumTurno;
    Self.T1EU:=InfoTurno.TurnoEU;
    Self.Modificato:=SensibilitaModifica;
    Self.ConteggiAggiornati:=False;
  end;
end;

procedure TGiorno.setT2(val:string);
var
  InfoTurno:TTurno;
begin
  //if pT2.Trim <> Val.Trim then
  //Alberto: eseguo sempre GetInfoTurno per aggiornare la sigla dello smonto notte
  begin
    Self.pT2:=Val;
    Self.NumTurno2:='';
    Self.pMinutiEntrata2:=0;
    Self.pMinutiUscita2:=0;
    Self.SiglaT2:='';
    InfoTurno:=GetInfoTurno(ntTurno2);
    Self.pMinutiEntrata2:=InfoTurno.Entrata;
    Self.pMinutiUscita2:=InfoTurno.Uscita;
    Self.SiglaT2:=InfoTurno.Sigla;
    Self.NumTurno2:=InfoTurno.NumTurno;
    Self.T2EU:=InfoTurno.TurnoEU;
    Self.Modificato:=SensibilitaModifica;
    Self.ConteggiAggiornati:=False;
  end;
end;

procedure TGiorno.setAss1(val:string);
begin
  if SensibilitaModifica and (pAss1.Trim <> Val.Trim) then
  begin
    Modificato:=True;
  end;
  pAss1:=Val;
  ConteggiAggiornati:=False;
end;

procedure TGiorno.setAss2(val:string);
begin
  if SensibilitaModifica and (pAss2.Trim <> Val.Trim) then
  begin
    Modificato:=True;
  end;
  pAss2:=Val;
  ConteggiAggiornati:=False;
end;

procedure TGiorno.setOra(val:string);
var
  InfoTurno:TTurno;
begin
  if pOra.Trim <> Val.Trim then
  begin
    pOra:=Val;
    if not Self.T1.Trim.IsEmpty then
    begin
      Self.SiglaT1:='';
      Self.NumTurno1:='';
      Self.pMinutiEntrata1:=0;
      Self.pMinutiUscita1:=0;
      InfoTurno:=GetInfoTurno(ntTurno1);
      Self.pMinutiEntrata1:=InfoTurno.Entrata;
      Self.pMinutiUscita1:=InfoTurno.Uscita;
      Self.SiglaT1:=InfoTurno.Sigla;
      Self.NumTurno1:=InfoTurno.NumTurno;
      Self.T1EU:=InfoTurno.TurnoEU;
    end;
    if not Self.T2.Trim.IsEmpty then
    begin
      Self.SiglaT2:='';
      Self.NumTurno2:='';
      Self.pMinutiEntrata2:=0;
      Self.pMinutiUscita2:=0;
      InfoTurno:=GetInfoTurno(ntTurno2);
      Self.pMinutiEntrata2:=InfoTurno.Entrata;
      Self.pMinutiUscita2:=InfoTurno.Uscita;
      Self.SiglaT2:=InfoTurno.Sigla;
      Self.NumTurno2:=InfoTurno.NumTurno;
      Self.T2EU:=InfoTurno.TurnoEU;
    end;
    Self.Modificato:=SensibilitaModifica;
    Self.ConteggiAggiornati:=False;
  end;
end;

procedure TGiorno.setT1EU(val:string);
begin
  if SensibilitaModifica and (pT1EU.Trim <> val.Trim) then
  begin
    Modificato:=True;
  end;
  pT1EU:=val;
  Self.ConteggiAggiornati:=False;
end;

procedure TGiorno.setT2EU(val:string);
begin
  if SensibilitaModifica and (pT2EU.Trim <> val.Trim) then
  begin
    Modificato:=True;
  end;
  pT2EU:=val;
  Self.ConteggiAggiornati:=False;
end;

function TGiorno.IsTurnoRepPresente:Boolean;
var
  I:Integer;
begin
  Result:=False;
  for I:=Low(TurniRep) to High(TurniRep) do
  begin
    if TurniRep[I].Turno <> '' then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

procedure TGiorno.setAntincendio(Val:string);
begin
  if SensibilitaModifica and (pAntincendio.Trim.ToUpper <> Val.Trim.ToUpper) then
  begin
    Self.Modificato:=True;
  end;
  Self.pAntincendio:=Val.Trim.ToUpper;
end;

procedure TGiorno.setReferente(Val:string);
begin
  if SensibilitaModifica and (pReferente.Trim.ToUpper <> Val.Trim.ToUpper) then
  begin
    Self.Modificato:=True;
  end;
  Self.pReferente:=Val.Trim.ToUpper;
end;

procedure TGiorno.setRichiestoDaTurnista(Val:string);
begin
  if SensibilitaModifica and (pRichiestoDaTurnista.Trim.ToUpper <> Val.Trim.ToUpper) then
  begin
    Self.Modificato:=True;
  end;
  Self.pRichiestoDaTurnista:=Val.Trim.ToUpper;
end;

procedure TGiorno.setModificato(val:Boolean);
begin
  pModificato:=val;
  (Self.ParentDipendente as TDipendente).Modificato:=val;
end;

function TGiorno.CopyGiorno:TGiorno;
var
  I,iOpDip,iSgDip:Integer;
  CurrAssenzaOre,NuovaAssenzaOre:TAssenzaOre;
begin
  Result:=TGiorno.Create;
  Result.ParentDipendente:=Self.ParentDipendente;
  Result.SensibilitaModificaOFF;
  Result.SiglaT1:=Self.SiglaT1;
  Result.SiglaT2:=Self.SiglaT2;
  Result.NumTurno1:=Self.NumTurno1 ;
  Result.NumTurno2:=Self.NumTurno2;
  Result.ValorGior:=Self.ValorGior;
  if (Self.AssOre <> nil) then
  begin
    Result.AssOre:=TObjectList<TAssenzaOre>.Create(True);
    for CurrAssenzaOre in Self.AssOre do
    begin
      NuovaAssenzaOre:=TAssenzaOre.Create;
      NuovaAssenzaOre.Causale:=CurrAssenzaOre.Causale;
      NuovaAssenzaOre.TipoGiust:=CurrAssenzaOre.TipoGiust;
      NuovaAssenzaOre.Orario:=CurrAssenzaOre.Orario;
      Result.AssOre.Add(NuovaAssenzaOre);
    end;
  end;
  Result.VAss:=Self.VAss;
  Result.Flag:=Self.Flag;
  Result.Squadra:=Self.Squadra;
  //Result.DSquadra:=Self.Oper;          gc 22/01/2019 - BugFix?
  Result.DSquadra:=Self.DSquadra;
  Result.Oper:=Self.Oper;
  Result.Area:=Self.Area;
  Result.DArea:=Self.DArea;
  Result.CodServizio:=Self.CodServizio;
  Result.DescServizio:=Self.DescServizio;
  Result.VerTurni:=Self.VerTurni;
  Result.VerRiposi:=Self.VerRiposi;
  for I:=Low(Self.TurniRep) to High(Self.TurniRep) do
  begin
    Result.TurniRep[I]:=Self.TurniRep[I];
  end;
  Result.Ass1Modif:=Self.Ass1Modif;
  Result.Ass2Modif:=Self.Ass2Modif;
  Result.Modificato:=Self.Modificato;
  Result.Debito:=Self.Debito;
  Result.Assegnato:=Self.Assegnato;
  Result.NTimbTurno:=Self.NTimbTurno;
  Result.Data:=Self.Data;
  Result.GGFestivo:=Self.GGFestivo;
  Result.Antincendio:=Self.Antincendio;
  Result.Note:=Self.Note;
  Result.T1:=Self.T1;
  Result.T2:=Self.T2;
  Result.Ass1:=Self.Ass1;
  Result.Ass1Competenza:=Self.Ass1Competenza;
  Result.Ass2Competenza:=Self.Ass2Competenza;
  Result.Ass2:=Self.Ass2;
  Result.Ora:=Self.Ora;
  Result.T1EU:=Self.T1EU;
  Result.T2EU:=Self.T2EU;
  Result.pMinutiEntrata1:=Self.pMinutiEntrata1;
  Result.pMinutiEntrata2:=Self.pMinutiEntrata2;
  Result.pMinutiUscita1:=Self.pMinutiUscita1;
  Result.pMinutiUscita2:=Self.pMinutiUscita2;
  Result.Referente:=Self.Referente;
  Result.RichiestoDaTurnista:=Self.RichiestoDaTurnista;
  for i:=0 to Self.Anomalie.Count - 1 do
  begin
    Result.Anomalie.Add(Self.Anomalie[i].CopyAnomalia);
  end;
  Result.SensibilitaModificaOFF;
  Result.ConteggiAggiornati:=Self.ConteggiAggiornati;
  Result.DetDip.Riposi:=Self.DetDip.Riposi;
  SetLength(Result.DetDip.Operatori,Length(Self.DetDip.Operatori));
  for iOpDip:=Low(Self.DetDip.Operatori) to High(Self.DetDip.Operatori) do
  begin
    Result.DetDip.Operatori[iOpDip].Operatore:=Self.DetDip.Operatori[iOpDip].Operatore;
    Result.DetDip.Operatori[iOpDip].Totale:=Self.DetDip.Operatori[iOpDip].Totale;
    SetLength(Result.DetDip.Operatori[iOpDip].Sigle,Length(Self.DetDip.Operatori[iOpDip].Sigle));
    for iSgDip:=Low(Self.DetDip.Operatori[iOpDip].Sigle) to High(Self.DetDip.Operatori[iOpDip].Sigle) do
    begin
      Result.DetDip.Operatori[iOpDip].Sigle[iSgDip].Sigla:=Self.DetDip.Operatori[iOpDip].Sigle[iSgDip].Sigla;
      Result.DetDip.Operatori[iOpDip].Sigle[iSgDip].Totale:=Self.DetDip.Operatori[iOpDip].Sigle[iSgDip].Totale;
    end;
  end;
end;

{end TGiorno}

{Start T080PCKTURNO}

constructor T080PCKTURNO.create;
begin
  pckT080COPIATURNO:=TOracleQuery.Create(nil);
  pckT080COPIATURNO.Session:=SessioneOracle;
  pckT080GETDATOGENERICO:=TOracleQuery.Create(nil);
  pckT080GETDATOGENERICO.Session:=SessioneOracle;
  pckT080GETTIPOGIORNO:=TOracleQuery.Create(nil);
  pckT080GETTIPOGIORNO.Session:=SessioneOracle;
  IniPckT080COPIATURNO;
  InipckT080GETDATOGENERICO;
  InipckT080GETTIPOGIORNO;
  AbilitaCopia:=False;
end;

destructor T080PCKTURNO.destroy;
begin
  FreeAndNil(pckT080COPIATURNO);
  FreeAndNil(pckT080GETDATOGENERICO);
  FreeAndNil(pckT080GETTIPOGIORNO);
end;

procedure T080PCKTURNO.IniPckT080COPIATURNO;
begin
  pckT080COPIATURNO.SQL.Clear;
  pckT080COPIATURNO.SQL.Add('begin');
  pckT080COPIATURNO.SQL.Add('  :RESULT:=t080pck_turno.copiaturno(:PROGORIG,:PROGDEST,:DATAINIZIO,:DATAFINE);');
  pckT080COPIATURNO.SQL.Add('end;');
  pckT080COPIATURNO.DeleteVariables;
  pckT080COPIATURNO.DeclareVariable('PROGORIG',otInteger);
  pckT080COPIATURNO.DeclareVariable('PROGDEST',otInteger);
  pckT080COPIATURNO.DeclareVariable('DATAINIZIO',otDate);
  pckT080COPIATURNO.DeclareVariable('DATAFINE',otDate);
  pckT080COPIATURNO.DeclareVariable('RESULT',otString);
  //pckT080COPIATURNO.Debug:=DebugHook <> 0;
end;

procedure T080PCKTURNO.InipckT080GETDATOGENERICO;
begin
  pckT080GETDATOGENERICO.SQL.Clear;
  pckT080GETDATOGENERICO.SQL.Add('begin');
  pckT080GETDATOGENERICO.SQL.Add('  :PARTENZA:='''';');
  pckT080GETDATOGENERICO.SQL.Add('  t080pck_turno.GETDATO_GENERICO(:INPROG,:INDATA);');
  pckT080GETDATOGENERICO.SQL.Add('  :PARTENZA:=t080pck_turno.GETPARTENZA;');
  pckT080GETDATOGENERICO.SQL.Add('end;');
  pckT080GETDATOGENERICO.DeleteVariables;
  pckT080GETDATOGENERICO.DeclareVariable('INPROG',otInteger);
  pckT080GETDATOGENERICO.DeclareVariable('INDATA',otDate);
  pckT080GETDATOGENERICO.DeclareVariable('PARTENZA',otInteger);
  //pckT080GETDATOGENERICO.Debug:=DebugHook <> 0;
end;

procedure T080PCKTURNO.IniPckT080GETTIPOGIORNO;
begin
  pckT080GETTIPOGIORNO.SQL.Clear;
  pckT080GETTIPOGIORNO.SQL.Add('begin');
  pckT080GETTIPOGIORNO.SQL.Add('  :RESULT:=t080pck_turno.GETTIPOGIORNO(:PROGRESSIVO,:DATA,:DOMENICA_FESTIVA);');
  pckT080GETTIPOGIORNO.SQL.Add('end;');
  pckT080GETTIPOGIORNO.DeleteVariables;
  pckT080GETTIPOGIORNO.DeclareVariable('PROGRESSIVO',otInteger);
  pckT080GETTIPOGIORNO.DeclareVariable('DATA',otDate);
  pckT080GETTIPOGIORNO.DeclareVariable('DOMENICA_FESTIVA',otString);
  pckT080GETTIPOGIORNO.DeclareVariable('RESULT',otString);
  //pckT080GETTIPOGIORNO.Debug:=DebugHook <> 0;
end;

procedure T080PCKTURNO.CalcolaDatiADATA(Progr:integer; DataDest:TDateTime);
begin
  pckT080GETDATOGENERICO.SetVariable('INPROG',Progr);
  pckT080GETDATOGENERICO.SetVariable('INDATA',DataDest);
  pckT080GETDATOGENERICO.Execute;
end;

function T080PCKTURNO.CalcolaTipoGiorno(Progr:Integer; Data:TDateTime; DomenicaFestiva:String):String;
begin
  if (VarToStr(pckT080GETTIPOGIORNO.GetVariable('RESULT')) = '') or
     (pckT080GETTIPOGIORNO.GetVariable('PROGRESSIVO') <> Progr) or
     (pckT080GETTIPOGIORNO.GetVariable('DATA') <> Data) or
     (VarToStr(pckT080GETTIPOGIORNO.GetVariable('DOMENICA_FESTIVA')) <> DomenicaFestiva)
  then
  begin
    pckT080GETTIPOGIORNO.SetVariable('PROGRESSIVO',Progr);
    pckT080GETTIPOGIORNO.SetVariable('DATA',Data);
    pckT080GETTIPOGIORNO.SetVariable('DOMENICA_FESTIVA',DomenicaFestiva);
    pckT080GETTIPOGIORNO.Execute;
  end;
  Result:=VarToStr(pckT080GETTIPOGIORNO.GetVariable('RESULT'));
end;

function T080PCKTURNO.GetPartenza:integer;
begin
  Result:=StrToIntDef(VarToStr(pckT080GETDATOGENERICO.GetVariable('PARTENZA')),0);
end;

function T080PCKTURNO.SeEsisteDatoT620(Progr:integer;DataInizio:TDateTime):integer;
begin
  Result:=-1;
  with TOracleQuery.Create(nil) do
  begin
    try
      Session:=SessioneOracle;
      SQL.Add('begin');
      SQL.Add('  select count(*) into :NUM_REC');
      SQL.Add('    from T620_TURNAZIND T620');
      SQL.Add('   where T620.PROGRESSIVO = :PROGRESSIVO');
      SQL.Add('     and T620.DATA = :DATA;');
      SQL.Add('end;');
      //Debug:=DebugHook <> 0;
      DeclareAndSet('PROGRESSIVO',otInteger,Progr);
      DeclareAndSet('DATA',otDate,DataInizio);
      DeclareVariable('NUM_REC',otInteger);
      Execute;
      Result:=GetVariable('NUM_REC');
    finally
      Free;
    end;
  end;
end;

procedure T080PCKTURNO.SetVariabiliCopiaTurnazione(ProgOrig, ProgDest:integer; DataInizio, DataFine:TDateTime);
begin
  AbilitaCopia:=True;
  if ProgOrig <= 0 then
    AbilitaCopia:=False;
  if ProgDest <= 0 then
    AbilitaCopia:=False;
  if DataInizio > DataFine then
    AbilitaCopia:=False;
  pckT080COPIATURNO.ClearVariables;
  pckT080COPIATURNO.SetVariable('PROGORIG',ProgOrig);
  pckT080COPIATURNO.SetVariable('PROGDEST',ProgDest);
  pckT080COPIATURNO.SetVariable('DATAINIZIO',DataInizio);
  pckT080COPIATURNO.SetVariable('DATAFINE',DataFine);
end;

function T080PCKTURNO.CopiaTurnazione(EseguiCommit:Boolean = True):string;
begin
  Result:='';
  if AbilitaCopia then
  begin
    try
      pckT080COPIATURNO.Execute;
      Result:=VarToStr(pckT080COPIATURNO.getVariable('RESULT'));
      if EseguiCommit then
        SessioneOracle.Commit;
    except
      on e:exception do
        Result:=e.Message;
    end;
    AbilitaCopia:=False;
  end;
end;

{End T080PCKTURNO}

{Begin TElementoCellaUI}

constructor TElementoCellaUI.Create;
begin
  ZeroMemory(@Self.WinProprieta, SizeOf(TWinPropElementoCella));
  ZeroMemory(@Self.WebProprieta, SizeOf(TWebPropElementoCella));
  TipoComplesso:=False;
  ListaSottoElementi:=nil;
end;

destructor TElementoCellaUI.Destroy;
begin
 if ListaSottoElementi <> nil then
   FreeAndNil(ListaSottoElementi);
end;

{End TElementoCellaUI}

{Begin TCellaUI}

constructor TCellaUI.Create;
begin
  inherited;
  Self.Elementi:=TObjectList<TElementoCellaUI>.Create(True);
  Self.Indicatori:=TObjectList<TIndicatoreCellaUI>.Create(True);
end;

destructor TCellaUI.Destroy;
begin
  FreeAndNil(Self.Elementi);
  FreeAndNil(Self.Indicatori);
  inherited;
end;

{End TCellaUI}

{Begin}

constructor TWinUITabellaInfo.Create(rRectCella:TRect;iAltezzaRiga,iCurrentRowHeight,iCurrentColWidth:Integer);
begin
  Self.RectCella:=rRectCella;
  Self.AltezzaRiga:=iAltezzaRiga;
  Self.CurrentRowHeight:=iCurrentRowHeight;
  Self.CurrentColWidth:=iCurrentColWidth;
end;

{End}

procedure TA058FPianifTurniDtM1.A058FPianifTurniDtM1Create(Sender: TObject);
var
  i:Integer;
begin
  if not SessioneOracle.Connected  then
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
  //AssenzeOperative:=Parametri.CampiRiferimento.C11_PianifOrari_No_Giustif = 'OPERATIVA';
  A058PCKT080TURNO:=T080PCKTURNO.Create;
  ConteggiaDebito:=False;
  EscludiTipoCumulo:=False;
  QSSquadra:=TQueryStorico.Create(nil);
  QSSquadra.Session:=SessioneOracle;
  Vista:=TListDip.Create;
  Vista.Parent:=Self{A058FPianifTurniDtm1};
  xValoreOrigine:=TGiorno.Create;
  selDatiBloccatiA058:=TDatiBloccati.Create(nil);
  selT082.Open;
  selT082.Filtered:=True;
  AssenzeOperative:=selT082.FieldByName('ASSENZE_OPERATIVE').AsString = 'S';
  Q020.Open;
  Q265.Open;
  Q265B.Open;
  selT265Esclusione.Open;
  selT650.Open;
  selT651.Open;
  selI210.Open;
  A210MW:=TA210FRegoleArchiviazioneDocMW.Create(Self);
  A210MW.selI210:=selI210;
  ListaCicli:=TStringList.Create;
  Turno1:=TStringList.Create;
  Turno2:=TStringList.Create;
  Orario:=TStringList.Create;
  Causale:=TStringList.Create;
  R502ProDtM:=TR502ProDtM1.Create(nil);
  selTipoOpe.Open;
  selI010:=TselI010.Create(Self);
  try
    selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'','','NOME_LOGICO');
  except
    on E:Exception do ShowMessage(E.Message);
  end;
end;

procedure TA058FPianifTurniDtM1.FiltraT606(ODS:TOracleDataset; Data:TDateTime; Condizione,Giorno:String);
begin
  ODS.Filtered:=False;
  FiltroT606.Data:=Data;
  FiltroT606.Condizione:=Condizione;
  FiltroT606.Giorno:=Giorno;
  ODS.OnFilterRecord:=FilterRecordT606;
  ODS.Filtered:=True;
  ODS.First;
end;

procedure TA058FPianifTurniDtM1.RefreshSquadre;
begin
  R180SetVariable(selT603,'DATADA',DataInizio);
  R180SetVariable(selT603,'DATAA',DataFine);
  selT603.Open;
end;

procedure TA058FPianifTurniDtM1.selSostitutiVarImposta(DataRif:TDateTime;ProgressivoOrigine:LongInt;Orario,DalleAlle,Campi:String);
var DaOre,AOre,CampiV430,sNomeCampo,sNomeCampoDesc:String;
const TESTO_ANZIANITA = ',(select round(sum(least(V430A.T430DATAFINE,:DATA) - greatest(V430A.T430DATADECORRENZA,V430A.T430INIZIO) + 1)/365,1) ' + CRLF +
                          'from V430_STORICO V430A ' + CRLF +
                          'where V430A.T430PROGRESSIVO = V430.T430PROGRESSIVO ' + CRLF +
                          'and V430A.T430INIZIO = V430.T430INIZIO ' + CRLF +
                          'and nvl(V430A.T430FINE,:DATA) = nvl(V430.T430FINE,:DATA) ' + CRLF +
                          'and nvl(to_char(V430A.CAMPORIFERIMENTO),''#NULL#'') = nvl(to_char(V430.CAMPORIFERIMENTO),''#NULL#'') ' + CRLF +
                          'and greatest(V430A.T430DATADECORRENZA,V430A.T430INIZIO) <= least(V430A.T430DATAFINE,:DATA)) CAMPORIFERIMENTO_ANNI';
begin
  if not RicercaSostituti then exit;
  if DataRif <> 0 then
    selSostituti.SetVariable('DATA',DataRif);
  if VarToStr(selSostituti.GetVariable('DATA')) = '' then exit;
  selSostituti.SetVariable('TAB_PIANIF',IfThen(selT082.fieldByName('MODALITA_LAVORO').AsString = 'O','T080_PIANIFORARI','T081_PROVVISORIO'));
  selSostituti.SetVariable('FLAGAGG',IfThen(selT082.fieldByName('MODALITA_LAVORO').AsString = 'O','',IfThen(Parametri.CampiRiferimento.C11_PianifOrariProg = 'S',IfThen(TipoPianif = 0,'I','C'),'N')));
  selSostituti.SetVariable('PROGRESSIVO',ProgressivoOrigine);
  selSostituti.SetVariable('ORARIO',Orario);
  DaOre:=R180MinutiOre(R180OreMinuti(Copy(DalleAlle,2,5)));//Entrata (effettuo doppia conversione per annullare stringhe non conformi)
  AOre:=R180MinutiOre(R180OreMinuti(Copy(DalleAlle,11,5)));//Uscita (effettuo doppia conversione per annullare stringhe non conformi)
  selSostituti.SetVariable('DAORE',DaOre);
  selSostituti.SetVariable('AORE',AOre);
  selSostituti.SetVariable('SQUADRA',SquadraRiferimento);
  selSostituti.SetVariable('AZIENDA',Parametri.Azienda);
  if Campi <> '' then
  begin
    Campi:=Campi + ',';
    while Pos(',',Campi) > 0 do
    begin
      //Campo selezionato
      sNomeCampo:=VarToStr(selI010.Lookup('NOME_LOGICO',Copy(Campi,1,Pos(',',Campi) - 1),'NOME_CAMPO'));
      CampiV430:=CampiV430 + ',V430.' + sNomeCampo;
      //Descrizione
      sNomeCampoDesc:=VarToStr(selI010.Lookup('NOME_CAMPO',StringReplace(sNomeCampo,'430','430D_',[]),'NOME_CAMPO'));
      if (sNomeCampoDesc <> '') and (sNomeCampoDesc <> sNomeCampo) then
        CampiV430:=CampiV430 + ',V430.' + sNomeCampoDesc;
      //Anzianità
      CampiV430:=CampiV430 + StringReplace(TESTO_ANZIANITA,'CAMPORIFERIMENTO',sNomeCampo,[rfReplaceAll]);

      Campi:=Copy(Campi,Pos(',',Campi) + 1);
    end;
  end;
  selSostituti.SetVariable('CAMPI',CampiV430);
  //Se sono cambiate le variabili rispetto all'ultima apertura, chiedo di forzare la chiusura per rieseguire la query
  //(non uso R180SetVariable perché in certi punti del codice devo tenere il dataset aperto)
  if selSostitutiVarCambiate then
    if Assigned(procRichiediAggiornaSostituti) then
      procRichiediAggiornaSostituti;
end;

function TA058FPianifTurniDtM1.selSostitutiVarCambiate:Boolean;
begin
  Result:=
     (selSostitutiVar.Data <> VarToStr(selSostituti.GetVariable('DATA')))
  or (selSostitutiVar.TabPianif <> VarToStr(selSostituti.GetVariable('TAB_PIANIF')))
  or (selSostitutiVar.FlagAgg <> VarToStr(selSostituti.GetVariable('FLAGAGG')))
  or (selSostitutiVar.Progressivo <> VarToStr(selSostituti.GetVariable('PROGRESSIVO')))
  or (selSostitutiVar.Orario <> VarToStr(selSostituti.GetVariable('ORARIO')))
  or (selSostitutiVar.DaOre <> VarToStr(selSostituti.GetVariable('DAORE')))
  or (selSostitutiVar.AOre <> VarToStr(selSostituti.GetVariable('AORE')))
  or (selSostitutiVar.Squadra <> VarToStr(selSostituti.GetVariable('SQUADRA')))
  or (selSostitutiVar.Azienda <> VarToStr(selSostituti.GetVariable('AZIENDA')))
  or (selSostitutiVar.Campi <> VarToStr(selSostituti.GetVariable('CAMPI')))
  or (selSostitutiVar.OrderBy <> VarToStr(selSostituti.GetVariable('ORDERBY')));
end;

procedure TA058FPianifTurniDtM1.AvviaRicercaSostituti;
var ProgOld:Integer;
begin
  try
    if selSostituti.Active then
      ProgOld:=selSostituti.FieldByName('PROGRESSIVO_NV').AsInteger;
    selSostituti.Close;
    Screen.Cursor:=crHourGlass;
    selSostituti.Open;
    if not selSostituti.SearchRecord('PROGRESSIVO_NV',ProgOld,[srFromBeginning]) then
      selSostituti.First;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA058FPianifTurniDtM1.selSostitutiApplicaFiltro(Filtra:Boolean;Filtro:String = '--');
var ProgOld:Integer;
begin
  ProgOld:=selSostituti.FieldByName('PROGRESSIVO_NV').AsInteger;
  if Filtro <> '--' then
    selSostituti.Filter:=Filtro;
  selSostituti.Filtered:=Filtra;
  if not selSostituti.SearchRecord('PROGRESSIVO_NV',ProgOld,[srFromBeginning]) then
    selSostituti.First;
end;

procedure TA058FPianifTurniDtM1.selSostitutiAfterOpen(DataSet: TDataSet);
var i,k:Integer;
    NomeCampo,NomeLogico:String;
    CampoAnni:Boolean;
begin
  //Salvo variabili della open più recente
  selSostitutiVar.Data:=VarToStr(selSostituti.GetVariable('DATA'));
  selSostitutiVar.TabPianif:=VarToStr(selSostituti.GetVariable('TAB_PIANIF'));
  selSostitutiVar.FlagAgg:=VarToStr(selSostituti.GetVariable('FLAGAGG'));
  selSostitutiVar.Progressivo:=VarToStr(selSostituti.GetVariable('PROGRESSIVO'));
  selSostitutiVar.Orario:=VarToStr(selSostituti.GetVariable('ORARIO'));
  selSostitutiVar.DaOre:=VarToStr(selSostituti.GetVariable('DAORE'));
  selSostitutiVar.AOre:=VarToStr(selSostituti.GetVariable('AORE'));
  selSostitutiVar.Squadra:=VarToStr(selSostituti.GetVariable('SQUADRA'));
  selSostitutiVar.Azienda:=VarToStr(selSostituti.GetVariable('AZIENDA'));
  selSostitutiVar.Campi:=VarToStr(selSostituti.GetVariable('CAMPI'));
  selSostitutiVar.OrderBy:=VarToStr(selSostituti.GetVariable('ORDERBY'));
  //Imposto le etichette delle colonne della griglia dei sostituti
  for i:=0 to selSostituti.FieldCount - 1 do
  begin
    NomeCampo:=selSostituti.Fields[i].FieldName;
    NomeLogico:='';
    CampoAnni:=Copy(NomeCampo,Length(NomeCampo) - 4) = '_ANNI';
    for k:=Low(CAMPI_FISSI_RICERCA_SOSTITUTI) to High(CAMPI_FISSI_RICERCA_SOSTITUTI) do
      if CAMPI_FISSI_RICERCA_SOSTITUTI[k].NomeCampo = NomeCampo then
      begin
        NomeLogico:=CAMPI_FISSI_RICERCA_SOSTITUTI[k].Griglia;
        Break;
      end;
    if NomeLogico = '' then
      NomeLogico:=IfThen(CampoAnni,'Anz. ') + VarToStr(selI010.Lookup('NOME_CAMPO',IfThen(CampoAnni,Copy(NomeCampo,1,Length(NomeCampo) - 5),NomeCampo),'NOME_LOGICO'));
    selSostituti.Fields[i].DisplayLabel:=IfThen(NomeLogico <> '',NomeLogico,NomeCampo);
    selSostituti.Fields[i].Visible:=not (Copy(NomeCampo,Length(NomeCampo) - 2,3) = '_NV');
    selSostituti.Fields[i].DisplayWidth:=IfThen(NomeCampo = 'TR_PIANIF',8,
                                         IfThen(NomeCampo = 'DURATA_ASS',6,
                                         IfThen(NomeCampo = 'N_MIN_PIANIF',5,
                                         IfThen(NomeCampo = 'N_DIP_PIANIF',5,
                                         IfThen(NomeCampo = 'N_MAX_PIANIF',5,
                                         IfThen(CampoAnni,4,
                                                Min(selSostituti.Fields[i].DisplayWidth,20)))))));
  end;
end;

procedure TA058FPianifTurniDtM1.selSostitutiAfterScroll(DataSet: TDataSet);
var sRecord:String;
begin
  if Assigned(procNumRecords) then
    procNumRecords(DataSet);
end;

procedure TA058FPianifTurniDtM1.OpenSelV430(OutDato:String);
begin
  R180SetVariable(selV430,'DATA',DataInizio);
  R180SetVariable(selV430,'COLONNE',OutDato);
  selV430.Open;
end;

procedure TA058FPianifTurniDtM1.OpenSelT100(Prog:Integer;DaData,AData:TDateTime);
begin
  R180SetVariable(selT100,'PROGRESSIVO',Prog);
  R180SetVariable(selT100,'DADATA',DaData);
  R180SetVariable(selT100,'ADATA',AData);
  selT100.Open;
end;

function TA058FPianifTurniDtM1.GetConteggioTurni(Data:TDateTime; TipoOpe,SiglaTurno:String):TMaxMin;
var
  iGG,iOp,iSg:Integer;
begin
  Result.Min:=0;
  Result.Max:=0;
  Result.Totale:=0;

  if Vista.Count <= 0 then
    Exit;
  if Vista[0].Giorni.Count <= 0 then
    Exit;

  TipoOpe:=TipoOpe.Replace('(','').Replace(')','').Trim;
  SiglaTurno:=SiglaTurno.Replace('(','').Replace(')','').Trim;
  iGG:=Trunc(Data - Vista[0].Giorni[0].Data);
  for iOp:=0 to High(TotGio[iGG].Operatori) do
    if TotGio[iGG].Operatori[iOp].Operatore = TipoOpe then
      for iSg:=0 to High(TotGio[iGG].Operatori[iOp].Sigle) do
        if TotGio[iGG].Operatori[iOp].Sigle[iSg].Sigla = SiglaTurno then
        begin
          Result.Min:=StrToIntDef(TotGio[iGG].Operatori[iOp].Sigle[iSg].Min,0);
          Result.Max:=StrToIntDef(TotGio[iGG].Operatori[iOp].Sigle[iSg].Max,99);
          Result.Totale:=TotGio[iGG].Operatori[iOp].Sigle[iSg].Totale;
          Exit;
        end;
end;

function TA058FPianifTurniDtM1.TestAssenza(Ass:String):Boolean;
begin
  //Restituisce True se causale ad considerare come assenza
  Ass:=Trim(Ass);
  Result:=(Ass <> '');// and (not selT265Esclusione.SearchRecord('CODICE;ESCLUSIONE',VarArrayOf([Ass,'S']),[srfromBeginning]));
end;

function TA058FPianifTurniDtM1.TestRiposo(Ass:String):Boolean;
begin
  //Restituisce True se causale di tipo riposo o riposo compensativo
  Ass:=Trim(Ass);
  Result:=(Ass <> '') and selT265Esclusione.SearchRecord('CODICE;CODINTERNO',VarArrayOf([Ass,'H']),[srfromBeginning]);
  if not Result then
    Result:=(Ass <> '') and selT265Esclusione.SearchRecord('CODICE;CODINTERNO',VarArrayOf([Ass,'E']),[srfromBeginning]);
end;

function TA058FPianifTurniDtM1.TestRiposoComp(Ass:String):Boolean;
begin
  //Restituisce True se causale di tipo riposo o riposo compensativo
  Ass:=Trim(Ass);
  Result:=(Ass <> '') and selT265Esclusione.SearchRecord('CODICE;CODINTERNO',VarArrayOf([Ass,'E']),[srfromBeginning]);
end;

function TA058FPianifTurniDtM1.TestSmontoNotte(Giorno:TGiorno):Boolean;
begin
  Result:=False;
  if (Giorno.T1EU = 'U') and ((Giorno.T2.Trim = '') or (Giorno.T2.Trim = '0')) then
    Result:=True;
  if (Giorno.T2EU = 'U') and ((Giorno.T1.Trim = '') or (Giorno.T1.Trim = '0')) then
    Result:=True;
end;

procedure TA058FPianifTurniDtM1.AggiornaContatoriTurni(nRiga:integer;nColonna:integer;DopoElabTurni:Boolean = False);
begin
  if Vista[nRiga].Giorni[nColonna].Modificato or DopoelabTurni then
  begin
    //*************************************************************************
    //Aggiorno i contatori riguardanti la distribuzione dei turni
    //*************************************************************************
    AggiornaTotaleTurni(Vista[nRiga],nColonna,False); //Aumento i valori correnti
    AggiornaTotaleTurni(Vista[nRiga],nColonna,True);  //Decremento i valori precedenti
  end;
  {$IFNDEF IRISWEB}
  if (A058FGrigliaPianif <> nil) and (A058FGrigliaPianif.GVista <> nil) then
    A058FGrigliaPianif.GVista.Refresh;
  {$ENDIF}
end;

procedure TA058FPianifTurniDtM1.PianificaAssenza(NDip,G:LongInt; A1,A2:String; xArrayPianif:TPianificazione);
{Pianifica le assenze su T040 o T041 a seconda che la pianificazione sia
 operativa o meno}
var
  Cau1,Cau2:String;
  bTrovato:boolean;
  Prog:LongInt;
  Data:TDateTime;

    procedure Inserisci(Causale:String; ProgAss:integer);
    var AssModif:Boolean;
    begin
      if not Q265.Locate('Codice',Causale,[]) then exit;
      //Se registrazione su T040, consento solo se causale senza cumulo o causale di riposo
      if xArrayPianif.xDatasetGiust = Q040Gest then
      begin
        if not ((Q265.FieldByName('TIPOCUMULO').AsString = 'H') or R180In(Q265.FieldByName('CODINTERNO').AsString,['E','H'])) then
          exit;
      end;
      //Se il giustificativo è stato pianificato dalla gestione assenze allora non devo inserirlo...
      //perchè altrimenti creerei un duplicato, sulla T041 del record che esiste già sulla T040 e che non
      //è modificabile...
      if ProgAss = 1 then
       AssModif:=Vista[NDip].Giorni[G].Ass1Modif
      else
       AssModif:=Vista[NDip].Giorni[G].Ass2Modif;
      if AssModif then
      begin
        xArrayPianif.xDatasetGiust.Append;
        xArrayPianif.xDatasetGiust.FieldByName('Progressivo').AsInteger:=Prog;
        xArrayPianif.xDatasetGiust.FieldByName('Data').AsDateTime:=Data;
        xArrayPianif.xDatasetGiust.FieldByName('Causale').AsString:=Causale;
        xArrayPianif.xDatasetGiust.FieldByName('ProgrCausale').AsInteger:=98 + ProgAss;
        if xArrayPianif.xDatasetGiust = Q040Gest then
        begin
          xArrayPianif.xDatasetGiust.FieldByName('TipoGiust').AsString:='I';
          xArrayPianif.xDatasetGiust.FieldByName('Scheda').AsString:='P';
        end;
        if not xArrayPianif.sFlagAgg.IsEmpty and not AssenzeOperative then
        begin
          xArrayPianif.xDatasetGiust.FieldByName('FLAGAGG').AsString:=xArrayPianif.sFlagAgg;
        end;
        xArrayPianif.xDatasetGiust.Post;
      end;
    end;

begin
  Prog:=Vista[NDip].Prog;
  Data:=DataInizio + G - OffsetVista;
  Cau1:='';
  Cau2:='';
  if (xArrayPianif.sFlagAgg = '') or AssenzeOperative then
    bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;TipoGiust',VarArrayOf([Data,'I']),[srFromBeginning])
  else
    bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;FlagAgg',VarArrayOf([Data, xArrayPianif.sFlagAgg]),[srFromBeginning]);
  if bTrovato then
    //leggo le causali a giornate intere in Cau1 e Cau2 (Max 2)
    while not xArrayPianif.xDatasetGiust.Eof do
    begin
      if xArrayPianif.xDatasetGiust.FieldByName('Data').AsDateTime <> Data then Break;
      if (Cau1 = '') then //and (xArrayPianif.xDatasetGiust.FieldByName('PROGRCAUSALE').asInteger <= 99) then
        Cau1:=xArrayPianif.xDatasetGiust.FieldByName('Causale').AsString
      else if (Cau2 = '') then //and (xArrayPianif.xDatasetGiust.FieldByName('PROGRCAUSALE').asInteger <> 99) then
        Cau2:=xArrayPianif.xDatasetGiust.FieldByName('Causale').AsString;
      xArrayPianif.xDatasetGiust.Next;
    end;
  {if (Not A058FPianifTurni.NuovaPianif) and
     (Not A058FPianifTurni.AssenzeOperative) then
  begin}
    if (Cau1 <> A1) then
    begin
      //Se Cau1 non è più pianificata la cancello
      if (xArrayPianif.sFlagAgg = '') or AssenzeOperative then
        bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;Causale;TipoGiust',VarArrayOf([Data,Cau1,'I']),[srFromBeginning])
      else
        bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;Causale;FlagAgg',VarArrayOf([Data,Cau1,xArrayPianif.sFlagAgg]),[srFromBeginning]);
      if bTrovato then
        xArrayPianif.xDatasetGiust.Delete;
    end;
    if (Cau2 <> A2) then
    begin
      //Se Cau2 non è più pianificata la cancello
      if (xArrayPianif.sFlagAgg = '') or AssenzeOperative then
        bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;Causale;TipoGiust',VarArrayOf([Data,Cau2,'I']),[srFromBeginning])
      else
        bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;Causale;FlagAgg',VarArrayOf([Data,Cau2,xArrayPianif.sFlagAgg]),[srFromBeginning]);
      if bTrovato then
        xArrayPianif.xDatasetGiust.Delete;
    end;
  //end;
  if (A1 <> Cau1) and (A1 <> Cau2) then
    //Se A1 non esiste la inserisco
    if A1 <> '' then
      Inserisci(A1,1);
  if (A2 <> Cau1) and (A2 <> Cau2) then
    if A2 <> '' then
      Inserisci(A2,2);
end;

procedure TA058FPianifTurniDtM1.PianificaOrario(NDip,G:LongInt; Giorno:TGiorno;xArrayPianif:TPianificazione);
{Pianifica l'orario su T080 o T081 a seconda che la pianificazione sia operativa o meno}
var
  Prog:integer;
  Data:TDateTime;
begin
  Prog:=Vista[NDip].Prog;
  //per il calcolo della data tolgo l'offset
  Data:=DataInizio + G - OffsetVista;
  //Se esiste una pianificazione esistente la cancello
  if xArrayPianif.xDatasetPianif.Locate('Data',Data,[]) then
    xArrayPianif.xDatasetPianif.Delete;
  if (Q020.Locate('Codice',Giorno.Ora,[])) then
     // or (selT651.Locate('Codice_Area',Giorno.Area,[])) then  (questo controllo lo tolgo) - Giorgio (se non seleziono l'orario ma solo l'area, NON SALVO)
  //Pianifico se esiste l'orario o esiste l'area
  begin
    xArrayPianif.xDatasetPianif.Append;
    xArrayPianif.xDatasetPianif.FieldByName('Progressivo').AsInteger:=Prog;
    xArrayPianif.xDatasetPianif.FieldByName('Data').AsDateTime:=Data;
    xArrayPianif.xDatasetPianif.FieldByName('Orario').AsString:=Giorno.Ora;
    xArrayPianif.xDatasetPianif.FieldByName('Turno1').AsString:='';
    xArrayPianif.xDatasetPianif.FieldByName('Turno2').AsString:='';
    xArrayPianif.xDatasetPianif.FieldByName('Turno1EU').AsString:='';
    xArrayPianif.xDatasetPianif.FieldByName('Turno2EU').AsString:='';
    xArrayPianif.xDatasetPianif.FieldByName('Antincendio').AsString:=Giorno.Antincendio;
    xArrayPianif.xDatasetPianif.FieldByName('Note').AsString:=Giorno.Note;
    xArrayPianif.xDatasetPianif.FieldByName('Referente').AsString:=Giorno.Referente;
    xArrayPianif.xDatasetPianif.FieldByName('Richiesto_da_turnista').AsString:=Giorno.RichiestoDaTurnista;
    xArrayPianif.xDatasetPianif.FieldByName('Area').AsString:=Giorno.Area;
    if xArrayPianif.xDatasetPianif = Q080Gest then
      xArrayPianif.xDatasetPianif.FieldByName('ValorGior').AsString:=Giorno.ValorGior;
    if (Q020.FieldByName('TipoOra').AsString = 'E') and (Trim(Giorno.T1) <> 'M') and (Trim(Giorno.T1) <> 'A') then
    //FlagAgg = 'P' viene impostato automaticamente in U080/U081
    //Pianifico i turni solo se l'orario è di tipo Turni
    begin
      xArrayPianif.xDatasetPianif.FieldByName('Turno1').AsString:=Trim(Giorno.T1);
      xArrayPianif.xDatasetPianif.FieldByName('Turno2').AsString:=Trim(Giorno.T2);
      xArrayPianif.xDatasetPianif.FieldByName('Turno1EU').AsString:=Giorno.T1EU;
      xArrayPianif.xDatasetPianif.FieldByName('Turno2EU').AsString:=Giorno.T2EU;
    end;
    if xArrayPianif.sFlagAgg <> '' then
    begin
      xArrayPianif.xDatasetPianif.FieldByName('FLAGAGG').AsString:=xArrayPianif.sFlagAgg;
    end;
    xArrayPianif.xDatasetPianif.Post;
  end;
end;

procedure TA058FPianifTurniDtM1.PianificaGiorno(NDip,G:LongInt; BloccoT040,BloccoT080:Boolean; xArrayPianif:TPianificazione);
begin
  //with Vista[NDip].Giorni[G] do
  begin
    //Non pianifico le pianificazioni manuali già esistenti
    if (Vista[NDip].Giorni[G].Flag = 'M') and (not Vista[NDip].Giorni[G].Modificato) and (Parametri.CampiRiferimento.C11_PianifOrariProg <> 'S') then
      Exit;
    //Pianifico l'orario
    if not BloccoT080 then
      PianificaOrario(NDip,G,Vista[NDip].Giorni[G](*Ora,T1,T2,T1EU,T2EU,ValorGior*),xArrayPianif);
    //Pianifico le assenze
    if not BloccoT040 then
      PianificaAssenza(NDip,G,Vista[NDip].Giorni[G].Ass1,Vista[NDip].Giorni[G].Ass2,xArrayPianif);
  end;
end;

procedure TA058FPianifTurniDtM1.RendiOperativa(NDip:LongInt);
{Esegui pianificazione}
var i,n:LongInt;
    xArrayPianif:array of TPianificazione;
    BloccoT040,BloccoT080:Boolean;
    D:TDateTime;
begin
  try
    selDatiBloccatiA058.Close;
    BloccoT040:=False;
    BloccoT080:=False;
    //Cancella la pianificazione esistente su T080,T040 o su T081,T041
    //Verifico se uno dei riepiloghi è bloccato
    D:=DataInizio;
    while D <= DataFine do
    begin
      if selDatiBloccatiA058.DatoBloccato(Vista[NDip].Prog,R180InizioMese(D),'T040') then
        BloccoT040:=True;
      if selDatiBloccatiA058.DatoBloccato(Vista[NDip].Prog,R180InizioMese(D),'T080') then
        BloccoT080:=True;
      D:=D + 1;
    end;

    if not BloccoT080 then
    begin
      CancT080.SetVariable('Progressivo',Vista[NDip].Prog);
      CancT080.SetVariable('Data1',DataInizio);
      CancT080.SetVariable('Data2',DataFine);
      CancT080.Execute;
    end;
    if not BloccoT040 then
    begin
      CancT040.SetVariable('Progressivo',Vista[NDip].Prog);
      CancT040.SetVariable('Data1',DataInizio);
      CancT040.SetVariable('Data2',DataFine);
      CancT040.Execute;
    end;

    //Apertura archivio pianificazioni
    SetLength(xArrayPianif,0);
    SetLength(xArrayPianif,Length(xArrayPianif)+1);
    xArrayPianif[High(xArrayPianif)].xDatasetPianif:=Q080Gest;
    xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q040Gest;
    xArrayPianif[High(xArrayPianif)].sFlagAgg:='';
    for n:=0 to High(xArrayPianif) do
    begin
      xArrayPianif[n].xDatasetPianif.Close;
      xArrayPianif[n].xDatasetPianif.ClearVariables;
      xArrayPianif[n].xDatasetPianif.SetVariable('Progressivo',Vista[NDip].Prog);
      xArrayPianif[n].xDatasetPianif.SetVariable('Data1',DataInizio);
      xArrayPianif[n].xDatasetPianif.SetVariable('Data2',DataFine);
      xArrayPianif[n].xDatasetPianif.Open;
      //Aggiorno i giustificativi non pianificati
      Q040.Close;
      Q040.Open;
      //Apertura archivio giustificativi
      xArrayPianif[n].xDatasetGiust.Close;
      xArrayPianif[n].xDatasetGiust.ClearVariables;
      xArrayPianif[n].xDatasetGiust.SetVariable('Progressivo',Vista[NDip].Prog);
      xArrayPianif[n].xDatasetGiust.SetVariable('Data1',DataInizio);
      xArrayPianif[n].xDatasetGiust.SetVariable('Data2',DataFine);
      xArrayPianif[n].xDatasetGiust.Open;
      //Scorrimento dei giorni da pianificare
      for i:=0 to Vista[NDip].Giorni.Count - 1 do
        PianificaGiorno(NDip,i,BloccoT040,BloccoT080,xArrayPianif[n]);
      SessioneOracle.ApplyUpdates([xArrayPianif[n].xDatasetPianif, xArrayPianif[n].xDatasetGiust],True);
    end;

    //Registrazione log
    if not BloccoT040 then
    begin
      RegistraLog.SettaProprieta('I','T040_GIUSTIFICATIVI',Copy(Self.Name,1,4),nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Vista[NDip].Prog));
      RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
      RegistraLog.RegistraOperazione;
    end;
    if not BloccoT080 then
    begin
      RegistraLog.SettaProprieta('I','T080_PIANIFORARI',Copy(Self.Name,1,4),nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Vista[NDip].Prog));
      RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
      RegistraLog.RegistraOperazione;
    end;
  finally
    SessioneOracle.Commit;
  end;
end;

procedure TA058FPianifTurniDtM1.CancellaPianificazione(Prog:LongInt);
{Cancello i dati del dipendente corrente}
var
  D:TDateTime;
  BloccoT040,BloccoT080:Boolean;
  xArrayPianif:array of TPianificazione;
  i:integer;
begin
  try
    selDatiBloccatiA058.Close;
    BloccoT080:=False;
    BloccoT040:=False;
    SetLength(xArrayPianif,0);
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      //Verifico se uno dei riepiloghi è bloccato
      D:=DataInizio;
      while D <= DataFine do
      begin
        if selDatiBloccatiA058.DatoBloccato(Prog,R180InizioMese(D),'T040') then
          BloccoT040:=True;
        if selDatiBloccatiA058.DatoBloccato(Prog,R180InizioMese(D),'T080') then
          BloccoT080:=True;
        D:=D + 1;
      end;
      SetLength(xArrayPianif,length(xArrayPianif)+1);
      xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancAllT080;
      xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT040;
      xArrayPianif[High(xArrayPianif)].sFlagAgg:='';
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        (*Alberto 29/09/2017: perchè? non mi convince
        SetLength(xArrayPianif,length(xArrayPianif)+1);
        xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
        xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='I';
        SetLength(xArrayPianif,length(xArrayPianif)+1);
        xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
        xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='C';
        *)
      end;
    end
    else
    begin
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        {Precedente al 10/04/2014)
        SetLength(xArrayPianif,length(xArrayPianif)+1);
        xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
        xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='I';
        SetLength(xArrayPianif,length(xArrayPianif)+1);
        xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
        xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='C';}
        SetLength(xArrayPianif,length(xArrayPianif)+1);
        xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
        xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
        if TipoPianif = 0 then
          xArrayPianif[High(xArrayPianif)].sFlagAgg:='I'
        else
          xArrayPianif[High(xArrayPianif)].sFlagAgg:='C';
      end
      else
      begin
        SetLength(xArrayPianif,length(xArrayPianif)+1);
        xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
        xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='N';
      end;
    end;

    for i:=0 to High(xArrayPianif) do
    begin
      //Pianificazione
      if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') or (not BloccoT080) then
      begin
        xArrayPianif[i].xQueryPianif.ClearVariables;
        xArrayPianif[i].xQueryPianif.SetVariable('Progressivo',Prog);
        xArrayPianif[i].xQueryPianif.SetVariable('Data1',DataInizio);
        xArrayPianif[i].xQueryPianif.SetVariable('Data2',DataFine);
        if xArrayPianif[i].sFlagAgg <> '' then
        begin
          xArrayPianif[i].xQueryPianif.SetVariable('FlagAgg',' AND FLAGAGG = ''' + xArrayPianif[i].sFlagAgg + '''');
        end;
        xArrayPianif[i].xQueryPianif.Execute;
      end;
      //Giustificativi
      if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') or (not BloccoT040) then
      begin
        xArrayPianif[i].xQueryGiust.SetVariable('Progressivo',Prog);
        xArrayPianif[i].xQueryGiust.SetVariable('Data1',DataInizio);
        xArrayPianif[i].xQueryGiust.SetVariable('Data2',DataFine);
        if (not xArrayPianif[i].sFlagAgg.IsEmpty) and not AssenzeOperative {(xArrayPianif[i].xQueryGiust.VariableIndex('FLAGAGG') >= 0)}  then
        begin
          xArrayPianif[i].xQueryGiust.SetVariable('FlagAgg',' AND FLAGAGG = ''' + xArrayPianif[i].sFlagAgg + '''');
        end;
        xArrayPianif[i].xQueryGiust.Execute;
      end;
    end;

    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      if not BloccoT040 then
      begin
        RegistraLog.SettaProprieta('C','T040_GIUSTIFICATIVI',Copy(Name,1,4),nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
        RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
        RegistraLog.RegistraOperazione;
      end;
      if not BloccoT080 then
      begin
        RegistraLog.SettaProprieta('C','T080_PIANIFORARI',Copy(Name,1,4),nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
        RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
        RegistraLog.RegistraOperazione;
      end;
    end;
  finally
    SessioneOracle.Commit;
  end;
end;

function TA058FPianifTurniDtM1.PianifBloccata(Progressivo: Integer; Data: TDateTime): Boolean;
var CodRiep:String;
begin
  CodRiep:=IfThen(TipoPianif = 0,COD_RIEPILOGO_INIZIALE,COD_RIEPILOGO_CORRENTE);
  Result:=selDatiBloccatiA058.DatoBloccato(Progressivo,Data,CodRiep);
end;

procedure TA058FPianifTurniDtM1.EseguiBloccaSblocca(Operazione: String);
var i:Integer;
    CodRiep:String;
begin
  if Vista.Count = 0 then
    Exit;

  if Assigned(procProgressBarInizio) then
    procProgressBarInizio;
  //Scorro Vista (elenco dipendenti)
  for i:=0 to Vista.Count - 1 do
  begin
    if Assigned(procProgressBarNext) then
      procProgressBarNext;
    // blocco riepilogo per tutto il mese per il progressivo selezionato
    CodRiep:=IfThen(TipoPianif = 0,COD_RIEPILOGO_INIZIALE,COD_RIEPILOGO_CORRENTE);
    if Operazione='B' then
      selDatiBloccatiA058.BloccaRiepilogo(Vista[i].Prog,R180InizioMese(DataInizio),R180FineMese(DataFine),CodRiep)
    else
      selDatiBloccatiA058.SbloccaRiepilogo(Vista[i].Prog,R180InizioMese(DataInizio),R180FineMese(DataFine),CodRiep);
  end;
  if Assigned(procProgressBarFine) then
    procProgressBarFine;
end;

procedure TA058FPianifTurniDtM1.AbilitaBloccaSblocca(var AbilitaBlocca, AbilitaSblocca: Boolean);
var i:Integer;
begin
  // Setto abilitazioni di default
  AbilitaBlocca:=False;
  AbilitaSblocca:=False;

  if Vista.Count = 0 then
    Exit;

  //Scorro Vista (elenco dipendenti)
  for i:=0 to Vista.Count - 1 do
  begin
    // verifica condizione di blocco/sblocco riepilogo per il progressivo selezionato alla data inizio
    if PianifBloccata(Vista[i].Prog,DataInizio) then
      AbilitaSblocca:=True
    else
      AbilitaBlocca:=True;
  end;
end;

procedure TA058FPianifTurniDtM1.EseguiPianificazione(NDip:LongInt;DataRif:TDateTime);
{Esegui pianificazione}
var i,n:LongInt;
    xArrayPianif:array of TPianificazione;
    BloccoT040,BloccoT080:Boolean;
    D,DIni,DFin:TDateTime;
begin
  try
    if DataRif <> -1 then
    begin
      DIni:=DataRif;
      DFin:=DataRif;
    end
    else
    begin
      DIni:=DataInizio;
      DFin:=DataFine;
    end;
    selDatiBloccatiA058.Close;
    BloccoT040:=False;
    BloccoT080:=False;
    //Cancella la pianificazione esistente su T080,T040 o su T081,T041
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      //Verifico se uno dei riepiloghi è bloccato
      D:=DIni;
      while D <= DFin do
      begin
        if selDatiBloccatiA058.DatoBloccato(Vista[NDip].Prog,R180InizioMese(D),'T040') then
          BloccoT040:=True;
        if selDatiBloccatiA058.DatoBloccato(Vista[NDip].Prog,R180InizioMese(D),'T080') then
          BloccoT080:=True;
        D:=D + 1;
      end;
    end;
    if NuovaPianif then
    begin
      if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
      begin
        if not BloccoT080 then
        begin
          CancT080.SetVariable('Progressivo',Vista[NDip].Prog);
          CancT080.SetVariable('Data1',DIni);
          CancT080.SetVariable('Data2',DFin);
          CancT080.Execute;
        end;
        if not BloccoT040 then
        begin
          CancT040.SetVariable('Progressivo',Vista[NDip].Prog);
          CancT040.SetVariable('Data1',DIni);
          CancT040.SetVariable('Data2',DFin);
          CancT040.Execute;
        end;
        (*Alberto 29/09/2017: perchè? non mi convince
        //Se è attiva la PIANIFICAZIONE PROGRESSIVA elimino anche il contenuto
        //delle tabelle T081 e T041
        if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
        begin
          CancT081.SetVariable('Progressivo',Vista[NDip].Prog);
          CancT081.SetVariable('Data1',DIni);
          CancT081.SetVariable('Data2',DFin);
          CancT081.SetVariable('FlagAgg',' AND FLAGAGG <> ''N''');
          CancT081.Execute;
          CancT041.SetVariable('Progressivo',Vista[NDip].Prog);
          CancT041.SetVariable('Data1',DIni);
          CancT041.SetVariable('Data2',DFin);
          CancT041.SetVariable('FlagAgg',' AND FLAGAGG <> ''N''');
          CancT041.Execute;
        end;
        *)
      end
      else
      begin
        CancT081.SetVariable('Progressivo',Vista[NDip].Prog);
        CancT081.SetVariable('Data1',DIni);
        CancT081.SetVariable('Data2',DFin);
        if (Parametri.CampiRiferimento.C11_PianifOrariProg <> 'S') then
          CancT081.SetVariable('FlagAgg','AND FLAGAGG = ''N''')
        else if TipoPianif = 0 then //Iniziale
          CancT081.SetVariable('FlagAgg',' AND FLAGAGG = ''I''')
        else if TipoPianif = 1 then //Corrente
          CancT081.SetVariable('FlagAgg',' AND FLAGAGG = ''C''');
        CancT081.Execute;
        CancT041.SetVariable('Progressivo',Vista[NDip].Prog);
        CancT041.SetVariable('Data1',DIni);
        CancT041.SetVariable('Data2',DFin);
        if (Parametri.CampiRiferimento.C11_PianifOrariProg <> 'S') then
          CancT041.SetVariable('FlagAgg','AND FLAGAGG = ''N''')
        else if TipoPianif = 0 then //Iniziale
          CancT041.SetVariable('FlagAgg',' AND FLAGAGG = ''I''')
        else if TipoPianif = 1 then //Corrente
          CancT041.SetVariable('FlagAgg',' AND FLAGAGG = ''C''');
        CancT041.Execute;
      end;
    end;
    //Apertura archivio pianificazioni
    SetLength(xArrayPianif,0);
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then //PIANIFICAZIONE PROGRESSIVA (SOLO OPERATIVA)
    begin
      if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
      begin
        SetLength(xArrayPianif,Length(xArrayPianif)+1);
        xArrayPianif[High(xArrayPianif)].xDatasetPianif:=Q080Gest;
        xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q040Gest;
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='';
      end;
      {*Pianificazione progressivo non operativa*}
      //if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') then
      begin
        if GeneraIniCorr or ((TipoPianif = 0) and (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N')) then
        begin
          SetLength(xArrayPianif,Length(xArrayPianif) + 1);
          xArrayPianif[High(xArrayPianif)].xDatasetPianif:=Q081Gest;
          if not AssenzeOperative then
            xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q041Gest
          else
            xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q040Gest;
          xArrayPianif[High(xArrayPianif)].sFlagAgg:='I';
        end;
        if GeneraIniCorr or ((TipoPianif = 1) and (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N')) or
          (NuovaPianif and  (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N')) then
        begin
          SetLength(xArrayPianif,Length(xArrayPianif) + 1);
          xArrayPianif[High(xArrayPianif)].xDatasetPianif:=Q081Gest;
          if not AssenzeOperative then
            xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q041Gest
          else
            xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q040Gest;
          xArrayPianif[High(xArrayPianif)].sFlagAgg:='C';
        end;
      end;
      {--Bruno--10/04/2014}
    end
    else
    begin
      SetLength(xArrayPianif,1);
      if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
      begin
        xArrayPianif[0].xDatasetPianif:=Q080Gest;
        xArrayPianif[0].xDatasetGiust:=Q040Gest;
        xArrayPianif[0].sFlagAgg:='';
      end
      else
      begin
        xArrayPianif[0].xDatasetPianif:=Q081Gest;
        xArrayPianif[0].xDatasetGiust:=Q041Gest;
        if AssenzeOperative then
          xArrayPianif[0].xDatasetGiust:=Q040Gest;
        xArrayPianif[0].sFlagAgg:='N';
      end;
    end;
    for n:=0 to High(xArrayPianif) do
    begin
      xArrayPianif[n].xDatasetPianif.Close;
      xArrayPianif[n].xDatasetPianif.ClearVariables;
      xArrayPianif[n].xDatasetPianif.SetVariable('Progressivo',Vista[NDip].Prog);
      xArrayPianif[n].xDatasetPianif.SetVariable('Data1',DIni);
      xArrayPianif[n].xDatasetPianif.SetVariable('Data2',DFin);
      if xArrayPianif[n].sFlagAgg <> '' then
        xArrayPianif[n].xDatasetPianif.SetVariable('FLAGAGG','AND FLAGAGG = ''' + xArrayPianif[n].sFlagAgg + '''');
      xArrayPianif[n].xDatasetPianif.Open;
      //Aggiorno i giustificativi non pianificati
      Q040.Close;
      Q040.Open;
      //Apertura archivio giustificativi
      //LELLO
      xArrayPianif[n].xDatasetGiust.Close;
      xArrayPianif[n].xDatasetGiust.ClearVariables;
      xArrayPianif[n].xDatasetGiust.SetVariable('Progressivo',Vista[NDip].Prog);
      xArrayPianif[n].xDatasetGiust.SetVariable('Data1',DIni);
      xArrayPianif[n].xDatasetGiust.SetVariable('Data2',DFin);
      if Not xArrayPianif[n].sFlagAgg.IsEmpty and Not AssenzeOperative{(xArrayPianif[n].xDatasetGiust.VariableIndex('FLAGAGG') >= 0)} then
      begin
        xArrayPianif[n].xDatasetGiust.SetVariable('FLAGAGG','AND FLAGAGG = ''' + xArrayPianif[n].sFlagAgg + '''');
      end;
      xArrayPianif[n].xDatasetGiust.Open;
      //Pianifico il giorno specificato
      if DataRif <> -1 then
        PianificaGiorno(NDip,OffsetVista + Trunc(DIni - DataInizio),BloccoT040,BloccoT080,xArrayPianif[n])
      else
        //Scorrimento dei giorni da pianificare
        for i:=OffsetVista to (OffsetVista + Trunc(DFin - DIni)) do
          PianificaGiorno(NDip,i,BloccoT040,BloccoT080,xArrayPianif[n]);
      SessioneOracle.ApplyUpdates([xArrayPianif[n].xDatasetPianif, xArrayPianif[n].xDatasetGiust],True);
    end;
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      if not BloccoT040 then
      begin
        RegistraLog.SettaProprieta('I','T040_GIUSTIFICATIVI',Copy(Self.Name,1,4),nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Vista[NDip].Prog));
        if DataRif <> -1 then
          RegistraLog.InserisciDato('DATA','',DateToStr(DIni))
        else
          RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DIni),DateToStr(DFin)]));
        RegistraLog.RegistraOperazione;
      end;
      if not BloccoT080 then
      begin
        RegistraLog.SettaProprieta('I','T080_PIANIFORARI',Copy(Self.Name,1,4),nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Vista[NDip].Prog));
        if DataRif <> -1 then
          RegistraLog.InserisciDato('DATA','',DateToStr(DIni))
        else
          RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DIni),DateToStr(DFin)]));
        RegistraLog.RegistraOperazione;
      end;
    end;
  finally
    SessioneOracle.Commit;
  end;
end;

procedure TA058FPianifTurniDtM1.EstraiTurnazioni(Data: TDateTime);
var i,Posizione:Integer;
    DataRif:TDateTime;
    OffSet:Integer;
begin
  if cdsT611.Active then
    cdsT611.EmptyDataset;
  cdsT611.Close;
  cdsT611.Open;
  cdsT611.FieldByName('PROGRESSIVO').Visible:=False;
  cdsT611.FieldByName('CICLO').Visible:=False;
  cdsT611.FieldByName('NOMINATIVO').DisplayWidth:=20;
  cdsT611.FieldByName('SQUADRA').DisplayWidth:=5;
  TurnazioneOld:='';
  for i:=0 to Vista.Count - 1 do
  begin
    GetAssegnazioneTurnazione(Vista[i].Prog,Data);
    cdsT611.Append;
    cdsT611.FieldByName('PROGRESSIVO').AsInteger:=Vista[i].Prog;
    cdsT611.FieldByName('MATRICOLA').AsString:=Vista[i].Matricola;
    cdsT611.FieldByName('NOMINATIVO').AsString:=Vista[i].Cognome + ' ' + Vista[i].Nome;
    cdsT611.FieldByName('SQUADRA').AsString:=Vista[i].Squadra;
    cdsT611.FieldByName('TIPO_OPERATORE').AsString:=Vista[i].TipoOpe.Replace('(','').Replace(')','');
    if Q620.RecordCount > 0 then
    begin
      DataRif:=Q620.FieldByName('Data').AsDateTime;
      Offset:=IfThen(DataRif <= Data,1,-1);
      GetTurnazione(Posizione);
      cdsT611.FieldByName('TURNAZIONE').AsString:=TurnazioneOld;
      if Posizione = 0 then
        cdsT611.FieldByName('POSIZIONE').AsInteger:=0
      else
      begin
        while DataRif <> Data do
        begin
          DataRif:=DataRif + Offset;
          Posizione:=Posizione + Offset;
          if Posizione >= Turno1.Count then
            Posizione:=1;
          if Posizione <=0 then
            Posizione:=Turno1.Count - 1;
        end;
        cdsT611.FieldByName('POSIZIONE').AsInteger:=Posizione;
        cdsT611.FieldByName('ORARIO').AsString:=Orario[Posizione];
        cdsT611.FieldByName('TURNO1').AsString:=Turno1[Posizione];
        cdsT611.FieldByName('TURNO2').AsString:=Turno2[Posizione];
      end;
    end;
    cdsT611.Post;
  end;
  cdsT611.First;
end;

function TA058FPianifTurniDtm1.OrdinamentoStampa:string;
var
  ListaOrdinamento:TStringList;
  i:integer;
begin
  ListaOrdinamento:=TStringList.Create;
  try
    ListaOrdinamento.CommaText:=selT082.FieldByName('ORD_STAMPA').AsString;
    Result:='';
    for i:=0 to ListaOrdinamento.Count - 1 do
    begin
      if not Result.IsEmpty and (i < ListaOrdinamento.Count) then
        Result:=Result + ';';
      if ListaOrdinamento[i] = 'N' then
        Result:=Result + 'Nome'
      else if ListaOrdinamento[i] = 'S' then
        Result:=Result + 'Operatore'
      else if ListaOrdinamento[i] = 'T' then
        Result:=Result + 'Partenza'
      else if ListaOrdinamento[i] = 'P' then
        Result:=Result + 'Turni0'
      else if ListaOrdinamento[i] = 'O' then
        Result:=Result + 'Orari0';
    end;
  finally
    FreeAndNil(ListaOrdinamento);
  end;
end;

procedure TA058FPianifTurniDtm1.CreateVarSpostamentoSquadra(Dts:TOracleDataSet);
begin
  Dts.DeclareAndSet('A058DATADA',otDate,DataInizio);
  Dts.DeclareAndSet('A058DATAA',otDate,DataFine);
  Dts.DeclareAndSet('A058SQUADRA',otString,SquadraRiferimento);
end;

procedure TA058FPianifTurniDtm1.ClearVarSpostamentoSquadra(Dts:TOracleDataSet);
begin
  if Dts.VariableIndex('A058SQUADRA') >= 0 then
  begin
    Dts.DeleteVariable('A058SQUADRA');
    Dts.DeleteVariable('A058DATADA');
    Dts.DeleteVariable('A058DATAA');
  end;
end;

procedure TA058FPianifTurniDtm1.EditSQLC700;
var
  Select, From, Where, Orderby, SQL:String;
  WhereT620,WhereXCambioSquadra:String;
  PosStart, PosEnd, i, iFAI:Integer;
  AggParentesiFine:Boolean;
  ListaOrdinamento,lst:TStringList;
begin
  if SalvaSQLOriginale <> '' then
    SelAnagrafeA058.SQL.Text:=SalvaSQLOriginale;
  //Cancello le variabili dichiarate per spostamento squadra
  ClearVarSpostamentoSquadra(SelAnagrafeA058);

  {Scompongo query selanagrafe in Select - From - Where - OrderBy}
  PosStart:=0;
  PosEnd:=pos(' FROM' + #13#10,SelAnagrafeA058.SubstitutedSQL);
  Select:=Copy(SelAnagrafeA058.SubstitutedSQL,PosStart,PosEnd);
  PosStart:=PosEnd;
  PosEnd:=pos(#13#10 + 'WHERE ',SelAnagrafeA058.SubstitutedSQL);
  From:=Copy(SelAnagrafeA058.SubstitutedSQL,PosStart, PosEnd - PosStart);
  PosStart:=PosEnd;
  PosEnd:=pos('ORDER BY',SelAnagrafeA058.SubstitutedSQL.ToUpper) - 1;
  if PosEnd > 0 then
    Where:=Copy(SelAnagrafeA058.SubstitutedSQL,PosStart,PosEnd - PosStart)
  else
    Where:=Copy(SelAnagrafeA058.SubstitutedSQL,PosStart,Length(SelAnagrafeA058.SubstitutedSQL));

  {Compongo la nuova query SQL in base ai parametri su T082}
  WhereT620:='';
  ListaOrdinamento:=TStringList.Create;
  try
    OrderBy:='';
    ListaOrdinamento.CommaText:=selT082.FieldByName('ORD_VIS').AsString;
    for i:=0 to ListaOrdinamento.Count - 1 do
    begin
      if not OrderBy.IsEmpty and (i < ListaOrdinamento.Count) then
        OrderBy:=OrderBy + ', ';
      if ListaOrdinamento[i] = 'T' then
      begin
        //Ordinamento per turno di partenza
        From:=From + ',T620_TURNAZIND T620';
        WhereT620:='and T620.PROGRESSIVO = T030.PROGRESSIVO and T620.DATA = (select max(T620.DATA) from T620_TURNAZIND T620 where T620.PROGRESSIVO = T030.PROGRESSIVO and T620.DATA <= to_date(''' + DateToStr(DataFine) + ''',''DD/MM/YYYY''))';
        OrderBy:=OrderBy + 'T620.PARTENZA';
      end;
      if ListaOrdinamento[i] = 'S' then
        //Ordinamento per squdra - operatore
        OrderBy:=OrderBy + 'V430.T430TIPOOPE';
      if ListaOrdinamento[i] = 'P' then
        //Ordinamento per turno
        OrderBy:=OrderBy + 'T080PCK_TURNO.GETNTURNO(T030.PROGRESSIVO,TO_DATE(''' + DateToStr(DataInizio) + ''',''DD/MM/YYYY''),''' +
                           IfThen(selT082.fieldByName('MODALITA_LAVORO').AsString = 'O','O','N') + ''')';
      if ListaOrdinamento[i] = 'N' then
        //ordinamento per cognome nome
        OrderBy:=OrderBy + 'T030.COGNOME, T030.NOME';
      if ListaOrdinamento[i] = 'O' then
        OrderBy:=OrderBy + 'T080PCK_TURNO.GETORARIO(T030.PROGRESSIVO,TO_DATE(''' + DateToStr(DataInizio) + ''',''DD/MM/YYYY''),''' +
                           IfThen(selT082.fieldByName('MODALITA_LAVORO').AsString = 'O','O','N') + ''')';
    end;

    if IncludiDipCambioSquadra then
    begin
      WhereXCambioSquadra:=' or exists (select ''X''' + CRLF +
                           '              from T630_SPOSTSQUADRA T630' + CRLF +
                           '             where T630.PROGRESSIVO = T030.PROGRESSIVO' + CRLF +
                           '               and T630.DATA between :A058DATADA and :A058DATAA' + CRLF +
                           '               and T630.SQUADRA = :A058SQUADRA)';
      lst:=TStringList.Create;
      try
        lst.Text:=Where;
        iFAI:=lst.IndexOf(TAG_FILTRO_ANAG_INIZIO); //Cerco il tag del filtro anagrafe, anche se vuoto
        AggParentesiFine:=Copy(Trim(lst.Text),Length(Trim(lst.Text))) = ')';
        lst.Insert(iFAI,IfThen(Copy(Trim(lst[iFAI - 1]),Length(Trim(lst[iFAI - 1])) - 2) <> 'AND','AND ') //Valuto se continuare le condizioni precedenti...
          + '((' //...apro tutte le eventuali condizioni successive...
          + IfThen(AggParentesiFine,'(')); //...tenendo conto di quelle già aperte.
        if lst.IndexOf(TAG_FILTRO_ANAG_FINE) - lst.IndexOf(TAG_FILTRO_ANAG_INIZIO) = 1 then //Se il filtro anagrafe è vuoto...
          lst.Insert(lst.IndexOf(TAG_FILTRO_ANAG_INIZIO) + 1,'1 = 1' //...aggiungo una condizione fittizia...
            + IfThen(    (Trim(Copy(lst.Text,Pos(TAG_FILTRO_ANAG_FINE,lst.Text) + Length(TAG_FILTRO_ANAG_FINE))) <> '') and
                         (Trim(Copy(lst.Text,Pos(TAG_FILTRO_ANAG_FINE,lst.Text) + Length(TAG_FILTRO_ANAG_FINE))) <> ')') and
                     not (Copy(Trim(Copy(lst.Text,Pos(TAG_FILTRO_ANAG_FINE,lst.Text) + Length(TAG_FILTRO_ANAG_FINE))),1,3) = 'AND')
                     ,' AND')); //...tenendo conto dell'eventuale selezione anagrafica dell'operatore.
        lst.Append(')'); //Chiudo le condizioni generali, quelle specifiche del filtro anagrafe e quelle specificate dalla selezione anagrafica
        lst.Append(WhereXCambioSquadra); //Aggiungo i dipendenti esterni ai precedenti filtri, ma da includere per via del cambio squadra
        lst.Append(')' + IfThen(AggParentesiFine,')')); //Chiudo tutte le condizioni
        Where:=lst.Text;
        CreateVarSpostamentoSquadra(SelAnagrafeA058);
      finally
        FreeAndNil(Lst);
      end;
    end;
    if WhereT620 <> '' then
      Where:=Where.TrimRight + CRLF + WhereT620;

    SQL:=Select + From + Where + CRLF + 'order by V430.T430SQUADRA' + IfThen(OrderBy <> '',', ' + OrderBy);
    //Prima di sostituire l'SQL lo salvo in una variabile
    SalvaSQLOriginale:=SelAnagrafeA058.SQL.Text;
    SelAnagrafeA058.SQL.Text:=SQL;
  finally
    FreeAndNil(ListaOrdinamento);
  end;
end;

function TA058FPianifTurniDtm1.GetSquadraPiuAssegnata(SquadraIniziale:String):String;
var
  Str:String;
begin
  Result:=SquadraIniziale;
  Str:='';
  SelAnagrafeA058.First;
  while Not SelAnagrafeA058.Eof and (SelAnagrafeA058.RecNo <= 1000) do
  begin
    Str:=Str + SelAnagrafeA058.FieldByName('PROGRESSIVO').AsString;
    SelAnagrafeA058.Next;
    if Not SelAnagrafeA058.Eof and (SelAnagrafeA058.RecNo <= 1000) then
      Str:=Str + ','
  end;
  selT430.Close;
  if Str <> '' then
  begin
    Str:='AND T430.PROGRESSIVO IN (' + Str + ')';
    selT430.SetVariable('FILTRO',Str);
  end;
  selT430.Open;
  if (selT430.FieldByName('SQUADRA').AsString <> '')
  and (VarToStr(selT603.Lookup('CODICE',selT430.FieldByName('SQUADRA').AsString,'CODICE')) = selT430.FieldByName('SQUADRA').AsString) then
    Result:=selT430.FieldByName('SQUADRA').AsString;
end;

function TA058FPianifTurniDtm1.GetDatoPiuAssegnato(Campo:String;Data:TDateTime):String;
var
  Str:String;
begin
  Result:='';
  Str:='';
  SelAnagrafeA058.First;
  while Not SelAnagrafeA058.Eof and (SelAnagrafeA058.RecNo <= 1000) do
  begin
    Str:=Str + SelAnagrafeA058.FieldByName('PROGRESSIVO').AsString;
    SelAnagrafeA058.Next;
    if Not SelAnagrafeA058.Eof and (SelAnagrafeA058.RecNo <= 1000) then
      Str:=Str + ','
  end;
  selT430B.Close;
  selT430B.SetVariable('CAMPO',Campo);
  selT430B.SetVariable('DATA',Data);
  selT430B.SetVariable('FILTRO',Str);
  selT430B.Open;
  if selT430B.FieldByName('CAMPO').AsString <> '' then
    Result:=selT430B.FieldByName('CAMPO').AsString;
end;

procedure TA058FPianifTurniDtm1.RefreshReperibilità;
var
  i,j:integer;
begin
  selT380.Close;
  selT380.SetVariable('DATADA',DataInizio);
  selT380.SetVariable('DATAA',DataFine);
  for i:=0 to Vista.Count - 1 do
  begin
    R180SetVariable(selT380,'PROGRESSIVO',Vista[i].Prog);
    selT380.Open;
    for j:=0 to Vista[i].Giorni.Count - 1 do
    begin
      // (Gallizio 2017-09-13): ripulisco i turni per il giorno corrente
      Vista[i].Giorni[j].ClearTurniRep;
      if (selT380.FieldByName('DATA').AsDateTime = Vista[i].Giorni[j].Data) or
         selT380.SearchRecord('DATA',Vista[i].Giorni[j].Data,[srFromCurrent]) then
      begin
        // dati turno 1
        Vista[i].Giorni[j].TurniRep[1].Turno:=selT380.FieldByName('TURNO1').AsString;
        Vista[i].Giorni[j].TurniRep[1].Sigla:=selT380.FieldByName('SIGLA').AsString;
        Vista[i].Giorni[j].TurniRep[1].OraInizio:=selT380.FieldByName('ORAINIZIO').AsString;
        Vista[i].Giorni[j].TurniRep[1].OraFine:=selT380.FieldByName('ORAFINE').AsString;
        // dati turno 2
        Vista[i].Giorni[j].TurniRep[2].Turno:=selT380.FieldByName('TURNO2').AsString;
        Vista[i].Giorni[j].TurniRep[2].Sigla:=selT380.FieldByName('SIGLA2').AsString;
        Vista[i].Giorni[j].TurniRep[2].OraInizio:=selT380.FieldByName('ORAINIZIO2').AsString;
        Vista[i].Giorni[j].TurniRep[2].OraFine:=selT380.FieldByName('ORAFINE2').AsString;
        // dati turno 3
        Vista[i].Giorni[j].TurniRep[3].Turno:=selT380.FieldByName('TURNO3').AsString;
        Vista[i].Giorni[j].TurniRep[2].Sigla:=selT380.FieldByName('SIGLA3').AsString;
        Vista[i].Giorni[j].TurniRep[3].OraInizio:=selT380.FieldByName('ORAINIZIO3').AsString;
        Vista[i].Giorni[j].TurniRep[3].OraFine:=selT380.FieldByName('ORAFINE3').AsString;
      end;
    end;
  end;
end;

procedure TA058FPianifTurniDtm1.PianificaDipendente(Prog:LongInt);
var
  Posizione:LongInt;
  DataCorr:TDateTime;
  DipendenteTemp:TDipendente;
  Badge:Integer;
  VisualizzaDip:Boolean;
begin
  RegistraMsg.IniziaMessaggio('A058');
  if not GetPartenza(Prog,Posizione) then
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A058_ERR_NO_PIANIFICAZIONE,[SelAnagrafeA058.FieldByName('Cognome').AsString + ' ' +
                                                                                  SelAnagrafeA058.FieldByName('Nome').AsString]));
    {raise exception.Create(Format(A000MSG_A058_ERR_NO_PIANIFICAZIONE,[SelAnagrafeA058.FieldByName('Cognome').AsString + ' ' +
                                                                      SelAnagrafeA058.FieldByName('Nome').AsString]));}
  try
    if SelAnagrafeA058.FindField('T430Badge') <> nil then
      Badge:=SelAnagrafeA058.FieldByName('T430Badge').AsInteger
    else
      Badge:=0;
  except
    Badge:=0;
  end;
  DipendenteTemp:=CreaDipendente(SelAnagrafeA058.FieldByName('Progressivo').AsInteger,
                                 Badge,
                                 SelAnagrafeA058.FieldByName('Matricola').AsString,
                                 SelAnagrafeA058.FieldByName('Cognome').AsString,
                                 SelAnagrafeA058.FieldByName('Nome').AsString);
  //Apertura DataSet per visualizzazione turni di reperibilità
  selT380.Close;
  selT380.SetVariable('PROGRESSIVO',Prog);
  selT380.SetVariable('DATADA',DataInizio);
  selT380.SetVariable('DATAA',DataFine);
  selT380.Open;
  QSSquadra.GetDatiStorici('T430SQUADRA,T430D_SQUADRA,T430CALENDARIO,T430TIPOOPE,T430TGESTIONE,T430INIZIO,T430FINE',Prog,DataInizio,DataFine);
  DataCorr:=DataInizio;
  VisualizzaDip:=False;
  {*VisualizzaDip* verifica che il dipendente abbia almeno un giorno pianificato nel periodo
   se no non inserisce il dipendente nella lista(non lo visualizza)}
  while DataCorr <= DataFine do
  begin
    //Se trovo una turnazione successiva ricalcolo lo sviluppo del ciclo e
    //la posizione di partenza
    if DataCorr >= TurnazSucc then
    begin
      GetAssegnazioneTurnazione(SelAnagrafeA058.FieldByName('PROGRESSIVO').AsInteger,DataCorr);
      GetTurnazione(Posizione);
    end;
    CreaGiorno(DipendenteTemp,DataCorr,Posizione);
    //if DipendenteTemp.Giorni[DipendenteTemp.Giorni.Count - 1].Flag <> 'NT' then
    if DipendenteTemp.Giorni[DipendenteTemp.Giorni.Count - 1].Squadra = SquadraRiferimento then
      VisualizzaDip:=True;
    //Incremento posizione sui cicli e data corrente
    if Posizione > 0 then
      begin
      Posizione:=Posizione + 1;
      if Posizione >= Turno1.Count then
        Posizione:=1;
      end;
    DataCorr:=DataCorr + 1;
  end;
  if VisualizzaDip then
    Vista.Add(DipendenteTemp)
  else
    FreeAndNil(DipendenteTemp)
end;

procedure TA058FPianifTurniDtm1.PulisciVista;
{Pulisce la Lista VISTA liberando la memoria allocata per ogni Elemento TDipendente}
begin
  OffsetVista:=0;
  Vista.Clear;
  SetLength(TotGio,0);
  SetLength(TotTabGio,0);
  Vista.pModificato:=False;
end;

procedure TA058FPianifTurniDtm1.PulisciDipSostituto;
begin
  DipSostituto.Progressivo:=-1;
  DipSostituto.Badge:=0;
  DipSostituto.Matricola:='';
  DipSostituto.Cognome:='';
  DipSostituto.Nome:='';
  DipSostituto.Pianificato:=False;
  DipSostituto.Squadra:='';
  DipSostituto.TipoOpe:='';
end;

procedure TA058FPianifTurniDtM1.Q020AfterOpen(DataSet: TDataSet);
begin
  Q020.FieldByName('CODICE').DisplayWidth:=7;
end;

procedure TA058FPianifTurniDtM1.ReadBufferBeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA058FPianifTurniDtM1.Q265BBeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA058FPianifTurniDtM1.Q265BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA058FPianifTurniDtm1.InizializzaGiorno(MyDip:TDipendente; iGg:Integer);
var iOp:Integer;
begin
  if High(TotGio) < iGg then
  begin
    SetLength(TotGio,iGg + 1);
    SetLength(TotGio[iGg].Operatori,0);
    TotGio[iGg].OreLiquid:=0;

    //Recupero tutte le condizioni min/max del giorno e le carico per ogni operatore e sigla
    R180SetVariable(selT606b,'PROGRESSIVO',-1); //Non individuale
    R180SetVariable(selT606b,'COD_SQUADRA',SquadraRiferimento);
    R180SetVariable(selT606b,'COD_ORARIO','*'); //Tutti gli orari
    R180SetVariable(selT606b,'COD_CONDIZIONE','00001'); //Numero teste
    selT606b.Open;
    try
      FiltraT606(selT606b,MyDip.Giorni[iGg].Data,'00001',A058PCKT080TURNO.CalcolaTipoGiorno(MyDip.Prog,MyDip.Giorni[iGg].Data,'S'));
      if selT606b.RecordCount = 0 then
        FiltraT606(selT606b,MyDip.Giorni[iGg].Data,'00001',IntToStr(DayOfWeek(MyDip.Giorni[iGg].Data - 1)));
      if selT606b.RecordCount = 0 then
        FiltraT606(selT606b,MyDip.Giorni[iGg].Data,'00001','*');
      while not selT606b.Eof do
      begin
        //TotTabGio serve a esporre in maniera ordinata i dati degli array dei totali
        iOp:=InizializzaOperatore(selT606b.FieldByName('COD_TIPOOPE').AsString,TotGio[iGg].Operatori);
        InizializzaSigla(MyDip,iGg,selT606b.FieldByName('COD_TIPOOPE').AsString,selT606b.FieldByName('SIGLA_TURNO').AsString,TotGio[iGg].Operatori[iOp].Sigle,True);
        AggiornaTotGenGio(TotTabGio,selT606b.FieldByName('COD_TIPOOPE').AsString,selT606b.FieldByName('SIGLA_TURNO').AsString,-1,0,0,False,True);
        selT606b.Next;
      end;
    finally
      selT606b.Filtered:=False;
  end;
  end;
end;

function TA058FPianifTurniDtm1.InizializzaOperatore(Operatore:String; var arrOperatori:TArrOperatori):Integer;
var TrovOp:Boolean;
    iOp:Integer;
begin
  iOp:=-1;
  Result:=iOp;
  TrovOp:=False;
  for iOp:=Low(arrOperatori) to High(arrOperatori) do
    if arrOperatori[iOp].Operatore = Operatore then
    begin
      TrovOp:=True;
      Result:=iOp;
      Break;
    end;
  if not TrovOp then
  begin
    SetLength(arrOperatori,Length(arrOperatori) + 1);
    iOp:=High(arrOperatori);
    Result:=iOp;
    arrOperatori[iOp].Operatore:=Operatore;
    arrOperatori[iOp].Totale:=0;
    SetLength(arrOperatori[iOp].Sigle,0);
  end;
end;

function TA058FPianifTurniDtm1.InizializzaSigla(MyDip:TDipendente; iGg:Integer; Operatore,SiglaTurno:String; var arrSigle:TArrSigle; PrelevaMinMax:Boolean):Integer;
var TrovSg:Boolean;
    iSg:Integer;
begin
  iSg:=-1;
  Result:=iSg;
  TrovSg:=False;
  for iSg:=Low(arrSigle) to High(arrSigle) do
    if arrSigle[iSg].Sigla = SiglaTurno then
    begin
      TrovSg:=True;
      Result:=iSg;
      Break;
    end;
  if not TrovSg then
  begin
    SetLength(arrSigle,Length(arrSigle) + 1);
    iSg:=High(arrSigle);
    Result:=iSg;
    arrSigle[iSg].Sigla:=SiglaTurno;
    arrSigle[iSg].Min:='-';
    arrSigle[iSg].Max:='-';
    arrSigle[iSg].Totale:=0;
    if PrelevaMinMax then
    begin
      //Recupero i massimi e i minimi
      R180SetVariable(selT606,'PROGRESSIVO',-1); //Non individuale
      R180SetVariable(selT606,'COD_ORARIO','*'); //Tutti gli orari
      R180SetVariable(selT606,'COD_SQUADRA',SquadraRiferimento);
      R180SetVariable(selT606,'COD_TIPOOPE',Operatore);
      selT606.Open;
      FiltraT606(selT606,MyDip.Giorni[iGg].Data,'00001',A058PCKT080TURNO.CalcolaTipoGiorno(MyDip.Prog,MyDip.Giorni[iGg].Data,'S'));
      if selT606.RecordCount = 0 then
        FiltraT606(selT606,MyDip.Giorni[iGg].Data,'00001',IntToStr(DayOfWeek(MyDip.Giorni[iGg].Data - 1)));
      if selT606.RecordCount = 0 then
        FiltraT606(selT606,MyDip.Giorni[iGg].Data,'00001','*');
      if selT606.SearchRecord('SIGLA_TURNO',SiglaTurno,[srFromBeginning]) then
      begin
        arrSigle[iSg].Min:=IntToStr(selT606.FieldByName('MINIMO').AsInteger);
        arrSigle[iSg].Max:=IntToStr(selT606.FieldByName('MASSIMO').AsInteger);
      end;
    end;
  end;
end;

function TA058FPianifTurniDtm1.EsisteRiposo(ValNumTurno1,ValT1,ValT1EU,ValAss1,ValNumTurno2,ValT2,ValAss2:String):Boolean;
begin
  //Turno di riposo 1
  Result:=(ValNumTurno1 = '') and (Trim(ValT1) = '0');
  //Turno di riposo 2
  Result:=Result or ((ValNumTurno2 = '') and (Trim(ValT2) = '0'));
  //Esiste pianificazione di smonto notte
  Result:=Result or ((ValNumTurno1 = '') and (ValT1EU = 'U') and (ValNumTurno2 = ''));
  //Causale di riposo non compensativo 1
  Result:=Result or (TestRiposo(ValAss1) and not TestRiposoComp(ValAss1));
  //Causale di riposo non compensativo 2
  Result:=Result or (TestRiposo(ValAss2) and not TestRiposoComp(ValAss2));
end;

procedure TA058FPianifTurniDtm1.AggiornaTotaleTurni(MyDip:TDipendente; iGg:Integer; ValPrecedenti:Boolean);
var iOp,iSg,iTr,MinutiEntrata:Integer;
    ValMinutiEntrata1,ValMinutiEntrata2:Integer;
    ValNumTurno1,ValSiglaT1,ValT1,ValT1EU,ValAss1,
    ValOperatore,ValNumTurno2,ValSiglaT2,ValT2,ValAss2:String;
    NumTurno,SiglaTurno:String;
begin
  //Adeguo l'array dei totali giornalieri
  InizializzaGiorno(MyDip,iGg);

  //Decido se per i controlli devo usare i...
  if ValPrecedenti then //...valori precedenti...
  begin
    ValOperatore:=sOperatore;
    ValNumTurno1:=sNumTurno1;
    ValSiglaT1:=sSiglaT1;
    ValMinutiEntrata1:=-1;
    ValT1:=sT1;
    ValT1EU:=sT1EU;
    ValAss1:=sAss1;
    ValNumTurno2:=sNumTurno2;
    ValSiglaT2:=sSiglaT2;
    ValMinutiEntrata2:=-1;
    ValT2:=sT2;
    ValAss2:=sAss2;
  end
  else //...o i valori correnti
  begin
    ValOperatore:=MyDip.Giorni[iGg].Oper;
    ValNumTurno1:=MyDip.Giorni[iGg].NumTurno1;
    ValSiglaT1:=MyDip.Giorni[iGg].SiglaT1;
    ValMinutiEntrata1:=MyDip.Giorni[iGg].MinutiEntrata1;
    ValT1:=MyDip.Giorni[iGg].T1;
    ValT1EU:=MyDip.Giorni[iGg].T1EU;
    ValAss1:=MyDip.Giorni[iGg].Ass1;
    ValNumTurno2:=MyDip.Giorni[iGg].NumTurno2;
    ValSiglaT2:=MyDip.Giorni[iGg].SiglaT2;
    ValMinutiEntrata2:=MyDip.Giorni[iGg].MinutiEntrata2;
    ValT2:=MyDip.Giorni[iGg].T2;
    ValAss2:=MyDip.Giorni[iGg].Ass2;

    //Svuoto il dettaglio giornaliero del dipendente
    MyDip.Giorni[iGg].DetDip.Riposi:=0;
    SetLength(MyDip.Giorni[iGg].DetDip.Operatori,0);
  end;

  //Se c'è un riposo...
  if EsisteRiposo(ValNumTurno1,ValT1,ValT1EU,ValAss1,ValNumTurno2,ValT2,ValAss2) then
  begin
    //Adeguo solo i riposi del dipendente (non esiste il totale dei riposi del giorno)
    if not ValPrecedenti then //...valori correnti...
      //Imposto il dettaglio giornaliero dei riposi del dipendente
      AggiornaRipDip(MyDip.Giorni[iGg].DetDip,IfThen(ValPrecedenti,0,1),IfThen(ValPrecedenti,1,0));
    //Adeguo il totale dei riposi del dipendente
    AggiornaRipDip(MyDip.TotDip,IfThen(ValPrecedenti,0,1),IfThen(ValPrecedenti,1,0));
  end
  //...altrimenti, se non ci sono assenze...
  else if not (TestAssenza(ValAss1) or TestAssenza(ValAss2)) then
    for iTr:=1 to 2 do
    begin
      NumTurno:=IfThen(iTr = 1,ValNumTurno1,ValNumTurno2);
      SiglaTurno:=IfThen(iTr = 1,ValSiglaT1,ValSiglaT2);
      MinutiEntrata:=IfThen(iTr = 1,ValMinutiEntrata1,ValMinutiEntrata2);
      if (NumTurno <> '') then
      begin
        SiglaTurno:=SiglaTurno.Replace('(','').Replace(')','').Trim;

        if not ValPrecedenti then //...valori correnti...
        begin
          //Imposto l'array dei tipi operatori del dettaglio giornaliero individuale
          iOp:=InizializzaOperatore(ValOperatore,MyDip.Giorni[iGg].DetDip.Operatori);//restituisce iOp in base a ValOperatore
          //Imposto il totale dell'operatore del dettaglio giornaliero del dipendente
          AggiornaTotOpe(MyDip.Giorni[iGg].DetDip.Operatori[iOp].Totale,IfThen(ValPrecedenti,0,1),IfThen(ValPrecedenti,1,0));
          //Imposto l'array delle sigle turno dei tipi operatori del dettaglio giornaliero individuale
          iSg:=InizializzaSigla(MyDip,iGg,ValOperatore,SiglaTurno,MyDip.Giorni[iGg].DetDip.Operatori[iOp].Sigle,False);//restituisce iSg in base a SiglaTurno
          //Imposto il totale della sigla turno dei tipi operatori del dettaglio giornaliero del dipendente
          AggiornaTotDip(MyDip.Giorni[iGg].DetDip.Operatori[iOp].Sigle,iSg,IfThen(ValPrecedenti,0,1),IfThen(ValPrecedenti,1,0));
        end;

        //Adeguo l'array dei tipi operatori dei totali individuali
        iOp:=InizializzaOperatore(ValOperatore,MyDip.TotDip.Operatori);//restituisce iOp in base a ValOperatore
        //Adeguo il totale dell'operatore del dipendente
        AggiornaTotOpe(MyDip.TotDip.Operatori[iOp].Totale,IfThen(ValPrecedenti,0,1),IfThen(ValPrecedenti,1,0));
        //Adeguo l'array delle sigle turno dei tipi operatori dei totali individuali
        iSg:=InizializzaSigla(MyDip,iGg,ValOperatore,SiglaTurno,MyDip.TotDip.Operatori[iOp].Sigle,False);//restituisce iSg in base a SiglaTurno
        //Adeguo il totale della sigla turno dei tipi operatori del dipendente
        AggiornaTotDip(MyDip.TotDip.Operatori[iOp].Sigle,iSg,IfThen(ValPrecedenti,0,1),IfThen(ValPrecedenti,1,0));

        //Adeguo l'array dei tipi operatori dei totali giornalieri
        iOp:=InizializzaOperatore(ValOperatore,TotGio[iGg].Operatori);//restituisce iOp in base a ValOperatore
        //Adeguo il totale dell'operatore del giorno
        AggiornaTotOpe(TotGio[iGg].Operatori[iOp].Totale,IfThen(ValPrecedenti,0,1),IfThen(ValPrecedenti,1,0));
        //Adeguo l'array delle sigle turno dei tipi operatori dei totali giornalieri
        iSg:=InizializzaSigla(MyDip,iGg,ValOperatore,SiglaTurno,TotGio[iGg].Operatori[iOp].Sigle,True);//restituisce iSg in base a SiglaTurno e recupera Min/Max
        //Adeguo il totale della sigla turno del tipo operatore del giorno
        AggiornaTotGio(TotGio[iGg].Operatori[iOp].Sigle,iSg,IfThen(ValPrecedenti,0,1),IfThen(ValPrecedenti,1,0));

        //Adeguo l'elenco delle sigle degli operatori e i rispettivi totali, per poi visualizzarli in ordine
        AggiornaTotGenGio(TotTabGio,ValOperatore,SiglaTurno,MinutiEntrata,IfThen(ValPrecedenti,0,1),IfThen(ValPrecedenti,1,0),False,False);
      end;
    end;
end;

procedure TA058FPianifTurniDtm1.AggiornaRipDip(var TotDip:TTotDip; ValInc,ValDec:Integer);
begin
  TotDip.Riposi:=TotDip.Riposi + ValInc - ValDec;
end;

procedure TA058FPianifTurniDtm1.AggiornaTotOpe(var TotOpe:Integer; ValInc,ValDec:Integer);
begin
  TotOpe:=TotOpe + ValInc - ValDec;
end;

procedure TA058FPianifTurniDtm1.AggiornaTotDip(var arrSigle:TArrSigle; iSg:Integer; ValInc,ValDec:Integer);
var iApp:Integer;
begin
  arrSigle[iSg].Totale:=arrSigle[iSg].Totale + ValInc - ValDec;
  //Spostamento: scatta quando devo cancellare una sigla perché senza turni assegnati
  //NON DEVE TENERE CONTO DEL RISPETTIVO VALORE DI TotTabGio[ixx].VisualizzaSempre, DIVERSAMENTE DA AggiornaTotGenGio)
  if arrSigle[iSg].Totale = 0 then
  begin
    //copio i dati del record successivo su quello corrente fino al penultimo
    for iApp:=iSg to High(arrSigle) - 1 do
    begin
      arrSigle[iApp].Sigla:=arrSigle[iApp + 1].Sigla;
      arrSigle[iApp].Min:=arrSigle[iApp + 1].Min;
      arrSigle[iApp].Max:=arrSigle[iApp + 1].Max;
      arrSigle[iApp].Totale:=arrSigle[iApp + 1].Totale;
    end;
    //elimino l'ultimo record (ormai uguale al penultimo)
    SetLength(arrSigle,Length(arrSigle) - 1);
  end;
end;

procedure TA058FPianifTurniDtm1.AggiornaTotGio(var arrSigle:TArrSigle; iSg:Integer; ValInc,ValDec:Integer);
begin
  arrSigle[iSg].Totale:=arrSigle[iSg].Totale + ValInc - ValDec;
  //Spostamento: scatta quando devo cancellare una sigla perché senza turni assegnati
  //PER ORA NON CE N'E' BISOGNO MA, NEL CASO, BISOGNERA' TENERE CONTO DEL RISPETTIVO VALORE DI TotTabGio[ixx].VisualizzaSempre, COME IN AggiornaTotGenGio
  //EVENTUALMENTE VERIFICARE SE FONDERE CON AggiornaTotDip, PASSANDO UN PARAMETRO PER GESTIRE LA DIFFERENZA IN RELAZIONE A TotTabGio[ixx].VisualizzaSempre
end;

procedure TA058FPianifTurniDtm1.AggiornaTotGenGio(var arrTotali:TArrTotGenGio; sOper,sSigla:String;nMinutiEntrata,ValInc,ValDec:Integer;TotOpe,VisSempre:Boolean);
var iSgOp,iApp:Integer;
    TrovSiglaOper:Boolean;
    arrAppoggio:TArrTotGenGio;
    SLSgOp:TStringList;
begin
  TrovSiglaOper:=False;
  for iSgOp:=Low(arrTotali) to High(arrTotali) do
    if (arrTotali[iSgOp].Operatore = sOper)
    and (arrTotali[iSgOp].Sigla = sSigla) then
    begin
      TrovSiglaOper:=True;
      //Aggiorno i totali
      arrTotali[iSgOp].Totale:=arrTotali[iSgOp].Totale + ValInc - ValDec;
      if arrTotali[iSgOp].OraEntrata = '-00.01' then //non l'avevo precedentemente impostato, ma avevo passato nMinutiEntrata:=-1
        arrTotali[iSgOp].OraEntrata:=R180MinutiOre(nMinutiEntrata);
      if VisSempre and arrTotali[iSgOp].TotaleOperatore then //almeno una delle sigle dell'operatore è da mostrare sempre, quindi mostro sempre il totale
        arrTotali[iSgOp].VisualizzaSempre:=True;
      Break;
    end;
  if not TrovSiglaOper then
  begin
    //Aggiunta del binomio e delle sue proprietà, compresi i totali
    SetLength(arrTotali,Length(arrTotali) + 1);
    iSgOp:=High(arrTotali);
    arrTotali[iSgOp].Operatore:=sOper;
    arrTotali[iSgOp].Sigla:=sSigla;
    arrTotali[iSgOp].TotaleOperatore:=TotOpe;
    arrTotali[iSgOp].VisualizzaSempre:=VisSempre;
    arrTotali[iSgOp].OraEntrata:=R180MinutiOre(nMinutiEntrata);
    arrTotali[iSgOp].Totale:=ValInc;
    //Ordinamento: scatta quando inserisco una nuova sigla
    if Length(arrTotali) > 1 then
    begin
      SLSgOp:=TStringList.Create;
      SetLength(arrAppoggio,Length(arrTotali));
      try
        //scorro i valori dell'array originale
        for iSgOp:=Low(arrTotali) to High(arrTotali) do
        begin
          //carico una stringlist per ordinare la chiave
          SLSgOp.Add(arrTotali[iSgOp].Operatore + '.' + arrTotali[iSgOp].OraEntrata + '.' + arrTotali[iSgOp].Sigla);
          //creo una copia dell'array
          arrAppoggio[iSgOp].Operatore:=arrTotali[iSgOp].Operatore;
          arrAppoggio[iSgOp].Sigla:=arrTotali[iSgOp].Sigla;
          arrAppoggio[iSgOp].TotaleOperatore:=arrTotali[iSgOp].TotaleOperatore;
          arrAppoggio[iSgOp].VisualizzaSempre:=arrTotali[iSgOp].VisualizzaSempre;
          arrAppoggio[iSgOp].OraEntrata:=arrTotali[iSgOp].OraEntrata;
          arrAppoggio[iSgOp].Totale:=arrTotali[iSgOp].Totale;
          //svuoto i valori dell'array originale
          arrTotali[iSgOp].Operatore:='';
          arrTotali[iSgOp].Sigla:='';
          arrTotali[iSgOp].TotaleOperatore:=False;
          arrTotali[iSgOp].VisualizzaSempre:=False;
          arrTotali[iSgOp].OraEntrata:='';
          arrTotali[iSgOp].Totale:=0;
        end;
        //ordino la chiave
        SLSgOp.Sort;
        //scorro la chiave ordinata
        for iSgOp:=0 to SLSgOp.Count - 1 do
          for iApp:=Low(arrAppoggio) to High(arrAppoggio) do
            if arrAppoggio[iApp].Operatore + '.' + arrAppoggio[iApp].OraEntrata + '.' + arrAppoggio[iApp].Sigla = SLSgOp[iSgOp] then
            begin
              //ricarico in maniera ordinata l'array originale
              arrTotali[iSgOp].Operatore:=arrAppoggio[iApp].Operatore;
              arrTotali[iSgOp].Sigla:=arrAppoggio[iApp].Sigla;
              arrTotali[iSgOp].TotaleOperatore:=arrAppoggio[iApp].TotaleOperatore;
              arrTotali[iSgOp].VisualizzaSempre:=arrAppoggio[iApp].VisualizzaSempre;
              arrTotali[iSgOp].OraEntrata:=arrAppoggio[iApp].OraEntrata;
              arrTotali[iSgOp].Totale:=arrAppoggio[iApp].Totale;
              Break;//passo al valore successivo della chiave
            end;
      finally
        FreeAndNil(SLSgOp);
        SetLength(arrAppoggio,0);
      end;
    end;
  end
  //Spostamento: scatta quando devo cancellare una sigla perché senza turni assegnati e senza visualizzazione obbligatoria
  else if (arrTotali[iSgOp].Totale = 0) and not arrTotali[iSgOp].VisualizzaSempre then
  begin
    //copio i dati del record successivo su quello corrente fino al penultimo
    for iApp:=iSgOp to High(arrTotali) - 1 do
    begin
      arrTotali[iApp].Operatore:=arrTotali[iApp + 1].Operatore;
      arrTotali[iApp].Sigla:=arrTotali[iApp + 1].Sigla;
      arrTotali[iApp].TotaleOperatore:=arrTotali[iApp + 1].TotaleOperatore;
      arrTotali[iApp].VisualizzaSempre:=arrTotali[iApp + 1].VisualizzaSempre;
      arrTotali[iApp].OraEntrata:=arrTotali[iApp + 1].OraEntrata;
      arrTotali[iApp].Totale:=arrTotali[iApp + 1].Totale;
    end;
    //elimino l'ultimo record (ormai uguale al penultimo)
    SetLength(arrTotali,Length(arrTotali) - 1);
  end;

  //Totali a livello di operatore (anche se viene conteggiato in un altro punto, corrisponde a Operatori[indice].Totale)
  if not TotOpe then //evito il loop in stack overflow
    AggiornaTotGenGio(arrTotali,sOper,'ZZZTOT'(*sigla fittizia per stare in fondo*),5999(*99:99 ora fittizia per stare in fondo*),ValInc,ValDec,True,VisSempre);
end;

procedure TA058FPianifTurniDtm1.AggiornaTotPagGio(IndiceGiornoPartenza,NumeroGiorni:Integer);
var iSgOp,iGG,iOp,iSg:Integer;
    SgOpTrov:Boolean;
begin
  SetLength(TotPagGio,0);
  for iSgOp:=Low(TotTabGio) to High(TotTabGio) do //scorro i totali ordinati a livello di tabellone
    for iGG:=IndiceGiornoPartenza to IndiceGiornoPartenza + NumeroGiorni do //scorro i giorni della pagina
    begin
      SgOpTrov:=False;
      for iOp:=Low(TotGio[iGG].Operatori) to High(TotGio[iGG].Operatori) do //scorro gli operatori del giorno
        if TotGio[iGG].Operatori[iOp].Operatore = TotTabGio[iSgOp].Operatore then //se l'operatore corrisponde
        begin
          for iSg:=Low(TotGio[iGG].Operatori[iOp].Sigle) to High(TotGio[iGG].Operatori[iOp].Sigle) do //scorro le sigle dell'operatore del giorno
            if TotGio[iGG].Operatori[iOp].Sigle[iSg].Sigla = TotTabGio[iSgOp].Sigla then //se la sigla corrisponde
            begin
              if (TotGio[iGG].Operatori[iOp].Sigle[iSg].Totale > 0) or TotTabGio[iSgOp].VisualizzaSempre then //se è significativa
                //Incremento i totali della pagina
                AggiornaTotGenGio(TotPagGio,TotTabGio[iSgOp].Operatore,TotTabGio[iSgOp].Sigla,R180OreMinuti(TotTabGio[iSgOp].OraEntrata),TotGio[iGG].Operatori[iOp].Sigle[iSg].Totale,0,False,TotTabGio[iSgOp].VisualizzaSempre);
              SgOpTrov:=True;
              Break; //esce dal ciclo delle sigle
            end;
          if SgOpTrov then
            Break; //esce dal ciclo degli operatori
        end;
    end;
end;

procedure TA058FPianifTurniDtm1.AggiornaTotPagDip(MyDip:TDipendente; IndiceGiornoPartenza,NumeroGiorni:Integer);
var iSgOp,iGG,iOp,iSg:Integer;
    SgOpTrov:Boolean;
begin
  SetLength(TotPagDip,0);
  for iSgOp:=Low(TotTabGio) to High(TotTabGio) do //scorro i totali ordinati a livello di tabellone
    for iGG:=IndiceGiornoPartenza to IndiceGiornoPartenza + NumeroGiorni do //scorro i giorni della pagina
    begin
      SgOpTrov:=False;
      for iOp:=Low(MyDip.Giorni[iGG].DetDip.Operatori) to High(MyDip.Giorni[iGG].DetDip.Operatori) do //scorro gli operatori del giorno
        if MyDip.Giorni[iGG].DetDip.Operatori[iOp].Operatore = TotTabGio[iSgOp].Operatore then //se l'operatore corrisponde
        begin
          for iSg:=Low(MyDip.Giorni[iGG].DetDip.Operatori[iOp].Sigle) to High(MyDip.Giorni[iGG].DetDip.Operatori[iOp].Sigle) do //scorro le sigle dell'operatore del giorno
            if MyDip.Giorni[iGG].DetDip.Operatori[iOp].Sigle[iSg].Sigla = TotTabGio[iSgOp].Sigla then //se la sigla corrisponde
            begin
              if (MyDip.Giorni[iGG].DetDip.Operatori[iOp].Sigle[iSg].Totale > 0) or TotTabGio[iSgOp].VisualizzaSempre then //se è significativa
                //Incremento i totali della pagina
                AggiornaTotGenGio(TotPagDip,TotTabGio[iSgOp].Operatore,TotTabGio[iSgOp].Sigla,R180OreMinuti(TotTabGio[iSgOp].OraEntrata),MyDip.Giorni[iGG].DetDip.Operatori[iOp].Sigle[iSg].Totale,0,False,TotTabGio[iSgOp].VisualizzaSempre);
              SgOpTrov:=True;
              Break; //esce dal ciclo delle sigle
            end;
          if SgOpTrov then
            Break; //esce dal ciclo degli operatori
        end;
    end;
end;

function TA058FPianifTurniDtm1.GetSimboloOperatore(Operatore,Sigla:String;ArrCercaSigla:TArrTotGenGio):String;
var iSmOp,iSgOp,nSg:Integer;
    sOldOp,sSmUsati,sSmOp:String;
const
  SimboliOperatori:String = '"^°@#§£$';
begin
  Result:='';
  sOldOp:='';
  sSmUsati:='';
  nSg:=0;
  if Sigla <> '' then
  begin
    for iSgOp:=Low(ArrCercaSigla) to High(ArrCercaSigla) do
      if ArrCercaSigla[iSgOp].Sigla = Sigla then
        inc(nSg);
    if nSg <= 1 then
      Exit;
  end;
  for iSgOp:=Low(TotPagGio) to High(TotPagGio) do
  begin
    sSmOp:=Trim(LowerCase(Copy(TotPagGio[iSgOp].Operatore,1,1)));
    if TotPagGio[iSgOp].Operatore = Operatore then
    begin
      if (sSmOp <> '') and (Pos(sSmOp,sSmUsati) = 0) then
        Result:=sSmOp
      else
        for iSmOp:=1 to Length(SimboliOperatori) do
          if Pos(SimboliOperatori[iSmOp],sSmUsati) = 0 then
          begin
            Result:=SimboliOperatori[iSmOp];
            Break;
          end;
      Exit;
    end;
    if TotPagGio[iSgOp].Operatore <> sOldOp then
    begin
      if (sSmOp <> '') and (Pos(sSmOp,sSmUsati) = 0) then
        sSmUsati:=sSmUsati + sSmOp
      else
        for iSmOp:=1 to Length(SimboliOperatori) do
          if Pos(SimboliOperatori[iSmOp],sSmUsati) = 0 then
          begin
            sSmUsati:=sSmUsati + SimboliOperatori[iSmOp];
            Break;
          end;
    end;
    sOldOp:=TotPagGio[iSgOp].Operatore;
  end;
end;

procedure TA058FPianifTurniDtm1.DebitoDipendente(MyDip:TDipendente; Dal,Al:Integer);
var
  j:Integer;
begin
  MyDip.Debito:=0;
  MyDip.Assegnato:=0;
  for j:=Dal to Al do
  begin
    inc(MyDip.Debito,MyDip.Giorni[j].Debito);
    inc(MyDip.Assegnato,MyDip.Giorni[j].Assegnato);
  end;
end;

function TA058FPianifTurniDtm1.GetTipoOpe(Prog:integer):string;
begin
  Result:='';
  //Q430.Close;
  R180SetVariable(Q430,'PROGRESSIVO',Prog);
  R180SetVariable(Q430,'DATA',DataFine);
  Q430.Open;
  Q430.First;
  Result:=Q430.FieldByName('TIPOOPE').AsString.Trim;
  if Result <> '' then
    Result:='(' + Result + ')';
end;

function TA058FPianifTurniDtm1.GetSquadra(Prog:integer):string;
begin
  Result:='';
  //Q430.Close;
  R180SetVariable(Q430,'PROGRESSIVO',Prog);
  R180SetVariable(Q430,'DATA',DataFine);
  Q430.Open;
  Q430.First;
  Result:=Q430.FieldByName('SQUADRA').asString;
end;

function TA058FPianifTurniDtm1.PianifDipInSquadra(inProgressivo:integer;inDataCorr,inDataDa,inDataA:TDateTime):TPianifDipInSquadra;
var GetTipoOpeT430:Boolean;
begin
  Result.CodiceSquadra:='';
  Result.DescSquadra:='';
  Result.Operatore:='';
  GetTipoOpeT430:=False;//variabile per compatibilità con la vecchia gestione, che non prevedeva l'impostazione del T630.COD_TIPOOPE, ora obbligatoria
  //Apertura DataSet per Verificare un eventuale spostamento di squadra
  R180SetVariable(selGetSquadraDip,'PROGRESSIVO',inProgressivo);
  R180SetVariable(selGetSquadraDip,'DATA1',inDataDa);
  R180SetVariable(selGetSquadraDip,'DATA2',inDataA);
  selGetSquadraDip.Open;
  //Se la squadra di riferimento è vuota imposto il campo a true
  //Ciclo per eventuali assegnazioni di squadra nello stesso periodo
  if selGetSquadraDip.SearchRecord('PROVENIENZA','T630',[srFromBeginning]) then
    repeat
      if (inDataCorr >= selGetSquadraDip.FieldByName('DATADECORRENZA').AsDateTime) and
         (inDataCorr <= selGetSquadraDip.FieldByName('DATAFINE').AsDateTime) then
      begin
        Result.CodiceSquadra:=selGetSquadraDip.FieldByName('SQUADRA').AsString;
        Result.DescSquadra:=selGetSquadraDip.FieldByName('DESCRIZIONE').AsString;
        Result.Operatore:=selGetSquadraDip.FieldByName('TIPOOPE').AsString;
        GetTipoOpeT430:=Result.Operatore = '';
        if not GetTipoOpeT430 then
          Exit;
      end;
    until not selGetSquadraDip.SearchRecord('PROVENIENZA','T630',[srForward]);

  if selGetSquadraDip.SearchRecord('PROVENIENZA','T430',[srFromBeginning]) then
    repeat
      if (inDataCorr >= selGetSquadraDip.FieldByName('DATADECORRENZA').AsDateTime) and
         (inDataCorr <= selGetSquadraDip.FieldByName('DATAFINE').AsDateTime) then
      begin
        if not GetTipoOpeT430 then
        begin
          Result.CodiceSquadra:=selGetSquadraDip.FieldByName('SQUADRA').AsString;
          Result.DescSquadra:=selGetSquadraDip.FieldByName('DESCRIZIONE').AsString;
        end;
        Result.Operatore:=selGetSquadraDip.FieldByName('TIPOOPE').AsString;
      end;
    until not selGetSquadraDip.SearchRecord('PROVENIENZA','T430',[srForward]);
  //===================================================================
end;

procedure TA058FPianifTurniDtm1.CreaGiorno(MyDip:TDipendente; Data:TDateTime; Posizione:LongInt);
{Crea un oggetto TGiorno associato al dipendente corrente}
var
	Giorno:TGiorno;
  InfoSquadra:TPianifDipInSquadra;
  T1,T2,T1EU,T2EU,Ora,Ass1,Ass2,ValorGior,Flag,VAss,Antincendio,Note,Referente,
  RichiestoDaTurnista,Area:String;
  AssOre:TObjectList<TAssenzaOre>;
  Ass1Modif,Ass2Modif:Boolean;
  Ass1Competenza,Ass2Competenza:TCompetenzaAssenza;
  Inizio,Fine,D:TDateTime;
begin
  Giorno:=TGiorno.Create;
  Giorno.ParentDipendente:=MyDip;
  Giorno.Anomalie.Progressivo:=MyDip.Prog;
  AssOre:=nil;
  R180SetVariable(selV010,'PROGRESSIVO',MyDip.Prog);
  R180SetVariable(selV010,'DAL', DataInizio);
  R180SetVariable(selV010,'AL', DataFine);
  selV010.Open;
  Giorno.GGFestivo:=VarToStr(selV010.Lookup('DATA',Data,'FESTIVO')) = 'S';
  //Informazioni sull'appartenza in squadra nel periodo
  InfoSquadra:=PianifDipInSquadra(MyDip.Prog,Data,DataInizio,DataFine);
  //Se Gestione cambio squadra è nullo pianifico sempre
  if not QSSquadra.LocDatoStorico(Data) or
    (InfoSquadra.CodiceSquadra <> SquadraRiferimento) then
  begin
    Flag:='NT';
  end
  else
    if QSSquadra.FieldByName('T430INIZIO').IsNull then
      Flag:='NT'
    else
    begin
      Inizio:=QSSquadra.FieldByName('T430INIZIO').AsDateTime;
      if QSSquadra.FieldByName('T430FINE').IsNull then
        Fine:=0
      else
        Fine:=QSSquadra.FieldByName('T430FINE').AsDateTime;
      if Fine = 0 then
        Fine:=StrToDate('31/12/3999');
      if (Data >= Inizio) and (Data <= Fine) then
        GetPianificazione(Data,MyDip.Prog,Posizione,T1,T2,T1EU,T2EU,Ora,Ass1,Ass2,ValorGior,Flag,VAss,Antincendio,Note,Referente,
                          RichiestoDaTurnista,Area,Ass1Modif,Ass2Modif,AssOre,Ass1Competenza,Ass2Competenza)
      else
        Flag:='NT';
    end;
  //caricamento turno reperibilità
  //Giorno.TurnRep:=Trim(VarToStr(selT380.Lookup('DATA',Data,'TURNO1')));
  if (selT380.FieldByName('DATA').AsDateTime = Data) or selT380.SearchRecord('DATA',Data,[srFromCurrent]) then
  begin
    // dati turno 1
    Giorno.TurniRep[1].Turno:=selT380.FieldByName('TURNO1').AsString;
    Giorno.TurniRep[1].Sigla:=selT380.FieldByName('SIGLA').AsString;
    Giorno.TurniRep[1].OraInizio:=selT380.FieldByName('ORAINIZIO').AsString;
    Giorno.TurniRep[1].OraFine:=selT380.FieldByName('ORAFINE').AsString;
    // dati turno 2
    Giorno.TurniRep[2].Turno:=selT380.FieldByName('TURNO2').AsString;
    Giorno.TurniRep[2].Sigla:=selT380.FieldByName('SIGLA2').AsString;
    Giorno.TurniRep[2].OraInizio:=selT380.FieldByName('ORAINIZIO2').AsString;
    Giorno.TurniRep[2].OraFine:=selT380.FieldByName('ORAFINE2').AsString;
    // dati turno 3
    Giorno.TurniRep[3].Turno:=selT380.FieldByName('TURNO3').AsString;
    Giorno.TurniRep[3].Sigla:=selT380.FieldByName('SIGLA3').AsString;
    Giorno.TurniRep[3].OraInizio:=selT380.FieldByName('ORAINIZIO3').AsString;
    Giorno.TurniRep[3].OraFine:=selT380.FieldByName('ORAFINE3').AsString;
  end;
  Giorno.NTimbTurno:=0;
  //=====================================
  //RICERCA DELLA PIANIFICAZIONE CORRETTA
  //=====================================
  R180SetVariable(Q620,'PROGRESSIVO',MyDip.Prog);
  Q620.Open;
  D:=Q620.FieldByName('DATA').AsDateTime;
  Q620.Last;
  while (not Q620.Bof) and (Q620.FieldByName('DATA').AsDateTime > Data) do
  begin
    Q620.Prior;
  end;
  Giorno.VerTurni:=Q620.FieldByName('VERIFICA_TURNI').AsString;
  Giorno.VerRiposi:=Q620.FieldByName('VERIFICA_RIPOSI').AsString;
  Q620.SearchRecord('DATA',D,[srFromBeginning]);
  Giorno.CodServizio:='';
  Giorno.DescServizio:='';
  Giorno.Flag:=Flag;
  Giorno.Data:=Data;//Bruno 02/04/10
  Giorno.pModificato:=False;
  Giorno.Antincendio:=Antincendio;
  Giorno.Note:=Note;
  Giorno.Referente:=Referente;
  Giorno.RichiestoDaTurnista:=RichiestoDaTurnista;
  Giorno.Ora:=Ora;
  Giorno.T1EU:=T1EU;
  Giorno.T2EU:=T2EU;
  Giorno.T1:=Format('%2s',[T1]);
  Giorno.T2:=Format('%2s',[T2]);
  Giorno.ValorGior:=ValorGior;
  Giorno.Ass1:=Ass1;
  Giorno.Ass2:=Ass2;
  Giorno.VAss:=VAss;
  Giorno.AssOre:=AssOre;
  Giorno.Ass1Modif:=Ass1Modif;
  Giorno.Ass2Modif:=Ass2Modif;
  Giorno.Ass1Competenza:=Ass1Competenza;
  Giorno.Ass2Competenza:=Ass2Competenza;
  Giorno.Squadra:=InfoSquadra.CodiceSquadra;
  Giorno.DSquadra:=InfoSquadra.DescSquadra;
  Giorno.Oper:=InfoSquadra.Operatore;
  Giorno.Area:=Area;
  Giorno.DArea:=ReperisciDArea(Area);
  //=======================================================
  //VALORIZZAZIONE VARIABILE VISTA X IL CONTROLLO SUI TURNI
  //=======================================================
  if not Giorno.Squadra.Trim.isEmpty then
  begin
    MyDip.CausRip:=VarToStr(selT603.Lookup('CODICE',QSSquadra.FieldByName('T430SQUADRA').AsString,'CAUS_RIPOSO'));
    R180SetVariable(selT606,'PROGRESSIVO',-1); //Non individuale
    R180SetVariable(selT606,'COD_ORARIO','*'); //Tutti gli orari
    R180SetVariable(selT606,'COD_SQUADRA',QSSquadra.FieldByName('T430SQUADRA').AsString);
    R180SetVariable(selT606,'COD_TIPOOPE',QSSquadra.FieldByName('T430TIPOOPE').AsString);
    selT606.Open;
    try
      FiltraT606(selT606,Giorno.Data,'00002','*');
      if selT606.SearchRecord('SIGLA_TURNO','*',[srFromBeginning]) then
        // Usato per il controllo del numero minimo di riposi nei giorni festivi per ogni mese
        MyDip.ConstMinFestMese:=selT606.FieldByName('MINIMO').AsInteger;

      FiltraT606(selT606,Giorno.Data,'00003','*');
      if selT606.SearchRecord('SIGLA_TURNO','*',[srFromBeginning]) then
        MyDip.ConstMaxNottiMese:=selT606.FieldByName('MASSIMO').AsInteger;
    finally
      selT606.Filtered:=False;
  end;
  end;
  if (Giorno.Ass1 <> '') and (Giorno.T1.Trim = '') then
    Giorno.T1:=' A';

  //Lello 07/02/2005 inizio
  //Se è pianificato il turno ma manca l'orario lo ricerco nello storico
  if NuovaPianif and (Giorno.Ora.Trim = '') and
     (((Trim(Giorno.T1) <> 'A') and (Trim(Giorno.T1) <> '')) or
      ((Trim(Giorno.T1) = 'A') and (selT082.FieldByName('PIANIF_GG_ASS').AsString = 'S'))) then
    Giorno.Ora:=GetOrarioStorico(Data,MyDip.Prog);
  //Lello 07/02/2005 fine
  if NuovaPianif and (selT082.FieldByName('PIANIF_GG_ASS').AsString = 'N') and
     (Trim(Giorno.Ass1) <> '') and (not Giorno.Ass1Modif) then
  begin
    Giorno.Ora:='';
    Giorno.T1:=' A';
  end;
  if not NuovaPianif and (Giorno.T1.Trim = '') then
    if Giorno.Ora <> '' then
      Giorno.T1:=' M';
  Giorno.pModificato:=False;
  Giorno.DetDip.Riposi:=0;
  SetLength(Giorno.DetDip.Operatori,0);
  MyDip.Giorni.Add(Giorno);
  //Aggiornamento dei totali dei turni
  AggiornaTotaleTurni(MyDip,MyDip.Giorni.Count - 1,False);
  //GiornoOld:=TGiorno.Create;
  //GiornoOld:=Giorno.CopyGiorno;
  //Inserire il metodo di clonazione dell'oggetto
  MyDip.GiorniOld.Add(Giorno.CopyGiorno);
  //FreeAndNil(Giorno);
end;

function TA058FPianifTurniDtm1.ReperisciDArea(Area:String):String;
begin
  Result:='';
  // Ricerco Descrizione Area in DataSet
  if (Area <> '') and (selT650.SearchRecord('CODICE',Area,[srFromBeginning])) then
    Result:=selT650.FieldByName('DESCRIZIONE').AsString;
end;

function TA058FPianifTurniDtm1.GetSiglaArea(Area: String): String;
begin
  Result:='';
  // Ricerco Sigla Area in DataSet
  if (Area <> '') and (selT650.SearchRecord('CODICE',Area,[srFromBeginning])) then
    Result:=selT650.FieldByName('SIGLA').AsString;
end;

procedure TA058FPianifTurniDtM1.GetAreeAfferenza(Squadra, Operatore: String);
var FiltroT651:String;
begin
  //Filtro DataSet con Aree previste per Squadra / Operatore
  FiltroT651:='(CODICE_SQUADRA = ''' + Squadra + ''')';
  FiltroT651:=FiltroT651 + ' AND ((CODICE_OPERATORE = ''' + Operatore + ''') OR (CODICE_OPERATORE = ''<*>''))';
  if selT651.Filter <> FiltroT651 then
  begin
    selT651.Filtered:=False;
    selT651.Filter:=FiltroT651;
    selT651.Filtered:=True;
  end;
end;

procedure TA058FPianifTurniDtm1.GetAssegnazioneTurnazione(Progressivo:Integer;Data:TDate);
begin
  R180SetVariable(Q620,'PROGRESSIVO',Progressivo);
  Q620.Open;
  Q620.Last;
  while not Q620.Bof and (Q620.FieldByName('DATA').AsDateTime > Data) do
    Q620.Prior;
end;

function TA058FPianifTurniDtm1.CreaDipendente(Prog, Badge:LongInt;Matricola, Cognome, Nome:String):TDipendente;
{Crea un oggetto TDipendente associato alla lista Vista}
begin
  Result:=TDipendente.Create;
  Result.ParentListDip:=Vista;
  Result.Prog:=Prog;
  Result.Badge:=Badge;
  Result.Cognome:=Cognome;
  Result.Nome:=Nome;
  Result.Matricola:=Matricola;
  //Leggo il profilo del dipendente
  Result.Squadra:=GetSquadra(Prog);
  Result.TipoOpe:=GetTipoOpe(Prog);
  SetLength(Result.TotDip.Operatori,0);
  Result.TotDip.Riposi:=0;
  Result.RiposiPrec:=0;
  Result.FestiviLavMeseCorr:=0;
  Result.FestiviLavMesePrec:=0;
  Result.FestiviLavAnnoPrec:=0;
  GetAssegnazioneTurnazione(Prog,DataInizio);
  Result.TurnoPartenza:=Q620.FieldByName('PARTENZA').AsInteger;
  with selRiposi do
  begin
    Close;
    SetVariable('PROGRESSIVO',Prog);
    if (R180Mese(DataInizio) = 1) and (R180Giorno(DataInizio) = 1) then
    begin
      SetVariable('DATA1',EncodeDate(R180Anno(DataInizio) - 1,1,1));
      SetVariable('DATA2',DataInizio - 1);
    end
    else
    begin
      SetVariable('DATA1',EncodeDate(R180Anno(DataInizio),1,1));
      SetVariable('DATA2',DataInizio - 1);
    end;
    Open;
    Result.RiposiPrec:=FieldByName('NUM').AsInteger;
    Close;
  end;
  with selFestLav do
  begin
    //Festività lavorate da inizio anno a fine mese precedente
    Close;
    SetVariable('PROGRESSIVO',Prog);

    SetVariable('PIANIF_OPERATIVA',IfThen(selT082.fieldByName('MODALITA_LAVORO').AsString = 'O','S','N'));
    SetVariable('GIUST_NONOPERATIVI',IfThen(selT082.fieldByName('MODALITA_LAVORO').AsString = 'N','S',IfThen(AssenzeOperative,'N','S')));
    SetVariable('GIUST_OPERATIVI','N');
    if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or
       AssenzeOperative or
       (Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') then
      SetVariable('GIUST_OPERATIVI','S');

    SetVariable('FLAGAGG','N');
    if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') then
    begin
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        if TipoPianif = 0 then //Iniziale
          SetVariable('FLAGAGG','I')
        else if TipoPianif = 1 then //Corrente
          SetVariable('FLAGAGG','C');
      end
      else
        SetVariable('FLAGAGG','N');
    end;

    if (R180Mese(DataInizio) = 1) and (R180Giorno(DataInizio) = 1) then
    begin
      SetVariable('DATA1',EncodeDate(R180Anno(DataInizio) - 1,1,1));
      SetVariable('DATA2',DataInizio - 1);
    end
    else
    begin
      SetVariable('DATA1',EncodeDate(R180Anno(DataInizio),1,1));
      SetVariable('DATA2',DataInizio - 1);
    end;
    Open;
    Result.FestiviLavMesePrec:=FieldByName('NUM').AsInteger;
    Close;
  end;
end;

procedure TA058FPianifTurniDtm1.LeggiPianificazione(Prog:LongInt;DataIniElab,DataFinElab:TDateTime; CreaPianif:Boolean = True);
{Creo Vista leggendo le pianificazioni e i giustificativi già esistenti}
var
  DataCorr:TDateTime;
  QP,QG,T040:TOracleDataSet;
  DipendenteTemp:TDipendente;
  Badge:Integer;
  VisualizzaDip:Boolean;
begin
  T040:=nil;
  if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  begin
    QP:=Q080Gest;
    QG:=Q040Gest;
  end
  else
  begin
    QP:=Q081Gest;
    QG:=Q041Gest;
    if AssenzeOperative then
      QG:=Q040Gest
    else
      T040:=Q040Gest;
  end;
  //Lettura turni reperibilità
  selT380.Close;
  selT380.SetVariable('PROGRESSIVO',Prog);
  selT380.SetVariable('DATADA',DataInizio);
  selT380.SetVariable('DATAA',DataFine);
  selT380.Open;
  //Leggo le assenze giornaliere
  if CreaPianif then
    with QG do
    begin
      Close;
      ClearVariables;
      SetVariable('Progressivo',Prog);
      SetVariable('Data1',DataIniElab);
      SetVariable('Data2',DataFinElab);
      //Andrea
      if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and not AssenzeOperative then
      begin
        if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
        //PIANIFICAZIONE PROGRESSIVA
        begin
          if TipoPianif = 0 then //Iniziale
            SetVariable('FlagAgg',' AND FLAGAGG = ''I''')
          else if TipoPianif = 1 then //Corrente
            SetVariable('FlagAgg',' AND FLAGAGG = ''C''');
        end
        else
          SetVariable('FlagAgg',' AND FLAGAGG = ''N''');
      end;
      Open;
    end;

  //Leggo le pianificazioni manuali (FlagAgg <> 'P')
  with QP do
  begin
    Close;
    ClearVariables;
    SetVariable('Progressivo',Prog);
    SetVariable('Data1',DataIniElab);
    SetVariable('Data2',DataFinElab);
    //Andrea
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
    begin
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      //PIANIFICAZIONE PROGRESSIVA
      begin
        if TipoPianif = 0 then //Iniziale
          SetVariable('FlagAgg',' AND FLAGAGG = ''I''')
        else if TipoPianif = 1 then //Corrente
          SetVariable('FlagAgg',' AND FLAGAGG = ''C''');
      end
      else
        SetVariable('FlagAgg',' AND FLAGAGG = ''N''');
    end;
    Open;
  end;

  if not CreaPianif then
    exit;

  if RicercaSostituti then
  begin
    DipendenteTemp:=CreaDipendente(DipSostituto.Progressivo,
                                   DipSostituto.Badge,
                                   DipSostituto.Matricola,
                                   DipSostituto.Cognome,
                                   DipSostituto.Nome);
  end
  else //situazione standard
  begin
    try
      if SelAnagrafeA058.FindField('T430Badge') <> nil then
        Badge:=SelAnagrafeA058.FieldByName('T430Badge').AsInteger
      else
        Badge:=0;
    except
      Badge:=0;
    end;
    DipendenteTemp:=CreaDipendente(SelAnagrafeA058.FieldByName('Progressivo').AsInteger,
                                   Badge,
                                   SelAnagrafeA058.FieldByName('Matricola').AsString,
                                   SelAnagrafeA058.FieldByName('Cognome').AsString,
                                   SelAnagrafeA058.FieldByName('Nome').AsString);
  end;
  //Leggo i giustificativi inseriti in t040 che devono essere visualizzati, ma non modificabili
  //eliminato--> //Solo se la pianificazione è diversa da INIZIALE
  //sostituito con: se la pianificazione è iniziale, leggo quello che trovo in T040 con scheda <> 'P'
  //e cioè tutte le assenze che sono state inserite dalla maschera di gestione dei giustificativi, ma NON dalla pianificazione
  if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and not AssenzeOperative then //and (RgpTipo.ItemIndex <> 0) then
  begin
    with T040 do
    begin
      Close;
      ClearVariables;
      SetVariable('Progressivo',Prog);
      SetVariable('Data1',DataIniElab);
      SetVariable('Data2',DataFinElab);
      SetVariable('SCHEDA', ' and ((SCHEDA <> ''P'') or SCHEDA is null)');
      Open;
    end;
  end;

  QSSquadra.GetDatiStorici('T430SQUADRA,T430D_SQUADRA,T430CALENDARIO,T430TIPOOPE,T430INIZIO,T430FINE',Prog,DataIniElab,DataFinElab);
  VisualizzaDip:=False;
  DataCorr:=DataIniElab;
  while DataCorr <= DataFinElab do
  begin
    CreaGiorno(DipendenteTemp, DataCorr,0);
    //if DipendenteTemp.Giorni[DipendenteTemp.Giorni.Count - 1].Flag <> 'NT' then
    if DipendenteTemp.Giorni[DipendenteTemp.Giorni.Count - 1].Squadra = SquadraRiferimento then
      VisualizzaDip:=True;
    //Incremento data corrente
    DataCorr:=DataCorr + 1;
  end;
  if VisualizzaDip then
  begin
    AnomalieXDipendente(DipendenteTemp);
    Vista.Add(DipendenteTemp);
  end
  else
  begin
    FreeAndNil(DipendenteTemp);
  end;
end;

procedure TA058FPianifTurniDtM1.CreaTabStampaAss;
begin
  T058Stampa.Close;
  //Creo la tabella di appoggio T058Stampa
  with T058Stampa.FieldDefs do
  begin
    Clear;
    Add('Matricola',ftString,10,False);
    Add('Data',ftDate);
    Add('Cognome',ftString,25,False);
    Add('Nome',ftString,25,False);
    Add('Causale',ftString,40,False);
  end;
  T058Stampa.CreateDataSet;
  T058Stampa.LogChanges:=False;
  T058Stampa.Open;
end;

procedure TA058FPianifTurniDtM1.CaricaTabStampaAss;
begin
  selT040.Close;
  selT040.SetVariable('DATADA',DataInizio);
  selT040.SetVariable('DATAA',DataFine);
  SelAnagrafeA058.First;
  while Not SelAnagrafeA058.Eof do
  begin
    selT040.Close;
    selT040.SetVariable('PROG',SelAnagrafeA058.FieldByName('PROGRESSIVO').AsInteger);
    selT040.Open;
    while Not selT040.Eof do
    begin
      T058Stampa.Append;
      if selT040.Bof then
      begin
        T058Stampa.FieldByName('MATRICOLA').AsString:=selT040.FieldByName('MATRICOLA').AsString;
        T058Stampa.FieldByName('COGNOME').AsString:=selT040.FieldByName('COGNOME').AsString;
        T058Stampa.FieldByName('NOME').AsString:=selT040.FieldByName('NOME').AsString;
      end;
      T058Stampa.FieldByName('DATA').AsDateTime:=selT040.FieldByName('DATA').AsDateTime;
      T058Stampa.FieldByName('CAUSALE').AsString:=selT040.FieldByName('CAUSALE').AsString;
      T058Stampa.Post;
      selT040.Next;
    end;
    SelAnagrafeA058.Next;
  end;
end;

procedure TA058FPianifTurniDtM1.RefreshAssenze(DataDa,DataA:TDateTime);
var
  i,j:Integer;
  DataScorr:TDateTime;
  CurrAssenzaOre:TAssenzaOre;
begin
  Q040.SetVariable('DATA1',DataDa);
  Q040.SetVariable('DATA2',DataA);
  for i:=0 to Vista.Count - 1 do
  begin
    Q040.Close;
    Q040.SetVariable('PROGRESSIVO',Vista[i].Prog);
    Q040.Open;
    DataScorr:=DataDa;
    j:=Trunc(DataScorr - DataInizio);
    while DataScorr <= DataA do
    begin
      Vista[i].Giorni[j].SensibilitaModificaOFF;
      Vista[i].Giorni[j].Ass1:='';
      Vista[i].Giorni[j].Ass1Competenza:=caVuota;
      Vista[i].Giorni[j].Ass2:='';
      Vista[i].Giorni[j].Ass2Competenza:=caVuota;
      Vista[i].Giorni[j].VAss:='';
      if Vista[i].Giorni[j].AssOre <> nil then
        FreeAndNil(Vista[i].Giorni[j].AssOre);
      Vista[i].Giorni[j].AssOre:=TObjectList<TAssenzaOre>.Create(True);
      if Q040.Locate('DATA',DataScorr,[]) then
      begin
        while not Q040.Eof do
        begin
          //Assenze a giorni
          if Q040.FieldByName('DATA').AsDateTime <> DataScorr then
            Break;
          if Q040.FieldByName('TIPOGIUST').AsString = 'I' then
          begin
            if Vista[i].Giorni[j].Ass1 = '' then
            begin
              Vista[i].Giorni[j].Ass1:=Q040.FieldByName('CAUSALE').AsString;
              Vista[i].Giorni[j].Ass1Competenza:=DecodeCompetenzaAssenza(Q040.FieldByName('COMPETENZA').AsString);
              Vista[i].Giorni[j].VAss:=Q040.FieldByName('VALIDAZIONE').AsString;
            end
            else
            begin
              Vista[i].Giorni[j].Ass2:=Q040.FieldByName('CAUSALE').AsString;
              Vista[i].Giorni[j].Ass2Competenza:=DecodeCompetenzaAssenza(Q040.FieldByName('COMPETENZA').AsString);
              if Vista[i].Giorni[j].VAss = '' then
                Vista[i].Giorni[j].VAss:=Q040.FieldByName('VALIDAZIONE').AsString;
            end
          end
          else
          begin
            //Assenze a ore/mezze giornate
            CurrAssenzaOre:=TAssenzaOre.Create();
            CurrAssenzaOre.Causale:=Q040.FieldByName('Causale').AsString;
            CurrAssenzaOre.TipoGiust:=Q040.FieldByName('TipoGiust').AsString;
            if CurrAssenzaOre.TipoGiust = 'M' then
              CurrAssenzaOre.Orario:='1/2'
            else if CurrAssenzaOre.TipoGiust = 'D' then
              CurrAssenzaOre.Orario:=Format('%s-%s',[FormatDateTime('hh.nn',Q040.FieldByName('DAORE').AsDateTime),FormatDateTime('hh.nn',Q040.FieldByName('AORE').AsDateTime)])
            else if CurrAssenzaOre.TipoGiust = 'N' then
              CurrAssenzaOre.Orario:=Format('%s',[FormatDateTime('hh.nn',Q040.FieldByName('DAORE').AsDateTime)]);
//            CurrAssenzaOre.Tabella:=DecodeTabellaProvenienzaAssenza(Q040.FieldByName('TABELLA').AsString);
            Vista[i].Giorni[j].AssOre.Add(CurrAssenzaOre);
          end;
          Q040.Next;
        end;
      end;
      Vista[i].Giorni[j].SensibilitaModificaON;
      inc(j);
      DataScorr:=DataScorr + 1;
    end;
  end;
end;

procedure TA058FPianifTurniDtM1.RefreshQ021(D:TDateTime);
begin
  if Q021.GetVariable('DECORRENZA') <> D then
  begin
    Q021.SetVariable('DECORRENZA',D);
    Q021.Close;
  end;
  Q021.Open;
end;

procedure TA058FPianifTurniDtM1.InizializzaConteggiGiornalieri(MyDip:TDipendente; IGiorno:Integer; var ConteggioNormale:Boolean);
begin
  if R502ProDtM = nil then
    Exit;

  ConteggioNormale:=True;
  if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and
     (Parametri.CampiRiferimento.C11_PianifOrariProg <> 'S') and
     (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'PUNTI NOMINALI') and
     AssenzeOperative then
    ConteggioNormale:=False;

  R502ProDtM.PianificazioneEsterna.Progressivo:=MyDip.Prog;
  R502ProDtM.PianificazioneEsterna.Data:=MyDip.Giorni[IGiorno].Data;
  R502ProDtM.PianificazioneEsterna.l08_Orario:=MyDip.Giorni[IGiorno].Ora;

  R502ProDtM.PianificazioneEsterna.l08_turno1:=StrToIntDef(MyDip.Giorni[IGiorno].T1,-1);
  if R502ProDtM.PianificazioneEsterna.l08_turno1 = 0 then
    R502ProDtM.PianificazioneEsterna.l08_turno2:=0
  else
    R502ProDtM.PianificazioneEsterna.l08_turno2:=StrToIntDef(MyDip.Giorni[IGiorno].T2,-1);

  if (not ConteggioNormale) and (R502ProDtM.PianificazioneEsterna.l08_turno1 = 0) and
     ((MyDip.Giorni[IGiorno].Ass1 <> '') or (MyDip.Giorni[IGiorno].Ass2 <> '')) then
       R502ProDtM.PianificazioneEsterna.l08_turno1:=-1;

  R502ProDtM.PianificazioneEsterna.l08_turno1EU:=MyDip.Giorni[IGiorno].T1EU;
  R502ProDtM.PianificazioneEsterna.l08_turno2EU:=MyDip.Giorni[IGiorno].T2EU;
  R502ProDtM.Conteggi('Cartolina',MyDip.Prog,MyDip.Giorni[IGiorno].Data);

end;

//Alberto (Pescara)
procedure TA058FPianifTurniDtM1.ConteggiGiornalieri(Data:TDateTime; MyDip:TDipendente; IGiorno:Integer);
var
  PNE, PNU, i:integer;
  ConteggioNorm:Boolean;
begin
  if not ConteggiaDebito then
  begin
    // Questo metodo viene richiamato dopo una modifica, in questo caso potremmo avere i conteggi
    // potenzialmente disallineati.
    MyDip.Giorni[IGiorno].ConteggiAggiornati:=False;
    Exit;
  end;

  if MyDip.Giorni[IGiorno].ConteggiAggiornati then
    exit;

  InizializzaConteggiGiornalieri(MyDip,IGiorno,ConteggioNorm);

  MyDip.Giorni[IGiorno].Debito:=R502ProDtM.debitocl;
  MyDip.Giorni[IGiorno].Assegnato:=0;
  if (((MyDip.Giorni[IGiorno].Ass1 = '') and (MyDip.Giorni[IGiorno].Ass2 = '')) or ConteggioNorm) and
     R502ProDtM.cdsT020.Active then
  begin
    if (R502ProDtM.PianificazioneEsterna.l08_turno1 > 0) then
    begin
      //Fraz.debito con turno notturno in E
      if (R502ProDtM.cdsT020.FieldByName('FrazDeb').AsString = 'S') and (R502ProDtM.PianificazioneEsterna.l08_turno1EU = 'E') then
        inc(MyDip.Giorni[IGiorno].Assegnato,
            1440 - R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1])
      //Fraz.debito con turno notturno in U
      else if (R502ProDtM.cdsT020.FieldByName('FrazDeb').AsString = 'S') and (R502ProDtM.PianificazioneEsterna.l08_turno1EU = 'U') then
        inc(MyDip.Giorni[IGiorno].Assegnato,
            R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1])
      //Turno normale
      else if (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'MODELLO ORARIO') then
        inc(MyDip.Giorni[IGiorno].Assegnato,
            R502ProDtM.ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1])
      //Differenza fra uscita ed entrata
      else if (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'PUNTI NOMINALI') then
      begin
        PNE:=R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1];
        PNU:=R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1];
        if PNE >= PNU then
        begin
          PNE:=1440 - PNE;
          if MyDip.Giorni[IGiorno].T1EU = 'E' then
            PNU:=0;
          if MyDip.Giorni[IGiorno].T1EU = 'U' then
            PNE:=0;
          inc(MyDip.Giorni[IGiorno].Assegnato,PNU + PNE);
        end
        else
          inc(MyDip.Giorni[IGiorno].Assegnato,PNU - PNE);
      end;
    end;
    if (R502ProDtM.PianificazioneEsterna.l08_turno2 > 0) then
    begin
      //Fraz.debito con turno notturno in E
      if (R502ProDtM.cdsT020.FieldByName('FrazDeb').AsString = 'S') and (R502ProDtM.PianificazioneEsterna.l08_turno2EU = 'E') then
        inc(MyDip.Giorni[IGiorno].Assegnato,
            1440 - R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2])
      //Fraz.debito con turno notturno in U
      else if (R502ProDtM.cdsT020.FieldByName('FrazDeb').AsString = 'S') and (R502ProDtM.PianificazioneEsterna.l08_turno2EU = 'U') then
        inc(MyDip.Giorni[IGiorno].Assegnato,
            R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2])
      //Turno normale
      else if (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'MODELLO ORARIO')  then
        inc(MyDip.Giorni[IGiorno].Assegnato,
            R502ProDtM.ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2])
      //Differenza fra uscita ed entrata
      else if (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'PUNTI NOMINALI') then
      begin
        PNE:=R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2];
        PNU:=R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2];
        if PNE >= PNU then
        begin
          PNE:=1440 - PNE;
          if MyDip.Giorni[IGiorno].T2EU = 'E' then
            PNU:=0;
          if MyDip.Giorni[IGiorno].T2EU = 'U' then
            PNE:=0;
          inc(MyDip.Giorni[IGiorno].Assegnato,PNU + PNE);
        end
        else
          inc(MyDip.Giorni[IGiorno].Assegnato,PNU - PNE);
      end;
    end
    else if (not ConteggioNorm) and (VarToStr(Q020.Lookup('CODICE',MyDip.Giorni[IGiorno].Ora,'TIPOORA')) <> 'E') then
    begin
      //Conteggi da punti nominali e modello orario NON a turni
      PNE:=R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,1];
      PNU:=R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,1];
      inc(MyDip.Giorni[IGiorno].Assegnato,max(0,PNU - PNE));
    end;
  end
  else if (Not ConteggioNorm) and ((MyDip.Giorni[IGiorno].Ass1 <> '') or
          (MyDip.Giorni[IGiorno].Ass2 <> '')) then
  begin
    //Se nel giorno è presente anche un solo giustificativo d'assenza annullo il debito.
    i:=1;
    while (i < R502ProDtM.n_riepasse) and (R502ProDtM.triepgiusasse[i].traggasse <> 'H') do
      inc(i);
    if R502ProDtM.triepgiusasse[i].traggasse <> 'H' then
      inc(MyDip.Giorni[IGiorno].Assegnato,IfThen(R502ProDtM.Blocca = 0,R502ProDtM.debitogg,0));
  end;
  {Bruno(19/11/2012) - MILANO_HSACCO}
  if (MyDip.Giorni[IGiorno].Assegnato = 0) and ConteggioNorm then
    if (not ((VarToStr(Q020.Lookup('CODICE',MyDip.Giorni[IGiorno].Ora,'TIPOORA')) = 'E') and
       (R502ProDtM.PianificazioneEsterna.l08_turno1 = 0))) then
      inc(MyDip.Giorni[IGiorno].Assegnato,IfThen(R502ProDtM.Blocca = 0,R502ProDtM.debitogg,0));

  MyDip.Giorni[IGiorno].ConteggiAggiornati:=True;
end;

function TA058FPianifTurniDtM1.GetPartenza(Prog:LongInt; var Posizione:LongInt):Boolean;
{Leggo dalle turnazioni individuali la data che più si avvicina alla data di partenza}
var
  DataRif:TDateTime;
  OffSet:Integer;
begin
  TurnazioneOld:='';
  if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or AssenzeOperative then
  //Leggo giustif. e pianificazioni manuali solo se lavoro in modalità operativa
  //o se la gestione assenze è operativa
  begin
    //Leggo le assenze giornaliere
    with Q040 do
    begin
      Close;
      SetVariable('Progressivo',Prog);
      SetVariable('Data1',DataInizio);
      SetVariable('Data2',DataFine);
      Open;
    end;
    //Leggo le pianificazioni manuali (FlagAgg <> 'P')
    with Q080 do
    begin
      Close;
      SetVariable('Progressivo',Prog);
      SetVariable('Data1',DataInizio);
      SetVariable('Data2',DataFine);
      Open;
    end;
  end;
  Result:=False;
  GetAssegnazioneTurnazione(Prog,DataInizio);
  with Q620 do
  begin
    if RecordCount = 0 then
    begin
      exit;
    end;
    DataRif:=FieldByName('Data').AsDateTime;
    Offset:=IfThen(DataRif <= DataInizio,1,-1);
    //Mi posiziono sulla data scelta
  end;
  Result:=True;
  //Leggo tutti gli spostamenti occasionali
  with Q630 do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data1',DataInizio);
    SetVariable('Data2',DataFine);
    Open;
  end;

  GetTurnazione(Posizione);
  //Se Posizione = 0: Nessun turno:non pianifico ma devo tener conto di
  //altre Turnazioni Individuali successive
  if Posizione = 0 then
    exit;
  //Ricerco il giorno di partenza effettivo spostandomi dalla data di riferimento
  //alla data di inizio pianificazione
  while DataRif <> DataInizio do
  begin
    DataRif:=DataRif + Offset;
    Posizione:=Posizione + Offset;
    if Posizione >= Turno1.Count then
      Posizione:=1;
    if Posizione <=0 then
      Posizione:=Turno1.Count - 1;
  end;
end;

procedure TA058FPianifTurniDtM1.GetTurnazione(var Posizione:LongInt);
{Sviluppa il ciclo specificato dalla turnazione individuale e la posizione di partenza}
begin
  with Q620 do
  begin
    Posizione:=FieldByName('Partenza').AsInteger;
    if Posizione > 0 then
    begin
      if TurnazioneOld <> FieldByName('Turnazione').AsString then
      begin
        //Sviluppo il ciclo nelle Liste Turno1,Turno2,Orario,Causale
        SviluppoTurnazione(FieldByName('Turnazione').AsString,ListaCicli);
        SviluppoCicli(ListaCicli,Turno1,Turno2,Orario,Causale);
        //Disallineamento tra Partenza e numero reale di Giorni di ciclicità:
        //esco senza pianificare
        TurnazioneOld:=FieldByName('Turnazione').AsString;
      end;
      if Posizione > Turno1.Count - 1 then
        Posizione:=0;
    end;
    Next;
    //Imposto data di Turnaz.Successiva
    if Eof then
      TurnazSucc:=EncodeDate(3999,12,31)
    else
      TurnazSucc:=FieldByName('Data').AsDateTime;
  end;
end;

procedure TA058FPianifTurniDtM1.SviluppoTurnazione(Turnazione:String; Lista:TStringList);
var i,j:Integer;
begin
  //Carico la sequenza dei cicli in ListaCicli
  Lista.Clear;
  with Q641 do
  begin
    Close;
    SetVariable('Turnazione',Turnazione);
    Open;
    while not Eof do
    begin
      for i:=1 to FieldByName('Multiplo').AsInteger do
        //Carico i cicli n volte quanto specificato da MULTIPLO
        for j:=0 to 4 do
          //Carico i Cicli validi
          if Trim(Fields[j].AsString) <> '' then
            Lista.Add(Fields[j].AsString);
      Next;
    end;
  end;
end;

procedure TA058FPianifTurniDtM1.SviluppoCicli(Lista,Turno1,Turno2,Orario,Causale:TStringList);
{Sviluppo i cicli ottenuti dalla turnazione}
var i:Integer;
    CicloOld:String;
begin
  CicloOld:='';
  Turno1.Clear;
  Turno2.Clear;
  Orario.Clear;
  Causale.Clear;
  Turno1.Add('NT');
  Turno2.Add('');
  Orario.Add('');
  Causale.Add('');
  for i:=0 to Lista.Count - 1 do
    //Scorro i cicli ottenuti dalla turnazione
    with Q611 do
    begin
      if CicloOld <> Lista[i] then
      //Aggiorno la query dei cicli giornalieri se è cambiato il codice
      begin
        Close;
        SetVariable('Ciclo',Lista[i]);
        Open;
        CicloOld:=Lista[i];
      end;
      First;
      while not Eof do
      begin
        Turno1.Add(Format('%2s',[FieldByName('Turno1').AsString]) + FieldByName('Turno1EU').AsString);
        Turno2.Add(Format('%2s',[FieldByName('Turno2').AsString]) + FieldByName('Turno2EU').AsString);
        Orario.Add(FieldByName('Orario').AsString);
        Causale.Add(FieldByName('Causale').AsString);
        Next;
      end;
    end;
end;

procedure TA058FPianifTurniDtM1.GetPianificazione(inData:TDateTime; Prog,Posizione:LongInt;
                                                  var T1,T2,T1EU,T2EU,Ora,Ass1,Ass2,ValorGior,Flag,VAss,Antincendio,Note,Referente,RichiestoDaTurnista,Area:String;
                                                  var Ass1Modif,Ass2Modif:boolean; var AssOre:TObjectList<TAssenzaOre>;
                                                  var Ass1Competenza,Ass2Competenza:TCompetenzaAssenza);
{Legge l'eventuale spostamento di squadra e la pianificazione del giorno}
var
  selPianif,selAssenze,T040:TOracleDataSet;
  CurrAssenzaOre:TAssenzaOre;
begin
  Ass1:='';
  Ass2:='';
  VAss:='';
  AssOre:=TObjectList<TAssenzaOre>.Create(True);
  Ass1Modif:=True;
  Ass2Modif:=True;
  Ass1Competenza:=caPianificazione;
  Ass1Competenza:=caPianificazione;
  Antincendio:='N';
  Note:='';
  Referente:='';
  RichiestoDaTurnista:='';
  Area:='';
  T040:=nil;
  if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  //Leggo giustif, e pianificazioni effettivi
  begin
    if NuovaPianif then
    begin
      selPianif:=Q080;
      selAssenze:=Q040;
    end
    else
    begin
      selPianif:=Q080Gest;
      selAssenze:=Q040Gest;
    end;
  end
  else
  //Leggo giustif, e pianificazioni provvisori
  begin
    selPianif:=Q081Gest;
    selAssenze:=Q041Gest;
    if AssenzeOperative then
    begin
      if NuovaPianif then
      begin
        selAssenze:=Q040;
      end
      else
      begin
        selAssenze:=Q040Gest;
      end;
    end
    else
    begin
      T040:=Q040Gest;
    end;
  end;
  if not NuovaPianif or (selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or AssenzeOperative then
  //Leggo Giustificativi e Causali quando:
  // - sto leggendo pianificazioni esistenti (NuovaPianif = False)
  // - sto pianificando in modalità operativa
  begin
    //T040 serve solo in modalità non operativa
    if T040 <> nil then
    begin
      if T040.Locate('Data',inData,[]) then
      //Carico i giustificativi in Ass1 e Ass2
        while not T040.Eof do
        begin
          if T040.FieldByName('Data').AsDateTime <> inData then
            Break;
          //In modalità non operativa considero solo giustificativi a gg.intera
          if T040.FieldByName('TIPOGIUST').AsString = 'I' then
          begin
            //if Ass1 = '' then
            if (Ass1 = '') then //and (T040.FieldByName('PROGRCAUSALE').AsInteger <= 99) then
            begin
              //if T040.FieldByName('SCHEDA').AsString <> 'V' then
                VAss:=T040.FieldByName('VALIDAZIONE').AsString;
              Ass1:=T040.FieldByName('Causale').AsString;
              Ass1Competenza:=DecodeCompetenzaAssenza(T040.FieldByName('COMPETENZA').AsString);
              if T040.FieldByName('Scheda').AsString <> 'P' then
                Ass1Modif:=False;
            end
            //else
            else if (Ass2 = '') then //and (T040.FieldByName('PROGRCAUSALE').AsInteger <> 99) then
            begin
              if (VAss <> 'S') (*and (T040.FieldByName('SCHEDA').AsString <> 'V')*) then
                VAss:=T040.FieldByName('VALIDAZIONE').AsString;
              Ass2:=T040.FieldByName('Causale').AsString;
              Ass2Competenza:=DecodeCompetenzaAssenza(T040.FieldByName('COMPETENZA').AsString);
              if T040.FieldByName('Scheda').AsString <> 'P' then
                Ass2Modif:=False;
            end;
          end;
          T040.Next;
        end;
    end;

    if selAssenze.Locate('Data',inData,[]) then
    //Carico i giustificativi in Ass1 e Ass2
      while not selAssenze.Eof do
      begin
        if selAssenze.FieldByName('Data').AsDateTime <> inData then
          Break;
        if (selAssenze = Q041Gest) or (selAssenze.FieldByName('TIPOGIUST').AsString = 'I') then
        begin
          //if Ass1 = '' then
          if (Ass1 = '') then //and (selAssenze.FieldByName('PROGRCAUSALE').AsInteger <= 99) then
          begin
            if (selAssenze <> Q041Gest) (*and (QG.FieldByName('SCHEDA').AsString <> 'V')*) then
              VAss:=selAssenze.FieldByName('VALIDAZIONE').AsString;
            Ass1:=selAssenze.FieldByName('Causale').AsString;
            Ass1Competenza:=DecodeCompetenzaAssenza(selAssenze.FieldByName('COMPETENZA').AsString);
            if selAssenze <> Q041Gest then
              if selAssenze.FieldByName('Scheda').AsString <> 'P' then
                Ass1Modif:=False;
          end
          //else
          else if (Ass2 = '') and (Ass1 <> selAssenze.FieldByName('Causale').AsString) then //and (selAssenze.FieldByName('PROGRCAUSALE').AsInteger <> 99) then
          begin
            if (VAss <> 'S') and  (selAssenze <> Q041Gest) (*and (QG.FieldByName('SCHEDA').AsString <> 'V')*) then
              VAss:=selAssenze.FieldByName('VALIDAZIONE').AsString;
            Ass2:=selAssenze.FieldByName('Causale').AsString;
            Ass2Competenza:=DecodeCompetenzaAssenza(selAssenze.FieldByName('COMPETENZA').AsString);
            if selAssenze <> Q041Gest then
              if selAssenze.FieldByName('Scheda').AsString <> 'P' then
                Ass2Modif:=False;
          end;
        end
        else
        //Assenze ad ore/mezza giornata
        begin
          CurrAssenzaOre:=TAssenzaOre.Create();
          CurrAssenzaOre.Causale:=selAssenze.FieldByName('Causale').AsString;
          CurrAssenzaOre.TipoGiust:=selAssenze.FieldByName('TipoGiust').AsString;
          if CurrAssenzaOre.TipoGiust = 'M' then
            CurrAssenzaOre.Orario:='1/2'
          else if CurrAssenzaOre.TipoGiust = 'D' then
            CurrAssenzaOre.Orario:=Format('%s-%s',[FormatDateTime('hh.nn',selAssenze.FieldByName('DAORE').AsDateTime),FormatDateTime('hh.nn',selAssenze.FieldByName('AORE').AsDateTime)])
          else if CurrAssenzaOre.TipoGiust = 'N' then
            CurrAssenzaOre.Orario:=Format('%s',[FormatDateTime('hh.nn',selAssenze.FieldByName('DAORE').AsDateTime)]);
          if (VAss <> 'S') and  (selAssenze <> Q041Gest) then
            VAss:=selAssenze.FieldByName('VALIDAZIONE').AsString;
          AssOre.Add(CurrAssenzaOre);
        end;
        selAssenze.Next;
      end;
    if selPianif.Locate('Data',inData,[]) then
    //Pianificazione manuale esistente
    begin
      Antincendio:=selPianif.FieldByName('Antincendio').AsString;
      Note:=selPianif.FieldByName('Note').AsString;
      Referente:=selPianif.FieldByName('Referente').AsString;
      RichiestoDaTurnista:=selPianif.FieldByName('Richiesto_da_turnista').AsString;
      Area:=selPianif.FieldByName('Area').AsString;
      Ora:=selPianif.FieldByName('Orario').AsString;
      T1:=selPianif.FieldByName('Turno1').AsString;
      T2:=selPianif.FieldByName('Turno2').AsString;
      T1EU:=selPianif.FieldByName('Turno1EU').AsString;
      T2EU:=selPianif.FieldByName('Turno2EU').AsString;
      if (selPianif = Q080) or (selPianif = Q080Gest) then
        ValorGior:=selPianif.FieldByName('ValorGior').AsString;
      Flag:='M';
      exit;
    end;
  end;
  if NuovaPianif then
  //Leggo lo sviluppo della turnazione solo se sto generando una Nuova Turnazione
  begin
    if Posizione = 0 then
      //Non pianifico
    begin
      Flag:='NT';
      exit;
    end;
    if selT082.FieldByName('PIANIF_GG_FEST').AsString = 'N' then
      //Se non si pianificano i giorni festivi controllo i calendari
      if GetTipoGiorno(inData,Prog,QSSquadra.FieldByName('T430CALENDARIO').AsString) = 'FESTIVO' then
      begin
        Flag:='NT';
        exit;
      end;
    //Se si pianifica solamente con Tipo Gestione = turnista, controllo il Tipo Gestione del dipendente
    if (selT082.FieldByName('PIANIF_SOLO_TURN').AsString = 'S') and (QSSquadra.FieldByName('T430TGESTIONE').AsString = '0') then
    begin
      Flag:='NT';
      exit;
    end;
    if not VarToStr(selT620.Lookup('PROGRESSIVO',Prog,'PROGRESSIVO')).IsEmpty then
    begin
      if (GetTipoGiorno(inData,Prog,QSSquadra.FieldByName('T430CALENDARIO').AsString,True) = 'FESTIVO') or
         (GetTipoGiorno(inData,Prog,QSSquadra.FieldByName('T430CALENDARIO').AsString,True) = 'NONLAV') then
      begin
        Flag:='NT';
        Exit;
      end;
    end;

    if Q630.Locate('Data',inData,[]) then
    //Spostamento occasionale di squadra
    begin
      Ora:=Q630.FieldByName('Orario').AsString;
      T1:=Q630.FieldByName('Turno1').AsString;
      T2:=Q630.FieldByName('Turno2').AsString;
      T1EU:='';
      T2EU:='';
      Flag:='CS';
      exit;
    end;
    //Dati da sviluppo turnazione
    Flag:='O';
    T1:=Copy(Turno1[Posizione],1,2);
    T2:=Copy(Turno2[Posizione],1,2);
    T1EU:=Copy(Turno1[Posizione],3,1);
    T2EU:=Copy(Turno2[Posizione],3,1);
    Ora:=Orario[Posizione];
    ValorGior:='';
    if Ass1 = '' then
      Ass1:=Causale[Posizione]
    else if (Ass1 <> Causale[Posizione]) and (Ass2 = '') then
      Ass2:=Causale[Posizione];
    if ((Trim(T1) <> '') or (Trim(T2) <> '')) and (Trim(Ora) = '') then
      //Sono definiti i turni ma non l'orario
    begin
      if Trim(T1) = 'A' then
        exit;
      Ora:=GetOrarioStorico(inData,Prog);
    end;
  end
  else
    //Giorno senza pianificazione
    Flag:='NT';
end;

function TA058FPianifTurniDtM1.GetOrarioStorico(Data:TDateTime; Prog:LongInt):String;
{Leggo l'orario sul profilo da anagrafico}
var G:String;
begin
 Result:='';
  with Q430 do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',Data);
    Open;
    if RecordCount = 0 then
      exit;
    if Trim(FieldByName('POrario').AsString) = '' then
      exit;
  end;
  with Q221 do
  begin
    Close;
    SetVariable('Codice',Q430.FieldByName('POrario').AsString);
    SetVariable('Data',Data);
    Open;
    if RecordCount = 0 then
      exit;
    //Leggo il nome del giorno da cui prendere l'orario sul profilo (Lu..Do,NonLav,Fest
    G:=GetTipoGiorno(Data,Prog,Q430.FieldByName('CALENDARIO').AsString);
    if G <> '' then
      Result:=FieldByName(G).AsString;
  end;
end;

function TA058FPianifTurniDtM1.GetTipoGiorno(Data:TDateTime; Prog:LongInt; Calendario:String; DomNonLav:Boolean = False):String;
{Leggo il tipo giorno da calendario individuale o normale
 DomNonLav = Considera la domenica come giorno non lavorativo}
const GIORNI : array[1..9] of String =
               ('LUNEDI','MARTEDI','MERCOLEDI','GIOVEDI','VENERDI',
                'SABATO','DOMENICA','NONLAV','FESTIVO');
begin
  Result:='';
  (*
  //Leggo calendario individuale
  with Q012 do
    begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',Data);
    Open;
    if RecordCount > 0 then
      begin
      Result:=GIORNI[DayOfWeek(Data - 1)];
      if (FieldByName('Lavorativo').AsString = 'N') and ((DayOfWeek(Data - 1) <> 7) or DomNonLav) then
        Result:=GIORNI[8];
      if FieldByName('Festivo').AsString = 'S' then
        Result:=GIORNI[9];
      exit;
      end;
    end;
  //Leggo calendario da anagrafico
  with Q011 do
    begin
    Close;
    SetVariable('Codice',Calendario);
    SetVariable('Data',Data);
    Open;
    if RecordCount > 0 then
      begin
      Result:=GIORNI[DayOfWeek(Data - 1)];
      if (FieldByName('Lavorativo').AsString = 'N') and ((DayOfWeek(Data - 1) <> 7) or DomNonLav)then
        Result:=GIORNI[8];
      if FieldByName('Festivo').AsString = 'S' then
        Result:=GIORNI[9];
      end;
    end;
  *)
  (*
  if (GetCalend.GetVariable('PROG') <> Prog) or (GetCalend.GetVariable('D') <> Data) then
  begin
    GetCalend.SetVariable('PROG',Prog);
    GetCalend.SetVariable('D',Data);
    GetCalend.Execute;
  end;
  *)
  R180SetVariable(selV010,'PROGRESSIVO',Prog);
  if (Data < selV010.GetVariable('DAL')) or (Data > selV010.GetVariable('AL')) then
  begin
    selV010.SetVariable('DAL',Data);
    selV010.SetVariable('AL',Data);
    selV010.Close;
  end;
  R180SetVariable(selV010,'DAL',DataInizio);
  R180SetVariable(selV010,'AL',DataFine);
  selV010.Open;

  Result:=GIORNI[DayOfWeek(Data - 1)];
  if (VarToStr(selV010.Lookup('DATA',Data,'LAVORATIVO')) = 'N') and ((DayOfWeek(Data - 1) <> 7) or DomNonLav) then
    Result:=GIORNI[8];
  if VarToStr(selV010.Lookup('DATA',Data,'FESTIVO')) = 'S' then
    Result:=GIORNI[9];
end;

procedure TA058FPianifTurniDtM1.A058FPianifTurniDtM1Destroy(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TDataSet then
    begin
      (Self.Components[i] as TDataSet).Close;
    end;
  end;
  FreeAndNil(A058PCKT080TURNO);
  selDatiBloccatiA058.Free;
  QSSquadra.Free;
  ListaCicli.Free;
  Turno1.Free;
  Turno2.Free;
  Orario.Free;
  Causale.Free;
  FreeAndNil(xValoreOrigine);
  FreeAndNil(Vista);
  FreeAndNil(R502ProDtM);
end;

procedure TA058FPianifTurniDtM1.SelAnagrafeFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  try
    Accept:=(DataSet.FieldByName('T430FINE').AsDateTime >= DataInizio) or
            DataSet.FieldByName('T430FINE').IsNull or (DataSet.FieldByName('T430FINE').AsDateTime = 0);
    Accept:=Accept and (DataSet.FieldByName('T430INIZIO').AsDateTime <= DataFine);
  except
    Accept:=False;
  end;
end;

procedure TA058FPianifTurniDtM1.selT265EsclusioneBeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA058FPianifTurniDtM1.selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('SQUADRE TURNI',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA058FPianifTurniDtM1.FilterRecordT606(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=R180Between(FiltroT606.Data,DataSet.FieldByName('DECORRENZA').AsDateTime,DataSet.FieldByName('DECORRENZA_FINE').AsDateTime)
          and
          ((DataSet.FIndField('COD_CONDIZIONE') = nil) or (DataSet.FieldByName('COD_CONDIZIONE').AsString = FiltroT606.Condizione))
          and
          (DataSet.FieldByName('COD_GIORNO').AsString = FiltroT606.Giorno);
end;

procedure TA058FPianifTurniDtM1.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  if (DataSet = Q265) or (DataSet = Q265B) then
  begin
    Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString);
    if EscludiTipoCumulo then
      Accept:=Accept and (DataSet.FieldByName('TIPOCUMULO').AsString = 'H');
  end
  else if DataSet = Q020 then
    Accept:=A000FiltroDizionario('MODELLI ORARIO',DataSet.FieldByName('CODICE').AsString) and
            R180InConcat(DataSet.FieldByName('CODICE').AsString,selT606c.FieldByName('VALORE').AsString)
  else if DataSet = selT082 then
    Accept:=A000FiltroDizionario('PROFILI PIANIF. TURNI',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA058FPianifTurniDtM1.ImpostaFiltroOrariSquadra(DataRif:TDateTime);
begin
  //Recupero la condizione di filtro sui codici orario a livello di squadra
  R180SetVariable(selT606c,'PROGRESSIVO',-1); //Non individuale
  R180SetVariable(selT606c,'COD_SQUADRA',SquadraRiferimento);
  R180SetVariable(selT606c,'COD_TIPOOPE','*'); //Tutti i tipi operatore
  R180SetVariable(selT606c,'COD_ORARIO','*'); //Tutti gli orari
  R180SetVariable(selT606c,'SIGLA_TURNO','*'); //Tutte le sigle turno
  R180SetVariable(selT606c,'COD_GIORNO','*'); //Tutti i giorni
  R180SetVariable(selT606c,'COD_CONDIZIONE','00000'); //Lettura codici orario
  if (not selT606c.Active) or (not R180Between(DataRif,selT606c.FieldByName('DECORRENZA').AsDateTime,selT606c.FieldByName('DECORRENZA_FINE').AsDateTime)) then
    R180SetVariable(selT606c,'DATA',DataRif); //Data specifica
  selT606c.Open;
  selT606c.First;
end;

function TA058FPianifTurniDtM1.GetTipoGiornoServizio(D:TDateTime):String;
{Restituisce l'alternanza dei giorni festivi/feriali legati alla pianificazione dei Servizi (FIRENZE_COMUNE)}
var x:Byte;
    Festivo:Boolean;
    DataPrimoFestivo,DataPrimoGiornaliero:TDateTime;
begin
  Result:='';
  try
    if not selT530.Active then
      exit;
    if selT530.RecordCount = 0 then
      exit;
    DataPrimoFestivo:=selT530.FieldByName('DATA_PRIMOGGFES').AsDateTime;
    DataPrimoGiornaliero:=selT530.FieldByName('DATA_PRIMOGGLAV').AsDateTime;
    with selT011 do
    begin
      SetVariable('CODICE',selT530.FieldByName('CALENDARIO').AsString);
      SetVariable('DATA1',Min(DataPrimoFestivo,DataPrimoGiornaliero));
      if D > GetVariable('DATA2') then
      begin
        SetVariable('DATA2',D);
        Close;
      end;
      Open;
      if not SearchRecord('DATA',D,[srFromEnd]) then
        exit;
      if (FieldByName('FESTIVO').AsString = 'S') or (DayOfWeek(D) = 1) then
      begin
        Festivo:=True;
        if SearchRecord('DATA',DataPrimoFestivo,[srFromBeginning]) then
          Result:='F'
        else
          exit;
      end
      else
      begin
        Festivo:=False;
        if SearchRecord('DATA',DataPrimoGiornaliero,[srFromBeginning]) then
          Result:='G'
        else
          exit;
      end;
      x:=0;
      while not Eof do
      begin
        if FieldByName('DATA').AsDateTime > D then
          Break;
        if Festivo then
        begin
          if (FieldByName('FESTIVO').AsString = 'S') or (DayOfWeek(FieldByName('DATA').AsDateTime) = 1) then
          begin
            inc(x);
            if x > selT530.FieldByName('ALTERNANZA_GGFES').AsInteger then
              x:=1;
          end;
        end
        else
        begin
          if (FieldByName('FESTIVO').AsString = 'N') and (DayOfWeek(FieldByName('DATA').AsDateTime) > 1) then
          begin
            inc(x);
            if x > selT530.FieldByName('ALTERNANZA_GGLAV').AsInteger then
              x:=1;
          end;
        end;
        Next;
      end;
      if x > 0 then
        Result:=Result + IntToStr(x);
    end;
  except
  end;
end;

//==============================================================================
//==================PROCEDURE INERENTI ALLA VERIFICA DEI TURNI==================
//==============================================================================
function TA058FPianifTurniDtM1.ModificaData(InDate:TDateTime;AA,MM,GG:Word):TDateTime;
var A,M,G:Word;
begin
  try
    DecodeDate(InDate,A,M,G);
    if (AA > 0) then
      A:=AA;
    if MM > 0 then
      M:=MM - (12 * (MM div 13));
    if GG > 0 then
      G:=GG;
    if (MM div 13 > 0) then
      A:=A + (MM div 13);
  except
  end;
  Result:=EncodeDate(A,M,G);
end;

function TA058FPianifTurniDtM1.ControlloSuccTurn(ProgDip:Integer;DataIn:TDateTime;TurnoOggi:String):Boolean;
//Controllo che non si verifichino casi: 3 -> 1, 2 -> 3, 1 -> 3, 3 -> 2
var
  Ind:Integer;
  Ret:Boolean;
  TurnoIeri,TurnoDomani:String;
begin
  Ret:=True;
  TurnoIeri:='NULL';
  TurnoDomani:='NULL';
  {/*PERIODO ELABORAZIONE*/
  Ind:=Trunc(DataIn - ModificaData(DataIn,0,1,1)) - 1;}
  Ind:=Trunc(DataIn - Vista[0].Giorni[0].Data) - 1;
  if Ind >= 0 then
    TurnoIeri:=Vista[ProgDip].Giorni[Ind].NumTurno1;
  if Ind + 2 <= Vista[0].Giorni.Count - 1 then
    TurnoDomani:=Vista[ProgDip].Giorni[Ind + 2].NumTurno1;
  if ((TurnoOggi = '1') or (TurnoOggi = '2')) and (TurnoIeri = '3') then
    Ret:=False;
  if (TurnoOggi = '3') and ((TurnoDomani = '1') or (TurnoDomani = '2')) then
    Ret:=False;
  if (TurnoIeri = 'NULL') and (TurnoDomani = 'NULL') then
    Ret:=False;

  Result:=Ret;
end;

procedure TA058FPianifTurniDtM1.AnomalieXDipendente(Dipendente:TDipendente);
var
  DataElaborazioneDa, DataElaborazioneA:TDateTime;
begin
  DataElaborazioneDa:=Dipendente.Giorni[0].Data;
  DataElaborazioneA:=Dipendente.Giorni[Dipendente.Giorni.Count - 1].Data;
  Dipendente.Controllo_IntegritaTurniNotturni(DataElaborazioneDa, DataElaborazioneA);
  Dipendente.Controllo_IntersezioneReperibilita(DataElaborazioneDa, DataElaborazioneA);
  Dipendente.Controllo_11ore(DataElaborazioneDa, DataElaborazioneA);
  Dipendente.Controllo_35Ore(DataElaborazioneDa, DataElaborazioneA);
  if Self.IsIntervalloMensile(DataElaborazioneDa,DataElaborazioneA) then
  begin
    Dipendente.Controllo_MinFestivitaMese(DataElaborazioneDa, DataElaborazioneA);
    Dipendente.Controllo_MaxNottiMese(DataElaborazioneDa, DataElaborazioneA);
  end;
end;

procedure TA058FPianifTurniDtM1.VerificaPianificazione(DataElabDa,DataElabA:TDateTime);
type
  TSquadre = record
    Squadra:String;
    Operatore:String;
  end;

  TNTurni = record
    Numero:Integer;
    Deficit:String;
  end;

//==============================
//DICHIARAZIONE VARIABILI LOCALI
//==============================
var
  AInizio,AFine,DataCorr:TDateTime;
  ICorr,xx,yy:Integer;
  VetSquadre:array of TSquadre;
  G:TGiustificativo;
  VistaPeriodo:TListDip;

//========================================
//DICHIARAZIONE SOTTO PROCEDURE E FUNZIONI
//========================================
  procedure RegAnom(Indice:Integer;DataModifica,DataA:TDateTime;Msg:String);
  var Nominativo,Data,DataFine:String;
      MaxLength,i:Integer;
  begin
    if Not((Indice >= -1) and (Indice < Vista.Count)) {and (EseguiLog)} then
      Exit;
    MaxLength:=0;
    if Indice >= 0 then
    begin
      for i:=0 to Vista.Count - 1 do
      begin
        Nominativo:=Vista[i].Cognome + ' ' + Vista[i].Nome;
        if Length(Nominativo) > MaxLength then
          MaxLength:=Length(Nominativo);
      end;
      AnomaliePianif:=True;
      Nominativo:=Vista[Indice].Cognome + ' ' + Vista[Indice].Nome + ':';
    end;
    Data:=' Data: ' + DateToStr(DataModifica);
    DataFine:=' - ' + DateToStr(DataA);
    if DataModifica = 0 then
      Data:='';
    if DataA = 0 then
      DataFine:='';
    Data:=Data + DataFine;
    if Indice > -1 then
      RegistraMsg.InserisciMessaggio('A',Format('%-*.*s',[MaxLength,MaxLength,Nominativo]) + Data + ' ' + Msg,'',Vista[Indice].Prog)
    else
      RegistraMsg.InserisciMessaggio('A',Format('%-*.*s',[MaxLength,MaxLength,Nominativo]) + Data + ' ' + Msg,'',0);
  end;

  function ElabPeriodo(Data:TDateTime;Periodo:Integer;DIF:String):TDateTime;
  //Calcola in output la Data di Inizio o Fine perido(in base al parametro DIF)
  //il parametro periodo controlla che il periodo sia un divisore di 12(mesi - (1 anno))
  //il parametro (periodo) viene valorizzato dalla maschera di definizione parametri
  var
    Ret,DataIni,DataFine,DataTemp:TDateTime;
    AA,MM,GG:Word;
    i:Integer;
  begin
    Result:=0;
    DataIni:=0;
    DataFine:=0;
    if Not(Periodo in [1,2,3,4,6,12]) then
      Exit;
    DecodeDate(Data,AA,MM,GG);
    DataTemp:=ModificaData(Data,AA,1,1);
    for i:=0 to (12 div Periodo)-1 do
    begin
      DataIni:=ModificaData(DataTemp,AA,1 + (i * Periodo) ,1);
      DataFine:=ModificaData(DataTemp,AA,1 + ((i + 1) * periodo),1)-1;
      if (Data >= DataIni) and (Data <= DataFine) then
        Break;
    end;
    if DIF = 'INIZIO' then
      Ret:=DataIni
    else
      Ret:=DataFine;
    Result:=Ret;
  end;

  function ControlloAss(Dip,Gio:Integer):Boolean;
  var Ret:Boolean;
  begin
    Ret:=False;
    if (Vista[Dip].Giorni[Gio].Ass1 <> '') or
       (Vista[Dip].Giorni[Gio].Ass2 <> '') then
      Ret:=True;
    Result:=Ret;
  end;

  function GetNumSquadra(GG:TDateTime;Sigla,Squad:String;Oper:String):Integer;
  //Calcola il numero dei dipendenti presenti in un turno, in una squadra e in un
  //determinato giorno(se Oper è valorizzato fa un ulteriore distinzione per operatore)
  var IndGio,i,Ret:Integer;
      TempSquad,TempSigla:String;
    //Se riconosce la presenza di più operatori all'interno della vista
    //ritorna true
    function PiuOperatori:Boolean;
    var Ind:Integer;
        Operatore:String;
    begin
      Result:=False;
      Operatore:=Vista[0].Giorni[IndGio].Oper;
      for Ind:=0 to Vista.Count - 1 do
        if Vista[Ind].Giorni[IndGio].Oper <> Operatore then
        begin
          Result:=True;
          Break;
        end;
    end;
  begin
    IndGio:=Trunc(GG - AInizio);
    Ret:=0;
    Oper:=Trim(Oper);

    for i:=0 to Vista.Count-1 do
    begin
      TempSigla:='NULL';
      if (Vista[i].Giorni[IndGio].T1EU <> 'U') then
        TempSigla:=Vista[i].Giorni[IndGio].SiglaT1;

      TempSquad:=Vista[i].Giorni[IndGio].Squadra;
      if (Squad = TempSquad) and ('(' + Sigla + ')' = TempSigla) and
         (Vista[i].Giorni[IndGio].Flag <> 'NT') and
         not ControlloAss(i,IndGio) then
        if (Oper = Vista[i].Giorni[IndGio].Oper) or not PiuOperatori then
          Inc(Ret);
    end;
    Result:=Ret;
  end;

  procedure GetSquadre(GG:TDateTime);
  //Prende squadre e operatori del giorno designato
  //NB:Prima di richiamarla ripulire il vettore "VetSquadre" = "SetLength(VetSquadre,0)"
  var
    IndGio,i,j,k:Integer;
    TempSquadra,TempOper:String;
    Trovato:Boolean;
  begin
    IndGio:=Trunc(GG - AInizio);
    for i:=0 to Vista.Count - 1 do
    begin
      TempSquadra:=Vista[i].Giorni[IndGio].Squadra;
      TempOper:=Vista[i].Giorni[IndGio].Oper;
      if TempSquadra <> '' then
      begin
        //Ricerca di valori già esistenti
        Trovato:=False;
        for k:=Low(VetSquadre) to High(VetSquadre) do
          if (VetSquadre[k].Squadra = TempSquadra) and (VetSquadre[k].Operatore = TempOper) then
            Trovato:=True;
        if not Trovato then
        begin
          SetLength(VetSquadre,Length(VetSquadre) + 1);
          j:=High(VetSquadre);
          //Carico Squadra e Operatore
          VetSquadre[j].Squadra:=TempSquadra;
          VetSquadre[j].Operatore:=TempOper;
        end;
      end;
    end;
  end;

  procedure GeneraLogAnomalie;
  var
    i,j,k,Numero,TempMese:Integer;
    DataScorr:TDateTime;
    Squadra,MemLog:String;
    DtsMsg:TClientDataSet;
    EntrataMinuti, UscitaMinuti:integer;
  begin
    AnomaliePianif:=False;
    //Reset anomalie
    Vista.PropElencoAnomalie.RegistraAnomalieDB:=True;
    //Vista.ClearAnomalie;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie integrità turni notturni>>');
    for i:=0 to Vista.Count - 1 do
    begin
      Vista[i].Controllo_IntegritaTurniNotturni(DataElabDa,DataElabA);
    end;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie controllo riposi 11 ore>>');
    for i:=0 to Vista.Count - 1 do
    begin
      Vista[i].Controllo_11Ore(DataElabDa,DataElabA);
    end;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie controllo riposi 35 ore>>');
    for i:=0 to Vista.Count - 1 do
    begin
      Vista[i].Controllo_35Ore(DataElabDa,DataElabA);
    end;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie controllo intersezioni turni infermieristici - turni di reperebilità>>');
    for i:=0 to Vista.Count - 1 do
    begin
      Vista[i].Controllo_IntersezioneReperibilita(DataElabDa,DataElabA);
    end;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie pianificazione turni antincendio>>');
    Vista.Controllo_TurnoAntincendio(DataElabDa,DataElabA);
    // Controllo referente turno
    RegistraMsg.InserisciMessaggio('A','<<Anomalie pianificazione referenti turni>>');
    Vista.Controllo_Referente(DataElabDa,DataElabA);
    // Numero minimo di riposi festivi per mese
    RegistraMsg.InserisciMessaggio('A','<<Anomalie numero minimo di riposi festivi nel mese>>');
    if Self.IsIntervalloMensile(DataElabDa,DataElabA) then
    begin
      for i:=0 to Vista.Count - 1 do
      begin
        Vista[i].Controllo_MinFestivitaMese(DataElabDa,DataElabA);
      end;
    end
    else
    begin
      RegistraMsg.InserisciMessaggio('A','Controllo saltato, il periodo di elaborazione non è mensile');
    end;
    // Numero massimo di turni notturni per mese
    RegistraMsg.InserisciMessaggio('A','<<Anomalie numero massimo di turni notturni nel mese>>');
    if Self.IsIntervalloMensile(DataElabDa,DataElabA) then
    begin
      for i:=0 to Vista.Count - 1 do
      begin
        Vista[i].Controllo_MaxNottiMese(DataElabDa,DataElabA);
      end;
    end
    else
    begin
      RegistraMsg.InserisciMessaggio('A','Controllo saltato, il periodo di elaborazione non è mensile');
    end;

    Vista.PropElencoAnomalie.RegistraAnomalieDB:=False;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie Massimi e minimi giornalieri>>');
    DataScorr:=DataElabDa;
    //Scorro sui giorni del periodo pianificato
    while DataScorr <= DataElabA do
    begin
      SetLength(VetSquadre,0);
      GetSquadre(DataScorr);
      //Scorro sulle squadre e operatori pianificati
      for i:=Low(VetSquadre) to High(VetSquadre) do
      begin
        Squadra:=VetSquadre[i].Squadra + '(' + VetSquadre[i].Operatore + ') ';
        //Recupero i massimi e i minimi
        R180SetVariable(selT606,'PROGRESSIVO',-1); //Non individuale
        R180SetVariable(selT606,'COD_ORARIO','*'); //Tutti gli orari
        R180SetVariable(selT606,'COD_SQUADRA',VetSquadre[i].Squadra);
        R180SetVariable(selT606,'COD_TIPOOPE',VetSquadre[i].Operatore);
        selT606.Open;
        try
          FiltraT606(selT606,DataScorr,'00001',A058PCKT080TURNO.CalcolaTipoGiorno(Vista[0].Prog,DataScorr,'S'));
          if selT606.RecordCount = 0 then
            FiltraT606(selT606,DataScorr,'00001',IntToStr(DayOfWeek(DataScorr - 1)));
          if selT606.RecordCount = 0 then
            FiltraT606(selT606,DataScorr,'00001','*');
          //Scorro le sigle turno per cui sono stati impostati i massimi e i minimi
          selT606.First;
          while not selT606.Eof do
          begin
            Numero:=GetNumSquadra(DataScorr,selT606.FieldByName('SIGLA_TURNO').AsString,VetSquadre[i].Squadra,VetSquadre[i].Operatore);
            if Numero < selT606.FieldByName('MINIMO').AsInteger then
              RegAnom(-1,0,0,Squadra + ' Data:' + DateToStr(DataScorr) + ' Numero dei dipendenti in squadra per il turno ' + selT606.FieldByName('SIGLA_TURNO').AsString + ' minore di quelli previsti.'
                                     + #13#10 + '(Assegnati:' + IntToStr(Numero) + ' - Previsti:' + IntToStr(selT606.FieldByName('MINIMO').AsInteger) + ')');
            if Numero > selT606.FieldByName('MASSIMO').AsInteger then
              RegAnom(-1,0,0,Squadra + ' Data:' + DateToStr(DataScorr) + ' Numero dei dipendenti in squadra per il turno ' + selT606.FieldByName('SIGLA_TURNO').AsString + ' maggiore di quelli previsti.'
                                     + #13#10 + '(Assegnati:' + IntToStr(Numero) + ' - Previsti:' + IntToStr(selT606.FieldByName('MASSIMO').AsInteger) + ')');
            selT606.Next;
          end;
        finally
          selT606.Filtered:=False;
      end;
      end;
      DataScorr:=DataScorr + 1;
    end;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie di successione nei turni>>');
    DataScorr:=DataElabDa;
    k:=Trunc(DataScorr - AInizio);
    while DataScorr <= DataElabA do
    begin
      if (k > 0) and (k < Vista.Count - 1) then
        for i:=0 to Vista.Count - 1 do
          if Not ControlloSuccTurn(i,DataScorr,Vista[i].Giorni[k].NumTurno1) then
            RegAnom(i,DataScorr,0,'Pianificato turno di mattino o pomeriggio dopo turno notturno.');
      DataScorr:=DataScorr + 1;
      inc(k);
    end;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie riposi nell''anno>>');
    DtsMsg:=TClientDataSet.Create(nil);
    DtsMsg.FieldDefs.Add('MESSAGGIO',ftString,100,False);
    DtsMsg.CreateDataSet;
    DtsMsg.Open;
    for TempMese:=R180Mese(DataElabDa) to R180Mese(DataElabA) do
    begin
      for i:=0 to Vista.Count - 1 do
      begin
        MemLog:=IntToStr(i) + DateToStr(AInizio) + DateToStr(AFine) + 'Numero di riposi nell''anno minori di ' + IntToStr(Vista[i].CompRip) + '(' + IntToStr(Vista[i].RiposiPrec) + ')';
        MemLog:=UpperCase(MemLog);
        if (Vista[i].RiposiPrec < Vista[i].CompRip) and
           (VarToStr(DtsMsg.Lookup('MESSAGGIO',MemLog,'MESSAGGIO')) = '') then
        begin
          RegAnom(i,AInizio,AFine,'Numero di riposi nell''anno minori di ' + IntToStr(Vista[i].CompRip) + '(' + IntToStr(Vista[i].RiposiPrec) + ')');
          DtsMsg.Insert;
          DtsMsg.FieldByName('MESSAGGIO').AsString:=UpperCase(MemLog);
          DtsMsg.Post;
        end;
        MemLog:=IntToStr(i) + DateToStr(AInizio) + DateToStr(AFine) + 'Numero di riposi nell''anno maggiore di ' + IntToStr(Vista[i].CompRip) + '(' + IntToStr(Vista[i].RiposiPrec) + ')';
        MemLog:=UpperCase(MemLog);
        if (Vista[i].RiposiPrec > Vista[i].CompRip) and
           (VarToStr(DtsMsg.Lookup('MESSAGGIO',MemLog,'MESSAGGIO')) = '') then
        begin
          RegAnom(i,AInizio,AFine,'Numero di riposi nell''anno maggiore di ' + IntToStr(Vista[i].CompRip) + '(' + IntToStr(Vista[i].RiposiPrec) + ')');
          DtsMsg.Insert;
          DtsMsg.FieldByName('MESSAGGIO').AsString:=UpperCase(MemLog);
          DtsMsg.Post;
        end;
      end;
    end;
    DtsMsg.Close;
    FreeAndNil(DtsMsg);
    if (TempMese mod 2) <> 0 then
      MemLog:='';
  end;

  procedure RipristinoVista;
  begin
    PulisciVista;
    SelAnagrafeA058.First;
    while Not(SelAnagrafeA058.Eof) do
    begin
      LeggiPianificazione(SelAnagrafeA058.FieldByName('PROGRESSIVO').AsInteger,
                          DataElabDa,DataElabA);
      SelAnagrafeA058.Next;
      {$IFNDEF IRISWEB}
      Application.ProcessMessages;
      {$ENDIF}
    end;
  end;
//====================================
//IMPLEMENTAZIONE PROCEDURA PRINCIPALE
//====================================
begin
  RegistraMsg.IniziaMessaggio('A058');
  {/*PERIODO ELABORAZIONE*/}
  if ControlloAnnualeAnomalie then
  begin
    AInizio:=ModificaData(DataElabDa,0,1,1);
    AFine:=ModificaData(DataElabA,0,12,31);
  end
  else
  begin
    AInizio:=DataElabDa;
    AFine:=DataElabA;
  end;
  {$IFNDEF IRISWEB}
  A058FGrigliaPianif.PGVista.Min:=0;
  A058FGrigliaPianif.PGVista.Max:=1;
  A058FGrigliaPianif.PGVista.Position:=0;
  {$ENDIF}
  ElaborazioneInterrotta:=False;
  Screen.Cursor:=crHourGlass;
  try
    {$IFNDEF IRISWEB}
    {/*PERIODO ELABORAZIONE*/}
    if ControlloAnnualeAnomalie then
    begin
      if A058FGrigliaPianif.DatoModificato or (DataInizio <> ModificaData(DataInizio,0,1,1)) or
        (DataFine <> ModificaData(DataFine,0,12,31)) then
      begin
        //BackUp vista periodo sèpecificato dall'utente
        VistaPeriodo:=Vista.CopyListaDipendenti;

        PulisciVista;
        SelAnagrafeA058.First;
        while Not SelAnagrafeA058.Eof do
        begin
          A058FGrigliaPianif.LblOPerazioni.Caption:='Caricamento annuale vista: ' +
                                                    SelAnagrafeA058.FieldByName('COGNOME').AsString +
                                                    ' ' + SelAnagrafeA058.FieldByName('NOME').AsString;
          {$IFNDEF IRISWEB}
          Application.ProcessMessages;
          {$ENDIF}
          LeggiPianificazione(SelAnagrafeA058.FieldByName('PROGRESSIVO').AsInteger,
                              AInizio,AFine);

          SelAnagrafeA058.Next;
          if ElaborazioneInterrotta then
            Break;
          {$IFNDEF IRISWEB}
          Application.ProcessMessages;
          {$ENDIF}
        end;
        //Riporto il periodo specificato dall'utente sulla vista annuale appena caricata
        for xx:=0 to Vista.Count - 1 do
        begin
          DataCorr:=DataElabDa;
          while DataCorr <= DataElabA do
          begin
            ICorr:=Trunc(DataCorr - AInizio);
            for yy:=0 to VistaPeriodo[xx].Giorni.count - 1 do
            begin
              if (Vista[xx].Giorni[ICorr].Data = VistaPeriodo[xx].Giorni[yy].Data) and
                 VistaPeriodo[xx].Giorni[yy].Modificato then
              begin
                Vista[xx].Giorni[ICorr]:=VistaPeriodo[xx].Giorni[yy].CopyGiorno;
              end;
            end;
            DataCorr:=DataCorr + 1;
          end;
        end;
        FreeAndNil(VistaPeriodo);
        A058FGrigliaPianif.PGVista.Position:=A058FGrigliaPianif.PGVista.Position + 1;
      end;
    end;
    {$ENDIF}
    if ElaborazioneInterrotta then
    begin
      RipristinoVista;
      Exit;
    end;
    ICorr:=Trunc(DataElabDa - AInizio);
    OffsetVista:=ICorr;
    //===================================================
    //CARICAMENTO DELLE COMPETENZE DEI RIPOSI NEL PERIODO
    //===================================================
    R600DtM:=TR600DtM1.Create(nil);
    try
      for xx:=0 to Vista.Count - 1 do
      begin
        G.Inserimento:=False;
        G.Modo:='I';
        G.Causale:=Vista[xx].CausRip;
        R600DtM.GetAssenze(Vista[xx].Prog,DataElabDa,DataElabA,0,G);
        Vista[xx].CompRip:=Trunc(R600DtM.ValCompTot);
      end;
    finally
      FreeAndNil(R600DtM);
    end;

    GeneraLogAnomalie;
  finally
    {$IFNDEF IRISWEB}
    if A058FGrigliaPianif <> nil then
      A058FGrigliaPianif.PGVista.Position:=0;
    {$ENDIF}
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA058FPianifTurniDtm1.LeggiValoriCella(iDipendente:Integer;iGiorno:Integer);
begin
  //Leggo i valori presenti nella cella
  sOperatore:=Vista[iDipendente].Giorni[iGiorno].Oper;
  sNumTurno1:=Vista[iDipendente].Giorni[iGiorno].NumTurno1;
  sSiglaT1:=Vista[iDipendente].Giorni[iGiorno].SiglaT1;
  sT1:=Vista[iDipendente].Giorni[iGiorno].T1;
  sT1EU:=Vista[iDipendente].Giorni[iGiorno].T1EU;
  sAss1:=Vista[iDipendente].Giorni[iGiorno].Ass1;
  sNumTurno2:=Vista[iDipendente].Giorni[iGiorno].NumTurno2;
  sSiglaT2:=Vista[iDipendente].Giorni[iGiorno].SiglaT2;
  sT2:=Vista[iDipendente].Giorni[iGiorno].T2;
  sT2EU:=Vista[iDipendente].Giorni[iGiorno].T2EU;
  sAss2:=Vista[iDipendente].Giorni[iGiorno].Ass2;
end;

function TA058FPianifTurniDtm1.GetCellaUI(IndDipendente,IndGiorno: Integer; Opzioni:TGetCellaUIOpzioni; WinUITabellaInfo: TWinUITabellaInfo=nil):TCellaUI;
var
  Giorno:TGiorno;
  CellaUI:TCellaUI;
  BloccaColoreSfondo,IsModificato:Boolean;
  ElementoCellaUI,SottoElementoCellaUI:TElementoCellaUI;
  IndicatoreCellaUI:TIndicatoreCellaUI;
  CurrAssOre:TAssenzaOre;
  function EstraiSiglaTurno(const S:String):String;
  begin
    Result:=IfThen(Length(S) >=2, Trim(Copy(S,2,Length(S) - 2)), S);
  end;
begin
  // Recupero il giorno, se esistente.
  if (IndDipendente > Vista.Count) then
    raise Exception.Create('Indice dipendente fuori dai limiti.');
  if (IndGiorno > Vista[IndDipendente].Giorni.Count) then
    raise Exception.Create('Indice giorno fuori dai limiti.');
  Giorno:=Vista[IndDipendente].Giorni[IndGiorno];
  GetAreeAfferenza(Giorno.Squadra,Giorno.Oper);
  CellaUI:=TCellaUI.Create;
  BloccaColoreSfondo:=False;
  try
    ElementoCellaUI:=nil;
    SottoElementoCellaUI:=nil;
    IndicatoreCellaUI:=nil;

    // Imposto lo sfondo
    CellaUI.SfondoWin:=clWhite; // default

    if (Giorno.Flag = 'M') then
    //Pianificazione manuale già esistente (Giallo)
    begin
      CellaUI.SfondoWin:=$0080FFFF;
      CellaUI.ClasseSfondoWeb:='bg_giallo_pastello';
      //modifico colore sfondo della cella se indicata area
      if (Giorno.Area <> '') and
         (selT651.SearchRecord('CODICE_AREA',Giorno.Area,[srFromBeginning])) then
        if (selT651.FieldByName('COLORE').AsString <> '') then
        begin
          CellaUI.SfondoWin:=getColoreCellaWIN(selT651.FieldByName('COLORE').AsString);
          CellaUI.ClasseSfondoWeb:=getColoreClassWEB(selT651.FieldByName('COLORE').AsString);
        end;
    end
    else if (Giorno.Flag = 'O') then
    //Pianificazione da turnazione (Verde)
    begin
      CellaUI.SfondoWin:=$0069E473;//clLime;
      CellaUI.ClasseSfondoWeb:='bg_verde_pastello';
    end
    else if (Giorno.Flag = 'CS') then
    //Pianificazione da cambio squadra (Azzurro)
    begin
      CellaUI.SfondoWin:=clAqua;
      CellaUI.ClasseSfondoWeb:='bg_aqua';
    end
    else if (Giorno.Squadra <> Self.SquadraRiferimento) then
    //Colore per assenza cambio squadra
    begin
      BloccaColoreSfondo:=True;
      CellaUI.SfondoWin:=$00DDDDDD;
      CellaUI.ClasseSfondoWeb:='bg_grigio_argento';
    end;

    if ((Trim(Giorno.T1) = '0') or (Trim(Giorno.T1) = '') or (Giorno.Ass1Modif=False) or (Trim(Giorno.Ass1) <> '') or (Trim(Giorno.Ass2) <> '') or
        TestSmontoNotte(Giorno) or
        (Trim(Giorno.T1) = ' M') and ((Trim(Giorno.Ass1) <> '') or (Trim(Giorno.Ass2) <> ''))) and not BloccaColoreSfondo then
    begin
      CellaUI.SfondoWin:=clWhite;
      CellaUI.ClasseSfondoWeb:='';
    end;

    IsModificato:=Giorno.Modificato;

    // Modello orario (solo su WEB, stesso stile dei turni)
    if (Trim(Giorno.Ora) <> '') then
    begin
      ElementoCellaUI:=TElementoCellaUI.Create;
      ElementoCellaUI.TipoElementoCellaUI:=tecModelloOrario;
      if not IsModificato then
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecTurno
      else
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecModificato;
      ElementoCellaUI.WebProprieta.Testo:='MO: ' + Giorno.Ora;
      ElementoCellaUI.WebProprieta.TestoSintetico:=''; // Non visibile in forma sintetica
      ElementoCellaUI.WinProprieta.Invisibile:=true;
      CellaUI.Elementi.Add(ElementoCellaUI);
      ElementoCellaUI:=nil;
    end;

    // Turno 1
    if Trim(Giorno.T1) <> '' then
    begin
      ElementoCellaUI:=TElementoCellaUI.Create;
      ElementoCellaUI.TipoElementoCellaUI:=tecTurno;
      if not IsModificato then
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecTurno
      else
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecModificato;
      ElementoCellaUI.WinProprieta.TestoSintetico:=Format('%2s%s%-3s',[Giorno.T1, Giorno.T1EU, IfThen(Giorno.SiglaT1 <> '','.') + EstraiSiglaTurno(Giorno.SiglaT1)]);
      ElementoCellaUI.WinProprieta.Testo:=Format('%-6s %s',[ElementoCellaUI.WinProprieta.TestoSintetico,R180DimLung(Giorno.Ora,5)]);
      if (WinUITabellaInfo <> nil) then
      begin
        ElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
        ElementoCellaUI.WinProprieta.RectDisegno.Bottom:=ElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.AltezzaRiga;
      end;
      ElementoCellaUI.WebProprieta.TestoSintetico:=Giorno.T1 + Giorno.T1EU + IfThen(Giorno.SiglaT1 <> '','.') + EstraiSiglaTurno(Giorno.SiglaT1);
      ElementoCellaUI.WebProprieta.Testo:='T1:' + ElementoCellaUI.WebProprieta.TestoSintetico;
      CellaUI.Elementi.Add(ElementoCellaUI);
      Inc(CellaUI.NumRigheElementiWin);
      ElementoCellaUI:=nil;
    end;
    // Turno 2
    if Trim(Giorno.T2) <> '' then
    begin
      ElementoCellaUI:=TElementoCellaUI.Create;
      ElementoCellaUI.TipoElementoCellaUI:=tecTurno;
      if not IsModificato then
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecTurno
      else
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecModificato;
      ElementoCellaUI.WinProprieta.TestoSintetico:=Format('%2s%s%-3s',[Giorno.T2, Giorno.T2EU, IfThen(Giorno.SiglaT2 <> '','.') + EstraiSiglaTurno(Giorno.SiglaT2)]);
      ElementoCellaUI.WinProprieta.Testo:=Format('%-6s %s',[ElementoCellaUI.WinProprieta.TestoSintetico,R180DimLung(Giorno.Ora,5)]);
      if (WinUITabellaInfo <> nil) then
      begin
        ElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
        ElementoCellaUI.WinProprieta.RectDisegno.Top:=ElementoCellaUI.WinProprieta.RectDisegno.Top + (CellaUI.NumRigheElementiWin * WinUITabellaInfo.AltezzaRiga);
        ElementoCellaUI.WinProprieta.RectDisegno.Bottom:=ElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.AltezzaRiga;
      end;
      ElementoCellaUI.WebProprieta.TestoSintetico:=Giorno.T2 + Giorno.T2EU + IfThen(Giorno.SiglaT2 <> '','.') + EstraiSiglaTurno(Giorno.SiglaT2);
      ElementoCellaUI.WebProprieta.Testo:='T2:' + ElementoCellaUI.WebProprieta.TestoSintetico;
      CellaUI.Elementi.Add(ElementoCellaUI);
      Inc(CellaUI.NumRigheElementiWin);
      ElementoCellaUI:=nil;
    end;
    // Assenza 1
    if (Giorno.Ass1 <> '') then
    begin
      ElementoCellaUI:=TElementoCellaUI.Create;
      ElementoCellaUI.TipoElementoCellaUI:=tecAssenza;
      if (Giorno.Ass1Competenza = caVuota) or (Giorno.Ass1Competenza = caPianificazione) then
      begin
        if TestRiposo(Giorno.Ass1) then
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecRiposo
        else
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenza;
      end
      else if (Giorno.Ass1Competenza = caCartellino) then
      begin
        if TestRiposo(Giorno.Ass1) then
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecRiposo
        else if (Giorno.VAss <> 'S') then
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenza
        else
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenzaVal;
      end
      else // (Giorno.Ass1Competenza = caIter)
      begin
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenzaRichiesta;
      end;

      ElementoCellaUI.WebProprieta.Testo:='A1: ' + Giorno.Ass1;
      ElementoCellaUI.WebProprieta.TestoSintetico:=Giorno.Ass1;
      ElementoCellaUI.WinProprieta.Testo:=Format('%-5s',[Giorno.Ass1]);
      ElementoCellaUI.WinProprieta.TestoSintetico:=Format('%-5s',[Giorno.Ass1]);
      if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (not AssenzeOperative) and Giorno.Ass1Modif then
      begin
        ElementoCellaUI.WinProprieta.StiliCarattere:=[fsItalic];
        ElementoCellaUI.WebProprieta.StiliCarattere:='italic';
      end;
      if (WinUITabellaInfo <> nil) then
      begin
        ElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
        ElementoCellaUI.WinProprieta.RectDisegno.Top:=ElementoCellaUI.WinProprieta.RectDisegno.Top + (CellaUI.NumRigheElementiWin * WinUITabellaInfo.AltezzaRiga);
        ElementoCellaUI.WinProprieta.RectDisegno.Bottom:=ElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.AltezzaRiga;
      end;
      CellaUI.Elementi.Add(ElementoCellaUI);
      Inc(CellaUI.NumRigheElementiWin);
      ElementoCellaUI:=nil;
    end;
    // ... e Assenza 2
    if (Giorno.Ass2 <> '') then
    begin
      ElementoCellaUI:=TElementoCellaUI.Create;
      ElementoCellaUI.TipoElementoCellaUI:=tecAssenza;


      if (Giorno.Ass2Competenza = caVuota) or (Giorno.Ass2Competenza = caPianificazione) then
      begin
        if TestRiposo(Giorno.Ass2) then
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecRiposo
        else
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenza;
      end
      else if (Giorno.Ass2Competenza = caCartellino) then
      begin
        if TestRiposo(Giorno.Ass2) then
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecRiposo
        else if (Giorno.VAss <> 'S') then
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenza
        else
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenzaVal;
      end
      else // (Giorno.Ass2ompetenza = caIter)
      begin
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenzaRichiesta;
      end;

      ElementoCellaUI.WebProprieta.Testo:='A2: ' + Giorno.Ass2;
      ElementoCellaUI.WebProprieta.TestoSintetico:=Giorno.Ass2;
      ElementoCellaUI.WinProprieta.Testo:=Format('%-5s',[Giorno.Ass2]);
      ElementoCellaUI.WinProprieta.TestoSintetico:=Format('%-5s',[Giorno.Ass2]);
      if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (not AssenzeOperative) and Giorno.Ass2Modif then
      begin
        ElementoCellaUI.WinProprieta.StiliCarattere:=[fsItalic];
        ElementoCellaUI.WebProprieta.StiliCarattere:='italic';
      end;
      if (WinUITabellaInfo <> nil) then
      begin
        ElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
        ElementoCellaUI.WinProprieta.RectDisegno.Top:=ElementoCellaUI.WinProprieta.RectDisegno.Top + (CellaUI.NumRigheElementiWin * WinUITabellaInfo.AltezzaRiga);
        ElementoCellaUI.WinProprieta.RectDisegno.Bottom:=ElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.AltezzaRiga;
      end;
      CellaUI.Elementi.Add(ElementoCellaUI);
      Inc(CellaUI.NumRigheElementiWin);
      ElementoCellaUI:=nil;
    end;
    //Assenze ad ore/mezze giornate
    if (Giorno.AssOre <> nil) then
    begin
      for CurrAssOre in Giorno.AssOre do
      begin
        if (not (coIncludiAssMezzGior in Opzioni)) and (CurrAssOre.TipoGiust = 'M') then
          continue;
        if (not (coIncludiAssOrarie in Opzioni)) and ((CurrAssOre.TipoGiust = 'D') or (CurrAssOre.TipoGiust = 'N')) then
          continue;
        ElementoCellaUI:=TElementoCellaUI.Create;
        ElementoCellaUI.TipoElementoCellaUI:=tecAssenzaOre;
        if (Giorno.VAss <> 'S') then
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenzaOre
        else
          ElementoCellaUI.TipoStileElementoCellaUI:=tsecAssenzaOreVal;
        ElementoCellaUI.WinProprieta.Testo:=Format('%s(%s)',[CurrAssOre.Causale,CurrAssOre.TipoGiust]);
        ElementoCellaUI.WinProprieta.TestoSintetico:=Format('%s(%s)',[CurrAssOre.Causale,CurrAssOre.TipoGiust]);
        if (WinUITabellaInfo <> nil) then
        begin
          ElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
          ElementoCellaUI.WinProprieta.RectDisegno.Top:=ElementoCellaUI.WinProprieta.RectDisegno.Top + (CellaUI.NumRigheElementiWin * WinUITabellaInfo.AltezzaRiga);
          ElementoCellaUI.WinProprieta.RectDisegno.Bottom:=ElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.AltezzaRiga;
        end;
        ElementoCellaUI.WebProprieta.Testo:=Format('%s(%s)',[CurrAssOre.Causale,CurrAssOre.TipoGiust]);;
        ElementoCellaUI.WebProprieta.TestoSintetico:=Format('%s(%s)',[CurrAssOre.Causale,CurrAssOre.TipoGiust]);;
        CellaUI.Elementi.Add(ElementoCellaUI);
        Inc(CellaUI.NumRigheElementiWin);
        ElementoCellaUI:=nil;
      end;
    end;

    // Flag: antincendio, referente, richiesto da turnista e sigla area selezionata
    if (Giorno.Antincendio = 'S') or (Giorno.Referente = 'S') or (Giorno.RichiestoDaTurnista = 'S') or
       ((Giorno.Area <> '') and (selT651.SearchRecord('CODICE_AREA',Giorno.Area,[srFromBeginning]))) then
    begin
      ElementoCellaUI:=TElementoCellaUI.Create;
      ElementoCellaUI.TipoElementoCellaUI:=tecCompostoFlag;
      ElementoCellaUI.TipoStileElementoCellaUI:=tsecTurno; // stile "neutro", non usato in questo caso
      ElementoCellaUI.TipoComplesso:=True;
      ElementoCellaUI.ListaSottoElementi:=TObjectList<TElementoCellaUI>.Create(True);
      // Se si verifica un'eccezione, viene catturata ed effettuata la Free() di
      // ElementoCellaUI, che a sua volta libera la propria ListaSottoElementi se è allocata

      // In caso devo disegnare la riga, aggiungo sempre tutti gli elementi (su Web devo
      // poter inserire spazi vuoti se non sono visibili, se no la posizione non è corretta)

      // Sigla Area
      SottoElementoCellaUI:=TElementoCellaUI.Create;
      try
        SottoElementoCellaUI.TipoElementoCellaUI:=tecSiglaArea;
        SottoElementoCellaUI.TipoStileElementoCellaUI:=tsecSiglaArea;
        SottoElementoCellaUI.WinProprieta.Testo:=Format('%-2s',[GetSiglaArea(Giorno.Area)]);
        SottoElementoCellaUI.WinProprieta.TestoSintetico:=Format('%-2s',[GetSiglaArea(Giorno.Area)]);
        SottoElementoCellaUI.WinProprieta.Invisibile:=(Giorno.Area = '');
        if (WinUITabellaInfo <> nil) then
        begin
          SottoElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Top:=SottoElementoCellaUI.WinProprieta.RectDisegno.Top + (CellaUI.NumRigheElementiWin * WinUITabellaInfo.AltezzaRiga);
          SottoElementoCellaUI.WinProprieta.RectDisegno.Bottom:=SottoElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.AltezzaRiga;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Right:=SottoElementoCellaUI.WinProprieta.RectDisegno.Left + 18;
        end;
        SottoElementoCellaUI.WebProprieta.Testo:=Format('%-2s',[GetSiglaArea(Giorno.Area)]);
        SottoElementoCellaUI.WebProprieta.TestoSintetico:=Format('%-2s',[GetSiglaArea(Giorno.Area)]);
        SottoElementoCellaUI.WebProprieta.Invisibile:=(Giorno.Area = '');
        ElementoCellaUI.ListaSottoElementi.Add(SottoElementoCellaUI);
        SottoElementoCellaUI:=nil;
      except
        on E:Exception do
        begin
          if (SottoElementoCellaUI <> nil) then
            FreeAndNil(SottoElementoCellaUI);
          raise Exception.Create(E.Message);
        end;
      end;

      // Antincendio
      SottoElementoCellaUI:=TElementoCellaUI.Create;
      try
        SottoElementoCellaUI.TipoElementoCellaUI:=tecAntincendio;
        SottoElementoCellaUI.TipoStileElementoCellaUI:=tsecAntincendio;
        SottoElementoCellaUI.WinProprieta.Testo:='A';
        SottoElementoCellaUI.WinProprieta.TestoSintetico:='A';
        SottoElementoCellaUI.WinProprieta.Invisibile:=(Giorno.Antincendio <> 'S');
        if (WinUITabellaInfo <> nil) then
        begin
          SottoElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Top:=SottoElementoCellaUI.WinProprieta.RectDisegno.Top + (CellaUI.NumRigheElementiWin * WinUITabellaInfo.AltezzaRiga);
          SottoElementoCellaUI.WinProprieta.RectDisegno.Bottom:=SottoElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.AltezzaRiga;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Left:=SottoElementoCellaUI.WinProprieta.RectDisegno.Left + 22;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Right:=SottoElementoCellaUI.WinProprieta.RectDisegno.Left + 13;
        end;
        SottoElementoCellaUI.WebProprieta.Testo:='A';
        SottoElementoCellaUI.WebProprieta.TestoSintetico:='A';
        SottoElementoCellaUI.WebProprieta.Invisibile:=(Giorno.Antincendio <> 'S');
        ElementoCellaUI.ListaSottoElementi.Add(SottoElementoCellaUI);
        SottoElementoCellaUI:=nil;
      except
        on E:Exception do
        begin
          if (SottoElementoCellaUI <> nil) then
            FreeAndNil(SottoElementoCellaUI);
          raise Exception.Create(E.Message);
        end;
      end;

      // Referente
      SottoElementoCellaUI:=TElementoCellaUI.Create;
      try
        SottoElementoCellaUI.TipoElementoCellaUI:=tecReferente;
        SottoElementoCellaUI.TipoStileElementoCellaUI:=tsecReferente;
        SottoElementoCellaUI.WinProprieta.Testo:='R';
        SottoElementoCellaUI.WinProprieta.TestoSintetico:='R';
        SottoElementoCellaUI.WinProprieta.Invisibile:=(Giorno.Referente <> 'S');
        if (WinUITabellaInfo <> nil) then
        begin
          SottoElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Top:=SottoElementoCellaUI.WinProprieta.RectDisegno.Top + (CellaUI.NumRigheElementiWin * WinUITabellaInfo.AltezzaRiga);
          SottoElementoCellaUI.WinProprieta.RectDisegno.Bottom:=SottoElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.AltezzaRiga;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Left:=SottoElementoCellaUI.WinProprieta.RectDisegno.Left + 40;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Right:=SottoElementoCellaUI.WinProprieta.RectDisegno.Left + 13;
        end;
        SottoElementoCellaUI.WebProprieta.Testo:='R';
        SottoElementoCellaUI.WebProprieta.TestoSintetico:='R';
        SottoElementoCellaUI.WebProprieta.Invisibile:=(Giorno.Referente <> 'S');
        ElementoCellaUI.ListaSottoElementi.Add(SottoElementoCellaUI);
        SottoElementoCellaUI:=nil;
      except
        on E:Exception do
        begin
          if (SottoElementoCellaUI <> nil) then
            FreeAndNil(SottoElementoCellaUI);
          raise Exception.Create(E.Message);
        end;
      end;

      // Richiesto da turnista
      SottoElementoCellaUI:=TElementoCellaUI.Create;
      try
        SottoElementoCellaUI.TipoElementoCellaUI:=tecRichiestoDaTurnista;
        SottoElementoCellaUI.TipoStileElementoCellaUI:=tsecRichiestoDaTurnista;
        SottoElementoCellaUI.WinProprieta.Testo:='T';
        SottoElementoCellaUI.WinProprieta.TestoSintetico:='T';
        SottoElementoCellaUI.WinProprieta.Invisibile:=(Giorno.RichiestoDaTurnista <> 'S');
        if (WinUITabellaInfo <> nil) then
        begin
          SottoElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Top:=SottoElementoCellaUI.WinProprieta.RectDisegno.Top + (CellaUI.NumRigheElementiWin * WinUITabellaInfo.AltezzaRiga);
          SottoElementoCellaUI.WinProprieta.RectDisegno.Bottom:=SottoElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.AltezzaRiga;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Left:=SottoElementoCellaUI.WinProprieta.RectDisegno.Left + 58;
          SottoElementoCellaUI.WinProprieta.RectDisegno.Right:=SottoElementoCellaUI.WinProprieta.RectDisegno.Left + 13;
        end;
        SottoElementoCellaUI.WebProprieta.Testo:='T';
        SottoElementoCellaUI.WebProprieta.TestoSintetico:='T';
        SottoElementoCellaUI.WebProprieta.Invisibile:=(Giorno.RichiestoDaTurnista <> 'S');
        ElementoCellaUI.ListaSottoElementi.Add(SottoElementoCellaUI);
        SottoElementoCellaUI:=nil;
      except
        on E:Exception do
        begin
          if (SottoElementoCellaUI <> nil) then
            FreeAndNil(SottoElementoCellaUI);
          raise Exception.Create(E.Message);
        end;
      end;

      CellaUI.Elementi.Add(ElementoCellaUI);
      Inc(CellaUI.NumRigheElementiWin);
    end;

    // Turni di reperibilità
    if Giorno.TurnoRepPresente then
    begin
      // WIN: mostro una R
      ElementoCellaUI:=TElementoCellaUI.Create;
      ElementoCellaUI.TipoElementoCellaUI:=tecTurnoRep;
      ElementoCellaUI.TipoStileElementoCellaUI:=tsecTurnoRep;
      ElementoCellaUI.WinProprieta.Testo:=Format('%-5s %-5s',[Giorno.TurniRep[1].Sigla,Giorno.TurniRep[2].Sigla]);
      ElementoCellaUI.WinProprieta.TestoSintetico:=Format('%s%s',[Giorno.TurniRep[1].Sigla,IfThen(Giorno.TurniRep[2].Sigla <> '','...')]);
      if (WinUITabellaInfo <> nil) then
      begin
        ElementoCellaUI.WinProprieta.RectDisegno:=WinUITabellaInfo.RectCella;
        ElementoCellaUI.WinProprieta.RectDisegno.Top:=ElementoCellaUI.WinProprieta.RectDisegno.Top + WinUITabellaInfo.CurrentRowHeight - 15;
      end;
      ElementoCellaUI.WebProprieta.Invisibile:=True;
      Inc(CellaUI.NumRigheElementiWin);
      CellaUI.Elementi.Add(ElementoCellaUI);
      ElementoCellaUI:=nil;
      // In WEB: mostro fino a 2 turni di reperibilità
      if (Giorno.TurniRep[1].Turno <> '') then // Sicuro
      begin
        ElementoCellaUI:=TElementoCellaUI.Create;
        ElementoCellaUI.TipoElementoCellaUI:=tecTurnoRep;
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecTurnoRep;
        ElementoCellaUI.WebProprieta.Testo:='R1: ' + Giorno.TurniRep[1].Sigla{Turno};
        ElementoCellaUI.WebProprieta.TestoSintetico:=Giorno.TurniRep[1].Sigla{Turno};
        ElementoCellaUI.WinProprieta.Invisibile:=true;
        CellaUI.Elementi.Add(ElementoCellaUI);
        ElementoCellaUI:=nil;
      end;
      if (Giorno.TurniRep[2].Turno <> '') then
      begin
        ElementoCellaUI:=TElementoCellaUI.Create;
        ElementoCellaUI.TipoElementoCellaUI:=tecTurnoRep;
        ElementoCellaUI.TipoStileElementoCellaUI:=tsecTurnoRep;
        ElementoCellaUI.WebProprieta.Testo:='R2: ' + Giorno.TurniRep[2].Sigla{Turno};
        ElementoCellaUI.WebProprieta.TestoSintetico:=Giorno.TurniRep[2].Sigla{Turno};
        ElementoCellaUI.WinProprieta.Invisibile:=true;
        CellaUI.Elementi.Add(ElementoCellaUI);
        ElementoCellaUI:=nil;
      end;
    end;

    // Indicatore note
    if (Trim(Giorno.Note) <> '') then
    begin
      //Evidenzio la presenza di note (triangolo blu in alto-dx)
      IndicatoreCellaUI:=TIndicatoreCellaUI.Create;
      IndicatoreCellaUI.TipoStileIndicatoreCellaUI:=tsicNota;
      if (WinUITabellaInfo <> nil) then
      begin
        SetLength(IndicatoreCellaUI.VerticiWin,4);
        IndicatoreCellaUI.VerticiWin[0]:=Point(WinUITabellaInfo.RectCella.Right,WinUITabellaInfo.RectCella.Top);
        IndicatoreCellaUI.VerticiWin[1]:=Point(WinUITabellaInfo.RectCella.Right - 8,WinUITabellaInfo.RectCella.Top);
        IndicatoreCellaUI.VerticiWin[2]:=Point(WinUITabellaInfo.RectCella.Right,WinUITabellaInfo.RectCella.Top + 8);
        IndicatoreCellaUI.VerticiWin[3]:=Point(WinUITabellaInfo.RectCella.Right,WinUITabellaInfo.RectCella.Top);
      end;
      IndicatoreCellaUI.TopWeb:='-1px';
      IndicatoreCellaUI.RightWeb:='-2px';
      CellaUI.Indicatori.Add(IndicatoreCellaUI);
      IndicatoreCellaUI:=nil;
    end;
    // Indicatore anomalie
    if (Giorno.Anomalie.Count > 0) then
    begin
      // In caso di anomalie visualizzo un triangolo rosso in alto-sx
      IndicatoreCellaUI:=TIndicatoreCellaUI.Create;
      IndicatoreCellaUI.TipoStileIndicatoreCellaUI:=tsicAnomalia;
      if (WinUITabellaInfo <> nil) then
      begin
        SetLength(IndicatoreCellaUI.VerticiWin,4);
        IndicatoreCellaUI.VerticiWin[0]:=Point(WinUITabellaInfo.RectCella.Left,WinUITabellaInfo.RectCella.Top);
        IndicatoreCellaUI.VerticiWin[1]:=Point(WinUITabellaInfo.RectCella.Left + 8,WinUITabellaInfo.RectCella.Top);
        IndicatoreCellaUI.VerticiWin[2]:=Point(WinUITabellaInfo.RectCella.Left,WinUITabellaInfo.RectCella.Top + 8);
        IndicatoreCellaUI.VerticiWin[3]:=Point(WinUITabellaInfo.RectCella.Left,WinUITabellaInfo.RectCella.Top);
      end;
      IndicatoreCellaUI.TopWeb:='-1px';
      IndicatoreCellaUI.LeftWeb:='-2px';
      CellaUI.Indicatori.Add(IndicatoreCellaUI);
      IndicatoreCellaUI:=nil;
    end;
    Result:=CellaUI;
  except
    on E:Exception do
    begin
      if (ElementoCellaUI <> nil) then
        FreeAndNil(ElementoCellaUI);
      if (IndicatoreCellaUI <> nil) then
        FreeAndNil(IndicatoreCellaUI);
      FreeAndNil(CellaUI);
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TA058FPianifTurniDtm1.getColoreCellaWIN(Colore: String): integer;
var i:integer;
begin
  Result:=clNone;
  for i:=0 to High(lstColori) do
    if (lstColori[i].Nome = Colore) then
    begin
      Result:=lstColori[i].Numero;
      Break;
    end;
end;

function TA058FPianifTurniDtm1.getColoreStyleWEB(Colore: String): String;
var i:integer;
begin
  Result:='#FFFFFF';
  for i:=0 to High(lstColori) do
    if (lstColori[i].Nome = Colore) then
    begin
      Result:=lstColori[i].StyleWEB;
      Break;
    end;
end;

function TA058FPianifTurniDtm1.getColoreClassWEB(Colore: String): String;
var i:integer;
begin
  Result:='bg_white';
  for i:=0 to High(lstColori) do
    if (lstColori[i].Nome = Colore) then
    begin
      Result:=lstColori[i].ClassWEB;
      Break;
    end;
end;

function TA058FPianifTurniDtm1.GetVistaInCSV(Sintetico:Boolean):String;
var
  Intestazione,Corpo,S:String;
  IdxDip,IdxGiorno:Integer;
  DataAttuale:TDateTime;
  DipAttuale:TDipendente;
  GiornoAttuale:TGiorno;
  function EstraiSiglaTurno(const S:String):String;
  begin
    Result:=IfThen(Length(S) >=2, Trim(Copy(S,2,Length(S) - 2)), S);
  end;
begin
  Result:='';
  S:='';
  // Intestazione
  // Riga 1
  Intestazione:='="TIPO OPERATORE"';
  Intestazione:=Intestazione + TAB + '="MATRICOLA"';
  Intestazione:=Intestazione + TAB + '="NOMINATIVO"';
  for IdxGiorno:=0 to Trunc(DataFine - DataInizio) do
  begin
    DataAttuale:=DataInizio + IdxGiorno;
    S:=GetTipoGiornoServizio(DataAttuale);
    if S <> '' then
       S:='(' + S + ')';
    S:=FormatDateTime('dd/mm',DataAttuale) + S;
    Intestazione:=Intestazione + TAB + '="' + S + '"';
  end;
  // Riga 2
  Intestazione := Intestazione + CRLF + '""' + TAB + '""' + TAB + '""';
  for IdxGiorno:=0 to Trunc(DataFine - DataInizio) do
  begin
    DataAttuale:=DataInizio + IdxGiorno;
    S:='="' + R180NomeGiorno(DataAttuale) + '"';
    Intestazione:=Intestazione + TAB + S;
  end;
  // Corpo
  S:='';
  Corpo:='';
  for IdxDip:=0 to Vista.Count - 1 do
  begin
    DipAttuale:=Vista[IdxDip];
    S:=CRLF + '="' + DipAttuale.TipoOpe + '"'; // Tipo operatore
    S:=S + TAB + '="' + DipAttuale.Matricola + '"'; // Matricola
    S:=S + TAB + '="' + DipAttuale.Cognome + ' ' + DipAttuale.Nome + '"'; // Cognome e nome
    for IdxGiorno:=0 to Trunc(DataFine - DataInizio) do
    begin
      S:=S + TAB + '="';
      GiornoAttuale:=DipAttuale.Giorni[IdxGiorno + OffsetVista];
      if Sintetico then
      begin
        // Visualizzazione sintetica: se non assente, solo sigla primo turno + eventuale AI per antincendio
        if Length(Trim(GiornoAttuale.Ass1)) = 0 then
        begin
          S:=S + EstraiSiglaTurno(GiornoAttuale.SiglaT1);
          if GiornoAttuale.Antincendio = 'S' then
            S:=S + ' (AI)';
        end
        else
        begin
          S:=S + GiornoAttuale.Ass1
        end;
      end
      else
      begin
        // Visualizzazione completa: se non assente, modello orario + sigla primo turno + eventuale AI per antincendio
        if Length(Trim(GiornoAttuale.Ass1)) = 0 then
        begin
          S:=S + R180DimLung(GiornoAttuale.Ora,5) + ' ';
          S:=S + EstraiSiglaTurno(GiornoAttuale.SiglaT1);
          if GiornoAttuale.Antincendio = 'S' then
            S:=S + ' (AI)';
        end
        else
        begin
          S:=S + GiornoAttuale.Ass1
        end;
      end;
      S:=S + '"';
    end;
    Corpo:=Corpo + S;
  end;
  Result:=Intestazione + Corpo;
end;

function TA058FPianifTurniDtm1.IsIntervalloMensile(DataDa,DataA:TDateTime):Boolean;
begin
  Result:=(R180Giorno(DataDa) = 1) and (R180Mese(DataDa) = R180Mese(DataA)) and
          (Trunc(DataA - DataDa) = (R180GiorniMese(DataDa) - 1));  
end;

function TA058FPianifTurniDtm1.DecodeCompetenzaAssenza(Stringa:String):TCompetenzaAssenza;
var
  StringaTrim:String;
begin
  StringaTrim:=Stringa.Trim;
  if StringaTrim = COMPETENZA_ASSENZA_CARTELLINO then
    Result:=caCartellino
  else if StringaTrim = COMPETENZA_ASSENZA_ITER then
    Result:=caIter
  else if StringaTrim = COMPETENZA_ASSENZA_PIANIFICAZIONE then
    Result:=caPianificazione
  else
    Result:=caVuota;
end;

{ TTurnoRep }

procedure TTurnoRep.Clear;
begin
  Turno:='';
  Sigla:='';
  OraInizio:='';
  OraFine:='';
end;

end.
