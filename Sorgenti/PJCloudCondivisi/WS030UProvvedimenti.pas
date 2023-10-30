unit WS030UProvvedimenti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, meIWRadioGroup, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, DB, StrUtils, WS030UDettaglioFM, medpIWMessageDlg,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, A000UInterfaccia, A000UCostanti, A000UMessaggi,
  IWCompEdit, meIWEdit;

type
  TWS030FProvvedimenti = class(TWR102FGestTabella)
    lblVisualizza: TmeIWLabel;
    rgpVisualizza: TmeIWRadioGroup;
    lblModalita: TmeIWLabel;
    rgpModalita: TmeIWRadioGroup;
    actVisualizzaAnomalie: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actVisualizzaAnomalieExecute(Sender: TObject);
    procedure rgpVisualizzaClick(Sender: TObject);
    procedure rgpModalitaClick(Sender: TObject);
    procedure grdTabControlTabControlChange(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    { Private declarations }
    CodeAC: String;
    EsistonoMsgAnomalie:Boolean;
    procedure AbilitaAzioni(Abilita: Boolean);
    procedure ImpostaTestoJQ(NomeLogico:String;NomeComponente:String);
  public
    { Public declarations }
    WS030Dett:TWS030FDettaglioFM;
    function InizializzaAccesso:Boolean; override;
    procedure selTabellaStateChange(DataSet: TDataSet); override;
    procedure AbilitaComponenti(Abilita:Boolean);
    procedure CaricaJQAutocomplete;
    procedure AbilitaJqAutocomplete(Val:Boolean);
  protected
    //Elaborazione senza ProgressBar
    procedure InizializzaMsgElaborazione; override;
    procedure ElaborazioneServer; override;
  end;

implementation

uses WS030UProvvedimentiDM, WS030UProvvedimentiBrowseFM, WS030UProvvedimentiDettFM;

{$R *.dfm}

procedure TWS030FProvvedimenti.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  WR302DM:=TWS030FProvvedimentiDM.Create(Self);
  WBrowseFM:=TWS030FProvvedimentiBrowseFM.Create(Self);
  WDettaglioFM:=TWS030FProvvedimentiDettFM.Create(Self);
  WS030Dett:=TWS030FDettaglioFM.Create(Self);
  AttivaGestioneC700;
  grdTabControl.AggiungiTab('Elenco provvedimenti',WBrowseFM);
  grdTabControl.AggiungiTab('Dettaglio',WDettaglioFM);
  grdTabControl.AggiungiTab('Dettaglio provvedimento',WS030Dett);
  grdTabControl.HasFiller:=True;
  grdTabControl.ActiveTab:=WBrowseFM;
  EsistonoMsgAnomalie:=False;
  if Parametri.CampiRiferimento.C14_ProvvSede <> '' then
  begin
    (WDettaglioFM as TWS030FProvvedimentiDettFM).lblSede.Enabled:=True;
    (WDettaglioFM as TWS030FProvvedimentiDettFM).lblSede.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C14_ProvvSede,1,1)) + LowerCase(Copy(Parametri.CampiRiferimento.C14_ProvvSede,2,Length(Parametri.CampiRiferimento.C14_ProvvSede)-1));
  end;
end;

function TWS030FProvvedimenti.InizializzaAccesso: Boolean;
var CampoProvv: string;
    Progressivo:Integer;
begin
  Result:=True;
  // progressivo
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  CampoProvv:=GetParam('CAMPO');
  with (WR302DM as TWS030FProvvedimentiDM).S030MW do
  begin
    selAnagrafe:=grdC700.selAnagrafe;
    if CampoProvv <> '' then
      grdTabControl.ActiveTab:=WDettaglioFM;
    CambiaProgressivo(CampoProvv);
    if SelSG100.State = dsBrowse then
    begin
      FiltroProvvedimenti(rgpVisualizza.ItemIndex);
      WBrowseFM.grdTabella.medpAggiornaCDS;
    end
    else
      (WDettaglioFM as TWS030FProvvedimentiDettFM).cmbDato.Text:=CampoProvv;
  end;
  Result:=True;
end;

procedure TWS030FProvvedimenti.IWAppFormRender(Sender: TObject);
begin
  inherited;
  if (WR302DM as TWS030FProvvedimentiDM).S030MW.NomeModello = '' then
  begin
    WS030Dett.lblFileSceltoDescr.Caption:=C004DM.GetParametro('NOMECERT','');
    WS030Dett.lblFileScelto.Caption:='Ultimo file scelto';
  end
  else
  begin
    WS030Dett.lblFileSceltoDescr.Caption:=ExtractFileName((WR302DM as TWS030FProvvedimentiDM).S030MW.NomeModello);
    WS030Dett.lblFileScelto.Caption:='Nome file scelto';
  end;
  (WR302DM as TWS030FProvvedimentiDM).S030MW.selSG104.Open;//Ha effetto se è stato chiuso precedentemente quando ho effettuato l'accesso alla maschera tramite lnkMotivazione
