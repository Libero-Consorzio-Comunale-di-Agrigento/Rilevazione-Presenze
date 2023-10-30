program WA164PQuoteIncentivi;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA164ULogin in 'WA164ULogin.pas' {WA164FLogin: TIWAppForm},
  WA164UQuoteIncentiviDM in 'WA164UQuoteIncentiviDM.pas' {WA164FQuoteIncentiviDM: TIWUserSessionBase},
  WA164UQuoteIncentivi in 'WA164UQuoteIncentivi.pas' {WA164FQuoteIncentivi: TIWAppForm},
  WA164UQuoteIncentiviBrowseFM in 'WA164UQuoteIncentiviBrowseFM.pas' {WA164FQuoteIncentiviBrowseFM: TFrame},
  WA164UQuoteIncentiviDettFM in 'WA164UQuoteIncentiviDettFM.pas' {WA164FQuoteIncentiviDettFM: TFrame},
  A164UQuoteIncentiviMW in '..\MWRilPre\A164UQuoteIncentiviMW.pas' {A164FQuoteIncentiviMW: TDataModule},
  WA164UAggGlobaleFM in 'WA164UAggGlobaleFM.pas' {WA164FAggGlobaleFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  WR207UMenuWebPJFM in '..\Repositary\WR207UMenuWebPJFM.pas' {WR207FMenuWebPJFM: TFrame},
  WC502UMenuRilPreFM in '..\Copy\WC502UMenuRilPreFM.pas' {WC502FMenuRilPreFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
