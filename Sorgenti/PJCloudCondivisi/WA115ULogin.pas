unit WA115ULogin;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Winapi.Messages,
  Winapi.Windows,
  Xml.Win.msxmldom,
  Xml.XMLDoc,
  Xml.XMLIntf,
  Xml.xmldom,
  IWApplication,
  IWBaseComponent,
  IWBaseContainerLayout,
  IWBaseControl,
  IWBaseHTML40Component,
  IWBaseHTMLComponent,
  IWBaseHTMLControl,
  IWBaseLayoutComponent,
  IWCompButton,
  IWCompEdit,
  IWCompExtCtrls,
  IWCompGrids,
  IWCompLabel,
  IWCompListbox,
  IWContainerLayout,
  IWControl,
  IWHTMLControls,
  IWTemplateProcessorHTML,
  IWVCLBaseControl,
  IWVCLComponent,
  WR101ULogin,
  meIWButton,
  meIWComboBox,
  meIWEdit,
  meIWGrid,
  meIWLabel,
  meIWLink,
  medpIWStatusBar;

type
  TWA115FLogin = class(TWR101FLogin)
  private
  protected
    procedure LanciaMainForm; override;
  end;

implementation

uses
  WA115UIterAutorizzativi;

{$R *.dfm}

procedure TWA115FLogin.LanciaMainForm;
begin
  with TWA115FIterAutorizzativi.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA115FLogin.SetAsMainForm;

end.
