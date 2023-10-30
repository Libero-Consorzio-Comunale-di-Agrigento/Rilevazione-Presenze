library WA071PRegoleBuoni_IIS;

uses
  ISAPIApp,
  IWInitISAPI,
  ISAPIThreadPool,
  DBClient,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WC003URicercaDatiFM in '..\Copy\WC003URicercaDatiFM.pas' {WC003FRicercaDatiFM: TFrame},
  WC004UEstrazioneDatiFM in '..\Copy\WC004UEstrazioneDatiFM.pas' {WC004FEstrazioneDatiFM: TFrame},
  WC005UMenuRilPreFM in '..\Copy\WC005UMenuRilPreFM.pas' {WC005FMenuRilPreFM: TFrame},
  WC009UCopiaSuFM in '..\Copy\WC009UCopiaSuFM.pas' {WC009FCopiaSuFM: TFrame},
  WC011UListboxFM in '..\Copy\WC011UListboxFM.pas' {WC011FListboxFM: TFrame},
  WC700USelezioneAnagrafeDM in '..\Copy\WC700USelezioneAnagrafeDM.pas' {WC700FSelezioneAnagrafeDM: TIWUserSessionBase},
  WC700USelezioneAnagrafeFM in '..\Copy\WC700USelezioneAnagrafeFM.pas' {WC700FSelezioneAnagrafeFM: TFrame},
  WA071ULogin in 'WA071ULogin.pas' {WA071FLogin: TIWAppForm},
  WA071URegoleBuoni in 'WA071URegoleBuoni.pas' {WA071FRegoleBuoni: TIWAppForm},
  WA071URegoleBuoniBrowseFM in 'WA071URegoleBuoniBrowseFM.pas' {WA071FRegoleBuoniBrowseFM: TFrame},
  WA071URegoleBuoniDettFM in 'WA071URegoleBuoniDettFM.pas' {WA071FRegoleBuoniDettFM: TFrame},
  WA071URegoleBuoniDM in 'WA071URegoleBuoniDM.pas' {WA071FRegoleBuoniDM: TIWUserSessionBase};

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  IWRun;
end.

