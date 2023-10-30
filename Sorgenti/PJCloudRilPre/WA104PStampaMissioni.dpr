program WA104PStampaMissioni;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  L021Call in '..\Copy\L021Call.pas',
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WA104ULogin in 'WA104ULogin.pas' {WA104FLogin: TIWAppForm},
  WA104UStampaMissioniDM in 'WA104UStampaMissioniDM.pas' {WA104FStampaMissioniDM: TIWUserSessionBase},
  WA104UStampaMissioni in 'WA104UStampaMissioni.pas' {WA104FStampaMissioni: TIWAppForm};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
