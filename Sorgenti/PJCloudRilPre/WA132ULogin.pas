unit WA132ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, meIWImageFile;

type
  TWA132FLogin = class(TWR101FLogin)
  private
    procedure LanciaMainForm;override;
  public
    { Public declarations }
  end;

implementation

uses WA132UMagazzinoBuoniPasto;

{$R *.dfm}

procedure TWA132FLogin.LanciaMainForm;
begin
  inherited;
  with TWA132FMagazzinoBuoniPasto.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
    Show;
  end;
end;

initialization
   TWA132FLogin.SetAsMainForm;

end.
