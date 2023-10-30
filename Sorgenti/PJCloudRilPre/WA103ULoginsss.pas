unit WA103ULoginsss;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA103FLogin = class(TWR100FBase)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA103UScaricoGiust;

{$R *.dfm}

procedure TWA103FLogin.LanciaMainForm;
begin
  inherited;
  with TWA103FScaricoGiust.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA103FLogin.SetAsMainForm;

end.
