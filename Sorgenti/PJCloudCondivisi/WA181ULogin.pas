unit WA181ULogin;

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
  TWA181FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

var
  WA181FLogin: TWA181FLogin;

implementation

uses WA181UAziende;

{$R *.dfm}

procedure TWA181FLogin.LanciaMainForm;
begin
  with TWA181FAziende.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA181FLogin.SetAsMainForm;

end.
