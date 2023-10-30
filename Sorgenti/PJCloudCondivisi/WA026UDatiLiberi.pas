unit WA026UDatiLiberi;

interface

uses
  WA026UDatiLiberiBrowseFM, WA026UDatiLiberiDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, Oracle, Db, OracleData,
  WA026UDatiLiberiDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, medpIWMessageDlg,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, System.Actions, meIWEdit;

type
  TWA026FDatiLiberi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TWA026FDatiLiberi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA026FDatiLiberiDM.Create(Self);

  InterfacciaWR102.ConfermaCancellazione:=False;
  WDettaglioFM:=TWA026FDatiLiberiDettFM.Create(Self);
  WBrowseFM:=TWA026FDatiLiberiBrowseFM.Create(Self);

  CreaTabDefault;
end;

end.
