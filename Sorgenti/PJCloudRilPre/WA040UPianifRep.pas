unit WA040UPianifRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, OracleData,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, StrUtils, Math,
  IWCompJQueryWidget, IWCompCheckbox, meIWCheckBox, IWCompEdit, meIWEdit,
  C180FunzioniGenerali, A000UInterfaccia, A000UMessaggi, A000UCostanti,
  WA040UInserimentoFM, WA040UDialogStampaFM, medpIWMessageDlg, B021UWebSvcClientDtM,
  medpIWC700NavigatorBar, WC700USelezioneAnagrafeFM, IWApplication,
  System.Actions, meIWImageFile, C004UParamForm, ActiveX, Data.DB,
  Datasnap.DBClient, Datasnap.Win.MConnect, C190FunzioniGeneraliWeb, Oracle;

type
  TWA040FPianifRep = class(TWR102FGestTabella)
    lblAnno: TmeIWLabel;
    edtAnno: TmeIWEdit;
    lblMese: TmeIWLabel;
    edtMese: TmeIWEdit;
    chkNonContDipPian: TmeIWCheckBox;
    actVisualizzaAnomalie: TAction;
    actAcquisizioneTurni: TAction;
    btnCambioData: TmeIWButton;
    grdTabDetail: TmedpIWTabControl;
    DCOMConnection: TDCOMConnection;
    chkRecapitiAlternativi: TmeIWCheckBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCambioDataClick(Sender: TObject);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure actVisualizzaAnomalieExecute(Sender: TObject);
    procedure actAcquisizioneTurniExecute(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkRecapitiAlternativiAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    Tipologia:String;
    SaveProg,Progressivo:Integer;
    DataIniziale:TDateTime;
    EsistonoMsgAnomalie,CancellaTurniEsistenti:Boolean;
    WA040Ins:TWA040FInserimentoFM;
    WA040Stm:TWA040FDialogStampaFM;
    B021FWebSvcClientDtM:TB021FWebSvcClientDtM;
    C004DM_1:TC004FParamForm;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    procedure AbilitaAzioni(Abilita: Boolean);
    procedure ResultAcquisTurni(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultCancellaTurni(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
    procedure VisualizzaColonneRecapiti;
  public
    DataDa,DataA:TDateTime;
    function InizializzaAccesso: Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure AbilitaComponenti(Abilita: Boolean);
    procedure EseguiStampa;
    procedure ElaborazioneServer; override;
  protected
    procedure ImpostazioniWC700; override;
  end;

implementation

uses WA040UPianifRepDM, WA040UPianifRepBrowseFM;

{$R *.dfm}

procedure TWA040FPianifRep.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA040FPianifRepDM.Create(Self);
  WBrowseFM:=TWA040FPianifRepBrowseFM.Create(Self);
  WA040Ins:=TWA040FInserimentoFM.Create(Self);

  C004DM_1:=CreaC004(SessioneOracle,'WA040_1',Parametri.ProgOper,False);
  WA040Stm:=TWA040FDialogStampaFM.Create(Self);
  WA040Stm.A040MWStm:=(WR302DM as TWA040FPianifRepDM).A040MW;
  WA040Stm.C004DMStm:=C004DM_1;
  WA040Stm.evtEseguiStampa:=EseguiStampa;
  WA040Stm.OperazioniIniziali;

  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Danilo: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  (WR302DM as TWA040FPianifRepDM).A040MW.selAnagrafe:=grdC700.selAnagrafe;
  AttivaGestioneC700;
  grdC700.WC700FM.ResultEvent:=ResultWC700;

  grdTabDetail.AggiungiTab('Tabella',WBrowseFM);
  grdTabDetail.AggiungiTab('Gestione mensile',WA040Ins);
  grdTabDetail.AggiungiTab('Stampa',WA040Stm);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WBrowseFM;

  edtAnno.Text:=IntToStr(R180Anno(Parametri.DataLavoro));
  edtMese.Text:=IntToStr(R180Mese(Parametri.DataLavoro));
  with (WR302DM as TWA040FPianifRepDM).A040MW do
  begin
    DataInizio:=EncodeDate(StrToIntDef(edtAnno.Text,1900),StrToIntDef(edtMese.Text,1),1);
    DataFine:=R180FineMese(DataInizio);
    grdC700.WC700FM.C700DataDal:=DataInizio;
    grdC700.WC700FM.C700DataLavoro:=DataFine;
  end;
  EsistonoMsgAnomalie:=False;
end;

function TWA040FPianifRep.InizializzaAccesso: Boolean;
begin
  Tipologia:=GetParam('Tipologia');

  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  DataIniziale:=DATE_NULL;
  if (not GetParam('Data').IsEmpty) and  (not TryStrToDate(GetParam('Data'),DataIniziale)) then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_DATA_NON_VALIDA),[GetParam('Data')]));

  with (WR302DM as TWA040FPianifRepDM),A040MW do
  begin
    if Tipologia <> '' then
      CodTipologia:=IfThen(Tipologia = 'REPERIB','R','G');
    Self.Title:='(WA040) Pianificazione turni ' + IfThen(CodTipologia = 'R','reperibilità','guardia');
    SetTag(IfThen(CodTipologia = 'R',16,63));
    grdTabDetail.TabByIndex(1).Enabled:=not SolaLettura;
    selTabella.Close;
    ImpostaFiltro(SelAnagrafe.SQL.Text);
    if Progressivo > 0 then
    begin
      grdC700.WC700FM.C700Progressivo:=Progressivo;
      grdC700.WC700FM.actConfermaExecute(nil);
    end;

    if DataIniziale > 0 then
    begin
      edtAnno.Text:=IntToStr(R180Anno(DataIniziale));
      edtMese.Text:=IntToStr(R180Mese(DataIniziale));
    end;
    RefreshT380;
    selTabella.Open;
    ImpostaTipologiaDataSet;
    VisualizzaCampi;
    WBrowseFM.grdTabella.Summary:='Pianificazione turni ' + IfThen(CodTipologia = 'R','reperibilità','guardia');
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
    chkNonContDipPian.Checked:=C004DM.GetParametro('chkNonContDipPian','N') = 'S';
    chkRecapitiAlternativi.Checked:=C004DM.GetParametro('chkRecapitiAlternativi','N') = 'S';
    actAcquisizioneTurni.Visible:=(not SolaLettura) and (CodTipologia = 'R') and (Parametri.CampiRiferimento.C30_WebSrv_A025_URL_GET <> '') and (Parametri.CampiRiferimento.C30_WebSrv_A025_URL_PUT <> '');
    actVisualizzaAnomalie.Visible:=actAcquisizioneTurni.Visible;
    actVisualizzaAnomalie.Enabled:=False;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    selT380.FieldByName('DATOLIBERO').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile);
    chkRecapitiAlternativi.Visible:=CodTipologia = 'R';
  end;
  WBrowseFM.grdTabella.medpCreaColonne;
  WA040Ins.clbGiorni.Items.Clear;
  Result:=True;
