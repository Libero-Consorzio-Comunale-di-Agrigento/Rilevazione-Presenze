program WP552PRegoleContoAnnuale;

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
  WP552ULogin in 'WP552ULogin.pas' {WP552FLogin: TIWAppForm},
  WP552URegoleContoAnnualeBrowseFM in 'WP552URegoleContoAnnualeBrowseFM.pas' {WP552FRegoleContoAnnualeBrowseFM: TFrame},
  WP552URegoleContoAnnualeDettFM in 'WP552URegoleContoAnnualeDettFM.pas' {WP552FRegoleContoAnnualeDettFM: TFrame},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WP552URegoleContoAnnualeDM in 'WP552URegoleContoAnnualeDM.pas' {WP552FRegoleContoAnnualeDM: TIWUserSessionBase},
  WP552URegoleContoAnnuale in 'WP552URegoleContoAnnuale.pas' {WP552FRegoleContoAnnuale: TIWAppForm},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P552URegoleContoAnnualeMW in '..\MWCondivisi\P552URegoleContoAnnualeMW.pas' {P552FRegoleContoAnnualeMW: TDataModule},
  WP552URigheRegoleContoAnnualeFM in 'WP552URigheRegoleContoAnnualeFM.pas' {WP552FRigheRegoleContoAnnualeFM: TFrame},
  WP552UColonneRegoleContoAnnualeFM in 'WP552UColonneRegoleContoAnnualeFM.pas' {WP552FColonneRegoleContoAnnualeFM: TFrame},
  WP552UDettaglioRegoleContoAnnFM in 'WP552UDettaglioRegoleContoAnnFM.pas' {WP552FDettaglioRegoleContoAnnFM: TFrame},
  WP552UEsportazioneFileFM in 'WP552UEsportazioneFileFM.pas' {WP552FEsportazioneFileFM: TFrame},
  WP552UDettaglioEsportazioneFileFM in 'WP552UDettaglioEsportazioneFileFM.pas' {WP552FDettaglioEsportazioneFileFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WP552UScriptInizialeRegoleContoAnnualeFM in 'WP552UScriptInizialeRegoleContoAnnualeFM.pas' {WP552FScriptInizialeRegoleContoAnnualeFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
