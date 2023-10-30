{ Invokable implementation File for TB020IrisWebSvc01 which implements IB020IrisWebSvc01 }

unit B020UIrisWebSvc01Impl;

interface

uses InvokeRegistry, Types, XSBuiltIns, B020UIrisWebSvc01Intf,
     SysUtils, Oracle, OracleData, ActiveX, Windows, Classes, SyncObjs,
     A000UCostanti, A000USessione, C180FunzioniGenerali,
     W009UStampaCartellinoDtm, R600, Rp502Pro, R500Lin, System.IOUtils;

type
  TParametri = record
    WEBCartelliniDataMin:TDateTime;
    WEBCartelliniMMPrec:Integer;
    WEBCartelliniMMSucc:Integer;
  end;

  { TB020IrisWebSvc01 }
  TB020IrisWebSvc01 = class(TInvokableClass, IB020IrisWebSvc01)
  private
    TipoRichiesta: String;
    W009FStampaCartellinoDtm: TW009FStampaCartellinoDtm;
    R600DtM: TR600DtM1;
    R502ProDtM: TR502ProDtM1;
    function GeneraRispostaOk(Xml: WideString): WideString;
    function GeneraErrore(Codice,Descrizione: String): WideString;
    function EstraiSessioneOracle(const DB, Azienda: WideString): Integer;
    function GetSessioneOracle(LogonDB,LogonUsr,LogonPwd:String):Integer;
    function CreaCartellinoPDF(SessioneOracleB020:TOracleSession; pMatricola,pDal,pAl,Parametrizzazione,FilePdf,CartelliniChiusi: WideString): WideString;
    const XML_HEAD: String = '<?xml version="1.0" encoding="UTF-8"?>';
  public
    function echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
    function echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
    function echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
    function echoDouble(const Value: Double): Double; stdcall;
    function CartellinoPDF(const DB,Azienda,Matricola,Dal,Al,Parametrizzazione,FilePdf: WideString): WideString; stdcall;
    function R600GetAssenze(const DB,Azienda,Matricola,DataRiferimento,Causale,DataNasFam: WideString): WideString; stdcall;
    function R502Conteggi(const DB,Azienda,Matricola,DataRiferimento: WideString): WideString; stdcall;
  end;

implementation

uses
  B020UIrisWebSvc01Dtm;

var
  CSStampa, CSStampaCartellino:TMedpCriticalSection;

function TB020IrisWebSvc01.echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
begin
  { TODO : Implement method echoEnum }
  Result := Value;
end;

function TB020IrisWebSvc01.echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
begin
  { TODO : Implement method echoDoubleArray }
  Result := Value;
end;

function TB020IrisWebSvc01.echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
begin
  { TODO : Implement method echoMyEmployee }
  Result := TMyEmployee.Create;
end;

function TB020IrisWebSvc01.echoDouble(const Value: Double): Double; stdcall;
begin
  { TODO : Implement method echoDouble }
  Result := Value;
end;

//______________________________________________________________________________

