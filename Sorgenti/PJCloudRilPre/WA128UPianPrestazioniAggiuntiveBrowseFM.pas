unit WA128UPianPrestazioniAggiuntiveBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, DB,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, StrUtils,
  C190FunzioniGeneraliWeb, meIWEdit, meIWLabel, medpIWMultiColumnComboBox,
  Vcl.Menus;

type
  TWA128FPianPrestazioniAggiuntiveBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    procedure AzzeraOrario(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure AzzeraTurni(Sender: TObject; EventParams: TStringList);
  public
    { Public declarations }
  end;

implementation

uses WA128UPianPrestazioniAggiuntive, WA128UPianPrestazioniAggiuntiveDM;

{$R *.dfm}

procedure TWA128FPianPrestazioniAggiuntiveBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPaginazione:=True;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MATRICOLA'),0,DBG_LBL,'8','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOMINATIVO'),0,DBG_LBL,'61','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO1'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO2'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORAINIZIO_TURNO1'),0,DBG_EDT,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORAFINE_TURNO1'),0,DBG_EDT,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORAINIZIO_TURNO2'),0,DBG_EDT,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORAFINE_TURNO2'),0,DBG_EDT,'','','','','S');
end;

procedure TWA128FPianPrestazioniAggiuntiveBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA'),0)).Css:='input_data_dmy';
  if (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).selTabella.State = dsEdit then
  begin
   (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('MATRICOLA'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('MATRICOLA').AsString;
   (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMINATIVO'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('NOMINATIVO').AsString;
  end
  else if (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).SelTabella.State = dsInsert then
  begin
   (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('MATRICOLA'),0) as TmeIWLabel).Caption:=(WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.selAnagrafe.FieldByName('MATRICOLA').AsString;
   (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMINATIVO'),0) as TmeIWLabel).Caption:=(WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW.selAnagrafe.FieldByName('NOMINATIVO').AsString;
  end;
  //Combo Turno1
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    Text:=ifthen((grdTabella.medpValoreColonna(Row,'TURNO1')<>''),grdTabella.medpValoreColonna(Row,'TURNO1'),'');
    with (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
    begin
      Q330.First;
      while not Q330.Eof do
      begin
        AddRow(Q330.FieldByName('CODICE').AsString + ';' + Q330.FieldByName('DESCRIZIONE').AsString);
        Q330.Next;
      end;
    end;
    OnAsyncChange:=AzzeraOrario;
    Tag:=Row;
  end;
  //Combo Turno2
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    Text:=ifthen((grdTabella.medpValoreColonna(Row,'TURNO2')<>''),grdTabella.medpValoreColonna(Row,'TURNO2'),'');
    with (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
    begin
      Q330.First;
      while not Q330.Eof do
      begin
        AddRow(Q330.FieldByName('CODICE').AsString + ';' + Q330.FieldByName('DESCRIZIONE').AsString);
        Q330.Next;
      end;
    end;
    OnAsyncChange:=AzzeraOrario;
    Tag:=Row;
  end;
  with TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAINIZIO_TURNO1'),0)) do
  begin
    Css:='input_hour_of_day width5chr';
    OnAsyncChange:=AzzeraTurni;
    Tag:=Row;
  end;
  with TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAFINE_TURNO1'),0)) do
  begin
    Css:='input_hour_of_day width5chr';
    OnAsyncChange:=AzzeraTurni;
    Tag:=Row;
  end;
  with TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAINIZIO_TURNO2'),0)) do
  begin
    Css:='input_hour_of_day width5chr';
    OnAsyncChange:=AzzeraTurni;
    Tag:=Row;
  end;
  with TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAFINE_TURNO2'),0)) do
  begin
    Css:='input_hour_of_day width5chr';
    OnAsyncChange:=AzzeraTurni;
    Tag:=Row;
  end;
end;

procedure TWA128FPianPrestazioniAggiuntiveBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA128FPianPrestazioniAggiuntiveDM).SelTabella do
  begin
    FieldByName('TURNO1').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('TURNO2').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('ORAINIZIO_TURNO1').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAINIZIO_TURNO1'),0) as TmeIWEdit).Text;
    FieldByName('ORAFINE_TURNO1').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAFINE_TURNO1'),0) as TmeIWEdit).Text;
    FieldByName('ORAINIZIO_TURNO2').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAINIZIO_TURNO2'),0) as TmeIWEdit).Text;
    FieldByName('ORAFINE_TURNO2').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAFINE_TURNO2'),0) as TmeIWEdit).Text;
  end;
end;

procedure TWA128FPianPrestazioniAggiuntiveBrowseFM.AzzeraOrario(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  Row:Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAINIZIO_TURNO1'),0)).Text:='';
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAFINE_TURNO1'),0)).Text:='';
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAINIZIO_TURNO2'),0)).Text:='';
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORAFINE_TURNO2'),0)).Text:='';
end;

procedure TWA128FPianPrestazioniAggiuntiveBrowseFM.AzzeraTurni(Sender: TObject; EventParams: TStringList);
var
  Row:Integer;
begin
  Row:=(Sender as TmeIWEdit).Tag;
  TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0)).Text:='';
  TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0)).Text:='';
end;

end.
