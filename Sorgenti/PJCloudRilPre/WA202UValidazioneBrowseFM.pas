unit WA202UValidazioneBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, IWCompJQueryWidget,
  WR204UBrowseTabellaFM, C190FunzioniGeneraliWeb,StrUtils,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids,
  medpIWDBGrid,meIWCheckBox, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, meIWGrid;

type
  TWA202FValidazioneBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA202FValidazioneBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('VALIDAZIONE'),0,DBG_CHK,'','','','','C');
end;

procedure TWA202FValidazioneBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  if not grdTabella.medpDataset.FieldByName('VALIDAZIONE').ReadOnly then
    with(grdTabella.medpCompCella(grdTabella.medpDataset.RecNo,grdTabella.medpIndexColonna('VALIDAZIONE'),0) as TmeIWCheckBox) do
      grdTabella.medpDataset.FieldByName('VALIDAZIONE').AsString:=IfThen(Checked,'S','N');
end;

procedure TWA202FValidazioneBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  if not grdTabella.medpDataset.FieldByName('VALIDAZIONE').ReadOnly then
    with(grdTabella.medpCompCella(grdTabella.medpDataset.RecNo,grdTabella.medpIndexColonna('VALIDAZIONE'),0) as TmeIWCheckBox) do
      Checked:=grdTabella.medpValoreColonna(grdTabella.medpDataset.RecNo,'VALIDAZIONE') = 'S';
end;

end.