function TB020IrisWebSvc01.GeneraErrore(Codice,Descrizione: String): WideString;
{ Formatta l'errore come stringa xml standard }
begin
  if TipoRichiesta = '' then
    TipoRichiesta:='Undefined';
  Result:=XML_HEAD + #13#10 +
          '<' + TipoRichiesta + '>' + #13#10 +
          '  <Errore>' + #13#10 +
          '    <Codice>' + Codice + '</Codice>' + #13#10 +
          '    <Descrizione>' + Descrizione + '</Descrizione>' + #13#10 +
          '  </Errore>' + #13#10 +
          '</' + TipoRichiesta + '>';
end;

function TB020IrisWebSvc01.GeneraRispostaOk(Xml: WideString): WideString;
{ Formatta il risultato come stringa xml standard }
begin
  if TipoRichiesta = '' then
    Result:=GeneraErrore('Errore interno','Tipo richiesta non definito')
  else
    Result:=XML_HEAD + #13#10 +
            '<' + TipoRichiesta + '>' + #13#10 +
            '  ' + StringReplace(Xml,#13#10,#13#10 + '  ',[rfReplaceAll]) + #13#10 +
            '</' + TipoRichiesta + '>';
end;

//______________________________________________________________________________

function TB020IrisWebSvc01.GetSessioneOracle(LogonDB,LogonUsr,LogonPwd:String):Integer;
var i,k:Integer;
begin
  Result:=-1;
  for i:=0 to High(B020FIrisWebSvc01Dtm.lstSessioniOracle) do
    if (B020FIrisWebSvc01Dtm.lstSessioniOracle[i].LogonDatabase = LogonDB) and
       (B020FIrisWebSvc01Dtm.lstSessioniOracle[i].LogonUserName = LogonUsr) then
    begin
      Result:=i;
      Break;
    end;
  if Result = -1 then
  begin
    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' SessioneOracle: nuova sessione.inizio');
    SetLength(B020FIrisWebSvc01Dtm.lstSessioniOracle,Length(B020FIrisWebSvc01Dtm.lstSessioniOracle) + 1);
    Result:=High(B020FIrisWebSvc01Dtm.lstSessioniOracle);
    k:=Result;
    B020FIrisWebSvc01Dtm.lstSessioniOracle[k]:=TOracleSession.Create(nil);
    B020FIrisWebSvc01Dtm.lstSessioniOracle[k].LogonDatabase:=LogonDB;
    B020FIrisWebSvc01Dtm.lstSessioniOracle[k].LogonUserName:=LogonUsr;
    B020FIrisWebSvc01Dtm.lstSessioniOracle[k].NullValue:=nvNull;
    B020FIrisWebSvc01Dtm.lstSessioniOracle[k].Preferences.ZeroDateIsNull:=False;
    B020FIrisWebSvc01Dtm.lstSessioniOracle[k].Preferences.TrimStringFields:=False;
    B020FIrisWebSvc01Dtm.lstSessioniOracle[k].Preferences.UseOCI7:=False;
    B020FIrisWebSvc01Dtm.lstSessioniOracle[k].ThreadSafe:=True;
    B020FIrisWebSvc01Dtm.lstSessioniOracle[k].Name:='SessioneOracleB020_' + IntToStr(k);
    try
      if LogonPwd = '' then
        A000LogonDBOracle(B020FIrisWebSvc01Dtm.lstSessioniOracle[k])
      else
      begin
        B020FIrisWebSvc01Dtm.lstSessioniOracle[k].LogonPassword:=LogonPwd;
        B020FIrisWebSvc01Dtm.lstSessioniOracle[k].Logon;
      end;
    except
      A000LogonDBOracle(B020FIrisWebSvc01Dtm.lstSessioniOracle[k]);
    end;

    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' SessioneOracle: nuova sessione.fine');
  end;
end;

function TB020IrisWebSvc01.EstraiSessioneOracle(const DB, Azienda: WideString): Integer;
var
  x: Integer;
  LogonDB,LogonUsr,LogonPwd:WideString;
