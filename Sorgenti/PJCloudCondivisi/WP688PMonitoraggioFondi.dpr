program WP688PMonitoraggioFondi;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P688UMonitoraggioFondiMW in '..\MWCondivisi\P688UMonitoraggioFondiMW.pas' {P688FMonitoraggioFondiMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WP688ULogin in 'WP688ULogin.pas' {WP688FLogin: TIWAppForm},
  WP688UMonitoraggioFondiDM in 'WP688UMonitoraggioFondiDM.pas' {WP688FMonitoraggioFondiDM: TIWUserSessionBase},
  WP688UMonitoraggioFondi in 'WP688UMonitoraggioFondi.pas' {WP688FMonitoraggioFondi: TIWAppForm};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
