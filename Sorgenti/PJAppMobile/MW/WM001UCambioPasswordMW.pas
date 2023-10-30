unit WM001UCambioPasswordMW;

interface

uses
  System.SysUtils, System.Classes, WM000UDataModuleBaseDM, Data.DB, OracleData, C180FunzioniGenerali,
  A000USessione, Oracle, A000UCostanti, StrUtils, A000UMessaggi;

type
  TWM001FCambioPasswordMW = class(TWM000FDataModuleBaseDM)
    QI060: TOracleDataSet;
  private
    FLoginEsterno: String;
    FPassword: String;
    FEMail: String;
    FEMailPEC: String;
    FCellulare: String;
    FRicezioneMail: Boolean;
  public
    property Password: String read FPassword;
    property EMail: String read FEMail;
    property EMailPEC: String read FEMailPEC;
    property Cellulare: String read FCellulare;
    property RicezioneMail: Boolean read FRicezioneMail;

    constructor Create(PSessioneIrisWin: TSessioneIrisWin; PLoginEsterno: String);

    function GetPasswordScaduta: Boolean;
    function AggiornaPassword(PNuovaPassword, PConfermaPassword, PVecchiaPassword: String): TResCtrl;
    function AggiornaContatti(PNuovaEmail, PNuovaEmailPec, PNuovoCellulare: String; PNuovaRicezioneMail: Boolean): TResCtrl;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TWM001FLoginDM }

