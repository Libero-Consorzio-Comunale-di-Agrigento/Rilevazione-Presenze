unit WA102UParScaricoGiustif;

interface

uses
  WA102UParScaricoGiustifBrowseFM, WA102UParScaricoGiustifDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA102UParScaricoGiustifDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, System.Actions, IWCompEdit, meIWEdit;

type
  TWA102FParScaricoGiustif = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA102FParScaricoGiustif.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA102FParScaricoGiustif.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA102FParScaricoGiustifDM.Create(Self);
  WBrowseFM:=TWA102FParScaricoGiustifBrowseFM.Create(Self);
  WDettaglioFM:=TWA102FParScaricoGiustifDettFM.Create(Self);
  CreaTabDefault;
end;


end.
