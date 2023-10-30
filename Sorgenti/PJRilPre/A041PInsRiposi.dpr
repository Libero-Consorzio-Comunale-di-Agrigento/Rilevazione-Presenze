program A041PInsRiposi;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  OracleMonitor,
  A041UInsRiposiDtM1 in 'A041UInsRiposiDtM1.pas' {A041FInsRiposiDtM1: TDataModule},
  A041UInsRiposi in 'A041UInsRiposi.pas' {A041FInsRiposi},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A041UInsRiposiMW in '..\MWRilPre\A041UInsRiposiMW.pas' {A041FInsRiposiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'C:\Iris_Delphi\Help\Iris.hlp';
  Application.CreateForm(TA041FInsRiposi, A041FInsRiposi);
  Application.CreateForm(TA041FInsRiposiDtM1, A041FInsRiposiDtM1);
  Application.Run;
end.
