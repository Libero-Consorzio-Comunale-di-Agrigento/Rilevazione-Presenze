unit WA193ULogin;

interface

uses
  IWApplication, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink;

type
  TWA193FLogin = class(TWR101FLogin)
    procedure IWAppFormRender(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

implementation

uses WA193UCaricaGiustRich;

{$R *.dfm}

{ TWA193FLogin }

procedure TWA193FLogin.IWAppFormRender(Sender: TObject);
begin
  inherited;
  // debug
  if DebugHook <> 0 then
  begin
    edtUtente.Text:='SYSMAN';
    edtPassword.Text:='LEADER';
  end;
end;

procedure TWA193FLogin.LanciaMainForm;
begin
  with TWA193FCaricaGiustRich.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA193FLogin.SetAsMainForm;
end.
