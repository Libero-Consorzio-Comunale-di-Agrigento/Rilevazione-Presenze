unit WA122UIscrizioniSindacati;

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
  TWA122FIscrizioniSindacati = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA122UIscrizioniSindacatiDM, WA122UIscrizioniSindacatiBrowseFM;

{$R *.dfm}

procedure TWA122FIscrizioniSindacati.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA122FIscrizioniSindacatiDM.Create(Self);
  AttivaGestioneC700;

  WBrowseFM:=TWA122FIscrizioniSindacatiBrowseFM.Create(Self);
  (WR302DM as TWA122FIscrizioniSindacatiDM).A122MW.selAnagrafe:=grdC700.selAnagrafe;

  CreaTabDefault;
end;

end.
