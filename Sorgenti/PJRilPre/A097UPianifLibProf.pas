unit A097UPianifLibProf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StrUtils, Buttons, StdCtrls, ExtCtrls, DB, OracleData, Spin, DBCtrls, Menus,
  Grids, DBGrids, ComCtrls, Mask, Variants, RegistrazioneLog, Math, SelAnagrafe,
  C001StampaLib, C004UParamForm, C005UDatiAnagrafici, C015UElencoValori,
  C180FunzioniGenerali, C700USelezioneAnagrafe, ToolbarFiglio,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  A003UDataLavoroBis, A083UMsgElaborazioni, A096UProfiliLibProf, InputPeriodo;

type
  TA097FPianifLibProf = class(TForm)
    pnlGestioneProfilo: TPanel;
    EProfilo: TDBLookupComboBox;
    Label4: TLabel;
    btnInserimento: TBitBtn;
    DBGrid1: TDBGrid;
    PopupMenu2: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Label6: TLabel;
    StatusBar: TStatusBar;
    btnCancellazione: TBitBtn;
    ProgressBar1: TProgressBar;
    PrinterSetupDialog1: TPrinterSetupDialog;
    ChkFestivi: TCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlTestata: TPanel;
    btnStampante: TBitBtn;
    btnStampa: TBitBtn;
    frmToolbarFiglio: TfrmToolbarFiglio;
    pnlImportazioneFile: TPanel;
    lblNomeFileInput: TLabel;
    edtNomeFileInput: TEdit;
    sbtNomeFileInput: TSpeedButton;
    OpenDialog1: TOpenDialog;
    btnImportazioneFile: TBitBtn;
    btnAnomalie: TBitBtn;
    rgpGestioneProfilo: TRadioGroup;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure rgpGestioneProfiloClick(Sender: TObject);
    procedure EProfiloKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure btnStampanteClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure btnInserimentoClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure sbtNomeFileInputClick(Sender: TObject);
    procedure btnImportazioneFileClick(Sender: TObject);
    procedure AggiornaData;
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodobtnDataFineClick(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CambiaProgressivo;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Public declarations }
    procedure VisualizzaDipendente;
    procedure AbilitaComponenti;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A097FPianifLibProf: TA097FPianifLibProf;

procedure OpenA097PianifLibProf(Prog:LongInt; Data:TDateTime);

implementation

uses A097UPianifLibProfDtM1, A097UStampaLibProf;

{$R *.DFM}

procedure OpenA097PianifLibProf(Prog:LongInt; Data:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA097PianifLibProf') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A097FPianifLibProf:=TA097FPianifLibProf.Create(nil);
  C700Progressivo:=Prog;
  A097FPianifLibProfDtM1:=TA097FPianifLibProfDtM1.Create(nil);
  with A097FPianifLibProf do
    try
      A097FPianifLibProfDtM1.A097MW.Dal:=R180InizioMese(Data);
      A097FPianifLibProfDtM1.A097MW.Al:=R180FineMese(Data);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
      A097FPianifLibProfDtM1.Free;
    end;
end;

procedure TA097FPianifLibProf.FormCreate(Sender: TObject);
begin
  A097FStampaLibProf:=TA097FStampaLibProf.Create(nil);
end;

procedure TA097FPianifLibProf.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A097',Parametri.ProgOper);
  GetParametriFunzione;
  frmToolbarFiglio.TFDButton:=A097FPianifLibProfDtM1.D320;
  frmToolbarFiglio.TFDBGrid:=DBGrid1;
  A097FPianifLibProfDtM1.Q320.ReadOnly:=SolaLettura;
  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  //A097FPianifLibProfDtM1.D320.OnStateChange:=frmToolbarFiglio.DButtonStateChange;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=pnlTestata;
  frmToolbarFiglio.lstLock[1]:=pnlGestioneProfilo;
  frmToolbarFiglio.lstLock[2]:=frmSelAnagrafe;
  frmToolbarFiglio.lstLock[3]:=pnlImportazioneFile;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  A097FPianifLibProfDtM1.A097MW.CodForm:=IfThen(A097FPianifLibProfDtM1.A097MW.TipoModulo = 'CS','A097','WA097');
  if A097FPianifLibProfDtM1.A097MW.Dal = 0 then
    A097FPianifLibProfDtM1.A097MW.Dal:=R180InizioMese(Parametri.DataLavoro);
  if A097FPianifLibProfDtM1.A097MW.Al = 0 then
    A097FPianifLibProfDtM1.A097MW.Al:=R180FineMese(Parametri.DataLavoro);
  DataI:= A097FPianifLibProfDtM1.A097MW.Dal;
  DataF:= A097FPianifLibProfDtM1.A097MW.Al;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',upper(T030.CODFISCALE) CODFISCALE';
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A097FPianifLibProfDtM1.A097MW,SessioneOracle,StatusBar,0,True);
  btnAnomalie.Enabled:=False;
  AbilitaComponenti;
