unit WC012UVisualizzaFileFM;

interface

uses
  C180FunzioniGenerali, StrUtils, IWGlobal, A000UCostanti,
  SysUtils, Classes, Controls, Forms, IWAppForm, IWApplication,
  IWVCLBaseContainer, IWContainer, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  IWHTMLContainer, IWHTML40Container, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompJQueryWidget, meIWButton,
  IW.Browser.InternetExplorer,
  IWAppCache, IWMimeTypes, IW.CacheStream, System.IOUtils;

type
  TmedpDirectory = (fdUser,    // [UserCacheDir]    (cartella utente)
                    fdGlobal,  // [FilesDir]        (cartella Files)
                    fdHelp);   // [FilesDir]\ PATH_HELP   (sottodirectory di Files)

  TAssociazioniFile = record
    Ext: String;        // estensione file  (es. "pdf")
    MimeType: String;   // tipo MIME        (es. "application/pdf")
    Desc: String;       // descr. file      (es. "File Pdf")
  end;

  TProcedura = procedure of object;

  TWC012FVisualizzaFileFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQVisFile: TIWJQueryWidget;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    btnChiudi: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
  private
    FForm: TIWAppForm;
    FDirectory: TmedpDirectory;
    FNomeFile,
    FTitolo,
    FCartella,
    FFile,
    FExt,
    FMimeType,
    FFileDesc,
    FFileUrl: String;
    FAttivaFrame,
    FExtGestita: Boolean;
    FOnShowFile,
    FOnCloseFile: TProcedura;
    function  CercaEstensione(const Estensione: String): Boolean;
    function  GetDirectory: TmedpDirectory;
    procedure SetDirectory(const Val: TmedpDirectory);
    function  GetTitolo: String;
    procedure SetTitolo(const Val: String);
    function  GetNomeFile: String;
    procedure SetNomeFile(const Val: String);
  public
    function  EsisteFile: Boolean;
    procedure Visualizza;
    property Directory: TmedpDirectory read GetDirectory write SetDirectory;
    property Titolo: String read GetTitolo write SetTitolo;
    property NomeFile: String read GetNomeFile write SetNomeFile;
    property OnShowFile: TProcedura read FOnShowFile write FOnShowFile;
    property OnCloseFile: TProcedura read FOnCloseFile write FOnCloseFile;
  end;

const
  AssociazioniFile: array [0..0] of TAssociazioniFile = (
    //(Ext: '.doc'; MimeType: 'application/msword'; Desc: 'Documento word'),
    //(Ext: '.htm';  MimeType: 'text/html';          Desc: 'File html'),
    //(Ext: '.html'; MimeType: 'text/html';          Desc: 'File html'),
    (Ext: '.pdf';  MimeType: 'application/pdf';    Desc: 'File pdf')
    //(Ext: '.xls'; MimeType: 'application/excel';  Desc: 'File excel'    )
  );

implementation

uses {$IFDEF WEBPJ}      WR100UBase{$ELSE}
     {$IFDEF X001}       WR010UBase{$ELSE}
     {$IFDEF INTRAWEBSVC}WR010UBase{$ELSE}
                         R010UPaginaWeb
     {$ENDIF}{$ENDIF}{$ENDIF},
     A000UInterfaccia;
{$R *.dfm}

procedure TWC012FVisualizzaFileFM.IWFrameRegionCreate(Sender: TObject);
begin
  Parent:=(Self.Owner as TIWAppForm);
  FForm:=(Parent as {$IFDEF WEBPJ}TWR100FBase{$ELSE}{$IFDEF X001}TWR010FBase{$ELSE}{$IFDEF INTRAWEBSVC}TWR010FBase{$ELSE}TR010FPaginaWeb{$ENDIF}{$ENDIF}{$ENDIF});
  FDirectory:=fdUser;
  FNomeFile:='';
  FTitolo:='';
  FCartella:='';
  FFile:='';
  FExt:='';
  FMimeType:='';
  FFileDesc:='';
  FFileUrl:='';
  FExtGestita:=False;
  FAttivaFrame:=(Pos(INI_PAR_FILE_INLINE,W000ParConfig.ParametriAvanzati) > 0);
