unit B110UServerMethodsDM;

interface

uses
  {$IFDEF DEBUG}OracleMonitor,{$ENDIF}
  A000Versione,
  R015UDatasnapRestDM,
  B110UUtils,
  // servizi mondoedp
  B110UWebServiceEnteDM,
  // servizi specifici (in ordine alfabetico)
  B110UAutenticazioneDM,
  B110UAutorizzazioneRichiesteGiustDM,
  B110UAutorizzazioneRichiesteTimbDM,
  B110UCancRichiestaGiustDM,
  B110UCancRichiestaTimbDM,
  B110UCartelliniDM,
  B110UCedoliniDM,
  B110UConsegnaCedoliniDM,
  B110UDatiGeneraliDM,
  B110UDatiGiornalieriDM,
  B110UDizionarioDM,
  B110UElencoDipendentiDM,
  B110UInfoServerDM,
  B110UInsRichiestaGiustDM,
  B110UInsRichiestaTimbDM,
  B110UInsTimbraturaDM,
  B110URevocaRichiestaGiustDM,
  B110URichiesteGiustDipDM,
  B110URichiesteGiustDM,
  B110URichiesteTimbDipDM,
  B110URichiesteTimbDM,
  B110UNoteRichiestaDM,
  B110URiepilogoAssenzeDM,
  B110UStampaCartellinoDM,
  B110UStampaCedolinoDM,
  B110UTimbModificabiliDM,
  B110UTimbratureDM,
  B110UVersioneServerDM,
  // unit di supporto
  A000UCostanti,
  FunzioniGenerali,
  C200UWebServicesTypes,
  C200UWebServicesServerUtils,
  B110USharedTypes,
  R600,
  System.IOUtils,
  System.SysUtils,
  System.Classes,
  Datasnap.DSServer,
  Datasnap.DSSession,
  Data.DBXPlatform,
  FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin;

type

{$METHODINFO ON}
  TB110FServerMethodsDM = class(TDataModule)
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
  private
    procedure EseguiOperazioniComuni; inline;
  public
    {$REGION 'Servizi di test'}
    function Echo(S: String): String;
    function InfoServer(InfoClient: TInfoClient; Dato: String): TRisultato;
    {$ENDREGION 'Servizi di test'}

    {$REGION 'Servizi centrali MondoEdp'}
    function WebServiceEnte(InfoClient: TInfoClient; IdAzienda: String): TRisultato;
    {$ENDREGION 'Servizi centrali MondoEdp'}

    {$REGION 'Servizi aziendali'}
    function CheckAutenticazione(InfoClient: TInfoClient; DatiLogin: TParametriLogin): TRisultato;
    function VersioneServer(TipoVersione: String): TRisultato;
    function DatiGenerali(InfoClient: TInfoClient; DatiLogin: TParametriLogin): TRisultato;
    function RichiesteGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste): TRisultato;
    function AutorizzaRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      IdRichiesta: Integer; Autorizzazione: String): TRisultato;
    function RichiesteGiustDip(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      FiltroRichieste: TFiltriRichieste): TRisultato;
    function InsRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      DatiGiust: TDatiRichiestaGiust): TRisultato;
    function CancRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer): TRisultato;
    function RevocaRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; TipoRichiesta: String; Dal: TDateTime; Al: TDateTime): TRisultato;
    function Cartellini(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      SoloNumeroCartellini: Boolean; DataInizio: TDateTime; DataFine: TDateTime): TRisultato;
    function Cartellino(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      MeseCartellino: TDateTime; CodParamStampa: String): TRisultato;
    function Cedolini(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      SoloNumeroCedolini: Boolean; DataInizio: TDateTime; DataFine: TDateTime): TRisultato;
    function Cedolino(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      IdCedolino: Integer; CumuloVociArretrate: Boolean; StampaOrigineVoci: Boolean): TRisultato;
    function ImpostaDataConsegnaCedolino(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      IdCedolino: Integer): TRisultato;
    function RichiesteTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste): TRisultato;
    function AutorizzaRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      IdRichiesta: Integer; Autorizzazione: String): TRisultato;
    function RichiesteTimbDip(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      FiltroRichieste: TFiltriRichieste): TRisultato;
    function TimbModificabili(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      DataRif: TDateTime): TRisultato;
    function InsRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      DatiTimb: TDatiRichiestaTimb): TRisultato;
    function CancRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      IdRichiesta: Integer): TRisultato;
    function NoteRichiesta(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      IdRichiesta: Integer): TRisultato;
    function SetNoteRichiesta(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      IdRichiesta: Integer; NoteLivello: TNoteLivello): TRisultato;
    function RiepilogoAssenze(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      Progressivo: Integer; Causale: String; Data,DataFamiliare: TDateTime): TRisultato;
    function Dipendenti(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      DataRiferimento: TDateTime): TRisultato;
    function DatiGiornalieri(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      Data: TDateTime): TRisultato;
    function Timbrature(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      Dal: TDateTime; Al: TDateTime): TRisultato;
    function InsTimbratura(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      DatiTimbratura: TDatiTimbratura): TRisultato;
    function Dizionario(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
      Tabella: String; Param1: String; ApplicaFiltroDizionario: Boolean): TRisultato;
    {$ENDREGION 'Servizi aziendali'}
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

