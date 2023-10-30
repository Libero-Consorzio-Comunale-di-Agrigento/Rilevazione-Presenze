unit WA171ULogin;

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
  TWA171FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

implementation

uses
  WA171UXMLVisiteFiscali, IWApplication;

{$R *.dfm}

procedure TWA171FLogin.LanciaMainForm;
begin
  with TWA171FXMLVisiteFiscali.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA171FLogin.SetAsMainForm;

end.
