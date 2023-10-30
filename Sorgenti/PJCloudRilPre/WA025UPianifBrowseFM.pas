unit WA025UPianifBrowseFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, OracleData,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, DB, Math,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, ActnList, meIWImageFile, meIWGrid, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompCheckbox, meIWCheckBox, IWCompListbox, meIWComboBox,
  medpIWMultiColumnComboBox, A000UInterfaccia, C180FunzioniGenerali, A000UMessaggi,medpIWMessageDlg,
  C190FunzioniGeneraliWeb, Menus, WC003URicercaDatiFM, IWApplication,
  System.Actions, WA025UEditNoteFM;

type
  TImgRow = class
    NumRow:integer;
  end;

  TWA025FPianifBrowseFM = class(TWR204FBrowseTabellaFM)
    grdCalendarioNavBar: TmeIWGrid;
    grdCalendario: TmedpIWDBGrid;
    actlstCalendarioNavBar: TActionList;
    actCalAggiorna: TAction;
    actCalRicerca: TAction;
    actCalPrimo: TAction;
    actCalPrecedente: TAction;
    actCalSuccessivo: TAction;
    actCalUltimo: TAction;
    actCalModifica: TAction;
    edtDataDa: TmeIWEdit;
    edtDataA: TmeIWEdit;
    lblDataDa: TmeIWLabel;
    lblDataA: TmeIWLabel;
    btnVisualizza: TmeIWButton;
    lblDescIndennita: TmeIWLabel;
    lblDescDatoLibero: TmeIWLabel;
    lblDescOrario: TmeIWLabel;
    actCalReset: TAction;
    chkInsPeriodo: TmeIWCheckBox;
    lbl2Turno: TmeIWLabel;
    lbl1Turno: TmeIWLabel;
    lblDatoLibero: TmeIWLabel;
    lblIndPresenza: TmeIWLabel;
    lblOrario: TmeIWLabel;
    cmbTurno2EU: TmeIWComboBox;
    cmbTurno1EU: TmeIWComboBox;
    cmbTurno2: TmeIWComboBox;
    cmbTurno1: TmeIWComboBox;
    cmbDatoLibero: TMedpIWMultiColumnComboBox;
    cmbIndennita: TMedpIWMultiColumnComboBox;
    cmbOrario: TMedpIWMultiColumnComboBox;
    chkPulDato: TmeIWCheckBox;
    chkPulIndennita: TmeIWCheckBox;
    chkPulOrario: TmeIWCheckBox;
    actCalConferma: TAction;
    actCalAnnulla: TAction;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actCalAggiornaExecute(Sender: TObject);
    procedure btnVisualizzaClick(Sender: TObject);
    procedure cmbIndennitaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbDatoLiberoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbOrarioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure chkPulOrarioAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkPulDatoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnInserisciClick(Sender: TObject);
    procedure btnCancCalClick(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdCalendarioRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdCalendarioComponenti2DataSet(Row: Integer);
    procedure grdCalendarioDataSet2Componenti(Row: Integer);
    procedure actCalModificaExecute(Sender: TObject);
    procedure actCalAnnullaExecute(Sender: TObject);
    procedure actCalConfermaExecute(Sender: TObject);
    procedure chkPulIndennitaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure actCalRicercaExecute(Sender: TObject);
    procedure actCalPrimoExecute(Sender: TObject);
    procedure actCalPrecedenteExecute(Sender: TObject);
    procedure actCalSuccessivoExecute(Sender: TObject);
    procedure actCalUltimoExecute(Sender: TObject);
    procedure chkInsPeriodoClick(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    DataDa,DataA:TDateTime;
    WA025EditNoteFM:TWA025FEditNoteFM;
    procedure AbilitaComponenti;
    procedure CaricaComboBoxAzioniMassive;
    procedure ImgCalendarioNavBarClick(Sender: TObject);
    procedure CancPianif(DataDa, DataA: TDateTime);
    procedure ResultCancella(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure cmbOrarioGrdAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbTipoGrdAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure AbilitazioneActCalConferma(Abilitazione: boolean);
    function grdCalendarioAssignCssCell: String;
    procedure VisualizzaGrpInsPeriodo;
    procedure cmbDatoLiberoGrdAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure SetItemIndexTurni(Row:Integer; field :String);
    procedure CaricaPickListTurni(Row: Integer);
    procedure imgCausaliClick(Sender: TObject);
   public
     DaCartellino: Boolean;
     procedure ControllaCheckInsPeriodo;
  end;

implementation

uses WA025UPianif, WA025UPianifDM;

{$R *.dfm}

procedure TWA025FPianifBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  DaCartellino:=False;
  grdTabella.medpPaginazione:=True;
  grdTabella.medpRighePagina:=5;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORARIO'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('INDPRESENZA'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_ORARIO'),0,DBG_LBL,'40','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_INDENNITA'),0,DBG_LBL,'30','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO1'),0,DBG_CMB,'5','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO1EU'),0,DBG_CMB,'5','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO2'),0,DBG_CMB,'5','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO2EU'),0,DBG_CMB,'5','','','','S');
  if (WR302DM as TWA025FPianifDM).SelTabella.FieldByName('DATOLIBERO').Visible then
  begin
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATOLIBERO'),0,DBG_MECMB,'10','2','null','','S');
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_DATOLIBERO'),0,DBG_LBL,'30','','null','','S');
  end;
  grdTabella.medpPreparaComponenteGenerico('WR102','NOTE',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','NOTE',1,DBG_IMG,'','PUNTINI','','','');

  grdCalendario.medpPaginazione:=True;
  grdCalendario.medpRighePagina:=5;
  grdCalendario.medpAttivaGrid(((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.selV010, False,False);
  grdCalendario.medpPreparaComponentiDefault;
  grdCalendario.medpPreparaComponenteGenerico('WR102',grdCalendario.medpIndexColonna('FESTIVO'),0,DBG_CMB,'5','','','','S');
  grdCalendario.medpPreparaComponenteGenerico('WR102',grdCalendario.medpIndexColonna('LAVORATIVO'),0,DBG_CMB,'5','','','','S');
  grdCalendario.medpPreparaComponenteGenerico('WR102',grdCalendario.medpIndexColonna('CALCCALEND_INDIVID'),0,DBG_LBL,'20','','null','','S');

  edtDataDa.Text:=DateToStr(Date);
  edtDataA.Text:=DateToStr(Date);
  (Self.Owner as TWA025FPianif).CreaNavigatorBar(actlstCalendarioNavBar,grdCalendarioNavBar,imgCalendarioNavBarClick);
  abilitaComponenti;
  CaricaComboBoxAzioniMassive;
  //Utente: AOSTA_REGIONE Chiamata: 90377 caricare turni in base all'orario
  cmbTurno1.Items.Clear;
  cmbTurno2.Items.Clear;
//  R180SetComboItemsValues(cmbTurno1.Items,((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.D_Turno,'V');
  R180SetComboItemsValues(cmbTurno1EU.Items,((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.D_TurnoEU,'V');
//  R180SetComboItemsValues(cmbTurno2.Items,((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.D_Turno,'V');

  R180SetComboItemsValues(cmbTurno2EU.Items,((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.D_TurnoEU,'V');
  ControllaCheckInsPeriodo;
  VisualizzaGrpInsPeriodo;
end;

procedure TWA025FPianifBrowseFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWA025FPianif).AddToInitProc('$(''#fsInsPer'').height("' + IfThen(chkInsPeriodo.Checked, '14','1') + 'em");')
end;

procedure TWA025FPianifBrowseFM.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  if PopupMenu1.PopupComponent = cmbOrario then
  begin
    //OpenA006ModelliOrario(CmbOrario.Text);
    ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.Q020.DisableControls;
    ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.Q020.Refresh;
    ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.Q020.EnableControls;
  end
  else
  begin
    (Self.Owner as TWA025FPianif).AccediForm(112,'CODICE='+CmbIndennita.Text); //OpenA024IndPresenza(CmbIndennita.Text); tag 112 WA024
    ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.Q163.DisableControls;
    ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.Q163.Refresh;
    ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.Q163.EnableControls
  end;
end;

procedure TWA025FPianifBrowseFM.AbilitaComponenti;
begin
  with (WR302DM as TWA025FPianifDM) do
  begin
    SelTabella.FieldByName('D_DATOLIBERO').Visible:=SelTabella.FieldByName('DATOLIBERO').Visible;  //dGrdPianif.Columns[11].Visible:=dGrdPianif.Columns[10].Visible;
    lblDatoLibero.Visible:=SelTabella.FieldByName('DATOLIBERO').Visible;
    cmbDatoLibero.Enabled:=SelTabella.FieldByName('DATOLIBERO').Visible;
    chkPulDato.Enabled:=SelTabella.FieldByName('DATOLIBERO').Visible;
    if SelTabella.FieldByName('DATOLIBERO').Visible then
    begin
      SelTabella.FieldByName('DATOLIBERO').DisplayLabel:=Copy(Parametri.CampiRiferimento.C3_DatoPianificabile,1,1) +
        LowerCase(Copy(Parametri.CampiRiferimento.C3_DatoPianificabile,2,Length(Parametri.CampiRiferimento.C3_DatoPianificabile) - 1));
      lblDatoLibero.Caption:=SelTabella.FieldByName('DATOLIBERO').DisplayLabel;
      grdTabella.medpCreaColonne;
    end;
  end;
end;

procedure TWA025FPianifBrowseFM.actCalAggiornaExecute(Sender: TObject);
begin
  grdCalendario.medpDataSet.Refresh;
  grdCalendario.medpAggiornaCDS(True);
end;

procedure TWA025FPianifBrowseFM.actCalAnnullaExecute(Sender: TObject);
begin
  grdCalendario.medpStato:=msBrowse;
  grdCalendario.medpDataSet.Cancel;
  grdCalendario.medpBrowse:=True;
  AbilitazioneActCalConferma(False);
  grdCalendario.medpAggiornaCDS;
end;

procedure TWA025FPianifBrowseFM.actCalConfermaExecute(Sender: TObject);
begin
  grdCalendario.medpConferma(ifThen(grdCalendario.medpDataSet.State = dsInsert,0,grdCalendario.medpDataSet.RecNo - IfThen(grdCalendario.RigaInserimento,0,1)));
  grdCalendario.medpBrowse:=True;
  SessioneOracle.ApplyUpdates([grdCalendario.medpDataSet],True);
  AbilitazioneActCalConferma(False);
  grdCalendario.medpAggiornaCDS(True);
end;

procedure TWA025FPianifBrowseFM.actCalModificaExecute(Sender: TObject);
begin
  grdCalendario.medpModifica(True);
  grdCalendario.medpBrowse:=False;
  AbilitazioneActCalConferma(True);
end;

procedure TWA025FPianifBrowseFM.actCalPrecedenteExecute(Sender: TObject);
// spostamento su record precedente
begin
  grdCalendario.medpDataSet.DisableControls;
  grdCalendario.medpDataSet.Prior;
  grdCalendario.medpDataSet.EnableControls;
  grdCalendario.medpAggiornaCDS(False);
end;

procedure TWA025FPianifBrowseFM.actCalPrimoExecute(Sender: TObject);
// spostamento su primo record
begin
  grdCalendario.medpDataSet.DisableControls;
  grdCalendario.medpDataSet.First;
  grdCalendario.medpDataSet.EnableControls;
  grdCalendario.medpAggiornaCDS(False);
end;

procedure TWA025FPianifBrowseFM.actCalRicercaExecute(Sender: TObject);
begin
  with TWC003FRicercaDatiFM.Create(Self.Owner) do
  begin
    SearchGrid:=grdCalendario;
    SearchDataset:=TOracleDataSet(grdCalendario.medpDataSet);
    Visualizza;
  end;
end;

procedure TWA025FPianifBrowseFM.actCalSuccessivoExecute(Sender: TObject);
begin
  grdCalendario.medpDataSet.DisableControls;
  grdCalendario.medpDataSet.Next;
  grdCalendario.medpDataSet.EnableControls;
  grdCalendario.medpAggiornaCDS(False);
end;

procedure TWA025FPianifBrowseFM.actCalUltimoExecute(Sender: TObject);
// spostamento su ultimo record
begin
  grdCalendario.medpDataSet.DisableControls;
  grdCalendario.medpDataSet.Last;
  grdCalendario.medpDataSet.EnableControls;
  grdCalendario.medpAggiornaCDS(False);
end;

procedure TWA025FPianifBrowseFM.btnCancCalClick(Sender: TObject);
{Controllo i dati e richiamo le procedure di inserimento o cancellazione}
begin
  inherited;
  if (Not TryStrToDate(edtDataDa.Text,DataDa)) or (Not TryStrToDate(edtDataA.Text,DataA)) then
  begin
    edtDataDa.SetFocus;
    raise Exception.Create(A000MSG_ERR_DATE_RIFERIMENTO);
  end;
  ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.ResetCalendario;
  grdCalendario.medpAggiornaCDS(True);
end;

procedure TWA025FPianifBrowseFM.btnInserisciClick(Sender: TObject);
var D:TDateTime;
    lDatoBloccato:Boolean;
{Controllo i dati e richiamo le procedure di inserimento o cancellazione}
begin
  //Date corrette
  try
    DataDa:=StrToDate(edtDataDa.Text);
    DataA:=StrToDate(edtDataA.Text);
  except
    edtDataDa.SetFocus;
    raise Exception.Create(A000MSG_ERR_DATE_RIFERIMENTO);
  end;
  //Date riferite allo stesso anno
  if R180Anno(DataDa) <> R180Anno(DataA) then
    raise Exception.Create(A000MSG_ERR_DATE_STESSO_ANNO);

  (WR302DM as TWA025FPianifDM).A025MW.SetSelT080;
  grdTabella.medpAggiornaCDS(True);

  //Verifico se dati bloccati sulla pianificazione
  D:=DataDa;
  while D <= DataA do
  begin
    lDatoBloccato:=False;
    if Sender = (Self.Owner as TWA025FPianif).actRegistra then
      //Inserimento: verifico il blocco sulla data generica
      lDatoBloccato:=(WR302DM as TWA025FPianifDM).A025MW.selDatiBloccati.DatoBloccato((Self.Owner as TWA025FPianif).grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(D),'T080')
    else
    begin
      //Cancellazione: verifico il blocco sulla data se attualmente pianificata
      if (WR302DM as TWA025FPianifDM).selTabella.Lookup('DATA',D,'PROGRESSIVO') > 0 then
        lDatoBloccato:=(WR302DM as TWA025FPianifDM).A025MW.selDatiBloccati.DatoBloccato((Self.Owner as TWA025FPianif).grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(D),'T080');
    end;
    if lDatoBloccato then
      raise Exception.Create(((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.selDatiBloccati.MessaggioLog);
    D:=D + 1;
  end;

  //Eseguo inserimento/cancellazione
  if Sender = (Self.Owner as TWA025FPianif).actRegistra then
    (Self.Owner as TWA025FPianif).InsPianif(DataDa,DataA)
  else
    CancPianif(DataDa,DataA);
end;

procedure TWA025FPianifBrowseFM.CancPianif(DataDa, DataA:TDateTime);
{Cancellazione pianificazione}
begin
  MsgBox.WebMessageDlg(Format(A000MSG_A025_DLG_FMT_CANCELLAZIONE,[DateToStr(DataDa),DateToStr(DataA)]),mtConfirmation,[mbYes,mbNo],ResultCancella,'');
end;

procedure TWA025FPianifBrowseFM.ResultCancella(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.CancellaPianificazione(DataDa,DataA);
    grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA025FPianifBrowseFM.btnVisualizzaClick(Sender: TObject);
begin
  ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.SetSelT080;
  ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW.OpenV010;
  grdTabella.medpAggiornaCDS(True);
  grdCalendario.medpAggiornaCDS(True);
end;

procedure TWA025FPianifBrowseFM.CaricaComboBoxAzioniMassive;
begin
  with ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW do
  begin
    //Carico cmbIndennità
    Q163.Refresh;
    Q163.First;
    while not Q163.Eof do
    begin
      cmbIndennita.AddRow(Q163.FieldByName('CODICE').AsString + ';' + Q163.FieldByName('DESCRIZIONE').AsString);
      Q163.Next;
    end;
    //Carico cmbDatoLibero
    SelDatoLibero.Refresh;
    SelDatoLibero.First;
    while not SelDatoLibero.Eof do
    begin
      cmbDatoLibero.AddRow(SelDatoLibero.FieldByName('CODICE').AsString + ';' + SelDatoLibero.FieldByName('DESCRIZIONE').AsString);
      SelDatoLibero.Next;
    end;
    //Carico cmbOrario
    Q020.Refresh;
    Q020.First;
    while not Q020.Eof do
    begin
      cmbOrario.AddRow(Q020.FieldByName('CODICE').AsString + ';' + Q020.FieldByName('DESCRIZIONE').AsString);
      Q020.Next;
    end;
  end;
end;

procedure TWA025FPianifBrowseFM.chkInsPeriodoClick(Sender: TObject);
begin
  inherited;
  if (WR302DM as TWA025FPianifDM).SelTabella.State in [dsEdit,dsInsert] then
  begin
    (WR302DM as TWA025FPianifDM).SelTabella.Cancel;
    grdTabella.medpAggiornaCDS(True);
  end;
  ControllaCheckInsPeriodo;
  VisualizzaGrpInsPeriodo;
end;

procedure TWA025FPianifBrowseFM.chkPulDatoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if chkPulDato.Checked then
  begin
    CmbDatoLibero.Text:='';
    lblDescDatoLibero.Caption:='';
  end;
end;

procedure TWA025FPianifBrowseFM.chkPulIndennitaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if chkPulIndennita.Checked then
  begin
    cmbIndennita.Text:='';
    lblDescIndennita.Caption:='';
  end;
end;

procedure TWA025FPianifBrowseFM.ControllaCheckInsPeriodo;
var js: String;
begin
  inherited;
  with (Self.Owner as TWA025FPianif) do
  begin
    actRegistra.Enabled:=(chkInsPeriodo.Checked) and (grdTabella.medpDataSet.State=dsBrowse);
    actCancPianificazione.Enabled:=(chkInsPeriodo.Checked) and (grdTabella.medpDataSet.State=dsBrowse);
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);

    js:='$("#ACTREGISTRA0WA025FPIANIF").wrap("<a title=\"Registra pianificazione nel periodo\" onclick=\"return SubmitClickConfirm(''ACTREGISTRA0WA025FPIANIF'','''', true, '''');\" href=''#''>");';
    if GGetWebApplicationThreadVar.IsCallBack then
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteasCData(js);
  end;
end;

procedure TWA025FPianifBrowseFM.chkPulOrarioAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if chkPulOrario.Checked then
  begin
    CmbOrario.Text:='';
    lblDescOrario.Caption:='';
    cmbTurno1.ItemIndex:=-1;
    cmbTurno1EU.ItemIndex:=-1;
    cmbTurno2.ItemIndex:=-1;
    cmbTurno2EU.ItemIndex:=-1;
  end;
end;

procedure TWA025FPianifBrowseFM.cmbDatoLiberoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if chkPulDato.Checked then
    CmbDatoLibero.Text:='';
  if CmbDatoLibero.Text <> '' then
    with ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW do
    begin
      selDatoLibero.SearchRecord('CODICE',CmbDatoLibero.Text,[srFromBeginning]);
      lblDescDatoLibero.Caption:=selDatoLibero.FieldByName('DESCRIZIONE').AsString;
    end
  else
    lblDescDatoLibero.Caption:='';
end;

procedure TWA025FPianifBrowseFM.cmbIndennitaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if chkPulIndennita.Checked then
    CmbIndennita.Text:='';
  if CmbIndennita.Text <> '' then
    with ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW do
    begin
      Q163.SearchRecord('CODICE',cmbIndennita.Text,[srFromBeginning]);
      lblDescIndennita.Caption:=Q163.FieldByName('DESCRIZIONE').AsString;
    end
  else
    lblDescIndennita.Caption:='';
end;

procedure TWA025FPianifBrowseFM.cmbOrarioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  i: Integer;
begin
  inherited;
  //Utente: AOSTA_REGIONE Chiamata: 90377 caricare turni in base all'orario
  cmbTurno1.Items.Clear;
  cmbTurno2.Items.Clear;
  if (WR302DM as TWA025FPianifDM).A025MW.Q020.SearchRecord('CODICE',CmbOrario.Text,[srFromBeginning]) then
  begin
    for i:=0 to (WR302DM as TWA025FPianifDM).A025MW.Q020.FieldByName('TURNI').AsInteger do
    begin
      if i = 0 then
      begin
        cmbTurno1.Items.add('0 - Riposo');
        cmbTurno2.Items.add('0 - Riposo');
      end
      else
      begin
        cmbTurno1.Items.add(IntToStr(i));
        cmbTurno2.Items.add(IntToStr(i));
      end;
    end;
  end;
  if chkPulOrario.Checked then
    CmbOrario.Text:='';
  if CmbOrario.Text <> '' then
    with ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW do
    begin
      Q020.SearchRecord('CODICE',cmbOrario.Text,[srFromBeginning]);
      lblDescOrario.Caption:=Q020.FieldByName('DESCRIZIONE').AsString;
    end
  else
    lblDescOrario.Caption:='';
end;

procedure TWA025FPianifBrowseFM.ImgCalendarioNavBarClick(Sender: TObject);
begin
  TAction(actlstCalendarioNavBar.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWA025FPianifBrowseFM.grdCalendarioDataSet2Componenti(Row: Integer);
begin
  inherited;
 (grdCalendario.medpCompCella(Row,grdCalendario.medpIndexColonna('CALCCALEND_INDIVID'),0) as TmeIWLabel).Caption:=grdCalendario.medpDataSet.FieldByName('CALCCALEND_INDIVID').AsString;
  //Combo
  with ((Self.Owner as TWA025FPianif).WR302DM as TWA025FPianifDM).A025MW do
  begin
    (grdCalendario.medpCompCella(Row,grdCalendario.medpIndexColonna('FESTIVO'),0) as TmeIWComboBox).RequireSelection:=True;
    (grdCalendario.medpCompCella(Row,grdCalendario.medpIndexColonna('LAVORATIVO'),0) as TmeIWComboBox).RequireSelection:=True;
    R180SetComboItemsValues((grdCalendario.medpCompCella(Row,grdCalendario.medpIndexColonna('FESTIVO'),0) as TmeIWComboBox).Items,D_Calend,'V');
    R180SetComboItemsValues((grdCalendario.medpCompCella(Row,grdCalendario.medpIndexColonna('LAVORATIVO'),0) as TmeIWComboBox).Items,D_Calend,'V');
  end;
  with (grdCalendario.medpCompCella(Row,grdCalendario.medpIndexColonna('FESTIVO'),0) as TmeIWComboBox) do
    ItemIndex:=Items.IndexOf(grdCalendario.medpValoreColonna(Row, 'FESTIVO'));
  with (grdCalendario.medpCompCella(Row,grdCalendario.medpIndexColonna('LAVORATIVO'),0) as TmeIWComboBox) do
    ItemIndex:=Items.IndexOf(grdCalendario.medpValoreColonna(Row, 'LAVORATIVO'));
end;

procedure TWA025FPianifBrowseFM.grdCalendarioComponenti2DataSet(Row: Integer);
begin
  inherited;
 (WR302DM as TWA025FPianifDM).A025MW.SelV010.FieldByName('FESTIVO').AsString:=(grdCalendario.medpCompCella(Row,grdCalendario.medpIndexColonna('FESTIVO'),0) as TmeIWComboBox).Text;
 (WR302DM as TWA025FPianifDM).A025MW.SelV010.FieldByName('LAVORATIVO').AsString:=(grdCalendario.medpCompCella(Row,grdCalendario.medpIndexColonna('LAVORATIVO'),0) as TmeIWComboBox).Text;
end;

procedure TWA025FPianifBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA025FPianifDM).SelTabella do
  begin
   FieldByName('ORARIO').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORARIO'),0) as TmedpIWMultiColumnComboBox).Text);
   FieldByName('INDPRESENZA').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('INDPRESENZA'),0) as TmedpIWMultiColumnComboBox).Text);
   FieldByName('TURNO1').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmeIWComboBox).Text);
   FieldByName('TURNO2').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmeIWComboBox).Text);
   FieldByName('TURNO1EU').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) as TmeIWComboBox).Text);
   FieldByName('TURNO2EU').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) as TmeIWComboBox).Text);
   if FieldByName('DATOLIBERO').Visible then
     FieldByName('DATOLIBERO').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATOLIBERO'),0) as TmedpIWMultiColumnComboBox).Text);
 end;
