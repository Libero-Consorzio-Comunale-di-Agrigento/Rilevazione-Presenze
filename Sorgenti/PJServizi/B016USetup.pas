unit B016USetup;

interface

uses
  Windows, Messages, IOUtils, StrUtils, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, StdCtrls, C180FunzioniGenerali, ShellAPI, ExtCtrls,
  CheckLst, Menus, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdFTP, DB, mySQLDbTables, IdExplicitTLSClientServerBase;

type
  TFileDistribuiti = record
    Tipo,NomeFile,Servizio:String;
  end;

  TB016FSetup = class(TForm)
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    N1: TMenuItem;
    Refresh1: TMenuItem;
    IdFTP: TIdFTP;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnLogin: TButton;
    edtDownloadPath: TEdit;
    btnDownloadPath: TButton;
    edtUtente: TEdit;
    edtPassword: TEdit;
    btnDownload: TButton;
    Label1: TLabel;
    lstPacchetti: TListBox;
    edtPathPacchetti: TEdit;
    rgpGruppoCollegamenti: TRadioGroup;
    chklstCollegamenti: TCheckListBox;
    btnCollegamenti: TButton;
    rgpUserCollegamenti: TRadioGroup;
    edtGruppoSetup: TEdit;
    msqlConnessione: TmySQLDatabase;
    selNukeUsers: TmySQLQuery;
    selNukeDownloads: TmySQLQuery;
    chklstDownloads: TCheckListBox;
    StatusBar1: TStatusBar;
    selDownloadUsers: TmySQLQuery;
    btnPathPacchetti: TButton;
    selDownloadVersione: TmySQLQuery;
    memoDownload: TMemo;
    memoPacchetti: TMemo;
    GroupBox1: TGroupBox;
    edtPathAmministrazione: TEdit;
    btnPathAmministrazione: TButton;
    chkAmministrazione: TCheckBox;
    chkIrisWIN: TCheckBox;
    edtPathIrisWIN: TEdit;
    btnPathIrisWIN: TButton;
    chkServizi: TCheckBox;
    edtPathServizi: TEdit;
    btnPathServizi: TButton;
    chkIrisWEB: TCheckBox;
    edtPathIrisWEB: TEdit;
    btnPathIrisWEB: TButton;
    chkWebSvc: TCheckBox;
    edtPathWebSvc: TEdit;
    btnPathWebSvc: TButton;
    Label5: TLabel;
    Label6: TLabel;
    lstServizi: TListBox;
    btnChiudi: TBitBtn;
    StatusBar: TStatusBar;
    GroupBox2: TGroupBox;
    btnScompatta: TBitBtn;
    btnB005: TBitBtn;
    chkServiziStop: TCheckBox;
    chkServiziStart: TCheckBox;
    chkBackup: TCheckBox;
    btnBackup: TBitBtn;
    chkAggDB: TCheckBox;
    btnServiziStop: TBitBtn;
    btnServiziStart: TBitBtn;
    chkIISReset: TCheckBox;
    chkFilesScompattati: TCheckBox;
    chkIrisCloud: TCheckBox;
    edtPathIrisCloud: TEdit;
    btnPathIrisCloud: TButton;
    chkIrisWEBSSO: TCheckBox;
    edtPathIrisWEBSSO: TEdit;
    btnPathIrisWEBSSO: TButton;
    chkIrisAPP: TCheckBox;
    edtPathIrisAPP: TEdit;
    btnPathIrisAPP: TButton;
    chkFrameworkUniGui: TCheckBox;
    procedure edtPathPacchettiExit(Sender: TObject);
    procedure btnPathPacchettiClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnDownloadPathClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure btnCollegamentiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnScompattaClick(Sender: TObject);
    procedure btnPathAmministrazioneClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IdFTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure chkAmministrazioneClick(Sender: TObject);
    procedure btnB005Click(Sender: TObject);
    procedure btnBackupClick(Sender: TObject);
    procedure btnServiziStopClick(Sender: TObject);
    procedure btnServiziStartClick(Sender: TObject);
    procedure chkIISResetClick(Sender: TObject);
  private
    { Private declarations }
    lstFileDistribuiti:TStringList;
    bScompattaFiles:Boolean;
    procedure CaricaFileDistribuiti;
    procedure CaricaPacchetti(Tipo:String);
    procedure CaricaCollegamenti;
    procedure CreaCollegamento(F:String);
    procedure AggiornaDownload(Modulo:String);
    procedure InstallaRuntimeIrisAPP(PathIrisAPP:String);
  public
    { Public declarations }
  end;

var
  B016FSetup: TB016FSetup;

const FileDistribuiti:array [0..27] of TFileDistribuiti =
      ((Tipo:'*';NomeFile:'PrgBase.exe'),
       (Tipo:'*';NomeFile:'HelpAccessori.exe'),
       (Tipo:'AMMINISTRAZIONE';NomeFile:'AggDB.exe';Servizio:''),
       (Tipo:'AMMINISTRAZIONE';NomeFile:'PrgAmm.exe';Servizio:''),
       (Tipo:'IRISWIN';NomeFile:'HelpStipendi.exe';Servizio:''),
       (Tipo:'IRISWIN';NomeFile:'Stipendi.exe';Servizio:''),
       (Tipo:'IRISWIN';NomeFile:'HelpStatoGiuridico.exe';Servizio:''),
       (Tipo:'IRISWIN';NomeFile:'StatoGiuridico.exe';Servizio:''),
       (Tipo:'IRISWIN';NomeFile:'Help.exe';Servizio:''),
       (Tipo:'IRISWIN';NomeFile:'RilPre.exe';Servizio:''),
       (Tipo:'IRISWEB';NomeFile:'RilPreWeb.exe';Servizio:'IrisWEB'),
       (Tipo:'IRISWEBSSO';NomeFile:'IrisWEBSSOWin.exe';Servizio:''),
       (Tipo:'IRISCLOUD'; NomeFile:'IrisCloudPres.exe';Servizio:'IrisCloud'),
       (Tipo:'IRISCLOUD'; NomeFile:'IrisCloudStaGiu.exe';Servizio:'IrisCloud'),
       (Tipo:'IRISCLOUD'; NomeFile:'IrisCloudStipendi.exe';Servizio:'IrisCloud'),
       (Tipo:'IRISAPP'; NomeFile:'IrisAPP.exe';Servizio:'IrisAPP'),
       (Tipo:'WEBSVC'; NomeFile:'WebServices.exe';Servizio:'B021FIRISRESTSVC'),
       (Tipo:'WEBSVC'; NomeFile:'WebUtility.exe';Servizio:'B017FCHECKWEBSERVICES'),
       (Tipo:'SERVIZI';NomeFile:'SchedulStampe.exe';Servizio:'B019FGENERATORESTAMPESRV'),
       (Tipo:'SERVIZI';NomeFile:'AcqGiust.exe';Servizio:'B015FSCARICOGIUSTIFICATIVISRV'),
       (Tipo:'SERVIZI';NomeFile:'AcqTimb.exe';Servizio:'B006FSCARICOSERVICE'),
       (Tipo:'SERVIZI';NomeFile:'AcqTimbEMK.exe';Servizio:''),
       (Tipo:'SERVIZI';NomeFile:'ArchiviazioneSostitutiva.exe';Servizio:''),
       (Tipo:'SERVIZI';NomeFile:'CartellinoSrv.exe';Servizio:''),
       (Tipo:'SERVIZI';NomeFile:'IntAnag.exe';Servizio:'B014INTEGRAZIONEANAGRAFICA'),
       (Tipo:'SERVIZI';NomeFile:'IntAnagGP4.exe';Servizio:''),
       (Tipo:'SERVIZI';NomeFile:'IntECM.exe';Servizio:'X004FINTEGRAZIONENBSSRV'),
       (Tipo:'SERVIZI';NomeFile:'Messaggi.exe';Servizio:'')
      );

