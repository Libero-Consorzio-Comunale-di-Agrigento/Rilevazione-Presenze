unit WA123UPartecipazioniSindacati;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA123UVisualizzazioneFM;

type
  TWA123FPartecipazioniSindacati = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA123UPartecipazioniSindacatiDM, WA123UPartecipazioniSindacatiBrowseFM;

{$R *.dfm}

procedure TWA123FPartecipazioniSindacati.IWAppFormCreate(Sender: TObject);
var WA123Visualizzazione: TWA123FVisualizzazioneFM;
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA123FPartecipazioniSindacatiDM.Create(Self);
  AttivaGestioneC700;
  WBrowseFM:=TWA123FPartecipazioniSindacatiBrowseFM.Create(Self);
  (WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW.selAnagrafe:=grdC700.selAnagrafe;

  CreaTabDefault;
  WA123Visualizzazione:=TWA123FVisualizzazioneFM.Create(Self);
  grdTabControl.AggiungiTab('Visualizza',WA123Visualizzazione);
  grdTabControl.ActiveTab:=WBrowseFM;
end;

end.
