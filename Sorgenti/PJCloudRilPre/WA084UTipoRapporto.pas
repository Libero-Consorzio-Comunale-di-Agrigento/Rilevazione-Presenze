unit WA084UTipoRapporto;

interface

uses
  WA084UTipoRapportoBrowseFM, WA084UTipoRapportoDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA084UTipoRapportoDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, System.Actions, IWCompEdit, meIWEdit;

type
  TWA084FTipoRapporto = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso: Boolean; override;
  public
  end;

implementation

{$R *.dfm}

procedure TWA084FTipoRapporto.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA084FTipoRapportoDM.Create(Self);
  WBrowseFM:=TWA084FTipoRapportoBrowseFM.Create(Self);
  WDettaglioFM:=TWA084FTipoRapportoDettFM.Create(Self);

  CreaTabDefault;
end;

function TWA084FTipoRapporto.InizializzaAccesso: Boolean;
begin
  Result:=True;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

end.