const COMServerDistribuiti:array [0..3] of String =
     ('A077PCOMServer.exe',
      'B028PPrintServer_COM.exe',
      'P077PCOMServer.exe',
      'P714PComServer.exe'
      );

const FilesDaCancellare:array [0..6] of String =
     ('wwwroot\Files\help',
      'wwwroot\Files\HelpCloudRilPre',
      'wwwroot\Files\HelpCloudStatoGiuridico',
      'wwwroot\Files\HelpCloudStipendi',
      'wwwroot\Files\HelpWSB110',
      'wwwroot\Files\EsempioChiamataPost.htm',
      'Archivi\Cache'
      );

implementation

{$R *.dfm}

uses ShlObj, ActiveX, ComObj, Registry, B016USetupPercorsi, B016USetupSelez;

procedure TB016FSetup.FormCreate(Sender: TObject);
var OldPath:String;
begin
  //PageControl1.ActivePage:=TabSheet1;
  bScompattaFiles:=False;
  TabSheet1.TabVisible:=False;
  TabSheet3.TabVisible:=False;
  PageControl1.ActivePage:=TabSheet2;
  edtDownloadPath.Text:=ExtractFilePath(Application.ExeName);
  edtDownloadPath.Text:=Copy(edtDownloadPath.Text,1,Length(edtDownloadPath.Text) - 1);
  //edtDownloadPath.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','DownloadPath',edtDownloadPath.Text);
  edtPathPacchetti.Text:=edtDownloadPath.Text;
  OldPath:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','Path','');
  edtPathAmministrazione.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','PathAmministrazione',IfThen(OldPath = '','C:\IrisWIN',OldPath));
  edtPathIrisWIN.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisWIN',IfThen(OldPath = '','C:\IrisWIN',OldPath));
  edtPathServizi.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','PathServizi',IfThen(OldPath = '','C:\IrisWIN',OldPath));
  edtPathIrisWEB.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisWEB',IfThen(OldPath = '','C:\IrisWEB',OldPath));
  edtPathIrisWEBSSO.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisWEBSSO',IfThen(OldPath = '','C:\IrisWEB_SSO',OldPath));
  edtPathIrisCloud.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisCloud',IfThen(OldPath = '','C:\IrisCloud',OldPath));
  edtPathIrisAPP.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisAPP',IfThen(OldPath = '','C:\IrisAPP',OldPath));
  edtPathWebSvc.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','PathWebSvc',IfThen(OldPath = '','C:\IrisWEB',OldPath));
  chkFrameworkUniGui.Enabled:=False;
  btnDownload.Enabled:=False;
  lstFileDistribuiti:=TStringList.Create;
  try
    CaricaFileDistribuiti;
  except
  end;
  chkAmministrazioneClick(nil);
  CaricaCollegamenti;
end;

procedure TB016FSetup.CaricaFileDistribuiti;
var F:TSearchRec;
    i:Integer;
    VerDB,App:String;
begin
  memoPacchetti.Clear;
  lstFileDistribuiti.Clear;
  App:='';
  VerDB:='NON DISPONIBILE';
  if FindFirst(edtPathPacchetti.Text + '\*.exe',faAnyFile,F) = 0 then
  repeat
    if Copy(UpperCase(F.Name),1,4) <> 'B016' then
      for i:=0 to High(FileDistribuiti) do
        if UpperCase(FileDistribuiti[i].NomeFile) = Uppercase(F.Name) then
        begin
          lstFileDistribuiti.Add(F.Name);
          if UpperCase(F.Name) = 'RILPRE.EXE' then
            App:=App + 'Presenze-Assenze' + #13#10
          else if UpperCase(F.Name) = 'STATOGIURIDICO.EXE' then
            App:=App + 'Stato giuridico' + #13#10
          else if UpperCase(F.Name) = 'MISSIONI.EXE' then
            App:=App + 'Missioni' + #13#10
          else if UpperCase(F.Name) = 'STIPENDI.EXE' then
            App:=App + 'Gestione economica' + #13#10;
          Break;
        end;
  until FindNext(F) <> 0;
  FindClose(F);
  if FindFirst(edtPathPacchetti.Text + '\*MEDP.ini*',faAnyFile,F) = 0 then
  begin
    with TStringList.Create do
    try
      LoadFromFile(F.Name);
      VerDB:=R180Decripta(Copy(Strings[0],3,80),14091943);
    finally
      Free;
    end;
    repeat
      lstFileDistribuiti.Add(F.Name);
    until FindNext(F) <> 0;
  end;
  FindClose(F);
  if App = '' then
    App:='ATTENZIONE!' + #13#10 + 'Nessun applicativo disponibile!';
  memoPacchetti.Lines.Add('Versione: ' + VerDB);
  memoPacchetti.Lines.Add(Trim(App));
