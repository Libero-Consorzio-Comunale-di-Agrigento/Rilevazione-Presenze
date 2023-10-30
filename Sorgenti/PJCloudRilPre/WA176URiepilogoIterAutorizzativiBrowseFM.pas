unit WA176URiepilogoIterAutorizzativiBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, WA176URiepilogoIterAutorizzativi;

type
  TWA176FRiepilogoIterAutorizzativiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  C190FunzioniGeneraliWeb, meIWImageFile, OracleData,
  WA176URiepilogoIterAutorizzativiDM, WR102UGestTabella;

{$R *.dfm}

procedure TWA176FRiepilogoIterAutorizzativiBrowseFM.grdTabellaAfterCaricaCDS(
  Sender: TObject; DBG_ROWID: string);
var
  img: TmeIWImageFile;
  r: Integer;
begin
  inherited;
  for r:=0 to High(grdTabella.medpCompGriglia) do
  begin
    if grdTabella.medpCompCella(r,'DBG_COMANDI',0) <> nil then
    begin
      img:=(grdTabella.medpCompCella(r,'DBG_COMANDI',0) as TmeIWImageFile);
      img.OnClick:=(Parent as TWA176FRiepilogoIterAutorizzativi).imgElaboraClick;
    end;
    if grdTabella.medpCompCella(r,'DBG_COMANDI',1) <> nil then
    begin
      img:=(grdTabella.medpCompCella(r,'DBG_COMANDI',1) as TmeIWImageFile);
      img.OnClick:=(Parent as TWA176FRiepilogoIterAutorizzativi).imgGestioneRichiestaClick;
    end;
  end;
end;

procedure TWA176FRiepilogoIterAutorizzativiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  grdTabella.medpComandiCustom:=True;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ELENCO','Info richiesta','','');
  grdTabella.medpCaricaCDS;
end;

end.