procedure TB110FServerMethodsDM.EseguiOperazioniComuni;
var
  LMetadata: TDSInvocationMetadata;
begin
  LMetadata:=GetInvocationMetadata;

  // imposta la chiusura della sessione (immediata o differita) in base ai parametri del server
  LMetadata.CloseSession:=TB110FParametriServer.Impostazioni_CloseSessionImmediata;

  // legge i parametri della querystring
  //  LMetadata.QueryParams
end;

{$REGION 'Servizi di test'}

function TB110FServerMethodsDM.Echo(S: String): String;
begin
  Result:='Hai passato "' + S + '"';
end;

function TB110FServerMethodsDM.InfoServer(InfoClient: TInfoClient; Dato: String): TRisultato;
// restituisce informazioni sui parametri di avvio del server
var
  B110DM: TB110FInfoServerDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FInfoServerDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // no parametri di login

      // imposta parametri specifici
      B110DM.DatoServer:=Dato;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Servizi di test'}

{$REGION 'Servizi centrali MondoEdp'}

function TB110FServerMethodsDM.WebServiceEnte(InfoClient: TInfoClient; IdAzienda: String): TRisultato;
// estrae informazioni dell'ente dato id azienda
var
  B110DM: TB110FWebServiceEnteDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FWebServiceEnteDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // no parametri di login

      // imposta parametri specifici
      B110DM.IdAzienda:=IdAzienda;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Servizi centrali MondoEdp'}

{$REGION 'Servizi aziendali'}

{$REGION 'Autenticazione'}

/// <summary>
/// restituisce informazioni sul controllo di autenticazione dell'utente indicato
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <returns>
/// oggetto TRisultato con output nullo
/// </returns>
function TB110FServerMethodsDM.CheckAutenticazione(InfoClient: TInfoClient; DatiLogin: TParametriLogin): TRisultato;
var
  B110DM: TB110FAutenticazioneDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FAutenticazioneDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION}

{$REGION 'VersioneServer'}

/// <summary>
/// restituisce il numero di versione del server datasnap B110
/// </summary>
/// <param name="TipoVersione">
/// tipo di versione richiesta:
///   'PA' = versionePA
///   'AM' = versioneAM
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputVersioneServer,
/// che contiene informazioni sulla versione del server
/// </returns>
function TB110FServerMethodsDM.VersioneServer(TipoVersione: String): TRisultato;
var
  B110DM: TB110FVersioneServerDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FVersioneServerDM.Create(Self);
  try
    try
      // imposta parametri specifici
      B110DM.TipoVersione:=TipoVersione;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'VersioneServer'}

