program WB007PManipolazioneDati;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  L021Call in '..\Copy\L021Call.pas',
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WB007ULogin in 'WB007ULogin.pas' {WB007FLogin: TIWAppForm},
  WB007UManipolazioneDatiDM in 'WB007UManipolazioneDatiDM.pas' {WB007FManipolazioneDatiDM: TIWUserSessionBase},
  WB007UManipolazioneDati in 'WB007UManipolazioneDati.pas' {WB007FManipolazioneDati: TIWAppForm},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  B007UManipolazioneDatiMW in '..\MWCondivisi\B007UManipolazioneDatiMW.pas' {B007FManipolazioneDatiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WC020UInputDataOreFM in '..\Copy\WC020UInputDataOreFM.pas' {WC020FInputDataOreFM: TFrame},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame},
  WC502UMenuRilPreFM in '..\Copy\WC502UMenuRilPreFM.pas' {WC502FMenuRilPreFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
