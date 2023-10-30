unit WA012UCalendari;

interface

uses
  WA012UCalendariBrowseFM, WA012UCalendariDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA012UCalendariDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, System.Actions, meIWImageFile, IWCompEdit, meIWEdit;

type
  TWA012FCalendari = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA012FCalendari.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA012FCalendari.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA012FCalendariDM.Create(Self);
  WBrowseFM:=TWA012FCalendariBrowseFM.Create(Self);
  WDettaglioFM:=TWA012FCalendariDettFM.Create(Self);

  CreaTabDefault;
end;


end.
