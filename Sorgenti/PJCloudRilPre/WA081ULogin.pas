unit WA081ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA081FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
 protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA081UTimbCaus;

{$R *.dfm}

procedure TWA081FLogin.LanciaMainForm;
begin
  with TWA081FTimbCaus.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA081FLogin.SetAsMainForm;

end.
