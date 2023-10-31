unit A208UAcquisizioneInfoEsterne;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, SelAnagrafe, C700USelezioneAnagrafe, C005UDatiAnagrafici,
  C180FunzioniGenerali, C004UParamForm, A000UCostanti, A000USessione,
  A000UInterfaccia, A003UDataLavoroBis, RegistrazioneLog, OracleData,
  P999UGenerale, QueryStorico, Menus, Grids, DBGrids, StdCtrls, DBCtrls,
  ExtCtrls, Mask, Buttons, ActnList, ImgList, Db, ComCtrls, ToolWin, Variants,
  C013UCheckList, A083UMsgElaborazioni, StrUtils, Math, System.Actions,
  System.ImageList, A000UMessaggi;

// ATTENZIONE!! frmSelAnagrafe PER IL MOMENTO NON E' UTILIZZATO

type
  TA208FAcquisizioneInfoEsterne = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    actVisualizzaFileInput: TAction;
    actVisualizzaAnomalie: TAction;
    actEseguiAcquisizione: TAction;
    actCancellaAcquisizione: TAction;
    ToolBar1: TToolBar;
    btnVisualizzaFileInput: TToolButton;
    btnSeparator2: TToolButton;
    btnAcquisizione: TToolButton;
    btnAnomalie1: TToolButton;
    btnCancellaAcquisizioniProvvisorie: TToolButton;
    pnlPrincipale: TPanel;
    dgrdInfoEsterne: TDBGrid;
    Operazioni1: TMenuItem;
    Visualizzafilevociinput1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Eseguiacquisizione1: TMenuItem;
    VisualizzaAnomalie1: TMenuItem;
    ProgressBar1: TProgressBar;
    TCopiaSu: TToolButton;
    pnlTitoloGriglia: TPanel;
    OpenDialog1: TOpenDialog;
    gpbImpostazioniFile: TGroupBox;
    lblNomeFile: TLabel;
    edtNomeFile: TEdit;
    btnCercaFile: TButton;
    lblTipo: TLabel;
    lblDato: TLabel;
    cmbTipo: TComboBox;
    cmbDato: TComboBox;
    lblValore: TLabel;
    cmbValore: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actVisualizzaFileInputExecute(Sender: TObject);
    procedure actVisualizzaAnomalieExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actEseguiAcquisizioneExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actCancellaAcquisizioneExecute(Sender: TObject);
    procedure AggiornaGriglia;
    procedure btnCercaFileClick(Sender: TObject);
    //procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    //procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    //procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure DisabilitaComponenti;
    procedure AbilitaComponenti;
    procedure VisualizzaAnomalie;
    procedure ImpostaParametriElaborazione;
   public
    { Public declarations }
    procedure MaxProgressBar(nMax:Integer);
    procedure IncrementaProgressBar;
    //procedure SettaPeriodoSelAnagrafe;
    //procedure MergeSelAnagrafe(ODS:TOracleDataSet;DataRiferimento:TDateTime);
  end;

var
  A208FAcquisizioneInfoEsterne: TA208FAcquisizioneInfoEsterne;

procedure OpenA208FAcquisizioneInfoEsterne(Prog:LongInt);

implementation

uses A208UAcquisizioneInfoEsterneDM, A208UVisualizzazioneFileInfoEsterne;

{$R *.DFM}

