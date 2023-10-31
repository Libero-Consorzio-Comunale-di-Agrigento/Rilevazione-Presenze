// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : Z:\Normativa\Condivisi\Flussi XML Gedap\WS_GEDAP.xml
//  >Import : Z:\Normativa\Condivisi\Flussi XML Gedap\WS_GEDAP.xml>0
//  >Import : Z:\Normativa\Condivisi\Flussi XML Gedap\WS_GEDAP.xml>1
// (19/04/2016 14:49:15 - - $Rev: 56641 $)
// ************************************************************************ //

unit A124UWSPermessiGEDAP;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_UNQL = $0008;
  IS_ATTR = $0010;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:nonNegativeInteger - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:integer         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:anySimpleType   - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:positiveInteger - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:date            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:time            - "http://www.w3.org/2001/XMLSchema"[Gbl]

  inserimentoIstituto  = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblElm] }
  success              = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }
  esitoInserimentoIstituto = class;             { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblElm] }
  confederazione       = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }
  distaccamento        = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }
  nuovoIstitutoPemRsuCumulati_type = class;     { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblCplx] }
  nuovoIstitutoPemCumulati_type = class;        { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblCplx] }
  wsdlResponse         = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblElm] }
  wsdlRequest          = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblElm] }
  nuovoIstitutoDisCumAsp_type = class;          { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblCplx] }
  dipendente           = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblElm] }
  provvedimento        = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }
  provvedimento2       = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }
  provvedimento3       = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }
  provvedimento4       = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }
  nuovoIstitutoPfp_type = class;                { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblCplx] }
  nuovoIstitutoAfp_type = class;                { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblCplx] }
  soggettoLegittimato  = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblElm] }
  provvedimento5       = class;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }
  nuovoIstitutoPemProPnr_type = class;          { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblCplx] }
  nuovoIstitutoPemPnrRsu_type = class;          { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblCplx] }

  {$SCOPEDENUMS ON}
  { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblSmpl] }
  sesso_type = (M, F);

  { "http://com.accenture.perla.it/gedap_inserimentoistituti"[GblSmpl] }
  esito_type = (OK, KO);

  {$SCOPEDENUMS OFF}

  confederazioniCollegate = array of confederazione;   { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }


  // ************************************************************************ //
  // XML       : inserimentoIstituto, global, <element>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  inserimentoIstituto = class(TRemotable)
  private
    FcodiceEnte: Int64;
    FnuovoIstitutoDIS: nuovoIstitutoDisCumAsp_type;
    FnuovoIstitutoDIS_Specified: boolean;
    FnuovoIstitutoCUM: nuovoIstitutoDisCumAsp_type;
    FnuovoIstitutoCUM_Specified: boolean;
    FnuovoIstitutoASP: nuovoIstitutoDisCumAsp_type;
    FnuovoIstitutoASP_Specified: boolean;
    FnuovoIstitutoPEM: nuovoIstitutoPemProPnr_type;
    FnuovoIstitutoPEM_Specified: boolean;
    FnuovoIstitutoPRO: nuovoIstitutoPemProPnr_type;
    FnuovoIstitutoPRO_Specified: boolean;
    FnuovoIstitutoPNR: nuovoIstitutoPemProPnr_type;
    FnuovoIstitutoPNR_Specified: boolean;
    FnuovoIstitutoPEMRSU: nuovoIstitutoPemPnrRsu_type;
    FnuovoIstitutoPEMRSU_Specified: boolean;
    FnuovoIstitutoPNRRSU: nuovoIstitutoPemPnrRsu_type;
    FnuovoIstitutoPNRRSU_Specified: boolean;
    FnuovoIstitutoAFP: nuovoIstitutoAfp_type;
    FnuovoIstitutoAFP_Specified: boolean;
    FnuovoIstitutoPFP: nuovoIstitutoPfp_type;
    FnuovoIstitutoPFP_Specified: boolean;
    FnuovoIstitutoPEMCumulati: nuovoIstitutoPemCumulati_type;
    FnuovoIstitutoPEMCumulati_Specified: boolean;
    FnuovoIstitutoPEMRSUCumulati: nuovoIstitutoPemRsuCumulati_type;
    FnuovoIstitutoPEMRSUCumulati_Specified: boolean;
    procedure SetnuovoIstitutoDIS(Index: Integer; const AnuovoIstitutoDisCumAsp_type: nuovoIstitutoDisCumAsp_type);
    function  nuovoIstitutoDIS_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoCUM(Index: Integer; const AnuovoIstitutoDisCumAsp_type: nuovoIstitutoDisCumAsp_type);
    function  nuovoIstitutoCUM_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoASP(Index: Integer; const AnuovoIstitutoDisCumAsp_type: nuovoIstitutoDisCumAsp_type);
    function  nuovoIstitutoASP_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoPEM(Index: Integer; const AnuovoIstitutoPemProPnr_type: nuovoIstitutoPemProPnr_type);
    function  nuovoIstitutoPEM_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoPRO(Index: Integer; const AnuovoIstitutoPemProPnr_type: nuovoIstitutoPemProPnr_type);
    function  nuovoIstitutoPRO_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoPNR(Index: Integer; const AnuovoIstitutoPemProPnr_type: nuovoIstitutoPemProPnr_type);
    function  nuovoIstitutoPNR_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoPEMRSU(Index: Integer; const AnuovoIstitutoPemPnrRsu_type: nuovoIstitutoPemPnrRsu_type);
    function  nuovoIstitutoPEMRSU_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoPNRRSU(Index: Integer; const AnuovoIstitutoPemPnrRsu_type: nuovoIstitutoPemPnrRsu_type);
    function  nuovoIstitutoPNRRSU_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoAFP(Index: Integer; const AnuovoIstitutoAfp_type: nuovoIstitutoAfp_type);
    function  nuovoIstitutoAFP_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoPFP(Index: Integer; const AnuovoIstitutoPfp_type: nuovoIstitutoPfp_type);
    function  nuovoIstitutoPFP_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoPEMCumulati(Index: Integer; const AnuovoIstitutoPemCumulati_type: nuovoIstitutoPemCumulati_type);
    function  nuovoIstitutoPEMCumulati_Specified(Index: Integer): boolean;
    procedure SetnuovoIstitutoPEMRSUCumulati(Index: Integer; const AnuovoIstitutoPemRsuCumulati_type: nuovoIstitutoPemRsuCumulati_type);
    function  nuovoIstitutoPEMRSUCumulati_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property codiceEnte:                  Int64                             Index (IS_ATTR) read FcodiceEnte write FcodiceEnte;
    property nuovoIstitutoDIS:            nuovoIstitutoDisCumAsp_type       Index (IS_OPTN) read FnuovoIstitutoDIS write SetnuovoIstitutoDIS stored nuovoIstitutoDIS_Specified;
    property nuovoIstitutoCUM:            nuovoIstitutoDisCumAsp_type       Index (IS_OPTN) read FnuovoIstitutoCUM write SetnuovoIstitutoCUM stored nuovoIstitutoCUM_Specified;
    property nuovoIstitutoASP:            nuovoIstitutoDisCumAsp_type       Index (IS_OPTN) read FnuovoIstitutoASP write SetnuovoIstitutoASP stored nuovoIstitutoASP_Specified;
    property nuovoIstitutoPEM:            nuovoIstitutoPemProPnr_type       Index (IS_OPTN) read FnuovoIstitutoPEM write SetnuovoIstitutoPEM stored nuovoIstitutoPEM_Specified;
    property nuovoIstitutoPRO:            nuovoIstitutoPemProPnr_type       Index (IS_OPTN) read FnuovoIstitutoPRO write SetnuovoIstitutoPRO stored nuovoIstitutoPRO_Specified;
    property nuovoIstitutoPNR:            nuovoIstitutoPemProPnr_type       Index (IS_OPTN) read FnuovoIstitutoPNR write SetnuovoIstitutoPNR stored nuovoIstitutoPNR_Specified;
    property nuovoIstitutoPEMRSU:         nuovoIstitutoPemPnrRsu_type       Index (IS_OPTN) read FnuovoIstitutoPEMRSU write SetnuovoIstitutoPEMRSU stored nuovoIstitutoPEMRSU_Specified;
    property nuovoIstitutoPNRRSU:         nuovoIstitutoPemPnrRsu_type       Index (IS_OPTN) read FnuovoIstitutoPNRRSU write SetnuovoIstitutoPNRRSU stored nuovoIstitutoPNRRSU_Specified;
    property nuovoIstitutoAFP:            nuovoIstitutoAfp_type             Index (IS_OPTN) read FnuovoIstitutoAFP write SetnuovoIstitutoAFP stored nuovoIstitutoAFP_Specified;
    property nuovoIstitutoPFP:            nuovoIstitutoPfp_type             Index (IS_OPTN) read FnuovoIstitutoPFP write SetnuovoIstitutoPFP stored nuovoIstitutoPFP_Specified;
    property nuovoIstitutoPEMCumulati:    nuovoIstitutoPemCumulati_type     Index (IS_OPTN) read FnuovoIstitutoPEMCumulati write SetnuovoIstitutoPEMCumulati stored nuovoIstitutoPEMCumulati_Specified;
    property nuovoIstitutoPEMRSUCumulati: nuovoIstitutoPemRsuCumulati_type  Index (IS_OPTN) read FnuovoIstitutoPEMRSUCumulati write SetnuovoIstitutoPEMRSUCumulati stored nuovoIstitutoPEMRSUCumulati_Specified;
  end;

  errori     = array of string;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }


  // ************************************************************************ //
  // XML       : success, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  success = class(TRemotable)
  private
    Fdescrizione: errori;
    FidRilevazione: errori;
  published
    property descrizione:   errori  Index (IS_UNBD) read Fdescrizione write Fdescrizione;
    property idRilevazione: errori  Index (IS_UNBD) read FidRilevazione write FidRilevazione;
  end;

  warning    = array of string;                 { "http://com.accenture.perla.it/gedap_inserimentoistituti"[Cplx] }


  // ************************************************************************ //
  // XML       : esitoInserimentoIstituto, global, <element>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  esitoInserimentoIstituto = class(TRemotable)
  private
    Fesito: esito_type;
    Ferrori: errori;
    Ferrori_Specified: boolean;
    Fwarning: warning;
    Fwarning_Specified: boolean;
    Fsuccess: success;
    Fsuccess_Specified: boolean;
    procedure Seterrori(Index: Integer; const Aerrori: errori);
    function  errori_Specified(Index: Integer): boolean;
    procedure Setwarning(Index: Integer; const Awarning: warning);
    function  warning_Specified(Index: Integer): boolean;
    procedure Setsuccess(Index: Integer; const Asuccess: success);
    function  success_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property esito:   esito_type  Index (IS_ATTR) read Fesito write Fesito;
    property errori:  errori      Index (IS_OPTN) read Ferrori write Seterrori stored errori_Specified;
    property warning: warning     Index (IS_OPTN) read Fwarning write Setwarning stored warning_Specified;
    property success: success     Index (IS_OPTN) read Fsuccess write Setsuccess stored success_Specified;
  end;



  // ************************************************************************ //
  // XML       : confederazione, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  confederazione = class(TRemotable)
  private
    FcodiceFiscale: string;
  published
    property codiceFiscale: string  Index (IS_ATTR) read FcodiceFiscale write FcodiceFiscale;
  end;



  // ************************************************************************ //
  // XML       : distaccamento, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  distaccamento = class(TRemotable)
  private
    Fcomune: string;
    Findirizzo: string;
  published
    property comune:    string  Index (IS_ATTR) read Fcomune write Fcomune;
    property indirizzo: string  Index (IS_ATTR) read Findirizzo write Findirizzo;
  end;



  // ************************************************************************ //
  // XML       : nuovoIstitutoPemRsuCumulati_type, global, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  nuovoIstitutoPemRsuCumulati_type = class(TRemotable)
  private
    FdataInizio: (*Variant*)TXSDate;
    FdataFine: (*Variant*)TXSDate;
    ForeFruite: TXSDecimal;
    FminutiFruiti: TXSDecimal;
    Fdipendente: dipendente;
    Fprovvedimento: provvedimento3;
  public
    destructor Destroy; override;
  published
    property dataInizio:    (*Variant*)TXSDate Index (IS_ATTR) read FdataInizio write FdataInizio;
    property dataFine:      (*Variant*)TXSDate Index (IS_ATTR) read FdataFine write FdataFine;
    property oreFruite:     TXSDecimal      Index (IS_ATTR) read ForeFruite write ForeFruite;
    property minutiFruiti:  TXSDecimal      Index (IS_ATTR) read FminutiFruiti write FminutiFruiti;
    property dipendente:    dipendente      Index (IS_REF) read Fdipendente write Fdipendente;
    property provvedimento: provvedimento3  read Fprovvedimento write Fprovvedimento;
  end;



  // ************************************************************************ //
  // XML       : nuovoIstitutoPemCumulati_type, global, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  nuovoIstitutoPemCumulati_type = class(TRemotable)
  private
    FdataInizio: (*Variant*)TXSDate;
    FdataFine: (*Variant*)TXSDate;
    ForeFruite: TXSDecimal;
    FminutiFruiti: TXSDecimal;
    Fdipendente: dipendente;
    Fprovvedimento: provvedimento2;
    FsoggettoLegittimato: soggettoLegittimato;
  public
    destructor Destroy; override;
  published
    property dataInizio:          (*Variant*)TXSDate   Index (IS_ATTR) read FdataInizio write FdataInizio;
    property dataFine:            (*Variant*)TXSDate   Index (IS_ATTR) read FdataFine write FdataFine;
    property oreFruite:           TXSDecimal           Index (IS_ATTR) read ForeFruite write ForeFruite;
    property minutiFruiti:        TXSDecimal           Index (IS_ATTR) read FminutiFruiti write FminutiFruiti;
    property dipendente:          dipendente           Index (IS_REF) read Fdipendente write Fdipendente;
    property provvedimento:       provvedimento2       read Fprovvedimento write Fprovvedimento;
    property soggettoLegittimato: soggettoLegittimato  Index (IS_REF) read FsoggettoLegittimato write FsoggettoLegittimato;
  end;



  // ************************************************************************ //
  // XML       : wsdlResponse, global, <element>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  wsdlResponse = class(TRemotable)
  private
    FesitoInserimentoIstituto: esitoInserimentoIstituto;
  public
    destructor Destroy; override;
  published
    property esitoInserimentoIstituto: esitoInserimentoIstituto  Index (IS_REF) read FesitoInserimentoIstituto write FesitoInserimentoIstituto;
  end;



  // ************************************************************************ //
  // XML       : wsdlRequest, global, <element>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  wsdlRequest = class(TRemotable)
  private
    Fusername: string;
    Fpwd: string;
    FinserimentoIstituto: inserimentoIstituto;
  public
    destructor Destroy; override;
  published
    property username:            string               read Fusername write Fusername;
    property pwd:                 string               read Fpwd write Fpwd;
    property inserimentoIstituto: inserimentoIstituto  Index (IS_REF) read FinserimentoIstituto write FinserimentoIstituto;
  end;



  // ************************************************************************ //
  // XML       : nuovoIstitutoDisCumAsp_type, global, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  nuovoIstitutoDisCumAsp_type = class(TRemotable)
  private
    Fdurata: TXSDecimal;
    FdataInizio: Variant;
    FdataFine: Variant;
    Fgrado: string;
    Fdipendente: dipendente;
    Fprovvedimento: provvedimento;
    FsoggettoLegittimato: soggettoLegittimato;
  public
    destructor Destroy; override;
  published
    property durata:              TXSDecimal           Index (IS_ATTR) read Fdurata write Fdurata;
    property dataInizio:          Variant              Index (IS_ATTR) read FdataInizio write FdataInizio;
    property dataFine:            Variant              Index (IS_ATTR) read FdataFine write FdataFine;
    property grado:               string               Index (IS_ATTR) read Fgrado write Fgrado;
    property dipendente:          dipendente           Index (IS_REF) read Fdipendente write Fdipendente;
    property provvedimento:       provvedimento        read Fprovvedimento write Fprovvedimento;
    property soggettoLegittimato: soggettoLegittimato  Index (IS_REF) read FsoggettoLegittimato write FsoggettoLegittimato;
  end;



  // ************************************************************************ //
  // XML       : dipendente, global, <element>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  dipendente = class(TRemotable)
  private
    FcodiceFiscale: string;
    Fcognome: string;
    Fnome: string;
    Fsesso: sesso_type;
    Fsesso_Specified: boolean;
    FdataNascita: TXSDate;
    FdataNascita_Specified: boolean;
    FcomuneNascita: string;
    FcomuneNascita_Specified: boolean;
    Fqualifica: TXSDecimal;
    Fdistaccamento: distaccamento;
    Fdistaccamento_Specified: boolean;
    procedure Setsesso(Index: Integer; const Asesso_type: sesso_type);
    function  sesso_Specified(Index: Integer): boolean;
    procedure SetdataNascita(Index: Integer; const ATXSDate: TXSDate);
    function  dataNascita_Specified(Index: Integer): boolean;
    procedure SetcomuneNascita(Index: Integer; const Astring: string);
    function  comuneNascita_Specified(Index: Integer): boolean;
    procedure Setdistaccamento(Index: Integer; const Adistaccamento: distaccamento);
    function  distaccamento_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property codiceFiscale: string         Index (IS_ATTR) read FcodiceFiscale write FcodiceFiscale;
    property cognome:       string         Index (IS_ATTR) read Fcognome write Fcognome;
    property nome:          string         Index (IS_ATTR) read Fnome write Fnome;
    property sesso:         sesso_type     Index (IS_ATTR or IS_OPTN) read Fsesso write Setsesso stored sesso_Specified;
    property dataNascita:   TXSDate        Index (IS_ATTR or IS_OPTN) read FdataNascita write SetdataNascita stored dataNascita_Specified;
    property comuneNascita: string         Index (IS_ATTR or IS_OPTN) read FcomuneNascita write SetcomuneNascita stored comuneNascita_Specified;
    property qualifica:     TXSDecimal     Index (IS_ATTR) read Fqualifica write Fqualifica;
    property distaccamento: distaccamento  Index (IS_OPTN) read Fdistaccamento write Setdistaccamento stored distaccamento_Specified;
  end;



  // ************************************************************************ //
  // XML       : provvedimento, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  provvedimento = class(TRemotable)
  private
    Fdata: TXSDate;
    Ftipo: TXSDecimal;
    FnumeroProtocollo: string;
    FnumeroProtocollo_Specified: boolean;
    Fnote: string;
    Fnote_Specified: boolean;
    procedure SetnumeroProtocollo(Index: Integer; const Astring: string);
    function  numeroProtocollo_Specified(Index: Integer): boolean;
    procedure Setnote(Index: Integer; const Astring: string);
    function  note_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property data:             TXSDate     Index (IS_ATTR) read Fdata write Fdata;
    property tipo:             TXSDecimal  Index (IS_ATTR) read Ftipo write Ftipo;
    property numeroProtocollo: string      Index (IS_ATTR or IS_OPTN) read FnumeroProtocollo write SetnumeroProtocollo stored numeroProtocollo_Specified;
    property note:             string      Index (IS_ATTR or IS_OPTN) read Fnote write Setnote stored note_Specified;
  end;



  // ************************************************************************ //
  // XML       : provvedimento, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  provvedimento2 = class(TRemotable)
  private
    Fdata: TXSDate;
    FnumeroProtocollo: string;
    FnumeroProtocollo_Specified: boolean;
    procedure SetnumeroProtocollo(Index: Integer; const Astring: string);
    function  numeroProtocollo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property data:             TXSDate  Index (IS_ATTR) read Fdata write Fdata;
    property numeroProtocollo: string   Index (IS_ATTR or IS_OPTN) read FnumeroProtocollo write SetnumeroProtocollo stored numeroProtocollo_Specified;
  end;



  // ************************************************************************ //
  // XML       : provvedimento, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  provvedimento3 = class(TRemotable)
  private
    Fdata: TXSDate;
    FnumeroProtocollo: string;
    FnumeroProtocollo_Specified: boolean;
    procedure SetnumeroProtocollo(Index: Integer; const Astring: string);
    function  numeroProtocollo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property data:             TXSDate  Index (IS_ATTR) read Fdata write Fdata;
    property numeroProtocollo: string   Index (IS_ATTR or IS_OPTN) read FnumeroProtocollo write SetnumeroProtocollo stored numeroProtocollo_Specified;
  end;



  // ************************************************************************ //
  // XML       : provvedimento, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  provvedimento4 = class(TRemotable)
  private
    Fdata: TXSDate;
    FnumeroProtocollo: string;
    FnumeroProtocollo_Specified: boolean;
    procedure SetnumeroProtocollo(Index: Integer; const Astring: string);
    function  numeroProtocollo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property data:             TXSDate  Index (IS_ATTR) read Fdata write Fdata;
    property numeroProtocollo: string   Index (IS_ATTR or IS_OPTN) read FnumeroProtocollo write SetnumeroProtocollo stored numeroProtocollo_Specified;
  end;



  // ************************************************************************ //
  // XML       : nuovoIstitutoPfp_type, global, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  nuovoIstitutoPfp_type = class(TRemotable)
  private
    FdataInizio: (*Variant*)TXSDate;
    FdataFine: (*Variant*)TXSDate;
    ForeTotali: TXSDecimal;
    FminutiResidui: TXSDecimal;
    Fcausale: TXSDecimal;
    Fdipendente: dipendente;
  public
    destructor Destroy; override;
  published
    property dataInizio:    (*Variant*)TXSDate  Index (IS_ATTR) read FdataInizio write FdataInizio;
    property dataFine:      (*Variant*)TXSDate  Index (IS_ATTR) read FdataFine write FdataFine;
    property oreTotali:     TXSDecimal  Index (IS_ATTR) read ForeTotali write ForeTotali;
    property minutiResidui: TXSDecimal  Index (IS_ATTR) read FminutiResidui write FminutiResidui;
    property causale:       TXSDecimal  Index (IS_ATTR) read Fcausale write Fcausale;
    property dipendente:    dipendente  Index (IS_REF) read Fdipendente write Fdipendente;
  end;



  // ************************************************************************ //
  // XML       : nuovoIstitutoAfp_type, global, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  nuovoIstitutoAfp_type = class(TRemotable)
  private
    FdataInizio: Variant;
    FdataFine: Variant;
    FgiorniTotali: TXSDecimal;
    Fcausale: TXSDecimal;
    Fdipendente: dipendente;
  public
    destructor Destroy; override;
  published
    property dataInizio:   Variant     Index (IS_ATTR) read FdataInizio write FdataInizio;
    property dataFine:     Variant     Index (IS_ATTR) read FdataFine write FdataFine;
    property giorniTotali: TXSDecimal  Index (IS_ATTR) read FgiorniTotali write FgiorniTotali;
    property causale:      TXSDecimal  Index (IS_ATTR) read Fcausale write Fcausale;
    property dipendente:   dipendente  Index (IS_REF) read Fdipendente write Fdipendente;
  end;



  // ************************************************************************ //
  // XML       : soggettoLegittimato, global, <element>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  soggettoLegittimato = class(TRemotable)
  private
    FcodiceFiscale: string;
    Fsigla: string;
    Fsigla_Specified: boolean;
    Fdenominazione: string;
    Fdenominazione_Specified: boolean;
    Fcomune: string;
    Fcomune_Specified: boolean;
    Findirizzo: string;
    Findirizzo_Specified: boolean;
    Fcap: string;
    Fcap_Specified: boolean;
    Ftelefono: string;
    Ftelefono_Specified: boolean;
    Ffax: string;
    Ffax_Specified: boolean;
    Femail: string;
    Femail_Specified: boolean;
    Ftipo: Int64;
    Ftipo_Specified: boolean;
    FconfederazioniCollegate: confederazioniCollegate;
    FconfederazioniCollegate_Specified: boolean;
    procedure Setsigla(Index: Integer; const Astring: string);
    function  sigla_Specified(Index: Integer): boolean;
    procedure Setdenominazione(Index: Integer; const Astring: string);
    function  denominazione_Specified(Index: Integer): boolean;
    procedure Setcomune(Index: Integer; const Astring: string);
    function  comune_Specified(Index: Integer): boolean;
    procedure Setindirizzo(Index: Integer; const Astring: string);
    function  indirizzo_Specified(Index: Integer): boolean;
    procedure Setcap(Index: Integer; const Astring: string);
    function  cap_Specified(Index: Integer): boolean;
    procedure Settelefono(Index: Integer; const Astring: string);
    function  telefono_Specified(Index: Integer): boolean;
    procedure Setfax(Index: Integer; const Astring: string);
    function  fax_Specified(Index: Integer): boolean;
    procedure Setemail(Index: Integer; const Astring: string);
    function  email_Specified(Index: Integer): boolean;
    procedure Settipo(Index: Integer; const AInt64: Int64);
    function  tipo_Specified(Index: Integer): boolean;
    procedure SetconfederazioniCollegate(Index: Integer; const AconfederazioniCollegate: confederazioniCollegate);
    function  confederazioniCollegate_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property codiceFiscale:           string                   Index (IS_ATTR) read FcodiceFiscale write FcodiceFiscale;
    property sigla:                   string                   Index (IS_ATTR or IS_OPTN) read Fsigla write Setsigla stored sigla_Specified;
    property denominazione:           string                   Index (IS_ATTR or IS_OPTN) read Fdenominazione write Setdenominazione stored denominazione_Specified;
    property comune:                  string                   Index (IS_ATTR or IS_OPTN) read Fcomune write Setcomune stored comune_Specified;
    property indirizzo:               string                   Index (IS_ATTR or IS_OPTN) read Findirizzo write Setindirizzo stored indirizzo_Specified;
    property cap:                     string                   Index (IS_ATTR or IS_OPTN) read Fcap write Setcap stored cap_Specified;
    property telefono:                string                   Index (IS_ATTR or IS_OPTN) read Ftelefono write Settelefono stored telefono_Specified;
    property fax:                     string                   Index (IS_ATTR or IS_OPTN) read Ffax write Setfax stored fax_Specified;
    property email:                   string                   Index (IS_ATTR or IS_OPTN) read Femail write Setemail stored email_Specified;
    property tipo:                    Int64                    Index (IS_ATTR or IS_OPTN) read Ftipo write Settipo stored tipo_Specified;
    property confederazioniCollegate: confederazioniCollegate  Index (IS_OPTN) read FconfederazioniCollegate write SetconfederazioniCollegate stored confederazioniCollegate_Specified;
  end;



  // ************************************************************************ //
  // XML       : provvedimento, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  provvedimento5 = class(TRemotable)
  private
    Fdata: TXSDate;
    FnumeroProtocollo: string;
    FnumeroProtocollo_Specified: boolean;
    procedure SetnumeroProtocollo(Index: Integer; const Astring: string);
    function  numeroProtocollo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property data:             TXSDate  Index (IS_ATTR) read Fdata write Fdata;
    property numeroProtocollo: string   Index (IS_ATTR or IS_OPTN) read FnumeroProtocollo write SetnumeroProtocollo stored numeroProtocollo_Specified;
  end;



  // ************************************************************************ //
  // XML       : nuovoIstitutoPemProPnr_type, global, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  nuovoIstitutoPemProPnr_type = class(TRemotable)
  private
    FdataPermesso: (*Variant*)TXSDate;
    ForaInizio: TXSTime;
    ForaFine: TXSTime;
    Fdipendente: dipendente;
    Fprovvedimento: provvedimento5;
    FsoggettoLegittimato: soggettoLegittimato;
  public
    destructor Destroy; override;
  published
    property dataPermesso:        (*Variant*)TXSDate   Index (IS_ATTR) read FdataPermesso write FdataPermesso;
    property oraInizio:           TXSTime              Index (IS_ATTR) read ForaInizio write ForaInizio;
    property oraFine:             TXSTime              Index (IS_ATTR) read ForaFine write ForaFine;
    property dipendente:          dipendente           Index (IS_REF) read Fdipendente write Fdipendente;
    property provvedimento:       provvedimento5       read Fprovvedimento write Fprovvedimento;
    property soggettoLegittimato: soggettoLegittimato  Index (IS_REF) read FsoggettoLegittimato write FsoggettoLegittimato;
  end;



  // ************************************************************************ //
  // XML       : nuovoIstitutoPemPnrRsu_type, global, <complexType>
  // Namespace : http://com.accenture.perla.it/gedap_inserimentoistituti
  // ************************************************************************ //
  nuovoIstitutoPemPnrRsu_type = class(TRemotable)
  private
    FdataPermesso: (*Variant*)TXSDate;
    ForaInizio: TXSTime;
    ForaFine: TXSTime;
    Fdipendente: dipendente;
    Fprovvedimento: provvedimento4;
  public
    destructor Destroy; override;
  published
    property dataPermesso:  (*Variant*)TXSDate Index (IS_ATTR) read FdataPermesso write FdataPermesso;
    property oraInizio:     TXSTime         Index (IS_ATTR) read ForaInizio write ForaInizio;
    property oraFine:       TXSTime         Index (IS_ATTR) read ForaFine write ForaFine;
    property dipendente:    dipendente      Index (IS_REF) read Fdipendente write Fdipendente;
    property provvedimento: provvedimento4  read Fprovvedimento write Fprovvedimento;
  end;


  // ************************************************************************ //
  // Namespace : http://com.accenture.perla.it/gedap
  // soapAction: InserimentoIstituti
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : GEDAPBinding
  // service   : GEDAPService
  // port      : GEDAPInterfaceEndpoint
  // URL       : http://www.perlapa.gov.it/GEDAP/1
  // ************************************************************************ //
  GEDAP = interface(IInvokable)
  ['{20911A13-2E32-1A21-9511-8865B364F698}']
    function  InserimentoIstituti(const wsdlRequest: wsdlRequest): wsdlResponse; stdcall;
  end;

