program WA206PCondizioniTurni;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A206UCondizioniTurniMW in '..\MWRilPre\A206UCondizioniTurniMW.pas' {A206FCondizioniTurniMW: TDataModule},
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
  WA206ULogin in 'WA206ULogin.pas' {WA206FLogin: TIWAppForm},
  WA206UCondizioniTurniDM in 'WA206UCondizioniTurniDM.pas' {WA206FCondizioniTurniDM: TIWUserSessionBase},
  WA206UCondizioniTurni in 'WA206UCondizioniTurni.pas' {WA206FCondizioniTurni: TIWAppForm},
  WA206UCondizioniTurniBrowseFM in 'WA206UCondizioniTurniBrowseFM.pas' {WA206FCondizioniTurniBrowseFM: TFrame},
  WA206UCondizioniTurniDettFM in 'WA206UCondizioniTurniDettFM.pas' {WA206FCondizioniTurniDettFM: TFrame},
  WA206UCodiciCondizioniTurni in 'WA206UCodiciCondizioniTurni.pas' {WA206FCodiciCondizioniTurni: TIWAppForm},
  WA206UCodiciCondizioniTurniBrowseFM in 'WA206UCodiciCondizioniTurniBrowseFM.pas' {WA206FCodiciCondizioniTurniBrowseFM: TFrame},
  WA206UCodiciCondizioniTurniDettFM in 'WA206UCodiciCondizioniTurniDettFM.pas' {WA206FCodiciCondizioniTurniDettFM: TFrame},
  WA206UCodiciCondizioniTurniDM in 'WA206UCodiciCondizioniTurniDM.pas' {WA206FCodiciCondizioniTurniDM: TIWUserSessionBase};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
