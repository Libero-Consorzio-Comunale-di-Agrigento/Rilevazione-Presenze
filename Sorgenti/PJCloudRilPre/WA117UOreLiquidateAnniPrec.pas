unit WA117UOreLiquidateAnniPrec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  WA117UOreLiquidateAnniPrecDM,WA117UOreLiquidateAnniPrecBrowseFM, OracleData,
  A000UInterfaccia ;

type
  TWA117FOreLiquidateAnniPrec = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso: Boolean; override;
  public
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure ImpostaDateWC700; //richiamato da DM
  end;

implementation

{$R *.dfm}

procedure TWA117FOreLiquidateAnniPrec.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA117FOreLiquidateAnniPrecDM.Create(Self);
  AttivaGestioneC700;

  (WR302DM as TWA117FOreLiquidateAnniPrecDM).selAnagrafe:=grdC700.selAnagrafe;
  InterfacciaWR102.DettaglioFM:=False;

  WBrowseFM:=TWA117FOreLiquidateAnniPrecBrowseFM.Create(Self);
  CreaTabDefault;
end;

function TWA117FOreLiquidateAnniPrec.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
begin
  Result:=False;

  //Deve prendere il progressivo selezionato da parametro (passato da WA029)
  //e non il progressivo corrente della WA001
  //Se arriva da menu Progressivo non impostato e quindi posizionamento su progressivo corrente della wa001 (fatto su attivazione wc700)
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  Result:=True;
end;

procedure TWA117FOreLiquidateAnniPrec.WC700CambioProgressivo(Sender: TObject);
var Anno: Integer;
begin
  Anno:=WR302DM.selTabella.FieldByName('ANNO').AsInteger;
  inherited;
  //mi riposiziono sulla stessa data
  //aggiorno griglia
  if WBrowseFM <> nil then
  begin
    if not WR302DM.selTabella.SearchRecord('ANNO',ANNO,[srFromBeginning]) then
      WR302DM.selTabella.First;
    WBrowseFM.grdTabella.medpAggiornaCDS(False);
    AggiornaRecord;
  end;
end;

procedure TWA117FOreLiquidateAnniPrec.ImpostaDateWC700;
begin
  if grdC700 <> nil then
  begin
    if WR302DM.selTabella.FieldByName('ANNO').AsInteger = 0 then
      grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro
    else
      grdC700.WC700FM.C700DataLavoro:=EncodeDate(WR302DM.selTabella.FieldByName('ANNO').AsInteger,1,1);
  end;
end;


end.

