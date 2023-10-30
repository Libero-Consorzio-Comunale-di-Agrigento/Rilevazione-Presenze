program WA199PCheckRimborsi;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A100UCheckRimborsiMW in '..\MWRilPre\A100UCheckRimborsiMW.pas' {A100FCheckRimborsiMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA199ULogin in 'WA199ULogin.pas' {WA199FLogin: TIWAppForm},
  WA199UCheckRimborsi in 'WA199UCheckRimborsi.pas' {WA199FCheckRimborsi: TIWAppForm},
  WA199UCheckRimborsiDM in 'WA199UCheckRimborsiDM.pas' {WA199FCheckRimborsiDM: TIWUserSessionBase},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA199URimborsiFM in 'WA199URimborsiFM.pas' {WA199FRimborsiFM: TFrame},
  WA199UIndKmFM in 'WA199UIndKmFM.pas' {WA199FIndKmFM: TFrame},
  WA199UDatiLiberiFM in 'WA199UDatiLiberiFM.pas' {WA199FDatiLiberiFM: TFrame},
  WA199UMezziFM in 'WA199UMezziFM.pas' {WA199FMezziFM: TFrame},
  WA199UCheckRimborsiBrowseFM in 'WA199UCheckRimborsiBrowseFM.pas' {WA199FCheckRimborsiBrowseFM: TFrame},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
