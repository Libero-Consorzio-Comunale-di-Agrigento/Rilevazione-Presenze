program B026PArchiviazioneCartelliniSrv;

{$ifdef DEBUG}
  {$APPTYPE CONSOLE}
{$endif}

uses
  SvcMgr,
  MidasLib,
  System.SysUtils,
  B026UArchiviazioneCartelliniSrv in 'B026UArchiviazioneCartelliniSrv.pas' {B026FArchiviazioneCartelliniSrv: TService},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A159UArchiviazioneCartellini in '..\PJRilPre\A159UArchiviazioneCartellini.pas' {A159FArchiviazioneCartellini};

{$R *.RES}
var
  MyDummyBoolean: Boolean;

begin
  {$ifdef DEBUG}
  try
    // In debug mode the server acts as a console application.
    WriteLn('B026FArchiviazioneCartelliniSrv DEBUG mode. Press enter to exit.');

    // Create the TService descendant manually.
    B026FArchiviazioneCartelliniSrv:=TB026FArchiviazioneCartelliniSrv.Create(nil);

    // Simulate service start.
    B026FArchiviazioneCartelliniSrv.ServiceStart(B026FArchiviazioneCartelliniSrv, MyDummyBoolean);
    B026FArchiviazioneCartelliniSrv.ServiceExecute(B026FArchiviazioneCartelliniSrv);

    // Keep the console box running (B026FArchiviazioneCartelliniSrv code runs in the background)
    ReadLn;

    // On exit, destroy the service object.
    FreeAndNil(B026FArchiviazioneCartelliniSrv);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      WriteLn('Press enter to exit.');
      ReadLn;
    end;
  end;
  {$else}
  Application.Initialize;
  Application.CreateForm(TB026FArchiviazioneCartelliniSrv, B026FArchiviazioneCartelliniSrv);
  Application.Run;
  {$endif}
end.
