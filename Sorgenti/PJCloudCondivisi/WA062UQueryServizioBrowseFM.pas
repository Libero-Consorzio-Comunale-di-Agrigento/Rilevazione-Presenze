unit WA062UQueryServizioBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, Vcl.Menus, IWCompListbox,
  IWDBStdCtrls, meIWDBComboBox, meIWComboBox, IWCompLabel, meIWLabel;

type
  TWA062FQueryServizioBrowseFM = class(TWR204FBrowseTabellaFM)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA062UQueryServizioDM;

{$R *.dfm}

end.
