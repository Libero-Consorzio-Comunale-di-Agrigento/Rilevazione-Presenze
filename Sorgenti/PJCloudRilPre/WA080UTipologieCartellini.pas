unit WA080UTipologieCartellini;

interface

uses
  WA080UTipologieCartelliniBrowseFM, WA080UTipologieCartelliniDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA080UTipologieCartelliniDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  IWCompGrids, WA080UTabLayoutFM, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  System.Actions, IWCompEdit, meIWEdit;

type
  TWA080FTipologieCartellini = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  public
     WA080FTabLayoutFM:TWA080FTabLayoutFM;
  end;

implementation

{$R *.dfm}

function TWA080FTipologieCartellini.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA080FTipologieCartellini.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=False;
  WR302DM:=TWA080FTipologieCartelliniDM.Create(Self);
  WBrowseFM:=TWA080FTipologieCartelliniBrowseFM.Create(Self);
  WDettaglioFM:=TWA080FTipologieCartelliniDettFM.Create(Self);
  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
  CreaTabDefault;
end;

end.
