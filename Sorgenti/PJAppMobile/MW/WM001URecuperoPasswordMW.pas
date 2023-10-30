unit WM001URecuperoPasswordMW;

interface

uses
  System.SysUtils, System.Classes, WM000UDataModuleBaseDM, Data.DB, OracleData, A000UCostanti,
  A000USessione, Variants, C180FunzioniGenerali, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP;

type
  TParametriSMTP = class(TObject)
  public
    SMTPHost: String;
    HeloName: String;
    Username: String;
    Password: String;
    Port: String;
    AuthType: String;
    UseTLS: String;
    Sender: String;
    SenderIndirizzo: String;
    constructor Create; overload;
  end;

  TParametriMail = class(TObject)
  private
    FPasswordIris: String;
    procedure SetPasswordIris(const passwordCodificata: String);
  const
    // testo della mail in formato html
    MAIL_TESTO_HTML='<div style="font-size: 13px; font-family: Arial">' +
                    '<p>' +
                    '  Gentile utente,<br>' +
                    '  ecco i dati di accesso a <b>IrisAPP</b> richiesti alle %s<br>' +
                    '  tramite la procedura di recupero password:' +
                    '</p>' +
                    '<table cellpadding="5" style="width: 200px; font-size: 12px; font-family: Courier New, Courier, mono; border-collapse: collapse;">' +
                    '  <tbody>' +
                    '    <tr>' +
                    '      <td style="border: 1px solid #AAAAAA;">Azienda</td>' +
                    '      <td style="border: 1px solid #AAAAAA;">%s</td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '      <td style="border: 1px solid #AAAAAA;">Utente</td>' +
                    '      <td style="border: 1px solid #AAAAAA;">%s</td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '      <td style="border: 1px solid #AAAAAA;">Password</td>' +
                    '      <td style="border: 1px solid #AAAAAA;">%s</td>' +
                    '    </tr>' +
                    '  </tbody>' +
                    '</table>' +
                    '<br><br>' +
                    '<p>' +
                    '  Avviso:<br>' +
                    '  La presente e-mail &egrave; stata generata automaticamente dal sistema IrisAPP.<br>' +
                    '  Si prega di non rispondere a questo indirizzo di posta,<br>' +
                    '  in quanto non &egrave; abilitato alla ricezione di messaggi.' +
                    '</p>' +
                    '</div>';
    // testo alternativo per i client che non supportano html
    MAIL_TESTO_NORMALE='Gentile utente,'#13#10 +
                       'ecco i dati di accesso a IrisAPP richiesti alle %s ' +
                       'tramite la procedura di recupero password:'#13#10 +
                       #13#10 +
                       'Azienda: %s'#13#10 +
                       'Utente: %s'#13#10 +
                       'Password: %s'#13#10 +
                       #13#10 +
                       'Avviso:'#13#10 +
                       'La presente e-mail è stata generata automaticamente dal sistema IrisAPP.'#13#10 +
                       'Si prega di non rispondere a questo indirizzo di posta, ' +
                       'in quanto non è abilitato alla ricezione di messaggi.';
  public
    Azienda: String;
    Utente: String;
    Indirizzi: String;
    HTML: Boolean;
    Oggetto: String;
    property PasswordIris: String read FPasswordIris write SetPasswordIris;
    constructor Create; overload;
    function GetTesto: String;
  end;

  TWM001FRecuperoPasswordMW = class(TWM000FDataModuleBaseDM)
    QI090: TOracleDataSet;
    QI091: TOracleDataSet;
    QI060: TOracleDataSet;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    selDistAzienda: TOracleDataSet;
  private
    FParametriSMTP: TParametriSMTP;
    FParametriMail: TParametriMail;

    function InviaMail: TResCtrl;
    function ImpostaParametriSMTP_SSL(PAzienda: String): TResCtrl;
    function ImpostaParametriMail(PAzienda, PUtente: String): TResCtrl;
  public
    constructor Create(PSessioneIrisWin: TSessioneIrisWin); overload;
    destructor Destroy; override;
    function RecuperaPassword(PAzienda, PUtente: String): TResCtrl;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TWM001FRecuperoPasswordDM }

