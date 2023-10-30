unit W028UChiamateReperibili;

interface

uses
  R010UPaginaWeb,
  R012UWebAnagrafico,
  USelI010,
  W028UChiamateReperibiliDM,
  W002UModificaDatiDM,
  W002UModificaDatiFM,
  WC002UDatiAnagraficiFM,
  A000UCostanti,
  A000USessione,
  A000UInterfaccia,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  W001UIrisWebDtM,
  IWApplication,
  StrUtils, Math, OracleData, Oracle, DB, SysUtils, FunzioniGenerali,
  Classes,Graphics,Controls,IWTemplateProcessorHTML,IWCompLabel,
  IWControl,IWHTMLControls,IWCompEdit,IWCompButton,
  IWCompListbox,Variants,IWBaseLayoutComponent,
  IWBaseContainerLayout,IWContainerLayout,IWVCLBaseControl,IWBaseControl,
  IWBaseHTMLControl,Forms, IWVCLComponent, IWDBGrids, medpIWDBGrid, DBClient,
  meTIWAdvRadioGroup, meIWEdit, meIWButton, meIWLabel,
  meIWComboBox, meIWText, meIWMemo, meIWGrid,
  IWCompExtCtrls, IWCompGrids, meIWImageFile, meIWLink, meIWRadioGroup,
  medpIWMultiColumnComboBox;

type
  TDipendenti = record
    Value:String;
    Visible:Boolean;
    Progressivo:String;
    Matricola:String;
    Cognome:String;
    Nome:String;
    Nominativo:String;
    Turno:String; // Codice univoco del turno
    Sigla:String; // Sigla personalizzata del turno
    Descrizione:String;
    Dalle:String;
    Alle:String;
    DataTurno:TDateTime;
    Priorita:Integer;
    TollChiamataInizio:String;
    TollChiamataFine:String;
    DatiVisArr: array of TDati;
    DatoFiltro1: TDato;
    DatoFiltro2: TDato;
    RecapitoExtra:String;
    // Prelevato dalla tabella di descrizione del dato libero indicato in C29_ChiamateRepFiltro1,
    // colonna TELEFONO, se definita
    TelefonoAziendale:String;
    DatoAgg1: TDato;
    DatoAgg2: TDato;
    AreaSquadra: TDato;
    function ToComboString: String;
    function DistribuisciNomeCognome(const PMaxLength: Integer): String;
  end;

  TInfoChiamata = record
    // Informazioni aggiuntive anagrafiche e turni sulle chiamate esistenti
    Value: String; // Chiave: PROGRESSIVO_yyyymmdd_hhnnss
    Progressivo: String; // Prog. dipendente
    Turno: String; // Codice turno della chiamata
    Sigla: String; // Sigla personalizzata del turno
    Descrizione: String; // Descrizione del turno
    Priorita: Integer; // Priorità del turno
    DatiVisArr: array of TDati; // Dati anagrafici visualizzati nelle info aggiuntive
    DatoLibero1Valore: String; // Valore dato libero 1
    DatoLibero2Valore: String; // Valore dato libero 2
    RecapitoExtra:String; // Recapito extra per la pianificazione turno
    TelefonoAziendale:String; // Campo TELEFONO di I501* alla data del turno
  end;

  TRecordChiamata = record
    Operazione:String;
    Data:TDateTime;
    Operatore:String;
    ProgReper:Integer;
    Esito:String;
    Note:String;
    DataTurno:TDateTime;
    Turno:String;
    Sigla:String;
    procedure Clear; inline;
  end;

  TW028FChiamateReperibili = class(TR012FWebAnagrafico)
    dsrT390: TDataSource;
    cdsT390: TClientDataSet;
    grdChiamate:TmedpIWDBGrid;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    rgpTipoEsito: TmeIWRadioGroup;
    rgpTipoUtente: TmeIWRadioGroup;
    btnEsegui: TmeIWButton;
    lblPeriodoDal: TmeIWLabel;
    lblPeriodoAl: TmeIWLabel;
    lblFiltroDato1: TmeIWLabel;
    lblFiltroDato2: TmeIWLabel;
    lblLegendaFiltri: TmeIWLabel;
    cmbFiltroDato1: TMedpIWMultiColumnComboBox;
    cmbFiltroDato2: TMedpIWMultiColumnComboBox;
    lblFiltroDato1Desc: TmeIWLabel;
    lblFiltroDato2Desc: TmeIWLabel;
    lblFiltroAreaSquadra: TmeIWLabel;
    cmbFiltroAreaSquadra: TMedpIWMultiColumnComboBox;
    lblFiltroAreaSquadraDesc: TmeIWLabel;
    procedure IWAppFormCreate(Sender:TObject);
    procedure imgModificaClick(Sender:TObject);
    procedure imgConfermaClick(Sender:TObject);
    procedure imgAnnullaClick(Sender:TObject);
    procedure grdChiamateRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
    procedure grdChiamateAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure rgpTipoEsitoClick(Sender: TObject);
    procedure rgpTipoUtenteClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure cmbFiltroDato1Change(Sender: TObject; Index: Integer);
    procedure cmbFiltroDato2Change(Sender: TObject; Index: Integer);
    procedure cmbFiltroAreaSquadraChange(Sender: TObject; Index: Integer);
  private
    FDal: TDateTime;
    FAl: TDateTime;
    FDatoFiltro1: TDatoFiltro;
    FDatoFiltro2: TDatoFiltro;
    FDatoFiltroArea: TDatoFiltro;
    FColInfoDip: Integer;
    FColSchedaAnag: Integer;
    FRecordChiamata: TRecordChiamata;
    FArrDip: array of TDipendenti;
     // FArrInfoChiamate contiene le informazioni aggiuntive sulle chiamate esistenti
    FArrInfoChiamate: array of TInfoChiamata;
    FCampoTelefonoAzPresente: Boolean;
    FStileCella1: String;
    FStileCella2: String;
    FStileCella3: String;
    W028DM: TW028FChiamateReperibiliDM;
    W002ModDatiDM: TW002FModificaDatiDM;
    W028ModDatiFM: TW002FModificaDatiFM;
    WC002FM: TWC002FDatiAnagraficiFM;
    FDatiAnag: TDatiAnag;
    function  ArrDipendentiGetIndex(const Codice:String;p,r:Integer):Integer;
    function  ArrDipendentiGetDesc(const Codice:String;p,r:Integer):String;
    function  ArrDipendentiGetText(const PIndex: Integer): String;
    function  ArrInfoChiamateGetDesc(ID:String): String;
    procedure GetDatiTabellari;
    procedure AggiornaFiltro;
    procedure TrasformaComponenti(const FN:String);
    procedure imgInserisciClick(Sender:TObject);
    function  ModificheRiga(const FN:String):Boolean;
    function  ImpostaPeriodo:Boolean;
    function  ControlliOK(const FN:String):Boolean;
    procedure actInserimentoOK;
    procedure actVariazioneOK;
    procedure DBGridColumnClick(ASender:TObject; const AValue:string);
    procedure CreaComponentiRiga(R:Integer);
    procedure dcmbDipendentiChange(Sender:TObject);
    procedure PreparaDatiAnag(const PIndex: Integer);
    procedure imgSchedaAnagraficaClick(Sender:TObject);
    procedure imgModificaDatiClick(Sender: TObject);
    const
      NOME_COL_TELEFONO_AZ:String = 'I051_TELEFONO';
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

//uses W001UIrisWebDtM;

{$R *.DFM}

function TW028FChiamateReperibili.InizializzaAccesso:Boolean;
var
  LFiltro: String;
begin
  // controlli sui parametri
  Result:=False;

  // parametri per filtri personalizzati
  if (Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 = '') and
     (Parametri.CampiRiferimento.C29_ChiamateRepFiltro2 <> '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' stato specificato il dato aziendale "Reperibilità: Filtro 2"' + CRLF +
                               'senza specificare il parametro "Reperibilità: Filtro 1".' + CRLF +
                               'Per accedere alla funzione "' + medpNomeFunzione + '" è necessario correggere questa impostazione.');
    Exit;
  end
  else if (Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 <> '') and
          (Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 = Parametri.CampiRiferimento.C29_ChiamateRepFiltro2) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Il dato aziendale "Reperibilità: Filtro 1"' + CRLF +
                               'è uguale al dato "Reperibilità: Filtro 2".' + CRLF +
                               'Per accedere alla funzione "' + medpNomeFunzione + '" è necessario correggere questa impostazione.');
    Exit;
  end;

  // parametri per dati aggiuntivi personalizzati
  if (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 = '') and
     (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' stato specificato il dato aziendale "Reperibilità: dato aggiuntivo 2 in pianificazione turno"' + CRLF +
                               'senza specificare il parametro "Reperibilità: dato aggiuntivo 1 in pianificazione turno".' + CRLF +
                               'Per accedere alla funzione "' + medpNomeFunzione + '" è necessario correggere questa impostazione.');
    Exit;
  end
  else if (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') and
          (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 = Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Il dato aziendale "Reperibilità: dato aggiuntivo 1 in pianificazione turno"' + CRLF +
                               'è uguale al dato "Reperibilità: dato aggiuntivo 2 in pianificazione turno".' + CRLF +
                               'Per accedere alla funzione "' + medpNomeFunzione + '" è necessario correggere questa impostazione.');
    Exit;
  end;

  // inizializzazioni
  if ParametriForm.Al = DATE_NULL then
  begin
    FDal:=Date;
    FAl:=Date;
  end
  else
  begin
    FDal:=ParametriForm.Dal;
    FAl:=ParametriForm.Al;
  end;
  // visualizza periodo
  edtDal.Text:=DateToStr(FDal);
  edtAl.Text:=DateToStr(FAl);

  // apertura dataset T390
  W028DM.selT390.SetVariable('AZIENDA',Parametri.Azienda);
  W028DM.selT390.SetVariable('DATAINIZIO',FDal);
  W028DM.selT390.SetVariable('DATAFINE',FAl);
  LFiltro:='';

  // filtro utente
  if rgpTipoUtente.ItemIndex = 0 then
    LFiltro:=LFiltro + ' AND T390.UTENTE = ''' + Parametri.Operatore + '''';

  // filtro esito chiamata
  if rgpTipoEsito.ItemIndex = 0 then
    LFiltro:=LFiltro + ' AND T390.ESITO = ''S'''
  else if rgpTipoEsito.ItemIndex = 1 then
    LFiltro:=LFiltro + ' AND T390.ESITO = ''N'''
  else if rgpTipoEsito.ItemIndex = 2 then
    LFiltro:=LFiltro + ' AND T390.ESITO = ''A''';

  W028DM.selT390.SetVariable('FILTRO',LFiltro);
  W028DM.selT390.Close;
  W028DM.selT390.Open;

  // filtro dipendenti
  lblLegendaFiltri.Caption:='Filtro dipendenti';
  cmbFiltroDato1.ItemIndex:=0;
  lblFiltroDato1Desc.Caption:='';
  cmbFiltroDato2.ItemIndex:=0;
  lblFiltroDato2Desc.Caption:='';
  cmbFiltroAreaSquadra.ItemIndex:=0;
  lblFiltroAreaSquadraDesc.Caption:='';

  // grid chiamate
  grdChiamate.medpCreaCDS;
  grdChiamate.medpEliminaColonne;
  grdChiamate.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdChiamate.medpAggiungiColonna('DATA','Data','',nil);
  grdChiamate.medpAggiungiColonna('OPERATORE','Operatore','',nil);
  grdChiamate.medpColonna('OPERATORE').Visible:=rgpTipoUtente.ItemIndex = 1;
  grdChiamate.medpAggiungiColonna('DIPENDENTE','Dipendente','',nil);
  grdChiamate.medpAggiungiColonna('D_SCHEDAANAG','','',nil);
  grdChiamate.medpAggiungiColonna('D_INFO','Informazioni','',nil);
  grdChiamate.medpAggiungiColonna('D_ESITO','Esito','',nil);
  grdChiamate.medpAggiungiColonna('NOTE','Note','',nil);
  // nascoste (servono per estrarre info turno)
  grdChiamate.medpAggiungiColonna('PROGRESSIVO_REPER','Progressivo','',nil);
  grdChiamate.medpAggiungiColonna('TURNO','Turno','',nil);
  grdChiamate.medpColonna('PROGRESSIVO_REPER').Visible:=False;;
  grdChiamate.medpColonna('TURNO').Visible:=False;;
  grdChiamate.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdChiamate.medpInizializzaCompGriglia;

  // indici utilizzati nella gestione
  FColSchedaAnag:=grdChiamate.medpIndexColonna('D_SCHEDAANAG');
  FColInfoDip:=grdChiamate.medpIndexColonna('D_INFO');

  if not SolaLettura then
  begin
    grdChiamate.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','MODIFICA','null','','S');
    grdChiamate.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','ANNULLA','null','','S');
    grdChiamate.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','CONFERMA','null','','D');
    //Riga di inserimento
    grdChiamate.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
    grdChiamate.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
    grdChiamate.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');

    // scheda anagrafica e modifica dati anagrafici
    // riga di inserimento
    grdChiamate.medpPreparaComponenteGenerico('I',FColSchedaAnag,0,DBG_IMG,'','SCHANAGR','null','','',True); // non impostare a False l'ultimo parametro
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
      grdChiamate.medpPreparaComponenteGenerico('I',FColSchedaAnag,1,DBG_IMG,'','MODIFICA','Modifica i dati anagrafici','','S');
    // righe di dettaglio
    grdChiamate.medpPreparaComponenteGenerico('R',FColSchedaAnag,0,DBG_IMG,'','SCHANAGR','null','','',True); // non impostare a False l'ultimo parametro
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
      grdChiamate.medpPreparaComponenteGenerico('R',FColSchedaAnag,1,DBG_IMG,'','MODIFICA','Modifica i dati anagrafici','','S');
  end;
  grdChiamate.medpCaricaCDS;

  GetDatiTabellari;

  // inizializza struttura dati per aggiornamento
  FRecordChiamata.Clear;

  Result:=True;
end;

procedure TW028FChiamateReperibili.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 14 OK }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    RimuoviNotifiche;
  end;
