program WA119PPartecipazioneScioperi;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  A119UPartecipazioneScioperiMW in '..\MWRilPre\A119UPartecipazioneScioperiMW.pas' {A119FPartecipazioneScioperiMW: TDataModule},
  WA119ULogin in 'WA119ULogin.pas' {WA119FLogin: TIWAppForm},
  WA119UPartecipazioneScioperiDM in 'WA119UPartecipazioneScioperiDM.pas' {WA119FPartecipazioneScioperiDM: TIWUserSessionBase},
  WA119UPartecipazioneScioperi in 'WA119UPartecipazioneScioperi.pas' {WA119FPartecipazioneScioperi: TIWAppForm},
  WA119UPartecipazioneScioperiBrowseFM in 'WA119UPartecipazioneScioperiBrowseFM.pas' {WA119FPartecipazioneScioperiBrowseFM: TFrame},
  WA119UPartecipazioneScioperiDettFM in 'WA119UPartecipazioneScioperiDettFM.pas' {WA119FPartecipazioneScioperiDettFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA119URichiesteFM in 'WA119URichiesteFM.pas' {WA119FRichiesteFM: TFrame},
  A004UGiustifAssPresMW in '..\MWRilPre\A004UGiustifAssPresMW.pas' {A004FGiustifAssPresMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