{$REGION 'Dati generali'}

/// <summary>
/// restituisce dati comuni per altri servizi in base alle info di login indicate
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <returns>
/// oggetto TRisultato con output i tipo TOutputDatiGenerali,
/// che contiene diverse informazioni generali utilizzabili nell'app (parametri aziendali, ecc...)
/// </returns>
function TB110FServerMethodsDM.DatiGenerali(InfoClient: TInfoClient; DatiLogin: TParametriLogin): TRisultato;
var
  B110DM: TB110FDatiGeneraliDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FDatiGeneraliDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // nessun parametro specifico

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION}

{$REGION 'Dati giornalieri'}

/// <summary>
/// restituisce alcuni dati giornalieri del cartellino per l'anagrafica associata
/// al login indicato alla data richiesta
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="Data">
/// data alla quale estrarre i conteggi giornalieri del cartellino
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputDatiGiornalieri,
/// che contiene alcuni dati giornalieri dei conteggi
/// </returns>
function TB110FServerMethodsDM.DatiGiornalieri(InfoClient: TInfoClient;
  DatiLogin: TParametriLogin; Data: TDateTime): TRisultato;
// espone i dati giornalieri del cartellino
var
  B110DM: TB110FDatiGiornalieriDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FDatiGiornalieriDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.Data:=Data;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION}

{$REGION 'Autorizzazione richieste giustificativi'}

/// <summary>
/// restituisce un dataset contenente le richieste di giustificativo per l'utente indicato
/// filtrate in base al relativo parametro
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="SoloNumeroRichieste">
/// se True viene restituito solo il conteggio delle richieste filtrate in base al relativo parametro
/// se False viene restituito anche il dataset contenente i dati delle richieste
/// </param>
/// <param name="FiltroRichieste">
/// informazioni di filtro per le richieste da estrarre
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputRichiesteGiust,
///  contenente il numero di richieste estratte ed eventualmente il dataset con i dati delle richieste
/// </returns>
function TB110FServerMethodsDM.RichiesteGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste): TRisultato;
var
  B110DM: TB110FRichiesteGiustDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FRichiesteGiustDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.SoloNumeroRichieste:=SoloNumeroRichieste;
      B110DM.FiltroRichieste:=FiltroRichieste;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// imposta l'autorizzazione per la richiesta di assenza indicata
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="IdRichiesta">
/// id della richiesta da autorizzare
/// </param>
/// <param name="Autorizzazione">
/// stato di autorizzazione da impostare
/// ''  = da autorizzare
/// 'S' = autorizzata
/// 'N' = negata
/// </param>
/// <returns>
/// output nullo
/// </returns>
function TB110FServerMethodsDM.AutorizzaRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  IdRichiesta: Integer; Autorizzazione: String): TRisultato;
var
  B110DM: TB110FAutorizzazioneRichiesteGiustDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FAutorizzazioneRichiesteGiustDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.IdRichiesta:=IdRichiesta;
      B110DM.Autorizzazione:=Autorizzazione;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Autorizzazione richieste giustificativi'}

{$REGION 'Richieste giustificativi'}

