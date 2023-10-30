unit WC700USelezioneAnagrafeFM;

interface

uses
  SysUtils, Classes, Controls, Dialogs, Forms, Variants, Math, Generics.Collections,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWVCLComponent, IWBaseLayoutComponent, IWForm,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  DB, IWCompCheckbox, IWCompEdit,
  medpIWMessageDlg, meIWGrid, meIWEdit,
  ActnList, meIWComboBox, meIWImageFile, IWCompListbox, meIWListbox,
  meIWCheckBox, meIWRadioGroup, IWCompLabel, meIWLabel,
  IWDBGrids, medpIWDBGrid,   IWTypes,
  meIWMemo, IWCompExtCtrls, IWCompGrids, IWCompJQueryWidget,
  IWTMSCheckList, meTIWCheckListBox,
  IWCompButton, meIWButton, IWWebGrid, IWCompMemo, IWColor,IWFont,
  StrUtils, Oracle, OracleData, Menus, IWApplication, System.Actions,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, QueryStorico, RegistrazioneLog,
  WC700USelezioneAnagrafeDM, WR200UBaseFM;

const C700TuttiCampi = 'T030.*,T480.CITTA,T480.PROVINCIA,V430.*';
      C700CampiBase = 'T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE';
      C700CampiAnteprima = 'MATRICOLA,COGNOME,NOME,T430BADGE,T430INIZIO,T430FINE,PROGRESSIVO';

type
  TWC700ModalResultEvent = procedure(Sender: TObject; Result: Boolean) of object;

  PSelezione = ^TSelezione;

  TSelezione = record
    DaValore,AValore,Valore:String;
    TotValori,SelValori:TStringList;
    Esistente:Boolean;
    EscludiValori:Boolean;
    CaseInsensitive:Boolean;
  end;

  TSelezioneFull = record
    NomeCampo,NomeLogico:String;
    Selezione:TSelezione;
  end;

  TC700SelAnagrafeBridge = record
    SQLCreato:String;
    Progressivo:Integer;
    SelezionePeriodica,
    SoloPersonaleInterno,
    SoloPersonaleInternoVal,
    AncheDipendentiCessati,
    AncheDipendentiCessatiVal:Boolean;
    SelezionePeriodicaVal:Integer;
  end;

  TWC700FSelezioneAnagrafeFM = class(TWR200FBaseFM)
    grdToolBar: TmeIWGrid;
    ActionList: TActionList;
    actEliminaSelezione: TAction;
    actAnnulla: TAction;
    actConferma: TAction;
    actlblSelezione: TAction;
    actcmbSelezione: TAction;
    actSalvaSelezione: TAction;
    actApriSelezione: TAction;
    actEseguiSelezione: TAction;
    actModificaSelezione: TAction;
    actAnnullaSelezione: TAction;
    lblPeriodoConsiderato: TmeIWLabel;
    rdgPeriodoConsiderato: TmeIWRadioGroup;
    lstAzienda: TmeIWListbox;
    chkDipendentiCessati: TmeIWCheckBox;
    chkPersonaleEsterno: TmeIWCheckBox;
    lblUguale: TmeIWLabel;
    lblDa: TmeIWLabel;
    lblA: TmeIWLabel;
    lblOppure: TmeIWLabel;
    jqAutoComplete: TIWJQueryWidget;
    edtUguale: TmeIWEdit;
    edtDa: TmeIWEdit;
    edtA: TmeIWEdit;
    lblOrdinamento: TmeIWLabel;
    lstOrdinamento: TmeIWListbox;
    chkgrpValori: TmeTIWCheckListBox;
    btnAggiungiOrdinamento: TmeIWButton;
    memModificaSelezione: TmeIWMemo;
    actConfermaSelezioneManuale: TAction;
    actAnnullaSelezioneManuale: TAction;
    grdAnteprima: TmedpIWDBGrid;
    pmnSelectionCheck: TPopupMenu;
    mnuSelezionaTutto: TMenuItem;
    mnuDeselezionaTutto: TMenuItem;
    mnuInvertiSelezione: TMenuItem;
    pmnRicerca: TPopupMenu;
    mnuRicercaCompleta: TMenuItem;
    meIWMemo1: TmeIWMemo;
    edtRicercaTesto: TmeIWEdit;
    btnSu: TmeIWImageFile;
    btnGiu: TmeIWImageFile;
    jqAutoCompleteDaA: TIWJQueryWidget;
    chkCaseInsensitive: TmeIWCheckBox;
    chkEscludiValori: TmeIWCheckBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure lstAziendaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure actAnnullaExecute(Sender: TObject);
    procedure lstAziendaAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure lstOrdinamentoAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure btnAggiungiOrdinamentoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure actAnnullaSelezioneExecute(Sender: TObject);
    procedure actEseguiSelezioneExecute(Sender: TObject);
    procedure actApriSelezioneExecute(Sender: TObject);
    procedure actSalvaSelezioneExecute(Sender: TObject);
    procedure actEliminaSelezioneExecute(Sender: TObject);
    procedure actModificaSelezioneExecute(Sender: TObject);
    procedure actConfermaSelezioneManualeExecute(Sender: TObject);
    procedure actAnnullaSelezioneManualeExecute(Sender: TObject);
    procedure grdAnteprimaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdAnteprimaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure mnuSelezionaTuttoClick(Sender: TObject);
    procedure mnuDeselezionaTuttoClick(Sender: TObject);
    procedure mnuInvertiSelezioneClick(Sender: TObject);
    procedure mnuRicercaCompletaClick(Sender: TObject);
    procedure chkDipendentiCessatiAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure edtRicercaTestoAsyncKeyUp(Sender: TObject; EventParams: TStringList);
    procedure btnSuAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnGiuAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure lstAziendaAsyncKeyUp(Sender: TObject; EventParams: TStringList);
    procedure edtUgualeAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtUgualeAsyncKeyUp(Sender: TObject; EventParams: TStringList);
  private
    PulisciVecchiaSelezione: Boolean;
    itemAziendaSelected : Integer;
    Componenti,SaveComponenti:TList;
    FDataLavoro,FDataDal : TDateTime;
    FSelezionePeriodica,
    FPersonaleInterno,
    FPersonaleInternoVal,
    FDipendentiCessati,
    FDipendentiCessatiVal : Boolean;
    FSelezionePeriodicaVal: Integer;
    ListSQL :  TStringList;
    ListSQLPeriodico,
    CorpoSQL:TStringList;
    SaveSelAnagrafe, SaveSQLCreato : TStringList;
    SaveProgressivo : Integer;
    SaveSingoloDipendente : Boolean;
    SaveRicercaCompleta:Boolean;
    SaveSelAnagrafeODS : TOracleDataSet;
    FDatiVisualizzati: String;
    FDatiSelezionati: String;
    FProgressivo: LongInt;
    FOpenSelAnagrafe: Boolean;
    SingoloDipendente : boolean;
    FSelAnagrafeBridge: TC700SelAnagrafeBridge;
    FNomeSelezioneCaricata: String;
    edtSelezione: TmeIWEdit;
    procedure CreaToolBar;
    procedure imgNavBarClick(Sender: TObject);
    procedure PulisciListaComponenti(var List: Tlist);
    procedure LoadDaSelezione(index : Integer);
    procedure SalvaSuSelezione(index : Integer);
    procedure GetCheck(Source:TStringList);
    procedure PutCheck(Dest:TStringList);
    procedure QueryDinamica(Modo : Integer);
    procedure setDatiVisualizzati(val : String);
    procedure setDatiSelezionati(val : String);
    procedure setProgressivo(val: LongInt);
    procedure GenerazioneSelezione;
    procedure SetSelezionePeriodica (val : boolean);
    function C700CompletaDatiSelezionati() :String;
    function IsCampoCaseInsensitive(Campo: String): Boolean;
    function PrefissoTabella(Campo:String):String;
    function GetHintT030V430(pCessati: Boolean):String;
    function GetCampiSelezionatiQueryDinamica(pModo: byte): string;
    function FormatoCampo(Campo:String; CaseInsensitive:Boolean; Tipo:String):String;
    function FormatoValore(Valore:String; CaseInsensitive:Boolean; Tipo:String):String;
    function ValoriSelezionati(Campo:String; Lista:TStringList; EscludiValori:Boolean; Tipo:String):String;
    procedure CaricaListSelezioni;
    procedure ResultSovrascrivi(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure SalvaSelezione;
    procedure ResultElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ModificaSelezioneManuale(val : boolean);
    procedure SalvaSelAnagrafeBridge;
    procedure setSelezionePeriodicaVal(const Value: Integer);
    procedure setPersonaleInterno(const Value: Boolean);
    procedure setPersonaleInternoVal(const Value: Boolean);
    procedure setDipendiCessati(const Value: Boolean);
    procedure setDipendiCessatiVal(const Value: Boolean);
    procedure CopiaListaComp(var ListSorgente: TList; var ListDestinazione: TList);
    procedure imgSingoloDipendenteClick(Sender: TObject);
    procedure CaricaLstAzienda(Completa: boolean);
    procedure CreaSave;
    procedure SvuotaSelezione(Sender: TObject);
    procedure SetElencoValoriDaA;
    function LeggiSQL: string;
  public
    SQLCreato :  TStringList;
    ResultEvent: TWC700ModalResultEvent;
    WC700NavigatorBar:TmeIWGrid;
    WC700DM:TWC700FSelezioneAnagrafeDM;
    SelezioneFull:array of TSelezioneFull;
    procedure ImpostazioniCampiSelAnagrafe(DataSet: TDataSet = nil);
    function getDatoVisualizzato(index: Integer): String;
    property C700DataLavoro : TDateTime read FDataLavoro write FDataLavoro;
    property C700DataDal : TDateTime read FDataDal write FDataDal;
    property C700DatiVisualizzati : String read FDatiVisualizzati write setDatiVisualizzati;
    property C700DatoVisualizzato[index:integer]: String read getDatoVisualizzato;//C700DatiVisualizzati.Split([','])[index]
    property C700DatiSelezionati : String read FDatiSelezionati write setDatiSelezionati;
    property C700Progressivo: LongInt read FProgressivo write setProgressivo;
    property C700OpenSelAnagrafe: Boolean read FOpenSelAnagrafe write FOpenSelAnagrafe;
    property C700SelezionePeriodica : Boolean read FSelezionePeriodica write setSelezionePeriodica;
    property C700SelezionePeriodicaVal : Integer read FSelezionePeriodicaVal write setSelezionePeriodicaVal;
    property C700PersonaleInterno : Boolean read FPersonaleInterno write setPersonaleInterno;
    property C700PersonaleInternoVal : Boolean read FPersonaleInternoVal write setPersonaleInternoVal;
    property C700DipendentiCessati : Boolean read FDipendentiCessati write setDipendiCessati;
    property C700DipendentiCessatiVal : Boolean read FDipendentiCessatiVal write setDipendiCessatiVal;
    property C700SelAnagrafeBridge: TC700SelAnagrafeBridge read FSelAnagrafeBridge;
    property C700NomeSelezioneCaricata: String read FNomeSelezioneCaricata;
    procedure Visualizza(const MinElementi:Integer = 0;const MaxElementi:Integer = 0);
    procedure C700MergeSelAnagrafe(ODS:TComponent; RicreaVariabili:Boolean = False);
    function C700MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
    function C700SettaPeriodoSelAnagrafe(DataDal,DataLavoro:TDateTime): Boolean;
    procedure C700CopiaTagFiltroAnag(ODS:TComponent);
    function C700ValueDatiVisualizzati(NomiCampi:Boolean = False): String;
    procedure C700ValuesDatiVisualizzati(Dati: TList<TItemsValues>);
    procedure C700StructDatiVisualizzati(Struct: TList<TItemsValues>);
    procedure ApriSelezione(Selezione:String);
    procedure EreditaSelezione(SelAnagrafeBridge: TC700SelAnagrafeBridge);
    procedure CreaSelezioneTotale;
    procedure RipristinaSelezione;
    procedure PreparaListSQL;
    procedure ReleaseOggetti; override;
    procedure SelezionePeriodicaDalAl(pSel: TOracleDataSet; pDal, pAl: TDateTime; pCorpoSQL:TStringList; pModo:byte; pCessati, pSoloInterni, pSingoloDipendente : Boolean);
  end;

implementation

uses medpIWC700NavigatorBar, WR010UBase;

{$R *.dfm}

function TWC700FSelezioneAnagrafeFM.ValoriSelezionati(Campo:String; Lista:TStringList; EscludiValori:Boolean; Tipo:String):String;
{ Gestione della lista con i valori per la costruzione
  della sintassi CAMPO1 IN (VALORE1, VALORE2,...) OR CAMPO1 IS NULL }
var i:Integer;
    Nullo:Boolean;
begin
  Result:='';
  Nullo:=False;

  // gestione della lista di valori
  for i:=0 to Lista.Count - 1 do
  begin
    if FormatoValore(Lista[i],False,Tipo) = '''''' then
      Nullo:=True
    else
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + FormatoValore(Lista[i],False,Tipo);
    end;
  end;
  if Result <> '' then
    Result:=FormatoCampo(Campo,False,Tipo) + IfThen(EscludiValori,' NOT') + ' IN (' + Result + ')';

  // gestione del valore null
  if Nullo then
  begin
    if Result <> '' then
    begin
      if EscludiValori then
        Result:='(' + Result + ' AND ' + Campo + ' IS NOT NULL' + ')'
      else
        Result:='(' + Result + ' OR ' + Campo + ' IS NULL' + ')';
    end
    else
      Result:=Campo + ' IS' + IfThen(EscludiValori,' NOT') + ' NULL';
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.CreaSave;
var i: Integer;
begin
  SaveSelAnagrafe:=TStringList.Create;
  SaveSQLCreato:=TStringList.Create;
  SaveSelAnagrafe.Assign(WC700DM.SelAnagrafe.SQL);
  SaveSQLCreato.Assign(SQLCreato);
  SaveSelAnagrafeODS:=TOracleDataSet.Create(nil);
  SaveSingoloDipendente:=SingoloDipendente;
  SaveRicercaCompleta:=mnuRicercaCompleta.Checked;
  for i:=0 to WC700DM.SelAnagrafe.VariableCount - 1 do
  begin
    SaveSelAnagrafeODS.DeclareVariable(WC700DM.selAnagrafe.VariableName(i),WC700DM.selAnagrafe.VariableType(i));
    SaveSelAnagrafeODS.SetVariable(WC700DM.SelAnagrafe.VariableName(i),WC700DM.SelAnagrafe.GetVariable(i));
  end;

  SaveProgressivo:=WC700DM.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TWC700FSelezioneAnagrafeFM.ImpostazioniCampiSelAnagrafe(DataSet: TDataSet = nil);
var i,j:Integer;
begin
  for i:=0 to WC700DM.selAnagrafe.FieldCount - 1 do
  begin
    for j:=0 to Parametri.ColonneStruttura.Count - 1 do
    begin
      if Parametri.ColonneStruttura.ValueFromIndex[j] = WC700DM.selAnagrafe.Fields[i].FieldName then
        WC700DM.selAnagrafe.Fields[i].DisplayLabel:=Parametri.ColonneStruttura.Names[j];
    end;
    WC700DM.selAnagrafe.Fields[i].Visible:=R180In(WC700DM.selAnagrafe.Fields[i].FieldName,('MATRICOLA,COGNOME,NOME,T430INIZIO,T430FINE,' + Parametri.DatiC700).Split([',']));
    if WC700DM.selAnagrafe.Fields[i] is TDateTimeField then
      WC700DM.selAnagrafe.Fields[i].DisplayWidth:=10
    else
      WC700DM.selAnagrafe.Fields[i].DisplayWidth:=20;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.Visualizza(const MinElementi:Integer; const MaxElementi:Integer);
var i : Integer;
    ListCampiAnteprima:TStringList;
  progIniziale: Integer;
  bSetprogIniziale: Boolean;
begin
  Visible:=True; //Necessario perchè nel css impostato come display none; non togliere a meno di rimuovere l'impostazione dal css
  //salvataggio dati per annulla
  with WC700DM do
  begin
    CreaSave;
    CaricaListSelezioni;
  end;

  ImpostazioniCampiSelAnagrafe;

  grdAnteprima.medpComandiCustom:=True;
  grdAnteprima.medpPaginazione:=True;

  grdAnteprima.medpRighePagina:=20;
  bSetprogIniziale:=False;
  progIniziale:=-1;
  if WC700DM.selAnagrafe.RecordCount > 0 then
  begin
    progIniziale:=WC700DM.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    bSetprogIniziale:=True;
  end;
  grdAnteprima.medpAttivaGrid(WC700DM.selAnagrafe,False,False);
  if SingoloDipendente then
    grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ANNULLA','','','')
  else
    grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','CONFERMA','','','');

  //Caratto 02/04/2013 In seguito alla modifica inserita nella DBGrid ( per avere medpComandiEdit e medpComandiCustom)
  //bisogna richiamare esplicitamente medpCaricaCDS in caso di medpComandiCustom;
  grdAnteprima.medpCaricaCDS;
  //devo resettare i componenti creati in precedenza, perchè non sempre uguali

  if bSetprogIniziale then
  begin
    WC700DM.selAnagrafe.SearchRecord('PROGRESSIVO',progIniziale,[srFromBeginning]);
    grdAnteprima.medpAggiornaCDS(False);
  end;


  (* Caratto 18/12/2012 la griglia anteprima visualizza i campi definiti
  Per la Wa001 i campi selezionati sono tutti, ma la grid deve visualizzare solo quelli base
  *)
  ListCampiAnteprima:=TStringList.Create;
  try
    ListCampiAnteprima.CommaText:=C700CampiAnteprima;
    //visibili solo le colonne prensenti nella stringlist
    for i:=0 to grdAnteprima.medpDataSet.FieldCount - 1 do
      if grdAnteprima.medpColonna(grdAnteprima.medpDataSet.Fields[i].FieldName) <> nil then
        grdAnteprima.medpColonna(grdAnteprima.medpDataSet.Fields[i].FieldName).Visible:=ListCampiAnteprima.IndexOf(grdAnteprima.medpDataSet.Fields[i].FieldName) > -1;
  finally
    FreeAndNil(ListCampiAnteprima);
  end;

  ModificaSelezioneManuale(False);
  //Carico i dati attualmente selezionati
  LoadDaSelezione(itemAziendaSelected);
  if Self.Parent is TWR010FBase then
    (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,800,-1,500, 'Selezione anagrafiche','#wc700_container',False,True)
  else
    raise Exception.Create('WC700: Self.Parent non è un TWR010FBase');
  if PulisciVecchiaSelezione then
    actAnnullaSelezioneExecute(nil);
end;

procedure TWC700FSelezioneAnagrafeFM.actAnnullaExecute(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  SQLCreato.Assign(SaveSQLCreato);
  if mnuRicercaCompleta.Checked <> SaveRicercaCompleta then
  begin
    mnuRicercaCompletaClick(nil);
  end;
  CopiaListaComp(SaveComponenti,Componenti);
  //SVUOTO elenco valori
  chkgrpValori.Items.Clear;
  with WC700DM do
  begin
    SelAnagrafe.SQL.Assign(SaveSelAnagrafe);
    SelAnagrafe.CloseAll;
    SelAnagrafe.DeleteVariables;
    for i:=0 to SaveSelAnagrafeODS.VariableCount - 1 do
    begin
      SelAnagrafe.DeclareVariable(SaveSelAnagrafeODS.VariableName(i),SaveSelAnagrafeODS.VariableType(i));
      SelAnagrafe.SetVariable(SaveSelAnagrafeODS.VariableName(i),SaveSelAnagrafeODS.GetVariable(i));
    end;
    SelAnagrafe.Open;
    SelAnagrafe.SearchRecord('PROGRESSIVO',SaveProgressivo,[srFromBeginning]);
  end;
  SingoloDipendente:=SaveSingoloDipendente;
  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,False);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;

  FreeAndNil(SaveSelAnagrafe);
  FreeAndNil(SaveSQLCreato);
  FreeAndNil(SaveSelAnagrafeODS);
  FreeAndNil(SaveSelAnagrafe);

  jQuery.OnReady.Clear;
  edtRicercaTesto.Text:='';
  Visible:=False;
end;

procedure TWC700FSelezioneAnagrafeFM.SvuotaSelezione(Sender: TObject);
var i : Integer;
begin
  try
    SQLCreato.Clear;
  except
    on E:Exception do
      RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.SvuotaSelezione - SQLCreato.Clear: ' + E.Message);
  end;

  if Sender = actAnnullaSelezione then
  begin
    edtSelezione.Text:='';
    Singolodipendente:=False;
  end;

  lstOrdinamento.Items.Clear;
  edtDa.Text:='';
  edtA.Text:='';
  edtUguale.Text:='';
  for i:=0 to lstazienda.Items.Count - 1 do
  begin
    try PSelezione(Componenti.Items[i]).Esistente:=False;       except on E:Exception do RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.SvuotaSelezione - Componenti.Items[i].Esistente: ' + E.Message); end;
    try PSelezione(Componenti.Items[i]).DaValore:='';           except on E:Exception do RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.SvuotaSelezione - Componenti.Items[i].DaValore: ' + E.Message); end;
    try PSelezione(Componenti.Items[i]).AValore:='';            except on E:Exception do RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.SvuotaSelezione - Componenti.Items[i].AValore: ' + E.Message); end;
    try PSelezione(Componenti.Items[i]).Valore:='';             except on E:Exception do RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.SvuotaSelezione - Componenti.Items[i].Valore: ' + E.Message); end;
    try PSelezione(Componenti.Items[i]).SelValori.Clear;        except on E:Exception do RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.SvuotaSelezione - Componenti.Items[i].SelValori.Clear: ' + E.Message); end;
    try PSelezione(Componenti.Items[i]).CaseInsensitive:=False; except on E:Exception do RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.SvuotaSelezione - Componenti.Items[i].CaseInsensitive: ' + E.Message); end;
    try PSelezione(Componenti.Items[i]).EscludiValori:=False;   except on E:Exception do RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.SvuotaSelezione - Componenti.Items[i].EscludiValori: ' + E.Message); end;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.actAnnullaSelezioneExecute(
  Sender: TObject);
