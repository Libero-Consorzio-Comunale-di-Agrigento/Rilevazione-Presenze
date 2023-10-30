program B006PScaricoService;

// scommentare per debug
//  {$APPTYPE CONSOLE}

uses
  System.SysUtils,
  SvcMgr,
  MidasLib,
  B006UScaricoService in 'B006UScaricoService.pas' {B006FScaricoService: TService},
  R200UScaricoTimbratureDtM in '..\MWRilPre\R200UScaricoTimbratureDtM.pas' {R200FScaricoTimbratureDtM: TDataModule};

{$R *.RES}

begin
  // scommentare per debug.ini
//  // cfr. https://stackoverflow.com/questions/2884631/how-to-debug-a-windows-service-with-delphi
//  try
//    // in debug il server funziona come una console application
//    WriteLn('B006',': modalità DEBUG. Premi INVIO per uscire.');
//
//    // crea oggetto server (TService) manualmente
//    B006FScaricoService:=TB006FScaricoService.Create(nil);
//
//    // simula l'avvio del server
//    B006FScaricoService.ServiceStart(B006FScaricoService, GStarted);
//
//    // attende pressione pulsante invio (il servizio gira in background nel frattempo)
//    ReadLn;
//
//    // simula l'arresto del server
//    B006FScaricoService.ServiceStop(B006FScaricoService, GStopped);
//
//    // all'uscita, distrugge il server
//    FreeAndNil(B006FScaricoService);
//  except
//    on E: Exception do
//    begin
//      Writeln(E.ClassName, ': ', E.Message);
//      WriteLn('Premi INVIO per uscire.');
//      ReadLn;
//    end;
//  end;

//  !!! commentare il flusso normale di esecuzione per eseguire in modalità debug !!!
// scommentare per debug.fine

  // flusso normale di esecuzione
  Application.Initialize;
  Application.CreateForm(TB006FScaricoService, B006FScaricoService);
  Application.Run;

end.
