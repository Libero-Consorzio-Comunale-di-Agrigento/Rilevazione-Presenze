unit WA151UAssenteismo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions, StrUtils, Math,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, meIWImageFile, A000UMessaggi,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, medpIWC700NavigatorBar, WA151UGrigliaRisultatoFM,
  IWCompEdit, meIWEdit, C180FunzioniGenerali, C190FunzioniGeneraliWeb, A000UInterfaccia,
  medpIWMessageDlg, Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} ActiveX,
  A000UCostanti, WC700USelezioneAnagrafeFM, OracleData;

type
  TWA151FAssenteismo = class(TWR102FGestTabella)
    actlstComandi: TActionList;
    actLblDal: TAction;
    actEdtDal: TAction;
    actLblAl: TAction;
    actEdtAl: TAction;
    actEsegui: TAction;
    actTabella: TAction;
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    grdComandi: TmeIWGrid;
    actAnomalie: TAction;
    actInfo: TAction;
    DCOMConnection: TDCOMConnection;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure actTabellaExecute(Sender: TObject);
    procedure actEseguiExecute(Sender: TObject);
    procedure grdTabControlTabControlChange(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actAnomalieExecute(Sender: TObject);
  private
    { Private declarations }
    WA151Ris:TWA151FGrigliaRisultatoFM;
    VisAnom,VisInfo,VisRis,Giro1,Giro2,Giro3:Boolean;
    iAccorpCorrente:Integer;
    FActionName: String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AbilitaAzioni(Abilita:Boolean);
    procedure CreaToolbarComandi(actlst: TActionList; grdToolbar: TmeIWGrid; _onClick: TprocSender);
    procedure imgComandiClick(Sender: TObject);
    procedure CallCOMServer;
    function CreateJSonString: String;
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    { Public declarations }
    procedure AbilitaComponenti;
    procedure evtClearKeys;
  protected
    procedure ImpostazioniWC700; override;
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ElaborazioneServer; override;
    procedure InizializzaMsgElaborazione; override;
    procedure InizioElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
  end;

implementation

uses WA151UAssenteismoDM, WA151UAssenteismoBrowseFM, WA151UAssenteismoDettFM;

{$R *.dfm}

procedure TWA151FAssenteismo.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  WR302DM:=TWA151FAssenteismoDM.Create(Self);
  WBrowseFM:=TWA151FAssenteismoBrowseFM.Create(Self);
  WDettaglioFM:=TWA151FAssenteismoDettFM.Create(Self);
  WA151Ris:=TWA151FGrigliaRisultatoFM.Create(Self);
  (WR302DM as TWA151FAssenteismoDM).A151MW.evtRichiesta:=evtRichiesta;
  (WR302DM as TWA151FAssenteismoDM).A151MW.evtClearKeys:=evtClearKeys;

  CreaToolbarComandi(actlstComandi,grdComandi,imgComandiClick);
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWA151FAssenteismoDM).A151MW.selAnagrafe:=grdC700.selAnagrafe;

  grdTabControl.AggiungiTab('Tabella',WBrowseFM);
  grdTabControl.AggiungiTab('Dettaglio',WDettaglioFM);
  grdTabControl.AggiungiTab('Risultati',WA151Ris);
  grdTabControl.HasFiller:=True;
  grdTabControl.ActiveTab:=WBrowseFM;

  edtDaData.Text:=DateToStr(R180InizioMese(Parametri.DataLavoro));
  edtAData.Text:=DateToStr(R180FineMese(Parametri.DataLavoro));
  VisAnom:=False;
  VisInfo:=False;
  VisRis:=False;
  AbilitaAzioni(True);
  (WR302DM as TWA151FAssenteismoDM).A151MW.selT151.First;

  GetParametriFunzione;
end;

procedure TWA151FAssenteismo.IWAppFormRender(Sender: TObject);
begin
  inherited;
  if grdTabControl.ActiveTab = WA151Ris then
    AbilitaAzioni(False);
end;

procedure TWA151FAssenteismo.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA151FAssenteismo.GetParametriFunzione;
begin
  with WA151Ris do
  begin
    cmbIdMittente.ItemIndex:=cmbIdUfficio.Items.IndexOf(C004DM.GetParametro('dcmbIdMittente', ''));
    cmbIdUfficio.ItemIndex:=cmbIdUfficio.Items.IndexOf(C004DM.GetParametro('dcmbIdUfficio', ''));
  end;
