unit B011UAllineamentoServer;
(*
      ---- INIZIO STRUTTURA DEL FILE B011PAllineamentoServer.ini:
      Indicare i files che si vogliono aggiornare sui clients nel formato: '@Sorgente#Destinazione'.
      I File indicati devono risiedere nella stessa cartella del programma di aggiornamento...
      @A002PAnagrafe.exe#A002PAnagrafe.exe
      @P001Standard.bpl#P001Standard.bpl
      ---- FINE STRUTTURA DEL FILE B011PAllineamentoServer.ini:
*)
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, shellApi, Variants, C180FunzioniGenerali;

type

  TVersioni = Record
    sSourceName: string;
    sTargetName: string;
    bDaCopiare:boolean; //True = il file deve essere allinenato;  False = il file non deve essere allineato.
  end;

  TFileEsistenti = Record
    sVecchioPercorso: string;
    sNuovoPercorso: string;
  end;

  TFileTemporanei = Record
    sPercorsoTemp: string;
    sPercorsoTarget: string;
  end;

  TB011FAllineamentoServer = class(TForm)
    PrbVersioni: TProgressBar;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    bPv_Anomalia: boolean; //Variabile generale di errore... indica che si è verificato un errore tale da interrompere l'operazione di allineamento
    sPv_ExeFileName:string;
    xPv_LogFile: TextFile;
    sPv_PercorsoSource, sPv_PercorsoTarget: string;
    LogOK:Boolean;
    procedure CompareFile(var InformazioniFile: TVersioni);
    procedure AllineaVersioni;
    procedure ScriviFileLog(sText:string);
    procedure VerificaNomeTarget(var sNome:string; var sPercorso:string; sPrefissoTemp:string; bCreaCartella: boolean);
  public
    { Public declarations }
  end;

var
  B011FAllineamentoServer: TB011FAllineamentoServer;
const
  sNomeFileIni:string  = 'B011PAllineamentoServer'; //Si trova sul server
  sNomeFileLog:string  = 'B011PAllineamentoServer.log'; //Si trova in locale

implementation

{$R *.DFM}

procedure TB011FAllineamentoServer.FormCreate(Sender: TObject);
begin
  LogOK:=True;
  bPv_Anomalia:=false;
  sPv_ExeFileName:='';
  PrbVersioni.Min:=0;
  PrbVersioni.Position:=0;
  //Imposto il percorso del server
  sPv_PercorsoSource:=ExtractFilePath(Application.ExeName);
  //Imposto il percorso del client
  sPv_PercorsoTarget:=GetCurrentDir + '\';
  //Cancello l'eventuale file di Log in locale, se già presente
  try
    if FileExists(sNomeFileLog) then
      DeleteFile(sNomeFileLog);
  except
  end;
  //Ricreo il file di Log
  try
    AssignFile(xPv_LogFile, sNomeFileLog);
    Rewrite(xPv_LogFile);
  except
    LogOK:=False;
  end;
  ScriviFileLog('***** Data inizio operazione: ' + formatdatetime('dddd dd mmmm yyyy hh:nn:ss', Now) + ' *****');
end;

procedure TB011FAllineamentoServer.FormActivate(Sender: TObject);
begin

  try
    AllineaVersioni; //=================>>> Eseguo il controllo di versioni...
  except
    on E:Exception do
    begin
      ScriviFileLog('Exception: ' + E.Message);
    end;
  end;

  PrbVersioni.Position:=PrbVersioni.Max;

  //Termino l'applicazione
  Application.Terminate;

end;

procedure TB011FAllineamentoServer.ScriviFileLog(sText:string);
begin
  //Scrivo i dati dall'array al file...
  if LogOK then
    try
      Writeln(xPv_LogFile, sText);
    except
      LogOK:=False;
    end;
end;

procedure TB011FAllineamentoServer.CompareFile(var InformazioniFile: TVersioni);
  { Helper function to get the actual file version information }
