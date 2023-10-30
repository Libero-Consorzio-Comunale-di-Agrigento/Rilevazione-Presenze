unit WA123ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR101ULogin, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, IWBaseComponent, IWBaseHTMLComponent, IWApplication,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink;

type
  TWA123FLogin = class(TWR101FLogin)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
      procedure LanciaMainForm; override;
  end;

implementation

uses WA123UPartecipazioniSindacati;

{$R *.dfm}

procedure TWA123FLogin.LanciaMainForm;
begin
  with TWA123FPartecipazioniSindacati.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA123FLogin.SetAsMainForm;

end.
