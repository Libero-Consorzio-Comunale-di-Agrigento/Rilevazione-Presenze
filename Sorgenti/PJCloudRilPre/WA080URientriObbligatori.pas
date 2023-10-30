unit WA080URientriObbligatori;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,WR102UGestTabella, ActnList, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl,
  IWCompLabel, meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl,IWHTMLControls, meIWLink,
  WA080URientriObbligatoriDM, WA080URientriObbligatoriBrowseFM, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, System.Actions;

type
  TWA080FRientriObbligatori = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TWA080FRientriObbligatori.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA080FRientriObbligatoriDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=False;
  WBrowseFM:=TWA080FRientriObbligatoriBrowseFM.Create(Self);
  AttivaGestioneStoricizzazione;
end;

end.
