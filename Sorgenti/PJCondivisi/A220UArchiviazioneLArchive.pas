unit A220UArchiviazioneLArchive;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, A000UCostanti, A000USessione, A000UInterfaccia,
  A000UMessaggi, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, A220UArchiviazioneLArchiveDtM, System.ImageList,
  Vcl.ImgList, A083UMsgElaborazioni, InputPeriodo, C180FunzioniGenerali, System.Diagnostics,
  Vcl.DBCtrls, Vcl.Menus, C004UParamForm, StrUtils;

type

  TStatoArchiviazioneLarchive = (saVuoto, saDocCaricati, saElabInCorso, saElabTerminata, saElabArrestata);

  TA220FArchiviazioneLArchive = class(TForm)
    PageControl: TPageControl;
    tabElaborazione: TTabSheet;
    tabStorico: TTabSheet;
    Panel2: TPanel;
    ProgressBar: TProgressBar;
    StatusBar: TStatusBar;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    btnAnomalie: TBitBtn;
    dgrdFileCaricati: TDBGrid;
    FileOpenDialogFile: TFileOpenDialog;
    ImageList: TImageList;
    FileOpenDialogDir: TFileOpenDialog;
    btnTerminaElaborazione: TBitBtn;
    dgrdStorico: TDBGrid;
    pmnuGrid: TPopupMenu;
    Selezionatutto2: TMenuItem;
    Deselezionatutto2: TMenuItem;
    Invertiselezione2: TMenuItem;
    N4: TMenuItem;
    Copia1: TMenuItem;
    CopiainExcel1: TMenuItem;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    lblEsitoTrasmissione: TLabel;
    lblTipoDocumento: TLabel;
    lblDocUserId: TLabel;
    frmInputPeriodo: TfrmInputPeriodo;
    cmbPdvStatus: TComboBox;
    edtDocUserId: TEdit;
    btnAggiorna: TBitBtn;
    ToolBar1: TToolBar;
    btnInserisciListaDoc: TToolButton;
    btnInsDocumento: TToolButton;
    ToolButton1: TToolButton;
    btnClear: TToolButton;
    btnCancellaDoc: TToolButton;
    cmbTipoDocumento: TComboBox;
    lblDocFileName: TLabel;
    edtDocFileName: TEdit;
    chkEliminaFile: TCheckBox;
    lblId: TLabel;
    edtId: TEdit;
    btnSvuotaFiltro: TBitBtn;
    Panel3: TPanel;
    ProgressBarPdvStatus: TProgressBar;
    btnAggiornaPdvStatus: TBitBtn;
    btnAnomaliePdvStatus: TBitBtn;
    btnTerminaElaborazionePdvStatus: TBitBtn;
    StatusBarPdvStatus: TStatusBar;
    procedure CaricaListaClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure CancellaSingoloClick(Sender: TObject);
    procedure CaricaSingoloClick(Sender: TObject);
    procedure EseguiClick(Sender: TObject);
    procedure btnTerminaElaborazioneClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnAggiornaClick(Sender: TObject);
    procedure SelezionatuttoStoricoClick(Sender: TObject);
    procedure InvertiselezioneStoricoClick(Sender: TObject);
    procedure DeselezionatuttoStoricoClick(Sender: TObject);
    procedure Copia1Click(Sender: TObject);
    procedure CopiainExcel1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnAggiornaPdvStatusClick(Sender: TObject);
    procedure btnTerminaElaborazionePdvStatusClick(Sender: TObject);
    procedure chkEliminaFileClick(Sender: TObject);
    procedure btnSvuotaFiltroClick(Sender: TObject);
  private
    FStatoArchiviazione: TStatoArchiviazioneLarchive;
    procedure SetStatoArchiviazione(const Value: TStatoArchiviazioneLarchive);
    procedure PopolaCombobox;
    procedure AggiornaStatusBar;
    procedure AggiornaStatusBarPdvStatus;
    procedure AggiornaGUI;

    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    property StatoArchiviazione: TStatoArchiviazioneLarchive read FStatoArchiviazione write SetStatoArchiviazione;

    procedure ScriviStatusBar(S: String);
    procedure ScriviStatusBarPdvStatus(S: String);
    procedure ResettaProgressBar;
    procedure IncrementaProgressBar;
    procedure MaxProgressBar(i: Integer);

    procedure ResettaProgressBarPdvStatus;
    procedure IncrementaProgressBarPdvStatus;
    procedure MaxProgressBarPdvStatus(i: Integer);
  end;

