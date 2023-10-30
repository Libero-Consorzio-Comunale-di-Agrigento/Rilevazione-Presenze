unit Rp502Pro;

interface

uses
  DBClient, SysUtils, StrUtils, Classes, DB, Math, Variants,
  R500Lin, C180FunzioniGenerali, A000UInterfaccia, A000UCostanti, A000USessione,
  OracleData, Oracle, Generics.Collections;

type
  TTurno = record
    T:String;
    Inizio,Fine:Integer;
  end;

  TTurnoNotturno = record
    Num,E,U,Ritardo:Integer;
    TimbGGDopo:Boolean;
  end;

  TPeriodoIF = record
    I,F:Integer;
  end;

  TOraLegaleSolare = record
    Data:TDateTime;
    Cambio:Boolean;
    OraVecchia:Integer;
    OraNuova:Integer;
    Diff:Integer;
  end;

  TTurniReperibilita = record
    Data:TDateTime;
    Tipo:String;
    IT,FT:Integer;
  end;

  TPropTurnoRep = record
    Codice:String;
    Inizio,Fine,Durata:Integer;
  end;

  TCodTurniReperibilita = record
    Tipo:String;
    Turno1,Turno2,Turno3:TPropTurnoRep;
  end;

  TFasceCausali276 = record
    Codice,TipoGiorno,
    Dalle,Alle:String;
    Dalle1,Alle1,
    Dalle2,Alle2:Integer;
  end;

  TFasceAbilitazione277 = record
    IT,FT:Integer;
    PN:Boolean;
  end;

  TRiepLibProf = record
    Causale,Descrizione:String;
    OrePianificate:Integer;
    OreRese:Integer;
  end;

  TFascePaghe = record
    VocePaghe:String;
    Ore:Integer;
  end;

  TFasciaMensa = record
    PMTInizioDa,PMTInizioA,PMTFineDa,PMTFineA:Integer;
  end;

  TPianificazioneEsterna = record
    Data:TDateTime;
    Progressivo:Integer;
    l08_turno1,l08_turno2:SmallInt;              //Turni letti dalla pianificazione
    l08_Orario,
    l08_turno1EU,l08_turno2EU:String; //Spezzone di turno notturno letto dalla pianificazione
  end;

  TTimbDipNotteU = record
    Data:TDateTime;
    TimbDip:t_ttimbraturedip;
  end;

  TTimbConNotteU = record
    Data:TDateTime;
    TimbCon:t_ttimbraturecon;
  end;

  TTimbNomNotteU = record
    Data:TDateTime;
    TimbNom:t_ttimbraturenom;
  end;

  TFasceNotteU = record
    Data:TDateTime;
    Fasce:t_tfasceorarie;
  end;

  TIntervalloUscita = record
    OraOriginale,OraNuova:Integer;
  end;

  TSpezzoniNonAbilitati = record
    TipoAbil:String; //NA=Non abilitato, NC=Non causalizzato
    TipoSpez:String; //E=Entrata anticipata, U=Uscita posticipata, FO=Fuori orario
    Inizio,Fine,Durata:Integer;
  end;

  TRientroPomeridiano = record
    Obbl,Suppl:Integer;
    BuonoPastoObbl,BuonoPastoSuppl:Integer;
    TotLav,MaxU,MaxUTimb:Integer;
    PausaMensa,LavDopoMensa,LavDopoMensaTimb,LavPrimaMensaTimb:Integer;
  end;

  TAnomalieGG = record
    Data:TDateTime;
    Livello,Num:Integer;
    LivNum,
    Id:String;
    Descrizione:String;
  end;

  TMinutiCoperti = class
  private
    Minuti: array of Boolean;
    FDimensione: Integer;
    FCopertura: Integer;
    function GetCopriIntervallo(E, U: Integer): Integer;
    procedure SetDimensione(const Value: Integer);
  public
    constructor Create;
    destructor  Destroy;
    procedure Reset;
    property  Dimensione:Integer read FDimensione write SetDimensione;
    property  CopriIntervallo[E,U:Integer]:Integer read GetCopriIntervallo;
    property  Copertura:Integer read FCopertura write FCopertura;
  end;

  TCdzAbilitazione = record
    Firma:String;
    Risultato:String;
  end;

  TR502ProDtM1 = class(TDataModule)
    Q430: TOracleDataSet;
    Q350: TOracleDataSet;
    Q210: TOracleDataSet;
    Q270: TOracleDataSet;
    Q110: TOracleDataSet;
    Q012B: TOracleDataSet;
    Q460: TOracleDataSet;
    Q040: TOracleDataSet;
    Q060: TOracleDataSet;
    Q090: TOracleDataSet;
    Q080: TOracleDataSet;
    selT100: TOracleDataSet;
    Q011: TOracleDataSet;
    Q011B: TOracleDataSet;
    Q200: TOracleDataSet;
    Q201: TOracleDataSet;
    selT220: TOracleDataSet;
    selT221: TOracleDataSet;
    Q265: TOracleDataSet;
    Q275: TOracleDataSet;
    Q305: TOracleDataSet;
    Q380: TOracleDataSet;
    QRepSost: TOracleDataSet;
    Q430Rep: TOracleDataSet;
    Q011BDATA: TDateTimeField;
    Q011BLAVORATIVO: TStringField;
    Q011BFESTIVO: TStringField;
    Q011BNUMGIORNI: TFloatField;
    Q012BDATA: TDateTimeField;
    Q012BLAVORATIVO: TStringField;
    Q012BFESTIVO: TStringField;
    Q012BNUMGIORNI: TFloatField;
    Q201CODICE: TStringField;
    Q201GIORNO: TStringField;
    Q201FASCIADA1: TDateTimeField;
    Q201FASCIADA2: TDateTimeField;
    Q201FASCIADA3: TDateTimeField;
    Q201FASCIADA4: TDateTimeField;
    Q201FASCIAA1: TDateTimeField;
    Q201FASCIAA2: TDateTimeField;
    Q201FASCIAA3: TDateTimeField;
    Q201FASCIAA4: TDateTimeField;
    Q201MAGGIOR1: TStringField;
    Q201MAGGIOR2: TStringField;
    Q201MAGGIOR3: TStringField;
    Q201MAGGIOR4: TStringField;
    Q305CODICE: TStringField;
    Q305CODRAGGR: TStringField;
    Q305SIGLA: TStringField;
    Q305CODINTERNO: TStringField;
    QRepSostRAGGRUPPAMENTO: TStringField;
    Q040DATA: TDateTimeField;
    Q040CAUSALE: TStringField;
    Q040TIPOGIUST: TStringField;
    Q040DAORE: TDateTimeField;
    Q040AORE: TDateTimeField;
    Q080DATA: TDateTimeField;
    Q080ORARIO: TStringField;
    Q080TURNO1: TStringField;
    Q080TURNO2: TStringField;
    Q080TURNO1EU: TStringField;
    Q080TURNO2EU: TStringField;
    Q080INDPRESENZA: TStringField;
    Q370: TOracleDataSet;
    Q276: TOracleDataSet;
    Q320: TOracleDataSet;
    selT265CumP: TOracleDataSet;
    selT277: TOracleDataSet;
    Q080DATOLIBERO: TStringField;
    selT025: TOracleDataSet;
    selT361: TOracleDataSet;
    selT021: TOracleDataSet;
    cdsT020: TClientDataSet;
    cdsT021: TClientDataSet;
    selT020: TOracleDataSet;
    Q332: TOracleDataSet;
    Q330: TOracleDataSet;
    Q080VALORGIOR: TStringField;
    scrQuadrSett: TOracleQuery;
    selV430RNF: TOracleQuery;
    selT100T105: TOracleDataSet;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    Q040DATANAS: TDateTimeField;
    Q040PROGRCAUSALE: TFloatField;
    selT040GGSucc: TOracleDataSet;
    DateTimeField3: TDateTimeField;
    StringField5: TStringField;
    StringField6: TStringField;
    DateTimeField4: TDateTimeField;
    DateTimeField5: TDateTimeField;
    DateTimeField6: TDateTimeField;
    FloatField1: TFloatField;
    Q080MOTIVAZIONE: TStringField;
    cdsT320: TClientDataSet;
    Q040NOTE: TStringField;
    selT050: TOracleDataSet;
    selT230: TOracleDataSet;
    selT235: TOracleDataSet;
    selVT420: TOracleDataSet;
    Q080NOTE: TStringField;
    selT220CODICE: TStringField;
    selT220DESCRIZIONE: TStringField;
    selT220ANTICIPOUSCITA: TDateTimeField;
    selT220PRITIMSC: TStringField;
    selT220SCOSTENTRATA: TStringField;
    selT220TIMBNONAPPOGGIATE: TStringField;
    selT220RITARDO_ENTRATA: TIntegerField;
    selT220DECORRENZA: TDateTimeField;
    selT220DECORRENZA_FINE: TDateTimeField;
    selT220IGNORA_TIMBNONINSEQ: TStringField;
    selT220PRIORITA_DOM_FEST: TStringField;
    selT220PRIORITA_DOM_NONLAV: TStringField;
    selT220PESO_SCOSTENTRATA_S: TIntegerField;
    selT220PESO_TIMBNONAPPOGGIATE_N: TIntegerField;
    selT220PESO_TIMBNONAPPOGGIATE_S: TIntegerField;
    selT220PESO_PRITIMSC_S: TIntegerField;
    selT220PESO_PRITIMSC_A: TIntegerField;
    selT220PESO_MINANTSCELTA: TIntegerField;
    selT220PESO_TIMBESTERNE: TIntegerField;
    selT220PESO_RITARDO_ENTRATA: TIntegerField;
    selT220IGNORA_STACCOPMT: TStringField;
    selIter: TOracleDataSet;
    selCdzAbilitazione: TOracleQuery;
    procedure Q430FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure Q276AfterOpen(DataSet: TDataSet);
    procedure Q320AfterOpen(DataSet: TDataSet);
    procedure Q265AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    codanom2                 :Byte;
    datacon_sv               :TDateTime;
    f03_com_sv               :String;
    totlav_sv                :Integer;
    indnotmin_sv             :Integer;
    n_rieppres_sv            :Byte;
    n_riepasse_sv            :Byte;
    n_timbrcon_sv            :Byte;
    minlavesc_sv             :Integer;
    minlavfes_sv             :Integer;
    CoperturaCarenza_sv      :Integer;
    triepgiuspres_sv         :array [1..10] of t_triepgiuspres;
    triepgiusasse_sv         :array [1..20] of t_triepgiusasse;
    tminlav_sv               :array [1..20] of Integer;
    ttimbraturecon_sv        :array [1..MaxTimbrature] of t_ttimbraturecon;
    ttimbraturedip_bck       :array of t_ttimbraturedip;
    T220                     :TProfilo;      //Profilo orario corrente
    T221                     :TSettimane;    //Settimane del profilo orario
    MaxT221                  :Byte; //Numero di settimane del profilo orario corrente
    T201                     :array[1..9] of TFasceGiorno; //Fasce da contratto;
    T201GG                   :TFasceGiorno; //Fasce del giorno corrente
    DetTeoMensa              :Integer;
    DetPresenza              :Integer;
    DetMinLavEsc             :Integer;
    RepSost                  :Boolean;
    SquadraSost              :String;
    LTurni                   :TStringList;
    DescAnom                 :String;
    invcausggass             :String;
    //4.0
    timbraturaesclusa        :t_ttimbraturedip;
    ttimbraturedip_vuota     :t_ttimbraturedip;
    TurniReperibilita        :array of TTurniReperibilita;
    FasceAbilitazione277     :array of TFasceAbilitazione277;
    TimbInRep                :Boolean;
    progrcon             :LongInt;
    gglavmm              :Byte;
    tritflex             :array [1..2] of Integer;
    tflexu               :array [1..2] of Integer;
    timinuti             :Integer;
    rit                  :Integer;
    ant                  :Integer;
    fasciabass           :Byte;
    debitopoass          :Integer;
    minlavtim            :Integer;
    detrazioni           :Integer;
    detrazstr            :Integer;
    FDetrazTotLav        :Integer;
    strarrdet            :Integer;
    strarrdetEscl        :Integer;
    strminimidet         :Integer;
    strgiorn             :Integer;
    strgiornEscl         :Integer;
    minutidalle          :Integer;
    minutialle           :Integer;
    mininterfasc         :Integer;
    scostliq             :Integer;
    minlavincfor         :Integer;
    minasscomp           :Integer;
    //***   Dati per frazionamento debito orario turno notturno
    turnonott            :Byte;
    debfrazmatt          :Integer;
    debfrazsera          :Integer;
    debnoncav            :Integer;
    //***   Minuti lavorati nelle fasce orarie
    minlavorar           :Integer;
    tcausale          :t_tcausale;
    tcausale_vuota    :t_tcausale;
    //***   Timbrature dipendente del mese in input da cartellino
    ttimbraturedipmese: array [1..31,1..MaxTimbrature] of t_ttimbraturedipmese;
    //***   Giustificativi dipendente del mese in input da cartellino
    tgiustificdipmese: array [1..31,1..MaxGiustif] of t_tgiustificdipmese;
    //causaleass.
    causass           :String;
    causrag           :String;
    causgnl           :String;
    causinf           :String;
    causval           :String;
    causvalcomp       :String;
    causipo           :String;
    causrpl           :String;
    causgga           :Integer;
    causesclusa       :String;
    causind           :String;
    causstr           :String;
    causpag           :String;
    causmis           :String;
    causestimb        :String;
    tipocumulo        :String;
    CausDataFamiliare :TDateTime;
    //***   Fasce indennita' notturne da contratto
    //fasceindnot.
    iniz1fascind      :Integer;
    fine1fascind      :Integer;
    iniz2fascind      :Integer;
    fine2fascind      :Integer;
    //***   Numero di fasce orarie FER/FES/SAB
    //tnumerofasce.
    tnumfasce         :array [1..3] of Byte;
    orelav24             :String;
    turnicavmez          :String;
    timbfac              :String;
    strabana             :String;
    debitocalc           :String;
    indabiulttim         :String;
    orarioacq            :String;
    timbraacq            :String;
    monteorelet          :String;
    aum862               :String;
    tipogasse            :Byte;
    versotiprec          :Char;
    e_u                  :Char;
    abprol               :Char;
    indice               :Byte;
    prolcaus             :String;
    riepcaus             :String;
    riepcaus_e           :Integer;
    riepcaus_u           :Integer;
    riepcausrag          :String;
    riepcausrip          :String;
    riepcausioe          :String;
    riepcaus_numtimb     :Byte;
    riepcausOreGettone   :Integer;
    riepcausOreAbbuonate :Integer;
    mingiuore            :Integer;
    minvalass            :Integer;
    minresass            :Integer;
    minass_oltredebito   :Integer;
    minantscelta         :Integer;
    scostentrata         :Integer;
    giornlav178          :Byte;
    ieu                  :Byte;
    igs                  :Byte;
    iag                  :Byte;
    i080                 :Byte;
    i390                 :Byte;
    i810                 :Byte;
    i90e                 :Byte;
    i90u                 :Byte;
    flex90               :Integer;
    flex92               :Integer;
    i890                 :Byte;
    e_u890               :Char;
    arr890               :Integer;
    per892               :Integer;
    p1                   :Byte;
    pe                   :Byte;
    pu                   :Byte;
    comodo1              :Integer;
    comodo2              :Integer;
    comodo3              :Integer;
    comodo6              :Integer;
    comodo7              :Integer;
    comodo8              :Integer;
    OrarioDaEntrata      :Boolean;
    paumendet_resto      :Integer;
    paumendet_rieppres   :Integer;
    paumendet_strgiorn   :Integer;
    paumenFatta          :Integer;
    paumendet_oreesc     :Integer;
    primaVolta_z148      :Boolean;
    conteggi_sologiust   :Boolean;
    //***   Salvataggi per evitare accessi inutili agli archivi
    progrcon20_sv        :LongInt;
    anno20_sv            :Integer;
    mese20_sv            :Integer;
    gior20_sv            :Integer;
    es09_sv              :String;
    progrconpo_sv        :LongInt;
    annopo_sv            :Integer;
    mesepo_sv            :Integer;
    c_profora_sv         :String;
    NotteSuEntrata_sv    :String;
    DataPrec_sv          :TDateTime;
    //***   Dati letti da archivio e registrati in memoria
    tcausalilette:  array of t_tcausalilette;
    lstT265      :  TlstElementi;
    lstT230      :  TlstElementi;
    lstT235      :  TlstElementi;
    lstT011      :  TlstElementi;
    tprofililetti:  array (*WEB [1..100]*) of t_tprofililetti;
    tcontrattiletti:array (*WEB [1..10]*)  of t_tcontrattiletti;
    ////// Variabili R502xlw2 ///////////////////////////////////////////////
    parcaus              :t_tparcaus;
    l04_caus             :String;
    l04_dalle            :TDateTime;
    l04_alle             :TDateTime;
    l04_tipogius         :Char;
    l04_PuntGiustR600    :Integer;
    l08_turno1,l08_turno2:SmallInt;       //Turni letti dalla pianificazione
    l08_Orario:String;
    l08_turno1EU,l08_turno2EU:String; //Spezzone di turno notturno letto dalla pianificazione
    l10_data             :TDateTime;
    l10_ora              :Integer;
    l10_verso            :Char;
    l10_flag             :Char;
    l10_rilevatore       :String;
    l10_causale          :String;
    //=== Gestione Conteggi   r500lin ===
    datacon_gg      :Word;
    datacon_mm      :Word;
    datacon_aa      :Word;
    //***   Debito orario senza gestione non lavorativo
    debitoor             :Integer;
    i1                   :Byte;
    i2                   :Byte;
    i3                   :Byte;
    i4                   :Byte;
    SenzaCausale         :Boolean;
    ScostCausEffettuato  :Boolean;
    z036FlexDopoMezzanotte:Boolean;
    RicalcoloMaxScostPos :Integer;
    R502Ricorsivo        :TR502ProDtM1;
    R502NotteUscita      :TR502ProDtM1;
    AbbatteCausPres      :Integer;
    SessioneOracleR502   :TOracleSession;
    calcolo_z100         :Boolean;
    CausaleDisabilBloccante:Boolean;
    ResoSett,DebSett     :Integer; //TORINO_COMUNE
    matura_ripcom        :Boolean;
    CRV_PMT_MNGiustE,CRV_PMT_MNGiustU:Integer;
    FasciaMensa         :TFasciaMensa;
    TimbDipNotteU        :array of TTimbDipNotteU;
    TimbNomNotteU        :array of TTimbNomNotteU;
    TimbConNotteU        :array of TTimbConNotteU;
    FasceNotteU          :array of TFasceNotteU;
    FConsideraRichiesteWeb:Boolean;
    FCompDebitoCausEscluse:Integer;
    PuntiNominali277     :String;
    CausaliPuntiNominali277  :String;
    z496Eseguito         :Boolean;
    TollPMUtilizzata     :Integer;
    FFunzioneChiamante   :String;
    CdzAbilitazione        :array of TCdzAbilitazione;
    procedure QueryActive(Param:TParam; Active:Boolean);
    procedure AggiornaQuery;
    procedure R500Inizio;
    procedure x810_cumulopres;
    procedure x811_cumuloasse;
    function GetCalendario(Cod:String; Data:TDateTime; var ZTipoGG,ZTipoGGLav:Char):String;
    function CausPresAbilitato(caus:String):Boolean;
    function GetValNumT020(Campo:String):Integer;
    function GetFasciaT021(TipoFascia:String; Indice:Integer):Boolean;
    function GetValNumT021(Campo,TipoFascia:String; Indice:Integer):Integer;
    function GetValStrT021(Campo,TipoFascia:String; Indice:Integer):String;
    function GetValStrT025(Campo:String; Default:String = ''):String;
    function GetValStrT265(Codice,Dato:String):String;
    function GetValStrT275(Codice,Dato:String):String;
    function GetPausaMensa:String;
    function GetTipoOrario:String;
    function GetPeriodoLavorativo:String;
    function GetEntrataNominale(i:Byte):Integer;
    function GetUscitaNominale(i:Byte):Integer;
    function GetEntrataNominaleNetta(i,ie:Byte):Integer;
    function GetUscitaNominaleNetta(i,iu:Byte):Integer;
    function GetEntrataTeorica:Integer;
    function GetUscitaTeorica:Integer;
    function GetIndPresAssenza:String;
    function GetmmMinDetrazMensa:Integer;
    function GetInizioMensa:Integer;
    function GetFineMensa:Integer;
    procedure SetFasciaMensa(MinutiRif:integer);
    function GetRilevatore:String;
    function GetTimbratureDiMensa:String;
    function GetOreMensaMaturate:Integer;
    function GetStaccoPausaMensa:Integer;
    function GetPianGGIndPresenza:String;
    function GetPianGGLivello:String;
    function GetPianRepLivello:String;
    function GetCarenzaObbNoLiq:Integer;
    function GetOreReseTotali:Integer;
    function GetNumTurniReperibilita(TipoTurno:String):Boolean;
    function GetRiepPresTotale(i:Byte):Integer;
    function GetRiepPresNonCau:Integer;
    function GetRiepAssenza(Causale,Risultato:String):Integer;
    function GetRiepAssenzaOreInalterate:Integer;
    function GetTurniExtraPianificati(Tipo:String):String;
    function GetTurniExtraPianificatiDalleAlle(Tipo:String):String;
    function GetPercPartTime(Tipo:String):Single;
    function GetGiustifPM:Boolean;
    function GetMinLavCau(CauPres:String):Integer;
    function GetMinLavCauFasce(CauPres:String):String;
    function GetDataFamiliare(Causale:String):TDateTime;
    procedure PutSpezzoniNonAbilitati(TipoAbil, TipoSpez: String; Inizio, Fine: Integer);
    function  GetProlungamentoInibito(TipoSpez:String = ''):Integer;
    function  GetProlungamentoNonCausalizzato(TipoSpez:String = ''):Integer;
    function  GetProlungamentoNonCausUscita:Integer;
    function  GetEccedIterDisponibile:Integer;
    function  GetEccedenzaIterdaAutorizzareInFasce:String;
    function  GetValenzaGGAss:Real;
    //function GetProlungamentoNonCausEntrata: Integer;
    function  GetPrimaEntrataNominaleUsata:Integer;
    function  GetUltimaUscitaNominaleUsata:Integer;
    function  GetXParam(Param:String):Boolean; inline;
    function  GetDetrazRiepprNorm:String;
    procedure AttivaGiutificativiPerPausaMensa;
    procedure AttivaGiutificativiPerFlessibilita;
    procedure GestioneTimbratureDipendente;
    procedure DefinizioneTurnoNotturno;
    procedure AggiornaTimbPerTurnoNotturno(FineNotte,Ritardo:Integer);
    procedure AggiornaGiustifPerTurnoNotturno(FineNotte,Ritardo:Integer);
    procedure AggiornaRiepPresPerTurnoNotturno(FineNotte:Integer);
    procedure EliminaGiustifPerTurnoNotturno(Modalita:String; FineNotte,Ritardo:Integer);
    function  EsisteTurnoNotturnoPianificato:Boolean;
    procedure WConsideraRichiesteWeb(Valore:Boolean);
    function  GiustificativiR600_Indice(tga,i:Integer):Integer;
    procedure AggiornaTimbratureOriginali(E,U:Integer);
    function  EntrataOriginale(idx:Integer):Integer;
    function  UscitaOriginale(idx:Integer):Integer;
    function  TimbraturaIsolata(idx:Integer):Boolean;
    function  TimbraturaCavalloMezzanotte(idx:Integer; Verso:String):Boolean;
    function  ProporzionaPartTime(TipoProp:String; Value:Integer):Integer;
    procedure TTimbratureDip_Compatta;
    procedure TTimbratureDip_Backup(var ArrayBackup: array of t_ttimbraturedip);
    procedure TGiusDalleAlle_Backup(var ArrayBackup: array of t_tgius_dallealle);
    procedure TTimbratureDip_Restore(var ArrayBackup: array of t_ttimbraturedip);
    procedure TGiusDalleAlle_Restore(var ArrayBackup: array of t_tgius_dallealle);
    procedure Inizio;
    procedure I000_PrimaVol;
    procedure z000_Conteggio;
    procedure z008_GestioneAnomalie;
    procedure z010_azziniz;
    procedure z020_datainiz;
    procedure z022_calend;
    procedure z024_acqcodindp;
    procedure z026_notteparz;
    procedure z028_nottecaus;
    procedure z030_flexorarE;
    procedure z034_gestflexen;
    procedure z035_gestflexTurnoDiurno;
    procedure z036_gestflexcv;
    procedure z040_fascdacon;
    procedure z042_dipinser;
    procedure z043_arrotgiustore;
    procedure z044_intimgiu;
    procedure z046_orario;
    procedure z050_instimfc;
    procedure z051_instim_orariospezzato;
    procedure z052_profiloorar;
    procedure z056_pausame;
    procedure z058_oreteotur;
    procedure z060_appoggio(DueTurni:Boolean);
    procedure z061_appoggioc1(i:Integer);
    procedure z062_appoggioc2(i,T:Integer);
    procedure z064_causali;
    procedure z066_causalic;
    procedure z068_causpresab;
    procedure z070_causpmenab;
    procedure z071_salvatimbrature;
    procedure z072_tipoconA;
    procedure z074_tipoconAc1;
    procedure z076_tipoconAca(Minuti:Integer);
    procedure z078_tipoconAc2(Riepiloga:Boolean);
    procedure z079_tipoconAc3(i:Integer);
    procedure z080_tipoconAf;
    procedure z082_tipoconAfc;
    procedure z084_pausamecop;
    procedure z086_pausamecon(SoloControllo:Boolean = False);
    procedure z088_flexorarA;
    procedure z090_flexrit;
    function  z091_flexIntervalloCompleto:Integer;
    procedure z092_flexspost;
    procedure z094_appoggcaus;
    procedure z096_presinorar;
    function  z097_anom2caus_conteggio(pCodAnom:Word; pCausale:String = 'tcausale.tcaus'): Integer;
    procedure z098_anom2caus(pCodAnom:Word; pCausale:String = 'tcausale.tcaus');
    procedure z099_anom3(pCodAnom:Word; pTimb:Integer; pDesc:String);
    procedure z100_coppieEU;
    procedure z102_fuoriorario;
    procedure z104_Eanticipata;
    procedure z106_Eanttest;
    procedure z108_Ecoincnomin;
    procedure z110_Eritardata;
    procedure z112_Eritdopor;
    procedure z114_Uritardata;
    procedure z116_Urittest;
    procedure z118_Ucoincnomin;
    procedure z120_Uanticipata;
    procedure z122_Uantprimaa;
    procedure z124_insTimbtipoAesc(I,F:Integer);
    procedure z125_delTimbtipoAesc(I,F:Integer);
    procedure z126_allineaMintipoAesc(I,F:Integer);
    function z130_FlexTipoConA:Integer;
    function z132_FlexPM(FlexPM,PN:Integer):Integer;
    procedure z136_inibizprol;
    procedure z138_detrrieppr(Abbatti_tminlav:Boolean = True; OreEscluse:Boolean = False);
    procedure z139_detrTimbNonAppoggiate(TimbCausalizzata:Boolean);
    procedure z140_detrazioni(var Vettore:t_FasceInteri);
    procedure z141_detrmensaF;
    procedure z142_detrmensa;
    procedure z143_abbattirientro;
    procedure z144_strgiornal;
    procedure z145_puntinommax;
    procedure z146_tipomenCDE(SoloGiustificativiPM:Boolean = False);
    procedure z148_timbmensa(SoloGiustificativiPM:Boolean = False);
    function z149_EsisteTimbraturaMensa(Attivazione:String):Boolean;
    procedure z150_contrat;
    procedure z152_constorico;
    procedure z154_contdatadec;
    procedure z156_fasce;
    procedure z158_fascecaric;
    procedure z162_ordinfasce;
    function  z164_ultimafascia(limiteSup:integer):Byte;
    procedure z166_contrfasc;
    procedure z170_tipofasc;
    procedure z172_monteore;
    procedure z176_monteorelet;
    procedure z180_gglavnor;
    procedure z181_gglavtur;
    procedure z182_debitoor;
    procedure z184_debiti;
    procedure z185_gestfrazdeb;
    procedure z186_fascein;
    procedure z187_RicalcoloDebitoGiornaliero;
    procedure z188_debitopo;
    function  z189_debito_ggass(debito_std:Integer):Integer;
    procedure z190_debpoind;
    procedure z192_debpocat;
    procedure z194_gglavmens;
    procedure z198_arrgiornal;
    procedure z199_arrgiornal_finale;
    procedure z200_oreelast;
    procedure z202_minfaselast;
    procedure z208_strdopoteo;
    procedure z210_legginomA;
    procedure z212_corregginomA;
    procedure z220_legginomB;
    procedure z240_legginomC;
    procedure z260_legginomD;
    procedure z280_legginomE;
    procedure z284_contrpianif;
    procedure z286_ordintimbrn;
    procedure z300_giustdaa;
    procedure z310_giustore;
    procedure z312_giusprenore;
    procedure z320_giustmgass;
    procedure z330_giustggass;
    procedure z340_giumgggass;
    procedure z342_valggass;
    procedure z344_inpcausass;
    procedure z346_debdaorar(var r_minuti180:Integer);
    procedure z350_gestglobass;
    procedure z352_infsuicont;
    procedure z354_infsulplor;
    procedure z356_calflpagass;
    procedure z390_riepasse;
    procedure z400_timbrat;
    procedure z402_timbratarc;
    procedure z404_timbrcaric;
    procedure z406_timbrprec;
    procedure z408_timbrgior;
    procedure z410_timbrsucc;
    procedure z412_timbratmat;
    procedure z414_timbrprec;
    procedure z416_timbrprecma;
    procedure z418_timbrprecar;
    procedure z420_timbrgior;
    procedure z422_timbrsucc;
    procedure z424_timbrsuccma;
    procedure z426_timbrsuccar;
    procedure z428_contrrilev;
    procedure z430_giustif;
    procedure z432_giustifarc;
    procedure z434_giustcararc;
    procedure z436_giustcarica(l04:Boolean; GGDopo:Boolean = False);
    procedure z438_giustifmat;
    procedure z440_giustcarmat;
    function  z444_InsTimbDaGiust(Caus:String; Dalle,Alle:Integer):Boolean;
    procedure z446_InsTimbDaGiustAss;
    procedure z448_CheckAnomalieIter;
    procedure z450_turnireperib;
    function  z494_CheckTimbMensa:Boolean;
    function  z495_IntervalloTimbMensa(U,E:Integer):Boolean;
    procedure z496_inscausPM;
    procedure z498_SpezzaPausaMensa;
    procedure z500_orarfac;
    procedure z502_acqorind;
    procedure z504_appoggiotor;
    procedure z506_inttimbr;
    procedure z512_spezztimb;
    procedure z520_repdaturpian;
    function  z521_TimbEsterneAllaReperib(x:Integer):Char;
    procedure z522_repdaintur;
    procedure z523_GetTurniPerContrTimbrTurni(T,TipoTurno:String; DT:TDateTime;OraInizio: String = ''; OraFine: String = '');
    procedure z524_gesturrep(IT,FT:Integer; TipoTurno:String);
    procedure z525_InizioFasciaAbilitazione(IT,FT:Integer; TipoTurno:String; TurnoReperibilita:Boolean);
    procedure z526_FineFasciaAbilitazione(IT,FT:Integer; TipoTurno:String; TurnoReperibilita:Boolean);
    procedure z527_FasciaAbilitazioneInterna(IT,FT:Integer; TipoTurno:String; TurnoReperibilita:Boolean);
    procedure z540_FasceCausalizzazione(FascePN:Boolean = False);
    function  z541_GetFasceAutorizzazione(Causale:String; DataRif,Data:TDateTime; FascePN:Boolean = False):Boolean;
    procedure z542_GestioneFasceAbilitazione(FascePN:Boolean = False);
    function  z543_CausaleFascePN(Causale:String; FascePN:Boolean):Boolean;
    procedure z550_LiberaProfessione;
    procedure z551_FlessibilitaLibProf;
    procedure z552_TimbratureInLibProf;
    procedure z553_InizioLibProf(IT,FT:Integer);
    procedure z554_FineLibProf(IT,FT:Integer);
    procedure z555_LibProfInterna(IT,FT:Integer);
    procedure z556_GiustifInLibProf;
    procedure z560_FasceGettone(FascePN:Boolean = False);
    procedure z570_CompattaTimbrature;
    procedure z700_gestindenn;
    procedure z702_indnotmin;
    procedure z704_indpres;
    procedure z706_indverieri;
    procedure z708_indennitadascostgg;
    procedure z710_indennita;
    procedure z711_GetPercentualiPartTime(var IndPres,IndFest:Real);
    procedure z712_indturpal;
    procedure z714_suddivisioneFasce(segno,mmda,mma,j:Integer; var Vettore:array of Integer);
    procedure z720_turfat;
    procedure z730_RiepilogoRilevatori;
    procedure z731_RiepilogoLibProf;
    procedure z740_AlterazioneOreRese;
    procedure z750_saldigg;
    procedure z752_lavscostgg;
    procedure z756_fasciaobbligatoria;
    procedure z760_minattrtur;
    procedure z770_datifinali;
    procedure z772_tipistraor;
    procedure z773_getstraor;
    procedure z774_strdopodeb;
    procedure z776_intersfasc(i,j:Integer);
    procedure z778_ripcomfasce;
    procedure z780_OreCausDetPausaMensa;
    procedure z782_OreCausalizzateLimitate;
    procedure z784_OreCausalizzateInterneLimitate;
    procedure z785_OreCausalizzateInferioriMinimo;
    procedure z790_OrdinaRiepiloghi;
    procedure z802_toglitimbr;
    procedure z803_toglitimbrcon;
    procedure z810_rieppres(MaxMinuti:Integer; TagTimb:String = '');
    procedure z812_suddfascep;
    procedure z814_CausaliInFasce(C:String; E,U:Integer);
    procedure z815_SuddivisioneFasce(C,TG:String; E,U:Integer);
    procedure z816_insetimbr;
    procedure z817_salva_timbraturedip;
    procedure z818_ripristina_timbraturedip;
    procedure z820_coppiecaus;
    procedure z822_arrEU;
    procedure z824_riepincesc;
    procedure z826_gesggparz;
    procedure z828_saltimbcon;
    procedure z830_mininpiu;
    procedure z840_datifrazdeb;
    procedure z850_FascePaghe;
    procedure z860_coppienorm;
    procedure z862_suddfascen;
    procedure z886_fuoriorarrE;
    procedure z888_fuoriorarrU;
    procedure z890_arrotonda(pTipoModif:String = '');
    procedure z892_arrotondap;
    procedure z914_leggiparam;
    procedure z922_leggicalen(Data:TDateTime; var ZTipoGG,ZTipoGGLav:Char);
    procedure z924_leggipian;
    procedure z930_Carical10;
    procedure z936_leggipoin;
    procedure z938_leggipocat;
    procedure z946_leggiorar;
    procedure z948_leggiprofor;
    procedure z950_leggicontr;
    procedure z951_leggifasce;
    procedure z952_leggifascesuccessive;
    procedure z964_leggicaus(key029_1:String);
    procedure z965_SettaCausPres(var C:t_tcausale);
    function  z966_leggicausT265(Codice:String):Boolean;
    function  z967_leggicausT275(Codice:String):Boolean;
    procedure z978_leggimonte;
    procedure z980_leggioralegalesolare;
    function  z999_Seleziona(Q:TOracleDataSet; Parametro,Valore:String):Boolean;
    procedure z1000_ReperibilitaSostitutivaB;
    function  z1001_ControlloTurnoRep(Codice:String; Data:TDateTime; Turno:array of TTurno):Integer;
    procedure z1002_TimbNotturnaNonAppoggiata;
    procedure z1003_StraordinarioForzato;
    procedure z1004_ArrotondaOreCausalizzate;
    procedure z1005_QuadraturaSettimanale;
    function  z1006_OreEsterne(Dalle,Alle:Integer):Integer;
    procedure z1007_AbbatteSuddivisionefasce;
    function  z1008_TipoGiorno276(C:String; GGSucc:Boolean):String;
    procedure z1009_CausalizzaStraordinario;
    procedure z1010_RientroPomeridiano;
    procedure z1011_MaturaRiposoCompensativo;
    procedure z1012_FestivoLavorato;
    procedure z1013_ArrotondaOreCausalizzateSGM;
    procedure z1014_CompensoDebitoDaCausEscluse;
    procedure z1015_limitazione_giustdaa;
    procedure z1016_EsclusioneOreNonLav;
    procedure z1017_TolleranzaPMA;
    procedure z1018_GetCausInizioFineOrario(CausInizioFine:String; var MinutiInizio,MinutiFine:Integer; var CausaleIO,CausaleFO:t_tcausale);
    function  z1018_CausalizzaInizioFineOrario(idx:Integer = -1; CausInizioFine:String = ''):Integer;
    procedure z1019_RiepilogoStruttureConvenzionate;
    procedure z1144_strgiornalEscl;
    procedure z9999_NotteUscita;
    function GetEsisteGiustificativo(TipoGiust, Parametro, Valore: String): Boolean;
    function GetFlessibilitaPM: Integer;
    function GetFlessibilitaRit: Integer;
    function GetFlessibilitaTot: Integer;
    function GetMaxFlex:Integer;
    function GetDescAnomaliaBloccante: String;
    function GetEsisteTagTimbratura(Value: String): Boolean;
    function EsistePrecedenteElaborazione(Firma: String): String;
    procedure AggiungiPrecedenteElaborazione(Firma, Risultato: String);
  public
    { Public declarations }
    QDaData,QAData:TDateTime;
    QProgressivo:LongInt;
    DetrazStraord:Integer;
    OraLegaleSolare:TOraLegaleSolare;
    TOCOQuadraturaSettimanale:Boolean;  //TORINO_COMUNE
    esegui_z430:Boolean;  //Se false i giustificativi non vengono più caricati
    esegui_z432:Boolean;  //Se false i giustificativi non vengono più letti da tabella
    CodTurniReperibilita:array of TCodTurniReperibilita;
    Q060_OREPO:Integer;
    Q090_OREPO:Integer;
    //***   Dati di input
    chiamante:String; //Cartellino,Cartolina,Assenze,Anomalie,Servizio,Contratto,APERTURA,
    datacon:TDateTime;
    //***   Timbrature dipendente del mese da cartellino
    m_tab_timbrature: array[1..31,1..MaxTimbrature] of t_ttimbraturedipmese;
    TimbratureDelGiorno: array of TTimbratureDelGiorno;
    TimbratureOriginali: array of TCoppieTimbrature;
    //***   Giustificativi dipendente del mese da cartellino
    m_tab_giustificativi:array[1..31,1..MaxGiustif] of t_tgiustificdipmese;
    GiustificativiDelGiorno:array of TGiustificativiDelGiorno;
    blocca               :byte;
    dipinser             :String;
    gglavcal             :String;
    giorsett             :Byte;
    pianif               :String;
    pianif_z550          :Boolean;
    c_contratto          :String;
    c_orario             :String;
    tipogg               :Char;
    tipogglav            :Char;
    tipogg_suc           :Char;
    tipogg_suc2          :Char;
    tipogglav_suc        :Char;
    tipogglav_suc2       :Char;
    tipogg_prec          :Char;
    tipogglav_prec       :Char;
    oreteoturni          :Integer;
    minmonteore          :Integer;
    giornlav             :Byte;
    //Turni pianificati (1..n)
    c_turni1             :SmallInt;
    c_turni2             :SmallInt;
    c_ValorGior          :String; 
    //Turni riconosciuti (1..n)
    r_turno1             :SmallInt;
    r_turno2             :SmallInt;
    //Sigla turni
    s_turno1             :String;
    s_turno2             :String;
    //Turni riepilogati (1..4)
    n_turno1             :SmallInt;
    n_turno2             :SmallInt;
    MotivazionePianif    :String;
    TurnoProvv1          :Integer;
    TurnoProvv2          :Integer;
    //Dati del turno notturno del modello orario utilizzato
    TurnoNotturno        :TTurnoNotturno;
    TurnoNotturnoE       :TTurnoNotturno;  //relativo alla pianificazione 'E'
    TurnoNotturnoU       :TTurnoNotturno;  //relativo alla pianificazione 'U'
    //***   Debiti orario per conteggio giornaliero e mensile
    debitogg             :Integer;
    debitorp             :Integer;
    debitorp_ripcom      :Integer;
    debitocl             :Integer; //Debito da calendario
    //Debito da orario, medio e scostamento
    debitodaorario       :Integer;
    scostamentodebito    :Integer;
    //Debito e tipo gestione plus orario (debito aggiuntivo)
    debitopo             :Integer;
    tipogespo            :Char;
    gglav                :String;
    debitopo_percpt      :single;  // % di part-time del debito aggiuntivo
    //***   Contratto corrente
    T200                 :TContratto;
    //***   Indennita' festive, di turno e di presenza
    indfesint            :Real;
    indfesrid            :Real;
    indnotgg             :Byte;
    indnotmin            :Integer;
    indnot_lorda         :tIndNot;
    tindturfas           :t_FasceInteri;
    tindennitapresenza   :array [1..3] of t_tindennitapresenza;
    //***   Eccedenza giornaliera solo compensabile
    eccsolocomp          :SmallInt;
    //***   Eccedenza giornaliera solo compensabile per stampa su cartellino
    EccSoloCompGG        :SmallInt;
    EccSoloCompOltreSoglia :Integer;
    //***   Minuti di scostamento in fascia di elasticita'
    scostfascia          :Integer;
    //***   Minuti conteggiati da assenze
    minassenze           :Integer;
    //***   Minuti di abbattimento straordinario liquidabile
    minabbstr            :Integer;
    n_fasce              :Byte;
    //***   Fasce orarie
    tfasceorarie: array [1..MaxFasceGio] of t_tfasceorarie;
    tfasceorarie_indturno: array [1..MaxFasceGio] of t_tfasceorarie;
    //***   Minuti lavorati suddivisi in fasce
    tminlav              :t_FasceInteri;
    n_anom2              :SmallInt;
    n_anom3              :SmallInt;
    //***   Anomalie del secondo livello riscontrate
    tanom2riscontrate: array (*WEB[1..20]*) of t_tanom2riscontrate;
    //***   Anomalie del terzo livello riscontrate
    tanom3riscontrate: array (*WEB[1..40]*) of t_tanom3riscontrate;
    n_rieppres           :Byte;
    n_riepasse           :Byte;
    //***   Riepilogo giustificativi presenza
    triepgiuspres        :array [1..10] of t_triepgiuspres;
    //***   Riepilogo giustificativi assenza
    triepgiusasse        :array [1..20] of t_triepgiusasse;
    //***   Riepilogo rilevatori
    trieprilev           :array of t_trieprilev;
    telencorilev         :array of String;
    numcorr              :LongInt;
    //***   Lavorato, scostamento giornaliero, minuti di presenza lordi
    totlav               :Integer;
    scost                :Integer;
    scostneg             :Integer;
    CompNeg_UNonCaus     :Integer;
    minpresenzelorde     :Integer;
    debitoposm           :Char;
    debitoposv           :Char;
    debitopomm           :String;
    debpoind             :String;
    datadeccon           :LongInt;
    gginser              :Byte;
    gglavser             :Byte;
    FestivoNonGoduto     :Byte;
    MinRicalcoloFest     :Integer;
    //***   Minuti lavorati prima e dopo mezzogiorno
    minlavmat            :Integer;
    minlavpom            :Integer;
    //***   Detrazione di debito plus orario causa assenze
    detrdebitopo         :Byte;
    //****   Riposi compensativi da turnazione
    ripcom               :Integer;
    //****   Abbattimento anno precedente, attuale e riposi compensativi
    abbannoprec          :Integer;
    abbannoatt           :Integer;
    abbliqannoprec       :Integer;
    abbliqannoatt        :Integer;
    abbripcom            :Integer;
    abbBancaOre          :Integer;
    //***   Minuti potenzialmente liquidabili suddivisi in fasce
    tminstrgio:t_FasceInteri;
    tminstrgio1:t_FasceInteri;
    tminstrgio2:t_FasceInteri;
    tminstrgio3:t_FasceInteri;
    tminstrgio4:t_FasceInteri;
    ggpres               :Byte;
    ggpomer              :Byte;
    ggvuoto              :Byte;
    ggvuoto_turnista     :Byte;
    ggpresenza           :Byte;
    strcontrat           :String;
    //***   Dati di output
    bloccatimb           :Byte;
    n_timbrcon           :Byte;
    lavsupset            :Integer;
    tollergod            :Integer;
    minattrib            :Integer;
    //***   Timbrature dipendente conteggiate a coppie di E _ U
    ttimbraturecon       :array [1..MaxTimbrature] of t_ttimbraturecon;
    IntervalloUscita     :TIntervalloUscita;
    NotteSuEntrata       :Boolean;
    NotteSuEntrata_TurnoCompleto: Boolean;
    primavolta           :String;
    s_trovato            :String;
    f03_com              :String;
    tipofasc             :Byte;
    primat_u             :String;
    ultimt_e             :String;
    n_timbrdip           :Byte;
    n_giusdaa            :Byte;
    PauMenMinUtilizzata  :Integer;
    paumenges            :String;
    TipoDetPaumen        :String;
    paumenTimbNonGes     :Boolean;
    paumendet            :Integer;
    paumencont           :Integer;
    paumencont_nonrese   :Integer;
    paumentimb_e         :Integer;
    paumentimb_u         :Integer;
    paumendet_giust      :Integer;
    rec_psicofisico      :Integer;
    //***   Timbratura precedente e timbratura successiva
    estimbprec        :String;
    verso_pre         :Char;
    minuti_pre        :Integer;
    minuti_pre_caus   :Integer;
    rilev_pre         :String;
    caus_pre          :String;
    data_pre          :TDateTime;
    estimbsucc        :String;
    verso_suc         :Char;
    minuti_suc        :Integer;
    rilev_suc         :String;
    caus_suc          :String;
    data_suc          :TDateTime;
    //***   Timbrature nominali del giorno a coppie di E _ U
    n_timbrnom           :Byte;
    ttimbraturenom       :array of t_ttimbraturenom;
    ttimbraturenom_vuota :t_ttimbraturenom;
    //***   Debito orario per conteggio indennita' festive
    debitoindfes         :Integer;
    mmminpresieriint     :Integer;
    mmminpresierimez     :Integer;
    mmminpresoggiint     :Integer;
    mmminpresoggimez     :Integer;
    //***   Minuti lavorati esclusi da quelli normali
    minlavesc            :Integer;
    //***   Minuti lavorati per indennita' festive
    minlavfes            :Integer;
    minlavfes_nottecompletaCorr: Integer;
    minlavfes_nottecompletaSucc: Integer;
    minlavfes_nottecompletaPrec: Integer;
    datacon_indfes_nottecompleta: TDateTime;
    indfes_lorda         :tIndFes;
    //***   Dati per conteggio indennita' di presenza
    numcorrpreccall      :Integer;
    indprescalcieri      :String;
    minlavpresieri       :Integer;
    tollpresieri         :Byte;
    compnotieri          :Char;
    minlavpresoggi       :Integer;
    minlavprescav        :Integer;
    indpresdaass         :String;
    n_giusore            :Byte;
    n_giusmga            :Byte;
    n_giusgga            :Byte;
    valggass             :Integer;
    valggcompass         :Integer;
    CoperturaCarenza     :Integer;
    //Fasce obbligatorie/facoltative
    PresenzaObbligatoria :Integer;
    PresenzaFacoltativa  :Integer;
    CarenzaObbligatoria  :Integer;
    CarenzaFacoltativa   :Integer;
    ScostFacoltativa     :Integer;
    //***   Minuti da causale di presenza con tipo conteggio A ed
    //***   esclusione dalle ore normali
    mintipoAesc          :Integer;
    timbtipoAesc         :array of TPeriodoIF;
    //***   Timbrature dipendente del giorno a coppie di E _ U
    ttimbraturedip: array [1..MaxTimbrature] of t_ttimbraturedip;
    //***   Giustificativi dalle alle
    tgius_dallealle: array [1..MaxGiustif] of t_tgius_dallealle;
    //***   Giustificativi in numero ore
    tgius_min: array [1..MaxGiustif] of t_tgius_min;
    //***   Giustificativi mezza giornata assenza
    tgius_mgass: array [1..2] of t_tgius_mgass;
    //***   Giustificativi giornata intera assenza
    tgius_ggass: array [1..5] of t_tgius_ggass;
    GiustDistFamiliari   :Boolean;
    FasceCausali276: array (*WEB [1..20]*) of TFasceCausali276;
    OreCausali276:   array (*WEB [1..20]*) of Integer;
    FascePaghe276:   array (*WEB [1..20]*) of TFascePaghe;
    Gettoni:         array of tGettoni;
    TimbratureMensa: array of TPeriodoIF;
    RiepLibProf:array of TRiepLibProf;
    RiepStruttureConvenzionate: array of TRiepLibProf;
    SpezzoniNonAbilitati: array of TSpezzoniNonAbilitati;
    ConteggiaGiustificativiR600 :Boolean;
    CaricaGiustificativiR600    :Boolean;
    GiustificativiR600          :array of TGiustificativiR600;
    PianificazioneEsterna:TPianificazioneEsterna;
    Q100                 :TOracleDataSet;
    FiltroDizionarioAnomalie:Boolean;
    RientroPomeridiano:TRientroPomeridiano;
    lstAnomalieGG: TList<TAnomalieGG>;
    IgnTimbNonInSeqForzata:Boolean;
    constructor Create(AOwner:TComponent; OwnerNil:Boolean = False);
    destructor Destroy; override;
    function PeriodoConteggi(DaData,AData:TDateTime):Boolean;
    procedure z442_giustcar_esterno(tcausgius:String; tdallegius, tallegius:TDateTime; ttipogius:Char);
    procedure z916_startgiust;
    procedure z918_leggigiust;
    procedure z926_starttimbr(Data:TDateTime);
    procedure z928_leggitimbr;
    procedure Conteggi(FChiamante:String; Progressivo:LongInt; Data:TDateTime);    
    procedure Resetta;
    procedure ResettaProg;
    function SpezzoniNonCausEccedenti:Integer;
    function GetNoteGiustificativo(giusasse:t_triepgiusasse):String;
    function ChiamataReperibilita(Data:TDateTime; Dalle,Alle:Integer):Boolean;
    function idxAnomalia(Livello,Anomalia:Integer):Integer;
    function CheckFruizGiustdaa(Causale:String; DaOre,AOre:Integer; var PeriodoFruizione:String):Boolean;
    property ValNumT020[Campo:String]:Integer read GetValNumT020;
    property ValNumT021[Campo,TipoFascia:String; Indice:Integer]:Integer read GetValNumT021;
    property ValStrT021[Campo,TipoFascia:String; Indice:Integer]:String read GetValStrT021;
    property ValStrT025[Campo:String; Default:String = '']:String read GetValStrT025;
    property ValStrT265[Codice,Dato:String]:String read GetValStrT265;
    property ValStrT275[Codice,Dato:String]:String read GetValStrT275;
    property EsisteGiustificativo[TipoGiust,Parametro,Valore:String]:Boolean read GetEsisteGiustificativo;
    property PausaMensa:String read GetPausaMensa;
    property TipoOrario:String read GetTipoOrario;
    property PeriodoLavorativo:String read GetPeriodoLavorativo;
    property EntrataNominale[i:Byte]:Integer read GetEntrataNominale;
    property UscitaNominale[i:Byte]:Integer read GetUscitaNominale;
    property EntrataNominaleNetta[i,ie:Byte]:Integer read GetEntrataNominaleNetta;
    property UscitaNominaleNetta[i,iu:Byte]:Integer read GetUscitaNominaleNetta;
    property EntrataTeorica:Integer read GetEntrataTeorica;
    property UscitaTeorica:Integer read GetUscitaTeorica;
    property IndPresAssenza:String read GetIndPresAssenza;
    property mmMinDetrazMensa:Integer read GetmmMinDetrazMensa;
    property InizioMensa:Integer read GetInizioMensa;
    property FineMensa:Integer read GetFineMensa;
    property Rilevatore:String read GetRilevatore;
    property TimbratureDiMensa:String read GetTimbratureDiMensa;
    property OreMensaMaturate:Integer read GetOreMensaMaturate;
    property StaccoPausaMensa:Integer read GetStaccoPausaMensa;
    property PianGGIndPresenza:String read GetPianGGIndPresenza;
    property PianGGLivello:String read GetPianGGLivello;
    property PianRepLivello:String read GetPianRepLivello;
    property CarenzaObbNoLiq:Integer read GetCarenzaObbNoLiq;
    property OreReseTotali:Integer read GetOreReseTotali;
    property RiepPresTotale[i:Byte]:Integer read GetRiepPresTotale;
    property RiepPresNonCau:Integer read GetRiepPresNonCau;
    property RiepAssenza[Causale,Risultato:String]:Integer read GetRiepAssenza;
    property RiepAssenzaOreInalterate:Integer read GetRiepAssenzaOreInalterate;
    property TurniExtraPianificati[Tipo:String]:String read GetTurniExtraPianificati;
    property TurniExtraPianificatiDalleAlle[Tipo:String]:String read GetTurniExtraPianificatiDalleAlle;
    property PercPartTime[Tipo:String]:Single read GetPercPartTime;
    property ConsideraRichiesteWeb:Boolean read FConsideraRichiesteWeb write WConsideraRichiesteWeb;
    property CompDebitoCausEscluse:Integer read FCompDebitoCausEscluse;
    property MinLavCau[CauPres:String]:Integer read GetMinLavCau;
    property MinLavCauFasce[CauPres:String]:String read GetMinLavCauFasce;
    property DataFamiliare[Cauale:String]:TDateTime read GetDataFamiliare;
    property ProlungamentoInibito[TipoSpez:String]: Integer read GetProlungamentoInibito;
    property ProlungamentoNonCausalizzato[TipoSpez:String]: Integer read GetProlungamentoNonCausalizzato;
    property ProlungamentoNonCausUscita: Integer read GetProlungamentoNonCausUscita;
    property EccedIterDisponibile: Integer read GetEccedIterDisponibile;
    property EccedenzaIterDaAutorizzareInFasce:String read GetEccedenzaIterDaAutorizzareInFasce;
    //property ProlungamentoNonCausEntrata: Integer read GetProlungamentoNonCausEntrata;
    property DetrazTotLav: Integer read FDetrazTotLav;
    property PrimaEntrataNominaleUsata:Integer read GetPrimaEntrataNominaleUsata;
    property UltimaUscitaNominaleUsata:Integer read GetUltimaUscitaNominaleUsata;
    property ValenzaGGAss:Real read GetValenzaGGAss;
    property XParam[Param:String]:Boolean read GetXParam;
    property FunzioneChiamante:String read FFunzioneChiamante write FFunzioneChiamante;
    property DetrazRiepprNorm:String read GetDetrazRiepprNorm;
    property FlessibilitaRit:Integer read GetFlessibilitaRit;
    property FlessibilitaPM:Integer read GetFlessibilitaPM;
    property FlessibilitaTot:Integer read GetFlessibilitaTot;
    property MaxFlex:Integer read GetMaxFlex;
    property EsisteTagTimbratura[Value:String]:Boolean read GetEsisteTagTimbratura;
    property prpStrarrdet:Integer read strarrdet;
    property prpStrminimidet:Integer read strminimidet;
    property prpStrgiorn:Integer read strgiorn;
    property DescAnomaliaBloccante:String read GetDescAnomaliaBloccante;
    property CausaleVuota:t_tcausale read tcausale_vuota;
  end;

implementation

{$R *.DFM}

constructor TR502ProDtM1.Create(AOwner:TComponent; OwnerNil:Boolean = False);
var i:Integer;
begin
  //Alberto 04/12/2009 gestione della creazione ricorsiva per evitare problemi col web service B020.
  //Se AOwner è una OracleSession pare dia problemi...........
  //if (AOwner <> nil) and (Pos('RICORSIONE_',AOwner.Name) = 1) then
  if OwnerNil then
  begin
    inherited Create(nil);
    if AOwner <> nil then
      AOwner.Name:=StringReplace(AOwner.Name,'RICORSIONE_','',[]);
  end
  else
    inherited Create(AOwner);
  SessioneOracleR502:=SessioneOracle;
  if AOwner <> nil then
    if AOwner is TOracleSession then
      SessioneOracleR502:=AOwner as TOracleSession;
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracleR502;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracleR502;
  end;
  A000SettaVariabiliAmbiente;
  Q270.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q275.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  selT277.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q330.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q350.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  selT361.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q460.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q100:=selT100;
  lstT265:=TlstElementi.Create;
  lstT230:=TlstElementi.Create;
  lstT235:=TlstElementi.Create;
  lstT011:=TlstElementi.Create;
  Resetta;
  QProgressivo:=0;
  QDaData:=0;
  QAData:=0;
  esegui_z430:=True;
  esegui_z432:=True;
  //cdsT011.FilterOptions:=[foNoPartialCompare];
  cdsT020.FilterOptions:=[foNoPartialCompare];
  cdsT021.FilterOptions:=[foNoPartialCompare];
  z914_leggiparam;
  //Registrazione Descrizione tabelle per accesso ai dati
  QueryActive(pNone,True);
  //*******GESTIONE REPERIBILITA' SOSTITUTIVA B*******//
  QRepSost.Open;
  //Leggo se esistono turni con Sostitutiva B
  RepSost:=QRepSost.RecordCount > 0;
  if RepSost then
  begin
    //Leggo il campo anagrafico di raggruppamento in SquadraSost (gestisco solo un campo)
    SquadraSost:=QRepSostRaggruppamento.AsString;
    if Trim(SquadraSost) = '' then
      RepSost:=False;
  end;
  QRepSost.Close;
  PianificazioneEsterna.Data:=0;
  PianificazioneEsterna.Progressivo:=0;
  TOCOQuadraturaSettimanale:=False;
  FConsideraRichiesteWeb:=False;
  FiltroDizionarioAnomalie:=False;
  ConteggiaGiustificativiR600:=False;
  CaricaGiustificativiR600:=False;
  SetLength(GiustificativiR600,0);
  lstAnomalieGG:=TList<TAnomalieGG>.Create;
  IgnTimbNonInSeqForzata:=False;
  GiustDistFamiliari:=False;
  FFunzioneChiamante:='';
end;

destructor TR502ProDtM1.Destroy;
var i:Integer;
begin
  FreeAndNil(lstAnomalieGG);
  QueryActive(pData,False);
  QueryActive(pProg,False);
  QueryActive(pNone,False);
  FreeAndNil(lstT265);
  FreeAndNil(lstT230);
  FreeAndNil(lstT235);
  FreeAndNil(lstT011);
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).CloseAll;
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Close;
  end;
  inherited Destroy;
end;

function TR502ProDtM1.PeriodoConteggi(DaData,AData:TDateTime):Boolean;
{Imposto i parametri Da Data e A Data nelle query che lo richiedono e le apro}
var DaAnno,AAnno,DaM,AM,DaG,AG:Word;
begin
  PrimaVolta:='si';
  try
    DecodeDate(DaData,DaAnno,DaM,DaG);
    DecodeDate(AData,AAnno,AM,AG);
  except
    Abort;
  end;
  Result:=True;
  {$IFDEF MEDP803}if (QDaData = DaData) and (QAData = AData) then exit;{$ENDIF}
  {$IFNDEF MEDP803}if (QDaData <= DaData) and (QAData >= AData) then exit;{$ENDIF}
  lstT011.Svuota;//cdsT011.Close;
  QDaData:=DaData;
  QAData:=AData;
  QueryActive(pProg,False);
  QueryActive(pData,False);
  Q011B.SetVariable('DaData',DaData - 2);
  Q011B.SetVariable('AData',AData + 2);
  Q012B.SetVariable('DaData',DaData - 2);
  Q012B.SetVariable('AData',AData + 2);
  Q040.SetVariable('DaData',DaData);
  Q040.SetVariable('AData',AData + 1);
  Q040.ReadBuffer:=Max(10,Min(366,Trunc(AData - DaData) + 1));
  selT050.SetVariable('Data1',DaData);
  selT050.SetVariable('Data2',AData + 1);
  selIter.SetVariable('Data1',DaData);
  selIter.SetVariable('Data2',AData + 1);
  {$IFDEF MEDP803}
  Q060.SetVariable('DaAnno',DaAnno);
  Q060.SetVariable('AAnno',AAnno);
  Q090.SetVariable('DaAnno',DaAnno);
  Q090.SetVariable('AAnno',AAnno);
  {$ENDIF}
  {$IFNDEF MEDP803}
  R180SetVariable(Q060,'DaAnno',DaAnno);
  R180SetVariable(Q060,'AAnno',AAnno);
  R180SetVariable(Q090,'DaAnno',DaAnno);
  R180SetVariable(Q090,'AAnno',AAnno);
  {$ENDIF}
  Q080.SetVariable('DaData',DaData);
  Q080.SetVariable('AData',AData);
  //Includo le timbrature del giorno precedente e successivo
  selT100.SetVariable('DaData',DaData - 2);
  selT100.SetVariable('AData',AData + 2);
  selT100.ReadBuffer:=Max(25,Min(500,(Trunc(AData - DaData) + 1)*3));
  selT100T105.SetVariable('DaData',DaData - 2);
  selT100T105.SetVariable('AData',AData + 2);
  selT100T105.ReadBuffer:=Max(25,Min(500,(Trunc(AData - DaData) + 1)*3));
  Q430.SetVariable('DaData',DaData - 2);
  Q430.SetVariable('AData',AData + 2);
  Q320.SetVariable('DaData',DaData - 2);
  Q320.SetVariable('AData',AData + 2);
  Q370.SetVariable('DaData',DaData - 2);
  Q370.SetVariable('AData',AData + 2);
  Q380.SetVariable('DaData',DaData - 2);
  Q380.SetVariable('AData',AData + 2);
  Q332.SetVariable('DaData',DaData - 2);
  Q332.SetVariable('AData',AData + 2);
  selT025.SetVariable('DaData',DaData - 2);
  selT025.SetVariable('AData',AData + 2);
  selVT420.SetVariable('DaData',DaData - 2);
  selVT420.SetVariable('AData',AData + 2);
  //Apro le query
  QueryActive(pData,True);
  {$IFDEF MEDP803}
  if QProgressivo <> 0 then QueryActive(pProg,True);
  {$ENDIF}
end;

procedure TR502ProDtM1.Resetta;
var xx,yy:Integer;
begin
  SetLength(tcausalilette,0);
  lstT265.Svuota;
  lstT230.Svuota;
  lstT235.Svuota;
  SetLength(tprofililetti,0);
  SetLength(tcontrattiletti,0);
  tcausale_vuota.tcaus:='';
  tcausale_vuota.tcaus_orig:='';
  tcausale_vuota.tcausabi:='';
  tcausale_vuota.tcausarr:=0;
  tcausale_vuota.tcauscodrag:='';
  tcausale_vuota.tcauscon:='';
  tcausale_vuota.tcausioe:='';
  tcausale_vuota.tcausMatMensa:='';
  tcausale_vuota.tcauspiu:=0;
  tcausale_vuota.tcausrag:='';
  tcausale_vuota.tcausrip:='';
  tcausale_vuota.tcausrpl:='';
  tcausale_vuota.tcaustip:='';
  tcausale_vuota.tLfsCavMez:='';
  tcausale_vuota.tNonAutorizzate:='';
  tcausale_vuota.tOreInsufficenti:='';
  tcausale_vuota.tminminuti:=0;
  tcausale_vuota.tmaxminuti:=0;
  tcausale_vuota.tpianrep:='';
  ttimbraturedip_vuota.oralegsol:=False;
  ttimbraturedip_vuota.spezzata:=False;
  ttimbraturedip_vuota.inserita:=False;
  ttimbraturedip_vuota.tag:='';
  ttimbraturedip_vuota.tflagarr_e:='';
  ttimbraturedip_vuota.tflagarr_u:='';
  ttimbraturedip_vuota.tminutid_e:=0;
  ttimbraturedip_vuota.tminutid_u:=0;
  ttimbraturedip_vuota.tpuntnomin:=0;
  ttimbraturedip_vuota.tpuntnominold:=0;
  ttimbraturedip_vuota.tpesopuntnomin:=0;
  ttimbraturedip_vuota.trilev_e:='';
  ttimbraturedip_vuota.trilev_u:='';
  ttimbraturedip_vuota.tcausale_e:=tcausale_vuota;
  ttimbraturedip_vuota.tcausale_u:=tcausale_vuota;
  ttimbraturedip_vuota.iOT:=-1;
  ttimbraturedip_vuota.timborig_e:=-1;
  ttimbraturedip_vuota.timborig_u:=-1;
  ttimbraturedip_vuota.tagmodif_e:='';
  ttimbraturedip_vuota.tagmodif_u:='';
  //SetLength(f03_com,20);
  f03_com:='                    ';
  for xx:=Low(T220) to High(T220) do T220[xx]:='';
  for xx:=1 to 50 do for yy:=1 to 9 do T221[xx,yy]:='';
  for xx:=Low(T200) to High(T200) do T200[xx]:='';
  for xx:=1 to 9 do for yy:=0 to 13 do T201[xx,yy]:='';
  cdsT020.Close;
  cdsT021.Close;
  QueryActive(pNone,False);
  QueryActive(pNone,True);
  QueryActive(pData,False);
  QueryActive(pData,True);
end;

procedure TR502ProDtM1.ResettaProg;
begin
  QueryActive(pProg,False);
  QueryActive(pProg,True);
end;

procedure TR502ProDtM1.QueryActive(Param:TParam; Active:Boolean);
{Apro o Chiudo le Query a seconda di Active;}
begin
  case Param of
    //Query legate alla data e I090_Enti
    pData:begin
            {$IFNDEF MEDP803}if Active then{$ENDIF}Q060.Active:=Active;
            if Q060.Active then Q060.First;
            Q011B.Active:=Active;
            if Q011B.Active then Q011B.First;
        end;
    //Query legate al progr. dipendente
    pProg:begin
            Q012B.Active:=Active;
            //Se chiamo da cartellino non leggo i giustificativi
            if (Chiamante = 'Cartellino') (*or (Chiamante = 'Assenze')*) then
              Q040.Active:=False
            else
              Q040.Active:=Active;
            Q080.Active:=Active;
            {$IFNDEF MEDP803}if Active then{$ENDIF}Q090.Active:=Active;
            //Se chiamo da cartellino non leggo le timbrature
            if (Chiamante = 'Cartellino') then
              Q100.Active:=False
            else
              Q100.Active:=Active;
            Q320.Active:=Active;
            Q370.Active:=Active;
            Q380.Active:=Active;
            try Q332.Active:=Active; except end;
            Q430.Active:=Active;
            selT025.Active:=Active;
            if ConsideraRichiesteWeb then
              selT050.Active:=Active;
            selVT420.Active:=Active;
            selIter.Active:=Active;
            if Q012B.Active then Q012B.First;
            if Q040.Active then Q040.First;
            if Q080.Active then Q080.First;
            if Q100.Active then Q100.First;
            if Q320.Active then Q320.First;
            if Q370.Active then Q370.First;
            if Q380.Active then Q380.First;
            if Q332.Active then Q332.First;
            if Q430.Active then Q430.First;
            if selT025.Active then selT025.First;
            if selT050.Active then selT050.First;
            if selVT420.Active then selVT420.First;
            if selIter.Active then selIter.First;
          end;
    //Query generali
    pNone:begin
            if not Active then
            begin
              selT020.Active:=Active;
              selT021.Active:=Active;
              Q265.Active:=Active;
              selT230.Active:=Active;
              selT235.Active:=Active;
            end;
            Q210.Active:=Active;
            Q270.Active:=Active;
            Q275.Active:=Active;
            selT277.Active:=Active;
            Q330.Active:=Active;
            Q350.Active:=Active;
            selT361.Active:=Active;
            Q460.Active:=Active;
            Q110.Active:=Active;
            Q276.Active:=Active;
            selT265CumP.Active:=Active;
          end;
  end;
end;

function TR502ProDtM1.SpezzoniNonCausEccedenti:Integer;
var i,Tot:Integer;
begin
  Result:=0;
  if cdsT020.FieldByName('SPEZZNONCAUS_SCARTOECC').AsString = 'N' then
    exit;
  //Totale timbrature non appoggiate, incluse nelle normali
  Tot:=0;
  for i:=1 to n_timbrdip do
    if ((ttimbraturedip[i].tpuntnomin = 0) or (debitogg = 0)) and (Copy(ttimbraturedip[i].tag,1,3) <> 'TG=') and (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'ORENORMALI'] <> 'A') then
      inc(Tot,ttimbraturedip[i].tminutid_u - ttimbraturedip[i].tminutid_e);
  //Differenza tra timbrature non appoggiate e scostamento gg
  if XParam[XP_COTO_SPEZZNONCAUS_DETPM] then
    {problema: la prima volta se non ci sono causalizzazioni va bene, mentre dopo a seconda delle
     causalizzazioni presenti PauMenDet dovrebbe variare in funzione di paumendet_rieppres,
     ma se ci sono delle ore non causalizzate si rischia di non assorbire tutta la PauMenDet sul riepilogo della causale}
    Result:=Max(0,Tot - (PauMenDet - paumendet_rieppres) - Scost)
    //Result:=Max(0,Tot - PauMenDet - Scost)
  else
    Result:=Max(0,Tot - Scost);
end;

function TR502ProDtM1.GetNoteGiustificativo(giusasse:t_triepgiusasse):String;
begin
  Result:='';
  if Q040.Active then
    Result:=VarToStr(Q040.Lookup('DATA;CAUSALE;TIPOGIUST',VarArrayOf([DataCon,giusasse.tcausasse,giusasse.ttipofruiz]),'NOTE'));
end;

function TR502ProDtM1.ChiamataReperibilita(Data:TDateTime; Dalle,Alle:Integer):Boolean;
var i,j:Integer;
begin
  Result:=False;
  z926_starttimbr(Data);
  with Q100 do
    while not Eof do
    begin
      if Q100.FieldByName('DATA').AsDateTime > Data + 1 then
        Break;
      if (Q100.FieldByName('DATA').AsDateTime = Data) and
         (Q100.FieldByName('VERSO').AsString = 'E') and
         (R180Between(R180OreMinuti(Q100.FieldByName('ORA').AsDateTime),Dalle,IfThen(Dalle < Alle,Alle,1440))) and
         (ValStrT275[Q100.FieldByName('CAUSALE').AsString.Trim,'CODINTERNO'] = 'C') then
      begin
        Result:=True;
        Break;
      end;
      if (Q100.FieldByName('DATA').AsDateTime = Data + 1) and
         (Q100.FieldByName('VERSO').AsString = 'E') and
         (R180Between(R180OreMinuti(Q100.FieldByName('ORA').AsDateTime),IfThen(Dalle < Alle,Alle + 1,0),Alle)) and
         (ValStrT275[Q100.FieldByName('CAUSALE').AsString.Trim,'CODINTERNO'] = 'C') then
      begin
        Result:=True;
        Break;
      end;
      Next;
    end;

  if not Result then
  begin
    //Ricerco timbratura in reperibilità conseguente ad anomalia di causalizzazione fuori turno: vuol dire che la timbratura effettiva è esterna al turno, ma poi prosegue su periodo valido
    for i:=1 to n_timbrcon do
    begin
      if (ValStrT275[ttimbraturecon[i].tcaus,'CODINTERNO'] = 'C')
      and (ttimbraturecon[i].tminutic_e < IfThen(Dalle < Alle,Alle,Alle + 1440))
      and (ttimbraturecon[i].tminutic_u > Dalle)
      then
      begin
        for j:=1 to n_anom2 do
          if (tanom2riscontrate[j].ta2puntdesc = 30)
          and (Pos(ttimbraturecon[i].tcaus,tanom2riscontrate[j].ta2caus) > 0)
          and (Pos(R180MinutiOre(ttimbraturecon[i].tminutic_e),tanom2riscontrate[j].ta2caus) > 0)
          then
          begin
            Result:=True;
            Break;
          end;
        if Result then
          Break;
      end;
    end;
  end;
end;

function TR502ProDtM1.idxAnomalia(Livello,Anomalia:Integer):Integer;
var i:Integer;
begin
  Result:=-1;
  if Livello = 1 then
  begin
    if Blocca = Anomalia then
      Result:=0
  end
  else if Livello = 2 then
  begin
    for i:=Low(tanom2riscontrate) to High(tanom2riscontrate) do
      if tanom2riscontrate[i].ta2puntdesc = Anomalia then
      begin
        Result:=i;
        Break;
      end;
  end
  else if Livello = 3 then
  begin
    for i:=Low(tanom3riscontrate) to High(tanom3riscontrate) do
      if tanom3riscontrate[i].ta3puntdesc = Anomalia then
      begin
        Result:=i;
        Break;
      end;
  end;
end;

function TR502ProDtM1.CheckFruizGiustdaa(Causale:String; DaOre,AOre:Integer; var PeriodoFruizione:String):Boolean;
var E,U,Flex:Integer;
begin
  Result:=True;
  PeriodoFruizione:='';
  if not Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    exit;
  if not R180In(Causale,TO_CSI_GIUST_LIMITATI.Split([','])) then
    exit;

  E:=0;
  U:=1440;
  Flex:=0;
  //fruizione compresa tra E + flex ed U
  if High(ttimbraturenom) > 0 then
  begin
    E:=ttimbraturenom[1].tminutin_e;
    if not R180In(Causale,[TO_CSI_RICH_RECHH,TO_CSI_REC_SETT,TO_CSI_REC_BANCAORE]) then
      U:=ttimbraturenom[1].tminutin_u;
    Flex:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1];
    if (DaOre < E + Flex) or (AOre > U) then
      Result:=False;
  end;

  //fruizione esterna alla fascia di PMT
  if InizioMensa < FineMensa then
  begin
    if (DaOre < FineMensa) and (AOre > InizioMensa) then
      Result:=False;
  end;

  if not Result then
  begin
    if InizioMensa < FineMensa then
      PeriodoFruizione:=Format('%s-%s / %s-%s',[R180MinutiOre(E + Flex),R180MinutiOre(InizioMensa),R180MinutiOre(FineMensa),R180MinutiOre(U)])
    else
      PeriodoFruizione:=Format('%s-%s',[R180MinutiOre(E + Flex),R180MinutiOre(U)]);
  end;
end;

procedure TR502ProDtM1.Conteggi(FChiamante:String; Progressivo:LongInt; Data:TDateTime);
{Verifica se e' cambiato il progressivo e lancia i conteggi
Corrisponde alla routine 'inizio' di r500.cbl}
var i,xx,yy:Integer;
    //FestivoLavorato:Boolean;
begin
  (*Per gestire lo scostamento su causali a cavallo di mezzanotte,
  si tiene memoria di quello del giorno precedente, altrimenti si resetta a False*)
  if (Progressivo <> ProgrCon) or (Data <> DataCon + 1) then
    ScostCausEffettuato:=False;
  ProgrCon:=Progressivo;
  Chiamante:=FChiamante;
  DataCon:=Data;
  datacon_sv:=datacon;
  f03_com_sv:=f03_com;
  //Permette di aprire gli archivi senza eseguire i conteggi
  if Chiamante = 'APERTURA' then
  begin
    R500Inizio;
    exit;
  end;
  //Verifica se occorre calcolare fino al giorno seguente
  if Copy(f03_com_sv,20,1) = '+' then
    f03_com:=Copy(f03_com_sv,11,9);
  if Copy(f03_com,1,5) = 'ALLE*' then
  begin
    datacon:=datacon + 1;
    //Chiamata al conteggio per il giorno dopo
    R500inizio;//x000-conteggio;
    f03_com:='';
    if blocca = 0 then
    //Salvataggio dati del giorno dopo
    begin
      totlav_sv:=totlav;
      CoperturaCarenza_sv:=CoperturaCarenza;
      minlavesc_sv:=minlavesc;
      minlavfes_sv:=minlavfes;
      indnotmin_sv:=indnotmin;
      n_rieppres_sv:=n_rieppres;
      n_riepasse_sv:=n_riepasse;
      n_timbrcon_sv:=n_timbrcon;
      for i:=1 to n_rieppres do
      begin
        triepgiuspres_sv[i]:=triepgiuspres[i];
        SetLength(triepgiuspres_sv[i].CoppiaEU,Length(triepgiuspres[i].CoppiaEU));
        for xx:=0 to High(triepgiuspres[i].CoppiaEU) do
          triepgiuspres_sv[i].CoppiaEU[xx]:=triepgiuspres[i].CoppiaEU[xx];
      end;
      for i:=1 to n_fasce do
        tminlav_sv[i]:=tminlav[i];
      for i:=1 to 20 do
      begin
        triepgiusasse_sv[i]:=triepgiusasse[i];
        triepgiusasse_sv[i].GiornoDopo:=True;
      end;
      for i:=1 to MaxTimbrature do
        ttimbraturecon_sv[i]:=ttimbraturecon[i];
    end
    else
    begin
      totlav_sv:=0;
      CoperturaCarenza_sv:=0;
      indnotmin_sv:=0;
      n_rieppres_sv:=0;
      n_riepasse_sv:=0;
      minlavesc_sv:=0;
      minlavfes_sv:=0;
      for xx:=Low(triepgiuspres_sv) to High(triepgiuspres_sv) do
      begin
        triepgiuspres_sv[xx].tcauspres:='';
        triepgiuspres_sv[xx].traggpres:='';
        triepgiuspres_sv[xx].DetPM:=0;
        triepgiuspres_sv[xx].minpres0024:=0;
        SetLength(triepgiuspres_sv[xx].CoppiaEU,0);
        for yy:=1 to MaxFasceGio do
          triepgiuspres_sv[xx].tminpres[yy]:=0;
      end;
      for xx:=Low(triepgiusasse_sv) to High(triepgiusasse_sv) do
      begin
        triepgiusasse_sv[xx].tcausasse:='';
        triepgiusasse_sv[xx].tfiniretr:=0;
        triepgiusasse_sv[xx].tggasse:=0;
        triepgiusasse_sv[xx].thhmmasse:=0;
        triepgiusasse_sv[xx].tmezggasse:=0;
        triepgiusasse_sv[xx].tminasse:=0;
        triepgiusasse_sv[xx].tminresasse:=0;
        triepgiusasse_sv[xx].tminvalasse:=0;
        triepgiusasse_sv[xx].tminvalcompasse:=0;
        triepgiusasse_sv[xx].tminfruizasse:=0;
        triepgiusasse_sv[xx].tminfruitoPaghe:=0;
        triepgiusasse_sv[xx].tminresoPaghe:=0;
        triepgiusasse_sv[xx].traggasse:='';
        triepgiusasse_sv[xx].tumisurasse:='';
        triepgiusasse_sv[xx].ttipofruiz:='';
        triepgiusasse_sv[xx].GiornoDopo:=False;
      end;
      n_timbrcon_sv:=0;
      for xx:=Low(ttimbraturecon_sv) to High(ttimbraturecon_sv) do
      begin
        ttimbraturecon_sv[xx].oralegsol:=False;
        ttimbraturecon_sv[xx].tinclcaus:='';
        ttimbraturecon_sv[xx].tminutic_e:=0;
        ttimbraturecon_sv[xx].tminutic_u:=0;
        ttimbraturecon_sv[xx].tpuntatore:=0;
        ttimbraturecon_sv[xx].traggcaus:='';
        ttimbraturecon_sv[xx].ttipofascia:=0;
        ttimbraturecon_sv[xx].trilev_e:='';
        ttimbraturecon_sv[xx].trilev_u:='';
      end;
      for xx:=Low(tminlav_sv) to High(tminlav_sv) do
        tminlav_sv[xx]:=0;
    end;
  end;
  //Chiamata al conteggio per la data da conteggiare
  if Copy(f03_com_sv,20,1) = '+' then
    f03_com:=Copy(f03_com_sv,1,10);
  datacon:=datacon_sv;
  R500Inizio;//x000_conteggio;
  for i:=1 to n_timbrcon do
    ttimbraturecon[i].ggsucc:=False;
  if (blocca = 0) and
     ((Copy(f03_com_sv,1,5) = 'ALLE*') or (Copy(f03_com_sv,20,1) = '+')) then
  //Cumulo con dati del giorno dopo
  begin
    inc(totlav,totlav_sv);
    //inc(scost,totlav_sv);
    inc(CoperturaCarenza,CoperturaCarenza_sv);
    inc(minlavesc,minlavesc_sv);
    inc(minlavfes,minlavfes_sv);
    inc(indnotmin,indnotmin_sv);
    x810_cumulopres;
    x811_cumuloasse;
    for i:=1 to n_timbrcon_sv do
    begin
      inc(n_timbrcon);
      ttimbraturecon[n_timbrcon]:=ttimbraturecon_sv[i];
      ttimbraturecon[n_timbrcon].ggsucc:=True;
    end;
    for i:=1 to n_fasce do
      inc(tminlav[i],tminlav_sv[i]);
  end;
end;

procedure TR502ProDtM1.x810_cumulopres;
{Cumulo giustificativi presenza}
var nf,xx,i,j:Integer;
begin
  for i:=1 to n_rieppres_sv do
  begin
    j:=0;
    repeat
      inc(j);
    until (j > n_rieppres) or (triepgiuspres[j].tcauspres = triepgiuspres_sv[i].tcauspres);
    if j > n_rieppres then
    begin
      inc(n_rieppres);
      j:=n_rieppres;
      triepgiuspres[j].tcauspres:=triepgiuspres_sv[i].tcauspres;
      triepgiuspres[j].traggpres:=triepgiuspres_sv[i].traggpres;
      triepgiuspres[j].DetPM:=triepgiuspres_sv[i].DetPM;
      triepgiuspres[j].minpres0024:=triepgiuspres_sv[i].minpres0024;
      for xx:=1 to MaxFasceGio do triepgiuspres[j].tminpres[xx]:=0;
    end;
    for nf:=1 to n_fasce do
      inc(triepgiuspres[j].tminpres[nf],triepgiuspres_sv[i].tminpres[nf]);
    for xx:=0 to High(triepgiuspres_sv[i].CoppiaEU) do
    begin
      nf:=Length(triepgiuspres[j].CoppiaEU);
      SetLength(triepgiuspres[i].CoppiaEU,nf + 1);
      triepgiuspres[i].CoppiaEU[nf].Tag:=triepgiuspres_sv[i].CoppiaEU[xx].Tag;
      triepgiuspres[i].CoppiaEU[nf].e:=triepgiuspres_sv[i].CoppiaEU[xx].e + 1440;
      triepgiuspres[i].CoppiaEU[nf].u:=triepgiuspres_sv[i].CoppiaEU[xx].u + 1440;
    end;
  end;
end;

procedure TR502ProDtM1.x811_cumuloasse;
{Cumulo giustificativi assenza}
var i:Integer;
begin
  for i:=1 to n_riepasse_sv do
  begin
    inc(n_riepasse);
    triepgiusasse[n_riepasse]:=triepgiusasse_sv[i];
  end;
end;

function TR502ProDtM1.CausPresAbilitato(caus:String):Boolean;
begin
  if caus = '' then
    Result:=False
  else
    Result:=Pos(',' + ValStrT275[caus,'CODRAGGR'] + ',',',' + Q430.FieldByName('AbPresenza1').AsString + ',') > 0;
end;

function TR502ProDtM1.GetValNumT020(Campo:String):Integer;
begin
  Result:=-1;
  if cdsT020.FindField(Campo) = nil then
    exit;
  if cdsT020.FieldByName(Campo) is TDateTimeField then
    Result:=R180OreMinuti(cdsT020.FieldByName(Campo).AsDateTime)
  else if cdsT020.FieldByName(Campo) is TStringField then
    Result:=R180OreMinutiExt(cdsT020.FieldByName(Campo).AsString)
  else if (cdsT020.FieldByName(Campo) is TIntegerField) or (cdsT020.FieldByName(Campo) is TFloatField) then
    Result:=cdsT020.FieldByName(Campo).AsInteger;
end;

function TR502ProDtM1.GetFasciaT021(TipoFascia:String; Indice:Integer):Boolean;
var x:Integer;
begin
  Result:=False;
  if not cdsT021.Active then
    exit;
  cdsT021.First;
  x:=0;
  while not cdsT021.Eof do
  begin
    if cdsT021.FieldByName('TIPO_FASCIA').AsString = TipoFascia then
    begin
      inc(x);
      if x = Indice then
      begin
        Result:=True;
        Break;
      end;
    end;
    cdsT021.Next;
  end;
end;

function TR502ProDtM1.GetValNumT021(Campo,TipoFascia:String; Indice:Integer):Integer;
begin
  Result:=0;
  if cdsT021.FindField(Campo) = nil then
  begin
    Result:=-1;
    exit;
  end;
  if (Indice = -1) or GetFasciaT021(TipoFascia,Indice) then
  begin
    if cdsT021.FieldByName(Campo) is TDateTimeField then
      Result:=R180OreMinuti(cdsT021.FieldByName(Campo).AsDateTime)
    else if cdsT021.FieldByName(Campo) is TStringField then
      Result:=R180OreMinutiExt(cdsT021.FieldByName(Campo).AsString)
    else if (cdsT021.FieldByName(Campo) is TIntegerField) or (cdsT021.FieldByName(Campo) is TFloatField) then
      Result:=cdsT021.FieldByName(Campo).AsInteger;
  end;
  if XParam[XP_CRV_ALLARGA_PMT] and (TipoFascia = TF_PM_TIMBRATA) then
  begin
    if Campo = 'ENTRATAMM' then
      Result:=Min(Result,CRV_PMT_MNGiustE);
    if Campo = 'MMANTICIPO' then
      Result:=Min(Result,CRV_PMT_MNGiustE);
    if Campo = 'USCITAMM' then
      Result:=Max(Result,CRV_PMT_MNGiustU);
    if Campo = 'MMRITARDO' then
      Result:=Max(Result,CRV_PMT_MNGiustU);
  end;

  //Correzione punti nominali in caso di Causale di Vestizione abilitata / non abilitata (COMO_HSANNA)
  if TipoFascia = TF_PUNTI_NOMINALI then
  begin
    //Gestione punti nominali di entrata
    if  R180In(Campo,['ENTRATA','ENTRATAMM'])
    and (cdsT020.FieldByName('CAUSALE_INIZIOORARIO').AsString <> '')
    and (ValNumT020['MINUTICAUS_INIZIOORARIO'] > 0)
    and ((TipoOrario <> 'E') or (cdsT020.FieldByName('TURNI_INIZIOORARIO').AsString.Trim = '') or R180InConcat(cdsT021.FieldByName('ID_TURNO').AsString,cdsT020.FieldByName('TURNI_INIZIOORARIO').AsString))
    and not CausPresAbilitato(cdsT020.FieldByName('CAUSALE_INIZIOORARIO').AsString)
    then
    begin
      Result:=Result + ValNumT020['MINUTICAUS_INIZIOORARIO'];
      if (Result > 1440) and not NotteSuEntrata then
        Result:=Result - ValNumT020['MINUTICAUS_INIZIOORARIO']
    end;

    //Gestione punti nominali di uscita
    if  R180In(Campo,['USCITA','USCITAMM'])
    and (cdsT020.FieldByName('CAUSALE_FINEORARIO').AsString <> '')
    and (ValNumT020['MINUTICAUS_FINEORARIO'] > 0)
    and ((TipoOrario <> 'E') or (cdsT020.FieldByName('TURNI_FINEORARIO').AsString.Trim = '') or R180InConcat(cdsT021.FieldByName('ID_TURNO').AsString,cdsT020.FieldByName('TURNI_FINEORARIO').AsString))
    and not CausPresAbilitato(cdsT020.FieldByName('CAUSALE_FINEORARIO').AsString)
    then
    begin
      Result:=Result - ValNumT020['MINUTICAUS_FINEORARIO'];
      if Result < 0 then
        Result:=Result + ValNumT020['MINUTICAUS_FINEORARIO'];
    end;
  end;
end;

function TR502ProDtM1.GetValStrT021(Campo,TipoFascia:String; Indice:Integer):String;
begin
  Result:='';
  if cdsT021.FindField(Campo) = nil then
  begin
    exit;
  end;
  if GetFasciaT021(TipoFascia,Indice) then
    Result:=cdsT021.FieldByName(Campo).AsString;
end;

function TR502ProDtM1.GetValStrT025(Campo:String; Default:String = ''):String;
begin
  Result:=Default;
  selT025.Filter:='(DATADECORRENZA <= ' + FloatToStr(DataCon) + ') and (DATAFINE >= ' + FloatToStr(DataCon) + ')';
  selT025.Filtered:=True;
  if (selT025.RecordCount > 0) and (selT025.FindField(Campo) <> nil) then
    Result:=Trim(selT025.FieldByName(Campo).AsString);
end;

function TR502ProDtM1.GetValStrT265(Codice,Dato:String):String;
begin
  Result:='';
  z964_leggicaus(Codice);
  if (s_trovato = 'no') or (parcaus.l29_1paramet <> 'A') then
    exit;
  if UpperCase(Dato) = 'CODRAGGR' then
    Result:=parcaus.l29_2Paramet
  else if UpperCase(Dato) = 'CODINTERNO' then
    Result:=parcaus.l29_Ragg
  else if UpperCase(Dato) = 'GNONLAV' then
    Result:=parcaus.l29_3Paramet
  else if UpperCase(Dato) = 'INFLUCONT' then
    Result:=parcaus.l29_4Paramet
  (*else if UpperCase(Dato) = 'VALORGIOR' then
    Result:=parcaus.l29_5Paramet*)
  else if UpperCase(Dato) = 'INFLUENZAPO' then
    Result:=parcaus.l29_6Paramet
  else if UpperCase(Dato) = 'STAMPA' then
    Result:=parcaus.l29_7Paramet
  (*else if UpperCase(Dato) = 'HMASSENZA' then
    Result:=parcaus.l29_8Paramet*)
  else if UpperCase(Dato) = 'ESCLUSIONE' then
    Result:=parcaus.l29_10Paramet
  (*else if UpperCase(Dato) = 'INDPRES' then
    Result:=parcaus.l29_11Paramet*)
  else if UpperCase(Dato) = 'ECCEDLIQ' then
    Result:=parcaus.l29_12Paramet
  else if UpperCase(Dato) = 'UMISURA' then
    Result:=parcaus.l29_13Paramet
  else if UpperCase(Dato) = 'VALSETIMB' then
    Result:=parcaus.l29_15Paramet
  else if UpperCase(Dato) = 'TIPOCUMULO' then
    Result:=parcaus.l29_16Paramet
  else if UpperCase(Dato) = 'TIPORECUPERO' then
    Result:=parcaus.l29_17Paramet
  else if UpperCase(Dato) = 'FLESSIBILITA_ORARIO' then
    Result:=parcaus.l29_18Paramet
  else if UpperCase(Dato) = 'PERC_INAIL' then
    Result:=parcaus.l29_19Paramet
  else if UpperCase(Dato) = 'FRUIZ_ARR' then
    Result:=parcaus.l29_20Paramet
  else if UpperCase(Dato) = 'FRUIZCOMPETENZE_ARR' then
    Result:=parcaus.l29_21Paramet
  (*
  else if UpperCase(Dato) = 'INTERSEZIONE_TIMBRATURE' then
    Result:=parcaus.l29_22Paramet
  *)
  (*else if UpperCase(Dato) = 'ABBATTE_STRIND' then
    Result:=parcaus.l29_23Paramet*)
  (*
  else if UpperCase(Dato) = 'TIMB_PM' then
    Result:=parcaus.l29_24Paramet
  *)
  else if UpperCase(Dato) = 'CUMULO_TIPO_ORE' then
    Result:=parcaus.l29_25Paramet
  (*
  else if UpperCase(Dato) = 'TIMB_PM_DETRAZ' then
    Result:=parcaus.l29_26Paramet
  *)
  else if UpperCase(Dato) = 'FRUIZ_MIN' then
    Result:=parcaus.l29_27Paramet
  else if UpperCase(Dato) = 'FRUIZ_MAX' then
    Result:=parcaus.l29_28Paramet
  else if UpperCase(Dato) = 'COPRE_FASCIA_OBB' then
    Result:=parcaus.l29_29Paramet
  else if UpperCase(Dato) = 'ITER_ECCGG' then
    Result:=parcaus.l29_30Paramet
  //Lettura dal client dataset cdsT265
  else if UpperCase(Dato) = 'PARTTIME' then
    Result:=lstT265.ValoreCorrente[Dato]
  //Lettura dal client dataset storicizzato cdsT230
  else if UpperCase(Dato) = 'HMASSENZA' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'HMASSENZA_PROPPT' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'VALORGIOR' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'VALORGIOR_COMP' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'VALORGIOR_ORE' then
    Result:=R180OreMinuti(lstT230.ValoreCorrente[Dato]).ToString
  else if UpperCase(Dato) = 'VALORGIOR_ORECOMP' then
    Result:=R180OreMinuti(lstT230.ValoreCorrente[Dato]).ToString
  else if UpperCase(Dato) = 'VALORGIOR_ORE_PROPPT' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'SCARICOPAGHE_FRUIZ_GG' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'SCARICOPAGHE_FRUIZ_ORE' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'CHECK_SOLOCOMPETENZE' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'TIMB_PM' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'TIMB_PM_H' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'TIMB_PM_DETRAZ' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'GIUST_DAA_RECUP_FLEX' then //MESSINA_UNIVERSITA
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'ABBATTE_STRIND' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'INTERSEZIONE_TIMBRATURE' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'CONTEGGIO_TIMB_INTERNA' then //MESSINA_UNIVERSITA
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'SCELTA_ORARIO' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'INDPRES' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'INDPRES_FESTIVO' then
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'INDTURNO' then  //FIRENZE_COMUNE
    Result:=lstT230.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'FRUIZ_INTERNA_PN' then //MESSINA_UNIVERSITA
    Result:=lstT230.ValoreCorrente[Dato]
  ;
end;

function TR502ProDtM1.GetValStrT275(Codice,Dato:String):String;
begin
  Result:='';
  z964_leggicaus(Codice);
  if (s_trovato = 'no') or (parcaus.l29_1paramet <> 'B') then
    exit;
  if UpperCase(Dato) = 'CODRAGGR' then
    Result:=parcaus.l29_2Paramet
  else if UpperCase(Dato) = 'CODINTERNO' then
    Result:=parcaus.l29_Ragg
  else if UpperCase(Dato) = 'TIPOCONTEGGIO' then
    Result:=parcaus.l29_3Paramet
  else if UpperCase(Dato) = 'RIPFASCE' then
    Result:=parcaus.l29_4Paramet
  else if UpperCase(Dato) = 'ORENORMALI' then
    Result:=parcaus.l29_5Paramet
  else if UpperCase(Dato) = 'ARROTONDAMENTO' then
    Result:=parcaus.l29_6Paramet
  else if UpperCase(Dato) = 'STAMPE' then
    Result:=parcaus.l29_7Paramet
  else if UpperCase(Dato) = 'SCOSTAMENTO' then
    Result:=parcaus.l29_8Paramet
  else if UpperCase(Dato) = 'TIPO_NONAUTORIZZATE' then
    Result:=parcaus.l29_9Paramet
  else if UpperCase(Dato) = 'TIPO_MINMINIMI' then
    Result:=parcaus.l29_10Paramet
  (*
  else if UpperCase(Dato) = 'MATURAMENSA' then
    Result:=parcaus.l29_11Paramet
  *)
  else if UpperCase(Dato) = 'LFSCAVMEZ' then
    Result:=parcaus.l29_12Paramet
  else if UpperCase(Dato) = 'MINMINUTI' then
    Result:=parcaus.l29_13Paramet
  else if UpperCase(Dato) = 'MAXMINUTI' then
    Result:=parcaus.l29_14Paramet
  else if UpperCase(Dato) = 'PIANIFREP' then
    Result:=parcaus.l29_15Paramet
  else if UpperCase(Dato) = 'SOGLIA_FASCE_OBBLFAC' then
    Result:=parcaus.l29_16Paramet
  else if UpperCase(Dato) = 'ESCLUSIONE_FASCIA_OBB' then
    Result:=parcaus.l29_17Paramet
  else if UpperCase(Dato) = 'FLESSIBILITA_ORARIO' then
    Result:=parcaus.l29_18Paramet
  else if UpperCase(Dato) = 'LIMITE_DEBITOGG' then
    Result:=parcaus.l29_19Paramet
  else if UpperCase(Dato) = 'NO_ECCEDENZA_IN_FASCIA' then
    Result:=parcaus.l29_20Paramet
  else if UpperCase(Dato) = 'LIQUIDABILE' then
    Result:=parcaus.l29_21Paramet
  //else if UpperCase(Dato) = 'RIPLIQ' then
  else if UpperCase(Dato) = 'SEMPRE_APPOGGIATA' then
    Result:=parcaus.l29_22Paramet
  else if UpperCase(Dato) = 'TIPO_U_NONAUTORIZZATE' then
    Result:=parcaus.l29_23Paramet
  else if UpperCase(Dato) = 'GETTONE_TIPO_ORESUP' then
    Result:=parcaus.l29_24Paramet
  else if UpperCase(Dato) = 'GETTONE_ORE' then
    Result:=parcaus.l29_25Paramet
  else if UpperCase(Dato) = 'GETTONE_DALLE' then
    Result:=parcaus.l29_33Paramet
  else if UpperCase(Dato) = 'GETTONE_ALLE' then
    Result:=parcaus.l29_34Paramet
  else if UpperCase(Dato) = 'GETTONE_SPEZZONI' then
    Result:=parcaus.l29_26Paramet
  else if UpperCase(Dato) = 'GETTONE_TIPO_OREINF' then
    Result:=parcaus.l29_27Paramet
  else if UpperCase(Dato) = 'STACCO_MINIMO_SCOST' then
    Result:=parcaus.l29_28Paramet
  else if UpperCase(Dato) = 'SCOST_PUNTI_NOMINALI' then
    Result:=parcaus.l29_29Paramet
  else if UpperCase(Dato) = 'SENZA_FLESSIBILITA' then
    Result:=parcaus.l29_30Paramet
  else if UpperCase(Dato) = 'CAUS_FUORI_TURNO' then
    Result:=parcaus.l29_31Paramet
  else if UpperCase(Dato) = 'PERC_INAIL' then
    Result:=parcaus.l29_32Paramet
  (*
  else if UpperCase(Dato) = 'TIMB_PM' then
    Result:=parcaus.l29_35Paramet
  *)
  else if UpperCase(Dato) = 'INCLUDI_INDTURNO' then
    Result:=parcaus.l29_36Paramet
  else if UpperCase(Dato) = 'ARROT_RIEPGG' then
    Result:=parcaus.l29_37Paramet
  else if UpperCase(Dato) = 'ARROT_RIEPGG_ORENORM' then
    Result:=parcaus.l29_38Paramet
  else if UpperCase(Dato) = 'ARROT_RIEPGG_FASCE' then
    Result:=parcaus.l29_39Paramet
  else if UpperCase(Dato) = 'E_IN_FLESSIBILITA' then
    Result:=parcaus.l29_40Paramet
  (*
  else if UpperCase(Dato) = 'AUTOCOMPLETAMENTO_UE' then     //TORINO_COMUNE
    Result:=parcaus.l29_41Paramet
  *)
  else if UpperCase(Dato) = 'TIPO_RICHIESTA_WEB' then       //GENOVA_HSMARTINO
    Result:=parcaus.l29_42Paramet
  else if UpperCase(Dato) = 'CONSIDERA_SCELTA_ORARIO' then  //EMPOLI_ASL11
    Result:=parcaus.l29_43Paramet
  else if UpperCase(Dato) = 'FLEX_TIMBR_CAUS' then          //FIRENZE_COMUNE
    Result:=parcaus.l29_44Paramet
  else if UpperCase(Dato) = 'FORZA_NOTTE_SPEZZATA' then     //AOSTA_ASL
    Result:=parcaus.l29_45Paramet
  else if UpperCase(Dato) = 'CAUSALIZZA_TIMB_INTERSECANTI' then     //ANCONA_ALM
    Result:=parcaus.l29_46Paramet
  (*
  else if UpperCase(Dato) = 'TIMB_PM_DETRAZ' then     //EMPOLI_ASL12
    Result:=parcaus.l29_47Paramet
  *)
  else if UpperCase(Dato) = 'GIUST_DAA_TIMB' then     //AOSTA_REGIONE
    Result:=parcaus.l29_48Paramet
  (*
  else if UpperCase(Dato) = 'INTERSEZIONE_TIMBRATURE' then  //AOSTA_REGIONE
    Result:=parcaus.l29_49Paramet
  *)
  else if UpperCase(Dato) = 'NO_ECCED_IN_FASCIA_CONS_ASS' then  //AOSTA_REGIONE
    Result:=parcaus.l29_50Paramet
  else if UpperCase(Dato) = 'FORZA_CAUSECCEDENZA' then  //PARMA_COMUNE
    Result:=parcaus.l29_52Paramet
  (*
  else if UpperCase(Dato) = 'TIMB_PM_H' then
    Result:=parcaus.l29_53Paramet
  *)
  //Dati storicizzati su T235
  else if UpperCase(Dato) = 'CAUSCOMP_DEBITOGG' then  //AOSTA_REGIONE
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'DETRAZ_RIEPPR_SEQ' then  //MESSINA_UNIVERSITA
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'GIUST_DAA_RECUP_FLEX' then //MESSINA_UNIVERSITA
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'CONTEGGIO_TIMB_INTERNA' then
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'MATURAMENSA' then
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'TIMB_PM' then
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'TIMB_PM_H' then
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'TIMB_PM_DETRAZ' then //EMPOLI_ASL12
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'INTERSEZIONE_TIMBRATURE' then  //AOSTA_REGIONE
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'AUTOCOMPLETAMENTO_UE' then     //TORINO_COMUNE
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'SEPARA_CAUSALI_UE' then     //PALERMO_UNIVERSITA
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'SPEZZ_STRAORD' then     //MESSINA_UNIVERSITA
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'RICONOSCIMENTO_TURNO' then //TORINO_CDS, MONCALIERI_ASLTO5
    Result:=lstT235.ValoreCorrente[Dato]
  else if UpperCase(Dato) = 'CONDIZIONE_ABILITAZIONE' then // AOSTA_ALS
    Result:=lstT235.ValoreCorrente[Dato]
  ;
end;

function TR502ProDtM1.GetPausaMensa:String;
begin
  if cdsT020.Active then
    Result:=cdsT020.FieldByName('TIPOMENSA').AsString
  else
    Result:='';
end;

function TR502ProDtM1.GetTipoOrario:String;
begin
  if cdsT020.Active then
    Result:=cdsT020.FieldByName('TIPOORA').AsString
  else
    Result:='';
end;

function TR502ProDtM1.GetPeriodoLavorativo:String;
begin
  if cdsT020.Active then
    Result:=cdsT020.FieldByName('PERLAV').AsString
  else
    Result:='';
end;

function TR502ProDtM1.GetValenzaGGAss: Real;
begin
  Result:=1;
  if n_timbrnom < 1 then
    exit;

  if (TipoOrario = 'E') and (pianif = 'si') and (c_turni1 > 0) and (cdsT020.FieldByName('FORZA_TURNOPIANIFICATO').AsString = 'S') then
    Result:=StrToFloat(ValStrT021['VALENZA_GGASS',TF_PUNTI_NOMINALI,c_turni1])
  else
    Result:=StrToFloat(ValStrT021['VALENZA_GGASS',TF_PUNTI_NOMINALI,1]);

  if Result = -1 then
    Result:=1;
end;

function TR502ProDtM1.GetEntrataNominale(i:Byte):Integer;
begin
  Result:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,i];
end;

function TR502ProDtM1.GetUscitaNominale(i:Byte):Integer;
begin
  Result:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,i];
end;

function TR502ProDtM1.GetEntrataNominaleNetta(i,ie:Byte):Integer;
begin
  Result:=ttimbraturenom[i].tminutin_e;
  if (cdsT020.FieldByName('CAUSALE_INIZIOORARIO').AsString <> '') and (ValNumT020['MINUTICAUS_INIZIOORARIO'] > 0)
  and ((TipoOrario <> 'E') or (cdsT020.FieldByName('TURNI_FINEORARIO').AsString.Trim = '') or R180InConcat(ie.ToString,cdsT020.FieldByName('TURNI_FINEORARIO').AsString))
  then
    Result:=Result + ValNumT020['MINUTICAUS_INIZIOORARIO'];
end;

function TR502ProDtM1.GetUscitaNominaleNetta(i,iu:Byte):Integer;
begin
  Result:=ttimbraturenom[i].tminutin_u;
  if (cdsT020.FieldByName('CAUSALE_FINEORARIO').AsString <> '') and (ValNumT020['MINUTICAUS_FINEORARIO'] > 0)
  and ((TipoOrario <> 'E') or (cdsT020.FieldByName('TURNI_FINEORARIO').AsString.Trim = '') or R180InConcat(iu.ToString,cdsT020.FieldByName('TURNI_FINEORARIO').AsString))
  then
    Result:=Result - ValNumT020['MINUTICAUS_FINEORARIO'];
end;

function TR502ProDtM1.GetEntrataTeorica:Integer;
var i:Integer;
begin
  Result:=-1;
  if TipoOrario = '' then
    exit;

  //Messina_Universita
  if (TipoOrario = 'A') and XParam[XP_Z088_INTERVALLO_FLEX] then
  begin
    if (Result = -1) and (n_timbrnom > 0) then
      Result:=ttimbraturenom[1].tminutin_e;
    exit;
  end;

  if TipoOrario = 'E' then
  begin
    for i:=1 to n_timbrdip do
      if ttimbraturedip[i].tpuntnomin > 0 then
      begin
        Result:=ttimbraturenom[ttimbraturedip[i].tpuntnomin].tminutin_e + ttimbraturenom[ttimbraturedip[i].tpuntnomin].Flex - ttimbraturenom[ttimbraturedip[i].tpuntnomin].FlexPM;
        Break;
      end;
  end;
  if (Result = -1) and (n_timbrnom > 0) then
    Result:=ttimbraturenom[1].tminutin_e + ttimbraturenom[1].Flex - ttimbraturenom[1].FlexPM;
end;

function TR502ProDtM1.GetUscitaTeorica:Integer;
var i:Integer;
begin
  Result:=-1;
  if TipoOrario = '' then
    exit;
  if TipoOrario = 'E' then
  begin
    for i:=1 to n_timbrdip do
      if ttimbraturedip[i].tpuntnomin > 0 then
        Result:=max(Result,ttimbraturenom[ttimbraturedip[i].tpuntnomin].tminutin_u);
  end;
  if (Result = -1) and (n_timbrnom > 0) then
    Result:=ttimbraturenom[n_timbrnom].tminutin_u;
end;

function TR502ProDtM1.GetEsisteGiustificativo(TipoGiust, Parametro, Valore: String): Boolean;
var g:Integer;
begin
  Result:=False;

  if R180In(TipoGiust,['*','D']) then
  begin
    for g:=1 to n_giusdaa do
    begin
      if ValStrT265[tgius_dallealle[g].tcausdaa,Parametro] = Valore then
      begin
        Result:=True;
        Break;
      end;
    end;
  end;
  if Result then exit;

  if R180In(TipoGiust,['*','N']) then
  begin
    for g:=1 to n_giusore do
    begin
      if ValStrT265[tgius_min[g].tcausore,Parametro] = Valore then
      begin
        Result:=True;
        Break;
      end;
    end;
  end;

  if R180In(TipoGiust,['*','G']) then
  begin
    for g:=1 to n_giusgga do
    begin
      if ValStrT265[tgius_ggass[g].tcausggass,Parametro] = Valore then
      begin
        Result:=True;
        Break;
      end;
    end;
  end;

  if R180In(TipoGiust,['*','M']) then
  begin
    for g:=1 to n_giusmga do
    begin
      if ValStrT265[tgius_mgass[g].tcausmgass,Parametro] = Valore then
      begin
        Result:=True;
        Break;
      end;
    end;
  end;
end;

function TR502ProDtM1.GetEsisteTagTimbratura(Value: String): Boolean;
var i:Integer;
begin
  Result:=False;
  for i:=1 to n_timbrdip do
    if ttimbraturedip[i].tag = Value then
    begin
      Result:=True;
      Break;
    end;
end;

function TR502ProDtM1.GetIndPresAssenza:String;
var i:Integer;
begin
  //Considero l'indennità da assenza solo se è presente un Riposo o Riposo compensativo
  Result:='no';
  if indpresdaass = 'si' then
    for i:=1 to n_riepasse do
      if (triepgiusasse[i].traggasse = traggrcausas[8].C) or
         (triepgiusasse[i].traggasse = traggrcausas[5].C) then
      begin
        Result:='si';
        Break;
      end;
end;

function TR502ProDtM1.GetmmMinDetrazMensa:Integer;
begin
  Result:=ValNumT021['OREMINIME',TF_PM_AUTO,1];
end;

function TR502ProDtM1.GetInizioMensa:Integer;
begin
  if (PeriodoLavorativo = 'S') and (TipoOrario <> 'C') then
    Result:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,1]
  else
    Result:=ValNumT021['ENTRATAMM',TF_PM_TIMBRATA,1];
end;

function TR502ProDtM1.GetFineMensa:Integer;
begin
  if (PeriodoLavorativo = 'S') and (TipoOrario <> 'C') then
    Result:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,2]
  else
    Result:=ValNumT021['USCITAMM',TF_PM_TIMBRATA,1];
end;

function TR502ProDtM1.GetFlessibilitaPM: Integer;
var i:Integer;
begin
  Result:=0;
  for i:=1 to n_timbrnom do
    inc(Result,ttimbraturenom[i].FlexPM);
end;

function TR502ProDtM1.GetFlessibilitaRit: Integer;
begin
  Result:=tritflex[1] + tritflex[2];
end;

function TR502ProDtM1.GetFlessibilitaTot: Integer;
var i:Integer;
begin
  Result:=0;
  for i:=1 to n_timbrnom do
    inc(Result,ttimbraturenom[i].Flex);
end;

function TR502ProDtM1.GetMaxFlex:Integer;
var i:Integer;
begin
  Result:=0;
  for i:=1 to n_timbrdip do
    if ttimbraturedip[i].tpuntnomin > 0 then
      if ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntre > 0 then
        Result:=max(Result,ValNumT021['MMFLEX',TF_PUNTI_NOMINALI,ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntre])
      else if ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntru > 0 then
        Result:=max(Result,ValNumT021['MMFLEX',TF_PUNTI_NOMINALI,ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntru]);
end;

function TR502ProDtM1.GetRilevatore:String;
var i:Integer;
begin
  Result:='';
  for i:=1 to n_timbrdip do
  begin
    if ttimbraturedip[i].trilev_e <> '' then
      if Result = '' then
        Result:=ttimbraturedip[i].trilev_e
      else if Result <> ttimbraturedip[i].trilev_e then
        Result:='*';
    if ttimbraturedip[i].trilev_u <> '' then
      if Result = '' then
        Result:=ttimbraturedip[i].trilev_u
      else if Result <> ttimbraturedip[i].trilev_u then
        Result:='*';
  end;
end;

function TR502ProDtM1.GetTimbratureDiMensa:String;
begin
  Result:='';
  with Q370 do
    if SearchRecord('DATA',datacon,[srFromBeginning]) then
      repeat
        if Result <> '' then
          Result:=Result + ' ';
        Result:=Result + FormatDateTime('hh.nn',FieldByname('ORA').AsDateTime);
      until not SearchRecord('DATA',datacon,[]);
end;

function TR502ProDtM1.GetOreMensaMaturate:Integer;
var i,j:Integer;
begin
  Result:=0;
  for i:=1 to n_fasce do
    inc(Result,tminlav[i]);
  for i:=1 to n_rieppres do
  begin
    if ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A' then
    begin
      if ValStrT275[triepgiuspres[i].tcauspres,'MATURAMENSA'] = 'S' then
        for j:=1 to n_fasce do
          inc(Result,triepgiuspres[i].tminpres[j]);
    end
    else
    begin
      if ValStrT275[triepgiuspres[i].tcauspres,'MATURAMENSA'] = 'N' then
        for j:=1 to n_fasce do
          dec(Result,triepgiuspres[i].tminpres[j]);
    end;
  end;
  Result:=Max(0,Result + paumendet - minassenze);
end;

function TR502ProDtM1.GetStaccoPausaMensa:Integer;
var i:Integer;
begin
  Result:=0;
  for i:=0 to High(TimbratureMensa) do
    inc(Result,TimbratureMensa[i].F - TimbratureMensa[i].I);
end;

function TR502ProDtM1.GetPianGGIndPresenza:String;
begin
  Result:=VarToStr(Q080.Lookup('DATA',DataCon,'INDPRESENZA'));
end;

function TR502ProDtM1.GetPianGGLivello:String;
begin
  Result:=VarToStr(Q080.Lookup('DATA',DataCon,'DATOLIBERO'));
end;

function TR502ProDtM1.GetPianRepLivello:String;
begin
  Result:=VarToStr(Q380.Lookup('DATA',DataCon,'DATOLIBERO'));
end;

function TR502ProDtM1.GetCarenzaObbNoLiq:Integer;
begin
  Result:=0;
  if (Blocca = 0) and cdsT020.Active then
    if cdsT020.FieldByName('CARENZA_OBB_NO_LIQ').AsString = 'S' then
      Result:=CarenzaObbligatoria;
end;

function TR502ProDtM1.GetOreReseTotali:Integer;
begin
  z752_lavscostgg;
  Result:=totlav;
end;

function TR502ProDtM1.GetRiepPresNonCau:Integer;
var i:Integer;
begin
  Result:=0;
  for i:=1 to n_rieppres do
    if triepgiuspres[i].tcauspres = '' then
    begin
      inc(Result,R180SommaArray(triepgiuspres[i].tminpres));
      Break;
    end;
end;

function TR502ProDtM1.GetMinLavCau(CauPres:String):Integer;
var
  i:Integer;
begin
  Result:=0;
  if CauPres <> '' then
    for i:=1 to n_rieppres do
      if (Pos(',' + triepgiuspres[i].tcauspres + ',',',' + CauPres + ',') > 0) then
        Inc(Result,RiepPresTotale[i]);
end;

function TR502ProDtM1.GetMinLavCauFasce(CauPres:String):String;
var
  FasceGiorno:t_FasceInteri;
  FasceMese:array [1..MaxFasce] of SmallInt;
  i,j,Durata: Integer;
  S1,C:String;
begin
  Result:='';
  if CauPres = '' then
    exit;

  for i:=Low(FasceGiorno) to High(FasceGiorno) do
    FasceGiorno[i]:=0;
  for i:=Low(FasceMese) to High(FasceMese) do
    FasceMese[i]:=0;

  C:='';
  for i:=1 to n_rieppres do
    if (Pos(',' + triepgiuspres[i].tcauspres + ',',',' + CauPres + ',') > 0) then
    begin
      for j:=1 to n_fasce do
        if triepgiuspres[i].tminpres[j] > 0 then
        begin
          inc(FasceGiorno[j],triepgiuspres[i].tminpres[j]);
          C:=triepgiuspres[i].tcauspres;
        end;
    end;

  if FALSE then
  BEGIN
    for i:=1 to n_fasce do
      if FasceGiorno[i] > 0 then
        Result:=Result + IfThen(Result <> '',' ') + Format('%s(%d%%)',[R180MinutiOre(FasceGiorno[i]),tfasceorarie[i].tpercfasc]);
  END
  ELSE
  BEGIN
    for i:=1 to n_fasce do
    begin
      j:=tfasceorarie[i].tposfasc;
      if j > 0 then
        inc(FasceMese[j],FasceGiorno[i]);
    end;

    for i:=Low(FasceMese) to High(FasceMese) do
    begin
      if i > 1 then
        Result:=Result + ' ';
      Result:=Result + IfThen(Fascemese[i] = 0,'     ',R180MinutiOre(FasceMese[i]));
    end;
  END;

  if C <> '' then
    Result:=Format('%-5s:%s',[C,Result.TrimRight]).Trim;
end;

function TR502ProDtM1.GetDataFamiliare(Causale:String):TDateTime;
var i:integer;
begin
  Result:=0;
  if Causale <> '' then
  begin
    i:=0;
    while (i <= High(GiustificativiDelGiorno)) and
          (GiustificativiDelGiorno[i].tcausgius <> Causale) do
      inc(i);
    if (GiustificativiDelGiorno[i].tcausgius = Causale) then
      Result:=GiustificativiDelGiorno[i].tdatanas;
  end;
end;

function TR502ProDtM1.GetDescAnomaliaBloccante: String;
var i:Integer;
begin
  Result:='';
  if Blocca in [25,26] then
  begin
    for i:=0 to lstAnomalieGG.Count - 1 do
      if lstAnomalieGG[i].Livello = 1 then
        Result:=lstAnomalieGG[i].Descrizione
  end
  else if Blocca > 0 then
    Result:=tdescanom1[Blocca].D;
end;

procedure TR502ProDtM1.PutSpezzoniNonAbilitati(TipoAbil, TipoSpez: String; Inizio, Fine: Integer);
var
  i: Integer;
begin
  // verifica parametri
  if (TipoAbil <> 'NA') and
     (TipoAbil <> 'NC') then
    raise Exception.Create(Format('R502.PutSpezzoniNonAbilitati: Tipo abilitazione %s errato',[TipoAbil]));
  if (TipoSpez <> 'FO') and
     (TipoSpez <> 'E') and
     (TipoSpez <> 'U') then
    raise Exception.Create(Format('R502.PutSpezzoniNonAbilitati: Tipo spezzone %s errato',[TipoSpez]));

  //Se lo spezzone è FO, ma in realtà è un proseguimento della notte precedente, lo categorizzo come U
  if (TipoSpez = 'FO') and NotteSuEntrata and (Inizio + 1440 = TurnoNotturnoU.U) and (Inizio = timbraturaesclusa.tminutid_u) then
  begin
    TipoSpez:='U';
  end;

  // crea nuovo elemento
  i:=Length(SpezzoniNonAbilitati);
  SetLength(SpezzoniNonAbilitati,i + 1);

  // imposta variabili elemento
  SpezzoniNonAbilitati[i].TipoAbil:=TipoAbil;
  SpezzoniNonAbilitati[i].TipoSpez:=TipoSpez;
  SpezzoniNonAbilitati[i].Inizio:=Inizio;
  SpezzoniNonAbilitati[i].Fine:=Fine;
  SpezzoniNonAbilitati[i].Durata:=Fine - Inizio;
end;

function TR502ProDtM1.GetProlungamentoInibito(TipoSpez:String = ''): Integer;
var
  i: Integer;
begin
  Result:=0;
  for i:=0 to High(SpezzoniNonAbilitati) do
    if SpezzoniNonAbilitati[i].TipoAbil = 'NA' then
      if (SpezzoniNonAbilitati[i].TipoSpez = TipoSpez) or (TipoSpez = '') then
        Result:=Result + SpezzoniNonAbilitati[i].Durata;
end;

function TR502ProDtM1.GetProlungamentoNonCausalizzato(TipoSpez:String = ''): Integer;
var
  i: Integer;
begin
  Result:=0;
  for i:=0 to High(SpezzoniNonAbilitati) do
    if SpezzoniNonAbilitati[i].TipoAbil = 'NC' then
      if (SpezzoniNonAbilitati[i].TipoSpez = TipoSpez) or (TipoSpez = '') then
        Result:=Result + SpezzoniNonAbilitati[i].Durata;
end;

(*
function TR502ProDtM1.GetProlungamentoNonCausEntrata: Integer;
begin
  Result:=GetProlungamentoNonCausalizzato('E');
end;
*)

function TR502ProDtM1.GetProlungamentoNonCausUscita: Integer;
var
  i: Integer;
begin
  Result:=0;
  for i:=0 to High(SpezzoniNonAbilitati) do
    if (SpezzoniNonAbilitati[i].TipoAbil = 'NC') and
       (SpezzoniNonAbilitati[i].TipoSpez = 'U') then
      Result:=Result + SpezzoniNonAbilitati[i].Durata;

  // considerazioni per Monza
  Result:=Max(0,Result + ScostNeg);
  if Result < ValNumT020['MinScoStr'] then
    Result:=0
  else if ValNumT020['ArrScoStr'] > 1 then
    Result:=Trunc(R180Arrotonda(Result,ValNumT020['ArrScoStr'],'D'));
end;

function TR502ProDtM1.GetEccedIterDisponibile:Integer;
(*Ore non causalizzate richiedibili tramite l'iter delle eccedenze giornaliere
  al momento si considera il caso di TORINO_CITTADELLASALUTE: ore incluse nelle normali non causalizzate + ore già destinate*)
var i,TotStr,OreCausIncluse,OreCausEscluse,OreCausStr,EccNonCaus,GiustEccGG:Integer;
begin
  Result:=0;
  OreCausIncluse:=0;
  OreCausEscluse:=0;
  OreCausStr:=0;
  TotStr:=R180SommaArray(tminstrgio);
  //Ore causalizzate
  for i:=1 to n_rieppres do
  begin
    if R180In(ValStrT275[triepgiuspres[i].tcauspres,'TIPO_RICHIESTA_WEB'],['P','R']) then
    begin
      inc(Result,R180SommaArray(triepgiuspres[i].tminpres));
      if ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A' then
        inc(OreCausIncluse,R180SommaArray(triepgiuspres[i].tminpres))
      else
        inc(OreCausEscluse,R180SommaArray(triepgiuspres[i].tminpres));
    end
    else if (triepgiuspres[i].tcauspres = '') or (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A') then
      inc(OreCausStr,R180SommaArray(triepgiuspres[i].tminpres));
  end;
  //Ore non causalizzate limitate allo scostamento positivo giornaliero
  EccNonCaus:=max(0,scost - OreCausIncluse);

  //Ore dovute a giustificativi di assenza abilitati al riconoscimento eccedenza sull'iter autorizzativo
  GiustEccGG:=0;
  for i:=1 to n_giusdaa do
  begin
    if (ValStrT265[tgius_dallealle[i].tcausdaa,'ITER_ECCGG'] <> 'S') then
      Continue;
    //Deve aumentare le ore sul cartellino
    if not (R180CarattereDef(ValStrT265[tgius_dallealle[i].tcausdaa,'INFLUCONT']) in ['A','C','H']) then
      Continue;
    inc(GiustEccGG,tgius_dallealle[i].tminutia - tgius_dallealle[i].tminutida);
  end;

  //Alberto 17/10/2017: limite all'eccedenza liquidabile e distinzione per orari senza punti nominali, che non hanno RiepPresNonCau valorizzata
  if n_timbrnom > 0 then
  begin
    //Eccedenza limitata allo straord.liquiabile
    Result:=OreCausEscluse + OreCausIncluse + min(max(0,TotStr - OreCausIncluse),(*RiepPresNonCau*)OreCausStr + GiustEccGG);
  end
  else
  begin
    //Orario senza punti nominali
    Result:=Result + EccNonCaus;
    for i:=1 to n_riepasse do
      if (ValStrT265[triepgiusasse[i].tcausasse,'ITER_ECCGG'] <> 'S') then
        dec(Result,triepgiusasse[i].tminresasse);
    Result:=max(0,Result);
    //Eccedenza limitata allo straord.liquiabile
    Result:=min(Result,TotStr);
  end;
end;

function TR502ProDtM1.GetEccedenzaIterdaAutorizzareInFasce:String;
var
  FasceGiorno:t_FasceInteri;
  FasceMese:array [1..MaxFasce] of SmallInt;
  i,j,Durata: Integer;
  S1:String;
begin
  Result:='';
  for i:=Low(FasceGiorno) to High(FasceGiorno) do
    FasceGiorno[i]:=0;
  for i:=Low(FasceMese) to High(FasceMese) do
    FasceMese[i]:=0;
  for i:=0 to High(SpezzoniNonAbilitati) do
    if SpezzoniNonAbilitati[i].TipoAbil = 'NC' then
    begin
      if (SpezzoniNonAbilitati[i].TipoSpez = 'U') then//or (TipoSpez = '') then
      begin
        for j:=1 to n_fasce do
          z714_suddivisioneFasce(1,SpezzoniNonAbilitati[i].Inizio,SpezzoniNonAbilitati[i].Fine,j,FasceGiorno);
      end
      else if (SpezzoniNonAbilitati[i].TipoSpez = 'FO') and
              (Parametri.CampiRiferimento.C90_W026Spezzoni <> 'T') and
              (Parametri.CampiRiferimento.C90_W026IncludiSpezzoniFuoriOrario = 'S') then
      begin
        if //(( = 'E') and (EntrataTeorica >= 0) and (SpezzoniNonAbilitati[i].Inizio < EntrataTeorica)) or
           ((*(TipoSpez = 'U') and*) (UscitaTeorica >= 0) and (SpezzoniNonAbilitati[i].Fine > UscitaTeorica))
        then
        begin
          for j:=1 to n_fasce do
            z714_suddivisioneFasce(1,SpezzoniNonAbilitati[i].Inizio,SpezzoniNonAbilitati[i].Fine,j,FasceGiorno);
        end
      end;
    end;

  if FALSE then
  BEGIN
    for i:=1 to n_fasce do
      if FasceGiorno[i] > 0 then
        Result:=Result + IfThen(Result <> '',' ') + Format('%s(%d%%)',[R180MinutiOre(FasceGiorno[i]),tfasceorarie[i].tpercfasc]);
  END
  ELSE
  BEGIN
    for i:=1 to n_fasce do
    begin
      j:=tfasceorarie[i].tposfasc;
      if j > 0 then
        inc(FasceMese[j],FasceGiorno[i]);
    end;

    for i:=Low(FasceMese) to High(FasceMese) do
    begin
      if i > 1 then
        Result:=Result + ' ';
      Result:=Result + IfThen(Fascemese[i] = 0,'     ',R180MinutiOre(FasceMese[i]));
    end;
  END;

  Result:=Result.TrimRight;
end;

function TR502ProDtM1.GetNumTurniReperibilita(TipoTurno:String):Boolean;
//Verifico se ci sono turni di reperibilità o prest.aggiuntive
var
  i: integer;
begin
  Result:=False;
  for i:=0 to High(TurniReperibilita) do
    if TurniReperibilita[i].Tipo = TipoTurno then
    begin
      Result:=True;
      Break;
    end;
end;

function TR502ProDtM1.GetRiepPresTotale(i:Byte):Integer;
begin
  Result:=R180SommaArray(triepgiuspres[i].tminpres);
end;

function TR502ProDtM1.GetRiepAssenza(Causale,Risultato:String):Integer;
var i:Integer;
begin
  Result:=0;
  for i:=1 to n_riepasse do
    if triepgiusasse[i].tcausasse = Causale then
    begin
      if Risultato = 'GG' then
        Result:=triepgiusasse[i].tggasse
      else if Risultato = 'MG' then
        Result:=triepgiusasse[i].tmezggasse
      else if Risultato = 'HH' then
        Result:=triepgiusasse[i].tminasse
      else if Risultato = 'HHRESE' then
        Result:=triepgiusasse[i].tminresasse
      else if Risultato = 'HHVAL' then
        Result:=triepgiusasse[i].tminvalasse
      else if Risultato = 'HHVALCOMP' then
        Result:=triepgiusasse[i].tminvalcompasse;
      Break;
    end;
end;

function TR502ProDtM1.GetRiepAssenzaOreInalterate:Integer;
var i:Integer;
begin
  Result:=0;
  for i:=1 to n_riepasse do
    if ValStrT265[triepgiusasse[i].tcausasse,'INFLUCONT'] = 'B' then
      inc(Result,triepgiusasse[i].tminvalasse);
end;

function TR502ProDtM1.GetTurniExtraPianificati(Tipo:String):String;
var i:Integer;
begin
  Result:='';
  for i:=Low(CodTurniReperibilita) to High(CodTurniReperibilita) do
    if CodTurniReperibilita[i].Tipo = Tipo then
      Result:=Result + Trim(CodTurniReperibilita[i].Turno1.Codice + ' ' + CodTurniReperibilita[i].Turno2.Codice + ' ' + CodTurniReperibilita[i].Turno3.Codice) + ' ';
  Result:=Trim(Result);
end;

function TR502ProDtM1.GetTurniExtraPianificatiDalleAlle(Tipo:String):String;
var i:Integer;
begin
  Result:='';
  for i:=Low(CodTurniReperibilita) to High(CodTurniReperibilita) do
    if CodTurniReperibilita[i].Tipo = Tipo then
    begin
      if CodTurniReperibilita[i].Turno1.Codice <> '' then
        Result:=Result + Trim(CodTurniReperibilita[i].Turno1.Codice + '(' + R180MinutiOre(CodTurniReperibilita[i].Turno1.Inizio) + '-' + R180MinutiOre(CodTurniReperibilita[i].Turno1.Fine) + ')')
      else if (CodTurniReperibilita[i].Turno1.Inizio > 0) and (CodTurniReperibilita[i].Turno1.Fine > 0) then
        Result:=Result + Trim(R180MinutiOre(CodTurniReperibilita[i].Turno1.Inizio) + '-' + R180MinutiOre(CodTurniReperibilita[i].Turno1.Fine));
      if CodTurniReperibilita[i].Turno2.Codice <> '' then
        Result:=Result + ' ' + Trim(CodTurniReperibilita[i].Turno2.Codice + '(' + R180MinutiOre(CodTurniReperibilita[i].Turno2.Inizio) + '-' + R180MinutiOre(CodTurniReperibilita[i].Turno2.Fine) + ')')
      else if (CodTurniReperibilita[i].Turno2.Inizio > 0) and (CodTurniReperibilita[i].Turno2.Fine > 0) then
        Result:=Result + ' ' + Trim(R180MinutiOre(CodTurniReperibilita[i].Turno2.Inizio) + '-' + R180MinutiOre(CodTurniReperibilita[i].Turno2.Fine));
      if CodTurniReperibilita[i].Turno3.Codice <> '' then
        Result:=Result + ' ' + Trim(CodTurniReperibilita[i].Turno3.Codice + '(' + R180MinutiOre(CodTurniReperibilita[i].Turno3.Inizio) + '-' + R180MinutiOre(CodTurniReperibilita[i].Turno3.Fine) + ')');
    end;
  Result:=Trim(Result);
end;

function TR502ProDtM1.GetPercPartTime(Tipo:String):Single;
var
  Found: Boolean;
begin
  Result:=1;

  // debito agg. 24/03/2010
  // diversamente dalle indennità, il proporzionamento del debito aggiuntivo
  // è da considerarsi su tutti i tipi di part-time (anche verticali)
  if UpperCase(Tipo) = 'DEBITO_AGG' then
    Found:=Q460.SearchRecord('Codice',Q430.FieldByName('PARTTIME').AsString,[srFromBeginning])
  else
    Found:=Q460.SearchRecord('Tipo;Codice',VarArrayOf(['O',Q430.FieldByName('PARTTIME').AsString]),[srFromBeginning]);

  //if Q460.SearchRecord('Codice',Q430.FieldByName('PARTTIME').AsString,[srFromBeginning]) then
  // debito agg.fine
  if Found then
    try
      Result:=Q460.FieldByName(Tipo).AsFloat / 100;
    except
    end;
end;

function TR502ProDtM1.GetGiustifPM:Boolean;
//Restituisce True se esistono giustificativi dalle..alle da considerare nella pausa mensa
var k:Integer;
begin
  Result:=False;
  for k:=1 to n_giusdaa do
  begin
    if Result then
      Break;
    if tgius_dallealle[k].tassenza  then
    begin
      if ValStrT265[tgius_dallealle[k].tcausdaa,'TIMB_PM'] = 'S' then
        Result:=True;
    end
    else if ValStrT275[tgius_dallealle[k].tcausdaa,'TIMB_PM'] = 'S' then
      Result:=True;
  end;
end;

procedure TR502ProDtM1.SetFasciaMensa(MinutiRif:Integer);
{Alberto 10/01/2012 - gestione della pausa mensa in fascia notturna nel giorno dopo se gestito interno turno notturno}
begin
  FasciaMensa.PMTInizioDa:=ValNumT021['ENTRATAMM',TF_PM_TIMBRATA,1];
  FasciaMensa.PMTInizioA:=ValNumT021['MMRITARDO',TF_PM_TIMBRATA,1];
  FasciaMensa.PMTFineDa:=ValNumT021['MMANTICIPOU',TF_PM_TIMBRATA,1];
  FasciaMensa.PMTFineA:=ValNumT021['USCITAMM',TF_PM_TIMBRATA,1];
  if NotteSuEntrata_TurnoCompleto and (MinutiRif > 1440) then
  begin
    inc(FasciaMensa.PMTInizioDa,1440);
    inc(FasciaMensa.PMTInizioA,1440);
    inc(FasciaMensa.PMTFineDa,1440);
    inc(FasciaMensa.PMTFineA,1440);
  end;
end;

procedure TR502ProDtM1.WConsideraRichiesteWeb(Valore:Boolean);
begin
  if Valore then
    Q100:=selT100T105
  else
    Q100:=selT100;
  if Valore <> FConsideraRichiesteWeb then
  begin
    FConsideraRichiesteWeb:=Valore;
    ResettaProg;
  end;
end;

function TR502ProDtM1.GetPrimaEntrataNominaleUsata:Integer;
var i:Integer;
begin
  Result:=9999;
  for i:=1 to n_timbrdip do
    if (ttimbraturedip[i].tpuntnomin > 0) and (ttimbraturenom[ttimbraturedip[i].tpuntnomin].tminutin_e < Result) then
      with ttimbraturenom[ttimbraturedip[i].tpuntnomin] do
        Result:=tminutin_e + max(0,Flex - FlexPM);
  if Result = 9999 then
    Result:=-1;
end;

function TR502ProDtM1.GetUltimaUscitaNominaleUsata:Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=1 to n_timbrdip do
    if (ttimbraturedip[i].tpuntnomin > 0) and (ttimbraturenom[ttimbraturedip[i].tpuntnomin].tminutin_u > Result) then
      Result:=ttimbraturenom[ttimbraturedip[i].tpuntnomin].tminutin_u;
end;

function TR502ProDtM1.GetXParam(Param:String):Boolean;
begin
  Result:=False;
  if cdsT020.Active and (cdsT020.FindField('XPARAM') <> nil) then
  begin
    if cdsT020.FindField('XPARAM_COMP_OLDVERS') = nil then
      Result:=Pos(Param,cdsT020.FieldByName('XPARAM').AsString) > 0
    else
      Result:=Pos(Param,cdsT020.FieldByName('XPARAM').AsString + cdsT020.FieldByName('XPARAM_COMP_OLDVERS').AsString) > 0;
  end;
end;

function TR502ProDtM1.GetDetrazRiepprNorm:String;
begin
  Result:='CS';
  if cdsT020.FindField('DETRAZ_RIEPPR_NORM') = nil then
    exit;
  if cdsT020.FieldByName('DETRAZ_RIEPPR_NORM').IsNull then
    exit;
  Result:=cdsT020.FieldByName('DETRAZ_RIEPPR_NORM').AsString;
end;

procedure TR502ProDtM1.TTimbratureDip_Compatta;
var i:Integer;
begin
  i:=n_timbrdip;
  while i >= 1 do
  begin
    if (ttimbraturedip[i].tminutid_e = ttimbraturedip[i].tminutid_u) and
       (ttimbraturedip[i].tcausale_e.tcaus <> CAUS_PM) and
       (ttimbraturedip[i].tcausale_u.tcaus <> CAUS_PM)
    then
    begin
      indice:=i;
      z802_toglitimbr;
    end;
    dec(i);
  end;
end;

procedure TR502ProDtM1.TTimbratureDip_Backup(var ArrayBackup: array of t_ttimbraturedip);
var i:Integer;
begin
  for i:=1 to n_timbrdip do
  begin
    ArrayBackup[i - 1]:=ttimbraturedip[i];
  end;
end;

procedure TR502ProDtM1.TTimbratureDip_Restore(var ArrayBackup: array of t_ttimbraturedip);
var i:Integer;
begin
  for i:=1 to High(ttimbraturedip) do
  begin
    ttimbraturedip[i]:=ttimbraturedip_vuota;
  end;

  for i:=0 to High(ArrayBackup) do
  begin
    ttimbraturedip[i + 1]:=ArrayBackup[i];
  end;
  n_timbrdip:=Length(ArrayBackup);
end;

procedure TR502ProDtM1.TGiusDalleAlle_Backup(var ArrayBackup: array of t_tgius_dallealle);
var i:Integer;
begin
  for i:=1 to n_giusdaa do
  begin
    ArrayBackup[i - 1]:=tgius_dallealle[i];
  end;
end;

procedure TR502ProDtM1.TGiusDalleAlle_Restore(var ArrayBackup: array of t_tgius_dallealle);
var i:Integer;
begin
  for i:=0 to High(ArrayBackup) do
  begin
    tgius_dallealle[i + 1]:=ArrayBackup[i];
  end;
  n_giusdaa:=Length(ArrayBackup);
end;

//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
////////////I N I Z I O    R O U T I N E S    C O N T E G G I ////////////
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
procedure TR502ProDtM1.R500inizio;
{Parametrizzo le query con progressivo e data corretti}
begin
  if ProgrCon <> QProgressivo then
  begin
    QProgressivo:=ProgrCon;
    lstT011.Svuota;//if cdsT011.Active then cdsT011.EmptyDataSet;
    if cdsT020.Active then
      cdsT020.EmptyDataSet;
    if cdsT021.Active then
      cdsT021.EmptyDataSet;
    {$IFDEF MEDP803}AggiornaQuery;{$ENDIF}
  end;
  {$IFNDEF MEDP803}AggiornaQuery;{$ENDIF}
  DecodeDate(DataCon,DataCon_aa,DataCon_mm,DataCon_gg);
  //Se voglio solo aprire gli archivi non eseguo i conteggi
  if Chiamante <> 'APERTURA' then
  begin
    Q430.Filtered:=True;
    Inizio;
    Q430.Filtered:=False;
  end;
end;

procedure TR502ProDtM1.AggiornaQuery;
{Assegna il progressivo richiesto alle Query e le aggiorna}
begin
  {$IFDEF MEDP803}QueryActive(pProg,False);{$ENDIF}
  R180SetVariable(Q011,'Progressivo',QProgressivo);
  R180SetVariable(Q012B,'Progressivo',QProgressivo);
  R180SetVariable(Q040,'Progressivo',QProgressivo);
  R180SetVariable(selT050,'Progressivo',QProgressivo);
  R180SetVariable(selIter,'Progressivo',QProgressivo);
  R180SetVariable(Q080,'Progressivo',QProgressivo);
  R180SetVariable(Q090,'Progressivo',QProgressivo);
  //Q100.SetVariable('Progressivo',QProgressivo);
  R180SetVariable(selT100,'Progressivo',QProgressivo);
  R180SetVariable(selT100T105,'Progressivo',QProgressivo);
  R180SetVariable(Q320,'Progressivo',QProgressivo);
  R180SetVariable(Q370,'Progressivo',QProgressivo);
  R180SetVariable(Q380,'Progressivo',QProgressivo);
  R180SetVariable(Q332,'Progressivo',QProgressivo);
  R180SetVariable(Q430,'Progressivo',QProgressivo);
  R180SetVariable(selT025,'Progressivo',QProgressivo);
  R180SetVariable(selVT420,'Progressivo',QProgressivo);
  QueryActive(pProg,True);
end;

procedure TR502ProDtM1.Inizio;
{Corrisponde alla routine 'inizio' di R502Pro}
begin
  parcaus.l29_Ragg:='';
  parcaus.l29_0paramet:='';
  parcaus.l29_1paramet:='';
  parcaus.l29_2paramet:='';
  parcaus.l29_3paramet:='';
  parcaus.l29_4paramet:='';
  parcaus.l29_5paramet:='';
  parcaus.l29_6paramet:='';
  parcaus.l29_7paramet:='';
  parcaus.l29_8paramet:='';
  parcaus.l29_9paramet:='';
  parcaus.l29_10paramet:='';
  parcaus.l29_11paramet:='';
  parcaus.l29_12paramet:='';
  parcaus.l29_13paramet:='';
  parcaus.l29_14paramet:='';
  parcaus.l29_15paramet:='';
  parcaus.l29_16paramet:='';
  parcaus.l29_17paramet:='';
  parcaus.l29_18paramet:='';
  parcaus.l29_19paramet:='';
  parcaus.l29_20paramet:='';
  parcaus.l29_21paramet:='';
  parcaus.l29_22paramet:='';
  parcaus.l29_23paramet:='';
  parcaus.l29_24paramet:='';
  parcaus.l29_25paramet:='';
  parcaus.l29_26paramet:='';
  parcaus.l29_27paramet:='';
  parcaus.l29_28paramet:='';
  parcaus.l29_29paramet:='';
  parcaus.l29_30paramet:='';
  parcaus.l29_31paramet:='';
  parcaus.l29_32paramet:='';
  parcaus.l29_33paramet:='';
  parcaus.l29_34paramet:='';
  parcaus.l29_35paramet:='';
  parcaus.l29_36paramet:='';
  parcaus.l29_37paramet:='';
  parcaus.l29_38paramet:='';
  parcaus.l29_39paramet:='';
  parcaus.l29_40paramet:='';
  parcaus.l29_41paramet:='';
  parcaus.l29_42paramet:='';
  parcaus.l29_43paramet:='';
  parcaus.l29_44paramet:='';
  parcaus.l29_45paramet:='';
  parcaus.l29_46paramet:='';
  parcaus.l29_47paramet:='';
  parcaus.l29_48paramet:='';
  parcaus.l29_49paramet:='';
  parcaus.l29_50paramet:='';
  parcaus.l29_51paramet:='';
  parcaus.l29_52paramet:='';
  if PrimaVolta = 'si' then
  //****   Gestione prima chiamata a questa routine
  begin
    PrimaVolta:='no';
    i000_PrimaVol;
    if Blocca = 0 then
    //****   Acquisizione progressivo dipendente e routine conteggi
    begin
      z000_Conteggio;
      z008_GestioneAnomalie;
    end;
  end
  else
  begin
    z000_Conteggio;
    z008_GestioneAnomalie;
  end;
  //Gestione reperibiltà sostitutiva B (S.Anna)
  if (RepSost) and ((Chiamante = 'Cartellino') or (Chiamante = 'Anomalie') or (Chiamante = 'Servizio')) then
    z1000_ReperibilitaSostitutivaB;
end;
//_________________________________________________________________
procedure TR502ProDtM1.i000_primavol;
{Gestione prima chiamata a questa routine}
begin
  Blocca:=0;
  ProgrCon20_sv:=0;
  anno20_sv:=0;
  mese20_sv:=0;
  gior20_sv:=0;
  progrconpo_sv:=0;
  annopo_sv:=0;
  mesepo_sv:=0;
  c_profora_sv:='';
  NotteSuEntrata_sv:='';
  DataPrec_sv:=0;
  es09_sv:='no';
  indprescalcieri:='si';
  z999_seleziona(Q200,'Codice',''); //Alberto 04/03/2010: apertura dei contratti in modo che siano disponibili alla R400 anche se i conteggi giornalieri danno anomalie bloccanti per tutto il mese
end;
//_________________________________________________________________
procedure TR502ProDtM1.z000_conteggio;
var k,k2:Integer;
{Azzeramenti iniziali}
  procedure z000EstendiPeriodoConteggio;
  var i:integer;
  begin
    if minutialle >= 1440 then
      for i:=1 to n_giusdaa do
        if tgius_dallealle[i].tminutia > minutialle then
          minutialle:=tgius_dallealle[i].tminutia;
    //Ampliamento fascia notturna
    if (fine1fascind = 1440) and (minutialle > 1440) then
      fine1fascind:=1440 + fine2fascind;
  end;
  procedure z000b;
  var i:Integer;
    function VerificaInfluCont(Indice:Integer; Causale:String):Boolean;
    var ic:String;
    begin
      ic:=ValStrT265[Causale,'INFLUCONT'];
      Result:=((Indice = 1) and (ic <> 'G') and (ic <> 'I')) or
              ((Indice = 2) and (ic = 'I')) or
              ((Indice = 3) and (ic = 'G'));
    end;
  begin
    //Alberto 15/07/2009: se ci sono solo giustificativi, elimino le timbratura fittizie (per es. quella delle 12.00) per consentire il calcolo della PM sui soli giustificativi effettivi
    if conteggi_sologiust then
      for i:=n_timbrdip downto 1 do
      begin
        indice:=i;
        z802_toglitimbr;
      end;
    paumendet_giust:=paumendet; //Alberto 18/06/2009: detrazione della pausa mensa dai giustificativi che intersecano la PMT
    //Alberto 21/01/2010: scorrimento dei giustificativi considerando per ultimi quelli con "Aumenta ore rese da assenza fino al debito" e "Aumenta ore lav fino a completare il debito"
    //i = 1: giustificativi normali
    //i = 2: giustificativi assenza "Aumenta ore rese da assenza fino al debito"
    //i = 3: giustificativi assenza "Aumenta ore lav fino a completare il debito"
    for i:=1 to 3 do
    begin
      //Gestione globale giustificativi dalle-alle
      iag:=1;
      while (iag <= n_giusdaa) and (blocca = 0) do
      begin
        if VerificaInfluCont(i,tgius_dallealle[iag].tcausdaa) then
          z300_giustdaa;
        inc(iag);
      end;
      if blocca <> 0 then exit;
      //Gestione ore min e max giornaliere per orario elastico
      if (chiamante <> 'Assenze') and (TipoOrario = 'C') then
        if i = 3 then
          z200_oreelast;
      //Gestione globale giustificativi in numero ore
      if Copy(f03_com,1,5) <> 'ALLE*' then
      begin
        iag:=1;
        while (iag <= n_giusore) and (blocca = 0) do
        begin
          if VerificaInfluCont(i,tgius_min[iag].tcausore) then
            z310_giustore;
          inc(iag);
        end;
        if blocca <> 0 then exit;
      end;
      //Gestione globale giustificativi mezza giornata assenza
      if Copy(f03_com,1,5) <> 'ALLE*' then
      begin
        iag:=1;
        while (iag <= n_giusmga) and (iag <= 2) and (blocca = 0) do
        begin
          if VerificaInfluCont(i,tgius_mgass[iag].tcausmgass) then
            z320_giustmgass;
          inc(iag);
        end;
        if blocca <> 0 then exit;
      end;
      //Gestione globale giustificativi giornata intera assenza
      if (Copy(f03_com,1,5) <> 'ALLE*') or (FFunzioneChiamante = 'A043') then //Alberto 26/07/2011 - lascio conteggiare le giornate del giorno dopo: servono alla cartolina di reperibilità
      begin
        invcausggass:='no';
        iag:=1;
        while (iag <= n_giusgga) and (*(iag <= 2) and*) (blocca = 0) do
        begin
          if VerificaInfluCont(i,tgius_ggass[iag].tcausggass) then
            z330_giustggass;
          inc(iag);
        end;
        if blocca <> 0 then exit;
      end;
    end;
    //Detrazioni dovute ai giustificativi di presenza
    detrazioni:=DetPresenza;
    z140_detrazioni(tminlav);
    //Alberto: Ulteriore detrazione pausa mensa, dopo aver conteggiato i giustificativi, se prima non c'era disponibilità sulle ore da timbrature
    detrazioni:=paumendet_resto;
    z140_detrazioni(tminlav);
    rec_psicofisico:=0;
    if XParam[XP_REC_PSICOFISICO] then
    begin
      for i:=1 to n_timbrcon do
        if ttimbraturecon[i].tminutic_u - ttimbraturecon[i].tminutic_e > rec_psicofisico then
          rec_psicofisico:=ttimbraturecon[i].tminutic_u - ttimbraturecon[i].tminutic_e;
      rec_psicofisico:=max(0,rec_psicofisico - 360);
      rec_psicofisico:=min(10,rec_psicofisico);
      detrazioni:=rec_psicofisico;
      z140_detrazioni(tminlav);
    end;

    //GESTIONE GIORNO CON INDENNITA' E SALDI GIORNALIERI
    if chiamante <> 'Assenze' then
    begin
      //Firenze_Comune: conteggio turno 21.00-3.00 su uscita
      z9999_NotteUscita;
      //SGiulianoMilanese_Comune: arrotondamento sul reso finale (messi comunali)
      z199_arrgiornal_finale;
      if XParam[XP_COTO_ORECAUS_DETPM]  then
        z780_OreCausDetPausaMensa;
      if (not XParam[XP_SGM_CAUSARR_FASCE]) or (datacon < EncodeDate(2013,11,1)) then
        //Torino_Comune: arrotondamento riepiloghi causali ai 30 minuti con mantenimento del resto nelle ore rese per scorrimento
        z1004_ArrotondaOreCausalizzate
      else
        //S.Giuliano Milanese: solo dal 01/11/2013 arrotondamento in fasce con riporto del resto sulla fascia più bassa
        z1013_ArrotondaOreCausalizzateSGM;
      if not XParam[XP_COTO_ORECAUS_DETPM] then
        z780_OreCausDetPausaMensa;
      //TORINO_CSI_PRV: tolleranza su pausa mensa automatica
      z1017_TolleranzaPMA;
      //Limitazione delle ore causalizzate al debito giornaliero
      z782_OreCausalizzateLimitate;
      z784_OreCausalizzateInterneLimitate;
      //Abbuono ore causalizzate escluse inferiori al minimo
      z785_OreCausalizzateInferioriMinimo;
      //Gestione finale del lavorato giornaliero
      z750_saldigg;
      //Calcolo lavorato e scostamento giornalieri definitivi
      z752_lavscostgg;
      //Calcolo dei dati finali
      z770_datifinali;
      //Torino_Comune: quadratura settimanale aggiungendo sulla domenica di fine settimana un giustificativo in più/meno per avere il totale ore settimanali = debito settimanale
      z1005_QuadraturaSettimanale;
      //Calcolo tipi di straordinario potenzialmente liquidabile
      z772_tipistraor;
      //Scrivo in tminstrgio il tipo di straordinario specificato
      z773_getstraor;
      z1009_CausalizzaStraordinario;
      z1007_AbbatteSuddivisioneFasce;
      //Gestione dei riposi compensativi in fasce
      z778_ripcomfasce;
      //Aggiunta dei minuti in più dovuti al ricalcolo del debito in giorno festivo infra-settimanale (Regione Piemonte)
      z740_AlterazioneOreRese;  //inc(tminlav[1],MinRicalcoloFest);
      //Compensazione debito gg con ore esluse dalle normali (Regione Aosta)
      z1014_CompensoDebitoDaCausEscluse;
      //Verifica del rispetto delle fasce obbligatorie
      z756_fasciaobbligatoria;
      //Calcolo indennita' festive, di turno e di presenza
      z710_indennita;
      //Suddivisione ore rese per rilevatore
      z730_RiepilogoRilevatori;
      //Riepilogo turni libera professione con relative ore rese
      z731_RiepilogoLibProf;
      //Riepilogo Strutture personale Convenzionato
      z1019_RiepilogoStruttureConvenzionate;
      //Suddivisione ore causalizzate nelle Voci Paghe a blocchi (AMGAS Bari)
      z850_FascePaghe;
      z790_OrdinaRiepiloghi;
      (*Crea problemi in certe situazioni: dovrebbe tenere conto di causali di presenza e stacco mensa...
      //Elimina coppie di timbrature uguali E=U ma non di pausa mensa (per visualizzazione)
      TTimbratureDip_Compatta;
      *)
      //ricalcolo lavorato e scostamento giornalieri definitivi
      z752_lavscostgg; //Alberto 15/01/2014: aggiunto perchè le chiamate precedenti (es. z710) possono alterare tminlav
    end;
  end;
  //__________________________
begin
  calcolo_z100:=True;
  z010_azziniz;
  //Operazioni iniziali su data conteggio
  z020_datainiz;
  {Se chiamante = Contratto
    Lettura contratto del dipendente con sue fasce orarie e uscita }
  if chiamante = 'Contratto' then
  begin
    z150_contrat;
    exit;
  end;
  //Impostazione fascia del giorno da conteggiare
  z040_fascdacon;
  //Lettura timbrature e gestione parziale prima T=U
  //o ultima T=E o 24 ore di lavoro
  if chiamante <> 'Assenze' then
  begin
    z450_turnireperib;
    z400_timbrat;
    if blocca <> 0 then
    begin
      bloccatimb:=blocca;
      blocca:=0;
      (*n_timbrdip:=0;
      ultimt_e:='no';
      primat_u:='no';*)
    end;
  end;
  z071_salvatimbrature;
  //Lettura giustificativi
  if esegui_z430 then
    z430_giustif;
  //Calcolo minuti di presenza al lordo delle detrazioni
  for k:=1 to n_timbrdip do
    minpresenzelorde:=minpresenzelorde + max(0,ttimbraturedip[k].tminutid_u - ttimbraturedip[k].tminutid_e);
  //Verifica dipendente in servizio
  z042_dipinser;
  if blocca <> 0 then exit;
  if (chiamante <> 'Assenze') and (dipinser = 'no') then exit;
  //Lettura tipo giorno da calendario del dipendente
  z022_calend;
  if blocca <> 0 then exit;
  //Lettura giorni lavorativi del dipendente dal calendario
  giornlav:=giornlav178;
  if blocca <> 0 then exit;
  //Verifica se giorno lavorativo o meno da calendario
  z180_gglavnor;
  //Scelta orario
  z500_orarfac;
  if blocca <> 0 then exit;
  //Alberto 28/05/2007: Gestisco qui bloccatimb, perchè può essere stato annullato dentro z502, se il profilo permette di ignorare le timb non in seq
  if bloccatimb <> 0 then
  begin
    n_timbrdip:=0;
    ultimt_e:='no';
    primat_u:='no';
  end;
  //4.0
  {Riconoscimento se conteggiare il turno notturno su entrata:
  NotteEntrata = 'S',
  Orario a Turni con Cavallo Mezzanotte senza Frazionamento Debito,
  Nessun conteggio parziale (Dalle..alle)
  timbrature a cavallo oppure pianificazione di un turno notturno specificando E/U}
  NotteSuEntrata:=False;
  if (TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and
     (cdsT020.FieldByName('FrazDeb').AsString = 'N') and (cdsT020.FieldByName('NotteEntrata').AsString = 'S') and
     (Trim(f03_com) = '') and
     ((ultimt_e = 'si') or (primat_u = 'si') or
      (*((pianif = 'si') and (turnicavmez = 'si') and (l08_turno1EU <> ''))*)
      EsisteTurnoNotturnoPianificato  //Alberto 27/10/2009: sostituito al test precedente per gestire meglio la flessibilità a cavallo di mezzanotte quando si entra dopo mezzanotte
     ) then
  begin
    NotteSuEntrata:=True;
    //Alberto 10/01/2012 - attivazione della gestione dell'interno turno notturno
    NotteSuEntrata_TurnoCompleto:=XParam[XP_TURNO_NOTTURNO] and (not ConteggiaGiustificativiR600) and (Chiamante <> 'Assenze');
    if NotteSuEntrata_TurnoCompleto then
      z280_legginomE;
    GestioneTimbratureDipendente;
  end;
  //Alberto 05/11/2013: segnalazione anomalia se conteggio notturno su entrata non presente su entrami i giorni della notte
  if (DataPrec_sv + 1 = DataCon) and (NotteSuEntrata_sv <> '') and (primat_u = 'si') and (NotteSuEntrata_sv <> BoolToStr(NotteSuEntrata)) then
  begin
    if NotteSuEntrata then
      z098_anom2caus(56,'')
    else
      z098_anom2caus(55,'');
  end;
  DataPrec_sv:=DataCon;
  NotteSuEntrata_sv:=BoolToStr(NotteSuEntrata);
  //Segnalazione di anomalia se esistono richieste web in attesa di autorizzazione / elaborazione
  z448_CheckAnomalieIter;
  //Verifica se giorno lavorativo o meno per personale turnista
  if (Q430.FieldByName('TGestione').AsString = '1')  or (Q430.FieldByName('TGestione').AsString = '4') then
  begin
    z181_gglavtur;
    if blocca <> 0 then exit;
  end;
  //Verifica se giorno vuoto
  if (gglav = 'si') and (cdsT020.FieldByName('OBBLFAC').AsString = 'O') and (n_timbrdip = 0) and (n_giusdaa = 0) and (idxAnomalia(2,51) = -1) and
     (n_giusore = 0) and (n_giusmga = 0) and (n_giusgga = 0) then
  begin
    ggvuoto:=1;
    if (blocca = 0) and (bloccatimb = 0) then
    begin
      z098_anom2caus(31,'');
    end;
  end
  //Alberto 08/02/2013: segnalazione sola anomalia giorno vuoto anche per turnista senza pianificazione
  else if (Q430.FieldByName('TGestione').AsString = '1') and
          ((pianif = 'no') or ((c_turni1 = -1) and (c_turni1 = -1))) and
          (cdsT020.FieldByName('OBBLFAC').AsString = 'O') and (n_timbrdip = 0) and (n_giusdaa = 0) and (idxAnomalia(2,51) = -1) and
          (n_giusore = 0) and (n_giusmga = 0) and (n_giusgga = 0) then
  begin
    ggvuoto_turnista:=1;
    if (blocca = 0) and (bloccatimb = 0) then
    begin
      z098_anom2caus(54,'');
    end;
  end;
  //Verifica se giorno di presenza
  if n_timbrdip <> 0 then
    ggpresenza:=1;
  //Se chiamante = Assenze si va alla gestione giustificativi
  (*if chiamante = 'Assenze' then
    begin
    fasciabass:=1;
    z000b;
    end
  else *)
  begin
    //arrotondo i giustificativi di assenza fruiti ad ore (GENOVA_COMUNE)
    //z043_arrotgiustore; //Alberto 04/11/2005
    //Controllo intersezione timbrature e giustificativi
    //z044_intimgiu; //Alberto 04/11/2005
    if blocca <> 0 then exit;
    //Lettura contratto del dipendente con sue fasce orarie
    z150_contrat;
    if blocca <> 0 then exit;
    //Esensione minutialle se esistono giustificativi nel giorno dopo
    if NotteSuEntrata and NotteSuEntrata_TurnoCompleto then
      z000EstendiPeriodoConteggio;
    //Scelta tipo di fasce orario ( FER/FES/SAB ) in base al gg
    //e calcolo puntatore alla fascia piu' bassa
    z170_tipofasc;
    //Lettura monte ore settimanale del dipendente
    z172_monteore;
    if blocca <> 0 then exit;
    //Calcolo debito orario senza gestione non lavorativo
    z182_debitoor;
    //Calcolo debito plus orario senza gestione non lavorativo
    z188_debitopo;
    if blocca <> 0 then exit;
    //Lettura timbrature nominali
    n_timbrnom:=0;
    ttimbraturenom:=nil;
    SetLength(ttimbraturenom,1); //-->Inizializzazioni
    ttimbraturenom_vuota.EntrataNomPrec:=0;
    ttimbraturenom_vuota.Flex:=0;
    ttimbraturenom_vuota.FlexPM:=0;
    ttimbraturenom_vuota.Ritardo:=0;
    ttimbraturenom_vuota.PuntreNomPrec:=0;
    ttimbraturenom_vuota.tminutin_e:=0;
    ttimbraturenom_vuota.tminutin_u:=0;
    ttimbraturenom_vuota.tpuntre:=0;
    ttimbraturenom_vuota.tpuntru:=0;
    ttimbraturenom_vuota.tminutin_e_ori:=-1;
    ttimbraturenom_vuota.tminutin_u_ori:=-1;
    if TipoOrario = 'A' then
      z210_legginomA
    else if TipoOrario = 'B' then
      z220_legginomB
    else if TipoOrario = 'C' then
      z240_legginomC
    else if TipoOrario = 'D' then
      z260_legginomD
    else if TipoOrario = 'E' then
      z280_legginomE;
    if blocca <> 0 then exit;
    //Verifica se si puo' calcolare
    //l'indennita' di presenza di ieri
    z706_indverieri;
    //Acquisizione codice indennita' di presenza
    //considerando pianificazione e dati strutturali
    z024_acqcodindp;
    //Inserimento timbrature facoltative (se necessario)
    z050_instimfc;
    z051_instim_orariospezzato;
    //Gestione orario a ascorrimento per TORINO_COMUNE: scatta solo se ci sono timbrature oppure il giorno è vuoto, e altera i punti nominali
    if (tipogglav = 'S') and
       (Self.Name <> 'R502Ricorsivo') and (cdsT020.FieldByName('RICALCOLO_DEBITO_GG').AsString = 'S') then
    begin
      if cdsT020.FieldByName('RICALCOLO_SPOSTA_PN').AsString = 'S' then
        z187_RicalcoloDebitoGiornaliero;
    end;
    if (n_timbrdip = 0) then
    begin
      //Alberto 17/06/2009: carico timbratura fittizia se si deve applicare la pausa mensa sul giustificativo dalle..alle
      AttivaGiutificativiPerPausaMensa;
      //Alberto 02/04/2010: carico timbratura fittizia se si deve alterare la flessibiltà
      AttivaGiutificativiPerFlessibilita;
    end;
    //Se non ci sono timbrature si salta la loro gestione
    //if (n_timbrdip = 0) or ((Chiamante = 'Assenze') and (ValStrT265[m_tab_giustificativi[datacon_gg,1].tcausgius,'CUMULO_TIPO_ORE'] = '0')) then
    if (n_timbrdip = 0) or (Chiamante = 'Assenze') then
    begin
      //Definizione turno notturno e esclusione giustificativi già conteggiati il giorno prima
      if NotteSuEntrata then
        DefinizioneTurnoNotturno;
      //TORINO_CITTADELLASALUTE - iter ecc.gg su giustificativi dalle..alle
      z556_GiustifInLibProf;
      //limitazione giustificativi dalle..alle (TORINO_CSI_PRV)
      z1015_limitazione_giustdaa;
      //arrotondo i giustificativi di assenza fruiti ad ore (GENOVA_COMUNE)
      z043_arrotgiustore; //Alberto 04/11/2005
      //Controllo intersezione timbrature e giustificativi
      z044_intimgiu; //Alberto 04/11/2005
      z184_debiti;
      z000b;
    end
    else
    begin
      //GESTIONE TIMBRATURE
      //Le timbrature aumentano sempre le ore lavorate
      aum862:='si';
      CausaleDisabilBloccante:=cdsT020.FieldByName('CAUSALE_DISABIL_BLOCCANTE').AsString = 'S';
      //Gestione causali prima T=U o ultima T=E o 24 ore di lavoro
      z028_nottecaus;
      //Lettura e primi controlli su causali
      i1:=1;
      while i1 <= n_timbrdip do
      begin
        z064_causali;
        inc(i1);
      end;
      //Messina università: se esiste causale 83 e nessuna altra causale, i punti nominali diventano = al debito gg
      z212_corregginomA;
      //z071_salvatimbrature;
      //Scarto timbrature con causale presenza
      //su U e successiva E di tipo conteggio A (se abilitate)
      z072_tipoconA;
      //Gestione reperibilita' da turno pianificato
      z520_repdaturpian;
      //Gestione fasce di autorizzazione alla causalizzazione - prima chiamata per le fasce di autorizzazione normali
      z540_fascecausalizzazione(False);
      //Gestione libera professione
      z550_LiberaProfessione;
      //Gestione ore per la maturazione del gettone
      z560_FasceGettone(False);
      if not XParam[XP_V1067_Z570] and
         ((idxAnomalia(2,40) >= 0) or (idxAnomalia(2,41) >= 0) or (idxAnomalia(2,42) >= 0) or (idxAnomalia(2,43) >= 0))
      then
        z570_CompattaTimbrature;
      //Gestione due turni lavorati consecutivamente e
      //calcolo timbr. nominali di appoggio per timbr. dipendente
      z060_appoggio(True);
      if (TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and
         (ValNumT020['Min_Uscita_Notte'] > 0) then
        z1002_TimbNotturnaNonAppoggiata;
      if (TipoOrario = 'D') or (TipoOrario = 'C') then
        //Tolgo appoggio orario alle timbrature con causale
        //di presenza accoppiate per orario libero o elastico
        z094_appoggcaus
      else if (TipoOrario = 'E') and ((pianif = 'no') or ((pianif = 'si') and (l08_Turno1 = 0))) then
        //Tolgo appoggio orario se Turni non pianificati o riposo
        z094_appoggcaus;
      //Calcolo ore teoriche da svolgere per tipo orario a turni
      if TipoOrario = 'E' then
        z058_oreteotur;
      //Gestione flessibilita' e E in ritardo per tipo orario A
      if TipoOrario = 'A' then
      begin
        z088_flexorarA;
        //Ricalcolo timbr. nominali di appoggio per timbr. dipendente
        if (cdsT020.FieldByName('TipoFle').AsString <> 'D') and
           ((cdsT020.FieldByName('TipoFle').AsString = 'A') or (tritflex[2] = 0) or
            XParam[XP_REC_SPEZZATO_PM_AUTO]) then
          z060_appoggio(False);
      end;
      //Tolgo appoggio alle timbrature causalizzate con 'Ore esterne all'orario'
      z1003_StraordinarioForzato;
      //Gestione flessibilita' per tipo orario E
      if (TipoOrario = 'E') and (MaxFlex > 0) then
      begin
        z030_flexorarE;
        //Alberto 9/6/2003 x S.Martino, che usano orari a turni per amministrativi (come flessibili)
        if n_timbrnom = 1 then
        begin
          z060_appoggio(False);
          if (pianif = 'no') or ((pianif = 'si') and (l08_Turno1 = 0)) then
            //Tolgo appoggio orario alle causali se Turni non pianificati o riposo
            z094_appoggcaus;
          //Tolgo appoggio alle timbrature causalizzate con 'Ore esterne all'orario'
          z1003_StraordinarioForzato;
        end;
      end;
      //Roma_ASLA: anticipo la gestione delle causali su E postic. e U anticip.
      if XParam[XP_GEST_ANTIC_CAUS_UE] then
      begin
        i1:=1;
        while i1 <= n_timbrdip do
        begin
          z080_tipoconAf;
          inc(i1);
        end;
      end;
      //Gestione fasce di autorizzazione alla causalizzazione - seconda chiamata per le fasce di autorizzazione uguali ai punti nominali
      z540_FasceCausalizzazione(True);
      z560_FasceGettone(True); //Alberto 09/05/2012: gestione gettone per causali con fasce autorizzazione da Punti Nominali
      if not XParam[XP_V1067_Z570] and
         ((idxAnomalia(2,40) >= 0) or (idxAnomalia(2,41) >= 0) or (idxAnomalia(2,42) >= 0) or (idxAnomalia(2,43) >= 0))
      then
        z570_CompattaTimbrature;
      //arrotondo i giustificativi di assenza fruiti ad ore (GENOVA_COMUNE)
      z043_arrotgiustore; //Alberto 04/11/2005
      //Controllo intersezione timbrature e giustificativi
      z044_intimgiu; //Alberto 04/11/2005
      //4.0
      if NotteSuEntrata then
      begin
        DefinizioneTurnoNotturno;
        //Dopo aver appoggiato le nuove timbrature, si riverificano le causali esterne all'orario
        if (pianif = 'no') or ((pianif = 'si') and (l08_Turno1 = 0)) then
          z094_appoggcaus;
        z1003_StraordinarioForzato;
        if (Q430.FieldByName('TGestione').AsString = '1')  or (Q430.FieldByName('TGestione').AsString = '4') then
          z181_gglavtur;
        //Ri-verifica del giorno vuoto ( presenza dopo l'azione del turno notturno
        if (Q430.FieldByName('TGestione').AsString = '1') and
           ((pianif = 'no') or ((c_turni1 = -1) and (c_turni1 = -1))) and
           (cdsT020.FieldByName('OBBLFAC').AsString = 'O') and (n_timbrdip = 0) and (n_giusdaa = 0) and (idxAnomalia(2,51) = -1) and
           (n_giusore = 0) and (n_giusmga = 0) and (n_giusgga = 0) then
        begin
          ggvuoto_turnista:=1;
          if (blocca = 0) and (bloccatimb = 0) then
          begin
            z098_anom2caus(54,'');
          end;
        end;
        //Ri-verifica se giorno di presenza
        if n_timbrdip = 0 then
          ggpresenza:=0;
      end;
      //Gestione tipo pausa mensa A e B
      paumenTimbNonGes:=False;
      if n_timbrdip > 0 then
        z056_pausame;
      //Alberto 06/03/2009: se la flessibilità in uscita è cambiata per effetto della pausa mensa, riappoggio le timbrature
      for k:=1 to n_timbrnom do
        if ttimbraturenom[k].FlexPM > 0 then
        begin
          for k2:=1 to n_timbrdip do
            //Standard: stessa causale su E/U (anche senza)
            if (ttimbraturedip[k2].tpuntnomin = 0) and
               (not XParam[XP_APPOGGIO_FLEXPM_CAUS]) and
               (not XParam[XP_APPOGGIO_FLEXPM_NOCAUS]) and
               (ttimbraturedip[k2].tcausale_e.tcaus = ttimbraturedip[k2].tcausale_u.tcaus) and
               (ValStrT275[ttimbraturedip[k2].tcausale_e.tcaus,'LIQUIDABILE'] <> 'B')
            then
              z061_appoggioc1(k2)
            //<APPOGGIO_FLEXPM_NOCAUS> Versione vecchia: solo se senza causale
            else if (ttimbraturedip[k2].tpuntnomin = 0) and
               (ttimbraturedip[k2].tcausale_e.tcaus = '') and
               (ttimbraturedip[k2].tcausale_u.tcaus = '') and
               (XParam[XP_APPOGGIO_FLEXPM_NOCAUS])
            then
              z061_appoggioc1(k2)
            //<APPOGGIO_FLEXPM_CAUS> Messina_Universita: anche causali diverse (per es. solo sull'Uscita): basta che siano non Esterne all'orario
            else if (ttimbraturedip[k2].tpuntnomin = 0) and
                    (XParam[XP_APPOGGIO_FLEXPM_CAUS]) and
                    (ValStrT275[ttimbraturedip[k2].tcausale_e.tcaus,'LIQUIDABILE'] <> 'B') and
                    (ValStrT275[ttimbraturedip[k2].tcausale_u.tcaus,'LIQUIDABILE'] <> 'B')
            then
              z061_appoggioc1(k2)
            else if (PausaMensa = 'B') and  //Alberto 26/03/2012: solo nel caso di Pausa mensa = B, appoggio la timbratura se ha come causale di entrata P.M
               (ttimbraturedip[k2].tpuntnomin = 0) and
               (ttimbraturedip[k2].tcausale_e.tcaus = CAUS_PM) and
               (ttimbraturedip[k2].tcausale_u.tcaus = '')
            then
              z061_appoggioc1(k2);
          Break;
        end;
      calcolo_z100:=True;
      if blocca <> 0 then exit;

      //Anomalia e eliminazione per timbrature con causale di
      //presenza interne all'orario con tipo conteggio diverso da A
      z096_presinorar;
      if not XParam[XP_GEST_ANTIC_CAUS_UE] then
      begin
        //Gestione timbrature con causale presenza
        //di tipo conteggio A non accoppiata
        i1:=1;
        while i1 <= n_timbrdip do
        begin
          z080_tipoconAf;
          inc(i1);
        end;
      end;
      //Verifica se straordinario abilitato in anagrafico
      strabana:='no';
      with TStringList.Create do
      begin
        CommaText:=Q430.FieldByName('AbPresenza1').AsString;
        for k:=0 to Count - 1 do
          if VarToStr(Q270.Lookup('Codice',Strings[k],'CodInterno')) = traggrcauspr[1].C then
          begin
            strabana:='si';
            Break;
          end;
        Free;
      end;
      //limitazione giustificativi dalle..alle (TORINO_CSI_PRV)
      z1015_limitazione_giustdaa;
      //per il giorno non lavorativo causalizzazione automatica delle ore non causalizzate (TORINO_CSI_PRV)
      z1016_EsclusioneOreNonLav;
      //Cambio Tuta.ini
      z1018_CausalizzaInizioFineOrario;
      if (MaxFlex > 0) and (cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S') and EsisteTagTimbratura['CAUSALE_INIZIOORARIO'] then
      begin
        //Ricalcolo la flessibilità per orari a Turni e Flessibili, perchè potrebbe essere cambiata a causa della causalizzazione di inizio orario (tempo Tuta)
        if TipoOrario = 'E' then
          z030_flexorarE
        else if TipoOrario = 'A' then
          z088_flexorarA;
      end;
      //Cambio Tuta.fine
      //Gestione globale timbrature a coppie di E - U
      ieu:=1;
      //4.1
      while (ieu <= n_timbrdip) and (blocca = 0) do
      begin
        z100_coppieEU;
        inc(ieu);
      end;
      //4.0 - Conteggio della timbratura esclusa per l'indennità festiva
      if NotteSuEntrata then
      begin
        ieu:=n_timbrdip + 1;
        ttimbraturedip[ieu]:=timbraturaesclusa;
        z702_indnotmin;
        ttimbraturedip[ieu]:=ttimbraturedip_vuota;
      end;
      //Se previsto conteggio le ore fatte all'interno dei punti nominali
      //per mettere in compensazione quelle che eccedono il debito GG
      if blocca <> 0 then exit;
      //Eventuali detrazioni per causali di presenza con tipo
      //conteggio A ed esclusione dalle ore normali
      detrazioni:=mintipoAesc;
      z140_detrazioni(tminlav);
      //Gestione straordinario giornaliero ed eventuali detrazioni
      if (strgiorn <> 0) or (strarrdet <> 0) then
        z144_strgiornal;
      //Gestione straordinario giornaliero escluso dalle ore normali ed eventuali detrazioni
      if (strgiornEscl <> 0) or (strarrdetEscl <> 0) then
        z1144_strgiornalEscl;
      //Detrazioni da causali di presenza (Pausa Caffè) - Alberto 29/9/98
      //(23/02/2005: Spostato prima delle detrazioni mensa)
      detrazioni:=DetPresenza;
      z140_detrazioni(tminlav);
      DetPresenza:=0;
      //Eventuali detrazioni tipo pausa mensa F
      z141_detrmensaF;
      //Eventuali detrazioni tipo pausa mensa A o C o D o E
      z142_detrmensa;
      (*//Detrazioni da causali di presenza (Pausa Caffè) - Alberto 29/9/98
      detrazioni:=DetPresenza;
      z140_detrazioni(tminlav);
      DetPresenza:=0;*)
      //Arrotondamento giornaliero
      if c_orario <> '' then
        z198_arrgiornal;
      //Abbattimento ore rese per tipo Pausa Mensa F
      z143_abbattirientro;
      //Abbattimento ore rese nei punti nominali in modo che non eccedano il debito (MESSINA_UNIVERSITA)
      z145_puntinommax;
      //Strardinario dopo ore teoriche
      if (n_rieppres = 1) and (prolcaus <> '') and (triepgiuspres[1].tcauspres = prolcaus) then
        z208_strdopoteo;
      //Calcolo minuti attribuibili derivanti da turni lavorati
      if Q430.FieldByName('TGestione').AsString = '2' then
        z760_minattrtur;
      if ((ultimt_e = 'si') and (estimbsucc = 'si') and (verso_suc = 'U')) or
         ((primat_u = 'si') and (estimbprec = 'si') and (verso_pre = 'E')) then
        if (TipoOrario <> 'E') or (PeriodoLavorativo <> 'T1') then
        begin
          z098_anom2caus(33,'');
        end;
      z184_debiti;
      //GESTIONE GIUSTIFICATIVI E SALDI FINALI
      z000b;
    end;
  end;
end;

procedure TR502ProDtM1.AttivaGiutificativiPerPausaMensa;
{Cerco se ci sono giustificativi che devono innescare la pausa mensa;
 si insericsce una timbratura fittizia per innescare le procedure di calcolo della pausa mensa}
var k:Integer;
begin
  if GetGiustifPM then
  begin
    indice:=1;
    for k:=0 to High(GiustificativiDelGiorno) do
      if ValStrT265[GiustificativiDelGiorno[k].tcausgius,'VALSETIMB'] = 'S' then
        indice:=0;
    if (indice = 1) and (PausaMensa <> 'Z') then
    begin
      z816_insetimbr;
      ttimbraturedip[indice].tminutid_e:=InizioMensa;
      ttimbraturedip[indice].tminutid_u:=InizioMensa;
      ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
      ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
      ttimbraturedip[indice].tflagarr_u:='si';
      ttimbraturedip[indice].tflagarr_e:='si';
      ttimbraturedip[indice].tpuntnomin:=0;
      conteggi_sologiust:=True;
    end;
  end;
end;

procedure TR502ProDtM1.AttivaGiutificativiPerFlessibilita;
{Cerco se ci sono giustificativi che alterano la flessibilità;
 si insericsce una timbratura fittizia per innescare le procedure di calcolo della flessibilità}
var k,MinDalle:Integer;
begin
  MinDalle:=9999;
  //Cerco se ci sono giustificativi dalle..alle che devono alterano la flessibilità
  for k:=0 to High(GiustificativiDelGiorno) do
    if (ValStrT265[GiustificativiDelGiorno[k].tcausgius,'FLESSIBILITA_ORARIO'] = 'S') and (GiustificativiDelGiorno[k].ttipogius = 'D') then
      if MinDalle > GiustificativiDelGiorno[k].tdallegius then
        MinDalle:=GiustificativiDelGiorno[k].tdallegius;
  if MinDalle < 9999 then
  begin
    indice:=1;
    z816_insetimbr;
    ttimbraturedip[indice].tminutid_e:=MinDalle;
    ttimbraturedip[indice].tminutid_u:=MinDalle;
    ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
    ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
    ttimbraturedip[indice].tflagarr_u:='si';
    ttimbraturedip[indice].tflagarr_e:='si';
    ttimbraturedip[indice].tpuntnomin:=0;
    conteggi_sologiust:=True;
  end;
end;

//4.0
procedure TR502ProDtM1.GestioneTimbratureDipendente;
var TimbSucc:Boolean;
    TNU,TNR:Integer;
begin
  if ValStrT275[caus_suc,'FORZA_NOTTE_SPEZZATA'] = 'S' then
    exit;
  TimbSucc:=False;
  //Inclusione timbratura successiva se fatta nel giorno successivo
  if (ultimt_e = 'si') and (verso_suc = 'U') and (data_suc - datacon = 1) and (n_timbrdip > 0) then
  begin
    ttimbraturedip[n_timbrdip].tminutid_u:=1440 + minuti_suc;
    ttimbraturedip[n_timbrdip].trilev_u:=rilev_suc;
    ttimbraturedip[n_timbrdip].tcausale_u.tcaus:=caus_suc;
    TimbSucc:=True;
    AggiornaTimbratureOriginali(ttimbraturedip[n_timbrdip].tminutid_e,ttimbraturedip[n_timbrdip].tminutid_u);
  end
  //Alberto 10/01/2012 - con gestione dell'interno turno notturno si considera la timbratura successiva anche se è Entrata
  else if NotteSuEntrata_TurnoCompleto and (ultimt_e = 'no') and (verso_suc = 'E') and (data_suc - datacon = 1) and (TurnoNotturnoE.U > 1440 + minuti_suc) then
  begin
    inc(n_timbrdip);
    ttimbraturedip[n_timbrdip].tminutid_e:=1440 + minuti_suc;
    ttimbraturedip[n_timbrdip].tminutid_u:=1440 + minuti_suc;  //Chiudo subito la timbratura
    ttimbraturedip[n_timbrdip].trilev_e:=rilev_suc;
    ttimbraturedip[n_timbrdip].tcausale_e.tcaus:=caus_suc;
    ttimbraturedip[n_timbrdip].tflagarr_e:='no';
    ttimbraturedip[n_timbrdip].tpuntnomin:=0;
    TimbSucc:=True;
    AggiornaTimbratureOriginali(ttimbraturedip[n_timbrdip].tminutid_e,ttimbraturedip[n_timbrdip].tminutid_u);
  end;
  //Alberto 16/03/2012: Non considero i dati del giorno successivo se sono pianificati solo turni in uscita e non in entrata
  if (pianif = 'si') and (l08_turno1EU = 'U') and (l08_turno2EU <> 'E') then
    exit;
  if (pianif = 'si') and (l08_turno1EU <> 'E') and (l08_turno2EU = 'U') then
    exit;
  if NotteSuEntrata_TurnoCompleto and TimbSucc and ((n_timbrdip = 0) or (TurnoNotturnoE.U > ttimbraturedip[n_timbrdip].tminutid_u)) then
    //aggiunta timbrature del giorno successivo
    AggiornaTimbPerTurnoNotturno(TurnoNotturnoE.U(* + 1440*),TurnoNotturnoE.Ritardo);
  if NotteSuEntrata_TurnoCompleto then
  begin
    //aggiunta giustificativi dalle..alle del giorno successivo
    TNU:=TurnoNotturnoE.U;
    TNR:=TurnoNotturnoE.Ritardo;
    if (n_timbrdip > 0) and (ttimbraturedip[n_timbrdip].tminutid_u > 1440) then
    begin
      TNU:=Min(Max(TurnoNotturnoE.U,ttimbraturedip[n_timbrdip].tminutid_u),TurnoNotturnoE.U + TurnoNotturnoE.Ritardo);
      TNR:=TurnoNotturnoE.U + TurnoNotturnoE.Ritardo - TNU;
    end;
    AggiornaGiustifPerTurnoNotturno(TNU(* + 1440*),TNR);
  end;
end;

procedure TR502ProDtM1.AggiornaTimbratureOriginali(E,U:Integer);
var i,itd:Integer;
    Fatto:Boolean;
begin
  Fatto:=False;
  for i:=0 to High(TimbratureOriginali) do
    if TimbratureOriginali[i].E = E then
    begin
      TimbratureOriginali[i].U:=U;
      Fatto:=True;
      Break;
    end
    else if TimbratureOriginali[i].U = U then
    begin
      TimbratureOriginali[i].E:=E;
      Fatto:=True;
      Break;
    end;

  if not Fatto then
  begin
    i:=Length(TimbratureOriginali);
    SetLength(TimbratureOriginali,i + 1);
    TimbratureOriginali[i].E:=E;
    TimbratureOriginali[i].U:=U;
    for itd:=1 to n_timbrdip do
    begin
      if (ttimbraturedip[itd].tminutid_e = E) and (ttimbraturedip[itd].tminutid_u = U) then
      begin
        ttimbraturedip[itd].iOT:=i;
        Break;
      end;
    end;
  end;
end;

function TR502ProDtM1.EntrataOriginale(idx:Integer):Integer;
{Restituisce l'entrata della timbratura originale da cui ttimbraturedip[i] deriva}
begin
  Result:=0;
  if idx <= n_timbrdip then
  begin
    Result:=ttimbraturedip[idx].tminutid_e;
    //Per ora si attiva il riferimento alla timbratura originale solo se NotteSuEntrata_TurnoCompleto (XPARAM=TURNO_NOTTURNO)
    if NotteSuEntrata_TurnoCompleto then
    begin
      if R180Between(ttimbraturedip[idx].iOT,0,High(TimbratureOriginali)) then
        Result:=TimbratureOriginali[ttimbraturedip[idx].iOT].E;
    end;
  end;
end;

function TR502ProDtM1.UscitaOriginale(idx:Integer):Integer;
{Restituisce l'uscita della timbratura originale da cui ttimbraturedip[i] deriva}
begin
  Result:=0;
  if idx <= n_timbrdip then
  begin
    Result:=ttimbraturedip[idx].tminutid_u;
    //Per ora si attiva il riferimento alla timbratura originale solo se NotteSuEntrata_TurnoCompleto (XPARAM=TURNO_NOTTURNO)
    if NotteSuEntrata_TurnoCompleto then
    begin
      if R180Between(ttimbraturedip[idx].iOT,0,High(TimbratureOriginali)) then
        Result:=TimbratureOriginali[ttimbraturedip[idx].iOT].U;
    end;
  end;
end;

function TR502ProDtM1.TimbraturaIsolata(idx:Integer):Boolean;
var i:Integer;
begin
  Result:=False;
  for i:=0 to High(TimbratureOriginali) do
  begin
    if (TimbratureOriginali[i].e = ttimbraturedip[idx].tminutid_e) and
       (TimbratureOriginali[i].u = ttimbraturedip[idx].tminutid_u) then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

function TR502ProDtM1.TimbraturaCavalloMezzanotte(idx:Integer; Verso:String):Boolean;
begin
  if Verso = 'E' then
    Result:=(ttimbraturedip[idx].tminutid_e = 0) and (not NotteSuEntrata) and (primat_u = 'si') and (estimbprec = 'si') and (verso_pre = 'E')
  else if Verso = 'U' then
    Result:=(ttimbraturedip[idx].tminutid_u = 1440) and (not NotteSuEntrata) and (ultimt_e = 'si') and (estimbsucc = 'si') and (verso_suc = 'U');
end;

function TR502ProDtM1.ProporzionaPartTime(TipoProp:String; Value:Integer):Integer;
var locHHGiornaliere:Real;
begin
  Result:=Value;
  //La causale richiede proporzionamento per part-time della valorizzazione giornaliera
  if ValStrT265[causass,TipoProp] <> 'S' then
    exit;
  //La causale permette propozionamento delle competenze su part-time
  //if Pos('O',ValStrT265[causass,'PARTTIME']) = 0 then
  if (ValStrT265[causass,'PARTTIME'] = 'N') or (ValStrT265[causass,'PARTTIME'] = '') then
    exit;
  //percentuale di proporzionamento delle assenze ad ore per il part-time assegnato in anagrafico
  if not Q460.SearchRecord('Codice',Q430.FieldByName('PARTTIME').AsString,[srFromBeginning]) then
    exit;
  try
    //PTAssenzeHH:=Q460.FieldByName('ASSENZEHH').AsFloat / 100;
    locHHGiornaliere:=Q460.FieldByName('HHGIORNALIERE').AsFloat / 100;
    Result:=Round(Result * locHHGiornaliere);
  except
  end;
end;

//4.0
procedure TR502ProDtM1.DefinizioneTurnoNotturno;
{Riconoscimento della timbratura di smonto notte da considerare sul giorno attuale
 Esclusione delle prime timbrature del giorno, già conteggiate il giorno prima
 la durata della notte viene fatta considerando il turno notturno, i minuti di ritardo su Uscita,
 e l'eventuale turno di reperibilità notturno, se l'ultima/prima timbratura è causalizzata in reperibilità con controllo turni}
var TurnoRep,i,j,Ritardo:Integer;
    NTimbEscluse,FineNotte:Integer;
    TimbSalvate:array [1..MaxTimbrature] of t_ttimbraturedip;
begin
  //Ricerco l'ora di fine del turno notturno con relativo ritardo in FineNotte e Ritardo
  FineNotte:=0;
  Ritardo:=0;
  for i:=1 to n_timbrnom do
    if ttimbraturenom[i].tpuntre = 0 then
    begin
      FineNotte:=ttimbraturenom[i].tminutin_u;
      Ritardo:=ValNumT021['MMRitardoU',TF_PUNTI_NOMINALI,ttimbraturenom[i].tpuntru];
    end;
  if (FineNotte = 0) and (TurnoNotturnoU.Num <> -1) then
  begin
    FineNotte:=TurnoNotturnoU.U - 1440;
    Ritardo:=TurnoNotturnoU.Ritardo;//ValNumT021['MMRitardoU',TF_PUNTI_NOMINALI,ttimbraturenom[TurnoNotturno.Num].tpuntru];
  end;

  //Elimino giustificativi già conteggiati il giorno prima
  if NotteSuEntrata_TurnoCompleto and (n_timbrdip = 0) then
    EliminaGiustifPerTurnoNotturno('PRIMA',FineNotte,Ritardo)
  else if NotteSuEntrata_TurnoCompleto and not XParam['<GIUSTIF_TURNO_NOTTURNO>'] then
    EliminaGiustifPerTurnoNotturno('PRIMA',FineNotte,Ritardo);

  if n_timbrdip = 0 then
    exit;

  if (primat_u = 'si') and (ValStrT275[ttimbraturedip[1].tcausale_u.tcaus,'FORZA_NOTTE_SPEZZATA'] = 'S') then
    primat_u:='no';

  {Prima parte: limitazione timbrature relative allo smonto dal turno del giorno prima
   attenzione: Le chiamate in reperibilità con turno pianificato si devono conteggiare sul giorno attuale
   se NotteSuEntrata_TurnoCompleto si escludono tutte le timbrature fino a FineNotte + Ritardo
   altrimenti si esclude solo la prima timbratura
  }
  if NotteSuEntrata_TurnoCompleto and (ttimbraturedip[1].tminutid_e < FineNotte) and (ValStrT275[ttimbraturedip[1].tcausale_u.tcaus,'FORZA_NOTTE_SPEZZATA'] <> 'S') then
  begin
    //Accorcio FineNotte nel caso esistano turni di reperibilità pianificati con relative timbrature in reperibilità.
    //Queste timbrature devono essere conteggiate nel giorno effettivo
    TurnoRep:=9999;
    for i:=0 to High(TurniReperibilita) do
      if (TurniReperibilita[i].Data = datacon) and (TurniReperibilita[i].IT < TurnoRep) then
        TurnoRep:=TurniReperibilita[i].IT;
    if (TurnoRep < 9999) and (TurnoRep < FineNotte + Ritardo) then
      for i:=1 to n_timbrdip do
        if (ttimbraturedip[i].tminutid_e < FineNotte) and
           (ttimbraturedip[i].tminutid_u > TurnoRep) and
           (((ttimbraturedip[i].tcausale_u.tcaus <> '') and
             (ValStrT275[ttimbraturedip[i].tcausale_u.tcaus,'CODINTERNO'] = traggrcauspr[3].c) and
             (ValStrT275[ttimbraturedip[i].tcausale_u.tcaus,'PIANIFREP'] <> 'N'))
            or
            ((ttimbraturedip[i].tcausale_e.tcaus <> '') and
             (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'CODINTERNO'] = traggrcauspr[3].c) and
             (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'PIANIFREP'] <> 'N')))
        then
          begin
            FineNotte:=TurnoRep;//Modifico il punto di spezzamento delle timbrature
            Ritardo:=0;
            Break;
          end;
    //Alberto 10/01/2012 - Turno notturno completo: escludo tutte le timbrature fino a FineNotte + Ritardo
    timbraturaesclusa:=ttimbraturedip[1];
    NTimbEscluse:=0;
    //Segno da escludere tutte le coppie di timbrature che cominciano prima di FineNotte
    for i:=1 to n_timbrdip do
      //if (ttimbraturedip[i].tminutid_e < FineNotte) and (ttimbraturedip[i].tminutid_u <= FineNotte + Ritardo) then
      if (EntrataOriginale(i) < FineNotte) and (UscitaOriginale(i) <= FineNotte + Ritardo) then
      begin
        timbraturaesclusa.tminutid_u:=ttimbraturedip[i].tminutid_u;
        NTimbEscluse:=i;
      end
      //else if ttimbraturedip[i].tminutid_e < FineNotte then
      else if EntrataOriginale(i) < FineNotte then
      begin
        ttimbraturedip[i].tminutid_e:=FineNotte;
        Break;
      end;
    //Salvataggio e eliminazione timbrature precedenti già conteggiate
    for i:=1 to NTimbEscluse do
    begin
      TimbSalvate[i]:=ttimbraturedip[1];
      indice:=1;
      z802_toglitimbr;
    end;
    z060_appoggio(False);
    AggiornaRiepPresPerTurnoNotturno(FineNotte);
    EliminaGiustifPerTurnoNotturno('PRIMA',FineNotte,Ritardo);
  end
  else
  (**)
  if primat_u = 'si' then
  begin
    //11/02/2003 - considero il conteggio del giorno da FineNotte (+ Ritardo)
    //u:=TimbratureOriginali[0].u;
    timbraturaesclusa:=ttimbraturedip[1];
    NTimbEscluse:=1;
    //Segno da eslcudere tutte le timbrature 'interne' all'interno della prima
    for i:=1 to n_timbrdip do
      if ttimbraturedip[i].tminutid_u <= TimbratureOriginali[0].u then
      begin
        timbraturaesclusa.tminutid_u:=ttimbraturedip[i].tminutid_u;
        NTimbEscluse:=i;
      end
      else
        Break;
    //Salvataggio timbrature da eliminare (tranne l'ultima)
    for i:=1 to NTimbEscluse - 1 do
      TimbSalvate[i]:=ttimbraturedip[i];
    //Eliminazione timbrature precedenti già conteggiate: l'ultima può essere parzialmente conteggiata
    for i:=1 to NTimbEscluse - 1 do
    begin
      indice:=1;
      z802_toglitimbr;
    end;
    //Accorcio FineNotte nel caso esistano turni di reperibilità pianificati con relative timbrature in reperibilità.
    //Queste timbrature devono essere conteggiate nel giorno effettivo
    TurnoRep:=9999;
    for i:=0 to High(TurniReperibilita) do
      if (TurniReperibilita[i].Data = datacon) and (TurniReperibilita[i].IT < TurnoRep) then
        TurnoRep:=TurniReperibilita[i].IT;
    if (TurnoRep < 9999) and (TurnoRep < FineNotte + Ritardo) then
    begin
      if (ttimbraturedip[1].tminutid_u > TurnoRep) and
         (ttimbraturedip[1].tcausale_u.tcaus <> '') and
         (ValStrT275[ttimbraturedip[1].tcausale_u.tcaus,'CODINTERNO'] = traggrcauspr[3].c) and
         (ValStrT275[ttimbraturedip[1].tcausale_u.tcaus,'PIANIFREP'] <> 'N') then
      begin
        FineNotte:=TurnoRep;//Modifico il punto di spezzamento delle timbrature
        Ritardo:=0;
      end
      else
        for i:=1 to NTimbEscluse - 1 do
          if (TimbSalvate[i].tminutid_u > TurnoRep) and
             (TimbSalvate[i].tcausale_u.tcaus <> '') and
             (ValStrT275[TimbSalvate[i].tcausale_u.tcaus,'CODINTERNO'] = traggrcauspr[3].c) and
             (ValStrT275[TimbSalvate[i].tcausale_u.tcaus,'PIANIFREP'] <> 'N') then
          begin
            FineNotte:=TurnoRep;//Modifico il punto di spezzamento delle timbrature
            Ritardo:=0;
            Break;
          end;
    end;
    //Fine gestione reperibilità
    //if ttimbraturedip[1].tminutid_u > u then
    if ttimbraturedip[1].tminutid_u > FineNotte + Ritardo then
    begin
      //Verifico se rimettere in ballo le timbrature escluse (le chiamate in reperibilità devono essere conteggiate nel giorno attuale)
      for i:=NTimbEscluse - 1 downto 1 do
        if ttimbraturedip[1].tminutid_e < FineNotte then
          Break
        else
        begin
          //Se la prima timbratura è successiva a FineNotte includo quelle precedentemente eliminate che forse accavallano il FineNotte
          indice:=1;
          z816_insetimbr;
          ttimbraturedip[1]:=TimbSalvate[i];
          ttimbraturedip[1].tpuntnomin:=0;
        end;
      ttimbraturedip[1].tminutid_e:=FineNotte;
      ttimbraturedip[1].tminutid_u:=max(ttimbraturedip[1].tminutid_u,FineNotte);
      //Appoggiare la nuova timbratura???????
      //ttimbraturedip[1].tpuntnomin:=0;
      timbraturaesclusa.tminutid_u:=FineNotte;
    end
    else
    begin
      //comportamento 'normale': se ttimbraturedip[1].tminutid_u <= FineNotte + Ritardo la tolgo
      indice:=1;
      z802_toglitimbr;
    end;
    z060_appoggio(False);
  end;
  {Seconda parte: timbrature del giorno successivo. Limitazione timbrature relative allo smonto sul giorno successivo (caricate in GestioneTimbratureDipendente)
  considerando la fine del turno notturno, il ritardo e eventuale chiamate in reperibilità}
  //Rileggo la fine del turno notturno eventualmente prolungato per la flessibilità
  if TurnoNotturnoE.Num > 0 then
    if (TurnoNotturnoE.U) < (ttimbraturenom[TurnoNotturnoE.Num].tminutin_u) then
      TurnoNotturnoE.U:=ttimbraturenom[TurnoNotturnoE.Num].tminutin_u;
  if n_timbrdip = 0 then
    exit;
  //Limitazione ultima coppia di timbrature e ampliamento periodo da conteggiare (minutidalle..minutialle)
  if (ttimbraturedip[n_timbrdip].tminutid_u > 1440) and (TurnoNotturnoE.Num <> -1) then
  begin
    //Uscita + ritardo
    FineNotte:=TurnoNotturnoE.U;
    Ritardo:=TurnoNotturnoE.Ritardo;//ValNumT021['MMRitardoU',TF_PUNTI_NOMINALI,ttimbraturenom[TurnoNotturno.Num].tpuntru];
    TurnoRep:=9999;
    //Gestione della causale di reperibilità sull'uscita nel giorno successivo,
    //se il turno di rep. è pianificato sul giorno successivo
    if Q380.SearchRecord('DATA',datacon + 1,[srFromBeginning]) then
    begin
      for j:=1 to 3 do
        if Q350.SearchRecord('Codice',Trim(Q380.FieldByName('TURNO' + IntToStr(j)).AsString),[srFromBeginning]) then
          if R180OreMinuti(Q350.FieldByName('ORAINIZIO').AsDateTime) < TurnoRep then
            TurnoRep:=R180OreMinuti(Q350.FieldByName('ORAINIZIO').AsDateTime);
    end;
    if (TurnoRep + 1440 < FineNotte + Ritardo) and (TurnoRep < 9999) then
      if NotteSuEntrata_TurnoCompleto then
      begin
        for i:=1 to n_timbrdip do
          if (ttimbraturedip[i].tminutid_e < FineNotte) and
             (ttimbraturedip[i].tminutid_u > TurnoRep + 1440) and
             (((ttimbraturedip[i].tcausale_u.tcaus <> '') and
               (ValStrT275[ttimbraturedip[i].tcausale_u.tcaus,'CODINTERNO'] = traggrcauspr[3].c) and
               (ValStrT275[ttimbraturedip[i].tcausale_u.tcaus,'PIANIFREP'] <> 'N'))
              or
              ((ttimbraturedip[i].tcausale_e.tcaus <> '') and
               (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'CODINTERNO'] = traggrcauspr[3].c) and
               (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'PIANIFREP'] <> 'N'))) then
          begin
            FineNotte:=TurnoRep + 1440;
            Ritardo:=0;
          end;
      end
      else if (minuti_suc > TurnoRep) and (caus_suc <> '') and
              (ValStrT275[caus_suc,'CODINTERNO'] = traggrcauspr[3].c) and
              (ValStrT275[caus_suc,'PIANIFREP'] <> 'N') then
      begin
        FineNotte:=TurnoRep + 1440;
        Ritardo:=0;
      end;
    //Fine gestione reperibilità
    //Elimino timbrature che possono trovarsi oltre FineNotte, in base al ricalcolo per il turno di reperibilità
    if NotteSuEntrata_TurnoCompleto then
    begin
      for i:=n_timbrdip downto 1 do
        begin
          //if (ttimbraturedip[i].tminutid_e >= FineNotte) or (ttimbraturedip[i].tminutid_u > FineNotte + Ritardo) then
          if (EntrataOriginale(i) >= FineNotte) or (UscitaOriginale(i) > FineNotte + Ritardo) then
          begin
            indice:=i;
            z802_toglitimbr;
          end;
        end;
      //Elimino giustificativi dalle..alle che possono trovarsi oltre FineNotte, in base al ricalcolo per il turno di reperibilità
      EliminaGiustifPerTurnoNotturno('DOPO',FineNotte,Ritardo);
    end
    else
      for i:=n_timbrdip downto 1 do
        begin
          //if ttimbraturedip[i].tminutid_e >= FineNotte + Ritardo then
          if EntrataOriginale(i) >= FineNotte + Ritardo then
          begin
            indice:=i;
            z802_toglitimbr;
          end;
        end;
    if n_timbrdip > 0 then
    begin
      if ttimbraturedip[n_timbrdip].tminutid_u > FineNotte + Ritardo then
        ttimbraturedip[n_timbrdip].tminutid_u:=max(FineNotte,ttimbraturedip[n_timbrdip].tminutid_e);
      if ttimbraturedip[n_timbrdip].tminutid_u > minutialle then
        minutialle:=ttimbraturedip[n_timbrdip].tminutid_u;
    end;
  end;
  //verifico se esistono giustificativi dopo la mezzanotte caricati in AggiornaGiustifPerTurnoNotturno e da considerare nei conteggi
  if minutialle >= 1440 then
    for i:=1 to n_giusdaa do
      if tgius_dallealle[i].tminutia > minutialle then
        minutialle:=tgius_dallealle[i].tminutia;
  //Ampliamento fascia notturna
  if (fine1fascind = 1440) and (minutialle > 1440) then
    fine1fascind:=1440 + fine2fascind;

  //Aggiornamento riconoscimento ora legale/solare su timbrature del gg successivo
  if (not OraLegaleSolare.Cambio) and (datacon + 1 = OraLegaleSolare.Data) then
  begin
    for i:=1 to n_timbrdip do
    begin
      if ttimbraturedip[i].tminutid_u > 1440 then
      begin
        if (ttimbraturedip[i].tminutid_e < OraLegaleSolare.OraVecchia) and
           (ttimbraturedip[i].tminutid_u >= OraLegaleSolare.OraNuova) and
           (MinutiDalle < OraLegaleSolare.OraVecchia) and
           (MinutiAlle >= OraLegaleSolare.OraVecchia) then
        begin
          ttimbraturedip[i].oralegsol:=True;
          OraLegaleSolare.Cambio:=True;
          z098_anom2caus(63,Format('%s-%s',[R180MinutiOre(ttimbraturedip[i].tminutid_e - IfThen(ttimbraturedip[i].tminutid_e < 1440,0,1440)),R180MinutiOre(ttimbraturedip[i].tminutid_u - 1440)]));
          Break;
        end;
      end;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.AggiornaTimbPerTurnoNotturno(FineNotte,Ritardo:Integer);
{Caricamento timbrature del giorno successivo che ricadono prima di FineNotte}
var Verso:String;
  function AppartieneTurnoNotturno(mm:Integer):Boolean;
  begin
    Result:=True;
    mm:=mm - 1440;
    cdsT021.First;
    while not cdsT021.Eof do
    begin
      if cdsT021.FieldByName('TIPO_FASCIA').AsString = 'PN' then
      begin
        if (ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,-1] >= TurnoNotturnoE.U - 1440) and
           (mm >= ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,-1] - ValNumT021['MMANTICIPO',TF_PUNTI_NOMINALI,-1]) then
        begin
          Result:=False;
          Break;
        end;
      end;
      cdsT021.Next;
    end;
  end;
begin
  Q100.Filtered:=False;
  if Q100.GetVariable('AData') < datacon + 1 then
    R180SetVariable(Q100,'AData',datacon + 1);
  Q100.Open;
  if Q100.SearchRecord('DATA',datacon + 1,[srFromBeginning]) then
  begin
    Verso:=Q100.FieldByName('VERSO').AsString;
    if Verso = 'E' then
      indice:=n_timbrdip
    else
      indice:=0;
    Q100.Next;
    while not Q100.Eof do
    begin
      if Q100.FieldByName('DATA').AsDateTime > datacon + 1 then
        Break;
      if Q100.FieldByName('VERSO').AsString = Verso then
        Break;
      Verso:=Q100.FieldByName('VERSO').AsString;
      if Q100.FieldByName('VERSO').AsString = 'E' then
      begin
        if R180OreMinuti(Q100.FieldByName('ORA').AsDateTime) >= (TurnoNotturnoE.U - 1440) then
          Break;
        indice:=n_timbrdip + 1;
        z816_insetimbr;
        ttimbraturedip[indice].tminutid_e:=R180OreMinuti(Q100.FieldByName('ORA').AsDateTime) + 1440;
        ttimbraturedip[indice].tminutid_u:=R180OreMinuti(Q100.FieldByName('ORA').AsDateTime) + 1440;
        ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
        ttimbraturedip[indice].tcausale_e.tcaus:=Q100.FieldByName('CAUSALE').AsString.Trim;
        ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
        ttimbraturedip[indice].tflagarr_e:='no';
        ttimbraturedip[indice].tflagarr_u:='no';
        ttimbraturedip[indice].tpuntnomin:=0;
      end
      else if indice > 0 then
      begin
        ttimbraturedip[indice].tminutid_u:=R180OreMinuti(Q100.FieldByName('ORA').AsDateTime) + 1440;
        ttimbraturedip[indice].tcausale_u.tcaus:=Q100.FieldByName('CAUSALE').AsString.Trim;
        if (ttimbraturedip[indice].tminutid_e >= 1440) and
           (not R180In(ValStrT275[ttimbraturedip[indice].tcausale_e.tcaus,'TIPOCONTEGGIO'],['A','E'])) and
           (ttimbraturedip[indice].tminutid_u > TurnoNotturnoE.U) and
           (not AppartieneTurnoNotturno(ttimbraturedip[indice].tminutid_e))
        then
        begin
          z802_toglitimbr;
          Break;
        end
        else if ttimbraturedip[indice].tminutid_u <= TurnoNotturnoE.U + TurnoNotturnoE.Ritardo then
          minutialle:=ttimbraturedip[indice].tminutid_u
        else
          minutialle:=TurnoNotturnoE.U;
        TurnoNotturnoE.TimbGGDopo:=True;
        AggiornaTimbratureOriginali(ttimbraturedip[indice].tminutid_e,ttimbraturedip[indice].tminutid_u);
      end;
      Q100.Next;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.AggiornaGiustifPerTurnoNotturno(FineNotte,Ritardo:Integer);
{Caricamento giustificativi dalle..alle del giorno successivo che ricadono prima di FineNotte}
begin
  datacon:=datacon + 1;
  try
    z916_startgiust;
    while (s_trovato = 'si') and (datacon = Q040.FieldByName('Data').AsDateTime) do
    begin
      if (Q040TipoGiust.AsString = 'D') and (R180OreMinuti(Q040DaOre.AsDateTime) < FineNotte - 1440) and (R180OreMinuti(Q040AOre.AsDateTime) <= FineNotte + Ritardo - 1440) then
      begin
        z436_giustcarica(False,True);
      end;
      z918_leggigiust;
    end;
  finally
    datacon:=datacon - 1;
    z916_startgiust;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.AggiornaRiepPresPerTurnoNotturno(FineNotte:Integer);
{Aggiorno eventuali riepiloghi di presenza già valorizzati per effetto di causali su U-E (z072_tipoconA)
 La regola è che le coppie E-U non possono superare FineNotte}
var i,j,k:Integer;
    Modif:Boolean;
    riepgiuspres:t_triepgiuspres;
begin
  for i:=1 to n_rieppres do
  begin
    Modif:=False;
    //Leggo parametri della causale
    z964_leggicaus(triepgiuspres[i].tcauspres);
    if (s_trovato = 'si') and (parcaus.l29_1paramet = 'B') then
      z965_SettaCausPres(tcausale);
    //Correggo coppie E-U in modo che non possano mai superare FineNotte
    for j:=0 to High(triepgiuspres[i].CoppiaEU) do
      if triepgiuspres[i].CoppiaEU[j].e < FineNotte then
      begin
        Modif:=True;
        if tcausale.tcausioe = 'A' then
          z125_delTimbtipoAesc(triepgiuspres[i].CoppiaEU[j].e,triepgiuspres[i].CoppiaEU[j].u);
        triepgiuspres[i].CoppiaEU[j].e:=FineNotte;
        triepgiuspres[i].CoppiaEU[j].u:=max(triepgiuspres[i].CoppiaEU[j].u,triepgiuspres[i].CoppiaEU[j].e);
      end;
    //Ricalcolo ore rese per questa causale
    if Modif then
    begin
      //Resetto ore rese
      for j:=1 to High(triepgiuspres[i].tminpres) do
      begin
        if tcausale.tcausioe = 'A' then
          dec(mintipoAesc,triepgiuspres[i].tminpres[j]);
        triepgiuspres[i].tminpres[j]:=0;
      end;
      //Resetto CoppiaEU salvandole prima in riepgiuspres
      riepgiuspres:=triepgiuspres[i];
      SetLength(riepgiuspres.CoppiaEU,0);
      k:=-1;
      for j:=0 to High(triepgiuspres[i].CoppiaEU) do
        if triepgiuspres[i].CoppiaEU[j].e < triepgiuspres[i].CoppiaEU[j].u then
        begin
          inc(k);
          SetLength(riepgiuspres.CoppiaEU,k + 1);
          riepgiuspres.CoppiaEU[k].e:=triepgiuspres[i].CoppiaEU[j].e;
          riepgiuspres.CoppiaEU[k].u:=triepgiuspres[i].CoppiaEU[j].u;
        end;
      SetLength(triepgiuspres[i].CoppiaEU,0);
      riepcaus:=tcausale.tcaus;
      riepcausrag:=tcausale.tcauscodrag;
      riepcausrip:=tcausale.tcausrip;
      riepcausioe:=tcausale.tcausioe;
      for j:=0 to High(riepgiuspres.CoppiaEU) do
      begin
        riepcaus_e:=riepgiuspres.CoppiaEU[j].e;
        riepcaus_u:=riepgiuspres.CoppiaEU[j].u;
        riepcausOreGettone:=0;
        riepcaus_numtimb:=0;
        z810_rieppres(tcausale.tmaxminuti);
        if tcausale.tcausioe = 'A' then
        begin
          //Esclusione dalle ore normali
          inc(mintipoAesc,riepcaus_u - riepcaus_e);
          z124_InsTimbtipoAesc(riepcaus_e,riepcaus_u);
        end;
      end;
    end;
  end;
  //Elimino riepiloghi con 0 ore
  for i:=n_rieppres downto 1 do
    if R180SommaArray(triepgiuspres[i].tminpres) = 0 then
    begin
      for j:=i to n_rieppres - 1 do
        triepgiuspres[j]:=triepgiuspres[j + 1];
      dec(n_rieppres);
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.EliminaGiustifPerTurnoNotturno(Modalita:String; FineNotte,Ritardo:Integer);
{Elimino i giustificativi dalle..alle che ricadono prima di FineNotte}
var i,j:Integer;
    Condizione:Boolean;
begin
  for i:=High(GiustificativiDelGiorno) downto 0 do
  begin
    if Modalita = 'PRIMA' then
      Condizione:=(GiustificativiDelGiorno[i].ttipogius = 'D') and (GiustificativiDelGiorno[i].tdallegius < FineNotte) and (GiustificativiDelGiorno[i].tallegius <= FineNotte + Ritardo)
    else
      Condizione:=(GiustificativiDelGiorno[i].ttipogius = 'D') and (GiustificativiDelGiorno[i].tallegius > FineNotte + Ritardo);
    if Condizione then
    begin
      for j:=i to High(GiustificativiDelGiorno) - 1 do
        GiustificativiDelGiorno[j]:=GiustificativiDelGiorno[j + 1];
      SetLength(GiustificativiDelGiorno,Length(GiustificativiDelGiorno) - 1);
    end;
  end;
  for i:=n_giusdaa downto 1 do
  begin
    if Modalita = 'PRIMA' then
      Condizione:=(tgius_dallealle[i].tminutida < FineNotte) and (tgius_dallealle[i].tminutia <= FineNotte + Ritardo)
    else
      Condizione:=(tgius_dallealle[i].tminutia > FineNotte + Ritardo);
    if Condizione then
    begin
      for j:=i to n_giusdaa - 1 do
        tgius_dallealle[j]:=tgius_dallealle[j + 1];
      dec(n_giusdaa);
    end;
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.EsisteTurnoNotturnoPianificato:Boolean;
begin
  Result:=False;
  if pianif = 'no' then
    exit;
  if cdsT020.FieldByName('FLEXDOPOMEZZANOTTE').AsString = 'N' then
  begin
    //Condizione standard --> attenzione che turnicavmez non è sempre valorizzato! Si dovrebbe optare per la condizione innescata da <FLEXDOPOMEZZANOTTE>
    Result:=((pianif = 'si') and (turnicavmez = 'si') and (l08_turno1EU <> ''));
    exit;
  end;
  if (l08_turno1 >= 1) and (l08_turno1EU <> '') and (ValStrT021['ENTRATA',TF_PUNTI_NOMINALI,l08_turno1] <> '') then
  begin
    if ValNumT021['ENTRATA',TF_PUNTI_NOMINALI,l08_turno1] >= ValNumT021['USCITA',TF_PUNTI_NOMINALI,l08_turno1] then
    begin
      Result:=True;
      exit;
    end;
  end;
  if (l08_turno2 >= 1) and (l08_turno2EU <> '') and (ValStrT021['ENTRATA',TF_PUNTI_NOMINALI,l08_turno2] <> '') then
    if ValNumT021['ENTRATA',TF_PUNTI_NOMINALI,l08_turno2] >= ValNumT021['USCITA',TF_PUNTI_NOMINALI,l08_turno2] then
    begin
      Result:=True;
      exit;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z008_GestioneAnomalie;
{Gestione anomalie bloccanti}
var i:Integer;
  procedure ApplicaFiltroAnomalie;
  var i,j:Integer;
  begin
    i:=0;
    while i <= High(tanom2riscontrate) do
    begin
      //PALERMO_UNIVERSITA: Anomalia bloccante //Parametro su Modello orario con elenco di anomalie 2/3 che devono essere bloccanti
      tanom2riscontrate[i].ta2bloccante:=False;
      if (Blocca = 0) and R180In('2_' + tanom2riscontrate[i].ta2puntdesc.ToString,cdsT020.FieldByName('ANOM_BLOCC_23LIV').AsString.Split([','])) then
      begin
        Blocca:=25;
        tanom2riscontrate[i].ta2bloccante:=True;
        inc(i);
      end
      else if FiltroDizionarioAnomalie and not A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A2_' + IntToStr(tanom2riscontrate[i].ta2puntdesc)) then
      begin
        for j:=i to High(tanom2riscontrate) - 1 do
          tanom2riscontrate[j]:=tanom2riscontrate[j + 1];
        SetLength(tanom2riscontrate,Length(tanom2riscontrate) - 1);
      end
      else
        inc(i);
    end;
    i:=0;
    while i <= High(tanom3riscontrate) do
    begin
      //PALERMO_UNIVERSITA: Anomalia bloccante //Parametro su Modello orario con elenco di anomalie 2/3 che devono essere bloccanti
      tanom3riscontrate[i].ta3bloccante:=False;
      if (Blocca = 0) and R180In('3_' + tanom3riscontrate[i].ta3puntdesc.ToString,cdsT020.FieldByName('ANOM_BLOCC_23LIV').AsString.Split([','])) then
      begin
        Blocca:=26;
        tanom3riscontrate[i].ta3bloccante:=True;
        inc(i);
      end
      else if FiltroDizionarioAnomalie and not A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A3_' + IntToStr(tanom3riscontrate[i].ta3puntdesc)) then
      begin
        for j:=i to High(tanom3riscontrate) - 1 do
          tanom3riscontrate[j]:=tanom3riscontrate[j + 1];
        SetLength(tanom3riscontrate,Length(tanom3riscontrate) - 1);
      end
      else
        inc(i);
    end;
  end;

  procedure PutAnomalieGG;
  var AnomalieGG:TAnomalieGG;
      i:Integer;
      S,Anom23Bloccante:String;
  begin
    lstAnomalieGG.Clear;
    Anom23Bloccante:='';
    if Blocca <> 0 then
    begin
      AnomalieGG.Data:=datacon;
      AnomalieGG.Livello:=1;
      AnomalieGG.Num:=Blocca;
      AnomalieGG.Id:=AnomalieGG.Livello.ToString + '_' + AnomalieGG.Num.ToString;
      AnomalieGG.LivNum:=AnomalieGG.Id;
      AnomalieGG.Descrizione:=tdescanom1[Blocca].D;
      lstAnomalieGG.Add(AnomalieGG);
    end;
    for i:=0 to High(tanom2riscontrate) do
    begin
      S:='';
      if tdescanom2[tanom2riscontrate[i].ta2puntdesc].F = 1 then
        S:=tanom2riscontrate[i].ta2caus + ':';
      S:=S + tdescanom2[tanom2riscontrate[i].ta2puntdesc].D;
      AnomalieGG.Descrizione:=S;
      tanom2riscontrate[i].ta2testo:=AnomalieGG.Descrizione;
      if tanom2riscontrate[i].ta2bloccante then
        Anom23Bloccante:=S;
      AnomalieGG.Data:=datacon;
      AnomalieGG.Livello:=2;
      AnomalieGG.Num:=tanom2riscontrate[i].ta2puntdesc;
      AnomalieGG.Id:=AnomalieGG.Livello.ToString + '_' + AnomalieGG.Num.ToString;
      AnomalieGG.LivNum:=AnomalieGG.Id;
      lstAnomalieGG.Add(AnomalieGG);
    end;
    for i:=0 to High(tanom3riscontrate) do
    begin
      S:='';
      if tanom3riscontrate[i].ta3puntdesc in [4,6] then
        S:=tdescanom3[tanom3riscontrate[i].ta3puntdesc].D + ' per ' + R180MinutiOre(tanom3riscontrate[i].ta3timb) + ' ore: ' + tanom3riscontrate[i].ta3desc
      else
        S:=tdescanom3[tanom3riscontrate[i].ta3puntdesc].D + IfThen(tanom3riscontrate[i].ta3timb >= 0,':' + R180MinutiOre(tanom3riscontrate[i].ta3timb));
      case Length(tanom3riscontrate[i].ta3param) of
        0:AnomalieGG.Descrizione:=S;
        1:AnomalieGG.Descrizione:=Format(S,[tanom3riscontrate[i].ta3param[0]]);
        2:AnomalieGG.Descrizione:=Format(S,[tanom3riscontrate[i].ta3param[0],tanom3riscontrate[i].ta3param[1]]);
      end;
      tanom3riscontrate[i].ta3testo:=AnomalieGG.Descrizione;
      if tanom3riscontrate[i].ta3bloccante then
        Anom23Bloccante:=AnomalieGG.Descrizione;
      AnomalieGG.Data:=datacon;
      AnomalieGG.Livello:=3;
      AnomalieGG.Num:=tanom3riscontrate[i].ta3puntdesc;
      AnomalieGG.Id:=AnomalieGG.Livello.ToString + '_' + AnomalieGG.Num.ToString + '_' + i.ToString;
      AnomalieGG.LivNum:=AnomalieGG.Livello.ToString + '_' + AnomalieGG.Num.ToString;
      lstAnomalieGG.Add(AnomalieGG);
    end;
    if Anom23Bloccante <> '' then
      for i:=0 to lstAnomalieGG.Count - 1 do
      begin
        if lstAnomalieGG[i].Livello = 1 then
        begin
          AnomalieGG:=lstAnomalieGG[i];
          AnomalieGG.Descrizione:=Anom23Bloccante;
          lstAnomalieGG[i]:=AnomalieGG;
          Break;
        end;
      end;
  end;
begin
  if bloccatimb <> 0 then
    blocca:=bloccatimb;

  ApplicaFiltroAnomalie;
  PutAnomalieGG;

  if blocca = 0 then exit;
  if debitogg > 0 then
  begin
    // daniloc. 21.04.2010
    //debitorp:=debitogg

    // imposta debito da riepilogo = debito giornaliero
    // solo se il debito mensile non è da calendario,
    if (Q430.FieldByName('HTeoriche').AsString <> '2') and
       (Q430.FieldByName('HTeoriche').AsString <> '3') then
      debitorp:=debitogg;
  // daniloc. 21.04.2010
  end
  else
    if debitorp > 0 then
      debitogg:=debitorp
    else
      if blocca = 4 then
        begin
        debitogg:=0;
        debitorp:=0;
        debitodaorario:=0;
        end
      else
        begin
        debitogg:=480;
        debitorp:=480;
        debitodaorario:=480;
        end;
  totlav:=0;
  for i:=Low(tminlav) to High(tminlav) do tminlav[i]:=0;
  for i:=Low(tminstrgio) to High(tminstrgio) do tminstrgio[i]:=0;
  debitopo:=0;
  scost:=-debitogg;
  minpresenzelorde:=0;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z010_azziniz;
{Azzeramenti iniziali variabili di output}
var xx:Integer;
begin
  blocca:=0;
  c_orario:='';
  c_turni1:=-1;
  c_turni2:=-1;
  c_valorgior:='';
  r_turno1:=-1;
  r_turno2:=-1;
  pianif_z550:=False;
  oreteoturni:=0;
  n_anom2:=-1;
  turnicavmez:='no';
  CausaleDisabilBloccante:=False;
  n_anom3:=-1;
  SetLength(tanom2riscontrate,0);
  SetLength(tanom3riscontrate,0);
  n_timbrcon:=0;
  n_rieppres:=0;
  n_riepasse:=0;
  ggvuoto:=0;
  ggvuoto_turnista:=0;
  ggpresenza:=0;
  minuti_pre_caus:=-1;
  for xx:=Low(TMinLav) to High(TMinLav) do TMinLav[xx]:=0;
  for xx:=Low(tminstrgio) to High(tminstrgio) do tminstrgio[xx]:=0;
  for xx:=Low(tminstrgio1) to High(tminstrgio1) do tminstrgio1[xx]:=0;
  for xx:=Low(tminstrgio2) to High(tminstrgio2) do tminstrgio2[xx]:=0;
  for xx:=Low(tminstrgio3) to High(tminstrgio3) do tminstrgio3[xx]:=0;
  for xx:=Low(tminstrgio4) to High(tminstrgio4) do tminstrgio4[xx]:=0;
  for xx:=Low(trieprilev) to High(trieprilev) do
  begin
    trieprilev[xx].rilevatore:='';
    trieprilev[xx].tminprestot:=0;
  end;
  for xx:=Low(triepgiusasse) to High(triepgiusasse) do
  begin
    triepgiusasse[xx].tcausasse:='';
    triepgiusasse[xx].tfiniretr:=0;
    triepgiusasse[xx].tggasse:=0;
    triepgiusasse[xx].thhmmasse:=0;
    triepgiusasse[xx].tmezggasse:=0;
    triepgiusasse[xx].tminasse:=0;
    triepgiusasse[xx].tminresasse:=0;
    triepgiusasse[xx].tminvalasse:=0;
    triepgiusasse[xx].tminvalcompasse:=0;
    triepgiusasse[xx].tminfruizasse:=0;
    triepgiusasse[xx].tminfruitoPaghe:=0;
    triepgiusasse[xx].tminresoPaghe:=0;
    triepgiusasse[xx].traggasse:='';
    triepgiusasse[xx].tumisurasse:='';
    triepgiusasse[xx].ttipofruiz:='';
    triepgiusasse[xx].GiornoDopo:=False;
    triepgiusasse[xx].DataFamiliare:=0;
  end;
  indfesint:=0;
  indfesrid:=0;
  indnotgg:=0;
  indnotmin:=0;
  for xx:=Low(TIndTurFas) to High(TIndTurFas) do TIndTurFas[xx]:=0;
  indnot_lorda.Arr:=0;
  indnot_lorda.Ore:=0;
  indnot_lorda.Toll:=0;
  for xx:=1 to MaxFasceGio do indnot_lorda.EccGio[xx]:=0;
  n_turno1:=0;
  n_turno2:=0;
  s_turno1:='';
  s_turno2:='';
  tindennitapresenza[1].tindpres:=0;
  tindennitapresenza[2].tindpres:=0;
  tindennitapresenza[3].tindpres:=0;
  debitogg:=0;
  debitorp:=0;
  debitoor:=0;
  debitopo:=0;
  debitodaorario:=0;
  scostamentodebito:=0;
  debitopo_percpt:=0;
  detrdebitopo:=0;
  tipogespo:=#0;
  tollergod:=0;
  eccsolocomp:=0;
  EccSoloCompGG:=0;
  EccSoloCompOltreSoglia:=0;
  scostfascia:=0;
  minassenze:=0;
  minpresenzelorde:=0;
  minabbstr:=0;
  totlav:=0;
  scost:=0;
  scostneg:=0;
  CompNeg_UNonCaus:=0;
  minattrib:=0;
  MinRicalcoloFest:=0;
  //tflaggiusasse:=0;  Valduce
  debitoposv:='N';
  //Azzeramenti iniziali variabili locali
  bloccatimb:=0;
  n_timbrnom:=0;
  n_timbrdip:=0;
  for xx:=Low(ttimbraturedip) to High(ttimbraturedip) do
    ttimbraturedip[xx]:=ttimbraturedip_vuota;
  with IntervalloUscita do
  begin
    OraOriginale:=-1;
    OraNuova:=-1;
  end;
  if esegui_z430 then
  begin
    n_giusdaa:=0;
    n_giusore:=0;
    n_giusmga:=0;
    n_giusgga:=0;
  end;
  paumencont:=0;
  paumencont_nonrese:=0;
  paumendet:=0;
  paumendet_resto:=0;
  paumendet_rieppres:=0;
  paumendet_strgiorn:=0;
  paumendet_oreesc:=0;
  conteggi_sologiust:=False;
  paumentimb_u:=0;
  paumentimb_e:=1440;
  paumenFatta:=0;
  primaVolta_z148:=True;
  rec_psicofisico:=0;
  detrazstr:=0;
  DetrazStraord:=0;
  FDetrazTotLav:=0;
  strarrdet:=0;
  strarrdetEscl:=0;
  strminimidet:=0;
  strgiorn:=0;
  strgiornEscl:=0;
  for xx:=Low(tflexu) to High(tflexu) do tflexu[xx]:=0;
  for xx:=Low(tritflex) to High(tritflex) do tritflex[xx]:=0;
  minlavesc:=0;
  mintipoAesc:=0;
  minlavfes:=0;
  minlavfes_nottecompletaCorr:=0;
  minlavfes_nottecompletaSucc:=0;
  minlavfes_nottecompletaPrec:=0;
  indfes_lorda.Debito:=0;
  indfes_lorda.Ore:=0;
  for xx:=1 to MaxFasceGio do indfes_lorda.EccGio[xx]:=0;
  minlavmat:=0;
  minlavpom:=0;
  minlavpresoggi:=0;
  minlavprescav:=0;
  minlavorar:=0;
  turnonott:=0;
  debfrazmatt:=0;
  debfrazsera:=0;
  debnoncav:=0;
  primat_u:='no';
  ultimt_e:='no';
  orelav24:='no';
  estimbprec:='no';
  estimbsucc:='no';
  paumenges:='no';
  TipoDetPaumen:='';
  paumenTimbNonGes:=False;
  indabiulttim:='no';
  indpresdaass:='no';
  timbfac:='no';
  orarioacq:='no';
  timbraacq:='no';
  monteorelet:='no';
  prolcaus:='';
  gginser:=0;
  gglavser:=0;
  ripcom:=0;
  debitorp_ripcom:=0;
  matura_ripcom:=True;
  abbannoprec:=0;
  abbannoatt:=0;
  abbliqannoprec:=0;
  abbliqannoatt:=0;
  abbBancaOre:=0;
  abbripcom:=0;
  ggpres:=0;
  ggpomer:=0;
  minlavincfor:=0;
  minasscomp:=0;
  DetTeoMensa:=0;
  DetPresenza:=0;
  TollPMUtilizzata:=0;
  OraLegaleSolare.Cambio:=False;
  OraLegaleSolare.Data:=EncodeDate(1900,1,1);
  OraLegaleSolare.Diff:=0;
  OraLegaleSolare.OraNuova:=0;
  OraLegaleSolare.OraVecchia:=0;
  //4.0
  NotteSuEntrata:=False;
  TurnoNotturno.E:=0;
  TurnoNotturno.U:=0;
  TurnoNotturno.Ritardo:=0;
  TurnoNotturno.Num:=-1;
  TurnoNotturno.TimbGGDopo:=False;
  TurnoNotturnoE.E:=0;
  TurnoNotturnoE.U:=0;
  TurnoNotturnoE.Ritardo:=0;
  TurnoNotturnoE.Num:=-1;
  TurnoNotturnoE.TimbGGDopo:=False;
  TurnoNotturnoU.E:=0;
  TurnoNotturnoU.U:=0;
  TurnoNotturnoU.Ritardo:=0;
  TurnoNotturnoU.Num:=-1;
  TurnoNotturnoU.TimbGGDopo:=False;
  // daniloc.ini - sostituiti da property
  //ProlungamentoNonCausalizzato:=0;
  //ProlungamentoInibito:=0;
  //ProlungamentoNonCausUscita:=0;
  for xx:=Low(SpezzoniNonAbilitati) to High(SpezzoniNonAbilitati) do
  begin
    SpezzoniNonAbilitati[xx].TipoAbil:='';
    SpezzoniNonAbilitati[xx].TipoSpez:='';
    SpezzoniNonAbilitati[xx].Inizio:=0;
    SpezzoniNonAbilitati[xx].Fine:=0;
    SpezzoniNonAbilitati[xx].Durata:=0;
  end;
  SetLength(SpezzoniNonAbilitati,0);
  // daniloc.fine
  timbraturaesclusa:=ttimbraturedip_vuota;
  SetLength(GiustificativiDelGiorno,0);
  SetLength(TimbratureDelGiorno,0);
  for xx:=Low(CodTurniReperibilita) to High(CodTurniReperibilita) do
  begin
    CodTurniReperibilita[xx].Tipo:='';
    CodTurniReperibilita[xx].Turno1.Codice:='';
    CodTurniReperibilita[xx].Turno1.Inizio:=0;
    CodTurniReperibilita[xx].Turno1.Fine:=0;
    CodTurniReperibilita[xx].Turno1.Durata:=0;
    CodTurniReperibilita[xx].Turno2.Codice:='';
    CodTurniReperibilita[xx].Turno2.Inizio:=0;
    CodTurniReperibilita[xx].Turno2.Fine:=0;
    CodTurniReperibilita[xx].Turno2.Durata:=0;
    CodTurniReperibilita[xx].Turno3.Codice:='';
    CodTurniReperibilita[xx].Turno3.Inizio:=0;
    CodTurniReperibilita[xx].Turno3.Fine:=0;
    CodTurniReperibilita[xx].Turno3.Durata:=0;
  end;
  SetLength(CodTurniReperibilita,0);
  for xx:=Low(OreCausali276) to High(OreCausali276) do OreCausali276[xx]:=0;
  for xx:=Low(FascePaghe276) to High(FascePaghe276) do
  begin
    FascePaghe276[xx].Ore:=0;
    FascePaghe276[xx].VocePaghe:='';
  end;
  //SetLength(OreCausali276,0);
  //SetLength(FascePaghe276,0);
  for xx:=1 to High(triepgiuspres) do
    SetLength(triepgiuspres[xx].CoppiaEU,0);
  SetLength(TimbratureOriginali,0);
  SetLength(Gettoni,0);
  SetLength(timbtipoAesc,0);
  SetLength(TimbratureMensa,0);
  SetLength(RiepLibProf,0);
  SetLength(CdzAbilitazione,0);
  RicalcoloMaxScostPos:=-1;
  CarenzaObbligatoria:=0;
  CarenzaFacoltativa:=0;
  PresenzaObbligatoria:=0;
  PresenzaFacoltativa:=0;
  ScostFacoltativa:=0;
  AbbatteCausPres:=0;
  CoperturaCarenza:=0;
  ResoSett:=0;
  DebSett:=0;
  FestivoNonGoduto:=0;
  CausaliPuntiNominali277:='';
  z496Eseguito:=False;
  RientroPomeridiano.TotLav:=0;
  RientroPomeridiano.Obbl:=0;
  RientroPomeridiano.Suppl:=0;
  RientroPomeridiano.BuonoPastoObbl:=0;
  RientroPomeridiano.BuonoPastoSuppl:=0;
  RientroPomeridiano.MaxU:=0;
  RientroPomeridiano.MaxUTimb:=0;
  RientroPomeridiano.PausaMensa:=0;
  RientroPomeridiano.LavDopoMensa:=0;
  RientroPomeridiano.LavPrimaMensaTimb:=0;
  RientroPomeridiano.LavDopoMensaTimb:=0;
  CRV_PMT_MNGiustE:=9999;
  CRV_PMT_MNGiustU:=0;
  Q320AfterOpen(Q320);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z020_datainiz;
{Operazioni iniziali su data conteggio - Capovolgimento data conteggio}
begin
  DecodeDate(DataCon,DataCon_aa,DataCon_mm,DataCon_gg);
  //Calcolo numero corrispondente
  numcorr:=Trunc(datacon);  //Perdo la parte decimale
  //Calcolo giorno della settimana
  //Poichè la funz. restituisce Domenica = 1, Lunedi= 2, ecc, passo il
  //giorno precedente per avere la compatibilità
  giorsett:=DayOfWeek(datacon - 1);
  z980_leggioralegalesolare;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z022_calend;
{Lettura tipo giorno da calendario del dipendente}
begin
  z922_leggicalen(datacon - 1,TipoGG_prec,TipoGGLav_prec);
  z922_leggicalen(datacon + 1,TipoGG_suc,TipoGGLav_suc);
  z922_leggicalen(datacon + 2,TipoGG_suc2,TipoGGLav_suc2);
  z922_leggicalen(datacon,TipoGG,tipogglav);
  if s_trovato <> 'si' then
    blocca:=21;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z024_acqcodindp;
{Resettaggio turni pianificati}
begin
  if l08_Turno1 = 0 then
    l08_Turno2:=0;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z026_notteparz;
{Gestione parziale prima T=U o ultima T=E o 24 ore di lavoro}
  function VerificaGGVuoto(d1,d2:TDateTime):Boolean;
  begin
    Result:=True;
    if d2 - d1 > 1 then
    begin
      R180SetVariable(selT040GGSucc,'PROGRESSIVO',Progrcon);
      R180SetVariable(selT040GGSucc,'DATA',d1 + 1);
      selT040GGSucc.Open;
      if selT040GGSucc.RecordCount > 0 then
        Result:=False;
    end;
  end;
begin
  if n_timbrdip = 0 then
  begin
    if (estimbprec = 'si') and (verso_pre = 'E') and
       (estimbsucc = 'si') and (verso_suc = 'U') and
       (data_suc - data_pre <= 2) then
    begin
      inc(n_timbrdip);
      ttimbraturedip[1].tminutid_e:=0;
      ttimbraturedip[1].trilev_e:=rilev_pre;
      ttimbraturedip[1].tcausale_e:=tcausale_vuota;
      ttimbraturedip[1].tflagarr_e:='si';
      ttimbraturedip[1].tminutid_u:=1440;
      ttimbraturedip[1].trilev_u:=rilev_suc;
      ttimbraturedip[1].tcausale_u:=tcausale_vuota;
      ttimbraturedip[1].tflagarr_u:='si';
      primat_u:='si';
      ultimt_e:='si';
      orelav24:='si';
      z098_anom2caus(32,'');
      exit;
    end
    else
      exit;
  end;
  if primat_u = 'si' then
  begin
    if (estimbprec = 'si') and (verso_pre = 'E') and VerificaGGVuoto(data_pre,datacon) then
    begin
      ttimbraturedip[1].tminutid_e:=0;
      ttimbraturedip[1].trilev_e:=rilev_pre;
      ttimbraturedip[1].tcausale_e:=tcausale_vuota;
      ttimbraturedip[1].tflagarr_e:='si';
    end
    else
    begin
      blocca:=2;
      exit;
    end;
  end;
  if ultimt_e = 'si' then
  begin
    if (estimbsucc = 'si') and (verso_suc = 'U') and VerificaGGVuoto(datacon,data_suc) then
    begin
      ttimbraturedip[n_timbrdip].tminutid_u:=1440;
      ttimbraturedip[n_timbrdip].trilev_u:=rilev_suc;
      ttimbraturedip[n_timbrdip].tcausale_u:=tcausale_vuota;
      ttimbraturedip[n_timbrdip].tflagarr_u:='si';
    end
    else
      blocca:=2;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z028_nottecaus;
{Gestione causali prima T=U o ultima T=E o 24 ore di lavoro}
var LeggiCaus:Boolean;
begin
  if orelav24 = 'si' then
  //Gestione causali 24 ore di lavoro
  begin
    if (caus_pre = '') or (caus_pre <> caus_suc) then
      exit
    else
    begin
      if (ValStrT275[caus_pre,'TIPOCONTEGGIO'] <> '') and
         (ValStrT275[caus_pre,'TIPOCONTEGGIO'] <> 'A') and
         (ValStrT275[caus_pre,'TIPOCONTEGGIO'] <> 'E') then
      begin
        ttimbraturedip[1].tcausale_e.tcaus:=caus_pre;
        ttimbraturedip[1].tcausale_u.tcaus:=caus_pre;
      end;
      exit;
    end;
  end;
  if primat_u = 'si' then
    //Gestione prima T=U con causale
    if ttimbraturedip[1].tcausale_u.tcaus <> '' then
      if ((ttimbraturedip[1].tcausale_u.tcaus = caus_pre) and (TipoOrario = 'E') and (PeriodoLavorativo = 'T1')) or
          (TipoOrario <> 'E' ) or ((TipoOrario = 'E') and (PeriodoLavorativo <> 'T1')) then
      begin
        if (ValStrT275[ttimbraturedip[1].tcausale_u.tcaus,'TIPOCONTEGGIO'] <> '') and
           (ValStrT275[ttimbraturedip[1].tcausale_u.tcaus,'TIPOCONTEGGIO'] <> 'A') and
           (ValStrT275[ttimbraturedip[1].tcausale_u.tcaus,'TIPOCONTEGGIO'] <> 'E') then
          ttimbraturedip[1].tcausale_e.tcaus:=ttimbraturedip[1].tcausale_u.tcaus;
      end;
  if primat_u = 'si' then
    //Gestione prima T=U senza causale con causale su E precedente
    if (ttimbraturedip[1].tcausale_u.tcaus = '') and (caus_pre <> '') then
      if (TipoOrario <> 'E') or
         ((TipoOrario = 'E') and (turnicavmez = 'no')) or
         ((TipoOrario = 'E') and (turnicavmez = 'si') and (minuti_pre >= ttimbraturenom[n_timbrnom].tminutin_e)) then
      begin
        if (ValStrT275[caus_pre,'TIPOCONTEGGIO'] <> '') and
           (ValStrT275[caus_pre,'TIPOCONTEGGIO'] <> 'A') and
           (ValStrT275[caus_pre,'TIPOCONTEGGIO'] <> 'E') then
          ttimbraturedip[1].tcausale_e.tcaus:=caus_pre;
      end;
  if ultimt_e = 'si' then
    //Gestione ultima T=E con causale
    if ttimbraturedip[n_timbrdip].tcausale_e.tcaus <> '' then
      if ((ttimbraturedip[n_timbrdip].tcausale_e.tcaus = caus_suc) and (TipoOrario = 'E') and (PeriodoLavorativo = 'T1')) or
         (TipoOrario <> 'E' ) or
         ((TipoOrario = 'E') and (PeriodoLavorativo <> 'T1')) then
      begin
        if (ValStrT275[ttimbraturedip[n_timbrdip].tcausale_e.tcaus,'TIPOCONTEGGIO'] <> '') and
           (ValStrT275[ttimbraturedip[n_timbrdip].tcausale_e.tcaus,'TIPOCONTEGGIO'] <> 'A') and
           (ValStrT275[ttimbraturedip[n_timbrdip].tcausale_e.tcaus,'TIPOCONTEGGIO'] <> 'E') then
          ttimbraturedip[n_timbrdip].tcausale_u.tcaus:=ttimbraturedip[n_timbrdip].tcausale_e.tcaus;
      end;
  if ultimt_e = 'si' then
  begin
    //Gestione ultima T=E senza causale
    //con causale su U successiva
    LeggiCaus:=False;
    //Alberto 20/10/2005: Aggiunto test su CAUS_PM
    if ((ttimbraturedip[n_timbrdip].tcausale_e.tcaus = '') or (ttimbraturedip[n_timbrdip].tcausale_e.tcaus = CAUS_PM)) and
       (caus_suc <> '') then
    begin
      if (TipoOrario <> 'E') or
         ((TipoOrario = 'E') and (turnicavmez = 'no')) then
        LeggiCaus:=True;
      if (TipoOrario = 'E') and (turnicavmez = 'si') and (n_timbrnom > 0) then
        if minuti_suc <= ttimbraturenom[1].tminutin_u then
          LeggiCaus:=True;
    end;
    if LeggiCaus then
    begin
      if (ValStrT275[caus_suc,'TIPOCONTEGGIO'] <> '') and
         (ValStrT275[caus_suc,'TIPOCONTEGGIO'] <> 'A') and
         (ValStrT275[caus_suc,'TIPOCONTEGGIO'] <> 'E') then
        ttimbraturedip[n_timbrdip].tcausale_u.tcaus:=caus_suc;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z030_flexorarE;
{Gestione flessibilita' per tipo orario E
 Scorrimento entrate dipendente per gestire flessibilita'}
begin
  i1:=1;
  while i1 <= n_timbrdip do
    begin
    //Scorrimento entrate dipendente per gestire flessibilita'
    p1:=ttimbraturedip[i1].tpuntnomin;
    if p1 > 0 then
      begin
      //Gestione entrata dipendente appoggiata a quella nominale
      z034_gestflexen;
      //Salto coppie di timbrature appoggiate al turno appena gestito
      i2:=i1;
      while not((i2 > n_timbrdip) or ((ttimbraturedip[i2].tpuntnomin <> 0) and (ttimbraturedip[i2].tpuntnomin <> p1))) do
        inc(i2);
      i1:=i2 - 1;
      end;
    inc(i1);
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z034_gestflexen;
var flex_e:Integer;
{Gestione entrata dipendente appoggiata a quella nominale}
begin
  pe:=ttimbraturenom[p1].tpuntre;
  pu:=ttimbraturenom[p1].tpuntru;
  if pu = 0 then exit;
  if pe = 0 then
  begin
    if i1 = 1 then
    begin
      //Gestione flessibilita' a cavallo di mezzanotte
      z036FlexDopoMezzanotte:=False;
      z036_gestflexcv;
      if z036FlexDopoMezzanotte then
      begin
        estimbprec:='no';
        verso_pre:=#0;
        minuti_pre:=0;
        z036FlexDopoMezzanotte:=False;
      end;
    end;
    exit;
  end;
  if not Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    z035_gestflexTurnoDiurno
  else
  begin  //flex su tutto l'intervallo (TORINO_CSI)
    i90e:=p1;
    flex90:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1];
    //Calcolo carenze nell'intervallo di flessibilità
    flex_e:=z091_flexIntervalloCompleto;
    //Spostamento uscita nominale per flessibilita'
    ttimbraturenom[p1].tminutin_u:=ttimbraturenom[p1].tminutin_u + flex_e;
    ttimbraturenom[p1].Flex:=flex_e;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z035_gestflexTurnoDiurno;
var i,xx,tminutiflex_e,tminutinom_e:Integer;
    FlexGius:Boolean;
begin
  //Verifica se E in ritardo
  if (ttimbraturedip[i1].tcausale_e.tcaus <> '') and
     (ttimbraturedip[i1].tcausale_e.tcauscon = 'A') and
     (ValStrT275[ttimbraturedip[i1].tcausale_e.tcaus,'E_IN_FLESSIBILITA'] = 'N') then
    exit;
  //Si eslcudono le timbrature dalla flessibilità se E_IN_FLESSIBILITA = 'S'
  if (ttimbraturedip[i1].tcausale_e.tcaus <> '') and
     (ValStrT275[ttimbraturedip[i1].tcausale_e.tcaus,'LIQUIDABILE'] = 'B') and        //Ore esterne all'orario
     (R180CarattereDef(ttimbraturedip[i1].tcausale_e.tcauscon) in ['B','C']) and      //Causale su entrata/uscita
     (ValStrT275[ttimbraturedip[i1].tcausale_e.tcaus,'E_IN_FLESSIBILITA'] = 'S') then //Non considerata nella flessibilità
    exit;
  //Si usa tminutiflex_e anzichè ttimbraturedip[i1].tminutid_e
  tminutiflex_e:=ttimbraturedip[i1].tminutid_e;
  //Considero il punto nominale di ingresso con eventuale flessibilità già calcolata precedentemente (caso COTTOLENGO, la flessibilità può venire calcolata 2 volte)
  tminutinom_e:=ttimbraturenom[p1].tminutin_e;
  if cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S' then
    //In realtà potrebbe essere valido sempre, indipendentemente da MINUTICAUS_PRIORITARI
    tminutinom_e:=tminutinom_e + ttimbraturenom[p1].Flex;
  //Come LaSpezia: se la fascia di flessibilità è coperta da giustificativi non la applico
  FlexGius:=False;
  for i:=1 to n_giusdaa do
  begin
    z964_leggicaus(tgius_dallealle[i].tcausdaa);
    if (s_trovato = 'no') or (parcaus.l29_18paramet <> 'S') then
      Continue;
    if (tgius_dallealle[i].tminutida <= tminutiflex_e) and (tgius_dallealle[i].tminutia >= tminutinom_e) then
    begin
      tminutiflex_e:=Max(tgius_dallealle[i].tminutida,tminutinom_e);
      FlexGius:=True;
    end;
  end;
  //Alberto 15/06/2009: non arrotondo più le timbrature successive al giustificativo di assenza
  if FlexGius and (cdsT020.FieldByName('ARR_TIMB_INTERNE').AsString = 'N') then
    for xx:=1 to n_timbrdip do
      if ttimbraturedip[xx].tminutid_e > tminutiflex_e then
        ttimbraturedip[xx].tflagarr_e:='si';
  if tminutiflex_e <= tminutinom_e then
    exit;
  //Calcolo ritardo dell'entrata
  rit:=tminutiflex_e - tminutinom_e;
  //if (rit <= StrToIntDef(T020[Q020.Fields[C_POS_TOLLERANZA + pe].Index],0)) and (f03_com <> 'NO TOLLERANZA') then
  if (rit <= ValNumT021['TOLLERANZA',TF_PUNTI_NOMINALI,pe]) and (f03_com <> 'NO TOLLERANZA') then
  begin
    //Tolleranza
    ttimbraturedip[i1].tminutid_e:=tminutinom_e;
    inc(tollergod,rit);
  end
  else if rit <= ValNumT021['mmFlex',TF_PUNTI_NOMINALI,pe] then
  begin
    //Flessibilita'
    if (not FlexGius) or (ttimbraturedip[i1].tminutid_e - tminutinom_e <= ValNumT021['mmFlex',TF_PUNTI_NOMINALI,pe]) then
    begin
      //Arrotondamento in flessibilità
      i890:=i1;
      e_u890:='E';
      arr890:=ValNumT021['MMARROTOND',TF_PUNTI_NOMINALI,pe];
      z890_arrotonda;
    end;
    if not FlexGius then
      tminutiflex_e:=ttimbraturedip[i1].tminutid_e;
    //Spostamento uscita nominale per flessibilita'
    ttimbraturenom[p1].tminutin_u:=ttimbraturenom[p1].tminutin_u + tminutiflex_e - tminutinom_e;
    ttimbraturenom[p1].Flex:=tminutiflex_e - tminutinom_e;
  end
  else
  begin
    //Ritardo: Spostamento uscita nominale per flessibilita'
    inc(ttimbraturenom[p1].tminutin_u,ValNumT021['mmFlex',TF_PUNTI_NOMINALI,pe]);
    ttimbraturenom[p1].Flex:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,pe];
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z036_gestflexcv;
{Gestione flessibilita' a cavallo di mezzanotte}
var puntre:Byte;
    minutin_e:Integer;
    i,PuntoOld:Integer;
begin
  //Alberto 28/09/1999: gestione flessibilità a cavallo con pianificazione spezzone E/U
  if (estimbprec = 'no') or (verso_pre = 'U') then
  begin
    if not NotteSuEntrata then
      exit;
    //Alberto 09/06/2005: nel caso di NotteSuEntrata gestisco la flessibilità quando l'entrata in ritardo è dopo la mezzanotte
    z036FlexDopoMezzanotte:=True;
    estimbprec:='si';
    verso_pre:='E';
    minuti_pre:=ttimbraturedip[1].tminutid_e + 1440;
  end;
  //Ricerca appoggio per E di ieri
  i2:=0;
  repeat
    inc(i2);
  until (i2 > n_timbrnom) or
        ((minuti_pre >= ttimbraturenom[i2].tminutin_e) and ((ttimbraturenom[i2].tpuntru = 0) or {4.0}(ttimbraturenom[i2].tminutin_u > 1440))) or
        ((ttimbraturenom[i2].tpuntre = 0) and (ttimbraturenom[i2].PuntreNomPrec <> 0) and (minuti_pre >= ttimbraturenom[i2].EntrataNomPrec));
  //Verifica se si deve gestire la flessibilita'
  if i2 > n_timbrnom then exit;
  if ttimbraturenom[i2].PuntreNomPrec <> 0 then
  begin
    puntre:=ttimbraturenom[i2].PuntreNomPrec;
    minutin_e:=ttimbraturenom[i2].EntrataNomPrec;
  end
  else
  begin
    puntre:=ttimbraturenom[i2].tpuntre;
    minutin_e:=ttimbraturenom[i2].tminutin_e;
  end;
  (*TORINO_COMUNE: bisognerebbe chiamare i conteggi di ieri per calcolare esattamente la flessibilità*)
  if minuti_pre = minutin_e then exit;
  if (caus_pre <> '') and (ValStrT275[caus_pre,'TIPOCONTEGGIO'] = 'A') and (ValStrT275[caus_pre,'E_IN_FLESSIBILITA'] = 'N') then
    exit;
  //Si eslcudono le timbrature dalla flessibilità se E_IN_FLESSIBILITA = 'S'
  if (caus_pre <> '') and
     (ValStrT275[caus_pre,'LIQUIDABILE'] = 'B') and                            //Ore esterne all'orario
     (R180CarattereDef(ValStrT275[caus_pre,'TIPOCONTEGGIO']) in ['B','C']) and //Causale su entrata/uscita
     (ValStrT275[caus_pre,'E_IN_FLESSIBILITA'] = 'S') then                     //Non considerata nella flessibilità
    exit;
  //Calcolo ritardo dell'entrata di ieri
  rit:=minuti_pre - minutin_e;
  PuntoOld:=ttimbraturenom[p1].tminutin_u;
  pe:=puntre;
  if rit <= ValNumT021['mmFlex',TF_PUNTI_NOMINALI,max(1,pe)] then
    //Flessibilita' di ieri
  begin
    per892:=minuti_pre;
    arr890:= - ValNumT021['MMARROTOND',TF_PUNTI_NOMINALI,max(1,pe)];
    z892_arrotondap;
    //Spostamento uscita nominale per flessibilita' di ieri
    ttimbraturenom[p1].tminutin_u:=ttimbraturenom[p1].tminutin_u + per892 - minutin_e;
    ttimbraturenom[p1].Flex:=per892 - minutin_e;
  end
  else
  //Ritardo di ieri: Spostamento uscita nominale per flessibilita'
  begin
    inc(ttimbraturenom[p1].tminutin_u,ValNumT021['mmFlex',TF_PUNTI_NOMINALI,max(1,pe)]);
    ttimbraturenom[p1].Flex:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,max(1,pe)];
  end;
  //4.0 Gestione spezzamento delle timbrature con flessibilità
  for i:=1 to n_timbrdip - 1 do
    if (ttimbraturedip[i].spezzata) and (ttimbraturedip[i].tminutid_u = PuntoOld) and
       (ttimbraturedip[i + 1].tminutid_u >= ttimbraturenom[p1].tminutin_u) then
    begin
      ttimbraturedip[i + 1].tminutid_e:=ttimbraturenom[p1].tminutin_u;
      Break;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z040_fascdacon;
{Impostazione fascia del giorno da conteggiare}
begin
  minutidalle:=0;
  minutialle:=1440;
  if Copy(f03_com,1,5) = 'ALLE*' then
    //f03_com nel formato ALLE*hhmm
    begin
    MinutiAlle:=R180OreMinuti(EncodeTime(StrToIntDef(Copy(f03_com,6,2),0),StrToIntDef(Copy(f03_com,8,2),0),0,0));
    exit;
    end;
  if Copy(f03_com,1,6) = 'DALLE*' then
    //f03_com nel formato DALLE*hhmm
    begin
    MinutiDalle:=R180OreMinuti(EncodeTime(StrToIntDef(Copy(f03_com,7,2),0),StrToIntDef(Copy(f03_com,9,2),0),0,0));
    if Copy(f03_com,11,6) = '*ALLE*' then
      //f03_com nel formato DALLE*hhmm*ALLE*hhmm
      minutialle:=R180OreMinuti(EncodeTime(StrToIntDef(Copy(f03_com,17,2),0),StrToIntDef(Copy(f03_com,19,2),0),0,0));
      if minutialle = 0 then
        minutialle:=1440;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z042_dipinser;
var DataCom5,r_amg150:TDateTime;
begin
  //data assunzione
  DataCom5:=Q430.FieldByName('Inizio').AsDateTime;
  //data cessazione
  r_amg150:=Q430.FieldByName('Fine').AsDateTime;
  //Verifica dipendente in servizio
  dipinser:='si';
  if (Q430.RecordCount > 0) and (datacon >= DataCom5) then
    if (DataCom5 > 0) and ((r_amg150 = 0) or (datacon <= r_amg150)) then
      exit;
  dipinser:='no';
  gglav:='no';
  if n_timbrdip <> 0 then
    begin
    blocca:=4;
    exit;
    end
  else
    if (estimbprec = 'si') and (verso_pre = 'E') and
       (estimbsucc = 'si') and (verso_suc = 'U') then
      begin
      blocca:=4;
      exit;
      end;
  if chiamante <> 'Assenze' then
    if (n_giusdaa <> 0) or (n_giusore <> 0) or (n_giusmga <> 0) or (n_giusgga <> 0) then
      blocca:=4;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z043_arrotgiustore;
{Alberto 02/11/2005: arrotondamento interno}
var i,j,k,p,arr,incremento,gda,ga:Integer;
    Intersez:Boolean;
begin
  for i:=1 to n_giusore do
  begin
    arr:=StrToIntDef(ValStrT265[tgius_min[i].tcausore,'FRUIZ_ARR'],0);
    if (ValStrT265[tgius_min[i].tcausore,'FRUIZCOMPETENZE_ARR'] = 'S') and (arr > 1) then
    begin
      incremento:=Trunc(R180Arrotonda(tgius_min[i].tmin,arr,'E')) - tgius_min[i].tmin;
      if incremento > 0 then
      begin
        inc(tgius_min[i].tmin,incremento);
      end;
    end;
  end;
  for i:=1 to n_giusdaa do
  begin
    arr:=StrToIntDef(ValStrT265[tgius_dallealle[i].tcausdaa,'FRUIZ_ARR'],0);
    if (ValStrT265[tgius_dallealle[i].tcausdaa,'FRUIZCOMPETENZE_ARR'] = 'S') and (arr > 1) then
    begin
      incremento:=Trunc(R180Arrotonda(tgius_dallealle[i].tminutia - tgius_dallealle[i].tminutida,arr,'E')) - (tgius_dallealle[i].tminutia - tgius_dallealle[i].tminutida);
      if incremento > 0 then
      begin
        gda:=tgius_dallealle[i].tminutida;
        ga:=tgius_dallealle[i].tminutia;
        inc(tgius_dallealle[i].tminutia,incremento);
        incremento:=0;
        p:=0;
        //Cerco l'ultimo punto nominale usato nel giorno
        for j:=1 to n_timbrdip do
          if ttimbraturedip[j].tpuntnomin > 0 then
            p:=ttimbraturedip[j].tpuntnomin;
        //Se non c'è un punto nominale valido associato alle timbrature, considero l'ultimo tra quelli letti dai conteggi
        if p = 0 then
          p:=n_timbrnom;
        if p > 0 then
          incremento:=Max(0,tgius_dallealle[i].tminutia - ttimbraturenom[p].tminutin_u);
        if tgius_dallealle[i].tminutia - incremento < ga then
          dec(incremento,ga - (tgius_dallealle[i].tminutia - incremento));
        dec(tgius_dallealle[i].tminutia,incremento);
        dec(tgius_dallealle[i].tminutida,incremento);
        //Alberto 16/12/2005: consento il prolungamento solo se la parte aggiunta si sovrappone alle timbrature (GENOVA_COMUNE)
        for j:=tgius_dallealle[i].tminutida to gda - 1 do
        begin
          Intersez:=False;
          for k:=1 to n_timbrdip do
          begin
            Intersez:=(ttimbraturedip[k].tminutid_e <= j) and (ttimbraturedip[k].tminutid_u >= j);
            if Intersez then
              Break;
          end;
          if not Intersez then
            tgius_dallealle[i].tminutida:=j + 1;
        end;
        for j:=tgius_dallealle[i].tminutia downto ga + 1 do
        begin
          Intersez:=False;
          for k:=1 to n_timbrdip do
          begin
            Intersez:=(ttimbraturedip[k].tminutid_e <= j) and (ttimbraturedip[k].tminutid_u >= j);
            if Intersez then
              Break;
          end;
          if not Intersez then
            tgius_dallealle[i].tminutia:=j - 1;
        end;
        //Alberto 31/01/2006; se il giustificativo arrotondato è inferiore a quello originale, si ripristinano i valori originali annullando l'arrotondamento
        if tgius_dallealle[i].tminutia - tgius_dallealle[i].tminutida < ga - gda then
        begin
          tgius_dallealle[i].tminutida:=gda;
          tgius_dallealle[i].tminutia:=ga;
          z098_anom2caus(50);
        end;
      end;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z044_intimgiu;
{Controllo intersezione timbrature e giustificativi}
var i,j:Integer;
    appoggio:Boolean;
    IntersezioneTimbrature,ConteggioTimbInterna:String;
    TimbSalvate:array [1..MaxTimbrature] of t_ttimbraturedip;
  function SceltaIntervalloMaggiore(idxG,idxT:Integer):String;
  //Verifica se il giustificativo copre di più prima o dopo la timbratura
  var intPrec,intSucc:TPeriodoIF;
  begin
    //P=Precedente
    //S=Successivo
    Result:='P';
    intPrec.I:=tgius_dallealle[idxG].tminutida;
    intPrec.F:=tgius_dallealle[idxG].tminutia;
    intSucc:=intPrec;

    intPrec.F:=ttimbraturedip[idxT].tminutid_e;
    if idxT > 1 then
      intPrec.I:=max(intPrec.I,ttimbraturedip[idxT - 1].tminutid_u);

    intSucc.I:=ttimbraturedip[idxT].tminutid_u;
    if idxT < n_timbrdip then
      intSucc.F:=min(intSucc.F,ttimbraturedip[idxT + 1].tminutid_e);

    if intSucc.F - intSucc.I > intPrec.F - intPrec.I then
      Result:='S';
  end;
begin
  if conteggi_sologiust then
    exit;
  appoggio:=False;
  for i:=1 to n_giusdaa do
  begin
    if tgius_dallealle[i].tassenza then
    begin
      IntersezioneTimbrature:=ValStrT265[tgius_dallealle[i].tcausdaa,'INTERSEZIONE_TIMBRATURE'];
      ConteggioTimbInterna:=ValStrT265[tgius_dallealle[i].tcausdaa,'CONTEGGIO_TIMB_INTERNA'];
    end
    else
    begin
      IntersezioneTimbrature:=ValStrT275[tgius_dallealle[i].tcausdaa,'INTERSEZIONE_TIMBRATURE'];
      ConteggioTimbInterna:=ValStrT275[tgius_dallealle[i].tcausdaa,'CONTEGGIO_TIMB_INTERNA'];
    end;
    if ConteggioTimbInterna = '' then
      ConteggioTimbInterna:='C';
    j:=1;
    while j <= n_timbrdip do
    begin
      //Il giustificativo comprende la coppia di timbrature
      if (tgius_dallealle[i].tminutida <= ttimbraturedip[j].tminutid_e) and
         (tgius_dallealle[i].tminutia >= ttimbraturedip[j].tminutid_u) then
      begin
        if IntersezioneTimbrature = 'G' then
        begin
          z126_allineaMintipoAesc(ttimbraturedip[j].tminutid_e,ttimbraturedip[j].tminutid_u);
          if tgius_dallealle[i].tminutida = ttimbraturedip[j].tminutid_e then
            ttimbraturedip[j].tminutid_u:=ttimbraturedip[j].tminutid_e
          else if tgius_dallealle[i].tminutia = ttimbraturedip[j].tminutid_u then
            ttimbraturedip[j].tminutid_e:=ttimbraturedip[j].tminutid_u
          else
            //In realtà si dovrebbe eliminare la timbratura...
            ttimbraturedip[j].tminutid_u:=ttimbraturedip[j].tminutid_e;
        end
        else if IntersezioneTimbrature = 'T' then
        begin
          if tgius_dallealle[i].tminutia = ttimbraturedip[j].tminutid_u then
            //Fine giust coincide con Uscita
            tgius_dallealle[i].tminutia:=ttimbraturedip[j].tminutid_e
          else if tgius_dallealle[i].tminutida = ttimbraturedip[j].tminutid_e then
            //Inizio giust coincide con Entrata
            tgius_dallealle[i].tminutida:=ttimbraturedip[j].tminutid_u
          else
          begin
            //Inizio giust < Entrata e Fine giust > Uscita
            if ConteggioTimbInterna = 'C' then //Compensazione con intervallo di timbratura (Vecchio comportamento)
            begin
              //Alberto 10/12/2010: si sposta tminutida invece che tminutia per gestire sovrapposizione con eventuali timbrature successive
              inc(tgius_dallealle[i].tminutida,ttimbraturedip[j].tminutid_u - ttimbraturedip[j].tminutid_e);
            end
            else if ConteggioTimbInterna = 'P' then //Fine giustificativo prima della timrbatura
            begin
              tgius_dallealle[i].tminutia:=ttimbraturedip[j].tminutid_e;
            end
            else if ConteggioTimbInterna = 'S' then //Scelta intravallo maggiore prima o dopo la timbratura
            begin
              if SceltaIntervalloMaggiore(i,j) = 'P' then
                tgius_dallealle[i].tminutia:=ttimbraturedip[j].tminutid_e
              else
                tgius_dallealle[i].tminutida:=ttimbraturedip[j].tminutid_u;
            end
          end;
          (*
          if TRUE and tgius_dallealle[i].tassenza then
          begin
            tgius_dallealle[i].tminutia:=ttimbraturedip[j].tminutid_e;
          end
          else
          begin
            if tgius_dallealle[i].tminutia = ttimbraturedip[j].tminutid_u then
              tgius_dallealle[i].tminutia:=ttimbraturedip[j].tminutid_e
            else
              //Alberto 10/12/2010: si sposta tminutida invece che tminutia per gestire sovrapposizione con eventuali timbrature successive
              inc(tgius_dallealle[i].tminutida,ttimbraturedip[j].tminutid_u - ttimbraturedip[j].tminutid_e);
          end;
          *)
        end;
      end
      //Il giustificativo ha l'entrata dentro la coppia di timbrature
      else if (tgius_dallealle[i].tminutida >= ttimbraturedip[j].tminutid_e) and
              (tgius_dallealle[i].tminutida < ttimbraturedip[j].tminutid_u) and
              (tgius_dallealle[i].tminutia >= ttimbraturedip[j].tminutid_u) then
      begin
        if IntersezioneTimbrature = 'G' then
        begin
          z126_allineaMintipoAesc(tgius_dallealle[i].tminutida,ttimbraturedip[j].tminutid_u);
          ttimbraturedip[j].tminutid_u:=tgius_dallealle[i].tminutida;
          if ttimbraturedip[j].tpuntnomin > 0 then
            ttimbraturedip[j].tag:='tpuntnominold' + IntToStr(ttimbraturedip[j].tpuntnomin);
        end
        else if IntersezioneTimbrature = 'T' then
          tgius_dallealle[i].tminutida:=ttimbraturedip[j].tminutid_u;
      end
      //Il giustificativo ha l'uscita dentro la coppia di timbrature
      else if (tgius_dallealle[i].tminutia > ttimbraturedip[j].tminutid_e) and
              (tgius_dallealle[i].tminutia <= ttimbraturedip[j].tminutid_u) and
              (tgius_dallealle[i].tminutida <= ttimbraturedip[j].tminutid_e) then
      begin
        if IntersezioneTimbrature = 'G' then
        begin
          z126_allineaMintipoAesc(ttimbraturedip[j].tminutid_e,tgius_dallealle[i].tminutia);
          ttimbraturedip[j].tminutid_e:=tgius_dallealle[i].tminutia;
          if ttimbraturedip[j].tpuntnomin > 0 then
            ttimbraturedip[j].tag:='tpuntnominold' + IntToStr(ttimbraturedip[j].tpuntnomin);
        end
        else if IntersezioneTimbrature = 'T' then
          tgius_dallealle[i].tminutia:=ttimbraturedip[j].tminutid_e;
      end
      //Il giustificativo è dentro la coppia di timbrature
      else if (tgius_dallealle[i].tminutida > ttimbraturedip[j].tminutid_e) and
              (tgius_dallealle[i].tminutia < ttimbraturedip[j].tminutid_u) then
      begin
        if IntersezioneTimbrature = 'G' then
        begin
          z126_allineaMintipoAesc(tgius_dallealle[i].tminutida,tgius_dallealle[i].tminutia);
          appoggio:=True;
          indice:=j + 1;
          z816_insetimbr;
          ttimbraturedip[indice].tminutid_u:=ttimbraturedip[j].tminutid_u;
          ttimbraturedip[indice].tminutid_e:=tgius_dallealle[i].tminutia;
          ttimbraturedip[indice].trilev_e:=ttimbraturedip[j].trilev_e;
          ttimbraturedip[indice].trilev_u:=ttimbraturedip[j].trilev_u;
          ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
          ttimbraturedip[indice].tcausale_u:=ttimbraturedip[j].tcausale_u;
          ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[j].tflagarr_u;
          ttimbraturedip[indice].tflagarr_e:='si';
          ttimbraturedip[indice].tpuntnomin:=ttimbraturedip[j].tpuntnomin;
          if ttimbraturedip[indice].tpuntnomin > 0 then
            ttimbraturedip[indice].tag:='tpuntnominold' + IntToStr(ttimbraturedip[indice].tpuntnomin);
          if ttimbraturedip[j].tpuntnomin > 0 then
            ttimbraturedip[j].tag:='tpuntnominold' + IntToStr(ttimbraturedip[j].tpuntnomin);
          ttimbraturedip[j].tminutid_u:=tgius_dallealle[i].tminutida;
          ttimbraturedip[j].tflagarr_u:='si';
          if (R180CarattereDef(ttimbraturedip[j].tcausale_u.tcauscon) in ['A','E']) or
             (ttimbraturedip[j].tcausale_u.tcaustip = 'C') then
            ttimbraturedip[j].tcausale_u:=tcausale_vuota;
        end
        else if IntersezioneTimbrature = 'T' then
          tgius_dallealle[i].tminutia:=tgius_dallealle[i].tminutida;
      end;
      inc(j);
    end;
  end;
  if appoggio then
  begin
    //Salvo timbrature prima del nuovo appoggio
    for i:=1 to MaxTimbrature do
      TimbSalvate[i]:=ttimbraturedip[i];
   z060_appoggio(False);
   //Ripristino appoggio precedente per tutte le timbrature non toccate dall'intersezione
   for i:=1 to MaxTimbrature do
     if Pos('tpuntnominold',ttimbraturedip[i].tag) = 0 then
       ttimbraturedip[i].tpuntnomin:=TimbSalvate[i].tpuntnomin;
    if XParam[XP_Z044_NOAPPOGGIO] then
      //Per le timbrature toccate dall'intersezione, ripristino il punto d'appoggio originale se era diverso da 0
      for i:=1 to n_timbrdip do
        if Pos('tpuntnominold',ttimbraturedip[i].tag) > 0 then
          ttimbraturedip[i].tpuntnomin:=StrToIntDef(StringReplace(ttimbraturedip[i].tag,'tpuntnominold','',[]),ttimbraturedip[i].tpuntnomin);
  end;
  for i:=1 to n_timbrdip do
    if Pos('tpuntnominold',ttimbraturedip[i].tag) > 0 then
      ttimbraturedip[i].tag:='';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z046_orario;
{Lettura orario con inizializzazioni per orario vuoto}
begin
  if c_orario = '' then
  begin
    //orario vuoto
    blocca:=6;
    exit;
  end
  else
  //Lettura orario del giorno
  begin
    z946_leggiorar;
    if s_trovato = 'no' then
    begin
      blocca:=6;
      exit;
    end;
  end;
  if cdsT020.FieldByName('MaxGioStr').IsNull then
  begin
    //Nessun limite allo straordinario massimo
    cdsT020.Edit;
    cdsT020.FieldByName('MaxGioStr').AsString:='24.00';
    cdsT020.Post;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z050_instimfc;
{Inserimento timbrature facoltative (se necessario)}
var i:Integer;
begin
  if gglav = 'no' then exit;
  if (TipoOrario <> 'A') and (TipoOrario <> 'B') then exit;
  if (n_timbrdip > 0) or (n_giusmga > 0) or (n_giusgga > 0) then exit;
  //Giornata priva di timbrature e di causali di giornate
  //intere o mezze di assenza
  timbfac:='no';
  if cdsT020.FieldByName('OBBLFAC').AsString = 'F' then
    timbfac:='si';
  if (timbfac = 'no') or (n_giusdaa > 0) or (n_giusore > 0) then exit;
  //Inserimento timbrature facoltative
  for i:=1 to n_timbrnom do
    begin
    ttimbraturedip[i]:=ttimbraturedip_vuota;
    ttimbraturedip[i].tminutid_e:=ttimbraturenom[i].tminutin_e;
    ttimbraturedip[i].tminutid_u:=ttimbraturenom[i].tminutin_u;
    end;
  n_timbrdip:=n_timbrnom;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z051_instim_orariospezzato;
{Inserimento timbrature per pausa pranzo nel caso di orario spezzato}
var i,x1,x2,fx,fxmat,fxpom,y1,uscita_pm,int_pm:Integer;
begin
  if (not XParam[XP_REC_SPEZZATO_PM_AUTO]) and (not XParam[XP_REC_SPEZZATO_PM_MINIMA]) then
    exit;
  if (TipoOrario <> 'A') and (TipoOrario <> 'B') then
    exit;
  if PeriodoLavorativo <> 'S' then
    exit;
  int_pm:=30;
  //Appoggio timbrature
  z060_appoggio(False);
  //Ricerca prima e ultima timbratura del mattino
  x1:=0;
  x2:=0;
  for i:=1 to n_timbrdip do
    if (ttimbraturedip[i].tpuntnomin = 1) or (ttimbraturedip[i].tminutid_e <= ttimbraturenom[1].tminutin_u) then
    begin
      x2:=i;
      if x1 = 0 then
        x1:=i;
    end;
  //Tolgo appoggio alle timbrature
  for i:=1 to n_timbrdip do
    ttimbraturedip[i].tpuntnomin:=0;
  if x1 = 0 then
    exit;
  //calcolo flessibilità sul mattino (04/11/2011: in accordo col Comune, si considera la flex del mattino)
  fxmat:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1];
  fxpom:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,2];
  fx:=max(0,ttimbraturedip[x1].tminutid_e - ttimbraturenom[1].tminutin_e);
  fx:=min(fxmat,fx);
  //ricerco uscita in pausa mensa oppure uscita successiva al rientro del pomeriggio (da spezzare)
  uscita_pm:=0;
  y1:=0;
  for i:=x2 to n_timbrdip do
    if (i < n_timbrdip) and R180Between(ttimbraturedip[i].tminutid_u,ttimbraturenom[1].tminutin_u + fx,ttimbraturenom[2].tminutin_e + fxpom) then
    begin
      uscita_pm:=i;
      Break;
    end
    else if (ttimbraturedip[i].tminutid_u < ttimbraturenom[1].tminutin_u + fx) and
            (i < n_timbrdip) and
            (ttimbraturedip[i+ 1].tminutid_e >= ttimbraturenom[1].tminutin_u + fx) then
    begin
      uscita_pm:=i;
      Break;
    end
    else if (ttimbraturedip[i].tminutid_e < ttimbraturenom[1].tminutin_u + fx) and
            (ttimbraturedip[i].tminutid_u > ttimbraturenom[2].tminutin_e + fxpom) and
            (y1 = 0) then
      y1:=i
    else if (ttimbraturedip[i].tminutid_e < ttimbraturenom[1].tminutin_u + fx) and
            (ttimbraturedip[i].tminutid_u > ttimbraturenom[2].tminutin_e) and
            (y1 = 0) and
            (i = n_timbrdip) then
      y1:=i;

  if uscita_pm > 0 then
  begin
    if XParam[XP_REC_SPEZZATO_PM_MINIMA] then
    begin
      //intervallo minimo pausa mensa
      //int_pm:=max(0,ttimbraturenom[2].tminutin_e - (ttimbraturenom[1].tminutin_u + ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1]));
      if (int_pm > 0) and
         (uscita_pm < n_timbrdip) then
      begin
        (*Riduco eventualmente intervallo se già alimentato dallo spezzone non conteggiato*)
        if max(0,ttimbraturedip[uscita_pm].tminutid_u - (ttimbraturenom[1].tminutin_u + fx)) < ValNumT020['MinimiStr'] then
          dec(int_pm,max(0,ttimbraturedip[uscita_pm].tminutid_u - (ttimbraturenom[1].tminutin_u + fx)));
        int_pm:=max(0,int_pm);
        //Sposto il rientro dalla mensa data dall'uscita in mensa + int_pm; si controlla che non sia antecedente al rientro originale e che non sia successivo all'uscita corrispondente
        ttimbraturedip[uscita_pm + 1].tminutid_e:=max(ttimbraturedip[uscita_pm + 1].tminutid_e,min(max(ttimbraturedip[uscita_pm].tminutid_u,ttimbraturenom[1].tminutin_u + fx) + int_pm,ttimbraturedip[uscita_pm + 1].tminutid_u));
      end;
    end;
    exit;
  end
  else if y1 = 0 then
    exit;

  //Aggiungo timbrature fittizie nel caso che manchi lo smonto/rientro per pausa mensa
  if XParam[XP_REC_SPEZZATO_PM_AUTO] then
  begin
    indice:=y1;
    z816_insetimbr;
    //ttimbraturedip[y1].tminutid_u:=ttimbraturenom[1].tminutin_u + ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1];
    //calcolo il rientro dalla mensa come l'entrata effettiva del mattino + la durata nominale del mattino + la durtata di mensa;
    //se se non raggiungo l'entrata nominale del pomeriggio la estendo quanto serve, altrimenti posso superare l'ora di rientro
    //l'uscita in mensa è data quindi dall'ora di rientro meno la durata di mensa;
    //(!!non più!!)verifico poi che l'uscita in mensa non vada oltre l'uscita nominale del mattino più la flessibilità
    ttimbraturedip[y1].tminutid_u:=max(max(min(ttimbraturedip[x1].tminutid_e,ttimbraturenom[1].tminutin_e + fxmat),
                                           ttimbraturenom[1].tminutin_e) + (ttimbraturenom[1].tminutin_u - ttimbraturenom[1].tminutin_e + int_pm),
                                       ttimbraturenom[2].tminutin_e)
                                   - int_pm;
    //(!!non più!!)ttimbraturedip[y1].tminutid_u:=min(ttimbraturedip[y1].tminutid_u,ttimbraturenom[1].tminutin_u + ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1]);
    ttimbraturedip[y1].tcausale_u:=tcausale_vuota;
    ttimbraturedip[y1].tflagarr_u:='si';
    //ttimbraturedip[y1 + 1].tminutid_e:=max(ttimbraturenom[2].tminutin_e,ttimbraturenom[1].tminutin_u + ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1] + int_pm);
    ttimbraturedip[y1 + 1].tminutid_e:=ttimbraturedip[y1].tminutid_u + int_pm;
    ttimbraturedip[y1 + 1].tminutid_e:=min(ttimbraturedip[y1 + 1].tminutid_e,ttimbraturedip[y1 + 1].tminutid_u);
    ttimbraturedip[y1 + 1].tcausale_e:=tcausale_vuota;
    ttimbraturedip[y1 + 1].tflagarr_e:='si';
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z052_profiloorar;
{Lettura profilo orario}
begin
  //Leggo i profili orari e carico i codici orario in T221
  z948_leggiprofor;
  if s_trovato = 'si' then
  begin
    c_profora_sv:=Q430.FieldByName('POrario').AsString;
    minantscelta:=StrToIntDef(T220[selT220.FieldByName('AnticipoUscita').Index],0);
    if minantscelta = 0 then
      minantscelta:=9999;
  end
  else
    blocca:=23;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z056_pausame;
{Gestione tipo pausa mensa A e B
 Gestione prima E con pausa mensa}
var i,j,FlexPM,idxFlexPM,n_timbrapp,UMax:Integer;
    ttimbratureapp: array [1..MaxTimbrature] of t_ttimbraturedip;
    EsisteUMax,Cambiato,Considera:Boolean;
  procedure FlexPM_CausEsluse;
  var i,FlexPM:Integer;
  begin
    //LaSpezia - Firenze: applicazione flessibilità da causali di presenza U/E escluse dalle normali
    idxFlexPM:=0;
    //Ricerca del punto nominale dell'ultima timbratura in ordine cronologico
    for i:=n_timbrdip downto 1 do
      if ttimbraturedip[i].tpuntnomin <> 0 then
      begin
        idxFlexPM:=ttimbraturedip[i].tpuntnomin;
        Break;
      end;
    //Applicazione della flessibilità sul punto nominale individuato
    if idxFlexPM <> 0 then
    begin
      FlexPM:=z130_FlexTipoConA;
      FlexPM:=z132_FlexPM(FlexPM,idxFlexPM);
      inc(ttimbraturenom[idxFlexPM].tminutin_u,FlexPM);
      inc(ttimbraturenom[idxFlexPM].Flex,FlexPM);
      inc(ttimbraturenom[idxFlexPM].FlexPM,FlexPM);
    end;
    //Fine LaSpezia
  end;
  procedure CheckTimbratureArrotondate;
  var i,j:Integer;
  begin
    for i:=1 to n_timbrdip do
    begin
      if (ttimbraturedip[i].tagmodif_e = 'z086') or (ttimbraturedip[i].tagmodif_u = 'z086') then
      begin
        for j:=1 to n_timbrapp do
        begin
          if (ttimbraturedip[i].tagmodif_e = 'z086') and (ttimbraturedip[i].timborig_e = ttimbratureapp[j].tminutid_e) then
          begin
            ttimbratureapp[j].tminutid_e:=ttimbraturedip[i].tminutid_e;
            ttimbratureapp[j].tflagarr_e:='si';
          end;
          if (ttimbraturedip[i].tagmodif_u = 'z086') and (ttimbraturedip[i].timborig_u = ttimbratureapp[j].tminutid_u) then
          begin
            ttimbratureapp[j].tminutid_u:=ttimbraturedip[i].tminutid_u;
            ttimbratureapp[j].tflagarr_u:='si';
          end;
        end;
      end;
    end;
  end;
begin
  //Alberto: FIRENZE_COMUNE - gestione dei giustificativi dalle-alle nella gestione della pausa mensa
  //Inserisco i giustificativi come timbrature, poi alla fine della procedura verranno tolti.
  //Copia delle timbrature originali in ttimbratureapp;
  for i:=1 to MaxTimbrature do
    ttimbratureapp[i]:=ttimbraturedip[i];
  n_timbrapp:=n_timbrdip;

  if XParam[XP_ANTICIPA_FLEXPM_CAUS] then
    FlexPM_CausEsluse; //Pausa caffè Firenze - LaSpezia

  //Alberto: FIRENZE_COMUNE - verifica delle abilitazioni allo straordinario
  //Si esegue una 'passata' preliminare sulla z100 che poi dovrà essere rifatta definitivamente
  if cdsT020.FieldByName('PMT_TIMB_AUTORIZZATE').AsString = 'S' then
  begin
    calcolo_z100:=False;
    ieu:=1;
    while (ieu <= n_timbrdip) and (blocca = 0) do
    begin
      z100_coppieEU;
      inc(ieu);
    end;
  end;
  Cambiato:=False;
  if cdsT020.FieldByName('PMT_TIMB_MATURAMENSA').AsString  = 'S' then
  begin
    ieu:=1;
    while ieu <= n_timbrdip do
    begin
      if ((ieu = 1) and (ValStrT275[ttimbraturedip[ieu].tcausale_u.tcaus,'MATURAMENSA'] <> 'N'))
         or
         ((ieu = n_timbrdip) and (ValStrT275[ttimbraturedip[ieu].tcausale_e.tcaus,'MATURAMENSA'] <> 'N')) then
      begin
        inc(ieu);
        Continue;
      end
      else if (ValStrT275[ttimbraturedip[ieu].tcausale_e.tcaus,'MATURAMENSA'] = 'N') and
              (ValStrT275[ttimbraturedip[ieu].tcausale_u.tcaus,'MATURAMENSA'] = 'N') and
              not (R180CarattereDef(ttimbraturedip[ieu].tcausale_e.tcauscon) in ['A','E']) and
              not (R180CarattereDef(ttimbraturedip[ieu].tcausale_u.tcauscon) in ['A','E']) then
      begin
        indice:=ieu;
        z802_toglitimbr;
        Cambiato:=True;
      end
      else if (ValStrT275[ttimbraturedip[ieu].tcausale_e.tcaus,'MATURAMENSA'] = 'N') and
              not (R180CarattereDef(ttimbraturedip[ieu].tcausale_e.tcauscon) in ['A','E']) and
              (ValStrT275[ttimbraturedip[ieu].tcausale_u.tcaus,'MATURAMENSA'] <> 'N') and
              (ieu > 1) then
      begin
        ttimbraturedip[ieu]:=ttimbraturedip[ieu - 1];
        indice:=ieu - 1;
        z802_toglitimbr;
        Cambiato:=True;
      end
      else if (ValStrT275[ttimbraturedip[ieu].tcausale_e.tcaus,'MATURAMENSA'] <> 'N') and
              (ValStrT275[ttimbraturedip[ieu].tcausale_u.tcaus,'MATURAMENSA'] = 'N') and
              not (R180CarattereDef(ttimbraturedip[ieu].tcausale_u.tcauscon) in ['A','E']) and
              (ieu < n_timbrdip) then
      begin
        ttimbraturedip[ieu]:=ttimbraturedip[ieu + 1];
        indice:=ieu + 1;
        z802_toglitimbr;
        Cambiato:=True;
      end
      else
        inc(ieu);
    end;
  end;
  //Alberto 15/07/2009: se ci sono solo giustificativi, elimino le timbrature fittizie (per es. quella delle 12.00) per consentire il calcolo della PM sui soli giustificativi effettivi
  if conteggi_sologiust then
  begin
    for i:=n_timbrdip downto 1 do
    begin
      indice:=i;
      z802_toglitimbr;
    end;
    Cambiato:=True;
  end;
  for i:=1 to n_giusdaa do
  begin
    //Considera:=False;
    if tgius_dallealle[i].tassenza then
      Considera:=ValStrT265[tgius_dallealle[i].tcausdaa,'TIMB_PM'] = 'S'
    else
      Considera:=ValStrT275[tgius_dallealle[i].tcausdaa,'TIMB_PM'] = 'S';
    if Considera then
    begin
      //Alberto 15/09/2009 - TORINO_COMUNE: verifico ulteriormente che il giustificativo non sia già compreso in una coppia di timbrature
      //questo può capitare quando il giust. arriva da autogiustificazione da causale di presenza per lavoro fuori sede 
      for j:=1 to n_timbrdip do
        if ((tgius_dallealle[i].tminutida >= ttimbraturedip[j].tminutid_e) and
            (tgius_dallealle[i].tminutida < ttimbraturedip[j].tminutid_u))
           or
           ((tgius_dallealle[i].tminutia > ttimbraturedip[j].tminutid_e) and
            (tgius_dallealle[i].tminutia <= ttimbraturedip[j].tminutid_u))
           then
        begin
          Considera:=False;
          Break;
        end;
      if not Considera then
        Continue;
      Cambiato:=True;
      indice:=n_timbrdip + 1;
      for j:=1 to n_timbrdip do
        if tgius_dallealle[i].tminutida <= ttimbraturedip[j].tminutid_e then
        begin
          indice:=j;
          break;
        end;
      z816_insetimbr;
      ttimbraturedip[indice].tminutid_e:=tgius_dallealle[i].tminutida;
      ttimbraturedip[indice].tminutid_u:=tgius_dallealle[i].tminutia;
      ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
      ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
      ttimbraturedip[indice].tflagarr_u:='si';
      ttimbraturedip[indice].tflagarr_e:='si';
      ttimbraturedip[indice].tpuntnomin:=0;
      z061_appoggioc1(indice);
      if ttimbraturedip[indice].tpuntnomin = 0 then
      begin
        ttimbraturedip[indice].tcausale_e.tcaus:='######';
        ttimbraturedip[indice].tcausale_u.tcaus:='######';
      end;
    end;
  end;
  //Annullo eventuali causali P.M precedenti
  if Cambiato then
    for i:=1 to MaxTimbrature do
    begin
      if ttimbraturedip[i].tcausale_e.tcaus = CAUS_PM then
        ttimbraturedip[i].tcausale_e:=tcausale_vuota;
      if ttimbraturedip[i].tcausale_u.tcaus = CAUS_PM then
        ttimbraturedip[i].tcausale_u:=tcausale_vuota;
    end;
  if Cambiato or (not calcolo_z100) then
  begin
    z496_inscausPM;
    calcolo_z100:=True;
  end;

  //Gestione prima E con pausa mensa - annulla l'eventuale causale di pausa mensa
  if (n_timbrdip >= 1) and (ttimbraturedip[1].tcausale_e.tcaus <> '') and (ttimbraturedip[1].tcausale_e.tcaustip = 'C') and
     (ttimbraturedip[1].tcausale_e.tcausrag = traggrgius.C) then
  begin
    tcausale.tcaus:=ttimbraturedip[1].tcausale_e.tcaus;
    z098_anom2caus(7);
    ttimbraturedip[1].tcausale_e.tcaus:='';
  end;
  //Gestione ultima U con pausa mensa - annulla l'eventuale causale di pausa mensa
  if (n_timbrdip >= 1) and (ttimbraturedip[n_timbrdip].tcausale_u.tcaus <> '') and (ttimbraturedip[n_timbrdip].tcausale_u.tcaustip = 'C') and
     (ttimbraturedip[n_timbrdip].tcausale_u.tcausrag = traggrgius.C) then
  begin
    tcausale.tcaus:=ttimbraturedip[n_timbrdip].tcausale_u.tcaus;
    z098_anom2caus(7);
    ttimbraturedip[n_timbrdip].tcausale_u.tcaus:='';
  end;
  //Alberto 17/03/2010: eliminazione dello stacco di mensa P.M se le timbrature sono contigue e una delle 2 non è appoggiata all'orario (cioè si tratta di prolungamento)
  if XParam[XP_TC_NO_PROLUNG_PMT] then
  begin
    for i:=1 to n_timbrdip - 1 do
      if (ttimbraturedip[i].tcausale_u.tcaus = CAUS_PM) and
         (ttimbraturedip[i + 1].tcausale_e.tcaus = CAUS_PM) and
         (ttimbraturedip[i + 1].tminutid_e - ttimbraturedip[i].tminutid_u = 0) and
         ((ttimbraturedip[i].tpuntnomin = 0) or (ttimbraturedip[i + 1].tpuntnomin = 0)) then
      begin
        ttimbraturedip[i].tcausale_u:=tcausale_vuota;
        ttimbraturedip[i + 1].tcausale_e:=tcausale_vuota;
      end;
  end
  //else if cdsT020.FieldByName('PMT_NOTIMBCONSECUTIVE').AsString = 'S' then
  else if ValNumT020['PMT_STACCOMIN'] > 0 then
    //Alberto 31/08/2010: eliminazione dello stacco di mensa P.M se le timbrature sono contigue
    for i:=1 to n_timbrdip - 1 do
      if (ttimbraturedip[i].tcausale_u.tcaus = CAUS_PM) and
         (ttimbraturedip[i + 1].tcausale_e.tcaus = CAUS_PM) and
         //(ttimbraturedip[i + 1].tminutid_e - ttimbraturedip[i].tminutid_u = 0)
         (ttimbraturedip[i + 1].tminutid_e - ttimbraturedip[i].tminutid_u < ValNumT020['PMT_STACCOMIN'])
      then
      begin
        ttimbraturedip[i].tcausale_u:=tcausale_vuota;
        ttimbraturedip[i + 1].tcausale_e:=tcausale_vuota;
      end;
  //Alberto 31/08/2010: eliminazione dello stacco di mensa P.M se è richiesta l'uscita dopo ora max
  if cdsT020.FieldByName('PMT_USCITARIT').AsString = 'S' then
  begin
    UMax:=ValNumT021['USCITAMM',TF_PM_AUTO,1];
    if UMax > 0 then
    begin
      EsisteUMax:=False;
      for i:=1 to n_timbrdip do
        if (ttimbraturedip[i].tminutid_e <= UMax) and (ttimbraturedip[i].tminutid_u > UMax) then
        begin
          EsisteUMax:=True;
          Break;
        end;
      if not EsisteUMax then
        for i:=1 to n_timbrdip - 1 do
        if (ttimbraturedip[i].tcausale_u.tcaus = CAUS_PM) and
           (ttimbraturedip[i + 1].tcausale_e.tcaus = CAUS_PM) then
        begin
          ttimbraturedip[i].tcausale_u:=tcausale_vuota;
          ttimbraturedip[i + 1].tcausale_e:=tcausale_vuota;
        end;
    end;
  end;
  //Verifica accoppiamento U - E e conteggio per pausa mensa
  i1:=1;
  while (i1 < n_timbrdip) and (blocca = 0) do
  begin
    z084_pausamecop;
    inc(i1);
  end;
  if not XParam[XP_ANTICIPA_FLEXPM_CAUS] then
    FlexPM_CausEsluse;  //Pausa caffè Firenze - LaSpezia
  //Torino_HMauriziano - 12/02/2009: se la timbratura di mensa fa scattare la detrazione per pausa mensa automatica, si estende la flessibilità in modo da poter recuperare la pausa in uscita
  //Si richiede che TIMBRATURAMENSA_DETRAZIONE sia esplicitamente dichiarata
  if (idxFlexPM <> 0) and
     (paumenges = 'no') and
     z149_EsisteTimbraturaMensa(cdsT020.FieldByName('TimbraturaMensa').AsString) and
     (PausaMensa = 'C') and
     (cdsT020.FieldByName('TimbraturaMensa_Flex').AsString = 'S') then
  begin
    FlexPM:=IfThen(cdsT020.FieldByName('TIMBRATURAMENSA_DETRAZIONE').IsNull,IfThen(cdsT020.FieldByName('PausaMensa_Automatica').IsNull,ValNumT020['MMMINIMI'],ValNumT020['PausaMensa_Automatica']),ValNumT020['TIMBRATURAMENSA_DETRAZIONE']);
    FlexPM:=z132_FlexPM(FlexPM,idxFlexPM);
    inc(ttimbraturenom[idxFlexPM].tminutin_u,FlexPM);
    inc(ttimbraturenom[idxFlexPM].Flex,FlexPM);
    inc(ttimbraturenom[idxFlexPM].FlexPM,FlexPM);
  end;

  if Cambiato or (cdsT020.FieldByName('PMT_TIMB_AUTORIZZATE').AsString  = 'S') then
  begin
    //Primo ciclo per confermare eventuali arrotondamenti sulle timbrature originali applicati sulle timbrature di pausa mensa
    CheckTimbratureArrotondate;
    //Secondo ciclo per ripristinare le timbrature originali
    for i:=1 to MaxTimbrature do
      ttimbraturedip[i]:=ttimbratureapp[i];
    n_timbrdip:=n_timbrapp;
  end;
  paumendet_strgiorn:=paumendet;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z058_oreteotur;
{Calcolo ore teoriche da svolgere per tipo orario a turni}
var i,xx:Integer;
    comodo9:array of Byte;
begin
  SetLength(comodo9,Length(ttimbraturenom));
  for xx:=Low(Comodo9) to High(Comodo9) do Comodo9[xx]:=0;
  comodo2:=0;
  for i:=1 to n_timbrdip do
    begin
    p1:=ttimbraturedip[i].tpuntnomin;
    if (p1 <> 0) and (comodo9[p1] = 0) then
      begin
      //Cumulo di un turno o sua tranche se a cavallo di mezzanotte
      comodo3:=ttimbraturenom[p1].tminutin_u - ttimbraturenom[p1].tminutin_e;
      inc(oreteoturni,comodo3);
      comodo9[p1]:=1;
      if comodo2 = 0 then
        //Verifica se turno con mensa
        //Test se la coppia di timbrature nominali interseca la
        //fascia oraria per detrazione automatica
        if (ttimbraturenom[p1].tminutin_u > ValNumT021['ENTRATAMM',TF_PM_AUTO,1]) and
           (ttimbraturenom[p1].tminutin_e < ValNumT021['USCITAMM',TF_PM_AUTO,1]) then
          if (comodo3 >= ValNumT021['OreMinime',TF_PM_AUTO,1]) and (PausaMensa <> 'Z') then
            //Turno con detrazione di pausa mensa
            inc(comodo2,ValNumT020['mmMinimi']);
      end;
    end;
  //Eventuale detrazione di pausa mensa
  dec(oreteoturni,comodo2);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z060_appoggio(DueTurni:Boolean);
var i,j:Integer;
begin
  //Le gestioni che spezzano le timbrature vengono eseguite solo dopo aver scelto l'orario definitivo (DueTurni)
  if (TipoOrario = 'E') (*4.0*)and (DueTurni) then
    //Gestione due turni lavorati consecutivamente
    z512_spezztimb;

  //Salvo timbrature originali
  SetLength(ttimbraturedip_bck,0);
  if EsisteGiustificativo['D', 'SCELTA_ORARIO', 'S'] then
    z817_salva_timbraturedip;
  try
    //aggiungo giustificativi dalle..alle e unifico timbrature contigue
    z446_InsTimbDaGiustAss;
    //Calcolo timbrature nominali di appoggio per timbrature dipendente
    for i:=1 to n_timbrdip do
      z061_appoggioc1(i);
  finally
    //Ripristino timbrature originali assegnando il punto nominale
    for i:=0 to High(ttimbraturedip_bck) do
    begin
      for j:=1 to n_timbrdip do
        if (ttimbraturedip_bck[i].tminutid_e >= ttimbraturedip[j].tminutid_e) and
           (ttimbraturedip_bck[i].tminutid_u >= ttimbraturedip[j].tminutid_u) then
        begin
          ttimbraturedip_bck[i].tpuntnomin:=ttimbraturedip[j].tpuntnomin;
          ttimbraturedip_bck[i].tpuntnominold:=ttimbraturedip[j].tpuntnominold;
        end;
    end;
    if EsisteGiustificativo['D', 'SCELTA_ORARIO', 'S'] then
      z818_ripristina_timbraturedip;
    SetLength(ttimbraturedip_bck,0);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z061_appoggioc1(i:Integer);
var T:Integer;
  function CheckOreMinime(PN,idx:Integer):Boolean;
  var x,s:Integer;
  begin
    Result:=False;
    if max(ttimbraturenom[PN].tpuntre,ttimbraturenom[PN].tpuntru) = 0 then
      exit;

    s:=0;
    for x:=1 to idx do
      if (ttimbraturedip[x].tpuntnomin = PN) and ((ttimbraturedip[x].tcausale_e.tcaus = '') or (ttimbraturedip[x].tcausale_e.tcaus <> ttimbraturedip[x].tcausale_u.tcaus)) then
        inc(s,ttimbraturedip[x].tminutid_u - ttimbraturedip[x].tminutid_e);

    Result:=s > ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,max(ttimbraturenom[PN].tpuntre,ttimbraturenom[PN].tpuntru)] div 3;
  end;
begin
  //Calcolo timbr. nominali di appoggio per timbr. dipendente
  ttimbraturedip[i].tpuntnomin:=0;
  ttimbraturedip[i].tpuntnominold:=0;
  comodo1:=9999;
  comodo2:=Low(Integer);
  //Se orario a turni e coppia timbrature dipendente precedente
  //appoggiata e coppia timbrature dipendente attuale interseca
  //coppia timbrature nominali dell'appoggio e
  //uscita dipendente diversa da mezzanotte,
  //si appoggia coppia timbrature dipendente attuale come la
  //precedente per gestire correttamente la pausa mensa
  if (i > 1) and (TipoOrario = 'E') and (PausaMensa <> 'Z') and
     (ttimbraturedip[i-1].tpuntnomin <> 0) and
     (ttimbraturedip[i-1].tminutid_u < ValNumT021['USCITAMM',TF_PM_TIMBRATA,1]) and
     (ttimbraturedip[i].tminutid_e > ValNumT021['ENTRATAMM',TF_PM_TIMBRATA,1])
  then
    if ((ttimbraturedip[i-1].tcausale_e.tcaus = '') or
        (ttimbraturedip[i-1].tcausale_e.tcaustip = 'C') or
        (ttimbraturedip[i-1].tcausale_e.tcauscon = 'A') or
        (ttimbraturedip[i-1].tcausale_e.tcaus <> ttimbraturedip[i-1].tcausale_u.tcaus))
    then
    begin
      T:=ttimbraturedip[i-1].tpuntnomin;
      if (ttimbraturedip[i].tminutid_u > ttimbraturenom[T].tminutin_e) and
         (ttimbraturedip[i].tminutid_e < ttimbraturenom[T].tminutin_u) and
         (ttimbraturedip[i].tminutid_u < 1440)
      then
        if (not XParam[XP_Z061_HHMINIME_APPOGGIO_PM]) or  //parametro appoggio "Speciale"
           CheckOreMinime(T,i-1)
        then
        begin
          ttimbraturedip[i].tpuntnomin:=ttimbraturedip[i-1].tpuntnomin;
          ttimbraturedip[i].tpuntnominold:=ttimbraturedip[i-1].tpuntnominold;
          if R180In(ttimbraturedip[i].tcausale_u.tcauscon,['C','D']) then
          begin
            ttimbraturedip[i-1].tpesopuntnomin:=0;
            ttimbraturedip[i].tpesopuntnomin:=0;
          end;
          exit;
        end;
    end;

  for T:=1 to n_timbrnom do
    z062_appoggioc2(i,T);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z062_appoggioc2(i,T:Integer);
var NotteSuEntrata_z062,PrimaTimbPN:Boolean;
    EDip,UDip,ENom,UNom,j:Integer;
    //MMAnticipoE,MMAnticipoU,MMRitardoE,MMRitardoU:Integer;
{Calcolo appoggio per i1_esima timbratura dipendente}
begin
  //Calcolo in comodo3 il peso della timbratura i rispetto al punto nominale T
  EDip:=-1;
  UDip:=-1;
  if XParam[XP_Z062_APPOGGIO_TIMBORIG] and (not conteggi_sologiust) and ((pianif = 'no') or (l08_turno1 = 0)) then
  begin
    for j:=0 to High(TimbratureOriginali) do
    begin
      if R180Between(ttimbraturedip[i].tminutid_e,TimbratureOriginali[j].e,TimbratureOriginali[j].u) and
         R180Between(ttimbraturedip[i].tminutid_u,TimbratureOriginali[j].e,TimbratureOriginali[j].u) then
      begin
        EDip:=TimbratureOriginali[j].e;
        UDip:=TimbratureOriginali[j].u;
        if (TipoOrario = 'E') and (cdsT020.FieldByName('Regole_Profilo').AsString = 'S') and
           (selT220.FindField('IGNORA_STACCOPMT') <> nil) and (T220[selT220.FieldByName('IGNORA_STACCOPMT').Index] = 'S') and
           (j < High(TimbratureOriginali)) and (UDip < FineMensa) and (TimbratureOriginali[j + 1].e > InizioMensa) then
          UDip:=TimbratureOriginali[j + 1].u;
        Break;
      end;
    end;
  end;

  if (EDip = -1) and (UDip = -1) then
  begin
    EDip:=ttimbraturedip[i].tminutid_e;
    UDip:=ttimbraturedip[i].tminutid_u;
    if (TipoOrario = 'E') and (cdsT020.FieldByName('Regole_Profilo').AsString = 'S') and
       (selT220.FindField('IGNORA_STACCOPMT') <> nil) and (T220[selT220.FieldByName('IGNORA_STACCOPMT').Index] = 'S') and
       (i < n_timbrdip) and (UDip < FineMensa) and (ttimbraturedip[i + 1].tminutid_e > InizioMensa) then
      UDip:=ttimbraturedip[i + 1].tminutid_u;
  end;

  if conteggi_sologiust then
  //Alberto: se timbrature introdotte per consentire il conteggio dei giustificativi il controllo è diverso
  //per consentire di appoggiare la timbratura fittizia anche se è uguale all'entrata nominale (es. e=u=08.00 = tminutin_e)
  begin
    if ((UDip <= ttimbraturenom[T].tminutin_e) and (EDip < ttimbraturenom[T].tminutin_e)) or
       ((EDip >= ttimbraturenom[T].tminutin_u) and ((UDip > ttimbraturenom[T].tminutin_u))) then
      exit;
  end
  else
  begin
    if (UDip <= ttimbraturenom[T].tminutin_e) or
       (EDip >= ttimbraturenom[T].tminutin_u) then
      exit;
  end;

  //Calcolo in comodo3 il peso della timbratura i rispetto al punto nominale T
  ENom:=ttimbraturenom[T].tminutin_e;
  UNom:=ttimbraturenom[T].tminutin_u;
  //Alberto 03/07/2015: se timbrature a cavallo di mezzanotte e punto nominale a cavallo di mezzanotte, considero timbrature e punto nominale interamente, per evitare di confrontare solo lo spezzone parziale del giorno corrente
  //Solamente se orario a turni e non ci sono turni pianificati
  if (XParam[XP_Z062_APPOGGIO_TURNONOTT]) and (TipoOrario = 'E') and (turnicavmez = 'si') and (not NotteSuEntrata) and (l08_Turno1 = 0) and (l08_Turno2 = 0) then
  begin
    if (EDip = 0) and (primat_u = 'si') and (estimbprec = 'si') and (verso_pre = 'E') then
      EDip:=minuti_pre - 1440;
    if (UDip = 1440) and (ultimt_e = 'si') and (estimbsucc = 'si') and (verso_suc = 'U') then
      UDip:=minuti_suc + 1440;
    if ttimbraturenom[T].tpuntre = 0 then
      ENom:=ttimbraturenom[T].tminutin_e_ori - 1440;
    if ttimbraturenom[T].tpuntru = 0 then
      UNom:=ttimbraturenom[T].tminutin_u_ori + 1440;
    (*Considerare anche i parametri di anticipo/ritardo??
      vedi PA1, progr. 2442, 02/12/2014
    MMAnticipoE:=ValNumT021['MMAnticipo',TF_PUNTI_NOMINALI,IfThen(ttimbraturenom[T].tpuntre > 0,ttimbraturenom[T].tpuntre,ttimbraturenom[T].tpuntru)];
    MMAnticipoU:=ValNumT021['MMAnticipoU',TF_PUNTI_NOMINALI,IfThen(ttimbraturenom[T].tpuntre > 0,ttimbraturenom[T].tpuntre,ttimbraturenom[T].tpuntru)];
    MMRitardoE:=ValNumT021['MMRitardo',TF_PUNTI_NOMINALI,IfThen(ttimbraturenom[T].tpuntre > 0,ttimbraturenom[T].tpuntre,ttimbraturenom[T].tpuntru)];
    MMRitardoU:=ValNumT021['MMRitardoU',TF_PUNTI_NOMINALI,IfThen(ttimbraturenom[T].tpuntre > 0,ttimbraturenom[T].tpuntre,ttimbraturenom[T].tpuntru)];
    if R180Between(EDip,ENom - MMAnticipoE,ENom + MMRitardoE) then
      EDip:=ENom;
    if R180Between(UDip,UNom - MMAnticipoU,UNom + MMRitardoU) then
      UDip:=UNom;
    *)
  end;
  //copertura dell'intervallo nominale
  comodo3:=Min(UNom,UDip) - Max(EDip,ENom);
  //scostamento assoluto dai punti nominali
  if XParam[XP_Z062_PENALIZZA_OREESTERNE] then
  begin
    //Dò peso sfavorevole doppio per i minuti fuori dai punti nominali
    dec(comodo3,max(0,EDip - ENom));
    dec(comodo3,max(0,ENom - EDip)*2);
    dec(comodo3,max(0,UNom - UDip));
    dec(comodo3,max(0,UDip - UNom)*2);
  end
  else
  begin
    dec(comodo3,Abs(EDip - ENom));
    dec(comodo3,Abs(UDip - UNom));
  end;
  //Applicazione delle regole di scelta del profilo
  if (TipoOrario = 'E') and (cdsT020.FieldByName('Regole_Profilo').AsString = 'S') then
  begin
    //Lettura del profilo orario (nel caso di pianificazione)
    z052_profiloorar;
    //Scostamento sull'Entrata
    if (T220[selT220.FieldByName('ScostEntrata').Index] = 'S') then
      //dec(comodo3,30 * Abs(EDip - ENom));
      dec(comodo3,Abs(EDip - ENom) * StrToIntDef(T220[selT220.FieldByName('PESO_SCOSTENTRATA_S').Index],PESO_SCOSTENTRATA_S));
    //Anticipo sull'Uscita
    if (Max(0,UNom - UDip) > minantscelta) then
      //dec(comodo3,1000);
      dec(comodo3,StrToIntDef(T220[selT220.FieldByName('Peso_MinAntScelta').Index],PESO_MINANTSCELTA));
    //Ritardo sull'Entrata
    PrimaTimbPN:=True;
    //Valuto solo se prima timbratura con quel punto nominale
    for j:=1 to i - 1 do
      if ttimbraturedip[j].tpuntnomin = T then
      begin
        PrimaTimbPN:=False;
        Break;
      end;
    if PrimaTimbPN and
       (StrToIntDef(T220[selT220.FieldByName('Ritardo_Entrata').Index],-1) >= 0) and
       (Max(0,EDip - ENom) > StrToInt(T220[selT220.FieldByName('Ritardo_Entrata').Index])) then
      //dec(comodo3,10000);
      dec(comodo3,StrToIntDef(T220[selT220.FieldByName('PESO_RITARDO_ENTRATA').Index],PESO_RITARDO_ENTRATA));
  end;

  //Gestione coppia di E-U coincidenti
  if ttimbraturedip[i].tminutid_e = ttimbraturedip[i].tminutid_u then
  begin
    //21/02/2003 Alberto: Se E-U coincidenti causalizzate come pausa mensa, si toglie l'appoggio
    if (ttimbraturedip[i].tcausale_e.tcaus = CAUS_PM) or (ttimbraturedip[i].tcausale_u.tcaus = CAUS_PM) then
    begin
      ttimbraturedip[i].tpuntnomin:=0;
      ttimbraturedip[i].tpuntnominold:=0;
    end
    else
    begin
      ttimbraturedip[i].tpuntnomin:=T;
      ttimbraturedip[i].tpuntnominold:=T;
      ttimbraturedip[i].tpesopuntnomin:=comodo3;
    end;
    exit;
  end;
  //Lettura della condizione che attiva il conteggio NotteSuEntrata, per appoggiare le timbrature sulla mezzanotte
  NotteSuEntrata_z062:=(TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and
                       (cdsT020.FieldByName('FrazDeb').AsString = 'N') and (cdsT020.FieldByName('NotteEntrata').AsString = 'S') and
                       (Trim(f03_com) = '') and
                       ((ultimt_e = 'si') or (primat_u = 'si') or
                       (*((pianif = 'si') and (turnicavmez = 'si') and (l08_turno1EU <> ''))*)
                        EsisteTurnoNotturnoPianificato  //Alberto 27/10/2009: sostituito al test precedente per gestire meglio la flessibilità a cavallo di mezzanotte quando si entra dopo mezzanotte
                       );
  //NotteSuEntrata_z062:=False;
  //Se orario con turni a cavallo di mezzanotte, ultima T=E e
  //l'Uscita seguente non e' causalizzata oppure
  //e' causalizzata ma successiva alla nominale,
  //si appoggia l'Entrata solo sui cavalli
  if (TipoOrario = 'E') and (turnicavmez = 'si') and (ultimt_e = 'si') then
    if (ttimbraturedip[i].tminutid_u = 1440) and (ttimbraturenom[T].tpuntru <> 0) and (not NotteSuEntrata_z062) then
      if (caus_suc = '') or (minuti_suc > ttimbraturenom[1].tminutin_u) then
        exit;
   //Se orario con turni a cavallo di mezzanotte, prima T=U e
   //l'Entrata precedente non e' causalizzata oppure
   //e' causalizzata ma precedente alla nominale,
   //si appoggia l'Uscita solo sui cavalli
   if (TipoOrario = 'E') and (turnicavmez = 'si') and (primat_u = 'si') then
     if (ttimbraturedip[i].tminutid_e = 0) and (ttimbraturenom[T].tpuntre <> 0) and (not NotteSuEntrata_z062) then
       if (caus_pre = '') or (minuti_pre < ttimbraturenom[n_timbrnom].tminutin_e) then
         exit;
  //Verifica di quanto la coppia di timbrature dipendente sovrappone quella nominale
  //e di quanto e' distante da quella nominale
  (*
  comodo3:=Min(ttimbraturenom[T].tminutin_u,ttimbraturedip[i].tminutid_u) - Max(ttimbraturedip[i].tminutid_e,ttimbraturenom[T].tminutin_e);
  dec(comodo3,Abs(ttimbraturedip[i].tminutid_e - ttimbraturenom[T].tminutin_e));
  dec(comodo3,Abs(ttimbraturedip[i].tminutid_u - ttimbraturenom[T].tminutin_u));
  //Applicazione delle regole di scelta del profilo
  if (TipoOrario = 'E') and (cdsT020.FieldByName('Regole_Profilo').AsString = 'S') then
  begin
    //Lettura del profilo orario (nel caso di pianificazione)
    z052_profiloorar;
    //Scostamento sull'Entrata
    if (T220[selT220.FieldByName('ScostEntrata.Index] = 'S') then
      dec(comodo3,30 * Abs(ttimbraturedip[i].tminutid_e - ttimbraturenom[T].tminutin_e));
    //Anticipo sull'Uscita
    if (Max(0,ttimbraturenom[T].tminutin_u - ttimbraturedip[i].tminutid_u) > minantscelta) then
      dec(comodo3,1000);
    //Ritardo sull'Entrata
    if (StrToIntDef(T220[selT220.FieldByName('Ritardo_Entrata.Index],-1) >= 0) and
       (Max(0,ttimbraturedip[i].tminutid_e - ttimbraturenom[T].tminutin_e) > StrToInt(T220[selT220.FieldByName('Ritardo_Entrata.Index])) then
      dec(comodo3,10000);
  end;
  if comodo3 > comodo2 then
  begin
    //Cambio puntatore alla coppia di E - U nominale
    ttimbraturedip[i].tpuntnomin:=T;
    ttimbraturedip[i].tpuntnominold:=T;
    comodo2:=comodo3;
  end
  else if (comodo3 = comodo2) and (comodo1 > Abs(ttimbraturedip[i].tminutid_e - ttimbraturenom[T].tminutin_e)) then
  begin
    //Cambio puntatore alla coppia di E - U nominale
    ttimbraturedip[i].tpuntnomin:=T;
    ttimbraturedip[i].tpuntnominold:=T;
  end;
  comodo1:=Abs(ttimbraturedip[i].tminutid_e - ttimbraturenom[T].tminutin_e);
  *)
  if comodo3 > comodo2 then
  begin
    //Cambio puntatore alla coppia di E - U nominale
    ttimbraturedip[i].tpuntnomin:=T;
    ttimbraturedip[i].tpuntnominold:=T;
    ttimbraturedip[i].tpesopuntnomin:=comodo3;
    comodo2:=comodo3;
  end
  else if (comodo3 = comodo2) and (comodo1 > Abs(EDip - ENom)) then
  begin
    //Cambio puntatore alla coppia di E - U nominale
    ttimbraturedip[i].tpuntnomin:=T;
    ttimbraturedip[i].tpuntnominold:=T;
  end;
  comodo1:=Abs(EDip - ENom);
end;
//________________________________________________________________
procedure TR502ProDtM1.z064_causali;
{Lettura e primi controlli su causali}
begin
  tcausale:=ttimbraturedip[i1].tcausale_e;
  z066_causalic;
  ttimbraturedip[i1].tcausale_e:=tcausale;
  tcausale:=ttimbraturedip[i1].tcausale_u;
  z066_causalic;
  ttimbraturedip[i1].tcausale_u:=tcausale;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z066_causalic;
begin
  if (tcausale.tcaus = '') or (tcausale.tcaus = CAUS_PM) then exit;
  z964_leggicaus(tcausale.tcaus);
  if s_trovato = 'no' then
  begin
    z098_anom2caus(1);
    exit;
  end;
  if parcaus.l29_1paramet = 'A' then
  begin
    z098_anom2caus(2);
    exit;
  end;
  if parcaus.l29_1paramet = 'B' then
    z965_SettaCausPres(tcausale)
  else
  with tcausale do
  begin
    tcaustip:=parcaus.l29_1paramet;
    tcauscodrag:=parcaus.l29_2paramet;
    tcausrag:=parcaus.l29_Ragg;
    tcauscon:='';
    tcausrip:='';
    tcausioe:='';
    tcausarr:=0;
    tcauspiu:=0;
    tcausrpl:='B';
    tNonAutorizzate:='';
    tOreInsufficenti:='';
    tcausmatmensa:='';
    tminminuti:=0;
    tmaxminuti:=0;
    tpianrep:='';
    tLfsCavMez:='N';
  end;
  //Verifica se causale abilitata
  with tcausale do
  begin
    tcausabi:='no';
    if tcaustip = 'B' then
      z068_causpresab
    else if tcausrag = traggrgius.C then
      z070_causpmenab
    else if tcaustip = 'C' then
      tcausabi:='si';
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z068_causpresab;
{Verifica se causale presenza abilitata}
var SQL:String;
    Lst: TStringList;
    i: Integer;
    Firma, RisultatoElaborazione:String;
begin
  with TStringList.Create do
  begin
    CommaText:=Q430.FieldByName('AbPresenza1').AsString;
    if IndexOf(tcausale.tcauscodrag) >= 0 then
      tcausale.tcausabi:='si'
    else
    begin
      tcausale.tcausabi:='no';
      //Alberto 24/11/2013: la causale non abilitata può generare anomalia bloccante
      if CausaleDisabilBloccante then
        Blocca:=1;
    end;
    Free;
  end;
  if cdsT020.Active and (tcausale.tcausabi = 'si') and R180In(tcausale.tcaus,['35','83']) and XParam[XP_Z068_NO83] then
    tcausale.tcausabi:='no';

  if tcausale.tcausabi = 'si' then
  begin
    //Verifico eventuale condizione di validità sql per la causale (T235.CONDIZIONE_VALIDITA)
    SQL:=ValStrT275[tcausale.tcaus,'CONDIZIONE_ABILITAZIONE'];
    if Trim(SQL) <> '' then
    begin
      selCdzAbilitazione.ClearVariables;
      selCdzAbilitazione.SQL.Clear;
      selCdzAbilitazione.SQL.Text:=Format('select (%s) from dual',[Trim(SQL)]);
      try
        Lst:=FindVariables(selCdzAbilitazione.SQL.Text, False);
        if Lst.Count > 1 then
        begin
          for i:=0 to Lst.Count - 1 do
          begin
            if UpperCase(Lst[i]) = 'DATA' then
            begin
              selCdzAbilitazione.DeclareVariable(Lst[i], otDate);
              selCdzAbilitazione.SetVariable(Lst[i],datacon);
            end
            else if UpperCase(Lst[i]) = 'PROGRESSIVO' then
            begin
              selCdzAbilitazione.DeclareVariable(Lst[i], otInteger);
              selCdzAbilitazione.SetVariable('PROGRESSIVO',progrcon);
            end
            else if UpperCase(Lst[i]) = 'CAUSALE' then
            begin
              selCdzAbilitazione.DeclareVariable(Lst[i], otString);
              selCdzAbilitazione.SetVariable('CAUSALE',tcausale.tcaus);
            end;
          end;
        end;
      finally
        Lst.Free;
      end;
      Firma:=DateToStr(datacon) + ';' + IntToStr(progrcon) + ';' + tcausale.tcaus;
      RisultatoElaborazione:=EsistePrecedenteElaborazione(Firma);
      try
        if RisultatoElaborazione = '' then
        begin
          selCdzAbilitazione.Execute;
          AggiungiPrecedenteElaborazione(Firma, selCdzAbilitazione.FieldAsString(0));
          RisultatoElaborazione:=selCdzAbilitazione.FieldAsString(0);
        end;
        if RisultatoElaborazione = 'N' then
        begin
          if z097_anom2caus_conteggio(67,tcausale.tcaus) = 0 then
            z098_anom2caus(67,tcausale.tcaus);
          tcausale.tcausabi:='no';
        end
        else if RisultatoElaborazione = 'A' then
        begin
          if z097_anom2caus_conteggio(9,tcausale.tcaus) = 0 then
            z098_anom2caus(9,tcausale.tcaus);
          if z097_anom2caus_conteggio(67,tcausale.tcaus) = 0 then
            z098_anom2caus(67,tcausale.tcaus);
          tcausale.tcaus:='';
        end;
      except
        on E:Exception do
        begin
          z099_anom3(12,ttimbraturedip[i1].tminutid_e,'');
          SetLength(tanom3riscontrate[n_anom3].ta3param,2);
          tanom3riscontrate[n_anom3].ta3param[0]:=tcausale.tcaus;
          tanom3riscontrate[n_anom3].ta3param[1]:=E.Message;
        end;
      end;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z070_causpmenab;
{Verifica se causale pausa mensa abilitata}
begin
  if (c_orario <> '') and (PausaMensa <> 'Z') then
    tcausale.tcausabi:='si';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z071_salvatimbrature;
var i:Integer;
begin
  SetLength(TimbratureOriginali,n_timbrdip);
  for i:=1 to n_timbrdip do
  begin
    TimbratureOriginali[i - 1].e:=ttimbraturedip[i].tminutid_e;
    TimbratureOriginali[i - 1].u:=ttimbraturedip[i].tminutid_u;
    TimbratureOriginali[i - 1].ril_e:=ttimbraturedip[i].trilev_e;
    TimbratureOriginali[i - 1].ril_u:=ttimbraturedip[i].trilev_u;
    TimbratureOriginali[i - 1].caus_e:=ttimbraturedip[i].tcausale_e.tcaus;
    TimbratureOriginali[i - 1].caus_u:=ttimbraturedip[i].tcausale_u.tcaus;
    TimbratureOriginali[i - 1].esiste_e:=ttimbraturedip[i].tag <> 'E=null';
    TimbratureOriginali[i - 1].esiste_u:=ttimbraturedip[i].tag <> 'U=null';
    ttimbraturedip[i].iOT:=i - 1;
  end;
  if n_timbrdip > 0 then
  begin
    if (ultimt_e = 'si') and not((estimbsucc = 'si') and (verso_suc = 'U')) then
      TimbratureOriginali[n_timbrdip - 1].esiste_u:=False;
    if (primat_u = 'si') and not((estimbprec = 'si') and (verso_pre = 'E')) then
      TimbratureOriginali[0].esiste_e:=False;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z072_tipoconA;
{Scarto timbrature con causale presenza
 su U e successiva E di tipo conteggio A (se abilitate)}
var i:Integer;
begin
  //Primo ciclo: verifico se causali abilitate
  i1:=1;
  while i1 <= n_timbrdip do
  begin
    z074_tipoconAc1;
    inc(i1);
  end;
  //Secondo ciclo: scarto vero e proprio
  i4:=1;
  while True do
  begin
    if i4 >= n_timbrdip then Break;
    z078_tipoconAc2(True);
    inc(i4);
  end;
  //Gestione prima E con questo tipo di causale
  if not((ttimbraturedip[1].tcausale_e.tcaus = '') or
         ((ttimbraturedip[1].tcausale_e.tcauscon <> 'A') and (ttimbraturedip[1].tcausale_e.tcauscon <> 'E')) or
         (estimbprec = 'no') or (verso_pre = 'E') or (ttimbraturedip[1].tcausale_e.tcaus <> caus_pre) or
         (*Alberto*)(ttimbraturedip[1].tcausale_e.tLfsCavMez <> 'S')) then
    begin
    riepcaus:=ttimbraturedip[1].tcausale_e.tcaus;
    riepcaus_e:=0;
    riepcaus_u:=ttimbraturedip[1].tminutid_e;
    riepcausrag:=ttimbraturedip[1].tcausale_e.tcausrag;
    riepcausrip:=ttimbraturedip[1].tcausale_e.tcausrip;
    riepcausioe:=ttimbraturedip[1].tcausale_e.tcausioe;
    riepcausOreGettone:=0;
    riepcaus_numtimb:=1;
    z810_rieppres(ttimbraturedip[1].tcausale_e.tmaxminuti);
    ttimbraturedip[1].tminutid_e:=0;
    ttimbraturedip[1].tcausale_e.tcaus:='';
    primat_u:='si';
    end;
  //Gestione ultima U con questo tipo di causale
  if not((ttimbraturedip[n_timbrdip].tcausale_u.tcaus = '') or
         ((ttimbraturedip[n_timbrdip].tcausale_u.tcauscon <> 'A') and (ttimbraturedip[n_timbrdip].tcausale_u.tcauscon <> 'E')) or
         (estimbsucc = 'no') or (verso_suc = 'U') or
         (ttimbraturedip[n_timbrdip].tcausale_u.tcaus <> caus_suc) or
         (*Alberto*)(ttimbraturedip[n_timbrdip].tcausale_u.tLfsCavMez <> 'S')) then
    begin
    riepcaus:=ttimbraturedip[n_timbrdip].tcausale_u.tcaus;
    riepcaus_u:=1440;
    riepcaus_e:=ttimbraturedip[n_timbrdip].tminutid_u;
    riepcausrag:=ttimbraturedip[n_timbrdip].tcausale_u.tcausrag;
    riepcausrip:=ttimbraturedip[n_timbrdip].tcausale_u.tcausrip;
    riepcausioe:=ttimbraturedip[n_timbrdip].tcausale_u.tcausioe;
    riepcausOreGettone:=0;
    riepcaus_numtimb:=0;
    z810_rieppres(ttimbraturedip[n_timbrdip].tcausale_u.tmaxminuti);
    ttimbraturedip[n_timbrdip].tminutid_u:=1440;
    ttimbraturedip[n_timbrdip].tcausale_u.tcaus:='';
    ultimt_e:='si';
    end;
  //Terzo ciclo: anomalia per causali di tipo conteggio E non accoppiate
  for i:=1 to n_timbrdip do
    z079_tipoconAc3(i);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z074_tipoconAc1;
{Primo ciclo: verifico se causali abilitate}
begin
  tcausale:=ttimbraturedip[i1].tcausale_e;
  z076_tipoconAca(ttimbraturedip[i1].tminutid_e);
  ttimbraturedip[i1].tcausale_e:=tcausale;
  tcausale:=ttimbraturedip[i1].tcausale_u;
  z076_tipoconAca(ttimbraturedip[i1].tminutid_u);
  ttimbraturedip[i1].tcausale_u:=tcausale;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z076_tipoconAca(Minuti:Integer);
var i:Integer;
    Trovato,ControlloFasce:Boolean;
begin
  with tcausale do
  begin
    if (tcaus = '') or ((tcauscon <> 'A') and (tcauscon <> 'E')) then exit;
    if tcausabi = 'no' then
    begin
      z098_anom2caus(9);
    end
    else
    begin
      ControlloFasce:=False;
      Trovato:=False;
      SetLength(FasceAbilitazione277,0);
      if z541_GetFasceAutorizzazione(tcaus,datacon,datacon - 1) then
      begin
        ControlloFasce:=True;
        for i:=0 to High(FasceAbilitazione277) do
          if (Minuti >= FasceAbilitazione277[i].IT) and (Minuti <= FasceAbilitazione277[i].FT) then
          begin
            Trovato:=True;
            Break;
          end;
      end;
      if not Trovato then
      begin
        SetLength(FasceAbilitazione277,0);
        if z541_GetFasceAutorizzazione(tcaus,datacon,datacon) then
        begin
          ControlloFasce:=True;
          for i:=0 to High(FasceAbilitazione277) do
            if (Minuti >= FasceAbilitazione277[i].IT) and (Minuti <= FasceAbilitazione277[i].FT) then
            begin
              Trovato:=True;
              Break;
            end;
        end;
      end;
      if ControlloFasce and (not Trovato) then
      begin
        z098_anom2caus(9);
      end;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z078_tipoconAc2(Riepiloga:Boolean);
{Secondo ciclo: scarto vero e proprio}
var i5:Integer;
begin
  if Riepiloga then
  begin
    //Alberto 15/09/2009 - TORINO_COMUNE: causali di uscita per servizio auto-completate
    //Autocompletamento nel caso di E posticipata o Uscita anticipata (TIPOCONTEGGIO = A,E)
    if (ttimbraturedip[i4].tcausale_u.tcaus <> '') then
    begin
      if R180In(ttimbraturedip[i4].tcausale_u.tcauscon,['A','E']) and
         (ttimbraturedip[i4 + 1].tcausale_e.tcaus = '') and
         (ValStrT275[ttimbraturedip[i4].tcausale_u.tcaus,'AUTOCOMPLETAMENTO_UE'] = 'S') and
         (ValStrT275[ttimbraturedip[i4].tcausale_u.tcaus,'SEPARA_CAUSALI_UE'] = 'N') then
        ttimbraturedip[i4 + 1].tcausale_e:=ttimbraturedip[i4].tcausale_u;
    end
    else
    begin
      if R180In(ttimbraturedip[i4 + 1].tcausale_e.tcauscon,['A','E']) and
         (ttimbraturedip[i4 + 1].tcausale_e.tcaus <> '') and
         (ValStrT275[ttimbraturedip[i4 + 1].tcausale_e.tcaus,'AUTOCOMPLETAMENTO_UE'] = 'S') and
         (ValStrT275[ttimbraturedip[i4 + 1].tcausale_e.tcaus,'SEPARA_CAUSALI_UE'] = 'N') then
        ttimbraturedip[i4].tcausale_u:=ttimbraturedip[i4 + 1].tcausale_e;
    end;

    //Alberto 05/08/2019 - PALERMO_UNIVERSITA:
    //Autocompletamento nel caso di E e corrispondente Uscita (TIPOCONTEGGIO = A,E)
    if R180In(ttimbraturedip[i4].tcausale_u.tcauscon,['A','E']) and
       (ValStrT275[ttimbraturedip[i4].tcausale_u.tcaus,'AUTOCOMPLETAMENTO_UE'] = 'S') and
       (ValStrT275[ttimbraturedip[i4].tcausale_u.tcaus,'SEPARA_CAUSALI_UE'] = 'S') then
    begin
      if (ttimbraturedip[i4 + 1].tcausale_e.tcaus = '') and
         (R180In(ttimbraturedip[i4 + 1].tcausale_u.tcauscon,['','A','E'])) then
      begin
        //Causale su U-E con E senza causale, e successiva uscita non causalizzata o non per prolungamento:
        //completo la causale anche su E
        ttimbraturedip[i4 + 1].tcausale_e:=ttimbraturedip[i4].tcausale_u;
      end
      else if (ttimbraturedip[i4].tcausale_u.tcaus <> ttimbraturedip[i4 + 1].tcausale_e.tcaus) or
              (not R180In(ttimbraturedip[i4 + 1].tcausale_u.tcauscon,['','A','E'])) then
      begin
        //Causale su U diversa da E, oppure successiva uscita causalizzata per prolungamento:
        //spezzo la timbratura per dividere le causali
        indice:=i4;
        z816_insetimbr;
        ttimbraturedip[i4 + 1]:=ttimbraturedip_vuota;
        ttimbraturedip[i4 + 1].tminutid_e:=ttimbraturedip[i4 + 2].tminutid_e;
        ttimbraturedip[i4 + 1].tcausale_e:=ttimbraturedip[i4].tcausale_u;
        ttimbraturedip[i4 + 1].tminutid_u:=ttimbraturedip[i4 + 2].tminutid_e;
        ttimbraturedip[i4 + 1].tflagarr_e:='si';
        ttimbraturedip[i4 + 1].tflagarr_u:='si';
        ttimbraturedip[i4 + 1].inserita:=True;
        ttimbraturedip[i4 + 1].iOT:=ttimbraturedip[i4 + 2].iOT;
        if R180In(ttimbraturedip[i4 + 2].tcausale_e.tcauscon,['','A','E']) then
          ttimbraturedip[i4 + 2].tcausale_e:=tcausale_vuota;
      end;
    end;

    if R180In(ttimbraturedip[i4 + 1].tcausale_e.tcauscon,['A','E']) and
       (ValStrT275[ttimbraturedip[i4 + 1].tcausale_e.tcaus,'AUTOCOMPLETAMENTO_UE'] = 'S') and
       (ValStrT275[ttimbraturedip[i4 + 1].tcausale_e.tcaus,'SEPARA_CAUSALI_UE'] = 'S') then
    begin
      if (ttimbraturedip[i4].tcausale_u.tcaus = '') and
         (R180In(ttimbraturedip[i4].tcausale_e.tcauscon,['','A','E'])) then
      begin
        //Causale su U-E con E senza causale, e successiva uscita non causalizzata o non per prolungamento:
        //completo la causale anche su E
        ttimbraturedip[i4].tcausale_u:=ttimbraturedip[i4 + 1].tcausale_e;
      end
      else if (ttimbraturedip[i4].tcausale_u.tcaus <> ttimbraturedip[i4 + 1].tcausale_e.tcaus) or
              (not R180In(ttimbraturedip[i4].tcausale_e.tcauscon,['','A','E'])) then
      begin
        indice:=i4;
        z816_insetimbr;
        ttimbraturedip[i4 + 1]:=ttimbraturedip_vuota;
        ttimbraturedip[i4 + 1].tminutid_e:=ttimbraturedip[i4].tminutid_u;
        ttimbraturedip[i4 + 1].tminutid_u:=ttimbraturedip[i4].tminutid_u;
        ttimbraturedip[i4 + 1].tcausale_u:=ttimbraturedip[i4 + 2].tcausale_e;
        ttimbraturedip[i4 + 1].tflagarr_e:='si';
        ttimbraturedip[i4 + 1].tflagarr_u:='si';
        ttimbraturedip[i4 + 1].inserita:=True;
        ttimbraturedip[i4 + 1].iOT:=ttimbraturedip[i4].iOT;
        if R180In(ttimbraturedip[i4].tcausale_u.tcauscon,['','A','E']) then
          ttimbraturedip[i4].tcausale_u:=tcausale_vuota;
      end;
    end
  end;

  with ttimbraturedip[i4].tcausale_u do
  begin
    if (tcaus = '') or ((tcauscon <> 'A') and (tcauscon <> 'E')) (*or (Copy(f03_com,1,5) = 'ALLE*')*) then
      exit;
  end;

  i5:=i4 + 1;
  if ttimbraturedip[i5].tcausale_e.tcaus <> ttimbraturedip[i4].tcausale_u.tcaus then exit;
  //Remmato ma forse utile: limita la timbratura causalizzata se supera i minuti massimi specificati
  (*if ttimbraturedip[i4].tcausale_u.tmaxminuti < (ttimbraturedip[i5].tminutid_e - ttimbraturedip[i4].tminutid_u) then
  begin
          indice:=i5;
          //Inserimento cella coppia E_U nelle timbrature dipendente
          z816_insetimbr;
          //tuscitad[indice]:=tuscitad[ieu];
          ttimbraturedip[indice].tminutid_e:=ttimbraturedip[i4].tminutid_u + ttimbraturedip[i4].tcausale_u.tmaxminuti;
          ttimbraturedip[indice].tminutid_u:=ttimbraturedip[i4].tminutid_u + ttimbraturedip[i4].tcausale_u.tmaxminuti;
          ttimbraturedip[indice].tcausale_e:=ttimbraturedip[i4].tcausale_u;
          ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
          ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[i4].tflagarr_u;
          ttimbraturedip[indice].tflagarr_e:=ttimbraturedip[i5].tflagarr_u;
          ttimbraturedip[indice].trilev_e:=ttimbraturedip[i5].trilev_e;
          ttimbraturedip[indice].trilev_u:=ttimbraturedip[i5].trilev_u;
          ttimbraturedip[indice].tpuntnomin:=ttimbraturedip[i4].tpuntnomin;
          ttimbraturedip[indice + 1].tcausale_e:=tcausale_vuota;
  end;*)
  //Gestione del caso particolare di orario Flessibile Spezzato
  if Riepiloga and (TipoOrario = 'A') and (PeriodoLavorativo = 'S') then
  begin
    if (ttimbraturedip[i4].tminutid_u < ValNumT021['USCITA',TF_PUNTI_NOMINALI,1]) and
       (ttimbraturedip[i5].tminutid_e > ValNumT021['ENTRATA',TF_PUNTI_NOMINALI,2]) then
    begin
      riepcaus:=ttimbraturedip[i4].tcausale_u.tcaus;
      riepcaus_e:=ttimbraturedip[i4].tminutid_u;
      riepcaus_u:=ValNumT021['USCITA',TF_PUNTI_NOMINALI,1];
      riepcausrag:=ttimbraturedip[i4].tcausale_u.tcausrag;
      riepcausrip:=ttimbraturedip[i4].tcausale_u.tcausrip;
      riepcausioe:=ttimbraturedip[i4].tcausale_u.tcausioe;
      riepcausOreGettone:=0;
      riepcaus_numtimb:=0;
      z810_rieppres(ttimbraturedip[i4].tcausale_u.tmaxminuti);
      if ttimbraturedip[i4].tcausale_u.tcausioe = 'A' then
      begin
        //Esclusione dalle ore normali
        inc(mintipoAesc,riepcaus_u - riepcaus_e);
        z124_InsTimbtipoAesc(riepcaus_e,riepcaus_u);
      end;
      ////
      riepcaus:=ttimbraturedip[i5].tcausale_e.tcaus;
      riepcaus_e:=ValNumT021['ENTRATA',TF_PUNTI_NOMINALI,2];
      riepcaus_u:=ttimbraturedip[i5].tminutid_e;
      riepcausrag:=ttimbraturedip[i5].tcausale_e.tcausrag;
      riepcausrip:=ttimbraturedip[i5].tcausale_e.tcausrip;
      riepcausioe:=ttimbraturedip[i5].tcausale_e.tcausioe;
      riepcausOreGettone:=0;
      riepcaus_numtimb:=0;
      z810_rieppres(ttimbraturedip[i5].tcausale_e.tmaxminuti);
      if ttimbraturedip[i5].tcausale_e.tcausioe = 'A' then
      begin
        //Esclusione dalle ore normali
        inc(mintipoAesc,riepcaus_u - riepcaus_e);
        z124_InsTimbtipoAesc(riepcaus_e,riepcaus_u);
      end;
      ttimbraturedip[i4].tminutid_u:=ValNumT021['USCITA',TF_PUNTI_NOMINALI,1];
      ttimbraturedip[i4].tcausale_u:=tcausale_vuota;
      ttimbraturedip[i5].tminutid_e:=ValNumT021['ENTRATA',TF_PUNTI_NOMINALI,2];
      ttimbraturedip[i5].tcausale_e:=tcausale_vuota;
      exit;
    end;
  end;
  if Riepiloga then
  begin
    riepcaus:=ttimbraturedip[i4].tcausale_u.tcaus;
    riepcaus_e:=ttimbraturedip[i4].tminutid_u;
    riepcaus_u:=ttimbraturedip[i5].tminutid_e;
    riepcausrag:=ttimbraturedip[i4].tcausale_u.tcausrag;
    riepcausrip:=ttimbraturedip[i4].tcausale_u.tcausrip;
    riepcausioe:=ttimbraturedip[i4].tcausale_u.tcausioe;
    riepcausOreGettone:=0;
    riepcaus_numtimb:=0;
    z810_rieppres(ttimbraturedip[i4].tcausale_u.tmaxminuti);
    if ttimbraturedip[i4].tcausale_u.tcausioe = 'A' then
    begin
      //Esclusione dalle ore normali
      //inc(mintipoAesc,ttimbraturedip[i5].tminutid_e - ttimbraturedip[i4].tminutid_u);
      //z124_InsTimbtipoAesc(ttimbraturedip[i4].tminutid_u,ttimbraturedip[i5].tminutid_e);
      inc(mintipoAesc,riepcaus_u - riepcaus_e);
      z124_InsTimbtipoAesc(riepcaus_e,riepcaus_u);
    end;
  end;
  //tuscitad[i4]:=tuscitad[i5];
  ttimbraturedip[i4].tminutid_u:=ttimbraturedip[i5].tminutid_u;
  ttimbraturedip[i4].trilev_u:=ttimbraturedip[i5].trilev_u;
  ttimbraturedip[i4].tcausale_u:=ttimbraturedip[i5].tcausale_u;
  ttimbraturedip[i4].tflagarr_u:=ttimbraturedip[i5].tflagarr_u;
  indice:=i5;
  z802_toglitimbr;
  dec(i4);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z079_tipoconAc3(i:Integer);
{Terzo ciclo: anomalia per causali
 di tipo conteggio E non accoppiate}
  begin
  with ttimbraturedip[i].tcausale_e  do
    if (tcaus <> '') and (tcauscon = 'E') then
      begin
      tcausale.tcaus:=tcaus;
      z098_anom2caus(6);
      tcaus:='';
      end;
  with ttimbraturedip[i].tcausale_u  do
    if (tcaus <> '') and (tcauscon = 'E') then
      begin
      tcausale.tcaus:=tcaus;
      z098_anom2caus(6);
      tcaus:='';
      end;
  end;
//_________________________________________________________________
procedure TR502ProDtM1.z080_tipoconAf;
{Gestione timbrature con causale presenza
 di tipo conteggio A non accoppiata}
begin
  i080:=0;
  tcausale:=ttimbraturedip[i1].tcausale_e;
  e_u:='E';
  z082_tipoconAfc;
  ttimbraturedip[i1].tcausale_e:=tcausale;
  tcausale:=ttimbraturedip[i1].tcausale_u;
  e_u:='U';
  z082_tipoconAfc;
  ttimbraturedip[i1].tcausale_u:=tcausale;
  dec(i1,i080);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z082_tipoconAfc;
var ScostPuntiNominali:Integer;
begin
  if (tcausale.tcaus = '') or (tcausale.tcauscon <> 'A') then exit;
  if ttimbraturedip[i1].tpuntnomin = 0 then
  begin
    z098_anom2caus(5);
    exit;
  end;
  i2:=ttimbraturedip[i1].tpuntnomin;
  if e_u <> 'U' then
  begin
    //Gestione entrata con causale presenza di tipo conteggio A
    if ttimbraturedip[i1].tminutid_e <= ttimbraturenom[i2].tminutin_e then
    begin
      z098_anom2caus(5);
      exit;
    end;
    i3:=i1 - 1;
    if (i1 <> 1) and (ttimbraturedip[i1].tpuntnomin = ttimbraturedip[i3].tpuntnomin) then
    //Gestione causale presenza di tipo conteggio A presente
    //solo sull'entrata
    begin
      if ttimbraturedip[i3].tcausale_u.tcaus = '' then
      begin
        z098_anom2caus(8);
        riepcaus:=ttimbraturedip[i1].tcausale_e.tcaus;
        riepcaus_e:=ttimbraturedip[i3].tminutid_u;
        riepcaus_u:=ttimbraturedip[i1].tminutid_e;
        riepcausrag:=ttimbraturedip[i1].tcausale_e.tcausrag;
        riepcausrip:=ttimbraturedip[i1].tcausale_e.tcausrip;
        riepcausioe:=ttimbraturedip[i1].tcausale_e.tcausioe;
        riepcausOreGettone:=0;
        riepcaus_numtimb:=0;
        z810_rieppres(ttimbraturedip[i1].tcausale_e.tmaxminuti);
        if ttimbraturedip[i1].tcausale_e.tcausioe = 'A' then
        begin
          //Esclusione dalle ore normali
          inc(mintipoAesc,riepcaus_u - riepcaus_e);
          z124_InsTimbtipoAesc(riepcaus_e,riepcaus_u);
        end;
        //tuscitad[i3]:=tuscitad[i1];
        ttimbraturedip[i3].tminutid_u:=ttimbraturedip[i1].tminutid_u;
        ttimbraturedip[i3].trilev_u:=ttimbraturedip[i1].trilev_u;
        ttimbraturedip[i3].tcausale_u:=ttimbraturedip[i1].tcausale_u;
        ttimbraturedip[i3].tflagarr_u:=ttimbraturedip[i1].tflagarr_u;
        indice:=i1;
        z802_toglitimbr;
        dec(i1);
        tcausale:=ttimbraturedip[i1].tcausale_e;
        exit;
      end
      else
      begin
        z098_anom2caus(6);
        exit;
      end;
    end;
    //Appoggio entrata dipendente su entrata nominale
    riepcaus:=ttimbraturedip[i1].tcausale_e.tcaus;
    //08/04/2003 - Roma_ASLC: Alterazione del punto nominale da scostamento
    ScostPuntiNominali:=0;
    if ValStrT275[riepcaus,'SCOST_PUNTI_NOMINALI'] = 'S' then
    begin
      ScostPuntiNominali:=ValNumT021['SCOST_PUNTI_NOMINALI_E',TF_PUNTI_NOMINALI,i2];//StrToIntDef(T020[Q020SCOST_PUNTI_NOMINALI.Index],0);
      if ScostPuntiNominali > (ttimbraturedip[i1].tminutid_e - ttimbraturenom[i2].tminutin_e) then
        ScostPuntiNominali:=ttimbraturedip[i1].tminutid_e - ttimbraturenom[i2].tminutin_e;
    end;
    if (ValStrT275[riepcaus,'E_IN_FLESSIBILITA'] = 'S') and (((TipoOrario = 'A') and (PeriodoLavorativo = 'C')) or (TipoOrario = 'E')) then
    begin
      flex92:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,i2];
      ScostPuntiNominali:=flex92;
      if ScostPuntiNominali > (ttimbraturedip[i1].tminutid_e - ttimbraturenom[i2].tminutin_e) then
        ScostPuntiNominali:=ttimbraturedip[i1].tminutid_e - ttimbraturenom[i2].tminutin_e;
      //Alberto: la flessibilità vera e propria è già stata applicata in z034_gestflexen, z036_gestflexcv, z090_flexrit
      //i90u:=i2;
      //z092_flexspost;
    end;
    if (i1 > 1) and (not XParam[XP_V77_Z082]) then
      riepcaus_e:=Max(ttimbraturedip[i1 - 1].tminutid_u,ttimbraturenom[i2].tminutin_e + ScostPuntiNominali)
    else
      riepcaus_e:=ttimbraturenom[i2].tminutin_e + ScostPuntiNominali;
    riepcaus_u:=ttimbraturedip[i1].tminutid_e;
    riepcausrag:=ttimbraturedip[i1].tcausale_e.tcausrag;
    riepcausrip:=ttimbraturedip[i1].tcausale_e.tcausrip;
    riepcausioe:=ttimbraturedip[i1].tcausale_e.tcausioe;
    riepcausOreGettone:=0;
    riepcaus_numtimb:=0;
    z810_rieppres(ttimbraturedip[i1].tcausale_e.tmaxminuti);
    if ttimbraturedip[i1].tcausale_e.tcausioe = 'A' then
    begin
      //Esclusione dalle ore normali
      inc(mintipoAesc,riepcaus_u - riepcaus_e);
      z124_InsTimbtipoAesc(riepcaus_e,riepcaus_u);
    end;
    if (i1 > 1) and (not XParam[XP_V77_Z082]) then
      ttimbraturedip[i1].tminutid_e:=Max(ttimbraturedip[i1 - 1].tminutid_u,ttimbraturenom[i2].tminutin_e + ScostPuntiNominali)
    else
      ttimbraturedip[i1].tminutid_e:=ttimbraturenom[i2].tminutin_e + ScostPuntiNominali;
    tcausale.tcaus:='';
    exit;
  end
  else
  //z082a
  //Gestione uscita con causale presenza di tipo conteggio A
  begin
    if ttimbraturedip[i1].tminutid_u >= ttimbraturenom[i2].tminutin_u then
    begin
      z098_anom2caus(5);
      exit;
    end;
    i3:=i1 + 1;
    if (i1 <> n_timbrdip) and (ttimbraturedip[i1].tpuntnomin = ttimbraturedip[i3].tpuntnomin) then
    //Gestione causale presenza di tipo conteggio A presente
    //solo sull'uscita
    begin
      if ttimbraturedip[i3].tcausale_e.tcaus = '' then
      begin
        z098_anom2caus(8);
        riepcaus:=ttimbraturedip[i1].tcausale_u.tcaus;
        riepcaus_e:=ttimbraturedip[i1].tminutid_u;
        riepcaus_u:=ttimbraturedip[i3].tminutid_e;
        riepcausrag:=ttimbraturedip[i1].tcausale_u.tcausrag;
        riepcausrip:=ttimbraturedip[i1].tcausale_u.tcausrip;
        riepcausioe:=ttimbraturedip[i1].tcausale_u.tcausioe;
        riepcausOreGettone:=0;
        riepcaus_numtimb:=0;
        z810_rieppres(ttimbraturedip[i1].tcausale_u.tmaxminuti);
        if ttimbraturedip[i1].tcausale_u.tcausioe = 'A' then
        begin
          //Esclusione dalle ore normali
          inc(mintipoAesc,riepcaus_u - riepcaus_e);
          z124_InsTimbtipoAesc(riepcaus_e,riepcaus_u);
        end;
        //tuscitad[i1]:=tuscitad[i3];
        ttimbraturedip[i1].tminutid_u:=ttimbraturedip[i3].tminutid_u;
        ttimbraturedip[i1].trilev_u:=ttimbraturedip[i3].trilev_u;
        ttimbraturedip[i1].tcausale_u:=ttimbraturedip[i3].tcausale_u;
        ttimbraturedip[i1].tflagarr_u:=ttimbraturedip[i3].tflagarr_u;
        indice:=i3;
        z802_toglitimbr;
        tcausale:=ttimbraturedip[i1].tcausale_u;
        i080:=1;
        exit;
      end
      else
      begin
        z098_anom2caus(6);
        exit;
      end;
    end;
    //Appoggio uscita dipendente su uscita nominale
    riepcaus:=ttimbraturedip[i1].tcausale_u.tcaus;
    //08/04/2003 - Roma_ASLC: Alterazione del punto nominale, sia da scostamento sia ignorando la flessibilità
    ScostPuntiNominali:=0;
    if ValStrT275[riepcaus,'SCOST_PUNTI_NOMINALI'] = 'S' then
      ScostPuntiNominali:=ValNumT021['SCOST_PUNTI_NOMINALI_U',TF_PUNTI_NOMINALI,i2];
    if ValStrT275[riepcaus,'SENZA_FLESSIBILITA'] = 'S' then
      ScostPuntiNominali:=ScostPuntiNominali + ttimbraturenom[i2].Flex;
    if ScostPuntiNominali > (ttimbraturenom[i2].tminutin_u - ttimbraturedip[i1].tminutid_u) then
      ScostPuntiNominali:=ttimbraturenom[i2].tminutin_u - ttimbraturedip[i1].tminutid_u;
    if i1 < n_timbrdip then
      riepcaus_u:=Min(ttimbraturedip[i1 + 1].tminutid_e,ttimbraturenom[i2].tminutin_u - ScostPuntiNominali)
    else
      riepcaus_u:=ttimbraturenom[i2].tminutin_u - ScostPuntiNominali;
    riepcaus_e:=ttimbraturedip[i1].tminutid_u;
    riepcausrag:=ttimbraturedip[i1].tcausale_u.tcausrag;
    riepcausrip:=ttimbraturedip[i1].tcausale_u.tcausrip;
    riepcausioe:=ttimbraturedip[i1].tcausale_u.tcausioe;
    riepcausOreGettone:=0;
    riepcaus_numtimb:=0;
    z810_rieppres(ttimbraturedip[i1].tcausale_u.tmaxminuti);
    if ttimbraturedip[i1].tcausale_u.tcausioe = 'A' then
    begin
      //Esclusione dalle ore normali
      inc(mintipoAesc,riepcaus_u - riepcaus_e);
      z124_InsTimbtipoAesc(riepcaus_e,riepcaus_u);
    end;
    if i1 < n_timbrdip then
      ttimbraturedip[i1].tminutid_u:=Min(ttimbraturedip[i1 + 1].tminutid_e,ttimbraturenom[i2].tminutin_u - ScostPuntiNominali)
    else
      ttimbraturedip[i1].tminutid_u:=ttimbraturenom[i2].tminutin_u - ScostPuntiNominali;
    tcausale.tcaus:='';
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z084_pausamecop;
{Verifica accoppiamento U - E e conteggio per pausa mensa}
begin
  i2:=i1 + 1;
  if not((ttimbraturedip[i1].tcausale_u.tcaus = '') or (ttimbraturedip[i1].tcausale_u.tcaustip <> 'C') or
         (ttimbraturedip[i1].tcausale_u.tcausrag <> traggrgius.C)) then
  begin
    if ttimbraturedip[i2].tcausale_e.tcaus = '' then
    begin
      tcausale.tcaus:=ttimbraturedip[i1].tcausale_u.tcaus;
      z098_anom2caus(8);
      ttimbraturedip[i2].tcausale_e:=ttimbraturedip[i1].tcausale_u;
      //Conteggio pausa mensa se in orario e se abilitata
      z086_pausamecon;
      exit;
    end;
    if (ttimbraturedip[i2].tcausale_e.tcaustip <> 'C') or (ttimbraturedip[i2].tcausale_e.tcausrag <> traggrgius.C) then
    begin
      tcausale.tcaus:=ttimbraturedip[i1].tcausale_u.tcaus;
      z098_anom2caus(6);
      ttimbraturedip[i1].tcausale_u.tcaus:='';
      //exit;
    end;
    //Conteggio pausa mensa se in orario e se abilitata
    z086_pausamecon;
    exit;
  end
  else
    //z084a.
  begin
    if (ttimbraturedip[i2].tcausale_e.tcaus = '') or (ttimbraturedip[i2].tcausale_e.tcaustip <> 'C') or
       (ttimbraturedip[i2].tcausale_e.tcausrag <> traggrgius.C) then
      exit;
    if ttimbraturedip[i1].tcausale_u.tcaus = '' then
    begin
      tcausale.tcaus:=ttimbraturedip[i2].tcausale_e.tcaus;
      z098_anom2caus(8);
      ttimbraturedip[i1].tcausale_u:=ttimbraturedip[i2].tcausale_e;
      //Conteggio pausa mensa se in orario e se abilitata
      z086_pausamecon;
      exit;
    end;
    tcausale.tcaus:=ttimbraturedip[i2].tcausale_e.tcaus;
    z098_anom2caus(6);
    ttimbraturedip[i2].tcausale_e.tcaus:='';
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z086_pausamecon(SoloControllo:Boolean = False);
{Conteggio pausa mensa se in orario e se abilitata}
var T1U,T2E,DiffO,DiffA,Fx:Integer;
    i86,i86e,i86u:Byte;
    i,TollPM,MinPercorr,MinLavorati:Integer;
    OkE,OkU,EsistePMTSuccessiva:Boolean;
begin
  codanom2:=0;
  if c_orario = '' then exit;
  (*Alberto: gestione P.M. nel conteggio *DALLE*ALLE *)
  T1U:=ttimbraturedip[i1].tminutid_u;
  T2E:=ttimbraturedip[i2].tminutid_e;
  //Non gestisco la pausa mensa se le timbrature sono esterne al periodo da conteggiare
  if ((T1U < minutidalle) and (T2E < minutidalle)) or
     ((T1U > minutialle) and (T2E > minutialle)) then
       exit;
  DiffO:=Max(0,ttimbraturedip[i2].tminutid_e - ttimbraturedip[i1].tminutid_u);
  //Gestione ora di inizio conteggio
  if T2E <= minutidalle then
    T2E:=ttimbraturedip[i1].tminutid_u
  else if T1U < minutidalle then
    T1U:=minutidalle;
  //Gestione ora di fine conteggio
  if T1U >= minutialle then
    T2E:=ttimbraturedip[i1].tminutid_u
  else if T2E > minutialle then
    T2E:=minutialle;
  DiffA:=Max(0,T2E - T1U);
  if DiffO = 0 then
    DiffO:=1;
  if DiffA = 0 then
    DiffA:=1;
  (*Fine Alberto*)
  i86u:=ttimbraturedip[i1].tpuntnomin;
  i86e:=ttimbraturedip[i2].tpuntnomin;
  //Parametri per gestire la pausa mensa fuori dai punti nominali
  OkU:=i86u <> 0;
  OkE:=i86e <> 0;
  TollPM:=ValNumT020['PAUSAMENSA_ESTERNA'];
  //Inizio mensa nell'orario, Rientro fuori orario
  if (i86u <> 0) and (i86e = 0) then
    OkE:=ttimbraturenom[i86u].tminutin_u + TollPM >= ttimbraturedip[i2].tminutid_e
  //Inizio mensa fuori orario, Rientro nell'orario
  else if (i86u = 0) and (i86e <> 0) then
    OkU:=ttimbraturenom[i86e].tminutin_e - TollPM <= ttimbraturedip[i1].tminutid_u
  //Inizio e Rientro mensa fuori orario
  else if (i86u = 0) and (i86e = 0) then
  begin
    //Ricerca punto nominale precedente
    for i:=i1 - 1 downto 1 do
      if ttimbraturedip[i].tpuntnomin <> 0 then
      begin
        //OkE:=ttimbraturenom[i].tminutin_u + TollPM >= ttimbraturedip[i2].tminutid_e;
        OkE:=ttimbraturenom[ttimbraturedip[i].tpuntnomin].tminutin_u + TollPM >= ttimbraturedip[i2].tminutid_e;
        OkU:=OkE;
        Break;
      end;
    if not OkE then
      //Ricerca punto nominale successivo
      for i:=i2 + 1 to n_timbrdip do
        if ttimbraturedip[i].tpuntnomin <> 0 then
        begin
          //OkE:=ttimbraturenom[i].tminutin_e - TollPM <= ttimbraturedip[i1].tminutid_u;
          OkE:=ttimbraturenom[ttimbraturedip[i].tpuntnomin].tminutin_e - TollPM <= ttimbraturedip[i1].tminutid_u;
          OkU:=OkE;
          Break;
        end;
  end;
  //Se timbrature dovute a giustificativo che genera timbrature fittizie verifico sua partecipazione a PMT
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
  begin
    if not OkU then
      OkU:=(ttimbraturedip[i1].tcausale_u.tcaus = CAUS_PM) or (ValStrT275[ttimbraturedip[i1].tcausale_u.tcaus,'TIMB_PM'] = 'S');
    if not OkE then
      OkE:=(ttimbraturedip[i2].tcausale_e.tcaus = CAUS_PM) or (ValStrT275[ttimbraturedip[i2].tcausale_e.tcaus,'TIMB_PM'] = 'S');
  end;
  //Controllo abilitazione pausa mensa
  if ttimbraturedip[i1].tcausale_u.tcausabi = 'no' then
  begin
    tcausale.tcaus:=ttimbraturedip[i1].tcausale_u.tcaus;
    codanom2:=9;
  end
  //Controllo U interna all' orario (tranne orario libero)
  else if (((i86u = 0) and (not OkU)) or ((i86u <> 0) and (ttimbraturedip[i1].tminutid_u > ttimbraturenom[i86u].tminutin_u + TollPM))) and
          (n_timbrnom <> 0) and (ttimbraturedip[i1].tminutid_e <> ttimbraturedip[i1].tminutid_u) then
  begin
    tcausale.tcaus:=ttimbraturedip[i1].tcausale_u.tcaus;
    codanom2:=5;
  end
  //Controllo E interna all' orario (tranne orario libero)
  else if (((i86e = 0) and (not OkE)) or ((i86e <> 0) and (ttimbraturedip[i2].tminutid_e < ttimbraturenom[i86e].tminutin_e - TollPM))) and
          (n_timbrnom <> 0) and (ttimbraturedip[i2].tminutid_e <> ttimbraturedip[i2].tminutid_u) then
  begin
    tcausale.tcaus:=ttimbraturedip[i2].tcausale_e.tcaus;
    codanom2:=5;
  end
  //non gestita la pausa mensa B,D,E,F con orario E sul turno notturno
  //se il recupero sull'uscita (Flex della PMT) è maggiore di 0
  else if (R180In(PausaMensa,['B','D','E','F'])
          ) and
          ((ValStrT021['mmFlex',TF_PM_TIMBRATA,1] = '') or
           (ValNumT021['mmFlex',TF_PM_TIMBRATA,1] <> 0)
          ) and
          (TipoOrario = 'E') and
          (PeriodoLavorativo = 'T1') and
          (((i86e = 0) and not OkE) or
           ((ttimbraturenom[i86e].tpuntru = 0) and (ttimbraturedip[i2].tminutid_u >= 1440))
          ) then
  begin
    tcausale.tcaus:=ttimbraturedip[i2].tcausale_e.tcaus;
    codanom2:=7;
  end
  //Controllo U - E interne al range pausa mensa (se definito)
  else if (ValNumT021['ENTRATAMM',TF_PM_TIMBRATA,1] > 0) or
          (ValNumT021['USCITAMM',TF_PM_TIMBRATA,1] > 0) or
          (ValNumT021['MMRITARDO',TF_PM_TIMBRATA,1] > 0) or
          (ValNumT021['MMANTICIPOU',TF_PM_TIMBRATA,1] > 0) then
  begin
    SetFasciaMensa(ttimbraturedip[i1].tminutid_u);
    if (ttimbraturedip[i1].tminutid_u < FasciaMensa.PMTInizioDa(*ValNumT021['ENTRATAMM',TF_PM_TIMBRATA,1]*)) or
       (ttimbraturedip[i1].tminutid_u > FasciaMensa.PMTInizioA(*ValNumT021['MMRITARDO',TF_PM_TIMBRATA,1]*)) then
    begin
      tcausale.tcaus:=ttimbraturedip[i1].tcausale_u.tcaus;
      codanom2:=7;
    end
    else if (ttimbraturedip[i2].tminutid_e < FasciaMensa.PMTFineDa(*ValNumT021['MMANTICIPOU',TF_PM_TIMBRATA,1]*)) or
            (ttimbraturedip[i2].tminutid_e > FasciaMensa.PMTFineA(*ValNumT021['USCITAMM',TF_PM_TIMBRATA,1]*)) then
    begin
      tcausale.tcaus:=ttimbraturedip[i2].tcausale_e.tcaus;
      codanom2:=7;
    end;
  end;
  if SoloControllo then
    exit;
  if codanom2 <> 0 then
  begin
    if tcausale.tcaus <> CAUS_PM then
      z098_anom2caus(codanom2);
    ttimbraturedip[i1].tcausale_u.tcaus:='';
    ttimbraturedip[i2].tcausale_e.tcaus:='';
    exit;
  end;
  //Alberto 30/07/2008 (LA SPEZIA): gestione PMT solo se esiste timbratura di mensa
  if (cdsT020.FieldByName('PMT_SOLO_TIMBMENSA').AsString = 'S') and (TimbratureDiMensa = '') then
    exit;
  //Esiste timbratura di mensa e relativa gestione, ma non è nell'intervallo corrente: esco
  if z494_CheckTimbMensa and not z495_IntervalloTimbMensa(ttimbraturedip[i1].tminutid_u,ttimbraturedip[i2].tminutid_e) then
    exit;
  //Settaggio flag per pausa mensa gestita
  paumenges:='si';
  TipoDetPaumen:='PMT';
  //ttimbraturedip[i2].tminutid_e < ttimbraturedip[i1].tminutid_u
  (*Alberto*)
  //Arrotondamento pausa mensa
  i890:=i1;
  e_u890:='U';
  arr890:=ValNumT021['mmArrotond',TF_PM_TIMBRATA,1];  //L'Uscita dal servizio corrisponde all'Entrata in Mensa
  z890_arrotonda('z086');
  i890:=i2;
  e_u890:='E';
  arr890:=ValNumT021['mmArrotondU',TF_PM_TIMBRATA,1]; //L'Entrata in servizio corrisponde all'Uscita dalla Mensa
  z890_arrotonda('z086');
  if ttimbraturedip[i2].tminutid_e < ttimbraturedip[i1].tminutid_u then
  begin
    blocca:=8;
    exit;
  end;
  MinLavorati:=0;
  for i:=1 to n_timbrdip do
  begin
    if (ttimbraturedip[i].tcausale_e.tcaus <> '') and (ttimbraturedip[i].tcausale_e.tcausMatMensa = 'N') then
      Continue;
    (*if (ttimbraturedip[i].tpuntnomin = 0 then
      Continue;*)
    inc(MinLavorati,ttimbraturedip[i].tminutid_u - ttimbraturedip[i].tminutid_e);
  end;
  PauMenMinUtilizzata:=ValNumT020['mmMinimi'];
  //Alberto 02/10/2008 (Biella_ASL12): applicazione detrazione intermedia se le ore lavorate sono tra le 6.00 e le 6.30
  if (MinLavorati < ValNumT021['OreMinime',TF_PM_TIMBRATA,1]) and
     (MinLavorati >= IfThen(cdsT020.FieldByName('PM_OREMINIME_INF').IsNull,1440,ValNumT020['PM_OREMINIME_INF'])) then
    PauMenMinUtilizzata:=ValNumT020['PM_STACCO_INF'];
  //Alberto 30/07/2008 (LA SPEZIA): applicazione detrazione alternativa se esiste timbratura di mensa
  if (not cdsT020.FieldByName('TIMBRATURAMENSA_DETRAZIONE').IsNull) and z149_EsisteTimbraturaMensa('S') then
  begin
    PauMenMinUtilizzata:=ValNumT020['TIMBRATURAMENSA_DETRAZIONE'];
    TipoDetPaumen:='PMATM';
  end;
  //Gestione dei diversi tipi di pausa mensa
  comodo2:=ttimbraturedip[i2].tminutid_e - ttimbraturedip[i1].tminutid_u;
  SetLength(TimbratureMensa,Length(TimbratureMensa) + 1);
  TimbratureMensa[High(TimbratureMensa)].I:=ttimbraturedip[i1].tminutid_u;
  TimbratureMensa[High(TimbratureMensa)].F:=ttimbraturedip[i2].tminutid_e;
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
  begin //Si cumulano i vari intervalli fatti in fascia di mensa, per poi elaborarli quando si è sull'ultimo
    inc(paumenFatta,comodo2);
    EsistePMTSuccessiva:=False;
    for i:=i2 to n_timbrdip - 1 do
     if (ttimbraturedip[i].tcausale_u.tcaus = CAUS_PM) and (ttimbraturedip[i + 1].tcausale_e.tcaus = CAUS_PM) then
      EsistePMTSuccessiva:=True;
    if EsistePMTSuccessiva then
      exit;
  end
  else
    paumenFatta:=comodo2;
  if (PausaMensa = 'A') or (PausaMensa = 'C') then
  //Gestione tipo pausa mensa A e C se inserita causale
  begin
    if (paumenFatta < PauMenMinUtilizzata) then
      paumendet:=paumendet + PauMenMinUtilizzata - paumenFatta
    else
    begin
      //Alberto 28/09/2007: gestione percorrenza per tipi A,C
      if VarToStr(selT361.Lookup('CODICE',ttimbraturedip[i1].trilev_u,'APPLICA_PERCORRENZA_PM')) = 'N' then
        MinPercorr:=0
      else
        MinPercorr:=ValNumT020['MinPercorr'];
      dec(paumenFatta,PauMenMinUtilizzata);
      inc(tminlav[1],Min(paumenFatta,MinPercorr) * DiffA div DiffO);
      dec(paumenFatta,Min(paumenFatta,MinPercorr) * DiffA div DiffO);
      //Gestione tolleranza (Ciriè)
      if paumenFatta <= ValNumT020['PMT_Tolleranza'] then
      begin
        inc(tminlav[1],paumenFatta * DiffA div DiffO);
        inc(TollPMUtilizzata,paumenFatta * DiffA div DiffO);
      end
      else if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
      begin
        inc(tminlav[1],ValNumT020['PMT_Tolleranza'] * DiffA div DiffO);
        inc(TollPMUtilizzata,ValNumT020['PMT_Tolleranza'] * DiffA div DiffO);
      end;
    end;
  end
  else if PausaMensa = 'B' then
  //Gestione tipo pausa mensa B
  begin
    //Alberto 26/03/2012: solo nel caso di Pausa mensa = B, considero anche il punto nominale i86u nel caso che i86e sia fuori dall'orario, ma per via della tolleranza si consideri lo stacco di mensa
    if (i86e > 0) or (i86u > 0) then
    begin
      i86:=IfThen(i86e > 0,i86e,i86u);
      if paumenFatta > PauMenMinUtilizzata then
      begin
        //Alberto 28/09/2007: gestione percorrenza per tipo B
        if VarToStr(selT361.Lookup('CODICE',ttimbraturedip[i1].trilev_u,'APPLICA_PERCORRENZA_PM')) = 'N' then
          MinPercorr:=0
        else
          MinPercorr:=ValNumT020['MinPercorr'];
        dec(paumenFatta,PauMenMinUtilizzata);
        inc(tminlav[1],Min(paumenFatta,MinPercorr) * DiffA div DiffO);
        dec(paumenFatta,Min(paumenFatta,MinPercorr) * DiffA div DiffO);
        //Gestione tolleranza (Ciriè)
        if paumenFatta <= ValNumT020['PMT_Tolleranza'] then
        begin
          inc(tminlav[1],paumenFatta * DiffA div DiffO);
          inc(TollPMUtilizzata,paumenFatta * DiffA div DiffO);
        end
        else if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
        begin
          inc(tminlav[1],ValNumT020['PMT_Tolleranza'] * DiffA div DiffO);
          inc(TollPMUtilizzata,ValNumT020['PMT_Tolleranza'] * DiffA div DiffO);
        end;
        //Alberto 28/09/2007: fine
        Fx:=z132_FlexPM(PauMenMinUtilizzata,i86);
        inc(ttimbraturenom[i86].tminutin_u,Fx);
        inc(ttimbraturenom[i86].Flex,Fx);
        ttimbraturenom[i86].FlexPM:=Fx;
      end
      else
      begin
        Fx:=z132_FlexPM(paumenFatta,i86);
        inc(ttimbraturenom[i86].tminutin_u,Fx);
        inc(ttimbraturenom[i86].Flex,Fx);
        ttimbraturenom[i86].FlexPM:=Fx;
      end;
    end;
  end
  else if paumenFatta < PauMenMinUtilizzata then
    //Gestione tipo pausa mensa D e E
    paumendet:=paumendet + PauMenMinUtilizzata - paumenFatta
  else
  begin
    if VarToStr(selT361.Lookup('CODICE',ttimbraturedip[i1].trilev_u,'APPLICA_PERCORRENZA_PM')) = 'N' then
      MinPercorr:=0
    else
      MinPercorr:=ValNumT020['MinPercorr'];
    dec(paumenFatta,PauMenMinUtilizzata);
    //Gestione tempo di percorrenza
    if paumenFatta < MinPercorr then
      inc(tminlav[1],paumenFatta * DiffA div DiffO)
    else
    begin
      inc(tminlav[1],MinPercorr * DiffA div DiffO);
      dec(paumenFatta,MinPercorr * DiffA div DiffO);
      //Gestione tolleranza (Ciriè)
      if paumenFatta <= ValNumT020['PMT_Tolleranza'] then
      begin
        inc(tminlav[1],paumenFatta * DiffA div DiffO);
        inc(TollPMUtilizzata,paumenFatta * DiffA div DiffO);
        paumenFatta:=0;
      end
      else if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
      begin
        inc(tminlav[1],ValNumT020['PMT_Tolleranza'] * DiffA div DiffO);
        inc(TollPMUtilizzata,ValNumT020['PMT_Tolleranza'] * DiffA div DiffO);
      end;
      if ValNumT020['PM_RECUP_USCITA'] > PauMenMinUtilizzata then
      begin
        dec(paumenFatta,ValNumT020['PM_RECUP_USCITA'] - PauMenMinUtilizzata);
        paumenFatta:=Max(0,paumenFatta);
      end;
      if i86e > 0 then
      begin
        Fx:=z132_FlexPM(paumenFatta,i86e);
        inc(ttimbraturenom[i86e].tminutin_u,Fx);
        inc(ttimbraturenom[i86e].Flex,Fx);
        ttimbraturenom[i86e].FlexPM:=Fx;
      end
      else if (i86u > 0) and
              ((ttimbraturedip[i2].tminutid_e = ttimbraturedip[i2].tminutid_u) or XParam[XP_APPOGGIO_FLEXPM_CAUS]) and
              (ttimbraturedip[i1].tcausale_u.tcaus = CAUS_PM) and
              (ttimbraturedip[i2].tcausale_e.tcaus = CAUS_PM) then
      begin
        Fx:=z132_FlexPM(paumenFatta,i86u);
        inc(ttimbraturenom[i86u].tminutin_u,Fx);
        inc(ttimbraturenom[i86u].Flex,Fx);
        ttimbraturenom[i86u].FlexPM:=Fx;
      end;
    end;
  end;

  //Verifico se sono state raggiunte le ore minime per applicare la detrazione
  if MinLavorati < min(ValNumT021['OreMinime',TF_PM_TIMBRATA,1],IfThen(cdsT020.FieldByName('PM_OREMINIME_INF').IsNull,1440,ValNumT020['PM_OREMINIME_INF'])) then
    //Se non ci sono le ore minime, verifico se l'accesso mensa consente di applicare comunque la detrazione
    //Gestire PMT_NOOREMIN_TIMBMENSA e PMT_TIMBRATURAMENSA
    if (cdsT020.FindField('PMT_NOOREMIN_TIMBMENSA') = nil) or
       (cdsT020.FieldByName('PMT_NOOREMIN_TIMBMENSA').AsString = 'N') or
       (not z149_EsisteTimbraturaMensa('S')) then
    begin
      paumendet:=0;
      paumenTimbNonGes:=True; //Alberto 02/01/2009
    end;
  try
    paumendet:=paumendet * DiffA div DiffO;
  except
    paumendet:=0;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z088_flexorarA;
{Gestione flessibilita' e E in ritardo per tipo orario A}
begin
  i90e:=1;
  flex90:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1];
  //Verifica ritardo sulla prima E
  if not XParam[XP_Z088_INTERVALLO_FLEX] then
    z090_flexrit
  else
    tritflex[i90e]:=z091_flexIntervalloCompleto;
  if (PeriodoLavorativo = 'S') and (cdsT020.FieldByName('TipoFle').AsString = 'A') then
    //Annullamento seconda flessibilità
    if ValNumT021['mmFlex',TF_PUNTI_NOMINALI,2] > 0 then
    begin
      cdsT021.Edit;
      cdsT021.FieldByName('mmFlex').AsInteger:=0;
      cdsT021.Post;
    end;
  if PeriodoLavorativo = 'S' then
  begin
    i90e:=2;
    flex90:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,2];
    //Verifica ritardo sulla seconda E
    z090_flexrit;
  end;
  if cdsT020.FieldByName('TipoFle').AsString = 'A' then
    //Gestione flessibilita' tipo A
    if PeriodoLavorativo = 'S' then
    begin
      i90u:=2;
      flex92:=tritflex[1];
      //Spostamento ultima uscita nominale
      z092_flexspost;
    end
    else
    begin
      i90u:=1;
      flex92:=tritflex[1];
      //Spostamento ultima uscita nominale
      z092_flexspost;
    end
    else if cdsT020.FieldByName('TipoFle').AsString = 'B' then
    //Gestione flessibilita' tipo B
    begin
      i90u:=1;
      flex92:=tritflex[1];
      //Spostamento prima uscita nominale
      z092_flexspost;
      i90u:=2;
      flex92:=tritflex[2];
      //Spostamento seconda uscita nominale
      z092_flexspost;
    end
    else if cdsT020.FieldByName('TipoFle').AsString = 'C' then
    //Gestione flessibilita' tipo C
    begin
      i90u:=2;
      flex92:=tritflex[1] + tritflex[2];
      //Spostamento ultima uscita nominale
      z092_flexspost;
    end;
  if cdsT020.FieldByName('TipoFle').AsString <> 'D' then exit;
  //Gestione flessibilita' tipo D
  flex90:= tritflex[1] + tritflex[2];
  if flex90 = 0 then exit;
  //Ricerca uscita appoggiata alla prima uscita nominale
  i1:=n_timbrdip;
  while (i1 > 0) and (ttimbraturedip[i1].tpuntnomin <> 1) do
    dec(i1);
  if (i1 <> 0) and (ttimbraturedip[i1].tminutid_u > ttimbraturenom[1].tminutin_u) then
  //Calcolo ritardo nella prima uscita
  begin
    rit:=ttimbraturedip[i1].tminutid_u - ttimbraturenom[1].tminutin_u;
    i90u:=1;
    if rit >= flex90 then
    begin
      flex92:=flex90;
      //Spostamento prima uscita nominale della fless. totale
      z092_flexspost;
      exit;
    end
    else
    begin
      flex92:=rit;
      //Spostamento prima uscita nominale del ritardo
      z092_flexspost;
      dec(flex90,rit);
    end;
  end;
  //Ricerca uscita appoggiata alla seconda uscita nominale
  i1:=n_timbrdip;
  while (i1 > 0) and (ttimbraturedip[i1].tpuntnomin <> 2) do
    dec(i1);
  flex92:=flex90;
  if i1 <> 0 then
  begin
    i90u:=2;
    //Spostamento seconda uscita nominale della fless. residua
    z092_flexspost;
  end
  else
  begin
    i90u:=1;
    //Spostamento prima uscita nominale della fless. residua
    z092_flexspost;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z090_flexrit;
{Verifica ritardo sulla E per tipo orario A}
var i,xx,tminutiflex_e,tminutinom_e:Integer;
    FlexGius,TimbInFlex:Boolean;
begin
  with ttimbraturenom[i90e] do
  begin
    //Considero il punto nominale di ingresso con eventuale flessibilità già calcolata precedentemente (caso COTTOLENGO, la flessibilità può venire calcolata 2 volte)
    tminutinom_e:=tminutin_e;
    if cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S' then
      //In realtà potrebbe essere valido sempre, indipendentemente da MINUTICAUS_PRIORITARI
      tminutinom_e:=tminutinom_e + Flex;
    tritflex[i90e]:=0;
    i1:=0;
    TimbInFlex:=False;
    repeat
      inc(i1);
      if ttimbraturedip[i1].tpuntnomin = i90e then
      begin
        TimbInFlex:=True;
        //Valuto se la timbratura è causalizzata e se è da considerare per la flessibilità
        if (ttimbraturedip[i1].tcausale_e.tcaus <> '') and
           (ValStrT275[ttimbraturedip[i1].tcausale_e.tcaus,'LIQUIDABILE'] = 'B') and        //Ore esterne all'orario
           (R180CarattereDef(ValStrT275[ttimbraturedip[i1].tcausale_e.tcaus,'TIPOCONTEGGIO']) in ['B','C']) and //Causale su entrata/uscita
           (ValStrT275[ttimbraturedip[i1].tcausale_e.tcaus,'E_IN_FLESSIBILITA'] = 'S') then //Non considerata nella flessibilità
          TimbInFlex:=False;
      end;
    //until ((i1 > n_timbrdip) or (ttimbraturedip[i1].tpuntnomin = i90e));
    until ((i1 > n_timbrdip) or TimbInFlex);
    //Verifica se la prima timbratura è sucessiva all'uscita nominale
    //ma può rientrare nella flessibilità se causale di entr.posticipata che si appoggia alla fine flessibilità
    if (XParam[XP_TC_FLEX_EXTRAPN]) and
       (i1 > 1) and
       (i1 > n_timbrdip) and
       (ttimbraturedip[1].tpuntnomin = 0) and
       (PeriodoLavorativo = 'C') and
       (ttimbraturedip[1].tminutid_e >= ttimbraturenom[1].tminutin_u) and
       (ttimbraturedip[1].tminutid_e <= ttimbraturenom[1].tminutin_u + flex90) and
       (ttimbraturedip[1].tcausale_e.tcaus <> '') and
       (ttimbraturedip[1].tcausale_e.tcauscon = 'A') and
       (ValStrT275[ttimbraturedip[1].tcausale_e.tcaus,'E_IN_FLESSIBILITA'] = 'S') then
    begin
      ttimbraturedip[1].tpuntnomin:=1;
      i1:=1;
    end;
    with ttimbraturedip[i1] do
    begin
      if (i1 > n_timbrdip) or (tminutid_e <= tminutinom_e) then exit;
      if (tcausale_e.tcaus <> '') and
         (tcausale_e.tcauscon = 'A') and
         (ValStrT275[tcausale_e.tcaus,'E_IN_FLESSIBILITA'] = 'N') then
        exit;
      tminutiflex_e:=tminutid_e;
      FlexGius:=False;
      //5.5.2 LaSpezia: se la fascia di flessibilità è coperta da giustificativi non la applico
      //Si usa tminutiflex_e anzichè ttimbraturedip[i1].tminutid_e
      for i:=1 to n_giusdaa do
      begin
        z964_leggicaus(tgius_dallealle[i].tcausdaa);
        if (s_trovato = 'no') or (parcaus.l29_18paramet <> 'S') then
          Continue;
        if (tgius_dallealle[i].tminutida <= tminutiflex_e) and (tgius_dallealle[i].tminutia >= tminutinom_e) then
        begin
          tminutiflex_e:=Max(tgius_dallealle[i].tminutida,tminutinom_e);
          FlexGius:=True;
        end;
      end;
      //Alberto 15/06/2009: non arrotondo più le timbrature successive al giustificativo di assenza
      if FlexGius and (cdsT020.FieldByName('ARR_TIMB_INTERNE').AsString = 'N') then
        for xx:=1 to n_timbrdip do
          if ttimbraturedip[xx].tminutid_e > tminutiflex_e then
            ttimbraturedip[xx].tflagarr_e:='si';
      //Fine 5.5.2
      //Calcolo ritardo dell' entrata
      rit:=tminutid_e - tminutinom_e;
      if (rit <= ValNumT021['TOLLERANZA',TF_PUNTI_NOMINALI,i90e]) and (f03_com <> 'NO TOLLERANZA') then
      //Tolleranza
      begin
        tminutid_e:=tminutinom_e;
        inc(tollergod,rit);
      end
      else if rit <= flex90 then
      //Flessibilita'
      begin
        i890:=i1;
        e_u890:='E';
        arr890:=ValNumT021['ARRFLESFASC',TF_PUNTI_NOMINALI,i90e];
        //Alberto 03/07/2009: non applico l'arrotondamento se causale esterna all'orario
        if not((tcausale_e.tcaus <> '') and
               (tcausale_e.tcaus = tcausale_u.tcaus) and
               (tcausale_e.tcauscon <> 'A') and (tcausale_e.tcauscon <> 'E') and (tcausale_e.tcaustip = 'B') and
               (ValStrT275[tcausale_e.tcaus,'LIQUIDABILE'] = 'B')
               (*and (ValStrT275[tcausale_e.tcaus,'ARROT_MODORA'] = 'N')*)) then
          z890_arrotonda;
        if not FlexGius then
          tminutiflex_e:=tminutid_e;
        tritflex[i90e]:=tminutiflex_e - tminutinom_e;//5.5.2 tminutid_e - tminutin_e;
      end
      else
      //Ritardo
      begin
        if ((tcausale_e.tcaus = '') or (tcausale_e.tcaustip <> 'C')) and (not conteggi_sologiust) then
        begin
          z099_anom3(1,tminutid_e,'');
        end;
        i890:=i1;
        e_u890:='E';
        arr890:=ValNumT021['ARRRITARDO',TF_PUNTI_NOMINALI,i90e];
        //Alberto 03/07/2009: non applico l'arrotondamento se causale esterna all'orario
        if not((tcausale_e.tcaus <> '') and
               (tcausale_e.tcaus = tcausale_u.tcaus) and
               (tcausale_e.tcauscon <> 'A') and (tcausale_e.tcauscon <> 'E') and (tcausale_e.tcaustip = 'B') and
               (ValStrT275[tcausale_e.tcaus,'LIQUIDABILE'] = 'B')
               (*and (ValStrT275[tcausale_e.tcaus,'ARROT_MODORA'] = 'N')*)) then
          z890_arrotonda;
        if not FlexGius then
          tminutiflex_e:=tminutid_e;
        tritflex[i90e]:=tminutiflex_e - tminutinom_e;//tminutid_e - tminutin_e;
        if tritflex[i90e] > flex90 then
          tritflex[i90e]:=flex90;
      end;
    end;
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.z091_flexIntervalloCompleto:Integer;
{Verifica ritardo sulla E per tipo orario A}
var i,E,U:Integer;
    InizioFlex,FineFlex,PuntiNomEU,ResoEU:Integer;
    EU: array of TPeriodoIF;
  function AumentaFlexDaGiustificativi:Integer;
  var i,it:Integer;
      ttimbraturedip_sv:array of t_ttimbraturedip;
      tgius_dallealle_sv: array of t_tgius_dallealle;
  begin
    //Fatto apposta per Messina_Universita: servono parametri sulle causali (70,PP)????
    //Considero solo i giustificativi presi prima dell'uscita da servizio
    Result:=0;

    //copia dati originali
    SetLength(ttimbraturedip_sv,n_timbrdip);
    TTimbratureDip_Backup(ttimbraturedip_sv);
    SetLength(tgius_dallealle_sv,n_giusdaa);
    TGiusDalleAlle_Backup(tgius_dallealle_sv);

    try
      //elaboro provvisoriamente intersezione timbrature / giustificativi per avere la durata corretta dei giustificativi dalle/alle
      z044_intimgiu;

      //calcolo la durata dei giustificativi da recuperare
      for i:=1 to n_giusdaa do
      begin
        //if R180In(tgius_dallealle[i].tcausdaa,'70,70A,PP'.Split([','])) then
        if (ValStrT275[tgius_dallealle[i].tcausdaa,'GIUST_DAA_RECUP_FLEX'] = 'S') or
           (ValStrT265[tgius_dallealle[i].tcausdaa,'GIUST_DAA_RECUP_FLEX'] = 'S') then
        begin
          for it:=0 to High(TimbratureDelGiorno) do
          begin
            //Verifico che esista una timbratura successiva al giustificativo
            if (TimbratureDelGiorno[it].toratimb >= tgius_dallealle[i].tminutia) then
            begin
              inc(Result,tgius_dallealle[i].tminutia - tgius_dallealle[i].tminutida);
              Break;
            end;
          end;
        end;
      end;

    finally
      //ripristino timbrature e giustificativi dalle..alle
      TTimbratureDip_Restore(ttimbraturedip_sv);
      TGiusDalleAlle_Restore(tgius_dallealle_sv);
    end;
  end;
  procedure LimitaInizioFine(x:Integer);
  begin
    if x > 0 then
      EU[x].I:=max(EU[x].I,EU[x - 1].F);
    if x < High(EU) then
      EU[x].F:=min(EU[x].F,EU[x + 1].I);
  end;
  procedure Inserisci(Inizio,Fine:Integer);
  var x,y:Integer;
  begin
    if (Inizio >= FineFlex) or (Fine <= InizioFlex) then
      exit;
    Inizio:=max(Inizio,InizioFlex);
    Fine:=min(Fine,FineFlex);

    for x:=0 to High(EU) do
    begin
      if (Inizio <= EU[x].F) and (Fine >= EU[x].I) then
      begin
        EU[x].I:=min(Inizio,EU[x].I);
        EU[x].F:=max(Fine,EU[x].F);
        LimitaInizioFine(x);
        Break;
      end
      else if (x < High(EU)) and (Inizio > EU[x].I) and (Fine < EU[x + 1].I) then
      begin
        SetLength(EU,Length(EU) + 1);
        for y:=High(EU) - 1 downto x + 1 do
          EU[y + 1]:=EU[y];
        EU[x + 1].I:=Inizio;
        EU[x + 1].F:=Fine;
        LimitaInizioFine(x + 1);
        Break;
      end;
    end;
  end;
begin
  Result:=0;
  inc(Result,AumentaFlexDaGiustificativi);
  if flex90 = 0 then
    exit;
  PuntiNomEU:=ttimbraturenom[i90e].tminutin_u - ttimbraturenom[i90e].tminutin_e;
  InizioFlex:=ttimbraturenom[i90e].tminutin_e;
  FineFlex:=InizioFlex + flex90;

  SetLength(EU,2);
  EU[0].I:=InizioFlex;
  EU[0].F:=InizioFlex;
  EU[1].I:=FineFlex;
  EU[1].F:=FineFlex;
  //timbrature che coprono la fascia di flessibilità
  for i:=1 to n_timbrdip do
    with ttimbraturedip[i] do
    begin
      if (tcausale_e.tcaus <> '') and (*(tpuntnomin = i90e) stesso punto nominale??*)
         (ValStrT275[tcausale_e.tcaus,'LIQUIDABILE'] = 'B') and   //Ore esterne all'orario
         (R180CarattereDef(ValStrT275[tcausale_e.tcaus,'TIPOCONTEGGIO']) in ['B','C']) and //Causale su entrata/uscita
         (ValStrT275[tcausale_e.tcaus,'E_IN_FLESSIBILITA'] = 'S') //eclusa dalla flessibilità
      then //Non considerata nella flessibilità
        Continue;
      E:=tminutid_e;
      U:=tminutid_u;
      if (i = 1) and
         (tcausale_e.tcaus <> '') and
         (tcausale_e.tcauscon = 'A') and
         (ValStrT275[tcausale_e.tcaus,'E_IN_FLESSIBILITA'] = 'N')
      then  //Se prima timbratura considerata, e causalizzata come ritardo su entrata, considero E nominale
        E:=InizioFlex;
      if (i = n_timbrdip) and
         (tcausale_u.tcaus <> '') and
         (tcausale_u.tcauscon = 'A')
      then  //Se ultima timbratura considerata, e causalizzata come anticipo su uscita, considero U nominale
        U:=max(FineFlex,U);
      Inserisci(E,U);
    end;

  //giustificativi che coprono la fascia di flessibilità
  for i:=1 to n_giusdaa do
  begin
    z964_leggicaus(tgius_dallealle[i].tcausdaa);
    if (s_trovato = 'no') or (parcaus.l29_18paramet <> 'S') then
      Continue;
    E:=max(tgius_dallealle[i].tminutida,InizioFlex);
    U:=min(tgius_dallealle[i].tminutia,FineFlex);
    Inserisci(E,U);
  end;

  //cumulo gli intervalli scoperti calcolati precedentemente
  dec(PuntiNomEU,max(0,EU[0].F - EU[0].I));
  for i:=1 to High(EU) do
  begin
    //la gestione di PuntiNomEU serve nei casi estremi in cui si usa una flessibilità molto alta, superiore alla durata dell'orario stesso, per evitare di calcolare come 'buco' da recuperare anche lo spezzone rimasto dopo l'ultima uscita
    dec(PuntiNomEU,max(0,EU[i].F - EU[i].I));
    if PuntiNomEU <= 0 then
      Break;
    inc(Result,EU[i].I - EU[i - 1].F);
  end;

  //annullo arrotondamento timbrature in flessibilità (non significativo in questa modalità)
  for i:=1 to n_timbrdip do
  begin
    if ttimbraturedip[i].tpuntnomin = i90e then
      ttimbraturedip[i].tflagarr_e:='si';
  end;
end;

procedure TR502ProDtM1.z092_flexspost;
{Spostamento uscita nominale per flessibilita'}
begin
  if flex92 <> 0 then
    begin
    inc(ttimbraturenom[i90u].tminutin_u,flex92);
    inc(tflexu[i90u],flex92);
    inc(ttimbraturenom[i90u].Flex,flex92);
    end;
end;

procedure TR502ProDtM1.z094_appoggcaus;
{Tolgo appoggio orario alle timbrature con causale di presenza accoppiate per orario libero o elastico o turno non pianificato}
var i:Integer;
begin
  for i:=1 to n_timbrdip do
    if not((ttimbraturedip[i].tcausale_e.tcaus = '') or
           (ttimbraturedip[i].tcausale_e.tcaustip <> 'B') or
           (ttimbraturedip[i].tcausale_e.tcauscon = 'A') or
           (ttimbraturedip[i].tcausale_e.tcaus <> ttimbraturedip[i].tcausale_u.tcaus)) then
      //if (TipoOrario <> 'E') or (n_timbrnom > 1) or (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'SEMPRE_APPOGGIATA'] <> 'S') then
    begin
      if (TipoOrario <> 'E') then
        ttimbraturedip[i].tpuntnomin:=0
      else if (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'SEMPRE_APPOGGIATA'] <> 'S') then
        ttimbraturedip[i].tpuntnomin:=0
      else //TipoOrario = E and SEMPRE_APPOGGIATA = 'S'
        if (n_timbrnom > 1) and XParam[XP_Z094_SOLO1TURNO] then
          ttimbraturedip[i].tpuntnomin:=0;
    end;
end;

procedure TR502ProDtM1.z096_presinorar;
{Anomalia e eliminazione per timbrature con causale di
 presenza interne all'orario con tipo conteggio diverso da A}
var i,j:Integer;
begin
  for i:=1 to n_timbrdip do
  begin
    if ttimbraturedip[i].tpuntnomin = 0 then Continue;
    j:=ttimbraturedip[i].tpuntnomin;
    if ttimbraturedip[i].tminutid_e >= ttimbraturenom[j].tminutin_e then
      if (ttimbraturedip[i].tcausale_e.tcaus <> '') and
         (ttimbraturedip[i].tcausale_e.tcaustip = 'B') and
         (ttimbraturedip[i].tcausale_e.tcauscon <> 'A') then
      begin
        if (ttimbraturedip[i].tminutid_e = ttimbraturenom[j].tminutin_e) and
           (ttimbraturedip[i].tminutid_e = 0) then
          ttimbraturedip[i].tcausale_e.tcaus:=''
        else
        begin
          z098_anom2caus(3,Format('%s(%s)',[ttimbraturedip[i].tcausale_e.tcaus,R180MinutiOre(ttimbraturedip[i].tminutid_e)]));
          ttimbraturedip[i].tcausale_e.tcaus:='';
        end;
      end;
    if ttimbraturedip[i].tminutid_u <= ttimbraturenom[j].tminutin_u then
      if (ttimbraturedip[i].tcausale_u.tcaus <> '') and
         (ttimbraturedip[i].tcausale_u.tcaustip = 'B') and
         (ttimbraturedip[i].tcausale_u.tcauscon <> 'A') then
      begin
        if (ttimbraturedip[i].tminutid_u = ttimbraturenom[j].tminutin_u) and
           (ttimbraturedip[i].tminutid_u = 1440) then
          ttimbraturedip[i].tcausale_u.tcaus:=''
        else
        begin
          z098_anom2caus(3,Format('%s(%s)',[ttimbraturedip[i].tcausale_u.tcaus,R180MinutiOre(ttimbraturedip[i].tminutid_u)]));
          ttimbraturedip[i].tcausale_u.tcaus:='';
        end;
      end;
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.z097_anom2caus_conteggio(pCodAnom:Word; pCausale:String = 'tcausale.tcaus'): Integer;
var i:Integer;
begin
  Result:=0;
  if pCausale = 'tcausale.tcaus' then
  begin
    pCausale:=tcausale.tcaus;
  end;
  for i:=Low(tanom2riscontrate) to High(tanom2riscontrate) do
  begin
    if (tanom2riscontrate[i].ta2puntdesc = pCodAnom) and (tanom2riscontrate[i].ta2caus = pCausale) then
      inc(Result);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z098_anom2caus(pCodAnom:Word; pCausale:String = 'tcausale.tcaus');
{Anomalia di secondo livello}
begin
  if not calcolo_z100 then exit; //Alberto: FIRENZE_COMUNE
  inc(n_anom2);
  SetLength(tanom2riscontrate,n_anom2 + 1);
  tanom2riscontrate[n_anom2].ta2puntdesc:=pCodAnom;
  if pCausale = 'tcausale.tcaus' then
  begin
    tanom2riscontrate[n_anom2].ta2caus:=tcausale.tcaus;
    tcausale.tcaus:='';
  end
  else
    tanom2riscontrate[n_anom2].ta2caus:=pCausale;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z099_anom3(pCodAnom:Word; pTimb:Integer; pDesc:String);
{Anomalia di terzo livello}
begin
  inc(n_anom3,1);
  SetLength(tanom3riscontrate,n_anom3 + 1);
  tanom3riscontrate[n_anom3].ta3puntdesc:=pCodAnom;
  tanom3riscontrate[n_anom3].ta3timb:=pTimb;
  tanom3riscontrate[n_anom3].ta3desc:=pDesc;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z100_coppieEU;
{Gestione globale timbrature a coppie di E - U}
begin
  p1:=ttimbraturedip[ieu].tpuntnomin;
  if p1 = 0 then
    //E - U fuori orario
    begin
    z102_fuoriorario;
    exit;
    end;
  if TipoOrario = 'E' then
    begin
    pe:=ttimbraturenom[p1].tpuntre;
    pu:=ttimbraturenom[p1].tpuntru;
    end
  else
    begin
    pe:=p1;
    pu:=p1;
    end;
  if ttimbraturedip[ieu].tminutid_e < ttimbraturenom[p1].tminutin_e then
    //E anticipata rispetto a quella nominale
    z104_Eanticipata
  else
    if ttimbraturedip[ieu].tminutid_e = ttimbraturenom[p1].tminutin_e then
      //E coincidente con quella nominale
      z108_Ecoincnomin
    else
    begin
      //E ritardata rispetto a quella nominale
      z110_Eritardata;
      ttimbraturenom[p1].Ritardo:=ttimbraturedip[ieu].tminutid_e - ttimbraturenom[p1].tminutin_e;
    end;
  if blocca <> 0 then exit;
  if ttimbraturedip[ieu].tminutid_u > ttimbraturenom[p1].tminutin_u then
    //U ritardata rispetto a quella nominale
    z114_Uritardata
  else if ttimbraturedip[ieu].tminutid_u = ttimbraturenom[p1].tminutin_u then
    //U coincidente con quella nominale
    z118_Ucoincnomin
  else
    //U anticipata rispetto a quella nominale
    z120_Uanticipata;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z102_fuoriorario;
{E - U fuori orario}
var Abilitato:Boolean;
  function ProlungamentoSpezzato(Abilitato:Boolean):Boolean;
  //Se la timbratura corrente è un prolungamento di una timbratura appoggiata all'orario, valuta l'abilitazione allo straordinario come prolungamento, e non come spezzone.
  var i:Integer;
      Trovato:Boolean;
  begin
    Result:=Abilitato;
    if not XParam[XP_PROLUNGA_TIMB_SPEZZATE] then
      exit;

    Trovato:=False;
    for i:=ieu + 1 to n_timbrdip do
    begin
      if ttimbraturedip[i].tminutid_e <> ttimbraturedip[i - 1].tminutid_u then
        Break;
      if ttimbraturedip[i].tpuntnomin > 0 then
      begin
        Trovato:=True;
        Result:=Q430.FieldByName('StraordE').AsString = '2';
        Break;
      end;
    end;
    if not Trovato then
      for i:=ieu - 1 downto 1 do
      begin
        if ttimbraturedip[i].tminutid_u <> ttimbraturedip[i + 1].tminutid_e then
          Break;
        if ttimbraturedip[i].tpuntnomin > 0 then
        begin
          Trovato:=True;
          Result:=Q430.FieldByName('StraordU').AsString = '2';
          Break;
        end;
      end;
  end;
begin
  with ttimbraturedip[ieu] do
  begin
  //Verifica che l' eventuale causale su E non sia giustific.
  if (tcausale_e.tcaus <> '') and (tcausale_e.tcaustip = 'C') then
    if tcausale_e.tcausrag = traggrgius.C then
    //Giustificativo di pausa mensa abilitato
    begin
      if (tcausale_u.tcaus <> '') and (tcausale_u.tcaustip = 'B') then
      begin
        tcausale_e:=tcausale_u;
        if tcausale_u.tcausMatMensa = 'N' then paumendet:=0;  //Alberto: FIRENZE_COMUNE
      end
      else
        tcausale_e.tcaus:='';
    end
    else
    begin
      tcausale.tcaus:=tcausale_e.tcaus;
      z098_anom2caus(5);
      tcausale_e.tcaus:='';
    end;
  //Verifica che l' eventuale causale su U non sia giustific.
  if (tcausale_u.tcaus <> '') and (tcausale_u.tcaustip = 'C') then
    if tcausale_u.tcausrag = traggrgius.C then
    //Giustificativo di pausa mensa abilitato
    begin
      if (tcausale_e.tcaus <> '') and (tcausale_e.tcaustip = 'B') then
      begin
        tcausale_u:=tcausale_e;
        if tcausale_e.tcausMatMensa = 'N' then paumendet:=0;  //Alberto: FIRENZE_COMUNE
      end
      else
        tcausale_u.tcaus:='';
      end
   else
   begin
     tcausale.tcaus:=tcausale_u.tcaus;
     z098_anom2caus(5);
     tcausale_u.tcaus:='';
   end;
  //Verifica che le eventuali causali siano accoppiate
  if tcausale_e.tcaus = '' then
  begin
    if tcausale_u.tcaus <> '' then
    begin
      tcausale.tcaus:=tcausale_u.tcaus;
      z098_anom2caus(8);
      tcausale_e:=tcausale_u;
    end;
  end
  else
    if tcausale_u.tcaus = '' then
    begin
      tcausale.tcaus:=tcausale_e.tcaus;
      z098_anom2caus(8);
      tcausale_u:=tcausale_e;
    end
    else
      if tcausale_e.tcaus <> tcausale_u.tcaus then
      begin
        tcausale.tcaus:=tcausale_e.tcaus;
        z098_anom2caus(10);
        tcausale.tcaus:=tcausale_u.tcaus;
        z098_anom2caus(10);
        exit;
      end;
  SenzaCausale:=False;
  if tcausale_e.tcaus <> '' then
  //Gestione E - U fuori orario con causale
  begin
    if tcausale_e.tcausabi = 'no' then
    begin
      tcausale.tcaus:=tcausale_e.tcaus;
      z098_anom2caus(4);
      //Alberto 04/05/2010: Considero i giustificativi ai fini della PMA
      if calcolo_z100 and (*(ieu = 1)*) primaVolta_z148 and GetGiustifPM then
        z146_tipomenCDE(True);
    end
    else
    //Conteggio E - U con causale
    begin
      tcausale:=tcausale_e;
      //Gestione inibizione prolungamento orario
      z136_inibizprol;
      tcausale:=tcausale_e;
      z820_coppiecaus;
    end;
  end
  else
    SenzaCausale:=True;
  //Gestione E - U fuori orario senza causale
  //else (5.4.6)
  if SenzaCausale then
    if (TipoOrario = 'D') and (n_timbrnom = 0)  then
    //Orario libero senza E nominale: arrotondamenti e conteggio
    begin
      z886_fuoriorarrE;
      z888_fuoriorarrU;
      if tminutid_e > tminutid_u then
      begin
        z098_anom2caus(52,Format('%s-%s',[R180MinutiOre(tminutid_e),R180MinutiOre(tminutid_u)]));
        tminutid_u:=tminutid_e;
      end;
      //else
      z860_coppienorm;
    end
    else
    begin
      //if ((strabana = 'no') or (Q430.FieldByName('CausStraord').AsString = 'O')) and (not ProlungamentoSpezzato) then
      Abilitato:=(strabana <> 'no') and (ProlungamentoSpezzato(Q430.FieldByName('CausStraord').AsString = 'F'));
      if not Abilitato then
      //Straordinario non abilitato
      begin
        if calcolo_z100 then
        begin
          if tminutid_e < tminutid_u then
          begin
            z098_anom2caus(11,Format('%s-%s',[R180MinutiOre(tminutid_e),R180MinutiOre(tminutid_u)]));
            if strabana = 'no' then
            begin
              // utilizzo array spezzoni - 10.09.2010
              //inc(ProlungamentoInibito,tminutid_u - tminutid_e);
              PutSpezzoniNonAbilitati('NA','FO',tminutid_e,tminutid_u);
            end
            else
            begin
              // utilizzo array spezzoni - 10.09.2010
              //inc(ProlungamentoNonCausalizzato,tminutid_u - tminutid_e);
              PutSpezzoniNonAbilitati('NC','FO',tminutid_e,tminutid_u);
            end;
          end;
          Tag:='NON CONTEGGIATO';
          //Alberto 04/05/2010: Considero i giustificativi ai fini della PMA
          if (*(ieu = 1)*) primaVolta_z148 and GetGiustifPM then
            z146_tipomenCDE(True);
        end
        else
          Tag:='NON AUTORIZZATO';
      end
      else
      //Straordinario senza causale abilitato
      begin
        tcausale.tcausrag:=traggrcauspr[1].C;
        tcausale.tcaus:='';
        tcausale.tcausioe:='B';
        tcausale.tcausrpl:='B';
        tcausale.tNonAutorizzate:='N';
        tcausale.tOreInsufficenti:='N';
        tcausale.tminminuti:=0;
        tcausale.tmaxminuti:=1440;
        tcausale.tpianrep:='N';
        tcausale.tLfsCavMez:='N';
        z820_coppiecaus;
      end;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z104_Eanticipata;
{E anticipata rispetto a quella nominale
 Verifica che l' eventuale causale non sia giustificativo}
begin
  with ttimbraturedip[ieu] do
  if (tcausale_e.tcaus <>'') and (tcausale_e.tcaustip = 'C') then
  begin
    tcausale.tcaus:=tcausale_e.tcaus;
    z098_anom2caus(5);
    tcausale_e.tcaus:='';
  end;
  //Lettura tipo di abilitazione per prolungamento orario
  if (p1 = 1) or (TipoOrario = 'E') then
    abprol:=R180CarattereDef(Q430.FieldByName('StraordE').AsString)
  else
    abprol:=R180CarattereDef(Q430.FieldByName('StraordEU').AsString);
  SenzaCausale:=False;
  if ttimbraturedip[ieu].tcausale_e.tcaus <> '' then
    //Gestione E anticipata con causale
    begin
    if ttimbraturedip[ieu].tcausale_e.tcausabi = 'no' then
      //Causale non abilitata
      begin
      tcausale.tcaus:=ttimbraturedip[ieu].tcausale_e.tcaus;
      z098_anom2caus(4);
      ttimbraturedip[ieu].tminutid_e:=ttimbraturenom[p1].tminutin_e;
      end
    else
      if (ttimbraturedip[ieu].tcausale_e.tcauscon <> 'C') and
         (ttimbraturedip[ieu].tcausale_e.tcauscon <> 'D') then
        //Causale non su E anticipata
        begin
        tcausale.tcaus:=ttimbraturedip[ieu].tcausale_e.tcaus;
        z098_anom2caus(16);
        ttimbraturedip[ieu].tminutid_e:=ttimbraturenom[p1].tminutin_e;
        end
      else
        if (abprol = '0') and (ttimbraturedip[ieu].tcausale_e.tcausrag <> traggrcauspr[3].C) and
           (ttimbraturedip[ieu].tcausale_e.tcausrag <> traggrcauspr[4].C) then
          //Prolungamento orario inibito
        begin
          tcausale.tcaus:=ttimbraturedip[ieu].tcausale_e.tcaus;
          z098_anom2caus(15);
          if calcolo_z100 then
          begin
            // utilizzo array spezzoni - 10.09.2010
            //inc(ProlungamentoInibito,ttimbraturenom[p1].tminutin_e - ttimbraturedip[ieu].tminutid_e);
            PutSpezzoniNonAbilitati('NA','E',ttimbraturedip[ieu].tminutid_e,ttimbraturenom[p1].tminutin_e);
          end;
          ttimbraturedip[ieu].tminutid_e:=ttimbraturenom[p1].tminutin_e;
        end
        else
          //Conteggio prolungamento orario con causale
          begin
          indice:=ieu + 1;
          //Inserimento cella coppia E_U nelle timbrature dipendente
          z816_insetimbr;
          //tuscitad[indice]:=tuscitad[ieu];
          ttimbraturedip[indice].tminutid_u:=ttimbraturedip[ieu].tminutid_u;
          ttimbraturedip[indice].tcausale_u:=ttimbraturedip[ieu].tcausale_u;
          ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[ieu].tflagarr_u;
          ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_e;
          ttimbraturedip[indice].tminutid_e:=ttimbraturenom[p1].tminutin_e;
          ttimbraturedip[ieu].tcausale_u:=ttimbraturedip[ieu].tcausale_e;
          ttimbraturedip[ieu].tflagarr_u:='si';
          ttimbraturedip[indice].tflagarr_e:='si';
          ttimbraturedip[indice].trilev_e:=ttimbraturedip[ieu].trilev_e;
          ttimbraturedip[indice].trilev_u:=ttimbraturedip[ieu].trilev_u;
          ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
          ttimbraturedip[indice].tpuntnomin:=p1;
          ttimbraturedip[ieu].tpuntnomin:=0;
          //Controllo se la nuova timbratura è esterna ai turni di reperibilità pianificati
          case z521_TimbEsterneAllaReperib(ieu) of
            'C':;  //Timbratura cancellata
            'A':   //Causale annullata: conteggio il prolungamento
            begin
              if (strabana = 'no') or (abprol = '0') or (abprol = '1') then
              //Prolungamento orario non abilitato
              //Test su E anticipata senza causale e appoggio su E nominale
                z106_Eanttest
              else
                begin
                tcausale.tcausrag:=traggrcauspr[1].C;
                tcausale.tcaus:='';
                tcausale.tcausioe:='B';
                tcausale.tcausrpl:='B';
                tcausale.tNonAutorizzate:='N';
                tcausale.tOreInsufficenti:='N';
                tcausale.tminminuti:=0;
                tcausale.tmaxminuti:=1440;
                tcausale.tpianrep:='N';
                tcausale.tLfsCavMez:='N';
                z820_coppiecaus;
                end;
              inc(ieu);
            end;
            'I':    //Situazione invariata
            begin
              //Conteggio prolungamento orario con causale
              tcausale:=ttimbraturedip[ieu].tcausale_e;
              z820_coppiecaus;
              if not SenzaCausale then
                inc(ieu);
            end;
          end;
          end;
    end
  else
    SenzaCausale:=True;
  //Gestione E anticipata senza causale
  //else (5.4.6)
  if SenzaCausale then
    if (strabana = 'no') or (abprol = '0') or (abprol = '1') then
      //Prolungamento orario non abilitato
      //Test su E anticipata senza causale e appoggio su E nominale
      z106_Eanttest
    else
      begin
      //Prolungamento orario senza causale abilitato
      //Conteggio prolungamento orario senza causale
      indice:=ieu + 1;
      //Inserimento cella coppia E_U nelle timbrature dipendente
      z816_insetimbr;
      //tuscitad[indice]:=tuscitad[ieu];
      ttimbraturedip[indice].tminutid_u:=ttimbraturedip[ieu].tminutid_u;
      ttimbraturedip[indice].trilev_e:=ttimbraturedip[ieu].trilev_e;
      ttimbraturedip[indice].trilev_u:=ttimbraturedip[ieu].trilev_u;
      ttimbraturedip[indice].tcausale_u:=ttimbraturedip[ieu].tcausale_u;
      ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[ieu].tflagarr_u;
      ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_e;
      ttimbraturedip[indice].tminutid_e:=ttimbraturenom[p1].tminutin_e;
      ttimbraturedip[ieu].tflagarr_u:='si';
      ttimbraturedip[indice].tflagarr_e:='si';
      ttimbraturedip[ieu].tcausale_u:=tcausale_vuota;
      ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
      ttimbraturedip[indice].tpuntnomin:=p1;
      ttimbraturedip[ieu].tpuntnomin:=0;
      tcausale.tcausrag:=traggrcauspr[1].C;
      tcausale.tcaus:='';
      tcausale.tcausioe:='B';
      tcausale.tcausrpl:='B';
      tcausale.tNonAutorizzate:='N';
      tcausale.tOreInsufficenti:='N';
      tcausale.tminminuti:=0;
      tcausale.tmaxminuti:=1440;
      tcausale.tpianrep:='N';
      tcausale.tLfsCavMez:='N';
      z820_coppiecaus;
      inc(ieu);
      end;
  end;
//_________________________________________________________________
procedure TR502ProDtM1.z106_Eanttest;
{Test su E anticipata senza causale e appoggio su E nominale}
begin
  ant:=ttimbraturenom[p1].tminutin_e - ttimbraturedip[ieu].tminutid_e;
  if (ant > ValNumT021['MMANTICIPO',TF_PUNTI_NOMINALI,pe]) and (calcolo_z100) and (not conteggi_sologiust) then
  begin
    z099_anom3(1,ttimbraturedip[ieu].tminutid_e,'');
  end;
  if calcolo_z100 then
  begin
    if (abprol = '0') or (strabana = 'no') then
    begin
      // utilizzo array spezzoni - 10.09.2010
      //inc(ProlungamentoInibito,ttimbraturenom[p1].tminutin_e - ttimbraturedip[ieu].tminutid_e);
      PutSpezzoniNonAbilitati('NA','E',ttimbraturedip[ieu].tminutid_e,ttimbraturenom[p1].tminutin_e);
    end
    else
    begin
      // utilizzo array spezzoni - 10.09.2010
      //inc(ProlungamentoNonCausalizzato,ttimbraturenom[p1].tminutin_e - ttimbraturedip[ieu].tminutid_e);
      PutSpezzoniNonAbilitati('NC','E',ttimbraturedip[ieu].tminutid_e,ttimbraturenom[p1].tminutin_e);
    end;
  end;
  ttimbraturedip[ieu].tminutid_e:=ttimbraturenom[p1].tminutin_e;
end;
//_______________________________________________________________
procedure TR502ProDtM1.z108_Ecoincnomin;
{E coincidente con quella nominale
 Verifica che non vi sia causale tranne nell' elastico S}
begin
with ttimbraturedip[ieu] do
  if (tcausale_e.tcaus <> '') and (tcausale_e.tcaustip <> 'C') then
    if (TipoOrario = 'C') and (PeriodoLavorativo = 'S') and (p1 = 2) then
      exit
    else
      begin
      tcausale.tcaus:=tcausale_e.tcaus;
      z098_anom2caus(5);
      tcausale_e.tcaus:='';
      end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z110_Eritardata;
{E ritardata rispetto a quella nominale}
var x:Integer;
    PrimaTimb:Boolean;
  procedure Eritdopor_Golgi(Ritardo,T020Entrata,T020Ritardo,T020Tolleranza:Integer);
  var mmAbbuonati:Integer;
  begin
    mmAbbuonati:=min(Ritardo - T020Ritardo,T020Tolleranza);
    z442_giustcar_esterno('ER', EncodeDate(1899,12,30) + (mmAbbuonati/1440), 0, 'N');
  end;
begin
  i890:=ieu;
  e_u890:='E';

  //Considero il punto nominale al netto del cambio tuta
  rit:=ttimbraturedip[ieu].tminutid_e - EntrataNominaleNetta[p1,pe];//ttimbraturenom[p1].tminutin_e
  if rit <= 0 then
    exit;

  //Verifico se la timbratura in oggetto è la prima della giornata per il suo punto nominale
  PrimaTimb:=True;
  for x:=1 to ieu - 1 do
    if ttimbraturedip[ieu].tpuntnomin = ttimbraturedip[x].tpuntnomin then
    begin
      PrimaTimb:=False;
      Break;
    end;
  if (ieu <> 1) and (not PrimaTimb) then
  //if (ieu <> 1) and (ttimbraturedip[ieu].tpuntnomin = ttimbraturedip[i3].tpuntnomin) then
  begin
   //Gestione E dopo ritardo
   if cdsT020.FieldByName('ARR_TIMB_INTERNE').AsString = 'S' then
     z112_Eritdopor;
  end
  else if TipoOrario = 'B' then
  //E ritardata rispetto a quella nominale tipo orario B
  begin
    if (rit <= ValNumT021['TOLLERANZA',TF_PUNTI_NOMINALI,p1]) and (f03_com <> 'NO TOLLERANZA') then
    //Tolleranza
    begin
      ttimbraturedip[ieu].tminutid_e:=EntrataNominaleNetta[p1,pe];//ttimbraturenom[p1].tminutin_e;
      inc(tollergod,rit);
    end
    else if rit <= ValNumT021['MMRITARDO',TF_PUNTI_NOMINALI,p1] then
    //Ritardo
    begin
      arr890:=ValNumT021['MMARROTOND',TF_PUNTI_NOMINALI,p1];
      z890_arrotonda;
    end
    else
      //Gestione E dopo ritardo
      z112_Eritdopor;
  end
  else if TipoOrario = 'C' then
  begin
  //E ritardata rispetto a quella nominale tipo orario C
    if ttimbraturedip[ieu].tflagarr_e <> 'si' then
    begin
      if (p1 = 2) and (PeriodoLavorativo = 'S') then
       //Gestione E dopo ritardo
       z112_Eritdopor
      else
      begin
      (*Attenzione! punti nominali per orario elastico!*)
        comodo2:=ValNumT021['ENTRATA_OBB',TF_PUNTI_NOMINALI,1] - ttimbraturenom[p1].tminutin_e;
        comodo3:=comodo2 + ValNumT021['MMRITARDO',TF_PUNTI_NOMINALI,1];
        if rit <= comodo2 then
        //E in fascia
        begin
          arr890:=ValNumT021['ARRFLESFASC',TF_PUNTI_NOMINALI,1];
          z890_arrotonda;
        end
        else if rit <= comodo3 then
        //Ritardo
        begin
          arr890:=ValNumT021['ARRRITARDO',TF_PUNTI_NOMINALI,1];
          z890_arrotonda;
        end
        else
          //Gestione E dopo ritardo
          z112_Eritdopor;
      end;
    end;
  end
  else if TipoOrario = 'D' then
  //E ritardata rispetto a quella nominale tipo orario D
  begin
    if rit <= ValNumT021['MMRITARDO',TF_PUNTI_NOMINALI,p1] then
    //Ritardo
    begin
      arr890:=ValNumT021['ARRRITARDO',TF_PUNTI_NOMINALI,p1];
      z890_arrotonda;
    end
    else
      //Gestione E dopo ritardo
      z112_Eritdopor;
  end
  else if TipoOrario = 'E' then
    //E ritardata rispetto a quella nominale tipo orario E
    if pe = 0 then
      //E durante orario in un turno a cavallo di mezzanotte
      //Gestione E dopo ritardo
      z112_Eritdopor
    else
      if (rit <= ValNumT021['TOLLERANZA',TF_PUNTI_NOMINALI,pe]) and (f03_com <> 'NO TOLLERANZA') and (not XParam[XP_GOLGI_ENTRATA_RIT]) then
        //Tolleranza
        begin
        ttimbraturedip[ieu].tminutid_e:=EntrataNominaleNetta[p1,pe];//ttimbraturenom[p1].tminutin_e;
        inc(tollergod,rit)
        end
      else if rit <= ValNumT021['MMRITARDO',TF_PUNTI_NOMINALI,pe] then
      //Ritardo
      begin
        arr890:=ValNumT021['MMARROTOND',TF_PUNTI_NOMINALI,pe];
        z890_arrotonda;
      end
      else
      begin
        //Gestione E dopo ritardo
        z112_Eritdopor;
        if XParam[XP_GOLGI_ENTRATA_RIT] then
          Eritdopor_Golgi(rit,ttimbraturenom[p1].tminutin_e,ValNumT021['MMRITARDO',TF_PUNTI_NOMINALI,pe],ValNumT021['TOLLERANZA',TF_PUNTI_NOMINALI,pe]);
      end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z112_Eritdopor;
{Gestione E dopo ritardo}
var Anomalia:Boolean;
    FlexGius:Boolean;
    i,xx,tminutiflex_e:Integer;
begin
  if TipoOrario = 'C' then
  begin
    FlexGius:=False;
    //5.5.2 LaSpezia: se la fascia di flessibilità è coperta da giustificativi non la applico
    //Si usa tminutiflex_e anzichè ttimbraturedip[i1].tminutid_e
    //ttimbraturedip[ieu].tminutid_e - ttimbraturenom[p1].tminutin_e;
    for i:=1 to n_giusdaa do
    begin
      z964_leggicaus(tgius_dallealle[i].tcausdaa);
      if (s_trovato = 'no') or (parcaus.l29_18paramet <> 'S') then
        Continue;
      if (tgius_dallealle[i].tminutida <= ValNumT021['ENTRATA_OBB',TF_PUNTI_NOMINALI,1]) and
         (tgius_dallealle[i].tminutia >= ttimbraturenom[p1].tminutin_e) then
      begin
        tminutiflex_e:=Max(tgius_dallealle[i].tminutida,ttimbraturenom[p1].tminutin_e);
        FlexGius:=True;
      end;
    end;
    (* controllo su mezza giornata Valido solo per CSI
    for i:=1 to n_giusmga do
    begin
      z964_leggicaus(tgius_mgass[i].tcausmgass);
      if (s_trovato = 'no') or (parcaus.l29_18paramet <> 'S') then
        Continue;
      if tgius_mgass[i].ttipomg <> 'M' then
        Continue;
      if (ValNumT021['ENTRATA',TF_MG_MAT,1] <= tminutiflex_e) and (ValNumT021['USCITA',TF_MG_MAT,1] >= ttimbraturenom[p1].tminutin_e) then
      begin
        tminutiflex_e:=Max(ValNumT021['ENTRATA',TF_MG_MAT,1],ttimbraturenom[p1].tminutin_e);
        FlexGius:=True;
      end;
    end;
    *)
    //Alberto 15/06/2009: non arrotondo più le timbrature successive al giustificativo di assenza
    if FlexGius and (cdsT020.FieldByName('ARR_TIMB_INTERNE').AsString = 'N') then
      for xx:=1 to n_timbrdip do
        if ttimbraturedip[xx].tminutid_e > tminutiflex_e then
          ttimbraturedip[xx].tflagarr_e:='si';
  end;

  if (TipoOrario <> 'D') or (PeriodoLavorativo <> 'EU') then
  begin
    Anomalia:=(ttimbraturedip[ieu].tcausale_e.tcaus = '') or (ttimbraturedip[ieu].tcausale_e.tcaustip <> 'C');
    Anomalia:=Anomalia and (calcolo_z100) and (not conteggi_sologiust);
    if Length(TimbratureMensa) > 0 then
      Anomalia:=Anomalia and (ttimbraturedip[ieu].tminutid_e <> TimbratureMensa[0].F);
    if Anomalia then
    begin
      z099_anom3(1,ttimbraturedip[ieu].tminutid_e,'');
    end;
  end;
  if (TipoOrario = 'C') or (TipoOrario = 'D') then
    arr890:=ValNumT020['ArrFuoEnt']
  else if pe = 0 then
    arr890:=ValNumT021['ARRRITARDO',TF_PUNTI_NOMINALI,pu]
  else
    arr890:=ValNumT021['ARRRITARDO',TF_PUNTI_NOMINALI,pe];
  z890_arrotonda;
end;
//_______________________________________________________________
procedure TR502ProDtM1.z114_Uritardata;
{U ritardata rispetto a quella nominale
 Verifica che l' eventuale causale non sia giustificativo}
begin
  if (ttimbraturedip[ieu].tcausale_u.tcaus <> '') and (ttimbraturedip[ieu].tcausale_u.tcaustip = 'C') then
  begin
    tcausale.tcaus:=ttimbraturedip[ieu].tcausale_u.tcaus;
    z098_anom2caus(5);
    ttimbraturedip[ieu].tcausale_u.tcaus:='';
  end;
  //Lettura tipo di abilitazione per prolungamento orario
  if (p1 = n_timbrnom) or (TipoOrario = 'E') then
    abprol:=R180CarattereDef(Q430.FieldByName('StraordU').AsString)
  else
    abprol:=R180CarattereDef(Q430.FieldByName('StraordEU2').AsString);
  SenzaCausale:=False;
  if ttimbraturedip[ieu].tcausale_u.tcaus <> '' then
  //Gestione U ritardata con causale
  begin
    if ttimbraturedip[ieu].tcausale_u.tcausabi = 'no' then
    //Causale non abilitata
    begin
      tcausale.tcaus:=ttimbraturedip[ieu].tcausale_u.tcaus;
      z098_anom2caus(4);
      ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_u
    end
    else if (ttimbraturedip[ieu].tcausale_u.tcauscon <> 'C') and (ttimbraturedip[ieu].tcausale_u.tcauscon <> 'D') then
    //Causale non su U posticipata
    begin
      tcausale.tcaus:=ttimbraturedip[ieu].tcausale_u.tcaus;
      z098_anom2caus(16);
      ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_u
      end
    else if (abprol = '0') and (ttimbraturedip[ieu].tcausale_u.tcausrag <> traggrcauspr[3].C) and
            (ttimbraturedip[ieu].tcausale_u.tcausrag <> traggrcauspr[4].C) then
    //Prolungamento orario inibito
    begin
      tcausale.tcaus:=ttimbraturedip[ieu].tcausale_u.tcaus;
      z098_anom2caus(15);
      if calcolo_z100 then
      begin
        // utilizzo array spezzoni - 10.09.2010
        //inc(ProlungamentoInibito,ttimbraturedip[ieu].tminutid_u - ttimbraturenom[p1].tminutin_u);
        PutSpezzoniNonAbilitati('NA','U',ttimbraturenom[p1].tminutin_u,ttimbraturedip[ieu].tminutid_u);
      end;
      ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_u;
    end
    else
    //Conteggio prolungamento orario con causale
    begin
      indice:=ieu + 1;
      //Inserimento cella coppia E_U nelle timbrature dipendente
      z816_insetimbr;
      //tuscitad[indice]:=tuscitad[ieu];
      ttimbraturedip[indice].tminutid_u:=ttimbraturedip[ieu].tminutid_u;
      ttimbraturedip[indice].trilev_e:=ttimbraturedip[ieu].trilev_e;
      ttimbraturedip[indice].trilev_u:=ttimbraturedip[ieu].trilev_u;
      ttimbraturedip[indice].tcausale_u:=ttimbraturedip[ieu].tcausale_u;
      ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[ieu].tflagarr_u;
      ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_u;
      ttimbraturedip[indice].tminutid_e:=ttimbraturenom[p1].tminutin_u;
      ttimbraturedip[indice].tcausale_e:=ttimbraturedip[indice].tcausale_u;
      ttimbraturedip[ieu].tflagarr_u:='si';
      ttimbraturedip[indice].tflagarr_e:='si';
      ttimbraturedip[ieu].tcausale_u:=tcausale_vuota;
      ttimbraturedip[indice].tpuntnomin:=0;
      if (ttimbraturedip[indice].tcausale_u.tcauscon = 'D') and
         (indice = n_timbrdip) and
         (ValStrT275[ttimbraturedip[indice].tcausale_u.tcaus,'FORZA_CAUSECCEDENZA'] <> 'S') then
        //Prolungamento orario dopo resa orario teorico
        prolcaus:=ttimbraturedip[indice].tcausale_u.tcaus;
      //Conteggio E - U in ore normali
      if ttimbraturedip[ieu].tminutid_e > ttimbraturedip[ieu].tminutid_u then
      begin
        z098_anom2caus(52,Format('%s-%s',[R180MinutiOre(ttimbraturedip[ieu].tminutid_e),R180MinutiOre(ttimbraturedip[ieu].tminutid_u)]));
        ttimbraturedip[ieu].tminutid_u:=ttimbraturedip[ieu].tminutid_e;
      end;
      //else
      begin
        z860_coppienorm;
        //Controllo se la nuova timbratura è esterna ai turni di reperibilità pianificati
        case z521_TimbEsterneAllaReperib(indice) of
          'C':;  //Timbratura cancellata
          'A':   //Causale annullata: conteggio il prolungamento
            begin
              inc(ieu);
              if (strabana = 'no') or (abprol = '0') or (abprol = '1') then
                //Prolungamento orario non abilitato
                //Test su U ritardata senza causale e appoggio su U nominale
                z116_Urittest
              else
              begin
                tcausale.tcausrag:=traggrcauspr[1].C;
                tcausale.tcaus:='';
                tcausale.tcausioe:='B';
                tcausale.tcausrpl:='B';
                tcausale.tNonAutorizzate:='N';
                tcausale.tOreInsufficenti:='N';
                tcausale.tminminuti:=0;
                tcausale.tmaxminuti:=1440;
                tcausale.tpianrep:='N';
                tcausale.tLfsCavMez:='N';
                z820_coppiecaus;
              end;
            end;
          'I':    //Situazione invariata
            begin
              inc(ieu);
              //Conteggio prolungamento orario con causale
              tcausale:=ttimbraturedip[ieu].tcausale_e;
              z820_coppiecaus;
            end;
        end;
        (*z860_coppienorm;
          inc(ieu);
          //Conteggio prolungamento orario con causale
          tcausale:=ttimbraturedip[ieu].tcausale_e;
          z820_coppiecaus;*)
      end;
      if not SenzaCausale then
        exit;
    end;
  end
  else
    SenzaCausale:=True;
  //Gestione U ritardata senza causale
  //else (5.4.6)
  if SenzaCausale then
    if (strabana = 'no') or (abprol = '0') or (abprol = '1') then
      //Prolungamento orario non abilitato
      //Test su U ritardata senza causale e appoggio su U nominale
      z116_Urittest
    else
      //Prolungamento orario senza causale abilitato
      //Conteggio prolungamento orario senza causale
    begin
      if ttimbraturedip[ieu].tminutid_e >= ttimbraturenom[p1].tminutin_u then
      begin
        ttimbraturedip[ieu].tflagarr_e:='si';
        ttimbraturedip[ieu].tcausale_e:=tcausale_vuota;
        ttimbraturedip[ieu].tpuntnomin:=0;
      end
      else
      begin
        indice:=ieu + 1;
        //Inserimento cella coppia E_U nelle timbrature dipendente
        z816_insetimbr;
        //tuscitad[indice]:=tuscitad[ieu];
        ttimbraturedip[indice].tminutid_u:=ttimbraturedip[ieu].tminutid_u;
        ttimbraturedip[indice].trilev_e:=ttimbraturedip[ieu].trilev_e;
        ttimbraturedip[indice].trilev_u:=ttimbraturedip[ieu].trilev_u;
        ttimbraturedip[indice].tcausale_u:=ttimbraturedip[ieu].tcausale_u;
        ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[ieu].tflagarr_u;
        ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_u;
        ttimbraturedip[indice].tminutid_e:=ttimbraturenom[p1].tminutin_u;
        ttimbraturedip[ieu].tflagarr_u:='si';
        ttimbraturedip[indice].tflagarr_e:='si';
        ttimbraturedip[ieu].tcausale_u:=tcausale_vuota;
        ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
        ttimbraturedip[indice].tpuntnomin:=0;
      end;
      //Conteggio E - U in ore normali
      if ttimbraturedip[ieu].tminutid_e > ttimbraturedip[ieu].tminutid_u then
      begin
        z098_anom2caus(52,Format('%s-%s',[R180MinutiOre(ttimbraturedip[ieu].tminutid_e),R180MinutiOre(ttimbraturedip[ieu].tminutid_u)]));
        ttimbraturedip[ieu].tminutid_u:=ttimbraturedip[ieu].tminutid_e;
      end;
      //else
      begin
        z860_coppienorm;
        inc(ieu);
        //Conteggio prolungamento orario senza causale
        tcausale.tcausrag:=traggrcauspr[1].C;
        tcausale.tcaus:='';
        tcausale.tcausioe:='B';
        tcausale.tcausrpl:='B';
        tcausale.tNonAutorizzate:='N';
        tcausale.tOreInsufficenti:='N';
        tcausale.tminminuti:=0;
        tcausale.tmaxminuti:=1440;
        tcausale.tpianrep:='N';
        tcausale.tLfsCavMez:='N';
        z820_coppiecaus;
      end;
      exit;
    end;
  //Conteggio E - U in ore normali
  if ttimbraturedip[ieu].tminutid_e > ttimbraturedip[ieu].tminutid_u then
  begin
    z098_anom2caus(52,Format('%s-%s',[R180MinutiOre(ttimbraturedip[ieu].tminutid_e),R180MinutiOre(ttimbraturedip[ieu].tminutid_u)]));
    ttimbraturedip[ieu].tminutid_u:=ttimbraturedip[ieu].tminutid_e;
  end;
  //else
  z860_coppienorm;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z116_Urittest;
{Test su U ritardata senza causale e appoggio su U nominale}
begin
  rit:=ttimbraturedip[ieu].tminutid_u - ttimbraturenom[p1].tminutin_u;
  if (TipoOrario = 'C') and (PeriodoLavorativo = 'S') then
    i1:=1
  else
    i1:=pu;
  if (rit > ValNumT021['MMRITARDOU',TF_PUNTI_NOMINALI,i1]) and (calcolo_z100) and (not conteggi_sologiust) then
  begin
    z099_anom3(2,ttimbraturedip[ieu].tminutid_u,'');
  end;
  if calcolo_z100 then
  begin
    if (abprol = '0') or (strabana = 'no') then
    begin
      // utilizzo array spezzoni - 10.09.2010
      //inc(ProlungamentoInibito,ttimbraturedip[ieu].tminutid_u - ttimbraturenom[p1].tminutin_u);
      PutSpezzoniNonAbilitati('NA','U',ttimbraturenom[p1].tminutin_u,ttimbraturedip[ieu].tminutid_u);
    end
    else
    begin
      // utilizzo array spezzoni - 10.09.2010
      //inc(ProlungamentoNonCausalizzato,ttimbraturedip[ieu].tminutid_u - ttimbraturenom[p1].tminutin_u);
      //inc(ProlungamentoNonCausUscita,ttimbraturedip[ieu].tminutid_u - ttimbraturenom[p1].tminutin_u);
      PutSpezzoniNonAbilitati('NC','U',ttimbraturenom[p1].tminutin_u,ttimbraturedip[ieu].tminutid_u);
    end;
  end;
  ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_u;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z118_Ucoincnomin;
{U coincidente con quella nominale
 Verifica che non vi sia causale tranne nell' elastico S}
begin
  if (ttimbraturedip[ieu].tcausale_u.tcaus <> '') and (ttimbraturedip[ieu].tcausale_u.tcaustip <> 'C') then
    if not((TipoOrario = 'C') and (PeriodoLavorativo = 'S') and (p1 = 1)) then
      begin
      tcausale.tcaus:=ttimbraturedip[ieu].tcausale_u.tcaus;
      z098_anom2caus(5);
      ttimbraturedip[ieu].tcausale_u.tcaus:='';
      end;
  //Conteggio E - U in ore normali
  if ttimbraturedip[ieu].tminutid_e > ttimbraturedip[ieu].tminutid_u then
  begin
    z098_anom2caus(52,Format('%s-%s',[R180MinutiOre(ttimbraturedip[ieu].tminutid_e),R180MinutiOre(ttimbraturedip[ieu].tminutid_u)]));
    ttimbraturedip[ieu].tminutid_u:=ttimbraturedip[ieu].tminutid_e;
  end;
  //else
  z860_coppienorm;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z120_Uanticipata;
{U anticipata rispetto a quella nominale}
var x:Integer;
    UltimaTimb:Boolean;
begin
  i890:=ieu;
  e_u890:='U';
  ant:=ttimbraturenom[p1].tminutin_u - ttimbraturedip[ieu].tminutid_u;
  //Verifico se la timbratura in oggetto è l'ultima della giornata per il suo punto nominale
  UltimaTimb:=True;
  for x:=ieu + 1 to n_timbrdip do
    if ttimbraturedip[ieu].tpuntnomin = ttimbraturedip[x].tpuntnomin then
    begin
      UltimaTimb:=False;
      Break;
    end;
  if (ieu <> n_timbrdip) and (not UltimaTimb) then
  //if (ieu <> n_timbrdip) and (ttimbraturedip[ieu].tpuntnomin = ttimbraturedip[i3].tpuntnomin) then
  begin
    if cdsT020.FieldByName('ARR_TIMB_INTERNE').AsString = 'S' then
      //Gestione U prima anticipo
      z122_Uantprimaa;
  end
  else if TipoOrario = 'A' then
  //U anticipata rispetto a quella nominale tipo orario A
  begin
    if ant <= ValNumT021['TOLLERANZAU',TF_PUNTI_NOMINALI,p1] then
      //Tolleranza
      ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_u
    else if ant <= tflexu[p1] then
    //Flessibilita'
    begin
      arr890:=ValNumT021['ARRFLESFASCU',TF_PUNTI_NOMINALI,p1];
      z890_arrotonda;
    end
    else
      //Gestione U prima anticipo
      z122_Uantprimaa;
  end
  else if TipoOrario = 'B' then
  //U anticipata rispetto a quella nominale tipo orario B
  begin
    if ant <= ValNumT021['TOLLERANZAU',TF_PUNTI_NOMINALI,p1] then
      //Tolleranza
      ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p1].tminutin_u
    else if ant <= ValNumT021['MMANTICIPOU',TF_PUNTI_NOMINALI,p1] then
    //Anticipo
    begin
      arr890:=ValNumT021['MMARROTONDU',TF_PUNTI_NOMINALI,p1];
      z890_arrotonda;
    end
    else
      //Gestione U prima anticipo
      z122_Uantprimaa;
  end
  else if TipoOrario = 'C' then
  //U anticipata rispetto a quella nominale tipo orario C
  begin
    if ttimbraturedip[ieu].tflagarr_u <> 'si' then
      if (p1 = 1) and (PeriodoLavorativo = 'S') then
      begin
        if (cdsT020.FieldByName('CauObFac').AsString = 'F') and (ttimbraturedip[ieu].tminutid_u >= ValNumT021['ENTRATAMM',TF_PM_TIMBRATA,1]) then
        //U in fascia mensa
        begin
          arr890:=ValNumT021['mmArrotond',TF_PM_TIMBRATA,1]; //Q020ArrotMensa;
          z890_arrotonda;
        end
        else
          //Gestione U prima anticipo
          z122_Uantprimaa;
      end
      else
      begin
        comodo2:=ttimbraturenom[p1].tminutin_u - ValNumT021['USCITA_OBB',TF_PUNTI_NOMINALI,1];
        comodo3:=comodo2 + ValNumT021['MMANTICIPOU',TF_PUNTI_NOMINALI,1];
        if ant <= comodo2 then
        //U in fascia
        begin
          arr890:=ValNumT021['ARRFLESFASCU',TF_PUNTI_NOMINALI,1];
          z890_arrotonda;
        end
        else if ant <= comodo3 then
        //Anticipo
        begin
          arr890:=ValNumT021['MMARROTONDU',TF_PUNTI_NOMINALI,1];
          z890_arrotonda;
        end
        else
          //Gestione U prima anticipo
          z122_Uantprimaa;
      end;
  end
  else if TipoOrario = 'D' then
    //U anticipata rispetto a quella nominale tipo orario D
    //Gestione U prima anticipo
    z122_Uantprimaa
  else if TipoOrario = 'E' then
    //U anticipata rispetto a quella nominale tipo orario E
    if pu = 0 then
      //U durante orario in un turno a cavallo di mezzanotte
      //Gestione U prima anticipo
      z122_Uantprimaa
    else if ant <= ValNumT021['MMANTICIPOU',TF_PUNTI_NOMINALI,pu] then
    //Anticipo
    begin
      arr890:=ValNumT021['MMARROTONDU',TF_PUNTI_NOMINALI,pu];
      z890_arrotonda;
    end
    else
      //Gestione U prima anticipo
      z122_Uantprimaa;
  //Conteggio E - U in ore normali
  if ttimbraturedip[ieu].tminutid_e > ttimbraturedip[ieu].tminutid_u then
  begin
    z098_anom2caus(52,Format('%s-%s',[R180MinutiOre(ttimbraturedip[ieu].tminutid_e),R180MinutiOre(ttimbraturedip[ieu].tminutid_u)]));
    ttimbraturedip[ieu].tminutid_u:=ttimbraturedip[ieu].tminutid_e;
  end;
  z860_coppienorm;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z122_Uantprimaa;
{Gestione U prima anticipo}
var Anomalia:Boolean;
begin
  if TipoOrario <> 'D' then
  begin
    Anomalia:=(ttimbraturedip[ieu].tcausale_u.tcaus = '') or (ttimbraturedip[ieu].tcausale_u.tcaustip <> 'C');
    Anomalia:=Anomalia and (calcolo_z100) and (not conteggi_sologiust);
    if Length(TimbratureMensa) > 0 then
      Anomalia:=Anomalia and (ttimbraturedip[ieu].tminutid_u <> TimbratureMensa[0].I);
    if Anomalia then
    begin
      z099_anom3(2,ttimbraturedip[ieu].tminutid_u,'');
    end;
  end;
  if TipoOrario = 'A' then
    arr890:=ValNumT021['ARRUSCANT',TF_PUNTI_NOMINALI,p1]
  else if TipoOrario = 'B' then
    arr890:=ValNumT021['ARRUSCANT',TF_PUNTI_NOMINALI,p1]
  else if (TipoOrario = 'C') or (TipoOrario = 'D') then
    arr890:=ValNumT020['ArrFuoUsc']
  else if pu = 0 then
    arr890:=ValNumT021['ARRUSCANT',TF_PUNTI_NOMINALI,pe]
  else
    arr890:=ValNumT021['ARRUSCANT',TF_PUNTI_NOMINALI,pu];
  z890_arrotonda;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z124_InsTimbtipoAesc(I,F:Integer);
begin
  SetLength(timbtipoAesc,Length(timbtipoAesc) + 1);
  timbtipoAesc[High(timbtipoAesc)].I:=I;
  timbtipoAesc[High(timbtipoAesc)].F:=F;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z125_delTimbtipoAesc(I,F:Integer);
var x,y:Integer;
begin
  for x:=High(timbtipoAesc) downto 0 do
  begin
    if (timbtipoAesc[x].I = I) and (timbtipoAesc[x].F = F) then
    begin
      for y:=x to High(timbtipoAesc) - 1 do
        timbtipoAesc[y]:=timbtipoAesc[y + 1];
      SetLength(timbtipoAesc,Length(timbtipoAesc) - 1);
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z126_allineaMintipoAesc(I,F:Integer);
var x,I2,F2:Integer;
begin
  x:=0;
  while x <= High(timbtipoAesc) do
  begin
    if (I <= timbtipoAesc[x].F) and (F >= timbtipoAesc[x].I) then
    begin
      I2:=max(I,timbtipoAesc[x].I);
      F2:=min(F,timbtipoAesc[x].F);
      if F2 - I2 > 0 then
      begin
        dec(mintipoAesc,F2 - I2);
        if I2 > timbtipoAesc[x].I then
          z124_InsTimbtipoAesc(timbtipoAesc[x].I,I2);
        if F2 < timbtipoAesc[x].F then
          z124_InsTimbtipoAesc(F2,timbtipoAesc[x].F);
        timbtipoAesc[x].I:=0;
        timbtipoAesc[x].F:=0;
      end;
    end;
    inc(x);
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.z130_FlexTipoConA:Integer;
{Flessibilità derivata dalla causalizzazione su Uscita/Entrata esclusa dalle normali
 LaSpezia: 22/10/2003}
var i,j,Tot,Soglia:Integer;
begin
  Result:=0;
  if (PausaMensa <> 'B') and (PausaMensa <> 'D') and (PausaMensa <> 'E') and (PausaMensa <> 'F') then
    exit;
  for i:=1 to n_rieppres do
    with triepgiuspres[i] do
    begin
      if (ValStrT275[tcauspres,'TIPOCONTEGGIO'] <> 'A') and
         (ValStrT275[tcauspres,'TIPOCONTEGGIO'] <> 'E') then
        Continue;
      if ValStrT275[tcauspres,'ORENORMALI']  <> 'A' then
        Continue;
      //if ValStrT275[tcauspres,'ESCLUSIONE_FASCIA_OBB'] = 'S' then
      if ValStrT275[tcauspres,'FLEX_TIMBR_CAUS'] = 'N' then
        Continue;
      if StrToIntDef(ValStrT275[tcauspres,'SOGLIA_FASCE_OBBLFAC'],0) = 0 then
        Continue;
      Soglia:=StrToIntDef(ValStrT275[tcauspres,'SOGLIA_FASCE_OBBLFAC'],0);
      Tot:=minpres0024;
      //Se il totale del causalizzato supera la soglia della causale, si annulla la flessibilità
      if Tot > Soglia then
        if ValStrT275[tcauspres,'FLEX_TIMBR_CAUS'] = 'A' then
          Tot:=0
        else if ValStrT275[tcauspres,'FLEX_TIMBR_CAUS'] = 'B' then
          Tot:=Soglia;
      inc(Result,Tot);
    end;
end;
//_________________________________________________________________
function TR502ProDtM1.z132_FlexPM(FlexPM,PN:Integer):Integer;
var SuperFlex:Integer;
begin
  if ValStrT021['mmFlex',TF_PM_TIMBRATA,1] = '' then
    Result:=FlexPM
  else
  begin
    if cdsT020.FieldByName('PMT_LIMITE_FLEX').AsString = 'S' then
    begin
      SuperFlex:=Max(0,FlexPM - ValNumT021['mmFlex',TF_PM_TIMBRATA,1]);
      Result:=Max(0,Min(FlexPM,ValNumT021['mmFlex',TF_PM_TIMBRATA,1]));
    end
    else
    begin
      SuperFlex:=Max(0,FlexPM - (ValNumT021['mmFlex',TF_PM_TIMBRATA,1] - ttimbraturenom[PN].Flex));
      Result:=Max(0,Min(FlexPM,ValNumT021['mmFlex',TF_PM_TIMBRATA,1] - ttimbraturenom[PN].Flex));
    end;
    if SuperFlex > 0 then
    begin
      z099_anom3(3,SuperFlex,'');
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z136_inibizprol;
var p136:Byte;
    tcausini:String;
begin
  //Inizializzazione perchè non gestito
  tcausini:='A';
  //Gestione inibizione prolungamento orario
  p136:=ttimbraturedip[ieu].tpuntnominold;
  if p136 = 0 then exit;
  if (tcausini = 'B') or (tcausini = 'D') then
    if ttimbraturedip[ieu].tminutid_e < ttimbraturenom[p136].tminutin_e then
      //Prolungamento orario inibito sull' entrata
      begin
      z098_anom2caus(15);
      ttimbraturedip[ieu].tminutid_e:=ttimbraturenom[p136].tminutin_e;
      end;
  if (tcausini = 'C') or (tcausini = 'D') then
    if ttimbraturedip[ieu].tminutid_u > ttimbraturenom[p136].tminutin_u then
      //Prolungamento orario inibito sull' uscita
      begin
      tcausale:=ttimbraturedip[ieu].tcausale_e;
      z098_anom2caus(15);
      ttimbraturedip[ieu].tminutid_u:=ttimbraturenom[p136].tminutin_u;
      end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z138_detrrieppr(Abbatti_tminlav:Boolean = True; OreEscluse:Boolean = False);
{Eventuali detrazioni straordinario su riepilogo presenze}
  function CausaleAbilitata(pCausale:t_triepgiuspres):Boolean;
  begin
    Result:=(not OreEscluse) and (pCausale.traggpres = traggrcauspr[1].C) and (ValStrT275[pCausale.tcauspres,'ORENORMALI'] <> 'A');
    if not Result then
      Result:=(OreEscluse) and (pCausale.traggpres = traggrcauspr[1].C) and (ValStrT275[pCausale.tcauspres,'ORENORMALI'] = 'A') and (ValStrT275[pCausale.tcauspres,'SPEZZ_STRAORD'] = 'S');
  end;
  procedure detrrieppr_V1048;
  var i,j,app:Integer;
  {La detrazione riguarda solo la prima causale trovata che abbia il raggruppamento di tipo A=Straordinario}
  begin
    i:=0;
    repeat
      inc(i);
    //until (i > n_rieppres) or ((triepgiuspres[i].traggpres = traggrcauspr[1].C) and (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A'));
    until (i > n_rieppres) or CausaleAbilitata(triepgiuspres[i]);
    if i > n_rieppres then exit;
    j:=1;
    while (j <= n_fasce) and (detrazstr <> 0) do
    begin
      app:=min(triepgiuspres[i].tminpres[j],detrazstr);
      dec(triepgiuspres[i].tminpres[j],app);
      dec(detrazstr,app);
      inc(j);
    end;
  end;
  procedure detrrieppr;
  type
    Tz138CoppieCaus = record
      IdxRiepPres:Integer;
      CoppiaEU:tCoppiaEU;
    end;
  var
    i,j,x,iRP,mm,mm_tminlav:Integer;
    ItemInserito:Boolean;
    minpresFasce:t_FasceInteri;
    itm_z138CoppieCaus:Tz138CoppieCaus;
    lst_z138CoppieCaus: TList<Tz138CoppieCaus>;
    lstCausali:TStringList;
  begin
    //Alberto 21/02/2019:
    //Nuova gestione: ciclo su tutte le causali con raggruppamento di tipo A=Straordinario, gestendo l'abbattimento di eccsolocomp se la causale è inclusa ma compensabile, e partendo dalle ultime ore

    //Detrazione degli spezzoni in ordine cronologico decrescente
    if cdsT020.FieldByName('DETRAZ_RIEPPR_NORM').AsString = 'HD' then
    begin
      //Ordinamento delle coppie di timbratura in ordine descrescente
      lst_z138CoppieCaus:=TList<Tz138CoppieCaus>.Create;
      try
        lst_z138CoppieCaus.Clear;
        for i:=1 to n_rieppres do
        begin
          //if (triepgiuspres[i].traggpres <> traggrcauspr[1].C) or (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A') then
          if not CausaleAbilitata(triepgiuspres[i]) then
            Continue;
          for j:=0 to High(triepgiuspres[i].CoppiaEU) do
          begin
            itm_z138CoppieCaus.IdxRiepPres:=i;
            itm_z138CoppieCaus.CoppiaEU:=triepgiuspres[i].CoppiaEU[j];
            ItemInserito:=False;
            for x:=0 to lst_z138CoppieCaus.Count - 1 do
              if itm_z138CoppieCaus.CoppiaEU.u > lst_z138CoppieCaus[x].CoppiaEU.u then
              begin
                ItemInserito:=True;
                lst_z138CoppieCaus.Insert(x,itm_z138CoppieCaus);
              end;
            if not ItemInserito then
              lst_z138CoppieCaus.Add(itm_z138CoppieCaus);
          end;
        end;

        //Abbattimento del riepilogo in base alle coppie di E-U causalizzate
        //Attenzione: l'abbattimento può essere diverso da quello fatto su tminlav!!
        for i:=0 to lst_z138CoppieCaus.Count - 1 do
        begin
          if detrazstr <= 0 then
            Break;
          iRP:=lst_z138CoppieCaus[i].IdxRiepPres;
          //Suddivido la coppia E-U nelle fasce
          for j:=1 to n_fasce do
            minpresFasce[j]:=0;
          for j:=1 to n_fasce do
            z714_suddivisioneFasce(1,lst_z138CoppieCaus[i].CoppiaEU.e,lst_z138CoppieCaus[i].CoppiaEU.u,j,minpresFasce);
          for j:=1 to n_fasce do
          begin
            if detrazstr <= 0 then
              Break;
            mm:=min(triepgiuspres[iRP].tminpres[j],minpresFasce[j]);
            mm:=max(0,mm);
            if mm = 0 then
              Continue;
            mm:=min(mm,detrazstr);
            dec(detrazstr,mm);
            dec(triepgiuspres[iRP].tminpres[j],mm);
            //Applico l'abbattimento anche sull'eccedenza solo compensabile, se la causale matura ore compensabili
            if ValStrT275[triepgiuspres[iRP].tcauspres,'ORENORMALI'] = 'C' then
              dec(eccsolocomp,min(mm,eccsolocomp));
            //Applico l'abbattimento anche su tminlav
            if Abbatti_tminlav then
            begin
              mm_tminlav:=min(tminlav[j],mm);
              mm_tminlav:=min(mm_tminlav,detrazioni);
              dec(tminlav[j],mm_tminlav);
              dec(detrazioni,mm_tminlav);
            end;
          end;
        end;
      finally
        FreeAndNil(lst_z138CoppieCaus);
      end;
    end;

    //Abbattimento residuo in ordine di causale
    lstCausali:=TStringList.Create;
    try
      //Lettura delle causali in ordine di abbattimento (T235.DETRAZ_RIEPPR_SEQ)
      //si mantiene la lista 'numero_ordine'='indice di triepgiuspres'
      lstCausali.Sorted:=True;
      for i:=1 to n_rieppres do
        //if (triepgiuspres[i].traggpres = traggrcauspr[1].C) and (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A') then
        if CausaleAbilitata(triepgiuspres[i]) then
          lstCausali.Add(Format('%.8d=%d',[StrToIntDef(ValStrT275[triepgiuspres[i].tcauspres,'DETRAZ_RIEPPR_SEQ'],99999999),i]));

      //Detrazione dalla fascia più bassa
      if cdsT020.FieldByName('DETRAZ_RIEPPR_NORM').AsString = 'FB' then
      begin
        for j:=1 to n_fasce do
        begin
          if detrazstr <= 0 then
            Break;
          for x:=0 to lstCausali.Count - 1 do
          begin
            if detrazstr <= 0 then
              Break;
            for i:=1 to n_rieppres do
            begin
              if i.ToString <> lstCausali.ValueFromIndex[x] then
                Continue;
              if detrazstr <= 0 then
                Break;
              mm:=max(0,triepgiuspres[i].tminpres[j]);
              if mm = 0 then
                Continue;
              mm:=min(mm,detrazstr);
              dec(detrazstr,mm);
              dec(triepgiuspres[i].tminpres[j],mm);
              //Applico l'abbattimento anche sull'eccedenza solo compensabile, se la causale matura ore compensabili
              if ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'C' then
                dec(eccsolocomp,min(mm,eccsolocomp));
              if Abbatti_tminlav then
              begin
                mm_tminlav:=min(tminlav[j],mm);
                mm_tminlav:=min(mm_tminlav,detrazioni);
                dec(tminlav[j],mm_tminlav);
                dec(detrazioni,mm_tminlav);
              end;
            end;
          end;
        end;
      end
      else
      begin
        for x:=0 to lstCausali.Count - 1 do
        begin
          if detrazstr <= 0 then
            Break;
          for i:=1 to n_rieppres do
          begin
            if i.ToString <> lstCausali.ValueFromIndex[x] then
              Continue;
            if detrazstr <= 0 then
              Break;
            //if (triepgiuspres[i].traggpres <> traggrcauspr[1].C) or (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A') then
            if not CausaleAbilitata(triepgiuspres[i]) then
              Continue;
            for j:=1 to n_fasce do
            begin
              if detrazstr <= 0 then
                Break;
              mm:=max(0,triepgiuspres[i].tminpres[j]);
              if mm = 0 then
                Continue;
              mm:=min(mm,detrazstr);
              dec(detrazstr,mm);
              dec(triepgiuspres[i].tminpres[j],mm);
              //Applico l'abbattimento anche sull'eccedenza solo compensabile, se la causale matura ore compensabili
              if ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'C' then
                dec(eccsolocomp,min(mm,eccsolocomp));
              if Abbatti_tminlav then
              begin
                mm_tminlav:=min(tminlav[j],mm);
                mm_tminlav:=min(mm_tminlav,detrazioni);
                dec(tminlav[j],mm_tminlav);
                dec(detrazioni,mm_tminlav);
              end;
            end;
          end;
        end;
      end;
    finally
      lstCausali.Free;
    end;
  end;
begin
  if detrazstr <= 0 then
    exit;

  if OreEscluse then
    Abbatti_tminlav:=False;

  if DetrazRiepprNorm = 'CS' then
  begin
    detrrieppr_V1048;
  end
  else
  begin
    detrrieppr;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z139_detrTimbNonAppoggiate(TimbCausalizzata:Boolean);
{Eventuali detrazioni straordinario su timbrature non appoggiate}
var i,j,k,app:Integer;
begin
  for i:=1 to n_timbrcon do
  begin
    //Considero solo timbrature non appoggiate
    if ttimbraturecon[i].tpuntatore > 0 then
      Continue;
    //Considero solo timbrature causalizzte o non causalizzate a seconda di TimbCausalizzata
    if (not TimbCausalizzata) and (ttimbraturecon[i].tcaus <> '') then
      Continue;
    if TimbCausalizzata and (ttimbraturecon[i].tcaus = '') then
      Continue;

    //Considero solo causali incluse nelle normali
    if ttimbraturecon[i].tinclcaus = 'A' then
      Continue;
    //Cerco riepilogo presenze
    k:=-1;
    for j:=1 to n_rieppres do
      if triepgiuspres[j].tcauspres = ttimbraturecon[i].tcaus then
      begin
        k:=j;
        Break;
      end;
    //Considero solo se esiste riepilogo presenze
    if k = -1 then
      Continue;
    //Considero solo se causale di tipo Straordinario
    if triepgiuspres[k].traggpres <> traggrcauspr[1].C then
      Continue;
    for j:=1 to n_fasce do
    begin
      //Calcolo intersezione tra timbrature e fascia
      z776_intersfasc(i,j);
      app:=min(mininterfasc,tminlav[j]);
      app:=min(detrazioni,app);
      if app > 0 then
      begin
        dec(tminlav[j],app);
        dec(detrazioni,app);
        app:=min(app,triepgiuspres[k].tminpres[j]);
        dec(triepgiuspres[k].tminpres[j],app);
        dec(detrazstr,app);
      end;
      if detrazioni = 0 then
        Break;
    end;
    if detrazioni = 0 then
      Break;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z140_detrazioni(var Vettore:t_FasceInteri);
begin
  i1:=1;
  while (i1 <= n_fasce) and (detrazioni <> 0) do
  begin
    if Vettore[i1] <> 0 then
      if Vettore[i1] > detrazioni then
      begin
        Vettore[i1]:=Vettore[i1] - detrazioni;
        detrazioni:=0;
      end
      else
      begin
        dec(detrazioni,Vettore[i1]);
        Vettore[i1]:=0;
      end;
    inc(i1);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z141_detrmensaF;
{Conteggio delle ore fino all'uscita per la mensa.
 Se le ore lavorate superano le minime per la Detrazione Automatica,
 viene applicata la detrazione mensa considerando quella già calcolata da timbrature}
var i,Diff:Integer;
begin
  Diff:=0;
  if (paumenges = 'si') and (PausaMensa = 'F') and
     (paumendet < PauMenMinUtilizzata) then
  begin
    for i:=1 to n_timbrdip do
    begin
      //Esco al primo rientro dalla mensa
      if (ttimbraturedip[i].tcausale_e.tcaustip = 'C') and (ttimbraturedip[i].tcausale_e.tcausrag = traggrgius.C) then
        Break;
      //Non considero le timbrature escluse dalle ore normali
      if (ttimbraturedip[i].tpuntnomin > 0) and
         (ttimbraturedip[i].tcausale_u.tcausioe <> 'A') then
        inc(Diff,ttimbraturedip[i].tminutid_u - ttimbraturedip[i].tminutid_e);
    end;
    Diff:=Diff - ValNumT021['OreMinime',TF_PM_AUTO,1]; //Q020HHMMDETRAZ
    Diff:=Min(Diff,PauMenMinUtilizzata);
    paumendet:=Max(paumendet,Diff);
    TipoDetPaumen:='PMA';
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z142_detrmensa;
{Eventuali detrazioni tipo pausa mensa A,C,D,E,F}
var i,x,paumendet_oreinc:Integer;
    OreRif,OreMinime,OreEsc,OreInc:Integer;
begin
  OreEsc:=0;
  OreInc:=0;
  OreMinime:=0;
  paumendet_oreinc:=0;

  totlav:=R180SommaArray(tminlav);
  for i:=1 to n_rieppres do
  begin
    //Escludo le ore incluse che non maturano pausa mensa
    if (ValStrT275[triepgiuspres[i].tcauspres,'MATURAMENSA'] = 'N') and
       (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A') then
      dec(totlav,R180SommaArray(triepgiuspres[i].tminpres))
    else
    //Includo le ore escluse che maturano pausa mensa
    if (ValStrT275[triepgiuspres[i].tcauspres,'MATURAMENSA'] = 'S') and
       (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A') and
       not XParam[XP_Z142_OREESCL_NO_PM] then
    begin
      inc(totlav,R180SommaArray(triepgiuspres[i].tminpres));
      inc(OreEsc,R180SommaArray(triepgiuspres[i].tminpres));
    end;
  end;
  //Alberto 09/05/2009: TORINO_COMUNE includo nelle ore anche i giustificativi di assenza che si vuole considerare nella pausa mensa (come avviene già per PMA_PRESERVA_TIMBINFASCIA = S)
  for i:=1 to n_giusore do
    if tgius_min[i].tassenza and
       (ValStrT265[tgius_min[i].tcausore,'TIMB_PM_H'] = 'S') and
       (R180CarattereDef(ValStrT265[tgius_min[i].tcausore,'INFLUCONT']) in ['A','C','G','H','I']) then
      inc(totlav,tgius_min[i].tmin);
  for i:=1 to n_giusdaa do
    if tgius_dallealle[i].tassenza and
       (ValStrT265[tgius_dallealle[i].tcausdaa,'TIMB_PM'] = 'S') and
       (R180CarattereDef(ValStrT265[tgius_dallealle[i].tcausdaa,'INFLUCONT']) in ['A','C','G','H','I']) then
      inc(totlav,tgius_dallealle[i].tminutia - tgius_dallealle[i].tminutida);

  //Alberto: FIRENZE_COMUNE - vengono considerate le ore rese da timbrature nella pausa mensa automatica
  if (cdsT020.FieldByName('PMA_PRESERVA_TIMBINFASCIA').AsString = 'S') then
    OreRif:=paumencont - paumencont_nonrese
  else
    OreRif:=totlav;
  OreInc:=OreRif - OreEsc;

  //Per il tipo pausa mensa E la detrazione automatica non puo'
  //rendere le ore rese minori dei minuti minimi per detrazione
  if (paumenges = 'si') and ((PausaMensa = 'E') or (PausaMensa = 'F')) and
     (paumendet = PauMenMinUtilizzata) and
     (*SACCO*)((cdsT020.FieldByName('TimbraturaMensa').AsString <> 'S') or
               (cdsT020.FieldByName('TimbraturaMensa_DetrTot').AsString <> 'S') or
               (not z149_EsisteTimbraturaMensa(cdsT020.FieldByName('TimbraturaMensa').AsString))) then
    //Per il tipo pausa mensa E la detrazione automatica non puo'
    //rendere le ore rese minori dei minuti minimi per detrazione
  begin
    OreMinime:=ValNumT021['OreMinime',TF_PM_AUTO,1];
    //Calcolo paumendet con detrazione parziale considerando anche le ore minime per stacco intermedio
    if (PauMenMinUtilizzata > 0) and
       (not cdsT020.FieldByName('PM_STACCO_INF').IsNull) and
       (not cdsT020.FieldByName('PM_STACCO_INF').IsNull) then
    begin
      if OreRif < OreMinime then
      begin
        OreMinime:=ValNumT020['PM_OREMINIME_INF'];
        paumendet:=min(paumendet,max(0,OreRif - OreMinime));  //Destrazione intermedia parziale
      end
      else if OreRif >= OreMinime then
      begin
        paumendet:=min(paumendet,max(0,OreRif - OreMinime));
        if (paumendet < ValNumT020['PM_STACCO_INF']) and (cdsT020.FindField('DETRAZ_PARZ_STACCO_INF') <> nil) and (cdsT020.FieldByName('DETRAZ_PARZ_STACCO_INF').AsString = 'S') then
        begin
          PauMenMinUtilizzata:=ValNumT020['PM_STACCO_INF'];
          paumendet:=PauMenMinUtilizzata;                    //Destrazione intermedia totale
        end;
      end;
    end
    else
      paumendet:=min(paumendet,max(0,OreRif - OreMinime));  //Destrazione PMA parziale
  end;

  if XParam[XP_DETRAZ_CAUSESC_PMA] then
  begin
    paumendet_oreinc:=min(paumendet,max(0,OreInc - OreMinime));
    paumendet_oreesc:=min(paumendet - paumendet_oreinc,OreEsc);
    inc(paumendet_oreinc,paumendet - (paumendet_oreinc + paumendet_oreesc));
    detrazioni:=paumendet_oreinc;
  end
  else
  begin
    paumendet_oreinc:=0;
    paumendet_oreesc:=0;
    detrazioni:=paumendet;
  end;

  z140_detrazioni(tminlav);
  if GetGiustifPM then
    paumendet_resto:=detrazioni
  else
  begin
    for i:=1 to n_rieppres do
      if (ValStrT275[triepgiuspres[i].tcauspres,'MATURAMENSA'] = 'S') and
         (ValStrT275[triepgiuspres[i].tcauspres,'TIMB_PM_DETRAZ'] = 'S') then
      begin
        paumendet_resto:=detrazioni;
        Break;
      end;
  end;
end;

//_________________________________________________________________
procedure TR502ProDtM1.z143_abbattirientro;
{La pausa mensa F prevede che il lavorato totale ecceda le Ore Minime per
 Detrazione Automatica di una quantità espressa da Rientro_Minimo.
 Se non c'è questa eccedenza, il lavorato giornaliero viene troncato alle
 Ore Minime per Detrazione Automatica.}
var i:Integer;
begin
  if (paumenges = 'no') or (PausaMensa <> 'F') then exit;
  totlav:=0;
  for i:=1 to n_fasce do
    inc(totlav,tminlav[i]);
  if totlav > ValNumT021['OreMinime',TF_PM_AUTO,1] then
    if (totlav - ValNumT021['OreMinime',TF_PM_AUTO,1]) < ValNumT020['Rientro_Minimo'] then
    begin
      detrazioni:=totlav - ValNumT021['OreMinime',TF_PM_AUTO,1];
      z140_detrazioni(tminlav);
      TipoDetPaumen:='PMA';
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z144_strgiornal;
{Gestione straordinario giornaliero ed eventuali detrazioni}
var i,reso_giusdaa:Integer;
begin
  //Per evitare di fare la detrazione 2 volte: sia strgiorn che DetPresenza vengono originati da spezzoni inclusi nelle ore normali
  if not XParam[XP_V99_Z144] then
    strgiorn:=max(0,strgiorn - DetPresenza);

  detrazioni:=strarrdet;
  reso_giusdaa:=0;
  if XParam[XP_CRV_STR_GIUSDAA] then
    for i:=1 to n_giusdaa do
      if (*(R180CarattereDef(ValStrT265[tgius_dallealle[i].tcausdaa,'INFLUCONT']) in ['A','G','C','H','I']) and*)
         (ValStrT265[tgius_dallealle[i].tcausdaa,'ESCLUSIONE'] = 'S') then
        inc(reso_giusdaa,z1006_OreEsterne(tgius_dallealle[i].tminutida,tgius_dallealle[i].tminutia));
  //if strgiorn < ValNumT020['MinGioStr'] then
  if strgiorn + strgiornEscl + reso_giusdaa < ValNumT020['MinGioStr'] then  //Il minimo lo si può raggiungere anche con le ore escluse dalle normali
  //Straordinario giornaliero minore del minimo
  begin
    z098_anom2caus(52,'[' + R180MinutiOre(strgiorn + strgiornEscl + reso_giusdaa) + ' < ' + R180MinutiOre(ValNumT020['MinGioStr']) + ']');
    inc(detrazioni,strgiorn);
  end
  else
    if strgiorn > ValNumT020['MaxGioStr'] then
    begin
      //Straordinario giornaliero maggiore del massimo
      detrazioni:=detrazioni + strgiorn - ValNumT020['MaxGioStr'];
      z098_anom2caus(23,Format('%s',[R180MinutiOre(detrazioni)]));
    end
    else
    begin
      //Straordinario giornaliero nei range previsti
      comodo2:=strgiorn;
      per892:=strgiorn;
      arr890:=ValNumT020['ArrotGior'];
      //Arrotondamento generale giornaliero straordinario
      z892_arrotondap;
      //Calcolo eventuali detrazioni causa arrotondamento
      detrazioni:=detrazioni + comodo2 - per892;
      strarrdet:=strarrdet + comodo2 - per892;  //Alberto 13/09/2004
    end;
  detrazstr:=detrazioni;
  DetrazStraord:=detrazioni;
  if ((cdsT020.FieldbyName('CompFascia').AsString = '3') or (cdsT020.FieldbyName('CompFascia').AsString = '4')) and
     (cdsT020.FieldByName('ARROT_COMP').AsString = 'S') then
    dec(detrazioni,strarrdet - strminimidet);
  if ((cdsT020.FieldbyName('CompFascia').AsString = '3') or (cdsT020.FieldbyName('CompFascia').AsString = '4')) and
     (cdsT020.FieldByName('MINIMISTR_COMP').AsString = 'S') then
    dec(detrazioni,strminimidet);
  //Alberto 21/02/2019: comportamento vecchio: prima si applicano le detrazioni su tminlav, e dopo le detrazioni sul riepilogo presenze
  if DetrazRiepprNorm = 'CS' then
  begin
    //Eventuali detrazioni straordinario su ore lavorate
    z140_detrazioni(tminlav);
  end;
  //Eventuali detrazioni straordinario su riepilogo presenze
  z138_detrrieppr;
  //Alberto 21/02/2019: comportamento nuovo: prima si applicano le detrazioni sul riepilogo presenze, che abbattono anche tminlav, e dopo le detrazioni su tminlav per quello che rimane ancora da detrarre
  if DetrazRiepprNorm <> 'CS' then
  begin
    //Eventuali detrazioni straordinario su ore lavorate
    z140_detrazioni(tminlav);
  end;
  StrGiorn:=max(0,StrGiorn - DetrazStraord);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z145_puntinommax;
begin
  if not XParam[XP_Z145] then
    exit;
  if gglav = 'no' then
    exit;
  if debitogg = 0 then
    exit;
  if TipoOrario <> 'A' then
    exit;

  OreReseTotali;
  if totlav - strgiorn > debitogg then
  begin
    detrazioni:=totlav - strgiorn - debitogg;
    z098_anom2caus(61,Format('%s minuti persi',[detrazioni.ToString]));
    z140_detrazioni(tminlav);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z146_tipomenCDE(SoloGiustificativiPM:Boolean = False);
{Calcolo detrazione tipo pausa mensa C, D, E, F (se necessario)}
begin
  if (*(paumenges = 'si') or*) (c_orario = '') or (PausaMensa = 'Z') or
     (PausaMensa = 'A') or (PausaMensa = 'B') then exit;
  //Verifica se le ore per la detrazione automatica devono essere continuative
  //(le coppie di timbrature con uscita e successiva entrata che cadono nello
  // stesso minuto sono considerate continuative)
  if ieu = 1 then
    paumencont:=0
  else if (ttimbraturedip[ieu].tminutid_e <> ttimbraturedip[ieu - 1].tminutid_u) and
          (cdsT020.FieldByName('DetrAutCont').AsString <> 'N') and
          (paumenges = 'no') then  //FIRENZE_COMUNE
    paumencont:=0
  else if (ieu > 2) and
          (ttimbraturedip[ieu].tminutid_e = ttimbraturedip[ieu - 1].tminutid_u) and
          (ttimbraturedip[ieu].tminutid_e = ttimbraturedip[ieu - 1].tminutid_e) and
          (ttimbraturedip[ieu].tminutid_e <> ttimbraturedip[ieu - 2].tminutid_u) and
          (cdsT020.FieldByName('DetrAutCont').AsString <> 'N') and
          (paumenges = 'no') then  //FIRENZE_COMUNE
    paumencont:=0;
  //Test se la coppia di timbrature interseca la
  //fascia oraria per detrazione automatica
  if (not SoloGiustificativiPM) and
     (ttimbraturedip[ieu].tminutid_u > ValNumT021['ENTRATAMM',TF_PM_AUTO,1]) and
     (ttimbraturedip[ieu].tminutid_e < ValNumT021['USCITAMM',TF_PM_AUTO,1]) then
  //Cumulo la coppia di timbrature per la mensa
  begin
    z148_timbmensa;
    exit;
  end
  else if (*(ieu = 1)*) primaVolta_z148 and GetGiustifPM then
  begin
    //Alberto 04/05/2010: Considero i giustificativi ai fini della PMA
    z148_timbmensa(True);
    exit;
  end;
  //Test se la coppia di timbrature precedenti e' adiacente a
  //quella in gestione ed interseca la
  //fascia oraria per detrazione automatica
  if ieu <> 1 then
    if ttimbraturedip[ieu].tminutid_e = ttimbraturedip[ieu - 1].tminutid_u then
      if not((ttimbraturedip[ieu - 1].tminutid_u <= ValNumT021['ENTRATAMM',TF_PM_AUTO,1]) or
             (ttimbraturedip[ieu - 1].tminutid_e >= ValNumT021['USCITAMM',TF_PM_AUTO,1])) then
        if (ttimbraturedip[ieu - 1].tcausale_u.tcaus = '') or (ttimbraturedip[ieu - 1].tcausale_u.tcausMatMensa = 'S') then
        begin
          //Cumulo la coppia di timbrature per la mensa
          z148_timbmensa;
          exit;
        end;
  //Test se la coppia di timbrature successive e' adiacente a
  //quella in gestione ed interseca la
  //fascia oraria per detrazione automatica
  if ieu <> n_timbrdip then
    if ttimbraturedip[ieu].tminutid_u = ttimbraturedip[ieu + 1].tminutid_e then
      if not((ttimbraturedip[ieu + 1].tminutid_u <= ValNumT021['ENTRATAMM',TF_PM_AUTO,1]) or
             (ttimbraturedip[ieu + 1].tminutid_e >= ValNumT021['USCITAMM',TF_PM_AUTO,1])) then
        if (ttimbraturedip[ieu + 1].tcausale_e.tcaus = '') or (ttimbraturedip[ieu + 1].tcausale_e.tcausMatMensa = 'S') then
          //Cumulo la coppia di timbrature per la mensa
          z148_timbmensa;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z148_timbmensa(SoloGiustificativiPM:Boolean = False);
{Cumulo la coppia di timbrature per la mensa}
var MatMensa1,MatMensa2:Boolean;
    i,j,k,mm,inters,giust_dalle,giust_alle:Integer;
begin
  primaVolta_z148:=False;
  //FIRENZE_COMUNE considero anche i giustificativi fruiti ad ore
  if ((ieu = 1) or (paumencont = 0)) and (cdsT020.FieldByName('DetrAutCont').AsString = 'N') then
  begin
    //Giustificativi dalle-alle nella fascia di detrazione automatica
    for i:=1 to n_giusdaa do
    begin
      //Limitazione del giustificativo dalle..alle entro la fascia oraria di conteggio
      if XParam[XP_V1044_Z148] then
      begin
        //retro-compatibilità con versione originale
        giust_dalle:=tgius_dallealle[i].tminutida;
        giust_alle:=tgius_dallealle[i].tminutia;
      end
      else
      begin
        giust_dalle:=max(tgius_dallealle[i].tminutida,minutidalle);
        giust_alle:=min(tgius_dallealle[i].tminutia,minutialle);
        if giust_dalle > giust_alle then
          giust_dalle:=giust_alle;
      end;

      if tgius_dallealle[i].tassenza then
      begin
        if ValStrT265[tgius_dallealle[i].tcausdaa,'TIMB_PM'] = 'N' then
          Continue;
      end
      else if ValStrT275[tgius_dallealle[i].tcausdaa,'TIMB_PM'] = 'N' then
        Continue;
      if (giust_dalle < ValNumT021['USCITAMM',TF_PM_AUTO,1]) and
         (giust_alle > ValNumT021['ENTRATAMM',TF_PM_AUTO,1]) then
      begin
        inc(paumencont,giust_alle - giust_dalle);
        if (R180CarattereDef(ValStrT265[tgius_dallealle[i].tcausdaa,'INFLUCONT']) in ['B','D']) then
          inc(paumencont_nonrese,giust_alle - giust_dalle);
      end;
      if (paumenges = 'no') and
         (cdsT020.FieldByName('PM_AUTO_URIT').AsString = 'S') and
         (giust_dalle <= ValNumT021['USCITAMM',TF_PM_AUTO,1]) and
         (giust_alle > ValNumT021['USCITAMM',TF_PM_AUTO,1]) then
      begin
        paumenges:='si';
        TipoDetPaumen:='PMA';
        if not cdsT020.FieldByName('PausaMensa_Automatica').IsNull then
          PauMenMinUtilizzata:=ValNumT020['PausaMensa_Automatica']
        else
          PauMenMinUtilizzata:=ValNumT020['mmMinimi'];
        if PausaMensa = 'E' then
          PauMenMinUtilizzata:=min(PauMenMinUtilizzata,giust_alle - ValNumT021['USCITAMM',TF_PM_AUTO,1]);
        paumendet:=PauMenMinUtilizzata;
      end;
      //end;
    end;
    for i:=1 to n_giusore do
    begin
      if tgius_min[i].tassenza then
      begin
        if ValStrT265[tgius_min[i].tcausore,'TIMB_PM_H'] = 'N' then
          Continue;
      end
      else if ValStrT275[tgius_min[i].tcausore,'TIMB_PM_H'] = 'N' then
        Continue;
      inc(paumencont,tgius_min[i].tmin);
      if (R180CarattereDef(ValStrT265[tgius_min[i].tcausore,'INFLUCONT']) in ['B','D']) then
        inc(paumencont_nonrese,tgius_min[i].tmin);
    end;
  end;
  MatMensa1:=True;
  MatMensa2:=True;
  if SoloGiustificativiPM then
    comodo2:=0
  else
  begin
    comodo2:=ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e;
    if (ttimbraturedip[ieu].tcausale_e.tcaus <> '') and (ttimbraturedip[ieu].tcausale_e.tcaustip = 'B') then
      MatMensa1:=ttimbraturedip[ieu].tcausale_e.tcausMatMensa = 'S';
    if (ttimbraturedip[ieu].tcausale_u.tcaus <> '') and (ttimbraturedip[ieu].tcausale_u.tcaustip = 'B') then
      MatMensa2:=ttimbraturedip[ieu].tcausale_u.tcausMatMensa = 'S';
    //Abbatto la timbratura effettiva delle eventuali ore che non maturano mensa, scaturite da causali di presenza su U/E
    ////Alberto 16/07/2014: annullo la condizione: il blocco seguente viene sempre eseguito anche per timbrature causalizzate
    ////if (ttimbraturedip[ieu].tcausale_e.tcaus = '') and (ttimbraturedip[ieu].tcausale_u.tcaus = '') then
    begin
      mm:=0;
      for i:=1 to n_rieppres do//High(triepgiuspres) do
      begin
        if (ValStrT275[triepgiuspres[i].tcauspres,'MATURAMENSA'] = 'N') and
           (R180CarattereDef(ValStrT275[triepgiuspres[i].tcauspres,'TIPOCONTEGGIO']) in ['A','E']) then
          for j:=0 to High(triepgiuspres[i].CoppiaEU) do
          begin
            inters:=Max(0,Min(triepgiuspres[i].CoppiaEU[j].u,ttimbraturedip[ieu].tminutid_u) -
                          Max(triepgiuspres[i].CoppiaEU[j].e,ttimbraturedip[ieu].tminutid_e));
            inc(mm,inters);
          end;
        if (ValStrT275[triepgiuspres[i].tcauspres,'MATURAMENSA'] = 'S') and
           (R180CarattereDef(ValStrT275[triepgiuspres[i].tcauspres,'TIPOCONTEGGIO']) in ['A','E']) and
           (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A') then
          //Per ogni coppia E/U cerco in tgius_dallealle se un giustificativo TIMB_PM = 'S' rientra nella coppia EU:
          //Se sì, allora sto contando 2 volte l'intervallo --> annullo tutto il periodo (l'autogiustificativo può essere inferiore all'intervallo)
          for j:=0 to High(triepgiuspres[i].CoppiaEU) do
            for k:=1 to n_giusdaa do
              if tgius_dallealle[k].tassenza and (ValStrT265[tgius_dallealle[k].tcausdaa,'TIMB_PM'] = 'S') or
                 (not tgius_dallealle[k].tassenza) and (ValStrT275[tgius_dallealle[k].tcausdaa,'TIMB_PM'] = 'S') then
                //Se c'è un giustif. dalle-alle compreso in CoppiaEU...
                if R180Between(tgius_dallealle[k].tminutida,triepgiuspres[i].CoppiaEU[j].e,triepgiuspres[i].CoppiaEU[j].u) and
                   R180Between(tgius_dallealle[k].tminutia,triepgiuspres[i].CoppiaEU[j].e,triepgiuspres[i].CoppiaEU[j].u) then
                begin
                  //Se causale esclusa dalle ore normali --> annullo tutta la CoppiaEU
                  inters:=Max(0,Min(triepgiuspres[i].CoppiaEU[j].u,ttimbraturedip[ieu].tminutid_u) -
                                Max(triepgiuspres[i].CoppiaEU[j].e,ttimbraturedip[ieu].tminutid_e));
                  inc(mm,inters);
                end
      end;
      dec(comodo2,mm);
    end;
  end;
  if MatMensa1 and MatMensa2 then (*Fine modifica*)
    inc(paumencont,comodo2);
  if paumenges = 'si' then //FIRENZE_COMUNE
    exit;
  //Verifica se occorre detrazione
  if ((((paumencont >= ValNumT021['OreMinime',TF_PM_AUTO,1]) or ((paumencont >= IfThen(cdsT020.FieldByName('PM_OREMINIME_INF').IsNull,1440,ValNumT020['PM_OREMINIME_INF'])) and (ieu = n_timbrdip))) and
        (cdsT020.FieldByName('PM_AUTO_URIT').AsString <> 'S'))
     or
     (z149_EsisteTimbraturaMensa(cdsT020.FieldByName('TimbraturaMensa').AsString))) then
  //Settaggio flag per pausa mensa gestita
  begin
    paumenges:='si';
    TipoDetPaumen:='PMA';
    PauMenMinUtilizzata:=-1;
    //Alberto 15/05/2008: La Spezia - Detrazione alternativa se c'è timbratura di mensa
    if z149_EsisteTimbraturaMensa(cdsT020.FieldByName('TimbraturaMensa').AsString) then
    begin
      if not cdsT020.FieldByName('TIMBRATURAMENSA_DETRAZIONE').IsNull then
        PauMenMinUtilizzata:=ValNumT020['TIMBRATURAMENSA_DETRAZIONE']
      else if not cdsT020.FieldByName('PausaMensa_Automatica').IsNull then
        PauMenMinUtilizzata:=ValNumT020['PausaMensa_Automatica'];
      TipoDetPaumen:='PMATM';  
    end
    else
    begin
      //Alberto 02/10/2008 (Biella_ASL12): stacco intermedio se ore rese tra 6.00 e 6.30
      if (paumencont >= ValNumT021['OreMinime',TF_PM_AUTO,1]) and
         (not cdsT020.FieldByName('PausaMensa_Automatica').IsNull) then
        PauMenMinUtilizzata:=ValNumT020['PausaMensa_Automatica'];
      if paumencont < ValNumT021['OreMinime',TF_PM_AUTO,1] then
        PauMenMinUtilizzata:=ValNumT020['PM_STACCO_INF'];
    end;
    if PauMenMinUtilizzata = -1 then
      PauMenMinUtilizzata:=ValNumT020['mmMinimi'];
    paumendet:=PauMenMinUtilizzata;
  end
  //Alberto 24/01/2002: (Pescara) detrazione se uscita dopo ora max - la detrazione è data dalla differenza tra l'uscita e OraMax
  else if (not SoloGiustificativiPM) and
          (cdsT020.FieldByName('PM_AUTO_URIT').AsString = 'S') and
          (ttimbraturedip[ieu].tminutid_u > ValNumT021['USCITAMM',TF_PM_AUTO,1]) and
          (ttimbraturedip[ieu].tminutid_e <= ValNumT021['USCITAMM',TF_PM_AUTO,1]) and
          ((ttimbraturedip[ieu].tcausale_e.tcaus = '') or (ttimbraturedip[ieu].tcausale_e.tcausMatMensa = 'S')) then
  begin
    paumenges:='si';
    TipoDetPaumen:='PMA';
    if not cdsT020.FieldByName('PausaMensa_Automatica').IsNull then
      PauMenMinUtilizzata:=ValNumT020['PausaMensa_Automatica']
    else
      PauMenMinUtilizzata:=ValNumT020['mmMinimi'];
    if PausaMensa = 'E' then
      PauMenMinUtilizzata:=min(PauMenMinUtilizzata,ttimbraturedip[ieu].tminutid_u - ValNumT021['USCITAMM',TF_PM_AUTO,1]);
    paumendet:=PauMenMinUtilizzata;
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.z149_EsisteTimbraturaMensa(Attivazione:String):Boolean;
{SACCO: True se esiste una timbratura di mensa nella fascia di pausa mensa dell'orario}
var mm:Integer;
    i,imin,imax:Integer;
begin
  mm:=0;
  Result:=False;
  //if cdsT020.FieldByName('TimbraturaMensa').AsString <> 'S' then
  if Attivazione <> 'S' then
    exit;
  with Q370 do
  begin
    if SearchRecord('Data',datacon,[srFromBeginning]) then
      while (not Eof) and (FieldByName('Data').AsDateTime = datacon) do
      begin
        mm:=R180OreMinuti(FieldByName('Ora').AsDateTime);
        if (mm >=ValNumT021['ENTRATAMM',TF_PM_TIMBRATA,1]) and
           (mm <= ValNumT021['USCITAMM',TF_PM_TIMBRATA,1]) then
        begin
          Result:=True;
          Break;
        end;
        Next;
      end;
  end;
  if Result and ((cdsT020.FieldByName('TimbraturaMensa_Interna').AsString = 'S') or (cdsT020.FieldByName('TimbraturaMensa_Interna').AsString = 'I')) then
  begin
    //Alberto 24/08/2006: (Varese) La timbratura di mensa deve essere all'interno delle timbrature di presenza
    imin:=999;
    imax:=-1;
    for i:=0 to High(TimbratureDelGiorno) do
      if (TimbratureDelGiorno[i].tcaustimb = '') or (ValStrT275[TimbratureDelGiorno[i].tcaustimb,'MATURAMENSA'] = 'S') then
      begin
        if i > imax then
          imax:=i;
        if i < imin then
          imin:=i;
      end;
    //i:=High(TimbratureDelGiorno);
    if imax = -1 then
      Result:=False
    else
      Result:=(mm > TimbratureDelGiorno[imin].toratimb) and (mm < TimbratureDelGiorno[imax].toratimb);
  end;
  if Result and (cdsT020.FieldByName('TimbraturaMensa_Interna').AsString = 'I') then
  begin
    //Alberto 30/07/2008: (La Spezia) La timbratura di mensa deve essere compresa tra E-U
    //(ovvero la detrazione maggiorata deve scattare tra E/U, mentre tra U/E si applica la detrazione normale)
    Result:=False;
    if Length(TimbratureDelGiorno) > 0 then
    begin
      if (mm < TimbratureDelGiorno[0].toratimb) and (primat_u = 'si') and (estimbprec = 'si') and (verso_pre = 'E') then
        Result:=True
      else if (mm > TimbratureDelGiorno[High(TimbratureDelGiorno)].toratimb) and (ultimt_e = 'si') and (estimbsucc = 'si') and (verso_suc = 'U') then
        Result:=True
      else
        for i:=1 to High(TimbratureDelGiorno) do
          if (mm < TimbratureDelGiorno[i].toratimb) and (TimbratureDelGiorno[i].tversotimb = 'U') and
             (mm > TimbratureDelGiorno[i - 1].toratimb) and (TimbratureDelGiorno[i - 1].tversotimb = 'E') then
          begin
            Result:=True;
            Break;
          end;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z150_contrat;
{Lettura contratto del dipendente con sue fasce orarie}
begin
  //Se cambia il progressivo o  la data rileggo il contratto
  if (progrcon <> progrcon20_sv) or (datacon_aa <> anno20_sv) or
     (datacon_mm <> mese20_sv) or (datacon_gg < gior20_sv) then
  begin
    progrcon20_sv:=0;
    anno20_sv:=0;
    mese20_sv:=0;
    gior20_sv:=0;
    n_fasce:=0;
    //Ricerca codice contratto di inizio mese in storico
    z152_constorico;
    if blocca <> 0 then exit;
    //Lettura contratto con data decorrenza
    //non successiva all'inizio del mese attuale
    z154_contdatadec;
    if blocca <> 0 then exit;
  end;
  //Leggo sempre le fasce anche se sono sullo stesso contratto
  //Lettura fasce indennita' notturne da contratto
  z186_fascein;
  //Lettura fasce orarie del contratto
  z156_fasce;
  if blocca = 0 then
  begin
    progrcon20_sv:=progrcon;
    anno20_sv:=datacon_aa;
    mese20_sv:=datacon_mm;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z152_constorico;
{Ricerca codice contratto di inizio mese in storico}
begin
  if Q430.FieldByName('Contratto').AsString <> '' then
    c_contratto:=Q430.FieldByName('Contratto').AsString
  else
    blocca:=10;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z154_contdatadec;
{Lettura contratto con data decorrenza
 non successiva all' inizio del mese attuale}
begin
  z950_leggicontr;
  if s_trovato = 'no' then
    blocca:=11
  else
    begin
    //datadeccon:=f20_data;
    strcontrat:=T200[Q200.FieldByName('MaxStraord').Index];
    lavsupset:=0;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z156_fasce;
{Lettura fasce orarie del contratto
 Azzeramento numero fasce FER/FES/SAB}
var xx:Integer;
begin
  n_fasce:=0;
  for xx:=Low(tnumfasce) to High(tnumfasce) do tnumfasce[xx]:=0;
  //Lettura fasce orarie sul giorno interessato
  z951_leggifasce;
  z158_fascecaric;
  if n_fasce = 0 then
    blocca:=12
  else if n_fasce > MaxFasceGio then
    blocca:=20
  else
    //Ordinamento fasce orarie
    z162_ordinfasce;
  //Controllo che le fasce coprano l' intera giornata
  i4:=1;
  repeat
    z166_contrfasc;
    inc(i4);
  until (i4 > 3) or (blocca <> 0);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z158_fascecaric;
{Lettura fasce orarie}
var i:Byte;
    T201GGOri:TFasceGiorno;
begin
  for i:=1 to 4 do
  begin
    if Trim(T201GG[Q201MAGGIOR1.Index + i - 1]) = '' then Continue;
    if (T201GG[Q201Giorno.Index] = '7') or (T201GG[Q201Giorno.Index] = '9') then
      i1:=2  //Domenica o Festivo
    else if gglav = 'si' then
      i1:=1  //Lavorativo
    else
      i1:=3; //Non Lavorativo
    inc(tnumfasce[i1]);
    inc(n_fasce);
    with tfasceorarie[n_fasce] do
    begin
      tcodfasc:=T201GG[Q201Maggior1.Index + i - 1];
      //Estraggo la percent. di maggiorazione da Q210
      tpercfasc:=StrToIntDef(VarToStr(Q210.Lookup('Codice',tcodfasc,'Maggiorazione')),0);
      tiniz1fasc:=StrToIntDef(T201GG[Q201FASCIADA1.Index + i - 1],0);
      tfine1fasc:=StrToIntDef(T201GG[Q201FASCIAA1.Index + i - 1],0);
      if tfine1fasc = 1439 then
        tfine1fasc:=1440;
      tiniz2fasc:=0;
      tfine2fasc:=0;
      if tiniz1fasc > tfine1fasc then
      begin
        tfine2fasc:=tfine1fasc;
        tfine1fasc:=1440;
      end;
      ttipofasc:=i1;
      AbbFascia:=0;
    end;
    tfasceorarie_indturno[n_fasce]:=tfasceorarie[n_fasce];
    //Ind.turno CCNL 2018: la fascia notturna festiva comincia alle 22 del gg prima e finisce alle 6 del gg dopo
    if (cdsT020.FindField('FASCIA_NOTTFEST_COMPLETA') <> nil) and (cdsT020.FieldByName('FASCIA_NOTTFEST_COMPLETA').AsString = 'S') then
      with tfasceorarie_indturno[n_fasce] do
      begin
        //gg. lav o non lav.
        if (i1 in [1,3]) then
        begin
          if ((TipoGG_prec = 'F') and (i = 1)) or //gg prec festivo e sono sulla prima fascia (00.00-06.00)
             ((TipoGG_suc = 'F') and (i = 3))     //gg succ festivo e sono sulla terza fascia (22.00-24.00)
          then
          begin
            tcodfasc:=T201[9][Q201Maggior1.Index + i - 1];
            tpercfasc:=StrToIntDef(VarToStr(Q210.Lookup('Codice',tcodfasc,'Maggiorazione')),0);
            tiniz1fasc:=StrToIntDef(T201[9][Q201FASCIADA1.Index + i - 1],0);
            tfine1fasc:=StrToIntDef(T201[9][Q201FASCIAA1.Index + i - 1],0);
            if tfine1fasc = 1439 then
              tfine1fasc:=1440;
          end
          else
          if ((DayOfWeek(datacon - 1 - 1) = 7) and (i = 1)) or //gg prec Domenica e sono sulla prima fascia (00.00-06.00)
             ((DayOfWeek(datacon - 1 + 1) = 7) and (i = 3))    //gg succ Domenica e sono sulla terza fascia (22.00-24.00)
          then
          begin
            tcodfasc:=T201[7][Q201Maggior1.Index + i - 1];
            tpercfasc:=StrToIntDef(VarToStr(Q210.Lookup('Codice',tcodfasc,'Maggiorazione')),0);
            tiniz1fasc:=StrToIntDef(T201[7][Q201FASCIADA1.Index + i - 1],0);
            tfine1fasc:=StrToIntDef(T201[7][Q201FASCIAA1.Index + i - 1],0);
            if tfine1fasc = 1439 then
              tfine1fasc:=1440;
          end
        end;
      end;
  end;

  //4.0
  if NotteSuEntrata then
  begin
    T201GGOri:=T201GG;
    z952_leggifascesuccessive;
    for i:=1 to 4 do
    begin
      if Trim(T201GG[Q201Maggior1.Index + i - 1]) = '' then Continue;
      if (T201GG[Q201Giorno.Index] = '7') or (T201GG[Q201Giorno.Index] = '9') then
        i1:=2  //Domenica o Festivo
      else if Tipogglav_suc = 'S' then
        i1:=1  //Lavorativo
      else
        i1:=3; //Non Lavorativo
      inc(tnumfasce[i1]);
      inc(n_fasce);
      with tfasceorarie[n_fasce] do
      begin
        tcodfasc:=T201GG[Q201Maggior1.Index + i - 1];
        //Estraggo la percent. di maggiorazione da Q210
        tpercfasc:=StrToIntDef(VarToStr(Q210.Lookup('Codice',tcodfasc,'Maggiorazione')),0);
        tiniz1fasc:=StrToIntDef(T201GG[Q201FASCIADA1.Index + i - 1],0);
        tfine1fasc:=StrToIntDef(T201GG[Q201FASCIAA1.Index + i - 1],0);
        if tfine1fasc = 1439 then
          tfine1fasc:=1440;
        tiniz2fasc:=0;
        tfine2fasc:=0;
        if tiniz1fasc > tfine1fasc then
        begin
          tfine2fasc:=tfine1fasc;
          tfine1fasc:=1440;
        end;
        ttipofasc:=i1;
        AbbFascia:=0;
        tiniz1fasc:=1440 + tiniz1fasc;
        tfine1fasc:=1440 + tfine1fasc;
        if (tiniz2fasc <> 0) or (tfine2fasc <> 0) then
        begin
          tiniz2fasc:=1440 + tiniz2fasc;
          tfine2fasc:=1440 + tfine2fasc;
        end;
      end;
      tfasceorarie_indturno[n_fasce]:=tfasceorarie[n_fasce];
      if (cdsT020.FindField('FASCIA_NOTTFEST_COMPLETA') <> nil) and (cdsT020.FieldByName('FASCIA_NOTTFEST_COMPLETA').AsString = 'S') then
        with tfasceorarie_indturno[n_fasce] do
        begin
          //gg. lav o non lav.
          if (i1 in [1,3]) then
          begin
            if ((TipoGG = 'F') and (i = 1)) or    //gg prec festivo e sono sulla prima fascia (00.00-06.00)
               ((TipoGG_suc2 = 'F') and (i = 3))  //gg succ festivo e sono sulla terza fascia (22.00-24.00)
            then
            begin
              tcodfasc:=T201[9][Q201Maggior1.Index + i - 1];
              tpercfasc:=StrToIntDef(VarToStr(Q210.Lookup('Codice',tcodfasc,'Maggiorazione')),0);
              tiniz1fasc:=StrToIntDef(T201[9][Q201FASCIADA1.Index + i - 1],0);
              tfine1fasc:=StrToIntDef(T201[9][Q201FASCIAA1.Index + i - 1],0);
              if tfine1fasc = 1439 then
                tfine1fasc:=1440;
            end
            else
            if ((DayOfWeek(datacon - 1 ) = 7) and (i = 1)) or  //gg prec Domenica e sono sulla prima fascia (00.00-06.00)
               ((DayOfWeek(datacon - 1 + 2) = 7) and (i = 3))  //gg succ Domenica e sono sulla terza fascia (22.00-24.00)
            then
            begin
              tcodfasc:=T201[7][Q201Maggior1.Index + i - 1];
              tpercfasc:=StrToIntDef(VarToStr(Q210.Lookup('Codice',tcodfasc,'Maggiorazione')),0);
              tiniz1fasc:=StrToIntDef(T201[7][Q201FASCIADA1.Index + i - 1],0);
              tfine1fasc:=StrToIntDef(T201[7][Q201FASCIAA1.Index + i - 1],0);
              if tfine1fasc = 1439 then
                tfine1fasc:=1440;
            end
          end;
          tiniz1fasc:=1440 + tiniz1fasc;
          tfine1fasc:=1440 + tfine1fasc;
          if (tiniz2fasc <> 0) or (tfine2fasc <> 0) then
          begin
            tiniz2fasc:=1440 + tiniz2fasc;
            tfine2fasc:=1440 + tfine2fasc;
          end;
        end;
    end;
    T201GG:=T201GGOri;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z162_ordinfasce;
{Ordinamento fasce orarie}
var comodo4:t_tfasceorarie;
    i,nf:Integer;
begin
  for i:=1 to n_fasce do
  begin
    for nf:=i + 1 to n_fasce do
      if not((tfasceorarie[nf].tpercfasc > tfasceorarie[i].tpercfasc)  or
             ((tfasceorarie[nf].tpercfasc = tfasceorarie[i].tpercfasc) and
              (tfasceorarie[nf].tcodfasc > tfasceorarie[i].tcodfasc))  or
             ((tfasceorarie[nf].tpercfasc = tfasceorarie[i].tpercfasc) and
              (tfasceorarie[nf].tcodfasc = tfasceorarie[i].tcodfasc)   and
              (tfasceorarie[nf].tiniz1fasc > tfasceorarie[i].tiniz1fasc))) then
      begin
        comodo4:=tfasceorarie[i];
        tfasceorarie[i]:=tfasceorarie[nf];
        tfasceorarie[nf]:=comodo4;
        //Alberto 21/09/2018 - CCNL 2018: Applico ordinamento anche alle fasce per ind.turno
        comodo4:=tfasceorarie_indturno[i];
        tfasceorarie_indturno[i]:=tfasceorarie_indturno[nf];
        tfasceorarie_indturno[nf]:=comodo4;
      end;
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.z164_ultimafascia(limiteSup:integer):Byte;
{ritorna indice dell'ultima fascia oraria inferiore a limiteSup}
var i:Integer;
    FineMax:Integer;
begin
  Result:=1;
  FineMax:=0;
  for i:=1 to n_fasce do
    if (max(tfasceorarie[i].tfine1fasc,tfasceorarie[i].tfine2fasc) < limiteSup) and
       (max(tfasceorarie[i].tfine1fasc,tfasceorarie[i].tfine2fasc) > FineMax)
    then
    begin
      Result:=i;
      FineMax:=max(tfasceorarie[i].tfine1fasc,tfasceorarie[i].tfine2fasc);
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z166_contrfasc;
{Controllo che le fasce coprano l'intera giornata}
var i:Integer;
begin
  if tnumfasce[i4] <> 0 then
    begin
    comodo2:=0;
    for i:=1 to n_fasce do
      with tfasceorarie[i] do
        if (ttipofasc = i4) then
          comodo2:=comodo2 + tfine1fasc - tiniz1fasc + tfine2fasc - tiniz2fasc;
    if comodo2 < 1440 then
      if i4 = 1 then
        blocca:=13
      else if i4 = 2 then
        blocca:=14
      else
        blocca:=15;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z170_tipofasc;
{Scelta tipo di fasce orario ( FER/FES/SAB ) in base al gg
 e calcolo puntatore alla fascia piu' bassa}
begin
  //Festivo
  if (tipogg = 'F') and (tnumfasce[2] <> 0) then
    tipofasc:=2
  //Domenica
  else if (giorsett = 7) and (tnumfasce[2] <> 0) then
    tipofasc:=2
  //Non lavorativo
  else if (gglav = 'no') and (tnumfasce[3] <> 0) then
    tipofasc:=3
  //Lavorativo
  else
    tipofasc:=1;
  fasciabass:=0;
  //Calcolo puntatore alla fascia piu' bassa
  repeat
    inc(fasciabass);
  until tfasceorarie[fasciabass].ttipofasc = tipofasc;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z172_monteore;
{Lettura monte ore settimanale del dipendente}
begin
  monteorelet:='si';
  //Ricerca codice monte ore in storico
  //Lettura monte ore
  z176_monteorelet;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z176_monteorelet;
{Lettura monte ore}
begin
  z978_leggimonte;
  if s_trovato = 'no' then
    blocca:=17;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z180_gglavnor;
{Verifica se giorno lavorativo o meno da calendario}
begin
  if (tipogglav = 'S') and (tipogg <> 'F') then
    gglav:='si'
  else
    gglav:='no';
  gglavcal:=gglav;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z181_gglavtur;
{Verifica se giorno lavorativo o meno per personale turnista}
begin
  gglav:='si';
  i1:=1;
  while (i1 <= n_giusgga) and (gglav = 'si') do
  begin
    z964_leggicaus(tgius_ggass[i1].tcausggass);
    if (s_trovato = 'si') and (parcaus.l29_1paramet = 'A') and
       (parcaus.l29_Ragg = traggrcausas[8].C) then
      //Giornata di riposo causalizzata
      gglav:='no';
    //Se chiamante = Assenze, viene riconosciuto un solo giustificativo per volta:
    //Se il giustificativo non è di riposo, si verifica che sulla tabella non ce ne sia nessun'altro di riposo
    if (Chiamante = 'Assenze') and (s_trovato = 'si') and
       (parcaus.l29_1paramet = 'A') and (parcaus.l29_Ragg <> traggrcausas[8].C) then
      if Q040.SearchRecord('Data;TipoGiust',VarArrayOf([datacon,'I']),[srFromBeginning]) then
      repeat
        z964_leggicaus(Q040.FieldByName('CAUSALE').AsString);
        if (s_trovato = 'si') and (parcaus.l29_1paramet = 'A') and
           (parcaus.l29_Ragg = traggrcausas[8].C) then
          gglav:='no';
      until (gglav = 'no') or (not Q040.SearchRecord('Data;TipoGiust',VarArrayOf([datacon,'I']),[]));
    inc(i1);
  end;
  while (i1 <= n_giusgga) and (gglav = 'si') do
  begin
    z964_leggicaus(tgius_ggass[i1].tcausggass);
    if (s_trovato = 'si') and (parcaus.l29_1paramet = 'A') and
       (parcaus.l29_Ragg = traggrcausas[8].C) then
      //Giornata di riposo causalizzata
      gglav:='no';
    inc(i1);
  end;
  if gglav = 'no' then exit;
  //Scelta orario
  while orarioacq <> 'si' do
    z500_orarfac;
  if blocca <> 0 then exit;
  if (pianif = 'si') and (TipoOrario = 'E') and ((c_turni1 = 0) or (c_turni2 = 0)) then
    //Giornata di riposo pianificata ponendo turno = 0
  begin
    gglav:='no';
    exit;
  end;
  if (n_timbrdip = 0) and (n_giusdaa = 0) and (n_giusore = 0) and
     (n_giusmga = 0) and (n_giusgga = 0) then
    if (pianif = 'no') and (ValStrT025['GGVUOTO_TURNISTA','R'] = 'R') then
      //Giornata di riposo poiche' priva di timbrature, di causali
      //di presenza/assenza e senza orario pianificato
    begin
      gglav:='no';
      exit;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z182_debitoor;
{Calcolo debito orario senza gestione non lavorativo}
begin
  debitocalc:='si';
  debitoindfes:=0;
  try
    debitorp:=minmonteore div giornlav;
    comodo1:=minmonteore mod giornlav;
  except
    debitorp:=0;
    comodo1:=0;
  end;
  debitocl:=debitorp;

  if c_orario = '' then
    debitodaorario:=0
  else if (TipoOrario = 'A') or (TipoOrario = 'B') or (TipoOrario = 'C') or (TipoOrario = 'D') then
    debitodaorario:=z189_debito_ggass(ValNumT020['OreTeor'])
  else if TipoOrario = 'E' then
    if (pianif = 'si') and (l08_Turno1 >= 1) then
    begin
      if (l08_turno1EU = 'E') and
         (ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,l08_turno1] <= ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,l08_turno1]) and
         (ValStrT021['ENTRATA',TF_PUNTI_NOMINALI,l08_turno1] <> '') and
         (cdsT020.FieldByName('FrazDeb').AsString = 'S') then
      begin
        if ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_turno1] = 0 then
          debitodaorario:=1440 - ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,l08_turno1]
        else
          debitodaorario:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_turno1];
      end
      else if (l08_turno1EU = 'U') and
        (ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,l08_turno1] <= ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,l08_turno1]) and
        (ValStrT021['ENTRATA',TF_PUNTI_NOMINALI,l08_turno1] <> '') and
        (cdsT020.FieldByName('FrazDeb').AsString = 'S') then
      begin
        if ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_turno1] = 0 then
          debitodaorario:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,l08_turno1]
        else
          debitodaorario:=ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_turno1];
      end
      else if (ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,l08_turno1] <= ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,l08_turno1]) and
              (cdsT020.FieldByName('FrazDeb').AsString = 'S') then
        debitodaorario:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_turno1] + ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_turno1]
      else
        debitodaorario:=z189_debito_ggass(ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_turno1]);
      //Considerazione della pianificazione di un secondo turno notturno solo se in E o in U, ai fini delle giornate senza timbrature
      if (ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,l08_turno2] <= ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,l08_turno2]) and
         (ValStrT021['ENTRATA',TF_PUNTI_NOMINALI,l08_turno2] <> '') and
         (cdsT020.FieldByName('FrazDeb').AsString = 'S') then
        if (l08_turno2EU = 'E') then
        begin
          if ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_turno2] = 0 then
            inc(debitodaorario,1440 - ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,l08_turno2])
          else
            inc(debitodaorario,ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_turno2]);
        end
        else if (l08_turno2EU = 'U') then
        begin
          if ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_turno2] = 0 then
            inc(debitodaorario,ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,l08_turno2])
          else
            inc(debitodaorario,ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_turno2]);
        end;
    end
    else
    begin
      debitocalc:='no';
    end;

  if (Q430.FieldByName('HTeoriche').AsString = '0') or (Q430.FieldByName('HTeoriche').AsString = '3') then
  begin
    debitocalc:='si';
    debitogg:=debitorp;
  end
  else if debitocalc = 'si' then
  begin
    debitogg:=debitodaorario;
    if Q430.FieldByName('HTeoriche').AsString = '1' then
      debitorp:=debitogg;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z184_debiti;
{Azzeramento debiti se gg non lavorativo, verifica turnisti,
 calcolo debiti per indennita' festiva e di presenza
 Verifica calcolo debito orario giornaliero per turnisti}
begin
  if debitocalc = 'no' then
  begin
    debitogg:=z189_debito_ggass(ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,1]);
    debitodaorario:=debitogg;
  end;
  if Q430.FieldByName('HTeoriche').AsString = '1' then
    debitorp:=debitogg;
  //Calcolo riposi compensativi da turnazione (prima era in z770 ma debitorp veniva azzerato nei giorni festivi)
  if (cdsT020.FindField('RIPCOM_DEBITOGG') <> nil) and (cdsT020.FieldByName('RIPCOM_DEBITOGG').AsString = 'S') then
    debitorp_ripcom:=debitogg
  else
    debitorp_ripcom:=debitorp;
  //Alberto 08/01/2019: Torino_CDS per part-time verticali
  if (cdsT020.FieldByName('Matura_Ripcom').AsString = 'S') and (not cdsT020.FieldByName('Debito_Ripcom').IsNull) then
    debitorp_ripcom:=ValNumT020['Debito_Ripcom'];

  if not XParam[XP_TC_RIPOCOM_GIUSTIF] then
    z1011_MaturaRiposoCompensativo;
  //Memorizzo debito per calcolo indennita' se giorno festivo
  if (tipogg = 'F') or (giorsett = 7) then
    if ValNumT020['OreIndFest'] > 0 then
      debitoindfes:=ValNumT020['OreIndFest']
    else
    begin
      debitoindfes:=debitogg;
      if (TipoOrario = 'E') and (cdsT020.FieldByName('FrazDeb').AsString = 'S') and (pianif = 'si') and (l08_Turno1 >= 1) then
        if (l08_turno1EU = 'E') or (l08_turno1EU = 'U') then
          debitoindfes:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_turno1] + ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_turno1];
    end;
  //Debito orario senza gestione non lavorativo
  debitoor:=debitogg;
  //Calcolo debito per attribuzione indennita' di presenza
  if cdsT020.FieldByName('FlagPres').AsString = 'N' then
    mmminpresoggiint:=1441
  else if cdsT020.FieldByName('FlagPres').AsString = 'I' then
    mmminpresoggiint:=debitogg
  else if cdsT020.FieldByName('FlagPres').AsString = 'M' then
    mmminpresoggiint:=debitogg div 2
  else
    //Conversione hh.mm minimi per indennita' presenza in minuti
    mmMinPresOggiInt:=ValNumT020['mmindPres'];
  //Se il debito per attribuzione indennita' di presenza e' 0
  //lo porto a 1 (impongo di lavorare almeno un minuto)
  if mmminpresoggiint = 0 then
    mmminpresoggiint:=1;
  //Calcolo debito per attribuzione mezza indennita' presenza
  if cdsT020.FieldByName('FlagMPres').AsString = 'N' then
    mmminpresoggimez:=1441
  else
    //Conversione hh.mm minimi per indennita' presenza in minuti
    mmminpresoggimez:=ValNumT020['mmindMPres'];
  //Se il debito per attribuzione mezza indennita' di presenza
  //e' 0 lo porto a 1 (impongo di lavorare almeno un minuto)
  if mmminpresoggimez = 0 then
    mmminpresoggimez:=1;
  if  ((Q430.FieldByName('TGestione').AsString = '1') or ((Q430.FieldByName('TGestione').AsString = '0') and (cdsT020.FindField('FRAZDEB_NO_TURNISTA') <> nil) and (cdsT020.FieldByName('FRAZDEB_NO_TURNISTA').AsString = 'S') and (gglav = 'si')))
  and (R180In(Q430.FieldByName('HTeoriche').AsString,['1','2','3','4']))
  and (TipoOrario = 'E')
  and (PeriodoLavorativo = 'T1')
  and (cdsT020.FieldByName('FrazDeb').AsString = 'S')
  and (turnonott > 0)
  then
  //Gestione frazionamento debito orario turno notturno
  begin
    z185_gestfrazdeb;
    if Q430.FieldByName('HTeoriche').AsString = '1' then
      debitorp:=debitogg
    else if ((Q430.FieldByName('HTeoriche').AsString = '2') or (Q430.FieldByName('HTeoriche').AsString = '3')) and (gglavcal = 'no') then
    begin
      debitorp:=0;
      debitopo:=0;
    end
    else if (Q430.FieldByName('HTeoriche').AsString = '4') and (tipogglav = 'N') then
    //Alberto 05/02/2005 (GENOVA_HSMARTINO)
    begin
      debitorp:=0;
      debitopo:=0;
      debitocl:=0;
    end;
    if (gglavcal = 'no') and (Q430.FieldByName('HTeoriche').AsString <> '4') then
      debitocl:=0;
    scostamentodebito:=debitodaorario - debitocl;
    exit;
  end;
  if (Q430.FieldByName('TGestione').AsString = '1') and ((Q430.FieldByName('HTeoriche').AsString = '2') or (Q430.FieldByName('HTeoriche').AsString = '3')) then
  begin
    if gglavcal = 'no' then
    begin
      debitorp:=0;
      debitopo:=0;
    end;
    if gglav = 'no' then
    begin
      debitogg:=0;
      debitodaorario:=0;
      ripcom:=0;
      matura_ripcom:=False;
    end;
  end
  else if Q430.FieldByName('HTeoriche').AsString = '4' then
  //Alberto 05/02/2005 (GENOVA_HSMARTINO)
  begin
    if (tipogglav = 'N') then
    begin
      debitorp:=0;
      debitopo:=0;
      debitocl:=0;
    end;
    if (Q430.FieldByName('TGestione').AsString <> '2') and (Q430.FieldByName('TGestione').AsString <> '3') and (gglav = 'no') then
    begin
      if (tipogglav = 'N') or (Q430.FieldByName('TGestione').AsString = '1') then
      begin
        debitogg:=0;
        debitodaorario:=0;
      end;
      ripcom:=0;
      matura_ripcom:=False;
    end;
  end
  else if gglav = 'no' then
  begin
    debitorp:=0;
    debitopo:=0;
    ripcom:=0;
    matura_ripcom:=False;
    if (Q430.FieldByName('TGestione').AsString <> '2') and (Q430.FieldByName('TGestione').AsString <> '3') then
    begin
      debitogg:=0;
      debitodaorario:=0;
    end;
  end;
  //OBSOLETO!! non dovrebbe più servire - Aosta_Regione -  gestione festivo lavorato: per i turnisti nei festivi infrasettimanali si annulla sempre il debito
  if XParam[XP_RAVDA_FESTLAV_DEBITO0] and
     (Q430.FieldByName('TGestione').AsString = '1') and (tipogg = 'F') and (giorsett in [1..5])
     //and (n_giusgga = 0)  //Escludere se giornata di assenza??
     then
  begin
    debitogg:=0;
    debitorp:=0;
    debitopo:=0;
    debitodaorario:=0;
    ripcom:=0;
    matura_ripcom:=False;
  end;
  //Alberto 30/08/2010: Riposi compensativi per CRV nei giorni non lavorativi
  if (gglav = 'no') and
     (cdsT020.FieldByName('Matura_Ripcom').AsString = 'R') and
     (cdsT020.FieldByName('RIPCOM_GGNONLAV').AsString = 'S')  then
  begin
    z752_lavscostgg;
    if cdsT020.FieldByName('Debito_Ripcom').IsNull then
      ripcom:=max(0,min(0,totlav) - 0)
    else
      ripcom:=min(max(0,totlav - 0),ValNumT020['Debito_Ripcom']);
      //ripcom:=min(ValNumT020['Debito_Ripcom'],max(0,totlav - debitogg));
      //ripcom:=max(0,min(ValNumT020['Debito_Ripcom'],totlav) - debitorp);
    if n_giusgga > 0 then
    begin
      if (totlav = 0) or ((primat_u = 'si') and (Length(TimbratureOriginali) = 1)) then
        ripcom:=0;
    end;
  end;
  //Alberto 17/11/2004: debito da calendario usato nella pianificazione turni
  if (gglavcal = 'no') and (Q430.FieldByName('HTeoriche').AsString <> '4') then
    debitocl:=0;
  //Alberto 21/01/2003: RICALCOLO DEBITO GIORNALIERO x PROVINCIA DI TORINO
  //Avviene per tutti i giorni lavorativi da calendario, anche se sono anche festivi
  if //(gglavcal = 'si') and (debitogg > 0) and
     (tipogglav = 'S') and
     (Self.Name <> 'R502Ricorsivo') and (cdsT020.FieldByName('RICALCOLO_DEBITO_GG').AsString = 'S') then
  begin
    if cdsT020.FieldByName('RICALCOLO_SPOSTA_PN').AsString <> 'S' then
      z187_RicalcoloDebitoGiornaliero;
  end;
  scostamentodebito:=debitodaorario - debitocl;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z185_gestfrazdeb;
{Gestione frazionamento debito orario turno notturno}
var i:Integer;
begin
  if gglav = 'no' then
  begin
    debitogg:=debfrazmatt + debfrazsera;
    debitopo:=0;
    ripcom:=0;
    matura_ripcom:=False;
    exit;
  end;
  //Alberto 04/06/2012: calcolo il riposo compensativo solo sul giorno di monto della notte (PINEROLO _ASLTO3)
  if (debfrazsera = 0) and (debnoncav = 0) then
  begin
    ripcom:=0;
    matura_ripcom:=False;
  end;
  //Se pianificato il turno notturno in E/U esco perchè già calcolato precedentemente
  if (pianif = 'si') and (l08_Turno1 >= 1) and (l08_Turno1 = l08_Turno2) and
     ((l08_Turno1EU = 'E') and (l08_Turno2EU = 'U') or
      (l08_Turno1EU = 'U') and (l08_Turno2EU = 'E')) then
    exit;
  if (pianif = 'si') and (l08_Turno1 > 0) and (l08_Turno2 > 0) then
  begin
    //se Entrambi turni notturni esco perchè già calcolato precedentemente
    if (EntrataNominale[l08_Turno1] >= UscitaNominale[l08_Turno1]) and
       (EntrataNominale[l08_Turno2] >= UscitaNominale[l08_Turno2]) then
    begin
      exit;
    end;
    if turnonott = l08_Turno1 then
      //Due turni pianificati ed uno coincide con quello a cavallo
      //di mezzanotte effettivamente svolto
    begin
      debitogg:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_Turno2] + debfrazmatt + debfrazsera;
      exit;
    end
    else if turnonott = l08_Turno2 then
      //Due turni pianificati ed uno coincide con quello a cavallo
      //di mezzanotte effettivamente svolto
    begin
      debitogg:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_Turno1] + debfrazmatt + debfrazsera;
      exit;
    end
    else
      //Due turni pianificati ma nessuno coincide con quello a
      //cavallo di mezzanotte effettivamente svolto
      exit;
  end;
  if (pianif = 'si') and (l08_Turno1 > 0) then
    if (turnonott = l08_Turno1) then
      //Un turno pianificato coincidente con quello a cavallo
      //di mezzanotte effettivamente svolto
    begin
      debitogg:=debfrazmatt + debfrazsera;
      exit;
    end
    else
      //Un turno pianificato non coincidente con quello a cavallo
      //di mezzanotte effettivamente svolto
      exit;
  //Non vi sono turni pianificati
  if orelav24 = 'no' then
  begin
    if debnoncav = 0 then
    begin
      //Verifico se c'è un riposo compensativo: in tal caso,
      //oltre al debito dello smonto notte si aggiunge anche il debito del turno diurno (debitogg)
      for i:=1 to n_giusgga do
      begin
        z964_leggicaus(tgius_ggass[i1].tcausggass);
        if (s_trovato = 'si') and (parcaus.l29_1paramet = 'A') and (parcaus.l29_Ragg = traggrcausas[5].C) then
        begin
          debnoncav:=debitogg;
          Break;
        end;
      end;
    end;
    debitogg:=debnoncav + debfrazmatt + debfrazsera;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z186_fascein;
{Lettura fasce indennita' notturne da contratto}
begin
  iniz1fascind:=StrToIntDef(T200[Q200.FieldByName('IndNotteDa').Index],0);
  if StrToIntDef(T200[Q200.FieldByName('IndNotteA').Index],0) = 0 then
    fine1fascind:=1440
  else
    fine1fascind:=StrToIntDef(T200[Q200.FieldByName('IndNotteA').Index],0);
  iniz2fascind:=0;
  fine2fascind:=0;
  if iniz1fascind > fine1fascind then
  begin
    fine2fascind:=fine1fascind;
    fine1fascind:=1440;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z187_RicalcoloDebitoGiornaliero;
{RICALCOLO DEBITO GIORNALIERO x PROVINCIA DI TORINO - REGIONE PIEMONTE
 ESIGENZA:
 il debito del Venerdì viene abbattuto dagli scostamenti compensabili fatti
 nella settimana da Lunedì a Giovedì.
 L'abbattimento riguarda solo debitogg e non debitorp.
 FLUSSO:
 Se il tipo cartellino lo prevede, lo script GetPrimoGGSettimana verifica se
 il giorno corrente è l'ultimo lavorativo della settimana, nel qual caso restituisce
 il primo giorno lavorativo della settimana.
 Viene creata una nuova istanza di R502 per effettuare i conteggi da PrimoGiorno al
 giorno precedente quello corrente.
 Per ogni giorno conteggiato si verifica lo scostamento compensabile, dato da:
 TotaleOreRese - EccedenzaLiquidabile - DebitoGG
 Il debito giornaliero può venire aumentato se c'è uno scostamento negativo, senza mai
 superare il debito gg originale. In pratica l'abbattimento dovuto a uno scostamento positivo può
 essere annullato da uno scostamento negativo fatto nella stessa settimana.
 }
var PrimoGiorno,UltimoGiorno:TDateTime;
    OreCompletamento,i,debitoNew,resass:Integer;
begin
  //Nuova istanza di R502ProDtM1
  //Alberto 04/12/2009:
  //sembra necessario riconoscere sulla sessione oracle che viene creata una nuova istanza di R502, in modo che sul create venga gestito l'owner correttamente
  //il problema si verifica sul web service (B020) che va in errore se viene ripassato come owner la SessioneOracle, per cui si risolve eseguendo la creazione con nil (???????)
  //SessioneOracleR502.Name:='RICORSIONE_' + SessioneOracleR502.Name;
  //if (Self.Owner <> nil) and not(Self.Owner is TOracleDataSet) then
  if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
    R502Ricorsivo:=TR502ProDtM1.Create(Self.Owner,True)
  else
    R502Ricorsivo:=TR502ProDtM1.Create(SessioneOracleR502,True);
  SessioneOracleR502.Name:=StringReplace(SessioneOracleR502.Name,'RICORSIONE_','',[]);
  try
    ResoSett:=0;
    debitoNew:=debitogg;
    if (gglav = 'no') and (tipogglav = 'S') then
      DebSett:=0
    else
      DebSett:=debitogg;
    RicalcoloMaxScostPos:=ValNumT020['RICALCOLO_MAX'];
    R502Ricorsivo.Name:='R502Ricorsivo';
    PrimoGiorno:=DataCon - (giorsett - 1);
    UltimoGiorno:=PrimoGiorno + 6;
    R502Ricorsivo.PeriodoConteggi(PrimoGiorno,UltimoGiorno);
    while PrimoGiorno <= UltimoGiorno do
    begin
      if PrimoGiorno = DataCon then
      begin
        PrimoGiorno:=PrimoGiorno + 1;
        Continue;
      end;
      //Conteggi sui giorni da inizio settimana al giorno precedente (Lu..Gio)
      R502Ricorsivo.ConsideraRichiesteWeb:=ConsideraRichiesteWeb;
      R502Ricorsivo.Conteggi('Cartolina',ProgrCon,PrimoGiorno);
      if R502Ricorsivo.gglav = 'si' then
      begin
        OreCompletamento:=0;
        for i:=1 to R502Ricorsivo.n_fasce do
          inc(OreCompletamento,R502Ricorsivo.tminlav[i]);// - R502Ricorsivo.tminstrgio[i]);
        if not R502Ricorsivo.cdsT020.FieldByName('OreMin').IsNull then
          inc(ResoSett,max(OreCompletamento,R502Ricorsivo.ValNumT020['OreMin']))
        else
          inc(ResoSett,OreCompletamento);  //TORINO_COMUNE per quadratura settimanale
        (*Lo scostamento, negativo e positivo, influenza il debito ricalcolato,
          ma le ore rese sono limitate all'interno dei parametri RICALCOLO_MIN e RICALCOLO_MAX*)
        OreCompletamento:=max(OreCompletamento,ValNumT020['RICALCOLO_MIN']);
        OreCompletamento:=min(OreCompletamento,ValNumT020['RICALCOLO_MAX']);
        OreCompletamento:=OreCompletamento - R502Ricorsivo.debitogg;
        debitoNew:=debitoNew - OreCompletamento;
        inc(DebSett,R502Ricorsivo.debitogg);
      end
      else if (not cdsT020.FieldByName('RICALCOLO_CAUS_NEG').IsNull) or (not cdsT020.FieldByName('RICALCOLO_CAUS_POS').IsNull) then
      //Torino_Comune: se giorno non lavorativo guardo la resa dei giustificativi per la quadratura settimanale,
      //non considerando le causali usate per la quadratura stessa
      begin
        resass:=0;
        for i:=1 to R502Ricorsivo.n_riepasse do
          if (R502Ricorsivo.triepgiusasse[i].tcausasse <> cdsT020.FieldByName('RICALCOLO_CAUS_NEG').AsString) and
             (R502Ricorsivo.triepgiusasse[i].tcausasse <> cdsT020.FieldByName('RICALCOLO_CAUS_POS').AsString) and
             (R502Ricorsivo.triepgiusasse[i].tminresasse > 0) then
            inc(resass,R502Ricorsivo.triepgiusasse[i].tminresasse);
        inc(ResoSett,min(resass,R180SommaArray(R502Ricorsivo.tminlav)));
      end;
      PrimoGiorno:=PrimoGiorno + 1;
    end;
  finally
    FreeAndNil(R502Ricorsivo);
  end;
  if debitogg = 0 then
  begin
    z752_lavscostgg;
    if (debitoNew > 0) and (debitoNew > totlav) then
      MinRicalcoloFest:=debitoNew - totlav;
  end
  else
  begin
    //Alberto TORINO_COMUNE: orario a scorrimento: la somma settimanale degli scostamenti non può portare a meno di un'ora o a più di due ore
    begin
      begin
        //Non si altera il debito e punti nominali se il giorno è giustificato, ma è necessario fare i conteggi precedenti per la quadratura settimanale
        if cdsT020.FieldByName('RICALCOLO_OFF_NOTIMB').AsString = 'S' then
          if (n_timbrdip = 0) and (n_giusdaa + n_giusore + n_giusmga + n_giusgga > 0) then
            exit;
        if not cdsT020.FieldByName('RICALCOLO_DEB_MIN').IsNull then
          if debitogg - Max(0,debitoNew) > ValNumT020['RICALCOLO_DEB_MIN'] then
            debitoNew:=debitogg - ValNumT020['RICALCOLO_DEB_MIN'];
        if not cdsT020.FieldByName('RICALCOLO_DEB_MAX').IsNull then
          if Max(0,debitoNew) - debitogg > ValNumT020['RICALCOLO_DEB_MAX'] then
            debitoNew:=debitogg + ValNumT020['RICALCOLO_DEB_MAX'];
        (*if debitogg - Max(0,debitoNew) > 60 then
          debitoNew:=debitogg - 60
        else if Max(0,debitoNew) - debitogg > 120 then
          debitoNew:=debitogg + 120;*)
      end;
      if cdsT020.FieldByName('RICALCOLO_SPOSTA_PN').AsString = 'S' then
        if debitoNew - debitogg > 0 then
        begin
          ttimbraturenom[n_timbrnom].tminutin_u:=ttimbraturenom[n_timbrnom].tminutin_u + max(-ttimbraturenom[n_timbrnom].tminutin_u,debitoNew - debitogg);
          if ttimbraturenom[n_timbrnom].tminutin_u > 1440 then
            ttimbraturenom[n_timbrnom].tminutin_u:=1440;
        end;
    end;
    debitogg:=Max(0,debitoNew);
    debitodaorario:=debitogg;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z188_debitopo;
{Calcolo debito plus orario senza gestione non lavorativo
 Verifica se esiste debito plus orario individuale}
var MinDebitoPomm:Integer;
begin
  z190_debpoind;
  if debpoind = 'no' then
  //Lettura debito plus orario da categoria
  begin
    z192_debpocat;
    if blocca <> 0 then exit;
  end;
  //Conversione debito plus orario del mese in minuti
  MinDebitoPomm:=R180OreMinutiExt(debitopomm);
  try
    if debitoposm = 'S' then
      //Calcolo debito plus orario da settimanale
      try
        debitopo:=MinDebitoPomm div giornlav;
        // part-time percentualizzato.ini
        if debpoind = 'no' then
          debitopo:=Trunc(debitopo * PercPartTime['DEBITO_AGG']);
        debitopoass:=debitopo;
        // part-time percentualizzato.fine
      except
        debitopo:=0;
        debitopoass:=0; // part-time - daniloc. 01.03.2010
      end
    else
    //Calcolo giorni lavorativi del mese
    begin
      z194_gglavmens;
      if blocca = 0 then
      //Calcolo debito plus orario da mensile
      begin
        debitopo:=MinDebitoPomm div gglavmm;
        // part-time percentualizzato.ini
        if debpoind = 'no' then
          debitopo:=Trunc(debitopo * PercPartTime['DEBITO_AGG']);
        // part-time percentualizzato.fine
        debitopoass:=debitopo;
      end;
    end;
  except
    on EDivByZero do
    begin
      debitopo:=0;
      debitopoass:=0;
    end;
    else
      raise;
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.z189_debito_ggass(debito_std:Integer):Integer;
begin
  Result:=debito_std;
  if n_giusore > 0 then
    exit;
  if n_giusdaa > 0 then
    exit;
  if Length(TimbratureDelGiorno) > 1 then
    exit;
  if (Length(TimbratureDelGiorno) = 1) and (TimbratureDelGiorno[0].tversotimb <> 'U') then
    exit;
  if n_giusmga + n_giusgga = 0 then
    exit;

  if not cdsT020.FieldByName('ORETEOR_GGASS').IsNull then
  begin
    Result:=ValNumT020['ORETEOR_GGASS'];
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z190_debpoind;
{Verifica se esiste debito plus orario individuale}
begin
  if Q090_OREPO = 0 then
  begin
    Q090_OREPO:=Q090.FieldByName('ORE1').Index;
    //Q090_FLAGPO:=Q090.FieldByName('TIPOGEST1').Index;
  end;
  debpoind:='no';
  z936_leggipoin;
  if s_trovato = 'si' then
  begin
    es09_sv:='si';
    if Q090.Fields[Q090_OREPO + datacon_mm - 1].AsString <> '' then
    begin
      //Debito plus orario da tabella individuale
      debitopomm:=Q090.Fields[Q090_OREPO + datacon_mm - 1].AsString;
      debitoposm:=R180CarattereDef(Q090.FieldByName('TipoDebito').AsString);
      tipogespo:=R180CarattereDef(Q090.FieldByName('TipoPO').AsString);
      (*
      if Q090.Fields[Q090_FLAGPO + datacon_mm - 1].AsString <> '' then
        tipogespo:=R180CarattereDef(Q090.Fields[Q090_FLAGPO + datacon_mm - 1].AsString)
      else
        tipogespo:=R180CarattereDef(Q090.FieldByName('TipoPO').AsString);
      *)
      debpoind:='si';
    end;
  end
  else
    es09_sv:='no';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z192_debpocat;
{Lettura debito plus orario da categoria}
begin
  if Q060_OREPO = 0 then
  begin
    Q060_OREPO:=Q060.FieldByName('ORE1').Index;
    //Q060_FLAGPO:=Q060.FieldByName('TIPOGEST1').Index;
  end;
  z938_leggipocat;
  if s_trovato = 'no' then
  begin
    debitopomm:='';
    debitoposm:='S';
  end
  else
  begin
    debitopomm:=Q060.Fields[Q060_OREPO + datacon_mm - 1].AsString;
    debitoposm:=R180CarattereDef(Q060.FieldByName('TipoDebito').AsString);
    tipogespo:=R180CarattereDef(Q060.FieldByName('TipoPO').AsString);
    (*
    if Q060.Fields[C_POS_FLAGPO + datacon_mm].AsString <> '' then
      tipogespo:=R180CarattereDef(Q060.Fields[Q060_FLAGPO + datacon_mm - 1].AsString)
    else
      tipogespo:=R180CarattereDef(Q060.FieldByName('TipoPO').AsString);
    *)
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z194_gglavmens;
{Calcolo giorni lavorativi del mese}
var R_ngm170:Integer;
begin
  if (progrcon = progrconpo_sv) and (datacon_aa = annopo_sv) and
     (datacon_mm = mesepo_sv) then exit;
  progrconpo_sv:=0;
  annopo_sv:=0;
  mesepo_sv:=0;
  gglavmm:=0;
  //Calcolo numero giorni del mese attuale in r_ngm170
  R_ngm170:=R180GiorniMese(datacon);
  //Alberto 20/06/2006
  if (VarToStr(Q011.GetVariable('CODICE')) <> Q430.FieldByName('Calendario').AsString) or
     (Q011.GetVariable('DADATA') <> EncodeDate(datacon_aa,datacon_mm,1)) or
     (Q011.GetVariable('ADATA') <>  EncodeDate(datacon_aa,datacon_mm,R_ngm170)) then
  begin
    Q011.SetVariable('CODICE',Q430.FieldByName('Calendario').AsString);
    Q011.SetVariable('DADATA',EncodeDate(datacon_aa,datacon_mm,1));
    Q011.SetVariable('ADATA',EncodeDate(datacon_aa,datacon_mm,R_ngm170));
    Q011.Close;
  end;
  Q011.Open;
  Q011.First;
  gglavmm:=0;
  while not Q011.Eof do
    begin
    gglavmm:=gglavmm + Q011.Fields[0].AsInteger;
    Q011.Next;
    end;
  if blocca = 0 then
    begin
    progrconpo_sv:=progrcon;
    annopo_sv:=datacon_aa;
    mesepo_sv:=datacon_mm;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z198_arrgiornal;
{Arrotondamento giornaliero
Calcolo minuti lavorati considerando solo timbrature}
var i:Integer;
begin
  if XParam[XP_ARROTNEGPOS_FINALE] then
    exit;
  minlavtim:=0;
  for i:=1 to n_fasce do
    inc(minlavtim,tminlav[i]);
  //Scelta se arrotondamento in positivo o in negativo
  if minlavtim = debitogg then exit;
  if minlavtim > debitogg then
    arr890:=ValNumT020['ArrPos']
  else
    arr890:=ValNumT020['ArrNeg'];
  comodo2:=minlavtim;
  per892:=minlavtim;
  //Arrotondamento del totale giornaliero
  z892_arrotondap;
  //Calcolo eventuali detrazioni causa arrotondamento
  detrazioni:=comodo2 - per892;
  //Eventuali detrazioni arrotondamento giornaliero
  z140_detrazioni(tminlav);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z199_arrgiornal_finale;
{Arrotondamento giornaliero sul lavorato finale}
begin
  if not XParam[XP_ARROTNEGPOS_FINALE] then
    exit;
  minlavtim:=R180SommaArray(tminlav);
  //Scelta se arrotondamento in positivo o in negativo
  if minlavtim = debitogg then exit;
  if minlavtim > debitogg then
    arr890:=ValNumT020['ArrPos']
  else
    arr890:=ValNumT020['ArrNeg'];
  comodo2:=minlavtim;
  per892:=minlavtim;
  //Arrotondamento del totale giornaliero
  z892_arrotondap;
  //Calcolo eventuali detrazioni causa arrotondamento
  detrazioni:=comodo2 - per892;
  //Eventuali detrazioni arrotondamento giornaliero
  z140_detrazioni(tminlav);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z200_oreelast;
{Gestione ore min e max giornaliere per orario elastico
 Detrazione pausa mensa dalle ore lavorate in fascia}
var OreMaxMinuti:Integer;
    OreCausPuntiNominali:Integer;
    i:Integer;
begin
  if paumendet < minlavorar then
     dec(minlavorar,paumendet)
  else
    minlavorar:=0;

  OreCausPuntiNominali:=0;
  if (cdsT020.FieldByName('CompDetr').AsString = 'N') and (Trim(CausaliPuntiNominali277) <> '') then
    for i:=1 to n_rieppres do
      if Pos(',' + triepgiuspres[i].tcauspres + ',',',' + CausaliPuntiNominali277 + ',') > 0 then
        inc(OreCausPuntiNominali,RiepPresTotale[i]);

  //Controllo se lavorate le ore minime in caso di giorno
  //lavorativo privo di causali di giornate intere di assenza
  if gglav = 'si' then
    if (n_timbrdip > 0) or ((n_timbrdip = 0) and (n_giusgga = 0)) then
    begin
      if minlavorar + OreCausPuntiNominali < ValNumT020['OreMin'] then
      begin
        z098_anom2caus(20,Format('%s < %s',[R180MinutiOre(minlavorar + OreCausPuntiNominali),R180MinutiOre(ValNumT020['OreMin'])]));
      end;
    end;
  //Controllo se superate le ore massime
  OreMaxMinuti:=ValNumT020['OreMax'];
  if OreMaxMinuti > 0 then
  begin
    if minlavorar + OreCausPuntiNominali > OreMaxMinuti then
      if cdsT020.FieldByName('CompDetr').AsString = 'S' then
        //Eccedenza compensabile con assenza per
        //superamento ore massime
        eccsolocomp:=eccsolocomp + minlavorar - OreMaxMinuti
      else
      begin
        z098_anom2caus(21,Format('%s > %s',[R180MinutiOre(minlavorar + OreCausPuntiNominali),R180MinutiOre(OreMaxMinuti)]));
        //Detrazioni per superamento ore massime
        detrazioni:=minlavorar + OreCausPuntiNominali - OreMaxMinuti;
        z140_detrazioni(tminlav);
        if detrazioni > 0 then
        begin
          for i:=1 to n_rieppres do
            if Pos(',' + triepgiuspres[i].tcauspres + ',',',' + CausaliPuntiNominali277 + ',') > 0 then
              z140_detrazioni(triepgiuspres[i].tminpres);
        end;
        if minlavorar > OreMaxMinuti then
          minlavorar:=OreMaxMinuti;
      end;
  end;
  //Calcolo minuti di scostamento in fascia di elasticita'
  scostfascia:=minlavorar - debitogg;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z202_minfaselast;
//Calcolo minuti resi in fasce per orario elastico
var i,j,E,U:Integer;
begin
  //try...except: nel caso di 'Assenze' non scelgo l'orario, per cui T020.Count = 0!
  try
    if TipoOrario <> 'C' then exit;
  except
    exit;
  end;
  //Scorrimento coppie timbrature nominali per ricercarne
  //l'intersezione con quella del dipendente in gestione
  for i:=1 to n_timbrnom do
  begin
    if (i > 1) and (ttimbraturenom[i].tminutin_e < ttimbraturenom[i - 1].tminutin_u) then
      comodo3:=ttimbraturenom[i - 1].tminutin_u
    else
      comodo3:=ttimbraturenom[i].tminutin_e;
    if (ttimbraturedip[ieu].tminutid_e < ttimbraturenom[i].tminutin_u) and (ttimbraturedip[ieu].tminutid_u > comodo3) then
    begin
      if ttimbraturedip[ieu].tminutid_e < comodo3 then
        E:=comodo3
      else
        E:=ttimbraturedip[ieu].tminutid_e;
      if ttimbraturedip[ieu].tminutid_u < ttimbraturenom[i].tminutin_u then
        U:=ttimbraturedip[ieu].tminutid_u//minlavorar:=minlavorar + ttimbraturedip[ieu].tminutid_u - comodo2
      else
        U:=ttimbraturenom[i].tminutin_u;//minlavorar:=minlavorar + ttimbraturenom[i].tminutin_u - comodo2
      inc(minlavorar,U - E);
      for j:=0 to High(timbtipoAesc) do
        if (timbtipoAesc[j].I < U) and (timbtipoAesc[j].F > E) then
          dec(minlavorar,min(U,timbtipoAesc[j].F) - max(E,timbtipoAesc[j].I));
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z208_strdopoteo;
{Strardinario dopo ore teoriche
 Calcolo minuti lavorati considerando solo timbrature}
var r_minuti180:Integer;
    i:Integer;
begin
  minlavtim:=0;
  for i:=1 to n_fasce do
    inc(minlavtim,tminlav[i]);
  //Calcolo debito da modello di orario
  z346_debdaorar(r_minuti180);
  if minlavtim <= r_minuti180 then exit;
  dec(minlavtim,r_minuti180);
  //Calcolo minuti lavorati in strardinario dopo ore teoriche
  comodo2:=0;
  for i:=1 to n_fasce do
    inc(comodo2,triepgiuspres[1].tminpres[i]);
  if minlavtim > comodo2 then
    triepgiuspres[1].tminpres[1]:=triepgiuspres[1].tminpres[1] + minlavtim - comodo2;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z210_legginomA;
{Lettura timbrature nominali di un tipo orario A}
begin
  n_timbrnom:=1;
  SetLength(ttimbraturenom,2);
  ttimbraturenom[1]:=ttimbraturenom_vuota;
  ttimbraturenom[1].tminutin_e:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,1];
  ttimbraturenom[1].tminutin_u:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,1];
  if PeriodoLavorativo = 'S' then
  begin
    n_timbrnom:=2;
    SetLength(ttimbraturenom,3);
    ttimbraturenom[2]:=ttimbraturenom_vuota;
    ttimbraturenom[2].tminutin_e:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,2];
    ttimbraturenom[2].tminutin_u:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,2];
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z212_corregginomA;
var i,inizio:Integer;
    lstCausRiduzPN,lstCausRiduzPN_CheckPMT:String;
    EsisteCausRiduzPN:Boolean;
    EsisteAltraCaus:Boolean;
    EsisteCausPM:Boolean;
    R502CorreggiNomA:TR502ProDtM1;
begin
  if Self.Name = 'R502CorreggiNomA' then
    exit;
  if cdsT020.FindField('CAUS_RIDUZPN') = nil then
    exit;
  if cdsT020.FindField('CAUS_RIDUZPN_CHECKPMT') <> nil then
    lstCausRiduzPN_CheckPMT:=cdsT020.FieldByName('CAUS_RIDUZPN_CHECKPMT').AsString;
  if cdsT020.FieldByName('CAUS_RIDUZPN').AsString + lstCausRiduzPN_CheckPMT = '' then
    exit;
  if not ((TipoOrario = 'A') and (PeriodoLavorativo = 'C')) then
     exit;
  if ttimbraturenom[1].tminutin_u - ttimbraturenom[1].tminutin_e <= debitogg then
    exit;

  lstCausRiduzPN:=cdsT020.FieldByName('CAUS_RIDUZPN').AsString;
  if (lstCausRiduzPN <> '') and (lstCausRiduzPN_CheckPMT = '') then
  begin
    lstCausRiduzPN_CheckPMT:=lstCausRiduzPN;
    lstCausRiduzPN:='';
    if R180InConcat('35',lstCausRiduzPN_CheckPMT) then
      lstCausRiduzPN:=lstCausRiduzPN + ',35';
    if R180InConcat('83',lstCausRiduzPN_CheckPMT) then
      lstCausRiduzPN:=lstCausRiduzPN + ',83';
  end;

  EsisteCausRiduzPN:=lstCausRiduzPN = '<*>';
  EsisteAltraCaus:=False;
  EsisteCausPM:=False;

  for i:=1 to n_timbrdip - 1 do
  begin
    if (ttimbraturedip[i].tcausale_u.tcaus = ttimbraturedip[i + 1].tcausale_e.tcaus)
    and (ttimbraturedip[i].tcausale_u.tcaustip = 'C')
    and (ttimbraturedip[i].tcausale_u.tcausrag = traggrgius.C)
    then
    begin
      EsisteCausPM:=True;
      Break;
    end;
  end;

  if not EsisteCausRiduzPN then
  begin
    if XParam[XP_Z212_TUTTE_TIMB] then
      inizio:=1           //Considero tutte le timbrature (come era in origine), solo se c'è l'XParam attivo
    else
      inizio:=n_timbrdip; //Per default considero solo l'ultima timbratura

    for i:=inizio to n_timbrdip do
    begin
      if R180InConcat(ttimbraturedip[i].tcausale_u.tcaus,lstCausRiduzPN + ',' + lstCausRiduzPN_CheckPMT) and
         //R180In(ValStrT275[ttimbraturedip[i].tcausale_u.tcaus,'TIPOCONTEGGIO'],['A','C','D']) and
         (ttimbraturedip[i].tcausale_u.tcausabi = 'si') and
         (i = n_timbrdip)
      then
        EsisteCausRiduzPN:=True
      else if (ttimbraturedip[i].tcausale_u.tcaus <> '') and
              True//R180In(ValStrT275[ttimbraturedip[i].tcausale_u.tcaus,'TIPOCONTEGGIO'],['B','C','D'])
      then
        EsisteAltraCaus:=True;
    end;

    if not EsisteCausRiduzPN and (not EsisteAltraCaus) then
    begin
      //Cerco causalizzazioni in libera professione (autorizzazioni alle eccedenze gg) con le causali indicate
      if Q320.SearchRecord('DATA',datacon,[srFromBeginning]) then
        repeat
          if R180InConcat(Q320.FieldByName('CAUSALE').AsString,lstCausRiduzPN + ',' + lstCausRiduzPN_CheckPMT) then
          begin
            EsisteCausRiduzPN:=True;
            Break;
          end;
        until not Q320.SearchRecord('DATA',datacon,[]);
    end;
  end;

  if EsisteCausRiduzPN and (not EsisteAltraCaus) and
     (ttimbraturedip[n_timbrdip].tminutid_u > ttimbraturenom[1].tminutin_u) and
     //Condizione utile per le causali 35,83: in tal caso inutile fare i conteggi successivi
     (not R180InConcat(ttimbraturedip[n_timbrdip].tcausale_u.tcaus,lstCausRiduzPN) or EsisteCausPM)
  then
  begin
    EsisteCausRiduzPN:=False;
    //Richiamo conteggi interni per verificare se c'è o meno la pausa mensa, e di che tipo è
    if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
      R502CorreggiNomA:=TR502ProDtM1.Create(Self.Owner,True)
    else
      R502CorreggiNomA:=TR502ProDtM1.Create(SessioneOracleR502,True);
    SessioneOracleR502.Name:=StringReplace(SessioneOracleR502.Name,'RICORSIONE_','',[]);
    try
      R502CorreggiNomA.Name:='R502CorreggiNomA';
      R502CorreggiNomA.PeriodoConteggi(datacon - 1,datacon + 1);
      R502CorreggiNomA.ConsideraRichiesteWeb:=ConsideraRichiesteWeb;
      R502CorreggiNomA.Conteggi('Cartolina',ProgrCon,datacon);
      with R502CorreggiNomA do
      begin
        if (Blocca = 0) and (TipoDetPaumen = 'PMT') then
        //Accorciamento dei punti nominali se Pausa mensa timbrata oltre il punto nominale di uscita originale
        begin
          if (Length(TimbratureMensa) > 0) and
             (TimbratureMensa[0].F > ttimbraturenom[1].tminutin_u) then
          begin
            EsisteCausRiduzPN:=True;
          end;
        end
        else if (ttimbraturedip[n_timbrdip].tminutid_u <= ttimbraturenom[1].tminutin_u) then
        //Accorciamento dei punti nominali se Uscita anticipata con causale di servizio
        begin
          EsisteCausRiduzPN:=True;
        end;
      end;
    finally
      FreeAndNil(R502CorreggiNomA);
    end;
  end;

  //Accorciamento dei punti nominali in modo che corrispondano al debitogg
  if EsisteCausRiduzPN then
  begin
    z098_anom2caus(62,Format('%s -> %s',[R180MinutiOre(ttimbraturenom[1].tminutin_u),R180MinutiOre(ttimbraturenom[1].tminutin_e + debitogg)]));
    ttimbraturenom[1].tminutin_u:=ttimbraturenom[1].tminutin_e + debitogg;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z220_legginomB;
{Lettura timbrature nominali di un tipo orario B}
var i:Integer;
begin
  n_timbrnom:=1;
  SetLength(ttimbraturenom,2);
  ttimbraturenom[1]:=ttimbraturenom_vuota;
  ttimbraturenom[1].tminutin_e:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,1];
  ttimbraturenom[1].tminutin_u:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,1];
  if PeriodoLavorativo = 'S' then
  begin
    i:=2;
    repeat
      inc(n_timbrnom);
      SetLength(ttimbraturenom,n_timbrnom + 1);
      ttimbraturenom[i]:=ttimbraturenom_vuota;
      ttimbraturenom[i].tminutin_e:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,i];
      ttimbraturenom[i].tminutin_u:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,i];
      inc(i);
    until (i > 4) or (ValStrT021['ENTRATA',TF_PUNTI_NOMINALI,i] = '');
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z240_legginomC;
{Lettura timbrature nominali di un tipo orario C}
begin
  n_timbrnom:=1;
  SetLength(ttimbraturenom,2);
  ttimbraturenom[1]:=ttimbraturenom_vuota;
  ttimbraturenom[1].tminutin_e:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,1];
  if PeriodoLavorativo = 'S' then
  begin
    n_timbrnom:=2;
    SetLength(ttimbraturenom,3);
    ttimbraturenom[2]:=ttimbraturenom_vuota;
    ttimbraturenom[1].tminutin_u:=ValNumT021['MMRITARDO',TF_PM_TIMBRATA,1];
    ttimbraturenom[2].tminutin_e:=ValNumT021['MMANTICIPOU',TF_PM_TIMBRATA,1];
    ttimbraturenom[2].tminutin_u:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,1];
  end
  else
    ttimbraturenom[1].tminutin_u:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,1];
end;
//_________________________________________________________________
procedure TR502ProDtM1.z260_legginomD;
{Lettura timbrature nominali di un tipo orario D}
begin
  if PeriodoLavorativo = 'EU' then
  begin
    n_timbrnom:=1;
    SetLength(ttimbraturenom,2);
    ttimbraturenom[1]:=ttimbraturenom_vuota;
    ttimbraturenom[1].tminutin_e:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,1];
    ttimbraturenom[1].tminutin_u:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,1];
  end
  else if ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,1] <> 0 then
  begin
    n_timbrnom:=1;
    SetLength(ttimbraturenom,2);
    ttimbraturenom[1]:=ttimbraturenom_vuota;
    ttimbraturenom[1].tminutin_e:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,1];
    ttimbraturenom[1].tminutin_u:=2400;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z280_legginomE;
{Lettura timbrature nominali di un tipo orario E
 Controllo pianificazione turno}
var TurnoEU:String;
    i:Integer;
    TurnoNotturnoTrovato:Boolean;
  procedure SettaTurnoNotturnoEU(var TN:TTurnoNotturno; t:Integer);
  begin
    TN.E:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,t];
    TN.U:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,t];
    TN.Ritardo:=ValNumT021['MMRITARDOU',TF_PUNTI_NOMINALI,t];
    TN.Num:=0;
    if TN.U < 1440 then
    begin
      if TN.E >= TN.U then
        TN.U:=TN.U + 1440
      else
        TN.Num:=-1;
    end;
  end;
begin
  TurnoNotturno.E:=0;
  TurnoNotturno.U:=0;
  TurnoNotturno.Ritardo:=0;
  TurnoNotturno.Num:=-1;
  TurnoNotturnoE.E:=0;
  TurnoNotturnoE.U:=0;
  TurnoNotturnoE.Ritardo:=0;
  TurnoNotturnoE.Num:=-1;
  TurnoNotturnoU.E:=0;
  TurnoNotturnoU.U:=0;
  TurnoNotturnoU.Ritardo:=0;
  TurnoNotturnoU.Num:=-1;
  TurnoNotturnoTrovato:=False;
  if pianif = 'si' then
  begin
    z284_contrpianif;
    if blocca <> 0 then exit;
  end;
  if (pianif = 'si') and (l08_Turno1 > 0) and (l08_Turno1EU = 'E') then
    SettaTurnoNotturnoEU(TurnoNotturnoE,l08_Turno1)
  else if (pianif = 'si') and (l08_Turno2 > 0) and (l08_Turno2EU = 'E') then
    SettaTurnoNotturnoEU(TurnoNotturnoE,l08_Turno2);
  if (pianif = 'si') and (l08_Turno1 > 0) and (l08_Turno1EU = 'U') then
    SettaTurnoNotturnoEU(TurnoNotturnoU,l08_Turno1)
  else if (pianif = 'si') and (l08_Turno2 > 0) and (l08_Turno2EU = 'U') then
    SettaTurnoNotturnoEU(TurnoNotturnoU,l08_Turno2);
  //Lettura timbrature nominali
  n_timbrnom:=0;
  turnicavmez:='no';
  cdsT021.First;
  i:=0;
  while not cdsT021.Eof do
  begin
    if cdsT021.FieldByName('TIPO_FASCIA').AsString <> TF_PUNTI_NOMINALI then
    begin
      cdsT021.Next;
      Continue;
    end;
    inc(i);
    //Ripristino turni originali se modificati dopo la prima lettura
    if cdsT021.FieldByName('USCITAMM').AsInteger >= 1440 then
    begin
      cdsT021.Edit;
      cdsT021.FieldByName('USCITAMM').AsInteger:=cdsT021.FieldByName('USCITAMM').AsInteger - 1440;
      cdsT021.Post;
    end;
    //4.0 Registrazione turno notturno indipendentemente dalla pianificazione
    if (ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,-1] <= ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,-1]) and (not TurnoNotturnoTrovato) then
    begin
      TurnoNotturno.E:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,-1];
      TurnoNotturno.U:=1440 + ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,-1];
      TurnoNotturno.Ritardo:=R180OreMinutiExt(cdsT021.FieldByName('MMRITARDOU').AsString);
      TurnoNotturno.Num:=0;
    end;
    TurnoEU:='';
    if (pianif = 'si') and (l08_Turno1 > 0) and
       (i <> l08_Turno1) and (i <> l08_Turno2) then
    begin
      cdsT021.Next;
      Continue;
    end;
    //Alberto 27/09/1999: Lettura dello spezzone di turno notturno pianificato
    if (pianif = 'si') and (i = l08_Turno1) then
      TurnoEU:=l08_Turno1EU;
    if (pianif = 'si') and (i = l08_Turno2) then
      TurnoEU:=l08_Turno2EU;
    //Alberto 12/10/2009: in caso di pianificazione riconosco se ho pianificato un turno notturno, nel qual caso evito di scrivere in TurnoNotturno altre notti diverse da quella pianificata (serve nel caso il modello orario contenga più notti)
    if (pianif = 'si') and (TurnoNotturno.E = ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,-1]) and (TurnoNotturno.U = 1440 + ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,-1]) then
    begin
      TurnoNotturnoTrovato:=True;
    end;

    //Se pianifico sia E che U (necessario per il frazionamento debito), leggo i punti nominali sia di E che di U
    if (pianif = 'si') and (i = l08_Turno1) and
       (l08_Turno1 = l08_Turno2) and
       ((l08_Turno1EU = 'E') and (l08_Turno2EU = 'U') or
        (l08_Turno1EU = 'U') and (l08_Turno2EU = 'E')) then
      TurnoEU:='';
    inc(n_timbrnom);
    SetLength(ttimbraturenom,n_timbrnom + 1);
    ttimbraturenom[n_timbrnom]:=ttimbraturenom_vuota;
    ttimbraturenom[n_timbrnom].tminutin_e:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,-1];
    ttimbraturenom[n_timbrnom].tpuntre:=i;
    //Gestione cavallo mezzanotte sdoppiando timbrature nominali
    if (not NotteSuEntrata) and (cdsT021.FieldByName('USCITAMM').AsInteger = 0) then
    begin
      cdsT021.Edit;
      cdsT021.FieldByName('USCITAMM').AsInteger:=1440;
      cdsT021.Post;
    end;
    if (cdsT021.FieldByName('USCITAMM').AsInteger <= cdsT021.FieldByName('ENTRATAMM').AsInteger) then
    begin
      ttimbraturenom[n_timbrnom].tminutin_e_ori:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,-1];
      ttimbraturenom[n_timbrnom].tminutin_u_ori:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,-1];
      //4.0
      if not NotteSuEntrata then
      begin
        turnicavmez:='si';
        ttimbraturenom[n_timbrnom].tminutin_u:=1440;
        ttimbraturenom[n_timbrnom].tpuntru:=0;
      end
      else
      begin
        ttimbraturenom[n_timbrnom].tminutin_u:=1440 + ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,-1];
        ttimbraturenom[n_timbrnom].tpuntru:=i;
        if TurnoEU = 'E' then
        begin
          cdsT021.Edit;
          cdsT021.FieldByName('USCITAMM').AsInteger:=1440 + cdsT021.FieldByName('USCITAMM').AsInteger;//ttimbraturenom[n_timbrnom].tminutin_u;
          cdsT021.Post;
        end
        else if TurnoEU = 'U' then
        begin
          ttimbraturenom[n_timbrnom].EntrataNomPrec:=ttimbraturenom[n_timbrnom].tminutin_e;
          ttimbraturenom[n_timbrnom].PuntreNomPrec:=ttimbraturenom[n_timbrnom].tpuntre;
          ttimbraturenom[n_timbrnom].tminutin_e:=0;
          ttimbraturenom[n_timbrnom].tpuntre:=0; //Alberto 09/01/2009: aggiunto per FIRENZE_COMUNE per gestire il turno notturno pianificato con 'U' - serve in generale quando l'orari prevede più di un turno notturno
        end;
      end;
      if TurnoEU = '' then
      begin
        inc(n_timbrnom);
        SetLength(ttimbraturenom,n_timbrnom + 1);
        ttimbraturenom[n_timbrnom]:=ttimbraturenom_vuota;
        ttimbraturenom[n_timbrnom].tminutin_e:=0;
        ttimbraturenom[n_timbrnom].tpuntre:=0;
        ttimbraturenom[n_timbrnom].tminutin_e_ori:=ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,-1];
        ttimbraturenom[n_timbrnom].tminutin_u_ori:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,-1];
      end;
    end;
    ttimbraturenom[n_timbrnom].tminutin_u:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,-1];
    ttimbraturenom[n_timbrnom].tpuntru:=i;
    if cdsT021.FieldByName('USCITAMM').AsInteger > 1440 then
    begin
      cdsT021.Edit;
      cdsT021.FieldByName('USCITAMM').AsInteger:=cdsT021.FieldByName('USCITAMM').AsInteger - 1440;
      cdsT021.Post;
    end;
    //Alberto 27/09/1999: Gestione dello spezzone di turno notturno pianificato
    if (turnicavmez = 'si') and (TurnoEU = 'E') then
    begin
      ttimbraturenom[n_timbrnom].tminutin_u:=1440;
      ttimbraturenom[n_timbrnom].tpuntru:=0;
    end;
    if (turnicavmez = 'si') and (TurnoEU = 'U') then
    begin
      ttimbraturenom[n_timbrnom].EntrataNomPrec:=ttimbraturenom[n_timbrnom].tminutin_e;
      ttimbraturenom[n_timbrnom].PuntreNomPrec:=ttimbraturenom[n_timbrnom].tpuntre;
      ttimbraturenom[n_timbrnom].tminutin_e:=0;
      ttimbraturenom[n_timbrnom].tpuntre:=0;
    end;
    cdsT021.Next;
  end;
  //Ordinamento timbrature nominali
  z286_ordintimbrn;

  //Alberto 19/11/2019 - Genova_Comune: Se c'è la pianificazione di soli turni diurni (not TurnoNotturnoTrovato)
  //ma l'orario prevede turni a cavallo di mezzanotte, si può evitare di considerarli (STR_NOTTE_SPEZZATO=S)
  //in modo che eventuali timbrature fuori orario a cavallo di mezzanotte rimangano spezzate sui 2 gg.
  if (pianif = 'si') and (not TurnoNotturnoTrovato) and
     (cdsT020.FindField('STR_NOTTE_SPEZZATO') <> nil) and (cdsT020.FieldByName('STR_NOTTE_SPEZZATO').AsString = 'S') then
    TurnoNotturno.Num:=-1;
  //Associazione del TurnoNotturno ai punti nominali dell'orario
  for i:=1 to n_timbrnom do
  begin
    if (TurnoNotturno.Num = 0) and (ttimbraturenom[i].tminutin_e = TurnoNotturno.E) and (ttimbraturenom[i].tminutin_u = TurnoNotturno.U) then
      TurnoNotturno.Num:=i;
    if (TurnoNotturnoE.Num = 0) and (ttimbraturenom[i].tminutin_e = TurnoNotturnoE.E) and (ttimbraturenom[i].tminutin_u = TurnoNotturnoE.U) then
      TurnoNotturnoE.Num:=i;
    if (TurnoNotturnoU.Num = 0) and (ttimbraturenom[i].tminutin_e = TurnoNotturnoU.E) and (ttimbraturenom[i].tminutin_u = TurnoNotturnoU.U) then
      TurnoNotturnoU.Num:=i;
  end;
  if TurnoNotturnoE.Num = -1 then
    TurnoNotturnoE:=TurnoNotturno;
  if TurnoNotturnoU.Num = -1 then
    TurnoNotturnoU:=TurnoNotturno;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z284_contrpianif;
{Controllo pianificazione turno}
begin
  if l08_Turno1 <= 0 then exit;
  if l08_Turno1 > 99 then
  begin
    blocca:=7;
    exit;
  end;
  if (l08_Turno1 > 0) and (ValStrT021['ENTRATA',TF_PUNTI_NOMINALI,l08_Turno1] = '') then
  begin
    blocca:=7;
    exit;
  end;
  if (l08_Turno2 > 0) and (ValStrT021['ENTRATA',TF_PUNTI_NOMINALI,l08_Turno2] = '') then
    blocca:=7;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z286_ordintimbrn;
{Ordinamento timbrature nominali}
var comodo1:t_ttimbraturenom;
    i,nt:Integer;
begin
  for i:=1 to n_timbrnom do
    for nt:=i + 1 to n_timbrnom do
    //z288_ordintimbrc;
    begin
      if not((ttimbraturenom[nt].tminutin_e > ttimbraturenom[i].tminutin_e) or
        ((ttimbraturenom[nt].tminutin_e = ttimbraturenom[i].tminutin_e) and
         (ttimbraturenom[nt].tminutin_u > ttimbraturenom[i].tminutin_u))) then
      begin
        comodo1:=ttimbraturenom[i];
        ttimbraturenom[i]:=ttimbraturenom[nt];
        ttimbraturenom[nt]:=comodo1;
      end;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z300_giustdaa;
{Gestione globale giustificativi dalle alle}
begin
  tcausale.tcaus:=tgius_dallealle[iag].tcausdaa;
  z964_leggicaus(tcausale.tcaus);
  if s_trovato = 'no' then
  begin
    z098_anom2caus(17);
    exit;
  end
  else if (chiamante = 'Assenze') and (parcaus.l29_1paramet <> 'A') then
    exit;
  if parcaus.l29_1paramet = 'C' then
  //Giustificativo con causale giustificativo (anomalia)
  begin
    z098_anom2caus(18);
    end
  else if parcaus.l29_1paramet = 'B' then
  //Giustificativo di presenza
  begin
    if ValStrT275[tcausale.tcaus,'TIPOCONTEGGIO'] = 'A' then
    begin
      z098_anom2caus(18);
    end
    else
    begin
      z965_SettaCausPres(tcausale);
      //Verifica se causale abilitata
      z068_causpresab;
      if tcausale.tcausabi = 'no' then
      begin
        z098_anom2caus(4);
      end
      else
      begin
        minpresenzelorde:=minpresenzelorde + Max(0,tgius_dallealle[iag].tminutia - tgius_dallealle[iag].tminutida);
        indice:=1;
        z816_insetimbr;
        ieu:=1;
        ttimbraturedip[1]:=ttimbraturedip_vuota;
        ttimbraturedip[1].tminutid_e:=tgius_dallealle[iag].tminutida;
        ttimbraturedip[1].tminutid_u:=tgius_dallealle[iag].tminutia;
        ttimbraturedip[1].tcausale_e:=tcausale;
        ttimbraturedip[1].tcausale_u:=tcausale;
        ttimbraturedip[1].tpuntnomin:=0;
        ttimbraturedip[1].tflagarr_e:='si';
        ttimbraturedip[1].tflagarr_u:='si';
        ttimbraturedip[1].tag:='TG=D';
        aum862:='si';
        //Riepilogo e inclusione/esclusione ore normali
        ieu:=1;
        z820_coppiecaus;
        //ttimbraturedip[1].tag:='';
        //z824_riepincesc;
      end;
    end;
  end
  else
  //Giustificativo di assenza
  //Impostazione dati causale di assenza
  begin
    if (Chiamante <> 'Assenze') and (ValStrT265[tcausale.tcaus,'FRUIZ_INTERNA_PN'] = 'S') then
    begin
      if tgius_dallealle[iag].tminutida <> max(tgius_dallealle[iag].tminutida,EntrataTeorica) then
      begin
        z098_anom2caus(64,Format('%s dalle %s -> %s',[tgius_dallealle[iag].tcausdaa,R180MinutiOre(tgius_dallealle[iag].tminutida),R180MinutiOre(EntrataTeorica)]));
        tgius_dallealle[iag].tminutida:=EntrataTeorica;
      end;
      if tgius_dallealle[iag].tminutia <> min(tgius_dallealle[iag].tminutia,UscitaTeorica) then
      begin
        z098_anom2caus(64,Format('%s alle %s -> %s',[tgius_dallealle[iag].tcausdaa,R180MinutiOre(tgius_dallealle[iag].tminutia),R180MinutiOre(UscitaTeorica)]));
        tgius_dallealle[iag].tminutia:=UscitaTeorica;
      end;
    end;
    z344_inpcausass;
    //causfl:=tgius_dallealle[iag].tfldaa;
    tipogasse:=0;
    //Gestione globale giustificativo di assenza
    z350_gestglobass;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z310_giustore;
{Gestione globale giustificativi in numero ore}
begin
  tcausale.tcaus:=tgius_min[iag].tcausore;
  z964_leggicaus(tcausale.tcaus);
  if s_trovato = 'no' then
  begin
    z098_anom2caus(17);
  end
  else if not((chiamante = 'Assenze') and (parcaus.l29_1paramet <> 'A')) then
  begin
    if parcaus.l29_1paramet = 'C' then
    //Giustificativo con causale giustificativo (anomalia)
    begin
      z098_anom2caus(18);
    end
    else if parcaus.l29_1paramet = 'B' then
    //Giustificativo di presenza
    begin
      if ValStrT275[tcausale.tcaus,'TIPOCONTEGGIO'] = 'A' then
      begin
        z098_anom2caus(18);
      end
      else
      begin
        z965_SettaCausPres(tcausale);
        tcausale.tcausrip:='A';
        //Verifica se causale abilitata
        z068_causpresab;
        if tcausale.tcausabi = 'no' then
        begin
          z098_anom2caus(4);
        end
        else
        //Giustificativo di presenza in numero ore
        begin
          minpresenzelorde:=minpresenzelorde + tgius_min[iag].tmin;
          indice:=1;
          z816_insetimbr;
          ieu:=1;
          ttimbraturedip[1]:=ttimbraturedip_vuota;
          ttimbraturedip[1].tcausale_e:=tcausale;
          ttimbraturedip[1].tcausale_u:=tcausale;
          ttimbraturedip[1].tpuntnomin:=0;
          ttimbraturedip[1].tag:='TG=N';
          aum862:='si';
          mingiuore:=tgius_min[iag].tmin;
          while mingiuore <> 0 do
            z312_giusprenore;
          //ttimbraturedip[1].tag:='';
        end;
      end;
    end
    else
    //Giustificativo di assenza
    //Impostazione dati causale di assenza
    begin
      z344_inpcausass;
      //causfl:=tgius_min[iag].tflore;
      tipogasse:=1;
      //Gestione globale giustificativo di assenza
      z350_gestglobass;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z312_giusprenore;
{Giustificativo di presenza in numero ore
 Le ore vengono assegnate alle fascia piu' bassa
 eventualmente eseguendo piu' cicli}
begin
  comodo2:=tfasceorarie[fasciabass].tfine1fasc - tfasceorarie[fasciabass].tiniz1fasc;
  ttimbraturedip[1].tminutid_e:=tfasceorarie[fasciabass].tiniz1fasc;
  if mingiuore > comodo2 then
  begin
    ttimbraturedip[1].tminutid_u:=tfasceorarie[fasciabass].tfine1fasc;
    dec(mingiuore,comodo2);
  end
  else
  begin
    ttimbraturedip[1].tminutid_u:=tfasceorarie[fasciabass].tiniz1fasc + mingiuore;
    mingiuore:=0;
  end;
  //Riepilogo e inclusione/esclusione ore normali
  ieu:=1;
  z820_coppiecaus;
  //z824_riepincesc;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z320_giustmgass;
{Gestione globale giustificativi mezza giornata assenza}
begin
  tcausale.tcaus:=tgius_mgass[iag].tcausmgass;
  //causfl:=tgius_mgass[iag].tflmgass;
  tipogasse:=2;
  //Gestione giustificativi mezza giornata o giornata assenza
  z340_giumgggass;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z330_giustggass;
{Gestione globale giustificativi giornata intera assenza}
begin
  tcausale.tcaus:=tgius_ggass[iag].tcausggass;
  //causfl:=tgius_ggass[iag].tflggass;
  tipogasse:=3;
  //Gestione giustificativi mezza giornata o giornata assenza
  z340_giumgggass;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z340_giumgggass;
{Gestione giustificativi mezza giornata o giornata assenza}
begin
  z964_leggicaus(tcausale.tcaus);
  if s_trovato = 'no' then
  begin
    z098_anom2caus(17);
  end
  else if parcaus.l29_1paramet <> 'A' then
  //Giustificativo non di assenza
  begin
    z098_anom2caus(18);
  end
  else
  //Impostazione dati causale di assenza
  begin
    z344_inpcausass;
    if tipogasse = 3 then
      tgius_ggass[iag].tipocumulo:=tipocumulo;
    if (tipogasse = 3) and (n_giusgga >= 2) and (iag = 1) and ((causinf = 'G') or (causinf = 'I')) and (invcausggass = 'no') then
    begin
      //In caso di due giornate intere di assenza, quella eventuale
      //con influenza sui conteggi uguale a "G" o "I" deve essere gestita
      //per seconda
      tgius_ggass[5]:=tgius_ggass[1];
      tgius_ggass[1]:=tgius_ggass[2];
      tgius_ggass[2]:=tgius_ggass[5];
      iag:=0;
      invcausggass:='si';
    end
    else
    begin
      //Gestione globale giustificativo di assenza
      z350_gestglobass;
      if tipogasse = 3 then
        tgius_ggass[iag].mmresi:=minresass
      else
        tgius_mgass[iag].mmresi:=minresass;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z342_valggass;
{Calcolo valorizzazione giornata di assenza}
var r_minuti180:Integer;
  function OrePianifLibProf:Integer;
  {la valenza oraria è data dalla somma delle pianificazioni in libera professione, decurtando poi eventuale intervallo di pausa mensa calcolato dalla function USR_T320F_OREPIANIF_PM}
  var IT,FT:Integer;
  begin
    Result:=0;
    if cdsT320.Locate('Data',DataCon,[]) then
    begin
      while (not cdsT320.Eof) and (cdsT320.FieldByName('DATA').AsDateTime = DataCon) do
      begin
        IT:=R180OreMinutiExt(cdsT320.FieldByName('Dalle').AsString);
        FT:=R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString);
        inc(Result,FT - IT);
        cdsT320.Next;
      end;

      with TOracleQuery.Create(Self) do
      try
        Session:=SessioneOracle;
        SQL.Add('select USR_T320F_OREPIANIF_PM(:PROGRESSIVO,:DATA,:ORARIO) from dual');
        DeclareAndSet('PROGRESSIVO',otInteger,progrcon);
        DeclareAndSet('DATA',otDate,datacon);
        DeclareAndSet('ORARIO',otString,c_orario);
        Execute;
        dec(Result,FieldAsInteger(0));
      finally
        Free;
      end;
    end;
  end;
  function GetValggAss(Tipo:string):Integer;
  begin
    Result:=0;
    if Tipo = 'A' then
    //Lettura monte ore settimanale del dipendente
    begin
      if monteorelet <> 'si' then
        z172_monteore;
      if blocca = 0 then
        try
          Result:=minmonteore div giornlav;
        except
          Result:=0;
        end;
    end
    else if Tipo = 'C' then
    //Lettura monte ore settimanale del dipendente
    begin
      while monteorelet <> 'si' do
        z172_monteore;
      if blocca = 0 then
        Result:=minmonteore div 6;
    end
    else if Tipo = 'B' then
    //Scelta orario
    begin
      while orarioacq <> 'si' do
        z500_orarfac;
      if blocca = 0 then
      begin
        //Calcolo debito da modello di orario
        z346_debdaorar(r_minuti180);
        Result:=r_minuti180;
      end;
    end
    else if Tipo = 'E' then
    begin
      Result:=debitogg;
      if (RicalcoloMaxScostPos > 0) and (Name <> 'R502Ricorsivo') then
        Result:=min(debitogg,RicalcoloMaxScostPos);
    end;
  end;
begin
  valggass:=0;
  try
    (*Alberto 30/07/2008: obsoleto, non serve più questo parametro
    if c_ValorGior <> '' then
      causval:=c_ValorGior;*)
    if causval = 'D' then
      if (Q430.FieldByName('HTeoriche').AsString = '0') or (Q430.FieldByName('HTeoriche').AsString = '3') then
        causval:='A'
      else
        causval:='B';

    if (XParam[XP_COHSA_FERIE_SUMAI] or XParam[XP_LIBPROF_SUMAI]) and (causass = '90000') and (tipogasse = 3) then
      valggass:=OrePianifLibProf
    else if causval = 'F' then
      valggass:=ProporzionaPartTime('VALORGIOR_ORE_PROPPT',ValStrT265[causass,'VALORGIOR_ORE'].ToInteger)
    else
      valggass:=GetValggAss(causval);
  finally
    valggcompass:=valggass;
  end;

  //Alberto 23/05/2018 - CCNL 2018
  //causvalcomp:=ValStrT265[causass,'VALORGIOR_COMP'];
  if causvalcomp = '-' then
    causvalcomp:=causval
  else if causvalcomp = 'D' then
  begin
    if (Q430.FieldByName('HTeoriche').AsString = '0') or (Q430.FieldByName('HTeoriche').AsString = '3') then
      causvalcomp:='A'
    else
      causvalcomp:='B';
  end;

  if causvalcomp = 'F' then
    valggcompass:=ProporzionaPartTime('VALORGIOR_ORE_PROPPT',ValStrT265[causass,'VALORGIOR_ORECOMP'].ToInteger)
  else if causvalcomp = causval then
    valggcompass:=valggass
  else
    valggcompass:=GetValggAss(causvalcomp);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z344_inpcausass;
{Impostazione dati causale di assenza}
begin
  causass:=tcausale.tcaus;
  causrag:=parcaus.l29_Ragg;
  causgnl:=parcaus.l29_3paramet;
  causinf:=parcaus.l29_4paramet;
  //causval:=parcaus.l29_5paramet;
  causipo:=parcaus.l29_6paramet;
  causrpl:=parcaus.l29_7paramet;
  //causgga:=StrToIntDef(parcaus.l29_8paramet,0);
  causesclusa:=parcaus.l29_10paramet;
  //causind:=parcaus.l29_11paramet;
  causstr:=parcaus.l29_12paramet;
  causmis:=parcaus.l29_13paramet;
  causestimb:=parcaus.l29_15paramet;
  tipocumulo:=parcaus.l29_16paramet;
  causpag:='';

  causval:=ValStrT265[causass,'VALORGIOR'];
  causvalcomp:=ValStrT265[causass,'VALORGIOR_COMP'];
  causgga:=R180OreMinuti(ValStrT265[causass,'HMASSENZA']);
  causind:=ValStrT265[causass,'INDPRES'];
end;
//_________________________________________________________________
procedure TR502ProDtM1.z346_debdaorar(var r_minuti180:Integer);
{Calcolo debito da modello di orario}
begin
  if c_orario = '' then
    r_minuti180:=0
  else if (TipoOrario = 'A') or (TipoOrario = 'B') or (TipoOrario = 'C') or (TipoOrario = 'D') then
    r_minuti180:=z189_debito_ggass(ValNumT020['OreTeor'])
  else if TipoOrario = 'E' then
  begin
    if (pianif = 'si') and (l08_Turno1 > 0) then
    begin
      r_minuti180:=z189_debito_ggass(ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_Turno1]);
      //Nel caso di frazionamento debito con indicazione di ore teoriche sui 2 spezzoni, utilizzo le ore teoriche corrispondenti
      if  (cdsT020.FieldByName('FrazDeb').AsString = 'S')
      and (ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_turno1] > 0)
      and (ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,l08_turno1] <= ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,l08_turno1])
      and (ValStrT021['ENTRATA',TF_PUNTI_NOMINALI,l08_turno1] <> '')
      then
        if l08_turno1EU = 'E' then
          r_minuti180:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_Turno1]
        else if l08_turno1EU = 'U' then
          r_minuti180:=ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_Turno1]
        else if l08_turno1EU = '' then
          r_minuti180:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,l08_Turno1] + ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,l08_Turno1];
    end
    else
      r_minuti180:=z189_debito_ggass(ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,1]);
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.GiustificativiR600_Indice(tga,i:Integer):Integer;
begin
  Result:=-1;
  if not ConteggiaGiustificativiR600 then
    exit;

  if (tga = 0) and (i <= n_giusdaa) then
    Result:=tgius_dallealle[i].PuntGiustR600
  else if (tga = 1) and (i <= n_giusore) then
    Result:=tgius_min[i].PuntGiustR600
  else if (tga = 2) and (i <= n_giusmga) then
    Result:=tgius_mgass[i].PuntGiustR600
  else if (tga = 3) and (i <= n_giusgga) then
    Result:=tgius_ggass[i].PuntGiustR600;

  if (Result < 0) or (Result > High(GiustificativiR600)) then
    Result:=-1;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z350_gestglobass;
var iGR600:Integer;
    FruizConiuge:Boolean;
  function MaturaIndPres:Boolean;
  begin
    Result:=False;
    if causind = 'S' then
    begin
      Result:=True;
      if ValStrT265[causass,'INDPRES_FESTIVO'] = 'N' then
        Result:=(tipogg = 'N') and (giorsett <> 7);
    end;
  end;
begin
  if (gglav = 'no') and (causgnl = 'A') then exit;

  FruizConiuge:=False;
  iGR600:=GiustificativiR600_Indice(tipogasse,iag);
  if iGR600 >= 0 then
    FruizConiuge:=GiustificativiR600[iGR600].Coniuge;
  //Se non lavorativo da calendario, il nuovo parametro Influenza giorno non lavorativo = 'D' se part-time verticale segue comportamento di 'A' = Ininfluente
  if (not FruizConiuge) and (tipogglav = 'N') and (causgnl = 'D') and (VarToStr(Q460.Lookup('Codice',Q430.FieldByName('PARTTIME').AsString,'TIPO')) = 'V') then
  begin
    if iGR600 >= 0 then
      GiustificativiR600[iGR600].causgnl_PTV:=True;
    exit;
  end;
  //Per la gestione della malattia percentualizzato su part-time verticale che prevede il calcolo del fruito sui giorni lavorativi + sabato, domenica e festivi
  //Nuovo valore parametro Influenza giorno non lavorativo = 'E' in caso part-time verticale segue comportamento di 'A' = Ininfluente se: giorno non lavorativo e lavorativo (da lun.a ven.) per tempo pieno e non festivo
  if (causgnl = 'E') and (VarToStr(Q460.Lookup('Codice',Q430.FieldByName('PARTTIME').AsString,'TIPO')) = 'V') and (gglav = 'no') and (giorsett in [1..5]) and (tipogg <> 'F') then
  begin
    if iGR600 >= 0 then
      GiustificativiR600[iGR600].causgnl_PTV:=True;
    exit;
  end;

  if tipogasse = 3 then
    //Giustificativo giornata intera assenza
    if (causrag <> traggrcausas[8].C) and (n_timbrdip <> 0) and (not conteggi_sologiust) and (ValStrT265[tcausale.tcaus,'CHECK_SOLOCOMPETENZE'] <> 'S') then
    //Giornata non di riposo con presenza di timbrature
    begin
      z098_anom2caus(22);
    end;
  if tipogasse = 0 then
  //Giustificativo dalle alle
  begin
    ieu:=1;
    indice:=1;
    z816_insetimbr;
    ttimbraturedip[1]:=ttimbraturedip_vuota;
    ttimbraturedip[1].tminutid_e:=tgius_dallealle[iag].tminutida;
    ttimbraturedip[1].tminutid_u:=tgius_dallealle[iag].tminutia;
    ttimbraturedip[1].Tag:='TG=ASSENZA';
    //Gestione giorno con eventuale conteggio parziale
    z826_gesggparz;
    if ttimbraturedip[1].tminutid_e = ttimbraturedip[1].tminutid_u then exit;
  end;
  //inizializzazione data familiare di riferimento per mantenere distinte fruizioni di stessa causale riferiti a famialiari diversi
  case tipogasse of
    0:CausDataFamiliare:=tgius_dallealle[iag].DataFamiliare;
    1:CausDataFamiliare:=tgius_min[iag].DataFamiliare;
    2:CausDataFamiliare:=tgius_mgass[iag].DataFamiliare;
    3:CausDataFamiliare:=tgius_ggass[iag].DataFamiliare;
  end;
  //Calcolo flag per dati paghe Valduce in base ad assenze
  if causpag = 'A' then
    z356_calflpagass;
  //Riepilogo giustificativi assenza (Modif.Alberto: tutte le assenze sono riepilogate)
  z390_riepasse;
  if blocca <> 0 then exit;
  //Gestione influenza sui conteggi
  z352_infsuicont;
  //Esco anche per influenza giorno non lavorativo = 'D' in quanto ai fini dei conteggi di ore e indennità equivale a C
  if (gglav = 'no') and ((causgnl = 'C') or (causgnl = 'D')) then exit;
  //Gestione influenza sul plus orario
  if causipo <> 'B' then
    z354_infsulplor;
  //Gestione maturazione indennita' di presenza
  if MaturaIndPres then
  begin
    if tipogasse = 3 then
      indpresdaass:='si'
    else
      inc(minlavpresoggi,minresass);
  end;
  //Gestione influenza sullo straordinario liquidabile
  if causstr = 'A' then
    inc(minabbstr,minvalass);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z352_infsuicont;
{Gestione influenza sui conteggi}
var App,App2,FruizMin,FruizArr,minvalcompass:Integer;
    i,j,e,u:Integer;
begin
  if (causinf = 'G') or (causinf = 'I') then
    z752_lavscostgg;
  minresass:=0;
  minass_oltredebito:=0;
  if tipogasse = 0 then
  //Giustificativo dalle alle
  begin
    e:=ttimbraturedip[1].tminutid_e;
    u:=ttimbraturedip[1].tminutid_u;
    //Alberto 05/11/2009 - TORINO_COMUNE: Gestione dell'accavallamento di giustificativi che aumentano le ore con causali escluse dalle normali (che sono anche esterne all'orario, ma non viene fatto questo controllo)
    //L'esigenza è di conteggiare solo le causali escluse, che danno origine a straordinario
    if cdsT020.FieldByName('INTERSEZ_AUTOGIUST').AsString = 'S' then
      if (ValStrT265[causass,'INTERSEZIONE_TIMBRATURE'] <> 'T') and not(R180CarattereDef(causinf) in ['B','D']) then
        for i:=1 to n_rieppres do
          if (triepgiuspres[i].tcauspres <> '') and (not(R180CarattereDef(ValStrT275[triepgiuspres[i].tcauspres,'TIPOCONTEGGIO']) in ['A','E'])) then
            for j:=0 to High(triepgiuspres[i].CoppiaEU) do
            begin
              if (triepgiuspres[i].CoppiaEU[j].e < ttimbraturedip[1].tminutid_u) and
                 (triepgiuspres[i].CoppiaEU[j].u > ttimbraturedip[1].tminutid_e) then
                ttimbraturedip[1].tminutid_u:=max(ttimbraturedip[1].tminutid_e,triepgiuspres[i].CoppiaEU[j].e);
              if (triepgiuspres[i].CoppiaEU[j].u > ttimbraturedip[1].tminutid_e) and
                 (triepgiuspres[i].CoppiaEU[j].e < ttimbraturedip[1].tminutid_u) then
                ttimbraturedip[1].tminutid_e:=min(ttimbraturedip[1].tminutid_u,triepgiuspres[i].CoppiaEU[j].u);
            end;
    minvalass:=ttimbraturedip[1].tminutid_u - ttimbraturedip[1].tminutid_e;
    //if (causinf = 'G') and (totlav + minvalass > debitogg) and ((chiamante <> 'Assenze') or (ValStrT265[causass,'CUMULO_TIPO_ORE'] = '1')) then
    if (causinf = 'G') and (totlav + minvalass > debitogg) and (chiamante <> 'Assenze') then
    begin
      //da confermare per evitare doppia detrazione se c'è anche detrazione pausa mensa --> minass_oltredebito:=min(minvalass,totlav + minvalass - debitogg);
      minvalass:=debitogg - totlav;
      if minvalass < 0 then
        minvalass:=0;
      ttimbraturedip[1].tminutid_u:=ttimbraturedip[1].tminutid_e + minvalass;
    end;
    if (causinf = 'I') and (minassenze + minvalass > debitogg) and (chiamante <> 'Assenze') then
    begin
      //da confermare per evitare doppia detrazione se c'è anche detrazione pausa mensa --> minass_oltredebito:=min(minvalass,minassenze + minvalass - debitogg);
      minvalass:=debitogg - minassenze;
      if minvalass < 0 then
        minvalass:=0;
      ttimbraturedip[1].tminutid_u:=ttimbraturedip[1].tminutid_e + minvalass;
    end;
    if (causinf <> 'B') and ((gglav = 'si') or (causgnl = 'B')) then
    begin
      if causinf = 'D' then
        aum862:='no'
      else
      begin
        aum862:='si';
        if causesclusa <> 'S' then
          inc(minassenze,minvalass);
        minresass:=minvalass;
        //Calcolo minuti resi in fasce per orario elastico
        z202_minfaselast;
      end;
      if (causestimb = 'N') or (Length(TimbratureOriginali) > 0) or TurnoNotturnoE.TimbGGDopo or
         ((Chiamante = 'Assenze') and (Q100.SearchRecord('Data',DataCon,[srFromBeginning]))) then
        z862_suddfascen;
    end;
    if (*causinf = '?X?'*)
       (causass = 'PMLAV') and XParam[XP_GIUST_PAUMENDET] then
    begin
      minvalass:=min(minvalass,paumendet);
      ttimbraturedip[1].tminutid_u:=ttimbraturedip[1].tminutid_e + minvalass;
    end;
    if (paumendet_giust > 0) and (ValStrT265[tgius_dallealle[iag].tcausdaa,'TIMB_PM'] = 'S') and (ValStrT265[tgius_dallealle[iag].tcausdaa,'TIMB_PM_DETRAZ'] = 'S') then
      if ((paumentimb_u = 0) and (paumentimb_e = 1440)) or (ttimbraturedip[1].tminutid_u = paumentimb_u) or (ttimbraturedip[1].tminutid_e = paumentimb_e) then
      begin
        App:=Min(FineMensa,ttimbraturedip[1].tminutid_u) - Max(InizioMensa,ttimbraturedip[1].tminutid_e);
        if App > 0 then
        begin
          App:=Min(App,paumendet_giust);
          App2:=ttimbraturedip[1].tminutid_u - ttimbraturedip[1].tminutid_e - App;
          FruizArr:=StrToIntDef(ValStrT265[tgius_dallealle[iag].tcausdaa,'FRUIZ_ARR'],0);
          FruizMin:=R180OreMinutiExt(ValStrT265[tgius_dallealle[iag].tcausdaa,'FRUIZ_MIN']);
          //Verifico che il giustificativo ridotto rispetti la fruizione minima
          if App2 < FruizMin then
          begin
            App:=Max(0,App - (FruizMin - App2));
            App2:=ttimbraturedip[1].tminutid_u - ttimbraturedip[1].tminutid_e - App;
          end;
          //Applico l'eventuale arrotondamento
          if FruizArr > 1 then
            App:=Max(0,App - (Trunc(R180Arrotonda(App2,FruizArr,'E')) - App2));
          //Alberto 04/01/2018: considero eventuale abbattimento già applicato dovuto al supero del debito
          dec(paumendet_giust,min(paumendet_giust,minass_oltredebito));
          dec(paumendet_resto,min(paumendet_resto,minass_oltredebito));
          dec(App,min(App,minass_oltredebito));
          //Alberto 04/01/2018 - fine
          dec(paumendet_giust,App);
          if causesclusa <> 'S' then
            dec(minassenze,min(App,minvalass));
          dec(minvalass,min(App,minvalass));
          dec(minresass,min(App,minresass));
          detrazioni:=min(App,paumendet_resto);
          z140_detrazioni(tminlav);
          dec(paumendet_resto,min(App,paumendet_resto));
        end;
      end
      else if (paumendet_resto > 0) and (ttimbraturedip[1].tminutid_e < FasciaMensa.PMTFineA) and (ttimbraturedip[1].tminutid_u > FasciaMensa.PMTInizioDa) then
      //se esiste ancora un resto di detrazione mensa, si cerca di detrarlo dalle ore normali rese dal giustificativo
      begin
        App:=min(minresass,paumendet_resto);
        App:=min(App,max(0,min(ttimbraturedip[1].tminutid_u,FasciaMensa.PMTFineA) - max(ttimbraturedip[1].tminutid_e,FasciaMensa.PMTInizioDa)));
        //Alberto 04/01/2018: considero eventuale abbattimento già applicato dovuto al supero del debito
        dec(paumendet_giust,min(paumendet_giust,minass_oltredebito));
        dec(paumendet_resto,min(paumendet_resto,minass_oltredebito));
        dec(App,min(App,minass_oltredebito));
        //Alberto 04/01/2018 - fine
        dec(minvalass,min(App,minvalass));
        dec(minresass,min(App,minresass));
        dec(paumendet_resto,App);
        detrazioni:=App;
        z140_detrazioni(tminlav);
      end;
    //Alberto 05/11/2009: Ripristino del giustificativo alterato perchè compaiano i punti Entrata-Uscita originali
    if cdsT020.FieldByName('INTERSEZ_AUTOGIUST').AsString = 'S' then
    begin
      ttimbraturedip[1].tminutid_e:=e;
      ttimbraturedip[1].tminutid_u:=u;
    end;
    if (minresass > 0) and
       (ValStrT265[causass,'ESCLUSIONE'] = 'S') and
       (cdsT020.FieldByName('CAUSALE_FASCE').AsString <> '') then
      z814_CausaliInFasce(cdsT020.FieldByName('CAUSALE_FASCE').AsString,ttimbraturedip[1].tminutid_e,ttimbraturedip[1].tminutid_u);
  end
  else if tipogasse = 1 then
  //Giustificativo in numero ore
  begin
    minvalass:=tgius_min[iag].tmin;
    //if (causinf = 'G') and (totlav + minvalass > debitogg) and ((chiamante <> 'Assenze') or (ValStrT265[causass,'CUMULO_TIPO_ORE'] = '1')) then
    if (causinf = 'G') and (totlav + minvalass > debitogg) and (chiamante <> 'Assenze') then
      minvalass:=debitogg - totlav;
    if (causinf = 'I') and (minassenze + minvalass > debitogg) and (chiamante <> 'Assenze') then
      minvalass:=debitogg - minassenze;
    if (*causinf = '?X?'*)
       (causass = 'PMLAV') and XParam[XP_GIUST_PAUMENDET] then
      minvalass:=min(minvalass,paumendet);
    if minvalass < 0 then
      minvalass:=0;
  end
  else if tipogasse = 2 then
  //Giustificativo mezza giornata assenza
  //Calcolo valorizzazione giornata di assenza
  begin
    z342_valggass;
    if tgius_mgass[iag].tmin = 0 then
      minvalass:=valggass div 2
    else
      minvalass:=tgius_mgass[iag].tmin;
    //if (causinf = 'G') and (totlav + minvalass > debitogg) and ((chiamante <> 'Assenze') or (ValStrT265[causass,'CUMULO_TIPO_ORE'] = '1')) then
    if (causinf = 'G') and (totlav + minvalass > debitogg) and (chiamante <> 'Assenze') then
      minvalass:=debitogg - totlav;
    if (causinf = 'I') and (minassenze + minvalass > debitogg) and (chiamante <> 'Assenze') then
      minvalass:=debitogg - minassenze;
    if minvalass < 0 then
      minvalass:=0;
    //Alberto 23/05/2018: Valorizzazione ai fini della fruizione delle competenze
    minvalcompass:=valggcompass div 2;
  end
  else if tipogasse = 3 then
  //Giustificativo giornata intera assenza
  //Calcolo valorizzazione giornata di assenza
  begin
    z342_valggass;
    minvalass:=valggass;
    //if (causinf = 'G') and (totlav + minvalass > debitogg) and ((chiamante <> 'Assenze') or (ValStrT265[causass,'CUMULO_TIPO_ORE'] = '1')) then
    if (causinf = 'G') and (totlav + minvalass > debitogg) and (chiamante <> 'Assenze') then
      minvalass:=debitogg - totlav;
    if (causinf = 'I') and (minassenze + minvalass > debitogg) and (chiamante <> 'Assenze') then
      minvalass:=debitogg - minassenze;
    if minvalass < 0 then
      minvalass:=0;
    //Alberto 23/05/2018: CCNL 2018 - Valorizzazione ai fini della fruizione delle competenze
    minvalcompass:=valggcompass;
  end;
  if tipogasse <> 0 then
    //Giustificativo diverso da dalle-alle
    if (causinf <> 'B') and ((gglav = 'si') or (causgnl = 'B')) then
      if causinf = 'D' then
      begin
        dec(tminlav[fasciabass],minvalass);
        //Alberto 24/07/2006
        if ValStrT265[causass,'ABBATTE_STRIND'] = 'S' then
          inc(tfasceorarie[fasciabass].AbbFascia,minvalass);
      end
      else
        if (causestimb = 'N') or (Length(TimbratureOriginali) > 0) or TurnoNotturnoE.TimbGGDopo or
           ((Chiamante = 'Assenze') and (Q100.SearchRecord('Data',DataCon,[srFromBeginning]))) then
        begin
          inc(tminlav[fasciabass],minvalass);
          if causesclusa <> 'S' then
            inc(minassenze,minvalass);
          minresass:=minvalass;
        end;
  //Parametro di validità: le ore sono rese solo se ci sono delle timbrature nel giorno
  if causestimb = 'S' then
  begin
    //if ((chiamante <> 'Assenze') or (ValStrT265[causass,'CUMULO_TIPO_ORE'] = '1')) and (Length(TimbratureOriginali) = 0) then
    if (Chiamante <> 'Assenze') and (Length(TimbratureOriginali) = 0) and (not TurnoNotturnoE.TimbGGDopo) then
    begin
      minvalass:=0;
      minvalcompass:=0;
      minresass:=0;
    end
    else if (Chiamante = 'Assenze') and (not Q100.SearchRecord('Data',DataCon,[srFromBeginning])) then
    begin
      minvalass:=0;
      minvalcompass:=0;
      minresass:=0;
    end;
  end;

  //Alberto 23/05/2018: CCNL 2018 - Valorizzazione ai fini della fruizione delle competenze
  //Se fruizione ad ore o comunque la valorizzazione competenze = valorizzazione giornaliera,
  //forzo la stessa valorizzazione usata per il cartellino
  if R180In(tipogasse,[0,1]) or
    ((causvalcomp = causval) and (causvalcomp <> 'F')) or
    (causvalcomp = '-')
  then
    minvalcompass:=minvalass;

  //Calcolo minuti resi da assenze solo compensabili
  if causinf = 'H' then
    inc(minasscomp,minresass);
  //Totalizzazione valorizzazione assenza in riepilogo
  i390:=0;
  repeat
    inc(i390);
  until (i390 > n_riepasse) or ((triepgiusasse[i390].tcausasse = causass) and (triepgiusasse[i390].DataFamiliare = CausDataFamiliare));
  if i390 <= n_riepasse then
  begin
    inc(triepgiusasse[i390].tminvalasse,minvalass);
    inc(triepgiusasse[i390].tminresasse,minresass);
    //Calcolo reso ai fini delle paghe a seconda dell'abilitazione della fruizione (giorni/ore)
    if (R180In(tipogasse,[0,1]) and (ValStrT265[triepgiusasse[i390].tcausasse,'SCARICOPAGHE_FRUIZ_ORE'] = 'S'))
       or
       (R180In(tipogasse,[2,3]) and (ValStrT265[triepgiusasse[i390].tcausasse,'SCARICOPAGHE_FRUIZ_GG'] = 'S'))
    then
    begin
      if R180CarattereDef(causinf) in ['B','D'] then
        triepgiusasse[i390].tminresoPaghe:=triepgiusasse[i390].tminresoPaghe + minvalass
      else
        triepgiusasse[i390].tminresoPaghe:=triepgiusasse[i390].tminresoPaghe + minresass;
    end;
    //Alberto 23/05/2018: CCNL 2018 - Valorizzazione ai fini della fruizione delle competenze
    inc(triepgiusasse[i390].tminvalcompasse,minvalcompass);
    i:=GiustificativiR600_Indice(tipogasse,iag);
    if i >= 0 then
    begin
       GiustificativiR600[i].minvalasse:=minvalass;
       GiustificativiR600[i].minresasse:=minresass;
       //Alberto 23/05/2018: CCNL 2018 - Valorizzazione ai fini della fruizione delle competenze
       GiustificativiR600[i].minvalcompasse:=minvalcompass;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z354_infsulplor;
{Gestione influenza sul plus orario}
begin
  if tipogasse = 3 then
    if causipo = 'A' then
      inc(tminlav[fasciabass],debitopoass)
    else
      debitopo:=0;
  if causipo = 'C' then
  begin
    detrdebitopo:=1;
    // il debito settimanale viene calcolato mensilmente come somma dei debiti
    // giornalieri, per cui in questo caso deve essere azzerato a livello giornaliero
    // attenzione: se però il debito agg. è individuale non viene abbattuto!
    // (il dato individuale infatti non deve essere modificato)
    if (debitoposm = 'S') and (debpoind = 'no') then
    begin
      debitopo:=0;
      debitopoass:=0;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z356_calflpagass;
{Calcolo flag per dati paghe Valduce in base ad assenze}
begin
{  if (causrin = 'A') and ((causrdl = 'A') or (causrdl = 'B')) then
    //Matura settimana retribuita INPS
    tflagasse[1]:=1;
  if tipogasse = 3 then
    if (causrin = 'B') or ((causrin = 'A') and (causrdl = 'C')) then
      //Abbatte giorno retribuito INPS
      tflagasse [2]:=1;
  if (caussrd = 'A') and (causrdl = 'B') then
    //Matura settimana ridotta INPS
    tflagasse[3]:=1;
  if (caussrd = 'A') and (causrdl = 'C') then
    //Presente assenza con Settimana ridotta = A e
    //Retribuzione datore lavoro = C
    tflagasse[4]:=1;
  if (tipogasse = 3) and (causret = 'B') then
    //Abbatte giorno retribuito
    tflagasse [5]:=1;
  if causmin = 'A' then
    //Abbatte giorno minimale INPS/INAIL
    tflagasse[6]:=1;
  if (tipogasse = 3) and (causdld = 'A') then
    //Abbatte giorno detrazione lavoro dipendente
    tflagasse[7]:=1;
  if (tipogasse = 3) and (causpin = 'A')
    //Abbatte giorno premio incentivazione
    tflagasse[8]:=1;}
end;
//_________________________________________________________________
procedure TR502ProDtM1.z390_riepasse;
var i:Integer;
//Riepilogo giustificativi assenza
begin
  i390:=0;
  repeat
    inc(i390);
  until (i390 > n_riepasse) or ((triepgiusasse[i390].tcausasse = causass) and (triepgiusasse[i390].DataFamiliare = CausDataFamiliare));
  if i390 > n_riepasse then
  begin
    inc(n_riepasse);
    i390:=n_riepasse;
    with triepgiusasse[i390] do
    begin
      tcausasse:=causass;
      DataFamiliare:=CausDataFamiliare;
      traggasse:=causrag;
      if causgga > 0 then
      begin
        thhmmasse:=causgga;
        //proporzionamento per PT in base a T230.HMASSENZA_PROPPT
        thhmmasse:=ProporzionaPartTime('HMASSENZA_PROPPT',thhmmasse);
      end
      else
      try
        thhmmasse:=minmonteore div giornlav;
      except
        thhmmasse:=0;
      end;
      tumisurasse:=causmis;
      tggasse:=0;
      tmezggasse:=0;
      tminasse:=0;
      tminvalasse:=0;
      tminvalcompasse:=0;
      tminresasse:=0;
      tminfruizasse:=0;
      tminfruitoPaghe:=0;
      tminresoPaghe:=0;
      tfiniretr:=0;
      ttipofruiz:=IfThen(tipogasse = 0,'D',IfThen(tipogasse = 1,'N',IfThen(tipogasse = 2,'M','I')));
    end;
    //Verifico se causale ininfluente ai fini retributivi
    if causinf = 'C' then
      triepgiusasse[i390].tfiniretr:=1;
  end;
  i:=GiustificativiR600_Indice(tipogasse,iag);
  if tipogasse = 0 then
  begin
    //Giustificativo dalle alle
    triepgiusasse[i390].tminasse:=triepgiusasse[i390].tminasse + ttimbraturedip[1].tminutid_u - ttimbraturedip[1].tminutid_e;
    triepgiusasse[i390].tminfruizasse:=triepgiusasse[i390].tminfruizasse + ttimbraturedip[1].tminutid_u - ttimbraturedip[1].tminutid_e;
    triepgiusasse[i390].tminfruitoPaghe:=triepgiusasse[i390].tminfruitoPaghe + ttimbraturedip[1].tminutid_u - ttimbraturedip[1].tminutid_e;
    if i >= 0 then
      GiustificativiR600[i].minasse:=ttimbraturedip[1].tminutid_u - ttimbraturedip[1].tminutid_e;
  end
  else if tipogasse = 1 then
  begin
    //Giustificativo in numero ore
    triepgiusasse[i390].tminasse:=triepgiusasse[i390].tminasse + tgius_min[iag].tmin;
    triepgiusasse[i390].tminfruizasse:=triepgiusasse[i390].tminfruizasse + tgius_min[iag].tmin;
    triepgiusasse[i390].tminfruitoPaghe:=triepgiusasse[i390].tminfruitoPaghe + tgius_min[iag].tmin;
    if i >= 0 then
      GiustificativiR600[i].minasse:=tgius_min[iag].tmin;
  end
  else if tipogasse = 2 then
  begin
    inc(triepgiusasse[i390].tmezggasse);
    if i >= 0 then
      GiustificativiR600[i].mezggasse:=1;
  end
  else if tipogasse = 3 then
  begin
    inc(triepgiusasse[i390].tggasse);
    if i >= 0 then
      GiustificativiR600[i].ggasse:=1;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z400_timbrat;
{Lettura timbrature e gestione parziale prima T=U
 o ultima T=E o 24 ore di lavoro}
var i:Integer;
begin
  timbraacq:='si';
  if chiamante = 'Cartellino' then
    //Lettura timbrature da matrice
    z412_timbratmat
  else
    //Lettura timbrature da archivio
    z402_timbratarc;
  Q100.Filtered:=False;
  if blocca <> 0 then exit;
  //Se la prima timbratura e' U = 00:00 la elimino
  if (primat_u = 'si') and (ttimbraturedip[1].tminutid_u = 0) and
     (estimbprec = 'si') and (verso_pre = 'E') then
  begin
    indice:=1;
    z802_toglitimbr;
    primat_u:='no';
  end;
  //Gestione parziale prima T=U o ultima T=E o 24 ore di lavoro
  z026_notteparz;
  if blocca <> 0 then exit;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z402_timbratarc;
{Lettura timbrature da archivio
 Start su due giorni precedenti l'attuale}
begin
  z926_starttimbr(datacon - 2);
  if s_trovato = 'no' then exit;
  //Lettura timbrature precedente, del giorno e successiva
  //Leggo subito la timbratura poichè la z926 esegue già la FindFirst
  timinuti:=l10_Ora;
  if datacon > l10_Data then
    //Lettura timbratura precedente al giorno attuale
    z406_timbrprec
  else
    if datacon = l10_Data then
      //Lettura timbratura del giorno attuale
      z408_timbrgior
    else
      //Lettura timbratura successiva al giorno attuale
      z410_timbrsucc;
  //Ciclo sulle timbrature
  while s_trovato = 'si' do
    z404_timbrcaric;
  (*
  repeat
    z404_timbrcaric;
  until (s_trovato = 'no');
  *)
end;
//_________________________________________________________________
procedure TR502ProDtM1.z404_timbrcaric;
{Lettura timbrature precedente, del giorno e successiva}
begin
  //Eseguo la FindNext
  z928_leggitimbr;
  if s_trovato = 'no' then exit;
  timinuti:=l10_Ora;
  if datacon > l10_Data then
    //Lettura timbratura precedente al giorno attuale
    z406_timbrprec
  else
    if datacon = l10_Data then
      //Lettura timbratura del giorno attuale
      z408_timbrgior
    else
      //Lettura timbratura successiva al giorno attuale
      z410_timbrsucc;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z406_timbrprec;
{Lettura timbratura precedente al giorno attuale}
begin
  estimbprec:='si';
  minuti_pre:=timinuti;
  verso_pre:=l10_Verso;
  rilev_pre:=l10_Rilevatore;
  caus_pre:=l10_Causale;
  data_pre:=l10_data;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z408_timbrgior;
{Lettura timbratura del giorno attuale}
var i:Integer;
    StessoVerso:Boolean;
begin
  //Controllo sequenza E - U
  StessoVerso:=False;
  if (n_timbrdip <> 0) and (versotiprec = l10_Verso) then
  begin
    blocca:=2;
    StessoVerso:=True;
  end;
  //if l10_Verso = 'E' then
  if (l10_Verso = 'E') or ((n_timbrdip <> 0) and (versotiprec = l10_Verso)) then
  begin
    if n_timbrdip < MaxTimbrature then  //Alberto 02/02/2010: limitato a MaxTimbrature
      inc(n_timbrdip);
  end
  else if n_timbrdip = 0 then
  //Prima timbratura = U
  begin
    inc(n_timbrdip);
    primat_u:='si';
  end;
  versotiprec:=l10_Verso;
  i:=Length(TimbratureDelGiorno);
  SetLength(TimbratureDelGiorno,i + 1);
  TimbratureDelGiorno[i].toratimb:=timinuti;
  TimbratureDelGiorno[i].tversotimb:=l10_Verso;
  TimbratureDelGiorno[i].trilevtimb:=l10_rilevatore;
  TimbratureDelGiorno[i].tcaustimb:=l10_Causale;
  TimbratureDelGiorno[i].tdagiustif:=False;
  //Gestione anomalia su rilevatori
  if (chiamante = 'Anomalie') or (chiamante = 'Servizio') or (chiamante = 'Cartolina') or (chiamante = 'Cartellino') then
    z428_contrrilev;
  if l10_Verso = 'E' then
  begin
    with ttimbraturedip[n_timbrdip] do
    begin
      tminutid_e:=timinuti;
      trilev_e:=l10_Rilevatore;
      tcausale_e:=tcausale_vuota;
      tcausale_e.tcaus:=l10_Causale;
      tflagarr_e:='no';
      if StessoVerso then
        ttimbraturedip[n_timbrdip - 1].tag:='U=null';
    end;
    //Ultima timbratura letta = E
    ultimt_e:='si';
  end
  else
    with ttimbraturedip[n_timbrdip] do
    begin
      //Gestione cambio ora legale/solare o vicecersa
      if (not OraLegaleSolare.Cambio) and
         (datacon = OraLegaleSolare.Data) and
         (tminutid_e < OraLegaleSolare.OraVecchia) and
         (timinuti >= OraLegaleSolare.OraNuova) and
         (MinutiDalle < OraLegaleSolare.OraVecchia) and
         (MinutiAlle >= OraLegaleSolare.OraVecchia) then
      begin
        oralegsol:=True;
        OraLegaleSolare.Cambio:=True;
        z098_anom2caus(63,Format('%s-%s',[R180MinutiOre(tminutid_e),R180MinutiOre(timinuti)]));
      end;
      tminutid_u:=timinuti;
      trilev_u:=l10_Rilevatore;
      tcausale_u:=tcausale_vuota;
      tcausale_u.tcaus:=l10_Causale;
      tflagarr_u:='no';
      if StessoVerso then
        ttimbraturedip[n_timbrdip].tag:='E=null';
      //Ultima timbratura letta = U
      ultimt_e:='no';
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z410_timbrsucc;
{Lettura timbratura successiva al giorno attuale}
begin
  s_trovato:='no';
  //Se timbratura successiva di oltre 2 giorni la ignoro
  //dec(r_n170,2);
  if Trunc(l10_Data - 2) > Trunc(numcorr) then exit;
  //Timbratura successiva per non piu' di 2 giorni
  estimbsucc:='si';
  minuti_suc:=timinuti;
  verso_suc:=l10_Verso;
  rilev_suc:=l10_Rilevatore;
  caus_suc:=l10_Causale;
  data_suc:=l10_Data;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z412_timbratmat;
{Lettura timbrature da matrice
 Spostamento timbrature in matrice di lavoro locale}
var iz412,jz412:Byte;
begin
  for iz412:=1 to 31 do
    for jz412:=1 to MaxTimbrature do
      ttimbraturedipmese[iz412,jz412]:=m_tab_timbrature[iz412,jz412];
  //Lettura timbratura precedente al giorno attuale
  z414_timbrprec;
  //Conversione timbratura precedente in minuti
  //Lettura timbrature del giorno attuale
  i1:=1;
  while not((i1 > MaxTimbrature) or (ttimbraturedipmese[datacon_gg , i1].tversotimb = '') (*or (blocca <> 0)*)) do
  begin
    z420_timbrgior;
    inc(i1);
  end;
  if blocca <> 0 then exit;
  //Lettura timbratura successiva al giorno attuale
  z422_timbrsucc;
  //Conversione timbratura successiva in minuti
end;
//_________________________________________________________________
procedure TR502ProDtM1.z414_timbrprec;
{Lettura timbratura precedente al giorno attuale da matrice}
var A,M,G:Word;
    D1,D2:TDateTime;
begin
  i1:=1;
  while not((i1 = datacon_gg) or (i1 > 2) or (estimbprec = 'si')) do
    begin
    data_pre:=datacon - i1;
    z416_timbrprecma;
    inc(i1);
    end;
  if (estimbprec = 'si') or (datacon_gg > 2)  then exit;
  //Lettura timbratura precedente al giorno attuale da archivio
  //Start su due giorni precedenti l' attuale
  //Se chiamo da cartellino e quindi non ho aperto le timbrature, devo
  //aprirle ora per leggere i due giorni precedenti
  if Chiamante = 'Cartellino' then
    with Q100 do
      begin
      Close;
      D1:=GetVariable('DaData');
      D2:=GetVariable('AData');
      SetVariable('DaData',DataCon - 2);
      SetVariable('AData',DataCon - 1);
      Open;
      //Ripristino il periodo impostato precedentemente
      SetVariable('DaData',D1);
      SetVariable('AData',D2);
      end;
  z926_starttimbr(datacon - 2);
  if s_trovato = 'no' then
  begin
    if Chiamante = 'Cartellino' then
      Q100.Close;
    exit;
  end;
  DecodeDate(l10_Data,A,M,G);
  if (datacon < l10_Data) or (datacon_mm = M) then
    begin
    s_trovato:='no';
    if Chiamante = 'Cartellino' then
      Q100.Close;
    exit;
    end;
  timinuti:=l10_Ora;
  z406_timbrprec;
  repeat
    z418_timbrprecar;
  until s_trovato = 'no';
  if Chiamante = 'Cartellino' then
    Q100.Close;
end;
//________________________________________________________________
procedure TR502ProDtM1.z416_timbrprecma;
{Lettura timbratura precedente al giorno attuale da matrice}
begin
  i2:=datacon_gg - i1;
  if ttimbraturedipmese[i2,1].tversotimb <> '' then
    begin
    i3:=0;
    repeat
      inc(i3);
    until (i3 > MaxTimbrature) or (ttimbraturedipmese[i2,i3].tversotimb = '');
    dec(i3);
    estimbprec:='si';
    with ttimbraturedipmese[i2,i3] do
      begin
      minuti_pre:=R180OreMInuti(toratimb);
      verso_pre:=tversotimb;
      rilev_pre:=trilevtimb;
      caus_pre:=tcaustimb;
      end;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z418_timbrprecar;
{Lettura timbratura precedente al giorno attuale da archivio}
var A,M,G:Word;
begin
  z928_leggitimbr;
  DecodeDate(l10_Data,A,M,G);
  if s_trovato = 'no' then exit;
  if (datacon < l10_Data) or (datacon_mm = M) then
  begin
    s_trovato:='no';
    exit;
  end;
  timinuti:=l10_Ora;
  z406_timbrprec;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z420_timbrgior;
{Lettura timbrature del giorno attuale}
begin
  with ttimbraturedipmese[datacon_gg,i1] do
  begin
    l10_flag:='*';
    l10_ora:=R180OreMInuti(toratimb);
    timinuti:=l10_Ora;
    l10_verso:=tversotimb;
    l10_rilevatore:=trilevtimb;
    l10_causale:=tcaustimb.Trim;
    z408_timbrgior;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z422_timbrsucc;
{Lettura timbratura successiva al giorno attuale da matrice
 Calcolo numero giorni del mese attuale in r_ngm170}
var r_n170,D1,D2:TDateTime;
    r_ngm170:Byte;
begin
  //r_1d170:=datacon;
  r_ngm170:=R180GiorniMese(datacon);
  data_suc:=datacon;
  i2:=datacon_gg + 1;
  i3:=datacon_gg + 2;
  i1:=i2;
  while not((i1 > i3) or (i1 > r_ngm170) or (estimbsucc = 'si')) do
    begin
    data_suc:=data_suc + 1;
    z424_timbrsuccma;
    inc(i1);
    end;
  if (estimbsucc = 'si') or (i3 <= r_ngm170) then exit;
  //Lettura timbratura successiva al giorno attuale da archivio
  //Start sul primo giorno del mese successivo l' attuale
  r_n170:=datacon - DataCon_gg  +  r_ngm170 + 1; //numcorr - datacon_gg + r_ngm170 + 1;
  //Se chiamo da cartellino e quindi non ho aperto le timbrature, devo
  //aprirle ora per leggere i due giorni successivi
  if Chiamante = 'Cartellino' then
    with Q100 do
      begin
      Close;
      D1:=GetVariable('DaData');
      D2:=GetVariable('AData');
      SetVariable('DaData',r_n170);
      SetVariable('AData',r_n170 + 1);
      Open;
      SetVariable('DaData',D1);
      SetVariable('AData',D2);
      end;
  z926_starttimbr(r_n170);
  //Elaboro la prima timbratura
  if s_trovato = 'no' then
    begin
    if Chiamante = 'Cartellino' then
      Q100.Close;
    exit;
    end;
  timinuti:=l10_Ora;
  z410_timbrsucc;
  while s_trovato = 'si' do
    z426_timbrsuccar;
  if Chiamante = 'Cartellino' then
    Q100.Close;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z424_timbrsuccma;
{Lettura timbratura successiva al giorno attuale da matrice}
begin
with ttimbraturedipmese[i1,1] do
  if tversotimb <> '' then
    begin
    estimbsucc:='si';
    minuti_suc:=R180OreMinuti(toratimb);
    verso_suc:=tversotimb;
    rilev_suc:=trilevtimb;
    caus_suc:=tcaustimb;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z426_timbrsuccar;
{Lettura timbratura successiva al giorno attuale da archivio}
begin
  z928_leggitimbr;
  if s_trovato = 'no' then exit;
  timinuti:=l10_Ora;
  z410_timbrsucc;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z428_contrrilev;
{Gestione anomalia su rilevatori}
var LTerm:TStringList;
begin
  if (Q430.FieldByName('Terminali').AsString = '') or (l10_Rilevatore = '') then
    exit;
  //Divido i terminali separati dalla virgola nella string list
  LTerm:=TStringList.Create;
  LTerm.CaseSensitive:=True;
  LTerm.CommaText:=Q430.FieldByName('Terminali').AsString;
  if LTerm.IndexOf(l10_Rilevatore) = -1 then
  begin
    z099_anom3(3,timinuti,'');
  end;
  LTerm.Free;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z430_giustif;
{Lettura giustificativi}
var i:Integer;
begin
  if ConteggiaGiustificativiR600 and CaricaGiustificativiR600 then
    SetLength(GiustificativiR600,0);
  if (chiamante = 'Cartellino') or (chiamante = 'Assenze') then
  begin
    //Lettura giustificativi da matrice
    z438_giustifmat;
    Q040.Filtered:=False;
  end
  else
  begin
    //Lettura giustificativi da archivio
    if esegui_z432 then  //parametro per non leggere i giustificativi da tabella
      z432_giustifarc;
    //Lettura giustificativi da richieste web (T050)
    if ConsideraRichiesteWeb then
    begin
      if selT050.SearchRecord('DATA',datacon,[srFromBeginning]) then
        repeat
          l04_dalle:=selT050.FieldByName('DaOre').AsDateTime;
          l04_alle:=selT050.FieldByName('AOre').AsDateTime;
          l04_Caus:=selT050.FieldByName('Causale').AsString;
          l04_TipoGius:=R180CarattereDef(selT050.FieldByName('TipoGiust').AsString,1);
          l04_PuntGiustR600:=-1;
          z436_giustcarica(True);
        until not selT050.SearchRecord('DATA',datacon,[]);
    end
    else if ConteggiaGiustificativiR600 then
      //Aggiunta dei giustificativi di GiustificativiR600 aventi ProgrCausale = -1
      for i:=0 to High(GiustificativiR600) do
        if (GiustificativiR600[i].progrcausale = -1) then
        begin
          l04_dalle:=GiustificativiR600[i].dalle;
          l04_alle:=GiustificativiR600[i].alle;
          l04_Caus:=GiustificativiR600[i].causale;
          l04_TipoGius:=GiustificativiR600[i].tipogiust;
          l04_PuntGiustR600:=i;
          z436_giustcarica(True);
        end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z432_giustifarc;
{Lettura giustificativi da archivio}
begin
  z916_startgiust;
  if s_trovato = 'no' then exit;
  if datacon <> Q040.FieldByName('Data').AsDateTime then
    begin
    s_trovato:='no';
    exit;
    end
  else
    z436_giustcarica(False);
  //Caricamento giustificativi da archivio
  repeat
    z434_giustcararc;
  until s_trovato = 'no';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z434_giustcararc;
{Caricamento giustificativi da archivio}
begin
  z918_leggigiust;
  if s_trovato = 'no' then exit;
  if datacon <> Q040.FieldByname('Data').AsDateTime then
    s_trovato:='no'
  else
    z436_giustcarica(False);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z436_giustcarica(l04:Boolean; GGDopo:Boolean = False);
{Caricamento giustificativi}
var Locl04_alle,Locl04_dalle,i:Integer;
    Locl04_Caus:String;
    Locl04_tipogius:Char;
    Locl04_PuntGiustR600:Integer;
    Locl04_DataFamiliare:TDateTime;
  function GetCausaleModificata:String;
  var i:Integer;
  begin
    Result:=Q040Causale.AsString;
    for i:=0 to High(GiustificativiR600) do
      if (GiustificativiR600[i].causale = Q040Causale.AsString) and
         (GiustificativiR600[i].progrcausale = Q040ProgrCausale.AsInteger) and
         (GiustificativiR600[i].causale_nuova <> '') then
       begin
         Result:=GiustificativiR600[i].causale_nuova;
         Break;
       end;
  end;
  function GetPuntGiustR600:Integer;
  var i:Integer;
  begin
    Result:=-1;
    if (not ConteggiaGiustificativiR600) or l04 then
      exit;
    for i:=0 to High(GiustificativiR600) do
      if (GiustificativiR600[i].causale = Q040Causale.AsString) and
         (GiustificativiR600[i].progrcausale = Q040ProgrCausale.AsInteger) then
      begin
         Result:=i;
         Break;
      end;
  end;
  procedure AggiungiGiustificativiR600;
  var i:Integer;
  begin
    i:=Length(GiustificativiR600);
    SetLength(GiustificativiR600,i + 1);
    GiustificativiR600[i].causale:=Q040Causale.AsString;
    GiustificativiR600[i].causale_nuova:=Q040Causale.AsString;
    GiustificativiR600[i].progrcausale:=Q040ProgrCausale.AsInteger;
    GiustificativiR600[i].tipogiust:=R180CarattereDef(Q040TipoGiust.AsString);
    GiustificativiR600[i].dalle:=Q040DaOre.AsDateTime;
    GiustificativiR600[i].alle:=Q040AOre.AsDateTime;
    GiustificativiR600[i].hhmmasse:=0;
    GiustificativiR600[i].ggasse:=0;
    GiustificativiR600[i].mezggasse:=0;
    GiustificativiR600[i].minasse:=0;
    GiustificativiR600[i].minvalasse:=0;
    GiustificativiR600[i].minvalcompasse:=0;
    GiustificativiR600[i].minresasse:=0;
    GiustificativiR600[i].puntAssCum:=-1;
    GiustificativiR600[i].RichiestaWeb:=#0;
    GiustificativiR600[i].Coniuge:=False;
    GiustificativiR600[i].causgnl_PTV:=False;
  end;
begin
  //Carico nelle variabili locali i dati che possono provenire da tabella o da memoria
  if l04 then
  begin
    //Memoria
    Locl04_dalle:=R180OreMinuti(l04_dalle);
    Locl04_alle:=R180OreMInuti(l04_alle);
    Locl04_Caus:=l04_Caus;
    Locl04_TipoGius:=l04_TipoGius;
    Locl04_DataFamiliare:=0;
    Locl04_PuntGiustR600:=l04_PuntGiustR600;
    if GGDopo and (Locl04_TipoGius = 'D') then
    begin
      inc(Locl04_dalle,1440);
      inc(Locl04_alle,1440);
    end;
  end
  else
  begin
    //Tabella
    Locl04_dalle:=R180OreMinuti(Q040DaOre.AsDateTime);
    Locl04_alle:=R180OreMinuti(Q040AOre.AsDateTime);
    Locl04_Caus:=Q040Causale.AsString;
    Locl04_TipoGius:=R180CarattereDef(Q040TipoGiust.AsString);
    if GiustDistFamiliari then
      Locl04_DataFamiliare:=Q040DataNas.AsDateTime
    else
      Locl04_DataFamiliare:=0;
    Locl04_PuntGiustR600:=-1;
    if GGDopo and (Locl04_TipoGius = 'D') then
    begin
      inc(Locl04_dalle,1440);
      inc(Locl04_alle,1440);
    end;
    if ConteggiaGiustificativiR600 and CaricaGiustificativiR600 then
      AggiungiGiustificativiR600;
    if ConteggiaGiustificativiR600 then
    begin
      //Modifico la causale se richiesto da R600.RettificaCatenaCompetenze
      Locl04_Caus:=GetCausaleModificata;
      Locl04_PuntGiustR600:=GetPuntGiustR600;
    end;
  end;
  if (Locl04_TipoGius = 'D') and (ValStrT275[Locl04_Caus,'CAUSALIZZA_TIMB_INTERSECANTI'] = 'S') then
    exit;
  if (Trim(ValStrT265[Locl04_caus,'CODRAGGR']) = '') and
     (Locl04_TipoGius = 'D') and
     (ValStrT275[Locl04_caus,'GIUST_DAA_TIMB'] = 'S') then
    if z444_InsTimbDaGiust(Locl04_caus,Locl04_dalle,Locl04_alle) then
      exit;
  i:=Length(GiustificativiDelGiorno);
  SetLength(GiustificativiDelGiorno,i + 1);
  GiustificativiDelGiorno[i].tcausgius:=Locl04_Caus;
  GiustificativiDelGiorno[i].ttipogius:=Locl04_TipoGius;
  GiustificativiDelGiorno[i].tdallegius:=Locl04_dalle;
  GiustificativiDelGiorno[i].tallegius:=Locl04_alle;
  if not l04 then
    GiustificativiDelGiorno[i].tdatanas:=Q040DataNas.AsDateTime
  else
    GiustificativiDelGiorno[i].tdatanas:=0;
  case Locl04_TipoGius of
    'I':begin
          //Alberto 17/07/2014:
          //E' possibile considerare più di 3 giornate di assenza (normale + riposo + neutra) nel caso che provengano dal coniuge (ConteggiaGiustificativiR600)
          if (n_giusgga = 4) or ((n_giusgga >=3) and (not ConteggiaGiustificativiR600)) then
            exit;
          inc(n_giusgga);
          tgius_ggass[n_giusgga].tcausggass:=Locl04_caus;
          tgius_ggass[n_giusgga].mmresi:=0;
          tgius_ggass[n_giusgga].DataFamiliare:=Locl04_DataFamiliare;
          tgius_ggass[n_giusgga].PuntGiustR600:=Locl04_PuntGiustR600;
        end;
    'M':begin
          if n_giusmga = 2 then exit;
          inc(n_giusmga);
          tgius_mgass[n_giusmga].tcausmgass:=Locl04_caus;
          tgius_mgass[n_giusmga].tmin:=Locl04_dalle;
          tgius_mgass[n_giusmga].mmresi:=0;
          tgius_mgass[n_giusmga].DataFamiliare:=Locl04_DataFamiliare;
          tgius_mgass[n_giusmga].PuntGiustR600:=Locl04_PuntGiustR600;
        end;
    'N':begin
          if (n_giusgga + n_giusmga + n_giusore + n_giusdaa) = MaxGiustif then exit;
          inc(n_giusore);
          tgius_min[n_giusore].tmin:=Locl04_dalle;
          tgius_min[n_giusore].tcausore:=Locl04_caus;
          tgius_min[n_giusore].DataFamiliare:=Locl04_DataFamiliare;
          tgius_min[n_giusore].tassenza:=Trim(ValStrT265[Locl04_caus,'CODRAGGR']) <> '';
          tgius_min[n_giusore].PuntGiustR600:=Locl04_PuntGiustR600;
          s_trovato:='si';  //Alberto 24/02/2007 - resetto s_trovato che viene utilizzato anche in ValStrT265
        end;
    'D':begin
          if (n_giusgga + n_giusmga + n_giusore + n_giusdaa) = MaxGiustif then exit;
          inc(n_giusdaa);
          tgius_dallealle[n_giusdaa].tcausdaa:=Locl04_caus;
          tgius_dallealle[n_giusdaa].tminutida:=Locl04_dalle;
          if Locl04_alle = 0 then
            tgius_dallealle[n_giusdaa].tminutia:=1440
          else
            tgius_dallealle[n_giusdaa].tminutia:=Locl04_alle;
          tgius_dallealle[n_giusdaa].DataFamiliare:=Locl04_DataFamiliare;
          tgius_dallealle[n_giusdaa].tassenza:=Trim(ValStrT265[Locl04_caus,'CODRAGGR']) <> '';
          tgius_dallealle[n_giusdaa].PuntGiustR600:=Locl04_PuntGiustR600;
          s_trovato:='si';  //Alberto 24/02/2007 - resetto s_trovato che viene utilizzato anche in ValStrT265
        end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z438_giustifmat;
{Lettura giustificativi da matrice
 Spostamento timbrature in matrice di lavoro locale}
var iz438,jz438:Byte;
begin
  for iz438:=1 to 31 do
    for jz438:=1 to MaxGiustif do
      tgiustificdipmese[iz438,jz438]:=m_tab_giustificativi[iz438,jz438];
  //Caricamento giustificativi da matrice
  i1:=1;
  while not((i1 > MaxGiustif) or (tgiustificdipmese[datacon_gg , i1].tcausgius = '')) do
  begin
    z440_giustcarmat;
    inc(i1);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z440_giustcarmat;
{Caricamento giustificativi da matrice}
begin
  with m_tab_giustificativi[datacon_gg,i1] do
  begin
    l04_caus:=tcausgius;
    l04_dalle:=tdallegius;
    l04_alle:=tallegius;
    l04_tipogius:=ttipogius;
    l04_PuntGiustR600:=-1;
    z436_giustcarica(True);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z442_giustcar_esterno(tcausgius:String; tdallegius, tallegius:TDateTime; ttipogius:Char);
{Caricamento giustificativi da matrice}
begin
  l04_caus:=tcausgius;
  l04_dalle:=tdallegius;
  l04_alle:=tallegius;
  l04_tipogius:=ttipogius;
  l04_PuntGiustR600:=-1;
  z436_giustcarica(True);
end;
//_________________________________________________________________
function TR502ProDtM1.z444_InsTimbDaGiust(Caus:String; Dalle,Alle:Integer):Boolean;
var i,k:Integer;
    TipoConteggio:String;
    NuovaTimbGiustUE:Boolean;
    TimbGiustUE:String;
begin
  Result:=False;
  NuovaTimbGiustUE:=False;
  TimbGiustUE:='';
  if Alle = 0 then
    Alle:=1440;
  TipoConteggio:=ValStrT275[Caus,'TIPOCONTEGGIO'];
  //Gestisco Intersezione con timbrature se prioritario per i giustificativi
  if ValStrT275[Caus,'INTERSEZIONE_TIMBRATURE'] = 'G' then
  begin
    i:=1;
    while i <= n_timbrdip do
    begin
      if (ttimbraturedip[i].tminutid_e >= Dalle) and (ttimbraturedip[i].tminutid_u <= Alle) then
      begin
        //Elimino timbratura contenuta nel giustificativo
        indice:=i;
        z802_toglitimbr;
      end
      else
      begin
        //Accorcio timbrature che intersecano il giustificativo
        if R180Between(Dalle,ttimbraturedip[i].tminutid_e,ttimbraturedip[i].tminutid_u) and (ttimbraturedip[i].tminutid_u <= Alle) then
          ttimbraturedip[i].tminutid_u:=Dalle
        else if R180Between(Alle,ttimbraturedip[i].tminutid_e,ttimbraturedip[i].tminutid_u) and (ttimbraturedip[i].tminutid_e >= Dalle) then
          ttimbraturedip[i].tminutid_e:=Alle;
        inc(i);
      end;
    end;
    for i:=1 to n_timbrdip do
      if (Dalle < ttimbraturedip[i].tminutid_u) and (Alle > ttimbraturedip[i].tminutid_e) then
      begin
        //Giustificativo contenuto nella timbratura: spezzo la timbratura per fare posto al giustificativo
        indice:=i;
        z816_insetimbr;
        ttimbraturedip[i].tminutid_u:=Dalle;
        ttimbraturedip[i + 1].tminutid_e:=Alle;
        Break;
      end;
  end
  else if ValStrT275[Caus,'INTERSEZIONE_TIMBRATURE'] = 'T' then
  //Gestisco Intersezione con timbrature se prioritario per le timbrature
  begin
    for i:=1 to n_timbrdip do
    begin
      if R180Between(Dalle,ttimbraturedip[i].tminutid_e,ttimbraturedip[i].tminutid_u) then
        Dalle:=ttimbraturedip[i].tminutid_u;
      if R180Between(Alle,ttimbraturedip[i].tminutid_e,ttimbraturedip[i].tminutid_u) then
        Alle:=ttimbraturedip[i].tminutid_e;
    end;
    //Esco se il giustificativo è annullato perchè all'interno delle timbrature
    if Alle <= Dalle then
    begin
      Result:=True;
      exit;
    end;
  end;
  //Ricerca indice in cui inserire la nuova timbratura
  k:=-1;
  //Causale su U-E: in mezzo ad una coppia E-U
  if R180CarattereDef(TipoConteggio) in ['A','E'] then
  begin
    for i:=1 to n_timbrdip do
    begin
      if (i < n_timbrdip) and (Dalle = ttimbraturedip[i].tminutid_u) and (Alle = ttimbraturedip[i + 1].tminutid_e) then
      begin
        ttimbraturedip[i].tcausale_u.tcaus:=Caus;
        ttimbraturedip[i + 1].tcausale_e.tcaus:=Caus;
        TimbGiustUE:='UE';
        Result:=True;
        Break;
      end;
      if (i < n_timbrdip) and (Dalle = ttimbraturedip[i].tminutid_u) and (Alle < ttimbraturedip[i + 1].tminutid_e) then
      begin
        ttimbraturedip[i].tcausale_u.tcaus:=Caus;
        //ttimbraturedip[i + 1].tcausale_e.tcaus:=Caus;
        //EsisteTimbGiustUE:=True;
        Result:=True;
        TimbGiustUE:='U';
        k:=i;
        Break;
      end;
      if (i = n_timbrdip) and (Dalle = ttimbraturedip[i].tminutid_u) then
      begin
        ttimbraturedip[i].tcausale_u.tcaus:=Caus;
        //ttimbraturedip[i + 1].tcausale_e.tcaus:=Caus;
        //EsisteTimbGiustUE:=True;
        Result:=True;
        TimbGiustUE:='U';
        k:=i;
        Break;
      end;
      if (i < n_timbrdip) and (Dalle > ttimbraturedip[i].tminutid_u) and (Alle = ttimbraturedip[i + 1].tminutid_e) then
      begin
        //ttimbraturedip[i].tcausale_u.tcaus:=Caus;
        ttimbraturedip[i + 1].tcausale_e.tcaus:=Caus;
        //EsisteTimbGiustUE:=True;
        Result:=True;
        TimbGiustUE:='E';
        k:=i;
        Break;
      end;
      if (i = 1) and (Alle = ttimbraturedip[i].tminutid_e) then
      begin
        //ttimbraturedip[i].tcausale_u.tcaus:=Caus;
        ttimbraturedip[i].tcausale_e.tcaus:=Caus;
        //EsisteTimbGiustUE:=True;
        Result:=True;
        TimbGiustUE:='E';
        k:=0;
        Break;
      end;
      if R180Between(Dalle,ttimbraturedip[i].tminutid_e,ttimbraturedip[i].tminutid_u) and
         R180Between(Alle,ttimbraturedip[i].tminutid_e,ttimbraturedip[i].tminutid_u) then
      begin
        k:=i;
        Break;
      end;
    end;
    //Se non ho trovato le timbrature provo a inserirle forzatamente in modo che il giust. dalle..alle rimanga compreso tra una coppia E..U
    NuovaTimbGiustUE:=k = -1;
  end;
  if TimbGiustUE = 'UE' then
    exit;
  if k = -1 then
  begin
    //Causale su E-U: prima, ultima, oppure tra una coppia U-E
    if (n_timbrdip = 0) or (ttimbraturedip[1].tminutid_e >= Alle) then
      k:=0
    else if ttimbraturedip[n_timbrdip].tminutid_u <= Dalle then
      k:=n_timbrdip
    else
      for i:=1 to n_timbrdip - 1 do
        if R180Between(Dalle,ttimbraturedip[i].tminutid_u,ttimbraturedip[i + 1].tminutid_e) and
           R180Between(Alle,ttimbraturedip[i].tminutid_u,ttimbraturedip[i + 1].tminutid_e) then
        begin
          k:=i;
          Break;
        end;
  end;

  if k = -1 then
    exit;
  //Inserimento timbratura
  if NuovaTimbGiustUE or not(R180CarattereDef(TipoConteggio) in ['A','E']) then
  begin
    indice:=k + 1;
    z816_insetimbr;
    ttimbraturedip[indice].tminutid_e:=Dalle;
    ttimbraturedip[indice].tminutid_u:=Alle;
    ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
    if not NuovaTimbGiustUE then
      ttimbraturedip[indice].tcausale_e.tcaus:=Caus
    else if Caus = '16UE' then  //Gestione personalizzata x Varese_Provincia
      ttimbraturedip[indice].tcausale_e.tcaus:='16STR';
    ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
    if not NuovaTimbGiustUE then
      ttimbraturedip[indice].tcausale_u.tcaus:=Caus
    else if Caus = '16UE' then //Gestione personalizzata x Varese_Provincia
      ttimbraturedip[indice].tcausale_u.tcaus:='16STR';
    ttimbraturedip[indice].tflagarr_u:='no';
    ttimbraturedip[indice].tflagarr_e:='no';
    if NuovaTimbGiustUE then
      k:=k + 1
    else
      Result:=True;
  end;

  if R180CarattereDef(TipoConteggio) in ['A','E'] then
  begin
    if TimbGiustUE = '' then //Giustificativo non appoggiato a nessuna timbratura
    begin
      indice:=k + 1;
      z816_insetimbr;
      ttimbraturedip[indice].tminutid_e:=Alle;
      ttimbraturedip[indice].tminutid_u:=ttimbraturedip[indice - 1].tminutid_u;
      ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
      ttimbraturedip[indice].tcausale_e.tcaus:=Caus;
      ttimbraturedip[indice].tcausale_u:=ttimbraturedip[indice - 1].tcausale_u;
      ttimbraturedip[indice].tflagarr_e:='no';
      ttimbraturedip[indice - 1].tminutid_u:=Dalle;
      ttimbraturedip[indice - 1].tcausale_u:=tcausale_vuota;
      ttimbraturedip[indice - 1].tcausale_u.tcaus:=Caus;
      ttimbraturedip[indice - 1].tflagarr_u:='no';
    end
    else if TimbGiustUE = 'U' then  //Giustificativo appoggiato alla timbratura in Uscita: E-U-Giust
    begin
      indice:=k + 1;
      z816_insetimbr;
      ttimbraturedip[indice].tminutid_e:=Alle;
      ttimbraturedip[indice].tminutid_u:=Alle;
      ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
      ttimbraturedip[indice].tcausale_e.tcaus:=Caus;
      ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
      ttimbraturedip[indice].tflagarr_e:='no';
    end
    else if TimbGiustUE = 'E' then //Giustificativo appoggiato alla timbratura in Entrata: Giust-E-U
    begin
      indice:=k + 1;
      z816_insetimbr;
      ttimbraturedip[indice].tminutid_e:=Dalle;
      ttimbraturedip[indice].tminutid_u:=Dalle;
      ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
      if Caus = '16UE' then  //Gestione personalizzata x Varese_Provincia: si causalizza entrata nel caso fosse anticipata ai punti nominali
        ttimbraturedip[indice].tcausale_e.tcaus:='16STR';
      ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
      ttimbraturedip[indice].tcausale_u.tcaus:=Caus;
      ttimbraturedip[indice].tflagarr_u:='no';
    end;
    Result:=True
  end;

  if Result then
  begin
    //Aggiorno TimbratureDelGiorno
    k:=-1;
    for i:=0 to High(TimbratureDelGiorno) do
      if TimbratureDelGiorno[i].toratimb > Dalle then
      begin
        k:=i;
        Break;
      end;
    i:=Length(TimbratureDelGiorno);
    SetLength(TimbratureDelGiorno,i + 2);
    if k = -1 then
      k:=High(TimbratureDelGiorno) - 1;
    for i:=High(TimbratureDelGiorno) - 2 downto k do
      TimbratureDelGiorno[i + 2]:=TimbratureDelGiorno[i];
    TimbratureDelGiorno[k].toratimb:=Dalle;
    TimbratureDelGiorno[k].tversotimb:=IfThen(R180CarattereDef(TipoConteggio) in ['A','E'],'U','E')[1];
    TimbratureDelGiorno[k].trilevtimb:='';
    TimbratureDelGiorno[k].tcaustimb:=Caus;
    TimbratureDelGiorno[k].tdagiustif:=True;
    TimbratureDelGiorno[k + 1].toratimb:=Alle;
    TimbratureDelGiorno[k + 1].tversotimb:=IfThen(R180CarattereDef(TipoConteggio) in ['A','E'],'E','U')[1];
    TimbratureDelGiorno[k + 1].trilevtimb:='';
    TimbratureDelGiorno[k + 1].tcaustimb:=Caus;
    TimbratureDelGiorno[k + 1].tdagiustif:=True;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z446_InsTimbDaGiustAss;
{inserimento temporaneo dei giustificativi dalle..alle nelle timbrature per consentire un miglior riconoscimento dell'orario/turno}
var g,t:Integer;
    Inserito:Boolean;
begin
  if not EsisteGiustificativo['D', 'SCELTA_ORARIO', 'S'] then
    exit;

  for g:=1 to n_giusdaa do
  begin
    if ValStrT265[tgius_dallealle[g].tcausdaa,'SCELTA_ORARIO'] <> 'S' then
      Continue;

    t:=1;
    Inserito:=False;
    while t <= n_timbrdip do
    try
      if tgius_dallealle[g].tminutida <= ttimbraturedip[t].tminutid_e then
      begin
        //Inserimento giustificativo
        indice:=t;
        z816_insetimbr;
        ttimbraturedip[indice].tminutid_e:=tgius_dallealle[g].tminutida;
        ttimbraturedip[indice].tminutid_u:=tgius_dallealle[g].tminutia;
        ttimbraturedip[indice].inserita:=True;
        ttimbraturedip[indice].tag:='DalleAlle';
        Inserito:=True;
        Break;
      end;
    finally
      inc(t);
    end;
    if not Inserito then
    begin
      indice:=max(n_timbrdip,1);
      z816_insetimbr;
      ttimbraturedip[indice].tminutid_e:=tgius_dallealle[g].tminutida;
      ttimbraturedip[indice].tminutid_u:=tgius_dallealle[g].tminutia;
      ttimbraturedip[indice].inserita:=True;
      ttimbraturedip[indice].tag:='DalleAlle';
    end;
  end;

  //Unificazione timbrature contigue
  for t:=n_timbrdip - 1 downto 1 do
  begin
    if (ttimbraturedip[t].tminutid_e < ttimbraturedip[t + 1].tminutid_e) and
       (ttimbraturedip[t].tminutid_u >= ttimbraturedip[t + 1].tminutid_e) and
       R180In('DalleAlle',[ttimbraturedip[t].tag,ttimbraturedip[t + 1].tag]) then
    begin
      ttimbraturedip[t].tminutid_u:=max(ttimbraturedip[t].tminutid_u,ttimbraturedip[t + 1].tminutid_u);
      //Mantengo i dati (causale) della timbratura vera
      ttimbraturedip[t + 1].tminutid_e:=ttimbraturedip[t].tminutid_e;
      ttimbraturedip[t + 1].tminutid_u:=ttimbraturedip[t].tminutid_u;
      if ttimbraturedip[t].tag = 'DalleAlle' then
        ttimbraturedip[t]:=ttimbraturedip[t + 1];
      indice:=t + 1;
      z802_toglitimbr;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z448_CheckAnomalieIter;
{Segnalazione di anomalia se esistono richieste web in attesa di autorizzazione / elaborazione}
var TipoIterNonAut,TipoIterNonElab:String;
begin
  with selIter do
  begin
    First;
    TipoIterNonAut:='';
    TipoIterNonElab:='';
    while not Eof do
    try
      if R180Between(DataCon,FieldByName('DAL').AsDateTime,FieldByName('AL').AsDateTime) then
      begin
        if FieldByName('STATO').IsNull then
        begin
          //Non autorizzato
          if Pos(FieldByName('TIPO').AsString,TipoIterNonAut) = 0 then
            TipoIterNonAut:=TipoIterNonAut + IfThen(TipoIterNonAut <> '','/') + FieldByName('TIPO').AsString;
        end
        else
        begin
          //Autorizzato ma da elaborare sul cartellino
          if Pos(FieldByName('TIPO').AsString,TipoIterNonElab) = 0 then
            TipoIterNonElab:=TipoIterNonElab + IfThen(TipoIterNonElab <> '','/') + FieldByName('TIPO').AsString;
        end;
      end;
    finally
      Next;
    end;
    TipoIterNonAut:=TipoIterNonAut.Replace('T050','Giustif.').Replace('T105','Timbr.').Replace('T085','Cambi Orari');
    TipoIterNonElab:=TipoIterNonElab.Replace('T050','Giustif.').Replace('T105','Timbr.').Replace('T085','Cambi Orari');
    if TipoIterNonAut <> '' then
    begin
      z099_anom3(10,-1,'');
      SetLength(tanom3riscontrate[n_anom3].ta3param,1);
      tanom3riscontrate[n_anom3].ta3param[0]:=TipoIterNonAut;
    end;
    if TipoIterNonElab <> '' then
    begin
      z099_anom3(11,-1,'');
      SetLength(tanom3riscontrate[n_anom3].ta3param,1);
      tanom3riscontrate[n_anom3].ta3param[0]:=TipoIterNonElab;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z450_turnireperib;
var ODS:TOracleDataSet;
    i:Integer;
begin
  SetLength(CodTurniReperibilita,0);
  with Q332 do
  begin
    if not Active then
      exit;
    if SearchRecord('DATA',DataCon,[srFromBeginning]) then
    repeat
      SetLength(CodTurniReperibilita,Length(CodTurniReperibilita) + 1);
      i:=High(CodTurniReperibilita);
      CodTurniReperibilita[i].Tipo:=FieldByName('RAG_PRES').AsString;
      if (CodTurniReperibilita[i].Tipo = 'C') or (CodTurniReperibilita[i].Tipo = 'D') then
        ODS:=Q350
      else
        ODS:=Q330;
      //Turno 1
      CodTurniReperibilita[i].Turno1.Codice:=FieldByName('Turno1').AsString;
      // Gestione per codice turno
      if ODS.SearchRecord('CODICE',CodTurniReperibilita[i].Turno1.Codice,[srFromBeginning]) then
      begin
        CodTurniReperibilita[i].Turno1.Inizio:=R180OreMinuti(ODS.FieldByName('ORAINIZIO').AsDateTime);
        CodTurniReperibilita[i].Turno1.Fine:=R180OreMinuti(ODS.FieldByName('ORAFINE').AsDateTime);
        if CodTurniReperibilita[i].Turno1.Inizio >= CodTurniReperibilita[i].Turno1.Fine then
          CodTurniReperibilita[i].Turno1.Durata:=CodTurniReperibilita[i].Turno1.Fine + 1440 - CodTurniReperibilita[i].Turno1.Inizio
        else
          CodTurniReperibilita[i].Turno1.Durata:=CodTurniReperibilita[i].Turno1.Fine - CodTurniReperibilita[i].Turno1.Inizio;
      end
      // Gestione per fascia oraria
      else if (FieldByName('ORAINIZIO_TURNO1').AsString <> '') and (FieldByName('ORAFINE_TURNO1').AsString <> '') then
      begin
        CodTurniReperibilita[i].Turno1.Codice:='';
        CodTurniReperibilita[i].Turno1.Inizio:=R180OreMinuti(FieldByName('ORAINIZIO_TURNO1').AsString);
        CodTurniReperibilita[i].Turno1.Fine:=R180OreMinuti(FieldByName('ORAFINE_TURNO1').AsString);
        if CodTurniReperibilita[i].Turno1.Inizio >= CodTurniReperibilita[i].Turno1.Fine then
          CodTurniReperibilita[i].Turno1.Durata:=CodTurniReperibilita[i].Turno1.Fine + 1440 - CodTurniReperibilita[i].Turno1.Inizio
        else
          CodTurniReperibilita[i].Turno1.Durata:=CodTurniReperibilita[i].Turno1.Fine - CodTurniReperibilita[i].Turno1.Inizio;
      end;
      //Turno 2
      CodTurniReperibilita[i].Turno2.Codice:=FieldByName('Turno2').AsString;
      // Gestione per codice turno
      if ODS.SearchRecord('CODICE',CodTurniReperibilita[i].Turno2.Codice,[srFromBeginning]) then
      begin
        CodTurniReperibilita[i].Turno2.Inizio:=R180OreMinuti(ODS.FieldByName('ORAINIZIO').AsDateTime);
        CodTurniReperibilita[i].Turno2.Fine:=R180OreMinuti(ODS.FieldByName('ORAFINE').AsDateTime);
        if CodTurniReperibilita[i].Turno2.Inizio >= CodTurniReperibilita[i].Turno2.Fine then
          CodTurniReperibilita[i].Turno2.Durata:=CodTurniReperibilita[i].Turno2.Fine + 1440 - CodTurniReperibilita[i].Turno2.Inizio
        else
          CodTurniReperibilita[i].Turno2.Durata:=CodTurniReperibilita[i].Turno2.Fine - CodTurniReperibilita[i].Turno2.Inizio;
      end
      // Gestione per fascia oraria
      else if (FieldByName('ORAINIZIO_TURNO2').AsString <> '') and (FieldByName('ORAFINE_TURNO2').AsString <> '') then
      begin
        CodTurniReperibilita[i].Turno2.Codice:='';
        CodTurniReperibilita[i].Turno2.Inizio:=R180OreMinuti(FieldByName('ORAINIZIO_TURNO2').AsString);
        CodTurniReperibilita[i].Turno2.Fine:=R180OreMinuti(FieldByName('ORAFINE_TURNO2').AsString);
        if CodTurniReperibilita[i].Turno2.Inizio >= CodTurniReperibilita[i].Turno2.Fine then
          CodTurniReperibilita[i].Turno2.Durata:=CodTurniReperibilita[i].Turno2.Fine + 1440 - CodTurniReperibilita[i].Turno2.Inizio
        else
          CodTurniReperibilita[i].Turno2.Durata:=CodTurniReperibilita[i].Turno2.Fine - CodTurniReperibilita[i].Turno2.Inizio;
      end;
      //Turno 3
      CodTurniReperibilita[i].Turno3.Codice:=FieldByName('Turno3').AsString;
      if ODS.SearchRecord('CODICE',CodTurniReperibilita[i].Turno3.Codice,[srFromBeginning]) then
      begin
        CodTurniReperibilita[i].Turno3.Inizio:=R180OreMinuti(ODS.FieldByName('ORAINIZIO').AsDateTime);
        CodTurniReperibilita[i].Turno3.Fine:=R180OreMinuti(ODS.FieldByName('ORAFINE').AsDateTime);
        if CodTurniReperibilita[i].Turno3.Inizio >= CodTurniReperibilita[i].Turno3.Fine then
          CodTurniReperibilita[i].Turno3.Durata:=CodTurniReperibilita[i].Turno3.Fine + 1440 - CodTurniReperibilita[i].Turno3.Inizio
        else
          CodTurniReperibilita[i].Turno3.Durata:=CodTurniReperibilita[i].Turno3.Fine - CodTurniReperibilita[i].Turno3.Inizio;
      end;
    until not SearchRecord('DATA',DataCon,[]);
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.z494_CheckTimbMensa:Boolean;
begin
  Result:=False;
  if cdsT020.FindField('PMT_TIMBRATURAMENSA') = nil then
    exit;
  if cdsT020.FieldByName('PMT_TIMBRATURAMENSA').AsString <> 'S' then
    exit;
  if TimbratureDiMensa = '' then
    exit;
  Result:=True;
end;
//_________________________________________________________________
function TR502ProDtM1.z495_IntervalloTimbMensa(U,E:Integer):Boolean;
var i,j,mm:Integer;
    lstTimbMensa:array of Integer;
begin
  Result:=False;
  SetLength(lstTimbMensa,0);
  with Q370 do
  begin
    if SearchRecord('Data',datacon,[srFromBeginning]) then
      while (not Eof) and (FieldByName('Data').AsDateTime = datacon) do
      begin
        mm:=R180OreMinuti(FieldByName('Ora').AsDateTime);
        SetLength(lstTimbMensa,Length(lstTimbMensa) + 1);
        lstTimbMensa[High(lstTimbMensa)]:=mm;
        Next;
      end;
  end;
  if Length(lstTimbMensa) <= 0 then
    exit;

  for i:=0 to High(lstTimbMensa) do
  begin
    if R180Between(lstTimbMensa[i],U,E) then
    begin
      Result:=True;
      Break;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z496_inscausPM;
{Riconoscimento timbrature di mensa}
var i,Peso,PesoMax,idx:Integer;
  procedure SettaCausalePM(x:Integer);
  begin
    ttimbraturedip[x].tcausale_u.tcaus:=CAUS_PM;
    ttimbraturedip[x].tcausale_u.tcaustip:='C';
    ttimbraturedip[x].tcausale_u.tcausrag:=traggrgius.C;
    ttimbraturedip[x].tcausale_u.tcauscon:='';
    ttimbraturedip[x].tcausale_u.tcausrip:='';
    ttimbraturedip[x].tcausale_u.tcausioe:='';
    ttimbraturedip[x].tcausale_u.tcausarr:=0;
    ttimbraturedip[x].tcausale_u.tcausrpl:='B';
    ttimbraturedip[x].tcausale_u.tcauspiu:=0;
    ttimbraturedip[x].tcausale_u.tcausabi:='si';
    ttimbraturedip[x].tcausale_u.tminminuti:=0;
    ttimbraturedip[x].tcausale_u.tmaxminuti:=1440;
    ttimbraturedip[x].tcausale_u.tpianrep:='N';
    ttimbraturedip[x].tcausale_u.tLfsCavMez:='N';
    ttimbraturedip[x].tcausale_u.tOreInsufficenti:='N';
    ttimbraturedip[x].tcausale_u.tNonAutorizzate:='N';
    ttimbraturedip[x + 1].tcausale_e:=ttimbraturedip[x].tcausale_u;
    paumentimb_u:=ttimbraturedip[x].tminutid_u;
    paumentimb_e:=ttimbraturedip[x + 1].tminutid_e;
  end;
  function CercaCausalePM(SettaCaus:Boolean):Boolean;
  var x,y:Integer;
  begin
    Result:=False;
    x:=1;
    while x < n_timbrdip do
    begin
      y:=x + 1;
      if (ttimbraturedip[x].Tag = 'NON AUTORIZZATO') or (ttimbraturedip[y].Tag = 'NON AUTORIZZATO') then  //Alberto: FIRENZE_COMUNE
      begin
        inc(x);
        Continue;
      end;
      SetFasciaMensa(ttimbraturedip[x].tminutid_u);
      //Se c'è timbratura di mensa con relativo controllo, ma non è compresa nell'intervallo U-E, si passa all'intervallo successivo
      if z494_CheckTimbMensa and not z495_IntervalloTimbMensa(ttimbraturedip[x].tminutid_u,ttimbraturedip[y].tminutid_e) then
      begin
        inc(x);
        Continue;
      end;
      if (ttimbraturedip[x].tminutid_u >= FasciaMensa.PMTInizioDa) and
         (ttimbraturedip[x].tminutid_u <= FasciaMensa.PMTInizioA) and
         (ttimbraturedip[y].tminutid_e >= FasciaMensa.PMTFineDa) and
         (ttimbraturedip[y].tminutid_e <= FasciaMensa.PMTFineA) and
         (not SettaCaus or (ttimbraturedip[y].tminutid_e - ttimbraturedip[x].tminutid_u >= ValNumT020['PMT_STACCOMIN']))
      then
      begin
        if not SettaCaus then
        begin //primo giro per cercare causali di pausa mensa specificate sulle timbrature
          if (ttimbraturedip[x].tcausale_u.tcaus <> '') and (ttimbraturedip[x].tcausale_u.tcaustip = 'C') and (ttimbraturedip[x].tcausale_u.tcausrag = traggrgius.C) then
          begin
            Result:=True;
            if (ttimbraturedip[y].tcausale_e.tcaus <> '') and
               (ttimbraturedip[y].tcausale_e.tcaustip = 'B') and
               (ttimbraturedip[y].tcausale_e.tcauscon <> 'A') and
               (ttimbraturedip[y].tcausale_e.tcauscon <> 'E') and
               (ttimbraturedip[y].tcausale_e.tcausMatMensa = 'S') then
            begin
              indice:=y;
              z816_insetimbr;
              ttimbraturedip[y].tminutid_e:=ttimbraturedip[y + 1].tminutid_e;
              ttimbraturedip[y].tminutid_u:=ttimbraturedip[y + 1].tminutid_e;
              ttimbraturedip[y].tcausale_e:=tcausale_vuota;
              ttimbraturedip[y].tcausale_u:=tcausale_vuota;
            end;
            Break;
          end;
          if (ttimbraturedip[y].tcausale_e.tcaus <> '') and (ttimbraturedip[y].tcausale_e.tcaustip = 'C') and (ttimbraturedip[y].tcausale_e.tcausrag = traggrgius.C) then
          begin
            Result:=True;
            if (ttimbraturedip[x].tcausale_u.tcaus <> '') and
               (ttimbraturedip[x].tcausale_u.tcaustip = 'B') and
               (ttimbraturedip[x].tcausale_u.tcauscon <> 'A') and
               (ttimbraturedip[x].tcausale_u.tcauscon <> 'E') and
               (ttimbraturedip[x].tcausale_u.tcausMatMensa = 'S') then
            begin
              indice:=y;
              z816_insetimbr;
              ttimbraturedip[y].tminutid_e:=ttimbraturedip[x].tminutid_u;
              ttimbraturedip[y].tminutid_u:=ttimbraturedip[x].tminutid_u;
              ttimbraturedip[y].tcausale_e:=tcausale_vuota;
              ttimbraturedip[y].tcausale_u:=tcausale_vuota;
            end;
            Break;
          end;
        end
        else //secondo giro per cercare intervalli non causalizzati da riconoscere con la causale P.M
        begin
          //Alberto 28/01/2003: gestione timbrature causalizzate nell'intervallo di pausa mensa
          //Si inserisce una coppia di timbrature con la stessa ora della timbratura causalizzata, ma senza causale
          if (ttimbraturedip[x].tcausale_u.tcaus <> '') and
             (ttimbraturedip[x].tcausale_u.tcaustip = 'B') and
             (ttimbraturedip[x].tcausale_u.tcauscon <> 'A') and
             (ttimbraturedip[x].tcausale_u.tcauscon <> 'E') and
             (ttimbraturedip[x].tcausale_u.tcausMatMensa = 'S') then
          begin
            indice:=y;
            z816_insetimbr;
            ttimbraturedip[y].tminutid_e:=ttimbraturedip[x].tminutid_u;
            ttimbraturedip[y].tminutid_u:=ttimbraturedip[x].tminutid_u;
            ttimbraturedip[y].tcausale_e:=tcausale_vuota;
            ttimbraturedip[y].tcausale_u:=tcausale_vuota;
            inc(x);
            inc(y);
          end;
          if (ttimbraturedip[y].tcausale_e.tcaus <> '') and
             (ttimbraturedip[y].tcausale_e.tcaustip = 'B') and
             (ttimbraturedip[y].tcausale_e.tcauscon <> 'A') and
             (ttimbraturedip[y].tcausale_e.tcauscon <> 'E') and
             (ttimbraturedip[y].tcausale_e.tcausMatMensa = 'S') then
          begin
            indice:=y;
            z816_insetimbr;
            ttimbraturedip[y].tminutid_e:=ttimbraturedip[y + 1].tminutid_e;
            ttimbraturedip[y].tminutid_u:=ttimbraturedip[y + 1].tminutid_e;
            ttimbraturedip[y].tcausale_e:=tcausale_vuota;
            ttimbraturedip[y].tcausale_u:=tcausale_vuota;
          end;
          //Se altra causale non faccio nulla
          if (ttimbraturedip[x].tcausale_u.tcaus <> '') or (ttimbraturedip[y].tcausale_e.tcaus <> '') then
          begin
            inc(x);
            Continue;
          end;
          //Fine modifica
          SettaCausalePM(x);
          Break;
        end;
      end;
      inc(x);
    end;
  end;
begin
  z496Eseguito:=True;
  if not((c_orario <> '') and (PausaMensa <> 'Z') and (cdsT020.FieldByName('CauObFac').AsString = 'F')) then
    exit;
  //Lettura caratteristiche delle causali
  for i:=1 to n_timbrdip do
  begin
    if ttimbraturedip[i].tcausale_e.tcaus <> '' then
    begin
      z964_leggicaus(ttimbraturedip[i].tcausale_e.tcaus);
      if (s_trovato = 'no') and (ttimbraturedip[i].tcausale_e.tcaus <> '######') then
      begin
        z098_anom2caus(1);
      end;
      z965_SettaCausPres(ttimbraturedip[i].tcausale_e);
    end;
    if ttimbraturedip[i].tcausale_u.tcaus <> '' then
    begin
      z964_leggicaus(ttimbraturedip[i].tcausale_u.tcaus);
      if (s_trovato = 'no') and (ttimbraturedip[i].tcausale_u.tcaus <> '######') then
      begin
        z098_anom2caus(1);
      end;
      z965_SettaCausPres(ttimbraturedip[i].tcausale_u);
    end;
  end;
  if cdsT020.FieldByName('IntersezioneMensa').AsString = 'S' then
    z498_SpezzaPausaMensa;
  //Alberto:FIRENZE_COMUNE
  idx:=0;
  if not calcolo_z100 then
  begin
    PesoMax:=Low(Integer);
    Peso:=PesoMax;
    for i:=1 to n_timbrdip - 1 do
    begin
      if (ttimbraturedip[i].Tag = 'NON AUTORIZZATO') or ((ttimbraturedip[i + 1].Tag = 'NON AUTORIZZATO')) then  //Alberto: FIRENZE_COMUNE
        Continue;
      //Se c'è timbratura di mensa con relativo controllo, ma non è compresa nell'intervallo U-E, si passa all'intervallo successivo
      if z494_CheckTimbMensa and not z495_IntervalloTimbMensa(ttimbraturedip[i].tminutid_u,ttimbraturedip[i + 1].tminutid_e) then
        Continue;
      //Alberto 04/08/2014: richiamo z086 per controllare che le timbrature rispettino le regole della PMT, altrimenti possono essere eslcuse successivamente dando risultati errati
      i1:=i;
      i2:=i + 1;
      z086_pausamecon(True);
      if codanom2 <> 0 then
      begin
        codanom2:=0;
        Continue;
      end;

      SetFasciaMensa(ttimbraturedip[i].tminutid_u);
      //Ricerca delle timbrature intersecanti, ma che non hanno causali su U-E
      if (ttimbraturedip[i].tminutid_u >= FasciaMensa.PMTInizioDa) and
         (ttimbraturedip[i].tminutid_u <= FasciaMensa.PMTInizioA) and
         (ttimbraturedip[i + 1].tminutid_e >= FasciaMensa.PMTFineDa) and
         (ttimbraturedip[i + 1].tminutid_e <= FasciaMensa.PMTFineA) and
         (ttimbraturedip[i + 1].tcausale_e.tcausMatMensa <> 'N') and
         //(ttimbraturedip[i + 1].tcausale_e.tcaus = '')
         //)) and
         (ttimbraturedip[i].tcausale_u.tcauscon <> 'A') and (ttimbraturedip[i].tcausale_u.tcauscon <> 'E') and
         (ttimbraturedip[i + 1].tcausale_e.tcauscon <> 'A') and (ttimbraturedip[i + 1].tcausale_e.tcauscon <> 'E') then
      begin
        if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
        begin //tutti gli intervalli in fascia mensa partecipano alla pausa mensa; idx rimane sempre a 0.
          SettaCausalePM(i);
        end
        else
        begin //Ricerca dell'intervallo maggiore per applicare la detrazione minore
          Peso:=ttimbraturedip[i + 1].tminutid_e - ttimbraturedip[i].tminutid_u;
          //Se causale di pausa mensa vince su tutte le altre
          if (ttimbraturedip[i].tcausale_u.tcaus <> '') and (ttimbraturedip[i].tcausale_u.tcaustip = 'C') and (ttimbraturedip[i].tcausale_u.tcausrag = traggrgius.C) then
            inc(Peso,1000);
          if (ttimbraturedip[i + 1].tcausale_e.tcaus <> '') and (ttimbraturedip[i + 1].tcausale_e.tcaustip = 'C') and (ttimbraturedip[i + 1].tcausale_e.tcausrag = traggrgius.C) then
            inc(Peso,1000);
          if Peso > PesoMax then
          begin
            idx:=i;
            PesoMax:=Peso;
          end;
        end;
      end;
    end;
  end;
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] and (not calcolo_z100) then
    exit;
  if idx > 0 then
  begin
    SettaCausalePM(idx);
  end
  else
  begin
    if not CercaCausalePM(False) then
      CercaCausalePM(True);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z498_SpezzaPausaMensa;
{Spezza le timbrature di mensa sul periodo specificato se una è interna e l'altra è esterna}
var i,Peso,PesoMax,idx:Integer;
    Valido:Boolean;
begin
  PesoMax:=Low(Integer);
  Peso:=PesoMax;
  idx:=0;
  for i:=1 to n_timbrdip - 1 do
  begin
    if (ttimbraturedip[i].Tag = 'NON AUTORIZZATO') or ((ttimbraturedip[i + 1].Tag = 'NON AUTORIZZATO')) then  //Alberto: FIRENZE_COMUNE
      Continue;
    if not (
       (ttimbraturedip[i].tcausale_u.tcauscon <> 'A') and
       (ttimbraturedip[i].tcausale_u.tcauscon <> 'E') and
       (ttimbraturedip[i + 1].tcausale_e.tcauscon <> 'A') and
       (ttimbraturedip[i + 1].tcausale_e.tcauscon <> 'E')
    ) then
      Continue;

    //Ricerca delle timbrature intersecanti, ma che non hanno causali su U-E
    SetFasciaMensa(ttimbraturedip[i].tminutid_u);
    (*
    if ((R180Between(ttimbraturedip[i].tminutid_u,FasciaMensa.PMTInizioDa,FasciaMensa.PMTInizioA) and
         (ttimbraturedip[i].tcausale_u.tcausMatMensa <> 'N') and //and (ttimbraturedip[i].tcausale_u.tcaus = '')
         (ttimbraturedip[i + 1].tcausale_e.tcausMatMensa <> 'N')
        ) or
        (R180Between(ttimbraturedip[i + 1].tminutid_e,FasciaMensa.PMTFineDa,FasciaMensa.PMTFineA) and
         (ttimbraturedip[i + 1].tcausale_e.tcausMatMensa <> 'N') and //and (ttimbraturedip[i + 1].tcausale_e.tcaus = '')
         (ttimbraturedip[i].tcausale_u.tcausMatMensa <> 'N') //and (ttimbraturedip[i + 1].tcausale_e.tcaus = '')
        ) or
        (XParam[XP_INTERSEZPMT_ESTERNA] and
         (ttimbraturedip[i].tminutid_u < FasciaMensa.PMTInizioDa) and
         (ttimbraturedip[i + 1].tminutid_e > FasciaMensa.PMTFineA) and
         (ttimbraturedip[i].tcausale_u.tcausMatMensa <> 'N') and
         (ttimbraturedip[i + 1].tcausale_e.tcausMatMensa <> 'N')
        )
       ) and
       (ttimbraturedip[i].tcausale_u.tcauscon <> 'A') and
       (ttimbraturedip[i].tcausale_u.tcauscon <> 'E') and
       (ttimbraturedip[i + 1].tcausale_e.tcauscon <> 'A') and
       (ttimbraturedip[i + 1].tcausale_e.tcauscon <> 'E')
    *)
    Valido:=False;
    i1:=i;
    i2:=i1 + 1;
    if XParam[XP_INTERSEZPMT_ESTERNA] then
    begin
      //Dovrebbe rientrare tutto in questa gestione, ma per sicurezza adesso si tengono separate
      if (ttimbraturedip[i2].tminutid_e > FasciaMensa.PMTFineA) and
         (ttimbraturedip[i2].tcausale_e.tcausmatMensa <> 'N') then
        Valido:=True;
      //Uscita in anticipo e rientro interno
      if (ttimbraturedip[i1].tminutid_u < FasciaMensa.PMTInizioDa) and
         (ttimbraturedip[i1].tcausale_u.tcausMatMensa <> 'N') then
        Valido:=True;
    end
    else
    begin
      if (ttimbraturedip[i1].tminutid_u >= FasciaMensa.PMTInizioDa) and
         (ttimbraturedip[i1].tminutid_u <= FasciaMensa.PMTInizioA) and
         (ttimbraturedip[i1].tcausale_u.tcausmatMensa <> 'N') and
         (ttimbraturedip[i2].tminutid_e > FasciaMensa.PMTFineA) and
         (ttimbraturedip[i2].tcausale_e.tcausmatMensa <> 'N') then
        Valido:=True
      //Uscita in anticipo e rientro interno
      else if (ttimbraturedip[i1].tminutid_u < FasciaMensa.PMTInizioDa) and
              (ttimbraturedip[i1].tcausale_u.tcausMatMensa <> 'N') and
              (ttimbraturedip[i2].tminutid_e >= FasciaMensa.PMTFineDa) and
              (ttimbraturedip[i2].tminutid_e <= FasciaMensa.PMTFineA) and
              (ttimbraturedip[i2].tcausale_e.tcausmatMensa <> 'N') then
        Valido:=True
    end;

    if Valido then
    begin
      Peso:=Min(ttimbraturedip[i + 1].tminutid_e,FasciaMensa.PMTFineA) - Max(ttimbraturedip[i].tminutid_u,FasciaMensa.PMTInizioDa);
      if Peso > PesoMax then
      begin
        idx:=i;
        PesoMax:=Peso;
      end;
    end;
  end;
  if idx = 0 then
    exit;

  i1:=idx;
  i2:=i1 + 1;
  //Uscita interna e rientro in ritardo
  SetFasciaMensa(ttimbraturedip[i1].tminutid_u);
  if XParam[XP_INTERSEZPMT_ESTERNA] then
  begin
    //Dovrebbe rientrare tutto in questa gestione, ma per sicurezza adesso si tengono separate
    if (ttimbraturedip[i2].tminutid_e > FasciaMensa.PMTFineA) and
       (ttimbraturedip[i2].tcausale_e.tcausmatMensa <> 'N') then
    begin
      indice:=i2;
      z816_insetimbr;
      ttimbraturedip[i2].tminutid_e:=FasciaMensa.PMTFineA;
      ttimbraturedip[i2].tminutid_u:=FasciaMensa.PMTFineA;
      ttimbraturedip[i2].tcausale_e:=tcausale_vuota;
      ttimbraturedip[i2].tcausale_u:=tcausale_vuota;
    end;
    //Uscita in anticipo e rientro interno
    if (ttimbraturedip[i1].tminutid_u < FasciaMensa.PMTInizioDa) and
       (ttimbraturedip[i1].tcausale_u.tcausMatMensa <> 'N') then
    begin
      indice:=i2;
      z816_insetimbr;
      ttimbraturedip[i2].tminutid_e:=FasciaMensa.PMTInizioDa;
      ttimbraturedip[i2].tminutid_u:=FasciaMensa.PMTInizioDa;
      ttimbraturedip[i2].tcausale_e:=tcausale_vuota;
      ttimbraturedip[i2].tcausale_u:=tcausale_vuota;
    end;
  end
  else
  begin
    if (ttimbraturedip[i1].tminutid_u >= FasciaMensa.PMTInizioDa) and
       (ttimbraturedip[i1].tminutid_u <= FasciaMensa.PMTInizioA) and
       (ttimbraturedip[i1].tcausale_u.tcausmatMensa <> 'N') and
       //(ttimbraturedip[i1].tcausale_u.tcaus = '') and
       (ttimbraturedip[i2].tminutid_e > FasciaMensa.PMTFineA) and
       (ttimbraturedip[i2].tcausale_e.tcausmatMensa <> 'N') then
       //(ttimbraturedip[i2].tcausale_e.tcaus = '') then
    begin
      indice:=i2;
      z816_insetimbr;
      ttimbraturedip[i2].tminutid_e:=FasciaMensa.PMTFineA;
      ttimbraturedip[i2].tminutid_u:=FasciaMensa.PMTFineA;
      ttimbraturedip[i2].tcausale_e:=tcausale_vuota;
      ttimbraturedip[i2].tcausale_u:=tcausale_vuota;
    end
    //Uscita in anticipo e rientro interno
    else if (ttimbraturedip[i1].tminutid_u < FasciaMensa.PMTInizioDa) and
            (ttimbraturedip[i1].tcausale_u.tcausMatMensa <> 'N') and
            //(ttimbraturedip[i1].tcausale_u.tcaus = '') and
            (ttimbraturedip[i2].tminutid_e >= FasciaMensa.PMTFineDa) and
            (ttimbraturedip[i2].tminutid_e <= FasciaMensa.PMTFineA) and
            (ttimbraturedip[i2].tcausale_e.tcausmatMensa <> 'N') then
            //(ttimbraturedip[i2].tcausale_e.tcaus = '') then
    begin
      indice:=i2;
      z816_insetimbr;
      ttimbraturedip[i2].tminutid_e:=FasciaMensa.PMTInizioDa;
      ttimbraturedip[i2].tminutid_u:=FasciaMensa.PMTInizioDa;
      ttimbraturedip[i2].tcausale_e:=tcausale_vuota;
      ttimbraturedip[i2].tcausale_u:=tcausale_vuota;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z500_orarfac;
{Scelta orario e riconoscimento timbrature di mensa}
var i:Integer;
    TmbPM:Boolean;
begin
  orarioacq:='si';
  //Acquisizione codice orario considerando pianificazione
  z502_acqorind;
  if blocca <> 0 then exit;
  //Lettura orario con inizializzazioni per orario vuoto
  z046_orario;
  if blocca <> 0 then exit;
  //VENEZIA_CRV: giustificativi dalle..alle che allargano la fascia di PMT
  for i:=1 to n_giusdaa do
    if XParam[XP_CRV_ALLARGA_PMT] then
      if (tgius_dallealle[i].tcausdaa = 'MN010') or (tgius_dallealle[i].tcausdaa = 'MN020') then
      begin
        CRV_PMT_MNGiustE:=min(tgius_dallealle[i].tminutida,CRV_PMT_MNGiustE);
        CRV_PMT_MNGiustU:=max(tgius_dallealle[i].tminutia,CRV_PMT_MNGiustU);
      end;
  //FIRENZE_COMUNE: da non fare se ci sono giustificativi dalle..alle da considerare nella pausa mensa
  TmbPM:=False;
  for i:=1 to n_giusdaa do
  begin
    if tgius_dallealle[i].tassenza  then
      TmbPM:=ValStrT265[tgius_dallealle[i].tcausdaa,'TIMB_PM'] = 'S'
    else
      TmbPM:=ValStrT275[tgius_dallealle[i].tcausdaa,'TIMB_PM'] = 'S';
    if TmbPM then
      Break;
  end;
  if TmbPM or (cdsT020.FieldByName('PMT_TIMB_AUTORIZZATE').AsString = 'S') then
  begin
    exit;
  end
  else
  begin
    //Inserimento coppia di causali facoltative per Pausa Mensa (se necessario)
    z496_inscausPM;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z502_acqorind;
{Acquisizione codice orario considerando pianificazione}
var k,i5:Integer;
    comodo5:Integer;
    IgnTimbNonInSeq:String;
    TimbSalvate:array [1..MaxTimbrature] of t_ttimbraturedip;
    n_timbrdipsalvata:Byte;
begin
  z924_leggipian;
  if (s_trovato = 'si') and (l08_Orario <> '') then
    //Codice orario da pianificazione
    begin
    pianif:='si';
    c_orario:=l08_Orario;
    c_turni1:=l08_Turno1;
    c_turni2:=l08_Turno2;
    if l08_Turno1 <= 0 then
      begin
      l08_turno1:=0;
      l08_turno2:=0;
      end;
    if l08_Turno2 <= 0 then
      l08_Turno2:=0;
    exit;
    end;
  //Codice orario da anagrafico
  pianif:='no';
  c_turni1:=-1;
  c_turni2:=-1;
  r_turno1:=-1;
  r_turno2:=-1;
  //Lettura timbrature e gestione parziale prima T=U
  //o ultima T=E o 24 ore di lavoro
  if timbraacq <> 'si' then
  begin
    z400_timbrat;
    if blocca <> 0 then
    begin
      bloccatimb:=blocca;
      blocca:=0;
    end;
  end;
  //Alberto 28/05/2007: GENOVA_HGALLIERA - lettura del profilo orario per sapere se ignorare le timbrature non in sequenza
  z052_profiloorar;
  if (Chiamante = 'Assenze') or IgnTimbNonInSeqForzata then
    IgnTimbNonInSeq:='S'
  else
    IgnTimbNonInSeq:=T220[selT220.FieldByName('IGNORA_TIMBNONINSEQ').Index];
  if (timbraacq = 'si') and (bloccatimb = 2) and (IgnTimbNonInSeq = 'S') then
  begin
    for k:=n_timbrdip downto 1 do
      if (ttimbraturedip[k].tflagarr_e = '') or (ttimbraturedip[k].tflagarr_u = '') then
      begin
        if ttimbraturedip[k].tflagarr_e <> '' then
          z098_anom2caus(51,R180MinutiOre(ttimbraturedip[k].tminutid_e))
        else
          z098_anom2caus(51,R180MinutiOre(ttimbraturedip[k].tminutid_u));
        if not IgnTimbNonInSeqForzata then
        begin
          indice:=k;
          z802_toglitimbr;
        end
        else
        begin
          //Completamento timbratura mancante
          if ttimbraturedip[k].tflagarr_e = '' then
            ttimbraturedip[k].tminutid_e:=ttimbraturedip[k].tminutid_u
          else
          begin
            //Se manca l'uscita, si aggiunge fino all'entrata successiva o fino a mezzanotte
            if k = n_timbrdip then
              ttimbraturedip[k].tminutid_u:=max(ttimbraturedip[k].tminutid_e,1440)
            else
              ttimbraturedip[k].tminutid_u:=ttimbraturedip[k + 1].tminutid_e;
          end;
        end;
      end;
    //if (n_timbrdip > 0) or (Chiamante = 'Assenze') then
    bloccatimb:=0
  end;
  //FINE GENOVA_H_GALLIERA
  if length(TimbratureOriginali) = 0 then
    z071_salvatimbrature;
  if blocca <> 0 then exit;
  //Impostazione degli orari fra cui scegliere
  if Q430.FieldByName('POrario').AsString = '' then
    blocca:=23
  else
    //Codici orari da profilo orario in anagrafico
    z052_profiloorar;
  if blocca <> 0 then exit;
  //Orario del giorno lavorativo, sabato o domenica
  igs:=giorsett;
  if (Q430.FieldByName('TGestione').AsString <> '1') then
  begin
    //Orario del giorno non lavorativo diverso da domenica
    if (gglav = 'no') and (T221[1,8] <> '') then
    begin
      if T221[1,8] <> ':GGST' then
        if (igs <> 7) or (T220[selT220.FieldByName('PRIORITA_DOM_NONLAV').Index] <> 'S') then
          igs:=8;
    end;
    //Orario del giorno festivo
    if (tipogg = 'F') and (T221[1,9] <> '') then
    begin
      if T221[1,9] <> ':GGST' then
        if (igs <> 7) or (T220[selT220.FieldByName('PRIORITA_DOM_FEST').Index] <> 'S') then
          igs:=9;
    end;
  end;
  //Scelta del giorno Festivo per i turnisti
  if (Q430.FieldByName('TGestione').AsString = '1') then
    //Orario del giorno festivo
    if (tipogg = 'F') and (T221[1,9] <> '') then
    begin
      if T221[1,9] <> ':GGST' then
        if (igs <> 7) or (T220[selT220.FieldByName('PRIORITA_DOM_FEST').Index] <> 'S') then
          igs:=9;
    end;
  if (chiamante = 'Assenze') and (n_timbrdip = 0) then
     //Se chiamante = Assenze e non vi sono timbrature si sceglie il primo orario
     c_orario:=T221[1,igs]
  else
  //Scorrimento degli orari per scelta del migliore
  begin
    //Alberto 13/06/2007: unificazione delle causali di lavoro fuori sede (tipo A/E)
    n_timbrdipsalvata:=n_timbrdip;
    for k:=1 to n_timbrdip do
      TimbSalvate[k]:=ttimbraturedip[k];
    //Primo ciclo: verifico se causali abilitate
    i1:=1;
    while i1 <= n_timbrdip do
    begin
      z064_causali;
      inc(i1);
    end;
    //Secondo ciclo: scarto vero e proprio
    i4:=1;
    while True do
    begin
      if i4 >= n_timbrdip then Break;
      z078_tipoconAc2(False);
      inc(i4);
    end;

    //aggiungo giustificativi dalle..alle e unifico timbrature contigue
    z446_InsTimbDaGiustAss;

    //Considerazione dello smonto notte
    if (Parametri.RagioneSociale = TORINO_ASLTO1) and
       (Parametri.Azienda = 'CONV2') and
       (c_profora_sv = 'GM001') and
       (estimbsucc = 'si') then
    begin
      inc(n_timbrdip);
      ttimbraturedip[n_timbrdip].tminutid_e:=0;
      ttimbraturedip[n_timbrdip].tminutid_u:=minuti_suc;
      ttimbraturedip[n_timbrdip].tcausale_e.tcaus:=caus_suc;
      ttimbraturedip[n_timbrdip].tcausale_u.tcaus:=caus_suc;
    end;

    comodo5:=Low(Integer);
    i4:=1;
    OrarioDaEntrata:=False;
    for i5:=1 to MaxT221 do
      begin
      c_orario:=T221[i5,igs];
      if c_orario <> '' then
        //Appoggio timbrature ad orario
        begin
        z504_appoggiotor;
        comodo7:=comodo7 + 6000 - comodo8;
        if comodo7 > comodo5 then
          begin
          i4:=i5;
          comodo5:=comodo7;
          end;
        if OrarioDaEntrata then
          begin
          i4:=i5;
          Break;
          end;
        end;
      end;
    //Acquisizione del codice orario migliore
    c_orario:=T221[i4,igs];

    n_timbrdip:=n_timbrdipsalvata;
    for k:=1 to n_timbrdip do
      ttimbraturedip[k]:=TimbSalvate[k];
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z504_appoggiotor;
{Appoggio timbrature ad orario
 Lettura orario}
var nta,npn,i,j:Integer;
    Trovato:Boolean;
begin
  z046_orario;
  if blocca <> 0 then
    begin
    blocca:=0;
    exit;
    end;
  //Lettura timbrature nominali
  n_timbrnom:=0;
  ttimbraturenom:=nil;
  SetLength(ttimbraturenom,1);
  if TipoOrario = 'A' then
    z210_legginomA
  else if TipoOrario = 'B' then
    z220_legginomB
  else if TipoOrario = 'C' then
    z240_legginomC
  else if TipoOrario = 'D' then
    z260_legginomD
  else if TipoOrario = 'E' then
    z280_legginomE;
  //Calcolo timbr. nominali di appoggio per timbr. dipendente
  z060_appoggio(False);
  //Calcolo quanto le timbrature del dipendente
  //approssimano quelle nominali
  comodo1:=0;  //include comodo3
  comodo3:=0;  //Nuovo parametro per indicare quante timbrature NON si devono considerare in n_timbrdip perchè sono escluse
  comodo6:=0;  //Timbrature non appoggiate o esterne
  comodo7:=0;  //Intersezione con timbrature nominali
  comodo8:=0;  //Parametro conclusivo (include comodo1 e comodo6)
  scostentrata:=0;
  z506_inttimbr;
  if T220[selT220.FieldByName('ScostEntrata').Index] = 'S' then
    //inc(comodo8,30 * scostentrata);
    inc(comodo8,scostentrata * StrToIntDef(T220[selT220.FieldByName('PESO_SCOSTENTRATA_S').Index],PESO_SCOSTENTRATA_S));
  //Si gestisce il flag che impone la priorita' del numero di
  //timbrature nella scelta
  if T220[selT220.FieldByName('pritimsc').Index] = 'S' then
  begin
    //comodo1:=ABS(n_timbrdip - comodo3 - (n_timbrnom - IfThen(turnicavmez = 'si',1,0))) * 1000;
    comodo1:=ABS(n_timbrdip - comodo3 - (n_timbrnom - IfThen(turnicavmez = 'si',1,0))) * StrToIntDef(T220[selT220.FieldByName('PESO_PRITIMSC_S').Index],PESO_PRITIMSC_S);
    inc(comodo8,comodo1);
  end
  else if T220[selT220.FieldByName('pritimsc').Index] = 'A' then
  begin
    nta:=0;
    npn:=0;
    Trovato:=False;
    for i:=1 to n_timbrdip do
      if ttimbraturedip[i].tpuntnomin > 0 then
      begin
        for j:=1 to i - 1 do
          if ttimbraturedip[i].tpuntnomin = ttimbraturedip[j].tpuntnomin then
          begin
            Trovato:=True;
            Break;
          end;
        inc(nta);
        if not Trovato then
          inc(npn);
      end;
    //comodo1:=ABS(nta - npn) * 1000;
    comodo1:=ABS(nta - npn) * StrToIntDef(T220[selT220.FieldByName('PESO_PRITIMSC_A').Index],PESO_PRITIMSC_A);
    inc(comodo8,comodo1);
  end;
  //Se le timbrature dipendente non intersecano quelle nominali
  //l'orario in gestione dovra' essere scartato
  if (comodo6 = n_timbrdip) then
    if T220[selT220.FieldByName('TimbNonAppoggiate').Index] <> 'S' then
      //comodo8:=6000;
      comodo8:=StrToIntDef(T220[selT220.FieldByName('Peso_TimbNonAppoggiate_N').Index],PESO_TIMBNONAPPOGGIATE_N)
    else
      //Le timbrature che non sono appoggiate penalizzano la scelta
      //inc(comodo8,comodo6 * 1000);
      inc(comodo8,comodo6 * StrToIntDef(T220[selT220.FieldByName('Peso_TimbNonAppoggiate_S').Index],PESO_TIMBNONAPPOGGIATE_S))
  else
    //inc(comodo8,comodo6 * 100);
    inc(comodo8,comodo6 * StrToIntDef(T220[selT220.FieldByName('Peso_TimbEsterne').Index],PESO_TIMBESTERNE));
end;
//_________________________________________________________________
procedure TR502ProDtM1.z506_inttimbr;
{Calcolo quanto le timbrature dipendente
 approssimano quelle nominali}
var i6,Ritardo:Integer;
    PuntiNom:TPeriodoIF;
begin
  for i6:=1 to n_timbrdip do
  begin
    p1:=ttimbraturedip[i6].tpuntnomin;
    if p1 = 0 then
    begin
      if (ttimbraturedip[i6].tcausale_e.tcaus <> '') and
         (ttimbraturedip[i6].tcausale_e.tcaus = ttimbraturedip[i6].tcausale_u.tcaus) and
         (ValStrT275[ttimbraturedip[i6].tcausale_e.tcaus,'CONSIDERA_SCELTA_ORARIO'] = 'N') then
        inc(comodo3);
      inc(comodo6);
      Continue;
    end;

    //Calcolo punti nominali considerando il cavallo di mezzanotte
    PuntiNom.I:=ttimbraturenom[p1].tminutin_e;
    PuntiNom.F:=ttimbraturenom[p1].tminutin_u;
    if (TipoOrario = 'D') and (ttimbraturenom[p1].tminutin_u > 1440) then
      PuntiNom.F:=1440;
    (*
    puntre:=ttimbraturenom[p1].tpuntre;
    puntru:=ttimbraturenom[p1].tpuntru;
    if TipoOrario <> 'E' then
    begin
      puntre:=1;
      puntru:=1;
    end;
    if puntre > 0 then
      PuntiNom.I:=ttimbraturenom[p1].tminutin_e
    else
      PuntiNom.I:=ttimbraturenom[p1].tminutin_e_ori - 1440;
    if puntru > 0 then
      PuntiNom.F:=ttimbraturenom[p1].tminutin_u
    else
      PuntiNom.F:=ttimbraturenom[p1].tminutin_u_ori + 1440;
    *)

    //Si ignorano le timbrature con causale di presenza che non deve essere considerata nella scelta orario
    if (ttimbraturedip[i6].tcausale_e.tcaus <> '') and
       (ttimbraturedip[i6].tcausale_e.tcaus = ttimbraturedip[i6].tcausale_u.tcaus) and
       (ValStrT275[ttimbraturedip[i6].tcausale_e.tcaus,'CONSIDERA_SCELTA_ORARIO'] = 'N') then
    begin
      inc(comodo3);
      inc(comodo6);
      Continue;
    end
    //caso particolare della prima timbratura a cavallo di mezzanotte
    else if (i6 = 1) and (primat_u = 'si') and (estimbprec = 'si') and (caus_pre <> '') and
            (caus_pre = ttimbraturedip[i6].tcausale_u.tcaus) and
            (ValStrT275[caus_pre,'CONSIDERA_SCELTA_ORARIO'] = 'N') then
    begin
      inc(comodo3);
      inc(comodo6);
      Continue;
    end
    //caso particolare dell'ultima timbratura a cavallo di mezzanotte
    else if (i6 = n_timbrdip) and (ultimt_e = 'si') and (estimbsucc = 'si') and (caus_suc <> '') and
            (caus_suc = ttimbraturedip[i6].tcausale_e.tcaus) and
            (ValStrT275[caus_suc,'CONSIDERA_SCELTA_ORARIO'] = 'N') then
    begin
      inc(comodo3);
      inc(comodo6);
      Continue;
    end;
    //Calcolo quanto le timbrature dipendente
    //intersecano quelle nominali
    (*if ttimbraturedip[i6].tminutid_e < ttimbraturenom[p1].tminutin_e then
      comodo1:=ttimbraturenom[p1].tminutin_e
    else
      comodo1:=ttimbraturedip[i6].tminutid_e;
    if ttimbraturedip[i6].tminutid_u > ttimbraturenom[p1].tminutin_u then
      comodo7:=comodo7 + ttimbraturenom[p1].tminutin_u - comodo1
    else
      comodo7:=comodo7 + ttimbraturedip[i6].tminutid_u - comodo1;*)
    inc(comodo7,Min(ttimbraturedip[i6].tminutid_u,PuntiNom.F(*ttimbraturenom[p1].tminutin_u*)) -
                Max(ttimbraturedip[i6].tminutid_e,PuntiNom.I(*ttimbraturenom[p1].tminutin_e*)));
    //Calcolo quanto le timbrature dipendente
    //sono distanti da quelle nominali
    if ttimbraturedip[i6].tminutid_e <= PuntiNom.I(*ttimbraturenom[p1].tminutin_e*) then
    //E anticipata o coincidente con quella nominale
    begin
      comodo8:=comodo8 + PuntiNom.I(*ttimbraturenom[p1].tminutin_e*) - ttimbraturedip[i6].tminutid_e;
      scostentrata:=scostentrata + PuntiNom.I(*ttimbraturenom[p1].tminutin_e*) - ttimbraturedip[i6].tminutid_e;
      if StrToIntDef(T220[selT220.FieldByName('Ritardo_Entrata').Index],-1) >= 0 then
        if (primat_u = 'no') or (i6 <> 1) or (estimbprec = 'no') then  //Alberto 08/02/2011: si esclude il controllo su OrarioDaEntrata quando si è sulla prima timbratura che è uno scavaldo di mezzanotte
        //if (primat_u = 'si') and (i6 = 1) and (estimbprec = 'si') then
          OrarioDaEntrata:=True;
    end
    else
    //E ritardata rispetto a quella nominale
    begin
      i1:=i6 - 1;
      if ((i6 - comodo6) = 1) or (ttimbraturedip[i6].tpuntnomin <> ttimbraturedip[i1].tpuntnomin) then
      begin
        Ritardo:=ttimbraturedip[i6].tminutid_e - PuntiNom.I(*ttimbraturenom[p1].tminutin_e*);
        comodo8:=comodo8 + Ritardo;
        scostentrata:=scostentrata + Ritardo;
        if StrToIntDef(T220[selT220.FieldByName('Ritardo_Entrata').Index],-1) >= 0 then
          if Ritardo <= StrToInt(T220[selT220.FieldByName('Ritardo_Entrata').Index]) then
            if (primat_u = 'no') or (i6 <> 1) or (estimbprec = 'no') then
              OrarioDaEntrata:=True;
      end;
    end;
    if ttimbraturedip[i6].tminutid_u >= PuntiNom.F(*ttimbraturenom[p1].tminutin_u*) then
      //U ritardata o coincidente con quella nominale
      comodo8:=comodo8 + ttimbraturedip[i6].tminutid_u - PuntiNom.F(*ttimbraturenom[p1].tminutin_u*)
    else
    //U anticipata rispetto a quella nominale
    begin
      i1:=i6 + 1;
      if (i6 = n_timbrdip) or (ttimbraturedip[i6].tpuntnomin <> ttimbraturedip[i1].tpuntnomin) then
      begin
        ant:=PuntiNom.F(*ttimbraturenom[p1].tminutin_u*) - ttimbraturedip[i6].tminutid_u;
        comodo8:=comodo8 + ant;
        if ant > minantscelta then
          //inc(comodo8,1000);
          inc(comodo8,StrToIntDef(T220[selT220.FieldByName('Peso_MinAntScelta').Index],PESO_MINANTSCELTA));
      end;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z512_spezztimb;
{Verifica se occorre spezzare i1-esima timbratura dipendente}
var i,j:Integer;
begin
  for i:=1 to n_timbrdip do
    for j:=1 to n_timbrnom - 1 do
      begin
      //4.0
      (*if (ttimbraturenom[j].tminutin_u <> ttimbraturenom[j+1].tminutin_e) or
         (ttimbraturedip[i].tminutid_u <= ttimbraturenom[j].tminutin_u) then
       Continue;*)
      if (ttimbraturenom[j].tminutin_e = ttimbraturenom[j+1].tminutin_e) or
         (ttimbraturenom[j].tminutin_u - ttimbraturenom[j+1].tminutin_e > 60) or
         (ttimbraturenom[j].tminutin_u - ttimbraturenom[j+1].tminutin_e < 0) then
        Continue;
      pe:=ttimbraturenom[j].tpuntre;
      pu:=ttimbraturenom[j+1].tpuntru;
      if pe = 0 then
        comodo8:=0
      else
        comodo8:=ValNumT021['MMRITARDO',TF_PUNTI_NOMINALI,pe];
      inc(comodo8,ttimbraturenom[j].tminutin_e);
      if ttimbraturedip[i].tminutid_e > comodo8 then
        Continue;
      if pu = 0 then
        comodo8:=0
      else
        comodo8:=ValNumT021['MMANTICIPOU',TF_PUNTI_NOMINALI,pu];
      comodo8:=ttimbraturenom[j+1].tminutin_u - comodo8;
      if ttimbraturedip[i].tminutid_u < comodo8 then
        Continue;
      //Sono stati lavorati due turni consecutivamente
      indice:=i + 1;
      //Inserimento della coppia E-U nelle timbrature dipendente
      z816_insetimbr;
      //tuscitad[indice]:=tuscitad[i];
      ttimbraturedip[indice].tminutid_u:=ttimbraturedip[i].tminutid_u;
      ttimbraturedip[indice].trilev_e:=ttimbraturedip[i].trilev_e;
      ttimbraturedip[indice].trilev_u:=ttimbraturedip[i].trilev_u;
      ttimbraturedip[indice].tcausale_u:=ttimbraturedip[i].tcausale_u;
      ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[i].tflagarr_u;
      //
      ttimbraturedip[i].tminutid_u:=ttimbraturenom[j].tminutin_u;
      ttimbraturedip[indice].tminutid_e:=ttimbraturenom[j].tminutin_u;
      ttimbraturedip[i].tflagarr_u:='si';
      ttimbraturedip[indice].tflagarr_e:='si';
      ttimbraturedip[i].tcausale_u:=tcausale_vuota;
      ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
      if (ttimbraturedip[i].tcausale_e.tcaus <> '') and
         (ttimbraturedip[i].tcausale_e.tcaus = ttimbraturedip[indice].tcausale_u.tcaus) and
         ((pianif = 'no') or ((pianif = 'si') and (l08_Turno1 <= 0))) then
        begin
        ttimbraturedip[i].tcausale_u:=ttimbraturedip[i].tcausale_e;
        ttimbraturedip[indice].tcausale_e:=ttimbraturedip[i].tcausale_e;
        end;
      //4.0 Indico l'avvenuta spezzatura
      ttimbraturedip[i].spezzata:=True;
      //4.0 Annullo la flessibilità sul secondo turno
      ttimbraturenom[j+1].tminutin_e:=ttimbraturedip[indice].tminutid_e;
      //Si forza la fine del ciclo
      Break;
      end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z520_Repdaturpian;
{Gestione reperibilità da turno pianificato}
var i:Integer;
    Esterna:Boolean;
    c:String;
begin
  for i:=1 to n_timbrdip do ttimbraturedip[i].tag:='';
  for i:=1 to n_timbrdip do ttimbraturedip[i].inserita:=False;
  i1:=1;
  SetLength(TurniReperibilita,0);
  while True do
  begin
    if i1 > n_timbrdip then
      Break;
    z522_repdaintur;
    inc(i1);
  end;
  //Gestione timbrature causalizzate ma esterne al turno di reperibilità
  i1:=1;
  while True do
  begin
    if i1 > n_timbrdip then
      Break;
    //Se c'è una causale di reperibilità solo su una delle due timbrature, la ignoro
    if (ttimbraturedip[i1].tcausale_e.tcaus <> ttimbraturedip[i1].tcausale_u.tcaus) then
      if (ttimbraturedip[i1].tcausale_e.tpianrep <> 'N') and
         ((ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c)) and
         (ttimbraturedip[i1].tcausale_e.tcaustip = 'B') then
      begin
        if (ttimbraturedip[i1].tcausale_e.tpianrep <> 'M') or GetNumTurniReperibilita(ttimbraturedip[i1].tcausale_e.tcausrag) then
          if (ttimbraturedip[i1].tag = '-' + ttimbraturedip[i1].tcausale_e.tcaus) and (ttimbraturedip[i1].tcausale_e.tpianrep = 'E') then
            //Causale solo su entrata, ma da eliminare perchè fuori fascia (come Gigli)
            ttimbraturedip[i1].tcausale_u:=ttimbraturedip[i1].tcausale_e
          else
            //ttimbraturedip[i1].tcausale_e:=tcausale_vuota
            ttimbraturedip[i1].tcausale_u:=ttimbraturedip[i1].tcausale_e;
      end
      else if (ttimbraturedip[i1].tcausale_u.tpianrep <> 'N') and
              ((ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[7].c)) and
              (ttimbraturedip[i1].tcausale_u.tcaustip = 'B') then
        if (ttimbraturedip[i1].tcausale_u.tpianrep <> 'M') or GetNumTurniReperibilita(ttimbraturedip[i1].tcausale_u.tcausrag) then
          ttimbraturedip[i1].tcausale_e:=ttimbraturedip[i1].tcausale_u;
          //ttimbraturedip[i1].tcausale_u:=tcausale_vuota;
    //Se la coppia è causalizzata in reperibilità ed è esterna ai turni pianificati si elimina
    if (ttimbraturedip[i1].tcausale_e.tcaus = ttimbraturedip[i1].tcausale_u.tcaus) and
       (ttimbraturedip[i1].tcausale_e.tpianrep <> 'N') and
       ((ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c)) and
       (ttimbraturedip[i1].tcausale_e.tcaustip = 'B') then
    begin
      Esterna:=True;
      for i:=0 to High(TurniReperibilita) do
      begin
        if (TurniReperibilita[i].Tipo = ttimbraturedip[i1].tcausale_e.tcausrag) and
           (ttimbraturedip[i1].tminutid_e >= TurniReperibilita[i].IT) and
           (ttimbraturedip[i1].tminutid_u <= TurniReperibilita[i].FT) then
        begin
          Esterna:=False;
          Break;
        end;
      end;
      //Verifico se ci sono turni di reperibilità o prest.aggiuntive in base al raggr.della causale
      if not(GetNumTurniReperibilita(ttimbraturedip[i1].tcausale_e.tcausrag)) and (ttimbraturedip[i1].tcausale_e.tpianrep = 'M') then
        Esterna:=False;
      if Esterna then
        if ttimbraturedip[i1].tcausale_e.tpianrep = 'E' then
        //Gigli: la timbratura è eliminata
        begin
          //Segnalazione anomalia
          //Imposto anomalia in base al raggr. della causale reperibilità o prest.aggiuntive
          if ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c then
            z098_anom2caus(48,Format('%s-%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_e),R180MinutiOre(ttimbraturedip[i1].tminutid_u)]))
          else
            z098_anom2caus(28,Format('%s-%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_e),R180MinutiOre(ttimbraturedip[i1].tminutid_u)]));
          indice:=i1;
          z802_toglitimbr;
          dec(i1);
        end
        else
        //la causale è annullata o decodificata in CAUS_FUORI_TURNO
        begin
          //Imposto anomalia in base al raggr. della causale reperibilità o prest.aggiuntive
          if ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c then
            z098_anom2caus(49,Format('%s-%s (%s)',[R180MinutiOre(ttimbraturedip[i1].tminutid_e),R180MinutiOre(ttimbraturedip[i1].tminutid_u),ttimbraturedip[i1].tcausale_e.tcaus]))
          else
            z098_anom2caus(30,Format('%s-%s (%s)',[R180MinutiOre(ttimbraturedip[i1].tminutid_e),R180MinutiOre(ttimbraturedip[i1].tminutid_u),ttimbraturedip[i1].tcausale_e.tcaus]));
          c:=ttimbraturedip[i1].tcausale_e.tcaus;
          ttimbraturedip[i1].tcausale_e:=tcausale_vuota;
          ttimbraturedip[i1].tcausale_u:=tcausale_vuota;
          if c <> '' then
            if R180CarattereDef(ValStrT275[c,'PIANIFREP']) in ['S','M'] then
            begin
              z964_leggicaus(ValStrT275[c,'CAUS_FUORI_TURNO']);
              if s_trovato = 'si' then
              begin
                z965_SettaCausPres(ttimbraturedip[i1].tcausale_e);
                z965_SettaCausPres(ttimbraturedip[i1].tcausale_u);
              end;
          end;
        end;
    end;
    inc(i1);
  end;
  for i:=1 to n_timbrdip do ttimbraturedip[i].tag:='';
  for i:=1 to n_timbrdip do ttimbraturedip[i].inserita:=False;
end;
//_________________________________________________________________
function TR502ProDtM1.z521_TimbEsterneAllaReperib(x:Integer):Char;
var i:Integer;
    Esterna:Boolean;
    c:String;
begin
  Result:='I';
  //Se la coppia è causalizzata in reperibilità ed è esterna ai turni pianificati si elimina
  if (ttimbraturedip[x].tcausale_e.tcaus = ttimbraturedip[x].tcausale_u.tcaus) and
     (ttimbraturedip[x].tcausale_e.tpianrep <> 'N') and
     ((ttimbraturedip[x].tcausale_e.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[x].tcausale_e.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[x].tcausale_e.tcausrag = traggrcauspr[7].c)) and
     (ttimbraturedip[x].tcausale_e.tcaustip = 'B') then
  begin
    Esterna:=True;
    for i:=0 to High(TurniReperibilita) do
    begin
      if (TurniReperibilita[i].Tipo = ttimbraturedip[x].tcausale_e.tcausrag) and
         (ttimbraturedip[x].tminutid_e >= TurniReperibilita[i].IT) and
         (ttimbraturedip[x].tminutid_u <= TurniReperibilita[i].FT) then
      begin
        Esterna:=False;
        Break;
      end;
    end;
    //Verifico se ci sono turni di reperibilità o prest.aggiuntive in base al raggr.della causale
    if not(GetNumTurniReperibilita(ttimbraturedip[x].tcausale_e.tcausrag)) and (ttimbraturedip[x].tcausale_e.tpianrep = 'M') then
      Esterna:=False;
    if Esterna then
      if ttimbraturedip[x].tcausale_e.tpianrep = 'E' then
        //Gigli: la timbratura è eliminata
      begin
        Result:='C';
        //Segnalazione anomalia
        //Imposto anomalia in base al raggr. della causale reperibilità o prest.aggiuntive
        if ttimbraturedip[x].tcausale_e.tcausrag = traggrcauspr[7].c then
          z098_anom2caus(48,Format('%s-%s',[R180MinutiOre(ttimbraturedip[x].tminutid_e),R180MinutiOre(ttimbraturedip[x].tminutid_u)]))
        else
          z098_anom2caus(28,Format('%s-%s',[R180MinutiOre(ttimbraturedip[x].tminutid_e),R180MinutiOre(ttimbraturedip[x].tminutid_u)]));
        indice:=x;
        z802_toglitimbr;
      end
      else
        //la causale è annullata
      begin
        Result:='A';
        //Imposto anomalia in base al raggr. della causale reperibilità o prest.aggiuntive
        if ttimbraturedip[x].tcausale_e.tcausrag = traggrcauspr[7].c then
          z098_anom2caus(49,Format('%s-%s (%s)',[R180MinutiOre(ttimbraturedip[x].tminutid_e),R180MinutiOre(ttimbraturedip[x].tminutid_u),ttimbraturedip[x].tcausale_e.tcaus]))
        else
          z098_anom2caus(30,Format('%s-%s (%s)',[R180MinutiOre(ttimbraturedip[x].tminutid_e),R180MinutiOre(ttimbraturedip[x].tminutid_u),ttimbraturedip[x].tcausale_e.tcaus]));
        c:=ttimbraturedip[i1].tcausale_e.tcaus;
        ttimbraturedip[x].tcausale_e:=tcausale_vuota;
        ttimbraturedip[x].tcausale_u:=tcausale_vuota;
        if c <> '' then
          if R180CarattereDef(ValStrT275[c,'PIANIFREP']) in ['S','M'] then
          begin
            z964_leggicaus(ValStrT275[c,'CAUS_FUORI_TURNO']);
            if s_trovato = 'si' then
            begin
              z965_SettaCausPres(ttimbraturedip[i1].tcausale_e);
              z965_SettaCausPres(ttimbraturedip[i1].tcausale_u);
            end;
          end;
      end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z522_repdaintur;
{Controlli timbrature causalizzate in reperibilità con turni pianificati in reperibilità}
var c,TurRep:String;
    i,j:Integer;
    D:TDateTime;
    TR:TTurniReperibilita;
begin
  //Funziona solo se una delle 2 causali è di reperibilità o prestazione aggiuntive ed ha
  //attivato il controllo sulla pianificazione turni
  if not ((ttimbraturedip[i1].tcausale_e.tcaustip = 'B') and ((ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c)) and
          (ttimbraturedip[i1].tcausale_e.tpianrep <> 'N') or
          (ttimbraturedip[i1].tcausale_u.tcaustip = 'B') and ((ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[7].c)) and
          (ttimbraturedip[i1].tcausale_u.tpianrep <> 'N')) then
    exit;
  //Verifica se dipendente pianificato in reperibilita' o prestazioni aggiuntive
  if not (Length(TurniReperibilita) > 0) then
  begin
    with Q332 do
    begin
      if not Active then
        exit;
      D:=DataCon - 1;
      //Leggo i turni di reperibilità per giorno precedente, corrente e successivo (solo se turno notturno completo su entrata)
      while D <= DataCon + IfThen(NotteSuEntrata and NotteSuEntrata_TurnoCompleto,1,0) do
      begin
        if SearchRecord('DATA',D,[srFromBeginning]) then
        begin
          while (FieldByName('DATA').AsDateTime <= D) and not Eof do
          begin
            //Verifico che il raggruppamento della causale coincida con il tipo di pianificazione turni
            for i:=1 to 3 do
              if Trim(FieldByName('TURNO' + IntToStr(i)).AsString) <> '' then
              begin
                TurRep:=FieldByName('TURNO' + IntToStr(i)).AsString;
                z523_GetTurniPerContrTimbrTurni(TurRep,FieldByName('RAG_PRES').AsString,FieldByName('DATA').AsDateTime);
                if TurRep = '' then Break;
              end
              else if (i < 3) and (Trim(FieldByName('ORAINIZIO_TURNO' + IntToStr(i)).AsString) <> '') and (Trim(FieldByName('ORAFINE_TURNO' + IntToStr(i)).AsString) <> '') then
              begin
                TurRep:='nullo';
                z523_GetTurniPerContrTimbrTurni('',FieldByName('RAG_PRES').AsString,FieldByName('DATA').AsDateTime,
                                                Trim(FieldByName('ORAINIZIO_TURNO' + IntToStr(i)).AsString),
                                                Trim(FieldByName('ORAFINE_TURNO' + IntToStr(i)).AsString));
              end;
            if TurRep = '' then Break;
            Next;
          end;
        end;
        D:=D + 1;
      end;
    end;
    //Ordino i turni di reperibilità e prestazioni aggiuntive
    for i:=0 to High(TurniReperibilita) + 1 do
      for j:=i + 1 to High(TurniReperibilita) do
      begin
        if (TurniReperibilita[i].Data = TurniReperibilita[j].Data) and
           (TurniReperibilita[j].IT < TurniReperibilita[i].IT) then
        begin
          TR:=TurniReperibilita[i];
          TurniReperibilita[i]:=TurniReperibilita[j];
          TurniReperibilita[j]:=TR;
        end;
      end;
  end;
  TimbInRep:=False;
  for i:=0 to High(TurniReperibilita) do
    z524_gesturrep(TurniReperibilita[i].IT,TurniReperibilita[i].FT,TurniReperibilita[i].Tipo);
  if (not ttimbraturedip[i1].inserita) and (not TimbInRep) and (ttimbraturedip[i1].tcausale_e.tcaus <> ttimbraturedip[i1].tcausale_u.tcaus) then
  begin
    if (ttimbraturedip[i1].tcausale_e.tcaustip = 'B') and
       ((ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c)) and
       (ttimbraturedip[i1].tcausale_e.tpianrep <> 'M') then
      ttimbraturedip[i1].tcausale_e:=tcausale_vuota;
    if (ttimbraturedip[i1].tcausale_u.tcaustip = 'B') and
       ((ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[7].c)) and
       (ttimbraturedip[i1].tcausale_u.tpianrep <> 'M') then
      ttimbraturedip[i1].tcausale_u:=tcausale_vuota;
  end;
  c:='';
  //Nessun turno pianificato e regola diversa da M (controllo solo con turno pianificato)
  //if TurniReperibilita[1].IT = -1 then
  if not TimbInRep then
    if (ttimbraturedip[i1].tcausale_e.tcaustip = 'B') and
       ((ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c)) and
       (ttimbraturedip[i1].tcausale_e.tpianrep <> 'M') then
    begin
      //Imposto anomalia in base al raggr. della causale reperibilità o prest.aggiuntive
      if ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c then
        z098_anom2caus(49,Format('%s (%s)',[R180MinutiOre(ttimbraturedip[i1].tminutid_e),ttimbraturedip[i1].tcausale_e.tcaus]))
      else
        z098_anom2caus(30,Format('%s (%s)',[R180MinutiOre(ttimbraturedip[i1].tminutid_e),ttimbraturedip[i1].tcausale_e.tcaus]));
      //if ttimbraturedip[i1].tcausale_u.tcaus <> '' then
        ttimbraturedip[i1].tcausale_e:=ttimbraturedip[i1].tcausale_u;
    end
    else if (ttimbraturedip[i1].tcausale_u.tcaustip = 'B') and
            ((ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_u.tcausrag = traggrcauspr[7].c)) and
            (ttimbraturedip[i1].tcausale_u.tpianrep <> 'M') then
    begin
      //Imposto anomalia in base al raggr. della causale reperibilità o prest.aggiuntive
      if ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c then
        z098_anom2caus(49,Format('%s (%s)',[R180MinutiOre(ttimbraturedip[i1].tminutid_u),ttimbraturedip[i1].tcausale_u.tcaus]))
      else
        z098_anom2caus(30,Format('%s (%s)',[R180MinutiOre(ttimbraturedip[i1].tminutid_u),ttimbraturedip[i1].tcausale_u.tcaus]));
      if ttimbraturedip[i1].tcausale_e.tcaus <> '' then
        ttimbraturedip[i1].tcausale_u:=ttimbraturedip[i1].tcausale_e;
    end;
  (*if c <> '' then
    if R180CarattereDef(ValStrT275[c,'PIANIFREP']) = 'S' then
    begin
      z964_leggicaus(ValStrT275[c,'CAUS_FUORI_TURNO']);
      if s_trovato = 'si' then
      begin
        z965_SettaCausPres(ttimbraturedip[i1].tcausale_e);
        z965_SettaCausPres(ttimbraturedip[i1].tcausale_u);
      end;
    end;*)
end;
//_________________________________________________________________
procedure TR502ProDtM1.z523_GetTurniPerContrTimbrTurni(T,TipoTurno:String; DT:TDateTime; OraInizio: String = ''; OraFine: String = '');
//Lettura inizio e fine del turno di reperibilità con limitazione al giorno corrente
var
  IT,FT,i:Integer;
  selTabTur:TOracleDataSet;
begin
  if (DT > Datacon) and (not NotteSuEntrata) and (not NotteSuEntrata_TurnoCompleto) then
    exit;
  selTabTur:=nil;
  if (TipoTurno = 'C') or (TipoTurno = 'D') then
    selTabTur:=Q350
  else if TipoTurno = 'G' then
    selTabTur:=Q330;
  if T <> '' then
  begin
    with selTabTur do
    begin
      if not SearchRecord('Codice',T,[srFromBeginning]) then
      begin
        //Imposto anomalia in base al tipo turno se reperibilità 'C' o prest.aggiuntive 'G'
        if (TipoTurno = 'C') or (TipoTurno = 'D') then
          z098_anom2caus(27,T)
        else if TipoTurno = 'G' then
          z098_anom2caus(45,T);
        exit;
      end;
      IT:=R180OreMinuti(FieldByName('ORAINIZIO').AsDateTime);
      FT:=R180OreMinuti(FieldByName('ORAFINE').AsDateTime);
    end;
  end
  else if TipoTurno = 'G' then
  begin
    //Turno di prestazioni aggiuntive con fascia oraria indicata esplicitamente
    if (OraInizio = '') or (OraFine = '') then
    begin
      if (OraInizio = '') then z098_anom2caus(68,OraInizio);
      if (OraFine = '') then z098_anom2caus(68,OraFine);
      exit;
    end;
    IT:=R180OreMinuti(OraInizio);
    FT:=R180OreMinuti(OraFine);
  end;
  if DT < DataCon then
  //Turno pianificato il giorno prima:
  //considero solo se a cavallo di mezzanotte (Inizio = 0)
  begin
    if (FT > IT) or (FT = 0) then
      exit
    else
      IT:=0;
  end
  else if DT = DataCon then
  begin
    //Turno pianificato il giorno corrente:
    //fine massimo a mezzanotte
    if FT <= IT then
      if NotteSuEntrata then
        FT:=FT + 1440
      else
        FT:=1440;
  end
  else if DT = DataCon + 1 then
  begin
    //Turno pianificato per il giorno successivo, possibile solo se abilitato NotteSuEntrata_TurnoCompleto
    //Sposto tutto avanti di 24 ore
    IT:=IT + 1440;
    FT:=FT + 1440;
    if FT <= IT then
      FT:=FT + 1440
  end;
  //Aggiungo il turno alla lista, ordinando per Inizio turno se riferiti allo stesso giorno
  SetLength(TurniReperibilita,Length(TurniReperibilita) + 1);
  i:=High(TurniReperibilita);
  TurniReperibilita[i].IT:=IT;
  TurniReperibilita[i].FT:=FT;
  TurniReperibilita[i].Data:=DT;
  TurniReperibilita[i].Tipo:=TipoTurno;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z524_gesturrep(IT,FT:Integer; TipoTurno:String);
{Gestione turno di reperibilita'}
begin
  //Timbratura compresa nel turno di reperibilità (tolgo l'appoggio)
  if (IT <= ttimbraturedip[i1].tminutid_e) and
     (FT >= ttimbraturedip[i1].tminutid_u) and
     (((ttimbraturedip[i1].tcausale_u.tcaustip = 'B') and (ttimbraturedip[i1].tcausale_u.tcausrag = TipoTurno))
      or
      ((ttimbraturedip[i1].tcausale_e.tcaustip = 'B') and (ttimbraturedip[i1].tcausale_e.tcausrag = TipoTurno))) then
  begin
    TimbInRep:=True;
    ttimbraturedip[i1].tpuntnomin:=0;
    if (ttimbraturedip[i1].tcausale_u.tcaustip = 'B') and
       (ttimbraturedip[i1].tcausale_u.tcausrag = TipoTurno) then
      ttimbraturedip[i1].tcausale_e:=ttimbraturedip[i1].tcausale_u
    else
      ttimbraturedip[i1].tcausale_u:=ttimbraturedip[i1].tcausale_e;
  end
  else
  //Turno di reperibilità compreso nella coppia di timbrature:
  //deve essere causalizzata come reperibilità l'entrata opp. l'uscita
  if (IT >= ttimbraturedip[i1].tminutid_e) and
     (IT <= ttimbraturedip[i1].tminutid_u) and
     (FT >= ttimbraturedip[i1].tminutid_e) and
     (FT <= ttimbraturedip[i1].tminutid_u) and
     (((ttimbraturedip[i1].tcausale_u.tcaustip = 'B') and (ttimbraturedip[i1].tcausale_u.tcausrag = TipoTurno))
      or
      ((ttimbraturedip[i1].tcausale_e.tcaustip = 'B') and (ttimbraturedip[i1].tcausale_e.tcausrag = TipoTurno))) then
  begin
    TimbInRep:=True;
    z527_FasciaAbilitazioneInterna(IT,FT,TipoTurno,True);
  end
  else
  //Gestione Inizio turno compreso tra entrata ed uscita:
  //deve essere causalizzata come reperibilità l'uscita
  if (IT > ttimbraturedip[i1].tminutid_e) and
     (IT < ttimbraturedip[i1].tminutid_u) and
     (ttimbraturedip[i1].tcausale_u.tcaustip = 'B') and
     (ttimbraturedip[i1].tcausale_u.tcausrag = TipoTurno) then
  begin
    TimbInRep:=True;
    z525_InizioFasciaAbilitazione(IT,FT,TipoTurno,True);
  end
  else
  //Gestione Fine turno compreso tra entrata ed uscita:
  //deve essere causalizzata come reperibilità l'entrata
  //oppure la timbratura è inserita da un turno precedente, ed è causalizzata l'uscita
  if (FT > ttimbraturedip[i1].tminutid_e) and
     (FT < ttimbraturedip[i1].tminutid_u) and
     ((ttimbraturedip[i1].tcausale_e.tcaustip = 'B') and (ttimbraturedip[i1].tcausale_e.tcausrag = TipoTurno) or
      (ttimbraturedip[i1].inserita and
      (ttimbraturedip[i1].tcausale_u.tcaustip = 'B') and (ttimbraturedip[i1].tcausale_u.tcausrag = TipoTurno))
     )
  then
  begin
    TimbInRep:=True;
    z526_FineFasciaAbilitazione(IT,FT,TipoTurno,True);
  end;
end;

procedure TR502ProDtM1.z525_InizioFasciaAbilitazione(IT,FT:Integer; TipoTurno:String; TurnoReperibilita:Boolean);
{Inizio fascia di abilitazione compreso tra E-U: causalizzata l'uscita
 i1: timbratura precedente all'abilitazione
 indice: timbratura nella fascia di abilitazione }
//var c:String;
begin
  indice:=i1 + 1;
  //Inserimento timbrature nella fascia di abilitazione
  z816_insetimbr;
  ttimbraturedip[indice].tminutid_e:=IT;
  ttimbraturedip[indice].tminutid_u:=ttimbraturedip[i1].tminutid_u;
  ttimbraturedip[indice].trilev_e:=ttimbraturedip[i1].trilev_e;
  ttimbraturedip[indice].trilev_u:=ttimbraturedip[i1].trilev_u;
  ttimbraturedip[indice].tcausale_e:=ttimbraturedip[i1].tcausale_u;
  ttimbraturedip[indice].tcausale_u:=ttimbraturedip[i1].tcausale_u;
  ttimbraturedip[indice].tflagarr_e:='si';
  ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[i1].tflagarr_u;
  ttimbraturedip[indice].tpuntnomin:=0;
  ttimbraturedip[indice].tag:='';
  //
  ttimbraturedip[i1].tminutid_u:=IT;
  ttimbraturedip[i1].tflagarr_u:='si';
  ttimbraturedip[i1].tcausale_u:=tcausale_vuota;//ttimbraturedip[i1].tcausale_e; //Riporto la causalizzazione dell'entrata sull'uscita
  (*c:=ttimbraturedip[i1].tcausale_e.tcaus;
  if (R180CarattereDef(ValStrT275[c,'PIANIFREP']) in ['S','M']) then
  begin
    z964_leggicaus(ValStrT275[c,'CAUS_FUORI_TURNO']);
    if s_trovato = 'si' then
    begin
      z965_SettaCausPres(ttimbraturedip[i1].tcausale_e);
      z965_SettaCausPres(ttimbraturedip[i1].tcausale_u);
    end;
  end;*)
  if (ttimbraturedip[i1].tag = '') and (ttimbraturedip[i1].tcausale_e.tcaus <> '') then
    ttimbraturedip[i1].tag:='-' + ttimbraturedip[i1].tcausale_e.tcaus;// sembra più giusto riferirsi alla causale originaria piuttosto che a -> ttimbraturedip[indice].tcausale_e.tcaus;
  //Segnalazione anomalia
  //Imposto anomalia in base al tipo turno se reperibilità 'C' o prest.aggiuntive 'G'
  if (TipoTurno = 'C') or (TipoTurno = 'D') then
    z098_anom2caus(25,Format('%s',[R180MinutiOre(ttimbraturedip[indice].tminutid_e)]))
  else if TipoTurno = 'G' then
    z098_anom2caus(46,Format('%s',[R180MinutiOre(ttimbraturedip[indice].tminutid_e)]))
  //Segnalazione anomalia per causale generica di entrata esterna alla fascia
  else if TipoTurno = '*' then
    z098_anom2caus(36,Format('%s',[R180MinutiOre(ttimbraturedip[indice].tminutid_e)]));
  //Incremento i1 per saltare la timbratura appena inserita
  inc(i1);
end;

procedure TR502ProDtM1.z526_FineFasciaAbilitazione(IT,FT:Integer; TipoTurno:String; TurnoReperibilita:Boolean);
{Fine fascia di abilitazione compreso tra E-U: causalizzata l'entrata
 i1: timbratura nella fascia di abilitazione
 indice: timbratura successiva alla fascia di abilitazione}
begin
  //Alberto 17/05/2019
  //Se timbratura inserita da turno precedente, riporto la causale dell'Uscita sull'Entrata
  if ttimbraturedip[i1].inserita and (ttimbraturedip[i1].tcausale_e.tcaus = tcausale_vuota.tcaus) then
  begin
    ttimbraturedip[i1].tcausale_e:=ttimbraturedip[i1].tcausale_u;
    ttimbraturedip[i1].tag:='';
  end;

  indice:=i1 + 1;
  //Inserimento timbratura successiva alla fascia di abilitazione
  z816_insetimbr;
  ttimbraturedip[indice].inserita:=True;
  ttimbraturedip[indice].tminutid_e:=FT;
  ttimbraturedip[indice].tminutid_u:=ttimbraturedip[i1].tminutid_u;
  ttimbraturedip[indice].trilev_e:=ttimbraturedip[i1].trilev_e;
  ttimbraturedip[indice].trilev_u:=ttimbraturedip[i1].trilev_u;
  ttimbraturedip[indice].tflagarr_e:='si';
  ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[i1].tflagarr_u;
  ttimbraturedip[indice].tcausale_e:=tcausale_vuota;//ttimbraturedip[indice].tcausale_u;  //Riporto la causalizzazione dell'uscita sull'entrata
  ttimbraturedip[indice].tcausale_u:=ttimbraturedip[i1].tcausale_u;
  (*c:=ttimbraturedip[i1].tcausale_u.tcaus;
  if (R180CarattereDef(ValStrT275[c,'PIANIFREP']) in ['S','M']) then
  begin
    z964_leggicaus(ValStrT275[c,'CAUS_FUORI_TURNO']);
    if s_trovato = 'si' then
    begin
      z965_SettaCausPres(ttimbraturedip[indice].tcausale_e);
      z965_SettaCausPres(ttimbraturedip[indice].tcausale_u);
    end;
  end;*)
  if (ttimbraturedip[indice].tag = '') and (ttimbraturedip[indice].tcausale_u.tcaus <> '') then
    ttimbraturedip[indice].tag:='+' + ttimbraturedip[indice].tcausale_u.tcaus;//ttimbraturedip[i1].tcausale_e.tcaus;
  //
  ttimbraturedip[i1].tminutid_u:=FT;
  ttimbraturedip[i1].tcausale_u:=ttimbraturedip[i1].tcausale_e;
  ttimbraturedip[i1].tflagarr_u:='si';
  ttimbraturedip[i1].tag:='';
  z061_appoggioc1(indice);
  ttimbraturedip[i1].tpuntnomin:=0;
  //Segnalazione anomalia
  //Imposto anomalia in base al tipo turno se reperibilità 'C' o prest.aggiuntive 'G'
  if (TipoTurno = 'C') or (TipoTurno = 'D') then
    z098_anom2caus(25,Format('%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_u)]))
  else if TipoTurno = 'G' then
    z098_anom2caus(46,Format('%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_u)]))
  //Segnalazione anomalia per causale generica di uscita esterna alla fascia
  else if TipoTurno = '*' then
    z098_anom2caus(36,Format('%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_u)]));
  //Incremento i1 per saltare la timbratura appena inserita
  if (TipoTurno = 'C') or (TipoTurno = 'D') or (TipoTurno = 'G') then
    inc(i1);
end;

procedure TR502ProDtM1.z527_FasciaAbilitazioneInterna(IT,FT:Integer; TipoTurno:String; TurnoReperibilita:Boolean);
{La fascia di abilitazione è compresa tra Entrata e Uscita}
var CausRif:t_tcausale;
//    c:String;
begin
  if TurnoReperibilita then
  begin
    //Registro la causale di reperibilità
    if (ttimbraturedip[i1].tcausale_e.tcaustip = 'B') and ((ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[3].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[4].c) or (ttimbraturedip[i1].tcausale_e.tcausrag = traggrcauspr[7].c)) then
      CausRif:=ttimbraturedip[i1].tcausale_e
    else
      CausRif:=ttimbraturedip[i1].tcausale_u;
  end
  else
  begin
    //Registro la causale utilizzata
    if ttimbraturedip[i1].tcausale_e.tcaus <> '' then
      CausRif:=ttimbraturedip[i1].tcausale_e
    else
      CausRif:=ttimbraturedip[i1].tcausale_u;
  end;
  indice:=i1 + 1;
  //Inserimento timbratura successiva alla fascia di abilitazione
  z816_insetimbr;
  ttimbraturedip[indice].tminutid_u:=ttimbraturedip[i1].tminutid_u;
  ttimbraturedip[indice].tminutid_e:=FT;
  ttimbraturedip[indice].trilev_e:=ttimbraturedip[i1].trilev_e;
  ttimbraturedip[indice].trilev_u:=ttimbraturedip[i1].trilev_u;
  (*if TurnoReperibilita then
    ttimbraturedip[indice].tcausale_e:=tcausale_vuota
  else*)
    ttimbraturedip[indice].tcausale_e:=tcausale_vuota;//ttimbraturedip[i1].tcausale_e;
  ttimbraturedip[indice].tcausale_u:=ttimbraturedip[i1].tcausale_u; //Riporto la causalizzazione dell'uscita
  (*c:=CausRif.tcaus;
  if (R180CarattereDef(ValStrT275[c,'PIANIFREP']) in ['S','M']) then
  begin
    z964_leggicaus(ValStrT275[c,'CAUS_FUORI_TURNO']);
    if s_trovato = 'si' then
    begin
      z965_SettaCausPres(ttimbraturedip[indice].tcausale_e);
      z965_SettaCausPres(ttimbraturedip[indice].tcausale_u);
    end;
  end;*)
  ttimbraturedip[indice].tflagarr_e:='si';
  ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[i1].tflagarr_u;
  z061_appoggioc1(indice);
  //timbratura precedente alla fascia di abilitazione
  ttimbraturedip[i1].tminutid_u:=IT;
  ttimbraturedip[i1].tflagarr_u:='si';
  ttimbraturedip[i1].tcausale_u:=tcausale_vuota;
  if not TurnoReperibilita then
    ttimbraturedip[i1].tcausale_e:=tcausale_vuota;
  (*c:=CausRif.tcaus;
  if (R180CarattereDef(ValStrT275[c,'PIANIFREP']) in ['S','M']) then
  begin
    z964_leggicaus(ValStrT275[c,'CAUS_FUORI_TURNO']);
    if s_trovato = 'si' then
    begin
      z965_SettaCausPres(ttimbraturedip[i1].tcausale_e);
      z965_SettaCausPres(ttimbraturedip[i1].tcausale_u);
    end;
  end;*)
  z061_appoggioc1(i1);
  //Timbratura nella fascia di abilitazione
  z816_insetimbr;
  ttimbraturedip[indice].tminutid_u:=FT;
  ttimbraturedip[indice].tminutid_e:=IT;
  ttimbraturedip[indice].tcausale_e:=CausRif;
  ttimbraturedip[indice].tcausale_u:=CausRif;
  ttimbraturedip[indice].tflagarr_e:='si';
  ttimbraturedip[indice].tflagarr_u:='si';
  ttimbraturedip[indice].tpuntnomin:=0;
  ttimbraturedip[indice].tag:='';
  ttimbraturedip[indice - 1].tag:='-' + CausRif.tcaus;
  ttimbraturedip[indice + 1].tag:='+' + CausRif.tcaus;
  ttimbraturedip[indice + 1].inserita:=True;
  if TurnoReperibilita then
  begin
    //Segnalazione anomalia
    //Imposto anomalia in base al tipo turno se reperibilità 'C' o prest.aggiuntive 'G'
    if (TipoTurno = 'C') or (TipoTurno = 'D') then
      z098_anom2caus(25,Format('%s-%s',[R180MinutiOre(ttimbraturedip[indice].tminutid_e),R180MinutiOre(ttimbraturedip[indice].tminutid_u)]))
    else if TipoTurno = 'G' then
      z098_anom2caus(46,Format('%s-%s',[R180MinutiOre(ttimbraturedip[indice].tminutid_e),R180MinutiOre(ttimbraturedip[indice].tminutid_u)]));
    //Incremento i1 per saltare le 2 timbrature appena inserite
    inc(i1);
  end
  else
  begin
    //Segnalazione anomalia
    z098_anom2caus(36,Format('%s-%s',[R180MinutiOre(ttimbraturedip[indice].tminutid_e),R180MinutiOre(ttimbraturedip[indice].tminutid_u)]));
    //Incremento i1 per saltare la timbratura inserita nella fascia, ma si considera quella seguente
    inc(i1);
  end
end;
//_________________________________________________________________
procedure TR502ProDtM1.z540_FasceCausalizzazione(FascePN:Boolean = False);
{Gestione delle fasce di abilitazione alla causalizzazione (12/11/2002 Genova_HSMartino)}
var i:Integer;
    FasceGestite:Boolean;
begin
  PuntiNominali277:='';
  FasceGestite:=False;
  for i:=1 to n_timbrdip do
  begin
    ttimbraturedip[i].tag:='';
    //seconda chiamata: salvo i punti nominali attivi al momento per poi utilizzarli come fasce di abilitazione per le causali che hanno le fasce di abilitazione ai punti nominali
    if FascePN and (ttimbraturedip[i].tpuntnomin <> 0) then
      PuntiNominali277:=PuntiNominali277 + ',' + IntToStr(ttimbraturedip[i].tpuntnomin);
    //seconda chiamata: ripristino delle causali con fasce di autorizzazione ai punti nominali
    if FascePN and (ttimbraturedip[i].tcausale_e.tcaus_orig <> '') then
    begin
      ttimbraturedip[i].tcausale_e.tcaus:=ttimbraturedip[i].tcausale_e.tcaus_orig;
      ttimbraturedip[i].tcausale_e.tcaus_orig:='';
    end;
    if FascePN and (ttimbraturedip[i].tcausale_u.tcaus_orig <> '') then
    begin
      ttimbraturedip[i].tcausale_u.tcaus:=ttimbraturedip[i].tcausale_u.tcaus_orig;
      ttimbraturedip[i].tcausale_u.tcaus_orig:='';
    end;
  end;
  i1:=1;
  while i1 <= n_timbrdip do
  begin
    if (ttimbraturedip[i1].tcausale_e.tcaus <> '') or
       (ttimbraturedip[i1].tcausale_u.tcaus <> '') then
      //Alberto 20/03/2010 - Empoli_ASL11: prima chiamata: annullo le causali salvandole in tcaus_orig per poi ripristinarle nella seconda chiamata
      if (not FascePN) and (z543_CausaleFascePN(ttimbraturedip[i1].tcausale_e.tcaus,FascePN) or z543_CausaleFascePN(ttimbraturedip[i1].tcausale_u.tcaus,FascePN)) then
      begin
        //Se la causale con FascePN è solo su una delle due, la annullo e lascio l'altra
        if not z543_CausaleFascePN(ttimbraturedip[i1].tcausale_e.tcaus,FascePN) then
          ttimbraturedip[i1].tcausale_u.tcaus:='';
        if not z543_CausaleFascePN(ttimbraturedip[i1].tcausale_u.tcaus,FascePN) then
          ttimbraturedip[i1].tcausale_e.tcaus:='';
        if (ttimbraturedip[i1].tcausale_e.tcaus <> '') and (ttimbraturedip[i1].tcausale_u.tcaus <> '') then
        begin
          ttimbraturedip[i1].tcausale_e.tcaus_orig:=ttimbraturedip[i1].tcausale_e.tcaus;
          ttimbraturedip[i1].tcausale_u.tcaus_orig:=ttimbraturedip[i1].tcausale_u.tcaus;
          ttimbraturedip[i1].tcausale_e.tcaus:='';
          ttimbraturedip[i1].tcausale_u.tcaus:='';
        end;
      end
      else if (not FascePN) or (FascePN and (z543_CausaleFascePN(ttimbraturedip[i1].tcausale_e.tcaus,FascePN) and z543_CausaleFascePN(ttimbraturedip[i1].tcausale_u.tcaus,FascePN))) then
      begin
        z542_GestioneFasceAbilitazione(FascePN);
        FasceGestite:=True;
      end;
    inc(i1);
  end;
  //Eliminazione timbrature esterne alle fasce di autorizzazione che devono essere perse
  i1:=1;
  while i1 <= n_timbrdip do
  begin
    if (Copy(ttimbraturedip[i1].tag,1,1) = '-') and
       (ValStrT275[Trim(Copy(ttimbraturedip[i1].tag,2,5)),'TIPO_NONAUTORIZZATE'] = 'P') then
    begin
      indice:=i1;
      z802_toglitimbr;
    end
    else if (Copy(ttimbraturedip[i1].tag,1,1) = '+') and
       (ValStrT275[Trim(Copy(ttimbraturedip[i1].tag,2,5)),'TIPO_U_NONAUTORIZZATE'] = 'P') then
    begin
      indice:=i1;
      z802_toglitimbr;
    end
    else
    begin
      ttimbraturedip[i1].tag:='';
      inc(i1);
    end;
  end;
  if FascePN and FasceGestite then
    //Tolgo appoggio alle timbrature causalizzate con 'Ore esterne all'orario' se ci sono state gestioni delle fasce relative ai punti nominali
    z1003_StraordinarioForzato;
end;
//_________________________________________________________________
function TR502ProDtM1.z541_GetFasceAutorizzazione(Causale:String; DataRif,Data:TDateTime; FascePN:Boolean = False):Boolean;
{Lettura delle fasce di autorizzazione previste per il giorno Data}
var Festivo,FestivoSuc,Lavorativo:Char;
    TipiGG:String;
    IT,FT,H,i,j,k:Integer;
    PN:Boolean;
  procedure SettaFasceAbilitazione;
  begin
    if (Data = DataRif) or (FT <= IT) then
    begin
      if Data < DataRif then
        //Giorno precedente: considero solo se a cavallo di mezzanotte (Inizio = 0)
        IT:=0
      else if FT <= IT then
        //Giorno corrente: fine massimo a mezzanotte opp. turno notturno
        if NotteSuEntrata then
          FT:=FT + 1440
        else if DataRif = DataCon then //Alberto 07/05/2010: gestito il nuovo parametro DataRif usato nei gettoni per leggere la fascia del giorno prima che accavalla mezzanotte
          FT:=1440;
      H:=High(FasceAbilitazione277) + 1;
      SetLength(FasceAbilitazione277,H + 1);
      FasceAbilitazione277[H].IT:=IT;
      FasceAbilitazione277[H].FT:=FT;
      FasceAbilitazione277[H].PN:=PN;
    end;
    if (Data = DataRif + 1) then
    begin
      if not (FascePN and NotteSuEntrata) then
      begin
        if FT <= IT then
          FT:=1440;
        IT:=IT + 1440;
        FT:=FT + 1440;
      end;
      H:=High(FasceAbilitazione277) + 1;
      SetLength(FasceAbilitazione277,H + 1);
      FasceAbilitazione277[H].IT:=IT;
      FasceAbilitazione277[H].FT:=FT;
      FasceAbilitazione277[H].PN:=PN;
    end;
  end;
begin
  with selT277 do
  begin
    Filtered:=False;
    Result:=SearchRecord('CODICE',Causale,[srFromBeginning]);
    if not Result then
      exit;
    Result:=True;
    if Data = (DataCon - 1) then
    begin
      Festivo:=TipoGG_prec;
      FestivoSuc:=TipoGG;
      Lavorativo:=TipoGGLav_prec;
    end
    else if Data = (DataCon + 1) then
    begin
      Festivo:=TipoGG_suc;
      FestivoSuc:=TipoGG_suc2;
      Lavorativo:=TipoGGLav_suc;
    end
    else //Data = DataCon
    begin
      Festivo:=TipoGG;
      FestivoSuc:=TipoGG_suc;
      Lavorativo:=tipogglav;
    end;
    TipiGG:='(TIPO_GIORNO=''T'') OR (TIPO_GIORNO=''' + IntToStr(DayOfWeek(Data - 1)) + ''')';
    if Festivo = 'F' then
    begin
      TipiGG:=TipiGG + ' OR (TIPO_GIORNO=''F'')';  //Festivi
      if DayOfWeek(Data - 1) <> 7 then
        TipiGG:=TipiGG + ' OR (TIPO_GIORNO=''I'')';  //Festivi infrasettimanali
    end
    else if Lavorativo = 'S' then
      TipiGG:=TipiGG + ' OR (TIPO_GIORNO=''L'')'  //Lavorativi
    else
      TipiGG:=TipiGG + ' OR (TIPO_GIORNO=''N'')';  //Non lavorativi
    if (Festivo <> 'F') and (FestivoSuc = 'F') then
      TipiGG:=TipiGG + ' OR (TIPO_GIORNO=''P'')';  //Prefestivi
    Filter:='(CODICE = ''' + Causale + ''') AND (' + TipiGG + ')';
    Filtered:=True;
    while not Eof do
    begin
      //Alberto 20/03/2010 - Empoli_ASL11: le fasce di autorizzazione sono i punti nominali letti nella prima chiamata alla z540
      if FieldByName('FASCE_PN').AsString = 'N' then
      begin
        IT:=R180OreMinutiExt(FieldByName('DALLE').AsString);
        FT:=R180OreMinutiExt(FieldByName('ALLE').AsString);
        PN:=False;
        SettaFasceAbilitazione;
      end
      else if (Data = DataCon) or ((DataRif = DataCon) and (Data = DataCon + 1) and NotteSuEntrata) then
      begin
        if n_timbrnom = 0 then //Orario libero senza punti nominali
        begin
          IT:=0;
          FT:=0;
          PN:=True;
          SettaFasceAbilitazione;
        end
        else
          for i:=1 to n_timbrnom do
            //Considero i punti nominali usati nelle sole ttimbraturedip oppure tutti se sono nella prima chiamata della z540 o se non c'è nessun punto nominale utilizzato (tutto in straordinario)
            if (not FascePN) or (PuntiNominali277 = '') or (Pos(IntToStr(i),',' + PuntiNominali277 + ',') > 0) then
            begin
              IT:=ttimbraturenom[i].tminutin_e;
              FT:=ttimbraturenom[i].tminutin_u;
              PN:=True;
              if Pos(',' + Causale + ',',',' + CausaliPuntiNominali277 + ',') = 0 then
                CausaliPuntiNominali277:=CausaliPuntiNominali277 + ',' + Causale;
              SettaFasceAbilitazione;
            end;
      end;
      Next;
    end;
  end;
  //Alberto 01/06/2006: compatto i periodi trovati in modo che periodi intersecanti
  //vengano considerati in un unico periodo (es: 8-12, 10-16 -> 8-16)
  i:=0;
  while i < High(FasceAbilitazione277) do
  begin
    //Ciclo per allargare i turni
    for j:=i + 1 to High(FasceAbilitazione277) do
    begin
      //Allargo l'inizio turno
      if (FasceAbilitazione277[j].IT < FasceAbilitazione277[i].IT) and
         (Min(FasceAbilitazione277[j].FT,FasceAbilitazione277[i].IT) = FasceAbilitazione277[i].IT) then
        FasceAbilitazione277[i].IT:=FasceAbilitazione277[j].IT;
      //Allargo la fine turno
      if (FasceAbilitazione277[j].FT > FasceAbilitazione277[i].FT) and
         (Max(FasceAbilitazione277[j].IT,FasceAbilitazione277[i].FT) = FasceAbilitazione277[i].FT) then
        FasceAbilitazione277[i].FT:=FasceAbilitazione277[j].FT;
    end;
    //Ciclo per eliminare i turni ridondanti
    j:=i + 1;
    while j <= High(FasceAbilitazione277) do
    begin
      if (FasceAbilitazione277[i].IT <= FasceAbilitazione277[j].IT) and
         (FasceAbilitazione277[i].FT >= FasceAbilitazione277[j].FT) then
      begin
        for k:=j + 1 to High(FasceAbilitazione277) do
          FasceAbilitazione277[k - 1]:=FasceAbilitazione277[k];
        SetLength(FasceAbilitazione277,Length(FasceAbilitazione277) -1);
      end
      else
        inc(j);
    end;
    inc(i);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z542_GestioneFasceAbilitazione(FascePN:Boolean = False);
{Controllo sulla causalizzazione della coppia di timbrature}
var i:Integer;
  procedure AutorizzazioneGiornoPrec;
  {Gestione della coppia di timbrature rispetto alle fasce e alla causalizzazione sull'entrata}
  var i:Integer;
      Gestita:Boolean;
  begin
    //Se non ci sono fasce disponibili per il giorno si annulla la causale
    if Length(FasceAbilitazione277) = 0 then
    begin
      z098_anom2caus(35,Format('%s',[R180MinutiOre(minuti_pre)]));
      minuti_pre_caus:=1440;
      exit;
    end;
    Gestita:=False;
    for i:=0 to High(FasceAbilitazione277) do
      if (minuti_pre >= FasceAbilitazione277[i].IT) and (minuti_pre < FasceAbilitazione277[i].FT) and
         (FasceAbilitazione277[i].FT >= 1440) then
      begin
        Gestita:=True;
        minuti_pre_caus:=1440;
        Break;
      end
      else if (minuti_pre < FasceAbilitazione277[i].IT) and
              (FasceAbilitazione277[i].FT >= 1440) then
      begin
        Gestita:=True;
        minuti_pre_caus:=FasceAbilitazione277[i].IT;
        Break;
      end;
    if not Gestita then
    begin
      z098_anom2caus(35,Format('%s',[R180MinutiOre(minuti_pre)]));
      minuti_pre_caus:=1440;
    end;
  end;
  procedure AutorizzazioneEntrata;
  {Gestione della coppia di timbrature rispetto alle fasce e alla causalizzazione sull'entrata}
  var i:Integer;
      Gestita:Boolean;
  begin
    //Se non ci sono fasce disponibili per il giorno si annulla la causale
    if Length(FasceAbilitazione277) = 0 then
    begin
      ttimbraturedip[i1].tcausale_e:=tcausale_vuota;
      z098_anom2caus(35,Format('%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_e)]));
      exit;
    end;
    Gestita:=False;
    for i:=0 to High(FasceAbilitazione277) do
      if (ttimbraturedip[i1].tminutid_e >= FasceAbilitazione277[i].IT) and (ttimbraturedip[i1].tminutid_e < FasceAbilitazione277[i].FT) then
      begin
        if ttimbraturedip[i1].tcausale_u.tcaus <> ttimbraturedip[i1].tcausale_e.tcaus then
        begin
          tcausale.tcaus:=ttimbraturedip[i1].tcausale_e.tcaus;
          z098_anom2caus(8);
        end;
        //entrata interna alla fascia
        if ttimbraturedip[i1].tminutid_u <= FasceAbilitazione277[i].FT then
        begin
          //uscita interna alla fascia
          //ttimbraturedip[i1].tpuntnomin:=0;
          ttimbraturedip[i1].tcausale_u:=ttimbraturedip[i1].tcausale_e;
          Gestita:=True;
        end
        else
        begin
          z526_FineFasciaAbilitazione(FasceAbilitazione277[i].IT,FasceAbilitazione277[i].FT,'*',False);
          ttimbraturedip[i1 + 1].tcausale_e:=ttimbraturedip[i1].tcausale_u;
          Gestita:=True;
          Break;
        end;
      end
      else if (ttimbraturedip[i1].tminutid_e < FasceAbilitazione277[i].IT) and
              (ttimbraturedip[i1].tminutid_u > FasceAbilitazione277[i].FT) then
      begin
        if (ttimbraturedip[i1].tcausale_e.tcaus = ttimbraturedip[i1].tcausale_u.tcaus) then
        begin
          //Fascia interna alla coppia di timbrature
          z527_FasciaAbilitazioneInterna(FasceAbilitazione277[i].IT,FasceAbilitazione277[i].FT,'',False);
          Gestita:=True;
        end
        else
        begin
          tcausale.tcaus:=ttimbraturedip[i1].tcausale_e.tcaus;
          z098_anom2caus(6);
        end;
      end;
    if not Gestita then
    begin
      ttimbraturedip[i1].tag:='-' + ttimbraturedip[i1].tcausale_e.tcaus;
      ttimbraturedip[i1].tcausale_e:=tcausale_vuota;
      z098_anom2caus(35,Format('%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_e)]));
    end;
  end;
  procedure AutorizzazioneUscita;
  {Gestione della coppia di timbrature rispetto alle fasce e alla causalizzazione sull'uscita}
  var i:Integer;
      Gestita:Boolean;
  begin
    //Se non ci sono fasce disponibili per il giorno si annulla la causale
    if Length(FasceAbilitazione277) = 0 then
    begin
      ttimbraturedip[i1].tcausale_u:=tcausale_vuota;
      z098_anom2caus(35,Format('%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_u)]));
      exit;
    end;
    Gestita:=False;
    for i:=0 to High(FasceAbilitazione277) do
      if (ttimbraturedip[i1].tminutid_u > FasceAbilitazione277[i].IT) and (ttimbraturedip[i1].tminutid_u <= FasceAbilitazione277[i].FT) then
      begin
        if ttimbraturedip[i1].tcausale_u.tcaus <> ttimbraturedip[i1].tcausale_e.tcaus then
        begin
          tcausale.tcaus:=ttimbraturedip[i1].tcausale_u.tcaus;
          z098_anom2caus(8);
        end;
        //uscita interna alla fascia
        if ttimbraturedip[i1].tminutid_e >= FasceAbilitazione277[i].IT then
        begin
          //entrata interna alla fascia
          //ttimbraturedip[i1].tpuntnomin:=0;
          ttimbraturedip[i1].tcausale_e:=ttimbraturedip[i1].tcausale_u;
          Gestita:=True;
        end
        else
        begin
          //entrata esterna alla fascia
          z525_InizioFasciaAbilitazione(FasceAbilitazione277[i].IT,FasceAbilitazione277[i].FT,'*',False);
          Gestita:=True;
        Break;
        end;
      end
      else if ((ttimbraturedip[i1].tcausale_e.tcaus <> '') or (ttimbraturedip[i1].tcausale_u.tcaus <> '')) and
              (ttimbraturedip[i1].tminutid_e < FasceAbilitazione277[i].IT) and
              (ttimbraturedip[i1].tminutid_u > FasceAbilitazione277[i].FT) then
      begin
        //Fascia interna alla coppia di timbrature
        if ttimbraturedip[i1].tcausale_e.tcaus <> ttimbraturedip[i1].tcausale_u.tcaus then
        begin
          tcausale.tcaus:=IfThen(ttimbraturedip[i1].tcausale_e.tcaus <> '',ttimbraturedip[i1].tcausale_e.tcaus,ttimbraturedip[i1].tcausale_u.tcaus);
          z098_anom2caus(8);
        end;
        z527_FasciaAbilitazioneInterna(FasceAbilitazione277[i].IT,FasceAbilitazione277[i].FT,'*',False);
        Gestita:=True;
      end;
    if not Gestita then
    begin
      ttimbraturedip[i1].tag:='-' + ttimbraturedip[i1].tcausale_u.tcaus;
      ttimbraturedip[i1].tcausale_u:=tcausale_vuota;
      z098_anom2caus(35,Format('%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_u)]));
    end;
  end;
begin
  //La Spezia - 03/10/2019 - Alberto: gestione della causale sull'entrata del giorno precedente
  //Modifica di minuti_pre se c'è un cavallo di mezzanotte con causale che è soggetta a fasce di abilitazione
  SetLength(FasceAbilitazione277,0);
  if (i1 = 1) and
     (ttimbraturedip[i1].tminutid_e = 0) and
     (not NotteSuEntrata) and
     (verso_pre = 'E') and
     (caus_pre = ttimbraturedip[i1].tcausale_e.tcaus) and
     (ValStrT275[caus_pre,'LIQUIDABILE'] = 'B')
  then
  begin
    //Leggo le fasce del gg prec
    if z541_GetFasceAutorizzazione(ttimbraturedip[i1].tcausale_e.tcaus,datacon - 1,datacon - 1,FascePN) then
    begin
      //Limito le fasce a cavallo di mezzanotte
      for i:=0 to High(FasceAbilitazione277) do
        if FasceAbilitazione277[i].IT >= FasceAbilitazione277[i].FT then
            FasceAbilitazione277[i].FT:=1440;
      AutorizzazioneGiornoPrec;
    end;
  end;
  //gestione della causale sull'entrata
  SetLength(FasceAbilitazione277,0);
  if z541_GetFasceAutorizzazione(ttimbraturedip[i1].tcausale_e.tcaus,datacon,datacon - 1,FascePN) then
  begin
    z541_GetFasceAutorizzazione(ttimbraturedip[i1].tcausale_e.tcaus,datacon,datacon,FascePN);
    AutorizzazioneEntrata;
  end;
  //gestione della causale sull'uscita
  SetLength(FasceAbilitazione277,0);
  if z541_GetFasceAutorizzazione(ttimbraturedip[i1].tcausale_u.tcaus,datacon,datacon - 1,FascePN) then
  begin
    if not NotteSuEntrata then
    begin
      z541_GetFasceAutorizzazione(ttimbraturedip[i1].tcausale_u.tcaus,datacon,datacon,FascePN);
      AutorizzazioneUscita;
    end
    else
    begin
      //NotteSuEntrata = True
      if ttimbraturedip[i1].tminutid_u <= 1440 then
      begin
        z541_GetFasceAutorizzazione(ttimbraturedip[i1].tcausale_u.tcaus,datacon,datacon,FascePN);
        AutorizzazioneUscita;
      end;
      if ttimbraturedip[i1].tminutid_u > 1440 then
      begin
        z541_GetFasceAutorizzazione(ttimbraturedip[i1].tcausale_u.tcaus,datacon,datacon + 1,FascePN);
        AutorizzazioneUscita;
      end;
    end;
  end;
end;
//_________________________________________________________________
function TR502ProDtM1.z543_CausaleFascePN(Causale:String; FascePN:Boolean):Boolean;
{Restituisce true se è presente una fascia di abilitazione di tipo PuntiNominali}
var k:Integer;
begin
  Result:=False;
  if Causale = '' then
     exit;
  SetLength(FasceAbilitazione277,0);
  z541_GetFasceAutorizzazione(Causale,datacon,datacon - 1,FascePN);
  z541_GetFasceAutorizzazione(Causale,datacon,datacon,FascePN);
  for k:=0 to High(FasceAbilitazione277) do
    if FasceAbilitazione277[k].PN then
    begin
      Result:=True;
      Break;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z550_LiberaProfessione;
{Gestione libera professione}
var Interna:Boolean;
    CausLibProf:t_tcausale;
    IT,FT,FlexTot,i:Integer;
  function EsisteCausPM:Boolean;
  var i:Integer;
  begin
    Result:=False;
    for i:=1 to n_timbrdip - 1 do
      if (ttimbraturedip[i].tcausale_u.tcaus = CAUS_PM) and (ttimbraturedip[i + 1].tcausale_e.tcaus = CAUS_PM) then
      begin
        Result:=True;
        Break;
      end;
  end;
begin
  //TORINO_HCOTTOLENGO: se non esiste pianificazione del turno, appoggio preliminarmente le timbrature per capire qual'è il turno effettuato
  //e faccio una finta pianificazione per evitare di riappoggiare spezzoni non causalizzati su turni diversi da quello realmente fatto.
  pianif_z550:=False;
  if (Parametri.CampiRiferimento.C90_W026PianifForzata = 'S') and
    (cdsT320.Locate('Data',DataCon,[])) and
    (TipoOrario = 'E') and
    ((pianif = 'no') or (l08_turno1 = -1)) then
  begin
    z060_appoggio(True);
    for i:=1 to n_timbrdip do
    begin
      if ttimbraturedip[i].tpuntnomin > 0 then
      begin
        l08_turno1:=max(ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntre,ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntru);
        if l08_turno1 = 0 then
          l08_turno1:=-1
        else
          break;
      end;
    end;
    if l08_turno1 > 0 then
    begin
      pianif:='si';
      pianif_z550:=True;
      c_turni1:=l08_turno1;
      z280_legginomE;
      z060_appoggio(True);
    end;
  end;

  if XParam[XP_LIBPROF_SUMAI] or (UpperCase(Parametri.RagioneSociale) = COMO_HSANNA)(*'AZ. OSP. SANT''ANNA DI COMO'*) then
  begin
    //Gestione flessibilità dei turni in libera professione
    if cdsT320.Locate('Data',DataCon,[]) then
      while (not cdsT320.Eof) and (cdsT320.FieldByName('DATA').AsDateTime = DataCon) do
      begin
        z551_FlessibilitaLibProf;
        cdsT320.Next;
      end;
    if NotteSuEntrata then
      if cdsT320.Locate('Data',DataCon + 1,[]) then
        while (not cdsT320.Eof) and (cdsT320.FieldByName('DATA').AsDateTime = DataCon + 1) do
        begin
          z551_FlessibilitaLibProf;
          cdsT320.Next;
        end;
    //ASST Valtellina
    //Se non ho applicato prima la flessibilità sul singolo turno, la applico ora sul turno corrispondente al pomeriggio
    if XParam[XP_LIBPROF_FLEXPOM]
    and (TipoOrario = 'A')
    and (PeriodoLavorativo = 'S')
    and R180In(cdsT020.FieldByName('TipoFle').AsString,['A','C'])
    then
    begin
      FlexTot:=0;
      for i:=1 to n_timbrdip do
      begin
        FlexTot:=FlexTot + StrToIntDef(ttimbraturedip[i].tag.Replace('Z551:','',[]),0);
        ttimbraturedip[i].tag:='';
      end;
      //Se c'è flessibilità da applicare...
      if FlexTot > 0 then
      begin
        //Cerco il turno corrispondente al pomeriggio, o l'ultimo turno del giorno
        if not cdsT320.Locate('DATA;DALLE',VarArrayOf([DataCon,R180MinutiOre(EntrataNominale[2])]),[]) then
        begin
          cdsT320.Last;
          while (not cdsT320.Bof) and (cdsT320.FieldByName('DATA').AsDateTime <> DataCon) do
            cdsT320.Prior;
        end;
        if cdsT320.FieldByName('DATA').AsDateTime = DataCon then
        begin
          cdsT320.Edit;
          cdsT320.FieldByName('Alle').AsString:=R180MinutiOre(R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString) + FlexTot);
          cdsT320.Post;
        end;
      end;
    end;
    //ASST Valtellina cap.2: se ci sono causali a fine giornata, interrompo prima la pianificazione della lib.professione
    if XParam[XP_LIBPROF_CAUS] then
    begin
      for i:=n_timbrdip downto 1 do
      begin
        if ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'LIQUIDABILE'] = 'B' then
        begin
          //Cerco turno su T320 che contiene la timbratura, e anticipo il 'Alle'
          cdsT320.First;
          while not cdsT320.Eof do
          begin
            if (cdsT320.FieldByName('DATA').AsDateTime = DataCon)
            and R180Between(ttimbraturedip[i].tminutid_e,R180OreMinuti(cdsT320.FieldByName('Dalle').AsString),R180OreMinuti(cdsT320.FieldByName('Alle').AsString))
            then
            begin
              cdsT320.Edit;
              cdsT320.FieldByName('Alle').AsString:=R180MinutiOre(ttimbraturedip[i].tminutid_e);
              cdsT320.Post;
              Break;
            end;
            cdsT320.Next;
          end;
          Break;
        end;
      end;
    end;
  end;
  i1:=1;
  while True do
  begin
    if i1 > n_timbrdip then
      Break;
    z552_TimbratureInLibProf;
    inc(i1);
  end;
  //Gestione timbrature interne al turno di libera professione
  i1:=1;
  while True do
  begin
    if i1 > n_timbrdip then
      Break;
    //Alberto 29/03/2012: se causale di reperibilità/prestazione aggiuntiva con controllo sul turno abilitato, annullo la gestione della libera professione
    if (ttimbraturedip[i1].tcausale_e.tcaus <> '') and
       (ttimbraturedip[i1].tcausale_e.tcaus = ttimbraturedip[i1].tcausale_u.tcaus) and
       (ttimbraturedip[i1].tcausale_e.tcaustip = 'B') and
       (ValStrT275[ttimbraturedip[i1].tcausale_e.tcaus,'PIANIFREP'] <> 'N') then
    begin
      inc(i1);
      Continue;
    end;
    Interna:=False;
    //if cdsT320.SearchRecord('Data',DataCon,[srFromBeginning]) then
    if cdsT320.Locate('Data',DataCon,[]) then
      //repeat
      while (not cdsT320.Eof) and (cdsT320.FieldByName('DATA').AsDateTime = DataCon) do
      begin
        IT:=R180OreMinutiExt(cdsT320.FieldByName('Dalle').AsString);
        FT:=R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString);
        //Alberto 20/01/2009: gestione scavalco di mezzanotte per Firenze Vigili
        if FT <= IT then
          FT:=FT + 1440;
        if (ttimbraturedip[i1].tminutid_e >= IT) and
           (ttimbraturedip[i1].tminutid_u <= FT) then
        begin
          Interna:=True;
          Break;
        end;
        cdsT320.Next;
      end;
      //until not(cdsT320.SearchRecord('Data',DataCon,[]));
    //Alberto 22/10/2009 - TORINO_COMUNE: Gestione mensile sullo scavalco di mezzanotte considerando anche i turni del giorno dopo
    if (ttimbraturedip[i1].tminutid_e >= 1440) and (ttimbraturedip[i1].tminutid_u > 1440) and
       (not Interna) and NotteSuEntrata then
      //if cdsT320.SearchRecord('Data',DataCon + 1,[srFromBeginning]) then
      if cdsT320.Locate('Data',DataCon + 1,[]) then
        //repeat
        while (not cdsT320.Eof) and (cdsT320.FieldByName('DATA').AsDateTime = DataCon + 1) do
        begin
          IT:=R180OreMinutiExt(cdsT320.FieldByName('Dalle').AsString) + 1440;
          FT:=R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString) + 1440;
          //Alberto 20/01/2009: gestione scavalco di mezzanotte per Firenze Vigili
          if FT <= IT then
          begin
            cdsT320.Next;
            Continue;
          end;
          if (ttimbraturedip[i1].tminutid_e >= IT) and
             (ttimbraturedip[i1].tminutid_u <= FT) then
          begin
            Interna:=True;
            Break;
          end;
          cdsT320.Next;
        end;
        //until not(cdsT320.SearchRecord('Data',DataCon + 1,[]));
    if Interna then
    begin
      //Segnalazione anomalia
      z098_anom2caus(29,Format('%s-%s',[R180MinutiOre(ttimbraturedip[i1].tminutid_e),R180MinutiOre(ttimbraturedip[i1].tminutid_u)]));
      CausLibProf:=tcausale_vuota;
      if Trim(cdsT320.FieldByName('Causale').AsString) <> '' then
      begin
        z964_leggicaus(cdsT320.FieldByName('Causale').AsString);
        if (s_trovato = 'si') and (parcaus.l29_1paramet = 'B') then
          z965_SettaCausPres(CausLibProf);
      end;
      if CausLibProf.tcaus = '' then
      begin
        indice:=i1;
        z802_toglitimbr;
        dec(i1);
      end
      else
      begin
        ttimbraturedip[i1].tcausale_e:=CausLibProf;
        ttimbraturedip[i1].tcausale_u:=CausLibProf;
        ttimbraturedip[i1].tpuntnomin:=0;
      end;
    end;
    inc(i1);
  end;

  if not XParam[XP_V1064_Z550] then
  begin
    //Compatto timbrature consecutive causalizzate con stessa causale
    i:=1;
    while i < n_timbrdip do
    begin
      if (ttimbraturedip[i].tminutid_u = ttimbraturedip[i + 1].tminutid_e) and
         (ttimbraturedip[i].tcausale_u.tcaus = ttimbraturedip[i + 1].tcausale_e.tcaus) and
         (ttimbraturedip[i].tcausale_e.tcaus = ttimbraturedip[i].tcausale_u.tcaus) and
         (ttimbraturedip[i + 1].tcausale_e.tcaus = ttimbraturedip[i + 1].tcausale_u.tcaus) and
         (ttimbraturedip[i].tpuntnomin = 0) and (ttimbraturedip[i + 1].tpuntnomin = 0) and
         (ttimbraturedip[i].tcausale_e.tcaus <> '') and
         (ttimbraturedip[i].tcausale_e.tcaustip = 'B') then
      begin
        ttimbraturedip[i].tminutid_u:=ttimbraturedip[i + 1].tminutid_u;
        indice:=i + 1;
        z802_toglitimbr;
      end
      else
        inc(i);
    end;
  end;

  if z496Eseguito and (not EsisteCausPM) then
    z496_inscausPM;

  //TORINO_CITTADELLASALUTE
  //!!Gestione giustificativi ASSENZA intersecanti il turno di libera professione!!
  z556_GiustifInLibProf;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z551_FlessibilitaLibProf;
{Gestione delle timbrature intersecanti i turni di libera professione}
var i,IT,FT,Flex,T021Flex:Integer;
begin
  IT:=R180OreMinutiExt(cdsT320.FieldByName('Dalle').AsString);
  FT:=R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString);
  if cdsT320.FieldByName('Data').AsDateTime = DataCon then
  begin
    if FT <= IT then  //Alberto 20/01/2009: gestione scavalco di mezzanotte per Firenze Vigili
      FT:=FT + 1440;
  end
  else if cdsT320.FieldByName('Data').AsDateTime = DataCon + 1 then
  begin
    IT:=R180OreMinutiExt(cdsT320.FieldByName('Dalle').AsString) + 1440;
    FT:=R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString) + 1440;
    if FT <= IT then
      exit;
  end;
  for i:=1 to n_timbrdip do
  begin
    //Alberto 29/03/2012: se causale di reperibilità/prestazione aggiuntiva con controllo sul turno abilitato, annullo la gestione della libera professione
    if (ttimbraturedip[i].tcausale_e.tcaus <> '') and
       (ttimbraturedip[i].tcausale_e.tcaus = ttimbraturedip[i].tcausale_u.tcaus) and
       (ttimbraturedip[i].tcausale_e.tcaustip = 'B') and
       (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'PIANIFREP'] <> 'N') then
      Continue;
    if (cdsT320.FieldByName('Data').AsDateTime = DataCon + 1) and
       not((ttimbraturedip[i].tminutid_u > 1440) and NotteSuEntrata) then
      Continue;
    //Gestione Inizio turno compreso tra entrata ed uscita
    if R180Between(IT,ttimbraturedip[i].tminutid_e,ttimbraturedip[i].tminutid_u) then
      Break;

    if R180Between(ttimbraturedip[i].tminutid_e,IT,FT) then
    begin
      T021Flex:=max(ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1],ValNumT021['mmFlex',TF_PUNTI_NOMINALI,2]);
      Flex:=min(ttimbraturedip[i].tminutid_e - IT,T021Flex);
      cdsT320.Edit;
      cdsT320.FieldByName('Dalle').AsString:=R180MinutiOre(R180OreMinutiExt(cdsT320.FieldByName('Dalle').AsString) + Flex);
      //ASST Valtellina: la flessibilità viene applicata sull'ultimo turno del giorno
      if XParam[XP_LIBPROF_SUMAI]
      and XParam[XP_LIBPROF_FLEXPOM]
      and (TipoOrario = 'A')
      and (PeriodoLavorativo = 'S')
      and R180In(cdsT020.FieldByName('TipoFle').AsString,['A','C'])
      then
        ttimbraturedip[i].tag:='Z551:' + Flex.ToString
      else
        cdsT320.FieldByName('Alle').AsString:=R180MinutiOre(R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString) + Flex);
      cdsT320.Post;
      Break;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z552_TimbratureInLibProf;
{Gestione delle timbrature intersecanti i turni di libera professione}
var IT,FT:Integer;
begin
  //Alberto 29/03/2012: se causale di reperibilità/prestazione aggiuntiva con controllo sul turno abilitato, annullo la gestione della libera professione
  if (ttimbraturedip[i1].tcausale_e.tcaus <> '') and
     (ttimbraturedip[i1].tcausale_e.tcaus = ttimbraturedip[i1].tcausale_u.tcaus) and
     (ttimbraturedip[i1].tcausale_e.tcaustip = 'B') and
     (ValStrT275[ttimbraturedip[i1].tcausale_e.tcaus,'PIANIFREP'] <> 'N') then
    exit;
  //Analisi turni in libera professione
  //if cdsT320.SearchRecord('Data',DataCon,[srFromBeginning]) then
  if cdsT320.Locate('Data',DataCon,[]) then
    //repeat
    while (not cdsT320.Eof) and (cdsT320.FieldByName('DATA').AsDateTime = DataCon) do
    begin
      IT:=R180OreMinutiExt(cdsT320.FieldByName('Dalle').AsString);
      FT:=R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString);
      if FT <= IT then  //Alberto 20/01/2009: gestione scavalco di mezzanotte per Firenze Vigili
        FT:=FT + 1440;
      //Turno compreso nella coppia di timbrature
      if (IT >= ttimbraturedip[i1].tminutid_e) and
         (IT <= ttimbraturedip[i1].tminutid_u) and
         (FT >= ttimbraturedip[i1].tminutid_e) and
         (FT <= ttimbraturedip[i1].tminutid_u) then
        z555_LibProfInterna(IT,FT)
      else
      //Gestione Inizio turno compreso tra entrata ed uscita
      if (IT > ttimbraturedip[i1].tminutid_e) and
         (IT < ttimbraturedip[i1].tminutid_u) then
        z553_InizioLibProf(IT,FT)
      else
      //Gestione Fine turno compreso tra entrata ed uscita
      if (FT > ttimbraturedip[i1].tminutid_e) and
         (FT < ttimbraturedip[i1].tminutid_u) then
        z554_FineLibProf(IT,FT);
      cdsT320.Next;
    end;
    //until not(cdsT320.SearchRecord('Data',DataCon,[]));
  //Alberto 22/10/2009 - TORINO_COMUNE: Gestione mensile sullo scavalco di mezzanotte considerando anche i turni del giorno dopo
  if (*(ttimbraturedip[i1].tminutid_e >= 1440) and*) (ttimbraturedip[i1].tminutid_u > 1440) and NotteSuEntrata then
    //if cdsT320.SearchRecord('Data',DataCon + 1,[srFromBeginning]) then
    if cdsT320.Locate('Data',DataCon + 1,[]) then
      //repeat
      while (not cdsT320.Eof) and (cdsT320.FieldByName('DATA').AsDateTime = DataCon + 1) do
      begin
        IT:=R180OreMinutiExt(cdsT320.FieldByName('Dalle').AsString) + 1440;
        FT:=R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString) + 1440;
        if FT <= IT then
        begin
          cdsT320.Next;
          Continue;
        end;
        //Turno compreso nella coppia di timbrature
        if (IT >= ttimbraturedip[i1].tminutid_e) and
           (IT <= ttimbraturedip[i1].tminutid_u) and
           (FT >= ttimbraturedip[i1].tminutid_e) and
           (FT <= ttimbraturedip[i1].tminutid_u) then
          z555_LibProfInterna(IT,FT)
        else
        //Gestione Inizio turno compreso tra entrata ed uscita
        if (IT > ttimbraturedip[i1].tminutid_e) and
           (IT < ttimbraturedip[i1].tminutid_u) then
          z553_InizioLibProf(IT,FT)
        else
        //Gestione Fine turno compreso tra entrata ed uscita
        if (FT > ttimbraturedip[i1].tminutid_e) and
           (FT < ttimbraturedip[i1].tminutid_u) then
          z554_FineLibProf(IT,FT);
        cdsT320.Next;
      end;
      //until not(cdsT320.SearchRecord('Data',DataCon + 1,[]));
end;

procedure TR502ProDtM1.z553_InizioLibProf(IT,FT:Integer);
//Gestione Inizio turno compreso tra entrata ed uscita
begin
  indice:=i1 + 1;
  //Inserimento della coppia E-U nelle timbrature dipendente
  z816_insetimbr;
  ttimbraturedip[indice].tminutid_e:=IT;
  ttimbraturedip[indice].tminutid_u:=ttimbraturedip[i1].tminutid_u;
  ttimbraturedip[indice].iOT:=ttimbraturedip[i1].iOT;
  ttimbraturedip[indice].trilev_e:=ttimbraturedip[i1].trilev_e;
  ttimbraturedip[indice].trilev_u:=ttimbraturedip[i1].trilev_u;
  ttimbraturedip[indice].tflagarr_e:='si';
  ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[i1].tflagarr_u;
  ttimbraturedip[indice].tpuntnomin:=0;
  if ttimbraturedip[i1].tcausale_u.tcaus <> CAUS_PM then
  begin
    //Alberto 18/05/2012 per lib.prof. LaSpezia
    ttimbraturedip[indice].tcausale_e:=ttimbraturedip[i1].tcausale_u;
    ttimbraturedip[indice].tcausale_u:=ttimbraturedip[i1].tcausale_u;
  end
  else
  begin
    ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
    ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
  end;
  ttimbraturedip[i1].tminutid_u:=IT;
  ttimbraturedip[i1].tflagarr_u:='si';
  if ttimbraturedip[i1].tcausale_e.tcaus <> CAUS_PM then
    ttimbraturedip[i1].tcausale_u:=ttimbraturedip[i1].tcausale_e //Riporto la causalizzazione dell'entrata sull'uscita
  else
    ttimbraturedip[i1].tcausale_u:=tcausale_vuota;
  //Incremento i1 per saltare la timbratura appena inserita
  inc(i1);
end;

procedure TR502ProDtM1.z554_FineLibProf(IT,FT:Integer);
//Gestione Fine turno compreso tra entrata ed uscita
begin
  indice:=i1 + 1;
  //Inserimento della coppia E-U nelle timbrature dipendente
  z816_insetimbr;
  ttimbraturedip[indice].tminutid_e:=FT;
  ttimbraturedip[indice].tminutid_u:=ttimbraturedip[i1].tminutid_u;
  ttimbraturedip[indice].iOT:=ttimbraturedip[i1].iOT;
  ttimbraturedip[indice].trilev_e:=ttimbraturedip[i1].trilev_e;
  ttimbraturedip[indice].trilev_u:=ttimbraturedip[i1].trilev_u;
  ttimbraturedip[indice].tcausale_u:=ttimbraturedip[i1].tcausale_u;
  ttimbraturedip[indice].tcausale_e:=ttimbraturedip[indice].tcausale_u;  //Riporto la causalizzazione dell'uscita sull'entrata
  ttimbraturedip[indice].tflagarr_e:='si';
  ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[i1].tflagarr_u;
  //
  ttimbraturedip[i1].tminutid_u:=FT;
  ttimbraturedip[i1].tflagarr_u:='si';
  z061_appoggioc1(indice);
  ttimbraturedip[i1].tpuntnomin:=0;
  //Incremento i1 per saltare la timbratura appena inserita
  inc(i1);
end;

procedure TR502ProDtM1.z555_LibProfInterna(IT,FT:Integer);
//Turno compreso nella coppia di timbrature
begin
  //Reperibilita' da inizio turno pianificato
  indice:=i1 + 1;
  //Inserimento della coppia E-U nelle timbrature dipendente
  z816_insetimbr;
  ttimbraturedip[indice].tminutid_e:=FT;
  ttimbraturedip[indice].tminutid_u:=ttimbraturedip[i1].tminutid_u;
  ttimbraturedip[indice].iOT:=ttimbraturedip[i1].iOT;
  ttimbraturedip[indice].trilev_e:=ttimbraturedip[i1].trilev_e;
  ttimbraturedip[indice].trilev_u:=ttimbraturedip[i1].trilev_u;
  if ttimbraturedip[i1].tcausale_u.tcaus <> CAUS_PM then
  begin
    ttimbraturedip[indice].tcausale_e:=ttimbraturedip[i1].tcausale_u;
    ttimbraturedip[indice].tcausale_u:=ttimbraturedip[i1].tcausale_u;
  end
  else
  begin
    ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
    ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
  end;
  ttimbraturedip[indice].tflagarr_e:='si';
  ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[i1].tflagarr_u;
  z061_appoggioc1(indice);
  //
  ttimbraturedip[i1].tminutid_u:=IT;
  ttimbraturedip[i1].tflagarr_u:='si';
  //Alberto 08/07/2009: remmata la riga sotto per problema indicato da TORINO_COMUNE
  //ttimbraturedip[i1].tcausale_e:=ttimbraturedip[i1].tcausale_u; //Riporto la causalizzazione dell'uscita sull'entrata
  z061_appoggioc1(i1);
  //Inserimento della coppia E-U nelle timbrature dipendente
  z816_insetimbr;
  ttimbraturedip[indice].tminutid_e:=IT;
  ttimbraturedip[indice].tminutid_u:=FT;
  ttimbraturedip[indice].iOT:=ttimbraturedip[i1].iOT;
  ttimbraturedip[indice].tflagarr_e:='si';
  ttimbraturedip[indice].tflagarr_u:='si';
  ttimbraturedip[indice].tpuntnomin:=0;
  //Incremento i1 per saltare le 2 timbrature appena inserite
  inc(i1,2);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z556_GiustifInLibProf;
{TORINO_CITTADELLASALUTE
 parametri aggiuntivi:
 Causale di assenza: abilitata alla gestione dell'iter ecc.gg
                     aumenta le ore
 Causale di assenza che diminuisce le ore: parametro aziendale C90_W026CausAbbattGiustAss}
var i,IT,FT,IG,FG,IE,FE:Integer;
begin
  for i:=1 to n_giusdaa do
  begin
    //Causale abilitata alla gestione della libera professione usata per autorizzare l'eccedenza
    if (ValStrT265[tgius_dallealle[i].tcausdaa,'ITER_ECCGG'] <> 'S') then
      Continue;
    //Deve aumentare le ore sul cartellino
    if not (R180CarattereDef(ValStrT265[tgius_dallealle[i].tcausdaa,'INFLUCONT']) in ['A','C','H']) then
      Continue;

    //Giustificativo
    IG:=tgius_dallealle[i].tminutida;
    FG:=tgius_dallealle[i].tminutia;

    if cdsT320.Locate('Data',DataCon,[]) then
      while (not cdsT320.Eof) and (cdsT320.FieldByName('DATA').AsDateTime = DataCon) do
      begin
        //Turno lib.prof.
        IT:=R180OreMinutiExt(cdsT320.FieldByName('Dalle').AsString);
        FT:=R180OreMinutiExt(cdsT320.FieldByName('Alle').AsString);
        if FT <= IT then
          FT:=FT + 1440;
        //Intervallo per creare eccedenza autorizzata
        IE:=max(IG,IT);
        FE:=min(FG,FT);
        if IE < FE then
        begin
          if (n_giusgga + n_giusmga + n_giusore + n_giusdaa) + 1 = MaxGiustif then
            Continue;

          //Deve essere definita la causale di abbattimento delle ore
          if ValStrT265[Parametri.CampiRiferimento.C90_W026CausAbbattGiustAss,'INFLUCONT'] = 'D' then
          begin
            //inserimento giustificativo con causale T320.CAUSALE
            inc(n_giusdaa);
            tgius_dallealle[n_giusdaa].tcausdaa:=cdsT320.FieldByName('Causale').AsString;
            tgius_dallealle[n_giusdaa].tminutida:=IE;
            tgius_dallealle[n_giusdaa].tminutia:=FE;
            tgius_dallealle[n_giusdaa].DataFamiliare:=0;
            tgius_dallealle[n_giusdaa].tassenza:=False;
            tgius_dallealle[n_giusdaa].PuntGiustR600:=-1;
            //inserimento giustificativo che abbatte le ore normali
            inc(n_giusore);
            tgius_min[n_giusore].tmin:=FE - IE;
            tgius_min[n_giusore].tcausore:=Parametri.CampiRiferimento.C90_W026CausAbbattGiustAss;
            tgius_min[n_giusore].DataFamiliare:=0;
            tgius_min[n_giusore].tassenza:=True;
            tgius_min[n_giusore].PuntGiustR600:=-1;
          end
          else
          begin
            //Anomalia di secondo livello
            z098_anom2caus(60,Parametri.CampiRiferimento.C90_W026CausAbbattGiustAss);
          end;
        end;
        cdsT320.Next;
      end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z560_FasceGettone(FascePN:Boolean = False);
var i,j,g,E,U,OreGettone,GettoneDalle,GettoneAlle,Diff,PU:Integer;
    Trov,CavalloMezzanotte:Boolean;
  procedure OreInferiori;
  begin
    if (U - E < OreGettone) and (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_SPEZZONI'] = 'N') then
    begin
      if ValStrT275[tcausale.tcaus,'GETTONE_TIPO_OREINF'] = 'P' then
      begin
        //Ore Perse
        ttimbraturedip[i].tminutid_u:=ttimbraturedip[i].tminutid_e;
        z098_anom2caus(41,Format('%s min:%d',[ttimbraturedip[i].tcausale_e.tcaus,OreGettone]));
      end
      else
      begin
        //Ore Normali: annullo la causale
        ttimbraturedip[i].tcausale_e:=tcausale_vuota;
        ttimbraturedip[i].tcausale_u:=tcausale_vuota;
        z098_anom2caus(40,Format('%s min:%d',[ttimbraturedip[i].tcausale_e.tcaus,OreGettone]));
      end;
      //Annullo E ed U per evitare il controllo delle ore superiori
      E:=0;
      U:=0;
    end;
  end;
  procedure OreSuperiori;
  begin
    if (U - E > OreGettone) (*and (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_TIPO_ORESUP'] <> 'C')*) then
    begin
      //Spaccare la timbratura
      Diff:=U - E - OreGettone;
      PU:=U - Diff;
      //Troncatura sul giorno successivo: non succede nulla
      if (PU >= 1440) and (not NotteSuEntrata) then
        exit;
      if PU < 0 then
        PU:=0;
      //Spaccare le timbrature su PU oppure tminutid_u:=PU
      if ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_TIPO_ORESUP'] = 'P' then
      begin
        //Ore Perse
        U:=PU;
        ttimbraturedip[i].tminutid_u:=PU;
        z098_anom2caus(43,Format('%s min:%d',[ttimbraturedip[i].tcausale_e.tcaus,OreGettone]));
      end
      else if ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_TIPO_ORESUP'] = 'N' then
      begin
        //Ore Normali: spezzo la timbratura su PU
        U:=PU;
        indice:=i + 1;
        z816_insetimbr;
        ttimbraturedip[indice].tminutid_e:=PU;
        ttimbraturedip[indice].tminutid_u:=ttimbraturedip[i].tminutid_u;
        ttimbraturedip[indice].trilev_e:=ttimbraturedip[i].trilev_e;
        ttimbraturedip[indice].trilev_u:=ttimbraturedip[i].trilev_u;
        ttimbraturedip[indice].tcausale_e:=tcausale_vuota;
        ttimbraturedip[indice].tcausale_u:=tcausale_vuota;
        ttimbraturedip[indice].tflagarr_e:='si';
        ttimbraturedip[indice].tflagarr_u:=ttimbraturedip[i].tflagarr_u;
        ttimbraturedip[indice].tpuntnomin:=0;
        ttimbraturedip[indice].tag:='';
        z061_appoggioc1(indice);
        ttimbraturedip[i].tminutid_u:=PU;
        z098_anom2caus(42,Format('%s min:%d',[ttimbraturedip[i].tcausale_e.tcaus,OreGettone]));
      end
      else if ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_SPEZZONI'] = 'N' then
        U:=PU;
    end;
  end;
  procedure LimiteFasciaGettone;
  begin
    //Alberto 10/02/2007: Gestione fascia del gettone (Orbassano x Ind.notturna di Guardia)
    if (GettoneDalle = GettoneAlle) then //Se è attiva la durata del gettone non si fa nulla di diverso
      exit;
    if GettoneDalle < GettoneAlle then  //Fascia giornaliera
    begin
      E:=Max(E,GettoneDalle);
      U:=Min(U,GettoneAlle);
      if (OreGettone = 0) and (E <> GettoneDalle) and (U <> GettoneAlle) then
      begin
        E:=0;
        U:=0;
      end;
    end
    else
    begin  //Fascia a cavallo di mezzanotte (quella che serve effettivamente)
      if E > GettoneAlle then //Limite sullo spezzone della sera
      begin
        E:=Max(E,GettoneDalle);
        U:=Min(U,GettoneAlle + 1440);
      end
      else
        U:=Min(U,GettoneAlle); //Limite sullo spezzone del mattino
      if (OreGettone = 0) and (E <> GettoneDalle) and (U <> GettoneAlle + 1440) then
      begin
        E:=0;
        U:=0;
      end;
    end;
    if U - E < OreGettone then
      U:=E;
  end;
  function CollegaTimbraturePrecedenti(x:Integer; Caus:String):Integer;
  var k,eGett:Integer;
  begin
    //Result:=U;
    eGett:=E;
    for k:=x - 1 downto 1 do
      if (ttimbraturedip[k].tminutid_u = ttimbraturedip[k + 1].tminutid_e) and (ttimbraturedip[k].tcausale_u.tcaus = ttimbraturedip[k + 1].tcausale_e.tcaus) then
        eGett:=ttimbraturedip[k].tminutid_e
      else
        Break;
    Result:=eGett + Min(U - eGett,OreGettone);
    if Result < E then
      Result:=E;
  end;
begin
  //Alberto 5.4.7
  //Ore per gettone: controllo le ore in meno o in più
  i:=1;
  CavalloMezzanotte:=False;
  while i <= n_timbrdip do
  begin
    OreGettone:=R180OreMinutiExt(ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_ORE']);
    GettoneDalle:=R180OreMinutiExt(ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_DALLE']);
    GettoneAlle:=R180OreMinutiExt(ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_ALLE']);
    //Verifico che ci siano le regole per calcolare il gettone
    if (ttimbraturedip[i].tcausale_e.tcausabi = 'no') or (OreGettone = 0) or (ttimbraturedip[i].tcausale_e.tcaus <> ttimbraturedip[i].tcausale_u.tcaus) then
    begin
      inc(i);
      Continue;
    end;
    //Alberto 09/05/2012: gestione gettone per causali con fasce autorizzazione da Punti Nominali
    if FascePN and (not z543_CausaleFascePN(ttimbraturedip[i].tcausale_e.tcaus,FascePN)) then
    begin
      inc(i);
      Continue;
    end;
    E:=ttimbraturedip[i].tminutid_e;
    U:=ttimbraturedip[i].tminutid_u;
    if (E = 0) and (primat_u = 'si') and (estimbprec = 'si') and (verso_pre = 'E') then
      if NotteSuEntrata then
      begin
        //Non si calcola il gettone sullo smonto notte con conteggio sull'entrata
        inc(i);
        Continue;
      end
      else
      begin
        E:=-(1440 - minuti_pre);
        SetLength(FasceAbilitazione277,0);
        if not XParam[XP_V77_Z560] then
        begin
          if z541_GetFasceAutorizzazione(caus_pre,datacon - 1,datacon - 1) then
          begin
            E:=0;
            for j:=0 to High(FasceAbilitazione277) do
              //if FasceAbilitazione277[j].IT = 0 then  //Alberto 07/05/2010: sostituito con la la condizione sotto
              begin
                if FasceAbilitazione277[j].IT >= FasceAbilitazione277[j].FT then
                begin
                  //Alberto 07/05/2010: riprtistinato il riferimento al limite del giorno precedente
                  E:=-(1440 - max(minuti_pre,FasceAbilitazione277[j].IT));
                  //E:=-(1440 - minuti_pre);
                  Break;
                end
                else if FasceAbilitazione277[j].IT = 0 then
                begin
                  //E:=-(1440 - max(minuti_pre,FasceAbilitazione277[j].IT));
                  E:=-(1440 - minuti_pre);
                  Break;
                end;
              end
          end
        end
        else if z541_GetFasceAutorizzazione(caus_pre,datacon,datacon - 1) then
        begin
          E:=0;
          for j:=0 to High(FasceAbilitazione277) do
            if FasceAbilitazione277[j].IT = 0 then
            begin
              E:=-(1440 - minuti_pre);
              Break;
            end;
        end;
      end;
    if (not NotteSuEntrata) and (U = 1440) and (ultimt_e = 'si') and (estimbsucc = 'si') and (verso_suc = 'U') and (not CavalloMezzanotte) then
    begin
      U:=minuti_suc + 1440;
      CavalloMezzanotte:=True;
      if not XParam[XP_V77_Z560] then
      begin
        //Verifica delle fasce di autorizzazione sulla timbratura successiva
        SetLength(FasceAbilitazione277,0);
        if z541_GetFasceAutorizzazione(caus_suc,datacon + 1,datacon) then
        begin
          U:=1440;
          for j:=0 to High(FasceAbilitazione277) do
            if FasceAbilitazione277[j].IT = 0 then
            begin
              U:=1440 + min(minuti_suc,FasceAbilitazione277[j].FT);
              Break;
            end;
        end;
      end;
    end;
    LimiteFasciaGettone;
    //Alberto 28/06/2007: Controlli su min/max della causale
    if U - E < ttimbraturedip[i].tcausale_e.tminminuti then
      U:=E;
    if U - E > ttimbraturedip[i].tcausale_e.tmaxminuti then
      U:=E + ttimbraturedip[i].tcausale_e.tmaxminuti;
    if GettoneDalle = GettoneAlle then
    begin
      OreInferiori;
      OreSuperiori;
    end;
    //Conteggio delle ore che maturano il gettone: calcolato qui per gestire il cavallo di mezzanotte
    if (E >= 0) and (U - E > 0) then
    begin
      Trov:=False;
      for g:=0 to High(Gettoni) do
        if Gettoni[g].Causale = ttimbraturedip[i].tcausale_e.tcaus then
        begin
          if (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_SPEZZONI'] = 'N') or
             (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_TIPO_ORESUP'] <> 'C') then
          begin
            //Alberto 26/03/2010: se la timbratura è una prosecuzione della precedente, collego i minuti di gettone dovuti alle timbrature precedenti
            if (i > 1) and (ttimbraturedip[i - 1].tminutid_u = ttimbraturedip[i].tminutid_e) and (ttimbraturedip[i - 1].tcausale_u.tcaus = ttimbraturedip[i].tcausale_e.tcaus) then
              U:=CollegaTimbraturePrecedenti(i,ttimbraturedip[i].tcausale_e.tcaus);
            inc(Gettoni[g].Minuti,Min(U - E,OreGettone));
          end
          else
            inc(Gettoni[g].Minuti,U - E);
          Trov:=True;
        end;
      if not Trov then
      begin
        SetLength(Gettoni,Length(Gettoni) + 1);
        g:=High(Gettoni);
        Gettoni[g].Causale:=ttimbraturedip[i].tcausale_e.tcaus;
        if (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_SPEZZONI'] = 'N') or
           (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'GETTONE_TIPO_ORESUP'] <> 'C') then
        begin
          //Alberto 26/03/2010: se la timbratura è una prosecuzione della precedente, collego i minuti di gettone dovuti alle timbrature precedenti
          if (i > 1) and (ttimbraturedip[i - 1].tminutid_u = ttimbraturedip[i].tminutid_e) and (ttimbraturedip[i - 1].tcausale_u.tcaus = ttimbraturedip[i].tcausale_e.tcaus) then
            U:=CollegaTimbraturePrecedenti(i,ttimbraturedip[i].tcausale_e.tcaus);
          Gettoni[g].Minuti:=Min(U - E,OreGettone);
        end
        else
          Gettoni[g].Minuti:=U - E;
      end;
    end;
    inc(i);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z570_CompattaTimbrature;
{Ricompatto le timbrature contigue con stessa causale}
var i:Integer;
begin
  i:=1;
  while i < n_timbrdip do
  begin
    if (ttimbraturedip[i].iOT = ttimbraturedip[i + 1].iOT) and
       (ttimbraturedip[i].tminutid_u = ttimbraturedip[i + 1].tminutid_e) and
       //(ttimbraturedip[i].tcausale_e.tcaus = ttimbraturedip[i].tcausale_u.tcaus) and
       //(ttimbraturedip[i + 1].tcausale_e.tcaus = ttimbraturedip[i + 1].tcausale_u.tcaus)
       ((ttimbraturedip[i].tcausale_u.tcaus = ttimbraturedip[i + 1].tcausale_e.tcaus)
        or  //uscita con causale di mensa e rientro stesso minuto senza causale
        ((ttimbraturedip[i].tcausale_u.tcaustip = 'C') and (ttimbraturedip[i].tcausale_u.tcausrag = traggrgius.C) and (ttimbraturedip[i + 1].tcausale_e.tcaus = ''))
        or  //uscita senza causale entrata e rientro stesso minuto con causale di mensa
        ((ttimbraturedip[i + 1].tcausale_e.tcaustip = 'C') and (ttimbraturedip[i + 1].tcausale_e.tcausrag = traggrgius.C) and (ttimbraturedip[i].tcausale_u.tcaus = ''))
       )
    then
    begin
      ttimbraturedip[i].tminutid_u:=ttimbraturedip[i + 1].tminutid_u;
      indice:=i + 1;
      z802_toglitimbr;
      if ttimbraturedip[i].tcausale_e.tcaus = '' then
        z061_appoggioc1(i);
    end
    else
      inc(i);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z700_gestindenn;
{Gestione dati per calcolo indennita'}
var p:Integer;
    ElaboraIndennita:Boolean;
begin
  ElaboraIndennita:=True;
  try
    //Alberto 07/01/2009: FIRENZE_COMUNE eslcusione delle indennità per turno notturno su uscita (vengono calcolate il giorno dopo)
    if NotteSuEntrata and (ttimbraturedip[ieu].tpuntnomin > 0) then
      begin
        p:=ttimbraturenom[ttimbraturedip[ieu].tpuntnomin].tpuntre;
        if p = 0 then
          p:=ttimbraturenom[ttimbraturedip[ieu].tpuntnomin].tpuntru;
        if p > 0 then
          if (ValStrT021['NOTTE_USCITA',TF_PUNTI_NOMINALI,p] = 'S') and
             (ttimbraturedip[ieu].tminutid_e < 6000) then
            ElaboraIndennita:=False;
      end;
  except
  end;
  if ElaboraIndennita then
  begin
    //Calcolo minuti indennita' notturne e minuti lavorati per indennita' festive
    z702_indnotmin;
    //Calcolo minuti lavorati per indennita' di presenza
    z704_indpres;
  end;
  //Calcolo turno fatto
  //if TipoOrario = 'E' then
  z720_turfat;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z702_indnotmin;
{Calcolo minuti indennita' notturne
 e minuti lavorati per indennita' festive}
var StrConCauTur,StrConCauFes:String;
    IndFesDaOrario,IndNotDaOrario:Boolean;
    abindtur,abindfes:Char;
    NumFascia:Integer;
    ValFascia: string;
begin
  IndFesDaOrario:=True;
  IndNotDaOrario:=True;
  try
    abindtur:=R180CarattereDef(cdsT020.FieldByName('IndTurno').AsString,1,'N');
  except
    abindtur:='N';
  end;
  try
    abindfes:=R180CarattereDef(cdsT020.FieldByName('IndFestiva').AsString,1,'N');
  except
    abindfes:='N';
  end;

  //Disabilita indennità di turno e/o festiva per la singola fascia - 14-02-22 MONDOEDP - 165651
  if (TipoOrario = 'E') and (ttimbraturedip[ieu].tpuntnomin <> 0) then //Solo per orario a turni e se è stata riconosciuta la fascia
  begin
    NumFascia:=ttimbraturenom[ttimbraturedip[ieu].tpuntnomin].tpuntre;
    if NumFascia = 0 then
      NumFascia:=ttimbraturenom[ttimbraturedip[ieu].tpuntnomin].tpuntru;
    if (Numfascia > 0) and (abindtur <> 'N') then
    begin
      ValFascia:=ValStrT021['INDTURNO',TF_PUNTI_NOMINALI,NumFascia];
      //abindtur:=IfThen(ValFascia = 'N', ValFascia, abindtur)[1];
      if ValFascia = 'N' then
        abindtur:='N';
    end;
    if (Numfascia > 0) and (abindfes <> 'N') then
    begin
      ValFascia:=ValStrT021['INDFESTIVA',TF_PUNTI_NOMINALI,NumFascia];
      //abindfes:=IfThen(ValFascia = 'N', ValFascia, abindfes)[1];
      if ValFascia = 'N' then
        abindfes:='N';
    end;
  end;

  if (ttimbraturedip[ieu].tcausale_e.tcaus = '') and (ttimbraturedip[ieu].tpuntnomin = 0) then
    //Verifica se straordinario senza causale
    //con indennita' di turno
    begin
    if cdsT020.FieldByName('IndNotStr').AsString = '1' then
      try
        abindtur:='N';
        IndNotDaOrario:=False;
      except;
        abindtur:='N';
      end;
    if cdsT020.FieldByName('IndFestStr').AsString = '1' then
      try
        abindfes:='N';
        IndFesDaOrario:=False;
      except;
        abindfes:='N';
      end;
    end
  else
    begin
    //Leggo il tipo di raggruppamento sulla tabella Raggruppamenti causali presenza
    StrConCauTur:=VarToStr(Q270.Lookup('Codice',ttimbraturedip[ieu].tcausale_e.tcauscodrag,'IndNotturna'));
    StrConCauFes:=VarToStr(Q270.Lookup('Codice',ttimbraturedip[ieu].tcausale_e.tcauscodrag,'IndFestiva'));
    if (ttimbraturedip[ieu].tcausale_e.tcaus <> '') and (ttimbraturedip[ieu].tcausale_e.tcaustip = 'B') then
      //Verifica l'abilitazione alla maturazione delle indennità per la causale specificata;
      //se è specificata la maturazione su Eccedenza Giornaliera non viene considerato il parametro
      //a meno che sia esclusa dalle ore normali
      begin
        if ((StrConCauTur = 'S') and ((cdsT020.FieldByName('IndNotStr').AsString <> '2') or (ttimbraturedip[ieu].tcausale_e.tcausioe = 'A')))
           or
           (StrConCauTur = 'N') then
          try
            abindtur:=StrConCauTur[1];
            IndNotDaOrario:=False;
          except;
            abindtur:='N';
          end;
        if ((StrConCauFes = 'S') and ((cdsT020.FieldByName('IndFestStr').AsString <> '2') or (ttimbraturedip[ieu].tcausale_e.tcausioe = 'A')))
           or
           (StrConCauFes = 'N') then
          try
            abindfes:=StrConCauFes[1];
            IndFesDaOrario:=False;
          except
            abindfes:='N';
          end;
      end;
    end;

  //Ind.festiva limitata al giorno corrente
  if not(
     (Self.Name <> 'R502IndFest') and
     (TipoGG_suc <> 'F') and (giorsett <> 6) and
     ((cdsT020.FindField('INDFESTIVA_USA_NOTTE_COMPLETA') <> nil) and
     (cdsT020.FieldByName('INDFESTIVA_USA_NOTTE_COMPLETA').AsString = 'S'))
     )then
  begin
    if ((Self.Name = 'R502IndFest') or (abindfes = 'S') or ((abindfes = 'D') and (giorsett = 7)) or ((abindfes = 'F') and (tipoGG = 'F'))) and (ttimbraturedip[ieu].tminutid_e <= 1440) then
    //Indennita' festiva abilitata e entrata nel giorno corrente: non considero le timbrature del giorno dopo se conteggiate sull'entrata della notte
    //Calcolo minuti lavorati per indennita' festive con gestione cambio ora legale/solare
    begin
      if Self.Name = 'R502IndFest' then
      begin
        //CCNL 2018: conteggio delle sole ore che riguardano la fascia minutidalle..minutialle
        //Conteggio per lo stesso giorno festivo
        if (datacon = datacon_indfes_nottecompleta) and ((abindfes = 'S') or ((abindfes = 'D') and (giorsett = 7)) or ((abindfes = 'F') and (tipoGG = 'F'))) then
          minlavfes:=minlavfes + max(0,min(ttimbraturedip[ieu].tminutid_u,minutialle) - max(ttimbraturedip[ieu].tminutid_e,minutidalle));
        //Conteggio per il giorno precedente al festivo
        if (datacon = datacon_indfes_nottecompleta - 1) and ((abindfes = 'S') or ((abindfes = 'D') and (giorsett = 6)) or ((abindfes = 'F') and (tipoGG_suc = 'F'))) then
          minlavfes:=minlavfes + max(0,min(ttimbraturedip[ieu].tminutid_u,minutialle) - max(ttimbraturedip[ieu].tminutid_e,minutidalle));
        //Conteggio per il giorno successivo al festivo
        if (datacon = datacon_indfes_nottecompleta + 1) and ((abindfes = 'S') or ((abindfes = 'D') and (giorsett = 1)) or ((abindfes = 'F') and (tipoGG_prec = 'F'))) then
          minlavfes:=minlavfes + max(0,min(ttimbraturedip[ieu].tminutid_u,minutialle) - max(ttimbraturedip[ieu].tminutid_e,minutidalle));
      end
      else if ttimbraturedip[ieu].tminutid_u > 1440 then
        //4.0 Limito il conteggio dell'indennità festiva a mezzanotte
        minlavfes:=minlavfes + 1440 - ttimbraturedip[ieu].tminutid_e
      else
        minlavfes:=minlavfes + ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e;
      if ttimbraturedip[ieu].oralegsol then
        if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= minlavfes)) then
          inc(minlavfes,OraLegaleSolare.Diff)
        else
         minlavfes:=0;
    end;
  end;

  //Ind.festiva CCNL 2018: considero anche le ore del gg successivo, se turno notturno, fino alle 06.00
  if (Self.Name <> 'R502IndFest') and
     (TipoGG_suc <> 'F') and (giorsett <> 6) and
     ((cdsT020.FindField('INDFESTIVA_USA_NOTTE_COMPLETA') <> nil) and
     (cdsT020.FieldByName('INDFESTIVA_USA_NOTTE_COMPLETA').AsString = 'S')) then
  begin
    if (abindfes = 'S') or ((abindfes = 'D') and (giorsett = 7)) or ((abindfes = 'F') and (tipoGG = 'F')) then
    //Indennita' festiva abilitata e entrata nel giorno corrente, considerando anche il proseguimento della notte su giorno dopo
    //Calcolo minuti lavorati per indennita' festive con gestione cambio ora legale/solare
    begin
      minlavfes:=minlavfes + max(0,min(ttimbraturedip[ieu].tminutid_u,minutialle) - max(ttimbraturedip[ieu].tminutid_e,minutidalle));
      if ttimbraturedip[ieu].oralegsol then
        if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= minlavfes)) then
          inc(minlavfes,OraLegaleSolare.Diff)
        else
         minlavfes:=0;
    end;
  end;

  //Registro tutte le ore festive a prescindere dall'abilitazione, a meno che
  //non dipenda direttamente dal Modello Orario
  //(con gestione cambio ora legale/solare)
  if ((not IndFesDaOrario) and (StrConCauFes <> 'N')) or (abindfes = 'S') or ((abindfes = 'D') and (giorsett = 7)) or ((abindfes = 'F') and (tipoGG = 'F')) then
  begin
    if ttimbraturedip[ieu].tminutid_u < ttimbraturedip[ieu].tminutid_e then
      inc(indfes_lorda.Ore,ttimbraturedip[ieu].tminutid_u + 1440 - ttimbraturedip[ieu].tminutid_e)
    else
      inc(indfes_lorda.Ore,ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e);
    if ttimbraturedip[ieu].oralegsol then
      if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= indfes_lorda.Ore)) then
        inc(indfes_lorda.Ore,OraLegaleSolare.Diff)
      else
        indfes_lorda.Ore:=0;
  end;
  //4.0 - Calcolo la sola indennità festiva per la timbratura esclusa
  if ieu > n_timbrdip then
    exit;
  //Indennita' turno abilitata
  if (abindtur = 'S') and (ttimbraturedip[ieu].tminutid_u >= 1440) then
    //Settaggio flag per giorno con indennita' notturna
    indabiulttim:='si';
  //Test su primo range della fascia indennita'
  if (ttimbraturedip[ieu].tminutid_u > iniz1fascind) and
     (ttimbraturedip[ieu].tminutid_e < fine1fascind) then
    begin
    if ttimbraturedip[ieu].tminutid_e < iniz1fascind then
      comodo3:=iniz1fascind
    else
      comodo3:=ttimbraturedip[ieu].tminutid_e;
    if ttimbraturedip[ieu].tminutid_u > fine1fascind then
      comodo3:=fine1fascind - comodo3
    else
      comodo3:=ttimbraturedip[ieu].tminutid_u - comodo3;
    if abindtur = 'S' then
      inc(indnotmin,comodo3);
    //Registro tutte le ore notturne a prescindere dall'abilitazione, a meno che
    //non dipenda direttamente dal Modello Orario
    if ((not IndNotDaOrario) and (StrConCauTur <> 'N')) or (abindtur = 'S') then
    //if (not IndNotDaOrario) or (abindtur = 'S') then
      inc(indnot_lorda.Ore,comodo3);
    end;
  //Test su secondo eventuale range della fascia indennita'
  //con gestione cambio ora legale/solare
  if (ttimbraturedip[ieu].tminutid_u > iniz2fascind) and (ttimbraturedip[ieu].tminutid_e < fine2fascind) then
    begin
    if ttimbraturedip[ieu].tminutid_e < iniz2fascind then
      comodo3:=iniz2fascind
    else
      comodo3:=ttimbraturedip[ieu].tminutid_e;
    if ttimbraturedip[ieu].tminutid_u > fine2fascind then
      comodo3:=fine2fascind - comodo3
    else
      comodo3:=ttimbraturedip[ieu].tminutid_u - comodo3;
    if abindtur = 'S' then
      begin
      inc(indnotmin,comodo3);
      if ttimbraturedip[ieu].oralegsol then
        if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= indnotmin)) then
          inc(indnotmin,OraLegaleSolare.Diff)
        else
          indnotmin:=0;
      end;
    //Registro tutte le ore notturne a prescindere dall'abilitazione, a meno che
    //non dipenda direttamente dal Modello Orario
    if ((not IndNotDaOrario) and (StrConCauTur <> 'N')) or (abindtur = 'S') then
    //if (not IndNotDaOrario) or (abindtur = 'S') then
      begin
      inc(indnot_lorda.Ore,comodo3);
      if ttimbraturedip[ieu].oralegsol then
        if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= indnot_lorda.Ore)) then
          inc(indnot_lorda.Ore,OraLegaleSolare.Diff)
        else
          indnot_lorda.Ore:=0;
      end;
    end;
  if (abindtur = 'N') and (T200[Q200.FieldByName('IndTurno').Index] = 'A') then exit;
  //Calcolo minuti lavorati prima e dopo mezzogiorno
  //per le coppie di timbrature non causalizzate
  //if ttimbraturedip[ieu].tcausale_e.tcaus <> '' then exit; //Alberto 14/11/2010: eliminato il vincolo sulla non causalizzazione
  if ttimbraturedip[ieu].tminutid_u <= 720 then
    minlavmat:=minlavmat + ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e
  else if ttimbraturedip[ieu].tminutid_e >= 720 then
    minlavpom:=minlavpom + ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e
  else
  begin
    minlavmat:=minlavmat + 720 - ttimbraturedip[ieu].tminutid_e;
    minlavpom:=minlavpom + ttimbraturedip[ieu].tminutid_u - 720;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z704_indpres;
{Calcolo minuti lavorati per indennita' di presenza}
var IPE,IPU:String;
begin
  (*Alberto*)
  (*if (ttimbraturedip[ieu].tcausale_e.tcaus <> '') and (ttimbraturedip[ieu].tcausale_e.tcaustip = 'B') and
     (ttimbraturedip[ieu].tcausale_e.tcausrag = traggrcauspr[3].C) then
    //Le ore lavorate in reperibilita' non sono influenti per
    //l'indennita' di presenza
    exit;*)
  //Leggo l'abilitazione alla maturazione di indennità di presenza
  //sul raggr.causale oppure sul contratto per straordinario non causalizzato
  IPE:='S';
  IPU:='S';
  with ttimbraturedip[ieu] do
    begin
    if (tcausale_e.tcaus <> '') and (tcausale_e.tcaustip = 'B') then
      IPE:=VarToStr(Q270.Lookup('Codice',tcausale_e.tcauscodrag,'IndPresenza'))
    else if (tpuntnomin = 0) and (tcausale_e.tcaus = '') then
      IPE:=cdsT020.FieldByName('IndPresStr').AsString;
    if (tcausale_u.tcaus <> '') and (tcausale_u.tcaustip = 'B') then
      IPU:=VarToStr(Q270.Lookup('Codice',tcausale_u.tcauscodrag,'IndPresenza'))
    else if (tpuntnomin = 0) and (tcausale_u.tcaus = '') then
      IPU:=cdsT020.FieldByName('IndPresStr').AsString;
    end;
  //Se la maturazione dipende dall'Eccedenza Giornaliera, attivo sempre la maturazione
  if (IPE = '0') or (IPE = '2') then
    IPE:='S';
  if (IPU = '0') or (IPU= '2') then
    IPU:='S';
  if (IPE <> 'S') and (IPU <> 'S') then exit;
  if (primat_u = 'si') and (indprescalcieri = 'no') and (ttimbraturedip[ieu].tminutid_e = 0) then
  //Minuti lavorati ancora di ieri per indennita' di presenza (gestione cambio ora legale/solare)
  begin
    minlavpresieri:=minlavpresieri + ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e;
    if ttimbraturedip[ieu].oralegsol then
      if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= minlavpresieri)) then
        inc(minlavpresieri,OraLegaleSolare.Diff)
      else
        minlavpresieri:=0;
  end
  else if (ultimt_e = 'si') and (turnicavmez = 'si') and (ttimbraturedip[ieu].tminutid_u = 1440) then
  //Minuti lavorati con cavallo di mezzanotte (gestione cambio ora legale/solare)
  begin
    minlavprescav:=minlavprescav + ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e;
    if ttimbraturedip[ieu].oralegsol then
      if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= minlavprescav)) then
        inc(minlavprescav,OraLegaleSolare.Diff)
      else
        minlavprescav:=0;
  end
  else if (TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and
          (Trim(cdsT020.FieldByName('CompNot').AsString) = '') and (ultimt_e = 'si') and
          (ttimbraturedip[ieu].tminutid_u > 1440) then
  //Minuti lavorati con cavallo di mezzanotte, conteggio su entrata e doppia indennità (gestione cambio ora legale/solare)
  begin
    if ttimbraturedip[ieu].tminutid_e <= 1440 then  //Alberto 15/02/2005
    begin
      minlavpresoggi:=minlavpresoggi + 1440 - ttimbraturedip[ieu].tminutid_e;
      minlavprescav:=minlavprescav + ttimbraturedip[ieu].tminutid_u - 1440;
      if ttimbraturedip[ieu].oralegsol then
        if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= minlavprescav)) then
          inc(minlavprescav,OraLegaleSolare.Diff)
        else
          minlavprescav:=0;
    end;
  end
  (* da vedere con Nando per conteggio doppia indennità su doppio turno matt + notte
  else if (TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and
          (Trim(cdsT020.FieldByName('CompNot').AsString) = 'U') and (ultimt_e = 'si') and
          (ttimbraturedip[ieu].tminutid_u > 1440) then
  //Minuti lavorati con cavallo di mezzanotte, conteggio su entrata e doppia indennità (gestione cambio ora legale/solare)
  begin
    if ttimbraturedip[ieu].tminutid_e <= 1440 then  //Alberto 15/02/2005
    begin
      minlavprescav:=minlavprescav + ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e;
      if ttimbraturedip[ieu].oralegsol then
        if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= minlavprescav)) then
          inc(minlavprescav,OraLegaleSolare.Diff)
        else
          minlavprescav:=0;
    end;
  end
  *)
  else
  //Minuti lavorati di oggi per indennita' di presenza (gestione cambio ora legale/solare)
  begin
    minlavpresoggi:=minlavpresoggi + ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e;
    if ttimbraturedip[ieu].oralegsol then
      if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= minlavpresoggi)) then
        inc(minlavpresoggi,OraLegaleSolare.Diff)
      else
        minlavpresoggi:=0;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z706_indverieri;
{Verifica se si puo' calcolare
 l' indennita' di presenza di ieri}
begin
  if indprescalcieri = 'no' then
    if numcorr <> (numcorrpreccall + 1) then
      indprescalcieri:='si';
  //Salvataggio numero corrispondente alla chiamata attuale
  numcorrpreccall:=numcorr;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z708_indennitadascostgg;
{Aggiorno i minuti di maturazione indennità in base allo scostamento giornaliero}
var Temp,i:Integer;
begin
  z752_lavscostgg;
  if Scost <= 0 then exit;
  //Indennità FESTIVA abilitata e Eccedenza esclusa
  //if (cdsT020.FieldByName('IndFestiva').AsString = 'S') and (cdsT020.FieldByName('IndFestStr').AsString = '2') then
  if (cdsT020.FieldByName('IndFestiva').AsString <> 'N') and (cdsT020.FieldByName('IndFestStr').AsString = '2') then
    for i:=1 to n_fasce do
      if tfasceorarie[i].tiniz1fasc < 1440 then
      begin
        if minlavfes > tminstrgio[i] then
          dec(minlavfes,tminstrgio[i])
        else
          minlavfes:=0;
      end;
  //Indennità NOTTURNA abilitata e Eccedenza esclusa
  if (cdsT020.FieldByName('IndTurno').AsString = 'S') and (cdsT020.FieldByName('IndNotStr').AsString = '2') then
    for i:=1 to n_fasce do
      if (tfasceorarie[i].tiniz1fasc >= iniz1fascind) and (tfasceorarie[i].tfine1fasc <= fine1fascind) or
         (tfasceorarie[i].tiniz1fasc >= iniz2fascind) and (tfasceorarie[i].tfine1fasc <= fine2fascind) then
        if indnotmin > tminstrgio[i] then
          dec(indnotmin,tminstrgio[i])
        else
          indnotmin:=0;
  //Indennità di PRESENZA con Eccedenza esclusa
  if cdsT020.FieldByName('IndPresStr').AsString = '2' then
    begin
    Temp:=0;
    for i:=1 to n_fasce do
      inc(Temp,tminstrgio[i]);
    if (ultimt_e = 'si') and (n_timbrdip > 0) and (ttimbraturedip[n_timbrdip].tpuntnomin = 0) then
      //Decremento indennità per il giorno succ.
      if minlavprescav > Temp then
        begin
        dec(minlavprescav,Temp);
        Temp:=0;
        end
      else
        begin
        dec(Temp,minlavprescav);
        minlavprescav:=0;
        end;
    if (primat_u = 'si') and (n_timbrdip > 0) and (ttimbraturedip[1].tpuntnomin = 0) then
      //Decremento indennità dal giorno prec.
      if minlavpresieri > Temp then
        begin
        dec(minlavpresieri,Temp);
        Temp:=0;
        end
      else
        begin
        dec(Temp,minlavpresieri);
        minlavpresieri:=0;
        end;
    //Detraggo l'eccedenza residua da 1°:minlavpresoggi - 2°:minlavprescav - 3°:minlavpresieri
    if minlavpresoggi > Temp then
      dec(minlavpresoggi,Temp)
    else
      begin
      dec(Temp,minlavpresoggi);
      minlavpresoggi:=0;
      if minlavprescav > Temp then
        dec(minlavprescav,Temp)
      else
        begin
        dec(Temp,minlavprescav);
        minlavprescav:=0;
        if minlavpresieri > Temp then
          dec(minlavpresieri,Temp)
        else
          minlavpresieri:=0;
        end;
      end;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z710_indennita;
{Calcolo indennita' festive, di turno e di presenza
 Calcolo indennita' festiva
 Verifico se giorno festivo o domenica}
var PT,PTFest:Real;
    i:Integer;
    CausU0000,CausE0000:String;
    U0000,E0000:Boolean;
  procedure IndFestFasciaNotturna;
  var R502IndFest:TR502ProDtM1;
  begin
    if R180In(Chiamante,['Cartellino','Assenze','Anomalie']) then
      exit;
    if not(((TipoOrario = 'E') and (PeriodoLavorativo = 'T1')) or (TipoOrario = 'D')) then
      exit;
    if R180In(Self.Name,['R502IndFest','R502Ricorsivo','R502NotteUscita']) then
      exit;
    if trim(f03_com) <> '' then
      exit;
    minlavfes:=0;
    indfesrid:=0;
    if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
      R502IndFest:=TR502ProDtM1.Create(Self.Owner,True)
    else
      R502IndFest:=TR502ProDtM1.Create(SessioneOracleR502,True);
    SessioneOracleR502.Name:=StringReplace(SessioneOracleR502.Name,'RICORSIONE_','',[]);
    try
      R502IndFest.Name:='R502IndFest';
      R502IndFest.PeriodoConteggi(datacon - 1,datacon + 1);
      R502IndFest.ConsideraRichiesteWeb:=ConsideraRichiesteWeb;
      R502IndFest.datacon_indfes_nottecompleta:=datacon;

      //gg corrente
      R502IndFest.f03_com:='DALLE*0000';
      R502IndFest.Conteggi('Cartolina',ProgrCon,datacon);
      minlavfes_nottecompletaCorr:=R502IndFest.minlavfes;
      inc(minlavfes,R502IndFest.minlavfes);
      if minlavfes < comodo2 then
      begin
        //gg successivo
        if not((TipoGG_suc = 'F') or (giorsett = 6)) then
        begin
          R502IndFest.f03_com:='DALLE*0000*ALLE*0600';
          R502IndFest.Conteggi('Cartolina',ProgrCon,datacon + 1);
          minlavfes_nottecompletaSucc:=R502IndFest.minlavfes;
          inc(minlavfes,R502IndFest.minlavfes);
        end;
        if minlavfes < comodo2 then
        begin
          //gg precedente
          if not((TipoGG_prec = 'F') or (giorsett = 1)) then
          begin
            R502IndFest.f03_com:='DALLE*2200';
            R502IndFest.Conteggi('Cartolina',ProgrCon,datacon - 1);
            minlavfes_nottecompletaPrec:=R502IndFest.minlavfes;
            inc(minlavfes,R502IndFest.minlavfes);
          end;
        end;
      end;
    finally
      FreeAndNil(R502IndFest);
    end;
    if minlavfes > comodo2 then
      //Giorno con indennita' festiva intera
      indfesint:=1 * PTFest
    else if minlavfes >= 120 then
      //Giorno con indennita' festiva ridotta
      indfesrid:=1 * PTFest;
  end;
begin
  //Alberto 14/07/2006: abbattimento delle indennità festive/notturne da parte di causali di assenza che diminuiscono le ore
  for i:=1 to n_fasce do
  begin
    //Abbattimento ind.festiva
    dec(minlavfes,Min(minlavfes,tfasceorarie[i].AbbFascia));
    //Abbattimento ind.notturna se la fascia è notturna
    if (tfasceorarie[i].tiniz1fasc = iniz1fascind) and (tfasceorarie[i].tfine1fasc = fine1fascind) or
       (tfasceorarie[i].tiniz2fasc = iniz2fascind) and (tfasceorarie[i].tfine2fasc = fine2fascind) then
      dec(indnotmin,Min(indnotmin,tfasceorarie[i].AbbFascia));
  end;
  z708_indennitadascostgg;
  z711_GetPercentualiPartTime(PT,PTFest);

  if ((tipogg = 'F') or (giorsett = 7)) and (debitoindfes <> 0) then
  begin
    comodo2:=debitoindfes div 2;
    if minlavfes > comodo2 then
      //Giorno con indennita' festiva intera
      indfesint:=1 * PTFest
    else if minlavfes >= 120 then
      //Giorno con indennita' festiva ridotta
      indfesrid:=1 * PTFest;
    //Registro debito per indennità festiva per ricalcolo mensile
    indfes_lorda.Debito:=debitoindfes;

    //CCNL 2018: non maturo indennità festiva; allora devo verificare la notte estesa dalle 22.00 del gg prec. alle 06.00 del gg succ.
    if (indfesint = 0) and
       (cdsT020.FindField('INDFESTIVA_USA_NOTTE_COMPLETA') <> nil) and
       (cdsT020.FieldByName('INDFESTIVA_USA_NOTTE_COMPLETA').AsString = 'S') then
    begin
      //Conteggio 22gg.prec-06gg.succ del gg prec (se non festivo e <> domenica) e valuto maturazione in indfesint_prec
      IndFestFasciaNotturna;
    end;
  end;

  //Gestione tolleranza ed arrotondamento indennita' notturna
  if (StrToIntDef(T200[Q200.FieldByName('TolIndNot').Index],0) > 0) or
     (StrToIntDef(T200[Q200.FieldByName('ArrIndNot').Index],0) > 0) then
  begin
    inc(Indnotmin,StrToIntDef(T200[Q200.FieldByName('TolIndNot').Index],0));
    per892:=Indnotmin;
    arr890:=StrToIntDef(T200[Q200.FieldByName('ArrIndNot').Index],0);
    //Arrotondamento indennita' notturna
    z892_arrotondap;
    Indnotmin:=per892;
    indnot_lorda.Toll:=StrToIntDef(T200[Q200.FieldByName('TolIndNot').Index],0);
    indnot_lorda.Arr:=StrToIntDef(T200[Q200.FieldByName('ArrIndNot').Index],0);
  end;
  //Calcolo indennita' di turno
  if (T200[Q200.FieldByName('Tipo').Index] = 'PAL') or (T200[Q200.FieldByName('Tipo').Index] = 'AZP') then
    //Indennita' di turno per contratto PAL o AZP
    z712_indturpal
  else
  //Indennita' di turno per contratto USL
  //Verifico se ultima timbratura = E con indennita' abilitata
  if ((ultimt_e = 'si') or ((n_timbrdip > 0) and (ttimbraturedip[n_timbrdip].tminutid_u > 1440))) and (indabiulttim = 'si') then
    //Giorno con indennita' notturna
    indnotgg:=1
  else if indabiulttim = 'si' then
  begin
    //Indennita' di turno per contratto USL
    //Verifico se coppia di timbrature contigue spezzate sulla mezzanotte (giustificativi dalle..alle)
    U0000:=False;
    E0000:=False;
    CausU0000:='';
    CausE0000:='';
    for i:=1 to n_timbrdip do
    begin
      if (ttimbraturedip[i].tminutid_e < 1440) and
         (ttimbraturedip[i].tminutid_u = 1440) and
         (ttimbraturedip[i].tcausale_u.tcaustip <> 'A') and
         (ttimbraturedip[i].tag <> 'TG=ASSENZA')
      then
      begin
        U0000:=True;
        CausU0000:=ttimbraturedip[i].tcausale_u.tcaus;
      end;
      if (ttimbraturedip[i].tminutid_e = 1440) and
         (ttimbraturedip[i].tminutid_u > 1440) and
         (ttimbraturedip[i].tcausale_u.tcaustip <> 'A') and
         (ttimbraturedip[i].tag <> 'TG=ASSENZA')
      then
      begin
        E0000:=True;
        CausE0000:=ttimbraturedip[i].tcausale_e.tcaus;
      end;
      if U0000 and E0000 then
        Break;
    end;
    if U0000 and E0000 and (CausU0000 = CausE0000) then
      indnotgg:=1;
  end;
  //Calcolo indennita' di presenza
  if indprescalcieri = 'no' then
    //Gestione della doppia indennità su turno notturno contato sull'entrata
    if (TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and
       (Trim(cdsT020.FieldByName('CompNot').AsString) = '') and
       (minlavpresieri > 0) and NotteSuEntrata then
    begin
      indprescalcieri:='si';
      inc(minlavpresoggi,minlavpresieri);
      minlavpresieri:=0;
    end
    //Conteggio indennita' di presenza della notte precedente
    else if (minlavpresieri + tollpresieri) >= mmminpresieriint then
    begin
      if compnotieri = 'E' then
        tindennitapresenza[1].tindpres:=1 * PT
      else
        tindennitapresenza[2].tindpres:=1 * PT;
    end
    else if (minlavpresieri + tollpresieri) >= mmminpresierimez then
    begin
      if compnotieri = 'E' then
        tindennitapresenza[1].tindpres:=0.5 * PT
      else
        tindennitapresenza[2].tindpres:=0.5 * PT;
    end;
  if (TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and (ultimt_e = 'si') and
     ((Trim(cdsT020.FieldByName('CompNot').AsString) <> '')
      or
      ((Trim(cdsT020.FieldByName('CompNot').AsString) = '') and (minlavprescav > 0) and NotteSuEntrata)
     ) then
    //Salvataggio dati per indennita' di presenza con gestione
    //cavallo di mezzanotte
  begin
    indprescalcieri:='no';
    minlavpresieri:=minlavprescav;
    mmminpresieriint:=mmminpresoggiint;
    mmminpresierimez:=mmminpresoggimez;
    tollpresieri:=ValNumT020['TollPres'];
    compnotieri:=R180CarattereDef(cdsT020.FieldByName('CompNot').AsString);
  end
  else
  //Non occorre gestire il cavallo della mezzanotte
  begin
    indprescalcieri:='si';
    inc(minlavpresoggi,minlavprescav);
  end;
  //Conteggio indennita' di presenza del giorno attuale
  if (ValNumT020['MMINDPRESMAG'] > 0) and
     (cdsT020.FieldByName('COEFF_INDPRESMAG').AsFloat > 0) and
     (minlavpresoggi + ValNumT020['TollPres'] >= ValNumT020['MMINDPRESMAG']) then
    tindennitapresenza[3].tindpres:=1 * cdsT020.FieldByName('COEFF_INDPRESMAG').AsFloat * PT
  else if (minlavpresoggi + ValNumT020['TollPres']) >= mmminpresoggiint then
    tindennitapresenza[3].tindpres:=1 * PT
  else if (minlavpresoggi + ValNumT020['TollPres']) >= mmminpresoggimez then
    tindennitapresenza[3].tindpres:=0.5 * PT;
  if indpresdaass = 'si' then
    //Indennita' di presenza maturata da assenza
    tindennitapresenza[3].tindpres:=1 * PT;
  //Calcolo rientro pomeridiano (PARMA_AIPO)
  if cdsT020.FieldByName('RIENTRO_POMERIDIANO').AsString = 'S' then
    z1010_RientroPomeridiano;
  // AOSTA_REGIONE - commessa 2012/152 - SVILUPPO 6.ini
  if (cdsT020.FieldByName('FESTLAV_LIQ').AsString <> '') and           // FESTLAV_LIQ is not null
     (cdsT020.FieldByName('FESTLAV_CMP_LIQ').AsString <> '') and       // FESTLAV_CMP_LIQ is not null
     (cdsT020.FieldByName('FESTLAV_CMP_LIQ_TURN').AsString <> '') then // FESTLAV_CMP_LIQ_TURN is not null
    z1012_FestivoLavorato;
  // AOSTA_REGIONE - commessa 2012/152 - SVILUPPO 6.fine
end;
//_________________________________________________________________
procedure TR502ProDtM1.z711_GetPercentualiPartTime(var IndPres,IndFest:Real);
begin
  IndPres:=1;
  IndFest:=1;

  // le indennità vanno proporzionate solo per il part-time orizzontale [e il ciclico 10-02-2022 - 10.8(6) REGGIOEMILIA_COMUNE - 165370]
  if Q460.SearchRecord('Tipo;Codice',VarArrayOf(['O',Q430.FieldByName('PARTTIME').AsString]),[srFromBeginning]) or
     Q460.SearchRecord('Tipo;Codice',VarArrayOf(['C',Q430.FieldByName('PARTTIME').AsString]),[srFromBeginning]) then
  try
    IndPres:=Q460.FieldByName('INDPRES').AsFloat / 100;
    IndFest:=Q460.FieldByName('INDFEST').AsFloat / 100;
  except
  end;
end;

//_________________________________________________________________
procedure TR502ProDtM1.z712_indturpal;
{Indennita' di turno per contratto PAL}
var i,j,c,m,DetPM:Integer;
    MinutiCoperti:TMinutiCoperti;
begin
  indnotmin:=0;
  //Numero di presenze pomeridiane raffrontato con quello delle mensili
  if T200[Q200.FieldByName('IndTurno').Index] = 'A' then
    //Verifico se le ore pomeridiane superano quelle mattutine
  begin
    if minlavpom > minlavmat then
      indnotgg:=1;
    exit;
  end;
  if cdsT020.FieldByName('IndTurno').AsString <> 'S' then exit;

  //Numero di ore fatte in turno con o senza controllo dei pomeriggi lavorati
  if (T200[Q200.FieldByName('IndTurno').Index] = 'B') or (T200[Q200.FieldByName('IndTurno').Index] = 'C') then
  begin
    for i:=1 to n_timbrcon do
      //Alberto 21/01/2009: Causali di presenza incluse nelle indennità di turno
      if (ValStrT275[ttimbraturecon[i].tcaus,'INCLUDI_INDTURNO'] <> 'N') then
        indnotmin:=indnotmin + ttimbraturecon[i].tminutic_u - ttimbraturecon[i].tminutic_e;
    //Detrazione pausa mensa e causali che non maturano indennita' di turno
    DetPM:=paumendet;
    for i:=1 to n_rieppres do
      if (ValStrT275[triepgiuspres[i].tcauspres,'INCLUDI_INDTURNO'] = 'N') then
        dec(DetPM,triepgiuspres[i].DetPM);
    if DetPM + tfasceorarie[fasciabass].AbbFascia < indnotmin then
      dec(indnotmin,DetPM + tfasceorarie[fasciabass].AbbFascia)
    else
      indnotmin:=0;
    if StrToIntDef(T200[Q200.FieldByName('ARR_INDTURNO_PAL').Index],0) > 1 then
    begin
      arr890:=StrToIntDef(T200[Q200.FieldByName('ARR_INDTURNO_PAL').Index],0);
      per892:=indnotmin;
      z892_arrotondap;
      indnotmin:=per892;
    end;
    exit;
  end;
  //Numero di ore fatte in turno suddivise in fasce all'interno dei punti nominali
  if T200[Q200.FieldByName('IndTurno').Index] = 'D' then
  begin
    for i:=1 to n_timbrcon do
      //Alberto 21/01/2009: Causali di presenza incluse nelle indennità di turno
      if (ValStrT275[ttimbraturecon[i].tcaus,'INCLUDI_INDTURNO'] <> 'N') then
      begin
        for j:=1 to MaxFasceGio do
          z714_suddivisioneFasce(1,ttimbraturecon[i].tminutic_e,ttimbraturecon[i].tminutic_u,j,tindturfas);
      end;
    //Detrazione pausa mensa e causali che non maturano indennita' di turno
    DetPM:=paumendet;
    for i:=1 to n_rieppres do
      if ValStrT275[triepgiuspres[i].tcauspres,'INCLUDI_INDTURNO'] = 'N' then
        dec(DetPM,triepgiuspres[i].DetPM);
    comodo3:=DetPM + tfasceorarie[fasciabass].AbbFascia;
    i1:=1;
    repeat
      if tindturfas[i1] <> 0 then
        if tindturfas[i1] > comodo3 then
        begin
          tindturfas[i1]:=tindturfas[i1] - comodo3;
          comodo3:=0;
        end
        else
        begin
          dec(comodo3,tindturfas[i1]);
          tindturfas[i1]:=0;
        end;
      inc(i1);
    until (i1 > 4) or (comodo3 = 0);
  end;
  //Numero di ore fatte in turno suddivise in fasce all'interno del debito giornaliero
  if T200[Q200.FieldByName('IndTurno').Index] = 'E' then
  begin
    //Considero tutto il lavorato
    for i:=1 to n_fasce do
      tindturfas[i]:=tminlav[i];
    //poi tolgo le assenze che non maturano indennità
    for i:=1 to n_riepasse do
    begin
      if not((ValStrT265[triepgiusasse[i].tcausasse,'ESCLUSIONE'] = 'S') and
             (ValStrT265[triepgiusasse[i].tcausasse,'INDTURNO'] = 'S')) then
      begin
        detrazioni:=triepgiusasse[i].tminresasse;
        z140_detrazioni(tindturfas);
      end;
    end;
    if XParam[XP_INDTURNO_CAUSALIZZATA] then
    begin
      //tolgo le causali che non maturano indennità di turno (Genova_Comune)
      MinutiCoperti:=TMinutiCoperti.Create;
      try
        for i:=1 to n_rieppres do
          if  (ValStrT275[triepgiuspres[i].tcauspres,'INCLUDI_INDTURNO'] = 'N')
          and (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A')      //Ore incluse nelle normali
          then
          begin
            for j:=0 to High(triepgiuspres[i].CoppiaEU) do
              MinutiCoperti.CopriIntervallo[triepgiuspres[i].CoppiaEU[j].e, triepgiuspres[i].CoppiaEU[j].u];
            for j:=1 to n_fasce do
            begin
              m:=min(triepgiuspres[i].tminpres[j],MinutiCoperti.Copertura);
              m:=min(m,tindturfas[j]);
              dec(tindturfas[j],m);
              MinutiCoperti.Copertura:=MinutiCoperti.Copertura - m;
            end;
          end;
      finally
        MinutiCoperti.Free;
      end;
    end
    else
    begin
      //Tolgo la parte di straordinario (comportamento Standard)
      if not XParam[XP_PARMA_INDTURNO] then
      begin
        for i:=1 to n_fasce do
          dec(tindturfas[i],min(tindturfas[i],tminstrgio2[i]));
      end;
    end;
    //poi tolgo la parte eccedente il debito
    c:=R180SommaArray(tindturfas) - debitogg;
    if c > 0 then
      for i:=1 to n_fasce do
      begin
        if c = 0 then Break;
        m:=Min(c,tindturfas[i]);
        dec(c,m);
        dec(tindturfas[i],m);
      end;
  end;

  if ((T200[Q200.FieldByName('IndTurno').Index] = 'D') or (T200[Q200.FieldByName('IndTurno').Index] = 'E')) and
     (StrToIntDef(T200[Q200.FieldByName('ARR_INDTURNO_PAL').Index],0) > 1) then
  begin
    arr890:=StrToIntDef(T200[Q200.FieldByName('ARR_INDTURNO_PAL').Index],0);
    for i:=1 to n_fasce do
    begin
      per892:=tindturfas[i];
      z892_arrotondap;
      tindturfas[i]:=per892;
    end;
  end;
  if (T200[Q200.FieldByName('Tipo').Index] = 'PAL') and ((T200[Q200.FieldByName('IndTurno').Index] = 'D') or (T200[Q200.FieldByName('IndTurno').Index] = 'E')) then
  begin
    indnotmin:=0;
    for i:=1 to n_fasce do
      inc(indnotmin,tindturfas[i]);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z714_suddivisioneFasce(segno,mmda,mma,j:Integer; var Vettore:array of Integer);
{Suddivisione timbrature conteggiate in fasce}
begin
  with tfasceorarie[j] do
  begin
    //Test su primo range della fascia
    if (mma > tiniz1fasc) and (mmda < tfine1fasc) then
    begin
      if mmda < tiniz1fasc then
        comodo3:=tiniz1fasc
      else
        comodo3:=mmda;
      if mma > tfine1fasc then
        comodo3:=tfine1fasc - comodo3
      else
        comodo3:=mma - comodo3;
      inc(Vettore[j - 1],comodo3*segno);
    end;
    //Test su secondo eventuale range della fascia
    if (mma > tiniz2fasc) and (mmda < tfine2fasc) then
    begin
      if mmda < tiniz2fasc then
        comodo3:=tiniz2fasc
      else
        comodo3:=mmda;
      if mma > tfine2fasc then
        comodo3:=tfine2fasc - comodo3
      else
        comodo3:=mma - comodo3;
      inc(Vettore[j - 1],comodo3*segno);
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z720_turfat;
{Calcolo turno fatto}
var locPuntNomin:Integer;
  function GetSiglaTurno(nturno:Integer):String;
  var i:Integer;
  begin
    Result:='';
    for i:=1 to n_timbrnom do
      if ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,i] = nturno then
      begin
        Result:=ValStrT021['SIGLATURNI',TF_PUNTI_NOMINALI,i];
        Break;
      end;
  end;
begin
  locPuntNomin:=ttimbraturedip[ieu].tpuntnomin;
  if (locPuntNomin = 0) and
     (ttimbraturedip[ieu].tpuntnominold <> 0) and
     (ttimbraturedip[ieu].tcausale_e.tcaus <> '') and
     (ValStrT275[ttimbraturedip[ieu].tcausale_e.tcaus,'RICONOSCIMENTO_TURNO'] = 'S')
  then
  begin
    locPuntNomin:=ttimbraturedip[ieu].tpuntnominold;
    if (pe = 0) and (pu = 0) then
    begin
      if TipoOrario = 'E' then
      begin
        pe:=ttimbraturenom[locPuntNomin].tpuntre;
        pu:=ttimbraturenom[locPuntNomin].tpuntru;
      end
      else
      begin
        pe:=locPuntNomin;
        pu:=locPuntNomin;
      end;
    end;
  end;
  if locPuntNomin = 0 then
    exit;

  if pe = 0 then
    //Smonto notte
    begin
    s_turno1:='Sn';
    n_turno1:=-8;
    r_turno1:=-8;
    exit;
    end;
  if (ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,pe] <> n_turno1) and (ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,pe] <> n_turno2) then
  begin
    if n_turno1 <= 0 then
      n_turno1:=ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,pe]
    else if n_turno2 = 0 then
      n_turno2:=ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,pe];
  end;
  //Registro i turni riconosciuti
  if (r_turno1 = -1) or (r_turno1 = pe) then
    r_turno1:=pe
  else if r_turno2 = -1 then
    r_turno2:=pe;
  //Registro le sigle del turno
  if TipoOrario <> 'E' then
    exit;
  if r_turno1 > 0 then
    s_turno1:=ValStrT021['SIGLATURNI',TF_PUNTI_NOMINALI,pe]//GetSiglaTurno(n_turno1)
  else if c_turni1 = 0 then
    s_turno1:='Rp';
  if r_turno2 > 0 then
    s_turno2:=ValStrT021['SIGLATURNI',TF_PUNTI_NOMINALI,pe]//GetSiglaTurno(n_turno2)
  else if c_turni2 = 0 then
    s_turno2:='Rp';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z730_RiepilogoRilevatori;
var i,x,He,Hu,P1,P2:Integer;
    ril:String;
  procedure PutElencoRilevatori(rilev:String);
  var j1,r1:Integer;
  begin
    //Registrazione elenco dei rilevatori
    r1:=-1;
    for j1:=0 to High(telencorilev) do
      if telencorilev[j1] = rilev then
      begin
        r1:=j1;
        Break;
      end;
    if r1 = -1 then
    begin
      SetLength(telencorilev,Length(telencorilev) + 1);
      telencorilev[High(telencorilev)]:=rilev;
    end;
  end;
  procedure PutRiepilogoRilevatori;
  var j,r:Integer;
  begin
    //Ricerca del rilevatore nel riepilogo
    r:=-1;
    for j:=0 to High(trieprilev) do
      if trieprilev[j].rilevatore = ril then
      begin
        r:=j;
        Break;
      end;
    if r = -1 then
    begin
      //Nuovo rilevatore
      SetLength(trieprilev,Length(trieprilev) + 1);
      r:=High(trieprilev);
      trieprilev[r].rilevatore:=ril;
    end;
    inc(trieprilev[r].tminprestot,Hu - He);
  end;
begin
  SetLength(trieprilev,0);
  SetLength(telencorilev,0);
  //Elenco rilevatori usati senza riepilogare le ore
  for i:=0 to High(TimbratureOriginali) do
  begin
    if TimbratureOriginali[i].ril_e <> '' then
      PutElencoRilevatori(TimbratureOriginali[i].ril_e);
    if TimbratureOriginali[i].ril_u <> '' then
      PutElencoRilevatori(TimbratureOriginali[i].ril_u);
  end;
  if n_timbrdip = 0 then exit;
  for i:=0 to High(TimbratureOriginali) do
  begin
    //Riconoscimento del rilevatore
    if TimbratureOriginali[i].ril_e = TimbratureOriginali[i].ril_u then
      ril:=TimbratureOriginali[i].ril_e
    else if TimbratureOriginali[i].ril_e = '' then
      ril:=TimbratureOriginali[i].ril_u
    else if TimbratureOriginali[i].ril_u = '' then
      ril:=TimbratureOriginali[i].ril_e;
    //Leggo entrata/uscita e verifico a quali timbrature conteggiate si riferiscono
    He:=TimbratureOriginali[i].e;
    Hu:=TimbratureOriginali[i].u;
    P1:=1;
    for x:=1 to n_timbrdip do
      if (He > ttimbraturedip[x].tminutid_u) or (Copy(ttimbraturedip[x].Tag,1,3) = 'TG=') then
        P1:=x + 1;
    P2:=n_timbrdip;
    for x:=n_timbrdip downto 1 do
    begin
      if (Copy(ttimbraturedip[x].Tag,1,3) = 'TG=') then
        Continue
      else if (Hu < ttimbraturedip[x].tminutid_e) then
        P2:=x - 1;
    end;
    //Le timbrature originali vengono limitate all'interno delle timbrature conteggiate
    if P1 <= P2 then
    begin
      if He < ttimbraturedip[P1].tminutid_e then
        He:=ttimbraturedip[P1].tminutid_e;
      if Hu > ttimbraturedip[P2].tminutid_u then
        Hu:=ttimbraturedip[P2].tminutid_u;
      for x:=P1 to P2 - 1 do
        dec(Hu,ttimbraturedip[x + 1].tminutid_e - ttimbraturedip[x].tminutid_u);
      PutRiepilogoRilevatori;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z731_RiepilogoLibProf;
var x:Integer;
  procedure AddLibProf(Causale,Dalle,Alle:String);
  var i,k,HDalle,HAlle:Integer;
  begin
    k:=-1;
    for i:=0 to High(RiepLibProf) do
      if RiepLibProf[i].Causale = Causale then
      begin
        k:=i;
        Break;
      end;
    if k = -1 then
    begin
      SetLength(RiepLibProf,Length(RiepLibProf) + 1);
      k:=High(RiepLibProf);
      RiepLibProf[k].Causale:=Causale;
      RiepLibProf[k].Descrizione:=VarToStr(Q275.Lookup('CODICE',Causale,'DESCRIZIONE'));
      RiepLibProf[k].OrePianificate:=0;
      RiepLibProf[k].OreRese:=MinLavCau[Causale];
    end;
    if Dalle <> '' then
    begin
      HDalle:=R180OreMinutiExt(Dalle);
      HAlle:=R180OreMinutiExt(Alle);
      if HAlle <= HDalle then
        HAlle:=HAlle + 1440;
      inc(RiepLibProf[k].OrePianificate,HAlle - HDalle);
    end;
  end;
begin
  with cdsT320 do
    if Locate('Data',Datacon,[]) then
      while (not Eof) and (FieldByName('DATA').AsDateTime = DataCon) do
      begin
        AddLibProf(FieldByName('Causale').AsString,FieldByName('Dalle').AsString,FieldByName('Alle').AsString);
        Next;
      end;
  for x:=1 to n_rieppres do
    if triepgiuspres[x].tcauspres <> '' then
      AddLibProf(triepgiuspres[x].tcauspres,'','');
end;
//_________________________________________________________________
procedure TR502ProDtM1.z740_AlterazioneOreRese;
{Le ore rese vengono evenutualmente aumentate per arrivare a rendere le ore minime in fascia oraria o,
 se non indicate, le ore del debito gg
 Regione Piemonte: 27/05/2004}
var Soglia:Integer;
begin
  inc(tminlav[1],MinRicalcoloFest);
  if cdsT020.FieldByName('COPERTURA_CARENZA').AsString <> 'S' then
    exit;
  //PALERMO_UNIVERSITA - Alberto 12/10/2017: la copertura della carenza avviene solo se ci sono delle timbrature nel giorno o se le tmbrature sono facoltative
  if (cdsT020.FieldByName('OBBLFAC').AsString = 'O') and (Length(TimbratureDelGiorno) = 0) then
    exit;
  if ValNumT020['OREMIN'] > 0 then
    Soglia:=Min(ValNumT020['OREMIN'],DebitoGG)
  else
    Soglia:=DebitoGG;
  z752_lavscostgg;
  CoperturaCarenza:=Max(0,Soglia - TotLav);
  inc(tminlav[1],CoperturaCarenza);
  z098_anom2caus(59,Format('%s ore',[R180MinutiOre(CoperturaCarenza)]));
  //Riaggiorno eventuale scostamento negativo
  z752_lavscostgg;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z750_saldigg;
{Calcolo saldi giornalieri
 Calcolo lavorato giornaliero}
var Soglia,CompNetto,ScostFinale,OraMaxComp,AppScostNeg:Integer;
    i,j,t,app:Integer;
begin
  z752_lavscostgg;
  //Per gli orari con timbrature facoltative viene comunque
  //reso l'orario teorico quando la giornata presenta solo
  //giustificativi dalle alle o in numero ore
  if (scost < 0) and (timbfac = 'si') and ((n_giusdaa > 0) or (n_giusore > 0)) then
  begin
    totlav:=debitogg;
    tminlav[1]:=tminlav[1] - scost;
    scost:=0;
  end;

  //ASTI_ASL: maturazione compensabile entro la soglia da spezzoni di uscita non causalizzati
  CompNeg_UNonCaus:=0;
  if XParam[XP_Z750_COMP_UNONCAUS] then
  begin
    Soglia:=ValNumT020['MinScoStr'] - 1;
    if scost < Soglia then
    begin
      AppScostNeg:=-min(0,scost);
      t:=Soglia - scost;
      for i:=0 to High(SpezzoniNonAbilitati) do
      begin
        if SpezzoniNonAbilitati[i].TipoAbil <> 'NC' then
          Continue;
        if SpezzoniNonAbilitati[i].TipoSpez <> 'U' then
          Continue;
        app:=min(SpezzoniNonAbilitati[i].Durata,t);
        for j:=1 to n_fasce do
          z714_suddivisioneFasce(1,SpezzoniNonAbilitati[i].Inizio,SpezzoniNonAbilitati[i].Inizio + app,j,tminlav);
        dec(t,app);
        inc(CompNeg_UNonCaus,app);
      end;
      CompNeg_UNonCaus:=min(CompNeg_UNonCaus,AppScostNeg);
      z752_lavscostgg;
    end;
  end;

  if scost <= eccsolocomp then exit;
  //Gestione minuti resi da assenze solo compensabili
  comodo2:=scost - eccsolocomp;
  if comodo2 > minasscomp then
    inc(eccsolocomp,minasscomp)
  else
  begin
    eccsolocomp:=scost;
    exit;
  end;
  //Calcolo scostamento positivo tenendo conto degli eventuali
  //minuti solo compensabili
  (*Parametri in gioco:
    Q020MinScoStr: Soglia (minuti) di divisione tra compensabile e liquidabile
    Q020ArrScoStr: Arrotondamento (minuti) dello scostamento generale
    Q020CompLiq: Indica cosa fare dei minuti minori della Soglia:
       S: se scostamento <  soglia sono Compensabili
          se scostamento >= soglia sono Liquidabili
       N: se scostamento <  soglia sono Persi
          se scostamento >= soglia sono Liquidabili
       C: sono sempre Compensabili
       P: sono sempre Persi
    ScostFinale: Contiene lo scostamento finale liquidabile; è dato dallo
       scostamento iniziale meno i minuti persi o compensabili in seguito
       all'arrotondamento
    Q020TuttoComp: se 'S' trasforma il liquidabile in compensabile permettendo
       di applicare i minuti minimi e l'arrotondamento anche sul compensabile
  *)
  //Elimino dallo scostamento le ore rese con causale inclusa ma da non considerare nella soglia.
  for i:=1 to n_rieppres do
    if ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'D' then
      for j:=1 to High(triepgiuspres[i].tminpres) do
        dec(scost,triepgiuspres[i].tminpres[j]);
  if scost <= eccsolocomp then exit;
  Soglia:=ValNumT020['MinScoStr'];
  (*Gestione compensabile fino ad OraMax_Compensabile
    Si considerano le timbrature non appoggiate fatte dopo OraMaxComp, la cui eventuale causale
    non deve essere esclusa dalle normali nè esclusa dalla soglia*)
  OraMaxComp:=ValNumT020['OraMax_Compensabile'];
  if OraMaxComp > 0 then
  begin
    t:=0;
    for i:=1 to n_timbrdip do
      if (ttimbraturedip[i].tpuntnomin = 0) and (ttimbraturedip[i].tminutid_u > OraMaxComp) and (ttimbraturedip[i].tag <> 'TG=ASSENZA') then
        if (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'ORENORMALI'] <> 'A') and (ValStrT275[ttimbraturedip[i].tcausale_e.tcaus,'ORENORMALI'] <> 'D') then
          inc(t,ttimbraturedip[i].tminutid_u - max(OraMaxComp,ttimbraturedip[i].tminutid_e));
    //Arrotondamento in eccesso dello scostamento 'compensabile'
    per892:=Max(0,scost - t);
    arr890:=-ValNumT020['ArrScoStr'];
    z892_arrotondap;
    Soglia:=Min(Soglia,per892 + 1);
  end;
  comodo2:=scost - eccsolocomp;
  ScostFinale:=comodo2;
  if comodo2 >= Soglia then
  //Scostamento >= Soglia
  begin
    //Calcolo arrotondamento straordinario
    if ValNumT020['ArrScoStr'] <> 0 then
    begin
      if Soglia < ValNumT020['ArrScoStr'] then
        CompNetto:=comodo2 - Soglia
      else
        CompNetto:=comodo2 - ValNumT020['ArrScoStr'];
      per892:=CompNetto;
      arr890:=ValNumT020['ArrScoStr'];
      //Arrotondamento periodo di scostamento positivo
      z892_arrotondap;
      if CompNetto > per892 then
      begin
        comodo3:=CompNetto - per892;
        dec(ScostFinale,comodo3);
        if ((cdsT020.FieldByName('CompLiq').AsString = 'S') or (cdsT020.FieldByName('CompLiq').AsString = 'C')) and
           (cdsT020.FieldByName('ArrScoStr_Comp').AsString = 'S') then
          inc(eccsolocomp,comodo3)
        else
        begin
          //Straordinario arrotondato per difetto senza compensazione con assenze
          detrazioni:=comodo3;
          inc(strarrdet,detrazioni);
          //Detrazione straordinario per arrotondamento su ore lavorate
          z140_detrazioni(tminlav);
        end;
      end
      else
      //Straordinario arrotondato per eccesso
      begin
        tminlav[fasciabass]:=tminlav[fasciabass] + per892 - CompNetto;
        inc(ScostFinale,per892 - CompNetto);
      end;
    end;
    if cdsT020.FieldByName('CompLiq').AsString = 'C' then
    //I minuti minimi sono sempre Compensabili
    begin
      if Soglia > 0 then
      begin
        inc(eccsolocomp,Soglia - 1);
        dec(ScostFinale,Soglia - 1);
      end;
    end
    else if cdsT020.FieldByName('CompLiq').AsString = 'P' then
    //I minuti minimi vengono sempre Persi
    begin
      if Soglia > 0 then
      begin
        dec(ScostFinale,Soglia - 1);
        detrazioni:=Soglia - 1;
        inc(strarrdet,detrazioni);
        //Detrazione straordinario per arrotondamento su ore lavorate
        z140_detrazioni(tminlav);
      end;
    end;
    if cdsT020.FieldByName('TuttoComp').AsString = 'S' then
      //Includo tutto lo scostamento nel compensabile
      inc(eccsolocomp,ScostFinale);
  end
  else
    //Scostamento < Soglia:
    if ((cdsT020.FieldByName('CompLiq').AsString = 'S') or (cdsT020.FieldByName('CompLiq').AsString = 'C')) and
       (comodo2 >= ValNumT020['SCOSTGG_MIN_SOGLIA']) then //Alberto 10/08/2007: Collegno
    begin
      //Scostamento mantenuto nel compensabile con arrotondamento
      per892:=Trunc(R180Arrotonda(comodo2,ValNumT020['ArrScoStr_SottoSoglia'],'D'));
      detrazioni:=comodo2 - per892;
      comodo2:=per892;
      inc(eccsolocomp,comodo2); //incremento eccedenza compensabile
      //detrazioni minuti persi per arrotondamento
      detrazstr:=detrazioni;
      DetrazStraord:=detrazstr;
      dec(totlav,detrazioni);
      dec(scost,detrazioni);
      //prima detrazione da timbrature non appoggiate e non causalizzate (incluse nelle normali)
      if detrazioni > 0 then
        z139_detrTimbNonAppoggiate(False);
      //seconda detrazione da timbrature non appoggiate e causalizzate e incluse nelle normali
      if detrazioni > 0 then
        z139_detrTimbNonAppoggiate(True);
      //terza detrazione sul generico lavorato giornaliero

      //Alberto 21/02/2019: comportamento vecchio: prima si applicano le detrazioni su tminlav, e dopo le detrazioni sul riepilogo presenze
      if DetrazRiepprNorm = 'CS' then
      begin
        if detrazioni > 0 then
          z140_detrazioni(tminlav);
      end;
      //Detrazione straordinario su riepilogo presenze
      if detrazstr > 0 then
        z138_detrrieppr;
      //Alberto 21/02/2019: comportamento nuovo: prima si applicano le detrazioni sul riepilogo presenze, che abbattono anche tminlav, e dopo le detrazioni su tminlav per quello che rimane ancora da detrarre
      if DetrazRiepprNorm <> 'CS' then
      begin
        //Eventuali detrazioni straordinario su ore lavorate
        if detrazioni > 0 then
          z140_detrazioni(tminlav);
      end;
    end
    else
    begin
      //Lo scostamento non viene conteggiato
      if comodo2 >= ValNumT020['SCOSTGG_MIN_SOGLIA'] then
        z098_anom2caus(12,Format('[%s < %s]',[R180MinutiOre(comodo2),R180MinutiOre(Soglia)]))
      else
        z098_anom2caus(12,Format('[%s < %s]',[R180MinutiOre(comodo2),R180MinutiOre(ValNumT020['SCOSTGG_MIN_SOGLIA'])]));
      detrazioni:=comodo2;
      detrazstr:=comodo2;
      DetrazStraord:=detrazstr;
      //Detrazione straordinario su ore lavorate
      dec(totlav,detrazioni);
      dec(scost,detrazioni);
      //prima detrazione da timbrature non appoggiate e non causalizzate (incluse nelle normali)
      if detrazioni > 0 then
        z139_detrTimbNonAppoggiate(False);
      //seconda detrazione da timbrature non appoggiate e causalizzate e incluse nelle normali
      if detrazioni > 0 then
        z139_detrTimbNonAppoggiate(True);
      //terza detrazione sul generico lavorato giornaliero

      //Alberto 21/02/2019: comportamento vecchio: prima si applicano le detrazioni su tminlav, e dopo le detrazioni sul riepilogo presenze
      if DetrazRiepprNorm = 'CS' then
      begin
        if detrazioni > 0 then
          z140_detrazioni(tminlav);
      end;
      //Detrazione straordinario su riepilogo presenze
      if detrazstr > 0 then
        z138_detrrieppr;
      //Alberto 21/02/2019: comportamento nuovo: prima si applicano le detrazioni sul riepilogo presenze, che abbattono anche tminlav, e dopo le detrazioni su tminlav per quello che rimane ancora da detrarre
      if DetrazRiepprNorm <> 'CS' then
      begin
        //Eventuali detrazioni straordinario su ore lavorate
        if detrazioni > 0 then
          z140_detrazioni(tminlav);
      end;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z752_lavscostgg;
{Calcolo lavorato e scostamento giornaliero}
begin
  totlav:=R180SommaArray(tminlav);
  scost:= totlav - debitogg;
  scostneg:=min(scost,0);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z756_fasciaobbligatoria;
{Verifica del rispetto delle fasce obbligatorie specificate}
var i,k,mm,app,tot,n_fo,e_fo,u_fo,e_tn,u_tn,TotFasciaObb:Integer;
    n_fo_app,e_tn_app,u_tn_app:Integer;
    Fasce:array of TTurno;
  function PuntoNominaleCoperto(pn:Byte):Boolean;
  var x:Integer;
  begin
    Result:=False;
    for x:=1 to n_timbrdip do
      if ttimbraturedip[x].tpuntnomin = pn then
      begin
        Result:=True;
        Break;
      end;
  end;
  procedure VerificaFascia(E,U:Integer; TipoFascia:String);
  var mmFascia,j,x:Integer;
      Esiste:Boolean;
      F:String;
  begin
    if TipoFascia = 'O' then
      inc(TotFasciaObb,U - E);
    for mmFascia:=E to U do
    begin
      Esiste:=False;
      //Verifica se il minuto esiste nelle timbrature del dipendente
      for j:=1 to n_timbrdip do
      begin
        Esiste:=(mmFascia >= ttimbraturedip[j].tminutid_e) and
                (mmFascia <= ttimbraturedip[j].tminutid_u - 1);
        Esiste:=Esiste and
                ((ttimbraturedip[j].tpuntnomin <> 0) or
                 ((ttimbraturedip[j].tcausale_e.tcaus <> '') and (ttimbraturedip[j].tcausale_e.tcaus = ttimbraturedip[j].tcausale_u.tcaus)));
        if Esiste then Break;
      end;
      if not Esiste then
        //Verifica se il minuto esiste nei giustificativi dalle..alle
        for j:=1 to n_giusdaa do
        begin
          if ValStrT265[tgius_dallealle[j].tcausdaa,'COPRE_FASCIA_OBB'] = 'N' then
            Continue;
          Esiste:=(mmFascia >= tgius_dallealle[j].tminutida) and (mmFascia <= tgius_dallealle[j].tminutia - 1);
          if Esiste then Break;
        end;
      //Se il minuto è coperto, si verifica che non sia coperto da causale di presenza Esclusa dalle normali ed Esclusa dalla Fascia Obbl.
      if Esiste then
        for j:=1 to n_rieppres do
        begin
          if (ValStrT275[triepgiuspres[j].tcauspres,'TIPOCONTEGGIO'] = 'A') and
             (ValStrT275[triepgiuspres[j].tcauspres,'ESCLUSIONE_FASCIA_OBB'] = 'S') then
            for x:=0 to High(triepgiuspres[j].CoppiaEU) do
              if (mmFascia >= triepgiuspres[j].CoppiaEU[x].e) and (mmFascia <= triepgiuspres[j].CoppiaEU[x].u - 1) then
              begin
                Esiste:=False;
                Break;
              end;
          if not Esiste then Break;
        end;
      F:=TipoFascia;
      if Esiste then
        F:=F + 'P'
      else
       F:=F + 'C';
      if Length(Fasce) = 0 then
      begin
        //Prima fascia
        SetLength(Fasce,1);
        Fasce[High(Fasce)].T:=F;
        Fasce[High(Fasce)].Inizio:=mmFascia;
        Fasce[High(Fasce)].Fine:=mmFascia;
      end;
      if (Fasce[High(Fasce)].T = F) and (Fasce[High(Fasce)].Fine = mmFascia) then
        //Prolungamento fascia precedente
        Fasce[High(Fasce)].Fine:=min(mmFascia + 1,U)
      else
      begin
        //Nuova fascia
        SetLength(Fasce,Length(Fasce) + 1);
        Fasce[High(Fasce)].T:=F;
        Fasce[High(Fasce)].Inizio:=mmFascia;
        Fasce[High(Fasce)].Fine:=min(mmFascia + 1,U);
      end;
    end;
  end;
  procedure CopriFasciaObb;
  {Copertura fascia obbligatoria carente con minuti resi da giustificativi a numero ore e mezze giornate}
  var i,Tot,app:Integer;
  begin
    Tot:=0;
    for i:=1 to n_giusore do
    begin
      if ValStrT265[tgius_min[i].tcausore,'COPRE_FASCIA_OBB'] = 'N' then
        Continue;
      if (ValStrT275[tgius_min[i].tcausore,'TIPOCONTEGGIO'] = 'A') and
         (ValStrT275[tgius_min[i].tcausore,'ESCLUSIONE_FASCIA_OBB'] = 'S') then
        Continue;
      inc(Tot,tgius_min[i].tmin);
    end;
    for i:=1 to n_giusmga do
    begin
      if ValStrT265[tgius_mgass[i].tcausmgass,'COPRE_FASCIA_OBB'] = 'N' then
        Continue;
      inc(Tot,tgius_mgass[i].mmresi);
    end;
    if Tot = 0 then
      exit;
    //Copertura delle fasce obbligatorie scoperte
    for i:=0 to High(Fasce) do
    if Fasce[i].T = 'OC' then
    begin
      app:=min(Tot,Fasce[i].Fine - Fasce[i].Inizio);
      dec(Tot,app);
      inc(Fasce[i].Inizio,app);
    end;
  end;
begin
  //Controllo ore minime rese nel giorno
  if (gglav = 'no') and (debitogg = 0) then
    exit;
  mm:=ValNumT020['OREMIN'];
  if mm > 0 then
  begin
    z752_lavscostgg;
    //Non posso fare il controllo sulle ore minime se turno notturno senza conteggio su Entrata
    if not ((TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and (not NotteSuEntrata) and (turnonott > 0)) then
    begin
      if totlav < mm then
      begin
        z099_anom3(5,mm - totlav,'');
        SetLength(tanom3riscontrate[n_anom3].ta3param,2);
        tanom3riscontrate[n_anom3].ta3param[0]:=R180MinutiOre(totlav);
        tanom3riscontrate[n_anom3].ta3param[1]:=R180MinutiOre(mm);
      end;
    end;
  end;
  TotFasciaObb:=0;

  if n_giusgga > 0 then
    exit;
  if n_giusmga > 0 then
  begin
    mm:=0;
    for i:=1 to n_riepasse do
      if not (R180CarattereDef(ValStrT265[triepgiusasse[i].tcausasse,'INFLUCONT']) in ['A','G','I']) then
        inc(mm,RiepAssenza[triepgiusasse[i].tcausasse,'HHVAL']);
    if TotLav + mm >= DebitoGG then
      exit;
  end;

  SetLength(Fasce,0);
  //Controllo fasce obbligatorie/facoltative
  for i:=1 to n_timbrnom do
  begin
    //if (TipoOrario = 'E') and (r_turno1 <> i) and (r_turno2 <> i) then
    if (TipoOrario = 'E') and (not PuntoNominaleCoperto(i)) then
      Continue;
    e_tn:=ttimbraturenom[i].tminutin_e + ttimbraturenom[i].Flex - ttimbraturenom[i].FlexPM;
    u_tn:=ttimbraturenom[i].tminutin_u;
    n_fo:=1;
    n_fo_app:=1;
    while ValStrT021['ENTRATA',TF_OBBLIGATORIA,n_fo] <> '' do
    begin
      e_fo:=ValNumT021['ENTRATA',TF_OBBLIGATORIA,n_fo];
      u_fo:=ValNumT021['USCITA',TF_OBBLIGATORIA,n_fo];
      if u_fo = 1439 then
        u_fo:=1440;
      //Se l'inizio della fascia è in flessibilità, lo si sposta sul nuovo punto nominale
      if (e_fo >= ttimbraturenom[i].tminutin_e) and (e_fo <= e_tn) then
        e_fo:=e_tn;
      if (e_fo >= e_tn) and (e_fo <= u_tn) then
      begin
        VerificaFascia(e_tn,Max(e_fo,e_tn),'F');
        VerificaFascia(e_fo,Min(u_fo,u_tn),'O');
        e_tn:=Min(u_fo,u_tn);
      end;
      inc(n_fo);
    end;
    //Gestione delle fasce nel turno notturno
    if NotteSuEntrata and (u_tn > 1440) then
    begin
      e_tn_app:=e_tn;
      u_tn_app:=u_tn;
      n_fo_app:=n_fo;
      if n_fo_app = 1 then
        e_tn:=ttimbraturenom[i].tminutin_e + ttimbraturenom[i].Flex - ttimbraturenom[i].FlexPM;
      n_fo:=1;
      while ValStrT021['ENTRATA',TF_OBBLIGATORIA,n_fo] <> '' do
      begin
        e_fo:=ValNumT021['ENTRATA',TF_OBBLIGATORIA,n_fo] + 1440;
        u_fo:=ValNumT021['USCITA',TF_OBBLIGATORIA,n_fo] + 1440;
        //Se l'inizio della fascia è in flessibilità, lo si sposta sul nuovo punto nominale
        if (e_fo >= ttimbraturenom[i].tminutin_e) and (e_fo <= e_tn) then
          e_fo:=e_tn;
        if (e_fo >= e_tn) and (e_fo <= u_tn) then
        begin
          VerificaFascia(e_tn,Max(e_fo,e_tn),'F');
          VerificaFascia(e_fo,Min(u_fo,u_tn),'O');
          e_tn:=Min(u_fo,u_tn);
        end;
        inc(n_fo);
      end;
    end;
    //Se ci sono state fasce diurne ma non fasce notturne, ripristino i valori della prima elaborazione
    if (n_fo_app > 1) and (n_fo = 1) then
    begin
      n_fo:=n_fo_app;
      e_tn:=e_tn_app;
      u_tn:=u_tn_app;
    end;
    //Verifico ultima fascia facoltativa, alla fine di tutte le fasce precedenti
    if (n_fo > 1) and (e_tn < u_tn) then
      VerificaFascia(e_tn,u_tn,'F');
  end;
  //Copertura fascia obbligatoria carente con minuti resi da giustificativi a numero ore e mezze giornate
  CopriFasciaObb;
  //Cumulo fasce Obbligatorie/Facoltative sui contatori
  for i:=0 to High(Fasce) do
  begin
    if Fasce[i].Inizio = Fasce[i].Fine then Continue;
    if Fasce[i].T = 'FP' then
      inc(PresenzaFacoltativa,Fasce[i].Fine - Fasce[i].Inizio);
    if Fasce[i].T = 'FC' then
      inc(CarenzaFacoltativa,Fasce[i].Fine - Fasce[i].Inizio);
    if Fasce[i].T = 'OP' then
      inc(PresenzaObbligatoria,Fasce[i].Fine - Fasce[i].Inizio);
    if Fasce[i].T = 'OC' then
    begin
      //Segnalazione anomalia per carenza in fascia obbligatoria
      inc(CarenzaObbligatoria,Fasce[i].Fine - Fasce[i].Inizio);
      z099_anom3(6,Fasce[i].Fine - Fasce[i].Inizio,Format('%s-%s',[R180MinutiOre(Fasce[i].Inizio),R180MinutiOre(Fasce[i].Fine)]));
    end;
  end;
  //La Spezia: gestione della causale di Ristoro
  for i:=1 to n_rieppres do
    with triepgiuspres[i] do
    begin
      if (ValStrT275[tcauspres,'TIPOCONTEGGIO'] <> 'A') and
         (ValStrT275[tcauspres,'TIPOCONTEGGIO'] <> 'E') then
        Continue;
      if ValStrT275[tcauspres,'ORENORMALI'] <> 'A' then
        Continue;
      if ValStrT275[tcauspres,'ESCLUSIONE_FASCIA_OBB'] = 'S' then
        Continue;
      if StrToIntDef(ValStrT275[tcauspres,'SOGLIA_FASCE_OBBLFAC'],0) = 0 then
        Continue;
      mm:=StrToIntDef(ValStrT275[tcauspres,'SOGLIA_FASCE_OBBLFAC'],0);
      tot:=0;
      for k:=1 to n_fasce do
        inc(tot,tminpres[k]);
      if tot > mm then
      begin
        app:=Min(PresenzaObbligatoria,tot);
        dec(PresenzaObbligatoria,app);
        inc(CarenzaObbligatoria,app);
        app:=Min(PresenzaFacoltativa,tot - app);
        dec(PresenzaFacoltativa,app);
        inc(CarenzaFacoltativa,app);
      end
      else
      begin
        app:=Min(PresenzaFacoltativa,tot);
        dec(PresenzaFacoltativa,app);
        inc(CarenzaFacoltativa,app);
        app:=Min(PresenzaObbligatoria,tot - app);
        dec(PresenzaObbligatoria,app);
        inc(CarenzaObbligatoria,app);
      end;
    end;
  //Fine causale di Ristoro
  if (debitogg > 0) and (TotFasciaObb > 0) then
  begin
    //ScostFacoltativa: Presenza Facoltativa fatta in più o meno rispetto al (debitogg - la fascia obbligatoria teorica)
    //Inoltre si controlla che PresenzaFacoltativa non superi il saldo del giorno (eventuali limiti straordinario, pausa mensa, ecc..)
    PresenzaFacoltativa:=Max(0,PresenzaFacoltativa - (paumendet + AbbatteCausPres));
    ScostFacoltativa:=PresenzaFacoltativa - (debitogg - TotFasciaObb);
    if (ScostFacoltativa > 0) and (ScostFacoltativa > totlav - debitogg + CarenzaObbligatoria) then
      ScostFacoltativa:=Max(0,totlav - debitogg);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z760_minattrtur;
{Calcolo minuti attribuibili derivanti da turni lavorati
 Scorrimento delle timbrature nominali per conteggio
 minuti attribuibili}
var i,j:Integer;
begin
  for i:=1 to n_timbrnom do
    begin
    comodo2:=0;
    //Scorrimento delle timbrature dipendente per cumulare i
    //minuti appoggiati alla coppia di E - U nominale in gestione
    for j:=1 to n_timbrdip do
      if ttimbraturedip[j].tpuntnomin = i then
        comodo2:=comodo2 + ttimbraturedip[j].tminutid_u - ttimbraturedip[j].tminutid_e;
    if comodo2 > 0 then
      if (ttimbraturenom[i].tminutin_u = 1440) or (comodo2 > 239) then
        //Il turno e' attribuibile quando termina a mezzanotte (per
        //gestione del cavallo) o sono state lavorate piu' di 4 ore
        minattrib:=minattrib + ttimbraturenom[i].tminutin_u - ttimbraturenom[i].tminutin_e;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z770_datifinali;
{Calcolo dei dati finali}
var i,j,arr,comodo10:Integer;
    RNFAssToll,RNFAssNonToll:Boolean;
begin
  //Giorno in servizio
  if dipinser = 'si' then
    gginser:=1;
  //Giorno lavorativo in servizio
  if gglav = 'si' then
  begin
    gglavser:=1;
    // part-time percentualizzato.ini
    if detrdebitopo = 1 then
      debitopo_percpt:=0
    else
      debitopo_percpt:=PercPartTime['DEBITO_AGG'];
    // part-time percentualizzato.fine
  end;
  //Scostamento in fascia di elasticita'
  if minassenze >= debitogg then
    scostfascia:=0;
  //Giorno di presenza
  comodo10:=0;
  for i:=1 to n_timbrcon do
    if (ttimbraturecon[i].tinclcaus <> 'A') and (ttimbraturecon[i].traggcaus = '') then
      comodo10:=comodo10 + ttimbraturecon[i].tminutic_u - ttimbraturecon[i].tminutic_e;
  if comodo10 > (debitoor / 2 ) then
    ggpres:=1;
  //Giorno di presenza pomeridiana
  for i:=1 to n_timbrcon do
    if (ttimbraturecon[i].tinclcaus <> 'A') and
       (ttimbraturecon[i].tpuntatore <> 0) and
       (ttimbraturecon[i].tminutic_e > 720) then
    begin
      ggpomer:=1;
      Break;
    end;
  //Eventuale scostamento negativo
  if scost < 0 then
    scostneg:=scost
  else
    scostneg:=0;
  //Abbattimento anno precedente, attuale e riposi compensativi
  //integrato con quanto succede su A027UCarMen
  for i:=1 to n_riepasse do
    for j:=0 to High(tcausalilette) do
      if triepgiusasse[i].tcausasse = tcausalilette[j].tcodcaus then
      begin
        if R180CarattereDef(tcausalilette[j].tparcaus.l29_4paramet) in ['A','C','G','H','I'] then
        begin
          if tcausalilette[j].tparcaus.l29_17paramet = 'AC' then
            inc(abbannoatt,triepgiusasse[i].tminvalasse)
          else if R180In(tcausalilette[j].tparcaus. l29_17paramet,['AL','LA']) then
            inc(abbliqannoatt,triepgiusasse[i].tminvalasse)
          else if tcausalilette[j].tparcaus. l29_17paramet = 'PC' then
            inc(abbannoprec,triepgiusasse[i].tminvalasse)
          else if R180In(tcausalilette[j].tparcaus. l29_17paramet,['PL','LP']) then
            inc(abbliqannoprec,triepgiusasse[i].tminvalasse)
          else if tcausalilette[j].tparcaus. l29_17paramet = 'BO' then
          begin
            //Alberto 06/0472006: aggiunta la gestione dell'arrotondamento,
            //per correggere la quantità quando non è stato possibile arrotondarla nella routine z043_arrotgiustore;
            arr:=StrToIntDef(ValStrT265[triepgiusasse[i].tcausasse,'FRUIZ_ARR'],0);
            if (triepgiusasse[i].ttipofruiz <> 'I') and (triepgiusasse[i].ttipofruiz <> 'M') and (ValStrT265[triepgiusasse[i].tcausasse,'FRUIZCOMPETENZE_ARR'] = 'S') and (arr > 1) then
              inc(abbBancaOre,Trunc(R180Arrotonda(triepgiusasse[i].tminvalasse,arr,'E')))
            else
              inc(abbBancaOre,triepgiusasse[i].tminvalasse);
          end;
        end;
        //Abbattimento riposi compensativi
        if tcausalilette[j].tparcaus.l29_Ragg = traggrcausas[5].C then
        begin
          if (cdsT020.FieldByName('Matura_Ripcom').AsString = 'S') or
             (cdsT020.FieldByName('Matura_Ripcom').AsString = 'R') or
             (ValStrT025['CAUSRIPCOM_FASCE',''] <> '') then
            inc(abbripcom,triepgiusasse[i].tminresasse)
            //inc(abbripcom,triepgiusasse[i].tminvalasse);
          else
            with selT025 do
            begin
              //Filter:='(DATADECORRENZA <= ''' + DateToStr(DataCon) + ''') and (DATAFINE >= ''' + DateToStr(DataCon) + ''')';
              Filter:='(DATADECORRENZA <= ' + FloatToStr(DataCon) + ') and (DATAFINE >= ' + FloatToStr(DataCon) + ')';
              Filtered:=True;
              if (RecordCount > 0) and (FieldByName('RIPOSO_RECUPLIQUID').AsString = 'R') then
                inc(abbripcom,triepgiusasse[i].tminresasse);
            end;
        end;
        Break;
      end;
  if (paumendet = 0) and paumenTimbNonGes then
  begin
    paumenges:='no';
    TipoDetPaumen:='';
  end;
  if matura_ripcom and XParam[XP_TC_RIPOCOM_GIUSTIF] then
    z1011_MaturaRiposoCompensativo;
  //Alberto 23/02/2015: TORINO_COMUNE - forzatura del turno pianificato anche se non eseguito, per consentire successivo calcolo dell'indennità oraria
  if (pianif = 'si') and (c_turni1 > 0) and (n_turno1 = 0) and (cdsT020.FieldByName('FORZA_TURNOPIANIFICATO').AsString = 'S') then
    n_turno1:=ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,c_turni1];
  //Alberto 07/10/2009: TORINO_HMOLINETTE - gestione Riposi non goduti (festivi infrasettimanali dal lu al ve)
  if (tipogg = 'F') and (giorsett <= 5) and (ValStrT025['RNF_FILTRO',''] <> '') then
  begin
    //Verifico tutti i giustificativi presenti: se ce n'è uno tollerato, la festività si matura, se ce n'è uno NON tollerato la festività non si matura
    RNFAssToll:=False;
    RNFAssNonToll:=False;
    if High(TimbratureDelGiorno) >= 0 then
      FestivoNonGoduto:=1;
    for i:=1 to n_giusgga do
      if Pos(',' + tgius_ggass[i].tcausggass + ',',',' + ValStrT025['RNF_ASSENZE_TOLLERATE',''] + ',') > 0 then
        RNFAssToll:=True
      else
        RNFAssNonToll:=True;
    for i:=1 to n_giusmga do
      if Pos(',' + tgius_mgass[i].tcausmgass + ',',',' + ValStrT025['RNF_ASSENZE_TOLLERATE',''] + ',') > 0 then
        RNFAssToll:=True
      else
        RNFAssNonToll:=True;
    for i:=1 to n_giusore do
      if Pos(',' + tgius_min[i].tcausore + ',',',' + ValStrT025['RNF_ASSENZE_TOLLERATE',''] + ',') > 0 then
        RNFAssToll:=True
      else
        RNFAssNonToll:=True;
    for i:=1 to n_giusdaa do
      if Pos(',' + tgius_dallealle[i].tcausdaa + ',',',' + ValStrT025['RNF_ASSENZE_TOLLERATE',''] + ',') > 0 then
        RNFAssToll:=True
      else
        RNFAssNonToll:=True;
    if RNFAssNonToll then
      FestivoNonGoduto:=0
    else if RNFAssToll then
      FestivoNonGoduto:=1;
    //Verifico che il dipendente appartenga al filtro indicato  
    if FestivoNonGoduto = 1 then
    begin
      selV430RNF.SetVariable('PROGRESSIVO',progrcon);
      selV430RNF.SetVariable('DATA',datacon);
      selV430RNF.SetVariable('FILTRO',ValStrT025['RNF_FILTRO','']);
      selV430RNF.Execute;
      if selV430RNF.FieldAsInteger(0) = 0 then
        FestivoNonGoduto:=0;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z772_tipistraor;
{Calcolo tipi di straordinario potenzialmente liquidabile}
var GestCambioOra:Boolean;
    i,j,MaxStrEsterno,TotStr,xx,app:Integer;
begin
  //tminstrgio3
  //Minuti causalizzati come straordinario indipendentemente
  //dallo scostamento giornaliero
  for i:=1 to n_timbrcon do
    if (ttimbraturecon[i].tpuntatore = 0) and
       (ttimbraturecon[i].tinclcaus <> 'A') and
       (ttimbraturecon[i].tinclcaus <> 'C') then
    begin
      //Se attivo il flag Solo Compensabile, si considerano solo le timbrature causalizzate col flag Liquidabile
      if (cdsT020.FieldByName('TuttoComp').AsString = 'S') and
         (ValStrT275[ttimbraturecon[i].tcaus,'LIQUIDABILE'] <> 'B') then
        Continue;
      GestCambioOra:=not ttimbraturecon[i].oralegsol;
      for j:=1 to n_fasce do
      //Calcolo intersezione tra timbrature e fascia con gestione cambio Ora Legale/Solare
      begin
        z776_intersfasc(i,j);
        inc(tminstrgio3[j],mininterfasc);
        if (not GestCambioOra) and
           (tfasceorarie[j].tiniz1fasc <= OraLegaleSolare.OraVecchia) and
           (tfasceorarie[j].tfine1fasc >= OraLegaleSolare.OraNuova) then
        begin
          GestCambioOra:=True;
          if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= tminstrgio3[j])) then
            inc(tminstrgio3[j],OraLegaleSolare.Diff)
          else
            tminstrgio3[j]:=0;
        end;
      end;
    end;
  //Alberto 08/10/1999: limitazione dello straordinario conteggiato all'interno di MinGioStr e MaxGioStr
  TotStr:=0;
  for i:=1 to n_fasce do
    inc(TotStr,tminstrgio3[i]);
  if TotStr < ValNumT020['MinGioStr'] then
    for xx:=Low(tminstrgio3) to High(tminstrgio3) do tminstrgio3[xx]:=0;
  if totlav < ValNumT020['MaxGioStr'] then
    MaxStrEsterno:=totlav
  else
    MaxStrEsterno:=ValNumT020['MaxGioStr'];
  if TotStr > MaxStrEsterno then
    begin
    TotStr:=TotStr - MaxStrEsterno;
    for i:=1 to n_fasce do
      begin
      if TotStr = 0 then Break;
      if tminstrgio3[i] >= TotStr then
        begin
        dec(tminstrgio3[i],TotStr);
        TotStr:=0;
        end
      else
        begin
        dec(TotStr,tminstrgio3[i]);
        tminstrgio3[i]:=0;
        end;
      end;
    end;
  //Applicazione degli arrotondamenti dello straordinario a tminstrgio3
  for i:=1 to n_fasce do
  begin
    app:=min(tminstrgio3[i],strarrdet);
    dec(tminstrgio3[i],app);
    dec(strarrdet,app);
  end;
  scostliq:=scost - eccsolocomp;
  if scostliq <= 0 then exit;
  //tminstrgio4
  //come tminstrgio3 ma limitato all'eccedenza liquidabile
  for i:=1 to n_fasce do
    tminstrgio4[i]:=tminstrgio3[i];
  for i:=n_fasce downto 1 do
    if tminstrgio4[i] > scostliq then
    begin
      tminstrgio4[i]:=scostliq;
      scostliq:=0;
    end
    else
      dec(scostliq,tminstrgio4[i]);
  //tminstrgio1
  //Eccedenza giornaliera liquidabile distribuita considerando
  //prioritariamente le causali incluse nelle ore normali a
  //prescindere dai minuti minimi ed in alternativa usando
  //tutte le ore lavorate
  //Alberto 25/01/2008: riposi compensativi per AOSTA_ASL
  scostliq:=scost - eccsolocomp;
  if minlavincfor = 0 then
    for i:=n_fasce downto 1 do
      begin
      if scostliq = 0 then Break;
      if tminlav[i] > 0 then
        if tminlav[i] > scostliq then
          begin
          tminstrgio1[i]:=scostliq;
          scostliq:=0;
          end
        else
          begin
          tminstrgio1[i]:=tminlav[i];
          dec(scostliq,tminlav[i]);
          end;
      end
  else
    begin
    for i:=n_timbrcon downto 1 do
      begin
      if scostliq = 0 then Break;
      GestCambioOra:=not ttimbraturecon[i].oralegsol;
      if (ttimbraturecon[i].tpuntatore = 0) and (ttimbraturecon[i].tinclcaus = 'D') then
        for j:=n_fasce downto 1 do
          begin
          if scostliq = 0 then Break;
          //4.0 if tfasceorarie[j].ttipofasc = ttimbraturecon[i].ttipofascia then
            //Calcolo intersezione tra timbrature e fascia
            begin
            z776_intersfasc(i,j);
            if mininterfasc > scostliq then
              begin
              inc(tminstrgio1[j],scostliq);
              scostliq:=0;
              end
            else
              begin
              inc(tminstrgio1[j],mininterfasc);
              dec(scostliq,mininterfasc);
              end;
            if (not GestCambioOra) and
               (tfasceorarie[j].tiniz1fasc <= OraLegaleSolare.OraVecchia) and
               (tfasceorarie[j].tfine1fasc >= OraLegaleSolare.OraNuova) then
              begin
              GestCambioOra:=True;
              if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= tminstrgio1[j])) then
                inc(tminstrgio1[j],OraLegaleSolare.Diff)
              else
                tminstrgio1[j]:=0;
              end;
            end;
          end;
      end;
    inc(tminstrgio1[fasciabass],scostliq);
    end;
  scostliq:=scost - eccsolocomp;
  //tminstrgio2
  //Eccedenza giornaliera liquidabile distribuita usando
  //innanzitutto solo le ore lavorate fuori da quelle nominali
  //e le rimanenti solo per eventuali residui avendo escluso
  //quelle utilizzate per rendere il debito giornaliero
  for i:=n_timbrcon downto 1 do
    begin
    if scostliq = 0 then Break;
    GestCambioOra:=not ttimbraturecon[i].oralegsol;
    if (ttimbraturecon[i].tpuntatore = 0) and
       (ttimbraturecon[i].tinclcaus <> 'A') and
       (ttimbraturecon[i].tinclcaus <> 'C') and
       (XParam[XP_RAVDA_STRAOINFASCE] or
        (cdsT020.FieldByName('CAUSALE_FASCE').AsString = '') or       //no ore maggiorate in fasce
        (ValStrT275[ttimbraturecon[i].tcaus,'GIUST_DAA_TIMB'] <> 'S'))//no timbrature fittizie
    then
      for j:=n_fasce downto 1 do
        begin
        if scostliq = 0 then Break;
        //4.0 if tfasceorarie[j].ttipofasc = ttimbraturecon[i].ttipofascia then
          //Calcolo intersezione tra timbrature e fascia
          begin
          z776_intersfasc(i,j);
          if tfasceorarie[j].AbbFascia > 0 then
          begin
            app:=min(tfasceorarie[j].AbbFascia,mininterfasc);
            dec(mininterfasc,app);
            dec(tfasceorarie[j].AbbFascia,app);
          end;
          if mininterfasc > scostliq then
            begin
            inc(tminstrgio2[j],scostliq);
            scostliq:=0;
            end
          else
            begin
            inc(tminstrgio2[j],mininterfasc);
            dec(scostliq,mininterfasc);
            end;
          if (not GestCambioOra) and
             (tfasceorarie[j].tiniz1fasc <= OraLegaleSolare.OraVecchia) and
             (tfasceorarie[j].tfine1fasc >= OraLegaleSolare.OraNuova) then
            begin
            GestCambioOra:=True;
            if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= tminstrgio2[j])) then
              inc(tminstrgio2[j],OraLegaleSolare.Diff)
            else
              tminstrgio2[j]:=0;
            end;
          end;
        end;
    end;
  comodo6:=0;
  //Eventuali residui escludendo le ore utilizzate per rendere
  //il debito giornaliero
  z774_strdopodeb;
  inc(tminstrgio2[1],scostliq);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z773_getstraor;
var
  app,i,j,xx,totliq:Integer;
  tminstrgio_app,tminstrgiocaupres:t_FasceInteri;
begin
  for xx:=Low(tminstrgio) to High(tminstrgio) do tminstrgio[xx]:=0;
  for xx:=Low(tminstrgiocaupres) to High(tminstrgiocaupres) do tminstrgiocaupres[xx]:=0;
  (*Definizione dell'eccedenza solo compensabile giornaliera come
  differenza tra scostamento positivo e straordinario*)
  if scost > 0 then
    EccSoloCompGG:=scost
  else
    EccSoloCompGG:=0;
  totliq:=0;
  for i:=1 to n_fasce do
  begin
    if (cdsT020.FieldbyName('CompFascia').AsString = '1') or (cdsT020.FieldbyName('CompFascia').AsString = 'A') then
      tminstrgio[i]:=tminstrgio1[i]
    else if cdsT020.FieldbyName('CompFascia').AsString = '2' then
      tminstrgio[i]:=tminstrgio2[i]
    else if (cdsT020.FieldbyName('CompFascia').AsString = '3') or (cdsT020.FieldbyName('CompFascia').AsString = 'B') then
      tminstrgio[i]:=tminstrgio3[i]
    else if cdsT020.FieldbyName('CompFascia').AsString = '4' then
      tminstrgio[i]:=tminstrgio4[i];
    //TORINO_REGIONE: (22/07/2004) arrotonadamento eccedenza giornaliera su ogni fascia
    arr890:=ValNumT020['ARR_ECCED_FASCE'];
    comodo2:=tminstrgio[i];
    per892:=tminstrgio[i];
    z892_arrotondap;
    detrazioni:=comodo2 - per892;
    dec(tminstrgio[i],detrazioni);
    if (detrazioni > 0) and (cdsT020.FieldByName('ARR_ECC_FASCE_COMP').AsString <> 'S') then
    begin
      app:=detrazioni;
      dec(EccSoloCompGG,detrazioni);
      comodo2:=min(tminlav[i],detrazioni);
      //Abbatto i minuti dalle ore lavorate nella fascia corrispondente a quella di straordinario
      dec(tminlav[i],comodo2);
      dec(detrazioni,comodo2);
      if detrazioni > 0 then
        z140_detrazioni(tminlav); //Eventuale abbattimento ulteriore sulle fasce basse se rimane residuo non abbattuto
      inc(FDetrazTotLav,app - detrazioni);  //Alberto 24/01/2011: TORINO_COMUNE - serve per calcolo indennità turno
    end;
    //FINE
    dec(EccSoloCompGG,tminstrgio[i]);
    indnot_lorda.EccGio[i]:=tminstrgio[i];
    indfes_lorda.EccGio[i]:=tminstrgio[i];
    inc(totliq,tminstrgio[i]);
  end;
  if cdsT020.FieldbyName('StrRipFasce').AsString = 'N' then
  begin
    for i:=1 to n_rieppres do
    begin
      if ValStrT275[triepgiuspres[i].tcauspres,'RIPFASCE'] = 'B' then
        for j:=1 to n_fasce do
          inc(tminstrgiocaupres[j],triepgiuspres[i].tminpres[j])
    end;
    for j:=n_fasce downto 1 do
      if j <> fasciabass then
      begin
        inc(tminstrgio[fasciabass],(tminstrgio[j] - Min(tminstrgio[j],tminstrgiocaupres[j])));
        tminstrgio[j]:=Min(tminstrgio[j],tminstrgiocaupres[j]);
      end;
  end;
  //Arrotondamento eccedenza liquidabile
  arr890:=ValNumT020['ARR_ECCED_LIQ'];
  comodo2:=totliq;
  per892:=totliq;
  z892_arrotondap;
  detrazioni:=comodo2 - per892;
  tminstrgio_app:=tminstrgio;
  z140_detrazioni(tminstrgio);
  //Alberto 04/07/2008: Il flag se includere o meno l'arrotondamento nel compensabile viene utilizzato anche per l'arrotondamento del liquidabile
  if cdsT020.FieldByName('ARR_ECC_FASCE_COMP').AsString <> 'S' then
    for i:=1 to n_fasce do
    begin
      detrazioni:=tminstrgio_app[i] - tminstrgio[i];
      if detrazioni > 0 then
      begin
        app:=min(tminlav[i],detrazioni);
        dec(EccSoloCompGG,detrazioni);
        dec(tminlav[i],app);
        dec(detrazioni,app);
        if detrazioni > 0 then
          z140_detrazioni(tminlav);
        inc(FDetrazTotLav,tminstrgio_app[i] - tminstrgio[i] - detrazioni);  //Alberto 24/01/2011: TORINO_COMUNE - serve per calcolo indennità turno
      end;
    end;
  if EccSoloCompGG < 0 then
    EccSoloCompGG:=0;
  //Calcolo del compensabile dovuto a cuasali di assenza/presenza che può oltrepassare la soglia stabilita da MinScoStr
  EccSoloCompOltreSoglia:=0;
  if cdsT020.FieldbyName('Ecc_Comp_Causalizzata').AsString = 'E' then
  begin
    //Genova S.Martino
    if EccSoloCompGG > ValNumT020['MinScoStr'] then
      EccSoloCompOltreSoglia:=EccSoloCompGG;
  end
  else if cdsT020.FieldbyName('Ecc_Comp_Causalizzata').AsString = 'C' then
  begin
    //Carrara
    for i:=1 to n_rieppres do
      if (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'C') and
         (R180SommaArray(triepgiuspres[i].tminpres) >= ValNumT020['MinScoStr']) then
         inc(EccSoloCompOltreSoglia,R180SommaArray(triepgiuspres[i].tminpres));
    for i:=1 to n_riepasse do
    begin
      z964_LeggiCaus(triepgiusasse[i].tcausasse);
      if (s_trovato = 'si') and (parcaus.l29_4paramet = 'H') and
         (triepgiusasse[i].tminvalasse >= ValNumT020['MinScoStr']) then
        inc(EccSoloCompOltreSoglia,triepgiusasse[i].tminvalasse);
    end;
    EccSoloCompOltreSoglia:=Min(EccSoloCompGG,EccSoloCompOltreSoglia);
  end;
  //Monza
  { // daniloc. - spostato nella function in lettura della property ProlungamentoNonCausUscita
  ProlungamentoNonCausUscita:=Max(0,ProlungamentoNonCausUscita + ScostNeg);
  if ProlungamentoNonCausUscita < ValNumT020['MinScoStr'] then
    ProlungamentoNonCausUscita:=0
  else if ValNumT020['ArrScoStr'] > 1 then
    ProlungamentoNonCausUscita:=Trunc(R180Arrotonda(ProlungamentoNonCausUscita,ValNumT020['ArrScoStr'],'D'));
  }
end;
//_________________________________________________________________
procedure TR502ProDtM1.z774_strdopodeb;
{Eventuali residui escludendo le ore utilizzate per rendere il debito giornaliero}
var GestCambioOra:Boolean;
    i,j,xx:Integer;
begin
  //Nel caso di svolgimento di 2 turni conidero nello straordinario prima il secondo e poi il primo
  for xx:=1 to 2 do
  begin
    //if (xx = 2) and ((l08_turno1 < 1) or (l08_turno2 < 1)) then
    if (xx = 2) and ((r_turno1 < 1) or (r_turno2 < 1)) then
      Break;
    for i:=1 to n_timbrcon do
    begin
      if scostliq = 0 then Break;
      if (ttimbraturecon[i].tinclcaus = 'A') or (ttimbraturecon[i].tpuntatore = 0) then Continue;
      //primo giro: escludo le timbrature riferite al secondo turno (che considero dopo per evitare che vadano a colmare il debito)
      if (xx = 1) and (r_turno1 > 0) and (r_turno2 > 0) then
        if (ttimbraturenom[ttimbraturecon[i].tpuntatore].tpuntre = r_turno2) or
           (ttimbraturenom[ttimbraturecon[i].tpuntatore].tpuntru = r_turno2) then Continue;
      //secondo giro: escludo le timbrature riferite al primo turno (che ho già considerato al primo giro)
      if (xx = 2) and (r_turno1 > 0) and (r_turno2 > 0) then
        if (ttimbraturenom[ttimbraturecon[i].tpuntatore].tpuntre = r_turno1) or
           (ttimbraturenom[ttimbraturecon[i].tpuntatore].tpuntru = r_turno1) then Continue;
      GestCambioOra:=not ttimbraturecon[i].oralegsol;
      comodo7:=0;
      if comodo6 < debitogg then
        if (debitogg - comodo6) > (ttimbraturecon[i].tminutic_u - ttimbraturecon[i].tminutic_e) then
        begin
          comodo6:=comodo6 + ttimbraturecon[i].tminutic_u - ttimbraturecon[i].tminutic_e;
          Continue;
        end
        else
        begin
          comodo7:=debitogg - comodo6;
          inc(ttimbraturecon[i].tminutic_e,comodo7);
          comodo6:=debitogg;
        end;
      for j:=n_fasce downto 1 do
      begin
        if scostliq = 0 then Break;
        //4.0 if tfasceorarie[j].ttipofasc = ttimbraturecon[i].ttipofascia then
          //Calcolo intersezione tra timbrature e fascia
        begin
          z776_intersfasc(i,j);
          if mininterfasc > scostliq then
          begin
            inc(tminstrgio2[j],scostliq);
            scostliq:=0;
          end
          else
          begin
            inc(tminstrgio2[j],mininterfasc);
            dec(scostliq,mininterfasc);
          end;
          if (not GestCambioOra) and
             (tfasceorarie[j].tiniz1fasc <= OraLegaleSolare.OraVecchia) and
             (tfasceorarie[j].tfine1fasc >= OraLegaleSolare.OraNuova) then
          begin
            GestCambioOra:=True;
            if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= tminstrgio1[j])) then
              inc(tminstrgio2[j],OraLegaleSolare.Diff)
            else
              tminstrgio2[j]:=0;
          end;
        end;
      end;
      dec(ttimbraturecon[i].tminutic_e,comodo7);
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z776_intersfasc(i,j:Integer);
{Calcolo intersezione tra timbrature e fascia}
begin
  mininterfasc:=0;
  //Test su primo range della fascia
  if (ttimbraturecon[i].tminutic_u > tfasceorarie[j].tiniz1fasc) and (ttimbraturecon[i].tminutic_e < tfasceorarie[j].tfine1fasc) then
    begin
    if ttimbraturecon[i].tminutic_e < tfasceorarie[j].tiniz1fasc then
      comodo3:=tfasceorarie[j].tiniz1fasc
    else
      comodo3:=ttimbraturecon[i].tminutic_e;
    if ttimbraturecon[i].tminutic_u > tfasceorarie[j].tfine1fasc then
      mininterfasc:=tfasceorarie[j].tfine1fasc - comodo3
    else
      mininterfasc:=ttimbraturecon[i].tminutic_u - comodo3;
    end;
  //Test su secondo eventuale range della fascia
  if (ttimbraturecon[i].tminutic_u > tfasceorarie[j].tiniz2fasc) and (ttimbraturecon[i].tminutic_e < tfasceorarie[j].tfine2fasc) then
    begin
    if ttimbraturecon[i].tminutic_e < tfasceorarie[j].tiniz2fasc then
      comodo3:=tfasceorarie[j].tiniz2fasc
    else
      comodo3:=ttimbraturecon[i].tminutic_e;
    if ttimbraturecon[i].tminutic_u > tfasceorarie[j].tfine2fasc then
      mininterfasc:=mininterfasc + tfasceorarie[j].tfine2fasc - comodo3
    else
      mininterfasc:=mininterfasc + ttimbraturecon[i].tminutic_u - comodo3;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z778_ripcomfasce;
{Aosta - riposi compensativi in fasce}
var xx,rcapp:Integer;
    caus,ragg:String;
  procedure RiepilogaRC(limite_rc:Integer; UsaLiquidabile:Boolean);
  var i,j,app,limite_fascia:Integer;
  begin
    limite_fascia:=9999;
    for i:=1 to n_fasce do
    begin
      j:=z164_ultimafascia(limite_fascia);
      limite_fascia:=max(tfasceorarie[j].tfine1fasc,tfasceorarie[j].tfine2fasc);
      if UsaLiquidabile then
        app:=min(rcapp,tminstrgio[j])
      else
        app:=max(0,min(rcapp,limite_rc) - tminstrgio[j]);
      inc(triepgiuspres[i810].tminpres[j],app);
      dec(rcapp,app);
      if UsaLiquidabile then
        dec(tminstrgio[j],app);
    end;
  end;
begin
  if (ripcom > 0) and (cdsT020.FieldByName('Matura_Ripcom').AsString = 'R') then
  begin
    rcapp:=ripcom;
    caus:=ValStrT025['CAUSRIPCOM_FASCE',''];
    if caus <> '' then
    begin
      ragg:=ValStrT275[caus,'CODRAGGR'];
      //Verifico se causale abilitata
      if not CausPresAbilitato(caus) then
      begin
        tcausale.tcaus:=caus;
        z098_anom2caus(9);
        exit;
      end;
      if ValStrT275[caus,'ORENORMALI'] <> 'A' then
      begin
        z099_anom3(8,0,'');
        exit;
      end;
      if (cdsT020.FieldbyName('CompFascia').AsString = '3') or
         (cdsT020.FieldbyName('CompFascia').AsString = 'B') or
         (cdsT020.FieldbyName('CompFascia').AsString = '4') then
      begin
        z099_anom3(7,0,'');
        exit;
      end;
      i810:=0;
      repeat
        inc(i810);
      until (i810 > n_rieppres) or (triepgiuspres[i810].tcauspres = caus);
      if i810 > n_rieppres then
      begin
        inc(n_rieppres);
        i810:=n_rieppres;
        triepgiuspres[i810].tcauspres:=caus;
        triepgiuspres[i810].traggpres:=ragg;
        triepgiuspres[i810].DetPM:=0;
        triepgiuspres[i810].minpres0024:=0;
        for xx:=1 to MaxFasceGio do triepgiuspres[i810].tminpres[xx]:=0;
      end;
      (*
      //Minuti all'interno del debito gg
      inc(triepgiuspres[i810].tminpres[fasciabass],min(rcapp,max(0,debitogg - debitorp_ripcom)));
      dec(rcapp,min(rcapp,max(0,debitogg - debitorp_ripcom)));
      //Minuti solo compensabili
      inc(triepgiuspres[i810].tminpres[fasciabass],min(eccsolocomp,rcapp));
      dec(rcapp,min(eccsolocomp,rcapp));
      //Minuti liquidabili
      for xx:=1 to n_fasce do
      begin
        app:=min(tminstrgio[xx],rcapp);
        inc(triepgiuspres[i810].tminpres[xx],app);
        dec(tminstrgio[xx],app);
        dec(rcapp,app);
      end;
      *)
      //Riepilogo rip.comp. a partire dalle ore rese a fine giornata
      //Minuti all'interno del debito gg
      RiepilogaRC(max(0,debitogg - debitorp_ripcom),False);
      //Minuti solo compensabili
      RiepilogaRC(eccsolocomp,False);
      //Minuti liquidabili
      RiepilogaRC(0,True);
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z780_OreCausDetPausaMensa;
{Applicazione della detrazione di pausa mensa al riepilogo di presenza}
var Det:Integer;
    IM,FM:Integer;
  procedure DetraiPM(StaccoMensaAdiacente,OreNormali:Boolean);
  var i,j,OreCaus,Inizio,Fine,Intervallo:Integer;
      CausOreNormali:Boolean;
  begin
    if StaccoMensaAdiacente and (length(TimbratureMensa) = 0) then
      exit;

    if not OreNormali and (TipoDetPaumen = 'PMA') then
    begin
      IM:=ValNumT021['ENTRATAMM',TF_PM_AUTO,1];
      FM:=ValNumT021['USCITAMM',TF_PM_AUTO,1];
    end
    else
    begin
      IM:=InizioMensa;
      FM:=FineMensa;
    end;

    i:=1;
    while i <= n_rieppres do
    begin
      CausOreNormali:=ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A';
      if (((ValStrT275[triepgiuspres[i].tcauspres,'MATURAMENSA'] = 'S') and
           (ValStrT275[triepgiuspres[i].tcauspres,'TIMB_PM_DETRAZ'] = 'S'))
          (*or
          (CausOreNormali and (triepgiuspres[i].tcauspres = ''))*))
         and
         (OreNormali = CausOreNormali)
      then
      begin
        OreCaus:=R180SommaArray(triepgiuspres[i].tminpres);
        for j:=0 to High(triepgiuspres[i].CoppiaEU) do
        begin
          if StaccoMensaAdiacente and (length(TimbratureMensa) > 0) and
             (TimbratureMensa[0].I <> triepgiuspres[i].CoppiaEU[j].U) and
             (TimbratureMensa[0].F <> triepgiuspres[i].CoppiaEU[j].E) then
          begin
            Continue;
          end;
          Inizio:=max(triepgiuspres[i].CoppiaEU[j].E,IM);
          Fine:=min(triepgiuspres[i].CoppiaEU[j].U,FM);
          Intervallo:=max(0,Fine - Inizio);
          Intervallo:=min(Intervallo,OreCaus);
          Intervallo:=min(Intervallo,Det);
          if Intervallo > 0 then
          begin
            inc(paumendet_rieppres,Intervallo);
            dec(Det,Intervallo);
            detrazioni:=Intervallo;
            if not OreNormali then
              dec(minlavesc,detrazioni);
            z140_detrazioni(triepgiuspres[i].tminpres);
            z098_anom2caus(53,Format('%s: %s',[triepgiuspres[i].tcauspres,R180MinutiOre(Intervallo)]));
          end;
          if Det = 0 then
            Break;
        end;
        OreCaus:=R180SommaArray(triepgiuspres[i].tminpres);
        //Eliminazione riepilogo
        if OreCaus = 0 then
        begin
          dec(n_rieppres);
          for j:=i to n_rieppres do
            triepgiuspres[j]:=triepgiuspres[j + 1];
          dec(i);
        end;
        if Det = 0 then
          Break;
      end;
      inc(i);
    end;
  end;
begin
  if paumendet = 0 then
    exit;

  //Detrazione di quanto già detratto anche sul riepilogo delle causali incluse nelle ore normali
  Det:=paumendet - paumendet_resto;
  DetraiPM(True,True); //Spezzoni adiacenti
  //Messina_Universita: Se PMA, verifico se ci sono ore normali nei punti nominali oltre al debito gg che possono contenere la detrazione mensa
  if (XParam[XP_Z780_DETRAZ_CAUS_PMA]) and
     (TipoOrario = 'A') and (PeriodoLavorativo = 'C') and
     (ttimbraturenom[1].tminutin_u - ttimbraturenom[1].tminutin_e - ttimbraturenom[1].Flex > debitogg) then
  begin
    dec(Det,ttimbraturenom[1].tminutin_u - ttimbraturenom[1].tminutin_e - ttimbraturenom[1].Flex - debitogg);
    Det:=max(0,Det);
  end;
  DetraiPM(False,True); //Tutti gli spezzoni

  //Detrazione da causali escluse dalle ore normali
  Det:=paumendet_resto + paumendet_oreesc;
  DetraiPM(True,False); //Spezzoni adiacenti
  DetraiPM(False,False);//Tutti gli spezzoni

  //detraggo l'eventuale rimanenza dalle ore normali
  if (Det > 0) and (paumendet_oreesc > 0) then
  begin
    detrazioni:=Det;
    z140_detrazioni(tminlav);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z782_OreCausalizzateLimitate;
{Applicazione della detrazione per quelle causali che devono essere limitate al debito giornaliero}
var i,j,OreCaus,Det:Integer;
begin
  z752_lavscostgg;
  if scost <= 0 then exit;
  i:=1;
  while i <= n_rieppres do
  begin
    if (ValStrT275[triepgiuspres[i].tcauspres,'LIMITE_DEBITOGG'] = 'S') and
       (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A') then
    begin
      z752_lavscostgg;
      OreCaus:=0;
      for j:=1 to n_fasce do
        inc(OreCaus,triepgiuspres[i].tminpres[j]);
      Det:=min(Scost,OreCaus);
      z098_anom2caus(44,Format('%s: %s',[triepgiuspres[i].tcauspres,R180MinutiOre(Det)]));
      detrazioni:=Det;
      z140_detrazioni(tminlav);
      detrazioni:=Det;
      z140_detrazioni(triepgiuspres[i].tminpres);
      if Det = OreCaus then
      //Eliminazione riepilogo
      begin
        dec(n_rieppres);
        for j:=i to n_rieppres do
          triepgiuspres[j]:=triepgiuspres[j + 1];
        dec(i);
      end;
    end;
    inc(i);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z784_OreCausalizzateInterneLimitate;
var OreCaus,Diff,Det,TotLavInterno,i,j,x:Integer;
   ConsideraAssenze:Boolean;
begin
  //Calcolo tutte le ore rese incluse nelle normali
  TotLavInterno:=0;
  ConsideraAssenze:=True;
  for i:=1 to n_fasce do
    inc(TotLavInterno,tminlav[i]);
  //Escludo le ore non appoggiate incluse nelle normali
  //Ci possono essere problemi con giustificativi di presenza inseriti dalle..alle
  for i:=1 to n_timbrdip do
    if (ttimbraturedip[i].tpuntnomin = 0) and
       (ttimbraturedip[i].tcausale_e.tcaustip = 'B') and
       (ttimbraturedip[i].tcausale_e.tcausioe <> 'A') then
      dec(TotLavInterno,ttimbraturedip[i].tminutid_u - ttimbraturedip[i].tminutid_e);
  //Alberto 08/08/2012: escludo le ore rese da assenza
  for i:=1 to n_rieppres do
    if (ValStrT275[triepgiuspres[i].tcauspres,'LIMITE_DEBITOGG'] = 'N') and
       (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A') and
       (ValStrT275[triepgiuspres[i].tcauspres,'NO_ECCEDENZA_IN_FASCIA'] <> 'N') and
       (ValStrT275[triepgiuspres[i].tcauspres,'NO_ECCED_IN_FASCIA_CONS_ASS'] = 'N') then
      ConsideraAssenze:=False;
  if not ConsideraAssenze then
    for i:=1 to n_riepasse do
      dec(TotLavInterno,triepgiusasse[i].tminresasse);
  if (TotLavInterno <= debitogg) or (n_rieppres = 0) then exit;
  //Abbattimento ore causalizzate utilizzate nell'orario di servizio
  Diff:=TotLavInterno - debitogg;
  for i:=1 to n_rieppres do
  begin
    if (ValStrT275[triepgiuspres[i].tcauspres,'LIMITE_DEBITOGG'] = 'N') and
       (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A') and
       (ValStrT275[triepgiuspres[i].tcauspres,'NO_ECCEDENZA_IN_FASCIA'] <> 'N') then
    begin
      OreCaus:=0;
      for j:=1 to n_fasce do
        inc(OreCaus,triepgiuspres[i].tminpres[j]);
      (*Caso in cui si abbattono le ore causalizzate fruite sia come
      E ritardata, sia come U anticipata, sia come U/E nell'orario*)
      if (ValStrT275[triepgiuspres[i].tcauspres,'TIPOCONTEGGIO'] = 'A') and
         (ValStrT275[triepgiuspres[i].tcauspres,'NO_ECCEDENZA_IN_FASCIA'] = 'C') then
      begin
        Det:=min(OreCaus,Diff);
        dec(Diff,Det);
        z098_anom2caus(44,Format('%s: %s',[triepgiuspres[i].tcauspres,R180MinutiOre(Det)]));
        detrazioni:=Det;
        z140_detrazioni(tminlav);
        detrazioni:=Det;
        z140_detrazioni(triepgiuspres[i].tminpres);
        inc(AbbatteCausPres,Det);
      end
      (*Caso in cui si abbattono le ore causalizzate fruite solo come E ritardata o U anticipata*)
      else if ((ValStrT275[triepgiuspres[i].tcauspres,'TIPOCONTEGGIO'] = 'A') or
               (ValStrT275[triepgiuspres[i].tcauspres,'TIPOCONTEGGIO'] = 'E'))
              and
              (ValStrT275[triepgiuspres[i].tcauspres,'NO_ECCEDENZA_IN_FASCIA'] = 'P') then
      begin
        //Ricerco le timbrature che coincidono con una Entrata nominale o con un'Uscita nominale
        for j:=0 to High(triepgiuspres[i].CoppiaEU) do
        begin
          Det:=0;
          for x:=1 to n_timbrnom do
            if (triepgiuspres[i].CoppiaEU[j].e <= ttimbraturenom[x].tminutin_e) and
               (triepgiuspres[i].CoppiaEU[j].u >= ttimbraturenom[x].tminutin_e) and
               (triepgiuspres[i].CoppiaEU[j].u <= ttimbraturenom[x].tminutin_u) then
            begin
              Det:=min(Diff,triepgiuspres[i].CoppiaEU[j].u - triepgiuspres[i].CoppiaEU[j].e);
              Break;
            end
            else if (triepgiuspres[i].CoppiaEU[j].u >= ttimbraturenom[x].tminutin_u) and
               (triepgiuspres[i].CoppiaEU[j].e >= ttimbraturenom[x].tminutin_e) and
               (triepgiuspres[i].CoppiaEU[j].e <= ttimbraturenom[x].tminutin_u) then
            begin
              Det:=min(Diff,triepgiuspres[i].CoppiaEU[j].u - triepgiuspres[i].CoppiaEU[j].e);
              Break;
            end;
          //Applicazione dell'abbattimento
          if Det > 0 then
          begin
            dec(Diff,Det);
            z098_anom2caus(44,Format('%s: %s',[triepgiuspres[i].tcauspres,R180MinutiOre(Det)]));
            detrazioni:=Det;
            z140_detrazioni(tminlav);
            detrazioni:=Det;
            z140_detrazioni(triepgiuspres[i].tminpres);
            inc(AbbatteCausPres,Det);
          end;
        end;
      end;
    end;
  end;
  //Eliminazione dei riepiloghi di presenza vuoti
  i:=1;
  while i <= n_rieppres do
  begin
    OreCaus:=0;
    for j:=1 to n_fasce do
      inc(OreCaus,triepgiuspres[i].tminpres[j]);
    if OreCaus > 0 then
      inc(i)
    else
    begin
      for j:=i to n_rieppres - 1 do
        triepgiuspres[j]:=triepgiuspres[j + 1];
      dec(n_rieppres);
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z785_OreCausalizzateInferioriMinimo;
{Abbuono del minimo reso con causale esclusa dalle ore normali (in origine per TORINO_HCOTTOLENGO ma poi cambiata la regola)}
var i,j,PrimaFascia,Diff:Integer;
begin
  if Parametri.RagioneSociale.ToUpper = TORINO_HCOTTOLENGO then
    exit;

  for i:=1 to n_rieppres do
  begin
    Diff:=StrToIntDef(ValStrT275[triepgiuspres[i].tcauspres,'MINMINUTI'],0) - R180SommaArray(triepgiuspres[i].tminpres);
    if (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A') and
       (ValStrT275[triepgiuspres[i].tcauspres,'TIPO_MINMINIMI'] = 'A') and
       (R180SommaArray(triepgiuspres[i].tminpres) > 0) and
       (Diff > 0) then
    begin
      PrimaFascia:=-1;
      for j:=1 to High(triepgiuspres[i].tminpres) do
      begin
        if triepgiuspres[i].tminpres[j] > 0 then
        begin
          PrimaFascia:=j;
          Break;
        end;
      end;
      if PrimaFascia >= 0 then
      begin
        inc(triepgiuspres[i].tminpres[PrimaFascia],Diff);
        inc(minlavesc,Diff);
        z098_anom2caus(65,Format('%s min:%d',[triepgiuspres[i].tcauspres,Diff]));
      end;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z790_OrdinaRiepiloghi;
  procedure QuickSortRilevatori(iLo,iHi:Integer);
  var Lo,Hi:Integer;
      Mid:String;
      T:t_trieprilev;
  begin
    Lo:=iLo;
    Hi:=iHi;
    Mid:=trieprilev[(Lo + Hi) div 2].rilevatore;
    repeat
      while trieprilev[Lo].rilevatore < Mid do Inc(Lo);
      while trieprilev[Hi].rilevatore > Mid do Dec(Hi);
      if Lo <= Hi then
      begin
        T:=trieprilev[Lo];
        trieprilev[Lo]:=trieprilev[Hi];
        trieprilev[Hi]:=T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QuickSortRilevatori(iLo,Hi);
    if Lo < iHi then QuickSortRilevatori(Lo,iHi);
  end;
  procedure QuickSortPresenze(iLo,iHi:Integer);
  var Lo,Hi:Integer;
      Mid:String;
      T:t_triepgiuspres;
  begin
    Lo:=iLo;
    Hi:=iHi;
    Mid:=triepgiuspres[(Lo + Hi) div 2].tcauspres;
    repeat
      while triepgiuspres[Lo].tcauspres < Mid do Inc(Lo);
      while triepgiuspres[Hi].tcauspres > Mid do Dec(Hi);
      if Lo <= Hi then
      begin
        T:=triepgiuspres[Lo];
        triepgiuspres[Lo]:=triepgiuspres[Hi];
        triepgiuspres[Hi]:=T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QuickSortPresenze(iLo,Hi);
    if Lo < iHi then QuickSortPresenze(Lo,iHi);
  end;
  procedure QuickSortAssenze(iLo,iHi:Integer);
  var Lo,Hi:Integer;
      Mid:String;
      T:t_triepgiusasse;
  begin
    Lo:=iLo;
    Hi:=iHi;
    Mid:=triepgiusasse[(Lo + Hi) div 2].tcausasse;
    repeat
      while triepgiusasse[Lo].tcausasse < Mid do Inc(Lo);
      while triepgiusasse[Hi].tcausasse > Mid do Dec(Hi);
      if Lo <= Hi then
      begin
        T:=triepgiusasse[Lo];
        triepgiusasse[Lo]:=triepgiusasse[Hi];
        triepgiusasse[Hi]:=T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QuickSortAssenze(iLo,Hi);
    if Lo < iHi then QuickSortAssenze(Lo,iHi);
  end;
begin
  if Length(trieprilev) > 0 then
    QuickSortRilevatori(0,High(trieprilev));
  if n_rieppres > 1 then
    QuickSortPresenze(1,n_rieppres);
  if n_riepasse > 1 then
    QuickSortAssenze(1,n_riepasse);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z802_toglitimbr;
{Eliminazione coppia E_U dalle timbrature dipendente}
var i:Integer;
begin
  for i:=indice + 1 to n_timbrdip do
    ttimbraturedip[i - 1]:=ttimbraturedip[i];
  ttimbraturedip[n_timbrdip]:=ttimbraturedip_vuota;
  dec(n_timbrdip);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z803_toglitimbrcon;
{Eliminazione coppia E_U dalle timbrature conteggiate}
var i:Integer;
begin
  for i:=indice + 1 to n_timbrcon do
    ttimbraturecon[i - 1]:=ttimbraturecon[i];
  dec(n_timbrcon);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z810_rieppres(MaxMinuti:Integer; TagTimb:String = '');
{Riepilogo giustificativi presenza}
var Totale,Detrazione,xx:Integer;
    AppE,AppU,AppTotale,AppDet:Integer;
begin
  DetMinLavEsc:=0;
  i810:=0;
  Detrazione:=0;
  repeat
    inc(i810);
  until (i810 > n_rieppres) or (triepgiuspres[i810].tcauspres = riepcaus);
  if i810 > n_rieppres then
  begin
    inc(n_rieppres);
    i810:=n_rieppres;
    triepgiuspres[i810].tcauspres:=riepcaus;
    triepgiuspres[i810].traggpres:=riepcausrag;
    triepgiuspres[i810].DetPM:=0;
    triepgiuspres[i810].minpres0024:=0;
    for xx:=1 to MaxFasceGio do triepgiuspres[i810].tminpres[xx]:=0;
  end;
  (*Alberto: considero le ore causalizzate solo nel periodo DALLE*ALLE*)
  AppE:=riepcaus_e;
  AppU:=riepcaus_u;
  if riepcaus_u <= minutidalle then
    riepcaus_u:=riepcaus_e
  else if riepcaus_e < minutidalle then
    riepcaus_e:=minutidalle;
  //Gestione ora di fine conteggio
  if riepcaus_e >= minutialle then
    riepcaus_u:=riepcaus_e
  else if riepcaus_u > minutialle then
    riepcaus_u:=minutialle;
  //Detrazione dalle ore rese solo se la causale è inclusa nelle ore normali
  //19/03/2002: gestione della prima uscita con causale:
  //considero anche l'entrata precedente nel controllo dei Minuti Max
  Totale:=max(0,riepcaus_u - riepcaus_e);
  AppTotale:=max(0,AppU - AppE);
  if (riepcaus_numtimb = 1) and (estimbprec = 'si') and
     (verso_pre = 'E') and (caus_pre = riepcaus) and (ValStrT275[riepcaus,'LIQUIDABILE'] = 'B') then
  begin
    if not NotteSuEntrata or (timbraturaesclusa.tminutid_u = riepcaus_e) then
      Totale:=max(0,riepcaus_u + 1440 - IfThen(minuti_pre_caus = -1,minuti_pre,minuti_pre_caus));
    if not NotteSuEntrata or (timbraturaesclusa.tminutid_u = AppE) then
      AppTotale:=max(0,AppU + 1440 - AppE);
  end;

  //Salvo in minpres0024 il totale delle ore rese senza il limite di minutidalle-minutialle, per successive valutazioni
  AppDet:=0;
  if AppTotale > MaxMinuti then
  begin
    AppDet:=AppTotale - MaxMinuti;
    AppTotale:=MaxMinuti;
  end;
  inc(triepgiuspres[i810].minpres0024,AppTotale);
  if (OraLegaleSolare.Cambio) and (AppE < OraLegaleSolare.OraVecchia) and ((AppU - Appdet) >= OraLegaleSolare.OraNuova) then
    if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= triepgiuspres[i810].minpres0024)) then
      inc(triepgiuspres[i810].minpres0024,OraLegaleSolare.Diff)
    else
      triepgiuspres[i810].minpres0024:=0;
  //Salvo in minpres0024.fine

  if Totale > MaxMinuti then
  begin
    Detrazione:=max(0,riepcaus_u - riepcaus_e - MaxMinuti);
    if Totale > riepcaus_u - riepcaus_e then
      Detrazione:=max(0,min(Totale - MaxMinuti,riepcaus_u - riepcaus_e));
    if riepcausioe = 'A' then
      inc(DetMinLavEsc,Detrazione)
    else
      inc(DetPresenza,Detrazione);
    dec(riepcaus_u,Detrazione);
    z098_anom2caus(34,Format('%s: max %d minuti',[riepcaus,MaxMinuti]));
  end;
  //Gestione tipo di ripartizione
  if riepcausrip = 'A' then
    //Nessuna ripartizione
    with triepgiuspres[i810] do
    begin
      tminpres[fasciabass]:=tminpres[fasciabass] + riepcaus_u - riepcaus_e;
      if (OraLegaleSolare.Cambio) and (riepcaus_e < OraLegaleSolare.OraVecchia) and (riepcaus_u >= OraLegaleSolare.OraNuova) then
        if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= tminpres[fasciabass])) then
          inc(tminpres[fasciabass],OraLegaleSolare.Diff)
        else
          tminpres[fasciabass]:=0;
    end
  else
    //Ripartizione in fasce
    z812_suddfascep;
  if riepcaus <> '' then
    z814_CausaliInFasce(riepcaus,riepcaus_e,riepcaus_u);

  if Parametri.RagioneSociale.ToUpper = TORINO_HCOTTOLENGO then
    if riepcausOreAbbuonate > 0 then
    begin
      for xx:=1 to MaxFasceGio do
        if triepgiuspres[i810].tminpres[xx] > 0 then
        begin
          inc(triepgiuspres[i810].tminpres[xx],riepcausOreAbbuonate);
          inc(minlavesc,riepcausOreAbbuonate);
          Break;
        end;
      riepcausOreAbbuonate:=0;
    end;

  with triepgiuspres[i810] do
  begin
    //Registro la coppia causalizzata
    SetLength(CoppiaEU,Length(CoppiaEU) + 1);
    CoppiaEU[High(CoppiaEU)].Tag:=TagTimb;
    CoppiaEU[High(CoppiaEU)].e:=riepcaus_e;
    CoppiaEU[High(CoppiaEU)].u:=riepcaus_u;
  end;
  riepcaus_e:=AppE;
  riepcaus_u:=AppU;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z812_suddfascep;
{Suddivisione in fasce}
var i860,OraLSDiff,App:Integer;
begin
  OraLSDiff:=OraLegaleSolare.Diff;
  for i860:=1 to n_fasce do
    with tfasceorarie[i860] do
    begin
      //4.0 if ttipofasc <> tipofasc then exit;
      //Test su primo range della fascia
      if (riepcaus_u > tiniz1fasc) and (riepcaus_e < tfine1fasc) then
      begin
        if riepcaus_e < tiniz1fasc then
          comodo3:=tiniz1fasc
        else
          comodo3:=riepcaus_e;
        if riepcaus_u > tfine1fasc then
          comodo3:=tfine1fasc - comodo3
        else
          comodo3:=riepcaus_u - comodo3;
        inc(triepgiuspres[i810].tminpres[i860],comodo3);
        if (OraLegaleSolare.Cambio) and
           (OraLSDiff <> 0) and
           (riepcaus_e < OraLegaleSolare.OraVecchia) and (riepcaus_u >= OraLegaleSolare.OraNuova) then
        begin
          App:=OraLSDiff;
          if App < 0 then
            App:=-min(abs(OraLSDiff),triepgiuspres[i810].tminpres[i860]);
          inc(triepgiuspres[i810].tminpres[i860],App);
          dec(OraLSDiff,App);
          dec(DetMinLavEsc,App);
        end;
      end;
      //Test su secondo eventuale range della fascia
      if (riepcaus_u > tiniz2fasc) and (riepcaus_e < tfine2fasc) then
      begin
        if riepcaus_e < tiniz2fasc then
          comodo3:=tiniz2fasc
        else
          comodo3:=riepcaus_e;
        if riepcaus_u > tfine2fasc then
          comodo3:=tfine2fasc - comodo3
        else
          comodo3:=riepcaus_u - comodo3;
        inc(triepgiuspres[i810].tminpres[i860],comodo3);
        if (OraLegaleSolare.Cambio) and
           (OraLSDiff <> 0) and
           (riepcaus_e < OraLegaleSolare.OraVecchia) and (riepcaus_u >= OraLegaleSolare.OraNuova) then
        begin
          App:=OraLSDiff;
          if App < 0 then
            App:=-min(abs(OraLSDiff),triepgiuspres[i810].tminpres[i860]);
          inc(triepgiuspres[i810].tminpres[i860],App);
          dec(OraLSDiff,App);
          dec(DetMinLavEsc,App);
        end;
      end;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z814_CausaliInFasce(C:String; E,U:Integer);
var TipoGiorno,TipoGiornoSuc:String;
begin
  TipoGiorno:=z1008_TipoGiorno276(C,False);
  TipoGiornoSuc:='';
  //Non considero la coppia di timbrature spezzata dal giorno precedente
  if (primat_u = 'si') and
     (U <= ttimbraturedip[1].tminutid_u) and (E = 0) and (ttimbraturedip[1].tminutid_e = 0) and
     (estimbprec = 'si') and (verso_pre = 'E') and (caus_pre = C) then
    exit;
  //Considero la coppia di timbrature spezzata sul giorno successivo
  //Alberto 21/01/2011: gestisco anche il caso di NotteSuEntrata (Aosta_Regione)
  if (ultimt_e = 'si') and
     (((E = ttimbraturedip[n_timbrdip].tminutid_e) and (ttimbraturedip[n_timbrdip].tminutid_u = 1440) and
       (estimbsucc = 'si') and (verso_suc = 'U') and (caus_suc = C))
      or
      ((NotteSuEntrata) and (U > 1440)))
  then
  begin
    TipoGiornoSuc:=z1008_TipoGiorno276(C,True);
  end;
  //Elaborazione coppia di timbrature del giorno corrente
  if TipoGiorno <> '' then
    z815_SuddivisioneFasce(C,TipoGiorno,E,U);
  //Elaborazione coppia di timbrature del giorno successivo
  if TipoGiornoSuc <> '' then
    if U > 1440 then //Alberto 21/01/2011: gestisco anche il caso di NotteSuEntrata (Aosta_Regione)
      z815_SuddivisioneFasce(C,TipoGiornoSuc,max(E - 1440,0),U - 1440)
    else
      z815_SuddivisioneFasce(C,TipoGiornoSuc,0,minuti_suc);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z815_SuddivisioneFasce(C,TG:String; E,U:Integer);
var i:Integer;
begin
  for i:=0 to High(FasceCausali276) do
    begin
    if FasceCausali276[i].Codice = '' then Break;
    if (FasceCausali276[i].Codice = C) and (FasceCausali276[i].TipoGiorno = TG) then
      if (E >= FasceCausali276[i].Dalle1) and (E < FasceCausali276[i].Alle1) then
        begin
        if U <= FasceCausali276[i].Alle1 then
          OreCausali276[i]:=OreCausali276[i] + (U - E)
        else
          begin
          OreCausali276[i]:=OreCausali276[i] + (FasceCausali276[i].Alle1 - E);
          E:=FasceCausali276[i].Alle1;
          z815_SuddivisioneFasce(C,TG,E,U);
          end;
        Break;
        end
      else if (E >= FasceCausali276[i].Dalle2) and (E < FasceCausali276[i].Alle2) then
        begin
        if U <= FasceCausali276[i].Alle2 then
          OreCausali276[i]:=OreCausali276[i] + (U - E)
        else
          begin
          OreCausali276[i]:=OreCausali276[i] + (FasceCausali276[i].Alle2 - E);
          E:=FasceCausali276[i].Alle2;
          z815_SuddivisioneFasce(C,TG,E,U);
          end;
        Break;
        end
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z816_insetimbr;
{Inserimento coppia E_U nelle timbrature dipendente}
var i:Integer;
begin
  for i:=n_timbrdip downto indice do
    ttimbraturedip[i + 1]:=ttimbraturedip[i];
  inc(n_timbrdip);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z817_salva_timbraturedip;
var i:Integer;
begin
  if Length(ttimbraturedip_bck) > 0 then
    raise Exception.Create('Salvataggio timbrature già in uso!');
  SetLength(ttimbraturedip_bck,n_timbrdip);
  for i:=1 to n_timbrdip do
    ttimbraturedip_bck[i - 1]:=ttimbraturedip[i];
end;
//_________________________________________________________________
procedure TR502ProDtM1.z818_ripristina_timbraturedip;
var i:Integer;
begin
  n_timbrdip:=Length(ttimbraturedip_bck);
  for i:=0 to High(ttimbraturedip_bck) do
    ttimbraturedip[i + 1]:=ttimbraturedip_bck[i];
  SetLength(ttimbraturedip_bck,0);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z820_coppiecaus;
{Conteggio E - U con causale o straord. con causale facolt.}
var E,U,EOrig,x:Integer;
    locDetrazPMT:Integer;
    locRiepcausOreAbbuonate:Integer;
    tcausaleOrig:t_tcausale;
    MinutiIO,MinutiFO:Integer;
    CausaleIO,CausaleFO:t_tcausale;
begin
  if not calcolo_z100 then exit; //Alberto: FIRENZE_COMUNE
  //Alberto 5.4.6
  //Controllo minuti minimi richiesti considerando il cavallo di mezzanotte
  E:=ttimbraturedip[ieu].tminutid_e;
  U:=ttimbraturedip[ieu].tminutid_u;
  if (E = 0) and (not NotteSuEntrata) and (primat_u = 'si') and (estimbprec = 'si') and (verso_pre = 'E') then
    E:=-(1440 - minuti_pre);
  if (U = 1440) and (not NotteSuEntrata) and (ultimt_e = 'si') and (estimbsucc = 'si') and (verso_suc = 'U') then
    U:=minuti_suc + 1440;

  if Parametri.RagioneSociale.ToUpper = TORINO_HCOTTOLENGO then
  begin
    locRiepcausOreAbbuonate:=0;
    //Reperibilità
    if R180In(tcausale.tcaus,['WSTRA','WBO','WBOM','STRA','BO','BOM']) then
    begin
      //Se lo spezzone non è un prolungamento ma è una chiamata separata:
      if TimbraturaIsolata(ieu) then
      begin
        tcausaleOrig:=tcausale;
        //resa minima di 1 ora
        if tcausale.tOreInsufficenti = 'A' then
        begin
          //Abbuono i miuti tranne che sulla tranche di uscita
          if not TimbraturaCavalloMezzanotte(ieu,'E') then
          begin
            if (U - E < tcausale.tminminuti) and (U - E > 0) then
            begin
              //Abbuono i minuti mancanti
              locRiepcausOreAbbuonate:=tcausale.tminminuti - (U - E);
            end;
          end;
        end;
        //applicazione del tempo tuta sulla chiamata
        if TimbraturaCavalloMezzanotte(ieu,'U') then
          ieu:=z1018_CausalizzaInizioFineOrario(ieu,'I')
        else if TimbraturaCavalloMezzanotte(ieu,'E') then
          ieu:=z1018_CausalizzaInizioFineOrario(ieu,'F')
        else
        begin
          ieu:=z1018_CausalizzaInizioFineOrario(ieu,'I');
          tcausale:=tcausaleOrig;
          ieu:=z1018_CausalizzaInizioFineOrario(ieu,'F');
        end;
        tcausale:=tcausaleOrig;
      end;
    end;
    riepcausOreAbbuonate:=locRiepcausOreAbbuonate;
  end;
  //Fine - Parametri.RagioneSociale.ToUpper = TORINO_HCOTTOLENGO

  if (U - E < tcausale.tminminuti) and (U - E > 0) then
  begin
    if tcausale.tOreInsufficenti = 'P' then
    begin
      //Ore Perse
      ttimbraturedip[ieu].tminutid_u:=ttimbraturedip[ieu].tminutid_e;
      z098_anom2caus(39,Format('%s min:%d < %d',[tcausale.tcaus,U - E,tcausale.tminminuti]));
    end
    else if tcausale.tOreInsufficenti = 'N' then
    begin
      //Ore Normali: annullo la causale
      ttimbraturedip[ieu].tcausale_e:=tcausale_vuota;
      ttimbraturedip[ieu].tcausale_u:=tcausale_vuota;
      z098_anom2caus(38,Format('%s min:%d < %d',[tcausale.tcaus,U - E,tcausale.tminminuti]));
      SenzaCausale:=True;
      exit;
    end;
  end;
  //Causale diversa da straordinario
  if tcausale.tcausrag <> traggrcauspr[1].C then
  begin
    //Gestione minuti in piu'
    z830_mininpiu;
    //Arrotondamento E ed U fuori fascia oraria
    z822_arrEU;
    //Riepilogo e inclusione/esclusione ore normali
    z824_riepincesc;
    exit;
  end;
  //Controllo fasce di autorizzazione dello straordinario
  //se tag = 'TG=N' si tratta di giustificativo di presenza ad ore: non viene fatto il controllo
  if (ttimbraturedip[ieu].tag <> 'TG=N') and
     ((ValNumT021['ENTRATAMM',TF_STRAORDINARIO,1] <> 0) or (ValNumT021['ENTRATAMM',TF_STRAORDINARIO,2] <> 0) or
     (ValNumT021['USCITAMM',TF_STRAORDINARIO,1] <> 0) or (ValNumT021['USCITAMM',TF_STRAORDINARIO,2] <> 0)) then
  begin
    if (ttimbraturedip[ieu].tminutid_e < ValNumT021['USCITAMM',TF_STRAORDINARIO,1]) and
       (ttimbraturedip[ieu].tminutid_u > ValNumT021['ENTRATAMM',TF_STRAORDINARIO,1]) then
    //E - U interne al primo range straordinario
    begin
      if (ttimbraturedip[ieu].tminutid_e < ValNumT021['ENTRATAMM',TF_STRAORDINARIO,1]) or
         (ttimbraturedip[ieu].tminutid_u > ValNumT021['USCITAMM',TF_STRAORDINARIO,1]) then
      begin
        z098_anom2caus(13,'');
        if ttimbraturedip[ieu].tminutid_e < ValNumT021['ENTRATAMM',TF_STRAORDINARIO,1] then
          ttimbraturedip[ieu].tminutid_e:=ValNumT021['ENTRATAMM',TF_STRAORDINARIO,1];
        if ttimbraturedip[ieu].tminutid_u > ValNumT021['USCITAMM',TF_STRAORDINARIO,1] then
          ttimbraturedip[ieu].tminutid_u:=ValNumT021['USCITAMM',TF_STRAORDINARIO,1];
      end;
    end
    else if (ttimbraturedip[ieu].tminutid_e < ValNumT021['USCITAMM',TF_STRAORDINARIO,2]) and
            (ttimbraturedip[ieu].tminutid_u > ValNumT021['ENTRATAMM',TF_STRAORDINARIO,2]) then
    //E - U interne al secondo range straordinario
    begin
      if (ttimbraturedip[ieu].tminutid_e < ValNumT021['ENTRATAMM',TF_STRAORDINARIO,2]) or
         (ttimbraturedip[ieu].tminutid_u > ValNumT021['USCITAMM',TF_STRAORDINARIO,2]) then
      begin
        z098_anom2caus(13,'');
        if ttimbraturedip[ieu].tminutid_e < ValNumT021['ENTRATAMM',TF_STRAORDINARIO,2] then
          ttimbraturedip[ieu].tminutid_e:=ValNumT021['ENTRATAMM',TF_STRAORDINARIO,2];
        if ttimbraturedip[ieu].tminutid_u > ValNumT021['USCITAMM',TF_STRAORDINARIO,2] then
          ttimbraturedip[ieu].tminutid_u:=ValNumT021['USCITAMM',TF_STRAORDINARIO,2];
      end;
    end
    else if Parametri.ModuloInstallato['TORINO_CSI_PRV'] and
            (ttimbraturedip[ieu].tminutid_e = 0) and
            (estimbprec = 'si') and
            (verso_pre = 'E') and
            ((ValNumT021['USCITAMM',TF_STRAORDINARIO,1] = 1440) or (ValNumT021['USCITAMM',TF_STRAORDINARIO,2] = 1440)) then
    begin
      //non faccio nulla: non devo dare anomalia
    end
    else
    //E - U esterne ai due range straordinario
    begin
      z098_anom2caus(13,'');
      exit;
    end;
  end;
  //Controllo distanza tra E straordinario e ultima U
  i2:=ieu;
  if (ttimbraturedip[ieu].tag <> 'TG=N') and
     ((TipoOrario <> 'C') or (ValNumT020['OreMax'] > 0)) and
     (ieu > 1) and (ttimbraturedip[ieu].tpuntnomin = 0) then
  repeat
    dec(i2);
    if ttimbraturedip[i2].tpuntnomin <> 0 then
    begin
      x:=0;
      comodo2:=ttimbraturedip[ieu].tminutid_e - ttimbraturedip[i2].tminutid_u;
      //Controllo per Regione Umbria su Orario Elastico
      if (TipoOrario = 'C') and
         (cdsT020.FieldByName('STR_DOPO_HHMAX').AsString = 'S') and
         (minlavorar > ValNumT020['OreMax']) and
         (cdsT020.FieldByName('CompDetr').AsString <> 'S') then
      begin
        x:=minlavorar - ValNumT020['OreMax'];
        inc(comodo2,x);
      end;
      if comodo2 < ValNumT020['InterUsc'] then
      //Spostamento entrata
      begin
        z098_anom2caus(14,'');
        EOrig:=ttimbraturedip[ieu].tminutid_e;
        ttimbraturedip[ieu].tminutid_e:=ttimbraturedip[i2].tminutid_u + ValNumT020['InterUsc'] - x;
        if ttimbraturedip[ieu].tminutid_e > ttimbraturedip[ieu].tminutid_u then
          exit;
        IntervalloUscita.OraOriginale:=EOrig;
        IntervalloUscita.OraNuova:=ttimbraturedip[ieu].tminutid_e;
      end;
      Break;
    end;
  until i2 = 1;
  //Controllo distanza tra E straordinario e ultima U
  (*if (ieu > 1) and
     (ttimbraturedip[ieu].tpuntnomin = 0) and
     (ttimbraturedip[ieu - 1].tpuntnomin <> 0) then
  begin
    x:=0;
    i2:=ieu - 1;
    comodo2:=ttimbraturedip[ieu].tminutid_e - ttimbraturedip[i2].tminutid_u;
    //Controllo per Regione Umbria su Orario Elastico
    if (TipoOrario = 'C') and
       (T020[Q020STR_DOPO_HHMAX.Index] = 'S') and
       (minlavorar > StrToIntDef(T020[Q020OreMax.Index],0)) and
       (T020[Q020CompDetr.Index] <> 'S') then
    begin
      x:=minlavorar - StrToIntDef(T020[Q020OreMax.Index],0);
      inc(comodo2,x);
    end;
    if comodo2 < StrToIntDef(T020[Q020InterUsc.Index],0) then
    //Spostamento entrata
    begin
      inc(n_anom2);
      tanom2riscontrate[n_anom2].ta2puntdesc:=14;
      ttimbraturedip[ieu].tminutid_e:=ttimbraturedip[i2].tminutid_u + StrToIntDef(T020[Q020InterUsc.Index],0) - x;
      if ttimbraturedip[ieu].tminutid_e > ttimbraturedip[ieu].tminutid_u then
        exit;
    end;
  end;*)
  //Arrotondamento E ed U fuori fascia oraria
  z822_arrEU;
  if ttimbraturedip[ieu].tminutid_e > ttimbraturedip[ieu].tminutid_u then
    begin
    blocca:=0;
    exit;
    end;
  comodo2:=ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e;
  per892:=comodo2;
  arr890:=ValNumT020['ArrivRang'];
  //Arrotondamento periodo di straordinario
  z892_arrotondap;
  if per892 < ValNumT020['MinimiStr'] then
  //Straordinario inferiore ai minuti minimi per periodo di E/U
  begin
    z098_anom2caus(12,'[' + R180MinutiOre(per892) + ' < ' + R180MinutiOre(ValNumT020['MinimiStr']) + ']');
    if cdsT020.FieldByName('MINIMISTR_COMP').AsString = 'S' then
    begin
      comodo2:=per892;
      per892:=0;
      if (ttimbraturedip[ieu].tcausale_e.tcaus = '') or (ttimbraturedip[ieu].tcausale_e.tcausioe <> 'A') then
        inc(strminimidet,comodo2);
    end
    else
      exit;
  end;
  //Sommo eventuali detrazioni causa arrotondamento
  if (ttimbraturedip[ieu].tcausale_e.tcaus = '') or (ttimbraturedip[ieu].tcausale_e.tcausioe <> 'A') then
    strarrdet:=strarrdet + comodo2 - per892
  else if ValStrT275[tcausale.tcaus,'SPEZZ_STRAORD'] = 'S' then
    strarrdetEscl:=strarrdetEscl + comodo2 - per892;

  //Sommo periodo di straordinario al totale giornaliero
  if (ttimbraturedip[ieu].tcausale_e.tcaus = '') or (ttimbraturedip[ieu].tcausale_e.tcausioe <> 'A') or (ValStrT275[tcausale.tcaus,'SPEZZ_STRAORD'] = 'S') then
  begin
    //Verifico se esiste PMT che può abbattere lo straordinario
    if (paumendet_strgiorn > 0) and (TipoDetPaumen = 'PMT') and (Length(TimbratureMensa) > 0) and
       (tcausale.tcaus <> '') and
       (ValStrT275[tcausale.tcaus,'MATURAMENSA'] = 'S') and
       (ValStrT275[tcausale.tcaus,'TIMB_PM_DETRAZ'] = 'S')
    then
    begin
      //Verifico che le timbrature usate nello spezzone corrispondano a quelle di TimbratureMensa
      if (TimbratureMensa[0].I = ttimbraturedip[ieu].tminutid_u) or (TimbratureMensa[0].F = ttimbraturedip[ieu].tminutid_e) then
      begin
        locDetrazPMT:=min(ttimbraturedip[ieu].tminutid_u,FineMensa) - max(ttimbraturedip[ieu].tminutid_e,InizioMensa);
        locDetrazPMT:=min(locDetrazPMT,per892);
        locDetrazPMT:=min(per892,paumendet_strgiorn);
        dec(paumendet_strgiorn,locDetrazPMT);
        dec(per892,locDetrazPMT);
      end;
    end;

    if ttimbraturedip[ieu].tcausale_e.tcausioe = 'A' then
      inc(strgiornEscl,per892)
    else
      inc(strgiorn,per892);
  end;

  //Riepilogo e inclusione/esclusione ore normali straordinario
  z824_riepincesc;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z822_arrEU;
{Arrotondamento E ed U fuori fascia oraria}
begin
  if tcausale.tcausioe <> 'A' then
    z886_fuoriorarrE
  else
    begin
    i890:=ieu;
    e_u890:='E';
    arr890:=tcausale.tcausarr;
    z890_arrotonda;
    end;
  if tcausale.tcausioe <> 'A' then
    z888_fuoriorarrU
  else
    begin
    i890:=ieu;
    e_u890:='U';
    arr890:=tcausale.tcausarr;
    z890_arrotonda;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z824_riepincesc;
{Riepilogo e inclusione/esclusione ore normali
 Gestione giorno con eventuale conteggio parziale}
begin
  z826_gesggparz;
  if ttimbraturedip[ieu].tminutid_e = ttimbraturedip[ieu].tminutid_u then
    exit;
  riepcaus:=tcausale.tcaus;
  riepcaus_e:=ttimbraturedip[ieu].tminutid_e;
  riepcaus_u:=ttimbraturedip[ieu].tminutid_u;
  if riepcaus_e > riepcaus_u then
    riepcaus_e:=riepcaus_u;
  riepcausrag:=tcausale.tcausrag;
  riepcausrip:=tcausale.tcausrip;
  riepcausioe:=tcausale.tcausioe;
  riepcaus_numtimb:=ieu;
  z810_rieppres(tcausale.tmaxminuti,ttimbraturedip[ieu].Tag);
  if (tcausale.tcausioe = 'B') or (tcausale.tcausioe = 'D') then
    //Inclusione nelle ore normali
    z860_coppienorm
  else if tcausale.tcausioe = 'C' then
    //Inclusione nelle ore normali solo compensabili
    begin
    z860_coppienorm;
    eccsolocomp:=eccsolocomp + ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e;
    end
  else
    //Esclusione dalle ore normali
    begin
    z828_saltimbcon; //Alberto 03/01/2002
    minlavesc:=minlavesc + ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e - DetMinLavEsc;
    //Alberto 05/11/2009 - TORINO_COMUNE: Gestione dell'accavallamento di causali su U-E (escluse dalle normali)
    //con causali di straordinario escluse dalle normali:
    //se non si fa questo controllo, le ore vengono "escluse" 2 volte, dando poi dei problemi nel conteggio della pausa mensa
    if (cdsT020.FieldByName('INTERSEZ_AUTOGIUST').AsString = 'S') and
       (ttimbraturedip[ieu].Tag = '') and not(R180CarattereDef(tcausale.tcauscon) in ['A','E']) then
      z126_allineaMintipoAesc(ttimbraturedip[ieu].tminutid_e,ttimbraturedip[ieu].tminutid_u);
    //Calcolo detrazione tipo pausa mensa C o D o E (se necessario)
    if ttimbraturedip[ieu].Tag <> 'TG=D' then
      z146_tipomenCDE;
    //Gestione dati per calcolo indennita'
    z700_gestindenn;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z826_gesggparz;
{Gestione giorno con eventuale conteggio parziale}
begin
  //Gestione ora di inizio conteggio
  if ttimbraturedip[ieu].tminutid_u <= minutidalle then
    ttimbraturedip[ieu].tminutid_u:=ttimbraturedip[ieu].tminutid_e
  else
    if ttimbraturedip[ieu].tminutid_e < minutidalle then
      ttimbraturedip[ieu].tminutid_e:=minutidalle;
  //Gestione ora di fine conteggio
  if ttimbraturedip[ieu].tminutid_e >= minutialle then
    ttimbraturedip[ieu].tminutid_u:=ttimbraturedip[ieu].tminutid_e
  else
    if ttimbraturedip[ieu].tminutid_u > minutialle then
      ttimbraturedip[ieu].tminutid_u:=minutialle;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z828_saltimbcon;
{Salvataggio timbrature conteggiate in ore normali}
begin
  //if conteggi_sologiust and (n_timbrdip = 1) then
  if conteggi_sologiust then
    exit;
  inc(n_timbrcon);
  ttimbraturecon[n_timbrcon].oralegsol:=False;
  ttimbraturecon[n_timbrcon].tinclcaus:='';
  ttimbraturecon[n_timbrcon].tminutic_e:=0;
  ttimbraturecon[n_timbrcon].tminutic_u:=0;
  ttimbraturecon[n_timbrcon].tpuntatore:=0;
  ttimbraturecon[n_timbrcon].traggcaus:='';
  ttimbraturecon[n_timbrcon].tcaus:='';
  ttimbraturecon[n_timbrcon].ttipofascia:=0;
  ttimbraturecon[n_timbrcon].trilev_e:='';
  ttimbraturecon[n_timbrcon].trilev_u:='';
  with ttimbraturecon[n_timbrcon] do
  begin
    tminutic_e:=ttimbraturedip[ieu].tminutid_e;
    tminutic_u:=ttimbraturedip[ieu].tminutid_u;
    tpuntatore:=ttimbraturedip[ieu].tpuntnomin;
    ttipofascia:=tipofasc;
    oralegsol:=ttimbraturedip[ieu].oralegsol;
    trilev_e:=ttimbraturedip[ieu].trilev_e;
    trilev_u:=ttimbraturedip[ieu].trilev_u;
    if (ttimbraturedip[ieu].tcausale_e.tcaus <> '') and
       (ttimbraturedip[ieu].tcausale_e.tcaus = ttimbraturedip[ieu].tcausale_u.tcaus) and
       (ttimbraturedip[ieu].tcausale_e.tcaustip = 'B') then
    begin
      traggcaus:=ttimbraturedip[ieu].tcausale_e.tcausrag;
      tcaus:=ttimbraturedip[ieu].tcausale_e.tcaus;
      tinclcaus:=ttimbraturedip[ieu].tcausale_e.tcausioe;
    end
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z830_mininpiu;
{Gestione minuti in piu'}
var E,U,Stacco,mmAggiuntivi:Integer;
    ScostValido,ScostE:Boolean;
    StaccoMinimo:String;
  function mininpiuEntrata:Boolean;
  //Gestione minuti in piu' sull'Entrata
  var i:Integer;
  begin
    //Result:=True;
    Result:=False;
    //18/02/2003 verifica dello stacco minimo richiesto
    //Ricerca della timbratura precedente fra quelle originali e calcolo dello stacco
    ScostValido:=True;
    Stacco:=ttimbraturedip[ieu].tminutid_e;
    for i:=0 to High(TimbratureDelGiorno) do
    begin
      (*
      if TimbratureDelGiorno[i].tversotimb = #0 then
      begin
        Result:=False;
        exit;
      end;
      *)
      if (TimbratureDelGiorno[i].tversotimb = 'E') and (TimbratureDelGiorno[i].toratimb = ttimbraturedip[ieu].tminutid_e) then
      begin
        if i > 0 then
          Stacco:=ttimbraturedip[ieu].tminutid_e - TimbratureDelGiorno[i - 1].toratimb
        else if estimbprec = 'si' then
          Stacco:=ttimbraturedip[ieu].tminutid_e + 1440 - minuti_pre
        else
          Stacco:=tcausale.tcauspiu;
        Result:=True;
        Break;
      end;
    end;
    if not Result then
      exit;
    //Verifica delle condizioni per applicare lo scostamento
    if ttimbraturedip[ieu].tflagarr_e = 'si' then
      ScostValido:=False;
    (*if Stacco - StaccoMinimo < 0 then
      ScostValido:=False;*)
    //Se il controllo sullo stacco minimo non è attivato, si applicano sempre i minuti in più interamente
    if StaccoMinimo <> 'S' then
    begin
      ScostValido:=True;
      Stacco:=tcausale.tcauspiu;
    end;
    if ScostValido and (Stacco > 0) then
    begin
      mmAggiuntivi:=min(tcausale.tcauspiu,Stacco);
      ScostCausEffettuato:=True;
      ScostE:=True;
      l04_caus:=tcausale.tcaus;
      l04_tipogius:='D';
      E:=ttimbraturedip[ieu].tminutid_e - mmAggiuntivi;
      U:=ttimbraturedip[ieu].tminutid_e;
      if E < 0 then
      begin
        E:=0;
        U:=mmAggiuntivi;
      end;
      l04_dalle:=EncodeTime(E div 60,E mod 60,0,0);
      l04_alle:=EncodeTime(U div 60,U mod 60,0,0);
      l04_PuntGiustR600:=-1;
      z436_giustcarica(True);
    end;
    //18/02/2003 Fine modifica
    (*  if tcausale.tcauspiu <= ttimbraturedip[ieu].tminutid_e then
        ttimbraturedip[ieu].tminutid_e:=ttimbraturedip[ieu].tminutid_e - tcausale.tcauspiu;*)
  end;
  procedure mininpiuUscita;
  //Gestione minuti in piu' sull'Uscita
  var i:Integer;
  begin
    ScostValido:=True;
    Stacco:=ttimbraturedip[ieu].tminutid_u;
    //Ricerca della timbratura successiva fra quelle originali
    for i:=0 to High(TimbratureDelGiorno) do
    begin
      if TimbratureDelGiorno[i].tversotimb = #0 then Break;
      if (TimbratureDelGiorno[i].tversotimb = 'U') and (TimbratureDelGiorno[i].toratimb = ttimbraturedip[ieu].tminutid_u) then
      begin
        if i < High(TimbraturedelGiorno) then //TimbratureDelGiorno[i + 1].tversotimb <> #0 then
          Stacco:=TimbratureDelGiorno[i + 1].toratimb - ttimbraturedip[ieu].tminutid_u
        else if estimbsucc = 'si' then
          Stacco:=minuti_suc + 1440  - ttimbraturedip[ieu].tminutid_u
        else
          Stacco:=tcausale.tcauspiu;
        Break;
      end;
    end;
    //Verifica delle condizioni per applicare lo scostamento
    //si considera la timbratura con tflagarr_u = 'si' se è stata fatta a mezzanotte (00.00) del giorno dopo
    if (ttimbraturedip[ieu].tflagarr_u = 'si') then
      if not((ieu = n_timbrdip) and (ttimbraturedip[ieu].tminutid_u = 1440) and (estimbsucc = 'si') and (minuti_suc = 0)) then
        ScostValido:=False;
    (*if Stacco - StaccoMinimo < 0 then
      ScostValido:=False;*)
    if not ScostCausEffettuato then
      ScostValido:=False;
    if (not ScostE) and ScostCausEffettuato and (ieu > 1) and (ttimbraturedip[ieu - 1].tcausale_u.tcaus <> tcausale.tcaus) then
    begin
      ScostValido:=False;
      ScostCausEffettuato:=False;
    end;
    //Se i minuti in più si devono applicare sia su uscita che successiva entrata,
    //sull'uscita si applica solo la differenza tra l'intero stacco e i minuti da aggiungere
    //in modo da non conteggiarli 2 volte sia sull'uscita che sull'entrata
    //U18.30 E18.40: i 10 minuti da aggiungere vengono applicati solo sulla successiva entrata
    if ScostValido and (Stacco < tcausale.tcauspiu * 2) then
    begin
      if (ieu < n_timbrdip) and (ttimbraturedip[ieu + 1].tcausale_e.tcaus = tcausale.tcaus) then
        Stacco:=max(0,Stacco - tcausale.tcauspiu)
      else if (ieu = n_timbrdip) and (estimbsucc = 'si') and (verso_suc = 'E') and (caus_suc = tcausale.tcaus) then
        Stacco:=max(0,Stacco - tcausale.tcauspiu);
    end;
    //Se il controllo sullo stacco minimo non è attivato,
    //si applicano sempre i minuti in più interamente
    if StaccoMinimo <> 'S' then
    begin
      ScostValido:=True;
      Stacco:=tcausale.tcauspiu;
    end;
    if ScostValido then
    begin
      mmAggiuntivi:=min(tcausale.tcauspiu,Stacco);
      ScostCausEffettuato:=False;
      l04_caus:=tcausale.tcaus;
      l04_tipogius:='D';
      E:=ttimbraturedip[ieu].tminutid_u;
      U:=ttimbraturedip[ieu].tminutid_u + mmAggiuntivi;
      if U >= 1440 then
      begin
        E:=1440 - mmAggiuntivi;
        U:=0;
      end;
      l04_dalle:=EncodeTime(E div 60,E mod 60,0,0);
      l04_alle:=EncodeTime(U div 60,U mod 60,0,0);
      l04_PuntGiustR600:=-1;
      if mmAggiuntivi > 0 then
        z436_giustcarica(True);
    end;
    (*  if (ttimbraturedip[ieu].tminutid_u + tcausale.tcauspiu) <= 1440 then
        ttimbraturedip[ieu].tminutid_u:=ttimbraturedip[ieu].tminutid_u + tcausale.tcauspiu;*)
  end;
begin
  {ScostCausEffettuato: Si tiene conto dell'ultimo scostamento applicato sull'entrata, in modo da
  applicare lo scostamento sull'uscita solo se è già stato applicato su un'entrata precedente}
  if (tcausale.tcauspiu <= 0) or (ttimbraturedip[ieu].tag = 'TG=D') then exit;
  StaccoMinimo:=ValStrT275[tcausale.tcaus,'STACCO_MINIMO_SCOST'];
  ScostE:=False;
  if (ieu = 1) and (primat_u = 'si') and (ScostCausEffettuato) then
    mininpiuUscita
  else
  if mininpiuEntrata then
    mininpiuUscita;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z840_datifrazdeb;
{Impostazione dati per frazionamento debito orario turno notturno}
begin
  if (TipoOrario <> 'E') or (PeriodoLavorativo <> 'T1') or (cdsT020.FieldByName('FrazDeb').AsString <> 'S') or (ttimbraturedip[ieu].tpuntnomin = 0) then
    exit;
  if pe = 0 then
    //Uscita dopo turno notturno
    begin
    if ttimbraturedip[ieu].tminutid_e = 0 then
      //if (ttimbraturedip[ieu].tminutid_u - ttimbraturedip[ieu].tminutid_e) >= (StrToIntDef(T020[Q020.Fields[C_POS_USCITE + pu].Index],0) div 2) then
      begin
      turnonott:=pu;
      if (*(ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,pu] = 0) and*) (ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,pu] = 0) then
        debfrazmatt:=ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,pu]
      else
        debfrazmatt:=ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,pu];
      end;
    end
  else
    if pu = 0 then
      //Entrata per turno notturno
      begin
      if ttimbraturedip[ieu].tminutid_u = 1440 then
        begin
        turnonott:=pe;
        if (*(ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,pe] = 0) and*) (ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,pe] = 0) then
          debfrazsera:=1440 - ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,pe]
        else
          debfrazsera:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,pe];
        end;
      end
    else
    begin
      //Turno non notturno
      (*if Q430.FieldByName('HTeoriche').AsString = '3' then
        debnoncav:=debitogg
      else*)
        debnoncav:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,pe];
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z850_FascePaghe;
{Suddivisione ore causalizzate nelle Voci Paghe a blocchi (AMGAS Bari)}
var i:Integer;
    Q,QP:Integer;
  procedure PutVocePaghe(Ore:Integer; VP:String);
  var j:Integer;
  begin
    for j:=0 to High(FascePaghe276) do
    begin
      if FascePaghe276[j].VocePaghe = VP then
      begin
        inc(FascePaghe276[j].Ore,Ore);
        Break;
      end
      else if FascePaghe276[j].VocePaghe = '' then
      begin
        FascePaghe276[j].VocePaghe:=VP;
        FascePaghe276[j].Ore:=Ore;
        Break;
      end;
    end
  end;
begin
  for i:=0 to High(OreCausali276) do
  begin
    if FasceCausali276[i].Codice = '' then Break;
    if OreCausali276[i] = 0 then Continue;
    QP:=0;
    with FasceCausali276[i] do
      if Q276.SearchRecord('Codice;TipoGiorno;Dalle;Alle',VarArrayOf([Codice,TipoGiorno,Dalle,Alle]),[srFromBeginning]) then
        repeat
          Q:=R180OreMinutiExt(Q276.FieldByName('Limite').AsString) - QP;
          if OreCausali276[i] <= Q then
          begin
            PutVocePaghe(OreCausali276[i],Q276.FieldByName('VocePaghe').AsString);
            Break;
          end
          else
          begin
            PutVocePaghe(Q,Q276.FieldByName('VocePaghe').AsString);
            Dec(OreCausali276[i],Q);
          end;
          QP:=R180OreMinutiExt(Q276.FieldByName('Limite').AsString);
        until not(Q276.SearchRecord('Codice;TipoGiorno;Dalle;Alle',VarArrayOf([Codice,TipoGiorno,Dalle,Alle]),[]));
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z860_coppienorm;
{Conteggio E - U in ore normali (gia' arrotondate)
 Gestione giorno con conteggio parziale}
begin
  if not calcolo_z100 then exit; //Alberto: FIRENZE_COMUNE
  z826_gesggparz;
  if (not conteggi_sologiust) and (ttimbraturedip[ieu].tminutid_e = ttimbraturedip[ieu].tminutid_u) then
    exit;
  //Salvataggio timbrature conteggiate in ore normali
  z828_saltimbcon;
  //Suddivisione in fasce
  causass:='';  //Alberto 24/07/2006 per gestire il parametro ABBATTE_STRIND
  z862_suddfascen;
  //Verifica calcolo debito orario giornaliero per turnisti
  if (debitocalc = 'no') and (ttimbraturedip[ieu].tpuntnomin <> 0) then
  begin
    if pe = 0 then
    begin
      debitogg:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,pu];
      if (TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and (cdsT020.FieldByName('FrazDeb').AsString = 'S') then
        debitogg:=debitogg + ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,pu];
    end
    else
    begin
      debitogg:=ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,pe];
      if (TipoOrario = 'E') and (PeriodoLavorativo = 'T1') and (cdsT020.FieldByName('FrazDeb').AsString = 'S') then
        debitogg:=debitogg + ValNumT021['ORETEOTUR2',TF_PUNTI_NOMINALI,pe];
    end;
    debitodaorario:=debitogg;
    debitocalc:='si';
  end;
  //Calcolo detrazione tipo pausa mensa C o D o E (se necessario)
  if ttimbraturedip[ieu].Tag <> 'TG=D' then
    z146_tipomenCDE;
  //Gestione dati per calcolo indennita'
  z700_gestindenn;
  //Calcolo minuti resi in fasce per orario elastico
  z202_minfaselast;
  //Impostazione dati per frazionamento debito orario
  //turno notturno
  z840_datifrazdeb;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z862_suddfascen;
{Suddivisione in fasce}
var i860,E,U:Integer;
    GestCambioOra:Boolean;
begin
  GestCambioOra:=not ttimbraturedip[ieu].OraLegSol;
  for i860:=1 to n_fasce do
    with tfasceorarie[i860] do
      begin
      //4.0 if ttipofasc <> tipofasc then Continue;
      //Test su primo range della fascia
      if (ttimbraturedip[ieu].tminutid_u > tiniz1fasc) and (ttimbraturedip[ieu].tminutid_e < tfine1fasc) then
        begin
        if ttimbraturedip[ieu].tminutid_e < tiniz1fasc then
          comodo3:=tiniz1fasc
        else
          comodo3:=ttimbraturedip[ieu].tminutid_e;
        if ttimbraturedip[ieu].tminutid_u > tfine1fasc then
        begin
          E:=comodo3;
          U:=tfine1fasc;
          comodo3:=tfine1fasc - comodo3;
        end
        else
        begin
          E:=comodo3;
          U:=ttimbraturedip[ieu].tminutid_u;
          comodo3:=ttimbraturedip[ieu].tminutid_u - comodo3;
        end;
        if aum862 = 'si' then
        begin
          inc(tminlav[i860],comodo3);
          if cdsT020.FieldByName('CAUSALE_FASCE').AsString <> '' then
            if ttimbraturedip[ieu].tpuntnomin > 0 then
             (*and (ttimbraturedip[ieu].tcausale_e.tcaus = '') and (ttimbraturedip[ieu].tcausale_u.tcaus = '')*)
              z814_CausaliInFasce(cdsT020.FieldByName('CAUSALE_FASCE').AsString,E,U)
            else if (ttimbraturedip[ieu].tcausale_e.tcaus <> '') and
                    (ttimbraturedip[ieu].tcausale_e.tcaus = ttimbraturedip[ieu].tcausale_u.tcaus) and
                    (ValStrT275[ttimbraturedip[ieu].tcausale_e.tcaus,'GIUST_DAA_TIMB'] = 'S') then
            begin
              z814_CausaliInFasce(cdsT020.FieldByName('CAUSALE_FASCE').AsString,E,U);
            end;
        end
        else
        begin
          dec(tminlav[i860],comodo3);
          //Alberto 24/07/2006
          if ValStrT265[causass,'ABBATTE_STRIND'] = 'S' then
            inc(tfasceorarie[i860].AbbFascia,comodo3);
        end;
        end;
      //Test su secondo eventuale range della fascia
      if (ttimbraturedip[ieu].tminutid_u > tiniz2fasc) and (ttimbraturedip[ieu].tminutid_e < tfine2fasc) then
        begin
        if ttimbraturedip[ieu].tminutid_e < tiniz2fasc then
          comodo3:=tiniz2fasc
        else
          comodo3:=ttimbraturedip[ieu].tminutid_e;
        if ttimbraturedip[ieu].tminutid_u > tfine2fasc then
        begin
          E:=comodo3;
          U:=tfine2fasc;
          comodo3:=tfine2fasc - comodo3;
        end
        else
        begin
          E:=comodo3;
          U:=ttimbraturedip[ieu].tminutid_u;
          comodo3:=ttimbraturedip[ieu].tminutid_u - comodo3;
        end;
        if aum862 = 'si' then
        begin
          inc(tminlav[i860],comodo3);
          if (cdsT020.FieldByName('CAUSALE_FASCE').AsString <> '') and (ttimbraturedip[ieu].tpuntnomin > 0) (*and
             (ttimbraturedip[ieu].tcausale_e.tcaus = '') and (ttimbraturedip[ieu].tcausale_u.tcaus = '')*) then
            z814_CausaliInFasce(cdsT020.FieldByName('CAUSALE_FASCE').AsString,E,U);
        end
        else
        begin
          dec(tminlav[i860],comodo3);
          //Alberto 24/07/2006
          if ValStrT265[causass,'ABBATTE_STRIND'] = 'S' then
            inc(tfasceorarie[i860].AbbFascia,comodo3);
        end;
        end;
      //Gestione cambio ora legale/solare
      if not GestCambioOra then
        if (tiniz1fasc < OraLegaleSolare.OraVecchia) and
           (tfine1fasc >= OraLegaleSolare.OraNuova) and
           (aum862 = 'si') then
          begin
          GestCambioOra:=True;
          if (OraLegaleSolare.Diff >= 0) or ((OraLegaleSolare.Diff < 0) and (abs(OraLegaleSolare.Diff) <= tminlav[i860])) then
            inc(tminlav[i860],OraLegaleSolare.Diff)
          else
            tminlav[i860]:=0;
          end;
      end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z886_fuoriorarrE;
{Arrotondamento su E fuori fascia oraria}
begin
  i890:=ieu;
  e_u890:='E';
  arr890:=ValNumT020['ArrFuoEnt'];
  z890_arrotonda;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z888_fuoriorarrU;
{Arrotondamento su U fuori fascia oraria}
begin
  i890:=ieu;
  e_u890:='U';
  arr890:=ValNumT020['ArrFuoUsc'];
  z890_arrotonda;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z890_arrotonda(pTipoModif:String = '');
{Arrotondamento timbrature se necessario}
var res890,arrabs890,quo890:Integer;
begin
  with ttimbraturedip[i890] do
  begin
    if arr890 < 0 then
      arrabs890:= - arr890
    else
      arrabs890:=arr890;
    if e_u890 = 'U' then
    //Arrotondamento uscita se necessario
    begin
      if tflagarr_u = 'si' then exit;
      tflagarr_u:='si';
      if arr890 = 0 then exit;
      quo890:=tminutid_u div arrabs890;
      res890:=tminutid_u mod arrabs890;
      if res890 = 0 then exit;
      timborig_u:=tminutid_u;
      tminutid_u:=quo890 * arrabs890;
      if arr890 < 0 then
        inc(tminutid_u,arrabs890);
      if timborig_u = tminutid_u then
        timborig_u:=-1
      else
        tagmodif_u:=pTipoModif;
    end
    else
    //Arrotondamento entrata se necessario
    begin
      if tflagarr_e = 'si' then exit;
      tflagarr_e:='si';
      if arr890 = 0 then exit;
      quo890:=tminutid_e div arrabs890;
      res890:=tminutid_e mod arrabs890;
      if res890 = 0 then exit;
      timborig_e:=tminutid_e;
      tminutid_e:=quo890 * arrabs890;
      if arr890 > 0 then
        inc(tminutid_e,arrabs890);
      (*Alberto 15/09/1999: L'arrotondamento dell'entrata non può superare il punto nominale di uscita*)
      if tpuntnomin > 0 then
        if tminutid_e > ttimbraturenom[tpuntnomin].tminutin_u then
          tminutid_e:=ttimbraturenom[tpuntnomin].tminutin_u;
      if timborig_e = tminutid_e then
        timborig_e:=-1
      else
        tagmodif_e:=pTipoModif;
    end;
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z892_arrotondap;
{Arrotondamento periodo}
var res890,arrabs890,quo890:Integer;
begin
  if arr890 = 0 then exit;
  if arr890 < 0 then
    arrabs890:= - arr890
  else
    arrabs890:=arr890;
  quo890:=per892 div arrabs890;
  res890:=per892 mod arrabs890;
  if res890 = 0 then exit;
  per892:=quo890 * arrabs890;
  if arr890 < 0 then
    inc(per892,arrabs890);
end;
//_________________________________________________________________
procedure TR502ProDtM1.z914_leggiparam;
{Lettura parametri di base}
const CampiFissi = 'Progressivo,DataDecorrenza,DataFine,TGestione,AbPresenza1,HTeoriche,Inizio,Fine,Calendario,' +
                   'Contratto,POrario,Orario,PlusOra,CausStraord,StraordE,StraordU,' +
                   'StraordEU,StraordEU2,Terminali,PartTime';
var CampiSupp:String;
begin
  //Indennità di presenza per livelli strutturali
  (*CampiSupp:=Trim(Parametri.CampiRiferimento.C3_IndPres);
  if Parametri.CampiRiferimento.C3_IndPres2 <> '' then
   if CampiSupp <> '' then
     CampiSupp:=CampiSupp + ',' + Parametri.CampiRiferimento.C3_IndPres2;*)
  CampiSupp:='';
  with Q430 do
    begin
    DeleteVariables;
    SQL.Clear;
    SQL.Add('SELECT ' + CampiFissi);
    if CampiSupp <> '' then
      SQL.Add(Format(',%s',[CampiSupp]));
    SQL.Add('FROM T430_Storico WHERE');
    SQL.Add('Progressivo = :Progressivo AND');
    SQL.Add('DataDecorrenza <= :AData AND');
    SQL.Add('DataFine >= :DaData');
    DeclareVariable('Progressivo',otInteger);
    DeclareVariable('AData',otDate);
    DeclareVariable('DaData',otDate);
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z916_startgiust;
{Open file giustificativi (se necessario)}
begin
  Q040.Filter:='Data >= ' + FloatToStr(DataCon);
  Q040.Filtered:=True;
  if not Q040.Active then
    Q040.Open;
  Q040.First;
  if Q040.RecordCount > 0 then
    s_trovato:='si'
  else
    s_trovato:='no';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z918_leggigiust;
{Read next file giustificativi}
begin
  Q040.Next;
  if not Q040.Eof then
    s_trovato:='si'
  else
    s_trovato:='no';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z922_leggicalen(Data:TDateTime; var ZTipoGG,ZTipoGGLav:Char);
{Leggo il tipo di giorno dai calendari individuali o generali
 Restituisco ztipogg    = F festivo    o N non festivo
             ztipogglav = S lavorativo o N non lavorativo
             giornlav178 = numero Giorni Lavorativi}
begin
  //Prima leggo il calendario del dipendente
  s_trovato:='no';
  if Q012B.SearchRecord('Data',Data,[srFromBeginning]) then
    begin
    s_trovato:='si';
    if Q012BFestivo.AsString = 'S' then
      Ztipogg:='F'
    else
      Ztipogg:='N';
    Ztipogglav:=R180CarattereDef(Q012BLavorativo.AsString);  //S oppure N
    GiornLav178:=Q012BNumGiorni.AsInteger;
    end
  else
    s_trovato:=GetCalendario(Q430.FieldByName('Calendario').AsString,Data,Ztipogg,Ztipogglav);
end;

function TR502ProDtm1.GetCalendario(Cod:String; Data:TDateTime; var ZTipoGG,ZTipoGGLav:Char):String;
begin
  Result:='no';
  if Trim(Cod) = '' then exit;

  lstT011.IndiceCorrente:=-1;
  if lstT011.Indice(Cod,Data) = -1 then
  begin
    R180SetVariable(Q011B,'Codice',Cod);
    Q011B.Open;
    if Q011B.SearchRecord('DATA',Data,[srFromBeginning]) then
      lstT011.Aggiungi(Cod,Q011B.FieldByName('DATA').AsDateTime,Q011B.FieldByName('DATA').AsDateTime,Q011B);
  end;
  if lstT011.Indice(Cod,Data) >= 0 then
  begin
    Result:='si';
    if lstT011.ValoreCorrente['FESTIVO'] = 'S' then
      Ztipogg:='F'
    else
      Ztipogg:='N';
    Ztipogglav:=R180CarattereDef(lstT011.ValoreCorrente['LAVORATIVO'],1,'S');
    GiornLav178:=StrToIntDef(lstT011.ValoreCorrente['NUMGIORNI'],0);
  end;
end;

//_________________________________________________________________
procedure TR502ProDtM1.z924_leggipian;
{Open file pianificazione orari (se necessario)}
begin
  //Gestiti in R400 per Torino_Comune
  MotivazionePianif:='';
  TurnoProvv1:=0;
  TurnoProvv2:=0;
  if (PianificazioneEsterna.Progressivo = progrcon) and (PianificazioneEsterna.Data = datacon) then
  begin
    l08_Turno1:=-1;
    l08_Turno2:=-1;
    if PianificazioneEsterna.l08_turno1 > -1 then
    begin
      l08_Turno1:=PianificazioneEsterna.l08_turno1;
      l08_Turno2:=PianificazioneEsterna.l08_turno2;
      l08_Turno1EU:=PianificazioneEsterna.l08_turno1EU;
      l08_Turno2EU:=PianificazioneEsterna.l08_turno2EU;
      s_trovato:='si';
    end;
    l08_Orario:=Trim(PianificazioneEsterna.l08_Orario);
    if l08_Orario <> '' then
      s_trovato:='si';
    c_ValorGior:='';
  end
  else if Q080.SearchRecord('Data',datacon,[srFromBeginning]) then
  begin
    s_trovato:='si';
    l08_Orario:=Trim(Q080Orario.AsString);
    l08_Turno1:=StrToIntDef(Trim(Q080Turno1.AsString),-1);
    l08_Turno2:=StrToIntDef(Trim(Q080Turno2.AsString),-1);
    l08_Turno1EU:=Trim(Q080Turno1EU.AsString);
    l08_Turno2EU:=Trim(Q080Turno2EU.AsString);
    MotivazionePianif:=Trim(Q080Motivazione.AsString);
    c_ValorGior:='';//Trim(Q080ValorGior.AsString);
  end
  else
    s_trovato:='no';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z926_starttimbr(Data:TDateTime);
{Start file timbrature (se necessario)
Consiste nell'impostare il filtro con Data >= a data di riferimento}
begin
  s_trovato:='no';
  if not Q100.Active then
    Q100.Open;
  Q100.Filter:='Data >= ' + FloatToStr(Data);
  Q100.Filtered:=True;
  Q100.First;
  if Q100.RecordCount > 0 then
    begin
    s_trovato:='si';
    z930_Carical10;
    end
  else
    s_trovato:='no';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z928_leggitimbr;
{Read next file timbrature}
begin
  Q100.Next;
  if not Q100.Eof then
    begin
    s_trovato:='si';
    z930_Carical10;
    end
  else
    s_trovato:='no';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z930_Carical10;
{Carico i dati delle timbrature in variabili di memoria}
begin
  l10_Data:=Q100.FieldByName('Data').AsDateTime;
  l10_Ora:=R180OreMinuti(Q100.FieldByName('Ora').AsDateTime);
  l10_Verso:=R180CarattereDef(Q100.FieldByName('Verso').AsString);
  l10_Flag:=R180CarattereDef(Q100.FieldByName('Flag').AsString);
  l10_Rilevatore:=Q100.FieldByName('Rilevatore').AsString;
  l10_Causale:=Q100.FieldByName('Causale').AsString.Trim;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z936_leggipoin;
{Open file plus orario individuale (se necessario)}
begin
  if Q090.SearchRecord('Anno',datacon_aa,[srFromBeginning]) then
    s_trovato:='si'
  else
    s_trovato:='no';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z938_leggipocat;
{Open file categorie plus orario (se necessario)}
begin
  if Q060.SearchRecord('Codice;Anno',VarArrayOf([Q430.FieldByName('PlusOra').AsString,datacon_aa]),[srFromBeginning]) then
    s_trovato:='si'
  else
    s_trovato:='no';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z946_leggiorar;
{Lettura dei modelli di orario in cdsT020/cdsT021 e posizionamento sulla decorrenza valida alla data di conteggio}
var i,iPN:Integer;
    D:TDateTime;
begin
  s_trovato:='no';
  if not cdsT020.Active then
  begin
    //Creazione dei client dataset
    //z999_Seleziona(Q020,'Codice',c_orario);
    z999_Seleziona(selT020,'Codice',c_orario);
    z999_Seleziona(selT021,'Codice',c_orario);
    cdsT020.FieldDefs.Assign(selT020.FieldDefs);
    cdsT020.IndexDefs.Clear;
    cdsT020.IndexDefs.Add('INDICE','DECORRENZA',[ixDescending]);
    cdsT020.IndexName:='INDICE';
    cdsT020.CreateDataSet;
    cdsT021.FieldDefs.Assign(selT021.FieldDefs);
    cdsT021.IndexDefs.Clear;
    cdsT021.IndexDefs.Add('INDICE','CODICE;DECORRENZA;TIPO_FASCIA;ID_TURNO;ENTRATAMM;USCITAMM',[]);
    cdsT021.IndexName:='INDICE';
    cdsT021.CreateDataSet;
    cdsT020.LogChanges:=False;
    cdsT021.LogChanges:=False;
  end;
  cdsT020.Filter:='CODICE = ''' + c_orario + '''';
  cdsT021.Filter:='CODICE = ''' + c_orario + '''';
  cdsT020.Filtered:=True;
  cdsT021.Filtered:=True;
  cdsT020.First;
  cdsT021.First;
  if cdsT020.RecordCount = 0 then
  begin
    //Lettura orari dal database e caricamento nei client dataset
    z999_Seleziona(selT020,'Codice',c_orario);
    z999_Seleziona(selT021,'Codice',c_orario);
    //Caricare tutte le decorrenze
    while not selT020.Eof do
    begin
      cdsT020.Append;
      for i:=0 to selT020.FieldCount -1 do
        cdsT020.Fields[i].Value:=selT020.Fields[i].Value;
      cdsT020.Post;
      selT021.First;
      iPN:=0;
      while not selT021.Eof do
      begin
        if selT021.FieldByName('DECORRENZA').AsDateTime = selT020.FieldByName('DECORRENZA').AsDateTime then
        begin
          cdsT021.Append;
          for i:=0 to selT021.FieldCount -1 do
          begin
            if  (cdsT021.Fields[i].FieldName = 'USCITAMM')
            and (selT021.FieldByName('TIPO_FASCIA').AsString = TF_STRAORDINARIO)
            and (selT021.FieldByName('ENTRATAMM').AsInteger > 0)
            and (selT021.FieldByName('USCITAMM').AsInteger = 0)
            then
              cdsT021.Fields[i].AsInteger:=1440
            else
              cdsT021.Fields[i].Value:=selT021.Fields[i].Value;
            if (selT021.FieldByName('TIPO_FASCIA').AsString = TF_PUNTI_NOMINALI) and (selT021.Fields[i].FieldName = 'ID_TURNO') then
            begin
              inc(iPN);
              if cdsT021.Fields[i].IsNull then
                cdsT021.Fields[i].AsInteger:=iPN;
            end;
          end;
          cdsT021.Post;
        end;
        selT021.Next;
      end;
      selT020.Next;
    end;
  end;
  //Ricerca della decorrenza valida a datacon
  cdsT020.First;
  while not cdsT020.Eof do
  begin
    if cdsT020.FieldByName('DECORRENZA').AsDateTime <= datacon then
    begin
      s_trovato:='si';
      D:=cdsT020.FieldByName('DECORRENZA').AsDateTime;
      cdsT020.Filter:='CODICE = ''' + c_orario + ''' AND DECORRENZA = ' + FloatToStr(D);
      cdsT021.Filter:='CODICE = ''' + c_orario + ''' AND DECORRENZA = ' + FloatToStr(D);
      Break;
    end;
    cdsT020.Next;
  end;
  cdsT020.First;
  cdsT021.First;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z948_leggiprofor;
{Legge il profilo orario e carica i codici orario nelle tabelle T220,T221}
var Giorno:Integer;
    i,j,xx,yy,N_ProfiliLet:Integer;
begin
    s_trovato:='no';
    for xx:=Low(T220) to High(T220) do T220[xx]:='';
    for xx:=1 to 50 do for yy:=1 to 9 do T221[xx,yy]:='';
    MaxT221:=0;
    j:=-1;
    //Leggo dalla tabella in memoria
    for i:=0 to High(tprofililetti) do
      if (tprofililetti[i].Profilo[selT220.FieldByName('Codice').Index] = Q430.FieldByName('POrario').AsString) and
         (StrToDate(tprofililetti[i].Profilo[selT220.FieldByName('Decorrenza').Index]) <= DataCon) then
      begin
        s_trovato:='si';
        j:=i;
        T220:=tprofililetti[i].Profilo;
        T221:=tprofililetti[i].Settimane;
        MaxT221:=tprofililetti[i].NumSet;
        Break;
      end;
    if j = -1 then
      //Leggo da archivio
      begin
      if z999_Seleziona(selT220,'Codice',Q430.FieldByName('POrario').AsString) then
      begin
        //Alberto 21/12/2005: lettura di tutti i movimenti storici di questo profilo in ordine decrescente
        while not selT220.Eof do
        begin
          selT221.SetVariable('Codice',selT220.FieldByName('Codice').AsString);
          selT221.SetVariable('Decorrenza',selT220.FieldByName('Decorrenza').AsDateTime);
          selT221.Close;
          selT221.Open;
          for i:=0 to selT220.FieldCount - 1 do
            if (UpperCase(selT220.Fields[i].FieldName) <> 'DECORRENZA') and (selT220.Fields[i].DataType = ftDateTime) then
              T220[i]:=IntToStr(R180OreMinuti(selT220.Fields[i].AsDateTime))
            else
              T220[i]:=selT220.Fields[i].AsString;
          i:=1;
          while not selT221.Eof do
          begin
            for Giorno:=1 to 9 do
              T221[i,Giorno]:=Trim(selT221.Fields[Giorno - 1].AsString);
            selT221.Next;
            inc(i);
          end;
          MaxT221:=i - 1;
          N_ProfiliLet:=Length(tprofililetti);
          SetLength(tprofililetti,N_ProfiliLet + 1);
          tprofililetti[N_ProfiliLet].Profilo:=T220;
          tprofililetti[N_ProfiliLet].Settimane:=T221;
          tprofililetti[N_ProfiliLet].NumSet:=MaxT221;
          selT220.Next;
        end;
      //Leggo dalla tabella in memoria
      for i:=0 to High(tprofililetti) do
        if (tprofililetti[i].Profilo[selT220.FieldByName('Codice').Index] = Q430.FieldByName('POrario').AsString) and
           (StrToDate(tprofililetti[i].Profilo[selT220.FieldByName('Decorrenza').Index]) <= DataCon) then
        begin
          s_trovato:='si';
          T220:=tprofililetti[i].Profilo;
          T221:=tprofililetti[i].Settimane;
          MaxT221:=tprofililetti[i].NumSet;
          Break;
        end;
      end;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z950_leggicontr;
{Legge il contratto e lo carica nelle tabelle T200,T201}
var x:Integer;
    i,j,xx,yy,N_ContrattiLet:Integer;
begin
    s_trovato:='no';
    for xx:=Low(T200) to High(T200) do T200[xx]:='';
    for xx:=1 to 9 do for yy:=0 to 13 do T201[xx,yy]:='';
    j:=-1;
    //Leggo dalla tabella in memoria
    for i:=0 to High(tcontrattiletti) do
      if tcontrattiletti[i].Contratto[0] = c_contratto then
      begin
        s_trovato:='si';
        j:=i;
        T200:=tcontrattiletti[i].Contratto;
        for x:=1 to 9 do
          T201[x]:=tcontrattiletti[i].FasceGiorno[x];
        Break;
      end;
    if j = -1 then
    //Leggo da archivio
    begin
      if z999_Seleziona(Q200,'Codice',c_contratto) then
      begin
        s_trovato:='si';
        Q201.SetVariable('Codice',c_contratto);
        Q201.Close;
        Q201.Open;
        //Lettura dati contratto
        for i:=0 to Q200.FieldCount - 1 do
          if (Q200.Fields[i].DataType = ftDateTime) and (Q200.Fields[i].FieldName <> 'DATADECORRENZA') then
            T200[i]:=IntToStr(R180OreMinuti(Q200.Fields[i].AsDateTime))
          else
            T200[i]:=Q200.Fields[i].AsString;
        //Lettura dati fasce
        i:=1;
        while not Q201.Eof do
        begin
          for x:=0 to Q201.FieldCount - 1 do
            if Q201.Fields[x].DataType = ftDateTime then
              T201[i,x]:=IntToStr(R180OreMinuti(Q201.Fields[x].AsDateTime))
            else
              T201[i,x]:=Q201.Fields[x].AsString;
          Q201.Next;
          inc(i);
        end;
        //if N_ContrattiLet < High(tcontrattiletti) then
        N_ContrattiLet:=Length(tcontrattiletti);
        SetLength(tcontrattiletti,N_ContrattiLet + 1);
        tcontrattiletti[N_ContrattiLet].Contratto:=T200;
        for i:=1 to 9 do
          tcontrattiletti[N_ContrattiLet].FasceGiorno[i]:=T201[i];
      end;
    end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z951_leggifasce;
{Lettura fasce orarie da contratto (maggiorazioni)}
var xx:Integer;
begin
  for xx:=Low(T201GG) to High(T201GG) do T201GG[xx]:='';
  s_trovato:='no';
  T201GG:=T201[DayOfWeek(datacon - 1)];
  //Fascia magg. per festività
  if tipogg = 'F' then
    T201GG:=T201[9]
  else
    //Fascia magg. per non lavorativo e non domenica
    if (gglav = 'no') and (DayOfWeek(datacon - 1) <> 7) then
      T201GG:=T201[8];
  //Controllo che vi sia corrispondenza col contratto
  if T201GG[0] = T200[0] then
    s_trovato:='si';
end;
//_________________________________________________________________
//4.0
procedure TR502ProDtM1.z952_leggifascesuccessive;
{Lettura fasce orarie da contratto del giorno successivo per conteggio notte su Entrata}
var xx:Integer;
begin
  for xx:=Low(T201GG) to High(T201GG) do T201GG[xx]:='';
  s_trovato:='no';
  T201GG:=T201[DayOfWeek(datacon)];
  //Fascia magg. per festività
  if tipogg_suc = 'F' then
    T201GG:=T201[9]
  else
    //Fascia magg. per non lavorativo e non domenica
    if (tipogglav_suc = 'N') and (DayOfWeek(datacon) <> 7) then
      T201GG:=T201[8];
  //Controllo che vi sia corrispondenza col contratto
  if T201GG[0] = T200[0] then
    s_trovato:='si';
end;
//_________________________________________________________________
procedure TR502ProDtM1.z964_leggicaus(key029_1:String);
{Verifica se la causale e' gia' stata letta
 Se viene letta, l29_1Paramet contiene:
 A = Assenza
 B = Presenza
 C = Giustificativo
 l29_2paramet contiene il codice di raggruppamento
 l29_Ragg contiene il tipo di raggruppamento
}
var i:Integer;
begin
  s_trovato:='no';
  if key029_1 = '' then
    exit;

  if key029_1 = parcaus.l29_0paramet then
  begin
    s_trovato:='si';
  end
  else
  begin
    for i:=0 to High(tcausalilette) do
      if tcausalilette[i].tcodcaus = key029_1 then
      begin
        s_trovato:='si';
        parcaus:=tcausalilette[i].tparcaus;
        Break;
      end;
  end;

  if s_trovato = 'si' then
  begin
    if parcaus.l29_1Paramet = 'A' then
      z966_leggicausT265(parcaus.l29_0Paramet)
    else if parcaus.l29_1Paramet = 'B' then
      z967_leggicausT275(parcaus.l29_0Paramet);
    exit;
  end;

  //La causale non e' ancora stata letta
  parcaus.l29_Ragg:='';
  parcaus.l29_0paramet:='';
  parcaus.l29_1paramet:='';
  parcaus.l29_2paramet:='';
  parcaus.l29_3paramet:='';
  parcaus.l29_4paramet:='';
  parcaus.l29_5paramet:='';
  parcaus.l29_6paramet:='';
  parcaus.l29_7paramet:='';
  parcaus.l29_8paramet:='';
  parcaus.l29_9paramet:='';
  parcaus.l29_10paramet:='';
  parcaus.l29_11paramet:='';
  parcaus.l29_12paramet:='';
  parcaus.l29_13paramet:='';
  parcaus.l29_14paramet:='';
  parcaus.l29_15paramet:='';
  parcaus.l29_16paramet:='';
  parcaus.l29_17paramet:='';
  parcaus.l29_18paramet:='';
  parcaus.l29_19paramet:='';
  parcaus.l29_20paramet:='';
  parcaus.l29_21paramet:='';
  parcaus.l29_22paramet:='';
  parcaus.l29_23paramet:='';
  parcaus.l29_24paramet:='';
  parcaus.l29_25paramet:='';
  parcaus.l29_26paramet:='';
  parcaus.l29_27paramet:='';
  parcaus.l29_28paramet:='';
  parcaus.l29_29paramet:='';
  parcaus.l29_30paramet:='';
  parcaus.l29_31paramet:='';
  parcaus.l29_32paramet:='';
  parcaus.l29_33paramet:='';
  parcaus.l29_34paramet:='';
  parcaus.l29_35paramet:='';
  parcaus.l29_36paramet:='';
  parcaus.l29_37paramet:='';
  parcaus.l29_38paramet:='';
  parcaus.l29_39paramet:='';
  parcaus.l29_40paramet:='';
  parcaus.l29_41paramet:='';
  parcaus.l29_42paramet:='';
  parcaus.l29_43paramet:='';
  parcaus.l29_44paramet:='';
  parcaus.l29_45paramet:='';
  parcaus.l29_46paramet:='';
  parcaus.l29_47paramet:='';
  parcaus.l29_48paramet:='';
  parcaus.l29_49paramet:='';
  parcaus.l29_50paramet:='';
  parcaus.l29_51paramet:='';
  parcaus.l29_52paramet:='';
  s_trovato:='si';
  //if Q275.SearchRecord('CODICE',key029_1,[srFromBeginning]) then
  if z967_leggicausT275(key029_1) then
    with parcaus do
    begin
      l29_0Paramet:=Q275.FieldByName('Codice').AsString;
      l29_1Paramet:='B';
      l29_2Paramet:=Q275.FieldByName('CodRaggr').AsString;
      l29_Ragg:=Q275.FieldByName('CodInterno').AsString;
      l29_3Paramet:=Q275.FieldByName('TipoConteggio').AsString;
      l29_4Paramet:=Q275.FieldByName('RipFasce').AsString;
      l29_5Paramet:=Q275.FieldByName('OreNormali').AsString;
      l29_6Paramet:=Q275.FieldByName('Arrotondamento').AsString;
      l29_7Paramet:=Q275.FieldByName('Stampe').AsString;
      l29_8Paramet:=IntToStr(R180OreMinuti(Q275.FieldByName('Scostamento').AsDateTime));
      l29_9Paramet:=Q275.FieldByName('Tipo_NonAutorizzate').AsString;
      l29_10Paramet:=Q275.FieldByName('Tipo_MinMinimi').AsString;
      //l29_11Paramet:=Q275.FieldByName('MaturaMensa').AsString;
      l29_12Paramet:=Q275.FieldByName('LfsCavMez').AsString;
      l29_13Paramet:=Q275.FieldByName('MinMinuti').AsString;
      l29_14Paramet:=Q275.FieldByName('MaxMinuti').AsString;
      l29_15Paramet:=Q275.FieldByName('PianifRep').AsString;
      l29_16Paramet:=Q275.FieldByName('Soglia_Fasce_ObblFac').AsString;
      l29_17Paramet:=Q275.FieldByName('Esclusione_Fascia_Obb').AsString;
      l29_18Paramet:=Q275.FieldByName('Flessibilita_Orario').AsString;
      l29_19Paramet:=Q275.FieldByName('Limite_DebitoGG').AsString;
      l29_20Paramet:=Q275.FieldByName('No_Eccedenza_In_Fascia').AsString;
      l29_21Paramet:=Q275.FieldByName('liquidabile').AsString;
      //l29_22Paramet:=Q275.FieldByName('ripliq').AsString;
      l29_22Paramet:=Q275.FieldByName('SEMPRE_APPOGGIATA').AsString;
      l29_23Paramet:=Q275.FieldByName('tipo_u_nonautorizzate').AsString;
      l29_24Paramet:=Q275.FieldByName('gettone_tipo_oresup').AsString;
      l29_25Paramet:=Q275.FieldByName('gettone_ore').AsString;
      l29_26Paramet:=Q275.FieldByName('gettone_spezzoni').AsString;
      l29_27Paramet:=Q275.FieldByName('gettone_tipo_oreinf').AsString;
      l29_28Paramet:=Q275.FieldByName('stacco_minimo_scost').AsString;
      l29_29Paramet:=Q275.FieldByName('scost_punti_nominali').AsString;
      l29_30Paramet:=Q275.FieldByName('senza_flessibilita').AsString;
      l29_31Paramet:=Q275.FieldByName('caus_fuori_turno').AsString;
      l29_32Paramet:=Q275.FieldByName('Perc_Inail').AsString;
      l29_33Paramet:=Q275.FieldByName('gettone_dalle').AsString;
      l29_34Paramet:=Q275.FieldByName('gettone_alle').AsString;
      //l29_35Paramet:=Q275.FieldByName('TIMB_PM').AsString;
      l29_36Paramet:=Q275.FieldByName('INCLUDI_INDTURNO').AsString;
      l29_37Paramet:=Q275.FieldByName('ARROT_RIEPGG').AsString;
      l29_38Paramet:=Q275.FieldByName('ARROT_RIEPGG_ORENORM').AsString;
      l29_39Paramet:=Q275.FieldByName('ARROT_RIEPGG_FASCE').AsString;
      l29_40Paramet:=Q275.FieldByName('E_IN_FLESSIBILITA').AsString;
      //l29_41Paramet:=Q275.FieldByName('AUTOCOMPLETAMENTO_UE').AsString;
      l29_42Paramet:=Q275.FieldByName('TIPO_RICHIESTA_WEB').AsString;
      l29_43Paramet:=Q275.FieldByName('CONSIDERA_SCELTA_ORARIO').AsString;
      l29_44Paramet:=Q275.FieldByName('FLEX_TIMBR_CAUS').AsString;
      l29_45Paramet:=Q275.FieldByName('FORZA_NOTTE_SPEZZATA').AsString;
      l29_46Paramet:=Q275.FieldByName('CAUSALIZZA_TIMB_INTERSECANTI').AsString;
      //l29_47Paramet:=Q275.FieldByName('TIMB_PM_DETRAZ').AsString;
      l29_48Paramet:=Q275.FieldByName('GIUST_DAA_TIMB').AsString;
      //l29_49Paramet:=Q275.FieldByName('INTERSEZIONE_TIMBRATURE').AsString;
      l29_50Paramet:=Q275.FieldByName('NO_ECCED_IN_FASCIA_CONS_ASS').AsString;
      //l29_51Paramet:=Q275.FieldByName('CAUSCOMP_DEBITOGG').AsString;
      l29_52Paramet:=Q275.FieldByName('FORZA_CAUSECCEDENZA').AsString;
      //l29_53Paramet:=Q275.FieldByName('TIMB_PM_H').AsString;
      if l29_15Paramet = '' then
        l29_15Paramet:='N';
      //Forzo il limite massimo se è stato lasciato a 0
      if l29_14paramet = '' then
        l29_14paramet:='9999';
    end
  //else if z999_Seleziona(Q265,'Codice',key029_1) then
  else if z966_leggicausT265(key029_1) then
  begin
    with parcaus do
    begin
      l29_0Paramet:=lstT265.ValoreCorrente['Codice'];//cdsT265.FieldByName('Codice').AsString;
      l29_1Paramet:='A';
      l29_2Paramet:=lstT265.ValoreCorrente['CodRaggr'];//cdsT265.FieldByName('CodRaggr').AsString;
      l29_Ragg:=lstT265.ValoreCorrente['CodInterno'];//cdsT265.FieldByName('CodInterno').AsString;
      l29_3Paramet:=lstT265.ValoreCorrente['GNonLav'];//cdsT265.FieldByName('GNonLav').AsString;
      l29_4Paramet:=lstT265.ValoreCorrente['InfluCont'];//cdsT265.FieldByName('InfluCont').AsString;
      //l29_5Paramet:=cdsT265.FieldByName('ValorGior').AsString;
      l29_6Paramet:=lstT265.ValoreCorrente['InfluenzaPO'];//cdsT265.FieldByName('InfluenzaPO').AsString;
      l29_7Paramet:=lstT265.ValoreCorrente['Stampa'];//cdsT265.FieldByName('Stampa').AsString;
      //l29_8Paramet:=IntToStr(R180OreMinuti(cdsT265.FieldByName('HMAssenza').AsDateTime));
      l29_10Paramet:=lstT265.ValoreCorrente['Esclusione'];//cdsT265.FieldByName('Esclusione').AsString;
      //l29_11Paramet:=lstT265.ValoreCorrente['IndPres'];//cdsT265.FieldByName('IndPres').AsString;
      l29_12Paramet:=lstT265.ValoreCorrente['EccedLiq'];//cdsT265.FieldByName('EccedLiq').AsString;
      l29_13Paramet:=lstT265.ValoreCorrente['UMisura'];//cdsT265.FieldByName('UMisura').AsString;
      l29_15Paramet:=lstT265.ValoreCorrente['ValSeTimb'];//cdsT265.FieldByName('ValSeTimb').AsString;
      l29_16Paramet:=lstT265.ValoreCorrente['TipoCumulo'];//cdsT265.FieldByName('TipoCumulo').AsString;
      l29_17Paramet:=lstT265.ValoreCorrente['TipoRecupero'];//cdsT265.FieldByName('TipoRecupero').AsString;
      l29_18Paramet:=lstT265.ValoreCorrente['Flessibilita_Orario'];//cdsT265.FieldByName('Flessibilita_Orario').AsString;
      l29_19Paramet:=lstT265.ValoreCorrente['Perc_Inail'];//cdsT265.FieldByName('Perc_Inail').AsString;
      l29_20Paramet:=IntToStr(R180OreMinutiExt(lstT265.ValoreCorrente['Fruiz_Arr']));//IntToStr(R180OreMinutiExt(cdsT265.FieldByName('Fruiz_Arr').AsString));
      l29_21Paramet:=lstT265.ValoreCorrente['FruizCompetenze_Arr'];//cdsT265.FieldByName('FruizCompetenze_Arr').AsString;
      //l29_22Paramet:=lstT265.ValoreCorrente['Intersezione_Timbrature'];//cdsT265.FieldByName('Intersezione_Timbrature').AsString;
      //l29_23Paramet:=lstT265.ValoreCorrente['Abbatte_StrInd'];//cdsT265.FieldByName('Abbatte_StrInd').AsString;
      //l29_24Paramet:=lstT265.ValoreCorrente['Timb_PM'];//cdsT265.FieldByName('Timb_PM').AsString;
      l29_25Paramet:=lstT265.ValoreCorrente['Cumulo_Tipo_Ore'];//cdsT265.FieldByName('Cumulo_Tipo_Ore').AsString;
      //l29_26Paramet:=lstT265.ValoreCorrente['Timb_PM_Detraz'];//cdsT265.FieldByName('Timb_PM_Detraz').AsString;
      l29_27Paramet:=lstT265.ValoreCorrente['Fruiz_Min'];//cdsT265.FieldByName('Fruiz_Min').AsString;
      l29_28Paramet:=lstT265.ValoreCorrente['Fruiz_Max'];//cdsT265.FieldByName('Fruiz_Max').AsString;
      l29_29Paramet:=lstT265.ValoreCorrente['Copre_Fascia_Obb'];//cdsT265.FieldByName('Copre_Fascia_Obb').AsString;
      l29_30Paramet:=lstT265.ValoreCorrente['Iter_EccGG'];//cdsT265.FieldByName('Iter_EccGG').AsString;
    end
  end
  else if z999_Seleziona(Q305,'Codice',key029_1) then
    with parcaus do
    begin
      l29_0Paramet:=Q305Codice.AsString;
      l29_1Paramet:='C';
      l29_2Paramet:=Q305CodRaggr.AsString;
      l29_Ragg:=Q305CodInterno.AsString;
    end
  else
  begin
    s_trovato:='no';
    exit;
  end;
  i:=Length(tcausalilette);
  SetLength(tcausalilette,i + 1);
  tcausalilette[i].tcodcaus:=key029_1;
  tcausalilette[i].tparcaus:=parcaus;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z965_SettaCausPres(var C:t_tcausale);
begin
  C.tcaus:=parcaus.l29_0paramet;
  C.tcaustip:=parcaus.l29_1paramet;
  C.tcauscodrag:=parcaus.l29_2paramet;
  C.tcausrag:=parcaus.l29_Ragg;
  C.tcauscon:=parcaus.l29_3paramet;
  C.tcausrip:=parcaus.l29_4paramet;
  C.tcausioe:=parcaus.l29_5paramet;
  C.tcausarr:=StrToIntDef(parcaus.l29_6paramet,0);
  C.tcausrpl:=parcaus.l29_7paramet;
  C.tcauspiu:=StrToIntDef(parcaus.l29_8paramet,0);
  C.tNonAutorizzate:=parcaus.l29_9paramet;
  C.tOreInsufficenti:=parcaus.l29_10paramet;
  //C.tcausmatmensa:=parcaus.l29_11Paramet;
  C.tLfsCavMez:=parcaus.l29_12paramet;
  C.tMinMinuti:=StrToIntDef(parcaus.l29_13Paramet,0);
  C.tMaxMinuti:=StrToIntDef(parcaus.l29_14Paramet,9999);
  C.tpianrep:=parcaus.l29_15paramet;

  C.tcausmatmensa:=ValStrT275[C.tcaus,'MATURAMENSA'];
end;
//_________________________________________________________________
function TR502ProDtM1.z966_leggicausT265(Codice:String):Boolean;
{Lettura delle causali di assenza in lstT265/lstT230 e posizionamento sulla decorrenza valida alla data di conteggio}
var i:Integer;
    D:TDateTime;
begin
  Result:=False;

  lstT265.IndiceCorrente:=-1;
  lstT230.IndiceCorrente:=-1;
  if lstT265.Indice(Codice) = -1 then
    if z999_Seleziona(Q265,'Codice',Codice) then
    begin
      lstT265.Aggiungi(Codice,Q265);
      selT230.First;
      while not selT230.Eof do
      begin
        lstT230.Aggiungi(Codice,selT230.FieldByName('DECORRENZA').AsDateTime,selT230.FieldByName('DECORRENZA_FINE').AsDateTime,selT230);
        selT230.Next;
      end;
    end;
  if lstT265.Indice(Codice) = -1 then
    exit;
  lstT230.Indice(Codice,datacon);

  Result:=True;
end;
//_________________________________________________________________
function TR502ProDtM1.z967_leggicausT275(Codice:String):Boolean;
{Lettura delle causali di presenza in QT275/lstT235 e posizionamento sulla decorrenza valida alla data di conteggio}
var i:Integer;
    D:TDateTime;
begin
  Result:=False;
  lstT235.IndiceCorrente:=-1;
  if Q275.SearchRecord('CODICE',Codice,[srFromBeginning]) then
  begin
    Result:=True;
    if lstT235.Indice(Codice,datacon) = -1 then
    begin
      R180SetVariable(selT235,'CODICE',Codice);
      selT235.Open;
      selT235.First;
      while not selT235.Eof do
      begin
        lstT235.Aggiungi(Codice,selT235.FieldByName('DECORRENZA').AsDateTime,selT235.FieldByName('DECORRENZA_FINE').AsDateTime,selT235);
        selT235.Next;
      end;
    end;
    lstT235.Indice(Codice,datacon);
  end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z978_leggimonte;
{Lettura monte ore settimanali da anagrafico}
begin
  s_trovato:='no';
  if Q430.RecordCount > 0 then
    if not Q430.FieldByName('Orario').IsNull then
      begin
      s_trovato:='si';
      minmonteore:=R180OreMinutiExt(Q430.FieldByName('Orario').AsString);
      end;
end;
//_________________________________________________________________
procedure TR502ProDtM1.z980_leggioralegalesolare;
begin
  OraLegaleSolare.Cambio:=False;
  OraLegaleSolare.Data:=EncodeDate(1900,1,1);
  OraLegaleSolare.Diff:=0;
  OraLegaleSolare.OraNuova:=0;
  OraLegaleSolare.OraVecchia:=0;
  if Q110.SearchRecord('Data',DataCon,[srFromBeginning]) then
  begin
    OraLegaleSolare.Data:=datacon;
    OraLegaleSolare.OraVecchia:=R180OreMinutiExt(Q110.FieldByName('OraVecchia').AsString);
    OraLegaleSolare.OraNuova:=R180OreMinutiExt(Q110.FieldByName('OraNuova').AsString);
    OraLegaleSolare.Diff:=OraLegaleSolare.OraVecchia - OraLegaleSolare.OraNuova;
  end
  else if Q110.SearchRecord('Data',DataCon + 1,[srFromBeginning]) then
  begin
    OraLegaleSolare.Data:=datacon + 1;
    OraLegaleSolare.OraVecchia:=R180OreMinutiExt(Q110.FieldByName('OraVecchia').AsString) + 1440;
    OraLegaleSolare.OraNuova:=R180OreMinutiExt(Q110.FieldByName('OraNuova').AsString) + 1440;
    OraLegaleSolare.Diff:=OraLegaleSolare.OraVecchia - OraLegaleSolare.OraNuova;
  end
end;
//_________________________________________________________________
function TR502ProDtM1.z999_Seleziona(Q:TOracleDataSet; Parametro,Valore:String):Boolean;
begin
  //Q.SetVariable(Parametro,Valore);
  //Q.Close;
  R180SetVariable(Q,Parametro,Valore);
  Q.Open;
  Q.First;
  Result:=Q.RecordCount > 0;
end;
//_______________________________________________________________
procedure TR502ProDtM1.z1000_ReperibilitaSostitutivaB;
var V:String;
    Turno:array[1..4] of TTurno;
    ComPres:Integer;
    procedure LeggiTurni(P:LongInt; Data:TDateTime);
    var i:Byte;
         D:TDateTime;
    begin
      with Q380 do
      begin
        D:=DataCon - 1;
        while D <= DataCon do
        begin
          if SearchRecord('DATA',D,[srFromBeginning]) then
          begin
            if Q380.FieldByName('DATA').AsDateTime < DataCon then i:=1 else i:=3;
            Turno[i + 0].T:=Q380.FieldByName('TURNO1').AsString;
            Turno[i + 1].T:=Q380.FieldByName('TURNO2').AsString;
            if Q350.SearchRecord('CODICE',Turno[i + 0].T,[srFromBeginning]) then
            begin
              Turno[i + 0].Inizio:=R180OreMinuti(Q350.FieldByName('ORAINIZIO').AsDateTime);
              Turno[i + 0].Fine:=R180OreMinuti(Q350.FieldByName('ORAFINE').AsDateTime);
            end;
            if Q350.SearchRecord('CODICE',Turno[1].T,[srFromBeginning]) then
            begin
              Turno[i + 1].Inizio:=R180OreMinuti(Q350.FieldByName('ORAINIZIO').AsDateTime);
              Turno[i + 1].Fine:=R180OreMinuti(Q350.FieldByName('ORAFINE').AsDateTime);
            end;
          end;
          D:=D + 1;
        end;
      end;
    end;
   procedure CreaPeriodi;
   var i:Byte;
   begin
     for i:=1 to 4 do
       if Turno[i].T <> '' then
         begin
         if i < 3 then
           begin
           if Turno[i].Inizio < Turno[i].Fine then
             Turno[i].T:=''
           else
             Turno[i].Inizio:=0;
           end
         else
           if Turno[i].Inizio >= Turno[i].Fine then
             Turno[i].Fine:=1440;
         end
       else
         Turno[i].Inizio:=-1;
   end;
   procedure OrdinaPeriodi;
   var i,j,k:Integer;
       T:TTurno;
   begin
     for i:=1 to 4 do
       begin
       j:=i + 1;
       for k:=j to 4 do
         if Turno[k].Inizio < Turno[i].Inizio then
           begin
           T:=Turno[i];
           Turno[i]:=Turno[k];
           Turno[k]:=T;
           end;
       end;
   end;
begin
  ComPres:=0;
  Turno[1].T:='';
  Turno[2].T:='';
  Turno[3].T:='';
  Turno[4].T:='';
  //Lettura turni pianificati al dipendente in oggetto
  LeggiTurni(ProgrCon,DataCon);
  CreaPeriodi;
  OrdinaPeriodi;
  with Q430Rep do
    begin
    //Lettura valore della squadra
    Close;
    DeleteVariables;
    SQL.Clear;
    SQL.Add('SELECT ' + SquadraSost + ' FROM T430_STORICO WHERE PROGRESSIVO = :PROGRESSIVO AND DATADECORRENZA <= :DATA AND DATAFINE >=:DATA');
    DeclareVariable('Progressivo',otInteger);
    DeclareVariable('Data',otDate);
    SetVariable('PROGRESSIVO',ProgrCon);
    SetVariable('DATA',DataCon);
    try
      Open;
    except
      raise;
      exit;
    end;
    V:=Fields[0].AsString;
    Close;
    if Trim(V) = '' then exit;
    //Estrazione dipendenti appartenenti alla stessa squadra e pianificati in reperibilità
    Close;
    DeleteVariables;
    SQL.Clear;
    SQL.Add('SELECT T030.PROGRESSIVO, COGNOME, T030.NOME,T430.BADGE,T380.DATA,T380.TURNO1, T380.TURNO2');
    SQL.Add('FROM T030_ANAGRAFICO T030, T430_STORICO T430,');
    SQL.Add('T380_PIANIFREPERIB T380, T350_REGREPERIB T350A,T350_REGREPERIB T350B');
    SQL.Add('WHERE');
    SQL.Add('T030.PROGRESSIVO <> :PROGRESSIVO AND');
    SQL.Add('T030.PROGRESSIVO = T430.PROGRESSIVO AND');
    SQL.Add('T430.' + SquadraSost + ' = ''' + V + ''' AND DATADECORRENZA <= :DATA AND DATAFINE >= :DATA AND');
    SQL.Add('T380.PROGRESSIVO = T030.PROGRESSIVO AND ');
    SQL.Add('(T380.DATA = :DATA OR T380.DATA = :DATA - 1) AND');
    SQL.Add('T350A.CODICE(+) = T380.TURNO1 AND T350B.CODICE(+) = T380.TURNO2 AND');
    SQL.Add('(T350A.TIPOTURNO = ''R'' OR T350B.TIPOTURNO = ''R'')');
    SQL.Add('ORDER BY T030.PROGRESSIVO,T380.DATA');
    DeclareVariable('Progressivo',otInteger);
    DeclareVariable('Data',otDate);
    SetVariable('PROGRESSIVO',ProgrCon);
    SetVariable('DATA',DataCon);
    try
      Open;
    except
      raise;
      exit;
    end;
    LTurni:=TStringList.Create;
    DescAnom:='';
    while not Eof do
    begin
      if Q350.SearchRecord('CODICE;TIPOTURNO',VarArrayOf([FieldByName('TURNO1').AsString,'R']),[srFromBeginning]) then
        ComPres:=ComPres + z1001_ControlloTurnoRep(FieldByName('TURNO1').AsString,FieldByName('DATA').AsDateTime,Turno);
      if Q350.SearchRecord('CODICE;TIPOTURNO',VarArrayOf([FieldByName('TURNO2').AsString,'R']),[srFromBeginning]) then
        ComPres:=ComPres + z1001_ControlloTurnoRep(FieldByName('TURNO2').AsString,FieldByName('DATA').AsDateTime,Turno);
      Next;
    end;
    FreeAndNil(LTurni);//.Free;
    end;
  if ComPres > 0 then
  begin
    z099_anom3(4,ComPres,DescAnom);
  end;
end;
//_______________________________________________________________
function TR502ProDtM1.z1001_ControlloTurnoRep(Codice:String; Data:TDateTime; Turno:array of TTurno):Integer;
var I,F,xx:Integer;
    j,x:Byte;
    PeriodoRep:array[1..5] of TPeriodoIF;
    OraI,OraF:String;
begin
  Result:=0;
  I:=R180OreMinuti(Q350.FieldByName('OraInizio').AsDateTime);
  F:=R180OreMinuti(Q350.FieldByName('OraFine').AsDateTime);
  for xx:=Low(PeriodoRep) to High(PeriodoRep) do
  begin
    PeriodoRep[xx].F:=0;
    PeriodoRep[xx].I:=0;
  end;
  //Troncatura del turno a Mezzanotte se il turno è a cavallo di giorni:
  //se giorno precedente I = 0
  //se giorno attuale F = 1440
  if Data < DataCon then
    begin
    //Non considero se pianificato anche al dipendente
    if (Codice = Turno[0].T) or (Codice = Turno[1].T) then exit;
    if I < F then exit;
    I:=0;
    end
  else
    begin
    //Non considero se pianificato anche al dipendente
    if (Codice = Turno[2].T) or (Codice = Turno[3].T) then exit;
    if F <= I then
      F:=1440;
    end;
  OraI:=R180MinutiOre(I);
  OraF:=R180MinutiOre(F);
  //Se il turno è già stato esaminato esco subito
  if LTurni.IndexOf(IntToStr(I) + IntToStr(F)) >= 0 then
    exit
  else
    LTurni.Add(IntToStr(I) + IntToStr(F));
  //Controllo intersezione con turni di reperibilità del dipendente
  x:=1;
  PeriodoRep[1].I:=I;
  PeriodoRep[1].F:=F;
  for j:=0 to 3 do
    if Turno[j].T <> '' then
      begin
      if (Turno[j].Inizio >= I) and (Turno[j].Inizio <= F) then
        begin
        PeriodoRep[x].F:=Turno[j].Inizio;// - 1;
        I:=Turno[j].Fine;// + 1;
        inc(x);
        PeriodoRep[x].I:=I;
        PeriodoRep[x].F:=F;
        end;
      if (Turno[j].Fine >= I) and (Turno[j].Fine <= F) then
        begin
        I:=Turno[j].Fine;// + 1;
        PeriodoRep[x].I:=I;
        end;
      end;
  //Annullamento dei periodi non considerati
  for j:=x to 5 do
    if (PeriodoRep[j].I > PeriodoRep[j].F) or
       ((PeriodoRep[j].I = 0) and (PeriodoRep[j].F = 0)) then
      PeriodoRep[j].I:=-1;
  //A questo punto, PeriodoRep contiene le fasce orarie (fino a 5) che devono risultare libere
  for j:=1 to 5 do
    if PeriodoRep[j].I >= 0 then
      begin
      for x:=1 to n_timbrcon do
        begin
        I:=ttimbraturecon[x].tminutic_e;
        F:=ttimbraturecon[x].tminutic_u;
        if (I >= PeriodoRep[j].F) or (F <= PeriodoRep[j].I) then
          Continue;
        if PeriodoRep[j].I > I then
          I:=PeriodoRep[j].I;
        if F > PeriodoRep[j].F then
          F:=PeriodoRep[j].F;
        Result:=Result + F - I;
        end;
      end;
  if Result > 0 then
    begin
    if DescAnom <> '' then
      DescAnom:=DescAnom + #13 + #10;
    DescAnom:=DescAnom + Format('  %s %s %s Turno:%s Da %s a %s',[Q430Rep.FieldByName('COGNOME').AsString,Q430Rep.FieldByName('NOME').AsString,Q430Rep.FieldByName('BADGE').AsString,Codice,OraI,OraF]);
    end;
end;
//_______________________________________________________________
procedure TR502ProDtM1.z1002_TimbNotturnaNonAppoggiata;
{18/03/2002 x Collegno:
 Toglie l'appoggio alla timbratura a cavallo di mezzanotte, se l'uscita corrispondente
 è antecedente al parametro Min_Uscita_Notte del modello orario}
var i:Integer;
begin
  for i:=1 to n_timbrdip do
  begin
    if (i = 1) and (estimbprec = 'si') and (verso_pre = 'E') and
       (ttimbraturedip[i].tminutid_e = 0) and
       (ttimbraturedip[i].tminutid_u < ValNumT020['Min_Uscita_Notte']) then
    begin
      ttimbraturedip[i].tpuntnomin:=0;
      ttimbraturedip[i].tpuntnominold:=0;
    end;
    if (i = n_timbrdip) and (estimbsucc = 'si') and (verso_suc = 'U') and
       (ttimbraturedip[i].tminutid_u = 1440) and
       (minuti_suc < ValNumT020['Min_Uscita_Notte']) then
    begin
      ttimbraturedip[i].tpuntnomin:=0;
      ttimbraturedip[i].tpuntnominold:=0;
    end;
  end;
end;
//_______________________________________________________________
procedure TR502ProDtM1.z1003_StraordinarioForzato;
{Se la coppia di timbrature è causalizzata con il parametro 'Liquidabile' = 'B' tolgo l'appoggio}
var i:Integer;
begin
  for i:=1 to n_timbrdip do
    with ttimbraturedip[i] do
      if (tcausale_e.tcaus <> '') and (tcausale_e.tcauscon <> 'A') and (tcausale_e.tcauscon <> 'E') and (tcausale_e.tcaustip = 'B') then
        if (tcausale_e.tcaus = tcausale_u.tcaus) then
          if ValStrT275[tcausale_e.tcaus,'LIQUIDABILE'] = 'B' then
            tpuntnomin:=0;
end;
//_______________________________________________________________
procedure TR502ProDtM1.z1004_ArrotondaOreCausalizzate;
{TORINO_COMUNE: Arrotondamento dei riepiloghi causalizzati ai 30 minuti - il resto rimane nelle ore normali}
var i,j,OreCaus,OreArr,Arrot,Resto:Integer;
    sv_tminpres:t_FasceInteri;
    TipoArr:String;
begin
  i:=1;
  while i <= n_rieppres do
  begin
    Arrot:=R180OreMinutiExt(ValStrT275[triepgiuspres[i].tcauspres,'ARROT_RIEPGG']);
    if (triepgiuspres[i].tcauspres <> '') and (Arrot > 1) then
    begin
      OreCaus:=0;
      for j:=1 to n_fasce do
        inc(OreCaus,triepgiuspres[i].tminpres[j]);
      OreArr:=Trunc(R180Arrotonda(OreCaus,Arrot,'D'));
      detrazioni:=OreCaus - OreArr;
      Resto:=OreCaus - OreArr;
      sv_tminpres:=triepgiuspres[i].tminpres;
      //Se le ore sono escluse, reincludo il resto dell'arrotondamento nelle ore normali
      //if (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A') then
      z140_detrazioni(triepgiuspres[i].tminpres);
      //Se le ore sono escluse, tolgo il resto dell'arrotondamento dal riepilogo delle ore escluse
      if (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A') then
        dec(minlavesc,Resto);
      //Se causale esclusa e il resto dell'arrotondamento viene perso, si devono togliere le ore da tminlav nelle fase giuste
      if ValStrT275[triepgiuspres[i].tcauspres,'ARROT_RIEPGG_ORENORM'] = 'N' then //=N si perde il resto
        if (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] <> 'A') then
          for j:=1 to n_fasce do
            dec(tminlav[j],sv_tminpres[j] - triepgiuspres[i].tminpres[j]);
      //Se causale esclusa e il resto dell'arrotondamento viene mantenuto, si include il resto nelle ore normali
      if ValStrT275[triepgiuspres[i].tcauspres,'ARROT_RIEPGG_ORENORM'] = 'S' then //=S si mantiene il resto
      begin
        if (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A') then
          inc(tminlav[fasciabass],Resto);
      end;
      if OreArr = 0 then
      //Eliminazione riepilogo
      begin
        dec(n_rieppres);
        for j:=i to n_rieppres do
          triepgiuspres[j]:=triepgiuspres[j + 1];
        dec(i);
      end
      else if ValStrT275[triepgiuspres[i].tcauspres,'ARROT_RIEPGG_FASCE'] = 'S' then
      begin
        //Arrotondamento puro all'interno delle fasce
        TipoArr:='P';
        for j:=n_fasce downto 1 do
        begin
          if triepgiuspres[i].tminpres[j] > 0 then
          begin
            triepgiuspres[i].tminpres[j]:=Trunc(R180Arrotonda(triepgiuspres[i].tminpres[j],Arrot,TipoArr));
            TipoArr:=IfThen(TipoArr = 'P','P-','P');
          end;
        end;
      end;     
    end;
    inc(i);
  end;
end;

procedure TR502ProDtM1.z1005_QuadraturaSettimanale;
var TL:Integer;
begin
  //Alberto TORINO_COMUNE: quadratura settimanale - La variabile TOCOQuadraturaSettimanale viene impostata sulla R410
  if not(TOCOQuadraturaSettimanale and (Chiamante = 'Cartolina') and (tipogglav = 'S') and (Self.Name <> 'R502Ricorsivo') and (cdsT020.FieldByName('RICALCOLO_DEBITO_GG').AsString = 'S')) then
    exit;
  if cdsT020.FieldByName('RICALCOLO_CAUS_NEG').IsNull and cdsT020.FieldByName('RICALCOLO_CAUS_POS').IsNull then
    exit;
  if gglav = 'no' then
    TL:=0
  else
  begin
    z752_lavscostgg;
    TL:=totlav;
    if not cdsT020.FieldByName('OreMin').IsNull then
      TL:=max(TL,ValNumT020['OreMin']);
  end;
  with scrQuadrSett do
  begin
    ClearVariables;
    SetVariable('PROGRESSIVO',progrcon);
    SetVariable('DATA',datacon);
    //SetVariable('SCOST',ResoSett + TL - minmonteore);
    SetVariable('SCOST',ResoSett + TL - DebSett);
    SetVariable('CAUS_NEG',cdsT020.FieldByName('RICALCOLO_CAUS_NEG').Value);
    SetVariable('CAUS_POS',cdsT020.FieldByName('RICALCOLO_CAUS_POS').Value);
    Execute;
  end;
end;

function TR502ProDtM1.z1006_OreEsterne(Dalle,Alle:Integer):Integer;
var i,j:Integer;
begin
  for i:=1 to n_timbrnom do
    for j:=1 to n_timbrdip do
      if ttimbraturedip[j].tpuntnomin = i then
      begin
        Dalle:=max(Dalle,ttimbraturenom[i].tminutin_u);
        //Alle:=min(Alle,ttimbraturenom[i].tminutin_e);
      end;
  Result:=max(0,Alle - Dalle);
end;

procedure TR502ProDtM1.z1007_AbbatteSuddivisionefasce;
var i,t,abbattimento,app,nf:Integer;
    lstFasce:TStringList;
  procedure OrdinaFasce;
  var i:Integer;
  begin
    lstFasce:=TStringList.Create;
    lstFasce.Sorted:=True;
    for i:=1 to n_fasce do
      if lstFasce.IndexOf(Format('%5d',[tfasceorarie[i].tiniz1fasc])) = -1 then
        lstFasce.Add(Format('%5d',[tfasceorarie[i].tiniz1fasc]));
  end;
  procedure IntersezioneFasce276(NumFascia:Integer; DetrazMensa:Boolean);
  var i,Intervallo,OreIntervallo,IFascia,FFascia:Integer;
      TipoGiorno,TipoGiornoSuc:String;
  begin
    TipoGiorno:=z1008_TipoGiorno276(cdsT020.FieldByName('CAUSALE_FASCE').AsString,False);
    TipoGiornoSuc:=z1008_TipoGiorno276(cdsT020.FieldByName('CAUSALE_FASCE').AsString,True);
    //Ricerco le fasce a blocchi che intersecano le fasce orarie, in ordine cronologico discendente per escludere le ultime ore
    for i:=High(FasceCausali276) downto 0 do
      if (FasceCausali276[i].Codice = cdsT020.FieldByName('CAUSALE_FASCE').AsString) and (OreCausali276[i] > 0) then
      begin
        if DetrazMensa then
        begin
          IFascia:=InizioMensa;
          FFascia:=FineMensa;
        end
        else
        begin
          IFascia:=tfasceorarie[NumFascia].tiniz1fasc;
          FFascia:=tfasceorarie[NumFascia].tfine1fasc;
        end;
        if (IFascia < 1440) and (TipoGiorno <> FasceCausali276[i].TipoGiorno) then
          Continue;
        if (IFascia >= 1440) and (TipoGiornoSuc <> FasceCausali276[i].TipoGiorno) then
          Continue;
        if IFascia >= 1440 then
        begin
          IFascia:=tfasceorarie[NumFascia].tiniz1fasc - 1440;
          FFascia:=tfasceorarie[NumFascia].tfine1fasc - 1440;
        end;
        Intervallo:=max(0,min(FasceCausali276[i].Alle1,FFascia) - max(FasceCausali276[i].Dalle1,IFascia));
        Intervallo:=Intervallo + max(0,min(FasceCausali276[i].Alle2,FFascia) - max(FasceCausali276[i].Dalle2,IFascia));
        OreIntervallo:=max(0,min(OreCausali276[i],tminlav[NumFascia]));
        OreIntervallo:=max(0,min(OreIntervallo,Intervallo));
        OreIntervallo:=max(0,min(OreIntervallo,abbattimento));
        dec(OreCausali276[i],OreIntervallo);
        dec(abbattimento,OreIntervallo);
      end;
  end;
begin
  if cdsT020.FieldByName('CAUSALE_FASCE').AsString = '' then
    exit;
  //Totalizzo le ore rese nel giorno
  t:=0;
  for i:=1 to n_fasce do
  begin
    //vett_fasce[i]:=0;
    inc(t,tminlav[i]);    //inc(t,tminlav[i] - tminstrgio[i]);
  end;
  //Tolgo dal totale le ore rese da assenza
  for i:=1 to n_riepasse do
    if (triepgiusasse[i].ttipofruiz <> 'D') or (ValStrT265[triepgiusasse[i].tcausasse,'ESCLUSIONE'] = 'N') then
      dec(t,triepgiusasse[i].tminresasse);
  //Limito le ore rese al debito gg
  t:=min(t,debitogg);
  t:=max(0,t);
  //Totalizzo le ore riconosciute con la causale
  abbattimento:=0;
  for i:=0 to High(FasceCausali276) do
    if (FasceCausali276[i].Codice = cdsT020.FieldByName('CAUSALE_FASCE').AsString) and (OreCausali276[i] > 0) then
      inc(abbattimento,OreCausali276[i]);
  //L'abbattimento è dato dalla differenza tra le ore causalizzate e le ore rese (limitate al debito gg e al netto delle assenze)
  abbattimento:=max(0,abbattimento - t);
  if abbattimento = 0 then
    exit;
  //Abbattimento della pausa mensa dalla fasciabass
  if paumendet - paumendet_resto > 0 then
  begin
    app:=abbattimento;
    abbattimento:=min(paumendet - paumendet_resto,abbattimento);
    //Si considera il successivo abbattimento al netto della detrazione per pausa mensa
    dec(app,abbattimento);
    IntersezioneFasce276(fasciabass,True);
    abbattimento:=app;
  end;
  if abbattimento = 0 then
    exit;
  try
    OrdinaFasce;
    //Scorro tfasceorarie in ordine cronologico discendente per eliminare per prime le ore fatte dopo l'orario di lavoro
    for i:=lstFasce.Count - 1 downto 0 do
    begin
      nf:=1;
      repeat
        if (tfasceorarie[nf].tiniz1fasc = StrToInt(lstFasce[i])) and (tminlav[nf] > 0) then
        begin
          //per ogni fascia in cui ci sono dei minuti, vado a cercare le corrispondenti fasce in FasceCausali276
          //e diminuisco i minuti in OreCausali276 fino ad esaurire abbattimento.
          IntersezioneFasce276(nf,False);
          if abbattimento = 0 then
            Break;
        end;
        inc(nf);
      until nf > n_fasce;
      if abbattimento = 0 then
        Break;
    end;
  finally
    FreeAndNil(lstFasce);
  end;
end;

function TR502ProDtM1.z1008_TipoGiorno276(C:String; GGSucc:Boolean):String;
var giorsett_suc:Integer;
begin
  Result:='';
  if not GGSucc then
  begin
    //Tipo giorno attuale
    if ((tipogg = 'F') or (giorsett = 7)) and (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,'F']),[srFromBeginning])) then
      Result:='F'   //Festivo o domenica
    else if (tipogg = 'F') and (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,'FF']),[srFromBeginning])) then
      Result:='FF'  //Solo festivo
    else if ((TipoGG_suc = 'F') or (giorsett = 6)) and (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,'PF']),[srFromBeginning])) then
      Result:='PF'  //Prefestivo o sabato
    else if (gglav = 'no') and (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,'NL']),[srFromBeginning])) then
      Result:='NL'  //non lavorati
    else if (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,giorsett.ToString]),[srFromBeginning])) then
      Result:=giorsett.ToString  //gg specifico
    else if (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,'L']),[srFromBeginning])) then
      Result:='L'   //altro giorno
  end
  else
  begin
    //Tipo giorno successivo
    if giorsett = 7 then
      giorsett_suc:=1
    else
      giorsett_suc:=giorsett + 1;

    if ((TipoGG_suc = 'F') or (giorsett = 6)) and (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,'F']),[srFromBeginning])) then
      Result:='F'   //Festivo o domenica
    else if (not Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (TipoGG_suc = 'F') and (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,'FF']),[srFromBeginning])) then
      Result:='FF'  //Solo festivo
    else if (TipoGGLav_suc = 'N') and (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,'NL']),[srFromBeginning])) then
      Result:='NL'  //Non lavorativo
    else if (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,giorsett_suc.ToString]),[srFromBeginning])) then
      Result:=giorsett_suc.ToString  //gg specifico
    else if (Q276.SearchRecord('Codice;TipoGiorno',VarArrayOf([C,'L']),[srFromBeginning])) then
      Result:='L';  //altro giorno

    //Per TORINO_CSI, il solo festivo sul giorno successivo viene messo solo se lo è anche il giorno corrente
    if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (z1008_TipoGiorno276(C,False) = 'FF') then
      Result:='FF';
  end;
end;

procedure TR502ProDtM1.z1009_CausalizzaStraordinario;
{AOSTA_REGIONE: gestione compenso aggiuntivo
 Si generano i riepiloghi di presenza delle causali CA, CA1 a partire dallo straordinario}
var i,j,OreMax,OreArr,Tot,mm,OreEscluse:Integer;
    ArrCaus:array of t_tcausale;
    CausaliEccedenza:String;
begin
  //questa procedura è in alternativa con la z1016 per domenica e festivi,
  //a seconda che esista o meno il modulo TORINO_CSI_PRV
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] and (giorsett = 7) and (tipogg = 'F') then
    exit;

  //Forzatura della gestione di CausaliEccedenza se esiste causale apposita su ultima uscita (Parma_Comune)
  CausaliEccedenza:='';
  if cdsT020.FieldByName('CAUSALI_ECCEDENZA').IsNull then
  begin
    for i:=0 to High(TimbratureOriginali) do
    begin
      if (TimbratureOriginali[i].caus_u <> '') and
         (R180In(ValStrT275[TimbratureOriginali[i].caus_u,'TIPOCONTEGGIO'],['D'])) and
         (ValStrT275[TimbratureOriginali[i].caus_u,'FORZA_CAUSECCEDENZA'] = 'S') then
      begin
        CausaliEccedenza:=TimbratureOriginali[i].caus_u;
        Break;
      end;
    end;
  end;

  if (cdsT020.FieldByName('CAUSALI_ECCEDENZA').AsString = '') and (CausaliEccedenza = '') then
    exit;
  OreEscluse:=0;
  SetLength(ArrCaus,0);
  with TStringList.Create do
  try
    CommaText:=cdsT020.FieldByName('CAUSALI_ECCEDENZA').AsString + CausaliEccedenza;
    SetLength(ArrCaus,Count);
    for i:=0 to Count - 1 do
      ArrCaus[i].tcaus:=Strings[i];
  finally
    Free;
  end;
  for i:=0 to High(ArrCaus) do
  begin
    OreMax:=StrToIntDef(ValStrT275[ArrCaus[i].tcaus,'MAXMINUTI'],9999);
    OreArr:=R180OreMinutiExt(ValStrT275[ArrCaus[i].tcaus,'ARROT_RIEPGG']);
    if not CausPresAbilitato(ArrCaus[i].tcaus) then
      OreMax:=0;
    z964_leggicaus(ArrCaus[i].tcaus);
    if (s_trovato = 'si') and (parcaus.l29_1paramet = 'B') then
      z965_SettaCausPres(ArrCaus[i]);
    Tot:=R180SommaArray(tminstrgio);
    if OreArr > 1 then
      Tot:=Trunc(R180Arrotonda(Tot,OreArr,'D'));
    Tot:=min(Tot,OreMax);
    if Tot > 0 then
    begin
      riepcaus:=ArrCaus[i].tcaus;
      riepcaus_e:=0;
      riepcaus_u:=0;
      riepcausrag:=ArrCaus[i].tcausrag;
      riepcausrip:=ArrCaus[i].tcausrip;
      riepcausioe:=ArrCaus[i].tcausioe;
      riepcausOreGettone:=0;
      riepcaus_numtimb:=0;
      if riepcausioe = 'A' then
        OreEscluse:=max(OreEscluse,Tot);
      z810_rieppres(OreMax);
      if i810 > 0 then
        for j:=1 to n_fasce do
        begin
          mm:=min(tminstrgio[j],Tot);
          //Se causale inclusa nelle normali resetto il riepilogo
          //Se causale esclusa dalle normali la sommo all'eventuale riepilogo già calcolato
          triepgiuspres[i810].tminpres[j]:=IfThen(riepcausioe = 'A',triepgiuspres[i810].tminpres[j]) + mm;
          dec(Tot,mm);
        end;
    end;
  end;
  //Spostamento su ore escluse dalle normali
  if OreEscluse > 0 then
    for i:=1 to n_fasce do
    begin
      mm:=min(tminstrgio[i],OreEscluse);
      dec(OreEscluse,mm);
      dec(tminstrgio[i],mm);
      dec(tminstrgio2[i],min(mm,tminstrgio2[i])); //Serve per calcolo ind.turno PAL
      dec(tminlav[i],min(mm,tminlav[i]));
      inc(minlavesc,mm);
    end;
end;

procedure TR502ProDtM1.z1010_RientroPomeridiano;
//Ore lavorate minime (solo permessi, quali???)
//Uscita oltre le 16/17
//Intervallo mensa (diverso da TR350FCalcoloBuoniDtM.IntervalloMensa!!)
//Lavorato dopo mensa >= 1 ora
const
  RP_HMIN = 390;
  RPS_HMIN = 450;
  RP_UMIN = 16*60;
  RPS_UMIN = 17*60;
  RP_PMMIN = 30;
  RP_PMMAX = 120;
  RP_LAVPRIMAPM = 60;
  RP_LAVDOPOPM = 60;
var
  CausaliTollerate:String;
  i,j,Tot,PM,MaxU,InizioPM,RientroPM:Integer;
  TimbDaGiust:Boolean;
begin
  CausaliTollerate:=ValStrT025['CAUS_RIENTRIOBBL',''];
  //Ore lavorate minime (solo permessi, quali???)
  Tot:=R180SommaArray(tminlav) + minlavesc;
  for i:=1 to n_riepasse do
    if not R180InConcat(triepgiusasse[i].tcausasse,CausaliTollerate) then
      dec(Tot,triepgiusasse[i].tminresasse);
  RientroPomeridiano.TotLav:=Tot;
  if RientroPomeridiano.TotLav < min(RP_HMIN,RPS_HMIN) then
    exit;
  //Uscita oltre le 16/17
  MaxU:=0;
  for i:=1 to n_timbrdip do
  begin
    TimbDaGiust:=False;
    for j:=1 to n_giusdaa do
      if ttimbraturedip[i].tminutid_u = tgius_dallealle[j].tminutia then
      begin
        TimbDaGiust:=True;
        Break;
      end;
    if TimbDaGiust then
      Continue;
    if (*(ttimbraturedip[i].tpuntnomin > 0) and*) (ttimbraturedip[i].tminutid_u > MaxU) then
      MaxU:=ttimbraturedip[i].tminutid_u;
  end;
  RientroPomeridiano.MaxUTimb:=MaxU;
  for i:=1 to n_giusdaa do
    if R180InConcat(tgius_dallealle[i].tcausdaa,CausaliTollerate) then
      if (tgius_dallealle[i].tminutia > MaxU) then
        MaxU:=tgius_dallealle[i].tminutia;
  RientroPomeridiano.MaxU:=MaxU;
  if MaxU < min(RP_UMIN,RPS_UMIN) then
    exit;
  //Intervallo mensa
  PM:=0;
  InizioPM:=1440;
  RientroPM:=0;
  if paumenges = 'no' then
    exit;
  if TipoDetPaumen = 'PMT' then
    for i:=0 to High(TimbratureMensa) do
    begin
      inc(PM,TimbratureMensa[i].F - TimbratureMensa[i].I);
      if TimbratureMensa[i].I < InizioPM then
        InizioPM:=TimbratureMensa[i].I;
      if TimbratureMensa[i].F > RientroPM then
        RientroPM:=TimbratureMensa[i].F;
    end
  else
  begin
    InizioPM:=InizioMensa;
    RientroPM:=InizioMensa + PauMenMinUtilizzata;
  end;
  RientroPomeridiano.PausaMensa:=max(PM,PauMenMinUtilizzata);
  if not R180Between(RientroPomeridiano.PausaMensa,RP_PMMIN,RP_PMMAX) then
    exit;
  //Lavorato prima mensa >= 1 ora (Per buono pasto)
  for i:=1 to n_timbrdip do
    if (*(ttimbraturedip[i].tpuntnomin > 0) and*) (ttimbraturedip[i].tminutid_e < InizioPM) and (ttimbraturedip[i].tminutid_u >= InizioPM) then
      inc(RientroPomeridiano.LavPrimaMensaTimb,min(InizioPM,ttimbraturedip[i].tminutid_u) - ttimbraturedip[i].tminutid_e);
  //Lavorato dopo mensa >= 1 ora
  for i:=1 to n_timbrdip do
    if (*(ttimbraturedip[i].tpuntnomin > 0) and*) (ttimbraturedip[i].tminutid_u > RientroPM) then
      inc(RientroPomeridiano.LavDopoMensaTimb,ttimbraturedip[i].tminutid_u - max(RientroPM,ttimbraturedip[i].tminutid_e));
  for i:=1 to n_giusdaa do
    if R180InConcat(tgius_dallealle[i].tcausdaa,CausaliTollerate) then
      if (tgius_dallealle[i].tminutia > RientroPM) then
        inc(RientroPomeridiano.LavDopoMensa,tgius_dallealle[i].tminutia - max(RientroPM,tgius_dallealle[i].tminutida));
  inc(RientroPomeridiano.LavDopoMensa,RientroPomeridiano.LavDopoMensaTimb);
  if RientroPomeridiano.LavDopoMensa < RP_LAVDOPOPM then
    exit;
  //Riconoscimento rientro pomeridiano obbligatorio o supplementare
  if (RientroPomeridiano.TotLav >= RPS_HMIN) and (RientroPomeridiano.MaxU >= RPS_UMIN) then
    RientroPomeridiano.Suppl:=1
  else
    RientroPomeridiano.Obbl:=1;
  //Riconoscimento buono pasto
  if (RientroPomeridiano.LavPrimaMensaTimb >= RP_LAVPRIMAPM) and (RientroPomeridiano.LavDopoMensaTimb >= RP_LAVDOPOPM) and (RientroPomeridiano.MaxUTimb >= RP_UMIN) then
    if (RientroPomeridiano.Suppl = 1) and (RientroPomeridiano.MaxUTimb >= RPS_UMIN) then
      RientroPomeridiano.BuonoPastoSuppl:=1
    else
      RientroPomeridiano.BuonoPastoObbl:=1;
end;

procedure TR502ProDtM1.z1011_MaturaRiposoCompensativo;
var i:Integer;
    Matura:Boolean;{***** Bruno 06/09/2012 *****}
begin
  if cdsT020.FieldByName('Matura_Ripcom').AsString = 'S' then
  begin
    ripcom:=debitogg - debitorp_ripcom;
    if n_giusgga > 0 then
    begin
      z752_lavscostgg;
      if (totlav = 0) or ((primat_u = 'si') and (Length(TimbratureOriginali) = 1)) then
        ripcom:=0;
    end;
  end
  //Alberto 13/08/2007: Riposi compensativi per Orbassano_HSLuigi
  else if cdsT020.FieldByName('Matura_Ripcom').AsString = 'R' then
  begin
    z752_lavscostgg;

    if XParam[XP_TC_RIPOCOM_GIUSTIF] then
    begin //maturazione per TORINO_COMUNE con giustif assenze
      (*considero tutto totlav - assenze a giornate <> E01,E02 come da seguenti specifiche:
        - giornata con timbrature, almeno 1', e giustificativi ad ore Si maturano i 12'
        - giornata in servizio esterno ad ore (codice E02) e con timbrature Si maturano i 12'
        - giornata in servizio esterno (codice E01), no timbrature Si maturano i 12'
        - giornata in servizio esterno ad ore (codice E02) e con permessi Si maturano i 12'
      *)
      for i:=1 to n_riepasse do
        if (triepgiusasse[i].ttipofruiz = 'I') and (not R180In(triepgiusasse[i].tcausasse,['E01','E02'])) then
          dec(totlav,triepgiusasse[i].tminresasse);
      if Length(TimbratureDelGiorno) = 0 then
      begin
        Matura:=False;
        for i:=1 to n_riepasse do
          if R180In(triepgiusasse[i].tcausasse,['E01','E02']) then
          begin
            Matura:=True;
            Break;
          end;
        if not Matura then
          totlav:=0;
      end;
      totlav:=max(0,totlav);
    end;

    if cdsT020.FieldByName('Debito_Ripcom').IsNull then
      ripcom:=max(0,min(debitogg,totlav) - debitorp_ripcom)
    else
      ripcom:=min(max(0,totlav - debitorp_ripcom),ValNumT020['Debito_Ripcom']);
      //ripcom:=min(ValNumT020['Debito_Ripcom'],max(0,totlav - debitogg));
      //ripcom:=max(0,min(ValNumT020['Debito_Ripcom'],totlav) - debitorp);
    if not XParam[XP_TC_RIPOCOM_GIUSTIF] then
      if n_giusgga > 0 then
      begin
        if (totlav = 0) or ((primat_u = 'si') and (Length(TimbratureOriginali) = 1)) then
          ripcom:=0;
      end;
  end;
end;

procedure TR502ProDtM1.z1012_FestivoLavorato;
{AOSTA_REGIONE}
// AOSTA_REGIONE - commessa 2012/152 - SVILUPPO 6.ini
{
const
  CP_LIQ          = 'FLLIQ'; //Causale che va subito in pagamento (no assenza)
  CP_CMP_LIQ      = 'FLRPE'; //Causale esclusa (per non turnisti) che va a recupero e può essere Richiesta in Pagamento
  CP_CMP_LIQ_TURN = 'FLRPI'; //Causale inclusa (per turnisti) che va a recupero e può essere Richiesta in Pagamento
}
// AOSTA_REGIONE - commessa 2012/152 - SVILUPPO 6.fine
var mmLavorato:Integer;
    ggLavorativo:String;
  function FestLav_GGSett:Boolean;
  begin
    if cdsT020.FieldByName('FESTLAV_GGSETT').AsString = '5' then
      Result:=giorsett in [1..5]
    else if cdsT020.FieldByName('FESTLAV_GGSETT').AsString = '6' then
      Result:=giorsett in [1..6]
    else if cdsT020.FieldByName('FESTLAV_GGSETT').AsString = 'C' then
      Result:=tipogglav = 'S';
  end;
  function RiepPres(Caus:String; Ore:Integer):Boolean;
  var i,app1,app2:Integer;
  begin
    Result:=False;
    if not CausPresAbilitato(Caus) then
      exit;
    riepcaus:=Caus;
    riepcaus_e:=0;
    riepcaus_u:=0;
    riepcausrag:=ValStrT275[Caus,'CODRAGGR'];
    riepcausrip:=ValStrT275[Caus,'INFLUCONT'];
    riepcausioe:=ValStrT275[Caus,'ORENORMALI'];
    riepcausOreGettone:=0;
    riepcaus_numtimb:=1;
    z810_rieppres(1440);
    if i810 = 0 then
      exit;
    //riporto le ore di tminlav che ricadono entro mmLavorato
    app1:=Ore;
    for i:=High(tminlav) downto 1 do
    begin
      app2:=min(tminlav[i],app1);
      inc(triepgiuspres[i810].tminpres[i],app2);
      if riepcausioe = 'A' then
      begin
        dec(tminlav[i],app2);
        inc(minlavesc,app2);
        tminstrgio[i]:=min(tminstrgio[i],tminlav[i]);
      end;
      dec(app1,app2);
    end;
    //Serve per gestire il caso di maturazione del recupero festività nel giorno non lavorato (mmLavorato = 0)
    inc(triepgiuspres[i810].tminpres[1],app1);
    Result:=True;
  end;
  procedure ResetIndTurFas;
  var i:Integer;
  begin
    if Q430.FieldByName('TGestione').AsString = '1' then
      for i:=1 to high(tindturfas) do
        tindturfas[i]:=0;
    indnotmin:=R180SommaArray(tindturfas);
  end;
begin
  if tipogg <> 'F' then
    exit;
  ggLavorativo:=tipogglav;
  if Q430.FieldByName('TGestione').AsString = '1' then
    ggLavorativo:=IfThen(gglav = 'si','S','N');
  totlav:=R180SommaArray(tminlav);
  mmLavorato:=max(0,totlav - minassenze);
  //tipogglav = Giorno lavorativo da calendario
  //2.	Diritti acquisiti per festivo che cade da Lunedì a Sabato
  if (giorsett in [1..6]) and (mmLavorato > 0) then
  begin
    {2.1. Se il giorno è lavorativo e il dipendente non ha lavorato
          ha regolarmente fruito della festività e non ha acquisito alcun altro diritto.}

    {2.2. Se il giorno è lavorativo e il dipendente ha lavorato
           matura il diritto al pagamento delle ore di straordinario con relativa maggiorazione
           o in alternativa al recupero della festività fruibile in un altro giorno, a partire dal giorno successivo al festivo non goduto.
           I turnisti non maturano l’indennità festiva}
    if (ggLavorativo = 'S') and (ggpresenza = 1) then
    begin
      //Gestire causale esclusa dalle normali, estendere anche al sabato
      if Q430.FieldByName('TGestione').AsString <> '1' then
      begin
        // AOSTA_REGIONE - commessa 2012/152 - SVILUPPO 6.ini
        RiepPres(cdsT020.FieldByName('FESTLAV_CMP_LIQ').AsString{CP_CMP_LIQ},mmLavorato);
        ResetIndTurFas;
      end
      else if (Q430.FieldByName('TGestione').AsString = '1') and (gglav = 'si') and FestLav_GGSett(*(giorsett in [1..5])*) then
      begin
        //Se turnista, considerare solo le ore all'interno del debito e non lo straordinario
        // AOSTA_REGIONE - commessa 2012/152 - SVILUPPO 6.ini
        RiepPres(cdsT020.FieldByName('FESTLAV_CMP_LIQ_TURN').AsString{CP_CMP_LIQ_TURN},min(debitogg,mmLavorato));
        ResetIndTurFas;
      end;
    end;
    {2.3.	Se il giorno non è lavorativo e il dipendente non ha lavorato
          matura il diritto a recuperare la festività in altro giorno.
          I part-time verticali non maturano alcun diritto.
          (trattandosi di lunedì-venerdì il dipendente può essere turnista o inquadrato come al punto 1.4)}

    {2.4.	Se il giorno non è lavorativo e il dipendente ha lavorato
          matura il diritto al pagamento delle ore di straordinario con relativa maggiorazione
          e in più il diritto al recupero della festività in altro giorno(*).
          I turnisti non maturano l’indennità festiva.}
    if (ggLavorativo = 'N') and (ggpresenza = 1) and (mmLavorato > 0) and FestLav_GGSett(*(giorsett in [1..5])*) then
    begin
      //RiepPres(CP_CMP,mmLavorato);
      // AOSTA_REGIONE - commessa 2012/152 - SVILUPPO 6
      RiepPres(cdsT020.FieldByName('FESTLAV_LIQ').AsString{CP_LIQ},mmLavorato);  //CP_LIQ inclusa nelle normali per trattamento come straordinario normale
      //ResetIndTurFas;  //Non serve perchè nei giorni non lav il modello orario non prevede indennità turno
      //Maturo competenza per RFINF + 1gg matr. 2926 01/11/2012 e recupera il 03/11
      //Fatto con competenze personalizzate T265P_GETCOMPETENZE
    end;
  end
end;

procedure TR502ProDtM1.z1013_ArrotondaOreCausalizzateSGM;
{SGIULIANOMILANESE_COMUNE: Arrotondamento dei riepiloghi causalizzati ai 30 minuti
A partire dalle fasce più alte, il resto viene riportato sulle fasce inferiori se significative}
var i,j,k,OreArr,Arrot,Resto:Integer;
begin
  i:=1;
  while i <= n_rieppres do
  begin
    Arrot:=R180OreMinutiExt(ValStrT275[triepgiuspres[i].tcauspres,'ARROT_RIEPGG']);
    if (triepgiuspres[i].tcauspres <> '') and (Arrot > 1) then
    begin
      for j:=n_fasce downto 2 do
        if triepgiuspres[i].tminpres[j] > 0 then
        begin
          OreArr:=Trunc(R180Arrotonda(triepgiuspres[i].tminpres[j],Arrot,'D'));
          Resto:=triepgiuspres[i].tminpres[j] - OreArr;
          for k:=j - 1 downto 1 do
            if triepgiuspres[i].tminpres[k] > 0 then
            begin
              inc(triepgiuspres[i].tminpres[k],Resto);
              dec(triepgiuspres[i].tminpres[j],Resto);
              Break;
            end;
        end;
    end;
    inc(i);
  end;
end;

procedure TR502ProDtM1.z1014_CompensoDebitoDaCausEscluse;
{AOSTA_REGIONE: le ore rese a titolo di viaggio in missione devono servire
 per compensare eventuale debito gg, anche se escluse dalle normali}
var i,j,iEU,idxCC,idxCD,mm,app,totCompCaus:Integer;
    CausComp,CausDest:String;
  procedure RestringiCoppieEU(idx,f,q:Integer);
  {Per ogni coppia causalizzata cerco i minuti resi nella fascia f, potenzialmente da abbattere}
  var iEU,app,minintersez,iniziointersez:Integer;
  begin
    if q <= 0 then
      exit;
    for iEU:=0 to High(triepgiuspres[idx].CoppiaEU) do
    begin
      minintersez:=0;
      //Test su primo range della fascia
      if (triepgiuspres[idx].CoppiaEU[iEU].U > tfasceorarie[f].tiniz1fasc) and (triepgiuspres[idx].CoppiaEU[iEU].E < tfasceorarie[j].tfine1fasc) then
      begin
        iniziointersez:=max(triepgiuspres[idx].CoppiaEU[iEU].E,tfasceorarie[f].tiniz1fasc);
        minintersez:=min(triepgiuspres[idx].CoppiaEU[iEU].U,tfasceorarie[f].tfine1fasc) - iniziointersez;
      end;
      //Test su secondo eventuale range della fascia
      if (triepgiuspres[idx].CoppiaEU[iEU].U > tfasceorarie[f].tiniz2fasc) and (triepgiuspres[idx].CoppiaEU[iEU].E < tfasceorarie[f].tfine2fasc) then
      begin
        iniziointersez:=max(triepgiuspres[idx].CoppiaEU[iEU].E,tfasceorarie[f].tiniz2fasc);
        minintersez:=min(triepgiuspres[idx].CoppiaEU[iEU].U,tfasceorarie[f].tfine2fasc) - iniziointersez;
      end;

      app:=min(q,minintersez);
      if app > 0 then
      begin
        if triepgiuspres[idx].CoppiaEU[iEU].E = iniziointersez then
          inc(triepgiuspres[idx].CoppiaEU[iEU].E,app)
        else
          dec(triepgiuspres[idx].CoppiaEU[iEU].U,app);
        dec(q,app);
        if q <= 0 then
          Break;
      end;
    end;
  end;
  procedure ApplicaMinimoCoppieEU(idx:Integer);
  {per ogni coppia causalizzata, verifico se rispetta ancora il limite dei minuti minimi}
  var iEU,f,app,scostOld:Integer;
  begin
    z964_leggicaus(triepgiuspres[idx].tcauspres);
    if (s_trovato = 'si') and (parcaus.l29_1paramet = 'B') then
      z965_SettaCausPres(tcausale)
    else
      exit;
    for iEU:=0 to High(triepgiuspres[idx].CoppiaEU) do
    begin
      app:=triepgiuspres[idx].CoppiaEU[iEU].U - triepgiuspres[idx].CoppiaEU[iEU].E;
      if (app < tcausale.tminminuti) and (app > 0) then
      begin
        if tcausale.tOreInsufficenti = 'P' then
        begin
          //Ore Perse
          z098_anom2caus(39,Format('%s min:%d < %d',[tcausale.tcaus,app,tcausale.tminminuti]));
        end
        else if tcausale.tOreInsufficenti = 'N' then
        begin
          //Ore Normali: le aggiungo a tminlav
          z752_lavscostgg;
          scostOld:=max(0,scost);
          for f:=1 to n_fasce do
            z714_suddivisioneFasce(1,triepgiuspres[idx].CoppiaEU[iEU].E,triepgiuspres[idx].CoppiaEU[iEU].U,f,tminlav);
          z752_lavscostgg;
          //aggiorno l'eccedenza solo compensabile per la parte che ha generato uno scostamento positivo
          inc(eccsolocomp,min(max(0,scost) - scostOld,app));
          z098_anom2caus(38,Format('%s min:%d < %d',[tcausale.tcaus,app,tcausale.tminminuti]));
        end;
        for f:=1 to n_fasce do
          z714_suddivisioneFasce(-1,triepgiuspres[idx].CoppiaEU[iEU].E,triepgiuspres[idx].CoppiaEU[iEU].U,f,triepgiuspres[idx].tminpres);
        triepgiuspres[idx].CoppiaEU[iEU].E:=triepgiuspres[idx].CoppiaEU[iEU].U;
        dec(minlavesc,app);
        dec(mm,app);
        if mm < 0 then
          mm:=0;
      end;
    end;
  end;
begin
  FCompDebitoCausEscluse:=0;
  z752_lavscostgg;
  if scost >= 0 then
    exit;
  mm:=-scost;
  for idxCC:=1 to n_rieppres do
  begin
    CausComp:=triepgiuspres[idxCC].tcauspres;
    (*
    if CausComp <> 'TOREV' then
      Continue;
    CausDest:='TFIMI';
    *)
    CausDest:=ValStrT275[CausComp,'CAUSCOMP_DEBITOGG'];//Inclusa nelle normali
    if CausDest = '' then
      Continue;
    if ValStrT275[CausComp,'ORENORMALI'] <> 'A' then
      Continue;
    if (CausDest <> A000LimiteMensileLiquidabile) and (ValStrT275[CausDest,'ORENORMALI'] = 'A') then
      Continue;
    if MinLavCau[CausComp] = 0 then
      Continue;
    idxCD:=0;
    if CausDest <> A000LimiteMensileLiquidabile then
    begin
      for i:=1 to n_rieppres do
        if triepgiuspres[i].tcauspres = CausDest then
          idxCD:=i;
      //Creazione riepilogo della causale di destinazione
      if (idxCD = 0) and CausPresAbilitato(CausDest) then
      begin
        inc(n_rieppres);
        idxCD:=n_rieppres;
        triepgiuspres[idxCD].tcauspres:=CausDest;
        triepgiuspres[idxCD].traggpres:=ValStrT275[CausDest,'CODRAGGR'];
        triepgiuspres[idxCD].DetPM:=0;
        triepgiuspres[idxCD].minpres0024:=0;
        for j:=1 to MaxFasceGio do triepgiuspres[idxCD].tminpres[j]:=0;
      end;
    end;
    //Compensazione da CausComp a CausDest
    totCompCaus:=0;
    for j:=1 to n_fasce do
    begin
      app:=min(mm,triepgiuspres[idxCC].tminpres[j]);
      if app <= 0 then
        Continue;
      dec(mm,app);
      dec(minlavesc,app);
      dec(triepgiuspres[idxCC].tminpres[j],app);
      RestringiCoppieEU(idxCC,j,app);
      inc(FCompDebitoCausEscluse,app);
      inc(tminlav[j],app);
      inc(totCompCaus,app);
      if idxCD > 0 then
        inc(triepgiuspres[idxCD].tminpres[j],app);
      if mm = 0 then
        Break;
    end;
    z098_anom2caus(66,Format('%s min:%d',[triepgiuspres[idxCC].tcauspres,totCompCaus]));
    ApplicaMinimoCoppieEU(idxCC);
    if mm = 0 then
      Break;
  end;

  z752_lavscostgg;
end;

procedure TR502ProDtM1.z1015_limitazione_giustdaa;
var i,E,U,Flex,TV:Integer;
    abprolT430E,abprolT430U:Boolean;
    abprolE,abprolU:Boolean;
  function GetTempoViaggioPrima(Inizio:Integer):Integer;
  var i:Integer;
  begin
    Result:=TO_CSI_TEMPO_VISITAMED;
    for i:=0 to High(TimbratureOriginali) do
    begin
      if TimbratureOriginali[i].e <= Inizio then
      begin
        Result:=min(Result,TimbratureOriginali[i].u - Inizio);
        Result:=max(0,Result);
      end;
    end;
    if Result > 0 then
    begin
      for i:=1 to n_giusdaa do
      begin
        if (tgius_dallealle[i].tcausdaa <> TO_CSI_GIUST_VISITAMED) and
           (tgius_dallealle[i].tminutida <= Inizio)
        then
        begin
          Result:=min(Result,tgius_dallealle[i].tminutia - Inizio);
          Result:=max(0,Result);
        end;
      end;
    end;
    if (Inizio - TV) < (E + Flex) then
      TV:=max(0,Inizio - (E + Flex));
  end;
  function GetTempoViaggioDopo(Fine:Integer):Integer;
  var i:Integer;
  begin
    Result:=TO_CSI_TEMPO_VISITAMED;
    for i:=0 to High(TimbratureOriginali) do
    begin
      if TimbratureOriginali[i].u >= Fine then
      begin
        Result:=min(Result,TimbratureOriginali[i].e - Fine);
        Result:=max(0,Result);
      end;
    end;
    if Result > 0 then
    begin
      for i:=1 to n_giusdaa do
      begin
        if (tgius_dallealle[i].tcausdaa <> TO_CSI_GIUST_VISITAMED) and
           (tgius_dallealle[i].tminutia >= Fine)
        then
        begin
          Result:=min(Result,tgius_dallealle[i].tminutida - Fine);
          Result:=max(0,Result);
        end;
      end;
    end;
    if (Fine + TV) > U then
      TV:=max(0,U - Fine);
  end;
  procedure AddAnomalia(IdAnom:Integer; Causale:String; minuti1,minuti2:Integer);
  begin
    z098_anom2caus(IdAnom,Format('%s(%s->%s)',[Causale,R180MinutiOre(minuti1),R180MinutiOre(minuti2)]));
  end;
  function IsGiustDaATimb(timb:Integer; verso:String):Boolean;
  var i:Integer;
  begin
    Result:=False;
    for i:=0 to High(TimbratureDelGiorno) do
      if (TimbratureDelGiorno[i].toratimb = timb) and (TimbratureDelGiorno[i].tversotimb = verso) and (TimbratureDelGiorno[i].tdagiustif) then
      begin
        Result:=True;
        Break;
      end;
  end;
begin
  if not Parametri.ModuloInstallato['TORINO_CSI_PRV'] then exit;
  if High(ttimbraturenom) <= 0 then exit;
  abprolT430E:=Q430.FieldByName('StraordE').AsString <> '0';
  abprolT430U:=Q430.FieldByName('StraordU').AsString <> '0';
  E:=ttimbraturenom[1].tminutin_e;
  U:=ttimbraturenom[1].tminutin_u;
  Flex:=ValNumT021['mmFlex',TF_PUNTI_NOMINALI,1];
  for i:=1 to n_giusdaa do
  begin
    //1025 visita medica: estensione fino a mezz'ora prima/dopo
    if Parametri.ModuloInstallato['TORINO_CSI_PRV'] and
       (tgius_dallealle[i].tcausdaa = TO_CSI_GIUST_VISITAMED) then
    begin
      //verifica di quanto può essere anticipato l'inizio del giustificativo
      TV:=GetTempoViaggioPrima(tgius_dallealle[i].tminutida);
      if TV > 0 then
      begin
        AddAnomalia(57,tgius_dallealle[i].tcausdaa,tgius_dallealle[i].tminutida,tgius_dallealle[i].tminutida - TV);
        tgius_dallealle[i].tminutida:=tgius_dallealle[i].tminutida - TV;
      end;
      //verifica di quanto può essere allungato la fine del giustificativo
      TV:=GetTempoViaggioDopo(tgius_dallealle[i].tminutia);
      if TV > 0 then
      begin
        AddAnomalia(57,tgius_dallealle[i].tcausdaa,tgius_dallealle[i].tminutia,tgius_dallealle[i].tminutia + TV);
        tgius_dallealle[i].tminutia:=tgius_dallealle[i].tminutia + TV;
      end;
    end;

    abprolE:=True;
    abprolU:=True;
    //Limitazione generale ai punti nominali dell'orario in base alle abilitazioni al prolungamento
    if Parametri.ModuloInstallato['TORINO_CSI_PRV'] and (High(ttimbraturenom) > 0) then
       //Da verificare ulteriori parametri della causale?: Sempre abilitati, da anagrafico, da causale
    begin
      abprolE:=abprolT430E;
      abprolU:=abprolT430U;
    end;
    //Limitazione dell'inizio giustificativo solo se comincia dopo 00.00
    if (not abprolE) and (tgius_dallealle[i].tminutida > 0) and (tgius_dallealle[i].tminutida < E) then
    begin
      AddAnomalia(58,tgius_dallealle[i].tcausdaa,tgius_dallealle[i].tminutida,min(E,tgius_dallealle[i].tminutia));
      tgius_dallealle[i].tminutida:=min(E,tgius_dallealle[i].tminutia);
    end;
    if (not abprolU) and (tgius_dallealle[i].tminutia > U) then
    begin
      AddAnomalia(58,tgius_dallealle[i].tcausdaa,tgius_dallealle[i].tminutia,max(U,tgius_dallealle[i].tminutida));
      tgius_dallealle[i].tminutia:=max(U,tgius_dallealle[i].tminutida);
    end;
  end;

end;

procedure TR502ProDtM1.z1016_EsclusioneOreNonLav;
{Per TORINO_CSI_PRV: nel gg festivo o domenica le ore non causalizzate non devono essere considerate nei saldi normali:
 si considera la causale (Esclusa dalle normali)}
var i:Integer;
    CausEccedenzaEsclusa:t_tcausale;
begin
  //questa procedura è in alternativa con la z1009, a seconda che esista o meno il modulo TORINO_CSI_PRV
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] and (giorsett = 7) and (tipogg = 'F') then
  begin
    z964_leggicaus(cdsT020.FieldByName('CAUSALI_ECCEDENZA').AsString);
    if (s_trovato = 'si') and (parcaus.l29_1paramet = 'B') then
      z965_SettaCausPres(CausEccedenzaEsclusa);
    for i:=1 to n_timbrdip do
    begin
      if R180In(ttimbraturedip[i].tcausale_e.tcaus,['',CAUS_PM]) then
        ttimbraturedip[i].tcausale_e:=CausEccedenzaEsclusa;
      if R180In(ttimbraturedip[i].tcausale_u.tcaus,['',CAUS_PM]) then
        ttimbraturedip[i].tcausale_u:=CausEccedenzaEsclusa;
    end;
  end;
end;

procedure TR502ProDtM1.z1017_TolleranzaPMA;
{Per TORINO_CSI: se pausa mensa con tolleranza e senza detrazione, si rende la tolleranza come già avviene per la PMT}
var i,assenza,presenza:Integer;
begin
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] and
     (ValNumT020['PMT_Tolleranza'] > 0) and (ValNumT020['mmMinimi'] = 0) and
     (*(TipoDetPaumen = 'PMA') and*) (paumenges = 'si') and (paumendet = 0) then
  begin
    presenza:=0;
    for i:=1 to n_timbrdip do
    begin
      inc(presenza,max(0,min(ttimbraturedip[i].tminutid_u,FineMensa) - max(ttimbraturedip[i].tminutid_e,InizioMensa)));
    end;
    assenza:=max(0,FineMensa - InizioMensa - presenza);
    assenza:=min(assenza,ValNumT020['PMT_Tolleranza']);
    dec(assenza,TollPMUtilizzata);
    assenza:=max(0,assenza);
    inc(tminlav[1],assenza);
    //inc(TollPMUtilizzata,assenza);//sembra che la tolleranza nata da PMA non debba rendere la maggiorazione
  end;
  if (cdsT020.FieldByName('CAUSALE_FASCE').AsString <> '') and (TollPMUtilizzata > 0) then
    z814_CausaliInFasce(cdsT020.FieldByName('CAUSALE_FASCE').AsString,InizioMensa,InizioMensa + TollPMUtilizzata);
end;

procedure TR502ProDtM1.z1018_GetCausInizioFineOrario(CausInizioFine:String; var MinutiInizio,MinutiFine:Integer; var CausaleIO,CausaleFO:t_tcausale);
begin
  //Lettura parametri in gioco
  CausaleIO:=tcausale_vuota;
  if R180In(CausInizioFine,['','I']) then
  begin
    CausaleIO.tcaus:=cdsT020.FieldByName('CAUSALE_INIZIOORARIO').AsString;
    if (CausaleIO.tcaus <> '') and CausPresAbilitato(CausaleIO.tcaus) then
    begin
      z964_leggicaus(CausaleIO.tcaus);
      if (s_trovato = 'si') and (parcaus.l29_1paramet = 'B') then
        z965_SettaCausPres(CausaleIO)
      else
        CausaleIO:=tcausale_vuota;
    end
    else
      CausaleIO.tcaus:='';
  end;

  CausaleFO:=tcausale_vuota;
  if R180In(CausInizioFine,['','F']) then
  begin
    CausaleFO.tcaus:=cdsT020.FieldByName('CAUSALE_FINEORARIO').AsString;
    if (CausaleFO.tcaus <> '') and CausPresAbilitato(CausaleFO.tcaus) then
    begin
      z964_leggicaus(CausaleFO.tcaus);
      if (s_trovato = 'si') and (parcaus.l29_1paramet = 'B') then
        z965_SettaCausPres(CausaleFO)
      else
        CausaleFO:=tcausale_vuota;
    end
    else
      CausaleFO.tcaus:='';
  end;

  MinutiInizio:=ValNumT020['MINUTICAUS_INIZIOORARIO'];
  MinutiFine:=ValNumT020['MINUTICAUS_FINEORARIO'];
end;

function TR502ProDtM1.z1018_CausalizzaInizioFineOrario(idx:Integer = -1; CausInizioFine:String = ''):Integer;
var CausaleE,CausaleU,CausaleIO,CausaleFO:t_tcausale;
    MinutiInizio,MinutiFine,i,PNOri:Integer;
    InizioFine:TPeriodoIF;
  function GetInizioFineOrario(PN:Integer):TPeriodoIF;
  var puntre,puntru:Integer;
  begin
    puntre:=ttimbraturenom[PN].tpuntre;
    puntru:=ttimbraturenom[PN].tpuntru;
    if TipoOrario <> 'E' then
    begin
      puntre:=1;
      puntru:=1;
    end;
    if puntre > 0 then
      Result.I:=ttimbraturenom[PN].tminutin_e
    else
      Result.I:=ttimbraturenom[PN].tminutin_e_ori - 1440;
    if puntru > 0 then
      Result.F:=ttimbraturenom[PN].tminutin_u
    else
      Result.F:=ttimbraturenom[PN].tminutin_u_ori + 1440;
    inc(Result.I,ttimbraturenom[PN].Flex - ttimbraturenom[PN].FlexPM);
    if puntru = 0 then
      inc(Result.F,ttimbraturenom[PN].Flex);
  end;
  procedure CausalizzaSpezzone(InizioFine:String; CausaleIFO:t_tcausale; IT,FT:Integer; var idx:Integer);
  begin
    i1:=idx;
    if R180Between(IT,ttimbraturedip[i1].tminutid_e,ttimbraturedip[i1].tminutid_u - 1) and
       R180Between(FT,ttimbraturedip[i1].tminutid_e + 1,ttimbraturedip[i1].tminutid_u) then
    begin
      z555_LibProfInterna(IT,FT); //i1 = idx + 2
      ttimbraturedip[idx + 1].tcausale_e:=CausaleIFO;
      ttimbraturedip[idx + 1].tcausale_u:=CausaleIFO;
      if cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S' then
        ttimbraturedip[idx + 1].tag:=IfThen(InizioFine = 'I','CAUSALE_INIZIOORARIO','CAUSALE_FINEORARIO');

      ttimbraturedip[idx].tcausale_e:=CausaleE;
      if (InizioFine = 'F') and (cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S') then
        ttimbraturedip[idx].tcausale_u:=CausaleU
      else
        ttimbraturedip[idx].tcausale_u:=tcausale_vuota;
      z061_appoggioc1(idx);
      if (ttimbraturedip[idx].tpuntnomin <> PNOri) and (cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'N') then
        ttimbraturedip[idx].tpuntnomin:=0;
      if (cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S') and
         (ttimbraturedip[idx].tminutid_e = ttimbraturedip[idx].tminutid_u) then
        ttimbraturedip[idx].tpuntnomin:=0;

      if (InizioFine = 'I') and (cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S') then
        ttimbraturedip[i1].tcausale_e:=CausaleE
      else
        ttimbraturedip[i1].tcausale_e:=tcausale_vuota;
      ttimbraturedip[i1].tcausale_u:=CausaleU;
      z061_appoggioc1(i1);
      if (ttimbraturedip[i1].tpuntnomin <> PNOri) and (cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'N') then
        ttimbraturedip[i1].tpuntnomin:=0;
    end
    else
    //Gestione Inizio turno compreso tra entrata ed uscita
    if R180Between(IT,ttimbraturedip[i1].tminutid_e,ttimbraturedip[i1].tminutid_u - 1) then
    begin
      z553_InizioLibProf(IT,FT); //i1 = idx + 1
      ttimbraturedip[i1].tcausale_e:=CausaleIFO;
      ttimbraturedip[i1].tcausale_u:=CausaleIFO;
      if cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S' then
        ttimbraturedip[i1].tag:=IfThen(InizioFine = 'I','CAUSALE_INIZIOORARIO','CAUSALE_FINEORARIO');
    end
    else
    //Gestione Fine turno compreso tra entrata ed uscita
    if R180Between(FT,ttimbraturedip[i1].tminutid_e + 1,ttimbraturedip[i1].tminutid_u) then
    begin
      z554_FineLibProf(IT,FT);  //i1 = idx + 1
      ttimbraturedip[idx].tcausale_e:=CausaleIFO;
      ttimbraturedip[idx].tcausale_u:=CausaleIFO;
      if cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S' then
        ttimbraturedip[idx].tag:=IfThen(InizioFine = 'I','CAUSALE_INIZIOORARIO','CAUSALE_FINEORARIO');
    end;
    idx:=i1;
  end;
begin
  //se idx > 0 vuol dire che si vuole applicare la causalizzazione sulla specifica timbratura ttimbraturedip[idx], anche se causalizzata ed esterna all'orario.
  Result:=idx;
  if cdsT020.FindField('CAUSALE_INIZIOORARIO') = nil then
    exit;

  z1018_GetCausInizioFineOrario(CausInizioFine, MinutiInizio,MinutiFine, CausaleIO,CausaleFO);
  if (MinutiInizio = 0) and (MinutiFine = 0) then
    exit;
  if (CausaleIO.tcaus = '') and (CausaleFO.tcaus = '') then
    exit;

  //Riconoscimento timbrature riferite a punti nominali teorici
  InizioFine.I:=9999;
  InizioFine.F:=0;
  if idx > 0 then
  begin
    InizioFine.I:=min(InizioFine.I,ttimbraturedip[idx].tminutid_e);
    InizioFine.F:=max(InizioFine.F,ttimbraturedip[idx].tminutid_u);
  end
  else if cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S' then
  begin
    for i:=1 to n_timbrdip do
    begin
      if (ttimbraturedip[i].tpuntnomin > 0) or ((ttimbraturedip[i].tcausale_e.tcaus = '') and (ttimbraturedip[i].tcausale_u.tcaus = '')) then
      begin
        InizioFine.I:=min(InizioFine.I,ttimbraturedip[i].tminutid_e);
        InizioFine.F:=max(InizioFine.F,ttimbraturedip[i].tminutid_u);
      end;
    end;
    if (InizioFine.I = 0) and (primat_u = 'si') and (estimbprec = 'si') and (verso_pre = 'E') then
      CausaleIO:=tcausale_vuota;
    if (InizioFine.F = 1440) and (ultimt_e = 'si') and (estimbsucc = 'si') and (verso_suc = 'U') then
      CausaleFO:=tcausale_vuota;
  end;
  if ((idx > 0) or (cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S')) and
     (InizioFine.I >= InizioFine.F) then
    exit;

  if idx > 0 then
    i:=idx
  else
    i:=1;
  while i <= n_timbrdip do
  begin
    if (idx > 0) or (ttimbraturedip[i].tpuntnomin > 0) or ((cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'S') and (ttimbraturedip[i].tcausale_e.tcaus = '') and (ttimbraturedip[i].tcausale_u.tcaus = '')) then
    begin
      if (idx <= 0) and (cdsT020.FieldByName('MINUTICAUS_PRIORITARI').AsString = 'N') then
        InizioFine:=GetInizioFineOrario(ttimbraturedip[i].tpuntnomin);
      CausaleE:=ttimbraturedip[i].tcausale_e;
      CausaleU:=ttimbraturedip[i].tcausale_u;
      PNOri:=ttimbraturedip[i].tpuntnomin;
      //Causalizzazione inizio turno
      if  (CausaleIO.tcaus <> '') and (MinutiInizio > 0)
      and ((TipoOrario <> 'E') or
           (cdsT020.FieldByName('TURNI_INIZIOORARIO').AsString.Trim = '') or
           R180InConcat(ttimbraturenom[PNOri].tpuntre.ToString,cdsT020.FieldByName('TURNI_INIZIOORARIO').AsString)
          )
      and ((idx > 0) or (i = 1) or
           (ttimbraturedip[i - 1].tpuntnomin = 0) or
           (ttimbraturedip[i - 1].tpuntnomin = ttimbraturedip[i].tpuntnomin) or
           (ttimbraturedip[i - 1].tminutid_u < ttimbraturedip[i].tminutid_e)
          )
      then
      begin
        CausalizzaSpezzone('I',CausaleIO,InizioFine.I,InizioFine.I + MinutiInizio,i);
        if (idx > 0) and (i > ieu) and (ttimbraturedip[i - 1].tcausale_e.tcaus = CausaleIO.tcaus) then
        begin
          ieu:=i - 1;
          tcausale:=ttimbraturedip[ieu].tcausale_e;
          z820_coppiecaus;
          ieu:=i;
        end;
      end;
      //Causalizzazione fine turno
      if  (i <= n_timbrdip) and (CausaleFO.tcaus <> '') and (MinutiFine > 0)
      and ((TipoOrario <> 'E') or
           (cdsT020.FieldByName('TURNI_FINEORARIO').AsString.Trim = '') or
           R180InConcat(ttimbraturenom[PNOri].tpuntru.ToString,cdsT020.FieldByName('TURNI_FINEORARIO').AsString)
          )
      and ((idx > 0) or (i = n_timbrdip) or
           (ttimbraturedip[i + 1].tpuntnomin = 0) or
           (ttimbraturedip[i + 1].tpuntnomin = ttimbraturedip[i].tpuntnomin) or
           (ttimbraturedip[i + 1].tminutid_e > ttimbraturedip[i].tminutid_u)
          )
      then
      begin
        CausalizzaSpezzone('F',CausaleFO,InizioFine.F - MinutiFine,InizioFine.F,i);
        if (idx > 0) and (i > ieu) and (ttimbraturedip[ieu + 1].tcausale_e.tcaus = CausaleFO.tcaus) then
        begin
          i:=ieu;
        end;
      end;
    end;

    if idx > 0 then
    begin
      Result:=i;
      Break;
    end
    else
      inc(i);
  end;
end;

procedure TR502ProDtM1.z1019_RiepilogoStruttureConvenzionate;
{Riepilogo ore svolte dal personale convenzionato nella struttura pianificata sulla T420-T421}
var i,k,Dalle,Alle:Integer;
begin
  SetLength(RiepStruttureConvenzionate,0);
  with selVT420 do
  begin
    First;
    while not Eof do
    try
      //Ricerca pianificazione riferita al giorno corrente
      if not R180Between(datacon,FieldByName('DECORRENZA').AsDateTime,FieldByName('DECORRENZA_FINE').AsDateTime) then
        Continue;
      if giorsett <> FieldByName('GIORNO').AsInteger then
        Continue;

      //Ricerca riepilogo della struttura
      k:=-1;
      for i:=0 to High(RiepStruttureConvenzionate) do
        if RiepStruttureConvenzionate[i].Causale = FieldByName('STRUTTURA').AsString then
        begin
          k:=i;
          Break;
        end;
      if k = -1 then
      begin
        k:=Length(RiepStruttureConvenzionate);
        SetLength(RiepStruttureConvenzionate,k + 1);
        RiepStruttureConvenzionate[k].Causale:=FieldByName('STRUTTURA').AsString;
        RiepStruttureConvenzionate[k].Descrizione:='';
        RiepStruttureConvenzionate[k].OrePianificate:=0;
        RiepStruttureConvenzionate[k].OreRese:=0;
      end;
      Dalle:=R180OreMinuti(FieldByName('DALLE').AsString);
      Alle:=R180OreMinuti(FieldByName('ALLE').AsString);
      inc(RiepStruttureConvenzionate[k].OrePianificate,Alle - Dalle);
    finally
      Next;
    end;
  end;

  //Calcolo ore svolte per le strutture pianificate nel giorno corrente
  if Length(RiepStruttureConvenzionate) = 1 then
  begin
    //Una sola struttura: riepilogo direttamente le ore svolte
    inc(RiepStruttureConvenzionate[k].OreRese,R180SommaArray(tminlav));
    //?//inc(RiepStruttureConvenzionate[k].OreRese,minlavesc);
  end
  else if n_giusgga >=1 then
  begin
    //Giornate intere di assenza: copertura di tutta la giornata
    for i:=0 to High(RiepStruttureConvenzionate) do
      RiepStruttureConvenzionate[i].OreRese:=RiepStruttureConvenzionate[i].OrePianificate;
  end
  else
  begin
    with selVT420 do
    begin
      First;
      while not Eof do
      try
        //Ricerca pianificazione riferita al giorno corrente
        if not R180Between(datacon,FieldByName('DECORRENZA').AsDateTime,FieldByName('DECORRENZA_FINE').AsDateTime) then
          Continue;
        if giorsett <> FieldByName('GIORNO').AsInteger then
          Continue;

        //Ricerca riepilogo della struttura
        k:=-1;
        for i:=0 to High(RiepStruttureConvenzionate) do
          if RiepStruttureConvenzionate[i].Causale = FieldByName('STRUTTURA').AsString then
          begin
            k:=i;
            Break;
          end;
        Dalle:=R180OreMinuti(FieldByName('DALLE').AsString);
        Alle:=R180OreMinuti(FieldByName('ALLE').AsString);

        for i:=1 to n_timbrdip do
        begin
          inc(RiepStruttureConvenzionate[k].OreRese,max(0,min(ttimbraturedip[i].tminutid_u,Alle) - max(ttimbraturedip[i].tminutid_e,Dalle)));
        end;
      finally
        Next;
      end;
    end;
  end;
end;

procedure TR502ProDtM1.z1144_strgiornalEscl;
{Gestione straordinario giornaliero Escluso dalle ore normali ed eventuali detrazioni}
var i,reso_giusdaa,detrazstrEscl:Integer;
begin
  //Per evitare di fare la detrazione 2 volte: sia strgiorn che DetPresenza vengono originati da spezzoni inclusi nelle ore normali
  if not XParam[XP_V99_Z144] then
    strgiornEscl:=max(0,strgiornEscl - DetMinLavEsc);//?? Solo per causali di tipo Straordinario....

  detrazstrEscl:=strarrdetEscl;
  reso_giusdaa:=0;
  if XParam[XP_CRV_STR_GIUSDAA] then
    for i:=1 to n_giusdaa do
      if (*(R180CarattereDef(ValStrT265[tgius_dallealle[i].tcausdaa,'INFLUCONT']) in ['A','G','C','H','I']) and*)
         (ValStrT265[tgius_dallealle[i].tcausdaa,'ESCLUSIONE'] = 'S') then
        inc(reso_giusdaa,z1006_OreEsterne(tgius_dallealle[i].tminutida,tgius_dallealle[i].tminutia));
  //if strgiorn < ValNumT020['MinGioStr'] then
  if strgiorn + strgiornEscl + reso_giusdaa < ValNumT020['MinGioStr'] then
  //Straordinario giornaliero minore del minimo
  begin
    z098_anom2caus(52,'[' + R180MinutiOre(strgiorn + strgiornEscl + reso_giusdaa) + ' < ' + R180MinutiOre(ValNumT020['MinGioStr']) + ']');
    inc(detrazstrEscl,strgiorn);
    //dec(minlavesc,strgiornEscl);
  end
  else
    if strgiorn + strgiornEscl + reso_giusdaa > ValNumT020['MaxGioStr'] then
    begin
      //Straordinario giornaliero maggiore del massimo: strgiorn è stato già abbattuto in precedenza dalla z144!
      inc(detrazstrEscl,strgiorn + strgiornEscl + reso_giusdaa - ValNumT020['MaxGioStr']);
      z098_anom2caus(23,Format('%s',[R180MinutiOre(detrazstrEscl)]));
    end
    else
    begin
      (*Niente per ore escluse dalle normali
      //Straordinario giornaliero nei range previsti
      comodo2:=strgiorn;
      per892:=strgiorn;
      arr890:=ValNumT020['ArrotGior'];
      //Arrotondamento generale giornaliero straordinario
      z892_arrotondap;
      //Calcolo eventuali detrazioni causa arrotondamento
      detrazioni:=detrazioni + comodo2 - per892;
      strarrdet:=strarrdet + comodo2 - per892;  //Alberto 13/09/2004
      *)
    end;
  detrazstrEscl:=min(detrazstrEscl,minlavesc);
  detrazstr:=detrazstrEscl;
  (*Niente per ore escluse dalle normali
  if ((cdsT020.FieldbyName('CompFascia').AsString = '3') or (cdsT020.FieldbyName('CompFascia').AsString = '4')) and
     (cdsT020.FieldByName('ARROT_COMP').AsString = 'S') then
    dec(detrazioni,strarrdet - strminimidet);
  if ((cdsT020.FieldbyName('CompFascia').AsString = '3') or (cdsT020.FieldbyName('CompFascia').AsString = '4')) and
     (cdsT020.FieldByName('MINIMISTR_COMP').AsString = 'S') then
    dec(detrazioni,strminimidet);
  *)
  //Alberto 21/02/2019: comportamento vecchio: prima si applicano le detrazioni su tminlav, e dopo le detrazioni sul riepilogo presenze
  if DetrazRiepprNorm = 'CS' then
  begin
    //Eventuali detrazioni straordinario su ore lavorate
    dec(minlavesc,detrazstrEscl);//z140_detrazioni(tminlav);
  end;
  //Eventuali detrazioni straordinario su riepilogo presenze
  z138_detrrieppr(False,True);
  //Alberto 21/02/2019: comportamento nuovo: prima si applicano le detrazioni sul riepilogo presenze, che abbattono anche tminlav, e dopo le detrazioni su tminlav per quello che rimane ancora da detrarre
  if DetrazRiepprNorm <> 'CS' then
  begin
    //Eventuali detrazioni straordinario su ore lavorate
    dec(minlavesc,detrazstrEscl);//z140_detrazioni(tminlav);
  end;
  strgiornEscl:=max(0,strgiornEscl - detrazstrEscl);
end;

procedure TR502ProDtM1.z9999_NotteUscita;
{FIRENZE_COMUNE}
var i,j,p:Integer;
    Trovato:Boolean;
    OffsetTimbNom:Byte;
begin
  if Self.Name = 'R502Ricorsivo' then
    exit;
  if not NotteSuEntrata then
    exit;
  //Alberto 03/02/2010: verifico se si deve gestire la notte sull'uscita guardando i punti nominali dell'orario
  Trovato:=False;
  for i:=1 to n_timbrnom do
    if (ttimbraturenom[i].tpuntre > 0) and (ValStrT021['NOTTE_USCITA',TF_PUNTI_NOMINALI,ttimbraturenom[i].tpuntre] = 'S') then
      Trovato:=True
    else if (ttimbraturenom[i].tpuntru > 0) and (ValStrT021['NOTTE_USCITA',TF_PUNTI_NOMINALI,ttimbraturenom[i].tpuntru] = 'S') then
      Trovato:=True;
  if not Trovato then
    exit;
  Trovato:=False;
  //Eliminazione dei dati riferiti a datacon + 1
  for i:=High(TimbConNotteU) downto 0 do
    if TimbConNotteU[i].Data = datacon + 1 then
    begin
      for j:=i + 1 to High(TimbConNotteU) do
        TimbConNotteU[j-1]:=TimbConNotteU[j];
      SetLength(TimbConNotteU,Length(TimbConNotteU) - 1);
    end;
  for i:=High(TimbDipNotteU) downto 0 do
    if TimbDipNotteU[i].Data = datacon + 1 then
    begin
      for j:=i + 1 to High(TimbDipNotteU) do
        TimbDipNotteU[j-1]:=TimbDipNotteU[j];
      SetLength(TimbDipNotteU,Length(TimbDipNotteU) - 1);
    end;
  for i:=High(TimbNomNotteU) downto 0 do
    if TimbNomNotteU[i].Data = datacon + 1 then
    begin
      for j:=i + 1 to High(TimbNomNotteU) do
        TimbNomNotteU[j-1]:=TimbNomNotteU[j];
      SetLength(TimbNomNotteU,Length(TimbNomNotteU) - 1);
    end;
  for i:=High(FasceNotteU) downto 0 do
    if FasceNotteU[i].Data = datacon + 1 then
    begin
      for j:=i + 1 to High(FasceNotteU) do
        FasceNotteU[j-1]:=FasceNotteU[j];
      SetLength(FasceNotteU,Length(FasceNotteU) - 1);
    end;

  //Elimino ttimbraturedip da considerare il giorno successivo e la aggiungo a TimbDipNotteU
  for i:=n_timbrdip downto 1 do
    if ttimbraturedip[i].tpuntnomin > 0 then
    begin
      p:=ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntre;
      if p = 0 then
        p:=ttimbraturenom[ttimbraturedip[i].tpuntnomin].tpuntru;
      if p = 0 then
        Continue;
      if ValStrT021['NOTTE_USCITA',TF_PUNTI_NOMINALI,p] = 'S' then
      begin
        SetLength(TimbDipNotteU,Length(TimbDipNotteU) + 1);
        TimbDipNotteU[High(TimbDipNotteU)].Data:=datacon + 1;
        TimbDipNotteU[High(TimbDipNotteU)].TimbDip:=ttimbraturedip[i];
        indice:=i;
        z802_toglitimbr;
      end;
    end;
  //Elimino ttimbraturecon da considerare il giorno successivo e la aggiungo a TimbConNotteU
  for i:=n_timbrcon downto 1 do
    if ttimbraturecon[i].tpuntatore > 0 then
    begin
      p:=ttimbraturenom[ttimbraturecon[i].tpuntatore].tpuntre;
      if p = 0 then
        p:=ttimbraturenom[ttimbraturecon[i].tpuntatore].tpuntru;
      if p = 0 then
        Continue;
      if ValStrT021['NOTTE_USCITA',TF_PUNTI_NOMINALI,p] = 'S' then
      begin
        for j:=1 to MaxFasceGio do
          z714_suddivisioneFasce(-1,ttimbraturecon[i].tminutic_e,ttimbraturecon[i].tminutic_u,j,tminlav);
        SetLength(TimbConNotteU,Length(TimbConNotteU) + 1);
        TimbConNotteU[High(TimbConNotteU)].Data:=datacon + 1;
        TimbConNotteU[High(TimbConNotteU)].TimbCon:=ttimbraturecon[i];
        //salvare le fasce a cui si riferisce la timbratura
        //....
        indice:=i;
        z803_toglitimbrcon;
        Trovato:=True;
      end;
    end;
  //Salvataggio punti nominali per giorno successivo
  for i:=1 to n_timbrnom do
  begin
    SetLength(TimbNomNotteU,Length(TimbNomNotteU) + 1);
    TimbNomNotteU[High(TimbNomNotteU)].Data:=datacon + 1;
    TimbNomNotteU[High(TimbNomNotteU)].TimbNom:=ttimbraturenom[i];
  end;
  //salvataggio fasce per giorno successivo
  if Trovato then
    for i:=1 to n_fasce do
    begin
      SetLength(FasceNotteU,Length(FasceNotteU) + 1);
      FasceNotteU[High(FasceNotteU)].Data:=datacon + 1;
      FasceNotteU[High(FasceNotteU)].Fasce:=tfasceorarie[i];
    end;
  if Self.Name = 'R502NotteUscita' then
    exit;
  //Verifico se esistono già i dati conteggiati il giorno prima, nel caso fosse stata fatta una notte
  if timbraturaesclusa.tminutid_u - timbraturaesclusa.tminutid_e > 0 then
  begin
    Trovato:=False;
    for i:=0 to High(TimbDipNotteU) do
      if TimbDipNotteU[i].Data = datacon then
      begin
        Trovato:=True;
        Break;
      end;
    if not Trovato then
    begin
      //Se non esistono i conteggi di ieri, ma è stata fatta una notte, si eseguono i conteggi di ieri
      //SessioneOracleR502.Name:='RICORSIONE_' + SessioneOracleR502.Name; //Alberto 04/12/2009: vedi nota sul punto analogo in z187
      //if (Self.Owner <> nil) and not(Self.Owner is TOracleDataSet) then
      if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
        R502NotteUscita:=TR502ProDtM1.Create(Self.Owner,True)
      else
        R502NotteUscita:=TR502ProDtM1.Create(SessioneOracleR502,True);
      SessioneOracleR502.Name:=StringReplace(SessioneOracleR502.Name,'RICORSIONE_','',[]);
      try
        R502NotteUscita.Name:='R502NotteUscita';
        R502NotteUscita.PeriodoConteggi(datacon-1,datacon-1);
        R502NotteUscita.ConsideraRichiesteWeb:=ConsideraRichiesteWeb;
        R502NotteUscita.Conteggi('Cartolina',ProgrCon,datacon-1);
        if R502NotteUscita.Blocca = 0 then
        begin
          for i:=0 to High(R502NotteUscita.TimbDipNotteU) do
          begin
            SetLength(TimbDipNotteU,Length(TimbDipNotteU) + 1);
            TimbDipNotteU[High(TimbDipNotteU)]:=R502NotteUscita.TimbDipNotteU[i];
          end;
          for i:=0 to High(R502NotteUscita.TimbConNotteU) do
          begin
            SetLength(TimbConNotteU,Length(TimbConNotteU) + 1);
            TimbConNotteU[High(TimbConNotteU)]:=R502NotteUscita.TimbConNotteU[i];
          end;
          for i:=0 to High(R502NotteUscita.TimbNomNotteU) do
          begin
            SetLength(TimbNomNotteU,Length(TimbNOmNotteU) + 1);
            TimbNomNotteU[High(TimbNomNotteU)]:=R502NotteUscita.TimbNomNotteU[i];
          end;
          for i:=0 to High(R502NotteUscita.FasceNotteU) do
          begin
            SetLength(FasceNotteU,Length(FasceNotteU) + 1);
            FasceNotteU[High(FasceNotteU)]:=R502NotteUscita.FasceNotteU[i];
          end;
        end;
      finally
        FreeAndNil(R502NotteUscita);
      end;
    end;
  end;
  //aggiungo le fasce del giorno precedente
  for i:=0 to High(FasceNotteU) do
    if FasceNotteU[i].Data = datacon then
    begin
      inc(n_fasce);
      tfasceorarie[n_fasce]:=FasceNotteU[i].Fasce;
      inc(tfasceorarie[n_fasce].tiniz1fasc,6000);
      inc(tfasceorarie[n_fasce].tfine1fasc,6000);
      inc(tfasceorarie[n_fasce].tiniz2fasc,6000);
      inc(tfasceorarie[n_fasce].tfine2fasc,6000);
    end;
  for i:=High(FasceNotteU) downto 0 do
    if FasceNotteU[i].Data = datacon then
    begin
      for j:=i + 1 to High(FasceNotteU) do
        FasceNotteU[j-1]:=FasceNotteU[j];
      SetLength(FasceNotteU,Length(FasceNotteU) - 1);
    end;
  //aggiungo le timbraturenom eventuali del giorno precedente (per mantenere correttamente i puntatori di ttimbraturedip e ttimrbaturecon)
  OffsetTimbNom:=max(0,n_timbrnom);
  for i:=0 to High(TimbNomNotteU) do
    if TimbNomNotteU[i].Data = datacon then
    begin
      inc(n_timbrnom);
      SetLength(ttimbraturenom,Length(ttimbraturenom) + 1);
      ttimbraturenom[n_timbrnom]:=TimbNomNotteU[i].TimbNom;
    end;
  for i:=High(TimbNomNotteU) downto 0 do
    if TimbNomNotteU[i].Data = datacon then
    begin
      for j:=i + 1 to High(TimbNomNotteU) do
        TimbNomNotteU[j-1]:=TimbNomNotteU[j];
      SetLength(TimbNomNotteU,Length(TimbNomNotteU) - 1);
    end;
  //aggiungo le timbraturecon eventuali del giorno precedente
  for i:=High(TimbConNotteU) downto 0 do
    if TimbConNotteU[i].Data = datacon then
    begin
      //Inserimento timbrature in testa a ttimbraturecon (ore + 6000????)
      for j:=n_timbrcon downto 1 do
        ttimbraturecon[j + 1]:=ttimbraturecon[j];
      inc(n_timbrcon);
      ttimbraturecon[1]:=TimbConNotteU[i].TimbCon;
      inc(ttimbraturecon[1].tminutic_e,6000);
      inc(ttimbraturecon[1].tminutic_u,6000);
      if ttimbraturecon[1].tpuntatore <> 0 then
        inc(ttimbraturecon[1].tpuntatore,OffsetTimbNom);
      //Aggiornamento tminlav
      for j:=1 to MaxFasceGio do
        z714_suddivisioneFasce(1,ttimbraturecon[1].tminutic_e,ttimbraturecon[1].tminutic_u,j,tminlav);
      //Eliminazione timbrature
      for j:=i + 1 to High(TimbConNotteU) do
        TimbConNotteU[j-1]:=TimbConNotteU[j];
      SetLength(TimbConNotteU,Length(TimbConNotteU) - 1);
    end;
  //aggiungo le timbraturedip eventuali del giorno precedente
  for i:=High(TimbDipNotteU) downto 0 do
    if TimbDipNotteU[i].Data = datacon then
    begin
      //Inserimento timbrature in testa a ttimbraturedip (ore + 6000????)
      indice:=1;
      z816_insetimbr;
      ttimbraturedip[1]:=TimbDipNotteU[i].TimbDip;
      inc(ttimbraturedip[1].tminutid_e,6000);
      inc(ttimbraturedip[1].tminutid_u,6000);
      if ttimbraturedip[1].tpuntnomin <> 0 then
        inc(ttimbraturedip[1].tpuntnomin,OffsetTimbNom);
      //Eliminazione timbrature
      for j:=i + 1 to High(TimbDipNotteU) do
        TimbDipNotteU[j-1]:=TimbDipNotteU[j];
      SetLength(TimbDipNotteU,Length(TimbDipNotteU) - 1);
      ieu:=1;
      z700_gestindenn;
    end;
end;

procedure TR502ProDtM1.Q430FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=(Q430.FieldByName('DataDecorrenza').AsDateTime <= DataCon) and (Q430.FieldByName('DataFine').AsDateTime >= DataCon);
end;

procedure TR502ProDtM1.Q265AfterOpen(DataSet: TDataSet);
begin
  R180SetVariable(selT230,'CODICE',DataSet.FieldByName('CODICE').AsString);
  selT230.Open;
  selT230.First;
end;

procedure TR502ProDtM1.Q276AfterOpen(DataSet: TDataSet);
{Caricamento Fasce a blocchi per causali di presenza (AMGAS Bari)}
var i:Integer;
    Trovato:Boolean;
begin
  SetLength(OreCausali276,0);
  SetLength(FascePaghe276,0);
  SetLength(FasceCausali276,0);
  with Q276 do
  begin
    First;
    while not Eof do
    begin
      Trovato:=False;
      for i:=0 to High(FasceCausali276) do
        if (FasceCausali276[i].Codice = FieldByName('Codice').AsString) and
           (FasceCausali276[i].TipoGiorno = FieldByName('TipoGiorno').AsString) and
           (FasceCausali276[i].Dalle = FieldByName('Dalle').AsString) and
           (FasceCausali276[i].Alle = FieldByName('Alle').AsString) then
        begin
          Trovato:=True;
          Break;
        end;
      if not Trovato then
      begin
        i:=High(FasceCausali276) + 1;
        SetLength(FasceCausali276,i + 1);
        SetLength(OreCausali276,i + 1);
        SetLength(FascePaghe276,i + 1);
        FasceCausali276[i].Codice:=FieldByName('Codice').AsString;
        FasceCausali276[i].TipoGiorno:=FieldByName('TipoGiorno').AsString;
        FasceCausali276[i].Dalle:=FieldByName('Dalle').AsString;
        FasceCausali276[i].Alle:=FieldByName('Alle').AsString;
        FasceCausali276[i].Dalle1:=R180OreMinutiExt(FasceCausali276[i].Dalle);
        FasceCausali276[i].Alle1:=R180OreMinutiExt(FasceCausali276[i].Alle);
        //Gestione fascia a cavallo di mezzanotte
        if FasceCausali276[i].Dalle1 < FasceCausali276[i].Alle1 then
        begin
          FasceCausali276[i].Dalle2:=FasceCausali276[i].Dalle1;
          FasceCausali276[i].Alle2:=FasceCausali276[i].Alle1;
        end
        else
        begin
          FasceCausali276[i].Dalle2:=0;
          FasceCausali276[i].Alle2:=FasceCausali276[i].Alle1;
          FasceCausali276[i].Alle1:=1440;
        end;
        OreCausali276[i]:=0;
        FascePaghe276[i].Ore:=0;
        FascePaghe276[i].VocePaghe:='';
      end;
      Next;
    end;
  end;
end;

procedure TR502ProDtM1.Q320AfterOpen(DataSet: TDataSet);
var i:Integer;
begin
  cdsT320.Close;
  cdsT320.FieldDefs.Assign(Q320.FieldDefs);
  cdsT320.IndexDefs.Clear;
  cdsT320.CreateDataSet;
  cdsT320.LogChanges:=False;
  while not Q320.Eof do
  begin
    cdsT320.Append;
    for i:=0 to Q320.FieldCount -1 do
      cdsT320.Fields[i].Value:=Q320.Fields[i].Value;
    cdsT320.Post;
    Q320.Next;
  end;
end;

{ TMinutiCoperti }

constructor TMinutiCoperti.Create;
begin
  Reset;
end;

destructor TMinutiCoperti.Destroy;
begin
  SetLength(Minuti,0);
end;

function TMinutiCoperti.GetCopriIntervallo(E, U: Integer): Integer;
var i:Integer;
begin
  Result:=0;
  Dimensione:=max(E,U);

  for i:=E to U do
  begin
    if Minuti[i] then
    begin
      inc(Result);
      Minuti[i]:=False;
    end;
  end;

  //Tolgo 1 se il risultato è positivo (se E=U, Result = 0)
  if Result > 0 then
    dec(Result);
  inc(FCopertura,Result);
end;

procedure TMinutiCoperti.Reset;
begin
  FCopertura:=0;
  Dimensione:=0;
  Dimensione:=1440;
end;

procedure TMinutiCoperti.SetDimensione(const Value: Integer);
var i,h:Integer;
begin
  FDimensione := Value;
  h:=High(Minuti);
  SetLength(Minuti,max(Value + 1,Length(Minuti)));
  for i:=h + 1 to High(Minuti) do
    Minuti[i]:=True;
end;

function TR502ProDtM1.EsistePrecedenteElaborazione(Firma: String): String;
var i:Integer;
begin
  Result:='';
  for i:=Low(CdzAbilitazione) to High(CdzAbilitazione) do
  begin
    if Firma = CdzAbilitazione[i].Firma then
    begin
      Result:=CdzAbilitazione[i].Risultato;
      Break;
    end;
  end;
end;

procedure TR502ProDtM1.AggiungiPrecedenteElaborazione(Firma, Risultato: String);
begin
  if EsistePrecedenteElaborazione(Firma) = '' then
  begin
    SetLength(CdzAbilitazione, Length(CdzAbilitazione) + 1);
    CdzAbilitazione[Length(CdzAbilitazione) - 1].Firma:=Firma;
    CdzAbilitazione[Length(CdzAbilitazione) - 1].Risultato:=Risultato;
  end;
end;

end.
