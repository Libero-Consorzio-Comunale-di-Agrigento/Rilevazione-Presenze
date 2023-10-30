unit WA203UDatiMensiliPersonalizzati;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, Oracle, System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA203FDatiMensiliPersonalizzati = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function  InizializzaAccesso:Boolean; override;
    procedure AttivaGestioneC700L;
  end;

implementation

uses WA203UDatiMensiliPersonalizzatiDM, WA203UDatiMensiliPersonalizzatiBrowseFM, WA203UDatiMensiliPersonalizzatiDettFM;

{$R *.dfm}


function TWA203FDatiMensiliPersonalizzati.InizializzaAccesso:Boolean;
begin
  //Inizializzazione
  Result:=True;
end;

procedure TWA203FDatiMensiliPersonalizzati.AttivaGestioneC700L;
begin
  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
end;

procedure TWA203FDatiMensiliPersonalizzati.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA203FDatiMensiliPersonalizzatiDM.Create(Self);
  WBrowseFM:=TWA203FDatiMensiliPersonalizzatiBrowseFM.Create(Self);
  WDettaglioFM:=TWA203FDatiMensiliPersonalizzatiDettFM.Create(Self);
  InterfacciaWR102.GestioneDecorrenzaFine:=False;
  {AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;}

   //Apre la pagina sul tab del browse
  //DatiAbilitazioni.AccessoBrowse:='S';

  CreaTabDefault;
end;


end.
