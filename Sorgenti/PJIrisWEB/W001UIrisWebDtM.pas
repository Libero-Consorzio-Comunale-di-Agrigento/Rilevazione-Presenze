unit W001UIrisWebDtM;

interface

uses
  WR000UBaseDM, A000USessione, W000UMessaggi, L021Call,
  C180FunzioniGenerali, USelI010,
  DBClient, Windows, Messages, SysUtils, StrUtils, Classes,
  Controls, Forms, Db, OracleData, Oracle, Variants, Math,
  IWInit, IWApplication, A000UCostanti, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, C190FunzioniGeneraliWeb, Vcl.ImgList,
  meIWImageListCache, System.ImageList, IWImageList;

type
  TCampo = record
    FieldName: String;
    DisplayLabel: String;
    AsString: String;
    Clickable: Boolean;
    HasDesc: Boolean;
    DescAsString: String;
    NomePagina: String;
    Top: Integer;
    Left: Integer;
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  TNumMessaggi = record
    Totali: Integer;
    LetturaObbligatoria: Integer;
  end;
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

  TNotificaAttivita = record
    Tag:Integer;
    Refresh: Boolean;
    Contatore: Integer;
    Messaggio: String;
    TitoloNotifica: String;
    MsgNotifica: String;
  end;

  TNotificheAttivita = class
    Items:array of TNotificaAttivita;
  strict private
    function GetNotifica(Tag:Integer):TNotificaAttivita;
  public
    constructor Create;
    destructor Destroy;
    function AddNotifica(Tag:Integer):TNotificaAttivita;
    procedure UpdateNotifica(Value:TNotificaAttivita);
    procedure AttivaRefresh(Tag:Integer);
    property Notifica[Tag:Integer]:TNotificaAttivita read GetNotifica;
  end;

  TConteggioNotifica = record
    Numero: Integer;
    Messaggio: String;
  end;

  TDatoFiltro = record
    NomeDato: String;
    NomeCampo: String;
    NomeCampoDesc: String;
    ListaValoriAnag: TStringList;
    ListaValoriAgg: TStringList;
    procedure Clear; inline;
    function Esiste: Boolean; inline;
    function GetDatiSQL: String; inline;
    function GetListaValoriCompleta: TStringList;
  end;

  TW001FIrisWebDtM = class(TWR000FBaseDM)
    seldistT003: TOracleDataSet;
    selT003: TOracleDataSet;
    selDistAnagrafe: TOracleDataSet;
    insT003: TOracleQuery;
    selT350: TOracleDataSet;
    selT275: TOracleDataSet;
    selT265: TOracleDataSet;
    dsrT040: TDataSource;
    selT280: TOracleDataSet;
    selSG110: TOracleDataSet;
    selSG111: TOracleDataSet;
    selSG112: TOracleDataSet;
    selSG110_Luoghi: TOracleDataSet;
    selSG110PROGRESSIVO: TFloatField;
    selSG110DATA_REGISTRAZIONE: TDateTimeField;
    selSG110TIPOESPERIENZA: TStringField;
    selSG110DETTAGLIOESPERIENZA: TStringField;
    selSG110INCLUDI_STAMPA: TStringField;
    selSG110LUOGO_ESPERIENZA: TStringField;
    selSG110INIZIO_ESPERIENZA: TDateTimeField;
    selSG110FINE_ESPERIENZA: TDateTimeField;
    selSG110DESCRIZIONE: TStringField;
    selSG110ORIGINE: TStringField;
    selSG110STATO: TStringField;
    selSG110RI: TStringField;
    selSG110Desc_Tipo: TStringField;
    selSG110Desc_Dettaglio: TStringField;
    selSG113: TOracleDataSet;
    selSQL: TOracleDataSet;
    selSG651: TOracleDataSet;
    selSG650: TOracleDataSet;
    selSG654: TOracleDataSet;
    selSG651PROGRESSIVO: TFloatField;
    selSG651COD_CORSO: TStringField;
    selSG651DATA_CORSO: TDateTimeField;
    selSG651DURATA_CORSO: TStringField;
    selSG651NOTE: TStringField;
    selSG651TIPO_RECORD: TStringField;
    selSG651ORIGINE: TStringField;
    selSG651RI: TStringField;
    selSG651PULSANTE: TStringField;
    selSG651Desc_Corso: TStringField;
    selSG651Desc_TipoPart: TStringField;
    selSG110Desc_Stato: TStringField;
    selSG651STATO: TStringField;
    selSG651Desc_Stato: TStringField;
    delT003: TOracleQuery;
    Q950Lista: TOracleDataSet;
    selSG101: TOracleDataSet;
    selQSQL: TOracleQuery;
    cdsT950Int: TClientDataSet;
    selSG651ORA_INIZIO: TStringField;
    selSG651ORA_FINE: TStringField;
    selSG650Ediz: TOracleDataSet;
    selSG650Giorn: TOracleDataSet;
    selSG659: TOracleDataSet;
    selSG651DECORRENZA: TDateTimeField;
    selSG651EDIZIONE: TStringField;
    selSG651PROFILO_CREDITI: TStringField;
    selSG651DATA_ISCRIZIONE: TDateTimeField;
    selSG651Iscritti: TOracleDataSet;
    selSG651OPERATORE_ISCRIZIONE: TStringField;
    selSG651OPERATORE_AUTORIZZAZIONE: TStringField;
    selSG651DATA_AUTORIZZAZIONE: TDateTimeField;
    selSG651MATRICOLA: TStringField;
    selSG651NOMINATIVO: TStringField;
    selSG650c: TOracleDataSet;
    selSG651DESCGIORNO: TStringField;
    selT910: TOracleDataSet;
    SelCurriculum: TOracleDataSet;
    SelCurriculumPROGRESSIVO: TFloatField;
    SelCurriculumINIZIO: TStringField;
    SelCurriculumFINE: TStringField;
    SelCurriculumDETTAGLIO: TStringField;
    SelCurriculumTIPOESPERIENZA: TStringField;
    SelCurriculumLUOGO: TStringField;
    SelCurriculumNOTE: TStringField;
    SelCurriculumNOMINATIVO: TStringField;
    selT430: TOracleDataSet;
    selSG651ControlloIscritti: TOracleDataSet;
    SelSG655: TOracleDataSet;
    selT375: TOracleDataSet;
    selT305: TOracleDataSet;
    selP442Cumulo: TOracleDataSet;
    selP442NonCumulo: TOracleDataSet;
    selP442: TOracleDataSet;
    selP500: TOracleDataSet;
    selP441_Note: TOracleDataSet;
    selP442A: TOracleDataSet;
    delSG651: TOracleQuery;
    selSG651NUMERO_GIORNO: TFloatField;
    selSG651TIPO_PARTECIPAZIONE: TStringField;
    selSG651CREDITI: TFloatField;
    selSG651MAX_PARTECIPANTI: TFloatField;
    selSG651MAX_ISCRITTI: TFloatField;
    selSG651DATA_FINE: TDateTimeField;
    selSg651StatoGiornate: TOracleDataSet;
    delSG651b: TOracleQuery;
    upSG651: TOracleQuery;
    selI060Utenti: TOracleDataSet;
    selI061NomiProfili: TOracleDataSet;
    selI061PermessiUtente: TOracleDataSet;
    selI061DelegheUtente: TOracleDataSet;
    selI061DelegheEsistenti: TOracleDataSet;
    selI060DatiUtente: TOracleDataSet;
    selI090: TOracleDataSet;
    selI061ProfiloAssegnato: TOracleDataSet;
    selI061: TOracleDataSet;
    selDatoLibero: TOracleDataSet;
    selP504: TOracleDataSet;
    selT040: TOracleDataSet;
    selT040IMGSTAMPA: TStringField;
    selT040PROGRESSIVO: TFloatField;
    selT040DATA: TDateTimeField;
    selT040CAUSALE: TStringField;
    selT040DESCRIZIONE: TStringField;
    selT040DATANAS: TDateTimeField;
    selT040PROGRCAUSALE: TFloatField;
    selT040TIPOGIUST: TStringField;
    selT040DAORE: TDateTimeField;
    selT040AORE: TDateTimeField;
    selT040SCHEDA: TStringField;
    selT040STAMPA: TStringField;
    sel2T100: TOracleQuery;
    selSG101Causali: TOracleDataSet;
    selT080: TOracleDataSet;
    selT020: TOracleDataSet;
    selT163: TOracleDataSet;
    selaP504: TOracleDataSet;
    selAnagrafePeriodica: TOracleDataSet;
    selSG122: TOracleDataSet;
    insSG122: TOracleQuery;
    selSG122PROGRESSIVO: TIntegerField;
    selSG122DATA_AGG: TDateTimeField;
    selSG122TIPO_FAM: TStringField;
    selSG122COGNOME: TStringField;
    selSG122NOME: TStringField;
    selSG122CARICO: TStringField;
    selSG122DATA_CARICO_DA: TDateTimeField;
    selSG122DATA_CARICO_A: TDateTimeField;
    selSG122PERC_CARICO: TFloatField;
    selSG122MANCA_CONIUGE: TStringField;
    selSG122DETR_FIGLIO_HANDICAP: TStringField;
    selSG122DATANAS: TDateTimeField;
    selSG122CODFISCALE: TStringField;
    selSG122DESC_TIPO_FAM: TStringField;
    selSG122NUMORD: TFloatField;
    selSG120: TOracleDataSet;
    selaSG120: TOracleDataSet;
    selT480: TOracleDataSet;
    updSG122: TOracleQuery;
    selCOLS: TOracleDataSet;
    insStorico: TOracleQuery;
    selaSG101: TOracleDataSet;
    updSG101: TOracleQuery;
    insSG101: TOracleQuery;
    selbSG101: TOracleDataSet;
    updP430: TOracleQuery;
    selStorici: TOracleDataSet;
    selP020: TOracleDataSet;
    selSG122ORANAS: TStringField;
    updI061UltimoAccesso: TOracleQuery;
    selT361: TOracleDataSet;
    selT257: TOracleDataSet;
    selAssPres: TOracleDataSet;
    selT280EMail: TOracleDataSet;
    selT040NOTE: TStringField;
    selT282Count: TOracleQuery;
    selT282CountOper: TOracleQuery;
    selDatiPag: TOracleDataSet;
    selNotificaEventiSciopero: TOracleDataSet;
    selAnagEventoSciopero: TOracleDataSet;
    selConiuge: TOracleQuery;
    selT960CountDaLeggere: TOracleQuery;
    selP441CountDaLeggere: TOracleDataSet;
    selP504CountDaLeggere: TOracleDataSet;
    selT030DipCF: TOracleDataSet;
    seldSG101: TOracleDataSet;
    seldSG101GRADOPAR: TStringField;
    seldSG101COGNOME: TStringField;
    seldSG101NOME: TStringField;
    seldSG101DATANAS: TDateTimeField;
    seldSG101TIPO_DETRAZIONE: TStringField;
    seldSG101PERC_CARICO: TFloatField;
    seldSG101DETR_FIGLIO_HANDICAP: TStringField;
    seldSG101DESC_GRADO: TStringField;
    seldSG101DESC_DETRAZIONE: TStringField;
    seldSG101DESC_HANDICAP: TStringField;
    seldSG101DESC_PERC_CARICO: TStringField;
    selcSG101: TOracleDataSet;
    selcSG101GRADOPAR: TStringField;
    selcSG101DESC_GRADO: TStringField;
    selcSG101COGNOME: TStringField;
    selcSG101NOME: TStringField;
    selcSG101DATANAS: TDateTimeField;
    selcSG101SPECIALE_ANF: TStringField;
    selcSG101DESC_SPECIALE: TStringField;
    selcSG101INABILE_ANF: TStringField;
    selcSG101DESC_INABILE: TStringField;
    selcSG101REDDITO_TOT_ANF: TFloatField;
    selcSG101DESC_REDDITO: TStringField;
    selT275Lookup: TOracleDataSet;
    selMsgNotifica: TOracleDataSet;
    selT430CausaliAbilitate: TOracleDataSet;
    selT430RaggrAssenzeAbilitati: TOracleDataSet;
    procedure selSG651BeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure selSG110CalcFields(DataSet: TDataSet);
    procedure selSG651CalcFields(DataSet: TDataSet);
    procedure selSG122CalcFields(DataSet: TDataSet);
    procedure selcSG101CalcFields(DataSet: TDataSet);
    procedure seldSG101CalcFields(DataSet: TDataSet);
    procedure selAssPresFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT280AfterOpen(DataSet: TDataSet);
    procedure selP441FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    procedure GetNotificaAttivita(var NA: TNotificaAttivita);
    function  CampoDaEscludere(const Campo: String; SchedaCompleta: Boolean): Boolean;
    function  GetActiveFormCod: String;
    function  EsisteFilePDFCedolino(DataSet: TDataSet): String;
    function  GetNumRichiesteScioperoPendenti(var RDebugMsg: String): TConteggioNotifica;
    function  GetNumDocumentiDaLeggere(var RErrMsg: String): TConteggioNotifica;
    function  GetNumCedoliniDaLeggere: TConteggioNotifica;
    function  GetNumCuDaLeggere: TConteggioNotifica;
    function  GetNumRichDaAutorizzareW009: TConteggioNotifica;
    function  GetNumRichDaAutorizzareW010: TConteggioNotifica;
    function  GetNumRichDaAutorizzareW018: TConteggioNotifica;
    function  GetNumRichDaAutorizzareW024: TConteggioNotifica;
    function  GetNumRichDaAutorizzareW025: TConteggioNotifica;
    function  GetNumRichDaAutorizzareW026: TConteggioNotifica;
    function  GetNumRichDaAutorizzareW032: TConteggioNotifica;
    function  GetNumCertDaAutorizzareW048: TConteggioNotifica;
    function  GetNumRichDaAutorizzareW050: TConteggioNotifica;
    function  GetNumRichDaAutorizzareW052: TConteggioNotifica;
  public
    lstSQL: TStringList;          // utilizzato in W002RicercaAnagrafe: filtro della ricerca anagrafe
    FiltroRicerca,                // filtro anagrafe
    OrdinamentoRicerca,           // filtro anagrafe
    AccessoDirettoValutatore,     // valutazioni
    TipoValutazione: String;      // valutazioni
    SoloStampa: Boolean;          // valutazioni
    RefreshT003: Boolean;         // utilizzato in W002RicercaAnagrafe e W002AnagrafeElenco
    DataSetCorsi: TOracleDataSet; // utilizzato in W014PianifCorsi
    BookmarkIP: TBookMark;        // utilizzato in W002AnagrafeElenco
    CampoArr: array of TCampo;    // utilizzato in W002DatiAnagrafici + W002AnagrafeScheda
    NotificheAttivita: TNotificheAttivita;
    procedure InviaEmailT280;
    procedure InizializzazioneW001DtM; override;
    function  AccessoValutatore:String;
    procedure GetDatiAnagrafici(var Row:Integer;SchedaCompleta:Boolean);
    function  GetColumnDefault(const Tabella, Colonna:string):string;
    function  GetNumMsgDaLeggere: TNumMessaggi;
    function  GetNotificheAttivitaByTag(const PTag: Integer): TNotificaAttivita;
    function  TransV430toT430(ODS:TOracleDataset):Boolean;
    function  IsCambioProfiloAbilitato: Boolean;
    procedure SetDatoLibero(const PDato: String; var RDatoLibero: TDatoFiltro; pIgnoraInibizioni: Boolean = False; pData: TDateTime = 0);
  end;

