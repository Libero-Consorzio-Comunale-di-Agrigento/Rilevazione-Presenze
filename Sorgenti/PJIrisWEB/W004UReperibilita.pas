unit W004UReperibilita;

interface

uses
  W002UModificaDatiDM, W002UModificaDatiFM,
  WC002UDatiAnagraficiFM, R010UPaginaWeb, IWApplication,
  A000USessione, A000UInterfaccia, A000UMessaggi,
  C004UParamForm, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  DatiBloccati, Math, StrUtils, Oracle, OracleData, DB, DBClient,
  Classes, Graphics, Controls, SysUtils, IWControl, IWHTMLControls, IWCompEdit,
  IWCompListbox, IWCompCheckbox, Variants, IWVCLBaseControl, Forms,
  medpIWMultiColumnComboBox, IWDBGrids, meIWGrid, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, meIWLink, meIWLabel, meIWComboBox,
  meIWCheckBox, meIWButton, meIWEdit, IWCompExtCtrls, IWCompGrids,
  meIWImageFile, IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel, IWBaseControl,
  IWBaseHTMLControl, medpIWTabControl, IWHTMLContainer, IWHTML40Container,
  IWRegion, meIWRegion, W004UReperibilitaDM, W004UModificaTabelloneFM,
  W004ULegendaColoriFM, W000UMessaggi, Vcl.Menus, IWCompRadioButton,
  meIWRadioButton, meIWRadioGroup, IWCompJQueryWidget, IWTMSCheckList,
  meTIWCheckListBox, WA040UDialogStampaFM, A000UCostanti, ActiveX,
  Datasnap.Win.MConnect, W004UModificaRecapitiFM;

const
  NRIGHEBLOCCATE = 1;
  NCOLONNEBLOCCATE = 4;

type
  TW004FReperibilita = class(TR010FPaginaWeb)
    lnkDipendentiDisponibili: TmeIWLink;
    cmbDipendentiDisponibili: TmeIWComboBox;
    edtPeriodoDal: TmeIWEdit;
    edtPeriodoAl: TmeIWEdit;
    btnEsegui: TmeIWButton;
    chkNonContDipPian: TmeIWCheckBox;
    rgpTipologia: TmeTIWAdvRadioGroup;
    lblPeriodo: TmeIWLabel;
    rgpOrdinamento: TmeTIWAdvRadioGroup;
    W004DettaglioRG: TmeIWRegion;
    grdReperibilita: TmedpIWDBGrid;
    dsrT380: TDataSource;
    cdsT380: TClientDataSet;
    tpProspetto: TIWTemplateProcessorHTML;
    DLista: TDataSource;
    W004ProspettoRG: TmeIWRegion;
    grdProspetto: TmedpIWDBGrid;
    tpDettaglio: TIWTemplateProcessorHTML;
    tabReperibilita: TmedpIWTabControl;
    lnkLegendaColoriGiorni: TmeIWLink;
    pmnTabella: TPopupMenu;
    mnuEsportaExcel: TMenuItem;
    rgpNumTurni: TmeTIWAdvRadioGroup;
    rgpVisTurnoOrario: TmeIWRadioGroup;
    lblVisTurnoOrario: TmeIWLabel;
    JQuery: TIWJQueryWidget;
    W004GestioneMensileRG: TmeIWRegion;
    tpGestMensile: TIWTemplateProcessorHTML;
    lblContratto: TmeIWLabel;
    lblDipMatricola: TmeIWLabel;
    edtDipMatricola: TmeIWEdit;
    cmbDatoLibero: TMedpIWMultiColumnComboBox;
    cmbTurno3: TMedpIWMultiColumnComboBox;
    cmbTurno2: TMedpIWMultiColumnComboBox;
    cmbTurno1: TMedpIWMultiColumnComboBox;
    lnkTurno3: TmeIWLink;
    lnkTurno2: TmeIWLink;
    lnkTurno1: TmeIWLink;
    btnCancella: TmeIWButton;
    btnInserisci: TmeIWButton;
    lblDatoLibero: TmeIWLabel;
    clbGiorni: TmeTIWCheckListBox;
    pmnAzioniGiorni: TPopupMenu;
    Selezionatutto1Giorni: TMenuItem;
    Deselezionatutto1Giorni: TMenuItem;
    Invertiselezione1Giorni: TMenuItem;
    DCOMConnection1: TDCOMConnection;
    chkSoloSelAnagrafe: TmeIWCheckBox;
    imgPeriodoPrec: TmeIWImageFile;
    imgPeriodoSucc: TmeIWImageFile;
    lblDatoAgg1: TmeIWLabel;
    lblDatoAgg2: TmeIWLabel;
    cmbDatoAgg1T1: TMedpIWMultiColumnComboBox;
    cmbDatoAgg2T1: TMedpIWMultiColumnComboBox;
    cmbDatoAgg1T2: TMedpIWMultiColumnComboBox;
    cmbDatoAgg2T2: TMedpIWMultiColumnComboBox;
    cmbDatoAgg1T3: TMedpIWMultiColumnComboBox;
    cmbDatoAgg2T3: TMedpIWMultiColumnComboBox;
    lblPriorita: TmeIWLabel;
    edtPriorita1: TmeIWEdit;
    edtPriorita2: TmeIWEdit;
    edtPriorita3: TmeIWEdit;
    lblAreeTurni: TmeIWLabel;
    cmbAreaSquadraT1: TMedpIWMultiColumnComboBox;
    cmbAreaSquadraT2: TMedpIWMultiColumnComboBox;
    cmbAreaSquadraT3: TMedpIWMultiColumnComboBox;
    lblRecapito: TmeIWLabel;
    edtRecapito1: TmeIWEdit;
    edtRecapito2: TmeIWEdit;
    edtRecapito3: TmeIWEdit;
    mnuEsportaCsv: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure lnkDipendentiDisponibiliClick(Sender: TObject);
    procedure rgpTipologiaClick(Sender: TObject);
    procedure grdReperibilitaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdReperibilitaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbTurnoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure grdProspettoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdProspettoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure IWAppFormRender(Sender: TObject);
    procedure lnkTurnoClick(Sender: TObject);
    procedure lnkLegendaColoriGiorniClick(Sender: TObject);
    procedure tabReperibilitaTabControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tabReperibilitaTabControlChange(Sender: TObject);
    procedure mnuEsportaClick(Sender: TObject);
    procedure rgpNumTurniClick(Sender: TObject);
    procedure rgpVisTurnoOrarioClick(Sender: TObject);
    procedure btnInserisciClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure Selezionatutto1GiorniClick(Sender: TObject);
    procedure cmbDipendentiDisponibiliChange(Sender: TObject);
    procedure chkNonContDipPianClick(Sender: TObject);
    procedure cmbTurno1Change(Sender: TObject; Index: Integer);
    procedure cmbTurno2Change(Sender: TObject; Index: Integer);
    procedure cmbTurno3Change(Sender: TObject; Index: Integer);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure mnuEsportaExcelClick(Sender: TObject);
    procedure mnuEsportaCsvClick(Sender: TObject);
  private
    Dal,Al:TDateTime;
    selAnagrafe:TOracleDataSet;
    StileCella1,
    StileCella2,
    DatoLibero1,
    DatoLibero1Desc,
    DatoLibero2,
    DatoLibero2Desc,
    DatoLiberoAgg1,
    DatoLiberoAgg2: String;
    DatoRecapito: String;
    DatoAgg1Ana,DatoAgg2Ana:String;
    DatoIns1Ana,DatoIns2Ana:String;
    Squadra1Ana,Operatore1Ana:String;
    OldRecapito1,OldRecapito2,OldRecapito3,
    OldDatoAgg1T1,OldDatoAgg1T2,OldDatoAgg1T3,
    OldDatoAgg2T1,OldDatoAgg2T2,OldDatoAgg2T3:String;
    OldAreaSquadraT1,OldAreaSquadraT2,OldAreaSquadraT3:String;
    AssegnaDatoAggAna:Boolean;
    // variabili per controlli
    ErrMessage: String;
    ErrBloccante, InserimentoRecord:Boolean;
    M,T1,T2,T3,DL: String;
    P1,P2,P3: Integer;
    T1a,T2a,T3a: String;
    R1,R2,R3,Da1T1,Da1T2,Da1T3,Da2T1,Da2T2,Da2T3: String;
    AsT1,AsT2,AsT3: String;
    Progressivo: Integer;
    Data: TDateTime;
    // variabili generali
    Tipologia: String;
    Operazione: String;
    ColSchedaAnag{,ColInfoDip}: Integer;
    WC002FDatiAnagraficiFM: TWC002FDatiAnagraficiFM;
    W002ModDatiDM: TW002FModificaDatiDM;
    W002ModDatiFM: TW002FModificaDatiFM;
    W004ModRecapitiFM: TW004FModificaRecapitiFM;
    DatiAnag: TDatiAnag;
    W004DM: TW004FReperibilitaDM;
    W004FModTabFM: TW004FModificaTabelloneFM;
    W004FLegendaColoriFM: TW004FLegendaColoriFM;
    C004FParamFormPrv:TC004FParamForm;
    C004DM_1:TC004FParamForm;
    FiltroDip:String;
    MaxLenTurno: Integer;
    OldTabIndex:Integer;
    WA040Stm:TWA040FDialogStampaFM;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure GetDatiLiberi;
    procedure GetDipendentiDisponibili;
    procedure TrasformaComponenti(const FN:String);
    procedure TrasformaComponentiInserimento;
    procedure CaricaTurniDettaglio;
    procedure CaricaTurniTabellone;
    procedure CaricaListaTabellone;
    function CaricaClbGiorni(DataIniMese:TDateTime):string;
    procedure cmbDipendenteDettaglioChange(Sender: TObject; Index: Integer);
    procedure IniGestMensile;
    procedure IniGestMensileDatiAgg;
    procedure SvuotaGestMensileDatiAgg;
    procedure InizializzaVariabiliInserimento;
    procedure AbilitaGestMensileDatoAgg1;
    procedure AbilitaGestMensileDatoAgg2;
    procedure AbilitaGestMensileDatoAgg3;
    procedure FineElaborazioneMensile(VisualizzaMsg:Boolean = False);
    procedure VisualizzaGrigliaTabellone;
    function  ModificheRiga(const FN: String): Boolean;
    function  ControlliOK(const FN:String): Boolean;
    procedure TurniIntersecati(T1, T2:String);
    procedure TurniIntersecatiTipologieDiverse(T1,T2:String; DataRif:TDateTime);
    function  RaggruppamentiAbilitati(Prog:Integer; DataRif:TDateTime): Boolean;
    function  GiornataAssenza(Data:TDateTime; Progressivo: Integer): Boolean;
    procedure VisualizzaRgpTurnoOrario(const Stato:boolean);
    procedure actInsVar0;
    procedure actInsVar1;
    procedure actInsVar2;
    procedure actInsVar3;
    procedure actInsVar4;
    procedure actInsVar5;
    procedure actInsVar6;
    procedure actInsVar7;
    procedure actInsVar8;
    procedure actInsVar9;
    procedure actInsVar10;
    procedure actInsVar11;
    procedure actInsVar12;
    procedure actInsVar13;
    procedure actInserimentoOK;
    procedure actVariazioneOK;
    procedure actCancellazioneOK(FN:String);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgInserisciRecapitiClick(Sender: TObject);
    procedure imgConfermaInserimentoClick(Sender: TObject);
    procedure ControlloVincoliIndividuali(TurnoVincoli:String);
    procedure imgModificaDatiClick(Sender: TObject);
    procedure imgModificaRecapitiClick(Sender: TObject);
    function  GetInfoDip(Row:Integer): String;
    procedure PreparaDatiAnag;
    function VarToInt(MyVar:variant):integer;
    procedure CallDCOMPrinter;
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    function  GetProgressivo: Integer; override;
    function  GetInfoFunzione: String; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    grdModifica: TmedpIWDBGrid;
    DatoLiberoCodLen: Integer;
    lstDatoLibero,lstTurniDisponibili:TStringList;
    function  InizializzaAccesso:Boolean; override;
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure OnTabChanging(var AllowChange: Boolean; var Conferma: String); override;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    procedure GetTurniPianificati;
    procedure Cancellazione(FN: String);
    procedure Inserimento;
    procedure InserimentoSingolo;
    procedure Modifica(FN: String);
    procedure openSelT380GestMensile;
    procedure EseguiStampa;
  end;

implementation

uses W001UIrisWebDtM;

{$R *.DFM}

procedure TW004FReperibilita.IWAppFormCreate(Sender: TObject);
var
  S,DatiStorici: String;
begin
  inherited;
  AddScrollBarManager('divscrollable');
  // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.ini
  W002ModDatiDM:=TW002FModificaDatiDM.Create(Self);
  // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.fine

  // verifica le abilitazioni della funzione (W002) Scheda anagrafica (tag 412)
  if A000GetInibizioni('Tag','412') <> 'N' then
    lnkDipendentiDisponibili.OnClick:=lnkDipendentiDisponibiliClick
  else
    lnkDipendentiDisponibili.OnClick:=nil;

  //C004: gestire il Numero turni da visualizzare nel prospetto
  C004FParamFormPrv:=CreaC004(SessioneOracle,'W004',Parametri.Operatore,False);
  GetParametriFunzione;

  // imposta la gestione automatica degli spostamenti di periodo
  AssegnaGestPeriodo(edtPeriodoDal,edtPeriodoAl,imgPeriodoPrec,imgPeriodoSucc);

  W004DM:=TW004FReperibilitaDM.Create(Self);

  // inizializzazione dati
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);
  edtPeriodoDal.Text:=DateToStr(Dal);
  edtPeriodoAl.Text:=DateToStr(Al);
  selAnagrafe:=TOracleDataSet.Create(Self);
  selAnagrafe.Session:=WR000DM.selAnagrafe.Session;
  selAnagrafe.SQL.Assign(WR000DM.selAnagrafe.SQL);
  selAnagrafe.SQL[0]:='SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE FROM';
  selAnagrafe.Variables.Assign(WR000DM.selAnagrafe.Variables);

  R180SetVariable(selAnagrafe,'FILTRO', W004DM.AggiornaFiltroRicerca(selAnagrafe.GetVariable('FILTRO')));

  // inizializzazione griglia di inserimento
  lstDatoLibero:=TStringList.Create;
  lstDatoLibero.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  lstTurniDisponibili:=TStringList.Create;
  if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
  begin
    // reperimento dato libero e popolamento combobox relativa
    lstDatoLibero.Clear;
    with WR000DM do
    begin
      if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,selDatoLibero) then
      begin
        lstDatoLibero.Add('');
        if selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
          selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
        with selDatoLibero do
        begin
          Open;
          First;
          DatoLiberoCodLen:=0;
          while not Eof do
          begin
            if Length(FieldByName('CODICE').AsString) > DatoLiberoCodLen then
              DatoLiberoCodLen:=Length(FieldByName('CODICE').AsString);
            Next;
          end;
          First;
          // ciclo di popolamento della combo
          while not Eof do
          begin
            S:=Format('%-*s - %s',[DatoLiberoCodLen,FieldByName('CODICE').AsString,
               FieldByName('DESCRIZIONE').AsString]);
            lstDatoLibero.Values[S]:=FieldByName('CODICE').AsString;
            Next;
          end;
          Close;
        end;
      end;
    end;
  end;

  // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
  // elenco dati da visualizzare e da modificare per la reperibilità
  DatiAnag.Modificato:=False;
  DatiAnag.Progressivo:=0;
  DatiAnag.Decorrenza:=DATE_NULL;
  DatiAnag.Nominativo:='';
  // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine

  // estrae i dati liberi da visualizzare (chiamate in reperibilità)
  GetDatiLiberi;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdReperibilita.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdReperibilita.medpDataSet:=W004DM.selT380;
  grdModifica:=grdReperibilita;

  with WR000DM do
    selT350.Tag:=selT350.Tag + 1;

  W004DM.A040MW.evtFineElaborazioneMensile:=FineElaborazioneMensile;

  C004DM_1:=CreaC004(SessioneOracle,'W004_1',Parametri.Operatore,False);
  WA040Stm:=TWA040FDialogStampaFM.Create(Self);
  WA040Stm.A040MWStm:=W004DM.A040MW;
  WA040Stm.C004DMStm:=C004DM_1;
  WA040Stm.evtEseguiStampa:=EseguiStampa;
  WA040Stm.OperazioniIniziali;

  tabReperibilita.AggiungiTab(A000TraduzioneStringhe(A000MSG_W004_MSG_LBL_DETTAGLIO), W004DettaglioRG);
  tabReperibilita.AggiungiTab(A000TraduzioneStringhe(A000MSG_W004_MSG_LBL_PROSPETTO), W004ProspettoRG);
  tabReperibilita.AggiungiTab(A000TraduzioneStringhe(A000MSG_W004_MSG_LBL_GEST_MENSILE), W004GestioneMensileRG);
  // Bugfix ORBASSANO_HSLUIGI - chiamata 123614.ini
  // il tab di gestione mensile non deve essere disponibile in caso di accesso in sola lettura
  tabReperibilita.Tabs[W004GestioneMensileRG].Visible:=not SolaLettura;
  // Bugfix ORBASSANO_HSLUIGI - chiamata 123614.fine
  tabReperibilita.AggiungiTab(A000TraduzioneStringhe(A000MSG_W004_MSG_LBL_STAMPA), WA040Stm);
  tabReperibilita.ActiveTab:=W004DettaglioRG;
  OldTabIndex:=0;

  grdProspetto.medpPaginazione:=False;
  grdProspetto.medpDataSet:=W004DM.cdsLista;
  grdProspetto.medpTestoNoRecord:='Nessun record';

  GetDipendentiDisponibili;
  //rgpTipologia.ItemIndex:=0;
  rgpTipologiaClick(rgpTipologia);

  // Reperisco Dati liberi 1 e 2 di default
  DatiStorici:='T430SQUADRA, T430TIPOOPE';
  DatoIns1Ana:='';
  DatoIns2Ana:='';

  if AssegnaDatoAggAna then
  begin
    if DatoLiberoAgg1 <> '' then
      DatiStorici:=DatiStorici + ',' + DatoLiberoAgg1 + IfThen(DatoLiberoAgg2 <> '',',' + DatoLiberoAgg2) + IfThen(DatoRecapito <> '',',' + DatoRecapito);
    W004DM.QSDatiAgg.GetDatiStorici(DatiStorici,GetProgressivo,EncodeDate(1900,1,1),EncodeDate(3999,12,31));

    if (W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) and
        (DatoLiberoAgg1 <> '')) then
      DatoIns1Ana:=W004DM.QSDatiAgg.FieldByName(DatoLiberoAgg1).AsString;
    if (W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) and
        (DatoLiberoAgg2 <> '')) then
      DatoIns2Ana:=W004DM.QSDatiAgg.FieldByName(DatoLiberoAgg2).AsString;
  end;
end;

procedure TW004FReperibilita.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TW004FReperibilita.openSelT380GestMensile;
begin
  R180SetVariable(W004DM.selT380GestMesile,'QVISTAORACLE',StringReplace(QVistaOracle,':DataLavoro','T380.DATA',[rfReplaceAll, rfIgnoreCase]));
  R180SetVariable(W004DM.selT380GestMesile,'DAL',Dal);
  R180SetVariable(W004DM.selT380GestMesile,'AL',Al);
  R180SetVariable(W004DM.selT380GestMesile,'TIPOLOGIA',Tipologia);
  W004DM.selT380GestMesile.Open;
end;

procedure TW004FReperibilita.VisualizzaRgpTurnoOrario(const Stato:boolean);
begin
  C190VisualizzaElemento(JQuery,rgpVisTurnoOrario.Name,Stato);
end;

procedure TW004FReperibilita.IWAppFormRender(Sender: TObject);
begin
  inherited;
  rgpOrdinamento.Visible:=tabReperibilita.ActiveTab = W004DettaglioRG;
  rgpNumTurni.Visible:=tabReperibilita.ActiveTab = W004ProspettoRG;

  rgpVisTurnoOrario.Visible:=tabReperibilita.ActiveTab = W004ProspettoRG;
  VisualizzaRgpTurnoOrario(rgpVisTurnoOrario.Visible);

  lnkLegendaColoriGiorni.Visible:=tabReperibilita.ActiveTab <> W004DettaglioRG;
  if tabReperibilita.ActiveTab = W004DettaglioRG then
    grdModifica:=grdReperibilita;
end;

function TW004FReperibilita.InizializzaAccesso:Boolean;
var
  StrRicercaAnag:string;
begin
  Result:=True;
  if ParametriForm.Chiamante = 'W030' then
  begin
    Dal:=ParametriForm.Dal;
    Al:=ParametriForm.Al;
    Progressivo:=ParametriForm.Progressivo;
    with selAnagrafe do
    begin
      selAnagrafe.SearchRecord('PROGRESSIVO',Progressivo,[srFromBeginning]);
      StrRicercaAnag:=Format('%-8s %s %s',[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString,FieldByName('NOME').AsString]);
      StrRicercaAnag:=StrRicercaAnag + '=' + FieldByName('MATRICOLA').AsString;
      cmbDipendentiDisponibili.ItemIndex:=cmbDipendentiDisponibili.Items.IndexOf(StrRicercaAnag);
    end;
  end;
end;

procedure TW004FReperibilita.RefreshPage;
begin
  //btnEseguiClick(nil);
end;

procedure TW004FReperibilita.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 14 OK }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    RimuoviNotifiche;
  end;
end;

