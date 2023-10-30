unit WA132UMagazzinoBuoniPasto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  WA132UControlloFM, System.Actions;

type
  TWA132FMagazzinoBuoniPasto = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdTabControlTabControlChanging(Sender: TObject;var AllowChange: Boolean);
  private
    WA132FM:TWA132FControlloFM;
  public
    { Public declarations }
  end;

implementation

uses WA132UMagazzinoBuoniPastoDM, WA132UMagazzinoBuoniPastoBrowseFM;

{$R *.dfm}

procedure TWA132FMagazzinoBuoniPasto.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA132FMagazzinoBuoniPastoDM.Create(Self);
  WBrowseFM:=TWA132FMagazzinoBuoniPastoBrowseFM.Create(Self);
  WA132FM:=TWA132FControlloFM.Create(Self);
  CreaTabDefault;
  grdTabControl.AggiungiTab('Riepilogo Magazzino',WA132FM);
  grdTabControl.ActiveTab:=WBrowseFM;
  grdTabControl.OnTabControlChanging:=grdTabControlTabControlChanging;
end;

procedure TWA132FMagazzinoBuoniPasto.grdTabControlTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
 if grdTabControl.ActiveTab = WBrowseFM then
  WA132FM.RefrehCmbDataAcquisto;
end;

end.
