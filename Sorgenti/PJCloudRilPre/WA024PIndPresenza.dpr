program WA024PIndPresenza;

uses
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WA024ULogin in 'WA024ULogin.pas' {WA024FLogin: TIWAppForm},
  WA024UIndPresenzaDM in 'WA024UIndPresenzaDM.pas' {WA024FIndPresenzaDM: TIWUserSessionBase},
  WA024UIndPresenzaBrowseFM in 'WA024UIndPresenzaBrowseFM.pas' {WA024FIndPresenzaBrowseFM: TFrame},
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
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WA024UIndPresenza in 'WA024UIndPresenza.pas' {WA024FIndPresenza: TIWAppForm},
  WC011UListboxFM in '..\Copy\WC011UListboxFM.pas' {WC011FListboxFM: TFrame},
  A000USessione in '..\Copy\A000USessione.pas',
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA024UIndPresenzaIndennitaFM in 'WA024UIndPresenzaIndennitaFM.pas' {WA024FIndPresenzaIndennitaFM: TFrame},
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0); // daniloc.
  TIWStart.Execute(True);
end.
