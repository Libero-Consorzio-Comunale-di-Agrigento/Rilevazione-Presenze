unit A001UPassWord;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, DB, Registry, OracleData, StrUtils, OracleCI,
  A000UCostanti, A000USessione, A000Versione, A000UInterfaccia, A000UMessaggi,
  (*A008UAzOper,*)A008UcambioPassword, System.UITypes,
  C180FunzioniGenerali, L021Call, Variants;

type
  TA001FPassWord = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Azienda: TEdit;
    Utente: TEdit;
    Password: TEdit;
    Label4: TLabel;
    cmbDatabase: TComboBox;
    btnPassword: TSpeedButton;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbDatabaseKeyPress(Sender: TObject; var Key: Char);
    procedure btnPasswordMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnPasswordMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams);  override;
  public
    { Public declarations }
  end;

var
  A001FPassWord: TA001FPassWord;

implementation

uses A001UPassWordDtM1;

{$R *.DFM}

procedure TA001FPassWord.BitBtn1Click(Sender: TObject);
{Controllo accesso}
var //F:TSearchRec;
  Sysdate:TDateTime;
  Registro:TRegistry;
  AuthDom:Boolean;
  S,locDom:String;
begin
  with A001FPassWordDtM1 do
  begin
    //Se viene inserito il carattere ?, mostro l'elenco degli alias DB
    if cmbDatabase.Text = '?' then
    begin
      Application.HintHidePause:=30000;
      cmbDatabase.ShowHint:=True;
      cmbDatabase.Hint:=Format('Path TNSNAMES:' + #13#10 + '"%s"',[TNSNames]);
      cmbDatabase.Style:=csDropDown;
      cmbDatabase.Text:=R180GetRegistro(HKEY_CURRENT_USER,'A001','Database','IRIS');
      Exit;
    end;
    cmbDatabase.Text:=Trim(cmbDatabase.Text);
    if not A001FPassWordDtM1.TestDBAlias(cmbDatabase.Text) then
    begin
      R180MessageBox(Format(A000MSG_ERR_ALIAS_DB_ERRATO,[cmbDataBase.Text]),ERRORE);
      Exit;
    end;
    InizializzazioneSessione(cmbDatabase.Text);
    with QI090 do
    begin
      Close;
      SetVariable('Azienda',Azienda.Text);
      Open;
      if RecordCount = 0 then
        raise Exception.Create('Azienda inesistente!');
    end;
    with selI070Doppi do
    try
      Close;
      SetVariable('Azienda',QI090.FieldByName('Azienda').AsString);
      SetVariable('Utente',Utente.Text);
      Open;
    except
    end;
    with QI070 do
    begin
      Close;
      SetVariable('Azienda',QI090.FieldByName('Azienda').AsString);
      SetVariable('CampoUtente',IfThen(not selI070Doppi.Active or (selI070Doppi.RecordCount > 0),'UTENTE','UPPER(UTENTE)'));
      SetVariable('Utente',IfThen(not selI070Doppi.Active or (selI070Doppi.RecordCount > 0),Utente.Text,UpperCase(Utente.Text)));
      Open;
      AuthDom:=False;
      if RecordCount = 0 then
        raise Exception.Create(A000MSG_ERR_AUT_FALLITA);
      //Alberto: autenticazione su dominio
      if (QI070.FieldByName('Utente').AsString <> 'SYSMAN') and (QI070.FieldByName('Utente').AsString <> 'MONDOEDP') and (QI090.FindField('DOMINIO_USR') <> nil) and (not QI090.FieldByName('DOMINIO_USR').IsNull) then
      begin
        AuthDom:=False;
        for locDom in QI090.FieldByName('DOMINIO_USR').AsString.Split([';',',']) do
        begin
          AuthDom:=AutenticazioneDominio(locDom, QI070.FieldByName('Utente').AsString, Password.Text, QI090.FieldByName('DOMINIO_USR_TIPO').AsString, QI090.FieldByName('DOMINIO_LDAP_DN').AsString);
          if AuthDom and (Password.Text = '') and (QI090.FieldByName('Lung_Password').AsInteger > 0) then
            raise Exception.Create(A000MSG_ERR_ACCESSO_NEGATO_NO_PSW);
          Parametri.AuthDomInfo.DominioDip:=locDom;
          if AuthDom then
            Break;
        end;
        if not AuthDom and ((Password.Text = '') or (R180CriptaI070(Password.Text) <> FieldByName('PassWd').AsString)) then
          raise Exception.Create(A000MSG_ERR_AUT_FALLITA);
      end
      //Fine autenticazione su dominio
      else
      if R180CriptaI070(Password.Text) <> FieldByName('PassWd').AsString then
        raise Exception.Create(A000MSG_ERR_AUT_FALLITA);

      if Parametri.Applicazione <> '' then
      begin
        if (FieldByName('Occupato').Value = 'S') and (QI070.FieldByName('Utente').AsString <> 'SYSMAN') then
        begin
          if FieldByName('Sblocco').AsString = 'N' then
            raise Exception.Create('Operatore già occupato!')
          else
          begin
            if MessageDlg('Operatore già occupato!' + #13 + 'Utilizzarlo comunque?',
               mtConfirmation, [mbYes, mbNo], 0) = mrNo then
              Abort;
          end;
        end;
      end;
    end;
    //Abilitazione funzionalità/controlli
    with selI080 do
    try
      SetVariable('AZIENDA',QI090.FieldByName('Azienda').AsString);
      Open;
      GeneratoreDiStampe:=GeneratoreDiStampe or R180In(Parametri.Applicazione,['PAGHE','STAGIU']) or SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('GENERATORE_STAMPE',14091943)]),[srFromBeginning]);
      IndennitaTurno:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('INDENNITA_TURNO',14091943)]),[srFromBeginning]);
      IntegrazioneFTP:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('INTEGRAZIONE_ANAGRAFICA_ENGISANITA',14091943)]),[srFromBeginning]);
      CheckEutron:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('EUTRON',14091943)]),[srFromBeginning]);
      VersioneDimostrativa:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('VERSIONE_DIMOSTRATIVA',14091943)]),[srFromBeginning]);
      CartellinoAscii:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('CARTELLINO_ASCII',14091943)]),[srFromBeginning]);
    except
    end;
    //Registrazione parametri/inibizioni su tabelle in memoria
    RegistraInibizioni;
    Parametri.AuthDom:=AuthDom;
    if Parametri.AuthDom then
      Parametri.PassOper:=Password.text;

    //Verifica se il campo ACCESSO_NEGATO è N (significa che l'accesso è valido)
    if QI070.FindField('ACCESSO_NEGATO') <> nil then
    begin
      if QI070.FieldByName('ACCESSO_NEGATO').AsString = 'S' then
      begin
        ShowMessage('Attenzione! ' +#13 +
                    'L''accesso all''applicativo è momentaneamente inibito per attività di amministrazione.' + #13 +
                    'Riprovare più tardi o contattare l''amministratore dell''applicativo.');
        exit;
      end;
    end;
    //Verifica se dall'ultimo accesso sono passati "VALID_UTENTE" mesi.In tal caso nega l'accesso
    Sysdate:=Trunc(R180Sysdate(QI090.Session));
    if QI070.FindField('DATA_ACCESSO') <> nil then
    begin
      if (QI070.FieldByName('Utente').AsString <> 'SYSMAN') and (QI070.FieldByName('Utente').AsString <> 'MONDOEDP') then
      begin
        if (not QI070.FieldByName('DATA_ACCESSO').IsNull) and
           (QI090.FieldByName('VALID_UTENTE').AsInteger > 0) and
           (R180AddMesi(Trunc(QI070.FieldByName('DATA_ACCESSO').AsDateTime),Parametri.ValiditaUtente) <= Sysdate) then
        begin
          ShowMessage('Attenzione! E'' scaduto il periodo di validità di questo operatore. Contattare l''amministratore dell''applicativo');
          exit;
        end;
      end;
    end;
    if Parametri.Applicazione <> '' then
    begin
      with OperSQL do
      begin
        SQL.Clear;
        SQL.Add(Format('UPDATE I070_UTENTI SET OCCUPATO = ''S'' WHERE AZIENDA = ''%s'' AND UTENTE = ''%s''',[QI090.FieldByName('Azienda').AsString,QI070.FieldByName('Utente').AsString]));
        if selI070Utenti.FieldByName('NUM').AsInteger = 0 then
          SQL.Text:=StringReplace(SQL.Text,'I070_UTENTI','I070_OPERATORI',[rfReplaceAll,rfIgnoreCase]);
        Execute;
        SessioneMondoEDP.Commit;
      end;
    end;
    //Testa il campo NUOVA_PASSWORD per vedere se l'utente deve cambiare la password
    if QI070.FindField('NUOVA_PASSWORD') <> nil then
    begin
      if (not Parametri.AuthDom) and (Parametri.Applicazione <> '') and (QI070.FieldByName('NUOVA_PASSWORD').AsString = 'S') then
      begin
        ShowMessage('Per accedere bisogna cambiare la password!');
        OpenA008GestioneSicurezza(QI090.Session,False);
      end;
      if Parametri.Applicazione <> '' then
      begin
        with OperSQL do
        begin
          SQL.Clear;
          SQL.Add(Format('UPDATE I070_UTENTI SET NUOVA_PASSWORD = ''N'', DATA_ACCESSO = SYSDATE WHERE AZIENDA = ''%s'' AND UTENTE = ''%s''',[QI090.FieldByName('Azienda').AsString,QI070.FieldByName('Utente').AsString]));
          if selI070Utenti.FieldByName('NUM').AsInteger = 0 then
            SQL.Text:=StringReplace(SQL.Text,'I070_UTENTI','I070_OPERATORI',[rfReplaceAll,rfIgnoreCase]);
          Execute;
          SessioneMondoEDP.Commit;
        end;
      end;
    end;
    //Verifica se password scaduta
    if (not Parametri.AuthDom) and (QI070.FindField('DATA_PW') <> nil) then
    begin
      if ((Parametri.ValiditaPassword > 0) and (R180AddMesi(QI070.FieldByName('DATA_PW').AsDateTime,Parametri.ValiditaPassword) <= Sysdate)) then
      begin
        ShowMessage('La password è scaduta! Inserirne una nuova');
        OpenA008GestioneSicurezza(QI090.Session,False);
      end;
    end;
    R180PutRegistro(HKEY_CURRENT_USER,'A001','Database',cmbDatabase.Text);
    try
      Registro:=TRegistry.Create;
      try
        Registro.RootKey:=HKEY_LOCAL_MACHINE;
        Registro.OpenKey('Software\Microsoft\HTMLHelp\1.x\ItssRestrictions',True);
        Registro.WriteInteger('MaxAllowedZone',3);
      finally
        Registro.Free;
      end;
    except
    end;
    //Segnalo se lo spazio su tablespace è inferiore alla soglia minima
    if StrToIntDef(Parametri.CampiRiferimento.C27_TablespaceFree,0) > 0 then
    begin
      with A001FPassWordDtM1 do
      begin
        selTableSpace.Close;
        selTableSpace.SetVariable('TABLESPACE','''' + QI090.FieldByName('TSLAVORO').AsString + ''',''' + QI090.FieldByName('TSINDICI').AsString + '''');
        try
          S:='';
          selTableSpace.Open;
          while not selTableSpace.Eof do
          begin
            if selTableSpace.FieldByName('SPAZIO_LIBERO').AsFloat < StrToFloatDef(Parametri.CampiRiferimento.C27_TablespaceFree,0) then
              S:=S + IfThen(S <> '',#13) + 'Lo spazio libero sul tablespace ' + selTableSpace.FieldByName('TABLESPACE').AsString + ' è di ' + selTableSpace.FieldByName('SPAZIO_LIBERO_STRINGA').AsString + ' MB';
            selTableSpace.Next;
          end;
        except
        end;
        if S <> '' then
        begin
          S:='Attenzione:' + #13 + S + #13 + 'Si consiglia di avvisare l''amministratore di sistema';
          ShowMessage(S);
        end;
      end;
    end;
    ModalResult:=mrOk;
  end;
end;

procedure TA001FPassWord.BitBtn2Click(Sender: TObject);
{Rinuncia accesso}
begin
  Application.Terminate;
  //Close;
end;

procedure TA001FPassWord.cmbDatabaseKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    BitBtn1Click(Sender);
end;

procedure TA001FPassWord.CreateParams(var Params: TCreateParams);
{Serve per mostrare la form di login sulla taskbar}
begin
  inherited;
  Params.ExStyle:=Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TA001FPassWord.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.HintHidePause:=2500;
end;

procedure TA001FPassWord.FormShow(Sender: TObject);
begin
  //Setto le variabili d'ambiente per la funzione OracleAliasList
  //se le variabili non vengono settate ora i prossimi richiami della funzione
  //risulteranno comunque errati(Path TNSNames) in presenza di installazione oracle e OIC
  try
    R180SetOracleInstantClient;
    //-------------------------
    cmbDatabase.Style:=csSimple;
    if cmbDatabase.Text = '' then
      cmbDatabase.Text:=R180GetRegistro(HKEY_CURRENT_USER,'A001','Database','IRIS');
    Azienda.SetFocus;
    if Caption = '' then
    begin
      cmbDatabase.Style:=csDropDown;
      exit;
    end;
    if DebugHook <> 0 then
    begin
      if Azienda.Text = '' then
        Azienda.Text:='AZIN';
      Utente.SetFocus;
    end
    else
    begin
      with A001FPassWordDtM1 do  //Lorena 06/10/2010
      try
        InizializzazioneSessione(cmbDatabase.Text);
        with OperSQL do
        begin
          SQL.Clear;
          SQL.Add('SELECT I090.AZIENDA FROM MONDOEDP.I090_ENTI I090, MONDOEDP.I091_DATIENTE I091');
          SQL.Add(' WHERE I090.AZIENDA = I091.AZIENDA');
          SQL.Add('   AND I090.AGGIORNAMENTO_ABILITATO = ''S''');
          SQL.Add('   AND I091.TIPO = ''C24_AZIENDABUDGET''');
          SQL.Add('   AND nvl(I091.DATO,''N'') = ''N''');
          Execute;
          if RowsProcessed = 1 then
          begin
            Azienda.Text:=VarToStr(Field(0));
            Utente.SetFocus;
          end;
        end;
      except
      end;
    end;
  finally
    //La function "OracleAliasList" va referenziata dopo "InizializzazioneSessione"
    if OracleAliasList <> nil then
    begin
      cmbDatabase.Items.Assign(OracleAliasList);
    end;
  end;
end;

procedure TA001FPassWord.btnPasswordMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Password.PasswordChar:=Azienda.PasswordChar;
end;

procedure TA001FPassWord.btnPasswordMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Password.PasswordChar:='*';
end;

end.
