unit A025UPianif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Buttons, Mask, Grids, DBGrids, ExtCtrls, ComCtrls,
  Menus, Oracle, ActnList, ImgList, Db, ToolWin, Variants, OracleData,
  A000UCostanti, A000USessione,A000UInterfaccia, A002UInterfacciaSt,
  A000UMessaggi, A006UModelliOrario, A024UIndPresenza, A083UMsgElaborazioni,
  B021UWebSvcClientDtM, C001UFiltroTabelleDtM, C001UFiltroTabelle, C001UScegliCampi,
  C005UDatiAnagrafici, C700USelezioneAnagrafe, C180FunzioniGenerali,
  R001UGESTTAB, RegistrazioneLog, SelAnagrafe, ToolbarFiglio, System.Actions,
  C012UVisualizzaTesto, InputPeriodo, System.ImageList, Math;

type
  TA025FPianif = class(TR001FGestTab)
    dGrdPianif: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    dGrdCal: TDBGrid;
    Splitter2: TSplitter;
    pnlPianifOrari: TPanel;
    pnlPianifCalendari: TPanel;
    actAcquisizioneTurni: TAction;
    N4: TMenuItem;
    Acquisizioneturni1: TMenuItem;
    actVisualizzaAnomalie: TAction;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    frmToolbarFiglio: TfrmToolbarFiglio;
    Panel2: TPanel;
    btnVisualizza: TBitBtn;
    GroupBox1: TGroupBox;
    ProgressBar1: TProgressBar;
    CheckBox1: TCheckBox;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    actRegistra: TAction;
    actCancPianificazione: TAction;
    pnllInsPeriodo: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    lblDatoLibero: TLabel;
    lblDescDato: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblDescOrario: TLabel;
    lblDescInd: TLabel;
    dCmbOrario: TDBLookupComboBox;
    dCmbIndennita: TDBLookupComboBox;
    dCmbDatoLibero: TDBLookupComboBox;
    cmbTurno1: TComboBox;
    cmbTurno1EU: TComboBox;
    cmbTurno2EU: TComboBox;
    cmbTurno2: TComboBox;
    chkPulOrario: TCheckBox;
    chkPulIndennita: TCheckBox;
    chkPulDato: TCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure dcmbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInserisciClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TfrmSelAnagrafe1btnSelezioneClick(Sender: TObject);
    procedure TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnVisualizzaClick(Sender: TObject);
    procedure dCmbDatoLiberoCloseUp(Sender: TObject);
    procedure dCmbDatoLiberoKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure dCmbIndennitaCloseUp(Sender: TObject);
    procedure dCmbIndennitaKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure dCmbOrarioCloseUp(Sender: TObject);
    procedure dcmbOrarioKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure DButtonStateChange(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure cmbTurno1EUKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure cmbTurno2EUKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure chkPulOrarioClick(Sender: TObject);
    procedure chkPulIndennitaClick(Sender: TObject);
    procedure chkPulDatoClick(Sender: TObject);
    procedure dGrdCalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actAcquisizioneTurniExecute(Sender: TObject);
    procedure actVisualizzaAnomalieExecute(Sender: TObject);
    procedure frmToolbarFigliobtnTFAnnullaClick(Sender: TObject);
    procedure frmToolbarFigliobtnTFConfermaClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure frmToolbarFiglioactTFGenerica1Execute(Sender: TObject);
    procedure actRegistraExecute(Sender: TObject);
    procedure actCancPianificazioneExecute(Sender: TObject);
    procedure dGrdPianifEditButtonClick(Sender: TObject);
  private
    DaCartellino:Boolean;
    procedure InsPianif(DataDa,DataA:TDateTime);
    procedure CancPianif(DataDa,DataA:TDateTime);
    procedure CambiaProgressivo;
    procedure ControllaCheckInsPeriodo;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    procedure CaricaPickListTurni;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A025FPianif: TA025FPianif;

procedure OpenA025Pianif(Prog:LongInt;Orario,IndPre,Turni:String;Data:TDateTime;Cartel:Boolean);

implementation

uses A025UPianifDtM1;

{$R *.DFM}

procedure OpenA025Pianif(Prog:LongInt;Orario,IndPre,Turni:String;Data:TDateTime;Cartel:Boolean);
{Pianificazione Orari/Indennità presenza}
begin
  if Prog <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA025Pianif') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A025FPianif:=TA025FPianif.Create(nil);
  with A025FPianif do
  try
    C700Progressivo:=Prog;
    DataI:= Data;
    DataF:= Data;
    A025FPianifDtM1:=TA025FPianifDtM1.Create(nil);
    dgrdPianif.ReadOnly:=SolaLettura;
    dGrdCal.ReadOnly:=SolaLettura;
    actRegistra.Enabled:=Not SolaLettura;
    actCancPianificazione.Enabled:=Not SolaLettura;
    DaCartellino:=Cartel;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A025FPianifDtM1.Free;
    Free;
  end;
end;

procedure TA025FPianif.FormShow(Sender: TObject);
begin
  frmToolbarFiglio.TFDButton:=A025FPianifDtM1.A025MW.dscV010;
  frmToolbarFiglio.TFDBGrid:=dGrdCal;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  inherited;
  dCmbOrario.ListSource:=A025FPianifDtM1.A025MW.D020;
  dCmbIndennita.ListSource:=A025FPianifDtM1.A025MW.D163;
  dGrdCal.DataSource:=A025FPianifDtM1.A025MW.dscV010;
  dCmbDatoLibero.ListSource := A025FPianifDtM1.A025MW.dsrDatoLibero;
  actAcquisizioneTurni.Visible:=(Parametri.CampiRiferimento.C30_WebSrv_A025_URL_GET <> '') and (Parametri.CampiRiferimento.C30_WebSrv_A025_URL_PUT <> '');
  actVisualizzaAnomalie.Visible:=actAcquisizioneTurni.Visible;
  actVisualizzaAnomalie.Enabled:=False;
  N4.Visible:=actAcquisizioneTurni.Visible;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A025FPianifDtM1.A025MW,SessioneOracle,StatusBar,0,True);
  with A025FPianifDtM1.Q080 do
    if (RecordCount = 0) and (not SolaLettura) and DaCartellino then
    begin
      Insert;
      if DataI > 0 then FieldByName('DATA').AsDateTime:= DataI;
    end;
  //Utente: AOSTA_REGIONE Chiamata: 90377 caricare turni in base all'orario
  cmbTurno1.Items.clear;
  //R180SetComboItemsValues(cmbTurno1.Items,A025FPianifDtM1.A025MW.D_Turno,'V');
  R180SetComboItemsValues(cmbTurno1EU.Items,A025FPianifDtM1.A025MW.D_TurnoEU,'V');
  cmbTurno2.Items.clear;
  //R180SetComboItemsValues(cmbTurno2.Items,A025FPianifDtM1.A025MW.D_Turno,'V');
  R180SetComboItemsValues(cmbTurno2EU.Items,A025FPianifDtM1.A025MW.D_TurnoEU,'V');
  ControllaCheckInsPeriodo;
