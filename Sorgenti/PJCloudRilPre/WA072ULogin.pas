unit WA072ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA072FLogin = class(TWR101FLogin)
  private
    procedure LanciaMainForm;override;
  public
    { Public declarations }
  end;


implementation

uses WA072UBuoniMese;

{$R *.dfm}

procedure TWA072FLogin.LanciaMainForm;
begin
  inherited;
  with TWA072FBuoniMese.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
    Show;
  end;
end;

initialization
   TWA072FLogin.SetAsMainForm;

end.
