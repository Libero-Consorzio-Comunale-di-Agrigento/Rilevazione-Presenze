unit A171UXMLVisiteFiscali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  SelAnagrafe, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, FunzioniGenerali, Vcl.DBCtrls, C004UParamForm, A083UMsgElaborazioni,
  A003UDataLavoroBis, C700USelezioneAnagrafe, A000UInterfaccia, C180FunzioniGenerali,
  OracleData, System.IOUtils, A000USessione, A000UMessaggi, System.ImageList, InputPeriodo;

type
  TA171FXMLVisiteFiscali = class(TR001FGestTab)
    pnlAzioni: TPanel;
    dGrdVisiteFiscali: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnGeneraXML: TBitBtn;
    btnAnomalie: TBitBtn;
    rdgFiltroElaborato: TRadioGroup;
    lblPathXML: TLabel;
    edtPathXML: TEdit;
    btnPathXML: TButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    actCancellaVisite: TAction;
    grpInfoRichiedente: TGroupBox;
    lblRichiedenteCognome: TLabel;
    lblRichiedenteNome: TLabel;
    lblRichiedenteCF: TLabel;
    lblRichiedenteEMail: TLabel;
    lblRichiedenteTelefono: TLabel;
    edtRichiedenteCognome: TEdit;
    edtRichiedenteNome: TEdit;
    edtRichiedenteCodFiscale: TEdit;
    edtEMail: TEdit;
    edtTelefono: TEdit;
    SaveDlg: TSaveDialog;
    rgpDipendente: TGroupBox;
    lblInizioMal: TLabel;
    lblFineMal: TLabel;
    grpReperibilita: TGroupBox;
    lblRepComune: TLabel;
    lblRepCAP: TLabel;
    lblRepIndirizzo: TLabel;
    lblRepCognome: TLabel;
    dCmbRepComune: TDBLookupComboBox;
    dEdtRepCAP: TDBEdit;
    dEdtRepIndirizzo: TDBEdit;
    dEdtRepCognome: TDBEdit;
    dChkMalattiaFerie: TDBCheckBox;
    dEdtInizioMal: TDBEdit;
    dEdtFineMal: TDBEdit;
    btnInizioMal: TButton;
    btnFineMal: TButton;
    grpDettaglioVisita: TGroupBox;
    lblDataRichiesta: TLabel;
    lblOraRichiesta: TLabel;
    lblDataVisita: TLabel;
    dEdtDataRichiesta: TDBEdit;
    dEdtOraRichiesta: TDBEdit;
    dChkConfermaAmb: TDBCheckBox;
    dChkAccettaAttiMed: TDBCheckBox;
    dRgpTipoAmbDom: TDBRadioGroup;
    dEdtDataVisita: TDBEdit;
    dRgpOrarioVisita: TDBRadioGroup;
    dRgpObbligoOrario: TDBRadioGroup;
    btnDataRichiestaDa: TButton;
    btnDataVisita: TButton;
    btnCopiaConfig: TBitBtn;
    dChkElaborato: TDBCheckBox;
    N4: TMenuItem;
    Cancelladipendenti1: TMenuItem;
    actCaricaVisite: TAction;
    CaricarichiestedaComunicazionevisitefiscali1: TMenuItem;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    MnuCopia: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N9: TMenuItem;
    Copia1: TMenuItem;
    CopiaInExcel: TMenuItem;
    grpDettAgg: TGroupBox;
    lblDettagliIndirizzo: TLabel;
    dedtDettagliIndirizzo: TDBEdit;
    lblTelefono: TLabel;
    dedtTelefono: TDBEdit;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPathXMLClick(Sender: TObject);
    procedure btnGeneraXMLClick(Sender: TObject);
    procedure dEdtInizioMalExit(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnDataRichiestaDaClick(Sender: TObject);
    procedure btnInizioMalClick(Sender: TObject);
    procedure btnFineMalClick(Sender: TObject);
    procedure rdgFiltroElaboratoClick(Sender: TObject);
    procedure btnCopiaConfigClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure actCancellaVisiteExecute(Sender: TObject);
    procedure btnDataVisitaClick(Sender: TObject);
    procedure actCaricaVisiteExecute(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia1Click(Sender: TObject);
    procedure dCmbRepComuneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnDataFineClick(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure IniDCmbRepComune;
    procedure SetEdtData(edtData:TDBEdit);
    procedure Caricamento(Visite:Boolean);
    procedure VerificaPeriodo;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Public declarations }
    procedure CambiaProgressivo;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A171FXMLVisiteFiscali: TA171FXMLVisiteFiscali;

procedure OpenA171XMLVisiteFiscali;

implementation

uses A171UXMLVisiteFiscaliDM, A171UXMLVisiteFiscaliMW;

{$R *.dfm}

procedure OpenA171XMLVisiteFiscali;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA171XMLVisiteFiscali') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A171FXMLVisiteFiscaliDM:=TA171FXMLVisiteFiscaliDM.Create(nil);
  try
    A171FXMLVisiteFiscali:=TA171FXMLVisiteFiscali.Create(nil);
    A171FXMLVisiteFiscali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Screen.Cursor:=crDefault;
    FreeAndNil(A171FXMLVisiteFiscali);
    FreeAndNil(A171FXMLVisiteFiscaliDM);
  end;
end;

procedure TA171FXMLVisiteFiscali.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdVisiteFiscali,'S');
end;

procedure TA171FXMLVisiteFiscali.SetEdtData(edtData:TDBEdit);
var DataIn:TDateTime;
begin
  if not TryStrToDate(edtData.Text,DataIn) then
    DataIn:=Trunc(R180SysDate(SessioneOracle));
  edtData.Text:=DataOut(DataIn,edtData.Hint,'G').ToString('dd/mm/yyyy');
end;

procedure TA171FXMLVisiteFiscali.btnDataRichiestaDaClick(Sender: TObject);
begin
  inherited;
  SetEdtData(dEdtDataRichiesta);
end;

procedure TA171FXMLVisiteFiscali.btnDataVisitaClick(Sender: TObject);
begin
  inherited;
  SetEdtData(dEdtDataVisita);
end;

procedure TA171FXMLVisiteFiscali.btnInizioMalClick(Sender: TObject);
begin
  inherited;
  SetEdtData(dEdtInizioMal);
end;

procedure TA171FXMLVisiteFiscali.btnFineMalClick(Sender: TObject);
begin
  inherited;
  SetEdtData(dEdtFineMal);
end;

procedure TA171FXMLVisiteFiscali.actCancellaVisiteExecute(Sender: TObject);
var sInput:String;
begin
  inherited;
  btnAnomalie.Enabled:=False;
  if R180MessageBox(A171FXMLVisiteFiscaliDM.A171MW.T049MessaggioCancellazione,DOMANDA) = mrYes then
  begin
    sInput:= InputBox('Cancellazione di ' + IntToStr(A171FXMLVisiteFiscaliDM.selT049.RecordCount) + ' visite fiscali' ,'Inserire il numero di visite fiscali che verranno cancellate:', '0');
    if sInput <> IntToStr(A171FXMLVisiteFiscaliDM.selT049.RecordCount) then
    begin
      R180MessageBox(A000MSG_MSG_OPERAZIONE_ANNULLATA,INFORMA);
      exit;
    end;
    A171FXMLVisiteFiscaliDM.A171MW.CancellaPeriodoVisiteT049;
    A171FXMLVisiteFiscaliDM.selT049.Refresh;
  end;
end;

procedure TA171FXMLVisiteFiscali.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  PutParametriFunzione;
  FreeAndNil(C004FParamForm);
end;

procedure TA171FXMLVisiteFiscali.FormCreate(Sender: TObject);
begin
  inherited;
  CreaC004(SessioneOracle, 'A171', Parametri.ProgOper);
  GetParametriFunzione;
  frmInputPeriodo.CaptionDataOutI:= 'Periodo Da';
  frmInputPeriodo.CaptionDataOutF:= 'Periodo A';
end;

procedure TA171FXMLVisiteFiscali.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA171FXMLVisiteFiscali.GetParametriFunzione;
begin
  //Richiedente
  edtRichiedenteCognome.Text:=C004FParamForm.GetParametro(edtRichiedenteCognome,'');
  edtRichiedenteNome.Text:=C004FParamForm.GetParametro(edtRichiedenteNome,'');
  edtRichiedenteCodFiscale.Text:=C004FParamForm.GetParametro(edtRichiedenteCodFiscale,'');
  edtEMail.Text:=C004FParamForm.GetParametro(edtEMail,'');
  edtTelefono.Text:=C004FParamForm.GetParametro(edtTelefono,'');
  //--
  edtPathXML.Text:=C004FParamForm.GetParametro(edtPathXML,'');
end;

procedure TA171FXMLVisiteFiscali.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  //Richiedente
  C004FParamForm.PutParametro(edtRichiedenteCognome,edtRichiedenteCognome.Text);
  C004FParamForm.PutParametro(edtRichiedenteNome,edtRichiedenteNome.Text);
  C004FParamForm.PutParametro(edtRichiedenteCodFiscale,edtRichiedenteCodFiscale.Text);
  C004FParamForm.PutParametro(edtEMail,edtEMail.Text);
  C004FParamForm.PutParametro(edtTelefono,edtTelefono.Text);
  //--
  C004FParamForm.PutParametro(edtPathXML,edtPathXML.Text);
  try
    SessioneOracle.Commit;
  except
  end;
end;

procedure TA171FXMLVisiteFiscali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  if A171FXMLVisiteFiscali <> nil then
  begin
    btnInizioMal.Enabled:=DButton.DataSet.State in [dsInsert,dsEdit];
    btnFineMal.Enabled:=DButton.DataSet.State in [dsInsert,dsEdit];
    btnDataRichiestaDa.Enabled:=False; //Sempre disabilitato perchè campo chiave
    btnDataVisita.Enabled:=DButton.DataSet.State in [dsInsert,dsEdit];
    btnCopiaConfig.Enabled:=Not (DButton.DataSet.State in [dsInsert,dsEdit]);
    actCaricaVisite.Enabled:=Not (DButton.DataSet.State in [dsInsert,dsEdit]);
    actCancellaVisite.Enabled:=Not (DButton.DataSet.State in [dsInsert,dsEdit]);
    pnlAzioni.Enabled:=Not (DButton.DataSet.State in [dsInsert,dsEdit]);
    btnGeneraXML.Enabled:=Not (DButton.DataSet.State in [dsInsert,dsEdit]);
  end;
end;

procedure TA171FXMLVisiteFiscali.rdgFiltroElaboratoClick(Sender: TObject);
begin
  inherited;
  case rdgFiltroElaborato.ItemIndex of
    0: A171FXMLVisiteFiscaliDM.A171MW.T049FiltroElaborato:='';   //'Tutto'
    1: A171FXMLVisiteFiscaliDM.A171MW.T049FiltroElaborato:='S';  //'Elaborato'
    2: A171FXMLVisiteFiscaliDM.A171MW.T049FiltroElaborato:='N';  //'Da elaborare'
  end;
  A171FXMLVisiteFiscali.rgpDipendente.Caption:='';
  A171FXMLVisiteFiscaliDM.A171MW.OpenSelT049;
end;

procedure TA171FXMLVisiteFiscali.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A171FXMLVisiteFiscaliDM.selT049;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  A171FXMLVisiteFiscaliDM.A171MW.SelAnagrafe:=C700SelAnagrafe;
  actInserisci.Visible:=False;
  DataI:= Trunc(R180SysDate(SessioneOracle));
  DataF:= Trunc(R180SysDate(SessioneOracle));
  VerificaPeriodo;
  rdgFiltroElaboratoClick(nil);
  IniDCmbRepComune;
end;

procedure TA171FXMLVisiteFiscali.IniDCmbRepComune;
begin
  dCmbRepComune.DataSource:=DButton;
  dCmbRepComune.DataField:='CODCATASTALE_REP';
  dCmbRepComune.ListSource:=A171FXMLVisiteFiscaliDM.A171MW.dsrT480;
  dCmbRepComune.ListField:='CODCATASTALE;CITTA';
  dCmbRepComune.KeyField:='CODCATASTALE';
end;

procedure TA171FXMLVisiteFiscali.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdVisiteFiscali,'C');
end;

