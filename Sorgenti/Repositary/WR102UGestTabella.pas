unit WR102UGestTabella;

interface

uses
  A000UInterfaccia,
  WC003URicercaDatiFM, WC004UEstrazioneDatiFM,
  WR100UBase, WR204UBrowseTabellaFM, WR205UDettTabellaFM,
  WR302UGestTabellaDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs,
  IWAppForm, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, Oracle, OracleData, Db, meIWLabel, IWDBStdCtrls,
  IWVCLBaseContainer, IWContainer,
  IWCompEdit, meIWGrid, meIWLink,
  ActnList, IWCompListbox,
  meIWComboBox, meIWCheckBox, medpIWTabControl, meIWEdit, meIWImageFile,
  medpIWDBGrid, medpIWStatusBar, meIWDBEdit, medpIWMessageDlg, medpIWC700NavigatorBar,
  WC009UCopiaSuFM,
  A000UCostanti, A000USessione, A000UMessaggi, Math, StrUtils, IWCompGrids,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton,
  System.Actions, meIWImage,WR207UMenuWebPJFM;

type
  TEvOnStateChange = procedure (Sender: TObject) of object;
  TEvDataset = procedure (DataSet: TDataSet) of object;

  TWR102FGestTabella = class(TWR100FBase)
    lblNumRecord: TmeIWLabel;
    lblAnag: TmeIWLabel;
    lblMessaggio: TmeIWLabel;
    actlstNavigatorBar: TActionList;
    actPrimo: TAction;
    actPrecedente: TAction;
    grdNavigatorBar: TmeIWGrid;
    actModifica: TAction;
    actConferma: TAction;
    actAnnulla: TAction;
    actRicerca: TAction;
    actSuccessivo: TAction;
    actUltimo: TAction;
    actNuovo: TAction;
    actElimina: TAction;
    actAggiorna: TAction;
    actEstrai: TAction;
    actCopiaSu: TAction;
    actPrecedenteStorico: TAction;
    actSuccessivoStorico: TAction;
    actSelezioneStorico: TAction;
    grdTabControl: TmedpIWTabControl;
    grdToolBarStorico: TmeIWGrid;
    actVisioneCorrente: TAction;
    actVisioneAnnuale: TAction;
    CheckRelazioni: TOracleQuery;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure actPrimoExecute(Sender: TObject);
    procedure actPrecedenteExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);virtual;
    procedure actRicercaExecute(Sender: TObject);
    procedure actSuccessivoExecute(Sender: TObject);
    procedure actUltimoExecute(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);virtual;
    procedure actAnnullaExecute(Sender: TObject);virtual;
    procedure actConfermaExecute(Sender: TObject);virtual;
    procedure actEstraiExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);virtual;
    procedure actVisioneCorrenteExecute(Sender: TObject);
    procedure actPrecedenteStoricoExecute(Sender: TObject);
    procedure actSuccessivoStoricoExecute(Sender: TObject);
    procedure actVisioneAnnualeExecute(Sender: TObject);
    procedure actCopiaSuExecute(Sender: TObject);
    procedure grdTabControlTabControlChange(Sender: TObject);
    procedure TemplateProcessorBeforeProcess(var VTemplate: TStream);
  private
    SQLOriginale:String;
    // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
    FTabBrowseCaption: String;
    FTabDettaglioCaption: String;
    // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
    WC003FRicercaDatiFM:TWC003FRicercaDatiFM;
    procedure imgNavBarClick(Sender: TObject);
    procedure CreaToolBarStorico;
    procedure cmbDecorrenzaChange(Sender: TObject);
    procedure ResultRicerca;
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure CercaStoricoAvanti(Var S,S2,RI,RI2:String);
    procedure CercaStoricoIndietro(Var S, S2, RI, RI2:String);
    function CopiaSu(Storicizza:Boolean; EseguiOperazioniDopoCopia:Boolean = False):Boolean;
    procedure dedtDataScadenzaAsyncChange(Sender: TObject; EventParams: TStringList);    
  protected
    procedure imgNuovaStoricizzazioneClick(Sender: TObject); virtual;
    procedure SalvaValoriOriginali; virtual;
    procedure RipristinaValoriOriginali; virtual;
    procedure CercaStoricoCorrente(DataDecorrenza:TDateTime;ElencoCampi:String = '';ValoriCampi:TStringList = nil);
    procedure AttivaGestioneStoricizzazione;
    procedure DisattivaGestioneStoricizzazione;
    //procedure Componenti2Dataset; virtual;
    procedure AttivaGestioneC700; override;
    procedure CreaTabDefault;
    procedure dedtDataDecorrenzaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure CambioDataDecorrenza; virtual;
    procedure CambioDataScadenza; virtual;
    procedure AbilitaActListNavBar(Browse: boolean); virtual;
    function ActionForDownload(action : TAction):Boolean; virtual;
  public
    cmbDecorrenza:TmeIWComboBox;
    dEdtDataDecorrenza,
    dEdtDataScadenza: TmeIWDBEdit;
    chkStoriciPrec,
    chkStoriciSucc: TmeIWCheckBox;
    imgNuovaStoricizzazione: TmeIWImageFile;
    InterfacciaWR102:TInterfacciaWR102;
    WBrowseFM:TWR204FBrowseTabellaFM;
    WDettaglioFM:TWR205FDettTabellaFM;
    WR302DM:TWR302FGestTabellaDM;
    procedure GetValoriChiavePrimaria(var PK:string; var V:Variant; ConDecorrenza:Boolean);
    function VerificaSelezioneC700 : boolean ; virtual;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure EseguiDelete; virtual;
    procedure AggiornaRecord;
    procedure GetDateDecorrenza;
    procedure selTabellaStateChange(DataSet: TDataSet); virtual;
    procedure CreaNavigatorBar(actlstNavBar: TActionList; grdNavBar: TmeIWGrid; _onClick: TprocSender);
    procedure AggiornaToolBarStorico(ActiveText, ActiveChkPrec, ActiveChkSuc, CheckedPrec, CheckedSuc, ActiveButton: Boolean);
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    function CheckRelazioniEsistenti(pUsaValoriOld: Boolean = False):boolean;
    // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
    property TabBrowseCaption: String read FTabBrowseCaption write FTabBrowseCaption;
    property TabDettaglioCaption: String read FTabDettaglioCaption write FTabDettaglioCaption;
    // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
 end;

implementation

uses
  IWApplication;

{$R *.dfm}

procedure TWR102FGestTabella.IWAppFormCreate(Sender: TObject);
begin
  inherited IWAppFormCreate(Sender);
  InterfacciaWR102:=TInterfacciaWR102.Create;
  //CARATTO 10/09/2012. Per la gestione della T430 è stato parametrizzato il nome del campo
  //decorrenza. Per Default imposto DECORRENZA in modo da non modificare il codice pregresso
  InterfacciaWR102.CampoDecorrenza:='DECORRENZA';
  InterfacciaWR102.CampoDecorrenzaFine:='DECORRENZA_FINE';
  InterfacciaWR102.TemplateAutomatico:=True;
  InterfacciaWR102.PosStoricoCorrenteSuCambioProg:=False;
  //Tool bar
  actPrecedenteStorico.Visible:=False;
  actSuccessivoStorico.Visible:=False;
  actSelezioneStorico.Visible:=False;
  actVisioneCorrente.Visible:=False;
  CreaNavigatorBar(actlstNavigatorBar,grdNavigatorBar,imgNavBarClick);
  grdStatusBar.EliminaElementi;
  grdStatusBar.AggiungiElemento('DATALAVORO');
  grdStatusBar.AggiungiElemento('RECORD');
  grdStatusBar.AggiungiElemento('MESSAGGIO');
  grdStatusBar.CreaStatusBar;
  grdStatusBar.StatusBarComponent('DATALAVORO').Header:='Data Lavoro:';
  grdStatusBar.StatusBarComponent('DATALAVORO').Value:=DateToStr(Parametri.DataLavoro);
  grdStatusBar.StatusBarComponent('RECORD').Header:='Record:';
  grdStatusBar.StatusBarComponent('RECORD').Value:='0/0';
  MessaggioStatus(INFORMA,'');
  dEdtDataDecorrenza:=nil;
  dEdtDataScadenza:=nil;
  chkStoriciPrec:=nil;
  chkStoriciSucc:=nil;
  imgNuovaStoricizzazione:=nil;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  // caption per i tab di browse e dettaglio
  FTabBrowseCaption:='';
  FTabDettaglioCaption:='';
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
end;

procedure TWR102FGestTabella.CreaNavigatorBar(actlstNavBar: TActionList; grdNavBar: TmeIWGrid; _onClick: TprocSender);
var
  i, k:Integer;
  PrecCategory: String;
begin
  grdNavBar.RowCount:=1;
  grdNavBar.ColumnCount:=actlstNavBar.ActionCount;

  if actlstNavBar.ActionCount > 0 then
    PrecCategory:=TAction(actlstNavBar.Actions[0]).Category;

  k:=0;
  for i:=0 to actlstNavBar.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(actlstNavBar.Actions[i]).Category  then
    begin
      grdNavBar.Cell[0,k].Css:='x';
      grdNavBar.Cell[0,k].Text:='';
      k:=k + 1;
      grdNavBar.ColumnCount:=grdNavBar.ColumnCount + 1;
      PrecCategory:=TAction(actlstNavBar.Actions[i]).Category;
    end;

    if TAction(actlstNavBar.Actions[i]) <> actSelezioneStorico then
    begin
      grdNavBar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
      with TmeIWImageFile(grdNavBar.Cell[0,k].Control) do
      begin
        Name:=C190CreaNomeComponente(TAction(actlstNavBar.Actions[i]).Name,Self);
        //OnClick:=imgNavBarClick;
        OnClick:=_onClick;
        Tag:=i;
        if actionForDownload(TAction(actlstNavBar.Actions[i])) then
          medpDownloadButton:=True;
      end;
    end
    else
    begin
      grdNavBar.Cell[0,k].Control:=TmeIWComboBox.Create(Self);
      with TmeIWComboBox(grdNavBar.Cell[0,k].Control) do
      begin
        Tag:=i;
        Name:=C190CreaNomeComponente('cmbDecorrenza',Self);
        Css:='medpToolBarCmb width15chr';
        OnChange:=cmbDecorrenzaChange;
      end;
      cmbDecorrenza:=TmeIWComboBox(grdNavBar.Cell[0,k].Control);
    end;
    grdNavBar.Cell[0,k].Css:='x';
    grdNavBar.Cell[0,k].Text:='';

    k:=k + 1;
  end;
  AggiornaToolBar(grdNavBar,actlstNavBar);
