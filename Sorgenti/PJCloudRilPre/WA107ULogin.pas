unit WA107ULogin;

interface

uses WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWApplication;

type
  TWA107FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
protected
    procedure LanciaMainForm; override;   end;

implementation

uses WA107UInsAssAutoRegole;

{$R *.dfm}

procedure TWA107FLogin.LanciaMainForm;
begin
  with TWA107FInsAssAutoRegole.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA107FLogin.SetAsMainForm;

end.
