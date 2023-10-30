program WA121POrganizzSindacali;

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
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  A121URecapitiSindacaliMW in '..\MWRilPre\A121URecapitiSindacaliMW.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WA121ULogin in 'WA121ULogin.pas' {WA121FLogin: TIWAppForm},
  WA121UOrganizzSindacali in 'WA121UOrganizzSindacali.pas' {WA121FOrganizzSindacali: TIWAppForm},
  WA121UOrganizzSindacaliDM in 'WA121UOrganizzSindacaliDM.pas' {WA121FOrganizzSindacaliDM: TIWUserSessionBase},
  WA121UOrganizzSindacaliBrowseFM in 'WA121UOrganizzSindacaliBrowseFM.pas' {WA121FOrganizzSindacaliBrowseFM: TFrame},
  WA121UOrganizzSindacaliDettFM in 'WA121UOrganizzSindacaliDettFM.pas' {WA121FOrganizzSindacaliDettFM: TFrame},
  WA121UOrganizzSindacaliRecapitiFM in 'WA121UOrganizzSindacaliRecapitiFM.pas' {WA121FOrganizzSindacaliRecapitiFM: TFrame},
  WA121UOrganizzSindacaliCompetenzeFM in 'WA121UOrganizzSindacaliCompetenzeFM.pas' {WA121FOrganizzSindacaliCompetenzeFM: TFrame},
  WA121UOrganizzSindacaliOrganismiFM in 'WA121UOrganizzSindacaliOrganismiFM.pas' {WA121FOrganizzSindacaliOrganismiFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
