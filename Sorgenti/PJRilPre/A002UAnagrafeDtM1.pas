unit A002UAnagrafeDtM1;

interface

uses
  Windows,Messages,SysUtils,StrUtils,Classes,Graphics,Controls,Forms,Dialogs, ComCtrls,
  StdCtrls, DBCtrls, QueryStorico, A002UAnagrafeVista, A002UAnagrafeVistaPadre,
  A000Versione,
  A000UCostanti,
  A000USessione,
  A000UInterfaccia,
  A000UMessaggi,
  A002UAnagrafeMW,
  A099UUtilityDBMW,
  C180FunzioniGenerali,
  C700USelezioneAnagrafe,
  FunzioniGenerali,
  L021Call,
  RegistrazioneLog, OracleData, Oracle, I011UIntegrazioneSQL, USelI010,
  (*Midaslib,*)Db, Variants, Math;

const DataFine = '31/12/3999';
      DataBase = '01/01/1900';
      NumTabelle = 16;
      //{$I L000ParametriClienti}
type
  //Informazioni sui dati liberi
  DatoLibero = record
    NomeTabella:String;
    Storico:String;
    Query:TOracleDataSet;
    Sorgente:TDataSource;
    IntCampo:TLabel;
    LCampo:TDBText;
    ECampo:TDBLookupComboBox;
    ECampo2:TDBEdit;
  end;
  //Contiene i nomi delle tabelle individuali per la cancellazione del dipendente
  TTabIndividuali = record
    N,P:String
  end;
  //Contiene l'elenco dei campi della QVista con DisplayLabel, DispalyWidth, Visible
  TQVistaFields = record
    FieldName,DisplayLabel:String;
    DisplayWidth,Index:Word;
    Visible:Boolean;
  end;

  TA002FAnagrafeDtM1 = class(TDataModule)
    D030: TDataSource;
    D480: TDataSource;
    D430: TDataSource;
    DQVista: TDataSource;
    T480: TOracleDataSet;
    OperSQL: TOracleQuery;
    Q030Count: TOracleQuery;
    Q034: TOracleDataSet;
    InsQ034: TOracleQuery;
    QVista: TOracleDataSet;
    Q030: TOracleDataSet;
    Q030MATRICOLA: TStringField;
    Q030PROGRESSIVO: TFloatField;
    Q030COGNOME: TStringField;
    Q030NOME: TStringField;
    Q030SESSO: TStringField;
    Q030DATANAS: TDateTimeField;
    Q030COMUNENAS: TStringField;
    Q030CAPNAS: TStringField;
    Q030CODFISCALE: TStringField;
    Q030INIZIOSERVIZIO: TDateTimeField;
    Q030DescComune: TStringField;
    Q030D_Cap: TStringField;
    Q030NomeCognome: TStringField;
    Q030D_CodCatastale: TStringField;
    Q430: TOracleDataSet;
    Q430DATADECORRENZA: TDateTimeField;
    Q430DATAFINE: TDateTimeField;
    Q430EDBADGE: TStringField;
    Q430INDIRIZZO: TStringField;
    Q430COMUNE: TStringField;
    Q430CAP: TStringField;
    Q430TELEFONO: TStringField;
    Q430INIZIO: TDateTimeField;
    Q430FINE: TDateTimeField;
    Q430SQUADRA: TStringField;
    Q430TIPOOPE: TStringField;
    Q430TERMINALI: TStringField;
    Q430CAUSSTRAORD: TStringField;
    Q430STRAORDE: TStringField;
    Q430STRAORDU: TStringField;
    Q430STRAORDEU: TStringField;
    Q430CONTRATTO: TStringField;
    Q430ORARIO: TStringField;
    Q430HTEORICHE: TStringField;
    Q430PERSELASTICO: TStringField;
    Q430TGESTIONE: TStringField;
    Q430PLUSORA: TStringField;
    Q430CALENDARIO: TStringField;
    Q430IPRESENZA: TStringField;
    Q430PORARIO: TStringField;
    Q430PASSENZE: TStringField;
    Q430ABCAUSALE1: TStringField;
    Q430ABPRESENZA1: TStringField;
    Q430TIPORAPPORTO: TStringField;
    Q430PARTTIME: TStringField;
    Q430STRAORDEU2: TStringField;
    Q430D_Comune: TStringField;
    Q430D_Cap: TStringField;
    Q430D_Provincia: TStringField;
    Q430D_Squadra: TStringField;
    Q430D_Contratto: TStringField;
    Q430D_TIPOCART: TStringField;
    Q430D_PlusOra: TStringField;
    Q430D_Calendario: TStringField;
    Q430D_IPresenza: TStringField;
    Q430D_POrario: TStringField;
    Q430D_PAssenze: TStringField;
    Q430D_TipoRapporto: TStringField;
    Q430D_PartTime: TStringField;
    Q430PROGRESSIVO: TFloatField;
    Q430BADGE: TFloatField;
    Q430B: TOracleDataSet;
    Q430BDATADECORRENZA2: TDateTimeField;
    Q430BDATAFINE2: TDateTimeField;
    Q430BEDBADGE2: TStringField;
    Q430BINDIRIZZO2: TStringField;
    Q430BCOMUNE2: TStringField;
    Q430BCAP2: TStringField;
    Q430BTELEFONO2: TStringField;
    Q430BINIZIO2: TDateTimeField;
    Q430BFINE2: TDateTimeField;
    Q430BSQUADRA2: TStringField;
    Q430BTIPOOPE2: TStringField;
    Q430BTERMINALI2: TStringField;
    Q430BCAUSSTRAORD2: TStringField;
    Q430BSTRAORDE2: TStringField;
    Q430BSTRAORDU2: TStringField;
    Q430BSTRAORDEU3: TStringField;
    Q430BCONTRATTO2: TStringField;
    Q430BORARIO2: TStringField;
    Q430BHTEORICHE2: TStringField;
    Q430BPERSELASTICO2: TStringField;
    Q430BTGESTIONE2: TStringField;
    Q430BPLUSORA2: TStringField;
    Q430BCALENDARIO2: TStringField;
    Q430BIPRESENZA2: TStringField;
    Q430BPORARIO2: TStringField;
    Q430BPASSENZE2: TStringField;
    Q430BABCAUSALE12: TStringField;
    Q430BABPRESENZA12: TStringField;
    Q430BTIPORAPPORTO2: TStringField;
    Q430BPARTTIME2: TStringField;
    Q430BSTRAORDEU22: TStringField;
    Q430BPROGRESSIVO: TFloatField;
    Q430BBADGE: TFloatField;
    T480CODICE: TStringField;
    T480CITTA: TStringField;
    T480CAP: TStringField;
    T480PROVINCIA: TStringField;
    T480CODCATASTALE: TStringField;
    InsQ033: TOracleQuery;
    Q033B: TOracleDataSet;
    Q033BTOP: TFloatField;
    Q033BLFT: TFloatField;
    Q033BCAPTION: TStringField;
    Q033BACCESSO: TStringField;
    Q033BNOMEPAGINA: TStringField;
    Q033BCAMPODB: TStringField;
    Q033: TOracleDataSet;
    sel070: TOracleDataSet;
    selT033: TOracleDataSet;
    Q030D_ProvinciaNas: TStringField;
    selaT033: TOracleDataSet;
    selT432: TOracleDataSet;
    Q033BROWNUM: TFloatField;
    updDec: TOracleQuery;
    Q430DOCENTE: TStringField;
    Q030TIPO_PERSONALE: TStringField;
    Q430QUALIFICAMINIST: TStringField;
    Q430TIPO_LOCALITA_DIST_LAVORO: TStringField;
    Q430COD_LOCALITA_DIST_LAVORO: TStringField;
    Q430D_QUALIFICAMINIST: TStringField;
    Q430D_COD_LOCALITA_DIST_LAVORO: TStringField;
    selLocalita: TOracleDataSet;
    DselLocalita: TDataSource;
    Q430BDOCENTE: TStringField;
    Q430BQUALIFICAMINIST: TStringField;
    Q430BTIPO_LOCALITA_DIST_LAVORO: TStringField;
    Q430BCOD_LOCALITA_DIST_LAVORO: TStringField;
    selP430: TOracleDataSet;
    Q430INIZIO_IND_MAT: TDateTimeField;
    Q430FINE_IND_MAT: TDateTimeField;
    Q430BINIZIO_IND_MAT: TDateTimeField;
    Q430BFINE_IND_MAT: TDateTimeField;
    selI050: TOracleDataSet;
    Q430MEDICINA_LEGALE: TStringField;
    Q430D_MEDICINA_LEGALE: TStringField;
    Q430BMEDICINA_LEGALE: TStringField;
    Q030I060EMAIL: TStringField;
    Q430INDIRIZZO_DOM_BASE: TStringField;
    Q430COMUNE_DOM_BASE: TStringField;
    Q430CAP_DOM_BASE: TStringField;
    Q430D_COMUNE_DOM_BASE: TStringField;
    Q430D_CAP_DOM_BASE: TStringField;
    Q430D_PROVINCIA_DOM_BASE: TStringField;
    Q430BINDIRIZZO_DOM_BASE: TStringField;
    Q430BCOMUNE_DOM_BASE: TStringField;
    Q430BCAP_DOM_BASE: TStringField;
    T480SOPPRESSO: TStringField;
    Q430AZIENDA_BASE: TStringField;
    Q430D_AZIENDA_BASE: TStringField;
    Q430BAZIENDA_BASE: TStringField;
    Q030I060EMAILPEC: TStringField;
    Q030TIPO_SOGGETTO_BASE: TStringField;
    Q030I060CELLULARE: TStringField;
    Q430RAPPORTI_UNIFICATI: TStringField;
    Q430BRAPPORTI_UNIFICATI: TStringField;
    Q030I060EMAILPERSONALE: TStringField;
    Q030I060CELLULAREPERSONALE: TStringField;
    procedure Q030NewRecord(DataSet: TDataSet);
    procedure Q030AfterInsert(DataSet: TDataSet);
    procedure Q030AfterCancel(DataSet: TDataSet);
    procedure Q030BeforePost(DataSet: TDataSet);
    procedure T430DataFineGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure D030StateChange(Sender: TObject);
    procedure A002FAnagrafeDtM1Create(Sender: TObject);
    procedure Q030CalcFields(DataSet: TDataSet);
    procedure Q430StringField27Validate(Sender: TField);
    procedure Q430BFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure A002FAnagrafeDtM1Destroy(Sender: TObject);
    procedure Q030AfterDelete(DataSet: TDataSet);
    procedure Q030AfterPost(DataSet: TDataSet);
    procedure Q010AfterOpen(DataSet: TDataSet);
    procedure Q030BeforeInsert(DataSet: TDataSet);
    procedure Q030BeforeEdit(DataSet: TDataSet);
    procedure Q430AfterFetchRecord(Sender: TOracleDataSet;
      FilterAccept: Boolean; var Action: TAfterFetchRecordAction);
    procedure D430DataChange(Sender: TObject; Field: TField);
    procedure QVistaAfterScroll(DataSet: TDataSet);
    procedure Q430BeforeInsert(DataSet: TDataSet);
    procedure Q430AfterInsert(DataSet: TDataSet);
    procedure Q430BeforeEdit(DataSet: TDataSet);
    procedure Q430AfterOpen(DataSet: TDataSet);
    procedure Q430AfterScroll(DataSet: TDataSet);
    procedure sel070BeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    CreazioneDataModule,IntegrazioneOut,AllineaCessazione,AllineaRapportiUnificati,EseguiRelazioni:Boolean;
    ApriCdcPerc:Boolean;
    OldInizio,OldFine,OldDataFine:TDateTime;
    OldRapportiUnificati:String;
    ModificaStoricizzata:String;
    NomiTabelle:array of String;
    RelFiltrate:Boolean;
    procedure settaListSource;
    procedure EliminaB005B007;
    procedure CreaDatiLiberi;
    procedure Relaziona(Prog:LongInt; DataLav:TDateTime);
    procedure InizializzaDatiLiberi;
    procedure AggiornamentoStoriciPrecSucc(Data:TDateTime; Tipo:String);
    procedure DistruggiDatiLiberi;
    procedure AggiornaCdCPercentualizzati;
  public
    A002FAnagrafeMW:TA002FAnagrafeMW;
    TuttoStorico:(tsTutto,tsPrima,tsDopo); {tipo di filtro su archivio T430_Storico}
    Inserimento,StoricizzazioneInCorso:Boolean; {True:inserisco nuovi storici False:storicizzo dati}
    Decor:TDateTime; {Contiene la decorrenza del dato}
    ProgOperDM,OrderString,SelectString:String;
    ListSQL,ListaAssenze,ListaPresenze:TStringList;
    DatiLiberi: array of DatoLibero;
    QVistaFields:array of TQVistaFields;
    AbilAnagra:(aaReadWrite,aaReadOnly,aaNone);
    QI010:TselI010;
    OldTipoRapporto,NewTipoRapporto:String;
    procedure RinfrescaQueryDescrizioni(DataDec: TDateTime);
    procedure CaricaGriglia;
    procedure EsegueVista;
    procedure QueryAnagrafeStorico;
    procedure OrdinaAnagrafe(Campo:String);
    procedure CercaAnagrafe;
    procedure RicostruisciAnagrafico;
    procedure AperturaDatabase;
    procedure ActiveDatiLiberi(Active:Boolean);
    procedure GetIntegrazione;
    procedure ChiamaStorico(Prog:Integer; Data:TDateTime);
    procedure CaricaTVAzienda(Completa:Boolean);
    procedure GetColonneStruttura(CreaCampi:Boolean);
    procedure GetDateDecorrenza;
    procedure RegistraQVistaFields;
    procedure ApplicaQVistaFields;
    procedure RefreshLookupCache(ds:TDataSet);
    procedure RefreshFiltro(Sender: TField);
    procedure AllineaDataFine;
    procedure OpenA002ShortTerm(Progressivo:Integer; TipoRichiamo,TipoRapporto:String; DataRiferimento,StartDate,CessDate:TDateTime);
  end;

