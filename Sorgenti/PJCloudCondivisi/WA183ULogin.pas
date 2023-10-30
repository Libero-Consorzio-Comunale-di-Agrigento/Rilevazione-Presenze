unit WA183ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, IWJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, IWCompEdit, IWGrids, IWCompLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  WR101ULogin, meIWComboBox, meIWEdit, meIWGrid, meIWLabel, meIWLink,
  medpIWStatusBar, ActnList, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, IWApplication,
  meIWImageFile;

type
  TWA183FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

var
  WA183FLogin: TWA183FLogin;

implementation

uses WA183UFiltroAnagrafe;

{$R *.dfm}

procedure TWA183FLogin.LanciaMainForm;
begin
  with TWA183FFiltroAnagrafe.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA183FLogin.SetAsMainForm;

end.