end;

procedure TA097FPianifLibProf.GetParametriFunzione;
{Leggo i parametri della form}
var S:String;
begin
  S:=A097FPianifLibProfDtM1.A097MW.Q310.FieldByName('Codice').AsString;
  EProfilo.KeyValue:=C004FParamForm.GetParametro('EPROFILO',S);
  chkFestivi.Checked:=C004FParamForm.GetParametro('CHKFESTIVI','N') = 'S';
  edtNomeFileInput.Text:=C004FParamForm.GetParametro('EDTNOMEFILEINPUT','');
end;

procedure TA097FPianifLibProf.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('EPROFILO',VarToStr(EProfilo.KeyValue));
  C004FParamForm.PutParametro('CHKFESTIVI',IfThen(chkFestivi.Checked,'S','N'));
  C004FParamForm.PutParametro('EDTNOMEFILEINPUT',edtNomeFileInput.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TA097FPianifLibProf.CambiaProgressivo;
begin
  if A097FPianifLibProfDtM1.A097MW.SelAnagrafe = nil then
    exit;
  if C700OldProgressivo <> C700Progressivo then
    A097FPianifLibProfDtM1.A097MW.RefreshSelT320;
  AbilitaComponenti;
end;

procedure TA097FPianifLibProf.AbilitaComponenti;
begin
  frmToolBarFiglio.Align:=alCustom;//Necessario per non mischiare gli align dei panel dovuti all'impostazione di Visible
  DBGrid1.Align:=alCustom;//Necessario per non mischiare gli align dei panel dovuti all'impostazione di Visible
  pnlGestioneProfilo.Visible:=rgpGestioneProfilo.ItemIndex = 1;
  pnlImportazioneFile.Visible:=rgpGestioneProfilo.ItemIndex = 2;
  frmToolBarFiglio.Enabled:=(rgpGestioneProfilo.ItemIndex = 0) and (C700SelAnagrafe.RecordCount > 0);
  DBGrid1.Enabled:=(rgpGestioneProfilo.ItemIndex = 0) and (C700SelAnagrafe.RecordCount > 0);
  btnInserimento.Enabled:=C700SelAnagrafe.RecordCount > 0;
  btnCancellazione.Enabled:=C700SelAnagrafe.RecordCount > 0;
  btnImportazioneFile.Enabled:=C700SelAnagrafe.RecordCount > 0;
  frmToolBarFiglio.Align:=alTop;//Necessario per non mischiare gli align dei panel dovuti all'impostazione di Visible
  DBGrid1.Align:=alClient;//Necessario per non mischiare gli align dei panel dovuti all'impostazione di Visible
end;

procedure TA097FPianifLibProf.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=A097FPianifLibProfDtM1.A097MW.Al;
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA097FPianifLibProf.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  frmInputPeriodo.btnAvantiClick(Sender);
  AggiornaData;
end;

procedure TA097FPianifLibProf.frmInputPeriodobtnDataFineClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataFineClick(Sender);
  AggiornaData;
end;

procedure TA097FPianifLibProf.frmInputPeriodobtnDataInizioClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataInizioClick(Sender);
  AggiornaData;
end;

procedure TA097FPianifLibProf.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  frmInputPeriodo.btnIndietroClick(Sender);
  AggiornaData;
end;

procedure TA097FPianifLibProf.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  AggiornaData;
end;

procedure TA097FPianifLibProf.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  frmInputPeriodo.edtInizioExit(Sender);
  AggiornaData;
end;

procedure TA097FPianifLibProf.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=A097FPianifLibProfDtM1.A097MW.Al;
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA097FPianifLibProf.rgpGestioneProfiloClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TA097FPianifLibProf.EProfiloKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (not EProfilo.ListVisible) then
    Label6.Caption:='';
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      //if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA097FPianifLibProf.Nuovoelemento1Click(Sender: TObject);
{Richiamo gestione turnazioni}
begin
  OpenA096ProfiliLibProf(EProfilo.Text);
  A097FPianifLibProfDtM1.A097MW.Q310.DisableControls;
  A097FPianifLibProfDtM1.A097MW.Q310.Refresh;
  A097FPianifLibProfDtM1.A097MW.Q310.EnableControls;
end;

procedure TA097FPianifLibProf.btnStampanteClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A097FStampaLibProf.QRep);
end;

