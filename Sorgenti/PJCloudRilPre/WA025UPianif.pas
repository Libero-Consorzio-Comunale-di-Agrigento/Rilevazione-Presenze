unit WA025UPianif;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, WR103UGestMasterDetail, medpIWMessageDlg, A000UMessaggi, B021UWebSvcClientDtM, System.Actions, meIWImageFile,
  IWCompEdit, meIWEdit, Oracle;

type
  TWA025FPianif = class(TWR102FGestTabella)
    actRegistra: TAction;
    actCancPianificazione: TAction;
    actVisualizzaAnomalie: TAction;
    actAcquisizioneTurni: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actRegistraExecute(Sender: TObject);
    procedure actCancPianificazioneExecute(Sender: TObject);
    procedure actVisualizzaAnomalieExecute(Sender: TObject);
    procedure actAcquisizioneTurniExecute(Sender: TObject);
  private
    DataCorr:TDateTime;
    ElaborazioneB021WebSvc: Boolean;
    B021FWebSvcClientDtM:TB021FWebSvcClientDtM;
    EsistonoMsgAnomalie:Boolean;
    FTipoElaborazione: String;
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    procedure FineCicloElaborazione; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure ResultInserisci(Sender: TObject; R: TmeIWModalResult; KI: String);
    // procedure RefreshPagina(Sender: TObject; R: TmeIWModalResult; KI: String);
    function ElementoSuccessivo: Boolean; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ResultAnomalie(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultAcquisTurni(Sender: TObject; R: TmeIWModalResult; KI: String);
    function ElaborazioneTerminata: String; override;
    procedure InizializzaMsgElaborazione; override;
    procedure AfterElaborazione; override;
  public
    DataDa,DataA:TDateTime;
    function InizializzaAccesso: Boolean; override;
    procedure InsPianif(DataPianifDa,DataPIanifA:TDateTime);
  end;

implementation

uses WA025UPianifDM, WA025UPianifBrowseFM, A000UInterfaccia;

{$R *.dfm}

procedure TWA025FPianif.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  actAcquisizioneTurni.Visible:=(Parametri.CampiRiferimento.C30_WebSrv_A025_URL_GET <> '') and (Parametri.CampiRiferimento.C30_WebSrv_A025_URL_PUT <> '');
  actVisualizzaAnomalie.Visible:=actAcquisizioneTurni.Visible;
  actVisualizzaAnomalie.Enabled:=False;
  ElaborazioneB021WebSvc:=False;

  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA025FPianifDM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWA025FPianifDM).A025MW.SelAnagrafe:=grdC700.selAnagrafe;
  WBrowseFM:=TWA025FPianifBrowseFM.Create(Self);
  (*
  Massimo: aggiunto richiamo a WC700CambioProgressivo perchè solo a questo punto la SelAnagrafe è sicronizzata
  con quella della grdC700 e WBrowseFM è creato;
  WC700CambioProgressivo viene già chiamato in precedenza da AttivaGestioneC700, però nel nostro caso non basta
  perchè la prima volta WBrowseFM è nil quindi non viene eseguito nulla.
  *)
  WC700CambioProgressivo(Sender);
  EsistonoMsgAnomalie:=False;
end;

function TWA025FPianif.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
  sDataDa, sDataA, sDaCartellino: String;
begin
  Result:=False;
  //Deve prendere il progressivo selezionato da parametro (passato da WA023)
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  sDataDa:=GetParam('DATADA');
  sDataA:=GetParam('DATAA');
  sDaCartellino:=GetParam('DACARTELLINO');
  if sDataDa <> '' then
  begin
    with (WBrowseFM as TWA025FPianifBrowseFM) do
    begin
      edtDataDa.Text:=sDataDa;
      edtDataA.Text:=sDataA;
      btnVisualizzaClick(nil);
    end;
  end;

  if ((WR302DM as TWA025FPianifDM).SelTabella.recordCount = 0) and (not SolaLettura) and (UpperCase(sDaCartellino) = 'TRUE')  then
  begin
    try
      (WBrowseFM as TWA025FPianifBrowseFM).DaCartellino:=True;
      actNuovoExecute(actNuovo);
    except
    end;
  end;
  Result:=True;
end;

procedure TWA025FPianif.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  if (WBrowseFM as TWA025FPianifBrowseFM) <> nil then
     (WBrowseFM as TWA025FPianifBrowseFM).btnVisualizzaClick(nil);
end;

function TWA025FPianif.TotalRecordsElaborazione: Integer;
begin
  if ElaborazioneB021WebSvc then
    Result:=grdC700.selAnagrafe.RecordCount
  else
    Result:=Round(DataA) - Round(DataDa) +1;