implementation

uses A000UInterfaccia, R010UPaginaWeb,
     W010URichiestaAssenzeDM,
     W018URichiestaTimbratureDM,
     W024URichiestaStraordinariDM,
     W025UCambioOrarioDM,
     W026URichiestaStrGGDM,
     W032URichiestaMissioniDM,
     W048UCertificazioniDM,
     W050URichiestaDocumentaleDM,
     W052URichiestaDispTurniDM,
     C018UIterAutDM, W009UIterCartellinoDM;

{$R *.DFM}

procedure TW001FIrisWebDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  if (Owner as TIWApplication).Data <> nil then
  begin
    SetLength(BookmarkIP,0);
    SetLength(CampoArr,0);
    if lstSQL = nil then
      lstSQL:=TStringList.Create;
  end;
  FiltroRicerca:='';
  OrdinamentoRicerca:='';
  AccessoDirettoValutatore:='N';
  //TipoValutazione:='';
  Responsabile:=False;
  RefreshT003:=False;
  DataSetCorsi:=nil;
  if NotificheAttivita = nil then
    NotificheAttivita:=TNotificheAttivita.Create;
end;

procedure TW001FIrisWebDtM.DataModuleDestroy(Sender: TObject);
begin
  if lstSQL <> nil then
    try FreeAndNil(lstSQL); except end;
  if BookmarkIP <> nil then
  begin
    try
      cdsAnagrafe.FreeBookmark(BookmarkIP);
    except
    end;
  end;
  if CampoArr <> nil then
    SetLength(CampoArr,0);

  FreeAndNil(NotificheAttivita);
  inherited;
end;

function TW001FIrisWebDtM.GetActiveFormCod: String;
begin
  Result:='';
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.ActiveForm <> nil) then
  begin
    try
      Result:=(GGetWebApplicationThreadVar.ActiveForm as TR010FPaginaWeb).medpCodiceForm;
    except
    end;
  end;
end;

procedure TW001FIrisWebDtM.InviaEmailT280;
(*var
  LstProg, LstTitolo, LstTesto, LstEMail, LstEMailCC, LstEMailCCN: TStringList;*)
begin
  //invio per email dei messaggi contenuti in T280 (righe con FLAG = '3')
  if Parametri.CampiRiferimento.C90_EMailSMTPHost <> '' then
  begin
    with selT280EMail do
    begin
      Open;
      if RecordCount > 0 then
      begin
        //Prima passata per valorizzare LOG in modo che altri non leggano le stesse richieste
        while not Eof do
        begin
          Edit;
          FieldByName('LOG').AsString:='(inviata email)';
          Post;
          Next;
        end;
        SessioneOracle.Commit;
        //Seconda passata per invio email
        First;
        while not Eof do
        begin
          //Alberto 22/12/2011: invio solo al richiedente
          try
            InviaEMail(False,FieldByName('PROGRESSIVO').AsInteger,FieldByName('TITOLO').AsString,FieldByName('TESTO').AsString,
                      -1,'','','',
                      FieldByName('EMAIL').AsString,FieldByName('EMAIL_CC').AsString,FieldByName('EMAIL_CCN').AsString);
          except
          end;
          Next;
        end;
        (* PALERMO_POLICLINICO - 163352 - invio mail senza aprire-chiudere la connessione per ogni mail (DA COMPLETARE)
          InviaLstEMail(False,LstProg,LstTitolo,LstTesto,
                      -1,'','','',
                      LstEMail,LstEMailCC,LstEMailCCN);*)
      end;
      CloseAll;
    end;
  end;
end;

function TW001FIrisWebDtM.IsCambioProfiloAbilitato: Boolean;
// verifica se è possibile effettuare il cambio azienda
// restituisce true se:
// - per l'azienda e l'operatori correnti
// - esisteno più profili web disponibili
begin
  R180SetVariable(selI061,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selI061,'NOME_UTENTE',Parametri.Operatore);
  selI061.Open;
  Result:=selI061.RecordCount > 1;
end;

procedure TW001FIrisWebDtM.InizializzazioneW001DtM;
begin
  InviaEmailT280;

  //selSG110 (W012)
  selSG110.SetVariable('QVISTAORACLE',QVistaOracle);
  //selSG113 (W013)
  selSG113.SetVariable('QVISTAORACLE',QVistaOracle);
  //selSG651 (W014)
  selSG651.SetVariable('QVISTAORACLE',QVistaOracle);

  // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.ini
  // prepara il dataset selAnagEvento, utilizzato per estrarre le anagrafiche
  // della selezione indicata in un determinato evento di sciopero
  selAnagEventoSciopero.SQL.Text:=QVistaOracle;
  selAnagEventoSciopero.SQL.Insert(0,Format('SELECT %s T030.PROGRESSIVO FROM',[Parametri.CampiRiferimento.C26_HintT030V430]));
  selAnagEventoSciopero.SQL.Add(':FILTRO_IN_SERVIZIO');
  selAnagEventoSciopero.SQL.Add(':FILTRO');
  selAnagEventoSciopero.DeleteVariables;
  selAnagEventoSciopero.DeclareVariable('DATALAVORO',otDate);
  selAnagEventoSciopero.DeclareVariable('FILTRO',otSubst);
  selAnagEventoSciopero.DeclareVariable('FILTRO_IN_SERVIZIO',otSubst);
  // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.fine

  inherited;

  //Alberto 30/11/2017: per accesso da dipendente forzo la data corrente come data di lavoro senza considerare eventuale data salvata su T432
  if TipoUtente <> 'Supervisore' then
    Parametri.DataLavoro:=Date;
