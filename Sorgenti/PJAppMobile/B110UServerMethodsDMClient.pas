// 
// Created by the DataSnap proxy generator.
// 13/12/2019 09.47.04
// 

unit B110UServerMethodsDMClient;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, B110USharedTypes, C200UWebServicesTypes, A000UCostanti, Data.DBXJSONReflect;

type

  IDSRestCachedTRisultato = interface;

  TB110FServerMethodsDMClient = class(TDSAdminRestClient)
  private
    FEchoCommand: TDSRestCommand;
    FInfoServerCommand: TDSRestCommand;
    FInfoServerCommand_Cache: TDSRestCommand;
    FWebServiceEnteCommand: TDSRestCommand;
    FWebServiceEnteCommand_Cache: TDSRestCommand;
    FCheckAutenticazioneCommand: TDSRestCommand;
    FCheckAutenticazioneCommand_Cache: TDSRestCommand;
    FVersioneServerCommand: TDSRestCommand;
    FVersioneServerCommand_Cache: TDSRestCommand;
    FDatiGeneraliCommand: TDSRestCommand;
    FDatiGeneraliCommand_Cache: TDSRestCommand;
    FRichiesteGiustCommand: TDSRestCommand;
    FRichiesteGiustCommand_Cache: TDSRestCommand;
    FAutorizzaRichiestaGiustCommand: TDSRestCommand;
    FAutorizzaRichiestaGiustCommand_Cache: TDSRestCommand;
    FRichiesteGiustDipCommand: TDSRestCommand;
    FRichiesteGiustDipCommand_Cache: TDSRestCommand;
    FInsRichiestaGiustCommand: TDSRestCommand;
    FInsRichiestaGiustCommand_Cache: TDSRestCommand;
    FCancRichiestaGiustCommand: TDSRestCommand;
    FCancRichiestaGiustCommand_Cache: TDSRestCommand;
    FRevocaRichiestaGiustCommand: TDSRestCommand;
    FRevocaRichiestaGiustCommand_Cache: TDSRestCommand;
    FCartelliniCommand: TDSRestCommand;
    FCartelliniCommand_Cache: TDSRestCommand;
    FCartellinoCommand: TDSRestCommand;
    FCartellinoCommand_Cache: TDSRestCommand;
    FCedoliniCommand: TDSRestCommand;
    FCedoliniCommand_Cache: TDSRestCommand;
    FCedolinoCommand: TDSRestCommand;
    FCedolinoCommand_Cache: TDSRestCommand;
    FImpostaDataConsegnaCedolinoCommand: TDSRestCommand;
    FImpostaDataConsegnaCedolinoCommand_Cache: TDSRestCommand;
    FRichiesteTimbCommand: TDSRestCommand;
    FRichiesteTimbCommand_Cache: TDSRestCommand;
    FAutorizzaRichiestaTimbCommand: TDSRestCommand;
    FAutorizzaRichiestaTimbCommand_Cache: TDSRestCommand;
    FRichiesteTimbDipCommand: TDSRestCommand;
    FRichiesteTimbDipCommand_Cache: TDSRestCommand;
    FTimbModificabiliCommand: TDSRestCommand;
    FTimbModificabiliCommand_Cache: TDSRestCommand;
    FInsRichiestaTimbCommand: TDSRestCommand;
    FInsRichiestaTimbCommand_Cache: TDSRestCommand;
    FCancRichiestaTimbCommand: TDSRestCommand;
    FCancRichiestaTimbCommand_Cache: TDSRestCommand;
    FNoteRichiestaCommand: TDSRestCommand;
    FNoteRichiestaCommand_Cache: TDSRestCommand;
    FSetNoteRichiestaCommand: TDSRestCommand;
    FSetNoteRichiestaCommand_Cache: TDSRestCommand;
    FRiepilogoAssenzeCommand: TDSRestCommand;
    FRiepilogoAssenzeCommand_Cache: TDSRestCommand;
    FDipendentiCommand: TDSRestCommand;
    FDipendentiCommand_Cache: TDSRestCommand;
    FDatiGiornalieriCommand: TDSRestCommand;
    FDatiGiornalieriCommand_Cache: TDSRestCommand;
    FTimbratureCommand: TDSRestCommand;
    FTimbratureCommand_Cache: TDSRestCommand;
    FInsTimbraturaCommand: TDSRestCommand;
    FInsTimbraturaCommand_Cache: TDSRestCommand;
    FDizionarioCommand: TDSRestCommand;
    FDizionarioCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function Echo(S: string; const ARequestFilter: string = ''): string;
    function InfoServer(InfoClient: TInfoClient; Dato: string; const ARequestFilter: string = ''): TRisultato;
    function InfoServer_Cache(InfoClient: TInfoClient; Dato: string; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function WebServiceEnte(InfoClient: TInfoClient; IdAzienda: string; const ARequestFilter: string = ''): TRisultato;
    function WebServiceEnte_Cache(InfoClient: TInfoClient; IdAzienda: string; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function CheckAutenticazione(InfoClient: TInfoClient; DatiLogin: TParametriLogin; const ARequestFilter: string = ''): TRisultato;
    function CheckAutenticazione_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function VersioneServer(TipoVersione: string; const ARequestFilter: string = ''): TRisultato;
    function VersioneServer_Cache(TipoVersione: string; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function DatiGenerali(InfoClient: TInfoClient; DatiLogin: TParametriLogin; const ARequestFilter: string = ''): TRisultato;
    function DatiGenerali_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function RichiesteGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string = ''): TRisultato;
    function RichiesteGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function AutorizzaRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; Autorizzazione: string; const ARequestFilter: string = ''): TRisultato;
    function AutorizzaRichiestaGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; Autorizzazione: string; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function RichiesteGiustDip(InfoClient: TInfoClient; DatiLogin: TParametriLogin; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string = ''): TRisultato;
    function RichiesteGiustDip_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function InsRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; const ARequestFilter: string = ''): TRisultato;
    function InsRichiestaGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function CancRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; const ARequestFilter: string = ''): TRisultato;
    function CancRichiestaGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function RevocaRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; TipoRichiesta: string; Dal: TDateTime; Al: TDateTime; const ARequestFilter: string = ''): TRisultato;
    function RevocaRichiestaGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; TipoRichiesta: string; Dal: TDateTime; Al: TDateTime; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function Cartellini(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroCartellini: Boolean; DataInizio: TDateTime; DataFine: TDateTime; const ARequestFilter: string = ''): TRisultato;
    function Cartellini_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroCartellini: Boolean; DataInizio: TDateTime; DataFine: TDateTime; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function Cartellino(InfoClient: TInfoClient; DatiLogin: TParametriLogin; MeseCartellino: TDateTime; CodParamStampa: string; const ARequestFilter: string = ''): TRisultato;
    function Cartellino_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; MeseCartellino: TDateTime; CodParamStampa: string; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function Cedolini(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroCedolini: Boolean; DataInizio: TDateTime; DataFine: TDateTime; const ARequestFilter: string = ''): TRisultato;
    function Cedolini_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroCedolini: Boolean; DataInizio: TDateTime; DataFine: TDateTime; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function Cedolino(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdCedolino: Integer; CumuloVociArretrate: Boolean; StampaOrigineVoci: Boolean; const ARequestFilter: string = ''): TRisultato;
    function Cedolino_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdCedolino: Integer; CumuloVociArretrate: Boolean; StampaOrigineVoci: Boolean; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function ImpostaDataConsegnaCedolino(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdCedolino: Integer; const ARequestFilter: string = ''): TRisultato;
    function ImpostaDataConsegnaCedolino_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdCedolino: Integer; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function RichiesteTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string = ''): TRisultato;
    function RichiesteTimb_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function AutorizzaRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; Autorizzazione: string; const ARequestFilter: string = ''): TRisultato;
    function AutorizzaRichiestaTimb_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; Autorizzazione: string; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function RichiesteTimbDip(InfoClient: TInfoClient; DatiLogin: TParametriLogin; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string = ''): TRisultato;
    function RichiesteTimbDip_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function TimbModificabili(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DataRif: TDateTime; const ARequestFilter: string = ''): TRisultato;
    function TimbModificabili_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DataRif: TDateTime; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function InsRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiTimb: TDatiRichiestaTimb; const ARequestFilter: string = ''): TRisultato;
    function InsRichiestaTimb_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiTimb: TDatiRichiestaTimb; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function CancRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; const ARequestFilter: string = ''): TRisultato;
    function CancRichiestaTimb_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function NoteRichiesta(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; const ARequestFilter: string = ''): TRisultato;
    function NoteRichiesta_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function SetNoteRichiesta(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; NoteLivello: TNoteLivello; const ARequestFilter: string = ''): TRisultato;
    function SetNoteRichiesta_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; NoteLivello: TNoteLivello; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function RiepilogoAssenze(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Progressivo: Integer; Causale: string; Data: TDateTime; DataFamiliare: TDateTime; const ARequestFilter: string = ''): TRisultato;
    function RiepilogoAssenze_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Progressivo: Integer; Causale: string; Data: TDateTime; DataFamiliare: TDateTime; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function Dipendenti(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DataRiferimento: TDateTime; const ARequestFilter: string = ''): TRisultato;
    function Dipendenti_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DataRiferimento: TDateTime; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function DatiGiornalieri(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Data: TDateTime; const ARequestFilter: string = ''): TRisultato;
    function DatiGiornalieri_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Data: TDateTime; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function Timbrature(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Dal: TDateTime; Al: TDateTime; const ARequestFilter: string = ''): TRisultato;
    function Timbrature_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Dal: TDateTime; Al: TDateTime; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function InsTimbratura(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiTimbratura: TDatiTimbratura; const ARequestFilter: string = ''): TRisultato;
    function InsTimbratura_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiTimbratura: TDatiTimbratura; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function Dizionario(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Tabella: string; Param1: string; ApplicaFiltroDizionario: Boolean; const ARequestFilter: string = ''): TRisultato;
    function Dizionario_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Tabella: string; Param1: string; ApplicaFiltroDizionario: Boolean; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
  end;

  IDSRestCachedTRisultato = interface(IDSRestCachedObject<TRisultato>)
  end;

  TDSRestCachedTRisultato = class(TDSRestCachedObject<TRisultato>, IDSRestCachedTRisultato, IDSRestCachedCommand)
  end;

