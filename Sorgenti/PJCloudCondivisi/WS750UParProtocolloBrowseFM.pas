unit WS750UParProtocolloBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWComboBox, C190FunzioniGeneraliWeb;

type
  TWS750FParProtocolloBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWS750FParProtocolloBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
  var cmb: TmeIWComboBox;
begin
  inherited;
  //tipo xml
  cmb:=nil;
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPOXML'),0)<> nil) then
    cmb:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPOXML'),0) as TmeIWComboBox);
  if cmb <> nil then
  begin
    cmb.Items.Clear;
    cmb.Items.Add('A');
    cmb.ItemIndex:=cmb.Items.IndexOf(grdTabella.medpValoreColonna(Row, 'TIPOXML'));
    if cmb.ItemIndex = -1 then
      cmb.ItemIndex:=0;
  end;
  //invio consegna
  cmb:=nil;
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('INVIO_CONSEGNA'),0)<> nil) then
    cmb:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('INVIO_CONSEGNA'),0) as TmeIWComboBox);
  if cmb <> nil then
  begin
    cmb.Items.Clear;
    cmb.Items.Add('S');
    cmb.Items.Add('N');
    cmb.ItemIndex:=cmb.Items.IndexOf(grdTabella.medpValoreColonna(Row, 'INVIO_CONSEGNA'));
    if cmb.ItemIndex = -1 then
      cmb.ItemIndex:=0;
  end;
end;

procedure TWS750FParProtocolloBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPOXML'),0,DBG_CMB,'2','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('INVIO_CONSEGNA'),0,DBG_CMB,'2','','null','','S');
end;

end.
