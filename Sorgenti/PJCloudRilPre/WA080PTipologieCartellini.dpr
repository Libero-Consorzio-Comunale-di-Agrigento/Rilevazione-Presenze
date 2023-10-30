program WA080PTipologieCartellini;

uses
  IWStart,
  UTF8ContentParser,
  WA080UTipologieCartellini in 'WA080UTipologieCartellini.pas' {WA080FTipologieCartellini: TIWAppForm},
  WA080ULogin in 'WA080ULogin.pas' {WA080FLogin: TIWAppForm},
  WA080UTipologieCartelliniDM in 'WA080UTipologieCartelliniDM.pas' {WA080FTipologieCartelliniDM: TIWUserSessionBase},
  WC003URicercaDatiFM in '..\Copy\WC003URicercaDatiFM.pas' {WC003FRicercaDatiFM: TFrame},
  WC004UEstrazioneDatiFM in '..\Copy\WC004UEstrazioneDatiFM.pas' {WC004FEstrazioneDatiFM: TFrame},
  WA080UTipologieCartelliniBrowseFM in 'WA080UTipologieCartelliniBrowseFM.pas' {WA080FTipologieCartelliniBrowseFM: TFrame},
  WA080UTipologieCartelliniDettFM in 'WA080UTipologieCartelliniDettFM.pas' {WA080FTipologieCartelliniDettFM: TFrame},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WC013UCheckListFM in '..\Copy\WC013UCheckListFM.pas' {WC013FCheckListFM: TFrame},
  WC015USelEditGridFM in '..\Copy\WC015USelEditGridFM.pas' {WC015FSelEditGridFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WA080URientriObbligatoriDM in 'WA080URientriObbligatoriDM.pas' {WA080FRientriObbligatoriDM: TIWUserSessionBase},
  WA080URientriObbligatori in 'WA080URientriObbligatori.pas' {WA080FRientriObbligatori: TIWAppForm},
  WA080URientriObbligatoriBrowseFM in 'WA080URientriObbligatoriBrowseFM.pas' {WA080FRientriObbligatoriBrowseFM: TFrame},
  WC007UFormContainerFM in '..\Copy\WC007UFormContainerFM.pas' {WC007FFormContainerFM: TFrame},
  WA080USoglieStraordinario in 'WA080USoglieStraordinario.pas' {WA080FSoglieStraordinario: TIWAppForm},
  WA080USoglieStraordinarioDM in 'WA080USoglieStraordinarioDM.pas' {WA080FSoglieStraordinarioDM: TIWUserSessionBase},
  WA080USoglieStraordinarioBrowseFM in 'WA080USoglieStraordinarioBrowseFM.pas' {WA080FSoglieStraordinarioBrowseFM: TFrame},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA080USoglieStraordinarioOutputFM in 'WA080USoglieStraordinarioOutputFM.pas' {WA080FSoglieStraordinarioOutputFM: TFrame},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WC700USelezioneAnagrafeFM in '..\Copy\WC700USelezioneAnagrafeFM.pas' {WC700FSelezioneAnagrafeFM: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
