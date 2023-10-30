unit WA136URelazioniAnagrafe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink,OracleData, A000UMessaggi,C180FunzioniGenerali,
  WA136UComponiRelazioneFM,WA136UStampaRelazioniFM,medpIWMessageDlg,A000UInterfaccia,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWCompButton, meIWButton, System.Actions, meIWImageFile, DB, IWApplication,
  IWCompEdit, meIWEdit;

type
  TWA136FRelazioniAnagrafe = class(TWR102FGestTabella)
    lblCampo1NonEsistente: TmeIWLabel;
    lblCampo2NonEsistente: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure grdTabControlTabControlChanging(Sender: TObject;var AllowChange: Boolean);
    procedure grdTabControlTabControlChange(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
  private
    DettRelazione: TStringList;
    FTabFrom: TControl;
    msgSegnalaAnomaliaOrdine:String;
    FRichiamoEsterno: Boolean;
    procedure ImpostaMsgWarning(Tipo, Campo: String);
  protected
    procedure SalvaValoriOriginali; override;
    procedure RipristinaValoriOriginali; override;
  public
    WComponiRelazioneFM: TWA136FComponiRelazioneFM;
    WStampaRelazioniFM: TWA136FStampaRelazioniFM;
    procedure AbilitaStampaRelazione(Abilita: Boolean);
    procedure AbilitaComponiRelazione(Abilita: Boolean);
    procedure AbilitaDettaglio(Abilita: Boolean);
    procedure AttivaComponiRelazione;
    function InizializzaAccesso:Boolean; override;
    procedure SegnalaAnomaliaOrdine;
  end;

implementation

uses
  WA136URelazioniAnagrafeDM,
  WA136URelazioniAnagrafeBrowseFM,
  WA136URelazioniAnagrafeDettFM;

{$R *.dfm}

{ TWA136FRelazioniAnagrafe }

procedure TWA136FRelazioniAnagrafe.AbilitaStampaRelazione(Abilita: Boolean);
begin
  if WStampaRelazioniFM <> nil then
    grdTabControl.Tabs[WStampaRelazioniFM].Enabled:=Abilita;
end;

procedure TWA136FRelazioniAnagrafe.AbilitaComponiRelazione(Abilita: Boolean);
begin
  if WComponiRelazioneFM <> nil then
    grdTabControl.Tabs[WComponiRelazioneFM].Enabled:=Abilita;
end;

procedure TWA136FRelazioniAnagrafe.AbilitaDettaglio(Abilita: Boolean);
begin
  if WDettaglioFM <> nil then
    grdTabControl.Tabs[WDettaglioFM].Enabled:=Abilita;
end;

procedure TWA136FRelazioniAnagrafe.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  if FRichiamoEsterno then //Quando accedo da A002, chiudo la maschera degli abbinamenti e posso intervenire sulla relazione ma annullo lo stato di modifica
    SegnalaAnomaliaOrdine;
end;

procedure TWA136FRelazioniAnagrafe.actEliminaExecute(Sender: TObject);
begin
  if not(TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.VerificaCampiAbilitati(Self.SolaLettura)) then
  begin
    MsgBox.MessageBox(A000MSG_A136_ERR_UTENTE_NO_CAMPO,ERRORE);
    Abort;
  end;

  inherited;
end;

procedure TWA136FRelazioniAnagrafe.actModificaExecute(Sender: TObject);
begin
  if not(TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.VerificaCampiAbilitati(Self.SolaLettura)) then
  begin
    MsgBox.MessageBox(A000MSG_A136_ERR_UTENTE_NO_CAMPO,ERRORE);
    Abort;
  end;

  inherited;
end;

procedure TWA136FRelazioniAnagrafe.AttivaComponiRelazione;
begin
  grdTabControl.OnTabControlChanging:=nil;
  grdTabControl.OnTabControlChange:=nil;
  TWA136FComponiRelazioneFM(WComponiRelazioneFM).ImpostaStato;
  grdTabControl.ActiveTab:=WComponiRelazioneFM;
  grdTabControl.OnTabControlChanging:=grdTabControlTabControlChanging;
  grdTabControl.OnTabControlChange:=grdTabControlTabControlChange;
  if TWA136FRelazioniAnagrafeDM(WR302DM).selTabella.State in [dsEdit,dsInsert] then
    AbilitaDettaglio(False);
  AbilitaToolBar(grdNavigatorBar,False,actlstNavigatorBar);
end;

procedure TWA136FRelazioniAnagrafe.grdTabControlTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  if (grdTabControl.ActiveTab = WComponiRelazioneFM)
  or (grdTabControl.ActiveTab = WStampaRelazioniFM) then
    AbilitaToolBar(grdNavigatorBar,True,actlstNavigatorBar)
  else
    FTabFrom:=grdTabControl.ActiveTab; //per riposizionamento tab in caso di  dialog di conferma di WComponiRelazioneFM
end;

procedure TWA136FRelazioniAnagrafe.grdTabControlTabControlChange(Sender: TObject);
begin
  inherited;
  //se sto selezionando il tab Componi Relazione eseguo verifiche
  if grdTabControl.ActiveTab = WComponiRelazioneFM then
  begin
    if (not TWA136FComponiRelazioneFM(WComponiRelazioneFM).CaricaDatiIniziali) then
    begin
      //non devo scatenare tab change
      grdTabControl.OnTabControlChanging:=nil;
      grdTabControl.OnTabControlChange:=nil;
      grdTabControl.ActiveTab:=FTabFrom;
      grdTabControl.OnTabControlChanging:=grdTabControlTabControlChanging;
      grdTabControl.OnTabControlChange:=grdTabControlTabControlChange;
    end
    else
      AttivaComponiRelazione;
  end
  else if grdTabControl.ActiveTab = WStampaRelazioniFM then
  begin
    WStampaRelazioniFM.CaricaDatiIniziali;
    AbilitaToolBar(grdNavigatorBar,False,actlstNavigatorBar);
  end;
end;

function TWA136FRelazioniAnagrafe.InizializzaAccesso: Boolean;
var
  Tabella, Colonna: String;
  Data: TDateTime;
begin
  Tabella:=Trim(GetParam('TABELLA'));
  Colonna:=Trim(GetParam('COLONNA'));
  if GetParam('DATA') <> '' then
    Data:=StrToDate(GetParam('DATA'));

  if (Tabella <> '') and (Colonna <> '') then
  begin
    FRichiamoEsterno:=True;
    actVisioneCorrenteExecute(nil);
    with TWA136FRelazioniAnagrafeDM(WR302DM) do
    begin
      selTabella.Last;
      if selTabella.SearchRecord('TABELLA;COLONNA',VarArrayOf([Tabella,Colonna]),[srFromEnd])then
      begin
        repeat
          if  (Data >= selTabella.FieldByName('DECORRENZA').AsDateTime)
          and (Data <= selTabella.FieldByName('DECORRENZA_FINE').AsDateTime) then
            Break;
        until not selTabella.SearchRecord('TABELLA;COLONNA',VarArrayOf([Tabella,Colonna]),[srBackward]);
      end;
      WBrowseFM.grdTabella.medpAggiornaCds(False);

      if not SolaLettura and actModifica.Enabled then
        actModificaExecute(actModifica);

      if grdTabControl.Tabs[WComponiRelazioneFM].Enabled then
        grdTabControl.ActiveTab:=WComponiRelazioneFM;
    end;
  end;
  if WR302DM.selTabella.State = dsBrowse then //(Quando accedo da menu) oppure (Quando accedo da A002 e chiudo la maschera degli abbinamenti ma non posso intervenire sulla relazione)
    SegnalaAnomaliaOrdine;
  Result:=True;
end;

procedure TWA136FRelazioniAnagrafe.IWAppFormCreate(Sender: TObject);
begin
  msgSegnalaAnomaliaOrdine:='';
  inherited;
  FRichiamoEsterno:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.OttimizzaStorico:=False;
  WR302DM:=TWA136FRelazioniAnagrafeDM.Create(Self);
  (WR302DM as TWA136FRelazioniAnagrafeDM).A136FRelazioniAnagrafeMW.A136ImpostaMsgWarning:=ImpostaMsgWarning;

  WBrowseFM:=TWA136FRelazioniAnagrafeBrowseFM.Create(Self);
  WDettaglioFM:=TWA136FRelazioniAnagrafeDettFM.Create(Self);
  WComponiRelazioneFM:=TWA136FComponiRelazioneFM.Create(Self);
  WStampaRelazioniFM:=TWA136FStampaRelazioniFM.Create(Self);

  CreaTabDefault;
  GrdTabControl.AggiungiTab('Composizione relazione',WComponiRelazioneFM);
  GrdTabControl.AggiungiTab('Stampa relazioni',WStampaRelazioniFM);

  GrdTabControl.ActiveTab:=WBrowseFM;
  DettRelazione:=TStringList.Create();
  //Devo eseguire abilitaComponenti poichè imposta abilitazione di WComponiRelazione
  //Non può farlo il frame la prima volta poichè creato prima del frame WComponiRelazione
  WDettaglioFM.AbilitaComponenti;
  actVisioneCorrenteExecute(nil);
  AddScrollBarManager('divscrollablefm');
end;

procedure TWA136FRelazioniAnagrafe.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(DettRelazione);
  inherited;
end;

procedure TWA136FRelazioniAnagrafe.IWAppFormRender(Sender: TObject);
begin
  inherited;
  if msgSegnalaAnomaliaOrdine <> '' then
  begin
    MsgBox.MessageBox(msgSegnalaAnomaliaOrdine,INFORMA);
    msgSegnalaAnomaliaOrdine:='';
  end;
end;

procedure TWA136FRelazioniAnagrafe.RipristinaValoriOriginali;
begin
  inherited;
  TWA136FRelazioniAnagrafeDettFM(WDettaglioFM).memoRelazione.Lines.Assign(DettRelazione);
end;

procedure TWA136FRelazioniAnagrafe.SalvaValoriOriginali;
begin
  inherited;
  DettRelazione.Clear;
  DettRelazione.Assign(TWA136FRelazioniAnagrafeDettFM(WDettaglioFM).memoRelazione.Lines);
end;

procedure TWA136FRelazioniAnagrafe.ImpostaMsgWarning(Tipo, Campo: String);
begin
  if Tipo = 'TABELLA' then
  begin
    lblCampo1NonEsistente.Caption:='';  //reset
    if Campo <> '' then
      lblCampo1NonEsistente.Caption:='Attenzione! Il dato ' + Campo + ' non esiste!';
  end
  else if Tipo = 'TAB_ORIGINE' then
  begin
    lblCampo2NonEsistente.Caption:='';  //reset
    if Campo <> '' then
      lblCampo2NonEsistente.Caption:='Attenzione! Il dato ' + Campo + ' non esiste!';
  end;
end;

procedure TWA136FRelazioniAnagrafe.SegnalaAnomaliaOrdine;
var s:String;
begin
  FRichiamoEsterno:=False; //Per non eseguire nuovamente SegnalaAnomaliaOrdine quando si è giunti da A002 e si effettua un annullamento successivo all'eventuale primo annullamento (quello sulla relazione su cui si è posizionato in fase di accesso)
  s:=TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.ControlloOrdine(SolaLettura);
  if s <> '' then
  begin
    if GGetWebApplicationThreadVar.ActiveForm = Self then
      MsgBox.MessageBox(s,INFORMA)
    else
      msgSegnalaAnomaliaOrdine:=s;
  end;
    //GGetWebApplicationThreadVar.ShowMessage(s);
end;

end.

