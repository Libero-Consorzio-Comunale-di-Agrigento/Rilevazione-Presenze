unit WS746ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR101ULogin, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWApplication;

type
  TWS746FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

implementation

uses WS746UStatiAvanzamento;

{$R *.dfm}
procedure TWS746FLogin.LanciaMainForm;
begin
  with TWS746FStatiAvanzamento.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWS746FLogin.SetAsMainForm;

end.