end;

procedure TA025FPianif.frmToolbarFiglioactTFGenerica1Execute(Sender: TObject);
{Controllo i dati e richiamo le procedure di inserimento o cancellazione}
begin
  inherited;
  if (DataI <= 0) or (DataF <= 0) then
  begin
    frmInputPeriodo.edtInizio.SetFocus;
    raise Exception.Create(A000MSG_ERR_DATE_RIFERIMENTO);
  end;
  A025FPianifDtM1.A025MW.ResetCalendario;
end;

procedure TA025FPianif.frmToolbarFigliobtnTFAnnullaClick(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFAnnullaExecute(Sender);
  //SessioneOracle.CancelUpdates([A025FPianifDtM1.A025MW.selV010]);
  A025FPianifDtM1.A025MW.selV010.CancelUpdates;
  frmToolbarFiglio.actTFBrowseExecute(frmToolbarFiglio.actTFRefresh);
end;

procedure TA025FPianif.frmToolbarFigliobtnTFConfermaClick(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFConfermaExecute(Sender);
  frmToolbarFiglio.actTFBrowseExecute(frmToolbarFiglio.actTFRefresh);
end;

procedure TA025FPianif.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA025FPianif.btnInserisciClick(Sender: TObject);
var D,DataDa,DataA:TDateTime;
{Controllo i dati e richiamo le procedure di inserimento o cancellazione}
begin
  if (DataI <= 0) or (DataF <= 0) then
  begin
     frmInputPeriodo.edtInizio.SetFocus;
    raise Exception.Create(A000MSG_ERR_DATE_RIFERIMENTO)
  end;
  DataDa:= DataI;
  DataA:= DataF;
  D:=DataDa;
  while D <= DataA do
  begin
    if A025FPianifDtM1.A025MW.selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(D),'T080') then
      raise Exception.Create(A025FPianifDtM1.A025MW.selDatiBloccati.MessaggioLog);
    D:=D + 1;
  end;
  if Sender = actRegistra then
    InsPianif(DataDa,DataA)
  else
    CancPianif(DataDa,DataA);
end;

procedure TA025FPianif.InsPianif(DataDa,DataA:TDateTime);
{Inserimento pianificazione}
var DataCorr:TDateTime;
begin
  with A025FPianifDtM1 do
  begin
    // Setto parametri MW
    A025MW.Turno1:=cmbTurno1.Text;
    A025MW.Turno2:=cmbTurno2.Text;
    A025MW.Orario:=dCmbOrario.Text;
    A025MW.Turno1EU:=Trim(cmbTurno1EU.Text);
    A025MW.Turno2EU:=Trim(cmbTurno2EU.Text);
    A025MW.Turno1EUItemIndex:=CmbTurno1EU.ItemIndex;
    A025MW.Turno2EUItemIndex:=CmbTurno2EU.ItemIndex;
    A025MW.Indennita:=dCmbIndennita.Text;
    A025MW.DatoLibero:=dCmbDatoLibero.Text;
    A025MW.DatoLiberoCaption:=lblDatoLibero.Caption;
    A025MW.PulDatoChecked:=chkPulDato.Checked;
    A025MW.PulOrarioChecked:=chkPulOrario.Checked;
    A025MW.PulIndennitaChecked:=chkPulIndennita.Checked;
    A025MW.DatoLiberoEnabled:=dCmbDatoLibero.Enabled;
    A025MW.ControlliInsPianificazione;
    CmbTurno1EU.ItemIndex:=A025MW.Turno1EUItemIndex;
    CmbTurno2EU.ItemIndex:=A025MW.Turno2EUItemIndex;
    A025MW.Turno1EU:=Trim(cmbTurno1EU.Text);
    A025MW.Turno2EU:=Trim(cmbTurno2EU.Text);
  end;
  if R180MessageBox(Format(A000MSG_A025_DLG_FMT_ESEGUI_INSERIMENTO,[DateToStr(DataDa),DateToStr(DataA)]), 'DOMANDA') = mrNo then
    Abort;
  ProgressBar1.Min:=0;
  ProgressBar1.Max:=Round(DataA) - Round(DataDa);
  ProgressBar1.Position:=0;
  DataCorr:=DataDa;
  with A025FPianifDtM1 do
  begin
    // Ciclo DataA
    while DataCorr <= DataA do
    begin
      A025MW.DataCorrente:=DataCorr;
      ProgressBar1.Position:=ProgressBar1.Position + 1;
      if (dCmbOrario.Text <> '') or (dCmbIndennita.Text <> '') or
         (dCmbDatoLibero.Text <> '') then
        A025MW.InserisciPianificazione
      else
        A025MW.AggiornaPianificazione;
      DataCorr:=DataCorr+1;
    end;
    if (dCmbOrario.Text = '') and (dCmbIndennita.Text = '') and
       (dCmbDatoLibero.Text = '') then
       A025MW.CancellaT080(DataDa,DataA);
    SessioneOracle.Commit;
    A025MW.SetSelT080;
    NumRecords;
  end;
  ProgressBar1.Position:=0;
end;

procedure TA025FPianif.actAcquisizioneTurniExecute(Sender: TObject);
{2 fasi:
 - Chiamata servizio firlab 'Calendar' in get
 - Chiamata nostro servizio 'Turni' in put passando il risultato della chiamata precedente
}
var B021FWebSvcClientDtM:TB021FWebSvcClientDtM;
var EsistonoMsgAnomalie:Boolean;
begin
  inherited;
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP)
  else if MessageDlg(Format(A000MSG_A025_DLG_FMT_ACQUISIZ_TURNI,[frmInputPeriodo.edtInizio.Text,frmInputPeriodo.edtFine.Text]),
                     mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  actVisualizzaAnomalie.Enabled:=False;
  B021FWebSvcClientDtM:=TB021FWebSvcClientDtM.Create(nil);
  try
    with C700SelAnagrafe do
    begin
      ProgressBar1.Max:=RecordCount;
      ProgressBar1.Position:=0;
      First;
      while not Eof do
      begin
        ProgressBar1.StepIt;
        B021FWebSvcClientDtM.WebSvcRecordT080(FieldByName('PROGRESSIVO').AsInteger,
                                              FieldByName('MATRICOLA').AsString,
                                              DataI,
                                              DataF);
        Next;
      end;
    end;
    EsistonoMsgAnomalie:=B021FWebSvcClientDtM.EsistonoMsgAnomalie;
    actVisualizzaAnomalie.Enabled:=EsistonoMsgAnomalie;
  finally
    FreeAndNil(B021FWebSvcClientDtM);
  end;
  btnVisualizzaClick(nil);
  if EsistonoMsgAnomalie then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes) then
      actVisualizzaAnomalieExecute(nil);
  end
  else
    ShowMessage(A000MSG_MSG_ACQUISIZIONE_TERMINATA);
