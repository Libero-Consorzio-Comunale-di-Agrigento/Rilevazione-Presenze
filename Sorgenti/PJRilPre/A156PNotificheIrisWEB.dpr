program A156PNotificheIrisWEB;

uses
  Vcl.Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A156UNotificheIrisWEB in 'A156UNotificheIrisWEB.pas' {A156F},
  A156UNotificheIrisWEBDtM in 'A156UNotificheIrisWEBDtM.pas' {A156FNotificheIrisWEBDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A156UNotificheIrisWEBMW in '..\MWRilPre\A156UNotificheIrisWEBMW.pas' {A156FNotificheIrisWEBMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA156FNotificheIrisWEB, A156FNotificheIrisWEB);
  Application.CreateForm(TA156FNotificheIrisWEBDtM, A156FNotificheIrisWEBDtM);
  Application.Run;
end.
