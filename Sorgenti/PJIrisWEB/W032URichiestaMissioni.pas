unit W032URichiestaMissioni;

interface

uses
  R010UPaginaWeb,
  W032URichiestaMissioniDM,
  W032UMotivazioneFM,
  W032UPercorsoFM,
  R012UWebAnagrafico,
  R013UIterBase,
  C018UIterAutDM,
  QueryStorico,
  A000UInterfaccia,
  A000UCostanti,
  A000UMessaggi,
  A000USessione,
  W000UMessaggi,
  IWApplication,
  FunzioniGenerali,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  WC012UVisualizzaFileFM,
  meIWEdit, meTIWAdvRadioGroup, meTIWAdvCheckGroup, meIWRegion, meIWButton,
  meIWComboBox, meIWImageFile, meIWLabel, meIWGrid, IWCompMemo, meIWMemo,
  Oracle, OracleData, Math, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, ActnList, IWTemplateProcessorHTML, IWCompLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit, IWAdvRadioGroup, IWCompCheckbox, DB, DBClient, IWDBGrids,
  IWCompListBox, medpIWDBGrid, StrUtils, medpIWTabControl, IWVCLBaseContainer,
  IWContainer, IWRegion, IWAdvCheckGroup,
  meIWCheckBox, IWCompButton, IWCompGrids, IWCompExtCtrls, meIWLink,
  IWHTMLContainer, IWHTML40Container, Menus, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWHTMLControls, IOUtils, medpIWMultiColumnComboBox, System.Generics.Collections, IWCompJQueryWidget;

type
  TRecordAnticipo = record
    Codice: String;
    Quantita: Currency;
    Note: String;
  end;

  TRecordDettaglioGG = record
    Tipo: String;
    Data: TDateTime;
    Dalle: String;
    Alle: String;
    Note: String;
  end;

  TRecordRimborso = record
    Codice: String;
    IndennitaKm: String;     // dato calcolato in base a "Codice"
    DataRimborso: TDateTime;
    IdRimborso: Integer;
    KmPercorsi: double;
    CodValuta: String;
    Rimborso,
    RimborsoVar: currency;
    Note,
    FileAllegato: String;
    TipoRimborso: String;
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  TRegolaM010 = record
    Codice: String;
    Descrizione: String;
    AbilRimb: String;
    AbilIndKm: String;
    RimbKmAuto: String;
    IndKmAuto: String;
    TipoRegistrazione: String;
    ArrotTariffaDopoRiduzione: String;
  end;

  TDatiMezzo = class(TPersistent)
  private
    Riga: Integer;
    FlagAnticipo: String;
    FlagMotivazione: String;
    FlagTarga: String;
    FlagMezzoProprio: String;
    FasiCompetenza: String;
  end;

  TW032FRichiestaMissioni = class(TR013FIterBase)
    dsrM140: TDataSource;
    cdsM140: TClientDataSet;
    rgDettaglio: TmeIWRegion;
    tabMissioni: TmedpIWTabControl;
    tpAnticipi: TIWTemplateProcessorHTML;
    cgpMotivEstero: TmeTIWAdvCheckGroup;
    cgpIpotesiEstero: TmeTIWAdvCheckGroup;
    dsrM160: TDataSource;
    cdsM160: TClientDataSet;
    tpDettaglio: TIWTemplateProcessorHTML;
    rgAnticipi: TmeIWRegion;
    rgpAccredito: TmeTIWAdvRadioGroup;
    chkDelegato: TmeIWCheckBox;
    edtCercaDelegato: TmeIWEdit;
    lblDelegato: TmeIWLabel;
    cmbDelegato: TmeIWComboBox;
    btnCercaDelegato: TmeIWButton;
    grdAnticipi: TmedpIWDBGrid;
    grdMezzi: TmeIWGrid;
    lblNoteMezzoProprio: TmeIWLabel;
    rgRimborsi: TmeIWRegion;
    tpRimborsi: TIWTemplateProcessorHTML;
    grdRimborsi: TmedpIWDBGrid;
    dsrM150: TDataSource;
    cdsM150: TClientDataSet;
    lblAutRimborsi: TmeIWLabel;
    lblRespRimborsi: TmeIWLabel;
    rgDettaglioGG: TmeIWRegion;
    grdDettaglioGG: TmedpIWDBGrid;
    cdsM143: TClientDataSet;
    dsrM143: TDataSource;
    tpDettaglioGG: TIWTemplateProcessorHTML;
    lblDatiObbligatori: TmeIWLabel;
    grdDati: TmeIWGrid;
    lnkDocumento: TmeIWLink;
    lblMezzi: TmeIWLabel;
    lblTotAnticipi: TmeIWLabel;
    lblCapitoloTrasferta: TmeIWLabel;
    descCapitoloTrasferta: TmeIWLabel;
    cmbCapitoloTrasferta: TMedpIWMultiColumnComboBox;
    JQuery: TIWJQueryWidget;
    lblTotSpettante: TmeIWLabel;
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure lnkDocumentoClick(Sender: TObject);
    procedure rgpTipoRichiesteClick(selCountDatiPers: TObject);
    procedure tabMissioniTabControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tabMissioniTabControlChange(Sender: TObject);
    // richiesta missione
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    // anticipi
    procedure grdAnticipiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdAnticipiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure btnCercaDelegatoClick(Sender: TObject);
    procedure edtCercaDelegatoSubmit(Sender: TObject);
    procedure chkDelegatoClick(Sender: TObject);
    procedure rgpAccreditoClick(Sender: TObject);
    // rimborsi
    procedure grdRimborsiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRimborsiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    // servizi attivi
    procedure grdDettaglioGGRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdDettaglioGGAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdMezziRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure cmbCapitoloTrasfertaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure IWAppFormAfterRender(Sender: TObject);
  private
    FRichiesta: TRichiesta;
    FRecordAnticipo: TRecordAnticipo;
    FRecordDettaglioGG: TRecordDettaglioGG;
    FRecordRimborso: TRecordRimborso;
    FListaAnticipi: TStringList;
    FListaAnticipiAbilFase: TStringList;
    FListaRimborsi: TStringList;
    FListaRimborsiPasto: TStringList;
    FListaValute: TStringList;
    FListaTipiRegistrazione: TStringList;
    FAutorizza: TAutorizza;
    FRegolaM010: TRegolaM010;
    FCssIniCgp: String;
    FCodAnticipoPastoM020: String;
    FMsgAnt: String;
    FMsgRimb: String;
    FRegoleTrovate: Boolean;
    FGestAnticipi: Boolean;
    FModificaAnticipiAut: Boolean;
    W032MotivazioneFM: TW032FMotivazioneFM;
    W032PercorsoFM: TW032FPercorsoFM;
    FImgApplica: TmeIWImageFile;
    FImgConfermaAnt: TmeIWImageFile;
    FImgConfermaDettGG: TmeIWImageFile;
    FImgConfermaRimb: TmeIWImageFile;
    FFiltroUserM020: Boolean;
    FCtrlValiditaPeriodo: Boolean;
    FOldId: Integer;
    FQSCodRegole: TQueryStorico;
    FForzaRefreshListe: Boolean;
    FEsistonoDatiPersonalizzati: Boolean;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
    FFlagDestinazioneReadOnly: Boolean;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
    FImportazioneRimborsi:Boolean;
    procedure GetRichiesteMissioni;
    procedure PopolaMezzi;
    procedure CaricaListe;
    procedure CaricaListaTipiRegistrazione;
    procedure PopolaDatiPersonalizzati;
    procedure VariabiliQueryValore(DS:TOracleDataset);
    procedure cmbFlagDestinazioneChange(Sender: TObject);
    procedure cmbFlagDestinazioneAsyncChange(Sender: TObject; EventParams: TStringList);
    // richiesta missione
    procedure CleanRecordRichiesta;
    function  RicalcoloTipoMissione(const PForzaImpostazioneTipoCompatibile: Boolean; var RErrMsg: String): Boolean; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    procedure DBGridColumnClick(ASender:TObject; const AValue:string); {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    procedure TrasformaComponenti(const FN:String);
    function  CtrlSalvaDatiPersonalizzati: TResCtrl;
    function  ControlliOK(const FN: String):Boolean;
    procedure imgInserisciClick(Sender: TObject);
    procedure imgModificaClick(Sender:TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgAnnullaMissioneClick(Sender: TObject);
    procedure imgChiudiMissioneClick(Sender: TObject);
    procedure imgRiapriMissioneClick(Sender: TObject);
    procedure imgIterClick(Sender: TObject);
    procedure imgAllegClick(Sender: TObject); // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2
    procedure imgPercorsoClick(Sender: TObject);
    procedure actInsRichiesta;
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    procedure actModRichiesta(const FN: String);
    procedure actCancRichiesta(const FN: String);
    // autorizzazione missione
    procedure TrasformaComponentiAut(const FN: String);
    function  ControlliAutOK(const FN: String): Boolean;
    procedure actModDatiAut(const FN: String);
    procedure imgModificaDatiAutClick(Sender: TObject);
    procedure imgConfermaDatiAutClick(Sender: TObject);
    procedure imgAnnullaDatiAutClick(Sender: TObject);
    // anticipi
    procedure DBGridColumnClickAnt(ASender:TObject; const AValue:string);
    procedure TrasformaComponentiAnt(const FN:String);
    function  ControllaConfermaAnticipi(const FN: string): TResCtrl;
    function  CtrlAnticipoOK(const FN: String): Boolean;
    procedure imgInsAnticipoClick(Sender: TObject);
    procedure imgModAnticipoClick(Sender: TObject);
    procedure imgCanAnticipoClick(Sender: TObject);
    procedure imgAnnullaAnticipoClick(Sender: TObject);
    procedure imgApplicaAnticipoClick(Sender: TObject);
    procedure actInsAnticipo;
    procedure actModAnticipo(const FN: String);
    // rimborsi
    procedure DBGridColumnClickRimb(ASender:TObject; const AValue:string);
    procedure TrasformaComponentiRimb(const FN:String);
    function  CtrlRimborsoOK(const FN: String): Boolean;
    function  CtrlSommaIndKmOK: Boolean;
    procedure imgInsRimborsoClick(Sender: TObject);
    procedure imgModRimborsoClick(Sender: TObject);
    procedure imgCanRimborsoClick(Sender: TObject);
    procedure imgAnnullaRimborsoClick(Sender: TObject);
    procedure imgApplicaRimborsoClick(Sender: TObject);
    procedure actInsRimborso;
    procedure actModRimborso(const FN: String);
    // servizi attivi
    procedure DBGridColumnClickDettaglioGG(ASender:TObject; const AValue:string);
    procedure TrasformaComponentiDettaglioGG(const FN:String);
    function  CtrlDettaglioGGOK(const FN: String): Boolean;
    procedure imgInsDettaglioGGClick(Sender: TObject);
    procedure imgModDettaglioGGClick(Sender: TObject);
    procedure imgCanDettaglioGGClick(Sender: TObject);
    procedure imgAnnullaDettaglioGGClick(Sender: TObject);
    procedure imgApplicaDettaglioGGClick(Sender: TObject);
    procedure actInsDettaglioGG;
    procedure actModDettaglioGG(const FN: String);
    procedure CancellaServiziAttivi;
    procedure cmbVoceAnticipoChange(Sender: TObject);
    procedure edtQuantitaAnticipoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbVoceRimborsoChange(Sender: TObject);
    procedure chkMezzoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure cmbIspettivaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure AutorizzazioneOK;
    procedure GestioneFasi(const PFasePrima, PFaseDopo: Integer; const PRiapriMissione: Boolean = False);
    procedure LeggiRegolaMissione(Data:TDateTime;VisualizzaMessaggio:Boolean = True); {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    procedure PosizionamentoMultiColumnText(PCmb: TMedpIWMultiColumnComboBox; const PValore: String; const PCodLen: Integer);
    procedure CleanMezziTrasporto;
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    W032DM: TW032FRichiestaMissioniDM;
    function  InizializzaAccesso:Boolean; override;
    procedure OnTabChanging(var AllowChange: Boolean; var Conferma: String); override;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    procedure ConfermaAnnullaMissione(const PMotivazione: String); // richiamata da frame di conferma
    procedure ConfermaPercorso(PPercorsoInfo: TPercorsoInfo); // richiamata da frame di percorso
    procedure AnnullaPercorso; // richiamata da frame di percorso
  end;

const
  //MAX_RIMBORSI_PASTO_GG          = 2;   // numero max di rimborsi pasto / gg
  MAX_LENGTH_ELENCO_DESTINAZIONI = 30;  // max lunghezza elenco destinazioni da riportare

  W032_TQ_FLAG     = 'F';               // tipo quantità espressa come flag (0 / 1)
  W032_TQ_QUANTITA = 'Q';               // tipo quantità espressa come quantità intera
  W032_TQ_IMPORTO  = 'I';               // tipo quantità espressa come importo (floating point)

  W032_TIPO_ACCREDITO_CC = '1';
  W032_TIPO_ACCREDITO_AB = '2';

implementation

uses W001UIrisWebDtM, medpIWMessageDlg, IWGlobal;

{$R *.dfm}

function TW032FRichiestaMissioni.InizializzaAccesso:Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(C018.Periodo.Fine);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  // carica grid mezzi trasporto
  PopolaMezzi;

  if WR000DM.Responsabile then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
  end;

  // aggiorna visualizzazione
  VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 14 OK }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    RimuoviNotifiche;
  end;
end;

procedure TW032FRichiestaMissioni.IWAppFormCreate(Sender: TObject);
var
  LURLDoc: String;
  LDatiPersonalizzati: String;
begin
  Tag:=IfThen(WR000DM.Responsabile,441,440);
  inherited;

  AddScrollBarManager('divscrollable');

  // visualizzazione link a eventuale documento informativo
  LURLDoc:=ExtractFileName(Parametri.CampiRiferimento.C8_W032DocumentoMissioni).Trim;
  { DONE : TEST IW 14 OK }
  lnkDocumento.Visible:=(LURLDoc <> '') and (TFile.Exists(TA000FInterfaccia(gSC).MEDPFilesDir + LURLDoc));

  // inizializzazione dati record richiesta
  CleanRecordRichiesta;

  W032DM:=TW032FRichiestaMissioniDM.Create(Self);

  // individua su M025 i dati personalizzati da estrarre nella selezione anagrafica
  W032DM.selM025DatiAnagPers.Close;
  W032DM.selM025DatiAnagPers.Open;
  while not W032DM.selM025DatiAnagPers.Eof do
  begin
    LDatiPersonalizzati:=LDatiPersonalizzati + Format(',V430.T430%s',[W032DM.selM025DatiAnagPers.FieldByName('DATO_ANAGRAFICO').AsString]);
    W032DM.selM025DatiAnagPers.Next;
  end;
  W032DM.selM025DatiAnagPers.Close;

  // elenco campi da includere nella query anagrafica
  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430COMUNE,V430.T430D_COMUNE,V430.T430COMUNE_DOM_BASE,V430.T430D_COMUNE_DOM_BASE' + LDatiPersonalizzati;

  // verifica la presenza della function personalizzata USR_M020M021F_FILTROITER
  // per il filtro dei codici rimborso / anticipo
  try
    W032DM.selFiltroM020.Execute;
    FFiltroUserM020:=W032DM.selFiltroM020.FieldAsInteger(0) = 1;
  except
    FFiltroUserM020:=False;
  end;

  // VARESE_PROVINCIA
  // verifica la presenza della function personalizzata USR_M140F_PERIODO_VALIDO
  // per il controllo di coerenza con le timbrature
  try
    W032DM.selValiditaPeriodo.Execute;
    FCtrlValiditaPeriodo:=W032DM.selValiditaPeriodo.FieldAsInteger(0) = 1;
  except
    FCtrlValiditaPeriodo:=False;
  end;

  // verifica presenza di codici di anticipo
  try
    W032DM.selCountAnticipi.Execute;
    FGestAnticipi:=W032DM.selCountAnticipi.FieldAsInteger(0) > 0;
  except
    FGestAnticipi:=False;
  end;
  FModificaAnticipiAut:=False;

  // controllo esistenza dati personalizzati per le missioni web
  try
    W032DM.selCountDatiPers.Execute;
    FEsistonoDatiPersonalizzati:=W032DM.selCountDatiPers.FieldAsInteger(0) > 0;
  except
    FEsistonoDatiPersonalizzati:=False;
  end;

  lblCapitoloTrasferta.Visible:=W032DM.GestCapitoliTrasferta;
  cmbCapitoloTrasferta.Visible:=W032DM.GestCapitoliTrasferta;
  descCapitoloTrasferta.Visible:=W032DM.GestCapitoliTrasferta;

  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
  // la combobox del flag destinazione deve essere in sola lettura se:
  // - l'indicazione di località libere nel percorso non è permessa
  // - tutte le località su M042 hanno il COD_ISTAT impostato
  FFlagDestinazioneReadOnly:=False;
  if Parametri.CampiRiferimento.C8_W032TappeSoloSuDistanziometro = 'S' then
  begin
    W032DM.selM042Count.Execute;
    FFlagDestinazioneReadOnly:=W032DM.selM042Count.FieldAsInteger('NUM_REC_CODISTAT') = W032DM.selM042Count.FieldAsInteger('NUM_REC_TOT');
  end;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

  Iter:=ITER_MISSIONI;
  W032DM.C018:=C018;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W032DM.selM140,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W032DM.selM140,tiRichiesta);
  C018.Periodo.SetVuoto;
  
  // impostazione tab
  tabMissioni.HasFiller:=True;
  tabMissioni.AggiungiTab('Dettaglio richiesta',rgDettaglio);
  if FGestAnticipi then
    tabMissioni.AggiungiTab('Anticipi',rgAnticipi)
  else
    rgAnticipi.Visible:=False;
  tabMissioni.AggiungiTab('Rimborsi',rgRimborsi);
  tabMissioni.AggiungiTab('Servizi attivi',rgDettaglioGG);
  tabMissioni.ActiveTab:=rgDettaglio;

  // tabella richieste
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  grdRichieste.medpDataSet:=W032DM.selM140;
  grdRichieste.medpTestoNoRecord:='Nessuna richiesta';

  // tabella anticipi (no paginazione)
  grdAnticipi.medpDataSet:=W032DM.selM160;
  grdAnticipi.medpTestoNoRecord:='Nessun anticipo';

  // tabella dettaglio giornaliero (no paginazione)
  grdDettaglioGG.medpDataSet:=W032DM.selM143;
  grdDettaglioGG.medpTestoNoRecord:='Nessun servizio attivo';

  // tabella rimborsi (no paginazione)
  grdRimborsi.medpDataSet:=W032DM.selM150;
  grdRimborsi.medpTestoNoRecord:='Nessun rimborso';

  FCssIniCgp:=cgpMotivEstero.Css;

  FQSCodRegole:=TQueryStorico.Create(nil);
  FQSCodRegole.Session:=SessioneOracle;
  FRegolaM010.Codice:='';
  FRegolaM010.Descrizione:='';
  FRegolaM010.AbilRimb:='';
  FRegolaM010.AbilIndKm:='';
  FRegolaM010.TipoRegistrazione:='';
  FRegolaM010.ArrotTariffaDopoRiduzione:='';

  FImgConfermaAnt:=nil;
  FImgConfermaRimb:=nil;

  // inizializzazione variabili
  FOldId:=-1;
  FForzaRefreshListe:=False;
  FImportazioneRimborsi:=False;

  // stringlist
  FListaAnticipi:=TStringList.Create;
  FListaAnticipiAbilFase:=TStringList.Create; //+++
  FListaRimborsi:=TStringList.Create;
  FListaRimborsiPasto:=TStringList.Create;
  FListaValute:=TStringList.Create;

  // lista tipologie missione: inizialmente carica tutte le liste
  FListaTipiRegistrazione:=TStringList.Create;
  CaricaListaTipiRegistrazione;
end;

procedure TW032FRichiestaMissioni.IWAppFormRender(Sender: TObject);
var
  LJSCode: String;
begin
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;
  if tabMissioni.ActiveTab = rgDettaglio then
  begin
    lblMezzi.Enabled:=True;
  end
  else if tabMissioni.ActiveTab = rgAnticipi then
  begin
    // visibilità radiogroup delegato
    if (chkDelegato.Css = 'invisibile') and
       (rgpAccredito.Css = 'invisibile') then
    begin
      C190VisualizzaElemento(jqTemp,'w032Delegato',False);
    end;

    LJSCode:='$(".ui-autocomplete-input").css("width","24em");';
    if jQAutocomplete.OnReady.IndexOf(LJSCode) < 0 then
      jQAutocomplete.OnReady.Add(LJSCode);
  end;
  (*Se si vuole attivare un log su questa pagina
    per poi successivamente utilizzare InserisciMessaggio RegistraMsg.InserisciMessaggio()*)
  if RegistraMsg.ID = -1 then
    RegistraMsg.IniziaMessaggio(medpCodiceForm);
end;

procedure TW032FRichiestaMissioni.OnTabChanging(var AllowChange: Boolean; var Conferma: String);
begin
  AllowChange:=grdRichieste.medpStato = msBrowse;
end;

procedure TW032FRichiestaMissioni.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  if grdRichieste.medpStato <> msBrowse then
  begin
    case grdRichieste.medpStato of
      msInsert:
        Conferma:='Attenzione! La richiesta in fase di inserimento non è stata confermata.';
      msEdit:
        Conferma:='Attenzione! Sono presenti modifiche in corso non salvate che verranno perse.';
    end;
    Conferma:=Conferma + CRLF + 'Uscire comunque dalla funzione?';
  end;
end;

procedure TW032FRichiestaMissioni.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 441;
  // aggiorna visualizzazione
  if grdRichieste.medpStato = msBrowse then
    VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.rgpAccreditoClick(Sender: TObject);
begin
  chkDelegato.Enabled:=rgpAccredito.ItemIndex = 1;
  if not chkDelegato.Enabled then
  begin
    chkDelegato.Checked:=False;
    chkDelegatoClick(chkDelegato);
  end;
end;

procedure TW032FRichiestaMissioni.rgpTipoRichiesteClick(selCountDatiPers: TObject);
begin
  VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TW032FRichiestaMissioni.VisualizzaDipendenteCorrente;
begin
  inherited;
  GetRichiesteMissioni;
end;

procedure TW032FRichiestaMissioni.CleanRecordRichiesta;
// pulisce i dati della richiesta
begin
  FRichiesta.FlagDestinazione:='';
  FRichiesta.FlagIspettiva:='';
  FRichiesta.Partenza:='';
  FRichiesta.ElencoDestinazioni:='';
  FRichiesta.Rientro:='';
  FRichiesta.FlagPercorso:='';
  if FRichiesta.DatiPers <> nil then
    FreeAndNil(FRichiesta.DatiPers);
  FRichiesta.DatiPers:=TDictionary<String,TDatoPersonalizzato>.Create;
  FRichiesta.DataDa:=DATE_NULL;
  FRichiesta.DataA:=DATE_NULL;
  FRichiesta.OraDa:='';
  FRichiesta.OraA:='';
  FRichiesta.Delegato:='';
  FRichiesta.TipoRegistrazione:='';
  FRichiesta.PercorsoTesto:='';
end;

// AOSTA_REGIONE.ini
function TW032FRichiestaMissioni.RicalcoloTipoMissione(const PForzaImpostazioneTipoCompatibile: Boolean; var RErrMsg: String): Boolean;
// verifica ed eventualmente imposta il tipo missione verificando se è compatibile
// con le regole definite nella function personalizzata M011F_FILTROITER,
// (che verifica i dati presenti sul database)
// restituisce
//   True   se il tipo registrazione attualmente impostato è compatibile oppure
//          se ne è stato impostato uno automaticamente
//   False  se il tipo registrazione non è compatibile o se non esistono tipi compatibili
// casistiche considerate:
//   - se il filtro restituisce un resultset vuoto
//     -> restituisce False
//   - altrimenti
//     - se il tiporegistrazione è nullo:
//       -> imposta il primo codice disponibile (primo in ordine alfabetico)
//          e restituisce True
//     - se il tiporegistrazione è già impostato:
//       - se il tiporegistrazione è nel filtro
//         -> restituisce True
//       - se il tiporegistrazione non è nel filtro ->
//         valorizza messaggio di errore
//         - se PForzaImpostazioneTipoCompatibile = True
//           -> restituisce True
//         - se PForzaImpostazioneTipoCompatibile = False
//           -> restituisce False
var
  LTipoRegistrazione: String;
  LNewTipo: String;
  LOldCommitOnPost: Boolean;
begin
  RErrMsg:='';
  LNewTipo:='';

  // salva proprietà dataset missioni
  LOldCommitOnPost:=W032DM.selM140.CommitOnPost;

  try
    W032DM.selM011.Close;
    W032DM.selM011.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
    W032DM.selM011.Filtered:=True;
    W032DM.selM011.Open;
    if W032DM.selM011.RecordCount = 0 then
    begin
      // il filtro è vuoto -> restituisce False
      RErrMsg:='Nessun tipo missione previsto in base ai dati della richiesta!';
      Result:=False;
    end
    else
    begin
      LTipoRegistrazione:=W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString;
      if LTipoRegistrazione = '' then
      begin
        // tipo registrazione nullo -> imposta il primo codice disponibile nel filtro
        W032DM.selM011.First;
        LNewTipo:=W032DM.selM011.FieldByName('CODICE').AsString;
        Result:=True;
      end
      else
      begin
        // tipo registrazione impostato: lo cerca nel filtro
        if W032DM.selM011.SearchRecord('CODICE',LTipoRegistrazione,[srFromBeginning]) then
        begin
          // se il tipo è presente nel filtro restituisce True
          Result:=True;
        end
        else
        begin
          // se PForzaImpostazioneTipoCompatibile restituisce True, altrimenti False
          // in ogni caso valorizza il messaggio di errore
          Result:=PForzaImpostazioneTipoCompatibile;
          RErrMsg:=Format('Il tipo missione indicato (%s)'#13#10'non è compatibile con i dati della missione.',
                          [VarToStr(W032DM.selM011Lookup.Lookup('CODICE',LTipoRegistrazione,'DESCRIZIONE'))]);
          if PForzaImpostazioneTipoCompatibile then
          begin
            W032DM.selM011.First;
            LNewTipo:=W032DM.selM011.FieldByName('CODICE').AsString;
            RErrMsg:=RErrMsg + Format(#13#10'E'' stata impostata automaticamente una tipologia'#13#10'di missione compatibile (%s).'#13#10'Si prega di controllare i dati della richiesta n. %s.',
                                      [VarToStr(W032DM.selM011Lookup.Lookup('CODICE',LNewTipo,'DESCRIZIONE')),
                                       W032DM.selM140.FieldByName('PROTOCOLLO').AsString]);
          end;
        end;
      end;
    end;

    // update del tipo registrazione se necessario
    if (LNewTipo <> '') and
       (LNewTipo <> LTipoRegistrazione) then
    begin
      // esegue update senza committare
      W032DM.selM140.CommitOnPost:=False;
      W032DM.selM140.Edit;
      W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString:=LNewTipo;
      W032DM.selM140.Post;
    end;
  except
    on E: Exception do
    begin
      RErrMsg:=E.Message;
      Result:=False;
    end;
  end;

  // ripristina commitonpost
  W032DM.selM140.CommitOnPost:=LOldCommitOnPost;
end;
// AOSTA_REGIONE.fine

procedure TW032FRichiestaMissioni.LeggiRegolaMissione(Data:TDateTime;VisualizzaMessaggio:Boolean = True);
var
  LDatoRegola,
  LCodiceRegole,
  LTipoRegistrazione,
  LFlagDest,
  LFlagIspettiva:string;
begin
  if grdRichieste.medpStato = msInsert then
  begin
    LFlagDest:=FRichiesta.FlagDestinazione;
    LFlagIspettiva:=FRichiesta.FlagIspettiva;
  end
  else
  begin
    LFlagDest:=W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString;
    LFlagIspettiva:=W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString;
  end;
  LFlagDest:=IfThen(LFlagDest = 'E','S','N');

  FRegoleTrovate:=True;
  LCodiceRegole:='';
  LTipoRegistrazione:='';
  try
    LDatoRegola:='T430' + Parametri.CampiRiferimento.C8_Missione;
    FQSCodRegole.GetDatiStorici(LDatoRegola,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,Data);
    if FQSCodRegole.LocDatoStorico(Data) then
      LCodiceRegole:=FQSCodRegole.FieldByName(LDatoRegola).AsString;

    // estrae tipo missione da tabella di decodifica
    // in base a flag estero + flag ispettiva
    if (Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S') and
       (grdRichieste.medpStato in [msEdit,msInsert]) then
    begin
      // tipo registrazione
      LTipoRegistrazione:=FRichiesta.TipoRegistrazione;
    end
    else if grdRichieste.medpStato = msBrowse then
    begin
      // in caso di browse rilegge il parametro da tabella
      // se si tratta di insert o update viene invece rideterminato dalla M012
      LTipoRegistrazione:=W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString;
    end;

    // AOSTA_REGIONE.ini
    // il tipo registrazione è ora determinato in base alla function M011F_FILTROITER
    FListaTipiRegistrazione.Clear;
    W032DM.selM011.Close;
    W032DM.selM011.ClearVariables;
    W032DM.selM011.SetVariable('REGOLA',LCodiceRegole);
    if grdRichieste.medpStato <> msInsert then
      W032DM.selM011.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
    W032DM.selM011.Filtered:=True;
    try
      W032DM.selM011.Open;
      while not W032DM.selM011.Eof do
      begin
        if (LTipoRegistrazione = '') and (W032DM.selM011.RecNo = 1) then
          LTipoRegistrazione:=W032DM.selM011.FieldByName('CODICE').AsString;
        FListaTipiRegistrazione.Add(Format('%s=%s',[W032DM.selM011.FieldByName('DESCRIZIONE').AsString,W032DM.selM011.FieldByName('CODICE').AsString]));
        W032DM.selM011.Next;
      end;
    except
      on E: EOracleError do
      begin
        MsgBox.MessageBox(Format('%s',[E.Message]),ERRORE);
      end;
      on E: Exception do
        raise;
    end;
    // AOSTA_REGIONE.fine

    if (LCodiceRegole <> '') and (LTipoRegistrazione <> '') then
    begin
      if (W032DM.selM010.GetVariable('DECORRENZA') <> Data) or
         (W032DM.selM010.GetVariable('TIPOREGISTRAZIONE') <> LTipoRegistrazione) or
         (W032DM.selM010.GetVariable('CODICE') <> LCodiceRegole) then
      begin
        W032DM.selM010.Close;
        W032DM.selM010.SetVariable('DECORRENZA',Data);
        W032DM.selM010.SetVariable('TIPOREGISTRAZIONE',LTipoRegistrazione);
        W032DM.selM010.SetVariable('CODICE',LCodiceRegole);
        W032DM.selM010.Open;
      end;
    end;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox('Errore durante la lettura delle regole della missione:'#13#10 +
                        E.Message + ' (' + E.ClassName + ')'#13#10#13#10 +
                        'Informazioni per verifica anomalia'#13#10 +
                        'Codice regola (' + Parametri.CampiRiferimento.C8_Missione + '): ' + LCodiceRegole + #13#10 +
                        'Tipo missione: ' + LTipoRegistrazione + #13#10 +
                        'Data riferimento: ' + FormatDateTime('dd/mm/yyyy',Data) + #13#10 +
                        'Si prega di contattare l''ufficio competente.',ERRORE);
      Exit;
    end;
  end;

  // gestione regola non trovata:
  // non si controlla in fase di inserimento perchè i dati della missione non sono ancora stati registrati
  if (grdRichieste.medpStato <> msInsert) or (LTipoRegistrazione <> '') then
  begin
    if (not W032DM.selM010.Active) or (W032DM.selM010.Active and (W032DM.selM010.RecordCount = 0)) then
    begin
      if VisualizzaMessaggio then
      begin
        MsgBox.MessageBox('Regole della missione non trovate' + IfThen(WR000DM.Responsabile,' per il dipendente e la tipologia di trasferta') +
                          ' in data ' + Data.ToString + '.' + CRLF +
                          'Codice regola (' + Parametri.CampiRiferimento.C8_Missione + '): ' + IfThen(LCodiceRegole = '<non trovato>','',LCodiceRegole) + CRLF +
                          'Tipo missione: ' + IfThen(LTipoRegistrazione = '','<non trovato>',LTipoRegistrazione) + CRLF +
                          'Data riferimento: ' + Data.ToString + CRLF +
                          'Si prega di contattare l''ufficio competente.',ERRORE);
      end;
      FRegoleTrovate:=False;
    end
    else
    begin
      // imposta dati regola
      FRegolaM010.Codice:=LCodiceRegole;
      FRegolaM010.Descrizione:=W032DM.selM010.FieldByName('DESCRIZIONE').AsString;
      FRegolaM010.AbilRimb:=W032DM.selM010.FieldByName('CODICI_RIMBORSI').AsString;
      FRegolaM010.AbilIndKm:=W032DM.selM010.FieldByName('CODICI_INDENNITAKM').AsString;
      FRegolaM010.RimbKmAuto:=W032DM.selM010.FieldByName('RIMB_KM_AUTO').AsString;
      FRegolaM010.IndKmAuto:=W032DM.selM010.FieldByName('IND_KM_AUTO').AsString;
      FRegolaM010.TipoRegistrazione:=LTipoRegistrazione;
      FRegolaM010.ArrotTariffaDopoRiduzione:=W032DM.selM010.FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.lnkDocumentoClick(Sender: TObject);
var
  URLDoc: String;
begin
  URLDoc:=ExtractFileName(Parametri.CampiRiferimento.C8_W032DocumentoMissioni);
  VisualizzaFile(URLDoc,'Richiesta trasferte - documento informativo',nil,nil,fdGlobal);
end;

procedure TW032FRichiestaMissioni.tabMissioniTabControlChange(Sender: TObject);
begin
  FForzaRefreshListe:=False;
  if tabMissioni.ActiveTab = rgAnticipi then
  begin
    // se si passa al tab anticipi forza la rilettura delle liste
    // dei codici di anticipo selezionabili
    FForzaRefreshListe:=True;
    CaricaListe;
  end
  else if tabMissioni.ActiveTab = rgRimborsi then
  begin
    // se si passa al tab rimborsi forza la rilettura delle liste
    // dei codici di rimborso selezionabili
    FForzaRefreshListe:=True;
    CaricaListe;

    // se necessario visualizza label di autorizzazione rimborsi
    if lblAutRimborsi.Caption <> '' then
    begin
      AddToInitProc('$("#T032AutRimborsi").show();');
    end;
  end
end;

procedure TW032FRichiestaMissioni.tabMissioniTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange:=(grdAnticipi.medpStato = msBrowse) and
               (grdRimborsi.medpStato = msBrowse);
end;

procedure TW032FRichiestaMissioni.chkMezzoAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i,j: Integer;
  LAbilita: Boolean;
  LDatiMezzo: TDatiMezzo;
  LIWG: TmeIWGrid;
  LIWEdt: TmeIWEdit;
  LIWRadio: TmeTIWAdvRadioGroup;
  LIWCmb: TmeIWComboBox;
begin
  // mezzo con FLAG_MOTIVAZIONE = 'S' e/o FLAG_TARGA = 'S'
  LAbilita:=(Sender as TmeIWCheckBox).Checked;
  LDatiMezzo:=((Sender as TmeIWCheckBox).medpTag as TDatiMezzo);
  i:=LDatiMezzo.Riga;

  // abilita campo motivazione e/o targa
  if grdMezzi.Cell[i,0].Control is TmeIWGrid then
  begin
    LIWG:=TmeIWGrid(grdMezzi.Cell[i,0].Control);
    for j:=1 to LIWG.ColumnCount - 1 do
    begin
      if LIWG.Cell[0,j].Control <> nil then
      begin
        LIWEdt:=(LIWG.Cell[0,j].Control as TmeIWEdit);
        if ((LDatiMezzo.FlagMotivazione = 'S') and
            ((LIWEdt.medpTag as TDatiMezzo).FlagMotivazione = 'S')) or
           ((LDatiMezzo.FlagTarga = 'S') and
            ((LIWEdt.medpTag as TDatiMezzo).FlagTarga = 'S')) then
        begin
          AbilitazioneComponente(LIWEdt,LAbilita);
          if not LAbilita then
            LIWEdt.Text:='';
          // se l'edit è relativo alla motivazione imposta il watermark
          if ((LIWEdt.medpTag as TDatiMezzo).FlagMotivazione = 'S') and
             (LAbilita) then
          begin
            LIWEdt.medpWatermark:='Specificare...';
          end;
          // se l'edit è relativo a un mezzo con flag_targa, propone l'ultima targa utilizzata
          if ((LIWEdt.medpTag as TDatiMezzo).FlagTarga = 'S') and
             (LAbilita) and
             (LIWEdt.Text = '') then
          begin
            // estrae la targa indicata nell'ultima richiesta in cui si utilizza un automezzo
            // nota: viene distinto l'automezzo proprio da quello di servizio
            W032DM.selM170Targa.Close;
            W032DM.selM170Targa.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
            W032DM.selM170Targa.SetVariable('FLAG_TIPO',M020TIPO_MEZZO);
            W032DM.selM170Targa.SetVariable('FLAG_MEZZO_PROPRIO',LDatiMezzo.FlagMezzoProprio);
            W032DM.selM170Targa.Open;
            if W032DM.selM170Targa.RecordCount > 0 then
              LIWEdt.Text:=W032DM.selM170Targa.FieldByName('TARGA').AsString;
            W032DM.selM170Targa.Close;
          end;
        end;
      end;
    end;
  end;

  // verifica se automezzo proprio
  if LDatiMezzo.FlagMezzoProprio = 'S' then
  begin
    // verifica se occorre visualizzare o meno la riga successiva
    // con il radiogroup per la corresponsione delle spese viaggio
    if grdRichieste.medpStato = msBrowse then
    begin
      LAbilita:=LAbilita and (W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'N');
    end
    else
    begin
      i:=grdRichieste.medpRigaDiCompGriglia(cdsM140.FieldByName('DBG_ROWID').AsString);
      LIWCmb:=(grdRichieste.medpCompCella(i,'C_ISPETTIVA',0) as TmeIWComboBox);
      // se il componente non è creato significa che non si è abilitati alla modifica -> legge valore dal dataset
      if LIWCmb = nil then
        LAbilita:=LAbilita and (W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'N')
      else
        LAbilita:=LAbilita and (LIWCmb.Items.ValueFromIndex[LIWCmb.ItemIndex] = 'N');
    end;
    // applica visualizzazione su riga succ.
    //i:=DatiMezzo.Riga + 1;
    LIWRadio:=(Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup);
    //IWRadio.Css:=IfThen(Abilita,'intestazione width60chr','invisibile');
    LIWRadio.Css:='intestazione width60chr';
    C190VisualizzaElementoAsync(JQuery,LIWRadio.HTMLName,LAbilita);
  end;
end;

procedure TW032FRichiestaMissioni.cmbIspettivaAsyncChange(Sender: TObject; EventParams: TStringList);
var
  i: Integer;
  Ispettiva,Abilita: Boolean;
  DatiMezzo: TDatiMezzo;
  IWG: TmeIWGrid;
  IWRgp: TmeTIWAdvRadioGroup;
begin
  Ispettiva:=(Sender as TmeIWComboBox).Items.ValueFromIndex[(Sender as TmeIWComboBox).ItemIndex] = 'S';

  // abilitazione per mezzi trasporto
  for i:=0 to grdMezzi.RowCount - 1 do
  begin
    Abilita:=not Ispettiva;
    if (grdMezzi.Cell[i,0].Control is TmeIWGrid) then
    begin
      IWG:=(grdMezzi.Cell[i,0].Control as TmeIWGrid);
      DatiMezzo:=((IWG.Cell[0,0].Control as TmeIWCheckBox).medpTag as TDatiMezzo);

      // corresponsione spese di viaggio
      if DatiMezzo.FlagMezzoProprio = 'S' then
      begin
        Abilita:=Abilita and ((IWG.Cell[0,0].Control as TmeIWCheckBox).Checked);
        (*
        if grdMezzi.Cell[i,0].Control is TmeTIWAdvRadioGroup then
        begin
          IWRgp:=(grdMezzi.Cell[i,0].Control as TmeTIWAdvRadioGroup);
          C190VisualizzaElementoAsync(JQuery,IWRgp.HTMLName,Abilita);
        end;
        *)
        IWRgp:=(Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup);
        C190VisualizzaElementoAsync(JQuery,IWRgp.HTMLName,Abilita);
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.PopolaMezzi;
// popola la tabella dei mezzi di trasporto
var
  i,c: Integer;
  IWC: TIWCustomControl;
  LIWGrd: TmeIWGrid;
  E1,E2: String;
  MezzoProprioExist:Boolean;
  LIWRgp: TmeTIWAdvRadioGroup;
  LIWChk: TmeIWCheckBox;
  LDatiMezzo: TDatiMezzo;
  LIWEdt: TmeIWEdit;
begin
  W032DM.selM020Mezzi.Close;
  W032DM.selM020Mezzi.Open;

  MezzoProprioExist:=False;
  grdMezzi.RowCount:=W032DM.selM020Mezzi.RecordCount;
  i:=-1;
  while not W032DM.selM020Mezzi.Eof do
  begin
    inc(i);

    // crea grid
    LIWGrd:=TmeIWGrid.Create(Self);
    LIWGrd.Parent:=Self;
    LIWGrd.Css:='';
    LIWGrd.ExtraTagParams.Add('style=width: auto');
    LIWGrd.RowCount:=1;
    LIWGrd.ColumnCount:=1 + IfThen(W032DM.selM020Mezzi.FieldByName('FLAG_MOTIVAZIONE').AsString = 'S',1,0) +
                            IfThen(W032DM.selM020Mezzi.FieldByName('FLAG_TARGA').AsString = 'S',1,0);

    // checkbox per selezione mezzo di trasporto
    c:=0;
    IWC:=C190DBGridCreaChkBox(Self,Self,W032DM.selM020Mezzi.FieldByName('CODICE').AsString,W032DM.selM020Mezzi.FieldByName('DESCRIZIONE').AsString);
    LIWChk:=(IWC as TmeIWCheckBox);
    LIWChk.Css:='intestazione';
    LIWChk.medpTag:=TDatiMezzo.Create;
    LDatiMezzo:=(LIWChk.medpTag as TDatiMezzo);
    LDatiMezzo.Riga:=i;
    LDatiMezzo.FasiCompetenza:=W032DM.selM020Mezzi.FieldByName('FASI_COMPETENZA').AsString;
    LDatiMezzo.FlagAnticipo:=W032DM.selM020Mezzi.FieldByName('FLAG_ANTICIPO').AsString;
    LDatiMezzo.FlagMotivazione:=W032DM.selM020Mezzi.FieldByName('FLAG_MOTIVAZIONE').AsString;
    LDatiMezzo.FlagTarga:=W032DM.selM020Mezzi.FieldByName('FLAG_TARGA').AsString;
    LDatiMezzo.FlagMezzoProprio:=W032DM.selM020Mezzi.FieldByName('FLAG_MEZZO_PROPRIO').AsString;
    if (W032DM.selM020Mezzi.FieldByName('FLAG_MOTIVAZIONE').AsString = 'S') or
       (W032DM.selM020Mezzi.FieldByName('FLAG_TARGA').AsString = 'S') or
       (W032DM.selM020Mezzi.FieldByName('FLAG_MEZZO_PROPRIO').AsString = 'S') then
    begin
      LIWChk.OnAsyncClick:=chkMezzoAsyncClick;
    end;

    LIWGrd.Cell[0,c].Control:=IWC;

    // edit per eventuale motivazione
    if W032DM.selM020Mezzi.FieldByName('FLAG_MOTIVAZIONE').AsString = 'S' then
    begin
      inc(c);
      LIWGrd.Cell[0,c].Text:=' - Motivazione: ';
      IWC:=C190DBGridCreaEdit(Self,Self,W032DM.selM020Mezzi.FieldByName('CODICE').AsString,'width30chr','');

      LIWEdt:=(IWC as TmeIWEdit);
      LIWEdt.MaxLength:=2000;
      LIWEdt.medpTag:=TDatiMezzo.Create;
      LDatiMezzo:=(LIWEdt.medpTag as TDatiMezzo);
      LDatiMezzo.FlagAnticipo:=W032DM.selM020Mezzi.FieldByName('FLAG_ANTICIPO').AsString;
      // per l'edit indica solo il flag motivazione
      LDatiMezzo.FlagMotivazione:=W032DM.selM020Mezzi.FieldByName('FLAG_MOTIVAZIONE').AsString;

      LIWGrd.Cell[0,c].Control:=IWC;
    end;

    // edit per eventuale targa
    if W032DM.selM020Mezzi.FieldByName('FLAG_TARGA').AsString = 'S' then
    begin
      inc(c);
      LIWGrd.Cell[0,c].Text:=' - ' + IfThen(W032DM.selM020Mezzi.FieldByName('FLAG_MEZZO_PROPRIO').AsString = 'S','(**) ') + 'Targa n.: ';
      IWC:=C190DBGridCreaEdit(Self,Self,W032DM.selM020Mezzi.FieldByName('CODICE').AsString,'input10 maiuscolo','');
      LIWEdt:=(IWC as TmeIWEdit);
      LIWEdt.MaxLength:=15;
      LIWEdt.medpTag:=TDatiMezzo.Create;
      LDatiMezzo:=(LIWEdt.medpTag as TDatiMezzo);
      LDatiMezzo.FlagAnticipo:=W032DM.selM020Mezzi.FieldByName('FLAG_ANTICIPO').AsString;
      // per l'edit indica il flag targa + mezzo proprio
      LDatiMezzo.FlagTarga:=W032DM.selM020Mezzi.FieldByName('FLAG_TARGA').AsString;
      LDatiMezzo.FlagMezzoProprio:=W032DM.selM020Mezzi.FieldByName('FLAG_MEZZO_PROPRIO').AsString;

      LIWGrd.Cell[0,c].Control:=IWC;
    end;
    grdMezzi.Cell[i,0].Control:=LIWGrd;

    // se automezzo proprio e visita non ispettiva crea nuova riga con radiogroup
    // per scegliere se corresponsione spese viaggio
    // MezzoProprioExist nel caso in cui ci siano 2 mezzi propri(teoricamente errato) creo un solo radiogroup
    if (Not MezzoProprioExist) and (W032DM.selM020Mezzi.FieldByName('FLAG_MEZZO_PROPRIO').AsString = 'S') then
    begin
      MezzoProprioExist:=True;
      inc(i);
      grdMezzi.RowCount:=grdMezzi.RowCount + 1;
      // radiogroup per scelta corresp. spese viaggio
      E1:='Verificata in via preventiva la sussistenza dei presupposti all''utilizzo del mezzo proprio,<br/>' +
          '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;se ne autorizza l''uso e la successiva corresponsione delle spese di viaggio.';
      E2:='Si autorizza l''uso del mezzo proprio senza corresponsione delle spese di viaggio';
      grdMezzi.Cell[i,0].Css:='padding_sx_20px';
      grdMezzi.Cell[i,0].Control:=C190DBGridCreaRadioGroup(Self,Self,W032DM.selM020Mezzi.FieldByName('CODICE').AsString,Format('"%s" %s',[E1,E2]),'invisibile','');

      LIWRgp:=(grdMezzi.Cell[i,0].Control as TmeTIWAdvRadioGroup);
      LIWRgp.Name:='rgpMezzoProprio';
      LIWRgp.Layout:=glVertical;
      LIWRgp.Columns:=1;
      LIWRgp.ItemIndex:=W032DM.GetSpeseMezzoDefaultIndex;
      LIWRgp.medpTag:=TDatiMezzo.Create;
      LDatiMezzo:=(LIWRgp.medpTag as TDatiMezzo);
      LDatiMezzo.FasiCompetenza:=W032DM.selM020Mezzi.FieldByName('FASI_COMPETENZA').AsString;
    end;
    W032DM.selM020Mezzi.Next;
  end;
end;

procedure TW032FRichiestaMissioni.CaricaListaTipiRegistrazione;
// ricarica la lista dei tipi registrazione senza filtrare i codici con la function M011F_FILTROITER
begin
  FListaTipiRegistrazione.Clear;
  W032DM.selM011.Close;
  W032DM.selM011.ClearVariables;
  W032DM.selM011.Filtered:=True;
  try
    W032DM.selM011.Open;
    while not W032DM.selM011.Eof do
    begin
      FListaTipiRegistrazione.Add(Format('%s=%s',[W032DM.selM011.FieldByName('DESCRIZIONE').AsString,W032DM.selM011.FieldByName('CODICE').AsString]));
      W032DM.selM011.Next;
    end;
  except
    on E: EOracleError do
    begin
      // errore nella function M011F_FILTROITER
      MsgBox.MessageBox(Format('%s',[E.Message]),ERRORE);
      Exit;
    end;
    on E: Exception do
      raise;
  end;
end;

procedure TW032FRichiestaMissioni.CaricaListe;
var
  LId: Integer;
  LFaseLiv: Integer;
  LFiltroCodici: String;
  LElencoRimb: String;
  LFiltroIndKm: String;
  LElencoIndKm: String;
  LFiltroM020: String;
  LCodice: String;
  LDescrizione: String;
  i: Integer;
  LFasiAbil: String;
begin
  LId:=W032DM.selM140.FieldByName('ID').AsInteger;

  // fase corrispondente al livello corrente
  LFaseLiv:=C018.FaseLivello[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger];

  // filtro sql personalizzato
  LFiltroM020:='and    exists (select ''X'' from dual where USR_M020M021F_FILTROITER(' + IntToStr(LId) + ',''%s'',CODICE) = ''S'')';

  // codici di rimborsi / anticipi abilitati
  if FRegolaM010.AbilRimb = '' then
    LFiltroCodici:=''
  else
  begin
    LElencoRimb:=StringReplace(FRegolaM010.AbilRimb,',',''',''',[rfReplaceAll]);
    LFiltroCodici:=Format('and CODICE in (''%s'')',[LElencoRimb]);
  end;

  // lista voci anticipo
  if (FForzaRefreshListe) or
     (not W032DM.selM020Anticipi.Active) or
     (VarToStr(W032DM.selM020Anticipi.GetVariable('FILTRO_CODICI')) <> LFiltroCodici) or
     (FOldId <> LId) then
  begin
    FCodAnticipoPastoM020:='';
    FListaAnticipi.Clear;
    W032DM.selM020Anticipi.Close;
    W032DM.selM020Anticipi.SetVariable('FILTRO_CODICI',LFiltroCodici);
    if FFiltroUserM020 then
      W032DM.selM020Anticipi.SetVariable('FILTRO',Format(LFiltroM020,['M020A']));
    W032DM.selM020Anticipi.Filtered:=True;
    W032DM.selM020Anticipi.Open;
    while not W032DM.selM020Anticipi.Eof do
    begin
      LCodice:=W032DM.selM020Anticipi.FieldByName('CODICE').AsString;
      LDescrizione:=W032DM.selM020Anticipi.FieldByName('DESCRIZIONE').AsString;
      FListaAnticipi.Add(Format('%s=%s',[LDescrizione,LCodice]));
      if W032DM.selM020Anticipi.FieldByName('TIPO').AsString = M020TIPO_PASTO then
        FCodAnticipoPastoM020:=LCodice;
      W032DM.selM020Anticipi.Next;
    end;
  end;

  //+++.ini
  // per il responsabile determina la lista di anticipi filtrata in base alle fasi abilitate
  if WR000DM.Responsabile then
  begin
    FListaAnticipiAbilFase.Clear;
    for i:=0 to FListaAnticipi.Count - 1 do
    begin
      LCodice:=FListaAnticipi.ValueFromIndex[i];
      LFasiAbil:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',LCodice,'FASI_COMPETENZA'));
      if (LFasiAbil <> '') and R180In(LFaseLiv.ToString,LFasiAbil.Split([','])) then
        FListaAnticipiAbilFase.Add(FListaAnticipi[i]);
    end;
  end;
  //+++.fine

  // codici di indennità km abilitate
  if FRegolaM010.AbilIndKm = '' then
    LFiltroIndKm:=''
  else
  begin
    LElencoIndKm:=FRegolaM010.AbilIndKm.Replace(',',''',''',[rfReplaceAll]);
    LFiltroIndKm:=Format('and CODICE in (''%s'')',[LElencoIndKm]);
  end;

  // lista voci rimborsi e indennità km
  if (FForzaRefreshListe) or
     (not W032DM.selM020Rimborsi.Active) or
     (FOldId <> LId) or
     (VarToStr(W032DM.selM020Rimborsi.GetVariable('FILTRO_CODICI')) <> LFiltroCodici) or
     (not W032DM.selM021.Active) or
     (R180VarToDateTime(W032DM.selM021.GetVariable('DATA')) <> W032DM.selM140.FieldByName('DATAA').AsDateTime) or
     (VarToStr(W032DM.selM021.GetVariable('FILTRO_CODICI')) <> LFiltroIndKm) then
  begin
    FListaRimborsi.Clear;
    FListaRimborsiPasto.Clear;

    // lista voci rimborso
    W032DM.selM020Rimborsi.Close;
    W032DM.selM020Rimborsi.SetVariable('FILTRO_CODICI',LFiltroCodici);
    if FFiltroUserM020 then
      W032DM.selM020Rimborsi.SetVariable('FILTRO',Format(LFiltroM020,['M020R']));
    W032DM.selM020Rimborsi.Filtered:=True;
    W032DM.selM020Rimborsi.Open;
    while not W032DM.selM020Rimborsi.Eof do
    begin
      LCodice:=W032DM.selM020Rimborsi.FieldByName('CODICE').AsString;
      LDescrizione:=W032DM.selM020Rimborsi.FieldByName('DESCRIZIONE').AsString;
      FListaRimborsi.Add(Format('%s=%s',[LDescrizione,LCodice]));
      if W032DM.selM020Rimborsi.FieldByName('TIPO').AsString = M020TIPO_PASTO then
      begin
        FListaRimborsiPasto.Add(LCodice);
      end;
      W032DM.selM020Rimborsi.Next;
    end;

    // indennità km (caricate solo se è stato selezionato come mezzo di trasporto "automezzo proprio")
    W032DM.selM021.Close;
    W032DM.selM021.SetVariable('DATA',W032DM.selM140.FieldByName('DATAA').AsDateTime);
    W032DM.selM021.SetVariable('FILTRO_CODICI',LFiltroIndKm);
    if FFiltroUserM020 then
      W032DM.selM021.SetVariable('FILTRO',Format(LFiltroM020,['M021']));
    W032DM.selM021.Open;

    // in caso di gestione dei rimborsi km automatici, effettua queste considerazioni:
    // - se è stato indicato il codice di indennità automatica, e questo è presente nella
    //   lista dei rimborsi filtrati in base alla regola e al filtro dizionario, utilizza questo
    // - altrimenti si utilizza il primo codice di indennità km disponibile (v. ciclo successivo)
    W032DM.RimbAutomatico.Abilitato:=(FRegolaM010.RimbKmAuto = 'S');

    if (W032DM.RimbAutomatico.Abilitato) and
       (W032DM.selM021.RecordCount > 0) and
       (W032DM.selM021.SearchRecord('CODICE',FRegolaM010.IndKmAuto,[srFromBeginning])) then
    begin
      W032DM.RimbAutomatico.CodIndKM:=W032DM.selM021.FieldByName('CODICE').AsString;
    end
    else
    begin
      W032DM.RimbAutomatico.CodIndKM:='';
    end;

    // ciclo sui codici di indennità
    W032DM.selM021.First;
    while not W032DM.selM021.Eof do
    begin
      LCodice:=W032DM.selM021.FieldByName('CODICE').AsString;
      LDescrizione:=W032DM.selM021.FieldByName('DESCRIZIONE').AsString;

      // in caso di gestione dei rimborsi km automatici, se non è indicato
      // un codice valido si utilizza il primo codice di indennità km disponibile
      if (W032DM.RimbAutomatico.Abilitato) and
         (W032DM.RimbAutomatico.CodIndKM = '') and
         (W032DM.selM021.RecNo = 1) then
      begin
        W032DM.RimbAutomatico.CodIndKM:=LCodice;
      end;

      // il codice di indennità automatica non viene visualizzato nella lista
      if VarToStr(W032DM.selM150.Lookup('CODICE;AUTOMATICO',VarArrayOf([LCodice,'S']),'CODICE')) = '' then
        FListaRimborsi.Add(Format('%s=%s',[LDescrizione,LCodice]));

      W032DM.selM021.Next;
    end;
  end;

  // lista valute
  if (FForzaRefreshListe) or
     (not W032DM.selP030.Active) or
     (R180VarToDateTime(W032DM.selP030.GetVariable('DATA')) <> Parametri.DataLavoro) then
  begin
    FListaValute.Clear;
    W032DM.selP030.Close;
    W032DM.selP030.SetVariable('DATA',Parametri.DataLavoro);
    W032DM.selP030.Open;
    while not W032DM.selP030.Eof do
    begin
      // in caso di gestione dei rimborsi km automatici,
      // viene utilizzato il primo codice di valuta
      if W032DM.RimbAutomatico.Abilitato then
      begin
        if W032DM.selP030.RecNo = 1 then
          W032DM.RimbAutomatico.CodValuta:=W032DM.selP030.FieldByName('COD_VALUTA').AsString;
      end;
      FListaValute.Add(W032DM.selP030.FieldByName('DESCRIZIONE').AsString + '=' + W032DM.selP030.FieldByName('COD_VALUTA').AsString);
      W032DM.selP030.Next;
    end;
  end;

  //Lista capitoli trasferta (AOSTA_REGIONE)
  if W032DM.GestCapitoliTrasferta then
  begin
    R180SetVariable(W032DM.selM030,'PROGRESSIVO',W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(W032DM.selM030,'DATAA',W032DM.selM140.FieldByName('DATAA').AsDateTime);
    R180SetVariable(W032DM.selM030,'TIPOREGISTRAZIONE',W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString);
    W032DM.selM030.Open;
    W032DM.selM030.First;
    cmbCapitoloTrasferta.Items.Clear;
    while not W032DM.selM030.Eof do
    begin
      cmbCapitoloTrasferta.AddRow(Format('%s;%s',[W032DM.selM030.FieldByName('CODICE').AsString,W032DM.selM030.FieldByName('DESCRIZIONE').AsString]));
      W032DM.selM030.Next;
    end;
    cmbCapitoloTrasferta.Text:=W032DM.selM140.FieldByName('CAPITOLO_TRASFERTA').AsString;
    if grdRichieste.medpStato = msEdit then
    begin
      if W032DM.selM030.RecordCount = 0 then
        cmbCapitoloTrasferta.Text:=''
      else if W032DM.selM030.RecordCount = 1 then
        cmbCapitoloTrasferta.Text:=W032DM.selM030.FieldByName('CODICE').AsString;
    end;
    cmbCapitoloTrasfertaAsyncChange(cmbCapitoloTrasferta,nil,0,'');
  end;

  FOldId:=LId;
end;

procedure TW032FRichiestaMissioni.PopolaDatiPersonalizzati;
// popola i dati personalizzati delle missioni:
// - il checkgroup delle motivazioni per le trasferte estere
// - il checkgroup delle ipotesi per le trasferte estere
// - la tabella dei dati personalizzati
var
  Codice, Descrizione, Categoria, CategoriaPrec, Valori, DatoAnagrafico, QueryValore, ElencoFisso,
  Tabella, TabCodice, TabStorico, WidthCss, HintCampo, StileCampo, S,
  ValoreDefault, TestoSQLQueryValore, Valore: String;
  LFormato: Char;
  r, LungMax, FaseCorr, FaseLiv, MinFaseMod, MaxFaseMod, Righe, Prog: Integer;
  Obbligatorio, PrimaRottura, Elenco, ElencoTabellare, AbilRiga: Boolean;
  DatoPers: TDatoPersonalizzato;
  IWLbl: TmeIWLabel;
  IWC: TIWCustomControl;
  LIWCmb: TMedpIWMultiColumnComboBox;
  DSValori: TOracleDataSet;
const
  DATI_PERS_MAXWIDTH_CHAR = 40;   // num. max di caratteri per la width del dato personalizzato (la max-length rimane invariata!)
  DATI_PERS_MAXLENGTH     = 2000; // num. max di caratteri su database per i dati personalizzati
begin
  // checkgroup motivazioni e ipotesi trasf. estere
  cgpMotivEstero.Items.Clear;
  cgpIpotesiEstero.Items.Clear;

  // fase corrente della richiesta e fase del livello attuale
  if grdRichieste.medpStato = msInsert then
  begin
    FaseLiv:=M140FASE_INIZIALE;
    FaseCorr:=M140FASE_INIZIALE;
  end
  else
  begin
    FaseLiv:=C018.FaseLivello[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger];
    FaseCorr:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;
  end;

  // tabella dei dati personalizzati
  grdDati.RowCount:=1;
  r:=0;
  CategoriaPrec:='';
  PrimaRottura:=True;

  W032DM.selM025.Close;
  W032DM.selM025.Open;
  while not W032DM.selM025.Eof do
  begin
    Codice:=W032DM.selM025.FieldByName('CODICE').AsString;
    Descrizione:=W032DM.selM025.FieldByName('DESCRIZIONE').AsString;
    Categoria:=W032DM.selM025.FieldByName('CATEGORIA').AsString;

    // categorie speciali non modificabili
    if Categoria = MISSIONE_COD_CAT_ESTERO_MOTIVAZIONI then
    begin
      // motivazioni trasferte estere
      cgpMotivEstero.Items.Add(Descrizione);
      cgpMotivEstero.Values.Add(Codice);
    end
    else if Categoria = MISSIONE_COD_CAT_ESTERO_IPOTESI then
    begin
      // ipotesi trasferte estere
      cgpIpotesiEstero.Items.Add(Descrizione);
      cgpIpotesiEstero.Values.Add(Codice);
    end
    else
    begin
      // dati personalizzati
      DSValori:=nil;

      // controllo visibilità (per ora legata a categoria)
      if R180Between(FaseLiv,W032DM.selM025.FieldByName('MIN_FASE_VISIBILE_CAT').AsInteger,W032DM.selM025.FieldByName('MAX_FASE_VISIBILE_CAT').AsInteger) then
      begin
        // gestione rottura di categoria
        if Categoria <> CategoriaPrec then
        begin
          // 1/3 bordo superiore (esclude prima rottura di categoria)
          if not PrimaRottura then
          begin
            grdDati.Cell[r,0].Css:='riga_bianca bordo_top_categoria';
            grdDati.Cell[r,0].Text:='';
            grdDati.Cell[r,1].Css:='riga_bianca bordo_top_categoria';
            grdDati.Cell[r,1].Text:=' ';
            grdDati.RowCount:=grdDati.RowCount + 1;
            inc(r);
          end;

          // 2/3 riga di descrizione della categoria
          grdDati.Cell[r,0].Css:='riga_categoria';
          grdDati.Cell[r,0].Text:='<div style="position:relative; height:100%;">&nbsp;<span style="position:absolute; left:0; top:0; width:100%; height:100%;">' + W032DM.selM025.FieldByName('DESCRIZIONE_CAT').AsString + '</span></div>';
          grdDati.Cell[r,0].RawText:=True;
          grdDati.Cell[r,1].Css:='riga_categoria';
          grdDati.Cell[r,1].Text:=' ';
          grdDati.RowCount:=grdDati.RowCount + 1;
          inc(r);

          // 3/3 bordo inferiore
          grdDati.Cell[r,0].Css:='riga_bianca bordo_sx_categoria lineHeight0_5em';
          grdDati.Cell[r,0].Text:='';
          grdDati.Cell[r,1].Css:='riga_bianca bordo_dx_categoria lineHeight0_5em';
          grdDati.Cell[r,1].Text:=' ';
          grdDati.RowCount:=grdDati.RowCount + 1;
          inc(r);

          PrimaRottura:=False;
        end;

        // informazioni sul dato
        Valori:=W032DM.selM025.FieldByName('VALORI').AsString;
        Obbligatorio:=W032DM.selM025.FieldByName('OBBLIGATORIO').AsString = 'S';
        Righe:=W032DM.selM025.FieldByName('RIGHE').AsInteger;
        LFormato:=R180CarattereDef(W032DM.selM025.FieldByName('FORMATO').AsString);
        LungMax:=W032DM.selM025.FieldByName('LUNG_MAX').AsInteger;
        DatoAnagrafico:=W032DM.selM025.FieldByName('DATO_ANAGRAFICO').AsString;
        QueryValore:=W032DM.selM025.FieldByName('QUERY_VALORE').AsString;
        ElencoFisso:=W032DM.selM025.FieldByName('ELENCO_FISSO').AsString;
        ValoreDefault:=W032DM.selM025.FieldByName('VALORE_DEFAULT').AsString;
        Elenco:=(QueryValore <> '') or (DatoAnagrafico <> '') or (Valori <> '');

        // cerca di capire se il dato è tabellare (codice + descrizione) o meno
        ElencoTabellare:=False;
        if QueryValore <> '' then
        begin
          // elenco valori estratto da interrogazione di servizio
          W032DM.selQueryValore.SetVariable('NOME',QueryValore);
          try
            W032DM.selQueryValore.Execute;
            TestoSQLQueryValore:=W032DM.selQueryValore.FieldAsString(0);
          except
            TestoSQLQueryValore:='';
          end;

          if TestoSQLQueryValore <> '' then
          begin
            // crea e imposta proprietà dataset
            DSValori:=TOracleDataSet.Create(Self);
            DSValori.Session:=SessioneOracle;
            DSValori.ReadBuffer:=50;
            DSValori.ReadOnly:=True;

            // imposta testo e variabili sql
            DSValori.Close;
            DSValori.SQL.Text:=TestoSQLQueryValore;
            // gestione variabili
            DSValori.ClearVariables;
            DSValori.DeleteVariables;

            VariabiliQueryValore(DSValori);

            try
              DSValori.Open;
              ElencoTabellare:=DSValori.FieldCount > 1;
            except
              raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W032_ERR_FMT_QUERY_VALORE),
                                            [W032DM.selM025.FieldByName('DESCRIZIONE').AsString,QueryValore]));
            end;
          end;
        end
        else if DatoAnagrafico <> '' then
        begin
          // elenco valori estratto da dato personalizzato anagrafico
          A000GetTabella(DatoAnagrafico,Tabella,TabCodice,TabStorico);
          ElencoTabellare:=(Tabella <> '') and (Tabella.ToUpper <> 'T430_STORICO');
        end;

        // imposta l'oggetto da associare all'elemento dell'interfaccia come medpTag
        if LFormato = 'M' then
        begin
          DatoPers:=nil;
        end
        else
        begin
          DatoPers:=TDatoPersonalizzato.Create;
          DatoPers.Codice:=Codice;
          DatoPers.Descrizione:=Descrizione;
          DatoPers.Obbligatorio:=Obbligatorio;
          DatoPers.Formato:=LFormato;
          DatoPers.LungMax:=LungMax;
          DatoPers.DatoAnagrafico:=DatoAnagrafico;
          DatoPers.QueryValore:=QueryValore;
          DatoPers.Elenco:=Elenco;
          DatoPers.ElencoTabellare:=ElencoTabellare;
          DatoPers.LungCodice:=0;
          DatoPers.ElencoFisso:=ElencoFisso;
          DatoPers.ValoreDefault:=ValoreDefault;
          DatoPers.CodCategoria:=Categoria;
          // abilitazione alla modifica
          MinFaseMod:=W032DM.selM025.FieldByName('MIN_FASE_MODIFICA_CAT').AsInteger;
          MaxFaseMod:=W032DM.selM025.FieldByName('MAX_FASE_MODIFICA_CAT').AsInteger;
          HintCampo:='';
          DatoPers.AbilitaModifica:=R180Between(FaseLiv,MinFaseMod,MaxFaseMod);
          if DatoPers.AbilitaModifica then
            HintCampo:=HintCampo + Format('modifica abilitata in fase FL %d (range modifica: [%d..%d])<br>',[FaseLiv,MinFaseMod,MaxFaseMod])
          else
            HintCampo:=HintCampo + Format('<span class=''font_rosso''>modifica inibita in fase FL %d (range modifica: [%d..%d])</span><br>',[FaseLiv,W032DM.selM025.FieldByName('MIN_FASE_MODIFICA_CAT').AsInteger,W032DM.selM025.FieldByName('MAX_FASE_MODIFICA_CAT').AsInteger]);
          // bugfix.ini
          // disabilita comunque la modifica dalla fase cassa in poi
          if (FaseLiv > M140FASE_INIZIALE) and (FaseCorr >= M140FASE_CASSA) then // Alberto 23/03/2015
          begin
            DatoPers.AbilitaModifica:=False;
            HintCampo:=HintCampo + Format('<span class=''font_rosso''>dati non modificabili nella fase corrente: %d</span><br>',[FaseCorr]);
          end;
          // bugfix.fine
          DatoPers.ValoreStr:='';
        end;

        // imposta stili campo in base al formato
        WidthCss:=C190GetCssWidthChr(IfThen(LungMax = 0,DATI_PERS_MAXWIDTH_CHAR,LungMax));
        case LFormato of
          // messaggio
          'M': begin
                 StileCampo:='';
                 HintCampo:='formato: messaggio';
               end;
          // stringa
          'S': begin
                 StileCampo:=WidthCss + IfThen(Righe > 1,Format(' height%d',[Righe]));
                 HintCampo:=HintCampo + 'formato: alfanumerico' + Format(' (%d righe) (max %d caratteri)',[Righe,IfThen(LungMax = 0,2000,LungMax)]);
               end;
          // numero
          'N': begin
                 case LungMax of
                       0: StileCampo:='input_num_generic';                        // 0   : input_num_generic  (cifre intere, 2 decimali)
                    1..5: StileCampo:='input_num_' + StringOfChar('n',LungMax);   // 1..5: input_num_n..nnnnn (n cifre intere, 0 decimali)
                 else     StileCampo:='input_integer';                            // >5  : input_integer      (cifre intere, 0 decimali), limitato da codice
                 end;
                 StileCampo:=WidthCss + ' ' + StileCampo;
                 HintCampo:=HintCampo + 'formato: numerico ' + IfThen(LungMax = 0,'decimale',Format('intero (max %d cifre)',[LungMax]));
               end;
          // data dd/mm/yyyy
          'D': begin
                 StileCampo:='input_data_dmy';
                 HintCampo:=HintCampo + 'formato: data (gg/mm/aaaa)';
               end;
        else
          raise Exception.Create(Format('Formato del dato personalizzato non previsto: %s',[LFormato]));
        end;
        HintCampo:=HintCampo + '<br>';

        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
        if LFormato = 'M' then
        begin
          // il formato messaggio non prevede componenti di input
          IWC:=nil;
        end
        else if Elenco then
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
        begin
          // dato selezionabile da un elenco fisso: combobox con elenco di valori
          IWC:=C190DBGridCreaMedpMultiColCombo(Self,Self,DatoPers.Descrizione,WidthCss + IfThen(ElencoTabellare,' fontcourier'),'1');
          LIWCmb:=(IWC as TMedpIWMultiColumnComboBox);
          LIWCmb.medpTag:=DatoPers;
          LIWCmb.ColCount:=1;
          LIWCmb.CodeColumn:=0;
          if ElencoTabellare then
            LIWCmb.CssPopup:='fontcourier';
          LIWCmb.CustomElement:=(not ElencoTabellare) and (ElencoFisso = 'N');

          if QueryValore <> '' then
          begin
            // gestione query valore
            if TestoSQLQueryValore = '' then
            begin
              HintCampo:=HintCampo + Format('tipo: query_valore [%s] [NON INDICATA]',[QueryValore]);
            end
            else
            begin
              HintCampo:=HintCampo + Format('tipo: query_valore [%s] [%s]',[QueryValore,IfThen(ElencoTabellare,'tabellare','semplice')]);
              // popola multicolumn con valori
              // nota: il dataset è già stato aperto per determinare se il dato è tabellare
              if (DSValori <> nil) and (DSValori.Active) then
              begin
                // determina lunghezza codice se dato tabellare
                if ElencoTabellare then
                begin
                  DatoPers.LungCodice:=DSValori.Fields[0].Size;
                  // se DOA non riesce a capire la lunghezza del codice ci pensiamo noi
                  // con il vecchio metodo della nonna
                  if DatoPers.LungCodice = 0 then
                  begin
                    DSValori.First;
                    while not DSValori.Eof do
                    begin
                      if DSValori.Fields[0].AsString.Length > DatoPers.LungCodice then
                        DatoPers.LungCodice:=DSValori.Fields[0].AsString.Length;
                      DSValori.Next;
                    end;
                  end;
                  HintCampo:=HintCampo + Format(', lung. codice = %d',[DatoPers.LungCodice]);
                end;
                // popolamento combobox
                DSValori.First;
                while not DSValori.Eof do
                begin
                  if ElencoTabellare then
                    LIWCmb.AddRow(Format('%-*s - %s',[DatoPers.LungCodice,DSValori.Fields[0].AsString,DSValori.Fields[1].AsString]))
                  else
                    LIWCmb.AddRow(DSValori.Fields[0].AsString);
                  DSValori.Next;
                end;
              end;
            end;
          end
          else if DatoAnagrafico <> '' then
          begin
            // dato anagrafico
            HintCampo:=HintCampo + Format('tipo: dato_anagrafico [%s] [%s]',[DatoAnagrafico,IfThen(ElencoTabellare,'tabellare','semplice')]);

            // se è indicato il dato anagrafico estrae l'elenco di valori in base a questo
            if A000LookupTabella(DatoAnagrafico,WR000DM.selDatoLibero) then
            begin
              // popola multicolumn con valori
              if WR000DM.selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
                WR000DM.selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
              WR000DM.selDatoLibero.Open;
              if ElencoTabellare then
              begin
                DatoPers.LungCodice:=WR000DM.selDatoLibero.Fields[0].Size;
                HintCampo:=HintCampo + Format(', lung. codice = %d',[DatoPers.LungCodice]);
              end;
              WR000DM.selDatoLibero.First;
              // ciclo di popolamento della combo
              while not WR000DM.selDatoLibero.Eof do
              begin
                if ElencoTabellare then
                  LIWCmb.AddRow(Format('%-*s - %s',[DatoPers.LungCodice,WR000DM.selDatoLibero.FieldByName('CODICE').AsString,WR000DM.selDatoLibero.FieldByName('DESCRIZIONE').AsString]))
                else
                  LIWCmb.AddRow(WR000DM.selDatoLibero.FieldByName('CODICE').AsString);
                WR000DM.selDatoLibero.Next;
              end;
              WR000DM.selDatoLibero.Close;
            end;
          end
          else
          begin
            // elenco di valori fissi
            HintCampo:=HintCampo + 'tipo: elenco valori fissi';

            // popola multicolumn con valori
            for S in Valori.Split([',']) do
              LIWCmb.AddRow(S);
          end;
          HintCampo:=HintCampo + Format('<br>valore default: %s<br>custom element: %s',[IfThen(DatoPers.ValoreDefault = '','[non definito]',DatoPers.ValoreDefault),IfThen(LIWCmb.CustomElement,'sì','no')]);
          LIWCmb.ItemIndex:=0; // seleziona il primo elemento

          // se è presente un solo elemento nella combobox, questa viene eliminata
          // e sostituita da un edit
          if LIWCmb.Items.Count = 1 then
          begin
            // salva il valore del dato e distrugge la combobox
            Valore:=LIWCmb.Text;
            LIWCmb.medpTag:=nil; // pulisce il puntatore all'oggetto medpTag in modo che non venga distrutto dalla free successiva
            FreeAndNil(IWC);
            //LIWCmb:=nil; // pulisce il puntatore

            // crea un edit
            IWC:=C190DBGridCreaEdit(Self,Self,DatoPers.Descrizione,StileCampo,'');

            // maxlength per campi alfanumerici
            // non impostare per campi numerici: problemi con il plugin autonumeric!
            if DatoPers.Formato = 'S' then
              TmeIWEdit(IWC).MaxLength:=IfThen(LungMax = 0,DATI_PERS_MAXLENGTH,LungMax);
            TmeIWEdit(IWC).medpTag:=DatoPers;
            TmeIWEdit(IWC).Text:=Valore;
          end;
        end
        else
        begin
          // dato personalizzato: edit / memo
          HintCampo:=HintCampo + 'tipo: dato personalizzato';
          if Righe = 1 then
          begin
            // 1 riga: crea un edit
            IWC:=C190DBGridCreaEdit(Self,Self,DatoPers.Descrizione,StileCampo,'');
            // maxlength per campi alfanumerici
            // non impostare per campi numerici: problemi con il plugin autonumeric!
            if DatoPers.Formato = 'S' then
              TmeIWEdit(IWC).MaxLength:=IfThen(LungMax = 0,DATI_PERS_MAXLENGTH,LungMax);
            TmeIWEdit(IWC).medpTag:=DatoPers;
          end
          else
          begin
            // n>1 righe: crea un memo
            IWC:=TmeIWMemo.Create(Self);
            TmeIWMemo(IWC).Parent:=rgDettaglio; // bug TIWMemo -> non impostare il Parent = Self (form): per funzionare deve essere impostata = alla region di dettaglio
            TmeIWMemo(IWC).Css:=StileCampo;
            TmeIWMemo(IWC).Font.Enabled:=False;
            TmeIWMemo(IWC).FriendlyName:=DatoPers.Descrizione;
            TmeIWMemo(IWC).medpTag:=DatoPers;
            TmeIWMemo(IWC).RenderSize:=False;
            TmeIWMemo(IWC).Tag:=1;
          end;
          HintCampo:=HintCampo + Format('<br>valore default: %s',[IfThen(DatoPers.ValoreDefault = '','[non definito]',DatoPers.ValoreDefault)]);
        end;

        // imposta label e css per cella sx
        IWLbl:=C190DBGridCreaLabel(Self,Self,Codice);
        IWLbl.Caption:=IfThen(Obbligatorio,'(*) ') + W032DM.selM025.FieldByName('DESCRIZIONE').AsString;
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
        //IWLbl.Css:='intestazione';
        if LFormato = 'M' then
        begin
          // formato messaggio
          IWLbl.Css:='messaggio';
          IWLbl.ExtraTagParams.Add('style=position: absolute');
        end
        else
        begin
          // altri formati
          IWLbl.Css:='intestazione';
        end;
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
        IWLbl.ForControl:=IWC;
        {$WARN SYMBOL_PLATFORM OFF}
        IWLbl.Hint:=IfThen(DebugHook <> 0,'<html>' + HintCampo);
        IWLbl.ShowHint:=(DebugHook <> 0);
        {$WARN SYMBOL_PLATFORM ON}

        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
        if LFormato <> 'M' then
        begin
          // abilitazione dei componenti nella riga
          AbilRiga:=(grdRichieste.medpStato <> msBrowse) and DatoPers.AbilitaModifica;

          AbilitazioneComponente(IWLbl,AbilRiga);
          AbilitazioneComponente(IWC,AbilRiga);
        end;
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine

        // imposta tabella
        // cella sx: label con nome dato
        // cella dx: input per il dato
        // 1/2. nome del dato
        grdDati.Cell[r,0].Css:='intestazione align_top bordo_sx_categoria';
        grdDati.Cell[r,0].Control:=IWLbl;
        grdDati.Cell[r,0].Text:='';

        // 2/2. imposta componente e css per cella dx
        grdDati.Cell[r,1].Css:='bordo_dx_categoria';
        grdDati.Cell[r,1].Control:=IWC;

        // salva categoria precedente
        CategoriaPrec:=Categoria;

        // aggiunge una riga alla tabella
        grdDati.RowCount:=grdDati.RowCount + 1;
        inc(r);
      end;
    end;

    W032DM.selM025.Next;
  end;

  // visibilità tabella
  grdDati.Visible:=(grdDati.RowCount > 1);

  // gestione tabella dati personalizzati
  if grdDati.RowCount > 1 then
  begin
    // ultima riga con bordo top per chiudere la tabella
    grdDati.Cell[grdDati.RowCount - 1,0].Css:='bordo_top_categoria';
    grdDati.Cell[grdDati.RowCount - 1,1].Css:='bordo_top_categoria';
  end;
end;

procedure TW032FRichiestaMissioni.VariabiliQueryValore(DS:TOracleDataset);
var lstVariabili:TStringList;
    i:Integer;
begin
  lstVariabili:=FindVariables(DS.SQL.Text, False);
  try
    for i:=0 to lstVariabili.Count - 1 do
    begin
      if W032DM.selM140.FindField(lstVariabili[i]) = nil then
        Continue;
      if W032DM.selM140.FindField(lstVariabili[i]) is TDateTimeField then
        DS.DeclareVariable(lstVariabili[i],otDate)
      else if W032DM.selM140.FindField(lstVariabili[i]) is TIntegerField then
        DS.DeclareVariable(lstVariabili[i],otInteger)
      else
        DS.DeclareVariable(lstVariabili[i],otString);
      if grdRichieste.medpStato = msInsert then
      begin
        if lstVariabili[i].ToUpper = 'PROGRESSIVO' then
          DS.SetVariable(lstVariabili[i],selAnagrafeW.FieldByName('PROGRESSIVO').Value)
      end
      else
        DS.SetVariable(lstVariabili[i],W032DM.selM140.FieldByName(lstVariabili[i]).Value);
    end;
  finally
    FreeAndNil(lstVariabili);
  end;
end;

procedure TW032FRichiestaMissioni.GetRichiesteMissioni;
var
  FiltroAnag: String;
  LVisualizzaTab: Boolean;
  i: Integer;
begin
  grdRichieste.medpStato:=msBrowse;
  grdRichieste.medpBrowse:=True;

  // determina filtri
  FiltroAnag:=IfThen(TuttiDipSelezionato,WR000DM.FiltroRicerca,FiltroSingoloAnagrafico);

  // forza richiamo per comportamento non standard
  CorrezionePeriodo;

  // imposta variabili e apre il dataset
  W032DM.selM140.Close;
  W032DM.selM140.SetVariable('DATALAVORO',Parametri.DataLavoro);
  W032DM.selM140.SetVariable('FILTRO_ANAG',FiltroAnag);
  W032DM.selM140.SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
  W032DM.selM140.SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
  W032DM.selM140.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
  W032DM.selM140.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
  W032DM.selM140.Filtered:=False;
  R013Open(W032DM.selM140);
  // cfr. TW032FRichiestaMissioniDM.selM140AfterOpen

  // filtra il dataset in base alle seguenti informazioni
  // impostate nell'evento OnAfterOpen del dataset:
  // -  fasi autorizzative accessibili dai responsabili
  // -  checkbox di autorizzazione selezionati
  W032DM.selM140.Filtered:=True;
  W032DM.selM140.First;

  // imposta tabella richieste
  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Aut.','',nil);
    if C018.IterModificaValori then
      grdRichieste.medpAggiungiColonna('DBG_COMANDI','Modifica','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
  end;
  grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
  grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
  grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
  grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('MSGAUT_SI','Msg aut SI','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_NO','Msg aut NO','',nil);
    grdRichieste.medpColonna('MSGAUT_SI').Visible:=False;
    grdRichieste.medpColonna('MSGAUT_NO').Visible:=False;
  end;
  grdRichieste.medpAggiungiColonna('PROTOCOLLO','Numero','',nil);
  grdRichieste.medpAggiungiColonna('C_RIMBORSI','Rimborsi','',nil);
  grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Stato','',nil);
  grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
  grdRichieste.medpAggiungiColonna('FLAG_DESTINAZIONE','Destinazione','',nil);
  grdRichieste.medpColonna('FLAG_DESTINAZIONE').Visible:=False;
  grdRichieste.medpAggiungiColonna('C_DESTINAZIONE','Destinazione','',nil);
  grdRichieste.medpAggiungiColonna('FLAG_ISPETTIVA','Ispettiva','',nil);
  grdRichieste.medpColonna('FLAG_ISPETTIVA').Visible:=False;
  grdRichieste.medpAggiungiColonna('C_ISPETTIVA','Ispettiva','',nil);
  if Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S' then
    grdRichieste.medpAggiungiColonna('C_TIPOREGISTRAZIONE','Tipo','',nil);
  grdRichieste.medpAggiungiColonna('DATADA','Data inizio','',nil);
  grdRichieste.medpAggiungiColonna('ORADA','Dalle','',nil);
  grdRichieste.medpAggiungiColonna('DATAA','Data fine','',nil);
  grdRichieste.medpAggiungiColonna('ORAA','Alle','',nil);
  grdRichieste.medpAggiungiColonna('C_PERCORSO','Percorso','',nil);
  grdRichieste.medpAggiungiColonna('MISSIONE_RIAPERTA','Riaperta','',nil);
  grdRichieste.medpColonna('MISSIONE_RIAPERTA').Visible:=False;
  if not WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('F1_STATO','Aut.','',nil);
    grdRichieste.medpAggiungiColonna('F1_RESP','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
  end;
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  if not SolaLettura then
  begin
    if WR000DM.Responsabile then
    begin
      // autorizzazione
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
      // modifica dati
      if C018.IterModificaValori then
      begin
        i:=grdRichieste.medpIndexColonna('DBG_COMANDI');
        grdRichieste.medpPreparaComponenteGenerico('R',i,0,DBG_IMG,'','MODIFICA','Modifica la richiesta','','C');
        grdRichieste.medpPreparaComponenteGenerico('R',i,1,DBG_IMG,'','ANNULLA','Annulla la modifica della richiesta','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',i,2,DBG_IMG,'','CONFERMA','Conferma la modifica della richiesta','','D');
      end;
    end
    else
    begin
      // riga inserimento
      grdRichieste.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce una nuova richiesta di trasferta','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla l''inserimento della richiesta di trasferta','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma l''inserimento della nuova richiesta di trasferta','','D');
      // righe dettaglio
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta di trasferta','Eliminare la richiesta selezionata?','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la richiesta','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica della richiesta','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica della richiesta','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','REVOCA','Annulla la richiesta di missione','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,5,DBG_IMG,'','DEFINISCI','Chiude la richiesta','Chiudere l''iter della richiesta selezionata?'#13#10'Attenzione! Questa procedura è irreversibile.','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,6,DBG_IMG,'','RIAPRI','Riapre la richiesta','Riaprire l''iter della richiesta selezionata?'#13#10'Attenzione! Questa procedura è irreversibile.','D');
      // per le richieste prepara il link al percorso trasferta in inserimento
      grdRichieste.medpPreparaComponenteGenerico('I',grdRichieste.medpIndexColonna('C_PERCORSO'),0,DBG_LNK,'','','Indicazione percorso trasferta','','');
    end;
    // il percorso trasferta è ora un link sempre attivo
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('C_PERCORSO'),0,DBG_LNK,'','','Indicazione percorso trasferta','','');
  end;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('C_RIMBORSI'),0,DBG_LBL,'','','','','',False);
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');

  // imposta tabella anticipi
  // apertura dataset fittizia per creazione cds
  W032DM.selM160.Open;
  grdAnticipi.medpCreaCDS;
  grdAnticipi.medpEliminaColonne;
  grdAnticipi.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdAnticipi.medpAggiungiColonna('CODICE','Codice','',nil);
  grdAnticipi.medpColonna('CODICE').Visible:=False;
  grdAnticipi.medpAggiungiColonna('C_DESCRIZIONE','Voce richiesta','',nil);
  grdAnticipi.medpAggiungiColonna('C_TIPO_QUANTITA','T','',nil);
  grdAnticipi.medpColonna('C_TIPO_QUANTITA').Visible:=False;
  grdAnticipi.medpAggiungiColonna('QUANTITA','Quantità','',nil);
  grdAnticipi.medpAggiungiColonna('C_PERC_ANTICIPO','% spettante','',nil);
  grdAnticipi.medpAggiungiColonna('C_QTA_SPETTANTE','Qta spettante','',nil);
  grdAnticipi.medpAggiungiColonna('NOTE','Note del richiedente','',nil);
  grdAnticipi.medpAggiungiColonna('C_NOTE_FISSE','Note aziendali','',nil);
  grdAnticipi.medpInizializzaCompGriglia;
  if (not SolaLettura) then//+++and
     //+++(not WR000DM.Responsabile) then
  begin
    // riga inserimento
    grdAnticipi.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce una nuova richiesta di anticipo','','S');
    grdAnticipi.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla l''inserimento della richiesta di anticipo','','S');
    grdAnticipi.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma l''inserimento della richiesta di anticipo','','D');
      // righe dettaglio
    grdAnticipi.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta di anticipo','Eliminare la voce di anticipo selezionata?','S');
    grdAnticipi.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la richiesta di anticipo','','D');
    grdAnticipi.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica della richiesta di anticipo','','S');
    grdAnticipi.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica della richiesta di anticipo','','D');
  end;

  // imposta tabella dettaglio giornaliero
  W032DM.selM143.Open; // apertura dataset fittizia per creazione cds
  grdDettaglioGG.medpCreaCDS;
  grdDettaglioGG.medpEliminaColonne;
  grdDettaglioGG.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdDettaglioGG.medpAggiungiColonna('DATA','Data','',nil);
  grdDettaglioGG.medpAggiungiColonna('TIPO','Tipo','',nil); // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1
  grdDettaglioGG.medpAggiungiColonna('DALLE','Ora inizio','',nil);
  grdDettaglioGG.medpAggiungiColonna('ALLE','Ora fine','',nil);
  grdDettaglioGG.medpAggiungiColonna('NOTE','Note attività','',nil);
  grdDettaglioGG.medpInizializzaCompGriglia;
  if (not SolaLettura) and
     (not WR000DM.Responsabile) then
  begin
    // riga inserimento
    grdDettaglioGG.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce un nuovo servizio','','S');
    grdDettaglioGG.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla l''inserimento del servizio','','S');
    grdDettaglioGG.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma l''inserimento del servizio','','D');
    // righe dettaglio
    grdDettaglioGG.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina il servizio','','S');
    grdDettaglioGG.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica il servizio','','D');
    grdDettaglioGG.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica del servizio','','S');
    grdDettaglioGG.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica del servizio','','D');
  end;

  // imposta tabella rimborsi
  W032DM.selM150.Open; // apertura dataset fittizia per creazione cds
  grdRimborsi.medpCreaCDS;
  grdRimborsi.medpEliminaColonne;
  grdRimborsi.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdRimborsi.medpAggiungiColonna('INDENNITA_KM','Ind. Km','',nil);
  grdRimborsi.medpColonna('INDENNITA_KM').Visible:=False;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
  grdRimborsi.medpAggiungiColonna('DATA_RIMBORSO','Data rimborso','',nil);
  grdRimborsi.medpColonna('DATA_RIMBORSO').Visible:=(Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S');
  grdRimborsi.medpAggiungiColonna('ID_RIMBORSO','(**)ID rimb.','',nil);
  {$WARN SYMBOL_PLATFORM OFF}
  grdRimborsi.medpColonna('ID_RIMBORSO').Visible:=(DebugHook <> 0) and (Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S');
  {$WARN SYMBOL_PLATFORM ON}
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
  grdRimborsi.medpAggiungiColonna('CODICE','Codice','',nil);
  grdRimborsi.medpColonna('CODICE').Visible:=False;
  grdRimborsi.medpAggiungiColonna('C_DESCRIZIONE','Voce richiesta','',nil);
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
  grdRimborsi.medpAggiungiColonna('C_TIPO_QUANTITA','T','',nil);
  grdRimborsi.medpColonna('C_TIPO_QUANTITA').Visible:=False;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine
  grdRimborsi.medpAggiungiColonna('KMPERCORSI','Km percorsi','',nil);
  grdRimborsi.medpAggiungiColonna('KMPERCORSI_VARIATO','Km autorizzati','',nil);
  grdRimborsi.medpAggiungiColonna('COD_VALUTA','Valuta','',nil);
  grdRimborsi.medpAggiungiColonna('RIMBORSO','Rimborso richiesto','',nil);
  grdRimborsi.medpAggiungiColonna('RIMBORSO_VARIATO','Rimborso autorizzato','',nil);
  // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.ini
  if W032DM.GestTipoRimborso then
  begin
    grdRimborsi.medpAggiungiColonna('TIPORIMBORSO','Tipo rimborso','',nil);
  end;
  // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.fine
  grdRimborsi.medpAggiungiColonna('NOTE','Note','',nil);
  grdRimborsi.medpInizializzaCompGriglia;
  if (not SolaLettura) and
     (not WR000DM.Responsabile) then
  begin
    // riga inserimento
    grdRimborsi.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce un nuovo rimborso','','S');
    grdRimborsi.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla l''inserimento del rimborso','','S');
    grdRimborsi.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma l''inserimento del rimborso','','D');
    // righe dettaglio
    grdRimborsi.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta di rimborso','Eliminare la voce di rimborso selezionata?','S');
    grdRimborsi.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la richiesta di rimborso','','D');
    grdRimborsi.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica della richiesta di rimborso','','S');
    grdRimborsi.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica della richiesta di rimborso','','D');
  end;

  // carica i dati delle richieste
  grdRichieste.medpCaricaCDS;

  // nasconde i tab di dettaglio se non ci sono record da autorizzare
  LVisualizzaTab:=(not WR000DM.Responsabile) or (W032DM.selM140.RecordCount > 0);
  tabMissioni.Tabs[rgDettaglio].Visible:=LVisualizzaTab;
  if FGestAnticipi then
    tabMissioni.Tabs[rgAnticipi].Visible:=LVisualizzaTab;
  tabMissioni.Tabs[rgDettaglioGG].Visible:=LVisualizzaTab and (not Parametri.ModuloInstallato['TORINO_CSI']);
  tabMissioni.Tabs[rgRimborsi].Visible:=LVisualizzaTab;
  tabMissioni.Visible:=LVisualizzaTab;
  if LVisualizzaTab then
    tabMissioni.ActiveTab:=rgDettaglio; // ripristina visibilità tab
end;

procedure TW032FRichiestaMissioni.grdMezziRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not C190RenderCell(ACell,ARow,AColumn,False,False,False) then
    Exit;
end;

//##########################//
//### GESTIONE RICHIESTE ###//
//##########################//

procedure TW032FRichiestaMissioni.PosizionamentoMultiColumnText(PCmb: TMedpIWMultiColumnComboBox; const PValore: String; const PCodLen: Integer);
var
  i: Integer;
  bValoreTrovato: Boolean;
begin
  // se il valore è vuoto termina subito impostando Text =''
  if PValore.Trim = '' then
  begin
    // imposta il testo vuoto
    PCmb.Text:='';
  end
  else
  begin
    // effettua ricerca parziale per valore (primi caratteri del testo)
    bValoreTrovato:=False;
    for i:=0 to PCmb.Items.Count - 1 do
    begin
      if PValore = PCmb.Items[i].RowData[0].Substring(0,PCodLen).Trim then
      begin
        PCmb.ItemIndex:=i;
        bValoreTrovato:=True;
        Break;
      end;
    end;
    if not bValoreTrovato then
      PCmb.Text:=PValore;
  end;
end;

procedure TW032FRichiestaMissioni.CleanMezziTrasporto;
// pulizia grid mezzi di trasporto
var
  i: Integer;
  IWC: TIWCustomControl;
  IWG: TmeIWGrid;
  IWChk: TmeIWCheckBox;
begin
  for i:=0 to grdMezzi.RowCount - 1 do
  begin
    IWC:=grdMezzi.Cell[i,0].Control;
    if Assigned(IWC) then
    begin
      if IWC is TmeIWGrid then
      begin
        IWG:=(IWC as TmeIWGrid);

        // checkbox di selezione del mezzo
        IWChk:=(IWG.Cell[0,0].Control as TmeIWCheckBox);
        IWChk.Checked:=False;
        if @IWChk.OnAsyncClick <> nil then
          IWChk.OnAsyncClick(IWChk,nil);

        // esamina colonne aggiuntive: targa e motivazione
        if IWG.ColumnCount > 1 then
        begin
          // gestione targa
          IWC:=IWG.Cell[0,1].Control;
          if Assigned(IWC) then
          begin
            AbilitazioneComponente(IWC,False);
            if IWC is TmeIWEdit then
              TmeIWEdit(IWC).Text:='';
          end;
          // gestione motivazione
          if (IWG.ColumnCount > 2) then
          begin
            IWC:=IWG.Cell[0,2].Control;
            if Assigned(IWC) then
            begin
              AbilitazioneComponente(IWC,False);
              if IWC is TmeIWEdit then
                TmeIWEdit(IWC).Text:='';
            end;
          end;
        end;
      end
      else if IWC is TmeTIWAdvRadioGroup then
      begin
        (IWC as TmeTIWAdvRadioGroup).ItemIndex:=W032DM.GetSpeseMezzoDefaultIndex;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.DBGridColumnClick(ASender:TObject; const AValue:string);
var
  LCheckEstero: String;
  LCampo: String;
  S: String;
  LCodice: String;
  LValoreDatoPers: String;
  i,j: Integer;
  LIdRiga: Integer;
  LFaseCorr: Integer;
  LDatiMezzo: TDatiMezzo;
  LDatoPers: TDatoPersonalizzato;
  LIWC: TIWCustomControl;
  LIWChk: TmeIWCheckBox;
  LIWEdt: TmeIWEdit;
  LIWCmb: TMedpIWMultiColumnComboBox;
  LIWGrd: TmeIWGrid;
  LIWRgp: TmeTIWAdvRadioGroup;
  LCorrSpese: String;
begin
  // prova la locate prima con rowid, quindi con id richiesta
  if not cdsM140.Locate('DBG_ROWID',AValue,[]) then
  begin
    if TryStrToInt(AValue,LIdRiga) then
    begin
      if not cdsM140.Locate('ID',LIdRiga,[]) then
        Exit;
    end
    else
      Exit;
  end;

  // pulizia grid mezzi trasporto
  CleanMezziTrasporto;

  // posizionamento dataset
  W032DM.selM140.SearchRecord('ROWID',cdsM140.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);

  // carica grid dei dati personalizzati + checkgroup motivazioni e ipotesi trasferte estere
  PopolaDatiPersonalizzati;

  if AValue = '*' then
  begin
    // pulizia dati per inserimento
    CleanRecordRichiesta;

    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    // tappe percorso
    // apre il dataset in modo che sia inizialmente vuoto se non ci sono modifiche in corso
    if not W032DM.selM141.UpdatesPending then
    begin
      W032DM.selM141.Close;
      W032DM.selM141.SetVariable('ID',-1);
      W032DM.selM141.Open;
    end;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

    tabMissioni.Tabs[rgDettaglio].Caption:='Dettaglio trasferta';
    if FGestAnticipi then
      tabMissioni.Tabs[rgAnticipi].Caption:='Anticipi';
    tabMissioni.Tabs[rgDettaglioGG].Caption:='Servizi attivi';
    tabMissioni.Tabs[rgRimborsi].Caption:='Rimborsi';

    // pulizia checkbox motivazioni e ipotesi trasferta estera
    cgpMotivEstero.Css:='invisibile';
    cgpIpotesiEstero.Css:='invisibile';
    for i:=0 to cgpMotivEstero.Items.Count - 1 do
      cgpMotivEstero.IsChecked[i]:=False;
    for i:=0 to cgpIpotesiEstero.Items.Count - 1 do
      cgpIpotesiEstero.IsChecked[i]:=False;

    // pulizia dei valori nei dati personalizzati
    for i:=0 to grdDati.RowCount - 1 do
    begin
      // componente di input
      LIWC:=grdDati.Cell[i,1].Control;
      if Assigned(LIWC) then
      begin
        if LIWC is TmeIWEdit then
        begin
          LDatoPers:=(TmeIWEdit(LIWC).medpTag as TDatoPersonalizzato);
          if LDatoPers.ValoreDefault <> '' then
          begin
            // se il valore di default è indicato utilizza questo in ogni caso
            TmeIWEdit(LIWC).Text:=LDatoPers.ValoreDefault;
          end
          else
          begin
            // valore di default non indicato
            // verifica del caso particolare per cui il dato personalizzato è selezionabile da elenco
            // ma l'elenco ha un solo valore possibile
            if not LDatoPers.Elenco then
              TmeIWEdit(LIWC).Clear;
          end;
        end
        else if LIWC is TmeIWMemo then
        begin
          LDatoPers:=(TmeIWMemo(LIWC).medpTag as TDatoPersonalizzato);
          if LDatoPers.ValoreDefault <> '' then
          begin
            // se il valore di default è indicato utilizza questo in ogni caso
            TmeIWMemo(LIWC).Text:=LDatoPers.ValoreDefault;
          end
          else
          begin
            // valore di default non indicato
            TmeIWMemo(LIWC).Clear;
          end;
        end
        else if LIWC is TMedpIWMultiColumnComboBox then
        begin
          LIWCmb:=TMedpIWMultiColumnComboBox(LIWC);
          LDatoPers:=(LIWCmb.medpTag as TDatoPersonalizzato);

          // gestione del valore di default
          if LDatoPers.ValoreDefault <> '' then
          begin
            // se il valore di default è indicato utilizza questo in ogni caso
            LIWCmb.Text:=LDatoPers.ValoreDefault;
            // correzione per sincronizzare il Text nel caso di CustomElement non consentito
            if (not LIWCmb.CustomElement) and (LIWCmb.Text <> '') and (LIWCmb.ItemIndex = -1) then
              LIWCmb.Text:='';
          end
          else
          begin
            // valore di default non indicato
            LIWCmb.Text:='';
              
            // verifica casi particolari di query valore / dato anagrafico personalizzato
            if LDatoPers.QueryValore <> '' then
            begin
              // query valore con un solo elemento disponibile: lo seleziona
              if LIWCmb.Items.Count = 1 then
                LIWCmb.ItemIndex:=0;
            end
            else if LDatoPers.DatoAnagrafico <> '' then
            begin
              // dato anagrafico: propone il valore del dato anagrafico attualmente associato al dipendente
              if selAnagrafeW.FindField('T430' + LDatoPers.DatoAnagrafico) <> nil then
              begin
                try
                  LValoreDatoPers:=selAnagrafeW.FieldByName('T430' + LDatoPers.DatoAnagrafico).AsString;
                  if LDatoPers.ElencoTabellare then
                    PosizionamentoMultiColumnText(LIWCmb,LValoreDatoPers,LDatoPers.LungCodice)
                  else
                    LIWCmb.Text:=LValoreDatoPers;
                except
                  // errore nella selezione del dato personalizzato: che fare?
                end;
              end;
            end;
          end;
        end;
      end;
    end;

    //inizializzazione dataset di dettaglio
    W032DM.selM143.Close;
    W032DM.selM143.SetVariable('ID',-1);
    W032DM.selM143.Open;

    // rimborsi
    W032DM.selM150.Close;
    W032DM.selM150.SetVariable('ID',-1);
    W032DM.selM150.Open;

    // anticipi
    W032DM.selM160.Close;
    W032DM.selM160.SetVariable('ID',-1);
    W032DM.selM160.Open;

    // mezzi
    W032DM.selM170.Close;
    W032DM.selM170.SetVariable('ID',-1);
    W032DM.selM170.Open;

    // motivazioni
    W032DM.selM175.Close;
    W032DM.selM175.SetVariable('ID',-1);
    W032DM.selM175.Open;

    LFaseCorr:=M140FASE_INIZIALE;
  end
  else
  begin
    // modifica di una richiesta

    // gestione del percorso: partenza, destinazione e rientro
    FRichiesta.Partenza:=W032DM.selM140.FieldByName('PARTENZA').AsString;
    FRichiesta.ElencoDestinazioni:=W032DM.selM140.FieldByName('ELENCO_DESTINAZIONI').AsString;
    FRichiesta.Rientro:=W032DM.selM140.FieldByName('RIENTRO').AsString;
    FRichiesta.PercorsoTesto:=W032DM.selM140.FieldByName('C_PERCORSO').AsString;

    // tipo missione
    FRichiesta.TipoRegistrazione:=W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString;

    // estrae la regola da utilizzare
    LeggiRegolaMissione(W032DM.selM140.FieldByName('DATAA').AsDateTime,False);
    if not FRegoleTrovate then
    begin
      // errore bloccante: disabilita tutto
      // dettaglio
      rgDettaglio.medpDisabilitaComponenti;
      // anticipi
      if FGestAnticipi then
      begin
        tabMissioni.Tabs[rgAnticipi].Enabled:=False;
        rgAnticipi.medpDisabilitaComponenti;
        grdAnticipi.medpNascondiComandi;
      end;
      // rimborsi
      tabMissioni.Tabs[rgRimborsi].Enabled:=False;
      rgRimborsi.medpDisabilitaComponenti;
      grdRimborsi.medpNascondiComandi;
      // servizi attivi
      tabMissioni.Tabs[rgDettaglioGG].Enabled:=False;
      rgDettaglioGG.medpDisabilitaComponenti;
      grdDettaglioGG.medpNascondiComandi;
    end;

    LFaseCorr:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;
    C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
    C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;

    // tappe del percorso
    W032DM.selM141.Close;
    W032DM.selM141.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
    W032DM.selM141.Open;

    // mezzi di trasporto
    W032DM.selM170.Close;
    W032DM.selM170.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
    W032DM.selM170.Open;
    while not W032DM.selM170.Eof do
    begin
      for i:=0 to grdMezzi.RowCount - 1 do
      begin
        if grdMezzi.Cell[i,0].Control is TmeIWGrid then
        begin
          LIWGrd:=(grdMezzi.Cell[i,0].Control as TmeIWGrid);
          // checkbox
          LIWChk:=(LIWGrd.Cell[0,0].Control as TmeIWCheckBox);
          if LIWChk.FriendlyName = W032DM.selM170.FieldByName('CODICE').AsString then
          begin
            LIWChk.Checked:=True;
            if @LIWChk.OnAsyncClick <> nil then
              LIWChk.OnAsyncClick(LIWChk,nil);

            LDatiMezzo:=(LIWChk.medpTag as TDatiMezzo);

            // gestione radiogroup spese viaggio
            if (LDatiMezzo.FlagMezzoProprio = 'S') and
               (W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'N') then
            begin
              //LIWRgp:=(grdMezzi.Cell[i + 1,0].Control as TmeTIWAdvRadioGroup);
              LIWRgp:=(Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup);
              LCorrSpese:=W032DM.selM170.FieldByName('CORRESPONSIONE_SPESE').AsString;
              if LCorrSpese = '' then
                LIWRgp.ItemIndex:=-1
              else if LCorrSpese = 'S' then
                LIWRgp.ItemIndex:=0
              else
                LIWRgp.ItemIndex:=1;
            end;

            // campo targa / motivazione
            for j:=1 to LIWGrd.ColumnCount - 1 do
            begin
              if LIWGrd.Cell[0,j].Control <> nil then
              begin
                // targa / motivazione
                LIWEdt:=(LIWGrd.Cell[0,j].Control as TmeIWEdit);
                LCampo:=IfThen((LIWEdt.medpTag as TDatiMezzo).FlagTarga = 'S','TARGA','MOTIVAZIONE');
                AbilitazioneComponente(LIWEdt,True);
                LIWEdt.Text:=W032DM.selM170.FieldByName(LCampo).AsString;
              end;
            end;
          end;
        end;
      end;
      W032DM.selM170.Next;
    end;

    // carica le liste di anticipi, rimborsi, ind. km, valute
    CaricaListe;

    // motivazioni per trasferta estera e dati personalizzati
    if (W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString = 'E') or
       (FEsistonoDatiPersonalizzati) then
    begin
      W032DM.selM175.Close;
      W032DM.selM175.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      W032DM.selM175.Open;
    end;

    // gestione motivazioni e ipotesi trasferte estere
    if W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString = 'E' then
    begin
      LCheckEstero:='';
      // non riapre il dataset selM175
      if W032DM.selM175.RecordCount > 0 then
      begin
        W032DM.selM175.First;
        while not W032DM.selM175.Eof do
        begin
          LCheckEstero:=LCheckEstero + W032DM.selM175.FieldByName('CODICE').AsString + ',';
          W032DM.selM175.Next;
        end;
        LCheckEstero:=Copy(LCheckEstero,1,Length(LCheckEstero) - 1);
        for LCodice in LCheckEstero.Split([',']) do
        begin
          for j:=0 to cgpMotivEstero.Values.Count - 1 do
          begin
            if LCodice = Trim(Copy(cgpMotivEstero.Values[j],1,5)) then
            begin
              cgpMotivEstero.IsChecked[j]:=True;
              Break;
            end;
          end;
          for j:=0 to cgpIpotesiEstero.Values.Count - 1 do
          begin
            if LCodice = Trim(Copy(cgpIpotesiEstero.Values[j],1,5)) then
            begin
              cgpIpotesiEstero.IsChecked[j]:=True;
              Break;
            end;
          end;
        end;
      end;
      cgpMotivEstero.Css:=FCssIniCgp;
      cgpIpotesiEstero.Css:=FCssIniCgp;
    end
    else
    begin
      cgpMotivEstero.Css:='invisibile';
      cgpIpotesiEstero.Css:='invisibile';
    end;
    if cgpMotivEstero.Items.Count = 0 then
      cgpMotivEstero.Css:='invisibile';
    if cgpIpotesiEstero.Items.Count = 0 then
      cgpIpotesiEstero.Css:='invisibile';

    // popolamento dati personalizzati
    if FEsistonoDatiPersonalizzati then
    begin
      for i:=0 to grdDati.RowCount - 1 do
      begin
        // componente di input
        LIWC:=grdDati.Cell[i,1].Control;
        if Assigned(LIWC) then
        begin
          if LIWC is TmeIWEdit then
          begin
            // valore libero (su una riga)
            LDatoPers:=((LIWC as TmeIWEdit).medpTag as TDatoPersonalizzato);
            if W032DM.selM175.SearchRecord('CODICE',LDatoPers.Codice,[srFromBeginning]) then
              TmeIWEdit(LIWC).Text:=W032DM.selM175.FieldByName('VALORE').AsString
            else
              TmeIWEdit(LIWC).Clear;
          end
          else if LIWC is TmeIWMemo then
          begin
            // valore libero (su più righe)
            LDatoPers:=(TmeIWMemo(LIWC).medpTag as TDatoPersonalizzato);
            if W032DM.selM175.SearchRecord('CODICE',LDatoPers.Codice,[srFromBeginning]) then
              TmeIWMemo(LIWC).Text:=W032DM.selM175.FieldByName('VALORE').AsString
            else
              TmeIWMemo(LIWC).Clear;
          end
          else if LIWC is TMedpIWMultiColumnComboBox then
          begin
            // lista di valori
            LIWCmb:=TMedpIWMultiColumnComboBox(LIWC);
            LDatoPers:=(LIWCmb.medpTag as TDatoPersonalizzato);
            if W032DM.selM175.SearchRecord('CODICE',LDatoPers.Codice,[srFromBeginning]) then
            begin
              if LDatoPers.ElencoTabellare then
                PosizionamentoMultiColumnText(LIWCmb,W032DM.selM175.FieldByName('VALORE').AsString,LDatoPers.LungCodice)
              else
                LIWCmb.Text:=W032DM.selM175.FieldByName('VALORE').AsString;
            end
            else
            begin
              // codice non presente su M175
              LIWCmb.Text:='';
            end;
          end;
        end;
      end;
    end;

    // dati anticipo
    if W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString = W032_TIPO_ACCREDITO_CC then
      rgpAccredito.ItemIndex:=0
    else if W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString = W032_TIPO_ACCREDITO_AB then
      rgpAccredito.ItemIndex:=1;

    // delegato
    lblDelegato.Visible:=False;
    edtCercaDelegato.Visible:=False;
    cmbDelegato.Visible:=False;
    btnCercaDelegato.Visible:=False;
    chkDelegato.Checked:=not W032DM.selM140.FieldByName('DELEGATO').IsNull;
    chkDelegatoClick(nil);
    if chkDelegato.Checked then
    begin
      edtCercaDelegato.Text:=W032DM.selM140.FieldByName('DELEGATO').AsString; // matricola delegato
      if not W032DM.selM140.FieldByName('DELEGATO').IsNull then
      begin
        btnCercaDelegato.Caption:='Cerca delegato';
        btnCercaDelegatoClick(nil); // ricerca per matricola
      end;
    end;

    // anticipi
    if not W032DM.selM160.UpdatesPending then
    begin
      W032DM.selM160.Close;
      W032DM.selM160.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      W032DM.selM160.Open;
    end;
    if FGestAnticipi then
      tabMissioni.Tabs[rgAnticipi].Caption:=Format('Anticipi <span class="contatore_apice">%d</span>',[W032DM.selM160.RecordCount]);
    grdAnticipi.medpCaricaCDS;

    // dettaglio giornaliero (servizi attivi)
    if not W032DM.selM143.UpdatesPending then
    begin
      W032DM.selM143.Close;
      W032DM.selM143.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      W032DM.selM143.Open;
    end;
    if W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger >= M140FASE_CASSA then
      tabMissioni.Tabs[rgDettaglioGG].Caption:=Format('Servizi attivi <span class="contatore_apice">%d</span>',[W032DM.selM143.RecordCount])
    else
      tabMissioni.Tabs[rgDettaglioGG].Caption:='Servizi attivi';
    grdDettaglioGG.medpCaricaCDS;

    // rimborsi
    // 1. stato autorizzazione
    if W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger >= M140FASE_CASSA then
    begin
      S:=W032DM.selM140.FieldByName('F4_STATO').AsString;
      if S = 'S' then
        lblAutRimborsi.Caption:='Autorizzato'
      else if S = 'N' then
        lblAutRimborsi.Caption:='Non autorizzato'
      else
        lblAutRimborsi.Caption:='';
      if W032DM.selM140.FieldByName('F4_RESP').AsString = C018AUTOMATICO then
        lblRespRimborsi.Caption:='automaticamente'
      else
        lblRespRimborsi.Caption:=Format('(%s)',[W032DM.selM140.FieldByName('F4_RESP').AsString]);
    end
    else
    begin
      lblAutRimborsi.Caption:='';
      lblRespRimborsi.Caption:='';
    end;
    // 2. tabella rimborsi
    if not W032DM.selM150.UpdatesPending then
    begin
      W032DM.selM150.Close;
      W032DM.selM150.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      W032DM.selM150.Open;
    end;
    if W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger >= M140FASE_CASSA then
    begin
      // rimborsi abilitati: riporta conteggio record
      tabMissioni.Tabs[rgRimborsi].Caption:=Format('Rimborsi <span class="contatore_apice">%d</span>',[W032DM.selM150.RecordCount]);
    end
    else
    begin
      // rimborsi non abilitati: non riporta conteggio record
      tabMissioni.Tabs[rgRimborsi].Caption:='Rimborsi';
    end;
    grdRimborsi.medpCaricaCDS;
  end;

  // abilitazioni dei tab e dei campi
  //***rgDettaglio.medpDisabilitaComponenti;
  for j:=0 to rgDettaglio.ControlCount - 1 do
  begin
    if (rgDettaglio.Controls[j] is TIWCustomControl) then
    begin
      LIWC:=TIWCustomControl(rgDettaglio.Controls[j]);
      if not ((LIWC = grdDati) or (LIWC.Tag = 1)) then
        AbilitazioneComponente(LIWC,False);
    end;
  end;
  // tab anticipi
  if FGestAnticipi then
  begin
    tabMissioni.Tabs[rgAnticipi].Enabled:=WR000DM.Responsabile or (AValue <> '*');
    rgAnticipi.medpDisabilitaComponenti;
    grdAnticipi.medpNascondiComandi;
  end;
  // tab rimborsi
  // visibile solo da M140FASE_CASSA, anche per autorizzatore
  tabMissioni.Tabs[rgRimborsi].Enabled:=(LFaseCorr >= M140FASE_CASSA);
  rgRimborsi.medpDisabilitaComponenti;
  grdRimborsi.medpNascondiComandi;
  // tab servizi attivi
  // visibile solo da M140FASE_CASSA, anche per autorizzatore
  tabMissioni.Tabs[rgDettaglioGG].Enabled:=(LFaseCorr >= M140FASE_CASSA);
  rgDettaglioGG.medpDisabilitaComponenti;
  grdDettaglioGG.medpNascondiComandi;
end;

procedure TW032FRichiestaMissioni.TrasformaComponenti(const FN:String);
// trasforma i componenti della riga indicata da text a control e viceversa per la grid
var
  LDaTestoAControlli: Boolean;
  LAbilitaDett: Boolean;
  LAbilitaCorresponsione: Boolean;
  LBloccaDate:Boolean;
  i,c,j,LFaseCorr:Integer;
  LDatiMezzo: TDatiMezzo;
  LIWC: TIWCustomControl;
  LIWEdt: TmeIWEdit;
  LIWEdtInizio: TmeIWEdit;
  LIWEdtFine: TmeIWEdit;
  LIWLnk: TmeIWLink;
  LIWCmb: TmeIWComboBox;
  LIWGrd: TmeIWGrid;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  LDaTestoAControlli:=grdRichieste.medpStato <> msBrowse;

  // gestione icone comandi
  LIWGrd:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
  LIWGrd.Cell[0,0].Css:=IfThen(LDaTestoAControlli,'invisibile','align_left');
  if i = 0 then
  begin
    // riga di inserimento
    LIWGrd.Cell[0,1].Css:=IfThen(LDaTestoAControlli,'align_left','invisibile');
    LIWGrd.Cell[0,2].Css:=IfThen(LDaTestoAControlli,'align_right','invisibile');
  end
  else
  begin
    // righe di dettaglio
    LIWGrd.Cell[0,1].Css:=IfThen(LDaTestoAControlli,'invisibile','align_right');
    LIWGrd.Cell[0,2].Css:=IfThen(LDaTestoAControlli,'align_left','invisibile');
    LIWGrd.Cell[0,3].Css:=IfThen(LDaTestoAControlli,'align_right','invisibile');
    LIWGrd.Cell[0,4].Css:=IfThen(LDaTestoAControlli,'invisibile','align_left');
    LIWGrd.Cell[0,5].Css:=IfThen(LDaTestoAControlli,'invisibile','align_right');
  end;

  // abilitazione componenti dettaglio richiesta/anticipo
  LAbilitaDett:=False;
  LFaseCorr:=M140FASE_INIZIALE; // inizializzazione
  if LDaTestoAControlli then
  begin
    LFaseCorr:=StrToIntDef(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE'),-1);
    // impedisce modifica dettaglio per missione riaperta
    if ((grdRichieste.medpStato = msInsert) or (LFaseCorr < M140FASE_CASSA)) and
       (grdRichieste.medpValoreColonna(i,'MISSIONE_RIAPERTA') <> 'S') then
    begin
      // abilita modifica dettaglio richiesta
      LAbilitaDett:=True;
      // esclude la tabella dei dati personalizzati, in quanto già gestita in precedenza
      //rgDettaglio.medpAbilitaComponenti;
      for j:=0 to rgDettaglio.ControlCount - 1 do
      begin
        if (rgDettaglio.Controls[j] is TIWCustomControl) then
        begin
          LIWC:=TIWCustomControl(rgDettaglio.Controls[j]);
          if not ((LIWC = grdDati) or (LIWC.Tag = 1)) then
            AbilitazioneComponente(LIWC,LAbilitaDett);
        end;
      end;
    end;
    if grdRichieste.medpStato = msEdit then
    begin
      if LFaseCorr < M140FASE_CASSA then
      begin
        rgAnticipi.medpAbilitaComponenti;
        grdAnticipi.medpVisualizzaComandi;
        rgpAccreditoClick(rgpAccredito);
      end
      else if LFaseCorr = M140FASE_CASSA then (* esiste autorizzazione alla trasferta *)
      begin
        // rimborsi
        rgRimborsi.medpAbilitaComponenti;
        grdRimborsi.medpVisualizzaComandi;
        // servizi attivi
        rgDettaglioGG.medpAbilitaComponenti;
        grdDettaglioGG.medpVisualizzaComandi;
      end;
    end;
  end
  else
  begin
    // dettaglio
    rgDettaglio.medpDisabilitaComponenti;
    // anticipi
    rgAnticipi.medpDisabilitaComponenti;
    grdAnticipi.medpNascondiComandi;
    // rimborsi
    rgRimborsi.medpDisabilitaComponenti;
    grdRimborsi.medpNascondiComandi;
    // servizi attivi
    rgDettaglioGG.medpDisabilitaComponenti;
    grdDettaglioGG.medpNascondiComandi;
  end;

  if LDaTestoAControlli then
  begin
    // flag destinazione e flag ispettiva determinano il cod_iter,
    // pertanto possono essere modificati solo in fase di inserimento
    // oppure in modifica se non ci sono anticipi e non ci sono autorizzazioni
    if (grdRichieste.medpStato = msInsert) or ((W032DM.selM160.RecordCount = 0) and (LFaseCorr < M140FASE_AUTORIZZAZIONE)) then
    begin
      // flag destinazione (estero,regione,fuori regione)
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'12','','','','S');
      c:=grdRichieste.medpIndexColonna('C_DESTINAZIONE');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      LIWCmb:=(grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox);
      LIWCmb.NoSelectionText:='--';
      LIWCmb.ItemsHaveValues:=True;
      LIWCmb.Items.Add('Regione=R');
      LIWCmb.Items.Add('Fuori regione=I');
      LIWCmb.Items.Add('Estero=E');
      if grdRichieste.medpStato = msInsert then
      begin
        //IWCmb.ItemIndex:=0; // default = in regione
        LIWCmb.ItemIndex:=R180IndexFromValue(LIWCmb.Items,W032DM.GetValoreDefault('FLAG_DESTINAZIONE'));
      end
      else
        LIWCmb.ItemIndex:=max(0,R180IndexFromValue(LIWCmb.Items,grdRichieste.medpValoreColonna(i,'FLAG_DESTINAZIONE')));
      if (cgpMotivEstero.Items.Count > 0) or (cgpIpotesiEstero.Items.Count > 0) then
      begin
        //IWCmb.OnChange:=cmbFlagDestinazioneChange;
        LIWCmb.OnAsyncChange:=cmbFlagDestinazioneAsyncChange;
      end;
      // AOSTA_REGIONE - commessa: 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      // combobox in readonly se si verificano le condizioni
      // focus sul combobox solo se è editabile
      LIWCmb.Editable:=not FFlagDestinazioneReadOnly;
      if LIWCmb.Editable then
        LIWCmb.SetFocus;
      // AOSTA_REGIONE - commessa: 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

      // flag ispettiva
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'2','','','','S');
      c:=grdRichieste.medpIndexColonna('C_ISPETTIVA');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      LIWCmb:=(grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox);
      LIWCmb.NoSelectionText:='--';
      LIWCmb.ItemsHaveValues:=True;
      LIWCmb.Items.Add('Sì=S');
      LIWCmb.Items.Add('No=N');
      if grdRichieste.medpStato = msInsert then
      begin
        //IWCmb.ItemIndex:=1; // default = "Non ispettiva"
        LIWCmb.ItemIndex:=R180IndexFromValue(LIWCmb.Items,W032DM.GetValoreDefault('FLAG_ISPETTIVA'));
      end
      else
        LIWCmb.ItemIndex:=R180IndexOf(LIWCmb.Items,grdRichieste.medpValoreColonna(i,'FLAG_ISPETTIVA'),1);
      LIWCmb.OnAsyncChange:=cmbIspettivaAsyncChange;
      // AOSTA_REGIONE - commessa: 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      // focus sulla combobox ispettiva se non impostato precedentemente
      if (FFlagDestinazioneReadOnly) and
         (LIWCmb.Editable) then
        LIWCmb.SetFocus;
      // AOSTA_REGIONE - commessa: 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
    end;

    // Verifica fase corrente e parametro aziendale per inibire la modifica delle date inizio e fine
    LBloccaDate:=False;
    if (Parametri.CampiRiferimento.C8_W032BloccaDate = 'S') and
       (grdRichieste.medpStato = msEdit) and
       (LFaseCorr >= M140FASE_CASSA) then
      LBloccaDate:=True;

    // impedisce modifica periodo per missione riaperta
    if (LAbilitaDett or (R180Between(grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA'),M140TR_0,M140TR_3))) and
       (grdRichieste.medpValoreColonna(i,'MISSIONE_RIAPERTA') <> 'S') then
    begin
      // modifica data inizio e data fine solo se autorizzato e la fase lo consente
      if not LBloccaDate then
      begin
        // data inizio
        grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
        c:=grdRichieste.medpIndexColonna('DATADA');
        grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
        LIWEdtInizio:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
        LIWEdtInizio.Css:='input_data_dmy';
        if grdRichieste.medpStato = msEdit then
          LIWEdtInizio.Text:=grdRichieste.medpValoreColonna(i,'DATADA');

        // data fine
        grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
        c:=grdRichieste.medpIndexColonna('DATAA');
        grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
        LIWEdtFine:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
        LIWEdtFine.Css:='input_data_dmy';
        if grdRichieste.medpStato = msEdit then
          LIWEdtFine.Text:=grdRichieste.medpValoreColonna(i,'DATAA');

        // imposta la gestione automatica della selezione del periodo
        AssegnaGestPeriodo(LIWEdtInizio,LIWEdtFine);
      end;

      // ora inizio
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
      c:=grdRichieste.medpIndexColonna('ORADA');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      LIWEdt:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
      if grdRichieste.medpStato = msEdit then
        LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORADA');

      // ora fine
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
      c:=grdRichieste.medpIndexColonna('ORAA');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      LIWEdt:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
      if grdRichieste.medpStato = msEdit then
        LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORAA');

      if LAbilitaDett then //Non consentita la modifica dopo la prima autorizzazione
      begin
        // tipo missione (parametrizzato a livello aziendale)
        if Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S' then
        begin
          // nota: cfr. OnRenderCell -> la combobox viene nascosta in alcuni casi
          grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'20','','','','S');
          c:=grdRichieste.medpIndexColonna('C_TIPOREGISTRAZIONE');
          grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
          LIWCmb:=(grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox);
          LIWCmb.ItemsHaveValues:=True;
          LIWCmb.Items.Assign(FListaTipiRegistrazione);
          LIWCmb.Items.Insert(0,'=');
          if grdRichieste.medpStato = msInsert then
            LIWCmb.ItemIndex:=0
          else if grdRichieste.medpStato = msEdit then
            LIWCmb.ItemIndex:=max(0,R180IndexFromValue(LIWCmb.Items,grdRichieste.medpValoreColonna(i,'TIPOREGISTRAZIONE')));
        end;
      end;
    end;

    // il link per il percorso è sempre visibile
    LIWLnk:=(grdRichieste.medpCompCella(i,'C_PERCORSO',0) as TmeIWLink);
    if LIWLnk <> nil then
    begin
      if LIWLnk.Text = '' then
        LIWLnk.Text:='Indicare il percorso';
      // Tag: indica se il percorso è abilitato alla modifica
      //   0 = modifica non abilitata (solo visualizzazione)
      //   1 = modifica abilitata
      LIWLnk.Tag:=IfThen(LAbilitaDett,1,0);
      LIWLnk.OnClick:=imgPercorsoClick;
    end;

    //Gestione abilitazione "CORRESPONSIONE_SPESE" "DIPENDENTE"
    if (Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup) <> nil then
    begin
      LDatiMezzo:=((Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup).medpTag as TDatiMezzo);
      LAbilitaCorresponsione:=LDaTestoAControlli and R180In(C018.FaseLivello[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger].ToString,LDatiMezzo.FasiCompetenza.Split([',']));
      AbilitazioneComponente((Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup),LAbilitaCorresponsione);
    end;
  end
  else
  begin
    if grdRichieste.medpValoreColonna(i,'REVOCABILE') = 'CANC' then
    begin
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('FLAG_DESTINAZIONE')]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('FLAG_ISPETTIVA')]);
    end;
    if LAbilitaDett then
    begin
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('DATADA')]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('DATAA')]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('ORADA')]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('ORAA')]);
      if Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S' then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_TIPOREGISTRAZIONE')]);
    end;
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')]);
  end;
end;

procedure TW032FRichiestaMissioni.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,c,FaseCorr,FaseLiv,LivAut,CountM143M150: Integer;
  HintDesc,HintDataDesc,Revocabile,TR,StatoRimborsi,StatoM040,MissioneRiaperta: String;
  VisAutorizza,VisAnnulla,VisChiudi,VisRiapri,StatoNegato,LVisModificaDatiAut: Boolean;
  IWG: TmeIWGrid;
  IWImg: TmeIWImageFile;
  IWLnk: TmeIWLink;
  LIWImg: TmeIWImageFile;
  LIWGrd: TmeIWGrid;
  procedure ImpostaColRimborsi(const PFase: Integer);
  var
    MeseScarico: String;
    IWLbl: TmeIWLabel;
  begin
    W032DM.M150F_FILTRORIMBORSI.SetVariable('ID',C018.Id);
    W032DM.M150F_FILTRORIMBORSI.Execute;
    StatoRimborsi:=VarToStr(W032DM.M150F_FILTRORIMBORSI.GetVariable('RESULT'));
    MeseScarico:='';
    if (StatoRimborsi = 'L') and (W032DM.M150F_FILTRORIMBORSI.GetVariable('MESESCARICO') <> null) then
      MeseScarico:=FormatDateTime('mm/yyyy',W032DM.M150F_FILTRORIMBORSI.GetVariable('MESESCARICO'));

    // imposta colonna "Rimborsi"
    IWLbl:=(grdRichieste.medpCompCella(i,'C_RIMBORSI',0) as TmeIWLabel);
    if StatoRimborsi = 'N' then        // N = nessun rimborso
    begin
      // modifica.ini - daniloc 27.06.2012
      // v. chiamata <68205> (si vuole la dicitura "Liquidati" anche per rimborsi = 0)
      //Css:='invisibile'
      if PFase < M140FASE_CASSA then
        IWLbl.Css:='invisibile'
      else
      begin
        IWLbl.Css:='';
        IWLbl.Caption:='Nessuno';
      end;
      // modifica.fine
    end
    else
    begin
      IWLbl.Css:='';
      if StatoRimborsi = 'A' then      // A = rimborsi da autorizzare
        IWLbl.Caption:='Da autorizzare'
      else if StatoRimborsi = 'D' then // D = rimborsi da liquidare
        IWLbl.Caption:='Da liquidare'
      else if StatoRimborsi = 'L' then // L = rimborsi liquidati
        IWLbl.Caption:='Liquidati' + IfThen(MeseScarico <> '',Format('(%s)',[MeseScarico]));
    end;
  end;
begin
  if WR000DM.Responsabile then
  begin
    // autorizzazione
    for i:=0 to High(grdRichieste.medpCompGriglia) do
    begin
      // iter autorizzativo
      C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
      C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));

      // dettaglio iter
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile);
      IWImg.OnClick:=imgIterClick;
      IWImg.Hint:=C018.LeggiNoteComplete;
      IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
      // dettaglio allegati
      if C018.EsisteGestioneAllegati then
      begin
        //Alberto 20/02/2019.Inizio
        (*Attenzione!
          C018.SetIconaAllegati effettua spostamenti sul dataset selTabellaIter (selM140)
          e in questo caso (W032) scatena l'evento onCalcField che cambia i dati di C018
          Per mantenere la situazione uniforme ci si sposta subito sul record di selM140 corrispondente all'id corrente
          in modo che il contesto C018 non si disallinei
        *)
        if W032DM.selM140.SearchRecord('ROWID',IWImg.FriendlyName,[srFromBeginning]) then
        //Alberto 20/02/2019.Fine
        begin
          IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
          if C018.SetIconaAllegati(IWImg) then
            IWImg.OnClick:=imgAllegClick;
        end;
      end;
      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      // percorso trasferta
      IWLnk:=(grdRichieste.medpCompCella(i,'C_PERCORSO',0) as TmeIWLink);
      if IWLnk <> nil then
      begin
        IWLnk.OnClick:=imgPercorsoClick;
        IWLnk.Tag:=0; // indica che il percorso non è abilitato alla modifica (impostato in trasformacomponenti)
        IWLnk.Text:=grdRichieste.medpValoreColonna(i,'C_PERCORSO');
      end;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine

      LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
      VisAutorizza:=(not SolaLettura) and
                    (grdRichieste.medpValoreColonna(i,'ID_REVOCA') = '') and
                    (grdRichieste.medpValoreColonna(i,'AUTORIZZ_AUTOMATICA') <> 'S') and
                    (LivAut > 0);

      // imposta la fase, utilizzata successivamente
      FaseCorr:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE')),-1);
      FaseLiv:=C018.FaseLivello[LivAut];

      // imposta colonna "Rimborsi" e valorizza StatoM040
      ImpostaColRimborsi(FaseCorr);

      // se la missione è già stata caricata ed è in stato D = da liquidare
      // non consente la modifica dell'autorizzazione
      if VisAutorizza then
      begin
        if (grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE') = C018SI) and (StatoRimborsi = 'L') then
        begin
          VisAutorizza:=False;
        end
        else if (FaseCorr = M140FASE_RIMBORSI) and (FaseLiv <= M140FASE_RIMBORSI) and (StatoRimborsi = 'D') then
        begin
          VisAutorizza:=False;
        end
        // VARESE_PROVINCIA - chiamata 82392.ini
        // inibisce la modifica l'autorizzazione nel caso in cui:
        // - la richiesta è annullata <=> TIPO_RICHIESTA = M140TR_A
        //   oppure
        // - la missione è chiusa     <=> TIPO_RICHIESTA = M140TR_6
        else if grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA') = M140TR_A then
        begin
          // richiesta annullata
          VisAutorizza:=False;
        end
        else if grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA') = M140TR_6 then
        begin
          // richiesta chiusa (già importati i rimborsi su win)
          VisAutorizza:=False;
        end;
        // VARESE_PROVINCIA - chiamata 82392.fine
      end;

      if not VisAutorizza then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
        C018.SetValoriAut(grdRichieste,i,0,0,1,chkAutorizzazioneClick);

      // gestione modifica valori da parte dell'autorizzatore
      if (not SolaLettura) and C018.IterModificaValori then
      begin
        // estrae indice colonna
        c:=grdRichieste.medpIndexColonna('DBG_COMANDI');

        // 1. verifica modifica valori al livello corrente
        LVisModificaDatiAut:=C018.ModificaValori(LivAut);

        // 2. verifica esistenza dati personalizzati modificabili
        if LVisModificaDatiAut then
        begin
          // modifica possibile se ci sono dati personalizzati visibili alla fase del livello corrente
          W032DM.selM025.Filtered:=False;
          try
            W032DM.selM025.Filter:=Format('(CATEGORIA <> ''%s'') and (CATEGORIA <> ''%s'') and (%s >= MIN_FASE_MODIFICA_CAT) and (%s <= MAX_FASE_MODIFICA_CAT)',
                                          [MISSIONE_COD_CAT_ESTERO_MOTIVAZIONI,MISSIONE_COD_CAT_ESTERO_IPOTESI,FaseLiv.ToString,FaseLiv.ToString]);
            W032DM.selM025.Filtered:=True;
            LVisModificaDatiAut:=(W032DM.selM025.RecordCount > 0);
          except
          end;
          W032DM.selM025.Filtered:=False;
        end;

        // colonna per modifica dati in fase di autorizzazione
        if LVisModificaDatiAut then
        begin
          // modifica
          LIWImg:=(grdRichieste.medpCompCella(i,c,0) as TmeIWImageFile);
          LIWImg.Hint:='Modifica dati richiesta';
          LIWImg.OnClick:=imgModificaDatiAutClick;

          // annulla
          LIWImg:=(grdRichieste.medpCompCella(i,c,1) as TmeIWImageFile);
          LIWImg.Hint:='Annulla modifica dati richiesta';
          LIWImg.OnClick:=imgAnnullaDatiAutClick;

          // applica
          LIWImg:=(grdRichieste.medpCompCella(i,c,2) as TmeIWImageFile);
          LIWImg.Hint:='Conferma modifica dati richiesta';
          LIWImg.OnClick:=imgConfermaDatiAutClick;
        end;

        // gestione visibilità icona di modifica
        LIWGrd:=(grdRichieste.medpCompGriglia[i].CompColonne[c] as TmeIWGrid);
        // consente modifica dati se è abilitata al livello della richiesta
        if not LVisModificaDatiAut then
          LIWGrd.Cell[0,0].Css:='invisibile';
        LIWGrd.Cell[0,1].Css:='invisibile';
        LIWGrd.Cell[0,2].Css:='invisibile';
      end;
    end;
  end
  else
  begin
    // richiesta
    if grdRichieste.medpRigaInserimento then
    begin
      (grdRichieste.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
      (grdRichieste.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
      (grdRichieste.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
      LIWGrd:=(grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid);
      LIWGrd.Cell[0,1].Css:='invisibile';
      LIWGrd.Cell[0,2].Css:='invisibile';
    end;
    for i:=IfThen(grdRichieste.medpRigaInserimento,1,0) to High(grdRichieste.medpCompGriglia) do
    begin
      // iter autorizzativo
      C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
      C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));

      // dettaglio iter
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile);
      IWImg.OnClick:=imgIterClick;
      IWImg.Hint:=C018.LeggiNoteComplete;
      IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
      // dettaglio allegati
      if C018.EsisteGestioneAllegati then
      begin
        //Alberto 20/02/2019.Inizio
        (*Attenzione!
          C018.SetIconaAllegati effettua spostamenti sul dataset selTabellaIter (selM140)
          e in questo caso (W032) scatena l'evento onCalcField che cambia i dati di C018
          Per mantenere la situazione uniforme ci si sposta subito sul record di selM140 corrispondente all'id corrente
          in modo che il contesto C018 non si disallinei
        *)
        if W032DM.selM140.SearchRecord('ROWID',IWImg.FriendlyName,[srFromBeginning]) then
        //Alberto 20/02/2019.Fine
        begin
          IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
          if C018.SetIconaAllegati(IWImg) then
            IWImg.OnClick:=imgAllegClick;
         end;
      end;
      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      // percorso trasferta
      IWLnk:=(grdRichieste.medpCompCella(i,'C_PERCORSO',0) as TmeIWLink);
      if IWLnk <> nil then
      begin
        IWLnk.OnClick:=imgPercorsoClick;
        IWLnk.Tag:=0; // indica che il percorso non è abilitato alla modifica (impostato in trasformacomponenti)
        IWLnk.Text:=grdRichieste.medpValoreColonna(i,'C_PERCORSO');
      end;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine

      // imposta la variabile fase, utilizzata successivamente
      FaseCorr:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE')),-1);

      // imposta colonna "Rimborsi"
      ImpostaColRimborsi(FaseCorr);

      // stato della missione collegata (se esistente)
      StatoM040:='';
      W032DM.selM040.SetVariable('ID',C018.Id);
      W032DM.selM040.Execute;
      if W032DM.selM040.RowCount > 0 then
        StatoM040:=W032DM.selM040.FieldAsString(0);

      if (grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        case FaseCorr of
          M140FASE_INIZIALE..M140FASE_AUTORIZZAZIONE:
            HintDesc:=' di trasferta/anticipi';
          M140FASE_CASSA:
            HintDesc:=' di rimborsi';
          else
            HintDesc:='';
        end;
        HintDataDesc:=Format(' del %s',[grdRichieste.medpValoreColonna(i,'DATADA')]);
        HintDesc:=HintDesc + HintDataDesc;
        // cancella
        LIWImg:=(grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile);
        LIWImg.Hint:=LIWImg.Hint + HintDesc;
        LIWImg.OnClick:=imgCancellaClick;

        // modifica
        LIWImg:=(grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile);
        LIWImg.Hint:=LIWImg.Hint + HintDesc;
        LIWImg.OnClick:=imgModificaClick;

        // annulla
        LIWImg:=(grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile);
        LIWImg.Hint:=LIWImg.Hint + HintDesc;
        LIWImg.OnClick:=imgAnnullaClick;

        // applica
        LIWImg:=(grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile);
        LIWImg.Hint:=LIWImg.Hint + HintDesc;
        LIWImg.OnClick:=imgConfermaClick;

        // annulla missione
        LIWImg:=(grdRichieste.medpCompCella(i,0,4) as TmeIWImageFile);
        LIWImg.Hint:=LIWImg.Hint + HintDataDesc;
        LIWImg.OnClick:=imgAnnullaMissioneClick;

        // chiusura missione
        LIWImg:=(grdRichieste.medpCompCella(i,0,5) as TmeIWImageFile);
        LIWImg.Hint:=LIWImg.Hint + HintDataDesc;
        LIWImg.OnClick:=imgChiudiMissioneClick;

        // riapertura missione
        LIWImg:=(grdRichieste.medpCompCella(i,0,6) as TmeIWImageFile);
        LIWImg.Hint:=LIWImg.Hint + HintDataDesc;
        LIWImg.OnClick:=imgRiapriMissioneClick;

        // abilitazione azioni
        IWG:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
        Revocabile:=grdRichieste.medpValoreColonna(i,'REVOCABILE');
        TR:=grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA');
        StatoNegato:=C018.StatoNegato(grdRichieste.medpValoreColonna(i,'AUTORIZZ_UTILE'));
        MissioneRiaperta:=grdRichieste.medpValoreColonna(i,'MISSIONE_RIAPERTA');

        // conta i rimborsi + dettagli gg legati alla richiesta
        // NOTA: le indennità km automatiche sono escluse dal totale
        W032DM.selCountM143M150.SetVariable('ID',C018.Id);
        W032DM.selCountM143M150.Execute;
        CountM143M150:=W032DM.selCountM143M150.FieldAsInteger(0);

        // cancellazione
        if (Revocabile <> 'CANC') or
           (CountM143M150 > 0) or
           ((FaseCorr = M140FASE_CASSA) and (TR >= M140TR_4)) or  // controllo aggiunto 21.08.2012
            (FaseCorr > M140FASE_CASSA) then                       // controllo aggiunto 21.08.2012
        begin
          IWG.Cell[0,0].Css:='invisibile';
        end;

        // modifica impedita se esiste una autorizzazione negata
        if (StatoNegato) or
           ((FaseCorr = M140FASE_AUTORIZZAZIONE) or (FaseCorr > M140FASE_CASSA)) or
           ((FaseCorr = M140FASE_CASSA) and (TR >= M140TR_4)) then
        begin
          IWG.Cell[0,1].Css:='invisibile';
        end;
        IWG.Cell[0,2].Css:='invisibile';
        IWG.Cell[0,3].Css:='invisibile';

        // annullamento, chiusura missione e riapertura missione
        if StatoNegato then
        begin
          // impediti se esiste autorizzazione negativa
          IWG.Cell[0,4].Css:='invisibile';
          IWG.Cell[0,5].Css:='invisibile';
          IWG.Cell[0,6].Css:='invisibile';
        end
        else
        begin
          // annullamento missione
          VisAnnulla:=(FaseCorr >= M140FASE_CASSA) and
                      (FaseCorr < M140FASE_RIMBORSI) and
                      (CountM143M150 = 0) and
                      (TR <> M140TR_6) and
                      (TR <> M140TR_A);
          if not VisAnnulla then
          begin
            IWG.Cell[0,4].Css:='invisibile';
          end;
          // chiusura richiesta rimborsi
          // (TIPO_RICHIESTA = '') se esiste già autorizzazione a fase 1
          VisChiudi:=(FaseCorr >= M140FASE_CASSA) and
                     (FaseCorr < M140FASE_RIMBORSI) and
                     (TR < M140TR_4);
          if not VisChiudi then
          begin
            IWG.Cell[0,5].Css:='invisibile';
          end;
          // riapertura missione per rimborsi
          // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
          // la riapertura della missione è ora determinata dal relativo flag
          {
          // *** per il momento si valuta lo stato della missione su M040
          //     verificando che sia D = da liquidare oppure L = liquidata
          VisRiapri:=(Parametri.CampiRiferimento.C8_W032RiapriMissione = 'S') and
                     ((StatoM040 = 'D') or (StatoM040 = 'L')) and
                     (FaseCorr >= M140FASE_RIMBORSI);
          }
          VisRiapri:=MissioneRiaperta = 'S';
          // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
          if not VisRiapri then
          begin
            IWG.Cell[0,6].Css:='invisibile';
          end;
        end;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo,Valore: String;
  IWLnk: TmeIWLink;
const
  DEBUG_ELEMENT_OPEN  = '<div style="display: inline-block; border: 1px solid #ccc; margin: 0 auto 4px auto; padding: 3px 6px !important; background-color: #FFFFCC; font-size: 90%;">';
  DEBUG_ELEMENT_CLOSE = '</div>';
begin
  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=grdRichieste.medpNumColonna(AColumn);

  // contenuti allineati al centro
  Campo:=grdRichieste.medpColonna(NumColonna).DataField;
  if (Campo <> 'C_PERCORSO') and
     (Campo <> 'D_RESPONSABILE') then
  begin
    ACell.Css:=ACell.Css + ' align_center';
  end;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdRichieste.medpCompGriglia)) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    ACell.Text:='';

    if Campo = 'C_TIPOREGISTRAZIONE' then
    begin
      if (ACell.Control <> nil) and
         (ACell.Control is TmeIWComboBox) then
      begin
        // AOSTA_REGIONE - chiamata 82254.ini
        // mantiene visibile la combobox di selezione tipo missione solo se
        // sono presenti almeno 2 elementi fra cui scegliere
        // (si noti che l'elemento 0 è quello vuoto)
        // altrimenti visualizza il valore nel testo della cella e nasconde la combobox
        if (ACell.Control as TmeIWComboBox).Items.Count <= 2 then
        begin
          (ACell.Control as TmeIWComboBox).Css:='invisibile';
          ACell.Text:=grdRichieste.medpValoreColonna(ARow - 1,Campo);
        end;
        // AOSTA_REGIONE - chiamata 82254.fine
      end;
    end
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    else if Campo = 'C_PERCORSO' then
    begin
      // descrizione percorso limitata a MAX_LENGTH_ELENCO_DESTINAZIONI caratteri
      // il percorso completo è comunque riportato nell'hint
      if ACell.Control = nil then
      begin
        ACell.Hint:='';
        if ACell.Text.Length > MAX_LENGTH_ELENCO_DESTINAZIONI then
        begin
          ACell.Hint:=ACell.Text;
          ACell.Text:=ACell.Text.Substring(0,MAX_LENGTH_ELENCO_DESTINAZIONI) + '...';
        end;
      end
      else if ACell.Control is TmeIWLink then
      begin
        IWLnk:=TmeIWLink(ACell.Control);
        IWLnk.Hint:='';
        if Length(IWLnk.Text) > MAX_LENGTH_ELENCO_DESTINAZIONI then
        begin
          IWLnk.Hint:=IWLnk.Text;
          IWLnk.Text:=Copy(IWLnk.Text,1,MAX_LENGTH_ELENCO_DESTINAZIONI) + '...';
        end;
      end;
    end;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
  end;

  // impostazione css particolari
  if (ARow > 0) and (ARow - 1 <= High(grdRichieste.medpCompGriglia)) then
  begin
    // richieste annullate: colore font grigio
    if grdRichieste.medpValoreColonna(ARow - 1,'TIPO_RICHIESTA') = M140TR_A then
      ACell.Css:=ACell.Css + ' font_grigio';

    if (ACell.Control = nil) then
    begin
      // autorizzazione fase 1 / fase 4
      if (Campo = 'F1_STATO') or (Campo = 'F4_STATO') then
      begin
        Valore:=grdRichieste.medpValoreColonna(ARow - 1,Campo);
        ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                   IfThen(Valore = C018NO,' font_rosso');
        if Valore = '' then
          ACell.Text:=''
        else if Valore = C018NO then
          ACell.Text:='No'
        else
          ACell.Text:='Si';
      end
      else if Campo = 'D_TIPO_RICHIESTA' then
      begin
        ACell.RawText:=True;
        ACell.Text:=ACell.Text
          .Replace('TR:','<abbr title="Tipo richiesta">TR</abbr>:',[])
          .Replace('FC:','<abbr title="Fase corrente">FC</abbr>:',[])
          .Replace('FL:','<abbr title="Fase livello">FL</abbr>:',[])
          .Replace('[',DEBUG_ELEMENT_OPEN,[rfReplaceAll])
          .Replace(']',DEBUG_ELEMENT_CLOSE,[rfReplaceAll]);
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE4));
    Exit;
  end;
  VisualizzaDettagli(Sender);
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
procedure TW032FRichiestaMissioni.imgAllegClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE4),ESCLAMA);
    Exit;
  end;
  VisualizzaAllegati(Sender);
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

// CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
procedure TW032FRichiestaMissioni.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // imposta a nil il puntatore al frame del percorso quando ne viene effettuata la free
    if AComponent = W032PercorsoFM then
    begin
      W032PercorsoFM:=nil;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.imgPercorsoClick(Sender: TObject);
// apre il frame di gestione del percorso della trasferta
var
  FN: String;
  LAbilitaModifica: Boolean;
  LStr: String;
  i: Integer;
  LIWCmb: TmeIWComboBox;
begin
  FN:=(Sender as TmeIWLink).FriendlyName;
  LAbilitaModifica:=(Sender as TmeIWLink).Tag = 1;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);

  // verifica esistenza richiesta
  if grdRichieste.medpStato = msEdit then
  begin
    if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE4),ESCLAMA);
      Exit;
    end;
  end;

  // crea frame gestione percorso
  try
    W032PercorsoFM:=TW032FPercorsoFM.Create(Self);
    FreeNotification(W032PercorsoFM);
    W032PercorsoFM.AbilitaModifica:=LAbilitaModifica;
    W032PercorsoFM.W032DM:=W032DM;
    W032PercorsoFM.Inserimento:=grdRichieste.medpStato = msInsert;
    // la destinazione è ora multipla, su tabella M141
    W032PercorsoFM.PercorsoInfo.Partenza.CodLocalita:=FRichiesta.Partenza;
    W032PercorsoFM.PercorsoInfo.ElencoDestinazioni:=FRichiesta.ElencoDestinazioni;
    W032PercorsoFM.PercorsoInfo.Rientro.CodLocalita:=FRichiesta.Rientro;
    W032PercorsoFM.PercorsoInfo.FlagDestinazione:=FRichiesta.FlagDestinazione;
    W032PercorsoFM.PercorsoInfo.FlagPercorso:=FRichiesta.FlagPercorso;
    W032PercorsoFM.FlagDestinazioneInput:='';

    i:=grdRichieste.medpRigaDiCompGriglia(FN);

    //Alberto 12/09/2016
    //Valorizzo il tipo di Destinazione presente sulla richiesta per eventuale confronto col percorso
    //nel caso di tappe non presenti sul distanziometro
    if (grdRichieste.medpStato <> msBrowse) and (Assigned(grdRichieste.medpCompCella(i,'C_DESTINAZIONE',0) as TmeIWComboBox)) then
    begin
      LIWCmb:=(grdRichieste.medpCompCella(i,'C_DESTINAZIONE',0) as TmeIWComboBox);
      W032PercorsoFM.FlagDestinazioneInput:=LIWCmb.Items.ValueFromIndex[LIWCmb.ItemIndex];
    end;

    if (grdRichieste.medpStato = msBrowse) or
       ((grdRichieste.medpStato <> msInsert) and
        (WR000DM.Responsabile or not R180Between(grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA'),M140TR_0,M140TR_3))) then
    begin
      // se richiesta in fase >= 1 estrae periodo da m140
      W032PercorsoFM.DataInizioMissione:=W032DM.selM140.FieldByName('DATADA').AsDateTime;
      W032PercorsoFM.DataFineMissione:=W032DM.selM140.FieldByName('DATAA').AsDateTime;
    end
    else
    begin
      // altrimenti legge il periodo dagli edit
      // data inizio
      LStr:=(grdRichieste.medpCompCella(i,'DATADA',0) as TmeIWEdit).Text;
      if LStr = '' then
        raise Exception.Create('E'' necessario indicare la data di inizio della trasferta!');
      if not TryStrToDateTime(LStr,W032PercorsoFM.DataInizioMissione,TFunzioniGenerali.CreateDefaultFormatSettings) then
        raise Exception.Create('E'' necessario indicare una data valida di inizio della trasferta');
      // data fine
      LStr:=(grdRichieste.medpCompCella(i,'DATAA',0) as TmeIWEdit).Text;
      if LStr = '' then
        raise Exception.Create('E'' necessario indicare la data di fine della trasferta!');
      if not TryStrToDateTime(LStr,W032PercorsoFM.DataFineMissione,TFunzioniGenerali.CreateDefaultFormatSettings) then
        raise Exception.Create('E'' necessario indicare una data valida di fine della trasferta');
    end;
    // CUNEO_ASLCN1 - chiamata 91182.fine
    W032PercorsoFM.Visualizza;
  except
    on E: Exception do
    begin
      FreeAndNil(W032PercorsoFM);
      MsgBox.MessageBox(Format('Errore durante l''apertura dell''editor del percorso trasferta:'#13#10'%s',[E.Message]),ESCLAMA);
    end;
  end;
end;

procedure TW032FRichiestaMissioni.ConfermaPercorso(PPercorsoInfo: TPercorsoInfo);
// conferma i dati del percorso della trasferta
var
  r, idx: Integer;
  LIWCmb: TmeIWComboBox;
begin
  FRichiesta.Partenza:=PPercorsoInfo.Partenza.CodLocalita;
  FRichiesta.ElencoDestinazioni:=PPercorsoInfo.ElencoDestinazioni;
  FRichiesta.Rientro:=PPercorsoInfo.Rientro.CodLocalita;
  FRichiesta.FlagDestinazione:=PPercorsoInfo.FlagDestinazione;
  FRichiesta.FlagPercorso:=PPercorsoInfo.FlagPercorso;

  // aggiorna la vista
  if grdRichieste.medpStato <> msBrowse then
  begin
    // determina la riga da aggiornare
    if grdRichieste.medpStato = msInsert then
      r:=0
    else
      r:=grdRichieste.medpRigaDiCompGriglia(W032DM.selM140.RowId);

    // 1. flag destinazione
    // itemindex della combobox flag destinazione
    if FRichiesta.FlagDestinazione = 'R' then
      idx:=0
    else if FRichiesta.FlagDestinazione = 'I' then
      idx:=1
    else if FRichiesta.FlagDestinazione = 'E' then
      idx:=2
    else
      idx:=-1;
    // aggiorna il flag destinazione in tabella
    try
      if idx > -1 then
      begin
        LIWCmb:=(grdRichieste.medpCompCella(r,'C_DESTINAZIONE',0) as TmeIWComboBox);
        if Assigned(LIWCmb) then
        begin
          LIWCmb.ItemIndex:=idx;
          cmbFlagDestinazioneChange(LIWCmb);
        end;
      end;
    except
      // nessuna modifica se ci sono errori
    end;

    // 2. percorso
    try
      (grdRichieste.medpCompCella(r,'C_PERCORSO',0) as TmeIWLink).Text:=PPercorsoInfo.Testo;
    except
      // nessuna modifica se ci sono errori
    end;
  end;
end;

// CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
procedure TW032FRichiestaMissioni.AnnullaPercorso;
// annulla le modifiche ai dati del percorso della trasferta,
// ripristinando la situazione originale
var
  r: Integer;
begin
  // AOSTA_REGIONE - chiamata 88372.ini
  // bugfix: in fase di inserimento l'annullamento del percorso
  // deve pulire i relativi dati del record Richiesta
  if grdRichieste.medpStato = msInsert then
  begin
    FRichiesta.Partenza:='';
    FRichiesta.ElencoDestinazioni:='';
    FRichiesta.Rientro:='';
    FRichiesta.FlagDestinazione:='';
    FRichiesta.FlagPercorso:='';
  end;
  // AOSTA_REGIONE - chiamata 88372.fine

  // aggiorna la vista
  if grdRichieste.medpStato <> msBrowse then
  begin
    // determina la riga da aggiornare
    if grdRichieste.medpStato = msInsert then
      r:=0
    else
      r:=grdRichieste.medpRigaDiCompGriglia(W032DM.selM140.RowId);

    // ripristina il percorso
    try
      (grdRichieste.medpCompCella(r,'C_PERCORSO',0) as TmeIWLink).Text:=IfThen(FRichiesta.PercorsoTesto = '','Indicare il percorso',FRichiesta.PercorsoTesto);
    except
      // nessuna modifica se ci sono errori
    end;
  end;
end;
// CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

function TW032FRichiestaMissioni.CtrlSalvaDatiPersonalizzati: TResCtrl;
// funzione di controllo dei dati personalizzati
// - verifica i dati (obbligatorietà, formato, ecc...)
// - memorizza le informazioni nella struttura dati TRichiesta passata come parametro
// restituisce True se i controlli sono andati a buon fine, False altrimenti
var
  i: Integer;
  LValore: String;
  LIWC: TIWCustomControl;
  LIWCmb: TMedpIWMultiColumnComboBox;
  LDatoPers: TDatoPersonalizzato;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  if FRichiesta.DatiPers <> nil then
    FreeAndNil(FRichiesta.DatiPers);
  FRichiesta.DatiPers:=TDictionary<String,TDatoPersonalizzato>.Create;

  for i:=0 to grdDati.RowCount - 1 do
  begin
    // estrae il componente di input da analizzare
    LIWC:=grdDati.Cell[i,1].Control;
    if Assigned(LIWC) then
    begin
      LDatoPers:=nil;
      if LIWC is TmeIWEdit then
      begin
        // valore libero (su una righe)
        LValore:=Trim((LIWC as TmeIWEdit).Text);
        LDatoPers:=((LIWC as TmeIWEdit).medpTag as TDatoPersonalizzato);
        LDatoPers.ValoreStr:=LValore;
        if LDatoPers.Obbligatorio then
        begin
          if LValore = '' then
          begin
            Result.Messaggio:=Format('L''indicazione del dato %s è obbligatoria!',[LDatoPers.Descrizione]);
            LIWC.SetFocus;
            Exit;
          end;
        end;
        if (LDatoPers.LungMax > 0) and
           (LValore.Length > LDatoPers.LungMax) then
        begin
          Result.Messaggio:=Format('Il dato %s può contenere al massimo %d caratteri!'#13#10'(lunghezza corrente: %d)',[LDatoPers.Descrizione,LDatoPers.LungMax,LValore.Length]);
          LIWC.SetFocus;
          Exit;
        end;
      end
      else if LIWC is TmeIWMemo then
      begin
        // valore libero (su più righe)
        LValore:=Trim((LIWC as TmeIWMemo).Text);
        LDatoPers:=((LIWC as TmeIWMemo).medpTag as TDatoPersonalizzato);
        LDatoPers.ValoreStr:=LValore;
        if LDatoPers.Obbligatorio then
        begin
          if LValore = '' then
          begin
            Result.Messaggio:=Format('L''indicazione del dato %s è obbligatoria!',[LDatoPers.Descrizione]);
            LIWC.SetFocus;
            Exit;
          end;
        end;
        if (LDatoPers.LungMax > 0) and
           (LValore.Length > LDatoPers.LungMax) then
        begin
          Result.Messaggio:=Format('Il dato %s può contenere al massimo %d caratteri!'#13#10'(lunghezza corrente: %d)',[LDatoPers.Descrizione,LDatoPers.LungMax,LValore.Length]);
          LIWC.SetFocus;
          Exit;
        end;
      end
      else if LIWC is TMedpIWMultiColumnComboBox then
      begin
        // combo di selezione valori
        LIWCmb:=(LIWC as TMedpIWMultiColumnComboBox);
        LDatoPers:=(LIWCmb.medpTag as TDatoPersonalizzato);

        // salva il valore
        if LDatoPers.ElencoTabellare then
          LValore:=LIWCmb.Text.Substring(0,LDatoPers.LungCodice).Trim
        else
          LValore:=LIWCmb.Text.Trim;
        LDatoPers.ValoreStr:=LValore;

        // controllo dato obbligatorio
        if LDatoPers.Obbligatorio then
        begin
          if LValore = '' then
          begin
            Result.Messaggio:=Format('E'' necessario selezionare un valore per il dato %s!',[LDatoPers.Descrizione]);
            LIWC.SetFocus;
            Exit;
          end;
        end;
      end;

      // aggiunge le meta informazioni al dictionary dei dati personalizzati
      if LDatoPers <> nil then
      begin
        FRichiesta.DatiPers.Add(LDatoPers.Codice,LDatoPers);
      end;
    end;
  end;

  // controlli ok
  Result.Ok:=True;
end;

function TW032FRichiestaMissioni.ControlliOK(const FN: String):Boolean;
var
  i,j: Integer;
  LMezziSel: Integer;
  LOraDaMinuti: Integer;
  LOraAMinuti: Integer;
  LIWC: TIWCustomControl;
  LValore: String;
  LNomeMezzo: String;
  LErroreMezzoAmmi: String;
  LErroreCheckPercorso: String;
  LDatiMezzo: TDatiMezzo;
  LPeriodoVariato: Boolean;
  LOk: Boolean;
  LIWCmb: TmeIWComboBox;
  LResCtrl: TResCtrl;
begin
  Result:=False;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  if (grdRichieste.medpStato <> msInsert) and
     (not R180Between(grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA'),M140TR_0,M140TR_3)) then
  begin
    // se richiesta in fase >= 1 i controlli non devono essere effettuati
    Result:=True;
    Exit;
  end;

  LIWC:=nil;

  // flag destinazione, percorso, ispettiva
  if grdRichieste.medpStato in [msInsert,msEdit] then
  begin
    // flag destinazione
    LIWC:=grdRichieste.medpCompCella(i,'C_DESTINAZIONE',0);
    if Assigned(LIWC) then
    begin
      case (LIWC as TmeIWComboBox).ItemIndex of
        0: FRichiesta.FlagDestinazione:='R';
        1: FRichiesta.FlagDestinazione:='I';
        2: FRichiesta.FlagDestinazione:='E';
      end;
    end
    else
    begin
      FRichiesta.FlagDestinazione:=W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString;
    end;
    if FRichiesta.FlagDestinazione = '' then
    begin
      MsgBox.MessageBox('Indicare la tipologia di destinazione della trasferta!',INFORMA);
      ActiveControl:=LIWC;
      Exit;
    end;

    // flag percorso (in modifica)
    if (grdRichieste.medpStato = msEdit) and (W032PercorsoFM = nil) and (FRichiesta.FlagPercorso = '') then
      FRichiesta.FlagPercorso:=W032DM.selM140.FieldByName('FLAG_PERCORSO').AsString;

    // flag ispettiva
    LIWC:=grdRichieste.medpCompCella(i,'C_ISPETTIVA',0);
    if LIWC <> nil then
    begin
      FRichiesta.FlagIspettiva:=(LIWC as TmeIWComboBox).Items.ValueFromIndex[(LIWC as TmeIWComboBox).ItemIndex];
    end
    else
    begin
      FRichiesta.FlagIspettiva:=W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString;
    end;
    if FRichiesta.FlagIspettiva = '' then
    begin
      MsgBox.MessageBox('Indicare se trasferta Ispettiva!',INFORMA);
      ActiveControl:=LIWC;
      Exit;
    end;
  end;

  //+++.ini
  // periodo richiesta: solo per dipendente
  if not WR000DM.Responsabile then
  begin
    FRichiesta.DataDa:=W032DM.selM140.FieldByName('DATADA').AsDateTime;
    FRichiesta.OraDa:=W032DM.selM140.FieldByName('ORADA').AsString;
    FRichiesta.DataA:=W032DM.selM140.FieldByName('DATAA').AsDateTime;
    FRichiesta.OraA:=W032DM.selM140.FieldByName('ORAA').AsString;
    if grdRichieste.medpCompCella(i,'DATADA',0) <> nil then
    begin
      // data inizio
      LIWC:=grdRichieste.medpCompCella(i,'DATADA',0);
      LValore:=(LIWC as TmeIWEdit).Text;
      if LValore = '' then
      begin
        MsgBox.MessageBox('Indicare la data di inizio della trasferta!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
      if not TryStrToDateTime(LValore,FRichiesta.DataDa,TFunzioniGenerali.CreateDefaultFormatSettings) then
      begin
        MsgBox.MessageBox('La data di inizio della trasferta non è valida!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;

      // data fine
      LIWC:=grdRichieste.medpCompCella(i,'DATAA',0);
      LValore:=(LIWC as TmeIWEdit).Text;
      if LValore = '' then
      begin
        MsgBox.MessageBox('Indicare la data di fine della trasferta!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
      if not TryStrToDateTime(LValore,FRichiesta.DataA,TFunzioniGenerali.CreateDefaultFormatSettings) then
      begin
        MsgBox.MessageBox('La data di fine della trasferta non è valida!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;

      // coerenza periodo
      if FRichiesta.DataDa > FRichiesta.DataA then
      begin
        MsgBox.MessageBox('Il periodo della trasferta non è valido!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
    end;

    // ora inizio
    LIWC:=grdRichieste.medpCompCella(i,'ORADA',0);
    LValore:=(LIWC as TmeIWEdit).Text;
    if LValore = '' then
    begin
      MsgBox.MessageBox('Indicare l''ora di inizio della trasferta!',INFORMA);
      ActiveControl:=LIWC;
      Exit;
    end;
    try
      R180OraValidate(LValore);
    except
      on E:Exception do
      begin
        MsgBox.MessageBox(E.Message,INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
    end;
    FRichiesta.OraDa:=LValore;

    // ora fine
    LIWC:=grdRichieste.medpCompCella(i,'ORAA',0);
    LValore:=(LIWC as TmeIWEdit).Text;
    if LValore = '' then
    begin
      MsgBox.MessageBox('Indicare l''ora di fine della trasferta!',INFORMA);
      ActiveControl:=LIWC;
      Exit;
    end;
    try
      R180OraValidate(LValore);
    except
      on E:Exception do
      begin
        MsgBox.MessageBox(E.Message,INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
    end;
    FRichiesta.OraA:=LValore;
  end
  else
  begin
    // per il responsabile estrae i dati dal dataset
    FRichiesta.DataDa:=W032DM.selM140.FieldByName('DATADA').AsDateTime;
    FRichiesta.OraDa:=W032DM.selM140.FieldByName('ORADA').AsString;
    FRichiesta.DataA:=W032DM.selM140.FieldByName('DATAA').AsDateTime;
    FRichiesta.OraA:=W032DM.selM140.FieldByName('ORAA').AsString;
  end;

  // verifica richiesta duplicata
  if grdRichieste.medpStato in [msInsert,msEdit] then
  begin
    W032DM.selM040PK.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    if grdRichieste.medpStato in [msEdit] then
      W032DM.selM040PK.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger)
    else
      W032DM.selM040PK.SetVariable('ID',-1);
    W032DM.selM040PK.SetVariable('DATADA',FRichiesta.DataDa);
    W032DM.selM040PK.SetVariable('ORADA',FRichiesta.OraDa);
    W032DM.selM040PK.SetVariable('PARTENZA',FRichiesta.Partenza);
    W032DM.selM040PK.SetVariable('ELENCO_DEST',FRichiesta.ElencoDestinazioni);
    W032DM.selM040PK.SetVariable('RIENTRO',FRichiesta.Rientro);
    W032DM.selM040PK.Execute;
    if W032DM.selM040PK.FieldAsInteger(0) > 0 then
    begin
      MsgBox.MessageBox('Esiste già una missione con stessa data e ora di partenza e stesso percorso!',INFORMA);
      Exit;
    end;
  end;

  // coerenza ora inizio - fine se la trasferta è in giornata
  LOraDaMinuti:=R180OreMinutiExt(FRichiesta.OraDa);
  LOraAMinuti:=R180OreMinutiExt(FRichiesta.OraA);
  if (FRichiesta.DataDa = FRichiesta.DataA) and
     (LOraDaMinuti > LOraAMinuti) then
  begin
    MsgBox.MessageBox('Il periodo orario della trasferta non è corretto!',INFORMA);
    if Assigned(LIWC) then
      ActiveControl:=LIWC;
    Exit;
  end;

  // controlli in fase di modifica
  if grdRichieste.medpStato = msEdit then
  begin
    // in fase di modifica imposta anche il tipo registrazione, in modo che se si saltano
    // i controlli successivi sia correttamente impostato per l'update
    FRichiesta.TipoRegistrazione:=W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString;

    LPeriodoVariato:=(FRichiesta.DataDa <> W032DM.selM140.FieldByName('DATADA').AsDateTime) or
                     (FRichiesta.OraDa <> W032DM.selM140.FieldByName('ORADA').AsString) or
                     (FRichiesta.DataA <> W032DM.selM140.FieldByName('DATAA').AsDateTime) or
                     (FRichiesta.OraA <> W032DM.selM140.FieldByName('ORAA').AsString);

    // controlli in caso di periodo missione modificato
    if LPeriodoVariato then
    begin
      RegistraMsg.InserisciMessaggio('I',Format('ID = %d; ControlliOK.PeriodoVariato',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
      // se i rimborsi sono dettagliati impedisce conferma se sono presenti rimborsi
      // con date successive alla nuova data di fine missione
      if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
      begin
        W032DM.selM150.Filtered:=False;
        W032DM.selM150.Filter:=Format('DATA_RIMBORSO > %s',[FloatToStr(FRichiesta.DataA)]);
        W032DM.selM150.Filtered:=True;
        LOk:=W032DM.selM150.RecordCount = 0;
        W032DM.selM150.Filtered:=False;
        if not LOk then
        begin
          LValore:='Impossibile confermare la modifica al periodo della missione,'#13#10 +
                  'in quanto sono presenti rimborsi con date successive'#13#10 +
                  'alla fine della trasferta.';
          MsgBox.MessageBox(LValore,INFORMA);
          Exit;
        end;
      end;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

      // se ci sono servizi attivi avvisa che saranno rimossi
      if W032DM.selM143.RecordCount > 0 then
      begin
        if W032DM.selM143.GetVariable('ID') <> W032DM.selM140.FieldByName('ID').Value then
        begin
          RegistraMsg.InserisciMessaggio('I',Format('I servizi attivi non sono allineati con la trasferta. M143.ID = %s; M140.ID = %s',[VarToStr(W032DM.selM143.GetVariable('ID')),W032DM.selM140.FieldByName('ID').AsString]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
          MsgBox.MessageBox('I servizi attivi non sono allineati con la trasferta. Annullare l''operazione!',INFORMA);
          Exit;
        end;
        LValore:='Attenzione!' + CRLF +
                'Il periodo della missione è stato modificato.' + CRLF +
                'I servizi attivi caricati saranno cancellati,' + CRLF +
                'e sarà necessario reinserirli.' + CRLF +
                'Vuoi continuare?';
        Messaggio('Conferma modifica periodo',LValore,CancellaServiziAttivi,nil);
        Exit;
      end;
    end;

    // se è attivo il controllo di validità verifica coerenza periodo con timbrature
    if FCtrlValiditaPeriodo then
    begin
      W032DM.USR_M140F_MSG_PERIODO_INVALIDO.SetVariable('PROGRESSIVO',W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
      W032DM.USR_M140F_MSG_PERIODO_INVALIDO.SetVariable('DATADA',FRichiesta.DataDa);
      W032DM.USR_M140F_MSG_PERIODO_INVALIDO.SetVariable('ORADA',FRichiesta.OraDa);
      W032DM.USR_M140F_MSG_PERIODO_INVALIDO.SetVariable('DATAA',FRichiesta.DataA);
      W032DM.USR_M140F_MSG_PERIODO_INVALIDO.SetVariable('ORAA',FRichiesta.OraA);
      W032DM.USR_M140F_MSG_PERIODO_INVALIDO.Execute;
      LValore:=VarToStr(W032DM.USR_M140F_MSG_PERIODO_INVALIDO.GetVariable('RESULT'));
      if LValore <> '' then
      begin
        MsgBox.MessageBox(LValore,INFORMA);
        Exit;
      end;
    end;
  end;

  FRichiesta.CapitoloTrasferta:=cmbCapitoloTrasferta.Text;

  // se fase >= 0 salta i controlli su altri dati (non sono più modificabili)
  if StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE')),-1) >= 0 then
  begin
    Result:=True;
    Exit;
  end;

  // tipo missione (tipo registrazione) - SOLO se parametrizzato (VARESE_PROVINCIA)
  if Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S' then
  begin
    LIWCmb:=(grdRichieste.medpCompCella(i,'C_TIPOREGISTRAZIONE',0) as TmeIWComboBox);
    // se non sono presenti elementi consente comunque il salvataggio del tipo missione vuoto
    if (LIWCmb.ItemIndex = 0) and (LIWCmb.Items.Count > 1) then
    begin
      // se esiste un solo elemento selezionabile (oltre all'elemento vuoto) lo seleziona automaticamente
      if LIWCmb.Items.Count = 2 then
      begin
        LIWCmb.ItemIndex:=1;
      end
      else
      begin
        MsgBox.MessageBox('Indicare il tipo di trasferta!',ERRORE);
        ActiveControl:=LIWCmb;
        Exit;
      end;
    end;
    FRichiesta.TipoRegistrazione:=LIWCmb.Items.ValueFromIndex[LIWCmb.ItemIndex];
  end;

  // salva i dati del percorso
  if W032PercorsoFM <> nil then
  begin
    // la destinazione è ora multipla, su tabella M141
    FRichiesta.Partenza:=W032PercorsoFM.PercorsoInfo.Partenza.CodLocalita;
    FRichiesta.ElencoDestinazioni:=W032PercorsoFM.PercorsoInfo.ElencoDestinazioni;
    FRichiesta.Rientro:=W032PercorsoFM.PercorsoInfo.Rientro.CodLocalita;
    FRichiesta.PercorsoTesto:=W032PercorsoFM.PercorsoInfo.Testo;
    FRichiesta.FlagDestinazione:=W032PercorsoFM.PercorsoInfo.FlagDestinazione;
    FRichiesta.FlagPercorso:=W032PercorsoFM.PercorsoInfo.FlagPercorso;
  end;


  if Parametri.CampiRiferimento.C8_W032CheckPercorso = '' then
  begin
    // destinazione obbligatoria
    if FRichiesta.ElencoDestinazioni = '' then
    begin
      MsgBox.MessageBox('Indicare almeno una destinazione nel percorso della trasferta!',ERRORE);
      Exit;
    end;
  end
  else
  begin
    // valutazione del percorso
    LErroreCheckPercorso:=W032DM.CheckPercorso(
      IfThen(grdRichieste.medpStato in [msEdit],W032DM.selM140.FieldByName('ID').AsInteger,-1),
      selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,
      FRichiesta);

    if LErroreCheckPercorso <> '' then
    begin
      MsgBox.MessageBox(LErroreCheckPercorso,ERRORE);
      Exit;
    end;
  end;

  // controllo dati personalizzati
  LResCtrl:=CtrlSalvaDatiPersonalizzati;
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,ERRORE);
    Exit;
  end;

  // AOSTA_REGIONE.fine
  // mezzi di trasporto: verifica targa, motivazione...
  LMezziSel:=0;
  for i:=0 to grdMezzi.RowCount - 1 do
  begin
    if (grdMezzi.Cell[i,0].Control is TmeIWGrid) and
       (((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).Checked) then
    begin
      LMezziSel:=LMezziSel + 1;
      LNomeMezzo:=((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).Caption;
      LDatiMezzo:=(((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).medpTag as TDatiMezzo);
      for j:=1 to (grdMezzi.Cell[i,0].Control as TmeIWGrid).ColumnCount - 1 do
      begin
        LIWC:=(grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control;
        if Assigned(LIWC) then
        begin
          LValore:=Trim((LIWC as TmeIWEdit).Text);
          if (((LIWC as TmeIWEdit).medpTag as TDatiMezzo).FlagMotivazione = 'S') and
             ((LValore = '') or (LValore = (LIWC as TmeIWEdit).medpWatermark)) then
          begin
            LIWC.SetFocus;
            MsgBox.MessageBox(Format('Indicare la motivazione per l''utilizzo del mezzo di trasporto %s!',[LNomeMezzo]),INFORMA);
            Exit;
          end
          else if (((LIWC as TmeIWEdit).medpTag as TDatiMezzo).FlagTarga = 'S') and (LValore = '') then
          begin
            LIWC.SetFocus;
            MsgBox.MessageBox(Format('Indicare la targa del mezzo di trasporto %s!',[LNomeMezzo]),INFORMA);
            Exit;
          end;
        end;
      end;
      //Corresponsione spese è obbligatorio per la missione non ispettiva con mezzo proprio
      if (LDatiMezzo.FlagMezzoProprio = 'S') //Mezzo proprio
      and (FRichiesta.FlagIspettiva <> 'S') //Missione non ispettiva
      //and ((grdMezzi.Cell[i + 1,0].Control as TmeTIWAdvRadioGroup).ItemIndex = -1)
      and ((Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup).ItemIndex = -1)
      and (Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup).Enabled then //Scelta non effettuata
      begin
        LIWC.SetFocus;
        MsgBox.MessageBox(Format('Selezionare la modalità di corresponsione delle spese di viaggio del mezzo di trasporto %s!',[LNomeMezzo]),INFORMA);
        Exit;
      end;
    end;
  end;
  if LMezziSel = 0 then
  begin
    MsgBox.MessageBox('E'' necessario selezionare almeno un mezzo di trasporto!',INFORMA);
    Exit;
  end;

  // controlli specifici per CUNEO_ASLCN1.ini
  if Parametri.RagioneSociale = 'Azienda Sanitaria Locale CN1' then
  begin
    // per le trasferte con partenza dal domicilio, verifica che non sia selezionato
    // il mezzo di servizio (identificato con FLAG_TARGA = 'S' and FLAG_MEZZO_PROPRIO <> 'S')
    LErroreMezzoAmmi:='';
    if FRichiesta.FlagPercorso = M140FLAG_PERCORSO_DOMICILIO then
    begin
      // verifica i mezzi di trasporto selezionati
      for i:=0 to grdMezzi.RowCount - 1 do
      begin
        if (grdMezzi.Cell[i,0].Control is TmeIWGrid) and
           (((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).Checked) then
        begin
          for j:=1 to (grdMezzi.Cell[i,0].Control as TmeIWGrid).ColumnCount - 1 do
          begin
            LIWC:=(grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control;
            if Assigned(LIWC) then
            begin
              LDatiMezzo:=((LIWC as TmeIWEdit).medpTag as TDatiMezzo);
              if (LDatiMezzo.FlagTarga = 'S') and (LDatiMezzo.FlagMezzoProprio <> 'S') then
              begin
                LErroreMezzoAmmi:=Format('Non è consentito selezionare il mezzo %s per le trasferte dal domicilio!',
                                        [(((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).Caption)]);
                Break;
              end;
            end;
          end;
        end;
      end;
      // errore bloccante se è selezionato il mezzo dell'amministrazione
      if LErroreMezzoAmmi <> '' then
      begin
        MsgBox.MessageBox(LErroreMezzoAmmi,INFORMA);
        Exit;
      end;
    end;
  end;
  // controlli specifici per CUNEO_ASLCN1.fine

  // tab anticipi
  if FGestAnticipi and tabMissioni.Tabs[rgAnticipi].Enabled then
  begin
    // controllo delegato
    if chkDelegato.Checked then
    begin
      if edtCercaDelegato.Visible then
      begin
        MsgBox.MessageBox('E'' necessario cercare il delegato utilizzando l''apposito pulsante!',INFORMA);
        ActiveControl:=edtCercaDelegato;
        Exit;
      end;
      if (cmbDelegato.Items.Count > 1) and
         (cmbDelegato.ItemIndex = 0) then
      begin
        MsgBox.MessageBox('Selezionare il nominativo del delegato dalla lista!',INFORMA);
        ActiveControl:=cmbDelegato;
        Exit;
      end;
      FRichiesta.Delegato:=Trim(Copy(cmbDelegato.Text,1,8))
    end
    else
      FRichiesta.Delegato:='';
  end;

  Result:=True;
end;

procedure TW032FRichiestaMissioni.CancellaServiziAttivi;
// cancellazione M143 in seguito a richiesta dopo variazione periodo missione
begin
  RegistraMsg.InserisciMessaggio('I',Format('ID = %d; CancellaServiziAttivi',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

  // ciclo di cancellazione dei servizi attivi
  W032DM.selM143.First;
  while not W032DM.selM143.Eof do
    W032DM.selM143.Delete;

  // aggiorna visualizzazione
  grdDettaglioGG.medpCaricaCDS;

  // rieffettua conferma missione
  if FImgApplica <> nil then
    FImgApplica.OnClick(FImgApplica);
end;

procedure TW032FRichiestaMissioni.imgInserisciClick(Sender: TObject);
var
  FN: string;
  i: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato <> msBrowse then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione di ' +
                      IfThen(grdRichieste.medpStato = msInsert,'inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA,'Operazione in corso');
    Exit;
  end;

  //Alberto 27/01/2015
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    if grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] <> nil then
    begin
      if grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] is TmeIWLink then
        (grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] as TmeIWLink).OnClick:=nil;
    end;
  end;

  // pulisce i dati
  CleanRecordRichiesta;

  // carica la lista dei tipi registrazione, senza applicare la function M011F_FILTROITER
  CaricaListaTipiRegistrazione;

  grdRichieste.medpStato:=msInsert;
  DBGridColumnClick(Sender,FN);
  tabMissioni.ActiveTab:=rgDettaglio;
  grdRichieste.medpBrowse:=False;
  TrasformaComponenti(FN);
end;

procedure TW032FRichiestaMissioni.imgModificaClick(Sender:TObject);
var
  FN: String;
  LErrore: String;
  LDebugMsg: String;
  i: Integer;
begin
  // modifica
  if grdRichieste.medpStato <> msBrowse then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione di ' +
                      IfThen(grdRichieste.medpStato = msInsert,'inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA,'Operazione in corso');
    Exit;
  end;

  //Alberto 27/01/2015
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    if grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] <> nil then
    begin
      if grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] is TmeIWLink then
        (grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] as TmeIWLink).OnClick:=nil;
    end;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // verifica presenza richiesta
  W032DM.selM140.Refresh; //sostituire con Refreshrecord?? nooooooo
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('La richiesta da modificare non è più disponibile!',INFORMA,'Richiesta eliminata');
    Exit;
  end;

  // porta la riga in modifica: trasforma i componenti
  grdRichieste.medpStato:=msEdit;
  DBGridColumnClick(Sender,FN);
  grdRichieste.medpBrowse:=False;
  TrasformaComponenti(FN);

  // se è attiva la gestione automatica del rimborso km e la fase è > M140FASE_CASSA,
  // inserisce o aggiorna il record di rimborso corrispondente
  if (W032DM.RimbAutomatico.Abilitato) and
     (W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger >= M140FASE_CASSA) then
  begin
    if W032DM.CaricaRimborsoAutomatico(FRegolaM010.Codice,LDebugMsg,LErrore) then
    begin
      // rimborso caricato: refresh del dataset e della relativa grid
      W032DM.selM150.Refresh;
      grdRimborsi.medpCaricaCDS;
      tabMissioni.Tabs[rgRimborsi].Caption:=Format('Rimborsi <span class="contatore_apice">%d</span>',[W032DM.selM150.RecordCount]);
    end
    else
    begin
      // rimborso non caricato
      if LErrore <> '' then
        GGetWebApplicationThreadVar.ShowMessage('Errore durante l''impostazione del rimborso automatico:'#13#10 + LErrore);
    end;
    DebugClear;
    DebugAdd(LDebugMsg);
  end
  else
  begin
    // messaggio debug
    DebugAdd(Format('Caricamento indennità km automatica non abilitato su regola (%s) %s, con tipo missione %s',[Parametri.CampiRiferimento.C8_Missione,FRegolaM010.Codice,FRegolaM010.TipoRegistrazione]));
  end;

  // selezione automatica tab se fase = M140FASE_CASSA
  if (W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger = M140FASE_CASSA) and
     ((tabMissioni.ActiveTab = rgDettaglio) or (tabMissioni.ActiveTab = rgAnticipi)) then
  begin
    tabMissioni.ActiveTab:=rgRimborsi;
  end;
end;

procedure TW032FRichiestaMissioni.imgCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  // verifica presenza richiesta
  W032DM.selM140.Refresh;
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('La richiesta da cancellare non è più disponibile!',INFORMA,'Richiesta eliminata');
    Exit;
  end;

  DBGridColumnClick(Sender,FN);
  actCancRichiesta(FN);
end;

procedure TW032FRichiestaMissioni.imgAnnullaClick(Sender: TObject);
// annulla le modifiche apportate nei componenti editabili
var
  LOldId: Integer;
begin
  // salva id richiesta per successivo riposizionamento
  LOldId:=W032DM.selM140.FieldByName('ID').AsInteger;

  // se ci sono operazioni pendenti, annulla eventuali modifiche non salvate
  if grdRichieste.medpStato <> msBrowse then
  begin
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    if W032DM.selM141.UpdatesPending then
      W032DM.selM141.CancelUpdates;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

    // voci di anticipo
    if W032DM.selM160.UpdatesPending then
      W032DM.selM160.CancelUpdates;

    // dettaglio giornaliero
    if W032DM.selM143.UpdatesPending then
      W032DM.selM143.CancelUpdates;

    // dati rimborso
    if W032DM.selM150.UpdatesPending then
      W032DM.selM150.CancelUpdates;
  end;

  // aggiorna visualizzazione
  VisualizzaDipendenteCorrente;

  // posizionamento sulla richiesta
  DBGridColumnClick(nil,LOldId.ToString);
end;

procedure TW032FRichiestaMissioni.imgConfermaClick(Sender: TObject);
var
  FN: String;
  LMsgErr: String;
  i: Integer;
  LResCtrl: TResCtrl;
begin
  FImgApplica:=(Sender as TmeIWImageFile);
  FN:=FImgApplica.FriendlyName;

  if (grdRichieste.medpStato = msEdit) then
  begin
    // se il record non esiste -> errore
    if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      grdRichieste.medpStato:=msBrowse;
      TrasformaComponenti(FN);
      MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:'#13#10'potrebbe essere stata eliminata nel frattempo.',INFORMA);
      Exit;
    end;
  end;

  RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgConfermaClick.%s',[W032DM.selM140.FieldByName('ID').AsInteger,IfThen(grdRichieste.medpStato = msInsert,'Insert','Edit')]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;
  FImgApplica:=nil;

  // effettua controlli sugli anticipi e li conferma
  LResCtrl:=ControllaConfermaAnticipi(FN);
  if not LResCtrl.Ok then
  begin
    if LResCtrl.Messaggio <> '' then
      MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
    Exit;
  end;

  // se la tabella dei dettagli gg è in modifica effettua controlli e conferma
  if grdDettaglioGG.medpStato <> msBrowse then
  begin
    if Assigned(FImgConfermaDettGG) then
    begin
      FImgConfermaDettGG.OnClick(FImgConfermaDettGG);
      // se ci sono errori in fase di conferma lo stato non viene impostato a msBrowse
      if grdDettaglioGG.medpStato <> msBrowse then
        Exit;
    end
    else
    begin
      MsgBox.MessageBox('La pagina di Servizi attivi è in modifica. Chiudere le modifiche prima di confermare l''intera missione.',ESCLAMA);
      Exit;
    end;
  end;

  // se la tabella dei rimborsi è in modifica effettua controlli e conferma
  if grdRimborsi.medpStato <> msBrowse then
  begin
    // la grid dei rimborsi è in modifica
    if Assigned(FImgConfermaRimb) then
    begin
      FImgConfermaRimb.OnClick(FImgConfermaRimb);
      // se ci sono errori in fase di conferma lo stato non viene impostato a msBrowse
      if grdRimborsi.medpStato <> msBrowse then
        Exit;
    end
    else
    begin
      MsgBox.MessageBox('La pagina dei Rimborsi è in modifica. Chiudere le modifiche prima di confermare l''intera missione.',ESCLAMA);
      Exit;
    end;
  end
  else
  begin
    // la grid dei rimborsi è in modalità browse

    // 1. se è presente il rimborso pasto verifica il limite in base al periodo della trasferta
    for i:=0 to FListaRimborsiPasto.Count - 1 do
    begin
      if W032DM.selM150.SearchRecord('CODICE',FListaRimborsiPasto[i],[srFromBeginning]) then
      begin
        //Il controllo sui rimborsi, in particolare sul rimborso pasto, si deve fare sempre
        //caso critico: modifica missione, inserimento e conferma rimborso pasto, modifica della durata della missione, conferma missione
        (*
        // bugfix: se il record è appena stato inserito (Rowid è vuoto) il controllo è già
        //         stato effettuato e non è più necessario
        if W032DM.selM150.RowId <> '' then
        *)
        begin
          // effettua controlli bloccanti
          if not CtrlRimborsoOK(W032DM.selM150.Rowid) then
            Exit;

          actModRimborso(W032DM.selM150.Rowid);
        end;
      end;
    end;
  end;

  // se sono indicate indennità km verifica che la somma sia >= 0
  if not CtrlSommaIndKmOK then
  begin
    MsgBox.MessageBox('La somma dei km richiesti come rimborso non può essere inferiore a 0!',ESCLAMA);
    Exit;
  end;

  // inserimento / aggiornamento
  if grdRichieste.medpStato = msInsert then
    actInsRichiesta
  else
    actModRichiesta(FN);

  // viene eseguita la function oracle personalizzata M140F_CHECKRICHIESTA
  // se il risultato non è nullo, significa che sono presenti errori (non bloccanti):
  // in questo caso visualizzare il messaggio a video in un msgbox
  RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgConfermaClick.M140F_CHECKRICHIESTA non bloccante',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  try
    W032DM.M140F_CHECKRICHIESTA.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
    W032DM.M140F_CHECKRICHIESTA.SetVariable('LIVELLO',W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);
    W032DM.M140F_CHECKRICHIESTA.SetVariable('FASE',W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger);
    W032DM.M140F_CHECKRICHIESTA.SetVariable('CHIUSURA','N');
    W032DM.M140F_CHECKRICHIESTA.Execute;
    LMsgErr:=VarToStr(W032DM.M140F_CHECKRICHIESTA.GetVariable('RESULT'));
  except
    on E: Exception do
    begin
      LMsgErr:=Format('%s (%s)',[E.Message,E.ClassName]);
    end;
  end;
  if LMsgErr <> '' then
  begin
    LMsgErr:=Format('Avviso:'#13#10'%s',[LMsgErr]);
    MsgBox.MessageBox(LMsgErr,INFORMA);
    Exit;
  end;
end;

procedure TW032FRichiestaMissioni.imgAnnullaMissioneClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // se il record non esiste -> errore
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:' + CRLF +
                      'potrebbe essere stata eliminata nel frattempo.',INFORMA);
    Exit;
  end;

  // crea frame per conferma annullamento
  W032MotivazioneFM:=TW032FMotivazioneFM.Create(Self);
  W032MotivazioneFM.W032DM:=W032DM;
  W032MotivazioneFM.Visualizza;
end;

procedure TW032FRichiestaMissioni.ConfermaAnnullaMissione(const PMotivazione: String);
begin
  // - se esiste missione su M040 si deve impostare lo stato su 'Da liquidare',
  //   e trasferire gli Anticipi (M060) sui Rimborsi (M050) in modo che passino gli addebiti sullo stipendio
  // - se gli anticipi sono erogati con assegno bancario, è possibile effettuare una restituzione
  //   (lo fa la cassa economale?); in tal caso si deve cambiare lo stato della missione in 'Liquidata'
  //   in modo che non passi più alle paghe;

  // salva la motivazione di annullamento
  W032DM.selM140.Edit;
  W032DM.selM140.FieldByName('ANNULLAMENTO').AsString:=PMotivazione;
  W032DM.selM140.Post;

  // chiude l'iter della richiesta
  C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
  C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;
  C018.InsUltimeAutorizzazioni(C018.LivMaxAut + 1,C018SI,C018AUTOMATICO,'S','Annullamento richiesta: ' + PMotivazione,True);
  C018.SetTipoRichiesta(M140TR_A);
  SessioneOracle.Commit;

  // esegue procedura m050p_carica_rimborsi_daiter
  W032DM.M050P_CARICA_RIMBORSI_DAITER.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
  try
    W032DM.M050P_CARICA_RIMBORSI_DAITER.Execute;
  except
    on E: Exception do
    begin
      Log(ERRORE,'Errore durante annullamento missione',E);
      MsgBox.MessageBox('Errore durante l''annullamento della missione:'#13#10 + E.Message,ESCLAMA);
    end;
  end;

  // elimina la missione da IrisWin se non ci sono anticipi
  RegistraMsg.InserisciMessaggio('I',Format('ID = %d; ConfermaAnnullaMissione.delM040',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W032DM.delM040.SetVariable('ANNULLAMENTO','S');
  W032DM.delM040.SetVariable('ID',C018.Id);
  W032DM.delM040.Execute;
  SessioneOracle.Commit;

  VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.imgChiudiMissioneClick(Sender: TObject);
var
  F1,F2,ContaM143: Integer;
  FN,MsgErr: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // se il record non esiste -> errore
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:' + CRLF +
                      'potrebbe essere stata eliminata nel frattempo.',INFORMA);
    Exit;
  end;
  DBGridColumnClick(Sender,FN);

  // imposta id e codice struttura su C018
  C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
  C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;
  RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgChiudiMissioneClick; C8_W032DettaglioGG = %s',[C018.Id,Parametri.CampiRiferimento.C8_W032DettaglioGG]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

  // AOSTA_REGIONE - chiamata 88372.ini
  // il controllo dettagli giornalieri viene effettuato solo in funzione del parametro aziendale
  // il conteggio dei record avviene ora direttamente con una query su db, senza utilizzare il dataset
  if (Parametri.CampiRiferimento.C8_W032DettaglioGG = 'S'){ and
     (tabMissioni.Tabs[rgDettaglioGG].Visible)} then
  begin
    // conta i servizi attivi con una query
    try
      RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgChiudiMissioneClick.selCountM143',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      W032DM.selCountM143.SetVariable('ID',C018.Id);
      W032DM.selCountM143.Execute;
      ContaM143:=W032DM.selCountM143.FieldAsInteger(0);
    except
      ContaM143:=0;
    end;

    // impedisce l'avanzamento se non sono presenti record di dettaglio gg
    if ContaM143 = 0 then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('Attenzione!'#13#10'E'' necessario specificare i servizi attivi!',INFORMA);
      Exit;
    end;
  end;
  // AOSTA_REGIONE - chiamata 88372.fine

  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
  // viene eseguita la function oracle personalizzata M140F_CHECKRICHIESTA
  // se il risultato non è nullo, significa che sono presenti errori:
  // in questo caso visualizzare il messaggio a video con msgbox e impedire la chiusura
  RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgChiudiMissioneClick.M140F_CHECKRICHIESTA bloccante',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  try
    W032DM.M140F_CHECKRICHIESTA.SetVariable('ID',C018.Id);
    W032DM.M140F_CHECKRICHIESTA.SetVariable('LIVELLO',W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);
    W032DM.M140F_CHECKRICHIESTA.SetVariable('FASE',W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger);
    W032DM.M140F_CHECKRICHIESTA.SetVariable('CHIUSURA','S');
    W032DM.M140F_CHECKRICHIESTA.Execute;
    MsgErr:=VarToStr(W032DM.M140F_CHECKRICHIESTA.GetVariable('RESULT'));
  except
    on E: Exception do
    begin
      MsgErr:=Format('%s (%s)',[E.Message,E.ClassName]);
    end;
  end;
  if MsgErr <> '' then
  begin
    MsgErr:=Format('Attenzione!'#13#10'Il seguente errore impedisce la chiusura della missione:'#13#10'%s',[MsgErr]);
    MsgBox.MessageBox(MsgErr,ESCLAMA,'Errore chiusura missione');
    Exit;
  end;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine

  // se non ci sono rimborsi + dettagli chiude automaticamente l'iter
  // effettuando l'importazione su Iriswin
  if W032DM.selM150.RecordCount + W032DM.selM143.RecordCount = 0 then
  begin
    RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgChiudiMissioneClick.TipoRichiesta = 5; selM150 + selM143 = 0',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    C018.SetTipoRichiesta(M140TR_5);

    // chiude l'iter della richiesta
    F1:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;
    C018.InsUltimeAutorizzazioni(C018.LivMaxAut + 1,C018SI,C018AUTOMATICO,'S','Chiusura richiesta',True);
    F2:=C018.FaseCorrente;
    if F2 > F1 then
      GestioneFasi(F1,F2);

    // esegue procedura m050p_carica_rimborsi_daiter
    W032DM.M050P_CARICA_RIMBORSI_DAITER.SetVariable('ID',C018.Id);
    try
      W032DM.M050P_CARICA_RIMBORSI_DAITER.Execute;
    except
      on E: Exception do
      begin
        Log(ERRORE,'Errore durante chiusura missione',E);
        MsgBox.MessageBox(Format('Si è verificato un errore durante la chiusura della missione:'#13#10'%s',[E.Message]),ESCLAMA);
      end;
    end;
    SessioneOracle.Commit;
  end
  else
  begin
    RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgChiudiMissioneClick.TipoRichiesta = 4; selM150 + selM143 <> 0',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    C018.SetTipoRichiesta(M140TR_4);
    SessioneOracle.Commit;
  end;

  // aggiorna visualizzazione
  VisualizzaDipendenteCorrente;

  // tenta posizionamento sulla richiesta chiusa
  DBGridColumnClick(nil,C018.Id.ToString);
end;

procedure TW032FRichiestaMissioni.imgRiapriMissioneClick(Sender: TObject);
var
  FN: String;
  L, F1, F2, OldId: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  RegistraMsg.InserisciMessaggio('I',Format('ROWID = %s; imgRiapriMissioneClick',[FN]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

  if Parametri.CampiRiferimento.C8_W032RiapriMissione <> 'S' then
    EXIT;

  // se il record non esiste -> errore
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:'#13#10'potrebbe essere stata eliminata nel frattempo.',INFORMA);
    Exit;
  end;
  DBGridColumnClick(Sender,FN);

  C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
  C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;
  OldId:=C018.Id;

  try
    // fase prima delle operazioni
    F1:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;

    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1 - riesame del 28/10/2014.ini
    //Alberto 06/11/2014: forzo la fase a M140FASE_RIMBORSI per impedire la cancellazione e limitare alla riapertura dei rimborsi
    if F1 > M140FASE_RIMBORSI then
      F1:=M140FASE_RIMBORSI;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1 - riesame del 28/10/2014.fine

    F2:=F1;
    // rimuove autorizzazioni fino al livello della fase rimborsi (incluso)
    // se ci sono più livelli per la fase rimborsi si considera il minore
    for L:=C018.LivMaxAut downto C018.LivelliFase[M140FASE_RIMBORSI].Min do
    begin
      C018.SetStato('',L);
      C018.SetAutorizzAutomatica('',L);
      // fase dopo le operazioni
      F2:=C018.FaseCorrente;
    end;
    //Resetto flag di autorizzazione automatica sulla T850
    C018.SetAutorizzAutomatica('',0);
    // riporta tipo_richiesta a M140TR_0, in modo che il dipendente possa modificare i rimborsi
    C018.SetTipoRichiesta(M140TR_0);

    // operazioni se la fase finale è minore di quella iniziale (dovrebbe sempre verificarsi questa situazione)
    if F2 < F1 then
    begin
      RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgRiapriMissioneClick.GestioneFasi;',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      GestioneFasi(F1,F2,True);
    end;

    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
    // imposta il flag di missione riaperta a 'N'
    W032DM.updM140Riapri.SetVariable('ID',C018.Id);
    W032DM.updM140Riapri.SetVariable('MISSIONE_RIAPERTA','N');
    W032DM.updM140Riapri.Execute;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine

    SessioneOracle.Commit;
  except
    // rollback? no, per via delle sessioni oracle condivise
    SessioneOracle.Commit;
  end;

  // rilegge i dati
  VisualizzaDipendenteCorrente;

  // posizionamento sulla richiesta
  DBGridColumnClick(nil,OldId.ToString);
end;

procedure TW032FRichiestaMissioni.actInsRichiesta;
// inserimento richiesta missione
begin
  LeggiRegolaMissione(FRichiesta.DataA);
  (*se non esistono le regole si esce senza registrare la richiesta*)
  if not FRegoleTrovate then
    exit;
  W032DM.selM140.Append;
  W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString:=IfThen(Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S',FRichiesta.TipoRegistrazione,FRegolaM010.TipoRegistrazione);
  W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString:=FRichiesta.FlagDestinazione;
  W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString:=FRichiesta.FlagIspettiva;
  W032DM.selM140.FieldByName('FLAG_PERCORSO').AsString:=FRichiesta.FlagPercorso;
  W032DM.selM140.FieldByName('DATADA').AsDateTime:=FRichiesta.DataDa;
  W032DM.selM140.FieldByName('DATAA').AsDateTime:=FRichiesta.DataA;
  W032DM.selM140.FieldByName('ORADA').AsString:=FRichiesta.OraDa;
  W032DM.selM140.FieldByName('ORAA').AsString:=FRichiesta.OraA;
  W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString:=W032_TIPO_ACCREDITO_CC; // default tipo accredito anticipi
  if not C018.WarningRichiesta then
  begin
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta);
    Exit;
  end
  else
  begin
    ConfermaInsRichiesta;
  end;
end;

procedure TW032FRichiestaMissioni.ConfermaInsRichiesta;
var
  i,j,IdIns,F1,F2: Integer;
  Campo, Codice, Valore, ErrMsg: String;
  DatiMezzo: TDatiMezzo;
  IWG: TmeIWGrid;
  IWEdt: TmeIWEdit;
  IWRgp: TmeTIWAdvRadioGroup;
begin
  try
    F1:=0;
    C018.PosponiInvioMail:=True;
    C018.InsRichiesta(M140TR_0,'','');
    if C018.MessaggioOperazione <> '' then
    begin
      W032DM.selM140.Cancel;
      raise Exception.Create(C018.MessaggioOperazione);
    end;
    //Alberto 08/02/2012: registro i dati originali del periodo e della data
    C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
    C018.SetDatoAutorizzatore('DATADA',W032DM.selM140.FieldByName('DATADA').AsString,0);
    C018.SetDatoAutorizzatore('DATAA',W032DM.selM140.FieldByName('DATAA').AsString,0);
    C018.SetDatoAutorizzatore('ORADA',W032DM.selM140.FieldByName('ORADA').AsString,0);
    C018.SetDatoAutorizzatore('ORAA',W032DM.selM140.FieldByName('ORAA').AsString,0);
    F2:=C018.FaseCorrente;
    IdIns:=C018.Id;

    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    // M141: destinazioni
    // imposta gli ID sul dataset selM141
    W032DM.selM141.First;
    while not W032DM.selM141.Eof do
    begin
      W032DM.selM141.Edit;
      W032DM.selM141.FieldByName('ID').AsInteger:=C018.Id;
      W032DM.selM141.Post;
      W032DM.selM141.Next;
    end;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

    // M170: mezzi di trasporto
    if not W032DM.selM170.Active then
    begin
      W032DM.selM170.SetVariable('ID',IdIns);
      W032DM.selM170.Open;
    end;
    for i:=0 to grdMezzi.RowCount - 1 do
    begin
      if grdMezzi.Cell[i,0].Control is TmeIWGrid then
      begin
        IWG:=(grdMezzi.Cell[i,0].Control as TmeIWGrid);
        if (IWG.Cell[0,0].Control as TmeIWCheckBox).Checked then
        begin
          DatiMezzo:=((IWG.Cell[0,0].Control as TmeIWCheckBox).medpTag as TDatiMezzo);
          W032DM.selM170.Append;
          W032DM.selM170.FieldByName('ID').AsInteger:=IdIns;
          W032DM.selM170.FieldByName('CODICE').AsString:=(IWG.Cell[0,0].Control as TmeIWCheckBox).FriendlyName;
          for j:=1 to (grdMezzi.Cell[i,0].Control as TmeIWGrid).ColumnCount - 1 do
          begin
            if IWG.Cell[0,j].Control <> nil then
            begin
              IWEdt:=(IWG.Cell[0,j].Control as TmeIWEdit);
              Campo:=IfThen((IWEdt.medpTag as TDatiMezzo).FlagTarga = 'S','TARGA','MOTIVAZIONE');
              W032DM.selM170.FieldByName(Campo).AsString:=IWEdt.Text;
            end;
          end;
          // gestione radiogroup spese viaggio
          if (DatiMezzo.FlagMezzoProprio = 'S') and
             (W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'N') then
          begin
            //IWRgp:=(grdMezzi.Cell[i + 1,0].Control as TmeTIWAdvRadioGroup);
            IWRgp:=(Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup);
            if IWRgp.ItemIndex = 0 then
            begin
              W032DM.selM170.FieldByName('CORRESPONSIONE_SPESE').AsString:='S';
            end
            else if IWRgp.ItemIndex = 1 then
            begin
              W032DM.selM170.FieldByName('CORRESPONSIONE_SPESE').AsString:='N';
            end;
          end;
          W032DM.selM170.Post;
        end;
      end;
    end;

    // M175: motivazioni per trasferta estera e dati personalizzati
    if (W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString = 'E') or
       (FEsistonoDatiPersonalizzati) then                                     // AOSTA_REGIONE - gestione dati personalizzati
    begin
      if not W032DM.selM175.Active then
      begin
        W032DM.selM175.SetVariable('ID',IdIns);
        W032DM.selM175.Open;
      end;
      // gestione dei dati personalizzati su M175
      if FEsistonoDatiPersonalizzati then
      begin
        // dati personalizzati: verifica indicazione dei dati obbligatori
        for Codice in FRichiesta.DatiPers.Keys do
        begin
          Valore:=FRichiesta.DatiPers[Codice].ValoreStr;
          if Valore <> '' then
          begin
            W032DM.selM175.Append;
            W032DM.selM175.FieldByName('ID').AsInteger:=IdIns;
            W032DM.selM175.FieldByName('CODICE').AsString:=Codice;
            W032DM.selM175.FieldByName('VALORE').AsString:=Valore;
            W032DM.selM175.Post;
          end;
        end;
      end;

      // motivazioni per trasferta estera
      if W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString = 'E' then
      begin
        for i:=0 to cgpMotivEstero.Items.Count - 1 do
        begin
          if cgpMotivEstero.IsChecked[i] then
          begin
            W032DM.selM175.Append;
            W032DM.selM175.FieldByName('ID').AsInteger:=IdIns;
            W032DM.selM175.FieldByName('CODICE').AsString:=cgpMotivEstero.Values[i];
            W032DM.selM175.Post;
          end;
        end;
        for i:=0 to cgpIpotesiEstero.Items.Count - 1 do
        begin
          if cgpIpotesiEstero.IsChecked[i] then
          begin
            W032DM.selM175.Append;
            W032DM.selM175.FieldByName('ID').AsInteger:=IdIns;
            W032DM.selM175.FieldByName('CODICE').AsString:=cgpIpotesiEstero.Values[i];
            W032DM.selM175.Post;
          end;
        end;
      end;
    end;

    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    // applica e committa su db le modifiche legate al percorso
    // questa operazione è da eseguire prima del ricalcolo del tipo missione
    SessioneOracle.ApplyUpdates([W032DM.selM141],True);
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

    // determina i tipi registrazione disponibili in base a M011F_FILTROITER
    // e imposta il primo tipo registrazione disponibile (ordine alfabetico)
    if not RicalcoloTipoMissione(True,ErrMsg) then
    begin
      // impossibile determinare un tipo missione in base alle regole definite dall'utente
      // eliminazione della richiesta appena inserita

      // elimina il record di testata della richiesta
      C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;
      C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
      C018.EliminaIter;

      // elimina fisicamente il record su M040
      RegistraMsg.InserisciMessaggio('I',Format('ID = %d; ConfermaInsRichiesta.delM040',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      W032DM.delM040.SetVariable('ANNULLAMENTO','N');
      W032DM.delM040.SetVariable('ID',C018.Id);
      W032DM.delM040.Execute;

      MsgBox.MessageBox('Impossibile confermare la richiesta!'#13#10 +
                        'Non è possibile determinare il tipo missione'#13#10 +
                        'in base ai dati inseriti.'#13#10 +
                        'Per ulteriori informazioni contattare l''ufficio competente',ESCLAMA);

      //si esce subito per lasciare la riga di richiesta ancora pendente con i dati inseriti dall'utente;
      //riconfermando, se il tipo viene trovato, la richiesta viene registrata normalmente.
      SessioneOracle.Commit;
      Exit;
    end;

    //Invio mail al resposabile, con i dati delle tabelle figlie già registrati
    C018.PosponiInvioMail:=False;
    C018.VerificaRichiestaEsistente('V');

    // gestione fasi
    if F2 > F1 then
    begin
      RegistraMsg.InserisciMessaggio('I',Format('ID = %d; ConfermaInsRichiesta.GestioneFasi;',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      GestioneFasi(F1,F2);
    end;

    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      (*Alberto 21/02/2017: il percorso rimane sul dataset in cache
      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
      // annulla le modifiche legate al percorso
      SessioneOracle.CancelUpdates([W032DM.selM141]);
      Richiesta.Partenza:='';
      Richiesta.ElencoDestinazioni:='';
      Richiesta.Rientro:='';
      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
      *)
      SessioneOracle.Commit;
      W032DM.selM140.Cancel;
      MsgBox.MessageBox(Format('Errore durante l''inserimento della richiesta:'#13#10'%s (%s)',[E.Message,E.ClassName]),ESCLAMA);
      Exit;
    end;
  end;

  C018.Periodo.Estendi(W032DM.selM140.FieldByName('DATADA').AsDateTime,W032DM.selM140.FieldByName('DATAA').AsDateTime);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  C018.StrutturaSel:=C018STRUTTURA_TUTTE;
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // rilegge i dati
  VisualizzaDipendenteCorrente;

  // posizionamento su riga appena inserita
  DBGridColumnClick(nil,IntToStr(IdIns));
end;

procedure TW032FRichiestaMissioni.AnnullaInsRichiesta;
begin
  W032DM.selM140.Cancel;
  VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.actModRichiesta(const FN: String);
// modifica richiesta missione
var
  i,j,LId: Integer;
  LCampo, LCodice, LValore, LErrRicalcoloTipoMissione: String;
  LDatiMezzo: TDatiMezzo;
  LFaseCorrente,LF1,LF2:Integer;
  IWG: TmeIWGrid;
  IWChk: TmeIWCheckBox;
  IWEdt: TmeIWEdit;
  IWRgp: TmeTIWAdvRadioGroup;
begin
  LeggiRegolaMissione(FRichiesta.DataA);

  // se non esistono le regole si esce senza registrare la richiesta
  if not FRegoleTrovate then
    exit;

  LId:=W032DM.selM140.FieldByName('ID').AsInteger;
  LFaseCorrente:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;

  // parte 1. aggiornamento M140
  if LFaseCorrente < M140FASE_AUTORIZZAZIONE then
  begin
    W032DM.selM140.Edit;
    // imposta sempre tiporegistrazione
    // potrebbe essere stato modificato per effetto di variazioni di flag_estero / ispettiva
    W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString:=IfThen(Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S',FRichiesta.TipoRegistrazione,FRegolaM010.TipoRegistrazione);
    W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString:=FRichiesta.FlagIspettiva;
    W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString:=FRichiesta.FlagDestinazione;
    W032DM.selM140.FieldByName('FLAG_PERCORSO').AsString:=FRichiesta.FlagPercorso;
    W032DM.selM140.FieldByName('DATADA').AsDateTime:=FRichiesta.DataDa;
    W032DM.selM140.FieldByName('DATAA').AsDateTime:=FRichiesta.DataA;
    W032DM.selM140.FieldByName('ORADA').AsString:=FRichiesta.OraDa;
    W032DM.selM140.FieldByName('ORAA').AsString:=FRichiesta.OraA;
    LF1:=0;
    C018.CodIter:='';
    C018.PosponiInvioMail:=True;
    C018.UpdRichiesta(M140TR_0);
    if C018.MessaggioOperazione <> '' then
    begin
      W032DM.selM140.Cancel;
      raise Exception.Create(C018.MessaggioOperazione);
    end;
    //Alberto 08/02/2012: registro i dati originali del periodo e della data
    C018.Id:=LId;
    C018.SetDatoAutorizzatore('DATADA',W032DM.selM140.FieldByName('DATADA').AsString,0);
    C018.SetDatoAutorizzatore('DATAA',W032DM.selM140.FieldByName('DATAA').AsString,0);
    C018.SetDatoAutorizzatore('ORADA',W032DM.selM140.FieldByName('ORADA').AsString,0);
    C018.SetDatoAutorizzatore('ORAA',W032DM.selM140.FieldByName('ORAA').AsString,0);
    LF2:=C018.FaseCorrente;
    if LF2 > LF1 then
    begin
      RegistraMsg.InserisciMessaggio('I',Format('ID = %d; actModRichiesta.GestioneFasi;',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      GestioneFasi(LF1,LF2);
    end;

    //Alberto 08/02/2012: registro i dati originali del periodo e della data se richiesta ancora da autorizzare
    C018.Id:=LId;
    C018.SetDatoAutorizzatore('DATADA',W032DM.selM140.FieldByName('DATADA').AsString,0);
    C018.SetDatoAutorizzatore('DATAA',W032DM.selM140.FieldByName('DATAA').AsString,0);
    C018.SetDatoAutorizzatore('ORADA',W032DM.selM140.FieldByName('ORADA').AsString,0);
    C018.SetDatoAutorizzatore('ORAA',W032DM.selM140.FieldByName('ORAA').AsString,0);
  end
  else if R180Between(W032DM.selM140.FieldByName('TIPO_RICHIESTA').AsString,M140TR_0,M140TR_3) then
  begin
    W032DM.selM140.Edit;
    W032DM.selM140.FieldByName('DATADA').AsDateTime:=FRichiesta.DataDa;
    W032DM.selM140.FieldByName('DATAA').AsDateTime:=FRichiesta.DataA;
    W032DM.selM140.FieldByName('ORADA').AsString:=FRichiesta.OraDa;
    W032DM.selM140.FieldByName('ORAA').AsString:=FRichiesta.OraA;
    W032DM.selM140.FieldByName('CAPITOLO_TRASFERTA').AsString:=FRichiesta.CapitoloTrasferta;
    W032DM.selM140.Post;
  end;

  // parte 2. gestione tabelle figlie
  try
    // 2a. dati modificabili in fase iniziale (M140FASE_INIZIALE = -1)
    if LFaseCorrente < 0 then
    begin
      // 2a.1 mezzi di trasporto: tabella M170
      W032DM.selM170.Refresh; // AOSTA_REGIONE - refresh per via della gestione del filtro tipi missione
      if W032DM.selM170.RecordCount > 0 then
      begin
        W032DM.selM170.Last;
        while not W032DM.selM170.Bof do
          W032DM.selM170.Delete;
      end;
      for i:=0 to grdMezzi.RowCount - 1 do
      begin
        if grdMezzi.Cell[i,0].Control is TmeIWGrid then
        begin
          IWG:=(grdMezzi.Cell[i,0].Control as TmeIWGrid);

          // checkbox di selezione del mezzo di trasporto
          IWChk:=(IWG.Cell[0,0].Control as TmeIWCheckBox);
          if IWChk.Checked then
          begin
            LDatiMezzo:=(IWChk.medpTag as TDatiMezzo);
            W032DM.selM170.Append;
            W032DM.selM170.FieldByName('ID').AsInteger:=LId;
            W032DM.selM170.FieldByName('CODICE').AsString:=IWChk.FriendlyName;
            // verifica dati aggiuntivi legati al mezzo di trasporto
            // (targa o motivazione + corresponsione spese)
            for j:=1 to IWG.ColumnCount - 1 do
            begin
              IWEdt:=(IWG.Cell[0,j].Control as TmeIWEdit);
              LCampo:=IfThen((IWEdt.medpTag as TDatiMezzo).FlagTarga = 'S','TARGA','MOTIVAZIONE');
              if IWEdt <> nil then
                // valore targa / motivazione
                W032DM.selM170.FieldByName(LCampo).AsString:=IWEdt.Text;
            end;
            // gestione radiogroup spese viaggio (su riga successiva)
            if (LDatiMezzo.FlagMezzoProprio = 'S') and
               (W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'N') then
            begin
              //IWRgp:=(grdMezzi.Cell[i + 1,0].Control as TmeTIWAdvRadioGroup);
              IWRgp:=(Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup);
              W032DM.selM170.FieldByName('CORRESPONSIONE_SPESE').AsString:=IfThen(IWRgp.ItemIndex = 0,'S','N');
            end;
            W032DM.selM170.Post;
          end;
        end;
      end;

      // 2a.2 dati personalizzati: tabella M175
      // refresh e cancellazione dati
      if not W032DM.selM175.Active then
      begin
        W032DM.selM175.SetVariable('ID',LId);
        W032DM.selM175.Open;
      end;
      if W032DM.selM175.RecordCount > 0 then
      begin
        W032DM.selM175.Last;
        while not W032DM.selM175.Bof do
          W032DM.selM175.Delete;
      end;
      // inserimento dati
      if FEsistonoDatiPersonalizzati then
      begin
        for LCodice in FRichiesta.DatiPers.Keys do
        begin
          LValore:=FRichiesta.DatiPers[LCodice].ValoreStr;
          if LValore <> '' then
          begin
            W032DM.selM175.Append;
            W032DM.selM175.FieldByName('ID').AsInteger:=LId;
            W032DM.selM175.FieldByName('CODICE').AsString:=LCodice;
            W032DM.selM175.FieldByName('VALORE').AsString:=LValore;
            W032DM.selM175.Post;
          end;
        end;
      end;

      // motivazioni trasferta estera
      if W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString = 'E' then
      begin
        for i:=0 to cgpMotivEstero.Items.Count - 1 do
        begin
          if cgpMotivEstero.IsChecked[i] then
          begin
            W032DM.selM175.Append;
            W032DM.selM175.FieldByName('ID').AsInteger:=LId;
            W032DM.selM175.FieldByName('CODICE').AsString:=cgpMotivEstero.Values[i];
            W032DM.selM175.Post;
          end;
        end;
        for i:=0 to cgpIpotesiEstero.Items.Count - 1 do
        begin
          if cgpIpotesiEstero.IsChecked[i] then
          begin
            W032DM.selM175.Append;
            W032DM.selM175.FieldByName('ID').AsInteger:=LId;
            W032DM.selM175.FieldByName('CODICE').AsString:=cgpIpotesiEstero.Values[i];
            W032DM.selM175.Post;
          end;
        end;
      end;
    end;

    // 2b. dati degli anticipi
    if FGestAnticipi then
    begin
      // aggiorna sulla richiesta i dati legati agli anticipi
      if tabMissioni.Tabs[rgAnticipi].Enabled then
      begin
        W032DM.selM140.Edit;
        if rgpAccredito.ItemIndex = 0 then
        begin
          W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString:=W032_TIPO_ACCREDITO_CC;
          W032DM.selM140.FieldByName('DELEGATO').AsString:='';
        end
        else if rgpAccredito.ItemIndex = 1 then
        begin
          W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString:=W032_TIPO_ACCREDITO_AB;
          if chkDelegato.Checked then
            W032DM.selM140.FieldByName('DELEGATO').AsString:=FRichiesta.Delegato;
        end;
        W032DM.selM140.Post;
      end;
    end;

    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
    // imposta il valore di ID_RIMBORSO sul dataset riferito a M150
    // in modo da attribuire valori da 0 in su
    if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
    begin
      //*** ...
    end;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

    //Invio mail al resposabile, con i dati delle tabelle figlie già registrati
    C018.PosponiInvioMail:=False;
    C018.VerificaRichiestaEsistente('V');

    // applica le modifiche su db
    SessioneOracle.ApplyUpdates([W032DM.selM150,W032DM.selM160,W032DM.selM143,W032DM.selM141],True);

    // ridetermina i tipi registrazione disponibili in base a M011F_FILTROITER
    // e verifica la compatibilità del tipo registrazione già impostato
    // se questo non è compatibile fornisce un avviso al cliente
    if not RicalcoloTipoMissione(True,LErrRicalcoloTipoMissione) then
      raise Exception.Create(LErrRicalcoloTipoMissione);

    SessioneOracle.Commit;

    // mostra eventuale messaggio di errore nel ricalcolo del tipo missione
    if LErrRicalcoloTipoMissione <> '' then
      GGetWebApplicationThreadVar.ShowMessage(LErrRicalcoloTipoMissione);
  except
    on E: Exception do
    begin
      SessioneOracle.Commit;
      MsgBox.MessageBox('Errore durante la modifica della richiesta:'#13#10 + E.Message +
                        IfThen(E.ClassName <> 'Exception',#13#10'Tipo: ' + E.ClassName),
                        ERRORE,'Errore modifica');
      Exit;
    end;
  end;

  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
  // è necessario riaprire il dataset delle richieste per ricalcolare il percorso
  W032DM.selM140.Close;
  W032DM.selM140.Open;
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

  // rilegge i dati
  grdRichieste.medpCaricaCDS;

  // posizionamento su riga appena modificata
  DBGridColumnClick(nil,LId.ToString);
end;

procedure TW032FRichiestaMissioni.actCancRichiesta(const FN: String);
// cancellazione richiesta missione
begin
  // elimina il record di testata della richiesta
  C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;
  C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
  C018.EliminaIter;

  // elimina la missione
  RegistraMsg.InserisciMessaggio('I',Format('ID = %d; actCancRichiesta.delM040',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W032DM.delM040.SetVariable('ANNULLAMENTO','N');
  W032DM.delM040.SetVariable('ID',C018.Id);
  W032DM.delM040.Execute;

  SessioneOracle.Commit;

  VisualizzaDipendenteCorrente;
end;

//#########################//
//### GESTIONE ANTICIPI ###//
//#########################//

procedure TW032FRichiestaMissioni.DBGridColumnClickAnt(ASender:TObject; const AValue:string);
var
  TmpRecNo: Integer;
begin
  // in caso di UpdatesPending, AValue è numerico ed è = al RecNo del dataset
  if TryStrToInt(AValue,TmpRecNo) then
  begin
    cdsM160.RecNo:=TmpRecNo + IfThen(grdAnticipi.medpRigaInserimento,1); // riga inserimento
    W032DM.selM160.SearchRecord('CODICE',cdsM160.FieldByName('CODICE').AsString,[srFromBeginning]);
  end
  else
  begin
    if cdsM160.Locate('DBG_ROWID',AValue,[]) then
      W032DM.selM160.SearchRecord('ROWID',cdsM160.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);
  end;
end;

procedure TW032FRichiestaMissioni.TrasformaComponentiAnt(const FN:String);
var
  i,c:Integer;
  LTipoQuantita: String;
  V: double;
  LIWCmb: TmeIWComboBox;
  LIWLbl: TmeIWLabel;
  LIWGrd: TmeIWGrid;
begin
  i:=grdAnticipi.medpRigaDiCompGriglia(FN);

  // gestione icone comandi
  LIWGrd:=(grdAnticipi.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
  LIWGrd.Cell[0,0].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'invisibile','align_left');
  if i = 0 then
  begin
    // riga di inserimento
    LIWGrd.Cell[0,1].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'align_left','invisibile');
    LIWGrd.Cell[0,2].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'align_right','invisibile');
    if grdAnticipi.medpStato <> msBrowse then
      FImgConfermaAnt:=(LIWGrd.Cell[0,2].Control as TmeIWImageFile);
  end
  else
  begin
    // dettaglio
    LIWGrd.Cell[0,1].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'invisibile','align_right');
    LIWGrd.Cell[0,2].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'align_left','invisibile');
    LIWGrd.Cell[0,3].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'align_right','invisibile');
    if grdAnticipi.medpStato <> msBrowse then
      FImgConfermaAnt:=(LIWGrd.Cell[0,3].Control as TmeIWImageFile);
  end;

  LIWCmb:=nil;
  if grdAnticipi.medpStato <> msBrowse then
  begin
    // codice di anticipo richiesto
    if grdAnticipi.medpStato = msInsert then
    begin
      grdAnticipi.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'40','','','','S');
      c:=grdAnticipi.medpIndexColonna('C_DESCRIZIONE');
      grdAnticipi.medpCreaComponenteGenerico(i,c,grdAnticipi.Componenti);

      LIWCmb:=(grdAnticipi.medpCompCella(i,c,0) as TmeIWComboBox);
      LIWCmb.FriendlyName:=FN;
      LIWCmb.ItemsHaveValues:=True;
      //+++.ini
      if WR000DM.Responsabile then
        LIWCmb.Items.Assign(FListaAnticipiAbilFase)
      else
      //+++.fine
        LIWCmb.Items.Assign(FListaAnticipi);
      LIWCmb.Items.Insert(0,'=');
      if grdAnticipi.medpStato = msInsert then
        LIWCmb.ItemIndex:=0
      else if grdAnticipi.medpStato = msEdit then
        LIWCmb.ItemIndex:=LIWCmb.Items.IndexOfName(grdAnticipi.medpValoreColonna(i,'C_DESCRIZIONE'));
      LIWCmb.OnChange:=cmbVoceAnticipoChange;
    end;

    // percentuale
    grdAnticipi.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'3','','','','S');
    c:=grdAnticipi.medpIndexColonna('C_PERC_ANTICIPO');
    grdAnticipi.medpCreaComponenteGenerico(i,c,grdAnticipi.Componenti);
    LIWLbl:=(grdAnticipi.medpCompGriglia[i].CompColonne[c] as TmeIWLabel);
    LIWLbl.Caption:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',grdAnticipi.medpValoreColonna(i,'CODICE'),'PERC_ANTICIPO'));
    if LIWLbl.Caption <> '' then
      LIWLbl.Caption:=LIWLbl.Caption + '%';

    // quantità spettante
    grdAnticipi.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'10','','','','R');
    c:=grdAnticipi.medpIndexColonna('C_QTA_SPETTANTE');
    grdAnticipi.medpCreaComponenteGenerico(i,c,grdAnticipi.Componenti);
    LIWLbl:=(grdAnticipi.medpCompGriglia[i].CompColonne[c] as TmeIWLabel);
    LIWLbl.Caption:=W032DM.GetQuantitaSpettante(grdAnticipi.medpValoreColonna(i,'C_TIPO_QUANTITA'),StrToFloatDef(grdAnticipi.medpValoreColonna(i,'QUANTITA'),0),StrToFloatDef(grdAnticipi.medpValoreColonna(i,'C_PERC_ANTICIPO'),100));

    // note fisse
    grdAnticipi.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'20','','','','S');
    c:=grdAnticipi.medpIndexColonna('C_NOTE_FISSE');
    grdAnticipi.medpCreaComponenteGenerico(i,c,grdAnticipi.Componenti);
    LIWLbl:=(grdAnticipi.medpCompGriglia[i].CompColonne[c] as TmeIWLabel);
    LIWLbl.Caption:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',grdAnticipi.medpValoreColonna(i,'CODICE'),'NOTE_FISSE'));

    // quantità
    grdAnticipi.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'','','','','S');
    grdAnticipi.medpPreparaComponenteGenerico('C',0,1,DBG_CHK,'','','','','S');
    grdAnticipi.medpPreparaComponenteGenerico('C',0,2,DBG_EDT,'5','','','','S');
    grdAnticipi.medpPreparaComponenteGenerico('C',0,3,DBG_EDT,'7','','','','D');
    c:=grdAnticipi.medpIndexColonna('QUANTITA');
    grdAnticipi.medpCreaComponenteGenerico(i,c,grdAnticipi.Componenti);
    LTipoQuantita:=grdAnticipi.medpValoreColonna(i,'C_TIPO_QUANTITA');
    LIWGrd:=(grdAnticipi.medpCompGriglia[i].CompColonne[c] as TmeIWGrid);
    LIWGrd.Cell[0,0].Css:=IfThen((LTipoQuantita <> '') and (LTipoQuantita <> W032_TQ_FLAG),'','invisibile');
    LIWGrd.Cell[0,1].Css:=IfThen(LTipoQuantita = W032_TQ_FLAG,'','invisibile');
    LIWGrd.Cell[0,2].Css:=IfThen(LTipoQuantita = W032_TQ_QUANTITA,'','invisibile');
    LIWGrd.Cell[0,3].Css:=IfThen(LTipoQuantita = W032_TQ_IMPORTO,'','invisibile');
    (grdAnticipi.medpCompCella(i,c,3) as TmeIWEdit).OnAsyncChange:=edtQuantitaAnticipoAsyncChange;
    if grdAnticipi.medpStato = msInsert then
    begin
      cmbVoceAnticipoChange(LIWCmb);
    end
    else if grdAnticipi.medpStato = msEdit then
    begin
      V:=StrToFloat(grdAnticipi.medpValoreColonna(i,'QUANTITA'));
      if LTipoQuantita = W032_TQ_FLAG then
      begin
        // F = flag
        (grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption:='';
        (grdAnticipi.medpCompCella(i,c,1) as TmeIWCheckBox).Checked:=(V = 1);
      end
      else if LTipoQuantita = W032_TQ_QUANTITA then
      begin
        // Q = quantità
        (grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption:='n.';
        (grdAnticipi.medpCompCella(i,c,2) as TmeIWEdit).Text:=IntToStr(Trunc(V));
      end
      else if LTipoQuantita = W032_TQ_IMPORTO then
      begin
        // I = importo
        (grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption:='€';
        (grdAnticipi.medpCompCella(i,c,3) as TmeIWEdit).Text:=FloatToStr(V);
      end;
    end;

    // note
    grdAnticipi.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'30','','','','S');
    c:=grdAnticipi.medpIndexColonna('NOTE');
    grdAnticipi.medpCreaComponenteGenerico(i,c,grdAnticipi.Componenti);
  end
  else
  begin
    FreeAndNil(grdAnticipi.medpCompGriglia[i].CompColonne[grdAnticipi.medpIndexColonna('C_DESCRIZIONE')]);
    FreeAndNil(grdAnticipi.medpCompGriglia[i].CompColonne[grdAnticipi.medpIndexColonna('QUANTITA')]);
    FreeAndNil(grdAnticipi.medpCompGriglia[i].CompColonne[grdAnticipi.medpIndexColonna('NOTE')]);
    FreeAndNil(grdAnticipi.medpCompGriglia[i].CompColonne[grdAnticipi.medpIndexColonna('C_PERC_ANTICIPO')]);
    FreeAndNil(grdAnticipi.medpCompGriglia[i].CompColonne[grdAnticipi.medpIndexColonna('C_QTA_SPETTANTE')]);
    FreeAndNil(grdAnticipi.medpCompGriglia[i].CompColonne[grdAnticipi.medpIndexColonna('C_NOTE_FISSE')]);
  end;
end;

procedure TW032FRichiestaMissioni.grdAnticipiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
  LSomma: Currency;
  LSommaSpettante: Currency;
  LIWGrd: TmeIWGrid;
  LCodice: String;
  LFaseLiv: Integer;
  LFasiAbil: string;
begin
  if (not SolaLettura) then //+++and
     //+++(not WR000DM.Responsabile) then
  begin
    if grdAnticipi.medpRigaInserimento then
    begin
      (grdAnticipi.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInsAnticipoClick;
      (grdAnticipi.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaAnticipoClick;
      (grdAnticipi.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgApplicaAnticipoClick;
      LIWGrd:=(grdAnticipi.medpCompGriglia[0].CompColonne[0] as TmeIWGrid);
      if (WR000DM.Responsabile) and (FListaAnticipiAbilFase.Count = 0) then
        LIWGrd.Cell[0,0].Css:='invisibile';
      LIWGrd.Cell[0,1].Css:='invisibile';
      LIWGrd.Cell[0,2].Css:='invisibile';
    end;
    for i:=IfThen(grdAnticipi.medpRigaInserimento,1,0) to High(grdAnticipi.medpCompGriglia) do
    begin
      if (grdAnticipi.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        (grdAnticipi.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCanAnticipoClick;
        (grdAnticipi.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModAnticipoClick;
        (grdAnticipi.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaAnticipoClick;
        (grdAnticipi.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgApplicaAnticipoClick;
        LIWGrd:=(grdAnticipi.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
        //+++.ini
        if WR000DM.Responsabile then
        begin
          LCodice:=grdAnticipi.medpValoreColonna(i,'CODICE');
          LFaseLiv:=C018.FaseLivello[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger];
          LFasiAbil:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',LCodice,'FASI_COMPETENZA'));
          if not R180In(LFaseLiv.ToString,LFasiAbil.Split([','])) then
          begin
            LIWGrd.Cell[0,0].Css:='invisibile';
            LIWGrd.Cell[0,1].Css:='invisibile';
          end;
        end;
        //+++.fine
        LIWGrd.Cell[0,2].Css:='invisibile';
        LIWGrd.Cell[0,3].Css:='invisibile';
      end;
    end;
  end;

  // calcola totale anticipi richiesti (espressi in valuta)
  if grdAnticipi.medpStato = msBrowse then
  begin
    // somma solo le quantità espresse in importo (flag TIPO_QUANTITA = W032_TQ_IMPORTO)
    LSomma:=0;
    LSommaSpettante:=0;
    W032DM.selM160.First;
    while not W032DM.selM160.Eof do
    begin
      if W032DM.selM160.FieldByName('C_TIPO_QUANTITA').AsString = W032_TQ_IMPORTO then
      begin
        LSomma:=LSomma + W032DM.selM160.FieldByName('QUANTITA').AsCurrency;
        LSommaSpettante:=LSommaSpettante + StrToFloatDef(StringReplace(W032DM.selM160.FieldByName('C_QTA_SPETTANTE').AsString,'€ ','',[rfReplaceAll]),0);
      end;
      W032DM.selM160.Next;
    end;
    lblTotAnticipi.Caption:='Totale anticipi: € ' + CurrToStr(LSomma);
    lblTotSpettante.Caption:='Totale spettante: € ' + CurrToStr(LSommaSpettante);
  end;
end;

procedure TW032FRichiestaMissioni.grdAnticipiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  T,Campo,Prefisso: String;
begin
  if not grdAnticipi.medpRenderCell(ACell,ARow,AColumn,True,False,False) then
    Exit;

  if ARow > 0 then
  begin
    NumColonna:=grdAnticipi.medpNumColonna(AColumn);
    Campo:=grdAnticipi.medpColonna(NumColonna).DataField;
    if (Campo = 'QUANTITA') or
       (Campo = 'C_PERC_ANTICIPO') then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end;
    if (Campo = 'C_QTA_SPETTANTE') then
    begin
      ACell.Css:=ACell.Css + ' align_right';
    end;

    // assegnazione componenti alle celle
    if (ARow <= High(grdAnticipi.medpCompGriglia) + 1) and (grdAnticipi.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
    begin
      ACell.Control:=grdAnticipi.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
      ACell.Text:='';
    end;

    if (ARow <= High(grdAnticipi.medpCompGriglia) + 1) and (ACell.Control = nil) then
    begin
      if Campo = 'QUANTITA' then
      begin
        // quantità
        Prefisso:='';
        T:=grdAnticipi.medpValoreColonna(ARow - 1,'C_TIPO_QUANTITA');
        if T = W032_TQ_FLAG then
        begin
          // flag visualizzato come Sì/No
          ACell.Text:=IfThen(ACell.Text = '1','Sì','No');
        end
        else
        begin
          // quantità intera oppure importo
          if T = W032_TQ_QUANTITA then
            Prefisso:='n. '
          else if T = W032_TQ_IMPORTO then
            Prefisso:='€ ';
          ACell.Text:=Prefisso + ACell.Text;
        end;
      end
      else if Campo = 'C_PERC_ANTICIPO' then
      begin
        // % spettante di anticipo
        // se dato vuoto prova a fare lookup
        if ACell.Text = '' then
          ACell.Text:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',grdAnticipi.medpValoreColonna(ARow - 1,'CODICE'),'PERC_ANTICIPO'));
        if ACell.Text <> '' then
          ACell.Text:=ACell.Text + '%';
      end
      else if Campo = 'C_QTA_SPETTANTE' then
      begin
        // quantità spettante
        if ACell.Text = '' then
          ACell.Text:=W032DM.GetQuantitaSpettante(grdAnticipi.medpValoreColonna(ARow - 1,'C_TIPO_QUANTITA'),StrToFloatDef(grdAnticipi.medpValoreColonna(ARow - 1,'QUANTITA'),0),StrToFloatDef(grdAnticipi.medpValoreColonna(ARow - 1,'C_PERC_ANTICIPO'),100));
      end
      else if Campo = 'C_NOTE_FISSE' then
      begin
        // note fisse
        // se dato vuoto prova a fare lookup
        if ACell.Text = '' then
          ACell.Text:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',grdAnticipi.medpValoreColonna(ARow - 1,'CODICE'),'NOTE_FISSE'));
      end;
    end;
  end;
end;

function TW032FRichiestaMissioni.ControllaConfermaAnticipi(const FN: string): TResCtrl;
var
  i: Integer;
  LFaseCorr: Integer;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  if not FGestAnticipi then
  begin
    Result.Ok:=True;
    exit;
  end;

  FRichiesta.Delegato:='';
  if (tabMissioni.Tabs[rgAnticipi].Enabled) and (chkDelegato.Enabled) then
  begin
    // controllo delegato
    if chkDelegato.Checked then
    begin
      if edtCercaDelegato.Visible then
      begin
        MsgBox.MessageBox('E'' necessario cercare il delegato utilizzando l''apposito pulsante!',INFORMA);
        ActiveControl:=edtCercaDelegato;
        Exit;
      end;
      if (cmbDelegato.Items.Count > 1) and
         (cmbDelegato.ItemIndex = 0) then
      begin
        MsgBox.MessageBox('Selezionare il nominativo del delegato dalla lista!',INFORMA);
        ActiveControl:=cmbDelegato;
        Exit;
      end;
      FRichiesta.Delegato:=Trim(Copy(cmbDelegato.Text,1,8))
    end;
  end;

  // se la tabella degli anticipi è in modifica effettua controlli e conferma
  if grdAnticipi.medpStato <> msBrowse then
  begin
    if Assigned(FImgConfermaAnt) then
    begin
      FImgConfermaAnt.OnClick(FImgConfermaAnt);

      // se lo stato della grid non è msBrowse significa che ci sono stati errori in fase di conferma
      if grdAnticipi.medpStato <> msBrowse then
        Exit;
    end
    else
    begin
      Result.Messaggio:='La pagina degli Anticipi è in modifica.'#13#10'Chiudere le modifiche prima di confermare l''intera missione.';
      Exit;
    end;
  end
  else
  begin
    //se anticipi non ancora confermati ed è presente l'anticipo pasto, verifica il limite in base al periodo della trasferta
    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    LFaseCorr:=StrToIntDef(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE'),-1);
    if (LFaseCorr < M140FASE_CASSA) and (W032DM.selM160.SearchRecord('CODICE',FCodAnticipoPastoM020,[srFromBeginning])) then
    begin
      // bugfix: se il record è appena stato inserito (Rowid è vuoto) il controllo è già
      //         stato effettuato e non è più necessario
      if W032DM.selM160.RowId <> '' then
      begin
        // effettua controlli bloccanti
        if not CtrlAnticipoOK(W032DM.selM160.Rowid) then
          Exit;

        actModAnticipo(W032DM.selM160.Rowid);
      end;
    end;
  end;

  Result.Ok:=True;
end;

function TW032FRichiestaMissioni.CtrlAnticipoOK(const FN: String): Boolean;
var
  i,c: Integer;
  LQtaInt: Integer;
  LIWC: TIWCustomControl;
  LVoce, LTipoQuantita, LTipoArr: String;
  LArr: double;
  LLimite: Currency;
begin
  Result:=False;
  FMsgAnt:='';
  i:=grdAnticipi.medpRigaDiCompGriglia(FN);

  LIWC:=nil;
  if grdAnticipi.medpStato = msInsert then
  begin
    c:=grdAnticipi.medpIndexColonna('C_DESCRIZIONE');
    LIWC:=grdAnticipi.medpCompCella(i,c,0);
    FRecordAnticipo.Codice:=(LIWC as TmeIWComboBox).Items.ValueFromIndex[(LIWC as TmeIWComboBox).ItemIndex];
    LTipoQuantita:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',FRecordAnticipo.Codice,'TIPO_QUANTITA'));
    LVoce:=(LIWC as TmeIWComboBox).Items.Names[(LIWC as TmeIWComboBox).ItemIndex];
  end
  else
  begin
    FRecordAnticipo.Codice:=grdAnticipi.medpValoreColonna(i,'CODICE');
    LTipoQuantita:=grdAnticipi.medpValoreColonna(i,'C_TIPO_QUANTITA');
    LVoce:=grdAnticipi.medpValoreColonna(i,'C_DESCRIZIONE');
  end;

  if FRecordAnticipo.Codice = '' then
  begin
    MsgBox.MessageBox('Non è stata selezionata nessuna voce di anticipo.',INFORMA);
    exit;
  end;

  // quantità
  if grdAnticipi.medpStato <> msBrowse then
  begin
    c:=grdAnticipi.medpIndexColonna('QUANTITA');
    if LTipoQuantita = W032_TQ_FLAG then
    begin
      // flag: 0 = deselezionato, 1 = selezionato
      LIWC:=grdAnticipi.medpCompCella(i,c,1);
      FRecordAnticipo.Quantita:=IfThen((LIWC as TmeIWCheckBox).Checked,1,0)
    end
    else if LTipoQuantita = W032_TQ_QUANTITA then
    begin
      // quantità espressa in numero intero
      LIWC:=grdAnticipi.medpCompCella(i,c,2);
      if not TryStrToInt((LIWC as TmeIWEdit).Text,LQtaInt) then
      begin
        MsgBox.MessageBox(Format('La quantità indicata per la voce di anticipo "%s"'#13#10'non è valida!'#13#10'Indicare un valore intero positivo.',[LVoce]),INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
      FRecordAnticipo.Quantita:=LQtaInt;
    end
    else if LTipoQuantita = W032_TQ_IMPORTO then
    begin
      // quantità espressa in importo
      LIWC:=grdAnticipi.medpCompCella(i,c,3);
      if not TryStrToCurr((LIWC as TmeIWEdit).Text,FRecordAnticipo.Quantita) then
      begin
        MsgBox.MessageBox(Format('La quantità indicata per la voce di anticipo'#13#10'"%s" non è valida!',[LVoce]),INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
    end;
  end
  else
    FRecordAnticipo.Quantita:=StrToFloat(grdAnticipi.medpValoreColonna(i,'QUANTITA'));

  // se si tratta di anticipo pasto, limita il numero di pasti secondo le impostazioni
  if FRecordAnticipo.Codice = FCodAnticipoPastoM020 then
  begin
    W032DM.M013F_CALC_RIMB_PASTO.SetVariable('TIPORISULTATO',IfThen(LTipoQuantita = W032_TQ_IMPORTO,'I','N'));
    W032DM.M013F_CALC_RIMB_PASTO.SetVariable('CODICE',FRegolaM010.Codice);
    W032DM.M013F_CALC_RIMB_PASTO.SetVariable('TIPOREGISTRAZIONE',FRegolaM010.TipoRegistrazione);
    W032DM.M013F_CALC_RIMB_PASTO.SetVariable('DATADA',FRichiesta.DataDa);
    W032DM.M013F_CALC_RIMB_PASTO.SetVariable('DATAA',FRichiesta.DataA);
    W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORADA',FRichiesta.OraDa);
    W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORAA',FRichiesta.OraA);
    W032DM.M013F_CALC_RIMB_PASTO.Execute;
    LLimite:=StrToCurr(VarToStr(W032DM.M013F_CALC_RIMB_PASTO.GetVariable('RESULT')));
    if LLimite > -1 then
    begin
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
      // arrotondamento limite
      if LLimite > 0 then
      begin
        LArr:=1;
        LTipoArr:='P';
        W032DM.P050.Close;
        W032DM.P050.SetVariable('CODICE',FRegolaM010.ArrotTariffaDopoRiduzione);
        W032DM.P050.SetVariable('DECORRENZA',FRichiesta.DataA);
        W032DM.P050.Open;
        W032DM.P050.First;
        if not W032DM.P050.Eof then
        begin
          LArr:=W032DM.P050.FieldByName('VALORE').AsFloat;
          LTipoArr:=W032DM.P050.FieldByName('TIPO').AsString;
        end;
        LLimite:=R180Arrotonda(LLimite,LArr,LTipoArr);
      end;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

      // verifica sforamento limite
      if FRecordAnticipo.Quantita > LLimite then
      begin
        FRecordAnticipo.Quantita:=LLimite;
        if LTipoQuantita = W032_TQ_IMPORTO then
          FMsgAnt:='La quantità richiesta per l''anticipo pasto è stata limitata a ' + CurrToStr(LLimite)
        else
          FMsgAnt:='Il numero di pasti richiesti per l''anticipo è stato limitato a ' + IntToStr(Trunc(LLimite));
        FMsgAnt:=FMsgAnt + ', in base alle regole definite per la missione';
      end;
    end;
  end;

  if FRecordAnticipo.Quantita = 0 then
  begin
    if LTipoQuantita = W032_TQ_FLAG then
      MsgBox.MessageBox('Se si desidera includere la voce di anticipo' + CRLF +
                        '"' + LVoce + '"' + CRLF +
                        'è necessario spuntare la casella di selezione.',INFORMA)
    else
      MsgBox.MessageBox('La quantità relativa alla voce di anticipo' + CRLF +
                        '"' + LVoce + '"' + CRLF +
                        'deve essere maggiore di 0.',INFORMA);
    if Assigned(LIWC) then
      ActiveControl:=LIWC;
    Exit;
  end;

  // note
  LIWC:=grdAnticipi.medpCompCella(i,'NOTE',0);
  FRecordAnticipo.Note:=Trim((LIWC as TmeIWEdit).Text);

  // chiave duplicata
  if (grdAnticipi.medpStato = msInsert) and
     (W032DM.selM160.SearchRecord('CODICE',FRecordAnticipo.Codice,[srFromBeginning])) then
  begin
    MsgBox.MessageBox(Format('La voce di anticipo'#13#10'"%s"'#13#10'è già presente nella tabella!',[LVoce]),INFORMA);
    Exit;
  end;

  Result:=True;
end;

procedure TW032FRichiestaMissioni.imgInsAnticipoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickAnt(Sender,FN);
  grdAnticipi.medpStato:=msInsert;
  grdAnticipi.medpBrowse:=False;
  TrasformaComponentiAnt(FN);
end;

procedure TW032FRichiestaMissioni.imgModAnticipoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickAnt(Sender,FN);
  grdAnticipi.medpStato:=msEdit;
  grdAnticipi.medpBrowse:=False;
  TrasformaComponentiAnt(FN);
end;

procedure TW032FRichiestaMissioni.imgCanAnticipoClick(Sender: TObject);
var
  FN: String;
  LRecNo: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if W032DM.selM160.SearchRecord('ROWID',FN,[srFromBeginning]) then
    W032DM.selM160.Delete
  else if TryStrToInt(FN,LRecNo) then
  begin
    // caso di inserimenti con cached updates
    // 1 <= LRecNo <= RecordCount
    W032DM.selM160.First;
    W032DM.selM160.MoveBy(LRecNo - 1);
    W032DM.selM160.Delete;
  end;

  grdAnticipi.medpCaricaCDS;
end;

procedure TW032FRichiestaMissioni.imgAnnullaAnticipoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdAnticipi.medpStato:=msBrowse;
  TrasformaComponentiAnt(FN);
  grdAnticipi.medpBrowse:=True;
end;

procedure TW032FRichiestaMissioni.imgApplicaAnticipoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  FImgApplica:=nil;

  // effettua controlli e aggiorna il periodo della missione
  // per effettuare il controllo anticipi in modo corretto
  if not ControlliOK(W032DM.selM140.RowId) then
    Exit;

  W032DM.selM140.Edit;
  W032DM.selM140.FieldByName('DATADA').AsDateTime:=FRichiesta.DataDa;
  W032DM.selM140.FieldByName('DATAA').AsDateTime:=FRichiesta.DataA;
  W032DM.selM140.FieldByName('ORADA').AsString:=FRichiesta.OraDa;
  W032DM.selM140.FieldByName('ORAA').AsString:=FRichiesta.OraA;
  W032DM.selM140.Post;

  // effettua controlli bloccanti
  if not CtrlAnticipoOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if grdAnticipi.medpStato = msInsert then
    actInsAnticipo
  else
    actModAnticipo(FN);
end;

procedure TW032FRichiestaMissioni.actInsAnticipo;
begin
  // aggiornamento dataset (cached updates)
  W032DM.selM160.Append;
  W032DM.selM160.FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
  W032DM.selM160.FieldByName('CODICE').AsString:=FRecordAnticipo.Codice;
  W032DM.selM160.FieldByName('QUANTITA').AsFloat:=FRecordAnticipo.Quantita;
  W032DM.selM160.FieldByName('NOTE').AsString:=FRecordAnticipo.Note;
  try
    W032DM.selM160.Post;
    grdAnticipi.medpCaricaCDS;
    if FMsgAnt <> '' then
      Notifica('Informazione anticipo',FMsgAnt,'',True,False,15000);
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(Format('Errore durante l''inserimento della richiesta di anticipo:'#13#10'%s (%s)',[E.Message,E.ClassName]),ESCLAMA);
      Exit;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.actModAnticipo(const FN: String);
begin
  // aggiornamento dataset (cached updates)
  W032DM.selM160.Edit;
  W032DM.selM160.FieldByName('QUANTITA').AsFloat:=FRecordAnticipo.Quantita;
  W032DM.selM160.FieldByName('NOTE').AsString:=FRecordAnticipo.Note;
  try
    W032DM.selM160.Post;
    grdAnticipi.medpCaricaCDS;
    if FMsgAnt <> '' then
      Notifica('Informazione anticipo',FMsgAnt,'',True,False,15000);
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(Format('Errore durante la modifica della richiesta di anticipo:'#13#10'%s (%s)',[E.Message,E.ClassName]),ESCLAMA);
      Exit;
    end;
  end;
end;

//######################################//
//### GESTIONE DETTAGLIO GIORNALIERO ###//
//######################################//

procedure TW032FRichiestaMissioni.DBGridColumnClickDettaglioGG(ASender:TObject; const AValue:string);
var
  LRecNo: Integer;
begin
  // in caso di UpdatesPending, AValue è numerico ed è il recno del dataset
  if TryStrToInt(AValue,LRecNo) then
  begin
    cdsM143.RecNo:=LRecNo + IfThen(grdDettaglioGG.medpRigaInserimento,1);
    W032DM.selM143.SearchRecord('DATA;DALLE',VarArrayOf([cdsM143.FieldByName('DATA').AsDateTime,cdsM143.FieldByName('DALLE').AsString]),[srFromBeginning]);
  end
  else
  begin
    if cdsM143.Locate('DBG_ROWID',AValue,[]) then
      W032DM.selM143.SearchRecord('ROWID',cdsM143.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);
  end;
end;

procedure TW032FRichiestaMissioni.TrasformaComponentiDettaglioGG(const FN:String);
var
  i,c: Integer;
  LIWEdtData: TmeIWEdit;
  LIWEdtDalle: TmeIWEdit;
  LIWEdtAlle: TmeIWEdit;
  LIWRgpTipo: TmeTIWAdvRadioGroup;
  LIWMemNote: TmeIWMemo;
  LIWGrd: TmeIWGrid;
begin
  i:=grdDettaglioGG.medpRigaDiCompGriglia(FN);

  // gestione icone comandi
  LIWGrd:=(grdDettaglioGG.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
  LIWGrd.Cell[0,0].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'invisibile','align_left');
  if i = 0 then
  begin
    // riga di inserimento
    LIWGrd.Cell[0,1].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'align_left','invisibile');
    LIWGrd.Cell[0,2].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'align_right','invisibile');
    if grdDettaglioGG.medpStato <> msBrowse then
      FImgConfermaDettGG:=(LIWGrd.Cell[0,2].Control as TmeIWImageFile);
  end
  else
  begin
    // dettaglio
    LIWGrd.Cell[0,1].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'invisibile','align_right');
    LIWGrd.Cell[0,2].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'align_left','invisibile');
    LIWGrd.Cell[0,3].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'align_right','invisibile');
    if grdDettaglioGG.medpStato <> msBrowse then
      FImgConfermaDettGG:=(LIWGrd.Cell[0,3].Control as TmeIWImageFile);
  end;

  if grdDettaglioGG.medpStato <> msBrowse then
  begin
    // tipo dettaglio
    grdDettaglioGG.medpPreparaComponenteGenerico('C',0,0,DBG_RGP,'20','Servizio attivo,Ore viaggio','Tipo','','S');
    c:=grdDettaglioGG.medpIndexColonna('TIPO');
    grdDettaglioGG.medpCreaComponenteGenerico(i,c,grdDettaglioGG.Componenti);
    LIWRgpTipo:=(grdDettaglioGG.medpCompCella(i,c,0) as TmeTIWAdvRadioGroup);
    LIWRgpTipo.Columns:=1;
    LIWRgpTipo.Layout:=glVertical;
    if grdDettaglioGG.medpStato = msInsert then
      LIWRgpTipo.ItemIndex:=0
    else
      LIWRgpTipo.ItemIndex:=IfThen(grdDettaglioGG.medpValoreColonna(i,'TIPO') = 'S',0,1);

    // data servizio
    grdDettaglioGG.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
    c:=grdDettaglioGG.medpIndexColonna('DATA');
    grdDettaglioGG.medpCreaComponenteGenerico(i,c,grdDettaglioGG.Componenti);
    LIWEdtData:=(grdDettaglioGG.medpCompCella(i,c,0) as TmeIWEdit);
    if grdDettaglioGG.medpStato = msInsert then
      LIWEdtData.Text:={DataIns}IfThen(W032DM.selM140.FieldByName('DATADA').AsDateTime = W032DM.selM140.FieldByName('DATAA').AsDateTime,W032DM.selM140.FieldByName('DATADA').AsString,'')
    else
      LIWEdtData.Text:=grdDettaglioGG.medpValoreColonna(i,'DATA');

    // dalle
    grdDettaglioGG.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
    c:=grdDettaglioGG.medpIndexColonna('DALLE');
    grdDettaglioGG.medpCreaComponenteGenerico(i,c,grdDettaglioGG.Componenti);
    LIWEdtDalle:=(grdDettaglioGG.medpCompCella(i,c,0) as TmeIWEdit);
    if grdDettaglioGG.medpStato = msInsert then
      LIWEdtDalle.Text:=''
    else
      LIWEdtDalle.Text:=grdDettaglioGG.medpValoreColonna(i,'DALLE');

    // alle
    grdDettaglioGG.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
    c:=grdDettaglioGG.medpIndexColonna('ALLE');
    grdDettaglioGG.medpCreaComponenteGenerico(i,c,grdDettaglioGG.Componenti);
    LIWEdtAlle:=(grdDettaglioGG.medpCompCella(i,c,0) as TmeIWEdit);
    if grdDettaglioGG.medpStato = msInsert then
      LIWEdtAlle.Text:=''
    else
      LIWEdtAlle.Text:=grdDettaglioGG.medpValoreColonna(i,'ALLE');

    // note
    grdDettaglioGG.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'40','','','','S');
    c:=grdDettaglioGG.medpIndexColonna('NOTE');
    grdDettaglioGG.medpCreaComponenteGenerico(i,c,grdDettaglioGG.Componenti);
    LIWMemNote:=(grdDettaglioGG.medpCompCella(i,c,0) as TmeIWMemo);
    if grdDettaglioGG.medpStato = msInsert then
      LIWMemNote.Text:=''
    else
      LIWMemNote.Text:=grdDettaglioGG.medpValoreColonna(i,'NOTE');

    // imposta focus
    if grdDettaglioGG.medpStato = msInsert then
    begin
      if LIWEdtData.Text = '' then
        ActiveControl:=LIWEdtData
      else
        ActiveControl:=LIWEdtDalle;
    end
    else if grdDettaglioGG.medpStato = msEdit then
      ActiveControl:=LIWMemNote;
  end
  else
  begin
    FreeAndNil(grdDettaglioGG.medpCompGriglia[i].CompColonne[grdDettaglioGG.medpIndexColonna('TIPO')]);
    FreeAndNil(grdDettaglioGG.medpCompGriglia[i].CompColonne[grdDettaglioGG.medpIndexColonna('DATA')]);
    FreeAndNil(grdDettaglioGG.medpCompGriglia[i].CompColonne[grdDettaglioGG.medpIndexColonna('DALLE')]);
    FreeAndNil(grdDettaglioGG.medpCompGriglia[i].CompColonne[grdDettaglioGG.medpIndexColonna('ALLE')]);
    FreeAndNil(grdDettaglioGG.medpCompGriglia[i].CompColonne[grdDettaglioGG.medpIndexColonna('NOTE')]);
  end;
end;

procedure TW032FRichiestaMissioni.grdDettaglioGGAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  LIWG: TmeIWGrid;
begin
  if (not SolaLettura) and
     (not WR000DM.Responsabile) then
  begin
    if grdDettaglioGG.medpRigaInserimento then
    begin
      (grdDettaglioGG.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInsDettaglioGGClick;
      (grdDettaglioGG.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaDettaglioGGClick;
      (grdDettaglioGG.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgApplicaDettaglioGGClick;
      LIWG:=(grdDettaglioGG.medpCompGriglia[0].CompColonne[0] as TmeIWGrid);
      LIWG.Cell[0,1].Css:='invisibile';
      LIWG.Cell[0,2].Css:='invisibile';
    end;
    for i:=IfThen(grdDettaglioGG.medpRigaInserimento,1,0) to High(grdDettaglioGG.medpCompGriglia) do
    begin
      if (grdDettaglioGG.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        (grdDettaglioGG.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCanDettaglioGGClick;
        (grdDettaglioGG.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModDettaglioGGClick;
        (grdDettaglioGG.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaDettaglioGGClick;
        (grdDettaglioGG.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgApplicaDettaglioGGClick;
        LIWG:=(grdDettaglioGG.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
        LIWG.Cell[0,2].Css:='invisibile';
        LIWG.Cell[0,3].Css:='invisibile';
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.grdDettaglioGGRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not grdDettaglioGG.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdDettaglioGG.medpNumColonna(AColumn);
  Campo:=grdDettaglioGG.medpColonna(NumColonna).DataField;

  // width delle colonne
  if ARow = 0 then
  begin
    // riga di intestazione: larghezza colonne
    if Campo = 'NOTE' then
      ACell.Css:=ACell.Css + ' width55chr';
  end
  else
  begin
    // assegnazione componenti alle celle
    if (ARow <= High(grdDettaglioGG.medpCompGriglia) + 1) and (grdDettaglioGG.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
    begin
      ACell.Control:=grdDettaglioGG.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
      ACell.Text:='';
    end;

    // stili per celle
    if (Campo = 'TIPO') or (Campo = 'DATA') or (Campo = 'DALLE') or (Campo = 'ALLE') then
      ACell.Css:=ACell.Css + ' align_center';

    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
    // decodifiche dati
    if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (ACell.Text <> '') then
    begin
      if Campo = 'TIPO' then
      begin
        ACell.Text:=IfThen(ACell.Text = 'S','Servizio attivo','Viaggio');
      end;
    end;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
  end;
end;

function TW032FRichiestaMissioni.CtrlDettaglioGGOK(const FN: String): Boolean;
var
  i: Integer;
  TempStr, Msg, TipoDesc: String;
  DalleMin,AlleMin,DalleTemp,AlleTemp,OldRecNo: Integer;
  LIWEdt: TmeIWEdit;
  LIWRgp: TmeTIWAdvRadioGroup;
  LIWMemo: TmeIWMemo;
begin
  Result:=False;

  i:=grdDettaglioGG.medpRigaDiCompGriglia(FN);

  // data di riferimento
  LIWEdt:=(grdDettaglioGG.medpCompCella(i,'DATA',0) as TmeIWEdit);
  FRecordDettaglioGG.Data:=0;
  if LIWEdt.Text <> '' then
  begin
    if not TryStrToDateTime(LIWEdt.Text,FRecordDettaglioGG.Data,TFunzioniGenerali.CreateDefaultFormatSettings) then
    begin
      MsgBox.MessageBox('La data del dettaglio non è valida!',INFORMA);
      ActiveControl:=LIWEdt;
      Exit;
    end;
    if (FRecordDettaglioGG.Data < W032DM.selM140.FieldByName('DATADA').AsDateTime) or
       (FRecordDettaglioGG.Data > W032DM.selM140.FieldByName('DATAA').AsDateTime) then
    begin
      MsgBox.MessageBox('La data deve essere compresa nel periodo della missione!',INFORMA);
      ActiveControl:=LIWEdt;
      Exit;
    end;
  end;

  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
  // tipo
  LIWRgp:=(grdDettaglioGG.medpCompCella(i,'TIPO',0) as TmeTIWAdvRadioGroup);
  FRecordDettaglioGG.Tipo:=IfThen(LIWRgp.ItemIndex = 0,'S','V');
  // controllo commentato a seguito della richiesta dello stesso cliente - daniloc. 29/10/2014
  {
  // se la missione è di un solo giorno verifica presenza della sola tipologia = servizio
  if (W032DM.selM140.FieldByName('DATADA').AsDateTime = W032DM.selM140.FieldByName('DATAA').AsDateTime) and
     (RecordDettaglioGG.Tipo <> 'S') then
  begin
    MsgBox.MessageBox('Non è consentito indicare ore di viaggio per una missione di un giorno solo!',INFORMA);
    ActiveControl:=IWC;
    Exit;
  end;
  }
  TipoDesc:=IfThen(FRecordDettaglioGG.Tipo = 'S','servizio attivo','viaggio');
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine

  // dalle
  LIWEdt:=(grdDettaglioGG.medpCompCella(i,'DALLE',0) as TmeIWEdit);
  TempStr:=LIWEdt.Text;
  if TempStr = '' then
  begin
    MsgBox.MessageBox(Format('Indicare l''ora di inizio del %s!',[TipoDesc]),INFORMA);
    ActiveControl:=LIWEdt;
    Exit;
  end;
  try
    R180OraValidate(TempStr);
  except
    on E:Exception do
    begin
      MsgBox.MessageBox(E.Message,INFORMA);
      ActiveControl:=LIWEdt;
      Exit;
    end;
  end;

  // controlla ora inizio per il primo giorno della missione
  DalleTemp:=R180OreMinutiExt(TempStr);
  if (FRecordDettaglioGG.Data = W032DM.selM140.FieldByName('DATADA').AsDateTime) and
     (DalleTemp < R180OreMinutiExt(W032DM.selM140.FieldByName('ORADA').AsString)) then
  begin
    MsgBox.MessageBox(Format('L''ora di inizio del %s non può essere precedente all''inizio della missione!',[TipoDesc]),INFORMA);
    ActiveControl:=LIWEdt;
    Exit;
  end;
  FRecordDettaglioGG.Dalle:=TempStr;

  // alle
  LIWEdt:=(grdDettaglioGG.medpCompCella(i,'ALLE',0) as TmeIWEdit);
  TempStr:=LIWEdt.Text;
  if TempStr = '' then
  begin
    MsgBox.MessageBox(Format('Indicare l''ora di fine del %s!',[TipoDesc]),INFORMA);
    ActiveControl:=LIWEdt;
    Exit;
  end;
  try
    R180OraValidate(TempStr);
  except
    on E:Exception do
    begin
      MsgBox.MessageBox(E.Message,INFORMA);
      ActiveControl:=LIWEdt;
      Exit;
    end;
  end;

  // controlla ora fine per l'ultimo giorno della missione
  AlleTemp:=R180OreMinutiExt(TempStr);
  if (FRecordDettaglioGG.Data = W032DM.selM140.FieldByName('DATAA').AsDateTime) and
     (AlleTemp > R180OreMinutiExt(W032DM.selM140.FieldByName('ORAA').AsString)) then
  begin
    MsgBox.MessageBox(Format('L''ora di fine del %s non può essere successiva alla fine della missione!',[TipoDesc]),INFORMA);
    ActiveControl:=LIWEdt;
    Exit;
  end;
  FRecordDettaglioGG.Alle:=TempStr;

  // coerenza dalle-alle
  if DalleTemp > AlleTemp then
  begin
    MsgBox.MessageBox(Format('Il periodo di % non è corretto!',[TipoDesc]),INFORMA);
    ActiveControl:=LIWEdt;
    Exit;
  end;

  // controlli complessivi sulla tabella
  // - intersezione periodi dalle - alle
  // - presenza di una sola tipologia (servizio / viaggio) al giorno
  if W032DM.selM143.RecordCount > 0 then
  begin
    Msg:='';
    // salva recno iniziale per riposizionamento successivo
    if grdDettaglioGG.medpStato = msInsert then
      OldRecNo:=-1
    else
      OldRecNo:=W032DM.selM143.RecNo;
    // ciclo di controlli
    try
      W032DM.selM143.First;
      while not W032DM.selM143.Eof do
      begin
        if (W032DM.selM143.RecNo <> OldRecNo) and
           (FRecordDettaglioGG.Data = W032DM.selM143.FieldByName('DATA').AsDateTime)then
        begin
          // 1. verifica intersezione periodi [dalle - alle]
          DalleMin:=R180OreMinutiExt(W032DM.selM143.FieldByName('DALLE').AsString);
          AlleMin:=R180OreMinutiExt(W032DM.selM143.FieldByName('ALLE').AsString);
          if Min(AlleMin,AlleTemp) > Max(DalleMin,DalleTemp) then
          begin
            Msg:=Format('Il periodo di %s indicato interseca'#13#10'un periodo già esistente [%s - %s]',
                        [TipoDesc,
                         W032DM.selM143.FieldByName('DALLE').AsString,
                         W032DM.selM143.FieldByName('ALLE').AsString]);
            Break;
          end;

          // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
          // controllo commentato a seguito della richiesta dello stesso cliente - daniloc. 26/09/2014
          {
          // 2. verifica presenza di una sola tipologia al giorno (servizio / viaggio)
          if W032DM.selM143.FieldByName('TIPO').AsString <> RecordDettaglioGG.Tipo then
          begin
            Msg:='Non è consentito inserire ore di servizio attivo'#13#10'e di viaggio nello stesso giorno!';
            Break;
          end;
          }
          // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
        end;
        W032DM.selM143.Next;
      end;
    finally
      // posizionamento su record inizialmente selezionato
      if OldRecNo <> -1 then
        W032DM.selM143.RecNo:=OldRecNo;
    end;
    // segnala eventuale anomalia
    if Msg <> '' then
    begin
      MsgBox.MessageBox(Msg,INFORMA);
      ActiveControl:=LIWEdt;
      Exit;
    end;
  end;

  // note del servizio attivo (non obbligatorie)
  LIWMemo:=(grdDettaglioGG.medpCompCella(i,'NOTE',0) as TmeIWMemo);
  FRecordDettaglioGG.Note:=Trim(LIWMemo.Text);

  // controlli ok
  Result:=True;
end;

procedure TW032FRichiestaMissioni.imgInsDettaglioGGClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickDettaglioGG(Sender,FN);
  grdDettaglioGG.medpStato:=msInsert;
  grdDettaglioGG.medpBrowse:=False;
  TrasformaComponentiDettaglioGG(FN);
end;

procedure TW032FRichiestaMissioni.imgModDettaglioGGClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickDettaglioGG(Sender,FN);
  grdDettaglioGG.medpStato:=msEdit;
  grdDettaglioGG.medpBrowse:=False;
  TrasformaComponentiDettaglioGG(FN);
end;

procedure TW032FRichiestaMissioni.imgCanDettaglioGGClick(Sender: TObject);
var
  FN: String;
  LRecNo: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if W032DM.selM143.SearchRecord('ROWID',FN,[srFromBeginning]) then
    W032DM.selM143.Delete
  else if TryStrToInt(FN,LRecNo) then
  begin
    // caso di inserimenti con cached updates
    // 1 <= NumR <= RecordCount
    W032DM.selM143.First;
    W032DM.selM143.MoveBy(LRecNo - 1);
    W032DM.selM143.Delete;
  end;
  grdDettaglioGG.medpCaricaCDS;
end;

procedure TW032FRichiestaMissioni.imgAnnullaDettaglioGGClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdDettaglioGG.medpStato:=msBrowse;
  TrasformaComponentiDettaglioGG(FN);
  grdDettaglioGG.medpBrowse:=True;
end;

procedure TW032FRichiestaMissioni.imgApplicaDettaglioGGClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  FImgApplica:=nil;

  // effettua controlli e aggiorna periodo della missione
  // per effettuare il controllo dei servizi attivi in modo corretto
  if not ControlliOK(W032DM.selM140.RowId) then
    Exit;

  W032DM.selM140.Edit;
  W032DM.selM140.FieldByName('DATADA').AsDateTime:=FRichiesta.DataDa;
  W032DM.selM140.FieldByName('DATAA').AsDateTime:=FRichiesta.DataA;
  W032DM.selM140.FieldByName('ORADA').AsString:=FRichiesta.OraDa;
  W032DM.selM140.FieldByName('ORAA').AsString:=FRichiesta.OraA;
  W032DM.selM140.Post;

  // effettua controlli bloccanti
  if not CtrlDettaglioGGOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if grdDettaglioGG.medpStato = msInsert then
    actInsDettaglioGG
  else
    actModDettaglioGG(FN);
end;

procedure TW032FRichiestaMissioni.actInsDettaglioGG;
begin
  // aggiornamento dataset (cached updates)
  W032DM.selM143.Append;
  W032DM.selM143.FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
  W032DM.selM143.FieldByName('TIPO').AsString:=FRecordDettaglioGG.Tipo;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
  W032DM.selM143.FieldByName('DATA').AsDateTime:=FRecordDettaglioGG.Data;
  W032DM.selM143.FieldByName('DALLE').AsString:=FRecordDettaglioGG.Dalle;
  W032DM.selM143.FieldByName('ALLE').AsString:=FRecordDettaglioGG.Alle;
  W032DM.selM143.FieldByName('NOTE').AsString:=FRecordDettaglioGG.Note;
  try
    W032DM.selM143.Post;
    grdDettaglioGG.medpCaricaCDS;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(Format('Errore durante l''inserimento del dettaglio di %s:'#13#10 +
                               'Errore: %s'#13#10'Tipo: %s',
                               [IfThen(FRecordDettaglioGG.Tipo = 'S','servizio','viaggio'),E.Message,E.ClassName]),ESCLAMA);
      Exit;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.actModDettaglioGG(const FN: String);
begin
  // aggiornamento dataset (cached updates)
  W032DM.selM143.Edit;
  W032DM.selM143.FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
  W032DM.selM143.FieldByName('TIPO').AsString:=FRecordDettaglioGG.Tipo;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
  W032DM.selM143.FieldByName('DATA').AsDateTime:=FRecordDettaglioGG.Data;
  W032DM.selM143.FieldByName('DALLE').AsString:=FRecordDettaglioGG.Dalle;
  W032DM.selM143.FieldByName('ALLE').AsString:=FRecordDettaglioGG.Alle;
  W032DM.selM143.FieldByName('NOTE').AsString:=FRecordDettaglioGG.Note;
  try
    W032DM.selM143.Post;
    grdDettaglioGG.medpCaricaCDS;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(Format('Errore durante l''aggiornamento del dettaglio di %s.' + CRLF +
                               'Errore: %s'#13#10'Tipo: %s',
                               [IfThen(FRecordDettaglioGG.Tipo = 'S','servizio','viaggio'),E.Message,E.ClassName]),ESCLAMA);
      Exit;
    end;
  end;
end;


//######################################//
//###       GESTIONE RIMBORSI        ###//
//######################################//

procedure TW032FRichiestaMissioni.DBGridColumnClickRimb(ASender:TObject; const AValue:string);
var
  LRecNo: Integer;
begin
  // in caso di updatespending AValue è numerico ed è il recno del dataset
  if TryStrToInt(AValue,LRecNo) then
  begin
    cdsM150.RecNo:=LRecNo + IfThen(grdRimborsi.medpRigaInserimento,1);
    W032DM.selM150.SearchRecord('INDENNITA_KM;CODICE;ID_RIMBORSO',VarArrayOf([cdsM150.FieldByName('INDENNITA_KM').AsString,cdsM150.FieldByName('CODICE').AsString,cdsM150.FieldByName('ID_RIMBORSO').AsInteger]),[srFromBeginning]);
  end
  else
  begin
    if cdsM150.Locate('DBG_ROWID',AValue,[]) then
      W032DM.selM150.SearchRecord('ROWID',cdsM150.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);
  end;
end;

procedure TW032FRichiestaMissioni.TrasformaComponentiRimb(const FN:String);
var
  i,c,k:Integer;
  LIndKm,LNewIns,LFound: Boolean;
  LIWGrd: TmeIWGrid;
  LIWCmb: TmeIWComboBox;
  LIWMCCmb: TMedpIWMultiColumnComboBox;
  LIWEdt: TmeIWEdit;
begin
  i:=grdRimborsi.medpRigaDiCompGriglia(FN);

  // gestione icone comandi
  LIWGrd:=(grdRimborsi.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
  LIWGrd.Cell[0,0].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'invisibile','align_left');
  if i = 0 then
  begin
    // riga di inserimento
    LIWGrd.Cell[0,1].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'align_left','invisibile');
    LIWGrd.Cell[0,2].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'align_right','invisibile');
    if grdRimborsi.medpStato <> msBrowse then
      FImgConfermaRimb:=(LIWGrd.Cell[0,2].Control as TmeIWImageFile);
  end
  else
  begin
    // dettaglio
    LIWGrd.Cell[0,1].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'invisibile','align_right');
    LIWGrd.Cell[0,2].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'align_left','invisibile');
    LIWGrd.Cell[0,3].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'align_right','invisibile');
    if grdRimborsi.medpStato <> msBrowse then
      FImgConfermaRimb:=(LIWGrd.Cell[0,3].Control as TmeIWImageFile);
  end;

  LIWCmb:=nil;
  if grdRimborsi.medpStato <> msBrowse then
  begin
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
    // data rimborso
    if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
    begin
      if grdRimborsi.medpStato = msInsert then
      begin
        grdRimborsi.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','');
        c:=grdRimborsi.medpIndexColonna('DATA_RIMBORSO');
        grdRimborsi.medpCreaComponenteGenerico(i,c,grdRimborsi.Componenti);
        LIWEdt:=(grdRimborsi.medpCompCella(i,c,0) as TmeIWEdit);
        begin
          // se la missione è di un giorno solo, propone questo in inserimento
          if W032DM.selM140.FieldByName('DATADA').AsDateTime = W032DM.selM140.FieldByName('DATAA').AsDateTime then
            LIWEdt.Text:=W032DM.selM140.FieldByName('DATADA').AsString;
          if LIWEdt.Text = '' then
            ActiveControl:=LIWEdt;
        end;
      end;
    end;

    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
    // voce di rimborso
    if grdRimborsi.medpStato = msInsert then
    begin
      grdRimborsi.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'40','','','','S');
      c:=grdRimborsi.medpIndexColonna('C_DESCRIZIONE');
      grdRimborsi.medpCreaComponenteGenerico(i,c,grdRimborsi.Componenti);
      LIWCmb:=(grdRimborsi.medpCompCella(i,c,0) as TmeIWComboBox);
      LIWCmb.FriendlyName:=FN;
      LIWCmb.ItemsHaveValues:=True;
      LIWCmb.Items.Assign(FListaRimborsi);
      LIWCmb.Items.Insert(0,'=');
      if grdRimborsi.medpStato = msInsert then
        LIWCmb.ItemIndex:=0
      else if grdRimborsi.medpStato = msEdit then
        LIWCmb.ItemIndex:=LIWCmb.Items.IndexOfName(grdRimborsi.medpValoreColonna(i,'DESCRIZIONE'));
      LIWCmb.OnChange:=cmbVoceRimborsoChange;
      LIndKm:=W032DM.selM021.SearchRecord('CODICE',LIWCmb.Text,[srFromBeginning]);
    end
    else
    begin
      LIndKm:=grdRimborsi.medpValoreColonna(i,'INDENNITA_KM') = 'S';
    end;

    LNewIns:=(grdRimborsi.medpStato = msInsert) and (LIWCmb.Text = '');

    // km percorsi
    grdRimborsi.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'5','','','','S');
    c:=grdRimborsi.medpIndexColonna('KMPERCORSI');
    grdRimborsi.medpCreaComponenteGenerico(i,c,grdRimborsi.Componenti);
    LIWEdt:=(grdRimborsi.medpCompCella(i,c,0) as TmeIWEdit);
    if (LNewIns) or (not LIndKm) then
      LIWEdt.Css:='invisibile'
    else
      ActiveControl:=LIWEdt;
    LIWEdt.Text:=grdRimborsi.medpValoreColonna(i,'KMPERCORSI');

    // valuta
    grdRimborsi.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'15','','','','S');
    c:=grdRimborsi.medpIndexColonna('COD_VALUTA');
    grdRimborsi.medpCreaComponenteGenerico(i,c,grdRimborsi.Componenti);
    LIWCmb:=(grdRimborsi.medpCompCella(i,c,0) as TmeIWComboBox);
    if LNewIns or LIndKm then
      LIWCmb.Css:='invisibile';
    LIWCmb.FriendlyName:=FN;
    LIWCmb.ItemsHaveValues:=True;
    LIWCmb.Items.Assign(FListaValute);
    if grdRimborsi.medpStato = msInsert then
      LIWCmb.ItemIndex:=0
    else if grdRimborsi.medpStato = msEdit then
    begin
      // bugfix.ini - daniloc 20.05.2014
      // comportamento modificato da IW nella patch 12.2.29 - la seguente riga non è più esatta
      // ItemIndex:=Items.IndexOfName(medpValoreColonna(i,'COD_VALUTA'));
      for k:=0 to LIWCmb.Items.Count do
      begin
        if grdRimborsi.medpValoreColonna(i,'COD_VALUTA') = LIWCmb.Items.ValueFromIndex[k] then
        begin
          LFound:=True;
          Break;
        end;
      end;
      if LFound then
        LIWCmb.ItemIndex:=k;
      // bugfix.fine
    end;
    LIWCmb.RequireSelection:=LIWCmb.Items.Count > 0;

    // rimborso
    grdRimborsi.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'5','','','','S');
    c:=grdRimborsi.medpIndexColonna('RIMBORSO');
    grdRimborsi.medpCreaComponenteGenerico(i,c,grdRimborsi.Componenti);
    LIWEdt:=(grdRimborsi.medpCompCella(i,c,0) as TmeIWEdit);
    if LNewIns or LIndKm then
      LIWEdt.Css:='invisibile'
    else
      ActiveControl:=LIWEdt;
    LIWEdt.Text:=grdRimborsi.medpValoreColonna(i,'RIMBORSO');

    // note rimborso editabili
    if Parametri.CampiRiferimento.C8_W032NoteRimbEditabili = 'S' then
    begin
      grdRimborsi.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'30','','','','S');
      c:=grdRimborsi.medpIndexColonna('NOTE');
      grdRimborsi.medpCreaComponenteGenerico(i,c,grdRimborsi.Componenti);
      LIWEdt:=(grdRimborsi.medpCompCella(i,c,0) as TmeIWEdit);
      LIWEdt.Text:=grdRimborsi.medpValoreColonna(i,'NOTE');
    end;

    // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.ini
    if W032DM.GestTipoRimborso then
    begin
      grdRimborsi.medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      c:=grdRimborsi.medpIndexColonna('TIPORIMBORSO');
      grdRimborsi.medpCreaComponenteGenerico(i,c,grdRimborsi.Componenti);
      LIWMCCmb:=(grdRimborsi.medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox);
      C190CaricaMepdMulticolumnComboBox(LIWMCCmb,W032DM.selM049,'CODICE','DESCRIZIONE');
      if grdRimborsi.medpValoreColonna(i,'TIPORIMBORSO').IsEmpty then
      begin
        LIWMCCmb.Text:=VarToStr(W032DM.selM049.Lookup('SOMMA','S','CODICE'));
      end
      else
      begin
        LIWMCCmb.Text:=grdRimborsi.medpValoreColonna(i,'TIPORIMBORSO');
      end;
      if W032DM.GestTipoRimborso(grdRimborsi.medpValoreColonna(i,'CODICE')) and (not grdRimborsi.medpValoreColonna(i,'CODICE').IsEmpty) then
      begin
        LIWMCCmb.Css:=C190ImpostaCssInvisibile(LIWMCCmb.Css,True);
      end
      else
      begin
        LIWMCCmb.Css:=C190ImpostaCssInvisibile(LIWMCCmb.Css,False);
      end;
    end;
    // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.fine

    // file picker
    {medpPreparaComponenteGenerico('C',0,0,DBG_FPK,'30','','','','S');
    c:=medpIndexColonna('FILE_ALLEGATO');
    medpCreaComponenteGenerico(i,c,Componenti);
    LIWFile:=(medpCompCella(i,c,0) as TmeIWFile);
    LIWFile.Text:=medpValoreColonna(i,'FILE_ALLEGATO'); // non funziona...
    }
  end
  else
  begin
    FreeAndNil(grdRimborsi.medpCompGriglia[i].CompColonne[grdRimborsi.medpIndexColonna('C_DESCRIZIONE')]);
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
    if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
      FreeAndNil(grdRimborsi.medpCompGriglia[i].CompColonne[grdRimborsi.medpIndexColonna('DATA_RIMBORSO')]);
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
    FreeAndNil(grdRimborsi.medpCompGriglia[i].CompColonne[grdRimborsi.medpIndexColonna('KMPERCORSI')]);
    FreeAndNil(grdRimborsi.medpCompGriglia[i].CompColonne[grdRimborsi.medpIndexColonna('COD_VALUTA')]);
    FreeAndNil(grdRimborsi.medpCompGriglia[i].CompColonne[grdRimborsi.medpIndexColonna('RIMBORSO')]);
    // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.ini
    if (grdRimborsi.medpIndexColonna('TIPORIMBORSO') > 0) and
       (grdRimborsi.medpCompGriglia[i].CompColonne[grdRimborsi.medpIndexColonna('TIPORIMBORSO')] <> nil) then
    begin
      FreeAndNil(grdRimborsi.medpCompGriglia[i].CompColonne[grdRimborsi.medpIndexColonna('TIPORIMBORSO')]);
    end;
    // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.fine
  end;
end;

procedure TW032FRichiestaMissioni.grdRimborsiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
  IWG: TmeIWGrid;
begin
  if (not SolaLettura) and
     (not WR000DM.Responsabile) then
  begin
    if grdRimborsi.medpRigaInserimento then
    begin
      (grdRimborsi.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInsRimborsoClick;
      (grdRimborsi.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaRimborsoClick;
      (grdRimborsi.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgApplicaRimborsoClick;
      IWG:=(grdRimborsi.medpCompGriglia[0].CompColonne[0] as TmeIWGrid);
      // nasconde pulsante di inserimento se non ci sono rimborsi selezionabili
      if FListaRimborsi.Count = 0 then
      begin
        IWG.Cell[0,0].Css:='invisibile';
      end;
      IWG.Cell[0,1].Css:='invisibile';
      IWG.Cell[0,2].Css:='invisibile';
    end;

    // righe di dettaglio
    for i:=IfThen(grdRimborsi.medpRigaInserimento,1,0) to High(grdRimborsi.medpCompGriglia) do
    begin
      if (grdRimborsi.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        (grdRimborsi.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCanRimborsoClick;
        (grdRimborsi.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModRimborsoClick;
        (grdRimborsi.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaRimborsoClick;
        (grdRimborsi.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgApplicaRimborsoClick;
        IWG:=(grdRimborsi.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
        // il rimborso automatico non è cancellabile né modificabile
        if grdRimborsi.medpValoreColonna(i,'AUTOMATICO') = 'S' then
        begin
          IWG.Cell[0,0].Css:='invisibile';
          IWG.Cell[0,1].Css:='invisibile';
        end;
        // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
        // i rimborsi esistenti sono cancellabili / modificabili solo se STATO is null
        // (non modificabili se vale A,S,I).
        if R180In(grdRimborsi.medpValoreColonna(i,'STATO'),['A','S','I']) then
        begin
          IWG.Cell[0,0].Css:='invisibile';
          IWG.Cell[0,1].Css:='invisibile';
        end;
        // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
        IWG.Cell[0,2].Css:='invisibile';
        IWG.Cell[0,3].Css:='invisibile';
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.grdRimborsiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  IndKM: Boolean;
  Campo: String;
begin
  if not grdRimborsi.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  if ARow = 0 then
  begin
    // sostituzione spazio -> CRLF su intestazione
    ACell.RawText:=True;
    ACell.Text:=StringReplace(ACell.Text,' ','<br/>',[]);
  end
  else
  begin
    NumColonna:=grdRimborsi.medpNumColonna(AColumn);
    Campo:=grdRimborsi.medpColonna(NumColonna).DataField;

    // assegnazione componenti alle celle
    if (ARow <= High(grdRimborsi.medpCompGriglia) + 1) and (grdRimborsi.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
    begin
      ACell.Control:=grdRimborsi.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
      ACell.Text:='';
    end;

    if (ARow <= High(grdRimborsi.medpCompGriglia) + 1) and (ACell.Control = nil) then
    begin
      // campi con valori allineati al centro
      if (Campo = 'INDENNITA_KM') or
         (Campo = 'KMPERCORSI') or
         (Campo = 'COD_VALUTA') then
      begin
        ACell.Css:=ACell.Css + ' align_center';
      end
      else if (Campo = 'RIMBORSO') or
              (Campo = 'RIMBORSO_VARIATO') then
      begin
        ACell.Css:=ACell.Css + ' align_right';
      end;

      // in base al tipo di rimborso nasconde eventuali informazioni non coerenti
      if (Campo = 'KMPERCORSI') or
         (Campo = 'COD_VALUTA') or
         (Campo = 'RIMBORSO') or
         (Campo = 'RIMBORSO_VARIATO') then
      begin
        IndKM:=W032DM.selM021.SearchRecord('CODICE',grdRimborsi.medpValoreColonna(ARow - 1,'CODICE'),[srFromBeginning]);
        if (Campo = 'KMPERCORSI') and (not IndKM) then
          ACell.Text:='';
        //else if ((Campo = 'COD_VALUTA') or (Campo = 'RIMBORSO') or (Campo = 'RIMBORSO_VARIATO')) and (IndKM) then
        //  ACell.Text:='';
      end;
    end;
  end;
end;

function TW032FRichiestaMissioni.CtrlRimborsoOK(const FN: String): Boolean;
var
  i,x: Integer;
  LIWC: TIWCustomControl;
  LIndKm: Boolean;
  LTipoArr,LVoce,LDescValutaTemp,LTipoQuantita,LDataSetRowID:String;
  LArr: double;
  LImporto,LLimite,LSommaRimbPasto: Currency;
  LBM: TBookmark;
begin
  Result:=False;
  FMsgRimb:='';
  i:=grdRimborsi.medpRigaDiCompGriglia(FN);
  LIWC:=nil;

  // codice
  if grdRimborsi.medpStato = msInsert then
  begin
    if W032DM.GestTipoRimborso(FRecordRimborso.Codice)then
    begin
      LIWC:=grdRimborsi.medpCompCella(i,'TIPORIMBORSO',0);
      FRecordRimborso.TipoRimborso:=(LIWC as TMedpIWMultiColumnComboBox).Items[(LIWC as TMedpIWMultiColumnComboBox).ItemIndex].RowData[0];
    end;

    LIWC:=grdRimborsi.medpCompCella(i,'C_DESCRIZIONE',0);
    FRecordRimborso.Codice:=(LIWC as TmeIWComboBox).Items.ValueFromIndex[(LIWC as TmeIWComboBox).ItemIndex];
    if FRecordRimborso.Codice = '' then
    begin
      MsgBox.MessageBox('Selezionare una voce di rimborso tra quelle disponibili!',INFORMA);
      ActiveControl:=LIWC;
      Exit;
    end;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
    LTipoQuantita:=VarToStr(W032DM.selM020Rimborsi.Lookup('CODICE',FRecordRimborso.Codice,'TIPO_QUANTITA'));
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine
    LVoce:=(LIWC as TmeIWComboBox).Items.Names[(LIWC as TmeIWComboBox).ItemIndex];
  end
  else
  begin
    if (FN = '') and (W032DM.selM150.UpdatesPending) then
    begin
      // dati in cache -> utilizza campi del dataset selM150
      FRecordRimborso.Codice:=W032DM.selM150.FieldByName('CODICE').AsString;

      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
      LTipoQuantita:=W032DM.selM150.FieldByName('C_TIPO_QUANTITA').AsString;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine
      LVoce:=FRecordRimborso.Codice;
      for x:=0 to FListaRimborsi.Count - 1 do
      begin
        if FRecordRimborso.Codice = FListaRimborsi.ValueFromIndex[x] then
        begin
          LVoce:=FListaRimborsi.Names[x];
          Break;
        end;
      end;
    end
    else
    begin
      FRecordRimborso.Codice:=grdRimborsi.medpValoreColonna(i,'CODICE');
      if W032DM.GestTipoRimborso(FRecordRimborso.Codice)then
      begin
        LIWC:=grdRimborsi.medpCompCella(i,'TIPORIMBORSO',0);
        if LIWC = nil then
        begin
          FRecordRimborso.TipoRimborso:=grdRimborsi.medpValoreColonna(i,'TIPORIMBORSO');
        end
        else
        begin
          FRecordRimborso.TipoRimborso:=(LIWC as TMedpIWMultiColumnComboBox).Items[(LIWC as TMedpIWMultiColumnComboBox).ItemIndex].RowData[0];
        end;
      end;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
      LTipoQuantita:=grdRimborsi.medpValoreColonna(i,'C_TIPO_QUANTITA');
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine
      LVoce:=grdRimborsi.medpValoreColonna(i,'C_DESCRIZIONE');
    end;
  end;

  FRecordRimborso.IndennitaKm:=IfThen(W032DM.selM021.SearchRecord('CODICE',FRecordRimborso.Codice,[srFromBeginning]),'S','N');

  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
  FRecordRimborso.DataRimborso:=DATE_NULL;
  FRecordRimborso.IdRimborso:=0;
  if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
  begin
    // id rimborso
    if (FN = '') and (W032DM.selM150.UpdatesPending) then
    begin
      // dati in cache -> utilizza campi del dataset selM150
      FRecordRimborso.IdRimborso:=W032DM.selM150.FieldByName('ID_RIMBORSO').AsInteger;
    end
    else
    begin
      FRecordRimborso.IdRimborso:=StrToIntDef(grdRimborsi.medpValoreColonna(i,'ID_RIMBORSO'),-1);
    end;

    // data rimborso  (solo in inserimento)
    if grdRimborsi.medpStato = msInsert then
    begin
      LIWC:=grdRimborsi.medpCompCella(i,'DATA_RIMBORSO',0);
      // verifica che la data rimborso sia indicata
      if (LIWC as TmeIWEdit).Text = '' then
      begin
        MsgBox.MessageBox('E'' necessario indicare la data del rimborso!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
      // verifica che la data rimborso sia valida
      if not TryStrToDateTime((LIWC as TmeIWEdit).Text,FRecordRimborso.DataRimborso,TFunzioniGenerali.CreateDefaultFormatSettings) then
      begin
        MsgBox.MessageBox('La data del rimborso non è valida!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
      // verifica che la data rimborso sia compresa nel periodo della missione
      if (FRecordRimborso.DataRimborso < FRichiesta.DataDa) or
         (FRecordRimborso.DataRimborso > FRichiesta.DataA) then
      begin
        MsgBox.MessageBox('La data del rimborso non può essere esterna al periodo della missione!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
    end
    else
    begin
      if (FN = '') and (W032DM.selM150.UpdatesPending) then
      begin
        // dati in cache -> utilizza campi del dataset selM150
        FRecordRimborso.DataRimborso:=W032DM.selM150.FieldByName('DATA_RIMBORSO').AsDateTime;
      end
      else
      begin
        FRecordRimborso.DataRimborso:=StrToDate(grdRimborsi.medpValoreColonna(i,'DATA_RIMBORSO'));
      end;
    end;
  end;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

  LIndKm:=W032DM.selM021.SearchRecord('CODICE',FRecordRimborso.Codice,[srFromBeginning]);
  if LIndKm then
  begin
    // gestione indennità km
    // nessun controllo necessario -> termina subito restituendo False
    if grdRimborsi.medpStato = msBrowse then
      Exit;

    // km percorsi
    LIWC:=grdRimborsi.medpCompCella(i,'KMPERCORSI',0);
    if not TryStrToFloat((LIWC as TmeIWEdit).Text,FRecordRimborso.KmPercorsi) then
    begin
      MsgBox.MessageBox('Indicare i km percorsi!',INFORMA);
      ActiveControl:=LIWC;
      Exit;
    end;

    // importo indennità km
    W032DM.selM021.SearchRecord('CODICE',FRecordRimborso.Codice,[srFromBeginning]);
    LImporto:=FRecordRimborso.KmPercorsi * W032DM.selM021.FieldByName('IMPORTO').AsFloat;
    LArr:=1;
    LTipoArr:='P';
    W032DM.P050.Close;
    W032DM.P050.SetVariable('CODICE',W032DM.selM021.FieldByName('ARROTONDAMENTO').AsString);
    W032DM.P050.SetVariable('DECORRENZA',FRichiesta.DataA);
    W032DM.P050.Open;
    W032DM.P050.First;
    if not W032DM.P050.Eof then
    begin
      LArr:=W032DM.P050.FieldByName('VALORE').AsFloat;
      LTipoArr:=W032DM.P050.FieldByName('TIPO').AsString;
    end;

    FRecordRimborso.Rimborso:=R180Arrotonda(LImporto,LArr,LTipoArr);
    FRecordRimborso.CodValuta:=FListaValute.ValueFromIndex[0]; //*** a caso!!!
  end
  else
  begin
    // gestione rimborso
    // valuta
    if grdRimborsi.medpStato <> msBrowse then
    begin
      LIWC:=grdRimborsi.medpCompCella(i,'COD_VALUTA',0);
      if (LIWC as TmeIWComboBox).ItemIndex < 0 then
      begin
        MsgBox.MessageBox('Selezionare la valuta dall''elenco!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
      FRecordRimborso.CodValuta:=(LIWC as TmeIWComboBox).Items.ValueFromIndex[(LIWC as TmeIWComboBox).ItemIndex];
      LDescValutaTemp:=(LIWC as TmeIWComboBox).Text;
    end
    else
    begin
      if (FN = '') and (W032DM.selM150.UpdatesPending) then
      begin
        // dati in cache -> utilizza campi del dataset selM150
        FRecordRimborso.CodValuta:=W032DM.selM150.FieldByName('COD_VALUTA').AsString;
        LDescValutaTemp:=FRecordRimborso.CodValuta;
      end
      else
      begin
        FRecordRimborso.CodValuta:=grdRimborsi.medpValoreColonna(i,'COD_VALUTA');
        LDescValutaTemp:=FRecordRimborso.CodValuta;
      end;
    end;

    // importo rimborso
    if grdRimborsi.medpStato <> msBrowse then
    begin
      LIWC:=grdRimborsi.medpCompCella(i,'RIMBORSO',0);
      if not TryStrToCurr((LIWC as TmeIWEdit).Text,FRecordRimborso.Rimborso) then
      begin
        MsgBox.MessageBox('Indicare il valore del rimborso!',INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
      //Controllo su importo massimo dei rimborsi
      if W032DM.selM150.FieldByName('INDENNITA_KM').AsString = 'N' then
      begin
        LIWC:=grdRimborsi.medpCompCella(i,'RIMBORSO',0);
        LImporto:=StrToCurr(Trim((LIWC as TmeIWEdit).Text));
        //Sommo tutti i rimborsi con lo stesso codice se gestione rimborso è dettagliata
        if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
        begin
          LBM:=W032DM.selM150.GetBookmark;
          LDataSetRowID:=W032DM.selM150.RowId;
          if W032DM.selM150.SearchRecord('CODICE',FRecordRimborso.Codice,[srFromBeginning]) then
          begin
            repeat
              if (grdRimborsi.medpStato = msInsert) or (W032DM.selM150.RowId <> LDataSetRowID) then
                LImporto:=LImporto + W032DM.selM150.FieldByName('RIMBORSO').AsCurrency;
            until not W032DM.selM150.SearchRecord('CODICE',FRecordRimborso.Codice,[srForward]);
          end;
          W032DM.selM150.GotoBookmark(LBM);
        end;
        if (Trim((LIWC as TmeIWEdit).Text) <> '') and
           (W032DM.selM020Rimborsi.Lookup('CODICE',FRecordRimborso.Codice,'IMPORTO_MAX') <> null) and
           (LImporto > W032DM.selM020Rimborsi.Lookup('CODICE',FRecordRimborso.Codice,'IMPORTO_MAX'))  then
        begin
          MsgBox.MessageBox(Format('L''importo non può essere maggiore di %s.',[W032DM.selM020Rimborsi.FieldByName('IMPORTO_MAX').AsString]),INFORMA);
          ActiveControl:=LIWC;
          Exit;
        end;
      end;
    end
    else
    begin
      if (FN = '') and (W032DM.selM150.UpdatesPending) then
      begin
        // dati in cache -> utilizza campi del dataset selM150
        FRecordRimborso.Rimborso:=W032DM.selM150.FieldByName('RIMBORSO').AsFloat;
      end
      else
      begin
        FRecordRimborso.Rimborso:=StrToFloat(grdRimborsi.medpValoreColonna(i,'RIMBORSO'));
      end;
    end;

    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
    // nel caso di tipo quantità F (flag) l'importo del rimborso può essere solo 0 oppure 1
    if LTipoQuantita = W032_TQ_FLAG then
    begin
      // flag: 0 / 1
      if not ((FRecordRimborso.Rimborso = 0) or
              (FRecordRimborso.Rimborso = 1)) then
      begin
        MsgBox.MessageBox(Format('La quantità indicata per la voce di rimborso "%s"'#13#10'non è valida!'#13#10'Indicare 0 oppure 1.',[LVoce]),INFORMA);
        ActiveControl:=LIWC;
        Exit;
      end;
    end;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine

    // se il codice di rimborso è un rimborso pasto, verifica il limite
    // di importo / quantità impostato sulla regola missione
    if FListaRimborsiPasto.IndexOf(FRecordRimborso.Codice) > -1 then
    begin
      // imposta variabili per calcolo limite in base a regola trasferta
      W032DM.M013F_CALC_RIMB_PASTO.SetVariable('TIPORISULTATO','I');
      W032DM.M013F_CALC_RIMB_PASTO.SetVariable('CODICE',FRegolaM010.Codice);
      W032DM.M013F_CALC_RIMB_PASTO.SetVariable('TIPOREGISTRAZIONE',W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString);

      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
      if FRecordRimborso.DataRimborso = DATE_NULL then
      begin
        // rimborso pasto indicato complessivamente: calcola limite su tutta la durata della missione
        W032DM.M013F_CALC_RIMB_PASTO.SetVariable('DATADA',FRichiesta.DataDa);
        W032DM.M013F_CALC_RIMB_PASTO.SetVariable('DATAA',FRichiesta.DataA);
        W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORADA',FRichiesta.OraDa);
        W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORAA',FRichiesta.OraA);
        W032DM.M013F_CALC_RIMB_PASTO.Execute;
        LLimite:=StrToCurr(VarToStr(W032DM.M013F_CALC_RIMB_PASTO.GetVariable('RESULT')));

        // verifica sforamento limite rimborso pasto
        if LLimite > -1 then
        begin
          // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
          // arrotondamento limite
          if LLimite > 0 then
          begin
            LArr:=1;
            LTipoArr:='P';
            W032DM.P050.Close;
            W032DM.P050.SetVariable('CODICE',FRegolaM010.ArrotTariffaDopoRiduzione);
            W032DM.P050.SetVariable('DECORRENZA',FRichiesta.DataA);
            W032DM.P050.Open;
            W032DM.P050.First;
            if not W032DM.P050.Eof then
            begin
              LArr:=W032DM.P050.FieldByName('VALORE').AsFloat;
              LTipoArr:=W032DM.P050.FieldByName('TIPO').AsString;
            end;
            LLimite:=R180Arrotonda(LLimite,LArr,LTipoArr);
          end;
          // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

          if FRecordRimborso.Rimborso > LLimite then
          begin
            FRecordRimborso.Rimborso:=LLimite;
            FMsgRimb:=Format('La quantit&agrave; richiesta per il rimborso pasto &egrave; stata limitata a <b>%s %n</b><br>in base alle regole definite per la missione.',
                            [LDescValutaTemp,FRecordRimborso.Rimborso]);

            // se il rimborso è limitato a 0 non ne consente l'inserimento
            if FRecordRimborso.Rimborso = 0 then
            begin
              FMsgRimb:=FMsgRimb + #13#10'Il rimborso non può essere inserito!';
              MsgBox.TextIsHTML:=True;
              MsgBox.MessageBox(FMsgRimb,INFORMA);
              MsgBox.TextIsHTML:=False;
              if Assigned(LIWC) then
              begin
                (LIWC as TmeIWEdit).Text:='0';
                ActiveControl:=LIWC;
              end;
              Exit;
            end;
          end;
        end;
      end
      else
      begin
        // effettua controlli nel caso in cui la data rimborso è valorizzata
        // salva bookmark per successivo riposizionamento
        LBM:=W032DM.selM150.GetBookmark;
        try
          // filtra i rimborsi pasto presenti alla data del rimborso attuale
          W032DM.selM150.Filter:=Format('(DATA_RIMBORSO = %s) and (CODICE = ''%s'')',
                                        [FloatToStr(FRecordRimborso.DataRimborso),FRecordRimborso.Codice]);
          W032DM.selM150.Filtered:=True;

          (*Alberto 19/10/2020: rimosso il limite sui rimborsi pasto
          // in fase di inserimento verifica che non sia presente più di un
          // codice rimborso pasto per la data del rimborso corrente
          if (grdRimborsi.medpStato = msInsert) and
             (W032DM.selM150.RecordCount >= MAX_RIMBORSI_PASTO_GG) then
          begin
            // rimuove filtro temporaneo e riposiziona bookmark
            W032DM.selM150.Filtered:=False;
            if W032DM.selM150.BookmarkValid(LBM) then
              W032DM.selM150.GotoBookmark(LBM);
            MsgBox.MessageBox(Format('Non è consentito indicare più di %d rimborsi pasto al giorno!',[MAX_RIMBORSI_PASTO_GG]),INFORMA);
            Exit;
          end;
          *)

          // somma tutti i rimborsi pasto, compreso quello corrente
          LSommaRimbPasto:=0;
          W032DM.selM150.First;
          while not W032DM.selM150.Eof do
          begin
            if W032DM.selM150.FieldByName('ID_RIMBORSO').AsInteger <> FRecordRimborso.IdRimborso then
              LSommaRimbPasto:=LSommaRimbPasto + W032DM.selM150.FieldByName('RIMBORSO').AsFloat;
            W032DM.selM150.Next;
          end;
          // aggiunge il rimborso corrente
          LSommaRimbPasto:=LSommaRimbPasto + FRecordRimborso.Rimborso;

          // rimuove filtro temporaneo e riposiziona bookmark
          W032DM.selM150.Filtered:=False;
          if W032DM.selM150.BookmarkValid(LBM) then
            W032DM.selM150.GotoBookmark(LBM);

          // verifica che il totale non sfori il limite calcolato
          W032DM.M013F_CALC_RIMB_PASTO.SetVariable('DATADA',FRecordRimborso.DataRimborso);
          W032DM.M013F_CALC_RIMB_PASTO.SetVariable('DATAA',FRecordRimborso.DataRimborso);
          if FRichiesta.DataDa = FRichiesta.DataA then
          begin
            // missione di un solo giorno
            // [inizio missione - fine missione]
            W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORADA',FRichiesta.OraDa);
            W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORAA',FRichiesta.OraA);
          end
          else if FRecordRimborso.DataRimborso = FRichiesta.DataDa then
          begin
            // rimborso pasto nel giorno di inizio missione
            // [inizio missione - 23.59]
            W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORADA',FRichiesta.OraDa);
            W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORAA','23.59');
          end
          else if FRecordRimborso.DataRimborso = FRichiesta.DataDa then
          begin
            // rimborso pasto nel giorno di fine missione
            // [00.00 - fine missione]
            W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORADA','00.00');
            W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORAA',FRichiesta.OraA);
          end
          else
          begin
            // rimborso pasto in un giorno intermedio
            // [00.00 - 23.59]
            W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORADA','00.00');
            W032DM.M013F_CALC_RIMB_PASTO.SetVariable('ORAA','23.59');
          end;
          W032DM.M013F_CALC_RIMB_PASTO.Execute;
          LLimite:=StrToCurr(VarToStr(W032DM.M013F_CALC_RIMB_PASTO.GetVariable('RESULT')));

          // verifica sforamento limite rimborso pasto
          if LLimite > -1 then
          begin
            // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
            // arrotondamento limite
            if LLimite > 0 then
            begin
              LArr:=1;
              LTipoArr:='P';
              W032DM.P050.Close;
              W032DM.P050.SetVariable('CODICE',FRegolaM010.ArrotTariffaDopoRiduzione);
              W032DM.P050.SetVariable('DECORRENZA',FRecordRimborso.DataRimborso);
              W032DM.P050.Open;
              W032DM.P050.First;
              if not W032DM.P050.Eof then
              begin
                LArr:=W032DM.P050.FieldByName('VALORE').AsFloat;
                LTipoArr:=W032DM.P050.FieldByName('TIPO').AsString;
              end;
              LLimite:=R180Arrotonda(LLimite,LArr,LTipoArr);
            end;
            // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

            if LSommaRimbPasto > LLimite then
            begin
              FRecordRimborso.Rimborso:=(LLimite - (LSommaRimbPasto - FRecordRimborso.Rimborso));
              FMsgRimb:=Format('La quantit&agrave; richiesta per il rimborso pasto<br>del <b>%s</b> &egrave; stata limitata a <b>%s %n</b><br>in base alle regole definite per la missione.',
                              [DateToStr(FRecordRimborso.DataRimborso),LDescValutaTemp,FRecordRimborso.Rimborso]);

              // se il rimborso è limitato a 0 non ne consente l'inserimento
              if FRecordRimborso.Rimborso = 0 then
              begin
                FMsgRimb:=FMsgRimb + '<br>Il rimborso non pu&ograve; essere inserito';
                MsgBox.TextIsHTML:=True;
                MsgBox.MessageBox(FMsgRimb,INFORMA);
                MsgBox.TextIsHTML:=False;
                (LIWC as TmeIWEdit).Text:='0';
                ActiveControl:=LIWC;
                Exit;
              end;
            end;
          end;
        finally
          W032DM.selM150.FreeBookmark(LBM);
        end;
      end;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
    end;

    FRecordRimborso.KmPercorsi:=0;
  end;

  FRecordRimborso.Note:='';
  FRecordRimborso.FileAllegato:='';
  // note rimborso editabili
  if (FN <> '') and (Parametri.CampiRiferimento.C8_W032NoteRimbEditabili = 'S') then
  begin
    LIWC:=grdRimborsi.medpCompCella(i,'NOTE',0);
    FRecordRimborso.Note:=(LIWC as TmeIWEdit).Text;
  end;

  // file allegato
  {
  if FN <> '' then
  begin
    c:=grdRimborsi.medpIndexColonna('FILE_ALLEGATO');
    IWC:=grdRimborsi.medpCompCella(i,c,0);
    if Trim((IWC as TmeIWFile).Filename) = '' then
    begin
      MsgBox.MessageBox('Indicare il file del giustificativo di spesa!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
    RecordRimborso.FileAllegato:=Trim((IWC as TmeIWFile).Filename);
  end;
  }

  // verifica duplicazione di chiave
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
  if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
  begin
    // data rimborso: gestita
    // previsti codici di rimborso uguali, anche sulla stessa data
    // nessun controllo!
  end
  else
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
  begin
    // data rimborso: non gestita
    // previsto un solo codice di rimborso per richiesta
    // nota: in modifica il codice non è modificabile
    if (grdRimborsi.medpStato = msInsert) and
       (W032DM.selM150.SearchRecord('CODICE',FRecordRimborso.Codice,[srFromBeginning])) then
    begin
      MsgBox.MessageBox(Format('La voce di rimborso'#13#10'"%s"'#13#10'è già presente nella tabella!',[LVoce]),INFORMA);
      Exit;
    end;
  end;

  Result:=True;
end;

function TW032FRichiestaMissioni.CtrlSommaIndKmOK: Boolean;
// verifica che la somma dei km richiesti come indennità sia >= 0
var
  LOldFiltered: Boolean;
  LTotKm: Integer;
begin
  // filtra il dataset dei rimborsi in modo da considerare solo
  // le voci di indennità chilometrica
  LOldFiltered:=W032DM.selM150.Filtered;
  try
    W032DM.selM150.Filtered:=False;
    W032DM.selM150.Filter:='INDENNITA_KM = ''S''';
    W032DM.selM150.Filtered:=True;

    // ciclo sulle indennità per calcolare la somma
    LTotKm:=0;
    W032DM.selM150.First;
    while not W032DM.selM150.Eof do
    begin
      LTotKm:=LTotKm + W032DM.selM150.FieldByName('KMPERCORSI').AsInteger;
      W032DM.selM150.Next;
    end;
    W032DM.selM150.Filtered:=LOldFiltered;
  except
    LTotKm:=0;
  end;

  // richieste indennità ok se il totale dei km è >= 0
  Result:=LTotKm >= 0;
end;

procedure TW032FRichiestaMissioni.imgInsRimborsoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickRimb(Sender,FN);
  grdRimborsi.medpStato:=msInsert;
  grdRimborsi.medpBrowse:=False;
  TrasformaComponentiRimb(FN);
end;

procedure TW032FRichiestaMissioni.imgModRimborsoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickRimb(Sender,FN);
  grdRimborsi.medpStato:=msEdit;
  grdRimborsi.medpBrowse:=False;
  TrasformaComponentiRimb(FN);
end;

procedure TW032FRichiestaMissioni.imgCanRimborsoClick(Sender: TObject);
var
  FN: String;
  LRecNo: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if W032DM.selM150.SearchRecord('ROWID',FN,[srFromBeginning]) then
    W032DM.selM150.Delete
  else if TryStrToInt(FN,LRecNo) then
  begin
    // caso di inserimenti con cached updates
    // 1 <= NumR <= RecordCount
    W032DM.selM150.First;
    W032DM.selM150.MoveBy(LRecNo - 1);
    W032DM.selM150.Delete;
  end;

  grdRimborsi.medpCaricaCDS;
end;

procedure TW032FRichiestaMissioni.imgAnnullaRimborsoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdRimborsi.medpStato:=msBrowse;
  TrasformaComponentiRimb(FN);
  grdRimborsi.medpBrowse:=True;
end;

procedure TW032FRichiestaMissioni.imgApplicaRimborsoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  FImgApplica:=nil;

  // effettua controlli e aggiorna periodo della missione
  // per effettuare il controllo rimborsi in modo corretto
  if not ControlliOK(W032DM.selM140.RowId) then
    Exit;

  W032DM.selM140.Edit;
  W032DM.selM140.FieldByName('DATADA').AsDateTime:=FRichiesta.DataDa;
  W032DM.selM140.FieldByName('DATAA').AsDateTime:=FRichiesta.DataA;
  W032DM.selM140.FieldByName('ORADA').AsString:=FRichiesta.OraDa;
  W032DM.selM140.FieldByName('ORAA').AsString:=FRichiesta.OraA;
  W032DM.selM140.Post;

  // effettua controlli bloccanti
  if not CtrlRimborsoOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if grdRimborsi.medpStato = msInsert then
    actInsRimborso
  else
    actModRimborso(FN);
end;

procedure TW032FRichiestaMissioni.actInsRimborso;
// effettua l'inserimento della voce di rimborso
var
  LIdRimbMax: Integer;
begin
  // aggiornamento dataset (cached updates)
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
  LIdRimbMax:=-1;
  if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
  begin
    // cerca il max ID_RIMBORSO per ID + INDENNITA_KM + CODICE
    if W032DM.selM150.RecordCount > 0 then
    begin
      W032DM.selM150.Filter:=Format('(ID = %s) and (INDENNITA_KM = ''%s'') and (CODICE = ''%s'')',
                                    [W032DM.selM140.FieldByName('ID').AsString,
                                     FRecordRimborso.IndennitaKm,
                                     FRecordRimborso.Codice]);
      W032DM.selM150.Filtered:=True;
      W032DM.selM150.First;
      while not W032DM.selM150.Eof do
      begin
        if W032DM.selM150.FieldByName('ID_RIMBORSO').AsInteger > LIdRimbMax then
          LIdRimbMax:=W032DM.selM150.FieldByName('ID_RIMBORSO').AsInteger;
        W032DM.selM150.Next;
      end;
      W032DM.selM150.Filtered:=False;
    end;
  end;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

  W032DM.selM150.Append;
  W032DM.selM150.FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
  W032DM.selM150.FieldByName('CODICE').AsString:=FRecordRimborso.Codice;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
  if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
  begin
    W032DM.selM150.FieldByName('DATA_RIMBORSO').AsDateTime:=FRecordRimborso.DataRimborso;
    W032DM.selM150.FieldByName('ID_RIMBORSO').AsInteger:=LIdRimbMax + 1;
  end;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
  W032DM.selM150.FieldByName('KMPERCORSI').AsFloat:=FRecordRimborso.KmPercorsi;
  W032DM.selM150.FieldByName('INDENNITA_KM').AsString:=FRecordRimborso.IndennitaKm;
  W032DM.selM150.FieldByName('COD_VALUTA').AsString:=FRecordRimborso.CodValuta;
  W032DM.selM150.FieldByName('RIMBORSO').AsFloat:=FRecordRimborso.Rimborso;
  W032DM.selM150.FieldByName('NOTE').AsString:=FRecordRimborso.Note;
  W032DM.selM150.FieldByName('FILE_ALLEGATO').AsString:=FRecordRimborso.FileAllegato;
  // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.ini
  if W032DM.GestTipoRimborso(FRecordRimborso.Codice) then
  begin
    W032DM.selM150.FieldByName('TIPORIMBORSO').AsString:=FRecordRimborso.TipoRimborso;
  end;
  // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.fine
  try
    W032DM.selM150.Post;
    grdRimborsi.medpCaricaCDS;
    if FMsgRimb <> '' then
    begin
      MsgBox.TextIsHTML:=True;
      MsgBox.MessageBox(FMsgRimb,INFORMA);
      MsgBox.TextIsHTML:=False;
    end;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(Format('Errore durante l''inserimento della voce di rimborso:'#13#10'%s (%s)',[E.Message,E.ClassName]),ESCLAMA);
      Exit;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.actModRimborso(const FN: String);
begin
  // aggiornamento dataset (cached updates)
  W032DM.selM150.Edit;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
  if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
    W032DM.selM150.FieldByName('DATA_RIMBORSO').AsDateTime:=FRecordRimborso.DataRimborso
  else
    W032DM.selM150.FieldByName('DATA_RIMBORSO').Value:=null;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
  W032DM.selM150.FieldByName('KMPERCORSI').AsFloat:=FRecordRimborso.KmPercorsi;
  W032DM.selM150.FieldByName('COD_VALUTA').AsString:=FRecordRimborso.CodValuta;
  W032DM.selM150.FieldByName('NOTE').AsString:=FRecordRimborso.Note;
  W032DM.selM150.FieldByName('FILE_ALLEGATO').AsString:=FRecordRimborso.FileAllegato;
  W032DM.selM150.FieldByName('RIMBORSO').AsFloat:=FRecordRimborso.Rimborso;
  // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.ini
  if W032DM.GestTipoRimborso(FRecordRimborso.Codice) then
  begin
    W032DM.selM150.FieldByName('TIPORIMBORSO').AsString:=FRecordRimborso.TipoRimborso;
  end;
  // TORINO_ZOOPROFILATTICO -commessa 2017/260 SVILUPPO #1.fine
  try
    W032DM.selM150.Post;
    grdRimborsi.medpCaricaCDS;
    if FMsgRimb <> '' then
    begin
      MsgBox.TextIsHTML:=True;
      MsgBox.MessageBox(FMsgRimb,INFORMA);
      MsgBox.TextIsHTML:=False;
    end;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(Format('Errore durante la modifica della voce di rimborso:'#13#10'%s (%s)',[E.Message,E.ClassName]),ESCLAMA);
      Exit;
    end;
  end;
end;

//######################################//

procedure TW032FRichiestaMissioni.edtCercaDelegatoSubmit(Sender: TObject);
begin
  btnCercaDelegatoClick(btnCercaDelegato);
end;

procedure TW032FRichiestaMissioni.chkDelegatoClick(Sender: TObject);
begin
  lblDelegato.Visible:=chkDelegato.Checked;
  edtCercaDelegato.Visible:=chkDelegato.Checked;
  if not edtCercaDelegato.Visible then
    edtCercaDelegato.Text:='';
  cmbDelegato.Visible:=False;
  cmbDelegato.ItemIndex:=0;
  btnCercaDelegato.Visible:=chkDelegato.Checked;
  if not chkDelegato.Checked then
  begin
    lblDelegato.Caption:='Cerca delegato per cognome / matricola:';
    lblDelegato.ForControl:=edtCercaDelegato;
    btnCercaDelegato.Caption:='Cerca delegato';
  end;
end;

procedure TW032FRichiestaMissioni.cmbCapitoloTrasfertaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbCapitoloTrasferta.ItemIndex = -1 then
    descCapitoloTrasferta.Caption:=''
  else
    descCapitoloTrasferta.Caption:=cmbCapitoloTrasferta.Items[cmbCapitoloTrasferta.ItemIndex].RowData[1];
end;

procedure TW032FRichiestaMissioni.cmbFlagDestinazioneChange(Sender: TObject);
var
  i: Integer;
begin
  if (Sender as TmeIWComboBox).ItemIndex = 2 then
  begin
    // estero
    cgpMotivEstero.Css:=FCssIniCgp;
    cgpIpotesiEstero.Css:=FCssIniCgp;
  end
  else
  begin
    // regione / fuori regione
    cgpMotivEstero.Css:='invisibile';
    cgpIpotesiEstero.Css:='invisibile';
    for i:=0 to cgpMotivEstero.Items.Count - 1 do
      cgpMotivEstero.IsChecked[i]:=False;
    for i:=0 to cgpIpotesiEstero.Items.Count - 1 do
      cgpIpotesiEstero.IsChecked[i]:=False;
  end;
end;
procedure TW032FRichiestaMissioni.cmbFlagDestinazioneAsyncChange(Sender: TObject; EventParams: TStringList);
var
  i: Integer;
begin
  if (Sender as TmeIWComboBox).ItemIndex = 2 then
  begin
    // estero
    cgpMotivEstero.Css:=FCssIniCgp;
    cgpIpotesiEstero.Css:=FCssIniCgp;
  end
  else
  begin
    // regione / fuori regione
    cgpMotivEstero.Css:='invisibile';
    cgpIpotesiEstero.Css:='invisibile';
    for i:=0 to cgpMotivEstero.Items.Count - 1 do
      cgpMotivEstero.IsChecked[i]:=False;
    for i:=0 to cgpIpotesiEstero.Items.Count - 1 do
      cgpIpotesiEstero.IsChecked[i]:=False;
  end;
  cgpIpotesiEstero.AsyncUpdate;
  cgpMotivEstero.AsyncUpdate;
end;

procedure TW032FRichiestaMissioni.cmbVoceAnticipoChange(Sender: TObject);
var
  LCodice,LTipoQuantita: String;
  V: double;
  i,c: Integer;
  LIWGrd: TmeIWGrid;
begin
  LCodice:=(Sender as TmeIWComboBox).Items.ValueFromIndex[(Sender as TmeIWComboBox).ItemIndex];

  if LCodice = '' then
    LTipoQuantita:=''
  else
    LTipoQuantita:=W032DM.selM020Anticipi.Lookup('CODICE',LCodice,'TIPO_QUANTITA');

  i:=grdAnticipi.medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);

  // quantità
  c:=grdAnticipi.medpIndexColonna('QUANTITA');
  LIWGrd:=(grdAnticipi.medpCompGriglia[i].CompColonne[c] as TmeIWGrid);
  if LTipoQuantita = '' then
  begin
    LIWGrd.Cell[0,0].Css:='invisibile';
    LIWGrd.Cell[0,1].Css:='invisibile';
    LIWGrd.Cell[0,2].Css:='invisibile';
    LIWGrd.Cell[0,3].Css:='invisibile';
  end
  else
  begin
    LIWGrd.Cell[0,0].Css:=IfThen(LTipoQuantita <> W032_TQ_FLAG,'','invisibile');
    LIWGrd.Cell[0,1].Css:=IfThen(LTipoQuantita = W032_TQ_FLAG,'','invisibile');
    LIWGrd.Cell[0,2].Css:=IfThen(LTipoQuantita = W032_TQ_QUANTITA,'','invisibile');
    LIWGrd.Cell[0,3].Css:=IfThen(LTipoQuantita = W032_TQ_IMPORTO,'','invisibile');
  end;

  V:=0;
  if LTipoQuantita <> '' then
  begin
    if grdAnticipi.medpStato = msEdit then
      V:=StrToFloat(grdAnticipi.medpValoreColonna(i,'QUANTITA'));
    if LTipoQuantita = W032_TQ_FLAG then
    begin
      // F = flag
      (grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption:='';
      (grdAnticipi.medpCompCella(i,c,1) as TmeIWCheckBox).Checked:=(V = 1)
    end
    else if LTipoQuantita = W032_TQ_QUANTITA then
    begin
      // Q = quantità
      (grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption:='n.';
      (grdAnticipi.medpCompCella(i,c,2) as TmeIWEdit).Text:=IntToStr(Trunc(V))
    end
    else if LTipoQuantita = W032_TQ_IMPORTO then
    begin
      // I = importo
      (grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption:='€';
      (grdAnticipi.medpCompCella(i,c,3) as TmeIWEdit).Text:=FloatToStr(V);
    end;
  end;
  c:=grdAnticipi.medpIndexColonna('C_PERC_ANTICIPO');
  (grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',LCodice,'PERC_ANTICIPO'));
  if (grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption <> '' then
    (grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption:=(grdAnticipi.medpCompCella(i,c,0) as TmeIWLabel).Caption + '%';
  (grdAnticipi.medpCompCella(i,'C_QTA_SPETTANTE',0) as TmeIWLabel).Caption:=W032DM.GetQuantitaSpettante(LTipoQuantita,V,StrToFloatDef(VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',LCodice,'PERC_ANTICIPO')),100));
  (grdAnticipi.medpCompCella(i,'C_NOTE_FISSE',0) as TmeIWLabel).Caption:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',LCodice,'NOTE_FISSE'));
end;

procedure TW032FRichiestaMissioni.edtQuantitaAnticipoAsyncChange(Sender: TObject; EventParams: TStringList);
var
  LCodice,LTipoQuantita: String;
  V: double;
  i: Integer;
begin
  i:=grdAnticipi.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);

  if grdAnticipi.medpStato = msEdit then
    LCodice:=grdAnticipi.medpValoreColonna(i,'CODICE')
  else
    LCodice:=(grdAnticipi.medpCompCella(i,'C_DESCRIZIONE',0) as TmeIWComboBox).Items.ValueFromIndex[(grdAnticipi.medpCompCella(i,'C_DESCRIZIONE',0) as TmeIWComboBox).ItemIndex];

  if LCodice = '' then
    LTipoQuantita:=''
  else
    LTipoQuantita:=W032DM.selM020Anticipi.Lookup('CODICE',LCodice,'TIPO_QUANTITA');

  V:=0;
  if LTipoQuantita = W032_TQ_IMPORTO then
    V:=StrToFloatDef((grdAnticipi.medpCompCella(i,'QUANTITA',3) as TmeIWEdit).Text,0);

  (grdAnticipi.medpCompCella(i,'C_QTA_SPETTANTE',0) as TmeIWLabel).Caption:=W032DM.GetQuantitaSpettante(LTipoQuantita,V,StrToFloatDef(VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',LCodice,'PERC_ANTICIPO')),100));
end;

procedure TW032FRichiestaMissioni.cmbVoceRimborsoChange(Sender: TObject);
var
  LCodice: String;
  LIndKm: Boolean;
  i,c: Integer;
  LIWEdtKm: TmeIWEdit;
  LIWEdtRimb: TmeIWEdit;
  LIWCmb: TmeIWComboBox;
  LIWCmbTipoRimb: TMedpIWMultiColumnComboBox;
begin
  LCodice:=(Sender as TmeIWComboBox).Items.Valuefromindex[(Sender as TmeIWComboBox).ItemIndex];
  LIndKm:=False;
  if LCodice <> '' then
    LIndKm:=W032DM.selM021.SearchRecord('CODICE',LCodice,[srFromBeginning]);

  i:=grdRimborsi.medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);

  // visibilità campo "km percorsi"
  c:=grdRimborsi.medpIndexColonna('KMPERCORSI');
  LIWEdtKm:=(grdRimborsi.medpCompGriglia[i].CompColonne[c] as TmeIWEdit);
  if LCodice = '' then
    LIWEdtKm.Css:='invisibile'
  else
    LIWEdtKm.Css:=IfThen(LIndKm,'width5chr','invisibile');

  // visibilità campo "valuta"
  c:=grdRimborsi.medpIndexColonna('COD_VALUTA');
  LIWCmb:=(grdRimborsi.medpCompGriglia[i].CompColonne[c] as TmeIWComboBox);
  if LCodice = '' then
    LIWCmb.Css:='invisibile'
  else
    LIWCmb.Css:=IfThen(LIndKm,'invisibile','width15chr');

  // visibilità campo "rimborso"
  c:=grdRimborsi.medpIndexColonna('RIMBORSO');
  LIWEdtRimb:=(grdRimborsi.medpCompGriglia[i].CompColonne[c] as TmeIWEdit);
  if LCodice = '' then
    LIWEdtRimb.Css:='invisibile'
  else
    LIWEdtRimb.Css:=IfThen(LIndKm,'invisibile','width5chr');

  // visibilità campo "tipo rimborso"
  if W032DM.GestTipoRimborso then
  begin
    c:=grdRimborsi.medpIndexColonna('TIPORIMBORSO');
    LIWCmbTipoRimb:=(grdRimborsi.medpCompGriglia[i].CompColonne[c] as TMedpIWMultiColumnComboBox);
    if W032DM.GestTipoRimborso(LCodice) then
    begin
      LIWCmbTipoRimb.Css:=C190ImpostaCssInvisibile(LIWCmbTipoRimb.Css,True);
    end
    else
    begin
      LIWCmbTipoRimb.Css:=C190ImpostaCssInvisibile(LIWCmbTipoRimb.Css,False);
    end;
  end;

  if LCodice <> '' then
  begin
    if LIndKm then
      ActiveControl:=LIWEdtKm
    else
      ActiveControl:=LIWEdtRimb;
  end;
end;

procedure TW032FRichiestaMissioni.btnCercaDelegatoClick(Sender: TObject);
var
  LCerca: Boolean;
begin
  LCerca:=btnCercaDelegato.Caption = 'Cerca delegato';
  if LCerca then
  begin
    if Trim(edtCercaDelegato.Text) = '' then
    begin
      MsgBox.MessageBox('Indicare la matricola del delegato, oppure il cognome o parte di esso',INFORMA);
      ActiveControl:=edtCercaDelegato;
      Exit;
    end;
    cmbDelegato.Items.Clear;

    W032DM.selNomeDelegato.Close;
    W032DM.selNomeDelegato.Filter:='';
    W032DM.selNomeDelegato.Filtered:=False;
    W032DM.selNomeDelegato.SetVariable('MATRICOLA',IfThen(Sender = nil,'S','N'));
    W032DM.selNomeDelegato.SetVariable('VALORE',edtCercaDelegato.Text);
    if not WR000DM.Responsabile then
    begin
      W032DM.selNomeDelegato.Filter:=Format('PROGRESSIVO <> %d',[selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger]);
      W032DM.selNomeDelegato.Filtered:=True;
    end;
    W032DM.selNomeDelegato.Open;
    if W032DM.selNomeDelegato.RecordCount = 0 then
    begin
      MsgBox.MessageBox('Nessun dipendente trovato',INFORMA);
      ActiveControl:=edtCercaDelegato;
      Exit;
    end
    else
    begin
      cmbDelegato.Items.Add('Selezionare il delegato');
      while not W032DM.selNomeDelegato.Eof do
      begin
        cmbDelegato.Items.Add(Format('%-8s %s %s',[W032DM.selNomeDelegato.FieldByName('MATRICOLA').AsString,
                                                   W032DM.selNomeDelegato.FieldByName('COGNOME').AsString,
                                                   W032DM.selNomeDelegato.FieldByName('NOME').AsString]));
        W032DM.selNomeDelegato.Next;
      end;
      cmbDelegato.ItemIndex:=IfThen(W032DM.selNomeDelegato.RecordCount = 1,1,0);
    end;
    W032DM.selNomeDelegato.Close;
  end;

  // switch funzione pulsante
  lblDelegato.Caption:=IfThen(LCerca,'Nominativo:','Cerca delegato per cognome / matricola:');
  if LCerca then
    lblDelegato.ForControl:=cmbDelegato
  else
    lblDelegato.ForControl:=edtCercaDelegato;
  edtCercaDelegato.Visible:=not LCerca;
  cmbDelegato.Visible:=LCerca;
  btnCercaDelegato.Caption:=IfThen(LCerca,'Pulisci','Cerca delegato');
end;

//#########################//
//###   AUTORIZZAZIONE  ###//
//#########################//

procedure TW032FRichiestaMissioni.chkAutorizzazioneClick(Sender: TObject);
begin
  FAutorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  FAutorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  FAutorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // verifica presenza record
  W032DM.selM140.Refresh;
  if not W032DM.selM140.SearchRecord('ROWID',FAutorizza.RowId,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('Attenzione! La richiesta da autorizzare non è più disponibile!',INFORMA);
    Exit;
  end;
  DBGridColumnClick(Sender,FAutorizza.Rowid);
  AutorizzazioneOK;
end;

procedure TW032FRichiestaMissioni.GestioneFasi(const PFasePrima, PFaseDopo: Integer; const PRiapriMissione: Boolean = False);
// procedura eseguita a seguito di un'autorizzazione per la gestione delle fasi
// a partire dalla fase di partenza fino a quella finale
// parametri
//   PFasePrima:
//     fase iniziale
//   PFaseDopo
//     fase finale
//   PRiapriMissione
//     indicare True nel caso particolare di richiamo dalla funzione di riapertura missione
//     (attiva solo per effetto di parametrizzazione a livello aziendale)
var
  F,Ini,IdRich: Integer;
  Avanzamento: Boolean;
  function Continua(const F: Integer): Boolean;
  begin
    if Avanzamento then
      Result:=F <= PFaseDopo
    else
      Result:=F >= PFaseDopo;
  end;
begin
  Avanzamento:=PFasePrima < PFaseDopo;
  Ini:=PFasePrima + IfThen(Avanzamento,1,-1);
  IdRich:=W032DM.selM140.FieldByName('ID').AsInteger;
  RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.Inizio %d - %d',[IdRich,PFasePrima,PFaseDopo]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
  F:=Ini;
  try
    while Continua(F) do
    begin
      RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.Fase %d',[IdRich,F]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
      case F of
        M140FASE_AUTORIZZAZIONE:
          // fase 1
          // missioni e anticipi autorizzati e non più modificabili; non si possono ancora importare su M040
          begin
            // nessuna operazione
          end;
        M140FASE_AGVIAGGIO:
          // fase 2
          // missioni e anticipi visibili alla fase di importazione (cassa economale)
          begin
            if Avanzamento then
            begin
              // nessuna operazione
            end
            else
            begin
              // cancella missione da M040
              RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.delM040',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
              W032DM.delM040.SetVariable('ANNULLAMENTO','N');
              W032DM.delM040.SetVariable('ID',IdRich);
              W032DM.delM040.Execute;
              // cancella anticipi da M060
              W032DM.delM060.SetVariable('ID',IdRich);
              W032DM.delM060.Execute;
            end;
          end;
        M140FASE_CASSA:
          // fase 3
          begin
            if Avanzamento then
            begin
              // (TORINO_REGIONE: normalmente lo fa applicativo cassa economale del csi)
              // inserimento missione su M040
              RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.M040P_CARICA_MISSIONE_DAITER',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
              W032DM.M040P_CARICA_MISSIONE_DAITER.SetVariable('ID',IdRich);
              W032DM.M040P_CARICA_MISSIONE_DAITER.Execute;
              // inserimento anticipi su M060
              RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.M060P_CARICA_ANTICIPI_DAITER',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
              W032DM.M060P_CARICA_ANTICIPI_DAITER.SetVariable('ID',IdRich);
              W032DM.M060P_CARICA_ANTICIPI_DAITER.Execute;
            end
            else
            begin
              // annulla stato dei rimborsi richiesti su M150 (solo quelli con stato <> 'I' (inserito))
              W032DM.updM150.SetVariable('ID',IdRich);
              W032DM.updM150.SetVariable('SETVALORI','STATO = null');
              W032DM.updM150.Execute;
              // riporta la missione in stato 'S' (sospeso) se era ancora 'D' (da liquidare)
              W032DM.updM040Stato.SetVariable('ID',IdRich);
              W032DM.updM040Stato.Execute;
            end;
          end;
        M140FASE_RIMBORSI:
          // fase 4
          // rimborsi già autorizzati ma in attesa di validazione da uff.missioni
          begin
            if Avanzamento then
            begin
              // imposta stato dei rimborsi richiesti = 'A' (autorizzato) su M150 (solo quelli con stato <> 'I' (importato in M050))
              W032DM.updM150.SetVariable('ID',IdRich);
              W032DM.updM150.SetVariable('SETVALORI','STATO = ''A''');
              W032DM.updM150.Execute;
            end
            else
            begin
              // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
              // valuta se si tratta di una riapertura della richiesta
              if PRiapriMissione then
              begin
                // nessuna operazione
              end
              else
              // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
              begin
                // cancella i rimborsi da M050 / M052
                // cancella i servizi attivi da M043
                // cancella eventuali giustificativi legati alla richiesta
                // riporta la missione in stato Sospeso
                RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.delRimborsi',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
                W032DM.delRimborsi.SetVariable('ID',IdRich);
                W032DM.delRimborsi.Execute;
              end;
            end;
          end;
        M140FASE_CHIUSURA:
          // fase 5
          // rimborsi validati da uff.missioni importati su M050
          begin
            if Avanzamento then
            begin
              if FImportazioneRimborsi then
              begin
                // imposta stato dei rimborsi richiesti = 'S' su M150 in modo che la M050P_CARICA_RIMBORSI_DAITER possa importarli
                W032DM.updM150.SetVariable('ID',IdRich);
                W032DM.updM150.SetVariable('SETVALORI','STATO = ''S'''); // 'S' = Pronto per l'importazione in M050
                W032DM.updM150.Execute;
              end;
              // inserimento rimborsi su:
              // - M050
              // - M051 (dettaglio)
              // - M052 (indennità km)
              // inserimento servizi attivi su M043
              RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.M050P_CARICA_RIMBORSI_DAITER',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
              W032DM.M050P_CARICA_RIMBORSI_DAITER.SetVariable('ID',IdRich);
              W032DM.M050P_CARICA_RIMBORSI_DAITER.Execute;
            end
            else
            begin
              // non previsto
            end;
          end;
      end;

      if Avanzamento then
        inc(F)
      else
        dec(F);
    end;
  finally
    SessioneOracle.Commit;
  end;
end;

procedure TW032FRichiestaMissioni.AutorizzazioneOK;
var
  LAut,LResp,LNewTipoRich,LMsgErr: String;
  LFasePrima,LFaseDopo:Integer;
  LFaseRimborsi: Boolean;
  procedure AnnullaAutorizzazioni(F:Integer);
  var i:Integer;
  begin
    for i:=C018.LivelliFase[F].Min to C018.LivelliFase[F].Max do
    begin
      C018.SetStato('',i);
      C018.SetAutorizzAutomatica('',i);
    end;
  end;
begin
  LAut:='';
  LResp:='';

  // imposta i dati di autorizzazione
  W032DM.selM140.Refresh; // NON sostituire con Refreshrecord
  if not W032DM.selM140.SearchRecord('ROWID',FAutorizza.Rowid,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('Attenzione! La richiesta da autorizzare è stata modificata nel frattempo.' + CRLF +
                      'Verificarne nuovamente i dati prima di procedere!',INFORMA);
    Exit;
  end;
  LResp:=Parametri.Operatore;
  if FAutorizza.Checked and (FAutorizza.Caption = 'Si') then
  begin
    // autorizzazione SI
    LAut:=C018SI;

    // in caso di autorizzazione viene eseguita la function oracle personalizzata M140F_CHECKRICHIESTA
    // se il risultato non è nullo, significa che sono presenti errori (non bloccanti):
    // in questo caso visualizzare il messaggio a video un msgbox
    RegistraMsg.InserisciMessaggio('I',Format('ID = %d; AutorizzazioneOK.M140F_CHECKRICHIESTA non bloccante',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

    try
      W032DM.M140F_CHECKRICHIESTA.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      W032DM.M140F_CHECKRICHIESTA.SetVariable('LIVELLO',W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);
      W032DM.M140F_CHECKRICHIESTA.SetVariable('FASE',W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger);
      W032DM.M140F_CHECKRICHIESTA.SetVariable('CHIUSURA','N');
      W032DM.M140F_CHECKRICHIESTA.Execute;
      LMsgErr:=VarToStr(W032DM.M140F_CHECKRICHIESTA.GetVariable('RESULT'));
    except
      on E: Exception do
      begin
        LMsgErr:=Format('%s (%s)',[E.Message,E.ClassName]);
      end;
    end;
    if LMsgErr <> '' then
    begin
      LMsgErr:=Format('Avviso:'#13#10'%s',[LMsgErr]);
      MsgBox.AddMessage(LMsgErr);
    end;
  end
  else if FAutorizza.Checked and (FAutorizza.Caption = 'No') then
  begin
    // autorizzazione NO
    LAut:=C018NO;
  end
  else if not FAutorizza.Checked then
  begin
    // autorizzazione non impostata
    LAut:='';
  end;

  // salva i dati di autorizzazione
  try
    C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;
    C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
    LFasePrima:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;

    RegistraMsg.InserisciMessaggio('I',Format('ID = %d; AutorizzazioneOK.InsAutorizzazione',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

    // se il responsabile dei rimborsi nega la richiesta
    // lo stato deve essere impostato a null
    LFaseRimborsi:=(W032DM.selM140.FieldByName('TIPO_RICHIESTA').AsString = M140TR_4) and (LFasePrima = M140FASE_CASSA);
    LFaseRimborsi:=LFaseRimborsi or ((LAut = C018NO) and (W032DM.selM140.FieldByName('TIPO_RICHIESTA').AsString = M140TR_5) and (LFasePrima = M140FASE_RIMBORSI));
    //Se livello facoltativo --> no FaseRimborsi
    if LFaseRimborsi then
    begin
      if not C018.LivelloObbligatorio[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger] then
        LFaseRimborsi:=False
      else
      begin
        //Se livello obbligatorio e Aut = C018SI e livello non è l'ultimo della fase --> no FaseRimborsi
      if (LAut = C018SI) and
         (C018.FaseLivello[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger] = M140FASE_RIMBORSI) and
         (W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger < C018.LivelliObblFase[M140FASE_RIMBORSI].Max) then
        LFaseRimborsi:=False;
      end;
    end;
    if LFaseRimborsi and (LAut = C018NO) then
      LAut:='';
    C018.InsAutorizzazione(W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,LAut,LResp,'','');
    LFaseDopo:=C018.FaseCorrente;

    if C018.MessaggioOperazione <> '' then
      raise Exception.Create(C018.MessaggioOperazione)
    else
    begin
      //Se la fase 5 è definita nei livelli di autorizzazione, allora si importano i rimborsi da M150 a M050 flaggando M150.STATO = 'S'
      FImportazioneRimborsi:=LFaseDopo = M140FASE_CHIUSURA;
      GestioneFasi(LFasePrima,LFaseDopo);
      FImportazioneRimborsi:=False;
      if LFaseRimborsi then
      begin
        // attualmente tipo richiesta = M140TR_4
        // se autorizzazione SI -> tipo richiesta avanza a M140TR_5
        // altrimenti -> riporta tipo_richiesta a M140TR_0, in modo che il dipendente possa modificare i rimborsi
        LNewTipoRich:=IfThen(LAut = C018SI,M140TR_5,M140TR_0);
        C018.SetTipoRichiesta(LNewTipoRich);
        //Se torno alla modifica dei rimborsi resetto tutte le autorizzazioni per i livelli relativi alla fase M140FASE_RIMBORSI
        if LNewTipoRich = M140TR_0 then
          AnnullaAutorizzazioni(M140FASE_RIMBORSI)
        else if (LAut = C018SI) and (LFaseDopo = M140FASE_RIMBORSI) and (LNewTipoRich = M140TR_5) then
          GestioneFasi(M140FASE_RIMBORSI,M140FASE_CHIUSURA);
      end;
      SessioneOracle.Commit;
    end;
  except
    on E: Exception do
    begin
      SessioneOracle.Commit;
      MsgBox.AddMessage('Impostazione dell''autorizzazione fallita!' + CRLF +
                        'Errore: ' + E.Message + CRLF +
                        IfThen(E.ClassName <> 'Exception',#13#10'Tipo: ' + E.ClassName),mtWarning);
    end;
  end;
  MsgBox.ShowMessages;
  VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.TrasformaComponentiAut(const FN: String);
var
  LDaTestoAControlli:Boolean;
  i,c:Integer;
  LIWC: TIWCustomControl;
  LIWGrd: TmeIWGrid;
  LIWLbl: TIWCustomControl;
  LIWRgpMezzoProprio: TmeTIWAdvRadioGroup;
  LDatoPers: TDatoPersonalizzato;
  LDatiMezzo: TDatiMezzo;
  LAbilitaModifica: Boolean;
  LFaseLiv: Integer;
  LFasiAbil: string;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  c:=grdRichieste.medpIndexColonna('DBG_COMANDI');

  LDaTestoAControlli:=grdRichieste.medpStato <> msBrowse;

  // abilitazione checbox di autorizzazione
  if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
  begin
    (grdRichieste.medpCompCella(i,0,0) as TmeIWCheckBox).Enabled:=not LDaTestoAControlli;
    (grdRichieste.medpCompCella(i,0,1) as TmeIWCheckBox).Enabled:=not LDaTestoAControlli;
  end;

  // gestione icone comandi
  LIWGrd:=(grdRichieste.medpCompGriglia[i].CompColonne[c] as TmeIWGrid);
  LIWGrd.Cell[0,0].Css:=IfThen(LDaTestoAControlli,'invisibile','align_left');
  LIWGrd.Cell[0,1].Css:=IfThen(LDaTestoAControlli,'align_left','invisibile');
  LIWGrd.Cell[0,2].Css:=IfThen(LDaTestoAControlli,'align_right','invisibile');

  // radiogroup mezzo proprio
  LIWRgpMezzoProprio:=(Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup);

  // abilitazioni
  if LDaTestoAControlli then
  begin
    // tabella dei dati personalizzati
    for i:=0 to grdDati.RowCount - 1 do
    begin
      // abilitazione del componente
      LIWLbl:=grdDati.Cell[i,0].Control;
      LIWC:=grdDati.Cell[i,1].Control;
      if (LIWLbl <> nil) and (LIWC <> nil) then
      begin
        if LIWC is TmeIWEdit then
          LDatoPers:=(TmeIWEdit(LIWC).medpTag as TDatoPersonalizzato)
        else if LIWC is TmeIWMemo then
          LDatoPers:=(TmeIWMemo(LIWC).medpTag as TDatoPersonalizzato)
        else if LIWC is TMedpIWMultiColumnComboBox then
          LDatoPers:=(TMedpIWMultiColumnComboBox(LIWC).medpTag as TDatoPersonalizzato)
        else
          LDatoPers:=nil;

        // abilitazione del singolo componente
        if LDatoPers <> nil then
        begin
          AbilitazioneComponente(LIWLbl,LDatoPers.AbilitaModifica);
          AbilitazioneComponente(LIWC,LDatoPers.AbilitaModifica);
        end;
      end;
    end;

    // fase corrispondente al livello corrente
    LFaseLiv:=C018.FaseLivello[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger];

    //Gestione abilitazione "CORRESPONSIONE_SPESE" "RESPONSABILE"
    if LIWRgpMezzoProprio <> nil then
    begin
      LDatiMezzo:=(LIWRgpMezzoProprio.medpTag as TDatiMezzo);
      LAbilitaModifica:=R180In(LFaseLiv.ToString,LDatiMezzo.FasiCompetenza.Split([',']));
      AbilitazioneComponente(LIWRgpMezzoProprio,LAbilitaModifica);
    end;

    //+++.ini
    // gestione abilitazione tab anticipi
    FModificaAnticipiAut:=False;
    W032DM.selM020Anticipi.First;
    while not W032DM.selM020Anticipi.Eof do
    begin
      LFasiAbil:=W032DM.selM020Anticipi.FieldByName('FASI_COMPETENZA').AsString;
      if (LFasiAbil <> '') and R180In(LFaseLiv.ToString,LFasiAbil.Split([','])) then
      begin
        FModificaAnticipiAut:=True;
        Break;
      end;
      W032DM.selM020Anticipi.Next;
    end;

    // tab anticipi
    if FModificaAnticipiAut then
    begin
      rgAnticipi.medpAbilitaComponenti;
      grdAnticipi.medpVisualizzaComandi;
      rgpAccreditoClick(rgpAccredito);
    end;
    //+++.fine
  end
  else
  begin
    // tabella dei dati personalizzati
    AbilitazioneComponente(grdDati,False);

    // radiogroup mezzo proprio
    AbilitazioneComponente(LIWRgpMezzoProprio,False);

    // tab anticipi
    rgAnticipi.medpDisabilitaComponenti;
    grdAnticipi.medpNascondiComandi;
  end;
end;

// modifiche ai dati in fase di autorizzazione

function TW032FRichiestaMissioni.ControlliAutOK(const FN: String): Boolean;
// effettua controlli sui dati modificabili in fase di autorizzazione
var
  LResCtrl: TResCtrl;
begin
  Result:=False;

  // controllo dati personalizzati
  LResCtrl:=CtrlSalvaDatiPersonalizzati;
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,INFORMA);
    Exit;
  end;

  //+++.ini
  // effettua controlli sugli anticipi e li conferma
  if FModificaAnticipiAut then
  begin
    LResCtrl:=ControllaConfermaAnticipi(FN);
    if not LResCtrl.Ok then
    begin
      if LResCtrl.Messaggio <> '' then
        MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
      Exit;
    end;
  end;
  //+++.fine

  Result:=True;
end;

procedure TW032FRichiestaMissioni.actModDatiAut(const FN: String);
// conferma la modifica ai dati in fase di autorizzazione
var
  LId: Integer;
  LFaseLiv: Integer;
  LCodice: String;
  LValore: String;
  IWRgp: TmeTIWAdvRadioGroup;
begin
  LId:=W032DM.selM140.FieldByName('ID').AsInteger;
  LFaseLiv:=C018.FaseLivello[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger];

  if FEsistonoDatiPersonalizzati then
  begin
    // filtro dataset selM025 per estrarre i codici per cui la categoria è visibile e modificabile
    W032DM.selM025.Filtered:=False;
    W032DM.selM025.Filter:=Format('(%s >= MIN_FASE_VISIBILE_CAT) and (%s <= MAX_FASE_VISIBILE_CAT) and (%s >= MIN_FASE_MODIFICA_CAT) and (%s <= MAX_FASE_MODIFICA_CAT)',[LFaseLiv.ToString,LFaseLiv.ToString,LFaseLiv.ToString,LFaseLiv.ToString]);
    W032DM.selM025.Filtered:=True;
    try
      for LCodice in FRichiesta.DatiPers.Keys do
      begin
        // se il codice è tra quelli modificabili gestisce i dati su M175
        if W032DM.selM025.SearchRecord('CODICE',LCodice,[srFromBeginning]) then
        begin
          LValore:=FRichiesta.DatiPers[LCodice].ValoreStr;

          if W032DM.selM175.SearchRecord('CODICE',LCodice,[srFromBeginning]) then
          begin
            // record presente su M175
            //   se il valore è vuoto elimina il record
            //   altrimenti aggiorna il valore
            if LValore = '' then
            begin
              // cancellazione dato
              W032DM.selM175.Delete;
            end
            else
            begin
              // update dato
              W032DM.selM175.Edit;
              W032DM.selM175.FieldByName('VALORE').AsString:=LValore;
              W032DM.selM175.Post;
            end;
          end
          else
          begin
            // record non presente su M175
            //   se il valore è vuoto non effettua nessuna operazione
            //   altrimenti inserisce un nuovo record
            if LValore = '' then
            begin
              // nessuna operazione necessaria
            end
            else
            begin
              // inserimento nuovo dato
              W032DM.selM175.Append;
              W032DM.selM175.FieldByName('ID').AsInteger:=LId;
              W032DM.selM175.FieldByName('CODICE').AsString:=LCodice;
              W032DM.selM175.FieldByName('VALORE').AsString:=LValore;
              W032DM.selM175.Post;
            end;
          end;
        end;
      end;
    finally
      W032DM.selM025.Filtered:=False;
      W032DM.selM025.Filter:='';
    end;
  end;

  IWRgp:=Self.FindComponent('rgpMezzoProprio') as TmeTIWAdvRadioGroup;
  if IWRgp.Enabled then
  begin
    if W032DM.selM170.SearchRecord('CODICE','AUTO',[srFromBeginning]) then
    begin
      W032DM.selM170.Edit;
      W032DM.selM170.FieldByName('CORRESPONSIONE_SPESE').AsString:=IfThen(IWRgp.ItemIndex = 0,'S','N');
      W032DM.selM170.Post;
    end;
  end;

  // tabella anticipi
  if FModificaAnticipiAut then
  begin
    // aggiorna sulla richiesta i dati legati agli anticipi
    if (tabMissioni.Tabs[rgAnticipi].Enabled) and (rgpAccredito.Enabled) then
    begin
      W032DM.selM140.Edit;
      if rgpAccredito.ItemIndex = 0 then
      begin
        W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString:=W032_TIPO_ACCREDITO_CC;
        W032DM.selM140.FieldByName('DELEGATO').AsString:='';
      end
      else if rgpAccredito.ItemIndex = 1 then
      begin
        W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString:=W032_TIPO_ACCREDITO_AB;
        if chkDelegato.Checked then
          W032DM.selM140.FieldByName('DELEGATO').AsString:=FRichiesta.Delegato;
      end;
      W032DM.selM140.Post;

      // è necessario riaprire il dataset delle richieste per ricalcolare il percorso
      W032DM.selM140.Close;
      W032DM.selM140.Open;
    end;

    // applica le modifiche su db
    if W032DM.selM160.UpdatesPending then
      SessioneOracle.ApplyUpdates([W032DM.selM160],True);
  end;

  FModificaAnticipiAut:=False;

  // rilegge i dati
  grdRichieste.medpCaricaCDS;

  // posizionamento su riga appena modificata
  DBGridColumnClick(nil,LId.ToString);
end;

procedure TW032FRichiestaMissioni.imgModificaDatiAutClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // verifica presenza richiesta
  W032DM.selM140.Refresh;
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('La richiesta da modificare non è più disponibile!',INFORMA,'Richiesta eliminata');
    Exit;
  end;

  // porta la riga in modifica: trasforma i componenti
  DBGridColumnClick(Sender,FN);
  grdRichieste.medpStato:=msEdit;
  grdRichieste.medpBrowse:=False;
  TrasformaComponentiAut(FN);
end;

procedure TW032FRichiestaMissioni.imgConfermaDatiAutClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if (grdRichieste.medpStato = msEdit) then
  begin
    // se il record non esiste -> errore
    if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      grdRichieste.medpStato:=msBrowse;
      TrasformaComponenti(FN);
      MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:'#13#10'potrebbe essere stata eliminata nel frattempo.',INFORMA);
      Exit;
    end;
  end;

  // effettua controlli bloccanti sui dati personalizzati
  if not ControlliAutOK(FN) then
    Exit;

  // conferma modifica dati
  actModDatiAut(FN);
end;

procedure TW032FRichiestaMissioni.imgAnnullaDatiAutClick(Sender: TObject);
var
  LOldId: Integer;
begin
  // salva id richiesta per successivo riposizionamento
  LOldId:=W032DM.selM140.FieldByName('ID').AsInteger;

  //+++.ini
  // se ci sono operazioni pendenti, annulla eventuali modifiche non salvate
  if grdRichieste.medpStato <> msBrowse then
  begin
    // voci di anticipo
    if W032DM.selM160.UpdatesPending then
      W032DM.selM160.CancelUpdates;
  end;

  FModificaAnticipiAut:=False;
  //+++.fine

  // aggiorna visualizzazione
  VisualizzaDipendenteCorrente;

  // posizionamento sulla richiesta
  DBGridColumnClick(nil,LOldId.ToString);
end;

procedure TW032FRichiestaMissioni.DistruggiOggetti;
begin
  FreeAndNil(FRichiesta.DatiPers);
  FreeAndNil(FQSCodRegole);
  FreeAndNil(W032DM);
  FreeAndNil(FListaAnticipi);
  FreeAndNil(FListaAnticipiAbilFase); //+++
  FreeAndNil(FListaRimborsiPasto);
  FreeAndNil(FListaRimborsi);
  FreeAndNil(FListaValute);
  FreeAndNil(FListaTipiRegistrazione);
  inherited;
end;

end.
