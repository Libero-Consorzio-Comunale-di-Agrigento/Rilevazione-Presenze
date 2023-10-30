unit WA186ULoginDipendentiDM;

interface

uses
  Windows, Messages, SysUtils,StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, ActiveX,
  A000UInterfaccia, A000UCostanti, A000USessione, A001UADsHlp, C180FunzioniGenerali, L021Call,
  WR303UGestMasterDetailDM, WR300UBaseDM, WR302UGestTabellaDM,
  DBClient, IWCompListBox, medpIWMessageDlg,WR100UBase,A000UMessaggi;

type
  TFiltroProfiliI061 = record
    Attivo:Boolean;
    NomeProfilo,
    Permessi,
    FiltroAnagrafe,
    FiltroFunzioni,
    IterAutorizzativi,
    FiltroDizionario:String;
  end;

  TWA186FLoginDipendentiDM = class(TWR303FGestMasterDetailDM)
    DbIris008B: TOracleSession;
    selaT030: TOracleDataSet;
    selaT030MATRICOLA: TStringField;
    selaT030NOMINATIVO: TStringField;
    D090: TDataSource;
    QI090: TOracleDataSet;
    insI060: TOracleQuery;
    delI060: TOracleQuery;
    delI060Filtri: TOracleQuery;
    InsI061: TOracleQuery;
    delI061: TOracleQuery;
    UpdI061: TOracleQuery;
    selI061Dist: TOracleDataSet;
    selTabellaAZIENDA: TStringField;
    selTabellaMATRICOLA: TStringField;
    selTabellaNOME_UTENTE: TStringField;
    selTabellaPASSWORD: TStringField;
    selTabellaD_NOMINATIVO: TStringField;
    selTabellaD_PASSWORD: TStringField;
    selTabellaDATA_PW: TDateTimeField;
    selTabellaEMAIL: TStringField;
    selTabellaNOMI_PROFILI: TStringField;
    selI061: TOracleDataSet;
    selI061AZIENDA: TStringField;
    selI061NOME_UTENTE: TStringField;
    selI061NOME_PROFILO: TStringField;
    selI061PERMESSI: TStringField;
    selI061FILTRO_FUNZIONI: TStringField;
    selI061FILTRO_ANAGRAFE: TStringField;
    selI061FILTRO_DIZIONARIO: TStringField;
    selI061INIZIO_VALIDITA: TDateTimeField;
    selI061FINE_VALIDITA: TDateTimeField;
    selI061DELEGATO_DA: TStringField;
    selI061FINE_VALIDITA2: TDateTimeField;
    selUser_Triggers: TOracleDataSet;
    dsrTI071: TDataSource;
    selI071: TOracleDataSet;
    selI072Dist: TOracleDataSet;
    dsrI072Dist: TDataSource;
    selI073Dist: TOracleDataSet;
    dsrI073Dist: TDataSource;
    dsrI074Dist: TDataSource;
    selI074Dist: TOracleDataSet;
    selI065: TOracleDataSet;
    selI065C_TIPO: TStringField;
    selI065TIPO: TStringField;
    selI065CODICE: TStringField;
    selI065ESPRESSIONE: TStringField;
    selI065P: TOracleDataSet;
    dsrI065P: TDataSource;
    selI065U: TOracleDataSet;
    dsrI065U: TDataSource;
    dsrI065: TDataSource;
    selI090: TOracleDataSet;
    selI090AZIENDA: TStringField;
    selI090ALIAS: TStringField;
    selI090DESCRIZIONE: TStringField;
    selI090INDIRIZZO: TStringField;
    selI090TIPOCONTEGGIO: TStringField;
    selI090STORIAINTERVENTO: TStringField;
    selI090AZZERAMENTOSALDO: TStringField;
    selI090ECCFASCESTR: TStringField;
    selI090UTENTE: TStringField;
    selI090PAROLACHIAVE: TStringField;
    selI090TSLAVORO: TStringField;
    selI090TSINDICI: TStringField;
    selI090FRAZIONANOTTE: TStringField;
    selI090TSAUSILIARIO: TStringField;
    selI090TIMBORIG_VERSO: TStringField;
    selI090TIMBORIG_CAUSALE: TStringField;
    selI090RAGIONE_SOCIALE: TStringField;
    selI090VERSIONEDB: TStringField;
    selI090CODICE_INTEGRAZIONE: TStringField;
    selI090VALID_UTENTE: TIntegerField;
    selI075Dist: TOracleDataSet;
    dsrI061: TDataSource;
    OperSQL: TOracleQuery;
    UpdI060: TOracleQuery;
    selI060: TOracleDataSet;
    selI061RICEZIONE_MAIL: TStringField;
    selI061ITER_AUTORIZZATIVI: TStringField;
    selI061LOGIN_DEFAULT: TStringField;
    selTabellaEMAIL_PEC: TStringField;
    selTabellaCELLULARE: TStringField;
    selI061AUTO_ESCLUSIONE: TStringField;
    selI060NomeUtente: TOracleQuery;
    selTabellaNOME_UTENTE2: TStringField;
    selI060NomeUtenteUnivoco: TOracleQuery;
    selTabellaEMAIL_PERSONALE: TStringField;
    selTabellaCELLULARE_PERSONALE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure selI061BeforeEdit(DataSet: TDataSet);
    procedure selI061BeforeInsert(DataSet: TDataSet);
    procedure selI061BeforePost(DataSet: TDataSet);
    procedure selI061ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selUser_TriggersBeforeDelete(DataSet: TDataSet);
    procedure selUser_TriggersBeforeInsert(DataSet: TDataSet);
    procedure selI071FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selI065CalcFields(DataSet: TDataSet);
    procedure selI065BeforePost(DataSet: TDataSet);
    procedure selI065AfterPost(DataSet: TDataSet);
    procedure UpdI060AfterQuery(Sender: TOracleQuery);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure insI060AfterQuery(Sender: TOracleQuery);
    procedure InsI061AfterQuery(Sender: TOracleQuery);
    procedure delI060AfterQuery(Sender: TOracleQuery);
    procedure delI060FiltriAfterQuery(Sender: TOracleQuery);
    procedure selI061FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    FImpostazioneDatiAccountDaDominio: Boolean;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    FiltroProfiliI061:TFiltroProfiliI061;
    AziendaCorrente:String;
    selTI061VisioneCorrente:Boolean;
    procedure CambiaDataBase;
    procedure OpenI061;
    procedure I060SettaFiltroI061;
    procedure ImpostaDatiAccountDaDominio;
  end;