end;

procedure TB016FSetup.btnPathAmministrazioneClick(Sender: TObject);
var
    FPercorsi: TB016FSetupPercorsi;
    EdtPercorsi: TEdit;
begin
  if Sender = btnPathAmministrazione then
    EdtPercorsi:=edtPathAmministrazione
  else if Sender = btnPathIrisWIN then
    EdtPercorsi:=edtPathIrisWIN
  else if Sender = btnPathServizi then
    EdtPercorsi:=edtPathServizi
  else if Sender = btnPathIrisWEB then
    EdtPercorsi:=edtPathIrisWEB
  else if Sender = btnPathIrisWEBSSO then
    EdtPercorsi:=edtPathIrisWEBSSO
  else if Sender = btnPathIrisCloud then
    EdtPercorsi:=edtPathIrisCloud
  else if Sender = btnPathIrisAPP then
    EdtPercorsi:=edtPathIrisAPP
  else if Sender = btnPathWebSvc then
    EdtPercorsi:=edtPathWebSvc
  else
    EdtPercorsi:=nil;

  FPercorsi:=TB016FSetupPercorsi.Create(nil);
  FPercorsi.Percorsi:=EdtPercorsi.Text;
  FPercorsi.ShowModal;
  if FPercorsi.ModalResult = mrOk then
  begin
    EdtPercorsi.Text:=FPercorsi.Percorsi;
    CaricaCollegamenti;
  end;
  FreeAndNil(FPercorsi);
end;