end;

procedure TWR102FGestTabella.CreaToolBarStorico;
var
  VisualizzaScadenza: Boolean;
  col: Integer;
begin
  grdToolBarStorico.Visible:=True;
  grdToolBarStorico.RowCount:=1;
  grdToolBarStorico.ColumnCount:=7;
  VisualizzaScadenza:=False;
  if (InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti or (not InterfacciaWR102.GestioneDecorrenzaFine)) and
     (WR302DM.selTabella.FindField(InterfacciaWR102.CampoDecorrenzaFine) <> nil) and
     (InterfacciaWR102.DettaglioFM) then
    VisualizzaScadenza:=True;

  if VisualizzaScadenza then
    grdToolBarStorico.ColumnCount:=grdToolBarStorico.ColumnCount + 3;

  //Alberto: per evitare di ricreare i componenti nel caso si chiami più volte la procedura
  if dEdtDataDecorrenza <> nil then
    exit;

  col:=0;
  grdToolBarStorico.Cell[0,col].Text:='Decorrenza';
  grdToolBarStorico.Cell[0,col].Css:='intestazione';
  inc(col);
  grdToolBarStorico.Cell[0,col].Text:='';
  grdToolBarStorico.Cell[0,col].Css:='x';
  dEdtDataDecorrenza:=TmeIWDBEdit.Create(Self);
  grdToolBarStorico.Cell[0,col].Control:=dEdtDataDecorrenza;
  dEdtDataDecorrenza.Css:='input_data_dmy';
  dEdtDataDecorrenza.DataField:=InterfacciaWR102.CampoDecorrenza;
  dEdtDataDecorrenza.DataSource:=WR302DM.dsrTabella;
  dEdtDataDecorrenza.Name:=C190CreaNomeComponente('dedtDecorrenza',Self);
  dEdtDataDecorrenza.FriendlyName:='Data decorrenza'; //Caratto 04/11/2013 usato per segnalazioni errori
  dEdtDataDecorrenza.OnAsyncChange:=dedtDataDecorrenzaAsyncChange;
  inc(col);

  if VisualizzaScadenza then
  begin
    grdToolBarStorico.Cell[0,col].Text:='';
    grdToolBarStorico.Cell[0,col].Css:='x';
    inc(col);
    grdToolBarStorico.Cell[0,col].Text:='Scadenza';
    grdToolBarStorico.Cell[0,col].Css:='intestazione';
    inc(col);
    grdToolBarStorico.Cell[0,col].Text:='';
    grdToolBarStorico.Cell[0,col].Css:='x';
    dEdtDataScadenza:=TmeIWDBEdit.Create(Self);
    grdToolBarStorico.Cell[0,col].Control:=dEdtDataScadenza;
    dEdtDataScadenza.Css:='input_data_dmy';
    dEdtDataScadenza.DataField:=InterfacciaWR102.CampoDecorrenzaFine;
    dEdtDataScadenza.DataSource:=WR302DM.dsrTabella;
    dEdtDataScadenza.Name:=C190CreaNomeComponente('dedtScadenza',Self);
    dEdtDataScadenza.FriendlyName:='Data scadenza';
    dEdtDataScadenza.OnAsyncChange:=dedtDataScadenzaAsyncChange;
    inc(col);
  end;
  
  grdToolBarStorico.Cell[0,col].Text:='';
  grdToolBarStorico.Cell[0,col].Css:='x';
  inc(col);
  grdToolBarStorico.Cell[0,col].Text:='';
  grdToolBarStorico.Cell[0,col].Css:='x';
  chkStoriciPrec:=TmeIWCheckBox.Create(Self);
  grdToolBarStorico.Cell[0,col].Control:=chkStoriciPrec;
  chkStoriciPrec.Name:=C190CreaNomeComponente('chkStoriciPrec',Self);
  chkStoriciPrec.Caption:='Storici precedenti';
  inc(col);
  grdToolBarStorico.Cell[0,col].Text:='';
  grdToolBarStorico.Cell[0,col].Css:='x';
  chkStoriciSucc:=TmeIWCheckBox.Create(Self);
  grdToolBarStorico.Cell[0,col].Control:=chkStoriciSucc;
  chkStoriciSucc.Name:=C190CreaNomeComponente('chkStoriciSucc',Self);
  chkStoriciSucc.Caption:='Storici successivi';
  inc(col);
  grdToolBarStorico.Cell[0,col].Text:='';
  grdToolBarStorico.Cell[0,col].Css:='x';
  inc(col);
  grdToolBarStorico.Cell[0,col].Text:='';
  grdToolBarStorico.Cell[0,col].Css:='x';
  imgNuovaStoricizzazione:=TmeIWImageFile.Create(Self);
  grdToolBarStorico.Cell[0,col].Control:=imgNuovaStoricizzazione;
  imgNuovaStoricizzazione.Name:=C190CreaNomeComponente('imgNuovaStoricizzazione',Self);
  imgNuovaStoricizzazione.Hint:='Storicizzazione';
  imgNuovaStoricizzazione.OnClick:=imgNuovaStoricizzazioneClick;

  InterfacciaWR102.StoriciPrec:=False;
  InterfacciaWR102.StoriciSucc:=False;

  AggiornaToolBarStorico(False, False, False, False, False, not SolaLettura); //verificare parametri
end;

//Change su data decorrenza
procedure TWR102FGestTabella.dedtDataDecorrenzaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  CambioDataDecorrenza;
end;

//Change su data scadenza
procedure TWR102FGestTabella.dedtDataScadenzaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  CambioDataScadenza;
end;

procedure TWR102FGestTabella.AggiornaToolBarStorico(ActiveText, ActiveChkPrec, ActiveChkSuc, CheckedPrec, CheckedSuc, ActiveButton: Boolean);
// Imposta le proprietà Visible e Enabled dei pulsanti della grdToolBarStorico
begin
  if grdToolBarStorico.ColumnCount <= 1 then
    exit;
  dEdtDataDecorrenza.Enabled:=ActiveText and InterfacciaWR102.DettaglioFM;
  if dedtDataScadenza <> nil then
    dedtDataScadenza.Enabled:=dEdtDataDecorrenza.Enabled;
    
  chkStoriciPrec.Enabled:=ActiveChkPrec;
  chkStoriciSucc.Enabled:=ActiveChkSuc;
  chkStoriciPrec.Checked:=CheckedPrec;
  chkStoriciSucc.Checked:=CheckedSuc;

  imgNuovaStoricizzazione.Enabled:=ActiveButton;
  if ActiveButton then
    imgNuovaStoricizzazione.ImageFile.Filename:='img/btnStoricizzazione.png'
  else
    imgNuovaStoricizzazione.ImageFile.Filename:='img/btnStoricizzazione_Disabled.png'
end;

procedure TWR102FGestTabella.AttivaGestioneStoricizzazione;
begin
  InterfacciaWR102.GestioneStoricizzata:=True;
  //Caratto 17/12/2012 Ordinamento colonne griglia disabilitato se gestione storicizzata
  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpOrdinamentoColonne:=(not InterfacciaWR102.GestioneStoricizzata) or actVisioneCorrente.Checked;

  CreaToolBarStorico;

  actPrecedenteStorico.Visible:=True;
  actSuccessivoStorico.Visible:=True;
  actSelezioneStorico.Visible:=True;
  actVisioneCorrente.Visible:=True;
  actVisioneCorrente.Hint:=IfThen(actVisioneCorrente.Checked,'Disattiva','Attiva') + ' visione corrente';
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  GetDateDecorrenza;
end;

procedure TWR102FGestTabella.DisattivaGestioneStoricizzazione;
begin
  InterfacciaWR102.GestioneStoricizzata:=False;
 //Caratto 17/12/2012 Ordinamento colonne griglia disabilitato se gestione storicizzata
  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpOrdinamentoColonne:=(not InterfacciaWR102.GestioneStoricizzata) or actVisioneCorrente.Checked;

  grdToolBarStorico.Visible:=False;
  actPrecedenteStorico.Visible:=False;
  actSuccessivoStorico.Visible:=False;
  actSelezioneStorico.Visible:=False;
  actVisioneCorrente.Visible:=False;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  //GetDateDecorrenza;
end;

procedure TWR102FGestTabella.CreaTabDefault;
begin
  if InterfacciaWR102.GestioneStoricizzata then
    AttivaGestioneStoricizzazione;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  // gestione tab default personalizzabile su filtro funzioni
  //Caratto 04/03/2014 chiamata 81922
  {
  grdTabControl.AggiungiTab('Elenco ' + medpNomeFunzione.ToLower,WBrowseFM);
  if InterfacciaWR102.DettaglioFM then
    grdTabControl.AggiungiTab('Dettaglio',WDettaglioFM);
  grdTabControl.ActiveTab:=WBrowseFM;
  }
  // imposta caption di default per i tab, se non specificata diversamente
  if FTabBrowseCaption.Trim = '' then
    FTabBrowseCaption:=Format('Elenco %s',[medpNomeFunzione.ToLower]);
  if FTabDettaglioCaption.Trim = '' then
    FTabDettaglioCaption:='Dettaglio';

  // aggiunge i tab di browse (sempre) e dettaglio (se richiesto)
  grdTabControl.AggiungiTab(FTabBrowseCaption,WBrowseFM);
  if InterfacciaWR102.DettaglioFM then
    grdTabControl.AggiungiTab(FTabDettaglioCaption,WDettaglioFM);

  if DatiAbilitazioni.AccessoBrowse = 'S' then
  begin
    // accesso al tab di browse
    grdTabControl.ActiveTab:=WBrowseFM;
  end
  else
  begin
    // accesso al tab di dettaglio
    if WDettaglioFM <> nil then
      grdTabControl.ActiveTab:=WDettaglioFM;
  end;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
