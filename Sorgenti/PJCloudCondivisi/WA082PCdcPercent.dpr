program WA082PCdcPercent;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA082ULogin in 'WA082ULogin.pas' {WA082FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WA082UCdcPercent in 'WA082UCdcPercent.pas' {WA082FCdcPercent: TIWAppForm},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA082UCdcPercentDM in 'WA082UCdcPercentDM.pas' {WA082FCdcPercentDM: TIWUserSessionBase},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WA082UCdcPercentBrowseFM in 'WA082UCdcPercentBrowseFM.pas' {WA082FCdcPercentBrowseFM: TFrame},
  WC700USelezioneAnagrafeFM in '..\Copy\WC700USelezioneAnagrafeFM.pas' {WC700FSelezioneAnagrafeFM: TFrame},
  WC700USelezioneAnagrafeDM in '..\Copy\WC700USelezioneAnagrafeDM.pas' {WC700FSelezioneAnagrafeDM: TIWUserSessionBase},
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  A000USessione in '..\Copy\A000USessione.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A082UCdcPercentMW in '..\MWRilPre\A082UCdcPercentMW.pas' {A082FCdcPercentMW: TDataModule},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame},
  WC502UMenuRilPreFM in '..\Copy\WC502UMenuRilPreFM.pas' {WC502FMenuRilPreFM: TFrame};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