procedure TA171FXMLVisiteFiscali.CambiaProgressivo;
begin
  //Non c'è scorrimento
end;

procedure TA171FXMLVisiteFiscali.VerificaPeriodo;
begin
  A171FXMLVisiteFiscaliDM.A171MW.VerificaPeriodoT049(DataI, DataF);
  A171FXMLVisiteFiscali.rgpDipendente.Caption:='';
  A171FXMLVisiteFiscaliDM.A171MW.OpenSelT049;
end;


procedure TA171FXMLVisiteFiscali.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.btnAvantiClick(Sender);
  VerificaPeriodo;
end;

procedure TA171FXMLVisiteFiscali.frmInputPeriodobtnDataFineClick(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.btnDataFineClick(Sender);
  VerificaPeriodo;
end;

procedure TA171FXMLVisiteFiscali.frmInputPeriodobtnDataInizioClick(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.btnDataInizioClick(Sender);
  VerificaPeriodo;
end;

procedure TA171FXMLVisiteFiscali.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.btnIndietroClick(Sender);
  VerificaPeriodo;
end;

procedure TA171FXMLVisiteFiscali.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  inherited;
  VerificaPeriodo;
end;

procedure TA171FXMLVisiteFiscali.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.edtInizioExit(Sender);
  VerificaPeriodo;
end;

procedure TA171FXMLVisiteFiscali.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
//  inherited;
  C700DataLavoro:=Trunc(R180SysDate(SessioneOracle));
  frmSelAnagrafe.btnSelezioneClick(Sender);
  if frmSelAnagrafe.C700ModalResult = mrOK then
  begin
    if C700SelAnagrafe.RecordCount <= 0 then
      raise Exception.Create(A000MSG_ERR_NO_DIP);
    if R180MessageBox(Format(A000MSG_A171_DLG_FMT_INSERIMENTO,[IntToStr(C700SelAnagrafe.RecordCount)]),DOMANDA,'Conferma inserimento') <> mrYes then  //'Verranno inserite %s richieste visite fiscali. Continuare?';
      Exit;
  end
  else
    Exit;
  Caricamento(False);
end;

procedure TA171FXMLVisiteFiscali.actCaricaVisiteExecute(Sender: TObject);
begin
  inherited;
  A171FXMLVisiteFiscaliDM.A171MW.selT047.Close;
  A171FXMLVisiteFiscaliDM.A171MW.selT047.Open;
  if A171FXMLVisiteFiscaliDM.A171MW.selT047.RecordCount <= 0 then
    raise Exception.Create(A000MSG_A171_ERR_NO_VISITE);  //Non sono presenti visite fiscali da caricare in data odierna!
  if R180MessageBox(Format(A000MSG_A171_DLG_FMT_INSERIMENTO,[IntToStr(A171FXMLVisiteFiscaliDM.A171MW.selT047.RecordCount)]),DOMANDA,'Conferma inserimento') <> mrYes then  //'Verranno inserite %s richieste visite fiscali. Continuare?';
    Exit;
  Caricamento(True);
end;

procedure TA171FXMLVisiteFiscali.Caricamento(Visite:Boolean);
begin
  btnAnomalie.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  A171FXMLVisiteFiscaliDM.A171MW.InsDipSuT049(Visite);
  A171FXMLVisiteFiscaliDM.selT049.Refresh;
  rdgFiltroElaborato.ItemIndex:=2;
  DataI:= Trunc(R180SysDate(SessioneOracle));
  DataF:= Trunc(R180SysDate(SessioneOracle));
  VerificaPeriodo;
  rdgFiltroElaboratoClick(nil);
  Screen.Cursor:=crDefault;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoI;
  if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoI then
  begin
    if R180MessageBox(A000MSG_DLG_ELAB_ANOM_SEGNAL_VIS,DOMANDA) = mrYes then  //'Elaborazione terminata con anomalie e segnalazioni. Si desidera visualizzarle?'
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA, INFORMA);
end;

procedure TA171FXMLVisiteFiscali.Annullatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdVisiteFiscali,'N');
end;

