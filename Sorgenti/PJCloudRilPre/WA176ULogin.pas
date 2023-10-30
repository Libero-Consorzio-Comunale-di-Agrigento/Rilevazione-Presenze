unit WA176ULogin;

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
  TWA176FLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA176URiepilogoIterAutorizzativi, IWApplication;

{$R *.dfm}

procedure TWA176FLogin.LanciaMainForm;
begin
  with TWA176FRiepilogoIterAutorizzativi.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA176FLogin.SetAsMainForm;

end.