end;

function TWC012FVisualizzaFileFM.CercaEstensione(const Estensione: String): Boolean;
var
  i: Integer;
begin
  Result:=False;
  FMimeType:='';
  FFileDesc:='';
  for i:=Low(AssociazioniFile) to High(AssociazioniFile) do
  begin
    if Estensione = AssociazioniFile[i].Ext then
    begin
      FMimeType:=AssociazioniFile[i].MimeType;
      FFileDesc:=AssociazioniFile[i].Desc;
      Result:=True;
      Break;
    end;
  end;
end;

function TWC012FVisualizzaFileFM.GetDirectory: TmedpDirectory;
begin
  Result:=FDirectory;
end;

procedure TWC012FVisualizzaFileFM.SetDirectory(const Val: TmedpDirectory);
begin
  FDirectory:=Val;
end;

function TWC012FVisualizzaFileFM.GetTitolo: String;
begin
  Result:=FTitolo;
end;

procedure TWC012FVisualizzaFileFM.SetTitolo(const Val: String);
begin
  FTitolo:=Val;
end;

function TWC012FVisualizzaFileFM.GetNomeFile: String;
begin
  Result:=FNomeFile;
end;

procedure TWC012FVisualizzaFileFM.SetNomeFile(const Val: String);
begin
  if Val = FNomeFile then
    Exit;

  FNomeFile:=Val;

  // determina eventuale directory in cui risiede il file
  FCartella:=ExtractFileDir(FNomeFile);

  // estrae il nome del file senza directory (ma con estensione)
  FFile:=ExtractFileName(FNomeFile);

  // estrae estensione del file
  FExt:=ExtractFileExt(FNomeFile);

  // cerca l'estensionee nell'array per impostare altre proprietà
  FExtGestita:=CercaEstensione(FExt);
end;

function TWC012FVisualizzaFileFM.EsisteFile: Boolean;
var
  ActualPath, FileCompleto: String;
begin
  // determina la posizione file su disco e ne verifica l'esistenza
  { DONE : TEST IW 14 OK }
  case FDirectory of
    fdUser:   ActualPath:=GGetWebApplicationThreadVar.UserCacheDir;
    fdGlobal: ActualPath:=TA000FInterfaccia(gSC).MEDPFilesDir;
    fdHelp:   ActualPath:=TA000FInterfaccia(gSC).MEDPFilesDir + PATH_HELP;
  end;
  FileCompleto:=IncludeTrailingPathDelimiter(ActualPath) + FFile;
  Result:=FileExists(FileCompleto);
end;

procedure TWC012FVisualizzaFileFM.Visualizza;
var
  Cod,ObjH,ObjW,RelPath,xFileName,S: String;
  DlgW,DlgH: Integer;
  FileOk: Boolean;
begin
  // procedura da richiamare in fase di visualizzazione del file
  if Assigned(OnShowFile) then
  begin
    try
      OnShowFile;
    except
      on E: Exception do
        raise Exception.Create(Format('%s.OnShowFile: %s (%s)',[Self.Name,E.Message,E.ClassName]));
    end;
  end;

  { DONE : TEST IW 14 OK }
  // determina url relativa