end;

procedure TA025FPianif.actCancPianificazioneExecute(Sender: TObject);
begin
  inherited;
  btnInserisciClick(actCancPianificazione);
end;

procedure TA025FPianif.actRegistraExecute(Sender: TObject);
begin
  inherited;
  btnInserisciClick(actRegistra);
end;

procedure TA025FPianif.actVisualizzaAnomalieExecute(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A040WEBSRV','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A025FPianifDtM1.A025MW);
end;

procedure TA025FPianif.CancPianif(DataDa, DataA:TDateTime);
{Cancellazione pianificazione}
begin
  if R180MessageBox(Format(A000MSG_A025_DLG_FMT_CANCELLAZIONE,[DateToStr(DataDa),DateToStr(DataA)]), 'DOMANDA') = mrNo then
    Abort;
  A025FPianifDtM1.A025MW.CancellaPianificazione(DataDa,DataA);
end;

procedure TA025FPianif.CheckBox1Click(Sender: TObject);
begin
  inherited;
  if A025FPianifDtM1.Q080.state in [dsEdit,dsInsert] then
    A025FPianifDtM1.Q080.Cancel;
  ControllaCheckInsPeriodo;
end;

procedure TA025FPianif.ControllaCheckInsPeriodo;
begin
  inherited;
  pnllInsPeriodo.Visible:=CheckBox1.Checked;
  actRegistra.Visible:=CheckBox1.Checked;
  actRegistra.Enabled:=(CheckBox1.Checked) and (DButton.DataSet.State=dsBrowse);
  actCancPianificazione.Visible:=CheckBox1.Checked;
  actCancPianificazione.Enabled:=(CheckBox1.Checked) and (DButton.DataSet.State=dsBrowse);
  frmToolbarFiglio.actTFGenerica1.Visible:=True;
  frmToolbarFiglio.actTFGenerica1.Enabled:=True;
  if pnllInsPeriodo.Visible then
    GroupBox1.Height:=158
  else
    GroupBox1.Height:=20;
