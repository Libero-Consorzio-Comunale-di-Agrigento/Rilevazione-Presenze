unit WA159ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR101ULogin, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA159UArchiviazioneCartellini;

type
  TWA159FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
      procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

var
  WA159FLogin: TWA159FLogin;

implementation

uses
  IWApplication;

{$R *.dfm}

procedure TWA159FLogin.LanciaMainForm;
begin
  with TWA159FArchiviazioneCartellini.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization;
  TWA159FLogin.SetAsMainForm;

end.
