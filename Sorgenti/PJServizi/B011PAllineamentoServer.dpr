program B011PAllineamentoServer;



uses
  Forms,
  B011UAllineamentoServer in 'B011UAllineamentoServer.pas' {B011FAllineamentoServer};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB011FAllineamentoServer, B011FAllineamentoServer);
  Application.Run;
end.