end;

procedure TWA025FPianifBrowseFM.imgCausaliClick(Sender: TObject);
begin
  WA025EditNoteFM:=TWA025FEditNoteFM.Create(Self.Parent);
  WA025EditNoteFM.RigaEdit:=((Sender as TmeIWImageFile).medpTag as TImgRow).NumRow;
  WA025EditNoteFM.Visualizza(WR302DM.selTabella.FieldByName('NOTE').AsString);
end;

procedure TWA025FPianifBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  i:Integer;
  img:TmeIWImageFile;
begin
  inherited;

  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOTE'),1) <> nil then
  begin
    img:=TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOTE'),1));
    img.OnClick:=imgCausaliClick;
    img.medpTag:=TImgRow.Create;
    (img.medpTag as TImgRow).NumRow:=Row;
  end;

  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA'),0)).Css:='input_data_dmy';
  if(DaCartellino) then
    TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA'),0)).Text:=edtDataDa.Text;
 (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_ORARIO'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('D_ORARIO').AsString;
 (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_INDENNITA'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('D_INDENNITA').AsString;
  //Combo Orario
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORARIO'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    OnAsyncChange:=cmbOrarioGrdAsyncChange;
    Text:=ifthen((grdTabella.medpValoreColonna(Row, 'ORARIO')<>''),grdTabella.medpValoreColonna(Row, 'ORARIO'),'');
    (WR302DM as TWA025FPianifDM).A025MW.Q020.Refresh;
    (WR302DM as TWA025FPianifDM).A025MW.Q020.First;
    while not (WR302DM as TWA025FPianifDM).A025MW.Q020.Eof do
    begin
     (WR302DM as TWA025FPianifDM).OrarioPickList.Add((WR302DM as TWA025FPianifDM).A025MW.Q020.FieldByName('CODICE').AsString);
      AddRow((WR302DM as TWA025FPianifDM).A025MW.Q020.FieldByName('CODICE').AsString + ';' + (WR302DM as TWA025FPianifDM).A025MW.Q020.FieldByName('DESCRIZIONE').AsString);
      (WR302DM as TWA025FPianifDM).A025MW.Q020.Next;
    end;
  end;
  //Combo Indennità
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('INDPRESENZA'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    OnAsyncChange:=cmbTipoGrdAsyncChange;
    Text:=ifthen((grdTabella.medpValoreColonna(Row, 'INDPRESENZA')<>''),grdTabella.medpValoreColonna(Row, 'INDPRESENZA'),'');
    (WR302DM as TWA025FPianifDM).A025MW.Q163.Refresh;
    (WR302DM as TWA025FPianifDM).A025MW.Q163.First;
    while not (WR302DM as TWA025FPianifDM).A025MW.Q163.Eof do
    begin
     (WR302DM as TWA025FPianifDM).IndPresenzaPickList.Add((WR302DM as TWA025FPianifDM).A025MW.Q163.FieldByName('CODICE').AsString);
      AddRow((WR302DM as TWA025FPianifDM).A025MW.Q163.FieldByName('CODICE').AsString + ';' + (WR302DM as TWA025FPianifDM).A025MW.Q163.FieldByName('DESCRIZIONE').AsString);
      (WR302DM as TWA025FPianifDM).A025MW.Q163.Next;
    end;
  end;
  //Combo Turni
  with (WR302DM as TWA025FPianifDM).A025MW do
  begin
    //Utente: AOSTA_REGIONE Chiamata: 92165. controllo E/U. le due TStrings non servono
    //(WR302DM as TWA025FPianifDM).Turno1EuPickList.Text:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) as TmeIWComboBox).Text;
    //(WR302DM as TWA025FPianifDM).Turno2EuPickList.Text:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) as TmeIWComboBox).Text;

    //Utente: AOSTA_REGIONE Chiamata: 90377 caricare turni in base all'orario
    caricaPicklistTurni(Row);
    //R180SetComboItemsValues((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmeIWComboBox).Items,D_Turno,'V');
//    R180SetComboItemsValues((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmeIWComboBox).Items,D_Turno,'V');

    R180SetComboItemsValues((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) as TmeIWComboBox).Items,D_TurnoEU,'V');
    R180SetComboItemsValues((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) as TmeIWComboBox).Items,D_TurnoEU,'V');
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmeIWComboBox).NoSelectionText:=' ';
        (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmeIWComboBox).NoSelectionText:=' ';

    SetItemIndexTurni(Row,'TURNO1');
    SetItemIndexTurni(Row,'TURNO2');
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) as TmeIWComboBox) do
      ItemIndex:=IfThen(Items.IndexOf(grdTabella.medpValoreColonna(Row, 'TURNO1EU'))>0, Items.IndexOf(grdTabella.medpValoreColonna(Row, 'TURNO1EU')), 0);
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) as TmeIWComboBox) do
      ItemIndex:=IfThen(Items.IndexOf(grdTabella.medpValoreColonna(Row, 'TURNO2EU'))>0, Items.IndexOf(grdTabella.medpValoreColonna(Row, 'TURNO2EU')), 0);
  end;
  //Combo Campo libero
  if (WR302DM as TWA025FPianifDM).SelTabella.FieldByName('DATOLIBERO').Visible
      and((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATOLIBERO'),0) as TmedpIWMultiColumnComboBox) <> nil) then
    begin
     (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_DATOLIBERO'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('D_DATOLIBERO').AsString;
      with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATOLIBERO'),0) as TmedpIWMultiColumnComboBox) do
      begin
        Tag:=Row;
        items.Clear;
        OnAsyncChange:=cmbDatoLiberoGrdAsyncChange;
        Text:=ifthen((grdTabella.medpValoreColonna(Row, 'DATOLIBERO')<>''),grdTabella.medpValoreColonna(Row, 'DATOLIBERO'),'');
        (WR302DM as TWA025FPianifDM).A025MW.selDatoLibero.Refresh;
        (WR302DM as TWA025FPianifDM).A025MW.selDatoLibero.First;
        while not (WR302DM as TWA025FPianifDM).A025MW.selDatoLibero.Eof do
        begin
          AddRow((WR302DM as TWA025FPianifDM).A025MW.selDatoLibero.FieldByName('CODICE').AsString + ';' + (WR302DM as TWA025FPianifDM).A025MW.selDatoLibero.FieldByName('DESCRIZIONE').AsString);
          (WR302DM as TWA025FPianifDM).DatoLiberoPickList.Add((WR302DM as TWA025FPianifDM).A025MW.selDatoLibero.FieldByName('CODICE').AsString);
          (WR302DM as TWA025FPianifDM).A025MW.selDatoLibero.Next;
        end;
      end;
    end;
end;

procedure TWA025FPianifBrowseFM.CaricaPickListTurni(Row:Integer);
var
  i: Integer;
  cmb1,cmb2: TmeIWComboBox;
begin
  cmb1:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmeIWComboBox);
  cmb2:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmeIWComboBox);

  cmb1.items.clear;
  cmb2.items.clear;
  cmb1.RequireSelection:=False;
  cmb2.RequireSelection:=False;
  if (WR302DM as TWA025FPianifDM).A025MW.Q020.SearchRecord('CODICE',WR302DM.seltabella.FieldByName('ORARIO').AsString,[srFromBeginning]) then
  begin
    for i:=0 to (WR302DM as TWA025FPianifDM).A025MW.Q020.FieldByName('TURNI').AsInteger do
    begin
      if i = 0 then
      begin
        cmb1.items.Add('0 - Riposo');
        cmb2.items.Add('0 - Riposo');
      end
      else
      begin
        cmb1.items.Add(IntTostr(i));
        cmb2.items.Add(IntTostr(i));
      end;
    end;
  end;
end;

procedure TWA025FPianifBrowseFM.SetItemIndexTurni(Row:Integer; Field :String);
var i:Integer;
  cmb1: TmeIWComboBox;
begin
  cmb1:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna(Field),0) as TmeIWComboBox);

  for i:=0 to cmb1.Items.Count - 1 do
    if grdTabella.medpValoreColonna(Row, Field) = cmb1.Items[i] then
      cmb1.ItemIndex:=i;