implementation

uses WA186ULoginDipendenti,WA186ULoginDipendentiBrowseFM;

{$R *.dfm}

procedure TWA186FLoginDipendentiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY I060.NOME_UTENTE');
  NonAprireSelTabella:=True;
//  selTabella.SetVariable('C700SelAnagrafe',' T030_ANAGRAFICO WHERE PROGRESSIVO = -1');

  // inizializzazioni
  FImpostazioneDatiAccountDaDominio:=False;

  TWA186FLoginDipendenti(Self.Owner).grdC700.WC700FM.C700MergeSelAnagrafe(selTabella);
  TWA186FLoginDipendenti(Self.Owner).grdC700.WC700FM.C700MergeSettaPeriodo(selTabella,Parametri.DataLavoro,Parametri.DataLavoro);

  inherited;

  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';
  if Parametri.Azienda <> 'AZIN' then
  begin
    QI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    QI090.Filtered:=True;
  end;
  QI090.Open;
  QI090.SearchRecord('AZIENDA',Parametri.Azienda,[srFromBeginning]);
 
  if Parametri.Azienda <> 'AZIN' then
  begin
    selI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selI090.Filtered:=True;
  end;
  selTI061VisioneCorrente:=False;
  selI090.Open;
  selI071.Open;
  selI072Dist.Open;
  selI073Dist.Open;
  selI074Dist.Open;
  selI075Dist.Open;
  selI065.Open;
  CambiaDatabase;
end;

procedure TWA186FLoginDipendentiDM.CambiaDataBase;
begin
  //Apertura del database indicato da QI090
  AziendaCorrente:=QI090.FieldByName('AZIENDA').AsString;
  selI071.Filtered:=False;
  selI072Dist.Filtered:=False;
  selI073Dist.Filtered:=False;
  selI074Dist.Filtered:=False;
  selI075Dist.Filtered:=False; // bugfix
  selI071.Filtered:=True;
  selI072Dist.Filtered:=True;
  selI073Dist.Filtered:=True;
  selI074Dist.Filtered:=True;
  selI075Dist.Filtered:=True; // bugfix

  with DbIris008B do
  begin
    if (not Connected) or
       (UpperCase(LogonUserName) <> UpperCase(QI090.FieldByName('UTENTE').AsString)) then
    begin
      Logoff;
      LogonDataBase:=Parametri.Database;
      LogonUserName:=QI090.FieldByName('UTENTE').AsString;
      LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
      Preferences.UseOCI7:=False;
      BytesPerCharacter:=bc1Byte;
    end;
    {$IFDEF IRISWEB}
      ThreadSafe:=True;
    {$ENDIF}
    Logon;
    TWA186FLoginDipendenti(Self.Owner).MessaggioStatus(INFORMA,'');
    selaT030.Open;
    selUser_Triggers.Open;

    selI060.Close;
    selI060.SetVariable('AZIENDA',AziendaCorrente);
    selI060.Open;

    selTabella.Close;
    selTabella.SetVariable('AZIENDA',AziendaCorrente);
    selTabella.Open;
    selTabella.First;
  end;
end;

procedure TWA186FLoginDipendentiDM.selI065AfterPost(DataSet: TDataSet);
begin
  inherited;
  selI065U.Refresh;
  selI065P.Refresh;
