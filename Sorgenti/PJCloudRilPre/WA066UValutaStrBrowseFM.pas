unit WA066UValutaStrBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, meIWComboBox, A066UValutaStrMW, meIWLabel,
  medpIWMultiColumnComboBox;

type
  TWA066FValutaStrBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA066UValutaStrDM, WR102UGestTabella;

{$R *.dfm}

procedure TWA066FValutaStrBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('LIVELLO'),0,DBG_MECMB,'20','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALE'),0,DBG_MECMB,'20','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MAGGIORAZIONE'),0,DBG_EDT,'input_num_nn','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TARIFFA_LIQ'),0,DBG_EDT,'input_num_nnnnndd','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TARIFFA_MAT'),0,DBG_EDT,'input_num_nnnnndd','2','null','','S');
end;

procedure TWA066FValutaStrBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  cmb: TMedpIWMultiColumnComboBox;
  cmbCau: TMedpIWMultiColumnComboBox;
begin
  inherited;

  cmb:=nil;
  cmbCau:=nil;

  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('LIVELLO'),0)<> nil) and
     (not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso) then
    cmb:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('LIVELLO'),0) as TMedpIWMultiColumnComboBox);

  if cmb <> nil then
  begin
    cmb.items.Clear;
    (WR302DM as TWA066FValutaStrDM).A066FValutaStrMW:=TA066FValutaStrMW.Create(Self);
    (WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selLivello.First;
    while not (WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selLivello.Eof do
    begin
      cmb.AddRow(Format('%s;%s',[(WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selLivello.FieldByName('CODICE').AsString,(WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selLivello.FieldByName('DESCRIZIONE').AsString]));
      (WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selLivello.Next;
    end;
  end;

  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),1)<> nil) and
    (not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso) then
     cmbCau:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),1) as TMedpIWMultiColumnComboBox);

  if cmbCau <> nil then
  begin
    cmbCau.items.Clear;
    (WR302DM as TWA066FValutaStrDM).A066FValutaStrMW:=TA066FValutaStrMW.Create(Self);
    (WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selT275.First;
    while not (WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selT275.Eof do
    begin
      cmbCau.AddRow(Format('%s;%s',[(WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selT275.FieldByName('CODICE').AsString,(WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selT275.FieldByName('DESCRIZIONE').AsString]));
      (WR302DM as TWA066FValutaStrDM).A066FValutaStrMW.selT275.Next;
    end;
  end;
end;

end.
