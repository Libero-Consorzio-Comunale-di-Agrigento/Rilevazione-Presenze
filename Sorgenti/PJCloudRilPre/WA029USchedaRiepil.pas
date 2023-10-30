unit WA029USchedaRiepil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, WA029USchedaRiepilDM,
  WA029USchedaRiepilBrowseFM, WA029USchedaRiepilDettFM, WC020UInputDataOreFM,
  A000UInterfaccia, A000UMessaggi, OracleData, medpIWMessageDlg, DB,
  System.Actions, meIWImageFile, Oracle, C180FunzioniGenerali, IWCompEdit, meIWEdit, StrUtils, Math;

type
  TWA029FSchedaRiepil = class(TWR102FGestTabella)
    actSituazioneBudgetStraordinario: TAction;
    actParametriConteggio: TAction;
    actResidui: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actSituazioneBudgetStraordinarioExecute(Sender: TObject);
    procedure actParametriConteggioExecute(Sender: TObject);
    procedure actResiduiExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
  private
    WC020FInputDataOreFM: TWC020FInputDataOreFM;
    OldDataLavoro: TDateTime;
  protected
    procedure RefreshPage; override;
  public
    procedure ResultDataInserimento(Sender: TObject;Result: Boolean;Valore: String);
    procedure WC700CambioProgressivo(Sender: TObject); override;
    function InizializzaAccesso:boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA029FSchedaRiepil.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  OldDataLavoro:=0;
  WR302DM:=TWA029FSchedaRiepilDM.Create(Self);
  AttivaGestioneC700;
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
  begin
    selAnagrafe:=grdC700.selAnagrafe;
    actSituazioneBudgetStraordinario.Visible:=Budget;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
  WBrowseFM:=TWA029FSchedaRiepilBrowseFM.Create(Self);
  WDettaglioFM:=TWA029FSchedaRiepilDettFM.Create(Self);
  // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.ini
  TabBrowseCaption:='Elenco schede riepilogative';
  // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.fine
  CreaTabDefault;
end;

function TWA029FSchedaRiepil.InizializzaAccesso: boolean;
begin
  with (WR302DM as TWA029FSchedaRiepilDM) do
  begin
    A029FSchedaRiepilMW.VisualizzaDatiCalcolati:=(WDettaglioFM as TWA029FSchedaRiepilDettFM).VisualizzaDatiCalcolati;
    A029FSchedaRiepilMW.ImpostaContrattoEPartTime:=(WDettaglioFM as TWA029FSchedaRiepilDettFM).ImpostaContrattoEPartTime;
    A029FSchedaRiepilMW.ImpostaStraordinarioEsterno:=(WDettaglioFM as TWA029FSchedaRiepilDettFM).ImpostaStraordinarioEsterno;
    A029FSchedaRiepilMW.CaricaComboCausaliPresenza:=(WDettaglioFM as TWA029FSchedaRiepilDettFM).CaricaComboCausaliPresenza;
    A029FSchedaRiepilMW.AggiornaDettaglioCausalePresenza:=(WDettaglioFM as TWA029FSchedaRiepilDettFM).AggiornaDettaglioCausalePresenza;
    // se non si vuole partire con ultimo elemento commentare .last e scommentare actUltimoExecute(nil)
    //SelTabella.AfterScroll(nil);
    actUltimoExecute(nil);
  end;
  Result:=True;
end;

procedure TWA029FSchedaRiepil.actConfermaExecute(Sender: TObject);
var
  LErrMsg: String;
begin
  // verifica operazioni pendenti su sottotabelle
  if (WDettaglioFM as TWA029FSchedaRiepilDettFM).VerificaGrdPending then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_GRID_PENDING,mtInformation,[mbOk],nil,'');
    Abort;
  end;

  inherited;
end;