end;

procedure TWR102FGestTabella.cmbDecorrenzaChange(Sender: TObject);
begin
  if cmbDecorrenza.ItemIndex = -1 then
    exit;
  CercaStoricoCorrente(StrToDateTime(cmbDecorrenza.Items[cmbDecorrenza.ItemIndex]));
end;

procedure TWR102FGestTabella.CercaStoricoCorrente(DataDecorrenza:TDateTime;ElencoCampi:String = '';ValoriCampi:TStringList = nil);
var S,RI,PK:String;
    V:Variant;
    idx:Integer;
    SLCampiAgg:TStringList;
    sElencoCampi,Campo,ValAgg:String;
    evAfterScroll: TEvDataset;
    evCalcFields: TEvDataSet;
begin
  if actVisioneCorrente.Checked then
    exit;
  with WR302DM.selTabella do
  begin
    //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
    evAfterScroll:=WR302DM.selTabella.AfterScroll;
    WR302DM.selTabella.AfterScroll:=nil;
    evCalcFields:=WR302DM.selTabella.OnCalcFields;
    WR302DM.selTabella.OnCalcFields:=nil;
    //Recupero il record di partenza
    RI:=RowID;
    //Recupero l'elenco dei campi utilizzati nella ricerca ma che non sono nella chiave primaria
    idx:=0;
    ValAgg:='';
    SLCampiAgg:=TStringList.Create;
    sElencoCampi:=ElencoCampi + IfThen(ElencoCampi <> '',';');
    while Pos(';',sElencoCampi) > 0 do
    begin
      Campo:=Copy(sElencoCampi,1,Pos(';',sElencoCampi) - 1);
      if InterfacciaWR102.LChiavePrimaria.IndexOf(Campo) = -1 then
      begin
        SLCampiAgg.Add(Campo);
        ValAgg:=ValAgg + IfThen(ValAgg <> '',' ') + ValoriCampi[idx];
      end;
      sElencoCampi:=Copy(sElencoCampi,Pos(';',sElencoCampi) + 1);
      idx:=idx + 1;
    end;
    //Recupero i valori della chiave primaria del record di partenza
    S:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);
    GetValoriChiavePrimaria(PK,V,False);
    //Mi posiziono sul record più remoto a parità di chiave
    WR302DM.selTabella.Locate(PK,V,[]);
    //Scorro fino al periodo corrente a parità di chiave
    while (not Eof) and
          (S = R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria)) and
          (FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime <= DataDecorrenza) do
    begin
      //Salvo il rowid del record più recente a parità di chiave e di eventuali campi aggiuntivi utilizzati nella ricerca
      if ValAgg = R180GetCampiConcatenati(WR302DM.selTabella,SLCampiAgg) then
        RI:=RowID;
      Next;
    end;
    FreeAndNil(SLCampiAgg);
    //Mi posiziono sul record individuato
    SearchRecord('ROWID',RI,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS;

    //Caratto 26/09/2014 riattivo afterScroll
    WR302DM.selTabella.AfterScroll:=evAfterScroll;
    WR302DM.selTabella.OnCalcFields:=evCalcFields;
    //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
    TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',WR302DM.selTabella.RowId,[srFromBeginning]);

    AggiornaRecord;
  end;
end;

procedure TWR102FGestTabella.GetValoriChiavePrimaria(var PK:string; var V:Variant; ConDecorrenza:Boolean);
var i:Integer;
begin
    //Alberto 30/12/2005: aggiunta la decorrenza per posizionarsi sullo stesso record dopo aver richiesto la visione completa
    PK:='';
    if ConDecorrenza then
      V:=VarArrayCreate([0,InterfacciaWR102.LChiavePrimaria.Count], varVariant)
    else
      V:=VarArrayCreate([0,InterfacciaWR102.LChiavePrimaria.Count - 1], varVariant);
    for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
    begin
      V[i]:=WR302DM.selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).Value;
      if PK <> '' then PK:=PK + ';';
      PK:=PK + InterfacciaWR102.LChiavePrimaria[i];
    end;
    //Alberto 30/12/2005: aggiunta la decorrenza per posizionarsi sullo stesso record dopo aver richiesto la visione completa
    if ConDecorrenza then
    begin
      PK:=PK + ';'+InterfacciaWR102.CampoDecorrenza;
      V[InterfacciaWR102.LChiavePrimaria.Count]:=WR302DM.selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).Value;
    end;
end;

procedure TWR102FGestTabella.grdTabControlTabControlChange(Sender: TObject);
begin
  inherited;
  //if grdTabControl.ActiveTab = WDettaglioFM then
  //  WDettaglioFM.RenderHTMLControlli;
end;

procedure TWR102FGestTabella.GetDateDecorrenza;
var S:String;
    i:Integer;
begin
  if WR302DM = nil then
   exit;
  if not WR302DM.SelTabella.Active then
   exit;

  if InterfacciaWR102.GestioneStoricizzata then
  begin
    with TOracleDataSet.Create(nil) do
    try
      cmbDecorrenza.Items.Clear;
      Session:=SessioneOracle;
      SQL.Add('SELECT '+ InterfacciaWR102.CampoDecorrenza + ' FROM ' + InterfacciaWR102.NomeTabella);
      if InterfacciaWR102.LChiavePrimaria.Count > 0 then
        SQL.Add('WHERE ');
      for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
      begin
        S:='';
        if i > 0 then
          S:='AND ';
        S:=S + InterfacciaWR102.LChiavePrimaria[i] + '=' + '''' + AggiungiApice(WR302DM.selTabella.FieldByName(InterfacciaWR102.LChiavePrimaria[i]).AsString) + '''';
        SQL.Add(S);
      end;
      SQL.Add('ORDER BY '+InterfacciaWR102.CampoDecorrenza);
      Open;
      First;
      while not Eof do
      begin
        cmbDecorrenza.Items.Add(FieldByName(InterfacciaWR102.CampoDecorrenza).AsString);
        Next;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TWR102FGestTabella.selTabellaStateChange(DataSet: TDataSet);
var
  Browse:Boolean;
  StoricizzaEnable:Boolean;
begin
  Browse:=not (DataSet.State in [dsInsert,dsEdit]);

  if (DataSet.State = dsInsert) and (grdC700 <> nil) and (WR100LinkWC700) then
  begin
    if not VerificaSelezioneC700 then
    begin
      (*
      if GGetWebApplicationThreadVar.ActiveForm <> nil then
        (GGetWebApplicationThreadVar.ActiveForm as TWR100FBase).MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP_INS,mtError,[mbOk],nil,'')
      else //non dovrebbe mai capitare
      *)
        MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP_INS,mtError,[mbOk],nil,'');
      DataSet.Cancel;
      Abort;
    end;
  end;

  if (grdC700 <> nil) and WR100LinkWC700 then
    grdC700.AbilitaToolbar(Browse);

  if (WBrowseFM <> nil) and (WBrowseFM.grdTabella <> nil) then
  begin
    if not WBrowseFM.Visible
    and (grdTabControl.Tabs[WBrowseFM] <> nil) then
      grdTabControl.Tabs[WBrowseFM].Enabled:=Browse;

    WBrowseFM.grdTabella.medpBrowse:=Browse;
    //if DataSetState = dsInsert then
    if DataSet.State = dsInsert then
      WBrowseFM.grdTabella.medpClientDataSet.First;
    WBrowseFM.grdTabella.RowClick:=Browse;
  end;
  AbilitaActListNavBar(Browse);
  try
    StoricizzaEnable:=Browse and Dataset.Active and (not SolaLettura) and (Dataset.RecordCount > 0);
  except
    StoricizzaEnable:=False;
  end;
  actPrecedenteStorico.Enabled:=Browse and not actVisioneCorrente.Checked;
  actSuccessivoStorico.Enabled:=Browse and not actVisioneCorrente.Checked;
  actSelezioneStorico.Enabled:=Browse and not actVisioneCorrente.Checked;

  actVisioneCorrente.Enabled:=Browse;
  if Browse then
  begin
    //AggiornaRecord;
    InterfacciaWr102.StoricizzazioneInCorso:=False;
  end;

 (* for i:=0 to Self.ComponentCount - 1 do
    if (Self.Components[i] is TfrmToolbarFiglio) then
      TFrame(Self.Components[i]).Enabled:=Browse*)
   AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);

  if InterfacciaWR102.GestioneStoricizzata then
  begin
    AggiornaToolBarStorico(not Browse, not Browse, not Browse, False, False, StoricizzaEnable);
  end;
end;

procedure TWR102FGestTabella.TemplateProcessorBeforeProcess(
  var VTemplate: TStream);
begin
  inherited;
end;

//Verifica se la WC700 estrae almeno un elemento
//La WA002 ridefinisce questo controllo per poter inserire un record pur non avendo un dipendente selezionato
function TWR102FGestTabella.VerificaSelezioneC700 : boolean;
begin
  Result:=grdC700.SelAnagrafe.RecordCount > 0;
end;

