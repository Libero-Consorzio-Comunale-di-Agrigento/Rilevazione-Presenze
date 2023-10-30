unit WA058UPianifTurni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, A000UCostanti,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent, A000UInterfaccia,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, OracleData,
  IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, medpIWTabControl, System.Actions,
  Vcl.ActnList, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, IWCompLabel, meIWLabel, IWCompEdit,
  meIWEdit, IWDBStdCtrls, meIWDBLabel, medpIWMultiColumnComboBox, meIWRadioGroup,
  meIWImageFile, medpIWImageButton, DBClient, medpIWC700NavigatorBar, A000UMessaggi,
  C180FunzioniGenerali, WC700USelezioneAnagrafeFM,
  WA058UTabelloneTurniFM, WC013UCheckListFM, WC015USelEditGridFM;

type
  TWA058FPianifTurni = class(TWR100FBase)
    actlstNavigatorBar: TActionList;
    actAggiorna: TAction;
    actRicerca: TAction;
    actEstrai: TAction;
    actPrimo: TAction;
    actPrecedente: TAction;
    actSuccessivo: TAction;
    actUltimo: TAction;
    actVisioneCorrente: TAction;
    actVisioneAnnuale: TAction;
    actPrecedenteStorico: TAction;
    actSelezioneStorico: TAction;
    actSuccessivoStorico: TAction;
    actNuovo: TAction;
    actCopiaSu: TAction;
    actModifica: TAction;
    actElimina: TAction;
    actAnnulla: TAction;
    actConferma: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  protected
    procedure RefreshPage; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure ImpostazioniWC700; override;
  private
    WA058FM: TWA058FTabelloneTurniFM;
    WC013FCheckListFM:TWC013FCheckListFM;
    WC015FSelEditGridFM:TWC015FSelEditGridFM;
    CDSDialogProgTurnazione: TClientDataSet;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    {$IFDEF WEBPJ}procedure ElaborazioneServer; override;{$ENDIF}
    procedure OnFiltroAnomalieOKClickHandler(Sender: TObject; Result: Boolean);
    procedure OnChiudiDialogProgTurnazione(Sender: TObject; Result: Boolean);
    procedure OnWC700Result(Sender: TObject; Result: Boolean);
  public
    procedure VisualizzaDialogFiltroAnomalie(ListaTipiAnomalie,ListaTipiAnomalieSel:TStringList);
    procedure VisualizzaDialogProgTurnazione(Titolo:String;ProgTurnDataSet:TClientDataSet);
  end;

implementation

{$R *.dfm}

procedure TWA058FPianifTurni.IWAppFormCreate(Sender: TObject);
begin
  WC013FCheckListFM:=nil;
  CDSDialogProgTurnazione:=nil;
  WC015FSelEditGridFM:=nil;
  Self.AggiungiPluginJavaScript('JQGRID_LOCALE_IT',A000MSG_A058_ERR_JS_JQGRID_NON_SUPP);
  Self.AggiungiPluginJavaScript('JQGRID',A000MSG_A058_ERR_JS_JQGRID_NON_SUPP);
  Self.AggiungiPluginJavaScript('JQ_MEDP_DROPDOWN');
  inherited;
  //AddScrollBarManager('divtable');
  //creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);
  grdC700.AttivaBrowse:=False;
  AttivaGestioneC700;
  grdC700.WC700FM.ResultEvent:=OnWC700Result;

  WA058FM:=TWA058FTabelloneTurniFM.Create(Self);
  with WA058FM do
  begin
    A058DM.DataInizio:=R180InizioMese(Parametri.DataLavoro);
    A058DM.DataFine:=R180FineMese(Parametri.DataLavoro);
    WA058SelAnagrafe:=grdC700.selAnagrafe;
    WA058SelAnagrafe.OnFilterRecord:=A058DM.SelAnagrafeFilterRecord;
    WA058SelAnagrafe.Filtered:=True;
    WA058SolaLettura:=SolaLettura;
    Inizializza;
  end;
end;

procedure TWA058FPianifTurni.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  if WC013FCheckListFM <> nil then
    try FreeAndNil(WC013FCheckListFM); except end;
  if WC015FSelEditGridFM <> nil then
    try FreeAndNil(WC015FSelEditGridFM); except end;
  if CDSDialogProgTurnazione <> nil then
    try OnChiudiDialogProgTurnazione(nil,False); except end;
end;

procedure TWA058FPianifTurni.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  Conferma:=WA058FM.ModificheInCorso;
end;

procedure TWA058FPianifTurni.RefreshPage;
begin
  inherited;
  WA058FM.RefreshTabellone;
end;

procedure TWA058FPianifTurni.Notification(AComponent: TComponent;  Operation: TOperation);
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

procedure TWA058FPianifTurni.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700SelezionePeriodica:=True;
  grdC700.WC700FM.C700DataDal:=R180InizioMese(Parametri.DataLavoro);
  grdC700.WC700FM.C700DataLavoro:=R180FineMese(Parametri.DataLavoro);
end;

procedure TWA058FPianifTurni.VisualizzaDialogFiltroAnomalie(ListaTipiAnomalie,ListaTipiAnomalieSel:TStringList);
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

procedure TWA058FPianifTurni.OnFiltroAnomalieOKClickHandler(Sender: TObject; Result: Boolean);
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

procedure TWA058FPianifTurni.VisualizzaDialogProgTurnazione(Titolo:String;ProgTurnDataSet:TClientDataSet);
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

procedure TWA058FPianifTurni.OnChiudiDialogProgTurnazione(Sender: TObject; Result: Boolean);
begin
  CDSDialogProgTurnazione.EmptyDataSet;
  CDSDialogProgTurnazione.Close;
  CDSDialogProgTurnazione:=nil;
end;

procedure TWA058FPianifTurni.OnWC700Result(Sender: TObject; Result: Boolean);
begin
  if grdC700.selAnagrafe.SQL.Text <> WA058FM.A058DM.SalvaSQLOriginale then
    WA058FM.A058DM.SalvaSQLOriginale:='';
  WA058FM.cmbSquadra.Text:=WA058FM.A058DM.GetSquadraPiuAssegnata(WA058FM.cmbSquadra.Text);
  WA058FM.cmbSquadraAsyncChange(nil,nil,0,'');
end;

{$IFDEF WEBPJ}
//procedure utilizzata solo per visualizzare il msg di attesa in irisCloud
procedure TWA058FPianifTurni.ElaborazioneServer;
var LResCtrl: TResCtrl;
begin
  LResCtrl:=WA058FM.ElaboraStampa;
  if not LResCtrl.Ok then
    raise Exception.Create(LResCtrl.Messaggio);
end;
{$ENDIF}

end.