/// <summary>
/// restituisce un dataset contenente le richieste di giustificativo per l'utente indicato
/// filtrate in base al relativo parametro
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="FiltroRichieste">
/// informazioni di filtro per le richieste da estrarre
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputRichiesteGiust,
/// contenente il numero di richieste estratte ed eventualmente il dataset con i dati delle richieste
/// </returns>
function TB110FServerMethodsDM.RichiesteGiustDip(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  FiltroRichieste: TFiltriRichieste): TRisultato;
var
  B110DM: TB110FRichiesteGiustDipDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FRichiesteGiustDipDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.FiltroRichieste:=FiltroRichieste;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// effettua l'inserimento della richiesta di giustificativo indicata
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="DatiGiust">
/// dati della richiesta di giustificativo da inserire nel sistema
/// </param>
/// <returns>
/// oggetto TRisultato con ouput di tipo TOutputInsRichiestaGiust,
/// contenente struttura dati per gestione interazione utente
/// </returns>
function TB110FServerMethodsDM.InsRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  DatiGiust: TDatiRichiestaGiust): TRisultato;
var
  B110DM: TB110FInsRichiestaGiustDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FInsRichiestaGiustDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.DatiGiust:=DatiGiust;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// effettua la cancellazione della richiesta di giustificativo indicata
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="DatiGiust">
/// dati della richiesta di giustificativo da eliminare
/// viene utilizzato solo per gestire la struttura dati per l'interazione utente
/// </param>
/// <param name="IdRichiesta">
/// id della richiesta da eliminare
/// </param>
/// <returns>
/// oggetto TRisultato con ouput di tipo TOutputCancRichiestaGiust,
/// contenente struttura dati per gestione interazione utente
/// </returns>
function TB110FServerMethodsDM.CancRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer): TRisultato;
var
  B110DM: TB110FCancRichiestaGiustDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FCancRichiestaGiustDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.DatiGiust:=DatiGiust;
      B110DM.IdRichiesta:=IdRichiesta;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// effettua la revoca della richiesta di giustificativo indicata
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="DatiGiust">
/// dati della richiesta di giustificativo da revocare
/// viene utilizzato solo per gestire la struttura dati per l'interazione utente
/// </param>
/// <param name="IdRichiesta">
/// id della richiesta da revocare
/// </param>
/// <param name="TipoRichiesta">
/// tipo della richiesta da impostare se la revoca va a buon fine
/// (es. 'R' per revoca totale, oppure 'C' per revoca parziale)
/// </param>
/// <param name="Dal">
/// data di inizio del periodo di revoca
/// </param>
/// <param name="Al">
/// data di fine del periodo di revoca
/// </param>
/// <returns>
/// oggetto TRisultato con ouput di tipo TOutputRevocaRichiestaGiust,
/// contenente struttura dati per gestione interazione utente
/// </returns>
function TB110FServerMethodsDM.RevocaRichiestaGiust(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  DatiGiust: TDatiRichiestaGiust; IdRichiesta: Integer; TipoRichiesta: String; Dal: TDateTime; Al: TDateTime): TRisultato;
var
  B110DM: TB110FRevocaRichiestaGiustDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FRevocaRichiestaGiustDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.DatiGiust:=DatiGiust;
      B110DM.IdRichiesta:=IdRichiesta;
      B110DM.TipoRichiesta:=TipoRichiesta;
      B110DM.Dal:=Dal;
      B110DM.Al:=Al;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Richieste giustificativi'}

{$REGION 'Autorizzazione richieste timbrature'}

/// <summary>
/// restituisce un dataset contenente le richieste di timbrature per l'utente indicato
/// filtrate in base al relativo parametro
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="SoloNumeroRichieste">
/// se True viene restituito solo il conteggio delle richieste filtrate in base al relativo parametro
/// se False viene restituito anche il dataset contenente i dati delle richieste
/// </param>
/// <param name="FiltroRichieste">
/// informazioni di filtro per le richieste da estrarre
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputRichiesteTimb,
/// contenente il numero di richieste estratte ed eventualmente il dataset con i dati delle richieste
/// </returns>
function TB110FServerMethodsDM.RichiesteTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  SoloNumeroRichieste: Boolean; FiltroRichieste: TFiltriRichieste): TRisultato;
var
  B110DM: TB110FRichiesteTimbDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FRichiesteTimbDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.SoloNumeroRichieste:=SoloNumeroRichieste;
      B110DM.FiltroRichieste:=FiltroRichieste;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// imposta l'autorizzazione per la richiesta di timbratura indicata
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="IdRichiesta">
/// id della richiesta da autorizzare
/// </param>
/// <param name="Autorizzazione">
/// stato di autorizzazione da impostare
/// ''  = da autorizzare
/// 'S' = autorizzata
/// 'N' = negata
/// </param>
/// <returns>
/// output nullo
/// </returns>
function TB110FServerMethodsDM.AutorizzaRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  IdRichiesta: Integer; Autorizzazione: String): TRisultato;
// imposta l'autorizzazione per la richiesta di timbratura indicata
var
  B110DM: TB110FAutorizzazioneRichiesteTimbDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FAutorizzazioneRichiesteTimbDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.IdRichiesta:=IdRichiesta;
      B110DM.Autorizzazione:=Autorizzazione;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Autorizzazione richieste timbrature'}

