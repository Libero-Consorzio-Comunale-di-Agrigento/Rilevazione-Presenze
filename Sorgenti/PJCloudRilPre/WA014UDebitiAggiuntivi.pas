unit WA014UDebitiAggiuntivi;

interface

uses
  WA014UDebitiAggiuntiviBrowseFM, WA014UDebitiAggiuntiviDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel, A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,WA014UDebitiAggiuntiviDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData, IWCompGrids,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, System.Actions, meIWImageFile,
  IWCompEdit, meIWEdit;

type
  TWA014FDebitiAggiuntivi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  public
  end;

implementation

{$R *.dfm}

procedure TWA014FDebitiAggiuntivi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA014FDebitiAggiuntiviDM.Create(Self);
  WBrowseFM:=TWA014FDebitiAggiuntiviBrowseFM.Create(Self);
  WDettaglioFM:=TWA014FDebitiAggiuntiviDettFM.Create(Self);

  CreaTabDefault;
end;

function TWA014FDebitiAggiuntivi.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.DisableControls;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WR302DM.selTabella.EnableControls;
  AggiornaRecord;
  Result:=True;
end;

end.
