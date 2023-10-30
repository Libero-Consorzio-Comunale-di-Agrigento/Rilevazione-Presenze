unit WA184UFiltroFunzioniBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, DB, DBClient, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompJQueryWidget, IWCompGrids, IWCompButton, meIWButton, Vcl.Menus, IWCompExtCtrls, meIWImageFile, medpIWImageButton;

type
  TWA184FFiltroFunzioniBrowseFM = class(TWR204FBrowseTabellaFM)
    btnAggiornaFiltroFunzioni: TmedpIWImageButton;
    procedure btnAggiornaFiltroFunzioniClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses WA184UFiltroFunzioniDM;

{$R *.dfm}

procedure TWA184FFiltroFunzioniBrowseFM.btnAggiornaFiltroFunzioniClick(Sender: TObject);
begin
  inherited;
  TWA184FFiltroFunzioniDM(WR302DM).AggiornaI073;
end;

end.
