unit WA101URaggrInterrogazioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA101URaggrInterrogazioniDM, WA101URaggrInterrogazioniBrowseFM,
  WA101URaggrInterrogazioniFM, IWCompEdit, meIWEdit;

type
  TWA101FRaggrInterrogazioni = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA101FRaggrInterrogazioni.InizializzaAccesso:Boolean;
begin
  //Inizializzazione
  //variable:=GetParam('nome parametro');
  Result:=True;
end;

procedure TWA101FRaggrInterrogazioni.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA101FRaggrInterrogazioniFM;
begin
  inherited;
  //Creazione DataModulo
  WR302DM:=TWA101FRaggrInterrogazioniDM.Create(Self);
  WBrowseFM:=TWA101FRaggrInterrogazioniBrowseFM.Create(Self);
  WBrowseFM.grdTabella.Summary:='Elenco dei raggruppamenti';
  InterfacciaWR102.DettaglioFM:=False;
  Detail:=TWA101FRaggrInterrogazioniFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio((WR302DM as TWA101FRaggrInterrogazioniDM).selT006,(WR302DM as TWA101FRaggrInterrogazioniDM).dsrT006);
  CreaTabDefault;
end;

end.