end;

procedure TWA151FAssenteismo.PutParametriFunzione;
begin
  C004DM.Cancella001;
  with WA151Ris do
  begin
    C004DM.PutParametro('dcmbIdMittente', VarToStr(cmbIdMittente.Items[cmbIdMittente.ItemIndex]));
    C004DM.PutParametro('dcmbIdUfficio', VarToStr(cmbIdUfficio.Items[cmbIdUfficio.ItemIndex]));
    try SessioneOracle.Commit; except end;
  end;
end;

procedure TWA151FAssenteismo.AbilitaAzioni(Abilita:Boolean);
var i:Integer;
begin
  grdTabControl.TabByIndex(2).Enabled:=VisRis;
  //Toolbar generica
  actNuovo.Enabled:=Abilita;
  actModifica.Enabled:=Abilita and not(SolaLettura);
  actElimina.Enabled:=Abilita;
  actAggiorna.Enabled:=Abilita;
  actRicerca.Enabled:=Abilita;
  actEstrai.Enabled:=Abilita;
  actPrimo.Enabled:=Abilita;
  actPrecedente.Enabled:=Abilita;
  actSuccessivo.Enabled:=Abilita;
  actUltimo.Enabled:=Abilita;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  //Toolbar specifica
  for i:=0 to actlstComandi.ActionCount - 1 do
    actlstComandi[i].Enabled:=Abilita;
  actAnomalie.Enabled:=Abilita and VisAnom;
  actInfo.Enabled:=Abilita and VisInfo;
  AggiornaToolBar(grdComandi,actlstComandi);
  //Toolbar WC700
  grdC700.AbilitaToolbar(Abilita);
end;

procedure TWA151FAssenteismo.CreaToolbarComandi(actlst: TActionList; grdToolbar: TmeIWGrid; _onClick: TprocSender);
var
  i, k:Integer;
  PrecCategory: String;
begin
  grdToolbar.RowCount:=1;
  grdToolbar.ColumnCount:=actlst.ActionCount;
  if actlst.ActionCount > 0 then
    PrecCategory:=TAction(actlst.Actions[0]).Category;
  k:=0;
  for i:=0 to actlst.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(actlst.Actions[i]).Category  then
    begin
      grdToolbar.Cell[0,k].Css:='x';
      grdToolbar.Cell[0,k].Text:='';
      k:=k + 1;
      grdToolbar.ColumnCount:=grdToolbar.ColumnCount + 1;
      PrecCategory:=TAction(actlst.Actions[i]).Category;
    end;

    if (actlst.Actions[i] as TAction).Name = 'actLblDal' then
      grdToolbar.Cell[0,k].Control:=lblDaData
    else if (actlst.Actions[i] as TAction).Name = 'actEdtDal' then
      grdToolbar.Cell[0,k].Control:=edtDaData
    else if (actlst.Actions[i] as TAction).Name = 'actLblAl' then
      grdToolbar.Cell[0,k].Control:=lblAData
    else if (actlst.Actions[i] as TAction).Name = 'actEdtAl' then
      grdToolbar.Cell[0,k].Control:=edtAData
    else
    begin
      grdToolbar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
      with TmeIWImageFile(grdToolbar.Cell[0,k].Control) do
      begin
        Name:=C190CreaNomeComponente(TAction(actlst.Actions[i]).Name,Self);
        OnClick:=_onClick;
        Tag:=i;
      end;
      grdToolbar.Cell[0,k].Css:='x';
      grdToolbar.Cell[0,k].Text:='';
    end;
    k:=k + 1;
  end;
  AggiornaToolBar(grdToolbar,actlst);
end;