function GetGEDAP(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): GEDAP;


implementation
  uses SysUtils;

function GetGEDAP(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): GEDAP;
const
  defWSDL = 'Z:\Normativa\Condivisi\Flussi XML Gedap\WS_GEDAP.xml';
  defURL  = 'http://www.perlapa.gov.it/GEDAP/1';
  defSvc  = 'GEDAPService';
  defPrt  = 'GEDAPInterfaceEndpoint';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as GEDAP);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor inserimentoIstituto.Destroy;
begin
  SysUtils.FreeAndNil(FnuovoIstitutoDIS);
  SysUtils.FreeAndNil(FnuovoIstitutoCUM);
  SysUtils.FreeAndNil(FnuovoIstitutoASP);
  SysUtils.FreeAndNil(FnuovoIstitutoPEM);
  SysUtils.FreeAndNil(FnuovoIstitutoPRO);
  SysUtils.FreeAndNil(FnuovoIstitutoPNR);
  SysUtils.FreeAndNil(FnuovoIstitutoPEMRSU);
  SysUtils.FreeAndNil(FnuovoIstitutoPNRRSU);
  SysUtils.FreeAndNil(FnuovoIstitutoAFP);
  SysUtils.FreeAndNil(FnuovoIstitutoPFP);
  SysUtils.FreeAndNil(FnuovoIstitutoPEMCumulati);
  SysUtils.FreeAndNil(FnuovoIstitutoPEMRSUCumulati);
  inherited Destroy;