end;

procedure TWA040FPianifRep.IWAppFormDestroy(Sender: TObject);
begin
  SessioneOracle.Rollback;
  C004DM.Cancella001;
  C004DM.PutParametro('chkNonContDipPian',IfThen(chkNonContDipPian.Checked,'S','N'));
  C004DM.PutParametro('chkRecapitiAlternativi',IfThen(chkRecapitiAlternativi.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
  Wa040Stm.ReleaseOggetti;
  FreeAndNil(C004DM_1);
  FreeAndNil(B021FWebSvcClientDtM);
  FreeAndNil(WA040Stm);//.Free;
  FreeAndNil(WA040Ins);//.Free;
  inherited;
end;

procedure TWA040FPianifRep.IWAppFormRender(Sender: TObject);
begin
  inherited;
  if (grdTabDetail.ActiveTab = WA040Ins) or (grdTabDetail.ActiveTab = WA040Stm) then
    AbilitaAzioni(False);
  VisualizzaColonneRecapiti;
end;

procedure TWA040FPianifRep.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ',T030.COGNOME||'' ''||T030.NOME NOMINATIVO, T430CONTRATTO, T430D_CONTRATTO';
  grdC700.WC700FM.C700SelezionePeriodica:=True;
end;

procedure TWA040FPianifRep.ResultWC700(Sender: TObject; Result: Boolean);
begin
  if Result then
    with (WR302DM as TWA040FPianifRepDM).A040MW do
    begin
      ImpostaFiltro(selAnagrafe.SubstitutedSQL);
      RefreshT380;
      WBrowseFM.grdTabella.medpAggiornaCDS(True);
    end;
end;

procedure TWA040FPianifRep.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA040FPianifRepDM).A040MW do
    CercaContratto(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataFine);
end;

procedure TWA040FPianifRep.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(True);
end;

procedure TWA040FPianifRep.actModificaExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(False);
end;

procedure TWA040FPianifRep.actNuovoExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(False);
end;

procedure TWA040FPianifRep.AbilitaComponenti(Abilita:Boolean);
begin
  lblAnno.Enabled:=Abilita;
  edtAnno.Enabled:=Abilita;
  lblMese.Enabled:=Abilita;
  edtMese.Enabled:=Abilita;
  chkNonContDipPian.Enabled:=Abilita;
  chkRecapitiAlternativi.Enabled:=Abilita;
  grdTabDetail.TabByIndex(1).Enabled:=Abilita;
  grdTabDetail.TabByIndex(2).Enabled:=Abilita;
end;

procedure TWA040FPianifRep.AbilitaAzioni(Abilita:Boolean);
begin
  actVisualizzaAnomalie.Enabled:=Abilita and EsistonoMsgAnomalie;
  actAcquisizioneTurni.Enabled:=Abilita;
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

procedure TWA040FPianifRep.edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA040FPianifRep.btnCambioDataClick(Sender: TObject);
var Prog:Integer;
begin
  with (WR302DM as TWA040FPianifRepDM).A040MW do
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
      edtMese.Text:=IntToStr(R180Mese(selT380.FieldByName('DATA').AsDateTime));
    if DataInizio <> EncodeDate(StrToIntDef(edtAnno.Text,1900),StrToIntDef(edtMese.Text,1),1) then
      WA040Ins.clbGiorni.Items.Clear;
    DataInizio:=EncodeDate(StrToIntDef(edtAnno.Text,1900),StrToIntDef(edtMese.Text,1),1);
    DataFine:=R180FineMese(DataInizio);
    grdC700.WC700FM.C700DataDal:=DataInizio;
    grdC700.WC700FM.C700DataLavoro:=DataFine;
    DataSt:=DataInizio;

    Prog:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataInizio,DataFine) then
      SelAnagrafe.Close;
    SelAnagrafe.Open;
    RefreshT380;
    SelAnagrafe.SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
    //Gestione del dato libero storico
    with selDatoLibero do
      if Active and (VariableIndex('DECORRENZA') >= 0) then
      begin
        SetVariable('DECORRENZA',DataFine);
        Close;
        Open;
        WA040Ins.cmbDatoLibero.Items.Clear;
      end;
  end;
  AggiornaAnagr;
  if (grdTabDetail.ActiveTab = WA040Ins) or (grdTabDetail.ActiveTab = WA040Stm) then
    grdC700.AbilitaToolBar(False);
  WA040Ins.Visualizza;
  WA040Stm.Visualizza;