constructor TWM001FCambioPasswordMW.Create(PSessioneIrisWin: TSessioneIrisWin; PLoginEsterno: String);
begin
  inherited Create(PSessioneIrisWin);

  FPassword:='';
  FEMail:='';
  FEMailPEC:='';
  FCellulare:='';
  FRicezioneMail:=False;

  //Lettura password
  FPassword:=SessioneIrisWin.Parametri.PassOper;
  FLoginEsterno:=PLoginEsterno;

  with TOracleQuery.Create(Self) do
  begin
    try
      Session:=SessioneOracle;

      //Lettura EMail/PEC/Cellulare
      SQL.Add('SELECT EMAIL, EMAIL_PEC, CELLULARE FROM MONDOEDP.I060_LOGIN_DIPENDENTE ');
      SQL.Add('WHERE NOME_UTENTE = ''' + SessioneIrisWin.Parametri.Operatore + '''');
      SQL.Add('AND AZIENDA = ''' + SessioneIrisWin.Parametri.Azienda + '''');
      Execute;

      FEMail:=FieldAsString('EMail');
      FEMailPEC:=FieldAsString('EMail_PEC');
      FCellulare:=FieldAsString('Cellulare');

      //Lettura stato ricezione EMail
      SQL.Clear;
      SQL.Add('SELECT I061.RICEZIONE_MAIL');
      SQL.Add('  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061');
      SQL.Add(' WHERE I061.AZIENDA = ''' + SessioneIrisWin.Parametri.Azienda + '''');
      SQL.Add('   AND I061.NOME_UTENTE = ''' + SessioneIrisWin.Parametri.Operatore + '''');
      SQL.Add('   AND I061.NOME_PROFILO = ''' + SessioneIrisWin.Parametri.ProfiloWEB + '''');
      Execute;

      if RowCount > 0 then
        FRicezioneMail:=FieldAsString ('RICEZIONE_MAIL') = 'S';
    finally
      Free;
    end;
  end;
end;

function TWM001FCambioPasswordMW.GetPasswordScaduta: Boolean;
var Sysdate: TDateTime;
begin
  try
    QI060.Close;
    QI060.ClearVariables;
    QI060.SetVariable('Azienda',SessioneIrisWin.Parametri.Azienda);
    QI060.SetVariable('Utente', SessioneIrisWin.Parametri.Operatore);
    QI060.Open;

    //Password scaduta
    Result:=False;
    Sysdate:=Trunc(R180Sysdate(SessioneOracle));  //Date??
    if (FLoginEsterno = 'N') and (QI060.FindField('DATA_PW') <> nil) and (not SessioneIrisWin.Parametri.AuthDom) then
    begin
      if ((SessioneIrisWin.Parametri.ValiditaPassword > 0) and
         (R180AddMesi(QI060.FieldByName('DATA_PW').AsDateTime, SessioneIrisWin.Parametri.ValiditaPassword) <= Sysdate)) or
         (QI060.FieldByName('DATA_PW').IsNull) then
        Result:=True;
    end;
  except
    Result:=False;
  end;
end;

function TWM001FCambioPasswordMW.AggiornaPassword(PNuovaPassword,PConfermaPassword, PVecchiaPassword: String): TResCtrl;
var S: String;
begin
  Result.Clear;
  S:='';
  try
    if SessioneIrisWin.Parametri.AuthDom then
      raise Exception.Create('Impossibile modificare la password se è prevista l''autenticazione su dominio');

    if FLoginEsterno <> 'N' then
      raise Exception.Create('Impossibile modificare la password se è previsto il login esterno');

    if PVecchiaPassword <> FPassword then
      Result.Messaggio:='La password attuale indicata è errata'
    else if PNuovaPassword <> PConfermaPassword then
      Result.Messaggio:='La nuova password non è stata confermata correttamente'
    else if PNuovaPassword = FPassword then
      Result.Messaggio:='La nuova password indicata è uguale alla password corrente'
    else if (SessioneIrisWin.Parametri.AuthDomInfo.DominioDip = '') or (Length(PNuovaPassword) > 0) then
      Result.Messaggio:=SessioneIrisWin.Parametri.RegolePassword.PasswordValida(PNuovaPassword);

    if Result.Messaggio <> '' then
      Exit;

    S:='PASSWORD = ''' + AggiungiApice(R180Cripta(PNuovaPassword, 30011945)) + ''', DATA_PW = TRUNC(SYSDATE)';

    //Aggiornamento PASSWORD
    with TOracleQuery.Create(Self) do
    begin
      try
        Session:=SessioneOracle;
        SQL.Add('UPDATE MONDOEDP.I060_LOGIN_DIPENDENTE SET ' + S);
        SQL.Add('WHERE NOME_UTENTE = ''' + SessioneIrisWin.Parametri.Operatore + '''');
        SQL.Add('AND AZIENDA = ''' + SessioneIrisWin.Parametri.Azienda + '''');
        Execute;
        SessioneOracle.Commit;
        if RowsProcessed <> 0 then
        begin
          //aggiorno i campi
          SessioneIrisWin.Parametri.PassOper:=PNuovaPassword;
          FPassword:=PNuovaPassword;
        end;
      finally
        Free;
      end;
    end;
    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWM001FCambioPasswordMW.AggiornaContatti(PNuovaEmail, PNuovaEmailPec, PNuovoCellulare: String; PNuovaRicezioneMail: Boolean): TResCtrl;
var S: String;
    LunghMinCell: Integer;
begin
  Result.Clear;
  S:='';
  try
    //Email
    if PNuovaEmail <> FEmail then
    begin
      if (Length(PNuovaEmail) > 0) and ((Pos('@', PNuovaEmail) = 0) or (Pos('.', PNuovaEmail) = 0)) then
      begin
        Result.Messaggio:='Indirizzo e-mail non valido.';
        Exit;
      end;

      S:=IfThen(Length(S) > 0, S + ', ', '') + 'EMAIL = ''' + PNuovaEmail + '''';
    end;

    //EmailPEC
    if PNuovaEmailPec <> FEMailPEC then
    begin
      if (Length(PNuovaEmailPec) > 0) and ((Pos('@', PNuovaEmailPec) = 0) or (Pos('.', PNuovaEmailPec) = 0)) then
      begin
        Result.Messaggio:='Indirizzo e-mail PEC non valido.';
        Exit;
      end;

      S:=IfThen(Length(S) > 0, S + ', ', '') + 'EMAIL_PEC = ''' + PNuovaEmailPec + '''';
    end;

    //Cellulare
    if (PNuovoCellulare <> FCellulare) and (PNuovoCellulare <> '3') then
    begin
      PNuovoCellulare:=Trim(PNuovoCellulare);
      LunghMinCell:=StrToIntDef(SessioneIrisWin.Parametri.CampiRiferimento.C90_CellulareLunghMin, 10);

      if (Length(PNuovoCellulare) > 0) then
      begin
        if Copy(PNuovoCellulare,1,1) <> '3' then
          Result.Messaggio:=A000MSG_A186_ERR_INIZ_CELLULARE
        else if Length(PNuovoCellulare) < LunghMinCell then
          Result.Messaggio:=Format(A000MSG_A186_ERR_FMT_LUNG_CELLULARE,[LunghMinCell])
        else if not R180TestoInSetCaratteri(PNuovoCellulare,'0123456789') then
          Result.Messaggio:=A000MSG_A186_ERR_NON_NUMERICO;

        if Result.Messaggio <> '' then
          Exit;
      end;

      S:=IfThen(Length(S) > 0, S + ', ', '') + 'CELLULARE = ''' + PNuovoCellulare + '''';
    end;

    //Aggiornamento EMAIL e CELLULARE
    if S <> '' then
    begin
      with TOracleQuery.Create(Self) do
      begin
        try
          Session:=SessioneOracle;
          SQL.Add('UPDATE MONDOEDP.I060_LOGIN_DIPENDENTE SET ' + S);
          SQL.Add('WHERE NOME_UTENTE = ''' + SessioneIrisWin.Parametri.Operatore + '''');
          SQL.Add('AND AZIENDA = ''' + SessioneIrisWin.Parametri.Azienda + '''');
          Execute;
          SessioneOracle.Commit;
          if RowsProcessed <> 0 then
          begin
            FEmail:=PNuovaEmail;
            FEMailPEC:=PNuovaEmailPec;
            if PNuovoCellulare <> '3' then
              FCellulare:=PNuovoCellulare;
          end;
        finally
          Free;
        end;
      end;
    end;

    //Aggiornamento RICEZIONE_MAIL
    if PNuovaRicezioneMail <> FRicezioneMail then
    begin
      with TOracleQuery.Create(Self) do
      begin
        try
          Session:=SessioneOracle;
          SQL.Add('UPDATE MONDOEDP.I061_PROFILI_DIPENDENTE I061');
          SQL.Add('   SET I061.RICEZIONE_MAIL = ''' + IfThen(PNuovaRicezioneMail,'S','N') + '''');
          SQL.Add(' WHERE I061.AZIENDA = ''' + SessioneIrisWin.Parametri.Azienda + '''');
          SQL.Add('   AND I061.NOME_UTENTE = ''' + SessioneIrisWin.Parametri.Operatore + '''');
          SQL.Add('   AND I061.NOME_PROFILO = ''' + SessioneIrisWin.Parametri.ProfiloWEB + '''');
          Execute;
          SessioneOracle.Commit;

          FRicezioneMail:=PNuovaRicezioneMail;
        finally
          Free;
        end;
      end;
    end;

    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

end.