procedure TW004FReperibilita.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // chiusura frame modifica dati
    if AComponent = W002ModDatiFM then
    begin
      // se la stringa di update è valorizzata, aggiorna i dati anagrafici
      DatiAnag.Modificato:=W002ModDatiFM.UpdateString <> '';
      if DatiAnag.Modificato then
      begin
        // salva info decorrenza
        DatiAnag.Decorrenza:=W002ModDatiFM.Decorrenza;

        // prepara update
        with W002ModDatiDM.updDatiAnag do
        begin
          SetVariable('PROGRESSIVO',W002ModDatiFM.Progressivo);
          SetVariable('DECORRENZA',W002ModDatiFM.Decorrenza);
          SetVariable('SET_VALORI',W002ModDatiFM.UpdateString);
        end;
      end;
      W002ModDatiFM:=nil;
    end
    else if AComponent = W004ModRecapitiFM then // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
    begin
      // Chiusura frame modifica recapiti.
      try
        if W004ModRecapitiFM.Modificato then
        begin
          if not InserimentoRecord then
          begin
            cdsT380.Edit;
            cdsT380.FieldByName('RECAPITO1').AsString:=W004ModRecapitiFM.RecapitoT1;
            cdsT380.FieldByName('RECAPITO2').AsString:=IfThen(W004ModRecapitiFM.CodT2 <> '',W004ModRecapitiFM.RecapitoT2,'');
            cdsT380.FieldByName('RECAPITO3').AsString:=IfThen(W004ModRecapitiFM.CodT3 <> '',W004ModRecapitiFM.RecapitoT3,'');
            cdsT380.FieldByName('DATOAGG1_T1').AsString:=W004ModRecapitiFM.DatoAgg1T1;
            cdsT380.FieldByName('DATOAGG1_T2').AsString:=IfThen(W004ModRecapitiFM.CodT2 <> '',W004ModRecapitiFM.DatoAgg1T2,'');
            cdsT380.FieldByName('DATOAGG1_T3').AsString:=IfThen(W004ModRecapitiFM.CodT3 <> '',W004ModRecapitiFM.DatoAgg1T3,'');
            cdsT380.FieldByName('DATOAGG2_T1').AsString:=W004ModRecapitiFM.DatoAgg2T1;
            cdsT380.FieldByName('DATOAGG2_T2').AsString:=IfThen(W004ModRecapitiFM.CodT2 <> '',W004ModRecapitiFM.DatoAgg2T2,'');
            cdsT380.FieldByName('DATOAGG2_T3').AsString:=IfThen(W004ModRecapitiFM.CodT3 <> '',W004ModRecapitiFM.DatoAgg2T3,'');
            cdsT380.FieldByName('AREASQUADRA_T1').AsString:=W004ModRecapitiFM.DatoAreaSquadraT1;
            cdsT380.FieldByName('AREASQUADRA_T2').AsString:=IfThen(W004ModRecapitiFM.CodT2 <> '',W004ModRecapitiFM.DatoAreaSquadraT2,'');
            cdsT380.FieldByName('AREASQUADRA_T3').AsString:=IfThen(W004ModRecapitiFM.CodT3 <> '',W004ModRecapitiFM.DatoAreaSquadraT3,'');
            cdsT380.Post;
          end
          else
          begin
            R1:=W004ModRecapitiFM.RecapitoT1;
            R2:=IfThen(W004ModRecapitiFM.CodT2 <> '',W004ModRecapitiFM.RecapitoT2,'');
            R3:=IfThen(W004ModRecapitiFM.CodT3 <> '',W004ModRecapitiFM.RecapitoT3,'');
            Da1T1:=W004ModRecapitiFM.DatoAgg1T1;
            Da1T2:=IfThen(W004ModRecapitiFM.CodT2 <> '',W004ModRecapitiFM.DatoAgg1T2,'');
            Da1T3:=IfThen(W004ModRecapitiFM.CodT3 <> '',W004ModRecapitiFM.DatoAgg1T3,'');
            Da2T1:=W004ModRecapitiFM.DatoAgg2T1;
            Da2T2:=IfThen(W004ModRecapitiFM.CodT2 <> '',W004ModRecapitiFM.DatoAgg2T2,'');
            Da2T3:=IfThen(W004ModRecapitiFM.CodT3 <> '',W004ModRecapitiFM.DatoAgg2T3,'');
            AsT1:=W004ModRecapitiFM.DatoAreaSquadraT1;
            AsT2:=IfThen(W004ModRecapitiFM.CodT2 <> '',W004ModRecapitiFM.DatoAreaSquadraT2,'');
            AsT3:=IfThen(W004ModRecapitiFM.CodT3 <> '',W004ModRecapitiFM.DatoAreaSquadraT3,'');
          end;
        end;
      finally
        InserimentoRecord:=False;
        W004ModRecapitiFM:=nil;
      end;
      // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine
    end;
  end;
end;

procedure TW004FReperibilita.GetParametriFunzione;
{Leggo i parametri della form}
begin
  rgpNumTurni.ItemIndex:=StrToInt(C004FParamFormPrv.GetParametro('rgpNumTurni','2'));
  rgpVisTurnoOrario.ItemIndex:=C004FParamFormPrv.GetParametro(UpperCase(rgpVisTurnoOrario.Name),'0').ToInteger;
  rgpTipologia.ItemIndex:=C004FParamFormPrv.GetParametro(UpperCase(rgpTipologia.Name),'0').ToInteger;
  chkNonContDipPian.Checked:=C004FParamFormPrv.GetParametro(UpperCase(chkNonContDipPian.Name),'N') = 'S';
  chkSoloSelAnagrafe.Checked:=C004FParamFormPrv.GetParametro(UpperCase(chkSoloSelAnagrafe.Name),'N') = 'S';
  chkNonContDipPianClick(chkNonContDipPian);
end;

procedure TW004FReperibilita.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  try
    C004FParamFormPrv.Cancella001;
    C004FParamFormPrv.PutParametro('rgpNumTurni',IntToStr(rgpNumTurni.ItemIndex));
    C004FParamFormPrv.PutParametro(Uppercase(rgpVisTurnoOrario.Name),rgpVisTurnoOrario.ItemIndex.ToString);
    C004FParamFormPrv.PutParametro(Uppercase(rgpTipologia.Name),rgpTipologia.ItemIndex.ToString);
    C004FParamFormPrv.PutParametro(UpperCase(chkNonContDipPian.Name),IfThen(chkNonContDipPian.Checked,'S','N'));
    C004FParamFormPrv.PutParametro(UpperCase(chkSoloSelAnagrafe.Name),IfThen(chkSoloSelAnagrafe.Checked,'S','N'));
    C004FParamFormPrv.InsT001.Session.Commit;
  except
  end;
end;

procedure TW004FReperibilita.GetDatiLiberi;
// estrae gli eventuali liberi impostati a livello aziendale
// legati al filtro chiamate in reperibilità
var
  Tabella,Codice,Storico: String;
begin
  DatoLibero1:='';
  DatoLibero1Desc:='';
  DatoLibero2:='';
  DatoLibero2Desc:='';
  DatoLiberoAgg1:='';
  DatoLiberoAgg2:='';

  // dato libero 1 da riportare in tabella
  if Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 <> '' then
  begin
    DatoLibero1:=Format('T430%s',[Parametri.CampiRiferimento.C29_ChiamateRepFiltro1]);
    A000GetTabella(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,Tabella,Codice,Storico);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
      DatoLibero1Desc:=Format('T430D_%s',[Parametri.CampiRiferimento.C29_ChiamateRepFiltro1]);
  end;

  // dato libero 2 per filtro chiamate in reperibilità
  if Parametri.CampiRiferimento.C29_ChiamateRepFiltro2 <> '' then
  begin
    DatoLibero2:=Format('T430%s',[Parametri.CampiRiferimento.C29_ChiamateRepFiltro2]);
    A000GetTabella(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2,Tabella,Codice,Storico);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
      DatoLibero2Desc:=Format('T430D_%s',[Parametri.CampiRiferimento.C29_ChiamateRepFiltro2]);
  end;

  // dato aggiuntivo 1 in pianificazione turno
  if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '' then
    DatoLiberoAgg1:=Format('T430%s',[Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1]);

  // dato aggiuntivo 2 in pianificazione turno
  if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '' then
    DatoLiberoAgg2:=Format('T430%s',[Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2]);

  // dato recapito
  if Parametri.CampiRiferimento.C29_ChiamateRepDatoMod <> '' then
    DatoRecapito:=Format('T430%s',[Parametri.CampiRiferimento.C29_ChiamateRepDatoMod]);

  cmbTurno1.OnChange:=cmbTurno1Change;
  cmbTurno2.OnChange:=cmbTurno2Change;
  cmbTurno3.OnChange:=cmbTurno3Change;
  AssegnaDatoAggAna:=False;
  if DatoLiberoAgg1 <> '' then
  begin
    AssegnaDatoAggAna:=True;
    SvuotaGestMensileDatiAgg;
  end;
end;

procedure TW004FReperibilita.GetTurniPianificati;
// popola la tabella della reperibilita
var
  Dati:String;
begin
  Operazione:='';
  grdReperibilita.medpBrowse:=True;

  Dati:='';
  if DatoLibero1 <> '' then
  begin
    Dati:=Dati + Format('%s,',[DatoLibero1]);
    if DatoLibero1Desc <> '' then
      Dati:=Dati + Format('%s,',[DatoLibero1Desc]);
  end;
  if DatoLibero2 <> '' then
  begin
    Dati:=Dati + Format('%s,',[DatoLibero2]);
    if DatoLibero2Desc <> '' then
      Dati:=Dati + Format('%s,',[DatoLibero2Desc]);
  end;
  if DatoLiberoAgg1 <> '' then
    Dati:=Dati + Format('%s,',[DatoLiberoAgg1]);
  if DatoLiberoAgg2 <> '' then
    Dati:=Dati + Format('%s,',[DatoLiberoAgg2]);

  // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.ini
  W002ModDatiDM.IntegraCampiV430RepVis(Dati);
  if (Dati <> '') and (RightStr(Dati,1) <> ',') then
    Dati:=Dati + ',';
  // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.fine

  if DatoRecapito <> '' then
    Dati:=Dati + Format('%s,',[DatoRecapito]);

  // lettura turni pianificati
  with W004DM.selT380 do
  begin
    SetVariable('DL',Dati);
    SetVariable('FILTRO',W004DM.AggiornaFiltroRicerca(WR000DM.FiltroRicerca));
    SetVariable('DAL',Dal);
    SetVariable('DATALAVORO',Al);
    SetVariable('TIPOLOGIA',Tipologia);
    if rgpOrdinamento.ItemIndex = 0 then
      SetVariable('ORDINE','T030.COGNOME,T030.NOME,MATRICOLA,DATA')
    else
      SetVariable('ORDINE','DATA,T030.COGNOME,T030.NOME,MATRICOLA');
    Close;
    Open;
  end;

  if tabReperibilita.ActiveTab = W004DettaglioRG then
    CaricaTurniDettaglio
  else if tabReperibilita.ActiveTab = W004ProspettoRG then
    CaricaTurniTabellone;
end;

procedure TW004FReperibilita.CaricaTurniDettaglio;
begin
  with grdReperibilita do
  begin
    medpCreaCDS;
    medpEliminaColonne;
    medpAggiungiColonna('DBG_COMANDI','','',nil);
    medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    medpAggiungiColonna('T030NOMINATIVO','Nominativo','',nil);
    //medpAggiungiColonna('T430BADGE','Badge','',nil); // daniloc - attività per SAVONA_ASL2 2012/120 varie 1  - 24.09.2012

    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    // modifica dati anagrafici
    medpAggiungiColonna('D_SCHEDAANAG','','',nil);

    // info dipendente (dati liberi di filtro / dati liberi da visualizzare)
    if (DatoLibero1 <> '') or (DatoLibero2 <> '') or (Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '')
    or (DatoLiberoAgg1 <> '') or (DatoLiberoAgg2 <> '') then
      medpAggiungiColonna('D_INFO','Informazioni','',nil);
    {
    if DatoLibero1 <> '' then
      medpAggiungiColonna(IfThen(DatoLibero1Desc <> '',DatoLibero1Desc,DatoLibero1),R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1),'',nil);
    if DatoLibero2 <> '' then
      medpAggiungiColonna(IfThen(DatoLibero2Desc <> '',DatoLibero2Desc,DatoLibero2),R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2),'',nil);
    }
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine
    medpAggiungiColonna('DATA','Data','',nil);
    medpAggiungiColonna('DATA_GIORNO','gg','',nil); // daniloc. 07.02.2011 (campo DATA_GIORNO sul dataset)
    medpAggiungiColonna('TURNO1','Turno 1','',nil);
    medpColonna('TURNO1').Visible:=False;
    medpAggiungiColonna('C_TURNO1','Turno 1','',nil);
    medpAggiungiColonna('PRIORITA1','Priorità 1','',nil);
    medpColonna('PRIORITA1').Visible:=Tipologia = 'R'; // solo per reperibilità
    medpAggiungiColonna('TURNO2','Turno 2','',nil);
    medpColonna('TURNO2').Visible:=False;
    medpAggiungiColonna('C_TURNO2','Turno 2','',nil);
    medpAggiungiColonna('PRIORITA2','Priorità 2','',nil);
    medpColonna('PRIORITA2').Visible:=Tipologia = 'R'; // solo per reperibilità
    medpAggiungiColonna('TURNO3','Turno 3','',nil);
    medpColonna('TURNO3').Visible:=False;
    medpAggiungiColonna('C_TURNO3','Turno 3','',nil);
    medpAggiungiColonna('PRIORITA3','Priorità 3','',nil);
    medpColonna('PRIORITA3').Visible:=Tipologia = 'R'; // solo per reperibilità
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      medpAggiungiColonna('DATOLIBERO',R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile),'',nil);
    end;
   // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
    medpAggiungiColonna('RECAPITO1','Recapito alt. turno 1','',nil);
    medpColonna('RECAPITO1').Visible:=False;
    medpAggiungiColonna('RECAPITO2','Recapito alt. turno 2','',nil);
    medpColonna('RECAPITO2').Visible:=False;
    medpAggiungiColonna('RECAPITO3','Recapito alt. turno 3','',nil);
    medpColonna('RECAPITO3').Visible:=False;
   // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine
    medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
    medpInizializzaCompGriglia;

    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    // indici utilizzati nella gestione
    ColSchedaAnag:=medpIndexColonna('D_SCHEDAANAG');
    //ColInfoDip:=medpIndexColonna('D_INFO');
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine

    if not SolaLettura then
    begin
      medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
      medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
      medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
      medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
      //Riga di inserimento
      medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
      medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
      medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');

      // scheda anagrafica e modifica dati anagrafici
      medpPreparaComponenteGenerico('R',ColSchedaAnag,0,DBG_IMG,'','MODIFICA','Modifica i dati anagrafici','','S',True); // mantenere parametro Grid = True
      medpPreparaComponenteGenerico('R',ColSchedaAnag,1,DBG_IMG,'','','Modifica ' + IfThen(DatoLiberoAgg1 <> '','le informazioni aggiuntive','i recapiti alternativi'),'','S',True);
      //Riga di inserimento
      medpPreparaComponenteGenerico('I',ColSchedaAnag,1,DBG_IMG,'','','Modifica ' + IfThen(DatoLiberoAgg1 <> '','le informazioni aggiuntive','i recapiti alternativi'),'','S',True);
    end;
    medpCaricaCDS;
  end;
end;

function TW004FReperibilita.CaricaClbGiorni(DataIniMese:TDateTime):string;
var
  i:integer;
  D:TDateTime;
  a,m,g:word;
begin
  Result:='';
  try
    // caricamento lista giorni
    clbGiorni.Items.Clear;
    DecodeDate(DataIniMese,a,m,g);
    D:=EncodeDate(a,m,1);
    DecodeDate(D,a,m,g);
    for i:=1 to R180GiorniMese(D) do
    begin
      clbGiorni.Items.Add(FormatDateTime('ddd dd/mm/yyyy',EncodeDate(a,m,i)));
      clbGiorni.Selected[i - 1]:=False;
    end;
  except
    on e:exception do
    begin
      Result:=e.message;
    end;
  end;
end;

procedure TW004FReperibilita.IniGestMensile;
var DatiStorici: string;
begin
  edtDipMatricola.Text:=cmbDipendentiDisponibili.Items[cmbDipendentiDisponibili.ItemIndex].Substring(0,8).Trim;
  DatiStorici:='T430SQUADRA, T430TIPOOPE';
  if DatoLiberoAgg1 <> '' then
    DatiStorici:=DatiStorici + ',' + DatoLiberoAgg1 + IfThen(DatoLiberoAgg2 <> '',',' + DatoLiberoAgg2) + IfThen(DatoRecapito <> '',',' + DatoRecapito);
  W004DM.QSDatiAgg.GetDatiStorici(DatiStorici,GetProgressivo,EncodeDate(1900,1,1),EncodeDate(3999,12,31));
  C190CaricaMepdMulticolumnComboBox(cmbTurno1,W004DM.A040MW.Q350,'CODICE','DESCRIZIONE');
  C190CaricaMepdMulticolumnComboBox(cmbTurno2,W004DM.A040MW.Q350,'CODICE','DESCRIZIONE');
  C190CaricaMepdMulticolumnComboBox(cmbTurno3,W004DM.A040MW.Q350,'CODICE','DESCRIZIONE');
  cmbDatoLibero.Visible:=A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,W004DM.A040MW.selDatoLibero);
  lblDatoLibero.Visible:=cmbDatoLibero.Visible;
  if lblDatoLibero.Visible then
    lblDatoLibero.Caption:=W004DM.selT380.FieldByName('DATOLIBERO').DisplayLabel;
  if cmbDatoLibero.Visible and (cmbDatoLibero.Items.Count = 0) then
    C190CaricaMepdMulticolumnComboBox(cmbDatoLibero,W004DM.A040MW.selDatoLibero,'CODICE','DESCRIZIONE');
  lblPriorita.Visible:=Tipologia = 'R';
  edtPriorita1.Visible:=Tipologia = 'R';
  edtPriorita2.Visible:=Tipologia = 'R';
  edtPriorita3.Visible:=Tipologia = 'R';
  edtRecapito1.Visible:=edtPriorita1.Visible;
  edtRecapito2.Visible:=edtPriorita2.Visible;
  edtRecapito3.Visible:=edtPriorita3.Visible;

  AssegnaDatoAggAna:=False;
  IniGestMensileDatiAgg;
  CaricaClbGiorni(Dal);
end;

procedure TW004FReperibilita.IniGestMensileDatiAgg;
begin
  // Dato aggiuntivo 1
  lblDatoAgg1.Caption:='';
  DatoAgg1Ana:='';
  if DatoLiberoAgg1 <> '' then
  begin
    lblDatoAgg1.Caption:=Trim(R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1));
    if W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) then
      DatoAgg1Ana:=W004DM.QSDatiAgg.FieldByName(DatoLiberoAgg1).AsString;
    A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1,W004DM.selSQL);
    if W004DM.selSQL.VariableIndex('DECORRENZA') >= 0 then
      W004DM.selSQL.SetVariable('DECORRENZA',R180InizioMese(Dal));
    try
      W004DM.selSQL.Open;
    except
    end;
    C190CaricaMepdMulticolumnComboBox(cmbDatoAgg1T1,W004DM.selSQL,'CODICE','DESCRIZIONE');
    C190CaricaMepdMulticolumnComboBox(cmbDatoAgg1T2,W004DM.selSQL,'CODICE','DESCRIZIONE');
    C190CaricaMepdMulticolumnComboBox(cmbDatoAgg1T3,W004DM.selSQL,'CODICE','DESCRIZIONE');
  end;
  lblDatoAgg1.Visible:=(lblDatoAgg1.Caption <> '') and (Tipologia = 'R');
  cmbDatoAgg1T1.Css:=IfThen(lblDatoAgg1.Visible,'medpMultiColumnCombo','invisibile');
  cmbDatoAgg1T2.Css:=cmbDatoAgg1T1.Css;
  cmbDatoAgg1T3.Css:=cmbDatoAgg1T1.Css;

  // dato aggiuntivo 2
  lblDatoAgg2.Caption:='';
  DatoAgg2Ana:='';
  if DatoLiberoAgg2 <> '' then
  begin
    lblDatoAgg2.Caption:=Trim(R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2));
    if W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) then
      DatoAgg2Ana:=W004DM.QSDatiAgg.FieldByName(DatoLiberoAgg2).AsString;
    A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2,W004DM.selSQL);
    if W004DM.selSQL.VariableIndex('DECORRENZA') >= 0 then
      W004DM.selSQL.SetVariable('DECORRENZA',R180InizioMese(Dal));
    try
      W004DM.selSQL.Open;
    except
    end;
    C190CaricaMepdMulticolumnComboBox(cmbDatoAgg2T1,W004DM.selSQL,'CODICE','DESCRIZIONE');
    C190CaricaMepdMulticolumnComboBox(cmbDatoAgg2T2,W004DM.selSQL,'CODICE','DESCRIZIONE');
    C190CaricaMepdMulticolumnComboBox(cmbDatoAgg2T3,W004DM.selSQL,'CODICE','DESCRIZIONE');
  end;
  lblDatoAgg2.Visible:=(lblDatoAgg2.Caption <> '') and (Tipologia = 'R');
  cmbDatoAgg2T1.Css:=IfThen(lblDatoAgg2.Visible,'medpMultiColumnCombo','invisibile');
  cmbDatoAgg2T2.Css:=cmbDatoAgg2T1.Css;
  cmbDatoAgg2T3.Css:=cmbDatoAgg2T1.Css;

  // Reperisco Squadra e tipo operatore da anagrafico
  Squadra1Ana:='';
  Operatore1Ana:='';
  if W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) then
  begin
    Squadra1Ana:=W004DM.QSDatiAgg.FieldByName('T430SQUADRA').AsString;
    Operatore1Ana:=W004DM.QSDatiAgg.FieldByName('T430TIPOOPE').AsString;
  end;
  // Aree di afferenza
  lblAreeTurni.Caption:='';
  W004DM.GetAreeAfferenza(Squadra1Ana,Operatore1Ana);
  If W004DM.selT651.RecordCount > 0 then
  begin
    lblAreeTurni.Caption:='Aree afferenza';
    C190CaricaMepdMulticolumnComboBox(cmbAreaSquadraT1,W004DM.selT651,'CODICE','DESCRIZIONE');
    C190CaricaMepdMulticolumnComboBox(cmbAreaSquadraT2,W004DM.selT651,'CODICE','DESCRIZIONE');
    C190CaricaMepdMulticolumnComboBox(cmbAreaSquadraT3,W004DM.selT651,'CODICE','DESCRIZIONE');
  end;
  lblAreeTurni.Visible:=(lblAreeTurni.Caption <> '') and (Tipologia = 'R');
  cmbAreaSquadraT1.Css:=IfThen(lblAreeTurni.Visible,'medpMultiColumnCombo','invisibile');
  cmbAreaSquadraT2.Css:=cmbAreaSquadraT1.Css;
  cmbAreaSquadraT3.Css:=cmbAreaSquadraT1.Css;

  AbilitaGestMensileDatoAgg1;
  AbilitaGestMensileDatoAgg2;
  AbilitaGestMensileDatoAgg3;
  AssegnaDatoAggAna:=False;

  //Recapito
  if DatoRecapito <> '' then
  begin
    if edtRecapito1.Enabled then
      edtRecapito1.Text:=W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString;
    if edtRecapito2.Enabled then
      edtRecapito2.Text:=W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString;
    if edtRecapito3.Enabled then
      edtRecapito3.Text:=W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString;
  end;
end;

procedure TW004FReperibilita.SvuotaGestMensileDatiAgg;
begin
  cmbDatoAgg1T1.Text:='';
  cmbDatoAgg1T2.Text:='';
  cmbDatoAgg1T3.Text:='';
  cmbDatoAgg2T1.Text:='';
  cmbDatoAgg2T2.Text:='';
  cmbDatoAgg2T3.Text:='';
  cmbAreaSquadraT1.Text:='';
  cmbAreaSquadraT2.Text:='';
  cmbAreaSquadraT3.Text:='';
  edtRecapito1.Text:='';
  edtRecapito2.Text:='';
  edtRecapito3.Text:='';
end;

procedure TW004FReperibilita.AbilitaGestMensileDatoAgg1;
var bT1:Boolean;
begin
  bT1:=cmbTurno1.Text <> '';
  cmbDatoAgg1T1.Enabled:=bT1 and (lblDatoAgg1.Caption <> '');
  cmbDatoAgg2T1.Enabled:=bT1 and (lblDatoAgg2.Caption <> '');
  if cmbDatoAgg1T1.Enabled then
  begin
    if AssegnaDatoAggAna then
      cmbDatoAgg1T1.Text:=DatoAgg1Ana;
  end
  else
    cmbDatoAgg1T1.Text:='';
  if cmbDatoAgg2T1.Enabled then
  begin
    if AssegnaDatoAggAna then
      cmbDatoAgg2T1.Text:=DatoAgg2Ana;
  end
  else
    cmbDatoAgg2T1.Text:='';

  cmbAreaSquadraT1.Enabled:=bT1 and (lblAreeTurni.Caption <> '');
  cmbAreaSquadraT1.Text:='';
end;