const
  TabIndividuali:array [0..14] of TTabIndividuali =
        ((N:'T012_CALENDINDIVID';P:'PROGRESSIVO'),
         (N:'T040_GIUSTIFICATIVI';P:'PROGRESSIVO'),
         (N:'T070_SCHEDARIEPIL';P:'PROGRESSIVO'),
         (N:'T071_SCHEDAFASCE';P:'PROGRESSIVO'),
         (N:'T072_SCHEDAINDPRES';P:'PROGRESSIVO'),
         (N:'T073_SCHEDACAUSPRES';P:'PROGRESSIVO'),
         (N:'T074_CAUSPRESFASCE';P:'PROGRESSIVO'),
         (N:'T080_PIANIFORARI';P:'PROGRESSIVO'),
         (N:'T090_PLUSORAINDIV';P:'PROGRESSIVO'),
         (N:'T100_TIMBRATURE';P:'PROGRESSIVO'),
         (N:'T130_RESIDANNOPREC';P:'PROGRESSIVO'),
         (N:'T131_RESIDUIFASCE';P:'PROGRESSIVO'),
         (N:'T263_PROFASSIND';P:'PROGRESSIVO'),
         (N:'T264_RESIDASSANN';P:'PROGRESSIVO'),
         (N:'T430_STORICO';P:'PROGRESSIVO'));

var
  A002FAnagrafeDtM1: TA002FAnagrafeDtM1;

implementation

uses A002UAnagrafeGest, C001URicerca, A002UBadgeMsg, A002ULayout,
     A002UShortTerm;

{$R *.DFM}

procedure TA002FAnagrafeDtM1.A002FAnagrafeDtM1Create(Sender: TObject);
{Apertura degli archivi, imposto Operatore Occupato}
var i:Integer;
begin
  EliminaB005B007;
  DataBaseDrv:=dbOracle;
  SolaLetturaOriginale:=True;
  EseguiRelazioni:=True;
  OldDataFine:=-1;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  A000ParamDBOracle(SessioneOracle);
  if VersioneDimostrativa then
    with A002FAnagrafeDtM1.Q030Count do
    begin
      Execute;
      if Field(0) > 40 then
      begin
        ShowMessage('Questa è una versione dimostrativa: ' + #13 + 'è stato superato il numero di dipendenti disponibili!');
        Application.Terminate;
        exit;
      end;
    end;
  if TRUE AND (Parametri.VersioneDB <> '') and (Parametri.VersionePJ <> Parametri.VersioneDB) then
  begin
    ShowMessage('Attenzione!' + #13 +
                 Format('La versione del database (%s) non corrisponde alla versione del prodotto (%s).',[Parametri.VersioneDB,Parametri.VersionePJ]) + #13 +
                 'E'' necessario allineare la propria postazione di lavoro alla versione del database.' + #13 +
                 'Se il problema persiste contattare l''amministratore di sistema.');
    Application.Terminate;
    exit;
  end;
  selI050.SetVariable('NOME',ScriptSQLPA);
  selI050.Open;
  if TRUE AND (Parametri.VersioneDB <> '') and (*(Parametri.BuildPJ <> '0') and*) (UpperCase(selI050.FieldByName('NOME').AsString) <> UpperCase(ScriptSQLPA)) then
  begin
    ShowMessage('Attenzione!' + #13 +
                 Format('La versione in uso richiede l''esecuzione dello script ''%s''',[ScriptSQLPA]) + #13 +
                 'Contattare l''amministratore di sistema per aggiornare correttamente il database.');
    if (Parametri.Azienda <> 'TESTR') and (*(Parametri.Operatore <> 'SYSMAN') and*) (Parametri.Operatore <> 'MONDOEDP') then
    begin
      Application.Terminate;
      exit;
    end;
  end;
  selI050.Close;

  if (Parametri.VersioneDB <> '') and
     (StrToIntDef(Parametri.BuildPJ,0) < StrToIntDef(Parametri.BuildDB,0)) then
  begin
    ShowMessage('Attenzione!' + #13 +
                Format('Si sta utilizzando un applicativo non aggiornato: è richiesta la versione %s(%s)',[Parametri.VersioneDB,Parametri.BuildDB]) + #13 +
                 'Contattare l''amministratore di sistema per aggiornare correttamente l''applicativo.');
    if (Parametri.Azienda <> 'TESTR') and (Parametri.Operatore <> 'SYSMAN') and (Parametri.Operatore <> 'MONDOEDP') then
    begin
      Application.Terminate;
      exit;
    end;
  end;

  RegistraLog.SettaProprieta('A','','A002',nil,True);
  RegistraLog.InserisciDato('APPLICATIVO','',UpperCase(ExtractFileName(Application.ExeName)));
  RegistraLog.InserisciDato('OPERATORE','',Parametri.Operatore);
  RegistraLog.InserisciDato('TIPO','','ACCESSO');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;

  //Alberto 16/04/2013: verifica esistenza V430
  with TOracleDataSet.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Text:='select T430PROGRESSIVO from V430_STORICO where T430PROGRESSIVO = -1';
    try
      Open;
    except
      with TA099FUtilityDBMW.Create(nil) do
      try
        CostruisciV430;
      finally
        Free;
      end;
    end;
    Close;
  finally
    Free;
  end;

  //Imposto le inibizioni sulle funzioni
  A002FAnagrafeVista.InibizioniFunzioni;
  ProgOperDM:=IntToStr(Parametri.ProgOper);
  SetLength(NomiTabelle,NumTabelle + 1);
  NomiTabelle[1]:='T480_COMUNI';
  NomiTabelle[2]:='T603_SQUADRE';
  NomiTabelle[3]:='T200_CONTRATTI';
  NomiTabelle[4]:='T060_PLUSORARIO';
  NomiTabelle[5]:='T010_CALENDIMPOSTAZ';
  NomiTabelle[6]:='T163_CODICIINDENNITA';
  NomiTabelle[7]:='T220_PROFILIORARI';
  NomiTabelle[8]:='T261_DESCPROFASS';
  NomiTabelle[9]:='T265_CAUASSENZE';
  NomiTabelle[10]:='T270_RAGGRPRESENZE';
  NomiTabelle[11]:='T025_CONTMENSILI';
  NomiTabelle[12]:='T450_TIPORAPPORTO';
  NomiTabelle[13]:='T460_PARTTIME';
  NomiTabelle[14]:='T470_QUALIFICAMINIST';
  NomiTabelle[15]:='T485_MEDICINELEGALI';
  NomiTabelle[16]:='T440_AZIENDE_BASE';
  CreazioneDataModule:=True;
  //OrderString:='';
  //SelectString:='';
  //SelectString:='AND PROGRESSIVO = 0';
  A002FAnagrafeMW:=TA002FAnagrafeMW.Create(Self);
  A002FAnagrafeMW.selT030_Funzioni:=Q030;
  A002FAnagrafeMW.selT430_Funzioni:=Q430;
  A002FAnagrafeMW.selT430OldValues.SetDataSet(Q430);

  ListSQL:=TStringList.Create;
  ListaAssenze:=TStringList.Create;
  ListaPresenze:=TStringList.Create;
  with A002FAnagrafeVista do
  begin
    Azienda:=Parametri.Azienda;
    Operatore:=Parametri.Operatore;
    Caption:=Caption + Format(' %s %s (%s)',[Azienda,Operatore,Parametri.Database]);
    if VersioneDimostrativa then
      Caption:=Caption + ' - VERSIONE DIMOSTRATIVA'
    else
      Caption:=Caption + ' - ' + Parametri.RagioneSociale;
    A002FAnagrafeGest.Caption:='<A002> Scheda anagrafica';
    R180SetVariable(selT432,'UTENTE',Parametri.Operatore);
    selT432.Open;
    if not selT432.FieldByName('DATA').IsNull then
    begin
      Parametri.DataLavoro:=selT432.FieldByName('DATA').AsDateTime;
      DataLavoro:=Parametri.DataLavoro;
      StatusBar.Panels[2].Text:='Data di lavoro:' + FormatDateTime('dd/mm/yyyy',DataLavoro);
    end;
    selT432.Close;
  end;
  //Imposto layout della scheda anagrafica
  R180SetReadBuffer(selaT033);
  selaT033.Open;
  //A000GetLayout(A000SessioneIrisWIN); //Alberto: Già letto su A001UPasswordDtM1
  //Controllo inibizione su anagrafico
  QI010:=TselI010.Create(Self);
  QI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'','','RICERCA,NOME_LOGICO');
  if Parametri.CampiRiferimento.C26_HintT030V430 <> '' then
    QVista.SQL.Text:=StringReplace(QVista.SQL.Text,'SELECT T030.*',Format('SELECT %s T030.*',[Parametri.CampiRiferimento.C26_HintT030V430]),[rfIgnoreCase]);
  AperturaDatabase;
  if AbilAnagra <> aaNone then
  begin
    //AperturaDatabase;
    if (Parametri.Applicazione = 'RILPRE') and (Parametri.CampiRiferimento.C5_IntegrazAnag = 'T') and (Parametri.IntegrazioneAnagrafe = 'S') then
    begin
      I011FIntegrazioneSQL:=TI011FIntegrazioneSQL.Create(nil);
      I011FIntegrazioneSQL.IntegrazioneAnagrafica;
      I011FIntegrazioneSQL.Free;
    end;
    //QI010:=TselI010.Create(Self);
    //QI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'','','RICERCA,NOME_LOGICO');
    //SetVariable('APPLICAZIONE',Parametri.Applicazione);
    EsegueVista;
  end;
  with A002FAnagrafeMW.selT265 do
    while not Eof do
    begin
      ListaAssenze.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  with A002FAnagrafeMW.selT270 do
    while not Eof do
    begin
      ListaPresenze.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  settaListSource;
end;

procedure TA002FAnagrafeDtM1.sel070BeforeOpen(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset as TOracleDataset);
end;

procedure TA002FAnagrafeDtM1.settaListSource;
begin
  A002FAnagrafeGest.ECalendario.ListSource:=A002FAnagrafeMW.dsrT010;
  A002FAnagrafeGest.ETipoCart.ListSource:=A002FAnagrafeMW.dsrT025;
  A002FAnagrafeGest.EPlusOra.ListSource:=A002FAnagrafeMW.dsrT060;
  A002FAnagrafeGest.EIPresenza.ListSource:=A002FAnagrafeMW.dsrT163;
  A002FAnagrafeGest.EContratto.ListSource:=A002FAnagrafeMW.dsrT200;
  A002FAnagrafeGest.EPOrario.ListSource:=A002FAnagrafeMW.dsrT220;
  A002FAnagrafeGest.EPAssenze.ListSource:=A002FAnagrafeMW.dsrT261;
  A002FAnagrafeGest.dcmbAziendaBase.ListSource:=A002FAnagrafeMW.dsrT440;
  A002FAnagrafeGest.ETipoRapp.ListSource:=A002FAnagrafeMW.dsrT450;
  A002FAnagrafeGest.EParttime.ListSource:=A002FAnagrafeMW.dsrT460;
  A002FAnagrafeGest.dcmbMedicinaLegale.ListSource:=A002FAnagrafeMW.dsrT485;
  A002FAnagrafeGest.dcmbQualificaMinisteriale.ListSource:=A002FAnagrafeMW.dsrT470;
  A002FAnagrafeGest.ESquadra.ListSource:=A002FAnagrafeMW.dsrT603;
end;

procedure TA002FAnagrafeDtM1.EliminaB005B007;
{Eliminazione del B005 ante-23/09/2010 e del B007 per evitare accessi non consentiti}
var F:TSearchRec;
begin
  try
    if FindFirst('B005PAggIris.exe',faAnyFile,F) = 0 then
    begin
      if F.TimeStamp <= EncodeDate(2010,9,23) then
        DeleteFile('B005PAggIris.exe');
    end;
    FindClose(F);
  except
  end;
  try
    if FindFirst('B007PManipolazioneDati.exe',faAnyFile,F) = 0 then
      DeleteFile('B007PManipolazioneDati.exe');
    FindClose(F);
  except
  end;
end;

procedure TA002FAnagrafeDtM1.AperturaDatabase;
{Stabilisco la connessione col database e apro le tabelle richieste}
begin
  with A002FAnagrafeMW do
  begin
    selT010.Open;
    selT025.Open;
    selT060.Open;
    selT163.Open;
    selT200.Open;
    selT220.Open;
    selT261.Open;
    selT265.Open;
    selT270.Open;
    selT440.Open;
    selT450.Open;
    selT460.Open;
    selT470.Open;
    selT485.Open;
    selT603.Open;
    selT033_campoDecode.Close;
    selT033_campoDecode.SetVariable('Nome',Parametri.Layout);
    selT033_campoDecode.Open;
    selI030.Open;
    selI035.Open;
    RefreshVSQLAppoggio;
  end;

  if not T480.Active then
    T480.ReadBuffer:=A002FAnagrafeMW.GetReadBuffer(R180Query2NomeTabella(T480),'N');
  T480.Open;

  if R180Query2NomeTabella(SelLocalita) = R180Query2NomeTabella(T480) then
    SelLocalita.ReadBuffer:=T480.ReadBuffer
  else if not SelLocalita.Active then
    SelLocalita.ReadBuffer:=A002FAnagrafeMW.GetReadBuffer(R180Query2NomeTabella(SelLocalita),'N');
  SelLocalita.Open;
end;


procedure TA002FAnagrafeDtM1.RefreshLookupCache(ds:TDataSet);
var i:Integer;
begin
  for i:=0 to Q030.FieldCount - 1 do
    if (Q030.Fields[i].FieldKind = fkLookup) and (Q030.Fields[i].LookupDataSet = ds) then
      Q030.Fields[i].RefreshLookupList;
  for i:=0 to Q430.FieldCount - 1 do
    if (Q430.Fields[i].FieldKind = fkLookup) and (Q430.Fields[i].LookupDataSet = ds) then
      Q430.Fields[i].RefreshLookupList;
end;

procedure TA002FAnagrafeDtM1.EsegueVista;
{Crea gli eventuali controlli dei campi liberi
 Esegue la Query per estrarre i dati Anagrafici + Storici con descrizioni}