//  case FDirectory of
//    //TEST_IW_XIV//fdUser:   RelPath:=GGetWebApplicationThreadVar.UserCacheUrlBase;
//    fdUser://TEST_IW_XIV//
//    begin
//      xFileName:=TIWAppCache.NewTempFileName;//StringReplace(TIWAppCache.NewTempFileName,'.tmp','.pdf',[rfReplaceAll]);
//      TFile.Copy(GGetWebApplicationThreadVar.UserCacheDir + FFile, xFileName);
//      FFileUrl:=TIWAppCache.AddFileToCache(GGetWebApplicationThreadVar, xFileName, TIWMimeTypes.GetAsString(mtPDF), ctSession);
//      (*
//      FFileUrl:=TIWAppCache.AddFileToCache(GGetWebApplicationThreadVar, FFile, TIWMimeTypes.GetAsString(mtPDF), ctSession);
//      *)
//      end;
//    //TEST_IW_XIV//fdGlobal: RelPath:='Files/'{gSC.FilesUrl};
//    fdGlobal: FFileUrl:='/Files/'{gSC.FilesUrl} + FFile;//TEST_IW_XIV//
//    //TEST_IW_XIV//fdHelp:   RelPath:='Files/'{gSC.FilesUrl} + PATH_HELP + '/';
//    fdHelp:   FFileUrl:='/Files/'{gSC.FilesUrl} + PATH_HELP + '/' + FFile;//TEST_IW_XIV//
//  end;
//  //TEST_IW_XIV//FFileUrl:=RelPath + FFile;

  (*
  S:=
    Format('MappedURL:%s',[GGetWebApplicationThreadVar.MappedURL]) + CRLF +
    Format('AppUrlBase:%s',[GGetWebApplicationThreadVar.AppUrlBase]) + CRLF +
    Format('InternalUrlBase:%s',[GGetWebApplicationThreadVar.InternalUrlBase]) + CRLF +
    Format('SessionUrlBase:%s',[GGetWebApplicationThreadVar.SessionUrlBase]) + CRLF +
    Format('SessionInternalUrlBase:%s',[GGetWebApplicationThreadVar.SessionInternalUrlBase]) + CRLF +
    Format('ApplicationURL:%s',[GGetWebApplicationThreadVar.ApplicationURL]) + CRLF +
    Format('ReferringURL:%s',[GGetWebApplicationThreadVar.ReferringURL]) + CRLF +
    Format('UserCacheUrlBase:%s',[GGetWebApplicationThreadVar.UserCacheUrlBase]) + CRLF +
  '';

  MappedURL:
  AppUrlBase:/
  InternalUrlBase:/$/
  SessionUrlBase:/TJZujiU6XKMnulyHIbkiCG/
  SessionInternalUrlBase:/TJZujiU6XKMnulyHIbkiCG/$/
  ApplicationURL:http://127.0.0.1:50607
  ReferringURL:http://127.0.0.1:50607/$/start
  UserCacheUrlBase:/$/IrisWEB/TJZujiU6XKMnulyHIbkiCG/'
  *)

  //TEST_IW_XIV//
  case FDirectory of
    fdUser:
    begin
      xFileName:=TIWAppCache.NewTempFileName;
      xFileName:=StringReplace(xFileName,'.tmp',FExt,[rfReplaceAll]);
      RelPath:=GGetWebApplicationThreadVar.UserCacheDir;
      TFile.Copy(IncludeTrailingPathDelimiter(RelPath) + FFile, xFileName);
      //FFileUrl:=TIWAppCache.AddFileToCache(GGetWebApplicationThreadVar, xFileName, TIWMimeTypes.GetAsString(FExt), ctOneTime);
      FFileUrl:=TIWAppCache.AddFileToCache(GGetWebApplicationThreadVar, xFileName, TIWMimeTypes.GetAsString(FExt), ctSession);
    end;
    fdGlobal: FFileUrl:=GGetWebApplicationThreadVar.SessionInternalUrlBase + 'Files/' + FFile;
    fdHelp: FFileUrl:=GGetWebApplicationThreadVar.SessionInternalUrlBase + 'Files/' + PATH_HELP + '/' + FFile;
  end;

  // determina se il file esiste nella directory
  FileOk:=EsisteFile;

  { DONE : TEST IW 14 OK }
  { Problema: usando il tag <object> su Chrome,FF tutto ok, su IE si verifica un'eccezione
    EAbort. Mentre gli altri browser fanno una richiesta con verbo GET per ottenere la risorsa
    all'URL indicato nell'attributo  "data", IE va in HEAD.
    IW12 si comportava come se la richiesta fosse in GET, IW14/IW15 la blocca.
    Quindi IE non riesce ad ottenere risposta alla richiesta.
    Per ora passiamo alla visualizzazione con "window.open()" che va in GET se il browser è IE,
    ma bisognerà tornarci su probabilmente.
    26/06: sostituito con <iframe> in tutti i casi.
  }

  if FAttivaFrame and FExtGestita then
  begin
    FTitolo:=Format('%s - %s',[FTitolo,FFileDesc]);

    // prepara dialog modale
    DlgH:=1280;
    DlgW:=1024;
    (FForm as {$IFDEF WEBPJ}TWR100FBase{$ELSE}{$IFDEF X001}TWR010FBase{$ELSE}TR010FPaginaWeb{$ENDIF}{$ENDIF}).VisualizzajQMessaggio(jQVisFile,DlgH,DlgW,DlgW, Titolo,'#' + Name,True,True,-1);

    // evento dialogbeforeclose per gestire la corretta chiusura del frame:
    // prima della chiusura simula il click sul pulsante "Chiudi" (nascosto)
    Cod:=Format('$("#%s").bind("dialogbeforeclose", function(event, ui) { ' +
                '  SubmitClick("%s", "", true); ' +
                '}); ',
                [Name,btnChiudi.HTMLName]);

    // codice per incorporare il file come oggetto nell'html
    ObjW:=IfThen(GetBrowser is TInternetExplorer,'99%','100%');
    ObjH:='97%'; //IfThen(GetBrowser is TInternetExplorer,'???','97%');

    // verifica esistenza file
    if FileOk then
    begin
      Cod:=Cod + CRLF +
           'var o = $("<iframe />"); ' +
           '$(o).attr("src","' + FFileUrl + '"); ' +
           '$(o).attr("style","border: 0;"); ';
    end
    else
    begin
      // segnalazione file inesistente
      Cod:=Cod + CRLF +
           'var o = $("<p>Impossibile visualizzare il file <pre>' + FFile + '</pre></p>' +
           '<p>Percorso completo:  <pre>' + FFileUrl + '</pre></p>' +
           '<p>Il file non è stato trovato!</p>"); ';
    end;
    Cod:=Cod + CRLF +
           '$(o).attr("width","' + ObjW + '"); ' +
           '$(o).attr("height","' + ObjH + '"); ' +
           '$(o).insertBefore($("#wc012_footer")); ';
    jQVisFile.OnReady.Add(Cod);
  end
  else
  begin
    // impossibile incorporare nel browser il file indicato
    if FileOk then
    begin
      // apre il file in una nuova finestra del browser
      Cod:=Format('wNewWin = window.open("%s","","resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no"); ' +
                  // controllo popup bloccati
                  'if (!wNewWin || (typeof wNewWin == ''undefined'')) { ' +
                  '  /*alert("Verificare che il blocco popup non sia attivo e quindi riprovare!"); */ ' +
                  '} ' +
                  'else { ' +
                  '  wNewWin.focus();' +
                  '}',
                  [FFileUrl]);

      // fix IE: a volte la finestra con il pdf va in background
      // soluzione: si introduce un breve ritardo nell'apertura della finestra
      if GetBrowser is TInternetExplorer then
        Cod:=Format('window.setTimeout(function () { %s }, 300); ',[Cod]);
    end
    else
      Cod:=Format('alert("Impossibile visualizzare il file \"%s\"\r\nPercorso completo:\"%s\"\r\nFile non trovato!");',[FFile,FFileUrl]);

    // esegue il codice javascript
    FForm.AddToInitProc(Cod);

    // chiusura frame immediata
    btnChiudiClick(nil);
  end;
end;

procedure TWC012FVisualizzaFileFM.btnChiudiClick(Sender: TObject);
// chiusura del dialog modale
begin
  if Assigned(OnCloseFile) then
    try
      OnCloseFile;
    except
      on E: Exception do
        raise Exception.Create(Format('%s.OnCloseFile: %s (%s)',[Self.Name,E.Message,E.ClassName]));
    end;
  jQVisFile.OnReady.Text:='$("#WC012FVisualizzaFileFM").hide();';
end;

end.
