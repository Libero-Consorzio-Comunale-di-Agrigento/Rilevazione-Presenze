unit WS740URegoleValutazioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  IWCompEdit, meIWEdit;

type
  TWS740FRegoleValutazioni = class(TWR102FGestTabella)
  procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function InizializzaAccesso: Boolean; override;
  end;

implementation

uses WS740URegoleValutazioniDM, WS740URegoleValutazioniBrowseFM, WS740URegoleValutazioniDettFM;

{$R *.dfm}

procedure TWS740FRegoleValutazioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWS740FRegoleValutazioniDM.Create(Self);
  WR100LinkWC700:=False;
  AttivaGestioneC700;
  WBrowseFM:=TWS740FRegoleValutazioniBrowseFM.Create(Self);
  WDettaglioFM:=TWS740FRegoleValutazioniDettFM.Create(Self);
  CreaTabDefault;
end;

function TWS740FRegoleValutazioni.InizializzaAccesso: Boolean;
begin
  (WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.GetPeriodoCorrente;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;

  Result:=True;
end;

end.
