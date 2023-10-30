unit W010URichiestaAssenze;

interface

uses
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, W000UMessaggi,
  A004UGiustifAssPresMW, W010URichiestaAssenzeDM, W010UCalcoloCompetenzeFM,
  W010UCancPeriodoFM, R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb, R600, USelT004,
  B021UUtils, B021UWebSvcClientDtM,
  IWApplication, IWAppForm, SysUtils, Classes,
  Controls, IWCompLabel, DatiBloccati,
  IWControl, IWHTMLControls, IWCompListbox, IWCompEdit,
  Oracle, OracleData, IWCompCheckbox, Variants, IWBaseLayoutComponent,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, StrUtils,
  Forms, IWVCLBaseContainer, IWContainer, DB, IWCompMemo,
  RpCon, RpConDS, RpSystem, RpDefine, RpRave, RVCsStd, RVData,
  RvDirectDataView, RpRender, RpRenderPDF, RVClass, RVProj, DBClient,
  Math, IWDBGrids, medpIWDBGrid, meIWComboBox, meIWLabel, meIWImageFile,
  meIWCheckBox, meIWEdit, meIWMemo, meIWGrid, meIWButton, meIWRadioGroup,
  IWCompExtCtrls, IWCompGrids, IWCompButton, Menus, IWVCLComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, meIWLink,
  W005UCartellinoFM, medpIWImageButton, IWCompRadioButton, meIWRadioButton, medpIWMultiColumnComboBox, IWCompJQueryWidget;

type
  TValore = class(TObject)
  private
    FValore: String;
  public
    constructor Create(const PValore: String);
    property Valore: String read FValore;
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  TW010FRichiestaAssenze = class(TR013FIterBase)
    cdsAutorizzazione: TClientDataSet;
    cdsAutorizzazionePROGRESSIVO: TIntegerField;
    cdsAutorizzazioneNOMINATIVO: TStringField;
    cdsAutorizzazioneMATRICOLA: TStringField;
    cdsAutorizzazioneSESSO: TStringField;
    cdsAutorizzazioneCAUSALE: TStringField;
    cdsAutorizzazioneD_CAUSALE: TStringField;
    cdsAutorizzazioneTIPOGIUST: TStringField;
    cdsAutorizzazioneDAL: TDateField;
    cdsAutorizzazioneAL: TDateField;
    cdsAutorizzazioneNUMEROORE: TStringField;
    cdsAutorizzazioneAORE: TStringField;
    cdsAutorizzazioneRESPONSABILE: TStringField;
    cdsAutorizzazioneD_RESPONSABILE: TStringField;
    cdsAutorizzazioneC_OGGETTO: TStringField;
    cdsAutorizzazioneC_DATA_FIRMA: TStringField;
    cdsAutorizzazioneC_TESTO: TStringField;
    dsrT050: TDataSource;
    cdsT050: TClientDataSet;
    cmbAccorpCausali: TmeIWComboBox;
    lblLegenda1: TmeIWLabel;
    lblLegenda2: TmeIWLabel;
    chkNoteIns: TmeIWCheckBox;
    edtOre: TmeIWEdit;
    edtAOre: TmeIWEdit;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    lblDal: TmeIWLabel;
    lblAl: TmeIWLabel;
    memNoteIns: TmeIWMemo;
    lblRiepAl: TmeIWLabel;
    edtRiepAl: TmeIWEdit;
    lblCausale: TmeIWLabel;
    btnInserisci: TmeIWButton;
    btnNascondiRiepilogo: TmeIWButton;
    btnVisualizzaRiepilogo: TmeIWButton;
    grdRiepilogo: TmeIWGrid;
    lblGiustificativo: TmeIWLabel;
    cmbCausaliDisponibili: TmeIWComboBox;
    lblFamiliari: TmeIWLabel;
    cmbFamiliari: TmeIWComboBox;
    rgpTipo: TmeIWRadioGroup;
    lblLegenda3: TmeIWLabel;
    btnImporta: TmeIWButton;
    edtPeriodoDalAl: TmeIWEdit;
    lblPeriodoDalAl: TmeIWLabel;
    btnCartellino: TmeIWImageFile;
    cmbMotivazione: TmeIWComboBox;
    lblMotivazione: TmeIWLabel;
    lblNote: TmeIWLabel;
    edtNote: TmeIWEdit;
    lblFiltroCausale: TmeIWLabel;
    cmbFCausale: TMedpIWMultiColumnComboBox;
    lblFCausaleDesc: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnInserisciClick(Sender: TObject);
    procedure btnVisualizzaRiepilogoClick(Sender: TObject);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure chkAutorizzazioneAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnStampaRicevutaClick(Sender: TObject);
    procedure cdsAutorizzazioneCalcFields(DataSet: TDataSet);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure chkNoteInsAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnAnnullaClick(Sender: TObject);
    procedure grdRichiesteBeforeCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbAccorpCausaliChange(Sender: TObject);
    procedure btnNascondiRiepilogoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure btnImportaClick(Sender: TObject);
    procedure edtPeriodoDalAlAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCartellinoClick(Sender: TObject);
    procedure cmbCausaliDisponibiliAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDalAlAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    R600DtM:TR600DtM1;
    ListaCausali,ListaFamiliari:TStringList;
    Giustif: TGiustificativo;
    //GiorniRichiesti,GiorniIgnorati:Integer;
    //TotCompetenze:Real;
    Autorizza: TAutorizza;
    ShowAvvertimenti,
    AutorizzazioniDaConfermare: Boolean;
    FDatiGiust: TDatiRichiestaGiust;
    Operazione: String;
    //ElencoCausali,CausaleOriginale: String;
    StileCella1,StileCella2: String;
    AnomaliaAss: Byte; // cfr. R600.AnomaliaAssenze
    //rave report
    rvSystem:TRVSystem;
    rvDWDettaglio:TRaveDataView;
    rvProject:TRVProject;
    rvPage:TRaveComponent;
    rvRenderPDF:TRvRenderPDF;
    connDettaglio:TRVDataSetConnection;
    ScalaStampa:Real;
    W005FM: TW005FCartellinoFM;
    W010CalcoloCompetenzeFM: TW010FCalcoloCompetenzeFM;
    W010CancPeriodoFM: TW010FCancPeriodoFM;
    B021FWebSvcClientDtM:TB021FWebSvcClientDtM;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
    CallBackNameCausaleChange: String;
    GestioneMotivazioniCausali: Boolean;
    ListaMotivazioni: TStringList;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
    procedure GetAccorpamentiDisponibili;
    procedure GetCausaliDisponibili(pMantieniValore: Boolean = False);
    procedure GetFamiliari(CodCausale:String);
    procedure CreaR600;
    procedure RichiestaDaDefInConteggi(Includi: Boolean);
    procedure actIns0;
    procedure actIns1;
    procedure actIns2;
    procedure actInsRichiesta;
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    procedure actDefRichiesta;
    procedure actCtrlRipristinoRich;
    procedure AutorizzazioneOK;
    procedure TrasformaComponenti(const FN:String; DaTestoAControlli:Boolean);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgRevocaClick(Sender: TObject);
    procedure actInsRevoca(const PTipoRichiesta: String; const PDal, PAl: TDateTime);
    procedure imgCancPeriodoClick(Sender: TObject);
    procedure imgDefinisciClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaDefClick(Sender: TObject);
    procedure imgIterClick(Sender: TObject);
    procedure imgAllegClick(Sender: TObject); // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2
    procedure imgDettaglioClick(Sender: TObject);
    procedure imgCartellinoClick(Sender: TObject);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure W010AutorizzaTutto(Sender: TObject; var Ok: Boolean);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
    procedure OnCausaleChange(EventParams: TStringList);
    procedure CaricaListaMotivazioni(const PCausale: String);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
    procedure ImpostaJQuery;
    procedure GestisciRisposteRichiestaGiust;
    procedure SetDaoreAore;
    procedure IncludiTipoRichieste;
    procedure PostInsRichiesta;
    procedure PostAnnullaRichiesta;
    const
      PAR_CODCAUS_CALLBACK   = 'codcausale';
      MAX_LENGTH_MOTIVAZIONE = 30;
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    W010DM: TW010FRichiestaAssenzeDM;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    function  InizializzaAccesso: Boolean; override;
  end;

implementation

uses
  W001UIrisWebDtM,
  IWGlobal,
  SyncObjs;

{$R *.DFM}

function TW010FRichiestaAssenze.InizializzaAccesso:Boolean;
begin
  Result:=True;

  FDatiGiust.Dal:=ParametriForm.Dal;
  FDatiGiust.Al:=ParametriForm.Al;

  GetDipendentiDisponibili(FDatiGiust.Al);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  if WR000DM.Responsabile then
  begin
    // nasconde i componenti "causali disponibili" e "causali assenza"
    // NOTA: questi componenti vengono comunque utilizzati nel calcolo del riepilogo
    lblGiustificativo.Visible:=False;
    cmbCausaliDisponibili.Visible:=False;
    cmbAccorpCausali.Visible:=False;
    lblFamiliari.Visible:=False;
    cmbFamiliari.Visible:=False;
    lblNote.Visible:=False;
    edtNote.Visible:=False;
    lblMotivazione.Visible:=False;
    cmbMotivazione.Visible:=False;

    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W010AutorizzaTutto;
  end;

  // visualizza i dati del dipendente selezionato
  VisualizzaDipendenteCorrente;
  ImpostaJQuery;
end;

procedure TW010FRichiestaAssenze.IWAppFormCreate(Sender: TObject);
begin
  Tag:=IfThen(WR000DM.Responsabile,407,406);
  inherited;
  W010DM:=TW010FRichiestaAssenzeDM.Create(Self);
  Iter:=ITER_GIUSTIF;
  W010DM.C018DM:=C018;
  if WR000DM.Responsabile then
  begin
    Self.HelpKeyWord:='W010P1';
    C018.PreparaDataSetIter(W010DM.selT050,tiAutorizzazione);
    btnCartellino.Visible:=False;
  end
  else
  begin
    Self.HelpKeyWord:=IfThen(C018.EsisteAutorizzIntermedia,'W010P2','W010P0');
    C018.PreparaDataSetIter(W010DM.selT050,tiRichiesta);
  end;

  C018.Periodo.SetVuoto;

  B021FWebSvcClientDtM:=TB021FWebSvcClientDtM.Create(Self);

  FDatiGiust:=TDatiRichiestaGiust.Create;
  FDatiGiust.Dal:=Parametri.DataLavoro;
  FDatiGiust.Al:=Parametri.DataLavoro;

  WR000DM.selT265.Filtered:=True;  //Filtro Dizionario
  WR000DM.selT275.Filtered:=True;  //Filtro Dizionario

  // inserimento nuove richieste
  btnInserisci.Visible:=(not SolaLettura) and
                        (not WR000DM.Responsabile);
  edtDal.Visible:=not WR000DM.Responsabile;
  edtAl.Visible:=not WR000DM.Responsabile;
  lblDal.Visible:=not WR000DM.Responsabile;
  lblAl.Visible:=not WR000DM.Responsabile;
  rgpTipo.Visible:=not WR000DM.Responsabile;
  edtOre.Visible:=not WR000DM.Responsabile;
  edtAOre.Visible:=not WR000DM.Responsabile;
  chkNoteIns.Visible:=not WR000DM.Responsabile;
  memNoteIns.Visible:=not WR000DM.Responsabile;
  if memNoteIns.Visible then
    memNoteIns.Css:='invisibile';

  // gestione motivazioni per causali
  W010DM.selT106.Close;
  W010DM.selT106.Open;
  GestioneMotivazioniCausali:=W010DM.selT106.RecordCount > 0;
  if GestioneMotivazioniCausali then
  begin
    // registra funzione di callback
    CallBackNameCausaleChange:=UpperCase(Self.Name) + '.OnCausaleChange';
    GGetWebApplicationThreadVar.RegisterCallBack(CallBackNameCausaleChange,OnCausaleChange);

    // crea lista motivazioni
    ListaMotivazioni:=TStringList.Create;
    ListaMotivazioni.OwnsObjects:=True;
    ListaMotivazioni.StrictDelimiter:=True;
  end;
  lblMotivazione.Visible:=GestioneMotivazioniCausali and (not WR000DM.Responsabile);
  cmbMotivazione.Visible:=lblMotivazione.Visible;
  if not cmbMotivazione.Visible then
  begin
    AddToInitProc('document.getElementById("rigaMotivazione").className = ''invisibile'';');
  end;

  // causali di assenza e familiari
  WR000DM.selT265.Open;
  WR000DM.selT275.Open;
  ListaCausali:=TStringList.Create;
  // TORINO_ASLTO1 - chiamata <79586>.ini
  // la lista causali è inconsistente con i valori della combobox
  // il problema è legato alle causali con nome uguale ma case diverso
  ListaCausali.Duplicates:=dupIgnore; // ribadisce il valore di default: ignora i valori duplicati (non ci possono essere)
  ListaCausali.CaseSensitive:=True; // ignora i duplicati ma valuta il case sensitive
  // TORINO_ASLTO1 - chiamata <79586>.fine
  ListaCausali.Sorted:=True;
  GetAccorpamentiDisponibili;
  ListaFamiliari:=TStringList.Create;
  ListaFamiliari.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  edtRiepAl.Text:=DateToStr(Parametri.DataLavoro);

  // gestione tabella
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  grdRichieste.medpDataSet:=W010DM.selT050;

  with WR000DM do
  begin
    selT265.Tag:=selT265.Tag + 1;
    selT275.Tag:=selT275.Tag + 1;
    selT257.Tag:=selT257.Tag + 1;
    selSG101.Tag:=selSG101.Tag + 1;
    selSG101Causali.Tag:=selSG101Causali.Tag + 1;
  end;

  // TORINO_ASLTO2 - 2013/044 - R600 utilizzato per controlli causali concatenate
  // crea oggetto R600 sempre
  CreaR600;
  // TORINO_ASLTO2.fine

  // inizializzazioni dati richiesta
  Operazione:=OP_INSERIMENTO;
  FDatiGiust.Progressivo:=0;
  FDatiGiust.TipoRichiesta:='';
  FDatiGiust.IdRevocato:=-1;
  FDatiGiust.Motivazione:='';

  AutorizzazioniDaConfermare:=False;

  lblPeriodoDalAl.Visible:=False;
  edtPeriodoDalAl.Visible:=False;

  // imposta la gestione automatica della selezione del periodo
  AssegnaGestPeriodo(edtDal,edtAl);

  if WR000DM.Responsabile and
     C018.EsisteGestioneAllegati then
  begin
    AddCampoMetadati('DAL','DAL',0);
    AddCampoMetadati('AL','AL',0);
    AddCampoMetadati('CAUSALE','D_CAUSALE_2',200);
    AddCampoMetadati('FAMILIARE','DATANAS',0);
    CreaDataSetMetadati;
  end;
end;

procedure TW010FRichiestaAssenze.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 407;
  // TORINO_ASLTO2 - 2013/044 - R600 utilizzato per controlli causali concatenate
  //FreeAndNil(R600DtM);
  // TORINO_ASLTO2.fine
  if not AutorizzazioniDaConfermare then // COMO_HSANNA - commessa 2011/178 - riesame del 15.05.2013
    VisualizzaDipendenteCorrente;
end;

procedure TW010FRichiestaAssenze.IWAppFormRender(Sender: TObject);
var
  Caus: String;
begin
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;

  // autorizza / nega tutto
  if medpAutorizzaMultiplo then
  begin
    if btnTuttiSi.Visible then
      btnTuttiSi.Visible:=(W010DM.selT050.RecordCount > 0);
    btnTuttiNo.Visible:=btnTuttiSi.Visible;
  end;

  // acquisizione giustificativi
  // abilitata solo per le richieste da autorizzare se il corrispondente parametro aziendale è attivo
  btnImporta.Visible:=(Parametri.CampiRiferimento.C90_W010AcquisizioneAuto = 'S') and
                      (WR000DM.Responsabile) and // bugfix - SGIULIANOMILANESE_COMUNE - chiamata <76351>
                      (W010DM.selT050.RecordCount > 0) and
                      (C018.TipoRichiesteSel = [trDaAutorizzare]);

  // abilitazioni tipo fruizione causale
  if (not MsgBox.IsActive) and
     (not WR000DM.Responsabile) then
  begin
    Caus:=Trim(Copy(cmbCausaliDisponibili.Text,1,5));
    AddToInitProc('CausaleCambiata("' + Caus + '");');
  end;

  // note inserimento
  if chkNoteIns.Checked then
    memNoteIns.Css:='textarea_note inser';
end;

procedure TW010FRichiestaAssenze.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // chiusura frame cancellazione periodo
    if AComponent = W010CancPeriodoFM then
    begin
      try
        W010CancPeriodoFM:=nil;
      except
      end;
    end
    else if AComponent = W010CalcoloCompetenzeFM then
    begin
      // chiusura frame calcolo competenze
      try
        W010CalcoloCompetenzeFM:=nil;
      except
      end;
    end
    else if AComponent = W005FM then
    begin
      // chiusura frame cartellino
      try
        W005FM:=nil;
        // riapplica il filtro dizionario
        WR000DM.selT265.Filtered:=True;
        WR000DM.selT275.Filtered:=True;
      except
      end;
    end;
  end;
end;

procedure TW010FRichiestaAssenze.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  // COMO_HSANNA - commessa 2011/178 - riesame del 15.05.2013.ini
  // conferma nel caso di autorizzazioni pendenti da confermare
  if (Parametri.CampiRiferimento.C90_W010AcquisizioneAuto = 'S') and
     (AutorizzazioniDaConfermare) then
  begin
    Conferma:='Attenzione!'#13#10 +
              'Sono presenti autorizzazioni da confermare.'#13#10 +
              'Le modifiche non verrano perse, ma sarà necessario confermarle la volta successiva.'#13#10 +
              'Uscire comunque?';
  end;
  // COMO_HSANNA - commessa 2011/178 - riesame del 15.05.2013.fine
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
procedure TW010FRichiestaAssenze.CaricaListaMotivazioni(const PCausale: String);
var
  i, idx: Integer;
  LCodiceDefault: String;
