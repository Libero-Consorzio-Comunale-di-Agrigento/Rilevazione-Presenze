program WA169PPesatureIndividuali;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A169UPesatureIndividualiMW in '..\MWRilPre\A169UPesatureIndividualiMW.pas' {A169FPesatureIndividualiMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA169ULogin in 'WA169ULogin.pas' {WA169FLogin: TIWAppForm},
  WA169UPesatureIndividualiDM in 'WA169UPesatureIndividualiDM.pas' {WA169FPesatureIndividualiDM: TIWUserSessionBase},
  WA169UPesatureIndividuali in 'WA169UPesatureIndividuali.pas' {WA169FPesatureIndividuali: TIWAppForm},
  //WR020UBaseFM in '..\Repositary\WR020UBaseFM.pas' {WR020FBaseFM: TFrame},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WA169UPesatureIndividualiBrowseFM in 'WA169UPesatureIndividualiBrowseFM.pas' {WA169FPesatureIndividualiBrowseFM: TFrame},
  WA169UPesatureFM in 'WA169UPesatureFM.pas' {WA169FPesatureFM: TFrame},
  WA169UPesatureIndividualiDettFM in 'WA169UPesatureIndividualiDettFM.pas' {WA169FPesatureIndividualiDettFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
