unit WA022UFasceMaggiorazioneFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWDBGrids, medpIWDBGrid, IWCompGrids, IWCompJQueryWidget;

type
  TWA022FFasceMaggiorazioneFM = class(TWR200FBaseFM)
    grdFasceMaggiorazione: TmedpIWDBGrid;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdFasceMaggiorazioneRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdFasceMaggiorazionemedpStatoChange;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA022UContratti, WA022UContrattiDM;

{$R *.dfm}

procedure TWA022FFasceMaggiorazioneFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdFasceMaggiorazione.medpPaginazione:=True;
  grdFasceMaggiorazione.medpRighePagina:=10;
  grdFasceMaggiorazione.medpAttivaGrid(TWA022FContrattiDM(TWA022FContratti(Self.Parent).WR302DM).T210,True,True);
end;


procedure TWA022FFasceMaggiorazioneFM.grdFasceMaggiorazionemedpStatoChange;
begin
  inherited;
  if (grdFasceMaggiorazione.medpStato = msInsert) or
     (grdFasceMaggiorazione.medpStato = msEdit) then
  begin
    TWA022FContratti(Self.Parent).AbilitaToolBar(TWA022FContratti(Self.Parent).grdNavigatorBar,False,TWA022FContratti(Self.Parent).actlstNavigatorBar);
    TWA022FContratti(Self.Parent).grdTabControl.Tabs[TWA022FContratti(Self.Parent).WBrowseFM].Enabled:=False;
    TWA022FContratti(Self.Parent).grdTabControl.Tabs[TWA022FContratti(Self.Parent).WDettaglioFM].Enabled:=False;
  end
  else
  begin
    TWA022FContratti(Self.Parent).AbilitaToolBar(TWA022FContratti(Self.Parent).grdNavigatorBar,True,TWA022FContratti(Self.Parent).actlstNavigatorBar);
    TWA022FContratti(Self.Parent).grdTabControl.Tabs[TWA022FContratti(Self.Parent).WBrowseFM].Enabled:=True;
    TWA022FContratti(Self.Parent).grdTabControl.Tabs[TWA022FContratti(Self.Parent).WDettaglioFM].Enabled:=True;
  end;
end;

procedure TWA022FFasceMaggiorazioneFM.grdFasceMaggiorazioneRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdFasceMaggiorazione.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdFasceMaggiorazione.medpCompGriglia) + 1) and (grdFasceMaggiorazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdFasceMaggiorazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

end.