begin
  {Eseguo la creazione dati liberi solo una volta all'inizio
  dell'esecuzione}
  if CreazioneDataModule then
    CreaDatiLiberi;
  //Creo Vista dei dati anagrafici
  //QueryAnagrafeStorico;
end;

procedure TA002FAnagrafeDtM1.GetIntegrazione;
begin
  if (Parametri.Applicazione = 'RILPRE') and
     (Parametri.CampiRiferimento.C5_IntegrazAnag = 'T') and
     (Parametri.IntegrazioneAnagrafe = 'S') then
  begin
    I011FIntegrazioneSQL:=TI011FIntegrazioneSQL.Create(nil);
    I011FIntegrazioneSQL.IntegrazioneAnagrafica;
    I011FIntegrazioneSQL.Free;
  end;
end;

procedure TA002FAnagrafeDtM1.RicostruisciAnagrafico;
begin
  Screen.Cursor:=crHourGlass;
  try
    CreazioneDataModule:=True;
    InizializzaDatiLiberi;
    CreaDatiLiberi;
    try
      //A099FUtilityDBMW.CostruisciV430;
    except
      on E:Exception do
        raise Exception.Create('Creazione V430_STORICO fallita!' + #13#10 + E.Message);
    end;
    if AbilAnagra <> aaNone then
    begin
      A002FLayout.Inizializza;
      QueryAnagrafeStorico;
      A002FLayout.Attivazione;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA002FAnagrafeDtM1.InizializzaDatiLiberi;
{Dealloca le risorse utilizzate per i dati liberi}
begin
  QVista.CloseAll;
  Q030.CloseAll;
  Q430.CloseAll;
  Q430B.CloseAll;
  AperturaDatabase;
  DistruggiDatiLiberi;
end;

procedure TA002FAnagrafeDtM1.DistruggiDatiLiberi;
var i:Integer;
begin
  for i:=1 to A002FAnagrafeVista.NumDatiLiberi do
    with DatiLiberi[i] do
      if Assigned(IntCampo) then
        try
        IntCampo.Free;
        if ECampo = nil then
          begin
          Q430.FieldByName(ECampo2.DataField).Free;
          Q430B.FieldByName(ECampo2.DataField).Free;
          ECampo2.Free;
          end
        else
          begin
          Q430.FieldByName(ECampo.DataField).Free;
          Q430B.FieldByName(ECampo.DataField).Free;
          Q430.FieldByName(LCampo.DataField).Free;
          ECampo.Free;
          LCampo.Free;
          Query.Close;
          end;
        NomeTabella:='';
        Query.Free;
        Sorgente.Free;
        except
          R180AppendFile('IrisWIN.log','IntCampo.Free ' + IntToStr(i));
        end;
  SetLength(DatiLiberi,0);
end;

procedure TA002FAnagrafeDtM1.CreaDatiLiberi;
{Scorro I500 e creo Query e DataSource corrispondenti per
ciascun dato;
creo i campi persistenti del dato Codice e della descrizione (Lookup)
Creo i componenti visuali Label,DBLookupComboBox e DBText}
var NomeCampo:String;
    NDatiLiberi,Dimensione,Offset,PLeft:Integer;
    Parente:TWinControl;
begin
  //Creo i campi persistenti sia per Q430 che Q430B
  //(per visualizzazione storici)
  Q430.FieldDefs.Update;
  Q430B.FieldDefs.Update;
  SetLength(DatiLiberi,0);
  with A002FAnagrafeMW.selI500 do
  begin
    NDatiLiberi:=0;
    Close;
    Open;
    if RecordCount = 0 then exit;
    First;
    while not Eof do
    begin
      Inc(NDatiLiberi);
      SetLength(NomiTabelle,NumTabelle + NDatiLiberi + 1);
      SetLength(A002FAnagrafeVista.Storico,NumStorici + NDatiLiberi + 1);
      SetLength(DatiLiberi,NDatiLiberi + 1);
      // Appoggio momentaneamente i dati sulla 3° videata di dati fissi
      Parente:=TA002FLayout.GetScrollBoxTab(A002FAnagrafeGest.TabSheet3);
      Offset:=8;
      Dimensione:=0;
      PLeft:=Parente.Width div 2;
      NomeCampo:=FieldByName('NomeCampo').AsString;
      //Se è un dato tabellare costruisco la query associata
      if FieldByName('Tabella').AsString = 'S' then
        with DatiLiberi[NDatiLiberi] do
        begin
          {Creo Query associata al dato libero}
          NomeTabella:='I501'+NomeCampo;
          Storico:=FieldByName('STORICO').AsString;
          Query:=TOracleDataSet.Create(nil);
          Query.Name:='Q501'+NomeCampo;
          Query.Session:=SessioneOracle;
          //Alberto 26/04/2018: leggo num.rec. per dimensionare ReadBuffer
          Query.ReadBuffer:=A002FAnagrafeMW.GetReadBuffer(NomeTabella,FieldByName('STORICO').AsString);
          Query.AfterOpen:=Q010AfterOpen;
          Query.OnFilterRecord:=nil;
          Query.Filtered:=False;
          Query.SQL.Clear;
          Query.DeleteVariables;
          //Se il dato libero è storicizzato filtro max di data decorrenza
          if FieldByName('STORICO').AsString = 'S' then
          begin
            Query.SQL.Add('select * from ' + NomeTabella + ' T1 where :DATA between DECORRENZA and DECORRENZA_FINE');
            //Query.SQL.Add('SELECT * FROM ' + NomeTabella + ' T1 WHERE DECORRENZA = ');
            //Query.SQL.Add('(SELECT MAX(DECORRENZA) FROM ' + NomeTabella + ' WHERE CODICE = T1.CODICE AND DECORRENZA <= :Data)');
            Query.SQL.Add(' order by CODICE');
            Query.DeclareVariable('Data',otDate);
            Query.SetVariable('Data',Parametri.DataLavoro);
          end
          else
            Query.SQL.Add('select * from ' + NomeTabella + ' order by CODICE');
          Query.Open;
          //Creo data source associato alla tabella
          Sorgente:=TDataSource.Create(nil);
          Sorgente.Name:='D501'+NomeCampo;
          Sorgente.DataSet:=Query;
        end
      else
        DatiLiberi[NDatiLiberi].Query:=nil;
      //Creo il campo persistente associato al dato libero con indice = al progressivo dato libero
      if FieldByName('Formato').AsString = 'S' then
      begin
        with TStringField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430.Name + FieldName;
          Size:=FieldByName('Lunghezza').AsInteger;
          DataSet:=Q430;
          Index:=NumStorici + 2 + NDatiLiberi;
          //if (FieldByName('Riferimento').AsString = 'S') or (FieldByName('Riferimento').AsString = 'L') then //Lorena 17/05/2005
          //  OnValidate:=CampiCollegati;
          Required:=FieldByName('NULLABLE').AsString <> 'Y';
        end;
        //Creo lo stesso campo anche per Q430B
        with TStringField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430B.Name + FieldName;
          Size:=FieldByName('Lunghezza').AsInteger;
          Dimensione:=Size;
          DataSet:=Q430B;
        end;
      end
      else if FieldByName('Formato').AsString = 'D' then
      begin
        with TDateTimeField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430.Name + FieldName;
          DisplayFormat:='dd/mm/yyyy';
          EditMask:='!00/00/0000;1;_';
          DataSet:=Q430;
          Index:=NumStorici + 2 + NDatiLiberi;
          Required:=FieldByName('NULLABLE').AsString <> 'Y';
        end;
        //Creo lo stesso campo anche per Q430B
        with TDateTimeField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430B.Name + FieldName;
          Dimensione:=FieldByName('Lunghezza').AsInteger;
          DataSet:=Q430B;
        end;
      end
      else if FieldByName('Formato').AsString = 'N' then
      begin
        with TFloatField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430.Name + FieldName;
          DataSet:=Q430;
          Index:=NumStorici + 2 + NDatiLiberi;
          Required:=FieldByName('NULLABLE').AsString <> 'Y';
        end;
        //Creo lo stesso campo anche per Q430B
        with TFloatField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430B.Name + FieldName;
          Dimensione:=FieldByName('Lunghezza').AsInteger;
          DataSet:=Q430B;
        end;
      end;
      //Se è un dato tabellare creo il campo di Lookup
      if FieldByName('Tabella').AsString = 'S' then
        with TStringField.Create(nil) do
          begin
          FieldName:='D_'+NomeCampo;
          Name:=Q430.Name + FieldName;
          Size:=FieldByName('LUNG_DESC').AsInteger;
          Index:=Q430.FieldCount - 1;
          LookUp:=True;
          LookupDataSet:=DatiLiberi[NDatiLiberi].Query;
          LookupKeyFields:='Codice';
          LookupResultField:='Descrizione';
          KeyFields:=NomeCampo;
          Tag:=NumTabelle + NDatiLiberi;
          NomiTabelle[Tag]:=DatiLiberi[NDatiLiberi].NomeTabella;
          DataSet:=Q430;
          end;
      Q430.FieldDefs.Update;
      with DatiLiberi[NDatiLiberi] do
        begin
        {Creo Label di intestazione}
        IntCampo:=TLabel.Create(nil);
        IntCampo.Parent:=Parente;
        IntCampo.Caption:=NomeCampo;
        IntCampo.AutoSize:=True;
        IntCampo.Left:=PLeft;
        IntCampo.Top:=(NDatiLiberi - Offset - 1) * 36 + 6;
        IntCampo.Visible:=True;
        IntCampo.ParentFont:=False;
        IntCampo.Font.Color:=clBlue;
        if FieldByName('Tabella').AsString = 'S' then
          //Se campo tabellare creo LookupComboBox e DBText
          begin
          ECampo:=TDBLookupComboBox.Create(nil);
          ECampo.Parent:=Parente;
          ECampo.Height:=21;
          ECampo.Width:=min(Dimensione,200) * ECampo.Font.Size + 25;
          ECampo.Left:=PLeft;
          ECampo.Top:=(NDatiLiberi - Offset - 1) * 36 + 20;
          ECampo.DataSource:=D430;
          ECampo.DataField:=NomeCampo;
          ECampo.ListSource:=DatiLiberi[NDatiLiberi].Sorgente;
          ECampo.ListField:='Codice;Descrizione';
          ECampo.KeyField:='Codice';
          ECampo.DropDownWidth:=FieldByName('LUNG_DESC').AsInteger * ECampo.Font.Size + 25;
          if FieldByName('LUNG_DESC').AsInteger > 100 then
            ECampo.BiDiMode:=bdRightToLeftNoAlign;
          ECampo.PopupMenu:=A002FAnagrafeGest.PopupMenu1;
          ECampo.Tag:=100+NDatiLiberi;
          ECampo.Visible:=True;
          ECampo.ParentFont:=True;
          ECampo.ShowHint:=True;
          ECampo.OnKeyDown:=A002FAnagrafeGest.dcmbKeyDown;
          //Creo DBText per descrizione codice}
          LCampo:=TDBText.Create(nil);
          LCampo.Parent:=Parente;
          LCampo.Height:=13;
          LCampo.Width:=LCampo.Canvas.TextWidth(StringReplace(Format('%*s',[FieldByName('LUNG_DESC').AsInteger,' ']),' ','M',[rfReplaceAll]));//170;
          LCampo.Left:=ECampo.Left + ECampo.Width + 2;
          LCampo.Top:=(NDatiLiberi - Offset - 1) * 36 + 23;
          LCampo.DataSource:=D430;
          LCampo.DataField:='D_'+NomeCampo;
          LCampo.Visible:=True;
          LCampo.ParentFont:=True;
          ECampo2:=nil;
          end
        else
          //Se campo NON tabellare creo DBEdit
          begin
          ECampo2:=TDBEdit.Create(nil);
          ECampo2.Parent:=Parente;
          ECampo2.Height:=21;
          ECampo2.Width:=min(Dimensione,200) * ECampo2.Font.Size + 8;
          ECampo2.Left:=PLeft;
          ECampo2.Top:=(NDatiLiberi - Offset - 1) * 36 + 20;
          ECampo2.DataSource:=D430;
          ECampo2.DataField:=NomeCampo;
          ECampo2.PopupMenu:=A002FAnagrafeGest.PopupMenu1;
          ECampo2.Tag:=100+NDatiLiberi;
          ECampo2.Visible:=True;
          ECampo2.ParentFont:=True;
          LCampo:=nil;
          ECampo:=nil;
          end;
        {Inserisco il dato nella lista dati storici}
        with A002FAnagrafeVista.Storico[NumStorici+NDatiLiberi] do
          begin
          if LCampo = nil then
            CampoInput:=ECampo2
          else
            CampoInput:=ECampo;
          end;
        end;
      Next;
    end;
    A002FAnagrafeVista.NumDatiLiberi:=NDatiLiberi;
  end;
end;

(*procedure TA002FAnagrafeDtM1.CampiCollegati(Sender: TField);
{Procedura di collegamento dati liberi alla loro validazione}
var i,Ind:Integer;
    Campo,Tabella:String;
begin
  Campo:=Sender.FieldName;
  Tabella:='I501' + Campo;
  Ind:=Sender.Index - 2 - NumStorici;
  with DatiLiberi[Ind].Query do
    begin
    Locate('Codice',Sender.AsString,[]);
    for i:=0 to FieldCount - 1 do
      if (Fields[i].FieldName <> 'CODICE') and (Fields[i].FieldName <> 'DESCRIZIONE') and
         (Fields[i].FieldName <> 'PROGRESSIVOQM') and (Fields[i].FieldName <> 'DECORRENZA') and
         (Fields[i].FieldName <> 'DECORRENZA_FINE') then
        begin
        try
          Q430.FieldByName(Fields[i].FieldName).AsString:=Fields[i].AsString;
        except
        end;
        end;
    end;
end;*)

procedure TA002FAnagrafeDtM1.RefreshFiltro(Sender: TField);
var i:Integer;
    SqlRelazione,SqlOriginale,sNomeCampo,CatenaRelazioni:String;
begin
  RelFiltrate:=False;
  if (A002FLayout = nil){ or (Not selI030.Active)} then
    exit;
  D430.OnDataChange:=nil;
  if Q430.FieldByName('DATAFINE').AsDateTime <> OldDataFine then
  begin
    A002FAnagrafeMW.selI030.Filtered:=False;
    A002FAnagrafeMW.selI030.Filtered:=True;
    OldDataFine:=Q430.FieldByName('DATAFINE').AsDateTime;
  end;

  if Sender <> nil then
  begin
    sNomeCampo:=(Sender as TField).FieldName;
    with A002FAnagrafeMW.GetCatena do
    begin
      if VarToStr(GetVariable('sColonna')) <> sNomeCampo then
      begin
        SetVariable('sColonna',sNomeCampo);
        SetVariable('sChain','');
        Execute;
      end;
      CatenaRelazioni:=VarToStr(GetVariable('sChain'));
      CatenaRelazioni:=StringReplace(CatenaRelazioni,'''' + sNomeCampo + ''',','',[rfReplaceAll]);//tolgo sè stesso
      CatenaRelazioni:=StringReplace(Copy(CatenaRelazioni,1,Length(CatenaRelazioni) - 1),'''','',[rfReplaceAll]);//tolgo la virgola in fondo e gli apici
    end;
  end
  else
    with A002FLayout do
      for i:=0 to High(Layout) do
      begin
        if Layout[i].LinkComp[1] = nil then
        begin
          if Layout[i].LinkComp[0] is TDBRadioGroup then
          begin
            if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBRadioGroup(Layout[i].LinkComp[0]).Field.FieldName,'S']),[srFromBeginning])
            or (StoricizzazioneInCorso and (A002FAnagrafeMW.selI500.Lookup('NOMECAMPO',TDBRadioGroup(Layout[i].LinkComp[0]).Field.FieldName,'STORICIZZABILE') = 'N')) then
            begin
              TDBRadioGroup(Layout[i].LinkComp[0]).Field.ReadOnly:=True;
              TDBRadioGroup(Layout[i].LinkComp[0]).Color:=cl3DLight;
            end
            else
            begin
              TDBRadioGroup(Layout[i].LinkComp[0]).Field.ReadOnly:=Layout[i].Accesso = 'R';
              TDBRadioGroup(Layout[i].LinkComp[0]).Color:=clBtnFace;
            end;
          end
          else if Layout[i].LinkComp[0] is TDBCheckBox then
          begin
            if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBCheckBox(Layout[i].LinkComp[0]).Field.FieldName,'S']),[srFromBeginning])
            or (StoricizzazioneInCorso and (A002FAnagrafeMW.selI500.Lookup('NOMECAMPO',TDBCheckBox(Layout[i].LinkComp[0]).Field.FieldName,'STORICIZZABILE') = 'N')) then
            begin
              TDBCheckBox(Layout[i].LinkComp[0]).Field.ReadOnly:=True;
              TDBCheckBox(Layout[i].LinkComp[0]).Color:=cl3DLight;
            end
            else
            begin
              TDBCheckBox(Layout[i].LinkComp[0]).Field.ReadOnly:=Layout[i].Accesso = 'R';
              TDBCheckBox(Layout[i].LinkComp[0]).Color:=clBtnFace;
            end;
          end;
        end
        else
        begin
          if Layout[i].LinkComp[1] is TDBEdit then
          begin
            if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBEdit(Layout[i].LinkComp[1]).Field.FieldName,'S']),[srFromBeginning])
            or (StoricizzazioneInCorso and (A002FAnagrafeMW.selI500.Lookup('NOMECAMPO',TDBEdit(Layout[i].LinkComp[1]).Field.FieldName,'STORICIZZABILE') = 'N')) then
            begin
              TDBEdit(Layout[i].LinkComp[1]).Field.ReadOnly:=True;
              TDBEdit(Layout[i].LinkComp[1]).Color:=cl3DLight;
            end
            else
            begin
              TDBEdit(Layout[i].LinkComp[1]).Field.ReadOnly:=Layout[i].Accesso = 'R';
              TDBEdit(Layout[i].LinkComp[1]).Color:=clWindow;
            end;
          end
          else if Layout[i].LinkComp[1] is TDBLookupComboBox then
          begin
            if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBLookupComboBox(Layout[i].LinkComp[1]).Field.FieldName,'S']),[srFromBeginning])
            or (StoricizzazioneInCorso and (A002FAnagrafeMW.selI500.Lookup('NOMECAMPO',TDBLookupComboBox(Layout[i].LinkComp[1]).Field.FieldName,'STORICIZZABILE') = 'N')) then
            begin
              TDBLookupComboBox(Layout[i].LinkComp[1]).Field.ReadOnly:=True;
              TDBLookupComboBox(Layout[i].LinkComp[1]).ReadOnly:=True;
              TDBLookupComboBox(Layout[i].LinkComp[1]).Color:=cl3DLight;
            end
            else
            begin
              TDBLookupComboBox(Layout[i].LinkComp[1]).Field.ReadOnly:=Layout[i].Accesso = 'R';
              TDBLookupComboBox(Layout[i].LinkComp[1]).ReadOnly:=Layout[i].Accesso = 'R';
              TDBLookupComboBox(Layout[i].LinkComp[1]).Color:=clWindow;
            end;
          end;
        end;
        if not (Layout[i].LinkComp[2] = nil) then
          if Layout[i].LinkComp[2] is TDBEdit then
          begin
            if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBEdit(Layout[i].LinkComp[2]).Field.FieldName,'S']),[srFromBeginning])
            or (StoricizzazioneInCorso and (A002FAnagrafeMW.selI500.Lookup('NOMECAMPO',TDBEdit(Layout[i].LinkComp[2]).Field.FieldName,'STORICIZZABILE') = 'N')) then
            begin
              TDBEdit(Layout[i].LinkComp[2]).Field.ReadOnly:=True;
              TDBEdit(Layout[i].LinkComp[2]).Color:=cl3DLight;
            end
            else
            begin
              TDBEdit(Layout[i].LinkComp[2]).Field.ReadOnly:=Layout[i].Accesso = 'R';
              TDBEdit(Layout[i].LinkComp[2]).Color:=clWindow;
            end;
          end;
      end;

  if EseguiRelazioni then
  begin
    //Scorrimento su selI030 ordinato per ORDINE
    A002FAnagrafeMW.selI030.First;
    while not A002FAnagrafeMW.selI030.Eof do
    begin
      //eseguo le relazioni solo se la procedura è richiamata a causa della variazione della data fine decorrenza o di un dato pilota in una catena di relazioni o se è volutamente richiamata per tutti
      if (Sender = nil) or (sNomeCampo = 'DATAFINE') or R180InConcat(A002FAnagrafeMW.selI030.FieldByName('COLONNA').AsString,CatenaRelazioni) then
      begin
        if A002FAnagrafeMW.selI030.FieldByName('TIPO').AsString = 'F' then
        begin
          RelFiltrate:=True;
          with A002FLayout do
            for i:=0 to High(Layout) do
              if (Layout[i].LinkComp[1] is TDBLookupComboBox) and
                 (TDBLookupComboBox(Layout[i].LinkComp[1]).Field.FieldName = A002FAnagrafeMW.selI030.FieldByName('COLONNA').AsString) then
              begin
                SqlRelazione:=A002FAnagrafeMW.CreaSQLRelazione((TOracleDataSet(TDBLookupComboBox(Layout[i].LinkComp[1]).ListSource.Dataset).VariableIndex('DATA') >= 0));
                if Trim(SqlRelazione) <> '' then
                begin
                  with TOracleDataSet(TDBLookupComboBox(Layout[i].LinkComp[1]).ListSource.Dataset) do
                    if Trim(SqlRelazione) <> Trim(Sql.Text) then
                    begin
                      Close;
                      SqlOriginale:=Sql.Text;
                      Sql.Text:=SqlRelazione;
                      try
                        if VariableIndex('DATA') >= 0 then
                          SetVariable('DATA',Q430.FieldByName('DATAFINE').AsDateTime);
                        Open;
                      except
                        Sql.Text:=SqlOriginale;
                        Open;
                      end;
                    end;
                end;
                Break;
              end;
        end
        else if ((A002FAnagrafeMW.selI030.FieldByName('TIPO').AsString = 'S') or (A002FAnagrafeMW.selI030.FieldByName('TIPO').AsString = 'L')) and
                 (Q430.State in [dsEdit,dsInsert]) and
                 (A002FAnagrafeMW.selI030.FieldByName('TABELLA').AsString = A002FAnagrafeMW.selI030.FieldByName('TAB_ORIGINE').AsString) then
          A002FAnagrafeMW.ImpostaValoreRelazione;
      end;
      A002FAnagrafeMW.selI030.Next;
    end;
  end;
  //selI030.Filtered:=False;
  D430.OnDataChange:=D430DataChange;
end;

procedure TA002FAnagrafeDtM1.QueryAnagrafeStorico;
{QVista contiene l'unione dei dati anagrafici base (Q030) con
i dati storici validi (T430)
Struttura Sql:
(Dati_anagrafici LEFT JOIN Dati_ComuneNasc.)
       INNER JOIN dati_storici contenuti nella vista V430_Storico)
  WHERE Inibizioni_Operatore }
begin
  with QVista do
    begin
    DisableControls;
    //Creo i campi persistenti se non ci sono ancora
    if CreazioneDataModule then
    begin
      C700MergeSelAnagrafe(QVista,False);
      C700MergeSettaPeriodo(QVista,A002FAnagrafeVista.DataLavoro,A002FAnagrafeVista.DataLavoro);
      QVista.SetVariable('ORDERBY',A002FAnagrafeVista.frmSelAnagrafe.GetC700SelAnagrafeOrderBy);
      QVista.Open;
      CreazioneDataModule:=False;
      QI010.Open;
      GetColonneStruttura(True);
      if AbilAnagra <> aaNone then
      begin
        CaricaTVAzienda(False);
        //Routine per rendere visibili i campi e ordinarli
        CaricaGriglia;
      end;
      QI010.Close;
    end;
    (*try
      Open;
    except
      raise Exception.Create('Non sono disponibili dipendenti con i parametri correnti!');
    end;*)
    QVista.FieldByName('PROGRESSIVO').Visible:=False;
    QVista.FieldByName('T430PROGRESSIVO').Visible:=False;
    QVista.FieldByName('T430DATADECORRENZA').Visible:=False;
    QVista.FieldByName('T430DATAFINE').Visible:=False;
    QVista.First;
    QVista.EnableControls;
    end;
    RegistraQVistaFields;
end;

procedure TA002FAnagrafeDtM1.RegistraQVistaFields;
var i:Integer;
begin
  SetLength(QVistaFields,QVista.Fields.Count);
  for i:=0 to QVista.Fields.Count - 1 do
  begin
    QVistaFields[i].FieldName:=QVista.Fields[i].FieldName;
    QVistaFields[i].DisplayLabel:=QVista.Fields[i].DisplayLabel;
    QVistaFields[i].DisplayWidth:=QVista.Fields[i].DisplayWidth;
    QVistaFields[i].Visible:=QVista.Fields[i].Visible;
    QVistaFields[i].Index:=QVista.Fields[i].Index;
  end;
end;

procedure TA002FAnagrafeDtM1.ApplicaQVistaFields;
var i:Integer;
begin
  for i:=0 to High(QVistaFields) do
  begin
    QVista.FieldByName(QVistaFields[i].FieldName).DisplayLabel:=QVistaFields[i].DisplayLabel;
    QVista.FieldByName(QVistaFields[i].FieldName).DisplayWidth:=QVistaFields[i].DisplayWidth;
    QVista.FieldByName(QVistaFields[i].FieldName).Visible:=QVistaFields[i].Visible;
    QVista.FieldByName(QVistaFields[i].FieldName).Index:=QVistaFields[i].Index;
  end;
end;

procedure TA002FAnagrafeDtM1.GetColonneStruttura(CreaCampi:Boolean);
var i:Integer;
begin
  Parametri.ColonneStruttura.Clear;
  Parametri.TipiStruttura.Clear;
  for i:=0 to QVista.FieldDefs.Count - 1 do
  begin
    //if CreaCampi then
    //  QVista.FieldDefs[i].CreateField(QVista);
    Parametri.ColonneStruttura.Add(Format('%s=%s',[VarToStr(QI010.Lookup('NOME_CAMPO',QVista.FieldDefs[i].Name,'NOME_LOGICO')),QVista.FieldDefs[i].Name]));
    Parametri.TipiStruttura.Add(IntToStr(Ord(QVista.FieldDefs[i].DataType)));
  end;
end;

procedure TA002FAnagrafeDtM1.CaricaTVAzienda(Completa:Boolean);
var Nodo:TTreeNode;
    S:String;
begin
  A002FAnagrafeVista.TVAzienda.Items.BeginUpdate;
  A002FAnagrafeVista.TVAzienda.Items.Clear;
  with QI010 do
  begin
    Open;
    First;
    while not Eof do
    begin
      if Completa or ((not FieldByName('RICERCA').IsNull) and (FieldByName('RICERCA').AsInteger >= 0)) then
      begin
        S:=FieldByName('NOME_CAMPO').AsString;
        if Copy(S,1,6) = 'T430D_' then
          S:=Copy(S,7,Length(S))
        else if Copy(S,1,4) = 'T430' then
          S:=Copy(S,5,Length(S));
        if (Copy(S,1,4) = 'P430') or (S = 'PROGRESSIVO') or (A002FAnagrafeMW.selT033_campoDecode.SearchRecord('CAMPODB',VarArrayOf([S]),[srFromBeginning])) then
        begin
          Nodo:=A002FAnagrafeVista.TVAzienda.Items.Add(nil,FieldByName('NOME_LOGICO').AsString);
          A002FAnagrafeVista.TVAzienda.Items.AddChild(Nodo,'Valori');
        end;
      end;
      Next;
    end;
    Close;
  end;
  A002FAnagrafeVista.TVAzienda.Items.EndUpdate;
end;

procedure TA002FAnagrafeDtM1.QVistaAfterScroll(DataSet: TDataSet);
begin
  Screen.Cursor:=crHourGlass;
  try
    A002FAnagrafeVista.StatusBar.Panels[1].Text:=Format('Anagr. %d/%d',[QVista.RecNo,QVista.RecordCount]);
    A002FAnagrafeGest.StatusBar.Panels[1].Text:=Format('Anagr. %d/%d',[QVista.RecNo,QVista.RecordCount]);
    A002FAnagrafeVista.StatusBar.Repaint;
    Relaziona(QVista.FieldByName('PROGRESSIVO').AsInteger,A002FAnagrafeVista.DataLavoro);
    GetDateDecorrenza;
    // abilita azione di accesso (readonly) ai login dipendente
    A002FAnagrafeGest.actLoginDipendente.Enabled:=A002FAnagrafeMW.EsistonoLoginWeb(QVista.FieldByName('PROGRESSIVO').AsInteger);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA002FAnagrafeDtM1.RinfrescaQueryDescrizioni(DataDec: TDateTime);
//Per i dati liberi storicizzati imposto la data e rieseguo la query
var
  i: Integer;
begin
  //Ciclo sui dati liberi considerando solo quelli storicizzati
  if DataDec <> A002FAnagrafeMW.selT220.GetVariable('Data') then
  begin
    for i:=1 to A002FAnagrafeVista.NumDatiLiberi do
    begin
      if DatiLiberi[i].Storico = 'S' then
      begin
        //Opero sulla query legata al dato libero storicizzato
        DatiLiberi[i].Query.Close;
        //Setto la data e rieseguo la query
        DatiLiberi[i].Query.SetVariable('Data',DataDec);
        DatiLiberi[i].Query.Open;
      end;
    end;
    with A002FAnagrafeMW do
    begin
      selT220.Close;
      selT220.SetVariable('Data',DataDec);
      selT220.Open;
      selT470.Close;
      selT470.SetVariable('Data',DataDec);
      selT470.Open;
    end;
  end;
end;

procedure TA002FAnagrafeDtM1.CaricaGriglia;
{Carica le Impostazioni della griglia}
var Nome:string;
begin
  //Carico la descrizione dei campi in I010
  with QI010 do
  begin
    Open;
    First;
    while not Eof do
    begin
      Nome:=FieldByName('NOME_CAMPO').AsString;
      if Copy(Nome,1,6) = 'T430D_' then
        Nome:=Copy(Nome,7,Length(Nome) - 6)
      else if Copy(Nome,1,4) = 'T430' then
        Nome:=Copy(Nome,5,Length(Nome) - 4);
      try
        QVista.FieldByName(FieldByName('NOME_CAMPO').AsString).DisplayLabel:=FieldByName('NOME_LOGICO').AsString;
        if A002FAnagrafeMW.selT033_campoDecode.SearchRecord('CAMPODB',VarArrayOf([Nome]),[srFromBeginning]) then
          QVista.FieldByName(FieldByName('NOME_CAMPO').AsString).Visible:=True
        else
          QVista.FieldByName(FieldByName('NOME_CAMPO').AsString).Visible:=False;
      except
      end;
      Next;
    end;
    Close;
  end;
  //Carico i dati registrati in T034_LayoutGriglia
  QVista.FieldByName('COGNOME').DisplayWidth:=30;
  QVista.FieldByName('NOME').DisplayWidth:=30;
  Q034.Close;
  Q034.SetVariable('Operatore',StrToInt(ProgOperDM));
  Q034.Open;
  try
    while not Q034.Eof do
    begin
      Nome:=Q034['NomeCampo'];
      if QVista.FindField(Nome) <> nil then
      begin
        QVista.FieldByName(Nome).Index:=Q034['Posizione'];
        if QVista.FieldByName(Nome).Visible then
          QVista.FieldByName(Nome).Visible:=Q034['Visible']='S';
        QVista.FieldByName(Nome).DisplayLabel:=Q034['Label'];
        QVista.FieldByName(Nome).DisplayWidth:=Min(Q034['Lunghezza'],1000); // limitato a 1000 caratteri
      end;
      Q034.Next;
    end
  except
  end;
  Q034.Close;
end;

procedure TA002FAnagrafeDtM1.ChiamaStorico(Prog:Integer; Data:TDateTime);
begin
  if Data >= StrToDate(DataFine) then
    exit;
  Relaziona(Prog,Data);
  if Q430.RecordCount = 0 then
    Relaziona(Prog,Data + 1);
  with A002FAnagrafeGest.cmbDateDecorrenza do
    ItemIndex:=Items.IndexOf(Q430DataDecorrenza.AsString);
end;

procedure TA002FAnagrafeDtM1.Relaziona(Prog:LongInt; DataLav:TDateTime);
{Aggiorna il collegamento tra QVista e Q030/Q430 tramite progressivo}
begin
  with Q030 do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    Open;
  end;
  with Q430 do
  begin
    Close;
    SetVariable('DataLav',DataLav);
    SetVariable('Progressivo',Prog);
    Open;
    //Alberto 16/03/2009: se ci sono relazioni filtrate, è necessario fare il refresh per le descrizioni dei dblookupcombobox
    if RelFiltrate then
      Refresh;
  end;
end;

procedure TA002FAnagrafeDtM1.GetDateDecorrenza;
begin
  with A002FAnagrafeMW do
  begin
    //selDateDecorrenza.SetVariable('Progressivo',QVista.FieldByName('PROGRESSIVO').AsInteger);
    selT430_Decorrenze.SetVariable('Progressivo',Q030.FieldByName('PROGRESSIVO').AsInteger);
    selT430_Decorrenze.Close;
    selT430_Decorrenze.Open;
    with A002FAnagrafeGest.cmbDateDecorrenza do
    begin
      Items.Clear;
      while not selT430_Decorrenze.Eof do
      begin
        Items.Add(selT430_Decorrenze.FieldByName('DataDecorrenza').AsString);
        selT430_Decorrenze.Next;
      end;
      ItemIndex:=Items.IndexOf(Q430DataDecorrenza.AsString);
      selT430_Decorrenze.Close;
    end;
  end;
end;

procedure TA002FAnagrafeDtM1.OrdinaAnagrafe(Campo:String);
{Aggiunge la clausola ORDER BY alla Query QVISTA}
begin
(*  OrderString:=' ORDER BY ' + Campo;
  with QVista do
  begin
    Close;
    SQL.Assign(ListSQL);
    if SelectString <> '' then
      SQL.Add(SelectString);
    SQL.Add(OrderString);
    Open;
  end;*)
end;

procedure TA002FAnagrafeDtM1.Q030AfterInsert(DataSet: TDataSet);
{Riflette l'operazione su Q430}
begin
  if Q030.State = dsInsert then
    Q430.Append
  else
  try
    Q430.Edit;
  except
    Q030.Cancel;
    raise;
  end;
end;

procedure TA002FAnagrafeDtM1.Q030BeforePost(DataSet: TDataSet);
{Controlla se le modifiche richiedono la data di decorrenza, controlla
se la data e' valida}
var Q030Modified,Q430Modified,Storicizza,StoriciModificati,AggiornaStoriciSucc,AggiornaStoriciPrec:Boolean;
    DataLog,ModStor,CF,Msg:String;
    A,M,G,i:Word;
    DI,PrimaDecorrenza,tmpDataDecorrenza,tmpDataFine:TDateTime;
    lstBadgeUsato: TStringList;
begin
  D430.OnDataChange:=nil;

  try
    OldTipoRapporto:=VarToStr(A002FAnagrafeMW.selT430OldValues.FieldByName('TipoRapporto').Value);
    if Q030.State = dsInsert then
      OldTipoRapporto:='';
    NewTipoRapporto:=Q430.FieldByName('TipoRapporto').AsString;
    if QueryPK1.EsisteChiave('T030_ANAGRAFICO',Q030.RowID,Q030.State,['MATRICOLA'],[Q030Matricola.AsString]) then
      raise Exception.Create('Matricola già esistente!');
    if (Parametri.ModPersonaleEsterno = 'N') and (Q030.FieldByName('TIPO_PERSONALE').AsString = 'E') then
      raise Exception.Create('Attenzione! L''utente utilizzato non è abilitato alla modifica di dipendenti Esterni!');
    Q030.FieldByName('MATRICOLA').AsString:=Trim(Q030.FieldByName('MATRICOLA').AsString);
    Q030.FieldByName('COGNOME').AsString:=Trim(Q030.FieldByName('COGNOME').AsString);
    if Q030.FieldByName('MATRICOLA').IsNull then
      raise Exception.Create(A000MSG_S031_ERR_MATR_NULLA);

    CF:=A002FAnagrafeMW.VerificaCFCambiato(Q030.FieldByName('D_CodCatastale').AsString);
    if CF <> '' then
      if MessageDlg(Format(A000MSG_A002_DLG_FMT_CF_CAMBIATO,[CF]),mtConfirmation,[mbYes,mbNo],0) = mrYes then
        Q030.FieldByName('CodFiscale').AsString:=CF;

    {--CONTROLLO CODFISC--}
    Msg:=A002FAnagrafeMW.VerificaCFUsato;
    if Msg <> '' then
      if R180MessageBox(Format(A000MSG_A002_DLG_FMT_CF_USATO,[Msg]),'DOMANDA') = mrNo then
        Abort;

    {if QueryPK1.EsisteChiave('T030_ANAGRAFICO',Q030.RowID,Q030.State,['MATRICOLA'],[Q030Matricola.AsString]) then
      raise Exception.Create('Cod Fiscale già esistente!');}
    {---------------------}
    Q030Modified:=Q030.Modified;
    Q430Modified:=Q430.Modified;
    IntegrazioneOut:=False;
    ModStor:='N';
    Inserimento:=DataSet.State = dsInsert;
    Storicizza:=Inserimento or
                (StoricizzazioneInCorso and Q430Modified);
               //(A002FAnagrafeGest.FlagSto.Checked and Q430Modified);
    AllineaCessazione:=False;
    AllineaRapportiUnificati:=False;
    A002FAnagrafeGest.PageControl1.SetFocus;
    StoriciModificati:=False;
    AggiornaStoriciSucc:=False;
    AggiornaStoriciPrec:=False;
    ApriCdcPerc:=False;
    try
      //DI:=StrToDateTime(A002FAnagrafeGest.Decorrenza.Text)
      DI:=Q430.FieldByName('DATADECORRENZA').AsDateTime;
    except
      raise Exception.Create('E'' richiesta una data di decorrenza valida per registrare i dati storici');
    end;
    if (DI < EncodeDate(1900,01,01)) or (DI > EncodeDate(3999,12,31)) then
      raise Exception.Create('La data di decorrenza deve essere compresa tra il 1900 ed il 3999.');
    if (not Inserimento) and (not Storicizza) and (DI <> A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value) then
    begin
      Msg:=A002FAnagrafeMW.VerificaCampiNonAbilitati(Q430.FieldByName('Progressivo').AsInteger,A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value);
      if Msg <> '' then
      begin
        Msg:=Format(A000MSG_A002_ERR_FMT_DECO_CAMPI_DISABIL,['spostamento decorrenza',Msg]);
        Raise Exception.Create(Msg);
      end;
    end;

    if (not Inserimento) and (Storicizza or (A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value <> StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0]))) then
      PrimaDecorrenza:=StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0])
    else
      PrimaDecorrenza:=Q430.FieldByName('DataDecorrenza').AsDateTime;
    if (not Q430.FieldByName('INIZIO').IsNull) and (Q430.FieldByName('INIZIO').AsDateTime <> A002FAnagrafeMW.selT430OldValues.FieldByName('INIZIO').Value) then
    begin
      if Q430.FieldByName('INIZIO').AsDateTime < PrimaDecorrenza then
        raise Exception.Create(Format(A000MSG_A002_ERR_FMT_INIZIO_ANTE,[Q430.FieldByName('INIZIO').AsString,DateToStr(PrimaDecorrenza)]));
    end;
    if not Inserimento then
      if Storicizza then
      begin //Controllo che la data di decorrenza sia compresa nel periodo storico corrente, con l'eccezione del primo periodo storico in cui è possibile storicizzare ad una data precedente
        if ((DI < A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value) or (DI > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value)) then
          if (PrimaDecorrenza < A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value) or (DI > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value) then
            raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_FUORI_PER,[DateToStr(DI)]));
      end
      else
      begin
        if A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value <> StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0]) then
        begin //Controllo che la data di decorrenza non sia successiva alla fine del periodo storico corrente
              //e non sia precedente al periodo storico precedente
          if ((DI <= StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[A002FAnagrafeGest.cmbDateDecorrenza.ItemIndex - 1])) or (DI > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value)) then
            raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_FUORI_PER,[DateToStr(DI)]));
        end
        else //Controllo che la prima decorrenza non sia successiva alla fine del periodo storico corrente
        begin
          if (DI > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value) then
            raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_PRIMO_PER,[DateToStr(DI)]));
          //Se è già stata impostata la data di inizio rapporto...
          if not Q430.FieldByName('INIZIO').IsNull then
          begin

            if A002FAnagrafeMW.CountAnagraficheStipendiali(Q030.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(1900,01,01),EncodeDate(3999,12,31)) > 0 then
            begin
              //Se il dipendente ha già almeno un'anagrafica stipendiale, controllo che la decorrenza non sia maggiore del 1° giorno del mese di inizio rapporto
              if DI > R180InizioMese(Q430.FieldByName('INIZIO').AsDateTime) then
                raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_PRIMO_STIP,[DateToStr(DI),DateToStr(R180InizioMese(Q430.FieldByName('INIZIO').AsDateTime))]));
            end
            else
            begin
              //Se il dipendente non ha alcuna anagrafica stipendiale, controllo che la decorrenza non sia maggiore dell'inizio rapporto
              if DI > Q430.FieldByName('INIZIO').AsDateTime then
                raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_PRIMA_ASSUNZ,[DateToStr(DI),DateToStr(Q430.FieldByName('INIZIO').AsDateTime)]));
            end;
          end;
          //Se sto posticipando la decorrenza...
          if A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value < DI then
          begin
            //...verifico che non esistano periodi storici stipendiali nel periodo di traslazione della decorrenza
            if A002FAnagrafeMW.CountAnagraficheStipendiali(Q030.FieldByName('PROGRESSIVO').AsInteger,A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value + 1,DI) > 0 then
              raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DEL_STIPENDIALI,[DateToStr(A002FAnagrafeMW.selP430_count.GetVariable('DATA_OLD')),DateToStr(A002FAnagrafeMW.selP430_Count.GetVariable('DATA_NEW'))]));
          end;
          //Aggiorno la minima data decorrenza stipendiale, in modo che la Allinea_Periodi_Storici non annulli la posticipazione
          A002FAnagrafeMW.AggiornaDecorrenzaStipendiale(DI);
        end;
      end;

    //Un campo non storicizzabile può essere modificato soltanto se sono stati attivati i flag Storici prec. (non obbligatorio sul primo storico) e Storici succ. (non obbligatorio sull'ultimo storico)
    //In inserimento non si controlla. In storicizzazione il componente dovrebbe essere disabilitato, ma per sicurezza si effettua il controllo.
    if (not Inserimento)
    and (    Storicizza
         or (Q430Modified and (   ((not A002FAnagrafeGest.chkStoriciPrec.Checked) and (A002FAnagrafeGest.cmbDateDecorrenza.ItemIndex <> 0))
                               or ((not A002FAnagrafeGest.chkStoriciSucc.Checked) and (A002FAnagrafeGest.cmbDateDecorrenza.ItemIndex <> (A002FAnagrafeGest.cmbDateDecorrenza.Items.Count - 1)))))) then
    begin
      Msg:=A002FAnagrafeMW.VerificaCampiNonStoricizzabili;
      if Msg <> '' then
      begin
        Msg:=Format(A000MSG_A002_ERR_FMT_CAMPI_NON_STORICIZ,[IfThen(Storicizza,'storicizzazione','modifica'),Msg]);
        Raise Exception.Create(Msg);
      end;
    end;

    if (not Inserimento) and (Storicizza or (Q430Modified and (Q430.FieldByName('DATAFINE').AsDateTime <> StrToDate(DataFine)))) and A002FAnagrafeGest.chkStoriciSucc.Checked then
      AggiornaStoriciSucc:=True;
    if (not Inserimento) and (Storicizza or (Q430Modified)) and A002FAnagrafeGest.chkStoriciPrec.Checked then
      AggiornaStoriciPrec:=True;

    //if (not Inserimento) and (Storicizza or (Q430Modified and (Q430DataFine.AsDateTime <> StrToDate(DataFine)))) then
    //if MessageDlg('Si desidera modificare anche i movimenti storici successivi ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    if Q430.FieldByName('INIZIO_IND_MAT').IsNull xor Q430.FieldByName('FINE_IND_MAT').IsNull then
      Raise Exception.Create(A000MSG_A002_ERR_MATERNITA_VALOR);
    if Q430.FieldByName('INIZIO_IND_MAT').AsDateTime > Q430.FieldByName('FINE_IND_MAT').AsDateTime then
      Raise Exception.Create(A000MSG_A002_ERR_DATE_MATERNITA);
    if ((A002FAnagrafeMW.selT430OldValues.FieldByName('INIZIO_IND_MAT').Value <> Q430.FieldByName('INIZIO_IND_MAT').Value) or
       (A002FAnagrafeMW.selT430OldValues.FieldByName('FINE_IND_MAT').Value <> Q430.FieldByName('FINE_IND_MAT').Value) or
       (A002FAnagrafeMW.selT430OldValues.FieldByName('INIZIO').Value <> Q430.FieldByName('INIZIO').Value) or
       (A002FAnagrafeMW.selT430OldValues.FieldByName('FINE').Value <> Q430.FieldByName('FINE').Value)) then
    begin
      if (Not Q430.FieldByName('INIZIO_IND_MAT').IsNull) and (Not Q430.FieldByName('FINE_IND_MAT').IsNull) then
      begin
        {Controllo che non avvengano intersezioni tra periodi d'indennità maternità}
        Msg:=A002FAnagrafeMW.VerificaIntersezionePeriodiIndMat;
        if Msg <> '' then
        begin
          Msg:=Format(A000MSG_A002_ERR_FMT_INT_MAT,[Msg]);
          Raise Exception.Create(Msg);
        end;

        {Controllo che non avvengano intersezioni tra peridi di rapporto e periodi di maturazione
         indennità maternità}
        Msg:=A002FAnagrafeMW.VerificaIntersezionePeriodiRappIndMat;
        if Msg <> '' then
        begin
          Msg:=Format(A000MSG_A002_ERR_FMT_INT_MAT_RAPP,[Msg]);
          Raise Exception.Create(Msg);
        end;
      end;

      A002FAnagrafeMW.AggiornaPeriodoIndMat;
    end;

    if (not Q430.FieldByName('FINE').IsNull) and (Q430.FieldByName('INIZIO').AsDateTime > Q430.FieldByName('FINE').AsDateTime) then
      if MessageDlg(A000MSG_A002_DLG_DATA_ASSUNZ_POST,mtConfirmation,[mbYes,mbNo],0) <> mrYes then
        Abort;
    if (not Inserimento) and (Q430Modified and (Q430.FieldByName('DATAFINE').AsDateTime <> StrToDate(DataFine))) and (not AggiornaStoriciSucc) then
      if MessageDlg('Esistono delle storicizzazioni successive ma le modifiche verranno applicate solo sulla decorrenza corrente. Confermare?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
        Abort;
    if (not Inserimento) and (not Storicizza) and (Q430.FieldByName('DataDecorrenza').Value <> A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value) then
      if MessageDlg(A000MSG_A002_DLG_MODIFICA_DECOR,mtConfirmation,[mbYes,mbNo],0) <> mrYes then
        Abort;
    //Controllo che il badge assegnato non sia già utilizzato da altri dipendenti
    if A002FAnagrafeGest.cmbDateDecorrenza.Items.Count = 0 then
      tmpDataDecorrenza:=DATE_NULL
    else
      tmpDataDecorrenza:=StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0]);
    lstBadgeUsato:=A002FAnagrafeMW.VerificaBadge(Inserimento,Storicizza,tmpDataDecorrenza,AggiornaStoriciPrec,AggiornaStoriciSucc);
    if lstBadgeUsato <> nil then
    begin
      //Ho trovato altre occorrenze di questo badge
      A002FBadgeMsg:=TA002FBadgeMsg.Create(nil);
      try
        A002FBadgeMsg.Caption:='<A002> Badge già esistente';
        A002FBadgeMsg.pnlData.Visible:=False;
        with A002FBadgeMsg.Memo1 do
        begin
          //raise Exception.Create(Format(A000MSG_A002_ERR_FMT_BADGE_USATO,[Mex]));
          Lines.Add('Attenzione!');
          Lines.Add('Il badge risulta essere assegnato a:');
          for I:=0 to lstBadgeUsato.Count - 1 do
            Lines.Add(lstBadgeUsato[i]);
        end;
        A002FBadgeMsg.ShowModal;
        Abort;
      finally
        A002FBadgeMsg.Release;
        FreeAndNil(lstBadgeUsato);
      end;
    end;
    //Verifica non sia Badge servizio
    if not A002FAnagrafeMW.VerificaBadgeServizio then
      raise Exception.Create(A000MSG_A002_ERR_BADGE_SERVIZIO);

    (*
    //Filtri sul dizionario
    A002FAnagrafeMW.FiltroDizionarioBeforePost('CALENDARIO','CALENDARI','Calendario');
    A002FAnagrafeMW.FiltroDizionarioBeforePost('IPRESENZA','PROFILI INDENNITA','Profilo Indennità');
    A002FAnagrafeMW.FiltroDizionarioBeforePost('PORARIO','PROFILI ORARIO','Profilo Orario');
    A002FAnagrafeMW.FiltroDizionarioBeforePost('PASSENZE','PROFILI ASSENZA','Profilo Assenze');
    *)

    //Modifica senza storicizzazione
    if not Storicizza then
    begin
      begin
        if AggiornaStoriciSucc or AggiornaStoriciPrec then
        begin
          StoriciModificati:=True;
          if AggiornaStoriciPrec then
            AggiornamentoStoriciPrecSucc(Q430.FieldByName('DataDecorrenza').AsDateTime,'P');
          if AggiornaStoriciSucc then
            AggiornamentoStoriciPrecSucc(Q430.FieldByName('DataFine').AsDateTime,'S');
          RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
          RegistraLog.RegistraOperazione;
          RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
        end;
      end;
      if not StoriciModificati then
      begin
        DataLog:=FormatDateTime('dd/mm/yyyy',Q430DataFine.AsDateTime);
        if DataLog = DataFine then
          DataLog:='Corrente';
        RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
        RegistraLog.RegistraOperazione;
        RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
      end;
      A002FAnagrafeMW.AggiornaFine('N');
      A002FAnagrafeMW.AggiornaRapportiUnificati('N');
      AggiornaCdCPercentualizzati;

      Q430.Post;
      exit;
    end;
    try
      //Decor:=StrToDateTime(A002FAnagrafeGest.Decorrenza.Text);
      Decor:=Q430.FieldByName('DATADECORRENZA').AsDateTime;
    except
      raise Exception.Create('E'' richiesta una data di decorrenza valida per registrare i dati storici');
    end;
    if (Decor < EncodeDate(1900,01,01)) or (Decor > EncodeDate(3999,12,31)) then
      raise Exception.Create('La data di decorrenza deve essere compresa tra il 1900 ed il 3999.');

    //Inserimento di un nuovo dipendente
    if Inserimento then
    begin
      with Q430 do
      begin
        //Incremento il progressivo interno

        Q030['Progressivo']:=A002FAnagrafeMw.NuovoProgressivo;
        if FieldByName('Inizio').IsNull then
          //Se non ho la data di assunzione uso la data di decorrenza
        begin
          //S:='Poichè non è specificata la data di assunzione, i dati storici decorreranno dalla data decorrenza specificata: ' +
          //   A002FAnagrafeGest.Decorrenza.Text + #13 + 'Confermare l''inserimento ?';
          //Se non confermo, annullo l'operazione
          //if MessageDlg(S,mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          //  Abort;
          FieldByName('DataDecorrenza').AsDateTime:=Decor;
        end
        else
          //Setto data decorrenza = al giorno di assunzione
        begin
          DecodeDate(FieldByName('Inizio').AsDateTime,A,M,G);
          //Alberto 05/07/2006: la prima data di decorrenza non è più vincolata al primo del mese
          FieldByName('DataDecorrenza').AsDateTime:=EncodeDate(A,M,G);
          //FieldByName('DataDecorrenza').AsDateTime:=EncodeDate(A,M,1);
        end;
        FieldByName('DataFine').AsDateTime:=StrToDateTime(DataFine);
        FieldByName('Progressivo').AsInteger:=Q030.FieldByName('Progressivo').AsInteger;
        Post;
        RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
        RegistraLog.RegistraOperazione;
        RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
      end;
    end
    else
      //Modifica con storicizzazione
      with Q430B do
      begin
        //Aggiorno i dati storici solo di questo dipendente
        Filtered:=False;
        Close;
        SetVariable('Prog',Q030.FieldByName('Progressivo').AsInteger);
        Open;
        if Locate('DataDecorrenza',Decor,[]) then
          raise Exception.Create('Esiste già una situazione storica con questa data di decorrenza!');
        //(*//Alberto 30/01/2017: la DataFine viene già riallineata in AllineaDataFine, e questa assegnazione può invece causare un "record has been changed..."
          //Se lo si scommenta, lasciare l'ApplyUpdates successivo
        TuttoStorico:=tsPrima;
        Filtered:=True;
        if RecordCount > 0 then
        begin
          //Se si sovrappone a una storicizzazione già esistente
          //aggiorno la data fine di quest'ultima
          First;
          Edit;
          FieldByName('DataFine').AsDateTime:=Decor - 1;
          Post;
          //Alberto 01/05/2017: Correzione alternativa: si puà lasciare questo blocco ma è necessario eseguire subito l'update.
          SessioneOracle.ApplyUpdates([Q430B],False);
          Q430B.CancelUpdates;
        end;
        //*)
        //Se ci sono delle storicizzazioni posteriori imposto la data
        //di fine alla data di decorrenza successiva - 1
        TuttoStorico:=tsDopo;
        Filtered:=False;
        Filtered:=True;
        Q430.FieldByName('DataDecorrenza').AsDateTime:=Decor;
        tmpDataFine:=Q430.FieldByName('DataFine').AsDateTime;
        if RecordCount > 0 then
        begin
          First;
          Q430.FieldByName('DataFine').AsDateTime:=FieldByName('DataDecorrenza').AsDateTime - 1;
        end
        else
          Q430.FieldByName('DataFine').AsDateTime:=StrToDateTime(DataFine);
        if tmpDataFine <> Q430.FieldByName('DataFine').AsDateTime then
        begin
          D430DataChange(nil,nil); //Forzo datachange per riallineare le relazioni al nuovo valore di DATAFINE
          D430.OnDataChange:=nil;  //Annullo di nuovo perchè viene riassegnato da RefreshFiltro
        end;
        Filtered:=False;
        if Q430Modified then
          if AggiornaStoriciSucc or AggiornaStoriciPrec then
          begin
            StoriciModificati:=True;
            if AggiornaStoriciSucc then
              AggiornamentoStoriciPrecSucc(Q430.FieldByName('DataFine').AsDateTime,'S');
            if AggiornaStoriciPrec then
              AggiornamentoStoriciPrecSucc(Q430.FieldByName('DataDecorrenza').AsDateTime,'P');
            RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
            RegistraLog.RegistraOperazione;
            RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
          end;
        if not StoriciModificati then
        begin
          DataLog:=FormatDateTime('dd/mm/yyyy',Q430DataFine.AsDateTime);
          if DataLog = DataFine then
            DataLog:='Corrente';
          RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
          RegistraLog.RegistraOperazione;
          RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
        end;
        if (Q430.State = dsEdit) and (Q430Fine.AsDateTime <> OldFine) then
          with A002FAnagrafeMW.updFine do
          begin
            ClearVariables;
            SetVariable('PROGRESSIVO',Q430Progressivo.AsInteger);
            SetVariable('RIGAID',Q430.RowID);
            SetVariable('STORICIZZA','S');
            SetVariable('INIZIO',Q430Inizio.AsDateTime);
            if not Q430Fine.IsNull then
              SetVariable('FINE',Q430Fine.AsDateTime);
            AllineaCessazione:=True;
            //in questo caso (storicizzazione), l'esecuzione di updFine avviene nell'AfterPost
          end;
        if (Q430.State = dsEdit) and (Q430.FieldByName('RAPPORTI_UNIFICATI').AsString <> OldRapportiUnificati) then
          with A002FAnagrafeMW.updRapportiUnificati do
          begin
            ClearVariables;
            SetVariable('PROGRESSIVO',Q430Progressivo.AsInteger);
            SetVariable('RIGAID',Q430.RowID);
            SetVariable('STORICIZZA','S');
            SetVariable('INIZIO',Q430Inizio.AsDateTime);
            SetVariable('RAPPORTI_UNIFICATI',Q430.FieldByName('RAPPORTI_UNIFICATI').AsString);
            AllineaRapportiUnificati:=True;
            //in questo caso (storicizzazione), l'esecuzione di updRapportiUnificati avviene nell'AfterPost
          end;
        AggiornaCdCPercentualizzati;
        Append;
        for i:=0 to FieldCount - 1 do
          if (UpperCase(Fields[i].FieldName) = 'DATADECORRENZA') or
             (UpperCase(Fields[i].FieldName) = 'DATAFINE') then
            Fields[i].Value:=Q430.FieldByName(Fields[i].FieldName).Value
          else
            Fields[i].Value:=A002FAnagrafeMW.selT430OldValues.FieldByName(Fields[i].FieldName).Value;
        Post;
        //Salvo le modifiche storicizzate per rieseguirle dopo, in modo da far scattare il trigger per ADS (DEPOSITO_VARIAZIONI_SETTORE)
        AggiornamentoStoriciPrecSucc(Q430B.FieldByName('DataDecorrenza').AsDateTime,'=');
        ModificaStoricizzata:=OperSQL.SQL.Text;
        OperSQL.SQL.Clear;
        Q430.Cancel;
      end;
  finally
    D430.OnDataChange:=D430DataChange;
  end;
end;

procedure TA002FAnagrafeDtM1.AggiornamentoStoriciPrecSucc(Data:TDateTime; Tipo:String);
var i:Integer;
    U,V:String;
    IIM,FIM:Boolean;
begin
  U:='';
  IIM:=False;
  FIM:=False;
  for i:=0 to Q430.FieldDefs.Count - 1 do
  begin
    if Q430.FindField(Q430.FieldDefs[i].Name) = nil then
      Continue;
    if (UpperCase(Q430.FieldDefs[i].Name) = 'DATADECORRENZA') or (UpperCase(Q430.FieldDefs[i].Name) = 'DATAFINE') then Continue;
    if Copy(UpperCase(Q430.FieldDefs[i].Name),1,10) = 'ABPRESENZA' then
      if Copy(UpperCase(Q430.FieldDefs[i].Name),11,1) <> '1' then Continue;
    if Copy(UpperCase(Q430.FieldDefs[i].Name),1,9) = 'ABCAUSALE' then
      if Copy(UpperCase(Q430.FieldDefs[i].Name),10,1) <> '1' then Continue;
    if (Q430.FieldByName(Q430.FieldDefs[i].Name).Value <> A002FAnagrafeMW.selT430OldValues.FieldByName(Q430.FieldDefs[i].Name).Value) then
    begin
      if U <> '' then U:=U + ',';
      if Q430.FieldDefs[i].DataType = ftDateTime then
      begin
        if Q430.FieldByName(Q430.FieldDefs[i].Name).IsNull then
          V:='NULL'
        else
          V:=FormatDateTime('dd/mm/yyyy',Q430.FieldByName(Q430.FieldDefs[i].Name).AsDateTime);
      end
      else
        V:=Q430.FieldByName(Q430.FieldDefs[i].Name).AsString;
      if not((Q430.FieldDefs[i].DataType = ftDateTime) and (Q430.FieldByName(Q430.FieldDefs[i].Name).IsNull)) then
        V:='''' + AggiungiApice(V) + '''';
      U:=U + Q430.FieldDefs[i].Name + '=' + V;
      if Q430.FieldDefs[i].Name = 'INIZIO_IND_MAT' then
        IIM:=True;
      if Q430.FieldDefs[i].Name = 'FINE_IND_MAT' then
        FIM:=True;
    end;
  end;
  if U = '' then exit;
  if (IIM and not FIM) or (not IIM and FIM) then
  begin
    if Q430.FieldByName(IfThen(IIM,'FINE_IND_MAT','INIZIO_IND_MAT')).IsNull then
      V:='NULL'
    else
      V:='''' + FormatDateTime('dd/mm/yyyy',Q430.FieldByName(IfThen(IIM,'FINE_IND_MAT','INIZIO_IND_MAT')).AsDateTime) + '''';
    U:=U + IfThen(IIM,',FINE_IND_MAT',',INIZIO_IND_MAT') + ' = ' + V;
  end;
  with OperSQL do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE T430_Storico SET');
    SQL.Add(U);
    if Tipo = 'S' then
      SQL.Add(Format('WHERE PROGRESSIVO = %s AND DATADECORRENZA > ''%s''',[Q430.FieldByName('Progressivo').AsString,FormatDateTime('dd/mm/yyyy',Data)]))
    else if Tipo = 'P' then
      SQL.Add(Format('WHERE PROGRESSIVO = %s AND DATADECORRENZA < ''%s''',[Q430.FieldByName('Progressivo').AsString,FormatDateTime('dd/mm/yyyy',Data)]))
    else if Tipo = '=' then
      SQL.Add(Format('WHERE PROGRESSIVO = %s AND DATADECORRENZA = ''%s''',[Q430.FieldByName('Progressivo').AsString,FormatDateTime('dd/mm/yyyy',Data)]));
    if Tipo <> '=' then
      Execute;
  end;
end;

procedure TA002FAnagrafeDtM1.Q030AfterPost(DataSet: TDataSet);
{Applico la cache di modifica}
var D,Istante:TDateTime;
  Inserimento:Boolean;
  TR,sTmp:String;
begin
  try
    D430.OnDataChange:=nil;
    try
      if Q430B.Active and Q430B.UpdatesPending then
        D:=Q430B.FieldByName('DATADECORRENZA').AsDateTime
      else
        D:=Q430DataDecorrenza.AsDateTime;
      Inserimento:=Q030.UpdateStatus = usInserted;
      SessioneOracle.ApplyUpdates([Q030,Q430],True);
      if Q430B.Active and Q430B.UpdatesPending then
      begin
        Istante:=Now;
        A002FAnagrafeMW.NoTrigger(Istante,'S');
        //Inserisce la nuova decorrenza ma ancora con i vecchi valori
        SessioneOracle.ApplyUpdates([Q430B],False);
        Q430B.CancelUpdates;
        A002FAnagrafeMW.NoTrigger(Istante,'N');
        //Applica le modifiche storicizzate sulla nuova decorrenza
        if ModificaStoricizzata <> '' then
        begin
          OperSQL.SQL.Text:=ModificaStoricizzata;
          OperSQL.Execute;
        end;
      end;
      AllineaDataFine;
      if AllineaCessazione then
      begin
        A002FAnagrafeMW.updFine.Execute;
        AllineaCessazione:=False;
      end;
      if AllineaRapportiUnificati then
      begin
        A002FAnagrafeMW.updRapportiUnificati.Execute;
        AllineaRapportiUnificati:=False;
      end;

      A002FAnagrafeMW.UpdT430Mat.SetVariable('PROGRESSIVO',Q030.FieldByName('PROGRESSIVO').AsInteger);
      A002FAnagrafeMW.UpdT430Mat.Execute;

      if not A002FAnagrafeMW.AggiornaPeriodiStorici  then
        R180MessageBox(A000MSG_A002_ERR_DIP_IN_USO ,ERRORE);

      RegistraLog.RegistraOperazione;
    finally
      SessioneOracle.Commit;
    end;

    GetDateDecorrenza;
    if (OldTipoRapporto <> '')
    and (VarToStr(A002FAnagrafeMW.selT450.Lookup('CODICE',OldTipoRapporto,'TIPO')) = 'R')
    and (VarToStr(A002FAnagrafeMW.selT450.Lookup('CODICE',NewTipoRapporto,'TIPO')) <> 'R') then
    begin
      TR:=VarToStr(A002FAnagrafeMW.selT450.Lookup('CODICE',NewTipoRapporto,'TIPO'));
      ShowMessage(Format(A000MSG_A002_ERR_FMT_CAMBIO_RAPP,[IfThen(TR = 'S','Supplente',IfThen(TR = 'I','Incaricato',IfThen(TR = 'P','Prova',IfThen(TR = 'A','Altro','nessuno'))))]));
    end;
    if not A002FAnagrafeMW.VerificaInizioRapportoInterseca(sTmp) then
        ShowMessage(Format(A000MSG_A002_ERR_FMT_RAPP_INTERSECA,[sTmp]));

    if not A002FAnagrafeMW.VerificaPeriodiInvertiti(sTmp) then
        ShowMessage(Format(A000MSG_A002_ERR_FMT_PERIODI_INV,[sTmp]));

    if not A002FAnagrafeMW.VerificaDatePeriodi(sTmp) then
        ShowMessage(Format(A000MSG_A002_ERR_FMT_DATE_INCONGR,[sTmp]));

    if not A002FAnagrafeMW.VerificaCedAntePrimoStoricoStip then
        ShowMessage(A000MSG_P430_ERR_CED_ANTE_PRIMO_STORICO);

  finally
    D430.OnDataChange:=D430DataChange;
  end;

  ChiamaStorico(Q030Progressivo.AsInteger, D);
  if Inserimento then
    A002FAnagrafeVistaPadre.ResettaTVAzienda;

  //Apertura maschera dei centri di costo percentualizzati
  if ApriCdcPerc then
  begin
    ApriCdcPerc:=False;
    A002FAnagrafeVistaPadre.actCdcPercentExecute(A002FAnagrafeVistaPadre.actCdcPercent);
  end;
end;

procedure TA002FAnagrafeDtM1.AllineaDataFine;
var NomeTab,Chiave:String;
begin
  NomeTab:='T430_STORICO';
  Chiave:='PROGRESSIVO = t.PROGRESSIVO';
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add('begin');
    SQL.Add('  update T430_STORICO t set');
    SQL.Add('    DATAFINE = (select min(DATADECORRENZA) - 1 from T430_STORICO where');
    SQL.Add('                      PROGRESSIVO = t.PROGRESSIVO and');
    SQL.Add('                       DATADECORRENZA > t.DATADECORRENZA)');
    SQL.Add('  where PROGRESSIVO = ' + Q030.FieldByName('PROGRESSIVO').AsString + ' and');
    SQL.Add('    DATADECORRENZA < (select max(DATADECORRENZA) from T430_STORICO');
      SQL.Add('                  where PROGRESSIVO = t.PROGRESSIVO');
    SQL.Add('                  );');
    SQL.Add('  update T430_STORICO t set');
    SQL.Add('    DATAFINE = TO_DATE(''31123999'',''DDMMYYYY'')');
    SQL.Add('  where PROGRESSIVO = ' + Q030.FieldByName('PROGRESSIVO').AsString + ' and');
    SQL.Add('    DATADECORRENZA = (select max(DATADECORRENZA) from T430_STORICO');
    SQL.Add('                  where PROGRESSIVO = t.PROGRESSIVO');
    SQL.Add('                  );');
    SQL.Add('end;');
    try
      Execute;
      SessioneOracle.Commit;
    except
    end;
  finally
    Free;
  end;
end;

procedure TA002FAnagrafeDtM1.Q030AfterCancel(DataSet: TDataSet);
{Annulla le operazioni anche su T430 e reimposta i controlli sulla
modalita' scorrimento}
begin
  Q430.Cancel;
  //SessioneOracle.CancelUpdates([Q030]);
  Q030.CancelUpdates;
  Q430.CancelUpdates;
  //Serve per liberare il lock creato da Q030 + Q430
  SessioneOracle.Rollback;
end;

procedure TA002FAnagrafeDtM1.Q030AfterDelete(DataSet: TDataSet);
{Applico la cache di cancellazione}
begin
  SessioneOracle.ApplyUpdates([Q030],True);
  SessioneOracle.Commit;
end;

procedure TA002FAnagrafeDtM1.Q430BeforeEdit(DataSet: TDataSet);
begin
  A002FAnagrafeMW.selI030.Refresh;
  A002FAnagrafeMW.selI035.Refresh;
end;

procedure TA002FAnagrafeDtM1.Q430BeforeInsert(DataSet: TDataSet);
begin
  A002FAnagrafeMW.selI030.Refresh;
  A002FAnagrafeMW.selI035.Refresh;
  EseguiRelazioni:=False;
  Q430.DisableControls;
end;

procedure TA002FAnagrafeDtM1.Q430BFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
{Filtra i dati storici: tsTutto visualizza tutti i dati del dipendente
                        tsPrima visualizza la storia con una certa data compresa fra data inizio e data fine
                        tsDopo visualizza la storia dopo una certa data}
begin
  case TuttoStorico of
    tsPrima:Accept:=(Q430B.FieldByName('DataDecorrenza').AsDateTime < Decor) and
                    (Q430B.FieldByName('DataFine').AsDateTime >= Decor);
    tsDopo: Accept:=Q430B.FieldByName('DataDecorrenza').AsDateTime > Decor;
    tsTutto:Accept:=True;
  end;
end;

procedure TA002FAnagrafeDtM1.Q430AfterFetchRecord(Sender: TOracleDataSet;
  FilterAccept: Boolean; var Action: TAfterFetchRecordAction);
//Per i dati liberi storicizzati imposto la data e rieseguo la query
begin
  //RinfrescaQueryDescrizioni(Q430.FieldByName('DATADECORRENZA').NewValue);
  RinfrescaQueryDescrizioni(Q430.FieldByName('DATAFINE').NewValue);
  //RefreshFiltro(nil);
end;

procedure TA002FAnagrafeDtM1.Q430AfterInsert(DataSet: TDataSet);
begin
  EseguiRelazioni:=True;
  Q430.EnableControls;
end;

procedure TA002FAnagrafeDtM1.Q430AfterOpen(DataSet: TDataSet);
begin
  A002FAnagrafeMW.selT430OldValues.CreaStruttura;
end;

procedure TA002FAnagrafeDtM1.Q430AfterScroll(DataSet: TDataSet);
begin
  A002FAnagrafeMW.selT430OldValues.Aggiorna;
end;

procedure TA002FAnagrafeDtM1.T430DataFineGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
{Non visualizza la data finale se il dato e' corrente (data = 31/12/9999)}
begin
  Text:=FormatDateTime('dd/mm/yyyy',Sender.AsDateTime);
  if Sender.AsDateTime = 0 then Text:='';
  if Text = DataFine then Text:='Corrente';
end;

procedure TA002FAnagrafeDtM1.D030StateChange(Sender: TObject);
{Imposta lo stato dei bottoni in risposta al cambiamento
di stato di Q030_Anagrafe}
var Browse:Boolean;
begin
  Browse:=not (Q030.State in [dsInsert, dsEdit]);
  with A002FAnagrafeGest do
  begin
    Chiudi1.Enabled:=Browse;
    actRicerca.Enabled:=Browse;
    actPrimo.Enabled:=Browse;
    actPrecedente.Enabled:=Browse;
    actSuccessivo.Enabled:=Browse;
    actUltimo.Enabled:=Browse;
    actInserisci.Enabled:=Browse and (Parametri.InserimentoMatricole = 'S') and (AbilAnagra = aaReadWrite);
    actModifica.Enabled:=Browse and (AbilAnagra = aaReadWrite);
    actCancella.Enabled:=Browse and (AbilAnagra = aaReadWrite) and (Parametri.EliminaStorici = 'S');
    actConferma.Enabled:=not Browse;
    actAnnulla.Enabled:=not Browse;
    actGomma.Enabled:=not Browse;
    //Panel3.Visible:=not Browse;
    actStoricoPrecedente.Enabled:=Browse;
    actStoricoSuccessivo.Enabled:=Browse;
    cmbDateDecorrenza.Enabled:=Browse;
    try
      btnStoricizza.Enabled:=(AbilAnagra = aaReadWrite) and (Parametri.Storicizzazione = 'S') and Browse and Q430.Active and (Q430.RecordCount > 0);
    except
      btnStoricizza.Enabled:=False;
    end;
    if Browse then
      StoricizzazioneInCorso:=False;
    chkStoriciPrec.Enabled:=Q030.State = dsEdit;
    chkStoriciSucc.Enabled:=Q030.State = dsEdit;
    dedtDecorrenza.ReadOnly:=Browse or ((Q030.State = dsEdit) and not StoricizzazioneInCorso and (Parametri.ModificaDecorrenza = 'N'));
    dedtDecorrenza.Color:=IfThen(dedtDecorrenza.ReadOnly and not Browse,cl3DLight,clWindow);
    chkStoriciPrec.Checked:=False;
    chkStoriciSucc.Checked:=False;
  end;
end;

procedure TA002FAnagrafeDtM1.Q030CalcFields(DataSet: TDataSet);
begin
  //Costruisco NomeCognome
  Q030.FieldByName('NomeCognome').AsString:=Q030.FieldByName('Nome').AsString + ' ' + Q030.FieldByName('Cognome').AsString;
  //Costruisco I060EMail
  Q030.FieldByName('I060EMail').AsString:=A002FAnagrafeMW.FormattaEMail(Q030.FieldByName('Matricola').AsString,'EMAIL');
  //Costruisco I060EMailPEC
  Q030.FieldByName('I060EMailPEC').AsString:=A002FAnagrafeMW.FormattaEMail(Q030.FieldByName('Matricola').AsString,'EMAIL_PEC');
  // cellulare (I060)
  Q030.FieldByName('I060Cellulare').AsString:=A002FAnagrafeMW.GetDatoI060(Q030.FieldByName('Matricola').AsString,'CELLULARE');
  // cellulare personale (I060)
  Q030.FieldByName('I060CellularePersonale').AsString:=A002FAnagrafeMW.GetDatoI060(Q030.FieldByName('Matricola').AsString,'CELLULARE_PERSONALE');
  // email personale (I060)
  Q030.FieldByName('I060EMailPersonale').AsString:=A002FAnagrafeMW.FormattaEMail(Q030.FieldByName('Matricola').AsString,'EMAIL_PERSONALE');
end;

procedure TA002FAnagrafeDtM1.Q430StringField27Validate(Sender: TField);
{Controllo che i minuti siano minori di 60}
begin
  {Minuti:=StrToInt(Copy(Sender.AsString,4,2));
  if Minuti > 59 then
    Raise Exception.Create('I minuti devono essere minori di 60!');}
  OreMinutiValidate(Sender.AsString);
end;

procedure TA002FAnagrafeDtM1.CercaAnagrafe;
{Crea la form di ricerca e si posiziona sul record}
var i:Integer;
    ElencoCampi:String;
    Valori,Campi:TStringList;
    Pippo:Variant;
begin
  Valori:=TStringList.Create;
  Campi:=TStringList.Create;
  ElencoCampi:='';
  C001FRicerca:=TC001FRicerca.Create(Application);
  with C001FRicerca,A002FAnagrafeDtm1.QVista do
    try
      chkFiltro.Visible:=False;
      Grid.RowCount:=FieldCount + 1;
      for i:=0 to FieldCount - 1 do
        if not((Fields[i].Calculated) or (Fields[i].Lookup)) then
        begin
          Campi.Add(Fields[i].FieldName);
          Grid.Cells[0,i+1]:=Fields[i].DisplayLabel;
        end;
      Grid.RowCount:=Campi.Count + 1;
      if ShowModal = mrOk then
      begin
        for i:=1 to Grid.RowCount - 1 do
          if Trim(Grid.Cells[1,i]) <> '' then
          begin
            ElencoCampi:=ElencoCampi + ';' + Campi[i-1];
            Valori.Add(Trim(Grid.Cells[1,i]));
          end;
        if Valori.Count > 0 then
        begin
          Pippo:=VarArrayCreate([0,Valori.Count - 1],VarVariant);
          for i:=0 to Valori.Count - 1 do
            Pippo[i]:=Valori[i];
          if Valori.Count > 1 then
            Locate(Copy(ElencoCampi,2,1000),Pippo,[loCaseInsensitive, loPartialKey])
          else
            Locate(Copy(ElencoCampi,2,1000),Valori[0],[loCaseInsensitive, loPartialKey])
          end;
        end;
    finally
      Release;
    end;
end;

procedure TA002FAnagrafeDtM1.ActiveDatiLiberi(Active:Boolean);
{Attivo/Disattivo le query dei dati liberi}
var i:Word;
begin
  for i:=1 to A002FAnagrafeVista.NumDatiLiberi do
    if DatiLiberi[i].Query <> nil then
      DatiLiberi[i].Query.Active:=Active;
end;

procedure TA002FAnagrafeDtM1.A002FAnagrafeDtM1Destroy(Sender: TObject);
{Tolgo l'occupazione all'operatore}
begin
  FreeAndNil(A002FAnagrafeMW);

  (*if IntegrazioneFTP and (I002FModifOut <> nil) then
    FreeAndNil(I002FModifOut);*)
  with OperSQL do
    begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE MONDOEDP.I070_UTENTI SET OCCUPATO = ''N'' WHERE PROGRESSIVO = ' + ProgOperDM);
    try
      Execute;
    except
    end;
    end;
  with selT432 do
  try
    R180SetVariable(selT432,'UTENTE',Parametri.Operatore);
    Open;
    First;
    if Parametri.DataLavoro <> Date then
    begin
      Edit;
      FieldByName('UTENTE').AsString:=Parametri.Operatore;
      FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
      Post;
    end
    else if not Eof then
      Delete;
    Close;
  except
  end;
  RegistraLog.SettaProprieta('A','','A002',nil,True);
  RegistraLog.InserisciDato('APPLICATIVO','',UpperCase(ExtractFileName(Application.ExeName)));
  RegistraLog.InserisciDato('OPERATORE','',Parametri.Operatore);
  RegistraLog.InserisciDato('TIPO','','USCITA');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  try SessioneOracle.Commit; except end;
  ListSQL.Free;
  ListaAssenze.Free;
  ListaPresenze.Free;
  QI010.Free;
  DistruggiDatiLiberi;
  SetLength(NomiTabelle,0);
  SessioneOracle.LogOff;
end;

procedure TA002FAnagrafeDtM1.Q010AfterOpen(DataSet: TDataSet);
begin
  DataSet.Fields[0].DisplayWidth:=Trunc(DataSet.Fields[0].Size * 1.5) + 1;
end;

procedure TA002FAnagrafeDtM1.Q030BeforeEdit(DataSet: TDataSet);
begin
  if (Parametri.ModPersonaleEsterno = 'N') and (Q030.FieldByName('TIPO_PERSONALE').AsString = 'E') then
    raise Exception.Create('Attenzione! L''utente utilizzato non è abilitato alla modifica di dipendenti Esterni!');
  OldInizio:=Q430Inizio.AsDateTime;
  OldFine:=Q430Fine.AsDateTime;
  OldRapportiUnificati:=Q430.FieldByName('RAPPORTI_UNIFICATI').AsString;
end;

procedure TA002FAnagrafeDtM1.Q030BeforeInsert(DataSet: TDataSet);
begin
  if Parametri.InserimentoMatricole <> 'S' then
    Abort;
  if VersioneDimostrativa then
  begin
    Q030Count.Execute;
    if Q030Count.Field(0) > 40 then
      raise Exception.Create('Questa è una versione dimostrativa: ' + #13 + 'è stato superato il numero di dipendenti disponibili!');
  end;
end;

procedure TA002FAnagrafeDtM1.D430DataChange(Sender: TObject;
  Field: TField);
{Per i dati liberi con descrizione imposto Hint}
var i: Integer;
begin
  //Ciclo sui dati liberi considerando solo quelli con la query per la descrizione
  for i:=1 to A002FAnagrafeVista.NumDatiLiberi do
    if DatiLiberi[i].Query <> nil then
    begin
      DatiLiberi[i].ECampo.Hint:=DatiLiberi[i].Query.FieldByName('DESCRIZIONE').AsString;
    end;
  //Imposto Hint = descrizione anche per il campo TIPORAPPORTO perchè la descrizione è molto lunga
  A002FAnagrafeGest.ETipoRapp.Hint:=Q430.FieldByName('D_TIPORAPPORTO').AsString;

  if (Field = nil) or (Field = Q430.FieldByName('COMUNE')) or (Field = Q430.FieldByName('COMUNE_DOM_BASE')) then
  begin
    A002FAnagrafeGest.dcmbComune.Font.Color:=clBlack;
    A002FAnagrafeGest.dcmbComune.Hint:='';
    A002FAnagrafeGest.dcmbComuneDomBase.Font.Color:=clBlack;
    A002FAnagrafeGest.dcmbComuneDomBase.Hint:='';
    if VarTostr(T480.Lookup('CODICE',Q430.FieldByName('COMUNE').AsString,'SOPPRESSO')) = 'S' then
    begin
      A002FAnagrafeGest.dcmbComune.Font.Color:=clRed;
      A002FAnagrafeGest.dcmbComune.Hint:='Comune soppresso';
    end;
    if VarTostr(T480.Lookup('CODICE',Q430.FieldByName('COMUNE_DOM_BASE').AsString,'SOPPRESSO')) = 'S' then
    begin
      A002FAnagrafeGest.dcmbComuneDomBase.Font.Color:=clRed;
      A002FAnagrafeGest.dcmbComuneDomBase.Hint:='Comune soppresso';
    end;
  end;

  if (Field = nil) or ((Field.FieldKind = fkData) and (D430.State <> dsBrowse)) then
    RefreshFiltro(Field);
end;

procedure TA002FAnagrafeDtM1.Q030NewRecord(DataSet: TDataSet);
begin
  if (Parametri.DefTipoPersonale = 'E') and (Parametri.ModPersonaleEsterno = 'S') then
    Q030.FieldByName('TIPO_PERSONALE').AsString:='E'
  else
    Q030.FieldByName('TIPO_PERSONALE').AsString:='I';
end;

procedure TA002FAnagrafeDtM1.AggiornaCdCPercentualizzati;
var
  DataDecMod:TDateTime;
  Automatismo:Boolean;
  Risposta:Integer;
begin
  Automatismo:=False; //passato alla funzione per referenza
  if A002FAnagrafeMW.VerificaCdCPercentualizzati(A002FAnagrafeGest.chkStoriciPrec.Checked,A002FAnagrafeGest.chkStoriciSucc.Checked, StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0]), DataDecMod,Automatismo) then
  begin
    ApriCdcPerc:=False;
    //Chiedo se intervenire sui centri di costo, manualmente o automaticamente
    if not Automatismo then
      ApriCdcPerc:=R180MessageBox(A000MSG_A002_DLG_CDC_MANUALE,'DOMANDA') = mrYes
    else
    begin
      Risposta:=R180MessageBox(A000MSG_A002_DLG_CDC_AUTOMATICO,'DOMANDA_ESCI');
      //Se l'intervento è automatico, elimino le percentualizzazioni successive al giorno prima dell'intero periodo modificato sulla T430
      if Risposta = mrYes then
      begin
        A002FAnagrafeMW.updT433.SetVariable('PROGRESSIVO',Q430Progressivo.AsInteger);
        A002FAnagrafeMW.updT433.SetVariable('DATADECORRENZA_MOD',DataDecMod);
        A002FAnagrafeMW.updT433.SetVariable('CODICE',Q430.FieldByName(Parametri.CampiRiferimento.C13_CdcPercentualizzati).Value);
        A002FAnagrafeMW.updT433.Execute;
      end;
      ApriCdcPerc:=Risposta <> mrCancel;
    end;
  end;
end;

procedure TA002FAnagrafeDtM1.OpenA002ShortTerm(Progressivo:Integer; TipoRichiamo,TipoRapporto:String; DataRiferimento,StartDate,CessDate:TDateTime);
var A002FShortTerm: TA002FShortTerm;
    DatiInpShortTerm:TDatiInpShortTerm;
    DatiOutShortTerm:TDatiOutShortTerm;
begin
  DatiInpShortTerm.Progressivo:=Progressivo;
  DatiInpShortTerm.TipoRichiamo:=TipoRichiamo;
  DatiInpShortTerm.TipoRapporto:=TipoRapporto;
  DatiInpShortTerm.DataRiferimento:=DataRiferimento;
  DatiInpShortTerm.StartDate:=StartDate;
  DatiInpShortTerm.CessDate:=CessDate;
  DatiOutShortTerm:=A002FAnagrafeMW.ShortTerm(DatiInpShortTerm);
  if DatiOutShortTerm.Messaggio <> '' then
    R180MessageBox(DatiOutShortTerm.Messaggio,ESCLAMA);
  if DatiOutShortTerm.MessaggioBloccante <> '' then
    R180MessageBox(DatiOutShortTerm.MessaggioBloccante,ERRORE);
  if DatiOutShortTerm.NumPeriodi > 0 then
    if (DatiOutShortTerm.Messaggio <> '') or (DatiOutShortTerm.MessaggioBloccante <> '') or
       (DatiInpShortTerm.TipoRichiamo = 'Analisi') then
    begin
      A002FShortTerm:=TA002FShortTerm.Create(nil);
      try
        A002FAnagrafeMW.CaricaCdsShortTerm(DatiOutShortTerm);
        A002FShortTerm.lblNominativo.Caption:=Q030.FieldByName('MATRICOLA').AsString + ' - ' + Q030.FieldByName('COGNOME').AsString + ' ' + Q030.FieldByName('NOME').AsString;
        A002FShortTerm.lblFineContrPrev.Visible:=DatiOutShortTerm.MessFineContrPrev <> '';
        A002FShortTerm.lblMessFineContrPrev.Visible:=DatiOutShortTerm.MessFineContrPrev <> '';
        A002FShortTerm.lblMessFineContrPrev.Caption:=DatiOutShortTerm.MessFineContrPrev;
        A002FShortTerm.lblRegola35Prev.Visible:=DatiOutShortTerm.MessRegola35Prev <> '';
        A002FShortTerm.lblMessRegola35Prev.Visible:=DatiOutShortTerm.MessRegola35Prev <> '';
        A002FShortTerm.lblMessRegola35Prev.Caption:=DatiOutShortTerm.MessRegola35Prev;
        A002FShortTerm.lblPensionePrev.Visible:=DatiOutShortTerm.MessPensionePrev <> '';
        A002FShortTerm.lblMessPensionePrev.Visible:=DatiOutShortTerm.MessPensionePrev <> '';
        A002FShortTerm.lblMessPensionePrev.Caption:=DatiOutShortTerm.MessPensionePrev;
        A002FShortTerm.lblShifPrev.Visible:=DatiOutShortTerm.MessShifPrev <> '';
        A002FShortTerm.lblMessShifPrev.Visible:=DatiOutShortTerm.MessShifPrev <> '';
        A002FShortTerm.lblMessShifPrev.Caption:=DatiOutShortTerm.MessShifPrev;
        A002FShortTerm.ShowModal;
      finally
        FreeAndNil(A002FShortTerm);
      end;
    end;
end;

end.

