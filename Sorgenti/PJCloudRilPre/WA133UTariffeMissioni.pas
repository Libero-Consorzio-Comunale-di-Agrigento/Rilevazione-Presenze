unit WA133UTariffeMissioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA133UTariffeMissioniDM, WA133UTariffeMissioniBrowseFM, WA133UTariffeMissioniDettFM,
  WA133URiduzioniFM;

type
  TWA133FTariffeMissioni = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    Detail: TWA133FRiduzioniFM;
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA133FTariffeMissioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;

  WR302DM:=TWA133FTariffeMissioniDM.Create(Self);
  WBrowseFM:=TWA133FTariffeMissioniBrowseFM.Create(Self);
  WDettaglioFM:=TWA133FTariffeMissioniDettFM.Create(Self);

  Detail:=TWA133FRiduzioniFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio((WR302DM as TWA133FTariffeMissioniDM).A133FTariffeMissioniMW.selM066,(WR302DM as TWA133FTariffeMissioniDM).A133FTariffeMissioniMW.dsrM066);

  CreaTabDefault;
end;

function TWA133FTariffeMissioni.InizializzaAccesso: Boolean;
var Progressivo: Integer;
begin
  Progressivo:=StrToIntDef(getParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    (WR302DM as TWA133FTariffeMissioniDM).A133FTariffeMissioniMW.TrovaCodice(Progressivo);
    WBrowseFM.grdTabella.medpAggiornaCDS(False);
    Detail.AggiornaDettaglio;
  end;
  Result:=True;
end;

end.
