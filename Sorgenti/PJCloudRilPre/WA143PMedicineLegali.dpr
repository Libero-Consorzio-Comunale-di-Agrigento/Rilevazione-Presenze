program WA143PMedicineLegali;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA143ULogin in 'WA143ULogin.pas' {WA143FLogin: TIWAppForm},
  WA143UMedicineLegaliDM in 'WA143UMedicineLegaliDM.pas' {WA143FMedicineLegaliDM: TIWUserSessionBase},
  WA143UMedicineLegali in 'WA143UMedicineLegali.pas' {WA143FMedicineLegali: TIWAppForm},
  WA143UMedicineLegaliBrowseFM in 'WA143UMedicineLegaliBrowseFM.pas' {WA143FMedicineLegaliBrowseFM: TFrame},
  WA143UMedicineLegaliDettFM in 'WA143UMedicineLegaliDettFM.pas' {WA143FMedicineLegaliDettFM: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