procedure TWR102FGestTabella.AttivaGestioneC700;
begin
  AttivaGestioneC700Common;

  grdStatusBar.EliminaElementi;
  grdStatusBar.AggiungiElemento('DATALAVORO');
  grdStatusBar.AggiungiElemento('RECORD');
  grdStatusBar.AggiungiElemento('ANAGRAFICHE');
  grdStatusBar.AggiungiElemento('MESSAGGIO');
  grdStatusBar.CreaStatusBar;
  grdStatusBar.StatusBarComponent('DATALAVORO').Header:='Data Lavoro:';
  grdStatusBar.StatusBarComponent('DATALAVORO').Value:=DateToStr(Parametri.DataLavoro);
  grdStatusBar.StatusBarComponent('RECORD').Header:='Record:';
  grdStatusBar.StatusBarComponent('RECORD').Value:='0/0';
  MessaggioStatus(INFORMA,'');
  if WR100LinkWC700 then
  begin
    grdStatusBar.StatusBarComponent('ANAGRAFICHE').Header:='Anagrafiche:';
    grdStatusBar.StatusBarComponent('ANAGRAFICHE').Value:='0/0';
    if (WR302DM <> nil) and (WR302DM.selTabella.VariableIndex('PROGRESSIVO') >= 0) then
    begin
      WR302DM.selTabella.Close;
      //Caratto 20/06/2013 sostituito .value con .AsInteger. Value restituisce null se selzione vuota invece che 0
      //WR302DM.selTabella.SetVariable('PROGRESSIVO',grdC700.selAnagrafe.FieldByName('Progressivo').Value);
      WR302DM.selTabella.SetVariable('PROGRESSIVO',grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger);
      WR302DM.selTabella.Open;
    end;
    AggiornaAnagr;
  end;
end;

// ****************************************************************** //
//                    Gestione azioni navigator bar                   //
// ****************************************************************** //
procedure TWR102FGestTabella.imgNavBarClick(Sender: TObject);
begin
  MessaggioStatus(INFORMA,'');
  TAction(actlstNavigatorBar.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWR102FGestTabella.imgNuovaStoricizzazioneClick(Sender: TObject);
{Inserimento nuovo record inizializzato con i valori del precedente per storicizzazione}
begin
  if WR302DM.selTabella.RecordCount = 0 then
    exit;
  try
    InterfacciaWR102.StoricizzazioneInCorso:=True;
    if Length(InterfacciaWR102.TabelleRelazionate) > 0 then
    begin
      CopiaSu(True,False);
    end
    else
    begin
      SalvaValoriOriginali;
      actNuovoExecute(nil);
      RipristinaValoriOriginali;
      if InterfacciaWR102.DettaglioFM then
        WR302DM.selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).Clear;
      if (not InterfacciaWR102.GestioneDecorrenzaFine) and (WR302DM.selTabella.FindField(InterfacciaWR102.CampoDecorrenzaFine) <> nil) then
        WR302DM.selTabella.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).Clear;

      if (not InterfacciaWR102.DettaglioFM) and (WBrowseFM.Visible) then
        //Gestione dbgrid
        WBrowseFM.grdTabella.DataSet2Componenti(0);
        (*
        for i:=0 to WR302DM.selTabella.FieldCount - 1 do
          TIWEdit(WBrowseFM.grdTabella.medpCompCella(0,i,0)).Text:=WBrowseFM.grdTabella.medpDataSet.Fields[i].AsString;
        *)
    end;
  except
  end;
end;

procedure TWR102FGestTabella.SalvaValoriOriginali;
{Registrazione dati originali in LValoriOriginali nel formato nome=valore}
var i:Integer;
begin
  InterfacciaWR102.LValoriOriginali.Clear;
  for i:=0 to WR302DM.selTabella.FieldDefs.Count - 1 do
  try
    if WR302DM.selTabella.FindField(WR302DM.selTabella.FieldDefs[i].Name) <> nil then
      InterfacciaWR102.LValoriOriginali.Add(WR302DM.selTabella.FieldDefs[i].Name + '=' + WR302DM.selTabella.FieldByName(WR302DM.selTabella.FieldDefs[i].Name).AsString)
  except
  end;
end;

procedure TWR102FGestTabella.RipristinaValoriOriginali;
{Ripristino dati originali da LValoriOriginali nel formato nome=valore}
var i:Integer;
begin
  if WR302DM.selTabella.State in [dsInsert,dsEdit] then
  begin
    for i:=0 to WR302DM.selTabella.FieldDefs.Count - 1 do
    try
      if (WR302DM.selTabella.FindField(WR302DM.selTabella.FieldDefs[i].Name) <> nil) and
         (WR302DM.selTabella.FieldByName(WR302DM.selTabella.FieldDefs[i].Name).FieldKind = fkData) then
      begin
        //Non considero i campi legati ad una sequenza e che non fanno parte della chiave primaria
        //Se facesse parte della chiave primaria potrebbe voler dire che è storicizzabile
        if (WR302DM.selTabella is TOracleDataset) and
           (TOracleDataSet(WR302DM.selTabella).SequenceField.Field.ToUpper = WR302DM.selTabella.FieldDefs[i].Name.ToUpper) and
           (InterfacciaWR102.LChiavePrimaria.IndexOf(WR302DM.selTabella.FieldDefs[i].Name) = -1)
        then
          Continue
        else
          WR302DM.selTabella.FieldByName(WR302DM.selTabella.FieldDefs[i].Name).AsString:=InterfacciaWR102.LValoriOriginali.Values[WR302DM.selTabella.FieldDefs[i].Name];
      end;
    except
    end;
    //CARATTO 13/11/2012
    //forzo il caricamento perchè i componenti non data-aware rimarrebbero vuoti
    if WDettaglioFM <> nil then
      WDettaglioFM.DataSet2Componenti;
  end;
end;

procedure TWR102FGestTabella.AbilitaActListNavBar(Browse: boolean);
begin
  actRicerca.Enabled:=Browse;
  actPrimo.Enabled:=Browse;
  actPrecedente.Enabled:=Browse;
  actSuccessivo.Enabled:=Browse;
  actUltimo.Enabled:=Browse;
  actEstrai.Enabled:=Browse;
  actPrecedenteStorico.Enabled:=Browse;
  actSuccessivoStorico.Enabled:=Browse;
  actSelezioneStorico.Enabled:=Browse;
  actElimina.Enabled:=Browse and not(SolaLettura);
  actNuovo.Enabled:=Browse and not(SolaLettura);
  actModifica.Enabled:=Browse and not(SolaLettura);

  actConferma.Enabled:=not Browse;
  actAnnulla.Enabled:=not Browse;

  actCopiaSu.Enabled:=Browse and not(SolaLettura);
  actAggiorna.Enabled:=Browse;
end;

procedure TWR102FGestTabella.actAggiornaExecute(Sender: TObject);
// refresh del dataset
var i,k:Integer;
    ID,ElencoCampi:String;
    VarValori:Variant;
begin
  ID:='';
  if WR302DM.selTabella is TOracleDataSet then
    ID:=(WR302DM.selTabella as TOracleDataSet).RowID;
  //Gestione della mancanza di rowid per successivo posizionamento
  if ID = '' then
  begin
    k:=0;
    for i:=0 to WR302DM.selTabella.FieldCount - 1 do
      if WR302DM.selTabella.Fields[i].FieldKind = fkData then
        inc(k);
    VarValori:=VarArrayCreate([0,k - 1],VarVariant);
    ElencoCampi:='';
    k:=-1;
    for i:=0 to WR302DM.selTabella.FieldCount - 1 do
    begin
      if WR302DM.selTabella.Fields[i].FieldKind = fkData then
      begin
        inc(k);
        VarValori[k]:=WR302DM.selTabella.Fields[i].Value;
        ElencoCampi:=ElencoCampi + WR302DM.selTabella.Fields[i].FieldName + ';';
      end;
    end;
    if Copy(ElencoCampi,Length(ElencoCampi),1) = ';' then
      ElencoCampi:=Copy(ElencoCampi,1,Length(ElencoCampi) - 1);
  end;

  WR302DM.selTabella.Refresh;

  if (WR302DM.selTabella is TOracleDataSet) and (ID <> '') then
    WR302DM.selTabella.Locate('RowID',ID,[])
  else
  begin
    WR302DM.selTabella.Locate(ElencoCampi,VarValori,[]);
    VarClear(VarValori);
  end;

  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWR102FGestTabella.actRicercaExecute(Sender: TObject);
// creazione frame di ricerca
begin
  inherited;
  WC003FRicercaDatiFM:=TWC003FRicercaDatiFM.Create(Self);
  with WC003FRicercaDatiFM do
  begin
    SearchGrid:=WBrowseFM.grdTabella;
    SearchDataset:=WR302DM.selTabella;
    if InterfacciaWR102.GestioneStoricizzata then
      ResultEvent:=ResultRicerca;
    Visualizza;
  end;
end;

procedure TWR102FGestTabella.ResultRicerca;
begin
  GetDateDecorrenza;
  if not WC003FRicercaDatiFM.CercaXDecorrenza then
  begin
    if WC003FRicercaDatiFM.rgpTipologia.ItemIndex = 0 then
      CercaStoricoCorrente(Parametri.DataLavoro,WC003FRicercaDatiFM.ElencoCampi,WC003FRicercaDatiFM.Valori)
    else
      CercaStoricoCorrente(Parametri.DataLavoro);
  end;
end;

procedure TWR102FGestTabella.actEliminaExecute(Sender: TObject);
begin
  inherited;
  //DC 30-10-2020 - controlla che la riga selezionata non sia quella vuota
  if (not InterfacciaWR102.DettaglioFM) and (WBrowseFM <> nil) and (WBrowseFM.Visible) then
    if WBrowseFM.grdTabella.medpClientDataset.FieldByName('DBG_ROWID').AsString = '*' then
      exit;

  if WR302DM.selTabella.RecordCount = 0 then
   exit;
  if not CheckRelazioniEsistenti then
    if InterfacciaWR102.ConfermaCancellazione then
      MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResultDelete,'')
    else
      EseguiDelete;
end;

