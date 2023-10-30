program WA145PComunicazioneVisiteFiscali;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WA145ULogin in 'WA145ULogin.pas' {WA145FLogin: TIWAppForm},
  WA145UComVisiteFiscaliDM in 'WA145UComVisiteFiscaliDM.pas' {WA145FComVisiteFiscaliDM: TIWUserSessionBase},
  WA145UComVisiteFiscali in 'WA145UComVisiteFiscali.pas' {WA145FComVisiteFiscali: TIWAppForm},
  L021Call in '..\Copy\L021Call.pas',
  A145UComVisiteFiscaliMW in '..\MWRilPre\A145UComVisiteFiscaliMW.pas' {A145FComVisiteFiscaliMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WA145UDettaglioAssenzeFM in 'WA145UDettaglioAssenzeFM.pas' {WA145FDettaglioAssenzeFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
