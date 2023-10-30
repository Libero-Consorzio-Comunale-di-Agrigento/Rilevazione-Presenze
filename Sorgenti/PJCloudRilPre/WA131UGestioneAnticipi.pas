unit WA131UGestioneAnticipi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA131UGestioneAnticipiDM, WA131UGestioneAnticipiBrowseFM,
  WA131UGestioneAnticipiDettFM, WA131UCollegMissioniFM, OracleData,DB;

type
  TWA131FGestioneAnticipi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdTabControlTabControlChange(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
  public
    WCollegMissioniFM: TWA131FCollegMissioniFM;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure RefreshPage; override;
    function InizializzaAccesso:boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA131FGestioneAnticipi.actAggiornaExecute(Sender: TObject);
var i:Integer;
begin
  //devo fare refresh anche del MW
  with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
    for i:=0 to ComponentCount - 1 do
      if (Components[i] is TOracleDataSet) and (TOracleDataSet(Components[i]).Active) then
        TOracleDataSet(Components[i]).Refresh;

  with (WR302DM as TWA131FGestioneAnticipiDM) do
    for i:=0 to ComponentCount - 1 do
      if (Components[i].Name <> selTabella.Name) and (Components[i] is TOracleDataSet) and (TOracleDataSet(Components[i]).Active) then
        TOracleDataSet(Components[i]).Refresh;

  inherited;
end;

procedure TWA131FGestioneAnticipi.grdTabControlTabControlChange(
  Sender: TObject);
begin
  inherited;
  if grdTabControl.TabIndex = 2 then
  begin
    (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW.CaricaAnticipi;
  end;
end;

procedure TWA131FGestioneAnticipi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA131FGestioneAnticipiDM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW.SelAnagrafe:=grdC700.selAnagrafe;
  (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW.ImpostaProgressivo;
  WBrowseFM:=TWA131FGestioneAnticipiBrowseFM.Create(Self);
  //Collegamento missioni deve essere creato prima di DettFM
  WCollegMissioniFM:=TWA131FCollegMissioniFM.Create(Self);
  WDettaglioFM:=TWA131FGestioneAnticipiDettFM.Create(Self);
  CreaTabDefault;

  grdTabControl.AggiungiTab('Collegamento missioni',WCollegMissioniFM);
  grdTabControl.ActiveTab:=WBrowseFM;
end;

function TWA131FGestioneAnticipi.InizializzaAccesso: boolean;
var
  Progressivo,IdMissione: Integer;
begin
  Result:=False;

  //Deve prendere il progressivo selezionato da parametro (passato da WA100)
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  IdMissione:=StrToIntDef(GetParam('ID_MISSIONE'),0);
  if IdMissione > 0 then
  begin
    with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
      selM040.SearchRecord('ID_MISSIONE',VarArrayOf([IdMissione]),[srFromBeginning]);
  end;
  Result:=True;
end;

procedure TWA131FGestioneAnticipi.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
  begin
    ImpostaProgressivo;
    CaricaAnticipi;
  end;
  if WCollegMissioniFM <> nil then
    WCollegMissioniFM.Aggiorna;
end;

procedure TWA131FGestioneAnticipi.RefreshPage;
begin
  inherited;
  with (WR302DM as TWA131FGestioneAnticipiDM) do
  begin
    A131FGestioneAnticipiMW.selTAnticipi.Refresh;
    if selTabella.State in [dsEdit,dsInsert] then
     (WDettaglioFM as TWA131FGestioneAnticipiDettFM).CaricaMultiColumnCombobox;
  end;
end;
end.