{$REGION 'Richieste timbrature'}

/// <summary>
/// restituisce un dataset contenente le richieste di timbratura per l'utente indicato
/// filtrate in base al relativo parametro
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="FiltroRichieste">
/// informazioni di filtro per le richieste da estrarre
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputRichiesteTimb,
/// contenente il numero di richieste estratte ed eventualmente il dataset con i dati delle richieste
/// </returns>
function TB110FServerMethodsDM.RichiesteTimbDip(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  FiltroRichieste: TFiltriRichieste): TRisultato;
var
  B110DM: TB110FRichiesteTimbDipDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FRichiesteTimbDipDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.FiltroRichieste:=FiltroRichieste;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// restituisce un dataset contenente le timbrature modificabili per l'utente indicato
/// e relative alla data indicata
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="DataRif">
/// la data di riferimento per cui estrarre le timbrature che sono potenzialmente
/// oggetto di richiesta di modifica
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputTimbModificabili,
/// contenente il dataset con le timbrature modificabili per la data
/// </returns>
function TB110FServerMethodsDM.TimbModificabili(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  DataRif: TDateTime): TRisultato;
var
  B110DM: TB110FTimbModificabiliDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FTimbModificabiliDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.DataRif:=DataRif;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// effettua l'inserimento della richiesta di timbratura indicata
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="DatiTimb">
/// dati della timbratura da inserire
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputInsRichiestaTimb,
/// contenente la struttura dati per l'interazione con l'utente
/// </returns>
function TB110FServerMethodsDM.InsRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  DatiTimb: TDatiRichiestaTimb): TRisultato;
var
  B110DM: TB110FInsRichiestaTimbDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FInsRichiestaTimbDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.DatiTimb:=DatiTimb;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// effettua la cancellazione della richiesta di timbratura indicata
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="IdRichiesta">
/// id della richiesta da eliminare
/// </param>
/// <returns>
/// oggetto TRisultato con output nullo
/// </returns>
function TB110FServerMethodsDM.CancRichiestaTimb(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  IdRichiesta: Integer): TRisultato;
var
  B110DM: TB110FCancRichiestaTimbDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FCancRichiestaTimbDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.IdRichiesta:=IdRichiesta;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION}

{$REGION 'Stampa cartellino'}

/// <summary>
/// estrae il dataset contenente l'elenco dei cartellini da stampare
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="SoloNumeroCartellini">
/// se True viene restituito solo il conteggio dei cartellini
/// se False viene restituito anche il dataset contenente i mesi dei cartellini
/// </param>
/// <param name="DataInizio">
/// data di inizio periood per la ricerca dei mesi da stampare
/// </param>
/// <param name="DataFine">
/// data di fine periodo per la ricerca dei mesi da stampare
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputCartellini,
/// contenente l'elenco dei cartellini da stampare nel periodo
/// </returns>
function TB110FServerMethodsDM.Cartellini(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  SoloNumeroCartellini: Boolean; DataInizio: TDateTime; DataFine: TDateTime): TRisultato;
var
  B110DM: TB110FCartelliniDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FCartelliniDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.SoloNumeroCartellini:=SoloNumeroCartellini;
      B110DM.DataInizio:=DataInizio;
      B110DM.DataFine:=DataFine;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// produce il file pdf del cartellino del mese indicato con il modello di stampa indicato
