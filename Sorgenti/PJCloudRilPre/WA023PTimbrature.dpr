program WA023PTimbrature;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA023ULogin in 'WA023ULogin.pas' {WA023FLogin: TIWAppForm},
  WA023UTimbrature in 'WA023UTimbrature.pas' {WA023FTimbrature: TIWAppForm},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WA023UTimbratureDM in 'WA023UTimbratureDM.pas' {WA023FTimbratureDM: TIWUserSessionBase},
  A023UTimbratureMW in '..\MWRilPre\A023UTimbratureMW.pas' {A023FTimbratureMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  L021Call in '..\Copy\L021Call.pas',
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR208UGestTimbFM in '..\Repositary\WR208UGestTimbFM.pas' {WR208FGestTimbFM: TFrame},
  WA023UGestGiustFM in 'WA023UGestGiustFM.pas' {WA023FGestGiustFM: TFrame},
  WC010UMemoEditFM in '..\Copy\WC010UMemoEditFM.pas' {WC010FMemoEditFM: TFrame},
  WC021URiepilogoAssenzeFM in '..\Copy\WC021URiepilogoAssenzeFM.pas' {WC021FRiepilogoAssenzeFM: TFrame},
  WA023URipristinoTimbOrigFM in 'WA023URipristinoTimbOrigFM.pas' {WA023FRipristinoTimbOrigFM: TFrame},
  WC020UInputDataOreFM in '..\Copy\WC020UInputDataOreFM.pas' {WC020FInputDataOreFM: TFrame},
  WA023UValidaAssenzeFM in 'WA023UValidaAssenzeFM.pas' {WA023FValidaAssenzeFM: TFrame},
  WA023UAllTimbUgualiFM in 'WA023UAllTimbUgualiFM.pas' {WA023FAllTimbUgualiFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A023UAllTimbMW in '..\MWRilPre\A023UAllTimbMW.pas' {A023FAllTimbMW: TDataModule},
  WR104UGestCartellino in '..\Repositary\WR104UGestCartellino.pas' {WR104FGestCartellino: TIWAppForm},
  WC024ULegendaFM in '..\Copy\WC024ULegendaFM.pas' {WC024FLegendaFM: TFrame},
  WA023UGestTimbFM in 'WA023UGestTimbFM.pas' {WA023FGestTimbFM: TFrame},
  WC027UInfoDatiFM in '..\Copy\WC027UInfoDatiFM.pas' {WC027FInfoDatiFM: TFrame},
  A087UImpAttestatiMalMW in '..\MWRilPre\A087UImpAttestatiMalMW.pas' {A087FImpAttestatiMalMW: TDataModule},
  A093UOperazioniMW in '..\MWRilPre\A093UOperazioniMW.pas' {A093FOperazioniMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
