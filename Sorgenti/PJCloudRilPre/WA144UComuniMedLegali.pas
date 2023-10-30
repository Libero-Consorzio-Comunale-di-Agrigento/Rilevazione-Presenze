unit WA144UComuniMedLegali;

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
  TWA144FComuniMedLegali = class(TWR102FGestTabella)
  procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA144UComuniMedLegaliDM, WA144UComuniMedLegaliBrowseFM, WA144UComuniMedLegaliDettFM;

{$R *.dfm}

procedure TWA144FComuniMedLegali.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  //InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA144FComuniMedLegaliDM.Create(Self);
  WBrowseFM:=TWA144FComuniMedLegaliBrowseFM.Create(Self);
  WDettaglioFM:=TWA144FComuniMedLegaliDettFM.Create(Self);

  CreaTabDefault;
end;

end.