end;

procedure TWA186FLoginDipendentiDM.selI065BeforePost(DataSet: TDataSet);
var ODS:TOracleDataSet;
begin
  with selI065.FieldByName('C_TIPO') do
  begin
    if (Trim(UpperCase(AsString)) <> 'PASSWORD') and (Trim(UpperCase(AsString)) <> 'UTENTE') then
      Raise Exception.Create('Il campo Tipo non è valido!');
    selI065.FieldByName('TIPO').AsString:=ifthen((Trim(UpperCase(AsString)) = 'PASSWORD'),'P','U');
  end;
  selI065.FieldByName('CODICE').AsString:=Trim(selI065.FieldByName('CODICE').AsString);
  ODS:=TOracleDataset.Create(nil);
  try
    ODS.Session:=SessioneOracle;
    ODS.SQL.Text:='SELECT :ESPRESSIONE ESPRESSIONE FROM T030_ANAGRAFICO WHERE PROGRESSIVO = 0';
    ODS.DeclareVariable('ESPRESSIONE',otSubst);
    ODS.SetVariable('ESPRESSIONE',DataSet.FieldByName('ESPRESSIONE').AsString);
    try
      ODS.Open;
    except
      on E:Exception do
       Raise Exception.Create('Il campo espressione non è un comando SQL valido!');
    end;
  finally
    FreeAndNil(ODS);
  end;

end;

procedure TWA186FLoginDipendentiDM.selI065CalcFields(DataSet: TDataSet);
begin
  selI065.FieldByName('C_TIPO').AsString:=ifthen(selI065.FieldByName('TIPO').AsString='P','Password','Utente');
end;

procedure TWA186FLoginDipendentiDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if selTabella.RecordCount = 0 then
   OpenI061;
  if selI090.Active then
    selTabella.FieldByName('NOME_UTENTE2').Visible:=(not QI090.FieldByName('DOMINIO_DIP').IsNull) and
                                                    (QI090.FieldByName('DOMINIO_DIP_TIPO').AsString = 'LDAP');
end;

procedure TWA186FLoginDipendentiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  if selTabella.FieldByName('PASSWORD').IsNull then
    selTabella.FieldByName('D_PASSWORD').AsString:='<No password>'
  else
    selTabella.FieldByName('D_PASSWORD').AsString:=StringReplace(Format('%*s',[Length(selTabella.FieldByName('PASSWORD').AsString),'*']),' ','*',[rfReplaceAll]);
end;

procedure TWA186FLoginDipendentiDM.OnNewRecord(DataSet: TDataSet);
begin
  selTabella.FieldByName('AZIENDA').AsString:=QI090.FieldByName('AZIENDA').AsString;
  inherited;
end;

procedure TWA186FLoginDipendentiDM.OpenI061;
begin
  if Not selTabella.Active then
    Exit;
  if VarToStr(selI061.GetVariable('AZIENDA')) <> selTabella.FieldByName('AZIENDA').AsString then
  begin
    selI061.SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
    selI061.Close;
  end;
  if VarToStr(selI061.GetVariable('NOME_UTENTE')) <> selTabella.FieldByName('NOME_UTENTE').AsString then
  begin
    selI061.SetVariable('NOME_UTENTE',selTabella.FieldByName('NOME_UTENTE').AsString);
    selI061.Close;
  end;
  selI061.Open;
end;