procedure TW004FReperibilita.AbilitaGestMensileDatoAgg2;
var bT2:Boolean;
begin
  bT2:=cmbTurno2.Text <> '';
  cmbDatoAgg1T2.Enabled:=bT2 and (lblDatoAgg1.Caption <> '');
  cmbDatoAgg2T2.Enabled:=bT2 and (lblDatoAgg2.Caption <> '');
  if cmbDatoAgg1T2.Enabled then
  begin
    if AssegnaDatoAggAna then
      cmbDatoAgg1T2.Text:=DatoAgg1Ana;
  end
  else
    cmbDatoAgg1T2.Text:='';
  if cmbDatoAgg2T2.Enabled then
  begin
    if AssegnaDatoAggAna then
      cmbDatoAgg2T2.Text:=DatoAgg2Ana;
  end
  else
    cmbDatoAgg2T2.Text:='';

  cmbAreaSquadraT2.Enabled:=bT2 and (lblAreeTurni.Caption <> '');
  cmbAreaSquadraT2.Text:='';
end;

procedure TW004FReperibilita.AbilitaGestMensileDatoAgg3;
var bT3:Boolean;
begin
  bT3:=cmbTurno3.Text <> '';
  cmbDatoAgg1T3.Enabled:=bT3 and (lblDatoAgg1.Caption <> '');
  cmbDatoAgg2T3.Enabled:=bT3 and (lblDatoAgg2.Caption <> '');
  if cmbDatoAgg1T3.Enabled then
  begin
    if AssegnaDatoAggAna then
      cmbDatoAgg1T3.Text:=DatoAgg1Ana;
  end
  else
    cmbDatoAgg1T3.Text:='';
  if cmbDatoAgg2T3.Enabled then
  begin
    if AssegnaDatoAggAna then
      cmbDatoAgg2T3.Text:=DatoAgg2Ana;
  end
  else
    cmbDatoAgg2T3.Text:='';

  cmbAreaSquadraT3.Enabled:=bT3 and (lblAreeTurni.Caption <> '');
  cmbAreaSquadraT3.Text:='';
end;

procedure TW004FReperibilita.CaricaTurniTabellone;
begin
  FiltroDip:=selAnagrafe.SubstitutedSql;
  CaricaListaTabellone;
  VisualizzaGrigliaTabellone;
end;

procedure TW004FReperibilita.CaricaListaTabellone;
var
  i,n,LenTurno,I1,F1:Integer;
  Data:TDateTime;
  OrarioXStampa:string;
  OraInizio, OraFine:integer;

  function CheckDatoBloccato(Progressivo:Integer; Data:TDateTime):Boolean;
  begin
    Result:=False;
    with W004DM.selT180 do
    begin
      if SearchRecord('PROGRESSIVO',Progressivo,[srFromBeginning]) then
      repeat
        if R180Between(Data,FieldByName('DAL').AsDateTime,FieldByName('AL').AsDateTime) then
        begin
          Result:=True;
          Break;
        end;
      until not SearchRecord('PROGRESSIVO',Progressivo,[]);
    end;
  end;

begin
  with W004DM do
  begin
    (*
    selT011.Close;
    selT040.Close;
    selT100.Close;
    selT180.Close;
    *)
    if Pos(':DATALAVORO',UpperCase(FiltroDip)) > 0 then
    begin
      if selT040.VariableIndex('DATALAVORO') = -1 then
      begin
        selT011.DeclareVariable('DATALAVORO',otDate);
        selT040.DeclareVariable('DATALAVORO',otDate);
        selT100.DeclareVariable('DATALAVORO',otDate);
        selT180.DeclareVariable('DATALAVORO',otDate);
      end;
      selT011.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT040.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT100.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT180.SetVariable('DATALAVORO',Parametri.DataLavoro);
    end
    else if selT040.VariableIndex('DATALAVORO') > -1 then
    begin
      selT011.DeleteVariable('DATALAVORO');
      selT040.DeleteVariable('DATALAVORO');
      selT100.DeleteVariable('DATALAVORO');
      selT180.DeleteVariable('DATALAVORO');
    end;
    R180SetVariable(selT011,'FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    R180SetVariable(selT011,'DAL',Dal);
    R180SetVariable(selT011,'AL',Al);
    selT011.Open;
    selT011.First;
    R180SetVariable(selT040,'FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    R180SetVariable(selT040,'DAL',Dal);
    R180SetVariable(selT040,'AL',Al);
    R180SetVariable(selT040,'PRESENZE',Parametri.CampiRiferimento.C90_W010CausPres);
    selT040.Open;
    selT040.First;
    R180SetVariable(selT100,'FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    R180SetVariable(selT100,'DAL',Dal);
    R180SetVariable(selT100,'AL',Al);
    selT100.Open;
    selT100.First;
    R180SetVariable(selT180,'FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    R180SetVariable(selT180,'DAL',R180InizioMese(Dal));
    R180SetVariable(selT180,'AL',R180FineMese(Al));
    selT180.Open;
    selT180.First;

    cdsLista.Close;
    cdsLista.FieldDefs.Clear;
    cdsLista.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsLista.FieldDefs.Add('COGNOME',ftString,50,False);
    cdsLista.FieldDefs.Add('NOME',ftString,50,False);
    cdsLista.FieldDefs.Add('NOMINATIVO',ftString,200,False);
    cdsLista.FieldDefs.Add('DATO_RAGGR',ftString,200,False);
    cdsLista.FieldDefs.Add('ORDINE',ftInteger,0,False);
    cdsLista.FieldDefs.Add('TOT_TURNI',ftInteger,0,False);
    cdsLista.FieldDefs.Add('TOT_ORE',ftString,10,False);
    for i:=0 to Trunc(Al - Dal) do
      cdsLista.FieldDefs.Add(FormatDateTime('yyyymmdd',Dal + i),ftString,37,False);
    cdsLista.CreateDataSet;
    cdsLista.LogChanges:=False;
    cdsLista.IndexDefs.Clear;
    cdsLista.IndexDefs.Add('Ricerca',('DATO_RAGGR;ORDINE;COGNOME;NOME;PROGRESSIVO'),[]);
    cdsLista.IndexName:='Ricerca';

    cdsListaTimb.Close;
    cdsListaTimb.FieldDefs.Clear;
    cdsListaTimb.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsListaTimb.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaTimb.FieldDefs.Add('LAVORATIVO',ftString,1,False);
    cdsListaTimb.FieldDefs.Add('MODIFICABILE',ftString,1,False);
    cdsListaTimb.FieldDefs.Add('TIMBRATURE',ftString,1,False);
    cdsListaTimb.FieldDefs.Add('GIUSTIF_GG',ftString,1,False);
    cdsListaTimb.CreateDataSet;
    cdsListaTimb.LogChanges:=False;

    cdsListaTurni.Close;
    cdsListaTurni.FieldDefs.Clear;
    cdsListaTurni.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsListaTurni.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaTurni.FieldDefs.Add('NUMERO',ftInteger,0,False);
    cdsListaTurni.FieldDefs.Add('TURNO',ftString,5,False);
    cdsListaTurni.FieldDefs.Add('PRIORITA',ftString,1,False);
    cdsListaTurni.CreateDataSet;
    cdsListaTurni.LogChanges:=False;

    cdsListaGG.Close;
    cdsListaGG.FieldDefs.Clear;
    cdsListaGG.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaGG.FieldDefs.Add('TOT_TURNI',ftInteger,0,False);
    cdsListaGG.FieldDefs.Add('TOT_ORE',ftString,10,False);
    cdsListaGG.CreateDataSet;
    cdsListaGG.LogChanges:=False;

    for i:=0 to Trunc(Al - Dal) do
    begin
      cdsListaGG.Append;
      cdsListaGG.FieldByName('DATA').AsDateTime:=Dal + i;
      cdsListaGG.FieldByName('TOT_TURNI').AsInteger:=0;
      cdsListaGG.FieldByName('TOT_ORE').AsString:=R180MinutiOre(0);
      cdsListaGG.Post;
    end;

    MaxLenTurno:=0;
    selAnagrafe.First;
    while not selAnagrafe.Eof do
    begin
      cdsLista.Append;
      cdsLista.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
      cdsLista.FieldByName('COGNOME').AsString:=selAnagrafe.FieldByName('COGNOME').AsString;
      cdsLista.FieldByName('NOME').AsString:=selAnagrafe.FieldByName('NOME').AsString;
      cdsLista.FieldByName('NOMINATIVO').AsString:=cdsLista.FieldByName('COGNOME').AsString + ' ' + cdsLista.FieldByName('NOME').AsString;
      cdsLista.FieldByName('ORDINE').AsInteger:=9999;
      cdsLista.FieldByName('TOT_TURNI').AsInteger:=0;
      cdsLista.FieldByName('TOT_ORE').AsString:=R180MinutiOre(0);
      cdsLista.Post;
      for i:=0 to Trunc(Al - Dal) do
      begin
        Data:=Dal + i;
        cdsListaTimb.Append;
        cdsListaTimb.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        cdsListaTimb.FieldByName('DATA').AsDateTime:=Data;
        (*
        T010F_GGLAVORATIVO.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        T010F_GGLAVORATIVO.SetVariable('DATA',Data);
        T010F_GGLAVORATIVO.Execute;
        cdsListaTimb.FieldByName('LAVORATIVO').AsString:=VarToStr(T010F_GGLAVORATIVO.GetVariable('LAVORATIVO'));
        *)
        cdsListaTimb.FieldByName('LAVORATIVO').AsString:=VarToStr(selT011.Lookup('PROGRESSIVO;DATA',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data]),'LAVORATIVO'));
        (*
        WR000DM.selDatiBloccati.Close;
        cdsListaTimb.FieldByName('MODIFICABILE').AsString:=IfThen(SolaLettura or WR000DM.selDatiBloccati.DatoBloccato(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(Data),'T380'),'N','S');
        *)
        cdsListaTimb.FieldByName('MODIFICABILE').AsString:=IfThen(SolaLettura or CheckDatoBloccato(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(Data)),'N','S');
        //Presenza timbrature
        cdsListaTimb.FieldByName('TIMBRATURE').AsString:=IfThen(StrToIntDef(VarToStr(selT100.Lookup('PROGRESSIVO;DATA',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data]),'N_TIMB_REP')),0) > 0,'R',
                                                         IfThen(StrToIntDef(VarToStr(selT100.Lookup('PROGRESSIVO;DATA',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data]),'N_TIMB')),0) > 0,'S','N'));
        //Giustificativo a giornata intera
        cdsListaTimb.FieldByName('GIUSTIF_GG').AsString:=IfThen(VarToStr(selT040.Lookup('PROGRESSIVO;DATA;TIPOGIUST',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data,'I']),'TIPOGIUST')) = 'I','S','N');
        cdsListaTimb.Post;
        //Cerco i turni del dipendente
        selT380.Filter:='(PROGRESSIVO = ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString + ') AND (DATA = ' + FloatToStr(Data) + ')';
        selT380.Filtered:=True;
        selT380.First;
        if selT380.RecordCount = 0 then
        begin
          if cdsListaTimb.FieldByName('MODIFICABILE').AsString = 'S' then
          begin
            cdsListaTurni.Append;
            cdsListaTurni.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
            cdsListaTurni.FieldByName('DATA').AsDateTime:=Data;
            cdsListaTurni.FieldByName('NUMERO').AsInteger:=1;
            cdsListaTurni.FieldByName('TURNO').AsString:='_';
            cdsListaTurni.FieldByName('PRIORITA').AsString:='';
            cdsListaTurni.Post;
          end;
        end
        else
          while not selT380.Eof do
          begin
            for n:=1 to rgpNumTurni.ItemIndex + 1 do
            begin
              cdsListaTurni.Append;
              cdsListaTurni.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaTurni.FieldByName('DATA').AsDateTime:=Data;
              cdsListaTurni.FieldByName('NUMERO').AsInteger:=n;
              cdsListaTurni.FieldByName('TURNO').AsString:=selT380.FieldByName('TURNO' + IntToStr(n)).AsString;
              cdsListaTurni.FieldByName('PRIORITA').AsString:=IfThen(Tipologia = 'R',selT380.FieldByName('PRIORITA' + IntToStr(n)).AsString);
              cdsListaTurni.Post;
              LenTurno:=Length(cdsListaTurni.FieldByName('TURNO').AsString + cdsListaTurni.FieldByName('PRIORITA').AsString);
              MaxLenTurno:=Max(MaxLenTurno,LenTurno);
              if Trim(cdsListaTurni.FieldByName('TURNO').AsString) <> '' then
              begin
                cdsLista.Locate('PROGRESSIVO',cdsListaTurni.FieldByName('PROGRESSIVO').AsInteger,[]);//Mi riposiziono per sicurezza a causa dell'indice
                cdsLista.Edit;
                cdsLista.FieldByName('TOT_TURNI').AsInteger:=cdsLista.FieldByName('TOT_TURNI').AsInteger + 1;
                I1:=WR000DM.selT350.Lookup('CODICE',cdsListaTurni.FieldByName('TURNO').AsString,'INIZIO');
                F1:=WR000DM.selT350.Lookup('CODICE',cdsListaTurni.FieldByName('TURNO').AsString,'FINE');
                if F1 <= I1 then
                  inc(F1,1440);
                cdsLista.FieldByName('TOT_ORE').AsString:=R180MinutiOre(R180OreMinuti(cdsLista.FieldByName('TOT_ORE').AsString) + F1 - I1);
                //Carico l'elenco dei turni con le priorità. Serve solo per l'esportazione in excel, invece per la griglia viene gestito tutto nel RawText della cella o del link
                if rgpVisTurnoOrario.Items[rgpVisTurnoOrario.ItemIndex] = 'Turno' then
                begin
                  cdsLista.FieldByName(FormatDateTime('yyyymmdd',Data)).AsString:=Trim(cdsLista.FieldByName(FormatDateTime('yyyymmdd',Data)).AsString + CRLF + cdsListaTurni.FieldByName('TURNO').AsString + ' ' + cdsListaTurni.FieldByName('PRIORITA').AsString);
                end
                else if rgpVisTurnoOrario.Items[rgpVisTurnoOrario.ItemIndex] = 'Orario' then
                begin
                  //Construzione stringa di output per esportazione in excel nel caso della visualizzazione dell'output
                  OraInizio:=VarToInt(WR000DM.selT350.Lookup('CODICE',cdsListaTurni.FieldByName('TURNO').AsString,'INIZIO'));
                  OraFine:=VarToInt(WR000DM.selT350.Lookup('CODICE',cdsListaTurni.FieldByName('TURNO').AsString,'FINE'));
                  OrarioXStampa:=Format('%s-%s',[R180MinutiOre(StrToIntDef(VarToStr(OraInizio),0)), R180MinutiOre(StrToIntDef(VarToStr(OraFine),0))]);
                  cdsLista.FieldByName(FormatDateTime('yyyymmdd',Data)).AsString:=Trim(cdsLista.FieldByName(FormatDateTime('yyyymmdd',Data)).AsString + CRLF + OrarioXStampa);
                end;
                cdsLista.Post;
                //Aggiorno i totali giornalieri
                cdsListaGG.Locate('DATA',Data,[]);
                cdsListaGG.Edit;
                cdsListaGG.FieldByName('TOT_TURNI').AsInteger:=cdsListaGG.FieldByName('TOT_TURNI').AsInteger + 1;
                cdsListaGG.FieldByName('TOT_ORE').AsString:=R180MinutiOre(R180OreMinuti(cdsListaGG.FieldByName('TOT_ORE').AsString) + F1 - I1);
                cdsListaGG.Post;
              end;
            end;
            selT380.Next;
          end;
        selT380.Filtered:=False;
      end;
      selAnagrafe.Next;
    end;
    if not selAnagrafe.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]) then
      selAnagrafe.First;
  end;
end;

procedure TW004FReperibilita.VisualizzaGrigliaTabellone;
var i:Integer;
    Data:TDateTime;
begin
  grdProspetto.Summary:=grdProspetto.Caption;
  with W004DM do
  begin
    if cdsLista.RecordCount > 0 then
    begin
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
      grdProspetto.medpRighePagina:=GetRighePaginaTabella;
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
    end;
    grdProspetto.medpCreaCDS;
    grdProspetto.medpEliminaColonne;
    for i:=0 to cdsLista.FieldDefs.Count - 1 do
      if not R180In(cdsLista.FieldDefs[i].Name,['DATO_RAGGR','ORDINE','COGNOME','NOME']) then
      begin
        if cdsLista.FieldDefs[i].Name = 'PROGRESSIVO' then
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Progressivo','',nil)
        else if cdsLista.FieldDefs[i].Name = 'NOMINATIVO' then
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Nominativo','',nil)
        else if cdsLista.FieldDefs[i].Name = 'TOT_TURNI' then
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Tot. turni','',nil)
        else if cdsLista.FieldDefs[i].Name = 'TOT_ORE' then
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Tot. ore','',nil)
        else
        begin
          Data:=EncodeDate(StrToInt(Copy(cdsLista.FieldDefs[i].Name,1,4)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,5,2)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,7,2)));
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,FormatDateTime('dd/mm/yyyy',Data),'',nil);
        end;
      end;
  end;
  grdProspetto.medpColonna('PROGRESSIVO').Visible:=False;
  grdProspetto.medpInizializzaCompGriglia;
  grdProspetto.medpCaricaCDS;
end;

procedure TW004FReperibilita.chkNonContDipPianClick(Sender: TObject);
begin
  inherited;
  chkSoloSelAnagrafe.Checked:=chkSoloSelAnagrafe.Checked and Not chkNonContDipPian.Checked;
  chkSoloSelAnagrafe.Enabled:=Not chkNonContDipPian.Checked;
end;

procedure TW004FReperibilita.cmbDipendentiDisponibiliChange(Sender: TObject);
var
  DatiStorici:String;
begin
  inherited;
  edtDipMatricola.Text:=cmbDipendentiDisponibili.Items[cmbDipendentiDisponibili.ItemIndex].Substring(0,8).Trim;
  CaricaClbGiorni(Dal);

  DatiStorici:='T430SQUADRA, T430TIPOOPE';
  DatiStorici:=DatiStorici + IfThen(DatoLiberoAgg1 <> '',',' + DatoLiberoAgg1) + IfThen(DatoLiberoAgg2 <> '',',' + DatoLiberoAgg2) + IfThen(DatoRecapito <> '',',' + DatoRecapito);
  W004DM.QSDatiAgg.GetDatiStorici(DatiStorici,GetProgressivo,EncodeDate(1900,1,1),EncodeDate(3999,12,31));

  if (W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) and
      (DatoLiberoAgg1 <> '')) then
    DatoIns1Ana:=W004DM.QSDatiAgg.FieldByName(DatoLiberoAgg1).AsString;
  if (W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) and
      (DatoLiberoAgg2 <> '')) then
    DatoIns2Ana:=W004DM.QSDatiAgg.FieldByName(DatoLiberoAgg2).AsString;

  if (tabReperibilita.ActiveTab = W004GestioneMensileRG) and (DatoLiberoAgg1 <> '') then
  begin
    AssegnaDatoAggAna:=True;
    SvuotaGestMensileDatiAgg;
    IniGestMensileDatiAgg;
  end;
end;

procedure TW004FReperibilita.cmbDipendenteDettaglioChange(Sender: TObject; Index: Integer);
var
  DatiStorici, Matr: String;
  c,tProgr: Integer;
begin
  inherited;
  c:=grdReperibilita.medpIndexColonna('MATRICOLA');
  Matr:=TMedpIWMultiColumnComboBox(grdReperibilita.medpCompCella(0,c,0)).Text;

  tProgr:=-1;
  if selAnagrafe <> nil then
  begin
    try
      if selAnagrafe.Active and (selAnagrafe.RecordCount > 0) then
        tProgr:=selAnagrafe.Lookup('MATRICOLA',Matr,'PROGRESSIVO');
    except
    end;
  end;
  DatiStorici:='T430SQUADRA, T430TIPOOPE';
  DatiStorici:=DatiStorici + IfThen(DatoLiberoAgg1 <> '',',' + DatoLiberoAgg1) + IfThen(DatoLiberoAgg2 <> '',',' + DatoLiberoAgg2) + IfThen(DatoRecapito <> '',',' + DatoRecapito);
  W004DM.QSDatiAgg.GetDatiStorici(DatiStorici,tProgr,EncodeDate(1900,1,1),EncodeDate(3999,12,31));

  if (W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) and
      (DatoLiberoAgg1 <> '')) then
    DatoIns1Ana:=W004DM.QSDatiAgg.FieldByName(DatoLiberoAgg1).AsString;
  if (W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) and
      (DatoLiberoAgg2 <> '')) then
    DatoIns2Ana:=W004DM.QSDatiAgg.FieldByName(DatoLiberoAgg2).AsString;
end;

procedure TW004FReperibilita.cmbTurno1Change(Sender: TObject; Index: Integer);
begin
  inherited;
  edtPriorita1.Enabled:=edtPriorita1.Visible and (cmbTurno1.Text <> '');
  if not edtPriorita1.Enabled then
    edtPriorita1.Text:='';
  edtRecapito1.Enabled:=edtRecapito1.Visible and (cmbTurno1.Text <> '');
  if (not edtRecapito1.Enabled) or (DatoRecapito = '') then
    edtRecapito1.Text:=''
  else
    edtRecapito1.Text:=W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString;

  if DatoLiberoAgg1 <> '' then
  begin
    AssegnaDatoAggAna:=True;
    AbilitaGestMensileDatoAgg1;
    AssegnaDatoAggAna:=False;
  end;
end;

procedure TW004FReperibilita.cmbTurno2Change(Sender: TObject; Index: Integer);
begin
  inherited;
  edtPriorita2.Enabled:=edtPriorita2.Visible and (cmbTurno2.Text <> '');
  if not edtPriorita2.Enabled then
    edtPriorita2.Text:='';
  edtRecapito2.Enabled:=edtRecapito2.Visible and (cmbTurno2.Text <> '');
  if not edtRecapito2.Enabled then
    edtRecapito2.Text:='';
  if DatoLiberoAgg1 <> '' then
  begin
    AssegnaDatoAggAna:=True;
    AbilitaGestMensileDatoAgg2;
    AssegnaDatoAggAna:=False;
  end;
end;

procedure TW004FReperibilita.cmbTurno3Change(Sender: TObject; Index: Integer);
begin
  inherited;
  edtPriorita3.Enabled:=edtPriorita3.Visible and (cmbTurno3.Text <> '');
  if not edtPriorita3.Enabled then
    edtPriorita3.Text:='';
  edtRecapito3.Enabled:=edtRecapito3.Visible and (cmbTurno3.Text <> '');
  if not edtRecapito3.Enabled then
    edtRecapito3.Text:='';
  if DatoLiberoAgg1 <> '' then
  begin
    AssegnaDatoAggAna:=True;
    AbilitaGestMensileDatoAgg3;
    AssegnaDatoAggAna:=False;
  end;
end;

procedure TW004FReperibilita.cmbTurnoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with (Sender as TMedpIWMultiColumnComboBox) do
  begin
    Hint:=Items[Index].RowData[1];
  end;
end;

procedure TW004FReperibilita.TrasformaComponenti(const FN: String);
// Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdReperibilita
var
  DaTestoAControlli:Boolean;
  i,j,c:Integer;
