program B015PScaricoGiustificativiSrv;

// scommentare per debug
//  {$APPTYPE CONSOLE}

uses
  System.SysUtils,
  SvcMgr,
  MidasLib,
  B015UScaricoGiustificativiSrv in 'B015UScaricoGiustificativiSrv.pas' {B015FScaricoGiustificativiSrv: TService},
  R250UScaricoGiustificativiDtM in '..\MWRilPre\R250UScaricoGiustificativiDtM.pas' {R250FScaricoGiustificativiDtM: TDataModule},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule};

{$R *.RES}

begin
  // scommentare per debug.ini
//  // cfr. https://stackoverflow.com/questions/2884631/how-to-debug-a-windows-service-with-delphi
//  try
//    // in debug il server funziona come una console application
//    WriteLn('B015',': modalità DEBUG. Premi INVIO per uscire.');
//
//    // crea oggetto server (TService) manualmente
//    B015FScaricoGiustificativiSrv:=TB015FScaricoGiustificativiSrv.Create(nil);
//
//    // simula l'avvio del server
//    B015FScaricoGiustificativiSrv.ServiceStart(B015FScaricoGiustificativiSrv, GStarted);
//
//    // attende pressione pulsante invio (il servizio gira in background nel frattempo)
//    ReadLn;
//
//    // simula l'arresto del server
//    B015FScaricoGiustificativiSrv.ServiceStop(B015FScaricoGiustificativiSrv, GStopped);
//
//    // all'uscita, distrugge il server
//    FreeAndNil(B015FScaricoGiustificativiSrv);
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
  Application.CreateForm(TB015FScaricoGiustificativiSrv, B015FScaricoGiustificativiSrv);
  Application.Run;
end.
