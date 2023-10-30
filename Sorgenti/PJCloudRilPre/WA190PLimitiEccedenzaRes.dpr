program WA190PLimitiEccedenzaRes;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA190ULogin in 'WA190ULogin.pas' {WA190FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WA190ULimitiEccedenzaRes in 'WA190ULimitiEccedenzaRes.pas' {WA190FLimitiEccedenzaRes: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WA190ULimitiEccedenzaResBrowseFM in 'WA190ULimitiEccedenzaResBrowseFM.pas' {WA190FLimitiEccedenzaResBrowseFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA190ULimitiEccedenzaResDM in 'WA190ULimitiEccedenzaResDM.pas' {WA190FLimitiEccedenzaResDM: TIWUserSessionBase},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA190ULimitiEccedenzaResMesiFM in 'WA190ULimitiEccedenzaResMesiFM.pas' {WA190FLimitiEccedenzaResMesiFM: TFrame},
  A094USkLimitiStraordMW in '..\MWRilPre\A094USkLimitiStraordMW.pas' {A094FSkLimitiStraordMW: TDataModule},
  L021Call in '..\Copy\L021Call.pas',
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
