unit WA036UTurniRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, System.Actions;

type
  TWA036FTurniRep = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA036UTurniRepDM, WA036UTurniRepBrowseFM;

{$R *.dfm}

procedure TWA036FTurniRep.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA036FTurniRepDM.Create(Self);
  WBrowseFM:=TWA036FTurniRepBrowseFM.Create(Self);
  CreaTabDefault;
  AttivaGestioneC700;
  (WR302DM as TWA036FTurniRepDM).A036MW.selAnagrafe:=grdC700.selAnagrafe;
end;

end.