var
  iFileSizeSource, iFileSizeTarget: integer;
  dDataModificaSource, dDataModificaTarget: TDateTime;
  IFileHandle:NativeUInt;
  Attrs:Integer;
  F:TSearchRec;
begin
  ScriviFileLog('Inizio lettura informazioni');
  //Dimensione dei file sorgente
  ScriviFileLog('FILE SORGENTE:');
  Attrs:=FileGetAttr(InformazioniFile.sSourceName);
  bPv_Anomalia:=true;
  if Attrs >= 0 then
  begin
    if FindFirst(InformazioniFile.sSourceName, Attrs, F) = 0 then
    begin
      ScriviFileLog('   Handle: ' + inttostr(F.FindHandle));
      ScriviFileLog('   Data: ' + formatdatetime('dd/mm/yyyy hh:nn:ss',FileDateToDateTime(F.Time)));
      ScriviFileLog('   Dimensioni: ' + inttostr(F.Size));
      iFileSizeSource:=F.Size;
      dDataModificaSource:=FileDateToDateTime(F.Time);
      bPv_Anomalia:=False;
    end;
    FindClose(F);
  end;
  if bPv_Anomalia then
  begin
    ScriviFileLog('   Impossibile reperire informazioni dal file sorgente');
    exit;
  end;
  //Dimensione dei file destinazione
  ScriviFileLog('FILE DESTINAZIONE:');
  Attrs:=FileGetAttr(InformazioniFile.sTargetName);
  bPv_Anomalia:=true;
  if Attrs >= 0 then
  begin
    if FindFirst(InformazioniFile.sTargetName, Attrs, F) = 0 then
    begin
      bPv_Anomalia:=False;
      ScriviFileLog('   Handle: ' + inttostr(F.FindHandle));
      ScriviFileLog('   Data: ' + formatdatetime('dd/mm/yyyy hh:nn:ss',FileDateToDateTime(F.Time)));
      ScriviFileLog('   Dimensioni: ' + inttostr(F.Size));
      iFileSizeTarget:=F.Size;
      dDataModificaTarget:=FileDateToDateTime(F.Time);
    end;
    FindClose(F);
  end;
  if bPv_Anomalia then
  begin
    ScriviFileLog('   Impossibile reperire informazioni dal file destinatario');
    exit;
  end;
  iFileHandle:=FileOpen(InformazioniFile.sTargetName,fmOpenWrite);
  if iFileHandle = -1 then
  begin
    bPv_Anomalia:=True;
    ScriviFileLog('   File destinatario in uso: impossibile proseguire nell''allineamento');
    exit;
  end;
  FileClose(iFileHandle);
  ScriviFileLog('Fine lettura informazioni');
  //Confronto le informazioni sulla data di creazione e sulla dimensione del file Sorgente con
  //le informazioni del file destinazione...
  if (iFileSizeSource = iFileSizeTarget) and
     (dDataModificaSource = dDataModificaTarget) then
  begin
    ScriviFileLog('==>   ALLINEAMENTO NON NECESSARIO   <==');
    InformazioniFile.bDaCopiare:=false;    //sono uguali per cui non deve essere copiato.
  end
  else
    ScriviFileLog('==>   ALLINEAMENTO NECESSARIO   <==');
end;

procedure TB011FAllineamentoServer.AllineaVersioni;
var
  sDep, sNome, sPercorso: string;
  i, n :integer;
  F: TextFile;
  aElencoFile: array of TVersioni;
  aElencoFileEsistenti: array of TFileEsistenti;
  aElecoFileTemporaneiCopiati: array of TFileTemporanei;
  sTimeStamp:string;
  bRemoveDir:boolean;
  sOldVersion:string;
  Attrs:integer;
  sr, FDir: TSearchRec;
