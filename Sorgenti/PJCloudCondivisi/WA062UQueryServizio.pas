unit WA062UQueryServizio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,OracleData,
  Dialogs, WR102UGestTabella, ActnList, IWApplication, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  A000UInterfaccia, IWHTMLControls, meIWLink, WA062URisultatiFM, medpIWMessageDlg, A000UMessaggi,
  System.Actions, meIWImageFile, Cestino, IWCompListbox, meIWComboBox, IWCompEdit, meIWEdit,
  A000UCostanti, System.StrUtils, C190FunzioniGeneraliWeb, Oracle;

type
  TWA062FQueryServizio = class(TWR102FGestTabella)
    actEsegui: TAction;
    actPulisci: TAction;
    cmbRaggruppamenti: TmeIWComboBox;
    lblRaggruppamento: TmeIWLabel;
    AJW062AvviaElab: TIWAJAXNotifier;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actEseguiExecute(Sender: TObject);
    procedure actPulisciExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);override;
    procedure actConfermaExecute(Sender: TObject);override;
    procedure actEliminaExecute(Sender: TObject);override;
    procedure actModificaExecute(Sender: TObject);override;
    procedure actNuovoExecute(Sender: TObject);override;
    procedure cmbRaggruppamentiChange(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure AJW062AvviaElabNotify(Sender: TObject);
  private
    FRisultatiInvalidati: Boolean;
    actInsertSubSqlProgr,actInsertSubSqlJoin,actInsertSubSqlExist:TAction;
    procedure SetRisultatiInvalidati(const Value: Boolean);
    procedure selTabellaRefresh;
    procedure AbilitaAzioni(Browse: boolean);
    procedure RefreshTabellaBrowse(nomeLocate:String ='');
    procedure ResultMessaggioDelT002(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure AbilitaTab(abilitazione: boolean; frame: array of TFrame);
    procedure actInsertSubSqlExistExecute(Sender: TObject);
    procedure actInsertSubSqlJoinExecute(Sender: TObject);
    procedure actInsertSubSqlProgrExecute(Sender: TObject);
    procedure AvviaElaborazione(EventParams: TStringList);
  protected
    procedure InizializzaMsgElaborazione; override;
  public
    WA062RisultatiFM:TWA062FRisultatiFM;
    IsModificaAction:boolean;
    function InizializzaAccesso: Boolean; override;
    property RisultatiInvalidati: Boolean read FRisultatiInvalidati write SetRisultatiInvalidati;
    const
      CALLBACK_AVVIA_ELAB:String='AvviaElaborazione';
  end;

implementation

uses WA062UQueryServizioDM, WA062UQueryServizioBrowseFM, WA062UQueryServizioDettFM, WR205UDettTabellaFM;

{$R *.dfm}

procedure TWA062FQueryServizio.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  GGetWebApplicationThreadVar.RegisterCallBack(Self.name + CALLBACK_AVVIA_ELAB,AvviaElaborazione);

  FRisultatiInvalidati:=False;
  WR302DM:=TWA062FQueryServizioDM.Create(Self);
  (WR302DM as TWA062FQueryServizioDM).A062MW.C004DM_MW:=C004DM;
  InterfacciaWR102.CopiaSuChiave:='APPLICAZIONE,NOME';
  InterfacciaWR102.CopiaSuChiaveInput:='NOME';
  InterfacciaWR102.CopiaSuCampi:='APPLICAZIONE,NOME,POSIZ,RIGA';
  WBrowseFM:=TWA062FQueryServizioBrowseFM.Create(Self);
  (WR302DM as TWA062FQueryServizioDM).A062MW.CaricaCmbRaggruppamenti(cmbRaggruppamenti.Items);
  cmbRaggruppamenti.ItemIndex:=0;

  WA062RisultatiFM:=TWA062FRisultatiFM.Create(Self);
  WDettaglioFM:=TWA062FQueryServizioDettFM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWA062FQueryServizioDM).A062MW.SelAnagrafe:=grdC700.selAnagrafe;
  grdC700.AttivaBrowse:=False;
  (WR302DM as TWA062FQueryServizioDM).A062MW.C700MergeSelAnagrafe:=grdC700.WC700FM.C700MergeSelAnagrafe;
  (WR302DM as TWA062FQueryServizioDM).A062MW.SelAnagrafe:=grdC700.selAnagrafe;
  CreaTabDefault;
  grdTabControl.AggiungiTab('Risultati',WA062RisultatiFM);
  grdTabControl.ActiveTab:=WBrowseFM;
  IsModificaAction:=False;
  //Action per l'inserimento di SQL preimpostato sulla IWMemo di WDettaglioFM
  actInsertSubSqlProgr:=TAction.Create(Self);
  actInsertSubSqlProgr.Caption:='btnImport';
  actInsertSubSqlProgr.Category:='Sql';
  actInsertSubSqlProgr.Hint:='Inserisci subquery ''PROGRESSIVO IN'' sulla selezione anagrafica';
  actInsertSubSqlProgr.Name:='actC700CreaSubSqlProgressivo';
  actInsertSubSqlProgr.OnExecute:=actInsertSubSqlProgrExecute;
  actInsertSubSqlProgr.Enabled:=False;
  grdC700.AddToActionList(actInsertSubSqlProgr);

  actInsertSubSqlJoin:=TAction.Create(Self);
  actInsertSubSqlJoin.Caption:='btnImport2';
  actInsertSubSqlJoin.Category:='Sql';
  actInsertSubSqlJoin.Hint:='Inserisci join con la selezione anagrafica';
  actInsertSubSqlJoin.Name:='actInsertSubSqlJoin';
  actInsertSubSqlJoin.OnExecute:=actInsertSubSqlJoinExecute;
  actInsertSubSqlJoin.Enabled:=False;
  grdC700.AddToActionList(actInsertSubSqlJoin);

  actInsertSubSqlExist:=TAction.Create(Self);
  actInsertSubSqlExist.Caption:='btnImport3';
  actInsertSubSqlExist.Category:='Sql';
  actInsertSubSqlExist.Hint:='Inserisci subquery ''EXISTS'' sulla selezione anagrafica';
  actInsertSubSqlExist.Name:='actInsertSubSqlExist';
  actInsertSubSqlExist.OnExecute:=actInsertSubSqlExistExecute;
  actInsertSubSqlExist.Enabled:=False;
  grdC700.AddToActionList(actInsertSubSqlExist);
  grdC700.WC700FM.C700SelezionePeriodica:=True;
end;

procedure TWA062FQueryServizio.IWAppFormDestroy(Sender: TObject);
begin
  gGetWebApplicationThreadVar.UnregisterCallBack(Self.Name + CALLBACK_AVVIA_ELAB);
  inherited;
end;

function TWA062FQueryServizio.InizializzaAccesso: Boolean;
var
  Sql: string;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('NOME',GetParam('NOME'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;

  //Richiamo da Wa077 con un sql generato
  Sql:=GetParam('SQL');
  if Sql <> '' then
  begin
    actNuovoExecute(nil);
    (WDettaglioFM as TWA062FQueryServizioDettFM).memoSql.Text:=sql;
  end;
  Result:=True;
end;

procedure TWA062FQueryServizio.actNuovoExecute(Sender: TObject);
begin
  WA062RisultatiFM.grdRisultati.DataSource:=nil;
  (WDettaglioFM as TWA062FQueryServizioDettFM).InizializzaCampi;
  AbilitaAzioni(False);
  (WDettaglioFM as TWA062FQueryServizioDettFM).AbilitaComponenti;
  (WDettaglioFM as TWA062FQueryServizioDettFM).PulisciCampoNome;
  AbilitaTab(True,[WDettaglioFM,WA062RisultatiFM]);
end;

procedure TWA062FQueryServizio.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  AbilitaAzioni(True);
  AbilitaTab(True,[]);
end;

procedure TWA062FQueryServizio.actPulisciExecute(Sender: TObject);
begin
  (WDettaglioFM as TWA062FQueryServizioDettFM).InizializzaCampi;
end;

procedure TWA062FQueryServizio.selTabellaRefresh;
begin
  if cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex] = 'Tutte le interrogazioni' then
    (WR302DM as TWA062FQueryServizioDM).A062MW.OpenSelT002((WR302DM as TWA062FQueryServizioDM).selTabella,'')
  else
    (WR302DM as TWA062FQueryServizioDM).A062MW.OpenSelT002((WR302DM as TWA062FQueryServizioDM).selTabella,cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex]);
end;

procedure TWA062FQueryServizio.SetRisultatiInvalidati(const Value: Boolean);
var
  LInfoMsg: string;
begin
  FRisultatiInvalidati:=Value;

  // tab esecuzione: messaggio in caso di risultati invalidati
  LInfoMsg:=IfThen(FRisultatiInvalidati,'I parametri sono stati modificati. Rieseguire la query per aggiornare i risultati','');
  if WDettaglioFM <> nil then
    (WDettaglioFM as TWA062FQueryServizioDettFM).lblInfo.Text:=LInfoMsg;

  // tab risultati: messaggio in caso di risultati invalidati
  LInfoMsg:=IfThen(FRisultatiInvalidati,'I risultati visualizzati sono riferiti all''esecuzione precedente.','');
  if WA062RisultatiFM <> nil then
    WA062RisultatiFM.lblInfo.Text:=LInfoMsg;
end;

procedure TWA062FQueryServizio.cmbRaggruppamentiChange(Sender: TObject);
begin
  inherited;
  selTabellaRefresh;
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWA062FQueryServizio.actConfermaExecute(Sender: TObject);
var nomeInserito:String;
begin
  nomeInserito:=(WDettaglioFM as TWA062FQueryServizioDettFM).SalvaSql;
  RefreshTabellaBrowse(nomeInserito);
  AbilitaAzioni(True);
  AbilitaTab(True,[]);
end;

procedure TWA062FQueryServizio.actEliminaExecute(Sender: TObject);
begin
  if WR302DM.selTabella.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_MSG_NESSUN_ELEMENTO_DA_CANCELLARE,mtInformation,[mbOK],nil,'');
    exit;
  end;
  if not MsgBox.KeyExists('delT002')then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_DLG_FMT_ELIMINARE_QUERY,[WR302DM.selTabella.FieldByName('NOME').AsString]),mtConfirmation,[mbYes,mbNo],ResultMessaggioDelT002,'delT002');
      Abort;
    end
