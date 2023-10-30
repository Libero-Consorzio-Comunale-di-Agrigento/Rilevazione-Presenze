program WP686PCalcoloFondi;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P686UCalcoloFondiMW in '..\MWCondivisi\P686UCalcoloFondiMW.pas' {P686FCalcoloFondiMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WP686ULogin in 'WP686ULogin.pas' {WP686FLogin: TIWAppForm},
  WP686UCalcoloFondiDM in 'WP686UCalcoloFondiDM.pas' {WP686FCalcoloFondiDM: TIWUserSessionBase},
  WP686UCalcoloFondi in 'WP686UCalcoloFondi.pas' {WP686FCalcoloFondi: TIWAppForm};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
