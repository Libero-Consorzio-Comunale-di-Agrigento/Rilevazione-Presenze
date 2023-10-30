unit WC024ULegendaFM;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  WR100UBase;

type
  TWC024FLegendaFM = class(TWR200FBaseFM)
    lblLegendaOrig: TmeIWLabel;
    lblLegendaOrigE: TmeIWLabel;
    lblLegendaOrigU: TmeIWLabel;
    lblLegendaMan: TmeIWLabel;
    lblLegendaManE: TmeIWLabel;
    lblLegendaManU: TmeIWLabel;
    lblLegendaGiust: TmeIWLabel;
    lblLegendaGiustA: TmeIWLabel;
    lblLegendaGiustP: TmeIWLabel;
    lblLegendaGiustG: TmeIWLabel;
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
  public
    procedure Visualizza;
  end;

implementation

uses
  Windows;

{$R *.dfm}

procedure TWC024FLegendaFM.Visualizza;
begin
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,230,135,135, 'Legenda','#wc024legenda_container',False,False);
end;

procedure TWC024FLegendaFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  ReleaseOggetti;
  Free;
end;

end.
