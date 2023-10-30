program WA171PXMLVisiteFiscali;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A171UXMLVisiteFiscaliMW in '..\MWRilPre\A171UXMLVisiteFiscaliMW.pas' {A171FXMLVisiteFiscaliMW: TDataModule},
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
  WA171ULogin in 'WA171ULogin.pas' {WA171FLogin: TIWAppForm},
  WA171UXMLVisiteFiscaliDM in 'WA171UXMLVisiteFiscaliDM.pas' {WA171FXMLVisiteFiscaliDM: TIWUserSessionBase},
  WA171UXMLVisiteFiscali in 'WA171UXMLVisiteFiscali.pas' {WA171FXMLVisiteFiscali: TIWAppForm},
  WA171UXMLVisiteFiscaliBrowseFM in 'WA171UXMLVisiteFiscaliBrowseFM.pas' {WA171FXMLVisiteFiscaliBrowseFM: TFrame},
  WA171UXMLVisiteFiscaliDettFM in 'WA171UXMLVisiteFiscaliDettFM.pas' {WA171FXMLVisiteFiscaliDettFM: TFrame},
  OracleMonitor;

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
