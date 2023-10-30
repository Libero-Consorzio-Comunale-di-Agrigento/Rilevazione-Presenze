unit WA073UAcquistoBuoniBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, meIWComboBox, meIWEdit, Vcl.Menus;

type
  TWA073FAcquistoBuoniBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    procedure edtAsyncChange(Sender: TObject; EventParams: TStringList);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA073UAcquistoBuoni,WA073UAcquistoBuoniDM;

{$R *.dfm}

procedure TWA073FAcquistoBuoniBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  if TWA073FAcquistoBuoniDM(WR302DM).selTabella.FieldByName('DATA_MAGAZZINO').Visible then
  begin
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATA_MAGAZZINO'),0,DBG_CMB,'10','','','','S');
  end;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TICKET'),0,DBG_EDT,'input_num_nnnn_neg','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('BUONIPASTO'),0,DBG_EDT,'input_num_nnnn_neg','','','','S');
end;

procedure TWA073FAcquistoBuoniBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  if TWA073FAcquistoBuoniDM(WR302DM).selTabella.FieldByName('DATA_MAGAZZINO').Visible then
  begin
    TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_MAGAZZINO'),0)).Items.Clear;
    TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_MAGAZZINO'),0)).NoSelectionText:= ' ';
    TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_MAGAZZINO'),0)).RequireSelection:=True;
    with TWA073FAcquistoBuoniDM(WR302DM).A073MW.selT691 do
    begin
      First;
      while not eof do
      begin
        TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_MAGAZZINO'),0)).Items.Add(FieldByName('DATA_ACQUISTO').AsString);
        Next;
      end;
    end;
    with TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_MAGAZZINO'),0)) do
      if Items.IndexOf(grdTabella.medpValoreColonna(Row,'DATA_MAGAZZINO')) >= 0 then
        ItemIndex:=Items.IndexOf(grdTabella.medpValoreColonna(Row,'DATA_MAGAZZINO'))
      else
        ItemIndex:=0;
  end;
  if TWA073FAcquistoBuoniDM(WR302DM).selTabella.FieldByName('ID_BLOCCHETTI').Visible then
  begin
    TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ID_BLOCCHETTI'),0)).onAsyncChange:=edtAsyncChange;
  end;
end;

procedure TWA073FAcquistoBuoniBrowseFM.edtAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  try
    TWA073FAcquistoBuoniDM(WR302DM).selTabella.FieldByName('ID_BLOCCHETTI').AsString:=TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.recNo-1,grdTabella.medpIndexColonna('ID_BLOCCHETTI'),0)).Text;
  except
    //GGetWebApplicationThreadVar.ShowMessage('ERORE!!');
  end;
  TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.recNo-1,grdTabella.medpIndexColonna('BUONIPASTO'),0)).Text:=TWA073FAcquistoBuoniDM(WR302DM).selTabella.FieldByName('BUONIPASTO').AsString;
  TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.recNo-1,grdTabella.medpIndexColonna('TICKET'),0)).Text:=TWA073FAcquistoBuoniDM(WR302DM).selTabella.FieldByName('TICKET').AsString;
end;

end.
