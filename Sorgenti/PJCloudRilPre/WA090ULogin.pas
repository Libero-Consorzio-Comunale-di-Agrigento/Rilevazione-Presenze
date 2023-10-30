unit WA090ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,IWApplication,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA090FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
 protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA090UAssenzeAnno;

{$R *.dfm}

procedure TWA090FLogin.LanciaMainForm;
begin
  with TWA090FAssenzeAnno.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA090FLogin.SetAsMainForm;

end.
