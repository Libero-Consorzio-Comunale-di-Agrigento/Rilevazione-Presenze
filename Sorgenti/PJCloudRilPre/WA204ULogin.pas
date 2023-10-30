unit WA204ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR101ULogin, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, medpIWStatusBar, meIWImageFile, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWApplication;

type
  TWA204FLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;

implementation
uses WA204UModelliCertificazione;

{$R *.dfm}

procedure TWA204FLogin.LanciaMainForm;
begin
  with TWA204FModelliCertificazione.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
  TWA204FLogin.SetAsMainForm;
end.