/// per l'anagrafica associata all'utente
/// il file è restituito sotto forma di array di byte e va ricostruito lato client
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="MeseCartellino">
/// il mese del cartellino da produrre
/// </param>
/// <param name="CodParamStampa">
/// il codice del modello di stampa da utilizzare
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TByteDynArrayWrapper,
/// contenente un array di byte che rappresenta il file pdf del cartellino richiesto
/// </returns>
function TB110FServerMethodsDM.Cartellino(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  MeseCartellino: TDateTime; CodParamStampa: String): TRisultato;
var
  B110DM: TB110FStampaCartellinoDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FStampaCartellinoDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.MeseCartellino:=MeseCartellino;
      B110DM.CodParamStampa:=CodParamStampa;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Stampa cartellino'}

{$REGION 'Gestione note richieste'}

/// <summary>
/// estrae i dati delle note associate alla richiesta indicata tramite id
/// per l'anagrafica associata all'utente
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="IdRichiesta">
/// id della richiesta per cui estrarre le note
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TNoteRichiesta,
/// contenente le note per ogni livello
/// </returns>
function TB110FServerMethodsDM.NoteRichiesta(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  IdRichiesta: Integer): TRisultato;
var
  B110DM: TB110FNoteRichiestaDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FNoteRichiestaDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.Operazione:=TOperazioneRec.Read;
      B110DM.IdRichiesta:=IdRichiesta;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// aggiorna le note della richiesta indicata tramite id al livello indicato
/// per l'anagrafica associata all'utente
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="IdRichiesta">
/// id della richiesta su cui aggiornare le note
/// </param>
/// <param name="NoteLivello">
/// dati aggiornati della nota (comprensivi di livello e note testuali)
/// </param>
/// <returns>
/// oggetto TRisultato con output nullo
/// </returns>
function TB110FServerMethodsDM.SetNoteRichiesta(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  IdRichiesta: Integer; NoteLivello: TNoteLivello): TRisultato;
var
  B110DM: TB110FNoteRichiestaDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FNoteRichiestaDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.Operazione:=TOperazioneRec.Update;
      B110DM.IdRichiesta:=IdRichiesta;
      B110DM.NoteLivello:=NoteLivello;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Gestione note richieste'}

{$REGION 'Servizi per giustificativi'}

/// <summary>
/// estrae il riepilogo di dati quali competenze e residui della causale di giustificativo indicata
/// per l'anagrafica indicata dal progressivo e con le altre informazioni passate
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="Progressivo">
/// progressivo dell'anagrafica di riferimento
/// </param>
/// <param name="Causale">
/// codice della causale di cui si vuole il riepilogo
/// </param>
/// <param name="Data">
/// data alla quale calcolare le informazioni di riepilogo
/// </param>
/// <param name="DataFamiliare">
/// per le causali di assenza associate ad un familiare, indicare la data di riferimento del familiare
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputRiepilogoAssenze,
/// contenente dati significativi di riepilogo per la causale indicata
/// </returns>
function TB110FServerMethodsDM.RiepilogoAssenze(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  Progressivo: Integer; Causale: String; Data,DataFamiliare: TDateTime): TRisultato;
var
  B110DM: TB110FRiepilogoAssenzeDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FRiepilogoAssenzeDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.Progressivo:=Progressivo;
      B110DM.Causale:=Causale;
      B110DM.Data:=Data;
      B110DM.DataFamiliare:=DataFamiliare;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION}

{$REGION 'Stampa cedolini'}