begin
  inherited;

  SvuotaSelezione(Sender);
  if Sender = actAnnullaSelezione then
    actEseguiSelezioneExecute(actAnnullaSelezione);
end;

procedure TWC700FSelezioneAnagrafeFM.actAnnullaSelezioneManualeExecute(
  Sender: TObject);
begin
  inherited;
  ModificaSelezioneManuale(False);
end;

procedure TWC700FSelezioneAnagrafeFM.actApriSelezioneExecute(Sender: TObject);
var Trovato:Boolean;
begin
  inherited;
  FNomeSelezioneCaricata:='';
  with WC700DM.selT003Nome do
  begin
    Open;
    Filtered:=True;
    Trovato:=SearchRecord('NOME',Trim(edtSelezione.Text),[srFromBeginning]);
    Close;
  end;
  if not Trovato then
  begin
    MsgBox.MessageBox(A000MSG_C700_ERR_SELEZIONE_INESISTENTE,ERRORE);
    abort;
  end;

  actAnnullaSelezioneExecute(nil);
  with WC700DM.selT003 do
  begin
    Close;
    SetVariable('Nome',edtSelezione.Text);
    Open;
    SQLCreato.Clear;
    while not Eof do
    begin
      SQLCreato.Add(FieldByName('Riga').AsString);
      Next;
    end;
  end;
  actEseguiSelezioneExecute(nil);
  FNomeSelezioneCaricata:=Trim(edtSelezione.Text);
end;

procedure TWC700FSelezioneAnagrafeFM.actConfermaExecute(Sender: TObject);
var
  Prog: Integer;
begin
  inherited;
  Prog:=SaveProgressivo;
  if WC700DM.selAnagrafe.State <> dsInactive then
    Prog:=WC700DM.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;

  //Salva i dati sulla struttura TSelezione
  if lstazienda.Items.Count > 0 then
    lstAziendaAsyncChange(nil,nil);

  //Imposto il flag  in modo da restituire le colonne volute
  if (SQLCreato.Count = 0) then
    GenerazioneSelezione;

  QueryDinamica(2);

  WC700DM.selAnagrafe.Open;

  if not WC700DM.selAnagrafe.SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]) then
    WC700DM.selAnagrafe.First; //elemento non più presente in selAnagrafe. capita nel caso di modifica selezione e poi eredita

  SalvaSelAnagrafeBridge;

  ImpostazioniCampiSelAnagrafe;

  CopiaListaComp(Componenti,SaveComponenti);
  if Assigned(TmedpIWC700NavigatorBar(WC700NavigatorBar).AggiornaAnagr) then
    TmedpIWC700NavigatorBar(WC700NavigatorBar).AggiornaAnagr;
  if Assigned(TmedpIWC700NavigatorBar(WC700NavigatorBar).CambioProgressivoEvent) then
    TmedpIWC700NavigatorBar(WC700NavigatorBar).CambioProgressivoEvent(nil);
  TmedpIWC700NavigatorBar(WC700NavigatorBar).AllineaProgressivoSelezionePrincipale;

  if Sender = actConferma then
    PulisciVecchiaSelezione:=False;
  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,True);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
  jQuery.OnReady.Clear;
  Visible:=False;
  edtRicercaTesto.Text:='';

  //Distruzione oggetti creati su visualizza. da fare anche su annulla
  FreeAndNil(SaveSelAnagrafe);
  FreeAndNil(SaveSQLCreato);
  FreeAndNil(SaveSelAnagrafeODS);
end;

procedure TWC700FSelezioneAnagrafeFM.actConfermaSelezioneManualeExecute(
  Sender: TObject);
begin
  inherited;
  // split a 2000 caratteri per ogni riga di codice sql
  R180SplitLines(memModificaSelezione.Lines);
  SQLCreato.Assign(memModificaSelezione.Lines);
  actEseguiSelezioneExecute(nil);
  ModificaSelezioneManuale(False);
end;

procedure TWC700FSelezioneAnagrafeFM.actEliminaSelezioneExecute(Sender: TObject);
var Trovato:Boolean;
begin
  inherited;
  with WC700DM.selT003Nome do
  begin
    Open;
    Filtered:=True;
    Trovato:=SearchRecord('NOME',Trim(edtSelezione.Text),[srFromBeginning]);
    Close;
  end;
  if not Trovato then
    exit;
  MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResultElimina,'');
  abort;
end;

procedure TWC700FSelezioneAnagrafeFM.actEseguiSelezioneExecute(Sender: TObject);
var
  S: String;
