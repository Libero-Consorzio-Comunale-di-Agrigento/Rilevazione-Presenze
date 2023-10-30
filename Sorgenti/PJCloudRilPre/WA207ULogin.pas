unit WA207ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR101ULogin, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids,
  meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  IWApplication;

type
  TWA207FLogin = class(TWR101FLogin)

  protected
    procedure LanciaMainForm; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses WA207UProfiliStampeRep;

{$R *.dfm}

procedure TWA207FLogin.LanciaMainForm;
begin
  with TWA207FProfiliStampeRep.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA207FLogin.SetAsMainForm;

end.
