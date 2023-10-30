unit WA117UOreLiquidateAnniPrecBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,C190FunzioniGeneraliWeb,
  meIWEdit, meIWComboBox, C180FunzioniGenerali, Vcl.Menus;

type
  TWA117FOreLiquidateAnniPrecBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  end;

implementation

{$R *.dfm}

procedure TWA117FOreLiquidateAnniPrecBrowseFM.grdTabellaDataSet2Componenti(
  Row: Integer);
var
  combo: TmeIWComboBox;
begin
  inherited;
  combo:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('OREPERSE'),0) as TmeIWComboBox);
  combo.Items.Clear;
  combo.Items.Add('S');
  combo.Items.Add('N');
  if grdTabella.medpValoreColonna(Row, 'OREPERSE') = 'S' then
    combo.ItemIndex:=0
  else
    combo.ItemIndex:=1;
end;

procedure TWA117FOreLiquidateAnniPrecBrowseFM.grdTabellaRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
{Evidenziazione in rosso del residuo negativo delle ore perse (MILANO_HMAGGIORE)}
begin
  inherited;
  if ARow < 1 then
    Exit;

  if ((AColumn + 1) in [grdTabella.medpIndexColonna('OREPERSE_TOT'), grdTabella.medpIndexColonna('OREPERSE_RES')]) and
     (R180OreMinutiExt(grdTabella.DataSource.DataSet.FieldByName('OREPERSE_RES').AsString) < 0) then
  begin
    ACell.Css:=ACell.Css + ' font_rossoImp';
  end;
end;

procedure TWA117FOreLiquidateAnniPrecBrowseFM.IWFrameRegionCreate(
  Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;

  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATA'),0,DBG_EDT,'input_data_my','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('OREPERSE'),0,DBG_CMB,'10','','','','S');
end;

end.
