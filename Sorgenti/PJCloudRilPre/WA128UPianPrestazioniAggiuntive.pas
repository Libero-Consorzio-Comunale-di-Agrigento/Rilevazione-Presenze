unit WA128UPianPrestazioniAggiuntive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, OracleData,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWCompEdit, meIWEdit,
  WA128UInserimentoFM, medpIWC700NavigatorBar, C180FunzioniGenerali,
  A000UInterfaccia, StrUtils, WC700USelezioneAnagrafeFM, IWApplication,
  WA128UAcqFilePrestazioniAggiuntiveFM, A000UMessaggi, Oracle, System.Actions;

type
  TWA128FPianPrestazioniAggiuntive = class(TWR102FGestTabella)
    lblContratto: TmeIWLabel;
    btnCambioData: TmeIWButton;
    lblAnno: TmeIWLabel;
    edtAnno: TmeIWEdit;
    lblMese: TmeIWLabel;
    edtMese: TmeIWEdit;
    grdTabDetail: TmedpIWTabControl;
    lblPartTime: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCambioDataClick(Sender: TObject);
    procedure grdTabDetailTabControlChange(Sender: TObject);
  private
    WA128Ins:TWA128FInserimentoFM;
    WA128Acq:TWA128FAcqFilePrestazioniAggiuntiveFM;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    procedure AbilitaAzioni(Abilita: Boolean);
  public
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure AbilitaComponenti(Abilita: Boolean);
  protected
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
  end;

implementation

uses WA128UPianPrestazioniAggiuntiveDM, WA128UPianPrestazioniAggiuntiveBrowseFM;

{$R *.dfm}