function TWR102FGestTabella.CheckRelazioniEsistenti(pUsaValoriOld: Boolean = False): boolean;
begin
  Result:=True;
  // -- imposta e richiama la function "MEDP_CHECK_RELAZIONI_ESISTENTI"
  CheckRelazioni.Session:=(WR302DM.selTabella as TOracleDataSet).Session;
  CheckRelazioni.ClearVariables;
  CheckRelazioni.SetVariable('MASCHERA',Copy(Name,1,5));
  CheckRelazioni.SetVariable('TABELLA',R180EstraiNomeTabella(TOracleDataSet(WR302DM.selTabella).SQL.Text).ToUpper);
  CheckRelazioni.SetVariable('CHIAVE',R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria, pUsaValoriOld));
  // Imposto DECORRENZA se Gestione Storicizzata, altrimenti default 31/12/3999
  if InterfacciaWR102.GestioneStoricizzata then
  begin
    if WR302DM.selTabella.FindField('DECORRENZA') <> nil then
      CheckRelazioni.SetVariable('DECORRENZA',WR302DM.selTabella.FieldByName('DECORRENZA').AsDateTime)
    else
      CheckRelazioni.SetVariable('DECORRENZA',DATE_MIN);
  end
  else
    CheckRelazioni.SetVariable('DECORRENZA',DATE_MIN);
  // Imposto SCADENZA se Gestione Decorrenza Fine, altrimenti default 31/12/3999
  if InterfacciaWR102.GestioneDecorrenzaFine then
  begin
    if WR302DM.selTabella.FindField('DECORRENZA_FINE') <> nil then
      CheckRelazioni.SetVariable('SCADENZA',WR302DM.selTabella.FieldByName('DECORRENZA_FINE').AsDateTime)
    else
      CheckRelazioni.SetVariable('SCADENZA',DATE_MAX);
  end
  else
    CheckRelazioni.SetVariable('SCADENZA',DATE_MAX);
  try
    CheckRelazioni.Execute;
  except
    on E:Exception do
    begin
      Result:=False;
    end;
  end;

  if VarToStr(CheckRelazioni.GetVariable('RESULT')) = 'E1' then
    Result:=False//raise Exception.Create('Errore passaggio parametri')
  else if VarToStr(CheckRelazioni.GetVariable('RESULT')) <> '' then
    raise Exception.Create('Cancellazione e modifica impedite in quanto il dato è in uso:' + CRLF + CheckRelazioni.GetVariable('RESULT'))
  else
    Result:=False;
end;

procedure TWR102FGestTabella.ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    EseguiDelete;
end;

procedure TWR102FGestTabella.EseguiDelete;
begin
  WR302DM.selTabella.Delete;
  WBrowseFM.grdTabella.medpAggiornaCDS;

  if InterfacciaWR102.GestioneStoricizzata then
    GetDateDecorrenza;
  AggiornaRecord;
end;

procedure TWR102FGestTabella.actEstraiExecute(Sender: TObject);
// creazione frame di estrazione dati
begin
  inherited;
  with TWC004FEstrazioneDatiFM.Create(Self) do
  begin
    InizializzaQuery(Self);
    Visualizza;
  end;
end;

//Ridefinire per poter usare l'action indcata per download (medpDownloadButton a True)
function TWR102FGestTabella.ActionForDownload(action: TAction): Boolean;
begin
  Result:=False;
end;

procedure TWR102FGestTabella.actPrimoExecute(Sender: TObject);
var S,S2,RI,RI2:String;
  evAfterScroll: TEvDataset;
// spostamento su primo record
begin
  inherited;
  RI:=TOracleDataSet(WR302DM.selTabella).RowID;

  //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
  evAfterScroll:=WR302DM.selTabella.AfterScroll;
  WR302DM.selTabella.AfterScroll:=nil;

  //MASSIMO 27/02/2013. campi concatenati della PK solo per gestione storicizzata. ci sono SelTabella che non estraggono la chiave completa ma un aggregato
  if InterfacciaWR102.GestioneStoricizzata then
    S:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);

  WR302DM.selTabella.First;
  if (not actVisioneCorrente.Checked)  and (InterfacciaWR102.GestioneStoricizzata) then
    CercaStoricoAvanti(S, S2, RI, RI2);

  if InterfacciaWR102.GestioneStoricizzata then
  begin
    //Riposizionamento sullo storico precedente al browsing se non è variata la chiave
    if (RI <> TOracleDataSet(WR302DM.selTabella).RowID) and (R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) = S) then
      TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',RI,[srFromBeginning]);
    //Caratto 26/09/2014 GetDateDecorrenza già fatto da  afterScroll
    (*
    else
      GetDateDecorrenza;
    *)
  end;

  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpAggiornaCDS(False);

  //Caratto 26/09/2014 riattivo afterScroll
  WR302DM.selTabella.AfterScroll:=evAfterScroll;
  //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
  //TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',WR302DM.selTabella.RowId,[srFromBeginning]);
  if @WR302DM.selTabella.AfterScroll <> nil then
    WR302DM.selTabella.AfterScroll(WR302DM.selTabella);

  AggiornaRecord;
end;

procedure TWR102FGestTabella.actPrecedenteExecute(Sender: TObject);
var S,S2,RI,RI2:String;
  evAfterScroll: TEvDataset;
// spostamento su record precedente
begin
  inherited;
  RI:=TOracleDataSet(WR302DM.selTabella).RowID;

  //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
  evAfterScroll:=WR302DM.selTabella.AfterScroll;
  WR302DM.selTabella.AfterScroll:=nil;

  if (actVisioneCorrente.Checked) or (not InterfacciaWR102.GestioneStoricizzata) then
    WR302DM.selTabella.Prior
  else
    begin
      //MASSIMO 27/02/2013. campi concatenati della PK solo per gestione storicizzata. ci sono SelTabella che non estraggono la chiave completa ma un aggregato
      S:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);
      if (*(not actVisioneCorrente.Checked)*) InterfacciaWR102.GestioneDecorrenzaFine and (WR302DM.selTabella.FindField(InterfacciaWR102.CampoDecorrenzaFine) <> nil)
      and not InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti then
        //Alberto 25/08/2006: mi posiziono subito sull'ultima decorrenza precedente
        TOracleDataSet(WR302DM.selTabella).SearchRecord(InterfacciaWR102.CampoDecorrenzaFine,VarArrayOf([EncodeDate(3999,12,31)]),[srBackward])
      else
        //Se non gestisco la decorrenza_fine (GestioneDecorrenzaFine = False) oppure non prevedo necessariamente il 31/12/3999 (AllineaSoloDecorrenzeIntersecanti = True)
        //allora ciclo sui record per trovare la chiave precedente
        repeat
          WR302DM.selTabella.Prior;
        until (R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) <> S) or WR302DM.selTabella.Bof;
      CercaStoricoIndietro(S, S2, RI, RI2);
    end;

  if InterfacciaWR102.GestioneStoricizzata then
  begin
    //Riposizionamento sullo storico precedente al browsing se non è variata la chiave
    if (RI <> TOracleDataSet(WR302DM.selTabella).RowID) and (R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) = S) then
      TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',RI,[srFromBeginning]);
    //Caratto 26/09/2014 GetDateDecorrenza già fatto da  afterScroll
    (*
    else
      GetDateDecorrenza;
    *)
  end;

  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpAggiornaCDS(False);

  //Caratto 26/09/2014 riattivo afterScroll
  WR302DM.selTabella.AfterScroll:=evAfterScroll;
  //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
  //TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',WR302DM.selTabella.RowId,[srFromBeginning]);
  if @WR302DM.selTabella.AfterScroll <> nil then
    WR302DM.selTabella.AfterScroll(WR302DM.selTabella);

  AggiornaRecord;
end;

procedure TWR102FGestTabella.actPrecedenteStoricoExecute(Sender: TObject);
{Scorrimento sullo storico precedente della medesima chiave}
var S:String;
  evAfterScroll: TEvDataset;
begin
  //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
  evAfterScroll:=WR302DM.selTabella.AfterScroll;
  WR302DM.selTabella.AfterScroll:=nil;

  S:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);
  try
    WR302DM.selTabella.Prior;
    if R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) <> S then
      WR302DM.selTabella.Next;
  finally
  end;

  WBrowseFM.grdTabella.medpAggiornaCDS(False);

  //Caratto 26/09/2014 riattivo afterScroll
  WR302DM.selTabella.AfterScroll:=evAfterScroll;
  //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
  //TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',WR302DM.selTabella.RowId,[srFromBeginning]);
  if @WR302DM.selTabella.AfterScroll <> nil then
    WR302DM.selTabella.AfterScroll(WR302DM.selTabella);

  AggiornaRecord;
end;

procedure TWR102FGestTabella.actSuccessivoExecute(Sender: TObject);
var S,S2,RI,RI2:String;
  evAfterScroll: TEvDataset;
