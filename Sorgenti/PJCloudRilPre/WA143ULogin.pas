unit WA143ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, ActnList,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWApplication,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox,
  IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, meIWImageFile;

type
  TWA143FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA143UMedicineLegali;

{$R *.dfm}

procedure TWA143FLogin.LanciaMainForm;
begin
  with TWA143FMedicineLegali.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA143FLogin.SetAsMainForm;
end.
