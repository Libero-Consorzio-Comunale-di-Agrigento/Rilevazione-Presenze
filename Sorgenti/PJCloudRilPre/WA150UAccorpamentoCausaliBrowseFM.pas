unit WA150UAccorpamentoCausaliBrowseFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb,
  medpIWMultiColumnComboBox , meIWLabel, Vcl.Menus;

type
  TWA150FAccorpamentoCausaliBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    procedure cmbTipoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  public
    { Public declarations }
  end;


implementation

uses WA150UAccorpamentoCausaliDM;

{$R *.dfm}

procedure TWA150FAccorpamentoCausaliBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPO'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_TIPO'),0,DBG_LBL,'20','','null','','S');
end;

procedure TWA150FAccorpamentoCausaliBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  TWA150FAccorpamentoCausaliDM(WR302DM).SelTabella.FieldByName('TIPO').AsString:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO'),0)).Text;
end;

procedure TWA150FAccorpamentoCausaliBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var i: Integer;
begin
  inherited;
 (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_TIPO'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('D_TIPO').AsString;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    OnAsyncChange:=cmbTipoAsyncChange;
    Text:=ifthen((grdTabella.medpValoreColonna(Row, 'TIPO')<>''),grdTabella.medpValoreColonna(Row, 'TIPO'),(WR302DM as TWA150FAccorpamentoCausaliDM).D_Tipo[0].Item);
    for i := 0 to High((WR302DM as TWA150FAccorpamentoCausaliDM).D_Tipo) do
      AddRow((WR302DM as TWA150FAccorpamentoCausaliDM).D_Tipo[i].Item+';'+(WR302DM as TWA150FAccorpamentoCausaliDM).D_Tipo[i].Value);
  end;
end;

procedure TWA150FAccorpamentoCausaliBrowseFM.cmbTipoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  grdTabella.medpDataSet.FieldByName('TIPO').AsString:=(Sender as TmedpIWMultiColumnComboBox).Text;
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_TIPO'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_TIPO').AsString;
end;


end.
