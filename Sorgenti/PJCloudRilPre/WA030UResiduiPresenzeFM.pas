unit WA030UResiduiPresenzeFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompGrids, IWDBGrids, medpIWDBGrid, WR200UBaseFM;

type
  TWA030FResiduiPresenzeFM = class(TWR204FBrowseTabellaFM)
    procedure grdResiduiPresenzeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA030UResidui, WA030UResiduiDM;

{$R *.dfm}

procedure TWA030FResiduiPresenzeFM.grdResiduiPresenzeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

end.
