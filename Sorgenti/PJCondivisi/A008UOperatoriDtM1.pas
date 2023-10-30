unit A008UOperatoriDtM1;

interface

uses
  {$IFDEF DEBUG} OracleMonitor, {$ENDIF DEBUG}
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, dbctrls, DBGrids, Math, A000UCostanti, A000USessione, A000UInterfaccia,
  A001UADsHlp, C180FunzioniGenerali, System.UITypes,
  RegistrazioneLog, L021Call, OracleData, Oracle, Variants, USelI010, DBClient,
  A181UAziendeMW, A185UFiltroDizionarioMW, RegolePassword, A000UMessaggi;

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

  TA008FOperatoriDtm1 = class(TDataModule)
    D090: TDataSource;
    D091: TDataSource;
    QI090: TOracleDataSet;
    QI090AZIENDA: TStringField;
    QI090DESCRIZIONE: TStringField;
    QI090INDIRIZZO: TStringField;
    QI090STORIAINTERVENTO: TStringField;
    QI090UTENTE: TStringField;
    QI090PAROLACHIAVE: TStringField;
    QI090TSLAVORO: TStringField;
    QI090TSINDICI: TStringField;
    QI092: TOracleDataSet;
    QI070: TOracleDataSet;
    QI070AZIENDA: TStringField;
    QI070UTENTE: TStringField;
    QI070PASSWD: TStringField;
    QI070OCCUPATO: TStringField;
    QI070INTEGRAZIONEANAGRAFE: TStringField;
    QI070D_Azienda: TStringField;
    T035: TOracleDataSet;
    OperSQL: TOracleQuery;
    DbIris008B: TOracleSession;
    QI070SBLOCCO: TStringField;
    QI090TIMBORIG_VERSO: TStringField;
    QI090TIMBORIG_CAUSALE: TStringField;
    selI071: TOracleDataSet;
    selI072: TOracleDataSet;
    selI073: TOracleDataSet;
    selI074: TOracleDataSet;
    selI072Dist: TOracleDataSet;
    selI073Dist: TOracleDataSet;
    selI074Dist: TOracleDataSet;
    dsrI072Dist: TDataSource;
    dsrI073Dist: TDataSource;
    dsrI074Dist: TDataSource;
    dsrI071: TDataSource;
    dsrI072: TDataSource;
    dsrI073: TDataSource;
    dsrI074: TDataSource;
    insI071: TOracleQuery;
    selValues: TOracleDataSet;
    insI072: TOracleQuery;
    insI073: TOracleQuery;
    insI074: TOracleQuery;
    QI070PERMESSI: TStringField;
    QI070FILTRO_ANAGRAFE: TStringField;
    QI070FILTRO_FUNZIONI: TStringField;
    QI070FILTRO_DIZIONARIO: TStringField;
    QI070PROGRESSIVO: TIntegerField;
    selI073PROFILO: TStringField;
    selI073APPLICAZIONE: TStringField;
    selI073TAG: TIntegerField;
    selI073FUNZIONE: TStringField;
    selI073GRUPPO: TStringField;
    selI073DESCRIZIONE: TStringField;
    selI073INIBIZIONE: TStringField;
    selT033: TOracleDataSet;
    dsrT033: TDataSource;
    QI090CODICE_INTEGRAZIONE: TStringField;
    QI060: TOracleDataSet;
    QI060AZIENDA: TStringField;
    QI060MATRICOLA: TStringField;
    QI060NOME_UTENTE: TStringField;
    QI060PASSWORD: TStringField;
    selI090: TOracleDataSet;
    dselI090: TDataSource;
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
    selI090TIMBORIG_VERSO: TStringField;
    selI090TIMBORIG_CAUSALE: TStringField;
    selI090RAGIONE_SOCIALE: TStringField;
    selI090VERSIONEDB: TStringField;
    selI090CODICE_INTEGRAZIONE: TStringField;
    dselI060: TDataSource;
    selI060: TOracleDataSet;
    insI060: TOracleQuery;
    selaT030: TOracleDataSet;
    QI060D_NOMINATIVO: TStringField;
    selaT030MATRICOLA: TStringField;
    selaT030NOMINATIVO: TStringField;
    delI060: TOracleQuery;
    QI060D_PASSWORD: TStringField;
    QI070DATA_PW: TDateTimeField;
    QI060DATA_PW: TDateTimeField;
    QI070ScadenzaPasswd: TDateField;
    QI090LUNG_PASSWORD: TIntegerField;
    QI090VALID_PASSWORD: TIntegerField;
    QI070NUOVA_PASSWORD: TStringField;
    QI070DATA_ACCESSO: TDateTimeField;
    QI090VALID_UTENTE: TIntegerField;
    selI090VALID_UTENTE: TIntegerField;
    QI070ScadenzaUtente: TDateField;
    selUser_Triggers: TOracleDataSet;
    QI070ACCESSO_NEGATO: TStringField;
    selI070Accessi: TOracleDataSet;
    selVSESSION: TOracleDataSet;
    selI070AccessiAZIENDA: TStringField;
    selI070AccessiUTENTE: TStringField;
    selI070AccessiACCESSO_NEGATO: TStringField;
    dsrVSESSION: TDataSource;
    selVSESSIONSID: TFloatField;
    selVSESSIONSERIAL: TFloatField;
    selVSESSIONSTATUS: TStringField;
    selVSESSIONUSERNAME: TStringField;
    selVSESSIONOSUSER: TStringField;
    selVSESSIONMACHINE: TStringField;
    selVSESSIONTERMINAL: TStringField;
    selVSESSIONPROGRAM: TStringField;
    selI070AccessiPROGRESSIVO: TIntegerField;
    delI060Filtri: TOracleQuery;
    QI090TSAUSILIARIO: TStringField;
    selI090TSAUSILIARIO: TStringField;
    QI090PATHALLCLIENT: TStringField;
    QI070VALIDITA_CESSATI: TIntegerField;
    selI073AZIENDA: TStringField;
    QI090DOMINIO_USR: TStringField;
    QI090DOMINIO_DIP: TStringField;
    selI061: TOracleDataSet;
    dsrI061: TDataSource;
    selI061AZIENDA: TStringField;
    selI061NOME_UTENTE: TStringField;
    selI061NOME_PROFILO: TStringField;
    selI061PERMESSI: TStringField;
    selI061FILTRO_FUNZIONI: TStringField;
    selI061FILTRO_ANAGRAFE: TStringField;
    selI061FILTRO_DIZIONARIO: TStringField;
    selI061INIZIO_VALIDITA: TDateTimeField;
    selI061FINE_VALIDITA: TDateTimeField;
    delI061: TOracleQuery;
    UpdI061: TOracleQuery;
    InsI061: TOracleQuery;
    QI060NOMI_PROFILI: TStringField;
    QI060EMAIL: TStringField;
    selI061Dist: TOracleDataSet;
    selPermessi: TOracleQuery;
    selFiltroAnagrafe: TOracleQuery;
    selFiltroFunzioni: TOracleQuery;
    selFiltroDizionario: TOracleQuery;
    delI073: TOracleQuery;
    QI090DOMINIO_DIP_TIPO: TStringField;
    QI090DOMINIO_USR_TIPO: TStringField;
    updI073: TOracleQuery;
    selI061DELEGATO_DA: TStringField;
    selI061FINE_VALIDITA2: TDateTimeField;
    selI075Dist: TOracleDataSet;
    selI061ITER_AUTORIZZATIVI: TStringField;
    dsrI075: TDataSource;
    dsrI075Dist: TDataSource;
    insI075: TOracleQuery;
    selI075: TOracleDataSet;
    delI075: TOracleQuery;
    selI075ITER: TStringField;
    selI075LIVELLO: TIntegerField;
    selI075ACCESSO: TStringField;
    cdsI075LookUp: TClientDataSet;
    cdsI075LookUpCODICE: TStringField;
    cdsI075LookUpDESCRIZIONE: TStringField;
    selI075D_ACCESSO: TStringField;
    selI075D_ITER: TStringField;
    selIterAutorizzativi: TOracleQuery;
    selI075AZIENDA: TStringField;
    selI075PROFILO: TStringField;
    insI075_2: TOracleQuery;
    selI075COD_ITER: TStringField;
    selI061RICEZIONE_MAIL: TStringField;
    selSG746: TOracleDataSet;
    QI060C_PWD_DECRIPTATA: TStringField;
    QI090PASSWORD_CIFRE: TIntegerField;
    QI090PASSWORD_MAIUSCOLE: TIntegerField;
    QI090PASSWORD_CARSPECIALI: TIntegerField;
    UpdI060: TOracleQuery;
    selI065P: TOracleDataSet;
    dsrI065P: TDataSource;
    selI065U: TOracleDataSet;
    dsrI065U: TDataSource;
    selI065: TOracleDataSet;
    dsrI065: TDataSource;
    selI065TIPO: TStringField;
    selI065CODICE: TStringField;
    selI065ESPRESSIONE: TStringField;
    selI065C_TIPO: TStringField;
    testFiltroAnagrafe: TOracleDataSet;
    testFiltroAnagrafeMATRICOLA: TStringField;
    testFiltroAnagrafeCOGNOME: TStringField;
    testFiltroAnagrafeNOME: TStringField;
    testFiltroAnagrafeT430INIZIO: TDateTimeField;
    testFiltroAnagrafeT430FINE: TDateTimeField;
    dsrTestFiltroAnagrafe: TDataSource;
    QI090AGGIORNAMENTO_ABILITATO: TStringField;
    QI090GRUPPO_BADGE: TStringField;
    QI090LOGIN_USR_ABILITATO: TStringField;
    QI090LOGIN_DIP_ABILITATO: TStringField;
    selI073ACCESSO_BROWSE: TStringField;
    selI073RIGHE_PAGINA: TIntegerField;
    selI073Agg: TOracleDataSet;
    insI073Agg: TOracleQuery;
    updI073Agg: TOracleQuery;
    delI073Agg: TOracleQuery;
    selI061LOGIN_DEFAULT: TStringField;
    QI060EMAIL_PEC: TStringField;
    selApplicativiOperatore: TOracleDataSet;
    selApplicativiNew: TOracleDataSet;
    QI060CELLULARE: TStringField;
    selI076: TOracleDataSet;
    selI076AZIENDA: TStringField;
    selI076PROFILO: TStringField;
    selI076APPLICAZIONE: TStringField;
    selI076TAG: TIntegerField;
    selI076IP: TStringField;
    selI076CONSENTITO: TStringField;
    selI076IP_ESTERNO: TStringField;
    selI061AUTO_ESCLUSIONE: TStringField;
    QI060NOMINATIVO_QRY: TStringField;
    QI070T030_PROGRESSIVO: TIntegerField;
    selT030: TOracleDataSet;
    QI090DOMINIO_LDAP_DN: TStringField;
    selI060NomeUtente: TOracleQuery;
    QI090DOMINIO_LDAP_SUFFISSO: TStringField;
    QI060NOME_UTENTE2: TStringField;
    selI060NomeUtenteUnivoco: TOracleQuery;
    selI060UtentiRipetuti: TOracleQuery;
    QI060CELLULARE_PERSONALE: TStringField;
    QI060EMAIL_PERSONALE: TStringField;
    selVersione: TOracleDataSet;
    procedure QI060FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure I070PASSWDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure I070PASSWDSetText(Sender: TField; const Text: string);
    procedure QI070PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure I071BeforeInsert(DataSet: TDataSet);
    procedure QI070BeforePost(DataSet: TDataSet);
    procedure QI070AfterPost(DataSet: TDataSet);
    procedure QI070BeforeDelete(DataSet: TDataSet);
    procedure QI070AfterDelete(DataSet: TDataSet);
    procedure BDEQI070UpdateError(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure A008FOperatoriDtM1Create(Sender: TObject);
    procedure A008FOperatoriDtM1Destroy(Sender: TObject);
    procedure QI090AfterPost(DataSet: TDataSet);
    procedure QI090AfterDelete(DataSet: TDataSet);
    procedure QI070AfterCancel(DataSet: TDataSet);
    procedure QI090BeforeDelete(DataSet: TDataSet);
    procedure QI090NewRecord(DataSet: TDataSet);
    procedure QI090AfterScroll(DataSet: TDataSet);
    procedure QI090AfterEdit(DataSet: TDataSet);
    procedure QI090BeforePost(DataSet: TDataSet);
    procedure QI070AfterScroll(DataSet: TDataSet);
    procedure BDEQI090PAROLACHIAVEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure BDEQI090PAROLACHIAVESetText(Sender: TField; const Text: String);
    procedure selI072FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI072DistAfterScroll(DataSet: TDataSet);
    procedure BeforeScroll(DataSet: TDataSet);
    procedure selI010AfterOpen(DataSet: TDataSet);
    procedure selI073FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI074DistAfterScroll(DataSet: TDataSet);
    procedure selI074FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI073BeforeDeleteInsert(DataSet: TDataSet);
    procedure selI073INIBIZIONEValidate(Sender: TField);
    procedure selI073DistAfterScroll(DataSet: TDataSet);
    procedure QI070BeforeInsert(DataSet: TDataSet);
    procedure QI070FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI090AfterScroll(DataSet: TDataSet);
    procedure QI060AfterDelete(DataSet: TDataSet);
    procedure QI060BeforeDelete(DataSet: TDataSet);
    procedure QI060BeforePost(DataSet: TDataSet);
    procedure QI060PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure QI060NewRecord(DataSet: TDataSet);
    procedure QI060CalcFields(DataSet: TDataSet);
    procedure QI070CalcFields(DataSet: TDataSet);
    procedure selI070AccessiBeforeDelete(DataSet: TDataSet);
    procedure selI070AccessiBeforeInsert(DataSet: TDataSet);
    procedure selUser_TriggersBeforeDelete(DataSet: TDataSet);
    procedure selUser_TriggersBeforeInsert(DataSet: TDataSet);
    procedure selI070AccessiBeforePost(DataSet: TDataSet);
    procedure selI073NewRecord(DataSet: TDataSet);
    procedure selI071FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QI070AZIENDAValidate(Sender: TField);
    procedure selI061BeforePost(DataSet: TDataSet);
    procedure selI061NewRecord(DataSet: TDataSet);
    procedure selI061BeforeEdit(DataSet: TDataSet);
    procedure selI061BeforeInsert(DataSet: TDataSet);
    procedure selI071AfterOpen(DataSet: TDataSet);
    procedure selI071BeforePost(DataSet: TDataSet);
    procedure selI061ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure QI090DOMINIO_DIP_TIPOChange(Sender: TField);
    procedure selI073BeforePost(DataSet: TDataSet);
    procedure selI075DistAfterScroll(DataSet: TDataSet);
    procedure selI075CalcFields(DataSet: TDataSet);
    procedure selI075NewRecord(DataSet: TDataSet);
    procedure selI075ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selI065AfterPost(DataSet: TDataSet);
    procedure selI065BeforePost(DataSet: TDataSet);
    procedure UpdI060AfterQuery(Sender: TOracleQuery);
    procedure selI065CalcFields(DataSet: TDataSet);
    procedure QI060AfterOpen(DataSet: TDataSet);
    procedure QI060AfterScroll(DataSet: TDataSet);
    procedure DbIris008BAfterLogOn(Sender: TOracleSession);
    procedure QI090FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI076BeforePost(DataSet: TDataSet);
    procedure selI076NewRecord(DataSet: TDataSet);
    procedure selI061FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI073AfterRefresh(DataSet: TDataSet);
    procedure selI073BeforeRefresh(DataSet: TDataSet);
    procedure dsrI061StateChange(Sender: TObject);
    procedure selI061DistBeforeOpen(DataSet: TDataSet);
    procedure QI060BeforeOpen(DataSet: TDataSet);
    procedure selI072BeforeOpen(DataSet: TDataSet);
    procedure selI071BeforeOpen(DataSet: TDataSet);
    procedure selI073BeforeOpen(DataSet: TDataSet);
    procedure selI074BeforeOpen(DataSet: TDataSet);
    procedure selI075BeforeOpen(DataSet: TDataSet);
    procedure selaT030BeforeOpen(DataSet: TDataSet);
    procedure selI072DistBeforeOpen(DataSet: TDataSet);
    procedure selI073DistBeforeOpen(DataSet: TDataSet);
    procedure selI074DistBeforeOpen(DataSet: TDataSet);
    procedure selI075DistBeforeOpen(DataSet: TDataSet);
    procedure QI070BeforeOpen(DataSet: TDataSet);
  private
    Inserimento072:Boolean;
    VecchiaAzienda:String;
    CdFnz,CdFnzWeb:TStringList;
    selI010:TSelI010;
    FImpostazioneDatiAccountDaDominio: Boolean;
    A008selI073RecNo:Integer;
    procedure CreaInsert;
    procedure EliminaFunzioniInesistenti;
    procedure NascondiDBGridColumns(var INDBGrid:TDBGrid);
    procedure A008_QI091AfterScroll(DataSet:TOracleDataSet);
  public
    A181MW:TA181FAziendeMW;
    A185MW:TA185FFiltroDizionarioMW;
    BrowseProfili:Boolean;
    AziendaCorrente:String;
    FiltroProfiliI061:TFiltroProfiliI061;
    selI061VisioneCorrente:Boolean;
    procedure AggiornaI073;
    procedure FiltraSelI075;
    procedure GetFiltroAnagrafe;
    procedure PutFiltroAnagrafe;
    procedure PutFiltroDizionario;
    procedure CreaFiltroFunzioni(Azienda,Profilo:String);
    procedure CambioDataBase;
    procedure AggiornaFiltroProfili;
    procedure OpenI061;
    procedure I060SettaFiltroI061;
    procedure ImpostaDatiAccountDaDominio;
  end;

var
  A008FOperatoriDtm1: TA008FOperatoriDtm1;

implementation

uses A008UOperatori, A008UAziende, A008UProfili, A008ULoginDipendenti, A008UCambioPassword;

{$R *.DFM}

procedure TA008FOperatoriDtm1.A008FOperatoriDtM1Create(Sender: TObject);
var i:Integer;
begin
  CdFnz:=TStringList.Create;
  CdFnzWeb:=TStringList.Create;
  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';

  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if (Components[i] is TOracleQuery) and ((Components[i] as TOracleQuery).Session = nil) then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if (Components[i] is TOracleDataSet) and ((Components[i] as TOracleDataSet).Session = nil) then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;

  // Massimo 14/12/2012 gestione A181UAziendeMW
  A181MW:=TA181FAziendeMW.Create(nil);
  A181MW.A181MW_QI091AfterScroll:=A008_QI091AfterScroll;
  A181MW.QI090:=QI090;
  D091.DataSet:=A181MW.QI091;
  QI060.SetVariable('COLONNA_ORD','I060.NOME_UTENTE');
  QI060.SetVariable('TIPO_ORD','ASC');

  // Bruno 03/07/2015
  A185MW:=TA185FFiltroDizionarioMW.Create(nil);

  BrowseProfili:=True;

  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';
  A181MW.selDizionario.Session:=DbIris008B;
  A181MW.QCols.Session:=DbIris008B;
  selI073.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  selI073.SetVariable('COLONNA_ORDER','null');
  selI073Agg.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  QI090.AfterScroll:=nil;
  if Parametri.Azienda <> 'AZIN' then
  begin
    //QI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    QI090.Filtered:=True;
  end;
  QI090.Open;
  DbIris008B.LogonDatabase:=Parametri.Database;
  DbIris008B.LogonUserName:=QI090.FieldByName('UTENTE').AsString;
  DbIris008B.LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
  DbIris008B.Preferences.UseOci7:=False;
  DbIris008B.BytesPerCharacter:=bc1Byte;
  DbIris008B.Logon;
  selI010:=TselI010.Create(Self);
  selI010.AfterOpen:=selI010AfterOpen;
  try
    selI010.Apri(DbIris008B,'',Parametri.Applicazione,'','','');
  except
    on E:Exception do ShowMessage(E.Message);
  end;
  if Parametri.Azienda <> 'AZIN' then
  begin
    selI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selI090.Filtered:=True;
  end;
  selI090.Open;
  try
    selT033.Open;
    selaT030.Open;
    A181MW.selDizionario.Open;
  except
  end;

  selVSESSION.Filter:='USERNAME = ''' + Parametri.Username + '''';
  selVSESSION.Filtered:=Parametri.Azienda <> 'AZIN';
  selI070Accessi.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
  selI070Accessi.Filtered:=Parametri.Azienda <> 'AZIN';
  //QI070.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
  QI070.Filtered:=Parametri.Azienda <> 'AZIN';
  QI070.Open;
  Inserimento072:=False;
  VecchiaAzienda:='';
  A181MW.AggiornaDatiEnte;
  QI070.SearchRecord('AZIENDA;UTENTE',VararrayOf([Parametri.Azienda,Parametri.Operatore]),[srfromBeginning]);
  //LooUp tipo accesso maschera dei profili
  cdsI075LookUp.Open;
  cdsI075LookUp.Append;
  cdsI075LookUp.FieldByName('CODICE').AsString:='N';
  cdsI075LookUp.FieldByName('DESCRIZIONE').AsString:='Negato';
  cdsI075LookUp.Post;
  cdsI075LookUp.Append;
  cdsI075LookUp.FieldByName('CODICE').AsString:='F';
  cdsI075LookUp.FieldByName('DESCRIZIONE').AsString:='Da filtro funzioni';
  cdsI075LookUp.Post;
  cdsI075LookUp.Append;
  cdsI075LookUp.FieldByName('CODICE').AsString:='R';
  cdsI075LookUp.FieldByName('DESCRIZIONE').AsString:='Sola lettura';
  cdsI075LookUp.Post;
  (* spostato in azione esplicita in A008UProfili
  //Aggiornamento filtro funzioni
  if DebugHook = 0 then
    AggiornaI073;*)
  selI071.Open;
  selI072.Open;
  selI073.Open;
  selI074.Open;
  selI072Dist.Open;
  selI073Dist.Open;
  selI074Dist.Open;
  selI075Dist.Open;
  CreaInsert;
  // inizializzazioni
  FImpostazioneDatiAccountDaDominio:=False;

  selI061VisioneCorrente:=False;
end;

procedure TA008FOperatoriDtm1.A008_QI091AfterScroll(DataSet:TOracleDataSet);
var
  i:Integer;
begin
  for i:=1 to High(DatiEnte) do
    if DataSet.FieldByName('TIPO').AsString = DatiEnte[i].Nome then
    begin
      DataSet.FieldByName('DATO').ReadOnly:=(DatiEnte[i].Lista <> '') and (DatiEnte[i].Lista <> 'NUMERICO') and (DatiEnte[i].Lista <> 'GIORNO_MESE') and (DatiEnte[i].Lista <> 'ORA');
      if A008FAziende <> nil then
      try
        if A008FAziende.DButton.State = dsBrowse then
          DataSet.FieldByName('DATO').ReadOnly:=True;
        if (DatiEnte[i].Lista = '') or (DatiEnte[i].Lista = 'NUMERICO') or (DatiEnte[i].Lista = 'GIORNO_MESE') or (DatiEnte[i].Lista = 'ORA') then
          A008FAziende.DbGrid1.Columns[2].ButtonStyle:=cbsNone
        else
          A008FAziende.DbGrid1.Columns[2].ButtonStyle:=cbsEllipsis;
      except
      end;
    end;
end;

procedure TA008FOperatoriDtm1.NascondiDBGridColumns(var INDBGrid:TDBGrid);
var i:Integer;
begin
  for i:=0 to INDBGrid.Columns.Count - 1 do
    INDBGrid.Columns[i].Visible:=INDBGrid.Columns[i].Field.Visible;
end;

procedure TA008FOperatoriDtm1.FiltraSelI075;
begin
  R180SetVariable(selI075,'AZIENDA',AziendaCorrente);
  R180SetVariable(selI075,'PROFILO',selI075Dist.FieldByName('PROFILO').AsString);
  if A008FProfili <> nil then
    R180SetVariable(selI075,'ITER',A008FProfili.cmbCodiceIter.Text)
  else
    R180SetVariable(selI075,'ITER',null);
  selI075.ReadBuffer:=IfThen(VarToStr(selI075.GetVariable('ITER')) = '',100,25);
  selI075.Open;
end;

procedure TA008FOperatoriDtm1.CreaInsert;
{Creazione degli script di duplicazione dei profili}
var S:String;
    i:Integer;
begin
  S:='';
  for i:=0 to selI071.FieldCount - 1 do
  begin
    if selI071.Fields[i].FieldName <> 'PROFILO' then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selI071.Fields[i].FieldName;
    end;
  end;
  with insI071 do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO MONDOEDP.I071_PERMESSI (PROFILO,' + S + ')');
    SQL.Add('SELECT :NEW_PROFILO,' + S);
    SQL.Add('FROM MONDOEDP.I071_PERMESSI WHERE PROFILO = :OLD_PROFILO AND AZIENDA = :AZIENDA');
  end;
  S:='';
  for i:=0 to selI072.FieldCount - 1 do
  begin
    if selI072.Fields[i].FieldName <> 'PROFILO' then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selI072.Fields[i].FieldName;
    end;
  end;
  with insI072 do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO MONDOEDP.I072_FILTROANAGRAFE (PROFILO,' + S + ')');
    SQL.Add('SELECT :NEW_PROFILO,' + S);
    SQL.Add('FROM MONDOEDP.I072_FILTROANAGRAFE WHERE PROFILO = :OLD_PROFILO AND AZIENDA = :AZIENDA');
  end;
  S:='';
  for i:=0 to selI073.FieldCount - 1 do
  begin
    if selI073.Fields[i].FieldName <> 'PROFILO' then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selI073.Fields[i].FieldName;
    end;
  end;
  with insI073 do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO MONDOEDP.I073_FILTROFUNZIONI (PROFILO,' + S + ')');
    SQL.Add('SELECT :NEW_PROFILO,' + S);
    //SQL.Add('FROM MONDOEDP.I073_FILTROFUNZIONI WHERE PROFILO = :OLD_PROFILO AND  AZIENDA = :AZIENDA AND APPLICAZIONE = :APPLICAZIONE');
    SQL.Add('FROM MONDOEDP.I073_FILTROFUNZIONI WHERE PROFILO = :OLD_PROFILO AND  AZIENDA = :AZIENDA');
    //SetVariable('APPLICAZIONE',Parametri.Applicazione);
  end;
  S:='';
  for i:=0 to selI074.FieldCount - 1 do
  begin
    if selI074.Fields[i].FieldName <> 'PROFILO' then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selI074.Fields[i].FieldName;
    end;
  end;
  with insI074 do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO MONDOEDP.I074_FILTRODIZIONARIO (PROFILO,' + S + ')');
    SQL.Add('SELECT :NEW_PROFILO,' + S);
    SQL.Add('FROM MONDOEDP.I074_FILTRODIZIONARIO WHERE PROFILO = :OLD_PROFILO AND AZIENDA = :AZIENDA');
  end;
end;

procedure TA008FOperatoriDtm1.DbIris008BAfterLogOn(Sender: TOracleSession);
var SetPar:TOracleQuery;
begin
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=Sender;
    SetPar.SQL.Add('ALTER SESSION SET NLS_TERRITORY = AMERICA');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_SORT = BINARY');
    SetPar.Execute;
  finally
    SetPar.Free;
  end;
end;

procedure TA008FOperatoriDtm1.dsrI061StateChange(Sender: TObject);
begin
  A008FLoginDipendenti.frmToolbarFiglio.actTFGenerica2.Enabled:=dsrI061.State = dsBrowse;
end;

procedure TA008FOperatoriDtm1.I070PASSWDGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
{Rende visibile la password}
begin
  Text:=R180DeCriptaI070(Sender.AsString);
end;

procedure TA008FOperatoriDtm1.I070PASSWDSetText(Sender: TField;
  const Text: string);
{Codifica la password prima di registrarla}
begin
  Sender.Value:=R180CriptaI070(Text);
end;

procedure TA008FOperatoriDtm1.QI070PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  ShowMessage('Modifica non riuscita!' + #13#10 + E.Message);
  Action:=daAbort;
end;

procedure TA008FOperatoriDtm1.I071BeforeInsert(DataSet: TDataSet);
{Non permetto l'inserimento automatico nella griglia}
begin
  if not A008FOPeratori.Inserimento then Abort
  else A008FOPeratori.Inserimento:=False;
end;

procedure TA008FOperatoriDtm1.QI070BeforeInsert(DataSet: TDataSet);
begin
  QI070.FieldByName('UTENTE').ReadOnly:=False;
end;

procedure TA008FOperatoriDtm1.QI070BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.QI070BeforePost(DataSet: TDataSet);
{Gestione progressivo operatori e creazione inibizioni a funzioni}
var
  i:Word;
  RegolePassword:TRegolePassword;
  S:String;
  ApplicativiOperatore, ApplicativiNew: TStringList;
  j: Integer;
  Intruso: Boolean;
  LOQ: TOracleQuery;
  LRowIDClause: String;
  LMsg: String;
begin
  if pos(' ', QI070.FieldByName('UTENTE').AsString) > 0 then
    raise exception.Create('L''operatore non può contenere degli spazi');
  if (VarToStr(QI070.FieldByName('FILTRO_FUNZIONI').OldValue) <> '') and
     (QI070.FieldByName('FILTRO_FUNZIONI').OldValue <> QI070.FieldByName('FILTRO_FUNZIONI').Value) and
     (VarToStr(selI073Dist.Lookup('PROFILO',VarToStr(QI070.FieldByName('FILTRO_FUNZIONI').OldValue),'PROFILO')) = '') then
    if MessageDlg('Attenzione!' + #13 +
                  'Risulta già assegnato il Filtro Funzioni ' + VarToStr(QI070.FieldByName('FILTRO_FUNZIONI').OldValue) + #13 +
                  'ma non è visibile in questa applicazione.' + #13 +
                  'Si consiglia di mantenere lo stesso Filtro, creandolo per l''applicazione corrente.' + #13 + #13 +
                  'Creare il Filtro adesso?',
                  mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      selI073.Filtered:=False;
      try
        CreaFiltroFunzioni(QI070.FieldByName('AZIENDA').AsString,VarToStr(QI070.FieldByName('FILTRO_FUNZIONI').OldValue));
      finally
        selI073.Filtered:=True;
        selI073Dist.Refresh;
      end;
      QI070.FieldByName('FILTRO_FUNZIONI').Value:=QI070.FieldByName('FILTRO_FUNZIONI').OldValue;
      ShowMessage('Filtro ' + QI070.FieldByName('FILTRO_FUNZIONI').Value + ' creato.' + #13 +
                  'Ricordarsi di attivare le funzioni desiderate');
    end;

  if QI070.FieldByName('PERMESSI').IsNull then
    raise Exception.Create(A000MSG_A008_ERR_PROFILOPERMESSI_NULLO);
  if QI070.FieldByName('FILTRO_FUNZIONI').IsNull then
    raise Exception.Create(A000MSG_A008_ERR_PROFILOFUNZIONI_NULLO);

  if DataSet.State = dsInsert then
  begin
    with T035 do
    begin
      Open;
      if FieldByName('I070PROGRESSIVO').IsNull then i:=0
      else i:=FieldByName('I070PROGRESSIVO').AsInteger;
      Inc(i);
      Edit;
      FieldByName('PROPERATORI').AsInteger:=i;
      Post;
      Close;
      DataSet.FieldByName('Progressivo').AsInteger:=i;
    end;

    // se è obbligatorio il collegamento ad una anagrafica, verificare che T030_PROGRESSIVO sia valorizzato
    if A181MW.LinkI070T030 = 'O' then
    begin
      if (DataSet.FieldByName('T030_PROGRESSIVO').IsNull) or
         (DataSet.FieldByName('T030_PROGRESSIVO').AsInteger = 0) then
      begin
        raise Exception.CreateFmt('È necessario selezionare l''anagrafica collegata all''operatore %s',[DataSet.FieldByName('UTENTE').AsString]);
      end;
    end;
  end;

  if (DataSet.State = dsInsert) or
     (DataSet.FieldByName('PASSWD').medpOldValue <> DataSet.FieldByName('PASSWD').Value) then
  begin
    with QI090 do
      if FieldByName('DOMINIO_USR').IsNull or (Trim(Dataset.FieldByName('PASSWD').AsString) <> '') then
      try
        RegolePassword:=TRegolePassword.Create(nil);
        RegolePassword.PasswordI060:=False;
        RegolePassword.MesiValidita:=FieldByName('VALID_PASSWORD').AsInteger;
        RegolePassword.Lunghezza:=FieldByName('LUNG_PASSWORD').AsInteger;
        RegolePassword.Cifre:=FieldByName('PASSWORD_CIFRE').AsInteger;
        RegolePassword.Maiuscole:=FieldByName('PASSWORD_MAIUSCOLE').AsInteger;
        RegolePassword.CarSpeciali:=FieldByName('PASSWORD_CARSPECIALI').AsInteger;
        S:=RegolePassword.PasswordValida(R180DecriptaI070(Dataset.FieldByName('PASSWD').AsString));
        if S <> '' then
          raise Exception.Create(s);
      finally
        FreeAndNil(RegolePassword);
      end;
    DataSet.FieldByName('DATA_PW').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
  end;

  // in modifica, verifica che T030_PROGRESSIVO sia valorizzato
  if DataSet.State = dsEdit then
  begin
    // se è obbligatorio il collegamento ad una anagrafica, verifica che T030_PROGRESSIVO sia valorizzato
    // fa eccezione il caso in cui OldValue sia null ->  in tal caso consentire di mantenere il valore nullo.
    if A181MW.LinkI070T030 = 'O' then
    begin
      if (DataSet.FieldByName('T030_PROGRESSIVO').medpOldValue <> null) and
         (DataSet.FieldByName('T030_PROGRESSIVO').medpOldValue <> 0) and
         ((DataSet.FieldByName('T030_PROGRESSIVO').IsNull) or
          (DataSet.FieldByName('T030_PROGRESSIVO').AsInteger = 0)) then
      begin
        raise Exception.CreateFmt('È necessario selezionare l''anagrafica collegata all''operatore %s',[DataSet.FieldByName('UTENTE').AsString]);
      end;
    end;
  end;

  // se il progressivo è valorizzato verifica l'univocità (limitatamente all'azienda)
  // e chiede conferma in caso di violazione
  if DataSet.FieldByName('T030_PROGRESSIVO').AsInteger <> 0 then
  begin
    LMsg:='';
    LRowIDClause:=IfThen(DataSet.State = dsInsert,'',Format(' AND ROWID <> ''%s''',[(DataSet as TOracleDataset).RowId.QuotedString]));
    LOQ:=TOracleQuery.Create(nil);
    try
      try
        LOQ.Session:=SessioneOracle;
        LOQ.SQL.Add(
          Format(
            'select concatena_testo(''SELECT UTENTE FROM MONDOEDP.I070_UTENTI WHERE AZIENDA = ''%s'' AND T030_PROGRESSIVO = %d %s ORDER BY 1'' ,'','') from dual',
            [DataSet.FieldByName('AZIENDA').AsString.QuotedString,
             DataSet.FieldByName('T030_PROGRESSIVO').AsInteger,
             LRowIDClause]));
        LOQ.Execute;
        if not LOQ.Eof then
          LMsg:=LOQ.FieldAsString(0);
      except
      end;
    finally
      FreeAndNil(LOQ);
    end;
    if LMsg <> '' then
    begin
      LMsg:=Format(
              'L''anagrafica di riferimento risulta già associata'#13#10 +
              IfThen(LMsg.Contains(','),
                'ai seguenti operatori:'#13#10'%s',
                'all''operatore "%s".') + #13#10 +
              'Confermare?',
            [LMsg]);
      if R180MessageBox(LMsg,DOMANDA) = mrNo then
        Abort;
    end;
  end;

  // imposta dati per log operazione
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','I070_UTENTI',Copy(Name,1,4),QI070,True);
    dsEdit:RegistraLog.SettaProprieta('M','I070_UTENTI',Copy(Name,1,4),QI070,True);
  end;

  // gestione del cambio del profilo funzioni in base agli applicativi consentiti?
  if DataSet.State in [dsInsert, dsEdit] then
  begin
    if (DataSet.State = dsInsert) or
       (QI070.FieldByName('FILTRO_FUNZIONI').Value <> QI070.FieldByName('FILTRO_FUNZIONI').medpOldValue) then
    begin
      selApplicativiOperatore.Close;
      selApplicativiOperatore.SetVariable('AZIENDA', QI090.FieldByName('AZIENDA').AsString);
      selApplicativiOperatore.SetVariable('PROFILO', Parametri.ProfiloFiltroFunzioni);
      selApplicativiOperatore.Open;

      selApplicativiNew.Close;
      selApplicativiNew.SetVariable('AZIENDA', QI070.FieldByName('AZIENDA').AsString);
      selApplicativiNew.SetVariable('PROFILO', QI070.FieldByName('FILTRO_FUNZIONI').Value);
      selApplicativiNew.Open;

      ApplicativiOperatore:=TStringList.Create;
      ApplicativiNew:=TStringList.Create;

      try
        Intruso:=False;
        while not selApplicativiOperatore.Eof do
        begin
          if Pos(selApplicativiOperatore.FieldByName('APPLICAZIONE').AsString, Parametri.ApplicativiDisponibili) > 0 then
            ApplicativiOperatore.Add(selApplicativiOperatore.FieldByName('APPLICAZIONE').AsString);
          selApplicativiOperatore.Next;
        end;

        while not selApplicativiNew.Eof do
        begin
          if Pos(selApplicativiNew.FieldByName('APPLICAZIONE').AsString, Parametri.ApplicativiDisponibili) > 0 then
            ApplicativiNew.Add(selApplicativiNew.FieldByName('APPLICAZIONE').AsString);
          selApplicativiNew.Next;
        end;

        for j:=0 to ApplicativiNew.Count - 1 do
        begin
          if Pos(ApplicativiNew[j], ApplicativiOperatore.CommaText) = 0  then
          begin
            Intruso:=True;
            Break;
          end;
        end;
        if Intruso then
          raise Exception.Create('Non è possibile assegnare un filtro funzioni che permetta l''accesso a funzioni di altri applicativi');
      finally
        FreeAndNil(ApplicativiOperatore);
        FreeAndNil(ApplicativiNew);
      end;
    end;
  end;
