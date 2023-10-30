program WA002PAnagrafe;

uses
  {$IFDEF DEBUG}
  OracleMonitor,
  {$ENDIF DEBUG}
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  L021Call in '..\Copy\L021Call.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA002UAnagrafe in 'WA002UAnagrafe.pas' {WA002FAnagrafe: TIWAppForm},
  WA002UAnagrafeBrowseFM in 'WA002UAnagrafeBrowseFM.pas' {WA002FAnagrafeBrowseFM: TFrame},
  WA002UAnagrafeDettFM in 'WA002UAnagrafeDettFM.pas' {WA002FAnagrafeDettFM: TFrame},
  WA002UAnagrafeDM in 'WA002UAnagrafeDM.pas' {WA002FAnagrafeDM: TIWUserSessionBase},
  WA002UCercaCampoFM in 'WA002UCercaCampoFM.pas' {WA002FCercaCampoFM: TFrame},
  WA002ULogin in 'WA002ULogin.pas' {WA002FLogin: TIWAppForm},
  A002UAnagrafeMW in '..\MWRilPre\A002UAnagrafeMW.pas' {A002FAnagrafeMW: TDataModule},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
