program WA123PPartecipazioniSindacati;

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
  WA123ULogin in 'WA123ULogin.pas' {WA123FLogin: TIWAppForm},
  WA123UPartecipazioniSindacatiDM in 'WA123UPartecipazioniSindacatiDM.pas' {WA123FPartecipazioniSindacatiDM: TIWUserSessionBase},
  WA123UPartecipazioniSindacati in 'WA123UPartecipazioniSindacati.pas' {WA123FPartecipazioniSindacati: TIWAppForm},
  WA123UPartecipazioniSindacatiBrowseFM in 'WA123UPartecipazioniSindacatiBrowseFM.pas' {WA123FPartecipazioniSindacatiBrowseFM: TFrame},
  L021Call in '..\Copy\L021Call.pas',
  WA123UVisualizzazioneFM in 'WA123UVisualizzazioneFM.pas' {WA123FVisualizzazioneFM: TFrame},
  A123UPartecipazioniSindacatiMW in '..\MWRilPre\A123UPartecipazioniSindacatiMW.pas' {A123FPartecipazioniSindacatiMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
