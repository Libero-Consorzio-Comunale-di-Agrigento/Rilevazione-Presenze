program WA071PRegoleBuoni;

uses
  IWStart,
  UTF8ContentParser,
  WA071URegoleBuoni in 'WA071URegoleBuoni.pas' {WA071FRegoleBuoni: TIWAppForm},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WA071ULogin in 'WA071ULogin.pas' {WA071FLogin: TIWAppForm},
  WA071URegoleBuoniBrowseFM in 'WA071URegoleBuoniBrowseFM.pas' {WA071FRegoleBuoniBrowseFM: TFrame},
  WA071URegoleBuoniDettFM in 'WA071URegoleBuoniDettFM.pas' {WA071FRegoleBuoniDettFM: TFrame},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WC009UCopiaSuFM in '..\Copy\WC009UCopiaSuFM.pas' {WC009FCopiaSuFM: TFrame},
  WC004UEstrazioneDatiFM in '..\Copy\WC004UEstrazioneDatiFM.pas' {WC004FEstrazioneDatiFM: TFrame},
  WC003URicercaDatiFM in '..\Copy\WC003URicercaDatiFM.pas' {WC003FRicercaDatiFM: TFrame},
  WA071URegoleBuoniDM in 'WA071URegoleBuoniDM.pas' {WA071FRegoleBuoniDM: TIWUserSessionBase},
  WC013UCheckListFM in '..\Copy\WC013UCheckListFM.pas' {WC013FCheckListFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR206FMenuFM: TFrame},
  WC700USelezioneAnagrafeFM in '..\Copy\WC700USelezioneAnagrafeFM.pas' {WC700FSelezioneAnagrafeFM: TFrame},
  WC700USelezioneAnagrafeDM in '..\Copy\WC700USelezioneAnagrafeDM.pas' {WC700FSelezioneAnagrafeDM: TIWUserSessionBase},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
