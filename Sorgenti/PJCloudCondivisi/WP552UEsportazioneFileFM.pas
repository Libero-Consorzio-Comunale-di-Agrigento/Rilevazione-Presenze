unit WP552UEsportazioneFileFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  WP552UDettaglioEsportazioneFileFM, A000UInterfaccia, WR100UBase,
  C180FunzioniGenerali;

type
  TWP552FEsportazioneFileFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TWP552FEsportazioneFileFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpEditMultiplo:=False;
  grdTabella.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
end;

procedure TWP552FEsportazioneFileFM.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'');
end;

procedure TWP552FEsportazioneFileFM.actConfermaExecute(Sender: TObject);
begin
  inherited;
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'');
end;

procedure TWP552FEsportazioneFileFM.actModificaExecute(Sender: TObject);
var
  WP552FDettaglioEsportazioneFileFM: TWP552FDettaglioEsportazioneFileFM;
begin
  inherited;
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpClearCompGriglia;
  WP552FDettaglioEsportazioneFileFM:=TWP552FDettaglioEsportazioneFileFM.Create(Self.Parent);
  WP552FDettaglioEsportazioneFileFM.Visualizza;
end;

procedure TWP552FEsportazioneFileFM.actNuovoExecute(Sender: TObject);
var
  WP552FDettaglioEsportazioneFileFM: TWP552FDettaglioEsportazioneFileFM;
begin
  inherited;
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpClearCompGriglia;
  WP552FDettaglioEsportazioneFileFM:=TWP552FDettaglioEsportazioneFileFM.Create(Self.Parent);
  WP552FDettaglioEsportazioneFileFM.Visualizza;
end;

end.