var
  A220FArchiviazioneLArchive: TA220FArchiviazioneLArchive;

procedure OpenA220FArchiviazioneLarchive;

implementation

{$R *.dfm}

procedure OpenA220FArchiviazioneLArchive;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA220FArchiviazioneLArchive') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA220FArchiviazioneLarchive, A220FArchiviazioneLarchive);
  Application.CreateForm(TA220FArchiviazioneLarchiveDtM, A220FArchiviazioneLarchiveDtM);
  try
    A220FArchiviazioneLarchive.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A220FArchiviazioneLarchive.Free;
    A220FArchiviazioneLarchiveDtM.Free;
  end;
end;

{ TA220FArchiviazioneLarchive }

procedure TA220FArchiviazioneLArchive.FormCreate(Sender: TObject);
begin
  StatoArchiviazione:=saVuoto;
  btnTerminaElaborazionePdvStatus.Enabled:=False;
  btnAnomaliePdvStatus.Enabled:=False;

  if SolaLettura then
  begin
    btnAggiornaPdvStatus.Enabled:=False;
    PageControl.Pages[0].TabVisible:=False;
    PageControl.ActivePageIndex:=1;
  end
  else
    PageControl.ActivePageIndex:=0;

  frmInputPeriodo.FormatoData:=fdGiorno;
  frmInputPeriodo.DataFine:=Date;
  frmInputPeriodo.DataInizio:=Date - 30;
end;

procedure TA220FArchiviazioneLArchive.FormShow(Sender: TObject);
begin
  PopolaCombobox;
  CreaC004(SessioneOracle,'A220',Parametri.ProgOper);

  GetParametriFunzione;

  btnAggiornaClick(Self);
  chkEliminaFileClick(Self);
end;

procedure TA220FArchiviazioneLArchive.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  if StatoArchiviazione = saElabInCorso then
  begin
    Action:=caNone;
    Exit;
  end;

  if StatoArchiviazione = saDocCaricati then
    if (mrNo = MessageDlg('La lista di documenti caricati ma non trasmessi verrà persa, proseguire con la chiusura?', mtConfirmation, [mbYes, mbNo], 0)) then
    begin
      Action:=caNone;
      Exit;
    end;

  PutParametriFunzione;
  try C004FParamForm.Free; except end;
end;

procedure TA220FArchiviazioneLArchive.CaricaListaClick(Sender: TObject);
var ListaDocNonInseriti: TStringList;
begin
  if FileOpenDialogDir.Execute then
  begin
    ListaDocNonInseriti:=TStringList.Create;
    try
      Screen.Cursor:=crHourGlass;
      try
        A220FArchiviazioneLarchiveDtM.A220MW.CaricaListaDocumenti(FileOpenDialogDir.FileName, ListaDocNonInseriti);
      finally
        Screen.Cursor:=crDefault;
      end;

      if ListaDocNonInseriti.Count > 0 then
         R180MessageBox('N° ' + ListaDocNonInseriti.Count.ToString + ' documenti non sono stati inseriti in quanto già presenti in elenco', INFORMA, 'Inserimento documento');
    finally
      FreeAndNil(ListaDocNonInseriti);
    end;

    if A220FArchiviazioneLarchiveDtM.A220MW.cdsFileCaricati.RecordCount > 0 then
      StatoArchiviazione:=saDocCaricati;

    AggiornaStatusBar;
  end;
