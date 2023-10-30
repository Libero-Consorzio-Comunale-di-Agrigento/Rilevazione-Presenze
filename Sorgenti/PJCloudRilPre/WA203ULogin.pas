unit WA203ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, IWApplication,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR101ULogin, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids,
  meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA203FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

implementation

uses WA203UDatiMensiliPersonalizzati;

{$R *.dfm}

{ TWA203FLogin }

procedure TWA203FLogin.LanciaMainForm;
begin
  with TWA203FDatiMensiliPersonalizzati.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA203FLogin.SetAsMainForm;



end.
