unit WM001ULoginMW;

interface

uses
  A000UCostanti,
  A000Versione,
  A000USessione,
  B110USharedTypes,
  C200UWebServicesTypes,
  B110UClientModule,
  FunzioniGenerali,
  SysUtils,
  Classes,
  WM000UConstants,
  B110UUtils;

type

  TWM001FLoginMW = class(TObject)
    private
      FParametriLogin: TParametriLogin;
      FDatiGenerali: TOutputDatiGenerali;
      FSessioneIrisWin: TSessioneIrisWin;

      function ControllaDati(PAzienda, PUtente, PPassword: String): TResCtrl;
      procedure SetParametriLogin(PAzienda, PUtente, PPassword, PProfilo: String; PRicordaPassword: Boolean);
      function CheckAllineamentoVersioneSRV(B110: TB110FClientModule; PVersioneClient: TInfoVersioneSW): TResCtrl;
      function LoginSRV(B110: TB110FClientModule; InfoClient: TInfoClient): TResCtrl;
    public
      property ParametriLogin: TParametriLogin read FParametriLogin;
      property DatiGenerali: TOutputDatiGenerali read FDatiGenerali;
      property SessioneIrisWin: TSessioneIrisWin read FSessioneIrisWin;

      constructor Create;
      destructor Destroy; override;
      function LoginB110(B110: TB110FClientModule; InfoClient: TInfoClient; PAzienda, PUtente, PPassword, PProfilo: String): TResCtrl;

      function AggiornaSessioneIrisWin: TResCtrl; overload;
      function AggiornaSessioneIrisWin(PAzienda: String; PUtente: String = ''): TResCtrl; overload;
    end;

implementation
{$region 'TWM001FLoginMW'}
constructor TWM001FLoginMW.Create;
begin
  inherited Create;
  FParametriLogin:=TParametriLogin.Create;
  FDatiGenerali:=TOutputDatiGenerali.Create;
  FSessioneIrisWin:=TSessioneIrisWin.Create(nil);
end;

destructor TWM001FLoginMW.Destroy;
begin
  FreeAndNil(FParametriLogin);
  FreeAndNil(FDatiGenerali);
  FreeAndNil(FSessioneIrisWin);

  inherited Destroy;
end;

function TWM001FLoginMW.LoginB110(B110: TB110FClientModule; InfoClient: TInfoClient; PAzienda, PUtente, PPassword, PProfilo: String): TResCtrl;
var
  LResCtrl: TResCtrl;
begin

  if not Assigned(B110) or not Assigned(InfoClient) then
  begin
    Result.Ok:=False;
    Result.Messaggio:='Impossibile eseguire il login, parametri incompleti';
    Exit;
  end;

  // verifica i dati in input
  LResCtrl:=ControllaDati(PAzienda, PUtente, PPassword);
  if not LResCtrl.Ok then
  begin
    Result:=LResCtrl;
    Exit;
  end;

  SetParametriLogin(PAzienda, PUtente, PPassword, PProfilo, False);

  LResCtrl:=CheckAllineamentoVersioneSRV(B110, InfoClient.VersioneApp); // controlla allineamento versione server

  if not LResCtrl.Ok then
    Result:=LResCtrl                    // controllo versione fallito
  else
  begin
    Result:=LoginSRV(B110, InfoClient); // effettua il login
    if Result.Ok then
      AggiornaSessioneIrisWin;
  end;
end;

function TWM001FLoginMW.ControllaDati(PAzienda, PUtente, PPassword: String): TResCtrl;
begin
  Result.Clear;

  // trim e verifica indicazione azienda
  PAzienda:=Trim(PAzienda);
  if Trim(PAzienda) = '' then
  begin
    Result.Messaggio:='Indicare l''azienda!';
    Exit;
  end;

  // trim e verifica indicazione utente
  PUtente:=Trim(PUtente);
  if Trim(PUtente) = '' then
  begin
    Result.Messaggio:='Indicare l''utente!';
    Exit;
  end;

  // verifica indicazione password
  if PPassword = '' then
  begin
    Result.Messaggio:='Indicare la password!';
    Exit;
  end;

  // controlli ok
  Result.Ok:=True;
end;

