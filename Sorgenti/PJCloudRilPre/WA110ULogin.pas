unit WA110ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWApplication, WA110UParametriConteggio;

type
  TWA110FLogin = class(TWR101FLogin)
    procedure IWAppFormRender(Sender: TObject);
  protected
    procedure LanciaMainForm; override;
  end;

implementation

{$R *.dfm}
procedure TWA110FLogin.IWAppFormRender(Sender: TObject);
begin
  inherited;
  // debug
  if DebugHook <> 0 then
  begin
    edtUtente.Text:='SYSMAN';
    edtPassword.Text:='LEADER';
  end;
end;

procedure TWA110FLogin.LanciaMainForm;
begin
  with TWA110FParametriConteggio.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA110FLogin.SetAsMainForm;

end.
