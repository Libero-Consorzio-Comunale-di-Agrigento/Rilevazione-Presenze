unit WA157UCapitoliTrasferte;

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
  TWA157FCapitoliTrasferte = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses
  WA157UCapitoliTrasferteDM, WA157UCapitoliTrasferteBrowseFM;

{$R *.dfm}

function TWA157FCapitoliTrasferte.InizializzaAccesso:Boolean;
begin
  Result:=True;
end;

procedure TWA157FCapitoliTrasferte.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA157FCapitoliTrasferteDM.Create(Self);
  WBrowseFM:=TWA157FCapitoliTrasferteBrowseFM.Create(Self);
  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
  CreaTabDefault;
end;

end.
