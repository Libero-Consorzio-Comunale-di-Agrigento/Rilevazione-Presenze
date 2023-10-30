program WA020PCausPresenze;

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
  WA020ULogin in 'WA020ULogin.pas' {WA020FLogin: TIWAppForm},
  WA020UCausPresenze in 'WA020UCausPresenze.pas' {WA020FCausPresenze: TIWAppForm},
  WA020UCausPresenzeBrowseFM in 'WA020UCausPresenzeBrowseFM.pas' {WA020FCausPresenzeBrowseFM: TFrame},
  WA020UCausPresenzeDettFM in 'WA020UCausPresenzeDettFM.pas' {WA020FCausPresenzeDettFM: TFrame},
  WA020UCausPresenzeDM in 'WA020UCausPresenzeDM.pas' {WA020FCausPresenzeDM: TIWUserSessionBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A020UCausPresenzeMW in '..\MWRilPre\A020UCausPresenzeMW.pas' {A020FCausPresenzeMW: TDataModule},
  WA020UCausPresenzeStorico in 'WA020UCausPresenzeStorico.pas' {WA020FCausPresenzeStorico: TIWAppForm},
  WA020UCausPresenzeStoricoBrowseFM in 'WA020UCausPresenzeStoricoBrowseFM.pas' {WA020FCausPresenzeStoricoBrowseFM: TFrame},
  WA020UCausPresenzeStoricoDettFM in 'WA020UCausPresenzeStoricoDettFM.pas' {WA020FCausPresenzeStoricoDettFM: TFrame},
  WA020UCausPresenzeStoricoDM in 'WA020UCausPresenzeStoricoDM.pas' {WA020FCausPresenzeStoricoDM: TIWUserSessionBase},
  A020UCausPresenzeStoricoMW in '..\MWRilPre\A020UCausPresenzeStoricoMW.pas' {A020FCausPresenzeStoricoMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