begin
  with grdReperibilita do
  begin
    i:=medpRigaDiCompGriglia(FN);
    c:=medpIndexColonna('C_TURNO1');
    DaTestoAControlli:=medpCompGriglia[i].CompColonne[c] = nil;

    with (medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
      Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
    end;

    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    // modifica dati
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
    begin
      with (medpCompGriglia[i].CompColonne[ColSchedaAnag] as TmeIWGrid) do
      begin
        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
          Cell[0,0].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      end;
    end;
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine

    // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini 
    // Tasto modifica recapiti alternativi. Devo essere in gestione turni di reperibilità per poterlo mostrare.
    (medpCompGriglia[i].CompColonne[ColSchedaAnag] as TmeIWGrid).Cell[0,1].Css:=IfThen(DaTestoAControlli and (Tipologia = 'R'),StileCella1,'invisibile');
    // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine

    if DaTestoAControlli then
    begin
      // data
      c:=medpIndexColonna('DATA');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      (medpCompCella(i,c,0) as TmeIWEdit).Text:=medpValoreColonna(i,'DATA');
      // turno 1
      c:=medpIndexColonna('C_TURNO1');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:=medpValoreColonna(i,'TURNO1');
        //OnAsyncChange:=cmbTurnoAsyncChange;
      end;
      // priorità chiamata turno 1
      c:=medpIndexColonna('PRIORITA1');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'PRIORITA1');
        MaxLength:=1;
      end;
      // turno 2
      c:=medpIndexColonna('C_TURNO2');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:=medpValoreColonna(i,'TURNO2');
      end;
      // priorità chiamata turno 2
      c:=medpIndexColonna('PRIORITA2');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'PRIORITA2');
        MaxLength:=1;
      end;
      // turno 3
      c:=medpIndexColonna('C_TURNO3');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:=medpValoreColonna(i,'TURNO3');
      end;
      // priorità chiamata turno 3
      c:=medpIndexColonna('PRIORITA3');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'PRIORITA3');
        MaxLength:=1;
      end;
      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      begin
        // dato libero
        c:=medpIndexColonna('DATOLIBERO');
        medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'20','','','','S');
        medpCreaComponenteGenerico(i,c,Componenti);
        with (medpCompCella(i,c,0) as TmeIWComboBox) do
        begin
          ItemsHaveValues:=True;
          Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
          Items.Assign(lstDatoLibero);
          ItemIndex:=R180IndexOf(Items,medpValoreColonna(i,'DATOLIBERO'),DatoLiberoCodLen);
        end;
      end;
    end
    else
    begin
      // data
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DATA')]);
      // turno 1
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_TURNO1')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('PRIORITA1')]);
      // turno 2
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_TURNO2')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('PRIORITA2')]);
      // turno 3
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_TURNO3')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('PRIORITA3')]);
      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
        FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DATOLIBERO')]);
    end;
    medpBrowse:=not DaTestoAControlli;
  end;
end;

procedure TW004FReperibilita.actCancellazioneOK(FN:String);
begin
  // cancellazione record
  with W004DM.selT380 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      // controllo dato bloccato
      WR000DM.selDatiBloccati.Close;
      if WR000DM.selDatiBloccati.DatoBloccato(FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(FieldByName('DATA').AsDateTime),'T380') then
      begin
        MsgBox.MessageBox('Cancellazione non consentita: ' + WR000DM.selDatiBloccati.MessaggioLog,ESCLAMA);
        Exit;
      end;

      RegistraLog.SettaProprieta('C','T380_PIANIFREPERIB',medpCodiceForm,W004DM.selT380,True);
      Delete;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    end;
  end;
  //GetTurniPianificati;
  if (grdModifica <> grdReperibilita) and (W004FModTabFM <> nil) then
    W004FModTabFM.AfterCancellazione
  else
    GetTurniPianificati;
end;

function TW004FReperibilita.GetInfoDip(Row:Integer): String;
var
  i, ProgCorr: Integer;
  Dato, DatoT430, DatoFmt: String;
  IsProgModif, IsDatoModificabile,MostraRecapito2,MostraRecapito3: Boolean;
begin
  // Reperisco Squadra e tipo operatore da anagrafico
  Squadra1Ana:='';
  Operatore1Ana:='';
  if W004DM.QSDatiAgg.LocDatoStorico(R180InizioMese(Dal)) then
  begin
    Squadra1Ana:=W004DM.QSDatiAgg.FieldByName('T430SQUADRA').AsString;
    Operatore1Ana:=W004DM.QSDatiAgg.FieldByName('T430TIPOOPE').AsString;
  end;

  // compone l'informazione da visualizzare
  Result:='<table><tbody>';

  // gestione dati parametrizzati
  if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
  begin
    // salva il progressivo della riga corrente
    ProgCorr:=grdReperibilita.medpClientDataSet.FieldByName('PROGRESSIVO').AsInteger;
    IsProgModif:=(DatiAnag.Modificato) and (DatiAnag.Progressivo = ProgCorr);

    // dati da visualizzare
    for i:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
    begin
      Dato:=W002ModDatiDM.LstDatiVis[i];
      DatoT430:=Format('T430%s',[Dato]);
      DatoFmt:=R180Capitalize(Dato);

      if WR000DM.cdsI010.Locate('NOME_CAMPO',DatoT430,[]) then
      begin
        // dato ok: se l'accesso è S/R lo visualizza
        if WR000DM.cdsI010.FieldByName('ACCESSO').AsString <> 'N' then
        begin
          // se il dato è nella lista dei modificabili e
          // l'accesso è S indica che il dato è modificabile
          IsDatoModificabile:=(W002ModDatiDM.LstDatiModif.IndexOf(Dato) > -1) and
                              (WR000DM.cdsI010.FieldByName('ACCESSO').AsString = 'S');
          if IsDatoModificabile then
          begin
            DatoFmt:=Format('<abbr title="Dato modificabile">%s</abbr>',[DatoFmt]);
          end;

          // se il dipendente è quello in modifica e il dato corrente è modificabile
          // legge il valore dal clientdataset
          // altrimenti visualizza il valore del dataset
          if IsProgModif and IsDatoModificabile then
          begin
            if W002ModDatiDM.cdsDatiAnag.Locate('DATO',Dato,[loCaseInsensitive]) then
              Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[DatoFmt,W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString]);
          end
          else
          begin
            if Assigned(W004DM.selT380.FindField(DatoT430)) then
              Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[DatoFmt,grdReperibilita.medpClientDataSet.FieldByName(DatoT430).AsString]);
          end;
        end;
      end;
    end;
  end;

  // dato libero 1
  if DatoLibero1 <> '' then
  begin
    Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr> ',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1),
                             W004DM.selT380.FieldByName(DatoLibero1).AsString]);
  end;

  // dato libero 2
  if DatoLibero2 <> '' then
  begin
    Result:=Result + Format('<tr><td>%s:</td> <td>%s</td></tr> ',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2),
                            W004DM.selT380.FieldByName(DatoLibero2).AsString]);
  end;

  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
  { Recapiti alternativi dei turni
    Se non sono in modifica, i turni aggiornati sono sempre quelli sul client dataset.
    In modifica invece: per le righe non in modifica il client dataset è sempre la fonte, per
    la riga in modifica invece devono basarmi sul valore della select.
    Queste info vanno aggiunte solo nella gestione dei turni di reperibilità.  }
  MostraRecapito2:=False;
  MostraRecapito3:=False;
  if Tipologia = 'R' then
  begin
    if Operazione <> 'M' then
    begin
      // Visualizzazione / Inserimento
      MostraRecapito2:=cdsT380.FieldByName('TURNO2').AsString <> '';
      MostraRecapito3:=cdsT380.FieldByName('TURNO3').AsString <> '';
    end
    else
    begin
      // Modifica, il CDS contiene i dati modificati per i recapiti. I turni li prendo dai controlli
      if (grdReperibilita.medpCompCella(Row,'C_TURNO2',0) <> nil) then
      begin
        // Sono sulla riga in modifica
        MostraRecapito2:=(grdReperibilita.medpCompCella(Row,'C_TURNO2',0) as TMedpIWMultiColumnComboBox).Text <> '';
        MostraRecapito3:=(grdReperibilita.medpCompCella(Row,'C_TURNO3',0) as TMedpIWMultiColumnComboBox).Text <> '';
      end
      else
      begin
        MostraRecapito2:=cdsT380.FieldByName('TURNO2').AsString <> '';
        MostraRecapito3:=cdsT380.FieldByName('TURNO3').AsString <> '';
      end;
    end;

    Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',['Recapito alternativo turno 1',cdsT380.FieldByName('RECAPITO1').AsString]);
    if MostraRecapito2 then
      Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',['Recapito alternativo turno 2',cdsT380.FieldByName('RECAPITO2').AsString]);
    if MostraRecapito3 then
      Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',['Recapito alternativo turno 3',cdsT380.FieldByName('RECAPITO3').AsString]);
  end;
  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine

  if Tipologia = 'R' then
  begin
    // dato libero aggiuntivo 1
    if DatoLiberoAgg1 <> '' then
    begin
      if Trim(cdsT380.FieldByName('DATOAGG1_T1').AsString) <> '' then
        Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1) + ' turno 1',cdsT380.FieldByName('DATOAGG1_T1').AsString]);
      if MostraRecapito2 and (Trim(cdsT380.FieldByName('DATOAGG1_T2').AsString) <> '') then
        Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1) + ' turno 2',cdsT380.FieldByName('DATOAGG1_T2').AsString]);
      if MostraRecapito3 and (Trim(cdsT380.FieldByName('DATOAGG1_T3').AsString) <> '') then
        Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1) + ' turno 3',cdsT380.FieldByName('DATOAGG1_T3').AsString]);
    end;

    // dato libero aggiuntivo 2
    if DatoLiberoAgg2 <> '' then
    begin
      if Trim(cdsT380.FieldByName('DATOAGG2_T1').AsString) <> '' then
        Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2) + ' turno 1',cdsT380.FieldByName('DATOAGG2_T1').AsString]);
      if MostraRecapito2 and (Trim(cdsT380.FieldByName('DATOAGG2_T2').AsString) <> '') then
        Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2) + ' turno 2',cdsT380.FieldByName('DATOAGG2_T2').AsString]);
      if MostraRecapito3 and (Trim(cdsT380.FieldByName('DATOAGG2_T3').AsString) <> '') then
        Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2) + ' turno 3',cdsT380.FieldByName('DATOAGG2_T3').AsString]);
    end;

    // area turni squadra
    if W004DM.selT651.RecordCount > 0 then
    begin
      if Trim(cdsT380.FieldByName('AREASQUADRA_T1').AsString) <> '' then
        Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',['Area afferenza turno 1',cdsT380.FieldByName('AREASQUADRA_T1').AsString]);
      if MostraRecapito2 and (Trim(cdsT380.FieldByName('AREASQUADRA_T2').AsString) <> '') then
        Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',['Area afferenza turno 2',cdsT380.FieldByName('AREASQUADRA_T2').AsString]);
      if MostraRecapito3 and (Trim(cdsT380.FieldByName('AREASQUADRA_T3').AsString) <> '') then
        Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',['Area afferenza turno 3',cdsT380.FieldByName('AREASQUADRA_T3').AsString]);
    end;
  end;

  Result:=Result + '</tbody></table>';
end;

procedure TW004FReperibilita.PreparaDatiAnag;
var
  i: Integer;
  DatoT430: String;
begin
  // imposta il clientdataset con i valori attuali dei campi da modificare
  for i:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
  begin
    DatoT430:=Format('T430%s',[W002ModDatiDM.LstDatiVis[i]]);
    if W002ModDatiDM.cdsDatiAnag.Locate('CAMPO',DatoT430,[]) then
    begin
      W002ModDatiDM.cdsDatiAnag.Edit;
      W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString:=W004DM.selT380.FieldByName(DatoT430).AsString;
      W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE_OLD').AsString:=W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString;
      W002ModDatiDM.cdsDatiAnag.Post;
    end;
  end;
end;

procedure TW004FReperibilita.grdProspettoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i,j,Prog:Integer;
    Data:TDateTime;
begin
  inherited;
  //Gestione dei link
  for i:=0 to High(grdProspetto.medpCompGriglia) do
    for j:=0 to High(grdProspetto.medpCompGriglia[i].CompColonne) do
      if j >= NCOLONNEBLOCCATE then
        with W004DM do
        begin
          Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(j).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,7,2)));
          Prog:=StrToInt(grdProspetto.medpValoreColonna(i,'PROGRESSIVO'));
          cdsListaTimb.Locate('PROGRESSIVO;DATA',VarArrayOf([Prog,Data]),[]);
          cdsListaTurni.Locate('PROGRESSIVO;DATA',VarArrayOf([Prog,Data]),[]);
          //Link per TURNO modificabile, altrimenti TURNO nel testo della cella
          if cdsListaTimb.FieldByName('MODIFICABILE').AsString = 'S' then
          begin
            grdProspetto.medpPreparaComponenteGenerico('C',0,0,DBG_LNK,'','','','','S');
            grdProspetto.medpCreaComponenteGenerico(i,j,grdProspetto.Componenti);
            with (grdProspetto.medpCompCella(i,j,0) as TmeIWLink) do
            begin
              OnClick:=lnkTurnoClick;
              FriendlyName:=DateToStr(Data) + ';' + IntToStr(Prog);
              Tag:=Trunc(Data);
            end;
          end;
        end;
end;

procedure TW004FReperibilita.lnkTurnoClick(Sender: TObject);
var FN:String;
begin
  W004FModTabFM:=TW004FModificaTabelloneFM.Create(Self);
  FreeNotification(W004FModTabFM);
  with W004FModTabFM do
  begin
    W004DM_Mod:=W004DM;
    FN:=(Sender as TmeIWLink).FriendlyName;
    Data:=StrToDate(Copy(FN,1,Pos(';',FN) - 1));
    Prog:=StrToInt(Copy(FN,Pos(';',FN) + 1));
    Tipo:=Tipologia;
    R180SetVariable(W004DM.QSDatiAgg,'PROGRESSIVO',Prog);
    if DatoRecapito <> '' then
    begin
      W004DM.QSDatiAgg.Open;
      CaricaGriglia(W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString)
    end
    else
      CaricaGriglia('');
  end;
end;

procedure TW004FReperibilita.mnuEsportaClick(Sender: TObject);
var i,TotTurni:Integer;
    TotOre:String;
begin
  with W004DM do
  begin
    //Totale turni
    cdsLista.Append;
    cdsLista.FieldByName('ORDINE').AsInteger:=10000;
    cdsLista.FieldByName('NOMINATIVO').AsString:='Tot. turni';
    TotTurni:=0;
    for i:=0 to Trunc(Al - Dal) do
    begin
      cdsListaGG.Locate('DATA',Dal + i,[]);
      TotTurni:=TotTurni + cdsListaGG.FieldByName('TOT_TURNI').AsInteger;
      cdsLista.FieldByName(FormatDateTime('yyyymmdd',Dal + i)).AsString:=cdsListaGG.FieldByName('TOT_TURNI').AsString;
    end;
    cdsLista.FieldByName('TOT_TURNI').AsInteger:=TotTurni;
    cdsLista.Post;
    //Totale ore
    cdsLista.Append;
    cdsLista.FieldByName('ORDINE').AsInteger:=10001;
    cdsLista.FieldByName('NOMINATIVO').AsString:='Tot. ore';
    TotOre:=R180MinutiOre(0);
    for i:=0 to Trunc(Al - Dal) do
    begin
      cdsListaGG.Locate('DATA',Dal + i,[]);
      TotOre:=R180MinutiOre(R180OreMinuti(TotOre) + R180OreMinuti(cdsListaGG.FieldByName('TOT_ORE').AsString));
      cdsLista.FieldByName(FormatDateTime('yyyymmdd',Dal + i)).AsString:=cdsListaGG.FieldByName('TOT_ORE').AsString;
    end;
    cdsLista.FieldByName('TOT_ORE').AsString:=TotOre;
    cdsLista.Post;
    //Esporto in excel
    if Sender = mnuEsportaCsv then
      csvDownload:=grdProspetto.ToCsv
    else
      streamDownload:=grdProspetto.ToXlsx;
    //Cancello i record fittizi inseriti
    if cdsLista.Locate('ORDINE',10001,[]) then
      cdsLista.Delete;
    if cdsLista.Locate('ORDINE',10000,[]) then
      cdsLista.Delete;
  end;
end;

procedure TW004FReperibilita.mnuEsportaCsvClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    mnuEsportaClick(mnuEsportaCsv)
  else
    InviaFile('ProspettoReperibilita.xls',csvDownload);
end;

procedure TW004FReperibilita.mnuEsportaExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    mnuEsportaClick(mnuEsportaExcel)
  else
    InviaFile('ProspettoReperibilita.xlsx',streamDownload);
end;

function TW004FReperibilita.VarToInt(MyVar:variant):integer;
begin
  Result:=0;
  if MyVar <> Null then
    Result:=MyVar;
end;

procedure TW004FReperibilita.grdProspettoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  r,c,Prog,TotTurni:Integer;
  OraInizioInt, OraFineInt:integer;
  Data:TDateTime;
  Timbrature,GiustifGG,Turni,Turno,Priorita,DTurno,DalleAlle,
  TestoOrig,Testo,BackgroundColor,FontWeight,AltTurno,TotOre:String;
  function GetData(const S:String):String;
  var Spaziatura:String;
  begin
    Result:=Copy(FormatDateTime('dddd',StrToDate(S)),1,2) + '<br>';
    if R180Anno(Dal) = R180Anno(Al) then
    begin
      if R180Mese(Dal) = R180Mese(Al) then
      begin
        Spaziatura:=DupeString('&nbsp;',MaxLenTurno + 1);
        Result:=Result + Spaziatura + Copy(S,1,2) + Spaziatura;
      end
      else
      begin
        if MaxLenTurno > 3 then
          Spaziatura:=DupeString('&nbsp;',Round(((MaxLenTurno + 1) / 2)));
        Result:=Result + Spaziatura + Copy(S,1,5) + Spaziatura;
      end;
    end
    else
    begin
      if MaxLenTurno > 5 then
        Spaziatura:=DupeString('&nbsp;',Round(((MaxLenTurno + 1) / 3)));
      Result:=Result + Spaziatura + FormatDateTime('dd/mm/yy',StrToDate(S)) + Spaziatura;
    end;
  end;
