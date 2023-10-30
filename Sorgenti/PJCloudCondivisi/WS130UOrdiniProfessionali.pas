unit WS130UOrdiniProfessionali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, OracleData, IWCompEdit, meIWEdit;

type
  TWS130FOrdiniProfessionali = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses WS130UOrdiniProfessionaliDM, WS130UOrdiniProfessionaliBrowseFM;

{$R *.dfm}

procedure TWS130FOrdiniProfessionali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWS130FOrdiniProfessionaliDM.Create(Self);
  WBrowseFM:=TWS130FOrdiniProfessionaliBrowseFM.Create(Self);
  CreaTabDefault;
end;

function TWS130FOrdiniProfessionali.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('COD_ORDINE',GetParam('COD_ORDINE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

end.