end;

procedure TW028FChiamateReperibili.IWAppFormCreate(Sender:TObject);
var
  LDati: String;
  LFiltroRicerca: String;
  LCampiV430Temp: String;
  LChiamateRepFiltro1: String;
  TabellaDL1: String;
  CodiceDL1: String;
  StoricoDL: String;
  LSQLLibero: String;
begin
  inherited;

  // colonne di V430 da estrarre oltre a quelle standard
  CampiV430:='V430.T430BADGE,V430.T430TELEFONO,V430.T430INDIRIZZO,V430.T430CAP,V430.T430D_COMUNE,V430.T430D_PROVINCIA';

  // datamodule principale
  W028DM:=TW028FChiamateReperibiliDM.Create(Self);

  // datamodule di supporto per modifica dati anagrafici
  W002ModDatiDM:=TW002FModificaDatiDM.Create(Self);

  LCampiV430Temp:=CampiV430;
  W002ModDatiDM.IntegraCampiV430RepVis(LCampiV430Temp);
  CampiV430:=LCampiV430Temp;

  // elenco dati da visualizzare e da modificare per la reperibilità
  FDatiAnag.Clear;

  // imposta la gestione automatica della selezione del periodo
  AssegnaGestPeriodo(edtDal,edtAl);

  // imposta filtri iniziali
  rgpTipoUtente.Items.Clear;
  rgpTipoUtente.Items.Add(Parametri.Operatore);
  rgpTipoUtente.Items.Add('Tutti');
  LFiltroRicerca:=WR000DM.FiltroRicerca;
  LFiltroRicerca:=StringReplace(LFiltroRicerca,':DATALAVORO','T390.DATA',[rfReplaceAll,rfIgnoreCase]);
  LFiltroRicerca:=StringReplace(LFiltroRicerca,':DATADAL','T390.DATA',[rfReplaceAll,rfIgnoreCase]);
  W028DM.selT390.SetVariable('FILTRORICERCA',LFiltroRicerca);

  grdChiamate.medpRighePagina:=GetRighePaginaTabella;
  grdChiamate.medpDataSet:=W028DM.selT390;

  // imposta i dati liberi per filtrare i dipendenti (1 , 2 e area)
  lblFiltroDato1.Visible:=Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 <> '';
  lblFiltroDato1.Caption:=R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1);
  cmbFiltroDato1.Visible:=lblFiltroDato1.Visible;
  cmbFiltroDato1.ColumnSeparator:=NAME_VALUE_SEPARATOR;
  lblFiltroDato1Desc.Visible:=lblFiltroDato1.Visible;
  lblFiltroDato1Desc.Caption:='';

  lblFiltroDato2.Visible:=Parametri.CampiRiferimento.C29_ChiamateRepFiltro2 <> '';
  lblFiltroDato2.Caption:=R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2);
  cmbFiltroDato2.Visible:=lblFiltroDato2.Visible;
  cmbFiltroDato2.ColumnSeparator:=NAME_VALUE_SEPARATOR;
  lblFiltroDato2Desc.Visible:=lblFiltroDato2.Visible;
  lblFiltroDato2Desc.Caption:='';

  lblFiltroAreaSquadra.Visible:=W028DM.selT651.RecordCount > 0;
  lblFiltroAreaSquadra.Caption:='Area afferenza';
  cmbFiltroAreaSquadra.Visible:=lblFiltroAreaSquadra.Visible;
  cmbFiltroAreaSquadra.ColumnSeparator:=NAME_VALUE_SEPARATOR;
  lblFiltroAreaSquadra.Visible:=lblFiltroAreaSquadra.Visible;
  lblFiltroAreaSquadraDesc.Caption:='';

  WR000DM.SetDatoLibero(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,FDatoFiltro1);
  WR000DM.SetDatoLibero(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2,FDatoFiltro2);

  // nasconde il groupbox del filtro dati se non sono presenti
  if not (FDatoFiltro1.Esiste or FDatoFiltro2.Esiste or (W028DM.selT651.RecordCount > 0)) then
    JavascriptBottom.Add('document.getElementById("filtroDati").className = "invisibile";');

  // imposta variabili dataset

  // dati da selezionare      aggiungere in testa T430SQUADRA,T430TIPOOPE
  LDati:='T430SQUADRA,T430TIPOOPE,' + FDatoFiltro1.GetDatiSQL + FDatoFiltro2.GetDatiSQL;

  // dati personalizzati per le info sul dipendente
  W002ModDatiDM.IntegraCampiV430RepVis(LDati);
  if (LDati <> '') and (RightStr(LDati,1) <> ',') then
    LDati:=LDati + ',';

  // imposta variabili per dataset principali
  W028DM.selT380.SetVariable('DATI',LDati);
  W028DM.selT390InfoChiamate.SetVariable('DATI',LDati);

  // Se è definito un dato libero, è possibile che il telefono aziendale sia conservato
  // sulla colonna TELEFONO della tabella descrittiva (I501*)
  FCampoTelefonoAzPresente:=False;
  LChiamateRepFiltro1:=Parametri.CampiRiferimento.C29_ChiamateRepFiltro1;
  if LChiamateRepFiltro1 <> '' then
  begin
    A000GetTabella(LChiamateRepFiltro1,TabellaDL1,CodiceDL1,StoricoDL); // Info sulla tabella I501*
    if (TabellaDL1 <> '') and (Copy(TabellaDL1,1,4) = 'I501') then
    begin
      // La tabella include una colonna TELEFONO?
      WR000DM.selCOLS.Close;
      WR000DM.selCOLS.ClearVariables;
      WR000DM.selCOLS.SetVariable('TABELLA',TabellaDL1);
      WR000DM.selCOLS.Open;
      if (WR000DM.selCOLS.Lookup('COLUMN_NAME','TELEFONO','COLUMN_NAME') = 'TELEFONO') then
      begin
        // La tabella ha una colonna TELEFONO. Imposto le variabili sul selT380 per gestire
        // il join con la tabella del dato libero
        LSQLLibero:=Format(', %s.TELEFONO %s',[TabellaDL1,NOME_COL_TELEFONO_AZ]);
        W028DM.selT380.SetVariable('DATO_LIB_1_TEL_AZ',LSQLLibero);
        W028DM.selT390InfoChiamate.SetVariable('DATO_LIB_1_TEL_AZ',LSQLLibero);

        LSQLLibero:=Format('%s,',[TabellaDL1]);
        W028DM.selT380.SetVariable('TAB_DATO_LIB_1',LSQLLibero);
        W028DM.selT390InfoChiamate.SetVariable('TAB_DATO_LIB_1',LSQLLibero);

        LSQLLibero:=Format(' and %s.%s = %s',[TabellaDL1,CodiceDL1,FDatoFiltro1.NomeCampo]);
        // Se il dato libero non è storicizzato, questa condizione è sufficiente
        if StoricoDL = 'N' then
        begin
          W028DM.selT380.SetVariable('COND_DATO_LIB1_TEL_AZ',LSQLLibero);
          W028DM.selT390InfoChiamate.SetVariable('COND_DATO_LIB1_TEL_AZ',LSQLLibero);
        end
        else
        begin
          W028DM.selT380.SetVariable('COND_DATO_LIB1_TEL_AZ',
                                     LSQLLibero + Format(' and :DATA between %s.DECORRENZA and %s.DECORRENZA_FINE',
                                                        [TabellaDL1,TabellaDL1])
                                     );
          W028DM.selT390InfoChiamate.SetVariable('COND_DATO_LIB1_TEL_AZ',
                                                  LSQLLibero + Format(' and T390.DATA_TURNO between %s.DECORRENZA and %s.DECORRENZA_FINE',
                                                                     [TabellaDL1,TabellaDL1]));
        end;
        FCampoTelefonoAzPresente:=True;
      end;
    end;
  end;
end;

