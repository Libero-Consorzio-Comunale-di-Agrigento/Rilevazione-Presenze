unit WA022UContratti;

interface

uses
  WA022UContrattiBrowseFM, WA022UContrattiDettFM,// WA022UFasceMaggiorazioneFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA022UContrattiDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  medpIWTabControl, medpIWStatusBar, OracleData,
  medpIWMessageDlg, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, meIWGrid, System.Actions, IWCompEdit,
  meIWEdit;

type
  TWA022FContratti = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  public
    //WFasceMaggiorazioneFM:TWA022FFasceMaggiorazioneFM;
  end;

implementation

{$R *.dfm}

function TWA022FContratti.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA022FContratti.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA022FContrattiDM.Create(Self);
  WBrowseFM:=TWA022FContrattiBrowseFM.Create(Self);
  WDettaglioFM:=TWA022FContrattiDettFM.Create(Self);
  //WFasceMaggiorazioneFM:=TWA022FFasceMaggiorazioneFM.Create(Self);

  CreaTabDefault;
  //grdTabControl.AggiungiTab('Gestione fasce di maggiorazione',WFasceMaggiorazioneFM);
  grdTabControl.ActiveTab:=WBrowseFM;
end;

end.