end;

procedure TA025FPianif.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  inherited;
  SessioneOracle.Commit;
end;

procedure TA025FPianif.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
    btnVisualizzaClick(nil);
end;

procedure TA025FPianif.dGrdCalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  with A025FPianifDtM1 do
  begin
    if (A025MW.selV010.FieldByName('FESTIVO').AsString = 'S') and
       (A025MW.selV010.FieldByName('LAVORATIVO').AsString = 'N') then
    begin
      dGrdCal.Canvas.Brush.Color:=clAqua;
      dGrdCal.Canvas.Font.Color:=clWindowText;
      dGrdCal.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end
    else if A025MW.selV010.FieldByName('FESTIVO').AsString = 'S' then
    begin
      dGrdCal.Canvas.Brush.Color:=clYellow;
      dGrdCal.Canvas.Font.Color:=clWindowText;
      dGrdCal.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end
    else if A025MW.selV010.FieldByName('LAVORATIVO').AsString = 'N' then
    begin
      dGrdCal.Canvas.Brush.Color:=clLime;
      dGrdCal.Canvas.Font.Color:=clWindowText;
      dGrdCal.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end;
  end;
end;

procedure TA025FPianif.dGrdPianifEditButtonClick(Sender: TObject);
var
  NoteStr:TStringList;
  C012Btn:TMsgDlgButtons;