procedure TW028FChiamateReperibili.IWAppFormRender(Sender: TObject);
begin
  inherited;
  // dipendenti disponibili
  AbilitazioneComponente(cmbDipendentiDisponibili,grdChiamate.medpStato = msBrowse);
  // filtri di visualizzazione
  AbilitazioneComponente(rgpTipoUtente,grdChiamate.medpStato = msBrowse);
  AbilitazioneComponente(rgpTipoEsito,grdChiamate.medpStato = msBrowse);
  // periodo
  AbilitazioneComponente(edtDal,grdChiamate.medpStato = msBrowse);
  AbilitazioneComponente(edtAl,grdChiamate.medpStato = msBrowse);
  AbilitazioneComponente(btnEsegui,grdChiamate.medpStato = msBrowse);

  // filtro dati liberi per inserimento
  AbilitazioneComponente(cmbFiltroDato1,grdChiamate.medpStato = msInsert);
  AbilitazioneComponente(cmbFiltroDato2,grdChiamate.medpStato = msInsert);
  AbilitazioneComponente(cmbFiltroAreaSquadra,grdChiamate.medpStato = msInsert);
end;

procedure TW028FChiamateReperibili.RefreshPage;
begin
  InizializzaAccesso;
end;

function TW028FChiamateReperibili.ImpostaPeriodo:Boolean;
begin
  Result:=True;
  // data iniziale
  if not TryStrToDate(edtDal.Text,FDal) then
  begin
    Result:=False;
    MsgBox.MessageBox('La data di inizio periodo non è valida',INFORMA);
    edtDal.SetFocus;
    Exit;
  end;
  // data finale
  if not TryStrToDate(edtAl.Text,FAl) then
  begin
    Result:=False;
    MsgBox.MessageBox('La data di fine periodo non è valida',INFORMA);
    edtAl.SetFocus;
    Exit;
  end;
  // controllo consecutività periodo
  if FDal > FAl then
  begin
    Result:=False;
    MsgBox.MessageBox('Il periodo indicato non è valido',INFORMA);
    edtDal.SetFocus;
    Exit;
  end;
  ParametriForm.Dal:=FDal;
  ParametriForm.Al:=FAl;
end;

procedure TW028FChiamateReperibili.btnEseguiClick(Sender: TObject);
begin
  // aggiorna la visualizzazione in base al periodo indicato
  if not ImpostaPeriodo then
    Exit;

  InizializzaAccesso;
end;

procedure TW028FChiamateReperibili.PreparaDatiAnag(const PIndex: Integer);
// prepara il clientdataset per la modifica dei dati anagrafici del dipendente
var
  i: Integer;
begin
  // verifica se è necessario effettuare il popolamento del clientdataset
  if (PIndex <= 0) or (Parametri.CampiRiferimento.C29_ChiamateRepDatiModif = '') then
    Exit;

  // imposta il clientdataset con i valori attuali dei campi da modificare
  for i:=0 to High(FArrDip[PIndex].DatiVisArr) do
  begin
    if W002ModDatiDM.cdsDatiAnag.Locate('CAMPO',FArrDip[PIndex].DatiVisArr[i].CampoV430,[]) then
    begin
      W002ModDatiDM.cdsDatiAnag.Edit;
      W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString:=FArrDip[PIndex].DatiVisArr[i].Valore;
      W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE_OLD').AsString:=W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString;
      W002ModDatiDM.cdsDatiAnag.Post;
    end;
  end;
end;

procedure TW028FChiamateReperibili.imgModificaDatiClick(Sender: TObject);
var
  r, idx: Integer;
  LCodice, LProg, FN: String;
  LIWC: TmeIWComboBox;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // estrae dati dipendente e indice array per modifica
  r:=grdChiamate.medpRigaDiCompGriglia(FN);
  if FRecordChiamata.Operazione = 'I' then
  begin
    LIWC:=(grdChiamate.medpCompCella(r,'DIPENDENTE',0) as TmeIWComboBox);
    LCodice:=LIWC.Items.ValueFromIndex[LIWC.ItemIndex];
    LProg:=Copy(LCodice,1,Pos('_',LCodice) - 1);
    FDatiAnag.Nominativo:=Trim(Copy(LIWC.Text,1,19)); // parte del nominativo: primi 19 caratteri
  end
  else
  begin
    LProg:=grdChiamate.medpValoreColonna(r,'PROGRESSIVO_REPER');
    LCodice:=Format('%s_%s',[LProg,grdChiamate.medpValoreColonna(r,'TURNO')]);
    FDatiAnag.Nominativo:=grdChiamate.medpValoreColonna(r,'DIPENDENTE');
  end;

  FDatiAnag.Progressivo:=StrToIntDef(LProg,0);

  // prepara il clientdataset con i dati del dipendente selezionato
  idx:=ArrDipendentiGetIndex(LCodice,0,High(FArrDip));
  PreparaDatiAnag(idx);

  // apre il form di modifica dati anagrafici
  if idx > 0 then
  begin
    W028ModDatiFM:=TW002FModificaDatiFM.Create(Self);
    W028ModDatiFM.W002ModDatiDM:=W002ModDatiDM;
    W028ModDatiFM.Progressivo:=FDatiAnag.Progressivo;
    W028ModDatiFM.Nominativo:=FDatiAnag.Nominativo;
    W028ModDatiFM.ArrIndex:=idx;
    W028ModDatiFM.Visualizza;
  end;
end;

procedure TW028FChiamateReperibili.cmbFiltroAreaSquadraChange(Sender: TObject; Index: Integer);
begin
  // aggiorna descrizione
  if Index < 0 then
    lblFiltroAreaSquadraDesc.Caption:=''
  else
    lblFiltroAreaSquadraDesc.Caption:=cmbFiltroAreaSquadra.Items[Index].RowData[1];

  AggiornaFiltro;
end;

procedure TW028FChiamateReperibili.cmbFiltroDato1Change(Sender: TObject; Index: Integer);
begin
  // aggiorna descrizione
  if Index < 0 then
    lblFiltroDato1Desc.Caption:=''
  else
    lblFiltroDato1Desc.Caption:=cmbFiltroDato1.Items[Index].RowData[1];

  AggiornaFiltro;
end;

procedure TW028FChiamateReperibili.cmbFiltroDato2Change(Sender: TObject; Index: Integer);
begin
  // aggiorna descrizione
  if Index < 0 then
    lblFiltroDato2Desc.Caption:=''
  else
    lblFiltroDato2Desc.Caption:=cmbFiltroDato2.Items[Index].RowData[1];

  AggiornaFiltro;
end;

procedure TW028FChiamateReperibili.AggiornaFiltro;
var
  LIWC: TmeIWComboBox;
  i: Integer;
begin
  GetDatiTabellari;

  // aggiornamento combobox
  if FRecordChiamata.Operazione = 'I' then
  begin
    LIWC:=(FindComponent('cmbDipendenteIns') as TmeIWComboBox);
    LIWC.Items.Clear;
    for i:=1 to High(FArrDip) do
    begin
      if FArrDip[i].Visible then
        LIWC.Items.Add(FArrDip[i].ToComboString + NAME_VALUE_SEPARATOR + FArrDip[i].Value);
    end;
    lblLegendaFiltri.Caption:=Format('Filtro dipendenti (%d disponibili)',[LIWC.Items.Count]);
    LIWC.Items.Insert(0,IfThen(LIWC.Items.Count = 0,'Nessun dipendente trovato' + NAME_VALUE_SEPARATOR,'Selezionare il dipendente' + NAME_VALUE_SEPARATOR));
    LIWC.ItemIndex:=IfThen(LIWC.Items.Count = 2,1,0); // se c'è un solo dipendente lo seleziona
    dcmbDipendentiChange(LIWC);
  end;
end;

procedure TW028FChiamateReperibili.GetDatiTabellari;
// Popolamento strutture dati di supporto per i dati tabellari
// utilizzati nelle chiamate (dipendenti)
var
  i, j: Integer;
  LPriorita: Integer;
  LFiltroDip: String;
  LCampo: String;
  LD_Campo: String;
  LValoreFiltro1: String;
  LValoreFiltro2: String;
  LValoreFiltroArea: String;
  LIsDatoFiltro1: Boolean;
  LIsDatoFiltro2: Boolean;
  LVisDip: Boolean;
  LElemento: String;
