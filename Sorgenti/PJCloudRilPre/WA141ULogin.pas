unit WA141ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, msxmldom, XMLDoc, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, IWCompEdit, IWGrids, IWCompLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  WR101ULogin, meIWComboBox, meIWEdit, meIWGrid, meIWLabel, meIWLink,
  medpIWStatusBar, ActnList, xmldom, XMLIntf, IWCompGrids, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton,
  meIWButton, IWApplication, meIWImageFile;

type
  TWA141FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

implementation

uses WA141URegoleRiposi;

{$R *.dfm}

procedure TWA141FLogin.LanciaMainForm;
begin
  with TWA141FRegoleRiposi.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA141FLogin.SetAsMainForm;

end.