procedure TWA186FLoginDipendentiDM.RelazionaTabelleFiglie;
begin
  R180SetVariable(selI061,'AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
  R180SetVariable(selI061,'NOME_UTENTE',selTabella.FieldByName('NOME_UTENTE').AsString);
  selI061.Open;
end;

procedure TWA186FLoginDipendentiDM.AfterScroll(DataSet: TDataSet);
begin
  if not selTabella.Active then
    Exit;
  inherited;
  OpenI061;

  // modifica delegato_da.ini
  // imposta colonna "delegato da"
  // propone elenco dei nomi utenti diversi da quello selezionato
  selI060.First;
  // modifica delegato_da.fine
end;

procedure TWA186FLoginDipendentiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  delI061.SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
  delI061.SetVariable('NOME_UTENTE',selTabella.FieldByName('NOME_UTENTE').AsString);
  delI061.Execute;
end;

procedure TWA186FLoginDipendentiDM.BeforePostNoStorico(DataSet: TDataSet);
var
  LADUserInfo: TActiveDirectoryUserInfo;
  LResCtrl: TResCtrl;
  LAggiornaDati: Boolean;

  procedure ControllaNomeUtente(pNomeUtente,pNomeUtente2: string);
  begin
    if (pNomeUtente = '') and (pNomeUtente2 = '') then
      Exit;
    selI060NomeUtenteUnivoco.SetVariable('AZIENDA', selTabella.FieldByName('AZIENDA').AsString);
    selI060NomeUtenteUnivoco.SetVariable('NOME_UTENTE', pNomeUtente);
    selI060NomeUtenteUnivoco.SetVariable('NOME_UTENTE2', pNomeUtente2);
    if selTabella.State = dsEdit then
      selI060NomeUtenteUnivoco.SetVariable('ID_RIGA',selTabella.RowId)
    else
      selI060NomeUtenteUnivoco.SetVariable('ID_RIGA',null);

    selI060NomeUtenteUnivoco.Execute;
    if selI060NomeUtenteUnivoco.FieldAsInteger(0) > 0 then
      raise Exception.Create(A000MSG_A008_NOME_UTENTE_IN_USO);
  end;
begin
  inherited;

  if (not selTabella.FieldByName('MATRICOLA').IsNull) and (VarToStr(selaT030.Lookup('MATRICOLA',selTabella.FieldByName('MATRICOLA').AsString,'MATRICOLA')) = '') then
    raise Exception.Create(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Matricola']));
  if (DataSet.State = dsInsert) or
     (Dataset.FieldByName('PASSWORD').medpOldValue <> Dataset.FieldByName('PASSWORD').Value) then
  begin
    if Length(Dataset.FieldByName('PASSWORD').AsString) < Parametri.LunghezzaPassword then
      if QI090.FieldByName('DOMINIO_DIP').IsNull or (Length(Dataset.FieldByName('PASSWORD').AsString) > 0) then
        raise Exception.Create(Format(A000MSG_A186_ERR_FMT_LUNG_PWD,[Parametri.LunghezzaPassword]));
    Dataset.FieldByName('DATA_PW').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
  end;
  DataSet.FieldByName('CELLULARE').AsString:=Trim(DataSet.FieldByName('CELLULARE').AsString);
  if Length(DataSet.FieldByName('CELLULARE').AsString) > 0 then
  begin
    if Copy(DataSet.FieldByName('CELLULARE').AsString,1,1) <> '3' then
      raise Exception.Create(A000MSG_A186_ERR_INIZ_CELLULARE);
    if Length(DataSet.FieldByName('CELLULARE').AsString) < StrToIntDef(Parametri.CampiRiferimento.C90_CellulareLunghMin,10) then
      raise Exception.Create(Format(A000MSG_A186_ERR_FMT_LUNG_CELLULARE,[StrToIntDef(Parametri.CampiRiferimento.C90_CellulareLunghMin,10)]));
    if not R180TestoInSetCaratteri(DataSet.FieldByName('CELLULARE').AsString,'0123456789') then
      raise Exception.Create(A000MSG_A186_ERR_NON_NUMERICO);
  end;

  //Controlli NOME_UTENTE e NOME_UTENTE2 (non nullo e non duplicato)
  selTabella.FieldByName('NOME_UTENTE').AsString:=Trim(selTabella.FieldByName('NOME_UTENTE').AsString);
  selTabella.FieldByName('NOME_UTENTE2').AsString:=Trim(selTabella.FieldByName('NOME_UTENTE2').AsString);
  if selTabella.FieldByName('NOME_UTENTE').IsNull then
    raise Exception.Create(A000MSG_A008_NOME_UTENTE_MANCANCANTE);
  if UpperCase(selTabella.FieldByName('NOME_UTENTE').AsString) = UpperCase(selTabella.FieldByName('NOME_UTENTE2').AsString) then
    raise Exception.Create(A000MSG_A008_NOME_UTENTE_IN_USO);
  if (selTabella.State = dsInsert) then
    ControllaNomeUtente(selTabella.FieldByName('NOME_UTENTE').AsString, selTabella.FieldByName('NOME_UTENTE2').AsString)
  else if (selTabella.State = dsEdit) then
    ControllaNomeUtente(
      IfThen(selTabella.FieldByName('NOME_UTENTE').AsString <> VarToStr(selTabella.FieldByName('NOME_UTENTE').medpOldValue),selTabella.FieldByName('NOME_UTENTE').AsString),
      IfThen(selTabella.FieldByName('NOME_UTENTE2').AsString <> VarToStr(selTabella.FieldByName('NOME_UTENTE2').medpOldValue),selTabella.FieldByName('NOME_UTENTE2').AsString)
    );

  if selTabella.State = dsInsert then
  begin
    selI061.FieldByName('AZIENDA').AsString:=selTabella.FieldByName('AZIENDA').AsString;
    selI061.FieldByName('NOME_UTENTE').AsString:=selTabella.FieldByName('NOME_UTENTE').AsString;
  end
  else if (selTabella.State = dsEdit) and
          (selTabella.FieldByName('NOME_UTENTE').AsString <> VarToStr(selTabella.FieldByName('NOME_UTENTE').medpOldValue)) then
  begin
    UpdI061.SetVariable('NOME_UTENTENEW',selTabella.FieldByName('NOME_UTENTE').AsString);
    UpdI061.SetVariable('NOME_UTENTEOLD',VarToStr(selTabella.FieldByName('NOME_UTENTE').medpOldValue));
    UpdI061.Execute;
  end;

  // impostazione dei dati da active directory
  // (passaggio evitato se è in corso l'impostazione massiva)
  if not FImpostazioneDatiAccountDaDominio then
  begin
    if (QI090.FieldByName('DOMINIO_DIP').AsString <> '') and
       (Parametri.CampiRiferimento.C90_EmailSincrDominio = 'S') then
    begin
      // verifica se è necessario aggiornare i dati di questo account
      LAggiornaDati:=(selTabella.FieldByName('EMAIL').AsString = '');

      if LAggiornaDati then
      begin
        // estrae info da active directory
        if not IsLibrary then
          CoInitialize(nil);
        try
          LResCtrl:=ADsGetUserInfo(QI090.FieldByName('DOMINIO_DIP').AsString, selTabella.FieldByName('NOME_UTENTE').AsString, LADUserInfo);
        finally
          if not IsLibrary then
            CoUninitialize;
        end;
      if LResCtrl.Ok then
        begin
          // impostazione dei dati letti da active directory
          // IMPORTANTE:
          //   i dati eventualmente impostati NON vengono sovrascritti

          // email
          if selTabella.FieldByName('EMAIL').AsString = '' then
            selTabella.FieldByName('EMAIL').AsString:=LADUserInfo.Email;
        end
        else
        begin
          // errore lettura info da active directory
          // nessuna segnalazione
          //raise Exception.CreateFmt('Errore durante la lettura delle informazioni utente da Active Directory: %s',[LResCtrl.Messaggio]);
        end;
      end;
    end;
  end;
end;

procedure TWA186FLoginDipendentiDM.selI061ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  case Action of
    'I':RegistraLog.SettaProprieta('I','I061_PROFILI_DIPENDENTE',Copy(Name,1,5),selI061,True);
    'U':RegistraLog.SettaProprieta('M','I061_PROFILI_DIPENDENTE',Copy(Name,1,5),selI061,True);
    'D':RegistraLog.SettaProprieta('C','I061_PROFILI_DIPENDENTE',Copy(Name,1,5),selI061,True);
  end;
  if Action in ['I','U','D'] then
    RegistraLog.RegistraOperazione;
end;

procedure TWA186FLoginDipendentiDM.selI061BeforeEdit(DataSet: TDataSet);
begin
  if selTabella.RecordCount <= 0 then
    raise Exception.Create(A000MSG_A186_ERR_NO_UTENTE);
end;

procedure TWA186FLoginDipendentiDM.selI061BeforeInsert(DataSet: TDataSet);
begin
 if selTabella.RecordCount <= 0 then
   raise Exception.Create(A000MSG_A186_ERR_NO_UTENTE);
end;

procedure TWA186FLoginDipendentiDM.selI061BeforePost(DataSet: TDataSet);
begin
  //PALERMO_POLICLINICO - 159894: controllo campo non nullo
  if selI061.FieldByName('NOME_PROFILO').IsNull then
  begin
    MsgBox.WebMessageDlg(A000MSG_A008_ERR_NOMEPROFILO_NULLO,mtError,[mbOK],nil,'');
    Abort;
  end;

  if selI061.FieldByName('PERMESSI').IsNull then
  begin
    MsgBox.WebMessageDlg(A000MSG_A008_ERR_PROFILOPERMESSI_NULLO,mtError,[mbOK],nil,'');
    Abort;
  end;
  if selI061.FieldByName('FILTRO_FUNZIONI').IsNull then
  begin
    MsgBox.WebMessageDlg(A000MSG_A008_ERR_PROFILOFUNZIONI_NULLO,mtError,[mbOK],nil,'');
    Abort;
  end;

  if not selI071.SearchRecord('PROFILO',selI061.FieldByName('PERMESSI').AsString,[srFromBeginning]) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Codice Permessi']),mtError,[mbOK],nil,'');
    Abort;
  end;
  if not selI073Dist.SearchRecord('PROFILO',selI061.FieldByName('FILTRO_FUNZIONI').AsString,[srFromBeginning]) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Fitro funzioni']),mtError,[mbOK],nil,'');
   Abort;
  end;
  if (not selI061.FieldByName('FILTRO_ANAGRAFE').IsNull) and
     (not selI072Dist.SearchRecord('PROFILO',selI061.FieldByName('FILTRO_ANAGRAFE').AsString,[srFromBeginning])) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Filtro anagrafe']),mtError,[mbOK],nil,'');
    Abort;
  end;
  if (not selI061.FieldByName('FILTRO_DIZIONARIO').IsNull) and
     (not selI074Dist.SearchRecord('PROFILO',selI061.FieldByName('FILTRO_DIZIONARIO').AsString,[srFromBeginning])) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Filtro dizionario']),mtError,[mbOK],nil,'');
    Abort;
  end;
  if (not selI061.FieldByName('ITER_AUTORIZZATIVI').IsNull) and
     (not selI075Dist.SearchRecord('PROFILO',selI061.FieldByName('ITER_AUTORIZZATIVI').AsString,[srFromBeginning])) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Iter autorizzativo']),mtError,[mbOK],nil,'');
    Abort;
  end;

  if not R180In(selI061.FieldByName('LOGIN_DEFAULT').AsString,['S','N']) then
  begin
    MsgBox.WebMessageDlg('Il campo Default può contenere solo i valori "S" o "N".',mtError,[mbOK],nil,'');
    Abort;
  end;
  if not R180In(selI061.FieldByName('RICEZIONE_MAIL').AsString,['S','N']) then
  begin
    MsgBox.WebMessageDlg('Il campo Ricezione E-Mail può contenere solo i valori "S" o "N".',mtError,[mbOK],nil,'');
    Abort;
  end;
  if selI061.FieldByName('FILTRO_ANAGRAFE').AsString.Trim = '' then
    selI061.FieldByName('AUTO_ESCLUSIONE').AsString:='N';
  if not R180In(selI061.FieldByName('AUTO_ESCLUSIONE').AsString,['S','N']) then
  begin
    MsgBox.WebMessageDlg('Il campo Autoesclusione può contenere solo i valori "S" o "N".',mtError,[mbOK],nil,'');
    Abort;
  end;

  // modifica delegato_da.ini
  if (not selI061.FieldByName('DELEGATO_DA').IsNull) then
  begin
     if selI061.FieldByName('DELEGATO_DA').AsString = selI061.FieldByName('NOME_UTENTE').AsString then
       raise exception.Create('Il valore di Delegato non è un nome utente valido!')
     else
      begin
        selI060NomeUtente.Close;
        selI060NomeUtente.SetVariable('AZIENDA', AziendaCorrente);
        selI060NomeUtente.SetVariable('NOME_UTENTE',selI061.FieldByName('DELEGATO_DA').AsString);
        selI060NomeUtente.Execute;
        if selI060NomeUtente.FieldAsInteger(0) = 0 then
          raise exception.Create('Il valore di Delegato non è un nome utente valido!');
      end;
  end;
  // modifica delegato_da.fine
end;

procedure TWA186FLoginDipendentiDM.selI061FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=True;
  if selTI061VisioneCorrente then
    Accept:=(selI061.FieldByName('INIZIO_VALIDITA').AsDateTime <= Parametri.DataLavoro) and
            (selI061.FieldByName('FINE_VALIDITA').AsDateTime >= Parametri.DataLavoro);
end;

procedure TWA186FLoginDipendentiDM.selI071FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=DataSet.FieldByName('AZIENDA').AsString = AziendaCorrente;
end;

procedure TWA186FLoginDipendentiDM.selTabellaPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  inherited;
  MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_REG_FALLITA,[E.Message]) ,mtError,[mbOk],nil,'');
  Action:=daAbort;