end;

procedure TWS030FProvvedimenti.selTabellaStateChange(DataSet: TDataSet);
begin
  inherited;
  AbilitaComponenti(True);
end;

procedure TWS030FProvvedimenti.grdTabControlTabControlChange(Sender: TObject);
begin
  inherited;
  if grdTabControl.ActiveTab = WS030Dett then
  begin
    grdC700.AbilitaToolBar(False);
    WS030Dett.Visualizza;
    AbilitaComponenti(False);
    AbilitaAzioni(False);
  end
  else
  begin
    grdC700.AbilitaToolBar(True);
    AbilitaComponenti(True);
    AbilitaAzioni(True);
  end;
end;

procedure TWS030FProvvedimenti.rgpVisualizzaClick(Sender: TObject);
begin
  inherited;
  (WR302DM as TWS030FProvvedimentiDM).S030MW.FiltroProvvedimenti(rgpVisualizza.ItemIndex);
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWS030FProvvedimenti.rgpModalitaClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(True);
  AbilitaAzioni(True);
end;

procedure TWS030FProvvedimenti.AbilitaComponenti(Abilita:Boolean);
begin
  if WR302DM <> nil then
    with WR302DM.SelTabella do
    begin
      rgpModalita.Enabled:=Abilita and (State = dsBrowse);
      rgpVisualizza.Enabled:=Abilita and (State = dsBrowse);
      if grdTabControl.TabByIndex(2) <> nil then
        grdTabControl.TabByIndex(2).Enabled:=(rgpModalita.ItemIndex = 0) and (State = dsBrowse)  and (Trim(FieldByName('CAUSALE').AsString) <> '');
    end;
end;

procedure TWS030FProvvedimenti.AbilitaAzioni(Abilita:Boolean);
var ModCollettiva:Boolean;
begin
  ModCollettiva:=rgpModalita.ItemIndex = 1;
  actVisualizzaAnomalie.Enabled:=Abilita and EsistonoMsgAnomalie;
  actNuovo.Enabled:=Abilita and not SolaLettura;
  actModifica.Enabled:=Abilita and not ModCollettiva and not SolaLettura;
  actElimina.Enabled:=Abilita and not SolaLettura;
  actAnnulla.Enabled:=actAnnulla.Enabled and Abilita and (WR302DM.SelTabella.State = dsBrowse);
  actConferma.Enabled:=actConferma.Enabled and Abilita and (WR302DM.SelTabella.State = dsBrowse);
  actAggiorna.Enabled:=Abilita and not ModCollettiva;
  actRicerca.Enabled:=Abilita and not ModCollettiva;
  actEstrai.Enabled:=Abilita and not ModCollettiva;
  actPrimo.Enabled:=Abilita and not ModCollettiva;
  actPrecedente.Enabled:=Abilita and not ModCollettiva;
  actSuccessivo.Enabled:=Abilita and not ModCollettiva;
  actUltimo.Enabled:=Abilita and not ModCollettiva;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWS030FProvvedimenti.actNuovoExecute(Sender: TObject);
begin
  inherited;
  CaricaJQAutocomplete;
  AbilitaJqAutocomplete(True);
end;

procedure TWS030FProvvedimenti.actModificaExecute(Sender: TObject);
begin
  inherited;
  CaricaJQAutocomplete;
  AbilitaJqAutocomplete(True);
end;

procedure TWS030FProvvedimenti.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  AbilitaAzioni(True);
  AbilitaComponenti(True);
  AbilitaJqAutocomplete(False);
end;

procedure TWS030FProvvedimenti.actConfermaExecute(Sender: TObject);
begin
  EsistonoMsgAnomalie:=False;
  if rgpModalita.ItemIndex = 0 then
    //Modalità singola
    inherited
  else
  begin
    //Modalità collettiva
    (WR302DM as TWS030FProvvedimentiDM).evtRichiesta((WR302DM as TWS030FProvvedimentiDM).S030MW.RecuperaTestoDomandaCollettiva('I'),'InsColl');
    MsgBox.ClearKeys;
    (WR302DM as TWS030FProvvedimentiDM).S030MW.Inserimento;
    EsistonoMsgAnomalie:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
    WBrowseFM.grdTabella.medpAggiornaCDS;
    AbilitaAzioni(True);
    AbilitaComponenti(True);
    if EsistonoMsgAnomalie then
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_ANOMALIE,mtInformation,[mbOk],nil,'')
    else
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA,mtInformation,[mbOk],nil,'');
  end;
  AbilitaJqAutocomplete(False);
end;

