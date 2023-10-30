program B027PCartellinoVcl;

uses
  Vcl.Forms,
  B027UCartellinoVcl in 'B027UCartellinoVcl.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
