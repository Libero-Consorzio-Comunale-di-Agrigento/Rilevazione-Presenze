program WP430PAnagrafico;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WP430ULogin in 'WP430ULogin.pas' {WP430FLogin: TIWAppForm},
  WP430UAnagraficoDM in 'WP430UAnagraficoDM.pas' {WP430FAnagraficoDM: TIWUserSessionBase},
  WP430UAnagrafico in 'WP430UAnagrafico.pas' {WP430FAnagrafico: TIWAppForm},
  WP430UAnagraficoBrowseFM in 'WP430UAnagraficoBrowseFM.pas' {WP430FAnagraficoBrowseFM: TFrame},
  WP430UAnagraficoDettFM in 'WP430UAnagraficoDettFM.pas' {WP430FAnagraficoDettFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  P430UAnagraficoMW in '..\MWCondivisi\P430UAnagraficoMW.pas' {P430FAnagraficoMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