end;

procedure TA220FArchiviazioneLArchive.CaricaSingoloClick(Sender: TObject);
begin
  if FileOpenDialogFile.Execute then
  begin
    if not A220FArchiviazioneLarchiveDtM.A220MW.CaricaDocumento(FileOpenDialogFile.FileName) then
      R180MessageBox('Il documento selezionato non è stato inserito in quanto già presente in elenco', INFORMA, 'Inserimento documento');

    if A220FArchiviazioneLarchiveDtM.A220MW.cdsFileCaricati.RecordCount > 0 then
      StatoArchiviazione:=saDocCaricati;

    AggiornaStatusBar;
  end;
end;

procedure TA220FArchiviazioneLArchive.chkEliminaFileClick(Sender: TObject);
begin
  A220FArchiviazioneLarchiveDtM.A220MW.EliminaFile:=chkEliminaFile.Checked;
end;

procedure TA220FArchiviazioneLArchive.AggiornaStatusBar;
begin
  StatusBar.Panels[0].Text:='Documenti: ' + A220FArchiviazioneLarchiveDtM.A220MW.ListaDocumenti.Count.ToString;
  StatusBar.Panels[1].Text:='';
  StatusBar.Repaint;
end;

procedure TA220FArchiviazioneLArchive.AggiornaStatusBarPdvStatus;
begin
  StatusBarPdvStatus.Panels[0].Text:='Documenti: ' + A220FArchiviazioneLarchiveDtM.A220MW.selI220a.RecordCount.ToString;
  StatusBarPdvStatus.Panels[1].Text:='';
  StatusBarPdvStatus.Repaint;
end;

procedure TA220FArchiviazioneLArchive.btnSvuotaFiltroClick(Sender: TObject);
begin
  cmbPdvStatus.ItemIndex:=0;
  cmbTipoDocumento.ItemIndex:=0;
  edtDocUserId.Text:='';
  edtDocFileName.Text:='';
  edtId.Text:='';
  frmInputPeriodo.DataFine:=Date;
  frmInputPeriodo.DataInizio:=Date - 30;
end;

procedure TA220FArchiviazioneLArchive.btnAggiornaClick(Sender: TObject);
var LInizio, LFine: TDateTime;
    LId: Integer;
begin
  if Trim(edtId.Text) <> '' then
    if not TryStrToInt(Trim(edtId.Text), LId) then
    begin
      ShowMessage('Inserire un id trasmissione numerico');
      Exit;
    end;

  if (TryStrToDate(frmInputPeriodo.edtInizio.Text, LInizio) and
                         TryStrToDate(frmInputPeriodo.edtFine.Text, LFine)) then
  begin
    A220FArchiviazioneLarchiveDtM.A220MW.AggiornaFiltroStorico(Trunc(LInizio), Trunc(LFine)+1, edtDocUserId.Text, cmbPdvStatus.Text, cmbTipoDocumento.Text, edtDocFileName.Text, edtId.Text);
  end;

  AggiornaStatusBarPdvStatus;
end;

procedure TA220FArchiviazioneLArchive.btnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda, Parametri.Operatore, 'A220', '');
end;

procedure TA220FArchiviazioneLArchive.btnTerminaElaborazioneClick(Sender: TObject);
begin
  A220FArchiviazioneLarchiveDtM.A220MW.TerminaElaborazione:=True;
  StatoArchiviazione:=saElabArrestata;
end;

procedure TA220FArchiviazioneLArchive.btnTerminaElaborazionePdvStatusClick(Sender: TObject);
begin
  A220FArchiviazioneLarchiveDtM.A220MW.TerminaElaborazione:=True;
end;