end;

procedure TA008FOperatoriDtm1.QI070AfterPost(DataSet: TDataSet);
var Az,Op:String;
begin
  Az:=DataSet.FieldByName('Azienda').AsString;
  Op:=DataSet.FieldByName('Utente').AsString;
  RegistraLog.RegistraOperazione;
  try
    SessioneOracle.ApplyUpdates([QI070],True);
  except
    SessioneOracle.Rollback;
  end;
  QI070.Close;
  QI070.Open;
  QI070.Locate('Azienda;Utente',VarArrayOf([Az,Op]),[]);
end;

procedure TA008FOperatoriDtm1.BDEQI070UpdateError(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TUpdateAction);
begin
  if UpdateKind in [ukModify,ukInsert] then
    begin
    ShowMessage('Operatore già esistente!');
    UpdateAction:=uaAbort;
    end;
end;

procedure TA008FOperatoriDtm1.QI070BeforeDelete(DataSet: TDataSet);
var S:String;
begin
  if (QI070.FieldByName('UTENTE').AsString = 'SYSMAN') and (QI070.FieldByName('AZIENDA').AsString = 'AZIN') then
    raise Exception.Create('Impossibile cancellare l''utente SYSMAN!');

  S:='';
  with selI071 do
  begin
    First;
    while not Eof do
    begin
      if (FieldByName('LAYOUT').AsString = QI070.FieldByName('UTENTE').AsString) and
         (FieldByName('AZIENDA').AsString = QI070.FieldByName('AZIENDA').AsString) then
        S:=S + IfThen(S <> '',',') + FieldByName('PROFILO').AsString;
      Next;
    end;
    if S <> '' then
      raise Exception.Create('Impossibile cancellare l''utente.' + #13#10 +
                              'E'' usato come layout nei seguenti profili dei Permessi:' + #13#10 + S);
  end;

  RegistraLog.SettaProprieta('C','I070_UTENTI',Copy(Name,1,4),QI070,True);
end;

procedure TA008FOperatoriDtm1.QI070AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  try
    SessioneOracle.ApplyUpdates([QI070],True);
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TA008FOperatoriDtm1.QI070AfterCancel(DataSet: TDataSet);
var i:Integer;
begin
  (DataSet as TOracleDataSet).CancelUpdates;
  A181MW.QI091.ReadOnly:=True;
  //Ripristino la selezione dei log
  with A008FAziende.TabelleLog do
    for i:=0 to Items.Count - 1 do
      Checked[i]:=QI092.Locate('SCHEDA',CdFnz[i],[]);
end;

procedure TA008FOperatoriDtm1.QI090AfterPost(DataSet: TDataSet);
var Az(*AzOld,*):String;
    i:Integer;
begin
  Az:=DataSet.FieldByName('Azienda').AsString;
  //AzOld:=VarToStr(DataSet.FieldByName('Azienda').medpOldValue);
  try
    SessioneOracle.ApplyUpdates([QI090,A181MW.QI091],False);
    (*17/07/2017 Danilo: inibita la possibilità di modificare il codice dell'azienda
    if (AzOld <> '') and (Az <> AzOld) then
    begin
      A181MW.scrupdI090.SetVariable('AZIENDA_OLD',AzOld);
      A181MW.scrupdI090.SetVariable('AZIENDA_NEW',Az);
      A181MW.scrupdI090.Execute;
      SessioneOracle.Commit;
    end;*)
    if QI090.FieldByName('STORIAINTERVENTO').AsString = 'S' then
    begin
      //Scrivo le tabelle selezionate per il log cancellando quelle non selezionate
      A181MW.scrI092.SQL.Clear;
      A181MW.scrI092.DeleteVariables;
      A181MW.scrI092.SQL.Add('begin');
      A181MW.scrI092.SQL.Add('  null;');
      with A008FAziende.TabelleLog do
        for i:=0 to Items.Count - 1 do
          if Checked[i] then
          begin
            A181MW.scrI092.SQL.Add(Format('  insert into MONDOEDP.I092_LOGTABELLE (AZIENDA,SCHEDA) select ''%s'',''%s'' from dual where (''%s'',''%s'') not in (select AZIENDA,SCHEDA from MONDOEDP.I092_LOGTABELLE where AZIENDA = ''%s'' and SCHEDA = ''%s'');',[Az,CdFnz[i],Az,CdFnz[i],Az,CdFnz[i]]));
            //Caratto: 11/04/2013. Unificazione L021. abilito anche la maschera web
            if (CdFnz[i] <> CdFnzWeb[i]) and (CdFnzWeb[i] <> '') then
            begin
              A181MW.scrI092.SQL.Add(Format('  insert into MONDOEDP.I092_LOGTABELLE (AZIENDA,SCHEDA) select ''%s'',''%s'' from dual where (''%s'',''%s'') not in (select AZIENDA,SCHEDA from MONDOEDP.I092_LOGTABELLE where AZIENDA = ''%s'' and SCHEDA = ''%s'');',[Az,CdFnzWeb[i],Az,CdFnzWeb[i],Az,CdFnzWeb[i]]));
            end;
          end
          else
          begin
            A181MW.scrI092.SQL.Add(Format('  delete MONDOEDP.I092_LOGTABELLE where AZIENDA = ''%s'' and SCHEDA = ''%s'';',[Az,CdFnz[i]]));
            //Caratto: 11/04/2013. Unificazione L021. disabilito anche la maschera web
            if (CdFnz[i] <> CdFnzWeb[i]) and (CdFnzWeb[i] <> '') then
            begin
              A181MW.scrI092.SQL.Add(Format('  delete MONDOEDP.I092_LOGTABELLE where AZIENDA = ''%s'' and SCHEDA = ''%s'';',[Az,CdFnzWeb[i]]));
            end;
          end;
      A181MW.scrI092.SQL.Add('end;');
      A181MW.scrI092.Execute;
    end;
    RegistraLog.RegistraOperazione;
  except
    on e:exception do
    begin
      SessioneOracle.Rollback;
      R180MessageBox(E.Message,ERRORE);
    end;
  end;
  SessioneOracle.Commit;
  A181MW.QI091.CancelUpdates;
  A181MW.QI091.CachedUpdates:=False;
  A181MW.QI091.ReadOnly:=True;
  A181MW.QI091.Filtered:=False;
  QI090.Close;
  QI090.AfterScroll:=nil;
  QI090.Open;
  QI090.AfterScroll:=QI090AfterScroll;
  QI090.Locate('Azienda',Az,[]);
  if A181MW.QI091.RecordCount = 0 then
  begin
    A181MW.PutDatiEnte(Az);
    A181MW.QI091.Close;
    A181MW.QI091.Open;
  end;
  //Gestione Jobs Archiviazione Log
  A181MW.JobArchiviazioneLOG;

  if Az = Parametri.Azienda then
    //ASSEGNAZIONE DEGLI EVENTUALI CAMBIAMENTI SUI PARAMETRI AZIENDALI IN TEMPO REALE
  begin
    Parametri.LogTabelle:=QI090.FieldByName('STORIAINTERVENTO').AsString;
    if Parametri.LogTabelle = 'S' then
    begin
      QI092.First;
      Parametri.NomiTabelleLog.Clear;
      while not QI092.Eof do
      begin
        Parametri.NomiTabelleLog.Add(QI092.FieldByName('SCHEDA').AsString);
        QI092.Next;
      end;
      QI092.First;
    end;
    A181MW.PutParametri;
    A181MW.QI091.Filtered:=True;
  end;
end;

procedure TA008FOperatoriDtm1.QI090BeforeDelete(DataSet: TDataSet);
{Cancello gli operatori associati all'azienda col metodo Delete per scatenare
l'evento BeforeDelete di QI070}
begin
  if DataSet.FieldByName('AZIENDA').AsString = 'AZIN' then
    raise Exception.Create('Impossibile cancellare l''azienda AZIN!');
  with A181MW.scrdelI090 do
  begin
    SetVariable('AZIENDA',DataSet.FieldByName('AZIENDA').AsString);
    Execute;
  end;
  RegistraLog.SettaProprieta('C','I090_ENTI',Copy(Name,1,4),QI090,True);
end;

procedure TA008FOperatoriDtm1.QI090AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([QI070,QI090],False);
  try
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TA008FOperatoriDtm1.QI090NewRecord(DataSet: TDataSet);
begin
  with QI090 do
  begin
    FieldByName('Utente').AsString:='MONDOEDP';
    FieldByName('ParolaChiave').AsString:=R180Cripta(A000PasswordFissa,21041974);
    FieldByName('StoriaIntervento').AsString:='N';
    FieldByName('TSLavoro').AsString:='LAVORO';
    FieldByName('TSIndici').AsString:='INDICI';
  end;
end;

procedure TA008FOperatoriDtm1.QI090AfterScroll(DataSet: TDataSet);
var
  i,j:Integer;
begin
  //Rilettura dati aziendali
  A181MW.QI091.Close;
  A181MW.QI091.SetVariable('AZIENDA',QI090Azienda.AsString);
  A181MW.QI091.Open;
  //Rilettura indicazioni sui log
  with QI092 do
  begin
    Close;
    SetVariable('AZIENDA',QI090Azienda.AsString);
    Open;
  end;
  //Apertura del database indicato dall'Azienda
  with DbIris008B do
  begin
    if (not Connected) or
       (UpperCase(LogonUserName) <> UpperCase(QI090.FieldByName('UTENTE').AsString)) then
    begin
      Logoff;
      if QI090.State = dsInsert then
      begin
        LogonDataBase:=Parametri.Database;
        LogonUserName:='MONDOEDP';
        LogonPassword:=Parametri.PasswordMondoEDP;
      end
      else
      begin
        LogonDataBase:=Parametri.Database;
        LogonUserName:=QI090.FieldByName('UTENTE').AsString;
        LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
      end;
      Logon;
    end;
  end;
  //Apertura tabelle dell'Azienda
  A181MW.QCols.Open;
  selaT030.Open;
  A181MW.selDizionario.Open;
  selT033.Open;
  CdFnz.Clear;
  CdFnzWeb.Clear;
  with A008FAziende do
  begin
    TabelleLog.Items.Clear;
    TabelleLog.Sorted:=False;
    j:=0;
    for i:=1 to High(FunzioniDisponibili) do
    begin
      if (L021GetMaschera(i) <> 'XXXX') and (FunzioniDisponibili[i].T <> 47) and //Alberto 28/11/2005: escludo l'inserimento collettivo giustificativi, che ha la stessa sigla di A004
         L021VerificaApplicazione(Parametri.Applicazione,i) then
      begin
        TabelleLog.Items.Add(FunzioniDisponibili[i].G + ': ' + FunzioniDisponibili[i].N);
        TabelleLog.Checked[j]:=QI092.Locate('SCHEDA',L021GetMaschera(i),[]);
        inc(j);
      end;
    end;
    TabelleLog.Sorted:=True;
    for i:=0 to TabelleLog.Items.Count - 1 do
      for j:=1 to High(FunzioniDisponibili) do
      begin
        if (L021GetMaschera(j) <> 'XXXX') and (FunzioniDisponibili[j].T <> 47) and //Alberto 28/11/2005: escludo l'inserimento collettivo giustificativi, che ha la stessa sigla di A004
           L021VerificaApplicazione(Parametri.Applicazione,j) and
           (TabelleLog.Items[i] = FunzioniDisponibili[j].G + ': ' + FunzioniDisponibili[j].N) then
        begin
          CdFnz.Add(L021GetMaschera(j));
          CdFnzWeb.Add(FunzioniDisponibili[j].SW);//Caratto: 11/04/2013. Unificazione L021. codice della maschera web. abilito/disabilito in coppia con la maschera win
          Break;
        end;
      end;
  end;
end;

procedure TA008FOperatoriDtm1.QI090AfterEdit(DataSet: TDataSet);
begin
  A181MW.QI091.CachedUpdates:=True;
  A181MW.QI091.ReadOnly:=False;
end;

procedure TA008FOperatoriDtm1.QI090BeforePost(DataSet: TDataSet);
begin
  if QI090.State = dsInsert then
  begin
    A181MW.QI091.CachedUpdates:=True;
    A181MW.QI091.ReadOnly:=False;
    QI090.FieldByName('AZIENDA').AsString:=UpperCase(QI090.FieldByName('AZIENDA').AsString);
  end;
  if ((QI090.State = dsInsert) or
      ((QI090.State = dsEdit) and (QI090.FieldByName('DOMINIO_LDAP_SUFFISSO').Value <> QI090.FieldByName('DOMINIO_LDAP_SUFFISSO').medpOldValue))) and
     (QI090.FieldByName('DOMINIO_LDAP_SUFFISSO').Value <> null)
     then
  begin
    //Controllo che il suffisso LDAP non crei degli utenti duplicati
    selI060UtentiRipetuti.Close;
    selI060UtentiRipetuti.SetVariable('AZIENDA', QI090.FieldByName('AZIENDA').AsString);
    selI060UtentiRipetuti.SetVariable('DOMINIO_LDAP_SUFFISSO', QI090.FieldByName('DOMINIO_LDAP_SUFFISSO').AsString);
    selI060UtentiRipetuti.Execute;
    if selI060UtentiRipetuti.RowCount > 0 then
      raise Exception.Create(A000MSG_A008_NOME_UTENTE_DUPLICATI);
  end;
  if (QI090.State = dsEdit) and
     (QI090.FieldByName('PAROLACHIAVE').Value <> QI090.FieldByName('PAROLACHIAVE').medpOldValue) then
    if R180MessageBox('ATTENZIONE!' + #13#10 +
                      'E'' stata modificata la password di connessione al database.' + #13#10 +
                      'Si ricorda che questa NON E'' la password del proprio operatore.' + #13#10 +
                      'Questa operazione avrà effetto a livello globale per tutti' + #13#10 +
                      'gli utenti dell''azienda "' + QI090.FieldByName('AZIENDA').AsString + '".' + #13#10 +
                      'Vuoi continuare?',DOMANDA) = mrNo then
      Abort;

  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','I090_ENTI',Copy(Name,1,4),QI090,True);
    dsEdit:RegistraLog.SettaProprieta('M','I090_ENTI',Copy(Name,1,4),QI090,True);
  end;
end;

procedure TA008FOperatoriDtm1.QI090DOMINIO_DIP_TIPOChange(Sender: TField);
begin
  if Sender.IsNull then
    Sender.AsString:='NTLM';
end;

procedure TA008FOperatoriDtm1.QI090FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=(Parametri.Azienda = 'AZIN') or
          (DataSet.FieldByName('AZIENDA').AsString = Parametri.Azienda);
end;

procedure TA008FOperatoriDtm1.QI070FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=(Parametri.Azienda = 'AZIN') or
          (DataSet.FieldByName('AZIENDA').AsString = Parametri.Azienda);
  if Accept and (Parametri.Operatore <> 'MONDOEDP') then
    Accept:=DataSet.FieldByName('UTENTE').AsString <> 'MONDOEDP';
end;

procedure TA008FOperatoriDtm1.QI070AfterScroll(DataSet: TDataSet);
begin
  QI070.FieldByName('UTENTE').ReadOnly:=R180In(QI070.FieldByName('UTENTE').AsString,['SYSMAN','MONDOEDP']);
  QI090.Locate('AZIENDA',QI070.FieldByName('AZIENDA').AsString,[]);
  AziendaCorrente:=QI070.FieldByName('AZIENDA').AsString;
  AggiornaFiltroProfili;
  try
    if A008FOperatori <> nil then
    begin
      if VarToStr(A008FOperatori.dlckPermessi.KeyValue) <> A008FOperatori.dlckPermessi.Text then
      begin
        A008FOperatori.dlckPermessi.KeyValue:=null;
        A008FOperatori.dlckPermessi.KeyValue:=QI070.FieldByName('PERMESSI').AsString;
      end;
      if VarToStr(A008FOperatori.dlckFiltroAnagrafe.KeyValue) <> A008FOperatori.dlckFiltroAnagrafe.Text then
      begin
        A008FOperatori.dlckFiltroAnagrafe.KeyValue:=null;
        A008FOperatori.dlckFiltroAnagrafe.KeyValue:=QI070.FieldByName('FILTRO_ANAGRAFE').AsString;
      end;
      if VarToStr(A008FOperatori.dlckFiltroFunzioni.KeyValue) <> A008FOperatori.dlckFiltroFunzioni.Text then
      begin
        A008FOperatori.dlckFiltroFunzioni.KeyValue:=null;
        A008FOperatori.dlckFiltroFunzioni.KeyValue:=QI070.FieldByName('FILTRO_FUNZIONI').AsString;
      end;
      if VarToStr(A008FOperatori.dlckFiltroDizionario.KeyValue) <> A008FOperatori.dlckFiltroDizionario.Text then
      begin
        A008FOperatori.dlckFiltroDizionario.KeyValue:=null;
        A008FOperatori.dlckFiltroDizionario.KeyValue:=QI070.FieldByName('FILTRO_DIZIONARIO').AsString;
      end;
    end;
  except
  end;
  //Apertura del database indicato dall'Azienda
  if (not DbIris008B.Connected) or
     (UpperCase(DbIris008B.LogonUserName) <> UpperCase(QI090.FieldByName('UTENTE').AsString)) then
  begin
    DbIris008B.Logoff;
    DbIris008B.LogonDatabase:=Parametri.Database;
    DbIris008B.LogonUserName:=QI090.FieldByName('UTENTE').AsString;
    DbIris008B.LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
    DbIris008B.Logon;
    try
      selI010.Apri(DbIris008B,'',Parametri.Applicazione,'','','');
    except
      on E:Exception do
        ShowMessage(E.Message);
    end;
    selT033.Open;
    A181MW.selDizionario.Open;
  end;
end;

procedure TA008FOperatoriDtm1.QI070AZIENDAValidate(Sender: TField);
begin
  AziendaCorrente:=Sender.AsString;
  AggiornaFiltroProfili;
end;

procedure TA008FOperatoriDtm1.BDEQI090PAROLACHIAVEGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text:=R180Decripta(Sender.AsString,21041974);
end;

procedure TA008FOperatoriDtm1.BDEQI090PAROLACHIAVESetText(Sender: TField;
  const Text: String);
begin
  Sender.AsString:=R180Cripta(Text,21041974);
end;

procedure TA008FOperatoriDtm1.AggiornaFiltroProfili;
begin
  with selI071 do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI072Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI073Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI074Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI075Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
end;

procedure TA008FOperatoriDtm1.selI072FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=selI072Dist.Active and
          (selI072.FieldByName('PROFILO').AsString = selI072Dist.FieldByName('PROFILO').AsString) and
          (selI072.FieldByName('AZIENDA').AsString = selI072Dist.FieldByName('AZIENDA').AsString);
end;

procedure TA008FOperatoriDtm1.selI073FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=selI073Dist.Active and
          (selI073.FieldByName('PROFILO').AsString = selI073Dist.FieldByName('PROFILO').AsString) and
          (selI073.FieldByName('AZIENDA').AsString = selI073Dist.FieldByName('AZIENDA').AsString);
  if Accept and Assigned(A008FProfili) and
     (A008FProfili.cmbFiltroFunzioni.Text <> '') and
     (A008FProfili.cmbFiltroFunzioni.Text <> 'Tutti') then
    Accept:=(selI073.FieldByName('GRUPPO').AsString = A008FProfili.cmbFiltroFunzioni.Text);
  if Accept and Assigned(A008FProfili) and
     (A008FProfili.edtContenuto.Text <> '') then
    Accept:=Pos(UpperCase(A008FProfili.edtContenuto.Text), UpperCase(selI073.FieldByName('DESCRIZIONE').AsString)) > 0;
end;

procedure TA008FOperatoriDtm1.selI074FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=selI074Dist.Active and
          (selI074.FieldByName('PROFILO').AsString = selI074Dist.FieldByName('PROFILO').AsString) and
          (selI074.FieldByName('AZIENDA').AsString = selI074Dist.FieldByName('AZIENDA').AsString);
end;

procedure TA008FOperatoriDtm1.selI075ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if (Action = 'C') and (Sender.RowID = '') then
    Applied:=True
  else if Sender.RowID = '' then
  begin
    if Action = 'U' then
    begin
      insI075.SetVariable('AZIENDA',selI075.FieldByName('AZIENDA').AsString);
      insI075.SetVariable('PROFILO',selI075.FieldByName('PROFILO').AsString);
      insI075.SetVariable('ITER',selI075.FieldByName('ITER').AsString);
      insI075.SetVariable('COD_ITER',selI075.FieldByName('COD_ITER').AsString);
      insI075.SetVariable('LIVELLO',selI075.FieldByName('LIVELLO').AsString);
      insI075.SetVariable('ACCESSO',selI075.FieldByName('ACCESSO').AsString);
      insI075.Execute;
    end;
    Applied:=True;
  end;
end;

procedure TA008FOperatoriDtm1.selI075BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI075CalcFields(DataSet: TDataSet);
begin
  selI075.FieldByName('D_ITER').AsString:=A000GetDescIter(selI075.FieldByName('ITER').AsString);
end;

procedure TA008FOperatoriDtm1.selI075DistAfterScroll(DataSet: TDataSet);
begin
  FiltraSelI075;
end;

procedure TA008FOperatoriDtm1.selI075DistBeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI075NewRecord(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA008FOperatoriDtm1.selI076BeforePost(DataSet: TDataSet);
var
  LConsentito: String;
  LIPEsterno: String;
begin
  // ip: dato obbligatorio
  if selI076.FieldByName('IP').AsString.Trim = '' then
    raise Exception.Create('Indicare l''indirizzo IP');

  // consentito: valori possibili: S/N
  LConsentito:=selI076.FieldByName('CONSENTITO').AsString.Trim;
  if (LConsentito = '') or
     (not R180In(LConsentito,['S','N'])) then
    raise Exception.Create('Selezionare S oppure N per consentire o meno l''indirizzo IP indicato!');

  // ip_esterno: valori possibili: S/N
  LIPEsterno:=selI076.FieldByName('IP_ESTERNO').AsString.Trim;
  if (LIPEsterno = '') or
     (not R180In(LIPEsterno,['S','N'])) then
    raise Exception.Create('Selezionare S oppure N per indicare se l''IP indicato è esterno o interno!');
end;

procedure TA008FOperatoriDtM1.selI076NewRecord(DataSet: TDataSet);
begin
  selI076.FieldByName('AZIENDA').AsString:=selI073.FieldByName('AZIENDA').AsString;
  selI076.FieldByName('PROFILO').AsString:=selI073.FieldByName('PROFILO').AsString;
  selI076.FieldByName('APPLICAZIONE').AsString:=selI073.FieldByName('APPLICAZIONE').AsString;
  selI076.FieldByName('TAG').AsInteger:=selI073.FieldByName('TAG').AsInteger;
end;

procedure TA008FOperatoriDtm1.selI072BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI072DistAfterScroll(DataSet: TDataSet);
begin
  selI072.Filtered:=False;
  selI072.Filtered:=True;
  GetFiltroAnagrafe;
  if Assigned(A008FProfili) then
    A008FProfili.EspandiGridFAnagrafe(False);
end;

procedure TA008FOperatoriDtm1.selI072DistBeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI073DistAfterScroll(DataSet: TDataSet);
begin
  A008selI073RecNo:=selI073.RecNo;
  selI073.Filtered:=False;
  selI073.Filtered:=True;
  if R180Between(A008selI073RecNo,1,selI073.RecordCount) then
    selI073.RecNo:=A008selI073RecNo;
end;

procedure TA008FOperatoriDtm1.selI073DistBeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI074BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI074DistAfterScroll(DataSet: TDataSet);
begin
  selI074.Filtered:=False;
  selI074.Filtered:=True;
  if Assigned(A008FProfili) then
    A008FProfili.cmbDizionarioChange(nil);
end;

procedure TA008FOperatoriDtm1.selI074DistBeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.GetFiltroAnagrafe;
{Lettura del filtro anagrafe dentro il memo}
begin
  selI072.First;
  if not Assigned(A008FProfili) then
    Exit;
  A008FProfili.memoFiltroAnagrafe.Lines.Clear;
  A008FProfili.chkSelezioneRichiestaPortale.Checked:=selI072.FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString = 'S';
  while not selI072.Eof do
  begin
    A008FProfili.memoFiltroAnagrafe.Lines.Add(selI072.FieldByName('FILTRO').AsString);
    selI072.Next;
  end;
  A008FProfili.memoFiltroAnagrafe.SelStart:=Length(A008FProfili.memoFiltroAnagrafe.Lines.Text) - 1;
end;

procedure TA008FOperatoriDtm1.PutFiltroAnagrafe;
{Registrazione del contenuto di memoFiltroAnagrafe}
var i:Integer;
begin
  selI072.First;
  while not selI072.Eof do
    selI072.Delete;
  for i:=0 to A008FProfili.memoFiltroAnagrafe.Lines.Count - 1 do
  begin
    selI072.Append;
    selI072.FieldByName('AZIENDA').AsString:=AziendaCorrente;
    selI072.FieldByName('PROFILO').AsString:=selI072Dist.FieldByName('PROFILO').AsString;
    selI072.FieldByName('PROGRESSIVO').AsInteger:=i;
    selI072.FieldByName('FILTRO').AsString:=A008FProfili.memoFiltroAnagrafe.Lines[i];
    selI072.FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString:='';
    if (i = 0) and A008FProfili.chkSelezioneRichiestaPortale.Checked then
      selI072.FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString:='S';
    selI072.Post;
  end;
  if (A008FProfili.memoFiltroAnagrafe.Lines.Count = 0) then
  begin
    selI072.Append;
    selI072.FieldByName('AZIENDA').AsString:=AziendaCorrente;
    selI072.FieldByName('PROFILO').AsString:=selI072Dist.FieldByName('PROFILO').AsString;
    selI072.FieldByName('PROGRESSIVO').AsInteger:=0;
    selI072.FieldByName('FILTRO').AsString:='';
    if A008FProfili.chkSelezioneRichiestaPortale.Checked then
      selI072.FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString:='S'
    else
      selI072.FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString:='';
    selI072.Post;
  end;
end;

procedure TA008FOperatoriDtm1.PutFiltroDizionario;
{Registrazione dei codici di dizionari selezionati}
var
  i:Integer;
  Inserito:Boolean;
begin
  A185MW.GetI074(A185MW.selI074Before,
                 QI090.FieldByName('AZIENDA').AsString,
                 selI074Dist.FieldByName('PROFILO').AsString,
                 A008FProfili.cmbDizionario.Text);
  selI074.First;
  while not selI074.Eof do
  begin
    if selI074.FieldByName('TABELLA').AsString = A008FProfili.cmbDizionario.Text then
      selI074.Delete
    else
      selI074.Next;
  end;
  Inserito:=False;
  for i:=0 to A008FProfili.lstDizionario.Items.Count - 1 do
  begin
    if A008FProfili.lstDizionario.Checked[i] then
    begin
      Inserito:=True;
      selI074.Append;
      selI074.FieldByName('AZIENDA').AsString:=AziendaCorrente;
      selI074.FieldByName('PROFILO').AsString:=selI074Dist.FieldByName('PROFILO').AsString;
      selI074.FieldByName('TABELLA').AsString:=A008FProfili.cmbDizionario.Text;
      {if A008FProfili.cmbDizionario.text <> 'ANOMALIE DEI CONTEGGI' then
        selI074.FieldByName('CODICE').AsString:=A008FProfili.lstDizionario.Items[i]
      else
        selI074.FieldByName('CODICE').AsString:=Trim(Copy(A008FProfili.lstDizionario.Items[i],1,5));}
      if A008FProfili.cmbDizionario.text = 'ANOMALIE DEI CONTEGGI' then
        selI074.FieldByName('CODICE').AsString:=Trim(Copy(A008FProfili.lstDizionario.Items[i],1,5))
      else if A008FProfili.cmbDizionario.text = 'ITER AUTORIZZATIVI' then
        selI074.FieldByName('CODICE').AsString:=A000GetCodIter(A008FProfili.lstDizionario.Items[i])
      else
        selI074.FieldByName('CODICE').AsString:=A008FProfili.lstDizionario.Items[i];

      if A008FProfili.rgpDizionario.ItemIndex = 0 then
        selI074.FieldByName('ABILITATO').AsString:='S'
      else
        selI074.FieldByName('ABILITATO').AsString:='N';
      selI074.Post;
    end;
  end;
  if (not Inserito) and (A008FProfili.rgpDizionario.ItemIndex = 0) then
  begin
    selI074.Append;
    selI074.FieldByName('AZIENDA').AsString:=AziendaCorrente;
    selI074.FieldByName('PROFILO').AsString:=selI074Dist.FieldByName('PROFILO').AsString;
    selI074.FieldByName('TABELLA').AsString:=A008FProfili.cmbDizionario.Text;
    selI074.FieldByName('CODICE').AsString:='DIZIONARIO DISABILITATO';
    selI074.FieldByName('ABILITATO').AsString:='S';
    selI074.Post;
  end;
  A185MW.GetI074(A185MW.selI074After,
                 QI090.FieldByName('AZIENDA').AsString,
                 selI074Dist.FieldByName('PROFILO').AsString,
                 A008FProfili.cmbDizionario.Text);
  A185MW.ConfrontaFiltroDizionario;
end;

procedure TA008FOperatoriDtm1.BeforeScroll(DataSet: TDataSet);
{Si impedisce lo scorrimento sui profili disponibili se si è in modifica}
begin
  if not BrowseProfili then
    Abort;
end;

procedure TA008FOperatoriDtm1.selaT030BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI010AfterOpen(DataSet: TDataSet);
{Lettura dei nomi di colonna validi per l'azienda selezionata}
begin
  if not Assigned(A008FProfili) then
    exit;
  A008FProfili.lstNomeCampo.Clear;
  while not selI010.Eof do
  begin
    A008FProfili.lstNomeCampo.Add(selI010.FieldByName('NOME_CAMPO').AsString);
    selI010.Next;
  end;
end;

procedure TA008FOperatoriDtm1.selI061ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  case Action of
    'I':RegistraLog.SettaProprieta('I','I061_PROFILI_DIPENDENTE',Copy(Name,1,4),selI061,True);
    'U':RegistraLog.SettaProprieta('M','I061_PROFILI_DIPENDENTE',Copy(Name,1,4),selI061,True);
    'D':RegistraLog.SettaProprieta('C','I061_PROFILI_DIPENDENTE',Copy(Name,1,4),selI061,True);
  end;
  if Action in ['I','U','D'] then
    RegistraLog.RegistraOperazione;
end;

procedure TA008FOperatoriDtm1.selI061BeforeEdit(DataSet: TDataSet);
begin
  if QI060.RecordCount <= 0 then
    Raise Exception.Create(A000MSG_A186_ERR_NO_UTENTE);
end;

procedure TA008FOperatoriDtm1.selI061BeforeInsert(DataSet: TDataSet);
begin
  if QI060.RecordCount <= 0 then
    Raise Exception.Create(A000MSG_A186_ERR_NO_UTENTE);
end;

procedure TA008FOperatoriDtm1.selI061BeforePost(DataSet: TDataSet);
begin
  if selI061.FieldByName('NOME_PROFILO').IsNull then  //PALERMO_POLICLINICO - 159894: aggiunto controllo del campo
    raise Exception.Create(A000MSG_A008_ERR_NOMEPROFILO_NULLO);
  if selI061.FieldByName('PERMESSI').IsNull then
    raise Exception.Create(A000MSG_A008_ERR_PROFILOPERMESSI_NULLO);
  if selI061.FieldByName('FILTRO_FUNZIONI').IsNull then
    raise Exception.Create(A000MSG_A008_ERR_PROFILOFUNZIONI_NULLO);

  if not selI071.SearchRecord('PROFILO',selI061.FieldByName('PERMESSI').AsString,[srFromBeginning]) then
    raise exception.Create('Codice Permessi non esistente!');
  if not selI073Dist.SearchRecord('PROFILO',selI061.FieldByName('FILTRO_FUNZIONI').AsString,[srFromBeginning]) then
    raise exception.Create('Filtro funzioni non esistente!');
  if (Not selI061.FieldByName('ITER_AUTORIZZATIVI').IsNull) and
     (Not selI075Dist.SearchRecord('PROFILO',selI061.FieldByName('ITER_AUTORIZZATIVI').AsString,[srFromBeginning])) then
    raise Exception.Create('Iter autorizzativo non esistente!');
  if (not selI061.FieldByName('FILTRO_ANAGRAFE').IsNull) and
     (not selI072Dist.SearchRecord('PROFILO',selI061.FieldByName('FILTRO_ANAGRAFE').AsString,[srFromBeginning])) then
    raise exception.Create('Filtro anagrafe non esistente!');
  if (not selI061.FieldByName('FILTRO_DIZIONARIO').IsNull) and
     (not selI074Dist.SearchRecord('PROFILO',selI061.FieldByName('FILTRO_DIZIONARIO').AsString,[srFromBeginning])) then
    raise exception.Create('Filtro dizionario non esistente!');
  selI061.FieldByName('RICEZIONE_MAIL').AsString:=UpperCase(selI061.FieldByName('RICEZIONE_MAIL').AsString);
  if not R180In(selI061.FieldByName('RICEZIONE_MAIL').AsString,['S','N']) then
    raise exception.Create('Il campo Ricezione E-Mail può contenere solo i valori "S" o "N".');
  selI061.FieldByName('LOGIN_DEFAULT').AsString:=UpperCase(selI061.FieldByName('LOGIN_DEFAULT').AsString);
  if not R180In(selI061.FieldByName('LOGIN_DEFAULT').AsString,['S','N']) then
    raise exception.Create('Il campo Default può contenere solo i valori "S" o "N".');
  if selI061.FieldByName('FILTRO_ANAGRAFE').AsString.Trim = '' then
    selI061.FieldByName('AUTO_ESCLUSIONE').AsString:='N';
  if not R180In(selI061.FieldByName('AUTO_ESCLUSIONE').AsString,['S','N']) then
    raise exception.Create('Il campo Autoesclusione può contenere solo i valori "S" o "N".');
  // modifica delegato_da.ini
  if (not selI061.FieldByName('DELEGATO_DA').IsNull) then
  begin
     if selI061.FieldByName('DELEGATO_DA').AsString = selI061.FieldByName('NOME_UTENTE').AsString then
       raise exception.Create('Il valore di Delegato non è un nome utente valido!')
     else
      begin
        selI060NomeUtente.Close;
        selI060NomeUtente.SetVariable('AZIENDA', A008FOperatoriDtm1.AziendaCorrente);
        selI060NomeUtente.SetVariable('NOME_UTENTE',selI061.FieldByName('DELEGATO_DA').AsString);
        selI060NomeUtente.Execute;
        if selI060NomeUtente.FieldAsInteger(0) = 0 then
          raise exception.Create('Il valore di Delegato non è un nome utente valido!');
      end;
  end;
  // modifica delegato_da.fine
end;

procedure TA008FOperatoriDtm1.selI061DistBeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI061FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=True;
  if selI061VisioneCorrente then
    Accept:=(selI061.FieldByName('INIZIO_VALIDITA').AsDateTime <= Parametri.DataLavoro) and
            (selI061.FieldByName('FINE_VALIDITA').AsDateTime >= Parametri.DataLavoro);
end;

procedure TA008FOperatoriDtm1.selI061NewRecord(DataSet: TDataSet);
begin
  selI061.FieldByName('AZIENDA').AsString:=QI060.FieldByName('AZIENDA').AsString;
  selI061.FieldByName('NOME_UTENTE').AsString:=QI060.FieldByName('NOME_UTENTE').AsString;
  selI061.FieldByName('NOME_PROFILO').AsString:=A008FLoginDipendenti.cmbNomeProfilo.Text;
  selI061.FieldByName('PERMESSI').AsString:=A008FLoginDipendenti.cmbPermessi.Text;
  selI061.FieldByName('PERMESSI').AsString:=A008FLoginDipendenti.cmbPermessi.Text;
  selI061.FieldByName('FILTRO_ANAGRAFE').AsString:=A008FLoginDipendenti.cmbFiltroAnagrafe.Text;
  selI061.FieldByName('FILTRO_FUNZIONI').AsString:=A008FLoginDipendenti.cmbFiltroFunzioni.Text;
  selI061.FieldByName('ITER_AUTORIZZATIVI').AsString:=A008FLoginDipendenti.cmbIterAutor.Text;
  selI061.FieldByName('FILTRO_DIZIONARIO').AsString:=A008FLoginDipendenti.cmbFiltroDizionario.Text;
  selI061.FieldByName('INIZIO_VALIDITA').AsDateTime:=EncodeDate(1900,1,1);
  selI061.FieldByName('FINE_VALIDITA').AsDateTime:=EncodeDate(3999,12,31);
end;

procedure TA008FOperatoriDtm1.selI065AfterPost(DataSet: TDataSet);
begin
  selI065U.Refresh;
  selI065P.Refresh;
end;

procedure TA008FOperatoriDtm1.selI065BeforePost(DataSet: TDataSet);
var ODS:TOracleDataSet;
begin
  with selI065.FieldByName('TIPO') do
    if (AsString <> 'P') and (AsString <> 'U') then
      Raise Exception.Create('Il campo Tipo non è valido!');
  selI065.FieldByName('CODICE').AsString:=Trim(selI065.FieldByName('CODICE').AsString);
  ODS:=TOracleDataset.Create(nil);
  try
    ODS.Session:=A008FOperatoriDtM1.DbIris008B;
    //ODS.SQL.Text:='SELECT :ESPRESSIONE ESPRESSIONE FROM T030_ANAGRAFICO WHERE PROGRESSIVO = 0';
    ODS.SQL.Text:='SELECT :ESPRESSIONE ESPRESSIONE FROM T030_ANAGRAFICO T030, V430_STORICO V430 WHERE T030.PROGRESSIVO = 0 AND T030.PROGRESSIVO = T430PROGRESSIVO AND SYSDATE BETWEEN T430DATADECORRENZA AND T430DATAFINE';
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

procedure TA008FOperatoriDtm1.selI065CalcFields(DataSet: TDataSet);
begin
  selI065.FieldByName('C_TIPO').AsString:=ifthen(selI065.FieldByName('TIPO').AsString='P','Password','Utente');
end;

procedure TA008FOperatoriDtm1.AggiornaI073;
{Aggiornamento iniziale delle funzioni disponibili}
var i:Integer;
  procedure AggiornaFunzione(Funzione:TFunzioniDisponibili);
  //Aggiorna e aggiunge le funzioni disponibili
  begin
    if Funzione.A = 'XXXX' then
      exit;
    if (Funzione.A <> 'IRIS') and (Funzione.A <> 'FUNWEB') and (Funzione.A <> Parametri.Applicazione) then
      exit;

    with updI073Agg do
    try
      SetVariable('TAG',Funzione.T);
      SetVariable('APPLICAZIONE',IfThen(Funzione.A = 'IRIS',Parametri.Applicazione,Funzione.A));
      SetVariable('FUNZIONE',Funzione.F);
      SetVariable('GRUPPO',Funzione.G);
      SetVariable('DESCRIZIONE',Funzione.N);
      Execute;
    except
    end;

    with insI073Agg do
    try
      SetVariable('TAG',Funzione.T);
      SetVariable('APPLICAZIONE',IfThen(Funzione.A = 'IRIS',Parametri.Applicazione,Funzione.A));
      SetVariable('FUNZIONE',Funzione.F);
      SetVariable('GRUPPO',Funzione.G);
      SetVariable('DESCRIZIONE',Funzione.N);
      Execute;
    except
    end;
  end;
begin
  if (Parametri.Operatore <> 'MONDOEDP') and
     ((Parametri.VersionePJ <> Parametri.VersioneDB) or
      (Parametri.BuildPJ <> Parametri.BuildDB)) then
  begin
    raise exception.Create(Format(A000MSG_A008_VERSIONI_DIVERSE,[Parametri.VersionePJ,Parametri.BuildPJ,Parametri.VersioneDB,Parametri.BuildDB]) + CRLF + A000MSG_A008_AGGIORNAMENTO_IMPEDITO);
  end;

  if (Parametri.Operatore = 'MONDOEDP') and
     (Parametri.VersioneDB <> '') and
     (Parametri.BuildDB <> '') then
  begin
    try
      selVersione.Close;
      selVersione.SetVariable('VERSIONEDB', Parametri.VersioneDB + '.' + Parametri.BuildDB);
      selVersione.SetVariable('VERSIONEPJ', Parametri.VersionePJ + '.' + Parametri.BuildPJ);
      selVersione.Open;
      if selVersione.FieldByName('VERSIONEPJ').AsFloat < selVersione.FieldByName('VERSIONEDB').AsFloat then
      begin
        raise exception.Create(Format(A000MSG_A008_VERSIONE_INFERIORE,[Parametri.VersionePJ,Parametri.BuildPJ,Parametri.VersioneDB,Parametri.BuildDB]) + CRLF + A000MSG_A008_AGGIORNAMENTO_IMPEDITO);
      end;
    except
      on E:Exception do
      begin
        raise exception.Create(E.Message + CRLF + A000MSG_A008_AGGIORNAMENTO_IMPEDITO);
      end;
    end;
  end;

  if Parametri.VersioneDB = '' then
  begin
    if MessageDlg(Format(A000MSG_A008_VERSIONE_DB,[Parametri.VersionePJ,Parametri.BuildPJ]),
                  mtWarning, [mbYes,mbNo], 0, mbNo) <> mrYes then
      exit;
  end;

  Screen.Cursor:=crHourGlass;
  try
    EliminaFunzioniInesistenti;
    for i:=1 to High(FunzioniDisponibili) do
      AggiornaFunzione(FunzioniDisponibili[i]);
    selI073.Refresh;
  finally
    SessioneOracle.Commit;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA008FOperatoriDtm1.EliminaFunzioniInesistenti;
//Elimina le funzioni registrate ma non più disponibili
var i:Integer;
    Esiste:Boolean;
begin
  with selI073Agg do
  try
    Open;
    while not Eof do
    begin
      Esiste:=False;
      for i:=1 to High(FunzioniDisponibili) do
        if (FunzioniDisponibili[i].T = FieldByName('TAG').AsInteger) and L021VerificaApplicazione(Parametri.Applicazione,i) then
        begin
          Esiste:=True;
          Break;
        end;
      if Esiste then
        Next
      else
      begin
        with delI073Agg do
        try
          SetVariable('TAG',FieldByName('TAG').AsInteger);
          SetVariable('APPLICAZIONE',FieldByName('APPLICAZIONE').AsString);
          Execute;
        except
        end;
        Next;
      end;
    end;
  finally
    Close;
    SessioneOracle.Commit;
  end;
end;

procedure TA008FOperatoriDtm1.CreaFiltroFunzioni(Azienda,Profilo:String);
{Lettura e aggiornamento delle funzioni disponibili}
var i:Integer;
  procedure GetFunzione(Funzione:TFunzioniDisponibili);
  //Aggiorna e aggiunge le funzioni disponibili
  begin
    if Funzione.A = 'XXXX' then
      exit;
    if (Funzione.A <> 'IRIS') and (Funzione.A <> 'FUNWEB') and (Funzione.A <> Parametri.Applicazione) then
      exit;
    with selI073 do
      if SearchRecord('AZIENDA;PROFILO;TAG',VarArrayOf([Azienda,Profilo,Funzione.T]),[srFromBeginning]) then
      begin
        if (FieldByName('FUNZIONE').AsString <> Funzione.F) or
           (FieldByName('GRUPPO').AsString <> Funzione.G) or
           (FieldByName('DESCRIZIONE').AsString <> Funzione.N) then
        begin
          Edit;
          FieldByName('FUNZIONE').AsString:=Funzione.F;
          FieldByName('GRUPPO').AsString:=Funzione.G;
          FieldByName('DESCRIZIONE').AsString:=Funzione.N;
          Post;
        end;
      end
      else //if Funzione.WEB = '' then
           //Caratto 10/04/2013 le funzioni specifiche di web non le inserisce.
           //Se fossero già presenti (inserite da webpj) le gestisce in update
      begin
        Append;
        FieldByName('AZIENDA').AsString:=Azienda;
        FieldByName('PROFILO').AsString:=Profilo;
        //if Funzione.G = 'Funzioni WEB' then
        if Funzione.A = 'FUNWEB' then
          FieldByName('APPLICAZIONE').AsString:=Funzione.A
        else
          FieldByName('APPLICAZIONE').AsString:=Parametri.Applicazione;
        FieldByName('TAG').AsInteger:=Funzione.T;
        FieldByName('FUNZIONE').AsString:=Funzione.F;
        FieldByName('GRUPPO').AsString:=Funzione.G;
        FieldByName('DESCRIZIONE').AsString:=Funzione.N;
        FieldByName('INIBIZIONE').AsString:='N';
        //Gestisco l'eccezione nel caso in cui il profilo esistà gia in un altro applicativo
        try
          Post;
        except
          Cancel;
        end;
      end;
  end;
begin
  with selI073 do
  begin
    DisableControls;
    ReadOnly:=False;
    BeforeInsert:=nil;
    BeforeDelete:=nil;
    CommitOnPost:=True;
    try
      for i:=1 to High(FunzioniDisponibili) do
        GetFunzione(FunzioniDisponibili[i]);
    finally
      SessioneOracle.Commit;
      EnableControls;
      ReadOnly:=True;
      BeforeInsert:=selI073BeforeDeleteInsert;
      BeforeDelete:=selI073BeforeDeleteInsert;
      Filtered:=False;
      Filtered:=True;
      CommitOnPost:=False;
    end;
  end;
end;

procedure TA008FOperatoriDtm1.A008FOperatoriDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  CdFnz.Free;
  CdFnzWeb.Free;
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(A181MW);
  FreeAndNil(A185MW);
end;

procedure TA008FOperatoriDtm1.selI073AfterRefresh(DataSet: TDataSet);
begin
  if R180Between(A008selI073RecNo,1,selI073.RecordCount) then
    selI073.RecNo:=A008selI073RecNo;
end;

procedure TA008FOperatoriDtm1.selI073BeforeDeleteInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA008FOperatoriDtm1.selI073BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI073BeforePost(DataSet: TDataSet);
begin
  // controllo validità dati
  if (selI073.FieldByName('ACCESSO_BROWSE').AsString <> 'S') and
     (selI073.FieldByName('ACCESSO_BROWSE').AsString <> 'N') then
    raise Exception.Create('Il valore del dato Accesso Browse deve essere S oppure N');

  if selI073.FieldByName('RIGHE_PAGINA').AsInteger < -1 then
    raise Exception.Create('Il valore indicato per il dato Righe Pagina non è valido');

  if selI073.FieldByName('RIGHE_PAGINA').AsInteger > 9999 then
    raise Exception.Create('Il valore indicato per il dato Righe Pagina non è valido');

  if (selI073.FieldByName('GRUPPO').AsString = 'Funzioni WEB')
  and (selI073.FieldByName('INIBIZIONE').OldValue <> selI073.FieldByName('INIBIZIONE').Value) then
  begin
    updI073.SetVariable('INIBIZIONE',selI073.FieldByName('INIBIZIONE').AsString);
    updI073.SetVariable('AZIENDA',selI073.FieldByName('AZIENDA').AsString);
    updI073.SetVariable('PROFILO',selI073.FieldByName('PROFILO').AsString);
    updI073.SetVariable('GRUPPO',selI073.FieldByName('GRUPPO').AsString);
    updI073.SetVariable('FUNZIONE',selI073.FieldByName('FUNZIONE').AsString);
    updI073.SetVariable('APPLICAZIONE',selI073.FieldByName('APPLICAZIONE').AsString);
    updI073.Execute;
  end;
end;

procedure TA008FOperatoriDtm1.selI073BeforeRefresh(DataSet: TDataSet);
begin
  A008selI073RecNo:=selI073.RecNo;
end;

procedure TA008FOperatoriDtm1.selI073INIBIZIONEValidate(Sender: TField);
begin
  if (Sender.AsString <> 'S') and (Sender.AsString <> 'N') and (Sender.AsString <> 'R') then
    raise Exception.Create('Valori ammessi: S/N/R');
end;

procedure TA008FOperatoriDtm1.selI073NewRecord(DataSet: TDataSet);
begin
  selI073.FieldByName('AZIENDA').AsString:=AziendaCorrente;//A008FProfili.cmbSelAzin.Text;
  selI073.FieldByName('ACCESSO_BROWSE').AsString:='S';
  selI073.FieldByName('RIGHE_PAGINA').AsInteger:=0;
end;

procedure TA008FOperatoriDtm1.selI090AfterScroll(DataSet: TDataSet);
var Index:Integer;
begin
  //Apertura del database indicato dall'Azienda
  Index:=0;
  if A008FLoginDipendenti <> nil then
    Index:=R180GetColonnaDBGrid(A008FLoginDipendenti.DBGridDettaglio,'PERMESSI');

  if DbIris008B.Connected and
     (UpperCase(DbIris008B.LogonUserName) = UpperCase(selI090.FieldByName('UTENTE').AsString)) and
     ((A008FLoginDipendenti = nil) or
      (A008FLoginDipendenti <> nil) and (A008FLoginDipendenti.DBGridDettaglio.Columns.Items[Index].PickList.Count > 0)) then
    exit;
  Screen.Cursor:=crHourGlass;
  try
    CambioDataBase;
    AziendaCorrente:=selI090.FieldByName('AZIENDA').AsString;
    AggiornaFiltroProfili;
    if A008FLoginDipendenti <> nil then
    begin
      with A008FLoginDipendenti do
      try
        QI060.Close;
        QI060.SetVariable('AZIENDA',selI090.FieldByName('AZIENDA').AsString);
        QI060.Open;
        A008FLoginDipendenti.DButton.DataSet:=QI060;
        CaricaCmbNomiProfili;
        cmbPermessi.Items.Clear;
        cmbFiltroAnagrafe.Items.Clear;
        cmbFiltroFunzioni.Items.Clear;
        cmbIterAutor.Items.Clear;
        cmbFiltroDizionario.Items.Clear;
        Index:=R180GetColonnaDBGrid(DBGridDettaglio,'PERMESSI');
        DBGridDettaglio.Columns.Items[Index].PickList.BeginUpdate;
        DBGridDettaglio.Columns.Items[Index].PickList.Clear;
        selI071.First;
        while not selI071.Eof do
        begin
          DBGridDettaglio.Columns.Items[Index].PickList.Add(selI071.FieldByName('PROFILO').AsString);
          cmbPermessi.Items.Add(selI071.FieldByName('PROFILO').AsString);
          selI071.Next;
        end;
        DBGridDettaglio.Columns.Items[Index].PickList.EndUpdate;
        Index:=R180GetColonnaDBGrid(DBGridDettaglio,'FILTRO_ANAGRAFE');
        DBGridDettaglio.Columns.Items[Index].PickList.BeginUpdate;
        DBGridDettaglio.Columns.Items[Index].PickList.Clear;
        selI072Dist.First;
        selI072Dist.AfterScroll:=nil;
        try
          while not selI072Dist.Eof do
          begin
            DBGridDettaglio.Columns.Items[Index].PickList.Add(selI072Dist.FieldByName('PROFILO').AsString);
            cmbFiltroAnagrafe.Items.Add(selI072Dist.FieldByName('PROFILO').AsString);
            selI072Dist.Next;
          end;
        finally
          selI072Dist.AfterScroll:=selI072DistAfterScroll;
          selI072Dist.First;
        end;
        DBGridDettaglio.Columns.Items[Index].PickList.EndUpdate;
        Index:=R180GetColonnaDBGrid(DBGridDettaglio,'FILTRO_FUNZIONI');
        DBGridDettaglio.Columns.Items[Index].PickList.BeginUpdate;
        DBGridDettaglio.Columns.Items[Index].PickList.Clear;
        selI073Dist.First;
        selI073Dist.AfterScroll:=nil;
        try
          while not selI073Dist.Eof do
          begin
            DBGridDettaglio.Columns.Items[Index].PickList.Add(selI073Dist.FieldByName('PROFILO').AsString);
            cmbFiltroFunzioni.Items.Add(selI073Dist.FieldByName('PROFILO').AsString);
            selI073Dist.Next;
          end;
        finally
          selI073Dist.AfterScroll:=selI073DistAfterScroll;
          selI073Dist.First;
        end;
        DBGridDettaglio.Columns.Items[Index].PickList.EndUpdate;
        Index:=R180GetColonnaDBGrid(DBGridDettaglio,'ITER_AUTORIZZATIVI');
        DBGridDettaglio.Columns.Items[Index].PickList.BeginUpdate;
        DBGridDettaglio.Columns.Items[Index].PickList.Clear;
        selI075Dist.First;
        selI075Dist.AfterScroll:=nil;
        try
          while not selI075Dist.Eof do
          begin
            DBGridDettaglio.Columns.Items[Index].PickList.Add(selI075Dist.FieldByName('PROFILO').AsString);
            cmbIterAutor.Items.Add(selI075Dist.FieldByName('PROFILO').AsString);
            selI075Dist.Next;
          end;
        finally
          selI075Dist.AfterScroll:=selI075DistAfterScroll;
          selI075Dist.First;
        end;
        DBGridDettaglio.Columns.Items[Index].PickList.EndUpdate;
        Index:=R180GetColonnaDBGrid(DBGridDettaglio,'FILTRO_DIZIONARIO');
        DBGridDettaglio.Columns.Items[Index].PickList.BeginUpdate;
        DBGridDettaglio.Columns.Items[Index].PickList.Clear;
        selI074Dist.First;
        selI074Dist.AfterScroll:=nil;
        try
          while not selI074Dist.Eof do
          begin
            DBGridDettaglio.Columns.Items[Index].PickList.Add(selI074Dist.FieldByName('PROFILO').AsString);
            cmbFiltroDizionario.Items.Add(selI074Dist.FieldByName('PROFILO').AsString);
            selI074Dist.Next;
          end;
        finally
          selI074Dist.AfterScroll:=selI074DistAfterScroll;
          selI074Dist.First;
        end;
        DBGridDettaglio.Columns.Items[Index].PickList.EndUpdate;
        spvAzienda:=selI090.FieldByName('AZIENDA').AsString;

        if spvAzienda = A008Flogindipendenti.dcmbAzienda.Text then
          A008FLoginDipendenti.OldSel:=spvAzienda;

        // gestione cambio azienda
        A008FLoginDipendenti.OnI090AziendaCambiata;

        // mantiene il QI090 sincronizzato
        QI090.SearchRecord('AZIENDA',selI090.FieldByName('AZIENDA').AsString,[srFromBeginning]);
      except
      end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA008FOperatoriDtm1.CambioDataBase;
begin
  //Apertura del database indicato dall'Azienda
  with DbIris008B do
    if (not Connected) or
       (UpperCase(LogonUserName) <> UpperCase(selI090.FieldByName('UTENTE').AsString)) then
    begin
      Logoff;
      LogonDataBase:=Parametri.Database;
      LogonUserName:=selI090.FieldByName('UTENTE').AsString;
      LogonPassword:=R180Decripta(selI090.FieldByName('PAROLACHIAVE').AsString,21041974);
      Logon;
      selaT030.Close;
      selaT030.Open;
      A181MW.selDizionario.Close;
      A181MW.selDizionario.Open;
      selT033.Close;
      selT033.Open;
      A181MW.QCols.Close;
      A181MW.QCols.Open;
    end;
end;

procedure TA008FOperatoriDtm1.QI060AfterDelete(DataSet: TDataSet);
begin
  try
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TA008FOperatoriDtm1.QI060AfterOpen(DataSet: TDataSet);
begin
 if QI060.RecordCount = 0 then
   OpenI061;
end;

procedure TA008FOperatoriDtm1.QI060AfterScroll(DataSet: TDataSet);
var
  ColAttuale: Integer;
begin
  OpenI061;

  // modifica delegato_da.ini
  // imposta colonna "delegato da"
  // propone elenco dei nomi utenti diversi da quello selezionato
  //ColAttuale:=10;
  with A008FLoginDipendenti do
  begin
    ColAttuale:=R180GetColonnaDBGrid(DBGridDettaglio,'DELEGATO_DA');
    DBGridDettaglio.Columns.Items[ColAttuale].PickList.BeginUpdate;
    DBGridDettaglio.Columns.Items[ColAttuale].PickList.Clear;
    selI060.First;
    try
      while not selI060.Eof do
      begin
        if selI060.FieldByName('NOME_UTENTE').AsString <> QI060.FieldByName('NOME_UTENTE').AsString then
          DBGridDettaglio.Columns.Items[ColAttuale].PickList.Add(selI060.FieldByName('NOME_UTENTE').AsString);
        selI060.Next;
      end;
    finally
      selI060.First;
    end;
    DBGridDettaglio.Columns.Items[ColAttuale].PickList.EndUpdate;
  end;
  // modifica delegato_da.fine
end;

procedure TA008FOperatoriDtm1.OpenI061;
begin
  if Not QI060.Active then
    Exit;
  if VarToStr(selI061.GetVariable('AZIENDA')) <> QI060.FieldByName('AZIENDA').AsString then
  begin
    selI061.SetVariable('AZIENDA',QI060.FieldByName('AZIENDA').AsString);
    selI061.Close;
  end;
  if VarToStr(selI061.GetVariable('NOME_UTENTE')) <> QI060.FieldByName('NOME_UTENTE').AsString then
  begin
    selI061.SetVariable('NOME_UTENTE',QI060.FieldByName('NOME_UTENTE').AsString);
    selI061.Close;
  end;
  selI061.Open;
end;

procedure TA008FOperatoriDtm1.QI060BeforeDelete(DataSet: TDataSet);
begin
  delI061.SetVariable('AZIENDA',QI060.FieldByName('AZIENDA').AsString);
  delI061.SetVariable('NOME_UTENTE',QI060.FieldByName('NOME_UTENTE').AsString);
  delI061.Execute;
  RegistraLog.SettaProprieta('C','I060_LOGIN_DIPENDENTE',Copy(Name,1,4),QI060,True);
end;

procedure TA008FOperatoriDtm1.QI060BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.QI060BeforePost(DataSet: TDataSet);
var
  LADUserInfo: TActiveDirectoryUserInfo;
  LResCtrl: TResCtrl;
  LAggiornaDati: Boolean;
  procedure ControllaNomeUtente(pNomeUtente,pNomeUtente2: string);
  begin
    if (pNomeUtente = '') and (pNomeUtente2 = '') then
      Exit;
    selI060NomeUtenteUnivoco.SetVariable('AZIENDA', QI060.FieldByName('AZIENDA').AsString);
    selI060NomeUtenteUnivoco.SetVariable('NOME_UTENTE', pNomeUtente);
    selI060NomeUtenteUnivoco.SetVariable('NOME_UTENTE2', pNomeUtente2);
    if QI060.State = dsEdit then
      selI060NomeUtenteUnivoco.SetVariable('ID_RIGA',QI060.RowId)
    else
      selI060NomeUtenteUnivoco.SetVariable('ID_RIGA',null);

    selI060NomeUtenteUnivoco.Execute;
    if selI060NomeUtenteUnivoco.FieldAsInteger(0) > 0 then
      raise Exception.Create(A000MSG_A008_NOME_UTENTE_IN_USO);
  end;
begin
  if Trim(QI060.FieldByName('NOME_UTENTE').AsString) = '' then
    raise Exception.Create(A000MSG_A008_NOME_UTENTE_MANCANCANTE);
  if (not QI060.FieldByName('MATRICOLA').IsNull) and (VarToStr(selaT030.Lookup('MATRICOLA',QI060.FieldByName('MATRICOLA').AsString,'MATRICOLA')) = '') then
    raise Exception.Create('Matricola non esistente!');
  if ((DataSet.State = dsInsert) or
     (Dataset.FieldByName('PASSWORD').medpOldValue <> Dataset.FieldByName('PASSWORD').Value)) then
  begin
    if Length(Dataset.FieldByName('PASSWORD').AsString) < Parametri.LunghezzaPassword then
      if QI090.FieldByName('DOMINIO_DIP').IsNull or (Length(Dataset.FieldByName('PASSWORD').AsString) > 0) then
        raise Exception.Create(Format(A000MSG_A186_ERR_FMT_LUNG_PWD,[Parametri.LunghezzaPassword]));
    if Not A008FLoginDipendenti.ForzaCambioPsw then
      Dataset.FieldByName('DATA_PW').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
  end;
  A008FLoginDipendenti.ForzaCambioPsw:=False;

  QI060.FieldByName('CELLULARE').AsString:=Trim(QI060.FieldByName('CELLULARE').AsString);
  if Length(QI060.FieldByName('CELLULARE').AsString) > 0 then
  begin
    if Copy(QI060.FieldByName('CELLULARE').AsString,1,1) <> '3' then
      raise Exception.Create(A000MSG_A186_ERR_INIZ_CELLULARE);
    if Length(QI060.FieldByName('CELLULARE').AsString) < StrToIntDef(Parametri.CampiRiferimento.C90_CellulareLunghMin,10) then
      raise Exception.Create(Format(A000MSG_A186_ERR_FMT_LUNG_CELLULARE,[StrToIntDef(Parametri.CampiRiferimento.C90_CellulareLunghMin,10)]));
    if not R180TestoInSetCaratteri(QI060.FieldByName('CELLULARE').AsString,'0123456789') then
      raise Exception.Create(A000MSG_A186_ERR_NON_NUMERICO);
  end;

  //Controlli NOME_UTENTE e NOME_UTENTE2 (non nullo e non duplicato)
  QI060.FieldByName('NOME_UTENTE').AsString:=Trim(QI060.FieldByName('NOME_UTENTE').AsString);
  QI060.FieldByName('NOME_UTENTE2').AsString:=Trim(QI060.FieldByName('NOME_UTENTE2').AsString);

  if UpperCase(QI060.FieldByName('NOME_UTENTE').AsString) = UpperCase(QI060.FieldByName('NOME_UTENTE2').AsString) then
    raise Exception.Create(A000MSG_A008_NOME_UTENTE_IN_USO);
  if (QI060.State = dsInsert) then
    ControllaNomeUtente(QI060.FieldByName('NOME_UTENTE').AsString, QI060.FieldByName('NOME_UTENTE2').AsString)
  else if (QI060.State = dsEdit) then
    ControllaNomeUtente(
      IfThen(QI060.FieldByName('NOME_UTENTE').AsString <> VarToStr(QI060.FieldByName('NOME_UTENTE').medpOldValue),QI060.FieldByName('NOME_UTENTE').AsString),
      IfThen(QI060.FieldByName('NOME_UTENTE2').AsString <> VarToStr(QI060.FieldByName('NOME_UTENTE2').medpOldValue),QI060.FieldByName('NOME_UTENTE2').AsString)
    );

  if QI060.State = dsInsert then
  begin
    selI061.FieldByName('AZIENDA').AsString:=QI060.FieldByName('AZIENDA').AsString;
    selI061.FieldByName('NOME_UTENTE').AsString:=QI060.FieldByName('NOME_UTENTE').AsString;
  end
  else if (QI060.State = dsEdit) and
          (QI060.FieldByName('NOME_UTENTE').AsString <> VarToStr(QI060.FieldByName('NOME_UTENTE').medpOldValue)) then
  begin
    UpdI061.SetVariable('NOME_UTENTENEW',QI060.FieldByName('NOME_UTENTE').AsString);
    UpdI061.SetVariable('NOME_UTENTEOLD',VarToStr(QI060.FieldByName('NOME_UTENTE').medpOldValue));
    UpdI061.SetVariable('AZIENDA',QI060.FieldByName('AZIENDA').AsString);
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
      LAggiornaDati:=(QI060.FieldByName('EMAIL').AsString = '');

      if LAggiornaDati then
      begin
        // estrae info da active directory
        LResCtrl:=ADsGetUserInfo(QI090.FieldByName('DOMINIO_DIP').AsString, QI060.FieldByName('NOME_UTENTE').AsString, LADUserInfo);
        if LResCtrl.Ok then
        begin
          // impostazione dei dati letti da active directory
          // IMPORTANTE:
          //   i dati eventualmente impostati NON vengono sovrascritti

          // email
          if QI060.FieldByName('EMAIL').AsString = '' then
            QI060.FieldByName('EMAIL').AsString:=LADUserInfo.Email;
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

  // log
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','I060_LOGIN_DIPENDENTE',Copy(Name,1,4),QI060,True);
    dsEdit:RegistraLog.SettaProprieta('M','I060_LOGIN_DIPENDENTE',Copy(Name,1,4),QI060,True);
  end;
end;

procedure TA008FOperatoriDtm1.QI060PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  ShowMessage(Format(A000MSG_ERR_FMT_REG_FALLITA,[E.Message]));
  Action:=daAbort;
end;

procedure TA008FOperatoriDtm1.QI060NewRecord(DataSet: TDataSet);
begin
  QI060.FieldByName('AZIENDA').AsString:=selI090.FieldByName('AZIENDA').AsString;
end;

procedure TA008FOperatoriDtm1.QI060CalcFields(DataSet: TDataSet);
begin
  if QI060.FieldByName('PASSWORD').IsNull then
    QI060.FieldByName('D_PASSWORD').AsString:='<No password>'
  else
    QI060.FieldByName('D_PASSWORD').AsString:=StringReplace(Format('%*s',[Length(QI060.FieldByName('PASSWORD').AsString),'*']),' ','*',[rfReplaceAll]);
  if not SolaLettura then
    QI060.FieldByName('C_PWD_DECRIPTATA').AsString:=R180Decripta(QI060.FieldByName('PASSWORD').AsString,30011945);
end;

procedure TA008FOperatoriDtm1.ImpostaDatiAccountDaDominio;
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

    RegistraMsg.InserisciMessaggio('I',Format('Elaborazione di n. %d account utente',[QI060.RecordCount]),Parametri.Azienda);

    // indica che è in corso l'impostazione massiva dei dati
    FImpostazioneDatiAccountDaDominio:=True;

    // estrae info da active directory per gli utenti nel dataset
    QI060.DisableControls;
    QI060.First;
    while not QI060.Eof do
    begin
      try
        // verifica se è necessario aggiornare i dati di questo account
        LAggiornaDati:=(QI060.FieldByName('EMAIL').AsString = '');

        if LAggiornaDati then
        begin
          // estrae i dati da Active Directory
          LResCtrl:=ADsGetUserInfo(QI090.FieldByName('DOMINIO_DIP').AsString, QI060.FieldByName('NOME_UTENTE').AsString, LADUserInfo);
          if LResCtrl.Ok then
          begin
            try
              // impostazione dei dati letti da active directory
              // IMPORTANTE:
              //   i dati eventualmente impostati NON vengono sovrascritti
              QI060.Edit;

              // email
              if QI060.FieldByName('EMAIL').AsString = '' then
                QI060.FieldByName('EMAIL').AsString:=LADUserInfo.Email;

              QI060.Post;
              // log
              RegistraMsg.InserisciMessaggio('I',Format('Account utente "%s": informazioni aggiornate correttamente',[QI060.FieldByName('NOME_UTENTE').AsString]),Parametri.Azienda);
            except
              on E: Exception do
              begin
                // log errore aggiornamento
                RegistraMsg.InserisciMessaggio('A',Format('Account utente "%s": errore durante l''aggiornamento delle informazioni: %s (%s)',[QI060.FieldByName('NOME_UTENTE').AsString,E.Message,E.ClassName]),Parametri.Azienda);
              end;
            end;
          end
          else
          begin
            // errore lettura info
            RegistraMsg.InserisciMessaggio('A',Format('Account utente "%s": errore nelle lettura delle informazioni da Active Directory: %s',[QI060.FieldByName('NOME_UTENTE').AsString,LResCtrl.Messaggio]),Parametri.Azienda);
          end;
        end
        else
        begin
          // aggiornamento info non necessario
          RegistraMsg.InserisciMessaggio('I',Format('Account utente "%s": aggiornamento informazioni non necessario',[QI060.FieldByName('NOME_UTENTE').AsString]),Parametri.Azienda);
        end;
      finally
        QI060.Next;
      end;
    end;
  finally
    FImpostazioneDatiAccountDaDominio:=False;
    RegistraMsg.InserisciMessaggio('I','Fine elaborazione');
    QI060.First;
    QI060.EnableControls;
  end;
end;

procedure TA008FOperatoriDtm1.QI070CalcFields(DataSet: TDataSet);
begin
  QI070.FieldByName('SCADENZAPASSWD').AsDateTime:=R180AddMesi(QI070.FieldByName('DATA_PW').AsDateTime,Parametri.RegolePassword.MesiValidita);
  { Se l'operatore ha già effettuato il primo ingresso, e quidi è stata memorizzata la sysdate, comparirà
    la data di scadenza utente, altrimenti non comapare nulla (significa che l'operatore non ha ancora effettuato il
    primo ingresso ed il campo DATA_ACCESSO è vuoto) }
  try
  if not QI070.FieldByName('DATA_ACCESSO').IsNull then
    QI070.FieldByName('ScadenzaUtente').AsDateTime:=R180AddMesi(QI070.FieldByName('DATA_ACCESSO').AsDateTime,QI090.FieldByName('VALID_UTENTE').AsInteger);
  except
  end;
end;

procedure TA008FOperatoriDtm1.selI070AccessiBeforeDelete(
  DataSet: TDataSet);
begin
  showmessage('In questa sezione non è possibile eliminare record.');
  Abort;
end;

procedure TA008FOperatoriDtm1.selI070AccessiBeforeInsert(
  DataSet: TDataSet);
begin
  Abort;
end;

procedure TA008FOperatoriDtm1.selUser_TriggersBeforeDelete(
  DataSet: TDataSet);
begin
  showmessage('In questa sezione non è possibile eliminare record.');
  Abort;
end;

procedure TA008FOperatoriDtm1.selUser_TriggersBeforeInsert(
  DataSet: TDataSet);
begin
  Abort;
end;

procedure TA008FOperatoriDtm1.UpdI060AfterQuery(Sender: TOracleQuery);
begin
  RegistraLog.SettaProprieta('M','I060_LOGIN_DIPENDENTE',Copy(Name,1,4),nil,True);
  RegistraLog.InserisciDato('NOME_UTENTE',UpdI060.GetVariable('NOME_UTENTE'),'');
  RegistraLog.InserisciDato('PASSWORD','',UpdI060.GetVariable('PASSWORD_NEW'));
  RegistraLog.RegistraOperazione;
end;

procedure TA008FOperatoriDtm1.selI070AccessiBeforePost(DataSet: TDataSet);
begin
  if (selI070Accessi.FieldByName('ACCESSO_NEGATO').AsString <> 'S') and
     (selI070Accessi.FieldByName('ACCESSO_NEGATO').AsString <> 'N') then
  begin
    showmessage('Il campo accetta solo i valori S o N.');
    Abort;
  end;
end;

procedure TA008FOperatoriDtm1.selI071AfterOpen(DataSet: TDataSet);
begin
  TDateTimeField(selI071.FieldByName('WEB_CARTELLINI_DATAMIN')).EditMask:='!00/00/0000;1;_';
  TDateTimeField(selI071.FieldByName('WEB_CARTELLINI_DATAMIN')).DisplayFormat:='dd/mm/yyyy';
  TDateTimeField(selI071.FieldByName('WEB_CEDOLINI_DATAMIN')).EditMask:='!00/00/0000;1;_';
  TDateTimeField(selI071.FieldByName('WEB_CEDOLINI_DATAMIN')).DisplayFormat:='dd/mm/yyyy';
end;

procedure TA008FOperatoriDtm1.selI071BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA008FOperatoriDtm1.selI071BeforePost(DataSet: TDataSet);
begin
  selI071.FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime:=R180InizioMese(selI071.FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime);
  selI071.FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime:=R180InizioMese(selI071.FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime);
end;

procedure TA008FOperatoriDtm1.selI071FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=DataSet.FieldByName('AZIENDA').AsString = AziendaCorrente;
end;

procedure TA008FOperatoriDtm1.I060SettaFiltroI061;
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

  QI060.SetVariable('FILTRO_I061',Filtro);
  QI060.Close;
  QI060.Open;
end;

procedure TA008FOperatoriDtm1.QI060FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  //Gestire il filtro sulla griglia
  try
    if (A008FLoginDipendenti = nil) or
       (A008FLoginDipendenti.C600frmSelAnagrafe.C600SelAnagrafe = nil) or
       (not A008FLoginDipendenti.C600frmSelAnagrafe.C600SelAnagrafe.Active) then
      Accept:=False
    else
      Accept:=QI060.FieldByName('MATRICOLA').IsNull or (VarToStr(A008FLoginDipendenti.C600frmSelAnagrafe.C600SelAnagrafe.Lookup('MATRICOLA',QI060.FieldByName('MATRICOLA').AsString,'MATRICOLA')) <> '');
  except
    Accept:=False;
  end;
end;

end.

