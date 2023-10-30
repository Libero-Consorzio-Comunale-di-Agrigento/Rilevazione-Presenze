unit WA098UCalendarioOraLegaleSolareBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, meIWComboBox,
  WA098UCalendarioOraLegaleSolareDM;

type
  TWA098FCalendarioOralegaleSolareBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
    procedure meIWComboBoxAsyncChange(Sender: TObject; EventParams: TStringList);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA098FCalendarioOralegaleSolareBrowseFM.grdTabellaDataSet2Componenti(
  Row: Integer);
var
  MyCombo:TmeIWComboBox;
begin
  inherited;
  MyCombo:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TOraDesc'),0) as TmeIWComboBox);
  MyCombo.NoSelectionText:='';
  MyCombo.items.Clear;
  MyCombo.Tag:=Row;
  with (WR302DM as TWA098FCalendarioOralegaleSolareDM) do
  begin
    cDtsT110.First;
    while Not cDtsT110.Eof do
    begin
      MyCombo.Items.Add(cDtsT110.FieldByName('TORA_DESC').AsString);
      cDtsT110.Next;
    end;
    MyCombo.ItemIndex:=MyCombo.items.IndexOf(selTabella.FieldByName('TOraDesc').AsString);
  end;
  MyCombo.OnAsyncChange:=meIWComboBoxAsyncChange;
end;

procedure TWA098FCalendarioOralegaleSolareBrowseFM.IWFrameRegionCreate(
  Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TOradesc'),0,DBG_CMB,'15','2','null','','S');
end;

procedure TWA098FCalendarioOralegaleSolareBrowseFM.meIWComboBoxAsyncChange(
  Sender: TObject; EventParams: TStringList);
var
  Row:integer;
begin
  inherited;
  Row:=(Sender as TmeIWComboBox).Tag;
  grdTabella.medpDataSet.FieldByName('VERSO').AsString:=VarToStr((WR302DM as TWA098FCalendarioOralegaleSolareDM).
  cDtsT110.Lookup('TORA_DESC',(Sender as TmeIWComboBox).Text,'TORA_COD'));
  //TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CODICE'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_CODICE').AsString;
end;

end.
