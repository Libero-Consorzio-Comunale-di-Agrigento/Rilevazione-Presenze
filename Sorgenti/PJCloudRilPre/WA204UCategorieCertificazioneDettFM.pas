unit WA204UCategorieCertificazioneDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  Oracle, OracleData, Data.DB, C190FunzioniGeneraliWeb,
  meIWEdit, medpIWMultiColumnComboBox, meIWLabel;

type
  TWA204FCategorieCertificazioneDettFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses
  WA204UModelliCertificazione, WA204UModelliCertificazioneDM, A000UCostanti;
{$R *.dfm}

{ TWA204FCategorieCertificazioneDettFM }

procedure TWA204FCategorieCertificazioneDettFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with TWA204FModelliCertificazioneDM(WR302DM).selSG236 do
  begin
    FieldByName('DESCRIZIONE').AsString:=StringReplace(Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCRIZIONE_CALC'),0) as TmeIWLabel).Text), CRLF, '<br>',[rfReplaceAll]);
  end;
end;

procedure TWA204FCategorieCertificazioneDettFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
inherited;
  TWA204FModelliCertificazione(Self.Owner).CreaBtnTesto(grdTabella, TWA204FModelliCertificazioneDM(WR302DM).selSG236, 'DESCRIZIONE_CALC',Row);
end;

procedure TWA204FCategorieCertificazioneDettFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPaginazione:=True;
  grdTabella.medpRighePagina:=50;
  grdTabella.medpEditMultiplo:=False;
  grdTabella.medpPreparaComponenteGenerico('WR102','DESCRIZIONE_CALC',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','DESCRIZIONE_CALC',1,DBG_IMG,'','PUNTINI','','','D');
  grdTabella.medpCaricaCDS;
end;

end.