procedure TWA151FAssenteismo.imgComandiClick(Sender: TObject);
begin
  MessaggioStatus(INFORMA,'');
  TAction(actlstComandi.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWA151FAssenteismo.grdTabControlTabControlChange(Sender: TObject);
begin
  inherited;
  AbilitaAzioni(grdTabControl.ActiveTab <> WA151Ris);
end;

procedure TWA151FAssenteismo.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase+' ,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE';
  grdC700.WC700FM.C700SelezionePeriodica:=True;
  grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  grdC700.WC700FM.C700DataDal:=Parametri.DataLavoro;
  grdC700.AttivaBrowse:=False;
end;

procedure TWA151FAssenteismo.actTabellaExecute(Sender: TObject);
begin
  inherited;
  FActionName:=actTabella.Name;
  CallCOMServer;
end;

procedure TWA151FAssenteismo.CallCOMServer;
var DataI,DataF:TDateTime;
begin
  evtRichiesta(A000MSG_A151_DLG_GENERA_TABELLA,'GeneraTabella');
  evtClearKeys;//Posizionato dopo l'ultima domanda del flusso, prima delle exception/abort
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(StrToDate(edtDaData.Text),StrToDate(edtAData.Text)) then
    grdC700.selAnagrafe.Close;
  grdC700.selAnagrafe.Open;
  if grdC700.selAnagrafe.RecordCount = 0 then
    raise exception.Create(A000MSG_ERR_NO_DIP);
  if Trim((WR302DM as TWA151FAssenteismoDM).A151MW.selT151.FieldByName('STAMPA_GENERATORE').AsString) = '' then
    raise exception.Create(A000MSG_R003_MSG_SPECIFICARE_STAMPA);
  DataI:=StrToDate(edtDaData.Text);
  DataF:=StrToDate(edtAData.Text);
  if DataF < DataI then
    raise exception.Create(A000MSG_R003_ERR_DATE_NON_CORRETTE);
  if R180Anno(DataI) < R180Anno(DataF) - 1 then
    raise exception.Create(A000MSG_R003_MSG_PERIODO_MAGGIORE_2_ANNI);
  // Inizio elaborazione
  StartElaborazioneServer(btnSendFile.HTMLName);
end;

procedure TWA151FAssenteismo.ElaborazioneServer;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  VisAnom:=False;
  VisInfo:=False;
  VisRis:=False;
  AbilitaAzioni(True);
  DettaglioLog:='';
  MsgFileNonCreato:=A000MSG_ERR_TAB_NON_COMPATIBILE;
  DCOMNomeFile:='';
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA077(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
    DCOMMsg:=DettaglioLog;
    (WR302DM as TWA151FAssenteismoDM).A151MW.CreaIndice:=True;
    (WDettaglioFM as TWA151FAssenteismoDettFM).AggiornaGrigliaRighe;
  end;
end;

function TWA151FAssenteismo.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDaData,json,'edtDal');
    C190Comp2JsonString(edtAData,json,'edtAl');
    json.AddPair('CodiceStampa',Trim((WR302DM as TWA151FAssenteismoDM).A151MW.selT151.FieldByName('STAMPA_GENERATORE').AsString));
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA151FAssenteismo.InizializzaMsgElaborazione;
begin
  inherited;

  if FActionName = actTabella.Name then
  begin
    // generazione tabella
    WC022FMsgElaborazioneFM.Titolo:='Creazione Tabella';
    WC022FMsgElaborazioneFM.Messaggio:='Creazione Tabella in corso...';
    WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_ELABORAZIONE;
  end
  else
  begin
    // esegui elaborazione
    WC022FMsgElaborazioneFM.Titolo:=A000MSG_MSG_ELABORAZIONE;
    WC022FMsgElaborazioneFM.Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
    WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_ELABORAZIONE;
  end;
end;

procedure TWA151FAssenteismo.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA151FAssenteismo.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    if KI = 'GeneraTabella' then
      actTabellaExecute(nil)
    else if R180In(KI,['NoIDMittente','Export1000Tassi']) then
      WA151Ris.btnEseguiClick(nil)
    else if R180In(KI,['GaranziaTassiAssPres','GaranziaL104AssPres','GaranziaL104DettFam','DettaglioDataFam']) then
      actEseguiExecute(nil);
  end
  else
    evtClearKeys;
end;

procedure TWA151FAssenteismo.evtClearKeys;
begin
  MsgBox.ClearKeys;
end;

procedure TWA151FAssenteismo.actAnomalieExecute(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=' + IfThen(Sender = actAnomalie,'A,B','I');
  accediForm(201,Params,False);
end;

procedure TWA151FAssenteismo.actConfermaExecute(Sender: TObject);
begin
  (WDettaglioFM as TWA151FAssenteismoDettFM).ConfermaGrdRighe;
  inherited;
end;

procedure TWA151FAssenteismo.actEseguiExecute(Sender: TObject);
var i:Integer;
    HTMLNameEsegui:String;
begin
  inherited;
  FActionName:=actEsegui.Name;
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(StrToDate(edtDaData.Text),StrToDate(edtAData.Text)) then
    grdC700.selAnagrafe.Close;
  grdC700.selAnagrafe.Open;

  //with (WR302DM as TWA151FAssenteismoDM).A151MW,(WDettaglioFM as TWA151FAssenteismoDettFM) do
  with (WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    PeriodiStorici:=grdC700.selAnagrafe.VariableIndex('C700DATADAL') >= 0;
    NumDipSel:='';
    PresenzeSel:='';
    AssenzeSel:='';
    RiepilogoSel:='';
    for i:=0 to lNumDip.Count - 1 do
      if R180InConcat(Copy(lNumDip[i],2,3),selT151.FieldByName('COLONNE').AsString) then
        NumDipSel:=NumDipSel + IfThen(Trim(NumDipSel) <> '',',') + Copy(lNumDip[i],2,3);
    for i:=0 to lPres.Count - 1 do
      if R180InConcat(Copy(lPres[i],2,3),selT151.FieldByName('COLONNE').AsString) then
        PresenzeSel:=PresenzeSel + IfThen(Trim(PresenzeSel) <> '',',') + Copy(lPres[i],2,3);
    for i:=0 to lAss.Count - 1 do
      if R180InConcat(Copy(lAss[i],2,3),selT151.FieldByName('COLONNE').AsString) then
        AssenzeSel:=AssenzeSel + IfThen(Trim(AssenzeSel) <> '',',') + Copy(lAss[i],2,3);
    for i:=0 to lRiep.Count - 1 do
      if R180InConcat(Copy(lRiep[i],2,3),selT151.FieldByName('COLONNE').AsString) then
        RiepilogoSel:=RiepilogoSel + IfThen(Trim(RiepilogoSel) <> '',',') + Copy(lRiep[i],2,3);

    CodTabella:=selT151.FieldByName('STAMPA_GENERATORE').AsString;//cmbTabella.Text;
    RecuperaTabella;
    TipoAccorp:=selT151.FieldByName('COD_TIPOACCORPCAUSALI').AsString;//cmbTipoAccorp.Text;
    ElencoAccorp.CommaText:=selT151.FieldByName('COD_CODICIACCORPCAUSALI').AsString;//dedtAccorpamenti.Text;
    iEsportaXml:=-1;
    if selT151.FieldByName('ESPORTA_XML').AsString <> 'N' then
      iEsportaXml:=IfThen(selT151.FieldByName('ESPORTA_XML').AsString = 'S',0,1);//cmbEsportaXML.ItemIndex;
    DettDip:=selT151.FieldByName('DETTAGLIO_DIP').AsString = 'S';//dchkDettaglioDip.Checked;
    iNumDipPeriodo:=IfThen(selT151.FieldByName('NUMDIP_PERIODO').AsString = 'I',0,1);//drdgNumDipPeriodo.ItemIndex;
    PresGGLav:=selT151.FieldByName('PRESENZA_GGLAV').AsString = 'S';//dchkPresenzaGGLav.Checked;
    AssGGLav:=selT151.FieldByName('ASSENZA_GGLAV').AsString = 'S';//dchkAssenzaGGLav.Checked;
    GGInt:=selT151.FieldByName('ASSENZA_GGINT').AsString = 'S';//dchkAssenzaGGInt.Checked;
    iDebitoGGInt:=IfThen(selT151.FieldByName('ASS_DEBITO_GGINT').AsString = 'C',0,1);//drdgDebitoGGInt.ItemIndex;
    AssQM:=selT151.FieldByName('ASSENZA_QM').AsString = 'S';//dchkAssenzaQM.Checked;
    DettGG:=selT151.FieldByName('ASS_DETTAGLIO').AsString = 'S';//dchkDettaglioGiustificativi.Checked;
    DettFam:=selT151.FieldByName('ASS_FAMILIARI').AsString = 'S';//dchkDettaglioFamiliari.Checked;
    FruizGG:=selT151.FieldByName('ASS_FRUIZIONE_GG').AsString = 'S';//dchkFruizGG.Checked;
    FruizMG:=selT151.FieldByName('ASS_FRUIZIONE_MG').AsString = 'S';//dchkFruizMG.Checked;
    FruizHH:=selT151.FieldByName('ASS_FRUIZIONE_HH').AsString = 'S';//dchkFruizHH.Checked;
    FruizDH:=selT151.FieldByName('ASS_FRUIZIONE_DH').AsString = 'S';//dchkFruizDH.Checked;
    MaxGG:=selT151.FieldByName('ASS_MAXPERIODO_GG').AsInteger;//dedtMaxGG.Text;
    DaData:=StrToDate(edtDaData.Text);
    AData:=StrToDate(edtAData.Text);
    CaricaElencoColonne;
    CaricaElencoRighe;
    Domande;
    evtClearKeys;//Posizionato dopo l'ultima domanda del flusso, prima delle exception/abort
    Controlli;
  end;

  VisAnom:=False;
  VisInfo:=False;
  VisRis:=False;
  AbilitaAzioni(True);
  RegistraMsg.IniziaMessaggio('WA151');

  HTMLNameEsegui:='';
  for i:=0 to grdComandi.ColumnCount - 1 do
    if (grdComandi.Cell[0,i].Control <> nil)
    and (grdComandi.Cell[0,i].Control is TmeIWImageFile)
    and ((grdComandi.Cell[0,i].Control as TmeIWImageFile).Hint = 'Esegui') then
      HTMLNameEsegui:=(grdComandi.Cell[0,i].Control as TmeIWImageFile).HTMLName;

  with (WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    PreparaElaborazione;

    Giro1:=OpzioneNumDip or OpzioneRiepilogoDip or OpzionePresenze or OpzioneRiepilogoPres;
    Giro2:=OpzioneEventiAssenze;
    Giro3:=OpzioneAssenze or OpzioneAssenzeL104 or OpzioneRiepilogoAss;

    if Giro1 or Giro2 or Giro3 then
    begin
      //MsgBox.WebMessageDlg(ElaborazioneCicloServer,mtConfirmation,[mbOK],nil,'');
      StartElaborazioneCicloServer(btnSendFile.HTMLName);
    end;
  end;
end;

procedure TWA151FAssenteismo.actModificaExecute(Sender: TObject);
begin
  inherited;
  (WDettaglioFM as TWA151FAssenteismoDettFM).dgrdRighe.medpModifica(False);
end;

procedure TWA151FAssenteismo.actNuovoExecute(Sender: TObject);
begin
  inherited;
  (WDettaglioFM as TWA151FAssenteismoDettFM).dgrdRighe.medpModifica(False);
end;

procedure TWA151FAssenteismo.AbilitaComponenti;
begin
  inherited;
  with WDettaglioFM as TWA151FAssenteismoDettFM do
  begin
    dchkAssenzaQM.Enabled:=lstAssenze.Selected[0] or lstAssenze.Selected[3];
    if not dchkAssenzaQM.Enabled then
      dchkAssenzaQM.Checked:=False;
    dchkAssenzaGGInt.Enabled:=lstAssenze.Selected[0] or lstAssenze.Selected[1] or lstAssenze.Selected[3];
    if not dchkAssenzaGGInt.Enabled then
      dchkAssenzaGGInt.Checked:=False;
    dchkAssenzaGGLav.Enabled:=lstAssenze.Selected[0] or lstAssenze.Selected[1] or lstAssenze.Selected[3] or lstAssenze.Selected[4] or lstAssenze.Selected[5];
    if not dchkAssenzaGGLav.Enabled then
      dchkAssenzaGGLav.Checked:=False;
    dchkDettaglioGiustificativi.Enabled:=(dchkDettaglioDip.Checked) and (lstAssenze.Selected[0] or lstAssenze.Selected[1] or lstAssenze.Selected[4] or lstAssenze.Selected[5]);
    if not dchkDettaglioGiustificativi.Enabled then
      dchkDettaglioGiustificativi.Checked:=False;
    dchkDettaglioFamiliari.Enabled:=(dchkDettaglioGiustificativi.Checked) and (lstAssenze.Selected[0] or lstAssenze.Selected[1] or lstAssenze.Selected[4] or lstAssenze.Selected[5]);
    if not dchkDettaglioFamiliari.Enabled then
      dchkDettaglioFamiliari.Checked:=False;
    dedtMaxGG.Enabled:=lstAssenze.Selected[0] or lstAssenze.Selected[1] or lstAssenze.Selected[3] or lstAssenze.Selected[4] or lstAssenze.Selected[5];
    lblMaxGG.Enabled:=lstAssenze.Selected[0] or lstAssenze.Selected[1] or lstAssenze.Selected[3] or lstAssenze.Selected[4] or lstAssenze.Selected[5];
    drdgAssenzaArrot.Enabled:=lstAssenze.Selected[0] or lstAssenze.Selected[3];
    drdgDebitoGGInt.Enabled:=dchkAssenzaGGInt.Checked;
    dchkDettaglioFamiliari.Enabled:=(dchkDettaglioGiustificativi.Checked);
    if not dchkDettaglioFamiliari.Enabled then
      dchkDettaglioFamiliari.Checked:=False;
  end;
end;

procedure TWA151FAssenteismo.InizioElaborazione;
begin
  with (WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    selV430.First;
    grdC700.selAnagrafe.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]);
    OldProg:=0;
  end;
  iAccorpCorrente:=0;
end;

function TWA151FAssenteismo.TotalRecordsElaborazione: Integer;
begin
  Result:=0;
  with (WR302DM as TWA151FAssenteismoDM).A151MW do
    if Giro1 then
      Result:=selV430.RecordCount
    else if Giro2 or Giro3 then
      Result:=ElencoAccorp.Count * selV430.RecordCount;
end;

function TWA151FAssenteismo.CurrentRecordElaborazione: Integer;
begin
  Result:=0;
  with (WR302DM as TWA151FAssenteismoDM).A151MW do
    if Giro1 then
      Result:=selV430.RecNO
    else if Giro2 or Giro3 then
      Result:=(iAccorpCorrente * selV430.RecordCount) + selV430.RecNO;
  WC019FProgressBarFM.MessaggioStep2:=IfThen(Giro1,A000MSG_A151_MSG_ELAB_PRESENZE,A000MSG_A151_MSG_ELAB_ASSENZE);
end;

procedure TWA151FAssenteismo.ElaboraElemento;
begin
  with (WR302DM as TWA151FAssenteismoDM).A151MW do
    if Giro1 then
    begin
      if not selSQL.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_DIP_NON_PRES,[Tabella]),'',selV430.FieldByName('PROGRESSIVO').AsInteger)
      else
        CaricaTabellaRisultato('PRES','');
    end
    else if Giro2 then
    begin
      if not selSQL.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_DIP_NON_PRES,[Tabella]),'',selV430.FieldByName('PROGRESSIVO').AsInteger)
      else
      begin
        //Registro solo se cambia progressivo
        if (OldProg <> 0) and (OldProg <> selV430.FieldByName('PROGRESSIVO').AsInteger) then
        begin
          cdsRisultato.Edit;
          cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[iAccorpCorrente]).AsFloat:=cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[iAccorpCorrente]).AsFloat + NumEventi;
          cdsRisultato.FieldByName('ASS10GG').AsFloat:=cdsRisultato.FieldByName('ASS10GG').AsFloat + NumEventi;
          cdsRisultato.Post;
        end;
        CaricaTabellaRisultato('EV',ElencoAccorp.Strings[iAccorpCorrente]);
      end;
    end
    else if Giro3 then
      if selSQL.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        CaricaTabellaRisultato('ASS',ElencoAccorp.Strings[iAccorpCorrente]);
