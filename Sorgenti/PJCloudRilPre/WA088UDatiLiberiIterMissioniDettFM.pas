unit WA088UDatiLiberiIterMissioniDettFM;

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
  meIWEdit, medpIWMultiColumnComboBox;

type
  TWA088FDatiLiberiIterMissioniDettFM = class(TWR203FGestDetailFM)
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses
  WA088UDatiLiberiIterMissioniDM;

{$R *.dfm}

procedure TWA088FDatiLiberiIterMissioniDettFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('OBBLIGATORIO'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FORMATO'),0,DBG_MECMB,'1','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ELENCO_FISSO'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATO_ANAGRAFICO'),0,DBG_MECMB,'10','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('QUERY_VALORE'),0,DBG_MECMB,'10','1','null','','S');
  grdTabella.medpCaricaCDS;
end;

procedure TWA088FDatiLiberiIterMissioniDettFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  DS: TOracleDataSet;
begin
  inherited;

  // obbligatorio: combobox con valori [S | N]
  with (grdTabella.medpCompCella(Row,'OBBLIGATORIO',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=3;
    Items.Clear;
    AddRow('S');
    AddRow('N');
    Text:=grdTabella.medpValoreColonna(Row,'OBBLIGATORIO');
  end;

  // formato: combobox con valori [S | N | D | M]
  with (grdTabella.medpCompCella(Row,'FORMATO',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=4;
    Items.Clear;
    AddRow('S;Stringa');
    AddRow('N;Numerico');
    AddRow('D;Data');
    AddRow('M;Messaggio');
    Text:=grdTabella.medpValoreColonna(Row,'FORMATO');
  end;

  // lunghezza max
  with (grdTabella.medpCompCella(Row,'LUNG_MAX',0) as TmeIWEdit) do
  begin
    Hint:='<html>0 = Limite massimo (2000 caratteri)';
    ShowHint:=True;
  end;

  // elenco fisso: combobox con valori [S | N]
  with (grdTabella.medpCompCella(Row,'ELENCO_FISSO',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=3;
    Items.Clear;
    AddRow('S');
    AddRow('N');
    Text:=grdTabella.medpValoreColonna(Row,'ELENCO_FISSO');
  end;

  // valori
  with (grdTabella.medpCompCella(Row,'VALORI',0) as TmeIWEdit) do
  begin
    Hint:='<html>Indicare l''elenco di valori da proporre separati da virgola';
    ShowHint:=True;
  end;

  // dato anagrafico: combobox con elenco
  with (grdTabella.medpCompCella(Row,'DATO_ANAGRAFICO',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=10;
    Items.Clear;

    DS:=TWA088FDatiLiberiIterMissioniDM(WR302DM).A088FDatiLiberiIterMissioniMW.selT430Colonne;
    DS.Open;
    DS.First;
    while not DS.Eof do
    begin
      AddRow(DS.FieldByName('COLUMN_NAME').AsString);
      DS.Next;
    end;
    Text:=grdTabella.medpValoreColonna(Row,'DATO_ANAGRAFICO');
  end;

  // interrogazioni servizio: combobox con elenco
  with (grdTabella.medpCompCella(Row,'QUERY_VALORE',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=10;
    Items.Clear;

    DS:=TWA088FDatiLiberiIterMissioniDM(WR302DM).A088FDatiLiberiIterMissioniMW.selT002;
    DS.Open;
    DS.First;
    while not DS.Eof do
    begin
      AddRow(DS.FieldByName('NOME').AsString);
      DS.Next;
    end;
    Text:=grdTabella.medpValoreColonna(Row,'QUERY_VALORE');
  end;
end;

procedure TWA088FDatiLiberiIterMissioniDettFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  //
end;

end.
