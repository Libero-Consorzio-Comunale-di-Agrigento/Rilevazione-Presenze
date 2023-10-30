unit WA056UTurnazIndBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, meIWEdit, meIWImageFile,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, meIWComboBox,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, WC015USelEditGridFM,
  Vcl.Menus;

type
  TWA056FTurnazIndBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    WC015: TWC015FSelEditGridFM;
    procedure PopolaSNComboBox(CmbBox: TmeIWComboBox);
    procedure imgPartenzaClick(Sender: TObject);
    procedure PartenzaSelezionato(Sender: TObject; Result: Boolean);
  public
    { Public declarations }
  end;

implementation

uses WA056UTurnazIndDM;

{$R *.dfm}

procedure TWA056FTurnazIndBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('PARTENZA'),1,DBG_IMG,'','PUNTINI','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('PIANIF_DA_CALENDARIO'),0,DBG_CMB,'5','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('VERIFICA_TURNI'),0,DBG_CMB,'5','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('VERIFICA_RIPOSI'),0,DBG_CMB,'5','','','','S');
end;

procedure TWA056FTurnazIndBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA056FTurnazIndDM).SelTabella do
  begin
   FieldByName('PARTENZA').AsString:=TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('PARTENZA'),0)).Text;
   FieldByName('PIANIF_DA_CALENDARIO').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PIANIF_DA_CALENDARIO'),0) as TmeIWComboBox).Text);
   FieldByName('VERIFICA_TURNI').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VERIFICA_TURNI'),0) as TmeIWComboBox).Text);
   FieldByName('VERIFICA_RIPOSI').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VERIFICA_RIPOSI'),0) as TmeIWComboBox).Text);
 end;
end;

procedure TWA056FTurnazIndBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PARTENZA'),1)).OnClick:=imgPartenzaClick;
  //Carico combo
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PIANIF_DA_CALENDARIO'),0) as TmeIWComboBox) do
  begin
    PopolaSNComboBox((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PIANIF_DA_CALENDARIO'),0) as TmeIWComboBox));
    ItemIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PIANIF_DA_CALENDARIO'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row, 'PIANIF_DA_CALENDARIO'));
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VERIFICA_TURNI'),0) as TmeIWComboBox) do
  begin
    PopolaSNComboBox((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VERIFICA_TURNI'),0) as TmeIWComboBox));
    ItemIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VERIFICA_TURNI'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row, 'VERIFICA_TURNI'));
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VERIFICA_RIPOSI'),0) as TmeIWComboBox) do
  begin
    PopolaSNComboBox((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VERIFICA_RIPOSI'),0) as TmeIWComboBox));
    ItemIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VERIFICA_RIPOSI'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row, 'VERIFICA_RIPOSI'));
  end;
end;

procedure TWA056FTurnazIndBrowseFM.imgPartenzaClick(Sender: TObject);
begin
  (WR302DM as TWA056FTurnazIndDM).CaricaCdsSviluppoTurnaz;
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  WC015.ResultEvent:=PartenzaSelezionato;
  WC015.ConfermaAutomatica:=True;
  WC015.Visualizza('Scelta punto di partenza turnazione ' + grdTabella.medpClientDataSet.FieldByName('TURNAZIONE').AsString,
    (WR302DM as TWA056FTurnazIndDM).cdsSviluppoTurnaz,False,False,True);
end;

procedure TWA056FTurnazIndBrowseFM.PartenzaSelezionato(Sender: TObject; Result: Boolean);
begin
  if Result then
    TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('PARTENZA'),0)).Text:=(WR302DM as TWA056FTurnazIndDM).cdsSviluppoTurnaz.FieldByName('NUM_GIORNO').AsString;
end;

procedure TWA056FTurnazIndBrowseFM.PopolaSNComboBox(CmbBox: TmeIWComboBox);
begin
  with CmbBox do
  begin
    RequireSelection:=True;
    NoSelectionText:=' ';
    Items.Clear;
    Items.Add('S');
    Items.Add('N');
  end;
end;

end.