begin
  LCodiceDefault:='';
  ListaMotivazioni.Clear;

  // PRE: il dataset è aperto e filtrato sul tipo T050

  // ciclo per caricare la lista di motivazioni
  W010DM.selT106.Refresh;
  if W010DM.selT106.RecordCount > 0 then
  begin
    W010DM.selT106.First;
    while not W010DM.selT106.Eof do
    begin
      // se l'elenco di causali è vuoto, si aggiungono tutte le motivazioni
      if (W010DM.selT106.FieldByName('CAUSALI').AsString = '') or
         (R180CercaParolaIntera(PCausale,W010DM.selT106.FieldByName('CAUSALI').AsString,',') > 0) then
      begin
        ListaMotivazioni.Add(Format('%s=%s',[W010DM.selT106.FieldByName('DESCRIZIONE').AsString,W010DM.selT106.FieldByName('CODICE').AsString]));
        if W010DM.selT106.FieldByName('CODICE_DEFAULT').AsString = 'S' then
          LCodiceDefault:=W010DM.selT106.FieldByName('CODICE').AsString;
      end;
      W010DM.selT106.Next;
    end;
    for i:=0 to ListaMotivazioni.Count - 1 do
    begin
      ListaMotivazioni.Objects[i]:=TValore.Create(ListaMotivazioni.ValueFromIndex[i]);
      ListaMotivazioni.Strings[i]:=ListaMotivazioni.Names[i];
    end;
  end;

  // imposta elementi combo e seleziona eventuale default
  cmbMotivazione.Items.Assign(ListaMotivazioni);
  cmbMotivazione.RequireSelection:=True;

  // seleziona default
  if cmbMotivazione.Items.Count > 0 then
  begin
    if cmbMotivazione.Items.Count = 1 then
    begin
      // seleziona l'unico elemento disponibile
      cmbMotivazione.ItemIndex:=0;
    end
    else if LCodiceDefault <> '' then
    begin
      // seleziona l'elemento di default indicato
      idx:=-1;
      for i:=0 to cmbMotivazione.Items.Count - 1 do
      begin
        if LCodiceDefault = TValore(cmbMotivazione.Items.Objects[i]).Valore then
        begin
          idx:=i;
          Break;
        end;
      end;
      cmbMotivazione.ItemIndex:=idx;
    end
    else
    begin
      // rimuove selezione
      cmbMotivazione.ItemIndex:=-1;
    end;
  end;

  // combobox visibile solo in presenza di elementi selezionabili
  // utilizzo property "css" invece di "visible" perché gli eventi async NON FUNZIONANO
  lblMotivazione.Css:=lblMotivazione.Css.Replace('nascosto','',[rfReplaceAll]).Trim + IfThen(ListaMotivazioni.Count = 0,' nascosto');
  cmbMotivazione.Css:=cmbMotivazione.Css.Replace('nascosto','',[rfReplaceAll]).Trim + IfThen(ListaMotivazioni.Count = 0,' nascosto');
end;

procedure TW010FRichiestaAssenze.OnCausaleChange(EventParams: TStringList);
var
  LCodCaus: String;
begin
  // estrae codice causale selezionata
  LCodCaus:=EventParams.Values[PAR_CODCAUS_CALLBACK];

  // popola la combobox con l'elenco delle motivazioni riferite alla causale indicata
  CaricaListaMotivazioni(LCodCaus);
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine

procedure TW010FRichiestaAssenze.CreaR600;
// Crea e imposta l'oggetto R600
begin
  Log('Traccia','CreaR600 - inizio');
  R600DtM:=TR600DtM1.Create(Self);
  //R600DtM.VisualizzaAnomalie:=False;
  //R600DtM.AnomalieBloccanti:=True;
  R600DtM.IterAutorizzativo:=True;
  Log('Traccia','CreaR600 - fine');
end;

procedure TW010FRichiestaAssenze.GetAccorpamentiDisponibili;
var CodDescAccorp:String;
begin
  with WR000DM do
  begin
    selT257.SetVariable('INDATA',Parametri.DataLavoro);
    selT257.Close;
    selT257.Open;
    if selT257.RecordCount > 0 then
    begin
      cmbAccorpCausali.Visible:=True;
      cmbAccorpCausali.Items.Add('');
      while not selT257.Eof do
      begin
        CodDescAccorp:=Format('%-5s %s',[selT257.FieldByName('COD_CODICIACCORPCAUSALI').AsString,
                                       selT257.FieldByName('DESCRIZIONE').AsString]);
        if cmbAccorpCausali.Items.IndexOf(CodDescAccorp) < 0 then
          cmbAccorpCausali.Items.Add(CodDescAccorp);
        selT257.Next;
      end;
      if (Parametri.CampiRiferimento.C90_W010CausPres = 'S') and (selT275.RecordCount > 0) then
        cmbAccorpCausali.Items.Add(Format('%-5s %s',['','Causali di presenza']));
      cmbAccorpCausali.ItemIndex:=0;
    end
    else
      cmbAccorpCausali.Visible:=False;
  end;
end;

procedure TW010FRichiestaAssenze.GetCausaliDisponibili(pMantieniValore: Boolean = False);
{ Popola la combo delle causali disponibili e in più prepara un array associativo
  in javascript per abilitare / disabilitare i radiobutton di scelta del tipo
  di fruizione (giornata, mezza gg.,...)
  L'array è del tipo
    arrCausFruiz["CAUSALE_1"] = bbbb;
    arrCausFruiz["CAUSALE_2"] = bbbb;
    arrCausFruiz["CAUSALE_3"] = bbbb;
    ...

  bbbb è una stringa di 4 cifre binarie che indicano il tipo di fruizione
       abilitato (0 = disabilitato, 1 = abilitato).

  pos. 1: fruizione a giornata
  pos. 2: fruizione a mezza giornata
  pos. 3: fruizione a num. ore
  pos. 4: fruizione di tipo da ore - a ore
}
var
  Codice,JsCodeFruiz,FruizG,FruizMG,FruizN,FruizD,JsCodeFam,Fam,JsCodeTipo,CausAb: String;
  LstFCausali, LstCausaliAAbilitate, LstRaggrCausaliPAbilitate, LstRaggrCausAb: TStringList;
  i: integer;
  ValoreSelezionato: string;
  DataDa, DataA: TDateTime;
  EscludiCausale: Boolean;