const
  TB110FServerMethodsDM_Echo: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'S'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TB110FServerMethodsDM_InfoServer: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'Dato'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_InfoServer_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'Dato'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_WebServiceEnte: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'IdAzienda'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_WebServiceEnte_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'IdAzienda'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_CheckAutenticazione: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_CheckAutenticazione_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_VersioneServer: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'TipoVersione'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_VersioneServer_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'TipoVersione'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_DatiGenerali: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_DatiGenerali_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_RichiesteGiust: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'SoloNumeroRichieste'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'FiltroRichieste'; Direction: 1; DBXType: 37; TypeName: 'TFiltriRichieste'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_RichiesteGiust_Cache: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'SoloNumeroRichieste'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'FiltroRichieste'; Direction: 1; DBXType: 37; TypeName: 'TFiltriRichieste'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_AutorizzaRichiestaGiust: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Autorizzazione'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_AutorizzaRichiestaGiust_Cache: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Autorizzazione'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_RichiesteGiustDip: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'FiltroRichieste'; Direction: 1; DBXType: 37; TypeName: 'TFiltriRichieste'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_RichiesteGiustDip_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'FiltroRichieste'; Direction: 1; DBXType: 37; TypeName: 'TFiltriRichieste'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_InsRichiestaGiust: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiGiust'; Direction: 1; DBXType: 37; TypeName: 'TDatiRichiestaGiust'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_InsRichiestaGiust_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiGiust'; Direction: 1; DBXType: 37; TypeName: 'TDatiRichiestaGiust'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_CancRichiestaGiust: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiGiust'; Direction: 1; DBXType: 37; TypeName: 'TDatiRichiestaGiust'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_CancRichiestaGiust_Cache: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiGiust'; Direction: 1; DBXType: 37; TypeName: 'TDatiRichiestaGiust'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_RevocaRichiestaGiust: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiGiust'; Direction: 1; DBXType: 37; TypeName: 'TDatiRichiestaGiust'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'TipoRichiesta'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Dal'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'Al'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_RevocaRichiestaGiust_Cache: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiGiust'; Direction: 1; DBXType: 37; TypeName: 'TDatiRichiestaGiust'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'TipoRichiesta'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Dal'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'Al'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_Cartellini: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'SoloNumeroCartellini'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'DataInizio'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'DataFine'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_Cartellini_Cache: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'SoloNumeroCartellini'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'DataInizio'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'DataFine'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_Cartellino: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'MeseCartellino'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'CodParamStampa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_Cartellino_Cache: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'MeseCartellino'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'CodParamStampa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_Cedolini: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'SoloNumeroCedolini'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'DataInizio'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'DataFine'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_Cedolini_Cache: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'SoloNumeroCedolini'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'DataInizio'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'DataFine'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_Cedolino: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdCedolino'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'CumuloVociArretrate'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'StampaOrigineVoci'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_Cedolino_Cache: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdCedolino'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'CumuloVociArretrate'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'StampaOrigineVoci'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_ImpostaDataConsegnaCedolino: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdCedolino'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_ImpostaDataConsegnaCedolino_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdCedolino'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_RichiesteTimb: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'SoloNumeroRichieste'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'FiltroRichieste'; Direction: 1; DBXType: 37; TypeName: 'TFiltriRichieste'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_RichiesteTimb_Cache: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'SoloNumeroRichieste'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: 'FiltroRichieste'; Direction: 1; DBXType: 37; TypeName: 'TFiltriRichieste'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_AutorizzaRichiestaTimb: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Autorizzazione'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_AutorizzaRichiestaTimb_Cache: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Autorizzazione'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_RichiesteTimbDip: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'FiltroRichieste'; Direction: 1; DBXType: 37; TypeName: 'TFiltriRichieste'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_RichiesteTimbDip_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'FiltroRichieste'; Direction: 1; DBXType: 37; TypeName: 'TFiltriRichieste'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_TimbModificabili: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DataRif'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_TimbModificabili_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DataRif'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_InsRichiestaTimb: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiTimb'; Direction: 1; DBXType: 37; TypeName: 'TDatiRichiestaTimb'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_InsRichiestaTimb_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiTimb'; Direction: 1; DBXType: 37; TypeName: 'TDatiRichiestaTimb'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_CancRichiestaTimb: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_CancRichiestaTimb_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_NoteRichiesta: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_NoteRichiesta_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_SetNoteRichiesta: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'NoteLivello'; Direction: 1; DBXType: 37; TypeName: 'TNoteLivello'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_SetNoteRichiesta_Cache: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'IdRichiesta'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'NoteLivello'; Direction: 1; DBXType: 37; TypeName: 'TNoteLivello'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_RiepilogoAssenze: array [0..6] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'Progressivo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Causale'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Data'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'DataFamiliare'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_RiepilogoAssenze_Cache: array [0..6] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'Progressivo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Causale'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Data'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'DataFamiliare'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_Dipendenti: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DataRiferimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_Dipendenti_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DataRiferimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_DatiGiornalieri: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'Data'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_DatiGiornalieri_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'Data'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_Timbrature: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'Dal'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'Al'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_Timbrature_Cache: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'Dal'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'Al'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_InsTimbratura: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiTimbratura'; Direction: 1; DBXType: 37; TypeName: 'TDatiTimbratura'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_InsTimbratura_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'DatiTimbratura'; Direction: 1; DBXType: 37; TypeName: 'TDatiTimbratura'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_Dizionario: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'Tabella'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Param1'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ApplicaFiltroDizionario'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_Dizionario_Cache: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'InfoClient'; Direction: 1; DBXType: 37; TypeName: 'TInfoClient'),
    (Name: 'DatiLogin'; Direction: 1; DBXType: 37; TypeName: 'TParametriLogin'),
    (Name: 'Tabella'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Param1'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ApplicaFiltroDizionario'; Direction: 1; DBXType: 4; TypeName: 'Boolean'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

function TB110FServerMethodsDMClient.Echo(S: string; const ARequestFilter: string): string;
begin
  if FEchoCommand = nil then
  begin
    FEchoCommand := FConnection.CreateCommand;
    FEchoCommand.RequestType := 'GET';
    FEchoCommand.Text := 'TB110FServerMethodsDM.Echo';
    FEchoCommand.Prepare(TB110FServerMethodsDM_Echo);
  end;
  FEchoCommand.Parameters[0].Value.SetWideString(S);
  FEchoCommand.Execute(ARequestFilter);
  Result := FEchoCommand.Parameters[1].Value.GetWideString;
end;

function TB110FServerMethodsDMClient.InfoServer(InfoClient: TInfoClient; Dato: string; const ARequestFilter: string): TRisultato;
begin
  if FInfoServerCommand = nil then
  begin
    FInfoServerCommand := FConnection.CreateCommand;
    FInfoServerCommand.RequestType := 'POST';
    FInfoServerCommand.Text := 'TB110FServerMethodsDM."InfoServer"';
    FInfoServerCommand.Prepare(TB110FServerMethodsDM_InfoServer);
  end;
  if not Assigned(InfoClient) then
    FInfoServerCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInfoServerCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInfoServerCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInfoServerCommand.Parameters[1].Value.SetWideString(Dato);
  FInfoServerCommand.Execute(ARequestFilter);
  if not FInfoServerCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FInfoServerCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FInfoServerCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FInfoServerCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.InfoServer_Cache(InfoClient: TInfoClient; Dato: string; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FInfoServerCommand_Cache = nil then
  begin
    FInfoServerCommand_Cache := FConnection.CreateCommand;
    FInfoServerCommand_Cache.RequestType := 'POST';
    FInfoServerCommand_Cache.Text := 'TB110FServerMethodsDM."InfoServer"';
    FInfoServerCommand_Cache.Prepare(TB110FServerMethodsDM_InfoServer_Cache);
  end;
  if not Assigned(InfoClient) then
    FInfoServerCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInfoServerCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInfoServerCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInfoServerCommand_Cache.Parameters[1].Value.SetWideString(Dato);
  FInfoServerCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FInfoServerCommand_Cache.Parameters[2].Value.GetString);
end;

function TB110FServerMethodsDMClient.WebServiceEnte(InfoClient: TInfoClient; IdAzienda: string; const ARequestFilter: string): TRisultato;
begin
  if FWebServiceEnteCommand = nil then
  begin
    FWebServiceEnteCommand := FConnection.CreateCommand;
    FWebServiceEnteCommand.RequestType := 'POST';
    FWebServiceEnteCommand.Text := 'TB110FServerMethodsDM."WebServiceEnte"';
    FWebServiceEnteCommand.Prepare(TB110FServerMethodsDM_WebServiceEnte);
  end;
  if not Assigned(InfoClient) then
    FWebServiceEnteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FWebServiceEnteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FWebServiceEnteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FWebServiceEnteCommand.Parameters[1].Value.SetWideString(IdAzienda);
  FWebServiceEnteCommand.Execute(ARequestFilter);
  if not FWebServiceEnteCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FWebServiceEnteCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FWebServiceEnteCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FWebServiceEnteCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.WebServiceEnte_Cache(InfoClient: TInfoClient; IdAzienda: string; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FWebServiceEnteCommand_Cache = nil then
  begin
    FWebServiceEnteCommand_Cache := FConnection.CreateCommand;
    FWebServiceEnteCommand_Cache.RequestType := 'POST';
    FWebServiceEnteCommand_Cache.Text := 'TB110FServerMethodsDM."WebServiceEnte"';
    FWebServiceEnteCommand_Cache.Prepare(TB110FServerMethodsDM_WebServiceEnte_Cache);
  end;
  if not Assigned(InfoClient) then
    FWebServiceEnteCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FWebServiceEnteCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FWebServiceEnteCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FWebServiceEnteCommand_Cache.Parameters[1].Value.SetWideString(IdAzienda);
  FWebServiceEnteCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FWebServiceEnteCommand_Cache.Parameters[2].Value.GetString);
end;

function TB110FServerMethodsDMClient.CheckAutenticazione(InfoClient: TInfoClient; DatiLogin: TParametriLogin; const ARequestFilter: string): TRisultato;
begin
  if FCheckAutenticazioneCommand = nil then
  begin
    FCheckAutenticazioneCommand := FConnection.CreateCommand;
    FCheckAutenticazioneCommand.RequestType := 'POST';
    FCheckAutenticazioneCommand.Text := 'TB110FServerMethodsDM."CheckAutenticazione"';
    FCheckAutenticazioneCommand.Prepare(TB110FServerMethodsDM_CheckAutenticazione);
  end;
  if not Assigned(InfoClient) then
    FCheckAutenticazioneCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCheckAutenticazioneCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCheckAutenticazioneCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCheckAutenticazioneCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCheckAutenticazioneCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCheckAutenticazioneCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCheckAutenticazioneCommand.Execute(ARequestFilter);
  if not FCheckAutenticazioneCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FCheckAutenticazioneCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FCheckAutenticazioneCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCheckAutenticazioneCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.CheckAutenticazione_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FCheckAutenticazioneCommand_Cache = nil then
  begin
    FCheckAutenticazioneCommand_Cache := FConnection.CreateCommand;
    FCheckAutenticazioneCommand_Cache.RequestType := 'POST';
    FCheckAutenticazioneCommand_Cache.Text := 'TB110FServerMethodsDM."CheckAutenticazione"';
    FCheckAutenticazioneCommand_Cache.Prepare(TB110FServerMethodsDM_CheckAutenticazione_Cache);
  end;
  if not Assigned(InfoClient) then
    FCheckAutenticazioneCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCheckAutenticazioneCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCheckAutenticazioneCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCheckAutenticazioneCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCheckAutenticazioneCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCheckAutenticazioneCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCheckAutenticazioneCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FCheckAutenticazioneCommand_Cache.Parameters[2].Value.GetString);
