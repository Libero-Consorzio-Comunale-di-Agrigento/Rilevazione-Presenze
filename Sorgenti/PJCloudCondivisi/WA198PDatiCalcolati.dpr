program WA198PDatiCalcolati;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WA198ULogin in 'WA198ULogin.pas' {WA198FLogin: TIWAppForm},
  WA198UDatiCalcolatiDM in 'WA198UDatiCalcolatiDM.pas' {WA198FDatiCalcolatiDM: TIWUserSessionBase},
  WA198UDatiCalcolati in 'WA198UDatiCalcolati.pas' {WA198FDatiCalcolati: TIWAppForm},
  WA198UDatiCalcolatiBrowseFM in 'WA198UDatiCalcolatiBrowseFM.pas' {WA198FDatiCalcolatiBrowseFM: TFrame},
  WA198UDatiCalcolatiDettFM in 'WA198UDatiCalcolatiDettFM.pas' {WA198FDatiCalcolatiDettFM: TFrame},
  R003UGeneratoreStampeMW in '..\Repositary\R003UGeneratoreStampeMW.pas' {R003FGeneratoreStampeMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
