program WA204PModelliCertificazione;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
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
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A204UModelliCertificazioneMW in '..\MWRilPre\A204UModelliCertificazioneMW.pas' {A204FModelliCertificazioneMW: TDataModule},
  WA204UModelliCertificazioneDM in 'WA204UModelliCertificazioneDM.pas' {WA204FModelliCertificazioneDM: TIWUserSessionBase},
  WA204ULogin in 'WA204ULogin.pas' {WA204FLogin: TIWAppForm},
  WA204UModelliCertificazione in 'WA204UModelliCertificazione.pas' {WA204FModelliCertificazione: TIWAppForm},
  WA204UModelliCertificazioneBrowseFM in 'WA204UModelliCertificazioneBrowseFM.pas' {WA204FModelliCertificazioneBrowseFM: TFrame},
  WA204UCategorieCertificazioneDettFM in 'WA204UCategorieCertificazioneDettFM.pas' {WA204FCategorieCertificazioneDettFM: TFrame},
  WA204UDatiCertificazioneDettFM in 'WA204UDatiCertificazioneDettFM.pas' {WA204FDatiCertificazioneDettFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