begin
  Log('Traccia','GetCausaliDisponibili - inizio');
  ValoreSelezionato:=cmbCausaliDisponibili.SelectedValue;

  ListaCausali.Clear;
  cmbCausaliDisponibili.Items.Clear;

  // aggiunge l'item vuoto
  ListaCausali.Add('');
  cmbCausaliDisponibili.Items.Add('');

  cmbFCausale.Items.Clear;
  cmbFCausale.AddRow('<Tutte>; ');
  LstFCausali:=TStringList.Create;
  LstFCausali.Sorted:=True;

  LstCausaliAAbilitate:=TStringList.Create;
  LstCausaliAAbilitate.Sorted:=True;
  LstCausaliAAbilitate.Duplicates:=dupIgnore;
  LstCausaliAAbilitate.CaseSensitive:=True;

  LstRaggrCausaliPAbilitate:=TStringList.Create;
  LstRaggrCausaliPAbilitate.Sorted:=True;
  LstRaggrCausaliPAbilitate.Duplicates:=dupIgnore;
  LstRaggrCausaliPAbilitate.CaseSensitive:=True;

  LstRaggrCausAb:=TStringList.Create;
  LstRaggrCausAb.Sorted:=True;
  LstRaggrCausAb.Duplicates:=dupIgnore;
  LstRaggrCausAb.CaseSensitive:=True;

  if (not WR000DM.Responsabile) and
     WR000DM.selT430RaggrAssenzeAbilitati.Active and
     WR000DM.selT430CausaliAbilitate.Active then
  begin
    if TryStrToDate(edtDal.Text, DataDa) and not TryStrToDate(edtAl.Text, DataA) then
      edtAl.Text:=edtDal.Text;
    if TryStrToDate(edtAl.Text, DataA) and not TryStrToDate(edtDal.Text, DataDa) then
      edtDal.Text:=edtAl.Text;
    if not TryStrToDate(edtDal.Text, DataDa) then
      DataDa:=IncMonth(Parametri.DataLavoro, -12);
    if not TryStrToDate(edtAl.Text, DataA) then
      DataA:=IncMonth(Parametri.DataLavoro, 12);
    if DataDa > DataA then
      DataDa:=DataA;

    with WR000DM.selT430CausaliAbilitate do
    begin
      First;
      while not eof do
      begin
        if Max(DataDa, FieldByName('DECORRENZA').AsDateTime) <= Min(DataA, FieldByName('SCADENZA').AsDateTime) then
        begin
          for CausAb in FieldByName('ABCAUSALE1').AsString.Split([',']) do
            LstCausaliAAbilitate.Add(CausAb);
          for CausAb in FieldByName('ABPRESENZA1').AsString.Split([',']) do
            LstRaggrCausaliPAbilitate.Add(CausAb);
        end;
        Next;
      end;
    end;

    with WR000DM.selT430RaggrAssenzeAbilitati do
    begin
      First;
      while not eof do
      begin
        if (Max(DataDa, FieldByName('DECORRENZA').AsDateTime) <= Min(DataA, FieldByName('SCADENZA').AsDateTime)) then
          LstRaggrCausAb.Add(FieldByName('CODRAGGR').AsString);
        Next;
      end;
    end;
  end;

  // popolamento combo
  with WR000DM.selT265 do
  begin
    //Close;
    Open;
    First;

    // prepara un array associativo (in javascript) per abilitare / disabilitare
    // i radiobutton di scelta del tipo di fruizione (giornata, mezza gg.,...)
    JsCodeFruiz:=IfThen(RecordCount = 0,'','var arrCausFruiz = { ');
    JsCodeFam:=IfThen(RecordCount = 0,'','var arrCausFam = { ');
    JsCodeTipo:=IfThen(RecordCount = 0,'','var arrCausTipo = { ');

    while not Eof do
    begin
      // salva dati in variabili di appoggio
      Codice:=FieldByName('CODICE').AsString;
      EscludiCausale:=(not WR000DM.Responsabile) and
                      (((FieldByName('FRUIBILE').AsString = 'N') and (LstCausaliAAbilitate.IndexOf(Codice) < 0)) or
                       ((FieldByName('CONTASOLARE').AsString = 'S') and (LstRaggrCausAb.IndexOf(FieldByName('CODRAGGR').AsString) < 0)));

      //Filtro le causali se l'accorpamento è valorizzato
      WR000DM.selT257.First;
      if (Trim(cmbAccorpCausali.Text) = '') or
         WR000DM.selT257.Locate('COD_CODICIACCORPCAUSALI;COD_CAUSALE',
         VarArrayOf([Trim(copy(cmbAccorpCausali.Text,1,5)),Codice]),[]) then
      begin
        FruizG:=IfThen(FieldByName('UM_INSERIMENTO').AsString = 'S','1','0');
        FruizMG:=IfThen(FieldByName('UM_INSERIMENTO_MG').AsString = 'S','1','0');
        FruizN:=IfThen(FieldByName('UM_INSERIMENTO_H').AsString = 'S','1','0');
        FruizD:=IfThen(FieldByName('UM_INSERIMENTO_D').AsString = 'S','1','0');
        Fam:=IfThen((R180CarattereDef(FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
                    (R180CarattereDef(FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D']),'1','0');

        if not EscludiCausale then
        begin
          cmbCausaliDisponibili.Items.Add(StringReplace(Format('%-5s %s',[Codice,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
          ListaCausali.Add(Codice);
        end;

        // aggiunge elemento all'array javascript
        if JsCodeFruiz <> 'var arrCausFruiz = { ' then
        begin
          JsCodeFruiz:=JsCodeFruiz + ', ';
          JsCodeFam:=JsCodeFam + ', ';
          JsCodeTipo:=JsCodeTipo + ', ';
        end;
        JsCodeFruiz:=JsCodeFruiz + '"' + Codice + '":"' + FruizG + FruizMG + FruizN + FruizD + '"';
        JsCodeFam:=JsCodeFam + '"' + Codice + '":"' + Fam + '"';
        JsCodeTipo:=JsCodeTipo + '"' + Codice + '":"A"';
      end;
      if not EscludiCausale then
        LstFCausali.Add(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;

  with WR000DM.selT275 do
  begin
    //Close;
    Open;
    First;
    if Parametri.CampiRiferimento.C90_W010CausPres = 'S' then
    begin
      // prepara un array associativo (in javascript) per abilitare / disabilitare
      // i radiobutton di scelta del tipo di fruizione (giornata, mezza gg.,...)
      if JsCodeFruiz = '' then
        JsCodeFruiz:=IfThen(RecordCount = 0,'','var arrCausFruiz = { ');
      if JsCodeFam = '' then
        JsCodeFam:=IfThen(RecordCount = 0,'','var arrCausFam = { ');
      if JsCodeTipo = '' then
        JsCodeTipo:=IfThen(RecordCount = 0,'','var arrCausTipo = { ');

      while not Eof do
      begin
        // salva dati in variabili di appoggio
        Codice:=FieldByName('CODICE').AsString;
        EscludiCausale:=(not WR000DM.Responsabile) and (LstRaggrCausaliPAbilitate.IndexOf(FieldByName('CODRAGGR').AsString) < 0);

        //Filtro le causali se l'accorpamento è valorizzato o se non sono fruibili
        WR000DM.selT257.First;
        if  (   (Trim(cmbAccorpCausali.Text) = '')
             or (Trim(cmbAccorpCausali.Text) = 'Causali di presenza'))
        and (   (FieldByName('UM_INSERIMENTO_H').AsString = 'S')
             or (FieldByName('UM_INSERIMENTO_D').AsString = 'S')) then
        begin
          FruizG:='0';
          FruizMG:='0';
          FruizN:=IfThen(FieldByName('UM_INSERIMENTO_H').AsString = 'S','1','0');
          FruizD:=IfThen(FieldByName('UM_INSERIMENTO_D').AsString = 'S','1','0');
          Fam:='0';

          if not EscludiCausale then
          begin
            cmbCausaliDisponibili.Items.Add(StringReplace(Format('%-5s %s',[Codice,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
            ListaCausali.Add(Codice);
          end;

          // aggiunge elemento all'array javascript
          if JsCodeFruiz <> 'var arrCausFruiz = { ' then
          begin
            JsCodeFruiz:=JsCodeFruiz + ', ';
            JsCodeFam:=JsCodeFam + ', ';
            JsCodeTipo:=JsCodeTipo + ', ';
          end;
          JsCodeFruiz:=JsCodeFruiz + '"' + Codice + '":"' + FruizG + FruizMG + FruizN + FruizD + '"';
          JsCodeFam:=JsCodeFam + '"' + Codice + '":"' + Fam + '"';
          JsCodeTipo:=JsCodeTipo + '"' + Codice + '":"P"';
        end;
        if not EscludiCausale then
          LstFCausali.Add(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
        Next;
      end;
    end;
  end;

  for i:=0 to LstFCausali.Count-1 do
    cmbFCausale.AddRow(LstFCausali[i]);
  FreeAndNil(LstFCausali);

  cmbFCausale.ItemIndex:=0;
  cmbCausaliDisponibili.ItemIndex:=0;

  Log('Traccia','GetCausaliDisponibili: popolamento ok');

  if JsCodeFruiz = '' then
    Exit;

  // imposta il javascript da includere nel documento
  with Javascript do
  begin
    Add(Copy(JsCodeFruiz,1,Length(JsCodeFruiz)) + ' };');
    Add(Copy(JsCodeFam,1,Length(JsCodeFam)) + ' };');
    Add(Copy(JsCodeTipo,1,Length(JsCodeTipo)) + ' };');
    Add(' ');
    Add('var NoteGiustificativi = ' + IfThen(Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S','true','false') + ';');
    Add('function CausaleCambiata(CodCausale) { ');
    Add('  // il codice causale è lungo 5 caratteri, e deve essere trimmato ');
    Add('  CodCausale = trim(CodCausale); ');
    Add('  try { console.log("CausaleCambiata(" + CodCausale + ")"); } catch(errore) {} ');
    Add('  try { ');
    Add('    try { ');
    Add('      var lblFamiliariElem = FindElem("LBLFAMILIARI"); ');
    Add('      var cmbFamiliariElem = FindElem("CMBFAMILIARI"); ');
    Add('      var GestFam = "0"; ');
    Add('      if (CodCausale != "") { ');
    Add('        GestFam = arrCausFam[CodCausale]; ');
    Add('      } ');
    Add('      cmbFamiliariElem.style.visibility = (GestFam == "1") ? "visible" : "hidden";');
    Add('      lblFamiliariElem.style.visibility = (GestFam == "1") ? "visible" : "hidden";');
    Add('    } ');
    Add('    catch(err) { ');
    Add('      //alert("Errore: " + err.message + "\n" + err.description); ');
    Add('    } ');
    Add('    // inizializzazione variabili di appoggio ');
    Add('    var edtOreElem = FindElem("EDTORE"); ');
    Add('    var edtAOreElem = FindElem("EDTAORE"); ');
    Add('    var btnInserisciElem = FindElem("BTNINSERISCI"); ');
    Add('    var Fruizioni = "1111"; ');
    Add('    var lblNoteElem = FindElem("' + lblNote.HTMLName + '"); ');
    Add('    var edtNoteElem = FindElem("' + edtNote.HTMLName + '"); ');
    Add('    if (CodCausale != "") { ');
    Add('      Fruizioni = arrCausFruiz[CodCausale]; ');
    Add('    } ');
    Add('    // creazione array di puntatori agli input di tipo radiobutton');
    Add('    numElem = 4; ');
    Add('    var arrRbTipo = new Array(numElem); ');
    Add('    for (i = 0; i < numElem; i++) { ');
    Add('      arrRbTipo[i] = FindElem("RGPTIPO_INPUT_" + (i + 1)); ');
    Add('      if (i == 0) {arrRbTipo[i].title = "giornata";} ');
    Add('      if (i == 1) {arrRbTipo[i].title = "mezza giornata";} ');
    Add('      if (i == 2) {arrRbTipo[i].title = "numero ore";} ');
    Add('      if (i == 3) {arrRbTipo[i].title = "da ore - a ore";} ');
    Add('    } ');
    Add('    // anomalia se nessun tipo fruizione è abilitato');
    Add('    window.status = (Fruizioni == "0000") ? "La causale selezionata non ha tipologie di fruizione abilitate!" : ""');
    Add('    // abilitazioni dei radiobutton per il tipo fruizione ');
    Add('    var indexChecked = -1; ');
    Add('    var firstEnabled = -1; ');
    Add('    for (i = numElem - 1; i >= 0; i--) { ');
    Add('      if (Fruizioni.substr(i,1) == "0") { ');
    Add('        arrRbTipo[i].style.visibility = "hidden"; ');
    Add('        arrRbTipo[i].nextSibling.style.visibility = "hidden"; ');
    Add('        if (arrRbTipo[i].checked) { ');
    Add('          arrRbTipo[i].checked = false; ');
    Add('          indexChecked = -1; ');
    Add('        } ');
    Add('      } ');
    Add('      else { ');
    Add('        firstEnabled = i; ');
    Add('        arrRbTipo[i].style.visibility = "visible"; ');
    Add('        arrRbTipo[i].nextSibling.style.visibility = "visible"; ');
    Add('      } ');
    Add('      if (arrRbTipo[i].checked) ');
    Add('        indexChecked = i; ');
    Add('    } ');
    Add('    // verifica se dopo il ciclo nessun radiobutton risulta selezionato ');
    Add('    if (indexChecked == -1) { ');
    Add('      // seleziona il primo radiobutton abilitato (se presente)');
    Add('      if (firstEnabled > -1) { ');
    Add('        indexChecked = firstEnabled; ');
    Add('        arrRbTipo[indexChecked].checked = true; ');
    Add('      } ');
    Add('    } ');
    Add('    // gestione disabilitazione pulsanti (caso di nessuna fruizione possibile) ');
    Add('    if (btnInserisciElem != null) ');
    Add('      btnInserisciElem.disabled = (firstEnabled == -1); ');
    Add('    // abilitazioni campi da ore / a ore ');
    Add('    edtOreElem.style.visibility = (indexChecked <= 1) ? "hidden" : "visible"; ');
    Add('    edtAOreElem.style.visibility = (indexChecked < 3) ? "hidden" : "visible"; ');
    Add('    if (indexChecked <= 1) ');
    Add('      edtOreElem.value = ""; ');
    Add('    if (indexChecked < 3) ');
    Add('      edtAOreElem.value = ""; ');
    Add('    lblNoteElem.style.visibility = ((indexChecked == ((numElem == 4)? 1 : -1)) && NoteGiustificativi) ? "visible" : "hidden"; ');
    Add('    edtNoteElem.style.visibility = lblNoteElem.style.visibility; ');
    Add('    try { ');
    Add('      var lblDalElem = FindElem("LBLDAL"); ');
    Add('      var edtDalElem = FindElem("EDTDAL"); ');
    Add('      var lblAlElem = FindElem("LBLAL"); ');
    Add('      var edtAlElem = FindElem("EDTAL"); ');
    Add('      var btnVisualizzaRiepilogoElem = FindElem("BTNVISUALIZZARIEPILOGO"); ');
    Add('      var TipoCaus; ');
    Add('      if (CodCausale != "") { ');
    Add('        TipoCaus = arrCausTipo[CodCausale]; ');
    Add('      } ');
    Add('      lblDalElem.style.visibility = (TipoCaus == "A") ? "visible" : "hidden";');
    Add('      edtDalElem.style.visibility = (TipoCaus == "A") ? "visible" : "hidden";');
    //Add('      lblAlElem.innerText = (TipoCaus == "A") ? "al" : "Data";');
    Add(Format('      lblAlElem.innerText = (TipoCaus == "A") ? "%s" : "%s";',[A000TraduzioneStringhe('al'),A000TraduzioneStringhe('Data')]));
    Add('      btnVisualizzaRiepilogoElem.style.visibility = (TipoCaus == "A") ? "visible" : "hidden";');
    Add('    } ');
    Add('    catch(err) { ');
    Add('      alert("Errore: " + err.message + "\n" + err.description); ');
    Add('    } ');
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
    // se è prevista la gestione delle motivazioni per le causali,
    // richiama funzione delphi in async per filtrare e proporre
    // la lista di motivazioni per la causale selezionata
    if GestioneMotivazioniCausali then
    begin
      // richiama funzione async delphi per proporre eventuali motivazioni causale
      Add('    executeAjaxEvent("&' + PAR_CODCAUS_CALLBACK + '=" + encodeURI(CodCausale),null,"' + CallBackNameCausaleChange + '",false,null,false); ');
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
    Add('  } ');
    Add('  catch(err) { ');
    Add('    alert("Errore: " + err.message + "\n" + err.description); ');
    Add('  } ');
    Add('} ');
  end;

  //Ripristina il valore selezionato se ancora disponibile
  if pMantieniValore and (cmbCausaliDisponibili.Items.Count > 0)  then
    cmbCausaliDisponibili.ItemIndex:=Max(0, cmbCausaliDisponibili.Items.IndexOf(ValoreSelezionato));

  Log('Traccia','GetCausaliDisponibili - fine');
end;

procedure TW010FRichiestaAssenze.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TW010FRichiestaAssenze.VisualizzaDipendenteCorrente;
var
  FiltroAnag: String;
begin
  inherited;
  Log('Traccia','VisualizzaDipendenteCorrente - inizio');
  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  // apertura dataset delle richieste assenza
  WR000DM.selT265.Filtered:=True;
  WR000DM.selT265.Open;
  WR000DM.selT275.Filtered:=True;
  WR000DM.selT275.Open;
  with W010DM.selT050 do
  begin
    // determina filtri
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       'and T030.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);

    // forza richiamo per comportamento non standard
    CorrezionePeriodo;

    // impostazione variabili per filtro richieste
    Close;
    if cmbFCausale.ItemIndex > 0 then
      W010DM.Causale:=cmbFCausale.Items[cmbFCausale.ItemIndex].RowData[0]
    else
      W010DM.Causale:='';

    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',FiltroAnag);
    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    // MONDOEDP - commessa MAN/07.ini
    SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
    // MONDOEDP - commessa MAN/07.fine
    R013Open(W010DM.selT050);
  end;

  R180SetVariable(WR000DM.selT430CausaliAbilitate, 'PROGRESSIVO', ParametriForm.Progressivo);
  WR000DM.selT430CausaliAbilitate.Open;
  R180SetVariable(WR000DM.selT430RaggrAssenzeAbilitati, 'PROGRESSIVO', ParametriForm.Progressivo);
  WR000DM.selT430RaggrAssenzeAbilitati.Open;

  Log('Traccia','VisualizzaDipendenteCorrente: dataset aperto');

  // estrae i familiari per il dipendente corrente
  //if not TuttiDipSelezionato then
  //  GetFamiliari('');

  // pulizia campi
  if not edtPeriodoDalAl.Visible then
  begin
    edtDal.Text:='';
    edtAl.Text:='';
  end;
  edtOre.Text:='';
  edtAOre.Text:='';
  rgpTipo.ItemIndex:=0;
  //cmbCausaliDisponibili.ItemIndex:=0;
  //cmbFamiliari.ItemIndex:=0;

  btnNascondiRiepilogoAsyncClick(nil,nil);

  (*Alberto 10/03/2015: Si lascia l'impostazione precedente
  chkNoteIns.Checked:=False;
  memNoteIns.Css:='invisibile';
  *)
  memNoteIns.Text:='';

  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
    grdRichieste.medpAggiungiColonna('DBG_COMANDI',IfThen(Parametri.AccessibilitaNonVedenti = 'S','Azioni'),'',nil);
    if C018.UtilizzoAvviso then
      grdRichieste.medpAggiungiColonna('D_VISTI_PREC','Visti prec.','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('D_CARTELLINO','Cartellino','',nil);
    with WR000DM.selT265 do
    begin
      Filter:='(TIPOCUMULO <> ''H'') and (NO_SUPERO_COMPETENZE_WEB = ''N'')';
      ShowAvvertimenti:=RecordCount > 0;
      Filter:='';
    end;
    if ShowAvvertimenti then
      grdRichieste.medpAggiungiColonna('D_AVVERTIMENTI','Avvertimenti','',nil);
    grdRichieste.medpAggiungiColonna('ID','ID','',nil);
    if (trTutte in C018.TipoRichiesteSel) or
       (trAutorizzate in C018.TipoRichiesteSel) or
       (trNegate in C018.TipoRichiesteSel) or
       (trRevocate in C018.TipoRichiesteSel) then
      grdRichieste.medpAggiungiColonna('D_ELABORATO','Elab.','',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_SI','Msg aut SI','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_NO','Msg aut NO','',nil);
    grdRichieste.medpColonna('MSGAUT_SI').Visible:=False;
    grdRichieste.medpColonna('MSGAUT_NO').Visible:=False;
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    if (C018.EsisteAutorizzIntermedia) or
       (C018.Revocabile) then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('DAL','Dal','',nil);
    grdRichieste.medpAggiungiColonna('AL','Al','',nil);
    grdRichieste.medpAggiungiColonna('D_CAUSALE_2','Causale','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIUST','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPOGIUST','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('NUMEROORE','Ore','',nil);
    grdRichieste.medpAggiungiColonna('AORE','Ore','',nil);
    grdRichieste.medpAggiungiColonna('D_DAORE_AORE','Ore','',nil);
    if C018.EsisteAutorizzIntermedia then
      grdRichieste.medpAggiungiColonna('D_DAORE_AORE_PREV','Ore prev.','',nil);
    grdRichieste.medpAggiungiColonna('DATANAS','Familiare','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
    if GestioneMotivazioniCausali then
      grdRichieste.medpAggiungiColonna('MOTIVAZIONE','Motivazione','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
    grdRichieste.medpColonna('ID').Visible:=False;
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('TIPOGIUST').Visible:=False;
    grdRichieste.medpColonna('NUMEROORE').Visible:=False;
    grdRichieste.medpColonna('AORE').Visible:=False;
  end
  else
  begin
    // richiesta
    grdRichieste.medpAggiungiColonna('DBG_COMANDI',IfThen(Parametri.AccessibilitaNonVedenti = 'S','Azioni'),'',nil);
    grdRichieste.medpAggiungiColonna('ID','ID','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    if (C018.EsisteAutorizzIntermedia) or
       (C018.Revocabile) then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('DAL','Dal','',nil);
    grdRichieste.medpAggiungiColonna('AL','Al','',nil);
    grdRichieste.medpAggiungiColonna('D_CAUSALE_2','Causale','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIUST','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPOGIUST','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('NUMEROORE','Ore','',nil);
    grdRichieste.medpAggiungiColonna('AORE','Ore','',nil);
    grdRichieste.medpAggiungiColonna('D_DAORE_AORE','Ore','',nil);
    if (C018.EsisteAutorizzIntermedia) and
       (C018.TipoRichiesteSel <> [trDaDefinire]) then
      grdRichieste.medpAggiungiColonna('D_DAORE_AORE_PREV','Ore prev.','',nil);
    grdRichieste.medpAggiungiColonna('DATANAS','Familiare','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
    if GestioneMotivazioniCausali then
      grdRichieste.medpAggiungiColonna('MOTIVAZIONE','Motivazione','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Aut.','',nil);
    if (trTutte in C018.TipoRichiesteSel) or
       (trAutorizzate in C018.TipoRichiesteSel) or
       (trNegate in C018.TipoRichiesteSel) or
       (trRevocate in C018.TipoRichiesteSel) then
      grdRichieste.medpAggiungiColonna('D_ELABORATO','Elab.','',nil);
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('D_CARTELLINO','Cartellino','',nil);
    grdRichieste.medpColonna('ID').Visible:=False;
    grdRichieste.medpColonna('TIPOGIUST').Visible:=False;
    grdRichieste.medpColonna('NUMEROORE').Visible:=False;
    grdRichieste.medpColonna('AORE').Visible:=False;
  end;
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  if WR000DM.Responsabile then
  begin
    // autorizzazione
    if not SolaLettura then
    begin
      if C018.TipoRichiesteSel <> [trDaDefinire] then
      begin
        grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'',A000TraduzioneStringhe('Si'),'','');
        grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'',A000TraduzioneStringhe('No'),'','');
      end;
      grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','STAMPA','Stampa dati della richiesta','','',False);
    end;
    // visti precedenti
    if C018.UtilizzoAvviso then
      grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('D_VISTI_PREC'),0,DBG_LBL,'','','','','',False);
    // supero competenze
    if ShowAvvertimenti then
      grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('D_AVVERTIMENTI'),0,DBG_LBL,'','','','','',False);
    // icona stampa
    grdRichieste.medpColonna('DBG_COMANDI').Visible:=(trAutorizzate in C018.TipoRichiesteSel) and (not SolaLettura) and (not IsCampoNascosto['DBG_COMANDI.STAMPA']);
    if C018.TipoRichiesteSel <= [trAutorizzate,trNegate,trRevocate,trTutte] then
      grdRichieste.medpColonna('D_ELABORATO').Visible:=(C018.TipoRichiesteSel <= [trAutorizzate,trNegate,trRevocate,trTutte]) and (not SolaLettura);
  end
  else
  begin
    // richiesta
    if not SolaLettura then
    begin
      // cancellazione + definizione e revoca richieste
      if C018.EsisteAutorizzIntermedia then
      begin
        grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA',A000TraduzioneStringhe(A000MSG_R013_MSG_HINT_CANC),A000TraduzioneStringhe(A000MSG_R013_MSG_CONFERMA_CANC),'S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','DEFINISCI','null','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','REVOCA',A000TraduzioneStringhe(A000MSG_R013_MSG_HINT_REVOCA),A000TraduzioneStringhe(A000MSG_R013_MSG_CONFERMA_REVOCA),'S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CANCPERIODO',A000TraduzioneStringhe(A000MSG_R013_MSG_HINT_CANCPARZ),'','D');
        grdRichieste.medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','ANNULLA',A000TraduzioneStringhe(A000MSG_R013_MSG_HINT_ANNULLA),'','S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,5,DBG_IMG,'','CONFERMA',A000TraduzioneStringhe(A000MSG_R013_MSG_HINT_DEFINITIVA),A000TraduzioneStringhe(A000MSG_R013_MSG_RICHIESTA_DEFINITIVA),'D');
      end
      else
      begin
        grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA',A000TraduzioneStringhe(A000MSG_R013_MSG_HINT_CANC),A000TraduzioneStringhe(A000MSG_R013_MSG_CONFERMA_CANC));
        grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','REVOCA',A000TraduzioneStringhe(A000MSG_R013_MSG_HINT_REVOCA),A000TraduzioneStringhe(A000MSG_R013_MSG_CONFERMA_REVOCA),'S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','CANCPERIODO',A000TraduzioneStringhe(A000MSG_R013_MSG_HINT_CANCPARZ),'','D');
      end;
    end;
    grdRichieste.medpColonna('DBG_COMANDI').Visible:=Length(grdRichieste.medpDescCompGriglia.Riga[0]) > 0;
  end;
  // icona cartellino
  grdRichieste.medpColonna('D_CARTELLINO').Visible:=not IsCampoNascosto['D_CARTELLINO'];

  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','Dettagli della richiesta','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','Allegati alla richiesta','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  //cartellino
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('D_CARTELLINO'),0,DBG_IMG,'','DETTAGLIO','Cartellino interattivo del giorno','','C');
  grdRichieste.medpCaricaCDS;

  //Carico i valori ricevuti evitando il DBClick
  if (ParametriForm.Chiamante <> '') or
     ((FDatiGiust.Dal <> Parametri.DataLavoro) and (FDatiGiust.Al <> Parametri.DataLavoro)) then
  begin
    edtDal.Text:=DateToStr(FDatiGiust.Dal);
    edtAl.Text:=DateToStr(FDatiGiust.Al);
  end;

  if (ParametriForm.Causale <> '') and (ListaCausali.IndexOf(ParametriForm.Causale) > 0) then
    cmbCausaliDisponibili.ItemIndex:=ListaCausali.IndexOf(ParametriForm.Causale);

  // estrae i familiari per il dipendente corrente
  cmbFamiliari.ItemIndex:=0;
  if not TuttiDipSelezionato then
    GetFamiliari(Trim(Copy(cmbCausaliDisponibili.Text,1,5)));

  // reset Valori
  FDatiGiust.Dal:=Parametri.DataLavoro;
  FDatiGiust.Al:=Parametri.DataLavoro;
  ParametriForm.Dal:=Parametri.DataLavoro;
  ParametriForm.Al:=Parametri.DataLavoro;
  ParametriForm.Causale:='';

  AutorizzazioniDaConfermare:=False;

  GetCausaliDisponibili;

  Log('Traccia','VisualizzaDipendenteCorrente - fine');
end;

procedure TW010FRichiestaAssenze.GetFamiliari(CodCausale:String);
var
  Codice, Descrizione, FiltroCausAbil, OldFam: String;
begin
  Log('Traccia','GetFamiliari - inizio');
  OldFam:=cmbFamiliari.Text;
  cmbFamiliari.ItemsHaveValues:=True;
  cmbFamiliari.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  cmbFamiliari.Items.Clear;
  ListaFamiliari.Clear;
  cmbFamiliari.Items.Add(NAME_VALUE_SEPARATOR);
  ListaFamiliari.Add(NAME_VALUE_SEPARATOR);

  // filtra i dataset dei familiari escludendo quelli senza causali abilitate
  if CodCausale = '' then
    FiltroCausAbil:='and    CAUSALI_ABILITATE is not null'
  else
    FiltroCausAbil:='and    ((CAUSALI_ABILITATE = ''*'') or (INSTR('',''||CAUSALI_ABILITATE||'','','',' + CodCausale + ','') > 0))';

  with WR000DM do
  begin
    R180SetVariable(selSG101,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selSG101,'FILTRO',FiltroCausAbil);
    selSG101.Open;
    selSG101.First;
    while not selSG101.Eof do
    begin
      Codice:=IntToStr(selSG101.FieldByName('NUMORD').AsInteger);
      Descrizione:='(' + selSG101.FieldByName('GRADOPAR').AsString + ') ' +
                   FormatDateTime('dd/mm/yyyy hh.nn',selSG101.FieldByName('DATA').AsDateTime) +
                   ' ' + selSG101.FieldByName('NOME').AsString;
      cmbFamiliari.Items.Values[Descrizione]:=Codice + '|' + selSG101.FieldByName('DATA_STR').AsString;
      ListaFamiliari.Values[selSG101.FieldByName('DATA').AsString]:=Codice + '|' + selSG101.FieldByName('DATA_STR').AsString;
      selSG101.Next;
    end;
    if (OldFam <> '') and (cmbFamiliari.Items.IndexOfName(OldFam) > -1) then
      cmbFamiliari.ItemIndex:=cmbFamiliari.Items.IndexOfName(OldFam)
    else if cmbFamiliari.Items.Count = 2 then
      cmbFamiliari.ItemIndex:=1
    else
      cmbFamiliari.ItemIndex:=0;

    // dataset familiari per abil. causali
    R180SetVariable(selSG101Causali,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selSG101Causali,'FILTRO',FiltroCausAbil);
    selSG101Causali.Open;
    selSG101Causali.First;
  end;
  Log('Traccia','GetFamiliari - fine');
end;

procedure TW010FRichiestaAssenze.imgCancellaClick(Sender: TObject);
var
  FN: String;
begin
  Log('Traccia','imgCancellaClick - inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // verifica presenza richiesta
  W010DM.selT050.Refresh;
  if not W010DM.selT050.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE),ESCLAMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  R600DtM.ItemsRichiestaGiust.RichiestaDaDefInConteggi:=RichiestaDaDefInConteggi;
  R600DtM.ItemsRichiestaGiust.CtrlRipristinoRich:=actCtrlRipristinoRich;
  R600DtM.ItemsRichiestaGiust.DefRichiesta:=actDefRichiesta;
  R600DtM.ItemsRichiestaGiust.SetDaoreAore:=SetDaoreAore;
  R600DtM.ItemsRichiestaGiust.IncludiTipoRichieste:=IncludiTipoRichieste;
  R600DtM.ItemsRichiestaGiust.PostAnnullaRichiesta:=PostAnnullaRichiesta;
  R600DtM.ItemsRichiestaGiust.PostInsRichiesta:=PostInsRichiesta;
  R600DtM.ItemsRichiestaGiust.selT050:=W010DM.selT050;
  R600DtM.ItemsRichiestaGiust.C018:=C018;
  R600DtM.ItemsRichiestaGiust.AnomaliaAss:=0;

  FDatiGiust.RisposteMsg.Clear;

  R600DtM.EliminaRichiestaGiust(FDatiGiust,W010DM.selT050.FieldByName('ID').AsInteger);
  GestisciRisposteRichiestaGiust;

  Log('Traccia','imgCancellaClick - fine');
end;

// empoli - commessa 2012/102.ini
procedure TW010FRichiestaAssenze.imgRevocaClick(Sender: TObject);
var
  FN: String;
begin
  Log('Traccia','imgRevocaClick - inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // verifica presenza richiesta
  W010DM.selT050.Refresh;
  if not W010DM.selT050.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE2),ESCLAMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  actInsRevoca('R',W010DM.selT050.FieldByName('DAL').AsDateTime,W010DM.selT050.FieldByName('AL').AsDateTime);
end;

procedure TW010FRichiestaAssenze.actInsRevoca(const PTipoRichiesta: String;
  const PDal, PAl: TDateTime);
// inserisce una richiesta di revoca oppure di cancellazione periodo
// PTipoRichiesta:
//   'R' -> revoca
//   'C' -> cancellazione periodo
// FN:
//   rowid del record della richiesta da rettificare
// PDal e PAl: periodo di revoca
//   'R' -> sono uguali al periodo originale
//   'C' -> sono quelli inseriti dall'utente, interni al periodo originale
begin
  R600DtM.ItemsRichiestaGiust.RichiestaDaDefInConteggi:=RichiestaDaDefInConteggi;
  R600DtM.ItemsRichiestaGiust.CtrlRipristinoRich:=actCtrlRipristinoRich;
  R600DtM.ItemsRichiestaGiust.DefRichiesta:=actDefRichiesta;
  R600DtM.ItemsRichiestaGiust.SetDaoreAore:=SetDaoreAore;
  R600DtM.ItemsRichiestaGiust.IncludiTipoRichieste:=IncludiTipoRichieste;
  R600DtM.ItemsRichiestaGiust.PostAnnullaRichiesta:=PostAnnullaRichiesta;
  R600DtM.ItemsRichiestaGiust.PostInsRichiesta:=PostInsRichiesta;
  R600DtM.ItemsRichiestaGiust.selT050:=W010DM.selT050;
  R600DtM.ItemsRichiestaGiust.C018:=C018;
  R600DtM.ItemsRichiestaGiust.AnomaliaAss:=0;

  FDatiGiust.RisposteMsg.Clear;

  R600DtM.RevocaRichiestaGiust(FDatiGiust,PTipoRichiesta,PDal,PAl);
  GestisciRisposteRichiestaGiust;
end;

procedure TW010FRichiestaAssenze.imgCancPeriodoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if not W010DM.selT050.SearchRecord('ROWID',FN,[srFromBeginning]) then
    Exit;
  DBGridColumnClick(Sender,FN);

  // crea frame per conferma annullamento
  if Assigned(W010CancPeriodoFM) then
    FreeAndNil(W010CancPeriodoFM);
  W010CancPeriodoFM:=TW010FCancPeriodoFM.Create(Self);
  FreeNotification(W010CancPeriodoFM);
  W010CancPeriodoFM.W010DM:=W010DM;
  W010CancPeriodoFM.C018:=C018;
  W010CancPeriodoFM.IdOrig:=W010DM.selT050.FieldByName('ID').AsInteger;
  //Alberto 09/04/2019 chiamata 124184: l'inserimento della richiesta viene fatta dal metodo actInsRevoca che prevede anche la Revoca parziale
  W010CancPeriodoFM.actInsRevoca:=actInsRevoca;
  W010CancPeriodoFM.Visualizza;
end;
// empoli - commessa 2012/102.fine

procedure TW010FRichiestaAssenze.TrasformaComponenti(const FN:String; DaTestoAControlli:Boolean);
// Trasforma i componenti della riga indicata da text a control e viceversa
// per la tabella delle assenze
var
  i,idxOre: Integer;
  TipoGiust: String;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  with (grdRichieste.medpCompgriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    // icone di azione
    Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
    Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
    Cell[0,2].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
    Cell[0,3].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
    // annulla e conferma
    Cell[0,4].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
    Cell[0,5].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
  end;

  if DaTestoAControlli then
  begin
    // numero ore / da ore - a ore
    idxOre:=grdRichieste.medpIndexColonna('D_DAORE_AORE');
    TipoGiust:=grdRichieste.medpValoreColonna(i,'TIPOGIUST');
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
    if TipoGiust = 'D' then
    begin
      grdRichieste.medpPreparaComponenteGenerico('C',0,1,DBG_LBL,'','','','','S');
      grdRichieste.medpPreparaComponenteGenerico('C',0,2,DBG_EDT,'ORA2','','','','S');
    end;
    grdRichieste.medpCreaComponenteGenerico(i,idxOre,grdRichieste.Componenti);

    (grdRichieste.medpCompCella(i,idxOre,0) as TmeIWEdit).Text:=grdRichieste.medpValoreColonna(i,'NUMEROORE');
    if TipoGiust = 'D' then
    begin
      (grdRichieste.medpCompCella(i,idxOre,1) as TmeIWLabel).Caption:='-';
      (grdRichieste.medpCompCella(i,idxOre,2) as TmeIWEdit).Text:=grdRichieste.medpValoreColonna(i,'AORE');
    end;
  end
  else
  begin
    idxOre:=grdRichieste.medpIndexColonna('D_DAORE_AORE');
    FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[idxOre]);
  end;
end;

procedure TW010FRichiestaAssenze.imgDefinisciClick(Sender: TObject);
// Definizione della richiesta preventiva
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if Operazione = OP_DEFINIZIONE then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_ANNULLA_OPERAZIONE),INFORMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  // reset dati giustificativo
  Operazione:=OP_DEFINIZIONE;
  FDatiGiust.Progressivo:=0;
  FDatiGiust.TipoRichiesta:='';
  FDatiGiust.IdRevocato:=-1;
  FDatiGiust.Motivazione:='';

  grdRichieste.medpBrowse:=False;
  TrasformaComponenti(FN,True);
end;

procedure TW010FRichiestaAssenze.imgAnnullaClick(Sender: TObject);
begin
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW010FRichiestaAssenze.imgConfermaDefClick(Sender: TObject);
var
  FN: String;
  i, c: Integer;
begin
  // effettua controlli bloccanti
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  // verifica presenza record
  if not W010DM.selT050.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE3),ESCLAMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  // imposta variabili per inserimento / aggiornamento
  c:=grdRichieste.medpIndexColonna('D_DAORE_AORE');
  FDatiGiust.NumeroOre:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit).Text;
  if grdRichieste.medpValoreColonna(i,'TIPOGIUST') = 'D' then
  begin
    FDatiGiust.AOre:=(grdRichieste.medpCompCella(i,c,2) as TmeIWEdit).Text;
  end;

  // definizione richiesta
  btnInserisciClick(nil);
end;

procedure TW010FRichiestaAssenze.imgDettaglioClick(Sender: TObject);
var idx: Integer;
begin
  idx:=StrToInt((Sender as TmeIWImageFile).FriendlyName);
  W010CalcoloCompetenzeFM:=TW010FCalcoloCompetenzeFM.Create(Self);
  FreeNotification(W010CalcoloCompetenzeFM);
  with W010CalcoloCompetenzeFM do
  begin
    TipoCumulo:=R600DtM.TipoCumulo; // AOSTA_REGIONE - commessa 2012/152
    lblProfiloAssenzeVal.Caption:=R600DtM.RiepilogoAssenze[idx].ProfiloAssenze;
    lblPeriodoCumuloVal.Caption:=R600DtM.RiepilogoAssenze[idx].PeriodoCumulo;
    lblCompLordeACVal.Caption:=R600DtM.RiepilogoAssenze[idx].CompLordeAC;
    lblVarPeriodiRapportoVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarPeriodiRapporto;
    lblAbbattiAssCessVal.Caption:=R600DtM.RiepilogoAssenze[idx].AbbattiAssCess;
    lblDecurtazNonMaturaVal.Caption:=R600DtM.RiepilogoAssenze[idx].DecurtazNonMatura;
    lblVarPartTimeVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarPartTime;
    lblVarAbilitazioneAnagraficaVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarAbilitazioneAnagrafica;
    // AOSTA_REGIONE - commessa 2012/152.ini
    lblVarFruizMMInteriVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarFruizMMInteri;
    lblVarMaxIndividualeVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarMaxIndividuale;
    lblVarFruizMMContinuativiVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarFruizMMContinuativi;
    // AOSTA_REGIONE - commessa 2012/152.fine
    lblVarCompManualeVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarCompManuale;
    lblCompNetteACVal.Caption:=R600DtM.RiepilogoAssenze[idx].CompNetteAC;
    memPartTimeVal.Lines.Text:=R600DtM.RiepilogoAssenze[idx].PartTime;
    lblFruizMinimaAC.Caption:=R600DtM.RiepilogoAssenze[idx].TitoloFruizMinimaAC;
    lblFruizMinimaACVal.Caption:=R600DtM.RiepilogoAssenze[idx].FruizMinimaAC;
    Visualizza;
  end;
end;

procedure TW010FRichiestaAssenze.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W010DM.selT050 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE4),ESCLAMA);
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
procedure TW010FRichiestaAssenze.imgAllegClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W010DM.selT050 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE4),ESCLAMA);
      Exit;
    end;
  end;
  VisualizzaAllegati(Sender);
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

procedure TW010FRichiestaAssenze.RichiestaDaDefInConteggi(Includi: Boolean);
// Permette di escludere la richiesta preventiva in fase di definizione
// dai conteggi, impostando un tipo richiesta fittizio.
// In caso di errore nei conteggi deve essere ripristinata, mi raccomando!
var RigaId: String;
begin
  RigaId:=cdsT050.FieldByName('DBG_ROWID').AsString;
  with W010DM do
  begin
    // verifica presenza record
    if not selT050.SearchRecord('ROWID',RigaId,[srFromBeginning]) then
    begin
      Log('Errore','Richiesta da definire non più disponibile');
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE3),ESCLAMA);
      Exit;
    end;

    // modifica tipo richiesta
    C018.Id:=selT050.FieldByName('ID').AsInteger;
    C018.SetTipoRichiesta(IfThen(Includi,'P','X'));
    SessioneOracle.Commit;

    // aggiorna il record del dataset
    selT050.RefreshOptions:=[roAllFields];//Serve per aggiornare i campi in join con la T050
    selT050.RefreshRecord;
    selT050.RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
  end;
end;

procedure TW010FRichiestaAssenze.btnImportaClick(Sender: TObject);
var
  Errore,Msg,ElencoRichieste,CampoIdRel,IdRich: String;
  NumScartate,NumRichieste,ContaElementi: Integer;
  Ok,AvvisoRiesegui: Boolean;
begin
  AutorizzazioniDaConfermare:=False;

  // determina l'elenco delle richieste attualmente presenti nel dataset
  W010DM.selT050.Refresh; // aggiorna elenco richieste
  if W010DM.selT050.RecordCount = 0 then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
    Exit;
  end;

  {
   /* richiesta definitiva o revoca o cancellazione con autorizzazione impostata */
   (t850.tipo_richiesta in ('D','R','C') and t850.stato in ('S','N')) or
   /* qualsiasi richiesta con revoca / cancellazione autorizzata */
   (t850r.stato = 'S') or
   /* richiesta preventiva negata */
   (t850.tipo_richiesta = 'P' and t850.stato = 'N')
  }

  with W010DM.selT050 do
  begin
    ElencoRichieste:='';
    ContaElementi:=0;
    AvvisoRiesegui:=RecordCount > ORACLE_MAX_IN_VALUES;
    First;
    while not Eof do
    begin
      // ogni record può aggiungere all'elenco "IN" fino a due richieste
      // pertanto se il conteggio arriva a MAX - 1 interrompe il ciclo
      if ContaElementi + 1 >= ORACLE_MAX_IN_VALUES then
        Break;

      // aggiunge l'id della richiesta attuale all'elenco delle richieste da considerare
      IdRich:=FieldByName('ID').AsString;
      if R180CercaParolaIntera(IdRich,ElencoRichieste,',') = 0 then
      begin
        inc(ContaElementi);
        ElencoRichieste:=ElencoRichieste + IdRich + ',';
      end;

      // SGIULIANOMILANESE_COMUNE - chiamata <80446>.ini
      // include anche la relativa revoca / richiesta, indipendentemente dallo stato
      // di autorizzazione, al fine di elaborare correttamente le richieste revocate
      // la query del dataset A004MW.selT050 si occuperà poi di filtrare in modo corretto
      // le sole richieste realmente da elaborare
      CampoIdRel:=IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'R','ID_REVOCATO','ID_REVOCA');
      if not FieldByName(CampoIdRel).IsNull then
      begin
        IdRich:=FieldByName(CampoIdRel).AsString;
        if R180CercaParolaIntera(IdRich,ElencoRichieste,',') = 0 then
        begin
          ElencoRichieste:=ElencoRichieste + IdRich + ',';
          inc(ContaElementi);
        end;
      end;
      // SGIULIANOMILANESE_COMUNE - chiamata <80446>.fine

      Next;
    end;
  end;
  ElencoRichieste:=Copy(ElencoRichieste,1,Length(ElencoRichieste) - 1);

  Ok:=R600DtM.AcquisizioneRichiesteAuto(ElencoRichieste,Errore,NumScartate,NumRichieste);
  if NumRichieste = 0 then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
    Exit;
  end;

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  // messaggio di fine elaborazione
  if Ok then
  begin
    // elaborazione ok / warning
    if Errore = '' then
      Msg:=A000TraduzioneStringhe(A000MSG_MSG_ELAB_OK)
    else
      Msg:=Format(A000TraduzioneStringhe(A000MSG_MSG_ELAB_WARNING),[Errore]);

    if NumScartate > 0 then
      Msg:=Msg + CRLF + A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_GIA_IMPORTATE);
    MsgBox.AddMessage(Msg);
  end
  else
  begin
    // anomalie durante elaborazione
    MsgBox.AddMessage(A000TraduzioneStringhe(A000MSG_MSG_ELAB_ERRORE) + CRLF +
                      A000TraduzioneStringhe(A000MSG_W010_MSG_CONSULTA_NOTIFICHE_ELAB));
  end;

  // richieste > del limite della 'in' di oracle
  if AvvisoRiesegui then
    MsgBox.AddMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_RIESEGUI_IMPORTAZIONE));

  MsgBox.ShowMessages;
end;

procedure TW010FRichiestaAssenze.btnNascondiRiepilogoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  // 18/04/2019 - Bug IntraWEB 15.0.18:
  //con TemplateProcessor.RenderStyle = False, settare la proprietà Visible in Async non funziona
  //si usa il css "invisibile"
  grdRiepilogo.Visible:=False;
  grdRiepilogo.CSS:=grdRiepilogo.CSS + ' ' + 'invisibile';
  lblCausale.Caption:='';
  btnNascondiRiepilogo.Visible:=False;
  btnNascondiRiepilogo.CSS:=btnNascondiRiepilogo.CSS + ' ' + 'invisibile';
end;

procedure TW010FRichiestaAssenze.btnInserisciClick(Sender: TObject);
var
  FamPresente: Boolean;
  i: Integer;
  LNumOrdFam: Integer;
  LValore,LDataStr:String;  
  LResCtrl: TResCtrl;
begin
  Log('Traccia','btnInserisciClick - inizio');
  AnomaliaAss:=0;

  FDatiGiust.TipoRichiesta:='';
  if Sender = btnInserisci then
  begin
    Operazione:=OP_INSERIMENTO;
    i:=0;
  end
  else
  begin
    Operazione:=OP_DEFINIZIONE;
    i:=grdRichieste.medpRigaDiCompGriglia(cdsT050.FieldByName('DBG_ROWID').AsString);
  end;
  FDatiGiust.IdRevocato:=-1;
  Log('Traccia','btnInserisciClick: operazione = ' + Operazione);

  FDatiGiust.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  FDatiGiust.NoteIns:=IfThen(chkNoteIns.Checked,Trim(memNoteIns.Text),'');

  WR000DM.selDatiBloccati.Close;

  // causale
  if Operazione = OP_INSERIMENTO then
  begin
    if cmbCausaliDisponibili.ItemIndex = 0 then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_ERR_INS_GIUSTIF),INFORMA);
      cmbCausaliDisponibili.SetFocus;
      Exit;
    end;
    FDatiGiust.Causale:=Trim(Copy(cmbCausaliDisponibili.Text,1,5));
  end
  else
  begin
    FDatiGiust.Causale:=Trim(Copy(grdRichieste.medpValoreColonna(i,'CAUSALE'),1,5));
  end;

  FDatiGiust.Minuti:=0;
  FDatiGiust.AMinuti:=0;
  if VarToStr(WR000DM.selT265.Lookup('Codice',FDatiGiust.Causale,'Codice')) = FDatiGiust.Causale then
    FDatiGiust.TipoCausale:=TTipoCausaleRec.Assenza
  else
    FDatiGiust.TipoCausale:=TTipoCausaleRec.Presenza;

  // periodo dal - al
  if Operazione = OP_INSERIMENTO then
  begin
    if FDatiGiust.TipoCausale = TTipoCausaleRec.Assenza then
    begin
      try
        FDatiGiust.Dal:=StrToDate(edtDal.Text);
      except
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO),INFORMA);
        edtDal.SetFocus;
        Exit;
      end;
    end;
    try
      FDatiGiust.Al:=StrToDate(edtAl.Text);
      //Per le causali di presenza è possibile specificare solo un giorno
      if FDatiGiust.TipoCausale = TTipoCausaleRec.Presenza  then
      begin
        FDatiGiust.Dal:=FDatiGiust.Al;
      end;
    except
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_ERR_FMT_DATA_FINE),
                        [IfThen(FDatiGiust.TipoCausale = TTipoCausaleRec.Assenza,
                                A000TraduzioneStringhe(A000MSG_W010_ERR_FMT_DATA_FINE_OPT1),
                                A000TraduzioneStringhe(A000MSG_W010_ERR_FMT_DATA_FINE_OPT2))]),INFORMA);
      edtAl.SetFocus;
      Exit;
    end;

    if FDatiGiust.Al - FDatiGiust.Dal > 366 then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_DATE_STESSO_ANNO),INFORMA);
      edtAl.SetFocus;
      Exit;
    end;

    if (FDatiGiust.Dal > FDatiGiust.Al) then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_DATA_FINE_MAGG_INIZIO),INFORMA);
      edtDal.SetFocus;
      Exit;
    end;
  end
  else
  begin
    // periodo dal - al
    FDatiGiust.Dal:=StrToDate(grdRichieste.medpValoreColonna(i,'DAL'));
    FDatiGiust.Al:=StrToDate(grdRichieste.medpValoreColonna(i,'AL'));
  end;

  // motivazione
  FDatiGiust.Motivazione:='';
  if GestioneMotivazioniCausali then
  begin
    if Operazione = OP_INSERIMENTO then
    begin
      // bugfix.ini
      // la proprietà visible non viene mantenuta correttamente usando eventi async
      //if cmbMotivazione.Visible then
      if ListaMotivazioni.Count > 0 then
      // bugfix.fine
      begin
        if cmbMotivazione.ItemIndex < 0 then
        begin
          MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_ERR_MOTIVAZIONE_NON_INDICATA),INFORMA);
          cmbMotivazione.SetFocus;
          Exit;
        end;
        FDatiGiust.Motivazione:=TValore(cmbMotivazione.Items.Objects[cmbMotivazione.ItemIndex]).Valore;
      end;
    end
    else
    begin
      FDatiGiust.Motivazione:=grdRichieste.medpValoreColonna(i,'MOTIVAZIONE');
    end;
  end;

  if Operazione = OP_INSERIMENTO then
  begin
    case rgpTipo.ItemIndex of
      0: begin
           FDatiGiust.TipoGiust:='I';
         end;
      1: begin
           FDatiGiust.TipoGiust:='M';
         end;
      2: begin
           FDatiGiust.TipoGiust:='N';
         end;
      3: begin
           FDatiGiust.TipoGiust:='D';
         end;
    else
      begin
        Log('Errore','Inserimento richiesta: tipo giustificativo nullo! rgpTipo.ItemIndex = ' + IntToStr(rgpTipo.ItemIndex));
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_TIPO_FRUIZIONE),INFORMA);
        rgpTipo.SetFocus;
        Exit;
      end;
    end;

    FDatiGiust.NumeroOre:=edtOre.Text;
    FDatiGiust.AOre:=edtAOre.Text;
    FDatiGiust.NoteGiustificativo:=edtNote.Text;
  end
  else
  begin
    FDatiGiust.TipoGiust:=grdRichieste.medpValoreColonna(i,'TIPOGIUST');
    if FDatiGiust.TipoGiust = '' then
    begin
      Log('Errore','Definizione richiesta: tipo giustificativo nullo! ID = ' + grdRichieste.medpValoreColonna(i,'ID'));
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_TIPO_FRUIZIONE2),INFORMA);
      rgpTipo.SetFocus;
      Exit;
    end;
  end;

  // imposta variabile Giustif
  Giustif.Inserimento:=True;
  Giustif.DaOre:=IfThen(Trim(FDatiGiust.NumeroOre) = '','.',FDatiGiust.NumeroOre);
  Giustif.AOre:=IfThen(Trim(FDatiGiust.AOre) = '','.',FDatiGiust.AOre);
  Giustif.Modo:=R180CarattereDef(FDatiGiust.TipoGiust,1,#0);
  Giustif.Causale:=FDatiGiust.Causale;

  // controlli per giustificativo a ore
  if (FDatiGiust.TipoGiust = 'N') and (Trim(FDatiGiust.NumeroOre) = '') then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_MSG_NUM_ORE_FRUIZIONE),INFORMA);
    if Operazione = OP_INSERIMENTO then
      edtOre.SetFocus;
    Exit;
  end;
  if (FDatiGiust.TipoGiust = 'D') and ((Trim(FDatiGiust.NumeroOre) = '') or (Trim(FDatiGiust.AOre) = '')) then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_MSG_DURATA_FRUIZIONE),INFORMA);
    if Operazione = OP_INSERIMENTO then
      edtAOre.SetFocus;
    Exit;
  end;

  // validità dati da ore - a ore
  if Trim(FDatiGiust.NumeroOre) <> '' then
  begin
    try
      R180OraValidate(FDatiGiust.NumeroOre);
    except
      on E:Exception do
      begin
        MsgBox.MessageBox(E.Message,INFORMA);
        if Operazione = OP_INSERIMENTO then
          edtOre.SetFocus;
        Exit;
      end;
    end;
  end;
  if Trim(FDatiGiust.AOre) <> '' then
  begin
    try
      R180OraValidate(FDatiGiust.AOre);
    except
      on E:Exception do
      begin
        MsgBox.MessageBox(E.Message,INFORMA);
        if Operazione = OP_INSERIMENTO then
          edtAOre.SetFocus;
        Exit;
      end;
    end;
  end;

  // controlla periodo da ore - a ore
  LResCtrl:=FDatiGiust.ValidaPeriodoOrario;
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,INFORMA);
    Exit;
  end;

  //Nuova gestione dei controlli condivisa tra web e mobile
  // familiare di riferimento
  LNumOrdFam:=-1;
  FDatiGiust.Datanas:=DATE_NULL;
  if FDatiGiust.TipoCausale = TTipoCausaleRec.Assenza then
  begin
    WR000DM.selT265.SearchRecord('CODICE',FDatiGiust.Causale,[srFromBeginning]);
    if ((R180CarattereDef(WR000DM.selT265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
        (R180CarattereDef(WR000DM.selT265.FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D'])) then
    begin
      if Operazione = OP_INSERIMENTO then
        FamPresente:=cmbFamiliari.ItemIndex > 0
      else
        FamPresente:=grdRichieste.medpValoreColonna(i,'DATANAS') <> '';
      if FamPresente then
      begin
        if Operazione = OP_INSERIMENTO then
          LValore:=cmbFamiliari.Items.ValueFromIndex[cmbFamiliari.ItemIndex]
        else
          LValore:=ListaFamiliari.ValueFromIndex[ListaFamiliari.IndexOfName(grdRichieste.medpValoreColonna(i,'DATANAS'))];
        // LValore è nel formato <NumOrd>|<DATANAS in ddmmyyyyhhnnss>
        LNumOrdFam:=StrToInt(Copy(LValore,1,Pos('|',LValore)-1));
        LDataStr:=Copy(LValore,Pos('|',LValore)+1,Length(LValore)-Pos('|',LValore));
        // posizionamento sul record del familiare
        WR000DM.selSG101.SearchRecord('NUMORD;DATA_STR',VarArrayOf([LNumOrdFam,LDataStr]),[srFromBeginning]);
        if LNumOrdFam > -1 then
          FDatiGiust.Datanas:=WR000DM.selSG101.FieldByName('DATA').AsDateTime;
      end;
    end;
  end;

  R600DtM.ItemsRichiestaGiust.RichiestaDaDefInConteggi:=RichiestaDaDefInConteggi;
  R600DtM.ItemsRichiestaGiust.CtrlRipristinoRich:=actCtrlRipristinoRich;
  R600DtM.ItemsRichiestaGiust.DefRichiesta:=actDefRichiesta;
  R600DtM.ItemsRichiestaGiust.SetDaoreAore:=SetDaoreAore;
  R600DtM.ItemsRichiestaGiust.IncludiTipoRichieste:=IncludiTipoRichieste;
  R600DtM.ItemsRichiestaGiust.PostAnnullaRichiesta:=PostAnnullaRichiesta;
  R600DtM.ItemsRichiestaGiust.PostInsRichiesta:=PostInsRichiesta;
  R600DtM.ItemsRichiestaGiust.selT050:=W010DM.selT050;
  R600DtM.ItemsRichiestaGiust.C018:=C018;
  R600DtM.ItemsRichiestaGiust.AnomaliaAss:=0;

  FDatiGiust.RisposteMsg.Clear;
  R600DtM.ControlliRichiestaGiust(FDatiGiust,Operazione);
  GestisciRisposteRichiestaGiust;

  Log('Traccia','btnInserisciClick - fine');
end;

procedure TW010FRichiestaAssenze.actIns0;
begin
  R600DtM.ControlliRichiestaGiust0;
  GestisciRisposteRichiestaGiust;
end;

procedure TW010FRichiestaAssenze.actIns1;
// Ciclo di controlli sul periodo di inserimento
begin
  R600DtM.ControlliRichiestaGiust1;
  GestisciRisposteRichiestaGiust;
end;

procedure TW010FRichiestaAssenze.actIns2;
// Seconda parte dei controlli di inserimento
begin
  R600DtM.ControlliRichiestaGiust2;
  GestisciRisposteRichiestaGiust;
end;

procedure TW010FRichiestaAssenze.actInsRichiesta;
// inserimento della richiesta
begin
  R600DtM.InsRichiestaGiust;
  GestisciRisposteRichiestaGiust;
end;

procedure TW010FRichiestaAssenze.ConfermaInsRichiesta;
{
var
  Errore,TipoRichiesta: String;
  IdIns,NumScartate:Integer;
  D: TDateTime;
}
begin
  R600DtM.ConfermaInsRichiesta;
  GestisciRisposteRichiestaGiust;
end;

procedure TW010FRichiestaAssenze.AnnullaInsRichiesta;
begin
  R600DtM.AnnullaInsRichiesta;
end;

procedure TW010FRichiestaAssenze.SetDaoreAore;
begin
  if Operazione = OP_INSERIMENTO then
  begin
    edtOre.Text:=FDatiGiust.NumeroOre;
    edtAOre.Text:=FDatiGiust.AOre;
  end;
end;

procedure TW010FRichiestaAssenze.IncludiTipoRichieste;
begin
  // corregge filtri visualizzazione al fine di includere la richiesta appena inserita
  C018.Periodo.Estendi(FDatiGiust.Dal,FDatiGiust.Al);
  C018.IncludiTipoRichieste(trDaAutorizzare);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  C018.StrutturaSel:=C018STRUTTURA_TUTTE;
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
end;

procedure TW010FRichiestaAssenze.PostInsRichiesta;
begin
  try
    if Assigned(W010CancPeriodoFM) then
      FreeAndNil(W010CancPeriodoFM);
  except
  end;

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  // posizionamento su riga appena inserita
  DBGridColumnClick(nil,R600DtM.ItemsRichiestaGiust.IdIns.ToString);
end;

procedure TW010FRichiestaAssenze.PostAnnullaRichiesta;
begin
  try
    if Assigned(W010CancPeriodoFM) then
      FreeAndNil(W010CancPeriodoFM);
  except
  end;

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW010FRichiestaAssenze.GestisciRisposteRichiestaGiust;
begin
  if FDatiGiust.RisposteMsg.Bloccante then
  begin
    //Messaggio bloccante
    if Operazione = OP_INSERIMENTO then
    begin
      if FDatiGiust.RisposteMsg.ErrCod = ERR_DATIGIUST_016 then
      begin
        cmbFamiliari.SetFocus;
      end
      else if FDatiGiust.RisposteMsg.ErrCod = ERR_DATIGIUST_017 then
      begin
        cmbFamiliari.SetFocus;
      end
      else if FDatiGiust.RisposteMsg.ErrCod = ERR_DATIGIUST_022 then
      begin
        edtOre.Text:=FDatiGiust.RisposteMsg.Attributo;
        edtOre.SetFocus;
      end
      else if FDatiGiust.RisposteMsg.ErrCod = ERR_DATIGIUST_023 then
      begin
        edtAOre.Text:=FDatiGiust.RisposteMsg.Attributo;
        edtAOre.SetFocus;
      end
      else if FDatiGiust.RisposteMsg.ErrCod = ERR_DATIGIUST_024 then
      begin
        edtOre.Text:=FDatiGiust.RisposteMsg.Attributo;
        edtOre.SetFocus;
      end
      else if FDatiGiust.RisposteMsg.ErrCod = ERR_DATIGIUST_025 then
      begin
        edtAOre.Text:=FDatiGiust.RisposteMsg.Attributo;
        edtAOre.SetFocus;
      end
      else if FDatiGiust.RisposteMsg.ErrCod = ERR_DATIGIUST_029 then
      begin
        edtOre.SetFocus;
      end;
    end;
    if FDatiGiust.RisposteMsg.ErrCod = ERR_DATIGIUST_027 then
    begin
      Log('Errore',FDatiGiust.RisposteMsg.ErrMsg);
    end
    else if FDatiGiust.RisposteMsg.ErrCod = ERR_DATIGIUST_028 then
    begin
      Log('Errore',FDatiGiust.RisposteMsg.ErrMsg);
    end;
    MsgBox.MessageBox(FDatiGiust.RisposteMsg.ErrMsg,ESCLAMA,FDatiGiust.RisposteMsg.ErrTitolo);
    Exit;
  end
  else if FDatiGiust.RisposteMsg.ErrMsg <> '' then
  begin
    //Mesaggio non bloccante: richiesta riposta dall'operatore
    if FDatiGiust.RisposteMsg.ErrCod = MSG_DATIGIUST_001 then
    begin
      Messaggio('Conferma',FDatiGiust.RisposteMsg.ErrMsg,actIns0,nil);
    end
    else if FDatiGiust.RisposteMsg.ErrCod = MSG_DATIGIUST_002 then
    begin
      if Operazione = OP_INSERIMENTO then
        Messaggio(FDatiGiust.RisposteMsg.ErrTitolo,FDatiGiust.RisposteMsg.ErrMsg,actInsRichiesta,nil)
      else
        Messaggio(FDatiGiust.RisposteMsg.ErrTitolo,FDatiGiust.RisposteMsg.ErrMsg,actDefRichiesta,nil);
    end
    else if FDatiGiust.RisposteMsg.ErrCod.Substring(0,Length(MSG_DATIGIUST_003)) = MSG_DATIGIUST_003 then
    begin
      Messaggio(FDatiGiust.RisposteMsg.ErrTitolo,FDatiGiust.RisposteMsg.ErrMsg,actIns1,nil);
    end
    else if FDatiGiust.RisposteMsg.ErrCod = MSG_DATIGIUST_009 then
    begin
      Messaggio(FDatiGiust.RisposteMsg.ErrTitolo,FDatiGiust.RisposteMsg.ErrMsg,ConfermaInsRichiesta,AnnullaInsRichiesta);
    end;
    Exit;
  end
  else
  begin
    // nulla da fare
  end;
end;

procedure TW010FRichiestaAssenze.actDefRichiesta;
// definizione della richiesta preventiva
var
  GiustTipoChar: Char;
  IsModificata, Ok: Boolean;
  IdDef, NumScartate, NumRichieste: Integer;
  ErrMsg: String;
begin
  Log('Traccia','actDefRichiesta');

  // aggiorna la richiesta
  with W010DM.selT050 do
  begin
    // verifica presenza record
    // no refresh in questo caso
    if not SearchRecord('ROWID',cdsT050.FieldByName('DBG_ROWID').AsString,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICH_NON_DISPONIBILE3),INFORMA);
      Exit;
    end;

    // determina se sono stati modificati dei dati
    GiustTipoChar:=R180CarattereDef(FDatiGiust.TipoGiust,1,#0);
    IsModificata:=False;
    if (GiustTipoChar in ['N','D']) or
       ((GiustTipoChar = 'M') and (R180OreMinutiExt(FDatiGiust.NumeroOre) > 0)) then
      IsModificata:=IsModificata or (FieldByName('NUMEROORE').AsString <> FDatiGiust.NumeroOre);
    if GiustTipoChar = 'D' then
      IsModificata:=IsModificata or (FieldByName('AORE').AsString <> FDatiGiust.AOre);

    // aggiorna i dati della richiesta per renderla definitiva
    try
      RefreshRecord;
      Edit;
    except
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_MODIFICATA),INFORMA);
      Exit;
    end;

    // imposta tipo richiesta e salva valori richiesta preventiva
    IdDef:=FieldByName('ID').AsInteger;
    FieldByName('NUMEROORE_PREV').AsString:=FieldByName('NUMEROORE').AsString;
    FieldByName('AORE_PREV').AsString:=FieldByName('AORE').AsString;
    if IsModificata then
    begin
      // salva il nuovo orario del giustificativo
      if (GiustTipoChar in ['N','D']) or
         ((GiustTipoChar = 'M') and (R180OreMinutiExt(FDatiGiust.NumeroOre) > 0)) then
        FieldByName('NUMEROORE').AsString:=FDatiGiust.NumeroOre;
      if GiustTipoChar = 'D' then
        FieldByName('AORE').AsString:=FDatiGiust.AOre;
    end;

    // post dei dati
    try
      RegistraLog.SettaProprieta('M',C018.TabellaIter,medpCodiceForm,W010DM.selT050,True);
      Post;
      RegistraLog.RegistraOperazione;
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=IdDef;
      C018.SetTipoRichiesta('D');
      C018.SetStato(C018SI,C018.LivAutIntermedia);
      // EMPOLI_ASL11: segnala anomalia su dati modificati (T852)
      if AnomaliaAss <> 0 then
        C018.SetDatoAutorizzatore('SUPERO_COMPETENZE','S',0);
      //Alberto 08/11/2018 - Orbassano_HSLuigi: Se è prevista l'acquisizione automatica, e la richiesta è subito autorizzata automaticamente, si procede con la sua acquisizione
      if (C018.StatoRichiesta <> '') then
        Ok:=R600DtM.AcquisizioneRichiesteAuto(C018.Id.ToString,ErrMsg,NumScartate,NumRichieste);
      SessioneOracle.Commit;
      RefreshOptions:=[roAllFields];
      RefreshRecord;
      RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
      grdRichieste.medpAllineaRecordCDS;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_FMT_DEF_FALLITA),[E.Message]),ESCLAMA);
      end;
    end;
  end;

  // corregge filtri visualizzazione al fine di includere la richiesta appena definita
  if IsModificata then
    C018.IncludiTipoRichieste(trDaAutorizzare)
   else
    C018.IncludiTipoRichieste(trAutorizzate);
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  // posizionamento su riga appena definita
  DBGridColumnClick(nil,IntToStr(IdDef));
