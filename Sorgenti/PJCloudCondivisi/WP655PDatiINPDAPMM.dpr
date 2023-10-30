program WP655PDatiINPDAPMM;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
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
  WP655ULogin in 'WP655ULogin.pas' {WP655FLogin: TIWAppForm},
  WP655UDatiINPDAPMMDM in 'WP655UDatiINPDAPMMDM.pas' {WP655FDatiINPDAPMMDM: TIWUserSessionBase},
  WP655UDatiINPDAPMM in 'WP655UDatiINPDAPMM.pas' {WP655FDatiINPDAPMM: TIWAppForm},
  WP655UDatiINPDAPMMBrowseFM in 'WP655UDatiINPDAPMMBrowseFM.pas' {WP655FDatiINPDAPMMBrowseFM: TFrame},
  WP655UFlussiIndividualiFM in 'WP655UFlussiIndividualiFM.pas' {WP655FFlussiIndividualiFM: TFrame},
  L021Call in '..\Copy\L021Call.pas',
  P655UDatiINPDAPMMMW in '..\MWCondivisi\P655UDatiINPDAPMMMW.pas' {P655FDatiINPDAPMMMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