/// <summary>
/// estrae il dataset contenente l'elenco dei cedolini chiusi per l'anagrafica
/// associata all'utente, nel periodo indicato
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="SoloNumeroCedolini">
/// se True viene restituito solo il conteggio dei cedolini
/// se False viene restituito anche il dataset contenente le informazioni sui cedolini
/// </param>
/// <param name="DataInizio">
/// data di inizio periood per la ricerca dei mesi da stampare
/// </param>
/// <param name="DataFine">
/// data di fine periodo per la ricerca dei mesi da stampare
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputCedolini,
/// contenente l'elenco dei cedolini da stampare nel periodo
/// </returns>
function TB110FServerMethodsDM.Cedolini(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  SoloNumeroCedolini: Boolean; DataInizio: TDateTime; DataFine: TDateTime): TRisultato;
var
  B110DM: TB110FCedoliniDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FCedoliniDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.SoloNumeroCedolini:=SoloNumeroCedolini;
      B110DM.DataInizio:=DataInizio;
      B110DM.DataFine:=DataFine;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// produce il file pdf del cedolino indicato tramite id con le opzioni indicate
/// per l'anagrafica associata all'utente
/// il file è restituito sotto forma di array di byte e va ricostruito lato client
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="IdCedolino">
/// id del cedolino da produrre
/// </param>
/// <param name="CumuloVociArretrate">
/// indica se effettuare il cumulo delle voci arretrate
/// </param>
/// </param>
/// <param name="StampaOrigineVoci">
/// indica se riportare l'origine delle voci di stipendio
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TByteDynArrayWrapper,
/// contenente un array di byte che rappresenta il file pdf del cedolino richiesto
/// </returns>
function TB110FServerMethodsDM.Cedolino(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  IdCedolino: Integer; CumuloVociArretrate: Boolean; StampaOrigineVoci: Boolean): TRisultato;
var
  B110DM: TB110FStampaCedolinoDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FStampaCedolinoDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.IdCedolino:=IdCedolino;
      B110DM.CumuloVociArretrate:=CumuloVociArretrate;
      B110DM.StampaOrigineVoci:=StampaOrigineVoci;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// imposta la data di avvenuta consegna del cedolino sul cedolino indicato tramite id
/// valorizzandola con la data odierna
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="IdCedolino">
/// id del cedolino su cui impostare la data di avvenuta consegna
/// </param>
/// <returns>
/// oggetto TRisultato con output nullo
/// </returns>
function TB110FServerMethodsDM.ImpostaDataConsegnaCedolino(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  IdCedolino: Integer): TRisultato;
var
  B110DM: TB110FConsegnaCedoliniDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FConsegnaCedoliniDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.IdCedolino:=IdCedolino;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Stampa cedolini'}

{$REGION 'Elenco dipendenti'}

/// <summary>
/// estrae l'elenco dei dipendenti compresi nel filtro anagrafe dell'utente
/// alla data indicata
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="DataRiferimento">
/// data alla quale valutare il filtro anagrafe associato all'utente
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputElencoDipendenti,
/// contenente l'elenco dei dipendenti con i seguenti dati anagrafici:
///   • dati anagrafici definiti in L001 con POSIZIONE non nulla,
///     ordinati per POSIZIONE e NOME LOGICO
///   • oltre a questi sono riportati anche i seguenti dati elaborati:
///     - T030PRESENTE:      informazioni di presenza
///     - T030GIUSTIFICATO:  informazioni sui giustificativi nel giorno
///     - T030REPERIBILE:    informazioni di reperibilità nel giorno
/// </returns>
function TB110FServerMethodsDM.Dipendenti(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  DataRiferimento: TDateTime): TRisultato;
var
  B110DM: TB110FElencoDipendentiDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FElencoDipendentiDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.DataRiferimento:=DataRiferimento;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Elenco dipendenti'}

{$REGION 'Timbrature'}

/// <summary>
/// estrae l'elenco delle timbrature effettuate dall'anagrafica associata all'utente
/// nel periodo indicato
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="Dal">
/// data di inizio periodo
/// </param>
/// <param name="Al">
/// data di fine periodo
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputTimbrature,
/// contenente l'elenco delle timbrature effettuate
/// </returns>
function TB110FServerMethodsDM.Timbrature(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  Dal, Al: TDateTime): TRisultato;
var
  B110DM: TB110FTimbratureDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FTimbratureDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.Dal:=Dal;
      B110DM.Al:=Al;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

