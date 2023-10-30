unit WA127ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink;

type
  TWA127FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA127UTurniPrestazioniAggiuntive;

{$R *.dfm}

procedure TWA127FLogin.LanciaMainForm;
begin
  with TWA127FTurniPrestazioniAggiuntive.Create(WebApplication) do
    OpenPage;
end;

initialization
   TWA127FLogin.SetAsMainForm;

end.