end;

procedure inserimentoIstituto.SetnuovoIstitutoDIS(Index: Integer; const AnuovoIstitutoDisCumAsp_type: nuovoIstitutoDisCumAsp_type);
begin
  FnuovoIstitutoDIS := AnuovoIstitutoDisCumAsp_type;
  FnuovoIstitutoDIS_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoDIS_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoDIS_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoCUM(Index: Integer; const AnuovoIstitutoDisCumAsp_type: nuovoIstitutoDisCumAsp_type);
begin
  FnuovoIstitutoCUM := AnuovoIstitutoDisCumAsp_type;
  FnuovoIstitutoCUM_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoCUM_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoCUM_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoASP(Index: Integer; const AnuovoIstitutoDisCumAsp_type: nuovoIstitutoDisCumAsp_type);
begin
  FnuovoIstitutoASP := AnuovoIstitutoDisCumAsp_type;
  FnuovoIstitutoASP_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoASP_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoASP_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoPEM(Index: Integer; const AnuovoIstitutoPemProPnr_type: nuovoIstitutoPemProPnr_type);
begin
  FnuovoIstitutoPEM := AnuovoIstitutoPemProPnr_type;
  FnuovoIstitutoPEM_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoPEM_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoPEM_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoPRO(Index: Integer; const AnuovoIstitutoPemProPnr_type: nuovoIstitutoPemProPnr_type);
