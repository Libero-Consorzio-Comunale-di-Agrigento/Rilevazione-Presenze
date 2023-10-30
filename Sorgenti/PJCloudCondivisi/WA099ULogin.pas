unit WA099ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, IWApplication, IWJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, IWCompEdit, IWGrids, IWCompLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  WR101ULogin, meIWComboBox, meIWEdit, meIWGrid, meIWLabel, meIWLink,
  medpIWStatusBar, ActnList, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton,
  IWAdvCheckGroup, meTIWAdvCheckGroup;

type
  TWA099FLogin = class(TWR101FLogin)
    meTIWAdvCheckGroup1: TmeTIWAdvCheckGroup;
  private
    { Private declarations }
  protected
    procedure LanciaMainForm; override;
  public
    { Public declarations }
  end;

implementation

uses WA099UUtilityDB;

{$R *.dfm}

procedure TWA099FLogin.LanciaMainForm;
begin
  with TWA099FUtilityDB.Create(GGetWebApplicationThreadVar) do
    OpenPage;
end;

initialization
  TWA099FLogin.SetAsMainForm;

end.
