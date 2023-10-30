program WA120PTipiRimborsi;

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
  WA120ULogin in 'WA120ULogin.pas' {WA120FLogin: TIWAppForm},
  WA120UTipiRimborsiDM in 'WA120UTipiRimborsiDM.pas' {WA120FTipiRimborsiDM: TIWUserSessionBase},
  WA120UTipiRimborsi in 'WA120UTipiRimborsi.pas' {WA120FTipiRimborsi: TIWAppForm},
  WA120UTipiRimborsiBrowseFM in 'WA120UTipiRimborsiBrowseFM.pas' {WA120FTipiRimborsiBrowseFM: TFrame},
  WA120UTipiRimborsiDettFM in 'WA120UTipiRimborsiDettFM.pas' {WA120FTipiRimborsiDettFM: TFrame},
  L021Call in '..\Copy\L021Call.pas',
  A120UTipiRimborsiMW in '..\MWRilPre\A120UTipiRimborsiMW.pas' {A120FTipiRimborsiMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