begin
  FnuovoIstitutoPRO := AnuovoIstitutoPemProPnr_type;
  FnuovoIstitutoPRO_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoPRO_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoPRO_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoPNR(Index: Integer; const AnuovoIstitutoPemProPnr_type: nuovoIstitutoPemProPnr_type);
begin
  FnuovoIstitutoPNR := AnuovoIstitutoPemProPnr_type;
  FnuovoIstitutoPNR_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoPNR_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoPNR_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoPEMRSU(Index: Integer; const AnuovoIstitutoPemPnrRsu_type: nuovoIstitutoPemPnrRsu_type);
begin
  FnuovoIstitutoPEMRSU := AnuovoIstitutoPemPnrRsu_type;
  FnuovoIstitutoPEMRSU_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoPEMRSU_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoPEMRSU_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoPNRRSU(Index: Integer; const AnuovoIstitutoPemPnrRsu_type: nuovoIstitutoPemPnrRsu_type);
begin
  FnuovoIstitutoPNRRSU := AnuovoIstitutoPemPnrRsu_type;
  FnuovoIstitutoPNRRSU_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoPNRRSU_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoPNRRSU_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoAFP(Index: Integer; const AnuovoIstitutoAfp_type: nuovoIstitutoAfp_type);
begin
  FnuovoIstitutoAFP := AnuovoIstitutoAfp_type;
  FnuovoIstitutoAFP_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoAFP_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoAFP_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoPFP(Index: Integer; const AnuovoIstitutoPfp_type: nuovoIstitutoPfp_type);