end;

procedure TWA062FQueryServizio.ResultMessaggioDelT002(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  Cod,Msg:string;
begin
  if R = mrYes then
  begin
    with TCestino.Create(SessioneOracle) do
      try
        Cod:=WR302DM.selTabella.FieldByName('NOME').AsString;
        Msg:=CancLogica('T002_QUERYPERSONALIZZATE',Cod);
        if Msg.Trim <> '' then
          raise Exception.Create(Msg);
        (WR302DM as TWA062FQueryServizioDM).A062MW.DelQueryRaggr(Cod);
        RegistraLog.SettaProprieta('C','T002_QUERYPERSONALIZZATE','WA062',nil,True);
        RegistraLog.InserisciDato('NOME',Cod,'');
        RegistraLog.RegistraOperazione;
      finally
        Free;
        MsgBox.ClearKeys;
        SessioneOracle.Commit;
        RefreshTabellaBrowse;
      end;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA062FQueryServizio.actEseguiExecute(Sender: TObject);
begin
  CreaMsgElaborazioneFM;

  // segnala avvio elaborazione
  grdStatusBar.StatusBarComponent('MESSAGGIO').Value:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;

  //start elaborazione
  AddToInitProc(format('executeAjaxEvent("", %sIWCL,"%s",false,null,true);',[cmbRaggruppamenti.HTMLName,Self.Name + CALLBACK_AVVIA_ELAB]));
end;

procedure TWA062FQueryServizio.AvviaElaborazione(EventParams: TStringList);
begin
  AJW062AvviaElab.Notify;
end;

procedure TWA062FQueryServizio.AJW062AvviaElabNotify(Sender: TObject);
var
  LElapsedMs: Int64;
  RichiediSubmit:Boolean;
  JSErr:String;
begin
  RichiediSubmit:=True;
  A000SessioneWEB.AnnullaTimeOut;
  try
    (WDettaglioFM as TWA062FQueryServizioDettFM).EseguiSql(actEsegui,LElapsedMs);

    // riporta il tempo di elaborazione a video
    //  grdStatusBar.StatusBarComponent('MESSAGGIO').Value:='Durata esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LElapsedMs / MSecsPerDay);

    if (WR302DM as TWA062FQueryServizioDM).A062MW.Q1.Active then
    begin
      WA062RisultatiFM.grdRisultati.medpAttivaGrid((WR302DM as TWA062FQueryServizioDM).A062MW.Q1,False,False);
      grdTabControl.ActiveTab:=WA062RisultatiFM;
      RisultatiInvalidati:=False;
    end;
  except
    on E:Exception do
    begin
      { Non posso usare Msgbox.MessageBox, potrebbe già essere stato utilizzato prima del verificarsi
        dell'eccezione. Non posso sollevare l'eccezione e basta perchè il codice JS che chiama la dialog
        viene eseguito anche in callback, ma subito dopo eseguirei un submit (fondo di questo metodo) -
        se invece non lo eseguissi non ci sarebbe mai un submit e resterei bloccato (dovrei modificare
        TA000FInterfaccia.IWServerControllerBaseException). }
      RichiediSubmit:=False;
      JSErr:='var eseguiSubmitWA062 = function(){' + Format('SubmitClick("%s", "", true);',[btnShowElabError.HTMLName]) + '};';
      JSErr:=JSErr + #13#10 + 'mostraDialogErrore("' + C190EscapeJS(Format(A000MSG_ERR_FMT_ERRORE,[E.Message])) + '",null,eseguiSubmitWA062,null);';
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(JSErr);
      // Sarà la dialog appena mostrata ad eseguire il submit al click su OK.
    end;
  end;

  grdStatusBar.StatusBarComponent('MESSAGGIO').Value:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LElapsedMs / MSecsPerDay);

  // ripristina il timeout di sessione
  A000SessioneWEB.RipristinaTimeOut;

  if WC022FMsgElaborazioneFM <> nil then
  begin
    WC022FMsgElaborazioneFM.Chiudi;
    WC022FMsgElaborazioneFM:=nil;
  end;

  //In async non si chiude il Frame WA074FMsgStampa ne viene presentato il file o l'errore. Forzo un click.
  if RichiediSubmit then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnShowElabError.HTMLName]));
