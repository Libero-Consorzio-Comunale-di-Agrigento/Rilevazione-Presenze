program WA122PIscrizioniSindacati;

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
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA122ULogin in 'WA122ULogin.pas' {WA122FLogin: TIWAppForm},
  WA122UIscrizioniSindacatiDM in 'WA122UIscrizioniSindacatiDM.pas' {WA122FIscrizioniSindacatiDM: TIWUserSessionBase},
  WA122UIscrizioniSindacati in 'WA122UIscrizioniSindacati.pas' {WA122FIscrizioniSindacati: TIWAppForm},
  WA122UIscrizioniSindacatiBrowseFM in 'WA122UIscrizioniSindacatiBrowseFM.pas' {WA122FIscrizioniSindacatiBrowseFM: TFrame},
  L021Call in '..\Copy\L021Call.pas',
  A122UIscrizioniSindacaliMW in '..\MWRilPre\A122UIscrizioniSindacaliMW.pas' {A122FIscrizioniSindacaliMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