end;

function TW001FIrisWebDtM.AccessoValutatore:String;
var i:Integer;
begin
  Result:='N';
  //Se l'utente è di I070 non effettuo l'accesso diretto, a causa dell'eventuale pesantezza del filtro anagrafe
  if TipoUtente = 'Supervisore' then
    exit;
  for i:=0 to High(Parametri.AbilitazioniFunzioni) do
    //Se trovo una funzione web abilitata...
    if (UpperCase(Copy(Parametri.AbilitazioniFunzioni[i].Funzione,1,5)) = UpperCase('OpenW'))
    and (UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) <> UpperCase('OpenW007GestioneSicurezza'))
    and (   (Parametri.AbilitazioniFunzioni[i].Inibizione = 'S')
         or (Parametri.AbilitazioniFunzioni[i].Inibizione = 'R')) then
      //...deve essere per l'autovalutazione...
      if UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) = UpperCase('OpenW022SchedaAutovalutazioni') then
        Result:=IfThen(Result <> 'V','A',Result)
      //...deve essere per le schede quant.ind...
      else if UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) = UpperCase('OpenW031SchedeQuantIndividuali') then
        Result:=IfThen(Result <> 'V',IfThen(Result <> 'A','Q',Result),Result)
      //...o per la valutazione...
      else if UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) = UpperCase('OpenW022SchedaValutazioni') then
        Result:='V'
      //...altrimenti esco
      else
      begin
        Result:='N';
        Break;
      end;
end;

