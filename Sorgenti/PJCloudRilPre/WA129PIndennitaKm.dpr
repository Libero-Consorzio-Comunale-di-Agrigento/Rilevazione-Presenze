program WA129PIndennitaKm;

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
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA129ULogin in 'WA129ULogin.pas' {WA129FLogin: TIWAppForm},
  WA129UIndennitaKmDM in 'WA129UIndennitaKmDM.pas' {WA129FIndennitaKmDM: TIWUserSessionBase},
  WA129UIndennitaKm in 'WA129UIndennitaKm.pas' {WA129FIndennitaKm: TIWAppForm},
  WA129UIndennitaKmBrowseFM in 'WA129UIndennitaKmBrowseFM.pas' {WA129FIndennitaKmBrowseFM: TFrame},
  WA129UIndennitaKmDettFM in 'WA129UIndennitaKmDettFM.pas' {WA129FIndennitaKmDettFM: TFrame},
  L021Call in '..\Copy\L021Call.pas',
  A129UIndennitaKmMW in '..\MWRilPre\A129UIndennitaKmMW.pas' {A129FIndennitaKmMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
