program B028PPrintServer_COM;

uses
  {$IFDEF DEBUG}
  OracleMonitor,
  {$ENDIF DEBUG}
  Forms,
  MidasLib,
  B028PPrintServer_COM_TLB in 'B028PPrintServer_COM_TLB.pas',
  B028UPrintServerDM in 'B028UPrintServerDM.pas' {B028PrintServer: TRemoteDataModule} {B028PrintServer: CoClass},
  B028UPRovastampa in 'B028UPRovastampa.pas' {B028FProvaStampa},
  B028UTest in 'B028UTest.pas' {B028FTest},
  B028UTestDM in 'B028UTestDM.pas' {B028FTestDM: TDataModule};

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB028FTest, B028FTest);
  Application.CreateForm(TB028FTestDM, B028FTestDM);
  Application.Run;
end.
