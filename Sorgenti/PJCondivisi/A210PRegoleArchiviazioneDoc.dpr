program A210PRegoleArchiviazioneDoc;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A210URegoleArchiviazioneDoc in 'A210URegoleArchiviazioneDoc.pas' {A210FRegoleArchiviazioneDoc},
  A210URegoleArchiviazioneDocDtM in 'A210URegoleArchiviazioneDocDtM.pas' {A210FRegoleArchiviazioneDocDtM: TDataModule},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A210URegoleArchiviazioneDocMW in '..\MWCondivisi\A210URegoleArchiviazioneDocMW.pas' {A210FRegoleArchiviazioneDocMW: TDataModule},
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA210FRegoleArchiviazioneDoc, A210FRegoleArchiviazioneDoc);
  Application.CreateForm(TA210FRegoleArchiviazioneDocDtM, A210FRegoleArchiviazioneDocDtM);
  Application.Run;
end.
