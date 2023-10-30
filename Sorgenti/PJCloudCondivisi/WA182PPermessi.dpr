program WA182PPermessi;

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
  WA182UPermessi in 'WA182UPermessi.pas' {WA182FPermessi: TIWAppForm},
  WA182UPermessiBrowseFM in 'WA182UPermessiBrowseFM.pas' {WA182FPermessiBrowseFM: TFrame},
  WA182UPermessiDettFM in 'WA182UPermessiDettFM.pas' {WA182FPermessiDettFM: TFrame},
  WA182UPermessiDM in 'WA182UPermessiDM.pas' {WA182FPermessiDM: TIWUserSessionBase},
  WA182ULogin in 'WA182ULogin.pas' {WA182FLogin: TIWAppForm},
  WC013UCheckListFM in '..\Copy\WC013UCheckListFM.pas' {WC013FCheckListFM: TFrame},
  WC011UListboxFM in '..\Copy\WC011UListboxFM.pas' {WC011FListboxFM: TFrame},
  WC009UCopiaSuFM in '..\Copy\WC009UCopiaSuFM.pas' {WC009FCopiaSuFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