end;

procedure TW010FRichiestaAssenze.actCtrlRipristinoRich;
begin
  // ripristina il tipo richiesta in modo che sia nuovamente
  // considerata nei conteggi
  if Operazione = OP_DEFINIZIONE then
    RichiestaDaDefInConteggi(True);
end;

procedure TW010FRichiestaAssenze.btnVisualizzaRiepilogoClick(Sender: TObject);
var G:TGiustificativo;
    i:Integer;
    Prog:Integer;
    dDataRiep:TDateTime;
    EsisteResiduo,EsisteFamiliare:Boolean;
begin
  try
    dDataRiep:=StrToDate(edtRiepAl.Text);
  except
    edtRiepAl.SetFocus;
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_DATA_RIEP));
    exit;
  end;
  Log('Traccia','btnRiepilogoClick - inizio');
  Prog:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  SetLength(R600DtM.RiepilogoAssenze,0);
  G.Inserimento:=False;
  G.Modo:='I';
  G.Causale:=Trim(Copy(StringReplace(cmbCausaliDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,5));
  if G.Causale = '' then
  begin
    cmbCausaliDisponibili.SetFocus;
    if WR000DM.Responsabile then
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_SELEZIONARE_RICH_RIEP))
    else
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_CAUSALE_RIEP));
    exit;
  end;
  lblCausale.Caption:=G.Causale + ' - ' + Trim(Copy(StringReplace(cmbCausaliDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),6,40));
  EsisteFamiliare:=False;
  if R600DtM = nil then
    CreaR600;
  try
    if R180CarattereDef(VarToStr(WR000DM.selT265.Lookup('Codice',G.Causale,'Cumulo_Familiari')),1,'N') in ['S','D'] then
      with R600DtM.selT040DATANAS do
      begin
        EsisteFamiliare:=True;
        Close;
        SetVariable('Progressivo',Prog);
        SetVariable('Causale',G.Causale);
        SetVariable('Data1',dDataRiep(*EncodeDate(1900,1,1)*));
        SetVariable('Data2',dDataRiep);
        Open;
        while not Eof do
        begin
          R600DtM.RiepilogaAssenze(Prog,dDataRiep,G,True,FieldByName('DataNas').AsDateTime);
          Next;
        end;
        CloseAll;
      end
    else
      R600DtM.RiepilogaAssenze(Prog,dDataRiep,G,False,0); (*Passo 0 perchè qui non serve questo parametro*)
  finally
    // TORINO_ASLTO2 - 2013/044 - R600 utilizzato per controlli causali concatenate
    // FreeAndNil(R600DtM);
    // TORINO_ASLTO2.fine
  end;
  grdRiepilogo.RowCount:=0;
  grdRiepilogo.ColumnCount:=0;
  grdRiepilogo.Clear;
  grdRiepilogo.Visible:=True;
  grdRiepilogo.RowCount:=Length(R600DtM.RiepilogoAssenze) + 1;
  grdRiepilogo.ColumnCount:=12;
  grdRiepilogo.Cell[0,0].Text:='';
  grdRiepilogo.Cell[0,1].Text:='Familiare';
  grdRiepilogo.Cell[0,2].Text:='Misura';
  grdRiepilogo.Cell[0,3].Text:='Comp.prec';
  grdRiepilogo.Cell[0,4].Text:='Comp.corr';
  grdRiepilogo.Cell[0,5].Text:='Comp.totali';
  grdRiepilogo.Cell[0,6].Text:='Fruito prec.';
  grdRiepilogo.Cell[0,7].Text:='Fruito corr.';
  grdRiepilogo.Cell[0,8].Text:='Fruito tot.';
  grdRiepilogo.Cell[0,9].Text:='Fruito rich.';
  grdRiepilogo.Cell[0,10].Text:='Fruito aut.';
  grdRiepilogo.Cell[0,11].Text:='Residuo';
  EsisteResiduo:=False;
  for i:=0 to High(R600DtM.RiepilogoAssenze) do
  begin
    if R600DtM.RiepilogoAssenze[i].EsisteResiduo then
      EsisteResiduo:=True;
    grdRiepilogo.Cell[i + 1,0].Control:=TmeIWImageFile.Create(Self);
    with (grdRiepilogo.Cell[i + 1,0].Control as TmeIWImageFile) do
    begin
      Css:='icona';
      Hint:='Dettaglio del calcolo competenze';
      AltText:=Hint;
      ImageFile.FileName:=fileImgDettaglio;
      FriendlyName:=IntToStr(i);
      OnClick:=imgDettaglioClick;
    end;
    grdRiepilogo.Cell[i + 1,0].Clickable:=True;
    with R600DtM.RiepilogoAssenze[i] do
    begin
      grdRiepilogo.Cell[i + 1,1].Text:=Familiare;
      grdRiepilogo.Cell[i + 1,2].Text:=IfThen(ArrotOre2Giorni,'Giorni',UM);
      grdRiepilogo.Cell[i + 1,3].Text:=IfThen(ArrotOre2Giorni,H_CP,CP);
      grdRiepilogo.Cell[i + 1,4].Text:=IfThen(ArrotOre2Giorni,H_CC,CC);
      grdRiepilogo.Cell[i + 1,5].Text:=IfThen(ArrotOre2Giorni,H_CT,CT);
      grdRiepilogo.Cell[i + 1,6].Text:=IfThen(ArrotOre2Giorni,H_FP,FP);
      grdRiepilogo.Cell[i + 1,7].Text:=IfThen(ArrotOre2Giorni,H_FC,FC);
      grdRiepilogo.Cell[i + 1,8].Text:=IfThen(ArrotOre2Giorni,H_FT,FT);
      grdRiepilogo.Cell[i + 1,9].Text:=IfThen(ArrotOre2Giorni,H_IterRich,IterRich);
      grdRiepilogo.Cell[i + 1,10].Text:=IfThen(ArrotOre2Giorni,H_IterAut,IterAut);
      grdRiepilogo.Cell[i + 1,11].Text:=IfThen(ArrotOre2Giorni,H_R,R);
    end;
  end;
  for i:=0 to grdRiepilogo.RowCount - 1 do
  begin
    if not EsisteFamiliare then
      grdRiepilogo.Cell[i,1].Css:='invisibile';
    if not EsisteResiduo then
    begin
      grdRiepilogo.Cell[i,3].Css:='invisibile';
      grdRiepilogo.Cell[i,4].Css:='invisibile';
      grdRiepilogo.Cell[i,6].Css:='invisibile';
      grdRiepilogo.Cell[i,7].Css:='invisibile';
    end;
  end;

  btnNascondiRiepilogo.Visible:=True;
  // 18/04/2019 - Bug IntraWEB 15.0.18:
  //con TemplateProcessor.RenderStyle = False, settare la proprietà Visible in Async non funziona
  //si usa il css "invisibile"
  grdRiepilogo.CSS:=grdRiepilogo.CSS.Replace(' invisibile','');
  btnNascondiRiepilogo.CSS:=btnNascondiRiepilogo.CSS.Replace(' invisibile','');

  Log('Traccia','btnRiepilogoClick - fine');