end;

function TB110FServerMethodsDMClient.VersioneServer(TipoVersione: string; const ARequestFilter: string): TRisultato;
begin
  if FVersioneServerCommand = nil then
  begin
    FVersioneServerCommand := FConnection.CreateCommand;
    FVersioneServerCommand.RequestType := 'GET';
    FVersioneServerCommand.Text := 'TB110FServerMethodsDM.VersioneServer';
    FVersioneServerCommand.Prepare(TB110FServerMethodsDM_VersioneServer);
  end;
  FVersioneServerCommand.Parameters[0].Value.SetWideString(TipoVersione);
  FVersioneServerCommand.Execute(ARequestFilter);
  if not FVersioneServerCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FVersioneServerCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FVersioneServerCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FVersioneServerCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.VersioneServer_Cache(TipoVersione: string; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FVersioneServerCommand_Cache = nil then
  begin
    FVersioneServerCommand_Cache := FConnection.CreateCommand;
    FVersioneServerCommand_Cache.RequestType := 'GET';
    FVersioneServerCommand_Cache.Text := 'TB110FServerMethodsDM.VersioneServer';
    FVersioneServerCommand_Cache.Prepare(TB110FServerMethodsDM_VersioneServer_Cache);
  end;
  FVersioneServerCommand_Cache.Parameters[0].Value.SetWideString(TipoVersione);
  FVersioneServerCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FVersioneServerCommand_Cache.Parameters[1].Value.GetString);
end;

function TB110FServerMethodsDMClient.DatiGenerali(InfoClient: TInfoClient; DatiLogin: TParametriLogin; const ARequestFilter: string): TRisultato;
begin
  if FDatiGeneraliCommand = nil then
  begin
    FDatiGeneraliCommand := FConnection.CreateCommand;
    FDatiGeneraliCommand.RequestType := 'POST';
    FDatiGeneraliCommand.Text := 'TB110FServerMethodsDM."DatiGenerali"';
    FDatiGeneraliCommand.Prepare(TB110FServerMethodsDM_DatiGenerali);
  end;
  if not Assigned(InfoClient) then
    FDatiGeneraliCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDatiGeneraliCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDatiGeneraliCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FDatiGeneraliCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDatiGeneraliCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FDatiGeneraliCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDatiGeneraliCommand.Execute(ARequestFilter);
  if not FDatiGeneraliCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FDatiGeneraliCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FDatiGeneraliCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FDatiGeneraliCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.DatiGenerali_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FDatiGeneraliCommand_Cache = nil then
  begin
    FDatiGeneraliCommand_Cache := FConnection.CreateCommand;
    FDatiGeneraliCommand_Cache.RequestType := 'POST';
    FDatiGeneraliCommand_Cache.Text := 'TB110FServerMethodsDM."DatiGenerali"';
    FDatiGeneraliCommand_Cache.Prepare(TB110FServerMethodsDM_DatiGenerali_Cache);
  end;
  if not Assigned(InfoClient) then
    FDatiGeneraliCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDatiGeneraliCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDatiGeneraliCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FDatiGeneraliCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDatiGeneraliCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FDatiGeneraliCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDatiGeneraliCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FDatiGeneraliCommand_Cache.Parameters[2].Value.GetString);
end;

function TB110FServerMethodsDMClient.RichiesteGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string): TRisultato;
begin
  if FRichiesteGiustCommand = nil then
  begin
    FRichiesteGiustCommand := FConnection.CreateCommand;
    FRichiesteGiustCommand.RequestType := 'POST';
    FRichiesteGiustCommand.Text := 'TB110FServerMethodsDM."RichiesteGiust"';
    FRichiesteGiustCommand.Prepare(TB110FServerMethodsDM_RichiesteGiust);
  end;
  if not Assigned(InfoClient) then
    FRichiesteGiustCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRichiesteGiustCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteGiustCommand.Parameters[2].Value.SetBoolean(SoloNumeroRichieste);
  if not Assigned(FiltroRichieste) then
    FRichiesteGiustCommand.Parameters[3].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustCommand.Parameters[3].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustCommand.Parameters[3].Value.SetJSONValue(FMarshal.Marshal(FiltroRichieste), True);
      if FInstanceOwner then
        FiltroRichieste.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteGiustCommand.Execute(ARequestFilter);
  if not FRichiesteGiustCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FRichiesteGiustCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FRichiesteGiustCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FRichiesteGiustCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.RichiesteGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FRichiesteGiustCommand_Cache = nil then
  begin
    FRichiesteGiustCommand_Cache := FConnection.CreateCommand;
    FRichiesteGiustCommand_Cache.RequestType := 'POST';
    FRichiesteGiustCommand_Cache.Text := 'TB110FServerMethodsDM."RichiesteGiust"';
    FRichiesteGiustCommand_Cache.Prepare(TB110FServerMethodsDM_RichiesteGiust_Cache);
  end;
  if not Assigned(InfoClient) then
    FRichiesteGiustCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRichiesteGiustCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteGiustCommand_Cache.Parameters[2].Value.SetBoolean(SoloNumeroRichieste);
  if not Assigned(FiltroRichieste) then
    FRichiesteGiustCommand_Cache.Parameters[3].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustCommand_Cache.Parameters[3].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustCommand_Cache.Parameters[3].Value.SetJSONValue(FMarshal.Marshal(FiltroRichieste), True);
      if FInstanceOwner then
        FiltroRichieste.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteGiustCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FRichiesteGiustCommand_Cache.Parameters[4].Value.GetString);
end;

function TB110FServerMethodsDMClient.AutorizzaRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; Autorizzazione: string; const ARequestFilter: string): TRisultato;
begin
  if FAutorizzaRichiestaGiustCommand = nil then
  begin
    FAutorizzaRichiestaGiustCommand := FConnection.CreateCommand;
    FAutorizzaRichiestaGiustCommand.RequestType := 'POST';
    FAutorizzaRichiestaGiustCommand.Text := 'TB110FServerMethodsDM."AutorizzaRichiestaGiust"';
    FAutorizzaRichiestaGiustCommand.Prepare(TB110FServerMethodsDM_AutorizzaRichiestaGiust);
  end;
  if not Assigned(InfoClient) then
    FAutorizzaRichiestaGiustCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FAutorizzaRichiestaGiustCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FAutorizzaRichiestaGiustCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FAutorizzaRichiestaGiustCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FAutorizzaRichiestaGiustCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FAutorizzaRichiestaGiustCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FAutorizzaRichiestaGiustCommand.Parameters[2].Value.SetInt32(IdRichiesta);
  FAutorizzaRichiestaGiustCommand.Parameters[3].Value.SetWideString(Autorizzazione);
  FAutorizzaRichiestaGiustCommand.Execute(ARequestFilter);
  if not FAutorizzaRichiestaGiustCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FAutorizzaRichiestaGiustCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FAutorizzaRichiestaGiustCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FAutorizzaRichiestaGiustCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.AutorizzaRichiestaGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; Autorizzazione: string; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FAutorizzaRichiestaGiustCommand_Cache = nil then
  begin
    FAutorizzaRichiestaGiustCommand_Cache := FConnection.CreateCommand;
    FAutorizzaRichiestaGiustCommand_Cache.RequestType := 'POST';
    FAutorizzaRichiestaGiustCommand_Cache.Text := 'TB110FServerMethodsDM."AutorizzaRichiestaGiust"';
    FAutorizzaRichiestaGiustCommand_Cache.Prepare(TB110FServerMethodsDM_AutorizzaRichiestaGiust_Cache);
  end;
  if not Assigned(InfoClient) then
    FAutorizzaRichiestaGiustCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FAutorizzaRichiestaGiustCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FAutorizzaRichiestaGiustCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FAutorizzaRichiestaGiustCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FAutorizzaRichiestaGiustCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FAutorizzaRichiestaGiustCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FAutorizzaRichiestaGiustCommand_Cache.Parameters[2].Value.SetInt32(IdRichiesta);
  FAutorizzaRichiestaGiustCommand_Cache.Parameters[3].Value.SetWideString(Autorizzazione);
  FAutorizzaRichiestaGiustCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FAutorizzaRichiestaGiustCommand_Cache.Parameters[4].Value.GetString);
end;

function TB110FServerMethodsDMClient.RichiesteGiustDip(InfoClient: TInfoClient; DatiLogin: TParametriLogin; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string): TRisultato;
begin
  if FRichiesteGiustDipCommand = nil then
  begin
    FRichiesteGiustDipCommand := FConnection.CreateCommand;
    FRichiesteGiustDipCommand.RequestType := 'POST';
    FRichiesteGiustDipCommand.Text := 'TB110FServerMethodsDM."RichiesteGiustDip"';
    FRichiesteGiustDipCommand.Prepare(TB110FServerMethodsDM_RichiesteGiustDip);
  end;
  if not Assigned(InfoClient) then
    FRichiesteGiustDipCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustDipCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustDipCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRichiesteGiustDipCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustDipCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustDipCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(FiltroRichieste) then
    FRichiesteGiustDipCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustDipCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustDipCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(FiltroRichieste), True);
      if FInstanceOwner then
        FiltroRichieste.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteGiustDipCommand.Execute(ARequestFilter);
  if not FRichiesteGiustDipCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FRichiesteGiustDipCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FRichiesteGiustDipCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FRichiesteGiustDipCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.RichiesteGiustDip_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FRichiesteGiustDipCommand_Cache = nil then
  begin
    FRichiesteGiustDipCommand_Cache := FConnection.CreateCommand;
    FRichiesteGiustDipCommand_Cache.RequestType := 'POST';
    FRichiesteGiustDipCommand_Cache.Text := 'TB110FServerMethodsDM."RichiesteGiustDip"';
    FRichiesteGiustDipCommand_Cache.Prepare(TB110FServerMethodsDM_RichiesteGiustDip_Cache);
  end;
  if not Assigned(InfoClient) then
    FRichiesteGiustDipCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustDipCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustDipCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRichiesteGiustDipCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustDipCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustDipCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(FiltroRichieste) then
    FRichiesteGiustDipCommand_Cache.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteGiustDipCommand_Cache.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteGiustDipCommand_Cache.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(FiltroRichieste), True);
      if FInstanceOwner then
        FiltroRichieste.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteGiustDipCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FRichiesteGiustDipCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.InsRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; const ARequestFilter: string): TRisultato;
