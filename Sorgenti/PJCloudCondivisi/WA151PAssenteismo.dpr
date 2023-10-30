program WA151PAssenteismo;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
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
  A151UAssenteismoMW in '..\MWCondivisi\A151UAssenteismoMW.pas' {A151FAssenteismoMW: TDataModule},
  WA151ULogin in 'WA151ULogin.pas' {WA151FLogin: TIWAppForm},
  WA151UAssenteismoDM in 'WA151UAssenteismoDM.pas' {WA151FAssenteismoDM: TIWUserSessionBase},
  WA151UAssenteismo in 'WA151UAssenteismo.pas' {WA151FAssenteismo: TIWAppForm},
  WA151UAssenteismoBrowseFM in 'WA151UAssenteismoBrowseFM.pas' {WA151FAssenteismoBrowseFM: TFrame},
  WA151UAssenteismoDettFM in 'WA151UAssenteismoDettFM.pas' {WA151FAssenteismoDettFM: TFrame},
  WA151UGrigliaRisultatoFM in 'WA151UGrigliaRisultatoFM.pas' {WA151FGrigliaRisultatoFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
