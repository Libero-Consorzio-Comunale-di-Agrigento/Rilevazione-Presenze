unit WA040UPianifRepBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, DB,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, StrUtils,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, Math, IWCompEdit,
  meIWEdit, IWCompLabel, meIWLabel, IWCompButton, meIWButton, IWCompCheckbox,
  meIWCheckBox, C190FunzioniGeneraliWeb, A000UInterfaccia, A000USessione,
  medpIWMultiColumnComboBox;

type
  TWA040FPianifRepBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA040UPianifRep, WA040UPianifRepDM;

{$R *.dfm}

procedure TWA040FPianifRepBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPaginazione:=True;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MATRICOLA'),0,DBG_LBL,'8','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOMINATIVO'),0,DBG_LBL,'61','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO1'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO2'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO3'),0,DBG_MECMB,'5','2','null','','S');
  if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,(WR302DM as TWA040FPianifRepDM).A040MW.selDatoLibero) then
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATOLIBERO'),0,DBG_MECMB,'20','2','null','','S');
end;

procedure TWA040FPianifRepBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA'),0)).Css:='input_data_dmy';
  if (WR302DM as TWA040FPianifRepDM).selTabella.State = dsEdit then
  begin
   (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('MATRICOLA'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('MATRICOLA').AsString;
   (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMINATIVO'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('NOMINATIVO').AsString;
  end
  else if (WR302DM as TWA040FPianifRepDM).SelTabella.State = dsInsert then
  begin
   (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('MATRICOLA'),0) as TmeIWLabel).Caption:=(WR302DM as TWA040FPianifRepDM).A040MW.selAnagrafe.FieldByName('MATRICOLA').AsString;
   (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMINATIVO'),0) as TmeIWLabel).Caption:=(WR302DM as TWA040FPianifRepDM).A040MW.selAnagrafe.FieldByName('NOMINATIVO').AsString;
  end;
  //Combo Turno1
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    Text:=ifthen((grdTabella.medpValoreColonna(Row,'TURNO1')<>''),grdTabella.medpValoreColonna(Row,'TURNO1'),'');
    with (WR302DM as TWA040FPianifRepDM).A040MW do
    begin
      Q350.First;
      while not Q350.Eof do
      begin
        AddRow(Q350.FieldByName('CODICE').AsString + ';' + Q350.FieldByName('DESCRIZIONE').AsString);
        Q350.Next;
      end;
    end;
  end;
  //Combo Turno2
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    Text:=ifthen((grdTabella.medpValoreColonna(Row,'TURNO2')<>''),grdTabella.medpValoreColonna(Row,'TURNO2'),'');
    with (WR302DM as TWA040FPianifRepDM).A040MW do
    begin
      Q350.First;
      while not Q350.Eof do
      begin
        AddRow(Q350.FieldByName('CODICE').AsString + ';' + Q350.FieldByName('DESCRIZIONE').AsString);
        Q350.Next;
      end;
    end;
  end;
  //Combo Turno3
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO3'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    Text:=ifthen((grdTabella.medpValoreColonna(Row,'TURNO3')<>''),grdTabella.medpValoreColonna(Row,'TURNO3'),'');
    with (WR302DM as TWA040FPianifRepDM).A040MW.Q350 do
    begin
      First;
      while not Eof do
      begin
        AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
        Next;
      end;
    end;
  end;
  //Edit Priorità
  if (WR302DM as TWA040FPianifRepDM).A040MW.CodTipologia = 'R' then
  begin
    TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PRIORITA1'),0)).Css:='input_num_n width1chr';
    TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PRIORITA2'),0)).Css:='input_num_n width1chr';
    TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PRIORITA3'),0)).Css:='input_num_n width1chr';
  end;
  //Combo DatoLibero
  if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,(WR302DM as TWA040FPianifRepDM).A040MW.selDatoLibero)
      and((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATOLIBERO'),0) as TmedpIWMultiColumnComboBox) <> nil) then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATOLIBERO'),0) as TmedpIWMultiColumnComboBox) do
    begin
      Tag:=Row;
      items.Clear;
      Text:=ifthen((grdTabella.medpValoreColonna(Row,'DATOLIBERO')<>''),grdTabella.medpValoreColonna(Row,'DATOLIBERO'),'');
      with (WR302DM as TWA040FPianifRepDM).A040MW.selDatoLibero do
      begin
        First;
        while not Eof do
        begin
          AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
          Next;
        end;
      end;
    end;
end;

procedure TWA040FPianifRepBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA040FPianifRepDM).SelTabella do
  begin
    FieldByName('TURNO1').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('TURNO2').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('TURNO3').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO3'),0) as TmedpIWMultiColumnComboBox).Text;
    if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,(WR302DM as TWA040FPianifRepDM).A040MW.selDatoLibero) then
      FieldByName('DATOLIBERO').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATOLIBERO'),0) as TmedpIWMultiColumnComboBox).Text;
  end;
end;

end.
