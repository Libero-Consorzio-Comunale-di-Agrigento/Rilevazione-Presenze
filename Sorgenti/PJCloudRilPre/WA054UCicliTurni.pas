unit WA054UCicliTurni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions, OracleData,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, meIWImageFile;

type
  TWA054FCicliTurni = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA054UCicliTurniDM, WA054UCicliTurniBrowseFM, WA054UCicliGiornalieriFM;

{$R *.dfm}

function TWA054FCicliTurni.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA054FCicliTurni.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA054FCicliGiornalieriFM;
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA054FCicliTurniDM.Create(Self);
  WBrowseFM:=TWA054FCicliTurniBrowseFM.Create(Self);
  WBrowseFM.grdTabella.medpPaginazione:=True;
  WBrowseFM.grdTabella.medpRighePagina:=10;

  Detail:=TWA054FCicliGiornalieriFM.Create(Self);
  AggiungiDetail(Detail);

  (WR302DM as TWA054FCicliTurniDM).A054MW.Q611.ReadOnly:=False;
  Detail.CaricaDettaglio((WR302DM as TWA054FCicliTurniDM).A054MW.Q611,(WR302DM as TWA054FCicliTurniDM).A054MW.D611);
  CreaTabDefault;
end;

end.
