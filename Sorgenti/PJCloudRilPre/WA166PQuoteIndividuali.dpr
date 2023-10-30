program WA166PQuoteIndividuali;

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
  WA166ULogin in 'WA166ULogin.pas' {WA166FLogin: TIWAppForm},
  WA166UQuoteIndividualiDM in 'WA166UQuoteIndividualiDM.pas' {WA166FQuoteIndividualiDM: TIWUserSessionBase},
  WA166UQuoteIndividuali in 'WA166UQuoteIndividuali.pas' {WA166FQuoteIndividuali: TIWAppForm},
  WA166UQuoteIndividualiBrowseFM in 'WA166UQuoteIndividualiBrowseFM.pas' {WA166FQuoteIndividualiBrowseFM: TFrame},
  WA166UQuoteIndividualiDettFM in 'WA166UQuoteIndividualiDettFM.pas' {WA166FQuoteIndividualiDettFM: TFrame},
  A166UQuoteIndividualiMW in '..\MWRilPre\A166UQuoteIndividualiMW.pas' {A166FQuoteIndividualiMW: TDataModule},
  WA166UAcquisizioneFM in 'WA166UAcquisizioneFM.pas' {WA166FAcquisizioneFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