begin
  if FInsRichiestaGiustCommand = nil then
  begin
    FInsRichiestaGiustCommand := FConnection.CreateCommand;
    FInsRichiestaGiustCommand.RequestType := 'POST';
    FInsRichiestaGiustCommand.Text := 'TB110FServerMethodsDM."InsRichiestaGiust"';
    FInsRichiestaGiustCommand.Prepare(TB110FServerMethodsDM_InsRichiestaGiust);
  end;
  if not Assigned(InfoClient) then
    FInsRichiestaGiustCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaGiustCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaGiustCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FInsRichiestaGiustCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaGiustCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaGiustCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiGiust) then
    FInsRichiestaGiustCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaGiustCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaGiustCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiGiust), True);
      if FInstanceOwner then
        DatiGiust.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsRichiestaGiustCommand.Execute(ARequestFilter);
  if not FInsRichiestaGiustCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FInsRichiestaGiustCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FInsRichiestaGiustCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FInsRichiestaGiustCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.InsRichiestaGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FInsRichiestaGiustCommand_Cache = nil then
  begin
    FInsRichiestaGiustCommand_Cache := FConnection.CreateCommand;
    FInsRichiestaGiustCommand_Cache.RequestType := 'POST';
    FInsRichiestaGiustCommand_Cache.Text := 'TB110FServerMethodsDM."InsRichiestaGiust"';
    FInsRichiestaGiustCommand_Cache.Prepare(TB110FServerMethodsDM_InsRichiestaGiust_Cache);
  end;
  if not Assigned(InfoClient) then
    FInsRichiestaGiustCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaGiustCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaGiustCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FInsRichiestaGiustCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaGiustCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaGiustCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiGiust) then
    FInsRichiestaGiustCommand_Cache.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaGiustCommand_Cache.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaGiustCommand_Cache.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiGiust), True);
      if FInstanceOwner then
        DatiGiust.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsRichiestaGiustCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FInsRichiestaGiustCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.CancRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; const ARequestFilter: string): TRisultato;
begin
  if FCancRichiestaGiustCommand = nil then
  begin
    FCancRichiestaGiustCommand := FConnection.CreateCommand;
    FCancRichiestaGiustCommand.RequestType := 'POST';
    FCancRichiestaGiustCommand.Text := 'TB110FServerMethodsDM."CancRichiestaGiust"';
    FCancRichiestaGiustCommand.Prepare(TB110FServerMethodsDM_CancRichiestaGiust);
  end;
  if not Assigned(InfoClient) then
    FCancRichiestaGiustCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaGiustCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaGiustCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCancRichiestaGiustCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaGiustCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaGiustCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiGiust) then
    FCancRichiestaGiustCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaGiustCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaGiustCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiGiust), True);
      if FInstanceOwner then
        DatiGiust.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCancRichiestaGiustCommand.Parameters[3].Value.SetInt32(IdRichiesta);
  FCancRichiestaGiustCommand.Execute(ARequestFilter);
  if not FCancRichiestaGiustCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FCancRichiestaGiustCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FCancRichiestaGiustCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCancRichiestaGiustCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.CancRichiestaGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FCancRichiestaGiustCommand_Cache = nil then
  begin
    FCancRichiestaGiustCommand_Cache := FConnection.CreateCommand;
    FCancRichiestaGiustCommand_Cache.RequestType := 'POST';
    FCancRichiestaGiustCommand_Cache.Text := 'TB110FServerMethodsDM."CancRichiestaGiust"';
    FCancRichiestaGiustCommand_Cache.Prepare(TB110FServerMethodsDM_CancRichiestaGiust_Cache);
  end;
  if not Assigned(InfoClient) then
    FCancRichiestaGiustCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaGiustCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaGiustCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCancRichiestaGiustCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaGiustCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaGiustCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiGiust) then
    FCancRichiestaGiustCommand_Cache.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaGiustCommand_Cache.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaGiustCommand_Cache.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiGiust), True);
      if FInstanceOwner then
        DatiGiust.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCancRichiestaGiustCommand_Cache.Parameters[3].Value.SetInt32(IdRichiesta);
  FCancRichiestaGiustCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FCancRichiestaGiustCommand_Cache.Parameters[4].Value.GetString);
end;

function TB110FServerMethodsDMClient.RevocaRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; TipoRichiesta: string; Dal: TDateTime; Al: TDateTime; const ARequestFilter: string): TRisultato;
begin
  if FRevocaRichiestaGiustCommand = nil then
  begin
    FRevocaRichiestaGiustCommand := FConnection.CreateCommand;
    FRevocaRichiestaGiustCommand.RequestType := 'POST';
    FRevocaRichiestaGiustCommand.Text := 'TB110FServerMethodsDM."RevocaRichiestaGiust"';
    FRevocaRichiestaGiustCommand.Prepare(TB110FServerMethodsDM_RevocaRichiestaGiust);
  end;
  if not Assigned(InfoClient) then
    FRevocaRichiestaGiustCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRevocaRichiestaGiustCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRevocaRichiestaGiustCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRevocaRichiestaGiustCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRevocaRichiestaGiustCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRevocaRichiestaGiustCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiGiust) then
    FRevocaRichiestaGiustCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRevocaRichiestaGiustCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FRevocaRichiestaGiustCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiGiust), True);
      if FInstanceOwner then
        DatiGiust.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRevocaRichiestaGiustCommand.Parameters[3].Value.SetInt32(IdRichiesta);
  FRevocaRichiestaGiustCommand.Parameters[4].Value.SetWideString(TipoRichiesta);
  FRevocaRichiestaGiustCommand.Parameters[5].Value.AsDateTime := Dal;
  FRevocaRichiestaGiustCommand.Parameters[6].Value.AsDateTime := Al;
  FRevocaRichiestaGiustCommand.Execute(ARequestFilter);
  if not FRevocaRichiestaGiustCommand.Parameters[7].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FRevocaRichiestaGiustCommand.Parameters[7].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FRevocaRichiestaGiustCommand.Parameters[7].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FRevocaRichiestaGiustCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.RevocaRichiestaGiust_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; TipoRichiesta: string; Dal: TDateTime; Al: TDateTime; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FRevocaRichiestaGiustCommand_Cache = nil then
  begin
    FRevocaRichiestaGiustCommand_Cache := FConnection.CreateCommand;
    FRevocaRichiestaGiustCommand_Cache.RequestType := 'POST';
    FRevocaRichiestaGiustCommand_Cache.Text := 'TB110FServerMethodsDM."RevocaRichiestaGiust"';
    FRevocaRichiestaGiustCommand_Cache.Prepare(TB110FServerMethodsDM_RevocaRichiestaGiust_Cache);
  end;
  if not Assigned(InfoClient) then
    FRevocaRichiestaGiustCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRevocaRichiestaGiustCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRevocaRichiestaGiustCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRevocaRichiestaGiustCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRevocaRichiestaGiustCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRevocaRichiestaGiustCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiGiust) then
    FRevocaRichiestaGiustCommand_Cache.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRevocaRichiestaGiustCommand_Cache.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FRevocaRichiestaGiustCommand_Cache.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiGiust), True);
      if FInstanceOwner then
        DatiGiust.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRevocaRichiestaGiustCommand_Cache.Parameters[3].Value.SetInt32(IdRichiesta);
  FRevocaRichiestaGiustCommand_Cache.Parameters[4].Value.SetWideString(TipoRichiesta);
  FRevocaRichiestaGiustCommand_Cache.Parameters[5].Value.AsDateTime := Dal;
  FRevocaRichiestaGiustCommand_Cache.Parameters[6].Value.AsDateTime := Al;
  FRevocaRichiestaGiustCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FRevocaRichiestaGiustCommand_Cache.Parameters[7].Value.GetString);
end;

function TB110FServerMethodsDMClient.Cartellini(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroCartellini: Boolean; DataInizio: TDateTime; DataFine: TDateTime; const ARequestFilter: string): TRisultato;
begin
  if FCartelliniCommand = nil then
  begin
    FCartelliniCommand := FConnection.CreateCommand;
    FCartelliniCommand.RequestType := 'POST';
    FCartelliniCommand.Text := 'TB110FServerMethodsDM."Cartellini"';
    FCartelliniCommand.Prepare(TB110FServerMethodsDM_Cartellini);
  end;
  if not Assigned(InfoClient) then
    FCartelliniCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCartelliniCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCartelliniCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCartelliniCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCartelliniCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCartelliniCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCartelliniCommand.Parameters[2].Value.SetBoolean(SoloNumeroCartellini);
  FCartelliniCommand.Parameters[3].Value.AsDateTime := DataInizio;
  FCartelliniCommand.Parameters[4].Value.AsDateTime := DataFine;
  FCartelliniCommand.Execute(ARequestFilter);
  if not FCartelliniCommand.Parameters[5].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FCartelliniCommand.Parameters[5].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FCartelliniCommand.Parameters[5].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCartelliniCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.Cartellini_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroCartellini: Boolean; DataInizio: TDateTime; DataFine: TDateTime; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FCartelliniCommand_Cache = nil then
  begin
    FCartelliniCommand_Cache := FConnection.CreateCommand;
    FCartelliniCommand_Cache.RequestType := 'POST';
    FCartelliniCommand_Cache.Text := 'TB110FServerMethodsDM."Cartellini"';
    FCartelliniCommand_Cache.Prepare(TB110FServerMethodsDM_Cartellini_Cache);
  end;
  if not Assigned(InfoClient) then
    FCartelliniCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCartelliniCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCartelliniCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCartelliniCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCartelliniCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCartelliniCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCartelliniCommand_Cache.Parameters[2].Value.SetBoolean(SoloNumeroCartellini);
  FCartelliniCommand_Cache.Parameters[3].Value.AsDateTime := DataInizio;
  FCartelliniCommand_Cache.Parameters[4].Value.AsDateTime := DataFine;
  FCartelliniCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FCartelliniCommand_Cache.Parameters[5].Value.GetString);
end;