procedure TA097FPianifLibProf.btnStampaClick(Sender: TObject);
var OldProg: Integer;
begin
  OldProg:=C700Progressivo;
  C700SelAnagrafe.First;
  A097FStampaLibProf.LEnte.Caption:=Parametri.DAzienda;
  A097FStampaLibProf.LTitolo.Caption:='Turni di libera professione pianificati';
  A097FStampaLibProf.QRep.DataSet:=C700SelAnagrafe;
  A097FStampaLibProf.QrDBText1.DataSet:=C700SelAnagrafe;
  A097FStampaLibProf.LTitolo.Caption:=A097FStampaLibProf.LTitolo.Caption + ' dal ' + frmInputPeriodo.edtInizio.Text + ' al ' + frmInputPeriodo.edtFine.Text;
  A097FPianifLibProfDtM1.Q320.SetVariable('Data1',A097FPianifLibProfDtM1.A097MW.Dal);
  A097FPianifLibProfDtM1.Q320.SetVariable('Data2',A097FPianifLibProfDtM1.A097MW.Al);
  A097FPianifLibProfDtM1.Q320.ReadBuffer:=Trunc(Max(0,A097FPianifLibProfDtM1.A097MW.Al - A097FPianifLibProfDtM1.A097MW.Dal) + 1) * 2;
  A097FStampaLibProf.QRep.Preview;
  C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
  frmSelAnagrafe.VisualizzaDipendente;
  C700OldProgressivo:=-1;
  CambiaProgressivo;
end;

procedure TA097FPianifLibProf.btnInserimentoClick(Sender: TObject);
{Inserisco la turnazione specificata cancellando eventualmente una già esistente
 nello stesso periodo}
var OldProg: Integer;
begin
  if A097FPianifLibProfDtM1.A097MW.Dal > A097FPianifLibProfDtM1.A097MW.Al then
    raise Exception.Create(A000MSG_ERR_DATE_INVERTITE);
  if (A097FPianifLibProfDtM1.A097MW.Al - A097FPianifLibProfDtM1.A097MW.Dal) > (R180AddMesi(A097FPianifLibProfDtM1.A097MW.Dal,(12 * 5)) - A097FPianifLibProfDtM1.A097MW.Dal) then
    raise Exception.Create(A000MSG_A097_ERR_PERIODO_LUNGO);
  if EProfilo.Text = '' then
    raise Exception.create(A000MSG_A097_ERR_PROFILO_NON_VALIDO);
  if R180MessageBox(Format(A000MSG_A097_DLG_FMT_CONFERMA,[IfThen(Sender = btnInserimento,'l''inserimento','la cancellazione'),frmInputPeriodo.edtInizio.Text, frmInputPeriodo.edtFine.Text]),DOMANDA) <> mrYes then
    exit;
  A097FPianifLibProfDtM1.A097MW.Q311.Close;
  A097FPianifLibProfDtM1.A097MW.Q311.SetVariable('Codice',EProfilo.Text);
  A097FPianifLibProfDtM1.A097MW.Q311.Open;
  btnAnomalie.Enabled:=False;
  A097FPianifLibProfDtM1.A097MW.PianifFestivi:=ChkFestivi.Checked;
  RegistraMsg.IniziaMessaggio(A097FPianifLibProfDtM1.A097MW.CodForm);
  OldProg:=C700Progressivo;
  C700SelAnagrafe.First;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  ProgressBar1.Position:=0;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.Eof do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.StepBy(1);
      A097FPianifLibProfDtM1.A097MW.GestionePianificazione(C700Progressivo,Sender = btnInserimento);
      C700SelAnagrafe.Next;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    ProgressBar1.Position:=0;
    C700SelAnagrafe.First;
    C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
    frmSelAnagrafe.VisualizzaDipendente;
    C700OldProgressivo:=-1;
    CambiaProgressivo;
  end;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if btnAnomalie.Enabled then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,'DOMANDA') = mrYes) then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,'INFORMA');
end;

procedure TA097FPianifLibProf.btnImportazioneFileClick(Sender: TObject);
var MsgNoImp:String;
    OldProg,i: Integer;