begin
  inherited;
  if not grdProspetto.medpRenderCell(ACell, ARow, AColumn, True, True, False) then
    Exit;
  r:=ARow - 1;
  c:=grdProspetto.medpNumColonna(AColumn);
  if grdProspetto.medpColonna(c).DataField = 'TOT_TURNI' then
  begin
    //Totalizzo i turni dell'intero prospetto
    if ARow = 0 then
    begin
      TotTurni:=0;
      W004DM.cdsListaGG.First;
      while not W004DM.cdsListaGG.Eof do
      begin
        TotTurni:=TotTurni + W004DM.cdsListaGG.FieldByName('TOT_TURNI').AsInteger;
        W004DM.cdsListaGG.Next;
      end;
      ACell.Text:='Tot.<br>turni<br>' + '<div style="color:black; font-weight:normal; font-size:0.9em; border-top: 1px solid grey">' + IntToStr(TotTurni) + '<br>' + '&nbsp;' + '</div>';
    end
    else
    begin
      ACell.Text:='<div style="color:black; font-weight:normal; font-size:0.9em;">' + ACell.Text + '</div>';
      ACell.Css:=StringReplace(ACell.Css,'align_right','',[rfReplaceAll]) + ' align_center';
    end;
  end
  else if grdProspetto.medpColonna(c).DataField = 'TOT_ORE' then
  begin
    //Totalizzo le ore dell'intero prospetto
    if ARow = 0 then
    begin
      TotOre:=R180MinutiOre(0);
      W004DM.cdsListaGG.First;
      while not W004DM.cdsListaGG.Eof do
      begin
        TotOre:=R180MinutiOre(R180OreMinuti(TotOre) + R180OreMinuti(W004DM.cdsListaGG.FieldByName('TOT_ORE').AsString));
        W004DM.cdsListaGG.Next;
      end;
      ACell.Text:='Tot.<br>ore<br>' + '<div style="color:black; font-weight:normal; font-size:0.9em; border-top: 1px solid grey">' + '&nbsp;' + '<br>' + TotOre + '</div>';
    end
    else
    begin
      ACell.Text:='<div style="color:black; font-weight:normal; font-size:0.9em;">' + ACell.Text + '</div>';
      ACell.Css:=ACell.Css + ' align_center';
    end;
  end
  else if c >= NCOLONNEBLOCCATE then
    with W004DM do
    begin
      if ARow = 0 then
      begin
        Data:=StrToDate(ACell.Text);
        ACell.RawText:=True;
        ACell.Text:=GetData(ACell.Text);
        if DayOfWeek(Data) = 1 then
          ACell.Css:=ACell.Css + ' font_rosso';
        cdsListaGG.Locate('DATA',Data,[]);
        ACell.Text:=ACell.Text + '<br>' + '<div style="color:black; font-weight:normal; font-size:0.9em; border-top: 1px solid grey">' + cdsListaGG.FieldByName('TOT_TURNI').AsString + '<br>' + cdsListaGG.FieldByName('TOT_ORE').AsString + '</div>';
        ACell.Hint:='Data' + '<br>' + 'Turni' + '<br>' + 'Ore';
        ACell.Css:=ACell.Css + ' tooltipHtml';
      end
      else if (Length(grdProspetto.medpCompGriglia) > 0) then
      begin
        Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(c).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,7,2)));
        Prog:=StrToInt(grdProspetto.medpValoreColonna(r,'PROGRESSIVO'));
        if cdsListaTimb.Locate('PROGRESSIVO;DATA',VarArrayOf([Prog,Data]),[]) then
        begin
          Timbrature:=cdsListaTimb.FieldByName('TIMBRATURE').AsString;
          GiustifGG:=cdsListaTimb.FieldByName('GIUSTIF_GG').AsString;
          if cdsListaTimb.FieldByName('LAVORATIVO').AsString = 'N' then
            ACell.Css:=ACell.Css + ' bg_nonlavorativo';
          //Altezza contenitore per: 3 turni = 4em, per 2 turni = 2.66em, per 1 turno = 1.33em
          AltTurno:=IfThen(rgpNumTurni.ItemIndex = 2,'4',IfThen(rgpNumTurni.ItemIndex = 1,'2.66','1.33'));
          //Contenitore esterno in cui inserire gli span con i colori e le causali
          TestoOrig:='<div style="position:relative; height:' + AltTurno + 'em;">';
          //Testo fittizio per dimensionare la cella e far applicare gli span successivi
          TestoOrig:=TestoOrig + '&nbsp;';
          //Fascia rossa per presenza giustificativo a giornata intera
          if GiustifGG = 'S' then
            TestoOrig:=TestoOrig + '<span style="position:absolute; left:90%; top:0px; width:5%; height:100%; z-index:7; background-color:#FF0000;">&nbsp;</span>';
          //Fascia verde per presenza timbrature
          if Timbrature <> 'N' then
            TestoOrig:=TestoOrig + '<span style="position:absolute; left:95%; top:0px; width:5%; height:100%; z-index:7; background-color:' + IfThen(Timbrature = 'R','#0000FF','#00FF00') + ';">&nbsp;</span>';
          //Azzero le variabili dei turni
          Turni:='';
          ACell.Hint:=Format('%s %s %s<br>Pianificazione del %s',[VarToStr(selAnagrafe.Lookup('PROGRESSIVO',Prog,'MATRICOLA')),VarToStr(selAnagrafe.Lookup('PROGRESSIVO',Prog,'COGNOME')),VarToStr(selAnagrafe.Lookup('PROGRESSIVO',Prog,'NOME')),FormatDateTime('dd/mm/yyyy',Data)]);
          ACell.Css:=ACell.Css + ' tooltipHtml';
          //Ciclo sui turni del giorno del dipendente
          if cdsListaTurni.Locate('PROGRESSIVO;DATA',VarArrayOf([Prog,Data]),[]) then
          begin
            repeat
              //Scelgo se visualizzare il codice del turno o l'orario
              Turno:='';
              Priorita:='';
              DTurno:='';
              DalleAlle:='';
              if cdsListaTurni.FieldByName('TURNO').AsString <> '' then
              begin
                if cdsListaTurni.FieldByName('TURNO').AsString <> '_' then
                begin
                  OraInizioInt:=VarToInt(WR000DM.selT350.Lookup('CODICE',cdsListaTurni.FieldByName('TURNO').AsString,'INIZIO'));
                  OraFineInt:=VarToInt(WR000DM.selT350.Lookup('CODICE',cdsListaTurni.FieldByName('TURNO').AsString,'FINE'));
                  Priorita:=cdsListaTurni.FieldByName('PRIORITA').AsString;
                  DTurno:=VarToStr(WR000DM.selT350.Lookup('CODICE',cdsListaTurni.FieldByName('TURNO').AsString,'DESCRIZIONE'));
                  DalleAlle:=Format('%s - %s',[R180MinutiOre(StrToIntDef(VarToStr(OraInizioInt),0)),R180MinutiOre(StrToIntDef(VarToStr(OraFineInt),0))]);
                  ACell.Hint:=ACell.Hint + '<br>' + cdsListaTurni.FieldByName('TURNO').AsString + IfThen(DTurno <> '',' ' + DTurno) + IfThen(DalleAlle <> '',': ' + DalleAlle);
                end;
                //Utente: TORINO_CITTADELLASALUTE Commessa: 2016/265 SVILUPPO#1
                if rgpVisTurnoOrario.Items[rgpVisTurnoOrario.ItemIndex] = 'Turno' then
                begin
                  Turno:=cdsListaTurni.FieldByName('TURNO').AsString;
                end
                else if (rgpVisTurnoOrario.Items[rgpVisTurnoOrario.ItemIndex] = 'Orario') and ((OraInizioInt > 0) or (OraFineInt > 0)) then
                begin
                  Turno:=Format('%s-%s',[R180MinutiOre(StrToIntDef(VarToStr(OraInizioInt),0)), R180MinutiOre(StrToIntDef(VarToStr(OraFineInt),0))]);
                end;
              end;
              {Priorita:='';
              DTurno:='';
              DalleAlle:='';
              if (Turno <> '') and (Turno <> '_') then
              begin
                Priorita:=cdsListaTurni.FieldByName('PRIORITA').AsString;
                DTurno:=VarToStr(WR000DM.selT350.Lookup('CODICE',Turno,'DESCRIZIONE'));
                DalleAlle:=Format('%s - %s',[R180MinutiOre(StrToIntDef(VarToStr(OraInizioInt),0)),R180MinutiOre(StrToIntDef(VarToStr(OraFineInt),0))]);
                ACell.Hint:=ACell.Hint + '<br>' + Turno + IfThen(DTurno <> '',' ' + DTurno) + IfThen(DalleAlle <> '',': ' + DalleAlle);
              end;}
              Turni:=Turni + Turno + IfThen(Priorita <> '',' ' + Priorita) + ',';
              BackgroundColor:='transparent';
              //Creo gli span colorati, sovrapponendo gli strati di visualizzazione
              TestoOrig:=TestoOrig + Format('<span style="position:absolute; left:%s; top:0px; width:%s; height:100%%; z-index:%s; background-color:%s;">&nbsp;</span>',
                                              ['0px',
                                               '100%',
                                               '1',
                                               BackgroundColor]);
              cdsListaTurni.Next;
            until cdsListaTurni.Eof
            or (cdsListaTurni.FieldByName('PROGRESSIVO').AsInteger <> Prog)
            or (cdsListaTurni.FieldByName('DATA').AsDateTime <> Data);
          end;
          //Testo con i turni pianificati
          Turni:=StringReplace(Copy(Turni,1,Length(Turni) - 1),',','<br>',[rfReplaceAll]);
          if Turni <> '' then
          begin
            //Utente: TORINO_CITTADELLASALUTE Commessa: 2016/265 SVILUPPO#1
            if rgpVisTurnoOrario.Items[rgpVisTurnoOrario.ItemIndex] = 'Turno' then
            begin
              TestoOrig:=TestoOrig + '<span style="position:absolute; left:0px; top:0px; width:100%; height:100%; z-index:8; background-color:transparent; padding-left:2px;">#TURNI#</span>';
            end
            else if rgpVisTurnoOrario.Items[rgpVisTurnoOrario.ItemIndex] = 'Orario' then
            begin
              TestoOrig:=TestoOrig + '<span style="position:absolute; left:0px; top:0px; width:100%; height:100%; z-index:8; background-color:transparent; padding-left:0px;">#TURNI#</span>';
            end;
          end;
          TestoOrig:=TestoOrig + '</div>';
          //Svuoto il testo derivante dal caricamento di cdsLista per l'esportazione in excel
          ACell.Text:='';
          //Se la cella non contiene componenti...
          if grdProspetto.medpCompGriglia[r].CompColonne[c] = nil then
          begin
            //...gestisco tutto nel testo della cella
            ACell.RawText:=True;
            Testo:=StringReplace(TestoOrig,'#TURNI#',Turni,[rfReplaceAll]);
            ACell.Text:=Testo;
          end
          //Se la cella contiene componenti...
          else
          begin
            //...gestisco tutto nel testo dei componenti della grid della cella
            ACell.Control:=grdProspetto.medpCompGriglia[r].CompColonne[c];
            FontWeight:='normal';
            if fsBold in (grdProspetto.medpCompCella(r,c,0) as TmeIWLink).Font.Style then
              FontWeight:='bold';
            if rgpVisTurnoOrario.Items[rgpVisTurnoOrario.ItemIndex] = 'Turno' then
            begin
              Testo:=StringReplace(TestoOrig,'#TURNI#',Format('<u style="color:blue; font-weight:%s;">%s</u>',[FontWeight,Turni]),[rfReplaceAll]);
            end
            else if rgpVisTurnoOrario.Items[rgpVisTurnoOrario.ItemIndex] = 'Orario' then
            begin
              Testo:=StringReplace(TestoOrig,'#TURNI#',Format('<u style="color:blue; font-weight:%s; font-size:%dpx;">%s</u>',[FontWeight,9,Turni]),[rfReplaceAll]);
            end;
            with (grdProspetto.medpCompCella(r,c,0) as TmeIWLink) do
            begin
              RawText:=True;
              Text:=Testo;
              Css:='';
            end;
          end;
        end;
      end;
    end;
end;

