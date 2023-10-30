program B025PPubblDoc2GestDoc;

uses
  Vcl.Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  B025UPubblDoc2GestDoc in 'B025UPubblDoc2GestDoc.pas' {B025FPubblDoc2GestDoc},
  A118UPubblicazioneDocumentiMW in '..\MWRilPre\A118UPubblicazioneDocumentiMW.pas' {A118FPubblicazioneDocumentiMW: TDataModule},
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  B025UPubblDoc2GestDocDM in 'B025UPubblDoc2GestDocDM.pas' {B025FPubblDoc2GestDocDM: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TB025FPubblDoc2GestDoc, B025FPubblDoc2GestDoc);
  Application.CreateForm(TB025FPubblDoc2GestDocDM, B025FPubblDoc2GestDocDM);
  Application.Run;
end.