procedure TA220FArchiviazioneLArchive.CancellaSingoloClick(Sender: TObject);
begin
  if (mrYes = MessageDlg('Rimuovere il documento selezionato dalla lista?', mtConfirmation, [mbYes, mbNo], 0)) then
    A220FArchiviazioneLarchiveDtM.A220MW.CancellaDocumento;

  if A220FArchiviazioneLarchiveDtM.A220MW.cdsFileCaricati.RecordCount = 0 then
    StatoArchiviazione:=saVuoto;

  AggiornaStatusBar;
end;

procedure TA220FArchiviazioneLArchive.ClearClick(Sender: TObject);
begin
  if (mrYes = MessageDlg('Rimuovere tutti i documenti presenti nella lista?', mtConfirmation, [mbYes, mbNo], 0)) then
    A220FArchiviazioneLarchiveDtM.A220MW.Clear;

  if A220FArchiviazioneLarchiveDtM.A220MW.cdsFileCaricati.RecordCount = 0 then
    StatoArchiviazione:=saVuoto;

  AggiornaStatusBar;
end;

procedure TA220FArchiviazioneLArchive.EseguiClick(Sender: TObject);
var LStopWatch: TStopwatch;
begin
  StatusBar.Panels[1].Text:='';

  if not A220FArchiviazioneLarchiveDtM.A220MW.ValidazioneTokenJWT then
  begin
    ShowMessage('Il token per l''autenticazione con il servizio di archiviazione è scaduto, è richiesto un aggiornamento della configurazione');
    Exit;
  end;

  if chkEliminaFile.Checked then
    if R180MessageBox('Procedere con la trasmissione dei documenti caricati e la successiva eliminazione se trasmessi con esito TRANSMITTED?', DOMANDA, 'Esegui') = mrNo then
      Exit;

  StatoArchiviazione:=saElabInCorso;

  LStopWatch:=TStopwatch.StartNew;
  StatusBar.Panels[1].Text:='Elaborazione in corso...';
  try
    A220FArchiviazioneLarchiveDtM.A220MW.InviaDocumenti;
  finally
    // stop timer
    LStopWatch.Stop;
    StatusBar.Panels[1].Text:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LStopWatch.ElapsedMilliseconds / MSecsPerDay);
    StatusBar.Repaint;
  end;

  if A220FArchiviazioneLarchiveDtM.A220MW.PresenzaAnomalie then
  begin
    btnAnomalie.Enabled:=True;
    if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS, DOMANDA, 'Anomalie') = mrYes then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA, INFORMA);

  PopolaCombobox;
  btnAggiornaClick(nil);
    
  StatoArchiviazione:=saElabTerminata;
end;

procedure TA220FArchiviazioneLArchive.SetStatoArchiviazione(const Value: TStatoArchiviazioneLarchive);
begin
  FStatoArchiviazione:=Value;
  AggiornaGUI;
end;

procedure TA220FArchiviazioneLArchive.btnAggiornaPdvStatusClick(Sender: TObject);
var LStopWatch: TStopwatch;
begin
  btnAggiornaPdvStatus.Enabled:=False;
  btnTerminaElaborazionePdvStatus.Enabled:=True;
  GroupBox1.Enabled:=False;
  dgrdStorico.Enabled:=False;

  LStopWatch:=TStopwatch.StartNew;
  StatusBarPdvStatus.Panels[1].Text:='Elaborazione in corso...';
  try
    A220FArchiviazioneLarchiveDtM.A220MW.AggiornaStatoDocumenti;
  finally
    // stop timer
    LStopWatch.Stop;
    StatusBarPdvStatus.Panels[1].Text:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LStopWatch.ElapsedMilliseconds / MSecsPerDay);
    StatusBarPdvStatus.Repaint;
    btnAggiornaPdvStatus.Enabled:=True;
    btnTerminaElaborazionePdvStatus.Enabled:=False;
    GroupBox1.Enabled:=True;
    dgrdStorico.Enabled:=True;
  end;

  if A220FArchiviazioneLarchiveDtM.A220MW.PresenzaAnomalie then
  begin
    btnAnomaliePdvStatus.Enabled:=True;
    if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS, DOMANDA, 'Anomalie') = mrYes then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA, INFORMA);

  PopolaCombobox;