begin
  // imposta l'array contenente i dipendenti reperibili da selezionare

  // inizializza liste dati aggiuntivi
  FDatoFiltro1.ListaValoriAgg.Clear;
  FDatoFiltro2.ListaValoriAgg.Clear;

  // filtro libero 1
  LValoreFiltro1:=cmbFiltroDato1.Text;

  // filtro libero 2
  LValoreFiltro2:=cmbFiltroDato2.Text;

  // filtro area squadra
  LValoreFiltroArea:=cmbFiltroAreaSquadra.Text;

  // salva il filtro anagrafico
  LFiltroDip:=WR000DM.FiltroRicerca;

  // apre il dataset per estrarre i dipendenti pianificati
  W028DM.selT380.Close;
  W028DM.selT380.SetVariable('DATA',Date);
  W028DM.selT380.SetVariable('ORA',R180OreMinuti(Now));
  W028DM.selT380.SetVariable('FILTRODIP',StringReplace(LFiltroDip,':DATALAVORO','T380.DATA',[rfReplaceAll,rfIgnoreCase]));
  W028DM.selT380.Open;
  SetLength(FArrDip,W028DM.selT380.RecordCount + 1);
  i:=1;
  while not W028DM.selT380.Eof do
  begin
    // determina se proporre il dipendente in base ai filtri sui dati liberi
    LVisDip:=True;
    // verifica il filtro 1
    if FDatoFiltro1.Esiste and (cmbFiltroDato1.Text <> '') then
    begin
      // verifica se il filtro 1 è uno dei due dati aggiuntivi pianificati e il dato è realmente pianificato
      // in questo caso viene filtrato il dato pianificato e non quello in anagrafica
      if (FDatoFiltro1.NomeDato = Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1) and
         (not W028DM.selT380.FieldByName('DATOAGG1').IsNull) then
        LVisDip:=(LValoreFiltro1 = W028DM.selT380.FieldByName('DATOAGG1').AsString)
      else if (FDatoFiltro1.NomeDato = Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2) and
              (not W028DM.selT380.FieldByName('DATOAGG2').IsNull) then
        LVisDip:=(LValoreFiltro1 = W028DM.selT380.FieldByName('DATOAGG2').AsString)
      else
        LVisDip:=(LValoreFiltro1 = W028DM.selT380.FieldByName(FDatoFiltro1.NomeCampo).AsString);
    end;
    // verifica il filtro 2
    if LVisDip and FDatoFiltro2.Esiste and (cmbFiltroDato2.Text <> '') then
    begin
      // verifica se il filtro 2 è uno dei due dati aggiuntivi pianificati e il dato è realmente pianificato
      // in questo caso viene filtrato il dato pianificato e non quello in anagrafica
      if (FDatoFiltro2.NomeDato = Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1) and
         (not W028DM.selT380.FieldByName('DATOAGG1').IsNull) then
        LVisDip:=(LValoreFiltro2 = W028DM.selT380.FieldByName('DATOAGG1').AsString)
      else if (FDatoFiltro2.NomeDato = Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2) and
              (not W028DM.selT380.FieldByName('DATOAGG2').IsNull) then
        LVisDip:=(LValoreFiltro2 = W028DM.selT380.FieldByName('DATOAGG2').AsString)
      else
        LVisDip:=(LValoreFiltro2 = W028DM.selT380.FieldByName(FDatoFiltro2.NomeCampo).AsString);
    end;
    // area afferenza
    if LVisDip and (W028DM.selT651.RecordCount > 0) and (cmbFiltroAreaSquadra.Text <> '') then
    begin
      if not W028DM.selT380.FieldByName('AREASQUADRA').IsNull then
        LVisDip:=(LValoreFiltroArea = W028DM.selT380.FieldByName('AREASQUADRA').AsString);
    end;
    FArrDip[i].Visible:=LVisDip;

    // imposta gli altri dati del dipendente e del turno pianificato
    FArrDip[i].Value:=Format('%s_%s',[W028DM.selT380.FieldByName('PROGRESSIVO').AsString,W028DM.selT380.FieldByName('TURNO').AsString]);
    FArrDip[i].Progressivo:=W028DM.selT380.FieldByName('PROGRESSIVO').AsString;
    FArrDip[i].Matricola:=W028DM.selT380.FieldByName('MATRICOLA').AsString;
    FArrDip[i].Cognome:=W028DM.selT380.FieldByName('COGNOME').AsString;
    FArrDip[i].Nome:=W028DM.selT380.FieldByName('NOME').AsString;
    FArrDip[i].Nominativo:=FArrDip[i].DistribuisciNomeCognome(19);
    FArrDip[i].Descrizione:=W028DM.selT380.FieldByName('DESCRIZIONE').AsString;
    FArrDip[i].Turno:=W028DM.selT380.FieldByName('TURNO').AsString;
    FArrDip[i].Sigla:=W028DM.selT380.FieldByName('SIGLA').AsString;
    FArrDip[i].Dalle:=W028DM.selT380.FieldByName('DALLE').AsString;
    FArrDip[i].Alle:=W028DM.selT380.FieldByName('ALLE').AsString;
    FArrDip[i].DataTurno:=W028DM.selT380.FieldByName('DATA_TURNO').AsDateTime;
    if W028DM.selT380.FieldByName('TURNO').AsString = W028DM.selT380.FieldByName('TURNO1').AsString then
      LPriorita:=W028DM.selT380.FieldByName('PRIORITA1').AsInteger
    else if W028DM.selT380.FieldByName('TURNO').AsString = W028DM.selT380.FieldByName('TURNO2').AsString then
      LPriorita:=W028DM.selT380.FieldByName('PRIORITA2').AsInteger
    else if W028DM.selT380.FieldByName('TURNO').AsString = W028DM.selT380.FieldByName('TURNO3').AsString then
      LPriorita:=W028DM.selT380.FieldByName('PRIORITA3').AsInteger
    else
      LPriorita:=0;
    FArrDip[i].Priorita:=LPriorita;
    // MONDOEDP - commessa MAN/02 SVILUPPO#119.ini
    FArrDip[i].TollChiamataInizio:=W028DM.selT380.FieldByName('TOLL_CHIAMATA_INIZIO').AsString;
    FArrDip[i].TollChiamataFine:=W028DM.selT380.FieldByName('TOLL_CHIAMATA_FINE').AsString;
    // MONDOEDP - commessa MAN/02 SVILUPPO#119.fine

    // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.ini
    // gestione dati aggiuntivi da visualizzare
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
    begin
      // dati da visualizzare
      SetLength(FArrDip[i].DatiVisArr,W002ModDatiDM.LstDatiVis.Count);
      for j:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
      begin
        LCampo:=Format('T430%s',[W002ModDatiDM.LstDatiVis[j]]);
        LD_Campo:=Format('T430D_%s',[W002ModDatiDM.LstDatiVis[j]]);
        FArrDip[i].DatiVisArr[j].CampoV430:=LCampo;
        FArrDip[i].DatiVisArr[j].Dato:=R180Capitalize(W002ModDatiDM.LstDatiVis[j]);
        FArrDip[i].DatiVisArr[j].Valore:=W028DM.selT380.FieldByName(LCampo).AsString;
        FArrDip[i].DatiVisArr[j].Caption:=FArrDip[i].DatiVisArr[j].Dato;
        if WR000DM.cdsI010.Locate('NOME_CAMPO',LCampo,[]) then
        begin
          FArrDip[i].DatiVisArr[j].Caption:=R180Capitalize(WR000DM.cdsI010.FieldByName('NOME_LOGICO').AsString);
          if WR000DM.cdsI010.Locate('NOME_CAMPO',LD_Campo,[]) then
            FArrDip[i].DatiVisArr[j].Valore:=Format('%s - %s',[FArrDip[i].DatiVisArr[j].Valore,W028DM.selT380.FieldByName(LD_Campo).AsString]);
        end;

        // verifica se il dato è fra quelli modificabili
        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif = '' then
          FArrDip[i].DatiVisArr[j].Modificabile:=False
        else
          FArrDip[i].DatiVisArr[j].Modificabile:=W002ModDatiDM.LstDatiModif.IndexOf(W002ModDatiDM.LstDatiVis[j]) > -1;
      end;
    end;
    // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.fine

    // dato libero filtro 1
    FArrDip[i].DatoFiltro1.Clear;
    if FDatoFiltro1.Esiste then
    begin
      FArrDip[i].DatoFiltro1.Codice:=W028DM.selT380.FieldByName(FDatoFiltro1.NomeCampo).AsString;
      if FDatoFiltro1.NomeCampoDesc <> '' then
        FArrDip[i].DatoFiltro1.Descrizione:=W028DM.selT380.FieldByName(FDatoFiltro1.NomeCampoDesc).AsString;
    end;

    // dato libero filtro 2
    FArrDip[i].DatoFiltro2.Clear;
    if FDatoFiltro2.Esiste then
    begin
      FArrDip[i].DatoFiltro2.Codice:=W028DM.selT380.FieldByName(FDatoFiltro2.NomeCampo).AsString;
      if FDatoFiltro2.NomeCampoDesc <> '' then
        FArrDip[i].DatoFiltro2.Descrizione:=W028DM.selT380.FieldByName(FDatoFiltro2.NomeCampoDesc).AsString;
    end;

    // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
    FArrDip[i].RecapitoExtra:=W028DM.selT380.FieldByName('RECAPITO_EXTRA').AsString;
    // Gestione campo "Telefono aziendale" su tabella dato libero 1
    if FCampoTelefonoAzPresente then
      FArrDip[i].TelefonoAziendale:=W028DM.selT380.FieldByName(NOME_COL_TELEFONO_AZ).AsString;
    // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine

    // dato aggiuntivo da pianificare #1
    if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '' then
    begin
      // info dato aggiuntivo visualizzabili
      FArrDip[i].DatoAgg1.Codice:=W028DM.selT380.FieldByName('DATOAGG1').AsString;
      FArrDip[i].DatoAgg1.Descrizione:=VarToStr(W028DM.selDatoAgg1Lookup.Lookup('CODICE',FArrDip[i].DatoAgg1.Codice,'DESCRIZIONE'));

      // se è pianificato il dato aggiuntivo effettua alcune considerazioni
      if FArrDip[i].DatoAgg1.Codice <> '' then
      begin
        // determina se il dato aggiuntivo è uno di quelli utilizzati per il filtro
        LIsDatoFiltro1:=(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 = FDatoFiltro1.NomeDato);
        LIsDatoFiltro2:=(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 = FDatoFiltro2.NomeDato);
        if LIsDatoFiltro1 or LIsDatoFiltro2 then
        begin
          // aggiunge il valore del dato aggiuntivo alla lista del corrispondente dato di filtro
          LElemento:=FArrDip[i].DatoAgg1.ToComboItem;
          if LIsDatoFiltro1 then
            FDatoFiltro1.ListaValoriAgg.Add(LElemento)
          else
            FDatoFiltro2.ListaValoriAgg.Add(LElemento);
        end;
      end;
    end;

    // dato aggiuntivo da pianificare #2
    if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '' then
    begin
      FArrDip[i].DatoAgg2.Codice:=W028DM.selT380.FieldByName('DATOAGG2').AsString;
      FArrDip[i].DatoAgg2.Descrizione:=VarToStr(W028DM.selDatoAgg2Lookup.Lookup('CODICE',FArrDip[i].DatoAgg2.Codice,'DESCRIZIONE'));

      if FArrDip[i].DatoAgg2.Codice <> '' then
      begin
        LIsDatoFiltro1:=(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 = FDatoFiltro1.NomeDato);
        LIsDatoFiltro2:=(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 = FDatoFiltro2.NomeDato);
        if LIsDatoFiltro1 or LIsDatoFiltro2 then
        begin
          // aggiunge il valore del dato aggiuntivo alla lista del corrispondente dato di filtro
          LElemento:=FArrDip[i].DatoAgg2.ToComboItem;
          if LIsDatoFiltro1 then
            FDatoFiltro1.ListaValoriAgg.Add(LElemento)
          else
            FDatoFiltro2.ListaValoriAgg.Add(LElemento);
        end;
      end;
    end;

    // dato aggiuntivo da pianificare #2
    FArrDip[i].AreaSquadra.Codice:=W028DM.selT380.FieldByName('AREASQUADRA').AsString;
    FArrDip[i].AreaSquadra.Descrizione:=VarToStr(W028DM.selT650Lookup.Lookup('CODICE',FArrDip[i].AreaSquadra.Codice,'DESCRIZIONE'));

    // passa al record successivo
    W028DM.selT380.Next;
    i:=i + 1;
  end;
  W028DM.selT380.Close;

  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
  // apertura dataset selT390InfoTurniChiamate (join T350/T380/T390 per info
  // chiamate già esistenti)
  W028DM.selT390InfoChiamate.Close;
  W028DM.selT390InfoChiamate.SetVariable('DATA_PERIODO_DAL',FDal);
  W028DM.selT390InfoChiamate.SetVariable('DATA_PERIODO_AL',FAl);
  W028DM.selT390InfoChiamate.SetVariable('FILTRODIP',StringReplace(LFiltroDip,':DATALAVORO','trunc(T390.DATA)',[rfReplaceAll,rfIgnoreCase]));
  W028DM.selT390InfoChiamate.Open;
  SetLength(FArrInfoChiamate,W028DM.selT390InfoChiamate.RecordCount);
  i:=0;
  while (not W028DM.selT390InfoChiamate.Eof) do
  begin
    FArrInfoChiamate[i].Value:=Format('%s_%s',
                                      [W028DM.selT390InfoChiamate.FieldByName('PROGRESSIVO').AsString,
                                       FormatDateTime('yyyymmdd_hhnnss',W028DM.selT390InfoChiamate.FieldByName('DATA_CHIAMATA').AsDateTime)]);
    FArrInfoChiamate[i].Progressivo:=W028DM.selT390InfoChiamate.FieldByName('PROGRESSIVO').AsString;
    FArrInfoChiamate[i].Descrizione:=W028DM.selT390InfoChiamate.FieldByName('DESCRIZIONE').AsString;
    FArrInfoChiamate[i].Turno:=W028DM.selT390InfoChiamate.FieldByName('TURNO').AsString;
    FArrInfoChiamate[i].Sigla:=W028DM.selT390InfoChiamate.FieldByName('SIGLA').AsString;
    FArrInfoChiamate[i].Priorita:=W028DM.selT390InfoChiamate.FieldByName('PRIORITA').AsInteger;

    if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
    begin
      // dati da visualizzare
      SetLength(FArrInfoChiamate[i].DatiVisArr,W002ModDatiDM.LstDatiVis.Count);
      for j:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
      begin
        LCampo:=Format('T430%s',[W002ModDatiDM.LstDatiVis[j]]);
        LD_Campo:=Format('T430D_%s',[W002ModDatiDM.LstDatiVis[j]]);
        FArrInfoChiamate[i].DatiVisArr[j].CampoV430:=LCampo;
        FArrInfoChiamate[i].DatiVisArr[j].Dato:=R180Capitalize(W002ModDatiDM.LstDatiVis[j]);
        FArrInfoChiamate[i].DatiVisArr[j].Valore:=W028DM.selT390InfoChiamate.FieldByName(LCampo).AsString;
        FArrInfoChiamate[i].DatiVisArr[j].Caption:=FArrInfoChiamate[i].DatiVisArr[j].Dato;
        if WR000DM.cdsI010.Locate('NOME_CAMPO',LCampo,[]) then
        begin
          FArrInfoChiamate[i].DatiVisArr[j].Caption:=R180Capitalize(WR000DM.cdsI010.FieldByName('NOME_LOGICO').AsString);
          if WR000DM.cdsI010.Locate('NOME_CAMPO',LD_Campo,[]) then
            FArrInfoChiamate[i].DatiVisArr[j].Valore:=Format('%s - %s',[FArrInfoChiamate[i].DatiVisArr[j].Valore,W028DM.selT390InfoChiamate.FieldByName(LD_Campo).AsString]);
        end;

        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif = '' then
          FArrInfoChiamate[i].DatiVisArr[j].Modificabile:=False
        else
          FArrInfoChiamate[i].DatiVisArr[j].Modificabile:=W002ModDatiDM.LstDatiModif.IndexOf(W002ModDatiDM.LstDatiVis[j]) > -1;
      end;
    end;

    // dato libero 1
    FArrInfoChiamate[i].DatoLibero1Valore:='';
    if FDatoFiltro1.Esiste then
    begin
      FArrInfoChiamate[i].DatoLibero1Valore:=W028DM.selT390InfoChiamate.FieldByName(FDatoFiltro1.NomeCampo).AsString;
      if FDatoFiltro1.NomeCampoDesc <> '' then
        FArrInfoChiamate[i].DatoLibero1Valore:=FArrInfoChiamate[i].DatoLibero1Valore + ' - ' + W028DM.selT390InfoChiamate.FieldByName(FDatoFiltro1.NomeCampoDesc).AsString;
    end;

    // dato libero 2
    FArrInfoChiamate[i].DatoLibero2Valore:='';
    if FDatoFiltro2.Esiste then
    begin
      FArrInfoChiamate[i].DatoLibero2Valore:=W028DM.selT390InfoChiamate.FieldByName(FDatoFiltro2.NomeCampo).AsString;
      if FDatoFiltro2.NomeCampoDesc <> '' then
        FArrInfoChiamate[i].DatoLibero2Valore:=FArrInfoChiamate[i].DatoLibero2Valore + ' - ' + W028DM.selT390InfoChiamate.FieldByName(FDatoFiltro2.NomeCampoDesc).AsString;
    end;

    // Recapito extra
    FArrInfoChiamate[i].RecapitoExtra:=W028DM.selT390InfoChiamate.FieldByName('RECAPITO_EXTRA').AsString;
    // Telefono aziendale
    if FCampoTelefonoAzPresente then
      FArrInfoChiamate[i].TelefonoAziendale:=W028DM.selT390InfoChiamate.FieldByName(NOME_COL_TELEFONO_AZ).AsString;

    W028DM.selT390InfoChiamate.Next;
    Inc(i);
  end;
  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine

  // popola la combobox per il filtro 1
  cmbFiltroDato1.Items.Clear;
  cmbFiltroDato1.AddRow(NAME_VALUE_SEPARATOR + ' ');
  for LElemento in FDatoFiltro1.GetListaValoriCompleta do
    cmbFiltroDato1.AddRow(LElemento);
  cmbFiltroDato1.Text:=LValoreFiltro1;

  // popola la combobox per il filtro 2
  cmbFiltroDato2.Items.Clear;
  cmbFiltroDato2.AddRow(NAME_VALUE_SEPARATOR + ' ');
  for LElemento in FDatoFiltro2.GetListaValoriCompleta do
    cmbFiltroDato2.AddRow(LElemento);
  cmbFiltroDato2.Text:=LValoreFiltro2;

  // popola la combobox per filtro area afferenza
  cmbFiltroAreaSquadra.Items.Clear;
  cmbFiltroAreaSquadra.AddRow(NAME_VALUE_SEPARATOR + ' ');
  W028DM.selT650Lookup.First;
  while not W028DM.selT650Lookup.Eof do
  begin
    cmbFiltroAreaSquadra.AddRow(W028DM.selT650Lookup.FieldByName('CODICE').AsString + NAME_VALUE_SEPARATOR + W028DM.selT650Lookup.FieldByName('DESCRIZIONE').AsString );
    W028DM.selT650Lookup.Next;
  end;
  cmbFiltroAreaSquadra.Text:=LValoreFiltroArea;
