unit A210URegoleArchiviazioneDocMW;

interface

uses
  System.SysUtils, System.Classes, OracleData, Oracle, Data.DB, StrUtils, System.IOUtils,
  R005UDataModuleMW, A000UInterfaccia, A000UMessaggi, A000UCostanti, C180FunzioniGenerali,
  System.JSON, System.Types, REST.JSON, System.Net.URLClient, System.NetEncoding, System.Hash,
  System.Net.HttpClient, System.Net.HttpClientComponent, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, DateUtils;

type
  TDatiVariabili = record
    Matricola:String;
    CodFiscale:String;
    Progressivo:Integer;
    Dal:TDateTime;
    ParamCartellino:String;
    IdDocumento:Integer;
  end;

  TA210FRegoleArchiviazioneDocMW = class(TR005FDataModuleMW)
    selCols: TOracleDataSet;
    updUltimaDataRifElab: TOracleQuery;
    selJSON: TOracleDataSet;
    HTTPClient: TNetHTTPClient;
    HTTPRequest: TNetHTTPRequest;
    selScript: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    RegistroArchiviazione: TJSONObject;
    function GetFileBase64(FullPath: String): String;
    function GetSHA256hex(FullPath: String): String;
  public
    { Public declarations }
    selI210: TOracleDataSet;
    AvviaPSCP: function(const PSCPPath,PSCPArgs:String):T180SyncProcessExecResults of object;
    procedure selI210BeforePostNoStorico;
    function CtrlFile(const PParFile: String; const DatiVariabili: TDatiVariabili; var RFileSost, RErrMsg: String; TipoFile:String = 'pdf'): Boolean;
    function GetPath(const PPath:String; const DatiVariabili: TDatiVariabili;var RErrMsg, VariabiliAna: String):String;
    procedure CtrlCampi(const PCampi:String; var RErrMsg, VariabiliAna, VariabiliXml: String);
    function GetPathArchiviazioneTemp(const PPath:String; var RErrMsg:String):String;
    function EseguiInviaViaSFTP:Boolean;
    function InviaViaSFTP(var RErrMsg:String):Boolean;
    function IsDirectoryEliminabile(Path:String):Boolean;
    procedure SvuotaCartelleArchiviazioneTemp(var RErrMsg:String);
    procedure SetDataRifUltimaElab(const TipoDocumento:String; const DataRif:TDateTime);
    function GetDataRifUltimaElab:TDateTime;
    function GetJSONRegolaSQL(const RegolaSQL: String; var RErrMsg:String): TJSONObject;
    procedure CreaFileJSON(const RegolaSQL: String; const DocumentoJSON: String; var RErrMsg:String);
    function IsMetadatiJSON: Boolean;
    //gestione registro di archiviazione
    procedure CreaRegistroJSON(Intestazione: String; Data: TDateTime);
    procedure AddDocumentoJSON(IdDocumento: Integer);
    function GetStringaRegistroJSON: String;
    function SalvaRegistroSuFile(FullPath: String): Boolean;
    function GetDataCreazioneRegistro: TDateTime;
    procedure InviaRegistro(FullPathTemp: String; IdDocumento: Integer);
  end;

const
  A210_DIR_CEDOLINI = 'cedolini';
  A210_DIR_CU = 'cu';
  A210_DIR_LOGCED = 'logcedolini';
  A210_DIR_LOGCU = 'logcu';

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA210FRegoleArchiviazioneDocMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='PAGHE';

  RegistroArchiviazione:=nil;
end;

procedure TA210FRegoleArchiviazioneDocMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(RegistroArchiviazione) then
    FreeAndNil(RegistroArchiviazione);
end;

procedure TA210FRegoleArchiviazioneDocMW.selI210BeforePostNoStorico;
var DatiVariabili:TDatiVariabili;
    FileSost,ErrMsg,VariabiliAna,VariabiliXml:String;
