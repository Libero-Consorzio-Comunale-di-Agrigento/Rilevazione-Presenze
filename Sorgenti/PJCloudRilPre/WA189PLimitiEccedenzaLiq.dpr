program WA189PLimitiEccedenzaLiq;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA189ULogin in 'WA189ULogin.pas' {WA189FLogin: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WA189ULimitiEccedenzaLiq in 'WA189ULimitiEccedenzaLiq.pas' {WA189FLimitiEccedenzaLiq: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA189ULimitiEccedenzaLiqBrowseFM in 'WA189ULimitiEccedenzaLiqBrowseFM.pas' {WA189FLimitiEccedenzaLiqBrowseFM: TFrame},
  WA189ULimitiEccedenzaLiqMesiFM in 'WA189ULimitiEccedenzaLiqMesiFM.pas' {WA189FLimitiEccedenzaLiqMesiFM: TFrame},
  A094USkLimitiStraordMW in '..\MWRilPre\A094USkLimitiStraordMW.pas' {A094FSkLimitiStraordMW: TDataModule},
  L021Call in '..\Copy\L021Call.pas',
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA189ULimitiEccedenzaLiqDM in 'WA189ULimitiEccedenzaLiqDM.pas' {WA189FLimitiEccedenzaLiqDM: TIWUserSessionBase},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