/// <summary>
/// inserisce la timbratura indicata come timbratura originale
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="DatiTimbratura">
/// struttura dati con le informazioni relative alla timbratura da inserire
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputInsTimbratura,
/// contenente la struttura dati per gestire l'interazione con l'utente
/// </returns>
function TB110FServerMethodsDM.InsTimbratura(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  DatiTimbratura: TDatiTimbratura): TRisultato;
var
  B110DM: TB110FInsTimbraturaDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FInsTimbraturaDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.DatiTimbratura:=DatiTimbratura;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Timbrature'}

{$REGION 'Dizionario'}

/// <summary>
/// estrae dati di tipo dizionario (codice, descrizione) per una serie di tabelle
/// predefinite, con la possibilità di applicare il filtro dizionario associato
/// all'utente
/// </summary>
/// <param name="InfoClient">
/// informazioni sul client che ha effettuato la chiamata al metodo
/// </param>
/// <param name="DatiLogin">
/// informazioni di login dell'utente che ha effettuato la richiesta
/// </param>
/// <param name="Tabella">
/// codice della tabella di cui si vuole estrarre il dizionario
/// sono previste le seguenti tabelle, da costanti in A000UCostanti
/// • B110_DIZ_TAB_I096                livelli iter autorizzativi
/// • B110_DIZ_TAB_SG101               elenco dei familiari
/// • B110_DIZ_TAB_T040_NOTE           note dei giustificativi
/// • B110_DIZ_TAB_T106                elenco motivazioni (tabella di riferimento specificata in Param1)
/// • B110_DIZ_TAB_T257                accorpamenti di causali
/// • B110_DIZ_TAB_T265                causali di assenza
/// • B110_DIZ_TAB_T275                causali di presenza
/// • B110_DIZ_TAB_T275_RICHIEDIBILI   causali di presenza e di giustificazione richiedibili
/// • B110_DIZ_TAB_T361                orologi di timbratura
/// </param>
/// <param name="Param1">
/// parametro specifico legato alla tabella indicata
/// Txxx:
/// </param>
/// <param name="ApplicaFiltroDizionario">
/// se True l'elenco verrà filtrato in base al filtro dizionario associato all'utente
/// se False l'elenco non sarà filtrato
/// Txxx:
/// </param>
/// <returns>
/// oggetto TRisultato con output di tipo TOutputDizionario,
/// contenente l'elenco dei record della tabella richiesta
/// </returns>
function TB110FServerMethodsDM.Dizionario(InfoClient: TInfoClient; DatiLogin: TParametriLogin;
  Tabella: String; Param1: String; ApplicaFiltroDizionario: Boolean): TRisultato;
var
  B110DM: TB110FDizionarioDM;
begin
  EseguiOperazioniComuni;

  // crea datamodule specifico
  B110DM:=TB110FDizionarioDM.Create(Self);
  try
    try
      // imposta versione app
      B110DM.SetInfoClient(InfoClient);

      // imposta parametri di login
      B110DM.SetParametriLogin(DatiLogin);

      // imposta parametri specifici
      B110DM.Tabella:=Tabella;
      B110DM.Param1:=Param1;
      B110DM.ApplicaFiltroDizionario:=ApplicaFiltroDizionario;

      // esegue il metodo
      B110DM.EseguiMetodo;
    except
      on E1: EC200Exception do
      begin
        // eccezione prevista
        B110DM.GetRisultato.AddError(E1.Code,E1.Message,E1.UserMessage);
      end;
      on E2: Exception do
      begin
        // altri tipi di eccezione non previsti
        B110DM.GetRisultato.AddError(Format('%s (%s)',[E2.Message,E2.ClassName]));
      end;
    end;
    Result:=B110DM.GetRisultato;
  finally
    FreeAndNil(B110DM);
  end;
end;

{$ENDREGION 'Dizionario'}

{$ENDREGION 'Metodi specifici per ogni azienda'}

end.

