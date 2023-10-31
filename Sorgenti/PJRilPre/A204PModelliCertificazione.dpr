program A204PModelliCertificazione;

uses
  Vcl.Forms,
  OracleMonitor,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  A204UModelliCertificazione in 'A204UModelliCertificazione.pas' {A204FModelliCertificazione},
  A204UModelliCertificazioneDtM in 'A204UModelliCertificazioneDtM.pas' {A204FModelliCertificazioneDtM: TDataModule},
  A204UModelliCertificazioneMW in '..\MWRilPre\A204UModelliCertificazioneMW.pas' {A204FModelliCertificazioneMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA204FModelliCertificazione, A204FModelliCertificazione);
  Application.Run;
end.
