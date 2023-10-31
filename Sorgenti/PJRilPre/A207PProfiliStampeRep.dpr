program A207PProfiliStampeRep;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A207UProfiliStampeRepDTM in 'A207UProfiliStampeRepDTM.pas' {A207FProfiliStampeRepDTM: TDataModule},
  A207UProfiliStampeRep in 'A207UProfiliStampeRep.pas' {A207FProfiliStampeRep},
  A040UPianifRepMW in '..\MWRilPre\A040UPianifRepMW.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA207FProfiliStampeRep, A207FProfiliStampeRep);
  Application.Run;
end.

