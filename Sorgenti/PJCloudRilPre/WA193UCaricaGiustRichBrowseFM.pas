unit WA193UCaricaGiustRichBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  Dialogs, DB, OracleData, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompExtCtrls,
  meIWImageFile, medpIWImageButton, IWCompEdit, meIWEdit, IWCompLabel,
  meIWLabel, IWCompCheckbox, meIWCheckBox, meIWRadioGroup,
  C190FunzioniGeneraliWeb, Vcl.Menus;

type
  TWA193FCaricaGiustRichBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
    procedure imgInfoRichiestaClick(Sender:TObject);
    procedure imgElaboraClick(Sender: TObject);
  public
  end;

implementation

uses
  WA193UCaricaGiustRich;

{$R *.dfm}

procedure TWA193FCaricaGiustRichBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  // modifica.ini - 17.10.2013
  grdTabella.medpComandiCustom:=True;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ELENCO','Elabora richiesta','','');
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),1,DBG_IMG,'','DETTAGLIO','Info richiesta','','');
  // modifica.fine

  //In seguito alla modifica inserita nella DBGrid ( per avere medpComandiEdit e medpComandiCustom)
  //bisogna richiamare esplicitamente medpCaricaCDS in caso di medpComandiCustom;

  grdTabella.medpCaricaCDS;
end;

procedure TWA193FCaricaGiustRichBrowseFM.imgInfoRichiestaClick(Sender:TObject);
var
  r, ID: Integer;
  LWA193FCaricaGiustRich:TWA193FCaricaGiustRich;
begin
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  ID:=grdTabella.medpValoreColonna(r,'ID').ToInteger;
  LWA193FCaricaGiustRich:=(Owner as TWA193FCaricaGiustRich);
  LWA193FCaricaGiustRich.ApriWC027(ID);
end;

procedure TWA193FCaricaGiustRichBrowseFM.grdTabellaAfterCaricaCDS(
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
      img.OnClick:=imgElaboraClick;
    end;
    if grdTabella.medpCompCella(r,'DBG_COMANDI',1) <> nil then
    begin
      img:=(grdTabella.medpCompCella(r,'DBG_COMANDI',1) as TmeIWImageFile);
      img.OnClick:=imgInfoRichiestaClick;
    end;
  end;
end;

procedure TWA193FCaricaGiustRichBrowseFM.imgElaboraClick(Sender: TObject);
var
  Id: String;
  r: Integer;
begin
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Id:=grdTabella.medpValoreColonna(r,'ID');

  if WR302DM.selTabella.SearchRecord('ID',Id,[srFromBeginning]) then
  begin
    (Self.Owner as TWA193FCaricaGiustRich).Elaborazione(Sender);
  end;
end;

end.
