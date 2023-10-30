unit W030UTabelloneTurni;

interface

uses
  SysUtils, StrUtils, Classes, Graphics, Controls,
  IWTemplateProcessorHTML, IWCompLabel, IWApplication,
  IWControl, IWHTMLControls, IWCompListbox, IWCompEdit,
  IWCompButton, OracleData, IWCompCheckbox, RegistrazioneLog, Variants, Math,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWAppForm, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWVCLComponent, DatiBloccati, ActnList, Menus, IWCompMenu, R012UWebAnagrafico,
  IWDBGrids, medpIWDBGrid, DB, DBClient,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, A058UPianifTurniDtm1,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPAGINAWEB, Rp502Pro,
  IWTypes, meIWLabel, meIWEdit,
  meIWButton, meIWCheckBox, meIWRadioGroup,W000UMessaggi,
  IWCompExtCtrls, IWCompGrids,IW.Browser.InternetExplorer, meIWImageFile,
  meIWLink, meIWGrid, medpIWTabControl, Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, medpIWMultiColumnComboBox,
  IWMultiColumnComboBox, WA058UTabelloneTurniFM,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,WC013UCheckListFM,WC015USelEditGridFM;

type
  TW030FTabelloneTurni = class(TR012FWebAnagrafico)
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    WA058FM: TWA058FTabelloneTurniFM;
    WC013FCheckListFM:TWC013FCheckListFM;
    WC015FSelEditGridFM:TWC015FSelEditGridFM;
    CDSDialogProgTurnazione: TClientDataSet;
    procedure AggiornaDipendentiDisponibili(Dal,Al: TDateTime);
    procedure OnFiltroAnomalieOKClickHandler(Sender: TObject; Result: Boolean);
    procedure OnChiudiDialogProgTurnazione(Sender: TObject; Result: Boolean);
  protected
    procedure RefreshPage; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    function  InizializzaAccesso:Boolean; override;
    procedure VisualizzaDialogFiltroAnomalie(ListaTipiAnomalie,ListaTipiAnomalieSel:TStringList);
    procedure VisualizzaDialogProgTurnazione(Titolo:String;ProgTurnDataSet:TClientDataSet);
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  end;

implementation

{$R *.DFM}

procedure TW030FTabelloneTurni.IWAppFormCreate(Sender: TObject);
begin
  WC013FCheckListFM:=nil;
  CDSDialogProgTurnazione:=nil;
  WC015FSelEditGridFM:=nil;
  Self.AggiungiPluginJavaScript('JQGRID_LOCALE_IT', A000MSG_A058_ERR_JS_JQGRID_NON_SUPP);
  Self.AggiungiPluginJavaScript('JQGRID',A000MSG_A058_ERR_JS_JQGRID_NON_SUPP);
  Self.AggiungiPluginJavaScript('JQ_MEDP_DROPDOWN');
  inherited;
  //AddScrollBarManager('divtable','WA058');
  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE';
  WA058FM:=TWA058FTabelloneTurniFM.Create(Self);
  WA058FM.AggiornaDipendentiDisponibili:=AggiornaDipendentiDisponibili;
  with WA058FM  do
  begin
    //Necessario per GetSquadraPiuAssegnata
    if (WR000DM.TipoUtente = 'Dipendente') and
       (Trim(Parametri.Inibizioni.Text) = '') then
      GetDipendentiDisponibili(Parametri.DataLavoro)
    else
      GetDipendentiDisponibili(R180InizioMese(Parametri.DataLavoro),R180FineMese(Parametri.DataLavoro));
    WA058SelAnagrafe:=selAnagrafeW;
    WA058SolaLettura:=SolaLettura;
    Inizializza;
  end;
end;

procedure TW030FTabelloneTurni.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  if WC013FCheckListFM <> nil then
    try FreeAndNil(WC013FCheckListFM); except end;
  if WC015FSelEditGridFM <> nil then
    try FreeAndNil(WC015FSelEditGridFM); except end;
  if CDSDialogProgTurnazione <> nil then
    try OnChiudiDialogProgTurnazione(nil,False); except end;
