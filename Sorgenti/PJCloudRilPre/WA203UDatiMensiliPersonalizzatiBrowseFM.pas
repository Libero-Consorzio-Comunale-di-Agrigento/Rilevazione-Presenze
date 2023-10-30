unit WA203UDatiMensiliPersonalizzatiBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion;

type
  TWA203FDatiMensiliPersonalizzatiBrowseFM = class(TWR204FBrowseTabellaFM)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA203UDatiMensiliPersonalizzatiDM;

{$R *.dfm}

end.
