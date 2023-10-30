unit WA011UEntiLocaliBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, DB, DBClient, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWLayoutMgrHTML, IWCompMemo,
  IWCompLabel, xmlDoc, ActiveX, IWHTMLTag, C190FunzioniGeneraliWeb, meIWLabel,
  IWCompJQueryWidget, IWCompGrids, meIWEdit,MedpIWMultiColumnComboBox, Vcl.Menus;

type
  TWA011FEntiLocaliBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  private
    procedure cmbProvChange(Sender: TObject;Index: Integer);
    procedure cmbRegChange(Sender: TObject;Index: Integer);
  public
    { Public declarations }
    procedure PreparaComponenti(Elenco: String);
  end;

implementation

uses WA011UEntiLocali, WA011UEntiLocaliDM;

{$R *.dfm}
procedure TWA011FEntiLocaliBrowseFM.PreparaComponenti(Elenco: String);
begin
  grdTabella.medpPreparaComponentiDefault;
  if Elenco = 'COMUNI' then
  begin
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('PROVINCIA'),0,DBG_MECMB,'10','2','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('SOPPRESSO'),0,DBG_MECMB,'1','1','null','','S');
  end
  else if Elenco = 'PROVINCE' then
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_REGIONE'),0,DBG_MECMB,'10','2','null','','S')
  else if Elenco = 'REGIONI' then
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FISCALE'),0,DBG_MECMB,'1','1','null','','S');
end;

procedure TWA011FEntiLocaliBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var x:Integer;
begin
  x:=grdTabella.medpClientDataSet.RecNo - 1;

  if TWA011FEntiLocali(Self.Owner).cmbElenco.Text = 'COMUNI' then
  begin
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('PROVINCIA'),0) as TMedpIWMultiColumnComboBox).Items.Clear;
    with TWA011FEntiLocaliDM(WR302DM).A011FEntiLocaliMW do
    begin
      selT481.First;
      while not selT481.Eof do
      begin
        (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('PROVINCIA'),0) as TMedpIWMultiColumnComboBox).AddRow(Format('%s;%s',[selT481.FieldByName('COD_PROVINCIA').AsString,selT481.FieldByName('DESCRIZIONE').AsString]));
        selT481.Next;
      end;
    end;
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('PROVINCIA'),0)as TMedpIWMultiColumnComboBox).PopUpHeight:=20;
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('PROVINCIA'),0)as TMedpIWMultiColumnComboBox).OnChange:=cmbProvChange;
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('SOPPRESSO'),0) as TMedpIWMultiColumnComboBox).Items.Clear;
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('SOPPRESSO'),0) as TMedpIWMultiColumnComboBox).AddRow('N');
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('SOPPRESSO'),0) as TMedpIWMultiColumnComboBox).AddRow('I');
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('SOPPRESSO'),0) as TMedpIWMultiColumnComboBox).AddRow('S');
  end
  else if TWA011FEntiLocali(Self.Owner).cmbElenco.Text = 'PROVINCE' then
  begin
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('COD_REGIONE'),0) as TMedpIWMultiColumnComboBox).Items.Clear;
    with TWA011FEntiLocaliDM(WR302DM).A011FEntiLocaliMW do
    begin
      selT482.First;
      while not selT482.Eof do
      begin
        (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('COD_REGIONE'),0) as TMedpIWMultiColumnComboBox).AddRow(Format('%s;%s',[selT482.FieldByName('COD_REGIONE').AsString,selT482.FieldByName('DESCRIZIONE').AsString]));
        selT482.Next;
      end;
    end;
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('COD_REGIONE'),0) as TMedpIWMultiColumnComboBox ).PopUpHeight:=20;
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('COD_REGIONE'),0) as TMedpIWMultiColumnComboBox).OnChange:=cmbRegChange;
  end
  else if TWA011FEntiLocali(Self.Owner).cmbElenco.Text = 'REGIONI' then
  begin
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('FISCALE'),0) as TMedpIWMultiColumnComboBox).Items.Clear;
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('FISCALE'),0) as TMedpIWMultiColumnComboBox).AddRow('S');
    (grdTabella.medpCompCella(x,grdTabella.medpIndexColonna('FISCALE'),0) as TMedpIWMultiColumnComboBox).AddRow('N');
  end;
end;

procedure TWA011FEntiLocaliBrowseFM.grdTabellaRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  if not TmedpIWdbGrid(acell.Grid).medpRenderCell(acell, arow, acolumn, true, true) then
    Exit;
  if (ARow > 0) then
  begin
    if (TWA011FEntiLocali(Self.Owner).cmbElenco.Text = 'COMUNI') and (grdTabella.DataSource.DataSet.FieldByName('SOPPRESSO').AsString = 'S') then
      ACell.Css:=ACell.Css + ' font_rossoImp';
  end;
end;

procedure TWA011FEntiLocaliBrowseFM.cmbProvChange(Sender: TObject;Index: Integer);
var Row:Integer;
begin
  Row:=grdTabella.medpRigaDiCompGriglia(TmeIWLabel(Sender).FriendlyName);
  with TWA011FEntiLocaliDM(WR302DM) do
  begin
    selTabella.FieldByName('PROVINCIA').Value:=(Sender as TMedpIWMultiColumnComboBox).Items[Index].RowData[0];
    TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_PROVINCIA'),0)).Text:=selTabella.FieldByName('D_PROVINCIA').Value;
    TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_REGIONE'),0)).Text:=selTabella.FieldByName('COD_REGIONE').Value;
    TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_REGIONE'),0)).Text:=selTabella.FieldByName('D_REGIONE').Value;
  end;
end;

procedure TWA011FEntiLocaliBrowseFM.cmbRegChange(Sender: TObject;Index: Integer);
begin
  with TWA011FEntiLocaliDM(WR302DM) do
  begin
    selTabella.FieldByName('COD_REGIONE').Value:=(Sender as TMedpIWMultiColumnComboBox).Items[Index].RowData[0];
    TmeIWLabel(grdTabella.medpCompCella(grdTabella.medpRigaDiCompGriglia(TmeIWLabel(Sender).FriendlyName),grdTabella.medpIndexColonna('D_REGIONE'),0)).Text:=
      selTabella.FieldByName('D_REGIONE').Value;
  end;
end;

end.
