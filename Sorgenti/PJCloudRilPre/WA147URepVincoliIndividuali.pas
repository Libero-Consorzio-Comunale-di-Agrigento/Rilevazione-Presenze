unit WA147URepVincoliIndividuali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWMessageDlg,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton, DB,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, StrUtils, Math,
  WC020UInputDataOreFM, System.Actions, meIWImageFile, A000UCostanti, A000UMessaggi;

type
  TWA147FRepVincoliIndividuali = class(TWR102FGestTabella)
    actDividiPeriodo: TAction;
    actInsTuttiDipSel: TAction;
    actCancTuttiDipSel: TAction;
    actVisualizzaAnomalie: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actDividiPeriodoExecute(Sender: TObject);
    procedure actInsTuttiDipSelExecute(Sender: TObject);
    procedure actCancTuttiDipSelExecute(Sender: TObject);
    procedure actVisualizzaAnomalieExecute(Sender: TObject);
  private
    Tipologia: String;
    procedure ResultDividiPeriodo(Sender: TObject; Result: Boolean; Valore: String);
    procedure evtRichiesta(Msg, Chiave: String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    function InizializzaAccesso: Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure AbilitaAzioni;
  end;

implementation

uses WA147URepVincoliIndividualiDM, WA147URepVincoliIndividualiBrowseFM, WA147URepVincoliIndividualiDettFM,
     A147URepVincoliIndividualiMW, A000UInterfaccia;

{$R *.dfm}

procedure TWA147FRepVincoliIndividuali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA147FRepVincoliIndividualiDM.Create(Self);
  AttivaGestioneC700;
  WBrowseFM:=TWA147FRepVincoliIndividualiBrowseFM.Create(Self);
  WDettaglioFM:=TWA147FRepVincoliIndividualiDettFM.Create(Self);
  CreaTabDefault;
  (WR302DM as TWA147FRepVincoliIndividualiDM).A147MW.selAnagrafe:=grdC700.selAnagrafe;
  actVisualizzaAnomalie.Enabled:=False;
end;

function TWA147FRepVincoliIndividuali.InizializzaAccesso: Boolean;
begin
  Tipologia:=GetParam('Tipologia');
  with (WR302DM as TWA147FRepVincoliIndividualiDM),A147MW do
  begin
    if Tipologia <> '' then
      CodTipologia:=IfThen(Tipologia = 'REPERIB','R','G');
    Self.Title:='(WA147) Vincoli pianificazione ' + IfThen(CodTipologia = 'R','reperibilità','guardia');
    SetTag(IfThen(CodTipologia = 'R',68,69));
    selTabella.Close;
    selTabella.SetVariable('TIPO',CodTipologia);
    selTabella.Open;
    WBrowseFM.grdTabella.Summary:='Vincoli pianificazione ' + IfThen(CodTipologia = 'R','reperibilità','guardia');
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
  Result:=True;
end;

procedure TWA147FRepVincoliIndividuali.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  AbilitaAzioni;
end;

procedure TWA147FRepVincoliIndividuali.AbilitaAzioni;
begin
  if WR302DM <> nil then
    with WR302DM do
    begin
      actDividiPeriodo.Enabled:=not (dsrTabella.State in [dsEdit,dsInsert]) and not SolaLettura;
      actInsTuttiDipSel.Enabled:=(dsrTabella.State = dsBrowse) and not SolaLettura and (dsrTabella.DataSet.RecordCount > 0);
      actCancTuttiDipSel.Enabled:=(dsrTabella.State = dsBrowse) and not SolaLettura and (dsrTabella.DataSet.RecordCount > 0);
      AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    end;
end;

procedure TWA147FRepVincoliIndividuali.actDividiPeriodoExecute(Sender: TObject);
var WC020FInputDataOreFM : TWC020FInputDataOreFM;
    DIni,DFin:TDateTime;
begin
  with (WR302DM as TWA147FRepVincoliIndividualiDM).selTabella do
  begin
    if RecordCount = 0 then
      exit;
    DIni:=FieldByName('DECORRENZA').AsDateTime;
    DFin:=FieldByName('DECORRENZA_FINE').AsDateTime;
  end;
  WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
  WC020FInputDataOreFM.ImpostaCampiData('Nuova decorrenza:',DIni,'dd/mm/yyyy');
  WC020FInputDataOreFM.ResultEvent:=ResultDividiPeriodo;
  WC020FInputDataOreFM.Visualizza('Dividi periodo dal ' + DateToStr(DIni) + ' al ' + DateToStr(DFin));
end;

procedure TWA147FRepVincoliIndividuali.ResultDividiPeriodo(Sender: TObject; Result: Boolean; Valore: String);
begin
  if Result then
  begin
    (WR302DM as TWA147FRepVincoliIndividualiDM).A147MW.DividiPeriodo(strToDate(Valore));
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA147FRepVincoliIndividuali.actInsTuttiDipSelExecute(Sender: TObject);
begin
  inherited;
  actVisualizzaAnomalie.Enabled:=False;
  evtRichiesta(A000MSG_A147_DLG_INS_SELEZ,'InsTuttiDipSel');
  (WR302DM as TWA147FRepVincoliIndividualiDM).A147MW.AgisciTuttiDipSel(taInserisci);
  actVisualizzaAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  MsgBox.WebMessageDlg(IfThen(actVisualizzaAnomalie.Enabled,A000MSG_MSG_ELABORAZIONE_ANOMALIE,A000MSG_MSG_ELABORAZIONE_TERMINATA),mtInformation,[mbOK],nil,'');
  MsgBox.ClearKeys;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWA147FRepVincoliIndividuali.actCancTuttiDipSelExecute(Sender: TObject);
begin
  inherited;
  actVisualizzaAnomalie.Enabled:=False;
  evtRichiesta(A000MSG_A147_DLG_CANC_SELEZ,'CancTuttiDipSel');
  (WR302DM as TWA147FRepVincoliIndividualiDM).A147MW.AgisciTuttiDipSel(taCancella);
  MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA,mtInformation,[mbOK],nil,'');
  MsgBox.ClearKeys;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWA147FRepVincoliIndividuali.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA147FRepVincoliIndividuali.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    if KI = 'InsTuttiDipSel' then
      actInsTuttiDipSelExecute(nil)
    else if KI = 'CancTuttiDipSel' then
      actCancTuttiDipSelExecute(nil);
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA147FRepVincoliIndividuali.actVisualizzaAnomalieExecute(Sender: TObject);
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

end.