end;

function TWA151FAssenteismo.ElementoSuccessivo: Boolean;
begin
  with (WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    OldProg:=selV430.FieldByName('PROGRESSIVO').AsInteger;
    selV430.Next;
    grdC700.selAnagrafe.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]);
    Result:=not selV430.EOF;
    if Giro2 and not Result then
    begin
      //Registro ultimo progressivo
      if cdsDettaglio.State in [dsEdit,dsInsert] then
        cdsDettaglio.Post;
      cdsRisultato.Edit;
      cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[iAccorpCorrente]).AsFloat:=cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[iAccorpCorrente]).AsFloat + NumEventi;
      cdsRisultato.FieldByName('ASS10GG').AsFloat:=cdsRisultato.FieldByName('ASS10GG').AsFloat + NumEventi;
      cdsRisultato.Post;
    end;
    if (Giro2 or Giro3) and not Giro1 and not Result then
      if iAccorpCorrente < (ElencoAccorp.Count - 1) then
      begin
        Result:=True;
        inc(iAccorpCorrente);
        selV430.First;
        grdC700.selAnagrafe.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]);
      end;
  end;
end;

procedure TWA151FAssenteismo.FineCicloElaborazione;
begin
  AggiornaAnagr;
end;

function TWA151FAssenteismo.ElaborazioneTerminata: String;
  function DecodeArrot(S:String):Integer;
  begin
    Result:=IfThen(S = 'N',0,IfThen(S = 'P',1,IfThen(S = 'D',2,3)));
  end;
