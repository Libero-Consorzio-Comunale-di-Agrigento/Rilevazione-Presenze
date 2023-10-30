unit WA055UTurnazioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions, OracleData,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompEdit, meIWEdit;

type
  TWA055FTurnazioni = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function InizializzaAccesso:Boolean; override;
  end;


implementation

uses WA055UTurnazioniDM, WA055UTurnazioniBrowseFM, WA055UMoltTurnazioneFM;

{$R *.dfm}

procedure TWA055FTurnazioni.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA055FMoltTurnazioneFM;
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA055FTurnazioniDM.Create(Self);
  WBrowseFM:=TWA055FTurnazioniBrowseFM.Create(Self);
  WBrowseFM.grdTabella.medpPaginazione:=True;
  WBrowseFM.grdTabella.medpRighePagina:=10;

  Detail:=TWA055FMoltTurnazioneFM.Create(Self);
  AggiungiDetail(Detail);

  (WR302DM as TWA055FTurnazioniDM).A055MW.Q641.ReadOnly:=False;
  Detail.CaricaDettaglio((WR302DM as TWA055FTurnazioniDM).A055MW.Q641,(WR302DM as TWA055FTurnazioniDM).A055MW.D641);
  CreaTabDefault;
end;

function TWA055FTurnazioni.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

end.
