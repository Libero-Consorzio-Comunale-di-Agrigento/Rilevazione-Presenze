unit WA205UAreeSquadreFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  DB, OracleData, C190FunzioniGeneraliWeb, meIWComboBox;

type
  TWA205FAreeSquadreFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WA205USquadre, WA205USquadreDM;

{$R *.dfm}

procedure TWA205FAreeSquadreFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpEditMultiplo:=False;
end;

procedure TWA205FAreeSquadreFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESCRIZIONE_AREA'),0,DBG_CMB_COUR,'80','','','','S');
end;

procedure TWA205FAreeSquadreFM.grdTabellaDataSet2Componenti(Row: Integer);
var cmb: TmeIWComboBox;
    i: Integer;
begin
  inherited;
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCRIZIONE_AREA'),0) <> nil then
    cmb:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCRIZIONE_AREA'),0) as TmeIWComboBox);
  if cmb <> nil then
  begin
    cmb.Items.Clear;
    cmb.ItemsHaveValues:=True;
    cmb.NoSelectionText:='';
    with (WR302DM as TWA205FSquadreDM).A205MW.selT650 do
    begin
      First;
      while not Eof do
      begin
        cmb.Items.Add(FieldByName('DECODIFICA').AsString + '=' + FieldByName('CODICE').AsString);
        if FieldByName('CODICE').AsString = (WR302DM as TWA205FSquadreDM).A205MW.selT651.FieldByName('CODICE_AREA').AsString then
          cmb.ItemIndex:=cmb.Items.Count - 1;
        Next;
      end;
    end;
  end;
  (Self.Owner as TWA205FSquadre).CaricaJQAutocomplete(grdTabella,Row);
  (Self.Owner as TWA205FSquadre).AbilitaJqAutocomplete(True);
end;

procedure TWA205FAreeSquadreFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA205FSquadreDM).A205MW do
    selT651.FieldByName('CODICE_AREA').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCRIZIONE_AREA'),0) as TmeIWComboBox).SelectedValue;
end;

end.
