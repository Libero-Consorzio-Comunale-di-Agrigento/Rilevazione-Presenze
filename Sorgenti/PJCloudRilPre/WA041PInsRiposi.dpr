program WA041PInsRiposi;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas',
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA041ULogin in 'WA041ULogin.pas' {WA041FLogin: TIWAppForm},
  WA041UInsRiposi in 'WA041UInsRiposi.pas' {WA041FInsRiposi: TIWAppForm},
  L021Call in '..\Copy\L021Call.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A041UInsRiposiMW in '..\MWRilPre\A041UInsRiposiMW.pas' {A041FInsRiposiMW: TDataModule},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WA041UInsRiposiDM in 'WA041UInsRiposiDM.pas' {WA041FInsRiposiDM: TIWUserSessionBase},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas',
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
