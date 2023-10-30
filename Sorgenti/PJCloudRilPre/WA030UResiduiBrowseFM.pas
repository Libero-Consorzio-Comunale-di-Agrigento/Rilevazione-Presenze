unit WA030UResiduiBrowseFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils,  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompGrids, IWDBGrids,meIWComboBox, medpIWDBGrid,meIWLabel, WR200UBaseFM,C190FunzioniGeneraliWeb,medpIWMultiColumnComboBox, IWCompEdit,
  Vcl.Menus;

type
  TWA030FResiduiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdResiduiOrariRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    procedure Q130DataSet2Componenti(Row: Integer);
    procedure SelT131DataSet2Componenti(Row: Integer);
    procedure T264DataSet2Componenti(Row: Integer);
    procedure SelSG656DataSet2Componenti(Row: Integer);
    procedure SelT131Componenti2DataSet(Row: Integer);
    procedure T264Componenti2DataSet(Row: Integer);
    procedure SelSG656Componenti2DataSet(Row: Integer);
    procedure SelT131C_CAUSALEAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure SelT264CODRAGGRAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  public
    procedure PreparaComponentiSelT131;
    procedure PreparaComponentiSelSG656;
    procedure PreparaComponentiT264;
    procedure PreparaComponentiT692;
    procedure PreparaComponentiQ130;
  end;

implementation

uses WA030UResidui, WA030UResiduiDM;

{$R *.dfm}

procedure TWA030FResiduiBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  case (Self.Owner as TWA030FResidui).grdTabControl.TabIndex of
  1:SelT131Componenti2DataSet(Row);
  2:T264Componenti2DataSet(Row);
  4:SelSG656Componenti2DataSet(Row);
  end;
end;

procedure TWA030FResiduiBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  case (Self.Owner as TWA030FResidui).grdTabControl.TabIndex of
  0:Q130DataSet2Componenti(Row);
  1:SelT131DataSet2Componenti(Row);
  2:T264DataSet2Componenti(Row);
  4:SelSG656DataSet2Componenti(Row);
  end;
end;

procedure TWA030FResiduiBrowseFM.PreparaComponentiSelT131;
begin
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('C_CAUSALE'),0,DBG_MECMB,'15','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_CAUSALE'),0,DBG_LBL,'20','2','','','S');
end;

procedure TWA030FResiduiBrowseFM.PreparaComponentiT264;
begin
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODRAGGR'),0,DBG_MECMB,'20','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_RAGGRUPPAMENTO'),0,DBG_LBL,'20','2','','','S');
end;

procedure TWA030FResiduiBrowseFM.PreparaComponentiT692;
begin
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpPreparaComponentiDefault;
end;

procedure TWA030FResiduiBrowseFM.PreparaComponentiQ130;
begin
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_ANNO'),0,DBG_LBL,'20','2','','','S');
end;

procedure TWA030FResiduiBrowseFM.PreparaComponentiSelSG656;
begin
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('C_PROFILO_CREDITI'),0,DBG_CMB,'15','','','','S');
end;

procedure TWA030FResiduiBrowseFM.grdResiduiOrariRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

procedure TWA030FResiduiBrowseFM.SelT131DataSet2Componenti(Row: Integer);
begin
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE'),0)).Text:=grdTabella.medpValoreColonna(Row, 'D_CAUSALE');
  with (WR302DM as TWA030FResiduiDM).A030MW.selT275 do
  begin
    First;
    while not eof do
    begin
      TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('C_CAUSALE'),0)).AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('C_CAUSALE'),0) as TmedpIWMultiColumnComboBox) do
  begin
    OnAsyncChange:=SelT131C_CAUSALEAsyncChange;
    Text:=grdTabella.medpValoreColonna(Row, 'C_CAUSALE');
  end;
end;

procedure TWA030FResiduiBrowseFM.SelSG656DataSet2Componenti(Row: Integer);
begin
  with (WR302DM as TWA030FResiduiDM).A030MW.selSG657 do
  begin
    First;
    while not eof do
    begin
      TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('C_PROFILO_CREDITI'),0)).Items.Add(FieldByName('CODICE').AsString);
      Next;
    end;
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('C_PROFILO_CREDITI'),0) as TmeIWComboBox) do
  begin
    RequireSelection:=True;
    NoSelectionText:=' ';
    ItemIndex:=StrToInt(ifthen(Row>0,IntToStr(Items.IndexOf(grdTabella.medpValoreColonna(Row, 'C_PROFILO_CREDITI'))),'0'));
  end;
end;

procedure TWA030FResiduiBrowseFM.T264DataSet2Componenti(Row: Integer);
begin
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_RAGGRUPPAMENTO'),0)).Text:=grdTabella.medpValoreColonna(Row, 'D_RAGGRUPPAMENTO');
  with (WR302DM as TWA030FResiduiDM).A030MW.Q260 do
  begin
    First;
    while not eof do
    begin
      TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODRAGGR'),0)).AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODRAGGR'),0) as TmedpIWMultiColumnComboBox) do
  begin
    OnAsyncChange:=SelT264CODRAGGRAsyncChange;
    Text:=grdTabella.medpValoreColonna(Row, 'CODRAGGR');
  end;
end;

procedure TWA030FResiduiBrowseFM.SelT131Componenti2DataSet(Row: Integer);
begin
  (WR302DM as TWA030FResiduiDM).A030MW.selT131.FieldByName('CAUSALE').AsString:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('C_CAUSALE'),0)).Text;
end;

procedure TWA030FResiduiBrowseFM.SelSG656Componenti2DataSet(Row: Integer);
begin
  (WR302DM as TWA030FResiduiDM).A030MW.selSG656.FieldByName('PROFILO_CREDITI').AsString:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('C_PROFILO_CREDITI'),0)).Text;

end;

procedure TWA030FResiduiBrowseFM.T264Componenti2DataSet(Row: Integer);
begin
  (WR302DM as TWA030FResiduiDM).A030MW.T264.FieldByName('CODRAGGR').AsString:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODRAGGR'),0)).Text;
end;

procedure TWA030FResiduiBrowseFM.Q130DataSet2Componenti(Row: Integer);
begin
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_ANNO'),0)).Text:=(WR302DM as TWA030FResiduiDM).A030MW.Q130.FieldByName('D_Anno').AsString;
end;

procedure TWA030FResiduiBrowseFM.SelT131C_CAUSALEAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var Descrizione:String;
begin
  Descrizione:=(WR302DM as TWA030FResiduiDM).A030MW.selT275.LookUp('CODICE',TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('C_CAUSALE'),0)).text,'DESCRIZIONE');
  with TmeIWLabel(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('D_CAUSALE'),0)) do
    Text:=Descrizione;
end;

procedure TWA030FResiduiBrowseFM.SelT264CODRAGGRAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var Descrizione:String;
begin
  Descrizione:=(WR302DM as TWA030FResiduiDM).A030MW.Q260.LookUp('CODICE',TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('CODRAGGR'),0)).text,'DESCRIZIONE');
  with TmeIWLabel(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('D_RAGGRUPPAMENTO'),0)) do
    Text:=Descrizione;
end;

end.
