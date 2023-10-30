program WP553PRisorseResidueContoAnnuale;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WP553ULogin in 'WP553ULogin.pas' {WP553FLogin: TIWAppForm},
  WP553URisorseResidueContoAnnualeDM in 'WP553URisorseResidueContoAnnualeDM.pas' {WP553FRisorseResidueContoAnnualeDM: TIWUserSessionBase},
  WP553URisorseResidueContoAnnuale in 'WP553URisorseResidueContoAnnuale.pas' {WP553FRisorseResidueContoAnnuale: TIWAppForm},
  WP553URisorseResidueContoAnnualeDettFM in 'WP553URisorseResidueContoAnnualeDettFM.pas' {WP553FRisorseResidueContoAnnualeDettFM: TFrame},
  P553URisorseResidueContoAnnualeMW in '..\MWCondivisi\P553URisorseResidueContoAnnualeMW.pas' {P553FRisorseResidueContoAnnualeMW: TDataModule},
  WP553URisorseResidueContoAnnualeBrowseFM in 'WP553URisorseResidueContoAnnualeBrowseFM.pas' {WP553FRisorseResidueContoAnnualeBrowseFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
