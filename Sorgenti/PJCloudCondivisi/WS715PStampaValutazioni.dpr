program WS715PStampaValutazioni;

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
  WS715ULogin in 'WS715ULogin.pas' {WS715FLogin: TIWAppForm},
  WS715UStampaValutazioni in 'WS715UStampaValutazioni.pas' {WS715FStampaValutazioni: TIWAppForm},
  WS715UStampaValutazioniDM in 'WS715UStampaValutazioniDM.pas' {WS715FStampaValutazioniDM: TIWUserSessionBase},
  L021Call in '..\Copy\L021Call.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S715UStampaValutazioniMW in '..\MWCondivisi\S715UStampaValutazioniMW.pas' {S715FStampaValutazioniMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
