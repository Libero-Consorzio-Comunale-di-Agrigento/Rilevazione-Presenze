unit WA173ULogin;

interface

uses WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWApplication;

type
  TWA173FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA173UImportAssestamento;

{$R *.dfm}

procedure TWA173FLogin.LanciaMainForm;
begin
  with TWA173FImportAssestamento.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA173FLogin.SetAsMainForm;

end.