begin
  //Verifico l'esistenza del file INI che contiene l'elenco dei file che si desiderano affrontare...
  if (not FileExists(sPv_PercorsoSource + sNomeFileIni + '.ini')) and (FileExists(sPv_PercorsoSource + sNomeFileIni + '.ori')) then
    CopyFile(PChar(sPv_PercorsoSource + sNomeFileIni + '.ori'),PChar(sPv_PercorsoSource + sNomeFileIni + '.ini'),False);
  if not FileExists(sPv_PercorsoSource + sNomeFileIni + '.ini') then
  begin
    ScriviFileLog('');
    ScriviFileLog('Non esiste il file INI ''' + sPv_PercorsoSource + sNomeFileIni + '.ini''');
    PrbVersioni.Max:=1;
    PrbVersioni.Position:=1;
    exit;
  end;

  //Procedo al caricamento dei nomi di file da allineare
  sDep:='';
  setLength(aElencoFile, 0);
  setLength(aElencoFileEsistenti, 0);
  setLength(aElecoFileTemporaneiCopiati, 0);

  AssignFile(F, sPv_PercorsoSource + sNomeFileIni + '.ini');
  Reset(F);
  while not Eof(F) do
  begin
    //Leggo le righe del file in una variabile di appoggio (sDep);
    Readln(F, sDep);
    sDep:=trim(sDep);
    if (length(sDep) > 0) then  //Se sDep contiene qlc.
      if (Pos('#',sDep) > 0) and (Copy(sDep,1,1) = '@') then //si tratta di una riga che contiene i nomi dei file da controllare...
      begin
      if FindFirst(sPv_PercorsoSource + trim(copy(sDep,2, Pos('#',sDep) - 2)),0,FDir) = 0 then
        repeat
          setLength(aElencoFile, Length(aElencoFile) + 1);
          aElencoFile[Length(aElencoFile)-1].sSourceName:=R180GetFilePath(sPv_PercorsoSource + trim(copy(sDep,2, Pos('#',sDep) - 2)),True) + FDir.Name;
          aElencoFile[Length(aElencoFile)-1].sTargetName:=R180GetFilePath(trim(copy(sDep,Pos('#',sDep) + 1, length(sDep))),True) + FDir.Name;
          aElencoFile[Length(aElencoFile)-1].bDaCopiare:=true;
        until FindNext(FDir) <> 0;
        FindClose(FDir);
      end;
  end;

  if length(aElencoFile) = 0 then
  begin
    ScriviFileLog('Il file INI ''' + sPv_PercorsoSource + sNomeFileIni + '.ini'' non contiene nessun nome di file da allineare');
    ScriviFileLog('Indicare i file da confrontare nel formato di esempio: @SourceFile#TargetFile');
    PrbVersioni.Max:=1;
    PrbVersioni.Position:=1;
    exit;
  end;

  PrbVersioni.Max:=(length(aElencoFile) * 3) + 1;
  PrbVersioni.Position:=PrbVersioni.Position + 1;
  sTimeStamp:= '@' + FormatDateTime('hhnnss', now);
  sOldVersion:='B012BackupIrisWin\';
  //sOldVersion:='Versione_' + FormatDateTime('yyyymmddhhnnss', now) + '\';

  for i:= 0 to length(aElencoFile) - 1 do
  begin
    ScriviFileLog('');
    ScriviFileLog('CONTROLLO DELLE VERSIONI DEI FILE ''' + aElencoFile[i].sSourceName + ''' - ''' + sPv_PercorsoTarget + aElencoFile[i].sTargetName + '''');
    ForceDirectories(R180GetFilePath(Application.ExeName,True) + R180GetFilePath(aElencoFile[i].sTargetName,True));
    if FileExists(aElencoFile[i].sSourceName) then  //Se esiste il file sorgente
    begin
      //Verifico che il file sorgente non abbia l'attributo di sola lettura
      Attrs:=FileGetAttr(aElencoFile[i].sSourceName);
      if Attrs and faReadOnly > 0 then
      begin
        ScriviFileLog('   File sorgente con attributo di sola lettura: impossibile proseguire nell''allineamento delle versioni.');
        bPv_Anomalia:=True;
      end
      else
      begin
        if FileExists(aElencoFile[i].sTargetName) then  //Se esiste il file destinazione
          CompareFile(aElencoFile[i])
        else
          ScriviFileLog('   Il file sorgente ''' + sPv_PercorsoTarget + aElencoFile[i].sTargetName + ''' non esiste sul client: AGGIORNAMENTO NECESSARIO');
      end;
    end
    else
    begin
      ScriviFileLog('Impossibile trovare il file sorgente ''' + aElencoFile[i].sSourceName + '''');
      bPv_Anomalia:=true;
    end;

    if bPv_Anomalia=true then //Sì è verificata un anomalia tale da non procedere nell'allineamento dei file...
    begin
      ScriviFileLog('==> ERRORE CRITICO: si è verificata un anomalia che non consente la continuazione della procedura di controllo delle versioni <==');
      exit;
    end;

    ScriviFileLog('CONTROLLO DELLE VERSIONI TERMINATO');
    PrbVersioni.Position:=PrbVersioni.Position + 1;

  end;

  bRemoveDir:=false;
  //Se è andato tutto bene, non ci sono state anomalie ed il controllo dei file è andato bene,
  //allora procedo al trasferimento dei file
  for i:=0 to length(aElencoFile) - 1 do
  begin
    if aElencoFile[i].bDaCopiare then
    begin

      B011FAllineamentoServer.Caption:='Allineamento delle versioni in corso...';

      ScriviFileLog('');
      ScriviFileLog('ALLINEAMENTO DELLE VERSIONI DEI FILE ''' + aElencoFile[i].sSourceName + ''' - ''' + sPv_PercorsoTarget + aElencoFile[i].sTargetName + '''');
      if FileExists(aElencoFile[i].sTargetName) then //Se il file di destinazione esiste, copio la versione esistente nella cartella contenente le vecchie versioni
      begin
        ScriviFileLog('   Rimozione dei files dalla cartella di salvataggio in corso');
        if not bRemoveDir then
        begin
          if FindFirst(sOldVersion + (*PathDelimiter +*) '\*.*', faAnyFile, sr) = 0 then
          begin
            repeat
              DeleteFile(sOldVersion + (*PathDelimiter*)'\' + sr.Name);
            until FindNext(sr) <> 0;
            FindClose(sr);
            ScriviFileLog('   Rimozione dei files dalla cartella di salvataggio avvenuta con successo');
          end;
          //RemoveDir(sOldVersion); //Cancello l'eventuale directory esistente
          //ScriviFileLog('   Rimozione della cartella ''' + sOldVersion + ''' avvenuto con successo');
          //CreateDir(sOldVersion); //Ricreo la cartella
          ForceDirectories(sPv_PercorsoTarget + sOldVersion); //Ricreo la cartella
          ScriviFileLog('   Creazione della cartella ''' + sOldVersion + ''' avvenuto con successo');
          bRemoveDir:=true;
        end;

        setLength(aElencoFileEsistenti,Length(aElencoFileEsistenti) + 1);
        aElencoFileEsistenti[Length(aElencoFileEsistenti)-1].sVecchioPercorso:= sPv_PercorsoTarget + aElencoFile[i].sTargetName;
        aElencoFileEsistenti[Length(aElencoFileEsistenti)-1].sNuovoPercorso:= sPv_PercorsoTarget + sOldVersion + aElencoFile[i].sTargetName;
        sNome:=sOldVersion + aElencoFile[i].sTargetName;
        VerificaNomeTarget(sNome, sPercorso, '', True);  //se non esiste la cartella destinazione la creo..
        CopyFile(PChar(aElencoFileEsistenti[Length(aElencoFileEsistenti)-1].sVecchioPercorso), PChar(aElencoFileEsistenti[Length(aElencoFileEsistenti)-1].sNuovoPercorso) , True);
        ScriviFileLog('   Copia della vecchia versione di ''' + aElencoFileEsistenti[Length(aElencoFileEsistenti)-1].sVecchioPercorso + ''' nella cartella ''' + aElencoFileEsistenti[Length(aElencoFileEsistenti)-1].sNuovoPercorso + ''' avvenuta con successo');
        DeleteFile(aElencoFileEsistenti[Length(aElencoFileEsistenti)-1].sVecchioPercorso);
        ScriviFileLog('   Cancellazione della vecchia versione di ''' + aElencoFileEsistenti[Length(aElencoFileEsistenti)-1].sVecchioPercorso + ''' avvenuta con successo');
      end;

      //Verifico se il file da copiare è costituito da una sotto cartella, in tal caso trovo il nome del file e lo modifico aggiungendo il prefisso temporaneo 'sTimeStamp'
      sNome:=aElencoFile[i].sTargetName;
      VerificaNomeTarget(sNome, sPercorso, sTimeStamp, True);
      ScriviFileLog('   Assegnazione del nome temporaneo ''' + sPv_PercorsoTarget + sNome + '''');

      ScriviFileLog('   Inizio della copia del file sorgente ''' + aElencoFile[i].sSourceName + ''' nel percorso ''' + sPv_PercorsoTarget + sNome + '''');
      if CopyFile(Pchar(aElencoFile[i].sSourceName), PChar(sNome), True) <> True then
      begin
        ScriviFileLog('   ATTENZIONE: si è verificato un errore nella copia del file sorgente ''' + aElencoFile[i].sSourceName + ''' nel percorso ''' + sPv_PercorsoTarget + sNome + '''');
        ScriviFileLog('   ==> CRITICO: si è verificata un anomalia che non consente la continuazione della procedura di controllo delle versioni <==');
        //elimino tutti gli eventuali file già copiati in precedenza...
        for n:= 0 to length(aElecoFileTemporaneiCopiati) - 1 do
        begin
          if DeleteFile(aElecoFileTemporaneiCopiati[n].sPercorsoTemp) then
            ScriviFileLog('   Rimozione del file ''' + aElecoFileTemporaneiCopiati[n].sPercorsoTemp + ''' avvenuta con successo')
          else
            ScriviFileLog('   Rimozione del file ''' + aElecoFileTemporaneiCopiati[n].sPercorsoTemp + ''' NON avvenuta con successo');
        end;
        //ripristino i file copiati nella cartella contenente le vecchie versioni...
        for n:= 0 to length(aElencoFileEsistenti) - 1 do
        begin
          if (CopyFile(PChar(aElencoFileEsistenti[n].sNuovoPercorso), PChar(aElencoFileEsistenti[n].sVecchioPercorso) , True) = true) and
             (DeleteFile(aElencoFileEsistenti[n].sNuovoPercorso) = True) then
            ScriviFileLog('   Il file ''' + aElencoFileEsistenti[n].sNuovoPercorso + '''è stato rinominato cun successo in ''' + aElencoFileEsistenti[n].sVecchioPercorso + '''')
          else
            ScriviFileLog('   Il file ''' + aElencoFileEsistenti[n].sNuovoPercorso + ''' NON è stato rinominato cun successo in ''' + aElencoFileEsistenti[n].sVecchioPercorso + '''');
        end;

        while DirectoryExists(sOldVersion) do
        begin
          for n:=0 to length(aElencoFileEsistenti) - 1 do
          begin
            sNome:=aElencoFileEsistenti[n].sNuovoPercorso;
            VerificaNomeTarget(sNome, sPercorso, '', False);
            if sPercorso <> '' then
              if RemoveDir(sPercorso) then
                ScriviFileLog('   Rimozione della sottocartella cartella ''' + sPercorso + ''' avvenuta con successo');
          end;
        end;
(*
        //Elimino la cartella padre contenente i file della vecchia versione
        if RemoveDir(sOldVersion) then
          ScriviFileLog('   Rimozione della cartella ''' + sOldVersion + ''' avvenuta con successo')
        else
          ScriviFileLog('   Rimozione della cartella ''' + sOldVersion + ''' NON avvenuta con successo');
*)
        ScriviFileLog('   LA VERSIONE PRECEDENTE DEI FILES E'' STATA RIPRISTINATA CON SUCCESSO');
        exit;

      end;

      setLength(aElecoFileTemporaneiCopiati ,Length(aElecoFileTemporaneiCopiati) + 1);
      aElecoFileTemporaneiCopiati[Length(aElecoFileTemporaneiCopiati)-1].sPercorsoTemp:= sNome;
      aElecoFileTemporaneiCopiati[Length(aElecoFileTemporaneiCopiati)-1].sPercorsoTarget:= aElencoFile[i].sTargetName;
      ScriviFileLog('   La copia del file sorgente ''' + aElencoFile[i].sSourceName + ''' nel percorso ''' + sPv_PercorsoTarget + sNome + ''' è avvenuta con successo');
      ScriviFileLog('ALLINEAMENTO DELLE VERSIONI DEI FILE ''' + aElencoFile[i].sSourceName + ''' - ''' + sPv_PercorsoTarget + aElencoFile[i].sTargetName + ''' TERMINATA');
    end;

    PrbVersioni.Position:=PrbVersioni.Position + 1;

  end;

  //Se è riuscita la copia di tutti i file in locale procedo ad eliminare, da ogni file il prefisso "sTimeStamp"
  //for i:= 0 to length(aElencoFile) - 1 do
  for i:= 0 to length(aElecoFileTemporaneiCopiati) - 1 do
  begin
    begin
      B011FAllineamentoServer.Caption:='Rinomina dei files temporanei in corso...';
      ScriviFileLog('');
      ScriviFileLog('RINOMINA DEL FILE ''' + sPv_percorsoTarget + aElecoFileTemporaneiCopiati[i].sPercorsoTemp + ''' IN ''' + sPv_percorsoTarget + aElecoFileTemporaneiCopiati[i].sPercorsoTarget + '''');
      RenameFile(aElecoFileTemporaneiCopiati[i].sPercorsoTemp,aElecoFileTemporaneiCopiati[i].sPercorsoTarget);
      ScriviFileLog('   Rinomina del file ''' + sPv_percorsoTarget + aElecoFileTemporaneiCopiati[i].sPercorsoTemp + ''' avvenuta con successo');
      ScriviFileLog('RINOMINA DEL FILE TERMINATA');
      PrbVersioni.Position:=PrbVersioni.Position + 1;
    end;
  end;
end;

procedure TB011FAllineamentoServer.FormDestroy(Sender: TObject);
begin
  //Chiudo il file di Log
  ScriviFileLog('');
  ScriviFileLog('***** Data fine operazione: ' + formatdatetime('dddd dd mmmm yyyy hh:nn:ss', Now) + ' *****');
  try
    CloseFile(xPv_LogFile);
  except
  end;
end;

procedure TB011FAllineamentoServer.VerificaNomeTarget(var sNome:string; var sPercorso:string; sPrefissoTemp:string; bCreaCartella:boolean);
begin
  sPercorso:='';
  if (Pos('\', sNome) = 0) then
    sNome:=sPrefissoTemp + sNome
  else
  begin
    while (Pos('\', sNome) > 0) do
    begin
      sPercorso:=sPercorso + Copy(sNome,1,Pos('\', sNome));
      sNome:=Copy(sNome,Pos('\', sNome)+1,Length(sNome));
    end;
    sNome:= sPercorso + sPrefissoTemp + sNome;
    if not DirectoryExists(sPercorso) and (bCreaCartella = True) then
    begin
      ScriviFileLog('   La cartella ''' + sPv_percorsoTarget + sPercorso + ''' non esiste, si procede alla sua creazione');
      if ForceDirectories(sPv_percorsoTarget + sPercorso) then
        ScriviFileLog('   La cartella ''' + sPv_percorsoTarget + sPercorso + ''' è stata creata con successo')
      else
        ScriviFileLog('   Si sono verificati problemi nella creazione della cartella ''' + sPv_percorsoTarget + sPercorso + '''');
    end;
  end;
end;

end.