begin
  FnuovoIstitutoPFP := AnuovoIstitutoPfp_type;
  FnuovoIstitutoPFP_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoPFP_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoPFP_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoPEMCumulati(Index: Integer; const AnuovoIstitutoPemCumulati_type: nuovoIstitutoPemCumulati_type);
begin
  FnuovoIstitutoPEMCumulati := AnuovoIstitutoPemCumulati_type;
  FnuovoIstitutoPEMCumulati_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoPEMCumulati_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoPEMCumulati_Specified;
end;

procedure inserimentoIstituto.SetnuovoIstitutoPEMRSUCumulati(Index: Integer; const AnuovoIstitutoPemRsuCumulati_type: nuovoIstitutoPemRsuCumulati_type);
begin
  FnuovoIstitutoPEMRSUCumulati := AnuovoIstitutoPemRsuCumulati_type;
  FnuovoIstitutoPEMRSUCumulati_Specified := True;
end;

function inserimentoIstituto.nuovoIstitutoPEMRSUCumulati_Specified(Index: Integer): boolean;
begin
  Result := FnuovoIstitutoPEMRSUCumulati_Specified;
end;

destructor esitoInserimentoIstituto.Destroy;
begin
  SysUtils.FreeAndNil(Fsuccess);
  inherited Destroy;
