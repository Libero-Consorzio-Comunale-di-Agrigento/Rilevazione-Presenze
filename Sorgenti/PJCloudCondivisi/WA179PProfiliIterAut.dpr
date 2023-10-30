program WA179PProfiliIterAut;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  OracleMonitor,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
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
  WA179ULogin in 'WA179ULogin.pas' {WA179FLogin: TIWAppForm},
  WA179UProfiliIterAutDM in 'WA179UProfiliIterAutDM.pas' {WA179FProfiliIterAutDM: TIWUserSessionBase},
  WA179UProfiliIterAut in 'WA179UProfiliIterAut.pas' {WA179FProfiliIterAut: TIWAppForm},
  WA179UProfiliIterAutBrowseFM in 'WA179UProfiliIterAutBrowseFM.pas' {WA179FProfiliIterAutBrowseFM: TFrame},
  WA179UProfiliIterAutDettFM in 'WA179UProfiliIterAutDettFM.pas' {WA179FProfiliIterAutDettFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A179UProfiliIterAutMW in '..\MWCondivisi\A179UProfiliIterAutMW.pas' {A179FProfiliIterAutMW: TDataModule},
  WA179UNuovoProfiloIterFM in 'WA179UNuovoProfiloIterFM.pas' {WA179FNuovoProfiloIterFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
