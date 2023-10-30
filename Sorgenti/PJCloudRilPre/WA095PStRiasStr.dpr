program WA095PStRiasStr;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA095ULogin in 'WA095ULogin.pas' {WA095FLogin: TIWAppForm},
  WA095UStRiasStr in 'WA095UStRiasStr.pas' {WA095FStRiasStr: TIWAppForm},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WA095UStRiasStrDM in 'WA095UStRiasStrDM.pas' {WA095FStRiasStrDM: TIWUserSessionBase},
  L021Call in '..\Copy\L021Call.pas',
  A095UStRiasStrMW in '..\MWRilPre\A095UStRiasStrMW.pas' {A095FStRiasStrMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