begin
  inherited;
  if Sender = edtUguale then
  begin
    S:=Trim(edtUguale.Text);
    if S <> '' then
    begin
      SvuotaSelezione(actAnnullaSelezione);
      edtUguale.Text:=S;
    end;
  end;

  //Salva i dati sulla struttura TSelezione
  FNomeSelezioneCaricata:='';
  if lstazienda.Items.Count > 0 then
    lstAziendaAsyncChange(nil,nil);
  if Sender = actEseguiSelezione then
    SingoloDipendente:=false;

  if (SQLCreato.Count = 0) then
    GenerazioneSelezione;

  QueryDinamica(1);

  //Alberto 16/06/2006: se si preme 'Annulla selezione' si esegue l'anteprima vuota con la condizione T030.PROGRESSIVO = 0
  if (Sender = actAnnullaSelezione) then
  begin
    S:=WC700DM.selAnagrafe.SQL.Text;
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      Insert(' AND T030.PROGRESSIVO = 0 ',S,Pos('ORDER BY',UpperCase(S)))
    else
      S:=S + ' AND T030.PROGRESSIVO = 0';
    WC700DM.selAnagrafe.SQL.Text:=S;
  end;

  try
    WC700DM.selAnagrafe.Open;
  except
    SQLCreato.Clear;
    GenerazioneSelezione;
    if (Sender = actAnnullaSelezione) then
    begin
      S:=WC700DM.selAnagrafe.SQL.Text;
      if Pos('ORDER BY',UpperCase(S)) > 0 then
        Insert(' AND T030.PROGRESSIVO = 0 ',S,Pos('ORDER BY',UpperCase(S)))
      else
        S:=S + ' AND T030.PROGRESSIVO = 0';
      WC700DM.selAnagrafe.SQL.Text:=S;
    end;
  end;
  (*
  try
    with TOracleQuery.Create(nil) do
    try
      Session:=WC700DM.selAnagrafe.Session;
      begin
        Variables.Assign(WC700DM.selAnagrafe.Variables);
        SQL.Assign(WC700DM.selAnagrafe.SQL);

        S:=SQL.Text;
        if Pos('ORDER BY',UpperCase(S)) > 0 then
          Insert(' AND T030.PROGRESSIVO = 0 ',S,Pos('ORDER BY',UpperCase(S)))
        else
          S:=S + ' AND T030.PROGRESSIVO = 0';
        SQL.Text:=S;
      end;
      Describe;
    finally
      Free;
    end;
  except
    SQLCreato.Clear;
    GenerazioneSelezione;
  end;
  *)
  (*
  //Alberto 16/06/2006: se si preme 'Annulla selezione' si esegue l'anteprima vuota con la condizione T030.PROGRESSIVO = 0
  if (Sender = actAnnullaSelezione) then
  begin
    S:=WC700DM.selAnagrafe.SQL.Text;
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      Insert(' AND T030.PROGRESSIVO = 0 ',S,Pos('ORDER BY',UpperCase(S)))
    else
      S:=S + ' AND T030.PROGRESSIVO = 0';
    WC700DM.selAnagrafe.SQL.Text:=S;
  end;
  WC700DM.selAnagrafe.Open;
  *)
  if Visible then //se non è visibile non aggiorno. es richiamo da WA023 per correzione
  begin
    if SingoloDipendente then
      grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ANNULLA','','','')
    else
      grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','CONFERMA','','','');
    grdAnteprima.medpAggiornaCDS(True);
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.actModificaSelezioneExecute(Sender: TObject);
begin
  inherited;

  ModificaSelezioneManuale(True);

  if SQLCreato.Count = 0 then
    GenerazioneSelezione;

  memModificaSelezione.Lines.Assign(SQLCreato);
end;

procedure TWC700FSelezioneAnagrafeFM.actSalvaSelezioneExecute(Sender: TObject);
var
  NewSelezione,Abilitato: Boolean;
begin
  inherited;
  if Trim(edtSelezione.Text) = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_C700_ERR_NO_SELEZIONE,mtError,[mbOK],nil,'');
    abort;
  end;

  if lstazienda.Items.Count > 0 then
    lstAziendaAsyncChange(nil,nil);

  if SQLCreato.Count = 0 then
    GenerazioneSelezione;

  NewSelezione:=False;
  with WC700DM.selT003Nome do
  begin
    Open;
    //Verifico esistenza in tutte le selezioni, indipendentemente dal filtro dizionario
    Filtered:=False;
    NewSelezione:=not SearchRecord('NOME',Trim(edtSelezione.Text),[srFromBeginning]);
    //Verifico esistenza nel proprio filtro dizionario
    Filtered:=True;
    Abilitato:=SearchRecord('NOME',Trim(edtSelezione.Text),[srFromBeginning]);
    Close;
  end;

  if not NewSelezione then
  begin
   if (Parametri.C700_SalvaSelezioni <> 'S') or (not Abilitato) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_C700_ERR_FMT_SEL_GIA_ESISTENTE,[edtSelezione.Text]),mtError,[mbOK],nil,'');
      abort;
    end
    else
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_C700_DLG_FMT_SEL_GIA_ESISTENTE,[edtSelezione.Text]),mtConfirmation,[mbYES,mbNO],ResultSovrascrivi,'');
      abort;
    end
  end;
  SalvaSelezione;
end;

procedure TWC700FSelezioneAnagrafeFM.btnAggiungiOrdinamentoAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if itemAziendaSelected < 0 then
  begin
    RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.btnAggiungiOrdinamentoAsyncClick - itemAziendaSelected = ' + itemAziendaSelected.ToString);
  end
  else if (lstOrdinamento.Items.IndexOf(lstAzienda.Items[itemAziendaSelected]) = -1 )then
  begin
    lstOrdinamento.Items.Add(lstAzienda.Items[itemAziendaSelected]);
    if (lstOrdinamento.itemIndex = -1) then
      lstOrdinamento.ItemIndex:=0;
  end;
  SQLCreato.Clear;
  edtSelezione.Text:='';
end;

function TWC700FSelezioneAnagrafeFM.C700CompletaDatiSelezionati: String;
var lstS,lstV:TStringList;
    i:Integer;
    EsisteT030Full:Boolean;
begin
  Result:=C700DatiSelezionati;
  if Result = C700TuttiCampi then
    exit;
  lstS:=TStringList.Create;
  lstV:=TStringList.Create;
  try
    EsisteT030Full:=Pos('T030.*',UpperCase(C700DatiSelezionati)) > 0;
    lstS.AddStrings(StringReplace(UpperCase(C700DatiSelezionati),'T030.','',[rfReplaceAll]).Split([',']));
    lstV.AddStrings(UpperCase(C700DatiVisualizzati).Split([',']));
    for i:=0 to lstV.Count - 1 do
      if lstS.IndexOf(lstV[i]) = -1 then
      begin
        //Non aggiungo la colonna se è della T030, e C700DatiSelezionati contiene già T030.*
        if (not EsisteT030Full) or (AliasTabella(lstV[i]) <> 'T030') then
        begin
          lstS.Add(lstV[i]);
          if Result <> '' then
            Result:=Result + ',';
          Result:=Result + lstV[i];
        end;
      end;
  finally
    lstS.Free;
    lstV.Free;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.CaricaListSelezioni;
var Elementi : String;
begin
  with WC700DM do
  begin
    selT003Nome.Open;
    Elementi:='';
    while not selT003Nome.Eof do
    begin
      Elementi:=Elementi + '''' + C190EscapeJs(selT003Nome.FieldByName('NOME').AsString) + ''',';
      selT003Nome.Next;
    end;
    selT003Nome.Close;
  end;
  if Elementi <> '' then
  begin
    JQAutoComplete.OnReady.Text:=
           'var ListSelezioni = [' + Copy(Elementi,1,Length(Elementi) - 1) + '];' + CRLF +
           '$("#' + edtSelezione.HTMLName + '").autocomplete({' + CRLF +
           //'  source: elementi,' + CRLF +
           '  source: ListSelezioni,' + CRLF +
           '  delay: 0,' + CRLF +
           '  minLength: 0' + CRLF +
           '}).focus(function(){ ' + CRLF +
           '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
           '}); ';
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.CopiaListaComp(var ListSorgente: TList; var ListDestinazione: TList);
var
  P : PSelezione;
  i,j: Integer;
begin
  PulisciListaComponenti(ListDestinazione);
  for i:=0 to ListSorgente.Count - 1 do
  begin
    New(P);
    j:=ListDestinazione.Add(P);
    PSelezione(ListDestinazione.Items[j]).DaValore:=PSelezione(ListSorgente.Items[i]).DaValore;
    PSelezione(ListDestinazione.Items[j]).AValore:=PSelezione(ListSorgente.Items[i]).AValore;
    PSelezione(ListDestinazione.Items[j]).Valore:=PSelezione(ListSorgente.Items[i]).Valore;
    PSelezione(ListDestinazione.Items[j]).TotValori:=TStringList.Create;
    PSelezione(ListDestinazione.Items[j]).TotValori.Assign(PSelezione(ListSorgente.Items[i]).TotValori);
    PSelezione(ListDestinazione.Items[j]).SelValori:=TStringList.Create;
    PSelezione(ListDestinazione.Items[j]).SelValori.Assign(PSelezione(ListSorgente.Items[i]).SelValori);
    PSelezione(ListDestinazione.Items[j]).Esistente:=PSelezione(ListSorgente.Items[i]).Esistente;
    PSelezione(ListDestinazione.Items[j]).CaseInsensitive:=PSelezione(ListSorgente.Items[i]).CaseInsensitive;
    PSelezione(ListDestinazione.Items[j]).EscludiValori:=PSelezione(ListSorgente.Items[i]).EscludiValori;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.CreaToolBar;
var
  i, k:Integer;
  PrecCategory: String;
begin
  grdToolBar.RowCount:=1;
  grdToolBar.ColumnCount:=ActionList.ActionCount;

  if ActionList.ActionCount > 0 then
    PrecCategory:=TAction(ActionList.Actions[0]).Category;

  k:=0;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(ActionList.Actions[i]).Category  then
    begin
      grdToolBar.Cell[0,k].Text:='';
      k:=k + 1;
      grdToolBar.ColumnCount:=grdToolBar.ColumnCount + 1;
      PrecCategory:=TAction(ActionList.Actions[i]).Category;
    end;

    grdToolBar.Cell[0,k].Text:='';
    if TAction(ActionList.Actions[i]) = actcmbSelezione then
    begin
      grdToolBar.Cell[0,k].Control:=TmeIWEdit.Create(Self);
      edtSelezione:=TmeIWEdit(grdToolBar.Cell[0,k].Control);
      //CARATTO 15/01/2014 alberto: mantenere la selezione scelta. svuotare solo in creazione
      edtSelezione.Text:='';
      edtSelezione.Tag:=i;
      edtSelezione.Name:='cmbSelezione';//C190CreaNomeComponente('cmbSelezione',Self.Owner);//
      edtSelezione.Css:='width30chr';
    end
    else if TAction(ActionList.Actions[i]) = actlblSelezione then
    begin
      grdToolBar.Cell[0,k].Text:=' Selezione: ';
      grdToolBar.Cell[0,k].Css:='intestazione';
    end
    else
    begin
      grdToolBar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
      TmeIWImageFile(grdToolBar.Cell[0,k].Control).OnClick:=imgNavBarClick;
      TmeIWImageFile(grdToolBar.Cell[0,k].Control).Tag:=i;
    end;

    k:=k + 1;
  end;
  (*TWR100FBase(Self.Parent).*)C190AggiornaToolBar(grdToolBar, ActionList);
end;

function TWC700FSelezioneAnagrafeFM.FormatoCampo(Campo:String; CaseInsensitive:Boolean; Tipo:String):String;
{ se il campo rientra nella lista di quelli da trattare come "case insensitive"
  utilizza il formato "UPPER(CAMPO)"
  altrimenti lascia il campo inalterato }
begin
  Result:=Campo;
  if (TFieldType(StrToInt(Tipo)) = ftString) and CaseInsensitive then
    Result:='UPPER(' + Result + ')';
end;

function TWC700FSelezioneAnagrafeFM.FormatoValore(Valore:String; CaseInsensitive:Boolean; Tipo:String):String;
{Formatta il valore inserendo gli apici se stringa,
 e trasformando la data in dd/mm/yyyy
 Inoltre valuta se considerare il campo case insensitive, utilizzando il formato
 "UPPER(campo)" (ha senso solo per i campi di tipo string) }
begin
  if Valore = '' then
    Result:=''''''
  else
  case TFieldType(StrToInt(Tipo)) of
    ftString:
    begin
      Result:='''' + AggiungiApice(Valore) + '''';
      if CaseInsensitive then
        Result:='UPPER(' + Result + ')';
    end;
    ftTime:
      Result:='''' + AggiungiApice(Valore) + '''';
    ftDate,ftDateTime:
      Result:='''' + FormatDateTime('dd/mm/yyyy',StrToDate(Valore)) + '''';
    else
      Result:=Valore;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.GenerazioneSelezione;
var i,P : Integer;
    Da,A,Campo1,Valore,Oppure,Valore1,Valore2,VecchioMemo,Ordina,TipoStruttura : String;
    locCaseInsensitive:Boolean;
