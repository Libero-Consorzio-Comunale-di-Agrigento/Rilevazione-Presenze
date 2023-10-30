program WA005PDatiLiberi;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  WA005UDatiLiberi in 'WA005UDatiLiberi.pas' {WA005FDatiLiberi: TIWAppForm},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WA005ULogin in 'WA005ULogin.pas' {WA005FLogin: TIWAppForm},
  WA005UDatiLiberiDM in 'WA005UDatiLiberiDM.pas' {WA005FDatiLiberiDM: TIWUserSessionBase},
  WA005UDatiLiberiBrowseFM in 'WA005UDatiLiberiBrowseFM.pas' {WA005FDatiLiberiBrowseFM: TFrame},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WC004UEstrazioneDatiFM in '..\Copy\WC004UEstrazioneDatiFM.pas' {WC004FEstrazioneDatiFM: TFrame},
  WC003URicercaDatiFM in '..\Copy\WC003URicercaDatiFM.pas' {WC003FRicercaDatiFM: TFrame},
  A000UIrisWebDM in '..\Copy\A000UIrisWebDM.pas' {A000FIrisWebDM: TDataModule},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WC009UCopiaSuFM in '..\Copy\WC009UCopiaSuFM.pas' {WC009FCopiaSuFM: TFrame},
  WC010UMemoEditFM in '..\Copy\WC010UMemoEditFM.pas' {WC010FMemoEditFM: TFrame},
  WC011UListBoxFM in '..\Copy\WC011UListBoxFM.pas' {WC011FListboxFM: TFrame},
  WC012UVisualizzaFileFM in '..\Copy\WC012UVisualizzaFileFM.pas' {WC012FVisualizzaFileFM: TFrame},
  WC013UCheckListFM in '..\Copy\WC013UCheckListFM.pas' {WC013FCheckListFM: TFrame},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm};

{$R *.res}
begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
