program WA177PFerieSolidali;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A177UFerieSolidaliMW in '..\MWRilPre\A177UFerieSolidaliMW.pas' {A177FFerieSolidaliMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA177ULogin in 'WA177ULogin.pas' {WA177FLogin: TIWAppForm},
  WA177UFerieSolidaliDM in 'WA177UFerieSolidaliDM.pas' {WA177FFerieSolidaliDM: TIWUserSessionBase},
  WA177UFerieSolidali in 'WA177UFerieSolidali.pas' {WA177FFerieSolidali: TIWAppForm},
  WA177UFerieSolidaliBrowseFM in 'WA177UFerieSolidaliBrowseFM.pas' {WA177FFerieSolidaliBrowseFM: TFrame},
  WA177UFerieSolidaliDettFM in 'WA177UFerieSolidaliDettFM.pas' {WA177FFerieSolidaliDettFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
