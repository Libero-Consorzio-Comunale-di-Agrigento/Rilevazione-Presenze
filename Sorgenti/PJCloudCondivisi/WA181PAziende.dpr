program WA181PAziende;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
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
  WA181UAziende in 'WA181UAziende.pas' {WA181FAziende: TIWAppForm},
  WA181UAziendeBrowseFM in 'WA181UAziendeBrowseFM.pas' {WA181FAziendeBrowseFM: TFrame},
  WA181UAziendeDettFM in 'WA181UAziendeDettFM.pas' {WA181FAziendeDettFM: TFrame},
  WA181UAziendeDM in 'WA181UAziendeDM.pas' {WA181FAziendeDM: TIWUserSessionBase},
  WA181ULogin in 'WA181ULogin.pas' {WA181FLogin: TIWAppForm},
  WC013UCheckListFM in '..\Copy\WC013UCheckListFM.pas' {WC013FCheckListFM: TFrame},
  WC011UListboxFM in '..\Copy\WC011UListboxFM.pas' {WC011FListboxFM: TFrame},
  WC010UMemoEditFM in '..\Copy\WC010UMemoEditFM.pas' {WC010FMemoEditFM: TFrame},
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  A181UAziendeMW in '..\MWRilPre\A181UAziendeMW.pas' {A181FAziendeMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
