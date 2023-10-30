program B020PTest;

uses
  Forms,
  B020UTest in 'B020UTest.pas' {Form1},
  IB020IrisWebSvcClnt in 'IB020IrisWebSvcClnt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
