unit WA017URaggrAsse;

interface

uses
  WA017URaggrAsseBrowseFM, WA017URaggrAsseDettFM,
  Classes, SysUtils, DB, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA017URaggrAsseDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  meIWDBRadioGroup, meIWDBEdit, meIWDBLabel,
  meIWDBCheckBox, meIWDBComboBox, meIWDBLookupComboBox, IWCompGrids,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  System.Actions, IWCompEdit, meIWEdit;

type
  TWA017FRaggrAsse = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA017FRaggrAsse.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA017FRaggrAsse.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA017FRaggrAsseDM.Create(Self);
  WBrowseFM:=TWA017FRaggrAsseBrowseFM.Create(Self);
  WDettaglioFM:=TWA017FRaggrAsseDettFM.Create(Self);

  CreaTabDefault;
end;

end.
