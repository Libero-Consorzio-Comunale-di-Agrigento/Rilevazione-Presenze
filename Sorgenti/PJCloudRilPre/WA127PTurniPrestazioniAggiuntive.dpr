program WA127PTurniPrestazioniAggiuntive;

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
  WA127ULogin in 'WA127ULogin.pas' {WA127FLogin: TIWAppForm},
  WA127UTurniPrestazioniAggiuntiveDM in 'WA127UTurniPrestazioniAggiuntiveDM.pas' {WA127FTurniPrestazioniAggiuntiveDM: TIWUserSessionBase},
  WA127UTurniPrestazioniAggiuntive in 'WA127UTurniPrestazioniAggiuntive.pas' {WA127FTurniPrestazioniAggiuntive: TIWAppForm},
  WA127UTurniPrestazioniAggiuntiveBrowseFM in 'WA127UTurniPrestazioniAggiuntiveBrowseFM.pas' {WA127FTurniPrestazioniAggiuntiveBrowseFM: TFrame},
  WA127UTurniPrestazioniAggiuntiveDettFM in 'WA127UTurniPrestazioniAggiuntiveDettFM.pas' {WA127FTurniPrestazioniAggiuntiveDettFM: TFrame},
  A127UTurniPrestazioniAggiuntiveMW in '..\MWRilPre\A127UTurniPrestazioniAggiuntiveMW.pas' {A127FTurniPrestazioniAggiuntiveMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
