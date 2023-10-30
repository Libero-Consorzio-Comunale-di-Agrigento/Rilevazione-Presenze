program WP684PDefinizioneFondi;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P684UDefinizioneFondiMW in '..\MWCondivisi\P684UDefinizioneFondiMW.pas' {P684FDefinizioneFondiMW: TDataModule},
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
  WP684ULogin in 'WP684ULogin.pas' {WP684FLogin: TIWAppForm},
  WP684UDefinizioneFondiDM in 'WP684UDefinizioneFondiDM.pas' {WP684FDefinizioneFondiDM: TIWUserSessionBase},
  WP684UDefinizioneFondi in 'WP684UDefinizioneFondi.pas' {WP684FDefinizioneFondi: TIWAppForm},
  WP684UDefinizioneFondiBrowseFM in 'WP684UDefinizioneFondiBrowseFM.pas' {WP684FDefinizioneFondiBrowseFM: TFrame},
  WP684UDefinizioneFondiDettFM in 'WP684UDefinizioneFondiDettFM.pas' {WP684FDefinizioneFondiDettFM: TFrame},
  WP684URisorseGenDefinizioneFondiFM in 'WP684URisorseGenDefinizioneFondiFM.pas' {WP684FRisorseGenDefinizioneFondiFM: TFrame},
  WP684UDestGenDefinizioneFondiFM in 'WP684UDestGenDefinizioneFondiFM.pas' {WP684FDestGenDefinizioneFondiFM: TFrame},
  WP684URisorseDettDefinizioneFondiFM in 'WP684URisorseDettDefinizioneFondiFM.pas' {WP684FRisorseDettDefinizioneFondiFM: TFrame},
  WP684UDestDettDefinizioneFondiFM in 'WP684UDestDettDefinizioneFondiFM.pas' {WP684FDestDettDefinizioneFondiFM: TFrame},
  WP684UGrigliaDettDefinizioneFondiDM in 'WP684UGrigliaDettDefinizioneFondiDM.pas' {WP684FGrigliaDettDefinizioneFondiDM: TIWUserSessionBase},
  WP684UGrigliaDettDefinizioneFondi in 'WP684UGrigliaDettDefinizioneFondi.pas' {WP684FGrigliaDettDefinizioneFondi: TIWAppForm},
  WP684UGrigliaDettDefinizioneFondiBrowseFM in 'WP684UGrigliaDettDefinizioneFondiBrowseFM.pas' {WP684FGrigliaDettDefinizioneFondiBrowseFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