function TB110FServerMethodsDMClient.Cartellino(InfoClient: TInfoClient; DatiLogin: TParametriLogin; MeseCartellino: TDateTime; CodParamStampa: string; const ARequestFilter: string): TRisultato;
begin
  if FCartellinoCommand = nil then
  begin
    FCartellinoCommand := FConnection.CreateCommand;
    FCartellinoCommand.RequestType := 'POST';
    FCartellinoCommand.Text := 'TB110FServerMethodsDM."Cartellino"';
    FCartellinoCommand.Prepare(TB110FServerMethodsDM_Cartellino);
  end;
  if not Assigned(InfoClient) then
    FCartellinoCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCartellinoCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCartellinoCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCartellinoCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCartellinoCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCartellinoCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCartellinoCommand.Parameters[2].Value.AsDateTime := MeseCartellino;
  FCartellinoCommand.Parameters[3].Value.SetWideString(CodParamStampa);
  FCartellinoCommand.Execute(ARequestFilter);
  if not FCartellinoCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FCartellinoCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FCartellinoCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCartellinoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.Cartellino_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; MeseCartellino: TDateTime; CodParamStampa: string; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FCartellinoCommand_Cache = nil then
  begin
    FCartellinoCommand_Cache := FConnection.CreateCommand;
    FCartellinoCommand_Cache.RequestType := 'POST';
    FCartellinoCommand_Cache.Text := 'TB110FServerMethodsDM."Cartellino"';
    FCartellinoCommand_Cache.Prepare(TB110FServerMethodsDM_Cartellino_Cache);
  end;
  if not Assigned(InfoClient) then
    FCartellinoCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCartellinoCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCartellinoCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCartellinoCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCartellinoCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCartellinoCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCartellinoCommand_Cache.Parameters[2].Value.AsDateTime := MeseCartellino;
  FCartellinoCommand_Cache.Parameters[3].Value.SetWideString(CodParamStampa);
  FCartellinoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FCartellinoCommand_Cache.Parameters[4].Value.GetString);
end;

function TB110FServerMethodsDMClient.Cedolini(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroCedolini: Boolean; DataInizio: TDateTime; DataFine: TDateTime; const ARequestFilter: string): TRisultato;
begin
  if FCedoliniCommand = nil then
  begin
    FCedoliniCommand := FConnection.CreateCommand;
    FCedoliniCommand.RequestType := 'POST';
    FCedoliniCommand.Text := 'TB110FServerMethodsDM."Cedolini"';
    FCedoliniCommand.Prepare(TB110FServerMethodsDM_Cedolini);
  end;
  if not Assigned(InfoClient) then
    FCedoliniCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCedoliniCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCedoliniCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCedoliniCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCedoliniCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCedoliniCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCedoliniCommand.Parameters[2].Value.SetBoolean(SoloNumeroCedolini);
  FCedoliniCommand.Parameters[3].Value.AsDateTime := DataInizio;
  FCedoliniCommand.Parameters[4].Value.AsDateTime := DataFine;
  FCedoliniCommand.Execute(ARequestFilter);
  if not FCedoliniCommand.Parameters[5].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FCedoliniCommand.Parameters[5].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FCedoliniCommand.Parameters[5].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCedoliniCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.Cedolini_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroCedolini: Boolean; DataInizio: TDateTime; DataFine: TDateTime; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FCedoliniCommand_Cache = nil then
  begin
    FCedoliniCommand_Cache := FConnection.CreateCommand;
    FCedoliniCommand_Cache.RequestType := 'POST';
    FCedoliniCommand_Cache.Text := 'TB110FServerMethodsDM."Cedolini"';
    FCedoliniCommand_Cache.Prepare(TB110FServerMethodsDM_Cedolini_Cache);
  end;
  if not Assigned(InfoClient) then
    FCedoliniCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCedoliniCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCedoliniCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCedoliniCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCedoliniCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCedoliniCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCedoliniCommand_Cache.Parameters[2].Value.SetBoolean(SoloNumeroCedolini);
  FCedoliniCommand_Cache.Parameters[3].Value.AsDateTime := DataInizio;
  FCedoliniCommand_Cache.Parameters[4].Value.AsDateTime := DataFine;
  FCedoliniCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FCedoliniCommand_Cache.Parameters[5].Value.GetString);
end;

function TB110FServerMethodsDMClient.Cedolino(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdCedolino: Integer; CumuloVociArretrate: Boolean; StampaOrigineVoci: Boolean; const ARequestFilter: string): TRisultato;
begin
  if FCedolinoCommand = nil then
  begin
    FCedolinoCommand := FConnection.CreateCommand;
    FCedolinoCommand.RequestType := 'POST';
    FCedolinoCommand.Text := 'TB110FServerMethodsDM."Cedolino"';
    FCedolinoCommand.Prepare(TB110FServerMethodsDM_Cedolino);
  end;
  if not Assigned(InfoClient) then
    FCedolinoCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCedolinoCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCedolinoCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCedolinoCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCedolinoCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCedolinoCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCedolinoCommand.Parameters[2].Value.SetInt32(IdCedolino);
  FCedolinoCommand.Parameters[3].Value.SetBoolean(CumuloVociArretrate);
  FCedolinoCommand.Parameters[4].Value.SetBoolean(StampaOrigineVoci);
  FCedolinoCommand.Execute(ARequestFilter);
  if not FCedolinoCommand.Parameters[5].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FCedolinoCommand.Parameters[5].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FCedolinoCommand.Parameters[5].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCedolinoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.Cedolino_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdCedolino: Integer; CumuloVociArretrate: Boolean; StampaOrigineVoci: Boolean; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FCedolinoCommand_Cache = nil then
  begin
    FCedolinoCommand_Cache := FConnection.CreateCommand;
    FCedolinoCommand_Cache.RequestType := 'POST';
    FCedolinoCommand_Cache.Text := 'TB110FServerMethodsDM."Cedolino"';
    FCedolinoCommand_Cache.Prepare(TB110FServerMethodsDM_Cedolino_Cache);
  end;
  if not Assigned(InfoClient) then
    FCedolinoCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCedolinoCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCedolinoCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCedolinoCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCedolinoCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCedolinoCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCedolinoCommand_Cache.Parameters[2].Value.SetInt32(IdCedolino);
  FCedolinoCommand_Cache.Parameters[3].Value.SetBoolean(CumuloVociArretrate);
  FCedolinoCommand_Cache.Parameters[4].Value.SetBoolean(StampaOrigineVoci);
  FCedolinoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FCedolinoCommand_Cache.Parameters[5].Value.GetString);
end;

function TB110FServerMethodsDMClient.ImpostaDataConsegnaCedolino(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdCedolino: Integer; const ARequestFilter: string): TRisultato;
begin
  if FImpostaDataConsegnaCedolinoCommand = nil then
  begin
    FImpostaDataConsegnaCedolinoCommand := FConnection.CreateCommand;
    FImpostaDataConsegnaCedolinoCommand.RequestType := 'POST';
    FImpostaDataConsegnaCedolinoCommand.Text := 'TB110FServerMethodsDM."ImpostaDataConsegnaCedolino"';
    FImpostaDataConsegnaCedolinoCommand.Prepare(TB110FServerMethodsDM_ImpostaDataConsegnaCedolino);
  end;
  if not Assigned(InfoClient) then
    FImpostaDataConsegnaCedolinoCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FImpostaDataConsegnaCedolinoCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FImpostaDataConsegnaCedolinoCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FImpostaDataConsegnaCedolinoCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FImpostaDataConsegnaCedolinoCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FImpostaDataConsegnaCedolinoCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FImpostaDataConsegnaCedolinoCommand.Parameters[2].Value.SetInt32(IdCedolino);
  FImpostaDataConsegnaCedolinoCommand.Execute(ARequestFilter);
  if not FImpostaDataConsegnaCedolinoCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FImpostaDataConsegnaCedolinoCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FImpostaDataConsegnaCedolinoCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FImpostaDataConsegnaCedolinoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.ImpostaDataConsegnaCedolino_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdCedolino: Integer; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FImpostaDataConsegnaCedolinoCommand_Cache = nil then
  begin
    FImpostaDataConsegnaCedolinoCommand_Cache := FConnection.CreateCommand;
    FImpostaDataConsegnaCedolinoCommand_Cache.RequestType := 'POST';
    FImpostaDataConsegnaCedolinoCommand_Cache.Text := 'TB110FServerMethodsDM."ImpostaDataConsegnaCedolino"';
    FImpostaDataConsegnaCedolinoCommand_Cache.Prepare(TB110FServerMethodsDM_ImpostaDataConsegnaCedolino_Cache);
  end;
  if not Assigned(InfoClient) then
    FImpostaDataConsegnaCedolinoCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FImpostaDataConsegnaCedolinoCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FImpostaDataConsegnaCedolinoCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FImpostaDataConsegnaCedolinoCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FImpostaDataConsegnaCedolinoCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FImpostaDataConsegnaCedolinoCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FImpostaDataConsegnaCedolinoCommand_Cache.Parameters[2].Value.SetInt32(IdCedolino);
  FImpostaDataConsegnaCedolinoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FImpostaDataConsegnaCedolinoCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.RichiesteTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string): TRisultato;
begin
  if FRichiesteTimbCommand = nil then
  begin
    FRichiesteTimbCommand := FConnection.CreateCommand;
    FRichiesteTimbCommand.RequestType := 'POST';
    FRichiesteTimbCommand.Text := 'TB110FServerMethodsDM."RichiesteTimb"';
    FRichiesteTimbCommand.Prepare(TB110FServerMethodsDM_RichiesteTimb);
  end;
  if not Assigned(InfoClient) then
    FRichiesteTimbCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRichiesteTimbCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteTimbCommand.Parameters[2].Value.SetBoolean(SoloNumeroRichieste);
  if not Assigned(FiltroRichieste) then
    FRichiesteTimbCommand.Parameters[3].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbCommand.Parameters[3].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbCommand.Parameters[3].Value.SetJSONValue(FMarshal.Marshal(FiltroRichieste), True);
      if FInstanceOwner then
        FiltroRichieste.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteTimbCommand.Execute(ARequestFilter);
  if not FRichiesteTimbCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FRichiesteTimbCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FRichiesteTimbCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FRichiesteTimbCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.RichiesteTimb_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FRichiesteTimbCommand_Cache = nil then
  begin
    FRichiesteTimbCommand_Cache := FConnection.CreateCommand;
    FRichiesteTimbCommand_Cache.RequestType := 'POST';
    FRichiesteTimbCommand_Cache.Text := 'TB110FServerMethodsDM."RichiesteTimb"';
    FRichiesteTimbCommand_Cache.Prepare(TB110FServerMethodsDM_RichiesteTimb_Cache);
  end;
  if not Assigned(InfoClient) then
    FRichiesteTimbCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRichiesteTimbCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteTimbCommand_Cache.Parameters[2].Value.SetBoolean(SoloNumeroRichieste);
  if not Assigned(FiltroRichieste) then
    FRichiesteTimbCommand_Cache.Parameters[3].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbCommand_Cache.Parameters[3].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbCommand_Cache.Parameters[3].Value.SetJSONValue(FMarshal.Marshal(FiltroRichieste), True);
      if FInstanceOwner then
        FiltroRichieste.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteTimbCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FRichiesteTimbCommand_Cache.Parameters[4].Value.GetString);
end;