begin
  A097FPianifLibProfDtM1.A097MW.NomeFile:=edtNomeFileInput.Text;
  A097FPianifLibProfDtM1.A097MW.ControlliImportazione;
  if (A097FPianifLibProfDtM1.A097MW.TipoModulo <> 'COM') then
    if R180MessageBox(Format(A000MSG_A097_DLG_FMT_CONFERMA_IMPORT,[A097FPianifLibProfDtM1.A097MW.NomeFile,IntToStr(C700SelAnagrafe.RecordCount),DateToStr(A097FPianifLibProfDtM1.A097MW.Dal),DateToStr(A097FPianifLibProfDtM1.A097MW.Al)]),DOMANDA) <> mrYes then
      exit;
  A097FPianifLibProfDtM1.A097MW.NRecImp:=0;
  btnAnomalie.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  RegistraMsg.IniziaMessaggio(A097FPianifLibProfDtM1.A097MW.CodForm);
  OldProg:=C700Progressivo;
  C700SelAnagrafe.First;
  Self.Enabled:=False;
  ProgressBar1.Position:=0;
  try
    A097FPianifLibProfDtM1.A097MW.ValorizzaVettoreCampi;
    if not ((RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB)) then
    begin
      A097FPianifLibProfDtM1.A097MW.ImportaFile_Inizio1;
      try
        A097FPianifLibProfDtM1.A097MW.ImportaFile_Inizio2;
        ProgressBar1.Max:=A097FPianifLibProfDtM1.A097MW.FRighe - 1;
        for i:=2 to A097FPianifLibProfDtM1.A097MW.FRighe do
        begin
          A097FPianifLibProfDtM1.A097MW.FRiga:=i;
          ProgressBar1.StepBy(1);
          Application.ProcessMessages;
          A097FPianifLibProfDtM1.A097MW.ImportaFile_Corpo;
        end;
      finally
        A097FPianifLibProfDtM1.A097MW.ImportaFile_Fine;
      end;
    end;
  finally
    Self.Enabled:=True;
    C700SelAnagrafe.First;
    C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
    frmSelAnagrafe.VisualizzaDipendente;
    C700OldProgressivo:=-1;
    CambiaProgressivo;
    Screen.Cursor:=crDefault;
    MsgNoImp:=IfThen(A097FPianifLibProfDtM1.A097MW.NRecImp = 0,A000MSG_A097_ERR_NO_IMPORT + CRLF);
  end;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if (A097FPianifLibProfDtM1.A097MW.TipoModulo <> 'COM') then
  begin
    if btnAnomalie.Enabled then
    begin
      if (R180MessageBox(MsgNoImp + A000MSG_DLG_ELAB_ANOMALIE_VIS,'DOMANDA') = mrYes) then
        btnAnomalieClick(nil);
    end
    else
      R180MessageBox(MsgNoImp + A000MSG_MSG_ELABORAZIONE_TERMINATA,'INFORMA');
  end;
  ProgressBar1.Position:=0;
end;

procedure TA097FPianifLibProf.VisualizzaDipendente;
begin
  frmSelAnagrafe.VisualizzaDipendente;
  Application.ProcessMessages;
end;

procedure TA097FPianifLibProf.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,A097FPianifLibProfDtM1.A097MW.CodForm,'');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A097FPianifLibProfDtM1.A097MW);
end;

procedure TA097FPianifLibProf.sbtNomeFileInputClick(Sender: TObject);
begin
  OpenDialog1.Title:='Nome file di importazione';
  if edtNomeFileInput.Text <> '' then
    OpenDialog1.FileName:=edtNomeFileInput.Text;
  if OpenDialog1.Execute then
    edtNomeFileInput.Text:=OpenDialog1.FileName;
end;


procedure TA097FPianifLibProf.DBGrid1EditButtonClick(Sender: TObject);
var  vCodice:Variant;
begin
  if (A097FPianifLibProfDtM1.Q320.ReadOnly) or (A097FPianifLibProfDtM1.Q320.State in [dsBrowse]) then
    exit;
  vCodice:=VarArrayOf([A097FPianifLibProfDtM1.Q320.FieldByName('CAUSALE').asString]);
  OpenC015FElencoValori('','<A097> Selezione della causale',A097FPianifLibProfDtM1.A097MW.Q275.Sql.Text,'CODICE',vCodice,A097FPianifLibProfDtM1.A097MW.Q275,350);
  if not VarIsClear(vCodice) then
    A097FPianifLibProfDtM1.Q320.FieldByName('CAUSALE').asString:=VarToStr(vCodice[0]);
end;

procedure TA097FPianifLibProf.AggiornaData;
begin
  if DataI > 0 then
    A097FPianifLibProfDtM1.A097MW.Dal:=DataI;
  If DataF > 0 then
    A097FPianifLibProfDtM1.A097MW.Al:=DataF;

  if C700SelAnagrafe.GetVariable('DataLavoro') <> A097FPianifLibProfDtM1.A097MW.Al then
    begin
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SetVariable('DataLavoro',A097FPianifLibProfDtM1.A097MW.Al);
      C700SelAnagrafe.Open;
      frmSelAnagrafe.NumRecords;
      frmSelAnagrafe.VisualizzaDipendente;
    end;

  A097FPianifLibProfDtM1.A097MW.RefreshSelT320;
end;

procedure TA097FPianifLibProf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA097FPianifLibProf.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

{ DataF }
function TA097FPianifLibProf._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA097FPianifLibProf._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ----DataF }
{ DataI }
function TA097FPianifLibProf._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA097FPianifLibProf._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ----DataI }

end.
