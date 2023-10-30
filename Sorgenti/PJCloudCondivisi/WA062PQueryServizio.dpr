program WA062PQueryServizio;

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
  WA062ULogin in 'WA062ULogin.pas' {WA062FLogin: TIWAppForm},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WA062UQueryServizioBrowseFM in 'WA062UQueryServizioBrowseFM.pas' {WA062FQueryServizioBrowseFM: TFrame},
  WA062UQueryServizio in 'WA062UQueryServizio.pas' {WA062FQueryServizio: TIWAppForm},
  WA062UQueryServizioDettFM in 'WA062UQueryServizioDettFM.pas' {WA062FQueryServizioDettFM: TFrame},
  WA062UQueryServizioDM in 'WA062UQueryServizioDM.pas' {WA062FQueryServizioDM: TIWUserSessionBase},
  WA062URisultatiFM in 'WA062URisultatiFM.pas' {WA062FRisultatiFM: TFrame},
  WA062UAccessoDB in 'WA062UAccessoDB.pas' {WA062FAccessoDB: TFrame},
  A062UQueryServizioMW in '..\MWCondivisi\A062UQueryServizioMW.pas' {A062FQueryServizioMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
