program A084PTipoRapporto;

uses
  Forms,
  A084UTipoRapportoDtM1 in 'A084UTipoRapportoDtM1.pas' {A084FTipoRapportoDtM1: TDataModule},
  A084UTipoRapporto in 'A084UTipoRapporto.pas' {A084FTipoRapporto},
  R001UGestTab in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA084FTipoRapporto, A084FTipoRapporto);
  Application.CreateForm(TA084FTipoRapportoDtM1, A084FTipoRapportoDtM1);
  Application.Run;
end.