end;

procedure TWA186FLoginDipendentiDM.selUser_TriggersBeforeDelete(
  DataSet: TDataSet);
begin
  Abort;
end;

procedure TWA186FLoginDipendentiDM.selUser_TriggersBeforeInsert(
  DataSet: TDataSet);
begin
  Abort;
end;

procedure TWA186FLoginDipendentiDM.UpdI060AfterQuery(Sender: TOracleQuery);
begin
  // MONDOEDP - chiamata 85397.ini
  // effettuate alcune correzioni e integrazioni per il log
  RegistraLog.SettaProprieta('M','I060_LOGIN_DIPENDENTE','WA186',nil,True);
  RegistraLog.InserisciDato('AZIENDA',AziendaCorrente,'');
  RegistraLog.InserisciDato('MATRICOLA',selTabella.FieldByName('MATRICOLA').AsString,'');
  RegistraLog.InserisciDato('NOME_UTENTE',UpdI060.GetVariable('NOME_UTENTE'),'');
  RegistraLog.InserisciDato('PASSWORD',selTabella.FieldByName('PASSWORD').AsString,UpdI060.GetVariable('PASSWORD_NEW'));
  if VarToStr(UpdI060.GetVariable('DATAPW')) <> selTabella.FieldByName('DATA_PW').AsString then
    RegistraLog.InserisciDato('DATAPW',selTabella.FieldByName('DATA_PW').AsString,VarToStr(UpdI060.GetVariable('DATAPW')));
  RegistraLog.RegistraOperazione;
  // MONDOEDP - chiamata 85397.ini