function TB110FServerMethodsDMClient.AutorizzaRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; Autorizzazione: string; const ARequestFilter: string): TRisultato;
begin
  if FAutorizzaRichiestaTimbCommand = nil then
  begin
    FAutorizzaRichiestaTimbCommand := FConnection.CreateCommand;
    FAutorizzaRichiestaTimbCommand.RequestType := 'POST';
    FAutorizzaRichiestaTimbCommand.Text := 'TB110FServerMethodsDM."AutorizzaRichiestaTimb"';
    FAutorizzaRichiestaTimbCommand.Prepare(TB110FServerMethodsDM_AutorizzaRichiestaTimb);
  end;
  if not Assigned(InfoClient) then
    FAutorizzaRichiestaTimbCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FAutorizzaRichiestaTimbCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FAutorizzaRichiestaTimbCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FAutorizzaRichiestaTimbCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FAutorizzaRichiestaTimbCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FAutorizzaRichiestaTimbCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FAutorizzaRichiestaTimbCommand.Parameters[2].Value.SetInt32(IdRichiesta);
  FAutorizzaRichiestaTimbCommand.Parameters[3].Value.SetWideString(Autorizzazione);
  FAutorizzaRichiestaTimbCommand.Execute(ARequestFilter);
  if not FAutorizzaRichiestaTimbCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FAutorizzaRichiestaTimbCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FAutorizzaRichiestaTimbCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FAutorizzaRichiestaTimbCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.AutorizzaRichiestaTimb_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; Autorizzazione: string; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FAutorizzaRichiestaTimbCommand_Cache = nil then
  begin
    FAutorizzaRichiestaTimbCommand_Cache := FConnection.CreateCommand;
    FAutorizzaRichiestaTimbCommand_Cache.RequestType := 'POST';
    FAutorizzaRichiestaTimbCommand_Cache.Text := 'TB110FServerMethodsDM."AutorizzaRichiestaTimb"';
    FAutorizzaRichiestaTimbCommand_Cache.Prepare(TB110FServerMethodsDM_AutorizzaRichiestaTimb_Cache);
  end;
  if not Assigned(InfoClient) then
    FAutorizzaRichiestaTimbCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FAutorizzaRichiestaTimbCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FAutorizzaRichiestaTimbCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FAutorizzaRichiestaTimbCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FAutorizzaRichiestaTimbCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FAutorizzaRichiestaTimbCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FAutorizzaRichiestaTimbCommand_Cache.Parameters[2].Value.SetInt32(IdRichiesta);
  FAutorizzaRichiestaTimbCommand_Cache.Parameters[3].Value.SetWideString(Autorizzazione);
  FAutorizzaRichiestaTimbCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FAutorizzaRichiestaTimbCommand_Cache.Parameters[4].Value.GetString);
end;

function TB110FServerMethodsDMClient.RichiesteTimbDip(InfoClient: TInfoClient; DatiLogin: TParametriLogin; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string): TRisultato;
begin
  if FRichiesteTimbDipCommand = nil then
  begin
    FRichiesteTimbDipCommand := FConnection.CreateCommand;
    FRichiesteTimbDipCommand.RequestType := 'POST';
    FRichiesteTimbDipCommand.Text := 'TB110FServerMethodsDM."RichiesteTimbDip"';
    FRichiesteTimbDipCommand.Prepare(TB110FServerMethodsDM_RichiesteTimbDip);
  end;
  if not Assigned(InfoClient) then
    FRichiesteTimbDipCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbDipCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbDipCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRichiesteTimbDipCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbDipCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbDipCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(FiltroRichieste) then
    FRichiesteTimbDipCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbDipCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbDipCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(FiltroRichieste), True);
      if FInstanceOwner then
        FiltroRichieste.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteTimbDipCommand.Execute(ARequestFilter);
  if not FRichiesteTimbDipCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FRichiesteTimbDipCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FRichiesteTimbDipCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FRichiesteTimbDipCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.RichiesteTimbDip_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; FiltroRichieste: TFiltriRichieste; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FRichiesteTimbDipCommand_Cache = nil then
  begin
    FRichiesteTimbDipCommand_Cache := FConnection.CreateCommand;
    FRichiesteTimbDipCommand_Cache.RequestType := 'POST';
    FRichiesteTimbDipCommand_Cache.Text := 'TB110FServerMethodsDM."RichiesteTimbDip"';
    FRichiesteTimbDipCommand_Cache.Prepare(TB110FServerMethodsDM_RichiesteTimbDip_Cache);
  end;
  if not Assigned(InfoClient) then
    FRichiesteTimbDipCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbDipCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbDipCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRichiesteTimbDipCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbDipCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbDipCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(FiltroRichieste) then
    FRichiesteTimbDipCommand_Cache.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRichiesteTimbDipCommand_Cache.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FRichiesteTimbDipCommand_Cache.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(FiltroRichieste), True);
      if FInstanceOwner then
        FiltroRichieste.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRichiesteTimbDipCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FRichiesteTimbDipCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.TimbModificabili(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DataRif: TDateTime; const ARequestFilter: string): TRisultato;
begin
  if FTimbModificabiliCommand = nil then
  begin
    FTimbModificabiliCommand := FConnection.CreateCommand;
    FTimbModificabiliCommand.RequestType := 'POST';
    FTimbModificabiliCommand.Text := 'TB110FServerMethodsDM."TimbModificabili"';
    FTimbModificabiliCommand.Prepare(TB110FServerMethodsDM_TimbModificabili);
  end;
  if not Assigned(InfoClient) then
    FTimbModificabiliCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FTimbModificabiliCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FTimbModificabiliCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FTimbModificabiliCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FTimbModificabiliCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FTimbModificabiliCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FTimbModificabiliCommand.Parameters[2].Value.AsDateTime := DataRif;
  FTimbModificabiliCommand.Execute(ARequestFilter);
  if not FTimbModificabiliCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FTimbModificabiliCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FTimbModificabiliCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FTimbModificabiliCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.TimbModificabili_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DataRif: TDateTime; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FTimbModificabiliCommand_Cache = nil then
  begin
    FTimbModificabiliCommand_Cache := FConnection.CreateCommand;
    FTimbModificabiliCommand_Cache.RequestType := 'POST';
    FTimbModificabiliCommand_Cache.Text := 'TB110FServerMethodsDM."TimbModificabili"';
    FTimbModificabiliCommand_Cache.Prepare(TB110FServerMethodsDM_TimbModificabili_Cache);
  end;
  if not Assigned(InfoClient) then
    FTimbModificabiliCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FTimbModificabiliCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FTimbModificabiliCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FTimbModificabiliCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FTimbModificabiliCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FTimbModificabiliCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FTimbModificabiliCommand_Cache.Parameters[2].Value.AsDateTime := DataRif;
  FTimbModificabiliCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FTimbModificabiliCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.InsRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiTimb: TDatiRichiestaTimb; const ARequestFilter: string): TRisultato;
begin
  if FInsRichiestaTimbCommand = nil then
  begin
    FInsRichiestaTimbCommand := FConnection.CreateCommand;
    FInsRichiestaTimbCommand.RequestType := 'POST';
    FInsRichiestaTimbCommand.Text := 'TB110FServerMethodsDM."InsRichiestaTimb"';
    FInsRichiestaTimbCommand.Prepare(TB110FServerMethodsDM_InsRichiestaTimb);
  end;
  if not Assigned(InfoClient) then
    FInsRichiestaTimbCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaTimbCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaTimbCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FInsRichiestaTimbCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaTimbCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaTimbCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiTimb) then
    FInsRichiestaTimbCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaTimbCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaTimbCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiTimb), True);
      if FInstanceOwner then
        DatiTimb.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsRichiestaTimbCommand.Execute(ARequestFilter);
  if not FInsRichiestaTimbCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FInsRichiestaTimbCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FInsRichiestaTimbCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FInsRichiestaTimbCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.InsRichiestaTimb_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiTimb: TDatiRichiestaTimb; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FInsRichiestaTimbCommand_Cache = nil then
  begin
    FInsRichiestaTimbCommand_Cache := FConnection.CreateCommand;
    FInsRichiestaTimbCommand_Cache.RequestType := 'POST';
    FInsRichiestaTimbCommand_Cache.Text := 'TB110FServerMethodsDM."InsRichiestaTimb"';
    FInsRichiestaTimbCommand_Cache.Prepare(TB110FServerMethodsDM_InsRichiestaTimb_Cache);
  end;
  if not Assigned(InfoClient) then
    FInsRichiestaTimbCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaTimbCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaTimbCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FInsRichiestaTimbCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaTimbCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaTimbCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiTimb) then
    FInsRichiestaTimbCommand_Cache.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsRichiestaTimbCommand_Cache.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FInsRichiestaTimbCommand_Cache.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiTimb), True);
      if FInstanceOwner then
        DatiTimb.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsRichiestaTimbCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FInsRichiestaTimbCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.CancRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; const ARequestFilter: string): TRisultato;
begin
  if FCancRichiestaTimbCommand = nil then
  begin
    FCancRichiestaTimbCommand := FConnection.CreateCommand;
    FCancRichiestaTimbCommand.RequestType := 'POST';
    FCancRichiestaTimbCommand.Text := 'TB110FServerMethodsDM."CancRichiestaTimb"';
    FCancRichiestaTimbCommand.Prepare(TB110FServerMethodsDM_CancRichiestaTimb);
  end;
  if not Assigned(InfoClient) then
    FCancRichiestaTimbCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaTimbCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaTimbCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCancRichiestaTimbCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaTimbCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaTimbCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCancRichiestaTimbCommand.Parameters[2].Value.SetInt32(IdRichiesta);
  FCancRichiestaTimbCommand.Execute(ARequestFilter);
  if not FCancRichiestaTimbCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FCancRichiestaTimbCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FCancRichiestaTimbCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCancRichiestaTimbCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.CancRichiestaTimb_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FCancRichiestaTimbCommand_Cache = nil then
  begin
    FCancRichiestaTimbCommand_Cache := FConnection.CreateCommand;
    FCancRichiestaTimbCommand_Cache.RequestType := 'POST';
    FCancRichiestaTimbCommand_Cache.Text := 'TB110FServerMethodsDM."CancRichiestaTimb"';
    FCancRichiestaTimbCommand_Cache.Prepare(TB110FServerMethodsDM_CancRichiestaTimb_Cache);
  end;
  if not Assigned(InfoClient) then
    FCancRichiestaTimbCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaTimbCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaTimbCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FCancRichiestaTimbCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FCancRichiestaTimbCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FCancRichiestaTimbCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FCancRichiestaTimbCommand_Cache.Parameters[2].Value.SetInt32(IdRichiesta);
  FCancRichiestaTimbCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FCancRichiestaTimbCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.NoteRichiesta(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; const ARequestFilter: string): TRisultato;
