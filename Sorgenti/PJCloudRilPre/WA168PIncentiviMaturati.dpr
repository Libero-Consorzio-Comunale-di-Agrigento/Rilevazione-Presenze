program WA168PIncentiviMaturati;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  A168UIncentiviMaturatiMW in '..\MWRilPre\A168UIncentiviMaturatiMW.pas' {A168FIncentiviMaturatiMW: TDataModule},
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
  WA168ULogin in 'WA168ULogin.pas' {WA168FLogin: TIWAppForm},
  WA168UIncentiviMaturatiDM in 'WA168UIncentiviMaturatiDM.pas' {WA168FIncentiviMaturatiDM: TIWUserSessionBase},
  WA168UIncentiviMaturatiBrowseFM in 'WA168UIncentiviMaturatiBrowseFM.pas' {WA168FIncentiviMaturatiBrowseFM: TFrame},
  WA168UIncentiviMaturati in 'WA168UIncentiviMaturati.pas' {WA168FIncentiviMaturati: TIWAppForm},
  WA168UAbbattimentiFM in 'WA168UAbbattimentiFM.pas' {WA168FAbbattimentiFM: TFrame};

{$R *.res}

begin

  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}


  TIWStart.Execute(True);
end.
