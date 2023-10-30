unit WA053USquadreAreeTurniFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  Db, OracleData, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, WR203UGestDetailFM, medpIWMultiColumnComboBox,meIWEdit,
  System.Actions, Vcl.Menus;

type
  TWA053FSquadreAreeTurniFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
   procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
 end;

implementation

uses WA053USquadre,WA053USquadreDM,WA053USquadreBrowseFM;

{$R *.dfm}

procedure TWA053FSquadreAreeTurniFM.CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource);
begin
  grdTabella.medpEditMultiplo:=True;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICE_OPERATORE'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICE_AREA'),0,DBG_MECMB,'10','2','null','','S');
end;

procedure TWA053FSquadreAreeTurniFM.grdTabellaDataSet2Componenti(Row: Integer);
var cmb:TmedpIWMultiColumnComboBox;
begin
  inherited;
  //Inserisco chiave primaria nel caso di inserimento nuovo record
  with grdTabella.medpDataSet.Fields[grdTabella.medpIndexColonna('CODICE_SQUADRA')] do
    if AsString = '' then
      AsString:=TWA053FSquadreDM(WR302DM).selTabellaCODICE.AsString;

  cmb:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE_OPERATORE'),0));
  cmb.css:='MulticolCmb';
  cmb.Items.Clear;
  with TWA053FSquadreDM(WR302DM).lstT601 do
  begin
    First;
    while not Eof do
    begin
      TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE_OPERATORE'),0)).AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  cmb:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE_AREA'),0));
  cmb.css:='MulticolCmb';
  cmb.Items.Clear;
  with TWA053FSquadreDM(WR302DM).selT650 do
  begin
    First;
    while not Eof do
    begin
      TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE_AREA'),0)).AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

end.