end;

procedure TWA062FQueryServizio.InizializzaMsgElaborazione;
begin
  inherited;

  WC022FMsgElaborazioneFM.Messaggio:='Esecuzione in corso...';
  WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_ELABORAZIONE;
end;

procedure TWA062FQueryServizio.actModificaExecute(Sender: TObject);
begin
  if WR302DM.selTabella.RecordCount = 0 then
  begin
    actNuovoExecute(actNuovo);
    exit;
  end;
  IsModificaAction:=True;
  AbilitaAzioni(False);
  AbilitaTab(True,[WDettaglioFM,WA062RisultatiFM]);
  (WDettaglioFM as TWA062FQueryServizioDettFM).AbilitaComponenti;
end;

procedure TWA062FQueryServizio.RefreshTabellaBrowse(nomeLocate:String ='');
begin
  with (WR302DM as TWA062FQueryServizioDM) do
  begin
    selTabellaRefresh;
    if nomeLocate <> '' then
      selTabella.SearchRecord('NOME',nomeLocate,[srFromBeginning]);
  end;
  (WBrowseFM as TWA062FQueryServizioBrowseFM).grdTabella.medpAggiornaCDS;
end;

procedure TWA062FQueryServizio.AbilitaAzioni(Browse: boolean);
begin
  actRicerca.Enabled:=Browse;
  actPrimo.Enabled:=Browse;
  actPrecedente.Enabled:=Browse;
  actSuccessivo.Enabled:=Browse;
  actUltimo.Enabled:=Browse;
  actEstrai.Enabled:=Browse;
  actPrecedenteStorico.Enabled:=Browse;
  actSuccessivoStorico.Enabled:=Browse;
  actSelezioneStorico.Enabled:=Browse;
  actElimina.Enabled:=Browse and (not SolaLettura);
  actNuovo.Enabled:=Browse and (not SolaLettura);
  actModifica.Enabled:=Browse and (not SolaLettura);
  actCopiaSu.Enabled:=Browse and (not SolaLettura);
  actAggiorna.Enabled:=Browse;
  actConferma.Enabled:=(not Browse) and (not SolaLettura);
  actAnnulla.Enabled:=not Browse;
  actInsertSubSqlProgr.Enabled:=not Browse;
  actInsertSubSqlJoin.Enabled:=not Browse;
  actInsertSubSqlExist.Enabled:=not Browse;
  actEsegui.Enabled:=True;
  actPulisci.Enabled:=Browse;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  grdC700.AggiornaGrdToolBar;
  if Browse then
    IsModificaAction:=False;
