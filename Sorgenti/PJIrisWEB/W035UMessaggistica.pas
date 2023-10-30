unit W035UMessaggistica;

interface

uses
  W035UMessaggisticaDM, W000UMessaggi, A000UMessaggi, System.IOUtils,
  WC013UCheckListFM, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPaginaWeb,
  medpIWDBGrid, medpIWC700NavigatorBar, IWApplication,
  Oracle, OracleData, Windows, StrUtils, Math, SysUtils, Classes, Controls,
  Forms, IWVCLComponent, IWBaseLayoutComponent, IWHTMLTag,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWCompText, meIWText, IWCompEdit,
  meIWEdit, meIWImageFile, IWCompMemo, meIWMemo,
  IWCompGrids, IWDBGrids, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, IWCompButton, meIWButton,
  DB, DBClient, meIWCheckBox, meIWGrid, IWCompExtCtrls, meIWRadioGroup,
  IWCompListbox, meIWComboBox, Variants, IWCompCheckbox, medpIWTabControl,
  IWCompJQueryWidget, Menus, IWDBStdCtrls, meIWDBMemo, medpIWImageButton,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  C200UWebServicesTypes, W001UIrisWebDtM, IWForm, IWCallBack,
  IWCompFileUploader, meIWFileUploader;

type
  TModalitaGestione = (
    Lettura,
    Invio
  );

  TDataSetAfterScroll = procedure(DataSet: TDataSet) of object;

  TDestinatario = record
    Progressivo: Integer;
    Matricola: String;
    Cognome: String;
    Nome: String;
    DataLettura: TDateTime;
    DataRicezione: TDateTime;
  end;

  TDestArr = array of TDestinatario;

  TDestOperatore = record
    Utente: String;           // operatore win
    DataLettura: TDateTime;   // data lettura messaggio (usato dal destinatario)
    DataRicezione: TDateTime; // data ricezione messaggio
  end;

  TDestOperatoreArr = array of TDestOperatore;

  TAllegato = record
    Flag: String;
    NomeFile: String;
    ExtFile: String;
    DimFile: Int64;
    DimFileStr: String;
  end;

  TAllegatiArr = array of TAllegato;

  TStatoLettura = (
    NonLetto,
    LettoParzialmente,
    Letto
  );

  TStatoRicezione = (
    NonRicevuto,
    RicevutoParzialmente,
    Ricevuto
  );

  TDatiModalita = record
    // bookmark sul record selezionato
    selTabella_Bookmark: TBookmark;
    // checkbox selezione stato
    chkStatoSospeso_Checked: Boolean;
    chkStatoInviato_Checked: Boolean;
    chkStatoCancellato_Checked: Boolean;
    chkStatoTutti_Checked: Boolean;
    // periodo invio dal - al
    edtPeriodoDal_Text: String;
    edtPeriodoAl_Text: String;
    // in lettura filtra sui messaggi da leggere
    rgpFiltroDaLeggere_ItemIndex: Integer;
    // filtri selezione anagrafica e mittente
    cmbFiltroSelezione_ItemIndex: Integer;
    cmbFiltroMittente_ItemIndex: Integer;
    // ricerca per oggetto e/o testo
    edtRicerca_Text: String;
  end;

  TDatiModalitaArr = array[0..1] of TDatiModalita;

  TMessaggio = class(TObject)
  private
    FErrMsg: String;
    FID: Integer;
    FOggetto: String;
    FTesto: String;
    FLetturaObbligatoria: String;
    FStato: String;
    FEditAsNew: Boolean;
    FModificato: Boolean;
    FDataInvio: TDateTime;
    FIDOriginale: Integer;
    // destinatari
    FSelezioneAnagrafica: String;
    FDestLetti: Integer;
    FDestRicevuti: Integer;
    FDestTot: Integer;
    FDestArr: TDestArr;
    FDestOperatoreArr: TDestOperatoreArr;
    FDestModificati: Boolean;
    FStatoLettura: TStatoLettura;
    FStatoRicezione: TStatoRicezione;
    // allegati
    FAllegatiArr: TAllegatiArr;
    FAllegatiCopyArr: TAllegatiArr;
    FAllegModificati: Boolean;
    function  GetStatoLettura: TStatoLettura;
    function  GetStatoRicezione: TStatoRicezione;
    function  GetTotAllegati: Integer;
    function  IsMaxAllegatiRaggiunto: Boolean;
    function  GetDimTotAllegati: Integer;
    procedure SetOggetto(const Value: String);
    procedure SetTesto(const Value: String);
    procedure Clear;
    procedure SetLetturaObbligatoria(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClearDestinatari;
    function  AddDestinatario(const PProg: Integer; const PMatricola, PCognome, PNome: String;
      const PDataLettura, PDataRicezione: TDateTime): Integer;
    procedure ClearDestinatariOperatori;
    function  AddDestinatarioOperatore(const PUtente: String; const PDataLettura, PDataRicezione: TDateTime): Integer;
    procedure ClearAllegati;
    function  EsisteAllegato(const PNomeFile: String): Boolean;
    function  AddAllegato(const PFlag, PNomeFile: String; const PDimFile: Int64 = 0): Integer;
    property ID: Integer read FID write FID;
    property Stato: String read FStato write FStato;
    property EditAsNew: Boolean read FEditAsNew write FEditAsNew;
    property DataInvio: TDateTime read FDataInvio write FDataInvio;
    property Oggetto: String read FOggetto write SetOggetto;
    property Testo: String read FTesto write SetTesto;
    property LetturaObbligatoria: String read FLetturaObbligatoria write SetLetturaObbligatoria;
    property Modificato: Boolean read FModificato write FModificato;
    property IDOriginale: Integer read FIDOriginale write FIDOriginale;
    property SelezioneAnagrafica: String read FSelezioneAnagrafica write FSelezioneAnagrafica;
    property DestArr: TDestArr read FDestArr write FDestArr;
    property DestOperatoreArr: TDestOperatoreArr read FDestOperatoreArr write FDestOperatoreArr;
    property DestLetti: Integer read FDestLetti write FDestLetti;
    property DestRicevuti: Integer read FDestRicevuti write FDestRicevuti;
    property DestTot: Integer read FDestTot write FDestTot;
    property DestModificati: Boolean read FDestModificati write FDestModificati;
    property StatoLettura: TStatoLettura read GetStatoLettura write FStatoLettura;
    property StatoRicezione: TStatoRicezione read GetStatoRicezione write FStatoRicezione;
    property AllegatiArr: TAllegatiArr read FAllegatiArr write FAllegatiArr;
    property AllegatiCopyArr: TAllegatiArr read FAllegatiCopyArr write FAllegatiCopyArr;
    property AllegModificati: Boolean read FAllegModificati write FAllegModificati;
    property TotAllegati: Integer read GetTotAllegati;
    property MaxAllegatiRaggiunto: Boolean read IsMaxAllegatiRaggiunto;
    property DimTotAllegati: Integer read GetDimTotAllegati;
    property ErrMsg: String read FErrMsg write FErrMsg;
  end;

  TW035FMessaggistica = class(TR010FPaginaWeb)
    tabMessaggi: TmedpIWTabControl;
    rgnDati: TmeIWRegion;
    tpDati: TIWTemplateProcessorHTML;
    lblDettaglio: TmeIWLabel;
    lblDestinatari: TmeIWLabel;
    lblOggetto: TmeIWLabel;
    lblTesto: TmeIWLabel;
    lblAllegati: TmeIWLabel;
    grdAllegati: TmeIWGrid;
    btnHdnUpload: TmeIWButton;
    edtOggetto: TmeIWEdit;
    edtDestinatari: TmeIWEdit;
    btnDestinatari: TmeIWButton;
    memTesto: TmeIWMemo;
    lblFiltro: TmeIWLabel;
    rgpFiltroDaLeggere: TmeIWRadioGroup;
    chkStatoSospeso: TmeIWCheckBox;
    chkStatoCancellato: TmeIWCheckBox;
    chkStatoTutti: TmeIWCheckBox;
    chkStatoInviato: TmeIWCheckBox;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    lblFiltroSelezione: TmeIWLabel;
    cmbFiltroSelezione: TmeIWComboBox;
    btnFiltra: TmeIWButton;
    lblFiltroMittente: TmeIWLabel;
    cmbFiltroMittente: TmeIWComboBox;
    edtRicerca: TmeIWEdit;
    grdMessaggi: TmedpIWDBGrid;
    lblPeriodoDal: TmeIWLabel;
    rgnDestinatari: TmeIWRegion;
    tpDestinatari: TIWTemplateProcessorHTML;
    grdDestinatari: TmedpIWDBGrid;
    rgpFiltroDest: TmeIWRadioGroup;
    jqDestinatari: TIWJQueryWidget;
    cdsDestinatari: TClientDataSet;
    cdsDestinatariPROGRESSIVO: TIntegerField;
    cdsDestinatariMATRICOLA: TStringField;
    cdsDestinatariCOGNOME: TStringField;
    cdsDestinatariNOME: TStringField;
    cdsDestinatariDATA_LETTURA: TDateTimeField;
    edtSelezione: TmeIWEdit;
    btnChiudiDest: TmeIWButton;
    lblFiltroDest: TmeIWLabel;
    lblNessunAllegato: TmeIWLabel;
    pmnTabella: TPopupMenu;
    mnuEsportaExcel: TMenuItem;
    jqDettaglio: TIWJQueryWidget;
    cdsDestinatariDATA_RICEZIONE: TDateTimeField;
    pmnDestinatari: TPopupMenu;
    mnuDestExcel: TMenuItem;
    cdsDestinatariUTENTE: TStringField;
    edtIDOriginale: TmeIWEdit;
    rgnElenco: TmeIWRegion;
    grdElenco: TmedpIWDBGrid;
    btnChiudiElenco: TmeIWButton;
    jqElenco: TIWJQueryWidget;
    tpElenco: TIWTemplateProcessorHTML;
    memElencoTesto: TmeIWDBMemo;
    btnRispondi: TmedpIWImageButton;
    btnStorico: TmedpIWImageButton;
    imgScegliDestOperatori: TmeIWImageFile;
    chkLetturaObbligatoria: TmeIWCheckBox;
    lblLimiteAllegatiRaggiunto: TmeIWLabel;
    meIWLabel1: TmeIWLabel;
    lblQuotaAllegati: TmeIWLabel;
    imgAllegatiInfo: TmeIWImageFile;
    jqQuotaAllegati: TIWJQueryWidget;
    IWFile: TmeIWFileUploader;
    mnuEsportaCsv: TMenuItem;
    mnuDestCsv: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdMessaggiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdMessaggimedpStatoChange;
    procedure btnHdnUploadClick(Sender: TObject);
    procedure grdDestinatariRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure rgpFiltroDestClick(Sender: TObject);
    procedure edtRicercaSubmit(Sender: TObject);
    procedure cmbFiltroMittenteChange(Sender: TObject);
    procedure cmbFiltroSelezioneChange(Sender: TObject);
    procedure btnFiltraClick(Sender: TObject);
    procedure chkStatoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkStatoTuttiAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure grdMessaggiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure rgpFiltroDaLeggereClick(Sender: TObject);
    procedure tabMessaggiTabControlChange(Sender: TObject);
    procedure btnDestinatariClick(Sender: TObject);
    procedure btnChiudiDestClick(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure grdMessaggiInserisci(Sender: TObject);
    procedure grdMessaggiModifica(Sender: TObject);
    procedure grdMessaggiCancella(Sender: TObject);
    procedure grdMessaggiConferma(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure mnuEsportaExcelClick(Sender: TObject);
    procedure mnuDestExcelClick(Sender: TObject);
    procedure btnRispondiClick(Sender: TObject);
    procedure btnStoricoClick(Sender: TObject);
    procedure btnChiudiElencoClick(Sender: TObject);
    procedure grdElencoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdMessaggiAnnulla(Sender: TObject);
    procedure imgScegliDestOperatoriClick(Sender: TObject);
    procedure tabMessaggiTabControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure mnuEsportaCsvClick(Sender: TObject);
    procedure mnuDestCsvClick(Sender: TObject);
  private
    FParMaxDimAllegatoMB: Integer;
    FParMaxAllegati: Integer;
    FParMesiDopoInvioCancMessaggi: Integer;
    FModalita: TModalitaGestione;
    FDatiModalitaArr: TDatiModalitaArr;
    // indica se è attiva la gestione del dato "ricevente"
    FVisualizzaRicevente: Boolean;
    selTabella: TOracleDataset;
    W035DM: TW035FMessaggisticaDM;
    grdC700: TmedpIWC700NavigatorBar;
    WC013FM: TWC013FCheckListFM;
    FLstOperatori: TStringList;
    FMsg: TMessaggio;
    iChkLetto: Integer;
    jChkLetto: Integer;
    iEdtRicevente: Integer;
    jEdtRicevente: Integer;
    iImgInvia: Integer;
    jImgInvia: Integer;
    iImgSalvaInvia: Integer;
    jImgSalvaInvia: Integer;
    // nome del cookie per il dettaglio (espanso / chiuso)
    FCookieDettName: String;
    FModalitaRisposta: Boolean;
    // tab index
    TAB_IDX_LETTURA,
    TAB_IDX_INVIO: Integer;
    FParQuotaAllegatiMB: Integer;
    FQuotaAllegatiUsata: Integer;
    FCallbackCalcolaQuotaAllegati: String;
    procedure SetModalita(const Value: TModalitaGestione);
    procedure ImpostaVisibilitaElementi; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function  GetNewID: Integer;
    function  CtrlMessaggio(const PAzione: String): TResCtrl;
    function  DoSalvaMessaggio: TResCtrl;
    function  DoInviaMessaggio(const PNotifica: Boolean): TResCtrl;
    function  DoCancellaMessaggio(const PNotifica: Boolean): TResCtrl;
    procedure VisualizzaInvio(const FN: String; const PShow: Boolean);
    function  ImpostaStatoLettura(const PLetto: Boolean): TResCtrl;
    function  ImpostaStatoRicezione: TResCtrl;
    procedure OnSelezioneAnagrafica;
    procedure OnSelezioneOperatori(Sender: TObject; Result:Boolean);
    procedure AggiornaDestinatari(const PSoloFiltro: Boolean = False);
    procedure AggiornaUI;
    procedure AbilitaUI;
    procedure AggiornaMessaggi(const PRicaricaComboFiltri: Boolean);
    procedure PulisciFiltriModalita;
    procedure InizializzaFiltriModalita;
    procedure SalvaFiltriModalita;
    procedure RipristinaFiltriModalita;
    procedure RipristinaBookmarkModalita;
    procedure ReimpostaComboFiltri;
    function  GetFiltroMessaggi: String;
    function  CreaAllegatoCheck(const PIndice: Integer): TmeIWCheckBox;
    function  CreaAllegatoLink(const PIndice: Integer): TmeIWLink;
    procedure lnkAllegatoClick(Sender: TObject);
    procedure chkAllegatoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgInviaClick(Sender: TObject);
    procedure imgConfermaInviaClick(Sender: TObject);
    procedure imgLetturaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure edtRiceventeSubmit(Sender: TObject);
    procedure edtRiceventeAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure EspandiDettaglio; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    //procedure RiduciDettaglio;
    function  IsUserOperatore: Boolean; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    procedure ImpostaVisibilitaSezioneAllegati;
    procedure CalcolaQuotaAllegati(EventParams: TStringList);
    function GetQuotaAllegatiUsata: Integer;
    function SuperoQuotaAllegati(const PDimensioneByte: Integer): Boolean; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
  protected
    procedure RefreshPage; override;
    function  GetInfoFunzione: String; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    property  Modalita: TModalitaGestione read FModalita write SetModalita;
    function  InizializzaAccesso: Boolean; override;
    procedure ClearMessaggio;
    procedure LeggiMessaggio;
    procedure CtrlImpostaStatoRicezione(EventParams: TStringList);
  end;

const
  // cookie
  ID_DETTAGLIO                     = 'w035Dettaglio';
  COOKIE_DETTAGLIO_FMT             = 'w035Dettaglio_%s_idx';
  ID_QUOTA_ALLEGATI                = 'w035Quota';

  // stati del messaggio (dominio di valori da tabella db)
  STATO_MSG_SOSPESO                 = 'S';
  STATO_MSG_CANCELLATO              = 'C';
  STATO_MSG_INVIATO                 = 'I';

  // item del filtro messaggi
  ITEM_DA_LEGGERE                   = 0;
  ITEM_LETTI                        = 1;
  ITEM_TUTTI                        = 2;
  ITEM_CANCELLATI                   = 3;

  // flag per allegati (utilizzato internamente a questa unit)
  FLAG_ALLEG_NUOVO                  = 'N';
  FLAG_ALLEG_SALVATO                = 'S';
  FLAG_ALLEG_CANC_NUOVO             = 'CN';
  FLAG_ALLEG_CANC_SALVATO           = 'CS';

  // notifiche
  DURATA_NOTIFICA                   = 6000;

  // azioni di controllo
  AZIONE_INVIA                      = 'I';
  AZIONE_SALVA                      = 'S';

  LIMITE_CARATTERI_TESTO            = 100;    // limite di caratteri per il testo da visualizzare in tabella
  LIMITE_RIGHE_TESTO                = 4;      // limite di ritorni a capo per il testo da visualizzare in tabella
  LIMITE_CARATTERI_DESTINATARI      = 20;     // limite di caratteri per i destinatari nell'elenco
  LIMITE_DESTINATARI_VISUALIZZATI   = 2;      // limite di destinatari visualizzati in modo esplicito

  // prefisso da impostare sull'oggetto per la risposta
  PREFISSO_OGGETTO_RISPOSTA         = 'Re: ';

  // css personalizzati
  // righe messaggi in tabella
  CSS_MSG_RICEVUTO_DALEGGERE        = 'msg_ric_daLeggere';
  CSS_MSG_INVIATO_DALEGGERE         = 'msg_inv_daLeggere';
  CSS_MSG_INVIATO_LETTO             = 'msg_inv_lettoTutti';
  CSS_MSG_INVIATO_LETTOPARZIALMENTE = 'msg_inv_lettoParz';
  CSS_MSG_CANCELLATO                = 'msg_canc';

  // righe messaggi inviati / ricevuti nello storico
  CSS_RIGA_INVIATO                  = 'w035_riga_inviato';
  CSS_RIGA_RICEVUTO                 = 'w035_riga_ricevuto';

  CIRCLE_QUOTA_ALLEGATI_SIZE        = 70; // dimensione cerchio quota allegati in px

implementation

uses IWGlobal;

{$R *.dfm}

function TW035FMessaggistica.InizializzaAccesso: Boolean;
// questa maschera è richiamabile con il parametro
// MODALITA
// - 'I'' = messaggi inviati (possibile solo in caso di accesso in scrittura alla funzione)
// - 'L'' = messaggi ricevuti
begin
  // importante: anche l'operatore iriswin può ricevere messaggi

  // impostazione tab (modalità operativa)
  tabMessaggi.HasFiller:=True;
  TAB_IDX_LETTURA:=tabMessaggi.AggiungiTab(Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_MESSAGGI_RICEVUTI),['']),rgnDati);
  TAB_IDX_INVIO:=tabMessaggi.AggiungiTab(A000TraduzioneStringhe(A000MSG_W035_MSG_MESSAGGI_INVIATI),rgnDati);
  InizializzaFiltriModalita;

  // invio messaggi: solo se funzione in scrittura
  tabMessaggi.TabByIndex(TAB_IDX_INVIO).Visible:=not SolaLettura;

  // inizializza i filtri
  PulisciFiltriModalita;

  if SolaLettura then
  begin
    tabMessaggi.ActiveTabIndex:=TAB_IDX_LETTURA;
  end
  else
  begin
    if GetParam('MODALITA') = 'I' then
      tabMessaggi.ActiveTabIndex:=TAB_IDX_INVIO
    else
      tabMessaggi.ActiveTabIndex:=TAB_IDX_LETTURA
  end;

  // inizializzazione ok
  Result:=True;
end;

procedure TW035FMessaggistica.RefreshPage;
begin
  AggiornaMessaggi(True);
end;

function TW035FMessaggistica.IsUserOperatore: Boolean;
// nel contesto della messaggistica, restituisce:
// - True
//     se l'utente attualmente loggato è un operatore win (*)
// - False
//     se l'utente loggato è un operatore web
// (*) IMPORTANTE
//   fra gli operatori win vengono annoverati anche
//   gli utenti web non associati ad una matricola
begin
  Result:=(WR000DM.TipoUtente = 'Supervisore') or
          (Parametri.MatricolaOper = '');
end;

procedure TW035FMessaggistica.IWAppFormCreate(Sender: TObject);
var
  LCodeJS,
  LCallBackName: String;
  LInfoAllegati: String;
begin
  // parametri relativi agli allegati
  FParMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_W035MaxDimAllegatoMB,5);
  FParMaxAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_W035MaxAllegati,MaxInt);
  if FParMaxAllegati < 0 then
    FParMaxAllegati:=MaxInt;
  FParQuotaAllegatiMB:=StrToIntDef(Parametri.CampiRiferimento.C90_W035QuotaAllegatiMB,-1);
  FParMesiDopoInvioCancMessaggi:=Max(0,StrToIntDef(Parametri.CampiRiferimento.C90_W035MesiDopoInvioCancMessaggi,0));

  // plugin per visualizzazione grafica quota allegati
  if FParQuotaAllegatiMB > -1 then
    AggiungiPluginJavaScript('JQ_EASYPIECHART','Si noti che la rappresentazione grafica della quota degli allegati non pu&ograve; essere visualizzata in quanto il browser in uso &egrave; obsoleto.');

  inherited;

  // datamodule e variabili di supporto
  W035DM:=TW035FMessaggisticaDM.Create(Self);

  // bookmark per riposizionarsi nel passaggio da un tab all'altro
  selTabella:=nil;

  // clientdataset destinatari
  cdsDestinatari.Close;
  cdsDestinatari.IndexDefs.Add('Nominativo','UTENTE;COGNOME;NOME;MATRICOLA',[]);
  cdsDestinatari.IndexName:='Nominativo';
  cdsDestinatari.CreateDataSet;
  cdsDestinatari.LogChanges:=False;
  cdsDestinatari.Open;

  // tabella destinatari
  grdDestinatari.medpDataset:=cdsDestinatari;
  grdDestinatari.medpTestoNoRecord:='Nessun destinatario';
  grdDestinatari.medpRowSelect:=False;
  grdDestinatari.medpAttivaGrid(cdsDestinatari,False,False);

  // tabella elenco messaggi
  W035DM.selElencoMsg.Open;
  grdElenco.medpDataset:=W035DM.selElencoMsg;
  grdElenco.medpRowIDField:='ID';
  grdElenco.medpTestoNoRecord:='Nessun messaggio';
  grdElenco.medpRowSelect:=True;
  grdElenco.medpAttivaGrid(W035DM.selElencoMsg,False,False);

  memElencoTesto.DataSource:=grdElenco.DataSource;

  // estrae lista operatori win
  FLstOperatori:=TStringList.Create;
  W035DM.selOperatori.Close;
  W035DM.selOperatori.SetVariable('TAG',Self.Tag);
  W035DM.selOperatori.Open;
  while not W035DM.selOperatori.Eof do
  begin
    FLstOperatori.Add(W035DM.selOperatori.FieldByName('UTENTE').AsString);
    W035DM.selOperatori.Next;
  end;
  W035DM.selOperatori.Close;

  // navigator C700 per selezione destinatari web
  if (not Parametri.InibizioneIndividuale) or
     (IsUserOperatore) then
  begin
    grdC700:=TmedpIWC700NavigatorBar.Create(Self);
    grdC700.Parent:=rgnDati;
    grdC700.Css:=grdC700.Css + ' floatLeft';
    grdC700.AggiornaAnagr:=OnSelezioneAnagrafica;
    grdC700.CreaSelezioneIniziale(True);
    grdC700.AttivaBrowse:=False;
    grdC700.AttivaEredita:=False;
    grdC700.AttivaLabel:=False;
  end;

  // callback per impostare stato ricezione messaggio
  LCallBackName:=UpperCase(Self.Name) + '.CtrlImpostaStatoRicezione';
  GGetWebApplicationThreadVar.RegisterCallBack(LCallBackName,CtrlImpostaStatoRicezione);

  // callback per calcolo utilizzo quota allegati
  jqQuotaAllegati.Enabled:=(FParQuotaAllegatiMB > -1);
  if FParQuotaAllegatiMB > -1 then
  begin
    LCodeJS:=
      // accordion per quota allegati
      'try { '#13#10 +
      Format(
      '  $("#%s").accordion({ '#13#10,
      [ID_QUOTA_ALLEGATI]
      ) +
      '    heightStyle: "content", '#13#10 +
      '    clearStyle: true, '#13#10 +
      '    collapsible: false, '#13#10 +
      '    active: 0'#13#10 +
      '  }); '#13#10 +
      '} '#13#10 +
      'catch (err) { '#13#10 +
      '  gestioneErrori(err.message + "|" + "jqQuotaAllegati" + "|accordion","",0); '#13#10 +
      '} '#13#10 +
      // grafica per quota allegati
      Format(
        'try { '#13#10 +
        '  $("#quota-chart").easyPieChart({ '#13#10 +
        '    barColor: function (percent) { '#13#10 +
        '      return (percent < 60 ? "#08c82c" : '#13#10 +
        '              percent < 80 ? "#ffa500" : "#ff0000"); '#13#10 +
        '    }, '#13#10 +
        '    trackColor: "#cccccc", '#13#10 +
        '    scaleColor: false, '#13#10 + //
        //'    scaleLength: ???  '#13#10 +
        '    lineCap: "butt", '#13#10 + // butt / round / square
        '    lineWidth: 10, '#13#10 + // larghezza in px
        '    size: %d, '#13#10 + // dimensione grafico in px
        //'    rotate: 0 '#13#10 +
        '    animate: 800, '#13#10 + // tempo di animazione in millisecondi per l'avanzamento / false per disattivare
        '    easing: "swing", '#13#10 +
        '    onStep: function(from, to, percent) { '#13#10 +
        '      $(this.el).find("#quota-percent") '#13#10 +
        '        .text(Math.round(percent)) '#13#10 +
        '        .css("color", (percent < 60 ? "#08c82c" : '#13#10 +
        '                       percent < 80 ? "#ffa500" : "#ff0000")); '#13#10 +
        '      } '#13#10 +
        '    }); '#13#10 +
        ' } '#13#10 +
        'catch (err) { '#13#10 +
        //'  gestioneErrori(err.message + "|" + "jqQuotaAllegati" + "|easyPieChart","",0); '#13#10 +
        '  try{ ' + #13#10 +
        '     console.log(err.message + "|" + "jqQuotaAllegati" + "|easyPieChart"); '#13#10 +
        '  } ' + #13#10 +
        '  catch(e){}' +
        '} '#13#10,
        [CIRCLE_QUOTA_ALLEGATI_SIZE]
      );
    jqQuotaAllegati.OnReady.Text:=LCodeJS;

    FCallbackCalcolaQuotaAllegati:=UpperCase(Self.Name) + '.CalcolaQuotaAllegati';
    GGetWebApplicationThreadVar.RegisterCallBack(FCallbackCalcolaQuotaAllegati,CalcolaQuotaAllegati);
  end;

  // imposta nome cookie per determinare lo stato del dettaglio messaggio (aperto / chiuso)
  FCookieDettName:=Format(COOKIE_DETTAGLIO_FMT,[GGetWebApplicationThreadVar.AppID]);

  // accordion per dettaglio messaggio
  LCodeJS:=
    'try { '#13#10 +
    Format(
    '  var cName = "%s"; '#13#10 +
    '  $("#%s").accordion({ '#13#10,
    [FCookieDettName,
     ID_DETTAGLIO]
    ) +
    '    heightStyle: "content", '#13#10 +
    '    clearStyle: true, '#13#10 +
    '    collapsible: true, '#13#10 +
    '    activate: function (event, ui) { '#13#10 +
    '      /* -1 se nessuno aperto, oppure >=0 */ '#13#10 +
    '      $.cookie(cName, ui.newHeader.index(), { expires: 2, path: "/" }); '#13#10 +
    '      if (ui.newHeader.index() >= 0) { '#13#10 +
    '        processAjaxEvent("",null,"' + LCallBackName + '",false,null,false); '#13#10 +
    '      } '#13#10 +
    '    }, '#13#10 +
    IfThen(Parametri.CampiRiferimento.C90_MessaggisticaApriDettaglio = 'S',
    '    active: 0 ',
    '    active: ($.cookie(cName) == null) ? false : ($.cookie(cName) == "-1") ? false : parseInt($.cookie(cName)) '
    ) + #13#10 +
    '  }); '#13#10 +
    '} '#13#10 +
    'catch (err) { '#13#10 +
    '  gestioneErrori(err.message + "|" + "jqDettaglio" + "|0","",0); '#13#10 +
    '} ';
  jqDettaglio.OnReady.Text:=LCodeJS;

  // abilita il jquery per il watermark
  jqWatermark.Enabled:=True;

  // evita submit
  { DONE : TEST IW 14 OK }
  {btnDestinatari.DontSubmitFiles:=True;
  btnFiltra.DontSubmitFiles:=True;
  edtRicerca.DontSubmitFiles:=True;}

  // inizializzazione variabili
  iChkLetto:=0;
  jChkLetto:=0;
  iEdtRicevente:=0;
  jEdtRicevente:=0;
  iImgInvia:=0;
  jImgInvia:=0;

  chkLetturaObbligatoria.Visible:=Parametri.CampiRiferimento.C90_MessaggisticaObbligoLettura = 'S';
  IWFile.MEdpMaxFileSize:=FParMaxDimAllegatoMB * BYTES_MB;

  // info allegati
  LInfoAllegati:=Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_INFO_DIM_ALLEGATO),[FParMaxDimAllegatoMB]);
  if FParMaxAllegati < MaxInt then
    LInfoAllegati:=Format('%s<br>%s',[LInfoAllegati ,Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_INFO_MAX_ALLEGATI),[FParMaxAllegati])]);
  imgAllegatiInfo.Hint:='<html>' + LInfoAllegati;
  imgAllegatiInfo.ShowHint:=True;

  // model per il messaggio
  FMsg:=TMessaggio.Create;
