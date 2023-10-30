unit WA096UPianificazioneFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, OracleData, DB, StrUtils,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompGrids, IWVCLBaseControl,
  IWCompListbox, IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, IWCompEdit,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  meIWGrid, medpIWDBGrid, meIWComboBox, medpIWMultiColumnComboBox, meIWEdit, meIWLabel,
  WR203UGestDetailFM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  System.Actions, Vcl.Menus;

type
  TWA096FPianificazioneFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure cmbGiornoChange(Sender: TObject);
    procedure cmbCausaleChange(Sender: TObject; Index: Integer);
  private
    { Private declarations }
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WA096UProfiliLibProfDM;

{$R *.dfm}

procedure TWA096FPianificazioneFM.CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource);
begin
  grdTabella.medpEditMultiplo:=False;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('GIORNO'),0,DBG_CMB,'1','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_GIORNO'),0,DBG_LBL,'10','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALE'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_CAUSALE'),0,DBG_LBL,'40','','null','','S');
end;

procedure TWA096FPianificazioneFM.grdTabellaDataSet2Componenti(Row: Integer);
var i:Integer;
begin
  inherited;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) as TmeIWComboBox) do
  begin
    Tag:=Row;
    Items.Add('');
    for i:=1 to 7 do
      Items.Add(IntToStr(i));
    OnChange:=cmbGiornoChange;
    ItemIndex:=Items.IndexOf(grdTabella.medpDataSet.FieldByName('GIORNO').AsString);
  end;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_GIORNO'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row,'D_GIORNO');
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    Text:=IfThen((grdTabella.medpValoreColonna(Row,'CAUSALE') <> ''),grdTabella.medpValoreColonna(Row,'CAUSALE'),'');
    with (WR302DM as TWA096FProfiliLibProfDM).A096MW do
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
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row,'D_CAUSALE');
end;

procedure TWA096FPianificazioneFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA096FProfiliLibProfDM).Q311 do
  begin
    FieldByName('GIORNO').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) as TmeIWComboBox).Text;
    FieldByName('CAUSALE').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).Text;
  end;
end;

procedure TWA096FPianificazioneFM.cmbGiornoChange(Sender: TObject);
var Row: Integer;
begin
  Row:=(Sender as TmeIWComboBox).Tag;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_GIORNO'),0) as TmeIWLabel).Caption:=R180NomeGiornoSett(StrToIntDef((Sender as TmeIWComboBox).Text,0));
end;

procedure TWA096FPianificazioneFM.cmbCausaleChange(Sender: TObject; Index: Integer);
var Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE'),0) as TmeIWLabel).Caption:=VarToStr((WR302DM as TWA096FProfiliLibProfDM).A096MW.Q275.Lookup('CODICE',(Sender as TmedpIWMultiColumnComboBox).Text,'DESCRIZIONE'));
end;

end.