end;

procedure TA220FArchiviazioneLArchive.PopolaCombobox;
begin
  with A220FArchiviazioneLarchiveDtM.A220MW.selI220b do
  begin
    cmbTipoDocumento.Clear;
    cmbTipoDocumento.AddItem('', nil);
    Close;
    Open;
    First;
    while not Eof do
    begin
      cmbTipoDocumento.AddItem(FieldByName('TIPO_DOCUMENTO').AsString, nil);
      Next;
    end;
  end;

  with A220FArchiviazioneLarchiveDtM.A220MW.selI220c do
  begin
    cmbPdvStatus.Clear;
    cmbPdvStatus.AddItem('', nil);
    Close;
    Open;
    First;
    while not Eof do
    begin
      cmbPdvStatus.AddItem(FieldByName('PDVSTATUS').AsString, nil);
      Next;
    end;
  end;
end;

procedure TA220FArchiviazioneLArchive.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;

  C004FParamForm.PutParametro('chkEliminaFile', IfThen(chkEliminaFile.Checked, 'S', 'N'));
  C004FParamForm.PutParametro('edtId', edtId.Text);
  C004FParamForm.PutParametro('edtDocUserId', edtDocUserId.Text);
  C004FParamForm.PutParametro('edtDocFileName', edtDocFileName.Text);
  C004FParamForm.PutParametro('edtInizio', frmInputPeriodo.edtInizio.Text);
  C004FParamForm.PutParametro('edtFine', frmInputPeriodo.edtFine.Text);
  C004FParamForm.PutParametro('cmbTipoDocumento', cmbTipoDocumento.Text);
  C004FParamForm.PutParametro('cmbPdvStatus', cmbPdvStatus.Text);

  try SessioneOracle.Commit; except end;
end;

procedure TA220FArchiviazioneLArchive.GetParametriFunzione;
var idx: Integer;
begin
  chkEliminaFile.Checked:=C004FParamForm.GetParametro('chkEliminaFile', 'N') = 'S';
  edtId.Text:=C004FParamForm.GetParametro('edtId', '');
  edtDocUserId.Text:=C004FParamForm.GetParametro('edtDocUserId', '');
  edtDocFileName.Text:=C004FParamForm.GetParametro('edtDocFileName', '');

  if (C004FParamForm.GetParametro('edtInizio', '  /  /    ') <> '  /  /    ')
      and (C004FParamForm.GetParametro('edtFine', '  /  /    ') <> '  /  /    ') then
  begin
    frmInputPeriodo.edtInizio.Text:=C004FParamForm.GetParametro('edtInizio', '  /  /    ');
    frmInputPeriodo.edtFine.Text:=C004FParamForm.GetParametro('edtFine', '  /  /    ');
  end;

  cmbPdvStatus.ItemIndex:=cmbPdvStatus.Items.IndexOf(C004FParamForm.GetParametro('cmbPdvStatus', ''));
  cmbTipoDocumento.ItemIndex:=cmbTipoDocumento.Items.IndexOf(C004FParamForm.GetParametro('cmbTipoDocumento', ''));
end;

