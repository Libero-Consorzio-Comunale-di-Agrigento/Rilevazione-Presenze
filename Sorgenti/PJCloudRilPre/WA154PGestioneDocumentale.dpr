program WA154PGestioneDocumentale;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A154UGestioneDocumentaleMW in '..\MWRilPre\A154UGestioneDocumentaleMW.pas' {A154FGestioneDocumentaleMW: TDataModule},
  WA154ULogin in 'WA154ULogin.pas' {WA154FLogin: TIWAppForm},
  WA154UGestioneDocumentaleDM in 'WA154UGestioneDocumentaleDM.pas' {WA154FGestioneDocumentaleDM: TIWUserSessionBase},
  WA154UGestioneDocumentale in 'WA154UGestioneDocumentale.pas' {WA154FGestioneDocumentale: TIWAppForm},
  WA154UGestioneDocumentaleBrowseFM in 'WA154UGestioneDocumentaleBrowseFM.pas' {WA154FGestioneDocumentaleBrowseFM: TFrame},
  WA154UGestioneDocumentaleDettFM in 'WA154UGestioneDocumentaleDettFM.pas' {WA154FGestioneDocumentaleDettFM: TFrame},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  L021Call in '..\Copy\L021Call.pas',
  WC015USelEditGridFM in '..\Copy\WC015USelEditGridFM.pas' {WC015FSelEditGridFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
