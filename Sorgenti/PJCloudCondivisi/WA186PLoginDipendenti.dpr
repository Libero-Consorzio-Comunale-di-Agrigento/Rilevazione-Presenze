program WA186PLoginDipendenti;

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
  WA186ULoginDipendenti in 'WA186ULoginDipendenti.pas' {WA186FLoginDipendenti: TIWAppForm},
  WA186ULoginDipendentiBrowseFM in 'WA186ULoginDipendentiBrowseFM.pas' {WA186FLoginDipendentiBrowseFM: TFrame},
  WA186ULoginDipendentiDM in 'WA186ULoginDipendentiDM.pas' {WA186FLoginDipendentiDM: TIWUserSessionBase},
  WA186ULogin in 'WA186ULogin.pas' {WA186FLogin: TIWAppForm},
  WC009UCopiaSuFM in '..\Copy\WC009UCopiaSuFM.pas' {WC009FCopiaSuFM: TFrame},
  WC010UMemoEditFM in '..\Copy\WC010UMemoEditFM.pas' {WC010FMemoEditFM: TFrame},
  WA186ULoginDipendentiCambioPasswordFM in 'WA186ULoginDipendentiCambioPasswordFM.pas' {WA186FLoginDipendentiCambioPasswordFM: TFrame},
  WC700USelezioneAnagrafeDM in '..\Copy\WC700USelezioneAnagrafeDM.pas' {WC700FSelezioneAnagrafeDM: TIWUserSessionBase},
  WC700USelezioneAnagrafeFM in '..\Copy\WC700USelezioneAnagrafeFM.pas' {WC700FSelezioneAnagrafeFM: TFrame},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA186ULoginDipendentiProfiliFM in 'WA186ULoginDipendentiProfiliFM.pas' {WA186FLoginDipendentiProfiliFM: TFrame},
  WC011UListBoxFM in '..\Copy\WC011UListBoxFM.pas' {WC011FListboxFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
