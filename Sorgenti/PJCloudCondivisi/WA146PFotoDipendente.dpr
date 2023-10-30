program WA146PFotoDipendente;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A146UFotoDipendenteMW in '..\MWCondivisi\A146UFotoDipendenteMW.pas' {A146FFotoDipendenteMW: TDataModule},
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
  WA146ULogin in 'WA146ULogin.pas' {WA146FLogin: TIWAppForm},
  WA146UFotoDipendenteDM in 'WA146UFotoDipendenteDM.pas' {WA146FFotoDipendenteDM: TIWUserSessionBase},
  WA146UFotoDipendente in 'WA146UFotoDipendente.pas' {WA146FFotoDipendente: TIWAppForm},
  WA146UFotoDipendenteDettFM in 'WA146UFotoDipendenteDettFM.pas' {WA146FFotoDipendenteDettFM: TFrame},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WA146UFotoDipendenteBrowseFM in 'WA146UFotoDipendenteBrowseFM.pas' {WA146FFotoDipendenteBrowseFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
