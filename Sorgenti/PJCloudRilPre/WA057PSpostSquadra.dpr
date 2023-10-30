program WA057PSpostSquadra;

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
  WA057ULogin in 'WA057ULogin.pas' {WA057FLogin: TIWAppForm},
  WA057USpostSquadra in 'WA057USpostSquadra.pas' {WA057FSpostSquadra: TIWAppForm},
  WA057USpostSquadraBrowseFM in 'WA057USpostSquadraBrowseFM.pas' {WA057FSpostSquadraBrowseFM: TFrame},
  WA057USpostSquadraDM in 'WA057USpostSquadraDM.pas' {WA057FSpostSquadraDM: TIWUserSessionBase},
  L021Call in '..\Copy\L021Call.pas',
  WA057USpostSquadraDettFM in 'WA057USpostSquadraDettFM.pas' {WA057FSpostSquadraDettFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A057USpostSquadraMW in '..\MWRilPre\A057USpostSquadraMW.pas' {A057FSpostSquadraMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