// spostamento su record successivo
begin
  inherited;
  //per la gestione storicizzata serve obbligatoriamente il RowID
  RI:=TOracleDataSet(WR302DM.selTabella).RowID;

  //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
  evAfterScroll:=WR302DM.selTabella.AfterScroll;
  WR302DM.selTabella.AfterScroll:=nil;

  if (actVisioneCorrente.Checked) or (not InterfacciaWR102.GestioneStoricizzata) then
    WR302DM.selTabella.Next
  else
  begin
    //CARATTO 27/07/2012. campi concatenati della PK solo per gestione storicizzata. ci sono SleTabella che non estraggono la chiave completa ma un aggregato
    S:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);
    if (*(not actVisioneCorrente.Checked)*) InterfacciaWR102.GestioneDecorrenzaFine and (WR302DM.selTabella.FindField(InterfacciaWR102.CampoDecorrenzaFine) <> nil)
    and not InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti then
    begin
      //Alberto 25/08/2006: mi posiziono subito sull'ultima decorrenza e vado avanti ancora di un record
      if WR302DM.selTabella.FieldByName(InterfacciaWR102.CampoDecorrenzaFine).AsDateTime < EncodeDate(3999,12,31) then
        TOracleDataSet(WR302DM.selTabella).SearchRecord(InterfacciaWR102.CampoDecorrenzaFine,VarArrayOf([EncodeDate(3999,12,31)]),[]);
      WR302DM.selTabella.Next;
    end
    else
      //Se non gestisco la decorrenza_fine (GestioneDecorrenzaFine = False) oppure non prevedo necessariamente il 31/12/3999 (AllineaSoloDecorrenzeIntersecanti = True)
      //allora ciclo sui record per trovare la chiave successiva
      repeat
        WR302DM.selTabella.Next;
      until (R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) <> S) or WR302DM.selTabella.Eof;
    CercaStoricoAvanti(S,S2,RI,RI2);
  end;

  if InterfacciaWR102.GestioneStoricizzata then
  begin
    //Riposizionamento sullo storico precedente al browsing se non è variata la chiave
    if (RI <> TOracleDataSet(WR302DM.selTabella).RowID) and (R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) = S) then
      TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',RI,[srFromBeginning]);
    //Caratto 26/09/2014 GetDateDecorrenza già fatto da  afterScroll
    (*
    else
      GetDateDecorrenza;
  *)
  end;

  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpAggiornaCDS(False);

  //Caratto 26/09/2014 riattivo afterScroll
  WR302DM.selTabella.AfterScroll:=evAfterScroll;
  //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
  //TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',WR302DM.selTabella.RowId,[srFromBeginning]);
  if @WR302DM.selTabella.AfterScroll <> nil then
    WR302DM.selTabella.AfterScroll(WR302DM.selTabella);

  AggiornaRecord;
end;

procedure TWR102FGestTabella.actSuccessivoStoricoExecute(Sender: TObject);
{Scorrimento sullo storico successivo della medesima chiave}
var S:String;
  evAfterScroll: TEvDataset;
begin
  //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
  evAfterScroll:=WR302DM.selTabella.AfterScroll;
  WR302DM.selTabella.AfterScroll:=nil;

  S:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);
  WR302DM.selTabella.Next;
  if R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) <> S then
    WR302DM.selTabella.Prior;

  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpAggiornaCDS(False);

  //Caratto 26/09/2014 riattivo afterScroll
  WR302DM.selTabella.AfterScroll:=evAfterScroll;
  //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
  //TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',WR302DM.selTabella.RowId,[srFromBeginning]);
  if @WR302DM.selTabella.AfterScroll <> nil then
    WR302DM.selTabella.AfterScroll(WR302DM.selTabella);

  AggiornaRecord;
end;

procedure TWR102FGestTabella.actUltimoExecute(Sender: TObject);
var S,S2,RI,RI2:String;
  evAfterScroll: TEvDataset;
// spostamento su ultimo record
begin
  inherited;
  RI:=TOracleDataSet(WR302DM.selTabella).RowID;
  //S:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);

  //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
  evAfterScroll:=WR302DM.selTabella.AfterScroll;
  WR302DM.selTabella.AfterScroll:=nil;

  //MASSIMO 27/02/2013 : campi concatenati della PK solo per gestione storicizzata. ci sono SleTabella che non estraggono la chiave completa ma un aggregato
  if InterfacciaWR102.GestioneStoricizzata then
    S:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);

  WR302DM.selTabella.Last;
  if (not actVisioneCorrente.Checked) and (InterfacciaWR102.GestioneStoricizzata) then
    CercaStoricoIndietro(S,S2,RI,RI2);

  if InterfacciaWR102.GestioneStoricizzata then
  begin
    //Riposizionamento sullo storico precedente al browsing se non è variata la chiave
    if (RI <> TOracleDataSet(WR302DM.selTabella).RowID) and (R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) = S) then
      TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',RI,[srFromBeginning]);
    //Caratto 26/09/2014 GetDateDecorrenza già fatto da  afterScroll
    (*
    else
      GetDateDecorrenza;
    *)
  end;

  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpAggiornaCDS(False);

  //Caratto 26/09/2014 riattivo afterScroll
  WR302DM.selTabella.AfterScroll:=evAfterScroll;
  //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
  //TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',WR302DM.selTabella.RowId,[srFromBeginning]);
  if @WR302DM.selTabella.AfterScroll <> nil then
    WR302DM.selTabella.AfterScroll(WR302DM.selTabella);

  AggiornaRecord;
end;

//Modifica della data di decorrenza
procedure TWR102FGestTabella.CambioDataDecorrenza;
begin
  //ridefinire
end;

//Modifica della data di scadenza
procedure TWR102FGestTabella.CambioDataScadenza;
begin
  //ridefinire
end;

procedure TWR102FGestTabella.CercaStoricoAvanti(Var S, S2, RI, RI2:String);

begin
  //Cerco il record alla data di lavoro corrente scorrendo il dataset avanti
  if R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) <> S then
  begin
    S2:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);
    RI2:=TOracleDataSet(WR302DM.selTabella).RowID;
    while (not WR302DM.selTabella.Eof) and
          (R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) = S2) and
          (WR302DM.selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime <= Parametri.DataLavoro) do
    begin
      RI2:=TOracleDataSet(WR302DM.selTabella).RowID;
      WR302DM.selTabella.Next;
    end;
    TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',RI2,[srFromBeginning]);
  end;
end;

procedure TWR102FGestTabella.CercaStoricoIndietro(Var S, S2, RI, RI2:String);
begin
  //Cerco il record alla data di lavoro corrente scorrendo il dataset indietro
  if R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) <> S then
  begin
    S2:=R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria);
    RI2:=TOracleDataSet(WR302DM.selTabella).RowID;
    while (not WR302DM.selTabella.Bof) and
          (R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) = S2) and
          (WR302DM.selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsDateTime > Parametri.DataLavoro) do
    begin
      RI2:=TOracleDataSet(WR302DM.selTabella).RowID;
      WR302DM.selTabella.Prior;
    end;
    if S2 <> R180GetCampiConcatenati(WR302DM.selTabella,InterfacciaWR102.LChiavePrimaria) then
      TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',RI2,[srFromBeginning]);
  end;
end;

