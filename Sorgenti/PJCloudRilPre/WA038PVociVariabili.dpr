program WA038PVociVariabili;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA038UVociVariabiliLogin in 'WA038UVociVariabiliLogin.pas' {WA038FVociVariabiliLogin: TIWAppForm},
  WA038UVociVariabili in 'WA038UVociVariabili.pas' {WA038FVociVariabili: TIWAppForm},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WA038UVociVariabiliDM in 'WA038UVociVariabiliDM.pas' {WA038FVociVariabiliDM: TIWUserSessionBase},
  A038UVociVariabiliMW in '..\MWRilPre\A038UVociVariabiliMW.pas' {A038FVociVariabiliMW: TDataModule},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
