unit WA111UParMessaggi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, medpIWC700NavigatorBar, WC700USelezioneAnagrafeFM, OracleData;

type
  TWA111FParMessaggi = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
    function InizializzaAccesso: Boolean; override;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
  public
    { Public declarations }
  protected
    procedure RefreshPage; override;
    procedure ImpostazioniWC700; override;
  end;

implementation

uses WA111UParMessaggiDM, WA111UParMessaggiBrowseFM, WA111UParMessaggiDettFM, WA111UTracciatoFM;

{$R *.dfm}

procedure TWA111FParMessaggi.IWAppFormCreate(Sender: TObject);
var Detail:TWA111FTracciatoFM;
begin
  inherited;
  WR302DM:=TWA111FParMessaggiDM.Create(Self);
  WBrowseFM:=TWA111FParMessaggiBrowseFM.Create(Self);
  WBrowseFM.grdTabella.medpPaginazione:=True;
  WBrowseFM.grdTabella.medpRighePagina:=10;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  WDettaglioFM:=TWA111FParMessaggiDettFM.Create(Self);
  DisabilitaFigliInModifica:=False;
  Detail:=TWA111FTracciatoFM.Create(Self);
  AggiungiDetail(Detail);
  (WR302DM as TWA111FParMessaggiDM).A111MW.selT292.ReadOnly:=False;
  Detail.CaricaDettaglio((WR302DM as TWA111FParMessaggiDM).A111MW.selT292,(WR302DM as TWA111FParMessaggiDM).A111MW.dsrT292);
  CreaTabDefault;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);
  //Inizializzazioni non standard:
  grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.SelezioneVuota:=False;
  grdC700.WC700FM.ResultEvent:=ResultWC700;
  //Fine inizializzazioni
  AttivaGestioneC700;

  (WR302DM as TWA111FParMessaggiDM).AfterScroll(nil);
end;

function TWA111FParMessaggi.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA111FParMessaggi.RefreshPage;
begin
  (WR302DM as TWA111FParMessaggiDM).A111MW.selT002.Refresh;
end;

procedure TWA111FParMessaggi.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ',T430TERMINALI,T430PASSENZE';
  grdC700.Visible:=False;
end;

procedure TWA111FParMessaggi.ResultWC700(Sender: TObject; Result: Boolean);
begin
  (WR302DM as TWA111FParMessaggiDM).A111MW.selT003.Refresh;
end;

end.