end;

procedure TW028FChiamateReperibili.imgSchedaAnagraficaClick(Sender:TObject);
var
  LMatr: String;
  x: Integer;
  IWC: TmeIWComboBox;
begin
  if FRecordChiamata.Operazione = 'I' then
  begin
    IWC:=(grdChiamate.medpCompCella(0,'DIPENDENTE',0) as TmeIWComboBox);
    x:=ArrDipendentiGetIndex(IWC.Items.ValueFromIndex[IWC.ItemIndex],0,High(FArrDip));
    if x > 0 then
      LMatr:=FArrDip[x].Matricola
    else
      LMatr:='';
  end
  else
    LMatr:=VarToStr(cdsT390.Lookup('DBG_ROWID',(Sender as TmeIWImageFile).FriendlyName,'MATRICOLA'));
  if LMatr <> '' then
  begin
    WC002FM:=TWC002FDatiAnagraficiFM.Create(Self);
    WC002FM.ParMatricola:=LMatr;
    WC002FM.AllowClick:=True;
    WC002FM.VisualizzaScheda;
  end;
end;

procedure TW028FChiamateReperibili.imgAnnullaClick(Sender:TObject);
// Annulla: annulla le modifiche apportate nei componenti editabili
begin
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  FRecordChiamata.Operazione:='';
  grdChiamate.medpStato:=msBrowse;
  btnEseguiClick(Sender);
end;

procedure TW028FChiamateReperibili.imgInserisciClick(Sender:TObject);
var
  FN: String;
  LIWGrd: TmeIWGrid;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if (FRecordChiamata.Operazione <> '') then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione di ' + IfThen(FRecordChiamata.Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!',INFORMA);
    Exit;
  end;
  DBGridColumnClick(Sender,FN);

  // imposta dati per inserimento
  FRecordChiamata.Operazione:='I';
  // SAVONA_ASL2 - chiamata 117817.ini
  // si utilizza l'ora del dbserver invece di quella del webserver
  //FRecordChiamata.Data:=Now;
  FRecordChiamata.Data:=R180SysDate(SessioneOracle);
  // SAVONA_ASL2 - chiamata 117817.fine
  FRecordChiamata.Operatore:=Parametri.Operatore;

  // imposta tabella
  grdChiamate.medpBrowse:=False;
  grdChiamate.medpStato:=msInsert;
  //Nascondo il pulsante inserisci e visualizzo annulla/conferma
  LIWGrd:=(grdChiamate.medpCompGriglia[0].CompColonne[0] as TmeIWGrid);
  LIWGrd.Cell[0,0].Css:='invisibile';
  LIWGrd.Cell[0,1].Css:=FStileCella1;
  LIWGrd.Cell[0,2].Css:=FStileCella2;

  LIWGrd:=(grdChiamate.medpCompGriglia[0].CompColonne[FColSchedaAnag] as TmeIWGrid);
  // scheda anagrafica
  LIWGrd.Cell[0,0].Css:=FStileCella3;
  // modifica dati
  if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
    LIWGrd.Cell[0,1].Css:=FStileCella1;

  GetDatiTabellari;
  CreaComponentiRiga(0);
end;

procedure TW028FChiamateReperibili.imgModificaClick(Sender:TObject);
// modifica della riga
var
  FN: String;
begin
  if (FRecordChiamata.Operazione = 'I') or (FRecordChiamata.Operazione = 'M') then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione di ' + IfThen(FRecordChiamata.Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!',INFORMA);
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);
  FRecordChiamata.Operazione:='M';
  GetDatiTabellari;
  TrasformaComponenti(FN);
  grdChiamate.medpBrowse:=False;
  grdChiamate.medpStato:=msEdit;
end;

procedure TW028FChiamateReperibili.imgConfermaClick(Sender:TObject);
// applica le modifiche
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  // valuta aggiornamento dati anagrafici
  // (effettuato indipendentemente dalla chiamata in reperibilità)
  if FDatiAnag.Modificato then
  begin
    try
      W002ModDatiDM.updDatiAnag.Execute;
      SessioneOracle.Commit;
      Notifica('Informazione',Format('I dati anagrafici di <b>%s</b> sono stati modificati con decorrenza %s',
                                     [FDatiAnag.Nominativo,DateToStr(FDatiAnag.Decorrenza)]),
               '',False,False,5000);
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        Notifica('Avviso',Format('Le modifiche ai dati anagrafici di <b>%s</b> non sono state aggiornate:%s%s',
                                 [FDatiAnag.Nominativo,CRLF,E.Message]),
                 '',False,True);
      end;
    end;

    // pulizia info dati anagrafici
    FDatiAnag.Clear;
  end;

  if (FRecordChiamata.Operazione = 'M') then
  begin
    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    if not ModificheRiga(FN) then
    begin
      FRecordChiamata.Operazione:='';
      grdChiamate.medpStato:=msBrowse;
      btnEseguiClick(Sender);
      Exit;
    end;
    // se il record non esiste -> errore
    if not W028DM.selT390.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      FRecordChiamata.Operazione:='';
      grdChiamate.medpStato:=msBrowse;
      MsgBox.MessageBox('Errore durante la modifica della chiamata:' + CRLF + 'il record non è più disponibile!',INFORMA);
      btnEseguiClick(Sender);
      Exit;
    end;
  end;

  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if FRecordChiamata.Operazione = 'I' then
    actInserimentoOK
  else
    actVariazioneOK;

  // ripristina stato browse
  FRecordChiamata.Operazione:='';
  grdChiamate.medpStato:=msBrowse;
end;

procedure TW028FChiamateReperibili.CreaComponentiRiga(R:Integer);
var
  i,c:Integer;
  FN: String;
  LIWC: TmeIWComboBox;
  LIWTxt: TmeIWText;
  LIWMemo: TmeIWMemo;