constructor TWM001FRecuperoPasswordMW.Create(PSessioneIrisWin: TSessioneIrisWin);
begin
  inherited Create(PSessioneIrisWin);

  if not PSessioneIrisWin.SessioneOracle.Connected then
    raise Exception.Create('Sessione Oracle non connessa');

  FParametriMail:=nil;
  FParametriSMTP:=nil;
end;

destructor TWM001FRecuperoPasswordMW.Destroy;
begin
  FreeAndNil(FParametriMail);
  FreeAndNil(FParametriSMTP);

  inherited;
end;

function TWM001FRecuperoPasswordMW.RecuperaPassword(PAzienda, PUtente: String): TResCtrl;
begin
  Result.Clear;

  // controlla campo azienda
  if PAzienda = '' then
  begin
    Result.Messaggio:='Per il recupero della password è necessario indicare l''azienda';
    Exit;
  end;

  // controlla campo utente
  if PUtente = '' then
  begin
    Result.Messaggio:='Per il recupero della password è necessario indicare l''utente';
    Exit;
  end;

  Result:=ImpostaParametriMail(PAzienda, PUtente);
  if not Result.Ok then
    Exit;

  Result:=ImpostaParametriSMTP_SSL(FParametriMail.Azienda);
  if not Result.Ok then
    Exit;

  Result:=InviaMail;
end;

function TWM001FRecuperoPasswordMW.ImpostaParametriMail(PAzienda, PUtente: String): TResCtrl;
var LEsisteUtente, LEsisteAzienda: Boolean;
    LDominioDipendente: String;
    LPassword: String;
begin
  Result.Clear;

  FreeAndNil(FParametriSMTP);
  FParametriMail:=TParametriMail.Create;

  try
    // estrae parametro per dominio di autenticazione
    // (verifica contestualmente esistenza dell'azienda)
    with QI090 do
    begin
      Close;
      SetVariable('AZIENDA', PAzienda);
      Open;
      LEsisteAzienda:=RecordCount > 0;
      if RecordCount > 0 then
      begin
        FParametriMail.Azienda:=FieldByName('AZIENDA').AsString;
        LDominioDipendente:=FieldByName('DOMINIO_DIP').AsString;
      end;
      Close;
    end;

    if not LEsisteAzienda then
    begin
      // azienda inesistente
      Result.Messaggio:='L''azienda indicata è inesistente';
      Exit;
    end;

    // estrae dati utente da I060
    with QI060 do
    begin
      Close;
      ClearVariables;
      SetVariable('AZIENDA', PAzienda);
      SetVariable('UTENTE', PUtente);
      Open;
      LEsisteUtente:=RecordCount > 0;
      if RecordCount > 0 then
      begin
        FParametriMail.Utente:=FieldByName('NOME_UTENTE').AsString;
        FParametriMail.Indirizzi:=FieldByName('EMAIL').AsString;
        LPassword:=FieldByName('PASSWORD').AsString;
      end;
      Close;
    end;
  except
    on e: Exception do
    begin
      Result.Messaggio:='Errore durante l''acquisizione dei parametri email: ' + E.Message;
      Exit;
    end;
  end;

  if not LEsisteUtente then
  begin
    // utente inesistente
    Result.Messaggio:='L''utente indicato è inesistente';
    Exit;
  end;

  // avvisa se l'utente non ha una mail associata
  if FParametriMail.Indirizzi = '' then
  begin
    Result.Messaggio:='L''utente indicato non ha nessun indirizzo di mail associato, non è possibile recuperare la password';
    Exit;
  end;

  // se l'autenticazione avviene sul dominio e la password non è indicata
  // avvisa l'utente che la modifica della password non è consentita
  if (LPassword = '') and (LDominioDipendente <> '') then
  begin
    Result.Messaggio:='Attenzione! L''autenticazione non è gestita da IrisAPP';
    Exit;
  end;

  FParametriMail.PasswordIris:=LPassword;

  Result.Ok:=True;
end;

