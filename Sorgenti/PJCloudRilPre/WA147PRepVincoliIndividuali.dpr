program WA147PRepVincoliIndividuali;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA147ULogin in 'WA147ULogin.pas' {WA147FLogin: TIWAppForm},
  WA147URepVincoliIndividuali in 'WA147URepVincoliIndividuali.pas' {WA147FRepVincoliIndividuali: TIWAppForm},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA147URepVincoliIndividualiBrowseFM in 'WA147URepVincoliIndividualiBrowseFM.pas' {WA147FRepVincoliIndividualiBrowseFM: TFrame},
  WA147URepVincoliIndividualiDettFM in 'WA147URepVincoliIndividualiDettFM.pas' {WA147FRepVincoliIndividualiDettFM: TFrame},
  WA147URepVincoliIndividualiDM in 'WA147URepVincoliIndividualiDM.pas' {WA147FRepVincoliIndividualiDM: TIWUserSessionBase},
  A147URepVincoliIndividualiMW in '..\MWRilPre\A147URepVincoliIndividualiMW.pas' {A147FRepVincoliIndividualiMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
