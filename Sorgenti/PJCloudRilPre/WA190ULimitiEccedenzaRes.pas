unit WA190ULimitiEccedenzaRes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR103UGestMasterDetail, ActnList, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA190ULimitiEccedenzaResDM, WA190ULimitiEccedenzaResBrowseFM,
  WA190ULimitiEccedenzaResMesiFM, A000UInterfaccia, System.Actions, meIWImageFile;

type
  TWA190FLimitiEccedenzaRes = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TWA190FLimitiEccedenzaRes.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA190FLimitiEccedenzaResMesiFM;
begin
  inherited;
  if Parametri.A094_Raggr = 'N' then
    SolaLettura:=True;

  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA190FLimitiEccedenzaResDM.Create(Self);
  WBrowseFM:=TWA190FLimitiEccedenzaResBrowseFM.Create(Self);

  Detail:=TWA190FLimitiEccedenzaResMesiFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio((WR302DM as TWA190FLimitiEccedenzaResDM).A094FSkLimitiStraordMW.selT811,TWA190FLimitiEccedenzaResDM(WR302DM).A094FSkLimitiStraordMW.dsrT811);

  CreaTabDefault;
end;

end.