procedure TW004FReperibilita.grdReperibilitaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
begin
  if not SolaLettura then
  begin
    with grdReperibilita do
    begin
      if StileCella1 = '' then
      begin
        with (medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
        begin
          StileCella1:=Cell[0,0].Css;
          StileCella2:=Cell[0,2].Css;
        end;
        {
        with (medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid) do
        begin
          StileCella3:=Cell[0,0].Css;
        end;
        }
      end;
      //Riga di inserimento
      (medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
      (medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
      (medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgConfermaInserimentoClick;
      with (medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;

      // GC 191203 - Imposto il secondo tasto di modifica recapiti alt.
      // Questo tasto è utilizzato solo in pianificazione reperibilità
      if Tipologia = 'R' then
      begin
        (medpCompCella(0,ColSchedaAnag,1) as TmeIWImageFile).OnClick:=imgInserisciRecapitiClick;
        (medpCompCella(0,ColSchedaAnag,1) as TmeIWImageFile).ImageFile.URL:='img/btnInfo.png';
      end;
      with (medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid) do
        Cell[0,1].Css:='invisibile'; // Parte nascosto

      // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
      // scheda anagrafica e modifica dati anagrafici
      {
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        (medpCompCella(0,ColSchedaAnag,0) as TmeIWImageFile).OnClick:=imgModificaDatiClick;
      with (medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid) do
      begin
        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
          Cell[0,0].Css:='invisibile';
      end;
      }
      // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini

      //Righe dati
      for i:=1 to High(medpCompGriglia) do
      begin
        // Associo l'evento OnClick alle Icone
        (medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCancellaClick;
        (medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
        (medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
        with (medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          Cell[0,2].Css:='invisibile';
          Cell[0,3].Css:='invisibile';
        end;

        // Il primo elemento nella colonna ColSchedaAnag è il tasto di modifica dati anagrafici

        // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
        with (medpCompGriglia[i].CompColonne[ColSchedaAnag] as TmeIWGrid) do
          Cell[0,0].Css:='invisibile'; // Parte nascosto
        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        begin
          (medpCompCella(i,ColSchedaAnag,0) as TmeIWImageFile).OnClick:=imgModificaDatiClick;
        end;
        // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine

        // Il secondo è il tasto di modifica recapiti alt.
        // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
        with (medpCompGriglia[i].CompColonne[ColSchedaAnag] as TmeIWGrid) do
          Cell[0,1].Css:='invisibile'; // Parte nascosto
        // Questo tasto è utilizzato solo in pianificazione reperibilità
        if Tipologia = 'R' then
        begin
          (medpCompCella(i,ColSchedaAnag,1) as TmeIWImageFile).OnClick:=imgModificaRecapitiClick;
          (medpCompCella(i,ColSchedaAnag,1) as TmeIWImageFile).ImageFile.URL:='img/btnInfo.png';
        end;
        // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine
      end;
    end;
  end;
end;

procedure TW004FReperibilita.grdReperibilitaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  NomeCampo,Cod: String;
begin
  if not grdReperibilita.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdReperibilita.medpNumColonna(AColumn);
  NomeCampo:=grdReperibilita.medpColonna(NumColonna).DataField;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdReperibilita.medpCompGriglia) + 1) and (grdReperibilita.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdReperibilita.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if ARow > 0 then
  begin
    // allineamento al centro per alcuni campi
    if (NomeCampo = 'DATA') or
       (NomeCampo = 'DATA_GIORNO') or
       (Copy(NomeCampo,1,8) = 'PRIORITA') then
      ACell.Css:=ACell.Css + ' align_center';

    if (NomeCampo = 'C_TURNO1') and
       (ACell.Control = nil) then
    begin
      Cod:=grdReperibilita.medpValoreColonna(ARow - 1,'TURNO1');
      if Cod <> '' then
        ACell.Text:=Format('%s - %s',[Cod,VarToStr(WR000DM.selT350.Lookup('CODICE',Cod,'DESCRIZIONE'))]);
    end
    else if (NomeCampo = 'C_TURNO2') and
       (ACell.Control = nil) then
    begin
      Cod:=grdReperibilita.medpValoreColonna(ARow - 1,'TURNO2');
      if Cod <> '' then
        ACell.Text:=Format('%s - %s',[Cod,VarToStr(WR000DM.selT350.Lookup('CODICE',Cod,'DESCRIZIONE'))]);
    end
    else if (NomeCampo = 'C_TURNO3') and
       (ACell.Control = nil) then
    begin
      Cod:=grdReperibilita.medpValoreColonna(ARow - 1,'TURNO3');
      if Cod <> '' then
        ACell.Text:=Format('%s - %s',[Cod,VarToStr(WR000DM.selT350.Lookup('CODICE',Cod,'DESCRIZIONE'))]);
    end
    else if (NomeCampo = 'PRIORITA2') and
            (grdReperibilita.medpValoreColonna(ARow - 1,'TURNO2') = '') then
    begin
      ACell.Text:=''
    end
    else if (NomeCampo = 'PRIORITA3') and
            (grdReperibilita.medpValoreColonna(ARow - 1,'TURNO3') = '') then
    begin
      ACell.Text:='';
    end
    else if NomeCampo = 'D_INFO' then
    begin
      ACell.Css:=ACell.Css + ' info_dipendente gridTrasparente';
      if ARow > IfThen(grdReperibilita.medpRigaInserimento,1,0) then
        ACell.Text:=GetInfoDip(ARow - 1);
    end;
  end;
end;

procedure TW004FReperibilita.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  if grdModifica <> nil then
    grdModifica.DataSource.DataSet.Locate('DBG_ROWID',AValue,[]);
  W004DM.selT380.SearchRecord('ROWID',AValue,[srFromBeginning]);
end;

procedure TW004FReperibilita.GetDipendentiDisponibili;
// popola la combo dei dipendenti
var
  Codice, Descrizione: String;
  P: Integer;
  Trovato: Boolean;
begin;
  with selAnagrafe do
  begin
    // salva progressivo prima del loop
    if Active then
      P:=FieldByName('PROGRESSIVO').AsInteger
    else
      P:=-1;

    // riapertura dataset
    R180SetVariable(selAnagrafe,'DATALAVORO',Al);

    cmbDipendentiDisponibili.Items.Clear;

    Open;
    First;

    while not Eof do
    begin
      Codice:=FieldByName('MATRICOLA').AsString;
      Descrizione:=Format('%-8s %s %s',[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString,FieldByName('NOME').AsString]);
      cmbDipendentiDisponibili.Items.Add(Descrizione + '=' + Codice);
      Next;
    end;

    // riposizionamento bookmark su selAnagrafe
    Trovato:=SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
    if not Trovato then
      First;
  end;
  cmbDipendentiDisponibili.RequireSelection:=cmbDipendentiDisponibili.Items.Count > 0;
  if cmbDipendentiDisponibili.Items.Count > 0 then
    cmbDipendentiDisponibili.ItemIndex:=0;
end;

procedure TW004FReperibilita.btnCancellaClick(Sender: TObject);
var
  i:Integer;
begin
  W004DM.A040MW.selT380:=W004DM.selT380GestMesile;
  W004DM.A040MW.Dipendente:=edtDipMatricola.Text;
  W004DM.A040MW.ProgGM:=GetProgressivo;
  W004DM.A040MW.DataControllo:=Dal;
  W004DM.A040MW.ListaGiorniSel.Clear;
  for i:=0 to clbGiorni.Items.Count - 1 do
    if clbGiorni.Selected[i] then
      W004DM.A040MW.ListaGiorniSel.Append(clbGiorni.Items[i]);
  W004DM.A040MW.Turno1Value:=cmbTurno1.Text;
  W004DM.A040MW.Turno2Value:=cmbTurno2.Text;
  W004DM.A040MW.Turno3Value:=cmbTurno3.Text;
  W004DM.A040MW.DatoLiberoValue:=CmbDatoLibero.Text;
  W004DM.A040MW.NonContDipPian:=chkNonContDipPian.Checked;
  W004DM.A040MW.CancellaGestioneMensile;
  //FineElaborazioneMensile viene richiamato alla fine di W004DM.A040MW.CancellaGestioneMensile
end;

procedure TW004FReperibilita.btnEseguiClick(Sender: TObject);
// aggiorna la visualizzazione in base al periodo indicato
var
  c: Integer;
begin
  PutParametriFunzione;

  lstScrollBar[ScrollBarIndexOf('divscrollable')].Top:=0;
  lstScrollBar[ScrollBarIndexOf('divscrollable')].Left:=0;
  Dal:=StrToDate(edtPeriodoDal.Text);
  Al:=StrToDate(edtPeriodoAl.Text);

  if (not SolaLettura) and (Length(grdReperibilita.medpDescCompGriglia.RigaIns) > 0) then
  begin
    c:=grdReperibilita.medpIndexColonna('DATA');
    (grdReperibilita.medpCompCella(0,c,0) as TmeIWEdit).Text:=edtPeriodoDal.Text;
  end;

  GetDipendentiDisponibili;
  GetTurniPianificati;
  //Ricarico lista gestione mensile
  if tabReperibilita.ActiveTab = W004GestioneMensileRG then
  begin
    AssegnaDatoAggAna:=True;
    SvuotaGestMensileDatiAgg;
    IniGestMensileDatiAgg;
    CaricaClbGiorni(Dal);
  end;

  grdReperibilita.Visible:=True;
  if (Dal = R180InizioMese(Dal)) and (Al = R180FineMese(Dal)) then
    grdReperibilita.Caption:=IfThen(Tipologia = 'R','Reperibilità','Guardia') + ' del mese di ' + FormatDateTime('mmmm yyyy',Dal)
  else
    grdReperibilita.Caption:=Format('%s dal %s al %s',[IfThen(Tipologia = 'R','Reperibilità','Guardia'),edtPeriodoDal.Text,edtPeriodoAl.Text]);
  grdProspetto.Caption:=grdReperibilita.Caption;

  W004DM.A040MW.DataSt:=R180InizioMese(Dal);
  WA040Stm.Visualizza;
end;

procedure TW004FReperibilita.btnInserisciClick(Sender: TObject);
var
  i:integer;
begin
  inherited;
  btnInserisci.Enabled:=False;
  openSelT380GestMensile;
  W004DM.A040MW.CodTipologia:=Tipologia;
  W004DM.A040MW.selT380:=W004DM.selT380GestMesile;
  W004DM.A040MW.Dipendente:=edtDipMatricola.Text;
  W004DM.A040MW.ProgGM:=GetProgressivo;
  W004DM.A040MW.DataControllo:=Dal;
  W004DM.A040MW.DataInizio:=R180InizioMese(Dal);
  W004DM.A040MW.DataFine:=R180FineMese(Al);
  W004DM.A040MW.ListaGiorniSel.Clear;
  for i:=0 to clbGiorni.Items.Count - 1 do
    if clbGiorni.Selected[i] then
      W004DM.A040MW.ListaGiorniSel.Append(clbGiorni.Items[i]);
  W004DM.A040MW.Turno1Value:=cmbTurno1.Text;
  W004DM.A040MW.Turno2Value:=cmbTurno2.Text;
  W004DM.A040MW.Turno3Value:=cmbTurno3.Text;
  W004DM.A040MW.DatoLiberoValue:=cmbDatoLibero.Text;
  W004DM.A040MW.Priorita1Value:=Trim(edtPriorita1.Text);
  W004DM.A040MW.Priorita2Value:=Trim(edtPriorita2.Text);
  W004DM.A040MW.Priorita3Value:=Trim(edtPriorita3.Text);
  W004DM.A040MW.Recapito1Value:=Trim(edtRecapito1.Text);
  W004DM.A040MW.Recapito2Value:=Trim(edtRecapito2.Text);
  W004DM.A040MW.Recapito3Value:=Trim(edtRecapito3.Text);
  W004DM.A040MW.DatoAgg1T1Value:=cmbDatoAgg1T1.Text;
  W004DM.A040MW.DatoAgg1T2Value:=cmbDatoAgg1T2.Text;
  W004DM.A040MW.DatoAgg1T3Value:=cmbDatoAgg1T3.Text;
  W004DM.A040MW.DatoAgg2T1Value:=cmbDatoAgg2T1.Text;
  W004DM.A040MW.DatoAgg2T2Value:=cmbDatoAgg2T2.Text;
  W004DM.A040MW.DatoAgg2T3Value:=cmbDatoAgg2T3.Text;

  W004DM.A040MW.DatoAreaSquadraT1Value:=cmbAreaSquadraT1.Text;
  W004DM.A040MW.DatoAreaSquadraT2Value:=cmbAreaSquadraT2.Text;
  W004DM.A040MW.DatoAreaSquadraT3Value:=cmbAreaSquadraT3.Text;

  W004DM.A040MW.NonContDipPian:=chkNonContDipPian.Checked;
  W004DM.A040MW.T380FiltraSelAnagrafe:=chkSoloSelAnagrafe.Checked;
  W004DM.A040MW.InserisciGestioneMensile;
  //FineElaborazioneMensile viene richiamato alla fine di W004DM.A040MW.InserisciGestioneMensile
end;

procedure TW004FReperibilita.FineElaborazioneMensile(VisualizzaMsg:Boolean = False);
begin
  btnInserisci.Enabled:=True;
    W004DM.selT380.Refresh;
    W004DM.A040MW.selT380.Close;
  if VisualizzaMsg then
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_MSG_OPERAZIONE_COMPLETATA), INFORMA);
end;

procedure TW004FReperibilita.imgAnnullaClick(Sender: TObject);
var
  FN: String;
begin
  try
    FN:=(Sender as TmeIWImageFile).FriendlyName;

    // pulizia info dati anagrafici
    DatiAnag.Progressivo:=0;
    DatiAnag.Decorrenza:=DATE_NULL;
    DatiAnag.Nominativo:='';
    DatiAnag.Modificato:=False;
  
    // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
    // annullo eventuali modifiche recapiti alt., mi evita di dover ripopolare il cds da zero.
    // In turni di guardia la modifica è inibita quindi i recapiti vecchi e nuovi sono uguali
    cdsT380.Edit;
    cdsT380.FieldByName('RECAPITO1').AsString:=OldRecapito1;
    cdsT380.FieldByName('RECAPITO2').AsString:=OldRecapito2;
    cdsT380.FieldByName('RECAPITO3').AsString:=OldRecapito3;
    cdsT380.FieldByName('DATOAGG1_T1').AsString:=OldDatoAgg1T1;
    cdsT380.FieldByName('DATOAGG1_T2').AsString:=OldDatoAgg1T2;
    cdsT380.FieldByName('DATOAGG1_T3').AsString:=OldDatoAgg1T3;
    cdsT380.FieldByName('DATOAGG2_T1').AsString:=OldDatoAgg2T1;
    cdsT380.FieldByName('DATOAGG2_T2').AsString:=OldDatoAgg2T2;
    cdsT380.FieldByName('DATOAGG2_T3').AsString:=OldDatoAgg2T3;
    cdsT380.FieldByName('AREASQUADRA_T1').AsString:=OldAreaSquadraT1;
    cdsT380.FieldByName('AREASQUADRA_T2').AsString:=OldAreaSquadraT2;
    cdsT380.FieldByName('AREASQUADRA_T3').AsString:=OldAreaSquadraT3;
    cdsT380.Post;
    // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine

    grdReperibilita.medpBrowse:=True;
    if Operazione = 'I' then
      TrasformaComponentiInserimento
    else
      TrasformaComponenti(FN);

    // annullamento modifiche
    Operazione:='';
  finally
    //Riporta alla selezione del dipendente corretta
    if Operazione = 'I' then
      cmbDipendentiDisponibiliChange(nil);
  end;
end;

procedure TW004FReperibilita.imgCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if (Operazione <> '') then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione' + CRLF +
                      'di ' + IfThen(Operazione = 'I','inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA);
    Exit;
  end;
  Cancellazione(FN);
end;

procedure TW004FReperibilita.Cancellazione(FN: String);
begin
  DBGridColumnClick(nil,FN);
  // eliminazione record
  actCancellazioneOK(FN);
end;

procedure TW004FReperibilita.imgConfermaClick(Sender: TObject);
var
  FN: String;
  Ricarica: Boolean;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
  // valuta aggiornamento dati anagrafici
  // (effettuato indipendentemente dalla chiamata in reperibilità)
  Ricarica:=False;
  if DatiAnag.Modificato then
  begin
    try
      W002ModDatiDM.updDatiAnag.Execute;
      SessioneOracle.Commit;
      Notifica('Informazione',Format('I dati anagrafici di <b>%s</b> sono stati modificati con decorrenza %s',
                                     [DatiAnag.Nominativo,DateToStr(DatiAnag.Decorrenza)]),
               '',False,False,5000);
    except
      on E: Exception do
      begin
        Notifica('Avviso',Format('Le modifiche ai dati anagrafici di <b>%s</b> non sono state aggiornate:%s%s',
                                 [DatiAnag.Nominativo,CRLF,E.Message]),
                 '',False,True);
      end;
    end;

    // pulizia info dati anagrafici
    DatiAnag.Progressivo:=0;
    DatiAnag.Decorrenza:=DATE_NULL;
    DatiAnag.Nominativo:='';
    DatiAnag.Modificato:=False;
    Ricarica:=True;
  end;
  // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine

  // applica le modifiche
  if not ModificheRiga(FN) then
  begin
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    // se i dati anagrafici sono stati modificati ricarica tutto
    if Ricarica then
    begin
      GetTurniPianificati;
    end
    else
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine
    begin
      Operazione:='';
      grdReperibilita.medpBrowse:=True;
      TrasformaComponenti(FN);
    end;
    Exit;
  end;

  // se record non esiste -> errore grave
  if not W004DM.selT380.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    Operazione:='';
    grdReperibilita.medpBrowse:=True;
    TrasformaComponenti(FN);
    MsgBox.MessageBox('Si è verificato un errore durante la modifica della pianificazione:' + CRLF +
                      'il record non è più disponibile.',ESCLAMA);
    Exit;
  end;

  Modifica(FN);
end;

procedure TW004FReperibilita.Modifica(FN: String);
begin
  // effettua controlli bloccanti
  if ControlliOK(FN) then
    actInsVar0;
end;

procedure TW004FReperibilita.imgModificaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if (Operazione <> '') then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione' + CRLF +
                      'di ' + IfThen(Operazione = 'I','inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
  // salvo i recapiti attuali, mi occoreranno per ripristinare il cds in caso di annullamento
  // e per il log dell'operazione di salvataggio su db
  OldRecapito1:=cdsT380.FieldByName('RECAPITO1').AsString;
  OldRecapito2:=cdsT380.FieldByName('RECAPITO2').AsString;
  OldRecapito3:=cdsT380.FieldByName('RECAPITO3').AsString;
  OldDatoAgg1T1:=cdsT380.FieldByName('DATOAGG1_T1').AsString;
  OldDatoAgg1T2:=cdsT380.FieldByName('DATOAGG1_T2').AsString;
  OldDatoAgg1T3:=cdsT380.FieldByName('DATOAGG1_T3').AsString;
  OldDatoAgg2T1:=cdsT380.FieldByName('DATOAGG2_T1').AsString;
  OldDatoAgg2T2:=cdsT380.FieldByName('DATOAGG2_T2').AsString;
  OldDatoAgg2T3:=cdsT380.FieldByName('DATOAGG2_T3').AsString;
  OldAreaSquadraT1:=cdsT380.FieldByName('AREASQUADRA_T1').AsString;
  OldAreaSquadraT2:=cdsT380.FieldByName('AREASQUADRA_T2').AsString;
  OldAreaSquadraT3:=cdsT380.FieldByName('AREASQUADRA_T3').AsString;
  // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine

  // porta la riga in modifica: trasforma i componenti
  Operazione:='M';
  grdReperibilita.medpBrowse:=False;
  TrasformaComponenti(FN);
end;

procedure TW004FReperibilita.imgModificaDatiClick(Sender: TObject);
var
  r: Integer;
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // estrae dati dipendente e indice array per modifica
  with grdReperibilita do
  begin
    r:=medpRigaDiCompGriglia(FN);

    if Operazione = 'I' then
    begin
      DatiAnag.Nominativo:='';// T030NOMINATIVO
      //
    end
    else
    begin
      DatiAnag.Nominativo:=medpValoreColonna(r,'T030NOMINATIVO');
      DatiAnag.Progressivo:=StrToIntDef(medpValoreColonna(r,'PROGRESSIVO'),0);
    end;
  end;

  // prepara il clientdataset con i dati del dipendente selezionato
  PreparaDatiAnag;

  // apre il form di modifica dati anagrafici
  W002ModDatiFM:=TW002FModificaDatiFM.Create(Self);
  W002ModDatiFM.W002ModDatiDM:=Self.W002ModDatiDM;
  W002ModDatiFM.Progressivo:=DatiAnag.Progressivo;
  W002ModDatiFM.Nominativo:=DatiAnag.Nominativo;
  W002ModDatiFM.Visualizza;
end;

// IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
procedure TW004FReperibilita.imgModificaRecapitiClick(Sender: TObject);
var Row:Integer;
begin
  // Ricavo il numero della riga in modifica
  Row:=grdReperibilita.medpRigaDiCompGriglia(cdsT380.FieldByName('DBG_ROWID').AsString);
  W004ModRecapitiFM:=TW004FModificaRecapitiFM.Create(Self);
  try
    // Recapito alt. turno 1
    W004ModRecapitiFM.CodT1:=Trim((grdReperibilita.medpCompCella(Row,'C_TURNO1',0) as TMedpIWMultiColumnComboBox).Text);

    if Trim(cdsT380.FieldByName('RECAPITO1').AsString) <> '' then
      W004ModRecapitiFM.RecapitoT1:=cdsT380.FieldByName('RECAPITO1').AsString
    else if DatoRecapito <> '' then
       W004ModRecapitiFM.RecapitoT1:=grdReperibilita.medpDataSet.FieldByName(DatoRecapito).AsString
    else
      W004ModRecapitiFM.RecapitoT1:='';

    W004ModRecapitiFM.RecT1Attivo:=True;
    W004ModRecapitiFM.DatoAgg1T1:=cdsT380.FieldByName('DATOAGG1_T1').AsString;
    W004ModRecapitiFM.DatoAgg2T1:=cdsT380.FieldByName('DATOAGG2_T1').AsString;
    W004ModRecapitiFM.DatoAreaSquadraT1:=cdsT380.FieldByName('AREASQUADRA_T1').AsString;
    // Recapito alt. turno 2
    W004ModRecapitiFM.CodT2:=Trim((grdReperibilita.medpCompCella(Row,'C_TURNO2',0) as TMedpIWMultiColumnComboBox).Text);
    if W004ModRecapitiFM.CodT2 <> '' then
    begin
      if Trim(cdsT380.FieldByName('RECAPITO2').AsString) <> '' then
        W004ModRecapitiFM.RecapitoT2:=cdsT380.FieldByName('RECAPITO2').AsString
      else if DatoRecapito <> '' then
         W004ModRecapitiFM.RecapitoT2:=grdReperibilita.medpDataSet.FieldByName(DatoRecapito).AsString
      else
        W004ModRecapitiFM.RecapitoT2:='';
      W004ModRecapitiFM.RecT2Attivo:=True;
      W004ModRecapitiFM.DatoAgg1T2:=cdsT380.FieldByName('DATOAGG1_T2').AsString;
      W004ModRecapitiFM.DatoAgg2T2:=cdsT380.FieldByName('DATOAGG2_T2').AsString;
      W004ModRecapitiFM.DatoAreaSquadraT2:=cdsT380.FieldByName('AREASQUADRA_T2').AsString;
    end;
    // Recapito alt. turno 3
    W004ModRecapitiFM.CodT3:=Trim((grdReperibilita.medpCompCella(Row,'C_TURNO3',0) as TMedpIWMultiColumnComboBox).Text);
    if W004ModRecapitiFM.CodT3 <> '' then
    begin
      if Trim(cdsT380.FieldByName('RECAPITO3').AsString) <> '' then
        W004ModRecapitiFM.RecapitoT3:=cdsT380.FieldByName('RECAPITO3').AsString
      else if DatoRecapito <> '' then
         W004ModRecapitiFM.RecapitoT3:=grdReperibilita.medpDataSet.FieldByName(DatoRecapito).AsString
      else
        W004ModRecapitiFM.RecapitoT3:='';
      W004ModRecapitiFM.RecT3Attivo:=True;
      W004ModRecapitiFM.DatoAgg1T3:=cdsT380.FieldByName('DATOAGG1_T3').AsString;
      W004ModRecapitiFM.DatoAgg2T3:=cdsT380.FieldByName('DATOAGG2_T3').AsString;
      W004ModRecapitiFM.DatoAreaSquadraT3:=cdsT380.FieldByName('AREASQUADRA_T3').AsString;
    end;
    // dato aggiuntivo 1
    if DatoLiberoAgg1 <> '' then
    begin
      W004ModRecapitiFM.lblDatoAgg1.Caption:=Trim(R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1));
      W004ModRecapitiFM.DatoAgg1Ana:=W004DM.selT380.FieldByName(DatoLiberoAgg1).AsString;
      A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1,W004DM.selSQL);
      if W004DM.selSQL.VariableIndex('DECORRENZA') >= 0 then
        W004DM.selSQL.SetVariable('DECORRENZA',cdsT380.FieldByName('DATA').AsDateTime);
      try
        W004DM.selSQL.Open;
      except
      end;
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg1T1,W004DM.selSQL,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg1T2,W004DM.selSQL,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg1T3,W004DM.selSQL,'CODICE','DESCRIZIONE');
    end;
    // dato aggiuntivo 2
    if DatoLiberoAgg2 <> '' then
    begin
      W004ModRecapitiFM.lblDatoAgg2.Caption:=Trim(R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2));
      W004ModRecapitiFM.DatoAgg2Ana:=W004DM.selT380.FieldByName(DatoLiberoAgg2).AsString;
      A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2,W004DM.selSQL);
      if W004DM.selSQL.VariableIndex('DECORRENZA') >= 0 then
        W004DM.selSQL.SetVariable('DECORRENZA',cdsT380.FieldByName('DATA').AsDateTime);
      try
        W004DM.selSQL.Open;
      except
      end;
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg2T1,W004DM.selSQL,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg2T2,W004DM.selSQL,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg2T3,W004DM.selSQL,'CODICE','DESCRIZIONE');
    end;
    // aree di afferenza
    W004ModRecapitiFM.lblAreeTurni.Caption:='';
    W004DM.GetAreeAfferenza(Squadra1Ana, Operatore1Ana);
    if W004DM.selT651.RecordCount > 0 then
    begin
      W004ModRecapitiFM.lblAreeTurni.Caption:='Aree afferenza';
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbAreaSquadraT1,W004DM.selT651,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbAreaSquadraT2,W004DM.selT651,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbAreaSquadraT3,W004DM.selT651,'CODICE','DESCRIZIONE');
    end;

    W004ModRecapitiFM.FreeNotification(Self);
    W004ModRecapitiFM.Visualizza;
  except
    on E:Exception do
    begin
      FreeAndNil(W004ModRecapitiFM);
      raise;
    end;
  end;
end;
// IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine

procedure TW004FReperibilita.imgInserisciClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if Operazione <> '' then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione' + CRLF +
                      'di ' + IfThen(Operazione = 'I','inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  Operazione:='I';
  grdReperibilita.medpBrowse:=False;

  InizializzaVariabiliInserimento;

  TrasformaComponentiInserimento;
end;

procedure TW004FReperibilita.InizializzaVariabiliInserimento;
begin
  // Inizializzo variabili di ritorno per l'inserimento
  R1:='';
  R2:='';
  R3:='';
  Da1T1:='';
  Da1T2:='';
  Da1T3:='';
  Da2T1:='';
  Da2T2:='';
  Da2T3:='';
  AsT1:='';
  AsT2:='';
  AsT3:='';
end;

procedure TW004FReperibilita.imgInserisciRecapitiClick(Sender: TObject);
var Row:Integer;
begin
  InserimentoRecord:=True;

  // il numero della riga in inserimento è sempre 0
  Row:=0;

  W004ModRecapitiFM:=TW004FModificaRecapitiFM.Create(Self);
  try
    // Recapito alt. turno 1
    W004ModRecapitiFM.CodT1:=Trim((grdReperibilita.medpCompCella(Row,'C_TURNO1',0) as TMedpIWMultiColumnComboBox).Text);

    if W004ModRecapitiFM.CodT1 <> '' then
    begin
      W004ModRecapitiFM.RecT1Attivo:=True;
      if R1 <> '' then       //Recapito alternativo
        W004ModRecapitiFM.RecapitoT1:=R1
      else
      begin
        if DatoRecapito <> '' then
          W004ModRecapitiFM.RecapitoT1:=W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString
        else
          W004ModRecapitiFM.RecapitoT1:='';
      end;

      if AssegnaDatoAggAna then  //Dati anagrafici
      begin
        W004ModRecapitiFM.DatoAgg1T1:=IfThen(Da1T1 <> '', Da1T1, DatoIns1Ana);
        W004ModRecapitiFM.DatoAgg2T1:=IfThen(Da2T1 <> '', Da2T1, DatoIns2Ana);
      end
      else
      begin
        W004ModRecapitiFM.DatoAgg1T1:='';
        W004ModRecapitiFM.DatoAgg2T1:='';
      end;
      W004ModRecapitiFM.DatoAreaSquadraT1:=IfThen(AsT1 <> '', AsT1, '');
    end;
    // Recapito alt. turno 2
    W004ModRecapitiFM.CodT2:=Trim((grdReperibilita.medpCompCella(Row,'C_TURNO2',0) as TMedpIWMultiColumnComboBox).Text);
    if W004ModRecapitiFM.CodT2 <> '' then
    begin
      W004ModRecapitiFM.RecT2Attivo:=True;
      if R2 <> '' then       //Recapito alternativo
        W004ModRecapitiFM.RecapitoT2:=R2
      else
      begin
        if DatoRecapito <> '' then
          W004ModRecapitiFM.RecapitoT2:=W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString
        else
          W004ModRecapitiFM.RecapitoT2:='';
      end;

      if AssegnaDatoAggAna then  //Dati anagrafici
      begin
        W004ModRecapitiFM.DatoAgg1T2:=IfThen(Da1T2 <> '', Da1T2, DatoIns1Ana);
        W004ModRecapitiFM.DatoAgg2T2:=IfThen(Da2T2 <> '', Da2T2, DatoIns2Ana);
      end
      else
      begin
        W004ModRecapitiFM.DatoAgg1T2:='';
        W004ModRecapitiFM.DatoAgg2T2:='';
      end;
      W004ModRecapitiFM.DatoAreaSquadraT2:=IfThen(AsT2 <> '', AsT2, '');
    end;
    // Recapito alt. turno 3
    W004ModRecapitiFM.CodT3:=Trim((grdReperibilita.medpCompCella(Row,'C_TURNO3',0) as TMedpIWMultiColumnComboBox).Text);
    if W004ModRecapitiFM.CodT3 <> '' then
    begin
      W004ModRecapitiFM.RecT3Attivo:=True;
      if R3 <> '' then       //Recapito alternativo
        W004ModRecapitiFM.RecapitoT3:=R3
      else
      begin
        if DatoRecapito <> '' then
          W004ModRecapitiFM.RecapitoT3:=W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString
        else
          W004ModRecapitiFM.RecapitoT3:='';
      end;

      if AssegnaDatoAggAna then  //Dati anagrafici
      begin
        W004ModRecapitiFM.DatoAgg1T3:=IfThen(Da1T3 <> '', Da1T3, DatoIns1Ana);
        W004ModRecapitiFM.DatoAgg2T3:=IfThen(Da2T3 <> '', Da2T3, DatoIns2Ana);
      end
      else
      begin
        W004ModRecapitiFM.DatoAgg1T3:='';
        W004ModRecapitiFM.DatoAgg2T3:='';
      end;
      W004ModRecapitiFM.DatoAreaSquadraT3:=IfThen(AsT3 <> '', AsT3, '');
    end;
    // dato aggiuntivo 1
    if DatoLiberoAgg1 <> '' then
    begin
      W004ModRecapitiFM.lblDatoAgg1.Caption:=Trim(R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1));
      W004ModRecapitiFM.DatoAgg1Ana:=W004DM.selT380.FieldByName(DatoLiberoAgg1).AsString;
      A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1,W004DM.selSQL);
      if W004DM.selSQL.VariableIndex('DECORRENZA') >= 0 then
        W004DM.selSQL.SetVariable('DECORRENZA',cdsT380.FieldByName('DATA').AsDateTime);
      try
        W004DM.selSQL.Open;
      except
      end;
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg1T1,W004DM.selSQL,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg1T2,W004DM.selSQL,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg1T3,W004DM.selSQL,'CODICE','DESCRIZIONE');
    end;
    // dato aggiuntivo 2
    if DatoLiberoAgg2 <> '' then
    begin
      W004ModRecapitiFM.lblDatoAgg2.Caption:=Trim(R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2));
      W004ModRecapitiFM.DatoAgg2Ana:=W004DM.selT380.FieldByName(DatoLiberoAgg2).AsString;
      A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2,W004DM.selSQL);
      if W004DM.selSQL.VariableIndex('DECORRENZA') >= 0 then
        W004DM.selSQL.SetVariable('DECORRENZA',cdsT380.FieldByName('DATA').AsDateTime);
      try
        W004DM.selSQL.Open;
      except
      end;
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg2T1,W004DM.selSQL,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg2T2,W004DM.selSQL,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbDatoAgg2T3,W004DM.selSQL,'CODICE','DESCRIZIONE');
    end;

    // aree di afferenza
    W004ModRecapitiFM.lblAreeTurni.Caption:='';
    W004DM.GetAreeAfferenza(Squadra1Ana, Operatore1Ana);
    if W004DM.selT651.RecordCount > 0 then
    begin
      W004ModRecapitiFM.lblAreeTurni.Caption:='Aree afferenza';
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbAreaSquadraT1,W004DM.selT651,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbAreaSquadraT2,W004DM.selT651,'CODICE','DESCRIZIONE');
      C190CaricaMepdMulticolumnComboBox(W004ModRecapitiFM.cmbAreaSquadraT3,W004DM.selT651,'CODICE','DESCRIZIONE');
    end;

    W004ModRecapitiFM.FreeNotification(Self);
    W004ModRecapitiFM.Visualizza;
  except
    on E:Exception do
    begin
      InserimentoRecord:=False;
      FreeAndNil(W004ModRecapitiFM);
      raise;
    end;
  end;

end;

procedure TW004FReperibilita.TrasformaComponentiInserimento;
// Creo i componenti della riga di inserimento
var
  c,j: Integer;
  DaTestoAControlli: Boolean;
begin
  with grdReperibilita do
  begin
    c:=medpIndexColonna('C_TURNO1');
    DaTestoAControlli:=medpCompGriglia[0].CompColonne[c] = nil;

    //Nascondo il pulsante inserisci
    with (medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
    end;

    (medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid).Cell[0,1].Css:=IfThen(DaTestoAControlli and (Tipologia = 'R'),StileCella1,'invisibile');

    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    {
    with (medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid) do
    begin
      // modifica dati
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        Cell[0,0].Css:=StileCella1;
    end;
    }
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine
    if DaTestoAControlli then
    begin
      // matricola
      c:=medpIndexColonna('MATRICOLA');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        PopUpHeight:=15;
        ShowHint:=True;
        selAnagrafe.First;
        while not selAnagrafe.Eof do
        begin
          AddRow(selAnagrafe.FieldByName('MATRICOLA').AsString + ';' + selAnagrafe.FieldByName('COGNOME').AsString + ' ' + selAnagrafe.FieldByName('NOME').AsString);
          selAnagrafe.Next;
        end;
        if not selAnagrafe.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]) then
          selAnagrafe.First;
        Text:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
        OnChange:=cmbDipendenteDettaglioChange;
      end;
      // data
      c:=medpIndexColonna('DATA');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      (medpCompCella(0,c,0) as TmeIWEdit).Text:=edtPeriodoDal.Text;
      // turno 1
      c:=medpIndexColonna('C_TURNO1');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        Name:='cmbTurno1Ins';
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:='';
      end;
      // priorità chiamata turno 1
      c:=medpIndexColonna('PRIORITA1');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TmeIWEdit) do
      begin
        MaxLength:=1;
        Text:='';
      end;
      // turno 2
      c:=medpIndexColonna('C_TURNO2');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:='';
      end;
      // priorità chiamata turno 2
      c:=medpIndexColonna('PRIORITA2');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TmeIWEdit) do
      begin
        MaxLength:=1;
        Text:='';
      end;

      // turno 3
      c:=medpIndexColonna('C_TURNO3');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:='';
      end;
      // priorità chiamata turno 3
      c:=medpIndexColonna('PRIORITA3');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TmeIWEdit) do
      begin
        MaxLength:=1;
        Text:='';
      end;

      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      begin
        c:=medpIndexColonna('DATOLIBERO');
        medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'20','','','','S');
        medpCreaComponenteGenerico(0,c,Componenti);
        with (medpCompCella(0,c,0) as TmeIWComboBox) do
        begin
          ItemsHaveValues:=True;
          Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
          Items.Assign(lstDatoLibero);
          ItemIndex:=0;
        end;
      end;
    end
    else
    begin
      // matricola
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('MATRICOLA')]);
      // data
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('DATA')]);
      // turno 1
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('C_TURNO1')]);
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('PRIORITA1')]);
      // turno 2
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('C_TURNO2')]);
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('PRIORITA2')]);
      // turno 3
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('C_TURNO3')]);
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('PRIORITA3')]);
      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
        FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('DATOLIBERO')]);
    end;
    medpBrowse:=not DaTestoAControlli;
  end;
end;

procedure TW004FReperibilita.TurniIntersecati(T1, T2:String);
// determina se due turni si intersecano
var
  I1,I2,F1,F2,F1Ori,F2Ori:Integer;
begin
  with WR000DM do
  begin
    if (T1 <> '') and (T2 <> '') then
    try
      I1:=selT350.Lookup('CODICE',T1,'INIZIO');
      F1Ori:=selT350.Lookup('CODICE',T1,'FINE');
      F1:=F1Ori;
      if F1 <= I1 then
        inc(F1,1440);
      if T2 <> '' then
      begin
        I2:=selT350.Lookup('CODICE',T2,'INIZIO');
        F2Ori:=selT350.Lookup('CODICE',T2,'FINE');
        F2:=F2Ori;
        if F2 <= I2 then
          inc(F2,1440);
        if ((I2 >= I1) and (I2 < F1)) or ((F2 > I1) and (F2 <= F1)) or
           ((I2 <= I1) and (F2 >= F1)) then
        begin
          ErrMessage:=ErrMessage +
                      'Attenzione!' + CRLF +
                      'I seguenti turni si sovrappongono:' + CRLF +
                      SPAZIO + Format('%s: %s - %s',[T1,R180MinutiOre(I1),R180MinutiOre(F1Ori)]) + CRLF +
                      SPAZIO + Format('%s: %s - %s',[T2,R180MinutiOre(I2),R180MinutiOre(F2Ori)]) + CRLF;
          Abort;
        end;
      end;
    except
      ErrMessage:=ErrMessage +
                 'Esistono pianificazioni configurate non correttamente.' + CRLF+
                 'Vuoi continuare?' + CRLF;
      Exit;
    end;
  end;
end;

procedure TW004FReperibilita.TurniIntersecatiTipologieDiverse(T1,T2:String;DataRif:TDateTime);
var I1,I2,F1,F2,F1Ori,F2Ori:Integer;
  Tipo1,Tipo2:String;
