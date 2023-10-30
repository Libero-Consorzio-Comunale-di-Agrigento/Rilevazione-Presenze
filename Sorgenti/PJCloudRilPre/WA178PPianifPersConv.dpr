program WA178PPianifPersConv;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A178UPianifPersConvMW in '..\MWRilPre\A178UPianifPersConvMW.pas' {A178FPianifPersConvMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA178ULogin in 'WA178ULogin.pas' {WA178FLogin: TIWAppForm},
  WA178UPianifPersConvDM in 'WA178UPianifPersConvDM.pas' {WA178FPianifPersConvDM: TIWUserSessionBase},
  WA178UPianifPersConv in 'WA178UPianifPersConv.pas' {WA178FPianifPersConv: TIWAppForm},
  WA178UPianifPersConvBrowseFM in 'WA178UPianifPersConvBrowseFM.pas' {WA178FPianifPersConvBrowseFM: TFrame},
  WA178UIDPianifPersConvFM in 'WA178UIDPianifPersConvFM.pas' {WA178FIDPianifPersConvFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