end;

procedure TW035FMessaggistica.IWAppFormRender(Sender: TObject);
var
  LJSCode: String;
begin
  inherited;

  LJSCode:='';

  // visibilità groupbox filtro destinatari nella region relativa
  if rgnDestinatari.Visible then
  begin
    LJSCode:=LJSCode +
             Format('var w035dest = document.getElementById("w035_dest"); '#13#10 +
                    'if (w035dest) {                                      '#13#10 +
                    '  w035dest.className = "groupbox fs100 %s";          '#13#10  +
                    '}                                                    '#13#10,
                    [IfThen(rgpFiltroDest.Visible,'','invisibile')]);
    AddToInitProc(LJSCode);
  end;

  // aggiorna la quota allegati
  if FParQuotaAllegatiMB > -1 then
    CalcolaQuotaAllegati(nil);
end;

procedure TW035FMessaggistica.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 14 OK }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    RimuoviNotifiche;
  end;
end;

function TW035FMessaggistica.GetInfoFunzione: String;
begin
  Result:='';
end;

procedure TW035FMessaggistica.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // chiusura frame cancellazione periodo
    if AComponent = WC013FM then
    begin
      WC013FM:=nil;
    end;
  end;
end;

procedure TW035FMessaggistica.SetModalita(const Value: TModalitaGestione);
var
  LOldAfterScroll: TDataSetAfterScroll;
