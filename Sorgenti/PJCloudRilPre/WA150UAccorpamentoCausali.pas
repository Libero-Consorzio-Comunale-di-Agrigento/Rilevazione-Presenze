unit WA150UAccorpamentoCausali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB, OracleData,
  Dialogs, WR103UGestMasterDetail, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, WA150UCausaliFM, Oracle, System.Actions, IWCompEdit, meIWEdit;

type
  TWA150FAccorpamentoCausali = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    procedure RefreshPage; override;
  public
    WA150CausaliFM: TWA150FCausaliFM;
    function InizializzaAccesso:Boolean; override;
  end;


implementation

uses WA150UAccorpamentoCausaliBrowseFM, WA150UAccorpamentoCausaliDM;

{$R *.dfm}

function TWA150FAccorpamentoCausali.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('COD_TIPOACCORPCAUSALI',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA150FAccorpamentoCausali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;

  WR302DM:=TWA150FAccorpamentoCausaliDM.Create(Self);
  WBrowseFM:=TWA150FAccorpamentoCausaliBrowseFM.Create(Self);
  WA150CausaliFM:=TWA150FCausaliFM.Create(Self);

  AggiungiDetail(WA150CausaliFM);
  WA150CausaliFM.CaricaDettaglio(TWA150FAccorpamentoCausaliDM(WR302DM).selT256,TWA150FAccorpamentoCausaliDM(WR302DM).dsrT256);
  WA150CausaliFM.PreparaComponenti;
  AggiornaDetails;
  WA150CausaliFM.AggiornaGridAccorpCausali;
end;

procedure TWA150FAccorpamentoCausali.RefreshPage;
begin
  inherited;
  if WA150CausaliFM.grdTabella.medpDataSet.State = dsBrowse then
    WA150CausaliFM.AggiornaGridAccorpCausali;
end;

end.