procedure TWA128FPianPrestazioniAggiuntive.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA128FPianPrestazioniAggiuntiveDM.Create(Self);
  WBrowseFM:=TWA128FPianPrestazioniAggiuntiveBrowseFM.Create(Self);
  WA128Ins:=TWA128FInserimentoFM.Create(Self);
  WA128Acq:=TWA128FAcqFilePrestazioniAggiuntiveFM.Create(Self);
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Danilo: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.selAnagrafe:=grdC700.selAnagrafe;
  AttivaGestioneC700;
  grdC700.WC700FM.ResultEvent:=ResultWC700;

  grdTabDetail.AggiungiTab('Tabella',WBrowseFM);
  grdTabDetail.AggiungiTab('Gestione mensile',WA128Ins);
  grdTabDetail.AggiungiTab('Acquisizione da file',WA128Acq);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WBrowseFM;
  grdTabDetail.TabByIndex(1).Enabled:=not SolaLettura;
  grdTabDetail.TabByIndex(2).Enabled:=not SolaLettura;

  edtAnno.Text:=IntToStr(R180Anno(Parametri.DataLavoro));
  edtMese.Text:=IntToStr(R180Mese(Parametri.DataLavoro));
  with (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
  begin
    DataInizio:=EncodeDate(StrToIntDef(edtAnno.Text,1900),StrToIntDef(edtMese.Text,1),1);
    DataFine:=R180FineMese(DataInizio);
    grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
    ImpostaFiltro(SelAnagrafe.SQL.Text);
    RefreshSelT332;
    WA128Acq.edtInizioAcquisizione.Text:=DateToStr(DataInizio);
    WA128Acq.edtFineAcquisizione.Text:=DateToStr(DataFine);
  end;
  WA128Ins.clbGiorni.Items.Clear;
  GetParametriFunzione;
end;

procedure TWA128FPianPrestazioniAggiuntive.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(WA128Ins);//.Free;
  FreeAndNil(WA128Acq);//.Free;
  inherited;
end;

procedure TWA128FPianPrestazioniAggiuntive.IWAppFormRender(Sender: TObject);
begin
  inherited;
  AbilitaAzioni((grdTabDetail.ActiveTab = WBrowseFM) and not SolaLettura);
  grdC700.AbilitaToolbar(grdTabDetail.ActiveTab <> WA128Acq);
end;

procedure TWA128FPianPrestazioniAggiuntive.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ',T030.COGNOME||'' ''||T030.NOME NOMINATIVO';
  grdC700.WC700FM.C700SelezionePeriodica:=True;
end;

procedure TWA128FPianPrestazioniAggiuntive.GetParametriFunzione;
begin
  with WA128Acq do
  begin
    edtMatricolaPos.Text:=C004DM.GetParametro('MatricolaPos','1');
    edtMatricolaLun.Text:=C004DM.GetParametro('MatricolaLung','8');
    edtGiornoPos.Text:=C004DM.GetParametro('GiornoPos','9');
    edtGiornoLun.Text:=C004DM.GetParametro('GiornoLung','2');
    edtMesePos.Text:=C004DM.GetParametro('MesePos','11');
    edtMeseLun.Text:=C004DM.GetParametro('MeseLung','2');
    edtAnnoPos.Text:=C004DM.GetParametro('AnnoPos','13');
    edtAnnoLun.Text:=C004DM.GetParametro('AnnoLung','4');
    edtTurno1Pos.Text:=C004DM.GetParametro('Turno1Pos','17');
    edtTurno1Lun.Text:=C004DM.GetParametro('Turno1Lung','5');
    edtTurno2Pos.Text:=C004DM.GetParametro('Turno2Pos','22');
    edtTurno2Lun.Text:=C004DM.GetParametro('Turno2Lung','5');
    edtOraInizioTurno1Pos.Text:=C004DM.GetParametro('OraInizioTurno1Pos','27');
    edtOraInizioTurno1Lun.Text:=C004DM.GetParametro('OraInizioTurno1Lung','5');
    edtOraFineTurno1Pos.Text:=C004DM.GetParametro('OraFineTurno1Pos','32');
    edtOraFineTurno1Lun.Text:=C004DM.GetParametro('OraFineTurno1Lung','5');
    edtOraInizioTurno2Pos.Text:=C004DM.GetParametro('OraInizioTurno2Pos','37');
    edtOraInizioTurno2Lun.Text:=C004DM.GetParametro('OraInizioTurno2Lung','5');
    edtOraFineTurno2Pos.Text:=C004DM.GetParametro('OraFineTurno2Pos','42');
    edtOraFineTurno2Lun.Text:=C004DM.GetParametro('OraFineTurno2Lung','5');
    chkSovrascriviEsistenti.Checked:=C004DM.GetParametro('chkSovrascriviEsistenti','False') = 'True';
  end;
end;

procedure TWA128FPianPrestazioniAggiuntive.PutParametriFunzione;
begin
  C004DM.Cancella001;
  with WA128Acq do
  begin
    C004DM.PutParametro('MatricolaPos',edtMatricolaPos.Text);
    C004DM.PutParametro('MatricolaLung',edtMatricolaLun.Text);
    C004DM.PutParametro('GiornoPos',edtGiornoPos.Text);
    C004DM.PutParametro('GiornoLung',edtGiornoLun.Text);
    C004DM.PutParametro('MesePos',edtMesePos.Text);
    C004DM.PutParametro('MeseLung',edtMeseLun.Text);
    C004DM.PutParametro('AnnoPos',edtAnnoPos.Text);
    C004DM.PutParametro('AnnoLung',edtAnnoLun.Text);
    C004DM.PutParametro('Turno1Pos',edtTurno1Pos.Text);
    C004DM.PutParametro('Turno1Lung',edtTurno1Lun.Text);
    C004DM.PutParametro('Turno2Pos',edtTurno2Pos.Text);
    C004DM.PutParametro('Turno2Lung',edtTurno2Lun.Text);
    C004DM.PutParametro('OraInizioTurno1Pos',edtOraInizioTurno1Pos.Text);
    C004DM.PutParametro('OraInizioTurno1Lung',edtOraInizioTurno1Lun.Text);
    C004DM.PutParametro('OraFineTurno1Pos',edtOraFineTurno1Pos.Text);
    C004DM.PutParametro('OraFineTurno1Lung',edtOraFineTurno1Lun.Text);
    C004DM.PutParametro('OraInizioTurno2Pos',edtOraInizioTurno2Pos.Text);
    C004DM.PutParametro('OraInizioTurno2Lung',edtOraInizioTurno2Lun.Text);
    C004DM.PutParametro('OraFineTurno2Pos',edtOraFineTurno2Pos.Text);
    C004DM.PutParametro('OraFineTurno2Lung',edtOraFineTurno2Lun.Text);
    C004DM.PutParametro('chkSovrascriviEsistenti',IfThen(chkSovrascriviEsistenti.Checked, 'True', 'False'));
    try SessioneOracle.Commit; except end;
  end;
end;

procedure TWA128FPianPrestazioniAggiuntive.ResultWC700(Sender: TObject; Result: Boolean);
begin
  if Result then
    with (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
    begin
      ImpostaFiltro(selAnagrafe.SubstitutedSQL);
      RefreshSelT332;
      WBrowseFM.grdTabella.medpAggiornaCDS(True);
    end;
end;

procedure TWA128FPianPrestazioniAggiuntive.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
  begin
    CercaContratto(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataFine);
    lblContratto.Caption:='Contratto: ' + Q430Contratto.FieldByName('Contratto').AsString + ' ' + Q430Contratto.FieldByName('Descrizione').AsString;
    lblPartTime.Caption:='Part-time: ' + IfThen(Q430Contratto.FieldByName('PERCPT').AsFloat = 100,'Tempo pieno',Q430Contratto.FieldByName('PERCPT').AsString + '%');
  end;
end;

procedure TWA128FPianPrestazioniAggiuntive.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(True);
end;

procedure TWA128FPianPrestazioniAggiuntive.actModificaExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(False);
end;

procedure TWA128FPianPrestazioniAggiuntive.actNuovoExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(False);
end;

procedure TWA128FPianPrestazioniAggiuntive.AbilitaComponenti(Abilita:Boolean);
begin
  lblAnno.Enabled:=Abilita;
  edtAnno.Enabled:=Abilita;
  lblMese.Enabled:=Abilita;
  edtMese.Enabled:=Abilita;
  grdTabDetail.TabByIndex(1).Enabled:=Abilita;
  grdTabDetail.TabByIndex(2).Enabled:=Abilita;
end;

procedure TWA128FPianPrestazioniAggiuntive.AbilitaAzioni(Abilita:Boolean);
begin
  actNuovo.Enabled:=Abilita;
  actModifica.Enabled:=Abilita;
  actElimina.Enabled:=Abilita;
  actAggiorna.Enabled:=Abilita;
  actRicerca.Enabled:=Abilita;
  actEstrai.Enabled:=Abilita;
  actPrimo.Enabled:=Abilita;
  actPrecedente.Enabled:=Abilita;
  actSuccessivo.Enabled:=Abilita;
  actUltimo.Enabled:=Abilita;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWA128FPianPrestazioniAggiuntive.edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA128FPianPrestazioniAggiuntive.btnCambioDataClick(Sender: TObject);
var Prog:Integer;
begin
  with (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
  begin
    try
      StrToInt(edtAnno.Text);
    except
      edtAnno.Text:=IntToStr(R180Anno(Parametri.DataLavoro));
    end;
    try
      StrToInt(edtMese.Text);
    except
      edtMese.Text:=IntToStr(R180Mese(Parametri.DataLavoro));
    end;
    if (StrToIntDef(edtMese.Text,1) > 12)
    or (StrToIntDef(edtMese.Text,1) < 1) then
      edtMese.Text:=IntToStr(R180Mese(selT332.FieldByName('DATA').AsDateTime));
    if DataInizio <> EncodeDate(StrToIntDef(edtAnno.Text,1900),StrToIntDef(edtMese.Text,1),1) then
      WA128Ins.clbGiorni.Items.Clear;
    DataInizio:=EncodeDate(StrToIntDef(edtAnno.Text,1900),StrToIntDef(edtMese.Text,1),1);
    DataFine:=R180FineMese(DataInizio);
    grdC700.WC700FM.C700DataLavoro:=DataInizio;

    Prog:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataInizio,DataInizio) then
      SelAnagrafe.Close;
    SelAnagrafe.Open;
    RefreshSelT332;
    SelAnagrafe.SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
  AggiornaAnagr;
  WA128Ins.Visualizza;
end;

procedure TWA128FPianPrestazioniAggiuntive.grdTabDetailTabControlChange(Sender: TObject);
begin
  inherited;
  AbilitaAzioni(grdTabDetail.ActiveTab = WBrowseFM);
  grdC700.AbilitaToolbar(grdTabDetail.ActiveTab <> WA128Acq);
  if grdTabDetail.ActiveTab = WA128Ins then
    WA128Ins.Visualizza
  else if grdTabDetail.ActiveTab = WBrowseFM then
  begin
    (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.RefreshSelT332;
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA128FPianPrestazioniAggiuntive.InizioElaborazione;
begin
  inherited;
  WA128Acq.btnAnomalie.Enabled:=False;
  (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.nNumRiga:=0;
end;

function TWA128FPianPrestazioniAggiuntive.TotalRecordsElaborazione: Integer;
begin
  Result:=(WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.nTotRighe;
end;

function TWA128FPianPrestazioniAggiuntive.CurrentRecordElaborazione: Integer;
begin
  Result:=(WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.nNumRiga;
end;

procedure TWA128FPianPrestazioniAggiuntive.ElaboraElemento;
begin
  (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.InserisciPrestAgg(StrToDate(WA128Acq.edtInizioAcquisizione.Text),StrToDate(WA128Acq.edtFineAcquisizione.Text), WA128Acq.chkSovrascriviEsistenti.Checked);
  SessioneOracle.Commit;
end;

function TWA128FPianPrestazioniAggiuntive.ElementoSuccessivo: Boolean;
begin
  Result:=not Eof((WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.FIn);
end;

procedure TWA128FPianPrestazioniAggiuntive.FineCicloElaborazione;
begin
  CloseFile((WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.FIn);
  WA128Acq.btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
end;

function TWA128FPianPrestazioniAggiuntive.ElaborazioneTerminata: String;
begin
  if WA128Acq.btnAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

end.
