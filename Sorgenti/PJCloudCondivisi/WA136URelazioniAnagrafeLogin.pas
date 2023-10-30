unit WA136URelazioniAnagrafeLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR101ULogin, xmldom, XMLIntf, msxmldom, XMLDoc, ActnList,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, meIWComboBox,
  IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink,WA136URelazioniAnagrafe, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton,
  meIWButton, meIWImageFile, IWApplication;

type
  TWA136FRelazioniAnagrafeLogin = class(TWR101FLogin)
  protected
    procedure LanciaMainForm; override;
  end;

implementation

{$R *.dfm}

{ TWA136FRelazioniAnagrafeLogin }

procedure TWA136FRelazioniAnagrafeLogin.LanciaMainForm;
begin
  inherited;
  with TWA136FRelazioniAnagrafe.Create(GGetWebApplicationThreadVar) do
  begin
  (*
    setParam('TABELLA','T430_STORICO');
    setParam('COLONNA','TIPOOPE');
    setParam('DATA','01/01/2012');
   *)
    OpenPage;
  end;
end;

initialization
 TWA136FRelazioniAnagrafeLogin.setAsMainForm;

end.
