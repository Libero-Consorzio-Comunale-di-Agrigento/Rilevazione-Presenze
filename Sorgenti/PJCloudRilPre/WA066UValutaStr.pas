unit WA066UValutaStr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink;

type
  TWA066FValutaStr = class(TWR102FGestTabella)
  procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



implementation

uses WA066UValutaStrDM, WA066UValutaStrBrowseFM; //, WA066UValutaStrDettFM;

{$R *.dfm}

procedure TWA066FValutaStr.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA066FValutaStrDM.Create(Self);
  WBrowseFM:=TWA066FValutaStrBrowseFM.Create(Self);
  //WDettaglioFM:=TWA066FValutaStrDettFM.Create(Self);

  CreaTabDefault;
end;

end.
