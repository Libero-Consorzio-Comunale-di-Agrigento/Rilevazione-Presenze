unit WA038UVociVariabiliLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink,WA038UVociVariabili, IWApplication;

type
  TWA038FVociVariabiliLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;

implementation

{$R *.dfm}

{ TWA038FVociVariabiliLogin }

procedure TWA038FVociVariabiliLogin.LanciaMainForm;
begin
  inherited;
  with TWA038FVociVariabili.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA038FVociVariabiliLogin.SetAsMainForm;
end.
