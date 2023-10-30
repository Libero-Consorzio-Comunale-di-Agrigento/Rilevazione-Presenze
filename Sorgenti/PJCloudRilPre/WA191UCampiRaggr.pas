unit WA191UCampiRaggr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, WA191UCampiRaggrDM,
  WA191UCampiRaggrBrowseFM, A000UInterfaccia, System.Actions, meIWImageFile;

type
  TWA191FCampiRaggr = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TWA191FCampiRaggr.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  if Parametri.A094_Raggr = 'N' then
    SolaLettura:=True;

  WR302DM:=TWA191FCampiRaggrDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=False;
  WBrowseFM:=TWA191FCampiRaggrBrowseFM.Create(Self);
  CreaTabDefault;
end;

end.