begin
  FN:=grdChiamate.medpValoreColonna(R,'DBG_ROWID');

  // Dipendente
  if FRecordChiamata.Operazione = 'I' then
  begin
    c:=grdChiamate.medpIndexColonna('DIPENDENTE');
    grdChiamate.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'45','','','','S');
    grdChiamate.medpCreaComponenteGenerico(R,c,grdChiamate.Componenti);
    LIWC:=(grdChiamate.medpCompCella(R,c,0) as TmeIWComboBox);
    LIWC.Name:='cmbDipendenteIns';
    LIWC.Css:=LIWC.Css + ' font_ridotto';
    LIWC.FriendlyName:=FN;
    LIWC.ItemsHaveValues:=True;
    LIWC.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
    for i:=1 to High(FArrDip) do
    begin
      LIWC.Items.Add(Format('%s' + NAME_VALUE_SEPARATOR + '%s',[FArrDip[i].ToComboString,FArrDip[i].Value]));
    end;
    LIWC.OnChange:=dcmbDipendentiChange;
    lblLegendaFiltri.Caption:=Format('Filtro dipendenti (%d disponibili)',[LIWC.Items.Count]);
    LIWC.Items.Insert(0,IfThen(LIWC.Items.Count = 0,'Nessun dipendente trovato' + NAME_VALUE_SEPARATOR,'Selezionare il dipendente' + NAME_VALUE_SEPARATOR));
    LIWC.ItemIndex:=IfThen(LIWC.Items.Count = 2,1,0); // se c'è un solo dipendente lo seleziona
  end;

  // info dipendente
  grdChiamate.medpPreparaComponenteGenerico('C',0,0,DBG_TXT,'','','','','S');
  grdChiamate.medpCreaComponenteGenerico(R,FColInfoDip,grdChiamate.Componenti);
  grdChiamate.medpCompGriglia[R].CompColonne[FColInfoDip].FriendlyName:=FN;
  LIWTxt:=(grdChiamate.medpCompCella(R,FColInfoDip,0) as TmeIWText);
  LIWTxt.Text:='';

  // richiama evento change per aggiornare info dipendente
  if FRecordChiamata.Operazione = 'I' then
    dcmbDipendentiChange(grdChiamate.medpCompCella(R,'DIPENDENTE',0));

  // esito
  c:=grdChiamate.medpIndexColonna('D_ESITO');
  grdChiamate.medpPreparaComponenteGenerico('C',0,0,DBG_RGP,'100%','Trovato,"Non trovato",Annullato','','','');
  grdChiamate.medpCreaComponenteGenerico(R,c,grdChiamate.Componenti);
  TmeTIWAdvRadioGroup(grdChiamate.medpCompGriglia[R].CompColonne[c]).Layout:=glVertical;
  TmeTIWAdvRadioGroup(grdChiamate.medpCompGriglia[R].CompColonne[c]).Columns:=1;
  grdChiamate.medpCompGriglia[R].CompColonne[c].FriendlyName:=FN;

  // note
  c:=grdChiamate.medpIndexColonna('NOTE');
  grdChiamate.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'40','','','','S');
  grdChiamate.medpCreaComponenteGenerico(R,c,grdChiamate.Componenti);
  grdChiamate.medpCompGriglia[R].CompColonne[c].FriendlyName:=FN;
  LIWMemo:=(grdChiamate.medpCompCella(R,c,0) as TmeIWMemo);
  LIWMemo.Text:='';
end;

procedure TW028FChiamateReperibili.dcmbDipendentiChange(Sender:TObject);
var
  r,c,x: Integer;
  IWC: TmeIWComboBox;
  LIWTxt: TmeIWText;
begin
  r:=grdChiamate.medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);
  c:=grdChiamate.medpIndexColonna('DIPENDENTE');

  // estrae info dipendente selezionato dall'array di dati
  IWC:=(grdChiamate.medpCompCella(r,c,0) as TmeIWComboBox);
  x:=ArrDipendentiGetIndex(IWC.Items.ValueFromIndex[IWC.ItemIndex],0,High(FArrDip));
  if x >= 0 then
  begin
    if FRecordChiamata.Operazione = 'I' then
    begin
      FRecordChiamata.Turno:=FArrDip[x].Turno;
      FRecordChiamata.Sigla:=FArrDip[x].Sigla;
      FRecordChiamata.DataTurno:=FArrDip[x].DataTurno;
    end;

    // aggiorna info dipendente
    LIWTxt:=(grdChiamate.medpCompCella(r,FColInfoDip,1) as TmeIWText);
    LIWTxt.Text:=ArrDipendentiGetText(x);
    LIWTxt.RawText:=True;
  end;
end;

procedure TW028FChiamateReperibili.TrasformaComponenti(const FN:String);
// Trasforma i componenti della riga indicata da text a control e
// viceversa per la grid grdChiamate
var
  DaTestoAControlli,ModificaDatiAnag:Boolean;
  Esito:String;
  i,c:Integer;
  LIWGrd: TmeIWGrid;
  DataOraChiamata: TDateTime;
begin
  i:=grdChiamate.medpRigaDiCompGriglia(FN);
  c:=grdChiamate.medpIndexColonna('NOTE');
  DaTestoAControlli:=grdChiamate.medpCompGriglia[i].CompColonne[c] = nil;

  // immagine per cancellazione / annullamento operazione
  LIWGrd:=(grdChiamate.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
  LIWGrd.Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',FStileCella1);
  LIWGrd.Cell[0,1].Css:=IfThen(DaTestoAControlli,FStileCella1,'invisibile');
  LIWGrd.Cell[0,2].Css:=IfThen(DaTestoAControlli,FStileCella2,'invisibile');

  // scheda anagrafica
  LIWGrd:=(grdChiamate.medpCompGriglia[i].CompColonne[FColSchedaAnag] as TmeIWGrid);
  LIWGrd.Cell[0,0].Css:=IfThen((not DaTestoAControlli) and grdChiamate.medpRigaInserimento and (i = 0),'invisibile',FStileCella3);
  // modifica dati
  DataOraChiamata:=R180VarToDateTime(grdChiamate.medpClientDataSet.Lookup('DBG_ROWID',FN,'DATA'));
  ModificaDatiAnag:=(Trunc(DataOraChiamata) = Date);
  if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
    LIWGrd.Cell[0,1].Css:=IfThen(DaTestoAControlli and ModificaDatiAnag,FStileCella1,'invisibile');

  if DaTestoAControlli then
  begin
    CreaComponentiRiga(i);
    //Impostazione item index
    Esito:=grdChiamate.medpValoreColonna(i,'D_ESITO');
    (grdChiamate.medpCompCella(i,'D_ESITO',0) as TmeTIWAdvRadioGroup).ItemIndex:=
      IfThen(Esito = 'Trovato',0,IfThen(Esito = 'Non trovato',1,2));
    (grdChiamate.medpCompCella(i,'NOTE',0) as TmeIWMemo).Text:=grdChiamate.medpValoreColonna(i,'NOTE');
  end
  else
  begin
    // Annullamento componenti
    c:=grdChiamate.medpIndexColonna('DATA');
    if grdChiamate.medpCompGriglia[i].CompColonne[c] <> nil then
      FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[c]);
    //FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[ColSchedaAnag]);
    FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[FColInfoDip]);
    c:=grdChiamate.medpIndexColonna('D_ESITO');
    FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[c]);
    c:=grdChiamate.medpIndexColonna('NOTE');
    FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[c]);
  end;
end;

function TW028FChiamateReperibili.ModificheRiga(const FN:String):Boolean;
// Restituisce True/False a seconda che il record sia stato modificato o meno
var
  i,c,idxEsito:Integer;
  DescEsito: String;
begin
  Result:=False;
  i:=grdChiamate.medpRigaDiCompGriglia(FN);

  // indice del radiogroup "esito"
  c:=grdChiamate.medpIndexColonna('D_ESITO');
  idxEsito:=(grdChiamate.medpCompCella(i,c,0) as TmeTIWAdvRadioGroup).ItemIndex;

  // esito
  DescEsito:=VarToStr(cdsT390.Lookup('DBG_ROWID',FN,'D_ESITO'));

  if (VarToStr(cdsT390.Lookup('DBG_ROWID',FN,'DIPENDENTE')) <> grdChiamate.medpValoreColonna(i,'DIPENDENTE')) or
     ((DescEsito = 'Trovato') and
      (idxEsito <> 0)) or
     ((DescEsito = 'Non trovato') and
      (idxEsito <> 1)) or
     ((DescEsito = 'Annullato') and
      (idxEsito <> 2)) or
     (VarToStr(cdsT390.Lookup('DBG_ROWID',FN,'NOTE')) <> (grdChiamate.medpCompCella(i,'NOTE',0) as TmeIWMeMo).Text) then
    Result:=True;
end;

procedure TW028FChiamateReperibili.Notification(AComponent: TComponent; Operation: TOperation);
var
  i: Integer;
  LCampo: String;
  IWC: TmeIWComboBox;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // chiusura frame modifica dati
    if AComponent = W028ModDatiFM then
    begin
      IWC:=nil;

      // se la stringa di update è valorizzata, aggiorna i dati anagrafici
      FDatiAnag.Modificato:=W028ModDatiFM.UpdateString <> '';
      if FDatiAnag.Modificato then
      begin
        // blocca la modifica del dipendente
        if FRecordChiamata.Operazione = 'I' then
        begin
          IWC:=(FindComponent('cmbDipendenteIns') as TmeIWComboBox);
          if Assigned(IWC) then
            AbilitazioneComponente(IWC,False);
        end;

        // salva info decorrenza
        FDatiAnag.Decorrenza:=W028ModDatiFM.Decorrenza;

        // aggiornamento array per visualizzazione
        for i:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
        begin
          LCampo:=Format('T430%s',[W002ModDatiDM.LstDatiVis[i]]);
          if FArrDip[W028ModDatiFM.ArrIndex].DatiVisArr[i].Modificabile then
            FArrDip[W028ModDatiFM.ArrIndex].DatiVisArr[i].Valore:=VarToStr(W002ModDatiDM.cdsDatiAnag.Lookup('CAMPO',LCampo,'VALORE'));
        end;

        // in caso di inserimento fa scattare l'evento onchange della combo dipendente
        // per aggiornare i valori
        if FRecordChiamata.Operazione = 'I' then
        begin
          dcmbDipendentiChange(IWC);
        end;

        // prepara update
        W002ModDatiDM.updDatiAnag.SetVariable('PROGRESSIVO',W028ModDatiFM.Progressivo);
        W002ModDatiDM.updDatiAnag.SetVariable('DECORRENZA',W028ModDatiFM.Decorrenza);
        W002ModDatiDM.updDatiAnag.SetVariable('SET_VALORI',W028ModDatiFM.UpdateString);
      end;
      W028ModDatiFM:=nil;
    end;
  end;
end;

function TW028FChiamateReperibili.ControlliOK(const FN:String):Boolean;
var
  i,idxEsito: Integer;
  IWC: TmeIWComboBox;
  ProgRep: String;
