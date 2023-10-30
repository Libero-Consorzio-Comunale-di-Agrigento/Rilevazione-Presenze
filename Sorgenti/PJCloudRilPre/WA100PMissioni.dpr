program WA100PMissioni;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  L021Call in '..\Copy\L021Call.pas',
  WA100ULogin in 'WA100ULogin.pas' {WA100FLogin: TIWAppForm},
  WA100UMissioniDM in 'WA100UMissioniDM.pas' {WA100FMissioniDM: TIWUserSessionBase},
  WA100UMissioniBrowseFM in 'WA100UMissioniBrowseFM.pas' {WA100FMissioniBrowseFM: TFrame},
  WA100UMissioniDettFM in 'WA100UMissioniDettFM.pas' {WA100FMissioniDettFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A100UMissioniMW in '..\MWRilPre\A100UMissioniMW.pas' {A100FMissioniMW: TDataModule},
  WA100UDistanzeChilometricheFM in 'WA100UDistanzeChilometricheFM.pas' {WA100FDistanzeChilometricheFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA100UIndennitaKMFM in 'WA100UIndennitaKMFM.pas' {WA100FIndennitaKMFM: TFrame},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WA100UMissioni in 'WA100UMissioni.pas' {WA100FMissioni: TIWAppForm},
  WA100URimborsiFM in 'WA100URimborsiFM.pas' {WA100FRimborsiFM: TFrame},
  WA100UDettaglioImportiFM in 'WA100UDettaglioImportiFM.pas' {WA100FDettaglioImportiFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WA100UDettaglioGGFM in 'WA100UDettaglioGGFM.pas' {WA100FDettaglioGGFM: TFrame},
  WC020UInputDataOreFM in '..\Copy\WC020UInputDataOreFM.pas' {WC020FInputDataOreFM: TFrame},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame},
  WC502UMenuRilPreFM in '..\Copy\WC502UMenuRilPreFM.pas' {WC502FMenuRilPreFM: TFrame},
  A100UImpRimborsiIterMW in '..\MWRilPre\A100UImpRimborsiIterMW.pas' {A100FImpRimborsiIterMW: TDataModule},
  WA100UAllegatiFM in 'WA100UAllegatiFM.pas' {WA100FAllegatiFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