begin
  SessioneOracle.Commit;
  if (Giro1 and (Giro2 or Giro3))
  or (Giro2 and Giro3) then
  begin
    Result:='';
    if Giro1 then
      Giro1:=False
    else if Giro2 then
      Giro2:=False;
    RipartiElaborazione:=True;
  end
  else
  begin
    //with (WR302DM as TWA151FAssenteismoDM).A151MW,(WDettaglioFM as TWA151FAssenteismoDettFM) do
    with (WR302DM as TWA151FAssenteismoDM).A151MW do
    begin
      EsportaTassiAss:=selT151.FieldByName('ESPORTA_XML').AsString = 'S';
      EsportaLegge104:=selT151.FieldByName('ESPORTA_XML').AsString = 'L';
      TotGen:=selT151.FieldByName('TOTALE_GENERALE').AsString = 'S';//dchkTotaleGen.Checked;
      RigheVuote:=selT151.FieldByName('RIGHE_VUOTE').AsString = 'S';//dchkRigheVuote.Checked;
      iNumDipArrot:=DecodeArrot(selT151.FieldByName('NUMDIP_ARROT').AsString);//drdgNumDipArrot.ItemIndex;
      iAssArrot:=DecodeArrot(selT151.FieldByName('ASSENZA_ARROT').AsString);//drdgAssenzaArrot.ItemIndex;
      iRiepArrot:=DecodeArrot(selT151.FieldByName('RIEPILOGO_ARROT').AsString);//drdgRiepilogoArrot.ItemIndex;
      OperazioniFinali;
      iAss:=IfThen(selT151.FieldByName('MODO_ACCORPCAUSALI').AsString = 'D',0,IfThen(selT151.FieldByName('MODO_ACCORPCAUSALI').AsString = 'T',1,2));//drdgAssenze.ItemIndex;
      iNumDipPeriodo:=IfThen(selT151.FieldByName('NUMDIP_PERIODO').AsString = 'I',0,1);//drdgNumDipPeriodo.ItemIndex;
      sDaData:=edtDaData.Text;
      sAData:=edtAData.Text;
      (WR302DM as TWA151FAssenteismoDM).A151MW.ImpostaColonneGriglia;
      WA151Ris.dgrdRisultato.medpAttivaGrid(cdsRisultato,False,False,False);
    end;
    Giro1:=False;
    Giro2:=False;
    Giro3:=False;
    VisAnom:=RegistraMsg.ContieneTipoA;
    VisInfo:=RegistraMsg.ContieneTipoI;
    VisRis:=True;
    AbilitaAzioni(True);
    if VisAnom then
      Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
    else if VisInfo then
    begin
      grdTabControl.ActiveTab:=WA151Ris;
      Result:=A000MSG_MSG_ELABORAZIONE_SEGNALAZIONI;
    end
    else
    begin
      grdTabControl.ActiveTab:=WA151Ris;
      Result:=inherited;
    end;
  end;
end;

procedure TWA151FAssenteismo.WC700AperturaSelezione(Sender: TObject);
var D: TDateTime;
begin
  if TryStrToDate(edtDaData.Text,D) then
    grdC700.WC700FM.C700DataDal:=D;

  if TryStrToDate(edtAData.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=D;
end;

end.