end;

procedure esitoInserimentoIstituto.Seterrori(Index: Integer; const Aerrori: errori);
begin
  Ferrori := Aerrori;
  Ferrori_Specified := True;
end;

function esitoInserimentoIstituto.errori_Specified(Index: Integer): boolean;
begin
  Result := Ferrori_Specified;
end;

procedure esitoInserimentoIstituto.Setwarning(Index: Integer; const Awarning: warning);
begin
  Fwarning := Awarning;
  Fwarning_Specified := True;
end;

function esitoInserimentoIstituto.warning_Specified(Index: Integer): boolean;
begin
  Result := Fwarning_Specified;
end;

procedure esitoInserimentoIstituto.Setsuccess(Index: Integer; const Asuccess: success);
begin
  Fsuccess := Asuccess;
  Fsuccess_Specified := True;
end;

function esitoInserimentoIstituto.success_Specified(Index: Integer): boolean;
begin
  Result := Fsuccess_Specified;
end;

destructor nuovoIstitutoPemRsuCumulati_type.Destroy;
begin
  SysUtils.FreeAndNil(ForeFruite);
  SysUtils.FreeAndNil(FminutiFruiti);
  SysUtils.FreeAndNil(Fdipendente);
  SysUtils.FreeAndNil(Fprovvedimento);
  inherited Destroy;
end;

destructor nuovoIstitutoPemCumulati_type.Destroy;
begin
  SysUtils.FreeAndNil(ForeFruite);
  SysUtils.FreeAndNil(FminutiFruiti);
  SysUtils.FreeAndNil(Fdipendente);
  SysUtils.FreeAndNil(Fprovvedimento);
  SysUtils.FreeAndNil(FsoggettoLegittimato);
  inherited Destroy;
end;

destructor wsdlResponse.Destroy;
begin
  SysUtils.FreeAndNil(FesitoInserimentoIstituto);
  inherited Destroy;
end;

destructor wsdlRequest.Destroy;
begin
  SysUtils.FreeAndNil(FinserimentoIstituto);
  inherited Destroy;
end;

destructor nuovoIstitutoDisCumAsp_type.Destroy;
begin
  SysUtils.FreeAndNil(Fdurata);
  SysUtils.FreeAndNil(Fdipendente);
  SysUtils.FreeAndNil(Fprovvedimento);
  SysUtils.FreeAndNil(FsoggettoLegittimato);
  inherited Destroy;
end;

destructor dipendente.Destroy;
begin
  SysUtils.FreeAndNil(FdataNascita);
  SysUtils.FreeAndNil(Fqualifica);
  SysUtils.FreeAndNil(Fdistaccamento);
  inherited Destroy;
