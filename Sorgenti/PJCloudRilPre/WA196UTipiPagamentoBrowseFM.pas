unit WA196UTipiPagamentoBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, meIWComboBox,meIWEDit,IWRegion, C190FunzioniGeneraliWeb;

type
  TWA196FTipiPagamentoBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA196FTipiPagamentoBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  Combo: TmeIWComboBox;
  idx: Integer;
begin
  inherited;

  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE'),0) as TmeIWEdit).ReadOnly:=(grdTabella.medpStato = msEdit);

  Combo:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('SOMMA'),0) as TmeIWComboBox);
  Combo.Items.Clear;
  Combo.Items.Add('S');
  Combo.Items.Add('N');
  Combo.NoSelectionText:= ' ';
  Combo.RequireSelection:=True;
  idx:=Combo.Items.IndexOf(grdTabella.medpValoreColonna(Row,'SOMMA'));
  if idx >= 0 then
    Combo.ItemIndex:=idx
  else
    Combo.ItemIndex:=0;
end;

procedure TWA196FTipiPagamentoBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('SOMMA'),0,DBG_CMB,'10','','','','S');

end;

end.
