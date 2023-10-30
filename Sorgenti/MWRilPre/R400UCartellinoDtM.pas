unit R400UCartellinoDtM;

interface

uses
  SysUtils, Classes, DB, Math, ComCtrls, Graphics, Generics.Collections,
  OracleData, Oracle, Variants, DBClient, StrUtils,
  A000UCostanti, A000USessione, A000UInterfaccia, A027UCostanti, A029ULiquidazione, A041UInsRiposiMW, A023UTimbratureMW,
  R300UAccessiMensaDtM, R350UCalcoloBuoniDtM,
  R410UAutoGiustificazioneDtM, C180FunzioniGenerali, L021Call,
  R450, Rp502Pro, R500Lin, R600,
  QueryStorico, DatiBloccati, USelT004;

const
  TipoIndennitaTurno = '(TIPO = ''A'') OR (TIPO = ''B'') OR (TIPO = ''C'') OR (TIPO = ''D'') OR (TIPO = ''E'') OR (TIPO = ''F'') OR (TIPO = ''H'') OR (TIPO = ''I'') OR (TIPO = ''P'')';
  MaxRighe = 37;
  MaxColonne = 106;
  MAX_RPMES = 100;

  A027RPPRES_I = 951;
  A027RPPRES_F = 973;
  A027RPASS_I = 901;
  A027RPASS_F = 919;

  REC_RST = 'RST';
  REC_STRA = 'STRA';

  FMT_HHNN = 'hhnn';
  FMT_HHpNN = 'hh.nn';

type
  TSettimana = record
    Data:TDateTime;
    OreRese:String;
    Debito:String;
    Saldo:String;
    Straord:String;
  end;

  T_trppresmes = record
    tcspresmes,
    tdescpresmes,
    tsiglapresmes:String;
    //tminpresenzames.
    tminpresmes:array [1..MaxFasce] of LongInt;
  end;

  T_trpassemes = record
    tcsassemes:String;
    tdescassemes:String;
    tggassemes:Byte;
    tmgassemes:Byte;
    tminassemes:LongInt;
    tminvalassemes:LongInt;
    tmintotassemes:LongInt; //Tutte le assenze fatte (anche giornate) in minuti
    tfnretrmes:Byte; //flag Ininfluenza Fini retributivi:1 = ininfluente - 0 = no
    tCompetenze:Boolean; //Dice se calcolare le competenze o non (Ferie, Fest., ecc.)
    tCalcolato:Boolean;  //Dice se sono già state calcolate le competenze
  end;

  T_trpindpmes = record
    tcodindpmes:String;
    tggindpmes:Single;
    RestoIndSup:Single;
    RestoIndSupPrec:Single;
    Importo:Single;
    NumGGLav:Byte;
    gginiziomat,ggfinemat:TDateTime;
  end;

  T_DomenicheLavorate = record
    Data:TDateTime;
    Eccedenza:Integer;
    Posizione:Byte;
    IndFes:Integer;
  end;

  T_RiepGettoni = record
    Causale,Indennita:String;
    Spezzoni:Boolean;
    OreGettone,Minuti,Gettoni,Resto:Integer;
  end;

  T_FasceMese = record
    Codice:String;
    Maggiorazione:Byte;
  end;

  T_StrGGDelMese = record
    Giorno:Integer;
    Str:array [1..MaxFasce] of Integer;
  end;

  T_SoglieEccedenza = record
    Causale:String;
    GGLav:Boolean;
    Minuti:Integer
  end;

  TDatiGGIndTurnoI = record
    Cod:String;
    Turno1,Turno2:ShortInt;
    TotOre,PuntoNominale:Integer;
    OreRese:array [1..MaxFasce] of Integer;
  end;

  TRientriPomeridiani = record
    DovutiTeorici:Integer;
    DovutiReali:Integer;
    ResiObbligatori:Integer;
    ResiSupplementari:Integer;
    Residuo:Integer;
    Saldo:Integer;
    ResoManuale:String;
    SaldoManuale:String;
  end;

  T_RiepCaus = record
    Causale:String;
    Minuti:Integer
  end;

  TIndPres = record
    IndAss:String;
    Turno:ShortInt;
    Ind,PartTime:Real;
    OreRese,OreInt,OreMez,DebitoGG,Scostamento,OreLavPres:Integer;
    MaturaAssenze:Boolean;
    //CausAss,
    IndSpett:String;
    RiepAss:array of T_RiepCaus;
    CodInd:array[1..10] of String;
    DatiGGIndTurnoI:array of TDatiGGIndTurnoI;
  end;

  TDatiLiberiSQL = record
    Sezione,SQL,Dato:String;
    Offset:Integer;
  end;

  TSchedeAggiornate = record
    Progressivo:Integer;
    Data:TDateTime;
  end;

  TR400FCartellinoDtM = class(TDataModule)
    D950: TDataSource;
    InServizio1: TOracleDataSet;
    InServizio2: TOracleDataSet;
    Q025: TOracleDataSet;
    Q201: TOracleDataSet;
    selT162: TOracleDataSet;
    Q161: TOracleDataSet;
    Q171: TOracleDataSet;
    Q265Riep: TOracleDataSet;
    Q265Comp: TOracleDataSet;
    Q265Fest: TOracleDataSet;
    Q275: TOracleDataSet;
    Q275Riep: TOracleDataSet;
    Q305: TOracleDataSet;
    Q950Lista: TOracleDataSet;
    Q950Int: TOracleDataSet;
    Ins071: TOracleQuery;
    Ins070: TOracleQuery;
    Ins072: TOracleQuery;
    Ins073: TOracleQuery;
    Ins074: TOracleQuery;
    OperSQL: TOracleQuery;
    Ins076: TOracleQuery;
    Ins043: TOracleQuery;
    Del043: TOracleQuery;
    selT004: TOracleDataSet;
    GetIndennita_T164: TOracleQuery;
    selT164: TOracleDataSet;
    selT073: TOracleDataSet;
    selT040: TOracleDataSet;
    cdsRiepilogo: TClientDataSet;
    cdsDettaglio: TClientDataSet;
    cdsPresenze: TClientDataSet;
    cdsAssenze: TClientDataSet;
    cdsSettimana: TClientDataSet;
    selT190: TOracleDataSet;
    PG_Stampa_Banner_MondoEDP: TOracleQuery;
    selTAB_BANNER_OUT: TOracleDataSet;
    selT375: TOracleDataSet;
    selGGMax: TOracleQuery;
    selT820: TOracleDataSet;
    selT951: TOracleDataSet;
    selDatoLIberoSQL: TOracleQuery;
    selT070: TOracleDataSet;
    selT025: TOracleQuery;
    T065P_REGISTRA_RICHIESTA: TOracleQuery;
    selT072Prec: TOracleDataSet;
    T100F_GETTIMBRATURELORDE: TOracleQuery;
    selT070_T072_Prec: TOracleDataSet;
    delT065: TOracleQuery;
    T430F_CHECKIND_PLURIMENS: TOracleQuery;
    selT074ResoAnnuo: TOracleQuery;
    selT081: TOracleDataSet;
    selT027: TOracleDataSet;
    selT028: TOracleDataSet;
    selT027SelezioneAnagrafe: TOracleDataSet;
    selT162MinTurni: TOracleQuery;
    USR_T166F_GETOREMAX: TOracleQuery;
    selT166: TOracleDataSet;
    T029P_GETRIENTRIPOMERIDIANI: TOracleQuery;
    insUSR_T072: TOracleQuery;
    selGGSer: TOracleQuery;
    selGGAss: TOracleQuery;
    delT102: TOracleQuery;
    insT102: TOracleQuery;
    selT050AutStr: TOracleDataSet;
    GET_RESIDUOMESE_PT: TOracleQuery;
    T070P_AFTERINSERT: TOracleQuery;
    selT072M: TOracleDataSet;
    selI011: TOracleDataSet;
    selI011Espressione: TOracleDataSet;
    cdsAnagrafico: TClientDataSet;
    insT172: TOracleQuery;
    selT072CongEquiTurni: TOracleDataSet;
    procedure selT820FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure R400FCartellinoDtMCreate(Sender: TObject);
    procedure R400FCartellinoDtMDestroy(Sender: TObject);
    procedure Q950ListaAfterOpen(DataSet: TDataSet);
    procedure Q950ListaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    QSDatiAnagrafici       :TQueryStorico;
    DatiStorici            :String;
    FAziendaBase           :String;
    FDAziendaBase          :String;
    FPrimoPassaggioStampa  :Boolean;
    lstSchedeAggiornate    :TList<TSchedeAggiornate>;
    RECBancaOre            :Boolean;
    RECLiquidabile         :Boolean;
    AnnoCor,MeseCor,GiornoCor:Integer;
    A027Progressivo:LongInt;
    Giorno:Integer;
    i_dat1:Byte;
    r_gior:Byte;
    m_tab_timbrature_vuoto:t_ttimbraturedipmese;
    m_tab_giustificativi_vuoto:t_tgiustificdipmese;
    s_tiporiepist          :String;
    l03_tipocart           :String;
    c_tipocart_att         :String;
    c_tipocart_prec        :String;
    ncinisaldi             :TDateTime;
    ncfinsaldi             :TDateTime;
    nciniistit             :TDateTime;
    ncfinistit             :TDateTime;
    s_saltoggnontot        :String;
    debitoposm_sv          :Char;
    debitoposv_sv          :Char;
    debitopomm_sv          :LongInt;
    debpoind_sv            :String;
    //-----------------------------------------------------------------
    //Dati per totalizzazioni settimanali
    //-----------------------------------------------------------------
    deborset               :LongInt;
    salsetatt              :LongInt;
    totminset              :LongInt;
    dimoreset              :LongInt;
    straordsett            :LongInt;
    //------------------------------------------------------
    //Dati per totalizzazioni mensili
    //------------------------------------------------------
    RientriPomeridiani     :TRientriPomeridiani;
    ngginser               :Byte;
    ngglavser              :Byte;
    ngglavcal              :Integer;
    nggdetrpo              :Byte;
    nggpres                :Byte;
    nggpomer               :Byte;
    fesintmesT             :Real;
    fesridmesT             :Real;
    notggmes               :Byte;
    notminmes              :LongInt;
    nggvuoti               :Byte;
    nggpresenza            :Byte;
    nggFestiviNonGoduti    :Byte;
    NDomeniche             :Byte;
    DomenicheLavorate      :array [1..6] of T_DomenicheLavorate;
    NDomenicheServizio     :Integer;
    DomenicheServizio      :array [1..6] of TDateTime;
    NRecuperiFestivi       :Byte;
    RecuperiFestivi        :array[1..6] of Integer;
    FascePaghe276Tot       :array[0..20] of TFascePaghe;
    RiepGettoni            :array of T_RiepGettoni;
    lstIndennitaSpettanti  :TStringList;
    lstIndennitaIncompatibili:TStringList;
    trpindpmes_stampa      :array of T_trpindpmes;
    FasceMese              :array [1..MaxFasce] of T_FasceMese;
    trpturfmes             :array [0..4] of Byte;
    trpturgg1              :array [1..38] of Byte;
    trpturgg2              :array [1..38] of Byte;
    NGIndNotFes            :Byte;
    NGIndPres              :Byte;
    OreInailMes            :Integer;
    indnot_giorno          :array [1..38] of tIndNot;
    indfes_giorno          :array [1..38] of tIndFes;
    indpres_giorno         :array [1..42] of TIndPres;
    StrGGdelMese           :array of T_StrGGdelMese;
    tStrGGFasMen           :array [1..MaxFasce] of SmallInt;
    tLavGGFasMen           :array [1..MaxFasce] of SmallInt;
    tLavTurnoFasMen        :array [1..MaxFasce] of SmallInt;
    minscostset_min        :Integer;
    straordsett_mese       :Integer;
    numcorrmenset          :TDateTime;
    s_cambiomenset         :String;
    numcorrinizconte       :TDateTime;
    c_finsetprec           :Integer;
    ncinidipser            :TDateTime;
    datadeccon_sv          :LongInt;
    s_carico               :String;
    toteccliq              :LongInt;
    Riga                   :Byte;
    s_saltoggsaldi         :String;
    s_saltoggistit         :String;
    s_saltoggistit1        :String;
    SaldoTotMesePrec       :Integer;
    A029FLiq               :TA029FLiquidazione;
    SessioneOracleR400     :TOracleSession;
    TO_CSI_STR_AUT_Arrot   :Integer;
    TO_CSI_STR_AUT_Min     :Integer;
    procedure carico_c;
    procedure spostoc;
    procedure carico_t;
    procedure LeggiFasceContratto(Anno,Mese:Word);
    procedure GetCartellinoIstituti(Anno,Mese:Word);
    procedure d113_tipocart(Anno,Mese,GGDa:Word);
    procedure d115a_numcorr(Anno,Mese,GGDa,GGA:Word);
    procedure d115b_numcorr(Anno,Mese,GGDa,GGA:Word);
    procedure d116_cerco1gg;
    procedure d117_stampo(Anno,Mese,GGDa,GGA:Word);
    procedure e020_stamriga(Anno,Mese,Giorno:Integer; Stampa:Boolean);
    procedure e022_saltogg;
    procedure e025_totali;
    procedure e040_statotse(Data:TDateTime);
    procedure conte(Data:TDateTime);
    procedure finepag;
    procedure x010_azztot(Anno,Mese:Word);
    procedure x018_registraindpres;
    procedure x020_vertotalizz;
    procedure x022_totalizz;
    procedure x025_CumuloFasce;
    procedure x030_totfin;
    procedure x040_aggscheda;
    procedure x048_aggcaupre(Data:TDateTime; CP:Integer);
    procedure x058_aggindpre(Data:TDateTime; IP:Integer);
    procedure x072_indturpal;
    procedure x080_indturno;
    procedure x085_restoindennita;
    procedure x090_gettoni;
    procedure x110_RegistraStrGGdelMese;
    procedure x120_rppresenze(PG:Integer);
    procedure x130_rpassenze(AG:Integer);
    procedure x140_rpindpres(RiepilogoMensile:Boolean);
    procedure x141_riepilogaindpres(RiepilogoMensile,Somma:Boolean; codindpres:String; indpres:Single; ggprec,Tipo:Byte); //LORENA 18/04/2005
    procedure x145_rpggIndTurnoI(Indice:Integer);
    function x150_OreInail:Integer;
    procedure x300_impdatifasc(Data:TDateTime; FM:Integer);
    function EsisteInRiepilogo(X:Integer):Boolean;
    procedure GestioneDomenicaLavorata(DomenicaLavorata:T_DomenicheLavorate; Recupero:Integer);
    procedure RicalcoloIndennita_1(Tipo:String);
    procedure RicalcoloIndPres_1;
    procedure AggiungiIndPresCalcolateSucc;
    function IndennitaEsclusaT164(P:Integer; D:TDateTime; Ind:String):Boolean;
    function GetIndTurnoA:Boolean;
    function GetIndTurnoB:Boolean;
    function GetIndTurnoP:Boolean;
    function GetIndTurnoC:Boolean;
    function GetIndTurnoD(NumInd,NumGGTot:Integer):Boolean;
    function GetIndTurnoE(NumInd:Integer):Boolean;
    function GetIndTurnoF(NumInd:Integer):Integer;
    function GetIndTurnoH(rpind:Integer):Single; //LORENA 01/04/2005
    function GetIndTurnoI(NumInd:Integer):Single;
    function MaturaIndTurno(Esp:String):Boolean;
    procedure CalcolaRientriPomeridiani;
    procedure SalvaRientriPomeridiani;
    procedure SalvaStraordinarioPT(OreSuppl,OreStr:Integer);
    procedure SalvaCompensabileMeseEff(Causale:String; OreComp:Integer);
    procedure SalvaNegativiCompensabili;
    function FormattaTimbratura(S:String; T:t_ttimbraturedipmese; var Indice:Integer):String;
    function FormattaTimbratura2(S:String; T:t_ttimbraturedipmese; Indice:Integer):String;
    procedure PulisciRiepilogoAssenze;
    procedure CompletaRiepilogoAssenze;
    procedure QuickSortRiepAss(iLo, iHi: Integer);
    procedure QuickSortRiepPres(iLo, iHi: Integer);
    function GetRiepilogoPresenze(Codice,Descrizione,Sigla:String; Aggiungi:Boolean = True):Integer;
    procedure EliminaRiepilogoPresenze(Codice:String);
    procedure LimitiMensiliCausalizzati;
    procedure CompletaRiepilogoPresenze;
    procedure CompensazioneScostNegativi;
    procedure LimitiAnnualiCausali;
    procedure SoglieEccedenza;
    procedure ScriviTotaliGiornalieri;
    procedure CaricaCdsAssenze(Chiave:String; Dal,Al:TDateTime);
    function  GetInizioAssenze:TDateTime;
    function  GetFineAssenze:TDateTime;
    procedure DeleteT102(Progressivo:Integer; Data:TDateTime; Dato:String = ''; Causale:String = '');
    procedure InsertT102(Progressivo:Integer; Mese,GG:TDateTime; Dato,Valore:String; Causale:String = ''; Dalle:String = ''; Alle:String = '');
    function  GetT050AutStr(P:Integer; D:TDateTime):Integer;
    function  GetEsisteAnomBloccante:Boolean;
    procedure SetPrimoPassaggioStampa(const Value: Boolean);
    procedure AddSchedeAggiornate(Progressivo:Integer; Data:TDateTime);
    procedure DatiAtipici;
  public
    { Public declarations }
    R300DtM:TR300FAccessiMensaDtM;
    R350DtM:TR350FCalcoloBuoniDtM;
    R410FAutoGiustificazioneDtM: TR410FAutoGiustificazioneDtM;
    R450DtM1:TR450DtM1;
    R502ProDtM1:TR502ProDtM1;
    R600DtM1:TR600DtM1;
    A041MW:TA041FInsRiposiMW;
    A023MW:TA023FTimbratureMW;
    A027SelAnagrafe:TOracleDataSet;
    lstDettaglio,lstRiepilogo,lstAnomalie:TStringList;
    lstAnomalieMM:TList<TAnomalieGG>;
    AnomalieBloccantiExtra:String;
    selT004Img:TselT004;
    DataDa,DataA:TDateTime;
    LungTimb:Integer;
    AutoGiustificazione    :Boolean;
    AbbattiBancaOre        :Boolean;  //solo per TORINO_CSI_PRV
    AggiornamentoScheda    :Boolean;
    SoloAggiornamento      :Boolean;
    EludiBloccoRiepiloghi  :Boolean;
    CalcoloCompetenze      :Boolean;
    IgnoraAnomalie         :Boolean;
    AnomaliaBloccante      :Boolean;
    RiepilogoBuoniPasto    :Boolean;
    RiepilogoAccessiMensa  :Boolean;
    InserimentoRiposi      :Boolean;
    ParametrizzazioniTipoCar:Boolean;
    StampaFileTesto        :Boolean;
    c03_tipocart           :String;
    dipinser1              :String;
    RiepTotLav             :LongInt;
    RiepScost              :LongInt;
    RiepScostNeg           :LongInt;
    RiepScostPos           :LongInt;
    RiepCompGG             :LongInt;
    RiepCompNegGG          :LongInt;
    RiepMinlavEsc          :LongInt;
    RiepMinlavCau          :LongInt;
    RiepMinlavCau2         :LongInt;
    RiepMinlavCau3         :LongInt;
    RiepEccedIterDisp      :LongInt;
    RiepDebitoGG           :LongInt;
    RiepDebitoGO           :LongInt;
    RiepDebitoM            :LongInt;
    RiepScostDebito        :LongInt;
    RiepOreLorde           :LongInt;
    RiepProlInib           :LongInt;
    RiepProlNonCaus        :LongInt;
    RiepProlENonCaus       :LongInt;
    RiepProlUNonCaus       :LongInt;
    RiepProlNonCont        :LongInt;
    RiepProlNonCausUscita  :LongInt;
    RiepPastiConv          :LongInt;
    RiepPastiInt           :LongInt;
    RiepBuoniPasto         :LongInt;
    RiepFeNNG              :LongInt;
    RiepPauMenDet          :Integer;
    RiepPresenzaObbligatoria:Integer;
    RiepPresenzaFacoltativa :Integer;
    RiepCarenzaObbligatoria :Integer;
    RiepCarenzaFacoltativa  :Integer;
    RiepScostFacoltativa    :Integer;
    RiepIndPres             :Real;
    RiepIndFest             :Real;
    RiepIndNot              :Integer;
    RiepNumNot              :Integer;
    RiepCoperturaCarenza    :Integer;
    n_rppresmes            :Integer;
    trppresmes             :array [1..MAX_RPMES] of T_trppresmes;
    trppresauto            :array of T_trppresmes;
    n_rpassemes            :Integer;
    trpassemes             :array [1..MAX_RPMES] of T_trpassemes;
    n_rpindpmes            :Integer;
    trpindpmes             :array [1..MAX_RPMES] of T_trpindpmes;
    tindturfasmes          :array [1..MaxFasce] of LongInt;
    totstrfascia           :array [1..MaxFasce] of LongInt;
    totminlavmes           :array [1..MaxFasce] of LongInt;
    VetRiepStampa:array[1..LENGTH_DATIRIEP] of String;
    VetDomenica:array[1..MaxRighe] of Integer;
    VetDatiLiberiSQL:array of TDatiLiberiSQL;
    MatDettStampa:array[1..MaxRighe,1..MaxColonne] of string;
    TotMese:array[1..35] of String;
    StrFasceStampa:string;
    CampiIntestazione,ParStampaCartellino:String;
    selDatiBloccati:TDatiBloccati;
    NumGiorniCartolina:Byte;
    TotSett:array[0..5] of TSettimana;
    function EsisteDato(X:Integer):Boolean;
    procedure carico(Anno,Mese:Word);
    function  GetDescGiust(S:String):String;
    function  GetSiglaGiust(S:String):String;
    function  GetTimbMensa(m_datacon:TDateTime):String;
    procedure CartolinaDipendente(Progressivo:LongInt; Anno,Mese,GGDa,GGA:Word);
    procedure CreaClientDataSet(ODS:TOracleDataSet);
    procedure CaricaClientDataSet(Dal,Al:TDateTime);
    procedure LeggiDatiRichiesti(Sender:String);
    function  GetDatoRiepPresenze(i:Integer; Dato:String; Fasce:Boolean):String;
    function  GetTagDatoLiberoSQL(Sezione,SQL:String):Integer;
    procedure CercaParametrizzazione(Progressivo:Integer;Data:TDateTime);
    function  CheckValidazione2Parametrizzazione(Progressivo:LongInt; Data1,Data2:TDateTime):String;
    function  CheckAggiornamentoAbilitato(Progressivo: Integer; Data:TDateTime):Boolean;
    procedure ScriptAggSchedaAfter(Progressivo: Integer; Data:TDateTime);
    function  ExistsSchedeAggiornate(Progressivo:Integer; Data:TDateTime):Boolean;
    function RichiestePendenti: Boolean;
    procedure GetDatiLiberiSQL;
    property InizioIstituti:TDateTime read nciniistit;
    property FineIstituti:TDateTime read ncfinistit;
    property InizioSaldi:TDateTime read ncinisaldi;
    property FineSaldi:TDateTime read ncfinsaldi;
    property InizioAssenze:TDateTime read GetInizioAssenze;
    property FineAssenze:TDateTime read GetFineAssenze;
    property AziendaBase:String read FAziendaBase;
    property EsisteAnomBloccante:Boolean read GetEsisteAnomBloccante;
    property PrimoPassaggioStampa:Boolean read FPrimoPassaggioStampa write SetPrimoPassaggioStampa;
  end;

//var R400FCartellinoDtM: TR400FCartellinoDtM;

implementation

{$R *.DFM}

procedure TR400FCartellinoDtM.R400FCartellinoDtMCreate(Sender: TObject);
{Preparo le query}
var i:Integer;
begin
  SessioneOracleR400:=SessioneOracle;
  selT004Img:=TselT004.Create(Self);
  if Self.Owner <> nil then
    if Self.Owner is TOracleSession then
      SessioneOracleR400:=Self.Owner as TOracleSession;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracleR400;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracleR400;
    end;
  if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
  begin
    R450DtM1:=TR450DtM1.Create(Self.Owner);
    R600DtM1:=TR600DtM1.Create(Self.Owner);
    R410FAutoGiustificazioneDtM:=TR410FAutoGiustificazioneDtM.Create(Self.Owner);
  end
  else
  begin
    R450DtM1:=TR450DtM1.Create(SessioneOracleR400);
    R600DtM1:=TR600DtM1.Create(SessioneOracleR400);
    R410FAutoGiustificazioneDtM:=TR410FAutoGiustificazioneDtM.Create(SessioneOracleR400);
  end;
  R600DtM1.TO_CSI_SaltaSettimanaCorrente:=False;
  R502ProDtM1:=R600DtM1.R502ProDtM1;
  R300DtM:=nil;
  R350DtM:=nil;
  A041MW:=nil;
  A023MW:=nil;
  {$IFNDEF WEBSVC}
  A023MW:=TA023FTimbratureMW.Create(nil);
  {$ENDIF}
  Q025.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  selT162.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q950Lista.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q265Riep.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q265Comp.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q275Riep.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q305.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  selT951.BeforeOpen:=TSessioneIrisWIN.BeforeOpenEvent;
  Q025.Open;
  selT162.Filtered:=True;
  selT162.Open;
  Q161.Open;
  selT164.Open;
  Q950Lista.Open;
  Q265Riep.Open;
  Q265Comp.Open;
  Q265Fest.Open;
  Q275.Open;
  Q275Riep.Open;
  Q305.Open;
  //Alberto: gestisco errore in apertura se in uso su DB che non supportano il tipo BLOB
  try
    selT004.Open;
  except
  end;
  QSDatiAnagrafici:=TQueryStorico.Create(Self);
  QSDatiAnagrafici.Session:=SessioneOracleR400;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  AutoGiustificazione:=False;
  AggiornamentoScheda:=False;
  EludiBloccoRiepiloghi:=False;
  IgnoraAnomalie:=True;
  RiepilogoBuoniPasto:=False;
  RiepilogoAccessiMensa:=False;
  ParametrizzazioniTipoCar:=False;
  StampaFileTesto:=False;
  RECBancaOre:=False;
  RECLiquidabile:=False;
  lstIndennitaSpettanti:=TStringList.Create;
  lstIndennitaIncompatibili:=TStringList.Create;
  lstDettaglio:=TStringList.Create;
  lstRiepilogo:=TStringList.Create;
  lstAnomalie:=TStringList.Create; // validazione web - daniloc 19.03.2012
  lstAnomalieMM:=TList<TAnomalieGG>.Create;
  lstSchedeAggiornate:=TList<TSchedeAggiornate>.Create;
  AnomalieBloccantiExtra:='';
  if Parametri.CampiRiferimento.C9_ScaricoPaghe = '' then
    selT190.SetVariable('INTERFACCIA','''<INTERFACCIA UNICA>''')
  else
  begin
    selT190.SetVariable('INTERFACCIA','(SELECT ' + Parametri.CampiRiferimento.C9_ScaricoPaghe + ' FROM T430_STORICO WHERE PROGRESSIVO = :PROGRESSIVO AND :DATA BETWEEN DATADECORRENZA AND DATAFINE)');
    selT190.DeclareVariable('PROGRESSIVO',otInteger);
    selT190.DeclareVariable('DATA',otDate);
  end;
end;

function TR400FCartellinoDtM.GetTagDatoLiberoSQL(Sezione,SQL:String):Integer;
var H,Offset:Integer;
begin
  SetLength(VetDatiLiberiSQL,Length(VetDatiLiberiSQL) + 1);
  H:=High(VetDatiLiberiSQL);
  Offset:=2000;
  if Sezione = 'FOOTER' then
    Offset:=1000;
  VetDatiLiberiSQL[H].Offset:=Offset + 1;
  VetDatiLiberiSQL[H].Sezione:=Sezione;
  VetDatiLiberiSQL[H].SQL:=SQL;
  Result:=Length(VetDatiLiberiSQL) + Offset;//2000;
end;

procedure TR400FCartellinoDtM.CreaClientDataSet(ODS:TOracleDataSet);
var i,dimensione:Integer;
begin
  with cdsRiepilogo do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Dal',ftDate,0,False);
    FieldDefs.Add('Al',ftDate,0,False);
    FieldDefs.Add('Data_Cartellino',ftString,20,False);
    FieldDefs.Add('Ragione_Sociale',ftString,200,False);
    FieldDefs.Add('Fasce_Cartellino',ftString,25,False);
    for i:=Low(TotMese) to High(TotMese) do
      FieldDefs.Add('TotGG' + IntToStr(i),ftString,30,False);
    for i:=Low(VetRiepStampa) to High(VetRiepStampa) do
      FieldDefs.Add('Campo' + IntToStr(i),ftString,60,False);
    for i:=Low(VetDatiLiberiSQL) to High(VetDatiLiberiSQL) do
      //FieldDefs.Add('Campo' + IntToStr(2001 + i),ftString,40,False);
      FieldDefs.Add('Campo' + IntToStr(VetDatiLiberiSQL[i].Offset + i),ftString,200,False);
    if (ODS <> nil) and (ODS.Active) then
      for i:=0 to ODS.FieldDefs.Count - 1 do
        if Length(ODS.FieldDefs[i].Name) <= 30 then
          //Alberto 31/07/2010: Dichiaro solo i campi effettivamente utilizzati in CampiIntestazione
          if Pos(',' + UpperCase(ODS.FieldDefs[i].Name) + ',',',' + UpperCase(CampiIntestazione) + ',') > 0 then
            FieldDefs.Add(ODS.FieldDefs[i].Name,ODS.FieldDefs[i].DataType,ODS.FieldDefs[i].Size,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
    for i:=0 to FieldCount - 1 do
      Fields[i].Visible:=False;
  end;
  with cdsAnagrafico do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Assign(cdsRiepilogo.FieldDefs);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
    for i:=0 to FieldCount - 1 do
      Fields[i].Visible:=False;
  end;
  with cdsDettaglio do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Chiave2',ftString,30,False);
    FieldDefs.Add('Progressivo',ftInteger,0,False);
    FieldDefs.Add('Data',ftDate,0,False);
    for i:=Low(MatDettStampa[1]) to High(MatDettStampa[1]) do
    begin
      Dimensione:=10;
      if i in [C_TI1..C_TI8] then
        Dimensione:=300
      else if i in [C_GI1] then
        Dimensione:=100
      else if i in [C_GI2] then
        Dimensione:=400
      else if i in [C_EC1..C_EC2,C_IT1..C_IT2,C_LF1] then
        Dimensione:=30
      else if i in [C_ECCAUTF1..C_CAUF6] then
        Dimensione:=40
      else if i in [C_ANM,C_LPR] then
        Dimensione:=500
      else if i in [C_TM1] then
        Dimensione:=100
      else if i in [C_NOTE] then
        Dimensione:=2000
      else if i in [C_RICHIESTE] then
        Dimensione:=100;
      FieldDefs.Add('Campo' + IntToStr(i),ftString,Dimensione,False);
    end;
    IndexDefs.Clear;
    //IndexDefs.Add('Primario',('Gruppo;Nome;Badge;Matricola;Progressivo;Data;CodTurno'),[ixUnique]);
    //IndexName:='Primario';
    CreateDataSet;
    LogChanges:=False;
    for i:=0 to FieldCount - 1 do
      Fields[i].Visible:=False;
  end;
  with cdsSettimana do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave2',ftString,30,False);
    FieldDefs.Add('Progressivo',ftInteger,0,False);
    FieldDefs.Add('Data',ftDate,0,False);
    FieldDefs.Add('Reso',ftString,8,False);
    FieldDefs.Add('Debito',ftString,8,False);
    FieldDefs.Add('Saldo',ftString,8,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
    for i:=0 to FieldCount - 1 do
      Fields[i].Visible:=False;
  end;
  with cdsPresenze do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Progressivo',ftInteger,0,False);
    for i:=A027RPPRES_I to A027RPPRES_F do
      FieldDefs.Add('Campo' + IntToStr(i),ftString,40,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
    for i:=0 to FieldCount - 1 do
      Fields[i].Visible:=False;
  end;
  with cdsAssenze do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Progressivo',ftInteger,0,False);
    for i:=A027RPASS_I to A027RPASS_F do
      FieldDefs.Add('Campo' + IntToStr(i),ftString,40,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
    for i:=0 to FieldCount - 1 do
      Fields[i].Visible:=False;
  end;
end;

procedure TR400FCartellinoDtM.CaricaClientDataSet(Dal,Al:TDateTime);
var ng,i:Integer;
    d:TDateTime;
    Chiave,Timbrature:String;
begin
  Chiave:=FormatDateTime('yyyymm',Dal) + '_' + IntToStr(A027Progressivo);
  //Riepilogo: dati anagrafici e consuntivi mensili
  cdsRiepilogo.Append;
  cdsRiepilogo.FieldByName('CHIAVE').AsString:=Chiave;
  cdsRiepilogo.FieldByName('DAL').AsDateTime:=Dal;
  cdsRiepilogo.FieldByName('AL').AsDateTime:=Al;
  cdsRiepilogo.FieldByName('DATA_CARTELLINO').AsString:=UpperCase(R180NomeMese(R180Mese(Dal))) + ' ' + IntToStr(R180Anno(Dal));
  cdsRiepilogo.FieldByName('RAGIONE_SOCIALE').AsString:=Parametri.RagioneSociale;
  if not R180In(FAziendaBase,['',T440AZIENDA_BASE]) then
    cdsRiepilogo.FieldByName('RAGIONE_SOCIALE').AsString:=FDAziendaBase;
  cdsRiepilogo.FieldByName('FASCE_CARTELLINO').AsString:=StrFasceStampa;
  for i:=0 to A027selAnagrafe.FieldCount - 1 do
    try
      if cdsRiepilogo.FindField(A027selAnagrafe.Fields[i].FieldName) <> nil then
        cdsRiepilogo.FieldByName(A027selAnagrafe.Fields[i].FieldName).Value:=A027selAnagrafe.Fields[i].Value;
    except
    end;
  for i:=Low(TotMese) to High(TotMese) do
    cdsRiepilogo.FieldByName('TOTGG' + IntToStr(i)).AsString:=TotMese[i];
  for i:=Low(VetRiepStampa) to High(VetRiepStampa) do
  begin
    cdsRiepilogo.FieldByName('CAMPO' + IntToStr(i)).AsString:=VetRiepStampa[i];
  end;
  for i:=Low(VetDatiLiberiSQL) to High(VetDatiLiberiSQL) do
  begin
    //cdsRiepilogo.FieldByName('CAMPO' + IntToStr(2001 + i)).AsString:=VetDatiLiberiSQL[i].Dato;
    cdsRiepilogo.FieldByName('CAMPO' + IntToStr(VetDatiLiberiSQL[i].Offset + i)).AsString:=VetDatiLiberiSQL[i].Dato;
    cdsRiepilogo.FieldByName('CAMPO' + IntToStr(VetDatiLiberiSQL[i].Offset + i)).Visible:=True;
  end;
  cdsRiepilogo.Post;

  //Dati anagrafici per Accessibilità non vedenti
  cdsAnagrafico.Append;
  for i:=0 to cdsRiepilogo.FieldCount - 1 do
    cdsAnagrafico.Fields[i].Value:=cdsRiepilogo.Fields[i].Value;
  cdsAnagrafico.Post;
  cdsAnagrafico.FieldByName('DATA_CARTELLINO').DisplayLabel:='Data del cartellino';
  cdsAnagrafico.FieldByName('DATA_CARTELLINO').Visible:=True;

  //Dati giornalieri
  d:=ncinisaldi;
  for ng:=1 to NumGiorniCartolina do
  begin
    cdsDettaglio.Append;
    cdsDettaglio.FieldByName('CHIAVE').AsString:=Chiave;
    cdsDettaglio.FieldByName('CHIAVE2').AsString:=Chiave + '_' + FormatDateTime('ddmmyyyy',d);
    //cdsDettaglio.FieldByName('PROGRESSIVO').AsInteger:=A027Progressivo;
    cdsDettaglio.FieldByName('DATA').AsDateTime:=d;
    for i:=Low(MatDettStampa[1]) to High(MatDettStampa[1]) do
    begin
      if i in [C_TI1..C_TI8] then
      //Gestione timbrature formattate + anomalie
      begin
        Timbrature:=MatDettStampa[ng,i];
        if Trim(MatDettStampa[ng,C_ANM]) <> '' then
          TImbrature:=Timbrature + #13 + MatDettStampa[ng,C_ANM];
        cdsDettaglio.FieldByName('CAMPO' + IntToStr(i)).AsString:=Timbrature;
      end
      else
        cdsDettaglio.FieldByName('CAMPO' + IntToStr(i)).AsString:=MatDettStampa[ng,i];
    end;
    cdsDettaglio.Post;
    d:=d + 1;
  end;
  //Totali settimanali
  if c03_tipocart = 'S' then
    for i:=0 to NumGiorniCartolina div 7 do
      if TotSett[i].Data > 0 then
      begin
        cdsSettimana.Append;
        cdsSettimana.FieldByName('CHIAVE2').AsString:=Chiave + '_' + FormatDateTime('ddmmyyyy',TotSett[i].Data);
        cdsSettimana.FieldByName('RESO').AsString:=TotSett[i].OreRese;
        cdsSettimana.FieldByName('DEBITO').AsString:=TotSett[i].Debito;
        cdsSettimana.FieldByName('SALDO').AsString:=TotSett[i].Saldo;
        cdsSettimana.Post;
      end;

  //Riepilogo presenze
  selT190.Close;
  if selT190.VariableIndex('PROGRESSIVO') >= 0 then
    selT190.SetVariable('PROGRESSIVO',A027Progressivo);
  if selT190.VariableIndex('DATA') >= 0 then
    selT190.SetVariable('DATA',Al);
  selT190.Open;

  for i:=1 to n_rppresmes do
  begin
    if VarToStr(Q275Riep.Lookup('Codice',trppresmes[i].tcspresmes,'Stampe')) = 'B' then
      Continue;
    if Pos(',' + trppresmes[i].tcspresmes + ',',',' + Q950Int.FieldByName('CAUPRES_ESCLUSE').AsString + ',') > 0 then
      Continue;
    if not A000FiltroDizionario('CAUSALI SUL CARTELLINO',trppresmes[i].tcspresmes) then
      Continue;
    cdsPresenze.Append;
    cdsPresenze.FieldByName('CHIAVE').AsString:=Chiave;
    //cdsPresenze.FieldByName('PROGRESSIVO').AsInteger:=A027Progressivo;
    cdsPresenze.FieldByName('CAMPO951').AsString:=GetDatoRiepPresenze(i,'CODICE',False);
    cdsPresenze.FieldByName('CAMPO952').AsString:=GetDatoRiepPresenze(i,'DESCRIZIONE',False);
    cdsPresenze.FieldByName('CAMPO953').AsString:=GetDatoRiepPresenze(i,'FATTO_MESE',True);
    cdsPresenze.FieldByName('CAMPO954').AsString:=GetDatoRiepPresenze(i,'FATTO_MESE',False);
    cdsPresenze.FieldByName('CAMPO955').AsString:=GetDatoRiepPresenze(i,'SIGLA',False);
    cdsPresenze.FieldByName('CAMPO956').AsString:=GetDatoRiepPresenze(i,'FATTO_ANNO',True);
    cdsPresenze.FieldByName('CAMPO957').AsString:=GetDatoRiepPresenze(i,'FATTO_ANNO',False);
    cdsPresenze.FieldByName('CAMPO958').AsString:=GetDatoRiepPresenze(i,'LIQUIDABILE_ANNO',True);
    cdsPresenze.FieldByName('CAMPO959').AsString:=GetDatoRiepPresenze(i,'LIQUIDABILE_ANNO',False);
    cdsPresenze.FieldByName('CAMPO960').AsString:=GetDatoRiepPresenze(i,'LIQUIDATO_MESE',True);
    cdsPresenze.FieldByName('CAMPO961').AsString:=GetDatoRiepPresenze(i,'LIQUIDATO_MESE',False);
    cdsPresenze.FieldByName('CAMPO962').AsString:=GetDatoRiepPresenze(i,'LIQUIDATO_ANNO',True);
    cdsPresenze.FieldByName('CAMPO963').AsString:=GetDatoRiepPresenze(i,'LIQUIDATO_ANNO',False);
    cdsPresenze.FieldByName('CAMPO964').AsString:=GetDatoRiepPresenze(i,'RESIDUO',True);
    cdsPresenze.FieldByName('CAMPO965').AsString:=GetDatoRiepPresenze(i,'RESIDUO',False);
    cdsPresenze.FieldByName('CAMPO966').AsString:=GetDatoRiepPresenze(i,'COMP_MESE_REG',False);
    cdsPresenze.FieldByName('CAMPO967').AsString:=GetDatoRiepPresenze(i,'COMP_MESE_EFF',False);
    cdsPresenze.FieldByName('CAMPO968').AsString:=GetDatoRiepPresenze(i,'COMP_ANNO_REG',False);
    cdsPresenze.FieldByName('CAMPO969').AsString:=GetDatoRiepPresenze(i,'COMP_ANNO_EFF',False);
    cdsPresenze.FieldByName('CAMPO970').AsString:=GetDatoRiepPresenze(i,'RECUPERO_MESE',False);
    cdsPresenze.FieldByName('CAMPO971').AsString:=GetDatoRiepPresenze(i,'RECUPERO_ANNO',False);
    cdsPresenze.FieldByName('CAMPO972').AsString:=GetDatoRiepPresenze(i,'ORE_PERSE',True);
    cdsPresenze.FieldByName('CAMPO973').AsString:=GetDatoRiepPresenze(i,'ORE_PERSE',False);
    cdsPresenze.Post;
  end;
  CaricaCdsAssenze(Chiave,Dal,Al);
  cdsRiepilogo.First;
  cdsDettaglio.First;
  cdsPresenze.First;
  cdsAssenze.First;
end;

//function TR400FCartellinoDtM.FormattaTimbrature(T:String):String;
(*var i:Integer;
    RETimb:TCustomRichEdit;*)
//begin
//  Result:=T;
  (*RETimb:=TCustomRichEdit.Create(Self);
  RETimb.Lines.Text:=T;
  RETimb.SelStart:=1;
  RETimb.SelLength:=Length(T);
  RETimb.SelAttributes.Style:=[];
  i:=1;
  while i <= Length(T) do
  begin
    RETimb.SelStart:=i;
    RETimb.SelLength:=LungTimb - 1;
    //RETimb.SelAttributes.Style:=[];
    if (T[i] = 'e') or (T[i] = 'u') then
      //Timbratura manuale
      RETimb.SelAttributes.Style:=[fsBold]
    else
      RETimb.SelAttributes.Style:=[];
    i:=i + LungTimb + 1;
  end;
  Result:=RETimb.Lines.Text;
  //
  FreeAndNil(RETimb);*)
//end;

procedure TR400FCartellinoDtM.CaricaCdsAssenze(Chiave:String; Dal,Al:TDateTime);
var i:Integer;
    G:TGiustificativo;
  procedure RiepilogaAssenze(i:Integer; RifDataNas:Boolean; DataNas:TDateTime);
  var CodCausale,DescCausale,UM:String;
      Quantita,OreRese:Real;
  begin
    CodCausale:=G.Causale;
    DescCausale:=Trim(trpassemes[i].tdescassemes);
    if RifDataNas then
    begin
      R600DtM1.GetQuantitaAssenze(A027Progressivo,DataDa,DataA,DataNas,G,UM,Quantita,OreRese);
      CodCausale:=CodCausale + '*' + R600DtM1.RiferimentoDataNascita.IDFamiliare;
      DescCausale:=R600DtM1.RiferimentoDataNascita.IDFamiliare + '*' + DescCausale;
    end;
    //Calcolo competenze o unità di misura
    if (not RifDataNas) and ((not trpassemes[i].tCompetenze) or (not CalcoloCompetenze)) then
      //Non devo calcolare le competenze: leggo solo l'unità di misura
//      UM:=R600DtM1.GetUnitaMisura(A027Progressivo,DataA,G)  Lorena 20/12/2005
      //R600DtM1.GetQuantitaAssenze(A027Progressivo,DataDa,DataA,DataNas,G,UM,Quantita,OreRese)  //Lorena 20/12/2005
      R600DtM1.GetQuantitaAssenze(A027Progressivo,InizioAssenze,FineAssenze,DataNas,G,UM,Quantita,OreRese)  //Lorena 20/12/2005
    else if trpassemes[i].tCompetenze then
    begin
      //Calcolo le competenze se non le ho già calcolate
      if not trpassemes[i].tCalcolato then
      begin
        if not RifDataNas then  //Lorena 20/12/2005
          //R600DtM1.GetQuantitaAssenze(A027Progressivo,DataDa,DataA,DataNas,G,UM,Quantita,OreRese);  //Lorena 20/12/2005
          R600DtM1.GetQuantitaAssenze(A027Progressivo,InizioAssenze,FineAssenze,DataNas,G,UM,Quantita,OreRese);  //Lorena 20/12/2005
        //R600DtM1.GetAssenze(A027Progressivo,DataA,DataA,DataNas,G);
        R600DtM1.GetAssenze(A027Progressivo,FineAssenze,FineAssenze,DataNas,G);
        UM:=R600DtM1.UMisura;
        trpassemes[i].tCalcolato:=True and (not RifDataNas);
        if (R600DtM1.TipoCumulo <> 'H') and (R600DtM1.ValCompCorr = 0) and (R600DtM1.ValCompPrec = 0) and (R600DtM1.ValFruitoTot = 0) then
          exit;
      end;
    end
    else if RifDataNas and (Quantita = 0) then
      exit;
    if UM = 'O' then UM:='H';
(*    if not RifDataNas then  //Lorena 20/12/2005
      if UM = 'G' then
        Quantita:=trpassemes[i].tggassemes + (trpassemes[i].tmgassemes / 2)
      else
        Quantita:=trpassemes[i].tmintotassemes;//trpassemes[i].tminvalassemes;*)
    //Scorrimento dati da valorizzare
    cdsAssenze.Append;
    cdsAssenze.FieldByName('CHIAVE').AsString:=Chiave;
    //cdsAssenze.FieldByName('PROGRESSIVO').AsInteger:=A027Progressivo;
    cdsAssenze.FieldByName('CAMPO901').AsString:=Format('%-7s(%s)',[CodCausale,UM]);
    cdsAssenze.FieldByName('CAMPO908').AsString:=DescCausale;
    //Fatto nel mese
    if UM = 'G' then
      cdsAssenze.FieldByName('CAMPO902').AsString:=FloatToStr(Quantita)
    else
      cdsAssenze.FieldByName('CAMPO902').AsString:=R180MinutiOre(Trunc(Quantita));
    if trpassemes[i].tCompetenze then
    begin
      //Competenze complessive
      cdsAssenze.FieldByName('CAMPO903').AsString:=R600DtM1.GetCompTot;
      //Competenze anno precedente
      cdsAssenze.FieldByName('CAMPO904').AsString:=R600DtM1.GetCompPrec;
      //Competenze anno corrente
      cdsAssenze.FieldByName('CAMPO905').AsString:=R600DtM1.GetCompCorr;
      //Assenze fruite
      cdsAssenze.FieldByName('CAMPO906').AsString:=R600DtM1.GetFruitoTot;
      //Assenze residue
      cdsAssenze.FieldByName('CAMPO907').AsString:=R600DtM1.GetResiduo;
      cdsAssenze.FieldByName('CAMPO916').AsString:=R600DtM1.GetResiduoPrec;
      cdsAssenze.FieldByName('CAMPO917').AsString:=R600DtM1.GetResiduoCorr;
      //Assenze fruite anno precedente
      cdsAssenze.FieldByName('CAMPO909').AsString:=R600DtM1.GetFruitoPrec;
      //Assenze fruite anno corrente
      cdsAssenze.FieldByName('CAMPO910').AsString:=R600DtM1.GetFruitoCorr;
      //Assenze richieste
      cdsAssenze.FieldByName('CAMPO918').AsString:=R600DtM1.GetIterRichiesto;
      //Assenze autorizzate
      cdsAssenze.FieldByName('CAMPO919').AsString:=R600DtM1.GetIterAutorizzato;
      if UM = 'G' then
        cdsAssenze.FieldByName('CAMPO911').AsString:=R600DtM1.GetCompTot
      else
        try
          cdsAssenze.FieldByName('CAMPO911').AsString:=Format('%.2f',[R600DtM1.TrasformaOre2Giorni(R180OreMinutiExt(R600DtM1.GetCompTot))]);//Format('%.2f',[R180OreMinutiExt(R600DtM1.GetCompTot)/R600DtM1.ValenzaGiornaliera]);
        except
          cdsAssenze.FieldByName('CAMPO911').AsString:='0';
        end;
      //Fruito totali in giorni
      if UM = 'G' then
        cdsAssenze.FieldByName('CAMPO912').AsString:=R600DtM1.GetFruitoTot
      else
        try
          cdsAssenze.FieldByName('CAMPO912').AsString:=Format('%.2f',[R600DtM1.TrasformaOre2Giorni(R180OreMinutiExt(R600DtM1.GetFruitoTot))]);//Format('%.2f',[R180OreMinutiExt(R600DtM1.GetFruitoTot)/R600DtM1.ValenzaGiornaliera]);
        except
          cdsAssenze.FieldByName('CAMPO912').AsString:='0';
        end;
      //Competenze totali in giorni
      if UM = 'G' then
        cdsAssenze.FieldByName('CAMPO913').AsString:=R600DtM1.GetResiduo
      else
        try
          cdsAssenze.FieldByName('CAMPO913').AsString:=Format('%.2f',[R600DtM1.TrasformaOre2Giorni(R180OreMinutiExt(R600DtM1.GetResiduo))]);//Format('%.2f',[R180OreMinutiExt(R600DtM1.GetResiduo)/R600DtM1.ValenzaGiornaliera]);
        except
          cdsAssenze.FieldByName('CAMPO913').AsString:='0';
        end;
      //Competenze parziali al mese in elaborazione
      cdsAssenze.FieldByName('CAMPO914').AsString:=R600DtM1.GetCompParz;
      //Residuo parziale
      cdsAssenze.FieldByName('CAMPO915').AsString:=R600DtM1.GetResiduoParz;
    end;
    cdsAssenze.Post;
  end;
begin

  for i:=1 to n_rpassemes do
  begin
    G.Inserimento:=False;
    G.Modo:='I';
    G.Causale:=trpassemes[i].tcsassemes;
    if R180CarattereDef(VarToStr(Q265Riep.Lookup('Codice',G.Causale,'Cumulo_Familiari')),1,'N') in ['S','D'] then
      with R600DtM1.selT040DataNas do
      begin
        Close;
        SetVariable('Progressivo',A027Progressivo);
        SetVariable('Causale',G.Causale);
        SetVariable('Data1',DataDa(*EncodeDate(1900,1,1)*));
        SetVariable('Data2',DataA);
        Open;
        while not Eof do
        begin
          RiepilogaAssenze(i,True,FieldByName('DataNas').AsDateTime);
          Next;
        end;
      end
    else
      RiepilogaAssenze(i,False,Date);
  end;
  //Alberto 31/01/2017: record nullo per far sì che la sezione delle assenze venga sempre stampata, in modo da stampare anche eventuali dati liberi successivi.
  if cdsAssenze.RecordCount = 0 then
  begin
    cdsAssenze.Append;
    cdsAssenze.FieldByName('CHIAVE').AsString:=Chiave;
    cdsAssenze.Post;
  end;
end;

procedure TR400FCartellinoDtM.Q950ListaAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TR400FCartellinoDtM.LeggiDatiRichiesti(Sender:String);
var i,j,i2:Integer;
    S,Nome,Capt,X,Y,H,W,Suff,Posiz:String;
    Lista:TStringList;
begin
  Lista:=TStringList.Create;
  selT951.Close;
  selT951.SetVariable('CODICE',Q950Int.GetVariable('CODICE'));
  selT951.Open;
  while not selT951.Eof do
  begin
    Lista.Add(selT951.FieldByName('RIGA').AsString);
    selT951.Next;
  end;
  selT951.Close;
  Suff:=Sender;
  if Sender = 'Intestazione' then
  begin
    CampiIntestazione:='';
    Suff:='';
  end
  else if Sender = 'Dettaglio' then
    lstDettaglio.Clear
  else if Sender = 'Riepilogo' then
  begin
    SetLength(VetDatiLiberiSQL,0);
    lstRiepilogo.Clear;
  end;
  i:=Lista.IndexOf(Format('[LABELS%s]',[Suff]));
  if i = -1 then
    exit;
  //Cerco la fine delle impostazioni del gruppo (Intestazione/Dettaglio/Riepilogo)
  i2:=Lista.IndexOf('[FONTDettaglio]');
  if i2 < i then
  begin
    i2:=Lista.IndexOf('[FONTRiepilogo]');
    if i2 < i then
      i2:=Lista.Count;
  end;
  for j:=i + 1 to i2 - 1 do
  begin
    S:=Lista[j];
    //Leggo il Nome della labels
    if not R180Getvalore(S,'[N]','[C]',Nome) then
      Continue;
    if not R180Getvalore(S,'[C]','[T]',Capt) then
      Continue;
    if not R180Getvalore(S,'[T]','[L]',Y) then
      Continue;
    if not R180Getvalore(S,'[L]','[H]',X) then
      Continue;
    if not R180Getvalore(S,'[H]','[W]',H) then
      Continue;
    if not R180Getvalore(S,'[W]','[G]',W) then
      Continue;
    if not R180Getvalore(S,'[G]','',Posiz) then
      Posiz:='0';
    if Sender = 'Intestazione' then
    begin
      if CampiIntestazione <> '' then
        CampiIntestazione:=CampiIntestazione + ',';
      CampiIntestazione:=CampiIntestazione + Nome;
    end
    else if Sender = 'Dettaglio' then
      lstDettaglio.Add(Posiz)
    else if Sender = 'Riepilogo' then
    begin
      lstRiepilogo.Add(Posiz);
      //if (StrToInt(Posiz) >= 903) and (StrToInt(Posiz) <= 907) then
      if R180In(StrToInt(Posiz),[903,904,905,906,907,909,910,911,912,913,914,915,916,917,918,919]) then
        CalcoloCompetenze:=True;
    end;
  end;
  FreeAndNil(Lista);
end;

function TR400FCartellinoDtM.CheckValidazione2Parametrizzazione(Progressivo:LongInt; Data1,Data2:TDateTime):String;
var D:TDateTime;
begin
  Result:='';
  if Q950Int.FieldByName('CARTELLINI_VALIDATI').AsString = 'I' then
    exit;
  D:=R180InizioMese(Data1);
  while D <= R180InizioMese(Data2) do
  begin
    if ((Q950Int.FieldByName('CARTELLINI_VALIDATI').AsString = 'S') and
        (not selDatiBloccati.CheckDatoBloccato(Progressivo,D,'T860',True))) then
      Result:=Format('Il modello di "Parametrizzazione" selezionato è incongruente:' + CRLF + 'il cartellino di %s non è ancora validato.',[FormatDateTime('mmmm yyyy',D)]);
    if ((Q950Int.FieldByName('CARTELLINI_VALIDATI').AsString = 'N') and
         selDatiBloccati.CheckDatoBloccato(Progressivo,D,'T860',True)) then
      Result:=Format('Il modello di "Parametrizzazione" selezionato è incongruente:'+ CRLF + 'il cartellino di %s è già validato.',[FormatDateTime('mmmm yyyy',D)]);
    if Result <> '' then
      Break;
    D:=R180AddMesi(D,1);
  end;
end;

procedure TR400FCartellinoDtM.CartolinaDipendente(Progressivo:LongInt; Anno,Mese,GGDa,GGA:Word);
{Ciclo per tutti i giorni del mese - Calcolo e stampa dei dati}
var A,M,G,Giorno:Word;
    S:String;
  procedure AllineaRiepTurni_IndPres;
  var i:Integer;
  begin
    if Parametri.CampiRiferimento.C3_RiepTurni_IndPres = 'S' then
    begin
      for i:=1 to High(trpturfmes) do trpturfmes[i]:=0;
      for i:=1 to High(trpturgg1) do
      begin
        if (indpres_giorno[i + 3].Ind > 0) and (trpturgg1[i] > 0) then
          inc(trpturfmes[trpturgg1[i]]);
        if (indpres_giorno[i + 3].Ind > 1) and (trpturgg2[i] > 0) then
          inc(trpturfmes[trpturgg2[i]]);
      end;
    end;
  end;
begin
  try
    A027Progressivo:=Progressivo;
    DataDa:=EncodeDate(Anno,Mese,GGDa);
    DataA:=EncodeDate(Anno,Mese,GGA);
    r_gior:=R180GiorniMese(DataDa);
    SaldoTotMesePrec:=0;

    //Lettura dati anagrafici storici
    if Parametri.CampiRiferimento.C3_IndPres = '' then
      S:=''
    else
    begin
      S:=',T430' + Parametri.CampiRiferimento.C3_IndPres;
      if Parametri.CampiRiferimento.C3_IndPres2 <> '' then
        S:=S + ',T430' + Parametri.CampiRiferimento.C3_IndPres2;
    end;
    DatiStorici:='T430PERSELASTICO,T430ABCAUSALE1,T430ABPRESENZA1,T430IPRESENZA,T430AZIENDA_BASE,T430D_AZIENDA_BASE' + S;
    QSDatiAnagrafici.GetDatiStorici(DatiStorici,A027Progressivo,R180InizioMese(R180AddMesi(DataDa,-1)),R180FineMese(R180AddMesi(DataA,1)));

    FAziendaBase:='';
    FDAziendaBase:='';
    if QSDatiAnagrafici.LocDatoStorico(R180FineMese(DataA)) then
    begin
      FAziendaBase:=QSDatiAnagrafici.FieldByName('T430AZIENDA_BASE').AsString;
      FDAziendaBase:=QSDatiAnagrafici.FieldByName('T430D_AZIENDA_BASE').AsString;
    end;

    RECBancaOre:=(UpperCase(Parametri.RagioneSociale) = 'COMUNE DI REGGIO EMILIA') and
                 (QSDatiAnagrafici.LocDatoStorico(R180FineMese(DataA))) and
                 (Pos(',RST,',',' + QSDatiAnagrafici.FieldByName('T430ABPRESENZA1').AsString + ',') > 0);
    RECLiquidabile:=(UpperCase(Parametri.RagioneSociale) = 'COMUNE DI REGGIO EMILIA') and
                 (QSDatiAnagrafici.LocDatoStorico(R180FineMese(DataA))) and
                 (Pos(',STRA,',',' + QSDatiAnagrafici.FieldByName('T430ABPRESENZA1').AsString + ',') > 0);

    if RECBancaOre or RECLiquidabile then  //Reggio Emilia
    begin
      R450DtM1.ConteggiMese('Generico',Anno,Mese,A027Progressivo);
      SaldoTotMesePrec:=R450DtM1.salfmprec;
    end;

    if RiepilogoBuoniPasto then
    try
      R350DtM.R502ProDtM1.PeriodoConteggi(DataDa,DataA);
      R350DtM.RiepilogoMensileMaturazione(Progressivo,DataDa,DataA,DataDa);
    except
      on E: Exception do
        raise Exception.Create(' [fase: riepilogo buoni pasto]: ' + E.Message);
    end;
    if (Parametri.ModuloInstallato['BUONI_PASTO']) and (EsisteDato(C_BP1) or EsisteDato(C_BP2)) then
    begin
      if R350DtM = nil then
      begin
        if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
          R350DtM:=TR350FCalcoloBuoniDtM.Create(Self.Owner)
        else
          R350DtM:=TR350FCalcoloBuoniDtM.Create(SessioneOracleR400);
      end;
      R350DtM.QSBuonoMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C4_BuoniMensa,A027Progressivo,R180InizioMese(DataDa),R180FineMese(DataA));
      R350DtM.R502ProDtM1.PeriodoConteggi(DataDa,DataA);
    end;

    if RiepilogoAccessiMensa then
    try
      R300DtM.ConteggiaPastiPeriodo(Progressivo,DataDa,DataA,True);
    except
      on E:Exception do
        raise Exception.Create(' [fase: riepilogo accessi mensa]: ' + E.Message);
    end;

    //Inserimento riposi solo per mesi antecenti al corrente
    if InserimentoRiposi and (DataA < R180InizioMese(Date)) then
    try
      A041MW.DataInizio:=DataDa;
      A041MW.DataFine:=DataA;
      A041MW.ElaboraDipendente;
    except
      on E:Exception do
        raise Exception.Create(' [fase: inserimento automatico riposi]: ' + E.Message);
    end;

    if RichiestePendenti and Assigned(A023MW) then
    try
      A023MW.CaricaRichieste(Progressivo,DataDa,DataA);
    except
      on E:Exception do
        raise Exception.Create(' [fase: riepilogo richieste pendenti]: ' + E.Message);
    end;

    LeggiFasceContratto(Anno,Mese);
    //Inizializzazione totalizzazioni mensili
    x010_azztot(Anno,Mese);
    //Apertura dataset accessi mensa    LORENA 07/02/2005
    with selT375 do
    begin
      Close;
      SetVariable('PROG',A027Progressivo);
      SetVariable('DADATA',DataDa);
      SetVariable('ADATA',DataA);
      Open;
    end;
    with selT820 do
    begin
      Close;
      SetVariable('PROGRESSIVO',A027Progressivo);
      SetVariable('ANNO',R180Anno(DataDa));
      SetVariable('MESE',R180Mese(DataDa));
      Open;
    end;
    //Apro per sicurezza le parametrizzazioni del cartellino perchè possono essere usate nelle elaborazioni successive.
    //La A041 Riposi richiama CartolinaDipendente senza aver scelto una parametrizzazione, per cui il dataset rimarrebbe chiuso
    with Q950Int do
      if not Active then
      begin
        SetVariable('Codice','');
        Open;
      end;
    GetCartellinoIstituti(Anno,Mese);
    if s_tiporiepist = 'N' then
    begin
      l03_tipocart:='M';
      c03_tipocart:='M';
    end
    else
    begin
      d113_tipocart(Anno,Mese,GGDa);
      c03_tipocart:=c_tipocart_att;
    end;
    if c03_tipocart = 'S' then
      d115b_numcorr(Anno,Mese,GGDa,GGA)
    else
      d115a_numcorr(Anno,Mese,GGDa,GGA);
    //Reset dati giornalieri per TORINO_CSI
    DeleteT102(A027Progressivo,R180InizioMese(DataDa));
    TO_CSI_STR_AUT_Arrot:=R180OreMinutiExt(VarToStr(Q275Riep.Lookup('CODICE',TO_CSI_STR_AUT,'ARROT_RIEPGG')));
    TO_CSI_STR_AUT_Min:=StrToIntDef(VarToStr(Q275Riep.Lookup('CODICE',TO_CSI_STR_AUT,'MINMINUTI')),0);
    //Auto-giustificazione
    if AutoGiustificazione then
      R410FAutoGiustificazioneDtM.AutoGiustificazione(A027Progressivo,DataDa,DataA);
    //TORINO_CSI: eliminazione giustificativo di abbattimento banca ore (STAMPA=B) per successivo reinserimento
    if AbbattiBancaOre then
      R410FAutoGiustificazioneDtM.ResetAbbattimentoBancaOre(A027Progressivo,ncinisaldi,ncfinsaldi);

    //Alberto 14/09/2018 - CCNL 2018: Giustificativi dalle..alle per visite fiscali
    //deve essere ricalcolato l'inserimento della giornata intera per il mese in elaborazione
    if AggiornamentoScheda then
      R410FAutoGiustificazioneDtM.CercaCausaliHMAssenza(A027Progressivo,DataDa,DataA);

    //Definisco il periodo dei conteggi e estraggo i dati senza effettuare altre operazioni
    R502ProDtM1.Chiamante:='Cartolina';
    R502ProDtM1.PeriodoConteggi(ncinisaldi - 2,Max(ncfinistit,ncfinsaldi) + 1);
    R502ProDtM1.ResettaProg;
    R502ProDtM1.Conteggi('APERTURA',A027Progressivo,DataDa);
    //Lettura Profili indennità
    if Parametri.CampiRiferimento.C3_IndPres = '' then
      S:=''
    else
    begin
      S:=',T430' + Parametri.CampiRiferimento.C3_IndPres;
      if Parametri.CampiRiferimento.C3_IndPres2 <> '' then
        S:=S + ',T430' + Parametri.CampiRiferimento.C3_IndPres2;
    end;
    QSDatiAnagrafici.GetDatiStorici(DatiStorici,A027Progressivo,ncinisaldi - 2,Max(ncfinistit,ncfinsaldi) + 1);

    //Ricerca del primo giorno di servizio del dipendente
    d116_cerco1gg;
    if dipinser1 = 'si' then
      d117_stampo(Anno,Mese,GGDa,GGA);
    //RICHIAMO CONTE 1 GIORNO DOPO
    if (R502ProDtM1.blocca = 0) and (ncfinistit >= ncfinsaldi) then
      conte(ncfinistit + 1);
    AllineaRiepTurni_IndPres;
    //Chiusura dataset accessi mensa    LORENA 07/02/2005
    selT375.Close;
    //Test se c'è anomalia bloccante
    if dipinser1 = 'si' then
    begin
      R450DtM1.Progress400:=A027Progressivo;
      R450DtM1.DaData:=DataDa;
      R450DtM1.AData:=DataA;
      //Lettura turni di reperibilità
      if EsisteInRiepilogo(61) or EsisteInRiepilogo(62) or EsisteInRiepilogo(63) or EsisteInRiepilogo(64) then
        R450DtM1.ParametrizzazioneQueryStampa(0);
      //Lettura buoni mensa/ticket maturati/acquistati
      if EsisteInRiepilogo(51) or EsisteInRiepilogo(52) then
        R450DtM1.ParametrizzazioneQueryStampa(1);
      if EsisteInRiepilogo(35) or EsisteInRiepilogo(36) then
        R450DtM1.ParametrizzazioneQueryStampa(2);
      //Lettura accessi mensa
      if EsisteInRiepilogo(57) or EsisteInRiepilogo(58) or EsisteInRiepilogo(59) then
        R450DtM1.ParametrizzazioneQueryStampa(5);
      R450DtM1.anno400:=Anno;
      R450DtM1.mese400:=Mese;
      finepag;

      if (c03_tipocart = 'S') and (s_tiporiepist = 'M') then
        begin
        if ncfinsaldi < ncfinistit then
          begin
          s_saltoggnontot:='no';
          DecodeDate(ncfinsaldi + 1,A,M,G);
          if M <> Mese then
            G:=1;
          for Giorno:=G to GGA do
            e020_stamriga(Anno,Mese,Giorno,False);
          end;
        end;
      //Elimino le assenze che non sono richieste poichè non servono più per i conteggi
      ParStampaCartellino:=R450DtM1.ParCartellino;
      PulisciRiepilogoAssenze;
    end;
  except
    on E: Exception do
    begin
      RegistraMsg.InserisciMessaggio('A',Format('Anomalia durante elaborazione cartellino (%d-%d/%d/%d): %s',[GGDa,GGA,Mese,Anno,E.Message]),'',A027Progressivo);
      DipInSer1:='no'; // forza interruzione ciclo principale
    end;
  end;
end;

procedure TR400FCartellinoDtM.DatiAtipici;
var myEspr: String;
    myRes: String;
    selT077: TselT077;
    Lst: TStringList;
    i: integer;
begin
  selT077:=TselT077.Create(Self);
  try
    selT077.Session:=SessioneOracleR400;
    selT077.Progressivo:=A027Progressivo;
    selT077.Data:=DataDa;

    selI011.Close;
    selI011.SetVariable('PROGRESSIVO',A027Progressivo);
    selI011.SetVariable('DATA',R180FineMese(EncodeDate(AnnoCor,MeseCor,1)));
    selI011.Open;

    while not selI011.Eof do
    begin
      myEspr:=selI011.FieldByName('ESPRESSIONE').AsString;

      selI011Espressione.Close;
      selI011Espressione.DeleteVariables;

      selI011Espressione.DeclareVariable('ESPRESSIONE', otSubst);
      selI011Espressione.SetVariable('ESPRESSIONE', myEspr);

      Lst:=FindVariables(myEspr, False);
      if Lst.Count > 1 then
      begin
        for i := 0 to Lst.Count-1 do
        begin
          if UpperCase(Lst[i]) = 'DATA' then
          begin
            selI011Espressione.DeclareVariable(Lst[i], otDate);
            selI011Espressione.SetVariable(Lst[i],R180FineMese(EncodeDate(AnnoCor,MeseCor,1)));
          end
          else if UpperCase(Lst[i]) = 'PROGRESSIVO' then
          begin
            selI011Espressione.DeclareVariable(Lst[i], otInteger);
            selI011Espressione.SetVariable('PROGRESSIVO',A027Progressivo);
          end;
        end;

      end;
      selI011Espressione.Open;
      Lst.Free;

      myRes:=selI011Espressione.FieldByName('RISULTATO').AsString;
      selT077.ScriviValore(selI011.FieldByName('DATO').AsString, myRes);

      selI011.Next;
    end;

    SessioneOracleR400.Commit;

  finally
    FreeAndNil(selT077);
  end;

end;

procedure TR400FCartellinoDtM.carico(Anno,Mese:Word);
{Caricamento timbrature e causali}
var xx,yy:Integer;
begin
  AnnoCor:=Anno;
  MeseCor:=Mese;
  with R502ProDtM1 do
  begin
    for xx:=Low(m_tab_timbrature) to High(m_tab_timbrature) do
      for yy:=1 to MaxTimbrature do
        m_tab_timbrature[xx,yy]:=m_tab_timbrature_vuoto;
    for xx:=Low(m_tab_giustificativi) to High(m_tab_giustificativi) do
      for yy:=1 to MaxGiustif do
        m_tab_giustificativi[xx,yy]:=m_tab_giustificativi_vuoto;
  end;
  giorno:=0;
  i_dat1:=1;
  //caricamento giustificativi
  R502ProDtM1.DataCon:=EncodeDate(AnnoCor,MeseCor,1);
  R502ProDtM1.z916_startgiust;
  if R502ProDtM1.s_trovato = 'si' then
  begin
    carico_c;
    repeat
      R502ProDtM1.z918_leggigiust;
      carico_c;
    until R502ProDtM1.s_trovato = 'no';
  end;
  //caricamento timbrature
  i_dat1:=0;
  giorno:=0;
  R502ProDtM1.z926_starttimbr(R502ProDtM1.DataCon);
  if R502ProDtM1.s_trovato = 'si' then
  begin
    carico_t;
    repeat
      R502ProDtM1.z928_leggitimbr;
      carico_t;
    until R502ProDtM1.s_trovato = 'no';
  end;
end;

procedure TR400FCartellinoDtM.carico_c;
{Caricamento giustificativi}
var A,M,G:Word;
begin
  with R502ProDtM1 do
  begin
    if s_trovato = 'no' then
      exit
    else
    //controllo se il giust. appartiene al mese preso in esame
    begin
      DecodeDate(Q040.FieldByName('Data').AsDateTime,A,M,G);
      if (A <> AnnoCor) or (M <> MeseCor) then
      begin
        s_trovato:='no';
        exit;
      end;
    end;
    GiornoCor:=G;
    if GiornoCor <> giorno then
      i_dat1:=0;
    inc(i_dat1);
    if (Q040.FieldByName('TipoGiust').AsString = 'I') or (Q040.FieldByName('TipoGiust').AsString = 'M') then
      spostoc
    else
    begin
      m_tab_giustificativi[GiornoCor,i_dat1].tcausgius:=Q040.FieldByName('Causale').AsString;
      m_tab_giustificativi[GiornoCor,i_dat1].ttipogius:=R180CarattereDef(Q040.FieldByName('TipoGiust').AsString);
      m_tab_giustificativi[GiornoCor,i_dat1].tdallegius:=Q040.FieldByName('DaOre').AsDateTime;
      m_tab_giustificativi[GiornoCor,i_dat1].tallegius:=Q040.FieldByName('AOre').AsDateTime;
      m_tab_giustificativi[GiornoCor,i_dat1].tnotegius:=Q040.FieldByName('Note').AsString;
    end;
    giorno:=GiornoCor;
  end;
end;

procedure TR400FCartellinoDtM.spostoc;
{Sposto i giustificativi DaOre/AOre e numero Ore per liberare la prima posizione}
var cola:Byte;
begin
  with R502ProDtM1 do
  begin
    for cola:=5 downto 1 do
    begin
      R502ProDtM1.m_tab_giustificativi[GiornoCor,cola + 1]:=R502ProDtM1.m_tab_giustificativi[GiornoCor,cola];
      R502ProDtM1.m_tab_giustificativi[GiornoCor,cola]:=m_tab_giustificativi_vuoto;
    end;
    m_tab_giustificativi[GiornoCor,1].tcausgius:=Q040.FieldByName('Causale').AsString;
    m_tab_giustificativi[GiornoCor,1].ttipogius:=R180CarattereDef(Q040.FieldByName('TipoGiust').AsString);
    m_tab_giustificativi[GiornoCor,1].tdallegius:=Q040.FieldByName('DaOre').AsDateTime;
    m_tab_giustificativi[GiornoCor,1].tallegius:=Q040.FieldByName('AOre').AsDateTime;
    m_tab_giustificativi[GiornoCor,1].tnotegius:=Q040.FieldByName('Note').AsString;
  end;
end;

procedure TR400FCartellinoDtM.carico_t;
{Caricamento timbrature in memoria}
var A,M,G:Word;
begin
  with R502ProDtM1 do
  begin
    if s_trovato = 'no' then
      exit
    else
    begin
      DecodeDate(Q100.FieldByName('Data').AsDateTime,A,M,G);
      //controllo se timbratura appartiene al mese preso in esame
      if (A <> AnnoCor) or (M <> MeseCor) then
      begin
        s_trovato:='no';
        exit;
      end;
    end;
    GiornoCor:=G;
    if GiornoCor <> giorno then
      i_dat1:=0;
    inc(i_dat1);
    m_tab_timbrature[GiornoCor,i_dat1].toratimb:=Q100.FieldByName('Ora').AsDateTime;
    m_tab_timbrature[GiornoCor,i_dat1].tversotimb:=R180CarattereDef(Q100.FieldByName('Verso').AsString);
    m_tab_timbrature[GiornoCor,i_dat1].trilevtimb:=Q100.FieldByName('Rilevatore').AsString;
    m_tab_timbrature[GiornoCor,i_dat1].tflagtimb:=R180CarattereDef(Q100.FieldByName('Flag').AsString);
    m_tab_timbrature[GiornoCor,i_dat1].tcaustimb:=Q100.FieldByName('Causale').AsString;
    giorno:=GiornoCor;
  end;
end;

function TR400FCartellinoDtM.GetDescGiust(S:String):String;
{Ricerco la descrizione del giustificativo da stampare nella colonna giustificativi}
begin
  Result:=S;
  if Q265Riep.Locate('Codice',S,[]) then
    Result:=Q265Riep.FieldByName('Descrizione').AsString
  else
    if Q275Riep.Locate('Codice',S,[]) then
      Result:=Q275Riep.FieldByName('Descrizione').AsString;
end;

function TR400FCartellinoDtM.GetSiglaGiust(S:String):String;
{Ricerco la sigla della causale della timbratura}
begin
  Result:=S;
  if Q275Riep.Locate('Codice',S,[]) then
    Result:=Q275Riep.FieldByName('Sigla').AsString
  else
    if Q305.Locate('Codice',S,[]) then
      Result:=Q305.FieldByName('Sigla').AsString;
end;

function TR400FCartellinoDtM.GetTimbMensa(m_datacon:TDateTime):String;
begin
  Result:='';
  with R502ProDtM1.Q370 do
    begin
    if Locate('Data',m_datacon,[]) then
      while (not Eof) and (FieldByName('Data').AsDateTime = m_datacon) do
        begin
        if Result <> '' then Result:=Result + ' ';
        Result:=Result + FormatDateTime(IfThen(Parametri.AccessibilitaNonVedenti = 'S',FMT_HHpNN,FMT_HHNN),FieldByName('Ora').AsDateTime);
        Next;
        end;
    end;
  if Result = '' then  //LORENA 07/02/2005
    if selT375.SearchRecord('DATA',m_datacon,[srFromBeginning]) then
      Result:=selT375.Fields[1].AsString;
end;

function TR400FCartellinoDtM.GetDatoRiepPresenze(i:Integer; Dato:String; Fasce:Boolean):String;
var k,j,t:Integer;
    TipoLiq:Char;
begin
  Result:='';
  Dato:=UpperCase(Dato);
  k:=R450DtM1.IndiceRiepPres(trppresmes[i].tcspresmes);
  if k = -1 then
    exit;

  if not Q275Riep.Locate('Codice',trppresmes[i].tcspresmes,[]) then
    exit;

  TipoLiq:='N';
  if selT190.Active then
  begin
    if (Q275Riep.FieldByName('VOCEPAGHE').AsString = 'S') and (Q275Riep.FieldByName('VOCEPAGHELIQ').AsString = 'S') then
    begin
      if selT190.Locate('CODINTERNO','160',[]) or (not selT190.Locate('CODINTERNO','230',[])) then
        TipoLiq:='L'
      else
        TipoLiq:='R';
    end
    else if Q275Riep.FieldByName('VOCEPAGHE').AsString = 'S' then
      TipoLiq:='R'
    else if Q275Riep.FieldByName('VOCEPAGHELIQ').AsString = 'S' then
      TipoLiq:='L'
  end;

  if Dato = 'CODICE' then
    Result:=trppresmes[i].tcspresmes
  else if Dato = 'DESCRIZIONE' then
    Result:=trppresmes[i].tdescpresmes
  else if Dato = 'FATTO_MESE' then
  begin
    t:=0;
    for j:=1 to R450DtM1.NFasceMese do
    begin
      inc(t,trppresmes[i].tminpresmes[j]);
      Result:=Result + Format('%7s',[R180MinutiOre(trppresmes[i].tminpresmes[j])]);
    end;
    if not Fasce then
      Result:=R180MinutiOre(t);
  end
  else if Dato = 'SIGLA' then
    Result:=trppresmes[i].tsiglapresmes
  else if Dato = 'FATTO_ANNO' then
  begin
    t:=0;
    for j:=1 to R450DtM1.NFasceMese do
    begin
      inc(t,R450DtM1.RiepPres[k].OreRese[j]);
      Result:=Result + Format('%7s',[R180MinutiOre(R450DtM1.RiepPres[k].OreRese[j])]);
    end;
    if not Fasce then
      Result:=R180MinutiOre(t);
  end
  else if Dato = 'LIQUIDABILE_ANNO' then
  begin
    t:=0;
    for j:=1 to R450DtM1.NFasceMese do
    begin
      inc(t,R450DtM1.RiepPres[k].Liquidabile[j]);
      Result:=Result + Format('%7s',[R180MinutiOre(R450DtM1.RiepPres[k].Liquidabile[j])]);
    end;
    if not Fasce then
      Result:=R180MinutiOre(t);
  end
  else if Dato = 'LIQUIDATO_MESE' then
  begin
    t:=0;
    for j:=1 to R450DtM1.NFasceMese do
    begin
      if TipoLiq = 'R' then
      begin
        inc(t,trppresmes[i].tminpresmes[j]);
        Result:=Result + Format('%7s',[R180MinutiOre(trppresmes[i].tminpresmes[j])]);
      end
      else if TipoLiq = 'L' then
      begin
        inc(t,R450DtM1.RiepPres[k].LiquidatoMese[j]);
        Result:=Result + Format('%7s',[R180MinutiOre(R450DtM1.RiepPres[k].LiquidatoMese[j])]);
      end;
    end;
    if not Fasce then
      Result:=R180MinutiOre(t);
  end
  else if Dato = 'LIQUIDATO_ANNO' then
  begin
    t:=0;
    for j:=1 to R450DtM1.NFasceMese do
    begin
     if TipoLiq = 'R' then
     begin
       inc(t,R450DtM1.RiepPres[k].OreRese[j]);
       Result:=Result + Format('%7s',[R180MinutiOre(R450DtM1.RiepPres[k].OreRese[j])]);
     end
     else if TipoLiq = 'L' then
     begin
       inc(t,R450DtM1.RiepPres[k].Liquidato[j]);
       Result:=Result + Format('%7s',[R180MinutiOre(R450DtM1.RiepPres[k].Liquidato[j])]);
     end;
    end;
    if not Fasce then
      Result:=R180MinutiOre(t);
  end
  else if Dato = 'RESIDUO' then
  begin
    t:=0;
    for j:=1 to R450DtM1.NFasceMese do
    begin
      inc(t,R450DtM1.RiepPres[k].Residuo[j]);
      Result:=Result + Format('%7s',[R180MinutiOre(R450DtM1.RiepPres[k].Residuo[j])]);
    end;
    if not Fasce then
      Result:=R180MinutiOre(t);
  end
  else if Dato = 'ORE_PERSE' then
  begin
    t:=0;
    for j:=1 to R450DtM1.NFasceMese do
    begin
      inc(t,R450DtM1.RiepPres[k].Abbattimento[j]);
      Result:=Result + Format('%7s',[R180MinutiOre(R450DtM1.RiepPres[k].Abbattimento[j])]);
    end;
    if not Fasce then
      Result:=R180MinutiOre(t);
  end
  else if Dato = 'COMP_MESE_REG' then
    Result:=R180MinutiOre(R450DtM1.RiepPres[k].CompensabileMese)
  else if Dato = 'COMP_MESE_EFF' then
    Result:=R180MinutiOre(R450DtM1.RiepPres[k].CompensabileMeseEff)
  else if Dato = 'COMP_ANNO_REG' then
    Result:=R180MinutiOre(R450DtM1.RiepPres[k].CompensabileAnno)
  else if Dato = 'COMP_ANNO_EFF' then
    Result:=R180MinutiOre(R450DtM1.RiepPres[k].CompensabileAnnoEff)
  else if Dato = 'RECUPERO_MESE' then
    Result:=R180MinutiOre(R450DtM1.RiepPres[k].RecuperoMese)
  else if Dato = 'RECUPERO_ANNO' then
    Result:=R180MinutiOre(R450DtM1.RiepPres[k].RecuperoAnno);
end;

procedure TR400FCartellinoDtM.x030_totfin;
{Saldi di fine cartolina}
var A,M,G: Word;
    i,j,xx,StrAutorizzato:Integer;
begin
  DecodeDate(DataDa,A,M,G);
  // part-time percentualizzato.ini
  {
  if debitoposm_sv = 'M' then
    //Debito plus orario tabellare mensile
    begin
    if debpoind_sv = 'si' then
      R450DtM1.debpomes:=debitopomm_sv
    else
      //Poiche' il debito plus orario mensile e' ricavato dalla
      //categoria, esso viene rapportato ai giorni di servizio del
      //dipendente nel mese in gestione
      if r_gior = ngginser then
        R450DtM1.debpomes:=debitopomm_sv
      else
        try
          R450DtM1.debpomes:=debitopomm_sv div r_gior * ngginser;
        except
          R450DtM1.debpomes:=0;
        end;
    if ngglavser > 0 then
      //Il debito plus orario viene detratto della quota annullata da assenze
      try
        R450DtM1.debpomes:=R450DtM1.debpomes - (R450DtM1.debpomes div ngglavser) * nggdetrpo;
      except
        R450DtM1.debpomes:=0;
      end;
    if nggdetrpo >= ngglavser then
      //Il debito plus orario viene azzerato perche' tutti i giorni
      //lavorativi presentano assenze che annullano il plus orario
      R450DtM1.debpomes:=0;
    end;
  }
  // NOTA: R450DtM1.debpo_percptmes è già al netto della quota annullata da assenze
  if debitoposm_sv = 'M' then
  begin
    // debito aggiuntivo mensile
    if debpoind_sv = 'si' then
    begin
      // debito individuale -> mantenuto così come definito
      R450DtM1.debpomes:=debitopomm_sv;
    end
    else
    begin
      // debito da anagrafico -> rapportato al part-time e ai giorni di servizio nel mese
      try
        if r_gior = ngginser then
        begin
          if ngglavser = 0 then
            R450DtM1.debpomes:=debitopomm_sv
          else
            R450DtM1.debpomes:=trunc(debitopomm_sv * R450DtM1.debpo_percptmes / ngglavser);
        end
        else
        begin
          if ngglavser = 0 then
            R450DtM1.debpomes:=trunc(debitopomm_sv * ngginser / r_gior)
          else
            R450DtM1.debpomes:=trunc((debitopomm_sv * ngginser / r_gior) * R450DtM1.debpo_percptmes / ngglavser);
        end;
      except
        R450DtM1.debpomes:=0;
      end;
    end;
    //debito fisso 156 ore.ini
    if (R450DtM1.poflag = '2') and (R450DtM1.debpomes  > 0) then
      R450DtM1.debpomes:=R450DtM1.debpomes - R450DtM1.debormes;
    //debito fisso 156 ore.fine
  end;
  // part-time percentualizzato.fine

  //Gestione indennita' di turno per contratto PAL or AZP
  //if (R502ProDtM1.Q200.FieldByName('Tipo').AsString = 'PAL') or (R502ProDtM1.Q200.FieldByName('Tipo').AsString = 'AZP') then
  if (R502ProDtM1.T200[R502ProDtM1.Q200.FieldByName('Tipo').Index] = 'PAL') or (R502ProDtM1.T200[R502ProDtM1.Q200.FieldByName('Tipo').Index] = 'AZP') then
    x072_indturpal;
  //Conteggio indennità festive in seguito al recupero domeniche lavorate (S.Giovanni)
  for i:=1 to NDomeniche do
    if RecuperiFestivi[i] > 0 then
    begin
      fesintmesT:=fesintmesT + 1;
      GestioneDomenicaLavorata(DomenicheLavorate[i],RecuperiFestivi[i]);
    end;

  with R450DtM1 do
  begin
    //Conteggio dati per mese attuale in stampa
    L07.AddebitoPaghe:=0;
    L07.OreCompLiquidate:=0;
    L07.BancaOreLiqVar:=0;
    L07.tdatiassestamento[1].tcauassest:='';
    L07.tdatiassestamento[2].tcauassest:='';
    L07.fesintmesVar:=0;
    L07.fesridmesVar:=0;
    L07.notggmesVar:=0;
    L07.notminmesVar:='';
    for xx:=1 to MaxFasce do
    begin
      L07.tdatiassestamento[1].tminassest[xx]:=0;
      L07.tdatiassestamento[2].tminassest[xx]:=0;
      L07.tfasce[xx]:='';
      L07.tLiqNelMese[xx]:=0;
      L07.tmaggioraz[xx]:=0;
      L07.tstrliquidatomm[xx]:=0;
    end;
    L07.debormes:=debormes;
    L07.debggtot:=debggtot;
    L07.debpomes:=debpomes;
    L07.poflag:=poflag;
    L07.eccsolocompmes:=eccsolocompmes;
    L07.EccSoloCompMesOltreSoglia:=EccSoloCompMesOltreSoglia;
    L07.vareccliqmes:=vareccliqmes;
    L07.scostnegmes:=scostnegmes;
    L07.compnegmes:=compnegmes;
    L07.abbannoprecmes:=abbannoprecmes;
    L07.abbannoattmes:=abbannoattmes;
    L07.abbliqannoprecmes:=abbliqannoprecmes;
    L07.abbliqannoattmes:=abbliqannoattmes;
    L07.ripcommes:=ripcommes;
    L07.abbripcommes:=abbripcommes;
    L07.OreCompRecuperate:=OreCompRecuperate;
    L07.NFasce:=NFasceMese;
    L07.CarenzaObbligatoria:=RiepCarenzaObbligatoria;
    for i:=1 to MaxFasce do
      begin
      L07.tminlavmese[i]:=tminlavmes[i];
      L07.tminstrmens[i]:=tminstrmen[i];
      L07.tmininturno[i]:=tmininturno[i];
      end;
    //Passaggio riepilogo presenze
    RiepPresCartellino:=nil;
    SetLength(RiepPresCartellino,n_rppresmes);
    for i:=1 to n_rppresmes do
      begin
      RiepPresCartellino[i - 1].Causale:=Trppresmes[i].tcspresmes;
      for j:=1 to NFasceMese do
        RiepPresCartellino[i - 1].OreRese[j]:=Trppresmes[i].tminpresmes[j];
      end;
    //Conteggio dati per mese attuale in stampa
    ConteggiMese('Cartolina',A,M,A027Progressivo);

    if AbbattiBancaOre then
    begin
      //TORINO_CSI: Inserimento giustificativo 9103 per i giorni con eccedenza non causalizzata fino ad esaurimento BancaOreEccedente
      StrAutorizzato:=min(straordsett_mese,GetT050AutStr(A027Progressivo,DataDa));
      R410FAutoGiustificazioneDtM.BancaOreTOCSI.Abbattimento:=BancaOreEccedente[StrAutorizzato];
      R410FAutoGiustificazioneDtM.BancaOreTOCSI.NumFasce:=NFasceMese;
      if (R410FAutoGiustificazioneDtM.BancaOreTOCSI.Abbattimento > 0) then
      begin
        if not selDatiBloccati.CheckDatoBloccato(A027Progressivo,R180InizioMese(ncinisaldi),'T195',True) then
          R410FAutoGiustificazioneDtM.TroncaBancaOreEccedente(A027Progressivo,ncinisaldi,ncfinsaldi)
        else
          RegistraMsg.InserisciMessaggio('A',Format('Taglio della banca ore non effettuato per presenza di anomalie nel mese %s',[DateToStr(ncinisaldi)]),'',A027Progressivo);
      end;
    end;

    LimitiAnnualiCausali;  //ReggioEmilia_Comune
    SoglieEccedenza; //Straord. part-time
  end;
  if (R450DtM1.R455_tipocon = 4) and (R450DtM1.RicalcoloIndennita <> '0') then
    //Ricalcolo indennità festive e notturne con straordinario
    RicalcoloIndennita_1(R450DtM1.RicalcoloIndennita);
  if (R450DtM1.R455_tipocon = 4) and (R450DtM1.RicalcoloIndPresenza = '1') then
    //Ricalcolo indennità di presenza con la regola del turnetto
    RicalcoloIndPres_1;
  //Considero indennità riconosciute da causali di assenza specifiche o proporzionate sul debito gg
  AggiungiIndPresCalcolateSucc;
  //Ricalcolo indennità di presenza in base agli equilibri mensili (Ind.Turno)
  x080_indturno;
  x085_restoindennita;
  //Integrazione idennità con i gettoni
  x090_gettoni;
  //Salvataggio Rientri pomeridiani - PARMA_AIPO
  CalcolaRientriPomeridiani;
end;

procedure TR400FCartellinoDtM.CalcolaRientriPomeridiani;
var selT077:TselT077;
begin
  if VarToStr(Q025.Lookup('CODICE',QSDatiAnagrafici.FieldByName('T430PERSELASTICO').AsString,'CAUS_RIENTRIOBBL')) = '' then
    exit;

  with T029P_GETRIENTRIPOMERIDIANI do
  begin
    SetVariable('PROGRESSIVO',A027Progressivo);
    SetVariable('DATA',R180InizioMese(DataDa));
    Execute;
    RientriPomeridiani.DovutiTeorici:=GetVariable('RIENTRI_TEORICI');
    RientriPomeridiani.DovutiReali:=GetVariable('RIENTRI_REALI');
  end;

  selT077:=TselT077.Create(Self);
  try
    selT077.Session:=SessioneOracleR400;
    selT077.Progressivo:=A027Progressivo;
    selT077.Data:=R180AddMesi(R180InizioMese(DataDa),-1);
    RientriPomeridiani.Residuo:=Min(0,StrToIntDef(selT077.LeggiValore(I011RIENTRIPOM_SALDO),0));
    RientriPomeridiani.Saldo:=min(0,RientriPomeridiani.ResiObbligatori + RientriPomeridiani.ResiSupplementari - (RientriPomeridiani.DovutiReali - RientriPomeridiani.Residuo));
    //Lettura eventuali dati manuali già impostati precedentemente
    if (R180InizioMese(DataDa) = DataDa) and (R180FineMese(DataA) = DataA) then
    begin
      selT077.Data:=R180InizioMese(DataDa);
      RientriPomeridiani.ResoManuale:=selT077.LeggiValore(I011RIENTRIPOM_RESI,'M');
      RientriPomeridiani.SaldoManuale:=selT077.LeggiValore(I011RIENTRIPOM_SALDO,'M');
      if StrToIntDef(RientriPomeridiani.ResoManuale,-1) >= 0 then
        RientriPomeridiani.Saldo:=Min(0,StrToInt(RientriPomeridiani.ResoManuale) - (RientriPomeridiani.DovutiReali - RientriPomeridiani.Residuo));
    end;

  finally
    FreeAndNil(selT077);
  end;
end;

procedure TR400FCartellinoDtM.SalvaRientriPomeridiani;
var selT077:TselT077;
begin
  if (RientriPomeridiani.DovutiTeorici = 0) and
     (RientriPomeridiani.ResiObbligatori = 0) and
     (RientriPomeridiani.ResiSupplementari = 0) and
     (RientriPomeridiani.Residuo = 0) and
     (RientriPomeridiani.Saldo = 0) then
  exit;

  selT077:=TselT077.Create(Self);
  try
    selT077.Session:=SessioneOracleR400;
    selT077.Progressivo:=A027Progressivo;
    selT077.Data:=DataDa;
    selT077.ScriviValore(I011RIENTRIPOM_TEORICI,IntToStr(RientriPomeridiani.DovutiTeorici));
    selT077.ScriviValore(I011RIENTRIPOM_REALI,IntToStr(RientriPomeridiani.DovutiReali));
    selT077.ScriviValore(I011RIENTRIPOM_RESI,IntToStr(RientriPomeridiani.ResiObbligatori + RientriPomeridiani.ResiSupplementari));
    selT077.ScriviValore(I011RIENTRIPOM_SALDO,IntToStr(RientriPomeridiani.Saldo));
  finally
    FreeAndNil(selT077);
  end;
end;

procedure TR400FCartellinoDtM.SalvaStraordinarioPT(OreSuppl,OreStr:Integer);
var selT077:TselT077;
begin
  selT077:=TselT077.Create(Self);
  try
    selT077.Session:=SessioneOracleR400;
    selT077.Progressivo:=A027Progressivo;
    selT077.Data:=DataDa;
    selT077.ScriviValore(I011PT_ORE_SUPPL,IntToStr(OreSuppl));
    selT077.ScriviValore(I011PT_ORE_STR,IntToStr(OreStr));
  finally
    FreeAndNil(selT077);
  end;
end;

procedure TR400FCartellinoDtM.SalvaCompensabileMeseEff(Causale:String; OreComp:Integer);
var selT077:TselT077;
begin
  selT077:=TselT077.Create(Self);
  try
    selT077.Session:=SessioneOracleR400;
    selT077.Progressivo:=A027Progressivo;
    selT077.Data:=DataDa;
    selT077.ScriviValore(I011COMPMM_EFF + ':' + Causale,IntToStr(OreComp));
  finally
    FreeAndNil(selT077);
  end;
end;

procedure TR400FCartellinoDtM.SalvaNegativiCompensabili;
var selT077:TselT077;
begin
  //ASTI_ASL
  if not R450DtM1.XParam[XP_R450_NEGATIVI_COMPENSABILI] then
    exit;
  selT077:=TselT077.Create(Self);
  try
    selT077.Session:=SessioneOracleR400;
    selT077.Progressivo:=A027Progressivo;
    selT077.Data:=DataDa;
    selT077.ScriviValore(I011_NEGATIVI_COMPENSABILI,IntToStr(R450DtM1.compnegmes));
  finally
    FreeAndNil(selT077);
  end;
end;

procedure TR400FCartellinoDtM.DeleteT102(Progressivo:Integer; Data:TDateTime; Dato:String = ''; Causale:String = '');
begin
  if not Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    exit;
  if not AggiornamentoScheda then
    exit;
  with delT102 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('MESE_RIEPILOGO',Data);
    SetVariable('DATO',Dato);
    SetVariable('CAUSALE',Causale);
    Execute;
  end;
end;

procedure TR400FCartellinoDtM.InsertT102(Progressivo:Integer; Mese,GG:TDateTime; Dato,Valore:String; Causale:String = ''; Dalle:String = ''; Alle:String = '');
begin
  if not Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    exit;
  if not AggiornamentoScheda then
    exit;
  with insT102 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('MESE_RIEPILOGO',Mese);
    SetVariable('DATA',GG);
    SetVariable('DATO',Dato);
    SetVariable('VALORE',Valore);
    SetVariable('CAUSALE',Causale);
    SetVariable('DALLE',Dalle);
    SetVariable('ALLE',Alle);
    Execute;
  end;
end;

function TR400FCartellinoDtM.GetT050AutStr(P:Integer; D:TDateTime):Integer;
var k,OreEscluse:Integer;
begin
  Result:=0;
  with selT050AutStr do
  begin
    SetVariable('PROGRESSIVO',P);
    SetVariable('DATA',D);
    SetVariable('CAUSALE',TO_CSI_AUT_STR);
    Close;
    Open;
    Result:=FieldByName('STRAORD_AUTORIZZATO').AsInteger;
    Close;
  end;
  k:=R450DtM1.IndiceRiepPres(TO_CSI_STR_ESC);
  if k >= 0 then
  begin
    OreEscluse:=R180SommaArray(R450DtM1.RiepPres[k].OreReseMese);
    OreEscluse:=Trunc(R180Arrotonda(OreEscluse,TO_CSI_STR_AUT_Arrot,'D'));
    if OreEscluse < TO_CSI_STR_AUT_Min then
      OreEscluse:=0;
    Result:=max(0,Result - OreEscluse);
  end;
end;

procedure TR400FCartellinoDtM.LeggiFasceContratto(Anno,Mese:Word);
begin
  R450DtM1.NFasceMese:=0;
  with Q201 do
    begin
    Close;
    SetVariable('Progressivo',A027Progressivo);
    SetVariable('Data',EncodeDate(Anno,Mese,R180GiorniMese(EncodeDate(Anno,Mese,1))));
    Open;
    if RecordCount > 0 then
      while not Eof do
        begin
        inc(R450DtM1.NFasceMese);
        FasceMese[R450DtM1.NFasceMese].Codice:=FieldByName('Codice').AsString;
        FasceMese[R450DtM1.NFasceMese].Maggiorazione:=FieldByName('Maggiorazione').AsInteger;
        Next;
        end;
    Close;
    end;
end;

procedure TR400FCartellinoDtM.x010_azztot(Anno,Mese:Word);
var xx,yy:Integer;
begin
  //Inizializzazione totalizzazioni mensili
  //Azzeramento variabili da cumulare
  debitoposm_sv:=#0;
  deborset:=0;
  salsetatt:=0;
  totminset:=0;
  dimoreset:=0;
  straordsett:=0;
  straordsett_mese:=0;
  ngginser:=0;
  ngglavser:=0;
  ngglavcal:=0;
  NDomenicheServizio:=0;
  nggdetrpo:=0;
  nggpres:=0;
  nggpomer:=0;
  fesintmesT:=0;
  fesridmesT:=0;
  notggmes:=0;
  notminmes:=0;
  nggvuoti:=0;
  RientriPomeridiani.DovutiTeorici:=0;
  RientriPomeridiani.DovutiReali:=0;
  RientriPomeridiani.ResiObbligatori:=0;
  RientriPomeridiani.ResiSupplementari:=0;
  RientriPomeridiani.Residuo:=0;
  RientriPomeridiani.Saldo:=0;
  RientriPomeridiani.ResoManuale:='';
  RientriPomeridiani.SaldoManuale:='';
  for xx:=Low(tindturfasmes) to High(tindturfasmes) do tindturfasmes[xx]:=0;
  n_rppresmes:=0;
  n_rpassemes:=0;
  n_rpindpmes:=0;
  for xx:=Low(trpturfmes) to High(trpturfmes) do trpturfmes[xx]:=0;
  for xx:=Low(trpturgg1) to High(trpturgg1) do trpturgg1[xx]:=0;
  for xx:=Low(trpturgg2) to High(trpturgg2) do trpturgg2[xx]:=0;
  nggpresenza:=0;
  nggFestiviNonGoduti:=0;
  for xx:=Low(totstrfascia) to High(totstrfascia) do totstrfascia[xx]:=0;
  for xx:=Low(totminlavmes) to High(totminlavmes) do totminlavmes[xx]:=0;
  for xx:=Low(TotMese) to High(TotMese) do TotMese[xx]:='';
  RiepTotLav:=0;
  RiepScost:=0;
  RiepScostNeg:=0;
  RiepScostPos:=0;
  RiepCompGG:=0;
  RiepCompNegGG:=0;
  RiepMinLavEsc:=0;
  RiepMinLavCau:=0;
  RiepMinLavCau2:=0;
  RiepMinLavCau3:=0;
  RiepEccedIterDisp:=0;
  RiepDebitoGG:=0;
  RiepDebitoGO:=0;
  RiepDebitoM:=0;
  RiepScostDebito:=0;
  RiepOreLorde:=0;
  RiepProlInib:=0;
  RiepProlNonCaus:=0;
  RiepProlENonCaus:=0;
  RiepProlUNonCaus:=0;
  RiepProlNonCont:=0;
  RiepProlNonCausUscita:=0;
  RiepPresenzaObbligatoria:=0;
  RiepPresenzaFacoltativa:=0;
  RiepCarenzaObbligatoria:=0;
  RiepCarenzaFacoltativa:=0;
  RiepScostFacoltativa:=0;
  RiepPauMenDet:=0;
  RiepIndPres:=0;
  RiepIndFest:=0;
  RiepIndNot:=0;
  RiepNumNot:=0;
  RiepCoperturaCarenza:=0;
  NGIndNotFes:=0;
  NGIndPres:=0;
  OreInailMes:=0;
  RiepPastiConv:=0;
  RiepPastiInt:=0;
  RiepBuoniPasto:=0;
  RiepFeNNG:=0;
  for xx:=Low(indnot_giorno) to High(indnot_giorno) do
  begin
    indnot_giorno[xx].Arr:=0;
    indnot_giorno[xx].Ore:=0;
    indnot_giorno[xx].Toll:=0;
    for yy:=1 to 4 do indnot_giorno[xx].EccGio[yy]:=0;
  end;
  for xx:=Low(indfes_giorno) to High(indfes_giorno) do
  begin
    indfes_giorno[xx].Debito:=0;
    indfes_giorno[xx].Ore:=0;
    for yy:=1 to 4 do indfes_giorno[xx].EccGio[yy]:=0;
  end;
  for xx:=Low(indpres_giorno) to High(indpres_giorno) do
  begin
    indpres_giorno[xx].Ind:=0;
    indpres_giorno[xx].IndAss:='';
    indpres_giorno[xx].Turno:=0;
    indpres_giorno[xx].PartTime:=0;
    indpres_giorno[xx].OreRese:=0;
    indpres_giorno[xx].OreInt:=0;
    indpres_giorno[xx].OreMez:=0;
    indpres_giorno[xx].DebitoGG:=0;
    indpres_giorno[xx].OreLavPres:=0;
    indpres_giorno[xx].MaturaAssenze:=False;
    //indpres_giorno[xx].CausAss:='';
    SetLength(indpres_giorno[xx].RiepAss,0);
    indpres_giorno[xx].IndSpett:='';
    for yy:=1 to 10 do indpres_giorno[xx].CodInd[yy]:='';
    SetLength(indpres_giorno[xx].DatiGGIndTurnoI,0);
  end;
  for xx:=Low(DomenicheLavorate) to High(DomenicheLavorate) do
  begin
    DomenicheLavorate[xx].Data:=0;
    DomenicheLavorate[xx].Eccedenza:=0;
    DomenicheLavorate[xx].IndFes:=0;
    DomenicheLavorate[xx].Posizione:=0;
  end;
  NDomeniche:=0;
  NRecuperiFestivi:=0;
  for xx:=Low(RecuperiFestivi) to High(RecuperiFestivi) do RecuperiFestivi[xx]:=0;
  for xx:=Low(FascePaghe276Tot) to High(FascePaghe276Tot) do
  begin
    FascePaghe276Tot[xx].Ore:=0;
    FascePaghe276Tot[xx].VocePaghe:='';
  end;
  with R450DtM1 do
  begin
    poflag:=#0;
    debormes:=0;
    debggtot:=0;
    debpomes:=0;
    debpo_percptmes:=0;
    scostmes:=0;
    eccsolocompmes:=0;
    EccSoloCompMesOltreSoglia:=0;
    scostfasciames:=0;
    minassenzemes:=0;
    vareccliqmes:=0;
    for xx:=1 to MaxFasce do
    begin
      tminlavmes[xx]:=0;
      tmininturno[xx]:=0;
      tminstrmen[xx]:=0;
      tstrannom[xx]:=0;
      tstrliqmm[xx]:=0;
      tLiqNelMese[xx]:=0;
      tdatiassestamen[1].tminassest[xx]:=0;
      tdatiassestamen[2].tminassest[xx]:=0;
    end;
    tdatiassestamen[1].tcauassest:='';
    tdatiassestamen[2].tcauassest:='';
    scostnegmes:=0;
    compnegmes:=0;
    abbannoprecmes:=0;
    abbannoattmes:=0;
    abbliqannoprecmes:=0;
    abbliqannoattmes:=0;
    OreCompRecuperate:=0;
    ripcommes:=0;
    abbripcommes:=0;
  end;
  SetLength(RiepGettoni,0);
  SetLength(StrGGdelMese,0);
end;

procedure TR400FCartellinoDtM.GetCartellinoIstituti(Anno,Mese:Word);
{Ricerca tipo cartellino e tipo riepilogo istituti di inizio mese in storico}
var //QSConteggiMese:TQueryStorico;
    FineMese,MesePrec,FineAnno:TDateTime;
begin
  minscostset_min:=0;
  s_tiporiepist:='N';
  c_tipocart_att:='M';
  c_tipocart_prec:='M';
  MesePrec:=EncodeDate(Anno,Mese,1) - 1;
  FineMese:=EncodeDate(Anno,Mese,R180GiorniMese(EncodeDate(Anno,Mese,1)));
  FineAnno:=EncodeDate(Anno,12,31);
  QSDatiAnagrafici.GetDatiStorici(DatiStorici,A027Progressivo,MesePrec,FineAnno);
  //Lettura dei parametri a fine mese
  if QSDatiAnagrafici.LocDatoStorico(FineMese) then
    with Q025 do
      if Locate('CODICE',QSDatiAnagrafici.FieldByName('T430PERSELASTICO').AsString,[]) then
      begin
        //Conteggio turno notturno su entrata
        //Scostamento settimanale permesso
        minscostset_min:=R180OreMinutiExt(FieldByName('SCOSTSETT').AsString);
        //Lettura periodicità degli istituti
        s_tiporiepist:=FieldByName('ISTITUTI').AsString;
        if (s_tiporiepist <> 'M') and (s_tiporiepist <> 'S') then
          s_tiporiepist:='N';
        //Lettura tipo cartellino del mese corrente
        c_tipocart_att:=FieldByName('CARTELLINO').AsString;
        c_tipocart_prec:=c_tipocart_att;
        //Lettura tipo cartellino del mese precedente
        if QSDatiAnagrafici.LocDatoStorico(Meseprec) then
          if Locate('CODICE',QSDatiAnagrafici.FieldByName('T430PERSELASTICO').AsString,[]) then
            c_tipocart_prec:=FieldByName('CARTELLINO').AsString;
      end;
end;

procedure TR400FCartellinoDtM.d113_tipocart(Anno,Mese,GGDa:Word);
{Riconoscimento di passaggio cartellino da Mens a Sett e calcolo del giorno di inizio}
begin
  numcorrmenset:=0;
  //Nessun cambio del tipo cartellino dal mese precedente
  if (c_tipocart_prec = c_tipocart_att) or (GGDa > 1) then
    begin
    s_cambiomenset:='NO';
    exit;
    end;
  if c_tipocart_prec = 'M' then
    //Cambio del tipo cartellino da mensile a settimanale
    begin
    s_cambiomenset:='MS';
    numcorrmenset:=EncodeDate(Anno,Mese,1);
    end
  else
    //Cambio del tipo cartellino da settimanale a mensile
    begin
    s_cambiomenset:='SM';
    numcorrmenset:=EncodeDate(Anno,Mese,1);
    //Calcolo numero corrispondente al primo lunedi che precede il
    //primo giorno da stampare compreso
    numcorrmenset:=numcorrmenset - DayOfWeek(numcorrmenset - 1) + 1;
    end;
end;

procedure TR400FCartellinoDtM.d115a_numcorr(Anno,Mese,GGDa,GGA:Word);
{Calcolo numero corrispondente alla data iniziale}
begin
  nciniistit:=EncodeDate(Anno,Mese,GGDa);
  ncinisaldi:=nciniistit;
  if s_cambiomenset = 'SM' then
    //Cambio da settimanale a mensile: i saldi partono dal lunedi'
    //precedente il primo del mese
    begin
    ncinisaldi:=numcorrmenset;
    if s_tiporiepist = 'S' then
      //Se il riepilogo istituti e' settimanale parte come i saldi
      nciniistit:=numcorrmenset;
    end;
  (*Calcolo numero corrispondente al primo giorno da
    conteggiare che coincide con l'ultima Domenica precedente
    la data iniziale se non e' essa stessa di Domenica;
    inoltre, si conteggiano comunque i due giorni precedenti
    la data iniziale*)
  if DayOfWeek(EncodeDate(Anno,Mese,GGDa) - 1) in [1,7] then
    numcorrinizconte:=ncinisaldi - 2
  else
    numcorrinizconte:=ncinisaldi - DayOfWeek(EncodeDate(Anno,Mese,GGDa) - 1);
  //Calcolo numero corrispondente alla data finale
  ncfinistit:=EncodeDate(Anno,Mese,GGA);
  ncfinsaldi:=ncfinistit;
  ncinidipser:=ncinisaldi;
end;

procedure TR400FCartellinoDtM.d115b_numcorr(Anno,Mese,GGDa,GGA:Word);
{Cartellino settimanale: calcolo il primo lunedi precedente e la data inizio cartolina per saldi e istituti (ass./ind.)}
begin
  //Calcolo data del primo giorno da stampare
  nciniistit:=EncodeDate(Anno,Mese,GGDa);
  //Calcolo data del primo lunedi da considerare
  ncinisaldi:=R180InizioMeseSettimanale(nciniistit,not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
  if s_cambiomenset = 'MS' then
    ncinisaldi:=numcorrmenset;
  ncinidipser:=ncinisaldi;
  //Calcolo data finale istituti
  ncfinistit:=EncodeDate(Anno,Mese,GGA);
  //Calcolo data finale saldi
  ncfinsaldi:=R180FineMeseSettimanale(ncfinistit,not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
  //Se anche i riepiloghi istituti sono settimanali allora il periodo è uguale a quello dei saldi
  if s_tiporiepist <> 'M' then
  begin
    nciniistit:=ncinisaldi;
    ncfinistit:=ncfinsaldi;
  end;
end;

procedure TR400FCartellinoDtM.d116_cerco1gg;
{verifico se il dipendente è in servizio}
var A,M,G,A2,M2,G2:Word;
begin
    try
      DecodeDate(DataDa,A,M,G);
      dipinser1:='si';
      InServizio2.Close;
      InServizio2.SetVariable('Fine',DataA);
      InServizio2.SetVariable('Progressivo',A027Progressivo);
      InServizio2.Open;
      if InServizio2.Fields[0].AsInteger = 0 then
        begin
        InServizio1.Close;
        InServizio1.SetVariable('Inizio',DataDa);
        InServizio1.SetVariable('Fine',DataA);
        InServizio1.SetVariable('Progressivo',A027Progressivo);
        InServizio1.Open;
        if InServizio1.Fields[0].AsInteger = 0 then
          begin
          dipinser1:='no';
          //Giorno:=G;
          InServizio1.Close;
          InServizio2.Close;
          exit;
          end;
        end;
      InServizio2.Close;
    except
    end;

  //Sembra che non serva a niente
  if A027SelAnagrafe <> nil then
    DecodeDate(A027SelAnagrafe.FieldByName('T430Inizio').AsDateTime,A2,M2,G2);
end;

procedure TR400FCartellinoDtM.d117_stampo(Anno,Mese,GGDa,GGA:Word);
{Gestione della stampa del cartellino settimanale e mensile}
var A,M,G,Giorno:Word;
    datacon_back:TDateTime;
begin
  //Stampa cartellino settimanale
  s_saltoggnontot:='si';
  //move m-data to m-data-sv.
  //I conteggi iniziano tre giorni prima
  DecodeDate(ncinisaldi - 3,A,M,G);
  carico(A,M);
  if M <> Mese then
  begin
    s_carico:='si';
    c_finsetprec:=R180GiorniMese(ncinisaldi - 3);
  end
  else
  begin
    s_carico:='no';
    c_finsetprec:=GGDa - 1;
  end;
  //Conteggi per i giorni eventuali del mese precedente
  for Giorno:=G to c_finsetprec do
    e020_stamriga(A,M,Giorno,True);
  //move m-data-sv to m-data.
  if (*(c03_tipocart = 'S') and*) (s_carico = 'si') then
    GGDa:=1;
  //Conteggi per il mese attuale
  (*if (c03_tipocart = 'S') or (s_cambiomenset = 'SM') then
    if R502ProDtM1.blocca <> 0 then exit;*)
  if s_carico = 'si' then
  begin
    datacon_back:=R502ProDtM1.datacon;
    carico(Anno,Mese);
    R502ProDtM1.datacon:=datacon_back;
  end;
  AnomaliaBloccante:=False;
  lstAnomalie.Clear; // validazione web - daniloc 19.03.2012
  lstAnomalieMM.Clear;
  for Giorno:=GGDa to GGA do
    e020_stamriga(Anno,Mese,Giorno,True);

  DecodeDate(ncfinsaldi,A,M,G);
  if M <> Mese then
  begin
    carico(A,M);
    for Giorno:=1 to G do
      e020_stamriga(A,M,Giorno,True);
  end;
end;

procedure TR400FCartellinoDtM.conte(Data:TDateTime);
{Chiamata ai conteggi con totalizzazioni}
begin
  R502ProDtM1.Conteggi('Cartolina',A027Progressivo,Data);
  //Controllo se saltare il giorno per i saldi e gli istituti
  e022_saltogg;
  x025_CumuloFasce;
  x018_registraindpres;
  //Totalizzazioni e pianificazione automatica (se necessarie)
  x020_vertotalizz;
end;

function TR400FCartellinoDtM.EsisteInRiepilogo(X:Integer):Boolean;
{Restituisce True se il dato specificato da X esiste nella Banda di Riepilogo}
var i:Integer;
begin
  Result:=False;
  for i:=0 to lstRiepilogo.Count - 1 do
    if StrToIntDef(lstRiepilogo[i],-1) = X then
    begin
      Result:=True;
      Break;
    end;
  (*for i:=0 to A027StampaTimb.Riepilogo.ControlCount - 1 do
    if A027StampaTimb.Riepilogo.Controls[i].Tag = X then
      begin
      Result:=True;
      Break;
      end;*)
end;

function TR400FCartellinoDtM.EsisteDato(X:Integer):Boolean;
{Restituisce True se il dato specificato da X esiste nella Banda di dettaglio}
var i:Integer;
begin
  Result:=False;
  for i:=0 to lstDettaglio.Count - 1 do
    if StrToIntDef(lstDettaglio[i],-1) = X then
    begin
      Result:=True;
      Break;
    end;
end;

procedure TR400FCartellinoDtM.finepag;
var S,TipoIndennita:String;
    i,T:Integer;
    LSort:TStringList;
    A,M,G:Word;
    Giustif:TGiustificativo;
  procedure CreaRiepilogoStampaIndPres;
  var Trovato:Boolean;
      i,j:integer;
  begin
    SetLength(trpindpmes_stampa,n_rpindpmes);
    for i:=1 to n_rpindpmes do
      trpindpmes_stampa[i - 1]:=trpindpmes[i];
    //Elimino le idennità con conguaglio plurimensile calcolate dai conteggi
    for i:=High(trpindpmes_stampa) downto 0 do
    begin
      if selT162.SearchRecord('CODICE',trpindpmes_stampa[i].tcodindpmes,[srFromBeginning]) then
      begin
        if R180In(selT162.FieldByName('TIPO').AsString,['P']) and
           (selT162.FieldByName('NMESI_EQUITURNI').AsInteger > 1) and
           (selT162.FindField('CONGUAGLIO_EQUITURNI') <> nil) and
           (selT162.FieldByName('CONGUAGLIO_EQUITURNI').AsString = 'S')
         then
         begin
           for j:=i + 1 to High(trpindpmes_stampa) do
             trpindpmes_stampa[j - 1]:=trpindpmes_stampa[j];
           SetLength(trpindpmes_stampa,Length(trpindpmes_stampa) - 1);
         end;
      end;
    end;
    //Aggiungo le idennità con conguaglio plurimensile da tabella T072
    R180SetVariable(selT072CongEquiTurni,'PROGRESSIVO',A027Progressivo);
    R180SetVariable(selT072CongEquiTurni,'DATA',DataDa);
    with selT072CongEquiTurni do
    try
      Open;
      First;
      while not Eof do
      begin
        SetLength(trpindpmes_stampa,Length(trpindpmes_stampa) + 1);
        i:=High(trpindpmes_stampa);
        trpindpmes_stampa[i].tcodindpmes:=FieldByName('CODINDPRES').AsString;
        trpindpmes_stampa[i].tggindpmes:=FieldByName('INDPRES').AsFloat;
        trpindpmes_stampa[i].RestoIndSup:=0;
        trpindpmes_stampa[i].RestoIndSupPrec:=0;
        trpindpmes_stampa[i].Importo:=FieldByName('IMPORTO').AsFloat;
        Next;
      end;
    except
    end;
    //Aggiungo le variazioni manuali lette da tabella T072
    R180SetVariable(selT072M,'PROGRESSIVO',A027Progressivo);
    R180SetVariable(selT072M,'DATA',DataDa);
    with selT072M do
    begin
      Open;
      First;
      while not Eof do
      begin
        Trovato:=False;
        for i:=0 to High(trpindpmes_stampa) do
        begin
          if trpindpmes_stampa[i].tcodindpmes = FieldByName('CODINDPRES').AsString then
          begin
            trpindpmes_stampa[i].tggindpmes:=trpindpmes_stampa[i].tggindpmes + FieldByName('INDPRES').AsFloat;
            Trovato:=True;
            Break;
          end;
        end;
        if not Trovato then
        begin
          SetLength(trpindpmes_stampa,Length(trpindpmes_stampa) + 1);
          i:=High(trpindpmes_stampa);
          trpindpmes_stampa[i].tcodindpmes:=FieldByName('CODINDPRES').AsString;
          trpindpmes_stampa[i].tggindpmes:=FieldByName('INDPRES').AsFloat;
          trpindpmes_stampa[i].RestoIndSup:=0;
          trpindpmes_stampa[i].RestoIndSupPrec:=0;
          trpindpmes_stampa[i].Importo:=FieldByName('IMPORTO').AsFloat;
        end;
        Next;
      end;
    end;
  end;
  function GetOrePersePeriodicheSucc:String;
  var locR400:TR400FCartellinoDtM;
      Data:TDateTime;
  begin
    locR400:=TR400FCartellinoDtM.Create(nil);
    try
      (locR400 as TR400FCartellinoDtM).A027SelAnagrafe:=nil;
      (locR400 as TR400FCartellinoDtM).SoloAggiornamento:=False;
      (locR400 as TR400FCartellinoDtM).NumGiorniCartolina:=0;
      locR400.Name:='R400GetOrePersePeriodicheSucc';
      Data:=R180FineMese(R180AddMesi(DataA,1));
      Data:=min(Date,Data);
      try
        //Eseguo la cartolina fino alla Data di conteggio
        (locR400 as TR400FCartellinoDtM).CartolinaDipendente(A027Progressivo,R180Anno(Data),R180Mese(Data),1,R180Giorno(Data));
        //Considero il saldo complessivo al lordo della liquidazione di straordinario che se presente riguarda tutto il mese.
        Result:=R180MinutiOre((locR400 as TR400FCartellinoDtM).R450DtM1.OrePersePeriodiche);
      except
      end;
    finally
      FreeAndNil(locR400);
    end;
  end;
begin
  //Per il cartellino settimanale tolgo dalle ore lav. partendo dalla
  //fascia piu' bassa le ore tolte ogni settimana per minuti minimi di
  //scostamento settimanale
  for i:=1 to R450DtM1.NFasceMese do
  begin
    if dimoreset = 0 then Break;
    if R450DtM1.tminlavmes[i] > dimoreset then
    begin
      dec(R450DtM1.tminlavmes[i],dimoreset);
      dimoreset:=0;
    end
    else
      if R450DtM1.tminlavmes[i] > 0 then
      begin
        R450DtM1.tminlavmes[i]:=0;
        dec(dimoreset,R450DtM1.tminlavmes[i]);
      end;
  end;
  if dimoreset > 0 then
    dec(R450DtM1.tminlavmes[1],dimoreset);
  //Lettura contratto: fatto prima in CartolinaDipendente
  LimitiMensiliCausalizzati;  //Genova_Comune?
  CompensazioneScostNegativi; //ReggioEmilia_Comune

  //SALDI DI FINE CARTOLINA
  x030_totfin;
  //RIEPILOGO ASSENZE
  CompletaRiepilogoAssenze;
  //RIEPILOGO PRESENZE
  CompletaRiepilogoPresenze;
  //Totali giornalieri
  ScriviTotaliGiornalieri;
  //if R502ProDtM1.Q200.FieldByName('Tipo').AsString = 'USL' then
  if R502ProDtM1.T200[R502ProDtM1.Q200.FieldByName('Tipo').Index] = 'USL' then
    TipoIndennita:='Indennità notturna gg/ore ='
  else
    TipoIndennita:='Indennità di turno gg/ore =';
  toteccliq:=0;
  for i:=1 to R450DtM1.NFasceMese do
    toteccliq:=toteccliq + (R450DtM1.tstrannom[i] - R450DtM1.tstrliq[i]);
  //Stampa dati riepilogativi
  with R450DtM1 do
  begin
    //Fasce di maggiorazione
    S:='';
    for i:=1 to R450DtM1.NFasceMese do
      S:=S + R180DimLungR(FasceMese[i].Codice,6);
    StrFasceStampa:=Copy(S,2,Length(S));
    //Debito totale mese
    VetRiepStampa[1]:=R180MinutiOre(Debtotmes);
    //Debito contrattuale mese
    VetRiepStampa[66]:=R180MinutiOre(Debormes);
    //Debito aggiuntivo mese
    VetRiepStampa[67]:=R180MinutiOre(Debpomes);
    //Debito aggiuntivo da inizio anno
    VetRiepStampa[105]:=R180MinutiOre(DebpoAnno);
    //Debito aggiuntivo residuo
    VetRiepStampa[106]:=R180MinutiOre(debpoannores);
    //Debito aggiuntivo reso nel mese
    VetRiepStampa[107]:=R180MinutiOre(debpoeff);
    //Debito aggiuntivo reso da inizio anno
    VetRiepStampa[108]:=R180MinutiOre(DebPOAnno - debpoannores);
    //Totale ore lavorate
    VetRiepStampa[2]:=R180MinutiOre(Totoreres);
    //Ore rese da assenza
    VetRiepStampa[27]:=R180MinutiOre(minassenzemes);
    //Ore rese da presenza
    VetRiepStampa[28]:=R180MinutiOre(Totoreres - minassenzemes);
    (*LaSpezia - Inizio*)
    //Ore obbligatorie rese
    VetRiepStampa[89]:=R180MinutiOre(RiepPresenzaObbligatoria);
    //Ore obbligatorie carenti
    VetRiepStampa[90]:=R180MinutiOre(-RiepCarenzaObbligatoria);
    //Ore facoltative rese
    VetRiepStampa[91]:=R180MinutiOre(RiepPresenzaFacoltativa);
    //Ore facoltative carenti
    VetRiepStampa[92]:=R180MinutiOre(-RiepCarenzaFacoltativa);
    //Ore obbligatorie carenti da inizio anno
    VetRiepStampa[93]:=R180MinutiOre(Min(0,VarEccLiqAnno));
    //Ore facoltative scostate da (debitogg - PresenzaFacoltativa)
    VetRiepStampa[94]:=R180MinutiOre(RiepScostFacoltativa);
    //Saldo ore facoltative (Compensabile complessivo - Variazioni eccedenze per liquidazione)
    VetRiepStampa[95]:=R180MinutiOre(salcompannoprec + salcompannoatt - Min(0,VarEccLiqAnno));
    (*LaSpezia - Fine*)
    //Eccedenza liquidabile mensile in fasce e totale
    S:='';
    for i:=1 to NFasceMese do
      S:=S + R180DimLungR(R180MinutiOre(tstrmese[i]),8);
    VetRiepStampa[4]:=Copy(S,2,Length(S));
    VetRiepStampa[122]:=R180MinutiOre(R180SommaArray(tstrmese));
    //Eccedenza liquidabile da inizio anno in fasce e totale
    S:='';
    for i:=1 to NFasceMese do
        S:=S + R180DimLungR(R180MinutiOre(tstrannom[i]),8);
    VetRiepStampa[5]:=Copy(S,2,Length(S));
    VetRiepStampa[123]:=R180MinutiOre(R180SommaArray(tstrannom));
    //Saldo anno complessivo
    VetRiepStampa[6]:=R180MinutiOre(salannoatt);
    //Saldo anno complessivo al netto del liquidato del mese
    VetRiepStampa[50]:=R180MinutiOre(salannonetto);
    //Saldo anno attuale con causali
    VetRiepStampa[112]:=R180MinutiOre(salannoatt + OreCausAnnoIncluseSaldi);
    //Straordinario liquidato da inizio anno in fasce e totale
    S:='';
    for i:=1 to R450DtM1.NFasceMese do
      S:=S + R180DimLungR(R180MinutiOre(tstrliq[i]),8);
    VetRiepStampa[7]:=Copy(S,2,Length(S));
    VetRiepStampa[124]:=R180MinutiOre(R180SommaArray(tstrliq));
    //Residuo liquidabile in fasce e totale
    S:='';
    for i:=1 to R450DtM1.NFasceMese do
      S:=S + R180DimLungR(R180MinutiOre(tstrannom[i] - tstrliq[i]),8);
    VetRiepStampa[8]:=Copy(S,2,Length(S));
    VetRiepStampa[125]:=R180MinutiOre(R180SommaArray(tstrannom) - R180SommaArray(tstrliq));
    //Str.liq.to nel mese in fasce e totale
    S:='';
    for i:=1 to NFasceMese do
      S:=S + R180DimLungR(R180MinutiOre(tLiqNelMese[i]),8);
    VetRiepStampa[9]:=Copy(S,2,Length(S));
    VetRiepStampa[126]:=R180MinutiOre(R180SommaArray(tLiqNelMese));

    VetRiepStampa[10]:=R180MinutiOre(Eccsolocompmes);
    VetRiepStampa[11]:=R180MinutiOre(Eccsolocompanno);
    VetRiepStampa[12]:=R180MinutiOre(Eccsolocompres);
    VetRiepStampa[13]:=FloatToStr(FesintmesT + fesintmesVar);
    VetRiepStampa[14]:=FloatToStr(FesridmesT + fesridmesVar);
    VetRiepStampa[15]:=IntToStr(Notggmes + notggmesVar);
    VetRiepStampa[16]:=R180MinutiOre(Notminmes + R180OreMinutiExt(notminmesVar));
    VetRiepStampa[109]:=IntToStr(nggFestiviNonGoduti);
    //Indennità di presenza
    VetRiepStampa[17]:='';
    //Alberto 12/02/2019: si riportano anche le variazioni manuali
    CreaRiepilogoStampaIndPres;
    for i:=0 to High(trpindpmes_stampa) do
    begin
      if trpindpmes_stampa[i].tggindpmes > 0 then
        VetRiepStampa[17]:=VetRiepStampa[17] +
                           Format('%s(%f)=%2.1f ',[trpindpmes_stampa[i].tcodindpmes,trpindpmes_stampa[i].Importo,trpindpmes_stampa[i].tggindpmes]);
    end;
    //Saldo mese con l'eventuale liquidato
    VetRiepStampa[3]:=R180MinutiOre(SalMeseAtt);
    //Saldo mese lordo
    VetRiepStampa[18]:=R180MinutiOre(TotOreRes - DebTotMes + IfThen(Parametri.CampiRiferimento.C32_SaldoMeseCompensato = 'S',OreEsclComp));
    //Saldo mese netto = saldo mese lordo - liquidato nel mese
    T:=R180SommaArray(tLiqNelMese) + OreCausLiqIncluse;
    VetRiepStampa[45]:=R180MinutiOre(TotOreRes - DebTotMes - T + IfThen(Parametri.CampiRiferimento.C32_SaldoMeseCompensato = 'S',OreEsclComp));
    //Saldo mese netto con causali
    VetRiepStampa[111]:=R180MinutiOre(TotOreRes - DebTotMes - T + IfThen(Parametri.CampiRiferimento.C32_SaldoMeseCompensato = 'S',OreEsclComp) + OreCausMeseIncluseSaldi);
    //Saldo al mese precedente
    VetRiepStampa[25]:=R180MinutiOre(salfmprec);
    //Saldo al mese precedente al netto delle ore liquidate del mese
    VetRiepStampa[49]:=R180MinutiOre(salfmprecnetto);
    //Liquidabile al mese precedente
    VetRiepStampa[72]:=R180MinutiOre(RiepilogoPrecedente.LiquidabileAtt + RiepilogoPrecedente.LiquidabilePrec);
    //Compensabile al mese precedente
    VetRiepStampa[73]:=R180MinutiOre(RiepilogoPrecedente.CompensabileAtt + RiepilogoPrecedente.CompensabilePrec);
    //Banca ore residua al mese prec.
    VetRiepStampa[74]:=R180MinutiOre(RiepilogoPrecedente.BancaOreResidua +  RiepilogoPrecedente.BancaOreResiduaPrec);
    //Banca ore anno prec. al mese prec.
    VetRiepStampa[87]:=R180MinutiOre(RiepilogoPrecedente.BancaOreResiduaPrec);
    //Banca ore anno att. al mese prec.
    VetRiepStampa[84]:=R180MinutiOre(RiepilogoPrecedente.BancaOreResidua);
    //Compensabile senza Banca ore residua al mese prec.
    if (RiepilogoPrecedente.StrResiduoAnno > 0) and (SaldoNegativoMinimoTipo = '2') then //COMUNEDIGENOVA
      VetRiepStampa[75]:=
        R180MinutiOre(RiepilogoPrecedente.CompensabileAtt +
                      RiepilogoPrecedente.CompensabilePrec -
                      RiepilogoPrecedente.BancaOreResidua -
                      RiepilogoPrecedente.BancaOreResiduaPrec -
                      Max(0,RiepilogoPrecedente.StrResiduoAnno - RiepilogoPrecedente.LiquidabileAtt))
    else
      VetRiepStampa[75]:=
        R180MinutiOre(RiepilogoPrecedente.CompensabileAtt +
                      RiepilogoPrecedente.CompensabilePrec -
                      RiepilogoPrecedente.BancaOreResidua -
                      RiepilogoPrecedente.BancaOreResiduaPrec);
    //Limito i saldi al mese precedenti nel caso di regime debito/credito (Provincia Torino)
    if (SaldoNegativoMinimoTipo = '1') and (SaldoNegativoMinimo < 0) then
    begin
      VetRiepStampa[25]:=R180MinutiOre(max(R180OreMinutiExt(VetRiepStampa[25]),SaldoNegativoMinimo));
      VetRiepStampa[49]:=R180MinutiOre(max(R180OreMinutiExt(VetRiepStampa[49]),SaldoNegativoMinimo));
      VetRiepStampa[75]:=R180MinutiOre(max(R180OreMinutiExt(VetRiepStampa[75]),SaldoNegativoMinimo));
    end;
    //Scostamenti negativi del mese
    VetRiepStampa[46]:=R180MinutiOre(scostnegmes);
    //Eccedenza liquidabile del mese in fasce e totale
    S:='';
    for i:=1 to NFasceMese do
      S:=S + R180DimLungR(R180MinutiOre(tminstrmen[i]),8);
    VetRiepStampa[47]:=Copy(S,2,Length(S));
    VetRiepStampa[128]:=R180MinutiOre(R180SommaArray(tminstrmen));
    //Ore lavorate nel mese in fasce e totale
    S:='';
    for i:=1 to NFasceMese do
      S:=S + R180DimLungR(R180MinutiOre(tminlavmes[i]),8);
    VetRiepStampa[48]:=Copy(S,2,Length(S));
    VetRiepStampa[129]:=R180MinutiOre(R180SommaArray(tminlavmes));
    //Ore timbrate nel mese in fasce e totale
    S:='';
    for i:=1 to NFasceMese do
      if i = 1 then
        S:=S + R180DimLungR(R180MinutiOre(tminlavmes[i] - minassenzemes),8)
      else
        S:=S + R180DimLungR(R180MinutiOre(tminlavmes[i]),8);
    VetRiepStampa[130]:=R180MinutiOre(R180SommaArray(tminlavmes) - minassenzemes);
    VetRiepStampa[79]:=Copy(S,2,Length(S));
    //Ore di turno del mese in fasce e totale
    S:='';
    for i:=1 to NFasceMese do
      S:=S + R180DimLungR(R180MinutiOre(tmininturno[i]),8);
    VetRiepStampa[78]:=Copy(S,2,Length(S));
    VetRiepStampa[77]:=R180MinutiOre(R180SommaArray(tmininturno));
    //Saldo anno precedente
    VetRiepStampa[20]:=R180MinutiOre(l13_sallav_min);
    //Saldo ore compensabili anno precedente
    VetRiepStampa[37]:=R180MinutiOre(salcompannoprec);
    //Saldo ore liquidabili anno precedente
    VetRiepStampa[38]:=R180MinutiOre(salliqannoprec);
    //Saldo ore compensabili anno attuale
    VetRiepStampa[39]:=R180MinutiOre(salcompannoatt);
    //Saldo ore liquidabili anno attuale
    VetRiepStampa[40]:=R180MinutiOre(salliqannoatt);
    //Ore di abbattimento dell'anno precedente
    VetRiepStampa[41]:=R180MinutiOre(abbannopreceff);
    //Ore di abbattimento dell'anno corrente
    VetRiepStampa[42]:=R180MinutiOre(abbannoatteff);
    //Saldo liquidabile + compensabile anno precedente
    VetRiepStampa[43]:=R180MinutiOre(salliqannoprec + salcompannoprec);
    //Saldo liquidabile + compensabile anno attuale
    VetRiepStampa[44]:=R180MinutiOre(salliqannoatt + salcompannoatt);
    //Saldo compensabile complessivo
    VetRiepStampa[29]:=R180MinutiOre(salcompannoprec + salcompannoatt);
    //Saldo liquidabile complessivo
    VetRiepStampa[30]:=R180MinutiOre(salliqannoprec + salliqannoatt);
    //Ore negative al mese precedente addebitate
    VetRiepStampa[80]:=R180MinutiOre(AddebitoPaghe);
    //Ore negative oltre il saldo negativo minimo nel regime debito/credito
    VetRiepStampa[113]:=R180MinutiOre(SaldoNegativoMinimoEcced);
    //Ore recuperate nel regime debito/credito
    VetRiepStampa[114]:=R180MinutiOre(max(0,RiepilogoPrecedente.SaldoNegativoMinimoEcced - AddebitoPaghe));
    //Ore escluse dalle normali compensabili
    VetRiepStampa[88]:=R180MinutiOre(OreEsclComp);
    //Ore perse in seguito all'azzeramento del saldo periodico
    VetRiepStampa[81]:=R180MinutiOre(OrePersePeriodiche);
    (*Ipotesi per richiesta di LASPEZIA di visualizzare le ore che sarebbero perse il mese successivo
    if Self.Name <> 'R400GetOrePersePeriodicheSucc' then
      VetRiepStampa[81]:=VetRiepStampa[81] + '-' + GetOrePersePeriodicheSucc;
    *)
    //Ore troncate
    VetRiepStampa[19]:=R180MinutiOre(OreTroncate);
    //Saldo negativo recuperato con riepilogo assenza (Messina_Universita)
    VetRiepStampa[132]:=R180MinutiOre(RiepAssCompensateAnno);
    //Saldo anno liquidato
    VetRiepStampa[76]:=R180MinutiOre(LiqOreAnniPrec);
    //Variazioni saldo anno
    VetRiepStampa[83]:=R180MinutiOre(VariazioneSaldo);
    //Causale di assestamento 1
    VetRiepStampa[21]:=VarToStr(Q305.Lookup('Codice',tdatiassestamen[1].tcauassest,'Descrizione'));
    //Ore di assestamento 1
    if Trim(VetRiepStampa[21]) <> '' then
      VetRiepStampa[22]:=R180MinutiOre(R180SommaArray(tdatiassestamen[1].tminassest))
    else
      VetRiepStampa[22]:='';
    //Causale di assestamento 2
    VetRiepStampa[23]:=VarToStr(Q305.Lookup('Codice',tdatiassestamen[2].tcauassest,'Descrizione'));
    //Ore di assestamento 1
    if Trim(VetRiepStampa[23]) <> '' then
      VetRiepStampa[24]:=R180MinutiOre(R180SommaArray(tdatiassestamen[2].tminassest))
    else
      VetRiepStampa[24]:='';
    //Ore causalizzate in fasce a blocchi (AMGAS Bari)
    LSort:=TStringList.Create;
    for i:=0 to High(FascePaghe276Tot) do
      begin
      if FascePaghe276Tot[i].VocePaghe = '' then
        Break;
      LSort.Add(FascePaghe276Tot[i].VocePaghe + '=' + R180MinutiOre(FascePaghe276Tot[i].Ore));
      end;
    LSort.Sort;
    S:='';
    for i:=0 to LSort.Count - 1 do
      begin
      if S <> '' then
        S:=S + ' ';
      S:=S + LSort[i];
      end;
    LSort.Free;
    VetRiepStampa[65]:=S;
    //Straordinario autorizzato nell'anno da contratto
    VetRiepStampa[32]:=R180MinutiOre(EccAutAnno['LIQUIDABILE']);
    //Straordinario autorizzato nel mese
    VetRiepStampa[82]:=R180MinutiOre(StrAutMen);
    //Eccedenza residuabile autorizzata
    VetRiepStampa[26]:=R180MinutiOre(EccResAutMen);
    //Riposi compensativi maturati
    VetRiepStampa[53]:=R180MinutiOre(ripcommes);
    //Riposi compensativi abbattuti
    VetRiepStampa[54]:=R180MinutiOre(abbripcommes + RipComLiqMes);
    //Saldo riposi compensativi
    VetRiepStampa[55]:=R180MinutiOre(salripcom);
    //Saldo riposi compensativi mensile
    VetRiepStampa[56]:=R180MinutiOre(salripcommes);
    //Saldo riposi compensativi al mese precedente
    VetRiepStampa[60]:=R180MinutiOre(salripcomfmprec);
    //Buoni mensa maturati
    VetRiepStampa[51]:=IntToStr(BuoniMensaMaturati + BuoniMensaVariati);
    //Buoni mensa acquistati
    VetRiepStampa[35]:=IntToStr(BuoniMensaAcquistati);
    if BuoniMensaRecuperati <> 0 then
      VetRiepStampa[35]:=VetRiepStampa[35] + '(' + IntToStr(BuoniMensaRecuperati) + ')';
    //Ticket restaurant
    VetRiepStampa[52]:=IntToStr(TicketMaturati + TicketVariati);
    //Ticket acquistati
    VetRiepStampa[36]:=IntToStr(TicketAcquistati);
    if TicketRecuperati <> 0 then
      VetRiepStampa[36]:=VetRiepStampa[36] + '(' + IntToStr(TicketRecuperati) + ')';
    //Buoni maturati totali
    VetRiepStampa[99]:=IntToStr(BuoniPastoAnno['BUONI_MAT']);
    //Ticket maturati totali
    VetRiepStampa[100]:=IntToStr(BuoniPastoAnno['TICKET_MAT']);
    //Buoni acquistati totali compresi dei residui
    VetRiepStampa[101]:=IntToStr(BuoniPastoAnno['BUONI_ACQ']);
    //Ticket acquistati totali compresi dei residui
    VetRiepStampa[102]:=IntToStr(BuoniPastoAnno['TICKET_ACQ']);
    //Buoni residui totali
    VetRiepStampa[103]:=IntToStr(BuoniPastoAnno['BUONI_ACQ'] - BuoniPastoAnno['BUONI_MAT']);
    //Ticket residui totali
    VetRiepStampa[104]:=IntToStr(BuoniPastoAnno['TICKET_ACQ'] - BuoniPastoAnno['TICKET_MAT']);
    //Accessi alla mensa
    if EsisteInRiepilogo(57) then
      VetRiepStampa[57]:=IntToStr(NumeroPastiConv + NumeroPastiInteri);
    //Pasti convenzionali
    if EsisteInRiepilogo(58) then
      VetRiepStampa[58]:=IntToStr(NumeroPastiConv);
    //Pasti interi
    if EsisteInRiepilogo(59) then
      VetRiepStampa[59]:=IntToStr(NumeroPastiInteri);
    //Turni interi di reperibilità
    VetRiepStampa[61]:=ReperibilitaTurni;
    //Spezzoni di reperibilità
    VetRiepStampa[62]:=ReperibilitaSpezzoni;
    //Ore maggiorate di reperibilità
    VetRiepStampa[63]:=ReperibilitaOreMaggiorate;
    //Ore non maggiorate di reperibilità
    VetRiepStampa[64]:=ReperibilitaOreNonMagg;
    //Banca ore del mese in fasce e totale
    S:='';
    for i:=1 to NFasceMese do
      S:=S + R180DimLungR(R180MinutiOre(tbancaore[i]),8);
    VetRiepStampa[31]:=S;
    VetRiepStampa[127]:=R180MinutiOre(R180SommaArray(tbancaore));
    //Banca ore liquidata nel mese
    VetRiepStampa[33]:=R180MinutiOre(OreCompLiquidate);
    //Banca ore liquidata nell'anno
    VetRiepStampa[34]:=R180MinutiOre(BancaOreLiquidata);
    //Banca ore residua da inizio anno
    VetRiepStampa[68]:=R180MinutiOre(BancaOreResidua + BancaOreResiduaPrec);
    //Banca ore anno prec.
    VetRiepStampa[85]:=R180MinutiOre(BancaOreResiduaPrec);
    //Banca ore anno att.
    VetRiepStampa[86]:=R180MinutiOre(BancaOreResidua);
    //Compensabile senza Banca ore residua
    if (StrResiduoAnno > 0) and (SaldoNegativoMinimoTipo = '2') then //COMUNEDIGENOVA
      //VetRiepStampa[69]:=R180MinutiOre(salcompannoprec + salcompannoatt - BancaOreResidua - BancaOreResiduaPrec - Max(0,StrResiduoAnno - salannoatt))
      VetRiepStampa[69]:=R180MinutiOre(salcompannoprec + salcompannoatt - BancaOreResidua - BancaOreResiduaPrec - Max(0,StrResiduoAnno - salliqannoatt))
    else
      VetRiepStampa[69]:=R180MinutiOre(salcompannoprec + salcompannoatt - BancaOreResidua - BancaOreResiduaPrec);
    //Banca ore recuperata nel mese
    VetRiepStampa[70]:=R180MinutiOre(OreCompRecuperate);
    //Banca ore recuperata nell'anno
    VetRiepStampa[71]:=R180MinutiOre(BancaOreRecuperata);
    //Banca ore recuperata internamente nel mese
    VetRiepStampa[131]:=R180MinutiOre(BancaOreRecInternaMensile);
    //Banca ore maturata da inizio anno
    VetRiepStampa[110]:=R180MinutiOre(BancaOreAnno);
    //Banca ore da compensare del mese
    VetRiepStampa[115]:=R180MinutiOre(R180SommaArray(tbancaore) - OreCompLiquidate);
    //Riposi non fruiti in gg (S.Camillo)
    VetRiepStampa[96]:=FloatToStr(RiposiNonFruitiGG);
    //Riposi non fruiti in ore (S.Camillo)
    VetRiepStampa[97]:=R180MinutiOre(RiposiNonFruitiOre);
    //Compensabile al netto dei Riposi non fruiti in ore (S.Camillo)
    VetRiepStampa[98]:=R180MinutiOre(CompensabileMensileNettoRiposi);
    //Gestione dei permessi non recuperati ed addebitati sulle paghe
    if (not SoloAggiornamento) and (EsisteInRiepilogo(116) or EsisteInRiepilogo(117)) then
    begin
      //Permessi non recuperati addebitati sul cedolino
      VetRiepStampa[116]:=R180MinutiOre(R450DtM1.OrePermesso.Addebitate);
      //Permessi da recuperare prima che vengano addebitati su paghe
      VetRiepStampa[117]:=R180MinutiOre(R450DtM1.OrePermesso.DaRecuperare);
    end;

    //Rientri pomeridiani (PARMA_AIPO)
    VetRiepStampa[118]:=IntToStr(-RientriPomeridiani.Residuo);//Residuo mese prec.
    VetRiepStampa[119]:=IntToStr(RientriPomeridiani.DovutiReali);//Rientri previsti
    //Rientri fatti
    if StrToIntDef(RientriPomeridiani.ResoManuale,-1) >= 0 then
      VetRiepStampa[120]:=IntToStr(min(StrToInt(RientriPomeridiani.ResoManuale),RientriPomeridiani.DovutiReali - RientriPomeridiani.Residuo))
    else
      VetRiepStampa[120]:=IntToStr(min(RientriPomeridiani.ResiObbligatori + RientriPomeridiani.ResiSupplementari,RientriPomeridiani.DovutiReali - RientriPomeridiani.Residuo));
    //Saldo rientri pomeridiani
    if RientriPomeridiani.SaldoManuale <> '' then
      VetRiepStampa[121]:=IntToStr(-StrToIntDef(RientriPomeridiani.SaldoManuale,0))
    else
      VetRiepStampa[121]:=IntToStr(-RientriPomeridiani.Saldo);
  end;

  //Aggiornamento scheda riepilogativa
  try
    if AggiornamentoScheda and (IgnoraAnomalie or (not EsisteAnomBloccante)) then
    begin
      DecodeDate(DataDa,A,M,G);
      if not CheckAggiornamentoAbilitato(A027Progressivo,R180InizioMese(DataDa)) then
      begin
        RegistraMsg.InserisciMessaggio('A','Aggiornamento non abilitato per il mese di ' + DateToStr(R180InizioMese(DataDa)),'',A027Progressivo);
        exit;
      end;
      x040_aggscheda;
      AddSchedeAggiornate(A027Progressivo,R180InizioMese(DataDa));
    end
    else if AggiornamentoScheda then //Anomalia bloccante
    begin
      RegistraMsg.InserisciMessaggio('A','Anomalie bloccanti, riepilogo non registrato','',A027Progressivo);
    end;
    DatiAtipici;
  finally
    //Eseguire sempre!
    GetDatiLiberiSQL;
  end;
end;

function TR400FCartellinoDtM.CheckAggiornamentoAbilitato(Progressivo: Integer; Data:TDateTime):Boolean;
var Expr,V:String;
    lstVariabili:TStringList;
begin
  Result:=True;

  //Blocco dei riepiloghi standard
  if (not EludiBloccoRiepiloghi) and selDatiBloccati.DatoBloccato(Progressivo,Data,'T070') then
  begin
    Result:=False;
    exit;
  end;

  //Verifica espressione custom
  Expr:=Trim(Parametri.CampiRiferimento.C32_CheckAggSchedaAbil);
  lstVariabili:=nil;
  if Expr <> '' then
    with TOracleQuery.Create(nil) do
    try
      Session:=SessioneOracleR400;
      SQL.Text:=Format('select %s from dual',[Expr]);
      lstVariabili:=FindVariables(SQL.Text, False);
      for V in lstVariabili do
      begin
        if V.ToUpper = 'PROGRESSIVO' then
          DeclareAndSet('PROGRESSIVO',otInteger,Progressivo)
        else if V.ToUpper = 'DATA' then
          DeclareAndSet('DATA',otDate,Data);
      end;
      try
        Execute;
        Result:=FieldAsString(0) = 'S';
      except
      end;
    finally
      Free;
      if Assigned(lstVariabili) then
        lstVariabili.Free;
    end;
end;

function TR400FCartellinoDtM.GetEsisteAnomBloccante:Boolean;
var
  ErrMsg: string;
  i: Integer;
begin
  Result:=False;
  for i:=0 to lstAnomalieMM.Count - 1 do
  begin
    if R180In(lstAnomalieMM[i].LivNum,AnomalieBloccantiExtra.Split([',']))
    or (lstAnomalieMM[i].Livello = 1)
    then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

procedure TR400FCartellinoDtM.GetDatiLiberiSQL;
var i:Integer;
begin
  try //Alberto 24/02/2009: gestione dati liberi da SQL
    for i:=0 to High(VetDatiLiberiSQL) do
    begin
      VetDatiLiberiSQL[i].Dato:='';
      try
        selDatoLiberoSQL.SQL.Text:=VetDatiLiberiSQL[i].SQL;
        //selDatoLiberoSQL.SQL.Text:=StringReplace(selDatoLiberoSQL.SQL.Text,':PROGRESSIVO',IntToStr(A027Progressivo),[rfReplaceAll,rfIgnoreCase]);
        //selDatoLiberoSQL.SQL.Text:=StringReplace(selDatoLiberoSQL.SQL.Text,':DATA','''' + FormatDateTime('dd/mm/yyyy',DataA) + '''',[rfReplaceAll,rfIgnoreCase]);
        selDatoLiberoSQL.DeleteVariables;
        if Pos(':PROGRESSIVO',selDatoLiberoSQL.SQL.Text.ToUpper) > 0 then
          selDatoLiberoSQL.DeclareAndSet('PROGRESSIVO',otInteger,A027Progressivo);
        if Pos(':DATA',selDatoLiberoSQL.SQL.Text.ToUpper) > 0 then
          selDatoLiberoSQL.DeclareAndSet('DATA',otDate,DataA);
        try
          selDatoLiberoSQL.Execute;
          if selDatoLiberoSQL.RowCount > 0 then
            VetDatiLiberiSQL[i].Dato:=selDatoLiberoSQL.FieldAsString(0);
        except
          on E:Exception do
            VetDatiLiberiSQL[i].Dato:=E.Message;
        end;
      except
      end;
    end;
  except
  end;
end;

procedure TR400FCartellinoDtM.ScriptAggSchedaAfter(Progressivo: Integer; Data:TDateTime);
{Esecuzione procedura pl/sql persnalizzata dopo agg.scheda (TORINO_CITTADELLASALUTE)}
var Expr,V:String;
    lstVariabili:TStringList;
begin
  Expr:=Parametri.CampiRiferimento.C32_ScriptAggSchedaAfter.Trim;
  if Expr = '' then
    exit;

  lstVariabili:=nil;
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracleR400;
    SQL.Text:=Format('begin %s; end;',[Expr]);
    lstVariabili:=FindVariables(SQL.Text, False);
    for V in lstVariabili do
    begin
      if V.ToUpper = 'PROGRESSIVO' then
        DeclareAndSet('PROGRESSIVO',otInteger,Progressivo)
      else if V.ToUpper = 'DATA' then
        DeclareAndSet('DATA',otDate,Data);
    end;
    try
      Execute;
    except
      on E:exception do
        RegistraMsg.InserisciMessaggio('A',Format('Errore di esecuzione di %s: %s',[Expr,E.Message]),'',Progressivo);
    end;
  finally
    Free;
    if Assigned(lstVariabili) then
      lstVariabili.Free;
  end;
end;

procedure TR400FCartellinoDtM.AddSchedeAggiornate(Progressivo:Integer; Data:TDateTime);
var SA:Tschedeaggiornate;
begin
  SA.Progressivo:=Progressivo;
  SA.Data:=Data;
  lstSchedeAggiornate.Add(SA);
end;

function TR400FCartellinoDtM.ExistsSchedeAggiornate(Progressivo:Integer; Data:TDateTime):Boolean;
var i:Integer;
begin
  Result:=False;
  for i:=0 to lstSchedeAggiornate.Count - 1 do
    if (lstSchedeAggiornate[i].Progressivo = Progressivo) and
       (lstSchedeAggiornate[i].Data = Data) then
    begin
      Result:=True;
      Break;
    end;
end;

procedure TR400FCartellinoDtM.ScriviTotaliGiornalieri;
var TM3,TM10,TM21,S1:String;
    j:Integer;
begin
  //Preparazione dati in fasce
  TM3:='';
  for j:=1 to R450DtM1.NFasceMese do
  begin
    if totminlavmes[j] = 0 then S1:='     '
    else S1:=R180MinutiOre(totminlavmes[j]);
    if j > 1 then
      TM3:=TM3 + ' ';
    TM3:=TM3 + S1;
  end;
  TM10:='';
  for j:=1 to R450DtM1.NFasceMese do
  begin
    if totStrfascia[j] = 0 then S1:='     '
    else S1:=R180MinutiOre(totstrfascia[j]);
    if j > 1 then
      TM10:=TM10 + ' ';
    TM10:=TM10 + S1;
  end;
  TM21:='';
  for j:=1 to R450DtM1.NFasceMese do
  begin
    if tindturfasmes[j] = 0 then S1:='     '
    else S1:=R180MinutiOre(tindturfasmes[j]);
    if j > 1 then
      TM21:=TM21 + ' ';
    TM21:=TM21 + S1;
  end;
  //Assegnazione dati effettivi a TotMese
  if RiepTotLav = 0 then
    TotMese[1]:=''
  else
    TotMese[1]:=R180MinutiOre(RiepTotLav);
  if RiepOreLorde = 0 then
    TotMese[2]:=''
  else
    TotMese[2]:=R180MinutiOre(RiepOreLorde);
  TotMese[3]:=TM3;
  if RiepScost = 0 then
    TotMese[4]:=''
  else
    TotMese[4]:=R180MinutiOre(RiepScost);
  if RiepScostNeg = 0 then
    TotMese[5]:=''
  else
    TotMese[5]:=R180MinutiOre(RiepScostNeg);
  if RiepScostPos = 0 then
    TotMese[6]:=''
  else
    TotMese[6]:=R180MinutiOre(RiepScostPos);
  if RiepCompGG = 0 then
    TotMese[7]:=''
  else
    TotMese[7]:=R180MinutiOre(RiepCompGG);
  if RiepCompNegGG = 0 then
    TotMese[8]:=''
  else
    TotMese[8]:=R180MinutiOre(RiepCompNegGG);
  if RiepDebitoGG = 0 then
    TotMese[9]:=''
  else
    TotMese[9]:=R180MinutiOre(RiepDebitoGG);
  TotMese[10]:=TM10;
  if RiepProlInib = 0 then
    TotMese[11]:=''
  else
    TotMese[11]:=R180MinutiOre(RiepProlInib);
  if RiepProlNonCaus = 0 then
    TotMese[12]:=''
  else
    TotMese[12]:=R180MinutiOre(RiepProlNonCaus);
  if RiepProlNonCont = 0 then
    TotMese[13]:=''
  else
    TotMese[13]:=R180MinutiOre(RiepProlNonCont);
  if RiepPauMenDet = 0 then
    TotMese[14]:=''
  else
    TotMese[14]:=R180MinutiOre(RiepPauMenDet);
  if RiepMinLavEsc = 0 then
    TotMese[15]:=''
  else
    TotMese[15]:=R180MinutiOre(RiepMinLavEsc);
  if RiepProlNonCausUscita = 0 then
    TotMese[16]:=''
  else
    TotMese[16]:=R180MinutiOre(RiepProlNonCausUscita);
  if RiepPastiConv = 0 then
    TotMese[17]:=''
  else
    TotMese[17]:=IntToStr(RiepPastiConv);
  if RiepPastiInt = 0 then
    TotMese[18]:=''
  else
    TotMese[18]:=IntToStr(RiepPastiInt);
  if RiepFeNNG = 0 then
    TotMese[19]:=''
  else
    TotMese[19]:=IntToSTr(RiepFeNNG);
  if RiepMinLavCau = 0 then
    TotMese[20]:=''
  else
    TotMese[20]:=R180MinutiOre(RiepMinLavCau);
  TotMese[21]:=TM21;
  if RiepIndPres = 0 then
    TotMese[22]:=''
  else
    TotMese[22]:=FloatToStr(RiepIndPres);
  if RiepIndFest = 0 then
    TotMese[23]:=''
  else
    TotMese[23]:=FloatToStr(RiepIndFest);
  if RiepIndNot = 0 then
    TotMese[24]:=''
  else
    TotMese[24]:=R180MinutiOre(RiepIndNot);
  if RiepNumNot = 0 then
    TotMese[25]:=''
  else
    TotMese[25]:=IntToStr(RiepNumNot);
  TotMese[26]:=IfThen(RiepMinLavCau2 <> 0,R180MinutiOre(RiepMinLavCau2));
  TotMese[27]:=IfThen(RiepMinLavCau3 <> 0,R180MinutiOre(RiepMinLavCau3));
  TotMese[28]:=IfThen(RiepEccedIterDisp <> 0,R180MinutiOre(RiepEccedIterDisp));
  TotMese[29]:=IfThen(RiepBuoniPasto <> 0,RiepBuoniPasto.ToString);
  TotMese[30]:=IfThen(RiepCoperturaCarenza <> 0,R180MinutiOre(RiepCoperturaCarenza));
  TotMese[31]:=IfThen(RiepProlENonCaus <> 0,R180MinutiOre(RiepProlENonCaus));
  TotMese[32]:=IfThen(RiepProlUNonCaus <> 0,R180MinutiOre(RiepProlUNonCaus));
  TotMese[33]:=IfThen(RiepDebitoGO <> 0,R180MinutiOre(RiepDebitoGO));
  TotMese[34]:=IfThen(RiepDebitoM <> 0,R180MinutiOre(RiepDebitoM));
  TotMese[35]:=IfThen(RiepScostDebito <> 0,R180MinutiOre(RiepScostDebito));
end;

procedure TR400FCartellinoDtM.e020_stamriga(Anno,Mese,Giorno:Integer; Stampa:Boolean);
{CARICAMENTO DATI GIORNALIERI PER LA BANDA DI DETTAGLIO IN MATDETT()}
var i,Indice,j,xx,Val:Integer;
    S,S1,DG,AR,Anom:String;
    m_datacon:TDateTime;
  function GetAnomalie2Liv:String;
  {Restituisce le causali di 2° livello richieste dalla parametrizzazione}
  var x,y:Integer;
  begin
    Result:='';
    with TStringList.Create do
    try
      CommaText:=Q950Int.FieldByName('Anomalie2').AsString;
      for x:=0 to Count - 1 do
         for y:=0 to High(R502ProDtM1.tanom2riscontrate) do
           if (StrToIntDef(Strings[x],-1) + 1) = R502ProDtM1.tanom2riscontrate[y].ta2puntdesc then
           begin
             if Result <> '' then
               Result:=Result + #13;
             (*
             if R502ProDtM1.tanom2riscontrate[y].ta2caus <> '' then
               Result:=Result + R502ProDtM1.tanom2riscontrate[y].ta2caus + ' ';
             Result:=Result + tdescanom2[R502ProDtM1.tanom2riscontrate[y].ta2puntdesc].D;
             *)
             Result:=Result + R502ProDtM1.tanom2riscontrate[y].ta2testo;
           end;
    finally
      Free;
    end;
  end;
  function GetAnomalie3Liv:String;
  {Restituisce le causali di 3° livello richieste dalla parametrizzazione}
  var x,y:Integer;
  begin
    Result:='';
    with TStringList.Create do
    try
      CommaText:=Q950Int.FieldByName('Anomalie3').AsString;
      for x:=0 to Count - 1 do
         for y:=0 to High(R502ProDtM1.tanom3riscontrate) do
           if (StrToIntDef(Strings[x],-1) + 1) = R502ProDtM1.tanom3riscontrate[y].ta3puntdesc then
           begin
             if Result <> '' then
               Result:=Result + #13;
             (*
             Result:=Result + R180MinutiOre(R502ProDtM1.tanom3riscontrate[y].ta3timb) + ' ' +
                              tdescanom3[R502ProDtM1.tanom3riscontrate[y].ta3puntdesc].D;
             *)
             Result:=Result + R502ProDtM1.tanom3riscontrate[y].ta3testo;
           end;
    finally
      Free;
    end;
  end;
begin
  m_datacon:=EncodeDate(Anno,Mese,Giorno);
  //Impostazione conteggio Dalle/Alle per gestire cavallo di
  //mezzanotte cumulando tutto sull'entrata
  //x002_impdallealle(Giorno);
  R502ProDtM1.Conteggi('Cartolina',A027Progressivo,m_datacon);
  if R502ProDtM1.Blocca <> 0 then
  begin
    AnomaliaBloccante:=True;
    // validazione web.ini - daniloc 19.03.2012
    Anom:=Format('%s: %s',[FormatDateTime('dd/mm/yyyy',m_datacon),R502ProDtM1.DescAnomaliaBloccante]);
    lstAnomalie.Add(Anom);
    // validazione web
  end
  else if (R502ProDtM1.Pianif = 'si') and (R502ProDtM1.MotivazionePianif = 'NO') then
  begin
    //Gestione turni pianificati su T081 (pianificazione Non Operativa per Torino_Comune)
    R180SetVariable(selT081,'PROGRESSIVO',A027Progressivo);
    R180SetVariable(selT081,'DATA',R502ProDtM1.DataCon);
    selT081.Open;
    R502ProDtM1.TurnoProvv1:=StrToIntDef(selT081.FieldByName('NUMTURNO1').AsString,0);
    R502ProDtM1.TurnoProvv2:=StrToIntDef(selT081.FieldByName('NUMTURNO2').AsString,0);
  end;

  x025_CumuloFasce;
  //Controllo se saltare il giorno per i saldi e gli istituti
  e022_saltogg;
  x018_registraindpres;
  if (R502ProDtM1.numcorr < ncinisaldi) or (R502ProDtM1.numcorr > max(ncfinistit,ncfinsaldi)) then
    exit;
  if (c03_tipocart = 'S') and (s_tiporiepist = 'M') and
     (R502ProDtM1.numcorr > ncfinsaldi) and (s_saltoggnontot = 'si') then
      exit;
  inc(NGIndNotFes);
  if Stampa then
  begin
    inc(NumGiorniCartolina);
    Riga:=NumGiorniCartolina;
  end
  else
    Riga:=NumGiorniCartolina + 1;
  //Totalizzazioni e pianificazione automatica (se necessarie)
  x020_vertotalizz;
  e025_totali;
  if not Stampa then exit;
  //Registro se il giorno è una Domenica per i totali settimanali
  if DayOfWeek(m_datacon) = 1 then
    VetDomenica[Riga]:=Riga div 7;
  //Stampa totalizzazioni settimanali
  if (c03_tipocart = 'S') and (VetDomenica[Riga] > -1) then
    e040_statotse(m_datacon);
  if SoloAggiornamento then
    exit;
  //Movimento anomalie per stampa linea anomalie
  (*
  if R502ProDtM1.blocca <> 0 then
    //Anomalie bloccanti
    MatDettStampa[Riga,C_ANM]:=UpperCase(R502ProDtM1.DescAnomaliaBloccante)
  else
    //Anomalie di 2° livello e 3° livello
    MatDettStampa[Riga,C_ANM]:=GetAnomalie2Liv + GetAnomalie3Liv;
  *)
  MatDettStampa[Riga,C_ANM]:=UpperCase(R502ProDtM1.DescAnomaliaBloccante);
  MatDettStampa[Riga,C_ANM]:=Trim(MatDettStampa[Riga,C_ANM] + IfThen(MatDettStampa[Riga,C_ANM] <> '',#13) + GetAnomalie2Liv);
  MatDettStampa[Riga,C_ANM]:=Trim(MatDettStampa[Riga,C_ANM] + IfThen(MatDettStampa[Riga,C_ANM] <> '',#13) + GetAnomalie3Liv);
  //Dati giornalieri
  //Giorno del mese con '*' se festivo o Domenica
  //S:=FormatDateTime('ddd',m_datacon);
  S:=Copy(R180NomeGiorno(m_datacon),1,2);
  AR:=' ';
  if (Q950Int.FieldByName('Festivo').AsString = 'S') and
     ((R502ProDtM1.tipogg = 'F') or (DayOfWeek(m_datacon) = 1)) then
    AR:='*';
  if (Q950Int.FieldByName('NonLav').AsString = 'S') and
     (R502ProDtM1.gglav = 'no') then
    AR:='*';
  S:=S + AR + FormatDateTime('dd',m_datacon);
  MatDettStampa[Riga,C_GG1]:=S;
  //competenza mese successivo (per cartellino settimanale TORINO_CSI)
  if R180InizioMese(m_datacon) > R180InizioMese(datada) then
    MatDettStampa[Riga,C_CMP]:='MS'
  else
    MatDettStampa[Riga,C_CMP]:='';
  //Timbrature
  MatDettStampa[Riga,C_TI1]:='';
  MatDettStampa[Riga,C_TI2]:='';
  MatDettStampa[Riga,C_TI3]:='';
  MatDettStampa[Riga,C_TI4]:='';
  MatDettStampa[Riga,C_TI5]:='';
  MatDettStampa[Riga,C_TI6]:='';
  MatDettStampa[Riga,C_TI7]:='';
  MatDettStampa[Riga,C_TI8]:='';
  for xx:=C_TI1 to C_TI8 do //Alberto 05/11/2008: ciclo su tutte le formattazioni possibili
  begin
    S:='';
    Indice:=C_TI1;
    for i:=1 to MaxTimbrature do
      if R502ProDtM1.m_tab_timbrature[Giorno,i].tversotimb = '' then Break
      else
      begin
        if S <> '' then S:=S + ' ';
        //Differenziazione timbrature originali/manuali
        if (R502ProDtM1.m_tab_timbrature[Giorno,i].tflagtimb = 'I') and
           (Q950Int.FieldByName('TIMBRATURE_MANUALI').AsString = 'S') then
          S1:=LowerCase(R502ProDtM1.m_tab_timbrature[Giorno,i].tversotimb)
        else
          S1:=R502ProDtM1.m_tab_timbrature[Giorno,i].tversotimb;
        //Timbratura base
        S1:=S1 + FormatDateTime(IfThen(Parametri.AccessibilitaNonVedenti = 'S',' ' + FMT_HHpNN,FMT_HHNN),R502ProDtM1.m_tab_timbrature[Giorno,i].toratimb);
        //Segnalazione orologio non abilitato
        if Trim(Q950Int.FieldByName('Anomalia').AsString) <> '' then
        begin
          AR:=' ';
          for j:=0 to R502ProDtM1.n_anom3 do
            if (R502ProDtM1.tanom3riscontrate[j].ta3puntdesc = 3) and (R502ProDtM1.tanom3riscontrate[j].ta3timb = R180OreMinuti(R502ProDtM1.m_tab_timbrature[Giorno,i].toratimb)) then
            begin
              AR:=Q950Int.FieldByName('Anomalia').AsString;
              Break;
            end;
          S1:=S1 + AR;
        end;
        //Alberto 05/11/2008: gestione varie formattazioni timbrature se Parametrizzazione cartellino variabile
        if not ParametrizzazioniTipoCar then
          S:=S + FormattaTimbratura(S1,R502ProDtM1.m_tab_timbrature[Giorno,i],Indice)
        else
          S:=S + FormattaTimbratura2(S1,R502ProDtM1.m_tab_timbrature[Giorno,i],xx)
      end;
    if not ParametrizzazioniTipoCar then
    begin
      MatDettStampa[Riga,Indice]:=S;  //Indice è restituito da FormattaTimbratura
      Break;
    end
    else
      MatDettStampa[Riga,xx]:=S;
  end;
  //Giustificativi
  for xx:=C_GI1 to C_GI2 do //Alberto 05/11/2008: ciclo su tutte le formattazioni possibili
  begin
    S:='';
    S1:='';
    Indice:=xx;
    for i:=1 to MaxGiustif do
      with R502ProDtM1.m_tab_giustificativi[Giorno,i] do
        if tcausgius = '' then Break
        else
        begin
          if (Pos(',' + tcausgius + ',',',' + Q950Int.FieldByName('CAUPRES_ESCLUSE').AsString + ',') > 0) then
            Continue;
          if not A000FiltroDizionario('CAUSALI SUL CARTELLINO',tcausgius) then
            Continue;
          //Verifico se usare il codice o la descrizione
          if Indice = C_GI2 then
          begin
            DG:=GetDescGiust(tcausgius);
            //Indice:=C_GI2;
          end
          else
          begin
            DG:=tcausgius;
            //Indice:=C_GI1;
          end;
          DG:=DG + IfThen(tnotegius <> '','[' + tnotegius + ']');
          case ttipogius of
            'I':S1:='GG:' + DG;
            'M':S1:='MG:' + DG;
            'N':S1:=FormatDateTime(IfThen(Parametri.AccessibilitaNonVedenti = 'S',FMT_HHpNN,FMT_HHNN),tdallegius) + ':' + DG;
            'D':S1:=FormatDateTime(IfThen(Parametri.AccessibilitaNonVedenti = 'S',FMT_HHpNN,FMT_HHNN),tdallegius) + '-' + FormatDateTime(IfThen(Parametri.AccessibilitaNonVedenti = 'S',FMT_HHpNN,FMT_HHNN),tallegius) + ':' + DG;
          end;
          if S <> '' then
            if Indice = C_GI1 then
              S:=S + ' '
            else
              S:=S + #13;
          S:=S + S1;
        end;
    //MatDettStampa[Riga,Indice]:=S;
    MatDettStampa[Riga,xx]:=S;
  end;
  //Ore lavorate
  if R502ProDtM1.TotLav = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.TotLav);
  MatDettStampa[Riga,C_HL1]:=S;
  MatDettStampa[Riga,C_HL2]:=S;
  //Ore lavorate in fasce
  S:='';
  for i:=1 to R450DtM1.NFasceMese do
    begin
    if tLavGGFasMen[i] = 0 then S1:='     '
    else S1:=R180MinutiOre(tLavGGFasMen[i]);
    if i > 1 then
       S:=S + ' ' + S1
    else
      S:=S1;
    end;
  MatDettStampa[Riga,C_LF1]:=S;
  MatDettStampa[Riga,C_LF2]:=S;
  //Eccedenze in fasce
  S:='';
  for i:=1 to R450DtM1.NFasceMese do
    begin
    if tStrGGFasMen[i] = 0 then S1:='     '
    else S1:=R180MinutiOre(tStrGGFasMen[i]);
    if i > 1 then
       S:=S + ' ' + S1
    else
      S:=S1;
    end;
  MatDettStampa[Riga,C_EC1]:=S;
  MatDettStampa[Riga,C_EC2]:=S;
  //Ind.turno in fasce
  S:='';
  for i:=1 to R450DtM1.NFasceMese do
    begin
    if tLavTurnoFasMen[i] = 0 then S1:='     '
    else S1:=R180MinutiOre(tLavTurnoFasMen[i]);
    if i > 1 then
       S:=S + ' ' + S1
    else
      S:=S1;
    end;
  MatDettStampa[Riga,C_IT1]:=S;
  MatDettStampa[Riga,C_IT2]:=S;
  //Scostamento
  if R502ProDtM1.Scost = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.Scost);
  MatDettStampa[Riga,C_SC1]:=S;
  MatDettStampa[Riga,C_SC2]:=S;
  //Scostamento negativo
  if R502ProDtM1.ScostNeg = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.ScostNeg);
  MatDettStampa[Riga,C_SN1]:=S;
  MatDettStampa[Riga,C_SN2]:=S;
  //Scostamento positivo
  if R502ProDtM1.Scost <= 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.Scost);
  MatDettStampa[Riga,C_SP1]:=S;
  MatDettStampa[Riga,C_SP2]:=S;
  //Compensabile giornaliero
  if R502ProDtM1.EccSoloCompGG <= 0 then S:=''
  else
    S:=R180MinutiOre(R502ProDtM1.EccSoloCompGG);
  MatDettStampa[Riga,C_CM1]:=S;
  MatDettStampa[Riga,C_CM2]:=S;
  MatDettStampa[Riga,C_CMNG1]:=S;
  MatDettStampa[Riga,C_CMNG2]:=S;
  if R502ProDtM1.ScostNeg < 0 then
  begin
    S:=R180MinutiOre(R502ProDtM1.ScostNeg);
    MatDettStampa[Riga,C_CMNG1]:=S;
    MatDettStampa[Riga,C_CMNG2]:=S;
  end;
  //Ore escluse dalle normali
  if (R502ProDtM1.minlavesc + R502ProDtM1.mintipoAesc) = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.minlavesc + R502ProDtM1.mintipoAesc);
  MatDettStampa[Riga,C_ESC1]:=S;
  MatDettStampa[Riga,C_ESC2]:=S;
  //Ore causalizzate
  if R502ProDtM1.MinLavCau[Q950Int.FieldByName('CAUPRES').AsString] = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.MinLavCau[Q950Int.FieldByName('CAUPRES').AsString]);
  MatDettStampa[Riga,C_CAU1]:=S;
  MatDettStampa[Riga,C_CAU2]:=S;
  //Ore causalizzate 2
  if R502ProDtM1.MinLavCau[Q950Int.FieldByName('CAUPRES2').AsString] = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.MinLavCau[Q950Int.FieldByName('CAUPRES2').AsString]);
  MatDettStampa[Riga,C_CAU3]:=S;
  MatDettStampa[Riga,C_CAU4]:=S;
  //Ore causalizzate 3
  if R502ProDtM1.MinLavCau[Q950Int.FieldByName('CAUPRES3').AsString] = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.MinLavCau[Q950Int.FieldByName('CAUPRES3').AsString]);
  MatDettStampa[Riga,C_CAU5]:=S;
  MatDettStampa[Riga,C_CAU6]:=S;
  //Ore causalizzate 1 in fasce
  S:=R502ProDtM1.MinLavCauFasce[Q950Int.FieldByName('CAUPRES').AsString];
  MatDettStampa[Riga,C_CAUF1]:=S;
  MatDettStampa[Riga,C_CAUF2]:=S;
  //Ore causalizzate 2 in fasce
  S:=R502ProDtM1.MinLavCauFasce[Q950Int.FieldByName('CAUPRES2').AsString];
  MatDettStampa[Riga,C_CAUF3]:=S;
  MatDettStampa[Riga,C_CAUF4]:=S;
  //Ore causalizzate 3 in fasce
  S:=R502ProDtM1.MinLavCauFasce[Q950Int.FieldByName('CAUPRES3').AsString];
  MatDettStampa[Riga,C_CAUF5]:=S;
  MatDettStampa[Riga,C_CAUF6]:=S;
  //Ecc.gg richiedibile da iter web (TORINO_CITTADELLASALUTE)
  if R502ProDtM1.EccedIterDisponibile = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.EccedIterDisponibile);
  MatDettStampa[Riga,C_ECCRICH1]:=S;
  MatDettStampa[Riga,C_ECCRICH2]:=S;
  //Ecc.gg richiedibile da iter web in fasce
  S:=R502ProDtM1.EccedenzaIterDaAutorizzareInFasce;
  MatDettStampa[Riga,C_ECCAUTF1]:=S;
  MatDettStampa[Riga,C_ECCAUTF2]:=S;
  //Debito giornaliero
  MatDettStampa[Riga,C_DG1]:=IfThen(R502ProDtM1.debitogg <> 0,R180MinutiOre(R502ProDtM1.debitogg));
  MatDettStampa[Riga,C_DG2]:=MatDettStampa[Riga,C_DG1];
  //Debito da orario
  MatDettStampa[Riga,C_DGO1]:=IfThen(R502ProDtM1.debitodaorario <> 0,R180MinutiOre(R502ProDtM1.debitodaorario));
  MatDettStampa[Riga,C_DGO2]:=MatDettStampa[Riga,C_DGO1];
  //Debito medio
  MatDettStampa[Riga,C_DGM1]:=IfThen(R502ProDtM1.debitocl <> 0,R180MinutiOre(R502ProDtM1.debitocl));
  MatDettStampa[Riga,C_DGM2]:=MatDettStampa[Riga,C_DGM1];
  //Scostamento del debito
  MatDettStampa[Riga,C_SD1]:=IfThen(R502ProDtM1.scostamentodebito <> 0,R180MinutiOre(R502ProDtM1.scostamentodebito));
  MatDettStampa[Riga,C_SD2]:=MatDettStampa[Riga,C_SD1];
  //Modello orario
  MatDettStampa[Riga,C_ORA]:=R502ProDtM1.c_orario;
  //Turno
  S:='';
  if (R502ProDtM1.n_turno1 > 0) or (R502ProDtM1.n_turno1 = -8) then
    begin
    S:=IntToStr(R502ProDtM1.n_turno1);
    if Trim(R502ProDtM1.s_turno1) <> '' then
      S1:=R502ProDtM1.s_turno1
    else
      S1:=S;
    end
  else if R502ProDtM1.c_turni1 = 0 then
    begin
    S:='0';
    S1:=R502ProDtM1.s_turno1;
    end;
  if R502ProDtM1.n_turno2 > 0 then
    begin
    S:=S + IntToStr(R502ProDtM1.n_turno2);
    if Trim(R502ProDtM1.s_turno2) <> '' then
      S1:=S1 + R502ProDtM1.s_turno2
    else
      S1:=S1 + IntToStr(R502ProDtM1.n_turno2);
    end
  else if R502ProDtM1.c_turni2 = 0 then
    begin
    S:=S + '0';
    S1:=S1 + R502ProDtM1.s_turno2;
    end;
  MatDettStampa[Riga,C_TR1]:=S;
  MatDettStampa[Riga,C_TR2]:=S1;
  //Ore lavorate lorde
  if R502ProDtM1.minpresenzelorde = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.minpresenzelorde);
  MatDettStampa[Riga,C_HH1]:=S;
  MatDettStampa[Riga,C_HH2]:=S;
  //Timbrature di mensa
  if EsisteDato(C_TM1) then
    MatDettStampa[Riga,C_TM1]:=GetTimbMensa(m_datacon);
  if R502ProDtM1.paumendet = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.paumendet);
  MatDettStampa[Riga,C_PM1]:=S;
  MatDettStampa[Riga,C_PM2]:=S;
  if (Parametri.ModuloInstallato['CONTEGGIO_PASTI']) and
     (EsisteDato(C_PCONV1) or EsisteDato(C_PCONV2) or EsisteDato(C_PINT1) or EsisteDato(C_PINT2)) then
  begin
    if R300DtM = nil then
      if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
        R300DtM:=TR300FAccessiMensaDtM.Create(Self.Owner)
      else
        R300DtM:=TR300FAccessiMensaDtM.Create(SessioneOracleR400);
    R300DtM.SettaPeriodo(DataDa,DataA);//(m_datacon,m_datacon);
    R300DtM.ConteggiaPasti(A027Progressivo,m_datacon);
    MatDettStampa[Riga,C_PCONV1]:=IfThen(R300DtM.PastiCon = 0,'',IntToStr(R300DtM.PastiCon));
    MatDettStampa[Riga,C_PCONV2]:=IfThen(R300DtM.PastiCon = 0,'',IntToStr(R300DtM.PastiCon));
    MatDettStampa[Riga,C_PINT1]:=IfThen(R300DtM.PastiInt = 0,'',IntToStr(R300DtM.PastiInt));
    MatDettStampa[Riga,C_PINT2]:=IfThen(R300DtM.PastiInt = 0,'',IntToStr(R300DtM.PastiInt));
    inc(RiepPastiConv,R300DtM.PastiCon);
    inc(RiepPastiInt,R300DtM.PastiInt);
    //Getire variabili di totale RiepPastiCon, RiepPastiInt, vedi RiepScostNeg
  end;
  //Turni di reperibilità pianificati
  MatDettStampa[Riga,C_TRP]:='';
  MatDettStampa[Riga,C_TRA]:='';
  MatDettStampa[Riga,C_TRP]:=R502ProDtM1.TurniExtraPianificati['C'];
  if MatDettStampa[Riga,C_TRP] <> '' then
    MatDettStampa[Riga,C_TRP]:=MatDettStampa[Riga,C_TRP] + ' ';
  MatDettStampa[Riga,C_TRP]:=Trim(MatDettStampa[Riga,C_TRP] + R502ProDtM1.TurniExtraPianificati['D']);
  MatDettStampa[Riga,C_TRA]:=R502ProDtM1.TurniExtraPianificati['G'];
  //Prolungamento inibito
  if R502ProDtM1.ProlungamentoInibito[''] = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.ProlungamentoInibito['']);
  MatDettStampa[Riga,C_PRI1]:=S;
  MatDettStampa[Riga,C_PRI2]:=S;
  //Prolungamento non causalizzato
  if R502ProDtM1.ProlungamentoNonCausalizzato[''] = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.ProlungamentoNonCausalizzato['']);
  MatDettStampa[Riga,C_PRN1]:=S;
  MatDettStampa[Riga,C_PRN2]:=S;
  //Prolungamento E non causalizzato
  if R502ProDtM1.ProlungamentoNonCausalizzato['E'] = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.ProlungamentoNonCausalizzato['E']);
  MatDettStampa[Riga,C_PRNE1]:=S;
  MatDettStampa[Riga,C_PRNE2]:=S;
  //Prolungamento U non causalizzato
  if R502ProDtM1.ProlungamentoNonCausalizzato['U'] = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.ProlungamentoNonCausalizzato['U']);
  MatDettStampa[Riga,C_PRNU1]:=S;
  MatDettStampa[Riga,C_PRNU2]:=S;
  //Prolungamento in uscita non conteggiato (Monza_HSG)
  if (R502ProDtM1.ProlungamentoNonCausUscita) = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.ProlungamentoNonCausUscita);
  MatDettStampa[Riga,C_PRU1]:=S;
  MatDettStampa[Riga,C_PRU2]:=S;
  //Prolungamento non conteggiato
  if (R502ProDtM1.ProlungamentoNonCausalizzato[''] + R502ProDtM1.ProlungamentoInibito['']) = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.ProlungamentoNonCausalizzato[''] + R502ProDtM1.ProlungamentoInibito['']);
  MatDettStampa[Riga,C_PRT1]:=S;
  MatDettStampa[Riga,C_PRT2]:=S;
  //Turni di libera professione
  S:='';
  with R502ProDtM1 do
    if Q320.SearchRecord('Data',Datacon,[srFromBeginning]) then
    repeat
      (*
      if S <> '' then
        S:=S + ' ';
      S:=S + Q320.FieldByName('Dalle').AsString + '-' + Q320.FieldByName('Alle').AsString;
      *)
      if S <> '' then
        S:=S + #13#10;
      S:=S + Format('%s:%s-%s',[Q320.FieldByName('Causale').AsString,
                                StringReplace(Q320.FieldByName('Dalle').AsString,'.','',[]),
                                StringReplace(Q320.FieldByName('Alle').AsString,'.','',[])
                               ]);
    until not(Q320.SearchRecord('Data',Datacon,[]));
  MatDettStampa[Riga,C_LPR]:=S;
  //Ore obbligatorie rese
  if R502ProDtM1.PresenzaObbligatoria = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.PresenzaObbligatoria);
  MatDettStampa[Riga,C_OBR]:=S;
  //Ore obbligatorie carenti
  if R502ProDtM1.CarenzaObbligatoria = 0 then S:=''
  else S:=R180MinutiOre(-R502ProDtM1.CarenzaObbligatoria);
  MatDettStampa[Riga,C_OBC]:=S;
  //Ore facoltative rese
  if R502ProDtM1.PresenzaFacoltativa = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.PresenzaFacoltativa);
  MatDettStampa[Riga,C_FAR]:=S;
  //Ore facoltative carenti
  if R502ProDtM1.CarenzaFacoltativa = 0 then S:=''
  else S:=R180MinutiOre(-R502ProDtM1.CarenzaFacoltativa);
  MatDettStampa[Riga,C_FAC]:=S;
  //Ore indennità notturna   LORENA 07/02/2005
  if R502ProDtM1.indnotmin = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.indnotmin);
  MatDettStampa[Riga,C_INDN1]:=S;
  MatDettStampa[Riga,C_INDN2]:=S;
  //Num. indennità festiva   LORENA 07/02/2005
  if (R502ProDtM1.indfesint + (R502ProDtM1.indfesrid / 2)) = 0 then S:=''
  else S:=FloatToStr(R502ProDtM1.indfesint + (R502ProDtM1.indfesrid / 2));
  MatDettStampa[Riga,C_INDF1]:=S;
  MatDettStampa[Riga,C_INDF2]:=S;
  //Num. indennità presenza   LORENA 07/02/2005
  if ((R502ProDtM1.tindennitapresenza[1].tindpres + R502ProDtM1.tindennitapresenza[2].tindpres + R502ProDtM1.tindennitapresenza[3].tindpres) = 0) or
    (lstIndennitaSpettanti.Count = 0) then S:=''
  else S:=FloatToStr(R502ProDtM1.tindennitapresenza[1].tindpres + R502ProDtM1.tindennitapresenza[2].tindpres + R502ProDtM1.tindennitapresenza[3].tindpres);
  MatDettStampa[Riga,C_INDP1]:=S;
  MatDettStampa[Riga,C_INDP2]:=S;
  //Num. notti
  if R502ProDtM1.indnotgg = 0 then S:=''
  else S:=FloatToStr(R502ProDtM1.indnotgg);
  MatDettStampa[Riga,C_NUMN1]:=S;
  MatDettStampa[Riga,C_NUMN2]:=S;
  if R502ProDtm1.FestivoNonGoduto = 0 then S:=''
  else S:=IntToStr(R502ProDtM1.FestivoNonGoduto);
  MatDettStampa[Riga,C_FENNG1]:=S;
  MatDettStampa[Riga,C_FENNG2]:=S;  //-->gestire totalizzazione in RiepFeNNG come RiepScostNeg
  //Ore facoltative scostate da (debitogg - PresenzaFacoltativa)
  if R502ProDtM1.ScostFacoltativa = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.ScostFacoltativa);
  MatDettStampa[Riga,C_FAS]:=S;
  //Maturazione buoni pasto
  S:='';
  if (Parametri.ModuloInstallato['BUONI_PASTO']) and (EsisteDato(C_BP1) or EsisteDato(C_BP2)) then
  begin
    Val:=R350DtM.GetMaturazioneGG(A027Progressivo,m_datacon);
    if Val > 0 then
    begin
      S:=IntToStr(Val);
      inc(RiepBuoniPasto,Val);
    end;
  end;
  MatDettStampa[Riga,C_BP1]:=S;
  MatDettStampa[Riga,C_BP2]:=S;
  //Copertura carenza
  if R502ProDtM1.CoperturaCarenza = 0 then S:=''
  else S:=R180MinutiOre(R502ProDtM1.CoperturaCarenza);
  MatDettStampa[Riga,C_CC1]:=S;
  MatDettStampa[Riga,C_CC2]:=S;
  //Note
  if EsisteDato(C_NOTE) then
    MatDettStampa[Riga,C_NOTE]:=VarToStr(R502ProDtM1.Q080.Lookup('Data',m_datacon,'NOTE'));
  //Richieste pendenti
  if RichiestePendenti then
  begin
    S:='';
    //TIMBRATURE
    if Assigned(A023MW) and A023MW.selVT105.Locate('DATA',m_datacon,[]) then
    begin
      while (A023MW.selVT105.FieldByName('DATA').AsDateTime = m_datacon) and (not A023MW.selVT105.Eof) do
      begin
        S:=S + IfThen(S <> '', CRLF);
        S:=S + 'T(' + A023MW.selVT105.FieldByName('OPERAZIONE').AsString + '): ' + A023MW.selVT105.FieldByName('VERSO').AsString + ' ' + A023MW.selVT105.FieldByName('ORA').AsString;
        S:=S + IfThen(A023MW.selVT105.FieldByName('CAUSALE').AsString <> '', ' ' + A023MW.selVT105.FieldByName('CAUSALE').AsString);
        A023MW.selVT105.Next;
      end;
    end;
    //GIUSTIFICATIVI
    if Assigned(A023MW) and A023MW.selVT050.Locate('DATA',m_datacon,[]) then
    begin
      while (A023MW.selVT050.FieldByName('DATA').AsDateTime = m_datacon) and (not A023MW.selVT050.Eof) do
      begin
        S:=S + IfThen(S <> '', CRLF);
        S:=S + 'G(' + A023MW.selVT050.FieldByName('TIPO_RICHIESTA').AsString + '): ' + A023MW.selVT050.FieldByName('CAUSALE').AsString;
        A023MW.selVT050.Next;
      end;
    end;
    //CAMBIO ORARIO
    if Assigned(A023MW) and A023MW.selVT085.Locate('DATA',m_datacon,[]) then
    begin
      while (A023MW.selVT085.FieldByName('DATA').AsDateTime = m_datacon) and (not A023MW.selVT085.Eof) do
      begin
        S:=S + IfThen(S <> '', CRLF);
        if A023MW.selVT085.FieldByName('TIPOGIORNO_INVER').AsString = 'L' then
        begin   //Cambio orario nel giorno stesso
          S:=S + 'O da: ' + A023MW.selVT085.FieldByName('ORARIO').AsString + ' a: ' + A023MW.selVT085.FieldByName('ORARIO_INVER').AsString;
        end
        else if A023MW.selVT085.FieldByName('TIPOGIORNO_INVER').AsString = 'N' then
        begin  //Scambio orario con altro giorno
          if A023MW.selVT085.FieldByName('DATA').AsString = A023MW.selVT085.FieldByName('DATA_ORARIO').AsString then
            S:=S + 'O da: ' + A023MW.selVT085.FieldByName('ORARIO').AsString + ' a: ' + A023MW.selVT085.FieldByName('DATA_INVER').AsString + ' - ' + A023MW.selVT085.FieldByName('ORARIO_INVER').AsString
          else
            S:=S + 'O da: ' + A023MW.selVT085.FieldByName('DATA_ORARIO').AsString + ' - ' + A023MW.selVT085.FieldByName('ORARIO').AsString + ' a: ' + A023MW.selVT085.FieldByName('ORARIO_INVER').AsString;
        end;
        A023MW.selVT085.Next;
      end;
    end;

    MatDettStampa[Riga,C_RICHIESTE]:=S;  //'TGO';
  end;
end;

procedure TR400FCartellinoDtM.x072_indturpal;
{Gestione indennita' di turno per contratto PAL}
var indtur:Single;
begin
  //if R502ProDtM1.Q200.FieldByName('Tipo').AsString = 'A' then
  if R502ProDtM1.T200[R502ProDtM1.Q200.FieldByName('Tipo').Index] = 'A' then
    //Numero di presenze pomeridiane raffrontato con quello delle mensili
    begin
    indtur:=notggmes * 2.6;
    notggmes:=trunc(indtur);
    //Se c'è parte decimale
    if indtur - notggmes > 0 then
      inc(notggmes);
    if nggpres < notggmes then
      notggmes:=nggpres;
    if notggmes > 26 then
      notggmes:=26;
    exit;
    end;
  //if R502ProDtM1.Q200.FieldByName('IndTurno').AsString = 'C' then
  if R502ProDtM1.T200[R502ProDtM1.Q200.FieldByName('Tipo').Index] = 'C' then
    //Numero di ore fatte in turno con controllo dei pomeriggi lavorati
    begin
    if (nggpomer > 2) and (nggpomer < 6) then
      notminmes:=notminmes div 2
    else
      if nggpomer < 3 then
        notminmes:=0;
    end;
end;

procedure TR400FCartellinoDtM.GestioneDomenicaLavorata(DomenicaLavorata:T_DomenicheLavorate; Recupero:Integer);
begin
  if Recupero > R450DtM1.tminstrmen[3] then
    begin
    dec(Recupero,R450DtM1.tminstrmen[3]);
    R450DtM1.tminstrmen[3]:=0;
    end
  else
    begin
    dec(R450DtM1.tminstrmen[3],Recupero);
    Recupero:=0;
    end;
  if Recupero > R450DtM1.tminstrmen[4] then
    R450DtM1.tminstrmen[4]:=0
  else
    dec(R450DtM1.tminstrmen[4],Recupero);
end;

procedure TR400FCartellinoDtM.RicalcoloIndennita_1(Tipo:String);
//Ricalcolo delle indennità festive e notturne in base al liquidabile del mese
var i,j,LiqNot,LiqFes:Integer;
    EccInd:Integer;
begin
  for i:=2 to R450DtM1.NFasceMese do
    begin
    //Registrazione Liquidabile Mensile della Fascia i-esima
    LiqFes:=R450DtM1.tstrmese[i];
    LiqNot:=R450DtM1.tstrmese[i];
    //Riduzione dell'eccedenza maturata giornalmente all'effettivo liquidabile,
    //per evitare il riporto sui mesi successivi
    R450DtM1.tminstrmen[i]:=R450DtM1.tstrmese[i];
    for j:=1 to 31 do
      begin
      if (i > 2) and ((Tipo = '1') or (Tipo = '3')) then
        //FASCE FESTIVE
        begin
        //EccInd è quanto posso togliere al massimo dal giorno tra l'Eccedenza giornaliera e l'Indennità
        if indfes_giorno[j].EccGio[i] <= indfes_giorno[j].Ore then
          EccInd:=indfes_giorno[j].EccGio[i]
        else
          EccInd:=indfes_giorno[j].Ore;
        if EccInd >= LiqFes then
          begin
          dec(indfes_giorno[j].EccGio[i],LiqFes);
          dec(indfes_giorno[j].Ore,LiqFes);
          LiqFes:=0;
          end
        else
          begin
          dec(LiqFes,EccInd);
          dec(indfes_giorno[j].EccGio[i],EccInd);
          dec(indfes_giorno[j].Ore,EccInd);
          end;
        end;
      if (i in [2,4]) and ((Tipo = '1') or (Tipo = '2')) then
        //FASCE NOTTURNE
        begin
        //EccInd è quanto posso togliere al massimo dal giorno tra l'Eccedenza giornaliera e l'Indennità
        if indnot_giorno[j].EccGio[i] <= indnot_giorno[j].Ore then
          EccInd:=indnot_giorno[j].EccGio[i]
        else
          EccInd:=indnot_giorno[j].Ore;
        if EccInd >= LiqNot then
          begin
          dec(indnot_giorno[j].EccGio[i],LiqNot);
          dec(indnot_giorno[j].Ore,LiqNot);
          LiqNot:=0;
          end
        else
          begin
          dec(LiqNot,EccInd);
          dec(indNot_giorno[j].EccGio[i],EccInd);
          dec(indNot_giorno[j].Ore,EccInd);
          end;
        end;
      end;
    end;
  if (Tipo = '1') or (Tipo = '3') then
  begin
    fesintmesT:=0;
    fesridmesT:=0;
  end;
  if (Tipo = '1') or (Tipo = '2') then
    notminmes:=0;
  for i:=1 to 31 do
  begin
    //Indennità festiva
    if (Tipo = '1') or (Tipo = '3') then
    begin
      if indfes_giorno[i].Debito > 0 then
        if indfes_giorno[i].Ore > (indfes_giorno[i].Debito div 2) then
          fesintmesT:=fesintmesT + 1
        else if indfes_giorno[i].Ore >= 120 then
          fesridmesT:=fesridmesT + 1;
    end;
    //Indennità notturna
    if (Tipo = '1') or (Tipo = '2') then
    begin
      if (indnot_giorno[i].Toll > 0) or (indnot_giorno[i].Arr > 0) then
        inc(notminmes,R180ArrotondaMinuti(indnot_giorno[i].Ore + indnot_giorno[i].Toll,indnot_giorno[i].Arr))
      else
        inc(notminmes,indnot_giorno[i].Ore);
    end;
  end;
end;

procedure TR400FCartellinoDtM.RicalcoloIndPres_1;
{Ricalcolo dell'indennità di presenza in base al 'Turnetto' del S.Giovanni}
var i,x,xx:Integer;
    OK:Boolean;
begin
  for xx:=Low(trpindpmes) to High(trpindpmes) do
  begin
    trpindpmes[xx].Importo:=0;
    trpindpmes[xx].tcodindpmes:='';
    trpindpmes[xx].tggindpmes:=0;
    trpindpmes[xx].RestoIndSup:=0;
    trpindpmes[xx].RestoIndSupPrec:=0;
  end;
  n_rpindpmes:=0;
  for i:=1 to High(indpres_giorno) do
    begin
    if (i < 4) or (indpres_giorno[i].Ind = 0) then Continue;
    if (i >= 4) and (indpres_giorno[i].IndAss = 'no') then
      for x:=1 to High(indpres_giorno[i].CodInd) do
        x141_riepilogaindpres(True,True,indpres_giorno[i].CodInd[x],indpres_giorno[i].Ind,0,0);
    if (i >= 4) and (indpres_giorno[i].IndAss = 'si') (*and (indpres_giorno[i].Turno = 3)*) then
      begin
      OK:=(indpres_giorno[i - 3].Ind + indpres_giorno[i - 2].Ind + indpres_giorno[i - 1].Ind) >= 3;
      if OK then
        for x:=1 to High(indpres_giorno[i].CodInd) do
          x141_riepilogaindpres(True,True,indpres_giorno[i].CodInd[x],indpres_giorno[i].Ind,0,0);
      end;
    end;
end;

function TR400FCartellinoDtM.RichiestePendenti: Boolean;
begin
  Result:=lstDettaglio.IndexOf(C_RICHIESTE.ToString) >= 0;
end;

procedure TR400FCartellinoDtM.AggiungiIndPresCalcolateSucc;
//Considero indennità riconosciute da causali di assenza specifiche o proporzionate sul debito gg
var i,x,y,oreRese:Integer;
    lstInd,lstAss,lstAssMat,lstAssMatProp:TStringList;
    Trovato:Boolean;
    ValInd:Single;
begin
  lstInd:=TStringList.Create;
  lstAss:=TStringList.Create;
  lstAssMat:=TStringList.Create;
  lstAssMatProp:=TStringList.Create;
  //for i:=Low(indpres_giorno) to High(indpres_giorno) do
  for i:=4 to High(indpres_giorno) do //Alberto 05/12/2006
  begin
    if (indpres_giorno[i].OreRese = 0) or (Trim(indpres_giorno[i].IndSpett) = '') then
      Continue;
    if (indpres_giorno[i].OreRese < indpres_giorno[i].OreInt) and (indpres_giorno[i].OreRese < indpres_giorno[i].OreMez) then
      Continue;
    lstInd.CommaText:=indpres_giorno[i].IndSpett;
    lstAss.Clear;
    for x:=0 to High(indpres_giorno[i].RiepAss) do
      lstAss.Add(indpres_giorno[i].RiepAss[x].Causale);
    for x:=0 to lstInd.Count - 1 do
    begin
      if not (R180CarattereDef(VarToStr(selT162.Lookup('CODICE',lstInd[x],'TIPO')),1,'Z') in ['Z','F']) then
        Continue;
      if (not indpres_giorno[i].MaturaAssenze) and (VarToStr(selT162.Lookup('CODICE',lstInd[x],'MATURAZ_PROP_DEBITOGG')) <> 'S') then
        Continue;
      ValInd:=0;
      //oreRese:=0;
      lstAssMat.CommaText:=VarToStr(selT162.Lookup('CODICE',lstInd[x],'ASSENZE_ABILITATE'));
      oreRese:=indpres_giorno[i].OreLavPres;
      //aggiungo alle ore che maturano indennità (da conteggi) quelle di assenza esplicitate sulla singola indennità
      for y:=0 to High(indpres_giorno[i].RiepAss) do
        if lstAssMat.IndexOf(indpres_giorno[i].RiepAss[y].Causale) >= 0 then
          inc(oreRese,indpres_giorno[i].RiepAss[y].Minuti);
      if VarToStr(selT162.Lookup('CODICE',lstInd[x],'MATURAZ_PROP_DEBITOGG')) <> 'S' then
      begin
        //maturazione da assenza con le regole del turno intero e di metà turno
        //if indpres_giorno[i].OreRese < indpres_giorno[i].OreInt then
        if (oreRese < indpres_giorno[i].OreInt) and (oreRese >= indpres_giorno[i].OreMez) then
          ValInd:=0.5 * indpres_giorno[i].PartTime
        else if oreRese >= indpres_giorno[i].OreInt then
          ValInd:=indpres_giorno[i].PartTime;
      end
      else if indpres_giorno[i].DebitoGG > 0 then
      begin
        //Alberto 10/09/2019: FIRENZE_COMUNE - Abbuono lo scostamento negativo
        if VarToStr(selT162.Lookup('CODICE',lstInd[x],'MATURAZ_PROP_IGNORA_SCOSTNEG')) = 'S' then
          dec(OreRese,min(0,indpres_giorno[i].Scostamento));
        //maturazione da assenza con le regole del proporzionamento rispetto al debito gg
        if oreRese >= min(indpres_giorno[i].OreMez,indpres_giorno[i].OreInt) then
          ValInd:=min(oreRese,indpres_giorno[i].DebitoGG)/indpres_giorno[i].DebitoGG * indpres_giorno[i].PartTime;
      end;
      if ValInd > 0 then
      begin
        Trovato:=False;
        for y:=1 to n_rpindpmes do
          if trpindpmes[y].tcodindpmes = lstInd[x] then
          begin
            trpindpmes[y].tggindpmes:=trpindpmes[y].tggindpmes + ValInd;
            Trovato:=True;
            Break;
          end;
        if not Trovato then
          if n_rpindpmes < MAX_RPMES then
          begin
            inc(n_rpindpmes);
            y:=n_rpindpmes;
            trpindpmes[y].tcodindpmes:=lstInd[x];
            trpindpmes[y].tggindpmes:=ValInd;
            trpindpmes[y].RestoIndSup:=0;
            trpindpmes[y].RestoIndSupPrec:=0;
            trpindpmes[y].Importo:=0;
          end;
      end;
    end;
  end;
  lstInd.Free;
  lstAss.Free;
  lstAssMat.Free;
  lstAssMatProp.Free;
end;

procedure TR400FCartellinoDtM.x080_indturno;
{Calcolo delle indennità di turno}
var i,j,VarInd:Integer;
    Maturato,IndennitaTrovata,GestPluriMensile:Boolean;
    lst:TStringList;
    salva_trpturfmes:array [0..4] of Byte;
  function PosRiepPres(C:String):Integer;
  var x:Integer;
  begin
    Result:=-1;
    for x:=1 to n_rpindpmes do
      if trpindpmes[x].tcodindpmes = C then
      begin
        Result:=x;
        Break;
      end;
  end;
  function ValiditaIndPluriMensile(Progressivo:Integer; Dal,Al:TDateTime; Indennita:String):Boolean;
  var S:String;
  begin
    Result:=True;
    with T430F_CHECKIND_PLURIMENS do
    begin
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DAL',Dal);
      SetVariable('AL',Al);
      SetVariable('INDENNITA',Indennita);
      Execute;
      S:=VarToStr(GetVariable('RESULT'));
      if S <> '' then
      begin
        Result:=False;
        RegistraMsg.InserisciMessaggio('I',Format('Controllo annullato per indennità %s nel periodo %s-%s: %s',[Indennita,DateToStr(Dal),DateToStr(Al),S]),'',Progressivo);
      end;
    end;
  end;
begin
  //Maturazione indennità di turno
  with selT162 do
  begin
    Filter:=TipoIndennitaTurno;
    for i:=1 to n_rpindpmes do
      if SearchRecord('CODICE',trpindpmes[i].tcodindpmes,[srFromBeginning]) then
      begin
        //Lettura delle regole della indennità di turno
        Maturato:=False;
        VarInd:=0;
        IndennitaTrovata:=True;
        GestPluriMensile:=False;
        //Se è richiesto l'equilibrio plurimensile, lo si calcola solo sull'ultimo mese del periodo.
        if (R180CarattereDef(FieldByName('TIPO').AsString) in ['A','B','P']) and
           (FieldByName('NMESI_EQUITURNI').AsInteger > 1) and
           ((FindField('CONGUAGLIO_EQUITURNI') = nil) or (FieldByName('CONGUAGLIO_EQUITURNI').AsString = 'N')) and
           (FieldByName('CODICE2').IsNull)
        then
          if (R180Mese(DataDa) mod FieldByName('NMESI_EQUITURNI').AsInteger > 0) then
            Continue
          else
          begin
            //Verifico che il dipendente sia in servizio e l'indennità sia assegnata per tutto il periodo da controllare
            if ValiditaIndPluriMensile(A027Progressivo,R180AddMesi(R180InizioMese(DataDa),-FieldByName('NMESI_EQUITURNI').AsInteger + 1),R180FineMese(DataDa),trpindpmes[i].tcodindpmes) then
            begin
              GestPluriMensile:=True;
              R180SetVariable(selT070_T072_Prec,'PROGRESSIVO',A027Progressivo);
              R180SetVariable(selT070_T072_Prec,'DATA',R180InizioMese(DataDa));
              selT070_T072_Prec.Open;
            end
            else
              Continue;
          end;
        while IndennitaTrovata do
        begin
          if (not IndennitaTurno) and
             (not R180In(FieldByName('TIPO').AsString,['Z','F','G','H','P'])) then
          begin
            Maturato:=False;
            trpindpmes[i].tggindpmes:=0;
            trpindpmes[i].RestoIndSup:=0;
            trpindpmes[i].RestoIndSupPrec:=0;
            IndennitaTrovata:=False;
          end
          else
          begin
            //Salvo riepilogo turni per la gestione plurimensile
            for j:=0 to High(trpturfmes) do
              salva_trpturfmes[j]:=trpturfmes[j];
            if GestPluriMensile and selT070_T072_Prec.SearchRecord('CODINDPRES',trpindpmes[i].tcodindpmes,[srFromBeginning]) then
            begin
              //Se gestione plurimensile si altera il riepilogo turni con i dati dei mesi precedenti
              for j:=1 to 4 do
                inc(trpturfmes[j],selT070_T072_Prec.FieldByName('TURNI' + IntToStr(j)).AsInteger);
            end;
            if FieldByName('TIPO').AsString = 'A' then
              Maturato:=GetIndTurnoA
            else if FieldByName('TIPO').AsString = 'P' then
            begin
              if (FieldByName('NMESI_EQUITURNI').AsInteger > 1) and (FindField('CONGUAGLIO_EQUITURNI') <> nil) and (FieldByName('CONGUAGLIO_EQUITURNI').AsString = 'S') then
                Maturato:=True
              else
                Maturato:=GetIndTurnoP;
            end
            else if FieldByName('TIPO').AsString = 'B' then
              Maturato:=GetIndTurnoB
            else if FieldByName('TIPO').AsString = 'C' then
              Maturato:=GetIndTurnoC
            else if FieldByName('TIPO').AsString = 'D' then
              Maturato:=GetIndTurnoD(i,ngglavcal)
            else if FieldByName('TIPO').AsString = 'E' then
              Maturato:=GetIndTurnoE(i)
            else if FieldByName('TIPO').AsString = 'F' then
            begin
              Maturato:=True;
              VarInd:=GetIndTurnoF(i);
            end
            else if FieldByName('TIPO').AsString = 'H' then  //LORENA 01/04/2005
            begin
              Maturato:=True;
              trpindpmes[i].tggindpmes:=GetIndTurnoH(i);
              //trpindpmes[i].tggindpmes:=GetIndTurnoH(FieldByName('COEFFICIENTE').AsInteger,FieldByName('ASSENZE').AsString,FieldByName('ESCLUDI_FESTIVI').AsString);
            end
            else if FieldByName('TIPO').AsString = 'I' then
            begin
              Maturato:=True;
              trpindpmes[i].tggindpmes:=GetIndTurnoI(i);
            end;
            //Ripristino riepilogo turni modificato per la gestione plurimensile
            for j:=0 to High(trpturfmes) do
              trpturfmes[j]:=salva_trpturfmes[j];
            if Maturato then
            begin
              IndennitaTrovata:=False;
              trpindpmes[i].tcodindpmes:=FieldByName('CODICE').AsString;
              trpindpmes[i].Importo:=FieldByName('IMPORTO').AsFloat;
              trpindpmes[i].tggindpmes:=trpindpmes[i].tggindpmes + VarInd;
              //Nel caso di variazione indennità impedisco che le indennità maturate siano negative
              if (VarInd <> 0) and (trpindpmes[i].tggindpmes < 0) then
                trpindpmes[i].tggindpmes:=0;
            end
            else if not SearchRecord('CODICE',FieldByName('CODICE2').AsString,[srFromBeginning]) then
              IndennitaTrovata:=False;
          end;
        end;
        if not Maturato then
        begin
          if GestPluriMensile and selT070_T072_Prec.SearchRecord('CODINDPRES',trpindpmes[i].tcodindpmes,[srFromBeginning]) then
          begin
            //Se l'indennità plurimesile non viene maturata, si carica sul riepilogo il conguaglio negativo
            trpindpmes[i].tggindpmes:=-selT070_T072_Prec.FieldByName('INDPRES').AsInteger;
            trpindpmes[i].RestoIndSup:=0;
            trpindpmes[i].RestoIndSupPrec:=selT070_T072_Prec.FieldByName('INDSUPP_RESTO_PREC').AsFloat;
          end
          else
          begin
            trpindpmes[i].tggindpmes:=0;
            trpindpmes[i].tcodindpmes:='';
          end;
        end;
      end;
  end;
  //Maturazione indennità unitarie mensili
  with selT162 do
  begin
    Filter:='TIPO = ''V''';
    for i:=1 to n_rpindpmes do
    begin
      if Locate('CODICE',trpindpmes[i].tcodindpmes,[]) then
      begin
        if not IndennitaTurno then
        begin
          trpindpmes[i].tggindpmes:=0;
          trpindpmes[i].RestoIndSup:=0;
          trpindpmes[i].RestoIndSupPrec:=0;
          Continue;
        end;
        if trpindpmes[i].tggindpmes >= FieldByName('NUMTURNI').AsFloat then
          trpindpmes[i].tggindpmes:=1
        else
          trpindpmes[i].tggindpmes:=0;
      end;
    end;
  end;
  //Cumulo delle indennità uguali
  for i:=1 to n_rpindpmes do
    for j:=i + 1 to n_rpindpmes do
      if trpindpmes[i].tcodindpmes = trpindpmes[j].tcodindpmes then
      begin
        trpindpmes[i].tggindpmes:=trpindpmes[i].tggindpmes + trpindpmes[j].tggindpmes;
        trpindpmes[j].RestoIndSup:=0;
        trpindpmes[j].RestoIndSupPrec:=0;
        trpindpmes[j].tggindpmes:=0;
      end;
  //Annullamento indennità incompatibili che richiedono un equilibrio mensile
  lst:=TStringList.Create;
  with selT162 do
  try
    Filter:='';
    First;
    while not Eof do
    begin
      if (not FieldByName('INDENNITA_INCOMPATIBILI').IsNull) and
         (PosRiepPres(FieldByName('CODICE').AsString) >= 1) then
      begin
        lst.CommaText:=FieldByName('INDENNITA_INCOMPATIBILI').AsString;
        for i:=0 to lst.Count - 1 do
        begin
          j:=PosRiepPres(lst[i]);
          if (j >= 1) and
             ((FieldByName('TIPO').AsString <> 'Z') or
              (VarToStr(Lookup('CODICE',lst[i],'TIPO')) <> 'Z')) then
          begin
            //Eliminazione del codice per evitare un doppio annullamento
            trpindpmes[j].tcodindpmes:='';
            trpindpmes[j].tggindpmes:=0;
            trpindpmes[j].RestoIndSup:=0;
            trpindpmes[j].RestoIndSupPrec:=0;
            Break;
          end;
        end;
      end;
      Next;
    end;
  finally
    lst.Free;
  end;
  //Eliminazione delle indennità annullate
  i:=1;
  while True do
    begin
    if i > n_rpindpmes then Break;
    if trpindpmes[i].tggindpmes = 0 then
      begin
      if VarToStr(selT162.Lookup('CODICE',trpindpmes[n_rpindpmes].tcodindpmes,'TIPO')) = 'I' then
        EliminaRiepilogoPresenze(VarToStr(selT162.Lookup('CODICE',trpindpmes[n_rpindpmes].tcodindpmes,'CAUPRES_RIEPORE')));
      for j:=i + 1 to n_rpindpmes do
        trpindpmes[j - 1]:=trpindpmes[j];
      trpindpmes[n_rpindpmes].Importo:=0;
      trpindpmes[n_rpindpmes].tcodindpmes:='';
      trpindpmes[n_rpindpmes].tggindpmes:=0;
      trpindpmes[n_rpindpmes].RestoIndSup:=0;
      trpindpmes[n_rpindpmes].RestoIndSupPrec:=0;
      dec(n_rpindpmes);
      end
    else
      inc(i);
    end;
end;

function TR400FCartellinoDtM.GetIndTurnoA:Boolean;
var i,Max:Byte;
    NT,Num:Integer;
    T:String;
    function GetTurnoMax:Byte;
    var i,M:Integer;
    begin
      Result:=0;
      M:=0;
      for i:=1 to 4 do
        if trpturfmes[i] > M then
          begin
          M:=trpturfmes[i];
          Result:=i;
          end;
    end;
begin
  NT:=selT162.FieldByName('NUMTURNI').AsInteger;
  T:=selT162.FieldByName('TURNI').AsString;
  Num:=0;
  //Turni in minoranza
  if T = '<' then
    begin
    Max:=GetTurnoMax;
    for i:=1 to 4 do
      if i <> Max then
        inc(Num,trpturfmes[i]);
    end
  else
    //Turni richiesti esplicitamente
    for i:=1 to 4 do
      if Pos(IntToStr(i),T) > 0 then
        inc(Num,trpturfmes[i]);
  Result:=Num >= NT;
  //Verifico l'esistenza del minimo dei turni richiesti
  if Result then
    for i:=1 to 4 do
      if (Pos(IntToStr(i),T) > 0) and
         (trpturfmes[i] < selT162.FieldByName('TURNO' + IntToStr(i)).AsInteger) then
      begin
        Result:=False;
        Break;
      end;
end;

function TR400FCartellinoDtM.GetIndTurnoB:Boolean;
var i,Max:Byte;
    Num,Tot:Integer;
    NT:Real;
    T:String;
    function GetTurnoMax:Byte;
    var i,M:Integer;
    begin
      Result:=0;
      M:=0;
      for i:=1 to 4 do
        if trpturfmes[i] > M then
          begin
          M:=trpturfmes[i];
          Result:=i;
          end;
    end;
begin
  NT:=selT162.FieldByName('NUMTURNI').AsFloat;
  T:=selT162.FieldByName('TURNI').AsString;
  Result:=False;
  Num:=0;
  Tot:=0;
  if NT = 0 then exit;
  //Turni in minoranza
  if T = '<' then
    begin
    Max:=GetTurnoMax;
    for i:=1 to 4 do
      begin
      if i <> Max then
        inc(Num,trpturfmes[i]);
      inc(Tot,trpturfmes[i])
      end;
    end
  else
    //Turni richiesti esplicitamente
    for i:=1 to 4 do
      begin
      if Pos(IntToStr(i),T) > 0 then
        inc(Num,trpturfmes[i]);
      inc(Tot,trpturfmes[i])
      end;
  if Tot = 0 then exit;
  //Andrea: Se il numero dei turni che devo prendere in considerazione è maggiore di zero
  //        procedo a verificare la proporzione.
  //        Se non ho fatto alcun turno da considerare nel mese, è inutile verificare la proporzione...
  //        So già che non ho diritto ad alcuna indennità.
  if Num = 0 then exit;
//    Result:=(R180Arrotonda(((Num/Tot)*100),1,selT162.FieldByName('ARROTONDAMENTO').AsString)>=NT);
  //Es: il 33% del totale dei turni fatti deve essere di pomeriggio...
  //Calcolo il 33% sul totale dei turni fatti...
  Result:=Num>=R180Arrotonda(((Tot * NT)/100),1,selT162.FieldByName('ARROTONDAMENTO').AsString);

  //Verifico l'esistenza del minimo dei turni richiesti
  if Result then
    for i:=1 to 4 do
      if (Pos(IntToStr(i),T) > 0) and
         (trpturfmes[i] < selT162.FieldByName('TURNO' + IntToStr(i)).AsInteger) then
      begin
        Result:=False;
        Break;
      end;
end;

function TR400FCartellinoDtM.GetIndTurnoC:Boolean;
var L:TStringList;
    i,P:Integer;
    GA:Single;
    Esp,Esp2,C,A:String;
begin
  C:=selT162.FieldByName('CODICE').AsString;
  A:=selT162.FieldByName('ASSENZE').AsString;
  Result:=False;
  L:=TStringList.Create;
  try
    L.CommaText:=A;
    GA:=0;
    for i:=1 to n_rpassemes do
      if L.IndexOf(trpassemes[i].tcsassemes) = -1 then
        begin
        if trpassemes[i].tggassemes > 0 then
          GA:=GA + trpassemes[i].tggassemes
        else if trpassemes[i].tmgassemes > 0 then
          GA:=GA + trpassemes[i].tmgassemes/2;
        end;
    //Lettura espressione legata ai giorni di assenza
    with Q171 do
      begin
      Close;
      SetVariable('CODICE',C);
      SetVariable('GIORNI',GA);
      Open;
      if RecordCount = 0 then
        begin
        Close;
        exit;
        end;
      Esp:=FieldByName('ESPRESSIONE').AsString;
      Close;
      end;
    Esp2:=Esp;
    while (not Result) and (Pos('/',Esp) > 0) do
      begin
      P:=Pos('/',Esp);
      if P > 0 then
        Esp2:=Copy(Esp,1,P - 1)
      else
        Esp2:=Esp;
      Esp:=Copy(Esp,P + 1,Length(Esp));
      Result:=MaturaIndTurno(Esp2);
      end;
     if not Result then
       Result:=MaturaIndTurno(Esp);
  finally
    L.Free;
  end;
end;

function TR400FCartellinoDtM.GetIndTurnoD(NumInd,NumGGTot:Integer):Boolean;
var i:Byte;
    Num:Integer;
    NT:Real;
    T:String;
{(Monza) Rapporto fra:
 Num.gg.lavorati = trpindpmes[NumInd].tggindpmes
   (Giorni che hanno maturato l'ind.di presenza)
 Num.gg.lavorativi = NGGTot
   (Sulla base del calendario normale, escludendo i non lav. e i festivi)
 Il rapporto è moltiplicato per un coefficente di proporzione (NT)
   e rappresenta il numero minimo di turni specificati da svolgere arrotondato all'intero
 Se i turni specificati non sono stati svolti per niente (= 0), non si matura l'indennità:
   eventualmente guardare il secondo codice
 Se i turni svolti sono inferiori al minimo e inferiori a NT, il numero di indennità maturate sarà:
   4 * num.turni svolti. Se tale valore supera il numero di ind.originali, si mantiene quest'ultimo
 }
begin
  NT:=selT162.FieldByName('NUMTURNI').AsFloat;
  T:=selT162.FieldByName('TURNI').AsString;
  Result:=False;
  Num:=0;
  //Numero di turni richiesti fatti
  for i:=1 to 4 do
    if Pos(IntToStr(i),T) > 0 then
      Inc(Num,trpturfmes[i]);
  //Se non ci sono i turni richiesti non si pagano le indennità
  if Num = 0 then exit;
  //Controllo del minimo richiesto
  Result:=(Num >= NT) or (Num >= R180Arrotonda(NT * trpindpmes[NumInd].tggindpmes / NumGGTot,1,'P'));
  //Caso in cui si è sotto il minimo
  if not Result then
  begin
    Result:=True;
    Num:=Num * Trunc(NT);
    if Num < trpindpmes[NumInd].tggindpmes then
      trpindpmes[NumInd].tggindpmes:=Num;
  end;
  //Verifico l'esistenza del minimo dei turni richiesti
  if Result then
    for i:=1 to 4 do
      if (Pos(IntToStr(i),T) > 0) and
         (trpturfmes[i] < selT162.FieldByName('TURNO' + IntToStr(i)).AsInteger) then
      begin
        Result:=False;
        Break;
      end;
end;

function TR400FCartellinoDtM.GetIndTurnoE(NumInd:Integer):Boolean;
{PESCARA_ASL}
var
    CoeffRipCon,CoeffIndenn,TurniPrestati,GiornateLavorate:Real;
    i,NumMaxTurniPrestati,Min:integer;
    TurnoConsid:String;
    function GetTurnoMin:Byte;
    var i,M,c:Integer;
    begin
      Result:=0;
      c:=0;
      M:=32;
      for i:=1 to 4 do
        if (trpturfmes[i] <> 0) then
        begin
          c:=c+1;
          if (trpturfmes[i] < M) then
          begin
            M:=trpturfmes[i];
            Result:=i;
          end;
        end;
      if c = 1 then //Se ho fatto un solo turno, allora non esiste un turno di minoranza...
        Result:=0;
    end;
begin
  Result:=False;
  CoeffRipCon:=selT162.FieldByName('NUMTURNI').asFloat;
  CoeffIndenn:=selT162.FieldByName('COEFFICIENTE').AsFloat;
  NumMaxTurniPrestati:=selT162.FieldByName('TURNO1').AsInteger;
  TurnoConsid:=selT162.FieldByName('TURNI').AsString;
  //Turno in minoranza
  if TurnoConsid = '<' then
  begin
    Min:=GetTurnoMin;
    if (Min = 0) then //Non esiste un turno fatto in minoranza...
      exit;
    //Calcolo il numero di indennità spettanti
    TurniPrestati:=0;
    for i:=1 to 4 do
      TurniPrestati:= TurniPrestati + trpturfmes[i];
    if TurniPrestati > NumMaxTurniPrestati then
      TurniPrestati:=NumMaxTurniPrestati;
    //Alberto 14/10/2006
    if TurniPrestati > trpindpmes[NumInd].tggindpmes then
      TurniPrestati:=trpindpmes[NumInd].tggindpmes;
    //Calcolo in numero di indennità spettanti...
    trpindpmes[NumInd].tggindpmes:=R180Arrotonda((trpturfmes[Min] * CoeffIndenn),1,'P');
    if trpindpmes[NumInd].tggindpmes > TurniPrestati then
      trpindpmes[NumInd].tggindpmes:=TurniPrestati;
  end
  else
  begin
    //Turni richiesti esplicitamente... devo verificare se è stato fatta almeno 1 unità di quel turno...
    if trpturfmes[strtoint(TurnoConsid)] = 0 then
      exit;
    TurniPrestati:=0;
    //Conteggio i turni effettivamente prestati...
    for i:=1 to 4 do
      TurniPrestati:= TurniPrestati + trpturfmes[i];
    if TurniPrestati > NumMaxTurniPrestati then
      TurniPrestati:=NumMaxTurniPrestati;
    //Alberto 02/02/2007: per limitare i turni ai giorni che hanno effettivamente maturato indennità di presesenza
    if TurniPrestati > trpindpmes[NumInd].tggindpmes then
      TurniPrestati:=trpindpmes[NumInd].tggindpmes;
    //Calcolo le giornate lavorate
    GiornateLavorate:=R180Arrotonda((TurniPrestati + ((TurniPrestati * CoeffRipCon)/100)),1,'P');
    //Calcolo in numero di indennità spettanti...
    trpindpmes[NumInd].tggindpmes:=R180Arrotonda(trpturfmes[strtoint(TurnoConsid)] * CoeffIndenn,1,'P');
    if trpindpmes[NumInd].tggindpmes > GiornateLavorate then
      trpindpmes[NumInd].tggindpmes:=GiornateLavorate;
  end;
  Result:=True;
end;

function TR400FCartellinoDtM.GetIndTurnoF(NumInd:Integer):Integer;
//Aggiunta delle domeniche comprese nel periodo di maturazione indennità e detrazione dei giorni di
//assenza effettuati (escluse alcune causali es. ferie) diviso un coefficiente (es. 7)
var
  A,M,G:Word;
  i:Integer;
  NDomInd,NAssInd,NAssIndMese:Integer;
begin
  NDomInd:=0;
  NAssInd:=0;
  NAssIndMese:=0;
  //Calcolo le domeniche di servizio del mese comprese tra data inizio e data fine maturazione
  //dell'indennità
  for i:=1 to NDomenicheServizio do
    if (DomenicheServizio[i] >= trpindpmes[NumInd].gginiziomat) and
       (DomenicheServizio[i] <= trpindpmes[NumInd].ggfinemat) then
      inc(NDomInd);
  //Estraggo assenze che abbattono l'indennità; sia i residui fino a fine mese precedente che i
  //giorni del mese
  begin
    //Se il coefficiente è a zero non detraggo indennità per le assenze
    if selT162.FieldByName('COEFFICIENTE').AsInteger <> 0 then
    begin
      if (selT040.GetVariable('Progressivo') <> A027Progressivo) or
         (selT040.GetVariable('DataInizioMese') <> DataDa) or
         (selT040.GetVariable('DataFineMese') <> DataA) or
         (selT040.GetVariable('ElencoCausaliEscluse') <> selT162.FieldByName('ELENCOASSENZE').AsString) then
      begin
        selT040.SetVariable('Progressivo',A027Progressivo);
        DecodeDate(DataDa,A,M,G);
        selT040.SetVariable('DataInizioAnno',EncodeDate(A,1,1));
        selT040.SetVariable('DataFineMesePrec',R180InizioMese(DataDa) - 1);
        selT040.SetVariable('DataInizioMese',DataDa);
        selT040.SetVariable('DataFineMese',DataA);
        if selT162.FieldByName('ELENCOASSENZE').AsString = '''''' then
          selT040.SetVariable('ElencoCausaliEscluse',''' ''')
        else
          selT040.SetVariable('ElencoCausaliEscluse',selT162.FieldByName('ELENCOASSENZE').AsString);
        selT040.SetVariable('Coefficiente',selT162.FieldByName('COEFFICIENTE').AsInteger);
        selT040.Close;
        selT040.Open;
      end
      else
        selT040.First;
      //Ciclo sulle assenze del mese precedente + quelle del mese
      while not selT040.Eof do
      begin
        //Solo se l'indennità matura dal primo del mese, considero le assenze residue del mese precedente
        if (selT040.FieldByName('DATA').AsDateTime = R180InizioMese(DataDa) - 1) and
           (trpindpmes[NumInd].gginiziomat = R180InizioMese(DataDa)) then
          NAssInd:=selT040.FieldByName('NUMASS').AsInteger;
        //Considero solo le assenze comprese nella data di maturazione indennità
        if (selT040.FieldByName('DATA').AsDateTime >= trpindpmes[NumInd].gginiziomat) and
           (selT040.FieldByName('DATA').AsDateTime <= trpindpmes[NumInd].ggfinemat) then
          NAssInd:=NAssInd + selT040.FieldByName('NUMASS').AsInteger;
        //Calcolo tutte le assenze del mese per togliere ind.delle domeniche se assenze del mese >= 28
        if (selT040.FieldByName('DATA').AsDateTime >= R180InizioMese(DataDa)) and
           (selT040.FieldByName('DATA').AsDateTime <= R180FineMese(DataA)) then
          NAssIndMese:=NAssIndMese + selT040.FieldByName('NUMASS').AsInteger;
        selT040.Next;
      end;
      NAssInd:=Trunc(NAssInd / selT162.FieldByName('COEFFICIENTE').AsInteger);
    end;
    Result:=NDomInd - NAssInd;
    //Se le assenze del mese sono >= 28 azzero le indennità maturate dalle domeniche
    if (NassIndMese >= 28) and (Result > 0) then
      Result:=0;
  end;
end;

function TR400FCartellinoDtM.GetIndTurnoH(rpind:Integer):Single;  //LORENA 01/04/2005
//Calcolo indennità di rischio in base ai giorni lavorativi - assenze non tollerate
//proporzionando il tutto su giorni 26\30\lav.calendario
var Coefficiente:Integer;
    AssToll,EscludiFestivi:String;
    i,NumGG:Integer;
    GGSer,GGAss,GGMax:Single;
    Lista:TStringList;
    S,FiltroEscludiFestivi:String;
begin
  Coefficiente:=selT162.FieldByName('COEFFICIENTE').AsInteger;
  AssToll:=selT162.FieldByName('ASSENZE').AsString;
  EscludiFestivi:=selT162.FieldByName('ESCLUDI_FESTIVI').AsString;
  FiltroEscludiFestivi:='';
  if EscludiFestivi = 'S' then
    FiltroEscludiFestivi:=' AND V010.FESTIVO = ''N''';
  with selGGSer do
  begin
    SetVariable('PROGRESSIVO',A027Progressivo);
    //SetVariable('DADATA',DataDa);
    //SetVariable('ADATA',DataA);
    SetVariable('DADATA',Max(DataDa,trpindpmes[rpind].gginiziomat));
    SetVariable('ADATA',Min(DataA,trpindpmes[rpind].ggfinemat));
    //SetVariable('INDENNITA',selT162.FieldByName('CODICE').AsString);
    if Coefficiente = 0 then
      SetVariable('FILTRO',' AND V010.LAVORATIVO = ''S''' + FiltroEscludiFestivi)
    else if Coefficiente = 26 then
      SetVariable('FILTRO',' AND TO_CHAR(V010.DATA,''d'') <> ''1''' + FiltroEscludiFestivi)
    else
      SetVariable('FILTRO',FiltroEscludiFestivi);
    Execute;
    GGSer:=FieldAsFloat('TOT');{Field('TOT')}       // modif. per errore se campo null - 23.08.2011
    NumGG:=FieldAsInteger('NUMGG');{Field('NUMGG')} // modif. per errore se campo null - 23.08.2011
    SetVariable('FILTRO',null);
    Execute;
  end;
  with selGGAss do
  begin
    SetVariable('PROGRESSIVO',A027Progressivo);
    //SetVariable('DADATA',DataDa);
    //SetVariable('ADATA',DataA);
    SetVariable('DADATA',Max(DataDa,trpindpmes[rpind].gginiziomat));
    SetVariable('ADATA',Min(DataA,trpindpmes[rpind].ggfinemat));
    //SetVariable('INDENNITA',selT162.FieldByName('CODICE').AsString);
    Lista:=TStringList.Create;
    Lista.Clear;
    Lista.CommaText:=AssToll;
    S:='';
    for i:=0 to Lista.Count - 1 do
    begin
      if Trim(S) <> '' then
        S:=S + ',';
      S:=S + '''' + Lista[i] + '''';
    end;
    if Trim(S) <> '' then
      SetVariable('CAUSALI',' AND T040.CAUSALE NOT IN (' + S + ')')
    else
      SetVariable('CAUSALI',' ');
    FreeAndNil(Lista);
    if Coefficiente = 0 then
      SetVariable('FILTRO',' AND V010.LAVORATIVO = ''S''' + FiltroEscludiFestivi)
    else if Coefficiente = 26 then
      SetVariable('FILTRO',' AND TO_CHAR(V010.DATA,''d'') <> ''1''' + FiltroEscludiFestivi)
    else
      SetVariable('FILTRO',FiltroEscludiFestivi);
    Execute;
    GGAss:=Field('TOT');
    SetVariable('FILTRO',null);
    Execute;
  end;
  if (Coefficiente = 26) or (Coefficiente = 30) then
    GGMax:=Coefficiente
  else
    with selGGMax do
    begin
      SetVariable('PROGRESSIVO',A027Progressivo);
      SetVariable('ADATA',DataA);
      Execute;
      GGMax:=Field('TOT');
    end;
  //Alberto 28/12/2005: Proporziono GGMax in base al part-time
  if (selGGSer.Field('MINDATA') = DateToStr(DataDa)) and (selGGSer.Field('MAXDATA') = DateToStr(DataA)) then
  begin
    if NumGG = 0 then
      GGMax:=0
    else
      GGMax:=GGMax*GGSer/NumGG;
  end;
  if (GGAss >= GGSer) and (selGGAss.Field('MINDATA') = DateToStr(DataDa)) and (selGGAss.Field('MAXDATA') = DateToStr(DataA)) then
    GGAss:=GGMax;
  if (selGGSer.Field('MINDATA') = DateToStr(DataDa)) and (selGGSer.Field('MAXDATA') = DateToStr(DataA)) then
    GGSer:=GGMax;
  if GGAss >= GGSer then
    GGAss:=GGMax;
  if GGAss >= GGMax then
    GGAss:=GGMax;
  if GGAss > GGSer then //Alberto 06/09/2012: gestione del caso di mese parziale per ass./cess.: result può essere negativo!
    GGSer:=GGAss;
  Result:=Min(GGSer,GGMax) - GGAss;
end;

function TR400FCartellinoDtM.GetIndTurnoI(NumInd:Integer):Single;
//Indennità di turno oraria per Comune di Torino
var
  app,gg,i,j,x,ni,nf,NumTP:Integer;
  CA,VMax,TurnoMax,GGLav,TotTurni,TotOre,Temp1,Temp2,NCount,TMin:Integer;
  TurniMese:array [1..4] of Byte;
  OreFasce:array [1..MaxFasce] of Integer;
  TCalc1,TCalc2:Boolean;
  CauPres:String;
  AppRiepPres:TRiepPres;
  TurniSabato,MinTurniPrioritari,MinTurniSecondari:Integer;
  T162MinTurniPrioritari,T162MinTurniSecondari,T162Sabato:String;
  function GetIndiceIndennita(gg:Integer):Integer;
  var i:Integer;
  begin
    Result:=-1;
    for i:=0 to High(indpres_giorno[gg].DatiGGIndTurnoI) do
      if indpres_giorno[gg].DatiGGIndTurnoI[i].Cod = selT162.FieldByName('CODICE').AsString then
      begin
        Result:=i;
        Break;
      end;
  end;
  function GetT162MinTurni(Expr:String; GGLav:Integer; D:TDateTime; P:Integer):Integer;
  begin
    Result:=GGLav;
    Expr:=Trim(Expr);
    if Expr = '' then
      exit;
    if TryStrToInt(Expr,Result) then
      exit;
    with selT162MinTurni do
    try
      ClearVariables;
      DeleteVariables;
      DeclareVariable('ESPRESSIONE',otSubst);
      SetVariable('ESPRESSIONE',Expr);
      if R180CercaParolaIntera(':GGLAV',Expr,',()=<>|!/+-*') > 0 then
      begin
        DeclareVariable('GGLAV',otInteger);
        SetVariable('GGLAV',GGLav);
      end;
      if R180CercaParolaIntera(':DATA',Expr,',()=<>|!/+-*') > 0 then
      begin
        DeclareVariable('DATA',otDate);
        SetVariable('DATA',D);
      end;
      if R180CercaParolaIntera(':PROGRESSIVO',Expr,',()=<>|!/+-*') > 0 then
      begin
        DeclareVariable('PROGRESSIVO',otInteger);
        SetVariable('PROGRESSIVO',P);
      end;
      Execute;
      Result:=FieldAsInteger(0);
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',Format('Anomalia durante elaborazione cartellino di %s in GetT162MinTurni. Espressione SQL: %s Errore: %s',[DateToStr(D),Expr,E.Message]),'',P);
    end;
  end;
begin
  Result:=trpindpmes[NumInd].tggindpmes;
  CauPres:=selT162.FieldByName('CAUPRES_RIEPORE').AsString;
  GGLav:=trpindpmes[NumInd].NumGGLav;
  T162MinTurniPrioritari:=IntToStr(GGLav);
  T162MinTurniSecondari:=IntToStr(GGLav);
  T162Sabato:='S';
  if selT162.FindField('MIN_TURNI_PRIORITARI') <> nil then T162MinTurniPrioritari:=selT162.FieldByName('MIN_TURNI_PRIORITARI').AsString;
  if selT162.FindField('MIN_TURNI_SECONDARI') <> nil then T162MinTurniSecondari:=selT162.FieldByName('MIN_TURNI_SECONDARI').AsString;
  if selT162.FindField('MATURA_SABATO') <> nil then T162Sabato:=selT162.FieldByName('MATURA_SABATO').AsString;
  MinTurniPrioritari:=GetT162MinTurni(T162MinTurniPrioritari,GGLav,R180InizioMese(DataDa),A027Progressivo);
  MinTurniSecondari:=GetT162MinTurni(T162MinTurniSecondari,GGLav,R180InizioMese(DataDa),A027Progressivo);
  TurniSabato:=0;
  if VarToStr(Q275Riep.Lookup('CODICE',CauPres,'ORENORMALI')) <> 'A' then
    exit;
  CA:=0;
  for i:=1 to 4 do TurniMese[i]:=0;
  for i:=1 to MaxFasce do OreFasce[i]:=0;
  for gg:=4 to R180GiorniMese(DataDa) + 3 do
  begin
    i:=GetIndiceIndennita(gg);
    if i >= 0 then
    begin
      if (Parametri.CampiRiferimento.C3_DettGG_TipoI = 'S') and AggiornamentoScheda then //Log per test CSI!
        with insUSR_T072 do
        begin
          //serve questa tabella: create table USR_T072_DETTGG_TIPOI as select * from USR_LOGINDTIPOI
          SetVariable('PROGRESSIVO',A027Progressivo);
          SetVariable('CODICE',indpres_giorno[gg].DatiGGIndTurnoI[i].Cod);
          SetVariable('DATA',R180InizioMese(DataDa) + gg - 4);
          SetVariable('TURNO1',indpres_giorno[gg].DatiGGIndTurnoI[i].Turno1);
          SetVariable('TURNO2',indpres_giorno[gg].DatiGGIndTurnoI[i].Turno2);
          SetVariable('TOTORE',indpres_giorno[gg].DatiGGIndTurnoI[i].TotOre);
          SetVariable('PUNTONOMINALE',indpres_giorno[gg].DatiGGIndTurnoI[i].PuntoNominale);
          SetVariable('ORERESE1',indpres_giorno[gg].DatiGGIndTurnoI[i].OreRese[1]);
          SetVariable('ORERESE2',indpres_giorno[gg].DatiGGIndTurnoI[i].OreRese[2]);
          SetVariable('ORERESE3',indpres_giorno[gg].DatiGGIndTurnoI[i].OreRese[3]);
          SetVariable('ORERESE4',indpres_giorno[gg].DatiGGIndTurnoI[i].OreRese[4]);
          SetVariable('SABATO',IfThen(DayOfWeek(R180InizioMese(DataDa) + gg - 4) = 7,'S','N'));
          Execute;
        end;
      //Esclusione del Sabato
      if (T162Sabato <> 'S') and (DayOfWeek(R180InizioMese(DataDa) + gg - 4) = 7) then
      begin
        if R180Between(indpres_giorno[gg].DatiGGIndTurnoI[i].Turno1,1,4) then
          inc(TurniSabato);
        if R180Between(indpres_giorno[gg].DatiGGIndTurnoI[i].Turno2,1,4) then
          inc(TurniSabato);
        Continue;
      end;
      //Totalizzazione numero turni
      if R180Between(indpres_giorno[gg].DatiGGIndTurnoI[i].Turno1,1,4) then
        inc(TurniMese[indpres_giorno[gg].DatiGGIndTurnoI[i].Turno1])
      else if indpres_giorno[gg].DatiGGIndTurnoI[i].Turno1 = -1 then
        inc(CA);
      if R180Between(indpres_giorno[gg].DatiGGIndTurnoI[i].Turno2,1,4) then
        inc(TurniMese[indpres_giorno[gg].DatiGGIndTurnoI[i].Turno2]);
    end;
  end;

  //Calcolo numero turni
  selT166.Open;
  //Equilibrio turno prioritario / turni secondari
  VMax:=0;
  TurnoMax:=0;
  for i:=1 to 4 do
    if TurniMese[i] > VMax then
    begin
      VMax:=TurniMese[i];
      TurnoMax:=i;
    end;
  //Gestione del turno del sabato da usarsi per agevolare la maturazione
  if T162Sabato <> 'A' then
    TurniSabato:=0;
  if VMax < MinTurniPrioritari then
  begin
     app:=min(TurniSabato,MinTurniPrioritari - VMax);
     inc(VMax,app);
     dec(TurniSabato,app);
  end;
  if VMax < MinTurniPrioritari then
     Result:=0
  else
  begin
    TotTurni:=0;
    NumTP:=0;
    for j:=1 to 4 do
      if TurniMese[j] = VMax then
        inc(NumTP)
      else
        inc(TotTurni,TurniMese[j]);
    TotTurni:=TotTurni + VMax * (NumTP - 1);
    if TotTurni < MinTurniSecondari then
    begin
     app:=min(TurniSabato,MinTurniPrioritari - TotTurni);
     inc(TotTurni,app);
     dec(TurniSabato,app);
    end;
    //if (TotTurni + VMax >= GGLav * 2) and (TotTurni > 0) then
    if (TotTurni + VMax >= GGLav * 2) and (TotTurni > 0) and (TotTurni >= MinTurniSecondari) then
    begin
      if (selT166.Lookup('CODICE',selT162.FieldByName('CODICE').AsString,'COUNT') > 0) then
      begin  //Considero tutti i turni svolti
        TCalc1:=True;
        Result:=TurniSabato;
        for i:=1 to 4 do Result:=Result + TurniMese[i];
      end
      else
      begin //Confronto i turni prioritari da quelli minoritari
        if TotTurni + CA + TurniSabato >= (VMax - 2) then //SOMMO LE ORE DI TUTTO IL MESE
        begin
          TCalc1:=True;
          Temp1:=TotTurni + CA + TurniSabato + VMax;
        end
        else
        begin //ELIMINO DALLA SOMMA LE ORE DEI TURNI MINORITARI
         TCalc1:=False;
         Temp1:=(TotTurni + CA + TurniSabato) * 2;
        end;
        if TotTurni >= (VMax - 2) + CA + TurniSabato then
        begin
         TCalc2:=True;
         Temp2:=TotTurni + CA + TurniSabato + VMax;
        end
        else
        begin
         TCalc2:=False;
         Temp2:=TotTurni * 2;
        end;
        if Temp2 >= Temp1 then
        begin
         TCalc1:=TCalc2;
         Result:=Temp2;
        end
        else
          Result:=Temp1;
      end;
    end
    else
      Result:=0;
  end;

  //Calcolo le ore
  if Result > 0 then
  begin
    (*---CALCOLO DELLE ORE IN BASE ALLA CONDIZIONE (TOTTURN >= (VMAX - 2) + CA)---*)
    if TCalc1 then
    begin
      for j:=4 to R180GiorniMese(DataDa) + 3 do
      begin
        if (T162Sabato = 'N') and (DayOfWeek(R180InizioMese(DataDa) + j - 4) = 7) then
          Continue;
        ni:=GetIndiceIndennita(j);
        if ni >= 0 then
          for nf:=1 to MaxFasce do
            inc(OreFasce[nf],indpres_giorno[j].DatiGGIndTurnoI[ni].OreRese[nf]);
      end;
    end
    else
    begin
      NCount:=TotTurni + CA + TurniSabato + (VMax * NumTP);
      {Se i turni effettuati eccedono quelli riconosciuti, li tolgo dal riepilogo orario annullando i giorni con questa logica:
      I giorni migliori da considerare nel conteggio delle ore sono:
      - tutti i giorni in cui il dipendente ha svolto il lavoro nei turni minori
      -	i restanti giorni (turni maggioritari) in cui il dipendente ha reso più ore, con questa eccezione:
        considerare prima i giorni in cui il dipendente ha lavorato nelle fasce notturne/festive,
        anche se il numero di ore è inferiore rispetto agli altri giorni.
      }
      while NCount > Result do
      begin
        //TROVO IL TURNO CON MENO ORE SOLO TRA I TURNI MAGGIORITARI PER ESCLUDERLI
        TMin:=High(Integer);
        for j:=4 to R180GiorniMese(DataDa) + 3 do
        begin
          if (T162Sabato = 'N') and (DayOfWeek(R180InizioMese(DataDa) + j - 4) = 7) then
            Continue;
          ni:=GetIndiceIndennita(j);
          if ni >= 0 then
          begin
            if (indpres_giorno[j].DatiGGIndTurnoI[ni].Turno1 <> TurnoMax) and (indpres_giorno[j].DatiGGIndTurnoI[ni].Turno2 <> TurnoMax) then
              Continue;
            TotOre:=indpres_giorno[j].DatiGGIndTurnoI[ni].TotOre;
            //Offset +1000 se giorno con ore maggiorate oltre il 15
            if TotOre > 0 then
              for x:=1 to High(FasceMese) do
                if (FasceMese[x].Maggiorazione <> 15) and (indpres_giorno[j].DatiGGIndTurnoI[ni].OreRese[x] > 0) then
                begin
                  inc(TotOre,1000);
                  Break;
                end;
            (*
            if R180Between(indpres_giorno[j].DatiGGIndTurnoI[ni].TotOre,1,TMin - 1) then
              TMin:=indpres_giorno[j].DatiGGIndTurnoI[ni].TotOre;
            *)
            if R180Between(TotOre,1,TMin - 1) then
              TMin:=TotOre;
          end;
        end;
        if TMin = High(Integer) then
          Break;
        //Annullo i giorni le cui ore rese sono minime
        for j:=4 to R180GiorniMese(DataDa) + 3 do
        begin
          if NCount = Result then
            Break;
          if (T162Sabato = 'N') and (DayOfWeek(R180InizioMese(DataDa) + j - 4) = 7) then
            Continue;
          ni:=GetIndiceIndennita(j);
          if ni >= 0 then
          begin
            if (indpres_giorno[j].DatiGGIndTurnoI[ni].Turno1 <> TurnoMax) and (indpres_giorno[j].DatiGGIndTurnoI[ni].Turno2 <> TurnoMax) then
              Continue;

            TotOre:=indpres_giorno[j].DatiGGIndTurnoI[ni].TotOre;
            //Offset +1000 se giorno con ore maggiorate oltre il 15
            if TotOre > 0 then
              for x:=1 to High(FasceMese) do
                if (FasceMese[x].Maggiorazione <> 15) and (indpres_giorno[j].DatiGGIndTurnoI[ni].OreRese[x] > 0) then
                begin
                  inc(TotOre,1000);
                  Break;
                end;
            //if indpres_giorno[j].DatiGGIndTurnoI[ni].TotOre = TMin then
            if TotOre = TMin then
            begin
              for nf:=1 to MaxFasce do
                indpres_giorno[j].DatiGGIndTurnoI[ni].OreRese[nf]:=0;
              indpres_giorno[j].DatiGGIndTurnoI[ni].TotOre:=0;
              dec(NCount);
            end;
          end;
        end;
      end;
      for j:=4 to R180GiorniMese(DataDa) + 3 do
      begin
        if (T162Sabato = 'N') and (DayOfWeek(R180InizioMese(DataDa) + j - 4) = 7) then
          Continue;
        ni:=GetIndiceIndennita(j);
        if ni >= 0 then
          for nf:=1 to MaxFasce do
            inc(OreFasce[nf],indpres_giorno[j].DatiGGIndTurnoI[ni].OreRese[nf]);
      end;
    end;
  end;
  TotOre:=0;
  for nf:=1 to MaxFasce do
    inc(TotOre,OreFasce[nf]);

  //Limito le ore leggendo i limiti dalla T166
  if selT166.Lookup('CODICE',selT162.FieldByName('CODICE').AsString,'COUNT') > 0 then
    with USR_T166F_GETOREMAX do
    begin
      SetVariable('PROGRESSIVO',A027Progressivo);
      SetVariable('DATA',R180FineMese(DataDa));
      SetVariable('TURNI',Trunc(Result));
      SetVariable('CODICE',selT162.FieldByName('CODICE').AsString);
      Execute;
      Temp1:=GetVariable('RESULT');
      Temp1:=max(0,TotOre - Temp1);
      dec(TotOre,Temp1);
      if Temp1 > 0 then
        for nf:=1 to MaxFasce do
        begin
          Temp2:=min(OreFasce[nf],Temp1);
          dec(Temp1,Temp2);
          dec(OreFasce[nf],Temp2);
          if Temp1 = 0 then
            Break;
        end;
    end;

  //Gestione causale di presenze contenente riepilogo delle ore
  if (Result > 0) and (TotOre > 0) then
  begin
    i:=GetRiepilogoPresenze(CauPres,
                            VarToStr(Q275Riep.Lookup('CODICE',CauPres,'DESCRIZIONE')),
                            VarToStr(Q275Riep.Lookup('CODICE',CauPres,'SIGLA')));
    if i > 0 then
      for nf:=1 to MaxFasce do
      begin
        //Gestione della ripartizione in fasce
        if VarToStr(Q275Riep.Lookup('CODICE',CauPres,'RIPFASCE')) = 'B' then
          inc(trppresmes[i].tminpresmes[nf],OreFasce[nf])
        else
          inc(trppresmes[i].tminpresmes[1],OreFasce[nf]);
      end;
    //Riaggiorno il riepilogo annuale della scheda riepilogativa
    j:=R450DtM1.IndiceRiepPres(CauPres);
    if j = -1 then
      R450DtM1.AddRiepPres
    else
    begin
      for nf:=1 to MaxFasce do
      begin
        dec(R450DtM1.RiepPres[j].Liquidato[nf],R450DtM1.RiepPres[j].LiquidatoMese[nf]);
        inc(R450DtM1.RiepPres[j].Residuo[nf],R450DtM1.RiepPres[j].LiquidatoMese[nf])
      end;
    end;
    j:=length(R450DtM1.RiepPresCartellino);
    SetLength(R450DtM1.RiepPresCartellino,j + 1);
    R450DtM1.RiepPresCartellino[j].Causale:=CauPres;
    for nf:=1 to MaxFasce do
      R450DtM1.RiepPresCartellino[j].OreRese[nf]:=trppresmes[i].tminpresmes[nf];
    R450DtM1.GetRiepilogoPresenze('',DataDa,AppRiepPres,j);
  end;
end;

function TR400FCartellinoDtM.GetIndTurnoP:Boolean;
var i:Byte;
    Tot:Integer;
    TurniFatti:Real;
begin
  Result:=False;
  Tot:=0;
  //Devo prendere in considerazione tutti i turni con percentuale > 0
  for i:=1 to 4 do
    inc(Tot,trpturfmes[i]);
  if Tot = 0 then exit;
  //Verifico l'esistenza del minimo dei turni richiesti
  for i:=1 to 4 do
  begin
    TurniFatti:=selT162.FieldByName('TURNO' + IntToStr(i)).AsFloat * Tot / 100;
    TurniFatti:=R180Arrotonda(TurniFatti,1,selT162.FieldByName('ARROTONDAMENTO').AsString);
    if (trpturfmes[i] < TurniFatti) or
       ((trpturfmes[i] = 0) and (selT162.FieldByName('TURNO' + IntToStr(i)).AsFloat > 0)) then
      exit;
  end;
  Result:=True;
end;

function TR400FCartellinoDtM.MaturaIndTurno(Esp:String):Boolean;
var L:TStringList;
    i,P:Integer;
    N1,N2:Integer;
begin
  L:=TStringList.Create;
  try
    Result:=True;
    L.CommaText:=Esp;
    for i:=0 to L.Count - 1 do
      begin
      P:=Pos('*',L[i]);
      N1:=StrToInt(Copy(L[i],1,P - 1));
      N2:=StrToInt(Copy(L[i],P + 1,Length(L[i])));
      if trpturfmes[N1] < N2 then
        begin
        Result:=False;
        Break;
        end;
      end;
  finally
    L.Free;
  end;
end;

procedure TR400FCartellinoDtM.x085_restoindennita;
var j,xx:Integer;
begin
  R180SetVariable(selT072Prec,'PROGRESSIVO',A027Progressivo);
  R180SetVariable(selT072Prec,'DATA',DataDa);
  with selT072Prec do
  begin
    Open;
    First;
    while not Eof do
    begin
      //Riepilogo gettoni insieme alle indennità
      xx:=-1;
      for j:=1 to n_rpindpmes do
        if trpindpmes[j].tcodindpmes = FieldByName('CODINDPRES').AsString then
        begin
          xx:=j;
          Break;
        end;
      if xx = -1 then
      begin
        if n_rpindpmes >= MAX_RPMES then
        begin
          Next;
          Continue;
        end;
        inc(n_rpindpmes);
        xx:=n_rpindpmes;
        trpindpmes[xx].tcodindpmes:=FieldByName('CODINDPRES').AsString;
        trpindpmes[xx].tggindpmes:=0;
        trpindpmes[xx].RestoIndSup:=0;
        trpindpmes[xx].RestoIndSupPrec:=0;
        try
          trpindpmes[xx].Importo:=selT162.Lookup('CODICE',FieldByName('CODINDPRES').AsString,'IMPORTO');
        except
          trpindpmes[xx].Importo:=0;
        end;
      end;
      if trpindpmes[xx].RestoIndSupPrec = 0 then
        trpindpmes[xx].RestoIndSup:=trpindpmes[xx].RestoIndSup + FieldByName('INDSUPP_RESTO').AsFloat
      else
        trpindpmes[xx].RestoIndSup:=trpindpmes[xx].RestoIndSupPrec;
      Next;
    end;
  end;
  for j:=1 to n_rpindpmes do
    if trpindpmes[j].RestoIndSup > 0 then
    begin
      trpindpmes[j].tggindpmes:=trpindpmes[j].tggindpmes + Trunc(trpindpmes[j].RestoIndSup);
      trpindpmes[j].RestoIndSup:=Frac(trpindpmes[j].RestoIndSup);
    end;
end;

procedure TR400FCartellinoDtM.x090_gettoni;
var i,j,xx:Integer;
begin
  //Lettura ultimo residuo gettoni
  with selT073 do
  begin
    SetVariable('PROGRESSIVO',A027Progressivo);
    SetVariable('DATA',DataDa);
    Close;
    Open;
  end;
  for i:=0 to High(RiepGettoni) do
  begin
    //Calcolo gettoni maturati
    if (RiepGettoni[i].Spezzoni) and (selT073.SearchRecord('CAUSALE',RiepGettoni[i].Causale,[srFromBeginning])) then
      inc(RiepGettoni[i].Minuti,selT073.FieldByName('GETTONE_RESIDUO').AsInteger);
    RiepGettoni[i].Gettoni:=RiepGettoni[i].Minuti div RiepGettoni[i].OreGettone;
    RiepGettoni[i].Resto:=RiepGettoni[i].Minuti mod RiepGettoni[i].OreGettone;
    if RiepGettoni[i].Gettoni > 0 then
    begin
      //Riepilogo gettoni insieme alle indennità
      xx:=-1;
      for j:=1 to n_rpindpmes do
        if trpindpmes[j].tcodindpmes = RiepGettoni[i].Indennita then
        begin
          xx:=j;
          Break;
        end;
      if xx = -1 then
      begin
        if n_rpindpmes >= MAX_RPMES then
          exit;
        inc(n_rpindpmes);
        xx:=n_rpindpmes;
        trpindpmes[xx].tcodindpmes:=RiepGettoni[i].Indennita;
        trpindpmes[xx].tggindpmes:=0;
        trpindpmes[xx].RestoIndSup:=0;
        trpindpmes[xx].RestoIndSupPrec:=0;
        try
          trpindpmes[xx].Importo:=selT162.Lookup('CODICE',RiepGettoni[i].Indennita,'IMPORTO');
        except
          trpindpmes[xx].Importo:=0;
        end;
      end;
      trpindpmes[xx].tggindpmes:=trpindpmes[xx].tggindpmes + RiepGettoni[i].Gettoni;
    end;
  end;
  selT073.Close;
end;

function TR400FCartellinoDtM.FormattaTimbratura(S:String; T:t_ttimbraturedipmese; var Indice:Integer):String;
var DG,RL:String;
begin
  //E0800
  if EsisteDato(C_TI1) then
  begin
    Indice:=C_TI1;
    Result:=S;
  end
  //E0800x
  else if EsisteDato(C_TI2) then
  begin
    Indice:=C_TI2;
    DG:=GetSiglaGiust(T.tcaustimb);
    Result:=Format('%s%1s',[S,DG]);
  end
  //E0800-x
  else if EsisteDato(C_TI3) then
  begin
    Indice:=C_TI3;
    DG:=GetSiglaGiust(T.tcaustimb);
    if Trim(DG) <> '' then DG:='-' + DG;
    Result:=Format('%s%-2s',[S,DG]);
  end
  //E0800-xxxxx
  else if EsisteDato(C_TI4) then
  begin
    Indice:=C_TI4;
    if Trim(T.tcaustimb) <> '' then
      DG:='-' + T.tcaustimb
    else
      DG:='';
    Result:=Format('%s%-6s',[S,DG]);
  end
  //E0800-rr
  else if EsisteDato(C_TI5) then
  begin
    Indice:=C_TI5;
    if Trim(T.trilevtimb) <> '' then
      DG:='-' + T.trilevtimb
    else
      DG:='';
    Result:=Format('%s%-3s',[S,DG]);
  end
  //E0800x-rr
  else if EsisteDato(C_TI6) then
  begin
    Indice:=C_TI6;
    DG:=GetSiglaGiust(T.tcaustimb);
    if Trim(T.trilevtimb) <> '' then
      RL:='-' + T.trilevtimb
    else
     RL:='';
    Result:=Format('%s%1s%-3s',[S,DG,RL]);
  end
  //E0800-x-rr
  else if EsisteDato(C_TI7) then
  begin
    Indice:=C_TI7;
    DG:=GetSiglaGiust(T.tcaustimb);
    if Trim(DG) <> '' then
      DG:='-' + DG;
    if Trim(T.trilevtimb) <> '' then
      RL:='-' + T.trilevtimb
    else
     RL:='';
    Result:=Format('%s%-2s%-3s',[S,DG,RL]);
  end
  //E0800-xxxxx-rr
  else if EsisteDato(C_TI8) then
  begin
    Indice:=C_TI8;
    if Trim(T.tcaustimb) <> '' then
      DG:='-' + T.tcaustimb
    else
      DG:='';
    if Trim(T.trilevtimb) <> '' then
      RL:='-' + T.trilevtimb
    else
     RL:='';
    Result:=Format('%s%-6s%-3s',[S,DG,RL]);
  end;
  //Annullamento timbratura se causale esclusa: devo però valorizzare correttamente la variabile Indice.
  if (Trim(T.tcaustimb) <> '') and (Pos(',' + T.tcaustimb + ',',',' + Q950Int.FieldByName('CAUPRES_ESCLUSE').AsString + ',') > 0) then
    Result:='';
end;

function TR400FCartellinoDtM.FormattaTimbratura2(S:String; T:t_ttimbraturedipmese; Indice:Integer):String;
var DG,RL:String;
begin
  //Indice:=C_TI1;
  Result:=S;
  //E0800
  if Indice = C_TI1 then exit;
  //E0800x
  if Indice = C_TI2 then
    begin
    //Indice:=C_TI2;
    DG:=GetSiglaGiust(T.tcaustimb);
    Result:=Format('%s%1s',[S,DG]);
    exit;
    end;
  //E0800-x
  if Indice = C_TI3 then
    begin
    //Indice:=C_TI3;
    DG:=GetSiglaGiust(T.tcaustimb);
    if Trim(DG) <> '' then DG:='-' + DG;
    Result:=Format('%s%-2s',[S,DG]);
    exit;
    end;
  //E0800-xxxxx
  if Indice = C_TI4 then
    begin
    //Indice:=C_TI4;
    if Trim(T.tcaustimb) <> '' then
      DG:='-' + T.tcaustimb
    else
      DG:='';
    Result:=Format('%s%-6s',[S,DG]);
    exit;
    end;
  //E0800-rr
  if Indice = C_TI5 then
    begin
    //Indice:=C_TI5;
    if Trim(T.trilevtimb) <> '' then
      DG:='-' + T.trilevtimb
    else
      DG:='';
    Result:=Format('%s%-3s',[S,DG]);
    exit;
    end;
  //E0800x-rr
  if Indice = C_TI6 then
    begin
    //Indice:=C_TI6;
    DG:=GetSiglaGiust(T.tcaustimb);
    if Trim(T.trilevtimb) <> '' then
      RL:='-' + T.trilevtimb
    else
      RL:='';
    Result:=Format('%s%1s%-3s',[S,DG,RL]);
    exit;
    end;
  //E0800-x-rr
  if Indice = C_TI7 then
    begin
    //Indice:=C_TI7;
    DG:=GetSiglaGiust(T.tcaustimb);
    if Trim(DG) <> '' then
      DG:='-' + DG;
    if Trim(T.trilevtimb) <> '' then
      RL:='-' + T.trilevtimb
    else
     RL:='';
    Result:=Format('%s%-2s%-3s',[S,DG,RL]);
    exit;
    end;
  //E0800-xxxxx-rr
  if Indice = C_TI8 then
    begin
    //Indice:=C_TI8;
    if Trim(T.tcaustimb) <> '' then
      DG:='-' + T.tcaustimb
    else
      DG:='';
    if Trim(T.trilevtimb) <> '' then
      RL:='-' + T.trilevtimb
    else
     RL:='';
    Result:=Format('%s%-6s%-3s',[S,DG,RL]);
    exit;
    end;
end;

procedure TR400FCartellinoDtM.e022_saltogg;
{Testo se considerare o meno il giorno per il cartellino settimanale
 in base al riepilogo saldi e istituti}
begin
  s_saltoggsaldi:='no';
  s_saltoggistit:='no';
  s_saltoggistit1:='no';
  if (R502ProDtM1.numcorr < ncinisaldi) or (R502ProDtM1.numcorr > ncfinsaldi) then
    s_saltoggsaldi:='si';
  if (R502ProDtM1.numcorr < nciniistit) or (R502ProDtM1.numcorr > ncfinistit) then
    s_saltoggistit:='si';
  if (R502ProDtM1.numcorr <= nciniistit) or (R502ProDtM1.numcorr > ncfinistit + 1) then
    s_saltoggistit1:='si';
end;

procedure TR400FCartellinoDtM.x018_registraindpres;
var i,h:Integer;
begin
  if (R502ProDtM1.numcorr >= (nciniistit - 3)) and (R502ProDtM1.numcorr <= ncfinistit + 1) then
    if not((c03_tipocart = 'S') and (s_tiporiepist = 'M') and
           (R502ProDtM1.numcorr > ncfinsaldi) and (s_saltoggnontot = 'si')) then
    begin
      //Indennità da assenza e turno pianificato per ricalcolo mensile
      inc(NGIndPres);
      indpres_giorno[NGIndPres].IndAss:=R502ProDtM1.IndPresAssenza;
      indpres_giorno[NGIndPres].Turno:=R502ProDtM1.c_turni1;
      (*Alberto 05/01/2006: dati per aggiungere le indennità maturate da causale di assenza*)
      indpres_giorno[NGIndPres].MaturaAssenze:=(R502ProDtM1.tindennitapresenza[3].tindpres = 0) and (R502ProDtM1.n_riepasse > 0);
      indpres_giorno[NGIndPres].OreRese:=R502ProDtM1.totlav;
      indpres_giorno[NGIndPres].OreInt:=R502ProDtM1.mmminpresoggiint;
      indpres_giorno[NGIndPres].OreMez:=R502ProDtM1.mmminpresoggimez;
      indpres_giorno[NGIndPres].OreLavPres:=R502ProDtM1.minlavpresoggi;
      //Alberto 10/09/2019: FIRENZE_COMUNE - Abbuono lo scostamento negativo
      indpres_giorno[NGIndPres].Scostamento:=R502ProDtM1.scost + R502ProDtM1.RiepAssenzaOreInalterate;
      indpres_giorno[NGIndPres].DebitoGG:=R502ProDtM1.debitogg;
      indpres_giorno[NGIndPres].PartTime:=R502ProDtM1.PercPartTime['INDPRES'];
      for i:=1 to R502ProDtM1.n_riepasse do
      begin
        //if R502ProDtM1.ValStrT265[R502ProDtM1.triepgiusasse[i].tcausasse,'INDPRES'] = 'N' then
        begin
          h:=Length(indpres_giorno[NGIndPres].RiepAss);
          SetLength(indpres_giorno[NGIndPres].RiepAss,h + 1);
          indpres_giorno[NGIndPres].RiepAss[h].Causale:=R502ProDtM1.triepgiusasse[i].tcausasse;
          if R502ProDtM1.triepgiusasse[i].tminresasse > 0 then
            indpres_giorno[NGIndPres].RiepAss[h].Minuti:=R502ProDtM1.triepgiusasse[i].tminresasse
          else
            indpres_giorno[NGIndPres].RiepAss[h].Minuti:=R502ProDtM1.triepgiusasse[i].tminvalasse;
        end;
      end;
      x140_rpindpres(False); //Alberto 05/01/2006
      x145_rpggIndTurnoI(NGIndPres); //Alberto 11/10/2010
    end;
end;

procedure TR400FCartellinoDtM.x020_vertotalizz;
{Totalizzazioni}
begin
  x022_totalizz;
  //Impostazione dati plus orario e dati contratto
  if (R502ProDtM1.numcorr >= ncinisaldi) and (R502ProDtM1.numcorr <= ncfinsaldi) and (R502ProDtM1.dipinser = 'si') and (R450DtM1.poflag = #0) and (R502ProDtM1.blocca = 0) then
  begin
    R450DtM1.poflag:=R502ProDtM1.tipogespo;
    debitoposm_sv:=R502ProDtM1.debitoposm;
    debitoposv_sv:=R502ProDtM1.debitoposv;
    debitopomm_sv:=R180OreMinutiExt(R502ProDtM1.debitopomm);
    debpoind_sv:=R502ProDtM1.debpoind;
    datadeccon_sv:=R502ProDtM1.datadeccon;
  end;
  //Riepilogo indennità di presenza
  x140_rpindpres(True);
end;

procedure TR400FCartellinoDtM.PulisciRiepilogoAssenze;
var i,j:Integer;
begin
  //Elimino le assenze che non sono richieste poichè non servono più per i conteggi
  for i:=n_rpassemes downto 1 do
    if (trpassemes[i].tdescassemes = '$$$') or
       (AbbattiBancaOre) or
       (Pos(',' + trpassemes[i].tcsassemes + ',',',' + Q950Int.FieldByName('CAUASS_NO_RIEPILOGO').AsString + ',') > 0) or
       (not A000FiltroDizionario('CAUSALI SUL CARTELLINO',trpassemes[i].tcsassemes)) then
    begin
      for j:=i to n_rpassemes - 1 do
        trpassemes[j]:=trpassemes[j + 1];
      trpassemes[n_rpassemes].tCalcolato:=False;
      trpassemes[n_rpassemes].tCompetenze:=False;
      trpassemes[n_rpassemes].tcsassemes:='';
      trpassemes[n_rpassemes].tdescassemes:='';
      trpassemes[n_rpassemes].tfnretrmes:=0;
      trpassemes[n_rpassemes].tggassemes:=0;
      trpassemes[n_rpassemes].tmgassemes:=0;
      trpassemes[n_rpassemes].tminassemes:=0;
      trpassemes[n_rpassemes].tmintotassemes:=0;
      trpassemes[n_rpassemes].tminvalassemes:=0;
      dec(n_rpassemes);
    end;
end;

procedure TR400FCartellinoDtM.CercaParametrizzazione(Progressivo:Integer;Data:TDateTime);
begin
  with selT025 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA',Data);
    Execute;
    if RowCount > 0 then
      ParStampaCartellino:=VarToStr(Field(0))
    else
      ParStampaCartellino:='';
  end;
end;

procedure TR400FCartellinoDtM.CompletaRiepilogoAssenze;
var i,x:Integer;
    Valida:Boolean;
begin
  //Elimino le assenze che non sono richieste poichè non servono più per i conteggi
  PulisciRiepilogoAssenze;
  //Integro le causali trovate nel mese con quelle sempre richieste (Ferie)
  with Q265Comp do
  begin
    First;
    //Ricerco la causale nel riepilogo assenze mensile
    while not Eof do
    begin
      x:=0;
      for i:=1 to n_rpassemes do
        if FieldByName('Codice').AsString = trpassemes[i].tcsassemes then
        begin
          x:=i;
          Break;
        end;
      if x = 0 then
      //Se la causale non c'è la inserisco
      begin
        Valida:=True;
        //Se causale non abilitata a tutti, verifico che sia abilitata in anagrafico
        if FieldByName('Fruibile').AsString = 'N' then
        begin
          Valida:=False;
          if QSDatiAnagrafici.LocDatoStorico(R180FineMese(DataDa)) then
            Valida:=R180In(FieldByName('Codice').AsString,QSDatiAnagrafici.FieldByName('T430ABCAUSALE1').AsString.Split([',']));
          if (not Valida) and QSDatiAnagrafici.LocDatoStorico(R180FineMese(DataA)) then
            Valida:=R180In(FieldByName('Codice').AsString,QSDatiAnagrafici.FieldByName('T430ABCAUSALE1').AsString.Split([',']));
        end;
        if Valida and (n_rpassemes < MAX_RPMES) then
        begin
          inc(n_rpassemes);
          i:=n_rpassemes;
          trpassemes[i].tfnretrmes:=0;
          trpassemes[i].tggassemes:=0;
          trpassemes[i].tmgassemes:=0;
          trpassemes[i].tminassemes:=0;
          trpassemes[i].tmintotassemes:=0;
          trpassemes[i].tminvalassemes:=0;
          trpassemes[i].tcsassemes:=FieldByName('Codice').AsString;
          trpassemes[i].tdescassemes:=Q265Riep.Lookup('Codice',trpassemes[i].tcsassemes,'Descrizione');
          trpassemes[i].tCompetenze:=True;
          trpassemes[i].tCalcolato:=False;
        end;
      end;
      Next;
    end;
  end;
  if n_rpassemes > 0 then
    QuickSortRiepAss(1,n_rpassemes);
end;

{Implementeazione Quick Sort per ordinamento assenze}
procedure TR400FCartellinoDtM.QuickSortRiepAss(iLo, iHi: Integer);
var Lo, Hi: Integer;
    Mid:String;
    T:T_trpassemes;
begin
  Lo := iLo;
  Hi := iHi;
  Mid := trpassemes[(Lo + Hi) div 2].tcsassemes;
  repeat
    while trpassemes[Lo].tcsassemes < Mid do Inc(Lo);
    while trpassemes[Hi].tcsassemes > Mid do Dec(Hi);
    if Lo <= Hi then
      begin
      T := trpassemes[Lo];
      trpassemes[Lo]:=trpassemes[Hi];
      trpassemes[Hi]:=T;
      Inc(Lo);
      Dec(Hi);
      end;
  until Lo > Hi;
  if Hi > iLo then QuickSortRiepAss(iLo, Hi);
  if Lo < iHi then QuickSortRiepAss(Lo, iHi);
end;

{Implementeazione Quick Sort per ordinamento presenze}
procedure TR400FCartellinoDtM.QuickSortRiepPres(iLo, iHi: Integer);
var Lo, Hi: Integer;
    Mid:String;
    T:T_trppresmes;
begin
  Lo := iLo;
  Hi := iHi;
  Mid := trppresmes[(Lo + Hi) div 2].tcspresmes;
  repeat
    while trppresmes[Lo].tcspresmes < Mid do Inc(Lo);
    while trppresmes[Hi].tcspresmes > Mid do Dec(Hi);
    if Lo <= Hi then
      begin
      T := trppresmes[Lo];
      trppresmes[Lo]:=trppresmes[Hi];
      trppresmes[Hi]:=T;
      Inc(Lo);
      Dec(Hi);
      end;
  until Lo > Hi;
  if Hi > iLo then QuickSortRiepPres(iLo, Hi);
  if Lo < iHi then QuickSortRiepPres(Lo, iHi);
end;

function TR400FCartellinoDtM.GetRiepilogoPresenze(Codice,Descrizione,Sigla:String; Aggiungi:Boolean = True):Integer;
var xx:Integer;
begin
  Result:=0;
  repeat
    inc(Result);
  until (Result > n_rppresmes) or (trppresmes[Result].tcspresmes = Codice);
  if Result > n_rppresmes then
    if Aggiungi and (n_rppresmes < MAX_RPMES) then
    begin
      inc(n_rppresmes);
      Result:=n_rppresmes;
      trppresmes[Result].tcspresmes:=Codice;
      trppresmes[Result].tdescpresmes:=Descrizione;
      trppresmes[Result].tsiglapresmes:=Sigla;
      for xx:=1 to MaxFasce do trppresmes[Result].tminpresmes[xx]:=0;
    end
    else
      Result:=0;
end;

procedure TR400FCartellinoDtM.EliminaRiepilogoPresenze(Codice:String);
begin
end;

procedure TR400FCartellinoDtM.LimitiMensiliCausalizzati;
var i,j,k,Dal,Al,OreMax,Ore:Integer;
begin
  selT820.Filtered:=False;
  while not selT820.Eof do
  begin
    Dal:=selT820.FieldByName('DAL').AsInteger;
    Al:=selT820.FieldByName('AL').AsInteger;
    OreMax:=selT820.FieldByName('ORE').AsInteger;
    for i:=R450DtM1.NFasceMese downto 1 do
    begin
      if OreMax = 0 then
        Break;
      for j:=0 to High(StrGGdelMese) do
      begin
        if OreMax = 0 then
          Break;
        if (StrGGdelMese[j].Giorno >= Dal) and (StrGGdelMese[j].Giorno <= Al) then
        begin
          Ore:=Min(OreMax,StrGGdelMese[j].Str[i]);
          dec(OreMax,Ore);
          dec(StrGGdelMese[j].Str[i],Ore);
          k:=GetRiepilogoPresenze(selT820.FieldByName('CAUSALE').AsString,
                                  selT820.FieldByName('DESCRIZIONE').AsString,
                                  selT820.FieldByName('SIGLA').AsString);
          if k > 0 then
            inc(trppresmes[k].tminpresmes[i],Ore);
        end;
      end;
    end;
    selT820.Next;
  end;
  SetLength(StrGGdelMese,0);
end;

procedure TR400FCartellinoDtM.CompensazioneScostNegativi;
{compensazione automatica degli scostamenti negativi con le causali escluse dalle normali (STRA e RST)}
var c,i,j,k1,k2,mm,tot,TettoStr,StrAnnuo:Integer;
    Caus:String;
begin
  if (not RECBancaOre) and (not RECLiquidabile) then  //Reggio Emilia
    exit;
  //Creo riepilogo delle causali interessate se non esiste
  k1:=-1;
  k2:=-1;
  if RECLiquidabile then
    k1:=GetRiepilogoPresenze(REC_STRA,
                         VarToStr(Q275Riep.Lookup('CODICE',REC_STRA,'DESCRIZIONE')),
                         VarToStr(Q275Riep.Lookup('CODICE',REC_STRA,'SIGLA')));
  if RECBancaOre then
    k2:=GetRiepilogoPresenze(REC_RST,
                         VarToStr(Q275Riep.Lookup('CODICE',REC_RST,'DESCRIZIONE')),
                         VarToStr(Q275Riep.Lookup('CODICE',REC_RST,'SIGLA')));
  //Salvo riepilogo originale su T276
  for c:=1 to 2 do
  begin
    i:=IfThen(c = 1,k1,k2);
    if i = -1 then
      Continue;
    Caus:=IfThen(c = 1,REC_STRA,REC_RST);
    if R180SommaArray(trppresmes[i].tminpresmes) > 0 then
    begin
      for j:=0 to High(FascePaghe276Tot) do
        if FascePaghe276Tot[j].VocePaghe = '' then
        begin
          FascePaghe276Tot[j].VocePaghe:=Caus;
          FascePaghe276Tot[j].Ore:=R180SommaArray(trppresmes[i].tminpresmes);
          Break;
        end;
    end;
  end;

  //Totalizzo ore fatte con le causali interessate per vedere se sforo la disponibilità annuale:
  //in tal caso le ore eccedenti vengono messe sulle ore normali
  tot:=0;
  if k1 >= 0 then
    inc(tot,R180SommaArray(trppresmes[k1].tminpresmes));
  if k2 >= 0 then
    inc(tot,R180SommaArray(trppresmes[k2].tminpresmes));
  if tot > 0 then
  begin
    with R450DtM1.scrStrAnnuo do
    begin
      SetVariable('PROGRESSIVO',A027Progressivo);
      SetVariable('DATA',R180InizioMese(DataDa));
      Execute;
      TettoStr:=GetVariable('MaxStrAnno');
    end;
    with selT074ResoAnnuo do
    begin
      SetVariable('PROGRESSIVO',A027Progressivo);
      SetVariable('DATA',R180AddMesi(R180InizioMese(DataDa),-1));
      Execute;
      StrAnnuo:=FieldAsInteger('ORE_RESE') + tot;
    end;
    if TettoStr < StrAnnuo then
      inc(R450DtM1.tminlavmes[1],min(tot,StrAnnuo - TettoStr));
  end;

  //Saldo totale al mese precedente + Saldo mese corrente
  //Se il saldo + negativo cerco di compensarlo con i riepilghi delle presenze
  tot:=SaldoTotMesePrec + R180SommaArray(R450DtM1.tminlavmes) - (R450DtM1.debormes + R450DtM1.debpomes);
  if tot >= 0 then
    exit;
  if ((k1 >= 0) and (R180SommaArray(trppresmes[k1].tminpresmes) > 0)) or
     ((k2 >= 0) and (R180SommaArray(trppresmes[k2].tminpresmes) > 0)) then
    for c:=1 to 2 do
    begin
      i:=IfThen(c = 1,k1,k2);
      if i = -1 then
        Continue;
      for j:=1 to MaxFasce do
      begin
        mm:=min(abs(tot),trppresmes[i].tminpresmes[j]);
        inc(tot,mm);
        dec(trppresmes[i].tminpresmes[j],mm);
        inc(R450DtM1.tminlavmes[j],mm);
        if tot >= 0 then
          Break;
      end;
      if tot >= 0 then
        Break;
    end;
end;

procedure TR400FCartellinoDtM.LimitiAnnualiCausali;
var k1,k2,i1,i2,j,c,mm,
    ResidRST,ResidSTR,
    ResoMese,TettoStr,StrAnnuo:Integer;
  procedure VerificaRiepiloghi;
  var i1,i2,j:Integer;
  begin
    i1:=GetRiepilogoPresenze(REC_RST,'','',False);
    i2:=GetRiepilogoPresenze(REC_STRA,'','',False);
    if (i1 > 0) and (R180SommaArray(trppresmes[i1].tminpresmes) = 0) then
    begin
      for j:=i1 to n_rppresmes - 1 do
        trppresmes[j]:=trppresmes[j + 1];
      dec(n_rppresmes);
    end;
    if (i2 > 0) and (R180SommaArray(trppresmes[i2].tminpresmes) = 0) then
    begin
      for j:=i2 to n_rppresmes - 1 do
        trppresmes[j]:=trppresmes[j + 1];
      dec(n_rppresmes);
    end;
  end;
begin
  if (not RECBancaOre) and (not RECLiquidabile) then  //Reggio Emilia
    exit;
  k1:=-1;
  k2:=-1;
  if RECBancaOre then
    k1:=R450DtM1.IndiceRiepPres(REC_RST);
  if RECLiquidabile then
    k2:=R450DtM1.IndiceRiepPres(REC_STRA);
  mm:=0;
  if k1 >= 0 then
    inc(mm,R180SommaArray(R450DtM1.RiepPres[k1].OreReseMese));
  if k2 >= 0 then
    inc(mm,R180SommaArray(R450DtM1.RiepPres[k2].OreReseMese));
  if mm = 0 then
  begin
    VerificaRiepiloghi;
    exit;
  end;
  //Verifico riepilogo RST
  if (k1 >= 0) and (k2 >= 0) then
  begin
    ResidRST:=0;
    if k1 >= 0 then
    begin
      ResidRST:=R180SommaArray(R450DtM1.RiepPres[k1].Residuo);//Residuo totale
      ResidRST:=max(0,ResidRST);
    end;
    if (ResidRST < 20*60) and (k2 >= 0) then
    begin
      //RST deve essere almeno di 20 ore: la mancanza deve essere sanata con STRA
      ResoMese:=R180SommaArray(R450DtM1.RiepPres[k2].OreReseMese);
      ResidRST:=20*60 - ResidRST;
      if ResoMese > 0 then
      begin
        RegistraMsg.InserisciMessaggio('A','Banca ore insufficiente: alimentata da straordinario','',A027Progressivo);
        for j:=1 to MaxFasce do
        begin
          mm:=min(ResidRST,R450DtM1.RiepPres[k2].OreReseMese[j]);
          dec(ResidRST,mm);
          dec(R450DtM1.RiepPres[k2].OreReseMese[j],mm);
          dec(R450DtM1.RiepPres[k2].OreRese[j],mm);
          dec(R450DtM1.RiepPres[k2].Residuo[j],mm);
          inc(R450DtM1.RiepPres[k1].OreReseMese[j],mm);
          inc(R450DtM1.RiepPres[k1].OreRese[j],mm);
          inc(R450DtM1.RiepPres[k1].Residuo[j],mm);
          if ResidRST = 0 then
            Break;
        end;
      end;
    end
    else if (ResidRST > 90*60) and (k1 >= 0) then
    begin
      //RST non può superare le 90 ore: l'eccedenza va su STRA
      RegistraMsg.InserisciMessaggio('A','Banca ore completata: l''eccedenza è trasferita sullo straordinario','',A027Progressivo);
      dec(ResidRST,90*60);
      ResoMese:=R180SommaArray(R450DtM1.RiepPres[k1].OreReseMese);
      if ResoMese > 0 then
      begin
        //Trasferisco le ore eccedenti sulla causale REC_STRA
        for j:=1 to MaxFasce do
        begin
          mm:=min(ResidRST,R450DtM1.RiepPres[k1].OreReseMese[j]);
          dec(ResidRST,mm);
          dec(R450DtM1.RiepPres[k1].OreReseMese[j],mm);
          dec(R450DtM1.RiepPres[k1].OreRese[j],mm);
          dec(R450DtM1.RiepPres[k1].Residuo[j],mm);
          inc(R450DtM1.RiepPres[k2].OreReseMese[j],mm);
          inc(R450DtM1.RiepPres[k2].OreRese[j],mm);
          inc(R450DtM1.RiepPres[k2].Residuo[j],mm);
          if ResidRST = 0 then
            Break;
        end;
      end;
    end;
  end;
  //Verifico supero delle ore rese totali
  TettoStr:=R450DtM1.EccAutAnno['LIQUIDABILE'];
  StrAnnuo:=0;
  if k1 >= 0 then
    inc(StrAnnuo,max(0,R180SommaArray(R450DtM1.RiepPres[k1].OreRese) - R180SommaArray(R450DtM1.RiepPres[k1].AnnoPrec)));
  if k2 >= 0 then
    inc(StrAnnuo,max(0,R180SommaArray(R450DtM1.RiepPres[k2].OreRese) - R180SommaArray(R450DtM1.RiepPres[k2].AnnoPrec)));
  if StrAnnuo > TettoStr then
  begin
    RegistraMsg.InserisciMessaggio('A','Straordinario superiore alla spettanza annua: l''eccedenza viene persa','',A027Progressivo);
    ResidSTR:=StrAnnuo - TettoStr;
    for c:=1 to 2 do
    begin
      i1:=IfThen(c = 1,k2,k1);
      if i1 >= 0 then
      begin
        for j:=1 to MaxFasce do
        begin
          mm:=min(ResidSTR,R450DtM1.RiepPres[i1].OreReseMese[j]);
          dec(ResidSTR,mm);
          dec(R450DtM1.RiepPres[i1].OreReseMese[j],mm);
          dec(R450DtM1.RiepPres[i1].OreRese[j],mm);
          dec(R450DtM1.RiepPres[i1].Residuo[j],mm);
          //inc(R450DtM1.tminlavmes[j],mm);
          if ResidSTR = 0 then
            Break;
        end;
        if ResidSTR = 0 then
          Break;
      end;
    end;
  end;
  i1:=GetRiepilogoPresenze(REC_RST,'','',False);
  i2:=GetRiepilogoPresenze(REC_STRA,'','',False);
  for j:=1 to MaxFasce do
  begin
    if (k1 >= 0) and (i1 > 0) then
      trppresmes[i1].tminpresmes[j]:=R450DtM1.RiepPres[k1].OreReseMese[j];
    if (k2 >= 0) and (i2 > 0) then
      trppresmes[i2].tminpresmes[j]:=R450DtM1.RiepPres[k2].OreReseMese[j];
  end;
  VerificaRiepiloghi;
end;

procedure TR400FCartellinoDtM.SetPrimoPassaggioStampa(const Value: Boolean);
begin
  FPrimoPassaggioStampa:=Value;
  if Value then
    lstSchedeAggiornate.Clear;
end;

procedure TR400FCartellinoDtM.SoglieEccedenza;
var i,TotEccedenze,LimiteEccedenze:Integer;
    lstCausali:TStringList;
    Filtro:String;
    Eccedenze:array of T_SoglieEccedenza;
    App_tstrmese,App_tbancaore,App_eccedenza:array[1..MaxFasce] of Integer;
    MeseDopo:TDateTime;
    R450DtMMeseSucc:TR450DtM1;
  procedure GetEccedenze(GGLav:Boolean);
  var i,idx,h,Tot:Integer;
  begin
    for i:=0 to lstCausali.Count - 1 do
    begin
      Tot:=0;
      if lstCausali[i] = '<*L>' then
      begin
        //Liquidabile
        for idx:=1 to MaxFasce do App_eccedenza[idx]:=App_tstrmese[idx];
        Tot:=R180SommaArray(App_eccedenza)
      end
      else
      if lstCausali[i] = '<*B>' then
      begin
        //Banca ore
        for idx:=1 to MaxFasce do App_eccedenza[idx]:=App_tbancaore[idx];
        Tot:=R180SommaArray(App_eccedenza)
      end
      else
      begin
        //Riepilogo da causale di presenza
        idx:=GetRiepilogoPresenze(lstCausali[i],'','',False);
        if idx > 0 then
          Tot:=R180SommaArray(trppresmes[idx].tminpresmes);
      end;
      if Tot > 0 then
      begin
        dec(LimiteEccedenze,Tot);
        if LimiteEccedenze < 0 then
        begin
          inc(Tot,LimiteEccedenze);
          LimiteEccedenze:=0;
        end;
        if Tot > 0 then
        begin
          SetLength(Eccedenze,Length(Eccedenze) + 1);
          h:=High(Eccedenze);
          Eccedenze[h].Causale:=lstCausali[i];
          Eccedenze[h].GGLav:=GGLav;
          Eccedenze[h].Minuti:=Tot;
        end;
      end;
    end;
  end;
  function RiepilogaEccedenza(idx,mm:Integer):Boolean;
  var x1,y1,x2,y2,i,App:Integer;
      CauDest,RaggrDest:String;
      RaggrAbil:Boolean;
  begin
    Result:=False;
    CauDest:=IfThen(Eccedenze[idx].GGLav,selT028.FieldByName('CAUSALE_GGLAV').AsString,selT028.FieldByName('CAUSALE_GGNONLAV').AsString);
    RaggrDest:=VarToStr(Q275Riep.Lookup('CODICE',CauDest,'CODRAGGR'));
    RaggrAbil:=(QSDatiAnagrafici.LocDatoStorico(R180FineMese(DataA))) and
               (Pos(',' + RaggrDest + ',',',' + QSDatiAnagrafici.FieldByName('T430ABPRESENZA1').AsString + ',') > 0);
    if not RaggrAbil then
      exit;
    Result:=True;
    x1:=-1;
    x2:=-1;
    if Eccedenze[idx].Causale <> '<*L>' then
    begin
      x1:=GetRiepilogoPresenze(Eccedenze[idx].Causale,'','',False);
      x2:=R450DtM1.IndiceRiepPres(Eccedenze[idx].Causale);
    end;
    y1:=GetRiepilogoPresenze(CauDest,
                         VarToStr(Q275Riep.Lookup('CODICE',CauDest,'DESCRIZIONE')),
                         VarToStr(Q275Riep.Lookup('CODICE',CauDest,'SIGLA')));
    y2:=R450DtM1.IndiceRiepPres(CauDest);
    if y2 = -1 then
    begin
      y2:=R450DtM1.AddRiepPres;
      R450DtM1.RiepPres[y2].Causale:=CauDest;
    end;
    for i:=1 to MaxFasce do
    begin
      if x1 > 0 then
      begin
        //Abbatto riepilogo causale di input
        App:=min(mm,trppresmes[x1].tminpresmes[i]);
        dec(trppresmes[x1].tminpresmes[i],App);
        dec(R450DtM1.RiepPres[x2].OreReseMese[i],App);
        dec(R450DtM1.RiepPres[x2].OreRese[i],App);
        dec(R450DtM1.RiepPres[x2].Residuo[i],App);
      end
      else
      begin
        App:=min(mm,App_eccedenza[i]);
        dec(App_eccedenza[i],App);
      end;
      //Imcremento riepilogo causale di output
      inc(trppresmes[y1].tminpresmes[i],App);
      inc(R450DtM1.RiepPres[y2].OreReseMese[i],App);
      inc(R450DtM1.RiepPres[y2].OreRese[i],App);
      inc(R450DtM1.RiepPres[y2].Residuo[i],App);
      dec(mm,App);
      if mm = 0 then
        Break;
    end;
  end;
  function EspressioneSoglia(Expr:String):Integer;
  begin
    Result:=0;
    with TOracleQuery.Create(Self) do
    try
      Session:=SessioneOracleR400;
      SQL.Add(Format('select %s from DUAL',[Expr]));
      if R180CercaParolaIntera(':DATA',Expr,',()=<>|!/+-*') > 0 then
      begin
        DeclareVariable('DATA',otDate);
        SetVariable('DATA',DataDa);
      end;
      if R180CercaParolaIntera(':PROGRESSIVO',Expr,',()=<>|!/+-*') > 0 then
      begin
        DeclareVariable('PROGRESSIVO',otInteger);
        SetVariable('PROGRESSIVO',A027Progressivo);
      end;
      if R180CercaParolaIntera(':ECCEDENZA',Expr,',()=<>|!/+-*') > 0 then
      begin
        DeclareVariable('ECCEDENZA',otInteger);
        SetVariable('ECCEDENZA',TotEccedenze);
      end;
      if R180CercaParolaIntera(':DEBITOMESE',Expr,',()=<>|!/+-*') > 0 then
      begin
        DeclareVariable('DEBITOMESE',otInteger);
        SetVariable('DEBITOMESE',R450DtM1.debtotmes);
      end;
      Execute;
      Result:=FieldAsInteger(0);
    finally
      Free;
    end;
  end;
  procedure ElaboraEccedenze;
  var SSoglia:String;
      i,j,x,Soglia,SogliaPrec,SogliaApp,App:Integer;
  begin
    //Lettura ore straordinario specificate in CAUSALI_GGLAV e CAUSALI_GGNONLAV
    SetLength(Eccedenze,0);
    lstCausali:=TStringList.Create;
    try
      lstCausali.CommaText:=selT027.FieldByName('CAUSALI_GGLAV').AsString;
      GetEccedenze(True);
      lstCausali.CommaText:=selT027.FieldByName('CAUSALI_GGNONLAV').AsString;
      GetEccedenze(False);
    finally
      FreeAndNil(lstCausali);
    end;
    TotEccedenze:=0;
    for i:=0 to High(Eccedenze) do
      inc(TotEccedenze,Eccedenze[i].Minuti);
  //Trasferimento eccedenze su causali di output
  SogliaPrec:=0;
  with selT028 do
  begin
    First;
    while not Eof do
    begin
      //Riconoscimento soglia
      SSoglia:=FieldByName('SOGLIA').AsString;
      if SSoglia = '*' then
        SogliaApp:=999999
      else if Pos('%',SSoglia) = 0 then
      begin
        if FieldByName('ESPRESSIONE').AsString <> '' then
          SogliaApp:=EspressioneSoglia(FieldByName('ESPRESSIONE').AsString)
        else
          SogliaApp:=R180OreMinutiExt(SSoglia);
      end
      else
        SogliaApp:=Trunc(R450DtM1.debtotmes * StrToFloat(StringReplace(SSoglia,'%','',[])) / 100);
      Soglia:=Max(0,SogliaApp - SogliaPrec);
      SogliaPrec:=SogliaApp;
      //Distribuzione delle eccedenze fino alla soglia indicata
      for i:=0 to High(Eccedenze) do
      begin
        App:=min(Eccedenze[i].Minuti,Soglia);
        if App > 0 then
        begin
          if RiepilogaEccedenza(i,App) then
          begin
            dec(Eccedenze[i].Minuti,App);
            dec(Soglia,App);
          end;
        end;
        if Soglia = 0 then
          Break;
      end;
      Next;
    end;
  end;
  //Eliminazione riepiloghi di presenza non più significativi
  for i:=0 to High(Eccedenze) do
    if Eccedenze[i].Causale <> '<*L>' then
    begin
      x:=GetRiepilogoPresenze(Eccedenze[i].Causale,'','',False);
      if (x > 0) and (R180SommaArray(trppresmes[x].tminpresmes) = 0) then
      begin
        for j:=x to n_rppresmes - 1 do
          trppresmes[j]:=trppresmes[j + 1];
        dec(n_rppresmes);
      end;
    end;
  end;
begin
  //Lettura regole
  R180SetVariable(selT027,'TIPOCARTELLINO',R450DtM1.selT025.FieldByName('CODICE').AsString);
  R180SetVariable(selT027,'DATA',R180InizioMese(DataDa));
  selT027.Open;
  if selT027.RecordCount = 0 then
    exit;
  //Salvataggio straordinario mensile liquidabile originale
  for i:=1 to MaxFasce do
    App_tstrmese[i]:=R450DtM1.tstrmese[i];
  for i:=1 to MaxFasce do
    App_tbancaore[i]:=R450DtM1.tbancaore[i];

  LimiteEccedenze:=999999;
  if (UpperCase(Parametri.RagioneSociale) = 'ASST LARIANA'(*'AZ. OSP. SANT''ANNA DI COMO'*)) then
  begin
    if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
      R450DtMMeseSucc:=TR450DtM1.Create(Self.Owner)
    else
      R450DtMMeseSucc:=TR450DtM1.Create(SessioneOracleR400);
    try
      MeseDopo:=R180AddMesi(EncodeDate(R450DtM1.anno400,R450DtM1.mese400,1),1);
      R450DtMMeseSucc.ConteggiMese('Generico',R180Anno(MeseDopo),R180Mese(MeseDopo),A027Progressivo);
      //Si considera il saldo anno corr del mese successivo:
      //Attenzione: vengono aggiunte le liquidazioni fatte nel mese CORRENTE, perchè il ricalcolo della scheda deve ragionare come se non fossero ancora state fatte
      LimiteEccedenze:=R450DtMMeseSucc.salliqannoatt + R450DtMMeseSucc.salcompannoatt + R450DtM1.totliqmm + R450DtM1.totcausliqmm;
      //Se sto valutando Dicembre su Gennaio, devo aggiungere al saldo corrente dell'anno successivo anche il saldo corrente che risulta a Dicembre
      if (R450DtM1.mese400 = 12) (*and (not SaldiMobili)*) then
        LimiteEccedenze:=LimiteEccedenze + (R450DtM1.salliqannoprec + R450DtM1.salcompannoprec + R450DtM1.salliqannoatt + R450DtM1.salcompannoatt - R450DtMMeseSucc.salfmprec);
      LimiteEccedenze:=max(0,LimiteEccedenze);
    finally
      FreeAndNil(R450DtMMeseSucc);
    end;
  end;

  selT027.First;
  while not selT027.Eof do
  begin
    //Verifica corrispondenza con selezione anagrafica
    (* Selezione su V430*)
    selT027SelezioneAnagrafe.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
    selT027SelezioneAnagrafe.SetVariable('C700SELANAGRAFE',QVistaOracle);
    selT027SelezioneAnagrafe.SetVariable('PROGRESSIVO',A027Progressivo);
    selT027SelezioneAnagrafe.SetVariable('DATALAVORO',R180FineMese(DataDa));
    (**)
    //Alberto: Selezione su valori costanti from dual
    Filtro:=selT027.FieldByName('SELEZIONE_ANAGRAFE').AsString;
    (*
    Filtro:=StringReplace(Filtro,'T030.','',[rfReplaceAll,rfIgnoreCase]);
    Filtro:=StringReplace(Filtro,'V430.T430','T430',[rfReplaceAll,rfIgnoreCase]);
    Filtro:=StringReplace(Filtro,'V430.P430','P430',[rfReplaceAll,rfIgnoreCase]);
    Filtro:=StringReplace(Filtro,'T480.','',[rfReplaceAll,rfIgnoreCase]);
    for i:=0 to A027SelAnagrafe.FieldCount - 1 do
      while R180CercaParolaIntera(A027SelAnagrafe.Fields[i].FieldName,UpperCase(Filtro),'.,()=<>|!/+-*') > 0 do
      begin
        p:=R180CercaParolaIntera(A027SelAnagrafe.Fields[i].FieldName,UpperCase(Filtro),'.,()=<>|!/+-*');
        Delete(Filtro,p,Length(A027SelAnagrafe.Fields[i].FieldName));
        Insert('''' + AggiungiApice(A027SelAnagrafe.Fields[i].AsString) + '''',Filtro,p);
      end;
    *)
    selT027SelezioneAnagrafe.SetVariable('FILTRO',Filtro);
    selT027SelezioneAnagrafe.Close;
    try
      selT027SelezioneAnagrafe.Open;
    except
    end;
    if (not selT027SelezioneAnagrafe.Active) or (selT027SelezioneAnagrafe.RecordCount = 0) then
    begin
      selT027.Next;
      Continue;
    end;
    R180SetVariable(selT028,'ID',selT027.FieldByName('ID').AsInteger);
    selT028.Open;
    if selT028.RecordCount = 0 then
    begin
      selT027.Next;
      Continue;
    end;
    ElaboraEccedenze;
    selT027.Next;
  end;
end;

procedure TR400FCartellinoDtM.CompletaRiepilogoPresenze;
var i,x,k,xx:Integer;
    Trov:Boolean;
begin
  //Integro le causali trovate nel mese con quelle richieste annualmente
    begin
    Q275Riep.First;
    while not Q275Riep.Eof do
      begin
      if Q275Riep.FieldByName('Stampe').AsString <> 'C' then
        begin
        Q275Riep.Next;
        Continue;
        end;
      //Ricerco causale nel riepilogo annuale e verifico se contiene dati significativi
      Trov:=False;
      k:=R450DtM1.IndiceRiepPres(Q275Riep.FieldByName('Codice').AsString);
      if k >= 0 then
        begin
        if R450DtM1.RiepPres[k].CompensabileAnno <> 0 then
          Trov:=True;
        for i:=1 to R450DtM1.NFasceMese do
          begin
          if (R450DtM1.RiepPres[k].OreRese[i] <> 0) or (R450DtM1.RiepPres[k].Liquidato[i] <> 0) then
            begin
            Trov:=True;
            Break;
            end;
          end;
        end;
      //Verifico se esiste riepilogo mensile
      x:=0;
      for i:=1 to n_rppresmes do
        if Q275Riep.FieldByName('Codice').AsString = trppresmes[i].tcspresmes then
          begin
          x:=i;
          Break;
          end;
      //Non esiste niente da riepilogare
      if (not Trov) and (x = 0) then
        begin
        Q275Riep.Next;
        Continue;
        end;
      if (x = 0) and (n_rppresmes < MAX_RPMES) then
        //Se la causale non c'è la inserisco
        begin
        inc(n_rppresmes);
        x:=n_rppresmes;
        trppresmes[x].tcspresmes:=Q275Riep.FieldByName('Codice').AsString;
        trppresmes[x].tdescpresmes:=VarToStr(Q275Riep.Lookup('Codice',trppresmes[x].tcspresmes,'Descrizione'));
        trppresmes[x].tsiglapresmes:=VarToStr(Q275Riep.Lookup('Codice',trppresmes[x].tcspresmes,'Sigla'));
        for xx:=1 to MaxFasce do trppresmes[x].tminpresmes[xx]:=0;
        end;
      Q275Riep.Next;
      end;
    end;
  if n_rppresmes > 0 then
    QuickSortRiepPres(1,n_rppresmes);
end;

procedure TR400FCartellinoDtM.x040_aggscheda;
{Aggiornamento scheda riepilogativa}
var A,M,G:Word;
    i,app:Integer;
    MinOreDaLiquidare,MinOreDaCompensare:Integer;
    c_Data:TDateTime;
    T065Causale:String;
    T065OreEccedenti,T065OreCausalizzate:Integer;
    ResiduoLiquidabile:Integer;
begin
  //move m_mese to s_mese.
  //move m_anno to s_anno.
  DecodeDate(DataDa,A,M,G);
  c_Data:=EncodeDate(A,M,1);
  //Cancellazione registrazioni precedenti
  try
    with OperSql do
    begin
      DeleteVariables;
      DeclareVariable('PROGRESSIVO',otInteger);
      DeclareVariable('DATA',otDate);
      SetVariable('PROGRESSIVO',A027Progressivo);
      SetVariable('DATA',c_Data);
      Sql.Clear;
      Sql.Add('delete from T070_SCHEDARIEPIL where PROGRESSIVO = :PROGRESSIVO and DATA = :DATA');
      Execute;
      Sql.Clear;
      Sql.Add('delete from T071_SCHEDAFASCE where PROGRESSIVO = :PROGRESSIVO and DATA = :DATA');
      Execute;
      Sql.Clear;
      Sql.Add('delete from T072_SCHEDAINDPRES where PROGRESSIVO = :PROGRESSIVO and DATA = :DATA and TIPO_RECORD = ''A''');
      Execute;
      Sql.Clear;
      Sql.Add('delete from T074_CAUSPRESFASCE where (PROGRESSIVO,DATA,CAUSALE) in (select PROGRESSIVO,DATA,CAUSALE from T073_SCHEDACAUSPRES where PROGRESSIVO = :PROGRESSIVO and DATA = :DATA and TIPO_RECORD = ''A'')');
      Execute;
      Sql.Clear;
      Sql.Add('delete from T073_SCHEDACAUSPRES where PROGRESSIVO = :PROGRESSIVO and DATA = :DATA and TIPO_RECORD = ''A''');
      Execute;
      Sql.Clear;
      Sql.Add('delete from T076_CAUSPRESPAGHE where PROGRESSIVO = :PROGRESSIVO and DATA = :DATA');
      Execute;
      Sql.Clear;
      Sql.Add('delete from T077_DATISCHEDA where PROGRESSIVO = :PROGRESSIVO and DATA = :DATA and VALORE_MAN is null');
      Execute;
      Sql.Clear;
      Sql.Add('delete from T172_INDPRES_EQUITURNI where PROGRESSIVO = :PROGRESSIVO and DATA = :DATA');
      try
        Execute;
      except
      end;
      DeleteVariables;
    end;
    //Impostazione record scheda riepilogativa
    with Ins070 do
    begin
      SetVariable('Progressivo',A027Progressivo);
      SetVariable('Data',c_Data);
      SetVariable('DebitoOrario',R180MinutiOre(R450DtM1.debormes));
      //SetVariable('DebitoGG_Tot',R180MinutiOre(R450DtM1.debggtot));
      SetVariable('DebitoPo',R180MinutiOre(R450DtM1.debpomes));
      if R450DtM1.poflag = #0 then
        R450DtM1.poflag:='0';
      SetVariable('TipoPo',R450DtM1.poflag);
      SetVariable('FestivRidotta',fesridmesT);
      SetVariable('FestivIntera',fesintmesT);
      SetVariable('IndTurnoNum',notggmes);
      SetVariable('IndTurnoOre',R180MinutiOre(notminmes));
      SetVariable('FestivRidotta_Var',R450DtM1.fesridmesVar);
      SetVariable('FestivIntera_Var',R450DtM1.fesintmesVar);
      SetVariable('IndTurnoNum_Var',R450DtM1.notggmesVar);
      SetVariable('IndTurnoOre_Var',R450DtM1.notminmesVar);
      SetVariable('Causale1MinAss',R450DtM1.tdatiassestamen[1].tcauassest);
      SetVariable('Causale2MinAss',R450DtM1.tdatiassestamen[2].tcauassest);
      SetVariable('OreEccedComp',R180MinutiOre(R450DtM1.eccsolocompmes));
      SetVariable('OreEccedCompOltreSoglia',R180MinutiOre(R450DtM1.EccSoloCompMesOltreSoglia));
      SetVariable('Turni1',trpturfmes[1]);
      SetVariable('Turni2',trpturfmes[2]);
      SetVariable('Turni3',trpturfmes[3]);
      SetVariable('Turni4',trpturfmes[4]);
      SetVariable('GGPresenza',nggpresenza);
      SetVariable('RIPOSI_NONFRUITI',nggFestiviNonGoduti);
      SetVariable('GGVuoti',nggvuoti);
      SetVariable('OreVariazEcc',R180MinutiOre(R450DtM1.vareccliqmes));
      SetVariable('OreAssenze',R180MinutiOre(Max(0,Min(R450DtM1.TotOreRes,R450DtM1.minassenzemes))));
      SetVariable('RecAnnoCorr',R180MinutiOre(R450DtM1.abbannoattmes));
      SetVariable('RecAnnoPrec',R180MinutiOre(R450DtM1.abbannoprecmes));
      SetVariable('RecLiqCorr',R180MinutiOre(R450DtM1.abbliqannoattmes));
      SetVariable('RecLiqPrec',R180MinutiOre(R450DtM1.abbliqannoprecmes));
      SetVariable('ScostNeg',R180MinutiOre(R450DtM1.scostnegmes));
      SetVariable('AddebitoPaghe',R180MinutiOre(R450DtM1.AddebitoPaghe));
      SetVariable('OreComp_Liquidate',R180MinutiOre(R450DtM1.OreCompLiquidate - R450DtM1.BancaOreLiqVar));
      SetVariable('BancaOre_Liq_Var',R180MinutiOre(R450DtM1.BancaOreLiqVar));
      SetVariable('OreComp_Recuperate',R180MinutiOre(R450DtM1.OreCompRecuperate));
      SetVariable('RipCom',R180MinutiOre(R450DtM1.ripcommes));
      SetVariable('AbbRipCom',R180MinutiOre(R450DtM1.abbripcommes));
      SetVariable('Carenza_Obbligatoria',R180MinutiOre(RiepCarenzaObbligatoria));
      SetVariable('Ore_Inail',R180MinutiOre(OreInailMes));
      (*RIETI*)SetVariable('RiposiNonFruitiOre',R180MinutiOre(R450DtM1.RiposiNonFruitiOre));
      SetVariable('RIEPASS_COMPENSATE_ANNO',R180MinutiOre(R450DtM1.RiepAssCompensateAnno));
      SetVariable('RIEPASS_COMPENSATE_MESE',R180MinutiOre(R450DtM1.RiepAssCompensateMese));
      Execute;
    end;
    //Aggiornamento dati in fasce
    for i:=1 to R450DtM1.NFasceMese do
      x300_impdatifasc(c_Data,i);
    //Aggiornamento causali di presenza
    for i:=0 to High(R450DtM1.RiepPres) do
      x048_aggcaupre(c_Data,i);
    //Aggiornamento indennita' di presenza
    for i:=1 to n_rpindpmes do
      x058_aggindpre(c_Data,i);
    //Ore causalizzate in fasce a blocchi (AMGAS Bari)
    with Ins076 do
      begin
      SetVariable('Progressivo',A027Progressivo);
      SetVariable('Data',c_Data);
      for i:=0 to High(FascePaghe276Tot) do
        begin
        if FascePaghe276Tot[i].VocePaghe = '' then
          Break;
        SetVariable('VocePaghe',FascePaghe276Tot[i].VocePaghe);
        SetVariable('Ore',R180MinutiOre(FascePaghe276Tot[i].Ore));
        Execute;
        end;
      end;
    //Salvataggio Rientri pomeridiani - PARMA_AIPO
    SalvaRientriPomeridiani;
    //Salvataggio Negativi Compensabili - AOSTA_ASL
    SalvaNegativiCompensabili;

    RegistraLog.SettaProprieta('I','T070_SCHEDARIEPIL','A027',nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(A027Progressivo));
    RegistraLog.InserisciDato('DATA','',DateTostr(c_Data));
    RegistraLog.RegistraOperazione;

    MinOreDaLiquidare:=0;
    MinOreDaCompensare:=0;
    if R450DtM1.IterAutorizzativoStr = '0' then
      with delT065 do
      begin
        SetVariable('PROGRESSIVO',A027Progressivo);
        SetVariable('DATA',c_Data);
        Execute;
      end
    else
    //Si registra la banca ore lorda (liquidabmese) e le ore recuperate + liquidate nel mese
    //with T065P_REGISTRA_RICHIESTA do
    begin
      T065OreEccedenti:=0;
      T065OreCausalizzate:=0;
      T065Causale:='';
      if R450DtM1.IterAutorizzativoStr = '1' then
      begin
        //Banca ore (AOSTA_REGIONE)
        if R450DtM1.PercPT = 100 then
        try
          //Caso standard - tempo pieno: considero i limiti annuali da contratto e le varie liquidazioni
          A029FLiq:=TA029FLiquidazione.Create(Self);
          A029FLiq.R450DtM:=R450DtM1;
          A029FLiq.GetOreLiquidate(A027Progressivo,c_data);
          T065OreEccedenti:=Max(0,R450DtM1.EccAutAnno['LIQUIDABILE'] - (A029FLiq.LiqT071Anno + A029FLiq.LiqT074Anno + A029FLiq.LiqT070 + A029FLiq.AssT071Anno
                                                                    - R450DtM1.BancaOreMese));//Alberto 31/07/2012: in caso di conguaglio la banca ore del mese non deve alterare la disponibilità rispetto al limite annuale
        finally
          FreeAndNil(A029FLiq);
        end
        else
        begin
          //Caso part-time: considero i limiti annuali indicati a scaglioni per %PT, e la divisione in ore supplementari e ore di straordinario
          with GET_RESIDUOMESE_PT do
          begin
            SetVariable('PROGRESSIVO',A027Progressivo);
            SetVariable('DATA',c_Data);
            SetVariable('DEBITO',R450DtM1.Debtotmes);
            SetVariable('ECCEDENZA',R450DtM1.liquidabmese);
            Execute;
            T065OreEccedenti:=GetVariable('SUPPLRESIDUO') + GetVariable('STRRESIDUO');
            //Salvataggio su T077
            SalvaStraordinarioPT(GetVariable('SUPPLRESIDUO'),GetVariable('STRRESIDUO'));
          end;
        end;
        T065OreEccedenti:=Min(R450DtM1.liquidabmese,T065OreEccedenti);
      end
      else if R180CarattereDef(R450DtM1.IterAutorizzativoStr) in ['2','3'] then
      begin
        //Straordinario (TORINO_REGIONE, GENOVA_COMUNE)
        T065OreEccedenti:=R450DtM1.OreTroncate + R180SommaArray(R450DtM1.tstrmese);
        try
          if R450DtM1.selT025.Active and (R450DtM1.selT025.FieldByName('ITER_AUTSTR_DISPONIBILITA').AsString = 'A') then
          begin
            //(ROMA_HSAndrea) si considera la disponibilità annua
            //(da deinire il comportamento in caso di autorizzazione, le ore non autorizzate dovrebbero comunque rimanere disponibili nei saldi successivi per future liquidazioni / recupero)
            if R450DtM1.LimiteEccLiq <> 'Z' then
              T065OreEccedenti:=max(0,min(R450DtM1.salannoatt,R180SommaArray(R450DtM1.tstrannom)));
          end;
        except
        end;
      end
      else if R180CarattereDef(R450DtM1.IterAutorizzativoStr) in ['5'] then
      begin
        //Straordinario + Ore Causalizzate (SAVONA_ASL2)
        //Lettura residuo liquidabile
        //if R450DtM1.PercPT = 100 then
        try
          //Caso standard - tempo pieno: considero i limiti annuali da contratto e le varie liquidazioni
          A029FLiq:=TA029FLiquidazione.Create(Self);
          A029FLiq.R450DtM:=R450DtM1;
          A029FLiq.GetOreLiquidate(A027Progressivo,c_data);
          ResiduoLiquidabile:=Max(0,R450DtM1.EccAutAnno['LIQUIDABILE'] - (A029FLiq.LiqT071Anno + A029FLiq.LiqT074Anno + A029FLiq.LiqT070 + A029FLiq.AssT071Anno
                                                                        - R450DtM1.BancaOreMese));//Alberto 31/07/2012: in caso di conguaglio la banca ore del mese non deve alterare la disponibilità rispetto al limite annuale
        finally
          FreeAndNil(A029FLiq);
        end;

        if R450DtM1.LimiteEccLiq = 'Z' then
        begin
          //Limite default = 0: si considerano le ore troncate
          T065OreEccedenti:=R450DtM1.OreTroncate + R180SommaArray(R450DtM1.tstrmese);
        end
        else
        begin
          //Limite default = illimitato
          //(SAVONA_ASL2) si considera il min(saldo mese / saldo anno)
          T065OreEccedenti:=max(0,min(min(R450DtM1.SalMeseAtt,R450DtM1.salannoatt),R180SommaArray(R450DtM1.tstrmese)));
          try
            if R450DtM1.selT025.Active and (R450DtM1.selT025.FieldByName('ITER_AUTSTR_DISPONIBILITA').AsString = 'A') then
            begin
              //(ROMA_HSAndrea) si considera la disponibilità annua
              //(da deinire il comportamento in caso di autorizzazione, le ore non autorizzate dovrebbero comunque rimanere disponibili nei saldi successivi per future liquidazioni / recupero)
              T065OreEccedenti:=max(0,min(R450DtM1.salannoatt,R180SommaArray(R450DtM1.tstrannom)));
            end
          except
          end;
        end;
        T065OreEccedenti:=min(T065OreEccedenti,ResiduoLiquidabile);

        T065OreCausalizzate:=R450DtM1.IterAutStrOreCausalizzate;
        if T065OreCausalizzate <> 0 then
        begin
          T065Causale:=R450DtM1.IterAutStrCausale;
          //Se causale inclusa nelle ore normali:
          //- le ore causalizzate sono limitate dal totale dello straordinario
          //- le ore causalizzate vengono tolte dalle ore eccedenti.
          if VarToStr(Q275Riep.Lookup('CODICE',T065Causale,'ORENORMALI')) <> 'A' then
          begin
            T065OreCausalizzate:=min(T065OreEccedenti,T065OreCausalizzate);
            dec(T065OreEccedenti,T065OreCausalizzate);
          end;
        end;
    end
      else if R180CarattereDef(R450DtM1.IterAutorizzativoStr) in ['4'] then
      begin //Banca ore causalizzata (TORINO_CSI)
        if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
        begin
          //Le ore liquidabili/compensabili sono lo straordinario liquidabile delle settimane con saldo positivo
          T065OreEccedenti:=straordsett_mese;
          //Limito le ore a quelle autorizzate dai responsabili sulla T050 (AUTST)
          T065OreEccedenti:=min(T065OreEccedenti,GetT050AutStr(A027Progressivo,c_Data));
          //Considero la banca ore disponibile
          app:=R450DtM1.salannoatt;//R450DtM1.BancaOreResidua + R450DtM1.BancaOreResiduaPrec;
          //registro la quantità minima che si può indicare come da compensare:
          //sono le ore che non posso liquidare perchè in tal caso avrei una banca ore negativa
          MinOreDaCompensare:=max(0,T065OreEccedenti - app);
          MinOreDaCompensare:=min(MinOreDaCompensare,T065OreEccedenti);
          //registro la quantità minima che si può indicare come da liquidare:
          //è la parte di banca ore eccedente le 20 ore, limitata dalla quantità liqidabile nel mese
          MinOreDaLiquidare:=Max(0,R450DtM1.salannoatt - TO_CSI_MAX_BANCAORE);
          MinOreDaLiquidare:=Min(T065OreEccedenti,MinOreDaLiquidare);
        end;
      end;
      with T065P_REGISTRA_RICHIESTA do
      begin
        SetVariable('p_progressivo',A027Progressivo);
        SetVariable('p_data',c_Data);
        SetVariable('p_ore_eccedenti',T065OreEccedenti);
        SetVariable('p_min_ore_daliquidare',MinOreDaLiquidare);
        SetVariable('p_min_ore_dacompensare',MinOreDaCompensare);
        SetVariable('p_causale',T065Causale);
        SetVariable('p_ore_causalizzate',T065OreCausalizzate);
        try
          Execute;
          if GetVariable('p_id') <> null then
          begin
            RegistraLog.SettaProprieta('I','T065_RICHIESTESTRAORDINARI','A027',nil,True);
            RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(A027Progressivo));
            RegistraLog.InserisciDato('DATA','',DateTostr(c_Data));
            RegistraLog.InserisciDato('ID_CONGUAGLIO','',VarToStr(GetVariable('p_id')));
            RegistraLog.RegistraOperazione;
          end;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Registrazione iter autorizzativo del ' + DateToStr(c_Data) + ' fallita: ' + E.Message,'',A027Progressivo);
        end;
      end;
    end;
    ScriptAggSchedaAfter(A027Progressivo,c_Data);
    SessioneOracleR400.Commit;
  except
    {$IFNDEF IRISWEB}SessioneOracleR400.Rollback;     //IrisWIN
    {$ELSE}{$IFDEF WEBPJ}SessioneOracleR400.Rollback; //IrisCloud
           {$ELSE}SessioneOracleR400.Commit;          //IrisWEB
           {$ENDIF}
    {$ENDIF}
    raise;
  end;
end;

procedure TR400FCartellinoDtM.e025_totali;
{Calcolo totali per fascia}
var i:Integer;
begin
  if s_saltoggsaldi = 'si' then exit;
  //Calcolo totale eccedenze, lavorato e lavorato in turno per fascia
  for i:=1 to R450DtM1.NFasceMese do
    begin
    inc(totstrfascia[i],tStrGGFasMen[i]);
    inc(totminlavmes[i],tLavGGFasMen[i]);
    inc(tindturfasmes[i],tLavTurnoFasMen[i]);
    end;
  //Totale ore lavorate
  inc(RiepTotLav,R502ProDtM1.TotLav);
  inc(RiepScost,R502ProDtM1.Scost);
  inc(RiepScostNeg,R502ProDtM1.ScostNeg);
  inc(RiepFeNNG,R502ProDtM1.FestivoNonGoduto);
  if R502ProDtM1.Scost > 0 then
    inc(RiepScostPos,R502ProDtM1.Scost);
  inc(RiepCompGG,R502ProDtM1.EccSoloCompGG);
  inc(RiepCompNegGG,R502ProDtM1.EccSoloCompGG + R502ProDtM1.ScostNeg);
  inc(RiepMinLavEsc,R502ProDtM1.minlavesc);
  inc(RiepMinLavCau,R502ProDtM1.MinLavCau[Q950Int.FieldByName('CAUPRES').AsString]);
  inc(RiepMinLavCau2,R502ProDtM1.MinLavCau[Q950Int.FieldByName('CAUPRES2').AsString]);
  inc(RiepMinLavCau3,R502ProDtM1.MinLavCau[Q950Int.FieldByName('CAUPRES3').AsString]);
  inc(RiepEccedIterDisp,R502ProDtM1.EccedIterDisponibile);
  inc(RiepDebitoGG,R502ProDtM1.debitogg);
  inc(RiepDebitoGO,R502ProDtM1.debitodaorario);
  inc(RiepDebitoM,R502ProDtM1.debitocl);
  inc(RiepScostDebito,R502ProDtM1.scostamentodebito);
  inc(RiepOreLorde,R502ProDtM1.minpresenzelorde);
  inc(RiepProlInib,R502ProDtM1.ProlungamentoInibito['']);
  inc(RiepProlNonCaus,R502ProDtM1.ProlungamentoNonCausalizzato['']);
  inc(RiepProlENonCaus,R502ProDtM1.ProlungamentoNonCausalizzato['E']);
  inc(RiepProlUNonCaus,R502ProDtM1.ProlungamentoNonCausalizzato['U']);
  inc(RiepProlNonCont,R502ProDtM1.ProlungamentoInibito[''] + R502ProDtM1.ProlungamentoNonCausalizzato['']);
  inc(RiepProlNonCausUscita,R502ProDtM1.ProlungamentoNonCausUscita);
  inc(RiepPauMenDet,R502ProDtM1.paumendet);
  RiepIndPres:=RiepIndPres + R502ProDtM1.tindennitapresenza[1].tindpres + R502ProDtM1.tindennitapresenza[2].tindpres + R502ProDtM1.tindennitapresenza[3].tindpres;
  RiepIndFest:=RiepIndFest + R502ProDtM1.indfesint + (R502ProDtM1.indfesrid / 2);
  inc(RiepIndNot,R502ProDtM1.indnotmin);
  inc(RiepNumNot,R502ProDtM1.indnotgg);
  inc(RiepCoperturaCarenza,R502ProDtM1.CoperturaCarenza);
end;

procedure TR400FCartellinoDtM.e040_statotse(Data:TDateTime);
begin
  if (salsetatt > 0) and (salsetatt < minscostset_min) then
  begin
    inc(dimoreset,salsetatt);
    salsetatt:=0;
  end;
  TotSett[NumGiorniCartolina div 7].Data:=Data;
  TotSett[NumGiorniCartolina div 7].OreRese:=R180MinutiOre(totminset);
  TotSett[NumGiorniCartolina div 7].Debito:=R180MinutiOre(deborset);
  TotSett[NumGiorniCartolina div 7].Saldo:=R180MinutiOre(salsetatt);
  TotSett[NumGiorniCartolina div 7].Straord:=R180MinutiOre(straordsett);
end;

procedure TR400FCartellinoDtM.x022_totalizz;
{TOTALIZZAZIONI GIORNALIERE}
var i,j,xx,EccTot,T1,T2:Integer;
    straordgg:Integer;
begin
  //Cumulo le fasce restituite dai conteggi con quelle già esistenti
  //x025_CumuloFasce;  --> spostato in ...
  EccTot:=0;
  if s_saltoggsaldi = 'no' then
  begin
    //Registro giorni eccedenti per eventuale troncatura banca ore successiva
    if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and AbbattiBancaOre then
    begin
      straordgg:=R502ProDtM1.scost - R502ProDtM1.RiepAssenza[TO_CSI_REC_BANCAORE,'HHRESE'];// - R502ProDtM1.RiepAssenza[TO_CSI_REC_SETT,'HHRESE'];
      if straordgg > 0 then
      begin
        //R410FAutoGiustificazioneDtM.AddGGBancaOreEccedente(R502ProDtM1.datacon,straordgg,R502ProDtM1.tminstrgio);
        R410FAutoGiustificazioneDtM.AddGGBancaOreEccedente(R502ProDtM1,straordgg);
        R410FAutoGiustificazioneDtM.BancaOreTOCSI.GestioneSettimanale:=c03_tipocart = 'S';
      end;
    end;
    //gestione contatori per cartellino settimanale
    if c03_tipocart = 'S' then
    begin
      if R502ProDtM1.giorsett = 1 then
      //Inizializzazione debito e totale lavorato settimanale
      begin
        deborset:=0;
        totminset:=0;
        straordsett:=0;
      end;
      //TOTALIZZAZIONI SETTIMANALI
      //Debito e totale lavorato settimanale
      inc(deborset,R502ProDtM1.debitorp);
      inc(totminset,R502ProDtM1.totlav);
      //Totalizzazioni di fine settimana
      if R502ProDtM1.giorsett = 7 then
        salsetatt:=totminset - deborset;

      if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
      begin
        //TORINO_CSI: considero l'eccedenza liquidabile giornaliera
        straordgg:=Max(0,R180SommaArray(R502ProDtM1.tminstrgio) - R502ProDtM1.RiepAssenza[TO_CSI_REC_BANCAORE,'HHRESE']);
        inc(straordsett,straordgg);
        //TORINO_CSI: straordinario autorizzato. Per ogni settimana è limitato al saldo settimanale e arrotondato
        if (R502ProDtM1.giorsett = 7) and (salsetatt > 0)  then
        begin
          straordsett:=min(straordsett,salsetatt);
          //straordsett:=Trunc(R180Arrotonda(straordsett,R180OreMinutiExt(R502ProDtM1.ValStrT275[TO_CSI_STR_AUT,'ARROT_RIEPGG']),'D'));
          straordsett:=Trunc(R180Arrotonda(straordsett,TO_CSI_STR_AUT_Arrot,'D'));
          //if straordsett < StrToIntDef(R502ProDtM1.ValStrT275[TO_CSI_STR_AUT,'MINMINUTI'],0) then
          if straordsett < TO_CSI_STR_AUT_Min then
            straordsett:=0;
          inc(straordsett_mese,straordsett);
          if AbbattiBancaOre then
            R410FAutoGiustificazioneDtM.AddSettBancaOreEccedente(R502ProDtM1.DataCon - 6,salsetatt,straordsett);
          //salvataggio dati settimanali su T102 per TORINO_CSI
          if straordsett > 0 then
            InsertT102(A027Progressivo,DataDa,R502ProDtM1.DataCon - 6,T102STRAOSETTIMANALE,straordsett.ToString,TO_CSI_STR_AUT);
        end;
      end;
    end;
  end;
  if s_saltoggsaldi = 'no' then
  begin
    if R502ProDtM1.lstAnomalieGG.Count > 0 then
      lstAnomalieMM.AddRange(R502ProDtM1.lstAnomalieGG);
    //TOTALIZZAZIONI MENSILI PER SALDI
    //Debito orario e plus orario mese
    inc(R450DtM1.debormes,R502ProDtM1.debitorp);
    inc(R450DtM1.debggtot,R502ProDtM1.debitogg);
    inc(R450DtM1.debpomes,R502ProDtM1.debitopo);
    R450DtM1.debpo_percptmes:=R450DtM1.debpo_percptmes + R502ProDtM1.debitopo_percpt;
    //Scostamento mensile
    inc(R450DtM1.scostmes,R502ProDtM1.scost);
    //Numero di giorni in servizio
    inc(ngginser,R502ProDtM1.gginser);
    //Numero di giorni lavorativi in servizio
    inc(ngglavser,R502ProDtM1.gglavser);
    //Numero di giorni lavorativi da calendario
    if (R502ProDtM1.gglavcal = 'si') and (R502ProDtM1.dipinser = 'si') then
      inc(ngglavcal);
    //Nando 07/11/2003 inizio
    //Numero delle domeniche del mese in cui il dipendente risulta in servizio
    if (R502ProDtM1.dipinser = 'si') and (R502ProDtM1.giorsett = 7) then
    begin
      inc(NDomenicheServizio);
      DomenicheServizio[NDomenicheServizio]:=R502ProDtM1.datacon;
    end;
    //Nando 07/11/2003 fine
    //Numero di detrazioni di debito plus orario causa assenze
    inc(nggdetrpo,R502ProDtM1.detrdebitopo);
    //Eccedenza solo compensabile derivata dalla giornaliera
    inc(R450DtM1.eccsolocompmes,R502ProDtM1.eccsolocompGG);
    inc(R450DtM1.EccSoloCompMesOltreSoglia,R502ProDtM1.EccSoloCompOltreSoglia);
    //Scostamento in fascia di elasticita'
    inc(R450DtM1.scostfasciames,R502ProDtM1.scostfascia);
    //Minuti conteggiati da assenze
    inc(R450DtM1.minassenzemes,R502ProDtM1.minassenze);
    //Minuti di variazione alla eccedenza per liquidazione
    dec(R450DtM1.vareccliqmes,R502ProDtM1.minabbstr + R502ProDtM1.CarenzaObbNoLiq);
    //Eventuale scostamento negativo
    inc(R450DtM1.scostnegmes,R502ProDtM1.scostneg);
    //ASTI_ASL: negativo utile alla compensazione entro la soglia
    if //R450DtM1.XParam[XP_R450_NEGATIVI_COMPENSABILI] and
       R502ProDtM1.XParam[XP_Z750_COMP_UNONCAUS] and
       (R502ProDtM1.ValNumT020['MinScoStr'] > 0) and (R502ProDtM1.scostneg < 0) then
      inc(R450DtM1.compnegmes,-1 * min(abs(R502ProDtM1.scostneg),R502ProDtM1.ValNumT020['MinScoStr'] - 1));
    //Riposi compensativi da turnazione
    inc(R450DtM1.ripcommes,R502ProDtM1.ripcom);
    //Abbattimento anno precedente, attuale, riposi compensativi, banca ore
    inc(R450DtM1.abbannoprecmes,R502ProDtM1.abbannoprec);
    inc(R450DtM1.abbannoattmes,R502ProDtM1.abbannoatt);
    inc(R450DtM1.abbliqannoprecmes,R502ProDtM1.abbliqannoprec);
    inc(R450DtM1.abbliqannoattmes,R502ProDtM1.abbliqannoatt);
    inc(R450DtM1.abbripcommes,R502ProDtM1.abbripcom);
    inc(R450DtM1.OreCompRecuperate,R502ProDtM1.abbBancaOre);
    inc(RiepPresenzaObbligatoria,R502ProDtM1.PresenzaObbligatoria);
    inc(RiepPresenzaFacoltativa,R502ProDtM1.PresenzaFacoltativa);
    inc(RiepCarenzaObbligatoria,R502ProDtM1.CarenzaObbligatoria);
    inc(RiepCarenzaFacoltativa,R502ProDtM1.CarenzaFacoltativa);
    inc(RiepScostFacoltativa,R502ProDtM1.ScostFacoltativa);
    //Lavorato mensile e tipi di straordinario potenzialmente liquidabile
    for xx:=1 to MaxFasce do
    begin
      tStrGGFasMen[xx]:=0;
      tLavGGFasMen[xx]:=0;
      tLavTurnoFasMen[xx]:=0;
    end;
    //Assegno la fascia giornaliera alla fascia mensile
    for i:=1 to R502ProDtM1.n_fasce do
    begin
      j:=R502ProDtM1.tfasceorarie[i].tposfasc;
      if j > 0 then
      begin
        inc(tStrGGFasMen[j],R502ProDtM1.tminstrgio[i]);
        inc(EccTot,R502ProDtM1.tminstrgio[i]);
        inc(tLavGGFasMen[j],R502ProDtM1.tminlav[i]);
        inc(R450DtM1.tminlavmes[j],R502ProDtM1.tminlav[i]);
        inc(R450DtM1.tminstrmen[j],R502ProDtM1.tminstrgio[i]);
      end;
      //Alberto 20/09/2018 - CCNL 2018: le fasce delle indennità di turno possono essere diverse nei pre/post-festivi
      j:=R502ProDtM1.tfasceorarie_indturno[i].tposfasc;
      if j > 0 then
      begin
        inc(tLavTurnoFasMen[j],R502ProDtM1.tindturfas[i]);
        inc(R450DtM1.tmininturno[j],R502ProDtM1.tindturfas[i]);
      end;
    end;
    if (R502ProDtM1.giorsett = 7) and (R502ProDtM1.indfesint = 0) and (R502ProDtM1.indfesint = 0) then
    begin
      inc(NDomeniche);
      DomenicheLavorate[NDomeniche].Data:=R502ProDtM1.datacon;
      DomenicheLavorate[NDomeniche].Eccedenza:=EccTot;
      DomenicheLavorate[NDomeniche].Posizione:=Riga;
      DomenicheLavorate[NDomeniche].IndFes:=R502ProDtm1.minlavfes;
    end;
    //Alberto 23/02/2006
    selT820.Filtered:=True;
    if (selT820.RecordCount > 0) and (EccTot > 0) then
      x110_RegistraStrGGdelMese;
  end;
  if s_saltoggistit = 'no' then
  //TOTALIZZAZIONI MENSILI PER ISTITUTI
  //Numero di giorni di presenza
  begin
    if R180SommaArray(R502ProDtM1.tminstrgio) - R502ProDtM1.RiepAssenza[TO_CSI_REC_BANCAORE,'HHRESE'] > 0 then
      InsertT102(A027Progressivo,DataDa,R502ProDtM1.DataCon,T102STRAOGG,(R180SommaArray(R502ProDtM1.tminstrgio) - R502ProDtM1.RiepAssenza[TO_CSI_REC_BANCAORE,'HHRESE']).ToString);
    inc(nggpres,R502ProDtM1.ggpres);
    //Numero di giorni di presenza pomeridiana
    inc(nggpomer,R502ProDtM1.ggpomer);
    //Indennita' festive e di turno
    fesintmesT:=fesintmesT + R502ProDtM1.indfesint;
    fesridmesT:=fesridmesT + R502ProDtM1.indfesrid;
    inc(notggmes,R502ProDtM1.indnotgg);
    inc(notminmes,R502ProDtM1.indnotmin);
    //Indennità festive e di turno giornaliere per ricalcolo mensile
    indnot_giorno[NGIndNotFes]:=R502ProDtM1.indnot_lorda;
    if R502ProDtM1.indfes_lorda.Debito = 0 then
      R502ProDtM1.indfes_lorda.Ore:=0;
    indfes_giorno[NGIndNotFes]:=R502ProDtM1.indfes_lorda;
    for xx:=1 to 4 do
    begin
      indnot_giorno[NGIndNotFes].EccGio[xx]:=0;
      indfes_giorno[NGIndNotFes].EccGio[xx]:=0;
    end;
    for i:=1 to R502ProDtM1.n_fasce do
    begin
      j:=R502ProDtM1.tfasceorarie[i].tposfasc;
      if j > 0 then
      begin
        inc(indnot_giorno[NGIndNotFes].EccGio[j],R502ProDtM1.indnot_lorda.EccGio[i]);
        inc(indfes_giorno[NGIndNotFes].EccGio[j],R502ProDtM1.indfes_lorda.EccGio[i]);
      end;
    end;
    //Turni fatti: si tiene conto della gestione turni pianificati su T081 (pianificazione Non Operativa per Torino_Comune)
    T1:=0;
    T2:=0;
    if R502ProDtM1.TurnoProvv1 in [1..4] then
      T1:=R502ProDtM1.TurnoProvv1
    else if R502ProDtM1.n_turno1 in [1..4] then
      T1:=R502ProDtM1.n_turno1;
    if R502ProDtM1.TurnoProvv2 in [1..4] then
      T2:=R502ProDtM1.TurnoProvv2
    else if R502ProDtM1.n_turno2 in [1..4] then
      T2:=R502ProDtM1.n_turno2;
    if T1 in [1..4] then
      inc(trpturfmes[T1]);
    if T2 in [1..4] then
      inc(trpturfmes[T2]);
    if max(0,T1) > 0 then
    begin
      trpturgg1[NGIndPres - 3]:=max(0,T1);
      trpturgg2[NGIndPres - 3]:=max(0,T2);
    end
    else
      trpturgg1[NGIndPres - 3]:=max(0,T2);
    //Giorni vuoti
    inc(nggvuoti,R502ProDtM1.ggvuoto);
    //Giorni di presenza
    inc(nggpresenza,R502ProDtM1.ggpresenza);
    //Riposi non fruiti
    inc(nggFestiviNonGoduti,R502ProDtM1.FestivoNonGoduto);
    //Rientri pomeridiani
    inc(RientriPomeridiani.ResiObbligatori,R502ProDtM1.RientroPomeridiano.Obbl);
    inc(RientriPomeridiani.ResiSupplementari,R502ProDtM1.RientroPomeridiano.Suppl);
    //TOTALIZZAZIONI PRESENZE
    for i:=1 to R502ProDtM1.n_rieppres do
      x120_rppresenze(i);
    //TOTALIZZAZIONI ASSENZE
    for i:=1 to R502ProDtM1.n_riepasse do
      x130_rpassenze(i);
    OreInailMes:=OreInailMes + x150_OreInail;
    //TOTALIZZAZIONI PRESENZE IN FASE A BLOCCHI (AMGAS Bari)
    for i:=0 to High(R502ProDtM1.FascePaghe276) do
    begin
      if R502ProDtM1.FascePaghe276[i].VocePaghe = '' then Break;
      for j:=0 to High(FascePaghe276Tot) do
        if FascePaghe276Tot[j].VocePaghe = '' then
        begin
          FascePaghe276Tot[j].VocePaghe:=R502ProDtM1.FascePaghe276[i].VocePaghe;
          FascePaghe276Tot[j].Ore:=R502ProDtM1.FascePaghe276[i].Ore;
          Break;
        end
        else if FascePaghe276Tot[j].VocePaghe = R502ProDtM1.FascePaghe276[i].VocePaghe then
        begin
          inc(FascePaghe276Tot[j].Ore,R502ProDtM1.FascePaghe276[i].Ore);
          Break;
        end;
      end;
    //Totalizzazione gettoni
    for i:=0 to High(R502ProDtM1.Gettoni) do
    begin
      if (VarToStr(Q275Riep.Lookup('CODICE',R502ProDtM1.Gettoni[i].Causale,'GETTONE_INDENNITA')) = '') or
         (R180OreMinutiExt(VarToStr(Q275Riep.Lookup('CODICE',R502ProDtM1.Gettoni[i].Causale,'GETTONE_ORE'))) = 0) then
        Continue;
      if IndennitaEsclusaT164(A027Progressivo,R502ProDtM1.datacon,VarToStr(Q275Riep.Lookup('CODICE',R502ProDtM1.Gettoni[i].Causale,'GETTONE_INDENNITA'))) then
        Continue;
      xx:=-1;
      for j:=0 to High(RiepGettoni) do
        if R502ProDtM1.Gettoni[i].Causale = RiepGettoni[j].Causale then
        begin
          xx:=j;
          Break;
        end;
      if xx = -1 then
      begin
        SetLength(RiepGettoni,Length(RiepGettoni) + 1);
        xx:=High(RiepGettoni);
        RiepGettoni[xx].Causale:=R502ProDtM1.Gettoni[i].Causale;
        RiepGettoni[xx].Indennita:=VarToStr(Q275Riep.Lookup('CODICE',R502ProDtM1.Gettoni[i].Causale,'GETTONE_INDENNITA'));
        RiepGettoni[xx].Spezzoni:=VarToStr(Q275Riep.Lookup('CODICE',R502ProDtM1.Gettoni[i].Causale,'GETTONE_SPEZZONI')) = 'S';
        RiepGettoni[xx].OreGettone:=R180OreMinutiExt(VarToStr(Q275Riep.Lookup('CODICE',R502ProDtM1.Gettoni[i].Causale,'GETTONE_ORE')));
        RiepGettoni[xx].Minuti:=0;
        RiepGettoni[xx].Gettoni:=0;
        RiepGettoni[xx].Resto:=0;
      end;
      inc(RiepGettoni[xx].Minuti,R502ProDtM1.Gettoni[i].Minuti);
    end;
  end;
end;

function TR400FCartellinoDtM.IndennitaEsclusaT164(P:Integer; D:TDateTime; Ind:String):Boolean;
{Verifico se l'indennità maturata come indicata(maturata dal gettone) è da eslcudersi per via delle abilitazioni specificate sulla T164}
var IndEsc,DatoPianificabile:String;
begin
  Result:=False;
  if (selT164.FieldByName('DECORRENZA').AsDateTime > D) or
     (selT164.FieldByName('SCADENZA').AsDateTime < D) then
    exit;
  with GetIndennita_T164 do
  begin
    ClearVariables;
    SetVariable('PROG_IN',P);
    SetVariable('DATA_IN',D);
    //Verificare chiamata in reperibilita
    SetVariable('REPERIBILE','N');
    //Lettura del valore pianificato: C3_DatoPianificabile è già contenuto in C3_IndPres o C3_IndPres2
    SetVariable('DATOLIBERO',Parametri.CampiRiferimento.C3_DatoPianificabile);
    if (Parametri.CampiRiferimento.C3_DatoPianificabile <> '') then
    begin
      DatoPianificabile:=VarToStr(R502ProDtM1.Q080.Lookup('Data',D,'DatoLibero'));
      if DatoPianificabile = '' then
        if QSDatiAnagrafici.LocDatoStorico(D) then
          DatoPianificabile:=QSDatiAnagrafici.FieldByName('T430' + Parametri.CampiRiferimento.C3_DatoPianificabile).AsString;
      SetVariable('VALORE',DatoPianificabile);
    end;
    try
      Execute;
      IndEsc:=VarToStr(GetVariable('IND_ESC'));
    except
      IndEsc:='';
    end;
    if IndEsc <> '' then
      with TStringList.Create do
      try
        CommaText:=IndEsc;
        Result:=IndexOf(Ind) >= 0;
      finally
        Free;
      end;
  end;
end;

procedure TR400FCartellinoDtM.x300_impdatifasc(Data:TDateTime; FM:Integer);
{Registrazione dati in fasce su T071}
begin
  with Ins071 do
    begin
    SetVariable('Progressivo',A027Progressivo);
    SetVariable('Data',Data);
    SetVariable('Maggiorazione',FasceMese[FM].Maggiorazione);
    SetVariable('CodFascia',FasceMese[FM].Codice);
    SetVariable('OreLavorate',R180MinutiOre(R450DtM1.tminlavmes[FM]));
    SetVariable('Ore1Assest',R180MinutiOre(R450DtM1.tdatiassestamen[1].tminassest[FM]));
    SetVariable('Ore2Assest',R180MinutiOre(R450DtM1.tdatiassestamen[2].tminassest[FM]));
    SetVariable('OreIndTurno',R180MinutiOre(tindturfasmes[FM]));
    SetVariable('OreEccedGiorn',R180MinutiOre(R450DtM1.tminstrmen_ori[FM]));
    SetVariable('OreStraordLiq',R180MinutiOre(R450DtM1.tstrliqmm[FM]));
    SetVariable('LiquidNelMese',R180MinutiOre(R450DtM1.tLiqNelMese[FM]));
    SetVariable('Banca_Ore',R180MinutiOre(R450DtM1.tbancaore[FM]));
    Execute;
    end;
end;

procedure TR400FCartellinoDtM.x048_aggcaupre(Data:TDateTime; CP:Integer);
{Aggiornamento causali di presenza}
var i:Integer;
    Registra:Boolean;
begin
  Registra:=R450DtM1.RiepPres[CP].CompensabileMese > 0;
  if not Registra then
    for i:=1 to MaxFasce do
      if (R450DtM1.RiepPres[CP].OreReseMese[i] > 0) or (R450DtM1.RiepPres[CP].LiquidatoMese[i] > 0) then
      begin
        Registra:=True;
        Break;
      end;
  if not Registra then exit;
  try
    //Impostazione record causali presenza
    with Ins073 do
    begin
      ClearVariables;
      SetVariable('Progressivo',A027Progressivo);
      SetVariable('Data',Data);
      SetVariable('Causale',R450DtM1.RiepPres[CP].Causale);
      SetVariable('Compensabile',R180MinutiOre(R450DtM1.RiepPres[CP].CompensabileMese));
      for i:=0 to High(RiepGettoni) do
        if (RiepGettoni[i].Causale = R450DtM1.RiepPres[CP].Causale) and (RiepGettoni[i].Resto > 0) then
        begin
          SetVariable('Gettone_Residuo',R180MinutiOre(RiepGettoni[i].Resto));
          Break;
        end;
      Execute;
    end;
    with Ins074 do
    begin
      SetVariable('Progressivo',A027Progressivo);
      SetVariable('Data',Data);
      SetVariable('Causale',R450DtM1.RiepPres[CP].Causale);
      for i:=1 to R450DtM1.NFasceMese do
      begin
        SetVariable('Maggiorazione',FasceMese[i].Maggiorazione);
        SetVariable('CodFascia',FasceMese[i].Codice);
        SetVariable('OrePresenza',R180MinutiOre(R450DtM1.RiepPres[CP].OreReseMese[i]));
        SetVariable('Liquidato',R180MinutiOre(R450DtM1.RiepPres[CP].LiquidatoMese[i]));
        Execute;
      end;
    end;
    if R450DtM1.RiepPres[CP].CompensabileMeseEff > 0 then
      SalvaCompensabileMeseEff(R450DtM1.RiepPres[CP].Causale, R450DtM1.RiepPres[CP].CompensabileMeseEff);
  except
    on E: Exception do
    begin
      RegistraMsg.InserisciMessaggio('A',Format('Anomalia nella registrazione del riepilogo causale di presenza %s (%s): %s',[R450DtM1.RiepPres[CP].Causale,DateToStr(Data),E.Message]),'',A027Progressivo);
    end;
  end;
end;

procedure TR400FCartellinoDtM.x058_aggindpre(Data:TDateTime; IP:Integer);
{Aggiornamento indennita' di presenza}
var EquilibrioPluriMensile:Boolean;
begin
  //Impostazione record indennita' di presenza
  EquilibrioPluriMensile:=False;
  if selT162.SearchRecord('CODICE',trpindpmes[IP].tcodindpmes,[srFromBeginning]) then
  begin
    EquilibrioPluriMensile:=R180In(selT162.FieldByName('TIPO').AsString,['P']) and
                            (selT162.FieldByName('NMESI_EQUITURNI').AsInteger > 1) and
                            (selT162.FindField('CONGUAGLIO_EQUITURNI') <> nil) and
                            (selT162.FieldByName('CONGUAGLIO_EQUITURNI').AsString = 'S');
  end;

  if not EquilibrioPluriMensile then
  begin
    //Tabella delle inndennità effettive
    with Ins072 do
    begin
      SetVariable('Progressivo',A027Progressivo);
      SetVariable('Data',Data);
      SetVariable('CodIndPres',trpindpmes[IP].tcodindpmes);
      SetVariable('IndPres',FormatFloat('##.#',trpindpmes[IP].tggindpmes).Replace('.',','));
      SetVariable('IndSupp_Resto',FormatFloat('#.###',trpindpmes[IP].RestoIndSup).Replace('.',','));
      Execute;
    end;
  end
  else
  begin
    //Tabella delle indennità da conguagliare su periodo plurimensile tramite il pl/sql
    with insT172 do
    begin
      SetVariable('Progressivo',A027Progressivo);
      SetVariable('Data',Data);
      SetVariable('CodIndPres',trpindpmes[IP].tcodindpmes);
      SetVariable('IndPres',FormatFloat('##.#',trpindpmes[IP].tggindpmes).Replace('.',','));
      Execute;
    end;
  end;
end;

procedure TR400FCartellinoDtM.x025_CumuloFasce;
{Leggo le fasce contenute in tfasceorarie e le inserisco in FasceMese
se non esistono ancora}
var i,j:Integer;
begin
  for i:=1 to R502ProDtM1.n_fasce do
  begin
    R502ProDtM1.tfasceorarie[i].tposfasc:=0;
    for j:=1 to R450DtM1.NFasceMese do
      if R502ProDtM1.tfasceorarie[i].tcodfasc = FasceMese[j].Codice then
      begin
        R502ProDtM1.tfasceorarie[i].tposfasc:=j;
        Break;
      end;
    //Se non trovo la fascia per codice, la cerco per fascia di maggiorazione (TORINO_ZOOPROFILATTICO)
    if R502ProDtM1.tfasceorarie[i].tposfasc = 0 then
    begin
      for j:=1 to R450DtM1.NFasceMese do
        if R502ProDtM1.tfasceorarie[i].tpercfasc = FasceMese[j].Maggiorazione then
        begin
          R502ProDtM1.tfasceorarie[i].tposfasc:=j;
          Break;
        end;
    end;
  end;

  //Alberto 20/09/2019 - CCNL2018: ripeto la'associazione delle fasce anche per quelle dell'ind.turno
  for i:=1 to R502ProDtM1.n_fasce do
  begin
    R502ProDtM1.tfasceorarie_indturno[i].tposfasc:=0;
    for j:=1 to R450DtM1.NFasceMese do
      if R502ProDtM1.tfasceorarie_indturno[i].tcodfasc = FasceMese[j].Codice then
      begin
        R502ProDtM1.tfasceorarie_indturno[i].tposfasc:=j;
        Break;
      end;
    //Se non trovo la fascia per codice, la cerco per fascia di maggiorazione (TORINO_ZOOPROFILATTICO)
    if R502ProDtM1.tfasceorarie_indturno[i].tposfasc = 0 then
    begin
      for j:=1 to R450DtM1.NFasceMese do
        if R502ProDtM1.tfasceorarie_indturno[i].tpercfasc = FasceMese[j].Maggiorazione then
        begin
          R502ProDtM1.tfasceorarie_indturno[i].tposfasc:=j;
          Break;
        end;
    end;
  end;
end;

procedure TR400FCartellinoDtM.x110_RegistraStrGGdelMese;
{Caricamento del riepilogo mensile della causale di presenza indicata sui limiti mensili}
var i,j,k,Eccedenza:Integer;
    strgio:t_FasceInteri;
begin
  with R502ProDtM1 do
  begin
    for i:=1 to n_fasce do
      strgio[i]:=tminstrgio[i];
    (*Alberto 30/03/2006: non si decurta l'ecedenza giornaliera per nessu motivo
    //Tolgo dall'eccedenza le eventuali causali significative incluse nelle normali
    for i:=1 to n_rieppres do
    begin
      if (triepgiuspres[i].tcauspres = '') or
         (ValStrT275[triepgiuspres[i].tcauspres,'TIPOCONTEGGIO'] = 'A') or
         (ValStrT275[triepgiuspres[i].tcauspres,'TIPOCONTEGGIO'] = 'E') or
         (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI']  = 'A') then
        Continue;
      for j:=1 to n_fasce do
      begin
        app:=Min(triepgiuspres[i].tminpres[j],strgio[j]);
        dec(strgio[j],app);
      end;
    end;
    *)
    Eccedenza:=0;
    for i:=1 to n_fasce do
      inc(Eccedenza,strgio[i]);
  end;
  if Eccedenza <= 0 then
    exit;
  i:=Length(StrGGdelMese);
  SetLength(StrGGdelMese,i + 1);
  StrGGdelMese[i].Giorno:=R180Giorno(R502ProDtM1.datacon);
  for j:=1 to High(StrGGdelMese[i].Str) do
    StrGGdelMese[i].Str[j]:=0;
  for j:=1 to R502ProDtM1.n_fasce do
  begin
    k:=R502ProDtM1.tfasceorarie[j].tposfasc;
    if k > 0 then
      inc(StrGGdelMese[i].Str[k],strgio[j]);
  end;
end;

procedure TR400FCartellinoDtM.x120_rppresenze(PG:Integer);
{Totalizzazioni presenze}
var i,j,xx,PM:Integer;
    RipFasce:Boolean;
begin
  //salvataggio dati giornalieri su T102 per TORINO_CSI, anche con causale nulla
  with R502ProDtM1.triepgiuspres[PG] do
    if R180SommaArray(tminpres) > 0 then
    begin
      for i:=0 to High(CoppiaEU) do
        InsertT102(A027Progressivo,DataDa,R502ProDtM1.DataCon,T102RIEPPRES_EU,'',tcauspres,CoppiaEU[i].E.ToString,CoppiaEU[i].U.ToString);
    end;

  if not Q275Riep.Locate('Codice',R502ProDtM1.triepgiuspres[PG].tcauspres,[]) then exit;
  RipFasce:=R502ProDtM1.ValStrT275[R502ProDtM1.triepgiuspres[PG].tcauspres,'RIPFASCE'] = 'B';
  PM:=0;
  repeat
    inc(PM);
  until (PM > n_rppresmes) or (trppresmes[PM].tcspresmes = R502ProDtM1.triepgiuspres[PG].tcauspres);
  if PM > n_rppresmes then
  begin
    if n_rppresmes >= MAX_RPMES then
      exit;
    inc(n_rppresmes);
    PM:=n_rppresmes;
    trppresmes[PM].tcspresmes:=R502ProDtM1.triepgiuspres[PG].tcauspres;
    trppresmes[PM].tdescpresmes:=Q275Riep.FieldByName('Descrizione').AsString;
    trppresmes[PM].tsiglapresmes:=Q275Riep.FieldByName('Sigla').AsString;
    for xx:=1 to MaxFasce do trppresmes[PM].tminpresmes[xx]:=0;
  end;
  for i:=1 to R502ProDtM1.n_fasce do
  begin
    if RipFasce then //Alberto 31/08/2010: Gestione della causale NON ripartita in fasce - sempre in 1° fascia
      j:=R502ProDtM1.tfasceorarie[i].tposfasc
    else
      j:=1;
    if j > 0 then
      inc(trppresmes[PM].tminpresmes[j],R502ProDtM1.triepgiuspres[PG].tminpres[i]);
  end;
end;

procedure TR400FCartellinoDtM.x130_rpassenze(AG:Integer);
{Totalizzazioni assenze}
var i,AM:Integer;
    S:String;
    quo130:Byte;
begin
  //Includo tutte le assenze, anche quelle non richieste nel riepilogo
  i:=0;
  for AM:=1 to n_rpassemes do
     if  (trpassemes[AM].tcsassemes = R502ProDtM1.triepgiusasse[AG].tcausasse) then
     begin
       i:=AM;
       Break;
     end;
  if i = 0 then
  begin
    if n_rpassemes >= MAX_RPMES then
      exit;
    inc(n_rpassemes);
    AM:=n_rpassemes;
    with trpassemes[AM] do
    begin
      tcsassemes:=R502ProDtM1.triepgiusasse[AG].tcausasse;
      S:=VarToStr(Q265Riep.Lookup('Codice',tcsassemes,'Stampa'));
      if (S = 'A') or (S = 'C') then
        tdescassemes:=VarToStr(Q265Riep.LookUp('Codice',tcsassemes,'Descrizione'))
      else
        tdescassemes:='$$$';  //Segno le assenze che non sono richieste nel riepilogo
      tggassemes:=0;
      tmgassemes:=0;
      tminassemes:=0;
      tminvalassemes:=0;
      tmintotassemes:=0; 
      tfnretrmes:=R502ProDtM1.triepgiusasse[AG].tfiniretr;
      tCompetenze:=Q265Comp.Locate('Codice',tcsassemes,[]);
      tCalcolato:=False;
    end;
  end;
  with trpassemes[AM],R502ProDtM1.triepgiusasse[AG] do
  begin
    inc(tminassemes,tminasse);
    inc(tminvalassemes,tminvalasse);
    inc(tmintotassemes,Max(Max(tminasse,tminresasse),tminvalasse));
    //Registrazione minuti da assenza per recupero festività (S.Giovanni)
    if Q265Fest.Locate('Codice',tcausasse,[]) then
    begin
      inc(NRecuperiFestivi);
      if NRecuperiFestivi > High(RecuperiFestivi) then
        NRecuperiFestivi:=1;
      inc(RecuperiFestivi[NRecuperiFestivi],tminvalasse);
    end;
    if thhmmasse > 0 then
      //Conversione hh.mm per giorno assenza in minuti
    begin
      thhmmasse:=thhmmasse div 2;
      //Totalizzazione e conversione mm assenza in mezze giornate
      try
        quo130:=tminassemes div thhmmasse;
      except
        quo130:=0;
      end;
      tminassemes:=tminassemes mod thhmmasse;
      inc(tmgassemes,quo130);
    end;
    inc(tggassemes,tggasse);
    inc(tmgassemes,tmezggasse);
    quo130:=tmgassemes div 2;
    tmgassemes:=tmgassemes mod 2;
    inc(tggassemes,quo130);
  end;
end;

procedure TR400FCartellinoDtM.x140_rpindpres(RiepilogoMensile:Boolean);
{Riepilogo indennita' di presenza}
var C1,C2,Reperibile:String;
    i:Integer;
    j:Byte;
    Somma:Boolean;
  function GetProfiloIndennita(D:TDateTime):String;
  {Lettura del profilo indennità corrispondente}
  var K1,K2:String;
  begin
    C1:=Parametri.CampiRiferimento.C3_IndPres;
    C2:=Parametri.CampiRiferimento.C3_IndPres2;
    Result:='';
    Result:=VarToStr(R502ProDtM1.Q080.Lookup('Data',D,'IndPresenza'));
    if Result = '' then
      if QSDatiAnagrafici.LocDatoStorico(D) then
        if QSDatiAnagrafici.FieldByName('T430IPRESENZA').AsString <> '' then
          Result:=QSDatiAnagrafici.FieldByName('T430IPRESENZA').AsString
        else if C1 <> '' then
        begin
          K1:='';
          if Parametri.CampiRiferimento.C3_DatoPianificabile = C1 then
            K1:=VarToStr(R502ProDtM1.Q080.Lookup('Data',D,'DatoLibero'));
          if K1 = '' then
            K1:=QSDatiAnagrafici.FieldByName('T430' + C1).AsString;
          with Q161 do
          begin
            if SearchRecord('Codice;Codice2',VarArrayOf([K1,'*']),[srFromEnd]) then
            begin
              while FieldByName('Decorrenza').AsDateTime > D do
                if not SearchRecord('Codice;Codice2',VarArrayOf([K1,'*']),[srBackward]) then
                  Break;
              if FieldByName('Decorrenza').AsDateTime <= D then
                Result:=FieldByName('Indennita').AsString;
            end;
            if (C2 <> C1) and (C2 <> '') then
            begin
              K2:='';
              if Parametri.CampiRiferimento.C3_DatoPianificabile = C2 then
                K2:=VarToStr(R502ProDtM1.Q080.Lookup('Data',D,'DatoLibero'));
              if K2 = '' then
                K2:=QSDatiAnagrafici.FieldByName('T430' + C2).AsString;
              if SearchRecord('Codice;Codice2',VarArrayOf([K1,K2]),[srFromEnd]) then
              begin
                while FieldByName('Decorrenza').AsDateTime > D do
                  if not SearchRecord('Codice;Codice2',VarArrayOf([K1,K2]),[srBackward]) then
                    Break;
              if FieldByName('Decorrenza').AsDateTime <= D then
                Result:=FieldByName('Indennita').AsString;
              end;
            end;
          end;
        end;
  end;
  function GetIndennitaDirette(D:TDateTime):String;
  {Lettura delle indennità associate direttamente}
  var DatoPianificabile,IndStd,IndRep,IndEsc:String;
      p,i:Integer;
  begin
    Result:='';
    if (selT164.FieldByName('DECORRENZA').AsDateTime > D) or
       (selT164.FieldByName('SCADENZA').AsDateTime < D) then
      exit;
    with GetIndennita_T164 do
    begin
      ClearVariables;
      SetVariable('PROG_IN',A027Progressivo);
      SetVariable('DATA_IN',D);
      //Verificare chiamata in reperibilita
      SetVariable('REPERIBILE',Reperibile);
      //Lettura del valore pianificato: C3_DatoPianiaficabile è già contenuto in C3_IndPres o C3_IndPres2
      SetVariable('DATOLIBERO',Parametri.CampiRiferimento.C3_DatoPianificabile);
      if (Parametri.CampiRiferimento.C3_DatoPianificabile <> '') then
      begin
        DatoPianificabile:=VarToStr(R502ProDtM1.Q080.Lookup('Data',D,'DatoLibero'));
        if DatoPianificabile = '' then
          if QSDatiAnagrafici.LocDatoStorico(D) then
            DatoPianificabile:=QSDatiAnagrafici.FieldByName('T430' + Parametri.CampiRiferimento.C3_DatoPianificabile).AsString;
        SetVariable('VALORE',DatoPianificabile);
      end;
      try
        Execute;
        IndStd:=VarToStr(GetVariable('IND_STD'));
        IndRep:=VarToStr(GetVariable('IND_REP'));
        IndEsc:=VarToStr(GetVariable('IND_ESC'));
      except
        IndStd:='';
        IndRep:='';
        IndEsc:='';
      end;
      if IndRep <> '' then
        Result:=IndRep
      else
        Result:=IndStd;
      if IndEsc <> '' then
        with TStringList.Create do
        try
          CommaText:=IndEsc;
          for i:=0 to Count - 1 do
          begin
            p:=lstIndennitaSpettanti.IndexOf(Strings[i]);
            if p >= 0 then
              lstIndennitaSpettanti.Delete(p);
          end;
        finally
          Free;
        end;
    end;
  end;
  function GetOreInReperibilita:String;
  var x,y,H,Turni:Integer;
  begin
    Result:='N';
    with R502ProDtM1 do
    begin
      Turni:=0;
      for x:=Low(CodTurniReperibilita) to High(CodTurniReperibilita) do
        if CodTurniReperibilita[x].Tipo = 'C' then
          inc(Turni,CodTurniReperibilita[x].Turno1.Durata + CodTurniReperibilita[x].Turno2.Durata);
      if Turni = 0 then
        exit;
      H:=0;
      for x:=1 to n_rieppres do
        if triepgiuspres[x].traggpres = traggrcauspr[3].c then
        begin
          for y:=1 to MaxFasceGio do
            inc(H,triepgiuspres[x].tminpres[y]);
          if (not NotteSuEntrata) and (ultimt_e = 'si') and
             (estimbsucc = 'si') and (verso_suc = 'U') and
             (caus_suc = triepgiuspres[x].tcauspres) and
             (caus_suc = ttimbraturedip[n_timbrdip].tcausale_u.tcaus) then
            inc(H,minuti_suc);
        end;
    end;
    if H >= (Turni div 2) then
      Result:='S';
  end;
  procedure IndennitaSpettanti(D:TDateTime);
  {lstIndennitaSpettanti contiene l'elenco delle indennità maturate dal dipendente,
   verificando la compatibilità tra indennità diverse}
  var ProfInd:String;
      x,p:Integer;
  begin
    lstIndennitaSpettanti.Clear;
    //Indennità associata al profilo indennità da anagrafico, pianificazione giornaliera o associazioni di gruppo
    ProfInd:=GetProfiloIndennita(D);
    if ProfInd = '*' then
      //Annullamento maturazione indennità
      exit;
    with selT162 do
    begin
      Filter:='PROFILO = ''' + ProfInd + '''';
      First;
      while not Eof do
      begin
        if lstIndennitaSpettanti.IndexOf(FieldByName('CODICE').AsString) = -1 then
          lstIndennitaSpettanti.Add(FieldByName('CODICE').AsString);
        Next;
      end;
    end;
    //Indennità associate direttamente tramite espressione SQL
    with TStringList.Create do
    try
      CommaText:=GetIndennitaDirette(D);
      for x:=0 to Count - 1 do
        if lstIndennitaSpettanti.IndexOf(Strings[x]) = -1 then
          lstIndennitaSpettanti.Add(Strings[x]);
    finally
      Free;
    end;
    with selT162 do
    begin
      //Eliminazione indennità incompatibili solo se senza equilibrio
      Filter:='';
      First;
      while not Eof do
      begin
        if (lstIndennitaSpettanti.IndexOf(FieldByName('CODICE').AsString) >= 0) and
           (not FieldByName('INDENNITA_INCOMPATIBILI').IsNull) and
           (FieldByName('TIPO').AsString = 'Z') then
        begin
          lstIndennitaIncompatibili.CommaText:=FieldByName('INDENNITA_INCOMPATIBILI').AsString;
          for x:=0 to lstIndennitaIncompatibili.Count - 1 do
            if VarToStr(Lookup('CODICE',lstIndennitaIncompatibili[x],'TIPO')) = 'Z' then
            begin
              p:=lstIndennitaSpettanti.IndexOf(lstIndennitaIncompatibili[x]);
              if p >= 0 then
                lstIndennitaSpettanti.Delete(p);
            end;
        end;
        Next;
      end;
    end;
    (*lstIndennitaSpettanti.Clear;
    //Indennità associate direttamente tramite espressione SQL
    lstIndennitaSpettanti.CommaText:=GetIndennitaDirette(D);
    //Eliminazione indennità ripetute
    x:=0;
    while x <= lstIndennitaSpettanti.Count - 1 do
    begin
      p:=x + 1;
      while p <= lstIndennitaSpettanti.Count - 1 do
      begin
        if lstIndennitaSpettanti[x] = lstIndennitaSpettanti[p] then
          lstIndennitaSpettanti.Delete(p)
        else
          inc(p);
      end;
      inc(x);
    end;
    //Indennità associata al profilo indennità da anagrafico, pianificazione giornaliera o associazioni di gruppo
    ProfInd:=GetProfiloIndennita(D);
    if ProfInd = '*' then
    begin
      //Annullamento maturazione indennità
      lstIndennitaSpettanti.Clear;
      ProfInd:='';
      exit;
    end;
    with selT162 do
    begin
      Filter:='PROFILO = ''' + ProfInd + '''';
      First;
      while not Eof do
      begin
        if lstIndennitaSpettanti.IndexOf(FieldByName('CODICE').AsString) = -1 then
          lstIndennitaSpettanti.Add(FieldByName('CODICE').AsString);
        Next;
      end;
      //Eliminazione indennità incompatibili solo se senza equilibrio
      Filter:='';
      First;
      while not Eof do
      begin
        if (lstIndennitaSpettanti.IndexOf(FieldByName('CODICE').AsString) >= 0) and
           (not FieldByName('INDENNITA_INCOMPATIBILI').IsNull) and
           (FieldByName('TIPO').AsString = 'Z') then
        begin
          lstIndennitaIncompatibili.CommaText:=FieldByName('INDENNITA_INCOMPATIBILI').AsString;
          for x:=0 to lstIndennitaIncompatibili.Count - 1 do
            if VarToStr(Lookup('CODICE',lstIndennitaIncompatibili[x],'TIPO')) = 'Z' then
            begin
              p:=lstIndennitaSpettanti.IndexOf(lstIndennitaIncompatibili[x]);
              if p >= 0 then
                lstIndennitaSpettanti.Delete(p);
            end;
        end;
        Next;
      end;
    end;*)
  end;
begin
  //Indennità spettanti del giorno precedente
  if (not RiepilogoMensile or (s_saltoggistit1 = 'no')) and (R502ProDtM1.tindennitapresenza[1].tindpres <> 0) then
  begin
    Reperibile:='N';
    IndennitaSpettanti(R502ProDtM1.DataCon - 1);
    Somma:=True;
    //Riepilogo indennità di presenza e turno
    for i:=0 to lstIndennitaSpettanti.Count - 1 do
    begin
      x141_riepilogaindpres(RiepilogoMensile,Somma,lstIndennitaSpettanti[i],R502ProDtM1.tindennitapresenza[1].tindpres,1,3);  //Alberto 21/11/2005 
      Somma:=False;
    end;
  end;
  //Indennità spettanti del giorno attuale
  if ((not RiepilogoMensile) or (s_saltoggistit = 'no')) and (R502ProDtM1.numcorr <= ncfinistit) then
  begin
    Reperibile:=GetOreInReperibilita;
    IndennitaSpettanti(R502ProDtM1.DataCon);
    if not RiepilogoMensile then
      indpres_Giorno[NGIndPres].IndSpett:=lstIndennitaSpettanti.CommaText;
    for j:=2 to 3 do
    begin
      //Nando 07/11/2003 inizio
      //if R502ProDtM1.tindennitapresenza[j].tindpres <> 0 then
      //Nando 07/11/2003 fine
      begin
        Somma:=True;
        for i:=0 to lstIndennitaSpettanti.Count - 1 do
        begin
          //Riepilogo indennità di presenza e turno
//          x141_riepilogaindpres(RiepilogoMensile,Somma,lstIndennitaSpettanti[i],R502ProDtM1.tindennitapresenza[j].tindpres,0);
          x141_riepilogaindpres(RiepilogoMensile,Somma,lstIndennitaSpettanti[i],R502ProDtM1.tindennitapresenza[j].tindpres,0,j); //LORENA 18/04/2005
          Somma:=False;
        end;
      end;
    end;
  end;
end;

procedure TR400FCartellinoDtM.x141_riepilogaindpres(RiepilogoMensile,Somma:Boolean; codindpres:String; indpres:Single; ggprec,Tipo:Byte);
var
  App:Byte;
  i,j,OreIndSup:Integer;
  Causali:String;
begin
  if codindpres = '' then exit;
  //Indennità di presenza da ore causalizzate
  if VarToStr(selT162.Lookup('CODICE',codindpres,'TIPO')) = 'G' then
  begin
    if Tipo = 2 then //LORENA 12/04/2005
      indpres:=1
    else if Tipo = 3 then
      indpres:=0;
    Causali:=',' + VarToStr(selT162.Lookup('CODICE',codindpres,'ASSENZE')) + ',';
    //Riepilogo delle presenze
    for i:=1 to R502ProDtM1.n_rieppres do
      if (Trim(R502ProDtM1.triepgiuspres[i].tcauspres) <> '') and (Pos(',' + R502ProDtM1.triepgiuspres[i].tcauspres + ',',Causali) > 0) then
      begin
        Causali:='';
        Break;
      end;
    //Riepilogo delle assenze
    if Causali <> '' then
      for i:=1 to R502ProDtM1.n_riepasse do
        if (Trim(R502ProDtM1.triepgiusasse[i].tcausasse) <> '') and (Pos(',' + R502ProDtM1.triepgiusasse[i].tcausasse + ',',Causali) > 0) then
        begin
          Causali:='';
          Break;
        end;
    if Causali <> '' then
      exit;
  end;
  if not(RiepilogoMensile) then
  //Registrazione indennità per ricalcolo a fine cartellino
  begin
    if Somma then
      indpres_giorno[NGIndPres - ggprec].Ind:=indpres_giorno[NGIndPres - ggprec].Ind + indpres;
    for i:=1 to High(indpres_giorno[NGIndPres - ggprec].CodInd) do
      if indpres_giorno[NGIndPres - ggprec].CodInd[i] = codindpres then
        Break
      else if indpres_giorno[NGIndPres - ggprec].CodInd[i] = '' then
      begin
        indpres_giorno[NGIndPres - ggprec].CodInd[i]:=codindpres;
        Break;
      end;
  end
  else
  //Riepilogo mensile
  begin
    //Le ind.giornaliere che maturano proporzionatamente al debito gg vengono ricalcolate dopo
    if VarToStr(selT162.Lookup('CODICE',codindpres,'MATURAZ_PROP_DEBITOGG')) = 'S' then
      exit;
    App:=0;
    for i:=1 to n_rpindpmes do
      if trpindpmes[i].tcodindpmes = codindpres then
      begin
        App:=1;
        Break;
      end;
    if App = 0 then
    begin
      if n_rpindpmes >= MAX_RPMES  then
        exit;
      inc(n_rpindpmes);
      i:=n_rpindpmes;
      trpindpmes[i].tcodindpmes:=codindpres;
      trpindpmes[i].tggindpmes:=0;
      trpindpmes[i].gginiziomat:=0;
      trpindpmes[i].ggfinemat:=0;
      trpindpmes[i].RestoIndSup:=0;
      trpindpmes[i].RestoIndSupPrec:=0;
      if selT162.SearchRecord('CODICE',codindpres,[srFromBeginning]) then
        trpindpmes[i].Importo:=selT162.FieldByName('IMPORTO').AsFloat
      else
        trpindpmes[i].Importo:=0;
    end;
    //Nando 07/11/2003 inizio
    if (R502ProDtM1.DataCon >= DataDa) and (R502ProDtM1.DataCon <= DataA) then
    begin
      if trpindpmes[i].gginiziomat = 0 then
        trpindpmes[i].gginiziomat:=R502ProDtM1.DataCon;
      if trpindpmes[i].ggfinemat < R502ProDtM1.DataCon then
        trpindpmes[i].ggfinemat:=R502ProDtM1.DataCon;
    end;
    //Nando 07/11/2003 fine
    trpindpmes[i].tggindpmes:=trpindpmes[i].tggindpmes + indpres;
    trpindpmes[i].NumGGLav:=R502ProDtM1.giornlav;
    if (VarToStr(selT162.Lookup('CODICE',codindpres,'SUPPL_5GGLAV')) = 'S') and (indpres = 1) then
      with R502ProDtM1 do
      begin
        OreIndSup:=Totlav;
        for j:=1 to n_riepasse do
          if (ValStrT265[triepgiusasse[j].tcausasse,'INDPRES'] <> 'S') then
            OreIndSup:=OreIndSup - triepgiusasse[j].tminresasse;
        if (gglav = 'si') and (minmonteore = 36*60) and (giornlav = 5) and (OreIndSup >= minmonteore / giornlav) then
          trpindpmes[i].RestoIndSup:=trpindpmes[i].RestoIndSup + 0.20;
      end;
  end;
end;

procedure TR400FCartellinoDtM.x145_rpggIndTurnoI(Indice:Integer);
var i,j,k,fm:Integer;
    (*ITIOreTimbLorde,*)ITIDebito,ITIOreTimb,ITIGGPres,ITIOreFT,ITIOreAss,IndiceTurnoPrec:Integer;
    ITICauAss,ITIRaggrCauPres:String;
    App,DetrazAssenze:Integer;
    T1,T2:Integer;
    T162Assenze,T162AssenzeAbilitate,T162PianifNO:String;
    T162OffsetMetaDebito,T162OffsetGGPrec:Integer;
begin
  T1:=Max(R502ProDtM1.n_turno1,R502ProDtM1.c_turni1);
  T2:=Max(R502ProDtM1.n_turno2,R502ProDtM1.c_turni2);
  //Riconoscimento delle ind. di presenza di tipo I
  with TStringList.Create do
  try
    CommaText:=indpres_Giorno[Indice].IndSpett;
    for i:=0 to Count - 1 do
      if VarToStr(selT162.Lookup('CODICE',Strings[i],'TIPO')) = 'I' then
      begin
        selT162.SearchRecord('CODICE',Strings[i],[srFromBeginning]);
        //Verifico che la causale di presenza sia abilitata in anagrafico
        ITIRaggrCauPres:=R502ProDtM1.ValStrT275[VarToStr(selT162.Lookup('CODICE',Strings[i],'CAUPRES_RIEPORE')),'CODRAGGR'];
        T162OffsetGGPrec:=-1;
        if (selT162.FindField('OFFSET_GGPREC') <> nil) and (not selT162.FieldByName('OFFSET_GGPREC').IsNull) then T162OffsetGGPrec:=R180OreMinutiExt(selT162.FieldByName('OFFSET_GGPREC').AsString);
        T162PianifNO:='S';
        if selT162.FindField('PIANIF_NOOP') <> nil then T162PianifNO:=selT162.FieldByName('PIANIF_NOOP').AsString;
        if T162PianifNO = 'S' then
        begin
          T1:=IfThen(R502ProDtM1.TurnoProvv1 in [1..4],R502ProDtM1.TurnoProvv1,R502ProDtM1.n_turno1);
          T2:=IfThen(R502ProDtM1.TurnoProvv2 in [1..4],R502ProDtM1.TurnoProvv2,R502ProDtM1.n_turno2);
        end;
        if (ITIRaggrCauPres <> '') and (Pos(',' + ITIRaggrCauPres + ',',',' + R502ProDtM1.Q430.FieldByName('AbPresenza1').AsString + ',') > 0) then
        begin
          k:=Length(indpres_Giorno[Indice].DatiGGIndTurnoI);
          SetLength(indpres_Giorno[Indice].DatiGGIndTurnoI,k + 1);
          indpres_Giorno[Indice].DatiGGIndTurnoI[k].Cod:=Strings[i];
          indpres_Giorno[Indice].DatiGGIndTurnoI[k].Turno1:=max(0,T1);
          indpres_Giorno[Indice].DatiGGIndTurnoI[k].Turno2:=max(0,T2);
          indpres_Giorno[Indice].DatiGGIndTurnoI[k].TotOre:=0;
          for j:=1 to High(indpres_Giorno[Indice].DatiGGIndTurnoI[k].OreRese) do
            indpres_Giorno[Indice].DatiGGIndTurnoI[k].OreRese[j]:=0;
        end;
      end;
  finally
    Free;
  end;
  for i:=0 to High(indpres_Giorno[Indice].DatiGGIndTurnoI) do
  begin
    //Per ogni ind. di tipo I, lettura dei parametri per il riconoscimento giornaliero
    selT162.SearchRecord('CODICE',indpres_Giorno[Indice].DatiGGIndTurnoI[i].Cod,[srFromBeginning]);
    T162Assenze:=selT162.FieldByName('ASSENZE').AsString; //Assenze da conteggiare
    T162AssenzeAbilitate:=selT162.FieldByName('ASSENZE_ABILITATE').AsString; //Assenze tollerate
    T162OffsetMetaDebito:=30;
    if selT162.FindField('OFFSET_METADEBITO') <> nil then T162OffsetMetaDebito:=selT162.FieldByName('OFFSET_METADEBITO').AsInteger;
    ITIOreAss:=0;
    with TStringList.Create do
    try
      CommaText:=T162Assenze;
      for j:=0 to Count - 1 do
      begin
        if not R180InConcat(Strings[j],T162AssenzeAbilitate) then
          inc(ITIOreAss,R502ProDtM1.RiepAssenza[Strings[j],'HHRESE']);
      end;
    finally
      Free;
    end;
    (*Alberto 24/01/2011: riduco la decurtazione da assenze (cfr. chiamata ID 57354)
      DetrazTotLav contiene le detrazioni delle ore rese dovute agli arrotondamenti dell'eccedenza giornaliera
      Non considero DetrazTotLav nelle assenze che vanno ad abbassare le ore da timbratura*)
    DetrazAssenze:=R502ProDtM1.minassenze - min(R502ProDtM1.DetrazTotLav,R502ProDtM1.minassenze);
    //ITIOreTimb:=min(R502ProDtM1.totlav - DetrazAssenze,ITIOreTimbLorde) (*+ ITIOreAss*);
    ITIOreTimb:=R502ProDtM1.debitogg;//Vogliono così!
    ITIOreFT:=R502ProDtM1.totlav;
    ITIDebito:=R502ProDtM1.debitogg;
    ITIGGPres:=R502ProDtM1.ggpresenza;
    ITICauAss:='';
    for j:=1 to R502ProDtM1.n_riepasse do
      if not R180InConcat(R502ProDtM1.triepgiusasse[j].tcausasse,T162AssenzeAbilitate) then
        dec(ITIOreTimb,R502ProDtM1.triepgiusasse[j].tminresasse);
    for j:=0 to High(R502ProDtM1.GiustificativiDelGiorno) do
      if R180InConcat(R502ProDtM1.GiustificativiDelGiorno[0].tcausgius,T162AssenzeAbilitate) then
        ITICauAss:=ITICAuAss + IfThen(j > 0,',','') + R502ProDtM1.GiustificativiDelGiorno[0].tcausgius;
    //Verifica che il turno effettuato risponda ai requisiti necessari
    if (T1 + T2 > 0) and ((ITIDebito / 2 + T162OffsetMetaDebito) < ITIOreTimb) and
       ((ITIGGPres = 1) or ((ITIGGPres = 0) or (ITICauAss <> ''))) then
    begin
      DetrazAssenze:=min(R502ProDtM1.DetrazTotLav,ITIOreAss);
      inc(ITIOreTimb,ITIOreAss - DetrazAssenze);
    end
    else
    begin
      indpres_Giorno[Indice].DatiGGIndTurnoI[i].Turno1:=0;
      indpres_Giorno[Indice].DatiGGIndTurnoI[i].Turno2:=0;
      ITIOreTimb:=0;
      ITIOreFT:=0;
    end;
    indpres_Giorno[Indice].DatiGGIndTurnoI[i].PuntoNominale:=-1;
    if (R502ProDtM1.n_turno1 > 0) or (R502ProDtM1.n_turno2 > 0) then
      indpres_Giorno[Indice].DatiGGIndTurnoI[i].PuntoNominale:=R502ProDtM1.PrimaEntrataNominaleUsata;
    IndiceTurnoPrec:=Indice - 1;
    while (IndiceTurnoPrec > 0) and (High(indpres_Giorno[IndiceTurnoPrec].DatiGGIndTurnoI) >= i) and (indpres_Giorno[IndiceTurnoPrec].DatiGGIndTurnoI[i].PuntoNominale = -1) do
      dec(IndiceTurnoPrec);
    if (T162OffsetGGPrec >= 0) and (Indice > 1) and (IndiceTurnoPrec > 0) then
      if (High(indpres_Giorno[Indice].DatiGGIndTurnoI) >= i) and
         (High(indpres_Giorno[IndiceTurnoPrec].DatiGGIndTurnoI) >= i) then
        if (indpres_Giorno[Indice].DatiGGIndTurnoI[i].PuntoNominale = -1) or
           ((indpres_Giorno[Indice].DatiGGIndTurnoI[i].PuntoNominale <> indpres_Giorno[IndiceTurnoPrec].DatiGGIndTurnoI[i].PuntoNominale) and
            (abs(indpres_Giorno[Indice].DatiGGIndTurnoI[i].PuntoNominale - indpres_Giorno[IndiceTurnoPrec].DatiGGIndTurnoI[i].PuntoNominale) < T162OffsetGGPrec)) then
        begin
          indpres_Giorno[Indice].DatiGGIndTurnoI[i].Turno1:=0;
          indpres_Giorno[Indice].DatiGGIndTurnoI[i].Turno2:=0;
          ITIOreTimb:=0;
          ITIOreFT:=0;
        end;
    //Calcolo delle ore rese in fasce
    K:=min(min(ITIOreTimb,ITIDebito),ITIOreFT);
    for j:=R502ProDtM1.n_fasce downto 1 do
    begin
      fm:=R502ProDtM1.tfasceorarie[j].tposfasc;
      if fm > 0 then
      begin
        App:=max(0,min(R502ProDtM1.tminlav[j] - R502ProDtM1.tminstrgio[j],K));
        inc(indpres_Giorno[Indice].DatiGGIndTurnoI[i].OreRese[fm],App);
        dec(k,App);
      end;
    end;
    (*Arrotondamento alla mezz'ora per difetto: il resto viene riportato sulla fascia precedente*)
    for j:=High(indpres_Giorno[Indice].DatiGGIndTurnoI[i].OreRese) downto 2 do
    begin
      inc(indpres_Giorno[Indice].DatiGGIndTurnoI[i].OreRese[j - 1],indpres_Giorno[Indice].DatiGGIndTurnoI[i].OreRese[j] mod 30);
      dec(indpres_Giorno[Indice].DatiGGIndTurnoI[i].OreRese[j],indpres_Giorno[Indice].DatiGGIndTurnoI[i].OreRese[j] mod 30);
    end;
    //Totalizzazione mensile delle ore
    for j:=1 to MaxFasce do
      inc(indpres_giorno[Indice].DatiGGIndTurnoI[i].TotOre,indpres_giorno[Indice].DatiGGIndTurnoI[i].OreRese[j]);
  end;
end;

function TR400FCartellinoDtM.x150_OreInail:Integer;
var i,j:Integer;
    PercInail:Real;
begin
  with R502ProDtM1 do
  begin
    Result:=totlav - abbannoprec - abbannoatt - abbliqannoprec - abbliqannoatt;
    for i:=1 to n_rieppres do
      if (ValStrT275[triepgiuspres[i].tcauspres,'ORENORMALI'] = 'A') and
         (ValStrT275[triepgiuspres[i].tcauspres,'PERC_INAIL'] = 'S') then
        for j:=1 to n_fasce do
          inc(Result,triepgiuspres[i].tminpres[j]);
    for i:=1 to n_riepasse do
      if ValStrT265[triepgiusasse[i].tcausasse,'PERC_INAIL'] <> '' then
        try
          PercInail:=StrToFloat(ValStrT265[triepgiusasse[i].tcausasse,'PERC_INAIL']);
          dec(Result,Trunc(triepgiusasse[i].tminresasse * (PercInail / 100)));
        except
        end;
  end;
end;

function TR400FCartellinoDtM.GetInizioAssenze:TDateTime;
begin
  Result:=nciniistit;
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    Result:=ncinisaldi;
end;

function TR400FCartellinoDtM.GetFineAssenze:TDateTime;
begin
  Result:=ncfinistit;
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    Result:=ncfinsaldi;
end;

procedure TR400FCartellinoDtM.R400FCartellinoDtMDestroy(Sender: TObject);
var i:Integer;
begin
  if A041MW <> nil then
    FreeAndNil(A041MW);
  if R300DtM <> nil then
    FreeAndNil(R300DtM);
  if R350DtM <> nil then
    FreeAndNil(R350DtM);
  if R450DtM1 <> nil then
    FreeAndNil(R450DtM1);
  if R600DtM1 <> nil then
    FreeAndNil(R600DtM1);
  if A023MW <> nil then
    FreeAndNil(A023MW);
  FreeAndNil(R410FAutoGiustificazioneDtM);
  FreeAndNil(QSDatiAnagrafici);
  FreeAndNil(selDatiBloccati);
  FreeAndNil(lstIndennitaSpettanti);
  FreeAndNil(lstIndennitaIncompatibili);
  FreeAndNil(lstDettaglio);
  FreeAndNil(lstRiepilogo);
  FreeAndNil(lstAnomalie); // validazione web - daniloc 19.03.2012
  FreeAndNil(lstAnomalieMM);
  FreeAndNil(lstSchedeAggiornate);
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if Self.Components[i] is TOracleQuery then
      (Self.Components[i] as TOracleQuery).Close;
  end;
end;

procedure TR400FCartellinoDtM.Q950ListaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('PARAMETRIZZAZIONI CARTELLINO',DataSet.FieldByName('CODICE').AsString);
end;

procedure TR400FCartellinoDtM.selT820FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=False;
  if R502ProDtM1 <> nil then
    Accept:=(DataSet.FieldByName('DAL').AsInteger <= R180Giorno(R502ProDtM1.datacon)) and
            (DataSet.FieldByName('AL').AsInteger >= R180Giorno(R502ProDtM1.datacon));
end;

end.
