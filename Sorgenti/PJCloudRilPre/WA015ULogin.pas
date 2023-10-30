unit WA015ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWApplication,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink;

type
  TWA015FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;


implementation

uses WA015UPlusOraIndiv;

{$R *.dfm}

procedure TWA015FLogin.LanciaMainForm;
begin
  with TWA015FPlusOraIndiv.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA015FLogin.SetAsMainForm;

end.
