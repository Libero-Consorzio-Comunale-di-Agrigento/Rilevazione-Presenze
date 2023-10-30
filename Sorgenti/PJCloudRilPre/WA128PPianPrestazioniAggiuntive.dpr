program WA128PPianPrestazioniAggiuntive;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
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
  WA128ULogin in 'WA128ULogin.pas' {WA128FLogin: TIWAppForm},
  WA128UPianPrestazioniAggiuntiveDM in 'WA128UPianPrestazioniAggiuntiveDM.pas' {WA128FPianPrestazioniAggiuntiveDM: TIWUserSessionBase},
  WA128UPianPrestazioniAggiuntive in 'WA128UPianPrestazioniAggiuntive.pas' {WA128FPianPrestazioniAggiuntive: TIWAppForm},
  WA128UPianPrestazioniAggiuntiveBrowseFM in 'WA128UPianPrestazioniAggiuntiveBrowseFM.pas' {WA128FPianPrestazioniAggiuntiveBrowseFM: TFrame},
  WA128UInserimentoFM in 'WA128UInserimentoFM.pas' {WA128FInserimentoFM: TFrame},
  A128UPianPrestazioniAggiuntiveMW in '..\MWRilPre\A128UPianPrestazioniAggiuntiveMW.pas' {A128FPianPrestazioniAggiuntiveMW: TDataModule},
  WA128UAcqFilePrestazioniAggiuntiveFM in 'WA128UAcqFilePrestazioniAggiuntiveFM.pas' {WA128FAcqFilePrestazioniAggiuntiveFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
