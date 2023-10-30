unit WA052UParCar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, meIWImageFile,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink,
  WA052UParCarDM, WA052UParCarBrowseFM, WA052UParCarDettFM, IWCompEdit,
  meIWEdit;

type
  TWA052FParCar = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
  private
    lstFonts: TStringList;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA052FParCar.actAnnullaExecute(Sender: TObject);
var
  DettaglioFM:TWA052FParCarDettFM;
begin
  DettaglioFM:=(WDettaglioFM as TWA052FParCarDettFM);
  DettaglioFM.AnnullaModificheDettagli;
  inherited;
end;

procedure TWA052FParCar.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA052FParCarDM.Create(Self);
  WBrowseFM:=TWA052FParCarBrowseFM.Create(Self);
  WDettaglioFM:=TWA052FParCarDettFM.Create(Self);

  CreaTabDefault;
end;

end.