procedure TA171FXMLVisiteFiscali.Copia1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dgrdVisiteFiscali,Sender = CopiaInExcel);
end;

procedure TA171FXMLVisiteFiscali.btnAnomalieClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A171','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A171FXMLVisiteFiscaliDM.A171MW);
end;

procedure TA171FXMLVisiteFiscali.btnPathXMLClick(Sender: TObject);
begin
  inherited;
  SaveDlg.InitialDir:=ExtractFilePath(edtPathXML.Text);
  SaveDlg.FileName:=ExtractFileName(edtPathXML.Text);
  if SaveDlg.Execute then
    edtPathXML.Text:=SaveDlg.FileName;
end;

procedure TA171FXMLVisiteFiscali.dCmbRepComuneKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA171FXMLVisiteFiscali.dEdtInizioMalExit(Sender: TObject);
begin
  inherited;
  with A171FXMLVisiteFiscaliDM do
  begin
    A171MW.VerificaPeriodoMalT049(dEdtInizioMal.Text, dEdtFineMal.Text);
    //Se il dataset è in edit(modifico lo stato del check MALATTIA_FERIE)
    if selT049.State in [dsInsert, dsEdit] then
    begin
      A171MW.T049PeriodoMalattiaDa:=selT049.FieldByName('INIZIO_MAL').AsDateTime;
      A171MW.T049PeriodoMalattiaA:=selT049.FieldByName('FINE_MAL').AsDateTime;
      selT049.FieldByName('MALATTIA_FERIE').AsString:=A171MW.PeriodoMalattiaInFerie(selT049.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;
end;

procedure TA171FXMLVisiteFiscali.btnCopiaConfigClick(Sender: TObject);
begin
  inherited;
  btnAnomalie.Enabled:=False;
  with A171FXMLVisiteFiscaliDM do
  begin
    A171MW.ControlliCopia;
    if R180MessageBox('Attenzione: i nuovi dati ' +  A171MW.updMessaggio + ' verranno estesi a tutte le visite presenti in griglia. Confermi l''operazione?',DOMANDA) = mrYes then
      A171MW.CopiaConfigurazione;
    selT049.Refresh;
  end;
end;

procedure TA171FXMLVisiteFiscali.btnGeneraXMLClick(Sender: TObject);
begin
  inherited;
  btnAnomalie.Enabled:=False;
  with A171FXMLVisiteFiscaliDM.A171MW do
  begin
    //Operazion iniziali
    RichiedenteCognome:=edtRichiedenteCognome.Text;
    RichiedenteNome:=edtRichiedenteNome.Text;
    RichiedenteCodFiscale:=edtRichiedenteCodFiscale.Text;
    RichiedenteEMail:=edtEMail.Text;
    RichiedenteTelefono:=PulisciNumero(edtTelefono.Text);
    NomeFile:=edtPathXML.Text;
    Controlli;
    //Genero i file Xml
    A171FXMLVisiteFiscaliDM.selT049.DisableControls;
    Screen.Cursor:=crHourGlass;
    GeneraXML;
    //Imposto il flag elaborato uguale a S per tutti i record presenti nel periodo
    if not RegistraMsg.ContieneTipoA then
      SetElaborato;
    Screen.Cursor:=crDefault;
    A171FXMLVisiteFiscaliDM.selT049.Refresh;
    A171FXMLVisiteFiscaliDM.selT049.EnableControls;
  end;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if RegistraMsg.ContieneTipoA then
  begin
    if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then  //'Elaborazione terminata con anomalie. Si desidera visualizzarle?'
      btnAnomalieClick(nil);
  end
  else
  begin
    if A171FXMLVisiteFiscaliDM.A171MW.NumCertificato > 0 then
      R180MessageBox(Format(A000MSG_A171_MSG_FMT_FINEELAB,[IntToStr(A171FXMLVisiteFiscaliDM.A171MW.NumCertificato + 1)]), INFORMA)
    else
      R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA, INFORMA);
  end;
end;

{ DataF }
function TA171FXMLVisiteFiscali._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA171FXMLVisiteFiscali._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ----DataF }
{ DataI }
function TA171FXMLVisiteFiscali._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA171FXMLVisiteFiscali._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ----DataI }

end.
