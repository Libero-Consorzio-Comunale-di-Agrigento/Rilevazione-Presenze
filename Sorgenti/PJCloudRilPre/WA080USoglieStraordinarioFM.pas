unit WA080USoglieStraordinarioFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompGrids, IWDBGrids, medpIWDBGrid;

type
  TWA080FSoglieStraordinarioFM = class(TWR200FBaseFM)
    grdTabella: TmedpIWDBGrid;
    grdSoglie: TmedpIWDBGrid;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdSoglieRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA080USoglieStraordinarioDM;

{$R *.dfm}

procedure TWA080FSoglieStraordinarioFM.grdSoglieRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdSoglie.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdSoglie.medpCompGriglia) + 1) and (grdSoglie.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdSoglie.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA080FSoglieStraordinarioFM.grdTabellaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdTabella.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdTabella.medpCompGriglia) + 1) and (grdTabella.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdTabella.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA080FSoglieStraordinarioFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with TWA080FSoglieStraordinarioDM(WR302DM) do
  begin
    selT028.SetVariable('ID','0');
    selT028.Open;
  end;
  grdTabella.medpAttivaGrid(WR302DM.selTabella,true,grdTabella.medpComandiInsert);
  grdSoglie.medpAttivaGrid(TWA080FSoglieStraordinarioDM(WR302DM).selT028,true,grdSoglie.medpComandiInsert);
end;

end.