end;

procedure TWA062FQueryServizio.AbilitaTab(abilitazione: boolean; frame: array of TFrame);
var i,j:Integer;
begin
  for i:=0 to (grdTabControl.TabCount-1) do
    if Length(frame) = 0 then
      grdTabControl.TabByIndex(i).Enabled:=abilitazione
    else
    begin
      grdTabControl.TabByIndex(i).Enabled:=not abilitazione;
      for j:=0 to High(frame) do
        if grdTabControl.TabByIndex(i) = grdTabControl.Tabs[frame[j]] then
          grdTabControl.TabByIndex(i).Enabled:=abilitazione;
    end;
end;

procedure TWA062FQueryServizio.actInsertSubSqlProgrExecute(Sender: TObject);
begin
  grdTabControl.ActiveTab:=WDettaglioFM;
  (WDettaglioFM as TWA062FQueryServizioDettFM).InserisciSqlProgressivo;
end;

procedure TWA062FQueryServizio.actInsertSubSqlJoinExecute(Sender: TObject);
begin
  grdTabControl.ActiveTab:=WDettaglioFM;
  (WDettaglioFM as TWA062FQueryServizioDettFM).InserisciSqlJoin;
end;

procedure TWA062FQueryServizio.actInsertSubSqlExistExecute(Sender: TObject);
begin
  grdTabControl.ActiveTab:=WDettaglioFM;
  (WDettaglioFM as TWA062FQueryServizioDettFM).InserisciSqlExist;
end;

end.
