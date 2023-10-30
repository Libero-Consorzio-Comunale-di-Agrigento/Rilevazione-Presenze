unit WA044UAllineaStoriciLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, WA044UAllineaStorici, meIWImageFile,
  IWApplication;

type
  TWA044FAllineaStoriciLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;

implementation

{$R *.dfm}

{ TWA044FAllineaStoriciLogin }

procedure TWA044FAllineaStoriciLogin.LanciaMainForm;
begin
  with TWA044FAllineaStorici.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA044FAllineaStoriciLogin.SetAsMainForm;

end.
