program WA162PIncentiviAssenze;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA162ULogin in 'WA162ULogin.pas' {WA162FLogin: TIWAppForm},
  WA162UIncentiviAssenzeDM in 'WA162UIncentiviAssenzeDM.pas' {WA162FIncentiviAssenzeDM: TIWUserSessionBase},
  WA162UIncentiviAssenze in 'WA162UIncentiviAssenze.pas' {WA162FIncentiviAssenze: TIWAppForm},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WA162UIncentiviAssenzeBrowseFM in 'WA162UIncentiviAssenzeBrowseFM.pas' {WA162FIncentiviAssenzeBrowseFM: TFrame},
  WA162UIncentiviAssenzeDettFM in 'WA162UIncentiviAssenzeDettFM.pas' {WA162FIncentiviAssenzeDettFM: TFrame},
  A162UIncentiviAssenzeMW in '..\MWRilPre\A162UIncentiviAssenzeMW.pas' {A162FIncentiviAssenzeMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