begin
  Tipo1:=IfThen(Tipologia = 'R','Guardia','Reperibilità');
  Tipo2:=IfThen(Tipologia = 'R','Reperibilità','Guardia');

  if (T1 <> '') and (T2 <> '') then
  try
    with W004DM do
    begin
      I1:=R180OreMinuti(R180VarToDateTime(selT350Opposto.Lookup('CODICE',T1,'ORAINIZIO')));
      F1Ori:=R180OreMinuti(R180VarToDateTime(selT350Opposto.Lookup('CODICE',T1,'ORAFINE')));
      F1:=F1Ori;
      if F1 <= I1 then
        inc(F1,1440);
      if T2 <> '' then
      begin
        I2:=WR000DM.selT350.Lookup('CODICE',T2,'INIZIO');
        F2Ori:=WR000DM.selT350.Lookup('CODICE',T2,'FINE');
        F2:=F2Ori;
        if F2 <= I2 then
          inc(F2,1440);
        if ((I2 >= I1) and (I2 < F1)) or ((F2 > I1) and (F2 <= F1)) or
           ((I2 <= I1) and (F2 >= F1)) then
        begin
          ErrMessage:=ErrMessage +
                      'I turni si sovrappongono tra Reperibilità e Guardia in data ' +
                      DateToStr(DataRif) + CRLF +
                      Format('%s: %s: %s - %s',[Tipo1,T1,R180MinutiOre(I1),R180MinutiOre(F1Ori)]) + CRLF +
                      Format('%s: %s: %s - %s',[Tipo2,T2,R180MinutiOre(I2),R180MinutiOre(F2Ori)]) + CRLF;
          Abort;
        end;
      end;
    end;
  except
    ErrMessage:=ErrMessage +
                'In data ' + DateToStr(DataRif) + ' esistono pianificazioni di ' +
                'reperibilità/guardia configurate non correttamente.' + CRLF +
                'Vuoi continuare?' + CRLF;
    Exit;
  end;
end;

function TW004FReperibilita.RaggruppamentiAbilitati(Prog:Integer; DataRif:TDateTime): Boolean;
// Controllo se il dipendente ha delle causali di presenza adeguate abilitate in data
var i: Integer;
begin
  Result:=False;
  with W004DM.selT430Contratto do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',DataRif);
    Open;
  end;

  with TStringList.Create do
  try
    CommaText:=W004DM.selT430Contratto.FieldByName('AbPresenza1').AsString;
    for i:=0 to Count - 1 do
      if W004DM.selT270.Locate('Codice',Strings[i],[]) then
      begin
        Result:=True;
        Break;
      end;
  finally
    Free;
  end;
end;

function TW004FReperibilita.GiornataAssenza(Data:TDateTime; Progressivo: Integer): Boolean;
// Verifica se nel giorno corrente è presente una giornata di assenza
begin
  with W004DM.selT040Assenza do
  begin
    Close;
    SetVariable('Progressivo',Progressivo);
    SetVariable('Data',Data);
    Open;
    if RecordCount > 0 then
      ErrMessage:=ErrMessage +
                  'Nel giorno ' + DateToStr(Data) + ' è presente una giornata di assenza ' +
                  FieldByName('Causale').AsString + '.' + CRLF +
                  'Vuoi continuare?' + CRLF;
    Result:=(RecordCount > 0);
  end;
end;

// inizio flusso di controlli
procedure TW004FReperibilita.actInsVar1;
begin
  TurniIntersecati(T1, T2);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar2,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar2,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar2;
end;

procedure TW004FReperibilita.actInsVar2;
begin
  TurniIntersecati(T1, T3);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar3,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar3,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar3;
end;

procedure TW004FReperibilita.actInsVar3;
begin
  TurniIntersecati(T2, T3);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar4,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar4,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar4;
end;

procedure TW004FReperibilita.actInsVar4;
begin
  // verifica intersezione turni fra guardia e reperibilità
  with W004DM.selT380a do
  begin
    Close;
    SetVariable('PROGRESSIVO', Progressivo);
    SetVariable('DATA', Data);
    SetVariable('TIPOLOGIA', Tipologia);
    Open;
    if RecordCount > 0 then
    begin
      // prosegue con i controlli
      T1a:=FieldByName('TURNO1').AsString;
      T2a:=FieldByName('TURNO2').AsString;
      T3a:=FieldByName('TURNO3').AsString;
      actInsVar5;
    end
    else
    begin
      // esegue inserimento / variazione
      if Operazione = 'I' then
        actInserimentoOK
      else
        actVariazioneOK;
    end;
  end;
end;

procedure TW004FReperibilita.actInsVar5;
begin
  TurniIntersecatiTipologieDiverse(T1a, T1, Data);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar6,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar6,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar6;
end;

procedure TW004FReperibilita.actInsVar6;
begin
  TurniIntersecatiTipologieDiverse(T1a, T2, Data);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar7,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar7,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar7;
end;

procedure TW004FReperibilita.actInsVar7;
begin
  TurniIntersecatiTipologieDiverse(T1a, T3, Data);
  
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar8,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar8,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar8;
end;

procedure TW004FReperibilita.actInsVar8;
begin
  TurniIntersecatiTipologieDiverse(T2a, T1, Data);
  
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar9,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar9,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar9;
end;

procedure TW004FReperibilita.actInsVar9;
begin
  TurniIntersecatiTipologieDiverse(T2a, T2, Data);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar10,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar10,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar10;
end;

procedure TW004FReperibilita.actInsVar10;
begin
  TurniIntersecatiTipologieDiverse(T2a, T3, Data);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar11,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar11,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar11;
end;

procedure TW004FReperibilita.actInsVar11;
begin
  TurniIntersecatiTipologieDiverse(T3a, T1, Data);
  
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar12,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar12,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar12;
end;

procedure TW004FReperibilita.actInsVar12;
begin
  TurniIntersecatiTipologieDiverse(T3a, T2, Data);
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar13,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar13,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar13;
end;

procedure TW004FReperibilita.actInsVar13;
begin
  TurniIntersecatiTipologieDiverse(T3a, T3, Data);
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInserimentoOK,nil)
    else
      Messaggio('Conferma',ErrMessage,actVariazioneOK,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  if Operazione = 'I' then
    actInserimentoOK
  else
    actVariazioneOK;
end;

procedure TW004FReperibilita.actInserimentoOK;
// controlli ok -> inserimento record di pianificazione
begin
  if grdModifica <> grdReperibilita then
    W004DM.selT380.Delete;//Cancello il record fittizio precedentemente creato in W004FModificaTabelloneFM
  with W004DM.insT380 do
  begin
    ClearVariables;
    SetVariable('MATRICOLA',M);
    SetVariable('DATA',Data);
    SetVariable('TURNO1',T1);
    if P1 <> 0 then
      SetVariable('PRIORITA1',P1);
    SetVariable('TURNO2',T2);
    if P2 <> 0 then
      SetVariable('PRIORITA2',P2);
    SetVariable('TURNO3',T3);
    if P3 <> 0 then
      SetVariable('PRIORITA3',P3);
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      SetVariable('DATOLIBERO',DL);
    SetVariable('TIPOLOGIA',Tipologia);

    if Tipologia = 'R' then
    begin
      if DatoRecapito <> '' then
      begin
        if selAnagrafe.SearchRecord('MATRICOLA',M,[srFromBeginning]) then
          R180SetVariable(W004DM.QSDatiAgg,'PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        W004DM.QSDatiAgg.Open;
        if T1 <> '' then
          R1:=IfThen(R1 = '', W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString, R1);
        if T2 <> '' then
          R2:=IfThen(R2 = '', W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString, R2);
        if T3 <> '' then
          R3:=IfThen(R3 = '', W004DM.QSDatiAgg.FieldByName(DatoRecapito).AsString, R3);
      end;

      SetVariable('RECAPITO1',R1);
      SetVariable('RECAPITO2',R2);
      SetVariable('RECAPITO3',R3);

      // Dato aggiuntivo 1
      if (T1 <> '') and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') then
        if Da1T1 <> '' then
          SetVariable('DATOAGG1_T1',Da1T1)
        else
          SetVariable('DATOAGG1_T1',DatoIns1Ana);

      if (T2 <> '') and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') then
        if Da1T2 <> '' then
          SetVariable('DATOAGG1_T2',Da1T2)
        else
          SetVariable('DATOAGG1_T2',DatoIns1Ana);

      if (T3 <> '') and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') then
        if Da1T3 <> '' then
          SetVariable('DATOAGG1_T3',Da1T3)
        else
          SetVariable('DATOAGG1_T3',DatoIns1Ana);

      // Dato aggiuntivo 2
      if (T1 <> '') and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '') then
        if Da2T1 <> '' then
          SetVariable('DATOAGG2_T1',Da2T1)
        else
          SetVariable('DATOAGG2_T1',DatoIns2Ana);

      if (T2 <> '') and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '') then
        if Da2T2 <> '' then
          SetVariable('DATOAGG2_T2',Da2T2)
        else
          SetVariable('DATOAGG2_T2',DatoIns2Ana);

      if (T3 <> '') and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '') then
        if Da2T3 <> '' then
          SetVariable('DATOAGG2_T3',Da2T3)
        else
          SetVariable('DATOAGG2_T3',DatoIns2Ana);

      // Area squadra
      if (T1 <> '') then
        SetVariable('AREASQUADRA_T1',AsT1);
      if (T2 <> '') then
        SetVariable('AREASQUADRA_T2',AsT2);
      if (T3 <> '') then
        SetVariable('AREASQUADRA_T3',AsT3);
    end;

    try
      Execute;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox('Inserimento fallito: ' + CRLF + E.Message,ESCLAMA);
        Exit;
      end;
    end;
    RegistraLog.SettaProprieta('I','T380_PIANIFREPERIB',medpCodiceForm,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',GetVariable('PROGRESSIVO'));
    RegistraLog.InserisciDato('DATA','',DateToStr(Data));
    RegistraLog.InserisciDato('TURNO1','',T1);
    RegistraLog.InserisciDato('PRIORITA1','',IfThen(P1 = 0,'',IntToStr(P1)));
    RegistraLog.InserisciDato('TURNO2','',T2);
    RegistraLog.InserisciDato('PRIORITA2','',IfThen(P2 = 0,'',IntToStr(P2)));
    RegistraLog.InserisciDato('TURNO3','',T3);
    RegistraLog.InserisciDato('PRIORITA3','',IfThen(P3 = 0,'',IntToStr(P3)));
    // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
    RegistraLog.InserisciDato('RECAPITO1','','');
    RegistraLog.InserisciDato('RECAPITO2','','');
    RegistraLog.InserisciDato('RECAPITO3','','');
   // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine
    RegistraLog.InserisciDato('DATOAGG1_T1','','');
    RegistraLog.InserisciDato('DATOAGG1_T2','','');
    RegistraLog.InserisciDato('DATOAGG1_T3','','');
    RegistraLog.InserisciDato('DATOAGG2_T1','','');
    RegistraLog.InserisciDato('DATOAGG2_T2','','');
    RegistraLog.InserisciDato('DATOAGG2_T3','','');
    RegistraLog.InserisciDato('AREASQUADRA_T1','','');
    RegistraLog.InserisciDato('AREASQUADRA_T2','','');
    RegistraLog.InserisciDato('AREASQUADRA_T3','','');
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      RegistraLog.InserisciDato('DATOLIBERO','',DL);
    RegistraLog.InserisciDato('TIPOLOGIA','',Tipologia);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;

  // rilegge i dati
  //GetTurniPianificati;
  if (grdModifica <> grdReperibilita) and (W004FModTabFM <> nil) then
    W004FModTabFM.AfterInserimento
  else
    GetTurniPianificati;
end;

procedure TW004FReperibilita.actVariazioneOK;
// controlli ok -> variazione record di pianificazione
var ModDaTabellone:Boolean;
begin
  with W004DM.selT380 do
  begin
    Edit;
    FieldByName('DATA').AsDateTime:=Data;
    FieldByName('TURNO1').AsString:=T1;
    if P1 = 0 then
      FieldByName('PRIORITA1').AsVariant:=null
    else
      FieldByName('PRIORITA1').AsInteger:=P1;
    FieldByName('TURNO2').AsString:=T2;
    if P2 = 0 then
      FieldByName('PRIORITA2').AsVariant:=null
    else
      FieldByName('PRIORITA2').AsInteger:=P2;
    FieldByName('TURNO3').AsString:=T3;
    if P3 = 0 then
      FieldByName('PRIORITA3').AsVariant:=null
    else
      FieldByName('PRIORITA3').AsInteger:=P3;
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      FieldByName('DATOLIBERO').AsString:=DL;

    //Il tabellone non permette di modificare i recapiti e i dati aggiuntivi, perciò devo assicurarmi che rimangano invariati
    ModDaTabellone:=(grdModifica <> grdReperibilita) and (W004FModTabFM <> nil);
    if (Tipologia = 'R') and ModDaTabellone then
    begin
      OldRecapito1:=FieldByName('RECAPITO1').AsString;
      OldRecapito2:=FieldByName('RECAPITO2').AsString;
      OldRecapito3:=FieldByName('RECAPITO3').AsString;
      OldDatoAgg1T1:=FieldByName('DATOAGG1_T1').AsString;
      OldDatoAgg1T2:=FieldByName('DATOAGG1_T2').AsString;
      OldDatoAgg1T3:=FieldByName('DATOAGG1_T3').AsString;
      OldDatoAgg2T1:=FieldByName('DATOAGG2_T1').AsString;
      OldDatoAgg2T2:=FieldByName('DATOAGG2_T2').AsString;
      OldDatoAgg2T3:=FieldByName('DATOAGG2_T3').AsString;
      OldAreaSquadraT1:=FieldByName('AREASQUADRA_T1').AsString;
      OldAreaSquadraT2:=FieldByName('AREASQUADRA_T2').AsString;
      OldAreaSquadraT3:=FieldByName('AREASQUADRA_T3').AsString;
    end;

    // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
    // In caso di turni di guardia le modifiche dei recapiti sono inibite, per sicurezza
    // comunque scartiamo la modifiche.
    // Se in un momento successivo ho eliminato il turno, il recapito viene eliminato
    if Tipologia = 'R' then
    begin
      FieldByName('RECAPITO1').AsString:=IfThen(T1 <> '',IfThen(ModDaTabellone,OldRecapito1,cdsT380.FieldByName('RECAPITO1').AsString),'');
      FieldByName('RECAPITO2').AsString:=IfThen(T2 <> '',IfThen(ModDaTabellone,OldRecapito2,cdsT380.FieldByName('RECAPITO2').AsString),'');
      FieldByName('RECAPITO3').AsString:=IfThen(T3 <> '',IfThen(ModDaTabellone,OldRecapito3,cdsT380.FieldByName('RECAPITO3').AsString),'');
      FieldByName('DATOAGG1_T1').AsString:=IfThen(T1 <> '',IfThen(ModDaTabellone,OldDatoAgg1T1,cdsT380.FieldByName('DATOAGG1_T1').AsString),'');
      FieldByName('DATOAGG1_T2').AsString:=IfThen(T2 <> '',IfThen(ModDaTabellone,OldDatoAgg1T2,cdsT380.FieldByName('DATOAGG1_T2').AsString),'');
      FieldByName('DATOAGG1_T3').AsString:=IfThen(T3 <> '',IfThen(ModDaTabellone,OldDatoAgg1T3,cdsT380.FieldByName('DATOAGG1_T3').AsString),'');
      FieldByName('DATOAGG2_T1').AsString:=IfThen(T1 <> '',IfThen(ModDaTabellone,OldDatoAgg2T1,cdsT380.FieldByName('DATOAGG2_T1').AsString),'');
      FieldByName('DATOAGG2_T2').AsString:=IfThen(T2 <> '',IfThen(ModDaTabellone,OldDatoAgg2T2,cdsT380.FieldByName('DATOAGG2_T2').AsString),'');
      FieldByName('DATOAGG2_T3').AsString:=IfThen(T3 <> '',IfThen(ModDaTabellone,OldDatoAgg2T3,cdsT380.FieldByName('DATOAGG2_T3').AsString),'');
      FieldByName('AREASQUADRA_T1').AsString:=IfThen(T1 <> '',IfThen(ModDaTabellone,OldAreaSquadraT1,cdsT380.FieldByName('AREASQUADRA_T1').AsString),'');
      FieldByName('AREASQUADRA_T2').AsString:=IfThen(T2 <> '',IfThen(ModDaTabellone,OldAreaSquadraT2,cdsT380.FieldByName('AREASQUADRA_T2').AsString),'');
      FieldByName('AREASQUADRA_T3').AsString:=IfThen(T3 <> '',IfThen(ModDaTabellone,OldAreaSquadraT3,cdsT380.FieldByName('AREASQUADRA_T3').AsString),'');
    end;
    // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine

    try
      Post;
      RegistraLog.SettaProprieta('M','T380_PIANIFREPERIB',medpCodiceForm,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO',FieldByName('PROGRESSIVO').AsString,FieldByName('PROGRESSIVO').AsString);
      RegistraLog.InserisciDato('DATA',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'DATA')),FieldByName('DATA').AsString);
      RegistraLog.InserisciDato('TURNO1',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'TURNO1')),FieldByName('TURNO1').AsString);
      RegistraLog.InserisciDato('PRIORITA1',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'PRIORITA1')),FieldByName('PRIORITA1').AsString);
      RegistraLog.InserisciDato('TURNO2',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'TURNO2')),FieldByName('TURNO2').AsString);
      RegistraLog.InserisciDato('PRIORITA2',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'PRIORITA2')),FieldByName('PRIORITA2').AsString);
      RegistraLog.InserisciDato('TURNO3',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'TURNO3')),FieldByName('TURNO3').AsString);
      RegistraLog.InserisciDato('PRIORITA3',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'PRIORITA3')),FieldByName('PRIORITA3').AsString);
      // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.ini
      // Vedi sopra
      if Tipologia = 'R' then
      begin
        RegistraLog.InserisciDato('RECAPITO1',OldRecapito1,FieldByName('RECAPITO1').AsString);
        RegistraLog.InserisciDato('RECAPITO2',OldRecapito2,FieldByName('RECAPITO2').AsString);
        RegistraLog.InserisciDato('RECAPITO3',OldRecapito3,FieldByName('RECAPITO3').AsString);
        RegistraLog.InserisciDato('DATOAGG1_T1',OldDatoAgg1T1,FieldByName('DATOAGG1_T1').AsString);
        RegistraLog.InserisciDato('DATOAGG1_T2',OldDatoAgg1T2,FieldByName('DATOAGG1_T2').AsString);
        RegistraLog.InserisciDato('DATOAGG1_T3',OldDatoAgg1T3,FieldByName('DATOAGG1_T3').AsString);
        RegistraLog.InserisciDato('DATOAGG2_T1',OldDatoAgg2T1,FieldByName('DATOAGG2_T1').AsString);
        RegistraLog.InserisciDato('DATOAGG2_T2',OldDatoAgg2T2,FieldByName('DATOAGG2_T2').AsString);
        RegistraLog.InserisciDato('DATOAGG2_T3',OldDatoAgg2T3,FieldByName('DATOAGG2_T3').AsString);
        RegistraLog.InserisciDato('AREASQUADRA_T1',OldDatoAgg2T1,FieldByName('AREASQUADRA_T1').AsString);
        RegistraLog.InserisciDato('AREASQUADRA_T2',OldDatoAgg2T2,FieldByName('AREASQUADRA_T2').AsString);
        RegistraLog.InserisciDato('AREASQUADRA_T3',OldDatoAgg2T3,FieldByName('AREASQUADRA_T3').AsString);
      end;
       // IMPERIA_ASL1 - commessa 2017/152 - SVILUPPO#1.fine
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
        RegistraLog.InserisciDato('DATOLIBERO',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'DATOLIBERO')),FieldByName('DATOLIBERO').AsString);
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        RegistraLog.AnnullaOperazione;
        SessioneOracle.Commit;
        MsgBox.MessageBox('Variazione fallita: ' + CRLF + E.Message,ESCLAMA);
      end;
    end;
  end;
  // rilegge i dati
  //GetTurniPianificati;
  if (grdModifica <> grdReperibilita) and (W004FModTabFM <> nil) then
    W004FModTabFM.AfterModifica
  else
    GetTurniPianificati;
end;

function TW004FReperibilita.ModificheRiga(const FN: String): Boolean;
// Restituisce True/False a seconda che il record sia stato modificato o meno
var
  i:Integer;
  IWCmb: TmeIWComboBox;
begin
  Result:=False;
  if not cdsT380.Locate('DBG_ROWID',FN,[]) then
    exit;

  with grdReperibilita do
  begin
    i:=medpRigaDiCompGriglia(FN);
    Result:=(cdsT380.FieldByName('DATA').AsString <> (medpCompCella(i,'DATA',0) as TmeIWEdit).Text) or
            (cdsT380.FieldByName('TURNO1').AsString <> (medpCompCella(i,'C_TURNO1',0) as TMedpIWMultiColumnComboBox).Text) or
            (cdsT380.FieldByName('PRIORITA1').AsString <> (medpCompCella(i,'PRIORITA1',0) as TmeIWEdit).Text) or
            (cdsT380.FieldByName('TURNO2').AsString <> (medpCompCella(i,'C_TURNO2',0) as TMedpIWMultiColumnComboBox).Text) or
            (cdsT380.FieldByName('PRIORITA2').AsString <> (medpCompCella(i,'PRIORITA2',0) as TmeIWEdit).Text) or
            (cdsT380.FieldByName('TURNO3').AsString <> (medpCompCella(i,'C_TURNO3',0) as TMedpIWMultiColumnComboBox).Text) or
            (cdsT380.FieldByName('PRIORITA3').AsString <> (medpCompCella(i,'PRIORITA3',0) as TmeIWEdit).Text) or
            (OldRecapito1 <> cdsT380.FieldByName('RECAPITO1').AsString) or
            (OldRecapito2 <> cdsT380.FieldByName('RECAPITO2').AsString) or
            (OldRecapito3 <> cdsT380.FieldByName('RECAPITO3').AsString) or
            (OldDatoAgg1T1 <> cdsT380.FieldByName('DATOAGG1_T1').AsString) or
            (OldDatoAgg1T2 <> cdsT380.FieldByName('DATOAGG1_T2').AsString) or
            (OldDatoAgg1T3 <> cdsT380.FieldByName('DATOAGG1_T3').AsString) or
            (OldDatoAgg2T1 <> cdsT380.FieldByName('DATOAGG2_T1').AsString) or
            (OldDatoAgg2T2 <> cdsT380.FieldByName('DATOAGG2_T2').AsString) or
            (OldDatoAgg2T3 <> cdsT380.FieldByName('DATOAGG2_T3').AsString) or
            (OldAreaSquadraT1 <> cdsT380.FieldByName('AREASQUADRA_T1').AsString) or
            (OldAreaSquadraT2 <> cdsT380.FieldByName('AREASQUADRA_T2').AsString) or
            (OldAreaSquadraT3 <> cdsT380.FieldByName('AREASQUADRA_T3').AsString);
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      IWCmb:=(medpCompCella(i,'DATOLIBERO',0) as TmeIWComboBox);
      Result:=Result or (cdsT380.FieldByName('DATOLIBERO').AsString <> IWCmb.Items.ValueFromIndex[IWCmb.ItemIndex]);
    end;
  end;
end;

function TW004FReperibilita.ControlliOK(const FN:String): Boolean;
var
  i: Integer;
  IWC: TIWCustomControl;
  Stato: TDataSetState;
  RI: String;
  function CheckTurno(LCB:TIWCustomControl):Boolean;
  var T:String;
  begin
    Result:=True;
    T:=(LCB as TMedpIWMultiColumnComboBox).Text;
    if (T <> '') and (VarToStr(WR000DM.selT350.Lookup('CODICE',T,'CODICE')) = '') then
    begin
      Result:=False;
      MsgBox.MessageBox(Format(A000MSG_ERR_FMT_NON_ESISTENTE + ' (%s)',['Turno',T]),INFORMA);
      ActiveControl:=LCB;
    end;
  end;