end;

procedure TWA186FLoginDipendentiDM.I060SettaFiltroI061;
var Filtro:String;
begin
  Filtro:='';
  if FiltroProfiliI061.Attivo then
  begin
    if FiltroProfiliI061.NomeProfilo <> '' then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('NOME_PROFILO = ''%s''',[FiltroProfiliI061.NomeProfilo]);
    if FiltroProfiliI061.Permessi <> '' then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('PERMESSI = ''%s''',[FiltroProfiliI061.Permessi]);
    if FiltroProfiliI061.FiltroAnagrafe <> '' then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('FILTRO_ANAGRAFE = ''%s''',[FiltroProfiliI061.FiltroAnagrafe]);
    if FiltroProfiliI061.FiltroFunzioni <> ''then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('FILTRO_FUNZIONI = ''%s''',[FiltroProfiliI061.FiltroFunzioni]);
    if FiltroProfiliI061.IterAutorizzativi <> ''then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('ITER_AUTORIZZATIVI = ''%s''',[FiltroProfiliI061.IterAutorizzativi]);
    if FiltroProfiliI061.FiltroDizionario <> ''then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('FILTRO_DIZIONARIO = ''%s''',[FiltroProfiliI061.FiltroDizionario]);
    if Filtro <> '' then
      Filtro:=Format('and exists (select ''X'' from MONDOEDP.I061_PROFILI_DIPENDENTE I061 where I061.NOME_UTENTE = I060.NOME_UTENTE and I061.AZIENDA = I060.AZIENDA and %s)',[Filtro]);
  end;

  selTabella.SetVariable('FILTRO_I061',Filtro);
  selTabella.Close;
  selTabella.Open;
