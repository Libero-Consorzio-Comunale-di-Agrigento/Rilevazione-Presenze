program WA174PParPianifTurni;

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
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A174UParPianifTurniMW in '..\MWRilPre\A174UParPianifTurniMW.pas' {A174FParPianifTurniMW: TDataModule},
  L021Call in '..\Copy\L021Call.pas',
  WA174ULogin in 'WA174ULogin.pas' {WA174FLogin: TIWAppForm},
  WA174UParPianifTurni in 'WA174UParPianifTurni.pas' {WA174FParPianifTurni: TIWAppForm},
  WA174UParPianifTurniBrowseFM in 'WA174UParPianifTurniBrowseFM.pas' {WA174FParPianifTurniBrowseFM: TFrame},
  WA174UParPianifTurniDM in 'WA174UParPianifTurniDM.pas' {WA174FParPianifTurniDM: TIWUserSessionBase},
  WA174UParPianifTurniDettFM in 'WA174UParPianifTurniDettFM.pas' {WA174FParPianifTurniDettFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