begin
  selI210.FieldByName('PATH_FILE').AsString:=Trim(selI210.FieldByName('PATH_FILE').AsString);
  selI210.FieldByName('FILE_PDF').AsString:=Trim(selI210.FieldByName('FILE_PDF').AsString);
  selI210.FieldByName('FILE_XML').AsString:=Trim(selI210.FieldByName('FILE_XML').AsString);
  selI210.FieldByName('CAMPI_XML').AsString:=Trim(selI210.FieldByName('CAMPI_XML').AsString);
  DatiVariabili.Matricola:='X';
  DatiVariabili.CodFiscale:='X';
  DatiVariabili.Progressivo:=0;
  DatiVariabili.Dal:=Parametri.DataLavoro;
  DatiVariabili.ParamCartellino:='X';
  DatiVariabili.IdDocumento:=0;
  // Scheda 'Archiviazione locale'
  if not selI210.FieldByName('PATH_FILE').IsNull then
  begin
    if selI210.FieldByName('PATH_FILE').AsString <> 'DB' then
    begin
      GetPath(selI210.FieldByName('PATH_FILE').AsString,DatiVariabili,ErrMsg,VariabiliAna);
      if ErrMsg <> '' then
        raise exception.Create(ErrMsg);
      if selI210.FieldByName('FILE_PDF').IsNull and selI210.FieldByName('FILE_XML').IsNull then
        raise exception.Create(A000MSG_A210_ERR_SI_PATH_FILE_NO_FILE);
      selI210.FieldByName('PATH_FILE').AsString:=IncludeTrailingPathDelimiter(selI210.FieldByName('PATH_FILE').AsString);
    end;
  end
  else if not selI210.FieldByName('FILE_PDF').IsNull or not selI210.FieldByName('FILE_XML').IsNull then
    raise exception.Create(A000MSG_A210_ERR_NO_PATH_FILE_SI_FILE);
  if not selI210.FieldByName('FILE_PDF').IsNull then
  begin
    if UpperCase(Copy(selI210.FieldByName('FILE_PDF').AsString,Length(selI210.FieldByName('FILE_PDF').AsString)-4)) <> '.PDF''' then
      raise exception.Create(A000MSG_A210_ERR_FORMATO_PDF);
    if not CtrlFile(selI210.FieldByName('FILE_PDF').AsString,DatiVariabili,FileSost,ErrMsg) then
      raise exception.Create(ErrMsg);
  end;
  if not selI210.FieldByName('FILE_XML').IsNull then
  begin
    if selI210.FieldByName('TIPO_FILE_METADATI').AsString = 'X' then
    begin
      if UpperCase(Copy(selI210.FieldByName('FILE_XML').AsString,Length(selI210.FieldByName('FILE_XML').AsString)-4)) <> '.XML''' then
        raise exception.Create(A000MSG_A210_ERR_FORMATO_XML);
      if not CtrlFile(selI210.FieldByName('FILE_XML').AsString,DatiVariabili,FileSost,ErrMsg,'xml') then
        raise exception.Create(ErrMsg);
      if selI210.FieldByName('CAMPI_XML').IsNull then
        raise exception.Create(A000MSG_A210_ERR_NO_CAMPI_XML);
      CtrlCampi(selI210.FieldByName('CAMPI_XML').AsString,ErrMsg,VariabiliAna,VariabiliXml);
      if ErrMsg <> '' then
        raise exception.Create(ErrMsg);
    end
    else if selI210.FieldByName('TIPO_FILE_METADATI').AsString = 'J' then
    begin
      if UpperCase(Copy(selI210.FieldByName('FILE_XML').AsString,Length(selI210.FieldByName('FILE_XML').AsString)-5)) <> '.JSON''' then
        raise exception.Create(A000MSG_A210_ERR_FORMATO_JSON);
      if not CtrlFile(selI210.FieldByName('FILE_XML').AsString,DatiVariabili,FileSost,ErrMsg,'json') then
        raise exception.Create(ErrMsg);
      if selI210.FieldByName('CAMPI_XML').IsNull then
        raise exception.Create(A000MSG_A210_ERR_NO_REGOLA_JSON);
    end;
  end
  else if not selI210.FieldByName('CAMPI_XML').IsNull then
    raise exception.Create(A000MSG_A210_ERR_NO_FILE_META_SI_CAMPI);

  // Scheda 'Archiviazione remota (SFTP)'
  if not selI210.FieldByName('SERVER_SFTP').IsNull and selI210.FieldByName('PATH_FILE').IsNull then
    raise exception.Create(A000MSG_A210_ERR_NO_LOCALE);

  if not selI210.FieldByName('SERVER_SFTP').IsNull then
  begin
    if selI210.FieldByName('USERNAME_SFTP').IsNull or selI210.FieldByName('PASSWORD_SFTP').IsNull
      or selI210.FieldByName('PATH_PSCP').IsNull or selI210.FieldByName('DIR_ARCH_SFTP').IsNull then
      raise exception.Create(A000MSG_A210_ERR_NO_SFTP_INFO);
  end
  else
  begin
    if not selI210.FieldByName('USERNAME_SFTP').IsNull or not selI210.FieldByName('PASSWORD_SFTP').IsNull then
      raise exception.Create(A000MSG_A210_ERR_NO_SFTP_SERVER);
  end;
  if not selI210.FieldByName('DIR_ARCH_SFTP').IsNull and selI210.FieldByName('SERVER_SFTP').IsNull then
    raise exception.Create(A000MSG_A210_ERR_NO_SFTP_SERVER_USER_PASS);
  if (not selI210.FieldByName('DIR_ARCH_SFTP').IsNull) and ((selI210.FieldByName('DIR_ARCH_SFTP').AsString)[Length(selI210.FieldByName('DIR_ARCH_SFTP').AsString)] <> '/') then
    raise exception.Create(A000MSG_A210_ERR_PATH_ARCH_REMOTA);
  {$IFNDEF WEBPJ}
  if not selI210.FieldByName('PATH_PSCP').IsNull and not FileExists(selI210.FieldByName('PATH_PSCP').AsString) then
    raise exception.Create(format(A000MSG_A210_ERR_PSCP_NO_VALIDO, [selI210.FieldByName('PATH_PSCP').AsString]));
  {$ENDIF}
