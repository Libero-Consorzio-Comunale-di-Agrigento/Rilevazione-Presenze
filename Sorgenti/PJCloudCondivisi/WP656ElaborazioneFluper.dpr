program WP656ElaborazioneFluper;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WP656UElaborazioneFluperDM in 'WP656UElaborazioneFluperDM.pas' {WP656FElaborazioneFluperDM: TIWUserSessionBase},
  WP656UElaborazioneFluper in 'WP656UElaborazioneFluper.pas' {WP656FElaborazioneFluper: TIWAppForm},
  WP656ULogin in 'WP656ULogin.pas' {WP656FLogin: TIWAppForm},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P656UElaborazioneFluperMW in '..\MWCondivisi\P656UElaborazioneFluperMW.pas' {P656FElaborazioneFluperMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
