program WA047PTimbMensa;

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
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WA047ULogin in 'WA047ULogin.pas' {WA047FLogin: TIWAppForm},
  WA047UTimbMensaDM in 'WA047UTimbMensaDM.pas' {WA047FTimbMensaDM: TIWUserSessionBase},
  WA047UTimbMensa in 'WA047UTimbMensa.pas' {WA047FTimbMensa: TIWAppForm},
  A047UTimbMensaMW in '..\MWRilPre\A047UTimbMensaMW.pas' {A047FTimbMensaMW: TDataModule},
  WR104UGestCartellino in '..\Repositary\WR104UGestCartellino.pas' {WR104FGestCartellino: TIWAppForm},
  A000UGestioneTimbraGiustMW in '..\MWRilPre\A000UGestioneTimbraGiustMW.pas' {A000FGestioneTimbraGiustMW: TDataModule},
  WR208UGestTimbFM in '..\Repositary\WR208UGestTimbFM.pas' {WR208FGestTimbFM: TFrame},
  WA047UGestTimbFM in 'WA047UGestTimbFM.pas' {WA047FGestTimbFM: TFrame},
  WA047UAccessoManualeFM in 'WA047UAccessoManualeFM.pas' {WA047FAccessoManualeFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WA047UDialogStampaFM in 'WA047UDialogStampaFM.pas' {WA047FDialogStampaFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
