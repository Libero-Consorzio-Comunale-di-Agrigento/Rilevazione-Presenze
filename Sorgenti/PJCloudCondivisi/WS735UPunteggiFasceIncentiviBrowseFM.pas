unit WS735UPunteggiFasceIncentiviBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, meIWComboBox,
  medpIWMultiColumnComboBox, meIWLabel;

type
  TWS735FPunteggiFasceIncentiviBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    procedure cmbDescrizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
  public
    { Public declarations }
  end;


implementation

uses
  WS735UPunteggiFasceIncentiviDM, WR102UGestTabella, IWApplication;

{$R *.dfm}

procedure TWS735FPunteggiFasceIncentiviBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  cmb: TMedpIWMultiColumnComboBox;
begin
 inherited;
  // Caricamento MultiColumnComboBox
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODQUOTA'),0) <> nil) and
     (not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso) then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODQUOTA'),0)as TMedpIWMultiColumnComboBox) do
    begin
      Items.Clear;
      PopUpHeight:=20;
      LookupColumn:=1;
      //OnChange:=cmbCodiceChange;
      Text:=grdTabella.medpValoreColonna(Row, 'CODQUOTA');
      with (WR302DM as TWS735FPunteggiFasceIncentiviDM).S735FPunteggiFasceIncentiviMW.selT765 do
      begin
        First;
        while not Eof do
        begin
          AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
      end;
      OnAsyncChange:=cmbDescrizioneAsyncChange;
  end;
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FLESSIBILITA'),0) <> nil then
  begin
    cmb:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FLESSIBILITA'),0) as TMedpIWMultiColumnComboBox);
    cmb.Items.Clear;
    cmb.AddRow('S;Flessibile');
    cmb.AddRow('N;Non flessibile');
    cmb.AddRow('*;Entrambi');
  end;
end;

procedure TWS735FPunteggiFasceIncentiviBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODQUOTA'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_CODQUOTA'),0,DBG_LBL,'20','','null','','S');
end;

procedure TWS735FPunteggiFasceIncentiviBrowseFM.cmbDescrizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
var
  r:Integer;
begin
  inherited;
  with (Sender as TMedpIWMultiColumnComboBox) do
  begin
    r:=grdTabella.medpRigaDiCompGriglia(FriendlyName);
    TmeIWLabel(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('D_CODQUOTA'),0)).Caption:=Items[Index].RowData[1];
  end;
end;



end.


