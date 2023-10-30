unit WA189ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, WA189ULimitiEccedenzaLiq, meIWImageFile,
  IWApplication;

type
  TWA189FLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;

implementation

{$R *.dfm}

{ TWA189FLogin }

procedure TWA189FLogin.LanciaMainForm;
begin
  with TWA189FLimitiEccedenzaLiq.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
  TWA189FLogin.SetAsMainForm;

end.