begin
  Result:=False;
  i:=grdChiamate.medpRigaDiCompGriglia(FN);
  // imposta variabili per inserimento / aggiornamento
  if FRecordChiamata.Operazione = 'I' then
  begin
    IWC:=(grdChiamate.medpCompCella(i,'DIPENDENTE',0) as TmeIWComboBox);
    ProgRep:=IWC.Items.ValueFromIndex[IWC.ItemIndex];
    ProgRep:=Copy(ProgRep,1,Pos('_',ProgRep) - 1);
    FRecordChiamata.ProgReper:=StrToIntDef(ProgRep,0);
  end;

  // esito
  idxEsito:=(grdChiamate.medpCompCella(i,'D_ESITO',0) as TmeTIWAdvRadioGroup).ItemIndex;
  if idxEsito = 0 then
    FRecordChiamata.Esito:='S'
  else if idxEsito = 1 then
    FRecordChiamata.Esito:='N'
  else
    FRecordChiamata.Esito:='A';

  // note
  FRecordChiamata.Note:=Trim((grdChiamate.medpCompCella(i,'NOTE',0) as TmeIWMemo).Text);

  if (FRecordChiamata.Operazione = 'I') and (FRecordChiamata.ProgReper = 0) then
  begin
    MsgBox.MessageBox('Indicare il dipendente reperibile che è stato chiamato!',INFORMA);
    try
      (grdChiamate.medpCompCella(i,'DIPENDENTE',0) as TmeIWComboBox).SetFocus;
    except
    end;
    Exit;
  end;

  // verifiche sulla base dati
  // verifica chiamata già esistente (in base a inserimento / variazione)
  if FRecordChiamata.Operazione = 'I' then
  begin
    if QueryPK1.EsisteChiave('T390_CHIAMATE_REPERIB','',dsInsert,['DATA','UTENTE','PROGRESSIVO_REPER'],
       [DateToStr(FRecordChiamata.Data),FRecordChiamata.Operatore,IntToStr(FRecordChiamata.ProgReper)]) then
    begin
      MsgBox.MessageBox('Chiamata già esistente!',INFORMA);
      Exit;
    end
  end
  else
  begin
    if QueryPK1.EsisteChiave('T390_CHIAMATE_REPERIB',W028DM.selT390.RowID,dsEdit,['DATA','UTENTE','PROGRESSIVO_REPER'],
      [DateToStr(FRecordChiamata.Data),FRecordChiamata.Operatore,IntToStr(FRecordChiamata.ProgReper)]) then
    begin
      MsgBox.MessageBox('Chiamata già esistente!',INFORMA);
      Exit;
    end
  end;
  // controlli ok
  Result:=True;
end;

procedure TW028FChiamateReperibili.actInserimentoOK;
// controlli ok -> inserimento record di pianificazione
begin
  W028DM.selT390.Append;
  W028DM.selT390.FieldByName('DATA').AsDateTime:=FRecordChiamata.Data;
  W028DM.selT390.FieldByName('UTENTE').AsString:=FRecordChiamata.Operatore;
  W028DM.selT390.FieldByName('PROGRESSIVO_REPER').AsInteger:=FRecordChiamata.ProgReper;
  W028DM.selT390.FieldByName('ESITO').AsString:=FRecordChiamata.Esito;
  W028DM.selT390.FieldByName('NOTE').AsString:=FRecordChiamata.Note;
  W028DM.selT390.FieldByName('TURNO').AsString:=FRecordChiamata.Turno;
  W028DM.selT390.FieldByName('SIGLA').AsString:=FRecordChiamata.Sigla;
  W028DM.selT390.FieldByName('DATA_TURNO').AsDateTime:=FRecordChiamata.DataTurno;
  try
    W028DM.selT390.Post;
  except
    on E:Exception do
    begin
      RegistraLog.AnnullaOperazione;
      SessioneOracle.Commit;
      MsgBox.MessageBox('Inserimento della chiamata fallito!' + CRLF + 'Motivo: ' + E.Message,INFORMA);
    end;
  end;
  // rilegge i dati
  InizializzaAccesso;
end;

procedure TW028FChiamateReperibili.actVariazioneOK;
// controlli ok -> variazione record di pianificazione
begin
  W028DM.selT390.Edit;
  W028DM.selT390.FieldByName('ESITO').AsString:=FRecordChiamata.Esito;
  W028DM.selT390.FieldByName('NOTE').AsString:=FRecordChiamata.Note;
  try
    W028DM.selT390.Post;
  except
    on E:Exception do
    begin
      RegistraLog.AnnullaOperazione;
      SessioneOracle.Commit;
      MsgBox.MessageBox('Variazione della chiamata fallita!#13#10Motivo: ' + E.Message,INFORMA);
    end;
  end;
  // rilegge i dati
  InizializzaAccesso;
end;

procedure TW028FChiamateReperibili.grdChiamateAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
  LIWGrd: TmeIWGrid;
begin
  for i:=1 to High(grdChiamate.medpCompGriglia) do
    (grdChiamate.medpCompCella(i,FColSchedaAnag,0) as TmeIWImageFile).OnClick:=imgSchedaAnagraficaClick;

  if (not SolaLettura) then
  begin
    if FStileCella1 = '' then
    begin
      LIWGrd:=(grdChiamate.medpCompGriglia[0].CompColonne[0] as TmeIWGrid);
      FStileCella1:=LIWGrd.Cell[0,0].Css;
      FStileCella2:=LIWGrd.Cell[0,2].Css;
      FStileCella3:=(grdChiamate.medpCompGriglia[0].CompColonne[FColSchedaAnag] as TmeIWGrid).Cell[0,0].Css;
    end;

    //Riga di inserimento
    (grdChiamate.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
    (grdChiamate.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
    (grdChiamate.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
    LIWGrd:=(grdChiamate.medpCompGriglia[0].CompColonne[0] as TmeIWGrid);
    LIWGrd.Cell[0,1].Css:='invisibile';
    LIWGrd.Cell[0,2].Css:='invisibile';

    // scheda anagrafica e modifica dati anagrafici
    (grdChiamate.medpCompCella(0,FColSchedaAnag,0) as TmeIWImageFile).OnClick:=imgSchedaAnagraficaClick;
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
      (grdChiamate.medpCompCella(0,FColSchedaAnag,1) as TmeIWImageFile).OnClick:=imgModificaDatiClick;
    LIWGrd:=(grdChiamate.medpCompGriglia[0].CompColonne[FColSchedaAnag] as TmeIWGrid);
    LIWGrd.Cell[0,0].Css:='invisibile';
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
      LIWGrd.Cell[0,1].Css:='invisibile';

    //Righe dati
    for i:=1 to High(grdChiamate.medpCompGriglia) do
    begin
      if Parametri.Operatore <> grdChiamate.medpValoreColonna(i,'UTENTE') then
      begin
        FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[0]);
      end
      else
      begin
        //Associo l'evento OnClick alle Icone
        (grdChiamate.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgModificaClick;
        (grdChiamate.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (grdChiamate.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
        LIWGrd:=(grdChiamate.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
        LIWGrd.Cell[0,1].Css:='invisibile';
        LIWGrd.Cell[0,2].Css:='invisibile';

        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        begin
          (grdChiamate.medpCompCella(i,FColSchedaAnag,1) as TmeIWImageFile).OnClick:=imgModificaDatiClick;
          LIWGrd:=(grdChiamate.medpCompGriglia[i].CompColonne[FColSchedaAnag] as TmeIWGrid);
          LIWGrd.Cell[0,1].Css:='invisibile';
        end;
      end;
    end;
  end;
end;

procedure TW028FChiamateReperibili.grdChiamateRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
var
  NumColonna: Integer;
  NomeCampo, Val: String;
  DataOraChiamata:TDateTime;  
begin
  if not grdChiamate.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdChiamate.medpNumColonna(AColumn);
  NomeCampo:=grdChiamate.medpColonna(NumColonna).DataField;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdChiamate.medpCompGriglia) + 1) and (grdChiamate.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdChiamate.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if ARow > 0 then
  begin
    if NomeCampo = 'DATA' then
    begin
      // in inserimento viene visualizzata la data/ora della chiamata che sarà inserita
      if (grdChiamate.medpStato = msInsert) and (ACell.Text = '') then
        ACell.Text:=FRecordChiamata.Data.ToString('dd/mm/yyyy hh.nn');
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if NomeCampo = 'D_INFO' then
    begin
      // informazioni dipendente
      ACell.Css:=ACell.Css + ' info_dipendente gridTrasparente';
      DataOraChiamata:=grdChiamate.DataSource.DataSet.FieldByName('DATA').AsDateTime;
      if Trunc(DataOraChiamata) = Date then
      begin
        Val:=Format('%s_%s',[grdChiamate.medpValoreColonna(ARow - 1,'PROGRESSIVO_REPER'),
                             grdChiamate.medpValoreColonna(ARow - 1,'TURNO')]);
        ACell.Text:=ArrDipendentiGetDesc(Val,0,High(FArrDip));
      end
      else
      begin
        // Genero l'identificativo per il record su FArrInfoChiamate.
        if DataOraChiamata > 0 then
        begin
          Val:=Format('%s_%s',[grdChiamate.medpValoreColonna(ARow - 1,'PROGRESSIVO_REPER'),
                               FormatDateTime('yyyymmdd_hhnnss',DataOraChiamata)]);
          ACell.Text:=ArrInfoChiamateGetDesc(Val);
        end;
      end;
      ACell.RawText:=True;
    end
    else if NomeCampo = 'D_ESITO' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if NomeCampo = 'NOTE' then
    begin
      if (ACell.Control = nil) and
         (Length(ACell.Text) > 40) then
      begin
        ACell.Hint:=grdChiamate.medpValoreColonna(ARow - 1,'NOTE');
        ACell.Text:=Copy(ACell.Text,1,40) + ' [...]';
      end
      else
        ACell.Hint:='';
      ACell.ShowHint:=True;
    end;
  end;
end;

function TW028FChiamateReperibili.ArrDipendentiGetDesc(const Codice:String;p,r:Integer):String;
var x:Integer;
begin
  x:=ArrDipendentiGetIndex(Codice,p,r);
  Result:=ArrDipendentiGetText(x);
end;

function TW028FChiamateReperibili.ArrDipendentiGetText(const PIndex: Integer): String;
// estrae il testo da visualizzare nella cella D_INFO
// con la tabella html contenente le informazioni del dipendente
var
  i, LPriorita: Integer;
  LDato: String;
  LTurno: String;
  LSigla: String;
  LDescTurno: String;
  blnNuovaRiga: Boolean;
begin
  // selezionando il primo elemento (indice = 0) il testo restituito è ''
  if (PIndex <= 0) or (PIndex > High(FArrDip)) then
  begin
    Result:='';
    Exit;
  end;

  // variabili di appoggio
  LPriorita:=FArrDip[PIndex].Priorita;
  LDescTurno:=FArrDip[PIndex].Descrizione + IfThen(LPriorita <> 0,Format(' (%d)',[LPriorita]));
  LTurno:=FArrDip[PIndex].Turno;
  LSigla:=FArrDip[PIndex].Sigla;

  // compone l'informazione da visualizzare
  Result:=Format('<table><tbody>' +
                 '<tr><td>Turno:</td><td>%s - %s</td>',
                 [IfThen(LSigla <> '',LSigla,LTurno),LDescTurno]);

  blnNuovaRiga:=False;
  // MONDOEDP - commessa MAN/02 SVILUPPO#119.ini
  {
  // info su tolleranza in entrata e uscita sul turno
  if R180OreMinutiExt(ArrDipendenti[PIndex].TollChiamataInizio) > 0 then
    Result:=Result + Format('<tr><td>Tolleranza entrata:</td><td>%s</td></tr>',[ArrDipendenti[PIndex].TollChiamataInizio]);
  if R180OreMinutiExt(ArrDipendenti[PIndex].TollChiamataFine) > 0 then
    Result:=Result + Format('<tr><td>Tolleranza uscita:</td><td>%s</td></tr>',[ArrDipendenti[PIndex].TollChiamataFine]);
  }
  // MONDOEDP - commessa MAN/02 SVILUPPO#119.fine

  // gestione dati parametrizzati
  if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
  begin
    // dati da visualizzare
    for i:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
    begin
      LDato:=FArrDip[PIndex].DatiVisArr[i].Caption;
      if WR000DM.cdsI010.Locate('NOME_CAMPO',FArrDip[PIndex].DatiVisArr[i].CampoV430,[]) then
      begin
        if WR000DM.cdsI010.FieldByName('ACCESSO').AsString <> 'N' then
        begin
          //if WR000DM.cdsI010.FieldByName('ACCESSO').AsString = 'S' then
          if FArrDip[PIndex].DatiVisArr[i].Modificabile then
            LDato:=Format('<abbr title="Dato modificabile">%s</abbr>',[LDato]);
          if blnNuovaRiga then
            Result:=Result + '<tr>';
          Result:=Result + Format('<td>%s:</td><td>%s</td>',[LDato,FArrDip[PIndex].DatiVisArr[i].Valore]);
          blnNuovaRiga:=not blnNuovaRiga;
          if blnNuovaRiga then
            Result:=Result + '</tr> ';
        end;
      end;
    end;
  end;

  // dato filtro libero 1
  if FDatoFiltro1.Esiste then
  begin
    if blnNuovaRiga then
      Result:=Result + '<tr>';
    Result:=Result + Format('<td>%s:</td><td>%s</td>',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1),
                             FArrDip[PIndex].DatoFiltro1.ToString]);
    blnNuovaRiga:=not blnNuovaRiga;
    if blnNuovaRiga then
      Result:=Result + '</tr> ';
  end;

  // dato filtro libero 2
  if FDatoFiltro2.Esiste then
  begin
    if blnNuovaRiga then
      Result:=Result + '<tr>';
    Result:=Result + Format('<td>%s:</td> <td>%s</td>',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2),
                             FArrDip[PIndex].DatoFiltro2.ToString]);
    blnNuovaRiga:=not blnNuovaRiga;
    if blnNuovaRiga then
      Result:=Result + '</tr> ';
  end;

  // dato aggiuntivo pianificato 1
  if (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') and
     (FArrDip[PIndex].DatoAgg1.Codice <> '') then
  begin
    if blnNuovaRiga then
      Result:=Result + '<tr>';
    Result:=Result + Format('<td>%s pianificato:</td> <td>%s</td>',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1),
                             FArrDip[PIndex].DatoAgg1.ToString]);
    blnNuovaRiga:=not blnNuovaRiga;
    if blnNuovaRiga then
      Result:=Result + '</tr> ';
  end;

  // dato aggiuntivo pianificato 2
  if (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '') and
     (FArrDip[PIndex].DatoAgg2.Codice <> '') then
  begin
    if blnNuovaRiga then
      Result:=Result + '<tr>';
    Result:=Result + Format('<td>%s pianificato:</td> <td>%s</td>',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2),
                             FArrDip[PIndex].DatoAgg2.ToString]);
    blnNuovaRiga:=not blnNuovaRiga;
    if blnNuovaRiga then
      Result:=Result + '</tr> ';
  end;

  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
  if blnNuovaRiga then
    Result:=Result + '<tr>';
  Result:=Result + Format('<td>%s:</td> <td>%s</td>',['Recapito alternativo',FArrDip[PIndex].RecapitoExtra]);
  blnNuovaRiga:=not blnNuovaRiga;
  if blnNuovaRiga then
    Result:=Result + '</tr> ';
  if FCampoTelefonoAzPresente then
  begin
    if blnNuovaRiga then
      Result:=Result + '<tr>';
    Result:=Result + Format('<td>%s %s:</td> <td>%s</td>',
                            ['Telefono',Lowercase(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1),
                             FArrDip[PIndex].TelefonoAziendale]);
    blnNuovaRiga:=not blnNuovaRiga;
    if blnNuovaRiga then
      Result:=Result + '</tr> ';
  end;

  if not blnNuovaRiga then //Chiusura table
    Result:=Result + '<td></td><td></td></tr> ';

  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine
  Result:=Result + '</tbody></table>';
