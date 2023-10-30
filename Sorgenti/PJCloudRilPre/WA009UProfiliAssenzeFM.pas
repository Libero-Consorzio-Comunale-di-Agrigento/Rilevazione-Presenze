unit WA009UProfiliAssenzeFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWDBGrids, medpIWDBGrid, IWCompGrids, IWCompJQueryWidget;

type
  TWA009FProfiliAssenzeFM = class(TWR200FBaseFM)
    grdProfiliAssenze: TmedpIWDBGrid;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdProfiliAssenzemedpStatoChange;
    procedure grdProfiliAssenzeRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA009UProfAsseAnn, WA009UProfAsseAnnDM;

{$R *.dfm}

procedure TWA009FProfiliAssenzeFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdProfiliAssenze.medpPaginazione:=True;
  grdProfiliAssenze.medpRighePagina:=10;
  grdProfiliAssenze.medpAttivaGrid(TWA009FProfAsseAnnDM(TWA009FProfAsseAnn(Self.Parent).WR302DM).selT261,True,True);
end;

procedure TWA009FProfiliAssenzeFM.grdProfiliAssenzemedpStatoChange;
begin
  inherited;
  if (grdProfiliAssenze.medpStato = msInsert) or
     (grdProfiliAssenze.medpStato = msEdit) then
  begin
    TWA009FProfAsseAnn(Self.Parent).AbilitaToolBar(TWA009FProfAsseAnn(Self.Parent).grdNavigatorBar,False,TWA009FProfAsseAnn(Self.Parent).actlstNavigatorBar);
    TWA009FProfAsseAnn(Self.Parent).grdTabControl.Tabs[TWA009FProfAsseAnn(Self.Parent).WBrowseFM].Enabled:=False;
    TWA009FProfAsseAnn(Self.Parent).grdTabControl.Tabs[TWA009FProfAsseAnn(Self.Parent).WDettaglioFM].Enabled:=False;
  end
  else
  begin
    TWA009FProfAsseAnn(Self.Parent).AbilitaToolBar(TWA009FProfAsseAnn(Self.Parent).grdNavigatorBar,True,TWA009FProfAsseAnn(Self.Parent).actlstNavigatorBar);
    TWA009FProfAsseAnn(Self.Parent).grdTabControl.Tabs[TWA009FProfAsseAnn(Self.Parent).WBrowseFM].Enabled:=True;
    TWA009FProfAsseAnn(Self.Parent).grdTabControl.Tabs[TWA009FProfAsseAnn(Self.Parent).WDettaglioFM].Enabled:=True;
  end;
end;

procedure TWA009FProfiliAssenzeFM.grdProfiliAssenzeRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdProfiliAssenze.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdProfiliAssenze.medpCompGriglia) + 1) and (grdProfiliAssenze.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdProfiliAssenze.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

end.
