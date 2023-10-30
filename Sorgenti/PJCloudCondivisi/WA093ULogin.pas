unit WA093ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, msxmldom, XMLDoc, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, IWCompEdit, IWGrids, IWCompLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, IWApplication,
  WR101ULogin, meIWComboBox, meIWEdit, meIWGrid, meIWLabel, meIWLink,
  medpIWStatusBar, ActnList, xmldom, XMLIntf, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton;

type
  TWA093FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

implementation

uses WA093UOperazioni;

{$R *.dfm}

procedure TWA093FLogin.LanciaMainForm;
begin
  with TWA093FOperazioni.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA093FLogin.SetAsMainForm;

end.
