program WA029PSchedaRiepil;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA029ULogin in 'WA029ULogin.pas' {WA029FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA029USchedaRiepil in 'WA029USchedaRiepil.pas' {WA029FSchedaRiepil: TIWAppForm},
  WA029USchedaRiepilDM in 'WA029USchedaRiepilDM.pas' {WA029FSchedaRiepilDM: TIWUserSessionBase},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WA029USchedaRiepilBrowseFM in 'WA029USchedaRiepilBrowseFM.pas' {WA029FSchedaRiepilBrowseFM: TFrame},
  WA029USchedaRiepilDettFM in 'WA029USchedaRiepilDettFM.pas' {WA029FSchedaRiepilDettFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A029USchedaRiepilMW in '..\MWRilPre\A029USchedaRiepilMW.pas' {A029FSchedaRiepilMW: TDataModule},
  L021Call in '..\Copy\L021Call.pas',
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WA029URecuperiMobiliFM in 'WA029URecuperiMobiliFM.pas' {WA029FRecuperiMobiliFM: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
