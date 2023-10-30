unit WA161UTipoAbbattimentiBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, meIWComboBox,
  A161UTipoAbbattimentiMW;

type
  TWA161FTipoAbbattimentiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);


  private
    { Private declarations }
    var
      riga:Integer;
  public
    { Public declarations }
  end;

implementation

uses
  WA161UTipoAbbattimentiDM, WR102UGestTabella, IWApplication;

{$R *.dfm}

procedure TWA161FTipoAbbattimentiBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  cmb: TmeIWComboBox;
begin
  inherited;

  cmb:=nil;
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('RISPARMIO_BILANCIO'),0)<> nil) then
    cmb:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('RISPARMIO_BILANCIO'),0) as TmeIWComboBox);

  if cmb <> nil then
  begin
    cmb.Items.Clear;
    cmb.Items.Add('N');
    cmb.Items.Add('S');
    cmb.ItemIndex:=cmb.Items.IndexOf(grdTabella.medpValoreColonna(Row, 'RISPARMIO_BILANCIO'));
    if cmb.ItemIndex = -1 then
      cmb.ItemIndex:=0;
  end;
end;

procedure TWA161FTipoAbbattimentiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('RISPARMIO_BILANCIO'),0,DBG_CMB,'2','','null','','S');
end;

end.
