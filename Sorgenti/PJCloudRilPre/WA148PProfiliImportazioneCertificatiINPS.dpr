program WA148PProfiliImportazioneCertificatiINPS;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
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
  WA148ULogin in 'WA148ULogin.pas' {WA148FLogin: TIWAppForm},
  WA148UProfiliImportazioneCertificatiINPSDM in 'WA148UProfiliImportazioneCertificatiINPSDM.pas' {WA148FProfiliImportazioneCertificatiINPSDM: TIWUserSessionBase},
  WA148UProfiliImportazioneCertificatiINPS in 'WA148UProfiliImportazioneCertificatiINPS.pas' {WA148FProfiliImportazioneCertificatiINPS: TIWAppForm},
  WA148UProfiliImportazioneCertificatiINPSBrowseFM in 'WA148UProfiliImportazioneCertificatiINPSBrowseFM.pas' {WA148FProfiliImportazioneCertificatiINPSBrowseFM: TFrame},
  A148UProfiliImportazioneCertificatiINPSMW in '..\MWRilPre\A148UProfiliImportazioneCertificatiINPSMW.pas' {A148FProfiliImportazioneCertificatiINPSMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
