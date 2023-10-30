unit WA161UTipoAbbattimenti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink;

type
  TWA161FTipoAbbattimenti = class(TWR102FGestTabella)
  procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA161UTipoAbbattimentiDM, WA161UTipoAbbattimentiBrowseFM; //, WA161UTipoAbbattimentiDettFM;

{$R *.dfm}

procedure TWA161FTipoAbbattimenti.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA161FTipoAbbattimentiDM.Create(Self);
  WBrowseFM:=TWA161FTipoAbbattimentiBrowseFM.Create(Self);

  CreaTabDefault;
end;
end.
