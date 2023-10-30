program WA194PRecapitiSindacali;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
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
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  L021Call in '..\Copy\L021Call.pas',
  WA194ULogin in 'WA194ULogin.pas' {WA194FLogin: TIWAppForm},
  WA194URecapitiSindacaliDM in 'WA194URecapitiSindacaliDM.pas' {WA194FRecapitiSindacaliDM: TIWUserSessionBase},
  WA194URecapitiSindacali in 'WA194URecapitiSindacali.pas' {WA194FRecapitiSindacali: TIWAppForm},
  WA194URecapitiSindacaliBrowseFM in 'WA194URecapitiSindacaliBrowseFM.pas' {WA194FRecapitiSindacaliBrowseFM: TFrame},
  WA194URecapitiSindacaliDettFM in 'WA194URecapitiSindacaliDettFM.pas' {WA194FRecapitiSindacaliDettFM: TFrame},
  A121URecapitiSindacaliMW in '..\MWRilPre\A121URecapitiSindacaliMW.pas' {A121FRecapitiSindacaliMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
