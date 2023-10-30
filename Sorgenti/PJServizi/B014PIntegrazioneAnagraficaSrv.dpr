program B014PIntegrazioneAnagraficaSrv;

// scommentare per debug
//  {$APPTYPE CONSOLE}

uses
  System.SysUtils,
  SvcMgr,
  MidasLib,
  B014UIntegrazioneAnagraficaSrv in 'B014UIntegrazioneAnagraficaSrv.pas' {B014FIntegrazioneAnagraficaSrv: TService},
  B014UIntegrazioneAnagraficaDtM in 'B014UIntegrazioneAnagraficaDtM.pas' {B014FIntegrazioneAnagraficaDtM: TDataModule};

{$R *.RES}

begin
  // scommentare per debug.ini

//  // cfr. https://stackoverflow.com/questions/2884631/how-to-debug-a-windows-service-with-delphi
//  try
//    // in debug il server funziona come una console application
//    WriteLn('B014',': modalità DEBUG. Premi INVIO per uscire.');
//
//    // crea oggetto server (TService) manualmente
//    B014FIntegrazioneAnagraficaSrv:=TB014FIntegrazioneAnagraficaSrv.Create(nil);
//
//    // simula l'avvio del server
//    B014FIntegrazioneAnagraficaSrv.ServiceStart(B014FIntegrazioneAnagraficaSrv, GStarted);
//
//    // attende pressione pulsante invio (il servizio gira in background nel frattempo)
//    ReadLn;
//
//    // simula l'arresto del server
//    B014FIntegrazioneAnagraficaSrv.ServiceStop(B014FIntegrazioneAnagraficaSrv, GStopped);
//
//    // all'uscita, distrugge il server
//    FreeAndNil(B014FIntegrazioneAnagraficaSrv);
//  except
//    on E: Exception do
//    begin
//      Writeln(E.ClassName, ': ', E.Message);
//      WriteLn('Premi INVIO per uscire.');
//      ReadLn;
//    end;
//  end;
//
//  !!! commentare il flusso normale di esecuzione per eseguire in modalità debug !!!
// scommentare per debug.fine

  // flusso normale di esecuzione
  Application.Initialize;
  Application.CreateForm(TB014FIntegrazioneAnagraficaSrv, B014FIntegrazioneAnagraficaSrv);
  Application.Run;

end.
