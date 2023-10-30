unit WA190ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, WA190ULimitiEccedenzaRes, meIWImageFile,
  IWApplication;

type
  TWA190FLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;


implementation

{$R *.dfm}

{ TWA190FLogin }

procedure TWA190FLogin.LanciaMainForm;
begin
  with TWA190FLimitiEccedenzaRes.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
  TWA190FLogin.SetAsMainForm;

end.