end;

function TA210FRegoleArchiviazioneDocMW.CtrlFile(const PParFile: String; const DatiVariabili:TDatiVariabili; var RFileSost, RErrMsg: String; TipoFile:String = 'pdf'): Boolean;
// verifica la sintassi file indicato e restituisce:
// - True
//     se la sintassi è ok
// - False
//     se ci sono errori (nel caso, valorizza RErrMsg con l'errore riscontrato)
// il nome file può contenere le seguenti variabili:
//   :AZIENDA
//   :PROGRESSIVO
//   :MATRICOLA
//   :CODFISCALE
//   :MESE_CARTELLINO
//   :PARAM_CARTELLINO
//   :ID_DOCUMENTO
var
  OQ: TOracleQuery;
  Src: String;
begin
  Result:=False;
  RFileSost:=PParFile;
  RErrMsg:='';
  // utilizza una query del tipo "select [PParFile] from dual"
  // per verificare la sintassi del nome file
  Src:=PParFile.ToUpper;
  OQ:=TOracleQuery.Create(nil);
  try
    try
      OQ.Session:=SessioneOracle;
      // stringa da estrarre
      OQ.DeclareVariable('S',otSubst);
      OQ.SetVariable('S',PParFile);
      // ricerca variabili conosciute
      // matricola
      if Pos(':MATRICOLA',Src) > 0 then
      begin
        OQ.DeclareVariable('MATRICOLA',otString);
        OQ.SetVariable('MATRICOLA',DatiVariabili.Matricola);
      end;
      // codice fiscale
      if Pos(':CODFISCALE',Src) > 0 then
      begin
        OQ.DeclareVariable('CODFISCALE',otString);
        OQ.SetVariable('CODFISCALE',DatiVariabili.CodFiscale);
      end;
      // progressivo
      if Pos(':PROGRESSIVO',Src) > 0 then
      begin
        OQ.DeclareVariable('PROGRESSIVO',otInteger);
        OQ.SetVariable('PROGRESSIVO',DatiVariabili.Progressivo)
      end;
      // mese cartellino
      if Pos(':MESE_CARTELLINO',Src) > 0 then
      begin
        OQ.DeclareVariable('MESE_CARTELLINO',otDate);
        OQ.SetVariable('MESE_CARTELLINO',DatiVariabili.Dal);
      end;
      // parametrizzazione cartellino
      if Pos(':PARAM_CARTELLINO',Src) > 0 then
      begin
        OQ.DeclareVariable('PARAM_CARTELLINO',otString);
        OQ.SetVariable('PARAM_CARTELLINO',DatiVariabili.ParamCartellino);
      end;
      // id documento (id cedolino / id cud)
      if Pos(':ID_DOCUMENTO',Src) > 0 then
      begin
        OQ.DeclareVariable('ID_DOCUMENTO',otInteger);
        OQ.SetVariable('ID_DOCUMENTO',DatiVariabili.IdDocumento)
      end;
      // esegue query
      OQ.SQL.Text:='select :S from DUAL';
      OQ.Execute;
      RFileSost:=Uppercase(OQ.FieldAsString(0));
      Result:=True;
    except
      on E:Exception do
      begin
        RErrMsg:=Format(A000MSG_A210_ERR_FMT_SINTASSI_NOMEFILE,[TipoFile,E.Message]);
        Exit;
      end;
    end;
  finally
    FreeAndNil(OQ);
  end;
end;

function TA210FRegoleArchiviazioneDocMW.GetPath(const PPath:String; const DatiVariabili: TDatiVariabili;var RErrMsg, VariabiliAna: String):String;
var S,Variabile,NomeCampo,TipoDocumento,TipoDocumentoDir:String;
    PosInizioVar:Integer;
