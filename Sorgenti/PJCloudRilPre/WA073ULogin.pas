unit WA073ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, meIWImageFile;

type
  TWA073FLogin = class(TWR101FLogin)
  private
    procedure LanciaMainForm;override;
  public
    { Public declarations }
  end;

implementation

uses WA073UAcquistoBuoni;

{$R *.dfm}

procedure TWA073FLogin.LanciaMainForm;
begin
  inherited;
  with TWA073FAcquistoBuoni.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
    Show;
  end;
end;

initialization
   TWA073FLogin.SetAsMainForm;

end.
