unit WA018URaggrPres;

interface

uses
  WA018URaggrPresBrowseFM, WA018URaggrPresDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA018URaggrPresDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, System.Actions, IWCompEdit, meIWEdit;

type
  TWA018FRaggrPres = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA018FRaggrPres.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA018FRaggrPres.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA018FRaggrPresDM.Create(Self);
  WBrowseFM:=TWA018FRaggrPresBrowseFM.Create(Self);
  WDettaglioFM:=TWA018FRaggrPresDettFM.Create(Self);

  CreaTabDefault;
end;


end.