end;

procedure TW010FRichiestaAssenze.btnStampaRicevutaClick(Sender: TObject);
// stampa pdf della ricevuta di autorizzazione
var
  rvComp: TRaveComponent;
  L: TStringList;
  dconnDettaglio: TRaveDataConnection;
  EnteIndirizzo,NomeFile: String;
begin
  Log('Traccia','StampaRicevuta - inizio');
  CSStampa.Enter;
  rvSystem:=TRVSystem.Create(Self);
  rvProject:=TRVProject.Create(Self);
  connDettaglio:=TRVDataSetConnection.Create(Self);
  rvRenderPDF:=TRvRenderPDF.Create(Self);
  L:=TStringList.Create;
  try
    cdsAutorizzazione.Open;
    cdsAutorizzazione.EmptyDataSet;

    rvProject.Engine:=RvSystem;
    rvRenderPDF.Active:=True;
    rvProject.ProjectFile:=gSC.ContentPath + 'report\W010RicevutaAutorizzazione.rav';
    connDettaglio.Name:='connDettaglio';
    connDettaglio.DataSet:=cdsAutorizzazione;
    connDettaglio.RuntimeVisibility:=RpCon.rtNone;

    with W010DM do
    begin
      if selT050.SearchRecord('ROWID',(Sender as TmeIWImageFile).FriendlyName,[srFromBeginning]) then
      begin
        C018.CodIter:=selT050.FieldByName('COD_ITER').AsString;
        C018.Id:=selT050.FieldByName('ID').AsInteger;
        // inserisce i dati nel client dataset
        with cdsAutorizzazione do
        begin
          Append;
          FieldByName('PROGRESSIVO').Value:=selT050.FieldByName('PROGRESSIVO').Value;
          FieldByName('NOMINATIVO').Value:=selT050.FieldByName('NOMINATIVO').Value;
          FieldByName('MATRICOLA').Value:=selT050.FieldByName('MATRICOLA').Value;
          FieldByName('SESSO').Value:=selT050.FieldByName('SESSO').Value;
          FieldByName('CAUSALE').Value:=selT050.FieldByName('CAUSALE').Value;
          FieldByName('TIPOGIUST').Value:=selT050.FieldByName('TIPOGIUST').Value;
          FieldByName('DAL').Value:=selT050.FieldByName('DAL').Value;
          FieldByName('AL').Value:=selT050.FieldByName('AL').Value;
          FieldByName('NUMEROORE').Value:=selT050.FieldByName('NUMEROORE').Value;
          FieldByName('AORE').Value:=selT050.FieldByName('AORE').Value;
          FieldByName('RESPONSABILE').Value:='';//selT050.FieldByName('RESPONSABILE').Value;
          FieldByName('D_CAUSALE').AsString:=Trim(selT050.FieldByName('D_CAUSALE').AsString);
          FieldByName('D_RESPONSABILE').AsString:=selT050.FieldByName('D_RESPONSABILE').AsString;
          Post;
        end;
      end;
    end;

    // Gestione stampa
    rvProject.Open;
    rvProject.GetReportList(L,True);
    rvProject.SelectReport(L[0],True);
    rvDWDettaglio:=(RVProject.ProjMan.FindRaveComponent('dwDettaglio',nil) as TRaveDataView);
    //Impostazioni dei campi di Dettaglio
    dconnDettaglio:=CreateDataCon(connDettaglio);
    rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
    rvDWDettaglio.DataCon:=dconnDettaglio;
    CreateFields(rvDWDettaglio,nil,nil,True);
    rvPage:=RVProject.ProjMan.FindRaveComponent('W010.Page',nil);

    // Impostazioni della banda bndTitolo
    // 1. Logo
    rvComp:=RVProject.ProjMan.FindRaveComponent('bmpLogo',rvPage);
    (rvComp as TRaveBitmap).Height:=0;
    (rvComp as TRaveBitmap).Width:=0;
    with TSelT004.Create(nil) do
    try
      Session:=SessioneOracle;
      if EsisteImmagine then
      begin
        (rvComp as TRaveBitmap).Image.Assign(Immagine);
        (rvComp as TRaveBitmap).Height:=0.640;
        (rvComp as TRaveBitmap).Width:=1.2;
      end;
    finally
      Free;
    end;
    // 2. altre informazioni di testata
    // ragione sociale
    rvComp:=RVProject.ProjMan.FindRaveComponent('lblAzienda',rvPage);
    (rvComp as TRaveText).Text:=Parametri.RagioneSociale;
    // indirizzo
    with WR000DM.selI090 do
    begin
      Close;
      SetVariable('AZIENDA',Parametri.Azienda);
      Open;
      EnteIndirizzo:=IfThen(RecordCount = 0,'',FieldByName('INDIRIZZO').AsString);
      Close;
    end;
    rvComp:=RVProject.ProjMan.FindRaveComponent('lblIndirizzo',rvPage);
    (rvComp as TRaveText).Text:=EnteIndirizzo;
    (RVProject.ProjMan.FindRaveComponent('Text8',rvPage) as TRaveText).Text:=A000TraduzioneStringhe(A000MSG_W010_MSG_RAV_FIRMA_RESP);

    ScalaStampa:=0.2 / 18;
    //Generazione del file PDF
    rvSystem.SystemSetups:=RVSystem.SystemSetups - [ssAllowSetup];
    rvSystem.SystemOptions:=rvSystem.SystemOptions - [soShowStatus,soPreviewModal];
    rvSystem.DefaultDest:=rdFile;
    rvSystem.DoNativeOutput:=False;
    rvSystem.RenderObject:=RvRenderPDF;
    if W000ParConfig.RaveStreamMode = INI_RAVE_STREAM_MODE_TEMPFILE then
      rvSystem.SystemFiler.StreamMode:=smTempFile
    else
      rvSystem.SystemFiler.StreamMode:=smMemory;
    NomeFile:=GetNomeFile('pdf');
    rvSystem.OutputFileName:=NomeFile;
    ForceDirectories(ExtractFileDir(rvSystem.OutputFileName));
    rvProject.Execute;
    VisualizzaFile(NomeFile,A000TraduzioneStringhe(A000MSG_W010_MSG_ANTEPRIMA_STAMPA),nil,nil);
  finally
    cdsAutorizzazione.Close;
    L.Free;
    rvProject.Close;
    FreeAndNil(dconnDettaglio);
    FreeAndNil(rvSystem);
    FreeAndNil(rvRenderPDF);
    FreeAndNil(rvProject);
    FreeAndNil(connDettaglio);
    CSStampa.Leave;
  end;
  Log('Traccia','StampaRicevuta - fine');
