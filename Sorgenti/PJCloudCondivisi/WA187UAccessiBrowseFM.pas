unit WA187UAccessiBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, DB, DBClient, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel, meIWLabel,
  IWCompListbox, IWDBStdCtrls, meIWDBLookupComboBox, Oracle, OracleData,
  C190FunzioniGeneraliWeb, IWCompJQueryWidget, IWCompGrids,meIWComboBox, Vcl.Menus;

type
  TWA187FAccessiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA187UAccessiDM, WA187UAccessi, WR100UBase;

{$R *.dfm}

procedure TWA187FAccessiBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
var posAccesso: Integer;
begin
  inherited;
  posAccesso:=grdTabella.medpIndexColonna('ACCESSO_NEGATO');
  WR302DM.selTabella.FieldByName('ACCESSO_NEGATO').AsString:=TmeIWComboBox(grdTabella.medpCompCella(Row,posAccesso,0)).Text;
end;

procedure TWA187FAccessiBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  colAccNegato: integer;
begin
  inherited;
  colAccNegato:=grdTabella.medpIndexColonna('ACCESSO_NEGATO');
  TmeIWComboBox(grdTabella.medpCompCella(Row,colAccNegato,0)).Items.Add('S');
  TmeIWComboBox(grdTabella.medpCompCella(Row,colAccNegato,0)).Items.Add('N');
  TmeIWComboBox(grdTabella.medpCompCella(Row,colAccNegato,0)).ItemIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,colAccNegato,0)).Items.IndexOf(grdTabella.medpValoreColonna(Row, 'ACCESSO_NEGATO'));
end;

procedure TWA187FAccessiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpEditMultiplo:=True;
  grdTabella.medpPreparaComponenteGenerico('WR102',2,0,DBG_CMB,'10','','null','','S');
end;

end.