//Macchina a stati per la gestione dello stato della GUI
procedure TA220FArchiviazioneLArchive.AggiornaGUI;
begin
  if FStatoArchiviazione = saVuoto then
  begin
    btnEsegui.Enabled:=False;
    btnChiudi.Enabled:=True;
    btnAnomalie.Enabled:=False;
    btnTerminaElaborazione.Enabled:=False;
    btnInsDocumento.Enabled:=True;
    btnInserisciListaDoc.Enabled:=True;
    btnCancellaDoc.Enabled:=False;
    btnClear.Enabled:=False;
    btnAggiornaPdvStatus.Enabled:=True;
    chkEliminaFile.Enabled:=True;
    ProgressBar.Position:=0;
  end
  else if FStatoArchiviazione = saDocCaricati then
  begin
    btnEsegui.Enabled:=True;
    btnChiudi.Enabled:=True;
    btnAnomalie.Enabled:=False;
    btnTerminaElaborazione.Enabled:=False;
    btnInsDocumento.Enabled:=True;
    btnInserisciListaDoc.Enabled:=True;
    btnCancellaDoc.Enabled:=True;
    btnAggiornaPdvStatus.Enabled:=True;
    btnClear.Enabled:=True;
    chkEliminaFile.Enabled:=True;
  end
  else if FStatoArchiviazione = saElabInCorso then
  begin
    btnEsegui.Enabled:=False;
    btnChiudi.Enabled:=False;
    btnAnomalie.Enabled:=False;
    btnTerminaElaborazione.Enabled:=True;
    btnInsDocumento.Enabled:=False;
    btnInserisciListaDoc.Enabled:=False;
    btnCancellaDoc.Enabled:=False;
    btnClear.Enabled:=False;
    btnAggiornaPdvStatus.Enabled:=False;
    chkEliminaFile.Enabled:=False;
  end
  else if (FStatoArchiviazione = saElabTerminata) or (FStatoArchiviazione = saElabArrestata)  then
  begin
    btnEsegui.Enabled:=False;
    btnChiudi.Enabled:=True;
    btnAnomalie.Enabled:=False;
    btnTerminaElaborazione.Enabled:=False;
    btnInsDocumento.Enabled:=False;
    btnInserisciListaDoc.Enabled:=False;
    btnCancellaDoc.Enabled:=False;
    btnClear.Enabled:=True;
    btnAggiornaPdvStatus.Enabled:=True;
    ProgressBar.Position:=0;
    chkEliminaFile.Enabled:=False;
  end;
end;

procedure TA220FArchiviazioneLArchive.InvertiselezioneStoricoClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdStorico, 'C');
end;

procedure TA220FArchiviazioneLArchive.SelezionatuttoStoricoClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdStorico, 'S');
end;

procedure TA220FArchiviazioneLArchive.DeselezionatuttoStoricoClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdStorico,'N');
end;

procedure TA220FArchiviazioneLArchive.Copia1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dgrdStorico,Sender = CopiaInExcel1, False);
end;

procedure TA220FArchiviazioneLArchive.CopiainExcel1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dgrdStorico,Sender = CopiaInExcel1, False);
end;

procedure TA220FArchiviazioneLArchive.ResettaProgressBar;
begin
  ProgressBar.Position:=0;
end;

procedure TA220FArchiviazioneLArchive.IncrementaProgressBar;
begin
  ProgressBar.StepIt;
  Application.ProcessMessages;
end;

procedure TA220FArchiviazioneLArchive.MaxProgressBar(i: Integer);
begin
  ProgressBar.Max:=i;
end;

procedure TA220FArchiviazioneLArchive.ScriviStatusBar(S: String);
begin
  StatusBar.Panels[0].Text:=S;
  StatusBar.Repaint;
end;

procedure TA220FArchiviazioneLArchive.ScriviStatusBarPdvStatus(S: String);
begin
  StatusBarPdvStatus.Panels[0].Text:=S;
  StatusBarPdvStatus.Repaint;
end;

procedure TA220FArchiviazioneLArchive.ResettaProgressBarPdvStatus;
begin
  ProgressBarPdvStatus.Position:=0;
end;

procedure TA220FArchiviazioneLArchive.IncrementaProgressBarPdvStatus;
begin
  ProgressBarPdvStatus.StepIt;
  Application.ProcessMessages;
end;

procedure TA220FArchiviazioneLArchive.MaxProgressBarPdvStatus(i: Integer);
begin
  ProgressBarPdvStatus.Max:=i;
end;

end.