end;

procedure TWA025FPianifBrowseFM.cmbDatoLiberoGrdAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  grdTabella.medpDataSet.FieldByName('DATOLIBERO').AsString:=(Sender as TmedpIWMultiColumnComboBox).Text;
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_DATOLIBERO'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_DATOLIBERO').AsString;
end;

procedure TWA025FPianifBrowseFM.cmbTipoGrdAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  grdTabella.medpDataSet.FieldByName('INDPRESENZA').AsString:=(Sender as TmedpIWMultiColumnComboBox).Text;
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_INDENNITA'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_INDENNITA').AsString;
end;

procedure TWA025FPianifBrowseFM.cmbOrarioGrdAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  grdTabella.medpDataSet.FieldByName('ORARIO').AsString:=(Sender as TmedpIWMultiColumnComboBox).Text;
  CaricaPickListTurni(Row);
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_ORARIO'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_ORARIO').AsString;
end;

procedure TWA025FPianifBrowseFM.grdCalendarioRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  if ARow = 0 then Exit;

  with TOracleDataSet(grdCalendario.medpClientDataset) do
  begin
    if (Active) and (RecordCount > 0) and (AColumn = 0) then
        ACell.Css:=grdCalendarioAssignCssCell;
  end;

  NumColonna:=grdCalendario.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdCalendario.medpCompGriglia) + 1) and (grdCalendario.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdCalendario.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA025FPianifBrowseFM.AbilitazioneActCalConferma(Abilitazione: boolean);
var i: Integer;
begin
  for i := 0 to actlstCalendarioNavBar.ActionCount - 1 do
    TAction(actlstCalendarioNavBar.Actions[i]).Enabled:=not Abilitazione;
  actCalConferma.Enabled:=Abilitazione;
  actCalAnnulla.Enabled:=Abilitazione;
  (Self.Owner as TWA025FPianif).AggiornaToolBar(grdCalendarioNavBar,actlstCalendarioNavBar);
end;

function TWA025FPianifBrowseFM.grdCalendarioAssignCssCell: String;
begin
  inherited;
  with grdCalendario.medpClientDataSet do
  begin
    if (FieldByName('FESTIVO').AsString = 'S') and
       (FieldByName('LAVORATIVO').AsString = 'N') then
      Result:=' bg_aqua'    //clAqua su Win
    else if FieldByName('FESTIVO').AsString = 'S' then
      Result:=' bg_giallo'  //clYellow su Win
    else if FieldByName('LAVORATIVO').AsString = 'N' then
      Result:=' bg_lime'; //clLime su Win
  end;
end;

procedure TWA025FPianifBrowseFM.VisualizzaGrpInsPeriodo;
begin
  chkPulOrario.Visible:=chkInsPeriodo.Checked;
  cmbOrario.Visible:=chkInsPeriodo.Checked;
  lblDescOrario.Visible:=chkInsPeriodo.Checked;
  lblOrario.Visible:=chkInsPeriodo.Checked;
  cmbTurno1.Visible:=chkInsPeriodo.Checked;
  lbl1Turno.Visible:=chkInsPeriodo.Checked;
  cmbTurno1EU.Visible:=chkInsPeriodo.Checked;
  cmbTurno2.Visible:=chkInsPeriodo.Checked;
  lbl2Turno.Visible:=chkInsPeriodo.Checked;
  cmbTurno2EU.Visible:=chkInsPeriodo.Checked;

  chkPulIndennita.Visible:=chkInsPeriodo.Checked;
  lblIndPresenza.Visible:=chkInsPeriodo.Checked;
  cmbIndennita.Visible:=chkInsPeriodo.Checked;
  lblDescIndennita.Visible:=chkInsPeriodo.Checked;

  chkPulDato.Visible:=chkInsPeriodo.Checked;
  cmbDatoLibero.Visible:=chkInsPeriodo.Checked;
  lblDatoLibero.Visible:=chkInsPeriodo.Checked;
  lblDescDatoLibero.Visible:=chkInsPeriodo.Checked;
end;

end.
