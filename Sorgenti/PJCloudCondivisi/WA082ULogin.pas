unit WA082ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, ActnList,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox,
  IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, IWApplication;

type
  TWA082FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;


implementation uses WA082UCdcPercent;

{$R *.dfm}

{ TWA082FLogin }

procedure TWA082FLogin.LanciaMainForm;
begin
  inherited;
  with TWA082FCdcPercent.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
 TWA082FLogin.setAsMainForm;
end.
