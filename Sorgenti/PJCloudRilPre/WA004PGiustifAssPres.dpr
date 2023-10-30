program WA004PGiustifAssPres;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA004ULogin in 'WA004ULogin.pas' {WA004FLogin: TIWAppForm},
  WA004UGiustifAssPres in 'WA004UGiustifAssPres.pas' {WA004FGiustifAssPres: TIWAppForm},
  L021Call in '..\Copy\L021Call.pas',
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WC502UMenuRilPreFM in '..\Copy\WC502UMenuRilPreFM.pas' {WC502FMenuRilPreFM: TFrame},
  WA004URecapitoVisFiscaliFM in 'WA004URecapitoVisFiscaliFM.pas' {WA004FRecapitoVisFiscaliFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A004UGiustifAssPresMW in '..\MWRilPre\A004UGiustifAssPresMW.pas' {A004FGiustifAssPresMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  R600 in '..\MWRilPre\R600.pas' {R600DtM1: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