begin
  inherited;
  //Click campo note
  if dGrdPianif.SelectedField.FieldName = 'NOTE' then
  begin
    NoteStr:=TStringList.Create;
    try
      //Elenco bottoni per edit e insert
      if not SolaLettura then
      begin
        C012Btn:=[mbOk,mbCancel];
      end
      else
      begin
        C012Btn:=[mbClose];
      end;
      NoteStr.Text:=dGrdPianif.SelectedField.AsString;
      OpenC012VisualizzaTesto('<A025> Pianificazioni giornaliere', '', NoteStr, '',C012Btn);
      if (not SolaLettura) and (A025FPianifDtM1.Q080.State in [dsBrowse]) then
      begin
        A025FPianifDtM1.Q080.Edit;
        dGrdPianif.SelectedField.AsString:=NoteStr.Text;
      end;
    finally
      FreeAndNil(NoteStr);
    end;
  end;
end;

procedure TA025FPianif.btnVisualizzaClick(Sender: TObject);
var i:Integer;
begin
  A025FPianifDtM1.A025MW.SetSelT080;
  A025FPianifDtM1.A025MW.OpenV010;
  NumRecords;
  i:=R180GetColonnaDBGrid(dGrdPianif,'D_MOTIVAZIONE');
  if i >= 0 then
    dGrdPianif.Columns[i].Visible:=A025FPianifDtM1.Q080.FieldByName('D_MOTIVAZIONE').Visible;
end;

procedure TA025FPianif.TfrmSelAnagrafe1btnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:= IfThen(DataF>0, DataF, Parametri.DataLavoro);
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA025FPianif.TfrmSelAnagrafe1R003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:= IfThen(DataF>0, DataF, Parametri.DataLavoro);
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA025FPianif.dCmbDatoLiberoCloseUp(Sender: TObject);
begin
  if chkPulDato.Checked then
    dCmbDatoLibero.KeyValue:='';
  if dCmbDatoLibero.Text <> '' then
    lblDescDato.Caption:=A025FPianifDtM1.A025MW.selDatoLibero.FieldByName('DESCRIZIONE').AsString
  else
    lblDescDato.Caption:='';
end;

procedure TA025FPianif.dCmbDatoLiberoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_DELETE) then
    dCmbDatoLiberoCloseUp(Sender);
end;

procedure TA025FPianif.dCmbIndennitaCloseUp(Sender: TObject);
begin
  inherited;
  if chkPulIndennita.Checked then
    dCmbIndennita.KeyValue:='';
  if dCmbIndennita.Text <> '' then
    lblDescInd.Caption:=A025FPianifDtM1.A025MW.Q163.FieldByName('DESCRIZIONE').AsString
  else
    lblDescInd.Caption:='';
end;

procedure TA025FPianif.dCmbIndennitaKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  inherited;
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_DELETE) then
    dCmbIndennitaCloseUp(Sender);
end;

