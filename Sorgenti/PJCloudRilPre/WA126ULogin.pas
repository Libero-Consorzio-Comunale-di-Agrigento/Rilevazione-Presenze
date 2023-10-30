unit WA126ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, WA126UBloccoRiepiloghi, IWApplication;

type
  TWA126FLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;

implementation

{$R *.dfm}

{ TWA126FBloccoRiepiloghiLogin }

procedure TWA126FLogin.LanciaMainForm;
begin
  inherited;
  with TWA126FBloccoRiepiloghi.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
  TWA126FLogin.SetAsMainForm;
end.