begin
  if FNoteRichiestaCommand = nil then
  begin
    FNoteRichiestaCommand := FConnection.CreateCommand;
    FNoteRichiestaCommand.RequestType := 'POST';
    FNoteRichiestaCommand.Text := 'TB110FServerMethodsDM."NoteRichiesta"';
    FNoteRichiestaCommand.Prepare(TB110FServerMethodsDM_NoteRichiesta);
  end;
  if not Assigned(InfoClient) then
    FNoteRichiestaCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FNoteRichiestaCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FNoteRichiestaCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FNoteRichiestaCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FNoteRichiestaCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FNoteRichiestaCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FNoteRichiestaCommand.Parameters[2].Value.SetInt32(IdRichiesta);
  FNoteRichiestaCommand.Execute(ARequestFilter);
  if not FNoteRichiestaCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FNoteRichiestaCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FNoteRichiestaCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FNoteRichiestaCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.NoteRichiesta_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FNoteRichiestaCommand_Cache = nil then
  begin
    FNoteRichiestaCommand_Cache := FConnection.CreateCommand;
    FNoteRichiestaCommand_Cache.RequestType := 'POST';
    FNoteRichiestaCommand_Cache.Text := 'TB110FServerMethodsDM."NoteRichiesta"';
    FNoteRichiestaCommand_Cache.Prepare(TB110FServerMethodsDM_NoteRichiesta_Cache);
  end;
  if not Assigned(InfoClient) then
    FNoteRichiestaCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FNoteRichiestaCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FNoteRichiestaCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FNoteRichiestaCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FNoteRichiestaCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FNoteRichiestaCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FNoteRichiestaCommand_Cache.Parameters[2].Value.SetInt32(IdRichiesta);
  FNoteRichiestaCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FNoteRichiestaCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.SetNoteRichiesta(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; NoteLivello: TNoteLivello; const ARequestFilter: string): TRisultato;
begin
  if FSetNoteRichiestaCommand = nil then
  begin
    FSetNoteRichiestaCommand := FConnection.CreateCommand;
    FSetNoteRichiestaCommand.RequestType := 'POST';
    FSetNoteRichiestaCommand.Text := 'TB110FServerMethodsDM."SetNoteRichiesta"';
    FSetNoteRichiestaCommand.Prepare(TB110FServerMethodsDM_SetNoteRichiesta);
  end;
  if not Assigned(InfoClient) then
    FSetNoteRichiestaCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSetNoteRichiestaCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSetNoteRichiestaCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FSetNoteRichiestaCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSetNoteRichiestaCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FSetNoteRichiestaCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSetNoteRichiestaCommand.Parameters[2].Value.SetInt32(IdRichiesta);
  if not Assigned(NoteLivello) then
    FSetNoteRichiestaCommand.Parameters[3].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSetNoteRichiestaCommand.Parameters[3].ConnectionHandler).GetJSONMarshaler;
    try
      FSetNoteRichiestaCommand.Parameters[3].Value.SetJSONValue(FMarshal.Marshal(NoteLivello), True);
      if FInstanceOwner then
        NoteLivello.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSetNoteRichiestaCommand.Execute(ARequestFilter);
  if not FSetNoteRichiestaCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSetNoteRichiestaCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FSetNoteRichiestaCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSetNoteRichiestaCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.SetNoteRichiesta_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; IdRichiesta: Integer; NoteLivello: TNoteLivello; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FSetNoteRichiestaCommand_Cache = nil then
  begin
    FSetNoteRichiestaCommand_Cache := FConnection.CreateCommand;
    FSetNoteRichiestaCommand_Cache.RequestType := 'POST';
    FSetNoteRichiestaCommand_Cache.Text := 'TB110FServerMethodsDM."SetNoteRichiesta"';
    FSetNoteRichiestaCommand_Cache.Prepare(TB110FServerMethodsDM_SetNoteRichiesta_Cache);
  end;
  if not Assigned(InfoClient) then
    FSetNoteRichiestaCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSetNoteRichiestaCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSetNoteRichiestaCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FSetNoteRichiestaCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSetNoteRichiestaCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FSetNoteRichiestaCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSetNoteRichiestaCommand_Cache.Parameters[2].Value.SetInt32(IdRichiesta);
  if not Assigned(NoteLivello) then
    FSetNoteRichiestaCommand_Cache.Parameters[3].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSetNoteRichiestaCommand_Cache.Parameters[3].ConnectionHandler).GetJSONMarshaler;
    try
      FSetNoteRichiestaCommand_Cache.Parameters[3].Value.SetJSONValue(FMarshal.Marshal(NoteLivello), True);
      if FInstanceOwner then
        NoteLivello.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSetNoteRichiestaCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FSetNoteRichiestaCommand_Cache.Parameters[4].Value.GetString);
end;

function TB110FServerMethodsDMClient.RiepilogoAssenze(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Progressivo: Integer; Causale: string; Data: TDateTime; DataFamiliare: TDateTime; const ARequestFilter: string): TRisultato;
begin
  if FRiepilogoAssenzeCommand = nil then
  begin
    FRiepilogoAssenzeCommand := FConnection.CreateCommand;
    FRiepilogoAssenzeCommand.RequestType := 'POST';
    FRiepilogoAssenzeCommand.Text := 'TB110FServerMethodsDM."RiepilogoAssenze"';
    FRiepilogoAssenzeCommand.Prepare(TB110FServerMethodsDM_RiepilogoAssenze);
  end;
  if not Assigned(InfoClient) then
    FRiepilogoAssenzeCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRiepilogoAssenzeCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRiepilogoAssenzeCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRiepilogoAssenzeCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRiepilogoAssenzeCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRiepilogoAssenzeCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRiepilogoAssenzeCommand.Parameters[2].Value.SetInt32(Progressivo);
  FRiepilogoAssenzeCommand.Parameters[3].Value.SetWideString(Causale);
  FRiepilogoAssenzeCommand.Parameters[4].Value.AsDateTime := Data;
  FRiepilogoAssenzeCommand.Parameters[5].Value.AsDateTime := DataFamiliare;
  FRiepilogoAssenzeCommand.Execute(ARequestFilter);
  if not FRiepilogoAssenzeCommand.Parameters[6].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FRiepilogoAssenzeCommand.Parameters[6].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FRiepilogoAssenzeCommand.Parameters[6].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FRiepilogoAssenzeCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.RiepilogoAssenze_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Progressivo: Integer; Causale: string; Data: TDateTime; DataFamiliare: TDateTime; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FRiepilogoAssenzeCommand_Cache = nil then
  begin
    FRiepilogoAssenzeCommand_Cache := FConnection.CreateCommand;
    FRiepilogoAssenzeCommand_Cache.RequestType := 'POST';
    FRiepilogoAssenzeCommand_Cache.Text := 'TB110FServerMethodsDM."RiepilogoAssenze"';
    FRiepilogoAssenzeCommand_Cache.Prepare(TB110FServerMethodsDM_RiepilogoAssenze_Cache);
  end;
  if not Assigned(InfoClient) then
    FRiepilogoAssenzeCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRiepilogoAssenzeCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FRiepilogoAssenzeCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FRiepilogoAssenzeCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FRiepilogoAssenzeCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FRiepilogoAssenzeCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FRiepilogoAssenzeCommand_Cache.Parameters[2].Value.SetInt32(Progressivo);
  FRiepilogoAssenzeCommand_Cache.Parameters[3].Value.SetWideString(Causale);
  FRiepilogoAssenzeCommand_Cache.Parameters[4].Value.AsDateTime := Data;
  FRiepilogoAssenzeCommand_Cache.Parameters[5].Value.AsDateTime := DataFamiliare;
  FRiepilogoAssenzeCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FRiepilogoAssenzeCommand_Cache.Parameters[6].Value.GetString);
end;

function TB110FServerMethodsDMClient.Dipendenti(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DataRiferimento: TDateTime; const ARequestFilter: string): TRisultato;
begin
  if FDipendentiCommand = nil then
  begin
    FDipendentiCommand := FConnection.CreateCommand;
    FDipendentiCommand.RequestType := 'POST';
    FDipendentiCommand.Text := 'TB110FServerMethodsDM."Dipendenti"';
    FDipendentiCommand.Prepare(TB110FServerMethodsDM_Dipendenti);
  end;
  if not Assigned(InfoClient) then
    FDipendentiCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDipendentiCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDipendentiCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FDipendentiCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDipendentiCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FDipendentiCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDipendentiCommand.Parameters[2].Value.AsDateTime := DataRiferimento;
  FDipendentiCommand.Execute(ARequestFilter);
  if not FDipendentiCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FDipendentiCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FDipendentiCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FDipendentiCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.Dipendenti_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DataRiferimento: TDateTime; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FDipendentiCommand_Cache = nil then
  begin
    FDipendentiCommand_Cache := FConnection.CreateCommand;
    FDipendentiCommand_Cache.RequestType := 'POST';
    FDipendentiCommand_Cache.Text := 'TB110FServerMethodsDM."Dipendenti"';
    FDipendentiCommand_Cache.Prepare(TB110FServerMethodsDM_Dipendenti_Cache);
  end;
  if not Assigned(InfoClient) then
    FDipendentiCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDipendentiCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDipendentiCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FDipendentiCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDipendentiCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FDipendentiCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDipendentiCommand_Cache.Parameters[2].Value.AsDateTime := DataRiferimento;
  FDipendentiCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FDipendentiCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.DatiGiornalieri(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Data: TDateTime; const ARequestFilter: string): TRisultato;
begin
  if FDatiGiornalieriCommand = nil then
  begin
    FDatiGiornalieriCommand := FConnection.CreateCommand;
    FDatiGiornalieriCommand.RequestType := 'POST';
    FDatiGiornalieriCommand.Text := 'TB110FServerMethodsDM."DatiGiornalieri"';
    FDatiGiornalieriCommand.Prepare(TB110FServerMethodsDM_DatiGiornalieri);
  end;
  if not Assigned(InfoClient) then
    FDatiGiornalieriCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDatiGiornalieriCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDatiGiornalieriCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FDatiGiornalieriCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDatiGiornalieriCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FDatiGiornalieriCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDatiGiornalieriCommand.Parameters[2].Value.AsDateTime := Data;
  FDatiGiornalieriCommand.Execute(ARequestFilter);
  if not FDatiGiornalieriCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FDatiGiornalieriCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FDatiGiornalieriCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FDatiGiornalieriCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.DatiGiornalieri_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Data: TDateTime; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FDatiGiornalieriCommand_Cache = nil then
  begin
    FDatiGiornalieriCommand_Cache := FConnection.CreateCommand;
    FDatiGiornalieriCommand_Cache.RequestType := 'POST';
    FDatiGiornalieriCommand_Cache.Text := 'TB110FServerMethodsDM."DatiGiornalieri"';
    FDatiGiornalieriCommand_Cache.Prepare(TB110FServerMethodsDM_DatiGiornalieri_Cache);
  end;
  if not Assigned(InfoClient) then
    FDatiGiornalieriCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDatiGiornalieriCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDatiGiornalieriCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FDatiGiornalieriCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDatiGiornalieriCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FDatiGiornalieriCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDatiGiornalieriCommand_Cache.Parameters[2].Value.AsDateTime := Data;
  FDatiGiornalieriCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FDatiGiornalieriCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.Timbrature(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Dal: TDateTime; Al: TDateTime; const ARequestFilter: string): TRisultato;
