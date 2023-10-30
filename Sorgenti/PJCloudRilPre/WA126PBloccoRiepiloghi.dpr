program WA126PBloccoRiepiloghi;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA126ULogin in 'WA126ULogin.pas' {WA126FLogin: TIWAppForm},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WA126UBloccoRiepiloghi in 'WA126UBloccoRiepiloghi.pas' {WA126FBloccoRiepiloghi: TIWAppForm},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA126UBloccoRiepiloghiDM in 'WA126UBloccoRiepiloghiDM.pas' {WA126FBloccoRiepiloghiDM: TIWUserSessionBase},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WA126UBloccoRiepiloghiBrowseFM in 'WA126UBloccoRiepiloghiBrowseFM.pas' {WA126FBloccoRiepiloghiBrowseFM: TFrame},
  WA126UBloccoRiepiloghiFM in 'WA126UBloccoRiepiloghiFM.pas' {WA126FBloccoRiepiloghiFM: TFrame},
  A126UBloccoRiepiloghiMW in '..\MWRilPre\A126UBloccoRiepiloghiMW.pas' {A126FBloccoRiepiloghiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WA126UDataCassaFM in 'WA126UDataCassaFM.pas' {WA126FDataCassaFM: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
