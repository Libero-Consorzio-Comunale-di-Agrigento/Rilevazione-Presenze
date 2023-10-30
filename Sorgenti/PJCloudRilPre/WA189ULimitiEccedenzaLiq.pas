unit WA189ULimitiEccedenzaLiq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR103UGestMasterDetail, ActnList, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA189ULimitiEccedenzaLiqDM, WA189ULimitiEccedenzaLiqBrowseFM,
  WA189ULimitiEccedenzaLiqMesiFM, medpIWDBGrid,A000UInterfaccia, System.Actions, meIWImageFile;

type
  TWA189FLimitiEccedenzaLiq = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TWA189FLimitiEccedenzaLiq.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA189FLimitiEccedenzaLiqMesiFM;
begin
  inherited;
  if Parametri.A094_Raggr = 'N' then
    SolaLettura:=True;

  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA189FLimitiEccedenzaLiqDM.Create(Self);
  WBrowseFM:=TWA189FLimitiEccedenzaLiqBrowseFM.Create(Self);

  Detail:=TWA189FLimitiEccedenzaLiqMesiFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio((WR302DM as TWA189FLimitiEccedenzaLiqDM).A094FSkLimitiStraordMW.selT810,TWA189FLimitiEccedenzaLiqDM(WR302DM).A094FSkLimitiStraordMW.dsrT810);

  CreaTabDefault;
end;

end.
