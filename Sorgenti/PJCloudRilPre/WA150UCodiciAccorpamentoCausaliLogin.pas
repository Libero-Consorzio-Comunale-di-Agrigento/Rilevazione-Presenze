unit WA150UCodiciAccorpamentoCausaliLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  IWApplication;

type
  TWA150FCodiciAccorpamentoCausaliLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA150UCodiciAccorpamentoCausali;

{$R *.dfm}

procedure TWA150FCodiciAccorpamentoCausaliLogin.LanciaMainForm;
begin
  inherited;
  with TWA150FCodiciAccorpamentoCausali.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA150FCodiciAccorpamentoCausaliLogin.SetAsMainForm;

end.
