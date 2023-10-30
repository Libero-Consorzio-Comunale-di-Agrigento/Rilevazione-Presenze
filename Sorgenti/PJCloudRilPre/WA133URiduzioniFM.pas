unit WA133URiduzioniFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, OracleData, DB, C190FunzioniGeneraliWeb,
  Vcl.Menus;

type
  TWA133FRiduzioniFM = class(TWR203FGestDetailFM)
  private
    { Private declarations }
  public
    procedure CaricaDettaglio(DataSet:TDataSet; DataSource:TDataSource); overload;
  end;

implementation

{$R *.dfm}
{ TWA133FRiduzioniFM }

procedure TWA133FRiduzioniFM.CaricaDettaglio(DataSet: TDataSet;
  DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('PERC_RIDUZIONE'),0,DBG_EDT,'input_num_nnndd','','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('QUOTA_ESENTE'),0,DBG_EDT,'input_num_generic','','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COEFF_MAGGIORAZIONE'),0,DBG_EDT,'input_num_nnndddddd','','','','');
end;

end.
