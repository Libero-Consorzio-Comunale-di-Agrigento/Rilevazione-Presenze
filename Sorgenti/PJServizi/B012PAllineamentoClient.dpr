program B012PAllineamentoClient;

(*

  Indicare dopo la parola chiave '@EXESERVER=' il percorso dove si trova il file di allineamento versioni lato server
  Indicare dopo la parola chiave '@EXECLIENT=' il nome del file eseguibile che si desidera lanciare sul client dopo il controllo delle versioni
  @EXESERVER=F:\Andrea\B011PAllineamentoServer.exe
  @EXECLIENT=A002PAnagrafe.exe

*)

uses
  SysUtils,
  ShellApi,
  Windows,
  Forms,
  Dialogs,
  Controls;

{$R *.RES}
var MyHandle:integer;
    StartupInfo:TStartupInfo;  //documented as STARTUPINFO
    ProcessInfo: TProcessInformation;  //documented as PROCESS_INFORMATION
    sExeClientName:string;
    sExeServerName:string;
    F:TextFile;
    xPv_LogFile:TextFile;
    sDep:string;
    Eseguito:Boolean;
    Mutex : THandle;
    LogOK:Boolean;

const sIniName='B012PAllineamentoClient';
const sLogName='B012PAllineamentoClient.log';

procedure ScriviLog(sText:string);
begin
  if LogOK then
    try
      Writeln(xPv_LogFile,sText);
    except
      LogOK:=False;
    end;
end;

