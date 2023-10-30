program B001PMigrazione;

uses
  Forms,
  B001UMigrazione in 'B001UMigrazione.pas' {Form1},
  B001UTableSpace in 'B001UTableSpace.pas' {B001FTableSpace};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TB001FTableSpace, B001FTableSpace);
  Application.Run;
end.
