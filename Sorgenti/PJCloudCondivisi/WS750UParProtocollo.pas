unit WS750UParProtocollo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WS750UParProtocolloDM, WS750UParProtocolloBrowseFM, WS750UDatiChiamataFM;

type
  TWS750FParProtocollo = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWS750FParProtocollo.IWAppFormCreate(Sender: TObject);
var Detail:TWS750FDatiChiamataFM;
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.ChiaveReadOnly:=True;

  WR302DM:=TWS750FParProtocolloDM.Create(Self);
  WBrowseFM:=TWS750FParProtocolloBrowseFM.Create(Self);

  Detail:=TWS750FDatiChiamataFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio(TWS750FParProtocolloDM(WR302DM).SG751,TWS750FParProtocolloDM(WR302DM).D751);
  CreaTabDefault;
end;

end.
