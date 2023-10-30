program WA089PRegIndPresenza;

uses
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WA089ULogin in 'WA089ULogin.pas' {WA089FLogin: TIWAppForm},
  WA089URegIndPresenzaDM in 'WA089URegIndPresenzaDM.pas' {WA089FRegIndPresenzaDM: TIWUserSessionBase},
  WA089URegIndPresenzaBrowseFM in 'WA089URegIndPresenzaBrowseFM.pas' {WA089FRegIndPresenzaBrowseFM: TFrame},
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
  WA089URegIndPresenza in 'WA089URegIndPresenza.pas' {WA089FRegIndPresenza: TIWAppForm},
  A000USessione in '..\Copy\A000USessione.pas',
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA089URegIndPresenzaRegoleFM in 'WA089URegIndPresenzaRegoleFM.pas' {WA089FRegIndPresenzaRegoleFM: TFrame},
  WC013UCheckListFM in '..\Copy\WC013UCheckListFM.pas' {WC013FCheckListFM: TFrame},
  WA089URegIndPresenzaDettFM in 'WA089URegIndPresenzaDettFM.pas' {WA089FRegIndPresenzaDettFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA089URegIndPresenzaRegMaturazioneFM in 'WA089URegIndPresenzaRegMaturazioneFM.pas' {WA089FRegIndPresenzaRegMaturazioneFM: TFrame},
  C190FunzioniGeneraliWeb in '..\Copy\C190FunzioniGeneraliWeb.pas',
  A024UIndPresenzaMW in '..\MWRilPre\A024UIndPresenzaMW.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0); // daniloc.
  TIWStart.Execute(True);
end.
