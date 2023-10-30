unit WA076UIndGruppo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  System.Actions;

type
  TWA076FIndGruppo = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA076UIndGruppoDM, WA076UIndGruppoBrowseFM;

{$R *.dfm}

procedure TWA076FIndGruppo.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA076FIndGruppoDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=False;
  WBrowseFM:=TWA076FIndGruppoBrowseFM.Create(Self);
  AttivaGestioneStoricizzazione;
end;

end.