end;

function TW030FTabelloneTurni.InizializzaAccesso:Boolean;
begin
  Result:=True;
end;

procedure TW030FTabelloneTurni.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  Conferma:=WA058FM.ModificheInCorso;
end;

procedure TW030FTabelloneTurni.RefreshPage;
begin
  inherited;
  WA058FM.RefreshTabellone;
end;

procedure TW030FTabelloneTurni.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TWC013FCheckListFM) and (AComponent = WC013FCheckListFM) then
      WC013FCheckListFM:=nil
    else if (AComponent is TWC015FSelEditGridFM) and (AComponent = WC015FSelEditGridFM) then
      WC015FSelEditGridFM:=nil;
  end;
end;

procedure TW030FTabelloneTurni.AggiornaDipendentiDisponibili(Dal, Al: TDateTime);
begin
  if (ParametriForm.Dal <> Dal) or (ParametriForm.Al <> Al) then
  begin
    // salva parametri form
    ParametriForm.Dal:=Dal;
    ParametriForm.Al:=Al;
    // effettua selezione dipendenti periodica nei seguenti due casi:
    // a. utente supervisore oppure
    // b. dipendente con filtro anagrafe impostato
    if (WR000DM.TipoUtente = 'Dipendente') and
       (Trim(Parametri.Inibizioni.Text) = '') then
      GetDipendentiDisponibili(Al)
    else
      GetDipendentiDisponibili(Dal,Al);
  end;
end;

procedure TW030FTabelloneTurni.VisualizzaDialogFiltroAnomalie(ListaTipiAnomalie,ListaTipiAnomalieSel:TStringList);
begin
  WC013FCheckListFM:=TWC013FCheckListFM.Create(Self);
  try
    FreeNotification(WC013FCheckListFM);
    WC013FCheckListFM.CaricaLista(ListaTipiAnomalie,ListaTipiAnomalie);
    WC013FCheckListFM.ImpostaValoriSelezionati(ListaTipiAnomalieSel);
    WC013FCheckListFM.ResultEvent:=OnFiltroAnomalieOKClickHandler;
    WC013FCheckListFM.Visualizza;
  except
    on E:Exception do
    begin
      try FreeAndNil(WC013FCheckListFM); except end;
      WC013FCheckListFM:=nil;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TW030FTabelloneTurni.OnFiltroAnomalieOKClickHandler(Sender: TObject; Result: Boolean);
var
  ListaTipiAnomalieSel:TStringList;
begin
  if Result then
  begin
    try
      ListaTipiAnomalieSel:=WC013FCheckListFM.LeggiValoriSelezionati;
      WA058FM.ImpostaFiltroAnomalie(ListaTipiAnomalieSel);
    finally
      try FreeAndNil(ListaTipiAnomalieSel); except end;
    end;
  end;
end;

procedure TW030FTabelloneTurni.VisualizzaDialogProgTurnazione(Titolo:String;ProgTurnDataSet:TClientDataSet);
begin
  WC015FSelEditGridFM:=TWC015FSelEditGridFM.Create(Self);
  try
    WC015FSelEditGridFM.grdElenco.medpRighePagina:=GetRighePaginaTabella;
    FreeNotification(WC015FSelEditGridFM);
    WC015FSelEditGridFM.ResultEvent:=OnChiudiDialogProgTurnazione;
    CDSDialogProgTurnazione:=ProgTurnDataSet;
    WC015FSelEditGridFM.Visualizza(Titolo,CDSDialogProgTurnazione,False,False,False,820);
  except
    on E:Exception do
    begin
      try FreeAndNil(WC015FSelEditGridFM); except end;
      WC015FSelEditGridFM:=nil;
      try OnChiudiDialogProgTurnazione(nil,False); except end;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TW030FTabelloneTurni.OnChiudiDialogProgTurnazione(Sender: TObject; Result: Boolean);
begin
  CDSDialogProgTurnazione.EmptyDataSet;
  CDSDialogProgTurnazione.Close;
  CDSDialogProgTurnazione:=nil;
end;

end.
