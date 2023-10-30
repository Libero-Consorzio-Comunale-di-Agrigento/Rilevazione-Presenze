program WP050PArrotondamenti;

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
  WP050ULogin in 'WP050ULogin.pas' {WP050FLogin: TIWAppForm},
  WP050UArrotondamenti in 'WP050UArrotondamenti.pas' {WP050FArrotondamenti: TIWAppForm},
  WP050UArrotondamentiBrowseFM in 'WP050UArrotondamentiBrowseFM.pas' {WP050FArrotondamentiBrowseFM: TFrame},
  WP050UArrotondamentiDM in 'WP050UArrotondamentiDM.pas' {WP050FArrotondamentiDM: TIWUserSessionBase},
  WC007UFormContainerFM in '..\Copy\WC007UFormContainerFM.pas' {WC007FFormContainerFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WP050UCodArrotondamentoFM in 'WP050UCodArrotondamentoFM.pas' {WP050FCodArrotondamentoFM: TFrame},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  P050UArrotondamentiMW in '..\MWCondivisi\P050UArrotondamentiMW.pas' {P050FArrotondamentiMW: TDataModule},
  WP050UArrotondamentiDettFM in 'WP050UArrotondamentiDettFM.pas' {WP050FArrotondamentiDettFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
