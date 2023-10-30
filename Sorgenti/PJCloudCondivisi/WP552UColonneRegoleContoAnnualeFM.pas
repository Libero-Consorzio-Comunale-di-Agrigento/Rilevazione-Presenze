unit WP552UColonneRegoleContoAnnualeFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  WP552UDettaglioRegoleContoAnnFM, P552URegoleContoAnnualeMW, A000UInterfaccia,
  WR100UBase, C180FunzioniGenerali;

type
  TWP552FColonneRegoleContoAnnualeFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWP552FColonneRegoleContoAnnualeFM.IWFrameRegionCreate(
  Sender: TObject);
begin
  inherited;
  grdTabella.medpEditMultiplo:=False;
  grdTabella.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
end;

procedure TWP552FColonneRegoleContoAnnualeFM.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'');
end;

procedure TWP552FColonneRegoleContoAnnualeFM.actConfermaExecute(
  Sender: TObject);
begin
  inherited;
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'');
end;

procedure TWP552FColonneRegoleContoAnnualeFM.actModificaExecute(
  Sender: TObject);
var
  WP552FDettaglioRegoleContoAnnFM: TWP552FDettaglioRegoleContoAnnFM;
begin
  inherited;
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpClearCompGriglia;
  WP552FDettaglioRegoleContoAnnFM:=TWP552FDettaglioRegoleContoAnnFM.Create(Self.Parent);
  WP552FDettaglioRegoleContoAnnFM.Visualizza('Dettaglio colonne',TIPO_ELAB_COLONNA);
end;

procedure TWP552FColonneRegoleContoAnnualeFM.actNuovoExecute(Sender: TObject);
var
  WP552FDettaglioRegoleContoAnnFM: TWP552FDettaglioRegoleContoAnnFM;
begin
  inherited;
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpClearCompGriglia;
  WP552FDettaglioRegoleContoAnnFM:=TWP552FDettaglioRegoleContoAnnFM.Create(Self.Parent);
  WP552FDettaglioRegoleContoAnnFM.Visualizza('Dettaglio colonne',TIPO_ELAB_COLONNA);
end;

end.
