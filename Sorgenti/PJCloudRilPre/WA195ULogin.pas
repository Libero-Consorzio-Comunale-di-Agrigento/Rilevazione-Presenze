unit WA195ULogin;

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
  meIWLink,WA195UImpRichRimborso, IWApplication;

type
  TWA195FLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;

implementation

{$R *.dfm}

{ TWA195FLogin }

procedure TWA195FLogin.LanciaMainForm;
begin
  with TWA195FImpRichRimborso.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
  TWA195FLogin.SetAsMainForm;
end.
