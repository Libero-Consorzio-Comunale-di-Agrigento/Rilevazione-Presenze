unit WA016ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  IWApplication, Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox,
  IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, meIWImageFile;

type
  TWA016FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA016UCausAssenze;

{$R *.dfm}

procedure TWA016FLogin.LanciaMainForm;
begin
  with TWA016FCausAssenze.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA016FLogin.SetAsMainForm;

end.