end;

function TW028FChiamateReperibili.ArrDipendentiGetIndex(const Codice:String;p,r:Integer):Integer;
var
  q,Res:Integer;
begin
  Res:=-1;

  if (p < r) then
  begin
    q:=p;
    if (Codice <> FArrDip[q].Value) then
      Res:=ArrDipendentiGetIndex(Codice,q + 1,r);
    if (Codice = FArrDip[q].Value) then
      Res:=q;
  end
  else if p = r then
  begin
    if FArrDip[p].Value = Codice then
      Res:=p
  end
  else
    Res:=-1;

  Result:=Res;
end;

function TW028FChiamateReperibili.ArrInfoChiamateGetDesc(ID:String): String;
// estrae il testo da visualizzare nella cella D_INFO
// con la tabella html contenente le informazioni del dipendente
var
  i, LPriorita: Integer;
  LDato: String;
  LTurno: String;
  LSigla: String;
  LDescTurno: String;
  LIndice: Integer;
begin
  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
  Result:='';
  // Ricerco il record relativo alla chiamata nell'array
  LIndice:=-1;
  for i:=0 to Length(FArrInfoChiamate) - 1 do
  begin
    if FArrInfoChiamate[i].Value = ID then
    begin
      LIndice:=i;
      Break;
    end;
  end;
  if LIndice = -1 then // Record non trovato
    Exit;

  // variabili di appoggio
  LPriorita:=FArrInfoChiamate[LIndice].Priorita;
  LDescTurno:=FArrInfoChiamate[LIndice].Descrizione + IfThen(LPriorita <> 0,Format(' (%d)',[LPriorita]));
  LTurno:=FArrInfoChiamate[LIndice].Turno;
  LSigla:=FArrInfoChiamate[LIndice].Sigla;

  // compone l'informazione da visualizzare
  Result:=Format('<table><tbody>' +
                 '<tr><td>Turno:</td><td>%s - %s</td></tr>',
                 [IfThen(LSigla <> '',LSigla,LTurno),LDescTurno]);

  // gestione dati parametrizzati
  if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
  begin
    // dati da visualizzare
    for i:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
    begin
      LDato:=FArrInfoChiamate[LIndice].DatiVisArr[i].Caption;
      begin
        if WR000DM.cdsI010.Locate('NOME_CAMPO',FArrInfoChiamate[LIndice].DatiVisArr[i].CampoV430,[]) then
        begin
          if WR000DM.cdsI010.FieldByName('ACCESSO').AsString <> 'N' then
          begin
            if FArrInfoChiamate[LIndice].DatiVisArr[i].Modificabile then
              LDato:=Format('<abbr title="Dato modificabile">%s</abbr>',[LDato]);
            Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[LDato,FArrInfoChiamate[LIndice].DatiVisArr[i].Valore]);
          end;
        end;
      end;
    end;
  end;

  // dato libero 1
  if FDatoFiltro1.Esiste then
  begin
    Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr> ',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1),
                             FArrInfoChiamate[LIndice].DatoLibero1Valore]);
  end;

  // dato libero 2
  if FDatoFiltro2.Esiste then
  begin
    Result:=Result + Format('<tr><td>%s:</td> <td>%s</td></tr> ',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2),
                            FArrInfoChiamate[LIndice].DatoLibero2Valore]);
  end;


  Result:=Result + Format('<tr><td>%s:</td> <td>%s</td></tr> ',['Recapito alternativo',FArrInfoChiamate[LIndice].RecapitoExtra]);
  if FCampoTelefonoAzPresente then
    Result:=Result + Format('<tr><td>%s %s:</td> <td>%s</td></tr> ',
                            ['Telefono',Lowercase(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1),
                             FArrInfoChiamate[LIndice].TelefonoAziendale]);


  Result:=Result + '</tbody></table>';
  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine
end;

procedure TW028FChiamateReperibili.DBGridColumnClick(ASender:TObject; const AValue:string);
begin
  inherited;
  cdsT390.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW028FChiamateReperibili.DistruggiOggetti;
begin
  if FDatoFiltro1.ListaValoriAnag <> nil then
    FreeAndNil(FDatoFiltro1.ListaValoriAnag);
  if FDatoFiltro2.ListaValoriAnag <> nil then
    FreeAndNil(FDatoFiltro2.ListaValoriAnag);
  if Assigned(W028ModDatiFM) then
    try FreeAndNil(W028ModDatiFM); except end;
  FreeAndNil(W028DM);
  FreeAndNil(W002ModDatiDM);
  grdChiamate.medpClearCompGriglia;
  SetLength(FArrDip,0);
end;

procedure TW028FChiamateReperibili.rgpTipoEsitoClick(Sender: TObject);
begin
  InizializzaAccesso;
end;

procedure TW028FChiamateReperibili.rgpTipoUtenteClick(Sender: TObject);
begin
  InizializzaAccesso;
end;

{ TDipendenti }

function TDipendenti.DistribuisciNomeCognome(const PMaxLength: Integer): String;
var
  LDiff,LCognome,LNome: Integer;
begin
  LCognome:=Length(Cognome);
  LNome:=Length(Nome);
  LDiff:=PMaxLength - LCognome - LNome;
  if LDiff < 0 then
  begin
    if LCognome > LNome then
      Cognome:=Copy(Cognome,1,LCognome - LDiff)
    else
      Nome:=Copy(Nome,1,LNome - LDiff);
  end;
  Result:=Cognome + ' ' + Nome;
end;

function TDipendenti.ToComboString: String;
var
  LIdentificativoTurno:String;
begin
  LIdentificativoTurno:=IfThen(Sigla <> '',Sigla,Turno);
  Result:=Format('%-19s %s-%s [%s]',[Nominativo,Dalle,Alle,LIdentificativoTurno]);
  if Priorita <> 0 then
    Result:=Result + Format('(%d)',[Priorita]);
end;

{ TRecordChiamata }

procedure TRecordChiamata.Clear;
begin
  Operazione:='';
  Data:=0;
  Operatore:='';
  ProgReper:=0;
  Esito:='';
  Note:='';
  DataTurno:=0;
  Turno:='';
  Sigla:='';
end;

end.
