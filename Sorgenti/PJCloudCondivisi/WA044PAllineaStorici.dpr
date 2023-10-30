program WA044PAllineaStorici;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA044UAllineaStoriciLogin in 'WA044UAllineaStoriciLogin.pas' {WA044FAllineaStoriciLogin: TIWAppForm},
  WA044UAllineaStorici in 'WA044UAllineaStorici.pas' {WA044FAllineaStorici: TIWAppForm},
  A044UAllineaStoriciMW in '..\MWRilPre\A044UAllineaStoriciMW.pas' {A044FAllineaStoriciMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WA044UAllineaStoriciDM in 'WA044UAllineaStoriciDM.pas' {WA044FAllineaStoriciDM: TIWUserSessionBase};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