end;

procedure TWA186FLoginDipendentiDM.ImpostaDatiAccountDaDominio;
// impostazione massiva di alcuni dati dell'account da Active Directory
// NOTA:
//   al momento l'unico dato impostato è la mail dell'account
var
  LADUserInfo: TActiveDirectoryUserInfo;
  LResCtrl: TResCtrl;
  LAggiornaDati: Boolean;
begin
  RegistraMsg.IniziaMessaggio('A008');
  RegistraMsg.InserisciMessaggio('I','Impostazione massiva degli indirizzi email degli account da Active Directory');
  try
    // se il dominio non è impostato esce subito
    if QI090.FieldByName('DOMINIO_DIP').AsString = '' then
    begin
      RegistraMsg.InserisciMessaggio('A','Elaborazione impossibile: il dominio di autenticazione per i dipendenti web non è indicato!',Parametri.Azienda);
      Exit;
    end;

    // se la sincronizzazione dati non è attiva esce subito
    if Parametri.CampiRiferimento.C90_EmailSincrDominio <> 'S' then
    begin
      RegistraMsg.InserisciMessaggio('A','Elaborazione impossibile: la sincronizzazione dei dati con Active Directory non è attiva!',Parametri.Azienda);
      Exit;
    end;

    RegistraMsg.InserisciMessaggio('I',Format('Elaborazione di n. %d account utente',[selTabella.RecordCount]),Parametri.Azienda);

    // indica che è in corso l'impostazione massiva dei dati
    FImpostazioneDatiAccountDaDominio:=True;

    // estrae info da active directory per gli utenti nel dataset
    selTabella.DisableControls;
    selTabella.First;
    while not selTabella.Eof do
    begin
      try
        // verifica se è necessario aggiornare i dati di questo account
        LAggiornaDati:=(selTabella.FieldByName('EMAIL').AsString = '');

        if LAggiornaDati then
        begin
          // estrae i dati da Active Directory
          if not IsLibrary then
            CoInitialize(nil);
          try
            LResCtrl:=ADsGetUserInfo(QI090.FieldByName('DOMINIO_DIP').AsString, selTabella.FieldByName('NOME_UTENTE').AsString, LADUserInfo);
          finally
            if not IsLibrary then
              CoUninitialize;
          end;

          if LResCtrl.Ok then
          begin
            try
              // impostazione dei dati letti da active directory
              // IMPORTANTE:
              //   i dati eventualmente impostati NON vengono sovrascritti
              selTabella.Edit;

              // email
              if selTabella.FieldByName('EMAIL').AsString = '' then
                selTabella.FieldByName('EMAIL').AsString:=LADUserInfo.Email;

              selTabella.Post;
              // log
              RegistraMsg.InserisciMessaggio('I',Format('Account utente "%s": informazioni aggiornate correttamente',[selTabella.FieldByName('NOME_UTENTE').AsString]),Parametri.Azienda);
            except
              on E: Exception do
              begin
                // log errore aggiornamento
                RegistraMsg.InserisciMessaggio('A',Format('Account utente "%s": errore durante l''aggiornamento delle informazioni: %s (%s)',[selTabella.FieldByName('NOME_UTENTE').AsString,E.Message,E.ClassName]),Parametri.Azienda);
              end;
            end;
          end
          else
          begin
            // errore lettura info
            RegistraMsg.InserisciMessaggio('A',Format('Account utente "%s": errore nelle lettura delle informazioni da Active Directory: %s',[selTabella.FieldByName('NOME_UTENTE').AsString,LResCtrl.Messaggio]),Parametri.Azienda);
          end;
        end
        else
        begin
          // aggiornamento info non necessario
          RegistraMsg.InserisciMessaggio('I',Format('Account utente "%s": aggiornamento informazioni non necessario',[selTabella.FieldByName('NOME_UTENTE').AsString]),Parametri.Azienda);
        end;
      finally
        selTabella.Next;
      end;
    end;
  finally
    FImpostazioneDatiAccountDaDominio:=False;
    RegistraMsg.InserisciMessaggio('I','Fine elaborazione');
    selTabella.First;
    selTabella.EnableControls;
  end;