end;

procedure dipendente.Setsesso(Index: Integer; const Asesso_type: sesso_type);
begin
  Fsesso := Asesso_type;
  Fsesso_Specified := True;
end;

function dipendente.sesso_Specified(Index: Integer): boolean;
begin
  Result := Fsesso_Specified;
end;

procedure dipendente.SetdataNascita(Index: Integer; const ATXSDate: TXSDate);
begin
  FdataNascita := ATXSDate;
  FdataNascita_Specified := True;
end;

function dipendente.dataNascita_Specified(Index: Integer): boolean;
begin
  Result := FdataNascita_Specified;
end;

procedure dipendente.SetcomuneNascita(Index: Integer; const Astring: string);
begin
  FcomuneNascita := Astring;
  FcomuneNascita_Specified := True;
end;

function dipendente.comuneNascita_Specified(Index: Integer): boolean;
begin
  Result := FcomuneNascita_Specified;
end;

procedure dipendente.Setdistaccamento(Index: Integer; const Adistaccamento: distaccamento);
begin
  Fdistaccamento := Adistaccamento;
  Fdistaccamento_Specified := True;
end;

function dipendente.distaccamento_Specified(Index: Integer): boolean;
begin
  Result := Fdistaccamento_Specified;
end;

destructor provvedimento.Destroy;
begin
  SysUtils.FreeAndNil(Fdata);
  SysUtils.FreeAndNil(Ftipo);
  inherited Destroy;
end;

procedure provvedimento.SetnumeroProtocollo(Index: Integer; const Astring: string);
begin
  FnumeroProtocollo := Astring;
  FnumeroProtocollo_Specified := True;
end;

function provvedimento.numeroProtocollo_Specified(Index: Integer): boolean;
begin
  Result := FnumeroProtocollo_Specified;
end;

procedure provvedimento.Setnote(Index: Integer; const Astring: string);
begin
  Fnote := Astring;
  Fnote_Specified := True;
end;

function provvedimento.note_Specified(Index: Integer): boolean;
begin
  Result := Fnote_Specified;
end;

destructor provvedimento2.Destroy;
begin
  SysUtils.FreeAndNil(Fdata);
  inherited Destroy;
end;

procedure provvedimento2.SetnumeroProtocollo(Index: Integer; const Astring: string);
begin
  FnumeroProtocollo := Astring;
  FnumeroProtocollo_Specified := True;
end;

function provvedimento2.numeroProtocollo_Specified(Index: Integer): boolean;
begin
  Result := FnumeroProtocollo_Specified;
end;

destructor provvedimento3.Destroy;
begin
  SysUtils.FreeAndNil(Fdata);
  inherited Destroy;
end;

procedure provvedimento3.SetnumeroProtocollo(Index: Integer; const Astring: string);
begin
  FnumeroProtocollo := Astring;
  FnumeroProtocollo_Specified := True;
end;

function provvedimento3.numeroProtocollo_Specified(Index: Integer): boolean;
begin
  Result := FnumeroProtocollo_Specified;
end;

destructor provvedimento4.Destroy;
begin
  SysUtils.FreeAndNil(Fdata);
  inherited Destroy;
end;

procedure provvedimento4.SetnumeroProtocollo(Index: Integer; const Astring: string);
begin
  FnumeroProtocollo := Astring;
  FnumeroProtocollo_Specified := True;
end;

function provvedimento4.numeroProtocollo_Specified(Index: Integer): boolean;
begin
  Result := FnumeroProtocollo_Specified;
end;

destructor nuovoIstitutoPfp_type.Destroy;
begin
  SysUtils.FreeAndNil(ForeTotali);
  SysUtils.FreeAndNil(FminutiResidui);
  SysUtils.FreeAndNil(Fcausale);
  SysUtils.FreeAndNil(Fdipendente);
  inherited Destroy;
end;

destructor nuovoIstitutoAfp_type.Destroy;
begin
  SysUtils.FreeAndNil(FgiorniTotali);
  SysUtils.FreeAndNil(Fcausale);
  SysUtils.FreeAndNil(Fdipendente);
  inherited Destroy;
end;

destructor soggettoLegittimato.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FconfederazioniCollegate)-1 do
    SysUtils.FreeAndNil(FconfederazioniCollegate[I]);
  System.SetLength(FconfederazioniCollegate, 0);
  inherited Destroy;
end;

procedure soggettoLegittimato.Setsigla(Index: Integer; const Astring: string);
begin
  Fsigla := Astring;
  Fsigla_Specified := True;
end;

function soggettoLegittimato.sigla_Specified(Index: Integer): boolean;
begin
  Result := Fsigla_Specified;
end;

procedure soggettoLegittimato.Setdenominazione(Index: Integer; const Astring: string);
begin
  Fdenominazione := Astring;
  Fdenominazione_Specified := True;
end;

function soggettoLegittimato.denominazione_Specified(Index: Integer): boolean;
begin
  Result := Fdenominazione_Specified;
end;

procedure soggettoLegittimato.Setcomune(Index: Integer; const Astring: string);
begin
  Fcomune := Astring;
  Fcomune_Specified := True;
end;

function soggettoLegittimato.comune_Specified(Index: Integer): boolean;
begin
  Result := Fcomune_Specified;
end;

procedure soggettoLegittimato.Setindirizzo(Index: Integer; const Astring: string);
begin
  Findirizzo := Astring;
  Findirizzo_Specified := True;
end;

function soggettoLegittimato.indirizzo_Specified(Index: Integer): boolean;
begin
  Result := Findirizzo_Specified;
end;

procedure soggettoLegittimato.Setcap(Index: Integer; const Astring: string);
begin
  Fcap := Astring;
  Fcap_Specified := True;
end;

function soggettoLegittimato.cap_Specified(Index: Integer): boolean;
begin
  Result := Fcap_Specified;
end;

procedure soggettoLegittimato.Settelefono(Index: Integer; const Astring: string);
begin
  Ftelefono := Astring;
  Ftelefono_Specified := True;
end;

function soggettoLegittimato.telefono_Specified(Index: Integer): boolean;
begin
  Result := Ftelefono_Specified;
end;

procedure soggettoLegittimato.Setfax(Index: Integer; const Astring: string);
begin
  Ffax := Astring;
  Ffax_Specified := True;
end;

function soggettoLegittimato.fax_Specified(Index: Integer): boolean;
begin
  Result := Ffax_Specified;
end;

