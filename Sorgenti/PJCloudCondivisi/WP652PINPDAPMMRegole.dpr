program WP652PINPDAPMMRegole;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas',
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WP652ULogin in 'WP652ULogin.pas' {WP652FLogin: TIWAppForm},
  WP652UINPDAPMMRegoleDM in 'WP652UINPDAPMMRegoleDM.pas' {WP652FINPDAPMMRegoleDM: TIWUserSessionBase},
  WP652UINPDAPMMRegole in 'WP652UINPDAPMMRegole.pas' {WP652FINPDAPMMRegole: TIWAppForm},
  WP652UINPDAPMMRegoleBrowseFM in 'WP652UINPDAPMMRegoleBrowseFM.pas' {WP652FINPDAPMMRegoleBrowseFM: TFrame},
  WP652UINPDAPMMRegoleDettFM in 'WP652UINPDAPMMRegoleDettFM.pas' {WP652FINPDAPMMRegoleDettFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P652UINPDAPMMRegoleMW in '..\MWCondivisi\P652UINPDAPMMRegoleMW.pas' {P652FINPDAPMMRegoleMW: TDataModule},
  L021Call in '..\Copy\L021Call.pas',
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
