unit WR000UBaseDM;

interface

uses
  A000UCostanti, A000USessione, A000UMessaggi, A001UPasswordDtM1, C180FunzioniGenerali,
  L021Call, USelI010, DatiBloccati,
  Db, OracleData, Oracle, Variants, Math, DBClient, DateUtils, Windows, JBFService,
  xmldom, msxmldom, XMLDoc, Xml.XMLIntf, Soap.SOAPHTTPClient, ActiveX,
  SysUtils, StrUtils, Classes, Graphics, Controls, Forms,
  IWInit, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IWAppForm, IWApplication,
  IWGlobal, pngimage,
  meIWGrid, meIWLink, System.SyncObjs, System.Contnrs, Vcl.ImgList,
  System.ImageList, IWImageList, meIWImageListCache, meIWImageList;

type
  // thread per invio mail asincrono
  TThreadMail = class(TThread)
  private
    C017DtMTh: TDataModule;
  protected
    procedure Execute; override;
  public
    destructor Destroy; override;
  end;

  TSSORisposta = record
    Utente,
    Profilo: String;
    TimeStamp: TDateTime;
  end;

  TDatiModuliAccessori = record
    Azienda: String;
    Modulo: String;
    Abilitato: Boolean;
  end;

  TModuliAccessori = class(TComponent)
  private
    FModuliArr: array of TDatiModuliAccessori;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Clear;
    function  GetIndex(const PAzienda, PModulo: String): Integer;
    function  Add(const PAzienda, PModulo: String): Boolean;
    function  IsAbilitato(const PAzienda, PModulo: String): Boolean;
  end;

  THistoryTab = record
    F: TIWAppForm;
    LastAdded, Highlight: Boolean;
    Scheda,
    Chiudi: TmeIWLink;
  end;

  THistory = class(TComponent)
  private
    HistoryLinkArr: array of THistoryTab;
    function GetCount: Integer;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assegna(PFormParent: TIWAppForm);
    procedure Clear;
    procedure Disegna(PFormSelezionata: TIWAppForm);
    procedure SetHighlighted(PForm: TIWAppForm);
    function  FormByTag(PTag: Integer): TIWAppForm;
    function  FormByIndex(PIndex: Integer): TIWAppForm;
    function  FormPrev(F: TIWAppForm): TIWAppForm;
    function  FormNext(F: TIWAppForm): TIWAppForm;
    function  FormAdd(F: TIWAppForm): Integer;
    function  FormRemove(PIndex: Integer; ReleaseForm: Boolean = False): Boolean; overload;
    function  FormRemove(PForm: TIWAppForm; ReleaseForm: Boolean = False): Boolean; overload;
    procedure FormReleaseAll;
    property  Count: Integer read GetCount;
  end;

  TWR000FBaseDM = class(TDataModule)
    selaT033: TOracleDataSet;
    selT432: TOracleDataSet;
    selAnagrafe: TOracleDataSet;
    cdsAnagrafe: TClientDataSet;
    cdsI010: TClientDataSet;
    dsrAnagrafe: TDataSource;
    selI015: TOracleDataSet;
    cdsI015: TClientDataSet;
    insT280: TOracleQuery;
    selI091: TOracleDataSet;
    xmlDoc: TXMLDocument;
    selI076: TOracleDataSet;
    OperSQL: TOracleQuery;
    IWImageList: TmeIWImageListCache;
    selAziendeUtente: TOracleDataSet;
    selI040: TOracleDataSet;
    scrI040: TOracleQuery;
    selT960RichiestaAssistenza: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selAnagrafeAfterOpen(DataSet: TDataSet);
  private
    FIpAddressClient:String;
    FClientName:String;
    FPaginaIniziale:String;
    FPaginaSingola:String;
    FResponsabile: Boolean; // utilizzato negli iter autorizzativi
    selI010: TselI010;
    function SessioneOracle: TOracleSession;
    procedure _MailImmediataLst(PDestResponsabile: Boolean; PLstProgressivo, PLstOggetto, PLstTesto: TStringList;
                         const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
                         const PLstDestinatari: TStringList = nil; const PLstDestinatariCC: TStringList = nil; const PLstDestinatariCCN: TStringList = nil);
    procedure _MailImmediata(PDestResponsabile: Boolean; PProgressivo: Integer;
      const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
      const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
    procedure _MailDifferita(PDestResponsabile: Boolean; PProgressivo: Integer;
      const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
      const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
    procedure SetResponsabile(const Value: Boolean);
    function GetRichiestaAssistenza: Boolean;
  public
    LogoutUrl,UsrFolder,BaseFolder: String;
    NumFrameVisualizzati,
    TimeoutDip,
    TimeoutOper: Integer;
    selDatiBloccati: TDatiBloccati;
    lstCompInvisibili: TStringList;
    TagList: TStringList;
    History: THistory;
    TipoUtente:String;            // Dipendente / Supervisore
    //Responsabile: Boolean;        // utilizzato negli iter autorizzativi
    EsisteUtenteI070: Boolean;    // utilizzato per richiamo IrisWeb->IrisCloud->IrisWeb
    ModuliAccessori: TModuliAccessori;
    C700NavigatorBarMain: TmeIWGrid;
    W001FPasswordDtM:TA001FPasswordDtM1;
    procedure CaricaImmagini;
    function  CaricaImmagine(ImgFileCompleto,TagStr:String; AddToLst:Boolean):String;
    function  GetSessioneLogin(DatabaseName:String):Integer;
    function  GetSessioneLavoro:Integer;
    function  SessioneConnessa(OS:TOracleSession):Boolean;
    procedure InizializzazioneW001DtM; virtual;
    function  SessioneDisponibile(Sessione:TOracleSession; CursPerSessione:Integer):Boolean;
    procedure InviaEMail(PDestResponsabile: Boolean; PProgressivo: Integer;
                         const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
                         const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
    procedure InviaLstEMail(PDestResponsabile: Boolean; PLstProgressivo, PLstOggetto, PLstTesto: TStringList;
                         const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
                         const PLstDestinatari: TStringList = nil; const PLstDestinatariCC: TStringList = nil; const PLstDestinatariCCN: TStringList = nil);
    procedure RegistraMessaggioT280(Progressivo:Integer; Flag,Titolo,Log,Testo:String);
    procedure RegistraMailT280(Progressivo:Integer;Titolo,Testo:String;EMail:String = '';EMailCC:String = ''; EMailCCN:String = '');
    procedure MergeSelAnagrafe(ODS:TComponent; _selAnagrafe:TOracleDataSet; RicreaVariabili:Boolean = False);
    function  MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
    procedure CopiaTagFiltroAnag(ODS:TComponent; _selAnagrafe:TOracleDataSet);
    //SSO.ini
    procedure GetParametriSSO(Azienda, Database: String);
    function  SSOTicket(const PTicket,UrlWSAuth: String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
    function  SSOSha1(const PUID, PTime, PHash: String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
    function  SSORdl(const PUID: String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
    procedure CheckTokenUsr(var Risposta:TSSORisposta; Mask:String);
    //function  GetTokenUsr(Utente,Mask:String):String;
    //SSO.fine
    function FormattaUrlWebApp: String;
    procedure AJAXIWCallbackNOP(EventParams: TStringList);
    function  IsCambioAziendaAbilitato: Boolean;
    procedure GetElencoCambioAziende(var RItems: TStringList);

    property IpAddressClient:String read FIpAddressClient write FIpAddressClient;
    property ClientName:String read FClientName write FClientName;
    property PaginaIniziale:String read FPaginaIniziale write FPaginaIniziale;
    property PaginaSingola:String read FPaginaSingola write FPaginaSingola;
    property Responsabile: Boolean read FResponsabile write SetResponsabile;
    property RichiestaAssistenza: Boolean read GetRichiestaAssistenza;
  end;

implementation

uses A000UInterfaccia, C017UEMailDtM, WR010UBase;

{$R *.DFM}

//############################################//
//###       GESTIONE MODULI ACCESSORI      ###//
//############################################//

constructor TModuliAccessori.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(FModuliArr,0);
end;

procedure TModuliAccessori.Clear;
begin
  SetLength(FModuliArr,0);
end;

function TModuliAccessori.GetIndex(const PAzienda, PModulo: String): Integer;
// estrae la posizione nell'array dei moduli accessori
var
  i: Integer;
  D: TDatiModuliAccessori;
begin
  Result:=-1;
  //ricerca nell'array
  for i:=Low(FModuliArr) to High(FModuliArr) do
  begin
    D:=FModuliArr[i];
    if (PAzienda = D.Azienda) and (PModulo = D.Modulo) then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function TModuliAccessori.Add(const PAzienda, PModulo: String): Boolean;
// aggiunge i dati relativi al modulo
// restituisce
// - True se l'elemento è stato inserito,
// - False se era già presente
var
  i, x: Integer;
begin
  if PAzienda = '' then
    raise Exception.Create('L''azienda non è indicata!');
  if PModulo = '' then
    raise Exception.Create('Il modulo non è indicato!');

  i:=GetIndex(PAzienda,PModulo);
  if i = -1 then
  begin
    // modulo non presente nell'array: lo aggiunge
    x:=Length(FModuliArr);
    SetLength(FModuliArr,x + 1);
    FModuliArr[x].Azienda:=PAzienda;
    FModuliArr[x].Modulo:=PModulo;
    FModuliArr[x].Abilitato:=Parametri.ModuloInstallato[PModulo];
    Result:=True;
  end
  else
  begin
    // modulo già presente nell'array
    Result:=False;
  end;
end;

function TModuliAccessori.IsAbilitato(const PAzienda, PModulo: String): Boolean;
// restituisce True/False a seconda che il modulo sia abilitato
var
  i: Integer;
begin
  // estrae la posizione nell'array
  i:=GetIndex(Pazienda, PModulo);
  try
    if i = -1 then
    begin
      // se il modulo non è stato trovato lo aggiunge all'array
      // e ne determina l'abilitazione
      if Add(PAzienda,PModulo) then
        i:=High(FModuliArr)
      else
        raise Exception.Create('Errore durante lettura abilitazioni per il modulo ' + PModulo);
    end;
    Result:=FModuliArr[i].Abilitato;
  except
    on E: Exception do
      try
        Result:=Parametri.ModuloInstallato[PModulo];
      except
        Result:=False
      end;
  end;
end;

//############################################//
//###           GESTIONE HISTORY           ###//
//############################################//
constructor THistory.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(HistoryLinkArr,0);
end;

destructor THistory.Destroy;
begin
  Clear;
  inherited;
end;

procedure THistory.Clear;
var
  i:Integer;
begin
  for i:=0 to High(HistoryLinkArr) do
  begin
    try
      FreeAndNil(HistoryLinkArr[i].Scheda);
      if HistoryLinkArr[i].Chiudi <> nil then
        FreeAndNil(HistoryLinkArr[i].Chiudi);
    except
    end;
  end;
  SetLength(HistoryLinkArr,0);
end;

function THistory.GetCount: Integer;
begin
  try
    Result:=Length(HistoryLinkArr);
  except
    Result:=0;
  end;
end;

procedure THistory.Assegna(PFormParent: TIWAppForm);
// assegna la history (intesa come oggetti che la compongono) alla form
// indicata come parametro, in modo che quest'ultima ne diventi il Parent
var
  i: Integer;
begin
  for i:=0 to High(HistoryLinkArr) do
  begin
    HistoryLinkArr[i].Scheda.Parent:=PFormParent;
    if not (HistoryLinkArr[i].F as TWR010FBase).medpFissa then
      HistoryLinkArr[i].Chiudi.Parent:=PFormParent;
  end;
end;

procedure THistory.Disegna(PFormSelezionata: TIWAppForm);
// ridisegna la grafica della history, evidenziando come selezionata la form
// passata come parametro
var
  i: Integer;
  S1,S2,NomeTab,Classe,Effetto: String;
  Scheda,Chiudi: TmeIWLink;
  TmpForm: TWR010FBase;
begin
  if ((PFormSelezionata as TWR010FBase).IsLoginForm) or
     (Length(HistoryLinkArr) = 0) then
  begin
    S1:='';
    S2:='';
  end
  else
  begin
    if (WR000DM.PaginaSingola <> '') and (WR000DM.PaginaSingola = WR000DM.PaginaIniziale) then
      S1:='document.getElementById("bndHistory").className = "invisibile";' + CRLF
    else
      S1:='document.getElementById("bndHistory").className = "";' + CRLF;
    S2:='';
    for i:=0 to High(HistoryLinkArr) do
    begin
      Scheda:=HistoryLinkArr[i].Scheda;
      TmpForm:=(HistoryLinkArr[i].F as TWR010FBase);

      // 1. gestione scheda
      NomeTab:='tab' + Copy(Scheda.Name,4);
      Effetto:='';
      if PFormSelezionata = TmpForm then
      begin
        // la form è quella selezionata
        if HistoryLinkArr[i].LastAdded then
          Effetto:='.fadeIn(400)'
        else if HistoryLinkArr[i].Highlight then
        begin
          Effetto:='';
          HistoryLinkArr[i].Highlight:=False;
        end
        else
          Effetto:='';
        Classe:='history sel';
        Scheda.OnClick:=nil; // il tab non deve essere cliccabile
      end
      else
      begin
        // la form non è quella selezionata
        // se la form selezionata è modale disabilita la selezione degli altri tab
        if (PFormSelezionata as TWR010FBase).medpModale then
        begin
          Classe:='history disab';
          Scheda.OnClick:=nil;
        end
        else
        begin
          Classe:='history';
          Scheda.OnClick:=(PFormSelezionata as TWR010FBase).actLinkSelect;
        end;
      end;
      // aggiorna dati della scheda
      Scheda.Caption:=(TmpForm as TWR010FBase).medpNomeFunzione;
      Scheda.Hint:=(TmpForm as TWR010FBase).medpInfoFunzione;
      Scheda.ShowHint:=(Scheda.Hint <> '');
      Scheda.Css:='scheda' + IfThen(Scheda.ShowHint,' tooltipHistory');
      Scheda.Parent:=PFormSelezionata; // imposta come parent la form selezionata: molto importante!

      // effetti di visualizzazione tab
      S1:=S1 + Format('document.getElementById("%s").className = "%s";',[NomeTab,IfThen(Effetto = '',Classe,'invisibile')]) + CRLF;
      if Effetto <> '' then
        S2:=S2 + Format('jQuery.root.find("#%s").addClass("%s")%s;',[NomeTab,Classe,Effetto]) + CRLF;

      // 2. gestione immagine di chiusura tab
      // gestisce la chiusura solo se la form non è fissa
      // (altrimenti il link non esiste)
      if not TmpForm.medpFissa then
      begin
        Chiudi:=HistoryLinkArr[i].Chiudi;
        // se la form selezionata è modale disabilita la chiusura degli altri tab
        if (PFormSelezionata <> TmpForm) and
           ((PFormSelezionata as TWR010FBase).medpModale) then
          Chiudi.OnClick:=nil
        else
          Chiudi.OnClick:=(PFormSelezionata as TWR010FBase).actLinkClose;
        Chiudi.Parent:=PFormSelezionata;
      end;

      // altre impostazioni
      HistoryLinkArr[i].LastAdded:=False;
    end;
  end;

  // impostazioni per disegno history ed effetti
  (PFormSelezionata as TWR010FBase).TagJsHistory:=S1; // utilizzato come tag nell'intestazione T000
  if (PFormSelezionata as TWR010FBase).jQHistory.Enabled then
    (PFormSelezionata as TWR010FBase).jQHistory.OnReady.Text:=S2;
end;

procedure THistory.SetHighlighted(PForm: TIWAppForm);
// inutilizzato
// segna la form indicata come da evidenziare graficamente
var
  i: Integer;
  Found: Boolean;
begin
  Found:=False;
  for i:=0 to High(HistoryLinkArr) do
  begin
    if PForm = HistoryLinkArr[i].F then
    begin
      Found:=True;
      Break;
    end;
  end;

  if Found then
    HistoryLinkArr[i].Highlight:=True;
end;

function THistory.FormByTag(PTag: Integer): TIWAppForm;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to High(HistoryLinkArr) do
  begin
    if PTag = HistoryLinkArr[i].F.Tag then
    begin
      Result:=HistoryLinkArr[i].F;
      Break;
    end;
  end;
end;

function THistory.FormByIndex(PIndex: Integer): TIWAppForm;
begin
  if (PIndex >= 0) and
     (PIndex < Length(HistoryLinkArr)) then
    Result:=HistoryLinkArr[PIndex].F
  else
    Result:=nil;
end;

function THistory.FormPrev(F: TIWAppForm): TIWAppForm;
// estrae la form precedente a quella indicata nella history
var
  i: Integer;
begin
  Result:=nil;

  if Length(HistoryLinkArr) = 0 then
    Exit;

  // se si tratta della prima form -> restituisce nil
  if F = HistoryLinkArr[0].F then
    Exit;

  // ciclo di ricerca elemento
  for i:=1 to High(HistoryLinkArr) do
    if F = HistoryLinkArr[i].F then
    begin
      Result:=HistoryLinkArr[i - 1].F;
      Break;
    end;
end;

function THistory.FormNext(F: TIWAppForm): TIWAppForm;
// estrae la form successiva a quella indicata nella history
var
  i: Integer;
begin
  Result:=nil;

  if Length(HistoryLinkArr) = 0 then
    Exit;

  // se si tratta dell'ultima form -> restituisce nil
  if F = HistoryLinkArr[High(HistoryLinkArr)].F then
    Exit;

  // ciclo di ricerca elemento
  for i:=High(HistoryLinkArr) - 1 downto 0 do
    if F = HistoryLinkArr[i].F then
    begin
      Result:=HistoryLinkArr[i + 1].F;
      Break;
    end;
end;

function THistory.FormAdd(F: TIWAppForm): Integer;
// aggiunge la form indicata alla history
// e restituisce la posizione dell'array in cui è stata aggiunta
// oppure -1 in caso di errore
var
  i: Integer;
begin
  if Length(HistoryLinkArr) >= ELEMENTI_HISTORY then
  begin
    // shift a sx dell'elenco per fare spazio alla nuova form
    // (si perde la prima form non "fissa")
    //Rimuove la prima form non fissa per la quale si può chiudere il tab
    //e senza richiesta di conferma
    for i:=0 to High(HistoryLinkArr) do
    begin
      HistoryLinkArr[i].Scheda.Parent:=nil;
      if HistoryLinkArr[i].Chiudi <> nil then
        HistoryLinkArr[i].Chiudi.Parent:=nil;
    end;
    for i:=0 to High(HistoryLinkArr) do
      if FormRemove(i,True) then
        Break;
  end;

  // aggiunge il corrispondente nuovo "tab"
  SetLength(HistoryLinkArr,Length(HistoryLinkArr) + 1);
  i:=High(HistoryLinkArr);

  // form
  HistoryLinkArr[i].F:=F;
  HistoryLinkArr[i].LastAdded:=True;
  HistoryLinkArr[i].HighLight:=False;

  // scheda
  HistoryLinkArr[i].Scheda:=TmeIWLink.Create(Self);
  HistoryLinkArr[i].Scheda.Name:=Format('lnkHistory%.2d',[i + 1]);
  HistoryLinkArr[i].Scheda.Tag:=i;

  // link di chiusura funzione
  if not TWR010FBase(F).medpFissa then
  begin
    HistoryLinkArr[i].Chiudi:=TmeIWLink.Create(Self);
    HistoryLinkArr[i].Chiudi.Name:=Format('lnkHistoryX%.2d',[i + 1]);
    HistoryLinkArr[i].Chiudi.Caption:=' ';
    HistoryLinkArr[i].Chiudi.Tag:=i;
    HistoryLinkArr[i].Chiudi.Css:='chiudi';
    HistoryLinkArr[i].Chiudi.Hint:=A000TraduzioneStringhe(A000MSG_MSG_CHIUDI_SCHEDA);
    HistoryLinkArr[i].Chiudi.ShowHint:=True;
  end;

  Result:=i;
end;

function THistory.FormRemove(PIndex: Integer; ReleaseForm: Boolean = False): Boolean;
// rimuove la form indicata dalla history
var
  i: Integer;
begin
  Result:=False;
  if (PIndex < Low(HistoryLinkArr)) or
     (PIndex > High(HistoryLinkArr)) then
    Exit;

  if HistoryLinkArr[PIndex].F <> nil then
  begin
    // gestione form "fisse"
    if TWR010FBase(HistoryLinkArr[PIndex].F).medpFissa then
      Exit;

    // se richiesto distrugge la form
    if ReleaseForm then
    begin
      try
        HistoryLinkArr[PIndex].F.Release;
      except
      end;
    end;
  end;

  // pulizia elemento
  HistoryLinkArr[PIndex].F:=nil;
  FreeAndNil(HistoryLinkArr[PIndex].Scheda);
  FreeAndNil(HistoryLinkArr[PIndex].Chiudi);

  // shift a sinistra delle altre form
  for i:=PIndex to High(HistoryLinkArr) - 1 do
  begin
    HistoryLinkArr[i]:=HistoryLinkArr[i + 1];
    // importante: aggiorna i nomi e i tag dei link
    HistoryLinkArr[i].Scheda.Name:=Format('lnkHistory%.2d',[i + 1]);
    HistoryLinkArr[i].Scheda.Tag:=i;
    HistoryLinkArr[i].Chiudi.Name:=Format('lnkHistoryX%.2d',[i + 1]);
    HistoryLinkArr[i].Chiudi.Tag:=i;
  end;

  // decrementa lunghezza array
  SetLength(HistoryLinkArr,Length(HistoryLinkArr) - 1);
  Result:=True;
end;

function THistory.FormRemove(PForm: TIWAppForm; ReleaseForm: Boolean = False): Boolean;
// rimuove la form indicata dalla history
var
  i: Integer;
begin
  Result:=False;
  for i:=0 to High(HistoryLinkArr) do
  begin
    if PForm = HistoryLinkArr[i].F then
    begin
      Result:=FormRemove(i,ReleaseForm);
      Break;
    end;
  end;
end;

procedure THistory.FormReleaseAll;
// release di tutte le form presenti nella history
var
  i: Integer;
  F: TIWAppForm;
begin
  for i:=High(HistoryLinkArr) downto 0 do
  begin
    if not FormRemove(i,True) then
    begin
      // la form non è eliminabile: la seleziona e termina il ciclo
      F:=FormByIndex(i);
      Assegna(F);
      SetHighlighted(F);
      (F as TWR010FBase).RefreshPageAttivo:=True;
      (F as TWR010FBase).Show;
      Break;
    end;
  end;
end;


//############################################//
//###         GESTIONE DATAMODULE          ###//
//############################################//
function TWR000FBaseDM.SessioneOracle: TOracleSession;
begin
  Result:=TSessioneWeb(TIWApplication(Owner).Data).SessioneIrisWIN.SessioneOracle;
end;

procedure TWR000FBaseDM.SetResponsabile(const Value: Boolean);
begin
  FResponsabile := Value;
end;

procedure TWR000FBaseDM.DataModuleCreate(Sender: TObject);
// questa funzione viene richiamata due volte
// evitare l'utilizzo di GGetWebApplicationThreadVar, che in alcuni casi potrebbe
// non essere inizializzato
// utilizzare invece Owner (facendo il downcast a TIWApplication)
var
  i: Integer;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - if Owner = nil');
  // Owner dovrebbe essere TIWApplication
  // dare errore se è nil
  if Owner = nil then
  begin
    W000RegistraLog('Errore',Format('%sDataModuleCreate: Owner = nil',[GetTestoLog('WR000')]));
    Exit;
  end;

  DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - if Owner <> nil');
  // assegnazione sessione oracle
  if (Owner as TIWApplication).Data <> nil then
  begin
    for i:=0 to ComponentCount - 1 do
    begin
      if Components[i] is TOracleQuery then
        try (Components[i] as TOracleQuery).Session:=SessioneOracle; except end
      else if Components[i] is TOracleDataSet then
        try (Components[i] as TOracleDataSet).Session:=SessioneOracle; except end;
    end;

    DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - selI010.Create');
    if selI010 = nil then
      selI010:=TselI010.Create((Owner as TIWApplication));

    DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - selDatiBloccati.Create');
    if selDatiBloccati = nil then
    begin
      selDatiBloccati:=TDatiBloccati.Create(nil);
      selDatiBloccati.TipoLog:='';
    end;
  end;

  DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - lstCompInvisibili.Create');
  // gestione campi da non visualizzare
  if lstCompInvisibili = nil then
  begin
    lstCompInvisibili:=TStringList.Create;
    lstCompInvisibili.CommaText:=UpperCase(W000ParConfig.CampiInvisibili);
  end;

  DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - History.Create');
  // creazione history
  if History = nil then
    History:=THistory.Create(Self)
  else
    History.Clear;

  DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - ModuliAccessori.Create');
  // creazione struttura per moduli accessori
  if ModuliAccessori = nil then
    ModuliAccessori:=TModuliAccessori.Create(Self)
  else
    ModuliAccessori.Clear;

  DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - inizializzazione variabili');
  // inizializzazione variabili
  LogoutUrl:='';
  NumFrameVisualizzati:=0;
  TimeoutDip:=W000ParConfig.TimeoutDip;
  TimeoutOper:=W000ParConfig.TimeoutOper;

  DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - C90_W038CheckIP');
  // imposta le variabili per il dataset del filtro IP
  if (Parametri <> nil) and
     (Parametri.CampiRiferimento.C90_W038CheckIP = 'S') then
  begin
    selI076.Close;
    selI076.SetVariable('AZIENDA',Parametri.Azienda);
    // in irisweb non si considera l'applicazione
    //selI076.SetVariable('APPLICAZIONE',Parametri.Applicazione);
    selI076.SetVariable('PROFILO',Parametri.ProfiloFiltroFunzioni);
    selI076.Open;
    if selI076.RecordCount = 0 then
    begin
      Parametri.CampiRiferimento.C90_W038CheckIP:='N';
      selI076.Close;
    end;
  end;

  DebugToFile(GGetWebApplicationThreadVar,'TWR000FBaseDM.DataModuleCreate - end');
end;

function TWR000FBaseDM.GetSessioneLogin(DatabaseName:String):Integer;
var i:Integer;
    OS:TOracleSession;
begin
  Result:=-1;
  begin
    CSSessioneMondoEDP.Enter;
    try
      for i:=0 to lstSessioniMondoEDP.Count - 1 do
      begin
        if Pos(INI_PAR_NO_SHARED_LOGIN,W000ParConfig.ParametriAvanzati) > 0 then
          Break;
        try
          if TOracleSession(lstSessioniMondoEDP[i]) = nil then
            Continue;
          if not Assigned(TOracleSession(lstSessioniMondoEDP[i])) then
            Continue;
          if TOracleSession(lstSessioniMondoEDP[i]).LogonDatabase <> DatabaseName then
            Continue;
          if (TOracleSession(lstSessioniMondoEDP[i]).Tag > 0) and (not WR000DM.SessioneDisponibile(TOracleSession(lstSessioniMondoEDP[i]),W000ParConfig.CursoriLogin)) then
            Continue;
          if not TOracleSession(lstSessioniMondoEDP[i]).Connected then
          try
            TOracleSession(lstSessioniMondoEDP[i]).Logon;
          except
            Continue;
          end;
          if (Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0) and
             (TOracleSession(lstSessioniMondoEDP[i]).CheckConnection(W000ParConfig.ReconnectSession) = ccError) then
            Continue;
        except
          Continue;
        end;
        TOracleSession(lstSessioniMondoEDP[i]).Tag:=TOracleSession(lstSessioniMondoEDP[i]).Tag + 1;
        Result:=i;
        Break;
      end;
      if Result = -1 then
      begin
        OS:=TOracleSession.Create(nil);
        OS.NullValue:=nvNull;
        OS.Preferences.ZeroDateIsNull:=False;
        OS.Preferences.TrimStringFields:=False;
        OS.Preferences.UseOCI7:=False;
        OS.BytesPerCharacter:=bc1Byte;
        OS.Cursor:=crSQLWait;
        OS.ThreadSafe:=True;
        OS.Tag:=1;
        OS.StatementCache:=Pos(INI_PAR_DB_STATEMENT_CACHE,W000ParConfig.ParametriAvanzati) > 0;
        if OS.StatementCache then
          OS.StatementCacheSize:=50;
        lstSessioniMondoEDP.Add(OS);
        Result:=lstSessioniMondoEDP.Count - 1;
      end;
      if W001FPassWordDtM <> nil then
        W001FPassWordDtM.SessioneMondoEDP:=TOracleSession(lstSessioniMondoEDP[Result]);
    finally
      CSSessioneMondoEDP.Leave;
    end;
  end;
end;

function TWR000FBaseDM.GetSessioneLavoro:Integer;
var i:Integer;
    OS:TOracleSession;
begin
  Result:=-1;
  CSSessioniOracle.Enter;
  try
    for i:=0 to lstSessioniOracle.Count - 1 do
    begin
      try
        if TOracleSession(lstSessioniOracle[i]) = nil then
          Continue;
        if not Assigned(TOracleSession(lstSessioniOracle[i])) then
          Continue;
        //Verifico se sessione corrispondente all'azienda di login
        if (TOracleSession(lstSessioniOracle[i]).LogonUserName <> Parametri.UserName) or
           (TOracleSession(lstSessioniOracle[i]).LogonDatabase <> Parametri.DataBase) then
          Continue;
        //Verifico se cursori disponibili sulla sessione
        {$IFNDEF WEBPJ}
        if (TOracleSession(lstSessioniOracle[i]).Tag > 0) and (not WR000DM.SessioneDisponibile(TOracleSession(lstSessioniOracle[i]),W000ParConfig.CursoriSessione)) then
          Continue;
        {$ELSE}
        //Per IrisCLOUD una sessione oracle per ogni sessione web. se però la sessione è scaduta
        //riutilizzo la connessione db (tag 0 non usata da nessuno) e non ne creo una ulteriore
        if (TOracleSession(lstSessioniOracle[i]).Tag > 0)then
          Continue;
        {$ENDIF}
        //Verifico se sessione correttamente collegata al db in base al parametro INI_PAR_DB_NO_CHECK_CONNECTION
        if not TOracleSession(lstSessioniOracle[i]).Connected then
        try
          TOracleSession(lstSessioniOracle[i]).Logon;
        except
          Continue;
        end;
        if (Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0) and
           (TOracleSession(lstSessioniOracle[i]).CheckConnection(W000ParConfig.ReconnectSession) = ccError) then
          Continue;
        //Verifico definitivamente se sessione disponibile
        if not SessioneConnessa((lstSessioniOracle[i] as TOracleSession)) then
        begin
          try TOracleSession(lstSessioniOracle[i]).Logoff; except end;
          try
            TOracleSession(lstSessioniOracle[i]).Logon;
          except
            Continue;
          end;
        end;
      except
        Continue;
      end;

      if (lstSessioniOracle[i] as TOracleSession).Tag = 0 then
        A000ParamDBOracle(lstSessioniOracle[i] as TOracleSession, False)
      else
        A000SetParametri(lstSessioniOracle[i] as TOracleSession);

      (lstSessioniOracle[i] as TOracleSession).Tag:=(lstSessioniOracle[i] as TOracleSession).Tag + 1;
      if (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Name <> 'SessioneIrisWEB' then
        try FreeAndNil((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle);(*.Free;*) except end;
      (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle:=(lstSessioniOracle[i] as TOracleSession);
      Result:=i;
      Break;
    end;

    if Result = -1 then
    begin
      OS:=TOracleSession.Create(nil);
      OS.Name:='SessioneIrisWEB';
      OS.NullValue:=nvNull;
      OS.Preferences.ZeroDateIsNull:=False;
      OS.Preferences.TrimStringFields:=False;
      OS.Preferences.UseOCI7:=False;
      OS.BytesPerCharacter:=bc1Byte;
      OS.Cursor:=crSQLWait;
      OS.ThreadSafe:=True;
      OS.MessageTable:='MONDOEDP.I018_ORACLEMESSAGE';
      OS.Tag:=1;
      OS.StatementCache:=Pos(INI_PAR_DB_STATEMENT_CACHE,W000ParConfig.ParametriAvanzati) > 0;
      if OS.StatementCache then
        OS.StatementCacheSize:=100;
      A000ParamDBOracle(OS);
      lstSessioniOracle.Add(OS);
      Result:=lstSessioniOracle.Count - 1;
      if (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Name <> 'SessioneIrisWEB' then
        try FreeAndNil((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle);(*.Free;*) except end;
      (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle:=OS;
    end;
  finally
    if Result >= 0 then
      try (lstSessioniOracle[Result] as TOracleSession).UseOCI80:=True; except end;
    IndennitaTurno:=True;
    CSSessioniOracle.Leave;
  end;
end;

function TWR000FBaseDM.SessioneConnessa(OS:TOracleSession):Boolean;
begin
  Result:=True;
  with TOracleQuery.Create(nil) do
  try
    Session:=OS;
    SQL.Text:='select * from dual';
    try
      Execute;
    except
      Result:=False;
    end;
  finally
    Free;
  end;
end;

procedure TWR000FBaseDM.InizializzazioneW001DtM;
var
  i: Integer;
  Ricerca,Posizione: Boolean;
  ElencoCampi,CampoCaptionLayout,CampiV430: String;
  CampiT030: string;
begin
  begin
    selaT033.Open;
    try
      if selaT033.SearchRecord('NOME',Parametri.Layout,[srFromBeginning]) then
        Parametri.Layout:=selaT033.FieldByName('NOME').AsString
      else if selaT033.SearchRecord('NOME',Parametri.Operatore,[srFromBeginning]) then
        Parametri.Layout:=selaT033.FieldByName('NOME').AsString
      else
        Parametri.Layout:='DEFAULT';
    except;
      Parametri.Layout:='DEFAULT';
    end;
    // data lavoro.ini
    R180SetVariable(selT432,'UTENTE',Parametri.Operatore);
    selT432.Open;
    if (selT432.RecordCount > 0) and
       (not selT432.FieldByName('DATA').IsNull) then
      Parametri.DataLavoro:=selT432.FieldByName('DATA').AsDateTime
    else
      Parametri.DataLavoro:=Date;
    selT432.CloseAll;
    // data lavoro.fine
    selaT033.CloseAll;

    //selI010
    CampoCaptionLayout:=IfThen(Pos(INI_PAR_CAPTION_LAYOUT,W000ParConfig.ParametriAvanzati) = 0,'NOME_LOGICO','CAPTION_LAYOUT||DECODE(CAMPO_DESCRIZIONE,0,NULL,'' (desc.)'')');
    ElencoCampi:=Format('NOME_CAMPO,DATA_TYPE,DATA_LENGTH,NOME_LOGICO,%s CAPTION_LAYOUT,RICERCA,POSIZIONE,ACCESSO',[CampoCaptionLayout]);
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini
    // aggiunta dati di T033 finalizzati all'ordinamento della scheda anagrafe
    ElencoCampi:=ElencoCampi + ',NOMEPAGINA,decode(NOMEPAGINA,''Dati Anagrafici'',''0'',''Parametri orario'',''1'',''Presenze/Assenze'',''2'',NOMEPAGINA) NOMEPAGINA_ORD,TOP,LFT';
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.fine
    selI010.UsaCampiI060:=True;//False;//Per abilitare la visualizzazione sulla griglia di Email, EMailPec, Cellulare
    selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,ElencoCampi,'','RICERCA,POSIZIONE,NOME_LOGICO');
    cdsI010.Close;
    cdsI010.FieldDefs.Assign(selI010.FieldDefs);
    cdsI010.CreateDataSet;
    cdsI010.LogChanges:=False;
    cdsI010.IndexDefs.Clear;
    cdsI010.IndexDefs.Add('Visualizzazione',('POSIZIONE;NOME_LOGICO'),[ixPrimary,ixUnique]);
    cdsI010.IndexDefs.Add('Ricerca',('RICERCA;POSIZIONE;NOME_LOGICO'),[ixPrimary,ixUnique]);
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini
    // aggiunta indice per visualizzazione scheda anagrafe
    cdsI010.IndexDefs.Add('Layout',('NOMEPAGINA_ORD;TOP;LFT;NOME_LOGICO'),[ixPrimary,ixUnique]);
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.fine
    CampiV430:='';
    Parametri.ColonneStruttura.Clear;
    Parametri.TipiStruttura.Clear;
    selI010.First;
    while not selI010.Eof do
    begin
      cdsI010.Append;
      for i:=0 to selI010.FieldCount - 1 do
      begin
        Ricerca:=(UpperCase(selI010.Fields[i].FieldName) = 'RICERCA');
        Posizione:=(UpperCase(selI010.Fields[i].FieldName) = 'POSIZIONE');
        // i valori nulli dei campi RICERCA e POSIZIONE sono sostituiti con un valore numerico molto elevato
        if (Ricerca or Posizione) and (selI010.Fields[i].IsNull) then
          cdsI010.Fields[i].Value:=IfThen(Ricerca,RICERCA_NULL,POSIZIONE_NULL)
        else
          // copia del valore nel campo del clientdataset
          cdsI010.Fields[i].Value:=selI010.Fields[i].Value;
      end;
      cdsI010.Post;
      if ((Copy(cdsI010.FieldByName('NOME_CAMPO').AsString,1,4) = 'T430') or
          (Copy(cdsI010.FieldByName('NOME_CAMPO').AsString,1,4) = 'P430')) and
          //(cdsI010.FieldByName('POSIZIONE').Value <> POSIZIONE_NULL) and
          (cdsI010.FieldByName('ACCESSO').AsString <> 'N') then
        CampiV430:=CampiV430 + 'V430.' + cdsI010.FieldByName('NOME_CAMPO').AsString + ','

      //Tentativo di includere anche i dati della I060, se abilitati sul Layout
      //Attenzione: si deve intervenire sulla selI010 (UselI010)
      else if (cdsI010.FieldByName('NOME_CAMPO').AsString = 'I060EMAIL') and
              (cdsI010.FieldByName('ACCESSO').AsString <> 'N') then
        CampiV430:=CampiV430 + 'I060F_DATO(''' + Parametri.Azienda + ''',PROGRESSIVO,''EMAIL'') ' + cdsI010.FieldByName('NOME_CAMPO').AsString + ','
      else if (cdsI010.FieldByName('NOME_CAMPO').AsString = 'I060EMAILPEC') and
              (cdsI010.FieldByName('ACCESSO').AsString <> 'N') then
        CampiV430:=CampiV430 + 'I060F_DATO(''' + Parametri.Azienda + ''',PROGRESSIVO,''EMAIL_PEC'') ' + cdsI010.FieldByName('NOME_CAMPO').AsString + ','
      else if (cdsI010.FieldByName('NOME_CAMPO').AsString = 'I060CELLULARE') and
              (cdsI010.FieldByName('ACCESSO').AsString <> 'N') then
        CampiV430:=CampiV430 + 'I060F_DATO(''' + Parametri.Azienda + ''',PROGRESSIVO,''CELLULARE'') ' + cdsI010.FieldByName('NOME_CAMPO').AsString + ',';

      Parametri.ColonneStruttura.Add(Format('%s=%s',[selI010.FieldByName('NOME_LOGICO').AsString,selI010.FieldByName('NOME_CAMPO').AsString]));
      if selI010.FieldByName('DATA_TYPE').AsString = 'VARCHAR2' then
        Parametri.TipiStruttura.Add(IntToStr(Ord(ftString)))
      else if selI010.FieldByName('DATA_TYPE').AsString = 'NUMBER' then
        Parametri.TipiStruttura.Add(IntToStr(Ord(ftInteger)))
      else if selI010.FieldByName('DATA_TYPE').AsString = 'DATE' then
        Parametri.TipiStruttura.Add(IntToStr(Ord(ftDateTime)));
      selI010.Next;
    end;
    FreeAndNil(selI010);
    if CampiV430 <> '' then
      CampiV430:=',' + Copy(CampiV430,1,Length(CampiV430) - 1);
    if Pos(',V430.T430BADGE,',',' + CampiV430 + ',') = 0 then
      CampiV430:=CampiV430 + ',V430.T430BADGE';

    selAnagrafe.SQL.Clear;
    selAnagrafe.SQL.Text:=QVistaOracle;
    CampiT030:='T030.MATRICOLA, T030.PROGRESSIVO, T030.COGNOME, T030.NOME, T030.SESSO, T030.DATANAS, T030.COMUNENAS, T030.CAPNAS, T030.CODFISCALE, T030.INIZIOSERVIZIO, T030.TIPO_PERSONALE, T030.TIPO_SOGGETTO_BASE'; //esclude T030.RAPPORTI_UNITI,
    selAnagrafe.SQL.Insert(0,Format('SELECT %s %s,T480.CITTA, T480.PROVINCIA %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,CampiT030,CampiV430]));
    selAnagrafe.SQL.Add(':FILTRO_IN_SERVIZIO');
    selAnagrafe.SQL.Add(':FILTRO');
    selAnagrafe.DeleteVariables;
    selAnagrafe.DeclareVariable('DATALAVORO',otDate);
    selAnagrafe.DeclareVariable('FILTRO',otSubst);
    selAnagrafe.DeclareVariable('FILTRO_IN_SERVIZIO',otSubst);

    // utilizzo di clientdataset per localizzazione
    Parametri.cdsI015:=nil;
    selI015.SetVariable('AZIENDA',Parametri.Azienda);
    selI015.SetVariable('LINGUA',UpperCase(Parametri.CampiRiferimento.C90_Lingua));
    selI015.SetVariable('APPLICAZIONE','W000');
    try
      selI015.Open;
      cdsI015.Filtered:=False;
      cdsI015.Close;
      cdsI015.FieldDefs.Assign(selI015.FieldDefs);
      cdsI015.FieldDefs.Find('CAPTION').Required:=False;
      cdsI015.CreateDataSet;
      cdsI015.LogChanges:=False;
      cdsI015.IndexDefs.Clear;
      cdsI015.IndexDefs.Add('Primario',('LINGUA;APPLICAZIONE;MASCHERA'),[]);
      selI015.First;
      while not selI015.Eof do
      begin
        cdsI015.Append;
        for i:=0 to selI015.FieldCount - 1 do
          cdsI015.Fields[i].Value:=selI015.Fields[i].Value;
        cdsI015.Post;
        selI015.Next;
      end;
      if cdsI015.RecordCount > 0 then
        Parametri.cdsI015:=cdsI015;
    except
    end;
    selI015.CloseAll;
  end;
end;

function TWR000FBaseDM.SessioneDisponibile(Sessione:TOracleSession; CursPerSessione:Integer):Boolean;
var MOC:Integer;
begin
  MOC:=W000ParConfig.MaxOpenCursors;
  Result:=MOC - (Sessione.Tag * CursPerSessione) > CursPerSessione;
end;

//############################################//
//###             INVIO MAIL               ###//
//############################################//
procedure TWR000FBaseDM.InviaEMail(PDestResponsabile: Boolean; PProgressivo: Integer;
  const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
  const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
begin
  if Parametri.CampiRiferimento.C90_EmailThread = 'S' then
  begin
    // gestione invio mail con thread separato
    _MailDifferita(PDestResponsabile,PProgressivo,POggetto,PTesto,PTag,PIter,PCodIter,PLivelliDest,PDestinatari,PDestinatariCC,PDestinatariCCN);
  end
  else
  begin
    // gestione invio mail normale
    _MailImmediata(PDestResponsabile,PProgressivo,POggetto,PTesto,PTag,PIter,PCodIter,PLivelliDest,PDestinatari,PDestinatariCC,PDestinatariCCN);
  end;
end;

procedure TWR000FBaseDM.InviaLstEMail(PDestResponsabile: Boolean; PLstProgressivo, PLstOggetto, PLstTesto: TStringList; const PTag: Integer; const PIter, PCodIter, PLivelliDest: String;
  const PLstDestinatari, PLstDestinatariCC, PLstDestinatariCCN: TStringList);
begin
  //PALERMO_POLICLINICO - 163352 - da completare: invio mail senza aprire-chiudere la connessione per ogni mail
  if Parametri.CampiRiferimento.C90_EmailThread = 'S' then
  begin
    // gestione invio mail con thread separato
    //_MailDifferita(PDestResponsabile,PProgressivo,POggetto,PTesto,PTag,PIter,PCodIter,PLivelliDest,PDestinatari,PDestinatariCC,PDestinatariCCN);
  end
  else
  begin
    //Inizializza config mail
    _MailImmediataLst(PDestResponsabile, PLstProgressivo, PLstOggetto, PLstTesto, PTag, PIter, PCodIter,
                         PLivelliDest,PLstDestinatari, PLstDestinatariCC, PLstDestinatariCCN);
  end;
end;

procedure TWR000FBaseDM.selAnagrafeAfterOpen(DataSet: TDataSet);
var
  NomeCampo: String;
  PosizioneNulla: Boolean;
begin
  if (cdsI010 <> nil) and (cdsI010.Active) then
  begin
    cdsI010.IndexName:='Visualizzazione';
    cdsI010.Filtered:=False;
    cdsI010.First;
    while not cdsI010.Eof do
    begin
      try
        NomeCampo:=cdsI010.FieldByName('NOME_CAMPO').AsString;
        PosizioneNulla:=(cdsI010.FieldByName('POSIZIONE').IsNull) or
                        (cdsI010.FieldByName('ACCESSO').AsString = 'N') or
                        (cdsI010.FieldByName('POSIZIONE').AsInteger = POSIZIONE_NULL);

        if selAnagrafe.FindField(NomeCampo) <> nil then
        begin
          // caption da layout anagrafico - daniloc 04.10.2010
          //selAnagrafe.FieldByName(NomeCampo).DisplayLabel:=cdsI010.FieldByName('NOME_LOGICO').AsString;
          selAnagrafe.FieldByName(NomeCampo).DisplayLabel:=cdsI010.FieldByName('CAPTION_LAYOUT').AsString;
          // caption da layout anagrafico.fine
          selAnagrafe.FieldByName(NomeCampo).Index:=IfThen(PosizioneNulla,POSIZIONE_NULL,cdsI010.FieldByName('POSIZIONE').AsInteger);
          selAnagrafe.FieldByName(NomeCampo).Visible:=not PosizioneNulla;
        end;
      except
      end;
      cdsI010.Next;
    end;
    selAnagrafe.FieldByName('COGNOME').Visible:=True;
    selAnagrafe.FieldByName('NOME').Visible:=True;
    selAnagrafe.FieldByName('MATRICOLA').Visible:=True;
    //selAnagrafe.FieldByName('T430BADGE').Visible:=True;
    selAnagrafe.FieldByName('COGNOME').Index:=0;
    selAnagrafe.FieldByName('NOME').Index:=1;
    selAnagrafe.FieldByName('MATRICOLA').Index:=2;
    //selAnagrafe.FieldByName('T430BADGE').Index:=3;
    selAnagrafe.FieldByName('PROGRESSIVO').Visible:=False;
    if selAnagrafe.FindField('T430PROGRESSIVO') <> nil then
      selAnagrafe.FieldByName('T430PROGRESSIVO').Visible:=False;
  end;
end;

procedure TWR000FBaseDM.MergeSelAnagrafe(ODS:TComponent; _selAnagrafe:TOracleDataSet; RicreaVariabili:Boolean = False);
{ODS deve essere un OracleDataSet o OracleQuery con il parametro C700SelAnagrafe di tipo Substitution;
 Viene rimpiazzato il parametro :C700SelAnagrafe con il testo SQL di C700Selanagrafe
 dalla FROM alla ORDER BY escluse.
 Le variabili di ODS vengono integrate con quelle di C700SelAnagrafe (DataLavoro, C700DataDal) cancellando quelle già esistenti o meno a seconda di RicreaVariabili
 Esempio di utilizzo:
 -Subquery-
 ...AND tabella.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)
 -Join-
 SELECT * FROM TABELLA1, TABELLA2, :C700SelAnagrafe //la WHERE è già inserita
 AND TABELLA1.CAMPO1 = TABELLA2.CAMPO2
 AND TABELLA1.PROGRESSIVO = T030.PROGRESSIVO
 }
var i:Integer;
    S:String;
begin
  //estrazione del corpo della select compresa tra il FROM e l'ORDERBY.
  S:=_SelAnagrafe.SubstitutedSQL;
  S:=Copy(S,R180CercaParolaIntera('FROM',S.ToUpper,'') + 4,Length(S)).Trim;
  if R180CercaParolaIntera('ORDER BY',S.ToUpper,'') > 0 then
    S:=Copy(S,1,R180CercaParolaIntera('ORDER BY',S.ToUpper,'') - 1).Trim;

  if ODS is TOracleQuery then
  begin
    //Se ODS è OracleQuery....
    if TOracleQuery(ODS).VariableIndex('C700SelAnagrafe') = -1 then
      exit;
    if RicreaVariabili then
    begin
      TOracleQuery(ODS).DeleteVariables;
      TOracleQuery(ODS).DeclareVariable('C700SelAnagrafe',otSubst);
    end;
    TOracleQuery(ODS).SetVariable('C700SelAnagrafe',S);
    if TOracleQuery(ODS).VariableIndex('C700Filtro') >= 0 then
      TOracleQuery(ODS).DeleteVariable('C700Filtro');
    if TOracleQuery(ODS).VariableIndex('C700DataDal') >= 0 then
      TOracleQuery(ODS).DeleteVariable('C700DataDal');
    for i:=0 to _SelAnagrafe.VariableCount - 1 do
    begin
      if (TOracleQuery(ODS).VariableIndex(_SelAnagrafe.VariableName(i)) = -1) and
         (_SelAnagrafe.VariableType(i) <> otSubst) then
      begin
        TOracleQuery(ODS).DeclareVariable(_SelAnagrafe.VariableName(i),_SelAnagrafe.VariableType(i));
        TOracleQuery(ODS).SetVariable(_SelAnagrafe.VariableName(i),_SelAnagrafe.GetVariable(i));
      end;
    end;
  end
  else
  begin
    //Se ODS è OracleDataSet...
    if TOracleDataSet(ODS).VariableIndex('C700SelAnagrafe') = -1 then
      exit;
    if RicreaVariabili then
    begin
      TOracleDataSet(ODS).DeleteVariables;
      TOracleDataSet(ODS).DeclareVariable('C700SelAnagrafe',otSubst);
    end;
    TOracleDataSet(ODS).SetVariable('C700SelAnagrafe',S);
    if TOracleDataSet(ODS).VariableIndex('C700Filtro') >= 0 then
      TOracleDataSet(ODS).DeleteVariable('C700Filtro');
    if TOracleDataSet(ODS).VariableIndex('C700DataDal') >= 0 then
      TOracleDataSet(ODS).DeleteVariable('C700DataDal');
    //Si riportano tutte le variabili non subst di C700, settandone sempre i valori
    for i:=0 to _SelAnagrafe.VariableCount - 1 do
    begin
      if (_SelAnagrafe.VariableType(i) <> otSubst) then
      begin
        if (TOracleDataSet(ODS).VariableIndex(_SelAnagrafe.VariableName(i)) = -1) then
          TOracleDataSet(ODS).DeclareVariable(_SelAnagrafe.VariableName(i),_SelAnagrafe.VariableType(i));
        TOracleDataSet(ODS).SetVariable(_SelAnagrafe.VariableName(i),_SelAnagrafe.GetVariable(i));
      end;
    end;
  end;
end;

function TWR000FBaseDM.MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
{ODS deve essere un OracleDataSet o OracleQuery}
begin
  Result:=False;
  if ODS is TOracleQuery then
  begin
    //Se ODS è OracleQuery...
    if TOracleQuery(ODS).VariableIndex('DATALAVORO') >= 0 then
      if TOracleQuery(ODS).GetVariable('DATALAVORO') <> DataLavoro then
      begin
        TOracleQuery(ODS).SetVariable('DATALAVORO',DataLavoro);
        Result:=True;
      end;
    if TOracleQuery(ODS).VariableIndex('C700DATADAL') >= 0 then
      if TOracleQuery(ODS).GetVariable('C700DATADAL') <> DataDal then
      begin
        TOracleQuery(ODS).SetVariable('C700DATADAL',DataDal);
        Result:=True;
      end;
  end
  else
  begin
    //Se ODS è OracleDataSet...
    if TOracleDataSet(ODS).VariableIndex('DATALAVORO') >= 0 then
      if TOracleDataSet(ODS).GetVariable('DATALAVORO') <> DataLavoro then
      begin
        TOracleDataSet(ODS).SetVariable('DATALAVORO',DataLavoro);
        Result:=True;
      end;
    if TOracleDataSet(ODS).VariableIndex('C700DATADAL') >= 0 then
      if TOracleDataSet(ODS).GetVariable('C700DATADAL') <> DataDal then
      begin
        TOracleDataSet(ODS).SetVariable('C700DATADAL',DataDal);
        Result:=True;
      end;
  end;
end;

procedure TWR000FBaseDM.CopiaTagFiltroAnag(ODS:TComponent; _selAnagrafe:TOracleDataSet);
{Cerca nella variabile C700SelAnagrafe di ODS il testo contenuto tra i tag /*I072*/ e /*\I072*/, lo sostituisce con quello trovato in C700SelAnagrafe fra gli stessi tag}
var x:Integer;
    S:String;
    lstSelAnagrafe:TStringList;
begin
  if ODS is TOracleQuery then
  begin
    //Se ODS è OracleQuery....
    if TOracleQuery(ODS).VariableIndex('C700SelAnagrafe') = -1 then
      exit;
    S:=TOracleQuery(ODS).GetVariable('C700SelAnagrafe');
  end
  else
  begin
    //Se ODS è OracleDataSet...
    if TOracleDataSet(ODS).VariableIndex('C700SelAnagrafe') = -1 then
      exit;
    S:=TOracleDataSet(ODS).GetVariable('C700SelAnagrafe');
  end;
  lstSelAnagrafe:=TStringList.Create;
  lstSelAnagrafe.Text:=_SelAnagrafe.SubstitutedSQL;
  with TStringList.Create do
  try
    Text:=S;
    if (IndexOf(TAG_FILTRO_ANAG_INIZIO) > 0) and (IndexOf(TAG_FILTRO_ANAG_FINE) > 0) then
    begin
      for x:=IndexOf(TAG_FILTRO_ANAG_INIZIO) + 1 to IndexOf(TAG_FILTRO_ANAG_FINE) - 1 do
        Delete(IndexOf(TAG_FILTRO_ANAG_INIZIO) + 1);
      for x:=lstSelAnagrafe.IndexOf(TAG_FILTRO_ANAG_INIZIO) + 1 to lstSelAnagrafe.IndexOf(TAG_FILTRO_ANAG_FINE) - 1 do
        Insert(IndexOf(TAG_FILTRO_ANAG_FINE),lstSelAnagrafe[x]);
      S:=Text;
    end;
  finally
    Free;
    FreeAndNil(lstSelAnagrafe);
  end;
  if ODS is TOracleQuery then
    TOracleQuery(ODS).SetVariable('C700SelAnagrafe',S)
  else
    TOracleDataSet(ODS).SetVariable('C700SelAnagrafe',S);
end;

procedure TWR000FBaseDM._MailImmediata(PDestResponsabile: Boolean; PProgressivo: Integer;
  const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
  const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
var
  C017DtM:TC017FEMailDtM;
  i: Integer;
  L: TStringList;
begin
  C017DtM:=TC017FEMailDtM.Create(GGetWebApplicationThreadVar);
  try
    try
      C017DtM.SollevaEccezioni:=True;
      C017DtM.Sessione:=SessioneOracle;
      C017DtM.DestResponsabile:=PDestResponsabile;
      C017DtM.Progressivo:=PProgressivo;
      C017DtM.Oggetto:=POggetto;
      C017DtM.Testo:=PTesto;
      C017DtM.TagFunzione:=PTag;
      C017DtM.Iter:=PIter;
      C017DtM.CodIter:=PCodIter;
      C017DtM.LivelliDest:=PLivelliDest;
      C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
      C017DtM.InviaEMail;
    except
      on E:Exception do
        W000RegistraLog('Errore',GetTestoLog('W001D',GGetWebApplicationThreadVar) + '[C017] ' + E.Message);
    end;
  finally
    // riporta i messaggi di traccia su database
    try
      if (Pos('TRACCIA',W000ParConfig.LogAbilitati) > 0) and
         (C017DtM.Traccia <> '') then
      begin
        L:=TStringList.Create;
        try
          R180Tokenize(L,C017DtM.Traccia,'|');
          for i:=0 to L.Count - 1 do
            W000RegistraLog('Traccia',L[i]);
        finally
          L.Free;
        end;
      end;
    except
    end;
    FreeAndNil(C017DtM);
  end;

  if (PDestinatari <> '') or (PDestinatariCC <> '') or (PDestinatariCCN <> '') then
  begin
    // In questo caso in aggiunta alla mail inviata precedentemente ne inviamo una ai destinatari
    // esplicitamente indicati
    C017DtM:=TC017FEMailDtM.Create(GGetWebApplicationThreadVar);
    try
      try
        C017DtM.SollevaEccezioni:=True;
        C017DtM.Sessione:=SessioneOracle;
        C017DtM.DestResponsabile:=False;
        C017DtM.Oggetto:=POggetto;
        C017DtM.Testo:=PTesto;
        C017DtM.TagFunzione:=PTag;
        C017DtM.CercaDestinatari:=False;
        C017DtM.Destinatari:=PDestinatari;
        C017DtM.DestinatariCC:=PDestinatariCC;
        C017DtM.DestinatariCCN:=PDestinatariCCN;
        //C017DtM.Iter:=PIter;
        //C017DtM.CodIter:=PCodIter;
        //C017DtM.LivelliDest:=PLivelliDest;
        C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
        C017DtM.InviaEMail;
      except
        on E:Exception do
          W000RegistraLog('Errore',GetTestoLog('W001D',GGetWebApplicationThreadVar) + '[C017] ' + E.Message);
      end;
    finally
      // riporta i messaggi di traccia su database
      try
        if (Pos('TRACCIA',W000ParConfig.LogAbilitati) > 0) and
           (C017DtM.Traccia <> '') then
        begin
          L:=TStringList.Create;
          try
            R180Tokenize(L,C017DtM.Traccia,'|');
            for i:=0 to L.Count - 1 do
              W000RegistraLog('Traccia',L[i]);
          finally
            L.Free;
          end;
        end;
      except
      end;
      FreeAndNil(C017DtM);
      end;
  end;
end;

procedure TWR000FBaseDM._MailImmediataLst(PDestResponsabile: Boolean; PLstProgressivo, PLstOggetto, PLstTesto: TStringList; const PTag: Integer; const PIter, PCodIter, PLivelliDest: String;
  const PLstDestinatari, PLstDestinatariCC, PLstDestinatariCCN: TStringList);
var  //PALERMO_POLICLINICO - 163352 - invio mail senza aprire-chiudere la connessione per ogni mail (DA COMPLETARE)
  C017DtM:TC017FEMailDtM;
  i,m: Integer;
  L: TStringList;
begin
  try
    C017DtM:=TC017FEMailDtM.Create(GGetWebApplicationThreadVar);
    C017DtM.SollevaEccezioni:=True;
    C017DtM.Sessione:=SessioneOracle;
    C017DtM.DestResponsabile:=PDestResponsabile;
    C017DtM.TagFunzione:=PTag;
    C017DtM.Iter:=PIter;
    C017DtM.CodIter:=PCodIter;
    C017DtM.LivelliDest:=PLivelliDest;
    C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
    for m:=0 to PLstProgressivo.Count-1 do
    try
      (*if not C017DtM.StatoSMPT = True then
        C017DtM.PreparazioneSendMail;      da scommentare su C017*)
      C017DtM.Progressivo:=StrToInt(PLstProgressivo[m]);
      C017DtM.Oggetto:=PLstOggetto[m];
      C017DtM.Testo:=PLstTesto[m];
      C017DtM.InviaEMail;
    except
      on E:Exception do
      begin
        W000RegistraLog('Errore',GetTestoLog('W001D',GGetWebApplicationThreadVar) + '[C017] (' + m.ToString + ')' + E.Message);
      end;
    end;
  finally
    // riporta i messaggi di traccia su database
    try
      if (Pos('TRACCIA',W000ParConfig.LogAbilitati) > 0) and
         (C017DtM.Traccia <> '') then
      begin
        L:=TStringList.Create;
        try
          R180Tokenize(L,C017DtM.Traccia,'|');
          for i:=0 to L.Count - 1 do
            W000RegistraLog('Traccia',L[i]);
        finally
          L.Free;
        end;
      end;
    except
    end;
    //C017DtM.ChiusuraSendMail;  da scommentare su C017
    FreeAndNil(C017DtM);
  end;

  //// parte DESTINATARI
  {if (PDestinatari <> '') or (PDestinatariCC <> '') or (PDestinatariCCN <> '') then
  begin
    // In questo caso in aggiunta alla mail inviata precedentemente ne inviamo una ai destinatari
    // esplicitamente indicati
    C017DtM:=TC017FEMailDtM.Create(GGetWebApplicationThreadVar);
    try
      try
        C017DtM.SollevaEccezioni:=True;
        C017DtM.Sessione:=SessioneOracle;
        C017DtM.DestResponsabile:=False;
        C017DtM.Oggetto:=POggetto;
        C017DtM.Testo:=PTesto;
        C017DtM.TagFunzione:=PTag;
        C017DtM.CercaDestinatari:=False;
        C017DtM.Destinatari:=PDestinatari;
        C017DtM.DestinatariCC:=PDestinatariCC;
        C017DtM.DestinatariCCN:=PDestinatariCCN;
        //C017DtM.Iter:=PIter;
        //C017DtM.CodIter:=PCodIter;
        //C017DtM.LivelliDest:=PLivelliDest;
        C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
        C017DtM.InviaEMail;
      except
        on E:Exception do
          W000RegistraLog('Errore',GetTestoLog('W001D',GGetWebApplicationThreadVar) + '[C017] ' + E.Message);
      end;
    finally
      // riporta i messaggi di traccia su database
      try
        if (Pos('TRACCIA',W000ParConfig.LogAbilitati) > 0) and
           (C017DtM.Traccia <> '') then
        begin
          L:=TStringList.Create;
          try
            R180Tokenize(L,C017DtM.Traccia,'|');
            for i:=0 to L.Count - 1 do
              W000RegistraLog('Traccia',L[i]);
          finally
            L.Free;
          end;
        end;
      except
      end;
      FreeAndNil(C017DtM);
      end;
  end;}
end;

procedure TWR000FBaseDM._MailDifferita(PDestResponsabile: Boolean; PProgressivo: Integer;
  const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
  const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
var
  ThMail,ThMail2: TThreadMail;
begin
  ThMail:=TThreadMail.Create(True);
  with ThMail do
  begin
    FreeOnTerminate:=True;
    C017DtMTh:=TC017FEMailDtM.Create(Self);
    with (C017DtMTh as TC017FEMailDtM) do
    begin
      SollevaEccezioni:=True;
      Sessione:=SessioneOracle;
      DestResponsabile:=PDestResponsabile;
      Progressivo:=PProgressivo;
      Oggetto:=POggetto;
      Testo:=PTesto;
      TagFunzione:=PTag;
      Iter:=PIter;
      CodIter:=PCodIter;
      LivelliDest:=PLivelliDest;
      WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
    end;
    Start;
  end;

  if (PDestinatari <> '') or (PDestinatariCC <> '') or (PDestinatariCCN <> '') then
  begin
    // In questo caso in aggiunta alla mail inviata precedentemente ne inviamo una ai destinatari
    // esplicitamente indicati
    ThMail2:=TThreadMail.Create(True);
    with ThMail2 do
    begin
      FreeOnTerminate:=True;
      C017DtMTh:=TC017FEMailDtM.Create(Self);
      with (C017DtMTh as TC017FEMailDtM) do
      begin
        SollevaEccezioni:=True;
        Sessione:=SessioneOracle;
        DestResponsabile:=False;
        Oggetto:=POggetto;
        Testo:=PTesto;
        TagFunzione:=PTag;
        CercaDestinatari:=False;
        Destinatari:=PDestinatari;
        DestinatariCC:=PDestinatariCC;
        DestinatariCCN:=PDestinatariCCN;
        //Iter:=PIter;
        //CodIter:=PCodIter;
        //LivelliDest:=PLivelliDest;
        WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
      end;
      Start;
    end;
  end;
end;

procedure TWR000FBaseDM.RegistraMessaggioT280(Progressivo:Integer; Flag,Titolo,Log,Testo:String);
begin
  with insT280 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA',Now);
    SetVariable('MITTENTE',Parametri.Operatore);
    SetVariable('FLAG',Flag);
    SetVariable('TITOLO',Copy(Titolo,1,1000));
    SetVariable('LOG',Copy(Log,1,4000));
    SetVariable('TESTO',Copy(Testo,1,4000));
    SetVariable('EMAIL','');
    SetVariable('EMAIL_CC','');
    SetVariable('EMAIL_CCN','');
    Execute;
  end;
end;

{ Aggiunge un record sulla tabella T280_MESSAGGIWEB che rappresenta uno o più messaggi email (uno per ogni
  tipo di destinatario indicato - progressivo, email, emailcc, emailccn).
  L'invio viene effettuato da W001FIrisWebDtM.InviaEmailT280.
  Se è indicato il progressivo, la mail di destinazione è quella dell'utente web indicato. Indicare -1
  per non inviare tramite progressivo, ma solo tramite i campi email, emailcc,emailccn.
  Se il progressivo è indicato, ma non email/emailcc/emailccn, viene inviato un solo messaggio al dipendente con il prog. indicato.
  Se progressivo è -1, vengono inviate mail a email/emailcc/emailccn.
  Se progressivo e email/emailcc/emailccn sono indicati, sono inviati messaggi sia al dipendente con prog
  indicato, sia ai destinatari specificati. }
procedure TWR000FBaseDM.RegistraMailT280(Progressivo:Integer;Titolo,Testo:String;EMail:String = '';EMailCC:String = ''; EMailCCN:String = '');
begin
  with insT280 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA',Now);
    SetVariable('MITTENTE',Parametri.Operatore);
    SetVariable('FLAG',3);
    SetVariable('TITOLO',Titolo);
    SetVariable('TESTO',Testo);
    SetVariable('EMAIL',EMail);
    SetVariable('EMAIL_CC',EMailCC);
    SetVariable('EMAIL_CCN',EMailCCN);
    Execute;
  end;
end;

//SSO.ini
procedure TWR000FBaseDM.GetParametriSSO(Azienda, Database: String);
{Valorizza i parametri di SSO dell'azienda indicata, prima del login effettivo}
var nsl:Integer;
begin
  if (Azienda = '') or (Database = '') then
    exit;

  if W001FPasswordDtM = nil then
    W001FPasswordDtM:=TA001FPasswordDtM1.Create((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN);
  nsl:=-1;
  try
    W001FPasswordDtM.EseguiCheckConnection:=Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0;
    WR000DM.W001FPasswordDtM:=W001FPasswordDtM;
    nsl:=WR000DM.GetSessioneLogin(Database);
    if nsl = -1 then
      Abort;

    CSSessioneMondoEDP.Enter;
    try
      W001FPasswordDtM.InizializzazioneSessione(Database);
    finally
      CSSessioneMondoEDP.Leave;
    end;

    with WR000DM.selI091 do
    begin
      Session:=(lstSessioniMondoEDP[nsl] as TOracleSession);
      SetVariable('AZIENDA',Azienda);
      Open;
      Parametri.CampiRiferimento.C90_SSO_SHA1Passphrase:=R180Decripta(VarToStr(Lookup('Tipo','C90_SSO_SHA1PASSPHRASE','Dato')),I091CryptKey);
      Parametri.CampiRiferimento.C90_SSO_RDLPassphrase:=R180Decripta(VarToStr(Lookup('Tipo','C90_SSO_RDLPASSPHRASE','Dato')),I091CryptKey);
      Parametri.CampiRiferimento.C90_SSO_UsrMask:=VarToStr(Lookup('Tipo','C90_SSO_USRMASK','Dato'));
      Parametri.CampiRiferimento.C90_SSO_TimeOut:=VarToStr(Lookup('Tipo','C90_SSO_TIMEOUT','Dato'));
      Close;
    end;

  finally
    FreeAndNil(W001FPasswordDtM);
    if nsl >= 0 then
    begin
      CSSessioneMondoEDP.Enter;
      try
        (lstSessioniMondoEDP[nsl] as TOracleSession).Tag:=max(1,(lstSessioniMondoEDP[nsl] as TOracleSession).Tag) - 1;
      finally
        CSSessioneMondoEDP.Leave;
      end;
    end;
  end;
end;

function TWR000FBaseDM.GetRichiestaAssistenza: Boolean;
var
  i: integer;
begin
  Result:=False;
  try
    if selT960RichiestaAssistenza.GetVariable('ID') = null then
    begin
      for i:=1 to Length(VettFileInstallati) do
      if VettFileInstallati[i].Codice = Supporto then
      begin
        selT960RichiestaAssistenza.SetVariable('ID',VettFileInstallati[i].Id);
        selT960RichiestaAssistenza.SetVariable('NOME_FILE', UpperCase(VettFileInstallati[i].NomeFile));
        selT960RichiestaAssistenza.Execute;
        break;
      end;
    end;
    Result:=selT960RichiestaAssistenza.FieldAsInteger(0) > 0;
  except
  end;
end;

function TWR000FBaseDM.SSOTicket(const PTicket,UrlWSAuth: String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
// Gestione sso per ospedale sant'andrea
//   L'autenticazione avviene in questo modo:
//   INPUT
//     - parametro "ticket" letto dai parametri della request
//   AUTENTICAZIONE
//   - il ticket viene impacchettato in una stringa xml che rappresenta la richiesta
//     da inoltrare al webservice di autenticazione
//   - viene chiamato il webservice e si attende la risposta
//   - se la risposta contiene il tag <info> allora l'autenticazione è ok
//       -> viene fatto un redirect alla dll di irisweb con il parametro usr ecc.
//     altrimenti se la risposta contiene il tag <Exception> l'autenticazione è fallita
var
  Richiesta,StrXML,Err: String;
  oJSB: THTTPRIO;
  xmlNodoList: IDOMNodeList;
begin
  W000RegistraLog('Traccia','JBFService;Autenticazione con ticket: ' + PTicket + ';Webservice chiamato: ' + UrlWSAuth);

  // inizializzazioni
  Result:=False;
  Anomalia:='';
  Risposta.Utente:='';
  Risposta.Profilo:='';
  Err:='';
  StrXML:='';

  // richiama il web service JBF con la richiesta
  if not IsLibrary then
    Coinitialize(nil);
  try
    try
      //Engi - ROMA_HSANDREA
      oJSB:=JBFService.GetDefaultWebService(False,UrlWSAuth);
      // assembla l'xml di richiesta
      Richiesta:='<Input>' +
                 '<WebServicesOggettiComuni id=''SSOTCK'' preAuthentication=''false''>'+
                 '<GetTicket>' + PTicket + '</GetTicket></WebServicesOggettiComuni></Input>';
      W000RegistraLog('Traccia','JBFService;XML richiesta: [' + Richiesta + ']');

      StrXML:=(oJSB as EngiWebService).call(Richiesta);
    except
      StrXML:=''
    end;
    try
      if StrXML = '' then
      begin
        //BOLOGNA_ERGO
        oJSB:=JBFService.GetDefaultWebService(False,UrlWSAuth);
        StrXML:=(oJSB as ERGOWebService).cercasessionetypo3(PTicket,'MONDOEDP');
      end;
    except
      StrXML:='';
      raise;
    end;
    W000RegistraLog('Traccia','JBFService;Call: OK;Risposta: [' + Copy(StrXML,1,1500) + ']');
  except
    on E:Exception do
    begin
      W000RegistraLog('Errore','JBFService;Call: FALLITA',E);
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_WEBSRV_CHIMATA_FALLITA));
    end;
  end;

  // legge l'xml di risposta e ne esegue il parsing
  xmlDoc.XML.Add(StrXML);
  try
    xmlDoc.Active:=True;
    W000RegistraLog('Traccia','JBFService;Parsing risposta: OK');
  except
    on E:Exception do
    begin
      W000RegistraLog('Errore','JBFService;Parsing risposta: FALLITO',E);
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_WEBSRV_RISP_ERRATA),[E.ClassName,E.Message]));
    end;
  end;

  // verifica l'xml di risposta
  if Pos('<Exception>',StrXML) > 0 then
  begin
    // Autenticazione fallita
    try
      xmlNodoList:=xmlDoc.DOMDocument.getElementsByTagName('Code');
      if Assigned(xmlNodoList) then
      begin
        try
          Err:=xmlNodoList.item[0].childNodes[0].nodeValue;
        except end;
      end;
      W000RegistraLog('Errore','JBFService;Autenticazione: FALLITA;Motivo: ' + IfThen(Err <> '',Err,'(errore non rilevabile)'));
      Anomalia:='Errore durante l''autenticazione sul servizio web!' +
                IfThen(Err <> '',CRLF + 'Motivo: ' + Err);
      Exit;
    except
      on E:Exception do
      begin
        W000RegistraLog('Errore','JBFService;Autenticazione: FALLITA',E);
        raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_WEBSRV_GENERICO),[E.ClassName,E.Message]));
      end;
    end;
  end
  //Bologna_ERGO
  else if Pos('<cercasessionetypo3Result>',StrXML) > 0 then
  begin
    // Autenticazione ok
    try
      // lettura utente
      xmlNodoList:=xmlDoc.DOMDocument.getElementsByTagName('username');
      if Assigned(xmlNodoList) and (xmlNodoList.Length > 0) then
      begin
        try
          Risposta.Utente:=xmlNodoList.item[0].childNodes[0].nodeValue;
          if Risposta.Utente = '' then
            raise Exception.Create(A000MSG_ERR_WEBSRV_NO_NOME_UTENTE);
        except
          on E:Exception do
          begin
            W000RegistraLog('Errore','JBFService;Autenticazione: FALLITA',E);
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_WEBSRV_NO_NOME_UTENTE));
          end;
        end;
      end
      else
      begin
        W000RegistraLog('Errore','JBFService;Autenticazione: FALLITA',nil);
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_WEBSRV_NO_NOME_UTENTE));
      end;
      (*
      // lettura profilo
      xmlNodoList:=xmlDoc.DOMDocument.getElementsByTagName('profilo');
      if Assigned(xmlNodoList) then
      begin
        try
          Risposta.Profilo:=xmlNodoList.item[0].childNodes[0].nodeValue;
        except
          on E:Exception do
          begin
            W000RegistraLog('Errore','JBFService;Autenticazione: OK',E);
            // il profilo non è indispensabile...
            Risposta.Profilo:='';
            //raise Exception.Create('Errore durante l''autenticazione sul servizio web!' +
            //                       'Motivo: Impossibile recuperare il profilo');
          end;
        end;
      end;
      *)
      // terminazione ok: redirect alla pagina di login con l'utente impostato
      W000RegistraLog('Traccia','JBFService;Autenticazione: OK;Utente: ' + Risposta.Utente);
      Result:=True;
      Exit;
    except
      on E:Exception do
      begin
        W000RegistraLog('Errore','JBFService;Autenticazione: OK',E);
        raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_WEBSRV_GENERICO),[E.ClassName,E.Message]));
      end;
    end;
  end
  //Engi ROMA_HSANDREA
  else if Pos('<info>',StrXML) > 0 then
  begin
    // Autenticazione ok
    try
      // lettura utente
      xmlNodoList:=xmlDoc.DOMDocument.getElementsByTagName('utente');
      if Assigned(xmlNodoList) then
      begin
        try
          Risposta.Utente:=xmlNodoList.item[0].childNodes[0].nodeValue;
        except
          on E:Exception do
          begin
            W000RegistraLog('Errore','JBFService;Autenticazione: OK',E);
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_WEBSRV_NO_NOME_UTENTE));
          end;
        end;
      end;
      // lettura profilo
      xmlNodoList:=xmlDoc.DOMDocument.getElementsByTagName('profilo');
      if Assigned(xmlNodoList) then
      begin
        try
          Risposta.Profilo:=xmlNodoList.item[0].childNodes[0].nodeValue;
        except
          on E:Exception do
          begin
            W000RegistraLog('Errore','JBFService;Autenticazione: OK',E);
            // il profilo non è indispensabile...
            Risposta.Profilo:='';
            //raise Exception.Create('Errore durante l''autenticazione sul servizio web!' +
            //                       'Motivo: Impossibile recuperare il profilo');
          end;
        end;
      end;
      // terminazione ok: redirect alla pagina di login con l'utente impostato
      W000RegistraLog('Traccia','JBFService;Autenticazione: OK;Utente: ' + Risposta.Utente + ',Profilo: ' + Risposta.Profilo);
      Result:=True;
      Exit;
    except
      on E:Exception do
      begin
        W000RegistraLog('Errore','JBFService;Autenticazione: OK',E);
        raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_WEBSRV_GENERICO),[E.ClassName,E.Message]));
      end;
    end;
  end
  else
  begin
    // autenticazione indefinita: nessun tag conosciuto
    W000RegistraLog('Errore','JBFService;Autenticazione: N/D;Errore: tag <info> e <Exception> non rilevati');
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_WEBSRV_RISP_NO_RICONOS));
  end;
end;

// COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.ini
function TWR000FBaseDM.SSOSha1(const PUID, PTime, PHash: String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
// Gestione sso per COMO_HSANNA
//   L'autenticazione avviene in questo modo:
//   INPUT
//   - sono previsti 3 parametri letti dalla request
//     uid  = username dell'utente da autenticare
//     time = timestamp della richiesta in formato unix time
//     hash = l'hash calcolato in questo modo
//            sha1 di una stringa formata concatenando:
//            uid + time + password condivisa
//   AUTENTICAZIONE
//   - verifica che l'ora corrente non sia più distante di un minuto dal parametro "time"
//     (questo evita che un token possa essere riutilizzato)
//   - ricostruisce il l'hash sha1 utilizzando i parametri uid, time e la password condivisa
//   - confronta il risultato ottenuto con l'hash calcolato prima
//     se e' uguale l'autenticazione è ok
//       -> viene fatto un redirect alla dll di irisweb con il parametro usr ecc.
//     altrimenti l'autenticazione è fallita
var
  Fase,TokenSha1,Formato,OraAttualeStr,OraRichiestaStr: String;
  UnixTimeRichiesta,UnixTimeOraAttuale,Delta: Int64;
  OraRichiesta, OraAttuale: TDateTime;
  SSOTimeOut:Integer;
  UTC:TSystemTime;
begin
  W000RegistraLog('Traccia',Format('SSO_Como;Autenticazione SSO con parametri [UID=%s] [time=%s] [hash=%s],',[PUID,PTime,PHash]));

  // inizializzazioni
  Result:=False;
  Anomalia:='';
  //Inizializzazioni forzate per COMO
  if Parametri.CampiRiferimento.C90_SSO_SHA1Passphrase = '' then
    Parametri.CampiRiferimento.C90_SSO_SHA1Passphrase:='pwdIrisWEBsha1';//password condivisa per generazione hash
  if Parametri.CampiRiferimento.C90_SSO_TimeOut = '' then
    Parametri.CampiRiferimento.C90_SSO_TimeOut:='60';// timeout oltre il quale il token non è più valido
  SSOTimeOut:=StrToIntDef(Parametri.CampiRiferimento.C90_SSO_TimeOut,-1);

  // 1. controlla i parametri in ingresso

  // verifica indicazione uid
  Fase:='SSO_Como;Verifica parametri: uid';
  W000RegistraLog('Traccia',Fase);

  if Trim(PUID) = '' then
  begin
    Anomalia:='user ID non indicato';
    W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
    Exit;
  end;

  // verifica indicazione ora richiesta
  Fase:='SSO_Como;Verifica parametri: time';
  W000RegistraLog('Traccia',Fase);
  if Trim(PTime) = '' then
  begin
    Anomalia:='ora della richiesta non indicata';
    W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
    Exit;
  end;

  // verifica correttezza ora richiesta
  if not TryStrToInt64(PTime,UnixTimeRichiesta) then
  begin
    Anomalia:=Format('ora della richiesta in formato unix time non corretta [%s]',[PTime]);
    W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
    Exit;
  end;

  // salva ora richiesta e ora attuale (in formato UTC, ora di Greenwich)
  OraRichiesta:=UnixToDateTime(UnixTimeRichiesta);
  //OraAttuale:=Now;
  GetSystemTime(UTC);
  OraAttuale:=SystemTimeToDateTime(UTC);

  UnixTimeOraAttuale:=DateTimeToUnix(OraAttuale);

  // controlla che la "distanza" dell'ora attuale rispetto all'ora della richiesta
  // non sia maggiore del timeout in secondi specificato
  // questo accorgimento serve ad evitare che il token possa essere riutilizzato
  Delta:=UnixTimeOraAttuale - UnixTimeRichiesta;
  if (SSOTimeOut > 0) and (Abs(Delta) > SSOTimeOut) then
  begin
    // errore: l'ora di elaborazione è più distante del numero max di secondi
    // tollerato rispetto all'ora della richiesta
    Formato:=IfThen(Trunc(OraAttuale) <> Trunc(OraRichiesta),'dd/mm/yyyy ') + 'hhhh.mm.ss';
    OraAttualeStr:=FormatDateTime(Formato,OraAttuale);
    OraRichiestaStr:=FormatDateTime(Formato,OraRichiesta);
    if Delta > SSOTimeOut then
    begin
      // token scaduto
      Anomalia:='token di autenticazione scaduto';
    end
    else if Delta < 0 then
    begin
      // data richiesta precedente a data attuale
      // (probabilmente gli orari dei server sono sfasati)
      Anomalia:=Format('ora della richiesta non congruente: %s',[OraRichiestaStr]);
    end;
    W000RegistraLog('Errore',Format('%s: FALLITA: %s [ora attuale=%s] [ora request=%s]',[Fase,Anomalia,OraAttualeStr,OraRichiestaStr]));
    Exit;
  end;

  // controlla hash sha1
  Fase:='SSO_Como;Verifica parametri: hash;';
  if Trim(PHash) = '' then
  begin
    Anomalia:='Hash sha1 non indicato';
    W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
    Exit;
  end;

  // 2. ricostruisce il token da confrontare con l'hash ricevuto
  Fase:='SSO_Como;Calcolo token';
  try
    TokenSha1:=R180Sha1Encrypt(Format('%s%d%s',[PUID,UnixTimeRichiesta,Parametri.CampiRiferimento.C90_SSO_SHA1Passphrase]));
  except
    on E: Exception do
    begin
      Anomalia:=Format('errore di cifratura sha-1: %s (%s)',[E.Message,E.ClassName]);
      W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
      Exit;
    end;
  end;

  // verifica corrispondenza degli hash
  // si potrebbe obiettare che il confronto è fatto fra stringhe ma i valori sono esadecimali
  // lo so, non è per nulla elegante.. ma se trovate una soluzione migliore che sfrutti
  // un confronto numerico implementatela pure
  Fase:='SSO_Como;Autenticazione: ';
  if UpperCase(TokenSha1) <> UpperCase(PHash) then
  begin
    Anomalia:='token non corrispondente';
    W000RegistraLog('Traccia',Format('%s: FALLITA; Token non corrispondente [calcolato=%s]',[Fase,TokenSha1]));
    Exit;
  end;

  // tutto ok
  Risposta.Utente:=PUID;
  Risposta.Profilo:=''; // verificare
  Result:=True;
  W000RegistraLog('Traccia',Format('%s: OK;Utente: %s,Profilo: %s',[Fase,Risposta.Utente,Risposta.Profilo]));
end;

function TWR000FBaseDM.SSORdl(const PUID: String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
// Gestione sso con portale ADS
//  esempio di chiamata: http://127.0.0.1:4998/?usr=CcFq1RCXLKuLAGFhFmtStzW3N5f0DBlGk9OmmLtTmcA=%20%20%20%20&xxx=y
//   L'autenticazione avviene in questo modo:
//   INPUT
//   - è previsto 1 parametro letto dalla request
//     usr  = username dell'utente da autenticare concatenato al timestamp della chiamata (per es. formato user#ddmmyyyyhhnnss)
//     lo usr è criptato secondo l'algoritmo RDL ECB (esempio passphrase: Video meliora proboque deteriora sequor)
//   AUTENTICAZIONE
//   - verifica che l'ora corrente non sia più distante di x secondi dal parametro "now"
//     (questo evita che un token possa essere riutilizzato)
var
  Fase:String;
  SSOTimeOut:Integer;
begin
  // inizializzazioni
  Result:=False;
  Anomalia:='';
  Risposta.Utente:=StringReplace(PUID,' ','+',[rfReplaceAll]);//Alberto 12/01/2022: il '%20' viene convertito dal browser in ' ' ma deve poi essere riconvertito in '+'
  try
    // 1. decriptazione del parametro in ingresso
    Risposta.Utente:=R180RDL_ECB_Decrypt(Risposta.Utente,Parametri.CampiRiferimento.C90_SSO_RDLPassphrase); //da troncare dopo #ddmmyyyyhhmmss
    if Risposta.Utente = '' then
    begin
      Anomalia:='token di autenticazione incongruente';
      W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
      Exit;
    end;

    // 2. separazione di utente e timestamp (per es. user#ddmmyyyyhhnnss)
    try
      Fase:='SSORdl.CheckTokenUsr';
      CheckTokenUsr(Risposta,Parametri.CampiRiferimento.C90_SSO_UsrMask);
    except
      on E:Exception do
      begin
        Anomalia:=E.Message;
        W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
        Exit;
      end;
    end;

    // 3. verifica validità temporale del token: now - timestamp
    Fase:='SSOTimeOut';
    SSOTimeOut:=StrToIntDef(Parametri.CampiRiferimento.C90_SSO_TimeOut,-1);
    if SSOTimeOut > 0 then
    begin
      if abs(Now - Risposta.TimeStamp) > SSOTimeOut / (24*60*60) then
      begin
        Anomalia:='token di autenticazione scaduto: ora della richiesta diversa da quella di autenticazione';
        W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
        Exit;
      end;
      (*
      if Now - Risposta.TimeStamp < 0 then
      begin
        Anomalia:='token di autenticazione incongruente: ora della richiesta successiva a quella di autenticazione';
        W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
        Exit;
      end
      else if abs(Now - Risposta.TimeStamp) > SSOTimeOut / (24*60*60) then
      begin
        Anomalia:='token di autenticazione scaduto: ora della richiesta antecedente a quella di autenticazione';
        W000RegistraLog('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
        Exit;
      end;
      *)
    end;

    Result:=True;
  except
  end;
end;

procedure TWR000FBaseDM.CheckTokenUsr(var Risposta:TSSORisposta; Mask:String);
var sep,usr,TS,FmtTS:String;
    posusr,dd,mm,yyyy,hh,nn,ss:Integer;
const MASK_USER = 'user';
begin
  //usr:=Risposta.Utente;
  Risposta.TimeStamp:=now;
  Mask:=LowerCase(Mask);
  //verifico che mask contenga 'user' e qualcos'altro
  if (Mask = '') or
     (Mask = MASK_USER) or
     (pos(MASK_USER,Mask) = 0) then
    exit;
  //estraggo il separatore tra user e il formato data
  posusr:=pos('user',Mask);
  if posusr = 1 then
  begin
    sep:=Copy(Mask,length(MASK_USER) + 1,1);
    FmtTS:=Copy(Mask,Pos(sep,Mask) + 1,Length(Mask));
  end
  else
  begin
    sep:=Copy(Mask,pos(MASK_USER,Mask) - 1,1);
    FmtTS:=Copy(Mask,1,Pos(sep,Mask) -1);
  end;
  //verifico che usr contenga il separatore
  if Pos(sep,Risposta.Utente) = 0 then
    exit;
  //
  if posusr = 1 then
  begin
    usr:=Copy(Risposta.Utente,1,Pos(sep,Risposta.Utente) - 1);
    TS:=Copy(Risposta.Utente,Pos(sep,Risposta.Utente) + 1,Length(Risposta.Utente));
  end
  else
  begin
    TS:=Copy(Risposta.Utente,1,Pos(sep,Risposta.Utente) - 1);
    usr:=Copy(Risposta.Utente,Pos(sep,Risposta.Utente) + 1,Length(Risposta.Utente));
  end;

  Risposta.Utente:=usr;

  dd:=StrToIntDef(Copy(TS,Pos('dd',FmtTS),2),-1);
  mm:=StrToIntDef(Copy(TS,Pos('mm',FmtTS),2),-1);
  yyyy:=StrToIntDef(Copy(TS,Pos('yyyy',FmtTS),4),-1);
  hh:=StrToIntDef(Copy(TS,Pos('hh',FmtTS),2),-1);
  nn:=StrToIntDef(Copy(TS,Pos('nn',FmtTS),2),-1);
  ss:=StrToIntDef(Copy(TS,Pos('ss',FmtTS),2),-1);
  if (dd = -1) or (mm = -1) or (yyyy = -1) or (hh = -1) or (mm = -1) or (nn = -1) or (ss = -1) then
    raise Exception.Create('ora della richiesta in formato non corretto');

  Risposta.TimeStamp:=EncodeDateTime(yyyy,mm,dd,hh,nn,ss,0);
end;

function TWR000FBaseDM.FormattaUrlWebApp: String;
var UTC:TSystemTime;
    OraAttuale:TDateTime;
    UnixTimeOraAttuale:Int64;
    HashToken:String;
    NomeWebApp:String;
  (*IniFile: TIniFile;*)
const
  TOM_SHARED_PWD = 'WfHbRfToTom';
  function SostituisciVariabile(Testo,Variabile,Valore:String):String;
  //Da usare al posto di StringReplace perché il confronto in UpperCase restituirebbe l'url in UpperCase (errato)
  var T1,T2:String;
  begin
    Result:=Testo;
    while Pos(UpperCase(Variabile),UpperCase(Result)) > 0 do
    begin
      T1:=Copy(Result,1,Pos(UpperCase(Variabile),UpperCase(Result)) - 1);
      T2:=Copy(Result,Pos(UpperCase(Variabile),UpperCase(Result)) + Length(Variabile));
      Result:=T1 + Valore + T2;
    end;
  end;
begin
  Result:=Copy(Trim(W000ParConfig.UrlWebApp),Pos('=',Trim(W000ParConfig.UrlWebApp)) + 1);
  NomeWebApp:=Copy(Trim(W000ParConfig.UrlWebApp),1,Pos('=',Trim(W000ParConfig.UrlWebApp)) - 1);

  // ora in formato unix time
  GetSystemTime(UTC);
  OraAttuale:=SystemTimeToDateTime(UTC);
  UnixTimeOraAttuale:=DateTimeToUnix(OraAttuale);

  // hash per TOM = sha1(utente + unixtime + password condivisa)
  HashToken:=LowerCase(R180Sha1Encrypt(Format('%s%d%s',[Parametri.Operatore,UnixTimeOraAttuale,IfThen(NomeWebApp = 'TOM',TOM_SHARED_PWD)])));

  //https://formazione.fbf.milano.it/tom_fbf_mi/externalAuth.html?uid=:UTENTE&time=:UNIX_TIME&hash=:HASH
  Result:=SostituisciVariabile(Result,':UTENTE',Parametri.Operatore);
  Result:=SostituisciVariabile(Result,':UNIX_TIME',IntToStr(UnixTimeOraAttuale));
  Result:=SostituisciVariabile(Result,':HASH',HashToken);

  (*//Solo per test: permette di recuperare l'url finale senza dover interrompere le operazioni con un breakpoint
  IniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName) + 'TestURLWebApp.ini');
  try
    // sezione impostazioni operative
    IniFile.WriteString('Parametri','OraAttuale',DateTimeToStr(OraAttuale));
    IniFile.WriteString('Parametri','URL TOM',Result);
  finally
    FreeAndNil(IniFile);
  end;*)
end;

//SSO.fine

procedure TWR000FBaseDM.CaricaImmagini;
var
  i: Integer;
  TagStr,ImgFile,ImgFileCompleto,Errore: String;
begin
  // 1. carica le immagini in formato png nella ImageListCache
  Errore:='';

  { DONE : TEST IW 14 OK }
  TagList:=TStringList.Create;
  try
    IWImageList.Clear;
    for i:=1 to High(FunzioniDisponibili) do
      if (L021VerificaApplicazione(Parametri.Applicazione,i) or (FunzioniDisponibili[i].M = 'IRIS_WEB')) then
      begin
        TagStr:=IntToStr(FunzioniDisponibili[i].T);
        ImgFile:=Format('%s.png',[TagStr]);

        // cerca il file con l'immagine prima nella cartella personalizzata,
        // poi in wwwroot\img
        if FileExists(UsrFolder + ImgFile) then
          ImgFileCompleto:=UsrFolder + ImgFile
        else if FileExists(BaseFolder + ImgFile) then
          ImgFileCompleto:=BaseFolder + ImgFile
        else
          ImgFileCompleto:='';

        Errore:=CaricaImmagine(ImgFileCompleto,TagStr,True);
      end;

    // eccezione
    if Errore <> '' then
      raise Exception.Create(Errore);
  except
    raise;
  end;
end;

(*
  Carica immagine a ImageList
  Input: Url cmpleta immagine
  Outpout: eventuale errore o stringa vuota
*)
function TWR000FBaseDM.CaricaImmagine(ImgFileCompleto,TagStr:String; AddToLst:Boolean):String;
begin
  { DONE : TEST IW 14 OK }
  // se il file esiste, lo carica nella imagelist
  if ImgFileCompleto <> '' then
  begin
    try
      IWImageList.MedpAggiungi(ImgFileCompleto);

      if AddToLst then
        TagList.Add(TagStr);
      Result:='';
    except
      on E: Exception do
        Result:=Result + Format('%s: immagine di menu %s: %s',[E.ClassName,ImgFileCompleto,E.Message]) + CRLF;
    end;
  end;
end;

procedure TWR000FBaseDM.AJAXIWCallbackNOP(EventParams: TStringList);
var
  i:Integer;
begin
  // Procedura intenzionalmente vuota
  i:=0;
end;

function TWR000FBaseDM.IsCambioAziendaAbilitato: Boolean;
// verifica se è possibile effettuare il cambio azienda
// restituisce true se:
// - per l'azienda corrente I090.LOGIN_USR_ABILITATO = 'S';
// - esiste lo stesso Utente su I070 per altre aziende in cui I090.LOGIN_USR_ABILITATO = 'S';
var
  LCercaUtentiIrisWeb: String;
begin
  // determina se effettuare la ricerca aziende considerando gli utenti irisweb
  LCercaUtentiIrisWeb:={$IFDEF WEBPJ}'N'{$ELSE}'S'{$ENDIF};

  // apre dataset con elenco delle aziende per cui sono verificate le seguenti condizioni:
  // - I090.LOGIN_USR_ABILITATO = 'S'
  // - è presente il proprio nome utente (identificato da Parametri.Operatore)
  selAziendeUtente.Close;
  selAziendeUtente.ClearVariables;
  selAziendeUtente.SetVariable('UTENTE',Parametri.Operatore);
  selAziendeUtente.SetVariable('I060',LCercaUtentiIrisWeb);
  selAziendeUtente.Open;

  // il cambio azienda è possibile se l'elenco contiene almeno 2 aziende,
  // di cui una è quella corrente (identificata da Parametri.Azienda)
  Result:=(selAziendeUtente.RecordCount > 1) and
          (selAziendeUtente.SearchRecord('AZIENDA',Parametri.Azienda,[srFromBeginning]));

  selAziendeUtente.Close;
end;

procedure TWR000FBaseDM.GetElencoCambioAziende(var RItems: TStringList);
var
  LIdxCurr: Integer;
  LCercaUtentiIrisWeb: String;
begin
  if RItems = nil then
    raise Exception.Create('Chiamata al metodo TWR000FBaseDM.GetElencoCambioAziende non valida: la stringlist non è valorizzata!');

  RItems.Clear;

  // determina se effettuare la ricerca aziende considerando gli utenti irisweb
  LCercaUtentiIrisWeb:={$IFDEF WEBPJ}'N'{$ELSE}'S'{$ENDIF};

  // apre dataset con elenco delle aziende per cui sono verificate le seguenti condizioni:
  // - I090.LOGIN_USR_ABILITATO = 'S'
  // - è presente il proprio nome utente (Parametri.Operatore)
  selAziendeUtente.Close;
  selAziendeUtente.ClearVariables;
  selAziendeUtente.SetVariable('UTENTE',Parametri.Operatore);
  selAziendeUtente.SetVariable('I060',LCercaUtentiIrisWeb);
  selAziendeUtente.Open;
  while not selAziendeUtente.Eof do
  begin
    RItems.Add(selAziendeUtente.FieldByName('AZIENDA').AsString);
    selAziendeUtente.Next;
  end;
  selAziendeUtente.Close;

  // rimuove dall'elenco l'azienda corrente
  LIdxCurr:=RItems.IndexOf(Parametri.Azienda);
  if LIdxCurr > -1 then
    RItems.Delete(LIdxCurr);
end;

procedure TWR000FBaseDM.DataModuleDestroy(Sender: TObject);
begin
  if TagList <> nil then
    try FreeAndNil(TagList); except end;
  if selI010 <> nil then
    try FreeAndNil(selI010); except end;
  if selDatiBloccati <> nil then
    try FreeAndNil(selDatiBloccati); except end;
  if lstCompInvisibili <> nil then
    try FreeAndNil(lstCompInvisibili); except end;
  if History <> nil then
    try FreeAndNil(History); except end;
  if ModuliAccessori <> nil then
    try FreeAndNil(ModuliAccessori); except end;
end;

// thread invio mail.ini
destructor TThreadMail.Destroy;
begin
  //FreeAndNil(C017DtMTh); //Non lo distrugge il thread, perchè appartiene al datamodulo (e deve essere così)
  inherited Destroy;
end;

procedure TThreadMail.Execute;
// non viene utilizzata una critical section
// in quanto per ogni chiamata viene creato un thread distinto
// che utilizza un proprio datamodule
begin
  if not Terminated then
    try
      (C017DtMTh as TC017FEMailDtM).InviaEMail;
    except
      // al momento nulla
      // impossibile dal thread utilizzare W000RegistraLog (non vede A000UInterfaccia)
    end;
end;
// thread invio mail.fine

end.
