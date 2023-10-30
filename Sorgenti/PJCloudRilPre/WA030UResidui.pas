unit WA030UResidui;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, DB, C180FunzioniGenerali, WA030UResiduiBrowseFM, WA030UResiduiPresenzeFM, Oracle, System.Actions, IWCompEdit, meIWEdit;

type
  TWA030FResidui = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdTabControlTabControlChange(Sender: TObject);
    procedure grdTabControlTabControlChanging(Sender: TObject; var AllowChange: Boolean);
  private
    procedure ApriSelTabella;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA030UResiduiDM;

{$R *.dfm}

procedure TWA030FResidui.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=True;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA030FResiduiDM.Create(Self);
  WR302DM.SelTabella:=(WR302DM as TWA030FResiduiDM).A030MW.Q130;
  InterfacciaWR102.NomeTabella:=UpperCase(R180Query2NomeTabella(WR302DM.selTabella));   // InterfacciaWR102.NomeTabella è richiamato dalla form di stampa
  AttivaGestioneC700;
  WBrowseFM:= TWA030FResiduiBrowseFM.Create(Self);
  with (WR302DM as TWA030FResiduiDM).A030MW do
  begin
    SelAnagrafe:=grdC700.selAnagrafe;
    SettaProgressivo;
  end;

  ApriSelTabella;
  grdTabControl.AggiungiTab('Residui Orari',WBrowseFM);
  grdTabControl.AggiungiTab('Residui Presenze',WBrowseFM);
  grdTabControl.AggiungiTab('Residui Assenze',WBrowseFM);
  grdTabControl.AggiungiTab('Residui Buoni/Ticket',WBrowseFM);
  grdTabControl.AggiungiTab('Residuo Crediti Formativi',WBrowseFM);
  grdTabControl.ActiveTab:=grdTabControl.TabByIndex(0).TabPageControl;
end;

function TWA030FResidui.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
begin
  Result:=False;
  //Deve prendere il progressivo selezionato da parametro (passato da WA029)
  //e non il progressivo corrente della WA001
  //Se arriva da menu Progressivo non impostato e quindi posizionamento su progressivo corrente della wa001 (fatto su attivazione wc700)
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  Result:=True;
end;

procedure TWA030FResidui.grdTabControlTabControlChange(Sender: TObject);
begin
  inherited;
  case grdTabControl.TabIndex of
    0:WR302DM.SelTabella:=(WR302DM as TWA030FResiduiDM).A030MW.Q130;
    1:WR302DM.SelTabella:=(WR302DM as TWA030FResiduiDM).A030MW.selT131;
    2:WR302DM.SelTabella:=(WR302DM as TWA030FResiduiDM).A030MW.T264;
    3:WR302DM.SelTabella:=(WR302DM as TWA030FResiduiDM).A030MW.selT692;
    4:WR302DM.SelTabella:=(WR302DM as TWA030FResiduiDM).A030MW.selSG656;
  end;
  ApriSelTabella;
  case grdTabControl.TabIndex of
    0:(WBrowseFM as TWA030FResiduiBrowseFM).PreparaComponentiQ130;
    1:(WBrowseFM as TWA030FResiduiBrowseFM).PreparaComponentiSelT131;
    2:(WBrowseFM as TWA030FResiduiBrowseFM).PreparaComponentiT264;
    3:(WBrowseFM as TWA030FResiduiBrowseFM).PreparaComponentiT692;
    4:(WBrowseFM as TWA030FResiduiBrowseFM).PreparaComponentiselSG656;
  end;
end;

procedure TWA030FResidui.grdTabControlTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  if WR302DM.SelTabella.State <> dsBrowse then
    AllowChange:=False;
end;

procedure TWA030FResidui.ApriSelTabella;
begin
  with WR302DM do
  begin
    InizializzaDataSet(InterfacciaWR102.Eventi);
    SelTabella.Close;
    SelTabella.SetVariable('PROGRESSIVO',grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SelTabella.Open;
    DsrTabella.DataSet:=SelTabella;
    WBrowseFM.grdTabella.medpAttivaGrid(SelTabella,false,false);
    InterfacciaWR102.NomeTabella:=UpperCase(R180Query2NomeTabella(selTabella));
  end;
end;

end.
