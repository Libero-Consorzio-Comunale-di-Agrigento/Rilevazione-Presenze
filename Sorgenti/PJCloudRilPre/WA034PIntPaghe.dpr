program WA034PIntPaghe;

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
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WA034ULogin in 'WA034ULogin.pas' {WA034FLogin: TIWAppForm},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA034UIntPagheDM in 'WA034UIntPagheDM.pas' {WA034FIntPagheDM: TIWUserSessionBase},
  WA034UIntPaghe in 'WA034UIntPaghe.pas' {WA034FIntPaghe: TIWAppForm},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WA034UIntPagheBrowseFM in 'WA034UIntPagheBrowseFM.pas' {WA034FIntPagheBrowseFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A034UIntPagheMW in '..\MWRilPre\A034UIntPagheMW.pas' {A034FIntPagheMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WC009UCopiaSuFM in '..\Copy\WC009UCopiaSuFM.pas' {WC009FCopiaSuFM: TFrame},
  WA034UParametriAvanzati in 'WA034UParametriAvanzati.pas' {WA034FParametriAvanzati: TIWAppForm},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WA034UParametriAvanzatiDM in 'WA034UParametriAvanzatiDM.pas' {WA034FParametriAvanzatiDM: TIWUserSessionBase},
  WA034UParametriAvanzatiDettFM in 'WA034UParametriAvanzatiDettFM.pas' {WA034FParametriAvanzatiDettFM: TFrame},
  WA034UParametriAvanzatiBrowseFM in 'WA034UParametriAvanzatiBrowseFM.pas' {WA034FParametriAvanzatiBrowseFM: TFrame},
  A034UParametriAvanzatiMW in '..\MWRilPre\A034UParametriAvanzatiMW.pas' {A034FParametriAvanzatiMW: TDataModule},
  WC007UFormContainerFM in '..\Copy\WC007UFormContainerFM.pas' {WC007FFormContainerFM: TFrame},
  L021Call in '..\Copy\L021Call.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
