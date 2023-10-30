unit WA171UXMLVisiteFiscali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, C180FunzioniGenerali, A000UInterfaccia,
  medpIWMessageDlg, IWAdvRadioGroup, meTIWAdvRadioGroup, meIWImageFile,
  medpIWImageButton, OracleData, IWGlobal, A000UMessaggi, WC020UInputDataOreFM,
  Winapi.ActiveX, IWApplication, System.IOUtils, A000UCostanti, Oracle;

type
  TWA171FXMLVisiteFiscali = class(TWR102FGestTabella)
    edtFiltroPeriodoA: TmeIWEdit;
    edtFiltroPeriodoDa: TmeIWEdit;
    rdgFiltroElaborato: TmeTIWAdvRadioGroup;
    btnAnomalie: TmedpIWImageButton;
    lblFiltroPeriodoDa: TmeIWLabel;
    lblFiltroPeriodoA: TmeIWLabel;
    grpInfoRichiedente: TmeIWLabel;
    lblRichiedenteCognome: TmeIWLabel;
    lblRichiedenteNome: TmeIWLabel;
    lblRichiedenteCodFiscale: TmeIWLabel;
    lblEMail: TmeIWLabel;
    lblTelefono: TmeIWLabel;
    edtRichiedenteCognome: TmeIWEdit;
    edtRichiedenteNome: TmeIWEdit;
    edtRichiedenteCodFiscale: TmeIWEdit;
    edtEMail: TmeIWEdit;
    edtTelefono: TmeIWEdit;
    btnGeneraXML: TmedpIWImageButton;
    actCancellaVisite: TAction;
    btnAggiorna: TmeIWButton;
    actCaricaVisite: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure rdgFiltroElaboratoClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure btnGeneraXMLClick(Sender: TObject);
    procedure actCancellaVisiteExecute(Sender: TObject);
    procedure edtFiltroPeriodoDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnAggiornaClick(Sender: TObject);
    procedure edtFiltroPeriodoAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure actCaricaVisiteExecute(Sender: TObject);
  private
    { Private declarations }
    procedure Caricamento(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure VisualizzaAnomalie(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultConfermaElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultInputCancellazione(Sender: TObject; Result: Boolean; Valore: String);
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
  end;

implementation

uses
  WA171UXMLVisiteFiscaliDM, WA171UXMLVisiteFiscaliBrowseFM,
  WA171UXMLVisiteFiscaliDettFM, A171UXMLVisiteFiscaliMW;

{$R *.dfm}

procedure TWA171FXMLVisiteFiscali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
  grdC700.WC700FM.ResultEvent:=ResultWC700;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.GestioneStoricizzata:=False;

  WR302DM:=TWA171FXMLVisiteFiscaliDM.Create(Self);
  WBrowseFM:=TWA171FXMLVisiteFiscaliBrowseFM.Create(Self);
  WDettaglioFM:=TWA171FXMLVisiteFiscaliDettFM.Create(Self);

  CreaTabDefault;

//  grdTabControl.ActiveTab:=WDettaglioFM;
  GetParametriFunzione;
  (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.SelAnagrafe:=grdC700.selAnagrafe;
  edtFiltroPeriodoDa.Text:=DateToStr(Trunc(R180SysDate(SessioneOracle)));
  edtFiltroPeriodoA.Text:=DateToStr(Trunc(R180SysDate(SessioneOracle)));
  btnAggiornaClick(nil);
  rdgFiltroElaboratoClick(nil);
end;

function TWA171FXMLVisiteFiscali.InizializzaAccesso:Boolean;
begin
  Result:=True;
end;

procedure TWA171FXMLVisiteFiscali.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA171FXMLVisiteFiscali.rdgFiltroElaboratoClick(Sender: TObject);
begin
  inherited;
  case rdgFiltroElaborato.ItemIndex of
    0: (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.T049FiltroElaborato:='';   //'Tutto'
    1: (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.T049FiltroElaborato:='S';  //'Elaborato'
    2: (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.T049FiltroElaborato:='N';  //'Da elaborare'
  end;
  (WDettaglioFM as TWA171FXMLVisiteFiscaliDettFM).lblNominativo.Caption:='';
  (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.OpenSelT049;
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWA171FXMLVisiteFiscali.edtFiltroPeriodoAAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnAggiorna.HTMLName]));
end;

procedure TWA171FXMLVisiteFiscali.edtFiltroPeriodoDaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnAggiorna.HTMLName]));
end;

procedure TWA171FXMLVisiteFiscali.btnAggiornaClick(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.VerificaPeriodoT049(StrToDate(edtFiltroPeriodoDa.Text), StrToDate(edtFiltroPeriodoA.Text));
  (WDettaglioFM as TWA171FXMLVisiteFiscaliDettFM).lblNominativo.Caption:='';
  (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.OpenSelT049;
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWA171FXMLVisiteFiscali.GetParametriFunzione;
begin
  edtRichiedenteCognome.Text:=C004DM.GetParametro(edtRichiedenteCognome,'');
  edtRichiedenteNome.Text:=C004DM.GetParametro(edtRichiedenteNome,'');
  edtRichiedenteCodFiscale.Text:=C004DM.GetParametro(edtRichiedenteCodFiscale,'');
  edtEMail.Text:=C004DM.GetParametro(edtEMail,'');
  edtTelefono.Text:=C004DM.GetParametro(edtTelefono,'');
end;

procedure TWA171FXMLVisiteFiscali.PutParametriFunzione;
begin
  C004DM.Cancella001;
  C004DM.PutParametro(edtRichiedenteCognome,edtRichiedenteCognome.Text);
  C004DM.PutParametro(edtRichiedenteNome,edtRichiedenteNome.Text);
  C004DM.PutParametro(edtRichiedenteCodFiscale,edtRichiedenteCodFiscale.Text);
  C004DM.PutParametro(edtEMail,edtEMail.Text);
  C004DM.PutParametro(edtTelefono,edtTelefono.Text);
  SessioneOracle.Commit;
end;

procedure TWA171FXMLVisiteFiscali.actCancellaVisiteExecute(Sender: TObject);
begin
  inherited;
  MsgBox.WebMessageDlg((WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.T049MessaggioCancellazione,mtConfirmation,[mbYes,mbNo],ResultConfermaElimina,'');
end;

procedure TWA171FXMLVisiteFiscali.ResultConfermaElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
var
  WC020FInputDataOreFM: TWC020FInputDataOreFM;
begin
  if Res = mrYes then
  begin
    WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
    WC020FInputDataOreFM.ImpostaCampiText('Inserire il numero di visite fiscali che verranno cancellate:','0');
    WC020FInputDataOreFM.ResultEvent:=ResultInputCancellazione;
    WC020FInputDataOreFM.Visualizza('Cancellazione di ' + IntToStr((WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.RecordCount) + ' visite fiscali');
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA171FXMLVisiteFiscali.ResultInputCancellazione(Sender: TObject; Result: Boolean; Valore: String);
begin
  if Result then
  begin
    if (Valore <> IntToStr((WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.RecordCount)) then
    begin
      MsgBox.WebMessageDlg(A000MSG_MSG_OPERAZIONE_ANNULLATA,mtInformation,[mbOk],nil,'');
      MsgBox.ClearKeys;
      Exit;
    end;
    (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.CancellaPeriodoVisiteT049;
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.Refresh;
    WBrowseFM.grdTabella.medpAggiornaCDS;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA171FXMLVisiteFiscali.actModificaExecute(Sender: TObject);
begin
  if WR302DM.selTabella.RecordCount <= 0 then
    raise Exception.Create('Nessun dipendente selezionato!')
  else
    inherited;
end;

procedure TWA171FXMLVisiteFiscali.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';
  AccediForm(201,Params,False);
end;

procedure TWA171FXMLVisiteFiscali.ResultWC700(Sender: TObject; Result: Boolean);
begin
  if Result then
  begin
    if grdC700.selAnagrafe.RecordCount <= 0 then
      raise Exception.Create(A000MSG_ERR_NO_DIP);
    MsgBox.WebMessageDlg(Format(A000MSG_A171_DLG_FMT_INSERIMENTO,[IntToStr(grdC700.selAnagrafe.RecordCount)]),mtConfirmation,[mbYes,mbNo],Caricamento,'False');  //'Verranno inseriti %d dipendenti. Continuare?'
  end;
end;

procedure TWA171FXMLVisiteFiscali.actCaricaVisiteExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.selT047.Close;
  (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.selT047.Open;
  if (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.selT047.RecordCount <= 0 then
    raise Exception.Create(A000MSG_A171_ERR_NO_VISITE);  //Non sono presenti visite fiscali da caricare in data odierna!
  MsgBox.WebMessageDlg(Format(A000MSG_A171_DLG_FMT_INSERIMENTO,[IntToStr((WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.selT047.RecordCount)]),mtConfirmation,[mbYes,mbNo],Caricamento,'True');  //'Verranno inserite %s richieste visite fiscali. Continuare?';
end;

procedure TWA171FXMLVisiteFiscali.Caricamento(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    btnAnomalie.Enabled:=False;
    if KI = 'False' then
      (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.InsDipSuT049(False)
    else
      (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.InsDipSuT049(True);
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.Refresh;
    rdgFiltroElaborato.ItemIndex:=2;
    edtFiltroPeriodoDa.Text:=DateToStr(Trunc(R180SysDate(SessioneOracle)));
    edtFiltroPeriodoA.Text:=DateToStr(Trunc(R180SysDate(SessioneOracle)));
    btnAggiornaClick(nil);
    rdgFiltroElaboratoClick(nil);
    btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoI;
    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoI then
    begin
      MsgBox.WebMessageDlg(A000MSG_DLG_ELAB_ANOM_SEGNAL_VIS,mtConfirmation,[mbYes,mbNo],VisualizzaAnomalie,''); //Elaborazione terminata con anomalie e informazioni. Si desidera visualizzarle?
      Abort;
    end
    else
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA,mtInformation,[mbOK],nil,'');
  end;
end;

procedure TWA171FXMLVisiteFiscali.VisualizzaAnomalie(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res <> mrYes then
    MsgBox.ClearKeys
  else
    btnAnomalieClick(nil);
end;

procedure TWA171FXMLVisiteFiscali.WC700AperturaSelezione(Sender: TObject);
begin
  inherited;
  try
    grdC700.WC700FM.C700DataLavoro:=Trunc(R180SysDate(SessioneOracle));
  except
    grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA171FXMLVisiteFiscali.btnGeneraXMLClick(Sender: TObject);
var i:Integer;
begin
  inherited;
  btnAnomalie.Enabled:=False;
  with (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW do
  begin
    //Operazion iniziali
    RichiedenteCognome:=edtRichiedenteCognome.Text;
    RichiedenteNome:=edtRichiedenteNome.Text;
    RichiedenteCodFiscale:=edtRichiedenteCodFiscale.Text;
    RichiedenteEMail:=edtEMail.Text;
    RichiedenteTelefono:=PulisciNumero(edtTelefono.Text);
    { DONE : TEST IW 14 OK }
    // NomeFile:=gSC.UserCacheDir + 'VisiteFiscali.xml';
    NomeFile:=gGetWebApplicationThreadVar.UserCacheDir + 'VisiteFiscali.xml';
    Controlli;
    //Genero i file Xml
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.DisableControls;
    if Not IsLibrary then
      CoInitialize(nil);
    GeneraXML;
    if Not IsLibrary then
      CoUninitialize;
    //Imposto il flag elaborato uguale a S per tutti i record presenti nel periodo
    if not RegistraMsg.ContieneTipoA then
      SetElaborato;
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.Refresh;
    (WR302DM as TWA171FXMLVisiteFiscaliDM).selTabella.EnableControls;
    WBrowseFM.grdTabella.medpAggiornaCDS;
    for i:=0 to ElencoFile.Count -1 do
    begin
      NomeFileGenerato:=ElencoFile.Strings[i];
      InviaFileGenerato;
    end;
  end;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if RegistraMsg.ContieneTipoA then
  begin
    MsgBox.WebMessageDlg(A000MSG_DLG_ELAB_ANOMALIE_VIS,mtConfirmation,[mbYes,mbNo],VisualizzaAnomalie,''); //Elaborazione terminata con anomalie. Si desidera visualizzarle?
    Abort;
  end
  else
  begin
    if (WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.NumCertificato > 0 then
      MsgBox.WebMessageDlg(Format(A000MSG_A171_MSG_FMT_FINEELAB,[IntToStr((WR302DM as TWA171FXMLVisiteFiscaliDM).A171MW.NumCertificato + 1)]),mtInformation,[mbOK],nil,'')
    else
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA,mtInformation,[mbOK],nil,'');
  end;
end;

end.
