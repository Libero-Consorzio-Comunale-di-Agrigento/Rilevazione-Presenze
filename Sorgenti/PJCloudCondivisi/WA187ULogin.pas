unit WA187ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, IWJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, IWCompEdit, IWGrids, IWCompLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  WR101ULogin, meIWComboBox, meIWEdit, meIWGrid, meIWLabel, meIWLink,
  medpIWStatusBar, ActnList, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, meIWImageFile;

type
  TWA187FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

implementation

uses WA187UAccessi;

{$R *.dfm}

procedure TWA187FLogin.LanciaMainForm;
begin
  with TWA187FAccessi.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA187FLogin.SetAsMainForm;

end.
