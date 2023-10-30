program WA033PStampaAnomalie;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  OracleMonitor,
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA033UStampaAnomalieLogin in 'WA033UStampaAnomalieLogin.pas' {WA033FStampaAnomalieLogin: TIWAppForm},
  WA033UStampaAnomalie in 'WA033UStampaAnomalie.pas' {WA033FStampaAnomalie: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WC013UCheckListFM in '..\Copy\WC013UCheckListFM.pas' {WC013FCheckListFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A033UStampaAnomalieMW in '..\MWRilPre\A033UStampaAnomalieMW.pas' {A033FStampaAnomalieMW: TDataModule},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WA033UStampaAnomalieDM in 'WA033UStampaAnomalieDM.pas' {WA033FStampaAnomalieDM: TIWUserSessionBase},
  L021Call in '..\Copy\L021Call.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
