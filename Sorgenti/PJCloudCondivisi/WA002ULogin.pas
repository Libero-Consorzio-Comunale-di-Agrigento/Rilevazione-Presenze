unit WA002ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, ActnList,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox,
  IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink,WA002UAnagrafe, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton,
  meIWButton, IWApplication, meIWImageFile;

type
  TWA002FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

var
  WA002FLogin: TWA002FLogin;

implementation

{$R *.dfm}

{ TWA002FLogin }

procedure TWA002FLogin.LanciaMainForm;
begin

  with TWA002FAnagrafe.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA002FLogin.SetAsMainForm;
end.
