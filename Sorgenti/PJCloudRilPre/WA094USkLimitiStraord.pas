unit WA094USkLimitiStraord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  WA094USkLimitiStraordDM, WA094USkLimitiStraordBrowseFM, A000UInterfaccia,
  System.Actions;

type
  TWA094FSkLimitiStraord = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  public
    AttivaGridIndAnn:Boolean;
    function  InizializzaAccesso:Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  end;
implementation

{$R *.dfm}

procedure TWA094FSkLimitiStraord.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AttivaGridIndAnn:=(not SolaLettura) and (Parametri.A094_Anno = 'S');
  if Parametri.A094_Mese = 'N' then
    SolaLettura:=True;

  WR302DM:=TWA094FSkLimitiStraordDM.Create(Self);
  AttivaGestioneC700;

  (WR302DM as TWA094FSkLimitiStraordDM).selAnagrafe:=grdC700.selAnagrafe;
  InterfacciaWR102.DettaglioFM:=False;

  WBrowseFM:=TWA094FSkLimitiStraordBrowseFM.Create(Self);
  CreaTabDefault;
end;

function TWA094FSkLimitiStraord.InizializzaAccesso: Boolean;
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

procedure TWA094FSkLimitiStraord.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  //Aggiorno la seconda griglia
  if WBrowseFM <> nil then
  begin
    (WBrowseFM as TWA094FSkLimitiStraordBrowseFM).grdLiqIndAnn.medpAggiornaCDS;
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
    if (WBrowseFM as TWA094FSkLimitiStraordBrowseFM).grdT830.Visible then
      (WBrowseFM as TWA094FSkLimitiStraordBrowseFM).grdT830.medpAggiornaCDS;
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
  end;
end;

end.
