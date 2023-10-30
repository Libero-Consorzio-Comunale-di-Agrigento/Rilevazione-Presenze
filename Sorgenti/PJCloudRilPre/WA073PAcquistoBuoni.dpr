program WA073PAcquistoBuoni;

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
  WA073ULogin in 'WA073ULogin.pas' {WA073FLogin: TIWAppForm},
  WA073UAcquistoBuoni in 'WA073UAcquistoBuoni.pas' {WA073FAcquistoBuoni: TIWAppForm},
  WA073UAcquistoBuoniDM in 'WA073UAcquistoBuoniDM.pas' {WA073FAcquistoBuoniDM: TIWUserSessionBase},
  WA073UAcquistoBuoniBrowseFM in 'WA073UAcquistoBuoniBrowseFM.pas' {WA073FAcquistoBuoniBrowseFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A073UAcquistoBuoniMW in '..\MWRilPre\A073UAcquistoBuoniMW.pas' {A073FAcquistoBuoniMW: TDataModule},
  WA073UImportazioneAcquistiExcelFM in 'WA073UImportazioneAcquistiExcelFM.pas' {WA073FImportazioneAcquistiExcelFM: TFrame},
  WA073UControlloFM in 'WA073UControlloFM.pas' {WA073FControlloFM: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
