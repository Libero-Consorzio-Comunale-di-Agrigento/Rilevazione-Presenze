program WA042PStampaPreAss;

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
  WA042ULogin in 'WA042ULogin.pas' {WA042FLogin: TIWAppForm},
  WA042UStampaPreAss in 'WA042UStampaPreAss.pas' {WA042FStampaPreAss: TIWAppForm},
  WA042UImpostazioniEUCausalizzateFM in 'WA042UImpostazioniEUCausalizzateFM.pas' {WA042FImpostazioniEUCausalizzateFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A042UStampaPreAssMW in '..\MWRilPre\A042UStampaPreAssMW.pas' {A042FStampaPreAssMW: TDataModule},
  WA042UImpostazioniProspettoFM in 'WA042UImpostazioniProspettoFM.pas' {WA042FImpostazioniProspettoFM: TFrame},
  WA042UImpostazioniGraficoFM in 'WA042UImpostazioniGraficoFM.pas' {WA042FImpostazioniGraficoFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
