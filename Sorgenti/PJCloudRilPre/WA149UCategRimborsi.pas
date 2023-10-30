unit WA149UCategRimborsi;

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
  TWA149FCategRimborsi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
    function InizializzaAccesso:Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  WA149UCategRimborsiDM, WA149UCategRimborsiBrowseFM;

{$R *.dfm}

function TWA149FCategRimborsi.InizializzaAccesso:Boolean;
begin
  Result:=True;
end;

procedure TWA149FCategRimborsi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA149FCategRimborsiDM.Create(Self);
  WBrowseFM:=TWA149FCategRimborsiBrowseFM.Create(Self);
  CreaTabDefault;
end;

end.
