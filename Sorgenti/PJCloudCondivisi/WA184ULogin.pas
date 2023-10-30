unit WA184ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, IWJQueryWidget, IWVCLComponent, IWApplication,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, IWCompEdit, IWGrids, IWCompLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  WR101ULogin, meIWComboBox, meIWEdit, meIWGrid, meIWLabel, meIWLink,
  medpIWStatusBar, ActnList, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, meIWImageFile;

type
  TWA184FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

var
  WA184FLogin: TWA184FLogin;

implementation

uses WA184UFiltroFunzioni;

{$R *.dfm}

procedure TWA184FLogin.LanciaMainForm;
begin
  with TWA184FFiltroFunzioni.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA184FLogin.SetAsMainForm;

end.
