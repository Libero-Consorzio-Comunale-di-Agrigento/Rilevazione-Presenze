program WA203PDatiMensiliPersonalizzati;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A203UDatiMensiliPersonalizzatiMW in '..\MWRilPre\A203UDatiMensiliPersonalizzatiMW.pas' {A203FDatiMensiliPersonalizzatiMW: TDataModule},
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
  WA203ULogin in 'WA203ULogin.pas' {WA203FLogin: TIWAppForm},
  WA203UDatiMensiliPersonalizzatiDM in 'WA203UDatiMensiliPersonalizzatiDM.pas' {WA203FDatiMensiliPersonalizzatiDM: TIWUserSessionBase},
  WA203UDatiMensiliPersonalizzati in 'WA203UDatiMensiliPersonalizzati.pas' {WA203FDatiMensiliPersonalizzati: TIWAppForm},
  WA203UDatiMensiliPersonalizzatiBrowseFM in 'WA203UDatiMensiliPersonalizzatiBrowseFM.pas' {WA203FDatiMensiliPersonalizzatiBrowseFM: TFrame},
  WA203UDatiMensiliPersonalizzatiDettFM in 'WA203UDatiMensiliPersonalizzatiDettFM.pas' {WA203FDatiMensiliPersonalizzatiDettFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
