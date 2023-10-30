unit WA180UOperatori;

interface

uses
  WA180UOperatoriBrowseFM, WA180UOperatoriDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  IWCompJQueryWidget, ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb,
  IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, meIWImageFile,
  C180FunzioniGenerali, OracleData, Db, IWCompGrids, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, System.Actions,
  meIWEdit;

type
  TWA180FOperatori = class(TWR102FGestTabella)
    actlstWA180ToolBar: TActionList;
    actAziende: TAction;
    grdWA180ToolBar: TmeIWGrid;
    actPermessi: TAction;
    actFiltroAnagrafe: TAction;
    actFiltroFunzioni: TAction;
    actFiltroDizionario: TAction;
    actLoginDipendenti: TAction;
    actAccessi: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actWA180ToolBarExecute(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    procedure CreaNavigatorBar;
    procedure imgToolBarClick(Sender: TObject);
  public
    procedure selTabellaStateChange(DataSet: TDataSet); override;
  end;

implementation

uses WA180UOperatoriDM,
     WA181UAziende, WA182UPermessi, WA183UFiltroAnagrafe,
     WA184UFiltroFunzioni, WA185UFiltroDizionario,
     WA186ULoginDipendenti, WA187UAccessi;

{$R *.dfm}

procedure TWA180FOperatori.IWAppFormCreate(Sender: TObject);
begin
  actCopiaSu.Visible:=False;	
  inherited;
  WR302DM:=TWA180FOperatoriDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=True;

  WR100LinkWC700:=False;
  AttivaGestioneC700;

  WDettaglioFM:=TWA180FOperatoriDettFM.Create(Self);
  WBrowseFM:=TWA180FOperatoriBrowseFM.Create(Self);
  CreaTabDefault;

  CreaNavigatorBar;
end;

procedure TWA180FOperatori.IWAppFormRender(Sender: TObject);
begin
  inherited;
  if not TWA180FOperatoriDettFM(WDettaglioFM).dcmbFiltroFunzioni.Editable then
    TWA180FOperatoriDettFM(WDettaglioFM).dcmbFiltroFunzioni.Editable:=True;
end;

procedure TWA180FOperatori.actWA180ToolBarExecute(Sender: TObject);
begin
  AccediForm(StrToInt(TAction(Sender).HelpKeyword));
end;

procedure TWA180FOperatori.CreaNavigatorBar;
var
  i, k:Integer;
begin
  grdWA180ToolBar.RowCount:=1;
  grdWA180ToolBar.ColumnCount:=actlstWA180ToolBar.ActionCount;

  k:=0;
  for i:=0 to actlstWA180ToolBar.ActionCount - 1 do
  begin
    grdWA180ToolBar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
    with TmeIWImageFile(grdWA180ToolBar.Cell[0,k].Control) do
    begin
      OnClick:=imgToolBarClick;
      Tag:=i;
    end;
    grdWA180ToolBar.Cell[0,k].Css:='x';
    grdWA180ToolBar.Cell[0,k].Text:='';
    k:=k + 1;
  end;
  AggiornaToolBar(grdWA180ToolBar,actlstWA180ToolBar);
end;

procedure TWA180FOperatori.selTabellaStateChange(DataSet: TDataSet);
var
  Browse:Boolean;
  //StoricizzaEnable:Boolean;
begin
  inherited;
  Browse:=not (DataSet.State in [dsInsert,dsEdit]);
  if not Browse then
    with (WR302DM as TWA180FOperatoriDM) do
    begin
      selI071.Refresh;
      selI072Dist.Refresh;
      selI073Dist.Refresh;
      selI074Dist.Refresh;
    end;

  actAziende.Enabled:=Browse;
  actPermessi.Enabled:=Browse;
  actFiltroAnagrafe.Enabled:=Browse;
  actFiltroFunzioni.Enabled:=Browse;
  actFiltroDizionario.Enabled:=Browse;
  actLoginDipendenti.Enabled:=Browse;
  actAccessi.Enabled:=Browse;

  if grdWA180ToolBar.ColumnCount > 1 then
    AggiornaToolBar(grdWA180ToolBar,actlstWA180ToolBar);
end;

procedure TWA180FOperatori.imgToolBarClick(Sender: TObject);
begin
  MessaggioStatus(INFORMA,'');
  TAction(actlstWA180ToolBar.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

end.

