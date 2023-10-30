unit WA049ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, ActnList, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWApplication,
  IWCompButton, meIWButton, meIWImageFile;

type
  TWA049FLogin = class(TWR101FLogin)
  private
    { Private declarations }
 protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;


implementation

uses WA049UStampaPasti;

{$R *.dfm}


procedure TWA049FLogin.LanciaMainForm;
begin
  with TWA049FStampaPasti.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA049FLogin.SetAsMainForm;

end.