procedure soggettoLegittimato.Setemail(Index: Integer; const Astring: string);
begin
  Femail := Astring;
  Femail_Specified := True;
end;

function soggettoLegittimato.email_Specified(Index: Integer): boolean;
begin
  Result := Femail_Specified;
end;

procedure soggettoLegittimato.Settipo(Index: Integer; const AInt64: Int64);
begin
  Ftipo := AInt64;
  Ftipo_Specified := True;
end;

function soggettoLegittimato.tipo_Specified(Index: Integer): boolean;
begin
  Result := Ftipo_Specified;
end;

procedure soggettoLegittimato.SetconfederazioniCollegate(Index: Integer; const AconfederazioniCollegate: confederazioniCollegate);
begin
  FconfederazioniCollegate := AconfederazioniCollegate;
  FconfederazioniCollegate_Specified := True;
end;

function soggettoLegittimato.confederazioniCollegate_Specified(Index: Integer): boolean;
begin
  Result := FconfederazioniCollegate_Specified;
end;

destructor provvedimento5.Destroy;
begin
  SysUtils.FreeAndNil(Fdata);
  inherited Destroy;
end;

procedure provvedimento5.SetnumeroProtocollo(Index: Integer; const Astring: string);
begin
  FnumeroProtocollo := Astring;
  FnumeroProtocollo_Specified := True;
end;

function provvedimento5.numeroProtocollo_Specified(Index: Integer): boolean;
begin
  Result := FnumeroProtocollo_Specified;
end;

destructor nuovoIstitutoPemProPnr_type.Destroy;
begin
  SysUtils.FreeAndNil(ForaInizio);
  SysUtils.FreeAndNil(ForaFine);
  SysUtils.FreeAndNil(Fdipendente);
  SysUtils.FreeAndNil(Fprovvedimento);
  SysUtils.FreeAndNil(FsoggettoLegittimato);
  inherited Destroy;
end;

destructor nuovoIstitutoPemPnrRsu_type.Destroy;
begin
  SysUtils.FreeAndNil(ForaInizio);
  SysUtils.FreeAndNil(ForaFine);
  SysUtils.FreeAndNil(Fdipendente);
  SysUtils.FreeAndNil(Fprovvedimento);
  inherited Destroy;
end;

initialization
  { GEDAP }
  InvRegistry.RegisterInterface(TypeInfo(GEDAP), 'http://com.accenture.perla.it/gedap', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(GEDAP), 'InserimentoIstituti');
  InvRegistry.RegisterInvokeOptions(TypeInfo(GEDAP), ioDocument);
  { GEDAP.InserimentoIstituti }
  InvRegistry.RegisterMethodInfo(TypeInfo(GEDAP), 'InserimentoIstituti', '',
                                 '[ReturnName="wsdlResponse"]', IS_OPTN or IS_REF);
  InvRegistry.RegisterParamInfo(TypeInfo(GEDAP), 'InserimentoIstituti', 'wsdlRequest', '',
                                '[Namespace="http://com.accenture.perla.it/gedap_inserimentoistituti"]', IS_REF);
  InvRegistry.RegisterParamInfo(TypeInfo(GEDAP), 'InserimentoIstituti', 'wsdlResponse', '',
                                '[Namespace="http://com.accenture.perla.it/gedap_inserimentoistituti"]', IS_REF);
  RemClassRegistry.RegisterXSInfo(TypeInfo(sesso_type), 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'sesso_type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(esito_type), 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'esito_type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(confederazioniCollegate), 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'confederazioniCollegate');
  RemClassRegistry.RegisterXSClass(inserimentoIstituto, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'inserimentoIstituto');
  RemClassRegistry.RegisterXSInfo(TypeInfo(errori), 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'errori');
  RemClassRegistry.RegisterXSClass(success, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'success');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(success), 'descrizione', '[ArrayItemName="descrizione"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(success), 'idRilevazione', '[ArrayItemName="descrizione"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(warning), 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'warning');
  RemClassRegistry.RegisterXSClass(esitoInserimentoIstituto, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'esitoInserimentoIstituto');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(esitoInserimentoIstituto), 'errori', '[ArrayItemName="descrizione"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(esitoInserimentoIstituto), 'warning', '[ArrayItemName="descrizione"]');
  RemClassRegistry.RegisterXSClass(confederazione, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'confederazione');
  RemClassRegistry.RegisterXSClass(distaccamento, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'distaccamento');
  RemClassRegistry.RegisterXSClass(nuovoIstitutoPemRsuCumulati_type, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'nuovoIstitutoPemRsuCumulati_type');
  RemClassRegistry.RegisterXSClass(nuovoIstitutoPemCumulati_type, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'nuovoIstitutoPemCumulati_type');
  RemClassRegistry.RegisterXSClass(wsdlResponse, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'wsdlResponse');
  RemClassRegistry.RegisterXSClass(wsdlRequest, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'wsdlRequest');
  RemClassRegistry.RegisterXSClass(nuovoIstitutoDisCumAsp_type, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'nuovoIstitutoDisCumAsp_type');
  RemClassRegistry.RegisterXSClass(dipendente, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'dipendente');
  RemClassRegistry.RegisterXSClass(provvedimento, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'provvedimento');
  RemClassRegistry.RegisterXSClass(provvedimento2, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'provvedimento2', 'provvedimento');
  RemClassRegistry.RegisterXSClass(provvedimento3, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'provvedimento3', 'provvedimento');
  RemClassRegistry.RegisterXSClass(provvedimento4, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'provvedimento4', 'provvedimento');
  RemClassRegistry.RegisterXSClass(nuovoIstitutoPfp_type, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'nuovoIstitutoPfp_type');
  RemClassRegistry.RegisterXSClass(nuovoIstitutoAfp_type, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'nuovoIstitutoAfp_type');
  RemClassRegistry.RegisterXSClass(soggettoLegittimato, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'soggettoLegittimato');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(soggettoLegittimato), 'confederazioniCollegate', '[ArrayItemName="confederazione"]');
  RemClassRegistry.RegisterXSClass(provvedimento5, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'provvedimento5', 'provvedimento');
  RemClassRegistry.RegisterXSClass(nuovoIstitutoPemProPnr_type, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'nuovoIstitutoPemProPnr_type');
  RemClassRegistry.RegisterXSClass(nuovoIstitutoPemPnrRsu_type, 'http://com.accenture.perla.it/gedap_inserimentoistituti', 'nuovoIstitutoPemPnrRsu_type');

end.