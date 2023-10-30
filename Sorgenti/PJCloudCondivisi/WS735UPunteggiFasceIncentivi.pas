unit WS735UPunteggiFasceIncentivi;

interface

uses
  Winapi.Windows, Winapi.Messages, StrUtils, Math, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompEdit, meIWEdit;

type
  TWS735FPunteggiFasceIncentivi = class(TWR102FGestTabella)
  procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function InizializzaAccesso: Boolean; override;
  end;


implementation

uses WS735UPunteggiFasceIncentiviDM, WS735UPunteggiFasceIncentiviBrowseFM, //, WS735UPunteggiFasceIncentiviDettFM;
     C190FunzioniGeneraliWeb;

{$R *.dfm}

procedure TWS735FPunteggiFasceIncentivi.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.OttimizzaDecorrenzaFine:=False;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
  WR302DM:=TWS735FPunteggiFasceIncentiviDM.Create(Self);
  WBrowseFM:=TWS735FPunteggiFasceIncentiviBrowseFM.Create(Self);

  CreaTabDefault;
end;

function TWS735FPunteggiFasceIncentivi.InizializzaAccesso: Boolean;
var sTipo:String;
begin
  sTipo:=GetParam('Tipo');
  (*I->205
    G->211
    V->353
  *)
  (WR302DM as TWS735FPunteggiFasceIncentiviDM).S735FPunteggiFasceIncentiviMW.Tipo:=sTipo;
  if sTipo = 'I' then
  begin
    Self.Title:='(WS735) Scaglioni part-time incentivi';
    SetTag(205);
    WBrowseFM.grdTabella.Summary:='Scaglioni part-time incentivi';
    WR302DM.selTabella.FieldByName('FLESSIBILITA').Visible:=True;
    WR302DM.selTabella.FieldByName('PUNTEGGIO_DA').DisplayLabel:='Da % PT effettiva';
    WR302DM.selTabella.FieldByName('PUNTEGGIO_A').DisplayLabel:='A % PT effettiva';
    WR302DM.selTabella.FieldByName('PERC').DisplayLabel:='% PT incentivo';
    WBrowseFM.grdTabella.medpPreparaComponenteGenerico('WR102',WBrowseFM.grdTabella.medpIndexColonna('FLESSIBILITA'),0,DBG_MECMB,'10','2','null','','S');
  end;
  if sTipo = 'G' then
  begin
    Self.Title:='(WS735) Scaglioni gg. effettivi incentivi';
    SetTag(211);
    WBrowseFM.grdTabella.Summary:='Scaglioni gg. effettivi incentivi';
    WR302DM.selTabella.FieldByName('FLESSIBILITA').Visible:=False;
    WR302DM.selTabella.FieldByName('PUNTEGGIO_DA').DisplayLabel:='Da % gg. effettivi';
    WR302DM.selTabella.FieldByName('PUNTEGGIO_A').DisplayLabel:='A % gg. effettivi';
    WR302DM.selTabella.FieldByName('PERC').DisplayLabel:='% gg. effettivi';
  end;
  if sTipo = 'V' then
  begin
    Self.Title:='(WS735) Scaglioni valutazioni per incentivi';
    SetTag(353);
    WBrowseFM.grdTabella.Summary:='Scaglioni valutazioni per incentivi';
    WR302DM.selTabella.FieldByName('FLESSIBILITA').Visible:=False;
    WR302DM.selTabella.FieldByName('PUNTEGGIO_DA').DisplayLabel:='Da punteggio';
    WR302DM.selTabella.FieldByName('PUNTEGGIO_A').DisplayLabel:='A punteggio';
    WR302DM.selTabella.FieldByName('PERC').DisplayLabel:='% valut.incentivo';
  end;

  with (WR302DM as TWS735FPunteggiFasceIncentiviDM) do
  begin
    selTabella.Close;
    selTabella.SetVariable('TIPO',sTipo);
    selTabella.Open;
  end;

  WBrowseFM.grdTabella.medpCreaColonne;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

end.
