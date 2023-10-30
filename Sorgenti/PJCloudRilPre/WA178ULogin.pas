unit WA178ULogin;

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
  meIWLink, IWApplication;

type
  TWA178FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LanciaMainForm; override;
  end;

  implementation

{$R *.dfm}

uses WA178UPianifPersConv;

{ TWA178FLogin }

procedure TWA178FLogin.LanciaMainForm;
begin
  inherited;
  with TWA178FPianifPersConv.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA178FLogin.SetAsMainForm;

end.