begin
  //Memorizzo la vecchia selezione e tolgo la parte ORDER BY
  VecchioMemo:=SQLCreato.Text;
  i:=Pos('ORDER BY',VecchioMemo);
  if i > 0 then
    VecchioMemo:=Copy(VecchioMemo,1,i - 1);
  SQLCreato.Clear;
  for i:=0 to lstAzienda.Items.Count - 1 do
  begin
    //Costruzione CAMPO1 >= ... AND CAMPO1 <= ...
    Da:='';
    A:='';
    Oppure:='';
    //Imposto il prefisso della tabella prima del campo
    Campo1:=PrefissoTabella(Parametri.ColonneStruttura.Values[lstAzienda.Items[i]]);
    Valore:=PSelezione(Componenti.Items[i]).Valore;
    Valore1:=PSelezione(Componenti.Items[i]).DaValore;
    Valore2:=PSelezione(Componenti.Items[i]).AValore;
    P:=Parametri.ColonneStruttura.IndexOfName(lstAzienda.Items[i]);
    locCaseInsensitive:=PSelezione(Componenti.Items[i]).CaseInsensitive;
    TipoStruttura:=Parametri.TipiStruttura[P];
    if (Valore <> '') then
    begin
      //valore puntuale
      Da:=FormatoCampo(Campo1,locCaseInsensitive,TipoStruttura) + ' LIKE ' + FormatoValore(Valore,locCaseInsensitive,TipoStruttura)
    end
    else if (Valore1 <> '') and (Valore2 <> '') then
    begin
      if Valore1 = Valore2 then
      begin
        if Pos('%',Valore1) = 0 then
          Da:=FormatoCampo(Campo1,locCaseInsensitive,TipoStruttura) + ' = ' + FormatoValore(Valore1,locCaseInsensitive,TipoStruttura)
        else
          Da:=FormatoCampo(Campo1,locCaseInsensitive,TipoStruttura) + ' LIKE ' +  FormatoValore(Valore1,locCaseInsensitive,TipoStruttura);
      end
      else
        Da:=Format('%s BETWEEN %s AND %s',[FormatoCampo(Campo1,locCaseInsensitive,TipoStruttura),FormatoValore(Valore1,locCaseInsensitive,TipoStruttura),FormatoValore(Valore2,locCaseInsensitive,TipoStruttura)])
    end
    else
    begin
      if Valore1 <> '' then
        Da:=FormatoCampo(Campo1,locCaseInsensitive,TipoStruttura) + ' >= ' + FormatoValore(Valore1,locCaseInsensitive,TipoStruttura);
      if Valore2 <> '' then
        A:=FormatoCampo(Campo1,locCaseInsensitive,TipoStruttura) + ' <= ' + FormatoValore(Valore2,locCaseInsensitive,TipoStruttura);
      if (Da <> '') and (A <> '') then
        Da:=Da + ' AND ';
      Da:=Da + A;
    end;
    if Da <> '' then Da:='(' + Da + ')';
    //Costruzione CAMPO1 IN (...)
    Oppure:=ValoriSelezionati(Campo1,PSelezione(Componenti.Items[i]).SelValori,PSelezione(Componenti.Items[i]).EscludiValori,TipoStruttura);
    //if Oppure <> '' then Oppure:='(' + Oppure + ')';
    if (Da <> '') and (Oppure <> '') then
      Da:=Da + ' OR ';
    Da:=Da + Oppure;
    if Da <> '' then
    begin
      Da:='(' + Da + ')';
      if SQLCreato.Count > 0 then
        Da:=' AND ' + Da;
      SQLCreato.Add(Da);
    end;
  end;
  //Se è cambiata la selezione reimposto Esistente = False
  //per tutti i dati
  if VecchioMemo <> SQLCreato.Text then
  begin
    for i:=0 to lstAzienda.Items.Count - 1 do
      PSelezione(Componenti.Items[i]).Esistente:=False;
    chkgrpValori.Items.Clear; //svuoto eventuali elementi caricati
  end;
  Ordina:='';
  for i:=0 to lstOrdinamento.Items.Count - 1 do
    Ordina:=Ordina + ', ' + PrefissoTabella(Parametri.ColonneStruttura.Values[lstOrdinamento.Items[i]]);
  if lstOrdinamento.Items.IndexOf('COGNOME') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('COGNOME');
  if lstOrdinamento.Items.IndexOf('NOME') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('NOME');
  if lstOrdinamento.Items.IndexOf('MATRICOLA') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('MATRICOLA');
  if Ordina <> '' then
    SQLCreato.Add('ORDER BY ' + Copy(Ordina,3,Length(Ordina)));
  // split a 2000 caratteri per ogni riga di codice sql
  R180SplitLines(SQLCreato);
end;

procedure TWC700FSelezioneAnagrafeFM.GetCheck(Source: TStringList);
{Leggo gli Items di Source e li Checko in CBValori}
var i,j:Integer;
begin
  //devo resettari i valori selezionati altrimenti la chkgrp li mantiene
  for i:=0 to chkgrpValori.Items.Count do
    chkgrpValori.Selected[i]:=False;

  for i:=0 to Source.Count - 1 do
  begin
    j:=chkgrpValori.Items.IndexOf(Source[i]);
    if j > -1 then
      chkgrpValori.Selected[j]:=True;
  end;
end;

function TWC700FSelezioneAnagrafeFM.getDatoVisualizzato(index: Integer): String;
begin
  Result:='';
  if Length(C700DatiVisualizzati.Split([','])) > index then
    Result:=C700DatiVisualizzati.Split([','])[index];
end;

procedure TWC700FSelezioneAnagrafeFM.grdAnteprimaAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var r : Integer;
    img : TmeIWImageFile;
