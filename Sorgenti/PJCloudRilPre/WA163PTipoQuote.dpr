program WA163PTipoQuote;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A163UTipoQuoteMW in '..\MWRilPre\A163UTipoQuoteMW.pas' {A163FTipoQuoteMW: TDataModule},
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
  WA163ULogin in 'WA163ULogin.pas' {WA163FLogin: TIWAppForm},
  WA163UTipoQuoteDM in 'WA163UTipoQuoteDM.pas' {WA163FTipoQuoteDM: TIWUserSessionBase},
  WA163UTipoQuote in 'WA163UTipoQuote.pas' {WA163FTipoQuote: TIWAppForm},
  WA163UTipoQuoteBrowseFM in 'WA163UTipoQuoteBrowseFM.pas' {WA163FTipoQuoteBrowseFM: TFrame},
  WA163UTipoQuoteDettFM in 'WA163UTipoQuoteDettFM.pas' {WA163FTipoQuoteDettFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin

  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
