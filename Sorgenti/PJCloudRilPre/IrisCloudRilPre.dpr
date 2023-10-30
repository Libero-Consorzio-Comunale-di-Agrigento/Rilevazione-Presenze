program IrisCloudRilPre;

uses
  Forms,
  IWStart,
  OracleMonitor,
  Midaslib,
  UTF8ContentParser,
  IwJclDebug, // Per logging
  IwJclStackTrace,  // Per logging
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  A000USessione in '..\Copy\A000USessione.pas',
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WC700USelezioneAnagrafeFM in '..\Copy\WC700USelezioneAnagrafeFM.pas' {WC700FSelezioneAnagrafeFM: TFrame},
  WC700USelezioneAnagrafeDM in '..\Copy\WC700USelezioneAnagrafeDM.pas' {WC700FSelezioneAnagrafeDM: TIWUserSessionBase},
  A000UIrisWebDM in '..\Copy\A000UIrisWebDM.pas' {A000FIrisWebDM: TDataModule},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WC004UEstrazioneDatiFM in '..\Copy\WC004UEstrazioneDatiFM.pas' {WC004FEstrazioneDatiFM: TFrame},
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA001UPaginaPrincipaleLogin in '..\PJCloudCondivisi\WA001UPaginaPrincipaleLogin.pas' {WA001FPaginaPrincipaleLogin: TIWAppForm},
  IWRtlFix,
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame},
  WC502UMenuRilPreFM in '..\Copy\WC502UMenuRilPreFM.pas' {WC502FMenuRilPreFM: TFrame},
  WC019UProgressBarFM in '..\Copy\WC019UProgressBarFM.pas' {WC019FProgressBarFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  L021Call in '..\Copy\L021Call.pas',
  WC000UServerAdmin in '..\Copy\WC000UServerAdmin.pas',
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  WC012UVisualizzaFileFM in '..\Copy\WC012UVisualizzaFileFM.pas' {WC012FVisualizzaFileFM: TFrame},
  WC023UCambioPasswordFM in '..\Copy\WC023UCambioPasswordFM.pas' {WC023FCambioPasswordFM: TFrame},
  WR104UGestCartellino in '..\Repositary\WR104UGestCartellino.pas' {WR104FGestCartellino: TIWAppForm},
  WR208UGestTimbFM in '..\Repositary\WR208UGestTimbFM.pas' {WR208FGestTimbFM: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
