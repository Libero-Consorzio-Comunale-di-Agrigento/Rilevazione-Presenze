unit WA082UCdcPercentBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,C190FunzioniGeneraliWeb,
  medpIWMultiColumnComboBox, meIWLabel, IWCompMemo,A000UMessaggi, IWCompEdit,
  Vcl.Menus, meIWEdit;

type
  TWA082FCdcPercentBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
    procedure AggiornaComboCdc(combo:TmedpIWMultiColumnComboBox);
    procedure MultiColumnComboBoxAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure edtScadenzaAsyncExit(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation uses WA082UCdcPercentDM;

{$R *.dfm}

procedure TWA082FCdcPercentBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICE'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_CODICE'),0,DBG_LBL,'20','','null','','S');
end;

procedure TWA082FCdcPercentBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var combo: TmedpIWMultiColumnComboBox;
    edtScadenza: TmeIWEdit;
begin
  inherited;
  edtScadenza:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DECORRENZA_FINE'),0) as TmeIWEdit);
  edtScadenza.OnAsyncExit:=edtScadenzaAsyncExit;
  edtScadenza.Tag:=Row;
  combo:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE'),0) as TmedpIWMultiColumnComboBox);
  combo.Tag:=Row;
  combo.OnAsyncChange:=MultiColumnComboBoxAsyncChange;
  AggiornaComboCdc(combo);
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CODICE'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_CODICE').AsString;
end;

procedure TWA082FCdcPercentBrowseFM.AggiornaComboCdc(combo:TmedpIWMultiColumnComboBox);
begin
  combo.items.Clear;
  with TWA082FCdcPercentDM(WR302DM).A082FCdcPercentMW do
  begin
    AggiornaElencoCdc(selCdcPercent);
    selCdcPercent.First;
    while not selCdcPercent.Eof do
    begin
      combo.addRow(selCdcPercent.FieldByName('CODICE').AsString + ';' + selCdcPercent.FieldByName('DESCRIZIONE').AsString);
      selCdcPercent.Next;
    end;
  end;
end;

procedure TWA082FCdcPercentBrowseFM.MultiColumnComboBoxAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  grdTabella.medpDataSet.FieldByName('CODICE').AsString:=(Sender as TmedpIWMultiColumnComboBox).Text;
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CODICE'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_CODICE').AsString;
end;

procedure TWA082FCdcPercentBrowseFM.edtScadenzaAsyncExit(Sender: TObject; EventParams: TStringList);
var Row: Integer;
begin
  Row:=(Sender as TmeIWEdit).Tag;
  grdTabella.medpDataSet.FieldByName('DECORRENZA_FINE').AsString:=(Sender as TmeIWEdit).Text;
  AggiornaComboCdc(TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE'),0)));
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CODICE'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_CODICE').AsString;
end;

end.