end;

procedure TWA186FLoginDipendentiDM.insI060AfterQuery(Sender: TOracleQuery);
begin
  // MONDOEDP - chiamata 85397.ini
  // gestione log per inserimento massivo login
  RegistraLog.SettaProprieta('I','I060_LOGIN_DIPENDENTE','WA186',nil,True);
  RegistraLog.InserisciDato('AZIENDA','',VarToStr(insI060.GetVariable('AZIENDA')));
  RegistraLog.InserisciDato('MATRICOLA','',VarToStr(insI060.GetVariable('MATRICOLA')));
  RegistraLog.InserisciDato('NOME_UTENTE','',VarToStr(insI060.GetVariable('NOMEUTENTE')));
  RegistraLog.InserisciDato('PASSWORD','',VarToStr(insI060.GetVariable('PASSWORD')));
  RegistraLog.InserisciDato('DATA_PW','',VarToStr(insI060.GetVariable('DATAPW')));
  RegistraLog.RegistraOperazione;
  // MONDOEDP - chiamata 85397.fine
end;

procedure TWA186FLoginDipendentiDM.InsI061AfterQuery(Sender: TOracleQuery);
begin
  // MONDOEDP - chiamata 85397.ini
  // gestione log per inserimento massivo login
  RegistraLog.SettaProprieta('I','I061_PROFILI_DIPENDENTE','WA186',nil,True);
  RegistraLog.InserisciDato('AZIENDA','',VarToStr(insI061.GetVariable('AZIENDA')));
  RegistraLog.InserisciDato('NOME_UTENTE','',VarToStr(insI061.GetVariable('NOME_UTENTE')));
  RegistraLog.InserisciDato('NOME_PROFILO','',VarToStr(insI061.GetVariable('NOME_PROFILO')));
  RegistraLog.InserisciDato('FILTRO_FUNZIONI','',VarToStr(insI061.GetVariable('FILTRO_FUNZIONI')));
  RegistraLog.InserisciDato('FILTRO_ANAGRAFE','',VarToStr(insI061.GetVariable('FILTRO_ANAGRAFE')));
  RegistraLog.InserisciDato('FILTRO_DIZIONARIO','',VarToStr(insI061.GetVariable('FILTRO_DIZIONARIO')));
  RegistraLog.InserisciDato('ITER_AUTORIZZATIVI','',VarToStr(insI061.GetVariable('ITER_AUTORIZZATIVI')));
  RegistraLog.InserisciDato('PERMESSI','',VarToStr(insI061.GetVariable('PERMESSI')));
  RegistraLog.InserisciDato('INIZIO_VALIDITA','',VarToStr(insI061.GetVariable('INIZIO_VALIDITA')));
  RegistraLog.InserisciDato('FINE_VALIDITA','',VarToStr(insI061.GetVariable('FINE_VALIDITA')));
  RegistraLog.RegistraOperazione;
  // MONDOEDP - chiamata 85397.fine
end;

procedure TWA186FLoginDipendentiDM.delI060AfterQuery(Sender: TOracleQuery);
begin
  // MONDOEDP - chiamata 85397.ini
  // gestione log per cancellazione massiva login (completa sulla selezione)
  RegistraLog.SettaProprieta('C','I060_LOGIN_DIPENDENTE','WA186',nil,True);
  RegistraLog.InserisciDato('AZIENDA','',VarToStr(delI060.GetVariable('AZIENDA')));
  RegistraLog.InserisciDato('MATRICOLA','',VarToStr(delI060.GetVariable('MATRICOLA')));
  RegistraLog.RegistraOperazione;
  // MONDOEDP - chiamata 85397.fine
end;

procedure TWA186FLoginDipendentiDM.delI060FiltriAfterQuery(Sender: TOracleQuery);
begin
  // MONDOEDP - chiamata 85397.ini
  // gestione log per cancellazione massiva login (con filtri)
  // se il login è stato effettivamente eliminato registra il log
  if StrToInt(VarToStr(delI060Filtri.GetVariable('RECORD_ELIMINATI'))) > 0 then
  begin
    RegistraLog.SettaProprieta('C','I060_LOGIN_DIPENDENTE','WA186',nil,True);
    RegistraLog.InserisciDato('AZIENDA','',VarToStr(delI060Filtri.GetVariable('AZIENDA')));
    RegistraLog.InserisciDato('MATRICOLA','',VarToStr(delI060Filtri.GetVariable('MATRICOLA')));
    RegistraLog.RegistraOperazione;
  end;
  // MONDOEDP - chiamata 85397.fine
end;
end.
