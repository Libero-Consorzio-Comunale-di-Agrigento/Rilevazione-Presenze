unit WA052ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR101ULogin, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, medpIWStatusBar, meIWImageFile, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWApplication;

type
  TWA052FLogin = class(TWR101FLogin)
  private
    function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
      FontType: Integer; Data: Pointer): Integer; stdcall;
  protected
    procedure LanciaMainForm; override;
  end;

implementation
uses WA052UParCar;
{$R *.dfm}

{ TWA052FLogin }


function TWA052FLogin.EnumFontsProc(var LogFont: TLogFont;
  var TextMetric: TTextMetric; FontType: Integer; Data: Pointer): Integer;
begin

end;

procedure TWA052FLogin.LanciaMainForm;
begin
  inherited;
  with TWA052FParCar.Create(GGetWebApplicationThreadVar) do
  begin
    OpenPage;
  end;
end;

initialization
   TWA052FLogin.SetAsMainForm;

end.
