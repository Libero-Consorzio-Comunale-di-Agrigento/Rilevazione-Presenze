program A203PDatiMensiliPersonalizzati;

uses
  Vcl.Forms,
  OracleMonitor,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A203UDatiMensiliPersonalizzati in 'A203UDatiMensiliPersonalizzati.pas' {A203FDatiMensiliPersonalizzati},
  A203UDatiMensiliPersonalizzatiDtM in 'A203UDatiMensiliPersonalizzatiDtM.pas' {A203FDatiMensiliPersonalizzatiDtM: TDataModule},
  A203UDatiMensiliPersonalizzatiMW in '..\MWRilPre\A203UDatiMensiliPersonalizzatiMW.pas' {A203FDatiMensiliPersonalizzatiMW: TDataModule},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  //ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA203FDatiMensiliPersonalizzati, A203FDatiMensiliPersonalizzati);
    Application.Run;
end.