begin
  RErrMsg:='';
  VariabiliAna:='';
  TipoDocumento:=selI210.FieldByName('TIPO_DOCUMENTO').AsString;
  Result:=PPath.ToUpper;                                //Es. C:\TEMP\:TIPODOCUMENTO\:T430DITTA\:ANNO\:MESE
  if PPath = '' then
  begin
    RErrMsg:=A000MSG_A210_ERR_NO_PATH_FILE;
    Exit;
  end;
  Result:=IncludeTrailingPathDelimiter(Result);         //Es. C:\TEMP\:T430DITTA\:ANNO\:MESE\
  if (TipoDocumento  = 'CU') or (TipoDocumento = 'CED') or (TipoDocumento = 'LOGCED') or (TipoDocumento = 'LOGCU') then
  begin // verifico il primo parametro, deve essere presente e deve essere :TIPODOCUMENTO
    PosInizioVar:=Pos('\:',Result);
    if PosInizioVar = 0  then
    begin
      RErrMsg:=A000MSG_A210_ERR_NO_VAR_TIPO_DOCUMENTO;
      Exit;
    end;
    inc(PosInizioVar); // posizione del ':'
    s:=Copy(Result, PosInizioVar); // :TIPODOCUMENTO\:T430DITTA\:ANNO\:MESE
    s:=Copy(s,1,Pos('\',s)); // :TIPODOCUMENTO\
    if Uppercase(s) <> ':TIPODOCUMENTO\' then
    begin
      RErrMsg:=A000MSG_A210_ERR_NO_VAR_TIPO_DOCUMENTO;
      Exit;
    end;

    if TipoDocumento = 'CU' then
      TipoDocumentoDir:=A210_DIR_CU
    else if TipoDocumento = 'CED' then
      TipoDocumentoDir:=A210_DIR_CEDOLINI
    else if TipoDocumento = 'LOGCED' then
      TipoDocumentoDir:=A210_DIR_LOGCED
    else if TipoDocumento = 'LOGCU' then
      TipoDocumentoDir:=A210_DIR_LOGCU;

    Result:=Result.Replace('\:TIPODOCUMENTO\','\' + Uppercase(TipoDocumentoDir) + '\',[rfignoreCase,rfReplaceAll]);
  end;
  Result:=Result.Replace(':ANNO',R180Anno(DatiVariabili.Dal).ToString,[rfignoreCase,rfReplaceAll]); //Es. C:\TEMP\:T430DITTA\2017\:MESE\
  Result:=Result.Replace(':MESE',R180LPad(R180Mese(DatiVariabili.Dal).ToString,2,'0'),[rfignoreCase,rfReplaceAll]);//Es. C:\TEMP\:T430DITTA\2017\05\
  s:=Result;                                            //Es. C:\TEMP\CEDOLINI\:T430DITTA\2017\05\
  s:=Copy(s,Pos('\:',s));                               //Es. \:T430DITTA\2017\05\
  while Pos('\:',s) > 0 do
  begin
    Variabile:=Copy(s,2);                               //Es. :T430DITTA\2017\05\
    Variabile:=Copy(Variabile,1,Pos('\',Variabile) - 1);//Es. :T430DITTA
    if not R180In(Copy(Variabile,2,4),['T430','P430']) then
    begin
      RErrMsg:=Format(A000MSG_A210_ERR_FMT_VAR_PATH,[Variabile]);
      Break;
    end;
    NomeCampo:=Copy(Variabile,2);                       //Es. T430DITTA
    selCols.Close;
    selCols.SetVariable('TABELLA','V430_STORICO');
    selCols.SetVariable('NOME_CAMPO',NomeCampo);
    selCols.Open;
    if selCols.RecordCount = 0 then
    begin
      RErrMsg:=Format(A000MSG_A210_ERR_FMT_VAR_PATH_NO_ANAG,[Variabile]);
      Break;
    end;
    VariabiliAna:=VariabiliAna + IfThen(VariabiliAna <> '',',') + NomeCampo;
    (*Per effettiva sostituzione in P500
    Individuare tipo per eventuale conversione (date->string,integer->string
    Impostare limite caratteri cartella)
    Eventualmente pulire da caratteri speciali*)
    s:=s.Replace(Variabile + '\','x\',[rfignoreCase,rfReplaceAll]);//Es. \x\2017\05\
    s:=Copy(s,Pos('\:',s));
  end;
  if RErrMsg <> '' then
    exit;
end;

procedure TA210FRegoleArchiviazioneDocMW.CtrlCampi(const PCampi:String; var RErrMsg, VariabiliAna, VariabiliXml: String);
var lstCampi:TStringList;
    i:Integer;
    NomeCampoAna,NomeCampoXml:String;
begin
  RErrMsg:='';
  VariabiliAna:='';
  VariabiliXml:='';
  lstCampi:=TStringList.Create;
  try
    lstCampi.CommaText:=PCampi.ToUpper;
    for i:=0 to lstCampi.Count - 1 do
    begin
      if Pos('=',lstCampi.Strings[i]) <= 0 then
      begin
        RErrMsg:=Format(A000MSG_A210_ERR_FMT_ELENCO_NO_UGUALE,[lstCampi.Strings[i]]);
        Break;
      end;
      NomeCampoAna:=Trim(Copy(lstCampi.Strings[i],1,Pos('=',lstCampi.Strings[i]) - 1));
      NomeCampoXml:=Trim(Copy(lstCampi.Strings[i],Pos('=',lstCampi.Strings[i]) + 1));
      if NomeCampoAna = '' then
      begin
        RErrMsg:=Format(A000MSG_A210_ERR_FMT_ELENCO_NO_CAMPO_ANA,[lstCampi.Strings[i]]);
        Break;
      end;
      if NomeCampoXml = '' then
      begin
        RErrMsg:=Format(A000MSG_A210_ERR_FMT_ELENCO_NO_CAMPO_XML,[lstCampi.Strings[i]]);
        Break;
      end;
      if (NomeCampoAna[1] = '$') and (NomeCampoAna[Length(NomeCampoAna)] = '$') then
      begin
        if NomeCampoAna <> '$DATA_CHIUSURA_AUT$' then
        begin
          RErrMsg:=Format(A000MSG_A210_ERR_FMT_ELENCO_VAR_SCON,[NomeCampoAna]);
          Break;
        end;
      end
      else
      begin
        selCols.Close;
        selCols.SetVariable('TABELLA','T030_ANAGRAFICO');
        selCols.SetVariable('NOME_CAMPO',NomeCampoAna);
        selCols.Open;
        if selCols.RecordCount = 0 then
        begin
          selCols.Close;
          selCols.SetVariable('TABELLA','V430_STORICO');
          selCols.SetVariable('NOME_CAMPO',NomeCampoAna);
          selCols.Open;
          if selCols.RecordCount = 0 then
          begin
            RErrMsg:=Format(A000MSG_A210_ERR_FMT_ELENCO_NO_ANAG,[NomeCampoAna]);
            Break;
          end;
        end;
      end;
      VariabiliAna:=VariabiliAna + IfThen(VariabiliAna <> '',',') + NomeCampoAna;
      VariabiliXml:=VariabiliXml + IfThen(VariabiliXml <> '',',') + NomeCampoXml;
    end;
  finally
    lstCampi.Free;
  end;
  if RErrMsg <> '' then
    exit;
end;

function TA210FRegoleArchiviazioneDocMW.GetPathArchiviazioneTemp(const PPath:String; var RErrMsg:String):String;
var
  PosInizioVar,PosSlashParametro:Integer;
  TempPath,VariabiliAna:String;
  DatiVariabili:TDatiVariabili;
begin
  Result:=IncludeTrailingPathDelimiter(PPath);
  PosInizioVar:=Pos('\:',Result);
  if PosInizioVar = 0 then
  begin
    RErrMsg:=A000MSG_A210_ERR_TEMP_PATH_NON_VALIDO;
    exit;
  end;
  PosSlashParametro:=Pos('\',Result,PosInizioVar+1);
  TempPath:=Copy(Result,1,PosSlashParametro);
  TempPath:=GetPath(TempPath,DatiVariabili,RErrMsg,VariabiliAna);
  if RErrMsg <> '' then
    TempPath:=IncludeTrailingPathDelimiter(PPath);
  Result:=TempPath;
end;

function TA210FRegoleArchiviazioneDocMW.EseguiInviaViaSFTP:Boolean;
begin
  Result:=not ((Trim(selI210.FieldByName('SERVER_SFTP').AsString) = '') and
               (Trim(selI210.FieldByName('USERNAME_SFTP').AsString) = '') and
               (Trim(selI210.FieldByName('PASSWORD_SFTP').AsString) = '') and
               (Trim(selI210.FieldByName('DIR_ARCH_SFTP').AsString) = '') and
               (Trim(selI210.FieldByName('PATH_PSCP').AsString) = ''));
end;

function TA210FRegoleArchiviazioneDocMW.InviaViaSFTP(var RErrMsg:String):Boolean;
var
  sPSCPPath,sSFTPHost,sSFTPUsername,sSFTPPassword,sSFTPRootDir:String;
  sPSCPArgs:String;
  sDirRootLocale:String;
  R180SyncProcessExecResults:T180SyncProcessExecResults;
begin
  RErrMsg:='';

  sSFTPHost:=Trim(selI210.FieldByName('SERVER_SFTP').AsString);
  sSFTPUsername:=Trim(selI210.FieldByName('USERNAME_SFTP').AsString);
  sSFTPPassword:=Trim(R180Decripta(selI210.FieldByName('PASSWORD_SFTP').AsString,A210PSW_CRYPT_PASSPHRASE));
  sSFTPRootDir:=Trim(selI210.FieldByName('DIR_ARCH_SFTP').AsString);

  if (sSFTPHost = '') or (sSFTPUsername = '') or (sSFTPUsername = '') or (sSFTPRootDir = '') then
  begin
    RErrMsg:=A000MSG_A210_ERR_NO_IMPOSTAZIONI_SFTP;
    Result:=false;
    exit;
  end;

  sPSCPPath:=selI210.FieldByName('PATH_PSCP').AsString;
  if (Trim(sPSCPPath) = '') or (not FileExists(sPSCPPath)) then
  begin
    RErrMsg:=format(A000MSG_A210_ERR_PSCP_NO_VALIDO, [sPSCPPath]);
    Result:=false;
    Exit;
  end;

  sDirRootLocale:=GetPathArchiviazioneTemp(selI210.FieldByName('PATH_FILE').AsString,RErrMsg);
  if RErrMsg <> '' then
  begin
    Result:=false;
    exit;
  end;

  try
    if not DirectoryExists(sDirRootLocale) then // non deve accadere
    begin
      RErrMsg:=Format(A000MSG_A210_ERR_NO_DIRECTORY_LOCALE,[sDirRootLocale]);
      Result:=false;
      Exit;
    end;

    // Verifico che la cartella da spedire contenga solo file XML e PDF (è lo stesso controllo
    // impiegato per verificare se una directory è eliminabile)
    if not IsDirectoryEliminabile(sDirRootLocale) then
    begin
      RErrMsg:=Format(A000MSG_A210_ERR_DIR_SPORCA,[sDirRootLocale]);
      Result:=false;
      Exit;
    end;

    sPSCPArgs:='-batch -l ' + sSFTPUsername + ' -pw ' + sSFTPPassword + ' -r ' +
                sDirRootLocale + ' ' + sSFTPHost + ':' + sSFTPRootDir;
    R180SyncProcessExecResults:=AvviaPSCP(sPSCPPath,sPSCPArgs);
    if R180SyncProcessExecResults.CodiceUscita <> 0 then
    begin
      RErrMsg:=Format(A000MSG_A210_ERR_ERRORE_PSCP,[sDirRootLocale, R180SyncProcessExecResults.DatiStdErr]);
      Result:=false;
      Exit;
    end;
    Result:=true;
  except
    on E:Exception do
    begin
      RErrMsg:=Format(A000MSG_A210_ERR_ERRORE_SFTP,[E.Message]);
      Result:=false;
    end;
  end;
end;

function TA210FRegoleArchiviazioneDocMW.IsDirectoryEliminabile(Path:String):Boolean;
var
 SearchRecord:TSearchRec;
 Eliminabile:Boolean;
 EstensioneAttuale,NomeCompletoAttuale:String;
begin
   Path:=IncludeTrailingPathDelimiter(Path);
  (* Una directory è eliminabile solo se esiste e pecorrendola ricorsivamente
   tutti i file hanno estensione pdf, xml o json*)
   if DirectoryExists(Path) then
   begin
     try
       try
         Eliminabile:=true;
         FindFirst(Path + '*',faAnyFile,SearchRecord);
         repeat
           EstensioneAttuale:='';
           NomeCompletoAttuale:=SearchRecord.Name;
           if (SearchRecord.Attr = faDirectory) then
           begin
             if (NomeCompletoAttuale <> '.') and (NomeCompletoAttuale <> '..') then
               Eliminabile:=IsDirectoryEliminabile(Path + NomeCompletoAttuale);
           end
           else
           begin
             EstensioneAttuale:=Lowercase(ExtractFileExt(NomeCompletoAttuale));
             if (EstensioneAttuale <> '.pdf') and (EstensioneAttuale <> '.xml') and (EstensioneAttuale <> '.json') then
               Eliminabile:=false;
           end;
         until ((FindNext(SearchRecord) <> 0) or (not Eliminabile));

       except
         Eliminabile:=false;
       end;
     finally
       FindClose(SearchRecord);
     end;
   end
   else
   begin
     Eliminabile:=false;
   end;
   Result:=Eliminabile;
end;

procedure TA210FRegoleArchiviazioneDocMW.SvuotaCartelleArchiviazioneTemp(var RErrMsg:String);
var PathTemp:String;
begin
  RErrMsg:='';

  if selI210.FieldByName('SVUOTA_DIRECTORY').AsString <> 'S' then
    exit;

  // Determino il path temporaneo
  PathTemp:=GetPathArchiviazioneTemp(selI210.FieldByName('PATH_FILE').AsString,RErrMsg);
  if RErrMsg <> '' then
    exit;

  if DirectoryExists(PathTemp) then
  begin
   if not IsDirectoryEliminabile(PathTemp) then
   begin
     RErrMsg:=Format(A000MSG_A210_ERR_DIR_NO_CANCELLA,[PathTemp]);
     exit;
   end;
   // Se il percorso da eliminare è valido e l'utente ha acconsentito all'eliminazione e
   // il percorso contiene solo file XML e PDF, lo posso eliminare.
   TDirectory.Delete(PathTemp,true);
   if DirectoryExists(PathTemp) then // Se la cancellazione fallisce
     RErrMsg:=Format(A000MSG_A210_ERR_DIR_ERR_CANCELLA,[PathTemp]);
   if not CreateDir(PathTemp) then
     if not ForceDirectories(PathTemp) then
     begin
       RErrMsg:=Format(A000MSG_A210_ERR_DIR_ERR_CANCELLA,[PathTemp]);
     end;
  end;
end;

procedure TA210FRegoleArchiviazioneDocMW.SetDataRifUltimaElab(const TipoDocumento:String; const DataRif:TDateTime);
begin
  // Se abbiamo sul DB una data più recente di quella nei parametri non effettiamo l'aggiornamento
  if not selI210.FieldByName('DATA_RIF_ULTIMA_ELAB').IsNull then
  begin
    if (DataRif < selI210.FieldByName('DATA_RIF_ULTIMA_ELAB').AsDateTime) then
      Exit;
  end;

  updUltimaDataRifElab.ClearVariables;
  updUltimaDataRifElab.SetVariable('APPLICAZIONE', Parametri.Applicazione);
  updUltimaDataRifElab.SetVariable('TIPO_DOCUMENTO',TipoDocumento);
  updUltimaDataRifElab.SetVariable('DATA_RIF_ULTIMA_ELAB',DataRif);
  updUltimaDataRifElab.Execute;
  SessioneOracle.Commit;
end;

function TA210FRegoleArchiviazioneDocMW.GetDataCreazioneRegistro: TDateTime;
var temp: String;
    JsonData: TJsonValue;
    fs: TFormatSettings;
begin
  Result:=DATE_NULL;
  if not Assigned(RegistroArchiviazione) then
    Exit;

  temp:=StringReplace(RegistroArchiviazione.Pairs[0].JsonString.ToString, '"', '', [rfReplaceAll]);

  fs:=TFormatSettings.Create;
  fs.DateSeparator:='/';
  fs.ShortDateFormat:='dd/MM/yyyy';
  fs.TimeSeparator:='.';
  fs.ShortTimeFormat:='hh.mm';
  fs.LongTimeFormat:='hh.mm.ss';

  if RegistroArchiviazione.TryGetValue(temp + '.datacreazione', JsonData) then
    Result:=StrToDateTime(JsonData.Value, fs);
end;

function TA210FRegoleArchiviazioneDocMW.GetDataRifUltimaElab:TDateTime;
begin
  Result:=DATE_NULL;
  if not selI210.FieldByName('DATA_RIF_ULTIMA_ELAB').IsNull then
    Result:=selI210.FieldByName('DATA_RIF_ULTIMA_ELAB').AsDateTime;
end;

//Gestione file di metadati in formato json
//------------------------------------------------------
function TA210FRegoleArchiviazioneDocMW.GetJSONRegolaSQL(const RegolaSQL: String; var RErrMsg: String): TJSONObject;
var i: Integer;
begin
  RErrMsg:='';
  Result:=TJSONObject.Create(nil);
  try
  with selJSON do
  begin
    Close;
    SQL.Text:=RegolaSQL;
    Open;

    if RecordCount = 0 then //devo trovare almeno un record
    begin
      RErrMsg:=A000MSG_A210_ERR_JSON_NO_RECORD;
      Exit;
    end;
    if RecordCount > 1 then //devo trovare un solo record
    begin
      RErrMsg:=A000MSG_A210_ERR_JSON_TROPPI_RECORD;
      Exit;
    end;
    if FieldCount = 0 then  //ci deve essere almeno una colonna
    begin
      RErrMsg:=A000MSG_A210_ERR_JSON_NO_FIELDS;
      Exit;
    end;

    //creo l'oggetto json
    for i:=0 to FieldCount-1 do
      Result.AddPair(TJSONPair.Create(TJSONString.Create(Fields[i].FieldName),
                                          TJSONString.Create(Fields[i].AsString)));
    Close;
  end;
  except
    on E: Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

procedure TA210FRegoleArchiviazioneDocMW.CreaFileJSON(const RegolaSQL,DocumentoJSON: String; var RErrMsg:String);
//esegue la query RegolaSQL passata come parametro sul ds selJSON (deve ritornare 1 solo record), crea il json
//fieldname=fieldvalue e lo salva su file nel path specificato nel parametro DocumentoJSON, messaggi di
//errori/eccezioni ritornati nel parametro ErrMsg
var JSONObject: TJSONObject;
begin
  try
    RErrMsg:='';
    JSONObject:=GetJSONRegolaSQL(RegolaSQL, RErrMsg);
    if RErrMsg <> '' then
      Exit;
    try
      //scrivo su file l'oggetto json (se non è presente lo crea, se già presente lo sovrascrive)
      TFile.WriteAllText(DocumentoJSON, JSONObject.ToString);
    finally
      FreeAndNil(JSONObject);
    end;
  except
    on E: Exception do
      RErrMsg:=E.Message;
  end;
end;

function TA210FRegoleArchiviazioneDocMW.IsMetadatiJSON: Boolean;
begin
  Result:=False;

  if selI210.Active then
    if selI210.RecordCount > 0 then
      if selI210.FieldByName('TIPO_FILE_METADATI').AsString = 'J' then
        Result:=True;
end;

//Gestione registro documenti archiviati in formato json
//------------------------------------------------------
procedure TA210FRegoleArchiviazioneDocMW.CreaRegistroJSON(Intestazione: String; Data: TDateTime);
// inizializza il registro dei documenti archiviati e crea la testata (fissa)
var JsonDocumento: TJSONObject;
    JsonLista: TJSONArray;
begin
  if Assigned(RegistroArchiviazione) then
    FreeAndNil(RegistroArchiviazione);

  RegistroArchiviazione:=TJSONObject.Create;
  JsonLista:=TJSONArray.Create;

  JsonDocumento:=TJSONObject.Create;
  with JsonDocumento do
  begin
    AddPair('datacreazione', FormatDateTime('dd/mm/yyyy hh.mm.ss', Data));
    AddPair('listadocumenti', JsonLista);
  end;

  RegistroArchiviazione.AddPair(intestazione, JsonDocumento);
end;

procedure TA210FRegoleArchiviazioneDocMW.AddDocumentoJSON(IdDocumento: Integer);
// aggiunge un documento salvato su T960 al registro eseguendo la regola SQL salvata in
// selI210.FieldByName('CAMPI_XML')
var JsonLista: TJsonValue;
    JsonDocumento: TJSONObject;
    RegolaSql, ErrMsg, temp: String;
begin
  if not Assigned(RegistroArchiviazione) then
    raise Exception.Create('Registro di archiviazione non creato');

  RegolaSQL:=Trim(selI210.FieldByName('CAMPI_XML').AsString);

  if RegolaSQL = '' then
   Exit;

  RegolaSQL:=RegolaSQL.Replace(':ID', IdDocumento.ToString);
  JsonDocumento:=GetJSONRegolaSQL(RegolaSQL, ErrMsg);

  if ErrMsg <> '' then
    raise Exception.Create(ErrMsg);

  temp:=StringReplace(RegistroArchiviazione.Pairs[0].JsonString.ToString, '"', '', [rfReplaceAll]);

  if RegistroArchiviazione.TryGetValue(temp + '.listadocumenti', JsonLista) then
    (JsonLista as TJSONArray).AddElement(JsonDocumento)
  else
    raise Exception.Create('Percorso per l''inserimento del documento nel registro in formato json non trovato');
end;

function TA210FRegoleArchiviazioneDocMW.GetStringaRegistroJSON: String;
begin
  Result:='';
  if not Assigned(RegistroArchiviazione) then
    Exit;
  Result:=TJson.Format(RegistroArchiviazione)
end;

function TA210FRegoleArchiviazioneDocMW.SalvaRegistroSuFile(FullPath: String): Boolean;
var LRegistro: String;
begin
  LRegistro:=GetStringaRegistroJSON;
  if LRegistro <> '' then
  begin
    TFile.WriteAllText(FullPath, LRegistro);
    Result:=True;
  end
  else
    Result:=False;
end;

function TA210FRegoleArchiviazioneDocMW.GetFileBase64(FullPath: String): String;
var Stream: TMemoryStream;
    Base64: TBase64Encoding;
begin
  Stream:=TMemoryStream.Create;
  try
    Stream.LoadFromFile(FullPath);
    Base64:=TBase64Encoding.Create(0);
    try
      Result:=Base64.EncodeBytesToString(Stream.Memory, Stream.Size);
    finally
      Base64.Free;
    end;
  finally
    FreeAndNil(Stream);
  end;
end;

function TA210FRegoleArchiviazioneDocMW.GetSHA256hex(FullPath: String): String;
begin
  Result:=THashSHA2.GetHashStringFromFile(FullPath, SHA256);
end;

procedure TA210FRegoleArchiviazioneDocMW.InviaRegistro(FullPathTemp: String; IdDocumento: Integer);
// invia il registro creato al sistema di archiviazione sostitutiva
var Hash: String;
    Result: String;
begin
  Hash:=GetSHA256hex(FullPathTemp);

  with selScript do
  begin
    SetVariable('IDT960', IdDocumento);
    SetVariable('HASH', Hash);
    Execute;
    Result:=selScript.GetVariable('RESULT');
  end;

  if Result.Substring(0,2) = 'OK' then
    RegistraMsg.InserisciMessaggio('I', Result.Substring(3))
  else
    raise Exception.Create(Result.Substring(3));
end;

end.
