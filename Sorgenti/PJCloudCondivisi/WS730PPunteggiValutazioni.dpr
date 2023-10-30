program WS730PPunteggiValutazioni;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S730UPunteggiValutazioniMW in '..\MWCondivisi\S730UPunteggiValutazioniMW.pas' {S730FPunteggiValutazioniMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WS730ULogin in 'WS730ULogin.pas' {WS730FLogin: TIWAppForm},
  WS730UPunteggiValutazioniDM in 'WS730UPunteggiValutazioniDM.pas' {WS730FPunteggiValutazioniDM: TIWUserSessionBase},
  WS730UPunteggiValutazioni in 'WS730UPunteggiValutazioni.pas' {WS730FPunteggiValutazioni: TIWAppForm},
  WS730UPunteggiValutazioniBrowseFM in 'WS730UPunteggiValutazioniBrowseFM.pas' {WS730FPunteggiValutazioniBrowseFM: TFrame},
  WS730UPunteggiValutazioniDettFM in 'WS730UPunteggiValutazioniDettFM.pas' {WS730FPunteggiValutazioniDettFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