end;

procedure TW010FRichiestaAssenze.W010AutorizzaTutto(Sender: TObject; var Ok: Boolean);
// Effettua l'autorizzazione positiva / negativa di tutte le richieste
// ancora da autorizzare visibili a video.
var
  Aut: String;
  ErrModCan: Boolean;
function FormattaDatiRichiesta: String;
  var
    Tipo,NumOre,AOre: String;
  begin
    with W010DM.selT050 do
    begin
      NumOre:=FieldByName('NUMEROORE').AsString;
      AOre:=FieldByName('AORE').AsString;
      if FieldByName('TIPOGIUST').AsString = 'I' then
        Tipo:=A000TraduzioneStringhe(A000MSG_W010_MSG_GG_INTERA)
      else if FieldByName('TIPOGIUST').AsString = 'M' then
        Tipo:=Format(A000TraduzioneStringhe(A000MSG_W010_FMT_GG_MEZZA),[IfThen(NumOre <> '',' (' + NumOre + ' ore)')])
      else if FieldByName('TIPOGIUST').AsString = 'N' then
        Tipo:=Format(A000TraduzioneStringhe(A000MSG_W010_FMT_NUM_ORE),[NumOre])
      else if FieldByName('TIPOGIUST').AsString = 'D' then
        Tipo:=Format(A000TraduzioneStringhe(A000MSG_W010_FMT_DA_ORE_A_ORE),[NumOre,AOre]);

      // formatta la richiesta
      Result:=Format(A000TraduzioneStringhe(A000MSG_W010_FMT_RICHIESTA_ASS),[FieldByName('NOMINATIVO').AsString,
                                                                           FieldByName('MATRICOLA').AsString,
                                                                           FieldByName('DATA_RICHIESTA').AsString,
                                                                           FormatDateTime('dd/mm/yyyy',FieldByName('DAL').AsDateTime),
                                                                           FormatDateTime('dd/mm/yyyy',FieldByName('AL').AsDateTime),
                                                                           Tipo,FieldByName('CAUSALE').AsString]);
    end;
  end;
