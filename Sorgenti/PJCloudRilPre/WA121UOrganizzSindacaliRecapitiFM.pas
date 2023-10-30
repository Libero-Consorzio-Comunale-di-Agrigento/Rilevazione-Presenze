unit WA121UOrganizzSindacaliRecapitiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWImageFile, A000UCostanti,
  C190FunzioniGeneraliWeb, Vcl.Menus;

type
  TWA121FOrganizzSindacaliRecapitiFM = class(TWR203FGestDetailFM)
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    procedure imgAccediClick(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA121UOrganizzSindacali, WA121UOrganizzSindacaliDM;

{$R *.dfm}

procedure TWA121FOrganizzSindacaliRecapitiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPaginazione:=False;
  grdTabella.medpComandiCustom:=True;
  grdTabella.medpRowSelect:=False;
  grdTabella.medpAttivaGrid(((Self.Owner as TWA121FOrganizzSindacali).WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT241,False,False,False);
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ACCEDI','','','');
  // forzato per gestione componenti WR102-R
  grdTabella.medpCaricaCDS;
end;

procedure TWA121FOrganizzSindacaliRecapitiFM.grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var r : Integer;
    img : TmeIWImageFile;
begin
  inherited;
  for r :=0 to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0) <> nil then
    begin
      img:=(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0) as TmeIWImageFile);
      img.Enabled:=true;
      img.OnClick:=imgAccediClick;
    end;
end;
procedure TWA121FOrganizzSindacaliRecapitiFM.grdTabellaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  if not grdTabella.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdTabella.medpNumColonna(AColumn);
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdTabella.medpCompGriglia) + 1) and (grdTabella.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdTabella.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA121FOrganizzSindacaliRecapitiFM.imgAccediClick(Sender: TObject);
var r: Integer;
    Params: String;
begin
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Params:='CODICE=' + grdTabella.medpValoreColonna(r, 'CODICE') + ParamDelimiter +
          'TIPO_RECAPITO=' + grdTabella.medpValoreColonna(r, 'TIPO_RECAPITO') + ParamDelimiter +
          'PROG_RECAPITO=' + grdTabella.medpValoreColonna(r, 'PROG_RECAPITO');

  (Self.Owner as TWA121FOrganizzSindacali).AccediForm(97,Params);
end;

end.
