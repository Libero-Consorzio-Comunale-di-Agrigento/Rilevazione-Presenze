program WA136PRelazioniAnagrafe;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  L021Call in '..\Copy\L021Call.pas',
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA136UComponiRelazioneFM in 'WA136UComponiRelazioneFM.pas' {WA136FComponiRelazioneFM: TFrame},
  WA136URelazioniAnagrafe in 'WA136URelazioniAnagrafe.pas' {WA136FRelazioniAnagrafe: TIWAppForm},
  WA136URelazioniAnagrafeBrowseFM in 'WA136URelazioniAnagrafeBrowseFM.pas' {WA136FRelazioniAnagrafeBrowseFM: TFrame},
  WA136URelazioniAnagrafeDettFM in 'WA136URelazioniAnagrafeDettFM.pas' {WA136FRelazioniAnagrafeDettFM: TFrame},
  WA136URelazioniAnagrafeDM in 'WA136URelazioniAnagrafeDM.pas' {WA136FRelazioniAnagrafeDM: TIWUserSessionBase},
  WA136URelazioniAnagrafeLogin in 'WA136URelazioniAnagrafeLogin.pas' {WA136FRelazioniAnagrafeLogin: TIWAppForm},
  WA136UStampaRelazioniFM in 'WA136UStampaRelazioniFM.pas' {WA136FStampaRelazioniFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A136UComposizioneRelazioneMW in '..\MWRilPre\A136UComposizioneRelazioneMW.pas' {A136FComposizioneRelazioneMW: TDataModule},
  A136URelazioniAnagrafeMW in '..\MWRilPre\A136URelazioniAnagrafeMW.pas' {A136FRelazioniAnagrafeMW: TDataModule};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