begin
  Log('Traccia','btnTuttiSiClick - inizio');
  // inizializzazione variabili
  ErrModCan:=False;
  Aut:=IfThen(Sender = btnTuttiSi,C018SI,C018NO);

  // autorizzazione richieste
  with W010DM.selT050 do
  begin
    // niente refresh: autorizza solo ciò che è visualizzato nella pagina
    First;
    while not Eof do
    begin
      try
        if (FieldByName('ELABORATO').AsString = 'N') and
           (FieldByName('ID_REVOCA').IsNull) and
           (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0) then
          try
            C018.CodIter:=FieldByName('COD_ITER').AsString;
            C018.Id:=FieldByName('ID').AsInteger;
            try
              C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
              SessioneOracle.Commit;
              if C018.MessaggioOperazione <> '' then
                raise Exception.Create(C018.MessaggioOperazione);
            except
              on E: Exception do
              begin
                SessioneOracle.Commit;
                // messaggio bloccante
                MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_FMT_IMPOST_AUT_FALLITA),[E.Message,FormattaDatiRichiesta]),
                                  ESCLAMA,A000TraduzioneStringhe(A000MSG_W010_MSG_AUTO_GIUST_ERR));
                VisualizzaDipendenteCorrente;
                Exit;
              end;
            end;
          except
            // errore probabilmente dovuto a record modificato / cancellato da altro utente
            on E:Exception do
              ErrModCan:=True;
          end;
      finally
        Next;
      end;
    end;
  end;
  //Alberto 02/12/2017 (TORINO_ITC): invio emil eventualmente caricate sulla T280 dagli script di autorizzazione
  WR000DM.InviaEmailT280;
  if ErrModCan then
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_IGNORATE));
  Log('Traccia','btnTuttiSiClick - fine');
  Ok:=True;
end;

procedure TW010FRichiestaAssenze.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,idxStampa,idxSuperoComp,LivAut: Integer;
  DefAttiva: Boolean;
  VisAutorizza: Boolean;
  VisCancella: Boolean;
  VisDefinisci: Boolean;
  VisRevoca: Boolean;
  VisCancPeriodo: Boolean;
  VisAnnulla: Boolean;
  VisConferma: Boolean;
  ShowLegenda1,
  ShowLegenda2,
  ShowLegenda3: Boolean;
  StrTipoRichiesta: String;
  StrRevocabile: String;
  StrElaborato: String;
  IdRevoca: Integer;
  StrAutorizzazione: String;
  StrAutorizzUtile: String;
  HintDescRichiesta:String;
  DatoAutorizzatore:String;
  TmpDal,TmpAl: TDateTime;
  IWImg: TmeIWImageFile;
  IWLbl: TmeIWLabel;
begin
  ShowLegenda1:=False;
  ShowLegenda2:=False;
  ShowLegenda3:=False;
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    // variabili di appoggio per i test
    StrTipoRichiesta:=grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA');
    StrRevocabile:=grdRichieste.medpValoreColonna(i,'REVOCABILE');
    StrElaborato:=grdRichieste.medpValoreColonna(i,'ELABORATO');
    IdRevoca:=StrToIntDef(grdRichieste.medpValoreColonna(i,'ID_REVOCA'),0);
    StrAutorizzazione:=grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE');
    StrAutorizzUtile:=grdRichieste.medpValoreColonna(i,'AUTORIZZ_UTILE');

    if IdRevoca > 0 then
      ShowLegenda1:=C018.Revocabile
    else if IdRevoca < 0 then
      ShowLegenda3:=C018.Revocabile;
    if (StrTipoRichiesta = 'P') and
       (StrAutorizzUtile = C018NO) then
      ShowLegenda2:=True;
    LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    // dettaglio iter
    IWImg:=(grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile);
    IWImg.OnClick:=imgIterClick;
    IWImg.Hint:=C018.LeggiNoteComplete;
    IWImg.AltText:='Dati di dettaglio della richiesta';
    IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    // dettaglio allegati
    if C018.EsisteGestioneAllegati then
    begin
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
      if C018.SetIconaAllegati(IWImg) then
        IWImg.OnClick:=imgAllegClick;
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    // dettaglio cartellino
    IWImg:=(grdRichieste.medpCompCella(i,'D_CARTELLINO',0) as TmeIWImageFile);
    IWImg.OnClick:=imgCartellinoClick;
    // visti precedenti
    if WR000DM.Responsabile and C018.UtilizzoAvviso then
    begin
      IWLbl:=(grdRichieste.medpCompCella(i,'D_VISTI_PREC',0) as TmeIWLabel);
      IWLbl.Caption:=C018.VistiPrecedenti[LivAut];
      if IWLbl.Caption = 'No' then
        IWLbl.Css:='font_rosso';
      IWLbl.Visible:=True;
    end;

    if WR000DM.Responsabile then
    begin
      // * Responsabile *
      // autorizzazione richiesta con checkbox
      VisAutorizza:=(StrElaborato = 'N') and
                    (IdRevoca = 0) and
                    (grdRichieste.medpValoreColonna(i,'AUTORIZZ_AUTOMATICA') <> 'S') and
                    (LivAut > 0); (*C018: se livello < 0 vuol dire che la richiesta fa parte del mio iter ma non posso autorizzare perchè già autorizzata successivamente*)
      if not VisAutorizza then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        if Parametri.CampiRiferimento.C90_W010AcquisizioneAuto <> 'S' then
        begin
          // v1: onclick
          C018.SetValoriAut(grdRichieste,i,0,0,1,chkAutorizzazioneClick);
          // v1.fine
        end
        else
        begin
          // v2.ini
          // COMO_HSANNA
          // versione con onasyncclick (non aggiorna la dbgrid dopo l'operazione di autorizzazione)
          C018.SetValoriAut(grdRichieste,i,0,0,1,nil);
          with (grdRichieste.medpCompCella(i,0,0) as TmeIWCheckBox) do
          begin
            Name:=Format(ROW_ELEM_NAME_FMT,[CHKSI_NAME,i]);
            OnAsyncClick:=chkAutorizzazioneAsyncClick;
            ScriptEvents.HookEvent('onClick','ShowBusy(true); return true;');
          end;
          if grdRichieste.medpCompCella(i,0,1) <> nil then
          begin
            with (grdRichieste.medpCompCella(i,0,1) as TmeIWCheckBox) do
            begin
              Name:=Format(ROW_ELEM_NAME_FMT,[CHKNO_NAME,i]);
              OnAsyncClick:=chkAutorizzazioneAsyncClick;
              ScriptEvents.HookEvent('onClick','ShowBusy(true); return true;');
            end;
          end;
          // v2.fine
        end;
      end;

      // stampa autorizzazione
      idxStampa:=grdRichieste.medpIndexColonna('DBG_COMANDI');
      if (StrTipoRichiesta = 'R') or
         (StrAutorizzazione <> 'S') then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[idxStampa]);
      if grdRichieste.medpCompGriglia[i].CompColonne[idxStampa] <> nil then
        (grdRichieste.medpCompCella(i,idxStampa,0) as TmeIWImageFile).OnClick:=btnStampaRicevutaClick;

      // EMPOLI_ASL11: segnala anomalia su dati modificati (T852)
      // flag supero competenze
      if ShowAvvertimenti then
      begin
        idxSuperoComp:=grdRichieste.medpIndexColonna('D_AVVERTIMENTI');
        DatoAutorizzatore:=C018.GetDatoAutorizzatore('SUPERO_COMPETENZE').Valore;
        with (grdRichieste.medpCompCella(i,idxSuperoComp,0) as TmeIWLabel) do
        begin
          if DatoAutorizzatore = 'S' then
          begin
            Css:='font_rosso';
            Caption:=A000TraduzioneStringhe('Competenze esaurite');
          end
          else
            Caption:='';
          Visible:=Caption <> '';
        end;
      end;
    end
    else
    begin
      // * Dipendente *
      VisCancella:=(StrRevocabile = 'CANC');
      DefAttiva:=(C018.EsisteAutorizzIntermedia) and
                 (StrTipoRichiesta = 'P') and
                 (grdRichieste.medpValoreColonna(i,'AUTORIZZ_PREV') = 'S') and
                 ((IdRevoca = 0));
      VisDefinisci:=(Operazione <> OP_DEFINIZIONE) and DefAttiva;
      // revoca: rich. revocabile non elaborata
      VisRevoca:=(C018.Revocabile) and
                 (StrTipoRichiesta <> 'R') and
                 (StrTipoRichiesta <> 'C') and // empoli - commessa 2012/102
                 (StrRevocabile = 'REVOC') and
                 //(StrElaborato <> 'E') and
                 (IdRevoca = 0); // se richiesta ha cancellazioni non si può revocare
      // EMPOLI_ASL11 - commessa 2012/102.ini
      // canc. periodo: rich. definitiva autorizzata, non revocata, di lunghezza maggiore di un giorno
      TmpDal:=StrToDate(grdRichieste.medpValoreColonna(i,'DAL'));
      TmpAl:=StrToDate(grdRichieste.medpValoreColonna(i,'AL'));
      VisCancPeriodo:=(C018.Revocabile) and
                      //(Pos(INI_PAR_T050_CANCELLAZIONE,W000ParConfig.ParametriAvanzati) > 0) and
                      (Parametri.CampiRiferimento.C90_W010Cancellazione = 'S') and
                      (StrTipoRichiesta = 'D') and
                      (StrAutorizzazione = 'S') and
                      //(StrElaborato <> 'E') and
                      (IdRevoca = 0) and // impedisce cancellazione se esiste una revoca
                      (TmpAl > TmpDal);
      // EMPOLI_ASL11 - commessa 2012/102.fine
      //Alberto 15/03/2018 (TORINO_ITC): i pulsanti di revoca / canc.parziale sono invisibili se il periodo è già bloccato
      if VisRevoca or VisCancPeriodo then
      begin
        if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180inizioMese(StrToDate(grdRichieste.medpValoreColonna(i,'DAL'))),'T040',True) then
        begin
          VisRevoca:=False;
          VisCancPeriodo:=False;
        end;
      end;

      VisAnnulla:=(Operazione = OP_DEFINIZIONE) and DefAttiva;
      VisConferma:=VisAnnulla;

      // Gestione grid comandi
      if not (VisCancella or VisDefinisci or VisRevoca or VisCancPeriodo or VisAnnulla or VisConferma) then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        if StileCella1 = '' then
        begin
          StileCella1:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css;
          if C018.EsisteAutorizzIntermedia then
            StileCella2:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css;
        end;
        HintDescRichiesta:=Format(A000TraduzioneStringhe(A000MSG_W010_FMT_HINT_DESC_RICHIESTA),
                                  [grdRichieste.medpValoreColonna(i,'DATA_RICHIESTA'),
                                   grdRichieste.medpValoreColonna(i,'D_CAUSALE_2'),
                                   grdRichieste.medpValoreColonna(i,'DAL'),
                                   grdRichieste.medpValoreColonna(i,'AL')]);
        // cancella
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css:=IfThen(VisCancella,StileCella1,'invisibile');
        with (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile) do
        begin
          OnClick:=imgCancellaClick;
          Hint:=Hint + HintDescRichiesta;
        end;

        if C018.EsisteAutorizzIntermedia then
        begin
          // definisci (1)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:=IfThen(VisDefinisci,StileCella1,'invisibile');
          with (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile) do
          begin
            if grdRichieste.medpValoreColonna(i,'TIPOGIUST') = 'I' then
            begin
              Confirmation:='Rendere la richiesta definitiva?';
              OnClick:=imgConfermaDefClick;
              Hint:='Rende definitiva la richiesta' + HintDescRichiesta;
            end
            else
            begin
              Confirmation:='';
              OnClick:=imgDefinisciClick;
              Hint:='Definisce la richiesta' + HintDescRichiesta;
            end;
          end;
          // revoca (2)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:=IfThen(VisRevoca,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile) do
          begin
            OnClick:=imgRevocaClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // EMPOLI_ASL11 - commessa 2012/102.ini
          // cancella periodo (3)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,3].Css:=IfThen(VisCancPeriodo,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile) do
          begin
            OnClick:=imgCancPeriodoClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // EMPOLI_ASL11 - commessa 2012/102.fine
          // annulla definizione (4)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,4].Css:=IfThen(VisConferma,StileCella1,'invisibile');
          with (grdRichieste.medpCompCella(i,0,4) as TmeIWImageFile) do
          begin
            Confirmation:='';
            OnClick:=imgAnnullaClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // conferma definizione
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,5].Css:=IfThen(VisConferma,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,5) as TmeIWImageFile) do
          begin
            Confirmation:='Rendere la richiesta definitiva?';
            OnClick:=imgConfermaDefClick;
            Hint:=Hint + HintDescRichiesta;
          end;
        end
        else
        begin
          // revoca
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:=IfThen(VisRevoca,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile) do
          begin
            OnClick:=imgRevocaClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // EMPOLI_ASL11 - commessa 2012/102.ini
          // cancella periodo (2)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:=IfThen(VisCancPeriodo,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile) do
          begin
            OnClick:=imgCancPeriodoClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // EMPOLI_ASL11 - commessa 2012/102.fine
        end;
      end;
    end;
  end;
  lblLegenda1.Visible:=ShowLegenda1;
  lblLegenda2.Visible:=ShowLegenda2;
  lblLegenda3.Visible:=ShowLegenda3;
  Log('Traccia','CaricaT050 - fine');
end;

procedure TW010FRichiestaAssenze.grdRichiesteBeforeCaricaCDS(Sender: TObject; DBG_ROWID: string);
begin
  Log('Traccia','CaricaT050 - inizio');
end;

procedure TW010FRichiestaAssenze.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna:Integer;
  NomeCampo, TestoApice: String;
begin
  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  NomeCampo:=grdRichieste.medpColonna(NumColonna).DataField;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdRichieste.medpCompGriglia)) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  // impostazione stili css particolari (colonne "Autorizzazione" ed "Elaborazione")
  if (ARow > 0) and (ARow - 1 <= High(grdRichieste.medpCompGriglia)) and (ACell.Control = nil) then
  begin
    if NomeCampo = 'D_TIPO_RICHIESTA' then
    begin
      ACell.RawText:=False;

      // visualizza le note come apici
      if (Pos('(1)',ACell.Text) > 0) or (Pos('(3)',ACell.Text) > 0) then
      begin
        TestoApice:=IfThen(Pos('(1)',ACell.Text) > 0,'(1)','(3)');
        ACell.Text:=StringReplace(ACell.Text,TestoApice,Format('<span class = "apice">&nbsp;%s</span>',[TestoApice]),[]);
        ACell.RawText:=True;
      end;
      if Pos('(2)',ACell.Text) > 0 then
      begin
        ACell.Text:=StringReplace(ACell.Text,'(2)','<span class = "apice">' + IfThen(ACell.RawText,'','&nbsp;') + '(2)</span>',[]);
        ACell.RawText:=True;
      end;
      // empoli - commessa 2012/102.ini
      // grassetto per revoca e cancellazione
      if R180In(grdRichieste.medpValoreColonna(ARow - 1,'TIPO_RICHIESTA'),['R','C']) then
        ACell.Css:=ACell.Css + ' font_grassetto';
      // empoli - commessa 2012/102.fine
    end
    else if NomeCampo = 'D_AUTORIZZAZIONE' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                 IfThen(grdRichieste.medpValoreColonna(ARow - 1,'AUTORIZZ_UTILE') = C018NO,' font_rosso');
    end
    else if NomeCampo = 'D_ELABORATO' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                 IfThen(grdRichieste.medpValoreColonna(ARow - 1,'ELABORATO') = 'E',' font_rosso');
    end
    else if ((NomeCampo = 'DAL') or
             (NomeCampo = 'AL') or
             (NomeCampo = 'D_CAUSALE_2')) then
    begin
      ACell.Css:=ACell.Css + ' font_blu';
    end
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
    else if NomeCampo = 'MOTIVAZIONE' then
    begin
      ACell.Hint:='';
      if ACell.Text <> '' then
        ACell.Text:=VarToStr(W010DM.selT106.Lookup('CODICE',ACell.Text,'DESCRIZIONE'));
      if ACell.Text.Length > MAX_LENGTH_MOTIVAZIONE then
      begin
        ACell.Hint:=ACell.Text;
        ACell.Text:=ACell.Text.Substring(0,MAX_LENGTH_MOTIVAZIONE) + '...';
      end;
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine

    if ACell.Text = C018AUTOMATICO then
      ACell.Text:=A000TraduzioneStringhe(C018AUTOMATICO);
  end;
