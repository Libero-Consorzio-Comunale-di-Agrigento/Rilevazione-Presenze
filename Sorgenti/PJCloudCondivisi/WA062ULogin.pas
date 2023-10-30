unit WA062ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, meIWImageFile, IWApplication;

type
  TWA062FLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA062UQueryServizio;

{$R *.dfm}

procedure TWA062FLogin.LanciaMainForm;
begin
  inherited;
  with TWA062FQueryServizio.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
    Show;
  end;
end;

initialization
   TWA062FLogin.SetAsMainForm;

end.