begin
  LogOK:=True;
  MyHandle:=0;
  Mutex := CreateMutex(nil, True, 'B012PAllineamentoClient');
  if (Mutex = 0) OR (GetLastError = ERROR_ALREADY_EXISTS) then
  begin
    if Mutex <> 0 then
      CloseHandle(Mutex);
    exit;
  end
  else
  try
    Screen.Cursor:=crHourGlass;
    //Cancello l'eventuale file di Log in locale, se già presente
    if FileExists(sLogName) then
      DeleteFile(sLogName);
    //Ricreo il file di Log
    try
      AssignFile(xPv_LogFile, sLogName);
      Rewrite(xPv_LogFile);
    except
      LogOK:=False;
    end;
    ScriviLog('***** Data inizio operazione: ' + formatdatetime('dddd dd mmmm yyyy hh:nn:ss', Now) + ' *****');
    ScriviLog('');
    {Writeln(xPv_LogFile, '***** Data inizio operazione: ' + formatdatetime('dddd dd mmmm yyyy hh:nn:ss', Now) + ' *****');
    Writeln(xPv_LogFile, '');}
    try
      if (not FileExists(sIniName + '.ini')) and (FileExists(sIniName + '.ori')) then
        CopyFile(PChar(sIniName + '.ori'),PChar(sIniName + '.ini'),False);
      if not FileExists(sIniName + '.ini') then
        ScriviLog('Il file ''' + GetCurrentDir + '\' + sIniName + '.ini'' non esiste: IMPOSSIBILE PROSEGUIRE CON L''ALLINEAMENTO DELLE VERSIONI')
        //Writeln(xPv_LogFile, 'Il file ''' + GetCurrentDir + '\' + sIniName + '.ini'' non esiste: IMPOSSIBILE PROSEGUIRE CON L''ALLINEAMENTO DELLE VERSIONI')
      else
      begin
        //Writeln(xPv_LogFile, 'Apertura file ''' + sIniName + '.ini''');
        ScriviLog('Apertura file ''' + sIniName + '.ini''');
        AssignFile(F, sIniName + '.ini');
        Reset(F);
        while not Eof(F) do
        begin
          Readln(F, sDep);
          sDep:=uppercase(trim(sDep));
          if Length(sDep) > 0 then
            if Copy(sDep,1,10) = '@EXESERVER' then
            begin
              sExeServerName:=trim(copy(sdep,Pos('=',sDep) + 1, length(sDep)));
              //Writeln(xPv_LogFile, 'Lettura del percorso SERVER: ''' + sExeServerName + '''');
              ScriviLog('Apertura file ''' + sIniName + '.ini''');
            end
            else if Copy(sDep,1,10) = '@EXECLIENT' then
            begin
              sExeClientName:=trim(copy(sdep,Pos('=',sDep) + 1, length(sDep)));
              //Writeln(xPv_LogFile, 'Lettura del percorso CLIENT: ''' + sExeClientName + '''');
              ScriviLog('Lettura del percorso CLIENT: ''' + sExeClientName + '''');
            end;
        end;
        CloseFile(F);

        if (sExeServerName <> '') and ((sExeClientName <> '') or (ParamCount > 0)) then
        begin
          { Clear the StartupInfo structure }
           FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
          { Initialize the StartupInfo structure with required data.
            Here, we assign the SW_XXXX constant to the wShowWindow field
            of StartupInfo. When specifing a value to this field the
            STARTF_USESSHOWWINDOW flag must be set in the dwFlags field.
            Additional information on the TStartupInfo is provided in the Win32
            online help under STARTUPINFO. }
          with StartupInfo do
          begin
            cb := SizeOf(TStartupInfo); // Specify size of structure
            dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
            wShowWindow := SW_SHOW;
          end;
          if FileExists(sExeServerName) then
          begin
            ScriviLog('Inizio creazione del processo SERVER di aggiornamento');

            if CreateProcess(PChar(sExeServerName),
              nil,nil,nil,FALSE,NORMAL_PRIORITY_CLASS,nil,
              PChar(GetCurrentDir),
              StartupInfo,ProcessInfo) then
              with ProcessInfo do
              begin
                { Wait until the process is in idle. }
                WaitForSingleObjectEx(hProcess, INFINITE, TRUE);
                CloseHandle(hThread); // Free the hThread  handle
                CloseHandle(hProcess);// Free the hProcess handle
                ScriviLog('Il processo SERVER di aggiornamento è terminato con esito positivo');
              end
              else
                ScriviLog('Il processo SERVER di aggiornamento è terminato con esito NEGATIVO');
          end
          else
            ScriviLog('Impossibile trovare il percorso server ''' + sExeServerName + '''');
          end;
      end;
    except
      on E:Exception do
      begin
        ScriviLog( 'EXCEPTION: ' + E.Message);
      end;
    end;

    Eseguito:=False;
    if ParamCount > 0 then
    begin
      //Esegue il file specificato sulla linea di comando
      MyHandle:=ShellExecute(MyHandle,nil,Pchar(ParamStr(1)),nil,nil,SW_SHOWNORMAL);
      case MyHandle of
        0                     :ScriviLog('ERRORE: The operating system is out of memory or resources.');
        ERROR_FILE_NOT_FOUND  :ScriviLog('ERRORE: The specified file was not found.');
        ERROR_BAD_FORMAT	    :ScriviLog('ERRORE: The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).');
        SE_ERR_ACCESSDENIED	  :ScriviLog('ERRORE: The operating system denied access to the specified file.');
        SE_ERR_ASSOCINCOMPLETE:ScriviLog('ERRORE: The filename association is incomplete or invalid.');
        SE_ERR_DDEBUSY	      :ScriviLog('ERRORE: The DDE transaction could not be completed because other DDE transactions were being processed.');
        SE_ERR_DDEFAIL	      :ScriviLog('ERRORE: The DDE transaction failed.');
        SE_ERR_DDETIMEOUT	    :ScriviLog('ERRORE: The DDE transaction could not be completed because the request timed out.');
        SE_ERR_DLLNOTFOUND	  :ScriviLog('ERRORE: The specified dynamic-link library was not found.');
        SE_ERR_NOASSOC	      :ScriviLog('ERRORE: There is no application associated with the given filename extension.');
        SE_ERR_OOM	          :ScriviLog('ERRORE: There was not enough memory to complete the operation.');
        SE_ERR_PNF	          :ScriviLog('ERRORE: The specified path was not found.');
        SE_ERR_SHARE	        :ScriviLog('ERRORE: A sharing violation occurred.');
      else
        Eseguito:=True;
      end;
    end;
    if (not Eseguito) and (Trim(sExeClientName) <> '') then
    begin
      //Esegue il file specificato in @EXECLIENT
      MyHandle:=ShellExecute(MyHandle,nil,Pchar(sExeClientName),nil,nil,SW_SHOWNORMAL);
      case MyHandle of
        0                     :ScriviLog('ERRORE: The operating system is out of memory or resources.');
        ERROR_FILE_NOT_FOUND  :ScriviLog('ERRORE: The specified file was not found.');
        ERROR_BAD_FORMAT	    :ScriviLog('ERRORE: The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).');
        SE_ERR_ACCESSDENIED	  :ScriviLog('ERRORE: The operating system denied access to the specified file.');
        SE_ERR_ASSOCINCOMPLETE:ScriviLog('ERRORE: The filename association is incomplete or invalid.');
        SE_ERR_DDEBUSY	      :ScriviLog('ERRORE: The DDE transaction could not be completed because other DDE transactions were being processed.');
        SE_ERR_DDEFAIL	      :ScriviLog('ERRORE: The DDE transaction failed.');
        SE_ERR_DDETIMEOUT	    :ScriviLog('ERRORE: The DDE transaction could not be completed because the request timed out.');
        SE_ERR_DLLNOTFOUND	  :ScriviLog('ERRORE: The specified dynamic-link library was not found.');
        SE_ERR_NOASSOC	      :ScriviLog('ERRORE: There is no application associated with the given filename extension.');
        SE_ERR_OOM	          :ScriviLog('ERRORE: There was not enough memory to complete the operation.');
        SE_ERR_PNF	          :ScriviLog('ERRORE: The specified path was not found.');
        SE_ERR_SHARE	        :ScriviLog('ERRORE: A sharing violation occurred.');
      end;
    end;

    ScriviLog('');
    ScriviLog('***** Data fine operazione: ' + formatdatetime('dddd dd mmmm yyyy hh:nn:ss', Now) + ' *****');
    try
      CloseFile(xPv_LogFile);
    except
    end;
    if Mutex <> 0 then
      CloseHandle(Mutex); 

  finally
    Screen.Cursor:=crDefault;
  end;
end.



