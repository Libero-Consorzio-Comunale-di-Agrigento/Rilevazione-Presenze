unit WS730UPunteggiValutazioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompEdit, meIWEdit;

type
  TWS730FPunteggiValutazioni = class(TWR102FGestTabella)
  procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WS730UPunteggiValutazioniDM, WS730UPunteggiValutazioniBrowseFM, WS730UPunteggiValutazioniDettFM;

{$R *.dfm}

procedure TWS730FPunteggiValutazioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.OttimizzaDecorrenzaFine:=False;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
  InterfacciaWR102.GestioneDecorrenzaFine:=False;
  WR302DM:=TWS730FPunteggiValutazioniDM.Create(Self);
  WBrowseFM:=TWS730FPunteggiValutazioniBrowseFM.Create(Self);
  WDettaglioFM:=TWS730FPunteggiValutazioniDettFM.Create(Self);

  CreaTabDefault;
end;


end.
