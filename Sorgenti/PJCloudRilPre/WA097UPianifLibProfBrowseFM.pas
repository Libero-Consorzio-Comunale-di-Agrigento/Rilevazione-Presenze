unit WA097UPianifLibProfBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb,
  meIWEdit, DB, meIWLabel, medpIWMultiColumnComboBox, StrUtils, IWCompEdit,
  C180FunzioniGenerali;

type
  TWA097FPianifLibProfBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbCausaleChange(Sender: TObject; Index: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA097UPianifLibProfDM;

{$R *.dfm}

procedure TWA097FPianifLibProfBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPaginazione:=True;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_GIORNO'),0,DBG_LBL,'8','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALE'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_CAUSALE'),0,DBG_LBL,'8','','null','','S');
end;

procedure TWA097FPianifLibProfBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA'),0) as TmeIWEdit) do
  begin
    Css:='input_data_dmy';
    Tag:=Row;
    OnAsyncChange:=edtDataAsyncChange;
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_GIORNO'),0) as TmeIWLabel) do
    Caption:=IfThen((WR302DM as TWA097FPianifLibProfDM).SelTabella.State = dsInsert,'',grdTabella.medpDataSet.FieldByName('D_GIORNO').AsString);
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    Text:=ifthen((grdTabella.medpValoreColonna(Row,'CAUSALE')<>''),grdTabella.medpValoreColonna(Row,'CAUSALE'),'');
    with (WR302DM as TWA097FPianifLibProfDM).A097MW do
    begin
      Q275.First;
      while not Q275.Eof do
      begin
        AddRow(Q275.FieldByName('CODICE').AsString + ';' + Q275.FieldByName('DESCRIZIONE').AsString);
        Q275.Next;
      end;
    end;
    OnChange:=cmbCausaleChange;
  end;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('D_CAUSALE').AsString;
end;

procedure TWA097FPianifLibProfBrowseFM.edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
var Row: Integer;
begin
  Row:=(Sender as TmeIWEdit).Tag;
  if (Sender as TmeIWEdit).Text <> '' then
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_GIORNO'),0) as TmeIWLabel).Caption:=R180NomeGiorno(StrToDate((Sender as TmeIWEdit).Text))
  else
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_GIORNO'),0) as TmeIWLabel).Caption:='';
end;

procedure TWA097FPianifLibProfBrowseFM.cmbCausaleChange(Sender: TObject; Index: Integer);
var Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE'),0) as TmeIWLabel).Caption:=VarToStr((WR302DM as TWA097FPianifLibProfDM).A097MW.Q275.Lookup('CODICE',(Sender as TmedpIWMultiColumnComboBox).Text,'DESCRIZIONE'));
end;

procedure TWA097FPianifLibProfBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA097FPianifLibProfDM).SelTabella do
    FieldByName('CAUSALE').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).Text;
end;

end.