procedure TWR102FGestTabella.actVisioneAnnualeExecute(Sender: TObject);
{Costruzione o ripristino della query per visualizzare solamente i record
la cui decorrenza cade nell'anno individuato dalla data di lavoro}
var S,SO,PK:String;
    PW,PO:Integer;
    V:Variant;
begin
  if InterfacciaWR102.LChiavePrimaria.Count > 0 then
    GetValoriChiavePrimaria(PK,V,False);
  if not actVisioneAnnuale.Checked and actVisioneCorrente.Checked then
    actVisioneCorrenteExecute(nil);
  actVisioneAnnuale.Checked:=not actVisioneAnnuale.Checked;
  WR302DM.selTabella.Close;
  if TOracleDataSet(WR302DM.selTabella).VariableIndex('DECORRENZA') >= 0 then
    TOracleDataSet(WR302DM.selTabella).DeleteVariable('DECORRENZA');
  if actVisioneAnnuale.Checked then
  begin
    SQLOriginale:=TOracleDataSet(WR302DM.selTabella).SQL.Text;
    //Caratto 10/03/2014 non fare upper di sql perchè in caso di decode o simili sarebbe tutto trasformato in maiuscolo
    S:=TOracleDataSet(WR302DM.selTabella).SQL.Text;
    PW:=Pos('WHERE',S.ToUpper);
    PO:=Pos(':ORDERBY',S.ToUpper); //al posto di cercare 'ORDER BY' cerco la variabile
    SO:='';
    if PO > 0 then
    begin
      SO:=Copy(S,PO,Length(S));
      Delete(S,PO,Length(SO));
    end;
    if PW = 0 then
      S:=S + ' WHERE '
    else
      S:=S + ' AND ';
    S:=S + 'TO_CHAR('+InterfacciaWR102.CampoDecorrenza+',''YYYY'') = TO_CHAR(:DECORRENZA,''YYYY'')';
    S:=S + SO;
    TOracleDataSet(WR302DM.selTabella).SQL.Text:=S;
    TOracleDataSet(WR302DM.selTabella).DeclareVariable('DECORRENZA',otDate);
    TOracleDataSet(WR302DM.selTabella).SetVariable('DECORRENZA',Parametri.DataLavoro);
  end
  else
    TOracleDataSet(WR302DM.selTabella).SQL.Text:=SQLOriginale;
  WR302DM.selTabella.Open;
  AggiornaRecord;
  if InterfacciaWR102.LChiavePrimaria.Count > 0 then
    WR302DM.selTabella.Locate(PK,V,[]);

   WBrowseFM.grdTabella.medpAggiornaCDS;
   AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWR102FGestTabella.actVisioneCorrenteExecute(Sender: TObject);
// Costruzione o ripristino della query per visualizzare solamente i record
// validi alla data di lavoro oppure per visualizzare tutti i dati
var S,SO,PK:String;
    i,PW,PO:Integer;
    V:Variant;
    evAfterScroll: TEvDataset;
  bCambioDataLavoro: Boolean;
begin
  //Caratto 26/09/2014 inibisco afterScroll per evitare che si scateni troppe volte
  evAfterScroll:=WR302DM.selTabella.AfterScroll;
  WR302DM.selTabella.AfterScroll:=nil;

  if InterfacciaWR102.LChiavePrimaria.Count > 0 then
    GetValoriChiavePrimaria(PK,V,actVisioneCorrente.Checked);
  if not actVisioneCorrente.Checked and actVisioneAnnuale.Checked then
    actVisioneAnnualeExecute(nil);

  //quando richiamato da menu per cambio data lavoro non deve cambiare il valore di actVisione corrente
  //ne salvare l'SQLoriginale; deve solo aggiornare
   bCambioDataLavoro:=False;
  if (Sender <> nil) and (Sender is TWR207FMenuWebPJFM) then
    bCambioDataLavoro:=True;

  if not bCambioDataLavoro then
    actVisioneCorrente.Checked:=not actVisioneCorrente.Checked;

  actVisioneCorrente.Hint:=IfThen(actVisioneCorrente.Checked,'Disattiva','Attiva') + ' visione corrente';
  actPrecedenteStorico.Enabled:=not actVisioneCorrente.Checked;
  actSuccessivoStorico.Enabled:=not actVisioneCorrente.Checked;
  actSelezioneStorico.Enabled:=not actVisioneCorrente.Checked;
  WR302DM.selTabella.Close;
  if TOracleDataSet(WR302DM.selTabella).VariableIndex('DECORRENZA') >= 0 then
    TOracleDataSet(WR302DM.selTabella).DeleteVariable('DECORRENZA');
  if actVisioneCorrente.Checked then
  begin
    if not bCambioDataLavoro then
      SQLOriginale:=TOracleDataSet(WR302DM.selTabella).SQL.Text;
    //Caratto 10/03/2014 non fare upper di sql perchè in caso di decode o simili sarebbe tutto trasformato in maiuscolo
    S:=TOracleDataSet(WR302DM.selTabella).SQL.Text;
    PW:=Pos('WHERE',S.toUpper);
    PO:=Pos(':ORDERBY',S.toUpper); //al posto di cercare 'ORDER BY' cerco la variabile
    SO:='';
    if PO > 0 then
    begin
      SO:=Copy(S,PO,Length(S));
      Delete(S,PO,Length(SO));
    end;
    if PW = 0 then
      S:=S + ' WHERE '
    else
      S:=S + ' AND ';
    if InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti then
      S:=S + ':DECORRENZA BETWEEN '+InterfacciaWR102.CampoDecorrenza +' AND ' +InterfacciaWR102.CampoDecorrenzaFine + ' '
    else
    begin
      S:=S + InterfacciaWR102.AliasNomeTabella + '.' + InterfacciaWR102.CampoDecorrenza + ' = (SELECT MAX('+InterfacciaWR102.CampoDecorrenza+') FROM ' + InterfacciaWR102.NomeTabella + ' WHERE ';
      for i:=0 to InterfacciaWR102.LChiavePrimaria.Count - 1 do
      begin
        S:=S + InterfacciaWR102.LChiavePrimaria[i] + ' = ' + InterfacciaWR102.AliasNomeTabella + '.' + InterfacciaWR102.LChiavePrimaria[i];
        if i < InterfacciaWR102.LChiavePrimaria.Count - 1 then
          S:=S + ' AND ';
      end;
      if InterfacciaWR102.LChiavePrimaria.Count > 0 then
        S:=S + ' AND ';
      S:=S + InterfacciaWR102.CampoDecorrenza + '<= :DECORRENZA) ';
    end;
    S:=S + SO;
    TOracleDataSet(WR302DM.selTabella).SQL.Text:=S;
    TOracleDataSet(WR302DM.selTabella).DeclareVariable('DECORRENZA',otDate);
    TOracleDataSet(WR302DM.selTabella).SetVariable('DECORRENZA',Parametri.DataLavoro);
  end
  else
  begin
//    DButton.DataSet.Close;
    TOracleDataSet(WR302DM.selTabella).SQL.Text:=SQLOriginale;
    //Caratto 17/12/2012 Ripristino ordinamento originale
    if TOracleDataSet(WR302DM.selTabella).VariableIndex('ORDERBY') > -1 then
      TOracleDataSet(WR302DM.selTabella).SetVariable('ORDERBY', InterfacciaWR102.OrdinamentoOriginale);
  end;
  WR302DM.selTabella.Open;

  //Caratto 17/12/2012 Ordinamento colonne griglia disabilitato se gestione storicizzata
  //ma consentito in caso di visione corrente
  with WBrowseFM.grdTabella do
  begin
    //Caratto 13/11/2014 riattivo afterScroll perchè in aluni casi necessario per impostare dataset lookup storici
    //es WA164.
    //l'evento di scroll all'interno di medpCaricaCDS è inibito a meno che DisabilitaEventiDataset sia a False
    //Quindi non genera eventi indesiderati
    WR302DM.selTabella.AfterScroll:=evAfterScroll;

    medpOrdinamentoColonne:=actVisioneCorrente.Checked;
    //WBrowseFM.grdTabella.medpAggiornaCDS;
    //Ricreo la griglia perchè titoli colonne passano da linkabili a non e viceversa
    medpAttivaGrid(medpDataSet,medpComandiEdit,medpComandiInsert,medpComandoDelete);
    if medpComandiCustom then
      //da eseguire adesso perchè non lo ha eseguito prima in medpAttivaGrid
      medpCaricaCDS;
    //Caratto 13/11/2014
    WR302DM.selTabella.AfterScroll:=nil;
  end;
  //14/03/2014 spostato locate e aggiornamento cds dopo medpAttivaGrid, altrimenti si riposiziona su primo elemento
  if InterfacciaWR102.LChiavePrimaria.Count > 0 then
     WR302DM.selTabella.Locate(PK,V,[]);
  WBrowseFM.grdTabella.medpAggiornaCDS(False);

  //Caratto 26/09/2014 riattivo afterScroll
  WR302DM.selTabella.AfterScroll:=evAfterScroll;
  //forzo scroll per scatenare tutti gli eventi derivati dallo scroll
  TOracleDataSet(WR302DM.selTabella).SearchRecord('ROWID',WR302DM.selTabella.RowId,[srFromBeginning]);

  AggiornaRecord;

  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWR102FGestTabella.actNuovoExecute(Sender: TObject);
// inserimento nuovo record
var i:Integer;
  LMsg: string;
begin
  if (InterfacciaWR102.DettaglioFM) (*and (WBrowseFM <> nil) and (WBrowseFM.Visible)*) then
  begin
    //Posizionamento sul tab di dettaglio
    grdTabControl.ActiveTab:=WDettaglioFM;
    //Se esiste un tab all'interno del dettaglio, posizionamento sulla prima pagina
    for i:=0 to WDettaglioFM.IWFrameRegion.ControlCount - 1 do
      if WDettaglioFM.IWFrameRegion.Controls[i] is TmedpIWTabControl then
      begin
        (WDettaglioFM.IWFrameRegion.Controls[i] as TmedpIWTabControl).ActiveTabIndex:=0;
        Break;
      end;
  end;

  WR302DM.selTabella.Insert;

  if (not InterfacciaWR102.DettaglioFM) and (WBrowseFM <> nil) and (WBrowseFM.Visible) then
  begin
    //Gestione dbgrid
    //Creazione componenti
    WBrowseFM.grdTabella.medpInserisci(False);
  end
  else
  begin
    //Gestione dettaglio
  end;

  // messaggio informativo sulla statusbar
  LMsg:=IfThen(InterfacciaWR102.StoricizzazioneInCorso,'Storicizzazione','Inserimento') +
        IfThen(A000SessioneWEB.IsTimeoutRidotto,A000TraduzioneStringhe(Format(A000MSG_MSG_FMT_TIMEOUT_RIDOTTO,[GGetWebApplicationThreadVar.SessionTimeOut])));
  MessaggioStatus(IfThen(A000SessioneWEB.IsTimeoutRidotto,ESCLAMA,INFORMA),LMsg);
end;

procedure TWR102FGestTabella.actModificaExecute(Sender: TObject);
var
  LMsg: string;
// modifica del record attuale
begin
  inherited;
  //DC 30-10-2020 - controlla che la riga selezionata non sia quella vuota
  if (not InterfacciaWR102.DettaglioFM) and (WBrowseFM <> nil) and (WBrowseFM.Visible) then
    if WBrowseFM.grdTabella.medpClientDataset.FieldByName('DBG_ROWID').AsString = '*' then
      exit;

  if (InterfacciaWR102.DettaglioFM) (*and (WBrowseFM <> nil) and (WBrowseFM.Visible)*) then
    grdTabControl.ActiveTab:=WDettaglioFM;
  WR302DM.selTabella.Edit;
  SalvaValoriOriginali;
  if (not InterfacciaWR102.DettaglioFM) and (WBrowseFM <> nil) and (WBrowseFM.Visible) then
  begin
    //Gestione dbgrid
    WBrowseFM.grdTabella.medpModifica(False);
  end
  else
  begin
    //Gestione dettaglio
  end;

  LMsg:='Modifica' + IfThen(A000SessioneWEB.IsTimeoutRidotto,A000TraduzioneStringhe(Format(A000MSG_MSG_FMT_TIMEOUT_RIDOTTO,[GGetWebApplicationThreadVar.SessionTimeOut])));
  MessaggioStatus(IfThen(A000SessioneWEB.IsTimeoutRidotto,ESCLAMA,INFORMA),LMsg);
end;

procedure TWR102FGestTabella.actAnnullaExecute(Sender: TObject);
// annullamento operazione
var
  RowID:String;
begin
  inherited;
  //...ritornare sul record corrente quando si è sulla pagina
  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpStato:=msBrowse;
  WR302DM.selTabella.Cancel;
  InterfacciaWR102.StoricizzazioneInCorso:=False;
  {
  lbldecorrenza.Font.Color:=clBlue;
  dedtDecorrenza.Hint:='';
  dedtDecorrenza.ShowHint:=False;
  }
  if (not InterfacciaWR102.DettaglioFM) and (WBrowseFM.Visible) then
  begin
    //Gestione dbgrid
    RowID:=WBrowseFM.grdTabella.medpClientDataSet.FieldByName('DBG_ROWID').AsString;
    //WBrowseFM.CreaColonne;
    WBrowseFM.grdTabella.medpCreaColonne;
    WR302DM.selTabella.Locate('ROWID',RowID,[]);
  end
  else
  begin
    //Gestione dettaglio
  end;
  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpAggiornaCDS;
  //Devo resettare eventuali punti già impostati, altrimenti un successivo edito li troverebbe già settati
  MsgBox.ClearKeys;
end;

procedure TWR102FGestTabella.actConfermaExecute(Sender: TObject);
// conferma operazione
var
  RowID:String;
  r: Integer;
begin
  if InterfacciaWR102.GestioneStoricizzata then
  begin
    InterfacciaWR102.StoriciPrec:=chkStoriciPrec.Checked;
    InterfacciaWR102.StoriciSucc:=chkStoriciSucc.Checked;
  end;

  if (not InterfacciaWR102.DettaglioFM) and (WBrowseFM <> nil) and (WBrowseFM.Visible) then
  begin
    //Gestione dbgrid
    with WBrowseFM do
    begin
      if not grdTabella.medpEditMultiplo then
      begin
        //Caratto 28/06/2013 Nel caso di edit in line su pagina successiva alla 1, bisogna
        //tenere conto di passare il valore della riga relativo (all'interno della pagina) e non assoluto (dal primo record del dataset)
        r:=grdTabella.medpDataSet.RecNo;
        if grdTabella.medpGetCurrPag > 1 then
          r:=r - (grdTabella.medpGetCurrPag - 1) * grdTabella.medpRighePagina;
        //Caratto 21/02/2013 recno Parte da riga 1 mentre componenti griglia da riga da 0 se non c'è riga inserimento. (aggiunto - Ifthen per problema su WA034. in edit prendeva riga errata)
        grdTabella.medpConferma(ifThen(grdTabella.medpDataSet.State = dsInsert,0,r - IfThen(grdTabella.RigaInserimento,0,1)));
      end
      else
      begin
        grdTabella.medpDataSet.Cancel;
        grdTabella.medpDataSet.RecNo:=1 + (grdTabella.medpGetCurrPag - 1) * grdTabella.medpRighePagina; //Posiziona il dataset sulla prima riga della pagina corrente (AOSTA_ASL - 164308)
        for r:=IfThen(grdTabella.RigaInserimento,1,0) to High(grdTabella.medpCompGriglia) do
        begin
          grdTabella.medpDataSet.Edit;
          grdTabella.medpConferma(r);
          grdTabella.medpDataSet.Next;
        end;
        grdTabella.medpDataSet.RecNo:=1 + (grdTabella.medpGetCurrPag - 1) * grdTabella.medpRighePagina;//grdTabella.medpDataSet.First;
      end;
    end;
    (*for i:=0 to WR302DM.selTabella.FieldCount - 1 do
      WR302DM.selTabella.Fields[i].AsString:=TIWEdit(WBrowseFM.grdTabella.medpCompCella(x,i,0)).Text;*)
  end
  else
  begin
    //Gestione dettaglio
    WR302DM.selTabella.Post; //se solo pannello browse il post viene eseguito da medpConferma
  end;

  if WBrowseFM <> nil then
  begin
    WBrowseFM.grdTabella.medpStato:=msBrowse;
    RowID:=WR302DM.selTabella.RowId;
    //WBrowseFM.CreaColonne;
    WBrowseFM.grdTabella.medpCreaColonne;
    WR302DM.selTabella.Locate('ROWID',RowID,[]);

    InterfacciaWR102.StoricizzazioneInCorso:=False;
    WBrowseFM.grdTabella.medpAggiornaCDS;
  end
  else
    InterfacciaWR102.StoricizzazioneInCorso:=False;
end;
(*
procedure TWR102FGestTabella.Componenti2DataSet;
var
  i:Integer;
  x:Integer;
begin
  x:=WBrowseFM.grdTabella.medpClientDataSet.RecNo - 1;
  for i:=0 to WR302DM.selTabella.FieldCount - 1 do
    if WBrowseFM.grdTabella.medpColonna(WR302DM.selTabella.Fields[i].FieldName).Visible then
      WR302DM.selTabella.Fields[i].AsString:=TIWEdit(WBrowseFM.grdTabella.medpCompCella(x,i,0)).Text;
end;
*)
procedure TWR102FGestTabella.actCopiaSuExecute(Sender: TObject);
begin;
  if WR302DM.selTabella.RecordCount = 0 then
   exit;
  CopiaSu(False,True);
end;

function TWR102FGestTabella.CopiaSu(Storicizza:Boolean; EseguiOperazioniDopoCopia:Boolean = False):Boolean;
begin
  Result:=True;
  with TWC009FCopiaSuFM.Create(Self) do
  begin
    Storicizzazione:=Storicizza;
    ODS:=WR302DM.selTabella;
    CopiaSuTabella:=InterfacciaWR102.CopiaSuTabella;
    CopiaSuChiave:=InterfacciaWR102.CopiaSuChiave;
    CopiaSuChiaveInput:=InterfacciaWR102.CopiaSuChiaveInput;
    CopiaSuCampi:=InterfacciaWR102.CopiaSuCampi;
    if (EseguiOperazioniDopoCopia) and Assigned(InterfacciaWR102.CopiaSuOperazioniDopoCopia) then
      OperazioniDopoCopia:=InterfacciaWR102.CopiaSuOperazioniDopoCopia;
    if Length(InterfacciaWR102.TabelleRelazionate) > 0 then
      SetODS(InterfacciaWR102.TabelleRelazionate)
    else
      SetODS([ODS]);

    Visualizza;
  end;
end;

procedure TWR102FGestTabella.AggiornaRecord;
begin
  if WR302DM = nil then
   exit;
  if not WR302DM.SelTabella.Active then
   exit;

  grdStatusBar.StatusBarComponent('RECORD').Value:=IntToStr(WR302DM.selTabella.RecNo) + '/' + IntToStr(WR302DM.selTabella.RecordCount);
  if InterfacciaWR102.GestioneStoricizzata then
    cmbDecorrenza.ItemIndex:=cmbDecorrenza.Items.IndexOf(WR302DM.selTabella.FieldByName(InterfacciaWR102.CampoDecorrenza).AsString);
end;

procedure TWR102FGestTabella.WC700CambioProgressivo(Sender: TObject);
var EvOnStateChange: TEvOnStateChange;
    Browse:Boolean;
    StoricizzaEnable:Boolean;
begin
  inherited;
  if WR302DM = nil then
    exit;
  if WR100LinkWC700 and (WR302DM.selTabella.VariableIndex('PROGRESSIVO') >= 0) then
  begin
    //Caratto 10/05/2013 sul cambio progressivo inibisco lo stateChange poichè scatenerebbe
    //AbilitaComponenti sui frame di dettaglio
    EvOnStateChange:=WR302DM.dsrTabella.OnStateChange;
    WR302DM.dsrTabella.OnStateChange:=nil;

    WR302DM.selTabella.Close;
    WR302DM.selTabella.SetVariable('PROGRESSIVO',grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger);
    WR302DM.selTabella.Open;
    WR302DM.dsrTabella.OnStateChange:=EvOnStateChange;
    if WBrowseFM <> nil then
    begin
      WBrowseFM.grdTabella.medpAggiornaCDS;
      AggiornaRecord;
    end;

    Browse:=not (WR302DM.selTabella.State in [dsInsert,dsEdit]);
    try
      StoricizzaEnable:=Browse and WR302DM.selTabella.Active and (not SolaLettura) and (WR302DM.selTabella.RecordCount > 0);
    except
      StoricizzaEnable:=False;
    end;
    AggiornaToolBarStorico(not Browse, not Browse, not Browse, False, False, StoricizzaEnable);
  end;
  GetDateDecorrenza;
  //Caratto: Utente: CUNEO_CSAC Chiamata: 82374 posizionarsi su storico in base a datalavoro
  if (InterfacciaWR102.GestioneStoricizzata) and (InterfacciaWR102.PosStoricoCorrenteSuCambioProg) then
    CercaStoricoCorrente(Parametri.DataLavoro);

  //Caratto 09/12/2013. se cambiando progressivo, non ci sono record i campi non data-aware
  //rimangono valorizzati perchè non si verifica scroll e quindi Daset2Componenti.
  //Forzo lo svuotamento
  //Massimo 23/12/2013. Aggiunto controllo se WDettaglioFM esiste
  if (WR302DM.selTabella.Active) and (WR302DM.selTabella.RecordCount = 0) and (WDettaglioFM <> nil) then
    WDettaglioFM.DataSet2Componenti;
end;

procedure TWR102FGestTabella.IWAppFormDestroy(Sender: TObject);
var
  i:Integer;
begin
  //Massimo 04/01/2013 nel caso di frame annidati in un dialog grdNavigatorBar è nil
  if grdNavigatorBar <> nil then
    for i:=0 to grdNavigatorBar.ColumnCount - 1 do
      if grdNavigatorBar.Cell[0,i].Control <> nil then
      begin
        TIWCustomControl(grdNavigatorBar.Cell[0,i].Control).Free;
        grdNavigatorBar.Cell[0,i].Control:=nil;
      end;

  FreeAndNil(InterfacciaWR102);
  FreeAndNil(WR302DM);

  inherited IWAppFormDestroy(Sender);
  //Caratto 09/04/2013 Scommentata questa parte.
  //Spostata dopo inherited perchè cicla sui frame per richiamare ReleaseOggetti
  if WBrowseFM <> nil then
    FreeAndNil(WBrowseFM);

  //CARATTO 07/09/2012
  if WDettaglioFM <> nil then
    FreeAndNil(WDettaglioFM);
end;

procedure TWR102FGestTabella.OnTabClosing(var AllowClose: Boolean;
  var Conferma: String);
begin
  inherited;
  if (WR302DM <> nil) and (WR302DM.SelTabella <> nil) and (WR302DM.SelTabella.State in [dsInsert,dsEdit]) then
  begin
    AllowClose:=False;
    Conferma:=A000MSG_ERR_MODIFICHE_PENDING;
  end;
end;

end.
