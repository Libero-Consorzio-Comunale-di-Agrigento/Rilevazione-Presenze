unit WA125UBadgeServizio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA125FBadgeServizio = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses WA125UBadgeServizioDM, WA125UBadgeServizioBrowseFM;

{$R *.dfm}

procedure TWA125FBadgeServizio.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=True;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA125FBadgeServizioDM.Create(Self);
  AttivaGestioneC700;
  WBrowseFM:= TWA125FBadgeServizioBrowseFM.Create(Self);
end;

end.