function TWM001FRecuperoPasswordMW.ImpostaParametriSMTP_SSL(PAzienda: String): TResCtrl;
begin
  Result.Clear;

  FreeAndNil(FParametriSMTP);
  FParametriSMTP:=TParametriSMTP.Create;

  // gestione recupero password via mail
  // legge i parametri relativi al server smtp
  try
    with QI091 do
    begin
      Close;
      SetVariable('AZIENDA', PAzienda);
      Open;

      FParametriSMTP.SMTPHost:=VarToStr(Lookup('Tipo','C90_EMAIL_SMTPHOST','Dato'));
      FParametriSMTP.HeloName:=VarToStr(LookUp('Tipo','C90_EMAIL_HELONAME','Dato'));
      FParametriSMTP.Username:=VarToStr(LookUp('Tipo','C90_EMAIL_USERNAME','Dato'));
      FParametriSMTP.Password:=R180Decripta(VarToStr(Lookup('Tipo','C90_EMAIL_PASSWORD','Dato')),30011945);
      FParametriSMTP.AuthType:=VarToStr(Lookup('Tipo','C90_EMAIL_AUTHTYPE','Dato'));
      FParametriSMTP.UseTLS:=VarToStr(Lookup('Tipo','C90_EMAIL_USETLS','Dato'));
      FParametriSMTP.SenderIndirizzo:=VarToStr(Lookup('Tipo','C90_EMAIL_SENDER_INDIRIZZO','Dato'));
      FParametriSMTP.Sender:=VarToStr(Lookup('Tipo','C90_EMAIL_SENDER','Dato'));

      Close;
    end;
  except
    on e: Exception do
    begin
      Result.Messaggio:='Errore durante l''acquisizione dei parametri SMTP: ' + E.Message;
      Exit;
    end;
  end;

  // avvisa se non è indicato il server di posta
  if FParametriSMTP.SMTPHost = '' then
  begin
    Result.Messaggio:='Non è stato indicato nessun server di posta per l''invio mail, contattare l''amministratore dell''applicativo.';
    Exit;
  end;

  // parametri ok
  IdSMTP.Host:=FParametriSMTP.SMTPHost;
  if FParametriSMTP.Port.Trim = '' then
    IdSMTP.Port:=25
  else
    IdSMTP.Port:=FParametriSMTP.Port.ToInteger;

  IdSMTP.AuthType:=satDefault;
  {Assegnazione e valorizzazione oggetto necessario per l'autenticazione TLS\SSL}
  if (FParametriSMTP.AuthType.Trim <> '') and
     (FParametriSMTP.AuthType.Trim.ToUpper <> 'NO AUTENTICAZIONE') then
  begin
    IdSMTP.IOHandler:=IdSSLIOHandlerSocketOpenSSL;

    IdSMTP.UseTLS:=utUseImplicitTLS;
    if FParametriSMTP.UseTLS.ToUpper = 'NO' then
      IdSMTP.UseTLS:=utNoTLSSupport
    else if FParametriSMTP.UseTLS.ToUpper = 'IMPLICIT' then
      IdSMTP.UseTLS:=utUseImplicitTLS
    else if FParametriSMTP.UseTLS.ToUpper = 'EXPLICIT' then
      IdSMTP.UseTLS:=utUseExplicitTLS
    else if FParametriSMTP.UseTLS.ToUpper = 'REQUIRE' then
      IdSMTP.UseTLS:=utUseRequireTLS
  end;

  with IdSSLIOHandlerSocketOpenSSL do
    begin
    IdSMTP.UseEhlo:=not FParametriSMTP.HeloName.Trim.IsEmpty;

    SSLOptions.Method:=sslvTLSv1;
    SSLOptions.SSLVersions:=[sslvTLSv1];
    if FParametriSMTP.AuthType.ToUpper = 'TLSV1_1' then
    begin
      SSLOptions.Method:=sslvTLSv1_1;
      SSLOptions.SSLVersions:=[sslvTLSv1_1];
    end
    else if FParametriSMTP.AuthType.ToUpper = 'TLSV1_2' then
    begin
      SSLOptions.Method:=sslvTLSv1_2;
      SSLOptions.SSLVersions:=[sslvTLSv1_2];
    end
    else if FParametriSMTP.AuthType.ToUpper = 'SSLV2' then
    begin
      SSLOptions.Method:=sslvSSLv2;
      SSLOptions.SSLVersions:=[sslvSSLv2];
    end
    else if FParametriSMTP.AuthType.ToUpper = 'SSLV23' then
    begin
      SSLOptions.Method:=sslvSSLv23;
      SSLOptions.SSLVersions:=[sslvSSLv23];
    end
    else if FParametriSMTP.AuthType.ToUpper = 'SSLV3' then
    begin
      SSLOptions.Method:=sslvSSLv3;
      SSLOptions.SSLVersions:=[sslvSSLv3];
    end;

    SSLOptions.RootCertFile:='';
    SSLOptions.Mode:=sslmUnassigned;
    SSLOptions.VerifyMode:=[];
    SSLOptions.VerifyDepth:=0;
    ConnectTimeout:=0;
  end;

  Result.Ok:=True;
end;

function TWM001FRecuperoPasswordMW.InviaMail: TResCtrl;
begin
  // invia la password all'indirizzo di posta indicato
  if Assigned(FParametriSMTP) and Assigned(FParametriMail) then
  begin
    try
      try
        // connessione smtp
        with IdSMTP do
        begin
          HeloName:=Trim(FParametriSMTP.HeloName);
          Connect;
          Username:=Trim(FParametriSMTP.Username);
          Password:=Trim(FParametriSMTP.Password);
        end;

        // imposta i dati della mail
        with IdMessage do
        begin
          From.Address:=FParametriSMTP.SenderIndirizzo;
          From.Name:=FParametriSMTP.Sender;
          BccList.Clear;
          Recipients.Clear;
          Recipients.EmailAddresses:=FParametriMail.Indirizzi;
          Subject:=FParametriMail.Oggetto;

          // imposta il testo della mail
          MessageParts.Clear;

          // nota: è stato copiato il content type da C017, compresa la specifica del character set iso-8859-15
          ContentType:='text/plain; charset=ISO-8859-15';
          Body.Text:=FParametriMail.GetTesto;
        end;
        IdSMTP.Send(IdMessage);

        // invio della mail completato
        Result.Ok:=True;
      except
        on E:Exception do
        begin
          Result.Ok:=False;
          Result.Messaggio:='Invio email fallito su host ' + IdSMTP.Host + ': ' + E.Message;
        end;
      end;
    finally
      IdSMTP.Disconnect;
    end;
  end
  else
    Result.Messaggio:='Impossibile inviare email: parametri email/SMTP non presenti';
end;

{ TParametriMail }

constructor TParametriMail.Create;
begin
  inherited Create;

  Indirizzi:='';
  HTML:=False;
  FPasswordIris:='<vuota>';
  Azienda:='';
  Utente:='';
  Oggetto:='Password di accesso a IrisAPP';
end;

function TParametriMail.GetTesto: String;
begin
  if HTML then
    Result:=Format(MAIL_TESTO_HTML,[FormatDateTime('dd/mm/yyyy hhhh.mm',Now), Azienda, Utente, FPasswordIris])
  else
    Result:=Format(MAIL_TESTO_NORMALE,[FormatDateTime('dd/mm/yyyy hhhh.mm',Now), Azienda, Utente, FPasswordIris]);
end;

procedure TParametriMail.SetPasswordIris(const passwordCodificata: String);
begin
  // decifra la password
  if passwordCodificata = '' then
    FPasswordIris:='<vuota>'
  else
    FPasswordIris:=R180Decripta(passwordCodificata,30011945);
end;

{ TParametriSMTP }

constructor TParametriSMTP.Create;
begin
  inherited Create;

  SMTPHost:='';
  HeloName:='';
  Username:='';
  Password:='';
  Port:='';
  AuthType:='';
  UseTLS:='';
  Sender:='';
  SenderIndirizzo:='';
end;

end.