begin
  inherited;
  for r:=0 to High(grdAnteprima.medpCompGriglia) do
  if grdAnteprima.medpCompCella(r,grdAnteprima.medpIndexColonna('DBG_COMANDI'),0) <> nil then
  begin
    img:=(grdAnteprima.medpCompCella(r,grdAnteprima.medpIndexColonna('DBG_COMANDI'),0) as TmeIWImageFile);
    img.OnClick:=imgSingoloDipendenteClick;
    if SingoloDipendente then
      img.Hint:='Annulla singolo dipendente'
    else
      img.Hint:='Singolo dipendente';
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.grdAnteprimaRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  DataInizioRap,
  DataFineRap: TDateTime;
  NumColonna: Integer;
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  if ARow = 0 then Exit;

  if grdAnteprima.medpClientDataset.RecNo <> ARow then
  begin
    grdAnteprima.medpClientDataset.First;
    grdAnteprima.medpClientDataset.MoveBy(ARow);
  end;


  with grdAnteprima.medpClientDataset do
  begin
    if (Active) and (RecordCount > 0) then
    begin
      DataInizioRap:=FieldByName('T430INIZIO').AsDateTime;
      if DataInizioRap = 0 then
        DataInizioRap:=EncodeDate(1899,12,30);
      DataFineRap:=FieldByName('T430FINE').AsDateTime;
      if DataFineRap = 0 then
        DataFineRap:=EncodeDate(3999,12,31);
      if ((rdgPeriodoConsiderato.ItemIndex = 0) and ((DataInizioRap > FDataLavoro) or (DataFineRap < FDataLavoro))) or
         ((rdgPeriodoConsiderato.ItemIndex = 1) and
          ((FDataLavoro < DataInizioRap) or
           (((grdAnteprima.medpDataSet as TOracleDataset).VariableIndex('C700DATADAL') >= 0) and (R180VarToDateTime((grdAnteprima.medpDataSet as TOracleDataset).GetVariable('C700DATADAL')) > DataFineRap))
         )) then
        ACell.Css:=ACell.Css + ' font_rosso';
    end;
  end;

  NumColonna:=grdAnteprima.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdAnteprima.medpCompGriglia) + 1) and (grdAnteprima.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdAnteprima.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    if ACell.Control is TmeIWImageFile then
      TmeIWImageFile(ACell.Control).Tag:=grdAnteprima.medpClientDataset.FieldByName('PROGRESSIVO').AsInteger;
  end;

end;

procedure TWC700FSelezioneAnagrafeFM.imgSingoloDipendenteClick(Sender: TObject);
var
 Progressivo: Integer;
begin
  inherited;
  Progressivo:=(Sender as TmeIWImageFile).Tag;

  SingoloDipendente:=not SingoloDipendente;

  if (SingoloDipendente)  then
  begin
    C700Progressivo:=Progressivo;
  end
  else
    C700Progressivo:=-1;
  actEseguiSelezioneExecute(nil);
end;

procedure TWC700FSelezioneAnagrafeFM.imgNavBarClick(Sender: TObject);
begin
  TAction(ActionList.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

function TWC700FSelezioneAnagrafeFM.IsCampoCaseInsensitive(
  Campo: String): Boolean;
{ Determina se un campo deve essere trattato in modo
  da non considerare differenza fra maiuscole e minuscole. }
//var
//  NomeCampo: String;
//  i: Integer;
begin
  // gestione commentata per il momento
  {
  i:=Pos('.',Campo);
  NomeCampo:=Copy(Campo,i + 1,Length(Campo) - i);
  Result:=(NomeCampo = 'COGNOME');
  }
  Result:=False;
end;

procedure TWC700FSelezioneAnagrafeFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  PulisciVecchiaSelezione:=True;
  lstOrdinamento.NoSelectionText:='';
  Componenti:=TList.Create;
  SaveComponenti:=TList.Create;
  CorpoSQL:=TStringList.Create;
  SQLCreato:=TStringList.Create;
  ListSQLPeriodico:=TStringList.Create;
  SingoloDipendente:=False;
  FNomeSelezioneCaricata:='';
  SaveSingoloDipendente:=SingoloDipendente;
  SaveRicercaCompleta:=mnuRicercaCompleta.Checked;

  //inizializzazione. I valori verranno impostati tramite le property
  FDataLavoro:=Parametri.DataLavoro;
  FDatiVisualizzati:=Parametri.DatiC700;
  //setto tramite property
  C700DatiSelezionati:='';

  ListSQL:=TStringList.Create;
  PreparaListSQL;
  caricaLstAzienda(False);
  //Creo lista componenti salvataggio vecchi valori
  CopiaListaComp(Componenti,SaveComponenti);

  if lstAzienda.Items.Count > 0 then
  begin
    lstAzienda.itemIndex:=0;
    itemAziendaSelected:=lstAzienda.itemIndex;
  end;

  CreaToolBar;
  if Self.Parent is TWR010FBase then
    (Self.Parent as TWR010FBase).WaterMarkEnabled:=True;
end;

procedure TWC700FSelezioneAnagrafeFM.PreparaListSQL;
var i: Integer;
    S,HintUnnest : String;
begin
  if ListSQL = nil then Exit;

  ListSQL.Text:=QVistaOracle;
  ListSQL.Insert(0,Format('SELECT %s %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,C700DatiSelezionati]));
  //Leggo le inbizioni
  with Parametri.Inibizioni do
  begin
    if (Count > 0) and (Strings[0] <> '') then
    begin
      ListSQL.Add('AND');
      ListSQL.Add(TAG_FILTRO_ANAG_INIZIO);
      for i:=0 to Count - 1 do
        ListSQL.Add(Strings[i]);
      ListSQL.Add(TAG_FILTRO_ANAG_FINE);
    end
    else
    begin
      ListSQL.Add(TAG_FILTRO_ANAG_INIZIO);
      ListSQL.Add(TAG_FILTRO_ANAG_FINE);
    end;
  end;

  ListSQLPeriodico.Clear;
  ListSQLPeriodico.Add(Format('SELECT %s %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,C700DatiSelezionati]));
  ListSQLPeriodico.Add(QVistaOracle);
  ListSQLPeriodico.Add('AND T030.PROGRESSIVO IN (');
  // utilizzo hint "unnest" - daniloc. 22.11.2010
  // nota: la distinct è stata rimossa dopo alcune verifiche statistiche sui tempi di esecuzione
  //ListSQLPeriodico.Add('  SELECT DISTINCT PROGRESSIVO FROM');
  HintUnnest:='/*+ HintT030V430 UNNEST */';
  ListSQLPeriodico.Add(Format('  SELECT %s PROGRESSIVO FROM',[HintUnnest]));
  // utilizzo hint "unnest".fine
  S:=StringReplace(QVistaOracle,':DATALAVORO BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                                 ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                                 [rfIgnoreCase]);
  {P430}
  if Parametri.V430 = 'P430' then
    S:=StringReplace(S,':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                       ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                       [rfIgnoreCase]);
  ListSQLPeriodico.Add(S);
  //Leggo le inibizioni
  with Parametri.Inibizioni do
  begin
    if (Count > 0) and (Strings[0] <> '') then
    begin
      ListSQLPeriodico.Add('AND');
      ListSQLPeriodico.Add(TAG_FILTRO_ANAG_INIZIO);
      for i:=0 to Count - 1 do
         ListSQLPeriodico.Add(Strings[i]);
      ListSQLPeriodico.Add(TAG_FILTRO_ANAG_FINE);
    end
    else
    begin
      ListSQLPeriodico.Add(TAG_FILTRO_ANAG_INIZIO);
      ListSQLPeriodico.Add(TAG_FILTRO_ANAG_FINE);
    end;
  end;
  ListSQLPeriodico.Add(':C700FILTRO)');
end;

procedure TWC700FSelezioneAnagrafeFM.CaricaLstAzienda(Completa: boolean);
var
   j : Integer;
   P : PSelezione;
   S : String;
   SelezioneFullVuota: Boolean;
begin
  SelezioneFullVuota:=Length(SelezioneFull) = 0;
  PulisciListaComponenti(Componenti);
  lstAzienda.Items.Clear;
  lstAzienda.OnAsyncChange:=nil;
  with WR000DM.cdsI010 do
  begin
    First;
    while not Eof do
    begin
      if (Completa) or ((FieldByName('RICERCA').AsInteger <> RICERCA_NULL) and (FieldByName('RICERCA').AsInteger >= 0))   then
      begin
        S:=FieldByName('NOME_CAMPO').AsString;
        if Copy(S,1,6) = 'T430D_' then
          S:=Copy(S,7,Length(S))
        else if Copy(S,1,4) = 'T430' then
          S:=Copy(S,5,Length(S));
        //Caratto 31/03/2015 Utente: TORINO_CITTADELLASALUTE Chiamata: 90312; verifica per accesso <> N e non ='S' per avere anche i campi reaonly
        if (Copy(S,1,4) = 'P430') or (S = 'PROGRESSIVO') or
           (Parametri.Layout = '') or (FieldByName('ACCESSO').AsString <> 'N' ) then
        begin
          lstAzienda.Items.Add(FieldByName('NOME_LOGICO').AsString);
          New(P);
          j:=Componenti.Add(P);
          PSelezione(Componenti.Items[j]).DaValore:='';
          PSelezione(Componenti.Items[j]).AValore:='';
          PSelezione(Componenti.Items[j]).Valore:='';
          PSelezione(Componenti.Items[j]).TotValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).SelValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).Esistente:=False;
          PSelezione(Componenti.Items[j]).EscludiValori:=False;
          PSelezione(Componenti.Items[j]).CaseInsensitive:=False;
        end;
      end;
      //Ricerca completa
      if SelezioneFullVuota then
      begin
        SetLength(SelezioneFull,Length(SelezioneFull) + 1);
        j:=High(SelezioneFull);
        SelezioneFull[j].NomeCampo:=FieldByName('NOME_CAMPO').AsString;
        SelezioneFull[j].NomeLogico:=FieldByName('NOME_LOGICO').AsString;
        SelezioneFull[j].Selezione.DaValore:='';
        SelezioneFull[j].Selezione.AValore:='';
        SelezioneFull[j].Selezione.Valore:='';
        SelezioneFull[j].Selezione.TotValori:=TStringList.Create;
        SelezioneFull[j].Selezione.SelValori:=TStringList.Create;
        SelezioneFull[j].Selezione.Esistente:=False;
        SelezioneFull[j].Selezione.EscludiValori:=False;
        SelezioneFull[j].Selezione.CaseInsensitive:=False;
      end;
      WR000DM.cdsI010.Next;
    end;
  end;
  lstAzienda.OnAsyncChange:=lstAziendaAsyncChange;
end;

procedure TWC700FSelezioneAnagrafeFM.chkDipendentiCessatiAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  FDipendentiCessatiVal:=chkDipendentiCessati.Checked;
end;

procedure TWC700FSelezioneAnagrafeFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  //sul render perchè posso cambiare data lavoro da una form all'altra
  if rdgPeriodoConsiderato.Enabled then
    lblPeriodoConsiderato.Caption:='Periodo considerato'
  else
    lblPeriodoConsiderato.Caption:='Periodo considerato (' + DateToStr(C700DataLavoro) + ')';

  rdgPeriodoConsiderato.Items[0]:='al ' + FormatDateTime('dd/mm/yyyy',FDataLavoro);
  rdgPeriodoConsiderato.Items[1]:='dal ' + FormatDateTime('dd/mm/yyyy',FDataDal) + ' al ' + FormatDateTime('dd/mm/yyyy',FDataLavoro);
  (Self.Parent as TWR010FBase).AddToInitProc(jqAutoCompleteDaA.OnReady.Text);
end;

procedure TWC700FSelezioneAnagrafeFM.SalvaSelAnagrafeBridge;
begin
  FSelAnagrafeBridge.SQLCreato:=SQLCreato.Text;
  FSelAnagrafeBridge.Progressivo:=C700Progressivo;
  FSelAnagrafeBridge.SelezionePeriodica:=FSelezionePeriodica;
  FSelAnagrafeBridge.SelezionePeriodicaVal:=rdgPeriodoConsiderato.ItemIndex;
  FSelAnagrafeBridge.SoloPersonaleInterno:=FPersonaleInterno;
  FSelAnagrafeBridge.SoloPersonaleInternoVal:=chkPersonaleEsterno.Checked;
  FSelAnagrafeBridge.AncheDipendentiCessati:=FDipendentiCessati;
  FSelAnagrafeBridge.AncheDipendentiCessatiVal:=chkDipendentiCessati.Checked;
end;

procedure TWC700FSelezioneAnagrafeFM.SalvaSelezione;
var
  i: Integer;
  LogValOld, LogValNew: string;
begin
  with WC700DM do
  begin
    LogValNew:='';
    LogValOld:=LeggiSQL;

    delT003.SetVariable('Nome',edtSelezione.Text);
    delT003.Execute;

    insT003.SetVariable('Nome',edtSelezione.Text);
    for i:=0 to SQLCreato.Count - 1 do
    begin
      if Trim(SQLCreato[i]) <> '' then
      begin
        insT003.SetVariable('Posizione',i);
        insT003.SetVariable('Riga',Trim(SQLCreato[i]));
        LogValNew:=LogValNew + IfThen(LogValNew <> '', ' ') + Trim(SQLCreato[i]);
        insT003.Execute;
      end;
    end;

    RegistraLog.SettaProprieta('C', 'T003_SELEZIONIANAGRAFE','WA002', nil, True);
    RegistraLog.InserisciDato('NOME', IfThen(LogValOld <> '', edtSelezione.Text), edtSelezione.Text);
    RegistraLog.InserisciDato('RIGA', LogValOld, LogValNew);
    RegistraLog.RegistraOperazione;

    insT003.Session.Commit;
    A000AggiornaFiltroDizionario('SELEZIONI ANAGRAFICHE','',edtSelezione.Text);
  end;
  CaricaListSelezioni;

  MsgBox.WebMessageDlg(A000MSG_MSG_SALVATAGGIO_AVVENUTO,mtInformation,[mbOK],nil,'');
end;

procedure TWC700FSelezioneAnagrafeFM.SalvaSuSelezione(index: Integer);
var
 OldValore, OldDa, OldA, OldIn: String;
 Old_EscludiValori, Old_CaseInsensitive:Boolean;
begin
  if index < 0 then
  begin
    RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.SalvaSuSelezione - index = ' + index.ToString);
    exit;
  end;

  OldValore:=PSelezione(Componenti.Items[index]).Valore;
  OldDa:=PSelezione(Componenti.Items[index]).DaValore;
  OldA:=PSelezione(Componenti.Items[index]).AValore;
  OldIn:=PSelezione(Componenti.Items[index]).SelValori.Text;
  Old_CaseInsensitive:=PSelezione(Componenti.Items[index]).CaseInsensitive;
  Old_EscludiValori:=PSelezione(Componenti.Items[index]).EscludiValori;

  PSelezione(Componenti.Items[index]).Valore:=edtUguale.Text;
  PSelezione(Componenti.Items[index]).DaValore:=edtDa.Text;
  PSelezione(Componenti.Items[index]).AValore:=edtA.Text;
  PSelezione(Componenti.Items[index]).CaseInsensitive:=False;
  if (edtUguale.Text <> '') or (edtDa.Text <> '') or (edtA.Text <> '') then
    PSelezione(Componenti.Items[index]).CaseInsensitive:=chkCaseInsensitive.Checked;

  chkgrpValori.Items.Clear;
  if PSelezione(Componenti.Items[index]).Esistente then
  begin
    chkgrpValori.Items.Assign(PSelezione(Componenti.Items[index]).TotValori);
    PutCheck(PSelezione(Componenti.Items[index]).SelValori);
  end;
  PSelezione(Componenti.Items[index]).EscludiValori:=False;
  if PSelezione(Componenti.Items[index]).SelValori.Count > 0 then
    PSelezione(Componenti.Items[index]).EscludiValori:=chkEscludiValori.Checked;

  if (OldValore <> PSelezione(Componenti.Items[index]).Valore) or
     (OldDa <> PSelezione(Componenti.Items[index]).DAValore ) or
     (OldA <> PSelezione(Componenti.Items[index]).AValore) or
     (OldIn <> PSelezione(Componenti.Items[index]).SelValori.Text) or
     (Old_CaseInsensitive <> PSelezione(Componenti.Items[index]).CaseInsensitive) or
     (Old_EscludiValori <> PSelezione(Componenti.Items[index]).EscludiValori)
  then
  begin
    SQLCreato.Clear;
    edtSelezione.Text:='';
    btnAggiungiOrdinamentoAsyncClick(nil,nil);
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.setDatiSelezionati(val: String);
begin
  FDatiSelezionati:=val;
  if FDatiSelezionati = '' then
    FDatiSelezionati:=C700CampiBase;

  FDatiSelezionati:=C700CompletaDatiSelezionati;
  PreparaListSQL;
end;

procedure TWC700FSelezioneAnagrafeFM.setDatiVisualizzati(val: String);
begin
  FDatiVisualizzati:=val;
  if FDatiVisualizzati = 'MATRICOLA,T430BADGE,COGNOME,NOME' then
    FDatiVisualizzati:=Parametri.DatiC700;
end;

procedure TWC700FSelezioneAnagrafeFM.setProgressivo(val: LongInt);
begin
  FProgressivo:=val;
  with WC700DM.selAnagrafe do
  begin
    CloseAll;
    SQL.Assign(ListSQL);
    SQLCreato.Clear;
    if C700Progressivo >= 0 then
    begin
      SQL.Add('AND T030.PROGRESSIVO = ' + IntToStr(FProgressivo));
      if FProgressivo >= 0 then
      begin
        if SQLCreato.Count > 0 then
          SQLCreato.Add('AND');
        SQLCreato.Add('T030.PROGRESSIVO = ' + IntToStr(FProgressivo));
      end;
      if C700Progressivo > 0 then
        PulisciVecchiaSelezione:=False;
      C700SelezionePeriodicaVal:=C700SelezionePeriodicaVal;
      (*
      if VariableIndex('C700DATADAL') >= 0 then
        DeleteVariable('C700DATADAL');
      *)
      if VariableIndex('C700FILTRO') >= 0 then
        DeleteVariable('C700FILTRO');
      if VariableIndex('DATALAVORO') < 0 then
        DeclareVariable('DATALAVORO',otDate);

      SetVariable('DATALAVORO',FDataLavoro);
      Open;
    end;
  end;
end;

function TWC700FSelezioneAnagrafeFM.LeggiSQL: string;
begin
  result:='';
  with WC700DM.selT003 do
  begin
    Close;
    SetVariable('Nome',edtSelezione.Text);
    Open;
    if RecordCount = 0 then exit;
    while not Eof do
    begin
      result:=result + IfThen(result <> '', ' ') + FieldByName('Riga').AsString;
      Next;
    end;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.LoadDaSelezione(index: Integer);
begin
  chkCaseInsensitive.Checked:=False;
  chkEscludiValori.Checked:=False;

  if index < 0 then
  begin
    RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.LoadDaSelezione - index = ' + index.ToString);
    exit;
  end;

  edtUguale.Text:=PSelezione(Componenti.Items[index]).Valore;
  edtDa.Text:=PSelezione(Componenti.Items[index]).DaValore;
  edtA.Text:=PSelezione(Componenti.Items[index]).AValore;
  chkgrpValori.Items.Clear;
  if PSelezione(Componenti.Items[index]).Esistente then
  begin
    chkgrpValori.Items.Assign(PSelezione(Componenti.Items[index]).TotValori);
    GetCheck(PSelezione(Componenti.Items[index]).SelValori);
  end;
  if (edtUguale.Text <> '') or (edtDa.Text <> '') or (edtA.Text <> '') then
    chkCaseInsensitive.Checked:=PSelezione(Componenti.Items[index]).CaseInsensitive;
  if PSelezione(Componenti.Items[index]).SelValori.Count > 0 then
    chkEscludiValori.Checked:=PSelezione(Componenti.Items[index]).EscludiValori;
  chkgrpValori.AsyncUpdate;
  SetElencoValoriDaA;
end;

procedure TWC700FSelezioneAnagrafeFM.lstAziendaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  //Salvo dati elemento selezionato precedentemente
  SalvaSuSelezione(itemAziendaSelected);

  //BugFix Chrome: Quando si seleziona il testo in una textbox tramite mouse e mantenendo premuto il tast sx
  //ci si sposta sopra la listbox, si perde l'elemento selezionato (solo su chrome)
  if (lstAzienda.ItemIndex = -1) and (itemAziendaSelected >= 0) then
    lstAzienda.ItemIndex:=itemAziendaSelected;

  //carico dati elemento selezionato attualmente
  itemAziendaSelected:=lstAzienda.itemIndex;
  LoadDaSelezione(itemAziendaSelected);
end;

procedure TWC700FSelezioneAnagrafeFM.lstAziendaAsyncDoubleClick(Sender: TObject;
  EventParams: TStringList);
var s: String;
begin
  inherited;
  if lstAzienda.ItemIndex = -1 then
    exit;
  //salva dati in caso di cambiamento elemento selezionato
  if (itemAziendaSelected <> lstAzienda.ItemIndex) then
    lstAziendaAsyncChange(nil,nil);

  if itemAziendaSelected < 0 then
  begin
    RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.lstAziendaAsyncDoubleClick - itemAziendaSelected: ' + itemAziendaSelected.ToString);
  end
  else if not PSelezione(Componenti.Items[itemAziendaSelected]).Esistente then
  begin
    //Costruisco la query per estrarre la colonna richiesta
    with WC700DM.selDistinct do
    begin
      Close;
      QueryDinamica(0);
      try
        Open;
      except
        GenerazioneSelezione;
        QueryDinamica(0);
        Open;
      end;
      //Riempo la lista con i dati della tabella
      PSelezione(Componenti.Items[itemAziendaSelected]).TotValori.Clear;
      PSelezione(Componenti.Items[itemAziendaSelected]).TotValori.BeginUpdate;
      while not Eof do
      begin
        //BUG TMS in async errore con ""
        //workaround - ini
        s:=StringReplace(Fields[0].AsString, '"', '&quot;', [rfReplaceAll]);
        //workaround - fine
        PSelezione(Componenti.Items[itemAziendaSelected]).TotValori.Add(s);
        Next;
      end;
    end;

    PSelezione(Componenti.Items[itemAziendaSelected]).TotValori.EndUpdate;
    chkgrpValori.Items.Assign(PSelezione(Componenti.Items[itemAziendaSelected]).TotValori);
    PSelezione(Componenti.Items[itemAziendaSelected]).Esistente:=True;
    GetCheck(PSelezione(Componenti.Items[itemAziendaSelected]).SelValori);
  end;
  SetElencoValoriDaA;

  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA('ShowBusy(false);');
end;

procedure TWC700FSelezioneAnagrafeFM.SetElencoValoriDaA;
var Elementi: String;
    i:Integer;
begin
  Elementi:='';
  jqAutoCompleteDaA.OnReady.Clear;
  with chkgrpValori do
    for i:=0 to Items.Count - 1 do
      if Trim(Items[i]) <> '' then
        Elementi:=Elementi + '"' + C190EscapeJs(Items[i]) + '",';
  jqAutoCompleteDaA.OnReady.Text:=
    'var ListValori = [' + Copy(Elementi,1,Length(Elementi) - 1) + '];' + CRLF +
    '$("#' + edtUguale.HTMLName + '").autocomplete({' + CRLF +
    //source ridefinito come function per consentire ricerca su inizio elemento, e non sul contenuto
    //source ridefinito.inizio
    '  source: function(req, response) {' + CRLF +
    '    var re = $.ui.autocomplete.escapeRegex(req.term);' + CRLF +
    '    var matcher = new RegExp( "^" + re, "i" );' + CRLF +
    '    response($.grep(ListValori, function(item){return matcher.test(item);}));' + CRLF +
    '  },' + CRLF +
    //source ridefinito.fine
    '  delay: 0,' + CRLF +
    '  minLength: 0' + CRLF +
    '}).focus(function(){ ' + CRLF +
    '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
    '}); ' + CRLF +
    '$("#' + edtDa.HTMLName + '").autocomplete({' + CRLF +
    //source ridefinito.inizio
    '  source: function(req, response) {' + CRLF +
    '    var re = $.ui.autocomplete.escapeRegex(req.term);' + CRLF +
    '    var matcher = new RegExp( "^" + re, "i" );' + CRLF +
    '    response($.grep(ListValori, function(item){return matcher.test(item);}));' + CRLF +
    '  },' + CRLF +
    //source ridefinito.fine
    '  delay: 0,' + CRLF +
    '  minLength: 0' + CRLF +
    '}).focus(function(){ ' + CRLF +
    '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
    '}); ' + CRLF +
    '$("#' + edtA.HTMLName + '").autocomplete({' + CRLF +
    //source ridefinito.inizio
    '  source: function(req, response) {' + CRLF +
    '    var re = $.ui.autocomplete.escapeRegex(req.term);' + CRLF +
    '    var matcher = new RegExp( "^" + re, "i" );' + CRLF +
    '    response($.grep(ListValori, function(item){return matcher.test(item);}));' + CRLF +
    '  },' + CRLF +
    //source ridefinito.fine
    '  delay: 0,' + CRLF +
    '  minLength: 0' + CRLF +
    '}).focus(function(){ ' + CRLF +
    '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
    '}); ';

  //serve per eseguire il javascript in async
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(jqAutoCompleteDaA.OnReady.Text);
end;

procedure TWC700FSelezioneAnagrafeFM.lstAziendaAsyncKeyUp(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if EventParams.Values['which'] = '113' then
  begin
    edtUguale.SetFocus;
    exit;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.lstOrdinamentoAsyncDoubleClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if lstOrdinamento.Items.Count > 0 then
    lstOrdinamento.Items.Delete(lstOrdinamento.ItemIndex);
  SQLCreato.Clear;
  edtSelezione.Text:='';
end;

procedure TWC700FSelezioneAnagrafeFM.edtRicercaTestoAsyncKeyUp(Sender: TObject; EventParams: TStringList);
var i:Integer;
begin
  inherited;
  //Invio: si posiziona su lstAzienda
  if EventParams.Values['which'] = '13' then
  begin
    lstAzienda.SetFocus;
    exit;
  end;
  //Freccia su: ricerca precedente
  if EventParams.Values['which'] = '38' then
  begin
    btnSuAsyncClick(btnSu,EventParams);
    exit;
  end;
  //Freccia giù: ricerca successivo
  if EventParams.Values['which'] = '40' then
  begin
    btnGiuAsyncClick(btnGiu,EventParams);
    exit;
  end;
  //F2: focus su input Uguale
  if (EventParams.Values['which'] = '113') and (lstAzienda.ItemIndex >= 0) then
  begin
    edtUguale.SetFocus;
    exit;
  end;
  for i:=0 to lstAzienda.Items.Count - 1 do
  begin
    if Pos(LowerCase(edtRicercaTesto.Text),LowerCase(lstAzienda.Items[i])) > 0 then
    begin
      lstAzienda.ItemIndex:=i;
      lstAziendaAsyncChange(lstAzienda,EventParams);
      Break;
    end;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.edtUgualeAsyncChange(Sender: TObject; EventParams: TStringList);
var S:String;
begin
  S:=Trim(edtUguale.Text);
  if S <> '' then
  begin
    SvuotaSelezione(actAnnullaSelezione);
    edtUguale.Text:=S;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.edtUgualeAsyncKeyUp(Sender: TObject; EventParams: TStringList);
  function Action2ToolBarCtrl(Action:TAction):TControl;
  //Ricerca controllo sulla toolbar associato all'action
  var i,j:Integer;
  begin
    Result:=nil;
    for i:=0 to ActionList.ActionCount - 1 do
      if (ActionList.Actions[i] = Action) then
      begin
        for j:=0 to grdToolBar.ColumnCount - 1 do
          if (grdToolBar.Cell[0,j].Control <> nil) and (grdToolBar.Cell[0,j].Control.Tag = i) then
          begin
            Result:=grdToolBar.Cell[0,j].Control;
            Break;
          end;
        Break;
      end;
  end;
begin
  inherited;
  if EventParams.Values['which'] = '13' then
  begin
    edtUgualeAsyncChange(Sender,EventParams);
    if EventParams.Values['modifiers'] = 'CTRL_MASK,' then
      //CTRL+INVIO: actConferma
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[(Action2ToolBarCtrl(actConferma) as TmeIWImageFile).HTMLName]))
    else
      //INVIO: actEseguiSelezione
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[(Action2ToolBarCtrl(actEseguiSelezione) as TmeIWImageFile).HTMLName]))
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.btnGiuAsyncClick(Sender: TObject; EventParams: TStringList);
var i:Integer;
begin
  inherited;
  for i:=lstAzienda.ItemIndex + 1 to lstAzienda.Items.Count - 1 do
  begin
    if Pos(LowerCase(edtRicercaTesto.Text),LowerCase(lstAzienda.Items[i])) > 0 then
    begin
      lstAzienda.ItemIndex:=i;
      lstAziendaAsyncChange(lstAzienda,EventParams);
      Break;
    end;
  end;
  edtRicercaTesto.SetFocus;
end;

procedure TWC700FSelezioneAnagrafeFM.btnSuAsyncClick(Sender: TObject; EventParams: TStringList);
var i:Integer;
begin
  inherited;
  for i:=lstAzienda.ItemIndex - 1 downto 0 do
  begin
    if Pos(LowerCase(edtRicercaTesto.Text),LowerCase(lstAzienda.Items[i])) > 0 then
    begin
      lstAzienda.ItemIndex:=i;
      lstAziendaAsyncChange(lstAzienda,EventParams);
      Break;
    end;
  end;
  edtRicercaTesto.SetFocus;
end;

procedure TWC700FSelezioneAnagrafeFM.mnuDeselezionaTuttoClick(Sender: TObject);
var i: Integer;
begin
  for i:=0 to chkgrpValori.Items.Count - 1 do
     chkgrpValori.Selected[i]:=False;
end;

procedure TWC700FSelezioneAnagrafeFM.mnuInvertiSelezioneClick(Sender: TObject);
var i: Integer;
begin
  for i:=0 to chkgrpValori.Items.Count - 1 do
     chkgrpValori.Selected[i]:=not chkgrpValori.Selected[i];
end;

procedure TWC700FSelezioneAnagrafeFM.mnuRicercaCompletaClick(Sender: TObject);
var
  i,j: Integer;
  SelectedItem: String;
  ItemFound: Boolean;

begin
  //salvo selezione corrente e campo corrente
  SalvaSuSelezione(itemAziendaSelected);
  if itemAziendaSelected < 0 then
  begin
    SelectedItem:='';
    RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.mnuRicercaCompletaClick - itemAziendaSelected = ' + itemAziendaSelected.ToString);
  end
  else
    SelectedItem:=lstAzienda.Items[itemAziendaSelected];
  ItemFound:=False;

  //Salvo le precedenti selezioni <> da null in una lista temporanea
  for i:=0 to lstAzienda.Items.Count - 1 do
  begin
    j:=0;
    while (j <= High(SelezioneFull) - 1) and (SelezioneFull[j].NomeLogico <> lstAzienda.Items[i]) do
      inc(j);
    if (SelezioneFull[j].NomeLogico <> lstAzienda.Items[i]) then
      j:= -1;

    if j >= 0 then
    begin
      SelezioneFull[j].Selezione.DaValore:=PSelezione(Componenti.Items[i]).DaValore;
      SelezioneFull[j].Selezione.AValore:=PSelezione(Componenti.Items[i]).AValore;
      SelezioneFull[j].Selezione.Valore:=PSelezione(Componenti.Items[i]).Valore;
      SelezioneFull[j].Selezione.TotValori.Assign(PSelezione(Componenti.Items[i]).TotValori);
      SelezioneFull[j].Selezione.SelValori.Assign(PSelezione(Componenti.Items[i]).SelValori);
      SelezioneFull[j].Selezione.Esistente:=PSelezione(Componenti.Items[i]).Esistente;
      SelezioneFull[j].Selezione.EscludiValori:=PSelezione(Componenti.Items[i]).EscludiValori;
      SelezioneFull[j].Selezione.CaseInsensitive:=PSelezione(Componenti.Items[i]).CaseInsensitive;
    end;
  end;
  //================================================================

  mnuRicercaCompleta.Checked:=not mnuRicercaCompleta.Checked;
  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    if mnuRicercaCompleta.Checked then
      mnuRicercaCompleta.Caption:='Ricerca completa'//'Ricerca semplice'
    else
      mnuRicercaCompleta.Caption:='Ricerca completa';
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteasCData('$("#' + pmnRicerca.Name + ' a[href=#' + mnuRicercaCompleta.Name + ']").html("' + mnuRicercaCompleta.Caption + '")');
  end;

  CaricaLstAzienda(mnuRicercaCompleta.Checked);

  //Riassegnazione valori precedentemente impostati
  lstAzienda.OnAsyncChange:=nil;
  for i:=0 to lstAzienda.Items.Count - 1 do
  begin
    j:=0;
    while (j <= High(SelezioneFull) - 1) and (SelezioneFull[j].NomeLogico <> lstAzienda.Items[i]) do
      inc(j);
    if (SelezioneFull[j].NomeLogico <> lstAzienda.Items[i]) then
      j:= -1;

    if j >= 0 then
    begin
      PSelezione(Componenti.Items[i]).Valore:=SelezioneFull[j].Selezione.Valore;
      PSelezione(Componenti.Items[i]).DaValore:=SelezioneFull[j].Selezione.DaValore;
      PSelezione(Componenti.Items[i]).AValore:=SelezioneFull[j].Selezione.AValore;
      PSelezione(Componenti.Items[i]).TotValori.Assign(SelezioneFull[j].Selezione.TotValori);
      PSelezione(Componenti.Items[i]).SelValori.Assign(SelezioneFull[j].Selezione.SelValori);
      PSelezione(Componenti.Items[i]).Esistente:=SelezioneFull[j].Selezione.Esistente;
      PSelezione(Componenti.Items[i]).CaseInsensitive:=SelezioneFull[j].Selezione.CaseInsensitive;
      PSelezione(Componenti.Items[i]).EscludiValori:=SelezioneFull[j].Selezione.EscludiValori;
    end;

    if lstAzienda.Items[i] = SelectedItem then
    begin
      lstAzienda.ItemIndex:=i;
      itemAziendaSelected:=i;
      ItemFound:=True; //da completa a normale l'item selezionato potrebbe non più esistere
    end;
  end;
  if not ItemFound then
  begin
    lstAzienda.ItemIndex:=0;
    itemAziendaSelected:=0;
  end;

  lstAzienda.OnAsyncChange:=lstAziendaAsyncChange;
end;

procedure TWC700FSelezioneAnagrafeFM.mnuSelezionaTuttoClick(Sender: TObject);
var i: Integer;
begin
  for i:=0 to chkgrpValori.Items.Count - 1 do
     chkgrpValori.Selected[i]:=True;
end;

procedure TWC700FSelezioneAnagrafeFM.ModificaSelezioneManuale(val: boolean);
begin
  memModificaSelezione.Visible:=val;
  actConfermaSelezioneManuale.Enabled:=val;
  actAnnullaSelezioneManuale.Enabled:=val;
  actConferma.Enabled:=not val;
  actAnnulla.Enabled:=not val;
  actcmbSelezione.Enabled:=not val;
  actSalvaSelezione.Enabled:=not val;
  actApriSelezione.Enabled:=not val;
  actEliminaSelezione.Enabled:=not val;
  actEseguiSelezione.Enabled:=not val;
  actAnnullaSelezione.Enabled:=not val;
  actModificaSelezione.Enabled:=not val;

  if val then
    memModificaSelezione.SetFocus;

  (WC700NavigatorBar as TmedpIWC700NavigatorBar).AggiornaToolBar(grdToolBar, ActionList);

  lstAzienda.enabled:=not val;

  if val then
  begin
    rdgPeriodoConsiderato.Enabled:=False;
    chkDipendentiCessati.Enabled:=False;
    chkPersonaleEsterno.Enabled:=False;
  end
  else
  begin
    //non posso settare enabled a true, ma devo verificare se consentiti da property
    rdgPeriodoConsiderato.Enabled:=FSelezionePeriodica;
    chkDipendentiCessati.Enabled:=FDipendentiCessati;
    chkPersonaleEsterno.Enabled:=not FPersonaleInterno;
  end;

  btnAggiungiOrdinamento.Enabled:=not val;
  edtUguale.Enabled:=not val;
  edtDa.Enabled:=not val;
  edtA.Enabled:=not val;
  chkgrpValori.Enabled:=not val;
  mnuSelezionaTutto.Enabled:=not val;
  mnuDeselezionaTutto.Enabled:=not val;
  mnuInvertiSelezione.Enabled:=not val;
  lstOrdinamento.Enabled:=not val;
  grdAnteprima.Visible:=not val;
end;

function TWC700FSelezioneAnagrafeFM.PrefissoTabella(Campo: String): String;
{Cerca la tabella di cui fa parte Campo tra T030,T480,V430}
begin
  Result:=AliasTabella(Campo) + '.' + Campo;
end;

procedure TWC700FSelezioneAnagrafeFM.PulisciListaComponenti(var List: Tlist);
var i:Integer;
begin
  for i:=List.Count - 1 downto 0 do
  try
    FreeAndNil(PSelezione(List.Items[i]).TotValori);//.Free;
    FreeAndNil(PSelezione(List.Items[i]).SelValori);//.Free;
    Dispose(PSelezione(List.Items[i]));
    List.Delete(i);
  except
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.PutCheck(Dest: TStringList);
{Salvo gli Items Checkati in SelValori}
var i:Integer;
begin
  Dest.Clear;
  for i:=0 to chkgrpValori.Items.Count - 1 do
    if chkgrpValori.Selected[i] then
      Dest.Add(chkgrpValori.Items[i]);
end;

function TWC700FSelezioneAnagrafeFM.GetCampiSelezionatiQueryDinamica(pModo: byte): string;
begin
  case pModo of
    0:begin
        if itemAziendaSelected < 0 then
        begin
          Result:='DISTINCT NULL';
          RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.QueryDinamica - itemAziendaSelected = ' + itemAziendaSelected.ToString);
        end
        else
          Result:='DISTINCT ' + Parametri.ColonneStruttura.Values[lstAzienda.Items[itemAziendaSelected]];  //Selezione di una colonna specifica
      end;
    1: Result:=FDatiSelezionati;//C700CampiBase;//Dati anagrafici di base
    2: Result:=C700DatiSelezionati;    //Dati anagrafici richiesti
  end;
end;

function TWC700FSelezioneAnagrafeFM.GetHintT030V430(pCessati: Boolean):String;
begin
  Result:=IfThen(pCessati,Parametri.CampiRiferimento.C26_HintT030V430,Parametri.CampiRiferimento.C26_HintT030V430_NC);
end;

procedure TWC700FSelezioneAnagrafeFM.SelezionePeriodicaDalAl(pSel: TOracleDataSet; pDal, pAl: TDateTime; pCorpoSQL:TStringList; pModo:byte; pCessati, pSoloInterni, pSingoloDipendente : Boolean);
var
  Filtro, S, OrderBy: string;
  i: Integer;
  function GetHintT030V430NoTag:String;
  begin
    Result:=StringReplace(StringReplace(GetHintT030V430(pCessati),'/*+','',[]),'*/','',[]);
  end;
begin
  S:=GetCampiSelezionatiQueryDinamica(pModo);
  with pSel do
  begin
    SQL.Assign(ListSQLPeriodico);
    SQL.Delete(0);
    SQL.Insert(0,Format('SELECT %s %s FROM',[GetHintT030V430(pCessati),S]));
    SQL.Text:=StringReplace(SQL.Text,'HintT030V430',GetHintT030V430NoTag,[rfIgnoreCase,rfReplaceAll]);
    if Assigned(pCorpoSQL) then
    begin
      pCorpoSQL.Assign(ListSQLPeriodico);
      pCorpoSQL.Delete(0);
      pCorpoSQL.Text:=StringReplace(CorpoSQL.Text,'HintT030V430',GetHintT030V430NoTag,[rfIgnoreCase,rfReplaceAll]);
    end;
    Filtro:='';
    OrderBy:='';
    //Filtro sui soli dipendenti in servizio
    if not pCessati then
      Filtro:=Filtro + 'AND :DATALAVORO >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DATALAVORO)' + #13#10;
    //Gestione del filtro sui soli dipendenti in servizio ereditato dalla selezione principale
    //commutazione dalla gestione non periodica a quella periodica
    S:=Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]);
    if Pos(S,CorpoSQL.Text) > 0 then
    begin
      SQL.Text:=SQL.Text.Replace(S,Format(QDipInServizioPeriodica,[IntToStr(Parametri.ValiditaCessati)]));
      if Assigned(pCorpoSQL) then
        pCorpoSQL.Text:=CorpoSQL.Text.Replace(S,Format(QDipInServizioPeriodica,[IntToStr(Parametri.ValiditaCessati)]));
    end;
    //Alberto: solo personale interno
    if pSoloInterni then
      Filtro:=Filtro + 'AND T030.TIPO_PERSONALE = ''I''' + #13#10;

    if pSingolodipendente then
      Filtro:=Filtro + 'AND T030.PROGRESSIVO = ' + IntToStr(C700Progressivo) + #13#10;

    with SQLCreato do
      for i:=0 to Count - 1 do
        if Pos('ORDER BY',Strings[i]) = 0 then
        begin
          if i = 0 then
            Filtro:=Filtro + 'AND' + #13#10;
          Filtro:=Filtro + Strings[i] + #13#10;
        end
        else if pModo > 0 then
          OrderBy:=OrderBy + Strings[i] + #13#10
        else Break;
    if pModo = 0 then
      OrderBy:='ORDER BY ' + Parametri.ColonneStruttura.Values[lstAzienda.Items[lstAzienda.ItemIndex]];
    if OrderBy <> '' then
      SQL.Add(OrderBy);
    DeleteVariables;
    DeclareVariable('DATALAVORO',otDate);
    DeclareVariable('C700DATADAL',otDate);
    DeclareVariable('C700FILTRO',otSubst);
    SetVariable('DATALAVORO',FDataLavoro);
    SetVariable('C700DATADAL',FDataDal);
    SetVariable('C700FILTRO',Filtro);
  end;
end;


procedure TWC700FSelezioneAnagrafeFM.QueryDinamica(Modo: Integer);
var Q : TOracleDataSet;
    S : String;
    i : Integer;
    OrderBy:String;
  function GetHintT030V430NoTag:String;
  begin
    Result:=StringReplace(StringReplace(GetHintT030V430(chkDipendentiCessati.Checked),'/*+','',[]),'*/','',[]);
  end;

begin
  CorpoSQL.Clear;
  //Colonne restituite dalla select
  Q:=nil;
  case Modo of
    0:begin
        if itemAziendaSelected < 0 then
        begin
          S:='DISTINCT NULL';
          RegistraMsg.InserisciMessaggio('A','TWC700FSelezioneAnagrafeFM.QueryDinamica - itemAziendaSelected = ' + itemAziendaSelected.ToString);
        end
        else
          S:='DISTINCT ' + Parametri.ColonneStruttura.Values[lstAzienda.Items[itemAziendaSelected]];  //Selezione di una colonna specifica
        Q:=WC700DM.selDistinct;
      end;
    1:begin
        S:=FDatiSelezionati;//C700CampiBase;//Dati anagrafici di base
        Q:=WC700DM.selAnagrafe;
      end;
    2:begin
        S:=C700DatiSelezionati;    //Dati anagrafici richiesti
        Q:=WC700DM.selAnagrafe;
      end;
  end;
  if not Assigned(Q) then
    exit;
  S:=GetCampiSelezionatiQueryDinamica(Modo);
  with Q do
  begin
    CloseAll;
    //Gestione Query periodica
    if rdgPeriodoConsiderato.Enabled and (rdgPeriodoConsiderato.ItemIndex = 1) then
    begin
      SelezionePeriodicaDalAl(Q, FDataDal, FDataLavoro, CorpoSQL, Modo, chkDipendentiCessati.Checked, (not chkPersonaleEsterno.Visible) or (not chkPersonaleEsterno.Checked), Singolodipendente);
      exit;
    end;

    SQL.Assign(ListSQL);
    SQL.Delete(0);
    SQL.Insert(0,Format('SELECT %s %s FROM',[GetHintT030V430(chkDipendentiCessati.Checked),S]));
    CorpoSQL.Assign(ListSQL);
    CorpoSQL.Delete(0);

    //Filtro sui soli dipendenti in servizio
    if (not chkDipendentiCessati.Checked) then
    begin
      S:='AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)';
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    //Gestione del filtro sui soli dipendenti in servizio ereditato dalla selezione principale
    //commutazione dalla gestione non periodica a quella periodica
    S:=Format(QDipInServizioPeriodica,[IntToStr(Parametri.ValiditaCessati)]);
    if Pos(S,CorpoSQL.Text) > 0 then
    begin
      SQL.Text:=SQL.Text.Replace(S,Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]));
      CorpoSQL.Text:=CorpoSQL.Text.Replace(S,Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]));
    end;
    //Alberto: solo personale interno
    if (not chkPersonaleEsterno.Visible) or (not chkPersonaleEsterno.Checked) then
    begin
      S:='AND T030.TIPO_PERSONALE = ''I''';
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    if Singolodipendente then
    begin
      S:='AND T030.PROGRESSIVO = ' + IntToStr(C700Progressivo);
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    with SQLCreato do
      for i:=0 to Count - 1 do
        if Pos('ORDER BY',UpperCase(Trim(Strings[i]))) <> 1 then
        begin
          if i = 0 then
          begin
            SQL.Add('AND');
            CorpoSQL.Add('AND');
          end;
          SQL.Add(Strings[i]);
          CorpoSQL.Add(Strings[i]);
        end
        else if Modo > 0 then SQL.Add(Strings[i])
        else Break;
    if (Modo = 0) and (itemAziendaSelected >= 0) then
      SQL.Add('ORDER BY ' + Parametri.ColonneStruttura.Values[lstAzienda.items[itemAziendaSelected]]);
    DeleteVariables;
    DeclareVariable('DATALAVORO',otDate);
    SetVariable('DATALAVORO',FDataLavoro);
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.ReleaseOggetti;
var i: Integer;
begin
  PulisciListaComponenti(Componenti);
  PulisciListaComponenti(SaveComponenti);
  FreeAndNil(Componenti);//Componenti.Free;
  FreeAndNil(SaveComponenti);
  FreeAndNil(ListSQL);//.Free;
  FreeAndNil(SQLCreato);//.Free;
  FreeAndNil(CorpoSQL);//.Free;
  FreeAndNil(ListSQLPeriodico);//.Free;
  //Caratto 03/10/2014 gli oggetti per il salvataggio della selezione iniziale
  //vengono correttamente distrutti su conferma e annulla.
  //In caso il frame venga laciato aperto e chiuso il browser, devono essere distrutti anche qui
  if SaveSelAnagrafe <> nil then
    FreeAndNil(SaveSelAnagrafe);

  if SaveSQLCreato <> nil then
    FreeAndNil(SaveSQLCreato);

  if SaveSelAnagrafeODS <> nil then
  FreeAndNil(SaveSelAnagrafeODS);

  for i:=low(SelezioneFull) to High(SelezioneFull) do
  begin
    FreeAndNil(SelezioneFull[i].Selezione.TotValori);
    FreeAndNil(SelezioneFull[i].Selezione.SelValori);
  end;
  SetLength(SelezioneFull,0);
