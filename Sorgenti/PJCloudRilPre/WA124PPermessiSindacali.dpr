program WA124PPermessiSindacali;

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
  WA124ULogin in 'WA124ULogin.pas' {WA124FLogin: TIWAppForm},
  WA124UPermessiSindacaliDM in 'WA124UPermessiSindacaliDM.pas' {WA124FPermessiSindacaliDM: TIWUserSessionBase},
  WA124UPermessiSindacali in 'WA124UPermessiSindacali.pas' {WA124FPermessiSindacali: TIWAppForm},
  WA124UPermessiSindacaliBrowseFM in 'WA124UPermessiSindacaliBrowseFM.pas' {WA124FPermessiSindacaliBrowseFM: TFrame},
  WA124UPermessiSindacaliDettFM in 'WA124UPermessiSindacaliDettFM.pas' {WA124FPermessiSindacaliDettFM: TFrame},
  A124UPermessiSindacaliMW in '..\MWRilPre\A124UPermessiSindacaliMW.pas' {A124FPermessiSindacaliMW: TDataModule},
  WA124USuperoCompetenzeFM in 'WA124USuperoCompetenzeFM.pas' {WA124FSuperoCompetenzeFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WA124UInvioPermessiFM in 'WA124UInvioPermessiFM.pas' {WA124FInvioPermessiFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
