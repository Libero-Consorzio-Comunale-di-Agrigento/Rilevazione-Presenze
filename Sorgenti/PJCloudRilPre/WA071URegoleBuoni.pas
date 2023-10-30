unit WA071URegoleBuoni;

interface

uses
  WA071URegoleBuoniBrowseFM, WA071URegoleBuoniDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000UMessaggi, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA071URegoleBuoniDM, IWCompButton, WR102UGestTabella, C190FunzioniGeneraliWeb,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar,
  OracleData, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, System.Actions, meIWEdit;

type
  TWA071FRegoleBuoni = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA071FRegoleBuoni.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA071FRegoleBuoni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA071FRegoleBuoniDM.Create(Self);
  if not TWA071FRegoleBuoniDM(WR302DM).QSource.Active then
    raise Exception.Create(A000MSG_A071_ERR_DATO_NON_SPECIF);

  WBrowseFM:=TWA071FRegoleBuoniBrowseFM.Create(Self);
  WDettaglioFM:=TWA071FRegoleBuoniDettFM.Create(Self);

  CreaTabDefault;
end;

end.