end;

procedure TW010FRichiestaAssenze.DBGridColumnClick(ASender: TObject; const AValue: string);
var
  IdRiga{, i, idx}: Integer;
  AbilitaRiepilogo: Boolean;
begin
  // prova la locate prima con rowid, quindi con id richiesta
  if not cdsT050.Locate('DBG_ROWID',AValue,[]) then
  begin
    if TryStrToInt(AValue,IdRiga) then
    begin
      if not cdsT050.Locate('ID',IdRiga,[]) then
        Exit;
    end
    else
      Exit;
  end;

  // causale
  cmbCausaliDisponibili.ItemIndex:=max(0,ListaCausali.IndexOf(cdsT050.FieldByName('CAUSALE').AsString));

  // estrae nominativo dipendente se <Tutti i dipendenti>
  if TuttiDipSelezionato then
  begin
    selAnagrafeW.SearchRecord('MATRICOLA',cdsT050.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
    lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
    //GetFamiliari(cdsT050.FieldByName('CAUSALE').AsString);
  end;

  // familiare
  GetFamiliari(cdsT050.FieldByName('CAUSALE').AsString);
  cmbFamiliari.ItemIndex:=max(0,ListaFamiliari.IndexOfName(cdsT050.FieldByName('DATANAS').AsString));

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
  // scommentare per selezionare automaticamente la motivazione presente nella richiesta selezionata
  {
  if GestioneMotivazioniCausali then
  begin
    idx:=-1;
    for i:=0 to cmbMotivazione.Items.Count - 1 do
    begin
      if cdsT050.FieldByName('MOTIVAZIONE').AsString = TValore(cmbMotivazione.Items.Objects[i]).Valore then
      begin
        idx:=i;
        break;
      end;
    end;
    cmbMotivazione.ItemIndex:=idx;
  end;
  }
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine

  if WR000DM.Responsabile then
  begin
    AbilitaRiepilogo:=VarToStr(WR000DM.selT265.Lookup('CODICE',cdsT050.FieldByName('CAUSALE').AsString,'CODICE')) <> '';
    lblRiepAl.Visible:=AbilitaRiepilogo;
    edtRiepAl.Visible:=AbilitaRiepilogo;
    btnVisualizzaRiepilogo.Visible:=AbilitaRiepilogo;
  end;

  // inizializzazioni dati richiesta
  Operazione:=OP_INSERIMENTO;
  FDatiGiust.TipoRichiesta:='';
  FDatiGiust.IdRevocato:=-1;
  FDatiGiust.Motivazione:='';
end;

procedure TW010FRichiestaAssenze.grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  RenderCell(ACell,ARow,AColumn,True,True);
  if (ARow > 0) and (AColumn in [5,8,11]) then
    ACell.Css:=IfThen (ACell.Css = 'invisibile','invisibile','riga_colorata');
end;

procedure TW010FRichiestaAssenze.cdsAutorizzazioneCalcFields(DataSet: TDataSet);
var
  Sesso,TipoGiust,Causale,CodCaus,DesCaus,
  DalAl,NumeroOre,AOre,NumGGStr,
  Periodo_gg, Periodo_ore: String;
  NumGG: Integer;
begin
  with cdsAutorizzazione do
  begin
    // 1. imposta variabili di appoggio
    // sesso
    Sesso:=FieldByName('SESSO').AsString;
    // causale
    CodCaus:=FieldByName('CAUSALE').AsString;
    DesCaus:=FieldByName('D_CAUSALE').AsString;
    Causale:=IfThen(DesCaus <> '',DesCaus,CodCaus);
    // giorni di fruizione
    NumGG:=Trunc(FieldByName('AL').AsDateTime - FieldByName('DAL').AsDateTime) + 1;
    NumGGStr:=IntToStr(NumGG) + ' ' + IfThen(NumGG = 1,'giorno','giorni');
    DalAl:=IfThen(NumGG > 1,
                  'dal ' + FieldByName('DAL').AsString + ' al ' + FieldByName('AL').AsString,
                  'in data ' + FieldByName('DAL').AsString);
    // fruizione a ore
    NumeroOre:=FieldByName('NUMEROORE').AsString;
    AOre:=FieldByName('AORE').AsString;
    // tipo giustificativo
    TipoGiust:=FieldByName('TIPOGIUST').AsString;
    Periodo_gg:=IfThen(TipoGiust = 'M',' per mezza giornata ' + IfThen(NumeroOre <> '','(' + NumeroOre + ' ore) '),' ') + DalAl;
    if TipoGiust = 'N' then
      Periodo_ore:=' di ore ' + NumeroOre                    // numero ore
    else if TipoGiust = 'D' then
      Periodo_ore:=' dalle ' + NumeroOre + ' alle ' + AOre   // da ore - a ore
    else
      Periodo_ore:='';

    // 2. imposta i campi visualizzati in stampa
    // campo: oggetto
    FieldByName('C_OGGETTO').AsString:='OGGETTO: AUTORIZZAZIONE GIUSTIFICATIVO ' + Causale;

    // campo: testo autorizzazione
    FieldByName('C_TESTO').AsString:='Si autorizza ' + IfThen(Sesso = 'F','la','il') + ' dipendente ' +
      FieldByName('NOMINATIVO').AsString + ' (matr. ' +  FieldByName('MATRICOLA').AsString +
      ') ad usufruire di n. ' + NumGGStr + ' di ' + Causale + Periodo_gg + Periodo_ore + '.';

    if C018.LeggiNoteEsistenti <> '' then
    begin
      FieldByName('C_TESTO').AsString:=FieldByName('C_TESTO').AsString + CRLF + CRLF +
                                       'Note:' + CRLF +
                                       C018.LeggiNoteEsistenti;
    end;

    // data e firma
    FieldByName('C_DATA_FIRMA').AsString:='Li ' + DateToStr(R180SysDate(SessioneOracle)) +
      ', ' + FieldByName('D_RESPONSABILE').AsString;
  end;
end;

procedure TW010FRichiestaAssenze.chkNoteInsAsyncClick(Sender: TObject; EventParams: TStringList);
var
  StrTemp: String;
begin
  if chkNoteIns.Checked then
  begin
    StrTemp:='$("#%s").attr("class","").attr("class","textarea_note inser").hide().slideDown(400).focus();'
  end
  else
  begin
    StrTemp:='$("#%s").slideUp(400);';
  end;
  StrTemp:=Format(StrTemp,[memNoteIns.HTMLName]);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(StrTemp);
end;

procedure TW010FRichiestaAssenze.cmbAccorpCausaliChange(Sender: TObject);
begin
  GetCausaliDisponibili;
end;

procedure TW010FRichiestaAssenze.cmbCausaliDisponibiliAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  GetFamiliari(Trim(Copy(cmbCausaliDisponibili.Text,1,5)));
end;

procedure TW010FRichiestaAssenze.chkAutorizzazioneClick(Sender: TObject);
// autorizzazione - v1
var
  AbilAut: Boolean;
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  //Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;
  Autorizza.Caption:=IfThen(((Sender as TmeIWCheckBox).medpTag as TC018TipoChekAutor).Tipo = C018SI,'Si','No');

  // verifica presenza record
  with W010DM.selT050 do
  begin
    //Refresh;
    if (not SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning])) or
       (not CheckRecord(Autorizza.RowId)) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2));
      Exit;
    end;
  end;

  DBGridColumnClick(Sender,Autorizza.Rowid);

  // verifica abilitazione all'autorizzazione
  AbilAut:=(W010DM.selT050.FieldByName('ELABORATO').AsString = 'N') and
           (W010DM.selT050.FieldByName('ID_REVOCA').AsInteger = 0) and
           (W010DM.selT050.FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (W010DM.selT050.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0);
  if not AbilAut then
  begin
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_AUT));
    Exit;
  end;

  AutorizzazioneOK;
end;

procedure TW010FRichiestaAssenze.chkAutorizzazioneAsyncClick(Sender: TObject; EventParams: TStringList);
// autorizzazione - v2
var
  AbilAut: Boolean;
  Nome,Indice,Target: String;
  IWC: TComponent;
begin
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA('ShowBusy(false);');

  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // verifica presenza record
  with W010DM.selT050 do
  begin
    //Refresh;
    if (not SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning])) or
       (not CheckRecord(Autorizza.RowId)) then
    begin
      // annulla l'operazione effettuata e dà una segnalazione
      (Sender as TmeIWCheckBox).Checked:=not (Sender as TmeIWCheckBox).Checked;
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2));
      Exit;
    end;
  end;

  DBGridColumnClick(Sender,Autorizza.Rowid);

  // verifica abilitazione all'autorizzazione
  AbilAut:=(W010DM.selT050.FieldByName('ELABORATO').AsString = 'N') and
           (W010DM.selT050.FieldByName('ID_REVOCA').AsInteger = 0) and
           (W010DM.selT050.FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (W010DM.selT050.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0);
  if not AbilAut then
  begin
    // annulla l'operazione effettuata e dà una segnalazione
    (Sender as TmeIWCheckBox).Checked:=not (Sender as TmeIWCheckBox).Checked;
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_AUT));
    Exit;
  end;

  AutorizzazioneOK;

  // garantisce che solo uno dei check si/no sia impostato
  if Autorizza.Checked then
  begin
    // determina il nome del checkbox da TmeIWCheckBox
    Nome:=(Sender as TmeIWCheckBox).Name;
    Indice:=RightStr(Nome,ROW_ELEM_INDEX_LENGTH);
    Nome:=Copy(Nome,1,Length(Nome) - ROW_ELEM_INDEX_LENGTH);

    Target:=IfThen(Nome = CHKSI_NAME,CHKNO_NAME,CHKSI_NAME) + Indice;
    IWC:=FindComponent(Target);
    if Assigned(IWC) then
    begin
      (IWC as TmeIWCheckBox).Checked:=False;
    end;
  end;

  // indica che sono presenti autorizzazioni da confermare
  if Parametri.CampiRiferimento.C90_W010AcquisizioneAuto = 'S' then
  begin
    if Autorizza.Checked and (Autorizza.Caption = 'No') then
      AutorizzazioniDaConfermare:=True
    else if Autorizza.Checked and (Autorizza.Caption = 'Si') and (W010DM.selT050.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger = C018.LivMaxObb) then
      AutorizzazioniDaConfermare:=True;
  end;
end;

procedure TW010FRichiestaAssenze.AutorizzazioneOK;
var
  Aut,Resp: String;
begin
  Log('Traccia','AutorizzazioneOK - inizio');
  Aut:='';
  Resp:='';
  // autorizzazione richiesta
  with W010DM.selT050 do
  begin
    Resp:=Parametri.Operatore;
    if Autorizza.Checked and (Autorizza.Caption = 'Si') then
      // autorizzazione SI
      Aut:=C018SI
    else if Autorizza.Checked and (Autorizza.Caption = 'No') then
      // autorizzazione NO
      Aut:=C018NO
    else if not Autorizza.Checked then
      // autorizzazione non impostata
      Aut:='';
    // salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Resp,'','',True);
      SessioneOracle.Commit;
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);
      //Alberto 02/12/2017 (TORINO_ITC): invio emil eventualmente caricate sulla T280 dagli script di autorizzazione
      WR000DM.InviaEmailT280;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W009_FMT_IMP_AUTORIZ_FALLITE),[E.Message]));
      end;
    end;
    if not GGetWebApplicationThreadVar.IsCallBack then
      VisualizzaDipendenteCorrente;
  end;
  Log('Traccia','AutorizzazioneOK - fine');
end;

procedure TW010FRichiestaAssenze.btnAnnullaClick(Sender: TObject);
begin
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  Operazione:=OP_INSERIMENTO;
  FDatiGiust.TipoRichiesta:='';
  FDatiGiust.IdRevocato:=-1;
end;

procedure TW010FRichiestaAssenze.btnCartellinoClick(Sender: TObject);
const
  FUNZIONE = 'btnCartellinoClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  W005FM:=TW005FCartellinoFM.Create(Self);
  W005FM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  try
    W005FM.Dal:=StrToDate(IfThen(edtDal.Text = '',edtAl.Text,edtDal.Text));
    W005FM.Al:=StrToDate(edtAl.Text);
    if W005FM.Al < W005FM.Dal then
      Abort;
    if W005FM.Al - W005FM.Dal > 34 then
      Abort;
  except
    FreeAndNil(W005FM);
    raise ExceptionNoLog.Create('Il periodo specificato non è corretto!');
  end;
  W005FM.Visualizza;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW010FRichiestaAssenze.DistruggiOggetti;
begin
  try FreeAndNil(W010DM); except end;
  try FreeAndNil(B021FWebSvcClientDtM); except end;

  try FreeAndNil(W010CalcoloCompetenzeFM); except end;
  try FreeAndNil(W010CancPeriodoFM); except end;

  if R600DtM <> nil then
    try FreeAndNil(R600DtM); except end;

  // pulizia grid
  grdRichieste.medpClearCompGriglia;

  if ListaCausali <> nil then
    FreeAndNil(ListaCausali);
  if ListaFamiliari <> nil then
    FreeAndNil(ListaFamiliari);

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
  if ListaMotivazioni <> nil then
    FreeAndNil(ListaMotivazioni);
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine

  FreeAndNil(FDatiGiust);

  if (GGetWebApplicationThreadVar <> nil) and (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT265);
    R180CloseDataSetTag0(WR000DM.selT275);
    R180CloseDataSetTag0(WR000DM.selT257);
    R180CloseDataSetTag0(WR000DM.selSG101);
    R180CloseDataSetTag0(WR000DM.selSG101Causali);
  end;

  inherited;
end;

procedure TW010FRichiestaAssenze.edtDalAlAsyncChange(Sender: TObject; EventParams: TStringList);
var D: TDateTime;
begin
  inherited;
  if TryStrToDate(TmeIWEdit(Sender).Text, D) then
    GetCausaliDisponibili(True);
end;

procedure TW010FRichiestaAssenze.edtPeriodoDalAlAsyncChange(Sender: TObject; EventParams: TStringList);
var D:TDateTime;
begin
  inherited;
  if TryStrToDate('01/' + edtPeriodoDalAl.Text,D) then
  begin
    D:=R180InizioMese(D);
    edtDal.Text:=DateToStr(R180InizioMeseSettimanale(D,False));
    edtAl.Text:=DateToStr(R180FineMeseSettimanale(D,False));
  end;
end;

procedure TW010FRichiestaAssenze.imgCartellinoClick(Sender: TObject);
var
  //i: Integer;
  FN: String;
  W005FM: TW005FCartellinoFM;
const
  FUNZIONE = 'imgCartellinoClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if not W010DM.selT050.SearchRecord('ROWID',FN,[srFromBeginning]) then
    exit;
  //grdRichiesteColumnClick(Sender,FN);
  //i:=grdRichieste.medpRigaDiCompGriglia(FN);

  W005FM:=TW005FCartellinoFM.Create(Self);
  W005FM.Progressivo:=W010DM.selT050.FieldByname('PROGRESSIVO').AsInteger;
  W005FM.Dal:=W010DM.selT050.FieldByName('DAL').AsDateTime;
  W005FM.Al:=W010DM.selT050.FieldByName('AL').AsDateTime;
  W005FM.Visualizza;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW010FRichiestaAssenze.ImpostaJQuery;
var
  s, Elementi: String;
  ODS: TOracleDataSet;
begin
  // autocomplete configurazioni stampa
  // Note del giustificativo (AM/PM per ITC)
  Elementi:='';
  if Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S' then
  begin
    ODS:=TOracleDataSet.Create(nil);
    try
      ODS.Session:=SessioneOracle;
      ODS.SQL.Add('select distinct NOTE from T040_GIUSTIFICATIVI where DATA >= add_months(sysdate,-12) and NOTE is not null');
      ODS.Open;
      while not ODS.Eof do
      begin
        Elementi:=Elementi + '''' + C190EscapeJS(ODS.FieldByName('NOTE').AsString) + ''',';
        ODS.Next;
      end;
      ODS.Close;
    finally
      FreeAndNil(ODS);
    end;
  end;
  if Elementi <> '' then
  begin
    s:='var elementi = [' + Copy(Elementi,1,Length(Elementi) - 1) + '];' +
       '$("#' + edtNote.HTMLName + '").autocomplete({' + CRLF +
       '  source: elementi,' + CRLF +
       '  delay: 0,' + CRLF +
       '  minLength: 0' + CRLF +
       '}).focus(function(){ ' + CRLF +
       '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
       '}); ';
  end;
  jQAutoComplete.OnReady.Text:=s;
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
{ TValore }

constructor TValore.Create(const PValore: String);
begin
  FValore:=PValore;
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine

end.
