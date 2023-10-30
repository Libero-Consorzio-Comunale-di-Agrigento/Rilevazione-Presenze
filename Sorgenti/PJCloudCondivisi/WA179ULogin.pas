unit WA179ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR101ULogin, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, medpIWStatusBar,
  IWCompEdit, meIWEdit, IWCompGrids, meIWGrid, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink;

type
  TWA179FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses
  WA179UProfiliIterAut, IWApplication;

{$R *.dfm}

procedure TWA179FLogin.LanciaMainForm;
begin
  with TWA179FProfiliIterAut.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA179FLogin.SetAsMainForm;

end.
