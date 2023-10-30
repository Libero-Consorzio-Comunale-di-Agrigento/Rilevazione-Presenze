unit WA057USpostSquadra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, Oracle, IWCompEdit, meIWEdit;

type
  TWA057FSpostSquadra = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA057USpostSquadraBrowseFM, WA057USpostSquadraDettFM, WA057USpostSquadraDM;

{$R *.dfm}

procedure TWA057FSpostSquadra.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA057FSpostSquadraDM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWA057FSpostSquadraDM).A057MW.SelAnagrafe:=grdC700.selAnagrafe;
  WBrowseFM:=TWA057FSpostSquadraBrowseFM.Create(Self);
  WDettaglioFM:=TWA057FSpostSquadraDettFM.Create(Self);
  CreaTabDefault;
  WC700CambioProgressivo(nil);
end;

end.
