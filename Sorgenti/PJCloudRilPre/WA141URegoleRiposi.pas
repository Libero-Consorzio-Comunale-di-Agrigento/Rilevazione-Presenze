unit WA141URegoleRiposi;

interface

uses
  WA141URegoleRiposiDM, WA141URegoleRiposiBrowseFM, WA141URegoleRiposiDettFM,
  WR102UGestTabella, A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  Classes, SysUtils, IWAppForm, IWControl, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWHTMLControls, meIWLink, ActnList, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, Forms, IWVCLBaseContainer, IWContainer,
  meIWLabel, WR302UGestTabellaDM, meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWCompButton, meIWButton;

type
  TWA141FRegoleRiposi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA141FRegoleRiposi.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA141FRegoleRiposi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA141FRegoleRiposiDM.Create(Self);
  WBrowseFM:=TWA141FRegoleRiposiBrowseFM.Create(Self);
  WDettaglioFM:=TWA141FRegoleRiposiDettFM.Create(Self);

  CreaTabDefault;
end;

end.
