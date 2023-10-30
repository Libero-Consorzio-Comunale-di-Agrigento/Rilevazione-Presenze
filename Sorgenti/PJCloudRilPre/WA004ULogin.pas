unit WA004ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWApplication;

type
  TWA004FLogin = class(TWR101FLogin)
    procedure IWAppFormRender(Sender: TObject);
  private
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA004UGiustifAssPres;

{$R *.dfm}

procedure TWA004FLogin.IWAppFormRender(Sender: TObject);
begin
  inherited;
  // debug
  if DebugHook <> 0 then
  begin
    edtUtente.Text:='SYSMAN';
    edtPassword.Text:='LEADER';
  end;
end;

procedure TWA004FLogin.LanciaMainForm;
begin
  with TWA004FGiustifAssPres.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
  TWA004FLogin.SetAsMainForm;

end.
