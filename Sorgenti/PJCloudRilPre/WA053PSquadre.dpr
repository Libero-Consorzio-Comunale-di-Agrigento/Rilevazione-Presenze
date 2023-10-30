program WA053PSquadre;

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
  WA053ULogin in 'WA053ULogin.pas' {WA053FLogin: TIWAppForm},
  WA053USquadreDM in 'WA053USquadreDM.pas' {WA053FSquadreDM: TIWUserSessionBase},
  WA053USquadre in 'WA053USquadre.pas' {WA053FSquadre: TIWAppForm},
  WA053USquadreBrowseFM in 'WA053USquadreBrowseFM.pas' {WA053FSquadreBrowseFM: TFrame},
  WA053USquadreDettFM in 'WA053USquadreDettFM.pas' {WA053FSquadreDettFM: TFrame},
  WA053USquadreTipiOperatoreFM in 'WA053USquadreTipiOperatoreFM.pas' {WA053FSquadreTipiOperatoreFM: TFrame},
  WA053USquadreAreeTurniFM in 'WA053USquadreAreeTurniFM.pas' {WA053FSquadreAreeTurniFM: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
