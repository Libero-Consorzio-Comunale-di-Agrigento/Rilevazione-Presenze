unit WA048ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA048FLogin = class(TWR101FLogin)
  private
    procedure LanciaMainForm;override;
  public
    { Public declarations }
  end;

implementation

uses WA048UPastiMese;

{$R *.dfm}

procedure TWA048FLogin.LanciaMainForm;
begin
  with TWA048FPastiMese.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
    Show;
  end;
end;

initialization
   TWA048FLogin.SetAsMainForm;

end.
