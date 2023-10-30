program WA091PLiquidPresenze;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA091ULogin in 'WA091ULogin.pas' {WA091FLogin: TIWAppForm},
  WA091ULiquidPresenze in 'WA091ULiquidPresenze.pas' {WA091FLiquidPresenze: TIWAppForm},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WA091ULiquidPresenzeDM in 'WA091ULiquidPresenzeDM.pas' {WA091FLiquidPresenzeDM: TIWUserSessionBase},
  L021Call in '..\Copy\L021Call.pas',
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A091ULiquidPresenzeMW in '..\MWRilPre\A091ULiquidPresenzeMW.pas' {A091FLiquidPresenzeMW: TDataModule},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