end;

procedure TWA040FPianifRep.chkRecapitiAlternativiAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  VisualizzaColonneRecapiti;
end;

procedure TWA040FPianifRep.grdTabDetailTabControlChange(Sender: TObject);
begin
  inherited;
  if grdTabDetail.ActiveTab = WA040Ins then
  begin
    grdC700.AbilitaToolBar(False);
    WA040Ins.Visualizza;
    AbilitaAzioni(False);
  end
  else if grdTabDetail.ActiveTab = WA040Stm then
  begin
    grdC700.AbilitaToolBar(False);
    (WR302DM as TWA040FPianifRepDM).A040MW.DataSt:=(WR302DM as TWA040FPianifRepDM).A040MW.DataInizio;
    WA040Stm.Visualizza;
    AbilitaAzioni(False);
  end
  else
  begin
    grdC700.AbilitaToolBar(True);
    AbilitaAzioni(True);
    (WR302DM as TWA040FPianifRepDM).A040MW.RefreshT380;
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA040FPianifRep.actVisualizzaAnomalieExecute(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
          'MASCHERA=A040WEBSRV';
  accediForm(201,Params,False);
end;

procedure TWA040FPianifRep.actAcquisizioneTurniExecute(Sender: TObject);
{2 fasi:
 - Chiamata servizio firlab 'Calendar' in get
 - Chiamata nostro servizio 'Turni' in put passando il risultato della chiamata precedente
}
var CancellaTurniEsistenti:Boolean;
begin
  inherited;
  if grdC700.selAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP)
  else
  begin
    if not MsgBox.KeyExists('AcquisTurni') then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A040_DLG_FMT_ACQUISIZ_TURNI,[R180NomeMese(StrToIntDef(edtMese.Text,0)),edtAnno.Text]),mtConfirmation,[mbYes,mbNo],ResultAcquisTurni,'AcquisTurni');
      Abort;
    end;
  end;
  if not MsgBox.KeyExists('CancellaTurni') then
  begin
    CancellaTurniEsistenti:=False;
    MsgBox.WebMessageDlg(Format(A000MSG_A040_DLG_FMT_CANCELLA_TURNI,[R180NomeMese(StrToIntDef(edtMese.Text,0)),edtAnno.Text]),mtConfirmation,[mbYes,mbNo],ResultCancellaTurni,'CancellaTurni');
    Abort;
  end;
  if CancellaTurniEsistenti then
    (WR302DM as TWA040FPianifRepDM).A040MW.CancellaTurniEsistenti;

  SaveProg:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  grdC700.selAnagrafe.First;
  B021FWebSvcClientDtM:=TB021FWebSvcClientDtM.Create(nil);
  StartElaborazioneCiclo(btnCambioData.HTMLName);
