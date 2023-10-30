unit WA080USoglieStraordinarioOutputFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Db,OracleData, WR203UGestDetailFM, ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, meIWComboBox, WA080USoglieStraordinarioDM,
  System.Actions, Vcl.Menus;

type
  TWA080FSoglieStraordinarioOutputFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA080FSoglieStraordinarioOutputFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  grdTabella.medpEditMultiplo:=False;
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_CAUSALE_GGLAV'),0,DBG_CMB,'20','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_CAUSALE_GGNONLAV'),0,DBG_CMB,'20','','','','S');
end;

procedure TWA080FSoglieStraordinarioOutputFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  TWA080FSoglieStraordinarioDM(WR302DM).selT028.FieldByName('CAUSALE_GGLAV').AsString:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGLAV'),0)).Text;
  TWA080FSoglieStraordinarioDM(WR302DM).selT028.FieldByName('CAUSALE_GGNONLAV').AsString:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGNONLAV'),0)).Text;
end;

procedure TWA080FSoglieStraordinarioOutputFM.grdTabellaDataSet2Componenti(Row: Integer);
var GgLavIndex,GgNonLavIndex:Integer;
begin
  inherited;
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGLAV'),0)).Items.Add(' ');
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGNONLAV'),0)).Items.Add(' ');

  with TWA080FSoglieStraordinarioDM(WR302DM).selT275 do
  begin
    First;
    while not eof do
    begin
      TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGLAV'),0)).Items.Add(FieldByName('CODICE').AsString);
      TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGNONLAV'),0)).Items.Add(FieldByName('CODICE').AsString);
      Next;
    end;
  end;

  with TWA080FSoglieStraordinarioDM(WR302DM).selT028 do
  begin
    if FieldByName('D_CAUSALE_GGLAV').AsString <> '' then
      GgLavIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGLAV'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row, 'D_CAUSALE_GGLAV'))
    else
      GgLavIndex:=0;
    if FieldByName('D_CAUSALE_GGNONLAV').AsString <> '' then
      GgNonLavIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGNONLAV'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row, 'D_CAUSALE_GGNONLAV'))
    else
      GgNonLavIndex:=0;
  end;
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGLAV'),0)).ItemIndex:=GgLavIndex;
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGNONLAV'),0)).ItemIndex:=GgNonLavIndex;

  //TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGLAV'),0)).ItemIndex:=StrToInt(ifthen(Row>0,IntToStr(TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGLAV'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row, 'D_CAUSALE_GGLAV'))),'0'));
  //TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGNONLAV'),0)).ItemIndex:=StrToInt(ifthen(Row>0,IntToStr(TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE_GGNONLAV'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row, 'D_CAUSALE_GGNONLAV'))),'0'));
end;

end.
