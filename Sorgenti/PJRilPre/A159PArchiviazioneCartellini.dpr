program A159PArchiviazioneCartellini;

uses
  Vcl.Forms,
  MidasLib,
  A159UArchiviazioneCartellini in 'A159UArchiviazioneCartellini.pas' {A159FArchiviazioneCartellini},
  C020UVisualizzaDataSet in '..\Copy\C020UVisualizzaDataSet.pas' {C020FVisualizzaDataSet},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  TABELLE99 in '..\Repositary\TABELLE99.pas' {FrmTabelle99: TDataModule},
  A159UArchiviazioneCartelliniMW in '..\MWRilPre\A159UArchiviazioneCartelliniMW.pas' {A159FArchiviazioneCartelliniMW: TDataModule},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA159FArchiviazioneCartellini, A159FArchiviazioneCartellini);
  Application.Run;
end.