begin
  FModalita:=Value;

  FModalitaRisposta:=False;

  // determina se attivare o meno la gestione del dato "ricevente"
  // la gestione del ricevente è specifica per SGIULIANOMILANESE_COMUNE
  // e serve ad indicare l'operatore che prende in carico la chiamata
  // la colonna deve essere visibile solo se si verificano queste condizioni:
  // in modalità lettura: modalità di risposta attiva e utente supervisore
  // in modalità invio:   modalità di risposta attiva e sono presenti operatori disponibili a cui inviare il messaggio
  if FModalita = TModalitaGestione.Lettura then
    FVisualizzaRicevente:=(Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and
                          (WR000DM.TipoUtente = 'Supervisore')
  else
    FVisualizzaRicevente:=(Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and
                          (FLstOperatori.Count > 0);

  // imposta la visibilità dei componenti in base al tipo di accesso
  ImpostaVisibilitaElementi;

  if FModalita = TModalitaGestione.Lettura then
  begin
    // funzione in lettura: messaggi destinati all'utente / operatore

    // nel contesto della messaggistica, l'utente web non associato
    // ad una matricola è considerato come un operatore
    if IsUserOperatore then
    begin
      // messaggi destinati all'operatore win
      selTabella:=W035DM.selT282RicevutiOper;
      selTabella.Close;
      selTabella.SetVariable('UTENTE',Parametri.Operatore);
    end
    else
    begin
      // messaggi destinati all'operatore web
      selTabella:=W035DM.selT282Ricevuti;
      selTabella.Close;
      selTabella.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
    end;
  end
  else
  begin
    // funzione in scrittura: messaggi inviati dall'utente
    selTabella:=W035DM.selT282Inviati;
    selTabella.Close;
    selTabella.SetVariable('MITTENTE',Parametri.Operatore);
    selTabella.SetVariable('LIMITE_DEST',LIMITE_DESTINATARI_VISUALIZZATI);
  end;
  selTabella.SetVariable('FILTRO_VIS',GetFiltroMessaggi);

  // disabilita afterscroll
  LOldAfterScroll:=selTabella.AfterScroll;
  selTabella.AfterScroll:=nil;

  // apre dataset
  selTabella.Open;

  // imposta la tabella dei messaggi
  grdMessaggi.medpRighePagina:=GetRighePaginaTabella;

  // imposta visibilità campo lettura obbligatoria
  selTabella.FieldByName('LETTURA_OBBLIGATORIA').Visible:=Parametri.CampiRiferimento.C90_MessaggisticaObbligoLettura = 'S';

  grdMessaggi.medpDataset:=selTabella;
  grdMessaggi.medpTestoNoRecord:='Nessun messaggio';
  grdMessaggi.Hint:=Format('Per aprire il messaggio cliccare su %s',[lblDettaglio.Caption]);
  grdMessaggi.medpComandiCustom:=True;
  grdMessaggi.medpAttivaGrid(selTabella,FModalita = TModalitaGestione.Invio,FModalita = TModalitaGestione.Invio);

  if FModalita = TModalitaGestione.Lettura then
  begin
    // lettura: prevede icona azione per segnare messaggic come letto/non letto
    iChkLetto:=grdMessaggi.medpIndexColonna('DATA_LETTURA');
    jChkLetto:=0;
    grdMessaggi.medpPreparaComponenteGenerico('R',iChkLetto,jChkLetto,DBG_CHK,'','','','','C');

    iEdtRicevente:=grdMessaggi.medpIndexColonna('RICEVENTE');
    jEdtRicevente:=0;
    grdMessaggi.medpPreparaComponenteGenerico('R',iEdtRicevente,jEdtRicevente,DBG_EDT,'30','','','','S');
  end
  else
  begin
    // invio: prevede icona azione di invio messaggio
    { TODO : Rivedere gli indici di riga e colonna fissi, magari con un metodo di medpIWDBGrid }
    iImgInvia:=0;
    jImgInvia:=4;
    grdMessaggi.medpPreparaComponenteGenerico('R',iImgInvia,jImgInvia,DBG_IMG,'','INVIA','Invia messaggio','Confermi l''invio del messaggio?','D');

    // inserimento: icona di conferma + invio
    { TODO : Rivedere gli indici di riga e colonna fissi, magari con un metodo di medpIWDBGrid }
    iImgSalvaInvia:=0;
    jImgSalvaInvia:=3;
    grdMessaggi.medpPreparaComponenteGenerico('I',iImgSalvaInvia,jImgSalvaInvia,DBG_IMG,'','INVIA','Invia messaggio','Confermi l''invio del messaggio?','D');

    if FParQuotaAllegatiMB > -1 then
      AddToInitProc(Format('processAjaxEvent("",null,"%s",false,null,false);',[FCallbackCalcolaQuotaAllegati]));
  end;

  // imposta visibilità colonne
  grdMessaggi.medpColonna('DBG_COMANDI').Visible:=FModalita = TModalitaGestione.Invio;
  grdMessaggi.medpColonna('D_STATO').Visible:=FModalita = TModalitaGestione.Invio;
  grdMessaggi.medpColonna('ID').Visible:=False;
  grdMessaggi.medpColonna('STATO').Visible:=False;
  grdMessaggi.medpColonna('MITTENTE').Visible:=False;
  // ricevente: campo utilizzato da SAN GIULIANO che rappresenta l'utente che prende in carico la chiamata
  grdMessaggi.medpColonna('RICEVENTE').Visible:=FVisualizzaRicevente;
  grdMessaggi.medpColonna('ID_ORIGINALE').Visible:=False;
  grdMessaggi.medpColonna('SELEZIONE_ANAGRAFICA').Visible:=FModalita = TModalitaGestione.Invio;

  // ripristina afterscroll
  selTabella.AfterScroll:=LOldAfterScroll;

  // legge i messaggi
  grdMessaggi.medpCaricaCDS;
  if selTabella.RecordCount = 0 then
    ClearMessaggio;
  ReimpostaComboFiltri;
end;

procedure TW035FMessaggistica.AggiornaMessaggi(const PRicaricaComboFiltri: Boolean);
// aggiornamento visualizzazione tabella messaggi
var
  LOldAfterScroll: TDataSetAfterScroll;
  LOldSelezione: string;
  LOldMittente: String;
begin
  // nasconde pulsante storico
  btnStorico.Visible:=False;

  // disabilita afterscroll
  LOldAfterScroll:=selTabella.AfterScroll;
  selTabella.AfterScroll:=nil;

  // reimposta filtro visualizzazione
  selTabella.Close;
  selTabella.SetVariable('FILTRO_VIS',GetFiltroMessaggi);
  selTabella.Open;

  // ripristina afterscroll
  selTabella.AfterScroll:=LOldAfterScroll;

  // carica tabella
  grdMessaggi.medpCaricaCDS;
  if selTabella.RecordCount = 0 then
    ClearMessaggio;

  // se necessario ricarica le combobox dei filtri mittente e selezione
  if PRicaricaComboFiltri then
  begin
    // salva i valori delle combobox
    LOldSelezione:=cmbFiltroSelezione.Text;
    LOldMittente:=cmbFiltroMittente.Text;

    ReimpostaComboFiltri;

    // reimposta combobox
    cmbFiltroSelezione.ItemIndex:=cmbFiltroSelezione.Items.IndexOf(LOldSelezione);
    cmbFiltroMittente.ItemIndex:=cmbFiltroMittente.Items.IndexOf(LOldMittente);
  end;
end;

procedure TW035FMessaggistica.ReimpostaComboFiltri;
// reimposta i filtri in base al contenuto del dataset
var
  LOldAfterScroll: TDataSetAfterScroll;
  LOldFiltered: Boolean;
begin
 // imposta combobox per il filtro su mittente
  cmbFiltroMittente.ItemsHaveValues:=True;
  cmbFiltroMittente.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  cmbFiltroMittente.Items.Duplicates:=dupIgnore;
  cmbFiltroMittente.Items.Sorted:=True;
  cmbFiltroMittente.Items.Clear;
  cmbFiltroMittente.Items.Add('');

  // imposta combobox per il filtro sulla selezione anagrafica
  // (è usato solo in modalità completa)
  cmbFiltroSelezione.Items.Duplicates:=dupIgnore;
  cmbFiltroSelezione.Items.Sorted:=True;
  cmbFiltroSelezione.Items.Clear;
  cmbFiltroSelezione.Items.Add('');

  // ciclo di popolamento combobox per gestione filtri
  LOldFiltered:=selTabella.Filtered;
  LOldAfterScroll:=selTabella.AfterScroll;
  selTabella.Filtered:=False;
  selTabella.AfterScroll:=nil;
  selTabella.First;
  while not selTabella.Eof do
  begin
    // item (senza duplicati) per combobox mittenti
    cmbFiltroMittente.Items.Add(Format('%s' + NAME_VALUE_SEPARATOR + '%s',[selTabella.FieldByName('D_MITTENTE').AsString,selTabella.FieldByName('MITTENTE').AsString]));
    if FModalita = TModalitaGestione.Invio then
    begin
      cmbFiltroSelezione.Items.Add(selTabella.FieldByName('SELEZIONE_ANAGRAFICA').AsString);
    end;
    selTabella.Next;
  end;

  // reimpostazione tabella
  cmbFiltroMittente.ItemIndex:=0;
  cmbFiltroSelezione.ItemIndex:=0;
  selTabella.Filtered:=LOldFiltered;
  selTabella.First;
  selTabella.AfterScroll:=LOldAfterScroll;

  // imposta la visibilità dei componenti in base al tipo di accesso
  ImpostaVisibilitaElementi;
end;

procedure TW035FMessaggistica.ImpostaVisibilitaElementi;
var
  LEsistonoMessaggi: Boolean;
begin
  // filtri stato messaggio
  chkStatoSospeso.Visible:=FModalita = TModalitaGestione.Invio;
  chkStatoInviato.Visible:=FModalita = TModalitaGestione.Invio;
  chkStatoCancellato.Visible:=FModalita = TModalitaGestione.Invio;
  chkStatoTutti.Visible:=FModalita = TModalitaGestione.Invio;

  // destinatari
  lblDestinatari.Visible:=FModalita = TModalitaGestione.Invio;
  if Assigned(grdC700) then
  begin
    grdC700.Visible:=(FModalita = TModalitaGestione.Invio) and (not FModalitaRisposta);
  end;
  rgpFiltroDest.Visible:=(FModalita = TModalitaGestione.Invio) and (grdMessaggi.medpStato <> msInsert) and (FMsg.Stato <> STATO_MSG_SOSPESO);
  edtDestinatari.Visible:=FModalita = TModalitaGestione.Invio;
  btnDestinatari.Visible:=(FModalita = TModalitaGestione.Invio);
  grdDestinatari.Visible:=FModalita = TModalitaGestione.Invio;

  // destinatari win (operatori)
  imgScegliDestOperatori.Visible:=(FModalita = TModalitaGestione.Invio) and (not FModalitaRisposta) and (FLstOperatori.Count > 0);

  LEsistonoMessaggi:=(Assigned(selTabella)) and
                     (selTabella.Active) and
                     (selTabella.RecordCount > 0);
  // visibilità pulsante storico -> cfr. procedure LeggiMessaggio
  // (si basa su dati del record)
  btnRispondi.Visible:=(Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and
                       (FModalita = TModalitaGestione.Lettura) and
                       (LEsistonoMessaggi);

  // visibilità sezione allegati
  ImpostaVisibilitaSezioneAllegati;

  // label per filtro periodo invio
  lblPeriodoDal.Visible:=FModalita = TModalitaGestione.Lettura;

  // filtro mittente
  lblFiltroMittente.Visible:=FModalita = TModalitaGestione.Lettura;
  cmbFiltroMittente.Visible:=FModalita = TModalitaGestione.Lettura;

  // filtro selezione
  lblFiltroSelezione.Visible:=FModalita = TModalitaGestione.Invio;
  cmbFiltroSelezione.Visible:=FModalita = TModalitaGestione.Invio;

  // filtro messaggi da leggere
  rgpFiltroDaLeggere.Visible:=FModalita = TModalitaGestione.Lettura;
end;

procedure TW035FMessaggistica.ImpostaVisibilitaSezioneAllegati;
var
  LAbilitaUpload: Boolean;
  LCodeJS: string;
  LOldStatus: String;
  LNewStatus: String;
  function GetStatus: String;
  begin
    Result:=IfThen(lblNessunAllegato.Visible,'1','0') +
            IfThen(IWFile.Visible,'1','0') +
            // { DONE : TEST IW 14 OK } IfThen(IWFile.MEdpPulsanteVisible,'1','0') +
            IfThen(lblLimiteAllegatiRaggiunto.Visible,'1','0');
  end;
begin
  LOldStatus:=GetStatus;

  lblNessunAllegato.Visible:=(grdMessaggi.medpStato = msBrowse) and (Length(FMsg.AllegatiArr) = 0);

  LAbilitaUpload:=(FModalita = TModalitaGestione.Invio) and (grdMessaggi.medpStato <> msBrowse) and (not FMsg.MaxAllegatiRaggiunto);
  IWFile.Visible:=LAbilitaUpload;
  { DONE : TEST IW 14 OK }
  //btnUpload.Visible:=IWFile.Visible;


  lblLimiteAllegatiRaggiunto.Visible:=(FModalita = TModalitaGestione.Invio) and (grdMessaggi.medpStato <> msBrowse) and (FMsg.MaxAllegatiRaggiunto);
  if lblLimiteAllegatiRaggiunto.Visible then
    lblLimiteAllegatiRaggiunto.Caption:=A000TraduzioneStringhe(A000MSG_W035_MSG_MAX_ALLEGATI_RAGGIUNTO);

  LNewStatus:=GetStatus;

  // forza l'esecuzione in full submit in caso di cambiamenti non gestibili in async
  if (GGetWebApplicationThreadVar.IsCallBack) and
     (LNewStatus <> LOldStatus) then
  begin
    LCodeJS:=Format('SubmitClick("%s","",true);',[btnFiltra.HTMLName]);
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(LCodeJS);
  end;
end;

procedure TW035FMessaggistica.rgpFiltroDaLeggereClick(Sender: TObject);
begin
  if rgpFiltroDaLeggere.ItemIndex = ITEM_CANCELLATI then
  begin
    // messaggi cancellati
    // stato inviato    -> deselezionato
    // stato cancellato -> selezionato
    chkStatoCancellato.Checked:=True;
    chkStatoInviato.Checked:=False;
    chkStatoAsyncClick(chkStatoInviato,nil);
  end
  else
  begin
    // altri casi
    // stato inviato    -> selezionato
    // stato cancellato -> deselezionato
    chkStatoCancellato.Checked:=False;
    chkStatoInviato.Checked:=True;
    chkStatoAsyncClick(chkStatoInviato,nil);
  end;

  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.rgpFiltroDestClick(Sender: TObject);
// filtro destinatari
begin
  AggiornaDestinatari(True);
end;

procedure TW035FMessaggistica.edtRicercaSubmit(Sender: TObject);
// filtro su oggetto / testo
begin
  AggiornaMessaggi(False);
end;

procedure TW035FMessaggistica.tabMessaggiTabControlChanging(Sender: TObject; var AllowChange: Boolean);
// salva il bookmark
begin
  SalvaFiltriModalita;
end;

procedure TW035FMessaggistica.tabMessaggiTabControlChange(Sender: TObject);
//
begin
  // ripristina i filtri precedentemente salvati
  RipristinaFiltriModalita;

  if tabMessaggi.ActiveTabIndex = TAB_IDX_LETTURA then
    Modalita:=TModalitaGestione.Lettura
  else
    Modalita:=TModalitaGestione.Invio;

  // ripristina il bookmark
  RipristinaBookmarkModalita;
end;

procedure TW035FMessaggistica.AggiornaUI;
var
  i, NonLetti, NumAllegati: Integer;
  TestoTab: String;
begin
  // conteggio messaggi da leggere
  if (not WebApplication.IsCallBack) and // in async selTabella non è aggiornato
     (Modalita = TModalitaGestione.Lettura) and
     (rgpFiltroDaLeggere.ItemIndex = ITEM_DA_LEGGERE) and
     (edtPeriodoDal.Text = '') and
     (edtPeriodoAl.Text = '') and
     (cmbFiltroMittente.Text = '') and
     (cmbFiltroSelezione.Text = '') and
     ((edtRicerca.Text = '') or
      (edtRicerca.Text = edtRicerca.medpWatermark)) then
  begin
    // se la pagina è in modalità "messaggi ricevuti", il filtro è impostato su "da leggere"
    // e non ci sono altri filtri attivi, allora il numero di messaggi da leggere
    // corrisponde al recordcount del dataset (evita la query di conteggio)
    NonLetti:=selTabella.RecordCount;
  end
  else
  begin
    // esegue query di conteggio
    NonLetti:=WR000DM.GetNumMsgDaLeggere.Totali;
  end;

  // testo del tab
  TestoTab:=Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_MESSAGGI_RICEVUTI),
                [IfThen(NonLetti > 0,Format(' <span class="w035ContatoreMsg">%d</span>',[NonLetti]))]);
  tabMessaggi.TabByIndex(0).Caption:=TestoTab;
  // workaround - ini
  if GGetWebApplicationThreadVar.IsCallBack then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteasCData('document.getElementById(''' + tabMessaggi.TabByIndex(0).Link.HTMLName + ''').innerHTML=''' + TestoTab + ''';')
  else
    AddToInitProc('document.getElementById(''' + tabMessaggi.TabByIndex(0).Link.HTMLName + ''').innerHTML=''' + TestoTab + ''';');
  // workaround - fine

  // dati del messaggio
  edtOggetto.Text:=FMsg.Oggetto;
  memTesto.Text:=FMsg.Testo;
  chkLetturaObbligatoria.Checked:=FMsg.LetturaObbligatoria = 'S';

  // id messaggio originale (risposte)
  edtIDOriginale.Text:=IntToStr(FMsg.IDOriginale);

  // destinatari
  if FModalita = TModalitaGestione.Invio then
  begin
    edtSelezione.Text:=IfThen(FMsg.IDOriginale = 0,'',FMsg.SelezioneAnagrafica);
    edtDestinatari.Text:=Trim(FMsg.SelezioneAnagrafica + ' ' +
                              Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_DESTINATARI_SEL),
                                     [FMsg.DestTot,FMsg.DestTot - FMsg.DestRicevuti]));
    AggiornaDestinatari;
  end;

  // allegati
  NumAllegati:=Length(FMsg.AllegatiArr);
  grdAllegati.medpClearComp;
  grdAllegati.RowCount:=1;
  if NumAllegati > 1 then
    grdAllegati.RowCount:=NumAllegati;
  lblNessunAllegato.Visible:=NumAllegati = 0;
  grdAllegati.Visible:=NumAllegati > 0;
  if NumAllegati > 0 then
  begin
    // visualizza allegati in tabella
    for i:=0 to NumAllegati - 1 do
    begin
      grdAllegati.Cell[i,0].Control:=CreaAllegatoCheck(i); // checkbox di selezione
      grdAllegati.Cell[i,1].Text:='';
      grdAllegati.Cell[i,1].Control:=CreaAllegatoLink(i);  // link per salvare allegato
    end;
  end;

  // abilitazione elementi interfaccia
  AbilitaUI;
end;

function TW035FMessaggistica.GetQuotaAllegatiUsata: Integer;
// estrae la quota allegati utilizzata
// se la grid è in modalità di edit, non considera il messaggio corrente
begin
  try
    W035DM.selT283DimAllegati.ClearVariables;
    W035DM.selT283DimAllegati.SetVariable('MITTENTE',Parametri.Operatore);
    if grdMessaggi.medpStato = TmedpStato.msEdit then
      W035DM.selT283DimAllegati.SetVariable('FILTRO',Format('and T282.ID <> %d',[FMsg.ID]));
    W035DM.selT283DimAllegati.Execute;
    Result:=W035DM.selT283DimAllegati.FieldAsInteger('DIM_ALLEGATI');
  except
    Result:=0;
  end;
end;

procedure TW035FMessaggistica.CalcolaQuotaAllegati(EventParams: TStringList);
var
  LQuotaUsata: Integer;
  LQuotaUsataMB: real;
  LQuotaUsataMBTrunc: Integer;
  LQuotaPerc: Integer;
  LJSCode: string;
begin
  if FParQuotaAllegatiMB = -1 then
    Exit;

  // aggiorna la quota utilizzata dai messaggi salvati / inviati
  FQuotaAllegatiUsata:=GetQuotaAllegatiUsata;

  if FModalita = TModalitaGestione.Invio then
  begin
    // calcola la quota usata come somma dei messaggi già inviati più gli allegati già aggiunti dell'eventuale messaggio corrente
    LQuotaUsata:=FQuotaAllegatiUsata;
    if grdMessaggi.medpStato in [TmedpStato.msInsert, TmedpStato.msEdit] then
      LQuotaUsata:=LQuotaUsata + FMsg.DimTotAllegati;
    LQuotaUsataMB:=LQuotaUsata / 1024 / 1024;
    LQuotaUsataMBTrunc:=Trunc(LQuotaUsataMB);

    // determina la percentuale sulla quota disponibile
    if FParQuotaAllegatiMB = 0 then
      LQuotaPerc:=100
    else
      LQuotaPerc:=Trunc(LQuotaUsataMBTrunc * 100 / FParQuotaAllegatiMB);

    LogConsole(Format('imposta percentuale %d',[LQuotaPerc]));

    LJsCode:=
      Format(
        // visualizza la cella con il riquadro delle info sulla quota
        '  $("#%s").removeClass("nascosto"); '#13#10 +
        // impostazioni del testo con la percentuale
        '  $("#quota-percent") '#13#10 +
        '    .css("line-height", "%dpx") '#13#10 +
        '    .width(%d) '#13#10 +
        '    .height(%d); '#13#10,
        [ID_QUOTA_ALLEGATI,
         CIRCLE_QUOTA_ALLEGATI_SIZE,
         CIRCLE_QUOTA_ALLEGATI_SIZE,
         CIRCLE_QUOTA_ALLEGATI_SIZE]) +
      // impostazioni del cerchio con la percentuale
      Format(
        'try { '#13#10 +
        // indicazione quota utilizzata
        '  $("#quota-space-used") '#13#10 +
        '    .html("%s <p><b>%d MB</b> di <b>%d MB</b></p>"); '#13#10 +
        // imposta la percentuale (con animazione)
        '  $("#quota-chart").data("easyPieChart").update(%d); '#13#10 +
        '} '#13#10 +
        'catch (err) { '#13#10 +
        '   $("#quota-percent").text("%d"); '#13#10 +
        //'  gestioneErrori(err.message + "|" + "easyPieChart" + "|0","",0); '#13#10 +
        '   try{ ' + #13#10 +
        '     console.log(err.message + "|" + "easyPieChart" + "|0"); '#13#10 +
        '   } ' + #13#10 +
        '   catch(e){}' + #13#10 +
        '} '#13#10,
        [A000TraduzioneStringhe(A000MSG_W035_MSG_LBL_QUOTA_USATA),LQuotaUsataMBTrunc,FParQuotaAllegatiMB,
         LQuotaPerc,
         LQuotaPerc]
      );
  end
  else
  begin
    // modalità lettura: riquadro nascosto
    LJsCode:=Format('$("%s").addClass("nascosto"); ',[ID_QUOTA_ALLEGATI]);
  end;

  // codice da eseguire lato javascript
  if LJsCode <> '' then
  begin
    if GGetWebApplicationThreadVar.IsCallBack then
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(LJsCode)
    else
      AddToInitProc(LJSCode);
  end;
end;

procedure TW035FMessaggistica.AbilitaUI;
var
  IsModifica: Boolean;
  r: Integer;
  IWChk: TmeIWCheckBox;
begin
  // reimposta la visibilita degli elementi
  ImpostaVisibilitaElementi;

  // abilita interfaccia se grid non è in browse
  IsModifica:=grdMessaggi.medpStato <> msBrowse;

  // abilitazione dettaglio in base allo stato della tabella
  edtOggetto.Enabled:=IsModifica;

  // è necessario utilizzare Editable per rendere la textarea scrollabile
  //memTesto.Enabled:=IsModifica;
  memTesto.Editable:=IsModifica;

  chkLetturaObbligatoria.Editable:=IsModifica;

  if Assigned(grdC700) then
  begin
    grdC700.AbilitaToolbar(IsModifica);
  end;

  if imgScegliDestOperatori.Visible then
  begin
    imgScegliDestOperatori.Enabled:=IsModifica;
    imgScegliDestOperatori.ImageFile.FileName:=IfThen(imgScegliDestOperatori.Enabled,fileImgOperatori,fileImgOperatoriDisab);
  end;

  // allegati
  for r:=0 to grdAllegati.RowCount - 1 do
  begin
    if grdAllegati.Cell[r,0].Control <> nil then
    begin
      IWChk:=(grdAllegati.Cell[r,0].Control as TmeIWCheckBox);
      IWChk.Editable:=IsModifica;
      IWChk.Enabled:=IsModifica;
    end;
  end;

  // abilitazione filtri
  chkStatoSospeso.Enabled:=not IsModifica;
  chkStatoInviato.Enabled:=not IsModifica;
  chkStatoCancellato.Enabled:=not IsModifica;
  chkStatoTutti.Enabled:=not IsModifica;
  edtPeriodoDal.Enabled:=not IsModifica;
  edtPeriodoAl.Enabled:=not IsModifica;
  cmbFiltroMittente.Enabled:=not IsModifica;
  cmbFiltroSelezione.Enabled:=not IsModifica;
  edtRicerca.Enabled:=not IsModifica;
  btnFiltra.Enabled:=not IsModifica;
end;

procedure TW035FMessaggistica.ClearMessaggio;
// pulisce il messaggio e l'interfaccia
begin
  if grdMessaggi.medpStato = msBrowse then
  begin
    FMsg.Clear;
    AggiornaUI;
  end;
end;

procedure TW035FMessaggistica.LeggiMessaggio;
// visualizza i dettagli del messaggio nell'interfaccia
var
  i: Integer;
  IsConcatenato: Boolean;
begin
  // pulisce dati messaggio
  FMsg.Clear;

  // valorizza dati
  if (grdMessaggi.medpStato <> msInsert) and
     (selTabella.RecordCount > 0) then
  begin
    FMsg.ID:=selTabella.FieldByName('ID').AsInteger;
    FMsg.Stato:=selTabella.FieldByName('STATO').AsString;
    FMsg.DataInvio:=selTabella.FieldByName('DATA_INVIO').AsDateTime;
    if Modalita = TModalitaGestione.Invio then
      FMsg.IDOriginale:=selTabella.FieldByName('ID_ORIGINALE').AsInteger;
    if grdMessaggi.medpStato = msBrowse then
    begin
      FMsg.Oggetto:=selTabella.FieldByName('OGGETTO').AsString;
      FMsg.Testo:=selTabella.FieldByName('TESTO').AsString;
      FMsg.LetturaObbligatoria:=selTabella.FieldByName('LETTURA_OBBLIGATORIA').AsString;
      FMsg.Modificato:=False;

      // destinatari
      if FModalita = TModalitaGestione.Invio then
      begin
        FMsg.DestLetti:=selTabella.FieldByName('D_DEST_LETTI').AsInteger;
        FMsg.DestRicevuti:=selTabella.FieldByName('D_DEST_RICEVUTI').AsInteger;
        FMsg.DestTot:=selTabella.FieldByName('D_DEST_TOT').AsInteger;
        FMsg.SelezioneAnagrafica:=selTabella.FieldByName('SELEZIONE_ANAGRAFICA').AsString;
        FMsg.ClearDestinatari;

        // destinatari web
        W035DM.selT284.First;
        while not W035DM.selT284.Eof do
        begin
          FMsg.AddDestinatario(W035DM.selT284.FieldByName('PROGRESSIVO').AsInteger,
                               W035DM.selT284.FieldByName('MATRICOLA').AsString,
                               W035DM.selT284.FieldByName('COGNOME').AsString,
                               W035DM.selT284.FieldByName('NOME').AsString,
                               W035DM.selT284.FieldByName('DATA_LETTURA').AsDateTime,
                               W035DM.selT284.FieldByName('DATA_RICEZIONE').AsDateTime);
          W035DM.selT284.Next;
        end;

        // destinatari win
        FMsg.ClearDestinatariOperatori;
        W035DM.selT285.First;
        while not W035DM.selT285.Eof do
        begin
          FMsg.AddDestinatarioOperatore(W035DM.selT285.FieldByName('UTENTE').AsString,
                                        W035DM.selT285.FieldByName('DATA_LETTURA').AsDateTime,
                                        W035DM.selT285.FieldByName('DATA_RICEZIONE').AsDateTime);
          W035DM.selT285.Next;
        end;
      end;
      FMsg.DestModificati:=False;

      // elenco allegati
      FMsg.ClearAllegati;
      W035DM.selT283.First;
      while not W035DM.selT283.Eof do
      begin
        FMsg.AddAllegato(FLAG_ALLEG_SALVATO,
                         W035DM.selT283.FieldByName('NOME').AsString,
                         W035DM.selT283.FieldByName('DIMENSIONE').AsLargeInt);
        W035DM.selT283.Next;
      end;

      // copia l'array in un array parallelo per successivi confronti
      SetLength(FMsg.FAllegatiCopyArr,Length(FMsg.AllegatiArr));
      for i:=0 to High(FMsg.AllegatiCopyArr) do
      begin
        // copymemory non sicura per via degli oggetti string nell'array
        //CopyMemory(@Msg.AllegatiCopyArr[i],@Msg.AllegatiArr[i],SizeOf(TAllegato));
        FMsg.AllegatiCopyArr[i].Flag:=FMsg.AllegatiArr[i].Flag;
        FMsg.AllegatiCopyArr[i].NomeFile:=FMsg.AllegatiArr[i].NomeFile;
        FMsg.AllegatiCopyArr[i].ExtFile:=FMsg.AllegatiArr[i].ExtFile;
        FMsg.AllegatiCopyArr[i].DimFile:=FMsg.AllegatiArr[i].DimFile;
        FMsg.AllegatiCopyArr[i].DimFileStr:=FMsg.AllegatiArr[i].DimFileStr;
      end;
    end;
  end;

  // aggiorna interfaccia
  AggiornaUI;

  // pulsante di storico messaggi
  IsConcatenato:=(not selTabella.FieldByName('ID_ORIGINALE').IsNull) or
                 (selTabella.FieldByName('D_RISPOSTE_TOT').AsInteger > 0);
  btnStorico.Visible:=(Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and
                      (grdMessaggi.medpStato = msBrowse) and
                      (IsConcatenato);
end;

procedure TW035FMessaggistica.EspandiDettaglio;
// espande il div del dettaglio messaggio
var
  Js: String;
begin
  Js:=Format('try { jQuery.root.find("#%s").accordion("option","active",0); } catch(e) {}',[ID_DETTAGLIO]);
  if GGetWebApplicationThreadVar.IsCallBack then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Js)
  else
    AddToInitProc(Js);
end;

// procedura non utilizzata
//procedure TW035FMessaggistica.RiduciDettaglio;
//// espande il div del dettaglio messaggio
//var
//  Js: String;
//begin
//  Js:=Format('try { jQuery.root.find("#%s").accordion("option","active",false); } catch(e) {}',[ID_DETTAGLIO]);
//  if GGetWebApplicationThreadVar.IsCallBack then
//    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Js)
//  else
//    AddToInitProc(Js);
//end;

function TW035FMessaggistica.GetNewID: Integer;
// estrae un nuovo ID messaggio dalla sequence oracle
begin
  W035DM.selT282ID.Execute;
  Result:=W035DM.selT282ID.FieldAsInteger(0);
end;

function TW035FMessaggistica.SuperoQuotaAllegati(const PDimensioneByte: Integer): Boolean;
var
  LDimensioneMB: real;
begin
  LDimensioneMB:=PDimensioneByte / 1024 / 1024;
  Result:=Trunc(LDimensioneMB) > FParQuotaAllegatiMB;
end;

function TW035FMessaggistica.CtrlMessaggio(const PAzione: String): TResCtrl;
// controlla il messaggio
// restituisce
//   True  se i controlli sono ok
//   False se i controlli non sono andati a buon fine
// parametri
//   PAzione: azione in fase di esecuzione
//     AZIONE_SALVA = salva
//     AZIONE_INVIA = invia
//   @ErrMsg
//     stringa di errore nel caso i controlli non siano andati a buon fine
var
  i: Integer;
  LLenOrig: Integer;
  LLenAttuale: Integer;
  LQuotaUsata: Integer;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // determina se il messaggio è una risposta ad un altro messaggio
  if FModalitaRisposta then
  begin
    // messaggio di risposta
    FMsg.IDOriginale:=StrToInt(edtIDOriginale.Text);
  end
  else
  begin
    // messaggio normale
    FMsg.IDOriginale:=0;
  end;

  // oggetto: richiesto obbligatoriamente
  FMsg.Oggetto:=Trim(edtOggetto.Text);
  if FMsg.Oggetto = '' then
  begin
    Result.Messaggio:=A000TraduzioneStringhe(A000MSG_W035_MSG_CTRL_OGGETTO);
    Exit;
  end;

  // testo: nessun controllo
  FMsg.Testo:=Trim(memTesto.Text);
  if (FModalitaRisposta) and (FMsg.Testo = '') then
  begin
    Result.Messaggio:=A000TraduzioneStringhe(A000MSG_W035_MSG_CTRL_TESTO);
    Exit;
  end;

  // flag lettura obbligatoria: nessun controllo
  FMsg.LetturaObbligatoria:=IfThen(chkLetturaObbligatoria.Checked,'S','N');

  // selezione anagrafica: nessun controllo
  FMsg.SelezioneAnagrafica:=edtSelezione.Text;

  // destinatari: obbligatori se azione = invio
  if PAzione = AZIONE_INVIA then
  begin
    if Length(FMsg.DestArr) + Length(FMsg.DestOperatoreArr) = 0 then
    begin
      Result.Messaggio:=A000TraduzioneStringhe(A000MSG_W035_MSG_CTRL_DESTINATARI);
      Exit;
    end;
  end;

  // allegati: determina se sono stati modificati
  FMsg.AllegModificati:=False;
  LLenAttuale:=Length(FMsg.AllegatiArr);
  LLenOrig:=Length(FMsg.AllegatiCopyArr);
  if LLenAttuale > LLenOrig then
  begin
    // sono stati aggiunti allegati
    // se almeno uno è confermato allora indica che è avvenuta una modifica
    for i:=LLenOrig to LLenAttuale - 1 do
    begin
      if FMsg.AllegatiArr[i].Flag = FLAG_ALLEG_NUOVO then
      begin
        FMsg.AllegModificati:=True;
        Break;
      end;
    end;
  end
  else
  begin
    // nessun allegato aggiunto
    // se uno degli allegati originali è stato flaggato per la cancellazione
    // allora indica che è avvenuta una modifica
    for i:=0 to LLenAttuale - 1 do
    begin
      if FMsg.AllegatiArr[i].Flag = FLAG_ALLEG_CANC_SALVATO then
      begin
        FMsg.AllegModificati:=True;
        Break;
      end;
    end;
  end;

  // controllo quota allegati
  if FParQuotaAllegatiMB > -1 then
  begin
    if (FMsg.AllegModificati) or (FMsg.EditAsNew) then
    begin
      // aggiorna la quota utilizzata dai messaggi salvati / inviati
      FQuotaAllegatiUsata:=GetQuotaAllegatiUsata;

      // verifica supero quota
      LQuotaUsata:=FQuotaAllegatiUsata + FMsg.DimTotAllegati;
      if SuperoQuotaAllegati(LQuotaUsata) then
      begin
        Result.Messaggio:=A000TraduzioneStringhe(A000MSG_W035_MSG_QUOTA_ALLEGATI_SUPERATA);
        Exit;
      end;
    end;
  end;

  // controlli ok
  Result.Ok:=True;
end;

function TW035FMessaggistica.DoSalvaMessaggio: TResCtrl;
// salva il messaggio nella tabella T282
var
  i, OldID: Integer;
  Blob: TLOBLocator;
  Flag, NomeFile, FilePath: String;
  DimFile: Int64;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  OldID:=-1;
  try
    // dati del messaggio
    if ((grdMessaggi.medpStato = msInsert) or
        (FMsg.EditAsNew))  then
    begin
      // inserimento nuovo messaggio oppure modifica di un messaggio già inviato
      OldID:=FMsg.ID;
      selTabella.Append;
      FMsg.ID:=GetNewID;
      FMsg.Stato:=STATO_MSG_SOSPESO;
      selTabella.FieldByName('ID').AsInteger:=FMsg.ID;
      selTabella.FieldByName('STATO').AsString:=FMsg.Stato;
      selTabella.FieldByName('MITTENTE').AsString:=Parametri.Operatore;
      if FModalitaRisposta then
        selTabella.FieldByName('ID_ORIGINALE').AsInteger:=FMsg.IDOriginale;
    end
    else
    begin
      selTabella.Edit;
    end;
    selTabella.FieldByName('OGGETTO').AsString:=FMsg.Oggetto;
    selTabella.FieldByName('TESTO').AsString:=FMsg.Testo;
    selTabella.FieldByName('LETTURA_OBBLIGATORIA').AsString:=FMsg.LetturaObbligatoria;
    selTabella.FieldByName('SELEZIONE_ANAGRAFICA').AsString:=FMsg.SelezioneAnagrafica;
    selTabella.Post;

    // destinatari messaggio
    if (FMsg.DestModificati) or (FMsg.EditAsNew) then
    begin
      // 1. elimina destinatari che non hanno ancora ricevuto il messaggio
      //    solo in caso di modifica
      if grdMessaggi.medpStato = msEdit then
      begin
        // se si sta modificando un messaggio già inviato
        // allora cancella i destinatari sul vecchio messaggio

        // 1a. cancella destinatari web
        if FMsg.EditAsNew then
          W035DM.delT284.SetVariable('ID',OldID)
        else
          W035DM.delT284.SetVariable('ID',FMsg.ID);
        W035DM.delT284.Execute;

        // 1b. cancella destinatari win
        if FMsg.EditAsNew then
          W035DM.delT285.SetVariable('ID',OldID)
        else
          W035DM.delT285.SetVariable('ID',FMsg.ID);
        W035DM.delT285.Execute;
      end;

      // 2a. inserisce destinatari web
      if Length(FMsg.DestArr) > 0 then
      begin
        W035DM.selT284.Close;
        W035DM.selT284.Open;
        for i:=0 to High(FMsg.DestArr) do
        begin
          // il progressivo potrebbe già essere presente
          // se il messaggio è in edit ed è già stato ricevuto
          if not W035DM.selT284.SearchRecord('PROGRESSIVO',FMsg.DestArr[i].Progressivo,[srFromBeginning]) then
          begin
            W035DM.selT284.Append;
            W035DM.selT284.FieldByName('ID').AsInteger:=FMsg.ID;
            W035DM.selT284.FieldByName('PROGRESSIVO').AsInteger:=FMsg.DestArr[i].Progressivo;
            W035DM.selT284.Post;
          end;
        end;
      end;

      // 2b. inserisce destinatari win (operatori)
      if Length(FMsg.DestOperatoreArr) > 0 then
      begin
        W035DM.selT285.Close;
        W035DM.selT285.Open;
        for i:=0 to High(FMsg.DestOperatoreArr) do
        begin
          // il progressivo potrebbe già essere presente
          // se il messaggio è in edit ed è già stato ricevuto
          if not W035DM.selT285.SearchRecord('UTENTE',FMsg.DestOperatoreArr[i].Utente,[srFromBeginning]) then
          begin
            W035DM.selT285.Append;
            W035DM.selT285.FieldByName('ID').AsInteger:=FMsg.ID;
            W035DM.selT285.FieldByName('UTENTE').AsString:=FMsg.DestOperatoreArr[i].Utente;
            W035DM.selT285.Post;
          end;
        end;
      end;
    end;

    // allegati messaggio
    if (FMsg.AllegModificati) or (FMsg.EditAsNew) then
    begin
      Blob:=TLOBLocator.CreateTemporary(SessioneOracle,otBLOB,True);
      try
        // imposta ID
        W035DM.insT283.SetVariable('ID',FMsg.ID);
        W035DM.delT283.SetVariable('ID',FMsg.ID);
        if FMsg.EditAsNew then
        begin
          W035DM.insT283Dup.SetVariable('ID_OLD',OldID);
          W035DM.insT283Dup.SetVariable('ID_NEW',FMsg.ID);
        end;

        // ciclo sugli allegati
        for i:=0 to High(FMsg.AllegatiArr) do
        begin
          NomeFile:=FMsg.AllegatiArr[i].NomeFile;
          Flag:=FMsg.AllegatiArr[i].Flag;
          if Flag = FLAG_ALLEG_NUOVO then
          begin
            // nuovo allegato
            // 1. carica il file in un TLobLocator
            FilePath:=GGetWebApplicationThreadVar.UserCacheDir + NomeFile;
            DimFile:=R180GetFileSize(FilePath);
            Blob.LoadFromFile(FilePath);
            // 2. salva il file nel campo BLOB
            W035DM.insT283.SetVariable('NOME',NomeFile);
            W035DM.insT283.SetComplexVariable('ALLEGATO',Blob);
            W035DM.insT283.SetVariable('DIMENSIONE',DimFile);
            W035DM.insT283.Execute;
            // 3. elimina il file dal file system
            DeleteFile(FilePath);
          end
          else if Flag = FLAG_ALLEG_CANC_SALVATO then
          begin
            // allegato da cancellare
            if not FMsg.EditAsNew then
            begin
              // elimina il record corrispondente
              W035DM.delT283.SetVariable('NOME',NomeFile);
              W035DM.delT283.Execute;
            end;
          end
          else if Flag = FLAG_ALLEG_SALVATO then
          begin
            if FMsg.EditAsNew then
            begin
              // carica l'allegato sul nuovo messaggio
              W035DM.insT283Dup.SetVariable('NOME',NomeFile);
              W035DM.insT283Dup.Execute;
            end;
          end;
        end;
      finally
        Blob.Free;
      end;
    end;

    // operazione terminata con successo
    SessioneOracle.Commit;
    Result.Ok:=True;
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_W035_ERR_SALVA),[E.Message]);
      //Eseguo rollback solo se la sessione db è usata solo da me
      if SessioneOracle.Tag = 1 then
        SessioneOracle.Rollback
      else
        SessioneOracle.Commit;
      Exit;
    end;
  end;
end;

function TW035FMessaggistica.DoInviaMessaggio(const PNotifica: Boolean): TResCtrl;
// effettua l'invio del messaggio ai destinatari
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  try
    // invio messaggio
    FMsg.Stato:=STATO_MSG_INVIATO;
    FMsg.DataInvio:=Now;
    selTabella.Edit;
    selTabella.FieldByName('STATO').AsString:=FMsg.Stato;
    selTabella.FieldByName('DATA_INVIO').AsDateTime:=FMsg.DataInvio;
    selTabella.Post;

    // operazione terminata con successo
    SessioneOracle.Commit;
    Result.Ok:=True;

    if PNotifica then
      Notifica('Messaggio inviato','Il messaggio è stato inviato','../img/mail-icon-ok.png',True,False,DURATA_NOTIFICA);
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_W035_ERR_INVIO),[E.Message]);
      //Eseguo rollback solo se la sessione db è usata solo da me
      if SessioneOracle.Tag = 1 then
        SessioneOracle.Rollback
      else
        SessioneOracle.Commit;
      Exit;
    end;
  end;
end;

function TW035FMessaggistica.DoCancellaMessaggio(const PNotifica: Boolean): TResCtrl;
// cancellazione del messaggio
//   vengono valutate diverse casistiche
var
  LEliminaAllegati: Boolean;
  LTestoAllegatiRimossi: string;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  try
    if (FMsg.Stato = STATO_MSG_SOSPESO) or
       (FMsg.StatoRicezione = TStatoRicezione.NonRicevuto) or
       (Parametri.CampiRiferimento.C90_W035ModalitaCancMessaggiInviati = C90_W035MODALITACANCMESSAGGIINVIATI_TUTTO) then
    begin
      // prepara log cancellazione
      RegistraLog.SettaProprieta('C','T282_MESSAGGI',medpCodiceForm,grdMessaggi.medpDataSet,True);

      // eliminazione fisica del messaggio - nei seguenti casi:
      //   se il messaggio è sospeso, oppure
      //   se non è ancora stato ricevuto da nessuno, oppure
      //   se è prevista l'eliminazione di messaggi inviati (con o senza allegati)
      grdMessaggi.medpCancella;

      // scrive log cancellazione
      RegistraLog.RegistraOperazione;

      SessioneOracle.Commit;
      Result.Ok:=True;
      if PNotifica then
        Notifica(A000TraduzioneStringhe(A000MSG_W035_MSG_ELIMINATO_HEAD),A000TraduzioneStringhe(A000MSG_W035_MSG_ELIMINATO),'../img/mail-icon-remove.png',False,False,DURATA_NOTIFICA);
    end
    else
    begin
      // verifica tipo di eliminazione
      // - eliminazione logica messaggio
      // - eliminazione fisica dei soli allegati
      LEliminaAllegati:=(FMsg.TotAllegati > 0) and
                        (Parametri.CampiRiferimento.C90_W035ModalitaCancMessaggiInviati = C90_W035MODALITACANCMESSAGGIINVIATI_ALLEGATI);

      // 1. elimina i destinatari che non hanno ancora ricevuto il messaggio
      W035DM.delT284.SetVariable('ID',FMsg.ID);
      W035DM.delT284.Execute;

      // 2. eliminazione specifica in base all'operazione
      if LEliminaAllegati then
      begin
        // elimina gli allegati
        W035DM.delT283Tutti.SetVariable('ID',FMsg.ID);
        W035DM.delT283Tutti.Execute;

        // indica nel testo che gli allegati sono stati rimossi
        LTestoAllegatiRimossi:=Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_TESTO_ALLEG_ELIMINATI),[Parametri.Operatore,DateTimeToStr(Now)]);
        selTabella.Edit;
        selTabella.FieldByName('TESTO').AsString:=LTestoAllegatiRimossi + #13#10 + selTabella.FieldByName('TESTO').AsString;
        selTabella.Post;

        // log cancellazione allegati (riporta i nomi degli allegati eliminati)
        if W035DM.selT283.RecordCount > 0 then
        begin
          W035DM.selT283.First;
          while not W035DM.selT283.Eof do
          begin
            RegistraLog.SettaProprieta('C','T283_ALLEGATI',medpCodiceForm,nil,True);
            RegistraLog.InserisciDato('ID',FMsg.Id.ToString,'');
            RegistraLog.InserisciDato('NOME',W035DM.selT283.FieldByName('NOME').AsString,'');
            RegistraLog.InserisciDato('DIMENSIONE',W035DM.selT283.FieldByName('DIMENSIONE').AsString,'');
            RegistraLog.RegistraOperazione;
            W035DM.selT283.Next;
          end;
        end;

        if PNotifica then
          Notifica(A000TraduzioneStringhe(A000MSG_W035_MSG_ALLEG_ELIMINATI_HEAD),A000TraduzioneStringhe(A000MSG_W035_MSG_ALLEG_ELIMINATI),'../img/mail-attachment-deleted.png',False,False,DURATA_NOTIFICA);
      end
      else
      begin
        // imposta lo stato del messaggio a STATO_MSG_CANCELLATO
        selTabella.Edit;
        selTabella.FieldByName('STATO').AsString:=STATO_MSG_CANCELLATO;
        selTabella.Post;

        // log cancellazione logica messaggio
        RegistraLog.SettaProprieta('M','T282_MESSAGGI',medpCodiceForm,nil,True);
        RegistraLog.InserisciDato('ID',FMsg.Id.ToString,'');
        RegistraLog.InserisciDato('STATO',FMsg.Stato,STATO_MSG_CANCELLATO);
        RegistraLog.RegistraOperazione;

        if PNotifica then
          Notifica(A000TraduzioneStringhe(A000MSG_W035_MSG_ELIMINATO_HEAD),A000TraduzioneStringhe(A000MSG_W035_MSG_SEGNA_CANC),'../img/mail-icon-remove.png',False,False,DURATA_NOTIFICA);
      end;

      // operazione terminata con successo
      SessioneOracle.Commit;
      Result.Ok:=True;
    end;
  except
    on E: Exception do
    begin
      //Eseguo rollback solo se la sessione db è usata solo da me
      if SessioneOracle.Tag = 1 then
        SessioneOracle.Rollback
      else
        SessioneOracle.Commit;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

procedure TW035FMessaggistica.VisualizzaInvio(const FN: String; const PShow: Boolean);
// solo in modalità invio
// consente di visualizzare o nascondere l'immagine legata all'azione di invio messaggio
var
  r: Integer;
  IWC: TIWCustomControl;
begin
  // determina riga della struttura
  r:=grdMessaggi.medpRigaDiCompGriglia(FN);

  // estrae il puntatore all'immagine e se valido ne determina la visibilità
  if (grdMessaggi.medpRigaInserimento) and (r = 0) then
  begin
    // riga di inserimento: icona di conferma + invio
    IWC:=grdMessaggi.medpCompCella(r,iImgSalvaInvia,jImgSalvaInvia);
  end
  else
  begin
    // riga di modifica: icona di invio
    IWC:=grdMessaggi.medpCompCella(r,iImgInvia,jImgInvia);
  end;
  if Assigned(IWC) then
    IWC.Css:=IfThen(PShow,'','invisibile');
end;

procedure TW035FMessaggistica.CtrlImpostaStatoRicezione(EventParams: TStringList);
// imposta lo stato di ricezione del messaggio a "ricevuto"
var
  LResCtrl: TResCtrl;
  LCookieDett: String;
  LDettAperto: Boolean;
  r: Integer;
  IWChk: TmeIWCheckBox;
begin
  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    // il richiamo è effettuato quando si espande il dettaglio
    LDettAperto:=True;
  end
  else
  begin
    // determina l'apertura del dettaglio in base al cookie oppure al parametro aziendale
    LCookieDett:=GGetWebApplicationThreadVar.Request.CookieFields.Values[FCookieDettName];
    if (LCookieDett = '') and (Parametri.CampiRiferimento.C90_MessaggisticaApriDettaglio = 'S') then
      LDettAperto:=True
    else
      LDettAperto:=StrToIntDef(LCookieDett,-1) >= 0;
  end;

  // in modalità messaggi ricevuti, se il dettaglio del messaggio è visualizzato
  //e la data di ricezione è nulla, la imposta
  if (Modalita = TModalitaGestione.Lettura) and
     (LDettAperto) and
     (selTabella.Active) and
     (selTabella.RecordCount > 0) and
     (selTabella.FieldByName('DATA_RICEZIONE').IsNull) then
  begin
    LResCtrl:=ImpostaStatoRicezione;
    if LResCtrl.Ok then
    begin
      // il flag di lettura del messaggio dipende dalla presenza di DATA_RICEZIONE
      // abilita il check in quanto il messaggio è stato "ricevuto" (il dettaglio è stato espanso)
      r:=grdMessaggi.medpRigaDiCompGriglia(selTabella.RowId);
      IWChk:=(grdMessaggi.medpCompCella(r,iChkLetto,jChkLetto) as TmeIWCheckBox);
      IWChk.Enabled:=True;
      IWChk.Hint:='';
    end
    else
    begin
      // errore nell'impostazione dello stato ricezione
      GGetWebApplicationThreadVar.ShowMessage(LResCtrl.Messaggio);
    end;
  end;
end;

function TW035FMessaggistica.ImpostaStatoRicezione: TResCtrl;
// imposta lo stato di ricezione del messaggio a "ricevuto"
var
  updQuery: TOracleQuery;
begin
  // DATA_RICEZIONE is null     -> messaggio da ricevere
  // DATA_RICEZIONE is not null -> messaggio già ricevuto
  if selTabella.FieldByName('DATA_RICEZIONE').IsNull then
  begin
    Result.Ok:=False;
    Result.Messaggio:='';

    // nel contesto della messaggistica, l'utente web non associato
    // ad una matricola è considerato come un operatore
    if IsUserOperatore then
    begin
      // aggiorna la data di ricezione sull'utente selezionato
      updQuery:=W035DM.updT285Ricezione;
      updQuery.SetVariable('UTENTE',selTabella.FieldByName('UTENTE').AsString);
    end
    else
    begin
      // aggiorna la data di ricezione sul progressivo selezionato
      updQuery:=W035DM.updT284Ricezione;
      updQuery.SetVariable('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger);
    end;

    // aggiorna data ricezione
    updQuery.SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
    updQuery.SetVariable('DATA_RICEZIONE',Now);
    try
      updQuery.Execute;
      // operazione terminata con successo
      SessioneOracle.Commit;
      selTabella.RefreshRecord;
      Result.Ok:=True;
    except
      on E: Exception do
      begin
        //Eseguo rollback solo se la sessione db è usata solo da me
        if SessioneOracle.Tag = 1 then
          SessioneOracle.Rollback
        else
          SessioneOracle.Commit;
        Result.Messaggio:=E.Message;
      end;
    end;
  end
  else
  begin
    // il messaggio è già stato contrassegnato come ricevuto
    Result.Ok:=True;
    Result.Messaggio:='';
  end;
end;

function TW035FMessaggistica.ImpostaStatoLettura(const PLetto: Boolean): TResCtrl;
// segna il messaggio come letto / da leggere
var
  updQuery: TOracleQuery;
begin
  // DATA_LETTURA is null     -> messaggio da leggere
  // DATA_LETTURA is not null -> messaggio già letto

  Result.Ok:=False;
  Result.Messaggio:='';

  // nel contesto della messaggistica, l'utente web non associato
  // ad una matricola è considerato come un operatore
  if IsUserOperatore then
  begin
    // aggiorna la data di lettura sull'utente selezionato
    updQuery:=W035DM.updT285Lettura;
    updQuery.SetVariable('UTENTE',selTabella.FieldByName('UTENTE').AsString);
  end
  else
  begin
    // aggiorna la data di lettura sul progressivo selezionato
    updQuery:=W035DM.updT284Lettura;
    updQuery.SetVariable('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger);
  end;
  updQuery.SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
  if PLetto then
    updQuery.SetVariable('DATA_LETTURA',Now)
  else
    updQuery.SetVariable('DATA_LETTURA',null);
  try
    updQuery.Execute;
    // operazione terminata con successo
    SessioneOracle.Commit;
    selTabella.RefreshRecord; //*** sarebbe utile, ma non viene eseguita correttamente

    Result.Ok:=True;
  except
    on E: Exception do
    begin
      //Eseguo rollback solo se la sessione db è usata solo da me
      if SessioneOracle.Tag = 1 then
        SessioneOracle.Rollback
      else
        SessioneOracle.Commit;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

procedure TW035FMessaggistica.imgLetturaAsyncClick(Sender: TObject; EventParams: TStringList);
// immagine di azione "segna come letto / da leggere"
var
  LResCtrl: TResCtrl;
  FN: String;
  LLetto: Boolean;
begin
  FN:=(Sender as TmeIWCheckBox).FriendlyName;
  LLetto:=(Sender as TmeIWCheckBox).Checked;
  grdMessaggi.medpColumnClick(Sender,FN);

  // segna il messaggio come letto / da leggere
  LResCtrl:=ImpostaStatoLettura(LLetto);
  if not LResCtrl.Ok then
  begin
    GGetWebApplicationThreadVar.ShowMessage(LResCtrl.Messaggio);
    Exit;
  end;

  // aggiornamento interfaccia necessario
  AggiornaUI;
end;

procedure TW035FMessaggistica.edtRiceventeAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //
end;

procedure TW035FMessaggistica.edtRiceventeSubmit(Sender: TObject);
// input per il nome del ricevente: sul submit
var
  FN, Ricevente: String;
begin
  FN:=(Sender as TmeIWEdit).FriendlyName;
  Ricevente:=Trim((Sender as TmeIWEdit).Text);

  grdMessaggi.medpColumnClick(Sender,FN);

  if Ricevente <> selTabella.FieldByName('RICEVENTE').AsString then
  begin
    // aggiornamento
    try
      selTabella.Edit;
      selTabella.FieldByName('RICEVENTE').AsString:=Ricevente;
      selTabella.Post;
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(Format(A000MSG_W035_ERR_FMT_SALVA_RICEVENTE,[E.Message]),ESCLAMA);
        selTabella.Cancel;
        SessioneOracle.Commit;
      end;
    end;
  end;
end;

procedure TW035FMessaggistica.imgInviaClick(Sender: TObject);
// immagine di azione invio messaggio
var
  FN: String;
  LResCtrl: TResCtrl;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdMessaggi.medpColumnClick(Sender,FN);

  // controllo dei dati per l'invio
  LResCtrl:=CtrlMessaggio(AZIONE_INVIA);
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
    Exit;
  end;

  // invia il messaggio ai destinatari (modifica lo stato e la data invio)
  LResCtrl:=DoInviaMessaggio(True);
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
    Exit;
  end;

  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.imgConfermaInviaClick(Sender: TObject);
var
  FN: String;
  LResCtrl: TResCtrl;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdMessaggi.medpColumnClick(Sender,FN);

  // controllo dei dati per l'invio
  LResCtrl:=CtrlMessaggio(AZIONE_INVIA);
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
    Exit;
  end;

  // salva il messaggio su db
  LResCtrl:=DoSalvaMessaggio;
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
    Exit;
  end;

  // invia il messaggio ai destinatari (modifica lo stato e la data invio)
  LResCtrl:=DoInviaMessaggio(True);
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
    Exit;
  end;

  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.btnRispondiClick(Sender: TObject);
var
  OldMittente,OldDescMittente,OldOggetto: String;
  OldId: Integer;
  IWC: TIWCustomControl;
  IWImg: TmeIWImageFile;
  DestWeb: Boolean;
  DestProg: Integer;
  DestMatr: String;
  DestCognome: String;
  DestNome: string;
begin
  // salva i dati per la risposta in variabili di appoggio
  OldMittente:=selTabella.FieldByName('MITTENTE').AsString;
  OldDescMittente:=selTabella.FieldByName('D_MITTENTE').AsString;
  OldId:=selTabella.FieldByName('ID').AsInteger;
  OldOggetto:=selTabella.FieldByName('OGGETTO').AsString;

  // modalità invio
  tabMessaggi.ActiveTabIndex:=TAB_IDX_INVIO;
  FModalitaRisposta:=True;

  // simula inserimento nuovo messaggio
  if grdMessaggi.medpRigaInserimento then
  begin
    IWC:=grdMessaggi.medpCompCella(0,0,0);
    if (Assigned(IWC)) and
       (IWC is TmeIWImageFile) then
    begin
      IWImg:=(IWC as TmeIWImageFile);
      if Assigned(@IWImg.OnClick) then
      begin
        IWImg.OnClick(IWImg);
      end;
    end;
  end;

  // imposta i dati per la risposta
  edtIDOriginale.Text:=IntToStr(OldId);
  if UpperCase(LeftStr(OldOggetto,Length(PREFISSO_OGGETTO_RISPOSTA))) = UpperCase(PREFISSO_OGGETTO_RISPOSTA) then
    edtOggetto.Text:=OldOggetto
  else
    edtOggetto.Text:=PREFISSO_OGGETTO_RISPOSTA + OldOggetto;

  // destinatario: è il mittente del messaggio originale
  // verifica se si tratta di utente web o di operatore win
  DestWeb:=False;
  DestProg:=0;
  DestMatr:='';
  DestCognome:='';
  DestNome:='';
  try
    //SetVariable('UTENTE',OldMittente);
    R180SetVariable(W035DM.selI060,'UTENTE',OldMittente);
    W035DM.selI060.Open;
    if W035DM.selI060.RecordCount > 0 then
    begin
      DestWeb:=True;
      DestProg:=W035DM.selI060.FieldByName('PROGRESSIVO').AsInteger;
      DestMatr:=W035DM.selI060.FieldByName('MATRICOLA').AsString;
      DestCognome:=W035DM.selI060.FieldByName('COGNOME').AsString;
      DestNome:=W035DM.selI060.FieldByName('NOME').AsString;
    end;
  except
  end;

  if DestWeb then
    FMsg.AddDestinatario(DestProg,DestMatr,DestCognome,DestNome,DATE_NULL,DATE_NULL)
  else
    FMsg.AddDestinatarioOperatore(OldMittente,DATE_NULL,DATE_NULL);
  FMsg.DestModificati:=True;

  // aggiorna interfaccia
  edtSelezione.Text:='';
  edtDestinatari.Text:=Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_DESTINATARI_SEL),[1,1]);
  AggiornaDestinatari;

  memTesto.SetFocus;
end;

procedure TW035FMessaggistica.btnDestinatariClick(Sender: TObject);
// visualizza dettaglio destinatari
begin
  rgnDestinatari.Visible:=True;
  VisualizzajQMessaggio(jqDestinatari,650,-1,-1,'Elenco destinatari','#' + rgnDestinatari.HTMLName,True,True,-1,'','',btnChiudiDest.HTMLName);
end;

procedure TW035FMessaggistica.btnChiudiDestClick(Sender: TObject);
// chiusura del dialog dei destinatari
begin
  rgnDestinatari.Visible:=False;
  jqDestinatari.OnReady.Clear;
end;

procedure TW035FMessaggistica.btnStoricoClick(Sender: TObject);
// PRE: la catena esiste
var
  Titolo: String;
begin
  // apre dataset per elenco messaggi legati all'id iniziale
  // (utilizza connect by prior)
  W035DM.selElencoMsg.Close;
  W035DM.selElencoMsg.SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
  W035DM.selElencoMsg.Open;

  // aggiorna tabella di elenco messaggi
  // seleziona il messaggio corrente nella tabella
  grdElenco.medpCaricaCDS(selTabella.FieldByName('ID').AsString);

  // visualizza region e attiva dialog jquery ui
  rgnElenco.Visible:=True;
  Titolo:='Storico: ' + VarToStr(W035DM.selElencoMsg.Lookup('LEVEL',1,'OGGETTO'));
  VisualizzajQMessaggio(jqElenco,650,-1,-1,Titolo,'#' + rgnElenco.HTMLName,True,True,-1,'','',btnChiudiElenco.HTMLName);
end;

procedure TW035FMessaggistica.btnChiudiElencoClick(Sender: TObject);
begin
  rgnElenco.Visible:=False;
  jqElenco.OnReady.Clear;
end;

procedure TW035FMessaggistica.btnFiltraClick(Sender: TObject);
// aggiornamento visualizzazione
begin
  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.InizializzaFiltriModalita;
// inizializza i filtri di selezione messaggi per ogni possibile modalità di visualizzazione
var
  i: Integer;
begin
  for i:=0 to tabMessaggi.TabCount - 1 do
  begin
    // bookmark record selezionato
    FDatiModalitaArr[i].selTabella_Bookmark:=nil;
    // checkbox selezione stato
    FDatiModalitaArr[i].chkStatoSospeso_Checked:=(i = TAB_IDX_INVIO);
    FDatiModalitaArr[i].chkStatoInviato_Checked:=True;
    FDatiModalitaArr[i].chkStatoCancellato_Checked:=False;
    FDatiModalitaArr[i].chkStatoTutti_Checked:=False;
    // periodo invio dal - al
    FDatiModalitaArr[i].edtPeriodoDal_Text:='';
    FDatiModalitaArr[i].edtPeriodoAl_Text:='';

    // in lettura filtra sui messaggi da leggere
    if i = TAB_IDX_LETTURA then
      rgpFiltroDaLeggere.ItemIndex:=ITEM_DA_LEGGERE;

    // filtri selezione anagrafica e mittente
    FDatiModalitaArr[i].cmbFiltroSelezione_ItemIndex:=0;
    FDatiModalitaArr[i].cmbFiltroMittente_ItemIndex:=0;
    // ricerca per oggetto e/o testo
    FDatiModalitaArr[i].edtRicerca_Text:='';
  end;
end;

procedure TW035FMessaggistica.PulisciFiltriModalita;
// ripristina i filtri iniziali
begin
  // checkbox selezione stato
  chkStatoSospeso.Checked:=FModalita = TModalitaGestione.Invio;
  chkStatoInviato.Checked:=True;
  chkStatoCancellato.Checked:=False;
  chkStatoTutti.Checked:=False;

  // periodo invio dal - al
  edtPeriodoDal.Clear;
  edtPeriodoAl.Clear;

  // in lettura filtra sui messaggi da leggere
  if FModalita = TModalitaGestione.Lettura then
    rgpFiltroDaLeggere.ItemIndex:=ITEM_DA_LEGGERE;

  // filtri selezione anagrafica e mittente
  cmbFiltroSelezione.ItemIndex:=0;
  cmbFiltroMittente.ItemIndex:=0;

  // ricerca per oggetto e/o testo
  edtRicerca.Clear;
end;

procedure TW035FMessaggistica.SalvaFiltriModalita;
// salva le impostazioni dei filtri sulla modalità corrente
var
  LIdx: Integer;
begin
  if (tabMessaggi.ActiveTabIndex < Low(FDatiModalitaArr)) or
     (tabMessaggi.ActiveTabIndex > High(FDatiModalitaArr)) then
    Exit;

  // indice corrente
  LIdx:=tabMessaggi.ActiveTabIndex;

  // bookmark record selezionato
  if (Assigned(selTabella)) and (selTabella.Active) and (selTabella.RecordCount > 0) then
    FDatiModalitaArr[LIdx].selTabella_Bookmark:=selTabella.GetBookmark
  else
    FDatiModalitaArr[LIdx].selTabella_Bookmark:=nil;
  // checkbox selezione stato
  FDatiModalitaArr[LIdx].chkStatoSospeso_Checked:=chkStatoSospeso.Checked;
  FDatiModalitaArr[LIdx].chkStatoInviato_Checked:=chkStatoInviato.Checked;
  FDatiModalitaArr[LIdx].chkStatoCancellato_Checked:=chkStatoCancellato.Checked;
  FDatiModalitaArr[LIdx].chkStatoTutti_Checked:=chkStatoTutti.Checked;
  // periodo invio dal - al
  FDatiModalitaArr[LIdx].edtPeriodoDal_Text:=edtPeriodoDal.Text;
  FDatiModalitaArr[LIdx].edtPeriodoAl_Text:=edtPeriodoAl.Text;
  // in lettura filtra sui messaggi da leggere
  FDatiModalitaArr[LIdx].rgpFiltroDaLeggere_ItemIndex:=rgpFiltroDaLeggere.ItemIndex;
  // filtri selezione anagrafica e mittente
  FDatiModalitaArr[LIdx].cmbFiltroSelezione_ItemIndex:=cmbFiltroSelezione.ItemIndex;
  FDatiModalitaArr[LIdx].cmbFiltroMittente_ItemIndex:=cmbFiltroMittente.ItemIndex;
  // ricerca per oggetto e/o testo
  FDatiModalitaArr[LIdx].edtRicerca_Text:=edtRicerca.Text;
end;

procedure TW035FMessaggistica.RipristinaFiltriModalita;
// ripristina le impostazioni dei filtri per la modalità corrente
var
  LDatiMod: TDatiModalita;
begin
  if (tabMessaggi.ActiveTabIndex < Low(FDatiModalitaArr)) or
     (tabMessaggi.ActiveTabIndex > High(FDatiModalitaArr)) then
    Exit;

  LDatiMod:=FDatiModalitaArr[tabMessaggi.ActiveTabIndex];
  // checkbox selezione stato
  chkStatoSospeso.Checked:=LDatiMod.chkStatoSospeso_Checked;
  chkStatoInviato.Checked:=LDatiMod.chkStatoInviato_Checked;
  chkStatoCancellato.Checked:=LDatiMod.chkStatoCancellato_Checked;
  chkStatoTutti.Checked:=LDatiMod.chkStatoTutti_Checked;
  // periodo invio dal - al
  edtPeriodoDal.Text:=LDatiMod.edtPeriodoDal_Text;
  edtPeriodoAl.Text:=LDatiMod.edtPeriodoAl_Text;
  // in lettura filtra sui messaggi da leggere
  rgpFiltroDaLeggere.ItemIndex:=LDatiMod.rgpFiltroDaLeggere_ItemIndex;
  // filtri selezione anagrafica e mittente
  cmbFiltroSelezione.ItemIndex:=LDatiMod.cmbFiltroSelezione_ItemIndex;
  cmbFiltroMittente.ItemIndex:=LDatiMod.cmbFiltroMittente_ItemIndex;
  // ricerca per oggetto e/o testo
  edtRicerca.Text:=LDatiMod.edtRicerca_Text;
end;

procedure TW035FMessaggistica.RipristinaBookmarkModalita;
var
  LDatiMod: TDatiModalita;
begin
  if (tabMessaggi.ActiveTabIndex < Low(FDatiModalitaArr)) or
     (tabMessaggi.ActiveTabIndex > High(FDatiModalitaArr)) then
    Exit;

  // bookmark record selezionato
  LDatiMod:=FDatiModalitaArr[tabMessaggi.ActiveTabIndex];
  if Assigned(LDatiMod.selTabella_Bookmark) and
     (selTabella.BookmarkValid(LDatiMod.selTabella_Bookmark)) then
  begin
    selTabella.GotoBookmark(LDatiMod.selTabella_Bookmark);
    grdMessaggi.medpClientDataSet.Locate('ID',selTabella.FieldByName('ID').AsInteger,[]);
  end;
end;

function TW035FMessaggistica.GetFiltroMessaggi: String;
// restituisce una stringa sql che rappresenta la parte di "where" valorizzata
// in base ai filtri attualmente indicati nell'interfaccia
var
  Cod,Filtro,FiltroPeriodo,FiltroStato: String;
  Inizio, Fine: TDateTime;
begin
  Result:='';

  // filtro periodo di invio
  if chkStatoInviato.Checked then
  begin
    // controllo periodo
    if edtPeriodoDal.Text = '' then
      Inizio:=DATE_MIN
    else
    begin
      if not TryStrToDate(edtPeriodoDal.Text,Inizio) then
        raise ExceptionNoLog.Create(A000MSG_A145_ERR_DATA_INIZIO_PERIODO);
    end;
    if edtPeriodoAl.Text = '' then
      Fine:=DATE_MAX
    else
    begin
      if not TryStrToDate(edtPeriodoAl.Text,Fine) then
        raise ExceptionNoLog.Create(A000MSG_A145_ERR_DATA_FINE_PERIODO);
    end;
    if Inizio > Fine then
      raise Exception.Create('Il periodo di invio non è valido!');

    // impostazione filtro
    if (Inizio = DATE_MIN) and (Fine = DATE_MAX) then
    begin
      // periodo non indicato
      FiltroPeriodo:='';
    end
    else if Inizio = Fine then
    begin
      // periodo di un solo giorno
      FiltroPeriodo:=Format('(trunc(T282.DATA_INVIO) = to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Inizio)]);
    end
    else if Inizio = DATE_MIN then
    begin
      // periodo <= di una data
      FiltroPeriodo:=Format('(trunc(T282.DATA_INVIO) <= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Fine)]);
    end
    else if Fine = DATE_MAX then
    begin
      // periodo >= di una data
      FiltroPeriodo:=Format('(trunc(T282.DATA_INVIO) >= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Inizio)]);
    end
    else
    begin
      // periodo di più giorni compreso fra due date
      FiltroPeriodo:=Format('(trunc(T282.DATA_INVIO) >= to_date(''%s'',''dd/mm/yyyy'') and trunc(T282.DATA_INVIO) <= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Inizio),FormatDateTime('dd/mm/yyyy',Fine)]);
    end;
  end
  else
  begin
    FiltroPeriodo:='';
  end;

  // filtro stato (e periodo invio)
  FiltroStato:='';
  if (not chkStatoTutti.Checked) or (FiltroPeriodo <> '') then
  begin
    // sospesi
    if chkStatoSospeso.Checked then
    begin
      Filtro:=Format('(T282.STATO = ''%s'')',[STATO_MSG_SOSPESO]);
      FiltroStato:=FiltroStato + IfThen(FiltroStato <> '',' or ') + Filtro;
    end;
    // inviati
    if chkStatoInviato.Checked then
    begin
      Filtro:=Format('(T282.STATO = ''%s'')',[STATO_MSG_INVIATO]);
      if FiltroPeriodo <> '' then
        Filtro:=Format('(%s and %s)',[Filtro,FiltroPeriodo]);
      FiltroStato:=FiltroStato + IfThen(FiltroStato <> '',' or ') + Filtro;
    end;
    // cancellati
    if chkStatoCancellato.Checked then
    begin
      Filtro:=Format('(T282.STATO = ''%s'')',[STATO_MSG_CANCELLATO]);
      FiltroStato:=FiltroStato + IfThen(FiltroStato <> '',' or ') + Filtro;
    end;
    FiltroStato:=Format('(%s)',[FiltroStato]);
  end;
  Result:=Result + IfThen((Result <> '') and (FiltroStato <> ''),' and ') + FiltroStato;

  if FModalita = TModalitaGestione.Lettura then
  begin
    // filtro da leggere / letti
    case rgpFiltroDaLeggere.ItemIndex of
      ITEM_DA_LEGGERE: // da leggere (stato = messaggi inviati)
         Filtro:='(T_DEST.DATA_LETTURA is null)';
      ITEM_LETTI:      // già letti  (stato = messaggi inviati)
         Filtro:='(T_DEST.DATA_LETTURA is not null)';
      ITEM_TUTTI:      // tutti      (stato = messaggi inviati + cancellati)
         Filtro:='';
      ITEM_CANCELLATI: // cancellati (stato = messaggi cancellati)
         Filtro:='';
    end;
    Result:=Result + IfThen((Result <> '') and (Filtro <> ''),' and ') + Filtro;

    // filtro mittente
    Cod:=cmbFiltroMittente.Items.ValueFromIndex[cmbFiltroMittente.ItemIndex];
    Filtro:=IfThen(Cod <> '',Format('(T282.MITTENTE = ''%s'')',[AggiungiApice(Cod)]));
    Result:=Result + IfThen((Result <> '') and (Filtro <> ''),' and ') + Filtro;
  end
  else
  begin
    // filtro selezione anagrafica
    Cod:=cmbFiltroSelezione.Text;
    Filtro:=IfThen(Cod <> '',Format('(T282.SELEZIONE_ANAGRAFICA = ''%s'')',[Cod]));
    Result:=Result + IfThen((Result <> '') and (Filtro <> ''),' and ') + Filtro;
  end;

  // ricerca per oggetto / testo (case-insensitive)
  if (Trim(edtRicerca.Text) <> '') and (edtRicerca.Text <> edtRicerca.medpWatermark) then
  begin
    Cod:=UpperCase(AggiungiApice(Trim(edtRicerca.Text)));
    Filtro:=IfThen(Cod <> '',Format('((UPPER(T282.OGGETTO) like ''%%%s%%'') or (UPPER(T282.TESTO) like ''%%%s%%''))',[Cod,Cod]));
    Result:=Result + IfThen((Result <> '') and (Filtro <> ''),' and ') + Filtro;
  end;

  if Result <> '' then
    Result:=Format('and (%s)',[Result]);
end;

procedure TW035FMessaggistica.cmbFiltroMittenteChange(Sender: TObject);
begin
  AggiornaMessaggi(False);
end;

procedure TW035FMessaggistica.cmbFiltroSelezioneChange(Sender: TObject);
begin
  AggiornaMessaggi(False);
end;

procedure TW035FMessaggistica.grdMessaggimedpStatoChange;
begin
  AbilitaUI;
end;

procedure TW035FMessaggistica.grdMessaggiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  LStato: string;
  LDataLetturaStr: string;
  LDataRicezioneStr: String;
  LDataInvioStr: string;
  LDataLettura: TDateTime;
  LDataInvio: TDateTime;
  LRicevuto: Boolean;
  LNumAllegati: Integer;
  LVisMod: Boolean;
  LVisCanc: Boolean;
  LPeriodoCancOk: Boolean;
  LIWImg: TmeIWImageFile;
  LIWChk: TmeIWCheckBox;
  LIWEdt: TmeIWEdit;
begin
  // riga di inserimento
  if grdMessaggi.medpRigaInserimento then
  begin
    if FModalita = TModalitaGestione.Invio then
    begin
      // conferma e invia messaggio: inizialmente nascosto
      LIWImg:=(grdMessaggi.medpCompCella(0,iImgSalvaInvia,jImgSalvaInvia) as TmeIWImageFile);
      LIWImg.OnClick:=imgConfermaInviaClick;
      LIWImg.Css:='invisibile';
    end;
  end;

  // righe dei dati
  for i:=IfThen(grdMessaggi.medpRigaInserimento,1,0) to High(grdMessaggi.medpCompGriglia) do
  begin
    LStato:=grdMessaggi.medpValoreColonna(i,'STATO');
    if FModalita = TModalitaGestione.Lettura then
    begin
      // data lettura in formato stringa
      LDataLetturaStr:=grdMessaggi.medpValoreColonna(i,'DATA_LETTURA');
      if LDataLetturaStr <> '' then
      begin
        if TryStrToDateTime(LDataLetturaStr,LDataLettura) then
          LDataLetturaStr:=FormatDateTime('dd/mm/yyyy hhhh.nn',LDataLettura);
      end;

      // segna come letto / non letto
      LIWChk:=(grdMessaggi.medpCompCella(i,iChkLetto,jChkLetto) as TmeIWCheckBox);
      LIWChk.Caption:=LDataLetturaStr;
      LIWChk.OnAsyncClick:=imgLetturaAsyncClick;
      LIWChk.Checked:=LDataLetturaStr <> '';
      LDataRicezioneStr:=grdMessaggi.medpValoreColonna(i,'DATA_RICEZIONE');
      // abilita il check solo se il messaggio è già stato "ricevuto" (ossia se il dettaglio è stato espanso)
      LIWChk.Enabled:=(LStato = STATO_MSG_INVIATO) and (LDataRicezioneStr <> '');
      LIWChk.Hint:=IfThen(LDataRicezioneStr = '','Espandere il dettaglio messaggio per abilitare questo flag','');

      // ricevente
      if FVisualizzaRicevente then
      begin
        LIWEdt:=(grdMessaggi.medpCompCella(i,iEdtRicevente,jEdtRicevente) as TmeIWEdit);
        LIWEdt.OnAsyncClick:=edtRiceventeAsyncClick;
        LIWEdt.Text:=grdMessaggi.medpValoreColonna(i,'RICEVENTE');
        LIWEdt.OnSubmit:=edtRiceventeSubmit;
      end;
    end
    else
    begin
      // modalità messaggi inviati

      // determina se il messaggio è già stato ricevuto da qualche destinatario
      LRicevuto:=StrToIntDef(grdMessaggi.medpValoreColonna(i,'D_DEST_RICEVUTI'),0) > 0;

      // modifica
      // - consentito se stato <> STATO_MSG_CANCELLATO
      if LStato = STATO_MSG_CANCELLATO then
      begin
        // se il messaggio è cancellato, la modifica è impedita
        LVisMod:=False;
      end
      else if (Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and (LRicevuto) then
      begin
        // nel caso di messaggio già ricevuto la modifica è impedita
        LVisMod:=False;
      end
      else
      begin
        // negli altri casi la cancellazione è consentita
        LVisMod:=True;
      end;
      LIWImg:=(grdMessaggi.medpCompCella(i,0,0) as TmeIWImageFile);
      LIWImg.Css:=IfThen(LVisMod,'','invisibile');
      LIWImg.Hint:='Modifica messaggio';

      // cancella
      if LStato = STATO_MSG_CANCELLATO then
      begin
        // se il messaggio è cancellato, la cancellazione è impedita (non ha senso)
        LVisCanc:=False;
      end
      else if (Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and (LRicevuto) then
      begin
        LNumAllegati:=StrToIntDef(grdMessaggi.medpValoreColonna(i,'D_ALLEGATI'),0);
        // verifica la possibilità di eliminare i messaggi in base alla data di invio
        LDataInvioStr:=grdMessaggi.medpValoreColonna(i,'DATA_INVIO');
        if not TryStrToDateTime(LDataInvioStr,LDataInvio) then
          LVisCanc:=True
        else
        begin
          LPeriodoCancOk:=(FParMesiDopoInvioCancMessaggi = 0) or
                          (Trunc(LDataInvio) <= R180AddMesi(Date,- FParMesiDopoInvioCancMessaggi));
          // nel caso di messaggio già ricevuto valuta il relativo parametro aziendale
          if Parametri.CampiRiferimento.C90_W035ModalitaCancMessaggiInviati = C90_W035MODALITACANCMESSAGGIINVIATI_NO then
            LVisCanc:=False
          else if Parametri.CampiRiferimento.C90_W035ModalitaCancMessaggiInviati = C90_W035MODALITACANCMESSAGGIINVIATI_ALLEGATI then
            LVisCanc:=(LPeriodoCancOk) and (LNumAllegati > 0)
          else if Parametri.CampiRiferimento.C90_W035ModalitaCancMessaggiInviati = C90_W035MODALITACANCMESSAGGIINVIATI_TUTTO then
            LVisCanc:=LPeriodoCancOk
          else
            LVisCanc:=False;
        end;
      end
      else
      begin
        // negli altri casi la cancellazione è consentita
        LVisCanc:=True;
      end;
      LIWImg:=(grdMessaggi.medpCompCella(i,0,1) as TmeIWImageFile);
      LIWImg.Css:=IfThen(LVisCanc,'','invisibile');
      if LVisCanc and (Parametri.CampiRiferimento.C90_W035ModalitaCancMessaggiInviati = C90_W035MODALITACANCMESSAGGIINVIATI_ALLEGATI) and (LRicevuto) then
      begin
        LIWImg.Confirmation:='Eliminare gli allegati del messaggio?';
        LIWImg.Hint:='Elimina allegati del messaggio';
      end
      else
      begin
        LIWImg.Confirmation:='Eliminare il messaggio selezionato?';
        LIWImg.Hint:='Elimina messaggio';
      end;

      // invia messaggio
      LIWImg:=(grdMessaggi.medpCompCella(i,iImgInvia,jImgInvia) as TmeIWImageFile);
      if LStato = STATO_MSG_SOSPESO then
        LIWImg.OnClick:=imgInviaClick;
      LIWImg.Css:=IfThen(LStato = STATO_MSG_SOSPESO,'','invisibile');
    end;
  end;
end;

procedure TW035FMessaggistica.grdMessaggiAnnulla(Sender: TObject);
begin
  // disattiva modalità risposta e pulisce dati
  if FModalitaRisposta then
  begin
    FModalitaRisposta:=False;

    // pulisce messaggio
    FMsg.Clear;
    AggiornaUI;
  end;
end;

procedure TW035FMessaggistica.grdMessaggiInserisci(Sender: TObject);
// ridefinisce evento di inserimento record su tabella
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // visualizza icona di conferma e invio messaggio
  VisualizzaInvio(FN,True);

  // pulisce messaggio per inserimento
  FMsg.Clear;
  AggiornaUI;

  // apre il dettaglio messaggio
  EspandiDettaglio;

  // focus su oggetto
  edtOggetto.SetFocus;
end;

procedure TW035FMessaggistica.grdMessaggiModifica(Sender: TObject);
// ridefinisce evento di modifica record su tabella
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // nasconde icona di invio messaggio
  VisualizzaInvio(FN,False);

  // apre il dettaglio messaggio
  EspandiDettaglio;

  // focus su oggetto
  edtOggetto.SetFocus;

  if FMsg.Stato = STATO_MSG_INVIATO then
  begin
    // messaggio già inviato
    // predispone la maschera per l'inserimento di un nuovo messaggio
    // con i dati uguali al messaggio attuale
    FMsg.EditAsNew:=True;
  end;
end;

procedure TW035FMessaggistica.grdMessaggiCancella(Sender: TObject);
// ridefinisce evento di cancellazione record su tabella
var
  LResCtrl: TResCtrl;
begin
  // cancellazione messaggio
  LResCtrl:=DoCancellaMessaggio(True);
  if not LResCtrl.Ok then
    raise Exception.Create('Errore durante la cencellazione del messaggio: ' + LResCtrl.Messaggio);

  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.grdMessaggiConferma(Sender: TObject);
// ridefinisce evento di conferma record su tabella
var
  LResCtrl: TResCtrl;
  LOldID: Integer;
begin
  // controllo dei dati per il salvataggio
  LResCtrl:=CtrlMessaggio(AZIONE_SALVA);
  if not LResCtrl.Ok then
    raise Exception.Create(LResCtrl.Messaggio);

  // se il messaggio è in stato inviato e non viene modificato,
  // non effettua nessuna operazione
  if FMsg.EditAsNew and not (FMsg.Modificato or FMsg.DestModificati or FMsg.AllegModificati) then
    Exit;

  // salva l'id del messaggio originale, che sarà utilizzato nel caso di modifica di un messaggio inviato
  LOldID:=FMsg.ID;

  // salva il messaggio su db
  LResCtrl:=DoSalvaMessaggio;
   if not LResCtrl.Ok then
    raise Exception.Create(LResCtrl.Messaggio);

  // nel caso di modifica di un messaggio inviato
  // effettua la cancellazione del vecchio messaggio
  if FMsg.EditAsNew then
  begin
    // forzatura necessaria per rileggere i dati del messaggio
    grdMessaggi.medpStato:=msBrowse;

    // posizionamento sul messaggio originale
    selTabella.SearchRecord('ID',LOldID,[srFromBeginning]);

    // tenta la cancellazione del messaggio
    LResCtrl:=DoCancellaMessaggio(False);
    if not LResCtrl.Ok then
      raise Exception.Create(LResCtrl.Messaggio);

    FMsg.EditAsNew:=False;
  end;

  // refresh visualizzazione
  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.grdMessaggiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  LNumColonna, LNumAllegati, LNumDest, LDiff: Integer;
  LPercLettura: real;
  LCampo, LNumDestStr: String;
begin
  if not grdMessaggi.medpRenderCell(ACell,ARow,AColumn,True,True,True) then
    Exit;

  LNumColonna:=grdMessaggi.medpNumColonna(AColumn);
  LCampo:=grdMessaggi.medpColonna(LNumColonna).DataField;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdMessaggi.medpCompGriglia) + 1) and (grdMessaggi.medpCompGriglia[ARow - 1].CompColonne[LNumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdMessaggi.medpCompGriglia[ARow - 1].CompColonne[LNumColonna];
  end;

  if ARow = 0 then
  begin
    // intestazione
    if LCampo = 'DBG_COMANDI' then
      ACell.Text:=IfThen(FModalita = TModalitaGestione.Lettura,'Letto');
  end
  else if ARow > IfThen(grdMessaggi.medpRigaInserimento,1,0) then
  begin
    // dettaglio

    // valorizza variabili di supporto
    if FModalita = TModalitaGestione.Invio then
    begin
      LNumDest:=grdMessaggi.medpClientDataSet.FieldByName('D_DEST_TOT').AsInteger;
      LNumDestStr:=A000TraduzioneStringhe(IfThen(LNumDest = 1,A000MSG_W035_MSG_DESTINATARI_1,Format(A000MSG_W035_MSG_FMT_DESTINATARI,[LNumDest])));
    end
    else
    begin
      LNumDest:=0;
      LNumDestStr:='';
    end;

    // valuta i singoli campi
    if LCampo = 'DATA_INVIO' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if LCampo = 'DATA_LETTURA' then
    begin
      // evidenzia stato cancellato
      if (grdMessaggi.medpClientDataSet.FieldByName('STATO').AsString = STATO_MSG_CANCELLATO) and
         (Assigned(ACell.Control)) and
         (ACell.Control is TmeIWCheckBox) then
      begin
        (ACell.Control as TmeIWCheckBox).Css:=StringReplace((ACell.Control as TmeIWCheckBox).Css,'comandi','msg_canc',[]);
      end;
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if LCampo = 'DATA_RICEZIONE' then
    begin
      // data di ricezione messaggio
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if LCampo = 'TESTO' then
    begin
      // se il testo supera certe soglie (lunghezza o ritorni a capo)
      // lo riduce inserendo dei puntini di sospensione
      // per evitare che la riga ecceda un'altezza accettabile
      if Length(ACell.Text) > LIMITE_CARATTERI_TESTO then
      begin
        ACell.Text:=Format('%s...',[Copy(ACell.Text,1,LIMITE_CARATTERI_TESTO)]);
      end;
      if ACell.RawText then
      begin
        ACell.Text:=Format('<div style="overflow-y: hidden; text-overflow: ellipsis; max-height: %dem;">%s</div>',[LIMITE_RIGHE_TESTO,ACell.Text]);
      end;
    end
    else if LCampo = 'D_ALLEGATI' then
    begin
      LNumAllegati:=StrToIntDef(ACell.Text,0);
      ACell.RawText:=LNumAllegati > 0;
      ACell.Text:=IfThen(LNumAllegati > 0,Format('<img class="icona" alt="Allegati" src="../img/attachment.png"> <span class="contatore_pedice">%d</span>',[LNumAllegati]));
      if LNumAllegati > 0 then
        ACell.Css:=ACell.Css + ' align_center';
    end
    else if LCampo = 'SELEZIONE_ANAGRAFICA' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
      ACell.Text:=ACell.Text + IfThen(ACell.Text <> '',': ') + LNumDestStr;
    end
    else if LCampo = 'D_STATO_LETTURA' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if LCampo = 'D_STATO_RICEZIONE' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if LCampo = 'LETTURA_OBBLIGATORIA' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
      // traduce S/N con valori in linguaggio più comprensibile
      if ACell.Text = 'S' then
        ACell.Text:='Sì'
      else if ACell.Text = 'N' then
        ACell.Text:='No';
    end
    // visualizza elenco destinatari
    else if (LCampo = 'D_DESTINATARI') and (FModalita = TModalitaGestione.Invio) then
    begin
      LDiff:=LNumDest - LIMITE_DESTINATARI_VISUALIZZATI;
      if LDiff > 0 then
      begin
        ACell.Text:=ACell.Text + ', ...';
      end;
      ACell.Css:=ACell.Css + ' align_center';
    end;

    // evidenzia messaggi da leggere in base alla modalità
    if FModalita = TModalitaGestione.Lettura then
    begin
      if grdMessaggi.medpClientDataSet.FieldByName('DATA_LETTURA').IsNull then
        ACell.Css:=ACell.Css + ' ' + CSS_MSG_RICEVUTO_DALEGGERE;
    end
    else
    begin
      // messaggi inviati letti
      LPercLettura:=grdMessaggi.medpClientDataSet.FieldByName('D_PERC_LETTURA').AsFloat;
      if LPercLettura = 0 then
        ACell.Css:=ACell.Css + ' ' + CSS_MSG_INVIATO_DALEGGERE
      else if LPercLettura = 1 then
        ACell.Css:=ACell.Css + ' ' + CSS_MSG_INVIATO_LETTO
      else
        ACell.Css:=ACell.Css + ' ' + CSS_MSG_INVIATO_LETTOPARZIALMENTE;
    end;
    // evidenza messaggi cancellati
    if grdMessaggi.medpClientDataSet.FieldByName('STATO').AsString = STATO_MSG_CANCELLATO then
    begin
      ACell.Css:=ACell.Css + ' ' + CSS_MSG_CANCELLATO;
    end;
  end;
end;

//############################################//
//###          GESTIONE DESTINATARI        ###//
//############################################//

procedure TW035FMessaggistica.grdDestinatariRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not grdDestinatari.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdDestinatari.medpNumColonna(AColumn);
  Campo:=grdDestinatari.medpColonna(NumColonna).DataField;

  if ARow > 0 then
  begin
    if Campo = 'DATA_RICEZIONE' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end;
  end;
end;

procedure TW035FMessaggistica.OnSelezioneAnagrafica;
// procedura eseguita dopo aver confermato una selezione anagrafica
begin
  // 1. imposta struttura dati
  FMsg.ClearDestinatari;
  if (Assigned(grdC700)) and (grdC700.selAnagrafe.Active) then
  begin
    FMsg.SelezioneAnagrafica:=grdC700.WC700FM.C700NomeSelezioneCaricata;
    // carica clientdataset destinatari con la selezione
    grdC700.selAnagrafe.First;
    while not grdC700.selAnagrafe.Eof do
    begin
      FMsg.AddDestinatario(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                          grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString,
                          grdC700.selAnagrafe.FieldByName('COGNOME').AsString,
                          grdC700.selAnagrafe.FieldByName('NOME').AsString,
                          DATE_NULL,
                          DATE_NULL);
      grdC700.selAnagrafe.Next;
    end;
  end
  else
  begin
    FMsg.SelezioneAnagrafica:='';
  end;
  FMsg.DestModificati:=True;

  // 2. aggiorna interfaccia
  AggiornaDestinatari;
  edtSelezione.Text:=FMsg.SelezioneAnagrafica;
  edtDestinatari.Text:=Trim(FMsg.SelezioneAnagrafica + ' ' +
                            Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_DESTINATARI_SEL),
                                   [cdsDestinatari.RecordCount,cdsDestinatari.RecordCount]));
end;

procedure TW035FMessaggistica.imgScegliDestOperatoriClick(Sender: TObject);
var
  LstOpSel: TStringList;
  i: Integer;
begin
  WC013FM:=TWC013FCheckListFM.Create(Self);
  FreeNotification(WC013FM);

  LstOpSel:=TStringList.Create;
  try
    // carica stringlist di operatori selezionati
    for i:=0 to High(FMsg.DestOperatoreArr) do
      LstOpSel.Add(FMsg.DestOperatoreArr[i].Utente);

    // prepara e visualizza il frame di selezione destinatari
    WC013FM.CaricaLista(FLstOperatori,FLstOperatori);
    WC013FM.ImpostaValoriSelezionati(LstOpSel);
    WC013FM.ResultEvent:=OnSelezioneOperatori;
    WC013FM.MinElem:=1;
    WC013FM.Visualizza(0,0,'Selezionare i destinatari');
  finally
    FreeAndNil(LstOpSel);
  end;
end;

procedure TW035FMessaggistica.OnSelezioneOperatori(Sender: TObject; Result:Boolean);
// procedura eseguita dopo aver confermato una selezione di operatori win
var
  LstDest: TStringList;
  i: Integer;
begin
  if Result then
  begin
    // 1. imposta struttura dati
    FMsg.ClearDestinatariOperatori;

    LstDest:=WC013FM.LeggiValoriSelezionati;
    try
      for i:=0 to LstDest.Count - 1 do
      begin
        FMsg.AddDestinatarioOperatore(LstDest[i],DATE_NULL,DATE_NULL);
      end;
      FMsg.DestModificati:=True;

      // 2. aggiorna interfaccia
      AggiornaDestinatari;
      edtSelezione.Text:='';
      edtDestinatari.Text:=Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_DESTINATARI_SEL),
                                  [cdsDestinatari.RecordCount,cdsDestinatari.RecordCount]);
    finally
      FreeAndNil(LstDest);
    end;
  end;
end;

procedure TW035FMessaggistica.AggiornaDestinatari(const PSoloFiltro: Boolean = False);
// aggiornamento interfaccia relativa ai destinatari del messaggio
// parametri:
// - PSoloFiltro
//     True:  imposta solo il filtro del clientdataset
//     False: svuota e ricarica il clientdataset con i dati dell'array Msg.DestArr,
//            quindi imposta il filtro del clientdataset
var
  i: Integer;
  Filtro: String;
begin
  cdsDestinatari.Filtered:=False;

  // in base al parametro ricarica il clientdataset
  if not PSoloFiltro then
  begin
    cdsDestinatari.EmptyDataSet;

    // aggiunge destinatari web
    for i:=0 to High(FMsg.DestArr) do
    begin
      cdsDestinatari.Append;
      cdsDestinatari.FieldByName('PROGRESSIVO').AsInteger:=FMsg.DestArr[i].Progressivo;
      cdsDestinatari.FieldByName('MATRICOLA').AsString:=FMsg.DestArr[i].Matricola;
      cdsDestinatari.FieldByName('COGNOME').AsString:=FMsg.DestArr[i].Cognome;
      cdsDestinatari.FieldByName('NOME').AsString:=FMsg.DestArr[i].Nome;
      if FMsg.DestArr[i].DataLettura = DATE_NULL then
        cdsDestinatari.FieldByName('DATA_LETTURA').Value:=null
      else
        cdsDestinatari.FieldByName('DATA_LETTURA').AsDateTime:=FMsg.DestArr[i].DataLettura;
      if FMsg.DestArr[i].DataRicezione = DATE_NULL then
        cdsDestinatari.FieldByName('DATA_RICEZIONE').Value:=null
      else
        cdsDestinatari.FieldByName('DATA_RICEZIONE').AsDateTime:=FMsg.DestArr[i].DataRicezione;
      cdsDestinatari.Post;
    end;
    grdDestinatari.medpColonna('DATA_RICEZIONE').Visible:=FMsg.Stato <> STATO_MSG_SOSPESO;

    // aggiunge destinatari win (operatori)
    for i:=0 to High(FMsg.DestOperatoreArr) do
    begin
      cdsDestinatari.Append;
      cdsDestinatari.FieldByName('UTENTE').AsString:=FMsg.DestOperatoreArr[i].Utente;
      if FMsg.DestOperatoreArr[i].DataLettura = DATE_NULL then
        cdsDestinatari.FieldByName('DATA_LETTURA').Value:=null
      else
        cdsDestinatari.FieldByName('DATA_LETTURA').AsDateTime:=FMsg.DestOperatoreArr[i].DataLettura;
      if FMsg.DestOperatoreArr[i].DataRicezione = DATE_NULL then
        cdsDestinatari.FieldByName('DATA_RICEZIONE').Value:=null
      else
        cdsDestinatari.FieldByName('DATA_RICEZIONE').AsDateTime:=FMsg.DestOperatoreArr[i].DataRicezione;
      cdsDestinatari.Post;
    end;
    grdDestinatari.medpColonna('DATA_RICEZIONE').Visible:=FMsg.Stato <> STATO_MSG_SOSPESO;
  end;

  // filtro dei destinatari sul clientdataset
  Filtro:='';
  if FModalita = TModalitaGestione.Invio then
  begin
    // il filtro è significativo solo se il messaggio è già stato inviato (o cancellato dopo invio)
    rgpFiltroDest.Visible:=(grdMessaggi.medpStato <> msInsert) and (FMsg.Stato <> STATO_MSG_SOSPESO);
    if rgpFiltroDest.Visible then
    begin
      case rgpFiltroDest.ItemIndex of
        0: Filtro:='';                           // tutti
        1: Filtro:='DATA_RICEZIONE is not null'; // ricevuto
        2: Filtro:='DATA_RICEZIONE is null';     // non ricevuto
      end;
    end;
  end;
  cdsDestinatari.Filter:=Filtro;
  cdsDestinatari.Filtered:=Filtro <> '';

  // aggiorna tabella destinatari
  grdDestinatari.medpCaricaCDS;
end;

//############################################//
//###           STORICO MESSAGGI           ###//
//############################################//

procedure TW035FMessaggistica.grdElencoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna, Liv: Integer;
  Campo, Prefisso, Stile: String;
  IsInviato: Boolean;
begin
  if not grdElenco.medpRenderCell(ACell,ARow,AColumn,True,False,True) then
    Exit;

  NumColonna:=grdElenco.medpNumColonna(AColumn);
  Campo:=grdElenco.medpColonna(NumColonna).DataField;

  if ARow > 0 then
  begin
    if Campo = 'OGGETTO' then
    begin
      ACell.RawText:=True;
      Liv:=grdElenco.medpClientDataSet.FieldByName('LEVEL').AsInteger;
      if Liv = 1 then
        Prefisso:=''
      else
      begin
        Prefisso:=Format('<span style="font-family: Courier New,Courier,mono;">%s%s%s%s</span>',[HTML_PIPE,HTML_DASH,HTML_DASH,'&nbsp;']);
      end;
      if Liv > 2 then
        Stile:=Format('style="padding-left: %dem"',[2 * (Liv - 2)]);
      ACell.Text:=Format('<span %s>%s%s</span>',[Stile,Prefisso,ACell.Text]);
    end
    else if Campo = 'DATA_INVIO' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'D_DESTINATARI' then
    begin
      // destinatari: tronca dopo un limite di caratteri prestabilito
      // visualizza comunque tutto l'elenco nell'hint
      ACell.ShowHint:=False;
      if Length(ACell.Text) > LIMITE_CARATTERI_DESTINATARI then
      begin
        ACell.Hint:=ACell.Text;
        ACell.ShowHint:=True;
        ACell.Text:=Format('%s...',[Copy(ACell.Text,1,LIMITE_CARATTERI_DESTINATARI)]);
      end;
    end;

    // id selezionato viene evidenziato in grassetto
    if grdElenco.medpClientDataSet.FieldByName('ID').AsInteger = selTabella.FieldByName('ID').AsInteger then
      ACell.Css:=ACell.Css + ' font_grassetto';

    // distingue messaggi ricevuti da inviati
    IsInviato:=grdElenco.medpClientDataSet.FieldByName('MITTENTE').AsString = Parametri.Operatore;
    ACell.Css:=ACell.Css + ' ' + IfThen(IsInviato,CSS_RIGA_INVIATO,CSS_RIGA_RICEVUTO);
  end;
end;

//############################################//
//###          GESTIONE ALLEGATI           ###//
//############################################//
procedure TW035FMessaggistica.btnHdnUploadClick(Sender: TObject);
var
  i,Suff: Integer;
  LNomeAllegato,AttName,AttExt,LFilePath: String;
  LDuplicato: Boolean;
  LDimensioneAllegato: Int64;
  LDimMB: Double;
begin
  { DONE : TEST IW 14 OK }
  if not IWFile.IsPresenteFileUploadato then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Selezionare un file da allegare al messaggio!');
    Exit;
  end;

  // determina il nome dell'allegato (per escludere duplicati)
  LNomeAllegato:=IWFile.NomeFile;
  AttExt:=TPath.GetExtension(LNomeAllegato);
  AttName:=TPath.GetFileNameWithoutExtension(LNomeAllegato);
  Suff:=2;
  LDuplicato:=False;
  while FMsg.EsisteAllegato(LNomeAllegato) do
  begin
    LDuplicato:=True;
    LNomeAllegato:=Format('%s(%d)%s',[AttName,Suff,AttExt]);
    Suff:=Suff + 1;
  end;

  try
    // path e nome per il salvataggio su file system
    LFilePath:=TPath.Combine(GGetWebApplicationThreadVar.UserCacheDir,LNomeAllegato);

    // se esiste già un file con lo stesso nome lo cancella
    if TFile.Exists(LFilePath) then
      TFile.Delete(LFilePath);

    // effettua upload
    IWFile.SalvaSuFile(LFilePath);
    IWFIle.Ripristina;

    // imposta proprietà documento
    LDimensioneAllegato:=R180GetFileSize(LFilePath);

    // controllo dimensione file
    LDimMB:=LDimensioneAllegato / BYTES_MB;
    if LDimMB > FParMaxDimAllegatoMB then
    begin
      // cancella file temporaneo
      try
        TFile.Delete(LFilePath);
      except
      end;
      // solleva eccezione
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_DIM_ALLEGATO),[FParMaxDimAllegatoMB,LDimMB]));
    end;

    // controllo quota
    // il controllo è effettuato in fase di conferma del messaggio

    // aggiorna interfaccia
    i:=FMsg.AddAllegato(FLAG_ALLEG_NUOVO,LNomeAllegato);
    if grdAllegati.Visible then
    begin
      grdAllegati.RowCount:=grdAllegati.RowCount + 1;
    end
    else
    begin
      grdAllegati.Visible:=True;
      grdAllegati.RowCount:=1;
    end;
    grdAllegati.Cell[i,0].Control:=CreaAllegatoCheck(i); // check di selezione file
    grdAllegati.Cell[i,1].Text:='';
    grdAllegati.Cell[i,1].Control:=CreaAllegatoLink(i);  // link per salvataggio file

    ImpostaVisibilitaSezioneAllegati;

    // notifica allegato duplicato
    if LDuplicato then
      GGetWebApplicationThreadVar.ShowMessage('Attenzione!'#13#10 +
                                              'Questo messaggio contiene già un allegato con lo stesso nome.'#13#10 +
                                              'Il nuovo file è stato rinominato in "' + LNomeAllegato + '".');
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(E.Message,ERRORE,'Errore upload');
    end;
  end;
end;

function TW035FMessaggistica.CreaAllegatoCheck(const PIndice: Integer): TmeIWCheckBox;
// crea e restituisce un checkbox per la selezione dell'allegato
begin
  if (PIndice < 0) or (PIndice > Length(FMsg.AllegatiArr)) then
  begin
    Result:=nil;
    Exit;
  end;

  Result:=TmeIWCheckBox.Create(Self);
  Result.Parent:=Self;
  Result.Caption:='';
  Result.Checked:=True;
  { DONE : TEST IW 14 OK }
  //Result.DontSubmitFiles:=True;
  Result.Hint:=FMsg.AllegatiArr[PIndice].NomeFile;
  Result.ShowHint:=False;
  Result.Tag:=PIndice;
  Result.OnAsyncClick:=chkAllegatoAsyncClick;
end;

function TW035FMessaggistica.CreaAllegatoLink(const PIndice: Integer): TmeIWLink;
// crea e restituisce un link per il salvataggio dell'allegato
var
  LAlleg: TAllegato;
begin
  if (PIndice < 0) or (PIndice > Length(FMsg.AllegatiArr)) then
  begin
    Result:=nil;
    Exit;
  end;

  LAlleg:=FMsg.AllegatiArr[PIndice];

  Result:=TmeIWLink.Create(Self);
  Result.Parent:=Self;
  Result.Text:=Format('%s (%s)',[LAlleg.NomeFile,LAlleg.DimFileStr]);
  Result.Css:='file_ext small'; //'link file_ext small';
  Result.ExtraTagParams.Add(Format('data-file-ext=%s',[LAlleg.ExtFile]));
  { DONE : TEST IW 14 OK }
  //Result.DontSubmitFiles:=True;
  Result.Hint:=LAlleg.NomeFile;
  Result.medpDownloadButton:=True;
  if LAlleg.Flag = FLAG_ALLEG_SALVATO then
    Result.OnClick:=lnkAllegatoClick
  else
    Result.OnClick:=nil;
end;

procedure TW035FMessaggistica.chkAllegatoAsyncClick(Sender: TObject; EventParams: TStringList);
// gestione click su checkbox di selezione allegato
var
  LIndice: Integer;
  LOldFlag: String;
begin
  // PRE: Tag è l'indice dell'elemento nell'array Msg.AllegatiArr
  LIndice:=(Sender as TmeIWCheckBox).Tag;

  LOldFlag:=FMsg.AllegatiArr[LIndice].Flag;
  if (Sender as TmeIWCheckBox).Checked then
  begin
    // allegato selezionato
    FMsg.AllegatiArr[LIndice].Flag:=IfThen(FMsg.AllegatiArr[LIndice].Flag = FLAG_ALLEG_CANC_NUOVO,FLAG_ALLEG_NUOVO,FLAG_ALLEG_SALVATO);
    if FMsg.TotAllegati > FParMaxAllegati then
    begin
      (Sender as TmeIWCheckBox).Checked:=False;
      FMsg.AllegatiArr[LIndice].Flag:=LOldFlag;
    end;
  end
  else
  begin
    // allegato deselezionato
    FMsg.AllegatiArr[LIndice].Flag:=IfThen(FMsg.AllegatiArr[LIndice].Flag = FLAG_ALLEG_NUOVO,FLAG_ALLEG_CANC_NUOVO,FLAG_ALLEG_CANC_SALVATO);
  end;

  ImpostaVisibilitaSezioneAllegati;

  if FParQuotaAllegatiMB > -1 then
    CalcolaQuotaAllegati(nil);
end;

procedure TW035FMessaggistica.chkStatoAsyncClick(Sender: TObject; EventParams: TStringList);
// abilitazione filtro periodo invio
begin
  if not (chkStatoSospeso.Checked or chkStatoInviato.Checked or chkStatoCancellato.Checked) then
    (Sender as TmeIWCheckBox).Checked:=True;

  // selezione checkbox "Tutti"
  chkStatoTutti.Checked:=chkStatoSospeso.Checked and
                         chkStatoInviato.Checked and
                         chkStatoCancellato.Checked;

  // gestione check stato inviato
  edtPeriodoDal.Enabled:=chkStatoInviato.Checked;
  edtPeriodoAl.Enabled:=chkStatoInviato.Checked;
  if not edtPeriodoDal.Enabled then
    edtPeriodoDal.Clear;
  if not edtPeriodoAl.Enabled then
    edtPeriodoAl.Clear;
end;

procedure TW035FMessaggistica.chkStatoTuttiAsyncClick(Sender: TObject; EventParams: TStringList);
// filtro stato: tutti
begin
  if chkStatoTutti.Checked then
  begin
    // seleziona tutti gli stati
    chkStatoSospeso.Checked:=True;
    chkStatoInviato.Checked:=True;
    chkStatoCancellato.Checked:=True;
  end
  else
  begin
    // se tutti gli altri checkbox sono selezionati, mantiene selezionato "Tutti"
    if (chkStatoSospeso.Checked) and (chkStatoInviato.Checked) and (chkStatoCancellato.Checked) then
      chkStatoTutti.Checked:=True;
  end;
end;

procedure TW035FMessaggistica.lnkAllegatoClick(Sender: TObject);
var
  NomeFile, FilePath: String;
  Blob: TLOBLocator;
begin
  // estrae il nome del file
  NomeFile:=(Sender as TmeIWLink).Hint;

  try
    W035DM.selT283Allegato.SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
    W035DM.selT283Allegato.SetVariable('NOME',NomeFile);
    W035DM.selT283Allegato.Execute;
    Blob:=W035DM.selT283Allegato.LOBField('ALLEGATO');
    if Blob.IsNull then
    begin
      MsgBox.MessageBox(Format('Il file "%s" non è presente nel database',[NomeFile]),ESCLAMA);
      Exit;
    end;
    begin
      // salva il blob in un file nella user cache
      // se un file con lo stesso nome esiste già, lo elimina
      { DONE : TEST IW 14 OK }
      FilePath:=WebApplication.UserCacheDir + NomeFile;
      if FileExists(FilePath) then
        DeleteFile(FilePath);
      Blob.SaveToFile(FilePath);

      // invia il file al browser
      GGetWebApplicationThreadVar.SendFile(FilePath,True,'application/x-download',NomeFile);
    end;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox('Errore durante il download del file: ' + E.Message,ESCLAMA);
      Exit;
    end;
  end;
end;

procedure TW035FMessaggistica.mnuEsportaCsvClick(Sender: TObject);
// esportazione csv dei messaggi
var
  Nome: String;
begin
  if not Assigned(Sender) then
    csvDownload:=grdMessaggi.ToCsv
  else
  begin
    Nome:=IfThen(Modalita = TModalitaGestione.Lettura,'Messaggi_ricevuti','Messaggi_inviati');
    Nome:=Format('%s.xls',[Nome]);
    InviaFile(Nome,csvDownload);
  end;
end;

procedure TW035FMessaggistica.mnuEsportaExcelClick(Sender: TObject);
// esportazione xlsx dei messaggi
var
  Nome: String;
begin
  if not Assigned(Sender) then
    streamDownload:=grdMessaggi.ToXlsx
  else
  begin
    Nome:=IfThen(Modalita = TModalitaGestione.Lettura,'Messaggi_ricevuti','Messaggi_inviati');
    Nome:=Format('%s.xlsx',[Nome]);
    InviaFile(Nome,streamDownload);
  end;
end;

procedure TW035FMessaggistica.mnuDestCsvClick(Sender: TObject);
// esportazione csv dei destinatari
begin
  if not Assigned(Sender) then
    csvDownload:=grdDestinatari.ToCsv
  else
    InviaFile('Destinatari.xls',csvDownload);
end;

procedure TW035FMessaggistica.mnuDestExcelClick(Sender: TObject);
// esportazione xlsx dei destinatari
begin
  if not Assigned(Sender) then
    streamDownload:=grdDestinatari.ToXlsx
  else
    InviaFile('Destinatari.xlsx',streamDownload);
end;

procedure TW035FMessaggistica.DistruggiOggetti;
// procedura distruzione oggetti creati a runtime
begin
  if Assigned(grdC700) then
    FreeAndNil(grdC700);
  FreeAndNil(FMsg);
  FreeAndNil(FLstOperatori);
  if Assigned(WC013FM) then
  begin
    try
      FreeAndNil(WC013FM);
    except
    end;
  end;
  FreeAndNil(W035DM);
end;

//############################################//
//###             TMessaggio               ###//
//############################################//

constructor TMessaggio.Create;
begin
  inherited;
  Clear;
end;

destructor TMessaggio.Destroy;
begin
  Clear;
  inherited;
end;

procedure TMessaggio.Clear;
// pulisce le proprietà del messaggio
begin
  FID:=0;
  FErrMsg:='';
  FOggetto:='';
  FTesto:='';
  FLetturaObbligatoria:='N';
  FModificato:=False;
  FIDOriginale:=0;
  FStato:=STATO_MSG_SOSPESO;
  FEditAsNew:=False;
  FDataInvio:=DATE_NULL;
  FSelezioneAnagrafica:='';
  FDestLetti:=0;
  FDestRicevuti:=0;
  FDestTot:=0;
  FDestModificati:=False;
  SetLength(FDestArr,0);
  SetLength(FDestOperatoreArr,0);
  FAllegModificati:=False;
  SetLength(FAllegatiArr,0);
  SetLength(FAllegatiCopyArr,0);
end;

function TMessaggio.GetStatoLettura: TStatoLettura;
// estrae lo stato di lettura del messaggio in base al numero di destinatari
// totali e al numero di destinatari che hanno letto il messaggio
var
  i, LNumLetti, LTotDest: Integer;
begin
  // numero totale di destinatari
  LTotDest:=Length(FDestArr) + Length(FDestOperatoreArr);

  // conta il numero di destinatari che hanno letto il messaggio
  // destinatari web + win
  LNumLetti:=0;
  for i:=0 to High(FDestArr) do
  begin
    if FDestArr[i].DataLettura <> DATE_NULL then
      LNumLetti:=LNumLetti + 1;
  end;
  for i:=0 to High(FDestOperatoreArr) do
  begin
    if FDestOperatoreArr[i].DataLettura <> DATE_NULL then
      LNumLetti:=LNumLetti + 1;
  end;

  // determina lo stato di lettura del messaggio
  if LNumLetti = 0 then
    Result:=TStatoLettura.NonLetto
  else if LNumLetti = LTotDest then
    Result:=TStatoLettura.Letto
  else
    Result:=TStatoLettura.LettoParzialmente;
end;

function TMessaggio.GetStatoRicezione: TStatoRicezione;
var
  i, NumRicevuti, TotDest: Integer;
begin
  // numero totale di destinatari
  TotDest:=Length(FDestArr) + Length(FDestOperatoreArr);

  // conta il numero di destinatari che hanno ricevuto il messaggio
  NumRicevuti:=0;
  for i:=0 to High(FDestArr) do
  begin
    if FDestArr[i].DataRicezione <> DATE_NULL then
      NumRicevuti:=NumRicevuti + 1;
  end;
  for i:=0 to High(FDestOperatoreArr) do
  begin
    if FDestOperatoreArr[i].DataRicezione <> DATE_NULL then
      NumRicevuti:=NumRicevuti + 1;
  end;

  // determina lo stato di ricezione del messaggio
  if NumRicevuti = 0 then
    Result:=TStatoRicezione.NonRicevuto
  else if NumRicevuti = TotDest then
    Result:=TStatoRicezione.Ricevuto
  else
    Result:=TStatoRicezione.RicevutoParzialmente;
end;

procedure TMessaggio.SetLetturaObbligatoria(const Value: String);
begin
  if (Value <> 'S') and (Value <> 'N') then
    raise Exception.Create(Format('Valore di LETTURA_OBBLIGATORIA non valido: %s. Specificare S oppure N',[Value]));

  FLetturaObbligatoria:=Value;
end;

procedure TMessaggio.SetOggetto(const Value: String);
begin
  FModificato:=FModificato or (FOggetto <> Value);
  FOggetto:=Value;
end;

procedure TMessaggio.SetTesto(const Value: String);
begin
  FModificato:=FModificato or (FTesto <> Value);
  FTesto:=Value;
end;

procedure TMessaggio.ClearDestinatari;
begin
  SetLength(FDestArr,0);
end;

procedure TMessaggio.ClearDestinatariOperatori;
begin
  SetLength(FDestOperatoreArr,0);
end;

function TMessaggio.AddDestinatario(const PProg: Integer; const PMatricola, PCognome, PNome: String; const PDataLettura, PDataRicezione: TDateTime): Integer;
// aggiunge un nuovo destinatario web all'array
var
  x: Integer;
begin
  x:=Length(FDestArr);
  SetLength(FDestArr,x + 1);
  FDestArr[x].Progressivo:=PProg;
  FDestArr[x].Matricola:=PMatricola;
  FDestArr[x].Cognome:=PCognome;
  FDestArr[x].Nome:=PNome;
  FDestArr[x].DataLettura:=PDataLettura;
  FDestArr[x].DataRicezione:=PDataRicezione;

  Result:=x;
end;

function TMessaggio.AddDestinatarioOperatore(const PUtente: String; const PDataLettura, PDataRicezione: TDateTime): Integer;
// aggiunge un nuovo destinatario (operatore win) all'array
var
  x: Integer;
begin
  x:=Length(FDestOperatoreArr);
  SetLength(FDestOperatoreArr,x + 1);
  FDestOperatoreArr[x].Utente:=PUtente;
  FDestOperatoreArr[x].DataLettura:=PDataLettura;
  FDestOperatoreArr[x].DataRicezione:=PDataRicezione;

  Result:=x;
end;

function TMessaggio.GetTotAllegati: Integer;
var
  i: Integer;
begin
  Result:=0;
  for i:=Low(FAllegatiArr) to High(FAllegatiArr) do
  begin
    if R180In(FAllegatiArr[i].Flag,[FLAG_ALLEG_NUOVO,FLAG_ALLEG_SALVATO]) then
      Result:=Result + 1;
  end;
end;

function TMessaggio.IsMaxAllegatiRaggiunto: Boolean;
var
  i: Integer;
  LConta: Integer;
  LMaxAllegati: Integer;
begin
  // valore parametro aziendale
  LMaxAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_W035MaxAllegati,MaxInt);
  if LMaxAllegati < 0 then
    LMaxAllegati:=MaxInt;

  // ciclo di conteggio allegati
  LConta:=0;
  for i:=Low(FAllegatiArr) to High(FAllegatiArr) do
  begin
    if R180In(FAllegatiArr[i].Flag,[FLAG_ALLEG_NUOVO,FLAG_ALLEG_SALVATO]) then
      LConta:=LConta + 1;
  end;
  Result:=LConta >= LMaxAllegati;
end;

function TMessaggio.GetDimTotAllegati: Integer;
var
  i: Integer;
 begin
  Result:=0;
  for i:=Low(FAllegatiArr) to High(FAllegatiArr) do
  begin
    if R180In(FAllegatiArr[i].Flag,[FLAG_ALLEG_NUOVO,FLAG_ALLEG_SALVATO]) then
      Result:=Result + FAllegatiArr[i].DimFile;
  end;
end;

function TMessaggio.AddAllegato(const PFlag, PNomeFile: String; const PDimFile: Int64 = 0): Integer;
// aggiunge l'allegato al messaggio dopo l'upload
var
  x: Integer;
  DimFile: Int64;
begin
  // aggiunge elemento all'array
  x:=Length(FAllegatiArr);
  SetLength(FAllegatiArr,x + 1);

  // imposta dati dell'allegato
  FAllegatiArr[x].Flag:=PFlag;
  FAllegatiArr[x].NomeFile:=PNomeFile;
  FAllegatiArr[x].ExtFile:=StringReplace(ExtractFileExt(PNomeFile),'.','',[]);
  { DONE : TEST IW 14 OK }
  if PDimFile = 0 then
    DimFile:=R180GetFileSize(GGetWebApplicationThreadVar.UserCacheDir + PNomeFile)
  else
    DimFile:=PDimFile;
  FAllegatiArr[x].DimFile:=DimFile;
  FAllegatiArr[x].DimFileStr:=R180GetFileSizeStr(DimFile);

  // restituisce indice
  Result:=x;
end;

procedure TMessaggio.ClearAllegati;
begin
  SetLength(FAllegatiArr,0);
  SetLength(FAllegatiCopyArr,0);
end;

function TMessaggio.EsisteAllegato(const PNomeFile: String): Boolean;
// restituisce True se il nome file è già presente nell'array degl allegati
// oppure False altrimenti
var
  i: Integer;
begin
  Result:=False;
  for i:=0 to High(FAllegatiArr) do
  begin
    if PNomeFile = FAllegatiArr[i].NomeFile then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

end.
