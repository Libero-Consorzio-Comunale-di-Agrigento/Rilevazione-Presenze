program PCalcolatriceW95;

uses
  Forms,
  UCalcolatrice in 'UCalcolatrice.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
