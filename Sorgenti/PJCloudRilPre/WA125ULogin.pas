unit WA125ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA125FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;


implementation

uses WA125UBadgeServizio;

{$R *.dfm}

procedure TWA125FLogin.LanciaMainForm;
begin
  with TWA125FBadgeServizio.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA125FLogin.SetAsMainForm;

end.
