unit WA190ULimitiEccedenzaResBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, WA190ULimitiEccedenzaResDM, meIWEdit,
  meIWLabel, medpIWMultiColumnComboBox, OracleData;

type
  TWA190FLimitiEccedenzaResBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    procedure CaricaComboCampo(Row: Integer; NumeroCampo, NomeCampo: String);
    procedure EditAsyncChange(Sender: TObject; EventParams: TStringList);
  end;

implementation

{$R *.dfm}

procedure TWA190FLimitiEccedenzaResBrowseFM.IWFrameRegionCreate(
  Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ANNO'),0,DBG_EDT,'input_num_nnnn','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOMECAMPO1'),0,DBG_LBL,'50','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAMPO1'),0,DBG_MECMB,'10','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOMECAMPO2'),0,DBG_LBL,'50','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAMPO2'),0,DBG_MECMB,'10','2','','','S');
end;

procedure TWA190FLimitiEccedenzaResBrowseFM.grdTabellaDataSet2Componenti(
  Row: Integer);
var Edit: TmeIWEdit;
begin
  inherited;
  //anno
  Edit:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ANNO'),0) as TmeIWEdit);
  Edit.Tag:=Row;
  Edit.OnAsyncChange:=EditAsyncChange;
  //nomeCampo1
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMECAMPO1'),0) as TmeIWLabel).Caption:=grdTabella.medpDataset.FieldByName('NOMECAMPO1').AsString;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMECAMPO2'),0) as TmeIWLabel).Caption:=grdTabella.medpDataset.FieldByName('NOMECAMPO2').AsString;
  CaricaComboCampo(Row,'1',grdTabella.medpDataset.FieldByName('NOMECAMPO1').AsString);
  CaricaComboCampo(Row,'2',grdTabella.medpDataset.FieldByName('NOMECAMPO2').AsString);
end;

procedure TWA190FLimitiEccedenzaResBrowseFM.CaricaComboCampo(Row:Integer;NumeroCampo: String;NomeCampo: String);
var
  Combo: TmedpIWMultiColumnComboBox;
  QLook: TOracleDataSet;
begin
  Combo:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAMPO' + NumeroCampo),0) as TmedpIWMultiColumnComboBox);
  Combo.Items.Clear;
  Combo.Enabled:=True;
  with (WR302DM as TWA190FLimitiEccedenzaResDM).A094FSkLimitiStraordMW do
  begin
    //devo verificare il nome campo su selT800_Data e non sul dataset della grigla(selTabella) perchè se cambio anno cambiano i campi
    if NomeCampo = '' then
    begin
      Combo.Enabled:=False;
      Combo.Text:='*';
      Exit;
    end;
    if NumeroCampo = '1' then
      QLook:=QLook1
    else
      QLook:=QLook2;
    QLook.First;
    while not QLook.Eof do
    begin
      Combo.AddRow(QLook.FieldByName('CODICE').AsString + ';' + QLook.FieldByName('DESCRIZIONE').AsString);
      QLook.Next;
    end;
    combo.Text:=grdTabella.medpDataSet.FieldByName('CAMPO' + NumeroCampo).AsString
  end;
end;

procedure TWA190FLimitiEccedenzaResBrowseFM.EditAsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  Row: Integer;
begin
  with (WR302DM as TWA190FLimitiEccedenzaResDM).A094FSkLimitiStraordMW do
  begin
    CambiaData((Sender as TmeIWEdit).Text,'R');
    Row:=(Sender as TmeIWEdit).Tag;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMECAMPO1'),0) as TmeIWLabel).Caption:=selT800_Data.FieldByName('NOMECAMPO1').AsString;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMECAMPO2'),0) as TmeIWLabel).Caption:=selT800_Data.FieldByName('NOMECAMPO2').AsString;
    CaricaComboCampo(Row,'1',selT800_Data.FieldByName('NOMECAMPO1').AsString);
    CaricaComboCampo(Row,'2',selT800_Data.FieldByName('NOMECAMPO2').AsString);
  end;
end;

end.