end;

procedure TWC700FSelezioneAnagrafeFM.ResultElimina(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
var
  LogValOld: string;
begin
  case Res of
    mrYes:
      begin
        LogValOld:=LeggiSQL;
        with WC700DM.delT003 do
        begin
          SetVariable('Nome',edtSelezione.Text);
          Execute;

          RegistraLog.SettaProprieta('C', 'T003_SELEZIONIANAGRAFE','WA002', nil, True);
          RegistraLog.InserisciDato('NOME', edtSelezione.Text, '');
          RegistraLog.InserisciDato('RIGA', LogValOld, '');
          RegistraLog.RegistraOperazione;

          Session.Commit;
        end;

        A000AggiornaFiltroDizionario('SELEZIONI ANAGRAFICHE',edtSelezione.Text,'');
        edtSelezione.Text:='';
        CaricaListSelezioni;
      end;
    mrNo:  exit;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.ResultSovrascrivi(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: SalvaSelezione;
    mrNo:  exit;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.EreditaSelezione(SelAnagrafeBridge: TC700SelAnagrafeBridge);
begin
  if SelAnagrafeBridge.SQLCreato = '' then
    exit;
  //C700SelezionePeriodica:=SelAnagrafeBridge.SelezionePeriodica;
  C700SelezionePeriodicaVal:=SelAnagrafeBridge.SelezionePeriodicaVal;
  //C700PersonaleInterno:=SelAnagrafeBridge.SoloPersonaleInterno;
  C700PersonaleInternoVal:=SelAnagrafeBridge.SoloPersonaleInternoVal;
  C700DipendentiCessati:=SelAnagrafeBridge.AncheDipendentiCessati;
  C700DipendentiCessatiVal:=SelAnagrafeBridge.AncheDipendentiCessatiVal;

  SQLCreato.Text:=SelAnagrafeBridge.SQLCreato;
  actConfermaExecute(actConferma);
end;

procedure TWC700FSelezioneAnagrafeFM.C700MergeSelAnagrafe(ODS:TComponent; RicreaVariabili:Boolean = False);
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
  if Trim(CorpoSQL.Text) = '' then
  begin
    //Prima volta che si richiama la procedura
    //C700FSelezioneAnagrafe.QueryDinamica(1);
    QueryDinamica(2);
    WC700DM.SelAnagrafe.Open;
  end;
  //Alberto 12/04/2007: gestisco a parte le variabili di tipo Substitution
  S:=CorpoSQL.Text;
  with WC700DM do
    for i:=0 to selAnagrafe.VariableCount - 1 do
      if selAnagrafe.VariableType(i) = otSubst then
        S:=StringReplace(S,selAnagrafe.VariableName(i),selAnagrafe.GetVariable(selAnagrafe.VariableName(i)),[rfIgnoreCase]);
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
    with WC700DM do
      for i:=0 to selAnagrafe.VariableCount - 1 do
      begin
        if (TOracleQuery(ODS).VariableIndex(selAnagrafe.VariableName(i)) = -1) and
           (selAnagrafe.VariableType(i) <> otSubst) then
        begin
          TOracleQuery(ODS).DeclareVariable(selAnagrafe.VariableName(i),selAnagrafe.VariableType(i));
          TOracleQuery(ODS).SetVariable(selAnagrafe.VariableName(i),selAnagrafe.GetVariable(i));
        end;
      end;
  end
  else if ODS is TOracleScript then
  begin
    //Se ODS è OracleScript....
    TOracleScript(ODS).SetVariable('C700SelAnagrafe',S);
  end
  else if ODS is TOracleDataSet then
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
    with WC700DM do
      //Si riportano tutte le variabili non subst di C700, settandone sempre i valori
      for i:=0 to selAnagrafe.VariableCount - 1 do
      begin
        if (SelAnagrafe.VariableType(i) <> otSubst) then
        begin
          if (TOracleDataSet(ODS).VariableIndex(selAnagrafe.VariableName(i)) = -1) then
            TOracleDataSet(ODS).DeclareVariable(selAnagrafe.VariableName(i),selAnagrafe.VariableType(i));
          TOracleDataSet(ODS).SetVariable(selAnagrafe.VariableName(i),selAnagrafe.GetVariable(i));
        end;
      end;
  end;
end;

function TWC700FSelezioneAnagrafeFM.C700MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
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

function TWC700FSelezioneAnagrafeFM.C700SettaPeriodoSelAnagrafe(DataDal,
  DataLavoro: TDateTime): Boolean;
begin
  with WC700DM do
  begin
    Result:=False;
    if SelAnagrafe.VariableIndex('DATALAVORO') >= 0 then
      if SelAnagrafe.GetVariable('DATALAVORO') <> DataLavoro then
      begin
        SelAnagrafe.SetVariable('DATALAVORO',DataLavoro);
        Result:=True;
      end;
    if SelAnagrafe.VariableIndex('C700DATADAL') >= 0 then
      if SelAnagrafe.GetVariable('C700DATADAL') <> DataDal then
      begin
        SelAnagrafe.SetVariable('C700DATADAL',DataDal);
        Result:=True;
      end;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.C700CopiaTagFiltroAnag(ODS:TComponent);
{Cerca nella variabile C700SelAnagrafe di ODS il testo contenuto tra i tag /*I072*/ e /*\I072*/, lo sostituisce con quello trovato in C700SelAnagrafe fra gli stessi tag}
var x:Integer;
    S:String;
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
  with TStringList.Create do
  try
    Text:=S;
    if (IndexOf(TAG_FILTRO_ANAG_INIZIO) > 0) and (IndexOf(TAG_FILTRO_ANAG_FINE) > 0) then
    begin
      for x:=IndexOf(TAG_FILTRO_ANAG_INIZIO) + 1 to IndexOf(TAG_FILTRO_ANAG_FINE) - 1 do
        Delete(IndexOf(TAG_FILTRO_ANAG_INIZIO) + 1);
      for x:=WC700DM.SelAnagrafe.SQL.IndexOf(TAG_FILTRO_ANAG_INIZIO) + 1 to WC700DM.SelAnagrafe.SQL.IndexOf(TAG_FILTRO_ANAG_FINE) - 1 do
        Insert(IndexOf(TAG_FILTRO_ANAG_FINE),WC700DM.SelAnagrafe.SQL[x]);
      S:=Text;
    end;
  finally
    Free;
  end;
  if ODS is TOracleQuery then
    TOracleQuery(ODS).SetVariable('C700SelAnagrafe',S)
  else
    TOracleDataSet(ODS).SetVariable('C700SelAnagrafe',S);
end;

function TWC700FSelezioneAnagrafeFM.C700ValueDatiVisualizzati(NomiCampi:Boolean = False): String;
var
  i:Integer;
  b:Boolean;
  function GetNomeLogico(NomeCampo:String):String;
  var i:Integer;
  begin
    Result:=NomeCampo;
    for i:=0 to Parametri.ColonneStruttura.Count - 1 do
    begin
      if Parametri.ColonneStruttura.ValueFromIndex[i].ToUpper = NomeCampo.ToUpper then
      begin
        Result:=Parametri.ColonneStruttura.Names[i];
        Break;
      end;
    end;
  end;
begin
  Result:='';
  with TStringList.Create do
  try
    CommaText:=C700DatiVisualizzati;
    b:=False;
    for i:=0 to Count - 1 do
    begin
      if WC700DM.selAnagrafe.FindField(Strings[i]) = nil then
        Continue;
      if Result <> '' then
        Result:=Result + ' ';
      if NomiCampi then
      begin
        Result:=Result + R180Capitalize(GetNomeLogico(WC700DM.selAnagrafe.FieldByName(Strings[i]).FieldName)) + ': '
      end;
      if ((Strings[i] = 'T430BADGE') or (Strings[i] = 'MATRICOLA')) and ((i = 0) or ((i = 1) and b)) then
      begin
        Result:=Result + Format('%-8s',[WC700DM.selAnagrafe.FieldByName(Strings[i]).AsString]);
        b:=True;
      end
      else
        Result:=Result + WC700DM.selAnagrafe.FieldByName(Strings[i]).AsString;
    end;
  finally
    Free;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.C700StructDatiVisualizzati(Struct: TList<TItemsValues>);
var i:Integer;
    Item:TItemsValues;
  function GetNomeLogico(NomeCampo:String):String;
  var i:Integer;
  begin
    Result:=NomeCampo;
    for i:=0 to Parametri.ColonneStruttura.Count - 1 do
    begin
      if Parametri.ColonneStruttura.ValueFromIndex[i].ToUpper = NomeCampo.ToUpper then
      begin
        Result:=Parametri.ColonneStruttura.Names[i];
        Break;
      end;
    end;
  end;
begin
  Struct.Clear;
  with TStringList.Create do
  try
    CommaText:=C700DatiVisualizzati;
    for i:=0 to Count - 1 do
    begin
      if WC700DM.selAnagrafe.FindField(Strings[i]) = nil then
        Continue;
      Item.Item:=Strings[i].ToUpper;
      Item.Value:=GetNomeLogico(WC700DM.selAnagrafe.FieldByName(Strings[i]).FieldName);
      Struct.Add(Item);
    end;
  finally
    Free;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.C700ValuesDatiVisualizzati(Dati: TList<TItemsValues>);
var i:Integer;
    Item:TItemsValues;
begin
  Dati.Clear;
  with TStringList.Create do
  try
    CommaText:=C700DatiVisualizzati;
    for i:=0 to Count - 1 do
    begin
      if WC700DM.selAnagrafe.FindField(Strings[i]) = nil then
        Continue;
      Item.Item:=Strings[i].ToUpper;
      Item.Value:=WC700DM.selAnagrafe.FieldByName(Strings[i]).AsString;
      Dati.Add(Item);
    end;
  finally
    Free;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.ApriSelezione(Selezione:String);
begin
  edtSelezione.Text:=Selezione;
  actApriSelezioneExecute(actApriSelezione);
end;

procedure TWC700FSelezioneAnagrafeFM.SetSelezionePeriodica(val: boolean);
begin
  FSelezionePeriodica:=val;
  rdgPeriodoConsiderato.Enabled:=FSelezionePeriodica;
  if (FSelezionePeriodica) then
    rdgPeriodoConsiderato.ItemIndex:=0;
end;

procedure TWC700FSelezioneAnagrafeFM.setSelezionePeriodicaVal(const Value: Integer);
var S,S1:String;
begin
  FSelezionePeriodicaVal:=Value;
  if (FSelezionePeriodica) then
  begin
    rdgPeriodoConsiderato.ItemIndex:=Value;
    //Gestione del filtro sui soli dipendenti in servizio ereditato dalla selezione principale:
    //commutazione dalla gestione periodica a quella non periodica o viceversa
    case FSelezionePeriodicaVal of
      0:begin
          S:=Format(QDipInServizioPeriodica,[IntToStr(Parametri.ValiditaCessati)]);
          S1:=Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]);
        end;
      1:begin
          S:=Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]);
          S1:=Format(QDipInServizioPeriodica,[IntToStr(Parametri.ValiditaCessati)]);
        end;
    end;
    if Pos(S,WC700DM.SelAnagrafe.SQL.Text) > 0 then
    begin
      WC700DM.SelAnagrafe.SQL.Text:=WC700DM.SelAnagrafe.SQL.Text.Replace(S,S1);
      CorpoSQL.Text:=CorpoSQL.Text.Replace(S,S1);
    end;
  end;
  if (Pos(':C700DATADAL',WC700DM.SelAnagrafe.SQL.Text.ToUpper) > 0) and (WC700DM.SelAnagrafe.VariableIndex('C700DATADAL') < 0) then
  begin
    WC700DM.SelAnagrafe.DeclareVariable('C700DATADAL',otDate);
    WC700DM.SelAnagrafe.SetVariable('C700DATADAL',Parametri.DataLavoro);
  end;
  if (Pos(':C700DATADAL',WC700DM.SelAnagrafe.SQL.Text.ToUpper) <= 0) and (WC700DM.SelAnagrafe.VariableIndex('C700DATADAL') >= 0) then
  begin
    WC700DM.SelAnagrafe.DeleteVariable('C700DATADAL');
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.setPersonaleInterno(const Value: Boolean);
begin
  FPersonaleInterno:=Value;
  chkPersonaleEsterno.Enabled:=not FPersonaleInterno;
end;

procedure TWC700FSelezioneAnagrafeFM.setPersonaleInternoVal(  const Value: Boolean);
begin
  FPersonaleInternoVal:=Value;
  chkPersonaleEsterno.Checked:=Value;
end;

procedure TWC700FSelezioneAnagrafeFM.setDipendiCessati(const Value: Boolean);
begin
  FDipendentiCessati:=Value;
  chkDipendentiCessati.Enabled:=Value;
end;

procedure TWC700FSelezioneAnagrafeFM.setDipendiCessatiVal(const Value: Boolean);
begin
  FDipendentiCessatiVal:=Value;
  chkDipendentiCessati.Checked:=Value;
end;

procedure TWC700FSelezioneAnagrafeFM.CreaSelezioneTotale;
begin
  CreaSave;
  CopiaListaComp(Componenti,SaveComponenti);
  SvuotaSelezione(actAnnullaSelezione);
  actEseguiSelezioneExecute(nil);
end;

procedure TWC700FSelezioneAnagrafeFM.RipristinaSelezione;
begin
  actAnnullaExecute(nil);
end;

end.
