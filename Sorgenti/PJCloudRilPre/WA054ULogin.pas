unit WA054ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR101ULogin, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWApplication,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink;

type
  TWA054FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses WA054UCicliTurni;

{$R *.dfm}

procedure TWA054FLogin.LanciaMainForm;
begin
  with TWA054FCicliTurni.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
   TWA054FLogin.SetAsMainForm;

end.