procedure OpenA208FAcquisizioneInfoEsterne(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA208FAcquisizioneInfoEsterne') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA208FAcquisizioneInfoEsterne,A208FAcquisizioneInfoEsterne);
  //C700Progressivo:=Prog;
  Application.CreateForm(TA208FAcquisizioneInfoEsterneDM,A208FAcquisizioneInfoEsterneDM);
  with A208FAcquisizioneInfoEsterne do
    try
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A208FAcquisizioneInfoEsterne.Free;
      A208FAcquisizioneInfoEsterneDM.Free;
    end;
end;

procedure TA208FAcquisizioneInfoEsterne.FormCreate(Sender: TObject);
begin
  inherited;
  btnAnomalie1.ImageIndex:=28;
  actVisualizzaAnomalie.Enabled:=False;
  frmSelAnagrafe.Height:=0;
end;

procedure TA208FAcquisizioneInfoEsterne.FormActivate(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A208FAcquisizioneInfoEsterneDM.selT036;
  AggiornaGriglia;
  dgrdInfoEsterne.Options:=[dgRowSelect,dgColumnResize,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit];
  dgrdInfoEsterne.SetFocus;
end;

procedure TA208FAcquisizioneInfoEsterne.FormShow(Sender: TObject);
begin
  inherited;
  CreaC004(SessioneOracle,'A208',Parametri.ProgOper);
  GetParametriFunzione;
  //C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  //C700DatiSelezionati:=C700CampiBase + ',T430CONTRATTO';
  //C700DataLavoro:=Parametri.DataLavoro;
  //frmSelAnagrafe.CreaSelAnagrafe(A208FAcquisizioneInfoEsterneDM.A208MW,SessioneOracle,StatusBar,0,False);
  actEseguiAcquisizione.Enabled:=not SolaLettura;
  actCancellaAcquisizione.Enabled:=not SolaLettura;
  if cmbTipo.ItemIndex = -1 then
    cmbTipo.ItemIndex:=0;
  if cmbDato.ItemIndex = -1 then
    cmbDato.ItemIndex:=0;
end;

procedure TA208FAcquisizioneInfoEsterne.FormDestroy(Sender: TObject);
begin
  inherited;
  //frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA208FAcquisizioneInfoEsterne.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA208FAcquisizioneInfoEsterne.btnCercaFileClick(Sender: TObject);
begin
  inherited;
  OpenDialog1.Title:='Scelta nome file da acquisire';
  if edtNomeFile.Text <> '' then
    OpenDialog1.FileName:=edtNomeFile.Text;
  if OpenDialog1.Execute then
    edtNomeFile.Text:=OpenDialog1.FileName;
end;

procedure TA208FAcquisizioneInfoEsterne.actVisualizzaFileInputExecute(Sender: TObject);
begin
  ImpostaParametriElaborazione;
  A208FAcquisizioneInfoEsterneDM.A208MW.ControlliEsistenzaFile(True);
  Application.CreateForm(TA208FVisualizzazioneFileInfoEsterne,A208FVisualizzazioneFileInfoEsterne);
  with A208FVisualizzazioneFileInfoEsterne do
  begin
    SetNomeFile(A208FAcquisizioneInfoEsterneDM.A208MW.ParametriElaborazione.sNomeFile);
    ShowModal;
    Free;
  end;
end;

procedure TA208FAcquisizioneInfoEsterne.ImpostaParametriElaborazione;
begin
  with A208FAcquisizioneInfoEsterneDM.A208MW.ParametriElaborazione do
  begin
    sNomeFile:=Trim(edtNomeFile.Text);
    sTipo:=cmbTipo.Text;
    sDato:=cmbDato.Text;
    sValoreDefault:=cmbValore.Text;
  end;
end;

procedure TA208FAcquisizioneInfoEsterne.actCancellaAcquisizioneExecute(Sender: TObject);
var Risposta:Integer;
begin
  with A208FAcquisizioneInfoEsterneDM.A208MW do
  begin
    Risposta:=R180MessageBox(A000MSG_P208_DLG_CANCELLA_INFO,DOMANDA);
    if Risposta = mrYes then
    begin
      DisabilitaComponenti;
      ProgressBar1.Position:=0;
      ImpostaParametriElaborazione;
      CancellaT036;
      A208FAcquisizioneInfoEsterneDM.A208MW.PresenzaAnomalie:=False;
      AbilitaComponenti;
      VisualizzaAnomalie;
    end;
  end;
end;

procedure TA208FAcquisizioneInfoEsterne.actEseguiAcquisizioneExecute(Sender: TObject);
begin
  ImpostaParametriElaborazione;
  A208FAcquisizioneInfoEsterneDM.A208MW.ControlliEsistenzaFile;

  if (A208FAcquisizioneInfoEsterneDM.A208MW.RecordCountT036 > 0) then
    if R180MessageBox(A000MSG_P208_DLG_INSERISCI_INFO,DOMANDA) <> mrYes then
      Exit;

  DisabilitaComponenti;
  Screen.Cursor:=crHourglass;
  ProgressBar1.Position:=0;
  try
    with A208FAcquisizioneInfoEsterneDM.A208MW do
    begin
      CancellaT036;
      EseguiAcquisizione;
    end;
  finally
    AbilitaComponenti;
    Screen.Cursor:=crDefault;
    VisualizzaAnomalie;
  end;
end;

procedure TA208FAcquisizioneInfoEsterne.actVisualizzaAnomalieExecute(Sender: TObject);
begin
  //frmSelAnagrafe.SalvaC00SelAnagrafe;
  //C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A208','A,B');
  //C700DatiSelezionati:=C700CampiBase;
  //C700Creazione(SessioneOracle);
  //frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TA208FAcquisizioneInfoEsterne.actRefreshExecute(Sender: TObject);
begin
  inherited;
  AggiornaGriglia;
end;

procedure TA208FAcquisizioneInfoEsterne.AggiornaGriglia;
begin
  with A208FAcquisizioneInfoEsterneDM do
  begin
    A208MW.AggiornaT036;
    StatusBar.Panels[1].Text:=Format('%d Record',[selT036.RecordCount]);
  end;
end;

procedure TA208FAcquisizioneInfoEsterne.DisabilitaComponenti;
// Disabilito i componenti sui quali non devono poter agire
begin
  btnAnomalie1.ImageIndex:=28;
  actVisualizzaAnomalie.Enabled:=False;
  frmSelAnagrafe.Enabled:=False;
  Toolbar1.Enabled:=False;
  pnlPrincipale.Enabled:=False;
end;

procedure TA208FAcquisizioneInfoEsterne.AbilitaComponenti;
// Riabilito i componenti disabilitati
begin
  if A208FAcquisizioneInfoEsterneDM.A208MW.PresenzaAnomalie then
  begin
    btnAnomalie1.ImageIndex:=27;
    actVisualizzaAnomalie.Enabled:=True;
  end
  else
  begin
    btnAnomalie1.ImageIndex:=28;
    actVisualizzaAnomalie.Enabled:=False;
  end;
  frmSelAnagrafe.Enabled:=True;
  Toolbar1.Enabled:=True;
  pnlPrincipale.Enabled:=True;
  ProgressBar1.Position:=0;
  AggiornaGriglia;
end;

procedure TA208FAcquisizioneInfoEsterne.VisualizzaAnomalie;
begin
  if A208FAcquisizioneInfoEsterneDM.A208MW.PresenzaAnomalie then
  begin
    if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
      actVisualizzaAnomalieExecute(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA, INFORMA);
end;

procedure TA208FAcquisizioneInfoEsterne.MaxProgressBar(nMax:Integer);
begin
  ProgressBar1.Max:=nMax;
  ProgressBar1.Position:=0;
end;

procedure TA208FAcquisizioneInfoEsterne.IncrementaProgressBar;
begin
  //if CambioDip then
  //  frmSelAnagrafe.VisualizzaDipendente;
  ProgressBar1.StepBy(1);
  if ProgressBar1.Position = ProgressBar1.Max then
    ProgressBar1.Position:=0;
  Application.ProcessMessages;
end;

procedure TA208FAcquisizioneInfoEsterne.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtNomeFile.Text:=C004FParamForm.GetParametro('NOMEFILE','');
  cmbTipo.Text:=C004FParamForm.GetParametro('TIPO','');
  cmbDato.Text:=C004FParamForm.GetParametro('DATO','');
  cmbValore.Text:=C004FParamForm.GetParametro('VALOREDEFAULT','');
end;

procedure TA208FAcquisizioneInfoEsterne.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('NOMEFILE',Trim(edtNomeFile.Text));
  C004FParamForm.PutParametro('TIPO',cmbTipo.Text);
  C004FParamForm.PutParametro('DATO',cmbDato.Text);
  C004FParamForm.PutParametro('VALOREDEFAULT',Trim(cmbValore.Text));
  try SessioneOracle.Commit; except end;
end;

{procedure TA461FAcquisizioneInfoEsterne.SettaPeriodoSelAnagrafe;
begin
  with P461FImportazioneAssistSanitConvenzDtM.P461MW do
  begin
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(ParametriElaborazione.dDataCompetenza,ParametriElaborazione.dDataCompetenza) then
      SelAnagrafe.Close;
    SelAnagrafe.Open;
    SelAnagrafe.Refresh;
    SelAnagrafe.First;
  end;
end;}

{procedure TA461FAcquisizioneInfoEsterne.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=DataRif;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;}

{procedure TA461FAcquisizioneInfoEsterne.frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnEreditaSelezioneClick(Sender);
  P461FImportazioneAssistSanitConvenzDtm.P461MW.LeggoQuantitaMensili(rgpTipoSanConv.ItemIndex,rgpTipoRecord.ItemIndex,R180FineMese(StrToDate('01/' + edtDataCompetenza.Text)));
  AggiornaGriglia;
end;}

{procedure TA461FAcquisizioneInfoEsterne.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=DataRif;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  with P461FImportazioneAssistSanitConvenzDtm do
    if frmSelAnagrafe.C700ModalResult = mrOk then
    begin
      P461FImportazioneAssistSanitConvenzDtm.P461MW.LeggoQuantitaMensili(rgpTipoSanConv.ItemIndex,rgpTipoRecord.ItemIndex,R180FineMese(StrToDate('01/' + edtDataCompetenza.Text)));
      AggiornaGriglia;
    end;
end;}

{procedure TA461FAcquisizioneInfoEsterne.MergeSelAnagrafe(ODS:TOracleDataSet;DataRiferimento:TDateTime);
begin
  C700MergeSelAnagrafe(ODS);
  C700MergeSettaPeriodo(ODS,DataRiferimento,DataRiferimento);
end;}

end.
