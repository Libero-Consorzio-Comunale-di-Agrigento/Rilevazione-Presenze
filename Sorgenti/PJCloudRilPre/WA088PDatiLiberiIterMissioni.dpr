program WA088PDatiLiberiIterMissioni;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  L021Call in '..\Copy\L021Call.pas',
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA088ULogin in 'WA088ULogin.pas' {WA088FLogin: TIWAppForm},
  WA088UDatiLiberiIterMissioniDM in 'WA088UDatiLiberiIterMissioniDM.pas' {WA088FDatiLiberiIterMissioniDM: TIWUserSessionBase},
  WA088UDatiLiberiIterMissioni in 'WA088UDatiLiberiIterMissioni.pas' {WA088FDatiLiberiIterMissioni: TIWAppForm},
  WA088UDatiLiberiIterMissioniBrowseFM in 'WA088UDatiLiberiIterMissioniBrowseFM.pas' {WA088FDatiLiberiIterMissioniBrowseFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A088UDatiLiberiIterMissioniMW in '..\MWRilPre\A088UDatiLiberiIterMissioniMW.pas' {A088FDatiLiberiIterMissioniMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA088UDatiLiberiIterMissioniDettFM in 'WA088UDatiLiberiIterMissioniDettFM.pas' {WA088FDatiLiberiIterMissioniDettFM: TFrame},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