end;

procedure TWA040FPianifRep.InizioElaborazione;
begin
  inherited;
  actVisualizzaAnomalie.Enabled:=False;
end;

procedure TWA040FPianifRep.ResultAcquisTurni(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R <> mrYes then
  begin
    MsgBox.ClearKeys;
    exit;
  end
  else
    actAcquisizioneTurniExecute(actAcquisizioneTurni);
end;

procedure TWA040FPianifRep.ResultCancellaTurni(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  CancellaTurniEsistenti:=R = mrYes;
  actAcquisizioneTurniExecute(actAcquisizioneTurni);
  MsgBox.ClearKeys;
end;

function TWA040FPianifRep.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

function TWA040FPianifRep.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA040FPianifRep.VisualizzaColonneRecapiti;
var
  c:integer;
  Visualizza: Boolean;
begin
  Visualizza:=((WR302DM as TWA040FPianifRepDM).A040MW.CodTipologia = 'R') and chkRecapitiAlternativi.Checked;
  WBrowseFM.grdTabella.medpColonna('RECAPITO1').Visible:=Visualizza;
  WBrowseFM.grdTabella.medpColonna('RECAPITO2').Visible:=Visualizza;
  WBrowseFM.grdTabella.medpColonna('RECAPITO3').Visible:=Visualizza;
  WBrowseFM.grdTabella.Refresh;
end;

procedure TWA040FPianifRep.ElaboraElemento;
var Dal,Al:TDateTime;
begin
  Dal:=EncodeDate(StrToIntDef(edtAnno.Text,1900),StrToIntDef(edtMese.Text,1),1);
  Al:=R180FineMese(Dal);
  B021FWebSvcClientDtM.WebSvcRecordT380(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                                        grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString,
                                        Dal,
                                        Al);
end;

function TWA040FPianifRep.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.selAnagrafe.Next;
  if not grdC700.selAnagrafe.EOF then
    Result:=True;
end;

procedure TWA040FPianifRep.FineCicloElaborazione;
begin
  EsistonoMsgAnomalie:=B021FWebSvcClientDtM.EsistonoMsgAnomalie;
  actVisualizzaAnomalie.Enabled:=EsistonoMsgAnomalie;
  FreeAndNil(B021FWebSvcClientDtM);

  (WR302DM as TWA040FPianifRepDM).A040MW.RefreshT380;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);

  MsgBox.ClearKeys;
end;

function TWA040FPianifRep.ElaborazioneTerminata: String;
begin
  SessioneOracle.Commit;
  grdC700.selAnagrafe.SearchRecord('PROGRESSIVO',SaveProg,[srFromBeginning]);
  if actVisualizzaAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA040FPianifRep.EseguiStampa;
begin
  (WR302DM as TWA040FPianifRepDM).A040MW.PulisciVariabili;
  StartElaborazioneServer(WA040Stm.btnGeneraPDF.HTMLName);
end;

procedure TWA040FPianifRep.ElaborazioneServer;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  DCOMMsg:='';
  DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=WA040Stm.CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA040(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMMsg:=DettaglioLog;
    DCOMConnection.Connected:=False;
  end;
end;

end.