procedure TW001FIrisWebDtM.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  if DataSet = selT020 then
    Accept:=A000FiltroDizionario('MODELLI ORARIO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT163 then
    Accept:=A000FiltroDizionario('PROFILI INDENNITA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT265 then
    Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT275 then
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT350 then
    Accept:=A000FiltroDizionario('TURNI REPERIBILITA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT361 then
    Accept:=A000FiltroDizionario('OROLOGI DI TIMBRATURA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = Q950Lista then
    Accept:=A000FiltroDizionario('PARAMETRIZZAZIONI CARTELLINO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT910 then
    Accept:=A000FiltroDizionario('GENERATORE DI STAMPE',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = seldistT003 then
    Accept:=A000FiltroDizionario('SELEZIONI ANAGRAFICHE',DataSet.FieldByName('NOME').AsString);
end;

procedure TW001FIrisWebDtM.selAssPresFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if DataSet.FieldByName('TIPO').AsString = 'A' then
    Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TW001FIrisWebDtM.selP441FilterRecord(DataSet: TDataSet; var Accept: Boolean);
//richiamato sia da selP441 che da selP441CountDaLeggere
begin
  inherited;
  Accept:=EsisteFilePDFCedolino(DataSet) = 'S';
end;

function TW001FIrisWebDtM.EsisteFilePDFCedolino(DataSet: TDataSet): String;
var NomeFileOrig,PathPDF:String;
    IdCedolino:Integer;
    DataRetribuzione,DataCedolino:TDateTime;
begin
  inherited;
  Result:='N';
  if Parametri.WEBCedoliniFilePDF = 'S' then
    try
      DataRetribuzione:=R180FineMese(StrToDate('01/' + DataSet.FieldByName('DATA_RETRIBUZIONE').AsString));
      selP500.Close;
      selP500.SetVariable('Anno', strtoint(FormatDateTime('yyyy',DataRetribuzione)));
      selP500.Open;
      if selP500.SearchRecord('COD_AZIENDA_BASE',T440AZIENDA_BASE,[srFromBeginning]) then
        PathPDF:=selP500.FieldByName('PATH_FILEPDF_CED').AsString
      else
        PathPDF:='';
      DataCedolino:=R180FineMese(StrToDate('01/' + DataSet.FieldByName('DATA_CEDOLINO').AsString));
      IdCedolino:=DataSet.FieldByName('ID_CEDOLINO').AsInteger;
      NomeFileOrig:=PathPDF + '\' + FormatDateTime('yyyymm',DataCedolino) + '\' + IntToStr(IdCedolino) + '.pdf';
      Result:=IfThen(FileExists(NomeFileOrig),'S','N');
    except
    end;
end;

procedure TW001FIrisWebDtM.selSG110CalcFields(DataSet: TDataSet);
begin
  with selSG110 do
  begin
    FieldByName('Desc_Tipo').AsString:=FieldByName('TIPOESPERIENZA').AsString + ' - ' +
      VarToStr(selSG111.Lookup('CODICE',FieldByName('TIPOESPERIENZA').AsString,'DESCRIZIONE'));
    FieldByName('Desc_Dettaglio').AsString:=FieldByName('DETTAGLIOESPERIENZA').AsString + ' - ' +
      VarToStr(selSG112.Lookup('TIPOESPERIENZA;CODICE',VarArrayOf([FieldByName('TIPOESPERIENZA').AsString,FieldByName('DETTAGLIOESPERIENZA').AsString]),'DESCRIZIONE'));
    if FieldByName('STATO').AsString = 'I' then
      FieldByName('Desc_Stato').AsString:='Valida'
    else if FieldByName('STATO').AsString = 'C' then
      FieldByName('Desc_Stato').AsString:='Non Valida'
    else if FieldByName('STATO').AsString = 'R' then
      FieldByName('Desc_Stato').AsString:='Richiesta';
  end;
end;

procedure TW001FIrisWebDtM.selSG122CalcFields(DataSet: TDataSet);
begin
  with selSG122 do
  begin
    if FieldByName('TIPO_FAM').AsString = 'CG' then
      FieldByName('DESC_TIPO_FAM').AsString:='Coniuge'
    else if Copy(FieldByName('TIPO_FAM').AsString,1,2) = 'FG' then
      FieldByName('DESC_TIPO_FAM').AsString:=Copy(FieldByName('TIPO_FAM').AsString,3) + '° Figlio'
    else if Copy(FieldByName('TIPO_FAM').AsString,1,2) = 'AL' then
      FieldByName('DESC_TIPO_FAM').AsString:=Copy(FieldByName('TIPO_FAM').AsString,3) + '° Altro familiare';
  end;
end;

procedure TW001FIrisWebDtM.selcSG101CalcFields(DataSet: TDataSet);
begin
  with selcSG101 do
  begin
    if FieldByName('GRADOPAR').AsString = 'NS' then
      FieldByName('Desc_Grado').AsString:='Nessuno/Sè stesso'
    else if FieldByName('GRADOPAR').AsString = 'CG' then
      FieldByName('Desc_Grado').AsString:='Coniuge'
    else if FieldByName('GRADOPAR').AsString = 'FG' then
      FieldByName('Desc_Grado').AsString:='Figlio/Figlia'
    else if FieldByName('GRADOPAR').AsString = 'GT' then
      FieldByName('Desc_Grado').AsString:='Genitore'
    else if FieldByName('GRADOPAR').AsString = 'FR' then
      FieldByName('Desc_Grado').AsString:='Fratello/Sorella'
    else if FieldByName('GRADOPAR').AsString = 'NP' then
      FieldByName('Desc_Grado').AsString:='Nipote'
    else if FieldByName('GRADOPAR').AsString = 'NF' then
      FieldByName('Desc_Grado').AsString:='Nipote equiparato figlio'
    else if FieldByName('GRADOPAR').AsString = 'AL' then
      FieldByName('Desc_Grado').AsString:='Altro'
    else if FieldByName('GRADOPAR').AsString = 'AF' then
      FieldByName('Desc_Grado').AsString:='Affidato'
    else if FieldByName('GRADOPAR').AsString = 'UC' then
      FieldByName('Desc_Grado').AsString:='Unito civilmente'
    else if FieldByName('GRADOPAR').AsString = 'CF' then
      FieldByName('Desc_Grado').AsString:='Convivente di fatto';

    if R180In(FieldByName('GRADOPAR').AsString,['FG']) then
    begin
      if FieldByName('SPECIALE_ANF').AsString = 'S' then
        FieldByName('Desc_Speciale').AsString:='Si'
      else
        FieldByName('Desc_Speciale').AsString:='No';
    end;

    if FieldByName('INABILE_ANF').AsString = 'S' then
      FieldByName('Desc_Inabile').AsString:='Si'
    else
      FieldByName('Desc_Inabile').AsString:='No';

    FieldByName('Desc_Reddito').AsString:=R180Formatta(FieldByName('REDDITO_TOT_ANF').AsFloat,10,2);
  end;
end;

procedure TW001FIrisWebDtM.seldSG101CalcFields(DataSet: TDataSet);
begin
  with seldSG101 do
  begin
    if FieldByName('GRADOPAR').AsString = 'NS' then
      FieldByName('Desc_Grado').AsString:='Nessuno/Sè stesso'
    else if FieldByName('GRADOPAR').AsString = 'CG' then
      FieldByName('Desc_Grado').AsString:='Coniuge'
    else if FieldByName('GRADOPAR').AsString = 'FG' then
      FieldByName('Desc_Grado').AsString:='Figlio/Figlia'
    else if FieldByName('GRADOPAR').AsString = 'GT' then
      FieldByName('Desc_Grado').AsString:='Genitore'
    else if FieldByName('GRADOPAR').AsString = 'FR' then
      FieldByName('Desc_Grado').AsString:='Fratello/Sorella'
    else if FieldByName('GRADOPAR').AsString = 'NP' then
      FieldByName('Desc_Grado').AsString:='Nipote'
    else if FieldByName('GRADOPAR').AsString = 'NF' then
      FieldByName('Desc_Grado').AsString:='Nipote equiparato figlio'
    else if FieldByName('GRADOPAR').AsString = 'AL' then
      FieldByName('Desc_Grado').AsString:='Altro'
    else if FieldByName('GRADOPAR').AsString = 'AF' then
      FieldByName('Desc_Grado').AsString:='Affidato'
    else if FieldByName('GRADOPAR').AsString = 'UC' then
      FieldByName('Desc_Grado').AsString:='Unito civilmente'
    else if FieldByName('GRADOPAR').AsString = 'CF' then
      FieldByName('Desc_Grado').AsString:='Convivente di fatto';

    if FieldByName('TIPO_DETRAZIONE').AsString = 'DC' then
      FieldByName('Desc_Detrazione').AsString:='Coniuge'
    else if FieldByName('TIPO_DETRAZIONE').AsString = 'DF' then
      FieldByName('Desc_Detrazione').AsString:='Figlio'
    else if FieldByName('TIPO_DETRAZIONE').AsString = 'DA' then
      FieldByName('Desc_Detrazione').AsString:='Altri';

    if not R180In(FieldByName('GRADOPAR').AsString,['CG','UC']) then
      FieldByName('Desc_Perc_Carico').AsString:=FieldByName('PERC_CARICO').AsString;

    if R180In(FieldByName('TIPO_DETRAZIONE').AsString,['DF']) then
    begin
      if FieldByName('DETR_FIGLIO_HANDICAP').AsString = 'S' then
        FieldByName('Desc_Handicap').AsString:='Si'
      else
        FieldByName('Desc_Handicap').AsString:='No';
    end;
  end;
end;

procedure TW001FIrisWebDtM.selSG651CalcFields(DataSet: TDataSet);
var
  sDep:string;
begin
  with selSG651 do
  begin
    if DataSetCorsi = nil then
    begin
      if not Responsabile then
        DataSetCorsi:=selSG650
      else
        DataSetCorsi:=selSG650c;
      DataSetCorsi.SetVariable('DATAINIZIO',GetVariable('DATAINIZIO'));
      DataSetCorsi.SetVariable('DATAFINE',GetVariable('DATAFINE'));
      DataSetCorsi.Open;
    end
    else if not DataSetCorsi.Active then
    begin
      DataSetCorsi.SetVariable('DATAINIZIO',GetVariable('DATAINIZIO'));
      DataSetCorsi.SetVariable('DATAFINE',GetVariable('DATAFINE'));
      DataSetCorsi.Open;
    end;
    sDep:=VarToStr(DataSetCorsi.Lookup('CODICE',FieldByName('COD_CORSO').AsString,'TITOLO_CORSO'));
    FieldByName('Desc_Corso').AsString:=FieldByName('COD_CORSO').AsString + ' - ' + sDep;
    if FieldByName('STATO').AsString = 'I' then
      FieldByName('Desc_Stato').AsString:='Valida'
    else if FieldByName('STATO').AsString = 'C' then
      FieldByName('Desc_Stato').AsString:='Non Valida'
    else if FieldByName('STATO').AsString = 'R' then
      FieldByName('Desc_Stato').AsString:='Richiesta'
    else if FieldByName('STATO').AsString = 'A' then
      FieldByName('Desc_Stato').AsString:='Autorizzata'
    else if FieldByName('STATO').AsString = 'N' then
      FieldByName('Desc_Stato').AsString:='Non autorizzata';
  end;
end;

procedure TW001FIrisWebDtM.selT280AfterOpen(DataSet: TDataSet);
begin
  TDateTimeField(selT280.FieldByName('DATA')).DisplayFormat:='dd/mm/yyyy hhhh.nn';
end;

procedure TW001FIrisWebDtM.selSG651BeforePost(DataSet: TDataSet);
begin
  //Controllo se il dipendente ha già partecipato alla stessa giornata di corso in passato...
  selSG651ControlloIscritti.Close;
  selSG651ControlloIscritti.SetVariable('CODICEIN',DataSet.FieldByName('COD_CORSO').AsString);
  selSG651ControlloIscritti.SetVariable('NUMERO_GIORNO',DataSet.FieldByName('NUMERO_GIORNO').AsInteger);
  selSG651ControlloIscritti.Open;
  if selSG651ControlloIscritti.RecordCount > 0 then
    GGetWebApplicationThreadVar.ShowMessage('Attenzione: hai già partecipato a questa giornata di corso in passato!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),GetActiveFormCod,Dataset,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),GetActiveFormCod,Dataset,True);
  end;
end;

function TW001FIrisWebDtM.CampoDaEscludere(const Campo: String; SchedaCompleta: Boolean): Boolean;
var
  v: Variant;
  NomeCampo,Accesso: string;
  Posizione: Integer;
begin
  // campo progressivo -> escluso
  Result:=(Campo = 'PROGRESSIVO') or
          (Campo = 'T430PROGRESSIVO');
  if Result then
    Exit;

  // campo descrittivo (di decodifica) -> escluso
  Result:=(Copy(Campo,1,6) = 'T430D_') and
          (Campo <> 'T430D_PROVINCIA'); // dicitura fissa per "provincia di residenza"
  if Result then
    Exit;

  // estrae dati da tabella I010
  v:=cdsI010.Lookup('NOME_CAMPO',Campo,'NOME_CAMPO;ACCESSO;POSIZIONE');

  // campo non trovato -> escluso
  Result:=VarIsNull(v);
  if Result then
    Exit;

  // salva dati in variabili di appoggio
  NomeCampo:=VarToStr(v[0]);
  Accesso:=VarToStr(v[1]);
  Posizione:=StrToIntDef(VarToStr(v[2]),-1);

  // accesso 'N' oppure non indicato -> escluso
  Result:=(Accesso = 'N') or (Accesso = '');
  if Result then
    Exit;

  // scheda non completa e posizione < 0 -> escluso
  Result:=(not SchedaCompleta) and
          (Posizione < 0);
end;

procedure TW001FIrisWebDtM.GetDatiAnagrafici(var Row:Integer; SchedaCompleta:Boolean);
var
  //i:Integer;
  F:TField;
  NomeCampo,OldIndexName: String;
begin
  // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini
  // la scheda anagrafica visualizza i campi ordinati in base all'indice "Layout" di cdsI010
  OldIndexName:=cdsI010.IndexName;
  cdsI010.IndexName:='Layout';
  // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini

  SetLength(CampoArr,0);
  Row:=0;
  with cdsI010 do
  begin
    First;
    while not Eof do
    begin
      NomeCampo:=FieldByName('NOME_CAMPO').AsString;
      if not CampoDaEscludere(NomeCampo,SchedaCompleta) then
      begin
        // inserisce i dati nell'array
        SetLength(CampoArr,Row + 1);
        CampoArr[Row].FieldName:=NomeCampo;
        CampoArr[Row].DisplayLabel:=FieldByName('CAPTION_LAYOUT').AsString;
        CampoArr[Row].NomePagina:=Format('(%s) %s',[FieldByName('NOMEPAGINA_ORD').AsString,FieldByName('NOMEPAGINA').AsString]);
        CampoArr[Row].Top:=FieldByName('TOP').AsInteger;
        CampoArr[Row].Left:=FieldByName('LFT').AsInteger;
        F:=cdsAnagrafe.FindField(NomeCampo);
        if F = nil then
          CampoArr[Row].AsString:=''
        else
          CampoArr[Row].AsString:=F.AsString;
        CampoArr[Row].Clickable:=False;
        CampoArr[Row].HasDesc:=False;
        if Copy(NomeCampo,1,4) = 'T430' then
        begin
          CampoArr[Row].Clickable:=True;
          F:=cdsAnagrafe.FindField(StringReplace(NomeCampo,'T430','T430D_',[]));
          if F <> nil then
          begin
            CampoArr[Row].HasDesc:=True;
            CampoArr[Row].DescAsString:=F.AsString;
          end;
        end;

        inc(Row);
      end;
      Next;
    end;
  end;

  // ripristina l'indice originale su cdsI010
  cdsI010.IndexName:='Layout';
  // MONDOEDP - commessa MAN/02 SVILUPPO#110.fine
end;

function TW001FIrisWebDtM.GetColumnDefault(const Tabella, Colonna:string):string;
var
  selUserTabCol:TOracleQuery;
begin
  Result:='';
  selUserTabCol:=TOracleQuery.Create(nil);
  try
    selUserTabCol.Session:=SessioneOracle;
    selUserTabCol.SQL.Add('declare');
    selUserTabCol.SQL.Add('  LONG_DEFAULT long;');
    selUserTabCol.SQL.Add('begin');
    selUserTabCol.SQL.Add('  begin');
    selUserTabCol.SQL.Add('    select DATA_DEFAULT into LONG_DEFAULT');
    selUserTabCol.SQL.Add('      from USER_TAB_COLS');
    selUserTabCol.SQL.Add('     where TABLE_NAME = :TABELLA');
    selUserTabCol.SQL.Add('       and COLUMN_NAME = :COLONNA;');
    selUserTabCol.SQL.Add('     :DATA_DEFAULT:=substr(LONG_DEFAULT,1,2000);');
    selUserTabCol.SQL.Add('  exception');
    selUserTabCol.SQL.Add('    when NO_DATA_FOUND then');
    selUserTabCol.SQL.Add('      :DATA_DEFAULT:='''';');
    selUserTabCol.SQL.Add('  end;');
    selUserTabCol.SQL.Add('end;');
    selUserTabCol.DeclareAndSet('TABELLA',otString,Tabella);
    selUserTabCol.DeclareAndSet('COLONNA',otString,Colonna);
    selUserTabCol.DeclareVariable('DATA_DEFAULT',otString);
    selUserTabCol.Execute;
    Result:=VarToStr(selUserTabCol.GetVariable('DATA_DEFAULT'));
  finally
    FreeAndNil(selUserTabCol);
  end;
end;

function TW001FIrisWebDtM.GetNumMsgDaLeggere: TNumMessaggi;
// nell'ambito della gestione del modulo messaggistica
// estrae un tipo record con le seguenti informazioni:
// - Result.Totali:
//     tot. messaggi da leggere (data_lettura is null) per l'operatore / utente web collegato,
// - Result.LetturaObbligatoria:
//     tot. messaggi con data_ricezione null se lettura obbligatoria
//     (i messaggi con lettura obbligatoria vengono contati non in base alla
//      data_lettura nulla, ma in base alla data_ricezione)
var
  selCount: TOracleQuery;
begin
  Result.Totali:=0;
  Result.LetturaObbligatoria:=0;
  try
    // nel contesto della messaggistica, l'utente web non associato
    // ad una matricola è considerato come un operatore
    if (TipoUtente = 'Supervisore') or
       (Parametri.MatricolaOper = '') then
    begin
      selT282CountOper.SetVariable('UTENTE',Parametri.Operatore);
      selCount:=selT282CountOper;
    end
    else
    begin
      selT282Count.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
      selCount:=selT282Count;
    end;

    // query conteggio messaggi da leggere
    selCount.Execute;
    if not selCount.Eof then
    begin
      Result.Totali:=selCount.FieldAsInteger(0);
      Result.LetturaObbligatoria:=selCount.FieldAsInteger(1);
    end;
  except
  end;
end;

function TW001FIrisWebDtM.GetNumRichiesteScioperoPendenti(var RDebugMsg: String): TConteggioNotifica;
// restituisce il numero di eventi di sciopero per cui:
// - non è presente una richiesta
// oppure
// - la richiesta non è autorizzata all'ultimo livello
var
  VisNotifica: Boolean;
  T1, DataInizioNotifica: TDateTime;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  RDebugMsg:='';

  // cronometro
  T1:=Now;

  // estrae gli eventi di sciopero futuri che non hanno ancora una richiesta associata
  // autorizzata all'ultimo livello, considerando i giorni di notifica
  selNotificaEventiSciopero.Close;
  selNotificaEventiSciopero.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
  selNotificaEventiSciopero.Open;

  // per ognuno degli eventi estratti valuta le selezioni anagrafiche,
  // per verificare quelle che intersecano la propria
  // nota: gli eventi sono ordinati per data decrescente, perciò sono considerati
  //       in modo prioritario quelli più recenti
  while not selNotificaEventiSciopero.Eof do
  begin
    VisNotifica:=selNotificaEventiSciopero.FieldByName('SELEZIONE_ANAGRAFICA').IsNull;
    if not VisNotifica then
    begin
      // valuta la selezione anagrafica associata all'evento per estrarre i progressivi
      // che possono partecipare allo sciopero
      selAnagEventoSciopero.SetVariable('DATALAVORO',selNotificaEventiSciopero.FieldByName('DATA').AsDateTime);
      selAnagEventoSciopero.SetVariable('FILTRO','AND ' + selNotificaEventiSciopero.FieldByName('SELEZIONE_ANAGRAFICA').AsString);
      selAnagEventoSciopero.SetVariable('FILTRO_IN_SERVIZIO',FILTRO_IN_SERVIZIO);
      selAnagEventoSciopero.Open;

      // valuta se esiste almeno un dipendente in comune tra le due selezioni anagrafiche
      cdsAnagrafe.First;
      while not cdsAnagrafe.Eof do
      begin
        if selAnagEventoSciopero.SearchRecord('PROGRESSIVO',cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        begin
          // notifica
          VisNotifica:=True;

          // in debug fornisce info sul primo evento da notificare
          if (DebugHook <> 0) and (RDebugMsg = '') then
          begin
            DataInizioNotifica:=selNotificaEventiSciopero.FieldByName('DATA').AsDateTime -
                                selNotificaEventiSciopero.FieldByName('GG_NOTIFICA').AsInteger;
            RDebugMsg:=Format('<hr/>(**) Evento del %s da notificare a partire dal %s (%d giorni prima)',
                              [selNotificaEventiSciopero.FieldByName('DATA').AsString,
                               DateToStr(DataInizioNotifica),
                               selNotificaEventiSciopero.FieldByName('GG_NOTIFICA').AsInteger]);
          end;
          Break;
        end;
        cdsAnagrafe.Next;
      end;
      cdsAnagrafe.First;
    end;

    // la notifica è generica, per cui al primo evento da notificare il ciclo si interrompe
    if VisNotifica then
      Result.Numero:=Result.Numero + 1;

    selNotificaEventiSciopero.Next;
  end;

  // chiusura dataset di supporto
  selNotificaEventiSciopero.CloseAll;
  selAnagEventoSciopero.CloseAll;

  // messaggio di debug
  if DebugHook <> 0 then
    RDebugMsg:=RDebugMsg + Format('<hr/>(ricerca effettuata in %s sec.)',[FormatDateTime('ss.zzz',Now - T1)]);
end;

function TW001FIrisWebDtM.GetNumDocumentiDaLeggere(var RErrMsg: String): TConteggioNotifica;
// restituisce il numero di documenti da leggere per il progressivo corrente
// oppure -1 in caso di errore
begin
  RErrMsg:='';
  Result.Messaggio:='';

  if Parametri.TipoOperatore = 'I070' then
  begin
    // operatore win
    //   per l'operatore iriswin non è prevista la possibilità di avere documenti da leggere
    Result.Numero:=0;
  end
  else
  begin
    // operatore web
    //   conta i record di T960 per il progressivo del dipendente attualmente loggato
    //   con data_lettura_progressivo is null
    try
      selT960CountDaLeggere.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
      selT960CountDaLeggere.Execute;
      Result.Numero:=selT960CountDaLeggere.FieldAsInteger(0);
    except
      on E: Exception do
      begin
        Result.Numero:=-1;
        RErrMsg:=E.Message;
      end;
    end;
  end;
end;

function TW001FIrisWebDtM.GetNumCedoliniDaLeggere: TConteggioNotifica;
// restituisce il numero di cedolini da leggere per il progressivo corrente
// oppure -1 in caso di errore
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  //prevista la possibilità di avere cedolini da consultare per:
  //operatori irisweb, con cedolino non internazionale
  if (Parametri.TipoOperatore <> 'I070')
  and (Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S') then
  begin
    //conta i record di P441 per il progressivo del dipendente attualmente loggato
    //il cedolino deve essere: chiuso, non letto, ai valori massimi di data_cedolino,data_retribuzione,data_emissione
    try
      selP441CountDaLeggere.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
      selP441CountDaLeggere.SetVariable('WEB_CEDOLINI_GGEMISS',Parametri.WEBCedoliniGGEmiss);
      selP441CountDaLeggere.SetVariable('WEB_CEDOLINI_DATAMIN',Parametri.WEBCedoliniDataMin);
      selP441CountDaLeggere.SetVariable('WEB_CEDOLINI_MMPREC',Parametri.WEBCedoliniMMPrec);
      selP441CountDaLeggere.Open;
      selP441CountDaLeggere.Filtered:=Parametri.WEBCedoliniFilePDF = 'S';
      Result.Numero:=selP441CountDaLeggere.RecordCount; //Possono essercene più di uno per via del Tipo_Cedolino
      selP441CountDaLeggere.Close;
    except
      on E: Exception do
      begin
        Result.Numero:=-1;
      end;
    end;
  end;
end;

function TW001FIrisWebDtM.GetNumCUDaLeggere: TConteggioNotifica;
// restituisce il numero di CU da leggere per il progressivo corrente
// oppure -1 in caso di errore
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  //prevista la possibilità di avere CU da consultare per:
  //operatori irisweb, con cedolino non internazionale
  if (Parametri.TipoOperatore <> 'I070')
  and (Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S') then
  begin
    //conta i record di P504 per il progressivo del dipendente attualmente loggato
    //il CU deve essere: chiuso, non annullato, dell'anno in corso, non letto, visibile
    try
      selP504CountDaLeggere.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
      selP504CountDaLeggere.Open;
      Result.Numero:=selP504CountDaLeggere.RecordCount;
      selP504CountDaLeggere.Close;
    except
      on E: Exception do
      begin
        Result.Numero:=-1;
      end;
    end;
  end;
end;

function TW001FIrisWebDtM.GetNumRichDaAutorizzareW009: TConteggioNotifica;
var
  C018DM: TC018FIterAutDM;
  W009DM: TW009FIterCartellinoDM;
  D, Data1, Data2: TDateTime;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  // 442 - validazione cartellini
  try
    // imposta dati di supporto al dataset principale dell'iter
    Responsabile:=True;

    // crea datamodule iter validazione cartellino
    W009DM:=TW009FIterCartellinoDM.Create(nil);

    // impostazioni datamodule generico per gli iter
    C018DM:=TC018FIterAutDM.Create(nil);
    C018DM.Responsabile:=Responsabile;
    C018DM.Iter:=ITER_CARTELLINO; //C018DM.MsgNotifica disponibile
    C018DM.TipoRichiesteSel:=[trDaAutorizzare];
    C018DM.NotificaAttivita:=True;
    C018DM.PreparaDataSetIter(W009DM.selT860,tiAutorizzazione);

    // estrae le richieste da autorizzare
    W009DM.selT860.OnCalcFields:=nil;
    W009DM.selT860.Close;
    W009DM.selT860.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W009DM.selT860.SetVariable('FILTRO_ANAG',FiltroRicerca);
    W009DM.selT860.SetVariable('FILTRO_PERIODO','');
    W009DM.selT860.SetVariable('FILTRO_VISUALIZZAZIONE',C018DM.FiltroRichieste);
    if not TransV430toT430(W009DM.selT860) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
    W009DM.selT860.Open;

    D:=R180InizioMese(Date);
    Data1:=R180AddMesi(D,-1 * IfThen(Parametri.WEBCartelliniMMPrec > 0,Parametri.WEBCartelliniMMPrec,12));
    Data1:=Max(Data1,Parametri.WEBCartelliniDataMin);
    Data2:=D - 1;

    W009DM.selT070Notifiche.Close;
    W009DM.selT070Notifiche.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W009DM.selT070Notifiche.SetVariable('FILTRO_ANAG',FiltroRicerca);
    W009DM.selT070Notifiche.SetVariable('DATA1',Data1);
    W009DM.selT070Notifiche.SetVariable('DATA2',Data2);
    W009DM.selT070Notifiche.Open;

    Result.Numero:=W009DM.selT860.RecordCount + W009DM.selT070Notifiche.Fields[0].AsInteger;
    Result.Messaggio:=C018DM.MsgNotifica;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W009DM);
  end;
end;

function TW001FIrisWebDtM.GetNumRichDaAutorizzareW010: TConteggioNotifica;
var
  C018DM: TC018FIterAutDM;
  W010DM: TW010FRichiestaAssenzeDM;
  statusT265Filtered:Boolean;
  statusT265Active:Boolean;
  statusT275Filtered:Boolean;
  statusT275Active:Boolean;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  //tag 407 - autorizzazione assenze
  // imposta dati di supporto al dataset principale dell'iter dopo averli salvati
  statusT265Filtered:=selT265.Filtered;
  statusT265Active:=selT265.Active;
  statusT275Filtered:=selT275.Filtered;
  statusT275Active:=selT275.Active;
  Responsabile:=True;
  try
    selT265.Filtered:=True;
    selT265.Open;
    selT275.Filtered:=True;
    selT275.Open;

    // crea datamodule iter giustificativi
    W010DM:=TW010FRichiestaAssenzeDM.Create(nil);
    // impostazioni datamodule generico per gli iter
    C018DM:=TC018FIterAutDM.Create(nil);
    C018DM.Responsabile:=Responsabile;
    W010DM.C018DM:=C018DM;
    C018DM.Iter:=ITER_GIUSTIF;  //C018DM.MsgNotifica disponibile
    C018DM.TipoRichiesteSel:=[trDaAutorizzare];
    C018DM.NotificaAttivita:=True;
    C018DM.PreparaDataSetIter(W010DM.selT050,tiAutorizzazione);

    // estrae le richieste da autorizzare
    W010DM.selT050.OnCalcFields:=nil;
    W010DM.selT050.Close;
    W010DM.selT050.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W010DM.selT050.SetVariable('FILTRO_ANAG',FiltroRicerca);
    W010DM.selT050.SetVariable('FILTRO_PERIODO','');
    W010DM.selT050.SetVariable('FILTRO_VISUALIZZAZIONE',C018DM.FiltroRichieste);
    if not TransV430toT430(W010DM.selT050) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
    W010DM.selT050.Open;

    Result.Numero:=W010DM.selT050.RecordCount;
    Result.Messaggio:=C018DM.MsgNotifica;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W010DM);
    // ripristina dati condivisi
    selT265.Filtered:=statusT265Filtered;
    selT265.Active:=statusT265Active;
    selT275.Filtered:=statusT275Filtered;
    selT275.Active:=statusT275Active;
  end;
end;

function TW001FIrisWebDtM.GetNumRichDaAutorizzareW018: TConteggioNotifica;
var
  C018DM: TC018FIterAutDM;
  W018DM: TW018FRichiestaTimbratureDM;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  //tag 419 - autorizzazione timbrature
  try
    // imposta dati di supporto al dataset principale dell'iter
    Responsabile:=True;

    // crea datamodule iter timbrature
    W018DM:=TW018FRichiestaTimbratureDM.Create(nil);

    // impostazioni datamodule generico per gli iter
    C018DM:=TC018FIterAutDM.Create(nil);
    C018DM.Responsabile:=Responsabile;
    C018DM.Iter:=ITER_TIMBR;   //C018DM.MsgNotifica disponibile
    C018DM.TipoRichiesteSel:=[trDaAutorizzare];
    C018DM.NotificaAttivita:=True;
    C018DM.PreparaDataSetIter(W018DM.selT105,tiAutorizzazione);

    // estrae le richieste da autorizzare
    W018DM.C018:=C018DM;
    W018DM.selT105.OnCalcFields:=nil;
    W018DM.selT105.OnFilterRecord:=nil;
    W018DM.selT105.Close;
    W018DM.selT105.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W018DM.selT105.SetVariable('FILTRO_ANAG',FiltroRicerca);
    W018DM.selT105.SetVariable('FILTRO_PERIODO','');
    W018DM.selT105.SetVariable('FILTRO_VISUALIZZAZIONE',C018DM.FiltroRichieste);
    if not TransV430toT430(W018DM.selT105) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
    W018DM.selT105.Open;

    Result.Numero:=W018DM.selT105.RecordCount;
    Result.Messaggio:=C018DM.MsgNotifica;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W018DM);
  end;
end;

function TW001FIrisWebDtM.GetNumRichDaAutorizzareW024: TConteggioNotifica;
var
  C018DM: TC018FIterAutDM;
  W024DM: TW024FRichiestaStraordinariDM;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  // tag 427 - autorizzazione straordinari
  try
    // imposta dati di supporto al dataset principale dell'iter
    Responsabile:=True;

    // crea datamodule iter straordinari mensili
    W024DM:=TW024FRichiestaStraordinariDM.Create(nil);
    W024DM.evtAperturaDataSetIterTemp:=nil;
    W024DM.AggiornaTotali:=False;
    W024DM.selT065.OnCalcFields:=nil;

    // impostazioni datamodule generico per gli iter
    C018DM:=TC018FIterAutDM.Create(nil);
    C018DM.Responsabile:=Responsabile;
    C018DM.Iter:=ITER_STRMESE;  //C018DM.MsgNotifica disponibile
    W024DM.C018:=C018DM;
    C018DM.NotificaAttivita:=True;
    C018DM.PreparaDataSetIter(W024DM.selT065,tiAutorizzazione);

    // estrae le richieste da autorizzare
    W024DM.AperturaDataSetIter(FiltroRicerca);

    if not TransV430toT430(W024DM.selT065) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
    W024DM.selT065.Open;

    Result.Numero:=W024DM.selT065.RecordCount;
    Result.Messaggio:=C018DM.MsgNotifica;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W024DM);
  end;
end;

function TW001FIrisWebDtM.GetNumRichDaAutorizzareW025: TConteggioNotifica;
var
  C018DM: TC018FIterAutDM;
  W025DM: TW025FCambioOrarioDM;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  // tag 431 - autorizzazione cambio orario
  try
    // imposta dati di supporto al dataset principale dell'iter
    Responsabile:=True;

    // crea datamodule iter cambio orario
    W025DM:=TW025FCambioOrarioDM.Create(nil);

    // impostazioni datamodule generico per gli iter
    C018DM:=TC018FIterAutDM.Create(nil);
    C018DM.Responsabile:=Responsabile;
    C018DM.Iter:=ITER_ORARIGG;    //C018DM.MsgNotifica disponibile
    C018DM.TipoRichiesteSel:=[trDaAutorizzare];
    C018DM.NotificaAttivita:=True;
    C018DM.PreparaDataSetIter(W025DM.selT085,tiAutorizzazione);

    // estrae le richieste da autorizzare
    W025DM.selT085.OnCalcFields:=nil;
    W025DM.selT085.Close;
    W025DM.selT085.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W025DM.selT085.SetVariable('FILTRO_ANAG',FiltroRicerca);
    W025DM.selT085.SetVariable('FILTRO_PERIODO','');
    W025DM.selT085.SetVariable('FILTRO_VISUALIZZAZIONE',C018DM.FiltroRichieste);
    if not TransV430toT430(W025DM.selT085) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
    W025DM.selT085.Open;

    Result.Numero:=W025DM.selT085.RecordCount;
    Result.Messaggio:=C018DM.MsgNotifica;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W025DM);
  end;
end;

function TW001FIrisWebDtM.GetNumRichDaAutorizzareW026: TConteggioNotifica;
// tag 433 - autorizzazione eccedenze giornaliere
var
  C018DM: TC018FIterAutDM;
  W026DM: TW026FRichiestaStrGGDM;
begin
  Result.Numero:=-1;
  Result.Messaggio:='';
  try
    try
      // imposta dati di supporto al dataset principale dell'iter
      Responsabile:=True;

      // crea datamodule iter cambio orario
      W026DM:=TW026FRichiestaStrGGDM.Create(nil);

      // impostazioni datamodule generico per gli iter
      C018DM:=TC018FIterAutDM.Create(nil);
      C018DM.Responsabile:=Responsabile;
      C018DM.Iter:=ITER_STRGIORNO;  //C018DM.MsgNotifica disponibile
      C018DM.TipoRichiesteSel:=[trDaAutorizzare];
      C018DM.NotificaAttivita:=True;
      C018DM.PreparaDataSetIter(W026DM.selT325Vis,tiAutorizzazione);

      W026DM.selT325Vis.Close;
      W026DM.selT325Vis.SetVariable('DATALAVORO',Parametri.DataLavoro);
      if W026DM.selT325Vis.VariableIndex('FILTRO_ANAG') >= 0 then
        W026DM.selT325Vis.SetVariable('FILTRO_ANAG',FiltroRicerca);
      {
      if W026DM.selT325Vis.VariableIndex('FILTRO_PROGRESSIVI') >= 0 then
      begin
        LFiltroAnag:='T030A.PROGRESSIVO in (' + ElencoProgressivi + ')';
        W026DM.selT325Vis.SetVariable('FILTRO_PROGRESSIVI',LFiltroAnag);
      end;
      }
      W026DM.selT325Vis.SetVariable('FILTRO_PERIODO','');
      W026DM.selT325Vis.SetVariable('FILTRO_VISUALIZZAZIONE',C018DM.FiltroRichieste);
      W026DM.selT325Vis.SetVariable('FILTRO_STRUTTURA','');
      W026DM.selT325Vis.SetVariable('FILTRO_ALLEGATI','');
      if not TransV430toT430(W026DM.selT325Vis) then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
      W026DM.selT325Vis.Open;

      Result.Numero:=W026DM.selT325Vis.RecordCount;
      Result.Messaggio:=C018DM.MsgNotifica;
    except
    end;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W026DM);
  end;
end;

function TW001FIrisWebDtM.GetNumRichDaAutorizzareW032: TConteggioNotifica;
var
  C018DM: TC018FIterAutDM;
  W032DM: TW032FRichiestaMissioniDM;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  // tag 441 - autorizzazione missioni
  try
    // imposta dati di supporto al dataset principale dell'iter
    Responsabile:=True;

    // crea datamodule iter missioni
    W032DM:=TW032FRichiestaMissioniDM.Create(nil);

    // impostazioni datamodule generico per gli iter
    C018DM:=TC018FIterAutDM.Create(nil);
    C018DM.Responsabile:=Responsabile;
    C018DM.Iter:=ITER_MISSIONI;    //C018DM.MsgNotifica disponibile
    C018DM.TipoRichiesteSel:=[trDaAutorizzare];
    C018DM.NotificaAttivita:=True;
    C018DM.PreparaDataSetIter(W032DM.selM140,tiAutorizzazione);

    // estrae le richieste da autorizzare
    W032DM.C018:=C018DM;
    W032DM.selM140.OnCalcFields:=nil;
    W032DM.selM140.Filtered:=False;
    W032DM.selM140.Close;
    W032DM.selM140.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W032DM.selM140.SetVariable('FILTRO_ANAG',FiltroRicerca);
    W032DM.selM140.SetVariable('FILTRO_PERIODO','');
    W032DM.selM140.SetVariable('FILTRO_VISUALIZZAZIONE',C018DM.FiltroRichieste);
    if not TransV430toT430(W032DM.selM140) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
    W032DM.selM140.Open;
    // è necessario filtrare il dataset per avere il numero corretto delle richieste
    W032DM.selM140.Filtered:=True;

    Result.Numero:=W032DM.selM140.RecordCount;
    Result.Messaggio:=C018DM.MsgNotifica;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W032DM);
  end;
end;

function TW001FIrisWebDtM.GetNumCertDaAutorizzareW048: TConteggioNotifica;
var
  C018DM: TC018FIterAutDM;
  W048DM: TW048FCertificazioniDM;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  // tag 456 - autorizzazione certificazioni
  try
    // imposta dati di supporto al dataset principale dell'iter
    Responsabile:=True;

    // crea datamodule certificazioni
    W048DM:=TW048FCertificazioniDM.Create(nil);

    // impostazioni datamodule generico per gli iter
    C018DM:=TC018FIterAutDM.Create(nil);
    C018DM.Responsabile:=Responsabile;
    C018DM.Iter:=ITER_CERTIFICAZIONI;    //C018DM.MsgNotifica disponibile
    C018DM.TipoRichiesteSel:=[trDaAutorizzare];
    C018DM.NotificaAttivita:=True;
    C018DM.PreparaDataSetIter(W048DM.selSG230,tiAutorizzazione);

    // estrae le richieste da autorizzare
    W048DM.C018:=C018DM;
    W048DM.selSG230.OnCalcFields:=nil;
    W048DM.selSG230.Filtered:=False;
    W048DM.selSG230.Close;
    W048DM.selSG230.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W048DM.selSG230.SetVariable('FILTRO_ANAG',FiltroRicerca);
    W048DM.selSG230.SetVariable('FILTRO_PERIODO','');
    W048DM.selSG230.SetVariable('FILTRO_VISUALIZZAZIONE',C018DM.FiltroRichieste);
    if not TransV430toT430(W048DM.selSG230) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
    W048DM.selSG230.Open;

    Result.Numero:=W048DM.selSG230.RecordCount;
    Result.Messaggio:=C018DM.MsgNotifica;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W048DM);
  end;
end;

function TW001FIrisWebDtM.GetNumRichDaAutorizzareW050: TConteggioNotifica;
var
  C018DM: TC018FIterAutDM;
  W050DM: TW050FRichiestaDocumentaleDM;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  // tag 456 - autorizzazione certificazioni
  try
    // imposta dati di supporto al dataset principale dell'iter
    Responsabile:=True;

    // crea datamodule certificazioni
    W050DM:=TW050FRichiestaDocumentaleDM.Create(nil);

    // impostazioni datamodule generico per gli iter
    C018DM:=TC018FIterAutDM.Create(nil);
    C018DM.Responsabile:=Responsabile;
    C018DM.Iter:=ITER_DOCUMENTALE;
    C018DM.TipoRichiesteSel:=[trDaAutorizzare];
    C018DM.NotificaAttivita:=True;
    C018DM.PreparaDataSetIter(W050DM.selT960,tiAutorizzazione);

    // estrae le richieste da autorizzare
    //W050DM.C018:=C018DM;
    W050DM.selT960.OnCalcFields:=nil;
    W050DM.selT960.Filtered:=False;
    W050DM.selT960.Close;
    W050DM.selT960.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W050DM.selT960.SetVariable('FILTRO_ANAG',FiltroRicerca);
    W050DM.selT960.SetVariable('FILTRO_PERIODO','');
    W050DM.selT960.SetVariable('FILTRO_VISUALIZZAZIONE',C018DM.FiltroRichieste);
    if not TransV430toT430(W050DM.selT960) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
    W050DM.selT960.Open;

    Result.Numero:=W050DM.selT960.RecordCount;
    Result.Messaggio:=C018DM.MsgNotifica;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W050DM);
  end;
end;

function TW001FIrisWebDtM.GetNumRichDaAutorizzareW052: TConteggioNotifica;
var
  C018DM: TC018FIterAutDM;
  W052DM: TW052FRichiestaDispTurniDM;
begin
  Result.Numero:=0;
  Result.Messaggio:='';
  // tag 463 - autorizzazione disponibilità turni
  try
    // imposta dati di supporto al dataset principale dell'iter
    Responsabile:=True;

    // crea datamodule iter cambio orario
    W052DM:=TW052FRichiestaDispTurniDM.Create(nil);

    // impostazioni datamodule generico per gli iter
    C018DM:=TC018FIterAutDM.Create(nil);
    C018DM.Responsabile:=Responsabile;
    C018DM.Iter:=ITER_DISPTURNI;    //C018DM.MsgNotifica disponibile
    C018DM.TipoRichiesteSel:=[trDaAutorizzare];
    C018DM.NotificaAttivita:=True;
    C018DM.PreparaDataSetIter(W052DM.selT600,tiAutorizzazione);

    // estrae le richieste da autorizzare
    W052DM.selT600.OnCalcFields:=nil;
    W052DM.selT600.Close;
    W052DM.selT600.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W052DM.selT600.SetVariable('FILTRO_ANAG',FiltroRicerca);
    W052DM.selT600.SetVariable('FILTRO_PERIODO','');
    W052DM.selT600.SetVariable('FILTRO_VISUALIZZAZIONE',C018DM.FiltroRichieste);
    if not TransV430toT430(W052DM.selT600) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE));
    W052DM.selT600.Open;

    Result.Numero:=W052DM.selT600.RecordCount;
    Result.Messaggio:=C018DM.MsgNotifica;
  finally
    // libera risorse
    FreeAndNil(C018DM);
    FreeAndNil(W052DM);
  end;
end;

function TW001FIrisWebDtM.GetNotificheAttivitaByTag(const PTag: Integer): TNotificaAttivita;
// estrae il numero di notifiche attività per il tag della funzione indicata
// corredato da un messaggio che spiega il tipo di notifiche
// in caso di errore restituisce un numero negativo e un messaggio informativo
  function GetResult(const PContatore: Integer; const PMessaggio: String): TNotificaAttivita;
  begin
    Result.Contatore:=PContatore;
    Result.Messaggio:=PMessaggio;
  end;
begin
  // PRE: abilitazione alla funzione con tag = PTag verificata (abilitazione <> 'N')

  // gestione legata ad un parametro aziendale
  if Parametri.CampiRiferimento.C90_NotificatoreAttivita <> 'S' then
  begin
    Result:=GetResult(0,Format('Parametri.CampiRiferimento.C90_NotificatoreAttivita = %s',[Parametri.CampiRiferimento.C90_NotificatoreAttivita]));
    Exit;
  end;

  Result:=NotificheAttivita.Notifica[PTag];

  if Result.Tag = -1 then
    Result:=NotificheAttivita.AddNotifica(PTag);

  if Result.Refresh then
  begin
    GetNotificaAttivita(Result);
    NotificheAttivita.UpdateNotifica(Result);
  end;
end;

procedure TW001FIrisWebDtM.GetNotificaAttivita(var NA: TNotificaAttivita);
var
  TempStr: String;
  OldResponsabile: Boolean;
  ConteggioNotifica: TConteggioNotifica;
  function GetMsgNotifica(Numero: Integer; Messaggio: String): String;
  begin
    Result:='';
    with selMsgNotifica do
    begin
      Close;
      SQL.Clear;
      DeleteVariables;
      SQL.Add('SELECT ' + Messaggio + ' MESSAGGIO FROM DUAL');
      if ContainsText(Messaggio, ':NUMERO') then
      begin
        DeclareVariable('NUMERO', otInteger);
        SetVariable('NUMERO', Numero);
      end;
      Open;
      Result:=FieldByName('MESSAGGIO').AsString;
      Close;
    end;
  end;
  procedure PutNotifica(const PConteggioNotifica: TConteggioNotifica; const PMessaggio: String);
  var FunzioniDisp: TFunzioniDisponibili;
  begin
    NA.Contatore:=PConteggioNotifica.Numero;
    NA.Messaggio:=StringReplace(Trim(PMessaggio),'"','',[rfReplaceAll]);
    NA.MsgNotifica:='';
    NA.TitoloNotifica:='';
    //valorizzo TitoloNotifica e MsgNotifica usati per la notifica all'ingresso di IrisWeb
    if (NA.Contatore > 0) and (PConteggioNotifica.Messaggio <> '') then
    begin
      NA.MsgNotifica:=GetMsgNotifica(NA.Contatore, PConteggioNotifica.Messaggio);//Funzione(PConteggioNotifica.Messaggio);

      FunzioniDisp:=L021ElementoByTag(NA.Tag);  //gestire eventuale exception su tag non trovato?
      NA.TitoloNotifica:='(' + FunzioniDisp.S + ') ' + FunzioniDisp.N;
    end;
  end;
begin
  ConteggioNotifica.Numero:=0;
  ConteggioNotifica.Messaggio:='';
  PutNotifica(ConteggioNotifica,'');
  // salva impostazioni da ripristinare successivamente
  OldResponsabile:=Responsabile;

  NA.Refresh:=False;
  try
    try
      // conteggio notifiche in base al tag indicato
      if NA.Tag = 406 then
      begin
        // 406 - richiesta assenze
        // risultato vuoto
      end
      else if NA.Tag = 407 then
      begin
        // 407 - autorizzazione assenze
        PutNotifica(GetNumRichDaAutorizzareW010,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ));
      end
      else if NA.Tag = 417 then
      begin
        // 417 - stampa cedolino
        PutNotifica(GetNumCedoliniDaLeggere,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_CEDOLINI));
      end
      else if NA.Tag = 418 then
      begin
        // 418 - richiesta timbrature
        // risultato vuoto
      end
      else if NA.Tag = 419 then
      begin
        // 419 - autorizzazione timbrature
        PutNotifica(GetNumRichDaAutorizzareW018,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ));
      end
      else if NA.Tag = 422 then
      begin
        // 422 - stampa modello CU
        PutNotifica(GetNumCUDaLeggere,A000MSG_W001_MSG_NOTIFICHE_CU);
      end
      else if NA.Tag = 426 then
      begin
        // 426 - richiesta straordinari
        // risultato vuoto
      end
      else if NA.Tag = 427 then
      begin
        // 427 - autorizzazione straordinari
        PutNotifica(GetNumRichDaAutorizzareW024,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ));
      end
      else if NA.Tag = 428 then
      begin
        // 428 - notifiche di sciopero
        PutNotifica(GetNumRichiesteScioperoPendenti(TempStr),A000MSG_W001_MSG_NOTIFICHE_SCIOPERO);
      end
      else if NA.Tag = 429 then
      begin
        // 429 - autorizzazione notifiche sciopero
        // risultato vuoto
      end
      else if NA.Tag = 430 then
      begin
        // 430 - richiesta cambio orario
        // risultato vuoto
      end
      else if NA.Tag = 431 then
      begin
        // 431 - autorizzazione cambio orario
        PutNotifica(GetNumRichDaAutorizzareW025,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ));
      end
      else if NA.Tag = 432 then
      begin
        // 432 - richiesta eccedenze giornaliere
        // risultato vuoto
      end
      else if NA.Tag = 433 then
      begin
        // 433 - autorizzazione eccedenze giornaliere
        PutNotifica(GetNumRichDaAutorizzareW026,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ));
      end
      else if NA.Tag = 440 then
      begin
        // richiesta missioni
        // risultato vuoto
      end
      else if NA.Tag = 441 then
      begin
        // 441 - autorizzazione missioni
        PutNotifica(GetNumRichDaAutorizzareW032,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ));
      end
      else if NA.Tag = 442 then
      begin
        // 442 - validazione cartellini
        PutNotifica(GetNumRichDaAutorizzareW009,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ));
      end
      else if NA.Tag = 445 then
      begin
        // 445 - messaggistica
        ConteggioNotifica.Numero:=GetNumMsgDaLeggere.Totali;
        PutNotifica(ConteggioNotifica,A000MSG_W001_MSG_NOTIFICHE_MESSAGGI);
      end
      else if NA.Tag = 448 then
      begin
        // 448 - gestione documentale
        PutNotifica(GetNumDocumentiDaLeggere(TempStr),A000MSG_W001_MSG_NOTIFICHE_DOCUMENTI);
      end
      else if NA.Tag = 456 then
      begin
        // 456 - autorizzazione certificazioni
        PutNotifica(GetNumCertDaAutorizzareW048,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ));
      end
      else if NA.Tag = 458 then
      begin
        // 458 - autorizzazione documentale
        PutNotifica(GetNumRichDaAutorizzareW050,A000TraduzioneStringhe(A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ));
      end
      else
      begin
        // nei casi non gestiti restituisce 0
        // risultato vuoto
      end;
    except
      on E: Exception do
      begin
        // imposta un result negativo in caso di errore
        ConteggioNotifica.Numero:=-1;
        PutNotifica(ConteggioNotifica,E.Message);
        // log di errore
        ////(Self.Parent as TWR010FBase).Log('ERRORE',Format('Errore nell''estrazione del numero di notifiche attività (tag funzione: %d)',[NA.Tag]),E);
      end;
    end;
  finally
    // ripristina dati e libera eventuali risorse
    Responsabile:=OldResponsabile;
  end;
end;

function TW001FIrisWebDtM.TransV430toT430(ODS:TOracleDataset):Boolean;
var SQL:String;
    i:Integer;

  function EsisteCampoV430Incompatibile(S:String):Boolean;
  // controllo che non esistano campi incompatibili: P430Campo, T430D_Campo
  begin
    Result:=False;
    S:=StringReplace(S,'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)','',[rfReplaceAll,rfIgnoreCase]);
    with cdsI010 do
    try
      Filtered:=False;
      Filter:='((NOME_CAMPO = ''T430D_*'') or (NOME_CAMPO = ''P430*''))';
      Filtered:=True;
      First;
      while not Eof do
      begin
        if Pos(UpperCase(FieldByName('NOME_CAMPO').AsString),UpperCase(S)) > 0 then
        begin
          Result:=True;
          Break;
        end;
        Next;
      end;
    finally
      Filter:='';
      Filtered:=False;
    end;
  end;

  function V430toT430(S:String):String;
  begin
    //Per gestire il caso in cui la V430 contenga anche la join con P430
    S:=StringReplace(S,'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)','',[rfReplaceAll,rfIgnoreCase]);

    Result:=S;
    if Pos('T430',UpperCase(S)) = 0 then
      exit;

    S:=StringReplace(S,'V430_STORICO V430','T430_STORICO T430',[rfReplaceAll,rfIgnoreCase]);
    S:=StringReplace(S,'V430.T430','T430.',[rfReplaceAll,rfIgnoreCase]);
    //Modifica puntuale dei riferimenti ai campi T430campo in T430.campo
    with cdsI010 do
    try
      Filtered:=False;
      Filter:='(NOME_CAMPO = ''T430*'')';
      Filtered:=True;
      First;
      while not Eof do
      begin
        S:=StringReplace(S,FieldByName('NOME_CAMPO').AsString,StringReplace(FieldByName('NOME_CAMPO').AsString,'T430','T430.',[]),[rfReplaceAll,rfIgnoreCase]);
        Next;
      end;
    finally
      Filter:='';
      Filtered:=False;
    end;
    Result:=S;
  end;

begin
  Result:=False;

  //Controllo che non esistano campi incompatibili: P430Campo, T430D_Campo
  if EsisteCampoV430Incompatibile(ODS.SQL.Text) then
    exit;
  for i:=0 to ODS.VariableCount - 1 do
    if ODS.VariableType(i) = otSubst then
      if EsisteCampoV430Incompatibile(VarToStr(ODS.GetVariable(i))) then
        exit;

  Result:=True;
  ODS.SQL.Text:=V430toT430(ODS.SQL.Text);
  for i:=0 to ODS.VariableCount - 1 do
    if ODS.VariableType(i) = otSubst then
    begin
      SQL:=VarToStr(ODS.GetVariable(i));
      ODS.SetVariable(i,V430toT430(SQL));
    end;
end;

procedure TW001FIrisWebDtM.SetDatoLibero(const PDato: String; var RDatoLibero: TDatoFiltro; pIgnoraInibizioni: Boolean = False; pData: TDateTime = 0);
var
  LTabella: String;
  LStorico: String;
  LCodice: String;
  LDato: TDato;
begin
  if pData = 0 then
    pData:=Date;

  // pulisce i dati associati
  RDatoLibero.Clear;

  if PDato = '' then
    Exit;

  RDatoLibero.NomeDato:=PDato;
  RDatoLibero.NomeCampo:=Format('T430%s',[PDato]);

  // estrae info in caso di dato tabellare e/o storico
  A000GetTabella(PDato,LTabella,LCodice,LStorico);
  if (LTabella <> '') and (LTabella <> 'T430_STORICO') then
    RDatoLibero.NomeCampoDesc:=Format('T430D_%s',[PDato]);

  // predispone la lista di valori anagrafici disponibili
  if RDatoLibero.ListaValoriAnag = nil then
    RDatoLibero.ListaValoriAnag:=TStringList.Create
  else
    RDatoLibero.ListaValoriAnag.Clear;

  // imposta il dataset per selezionare i valori del dato libero
  // realmente in uso dai dipendenti presenti nel filtro anagrafe
  selDistAnagrafe.Close;
  if Parametri.CampiRiferimento.C26_HintT030V430 <> '' then
    selDistAnagrafe.SQL.Text:=StringReplace(selDistAnagrafe.SQL.Text,'SELECT DISTINCT',Format('SELECT %s DISTINCT',[Parametri.CampiRiferimento.C26_HintT030V430]),[rfIgnoreCase]);
  selDistAnagrafe.SetVariable('DATALAVORO',pData);
  selDistAnagrafe.SetVariable('CAMPO',RDatoLibero.NomeCampo + ' CODICE' + IfThen(RDatoLibero.NomeCampoDesc <> '',',' + RDatoLibero.NomeCampoDesc + ' DESCRIZIONE'));

  if pIgnoraInibizioni then
    selDistAnagrafe.SetVariable('FILTRO','')
  else if Parametri.Inibizioni.Text <> '' then
    selDistAnagrafe.SetVariable('FILTRO',' AND ' + Parametri.Inibizioni.Text);

  selDistAnagrafe.Open;

  // ciclo di popolamento della lista di valori
  selDistAnagrafe.First;
  while not selDistAnagrafe.Eof do
  begin
    if not selDistAnagrafe.FieldByName('CODICE').IsNull then
    begin
      LDato.Codice:=selDistAnagrafe.FieldByName('CODICE').AsString;
      if RDatoLibero.NomeCampoDesc = '' then
        LDato.Descrizione:=''
      else
        LDato.Descrizione:=selDistAnagrafe.FieldByName('DESCRIZIONE').AsString;
      RDatoLibero.ListaValoriAnag.Add(LDato.ToComboItem);
    end;
    selDistAnagrafe.Next;
  end;
  selDistAnagrafe.Close;
end;

{ TDatoFiltro }

procedure TDatoFiltro.Clear;
begin
  NomeDato:='';
  NomeCampo:='';
  NomeCampoDesc:='';

  // prepara la lista di valori anagrafici
  if ListaValoriAnag = nil then
    ListaValoriAnag:=TStringList.Create
  else
    ListaValoriAnag.Clear;

  // la lista di valori aggiuntivi deve ignorare i duplicati
  if ListaValoriAgg = nil then
  begin
    ListaValoriAgg:=TStringList.Create;
    ListaValoriAgg.Sorted:=True;
    ListaValoriAgg.Duplicates:=TDuplicates.dupIgnore;
  end
  else
    ListaValoriAgg.Clear;
end;

function TDatoFiltro.Esiste: Boolean;
begin
  Result:=NomeDato <> '';
end;

function TDatoFiltro.GetDatiSQL: String;
begin
  Result:='';
  if NomeDato = '' then
    Exit;

  // concatena i nomi dei dati (che rappresentano codice e valore)
  Result:=Format('%s,%s',[NomeCampo,NomeCampoDesc]);

  // termina con una virgola
  if not Result.EndsWith(',') then
    Result:=Result + ',';
end;

function TDatoFiltro.GetListaValoriCompleta: TStringList;
// restituisce la lista completa ed ordinata dei valori selezionabili
// composta dalla "distinct" delle seguenti liste:
// - lista di valori associati alle anagrafiche disponibili
// - lista dei valori pianificati nel giorno
begin
  Result:=TStringList.Create;
  Result.Sorted:=True;
  Result.Duplicates:=TDuplicates.dupIgnore;
  Result.AddStrings(ListaValoriAnag);
  Result.AddStrings(ListaValoriAgg);
end;

{ TNotificheAttivita }

constructor TNotificheAttivita.Create;
begin
  inherited;
  SetLength(Items,0);
end;

destructor TNotificheAttivita.Destroy;
begin
  SetLength(Items,0);
  inherited;
end;

function TNotificheAttivita.AddNotifica(Tag: Integer): TNotificaAttivita;
var
  h:Integer;
begin
  Result.Tag:=Tag;
  Result.Refresh:=False;
  Result.Contatore:=0;
  Result.Messaggio:='';
  Result.TitoloNotifica:='';
  Result.MsgNotifica:='';
  if not R180In(Tag,[407,417,419,422,427,428,431,433,441,442,445,448,456,458]) then
    exit;

  h:=Length(Items);
  SetLength(Items,h + 1);
  Result.Refresh:=True;
  Items[h]:=Result;
end;

function TNotificheAttivita.GetNotifica(Tag: Integer): TNotificaAttivita;
var
  i:Integer;
begin
  Result.Tag:=-1;
  for i:=0 to High(Items) do
    if Items[i].Tag = Tag then
    begin
      Result:=Items[i];
      Break;
    end;
end;

procedure TNotificheAttivita.UpdateNotifica(Value: TNotificaAttivita);
var
  i:Integer;
begin
  for i:=0 to High(Items) do
    if Items[i].Tag = Value.Tag then
    begin
      Items[i]:=Value;
      Break;
    end;
end;

procedure TNotificheAttivita.AttivaRefresh(Tag: Integer);
var
  i:Integer;
begin
  for i:=0 to High(Items) do
    if Items[i].Tag = Tag then
    begin
      Items[i].Refresh:=True;
      Break;
    end;
end;

end.

