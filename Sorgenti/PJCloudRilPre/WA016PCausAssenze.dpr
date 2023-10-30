program WA016PCausAssenze;

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
  A016UCausAssenzeMW in '..\MWRilPre\A016UCausAssenzeMW.pas' {A016FCausAssenzeMW: TDataModule},
  WA016UCausAssenzeDM in 'WA016UCausAssenzeDM.pas' {WA016FCausAssenzeDM: TIWUserSessionBase},
  WA016UCausAssenzeDettFM in 'WA016UCausAssenzeDettFM.pas' {WA016FCausAssenzeDettFM: TFrame},
  WA016UCausAssenzeBrowseFM in 'WA016UCausAssenzeBrowseFM.pas' {WA016FCausAssenzeBrowseFM: TFrame},
  WA016UCausAssenze in 'WA016UCausAssenze.pas' {WA016FCausAssenze: TIWAppForm},
  WA016ULogin in 'WA016ULogin.pas' {WA016FLogin: TIWAppForm},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A016UCausAssenzeStoricoMW in '..\MWRilPre\A016UCausAssenzeStoricoMW.pas' {A016FCausAssenzeStoricoMW: TDataModule},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas',
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WC502UMenuRilPreFM in '..\Copy\WC502UMenuRilPreFM.pas' {WC502FMenuRilPreFM: TFrame},
  WA016UCausAssenzeStorico in 'WA016UCausAssenzeStorico.pas' {WA016FCausAssenzeStorico: TIWAppForm},
  WA016UCausAssenzeStoricoBrowseFM in 'WA016UCausAssenzeStoricoBrowseFM.pas' {WA016FCausAssenzeStoricoBrowseFM: TFrame},
  WA016UCausAssenzeStoricoDettFM in 'WA016UCausAssenzeStoricoDettFM.pas' {WA016FCausAssenzeStoricoDettFM: TFrame},
  WA016UCausAssenzeStoricoDM in 'WA016UCausAssenzeStoricoDM.pas' {WA016FCausAssenzeStoricoDM: TIWUserSessionBase};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
