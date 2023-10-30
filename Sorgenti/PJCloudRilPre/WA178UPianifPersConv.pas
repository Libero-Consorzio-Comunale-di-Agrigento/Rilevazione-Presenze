unit WA178UPianifPersConv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, WA178UIDPianifPersConvFM;

type
  TWA178FPianifPersConv = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
    Detail:TWA178FIDPianifPersConvFM;
    procedure imgNuovaStoricizzazioneClick(Sender: TObject); Override;
  public
    { Public declarations }
    function  InizializzaAccesso:Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  end;

implementation

{$R *.dfm}

uses WA178UPianifPersConvDM, WA178UPianifPersConvBrowseFM, A178UPianifPersConvMW;

{ TWA178FPianifPersConv }

procedure TWA178FPianifPersConv.imgNuovaStoricizzazioneClick(Sender: TObject);
begin
  (WR302DM as TWA178FPianifPersConvDM).A178MW.IDStoricizzato:=WR302DM.selTabella.FieldByName('ID').AsInteger;
  //Pulisco TabelleRelazionate per non far uscire la maschera C009
  SetLength(InterfacciaWR102.TabelleRelazionate,0);
  inherited;
  //Pulisco ID per forzare nuovo Next della sequenza
  WR302DM.selTabella.FieldByName('ID').Clear;
  //Ripristino TabelleRelazionate
  SetLength(InterfacciaWR102.TabelleRelazionate,2);
  InterfacciaWR102.TabelleRelazionate[0]:=(WR302DM as TWA178FPianifPersConvDM).selTabella;
  InterfacciaWR102.TabelleRelazionate[1]:=(WR302DM as TWA178FPianifPersConvDM).selT421;
end;

function TWA178FPianifPersConv.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WBrowseFM.grdTabella.medpAggiornaCDS(False);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA178FPianifPersConv.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.FChiaveReadOnly:=True;
  WR302DM:=TWA178FPianifPersConvDM.Create(Self);
  WBrowseFM:=TWA178FPianifPersConvBrowseFM.Create(Self);

  Detail:=TWA178FIDPianifPersConvFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio((WR302DM as TWA178FPianifPersConvDM).selT421,(WR302DM as TWA178FPianifPersConvDM).dsrT421);

  //  actVisioneCorrenteExecute(nil);
  CreaTabDefault;
  AttivaGestioneC700;
  (WR302DM as TWA178FPianifPersConvDM).A178MW.SelAnagrafe:=grdC700.selAnagrafe;

end;

procedure TWA178FPianifPersConv.WC700CambioProgressivo(Sender: TObject);
begin
  with (WR302DM as TWA178FPianifPersConvDM) do
  begin
    selTabella.Close;
    selTabella.SetVariable('Progressivo',grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger);
    selTabella.Open;
  end;
  inherited;
end;

end.
