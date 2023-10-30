unit WA029URecuperiMobiliFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel,
  IWCompButton, meIWButton, WR100UBase, R450, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, A029ULiquidazione;

type
  TWA029FRecuperiMobiliFM = class(TWR200FBaseFM)
    lblSaldo: TmeIWLabel;
    lblSaldoAttuale: TmeIWLabel;
    lblCarenze: TmeIWLabel;
    lblEcc: TmeIWLabel;
    grdRecuperiMobili: TmeIWGrid;
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure grdRecuperiMobiliRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  private
    Titolo: String;
  public
    procedure SaldiMobiliCausale(CodiceCausPresenza: String; Data: TDateTime;R450DtM1: TR450DtM1);
    procedure SaldiMobili(Data: TDateTime; R450DtM1: TR450DtM1);
    procedure LiquidazioniAnnue(A029FLiquidazione: TA029FLiquidazione);
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

procedure TWA029FRecuperiMobiliFM.Visualizza;
begin
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,500,310,310, Titolo,'#wa029Recuperi_container',False,True);
end;

procedure TWA029FRecuperiMobiliFM.grdRecuperiMobiliRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not C190RenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;
end;

procedure TWA029FRecuperiMobiliFM.SaldiMobiliCausale(CodiceCausPresenza: String; Data: TDateTime; R450DtM1: TR450DtM1);
var i,r:Integer;
    D:TDateTime;
    PrimaRiga:Boolean;
begin
  Titolo:='Saldi mobili della causale ' + CodiceCausPresenza;
  grdRecuperiMobili.Columncount:=5;
  grdRecuperiMobili.RowCount:=Length(R450DtM1.RiepilogoRecuperiRiepPres) + 1;

  grdRecuperiMobili.Cell[0,0].Text:='Mese';
  grdRecuperiMobili.Cell[0,1].Text:='Ore recuperate';
  grdRecuperiMobili.Cell[0,2].Text:='Compensazione';
  grdRecuperiMobili.Cell[0,3].Text:='Causali assenza';
  grdRecuperiMobili.Cell[0,4].Text:='Liquidazioni';
  r:=0;
  PrimaRiga:=True;
  for i:=0 to High(R450DtM1.RiepilogoRecuperiRiepPres) do
  begin
    if R450DtM1.RiepilogoRecuperiRiepPres[i].Causale = CodiceCausPresenza then
    begin
      if PrimaRiga then
      begin
        D:=R450DtM1.RiepilogoRecuperiRiepPres[i].Data;
        lblSaldo.Caption:=FormatDateTime('mmmm yyyy',D) + ' - ore abbattibili: ' + R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].OreRese);
        lblSaldoAttuale.Caption:=FormatDateTime('mmmm yyyy',Data) + ' - saldo attuale: ' + R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].OreResidue);
        PrimaRiga:=False;
      end
      else
      begin
        D:=R180AddMesi(D,1);
        inc(r);
        grdRecuperiMobili.Cell[r,0].Text:=FormatDateTime('yyyy mmmm',D);
        grdRecuperiMobili.Cell[r,1].Text:=R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].OreRecuperate);
        grdRecuperiMobili.Cell[r,2].Text:=Format('%s(%s)',[R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].CompUsato),R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].Compensabile)]);
        grdRecuperiMobili.Cell[r,3].Text:=Format('%s(%s)',[R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].RecupUsato),R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].Recuperato)]);
        grdRecuperiMobili.Cell[r,4].Text:=Format('%s(%s)',[R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].LiquidUsato),R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].Liquidato)]);
        if R450DtM1.RiepilogoRecuperiRiepPres[i].Data = Data then
          lblCarenze.Caption:=FormatDateTime('mmmm yyyy',Data) + ' - ore non recuperate: ' + R180MinutiOre(R450DtM1.RiepilogoRecuperiRiepPres[i].OrePerse);
      end;
    end;
  end;
end;

procedure TWA029FRecuperiMobiliFM.SaldiMobili(Data: TDateTime; R450DtM1:TR450DtM1);
var i:Integer;
    D:TDateTime;
begin
  Titolo:='Riepilogo saldi mobili';
  D:=R180AddMesi(Data,-R450DtM1.MesiSaldoPrec);
  lblSaldo.Caption:=FormatDateTime('mmmm yyyy',D) + ' - saldo abbattibile: ' + R180MinutiOre(R450DtM1.SaldoMobileAbbattibile);
  lblSaldoAttuale.Caption:=FormatDateTime('mmmm yyyy',Data) + ' - saldo attuale: ' + R180MinutiOre(R450DtM1.SaldoMobileDisponibile);
  lblcarenze.Caption:=FormatDateTime('mmmm yyyy',D) + ' - negativi non recup.: ' + R180MinutiOre(R450DtM1.NegativiNonRecuperati);
  grdRecuperiMobili.ColumnCount:=2;
  grdRecuperiMobili.RowCount:=R450DtM1.MesiSaldoPrec + 1;
  grdRecuperiMobili.Cell[0,0].Width:='30%';
  grdRecuperiMobili.Cell[0,1].Width:='70%';
  grdRecuperiMobili.Cell[0,0].Text:='Mese';
  grdRecuperiMobili.Cell[0,1].Text:='Recupero';
  for i:=0 to R450DtM1.MesiSaldoPrec - 1 do
  begin
    D:=R180AddMesi(D,1);
    grdRecuperiMobili.Cell[i + 1,0].Text:=FormatDateTime('yyyy mmmm',D);
    grdRecuperiMobili.Cell[i + 1,1].Text:=R180MinutiOre(R450DtM1.SaldoMobileRecupero[D]);
  end;
end;

procedure TWA029FRecuperiMobiliFM.LiquidazioniAnnue(A029FLiquidazione: TA029FLiquidazione);
begin
  TWR100FBase(Self.Parent).AddToInitProc('$(''#etichette'').hide();');
  Titolo:='<WA029> Riepilogo liquidazioni da inzio anno';
  lblEcc.Caption:='';
  grdRecuperiMobili.ColumnCount:=2;
  grdRecuperiMobili.RowCount:=5;

  grdRecuperiMobili.Cell[0,0].Text:='Tipologia';
  grdRecuperiMobili.Cell[0,1].Text:='Ore';
  grdRecuperiMobili.Cell[0,0].Width:='70%';
  grdRecuperiMobili.Cell[1,0].Text:='Straordinario liquidato';
  grdRecuperiMobili.Cell[1,1].Text:=R180MinutiOre(A029FLiquidazione.LiqT071Anno);
  grdRecuperiMobili.Cell[2,0].Text:='Causali di presenza liquidate';
  grdRecuperiMobili.Cell[2,1].Text:=R180MinutiOre(A029FLiquidazione.LiqT074Anno);
  grdRecuperiMobili.Cell[3,0].Text:='Banca ore liquidata';
  grdRecuperiMobili.Cell[3,1].Text:=R180MinutiOre(A029FLiquidazione.LiqT070);
  grdRecuperiMobili.Cell[4,0].Text:='Causali di assestamento liquidate';
  grdRecuperiMobili.Cell[4,1].Text:=R180MinutiOre(A029FLiquidazione.AssT071Anno);
end;

procedure TWA029FRecuperiMobiliFM.btnChiudiClick(Sender: TObject);
begin
  ReleaseOggetti;
  Free;
end;

end.
