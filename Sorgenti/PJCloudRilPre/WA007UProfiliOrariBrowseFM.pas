unit WA007UProfiliOrariBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, DB, DBClient, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWLayoutMgrHTML, IWCompMemo,
  IWCompLabel, xmlDoc, ActiveX, IWHTMLTag, IWCompJQueryWidget, IWCompGrids,
  Vcl.Menus;

type
  TWA007FProfiliOrariBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA007FProfiliOrariBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  grdTabella.medpRighePagina:=20;
  inherited;
end;

end.
