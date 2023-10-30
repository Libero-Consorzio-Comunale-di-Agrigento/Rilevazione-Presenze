unit WA158ULogin;

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
  meIWLink, WA158UCapitoliRimborso;

type
  TWA158FLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  IWApplication;

{$R *.dfm}

procedure TWA158FLogin.LanciaMainForm;
begin
  TWA158FCapitoliRimborso.Create(GGetWebApplicationThreadVar).OpenPage;
end;

initialization

  TWA158FLogin.SetAsMainForm;

end.