end;

procedure TWA025FPianif.actAcquisizioneTurniExecute(Sender: TObject);
{2 fasi:
 - Chiamata servizio firlab 'Calendar' in get
 - Chiamata nostro servizio 'Turni' in put passando il risultato della chiamata precedente
}
begin
  inherited;
  if grdC700.selAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP)
  else
  begin
    if not MsgBox.KeyExists('AcquisTurni') then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A025_DLG_FMT_ACQUISIZ_TURNI,[(WBrowseFM as TWA025FPianifBrowseFM).edtDataDa.Text,(WBrowseFM as TWA025FPianifBrowseFM).edtDataA.Text]),mtConfirmation,[mbYes,mbNo],ResultAcquisTurni,'AcquisTurni');
      Abort;
    end;
  end;
  ElaborazioneB021WebSvc:=True;
  B021FWebSvcClientDtM:=TB021FWebSvcClientDtM.Create(nil);

  FTipoElaborazione:=actAcquisizioneTurni.Name;
  StartElaborazioneCiclo(btnSendFile.HTMLName);
end;

procedure TWA025FPianif.InizioElaborazione;
begin
  inherited;
  if ElaborazioneB021WebSvc then
  begin
    actVisualizzaAnomalie.Enabled:=False;
  end;
end;

procedure TWA025FPianif.ResultAcquisTurni(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R <> mrYes then
  begin
    MsgBox.ClearKeys;
    exit;
  end
  else
    actAcquisizioneTurniExecute(Sender);
end;

procedure TWA025FPianif.ResultAnomalie(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    actVisualizzaAnomalieExecute(nil);
end;

procedure TWA025FPianif.actCancPianificazioneExecute(Sender: TObject);
begin
  (WBrowseFM as TWA025FPianifBrowseFM).btnInserisciClick(Sender);
end;

procedure TWA025FPianif.actRegistraExecute(Sender: TObject);
begin
  inherited;
  (WBrowseFM as TWA025FPianifBrowseFM).btnInserisciClick(Sender);
end;

procedure TWA025FPianif.actVisualizzaAnomalieExecute(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda +
          ',OPERATORE=' + Parametri.Operatore +
          ',MASCHERA=A040WEBSRV'+
          ',ID=' + IntToStr(RegistraMsg.ID);
  accediForm(201,Params,False);
end;

procedure TWA025FPianif.ElaboraElemento;
begin
  if ElaborazioneB021WebSvc then
    B021FWebSvcClientDtM.WebSvcRecordT080(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                                        grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString,
                                        StrToDate((WBrowseFM as TWA025FPianifBrowseFM).edtDataDa.Text),
                                        StrToDate((WBrowseFM as TWA025FPianifBrowseFM).edtDataA.Text))
  else
  begin
    (WR302DM as TWA025FPianifDM).A025MW.DataCorrente:=DataCorr;
    with (WBrowseFM as TWA025FPianifBrowseFM) do
      if (CmbOrario.Text <> '') or (CmbIndennita.Text <> '') or
         (CmbDatoLibero.Text <> '') then
        (WR302DM as TWA025FPianifDM).A025MW.InserisciPianificazione
      else
        (WR302DM as TWA025FPianifDM).A025MW.AggiornaPianificazione;
    DataCorr:=DataCorr+1;
  end;
  SessioneOracle.Commit;
end;

function TWA025FPianif.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  if ElaborazioneB021WebSvc then
  begin
    grdC700.selAnagrafe.Next;
    if not grdC700.selAnagrafe.EOF then
    begin
      Result:=True;
    end;
  end
  else
    if DataCorr <= DataA then
    begin
      Result:=True;
    end;
end;

procedure TWA025FPianif.FineCicloElaborazione;
begin
  if not ElaborazioneB021WebSvc then
  begin
    with (WBrowseFM as TWA025FPianifBrowseFM) do
      if (CmbOrario.Text = '') and
         (CmbIndennita.Text = '') and
         (CmbDatoLibero.Text = '') then
        (WR302DM as TWA025FPianifDM).A025MW.CancellaT080(DataDa,DataA);
    SessioneOracle.Commit;
    (WR302DM as TWA025FPianifDM).A025MW.SetSelT080;
  end
  else
  begin
    ElaborazioneB021WebSvc:=False;
    EsistonoMsgAnomalie:=B021FWebSvcClientDtM.EsistonoMsgAnomalie;
    FreeAndNil(B021FWebSvcClientDtM);
    MsgBox.ClearKeys;
  end;
end;

procedure TWA025FPianif.InsPianif(DataPianifDa, DataPianifA: TDateTime);
begin
  DataDa:=DataPianifDa;
  DataA:=DataPianifA;
  if not MsgBox.KeyExists('ControlliInsPianificazione') then
  begin
    with (WR302DM as TWA025FPianifDM) do
    begin
      // Setto parametri MW
      A025MW.Turno1:=(WBrowseFM as TWA025FPianifBrowseFM).cmbTurno1.Text;
      A025MW.Turno2:=(WBrowseFM as TWA025FPianifBrowseFM).cmbTurno2.Text;
      A025MW.Orario:=(WBrowseFM as TWA025FPianifBrowseFM).CmbOrario.Text;
      A025MW.Turno1EU:=Trim((WBrowseFM as TWA025FPianifBrowseFM).cmbTurno1EU.Text);
      A025MW.Turno2EU:=Trim((WBrowseFM as TWA025FPianifBrowseFM).cmbTurno2EU.Text);
      A025MW.Turno1EUItemIndex:=(WBrowseFM as TWA025FPianifBrowseFM).CmbTurno1EU.ItemIndex;
      A025MW.Turno2EUItemIndex:=(WBrowseFM as TWA025FPianifBrowseFM).CmbTurno2EU.ItemIndex;
      A025MW.Indennita:=(WBrowseFM as TWA025FPianifBrowseFM).CmbIndennita.Text;
      A025MW.DatoLibero:=(WBrowseFM as TWA025FPianifBrowseFM).CmbDatoLibero.Text;
      A025MW.DatoLiberoCaption:=(WBrowseFM as TWA025FPianifBrowseFM).lblDatoLibero.Caption;
      A025MW.PulDatoChecked:=(WBrowseFM as TWA025FPianifBrowseFM).chkPulDato.Checked;
      A025MW.PulOrarioChecked:=(WBrowseFM as TWA025FPianifBrowseFM).chkPulOrario.Checked;
      A025MW.PulIndennitaChecked:=(WBrowseFM as TWA025FPianifBrowseFM).chkPulIndennita.Checked;
      A025MW.DatoLiberoEnabled:=(WBrowseFM as TWA025FPianifBrowseFM).CmbDatoLibero.Enabled;
      A025MW.ControlliInsPianificazione;
      (WBrowseFM as TWA025FPianifBrowseFM).CmbTurno1EU.ItemIndex:=A025MW.Turno1EUItemIndex;
      (WBrowseFM as TWA025FPianifBrowseFM).CmbTurno2EU.ItemIndex:=A025MW.Turno2EUItemIndex;
      A025MW.Turno1EU:=Trim((WBrowseFM as TWA025FPianifBrowseFM).cmbTurno1EU.Text);
      A025MW.Turno2EU:=Trim((WBrowseFM as TWA025FPianifBrowseFM).cmbTurno2EU.Text);
    end;
    MsgBox.WebMessageDlg(Format(A000MSG_A025_DLG_FMT_ESEGUI_INSERIMENTO,[DateToStr(DataDa),DateToStr(DataA)]),mtConfirmation,[mbYes,mbNo],ResultInserisci,'ControlliInsPianificazione');
    Abort;
  end;
  MsgBox.ClearKeys;

  // MsgBox.WebMessageDlg(ElaborazioneCicloServer,mtConfirmation,[mbOK],RefreshPagina,'')
  FTipoElaborazione:='INSPIANIF';
  StartElaborazioneCicloServer(btnSendFile.HTMLName);
end;

//procedure TWA025FPianif.RefreshPagina(Sender: TObject; R: TmeIWModalResult; KI: String);
//begin
//  (WBrowseFM as TWA025FPianifBrowseFM).grdTabella.medpAggiornaCDS(True);
//end;

procedure TWA025FPianif.ResultInserisci(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    DataCorr:=DataDa;
    InsPianif(DataDa,DataA);
  end
  else
    MsgBox.ClearKeys;
end;

function TWA025FPianif.ElaborazioneTerminata: String;
begin
  Result:=inherited;
  if ElaborazioneB021WebSvc and EsistonoMsgAnomalie then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
end;

procedure TWA025FPianif.InizializzaMsgElaborazione;
begin
  WC022FMsgElaborazioneFM.Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
  WC022FMsgElaborazioneFM.Titolo:=A000MSG_MSG_ELABORAZIONE;
  WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_ELABORAZIONE;
end;

procedure TWA025FPianif.AfterElaborazione;
begin
  inherited;
  if FTipoElaborazione = 'INSPIANIF' then
  begin
    (WBrowseFM as TWA025FPianifBrowseFM).grdTabella.medpAggiornaCDS(True);
  end;
end;

end.
