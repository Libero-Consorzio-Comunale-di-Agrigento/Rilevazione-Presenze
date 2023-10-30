program B110PWSMobile;
{$APPTYPE GUI}



uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  {$IFDEF DEBUG}
  OracleMonitor,
  {$ENDIF DEBUG}
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  R015UDatasnapRestDM in '..\Repositary\R015UDatasnapRestDM.pas' {R015FDatasnapRestDM: TDataModule},
  A001UPassWordDtM1 in '..\PJCondivisi\A001UPassWordDtM1.pas' {A001FPassWordDtM1: TDataModule},
  C200UWebServicesUtils in '..\Copy\C200UWebServicesUtils.pas',
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas',
  A000USessione in '..\Copy\A000USessione.pas',
  B110UUtils in 'B110UUtils.pas',
  R016UDatasnapRestRichiesteDM in '..\Repositary\R016UDatasnapRestRichiesteDM.pas' {R016FDatasnapRestRichiesteDM: TDataModule},
  B110UStampaCartellinoDM in 'B110UStampaCartellinoDM.pas' {B110FStampaCartellinoDM: TDataModule},
  B110UForm in 'B110UForm.pas' {B110FForm},
  B110UServerMethodsDM in 'B110UServerMethodsDM.pas' {B110FServerMethodsDM: TDataModule},
  B110UInfoServerDM in 'B110UInfoServerDM.pas' {B110FInfoServerDM: TDataModule},
  B110UWebModule in 'B110UWebModule.pas' {B110FWebModule: TWebModule},
  B110USharedTypes in 'B110USharedTypes.pas',
  B110UStampaCedolinoDM in 'B110UStampaCedolinoDM.pas' {B110FStampaCedolinoDM: TDataModule},
  C200UWebServicesServerUtils in '..\Copy\C200UWebServicesServerUtils.pas',
  W017UStampaCedolinoDM in '..\PJIrisWEB\W017UStampaCedolinoDM.pas' {W017FStampaCedolinoDM: TDataModule},
  B110UAutenticazioneDM in 'B110UAutenticazioneDM.pas' {B110FAutenticazioneDM: TDataModule},
  B110UWebServiceEnteDM in 'B110UWebServiceEnteDM.pas' {B110FWebServiceEnteDM: TDataModule},
  B110UCartelliniDM in 'B110UCartelliniDM.pas' {B110FCartelliniDM: TDataModule},
  B110UConsegnaCedoliniDM in 'B110UConsegnaCedoliniDM.pas' {B110FConsegnaCedoliniDM: TDataModule},
  R017UDatasnapRestAutRichiesteDM in '..\Repositary\R017UDatasnapRestAutRichiesteDM.pas' {R017FDatasnapRestAutRichiesteDM: TDataModule},
  B110UDatiGeneraliDM in 'B110UDatiGeneraliDM.pas' {B110FDatiGeneraliDM: TDataModule},
  C200UWebServicesTypes in '..\Copy\C200UWebServicesTypes.pas',
  W009UStampaCartellinoDtm in '..\MWRilPre\W009UStampaCartellinoDtm.pas' {W009FStampaCartellinoDtm: TDataModule},
  W010URichiestaAssenzeDM in '..\PJIrisWEB\W010URichiestaAssenzeDM.pas' {W010FRichiestaAssenzeDM: TDataModule},
  W018URichiestaTimbratureDM in '..\PJIrisWEB\W018URichiestaTimbratureDM.pas' {W018FRichiestaTimbratureDM: TDataModule},
  C018UIterAutDM in '..\Copy\C018UIterAutDM.pas' {C018FIterAutDM: TDataModule},
  B110URiepilogoAssenzeDM in 'B110URiepilogoAssenzeDM.pas' {B110FRiepilogoAssenzeDM: TDataModule},
  B110UNoteRichiestaDM in 'B110UNoteRichiestaDM.pas' {B110FNoteRichiestaDM: TDataModule},
  B110URichiesteGiustDM in 'B110URichiesteGiustDM.pas' {B110FRichiesteGiustDM: TDataModule},
  B110URichiesteTimbDM in 'B110URichiesteTimbDM.pas' {B110FRichiesteTimbDM: TDataModule},
  B110UAutorizzazioneRichiesteGiustDM in 'B110UAutorizzazioneRichiesteGiustDM.pas' {B110FAutorizzazioneRichiesteGiustDM: TDataModule},
  B110UAutorizzazioneRichiesteTimbDM in 'B110UAutorizzazioneRichiesteTimbDM.pas' {B110FAutorizzazioneRichiesteTimbDM: TDataModule},
  B110USharedUtils in 'B110USharedUtils.pas',
  B110UDatiGiornalieriDM in 'B110UDatiGiornalieriDM.pas' {B110FDatiGiornalieriDM: TDataModule},
  B110UElencoDipendentiDM in 'B110UElencoDipendentiDM.pas' {B110FElencoDipendentiDM: TDataModule},
  A000Versione in '..\Copy\A000Versione.pas',
  B110UCedoliniDM in 'B110UCedoliniDM.pas' {B110FCedoliniDM: TDataModule},
  B110URichiesteGiustDipDM in 'B110URichiesteGiustDipDM.pas' {B110FRichiesteGiustDipDM: TDataModule},
  B110UInsRichiestaGiustDM in 'B110UInsRichiestaGiustDM.pas' {B110FInsRichiestaGiustDM: TDataModule},
  R600 in '..\MWRilPre\R600.pas' {R600DtM1: TDataModule},
  FunzioniGenerali in '..\Copy\FunzioniGenerali.pas',
  B110URichiesteTimbDipDM in 'B110URichiesteTimbDipDM.pas' {B110FRichiesteTimbDipDM: TDataModule},
  B110UTimbModificabiliDM in 'B110UTimbModificabiliDM.pas' {B110FTimbModificabiliDM: TDataModule},
  B110UInsRichiestaTimbDM in 'B110UInsRichiestaTimbDM.pas' {B110FInsRichiestaTimbDM: TDataModule},
  B110UCancRichiestaGiustDM in 'B110UCancRichiestaGiustDM.pas' {B110FCancRichiestaGiustDM: TDataModule},
  B110UCancRichiestaTimbDM in 'B110UCancRichiestaTimbDM.pas' {B110FCancRichiestaTimbDM: TDataModule},
  B110URevocaRichiestaGiustDM in 'B110URevocaRichiestaGiustDM.pas' {B110FRevocaRichiestaGiustDM: TDataModule},
  B110UTimbratureDM in 'B110UTimbratureDM.pas' {B110FTimbratureDM: TDataModule},
  B110UDizionarioDM in 'B110UDizionarioDM.pas' {B110FDizionarioDM: TDataModule},
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  B110UInsTimbraturaDM in 'B110UInsTimbraturaDM.pas' {con: TDataModule},
  B110UVersioneServerDM in 'B110UVersioneServerDM.pas' {B110FVersioneServerDM: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TB110FForm, B110FForm);
  Application.Run;
end.
