unit WA168UIncentiviMaturatiBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  meIWComboBox, medpIWMultiColumnComboBox, meIWLabel, C190FunzioniGeneraliWeb,
  C180FunzioniGenerali, A168UIncentiviMaturatiMW;

type
  TWA168FIncentiviMaturatiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    procedure cmbDescrizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
    procedure cmbDescrizioneImportoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
    procedure cmbDescrizioneMeseAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
  public
    A168FIncentiviMaturatiMW: TA168FIncentiviMaturatiMW;
  end;

implementation

uses WA168UIncentiviMaturatiDM, WR102UGestTabella, IWApplication;

{$R *.dfm}

procedure TWA168FIncentiviMaturatiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODTIPOQUOTA'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Desc_Quota'),0,DBG_LBL,'20','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Tipologia_Quota'),0,DBG_LBL,'2','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPOIMPORTO'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Desc_Importo'),0,DBG_LBL,'10','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MESE'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Desc_Mese'),0,DBG_LBL,'10','','null','','S');
end;

procedure TWA168FIncentiviMaturatiBrowseFM.grdTabellaDataSet2Componenti(
  Row: Integer);
var
  cmb: TmeIWComboBox;
  i: Integer;
begin
 inherited;
  //Caricamento MultiColumnComboBox
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODTIPOQUOTA'),0) <> nil) and
     (not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso) then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODTIPOQUOTA'),0) as TMedpIWMultiColumnComboBox) do
    begin
      Items.Clear;
      PopUpHeight:=20;
      LookupColumn:=1;
      ColCount:=3;
      Text:=grdTabella.medpValoreColonna(Row, 'CODTIPOQUOTA');
      with (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.selT765 do
      begin
        First;
        while not Eof do
        begin
          AddRow(Format('%s;%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString,FieldByName('TIPOQUOTA').AsString]));
          Next;
        end;
      end;
      OnAsyncChange:=cmbDescrizioneAsyncChange;
    end;

    if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPOIMPORTO'),0) <> nil) and
     (not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso) then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPOIMPORTO'),0)as TMedpIWMultiColumnComboBox) do
    begin
      Items.Clear;
      PopUpHeight:=20;
      LookupColumn:=1;
      Text:=grdTabella.medpValoreColonna(Row, 'TIPOIMPORTO');
      AddRow(Format('%s;%s',['1','Quota intera']));
      AddRow(Format('%s;%s',['2','Quota proporzionata']));
      AddRow(Format('%s;%s',['3','Quota netta']));
      AddRow(Format('%s;%s',['4','Quota netta + risparmio']));
      AddRow(Format('%s;%s',['5','Quota quantitativa']));
      OnAsyncChange:=cmbDescrizioneImportoAsyncChange;
    end;

    if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('MESE'),0) <> nil) and
     (not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso) then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('MESE'),0)as TMedpIWMultiColumnComboBox) do
    begin
      Items.Clear;
      PopUpHeight:=20;
      LookupColumn:=1;
      Text:=grdTabella.medpValoreColonna(Row, 'MESE');
      for i:=Low(FormatSettings.LongMonthNames) to High(FormatSettings.LongMonthNames) do
        AddRow(Format('%d;%s',[i,R180Capitalize(FormatSettings.LongMonthNames[i])]));
      OnAsyncChange:=cmbDescrizioneMeseAsyncChange;
    end;
end;

procedure TWA168FIncentiviMaturatiBrowseFM.cmbDescrizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
var
  r:Integer;
begin
  inherited;
  with (Sender as TMedpIWMultiColumnComboBox) do
  begin
    r:=grdTabella.medpRigaDiCompGriglia(FriendlyName);
    TmeIWLabel(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('Desc_Quota'),0)).Caption:=Items[Index].RowData[1];
    TmeIWLabel(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('Tipologia_Quota'),0)).Caption:=Items[Index].RowData[2];
  end;
end;

procedure TWA168FIncentiviMaturatiBrowseFM.cmbDescrizioneImportoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
var
  r:Integer;
begin
  inherited;
  with (Sender as TMedpIWMultiColumnComboBox) do
  begin
    r:=grdTabella.medpRigaDiCompGriglia(FriendlyName);
    TmeIWLabel(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('Desc_Importo'),0)).Caption:=Items[Index].RowData[1];
  end;
end;

procedure TWA168FIncentiviMaturatiBrowseFM.cmbDescrizioneMeseAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
var
  r:Integer;
begin
  inherited;
  with (Sender as TMedpIWMultiColumnComboBox) do
  begin
    r:=grdTabella.medpRigaDiCompGriglia(FriendlyName);
    TmeIWLabel(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('Desc_Mese'),0)).Caption:=Items[Index].RowData[1];
  end;
end;

end.
