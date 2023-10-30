program WA009PProfAsseAnn;

uses
  IWStart,
  UTF8ContentParser,
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WA009UProfAsseAnn in 'WA009UProfAsseAnn.pas' {WA009FProfAsseAnn: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA009ULogin in 'WA009ULogin.pas' {WA009FLogin: TIWAppForm},
  WA009UProfAsseAnnDM in 'WA009UProfAsseAnnDM.pas' {WA009FProfAsseAnnDM: TIWUserSessionBase},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WC003URicercaDatiFM in '..\Copy\WC003URicercaDatiFM.pas' {WC003FRicercaDatiFM: TFrame},
  WC004UEstrazioneDatiFM in '..\Copy\WC004UEstrazioneDatiFM.pas' {WC004FEstrazioneDatiFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WA009UProfAsseAnnBrowseFM in 'WA009UProfAsseAnnBrowseFM.pas' {WA009FProfAsseAnnBrowseFM: TFrame},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WA009UProfAsseAnnDettFM in 'WA009UProfAsseAnnDettFM.pas' {WA009FProfAsseAnnDettFM: TFrame},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WA009UProfiliAssenzeFM in 'WA009UProfiliAssenzeFM.pas' {WA009FProfiliAssenzeFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
