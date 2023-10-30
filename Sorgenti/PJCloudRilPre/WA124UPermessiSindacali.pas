unit WA124UPermessiSindacali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, meIWImageFile,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, A000UMessaggi, A000UInterfaccia, A000UCostanti,
  WC700USelezioneAnagrafeFM, StrUtils, Math, OracleData, WA124USuperoCompetenzeFM,
  meIWImage, WA124UInvioPermessiFM, IWCompEdit, meIWEdit, Oracle;

type
  TWA124FPermessiSindacali = class(TWR102FGestTabella)
    actAnomalie: TAction;
    actCartellino: TAction;
    actPermessiAnnoCorrente: TAction;
    actPermessiNonCancellati: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actPermessiNonCancellatiExecute(Sender: TObject);
    procedure actPermessiAnnoCorrenteExecute(Sender: TObject);
    procedure actCopiaSuExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actCartellinoExecute(Sender: TObject);
    procedure actAnomalieExecute(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure grdTabControlTabControlChange(Sender: TObject);
  private
    { Private declarations }
    (*AzioneCollettiva:String;*)
    (*WA124SupComp: TWA124FSuperoCompetenzeFM;*)
    WA124Invio:TWA124FInvioPermessiFM;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    (*procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;*)
  public
    procedure ApriSelTabella;
    procedure AbilitaRitornaallostatoModificato;
 protected
    procedure ImpostazioniWC700; override;
    procedure InizializzaMsgElaborazione; override;
    procedure ElaborazioneServer; override;
  end;

implementation

uses WA124UPermessiSindacaliDM, WA124UPermessiSindacaliBrowseFM, WA124UPermessiSindacaliDettFM, C180FunzioniGenerali;

{$R *.dfm}

procedure TWA124FPermessiSindacali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA124FPermessiSindacaliDM.Create(Self);
  AttivaGestioneC700;
  grdC700.WC700FM.ResultEvent:=ResultWC700;
  (WR302DM as TWA124FPermessiSindacaliDM).A124MW.SelAnagrafe:=grdC700.selAnagrafe;

  WBrowseFM:=TWA124FPermessiSindacaliBrowseFM.Create(Self);
  WDettaglioFM:=TWA124FPermessiSindacaliDettFM.Create(Self);
  WA124Invio:=TWA124FInvioPermessiFM.Create(Self);

  CreaTabDefault;
  grdTabControl.AggiungiTab('Invio tramite WebService',WA124Invio);
  grdTabControl.ActiveTab:=WBrowseFM;

  actAnomalie.Enabled:=False;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWA124FPermessiSindacali.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(WA124Invio);//.Free;
  inherited;
end;

procedure TWA124FPermessiSindacali.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ',''(Contr.''||T430CONTRATTO||'')'' CONTRATTO';
  grdC700.WC700FM.C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME,CONTRATTO';
end;

procedure TWA124FPermessiSindacali.ResultWC700(Sender: TObject; Result: Boolean);
begin
  if Result then
  begin
    actCartellino.Enabled:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger <> 0;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
end;

procedure TWA124FPermessiSindacali.ApriSelTabella;
begin
  with WR302DM do
  begin
    SelTabella.Close;
    SelTabella.SetVariable('PROGRESSIVO',grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SelTabella.Open;
    DsrTabella.DataSet:=SelTabella;
    WBrowseFM.grdTabella.medpAttivaGrid(SelTabella,false,false);
    InterfacciaWR102.NomeTabella:=UpperCase(R180Query2NomeTabella(selTabella));
  end;
end;

procedure TWA124FPermessiSindacali.grdTabControlTabControlChange(Sender: TObject);
begin
  inherited;
  if grdTabControl.ActiveTab = WA124Invio then
  begin
    with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    begin
      grdC700.WC700FM.C700MergeSelAnagrafe(selT248NoGEDAP);
      grdC700.WC700FM.C700MergeSettaPeriodo(selT248NoGEDAP,Parametri.DataLavoro,Parametri.DataLavoro);
    end;
    WA124Invio.CaricaDatiIniziali;
    grdC700.AbilitaToolBar(False);
    AbilitaToolBar(grdNavigatorBar,False,actlstNavigatorBar);
  end
  else
  begin
    grdC700.AbilitaToolBar(True);
    AbilitaToolBar(grdNavigatorBar,True,actlstNavigatorBar);
    actAnomalie.Enabled:=False;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
end;

procedure TWA124FPermessiSindacali.AbilitaRitornaallostatoModificato;
begin
  if WDettaglioFM <> nil then
    with (WDettaglioFM as TWA124FPermessiSindacaliDettFM),(WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    begin
      RitornaallostatoModificato1.Enabled:=(not SolaLettura) (*and (not SelezioneCollettiva)*) and (selT248.FieldByName('STATO').AsString = 'C');
      if RitornaallostatoModificato1.Enabled then
        RitornaallostatoModificato1.OnClick:=RitornaallostatoMODIFICATO1Click
      else
        RitornaallostatoModificato1.OnClick:=nil;
    end;
end;

procedure TWA124FPermessiSindacali.actPermessiNonCancellatiExecute(Sender: TObject);
begin
  inherited;
  actPermessiNonCancellati.Checked:=not actPermessiNonCancellati.Checked;
  actPermessiNonCancellati.Hint:=IfThen(actPermessiNonCancellati.Checked,'Visualizza anche','Nascondi') + ' permessi CANCELLATI';
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  (WR302DM as TWA124FPermessiSindacaliDM).A124MW.ImpostaFiltroPermessi(actPermessiNonCancellati.Checked,actPermessiAnnoCorrente.Checked);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA124FPermessiSindacali.actPermessiAnnoCorrenteExecute(Sender: TObject);
begin
  inherited;
  actPermessiAnnoCorrente.Checked:=not actPermessiAnnoCorrente.Checked;
  actPermessiAnnoCorrente.Hint:=IfThen(actPermessiAnnoCorrente.Checked,'Disattiva','Attiva') + ' visione anno corrente';
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  (WR302DM as TWA124FPermessiSindacaliDM).A124MW.ImpostaFiltroPermessi(actPermessiNonCancellati.Checked,actPermessiAnnoCorrente.Checked);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA124FPermessiSindacali.actCopiaSuExecute(Sender: TObject);
begin
  actAnomalie.Enabled:=False;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  grdTabControl.ActiveTab:=WDettaglioFM;
  with (WR302DM as TWA124FPermessiSindacaliDM) do
  begin
    A124MW.CopiaPermesso;
    A124MW.selT248.OnNewRecord:=OnNewRecord;//tolto in CopiaPermesso
  end;
end;

procedure TWA124FPermessiSindacali.actNuovoExecute(Sender: TObject);
begin
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    Azione:='';
    if SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger <= 0 then
      raise exception.create(A000MSG_ERR_NO_DIP);
  end;
  actAnomalie.Enabled:=False;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  inherited;
end;

procedure TWA124FPermessiSindacali.actModificaExecute(Sender: TObject);
begin
  if SolaLettura then
    exit;
  if (WR302DM as TWA124FPermessiSindacaliDM).A124MW.selT248.FieldByName('STATO').AsString = 'C' then
    raise exception.Create(Format(A000MSG_A124_ERR_FMT_PERM_CANCELLATO,['modificare']))
  else
  begin
    (WR302DM as TWA124FPermessiSindacaliDM).A124MW.Azione:='M';
    actAnomalie.Enabled:=False;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    inherited;
  end;
end;

procedure TWA124FPermessiSindacali.actEliminaExecute(Sender: TObject);
begin
  if Sender = actElimina then //azione standard
  begin
    actAnomalie.Enabled:=False;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    grdTabControl.ActiveTab:=WDettaglioFM;
    (WR302DM as TWA124FPermessiSindacaliDM).A124MW.Azione:='C';
    (*if (WR302DM as TWA124FPermessiSindacaliDM).A124MW.SelezioneCollettiva then
      WR302DM.selTabella.Insert//Inserimento fittizio
    else*)
      WR302DM.selTabella.Edit;
  end
  else  //pulsante sul Dettaglio
  begin
    (*if (WR302DM as TWA124FPermessiSindacaliDM).A124MW.SelezioneCollettiva then
    begin
      with (WDettaglioFM as TWA124FPermessiSindacaliDettFM),(WR302DM as TWA124FPermessiSindacaliDM) do
      begin
        selTabella.FieldByName('COD_SINDACATO').AsString:=cmbSindacato.Text;
        selTabella.FieldByName('COD_ORGANISMO').AsString:=cmbOrganismo.Text;
      end;
      (WR302DM as TWA124FPermessiSindacaliDM).A124MW.ProceduraChiamante:=1;
      if not MsgBox.KeyExists('CancellazioneCollettiva') then
        (WR302DM as TWA124FPermessiSindacaliDM).A124MW.PreparaCancellazioneCollettiva('E');
      AzioneCollettiva:='C';
      MsgBox.ClearKeys;
      WR302DM.SelTabella.Cancel;//Annulla l'inserimento fittizio
      (WR302DM as TWA124FPermessiSindacaliDM).A124MW.Conta:=0;
      StartElaborazioneCiclo((WDettaglioFM as TWA124FPermessiSindacaliDettFM).btnCompetenze.HTMLName);
    end
    else*)
      inherited;
      actAnomalie.Enabled:=RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB;
      AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
end;

procedure TWA124FPermessiSindacali.actConfermaExecute(Sender: TObject);
begin
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    ProceduraChiamante:=0;
    with (WDettaglioFM as TWA124FPermessiSindacaliDettFM),(WR302DM as TWA124FPermessiSindacaliDM) do
    begin
      selTabella.FieldByName('COD_SINDACATO').AsString:=cmbSindacato.Text;
      selTabella.FieldByName('COD_ORGANISMO').AsString:=cmbOrganismo.Text;
    end;
    Controlli;
    (*if SelezioneCollettiva then //Inserimento collettivo
    begin
      if Azione = 'C' then
      begin
        if not MsgBox.KeyExists('CancellazioneCollettiva') then
          PreparaCancellazioneCollettiva('C');
        AzioneCollettiva:='C';
      end
      else
      begin
        if not MsgBox.KeyExists('InserimentoCollettivo') then
        begin
          PreparaInserimentoCollettivo;
          ImpostaFiltroInserimentoCollettivo;
        end;
        AzioneCollettiva:='I';
      end;
      MsgBox.ClearKeys;
      WR302DM.SelTabella.Cancel;//Annulla l'inserimento fittizio
      Conta:=0;
      StartElaborazioneCiclo((WDettaglioFM as TWA124FPermessiSindacaliDettFM).btnCompetenze.HTMLName);
    end
    else
    begin*) //Inserimento singolo
      inherited;
      actAnomalie.Enabled:=RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB;
      AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    (*end;*)
  end;
end;

procedure TWA124FPermessiSindacali.actCartellinoExecute(Sender: TObject);
var Params: String;
begin
  inherited;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    Params:='PROGRESSIVO=' + selAnagrafe.FieldByName('PROGRESSIVO').AsString + ParamDelimiter +
            'DATARIF=' + DataSetInUso.FieldByName('DATA').AsString;
  AccediForm(7,Params,True);
end;

procedure TWA124FPermessiSindacali.actAnomalieExecute(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B';
  accediForm(201,Params,False);
end;

(*procedure TWA124FPermessiSindacali.InizioElaborazione;
begin
  inherited;
  actAnomalie.Enabled:=False;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if SuperoCompetResiduo = '' then
    begin
      OldProg:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
      if AzioneCollettiva = 'I' then
      begin
        SelAnagrafe.Filtered:=True;
        SelAnagrafe.First;
      end;
    end;
end;

function TWA124FPermessiSindacali.CurrentRecordElaborazione: Integer;
begin
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    Result:=IfThen(AzioneCollettiva = 'I',SelAnagrafe.RecNo,Conta);
end;

function TWA124FPermessiSindacali.TotalRecordsElaborazione: Integer;
begin
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if AzioneCollettiva = 'I' then
    begin
      Result:=IfThen(SelAnagrafe.Eof,0,SelAnagrafe.RecordCount);
      if SelAnagrafe.Eof then
        SuperoCompetResiduo:='';
    end
    else
      Result:=selT248Canc.RecordCount;
end;

procedure TWA124FPermessiSindacali.ElaboraElemento;
var DS:TOracleDataSet;
    msg:String;
begin
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    if AzioneCollettiva = 'I' then
      DS:=SelAnagrafe
    else
      DS:=selT248Canc;
    CercaDip(DS.FieldByName('PROGRESSIVO').AsInteger);
    if AzioneCollettiva = 'I' then
    begin
      InserisciPermesso;
      msg:='';
      try
        SuperoCompetResiduo:='';
        selT248.Post;
        Conta:=Conta+1;
      except
        on E:exception do
          msg:=E.Message;
      end;
      if SuperoCompetResiduo <> '' then //Nel caso di 'supero competenze' richiedo nuovi valori
      begin
        selT248.Cancel;
        //Interruzione del Ciclo-->Finalizzazione-->Richiama WA124SuperoComp.Visualizza
        WC019FProgressBarFM.chkInterrompiElaborazione.Checked:=True;
        WC019FProgressBarFM.NascondiFinalizzazione:=True;
        exit;
      end
      else if msg <> '' then  //Nel caso di exception generica carico il Messaggio sulla ListaAnomalie
      begin
        RegistraMsg.InserisciMessaggio('A',Nominativo + ': Inserimento fallito - ' + msg,'',DS.FieldByName('PROGRESSIVO').AsInteger);
        selT248.Cancel;
      end;
    end
    else
      CancellaPermesso;
  end;
end;

function TWA124FPermessiSindacali.ElementoSuccessivo: Boolean;
var DS:TOracleDataSet;
begin
  Result:=False;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if SuperoCompetResiduo <> '' then
      exit;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if AzioneCollettiva = 'I' then
      DS:=SelAnagrafe
    else
      DS:=selT248Canc;
  with DS do
  begin
    if (AzioneCollettiva = 'I') or (VarToStr(GetVariable('TIPO')) = 'C') then
      Next;
    SessioneOracle.Commit;
    if not EOF then
      Result:=True;
  end;
end;

procedure TWA124FPermessiSindacali.FineCicloElaborazione;
begin
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if SuperoCompetResiduo <> '' then
    begin
      WC019FProgressBarFM.chkInterrompiElaborazione.Checked:=False;
      exit;
    end;
  if AzioneCollettiva = 'I' then
    (WR302DM as TWA124FPermessiSindacaliDM).A124MW.SelAnagrafe.Filtered:=False;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    CercaDip(OldProg);
  WC700CambioProgressivo(nil);//Riapre il SelTabella con l'OldProg
  actAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

function TWA124FPermessiSindacali.ElaborazioneTerminata: String;
begin
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if SuperoCompetResiduo <> '' then
    begin
      Result:='';
      WA124SupComp:=TWA124FSuperoCompetenzeFM.Create(Self);
      with WA124SupComp do
      begin
        lblNominativo.Caption:=Nominativo;
        lblResiduo.Caption:=SuperoCompetResiduo;
        Visualizza;
      end;
      exit;
    end
    else
    begin
      Result:=Format(IfThen(AzioneCollettiva = 'I',A000MSG_A124_MSG_FMT_PERMESSI_INSERITI,IfThen(VarToStr(selT248Canc.GetVariable('TIPO')) = 'C',A000MSG_A124_MSG_FMT_PERMESSI_STATO_CANC,A000MSG_A124_MSG_FMT_PERMESSI_CANCELLATI)),[IntToStr(Conta)]);
      if (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
        Result:=Result + #$D#$A + A000MSG_MSG_ELABORAZIONE_ANOMALIE;
    end;
end;*)

procedure TWA124FPermessiSindacali.InizializzaMsgElaborazione;
begin
  with WC022FMsgElaborazioneFM do
  begin
    Messaggio:=A000MSG_MSG_ELABORAZIONE;
    Titolo:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
    ImgFileName:=IMG_FILENAME_ELABORAZIONE;
  end;
end;

procedure TWA124FPermessiSindacali.ElaborazioneServer;
begin
  WA124Invio.btnAnomalie.Enabled:=False;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    selT248NoGEDAP.First;
    try
      RegistraMsg.IniziaMessaggio(medpCodiceForm);
      try
        WSGEDAP(selT248NoGEDAP,True);
      finally
        SessioneOracle.Commit;
        selT248NoGEDAP.Refresh;
        selT248NoGEDAP.First;
      end;
    finally //gestito in caso di abort in WSGEDAP
      WA124Invio.btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
      if RegistraMsg.ContieneTipoA then
        DCOMMsg:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
    end;
  end;
end;

end.
