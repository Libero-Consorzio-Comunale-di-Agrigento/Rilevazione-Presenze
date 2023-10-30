program WA077PGeneratoreStampe;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  OracleMonitor,
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA077ULogin in 'WA077ULogin.pas' {WA077FLogin: TIWAppForm},
  WA077UGeneratoreStampeBrowseFM in 'WA077UGeneratoreStampeBrowseFM.pas' {WA077FGeneratoreStampeBrowseFM: TFrame},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR003UGeneratoreStampe in '..\Repositary\WR003UGeneratoreStampe.pas' {WR003FGeneratoreStampe: TIWAppForm},
  WA077UGeneratoreStampe in 'WA077UGeneratoreStampe.pas' {WA077FGeneratoreStampe: TIWAppForm},
  WR003UGeneratoreStampeDM in '..\Repositary\WR003UGeneratoreStampeDM.pas' {WR003FGeneratoreStampeDM: TIWUserSessionBase},
  WA077UGeneratoreStampeDM in 'WA077UGeneratoreStampeDM.pas' {WA077FGeneratoreStampeDM: TIWUserSessionBase},
  WR003UGeneratoreStampeDettFM in '..\Repositary\WR003UGeneratoreStampeDettFM.pas' {WR003FGeneratoreStampeDettFM: TFrame},
  WA077UGeneratoreStampeDettFM in 'WA077UGeneratoreStampeDettFM.pas' {WA077FGeneratoreStampeDettFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR003UFormatoFM in '..\Repositary\WR003UFormatoFM.pas' {WR003FFormatoFM: TFrame},
  WR003UProprietaDatiFM in '..\Repositary\WR003UProprietaDatiFM.pas' {WR003FProprietaDatiFM: TFrame},
  R003UGeneratoreStampeMW in '..\Repositary\R003UGeneratoreStampeMW.pas' {R003FGeneratoreStampeMW: TDataModule},
  A077UGeneratoreStampeMW in '..\MWRilPre\A077UGeneratoreStampeMW.pas' {A077FGeneratoreStampeMW: TDataModule},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas',
  WC502UMenuRilPreFM in '..\Copy\WC502UMenuRilPreFM.pas',
  WC025UUploadFile in '..\Copy\WC025UUploadFile.pas' {WC025FUploadFileFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
