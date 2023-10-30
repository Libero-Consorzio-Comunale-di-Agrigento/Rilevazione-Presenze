program WA006PModelliOrario;

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
  WA006ULogin in 'WA006ULogin.pas' {WA006FLogin: TIWAppForm},
  WA006UModelliOrario in 'WA006UModelliOrario.pas' {WA006FModelliOrario: TIWAppForm},
  WA006UModelliOrarioBrowseFM in 'WA006UModelliOrarioBrowseFM.pas' {WA006FModelliOrarioBrowseFM: TFrame},
  WA006UModelliOrarioDettFM in 'WA006UModelliOrarioDettFM.pas' {WA006FModelliOrarioDettFM: TFrame},
  WA006UModelliOrarioDM in 'WA006UModelliOrarioDM.pas' {WA006FModelliOrarioDM: TIWUserSessionBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A006UModelliOrarioMW in '..\MWRilPre\A006UModelliOrarioMW.pas' {A006FModelliOrarioMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
