program WA202PRapportiLavoro;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  OracleMonitor,
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A202URapportiLavoroMW in '..\MWRilPre\A202URapportiLavoroMW.pas' {A202FRapportiLavoroMW: TDataModule},
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
  WA202ULogin in 'WA202ULogin.pas' {WA202FLogin: TIWAppForm},
  WA202URapportiLavoro in 'WA202URapportiLavoro.pas' {WA202FRapportiLavoro: TIWAppForm},
  WA202URapportiLavoroBrowseFM in 'WA202URapportiLavoroBrowseFM.pas' {WA202FRapportiLavoroBrowseFM: TFrame},
  WA202URapportiLavoroDM in 'WA202URapportiLavoroDM.pas' {WA202FRapportiLavoroDM: TIWUserSessionBase},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WA202UValidazioneBrowseFM in 'WA202UValidazioneBrowseFM.pas' {WA202FValidazioneBrowseFM: TFrame},
  WA202UDetailEnteCorrFM in 'WA202UDetailEnteCorrFM.pas' {WA202FDetailEnteCorrFM: TFrame},
  WA202UDetailProfAssFM in 'WA202UDetailProfAssFM.pas' {WA202FDetailProfAssFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
