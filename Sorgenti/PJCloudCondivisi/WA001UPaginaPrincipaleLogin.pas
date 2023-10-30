unit WA001UPaginaPrincipaleLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, (*Graphics,*) Controls,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, ActnList,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWApplication,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox,
  IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWCompExtCtrls, meIWImageFile,
  IWCompJQueryWidget, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompButton, meIWButton;

type
  TWA001FPaginaPrincipaleLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

implementation uses WA001UPaginaPrincipale;

{$R *.dfm}
{ TWA001FPaginaPrincipaleLogin }

procedure TWA001FPaginaPrincipaleLogin.LanciaMainForm;
begin
  inherited;
  with TWA001FPaginaPrincipale.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA001FPaginaPrincipaleLogin.SetAsMainForm;
end.
