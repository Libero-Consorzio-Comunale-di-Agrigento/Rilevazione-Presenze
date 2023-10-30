unit WA053USquadre;

interface

uses
  Windows, Messages,OracleData, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR103UGestMasterDetail, ActnList, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, Oracle, System.Actions, IWCompEdit, meIWEdit;

type
  TWA053FSquadre = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  end;


implementation

uses WA053USquadreDM, WA053USquadreBrowseFM, WA053USquadreDettFM, WA053USquadreTipiOperatoreFM, WA053USquadreAreeTurniFM;

{$R *.dfm}

function TWA053FSquadre.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA053FSquadre.IWAppFormCreate(Sender: TObject);
var
  Detail_Operatore:TWA053FSquadreTipiOperatoreFM;
  Detail_Area:TWA053FSquadreAreeTurniFM;
begin
  inherited;
  WR302DM:=TWA053FSquadreDM.Create(Self);
  WBrowseFM:=TWA053FSquadreBrowseFM.Create(Self);
  WDettaglioFM:=TWA053FSquadreDettFM.Create(Self);
  // -- Dettaglio Tipi operatore
  Detail_Operatore:=TWA053FSquadreTipiOperatoreFM.Create(Self);
  AggiungiDetail(Detail_Operatore,'Tipi operatore');
  Detail_Operatore.CaricaDettaglio(TWA053FSquadreDM(WR302DM).selT601,TWA053FSquadreDM(WR302DM).dsrT601);
  // -- Dettaglio Aree afferenza
  Detail_Area:=TWA053FSquadreAreeTurniFM.Create(Self);
  AggiungiDetail(Detail_Area,'Aree afferenza');
  Detail_Area.CaricaDettaglio(TWA053FSquadreDM(WR302DM).Q651,TWA053FSquadreDM(WR302DM).D651);
  // --
  CreaTabDefault;
end;

end.
