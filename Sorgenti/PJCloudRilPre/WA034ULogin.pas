unit WA034ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, WA034UIntPaghe,WA034UParametriAvanzati,
  IWApplication, meIWImageFile;

type
  TWA034FLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;

implementation

{$R *.dfm}

{ TWA034FLogin }

procedure TWA034FLogin.LanciaMainForm;
begin
  with TWA034FIntPaghe.Create(GGetWebApplicationThreadVar) do
//   with TWA034FParametriAvanzati.Create(GGetWebApplicationThreadVar) do
  begin
//    ImpostaCodiceInterfaccia('<INTERFACCIA UNICA>');
    OpenPage;
  end;
end;

initialization
  TWA034FLogin.SetAsMainForm;
end.
