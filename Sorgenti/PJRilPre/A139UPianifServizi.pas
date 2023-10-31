unit A139UPianifServizi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids,
  DBGrids, ExtCtrls, StdCtrls, Spin, DBCtrls,
  ToolbarFiglio, Mask, Buttons, SelAnagrafe,
  A000UInterfaccia, A000UCostanti, A000USessione, A003UDataLavoroBis, A004UGiustifAssPres,
  A058UPianifTurni, A097UPianifLibProf, C004UParamForm,
  C012UVisualizzaTesto, C180FunzioniGenerali, C700USelezioneAnagrafe, Rp502Pro,
  BaseGrid, AdvGrid, DBAdvGrid, OracleData, Math;

const DURATA_TURNO = 420;


type
  TCartaServizi = record
    Ufficio,Note,Note2,FirmaSx,FirmaDx:String;
  end;

  TA139FPianifServizi = class(TR001FGestTab)
    PnlTop: TPanel;
    PnlCenter: TPanel;
    PnlBottom: TPanel;
    PnlDescrizioni: TPanel;
    grpNoteServizi: TGroupBox;
    grpNote: TGroupBox;
    DBMemoNoteServizio: TDBMemo;
    DBMemoNote: TDBMemo;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    PopupMenu1: TPopupMenu;
    InsCancgiustificativi1: TMenuItem;
    actRegistra1: TMenuItem;
    RegistraTutto1: TMenuItem;
    N6: TMenuItem;
    urnistraordinari1: TMenuItem;
    N4: TMenuItem;
    RegistraT5201: TMenuItem;
    actVisualizzaT5201: TMenuItem;
    Cancella2: TMenuItem;
    ActionList3: TActionList;
    actRegistraPattuglia: TAction;
    actRegistraServizio: TAction;
    actRegistraT520: TAction;
    actVisualizzaT520: TAction;
    actCancellapianificazionecorrente: TAction;
    actOpenA004: TAction;
    actOpenA097: TAction;
    GridServizi: TDBAdvGrid;
    Splitter3: TSplitter;
    lblTipoGiorno1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    edtDatada: TMaskEdit;
    edtDataa: TMaskEdit;
    lblTipoGiorno2: TLabel;
    grpAssentiNonGiustificati: TGroupBox;
    grpAssentiGiustificati: TGroupBox;
    dgrdAssentiGiustificati: TDBGrid;
    dgrdAssentiNonGiustificati: TDBGrid;
    ImageListA139: TImageList;
    ToolBar1: TToolBar;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    BtnAnomalie: TSpeedButton;
    ToolButton11: TToolButton;
    btnServiziComandati: TSpeedButton;
    Panel2: TPanel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    ToolButton2: TToolButton;
    ToolButton12: TToolButton;
    ToolButton15: TToolButton;
    chkColonneAutoDimensionate: TCheckBox;
    chkTTurno: TCheckBox;
    DBCmbTTurno: TDBLookupComboBox;
    chkServizio: TCheckBox;
    DBCmbServizio: TDBLookupComboBox;
    actChiudiPattuglia: TAction;
    actChiudiServizio: TAction;
    actSbloccaPattuglia: TAction;
    ToolButton17: TToolButton;
    N5: TMenuItem;
    Registrasingolapattuglia1: TMenuItem;
    Sbloccasingolapattuglia1: TMenuItem;
    Chiudituttoilservizio1: TMenuItem;
    chkOrdinamento: TCheckBox;
    actRinumera: TAction;
    N7: TMenuItem;
    Rinumerapattuglie1: TMenuItem;
    actDuplicaRiga: TAction;
    Duplicariga1: TMenuItem;
    ToolButton18: TToolButton;
    actApriNote: TAction;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton7: TToolButton;
    actShowQuadroRiass: TAction;
    actShowQuadroRiass1: TMenuItem;
    actSaltoPagina: TAction;
    actSaltoPagina1: TMenuItem;
    actInsCommento: TAction;
    Commento1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure chkTTurnoClick(Sender: TObject);
    procedure chkServizioClick(Sender: TObject);
    procedure PnlDescrizioniResize(Sender: TObject);
    procedure Registralapianificazionedelserviziocorrentecomemodello1Click(
      Sender: TObject);
    procedure Utilizzamodelliesistenti1Click(Sender: TObject);
    procedure actRegistraT520Execute(Sender: TObject);
    procedure actVisualizzaT520Execute(Sender: TObject);
    procedure btnServiziComandatiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actRegistraPattugliaExecute(Sender: TObject);
    procedure actRegistraServizioExecute(Sender: TObject);
    procedure actCancellapianificazionecorrenteExecute(Sender: TObject);
    procedure actOpenA058Execute(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridServiziGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GridServiziDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure GridServiziRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure TGommaClick(Sender: TObject);
    procedure GridServiziClick(Sender: TObject);
    procedure GridServiziGetRecordCount(Sender: TObject; var Count: Integer);
    procedure GridServiziCanAddRow(Sender: TObject; var CanAdd: Boolean);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure GridServiziCanInsertRow(Sender: TObject; ARow: Integer;
      var CanInsert: Boolean);
    procedure TInserClick(Sender: TObject);
    procedure BtnAnomalieClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
    procedure actOpenA097Execute(Sender: TObject);
    procedure actOpenA004Execute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure edtDatadaExit(Sender: TObject);
    procedure edtDatadaKeyPress(Sender: TObject; var Key: Char);
    procedure edtDataaDblClick(Sender: TObject);
    procedure chkColonneAutoDimensionateClick(Sender: TObject);
    procedure dgrdAssentiGiustificatiDblClick(Sender: TObject);
    procedure actChiudiPattugliaExecute(Sender: TObject);
    procedure actSbloccaPattugliaExecute(Sender: TObject);
    procedure actChiudiServizioExecute(Sender: TObject);
    procedure chkOrdinamentoClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure actRinumeraExecute(Sender: TObject);
    procedure actDuplicaRigaExecute(Sender: TObject);
    procedure actApriNoteExecute(Sender: TObject);
    procedure GridServiziOleDrop(Sender: TObject; ARow, ACol: Integer;
      data: string; var Allow: Boolean);
    procedure actShowQuadroRiassExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actSaltoPaginaExecute(Sender: TObject);
    procedure actInsCommentoExecute(Sender: TObject);
  private
    { Private declarations }
    AccessoA058,AccessoA097:Boolean;
    LarghezzeColonne: array of Integer;
    CartaServizi:TCartaServizi;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AbilitaDragDrop;
    procedure HideColonna(Nome:String;Val:Boolean);
    function GetColGrid(InCol:Integer):Integer;
    procedure OpenA139CopiaServizi(Az:String);
  public
    { Public declarations }
    AccessoA004:Boolean;
    Ordinamento:String;
    ProgSelezionato:Integer;
    function GetTipoGiorno(D:TDateTime):String;    
    function DataElab:TDateTime;
  end;

var
  A139FPianifServizi: TA139FPianifServizi;

  procedure OpenA139PianifServizi;

implementation

uses A139UPianifServiziDtm, A139UCopiaServizi, A139UGestisciPattuglie, A139UStampaServizi,
     A139UGestisciApparati, A139UDialogStampa, A139UNoteServizi, A139UQuadroRiass;

{$R *.dfm}

procedure OpenA139PianifServizi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA139PianifServizi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A139FPianifServizi:=TA139FPianifServizi.Create(nil);
  try
    A139FPianifServiziDtm:=TA139FPianifServiziDtm.Create(nil);
    A139FPianifServizi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A139FPianifServiziDtm.Free;
    A139FPianifServizi.Release;
  end;
end;

procedure TA139FPianifServizi.AbilitaDragDrop;
begin
  GridServizi.DragDropSettings.OleDropSource:=Not chkOrdinamento.Checked;
  GridServizi.DragDropSettings.OleDropTarget:=Not chkOrdinamento.Checked;
end;

procedure TA139FPianifServizi.FormCreate(Sender: TObject);
var AccessoA139:Boolean;
begin
  inherited;
  AccessoA139:=SolaLettura;
  AccessoA004:=A000GetInibizioni('Funzione','OpenA004GiustifAssPres') = 'S';
  AccessoA058:=A000GetInibizioni('Funzione','OpenA058PianifTurni') <> 'N';
  AccessoA097:=A000GetInibizioni('Funzione','OpenA097PianifLibProf') <> 'N';
  SolaLettura:=AccessoA139;
  btnAnomalie.Enabled:=False;
end;

procedure TA139FPianifServizi.FormShow(Sender: TObject);
var i:Integer;
begin
  inherited;
  DButton.DataSet:=A139FPianifServiziDtm.selT500;
  C700DatiVisualizzati:='';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  //frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle, StatusBar,2,False);
  frmSelAnagrafe.NumRecords;
  C700MergeSelAnagrafe(A139FPianifServiziDtm.selTotAnag,False);
  C700MergeSelAnagrafe(A139FPianifServiziDtm.selT040,False);
  C700MergeSelAnagrafe(A139FPianifServiziDtm.selAssenti,False);
  CreaC004(SessioneOracle,'A139',Parametri.ProgOper);

  actChiudiServizio.Enabled:=Parametri.A139_ServiziBlocco = 'S';
  btnServiziComandati.Enabled:=Parametri.A139_ServiziComandati = 'T'; //T=Tutti - C= solo Comandati - N = solo Non comandati
  btnServiziComandati.Down:=Parametri.A139_ServiziComandati = 'C';
  btnServiziComandatiClick(nil);
  HideColonna('COMANDATO',False);
  HideColonna('CAUSALE',False);
  HideColonna('TIPO_TURNO',False);
  //HideColonna('STATO',False);
  AbilitaDragDrop;
//========================
//SETTO FONT COLONNE A BLU
//========================
  for i:=0 to GridServizi.Columns.Count - 1 do
    GridServizi.Columns[i].HeaderFont.Color:=clBlue;

  with A139FPianifServiziDtm do
  begin
    ParametriPianServiziRaggr1:=Parametri.CampiRiferimento.C22_PianServLiv1;
    ParametriPianServiziRaggr2:=Parametri.CampiRiferimento.C22_PianServLiv2;
    EnabledT500:=False;
    GetParametriFunzione;
    EnabledT500:=True;
    AggDati(DataElab,False);
    OpenT500;
    OpenT500Aperti;
  end;
  GridServizi.Navigation.AppendOnArrowDown:=C700SelAnagrafe.RecordCount > 0;
end;

procedure TA139FPianifServizi.OpenA139CopiaServizi(Az:String);
begin
  A139FCopiaServizi:=TA139FCopiaServizi.Create(nil);
  try
    A139FCopiaServizi.Azione:=Az;
    A139FCopiaServizi.ShowModal;
  finally
    FreeAndNil(A139FCopiaServizi);
  end;
end;

function TA139FPianifServizi.DataElab:TDateTime;
begin
  with A139FPianifServizi do
    try
      Result:=StrToDate(edtDataA.Text);
    except
      Result:=Parametri.DataLavoro;
    end;
end;

procedure TA139FPianifServizi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  chkOrdinamento.Enabled:=DButton.State = dsBrowse;
  actOpenA004.Enabled:=DButton.State = dsBrowse;
  actOpenA097.Enabled:=DButton.State = dsBrowse;
  actRegistraPattuglia.Enabled:=DButton.State = dsBrowse;
  actRinumera.Enabled:=(DButton.State = dsBrowse) and (not chkOrdinamento.Checked);
  actRegistraT520.Enabled:=DButton.State = dsBrowse;
  actCancellapianificazionecorrente.Enabled:=DButton.State = dsBrowse;
  actRegistraServizio.Enabled:=False;
end;

procedure TA139FPianifServizi.frmSelAnagrafebtnEreditaSelezioneClick(
  Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnEreditaSelezioneClick(nil);
  GridServizi.Navigation.AppendOnArrowDown:=C700SelAnagrafe.RecordCount > 0;
  with A139FPianifServiziDtm do
  begin
    AggDati(DataElab,False);
    C700MergeSelAnagrafe(selTotAnag,False);
    C700MergeSelAnagrafe(selT040,False);
    C700MergeSelAnagrafe(selAssenti,False);
    selTotAnag.Close;
    selT040.Close;
    selAssenti.Close;
    A139FPianifServizi.grpAssentiGiustificati.Caption:='Assenti giustificati';
    A139FPianifServizi.grpAssentiNonGiustificati.Caption:='Assenti non giustificati';
    OpenT500;
    OpenT500Aperti;
  end;
end;

procedure TA139FPianifServizi.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  with A139FPianifServiziDtm do
  begin
    C700DataLavoro:=DataElab;
    frmSelAnagrafe.btnSelezioneClick(nil);
    if frmSelAnagrafe.C700ModalResult <> mrOK then
      exit;
    AggDati(DataElab,False);
    C700MergeSelAnagrafe(selTotAnag,False);
    C700MergeSelAnagrafe(selT040,False);
    C700MergeSelAnagrafe(selAssenti,False);
    selTotAnag.Close;
    selT040.Close;
    selAssenti.Close;
    A139FPianifServizi.grpAssentiGiustificati.Caption:='Assenti giustificati';
    A139FPianifServizi.grpAssentiNonGiustificati.Caption:='Assenti non giustificati';
    GridServizi.Navigation.AppendOnArrowDown:=C700SelAnagrafe.RecordCount > 0;
    OpenT500;
    OpenT500Aperti;
  end;
end;

procedure TA139FPianifServizi.GridServiziCanAddRow(Sender: TObject;
  var CanAdd: Boolean);
begin
  inherited;
  CanAdd:=C700SelAnagrafe.RecordCount > 0;
end;

procedure TA139FPianifServizi.GridServiziCanInsertRow(Sender: TObject;
  ARow: Integer; var CanInsert: Boolean);
begin
  inherited;
  CanInsert:=C700SelAnagrafe.RecordCount > 0;
end;

procedure TA139FPianifServizi.TInserClick(Sender: TObject);
begin
  if C700SelAnagrafe.RecordCount = 0 then
    exit;
  inherited;
end;

procedure TA139FPianifServizi.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  if chkTTurno.Checked then
    C004FParamForm.PutParametro('CHKTIPOTURNO','S')
  else
    C004FParamForm.PutParametro('CHKTIPOTURNO','N');
  if chkServizio.Checked then
    C004FParamForm.PutParametro('CHKSERVIZIO','S')
  else
    C004FParamForm.PutParametro('CHKSERVIZIO','N');
  if chkOrdinamento.Checked then                
    C004FParamForm.PutParametro('CHKORDINAMENTO','S')
  else
    C004FParamForm.PutParametro('CHKORDINAMENTO','N');
  C004FParamForm.PutParametro('DATA1',edtDataDa.Text);
  C004FParamForm.PutParametro('DATA2',edtDataA.Text);
  C004FParamForm.PutParametro('TIPO_TURNO',VarToStr(DBcmbTTurno.KeyValue));
  C004FParamForm.PutParametro('SERVIZIO',VarToStr(dbCmbServizio.KeyValue));
  C004FParamForm.PutParametro('CS_UFFICIO',CartaServizi.Ufficio);
  C004FParamForm.PutParametro('CS_NOTE',CartaServizi.Note);
  C004FParamForm.PutParametro('CS_NOTE2',CartaServizi.Note2);
  C004FParamForm.PutParametro('CS_FIRMASX',CartaServizi.FirmaSx);
  C004FParamForm.PutParametro('CS_FIRMADX',CartaServizi.FirmaDx);
  SessioneOracle.Commit;
end;

procedure TA139FPianifServizi.GetParametriFunzione;
begin
  chkTTurno.Checked:=C004FParamForm.GetParametro('CHKTIPOTURNO','S') = 'S';
  chkServizio.Checked:=C004FParamForm.GetParametro('CHKSERVIZIO','N') = 'S';
  chkOrdinamento.Checked:=C004FParamForm.GetParametro('CHKORDINAMENTO','S') = 'S';
  edtDataDa.Text:=C004FParamForm.GetParametro('DATA1',DateToStr(Parametri.DataLavoro));
  edtDataA.Text:=C004FParamForm.GetParametro('DATA2',edtDataDa.Text);
  try edtDatadaExit(edtDatada); except end;
  try lblTipoGiorno2.Caption:=GetTipoGiorno(StrToDate(edtDataA.Text)); except end;
  DBcmbTTurno.KeyValue:=C004FParamForm.GetParametro('TIPO_TURNO','-1');
  dbCmbServizio.DataSource.DataSet.Edit;
  dbCmbServizio.DataSource.DataSet.FieldByName('CODICE').AsString:=C004FParamForm.GetParametro('SERVIZIO','');
  CartaServizi.Ufficio:=C004FParamForm.GetParametro('CS_UFFICIO','');
  CartaServizi.Note:=C004FParamForm.GetParametro('CS_NOTE','');
  CartaServizi.Note2:=C004FParamForm.GetParametro('CS_NOTE2','');
  CartaServizi.FirmaSx:=C004FParamForm.GetParametro('CS_FIRMASX','');
  CartaServizi.FirmaDx:=C004FParamForm.GetParametro('CS_FIRMADX','');
end;

procedure TA139FPianifServizi.HideColonna(Nome:String;Val:Boolean);
begin
  if Not Val then
    GridServizi.HideColumn(GridServizi.ColumnByFieldName[Nome].Index)
  else
    GridServizi.UnHideColumn(GridServizi.ColumnByFieldName[Nome].Index);
end;

procedure TA139FPianifServizi.actApriNoteExecute(Sender: TObject);

begin
  try
    StrToDate(edtDataa.Text)
  except
    R180MessageBox('Impossibile aprire le note valore campo "Alla data" errato.','ERRORE');
    Exit;
  end;
  inherited;
  A139FNoteServizi:=TA139FNoteServizi.Create(nil);
  try
    A139FNoteServizi.ShowModal;
  finally
    FreeAndNil(A139FNoteServizi);
  end;
end;

procedure TA139FPianifServizi.actCancellapianificazionecorrenteExecute(
  Sender: TObject);
var CodTipo, Msg:String;
begin
  inherited;
  with A139FPianifServiziDtm do
  begin
    Msg:='Attenzione!' + #13#10;
    Msg:=Msg + 'Verranno cancellate le pianificazioni del turno ' + selT500.FieldByName('DESCTTURNO').AsString + ' del ' + selT500.FieldByName('DATA').AsString;
    Msg:=Msg + #13#10;
    Msg:=Msg + 'non ancora assegnate a nessun dipendente.' + #13#10 + 'Confermare?''';
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Exit;
    try
      Screen.Cursor:=crHourGlass;
      selT500.DisableControls;
      CodTipo:=selT500.FieldByName('TIPO_TURNO').AsString;
      OpenT500(selT500.FieldByName('DATA').AsDateTime);
      SelT500.First;
      while not SelT500.Eof do
      begin
        if (selT500.FieldByName('TIPO_TURNO').AsString = CodTipo) then
        begin
          selCountT502.SetVariable('PATTUGLIA',selT500.FieldByName('PATTUGLIA').AsInteger);
          selCountT502.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
          selCountT502.Execute;
          if selCountT502.FieldAsInteger(0) = 0 then
          begin
            selT500.Delete;
            Continue;
          end;
        end;
        selT500.Next;
      end;
      OpenT500;
      selT500.EnableControls;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TA139FPianifServizi.actChiudiPattugliaExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg('Attenzione!' + #13#10 + 'Dopo la chiusura non sarà più possibile modificare questa pianificazione.' + #13#10 + 'Continuare?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    with A139FPianifServiziDtM.selT500 do
    begin
      Edit;
      FieldByName('STATO').AsString:='C';
      Post;
    end;
end;

procedure TA139FPianifServizi.actChiudiServizioExecute(Sender: TObject);
var RID:String;
begin
  inherited;
  if MessageDlg('Attenzione!' + #13#10 + 'Dopo la chiusura non sarà più possibile modificare queste pianificazioni.' + #13#10 + 'Continuare?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    with A139FPianifServiziDtM.selT500 do
    try
      DisableControls;
      AfterScroll:=nil;
      AfterPost:=nil;
      RID:=RowID;
      First;
      while not Eof do
      begin
        if FieldByName('STATO').AsString = 'A' then
          if ((FieldByName('COMANDATO').AsString = 'S') and (btnServiziComandati.Down)) or
             ((FieldByName('COMANDATO').AsString = 'N') and (not btnServiziComandati.Down)) then
          begin
            Edit;
            FieldByName('STATO').AsString:='C';
            Post;
          end;
        Next;
      end;
      SearchRecord('ROWID',RID,[srFromBeginning]);
    finally
      EnableControls;
      AfterPost:=A139FPianifServiziDtM.AfterPost;
      AfterScroll:=A139FPianifServiziDtM.selT500AfterScroll;
      A139FPianifServiziDtM.selT500AfterScroll(nil);
    end;
end;

procedure TA139FPianifServizi.actDuplicaRigaExecute(Sender: TObject);
begin
  inherited;
  A139FPianifServiziDtM.DuplicaRecordCorrente;
  GridServizi.AutoSizeRow(GridServizi.Row);
end;

procedure TA139FPianifServizi.actInsCommentoExecute(Sender: TObject);
var Val:String;
begin
  inherited;
  if btnServiziComandati.Down then
    Val:='01C'
  else
    Val:='01N';
  with A139FPianifServiziDtm do
    //if selT545.SearchRecord('CODICE',Val,[srFromBeginning]) then
    begin
    //  DBCmbTTurno.KeyValue:=selT545.FieldByName('CODICE').AsString;
      selT500.Insert;
      selT500.FieldByName('TIPO_TURNO').AsString:=Val;
      selT500.FieldByName('DALLE').AsString:='00.00';
      selT500.FieldByName('ALLE').AsString:='00.00';
      //selT500.Post;
    end;
    //else
    //  R180MessageBox('Record "commento" assente sulla tabella T545.','ERRORE');
end;

procedure TA139FPianifServizi.actOpenA004Execute(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  try
    with A139FPianifServiziDtM do
    begin
      OpenA004daA139(selT500.FieldByName('PROGRESSIVI').AsString,selT500.FieldByName('DATA').AsString,'','','','',0,False);
      (*if selT040.Active then
        selT040.Refresh;*)
    end;
  finally
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe;
  end;
end;

procedure TA139FPianifServizi.actOpenA058Execute(Sender: TObject);
var Dal,Al:TDateTime;
begin
  inherited;
  Dal:=R180InizioMese(StrToDate(edtDataDa.Text));
  Al:=R180FineMese(StrToDate(edtDataA.Text));
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  try
    with A139FPianifServiziDtM do
      OpenA058VisualizzaTabellone(selT500.FieldByName('PROGRESSIVI').AsString,Dal,Al);
      //OpenA058VisualizzaTabellone('',Dal,Al);
  finally
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe;
  end;
end;

procedure TA139FPianifServizi.actOpenA097Execute(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  try
    with A139FPianifServiziDtM do
      OpenA097PianifLibProf(StrToIntDef(selT500.FieldByName('PROGRESSIVI').AsString,0),StrToDate(edtDataDa.Text));//(selT500.FieldByName('PROGRESSIVO').AsInteger,selT500.FieldByName('DATA').AsString,'','','','',0,False);
  finally
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe;
  end;
end;

procedure TA139FPianifServizi.actRefreshExecute(Sender: TObject);
begin
  inherited;
  with A139FPianifServiziDtM do
  try
    selT500.AfterScroll:=nil;
    gridServizi.AutoSizeRows(False,2);
    if chkColonneAutoDimensionate.Checked then
      gridServizi.AutoSizeColumns(False,0);
  finally
    selT500.AfterScroll:=selT500AfterScroll;
  end;
end;

procedure TA139FPianifServizi.actRegistraT520Execute(Sender: TObject);
begin
  inherited;
  OpenA139CopiaServizi('I');
end;

procedure TA139FPianifServizi.actRinumeraExecute(Sender: TObject);
begin
  inherited;
  A139FPianifServiziDtM.RinumeraT500;
end;

procedure TA139FPianifServizi.actSaltoPaginaExecute(Sender: TObject);
var Val:String;
begin
  inherited;
  with A139FPianifServiziDtm do
  begin
    if btnServiziComandati.Down then
      Val:='00C'
    else
      Val:='00N';
    //if selT545.SearchRecord('CODICE',Val,[srFromBeginning]) then
    //begin
    //  DBCmbTTurno.KeyValue:=selT545.FieldByName('CODICE').AsString;
      selT500.Insert;
      selT500.FieldByName('TIPO_TURNO').AsString:=Val;
      selT500.FieldByName('DALLE').AsString:='00.00';
      selT500.FieldByName('ALLE').AsString:='00.00';
      //selT500.Post;
    //end
    //else
    //  R180MessageBox('Record "salto pagina" assente sulla tabella T545.','ERRORE');
  end;
end;

procedure TA139FPianifServizi.actSbloccaPattugliaExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg('Confermare lo sblocco di questa pianificazione?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    with A139FPianifServiziDtM.selT500 do
    begin
      BeforeEdit:=nil;
      Edit;
      FieldByName('STATO').AsString:='A';
      Post;
      BeforeEdit:=A139FPianifServiziDtM.selT500BeforeEdit;
    end;
end;

procedure TA139FPianifServizi.actShowQuadroRiassExecute(Sender: TObject);
begin
  inherited;
  if C700SelAnagrafe.RecordCount <= 0 then
    Exit;  
  A139FQuadroRiass:=TA139FQuadroRiass.Create(nil);
  try
    A139FQuadroRiass.Show;
  except
    FreeAndNil(A139FQuadroRiass);
  end;
end;

procedure TA139FPianifServizi.actRegistraPattugliaExecute(Sender: TObject);
begin
  inherited;
  if R180MessageBox('Controllare questa pattuglia?',DOMANDA) <> mrYes then
    exit;
  with A139FPianifServiziDtm do
  begin
    StrError.Clear;
    R502DtM:=TR502ProDtM1.Create(nil);
    try
      R502DtM.PeriodoConteggi(selT500.FieldByName('DATA').AsDateTime,selT500.FieldByName('DATA').AsDateTime);
      if RegistraPattuglia then
        R180MessageBox('Pattuglia controllata correttamente','INFORMA')
      else
        R180MessageBox('Errore nel controllo della pattuglia.!','ERRORE');
    finally
      FreeAndNil(R502DtM);
    end;
    btnAnomalie.Enabled:=StrError.Count > 0;
  end;
end;

procedure TA139FPianifServizi.actRegistraServizioExecute(Sender: TObject);
var RID:String;
begin
  inherited;
  if R180MessageBox('Controllare tutto il servizio?',DOMANDA) <> mrYes then
    exit;
  with A139FPianifServiziDtm do
  begin
    R502DtM:=TR502ProDtM1.Create(nil);
    selT500.DisableControls;
    selT500.AfterScroll:=nil;
    RID:=selT500.RowID;
    try
      R502DtM.PeriodoConteggi(StrToDate(edtDataDa.Text),StrToDate(edtDataA.Text));
      StrError.Clear;
      selT500.First;
      while not selT500.Eof do
      begin
        RegistraPattuglia;
        selT500.Next;
      end;
      selT500.SearchRecord('ROWID',RID,[srFromBeginning]);
      //Assenti non giustificati
      selAssenti.DisableControls;
      try
        OpenAssenti(False,True);
        if selAssenti.RecordCount > 0 then
        begin
          StrError.Add('Assenti non giustificati:');
          while not SelAssenti.Eof do
          begin
            StrError.Add(Format('  %s(%s)',[selAssenti.FieldByName('NOMINATIVO').AsString,selAssenti.FieldByName('MATRICOLA').AsString]));
            SelAssenti.Next;
          end;
        end;
        selAssenti.Close;
      finally
        selAssenti.EnableControls;
      end;
      if StrError.Count > 0 then
        R180MessageBox('Controllo effettuato. Sono state riscontrate delle anomalie.','INFORMA')
      else
        R180MessageBox('Controllo effettuato.','INFORMA')
    finally
      FreeAndNil(R502DtM);
      selT500.EnableControls;
      selT500.AfterScroll:=selT500AfterScroll;
      selT500AfterScroll(nil);
    end;
    btnAnomalie.Enabled:=StrError.Count > 0;
  end;
end;

procedure TA139FPianifServizi.actVisualizzaT520Execute(Sender: TObject);
begin
  inherited;
  OpenA139CopiaServizi('M');
end;

procedure TA139FPianifServizi.BtnAnomalieClick(Sender: TObject);
begin
  inherited;
  if A139FPianifServiziDtm.StrError.Count > 0 then
    OpenC012VisualizzaTesto('<A139> Pianificazione servizi','',A139FPianifServiziDtm.StrError,'');
end;

procedure TA139FPianifServizi.btnServiziComandatiClick(Sender: TObject);
begin
  inherited;
  if btnServiziComandati.Down then
  begin
    Ordinamento:='ORDINE_CMD';
    btnServiziComandati.Caption:='Servizi comandati';
    btnServiziComandati.Font.Style:=[fsBold];
    A139FPianifServiziDtm.BloccaCampi(not btnServiziComandati.Down,'');
  end
  else
  begin
    Ordinamento:='ORDINE';
    btnServiziComandati.Caption:='Servizi normali';
    btnServiziComandati.Font.Style:=[];
    A139FPianifServiziDtm.BloccaCampi(not btnServiziComandati.Down,'NOTE,ORDINE');
  end;
  
  if chkOrdinamento.Checked then
  begin
    GridServizi.Columns[1].FieldName:='';
    GridServizi.Columns[1].Width:=0;
  end
  else
  begin
    GridServizi.Columns[1].FieldName:=Ordinamento;
    GridServizi.Columns[1].Width:=28;
  end;
  with A139FPianifServiziDtm do
  begin
    selT545.Filtered:=False;
    selT545.Filtered:=True;

    OpenT500;
    OpenT540;
  end;
end;

procedure TA139FPianifServizi.chkOrdinamentoClick(Sender: TObject);
begin
  inherited;
  if chkOrdinamento.Checked then
  begin
    GridServizi.Columns[1].FieldName:='';
    GridServizi.Columns[1].Width:=0;
  end
  else
  begin
    GridServizi.Columns[1].FieldName:=Ordinamento;
    GridServizi.Columns[1].Width:=28;
  end;
  AbilitaDragDrop;  
  A139FPianifServiziDtm.OpenT500;
  actRinumera.Enabled:=(DButton.State = dsBrowse) and (not chkOrdinamento.Checked);
end;

procedure TA139FPianifServizi.edtDataaDblClick(Sender: TObject);
begin
  inherited;
  edtDataa.Text:=edtDatada.Text;
  edtDatadaExit(Sender);
end;

procedure TA139FPianifServizi.edtDatadaExit(Sender: TObject);
begin
  inherited;
  if Sender = edtDataDa then
  begin
    lblTipoGiorno1.Caption:=GetTipoGiorno(StrToDate(edtDataDa.Text));
    if StrToDate(edtDataDa.Text) > StrToDate(edtDataA.Text) then
      edtDataA.Text:=edtDataDa.Text;
  end
  else
  begin
    lblTipoGiorno2.Caption:=GetTipoGiorno(StrToDate(edtDataA.Text));
    if StrToDate(edtDataDa.Text) > StrToDate(edtDataA.Text) then
      edtDataDa.Text:=edtDataA.Text;
  end;
  A139FPianifServiziDtm.AggDati(StrToDate(edtDataA.Text),False);
  if edtDataDa.Text = edtDataA.Text then
  begin
    GridServizi.Columns[2].FieldName:='';
    GridServizi.Columns[2].Width:=0;
  end
  else
  begin
    GridServizi.Columns[2].FieldName:='DATA';
    GridServizi.Columns[2].Width:=60;
  end;
  with A139FPianifServiziDtm do
    if (selT500.GetVariable('DATA1') <> StrToDate(edtDataDa.Text)) or
       (selT500.GetVariable('DATA2') <> StrToDate(edtDataA.Text)) then
    begin
      OpenT500;
      OpenT500Aperti;
    end;
end;

procedure TA139FPianifServizi.edtDatadaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtDatadaExit(Sender);
end;

procedure TA139FPianifServizi.chkTTurnoClick(Sender: TObject);
begin
  inherited;
  //HideColonna('CodTTurno',Not ChkTTurno.Checked);
  if ChkTTurno.Checked then
  begin
    GridServizi.Columns[11].FieldName:='';
    GridServizi.Columns[11].Width:=0;
  end
  else
  begin
    GridServizi.Columns[11].FieldName:='DescTTurno';
    GridServizi.Columns[11].Width:=60;
  end;
  with A139FPianifServiziDtm do
  begin
    if (ChkTTurno.Checked) and (Not selT500.FieldByName('TIPO_TURNO').IsNull) then
      DBCmbTTurno.KeyValue:=selT500.FieldByName('TIPO_TURNO').AsString;
    OpenT500;
  end;
  actRinumera.Enabled:=(DButton.State = dsBrowse) and (not chkOrdinamento.Checked);
end;

procedure TA139FPianifServizi.chkServizioClick(Sender: TObject);
begin
  inherited;
  //HideColonna('DescServizio',Not chkServizio.Checked);
  if chkServizio.Checked then
  begin
    GridServizi.Columns[12].FieldName:='';
    GridServizi.Columns[12].Width:=0;
  end
  else
  begin
    GridServizi.Columns[12].FieldName:='DescServizio';
    GridServizi.Columns[12].Width:=100;
  end;
  with A139FPianifServiziDtm do
  begin
    if (chkServizio.Checked) and (Not selT500.FieldByName('SERVIZIO').IsNull) then
      DBCmbServizio.KeyValue:=selT500.FieldByName('SERVIZIO').AsString;
    OpenT500;
  end;
end;

procedure TA139FPianifServizi.chkColonneAutoDimensionateClick(Sender: TObject);
var i:Integer;
begin
  inherited;
  if chkColonneAutoDimensionate.Checked then
  begin
    SetLength(LarghezzeColonne,gridServizi.ColCount);
    for i:=0 to gridServizi.ColCount - 1 do
      LarghezzeColonne[i]:=gridServizi.Columns[i].Width;
    gridServizi.AutoSizeColumns(False,0);
  end
  else
  begin
    for i:=0 to gridServizi.ColCount - 1 do
      gridServizi.Columns[i].Width:=LarghezzeColonne[i];
  end
end;

function TA139FPianifServizi.GetColGrid(InCol:Integer):Integer;
var Ret, i, c:Integer;
begin
  Ret:=-1;
  c:=0;
  for i:=1 to GridServizi.Columns.count - 1 do
  begin
    if not GridServizi.IsHiddenColumn(i) then
      inc(c);
    if c = InCol then
    begin
      Ret:=i;
      Break;
    end;
  end;
  Result:=Ret;
end;

procedure TA139FPianifServizi.GridServiziClick(Sender: TObject);
begin
  inherited;
  NumRecords;
end;

procedure TA139FPianifServizi.GridServiziDblClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  inherited;
  if (ARow <= 0) or (ACol <= 0) then
    exit;
  GridServizi.AutoSizeRow(ARow);
  with A139FPianifServiziDtm do
  begin
    if selT500.FieldByName('STATO').AsString = 'C' then
      exit;
    if (selT500.RecordCount > 0) and
       ((GridServizi.Columns[GetColGrid(ACol)].Field = selT500C_CAMPO1) or
        (GridServizi.Columns[GetColGrid(ACol)].Field = selT500C_CAMPO2) or
        (GridServizi.Columns[GetColGrid(ACol)].Field =  selT500NOMINATIVO)) then
    begin
      if C700SelAnagrafe.RecordCount > 0 then
      begin
        if (DButton.State <> dsBrowse) and (not selT500.FieldByName('DALLE').IsNull) and (not selT500.FieldByName('ALLE').IsNull) then
          selT500.Post;
        if DButton.State <> dsBrowse then
          exit;
        A139FGestisciPattuglie:=TA139FGestisciPattuglie.Create(nil);
        try
          A139FGestisciPattuglie.ShowModal;
          A139FPianifServiziDtm.selt502_2.Close;
        finally
          FreeAndNil(A139FGestisciPattuglie);
        end;
        try
          selT500.AfterScroll:=nil;
          selT502.Close;
          gridServizi.AutoSizeRows(False,2);
          if chkColonneAutoDimensionate.Checked then
            gridServizi.AutoSizeColumns(False,0);
        finally
          selT500.AfterScroll:=selT500AfterScroll;
        end;
      end
      else
        ShowMessage('Nessun dipendente selezionato!' + #13#10 + 'Selezionare prima i dipendenti su cui operare.');
    end
    else if (selT500.RecordCount > 0) and (GridServizi.Columns[GetColGrid(ACol)].Field = selT500APPARATI) then
    begin
      if (DButton.State <> dsBrowse) and (not selT500.FieldByName('DALLE').IsNull) and (not selT500.FieldByName('ALLE').IsNull) then
        selT500.Post;
      if DButton.State <> dsBrowse then
        exit;
      A139FGestisciApparati:=TA139FGestisciApparati.Create(nil);
      try
        A139FGestisciApparati.ShowModal;
      finally
        FreeAndNil(A139FGestisciApparati);
      end;
      actRefreshExecute(nil);
    end;
  end;
end;

procedure TA139FPianifServizi.GridServiziGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  inherited;
  with A139FPianifServiziDtm do
  begin
    if (ACol <= 0) or (ARow <= 0) or (gdFixed in AState) or (A139FPianifServiziDtm = nil) then
      exit;
    if gridServizi.Cells[gridServizi.ColumnByName['COMANDATO'].Index,ARow] = 'S' then
      if not(gdSelected in AState) then
      begin
        ABrush.Color:=$00AAFFFF;
        AFont.Color:=clWindowText;
      end;
    if (gridServizi.ColumnByName['NOMINATIVO'].Index = ACol) and (Pos('()',gridServizi.Cells[ACol,ARow]) > 0) then
      if not(gdSelected in AState) then
      begin
        ABrush.Color:=$002F97FF;
        AFont.Color:=clWindowText;
      end;
    if (gridServizi.ColumnByName['APPARATI'].Index = ACol) and (gridServizi.Cells[ACol,ARow] = '') then
      if not(gdSelected in AState) then
      begin
        ABrush.Color:=$008080FF;
        AFont.Color:=clWindowText;
      end;
    //if gridServizi.Cells[gridServizi.ColumnByName['DESCTTURNO'].Index,ARow] = '00C' then
    if (gridServizi.Cells[gridServizi.ColumnByName['TIPO_TURNO'].Index,ARow] = '00C') or
       (gridServizi.Cells[gridServizi.ColumnByName['TIPO_TURNO'].Index,ARow] = '00N') then
      if not(gdSelected in AState) then
      begin
        ABrush.Color:=clAqua;
        AFont.Color:=clWindowText;
      end;
    //if GridServizi.Cells[gridServizi.ColumnByName['DESCTTURNO'].Index,ARow] = 'Commento' then
    if (gridServizi.Cells[gridServizi.ColumnByName['TIPO_TURNO'].Index,ARow] = '01C') or
       (gridServizi.Cells[gridServizi.ColumnByName['TIPO_TURNO'].Index,ARow] = '01N') then
      if not(gdSelected in AState) then
      begin
        ABrush.Color:=clGray;
        AFont.Color:=clWindowText;
      end;
  end;
end;

procedure TA139FPianifServizi.GridServiziGetRecordCount(Sender: TObject;
  var Count: Integer);
begin
  inherited;
  if A139FPianifServiziDtm <> nil then
    try
      if A139FPianifServiziDtm.selT500.Active then
        Count:=A139FPianifServiziDtm.selT500.RecordCount;
    except
    end;
end;

procedure TA139FPianifServizi.GridServiziOleDrop(Sender: TObject; ARow,
  ACol: Integer; data: string; var Allow: Boolean);
var Temp,NRow:Integer;
begin
  inherited;
  with A139FPianifServiziDtm do
  begin
    selT500.AfterPost:=nil;
    selT500.BeforePost:=nil;
    selT500.BeforeEdit:=nil;
    try
      NRow:=selT500.RecNo;
      selT500.First;
      selT500.MoveBy(ARow-1);
      Temp:=selT500.FieldByName(Ordinamento).AsInteger;
      if (selT500.RecNo < NRow) then
        while (Not selT500.Eof) and (selT500.RecNo <= NRow) do
        begin
          selT500.Edit;
          selT500.FieldByName(Ordinamento).AsInteger:=selT500.FieldByName(Ordinamento).AsInteger + 1;
          selT500.Post;
          selT500.Next;
        end
      else if (selT500.RecNo > NRow) then
        while (Not selT500.Bof) and (selT500.RecNo >= NRow) do
        begin
          selT500.Edit;
          selT500.FieldByName(Ordinamento).AsInteger:=selT500.FieldByName(Ordinamento).AsInteger - 1;
          selT500.Post;
          selT500.Prior;
        end
      else
        Exit;

      selT500.First;
      selT500.MoveBy(nRow-1);
      selT500.Edit;
      selT500.FieldByName(Ordinamento).AsInteger:=Temp;
      selT500.Post;
    finally
      selT500.AfterPost:=AfterPost;
      selT500.BeforePost:=BeforePostNoStorico;
      selT500.BeforeEdit:=selT500BeforeEdit;
      selT500.Refresh;
    end;
  end;
end;

procedure TA139FPianifServizi.GridServiziRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  inherited;
  NumRecords;
end;

procedure TA139FPianifServizi.dgrdAssentiGiustificatiDblClick(Sender: TObject);
begin
  inherited;
  A139FPianifServiziDtm.OpenAssenti(Sender = dgrdAssentiGiustificati,Sender = dgrdAssentiNonGiustificati);
  if Sender = dgrdAssentiGiustificati then
    grpAssentiGiustificati.Caption:='Assenti giustificati (' + IntToStr(A139FPianifServiziDtM.selT040.RecordCount) + ')';
  if Sender = dgrdAssentiNonGiustificati then
    if A139FPianifServiziDtM.selAssenti.Active then
      grpAssentiNonGiustificati.Caption:='Assenti non giustificati (' + IntToStr(A139FPianifServiziDtM.selAssenti.RecordCount) + ')'
    else
      grpAssentiNonGiustificati.Caption:='Assenti non giustificati (disponibile solo per singola giornata)';
end;

procedure TA139FPianifServizi.PnlDescrizioniResize(Sender: TObject);
begin
  inherited;
  grpNoteServizi.Width:=PnlDescrizioni.Width div 2;
  grpNote.Width:=PnlDescrizioni.Width div 2;
end;

procedure TA139FPianifServizi.PopupMenu1Popup(Sender: TObject);
begin
  inherited;
  if DButton.State in [dsInsert,dsEdit] then
    exit;
  with A139FPianifServiziDtm do
  begin
    OpenT502(selT500.FieldByName('PATTUGLIA').AsInteger,selT500.FieldByName('DATA').AsDateTime);
    actOpenA004.Enabled:=AccessoA004 and UnProgPositivo;
    actOpenA097.Enabled:=AccessoA097 and UnProgPositivo;
    actRegistraPattuglia.Enabled:=ProgPositivi;
  end;
end;

procedure TA139FPianifServizi.Registralapianificazionedelserviziocorrentecomemodello1Click(
  Sender: TObject);
begin
  inherited;
  OpenA139CopiaServizi('I');
end;

procedure TA139FPianifServizi.SpeedButton1Click(Sender: TObject);
var D:TDateTime;
begin
  try
    D:=StrToDate(edtDatada.Text);
  except
    D:=Parametri.DataLavoro;
  end;
  edtDatada.Text:=FormatDateTime('dd/mm/yyyy',DataOut(D,'Descrizione','G'));
  edtDatadaExit(edtDatada);
end;

procedure TA139FPianifServizi.SpeedButton2Click(Sender: TObject);
var D:TDateTime;
begin
  try
    D:=StrToDate(edtDataa.Text);
  except
    D:=Parametri.DataLavoro;
  end;
  edtDataa.Text:=FormatDateTime('dd/mm/yyyy',DataOut(D,'Descrizione','G'));
  edtDatadaExit(edtDataa);
end;

function TA139FPianifServizi.GetTipoGiorno(D:TDateTime):String;
var x:Byte;
    Festivo:Boolean;
    DataPrimoFestivo,DataPrimoGiornaliero:TDateTime;
begin
  Result:='';
  DataPrimoFestivo:=A139FPianifServiziDtm.selT530.FieldByName('DATA_PRIMOGGFES').AsDateTime;
  DataPrimoGiornaliero:=A139FPianifServiziDtm.selT530.FieldByName('DATA_PRIMOGGLAV').AsDateTime;
  with A139FPianifServiziDtm.selT011 do
  begin
    SetVariable('CODICE',A139FPianifServiziDtm.selT530.FieldByName('CALENDARIO').AsString);
    SetVariable('DATA1',Min(DataPrimoFestivo,DataPrimoGiornaliero));
    if D > GetVariable('DATA2') then
    begin
      SetVariable('DATA2',D);
      Close;
    end;
    Open;
    if not SearchRecord('DATA',D,[srFromEnd]) then
      exit;
    if (FieldByName('FESTIVO').AsString = 'S') or (DayOfWeek(D) = 1) then
    begin
      Festivo:=True;
      if SearchRecord('DATA',DataPrimoFestivo,[srFromBeginning]) then
        Result:='Festivo '
      else
        exit;
    end
    else
    begin
      Festivo:=False;
      if SearchRecord('DATA',DataPrimoGiornaliero,[srFromBeginning]) then
        Result:='Giornaliero '
      else
        exit;
    end;
    x:=0;
    while not Eof do
    begin
      if FieldByName('DATA').AsDateTime > D then
        Break;
      if Festivo then
      begin
        if (FieldByName('FESTIVO').AsString = 'S') or (DayOfWeek(FieldByName('DATA').AsDateTime) = 1) then
        begin
          inc(x);
          if x > A139FPianifServiziDtm.selT530.FieldByName('ALTERNANZA_GGFES').AsInteger then
            x:=1;
        end;
      end
      else
      begin
        if (FieldByName('FESTIVO').AsString = 'N') and (DayOfWeek(FieldByName('DATA').AsDateTime) > 1) then
        begin
          inc(x);
          if x > A139FPianifServiziDtm.selT530.FieldByName('ALTERNANZA_GGLAV').AsInteger then
            x:=1;
        end;
      end;
      Next;
    end;
    if x > 0 then
      Result:=Result + IntToStr(x);
  end;
end;

procedure TA139FPianifServizi.Stampa1Click(Sender: TObject);
begin
  if edtDataDa.Text <> edtDataA.Text then
    raise Exception.Create('Non è possibile stampare la carta di servizio per un periodo di più giorni!');
  A139FDialogStampa:=TA139FDialogStampa.Create(nil);
  try
    A139FDialogStampa.DataStampa:=StrToDate(edtDataDa.Text);
    A139FDialogStampa.cmbCampo1.Text:=CartaServizi.Ufficio;
    A139FDialogStampa.edtNote.Text:=CartaServizi.Note;
    A139FDialogStampa.edtNote2.Text:=CartaServizi.Note2;    
    A139FDialogStampa.edtFirmaSx.Text:=CartaServizi.FirmaSx;
    A139FDialogStampa.edtFirmaDx.Text:=CartaServizi.FirmaDx;
    if chkTTurno.Checked then
      A139FDialogStampa.Servizio:=VarToStr(A139FPianifServiziDtM.selT545.Lookup('CODICE',DBCmBTTurno.Text,'DESCRIZIONE'))
    else
      A139FDialogStampa.Servizio:='Giornaliero';
    A139FDialogStampa.ShowModal;
    CartaServizi.Ufficio:=A139FDialogStampa.CmbCampo1.Text;
    CartaServizi.Note:=A139FDialogStampa.edtNote.Text;
    CartaServizi.Note2:=A139FDialogStampa.edtNote2.Text;
    CartaServizi.FirmaSx:=A139FDialogStampa.edtFirmaSx.Text;
    CartaServizi.FirmaDx:=A139FDialogStampa.edtFirmaDx.Text;
  finally
    FreeAndNil(A139FDialogStampa);
  end;
end;

procedure TA139FPianifServizi.TGommaClick(Sender: TObject);
var F:TField;
begin
  inherited;
  if ActiveControl is TGridCombo then
  begin
    GridServizi.HideInplaceEdit;
    ActiveControl:=GridServizi;
  end;
  if ActiveControl = GridServizi then
  begin
    F:=GridServizi.Columns[GetColGrid(GridServizi.Col)].Field;
    //F:=GridServizi.SelectedField;
    if F.Lookup then
      F:=F.DataSet.FieldByName(F.KeyFields);
    if F.DataSet.State in [dsEdit,dsInsert] then
      F.Clear;
  end;
end;

procedure TA139FPianifServizi.Utilizzamodelliesistenti1Click(Sender: TObject);
begin
  inherited;
  OpenA139CopiaServizi('M');
end;

procedure TA139FPianifServizi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  PutParametriFunzione;
end;

procedure TA139FPianifServizi.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(C004FParamForm);
end;

procedure TA139FPianifServizi.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  
  function GetColonnaAdvGrid(DBGrid:TDBAdvGrid; Campo:String):Integer;
  var i:Integer;
  begin
    Result:=-1;
    for i:=0 to DBGrid.Columns.Count - 1 do
      if UpperCase(DBGrid.Columns[i].FieldName) = Campo then
      begin
        Result:=i;
        Break;
      end;
  end;

begin
  inherited;
  if (ssAlt in Shift) and (Key = 80) then
    GridServiziDblClickCell(Sender,GridServizi.Row,GetColonnaAdvGrid(GridServizi,'NOMINATIVO'));
  if (ssAlt in Shift) and (Key = 68) then
    GridServiziDblClickCell(Sender,GridServizi.Row,GetColonnaAdvGrid(GridServizi,'APPARATI'));
end;

end.