procedure TWM001FLoginMW.SetParametriLogin(PAzienda, PUtente, PPassword, PProfilo: String; PRicordaPassword: Boolean);
begin
  if Assigned(FParametriLogin) then
  begin
    FParametriLogin.Azienda:=Trim(PAzienda);
    FParametriLogin.Utente:=Trim(PUtente);
    FParametriLogin.Password:=PPassword;
    FParametriLogin.Profilo:=Trim(PProfilo);
    FParametriLogin.RicordaPassword:=PRicordaPassword;
  end;
end;

function TWM001FLoginMW.AggiornaSessioneIrisWin: TResCtrl;
begin
  Result.Clear;
  try
    //con chiamante diverso da B110 lavora direttamente su variabile globale A000SessioneIrisWIN
    //aggiornandola con i ParametriLogin passati come parametro
    TB110FUtils.GetSessioneIrisWin(FParametriLogin, Result.Messaggio, 'WM000');
    FSessioneIrisWIN.SessioneOracle.LogOff;

    Result.Messaggio:=StringReplace(Result.Messaggio,
                                    'Errore in fase di accesso: ',
                                    'Errore nell''aggiornamento della sessione IrisWin: ',
                                    [rfReplaceAll, rfIgnoreCase]);
    if Result.Messaggio = '' then
      Result.Ok:=True;
  except
    on e:Exception do
      Result.Messaggio:='Errore nell''aggiornamento della sessione IrisWin: ' + e.Message;
  end;
end;

function TWM001FLoginMW.AggiornaSessioneIrisWin(PAzienda: String; PUtente: String = ''): TResCtrl;
begin
  ParametriLogin.Azienda:=PAzienda;
  ParametriLogin.Utente:=PUtente;
  Result:=AggiornaSessioneIrisWin;
end;

function TWM001FLoginMW.CheckAllineamentoVersioneSRV(B110: TB110FClientModule; PVersioneClient: TInfoVersioneSW): TResCtrl;
// verifica che la versione del client coincida con quella del server aziendale
var
  LRes: TRisultato;
  LResCtrl: TResCtrl;
  LVersioneSrvPA: TInfoVersioneSW;
begin
  try
    Result.Clear;

    // estrae numero di versione server (presenze)
    LRes:=B110.B110FServerMethodsDMClient.VersioneServer(TInfoVersioneSW.TIPO_VERSIONE_PA);

    // verifica risultato
    LResCtrl:=LRes.Check(TOutputVersioneServer);

    if not LResCtrl.Ok then
    begin
      LResCtrl.Messaggio:='Versione del server non disponibile';
      Result:=LResCtrl;
      Exit;
    end
    else
    begin
      LVersioneSrvPA:=(LRes.Output as TOutputVersioneServer).Versione;

      Result.Ok:=LVersioneSrvPA.Equals(PVersioneClient);
      if not Result.Ok then
      begin
        Result.Messaggio:=Format('La versione di %s [%s]'#13#10 +
                                 'non corrisponde a quella'#13#10 +
                                 'del server [%s]'#13#10 +
                                 'Accesso non consentito!',
                                 ['IRIS WebApp',PVersioneClient.ToString,
                                  LVersioneSrvPA.ToString]);
      end;
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWM001FLoginMW.LoginSRV(B110: TB110FClientModule; InfoClient: TInfoClient): TResCtrl;
var LRes: TRisultato;
begin
  try
    // estrae informazioni generali per l'utente indicato
    LRes:=B110.B110FServerMethodsDMClient.DatiGenerali(InfoClient.PrepareForServer, ParametriLogin.PrepareForServer);
    // verifica risultato
    Result:=LRes.Check(TOutputDatiGenerali);
    if not Result.Ok then
      Exit
    else
    begin
      FDatiGenerali.Assign(TOutputDatiGenerali(LRes.Output));
      //imposta il profilo corrente nei parametri di login e il nome dell'utente corretto
      //FParametriLogin.Utente:=FDatiGenerali.Parametri.Operatore;
      FParametriLogin.Profilo:=FDatiGenerali.Profilo;
      //TFunzioniGenerali.SettaVariabiliAmbiente(FDatiGenerali.Parametri.Lingua); //non necessario, già gestito da SessioneIrisWin
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;
{$endregion}
end.