procedure TA025FPianif.dCmbOrarioCloseUp(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  //Utente: AOSTA_REGIONE Chiamata: 90377 caricare turni in base all'orario
  cmbTurno1.Items.Clear;
  cmbTurno2.Items.Clear;
  if A025FPianifDtM1.A025MW.Q020.SearchRecord('CODICE',dCmbOrario.Text,[srFromBeginning]) then
  begin
    for i:=0 to A025FPianifDtM1.A025MW.Q020.FieldByName('TURNI').AsInteger do
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
    dCmbOrario.KeyValue:='';
  if dCmbOrario.Text <> '' then
    lblDescOrario.Caption:=A025FPianifDtM1.A025MW.Q020.FieldByName('DESCRIZIONE').AsString
  else
    lblDescOrario.Caption:='';
end;

procedure TA025FPianif.dcmbOrarioKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_DELETE) then
    dcmbOrarioCloseUp(Sender);
end;

procedure TA025FPianif.DButtonStateChange(Sender: TObject);
begin
  inherited;
  //Utente: AOSTA_REGIONE Chiamata: 90377 caricare turni in base all'orario
  CaricaPickListTurni;
  frmSelAnagrafe.pnlSelAnagrafe.Enabled:=DButton.DataSet.State = dsBrowse;
  ControllaCheckInsPeriodo;
end;

procedure TA025FPianif.CaricaPickListTurni();
var
  i: Integer;
begin
  dGrdPianif.Columns[3].PickList.clear;
  dGrdPianif.Columns[5].PickList.clear;

  if DButton.DataSet.State in [dsInsert, dsEdit] then
  begin
    if A025FPianifDtM1.A025MW.Q020.SearchRecord('CODICE',A025FPianifDtM1.Q080.FieldByName('ORARIO').AsString,[srFromBeginning]) then
    begin
      for i:=0 to A025FPianifDtM1.A025MW.Q020.FieldByName('TURNI').AsInteger do
      begin
        if i = 0 then
        begin
          dGrdPianif.Columns[3].PickList.Add('0 - Riposo');
          dGrdPianif.Columns[5].PickList.Add('0 - Riposo');
        end
        else
        begin
          dGrdPianif.Columns[3].PickList.Add(IntTostr(i));
          dGrdPianif.Columns[5].PickList.Add(IntTostr(i));
        end;
      end;
    end;
  end;
end;

procedure TA025FPianif.Nuovoelemento1Click(Sender: TObject);
begin
  if PopupMenu1.PopupComponent = dCmbOrario then
  begin
    OpenA006ModelliOrario(dCmbOrario.Text);
    A025FPianifDtM1.A025MW.Q020.DisableControls;
    A025FPianifDtM1.A025MW.Q020.Refresh;
    A025FPianifDtM1.A025MW.Q020.EnableControls;
  end
  else
  begin
    OpenA024IndPresenza(dCmbIndennita.Text);
    A025FPianifDtM1.A025MW.Q163.DisableControls;
    A025FPianifDtM1.A025MW.Q163.Refresh;
    A025FPianifDtM1.A025MW.Q163.EnableControls
  end;
end;

procedure TA025FPianif.cmbTurno1EUKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
    cmbTurno1EU.ItemIndex:=0;
end;

procedure TA025FPianif.cmbTurno2EUKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
    cmbTurno2EU.ItemIndex:=0;
end;

procedure TA025FPianif.chkPulOrarioClick(Sender: TObject);
begin
  inherited;
  if chkPulOrario.Checked then
  begin
    dCmbOrario.KeyValue:='';
    lblDescOrario.Caption:='';
    cmbTurno1.ItemIndex:=-1;
    cmbTurno1EU.ItemIndex:=-1;
    cmbTurno2.ItemIndex:=-1;
    cmbTurno2EU.ItemIndex:=-1;
  end;
end;

procedure TA025FPianif.chkPulIndennitaClick(Sender: TObject);
begin
  inherited;
  if chkPulIndennita.Checked then
  begin
    dCmbIndennita.KeyValue:='';
    lblDescInd.Caption:='';
  end;
end;

procedure TA025FPianif.chkPulDatoClick(Sender: TObject);
begin
  inherited;
  if chkPulDato.Checked then
  begin
    dCmbDatoLibero.KeyValue:='';
    lblDescDato.Caption:='';
  end;
end;

procedure TA025FPianif.dcmbKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

{ DataF }
function TA025FPianif._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA025FPianif._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ----DataF }
{ DataI }
function TA025FPianif._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA025FPianif._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ----DataI }

end.
