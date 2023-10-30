unit WA158UCapitoliRimborso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA158UCapitoliRimborsoDM, WA158UCapitoliRimborsoBrowseFM;

type
  TWA158FCapitoliRimborso = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA158FCapitoliRimborso.InizializzaAccesso:Boolean;
begin
  Result:=True;
end;

procedure TWA158FCapitoliRimborso.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
  WR302DM:=TWA158FCapitoliRimborsoDM.Create(Self);
  WBrowseFM:=TWA158FCapitoliRimborsoBrowseFM.Create(Self);
  CreaTabDefault;
end;

end.
