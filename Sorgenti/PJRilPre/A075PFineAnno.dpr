program A075PFineAnno;

uses
  {$IFDEF DEBUG}OracleMonitor,{$ENDIF DEBUG}
  Forms,
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A075UFineAnno in 'A075UFineAnno.pas' {A075FFineAnno},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A075UFineAnnoMW in '..\MWRilPre\A075UFineAnnoMW.pas' {A075FFineAnnoMW: TDataModule},
  A075UFineAnnoDtM1 in 'A075UFineAnnoDtM1.pas' {A075FFineAnnoDtM1: TDataModule};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA075FFineAnno, A075FFineAnno);
  Application.CreateForm(TA075FFineAnnoDtM1, A075FFineAnnoDtM1);
  Application.Run;
end.