begin
  if FTimbratureCommand = nil then
  begin
    FTimbratureCommand := FConnection.CreateCommand;
    FTimbratureCommand.RequestType := 'POST';
    FTimbratureCommand.Text := 'TB110FServerMethodsDM."Timbrature"';
    FTimbratureCommand.Prepare(TB110FServerMethodsDM_Timbrature);
  end;
  if not Assigned(InfoClient) then
    FTimbratureCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FTimbratureCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FTimbratureCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FTimbratureCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FTimbratureCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FTimbratureCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FTimbratureCommand.Parameters[2].Value.AsDateTime := Dal;
  FTimbratureCommand.Parameters[3].Value.AsDateTime := Al;
  FTimbratureCommand.Execute(ARequestFilter);
  if not FTimbratureCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FTimbratureCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FTimbratureCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FTimbratureCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.Timbrature_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Dal: TDateTime; Al: TDateTime; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FTimbratureCommand_Cache = nil then
  begin
    FTimbratureCommand_Cache := FConnection.CreateCommand;
    FTimbratureCommand_Cache.RequestType := 'POST';
    FTimbratureCommand_Cache.Text := 'TB110FServerMethodsDM."Timbrature"';
    FTimbratureCommand_Cache.Prepare(TB110FServerMethodsDM_Timbrature_Cache);
  end;
  if not Assigned(InfoClient) then
    FTimbratureCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FTimbratureCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FTimbratureCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FTimbratureCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FTimbratureCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FTimbratureCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FTimbratureCommand_Cache.Parameters[2].Value.AsDateTime := Dal;
  FTimbratureCommand_Cache.Parameters[3].Value.AsDateTime := Al;
  FTimbratureCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FTimbratureCommand_Cache.Parameters[4].Value.GetString);
end;

function TB110FServerMethodsDMClient.InsTimbratura(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiTimbratura: TDatiTimbratura; const ARequestFilter: string): TRisultato;
begin
  if FInsTimbraturaCommand = nil then
  begin
    FInsTimbraturaCommand := FConnection.CreateCommand;
    FInsTimbraturaCommand.RequestType := 'POST';
    FInsTimbraturaCommand.Text := 'TB110FServerMethodsDM."InsTimbratura"';
    FInsTimbraturaCommand.Prepare(TB110FServerMethodsDM_InsTimbratura);
  end;
  if not Assigned(InfoClient) then
    FInsTimbraturaCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsTimbraturaCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsTimbraturaCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FInsTimbraturaCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsTimbraturaCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FInsTimbraturaCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiTimbratura) then
    FInsTimbraturaCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsTimbraturaCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FInsTimbraturaCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiTimbratura), True);
      if FInstanceOwner then
        DatiTimbratura.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsTimbraturaCommand.Execute(ARequestFilter);
  if not FInsTimbraturaCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FInsTimbraturaCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FInsTimbraturaCommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FInsTimbraturaCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.InsTimbratura_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; DatiTimbratura: TDatiTimbratura; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FInsTimbraturaCommand_Cache = nil then
  begin
    FInsTimbraturaCommand_Cache := FConnection.CreateCommand;
    FInsTimbraturaCommand_Cache.RequestType := 'POST';
    FInsTimbraturaCommand_Cache.Text := 'TB110FServerMethodsDM."InsTimbratura"';
    FInsTimbraturaCommand_Cache.Prepare(TB110FServerMethodsDM_InsTimbratura_Cache);
  end;
  if not Assigned(InfoClient) then
    FInsTimbraturaCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsTimbraturaCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsTimbraturaCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FInsTimbraturaCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsTimbraturaCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FInsTimbraturaCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiTimbratura) then
    FInsTimbraturaCommand_Cache.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsTimbraturaCommand_Cache.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FInsTimbraturaCommand_Cache.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(DatiTimbratura), True);
      if FInstanceOwner then
        DatiTimbratura.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsTimbraturaCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FInsTimbraturaCommand_Cache.Parameters[3].Value.GetString);
end;

function TB110FServerMethodsDMClient.Dizionario(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Tabella: string; Param1: string; ApplicaFiltroDizionario: Boolean; const ARequestFilter: string): TRisultato;
begin
  if FDizionarioCommand = nil then
  begin
    FDizionarioCommand := FConnection.CreateCommand;
    FDizionarioCommand.RequestType := 'POST';
    FDizionarioCommand.Text := 'TB110FServerMethodsDM."Dizionario"';
    FDizionarioCommand.Prepare(TB110FServerMethodsDM_Dizionario);
  end;
  if not Assigned(InfoClient) then
    FDizionarioCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDizionarioCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDizionarioCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FDizionarioCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDizionarioCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FDizionarioCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDizionarioCommand.Parameters[2].Value.SetWideString(Tabella);
  FDizionarioCommand.Parameters[3].Value.SetWideString(Param1);
  FDizionarioCommand.Parameters[4].Value.SetBoolean(ApplicaFiltroDizionario);
  FDizionarioCommand.Execute(ARequestFilter);
  if not FDizionarioCommand.Parameters[5].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FDizionarioCommand.Parameters[5].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FDizionarioCommand.Parameters[5].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FDizionarioCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.Dizionario_Cache(InfoClient: TInfoClient; DatiLogin: TParametriLogin; Tabella: string; Param1: string; ApplicaFiltroDizionario: Boolean; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FDizionarioCommand_Cache = nil then
  begin
    FDizionarioCommand_Cache := FConnection.CreateCommand;
    FDizionarioCommand_Cache.RequestType := 'POST';
    FDizionarioCommand_Cache.Text := 'TB110FServerMethodsDM."Dizionario"';
    FDizionarioCommand_Cache.Prepare(TB110FServerMethodsDM_Dizionario_Cache);
  end;
  if not Assigned(InfoClient) then
    FDizionarioCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDizionarioCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDizionarioCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(InfoClient), True);
      if FInstanceOwner then
        InfoClient.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  if not Assigned(DatiLogin) then
    FDizionarioCommand_Cache.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDizionarioCommand_Cache.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FDizionarioCommand_Cache.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(DatiLogin), True);
      if FInstanceOwner then
        DatiLogin.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDizionarioCommand_Cache.Parameters[2].Value.SetWideString(Tabella);
  FDizionarioCommand_Cache.Parameters[3].Value.SetWideString(Param1);
  FDizionarioCommand_Cache.Parameters[4].Value.SetBoolean(ApplicaFiltroDizionario);
  FDizionarioCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FDizionarioCommand_Cache.Parameters[5].Value.GetString);
end;

constructor TB110FServerMethodsDMClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TB110FServerMethodsDMClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TB110FServerMethodsDMClient.Destroy;
begin
  FEchoCommand.DisposeOf;
  FInfoServerCommand.DisposeOf;
  FInfoServerCommand_Cache.DisposeOf;
  FWebServiceEnteCommand.DisposeOf;
  FWebServiceEnteCommand_Cache.DisposeOf;
  FCheckAutenticazioneCommand.DisposeOf;
  FCheckAutenticazioneCommand_Cache.DisposeOf;
  FVersioneServerCommand.DisposeOf;
  FVersioneServerCommand_Cache.DisposeOf;
  FDatiGeneraliCommand.DisposeOf;
  FDatiGeneraliCommand_Cache.DisposeOf;
  FRichiesteGiustCommand.DisposeOf;
  FRichiesteGiustCommand_Cache.DisposeOf;
  FAutorizzaRichiestaGiustCommand.DisposeOf;
  FAutorizzaRichiestaGiustCommand_Cache.DisposeOf;
  FRichiesteGiustDipCommand.DisposeOf;
  FRichiesteGiustDipCommand_Cache.DisposeOf;
  FInsRichiestaGiustCommand.DisposeOf;
  FInsRichiestaGiustCommand_Cache.DisposeOf;
  FCancRichiestaGiustCommand.DisposeOf;
  FCancRichiestaGiustCommand_Cache.DisposeOf;
  FRevocaRichiestaGiustCommand.DisposeOf;
  FRevocaRichiestaGiustCommand_Cache.DisposeOf;
  FCartelliniCommand.DisposeOf;
  FCartelliniCommand_Cache.DisposeOf;
  FCartellinoCommand.DisposeOf;
  FCartellinoCommand_Cache.DisposeOf;
  FCedoliniCommand.DisposeOf;
  FCedoliniCommand_Cache.DisposeOf;
  FCedolinoCommand.DisposeOf;
  FCedolinoCommand_Cache.DisposeOf;
  FImpostaDataConsegnaCedolinoCommand.DisposeOf;
  FImpostaDataConsegnaCedolinoCommand_Cache.DisposeOf;
  FRichiesteTimbCommand.DisposeOf;
  FRichiesteTimbCommand_Cache.DisposeOf;
  FAutorizzaRichiestaTimbCommand.DisposeOf;
  FAutorizzaRichiestaTimbCommand_Cache.DisposeOf;
  FRichiesteTimbDipCommand.DisposeOf;
  FRichiesteTimbDipCommand_Cache.DisposeOf;
  FTimbModificabiliCommand.DisposeOf;
  FTimbModificabiliCommand_Cache.DisposeOf;
  FInsRichiestaTimbCommand.DisposeOf;
  FInsRichiestaTimbCommand_Cache.DisposeOf;
  FCancRichiestaTimbCommand.DisposeOf;
  FCancRichiestaTimbCommand_Cache.DisposeOf;
  FNoteRichiestaCommand.DisposeOf;
  FNoteRichiestaCommand_Cache.DisposeOf;
  FSetNoteRichiestaCommand.DisposeOf;
  FSetNoteRichiestaCommand_Cache.DisposeOf;
  FRiepilogoAssenzeCommand.DisposeOf;
  FRiepilogoAssenzeCommand_Cache.DisposeOf;
  FDipendentiCommand.DisposeOf;
  FDipendentiCommand_Cache.DisposeOf;
  FDatiGiornalieriCommand.DisposeOf;
  FDatiGiornalieriCommand_Cache.DisposeOf;
  FTimbratureCommand.DisposeOf;
  FTimbratureCommand_Cache.DisposeOf;
  FInsTimbraturaCommand.DisposeOf;
  FInsTimbraturaCommand_Cache.DisposeOf;
  FDizionarioCommand.DisposeOf;
  FDizionarioCommand_Cache.DisposeOf;
  inherited;
end;

end.
