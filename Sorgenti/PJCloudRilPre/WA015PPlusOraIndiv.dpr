program WA015PPlusOraIndiv;

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
  WA015ULogin in 'WA015ULogin.pas' {WA015FLogin: TIWAppForm},
  WA015UPlusOraIndiv in 'WA015UPlusOraIndiv.pas' {WA015FPlusOraIndiv: TIWAppForm},
  WA015UPlusOraIndivBrowseFM in 'WA015UPlusOraIndivBrowseFM.pas' {WA015FPlusOraIndivBrowseFM: TFrame},
  WA015UPlusOraIndivDettFM in 'WA015UPlusOraIndivDettFM.pas' {WA015FPlusOraIndivDettFm: TFrame},
  WA015UPlusOraIndivDM in 'WA015UPlusOraIndivDM.pas' {WA015FPlusOraIndivDM: TIWUserSessionBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