procedure TWA029FSchedaRiepil.actNuovoExecute(Sender: TObject);
begin
  (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW.DataInserimento:=Parametri.DataLavoro;
  (*  Massimo 22/07/2013 : utilizzo della maschera generica WC020
  WA029FInputValoreFM:=TWA029FInputValoreFM.Create(Self);
  WA029FInputValoreFM.InputData(Parametri.DataLavoro);
  WA029FInputValoreFM.ResultEvent:=ResultDataInserimento;
  WA029FInputValoreFM.Visualizza;
  *)
  WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
  WC020FInputDataOreFM.ImpostaCampiData('Mese della scheda:',Parametri.DataLavoro,'mm/yyyy');
  WC020FInputDataOreFM.ResultEvent:=ResultDataInserimento;
  WC020FInputDataOreFM.Visualizza('Scheda del mese');
end;

procedure TWA029FSchedaRiepil.actParametriConteggioExecute(Sender: TObject);
begin
  with (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW do
    MsgBox.WebMessageDlg(ParametriConteggio,mtInformation,[mbOk],nil,'');
end;

procedure TWA029FSchedaRiepil.actResiduiExecute(Sender: TObject);
var Params: String;
begin
  Params:='PROGRESSIVO=' + IntToStr(WR302DM.selTabella.FieldByName('PROGRESSIVO').AsInteger);
  AccediForm(11,Params,True);
end;

procedure TWA029FSchedaRiepil.actSituazioneBudgetStraordinarioExecute(
  Sender: TObject);
  {Visualizzazione della situazione budgetaria del mese}
var S: String;
begin
  with (WR302DM as TWA029FSchedaRiepilDM) do
  begin
    if selTabella.RecordCount > 0 then
    begin
      S:=A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtm1.VisualizzaBudget(selTabella.FieldByName('PROGRESSIVO').AsInteger,selTabella.FieldByName('DATA').AsDateTime);
      MsgBox.WebMessageDlg(S,mtInformation,[mbOk],nil,'');
    end;
  end;
end;

procedure TWA029FSchedaRiepil.RefreshPage;
begin
  if WR302DM.selTabella.State = dsBrowse then
    actAggiornaExecute(nil);
end;

procedure TWA029FSchedaRiepil.ResultDataInserimento(Sender: TObject;Result: Boolean;Valore: String);
begin
  if Result then
  begin
    (WR302DM as TWA029FSchedaRiepilDM).A029FSchedaRiepilMW.DataInserimento:=strToDate(Valore);
    inherited actNuovoExecute(nil);
  end;
end;

procedure TWA029FSchedaRiepil.WC700CambioProgressivo(Sender: TObject);
var
  D: TDateTime;
begin
  if WR302DM.selTabella.State in [dsInsert,dsEdit] then
    exit;

  D:=WR302DM.selTabella.FieldByName('DATA').AsDateTime;
  if (OldDataLavoro > 0) and (Parametri.DataLavoro <> OldDataLavoro) then //è stata cambiata la data lavoro
    D:=R180InizioMese(Parametri.DataLavoro)
  else //se D=0 è appena stata aperta la funzione -> mi posiziono su data lavoro; se D<>0 è stato cambiato il progressivo -> mantengo la data precedente D
    D:=IfThen(D=0, R180InizioMese(Parametri.DataLavoro), D);
  OldDataLavoro:=Parametri.DataLavoro;

  inherited;
  //mi riposiziono sulla stessa data
    //aggiorno griglia
  if WBrowseFM <> nil then
  begin
    if not WR302DM.selTabella.SearchRecord('Data',D,[srFromBeginning]) then
    begin
      //se la data esatta non è trovata si posiziona su quella immediatamente precedente
      WR302DM.selTabella.Last;
      while not WR302DM.selTabella.Bof do
      begin
        if WR302DM.selTabella.FieldByName('Data').AsDateTime > D then
          WR302DM.selTabella.Prior
        else
          Break;
      end;
    end;
    WBrowseFM.grdTabella.medpAggiornaCDS(False);
    AggiornaRecord;
  end;
end;

end.
