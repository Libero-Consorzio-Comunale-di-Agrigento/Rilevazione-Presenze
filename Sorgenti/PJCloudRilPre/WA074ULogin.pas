unit WA074ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, ActnList, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel,
  meIWLabel, IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA074FLogin = class(TWR101FLogin)
 protected
    procedure LanciaMainForm; override;
  end;


implementation

uses WA074URiepilogoBuoni;

{$R *.dfm}

procedure TWA074FLogin.LanciaMainForm;
begin
  with TWA074FRiepilogoBuoni.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA074FLogin.SetAsMainForm;

end.
