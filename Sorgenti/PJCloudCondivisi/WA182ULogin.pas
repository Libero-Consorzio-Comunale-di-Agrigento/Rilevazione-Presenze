unit WA182ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, IWJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, IWCompEdit, IWGrids, IWCompLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  WR101ULogin, meIWComboBox, meIWEdit, meIWGrid, meIWLabel, meIWLink,
  medpIWStatusBar, ActnList, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, IWApplication;

type
  TWA182FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;


implementation

uses WA182UPermessi;

{$R *.dfm}

procedure TWA182FLogin.LanciaMainForm;
begin
  with TWA182FPermessi.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA182FLogin.SetAsMainForm;

end.