procedure TB016FSetup.btnScompattaClick(Sender: TObject);
var
  B016Path: TB016FSetupSelez;
  procedure CheckDirectory(D:String);
  var i:Integer;
  begin
    with TStringList.Create do
    try
      StrictDelimiter:=True;
      Delimiter:=';';
      DelimitedText:=D;
      for i:=0 to Count - 1 do
        if (Strings[i].Trim <> '') and not DirectoryExists(Strings[i].Trim) then
          if MessageDlg('Il percorso ' + Strings[i] + ' è inesistente! Creare automaticamente le cartelle necessarie?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
            ForceDirectories(Strings[i].Trim)
          else
            Abort;
    finally
      Free;
    end;
  end;

  procedure ScompattaFiles(D,Tipo:String);
  var i,k:Integer;
      wR180SyncProcessExecResults:T180SyncProcessExecResults;
  begin
    bScompattaFiles:=True;
    with TStringList.Create do
    try
      StrictDelimiter:=True;
      Delimiter:=';';
      DelimitedText:=D;
      for k:=0 to Count - 1 do
      begin
        D:=Strings[k].Trim;
        if D = '' then
          Continue;
        if Copy(D,Length(D),1) = '\' then
          D:=Copy(D,1,Length(D) - 1);
        Screen.Cursor:=crHourGlass;

        for i:=0 to High(FileDistribuiti) do
          if (FileDistribuiti[i].Tipo = Tipo) or (FileDistribuiti[i].Tipo = '*') then
          begin
            //ShellExecute(0,'open',pchar(edtPathPacchetti.Text + '\' + FileDistribuiti[i].NomeFile),pchar('-auto ' + D),pchar(edtPathPacchetti.Text), SW_SHOWNORMAL);
            StatusBar.SimpleText:='Scompatto ' + FileDistribuiti[i].NomeFile + '...';
            StatusBar.Repaint;
            Application.ProcessMessages;
            if TFile.Exists(IncludeTrailingPathDelimiter(edtPathPacchetti.Text) + FileDistribuiti[i].NomeFile) then
            try
              //wR180SyncProcessExecResults:=R180SyncProcessExec(FileDistribuiti[i].NomeFile,edtPathPacchetti.Text,'-auto ' + D); //vecchia cmd line per autoestraenti creati con winzip
              wR180SyncProcessExecResults:=R180SyncProcessExec(edtPathPacchetti.Text + '\' + FileDistribuiti[i].NomeFile,edtPathPacchetti.Text,'-y -o"' + D + '"'); //cmd line per autoestraenti creati con 7zip
              if wR180SyncProcessExecResults.CodiceUscita <> 0 then
                raise Exception.Create(wR180SyncProcessExecResults.DatiStdErr);
            except
              on E:Exception do
                raise Exception.Create('Esecuzione del comando ' + FileDistribuiti[i].NomeFile + ' fallita.' + CRLF + E.Message);
            end;
          end;
        if Tipo = 'AMMINISTRAZIONE' then
          for i:=0 to lstPacchetti.Count - 1 do
            if Pos('MEDP.INI',UpperCase(lstPacchetti.Items[i])) > 0 then
            begin
              CopyFile(PChar(edtPathPacchetti.Text + '\' + lstPacchetti.Items[i]),PChar(D + '\' + StringReplace(lstPacchetti.Items[i],'.txt','',[rfIgnoreCase])),False);
              //Break;
            end;
      end;
    finally
      Free;
      StatusBar.SimpleText:='';
      Screen.Cursor:=crDefault;
    end;
  end;

begin
  if (lstServizi.Items.Count > 0) and (not chkServiziStop.Checked) then
    raise exception.Create('Arrestare i servizi prima di continuare!');
  if (not chkBackup.Checked) then
    raise exception.Create('Effettuare backup delle cartelle prima di continuare!');

  //Verifico che ci sia PrgBase.exe
  if Pos('PRGBASE.EXE',UpperCase(lstPacchetti.Items.Text)) = 0 then
    if MessageDlg('Attenzione!' + #13 +
                  'PrgBase.exe è indispensabile per l''utilizzo degli applicativi, ma non è nell''elenco dei pacchetti disponibili.' + #13 +
                  'Eseguire comunque l''installazione?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      exit;

  //Verifico se c'è AggDB.exe
  //Se c'è, verifico che ci sia lo script MEDP.ini
  if Pos('AGGDB.EXE',UpperCase(lstPacchetti.Items.Text)) > 0 then
    if Pos('MEDP.INI',UpperCase(lstPacchetti.Items.Text)) = 0 then
      if MessageDlg('Attenzione!' + #13 +
                    'Lo script MEDP.ini è indispensabile per l''attivazione dei moduli accessori, ma non è nell''elenco dei pacchetti disponibili.' + #13 +
                    'Eseguire comunque l''installazione?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
        exit;

  B016Path:=TB016FSetupSelez.Create(nil);
  if chkAmministrazione.Checked then
    B016Path.LstTool:=edtPathAmministrazione.Text;
  if chkIrisWIN.Checked then
    B016Path.LstIrisWin:=edtPathIrisWIN.Text;
  if chkServizi.Checked then
    B016Path.LstServizi:=edtPathServizi.Text;
  if chkIrisWEB.Checked then
    B016Path.LstIrisWeb:=edtPathIrisWEB.Text;
  if chkIrisWEBSSO.Checked then
    B016Path.LstIrisWebSSO:=edtPathIrisWEBSSO.Text;
  if chkIrisCloud.Checked then
    B016Path.LstIrisCloud:=edtPathIrisCloud.Text;
  if chkIrisAPP.Checked then
    B016Path.LstIrisApp:=edtPathIrisAPP.Text;
  if chkWebSvc.Checked then
    B016Path.LstWebPrint:=edtPathWebSvc.Text;

  if not B016Path.SaltaGestione then
  begin
    B016Path.ShowModal;
    if B016Path.ModalResult <> mrOk then
    begin
      FreeAndNil(B016Path);
      Exit;
    end;
  end;

  if MessageDlg('Scompattare i files elencati nelle cartelle specificate?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;

  if chkAmministrazione.Checked then
    CheckDirectory(B016Path.LstTool);
  if chkIrisWIN.Checked then
    CheckDirectory(B016Path.LstIrisWin);
  if chkServizi.Checked then
    CheckDirectory(B016Path.LstServizi);
  if chkIrisWEB.Checked then
    CheckDirectory(B016Path.LstIrisWeb);
  if chkIrisWEBSSO.Checked then
    CheckDirectory(B016Path.LstIrisWebSSO);
  if chkIrisCloud.Checked then
    CheckDirectory(B016Path.LstIrisCloud);
  if chkIrisApp.Checked then
    CheckDirectory(B016Path.LstIrisApp);
  if chkWebSvc.Checked then
    CheckDirectory(B016Path.LstWebPrint);

  if chkAmministrazione.Checked then
    ScompattaFiles(B016Path.LstTool,'AMMINISTRAZIONE');
  if chkIrisWIN.Checked then
    ScompattaFiles(B016Path.LstIrisWin,'IRISWIN');
  if chkServizi.Checked then
    ScompattaFiles(B016Path.LstServizi,'SERVIZI');
  if chkIrisWEB.Checked then
    ScompattaFiles(B016Path.LstIrisWeb,'IRISWEB');
  if chkIrisWEBSSO.Checked then
    ScompattaFiles(B016Path.LstIrisWebSSO,'IRISWEBSSO');
  if chkIrisCloud.Checked then
    ScompattaFiles(B016Path.LstIrisCloud,'IRISCLOUD');
  if chkIrisAPP.Checked then
  begin
    ScompattaFiles(B016Path.LstIrisApp,'IRISAPP');
    if chkFrameworkUniGui.Checked then
      InstallaRuntimeIrisAPP(B016Path.LstIrisApp);
  end;
  if chkWebSvc.Checked then
    ScompattaFiles(B016Path.LstWebPrint,'WEBSVC');

  ShowMessage('Setup terminato!');
  chkFilesScompattati.Checked:=True;
  CaricaCollegamenti;
  FreeAndNil(B016Path);
end;

procedure TB016FSetup.InstallaRuntimeIrisAPP(PathIrisAPP:String);
var wR180SyncProcessExecResults:T180SyncProcessExecResults;
    PFPath:String;
    k:Integer;
const
    CartellaIrisAPP = 'wwwroot\IrisAPP';
    RuntimeFMSoft   = 'FMSoft_uniGUI_Complete_runtime.exe';
    CartellaFMSoft  = 'FMSoft\Framework';
    DisintFMSoft    = 'unins000.exe';
begin
  with TStringList.Create do
  try
    StrictDelimiter:=True;
    Delimiter:=';';
    DelimitedText:=PathIrisAPP;
    for k:=0 to Count - 1 do
    begin
      PathIrisAPP:=Strings[k].Trim;
      if PathIrisAPP = '' then
        Continue;
      PathIrisAPP:=IncludeTrailingPathDelimiter(PathIrisAPP) + CartellaIrisAPP;
      if TFile.Exists(IncludeTrailingPathDelimiter(PathIrisAPP) + RuntimeFMSoft) then
      begin
        Screen.Cursor:=crHourGlass;
        PFPath:=GetEnvironmentVariable('ProgramFiles');
        if TFile.Exists(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(PFPath) + CartellaFMSoft) + DisintFMSoft) then
        try
          wR180SyncProcessExecResults:=R180SyncProcessExec(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(PFPath) + CartellaFMSoft) + DisintFMSoft,'','/SILENT');
          if wR180SyncProcessExecResults.CodiceUscita <> 0 then
            raise Exception.Create('Esecuzione del comando ' + DisintFMSoft + ' fallita.' + CRLF + wR180SyncProcessExecResults.DatiStdErr);
        except
          raise Exception.Create('Esecuzione del comando ' + IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(PFPath) + CartellaFMSoft) + DisintFMSoft + ' fallita.');
        end;
        try
          wR180SyncProcessExecResults:=R180SyncProcessExec(IncludeTrailingPathDelimiter(PathIrisAPP) + RuntimeFMSoft,'','/SILENT');
          if wR180SyncProcessExecResults.CodiceUscita <> 0 then
            raise Exception.Create('Esecuzione del comando ' + RuntimeFMSoft + ' fallita.' + CRLF + wR180SyncProcessExecResults.DatiStdErr);
        except
          raise Exception.Create('Esecuzione del comando ' + IncludeTrailingPathDelimiter(PathIrisAPP) + RuntimeFMSoft + ' fallita.');
        end;
        Break;
      end;
    end;
  finally
    Free;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TB016FSetup.FormDestroy(Sender: TObject);
begin
  lstFileDistribuiti.Free;
end;

procedure TB016FSetup.CaricaPacchetti(Tipo:String);
var i,j:Integer;
begin
  //lstPacchetti.Clear;
  for i:=0 to lstFileDistribuiti.Count - 1 do
    if (Pos('MEDP.INI',UpperCase(lstFileDistribuiti[i])) > 0) and ((Tipo = '*') or (Tipo = 'AMMINISTRAZIONE')) then
      lstPacchetti.Items.Add(lstFileDistribuiti[i])
    else
      for j:=0 to High(FileDistribuiti) do
        if UpperCase(lstFileDistribuiti[i]) = UpperCase(FileDistribuiti[j].NomeFile) then
        begin
          if (FileDistribuiti[j].Tipo = '*') or (Tipo = '*') or (FileDistribuiti[j].Tipo = Tipo) then
          begin
            if lstPacchetti.Items.IndexOf(FileDistribuiti[j].NomeFile) = -1 then
              lstPacchetti.Items.Add(lstFileDistribuiti[i]);
            if (FileDistribuiti[j].Servizio <> '') and (lstServizi.Items.IndexOf(FileDistribuiti[j].Servizio) = -1) then
              lstServizi.Items.Add(FileDistribuiti[j].Servizio);
            Break;
          end;
        end;
end;

procedure TB016FSetup.chkAmministrazioneClick(Sender: TObject);
begin
  lstPacchetti.Clear;
  lstServizi.Clear;

  if chkAmministrazione.Checked then
    CaricaPacchetti('AMMINISTRAZIONE');
  if chkIrisWIN.Checked then
    CaricaPacchetti('IRISWIN');
  if chkServizi.Checked then
    CaricaPacchetti('SERVIZI');
  if chkIrisWEB.Checked then
    CaricaPacchetti('IRISWEB');
  if chkIrisWEBSSO.Checked then
    CaricaPacchetti('IRISWEBSSO');
  if chkIrisCloud.Checked then
    CaricaPacchetti('IRISCLOUD');
  if chkIrisAPP.Checked then
    CaricaPacchetti('IRISAPP');
  if chkWebSvc.Checked then
    CaricaPacchetti('WEBSVC');

  chkFrameworkUniGui.Enabled:=chkIrisAPP.Checked;
end;

procedure TB016FSetup.chkIISResetClick(Sender: TObject);
begin
  if chkIISReset.Checked then
    chkIISReset.Font.Color:=clRed
  else
    chkIISReset.Font.Color:=clWindowText;
end;

procedure TB016FSetup.CaricaCollegamenti;
var S:String;
    F:TSearchRec;
begin
  chklstCollegamenti.Items.Clear;
  S:=edtPathIrisWIN.Text;
  if Copy(S,Length(S),1) <> '\' then
    S:=S + '\';
  if FindFirst(S + '*.exe',faAnyFile,F) = 0 then
  repeat
    chklstCollegamenti.Items.Add(F.Name);
  until FindNext(F) <> 0;
  FindClose(F);
end;

procedure TB016FSetup.btnBackupClick(Sender: TObject);
var lst:TStringList;
    B016Path: TB016FSetupSelez;
  procedure BackupDirectory(D:String);
  var i,c:Integer;
      Cartella, TempName:String;
  begin
    with TStringList.Create do
    try
      StrictDelimiter:=True;
      Delimiter:=';';
      DelimitedText:=D;
      for i:=0 to Count - 1 do
      begin
        Cartella:=Strings[i].Trim;
        if (Cartella <> '') and DirectoryExists(Cartella) then
        begin
          if lst.IndexOf(UpperCase(Cartella)) = -1 then
          begin
            lst.Add(UpperCase(Cartella));
            try
              //Cancellazione cartella Cache + altro per (IrisWEB / IrisCloud)
              for c:=Low(FilesDaCancellare) to High(FilesDaCancellare) do
              begin
                TempName:=IncludeTrailingPathDelimiter(Cartella) + FilesDaCancellare[c];
                if FileExists(TempName) or DirectoryExists(TempName) then
                begin
                  StatusBar.SimpleText:=Format('Cancellazione in corso di "%s"', [TempName]);
                  StatusBar.Repaint;
                  if TFileAttribute.faDirectory in TPath.GetAttributes(TempName) then
                  begin
                    R180RemoveDir(TempName);
                  end
                  else
                  begin
                    TFile.Delete(TempName);
                  end;
                end;
              end;
            except
            end;
            StatusBar.SimpleText:='Copia in corso di ' + Cartella + ' in ' + Cartella + '_BCK';
            StatusBar.Repaint;
            TDirectory.Copy(Cartella, Cartella + '_BCK');
          end;
        end;
      end;
    finally
      Free;
    end;
  end;

begin
  B016Path:=TB016FSetupSelez.Create(nil);
  if chkAmministrazione.Checked then
    B016Path.LstTool:=edtPathAmministrazione.Text;
  if chkIrisWIN.Checked then
    B016Path.LstIrisWin:=edtPathIrisWIN.Text;
  if chkServizi.Checked then
    B016Path.LstServizi:=edtPathServizi.Text;
  if chkIrisWEB.Checked then
    B016Path.LstIrisWeb:=edtPathIrisWEB.Text;
  if chkIrisWEBSSO.Checked then
    B016Path.LstIrisWebSSO:=edtPathIrisWEBSSO.Text;
  if chkIrisCloud.Checked then
    B016Path.LstIrisCloud:=edtPathIrisCloud.Text;
  if chkIrisAPP.Checked then
    B016Path.LstIrisApp:=edtPathIrisAPP.Text;
  if chkWebSvc.Checked then
    B016Path.LstWebPrint:=edtPathWebSvc.Text;

  if not B016Path.SaltaGestione then
  begin
    B016Path.ShowModal;
    if B016Path.ModalResult <> mrOk then
    begin
      FreeAndNil(B016Path);
      Exit;
    end;
  end;

  if MessageDlg('Eseguire il backup delle cartelle indicate?' + #13#10 + 'Le cartelle saranno copiate col suffisso _BCK.',mtConfirmation,[mbYes,mbNo],0,mbNo) <> mrYes then
    exit;

  Screen.Cursor:=crHourGlass;
  lst:=TStringList.Create;
  try
    if chkAmministrazione.Checked then
      BackupDirectory(B016Path.LstTool);
    if chkIrisWIN.Checked then
      BackupDirectory(B016Path.LstIrisWin);
    if chkServizi.Checked then
      BackupDirectory(B016Path.LstServizi);
    if chkIrisWEB.Checked then
      BackupDirectory(B016Path.LstIrisWeb);
    if chkIrisWEBSSO.Checked then
      BackupDirectory(B016Path.LstIrisWebSSO);
    if chkIrisCloud.Checked then
      BackupDirectory(B016Path.LstIrisCloud);
    if chkIrisApp.Checked then
      BackupDirectory(B016Path.LstIrisApp);
    if chkWebSvc.Checked then
      BackupDirectory(B016Path.LstWebPrint);
    chkBackup.Checked:=True;
    ShowMessage('Eseguito Backup delle seguenti cartelle:' + #13#10 + lst.Text);
  finally
    Screen.Cursor:=crDefault;
    lst.Free;
    FreeAndNil(B016Path);
  end;
end;

procedure TB016FSetup.btnServiziStopClick(Sender: TObject);
var i:Integer;
    S:String;
begin
  S:='';
  if chkIISReset.Checked and ((lstPacchetti.Items.IndexOf('WebServices.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('RilPreWeb.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('IrisCloudPres.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('IrisAPP.exe') > 0))
  then
    S:=#13#10 + 'Verranno arrestati anche i servizi internet IIS';
  if MessageDlg('Arrestare i servizi disponibili?' + S,mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  for i:=0 to lstServizi.Count - 1 do
    ShellExecute(0,'open', PChar('NET'),PChar('STOP ' + lstServizi.Items[i]),nil,SW_SHOWNORMAL);
  if chkIISReset.Checked and ((lstPacchetti.Items.IndexOf('WebServices.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('RilPreWeb.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('IrisCloudPres.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('IrisAPP.exe') > 0))
  then
    ShellExecute(0,'open', PChar('IISRESET'),PChar('-STOP'),nil,SW_SHOWNORMAL);
  chkServiziStop.Checked:=True;
  ShowMessage('Servizi arrestati');
end;

procedure TB016FSetup.btnServiziStartClick(Sender: TObject);
var i:Integer;
    S:String;
  procedure EliminaComServer(F,Path:String);
  var i:Integer;
      D:String;
  begin
    with TStringList.Create do
    try
      StrictDelimiter:=True;
      Delimiter:=';';
      DelimitedText:=Path;
      for i:=0 to Count - 1 do
      begin
        D:=Strings[i].Trim;
        if D = '' then
           Continue;
        if Copy(D,Length(D),1) = '\' then
          D:=Copy(D,1,Length(D) - 1);
        try
          if TFile.Exists(D + '\' + F) then
            TFile.Delete(D + '\' + F);
        except
        end;
      end;
    finally
      Free;
    end;
  end;
  procedure EliminaFileDesktop(Path:String);
  var i:Integer;
      D:String;
      F:TSearchRec;
  begin
    with TStringList.Create do
    try
      StrictDelimiter:=True;
      Delimiter:=';';
      DelimitedText:=Path;
      for i:=0 to Count - 1 do
      begin
        D:=Strings[i].Trim;
        if D = '' then
           Continue;
        if Copy(D,Length(D),1) = '\' then
          D:=Copy(D,1,Length(D) - 1);
        if Pos(D,edtPathIrisWIN.Text) = 0 then
        try
          if FindFirst(D + '\' + 'B012*.*',faAnyFile,F) = 0 then
          repeat
            try TFile.Delete(D + '\' + F.Name); except end;
          until FindNext(F) <> 0;
        finally
          FindClose(F);
        end;
      end;
    finally
      Free;
    end;
  end;
begin
  S:='';
  if chkIISReset.Checked and ((lstPacchetti.Items.IndexOf('WebServices.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('RilPreWeb.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('IrisCloudPres.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('IrisAPP.exe') > 0))
  then
    S:=#13#10 + 'Verranno avviati anche i servizi internet IIS';
  if MessageDlg('Avviare i servizi disponibili?' + S,mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  //registrazione automatica di midas.dll
  if ((lstPacchetti.Items.IndexOf('WebServices.exe') > 0) or
      (lstPacchetti.Items.IndexOf('RilPreWeb.exe') > 0) or
      (lstPacchetti.Items.IndexOf('IrisCloudPres.exe') > 0) or
      (lstPacchetti.Items.IndexOf('IrisAPP.exe') > 0))
  then
  begin
    if TFile.Exists(edtPathIrisWEB.Text + '\midas.dll') then
      ShellExecute(0,'open', PChar('regsvr32'),PChar(edtPathIrisWEB.Text + '\midas.dll /s'),nil,SW_SHOWNORMAL)
    else if TFile.Exists(edtPathWebSvc.Text + '\midas.dll') then
      ShellExecute(0,'open', PChar('regsvr32'),PChar(edtPathWebSvc.Text + '\midas.dll /s'),nil,SW_SHOWNORMAL);
  end;
  //cancellazione automatica dei moduli COMPrint server se in cartelle diverse da quella delle WebUtility
  if (lstPacchetti.Items.IndexOf('WebUtility.exe') > 0) and
     (edtPathWebSvc.Text <> '') and
     (DirectoryExists(edtPathWebSvc.Text))
  then
  begin
    for i:=0 to High(COMServerDistribuiti) do
    begin
      if Pos(LowerCase(edtPathWebSvc.Text),LowerCase(edtPathServizi.Text)) = 0 then
        EliminaComServer(COMServerDistribuiti[i],edtPathServizi.Text);
      if Pos(LowerCase(edtPathWebSvc.Text),LowerCase(edtPathIrisWEB.Text)) = 0 then
        EliminaComServer(COMServerDistribuiti[i],edtPathIrisWEB.Text);
      if Pos(LowerCase(edtPathWebSvc.Text),LowerCase(edtPathIrisCloud.Text)) = 0 then
        EliminaComServer(COMServerDistribuiti[i],edtPathIrisCloud.Text);
    end;
  end;
  //cancellazione automatica B012*.* dai path <> IrisWIN
  if edtPathIrisWeb.Text <> '' then
    EliminaFileDesktop(edtPathIrisWEB.Text);
  if edtPathIrisCloud.Text <> '' then
    EliminaFileDesktop(edtPathIrisCloud.Text);
  if edtPathIrisAPP.Text <> '' then
    EliminaFileDesktop(edtPathIrisAPP.Text);
  if edtPathWebSvc.Text <> '' then
    EliminaFileDesktop(edtPathWebSvc.Text);
  if edtPathServizi.Text <> '' then
    EliminaFileDesktop(edtPathServizi.Text);

  //Avvio servizi
  for i:=0 to lstServizi.Count - 1 do
    ShellExecute(0,'open', PChar('NET'),PChar('START ' + lstServizi.Items[i]),nil,SW_SHOWNORMAL);
  if chkIISReset.Checked and ((lstPacchetti.Items.IndexOf('WebServices.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('RilPreWeb.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('IrisCloudPres.exe') > 0) or
                              (lstPacchetti.Items.IndexOf('IrisAPP.exe') > 0))
  then
    ShellExecute(0,'open', PChar('IISRESET'),PChar('-START'),nil,SW_SHOWNORMAL);
  chkServiziStart.Checked:=True;
  ShowMessage('Servizi avviati');
end;

procedure TB016FSetup.btnB005Click(Sender: TObject);
begin
  ShellExecute(0,'open',pchar(edtPathAmministrazione.Text + '\' + 'B005PAggIris.exe'),nil,pchar(edtPathAmministrazione.Text), SW_SHOWNORMAL);
  chkAggDB.Checked:=True;
end;

procedure TB016FSetup.btnCollegamentiClick(Sender: TObject);
var i:Integer;
begin
  if MessageDlg('Creare i collegamenti per gli applicativi indicati?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  for i:=0 to chklstCollegamenti.Count - 1 do
    if chklstCollegamenti.Checked[i] then
      CreaCollegamento(chklstCollegamenti.Items[i]);
  ShowMessage('Collegamenti creati!');
end;

procedure TB016FSetup.CreaCollegamento(F:String);
var
  MyObject  : IUnknown;
  MySLink   : IShellLink;
  MyPFile   : IPersistFile;
  FileName  : String;
  Directory : String;
  WFileName : WideString;
  S,Dato    : String;
  Registro  : TRegistry;
begin
  S:=edtPathIrisWIN.Text;
  if Copy(S,Length(S),1) <> '\' then
    S:=S + '\';
  FileName:=S + F;
  MyObject:=CreateComObject(CLSID_ShellLink);
  MySLink:=MyObject as IShellLink;
  MyPFile:=MyObject as IPersistFile;
  with MySLink do begin
    SetArguments('');
    SetPath(PChar(FileName));
    SetWorkingDirectory(PChar(ExtractFilePath(FileName)));
  end;
  Directory:='';
  Registro:=TRegistry.Create;
  try
    if rgpUserCollegamenti.ItemIndex = 0 then
    begin
      Registro.RootKey:=HKEY_CURRENT_USER;
      Dato:='';
    end
    else
    begin
      Registro.RootKey:=HKEY_LOCAL_MACHINE;
      Dato:='Common ';
    end;
    Registro.OpenKeyReadOnly('Software\MicroSoft\Windows\CurrentVersion\Explorer\Shell Folders');
    if rgpGruppoCollegamenti.ItemIndex = 0 then
      Dato:=Dato + 'Programs'
    else
      Dato:=Dato + 'Desktop';
    if Registro.ValueExists(Dato) then
      Directory:=Registro.ReadString(Dato);
  finally
    FreeAndNil(Registro);
  end;
  if Directory <> '' then
  begin
    if rgpGruppoCollegamenti.ItemIndex = 0 then
    begin
      Directory:=Directory + '\' + edtGruppoSetup.Text;
      CreateDir(Directory);
    end;
    WFileName:=Directory + '\' + F + '.lnk';
    MyPFile.Save(PWChar(WFileName),False);
  end;
end;

procedure TB016FSetup.Deselezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to (PopupMenu1.PopupComponent as TCheckListBox).Count - 1 do
    (PopupMenu1.PopupComponent as TCheckListBox).Checked[i]:=Sender = Selezionatutto1;
end;

procedure TB016FSetup.Refresh1Click(Sender: TObject);
begin
  CaricaCollegamenti;
end;

procedure TB016FSetup.btnLoginClick(Sender: TObject);
var S,Ver,App:String;
begin
  Screen.Cursor:=crHourGlass;
  try
    chklstDownloads.Items.Clear;
    memoDownload.Clear;
    btnDownload.Enabled:=False;
    msqlConnessione.Close;
    msqlConnessione.Open;
    selNukeUsers.ParamByName('USERNAME').AsString:=edtUtente.Text;
    selNukeUsers.ParamByName('USER_PASSWORD').AsString:=edtPassword.Text;
    selNukeUsers.Close;
    selNukeUsers.Open;
    if selNukeUsers.RecordCount <> 1 then
      raise Exception.Create('Autenticazione non valida!')
    else
    begin
      btnDownload.Enabled:=True;
      selDownloadVersione.Open;
      Ver:=selDownloadVersione.FieldByName('VERSIONE').AsString;
      S:=selNukeDownloads.SQL.Text;
      selNukeDownloads.SQL.Text:=StringReplace(S,':UTENTE',edtUtente.Text,[rfIgnoreCase]);
      selNukeDownloads.Open;
      App:='';
      while not selNukeDownloads.Eof do
      begin
        chklstDownloads.Items.Add(selNukeDownloads.FieldByName('TITLE').AsString);
        chklstDownloads.Checked[chklstDownloads.Items.Count - 1]:=True;
        if UpperCase(selNukeDownloads.FieldByName('TITLE').AsString) = 'RILPRE.EXE' then
          App:=App + 'Presenze-Assenze' + #13#10
        else if UpperCase(selNukeDownloads.FieldByName('TITLE').AsString) = 'STATOGIURIDICO.EXE' then
          App:=App + 'Stato giuridico' + #13#10
        else if UpperCase(selNukeDownloads.FieldByName('TITLE').AsString) = 'MISSIONI.EXE' then
          App:=App + 'Missioni' + #13#10
        else if UpperCase(selNukeDownloads.FieldByName('TITLE').AsString) = 'STIPENDI.EXE' then
          App:=App + 'Gestione economica' + #13#10;
        selNukeDownloads.Next;
      end;
      if App = '' then
        App:='Attenzione!' + #13#10 + 'Nessun applicativo disponibile!';
      memoDownload.Lines.Add('Versione disponibile: ' + Ver);
      memoDownload.Lines.Add('');
      memoDownload.Lines.Add('Applicativi disponibili:');
      memoDownload.Lines.Add(Trim(App));
    end;
  finally
    selNukeUsers.Close;
    selNukeDownloads.Close;
    selDownloadVersione.Close;
    msqlConnessione.Close;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TB016FSetup.btnDownloadPathClick(Sender: TObject);
begin
  SaveDialog1.FileName:=edtDownloadPath.Text + ExtractFileName(Application.ExeName);
  if SaveDialog1.Execute then
  begin
    edtDownloadPath.Text:=ExtractFilePath(SaveDialog1.FileName);
    if Copy(edtDownloadPath.Text,Length(edtDownloadPath.Text),1) = '\' then
      edtDownloadPath.Text:=Copy(edtDownloadPath.Text,1,Length(edtDownloadPath.Text) - 1);
  end;
end;

procedure TB016FSetup.btnDownloadClick(Sender: TObject);
var i:Integer;
    S:String;
begin
  if MessageDlg('Eseguire il download dei files selezionati?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  Screen.Cursor:=crHourGlass;
  S:=Trim(edtDownloadPath.Text);
  if (S <> '') and (S[length(S)] <> '\') then
    S:=S + '\';
  try
    if IdFTP.Connected then
      IdFTP.Disconnect;
    IdFTP.Connect;
    IdFTP.ChangeDir('/modules/Downloads/uploads');
    Self.KeyPreview:=True;
    Self.OnKeyPress:=FormKeyPress;
    Self.Enabled:=False;
    for i:=0 to chklstDownloads.Items.Count - 1 do
      if chklstDownloads.Checked[i] then
      begin
        StatusBar1.Panels[0].Text:='Download di ' + chklstDownloads.Items[i] + ' - ESC per interrompere';
        StatusBar1.Panels[1].Text:='0 bytes scaricati';
        StatusBar1.Refresh;
        IdFTP.Get(chklstDownloads.Items[i],S + chklstDownloads.Items[i],True);
        if (UpperCase(chklstDownloads.Items[i]) = 'RILPRE.EXE') or
           (UpperCase(chklstDownloads.Items[i]) = 'STATOGIURIDICO.EXE') or
           (UpperCase(chklstDownloads.Items[i]) = 'MISSIONI.EXE') or
           (UpperCase(chklstDownloads.Items[i]) = 'STIPENDI.EXE') then
          AggiornaDownload(chklstDownloads.Items[i]);
      end;
     ShowMessage('Download terminato');
     edtPathPacchetti.Text:=edtDownloadPath.Text;
     CaricaFileDistribuiti;
     chkAmministrazioneClick(nil);
  finally
    StatusBar1.Panels[0].Text:='';
    StatusBar1.Panels[1].Text:='';
    Self.OnKeyPress:=nil;
    Self.KeyPreview:=False;
    Self.Enabled:=True;
    IdFTP.Disconnect;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TB016FSetup.AggiornaDownload(Modulo:String);
var S:String;
    i:Integer;
    Trov:Boolean;
begin
  msqlConnessione.Open;
  try
    selDownloadUsers.Close;
    selDownloadUsers.ParamByName('TITLE').AsString:=Modulo;
    selDownloadUsers.Open;
    if selDownloadUsers.RecordCount = 1 then
    begin
      S:=selDownloadUsers.FieldByName('DOWNLOADUSERS').AsString;
      with TStringList.Create do
      try
        CommaText:=S;
        Trov:=False;
        for i:=0 to Count - 1 do
          if Pos(edtUtente.Text + '|',Strings[i]) = 1 then
          begin
            Strings[i]:=edtUtente.Text + '|' + FormatDateTime('dd/mm/yyyy',Date);
            Trov:=True;
            Break;
          end;
        if not Trov then
          Add(edtUtente.Text + '|' + FormatDateTime('dd/mm/yyyy',Date));
        S:=CommaText;
      finally
        Free;
      end;
      selDownloadUsers.Edit;
      selDownloadUsers.FieldByName('DOWNLOADUSERS').AsString:=S;
      selDownloadUsers.Post;
    end;
    selDownloadUsers.Close;
  finally
    msqlConnessione.Close;
  end;
end;

procedure TB016FSetup.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    if MessageDlg('Interrompere il  download?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      IDFTP.Abort;
      IDFTP.Disconnect;
    end;
end;

procedure TB016FSetup.IdFTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Application.ProcessMessages;
  StatusBar1.Panels[1].Text:=IntToStr(AWorkCount) + ' bytes scaricati';
  StatusBar1.Refresh;
end;

procedure TB016FSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if bScompattaFiles and (not chkAggDB.Checked) then
    raise exception.Create('Aggiornare il DB prima di uscire!');
  if bScompattaFiles and (lstServizi.Items.Count > 0) and (not chkServiziStart.Checked) then
    raise exception.Create('Riavviare i servizi prima di uscire!');

  try
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B016','PathAmministrazione',edtPathAmministrazione.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisWIN',edtPathIrisWIN.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B016','PathServizi',edtPathServizi.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisWEB',edtPathIrisWEB.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisWEBSSO',edtPathIrisWEBSSO.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisCloud',edtPathIrisCloud.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B016','PathIrisAPP',edtPathIrisAPP.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B016','PathWebSvc',edtPathWebSvc.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B016','DownloadPath',edtDownloadPath.Text);
  except
  end;
end;

procedure TB016FSetup.btnPathPacchettiClick(Sender: TObject);
begin
  SaveDialog1.FileName:=ExtractFileName(Application.ExeName);
  if SaveDialog1.Execute then
  begin
    edtPathPacchetti.Text:=ExtractFilePath(SaveDialog1.FileName);
    if Copy(edtPathPacchetti.Text,Length(edtPathPacchetti.Text),1) = '\' then
      edtPathPacchetti.Text:=Copy(edtPathPacchetti.Text,1,Length(edtPathPacchetti.Text) - 1);
  end;
  CaricaFileDistribuiti;
  chkAmministrazioneClick(nil);
end;

procedure TB016FSetup.edtPathPacchettiExit(Sender: TObject);
begin
  CaricaFileDistribuiti;
  chkAmministrazioneClick(nil);
end;

end.