begin
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' SessioneOracle: ricerca sessione.inizio');
  //Cerco la sessione oracle corrispondente a DB e Azienda specificati
  LogonDB:=DB;
  if LogonDB = '' then
    LogonDB:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B020','Database','IRIS');
  LogonUsr:='MONDOEDP';
  (*LogonPwd:=A000GetPassword;*)
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' SessioneMONDOEDP:%s %s %s ',[LogonDB,LogonUsr,''(*LogonPwd*)]));
  x:=GetSessioneOracle(LogonDB,LogonUsr,''(*LogonPwd*));
  if x = -1 then
    raise Exception.Create('Connessione al db MONDOEDP non riuscita');
  with TOracleQuery.Create(nil) do
  try
    Session:=B020FIrisWebSvc01Dtm.lstSessioniOracle[x];
    SQL.Text:='select UTENTE,PAROLACHIAVE from I090_ENTI where AZIENDA = ''' + Azienda + '''';
    Execute;
    LogonUsr:=FieldAsString(0);
    LogonPwd:=R180Decripta(FieldAsString(1),21041974);
  finally
    Free;
  end;
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' SessioneOracle:%s %s %s ',[LogonDB,LogonUsr,LogonPwd]));
  Result:=GetSessioneOracle(LogonDB,LogonUsr,LogonPwd);
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' SessioneOracle[%d]',[Result]));
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' SessioneOracle: ricerca sessione.fine');
end;

//______________________________________________________________________________

function TB020IrisWebSvc01.CreaCartellinoPDF(SessioneOracleB020:TOracleSession; pMatricola,pDal,pAl,Parametrizzazione,FilePdf,CartelliniChiusi: WideString): WideString;
// Stessa procedura utilizzata in IrisWEB in W009UStampaCartellino
var DataI,DataF:TDateTime;
    A,M,G,A2,M2,G2:Word;
    iSQL:Integer;
    S,SQLText:String;
    CodiceT950:String;
    lst:TStringList;
    Parametri:TParametri;
    FS:TFormatSettings;
    PathModelliRave: String;
begin
  Result:='';
  // bugfix.ini:
  // verifica e impostazione path modelli corretto
  PathModelliRave:=A000GetHomePath;
  PathModelliRave:=IncludeTrailingPathDelimiter(PathModelliRave) + RAVE_MODEL_REL_PATH;
  if not TDirectory.Exists(PathModelliRave) then
  begin
    Result:=Format('Il path dei modelli di stampa indicato è invalido o non accessibile: "%s". Verificare la variabile di ambiente HKLM\Software\IrisWin\HOME',[PathModelliRave]);
    exit;
  end;
  // bugfix.fine
  FS:=TFormatSettings.Create(MAKELCID(MAKELANGID(LANG_ITALIAN, SUBLANG_ITALIAN), SORT_DEFAULT));  //non serve fare il free
  FS.ShortDateFormat:='dd/mm/yyyy';
  Parametri.WEBCartelliniDataMin:=0;
  Parametri.WEBCartelliniMMPrec:=-1;
  Parametri.WEBCartelliniMMSucc:=-1;
  W009FStampaCartellinoDtm.Sessione:=SessioneOracleB020;
  W009FStampaCartellinoDtm.selAnagrafeW:=W009FStampaCartellinoDtm.selAnagrafeApp;
  W009FStampaCartellinoDtm.selAnagrafeW.Session:=SessioneOracleB020;
  W009FStampaCartellinoDtm.CartelliniChiusi:=CartelliniChiusi = 'S';
  W009FStampaCartellinoDtm.Stampa:=True;
  W009FStampaCartellinoDtm.RegLog:=False;
  W009FStampaCartellinoDtm.RaveProjectFile:=IncludeTrailingPathDelimiter(PathModelliRave) + RAVE_MODEL_CARTELLINO;
  W009FStampaCartellinoDtm.NomeFile:=FilePDF;
  W009FStampaCartellinoDtm.RaveOutputFileName:=FilePDF;
  DataI:=StrToDate(pDal,FS);
  DataF:=StrToDate(pAl,FS);
  if DataF < DataI then
  begin
    Result:='Date non corrette!';
    exit;
  end;
  if R180Anno(DataI) <> R180Anno(DataF) then
  begin
    Result:='Le date devono essere riferite allo stesso anno!';
    exit;
  end;
  if DataI < Parametri.WEBCartelliniDataMin then
  begin
    Result:=Format('Non è possibile elaborare il cartellino prima del %s!',[DateToStr(Parametri.WEBCartelliniDataMin)]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMPrec >= 0) and (R180AddMesi(R180InizioMese(DataI),Parametri.WEBCartelliniMMPrec) < R180InizioMese(Date)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino antecedente di %d mesi!',[Parametri.WEBCartelliniMMPrec]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMSucc >= 0) and (R180InizioMese(DataF) > R180AddMesi(R180InizioMese(Date),Parametri.WEBCartelliniMMSucc)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino successivo a %d mesi!',[Parametri.WEBCartelliniMMSucc]);
    exit;
  end;
  SQLText:=W009FStampaCartellinoDtm.selAnagrafeW.SQL.Text;
  CodiceT950:=Parametrizzazione;
  DecodeDate(DataI,A,M,G);
  DecodeDate(DataF,A2,M2,G2);
  //Se le date differiscono di mese o di anno, allora i giorni vanno
  //da 1 all'ultimo del mese
  if (M <> M2) or (A <> A2) then
  begin
    G:=1;
    G2:=R180GiorniMese(DataF);
    DataI:=EncodeDate(A,M,G);
    DataF:=EncodeDate(A2,M2,G2);
    pDal:=DateToStr(DataI);
    pAl:=DateToStr(DataF);
  end;
  try
    W009FStampaCartellinoDtm.CreazioneR400(SessioneOracleB020); //W009FStampaCartellinoDtm.W009FStampaCartellinoDtM.R400FCartellinoDtM:=TW009FStampaCartellinoDtM.R400FCartellinoDtM.Create(Self);
    W009FStampaCartellinoDtm.R400FCartellinoDtM.R450DtM1.Name:=''; //Altrimenti duplicazione sul nome quando viene creata la R450 dalla R600 per i conteggi di alcune assenze
    W009FStampaCartellinoDtm.R400FCartellinoDtM.R600DtM1.Name:='';
    W009FStampaCartellinoDtm.R400FCartellinoDtM.R410FAutoGiustificazioneDtM.Name:='';
  except
    on E:Exception do
    begin
      Result:=E.Message;
      exit;
    end;
  end;
  //RegistraMsg.IniziaMessaggio('W009');
  if False then
    W009FStampaCartellinoDtM.CreazioneR350;
  if False then
    W009FStampaCartellinoDtM.CreazioneR300(DataI,DataF);
  try
    try
      with W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int do
      begin
        Close;
        SetVariable('Codice',CodiceT950);
        Open;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.selDatiBloccati.Close;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.SoloAggiornamento:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AggiornamentoScheda:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AutoGiustificazione:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.CalcoloCompetenze:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstDettaglio.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstRiepilogo.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Intestazione');
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Dettaglio');
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');
      W009FStampaCartellinoDtm.selAnagrafeW.SetVariable('MATRICOLA',pMatricola);
      W009FStampaCartellinoDtm.selAnagrafeW.SetVariable('DATALAVORO',DataF);
      W009FStampaCartellinoDtm.selAnagrafeW.Close;
      if (Pos(W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione,W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text) = 0) and
         ((Pos('T030.*',W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text) = 0) or (Pos('V430.*',W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text) = 0)) then
      begin
        S:=W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text;
        iSQL:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
        if iSQL > 0 then
          Insert(',' + W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione + ' ',S,iSQL);
        W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text:=S;
      end;
      W009FStampaCartellinoDtm.selAnagrafeW.Open;
      lst:=TStringList.Create;
      with W009FStampaCartellinoDtM.R400FCartellinoDtM do
      try
        SetLength(VetDatiLiberiSQL,0);
        selT951.Close;
        selT951.SetVariable('Codice',Q950Int.FieldByName('CODICE').AsString);
        selT951.Open;
        while not selT951.Eof do
        begin
          lst.Add(Trim(selT951.FieldByName('RIGA').AsString));
          selT951.Next;
        end;
        selT951.Close;
        W009FStampaCartellinoDtM.GetLabels(lst,'Riepilogo2001',nil);
        //Devo già avere l'elenco dei dati liberi 2001
        CreaClientDataSet(W009FStampaCartellinoDtm.selAnagrafeW);
      finally
        lst.Free;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.A027SelAnagrafe:=W009FStampaCartellinoDtm.selAnagrafeW;
      //Posizionamento sulla matricola correntemente selezionata
      if W009FStampaCartellinoDtm.selAnagrafeW.SearchRecord('MATRICOLA',pMatricola,[srFromBeginning]) then
        Result:=W009FStampaCartellinoDtM.CalcoloCartellini(A,M,G,A2,M2,G2)
      else
      begin
        //GetDipendentiDisponibili(DataF);
        Result:='Anagrafico non disponibile!';
        Abort;
      end;
      W009FStampaCartellinoDtM.ChiusuraQuery(W009FStampaCartellinoDtM.R400FCartellinoDtM);
      with W009FStampaCartellinoDtM.R400FCartellinoDtM do
      begin
        //Chiudo subito le query e le unit dei conteggi, salvo Q950Int che serve in stampa
        Q950Int.Open;
        W009FStampaCartellinoDtM.ChiusuraQuery(R450DtM1);
        R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1)',['']));
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R600DtM1);
      end;
      try
       if W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0 then
       begin
         W009FStampaCartellinoDtM.W009CSStampa:=CSStampa;
         W009FStampaCartellinoDtm.RPDefine_DataID('B020');
         R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' W009FStampaCartellinoDtM.EsecuzioneStampa',[]));
         Result:=W009FStampaCartellinoDtM.EsecuzioneStampa;
       end
       else
         Result:='Nessun cartellino disponibile nel periodo specificato!';
      except
        on E:Exception do
          Result:=E.Message;
      end;
      with W009FStampaCartellinoDtM.R400FCartellinoDtM do
      begin
        cdsRiepilogo.Close;
        cdsDettaglio.Close;
        cdsSettimana.Close;
        cdsAssenze.Close;
        cdsPresenze.Close;
        Q950Int.CloseAll;
      end;
    finally
      W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.CloseAll;
      W009FStampaCartellinoDtm.selAnagrafeW.CloseAll;
      //W009FStampaCartellinoDtm.selAnagrafeW.SQL.Text:=SQLText;
      if W009FStampaCartellinoDtM.R400FCartellinoDtM <> nil then
      begin
        W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.CloseAll;
        W009FStampaCartellinoDtM.R400FCartellinoDtM.A027SelAnagrafe:=nil;
        if W009FStampaCartellinoDtM.R400FCartellinoDtM.R300DtM <> nil then
          FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R300DtM);
        if W009FStampaCartellinoDtM.R400FCartellinoDtM.R350DtM <> nil then
          FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R350DtM);
        R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM)',['']));
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM);
      end;
      //W009FStampaCartellinoDtm.selAnagrafeW.Open;
      W009FStampaCartellinoDtM.DistruggiLstRaveComp;
      R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' FreeAndNil(W009FStampaCartellinoDtm)',[]));
      FreeAndNil(W009FStampaCartellinoDtm);
    end;
  except
    on E:Exception do
      Result:=E.Message;
  end;
end;

//******************************************************************************
//******************   F U N Z I O N I   P U B B L I C H E   *******************
//******************************************************************************
function TB020IrisWebSvc01.CartellinoPDF(const DB,Azienda,Matricola,Dal,Al,Parametrizzazione,FilePdf: WideString): WideString; stdcall;
{Valorizzare le seguenti chiavi di registro in HKLM:
 - IrisWIN
   |  HOME          = c:\IrisWEB            (dove risiede il W009.rav)
   |  PATH_LOG      = c:\IrisWEB\Archivi    (dove scrivere B020.log)
   |_ B020
      |  Database   = IRIS                  (database di default)
      |  URL        = http://server/        (per eseguire B020PTest)
}
var
  k:Integer;
  DataTemp: TDateTime;
  FS:TFormatSettings;
begin
  A000SettaVariabiliAmbiente;
  FS:=TFormatSettings.Create(MAKELCID(MAKELANGID(LANG_ITALIAN, SUBLANG_ITALIAN), SORT_DEFAULT));  //non serve fare il free
  FS.ShortDateFormat:='dd/mm/yyyy';
  try
    TipoRichiesta:='CartellinoPdf';
    Result:='';
    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' TB020IrisWebSvc01.CartellinoPDF.inizio');
    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' Parametri: %s %s %s %s %s %s %s',[DB,Azienda,Matricola,Dal,Al,Parametrizzazione,FilePdf]));

    // controllo parametri
    if Trim(Matricola) = '' then
    begin
      Result:=GeneraErrore('Parametro errato','Matricola non specificata!');
      Exit;
    end;
    try
      DataTemp:=StrToDate(Dal,FS);
    except
      on E: Exception do
      begin
        Result:=GeneraErrore('Parametro errato','Data inizio errata ' + Dal + ': ' + E.Message);
        Exit;
      end;
    end;
    try
      DataTemp:=StrToDate(Al,FS);
    except
      on E: Exception do
      begin
        Result:=GeneraErrore('Parametro errato','Data fine errata ' + Al + ': ' + E.Message);
        Exit;
      end;
    end;

    // connessione oracle
    k:=EstraiSessioneOracle(DB,Azienda);
    if k = -1 then
    begin
      Result:=GeneraErrore('Errore di connessione','Connessione al db dell''azienda non riuscita');
      Exit;
    end;

    //Richiamo in modo sequenziale (con la CriticalSection) la procedura di creazione del cartellino pdf vera e propria
    CSStampaCartellino.Enter;
    try
      R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' TW009FStampaCartellinoDtm.Create',[]));
      W009FStampaCartellinoDtm:=TW009FStampaCartellinoDtm.Create(B020FIrisWebSvc01Dtm.lstSessioniOracle[k]);
      Result:=CreaCartellinoPDF(B020FIrisWebSvc01Dtm.lstSessioniOracle[k],Matricola,Dal,Al,Parametrizzazione,FilePdf,'N');
      if Result <> '' then
      begin
        R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' CartellinoPDF.Result=%s',[Result]));
        Result:=GeneraErrore('Errore cartellino',Result);
      end;
    finally
      FreeAndNil(W009FStampaCartellinoDtm);
      CSStampaCartellino.Leave;
      R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' TB020IrisWebSvc01.CartellinoPDF.fine');
    end;
  except
    on E:Exception do
    begin
      Result:=GeneraErrore(E.ClassName,E.Message);
      R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' CartellinoPDF.exception=%s',[E.Message]));
    end;
  end;
end;

function TB020IrisWebSvc01.R600GetAssenze(const DB,Azienda,Matricola,DataRiferimento,Causale,DataNasFam: WideString): WideString;
{Valorizzare le seguenti chiavi di registro in HKLM:
 - IrisWIN.PATH_LOG = c:\IrisWEB\Archivi    (dove scrivere B020.log)
 - IrisWIN\B020\Database = IRIS             (database di default)
 - IrisWIN\B020\URL = http://server/        (per eseguire B020PTest)
}
var
  k:Integer;
  Progressivo: Integer;
  DataRif,DataNas: TDateTime;
  Caus: String;
  G: TGiustificativo;
  XmlStr: WideString;
  FS:TFormatSettings;
begin
  A000SettaVariabiliAmbiente;
  FS:=TFormatSettings.Create(MAKELCID(MAKELANGID(LANG_ITALIAN, SUBLANG_ITALIAN), SORT_DEFAULT));  //non serve fare il free
  //GetLocaleFormatSettings(MAKELCID(MAKELANGID(LANG_ITALIAN, SUBLANG_ITALIAN), SORT_DEFAULT),FS);
  FS.ShortDateFormat:='dd/mm/yyyy';
  try
    TipoRichiesta:='DatiAssenze';
    Result:='';
    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' TB020IrisWebSvc01.R600GetAssenze.inizio ');
    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' Parametri: %s %s %s %s %s %s',[DB,Azienda,Matricola,DataRiferimento,Causale,DataNasFam]));

    // controllo parametri
    if Trim(Matricola) = '' then
    begin
      Result:=GeneraErrore('Parametro errato','Matricola mancante');
      Exit;
    end;
    try
      DataRif:=StrToDate(DataRiferimento,FS);
    except
      on E: Exception do
      begin
        Result:=GeneraErrore('Parametro errato','Data errata ' + DataRiferimento + ': ' + E.Message);
        Exit;
      end;
    end;
    Caus:=Causale;
    if Trim(Caus) = '' then
    begin
      Result:=GeneraErrore('Parametro errato','Causale non indicata');
      Exit;
    end;
    if DataNasFam = '' then
      DataNas:=0
    else
    begin
      try
        DataNas:=StrToDateTime(DataNasFam,FS);
      except
        on E: Exception do
        begin
          Result:=GeneraErrore('Parametro errato','Data di riferimento del familiare errata ' + DataNasFam + ': ' + E.Message);
          Exit;
        end;
      end;
    end;

    // connessione oracle
    k:=EstraiSessioneOracle(DB,Azienda);
    if k = -1 then
    begin
      Result:=GeneraErrore('Errore di connessione','Connessione al db dell''azienda non riuscita');
      Exit;
    end;

    // elaborazione richiesta
    CSStampaCartellino.Enter;
    try
      with TOracleQuery.Create(nil) do
      try
        Session:=B020FIrisWebSvc01Dtm.lstSessioniOracle[k];
        SQL.Text:='select PROGRESSIVO from T030_ANAGRAFICO where MATRICOLA = ''' + Matricola + '''';
        Execute;
        Progressivo:=FieldAsInteger(0);
      finally
        Free;
      end;

      R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' R600DtM.Create',[]));
      G.Inserimento:=False;
      G.Modo:='I';
      G.Causale:=Caus;
      R600DtM:=TR600Dtm1.Create(B020FIrisWebSvc01Dtm.lstSessioniOracle[k]);
      try
        R600DtM.GetAssenze(Progressivo,DataRif,DataRif,DataNas,G,False);
        XmlStr:='<UnitaMisura>' + R600DtM.UMisura + '</UnitaMisura>' + #13#10 +
                '<TipoCumulo>' + R600DtM.TipoCumulo + '</TipoCumulo>' + #13#10 +
                '<Competenze>' + R600DtM.GetCompTot + '</Competenze>' + #13#10 +
                '<Fruito>' + R600DtM.GetFruitoTot + '</Fruito>' + #13#10 +
                '<Residuo>' + R600DtM.GetResiduo + '</Residuo>';
        R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' R600GetAssenze.Result=%s',[StringReplace(StringReplace(XmlStr,#13,'',[rfReplaceAll]),#10,'',[rfReplaceAll])]));
        Result:=GeneraRispostaOK(XmlStr);
      except
        on E: Exception do
        begin
          Result:=GeneraErrore('Lettura dati assenza fallita',
                               'Anomalia rilevata: ' + E.Message);
        end;
      end;
    finally
      FreeAndNil(R600DtM);
      CSStampaCartellino.Leave;
      R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' TB020IrisWebSvc01.R600GetAssenze.fine');
    end;
  except
    on E:Exception do
    begin
      Result:=GeneraErrore('Errore generico',E.Message);
      R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' R600GetAssenze.exception=%s',[E.Message]));
    end;
  end;
end;

function TB020IrisWebSvc01.R502Conteggi(const DB,Azienda,Matricola,DataRiferimento: WideString): WideString;
{Valorizzare le seguenti chiavi di registro in HKLM:
 - IrisWIN.PATH_LOG = c:\IrisWEB\Archivi    (dove scrivere B020.log)
 - IrisWIN\B020\Database = IRIS             (database di default)
 - IrisWIN\B020\URL = http://server/        (per eseguire B020PTest)
}
var
  k: Integer;
  Progressivo: Integer;
  DataRif: TDateTime;
  XmlStr: WideString;
  FS:TFormatSettings;
begin
  A000SettaVariabiliAmbiente;
  FS:=TFormatSettings.Create(MAKELCID(MAKELANGID(LANG_ITALIAN, SUBLANG_ITALIAN), SORT_DEFAULT));  //non serve fare il free
  //GetLocaleFormatSettings(MAKELCID(MAKELANGID(LANG_ITALIAN, SUBLANG_ITALIAN), SORT_DEFAULT),FS);
  FS.ShortDateFormat:='dd/mm/yyyy';
  try
    TipoRichiesta:='Conteggi';
    Result:='';
    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' TB020IrisWebSvc01.R502Conteggi.inizio');
    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' Parametri: %s %s %s %s',[DB,Azienda,Matricola,DataRiferimento]));

    // controllo parametri
    if Trim(Matricola) = '' then
    begin
      Result:=GeneraErrore('Parametro errato','Matricola mancante');
      Exit;
    end;
    try
      DataRif:=StrToDate(DataRiferimento,FS);
    except
      on E: Exception do
      begin
        Result:=GeneraErrore('Parametro errato','Data errata ' + DataRiferimento + ': ' + E.Message);
        Exit;
      end;
    end;

    k:=EstraiSessioneOracle(DB,Azienda);
    if k = -1 then
    begin
      Result:=GeneraErrore('Errore di connessione','Connessione al db dell''azienda non riuscita');
      Exit;
    end;

    CSStampaCartellino.Enter;
    try
      with TOracleQuery.Create(nil) do
      try
        Session:=B020FIrisWebSvc01Dtm.lstSessioniOracle[k];
        SQL.Text:='select PROGRESSIVO from T030_ANAGRAFICO where MATRICOLA = ''' + Matricola + '''';
        Execute;
        Progressivo:=FieldAsInteger(0);
      finally
        Free;
      end;

      R502ProDtM:=TR502ProDtM1.Create(B020FIrisWebSvc01Dtm.lstSessioniOracle[k]);
      try
        //R502ProDtM.PeriodoConteggi(DataRif,DataRif - 1);
        R502ProDtM.PeriodoConteggi(DataRif,DataRif);
        R502ProDtM.Conteggi('Cartolina',Progressivo,DataRif);
        if R502ProDtM.Blocca = 0 then
          XmlStr:='<Anomalia>' + #13#10 +
                  '  <Codice>0</Codice>' + #13#10 +
                  '  <Descrizione></Descrizione' + #13#10 +
                  '</Anomalia>'
        else
          XmlStr:='<Anomalia>' + #13#10 +
                  '  <Codice>' + IntToStr(R502ProDtM.Blocca) + '</Codice>' + #13#10 +
                  '  <Descrizione>' + R502ProDtM.DescAnomaliaBloccante + '</Descrizione>' + #13#10 +
                  '</Anomalia>';
        R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' R502Conteggi.Result=%s',[StringReplace(StringReplace(XmlStr,#13,'',[rfReplaceAll]),#10,'',[rfReplaceAll])]));
        Result:=GeneraRispostaOK(XmlStr);
      except
        on E: Exception do
        begin
          Result:=GeneraErrore('Esecuzione conteggi fallita',
                               'Anomalia rilevata: ' + E.Message);
        end;
      end;
    finally
      FreeAndNil(R502ProDtM);
      CSStampaCartellino.Leave;
      R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' TB020IrisWebSvc01.R502Conteggi.fine');
    end;
  except
    on E:Exception do
    begin
      Result:=GeneraErrore('Errore generico',E.Message);
      R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + Format(' R502Conteggi.exception=%s',[E.Message]));
    end;
  end;
end;

{ GESTIONE 2
  Creazione istanza globale}
procedure B020IrisWebSvc01Factory(out obj: TObject);
{$J+}
const
  iInstance: IB020IrisWebSvc01 = nil;
  instance: TB020IrisWebSvc01 = nil;
begin
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' B020IrisWebSvc01Factory.INI');

  if instance = nil then
  begin
    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' TB020IrisWebSvc01.Create');
    instance:=TB020IrisWebSvc01.Create;
    R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' TB020IrisWebSvc01.GetInterface');
    instance.GetInterface(IB020IrisWebSvc01, iInstance);
  end;
  obj:=instance;

  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' B020IrisWebSvc01Factory.FINE');
end;

initialization
{ Invokable classes must be registered }
   R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' Initialization.inizio');

   // GESTIONE 1
   //InvRegistry.RegisterInvokableClass(TB020IrisWebSvc01);

   // GESTIONE 2
   InvRegistry.RegisterInvokableClass(TB020IrisWebSvc01,B020IrisWebSvc01Factory);

   CSStampa:=TMedpCriticalSection.Create;
   CSStampaCartellino:=TMedpCriticalSection.Create;
   //A000SettaVariabiliAmbiente;
   R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' Initialization.fine');
finalization
   R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' Finalization.inizio');
   CSStampa.Free;
   CSStampaCartellino.Free;
   R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' Finalization.fine');
end.