procedure TWS030FProvvedimenti.actEliminaExecute(Sender: TObject);
begin
  EsistonoMsgAnomalie:=False;
  if rgpModalita.ItemIndex = 0 then
    //Modalità singola
    inherited
  else
  begin
    //Modalità collettiva
    (WR302DM as TWS030FProvvedimentiDM).evtRichiesta((WR302DM as TWS030FProvvedimentiDM).S030MW.RecuperaTestoDomandaCollettiva('C'),'DelColl');
    MsgBox.ClearKeys;
    (WR302DM as TWS030FProvvedimentiDM).S030MW.Cancellazione;
    EsistonoMsgAnomalie:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
    WBrowseFM.grdTabella.medpAggiornaCDS;
    AbilitaAzioni(True);
    if EsistonoMsgAnomalie then
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_ANOMALIE,mtInformation,[mbOk],nil,'')
    else
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA,mtInformation,[mbOk],nil,'');
  end;
end;

procedure TWS030FProvvedimenti.CaricaJQAutocomplete;
begin
  CodeAC:='';
  jQAutocomplete.Enabled:=True;
  jQAutocomplete.OnReady.Clear;
  ImpostaTestoJQ('TIPOATTO',(WDettaglioFM as TWS030FProvvedimentiDettFM).dedtTipoAtto.HTMLName);
  ImpostaTestoJQ('AUTORITA',(WDettaglioFM as TWS030FProvvedimentiDettFM).dedtAutorita.HTMLName);
  jQAutocomplete.OnReady.Add(CodeAC);
end;

procedure TWS030FProvvedimenti.ImpostaTestoJQ(NomeLogico:String;NomeComponente:String);
var Elementi:String;
    Lista:TStringList;
    i:Integer;
begin
  if NomeLogico = 'TIPOATTO' then
  begin
    (WR302DM as TWS030FProvvedimentiDM).S030MW.CaricaListaTipoAtto;
    Lista:=(WR302DM as TWS030FProvvedimentiDM).S030MW.lstTipoAtto;
  end
  else if NomeLogico = 'AUTORITA' then
  begin
    (WR302DM as TWS030FProvvedimentiDM).S030MW.CaricaListaAutorita;
    Lista:=(WR302DM as TWS030FProvvedimentiDM).S030MW.lstAutorita;
  end
  else
    exit;

  // prepara autocomplete
  if Lista.Count > 0 then
  begin
    //Ciclo su Lista per mantenere le virgole interne al testo delle singole opzioni:
    for i:=0 to Lista.Count - 1 do
      Elementi:=Elementi + IfThen(Elementi <> '',''',''') + C190EscapeJS(Lista[i]);
    Elementi:='''' + Elementi + '''';
    CodeAC:=CodeAC + CRLF +
            'var elementi = [' + Elementi + ']; ' + CRLF +
            '$("#' + NomeComponente + '").autocomplete({ ' + CRLF +
            '  source: elementi, ' + CRLF +
            '  delay: 0,' + CRLF +
            '  minLength: 0' + CRLF +
            '}).focus(function(){ ' + CRLF +
            '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
            '}); ';
  end;
end;

procedure TWS030FProvvedimenti.AbilitaJqAutocomplete(Val:Boolean);
begin
  jQAutocomplete.OnReady.Clear;
  jQAutocomplete.OnReady.Add(IfThen(Val,CodeAC));
end;

procedure TWS030FProvvedimenti.actVisualizzaAnomalieExecute(Sender: TObject);
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

procedure TWS030FProvvedimenti.InizializzaMsgElaborazione;
begin
  with WC022FMsgElaborazioneFM do
  begin
    Messaggio:=A000MSG_MSG_ELABORAZIONE;
    Titolo:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
    ImgFileName:=IMG_FILENAME_ELABORAZIONE;
  end;
end;

procedure TWS030FProvvedimenti.ElaborazioneServer;
var i:Integer;
begin
  with (WR302DM as TWS030FProvvedimentiDM).S030MW do
  begin
    try
      Elaborazione_Cancella;
      //Carico i valori precedenti risultanti dalle query di P660 a Decorrenza-1
      for i:=0 to lstNumeriPrec.Count - 1 do
        Elaborazione_InserisciPrec(lstNumeriPrec.Strings[i]);
      SessioneOracle.Commit;
      selSG095.Refresh;
      //Carico i valori successivi risultanti dalle query di P660 a Decorrenza
      for i:=0 to lstNumeriSucc.Count - 1 do
        Elaborazione_InserisciSucc(lstNumeriSucc.Strings[i]);
      SessioneOracle.Commit;
      selSG095.Refresh;
      selSG095.First;
    finally
      WS030Dett.dgrdDettProvv.medpAggiornaCDS;
    end;
    DCOMMsg:=A000MSG_MSG_ELAB_OK;
  end;
end;

end.
