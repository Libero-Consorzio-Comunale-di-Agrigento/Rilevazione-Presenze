program WA110PParametriConteggio;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas',
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WA110ULogin in 'WA110ULogin.pas' {WA110FLogin: TIWAppForm},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WA110UParametriConteggioDM in 'WA110UParametriConteggioDM.pas' {WA110FParametriConteggioDM: TIWUserSessionBase},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WA110UParametriConteggioBrowseFM in 'WA110UParametriConteggioBrowseFM.pas' {WA110FParametriConteggioBrowseFM: TFrame},
  L021Call in '..\Copy\L021Call.pas',
  WA110UParametriConteggioDettFM in 'WA110UParametriConteggioDettFM.pas' {WA110FParametriConteggioDettFM: TFrame},
  A110UParametriConteggioMW in '..\MWRilPre\A110UParametriConteggioMW.pas' {A110FParametriConteggioMW: TDataModule},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WA110UParametriConteggio in 'WA110UParametriConteggio.pas' {WA110FParametriConteggio: TIWAppForm},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA110USoglieRimborsiPastoFM in 'WA110USoglieRimborsiPastoFM.pas' {WA110FSoglieRimborsiPastoFM: TFrame},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA110UTipiMissioneFM in 'WA110UTipiMissioneFM.pas' {WA110FTipiMissioneFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
