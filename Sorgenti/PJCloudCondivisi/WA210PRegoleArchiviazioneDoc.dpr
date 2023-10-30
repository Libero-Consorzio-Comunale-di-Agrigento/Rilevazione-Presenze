program WA210PRegoleArchiviazioneDoc;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A210URegoleArchiviazioneDocMW in '..\MWCondivisi\A210URegoleArchiviazioneDocMW.pas' {A210FRegoleArchiviazioneDocMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA210ULogin in 'WA210ULogin.pas' {WA210FLogin: TIWAppForm},
  WA210URegoleArchiviazioneDocDM in 'WA210URegoleArchiviazioneDocDM.pas' {WA210FRegoleArchiviazioneDocDM: TIWUserSessionBase},
  WA210URegoleArchiviazioneDoc in 'WA210URegoleArchiviazioneDoc.pas' {WA210FRegoleArchiviazioneDoc: TIWAppForm},
  WA210URegoleArchiviazioneDocBrowseFM in 'WA210URegoleArchiviazioneDocBrowseFM.pas' {WA210FRegoleArchiviazioneDocBrowseFM: TFrame},
  WA210URegoleArchiviazioneDocDettFM in 'WA210URegoleArchiviazioneDocDettFM.pas' {WA210FRegoleArchiviazioneDocDettFM: TFrame},
  L021Call in '..\Copy\L021Call.pas';

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
