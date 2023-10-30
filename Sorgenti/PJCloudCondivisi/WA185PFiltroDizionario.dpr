program WA185PFiltroDizionario;

uses
  IWStart,
  UTF8ContentParser,
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WC003URicercaDatiFM in '..\Copy\WC003URicercaDatiFM.pas' {WC003FRicercaDatiFM: TFrame},
  WC004UEstrazioneDatiFM in '..\Copy\WC004UEstrazioneDatiFM.pas' {WC004FEstrazioneDatiFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame},
  A000USessione in '..\Copy\A000USessione.pas',
  WA185UFiltroDizionario in 'WA185UFiltroDizionario.pas' {WA185FFiltroDizionario: TIWAppForm},
  WA185UFiltroDizionarioBrowseFM in 'WA185UFiltroDizionarioBrowseFM.pas' {WA185FFiltroDizionarioBrowseFM: TFrame},
  WA185UFiltroDizionarioDettFM in 'WA185UFiltroDizionarioDettFM.pas' {WA185FFiltroDizionarioDettFM: TFrame},
  WA185UFiltroDizionarioDM in 'WA185UFiltroDizionarioDM.pas' {WA185FFiltroDizionarioDM: TIWUserSessionBase},
  WA185ULogin in 'WA185ULogin.pas' {WA185FLogin: TIWAppForm},
  WC009UCopiaSuFM in '..\Copy\WC009UCopiaSuFM.pas' {WC009FCopiaSuFM: TFrame},
  WC010UMemoEditFM in '..\Copy\WC010UMemoEditFM.pas' {WC010FMemoEditFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A185UFiltroDizionarioMW in '..\MWRilPre\A185UFiltroDizionarioMW.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
