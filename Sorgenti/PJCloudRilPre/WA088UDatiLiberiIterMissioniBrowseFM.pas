unit WA088UDatiLiberiIterMissioniBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompListbox, meIWComboBox, IWCompLabel,
  meIWLabel, WA088UDatiLiberiIterMissioniDM, A000UCostanti, Math, Data.DB,
  C190FunzioniGeneraliWeb;

type
  TWA088FDatiLiberiIterMissioniBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA088FDatiLiberiIterMissioniBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MIN_FASE_VISIBILE'),0,DBG_EDT,'input_num_nn_neg','','null','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MAX_FASE_VISIBILE'),0,DBG_EDT,'input_num_nn_neg','','null','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MIN_FASE_MODIFICA'),0,DBG_EDT,'input_num_nn_neg','','null','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MAX_FASE_MODIFICA'),0,DBG_EDT,'input_num_nn_neg','','null','','D');
end;

end.