begin
  Result:=False;
  ErrMessage:='';
  WR000DM.selDatiBloccati.Close;

  Dal:=StrToDate(edtPeriodoDal.Text);
  Al:=StrToDate(edtPeriodoAl.Text);

  Operazione:=IfThen(FN = '*','I','M');//utile per il richiamo da W004UModificaTabelloneFM e compatibile con gestione standard
  if Operazione = 'I' then
  begin
    // imposta i dati per l'inserimento
    // matricola
    M:=Trim((grdModifica.medpCompCella(0,'MATRICOLA',0) as TMedpIWMultiColumnComboBox).Text);

    // data
    IWC:=grdModifica.medpCompCella(0,'DATA',0);
    if not TryStrToDate((IWC as TmeIWEdit).Text,Data) then
    begin
      MsgBox.MessageBox('La data specificata è errata!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // turno 1 e priorità
    T1:=(grdModifica.medpCompCella(0,'C_TURNO1',0) as TMedpIWMultiColumnComboBox).Text;
    if not CheckTurno(grdModifica.medpCompCella(0,'C_TURNO1',0)) then
      exit;
    IWC:=grdModifica.medpCompCella(0,'PRIORITA1',0);
    if (IWC as TmeIWEdit).Text = '' then
      P1:=0
    else if not TryStrToInt((IWC as TmeIWEdit).Text,P1) then
    begin
      MsgBox.MessageBox('La priorità di chiamata del turno 1 deve essere compresa fra 1 e 9!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end
    else if P1 <= 0 then
    begin
      MsgBox.MessageBox('La priorità di chiamata del turno 1 deve essere compresa fra 1 e 9!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // turno 2 e priorità
    T2:=(grdModifica.medpCompCella(0,'C_TURNO2',0) as TMedpIWMultiColumnComboBox).Text;
    if T2 <> '' then
    begin
      if not CheckTurno(grdModifica.medpCompCella(0,'C_TURNO2',0)) then
        exit;
      IWC:=grdModifica.medpCompCella(0,'PRIORITA2',0);
      if (IWC as TmeIWEdit).Text = '' then
        P2:=0
      else if not TryStrToInt((IWC as TmeIWEdit).Text,P2) then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 2 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end
      else if P2 <= 0 then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 2 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
    begin
      P2:=0;
      R2:='';
    end;

    // turno 3 e priorità
    T3:=(grdModifica.medpCompCella(0,'C_TURNO3',0) as TMedpIWMultiColumnComboBox).Text;
    if T3 <> '' then
    begin
      if not CheckTurno(grdModifica.medpCompCella(0,'C_TURNO3',0)) then
        exit;
      IWC:=grdModifica.medpCompCella(0,'PRIORITA3',0);
      if (IWC as TmeIWEdit).Text = '' then
        P3:=0
      else if not TryStrToInt((IWC as TmeIWEdit).Text,P3) then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 3 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end
      else if P3 <= 0 then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 3 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
    begin
      P3:=0;
      R3:='';
    end;

    // dato libero
    DL:='';
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      IWC:=grdModifica.medpCompCella(0,'DATOLIBERO',0);
      DL:=Trim((IWC as TmeIWComboBox).Items.ValueFromIndex[(IWC as TmeIWComboBox).ItemIndex]);
    end;
  end
  else
  begin
    // imposta i dati per la variazione
    i:=grdModifica.medpRigaDiCompGriglia(FN);
    M:=VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',FN,'MATRICOLA'));

    // data
    IWC:=grdModifica.medpCompCella(i,'DATA',0);
    if not TryStrToDate((IWC as TmeIWEdit).Text,Data) then
    begin
      MsgBox.MessageBox('La data specificata è errata!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // turno 1
    T1:=(grdModifica.medpCompCella(i,'C_TURNO1',0) as TMedpIWMultiColumnComboBox).Text;
    if not CheckTurno(grdModifica.medpCompCella(i,'C_TURNO1',0)) then
      exit;
    IWC:=grdModifica.medpCompCella(i,'PRIORITA1',0);
    if (IWC as TmeIWEdit).Text = '' then
      P1:=0
    else if not TryStrToInt((IWC as TmeIWEdit).Text,P1) then
    begin
      MsgBox.MessageBox('La priorità di chiamata del turno 1 deve essere compresa fra 1 e 9!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end
    else if P1 <= 0 then
    begin
      MsgBox.MessageBox('La priorità di chiamata del turno 1 deve essere compresa fra 1 e 9!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // turno 2
    T2:=(grdModifica.medpCompCella(i,'C_TURNO2',0) as TMedpIWMultiColumnComboBox).Text;
    if T2 <> '' then
    begin
      if not CheckTurno(grdModifica.medpCompCella(i,'C_TURNO2',0)) then
        exit;
      IWC:=grdModifica.medpCompCella(i,'PRIORITA2',0);
      if (IWC as TmeIWEdit).Text = '' then
        P2:=0
      else if not TryStrToInt((IWC as TmeIWEdit).Text,P2) then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 2 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end
      else if P2 <= 0 then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 2 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
      P2:=0;

    // turno 3
    T3:=(grdModifica.medpCompCella(i,'C_TURNO3',0) as TMedpIWMultiColumnComboBox).Text;
    if T3 <> '' then
    begin
      if not CheckTurno(grdModifica.medpCompCella(i,'C_TURNO3',0)) then
        exit;
      IWC:=grdModifica.medpCompCella(i,'PRIORITA3',0);
      if (IWC as TmeIWEdit).Text = '' then
        P3:=0
      else if not TryStrToInt((IWC as TmeIWEdit).Text,P3) then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 3 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end
      else if P3 <= 0 then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 3 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
      P3:=0;

    // dato libero
    DL:='';
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      IWC:=grdModifica.medpCompCella(i,'DATOLIBERO',0);
      DL:=Trim((IWC as TmeIWComboBox).Items.ValueFromIndex[(IWC as TmeIWComboBox).ItemIndex])
    end;
  end;

  if (Data < Dal) or (Data > Al) then
  begin
    MsgBox.MessageBox('La data è esterna al periodo specificato!',INFORMA);
    Exit;
  end;
  if M = '' then
  begin
    MsgBox.MessageBox('Specificare la matricola del dipendente!',INFORMA);
    Exit;
  end;
  if T1 = '' then
  begin
    MsgBox.MessageBox('Specificare il turno 1!',INFORMA);
    Exit;
  end;
  with selAnagrafe do
  begin
    SetVariable('DATALAVORO',Data);
    if not SearchRecord('MATRICOLA',M,[srFromBeginning]) then
    begin
      MsgBox.MessageBox('La matricola indicata non è valida!',INFORMA);
      Exit;
    end;
    Progressivo:=FieldByName('PROGRESSIVO').AsInteger;
  end;
  // verifiche sulla base dati
  with WR000DM do
  begin
    // controllo raggruppamenti abilitati
    if not RaggruppamentiAbilitati(Progressivo, Data) then
    begin
      MsgBox.MessageBox('Il dipendente non ha raggruppamenti di ' +
                        IfThen(Tipologia = 'R','reperibilità','guardia') +
                        ' abilitati in data ' + DateToStr(Data) + '!',INFORMA);
      Exit;
    end;
    // verifica dato bloccato
    if WR000DM.selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(Data),'T380') then
    begin
      MsgBox.MessageBox(IfThen(Operazione = 'I','Inserimento non consentito!','Variazione non consentita!') + CRLF +
                        'Motivo: ' + WR000DM.selDatiBloccati.MessaggioLog,INFORMA);
      Exit;
    end;
    // verifica turno ripetuto
    if (T1 = T2) or
       ((T1 <> '') and (T1 = T3)) or
       ((T2 <> '') and (T2 = T3)) then
    begin
      MsgBox.MessageBox(A000MSG_A040_ERR_TURNO_RIPETUTO,INFORMA);
      Exit;
    end;
    // errore se turno 3 inserito ma turno 2 vuoto
    if (T2 = '') and (T3 <> '') then
    begin
      MsgBox.MessageBox(A000MSG_A040_ERR_NO_TURNO_2,INFORMA);
      Exit;
    end;

    // verifica pianificazione già esistente (in base a inserimento / variazione)
    if Operazione = 'I' then
    begin
      if grdModifica = grdReperibilita then
      begin
        Stato:=dsInsert;
        RI:='';
      end
      else //In W004FModificaTabelloneFM creo già un record fittizio sulla tabella
      begin
        Stato:=dsEdit;
        RI:=W004DM.selT380.RowId;
      end;
      if QueryPK1.EsisteChiave('T380_PIANIFREPERIB',RI,Stato,['PROGRESSIVO','DATA','TIPOLOGIA'],[IntToStr(Progressivo),DateToStr(Data),Tipologia]) then
      begin
        MsgBox.MessageBox(A000MSG_A040_ERR_ESISTE_PIANIFICAZIONE,INFORMA);
        Exit;
      end
    end
    else
    begin
      if QueryPK1.EsisteChiave('T380_PIANIFREPERIB',W004DM.selT380.RowId,dsEdit,['PROGRESSIVO','DATA','TIPOLOGIA'],[IntToStr(Progressivo),DateToStr(Data),Tipologia]) then
      begin
        MsgBox.MessageBox(A000MSG_A040_ERR_ESISTE_PIANIFICAZIONE,INFORMA);
        Exit;
      end
    end;
  end;
  Result:=True;
end;

procedure TW004FReperibilita.imgConfermaInserimentoClick(Sender: TObject);
begin
  try
    Inserimento;
  finally
    //Riporta alla selezione del dipendente corretta
    cmbDipendentiDisponibiliChange(nil);
  end;
end;

procedure TW004FReperibilita.Inserimento;
begin
  W004DM.A040MW.ProceduraChiamante:=4;
  W004DM.A040MW.PulisciVariabili;
  W004DM.A040MW.evtTurnoNonInserito:=nil;

  // controlli bloccanti sui dati
  if not ControlliOK('*') then
    Exit;

  W004DM.A040MW.T380FiltraSelAnagrafe:=chkSoloSelAnagrafe.Checked;
  W004DM.A040MW.DataInizio:=R180InizioMese(Dal);
  W004DM.A040MW.DataFine:=R180FineMese(Al);

  //Controllo limite mensile turni
  W004DM.A040MW.CodTipologia:=ifThen(rgpTipologia.ItemIndex = 0,'R','G');
  W004DM.A040MW.VerificaLimiteMese([T1,T2,T3],Data,W004DM.selT380.State,W004DM.selT380.Rowid,Progressivo);
  //Bruno: 22/02/2017
  //Procedura d'inserimento reperibilità singolo dipendente
  //Richiamata anche nel ResultEvtRichiesta del datamodulo al numero di procedura chiamante 4
  //   PS: Che Dio mi perdoni!
  InserimentoSingolo;
end;

procedure TW004FReperibilita.InserimentoSingolo;
begin
  // verifica se nella data è già indicata un'assenza
  try
    if (GiornataAssenza(Data, Progressivo)) or
       ((not chkNonContDipPian.Checked)) and
        (not W004DM.A040MW.TurnoNonInserito(T1,T2,T3,Data,Progressivo,ErrMessage)) then
    begin
      ErrMessage:='Attenzione!' + CRLF + ErrMessage;
      Messaggio('Conferma',ErrMessage,actInsVar1,nil);
      ErrMessage:='';
      Exit;
    end;
  finally
    W004DM.A040MW.evtTurnoNonInserito:=W004DM.evtTurnoNonInserito;
  end;

  //W004DM.A040MW.TurnoNonInserito(T1,T2,T3,Data,Progressivo);
  if MsgBox.IsActive then
    Exit;
  actInsVar0;
end;

procedure TW004FReperibilita.actInsVar0;
begin
  // controllo vincoli individuali
  with W004DM do
  begin
    R180SetVariable(selT385,'PROGRESSIVO',Progressivo);
    R180SetVariable(selT385,'TIPO',Tipologia);
    R180SetVariable(selT385,'DATA',Data);
    selT385.Open;
    selT385.First;
    ErrMessage:='';
    ErrBloccante:=False;
    //while (not selT385.Eof) and (not ErrBloccante) do
    begin
      ControlloVincoliIndividuali(T1);
      if not ErrBloccante then
        ControlloVincoliIndividuali(T2);
      if not ErrBloccante then
        ControlloVincoliIndividuali(T3);
      //selT385.Next;
    end;
  end;
  if ErrBloccante then
  begin
    MsgBox.MessageBox(ErrMessage,INFORMA);
    Exit;
  end
  else if ErrMessage <> '' then
  begin
    Messaggio('Conferma',ErrMessage + CRLF + 'Continuare?',actInsVar1,nil);
    ErrMessage:='';
    Exit;
  end;
  if MsgBox.IsActive then
    Exit;
  actInsVar1;
end;

procedure TW004FReperibilita.ControlloVincoliIndividuali(TurnoVincoli:String);
var Messaggio:String;
begin
  if Trim(TurnoVincoli) = '' then
    Exit;
  //Priorità: FS/PF - (1..7) - *
  //se il giorno del vincolo è FS e la data pianif. è un festivo
  with W004DM do
  begin
    if (selT385.SearchRecord('GIORNO','FS',[srFromBeginning])) and
       (selT385.FieldByName('DTFESTIVO').AsString = 'S') then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + TurnoVincoli + ' non è disponibile nei vincoli di pianificazione dei giorni festivi';
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
          ErrBloccante:=True;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
      exit;
    end;
    //se il giorno del vincolo è PF e la data pianif. è un prefestivo
    if (selT385.SearchRecord('GIORNO','PF',[srFromBeginning])) and
       (selT385.FieldByName('DTPREFESTIVO').AsString = 'S') then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + TurnoVincoli + ' non è disponibile nei vincoli di pianificazione dei giorni prefestivi';
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
          ErrBloccante:=True;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
      exit;
    end;
    //se il giorno del vincolo è uguale al giorno della data pianif.
    if selT385.SearchRecord('GIORNO',DayOfWeek(selT385.GetVariable('DATA') - 1),[srFromBeginning]) then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + TurnoVincoli + ' non è disponibile nei vincoli di pianificazione del ' + R180NomeGiorno(StrToDate(VarToStr(selT385.GetVariable('DATA'))));
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
          ErrBloccante:=True;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
      exit;
    end;
    //se il giorno del vincolo è Tutti
    if selT385.SearchRecord('GIORNO','*',[srFromBeginning]) then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + TurnoVincoli + ' non è disponibile nei vincoli di pianificazione generali!';
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
          ErrBloccante:=True;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
    end;
  end;
end;

procedure TW004FReperibilita.lnkDipendentiDisponibiliClick(Sender: TObject);
var
  Matricola:String;
begin
  Matricola:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
  WC002FDatiAnagraficiFM:=TWC002FDatiAnagraficiFM.Create(Self);
  WC002FDatiAnagraficiFM.ParMatricola:=Matricola;
  WC002FDatiAnagraficiFM.AllowClick:=True;
  WC002FDatiAnagraficiFM.VisualizzaScheda;
end;

procedure TW004FReperibilita.lnkLegendaColoriGiorniClick(Sender: TObject);
begin
  W004FLegendaColoriFM:=TW004FLegendaColoriFM.Create(Self);
end;

procedure TW004FReperibilita.rgpNumTurniClick(Sender: TObject);
begin
  btnEseguiClick(Sender);
end;

procedure TW004FReperibilita.rgpTipologiaClick(Sender: TObject);
var
  S, Elementi: String;
begin
  Tipologia:=IfThen(rgpTipologia.ItemIndex = 0,'R','G');
  //Gestione mesile
  W004DM.A040MW.CodTipologia:=Tipologia;
  W004DM.A040MW.ImpostaTipologiaDataSet;
  cmbTurno1.Text:='';
  cmbTurno2.Text:='';
  cmbTurno3.Text:='';
  C190CaricaMepdMulticolumnComboBox(cmbTurno1,W004DM.A040MW.Q350,'CODICE','DESCRIZIONE');
  C190CaricaMepdMulticolumnComboBox(cmbTurno2,W004DM.A040MW.Q350,'CODICE','DESCRIZIONE');
  C190CaricaMepdMulticolumnComboBox(cmbTurno3,W004DM.A040MW.Q350,'CODICE','DESCRIZIONE');
  lblPriorita.Visible:=Tipologia = 'R';
  edtPriorita1.Visible:=Tipologia = 'R';
  edtPriorita2.Visible:=Tipologia = 'R';
  edtPriorita3.Visible:=Tipologia = 'R';
  edtPriorita1.Enabled:=edtPriorita1.Visible and (cmbTurno1.Text <> '');
  edtPriorita2.Enabled:=edtPriorita2.Visible and (cmbTurno2.Text <> '');
  edtPriorita3.Enabled:=edtPriorita3.Visible and (cmbTurno3.Text <> '');
  edtRecapito1.Visible:=edtPriorita1.Visible;
  edtRecapito2.Visible:=edtPriorita2.Visible;
  edtRecapito3.Visible:=edtPriorita3.Visible;
  edtRecapito1.Enabled:=edtRecapito1.Visible and (cmbTurno1.Text <> '');
  edtRecapito2.Enabled:=edtRecapito2.Visible and (cmbTurno2.Text <> '');
  edtRecapito3.Enabled:=edtRecapito3.Visible and (cmbTurno3.Text <> '');
  edtPriorita1.Text:='';
  edtPriorita2.Text:='';
  edtPriorita3.Text:='';

  lstTurniDisponibili.Clear;
  //lstTurniDisponibili.Add(';');
  // raggruppamenti presenze
  with W004DM.selT270 do
  begin
    Close;
    if Tipologia = 'R' then
      SetVariable('CODINTERNO','C')
    else if Tipologia = 'G' then
      SetVariable('CODINTERNO','D');
    Open;
  end;

  // inizializzazione turni disponibili
  Elementi:='';
  with WR000DM.selT350 do
  begin
    Close;
    SetVariable('TIPOLOGIA',Tipologia);
    Filtered:=True;
    Open;
    First;
    while not Eof do
    begin
      S:=StringReplace(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]);
      lstTurniDisponibili.Add(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Filtered:=False;
  end;

  with W004DM.selT350Opposto do
  begin
    Close;
    SetVariable('TIPOLOGIA',Tipologia);
    Open;
  end;

  btnEseguiClick(Sender);
end;

procedure TW004FReperibilita.rgpVisTurnoOrarioClick(Sender: TObject);
begin
  inherited;
  btnEseguiClick(Sender);
end;

procedure TW004FReperibilita.Selezionatutto1GiorniClick(Sender: TObject);
var
  i:Integer;
begin
  with (pmnAzioniGiorni.PopupComponent as TmeTIWCheckListBox) do
  begin
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1Giorni then
        Selected[i]:=True
      else if Sender = DeselezionaTutto1Giorni then
        Selected[i]:=False
      else if Sender = InvertiSelezione1Giorni then
        Selected[i]:=not Selected[i];
  end;
end;

procedure TW004FReperibilita.tabReperibilitaTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if tabReperibilita.ActiveTab <> nil then
    OldTabIndex:=tabReperibilita.ActiveTabIndex;
end;

procedure TW004FReperibilita.tabReperibilitaTabControlChange(Sender: TObject);
begin
  if OldTabIndex <> tabReperibilita.ActiveTabIndex then
  begin
    if tabReperibilita.ActiveTab = W004DettaglioRG then
      CaricaTurniDettaglio
    else if tabReperibilita.ActiveTab = W004ProspettoRG then
      CaricaTurniTabellone
    else if tabReperibilita.ActiveTab = W004GestioneMensileRG then
      IniGestMensile
    else if tabReperibilita.ActiveTab = WA040Stm then
    begin
      W004DM.A040MW.DataSt:=R180InizioMese(Dal);
      WA040Stm.Visualizza;
    end;
    Operazione:='';
  end;
end;

procedure TW004FReperibilita.DistruggiOggetti;
// distrugge componenti creati dinamicamente
begin
  FreeAndNil(C004FParamFormPrv);
  FreeAndNil(C004DM_1);
  FreeAndNil(WA040Stm);
  FreeAndNil(W004DM);
  FreeAndNil(W002ModDatiDM);
  if selAnagrafe <> nil then
    FreeAndNil(selAnagrafe);
  FreeAndNil(lstDatoLibero);
  FreeAndNil(lstTurniDisponibili);

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT350);
  end;
end;

procedure TW004FReperibilita.OnTabChanging(var AllowChange: Boolean; var Conferma: String);
begin
  if Operazione <> '' then
    Conferma:='Attenzione! La pianificazione in fase di ' + IfThen(Operazione = 'I','inserimento','modifica') + ' non è stata confermata.' + CRLF +
              'Vuoi continuare?';
end;

procedure TW004FReperibilita.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  if Operazione <> '' then
    Conferma:='Attenzione! La pianificazione in fase di ' + IfThen(Operazione = 'I','inserimento','modifica') + ' non è stata confermata.' + CRLF +
              'Uscire comunque dalla funzione?';
end;

function TW004FReperibilita.GetProgressivo:Integer;
// il progressivo attuale è quello di selAnagrafe
begin
  Result:=-1;
  if selAnagrafe <> nil then
  begin
    try
      if selAnagrafe.Active and (selAnagrafe.RecordCount > 0) then
        //Result:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        Result:=selAnagrafe.Lookup('MATRICOLA',cmbDipendentiDisponibili.Items[cmbDipendentiDisponibili.ItemIndex].Substring(0,8).Trim,'PROGRESSIVO');
    except
    end;
  end;
end;

function TW004FReperibilita.GetInfoFunzione: String;
begin
  Result:='';
  if selAnagrafe <> nil then
  begin
    try
      with selAnagrafe do
      begin
        if Active and (selAnagrafe.RecordCount > 0) then
          Result:=Format('%s: %s<br>%s: %s %s',
                         [A000TraduzioneStringhe(A000MSG_MSG_MATRICOLA),
                          FieldByName('MATRICOLA').AsString,
                          A000TraduzioneStringhe(A000MSG_MSG_NOMINATIVO),
                          FieldByName('COGNOME').AsString,
                          FieldByName('NOME').AsString]);
      end;
    except
    end;
  end;
end;

procedure TW004FReperibilita.EseguiStampa;
begin
  W004DM.A040MW.PulisciVariabili;
  CallDCOMPrinter;
end;

procedure TW004FReperibilita.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  try
    //Chiamo Servizio COM B028 per creare il pdf su server
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
    DatiUtente:=WA040Stm.CreateJSonString;
    if (not IsLibrary) and
       (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
      CoInitialize(nil);
    if not DCOMConnection1.Connected then
      DCOMConnection1.Connected:=True;
    try
      A000SessioneWEB.AnnullaTimeOut;
      DCOMConnection1.AppServer.PrintA040(selAnagrafe.SubstitutedSQL,
                                          DCOMNomeFile,
                                          Parametri.Operatore,
                                          Parametri.Azienda,
                                          WR000DM.selAnagrafe.Session.LogonDataBase,
                                          DatiUtente,
                                          DettaglioLog);
    finally
      DCOMConnection1.Connected:=False;
      A000SessioneWEB.RipristinaTimeOut;
    end;
    if FileExists(DCOMNomeFile) then
    begin
      if DettaglioLog <> '' then
        R180MessageBox(DettaglioLog,ESCLAMA);
      VisualizzaFile(DCOMNomeFile,WA040Stm.edtTitolo.Text,nil,nil)
    end
    else
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W004_ERR_TAB_NON_COMPATIBILE));
  except
    on E:Exception do
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W004_FMT_STAMPA_NON_DISPONIB),[E.message]));
  end;
end;

end.
