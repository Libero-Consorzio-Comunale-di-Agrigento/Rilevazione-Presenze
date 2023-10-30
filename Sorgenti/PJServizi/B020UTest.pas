unit B020UTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StrUtils, ActiveX, Oracle, OracleData, SyncObjs,
  C180FunzioniGenerali, A000UCostanti, A000USessione, W009UStampaCartellinoDtm,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  IB020IrisWebSvcClnt,
  R600, Rp502Pro, R500Lin, Spin, System.IOUtils;

type
  TB020FIrisWebSvc01Dtm = record
    lstSessioniOracle:array of TOracleSession;
  end;

  TParametri = record
    WEBCartelliniDataMin:TDateTime;
    WEBCartelliniMMPrec:Integer;
    WEBCartelliniMMSucc:Integer;
  end;

  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    rgpTipoRichiesta: TRadioGroup;
    grpParametri: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    edtMatricolaProgressivo: TEdit;
    edtData1: TEdit;
    edtData2: TEdit;
    edtParametrizzazione: TEdit;
    edtFilePdf: TEdit;
    edtDatabase: TEdit;
    edtAzienda: TEdit;
    memOutputSvc: TMemo;
    grpInfo: TGroupBox;
    edtLogonDB: TEdit;
    Label8: TLabel;
    lblHome: TLabel;
    edtHome: TEdit;
    Label10: TLabel;
    edtPathLog: TEdit;
    edtUrlWebSvc: TEdit;
    lblWebSvc: TLabel;
    Panel1: TPanel;
    btnSaveFile: TButton;
    SaveDialog1: TSaveDialog;
    grpEsecuzione: TGroupBox;
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    Label9: TLabel;
    chkNormale: TCheckBox;
    chkWebService: TCheckBox;
    TabSheet3: TTabSheet;
    memOutputNorm: TMemo;
    ProgressBar1: TProgressBar;
    edtConfronto: TEdit;
    lblConfronto: TLabel;
    Panel2: TPanel;
    btnSaveFile2: TButton;
    TabSheet4: TTabSheet;
    memLog: TMemo;
    Panel3: TPanel;
    Button2: TButton;
    lblIIS: TLabel;
    edtIIS: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure rgpTipoRichiestaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveFileClick(Sender: TObject);
    procedure chkWebServiceClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    TipoRichiesta: String;
    W009FStampaCartellinoDtm: TW009FStampaCartellinoDtm;
    B020FIrisWebSvc01Dtm:TB020FIrisWebSvc01Dtm;
    R600DtM: TR600DtM1;
    R502ProDtM: TR502ProDtM1;
    procedure GetParRich(Index: Integer);
    procedure GetParametri;
    procedure PutParametri;
    function GeneraRispostaOk(Xml: WideString): WideString;
    function GeneraErrore(Codice,Descrizione: String): WideString;
    function EstraiSessioneOracle(const DB, Azienda: WideString): Integer;
    function GetSessioneOracle(LogonDB,LogonUsr:String; LogonPwd:TStringList):Integer;
    function CreaCartellinoPDF(SessioneOracleB020:TOracleSession; pMatricola,pDal,pAl,Parametrizzazione,FilePdf,CartelliniChiusi: WideString): WideString;
    function CartellinoPDF(const DB,Azienda,Matricola,Dal,Al,Parametrizzazione,FilePdf: WideString): WideString; stdcall;
    function R600GetAssenze(const DB,Azienda,Matricola,DataRiferimento,Causale,DataNasFam: WideString): WideString; stdcall;
    function R502Conteggi(const DB,Azienda,Matricola,DataRiferimento: WideString): WideString; stdcall;
    const XML_HEAD: String = '<?xml version="1.0" encoding="UTF-8"?>';
  end;

var
  Form1: TForm1;
  CSStampa, CSStampaCartellino:TMedpCriticalSection;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage:=TabSheet1;
  ProgressBar1.Visible:=False;

  // imposta parametri salvati
  GetParametri;

  rgpTipoRichiestaClick(nil);

  // visualizza informazioni
  edtLogonDb.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B020','Database','');
  edtHome.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','');
  edtPathLog.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG','');
  edtUrlWebSvc.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B020','URL','');
  edtIIS.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B020','IIS','S');

  // visualizza log preesistente
  if FileExists(edtPathLog.Text + '\B020.log') then
    memLog.Lines.LoadFromFile(edtPathLog.Text + '\B020.log');

  // path file xml per eventuale salvataggio
  if DirectoryExists(edtPathLog.Text) then
    SaveDialog1.InitialDir:=edtPathLog.Text
  else
    SaveDialog1.InitialDir:='c:\';  
end;

procedure TForm1.Button1Click(Sender: TObject);
// Elaborazione richiesta
var
  OutSvc,OutNorm,NomeFile,NomeCartella,TempStr: String;
  i: Integer;
const
  ORA_FMT = 'dd/mm/yyyy hh.nn.ss';
begin
  Screen.Cursor:=crHourGlass;
  PutParametri;

  edtConfronto.Text:=IfThen((chkWebService.Checked) and (chkNormale.Checked),'OK','');
  edtConfronto.Color:=clWindow;

  ProgressBar1.Visible:=(SpinEdit1.Value > 1);
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=SpinEdit1.Value;
  ProgressBar1.Repaint;

  // elaborazione principale
  for i:=1 to SpinEdit1.Value do
  begin
    // gestione webservice
    if chkWebService.Checked then
    begin
      //CoInitialize(nil);
      case rgpTipoRichiesta.ItemIndex of
        0: begin
             // echoDouble
             R180ScriviMsgLog('B020.log',FormatDateTime(ORA_FMT,Now) + ' TEST | echoDouble.ini');
             OutSvc:=FloatToStr(GetIB020IrisWebSvc01.echoDouble(StrToFloat(edtMatricolaProgressivo.Text)));
             R180ScriviMsgLog('B020.log',FormatDateTime(ORA_FMT,Now) + ' TEST | echoDouble.fine'#13#10);
           end;
        1: begin
             // cartellino pdf
             NomeCartella:=TPath.GetDirectoryName(edtFilePdf.Text);
             NomeFile:=TPath.GetFileName(edtFilePdf.Text);
             NomeFile:=TPath.GetFileNameWithoutExtension(NomeFile) + '_svc_' + FormatDateTime('hhnnss',Now) + TPath.GetExtension(NomeFile);
             TempStr:=IncludeTrailingPathDelimiter(NomeCartella) + NomeFile;
             R180ScriviMsgLog('B020.log',FormatDateTime(ORA_FMT,Now) + ' TEST | CartellinoPDF.ini');
             OutSvc:=GetIB020IrisWebSvc01.CartellinoPDF(edtDatabase.Text,edtAzienda.Text,edtMatricolaProgressivo.Text,edtData1.Text,edtData2.Text,edtParametrizzazione.Text,TempStr);
             OutSvc:=TempStr + #13#10 + OutSvc;
             R180ScriviMsgLog('B020.log',FormatDateTime(ORA_FMT,Now) + ' TEST | CartellinoPDF.fine'#13#10);
           end;
        2: begin
             // assenze R600
             R180ScriviMsgLog('B020.log',FormatDateTime(ORA_FMT,Now) + ' TEST | R600GetAssenze.ini');
             OutSvc:=GetIB020IrisWebSvc01.R600GetAssenze(edtDatabase.Text, edtAzienda.Text, edtMatricolaProgressivo.Text, edtData1.Text, edtParametrizzazione.Text, edtData2.Text);
             R180ScriviMsgLog('B020.log',FormatDateTime(ORA_FMT,Now) + ' TEST | R600GetAssenze.fine' + #13#10);
           end;
        3: begin
             // conteggi R502
             R180ScriviMsgLog('B020.log',FormatDateTime(ORA_FMT,Now) + ' TEST | R502Conteggi.ini');
             OutSvc:=GetIB020IrisWebSvc01.R502Conteggi(edtDatabase.Text, edtAzienda.Text, edtMatricolaProgressivo.Text, edtData1.Text);
             R180ScriviMsgLog('B020.log',FormatDateTime(ORA_FMT,Now) + ' TEST | R502Conteggi.fine' + #13#10);
           end;
      end;
      //CoUninitialize;
    end;

    // gestione normale
    if chkNormale.Checked then
    begin
      case rgpTipoRichiesta.ItemIndex of
        0: OutNorm:=FloatToStr(StrToFloat(edtMatricolaProgressivo.Text));
        1: begin
             NomeCartella:=TPath.GetDirectoryName(edtFilePdf.Text);
             NomeFile:=TPath.GetFileName(edtFilePdf.Text);
             NomeFile:=TPath.GetFileNameWithoutExtension(NomeFile) + '_normal_' + FormatDateTime('hhnnss',Now) + TPath.GetExtension(NomeFile);
             TempStr:=IncludeTrailingPathDelimiter(NomeCartella) + NomeFile;
             OutNorm:=CartellinoPDF(edtDatabase.Text,edtAzienda.Text,edtMatricolaProgressivo.Text,edtData1.Text,edtData2.Text,edtParametrizzazione.Text,TempStr);
             OutNorm:=TempStr + #13#10 + OutNorm;
           end;
        2: OutNorm:=R600GetAssenze(edtDatabase.Text, edtAzienda.Text, edtMatricolaProgressivo.Text, edtData1.Text, edtParametrizzazione.Text, edtData2.Text);
        3: OutNorm:=R502Conteggi(edtDatabase.Text, edtAzienda.Text, edtMatricolaProgressivo.Text, edtData1.Text);
      end;
    end;

    // se risultati differiscono termina ciclo
    if (chkWebService.Checked) and
       (chkNormale.Checked) and
       (StringReplace(StringReplace(OutSvc,#13,'',[rfReplaceAll]),#10,'',[rfReplaceAll]) <>
        StringReplace(StringReplace(OutNorm,#13,'',[rfReplaceAll]),#10,'',[rfReplaceAll])) then
    begin
      edtConfronto.Text:='DIFF';
      edtConfronto.Color:=clRed;
      Break;
    end;

    ProgressBar1.StepBy(1);
    ProgressBar1.Repaint;
  end;

  // visualizza output e log
  memOutputSvc.Lines.Text:=OutSvc;
  memOutputNorm.Lines.Text:=OutNorm;
  if FileExists(edtPathLog.Text + '\B020.log') then
    memLog.Lines.LoadFromFile(edtPathLog.Text + '\B020.log')
  else
    memLog.Lines.Clear;

  Screen.Cursor:=crDefault;
  ProgressBar1.Visible:=False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if FileExists(edtPathLog.Text + '\B020.log') then
    try
      if DeleteFile(edtPathLog.Text + '\B020.log') then
        memLog.Clear;
    except
    end;
end;

procedure TForm1.btnSaveFileClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    if Sender = btnSaveFile then
      memOutputSvc.Lines.SaveToFile(SaveDialog1.FileName)
    else
      memOutputNorm.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TForm1.rgpTipoRichiestaClick(Sender: TObject);
begin
  case rgpTipoRichiesta.ItemIndex of
    0: begin
         Label3.Caption:='Valore double';
         Label4.Caption:='';
         Label5.Caption:='';
         Label6.Caption:='';
         Label7.Caption:='';
         edtData1.Visible:=False;
         edtData2.Visible:=False;
         edtParametrizzazione.Visible:=False;
         edtFilePdf.Visible:=False;
       end;
    1: begin
         Label3.Caption:='Matricola';
         Label4.Caption:='Dal';
         Label5.Caption:='Al';
         Label6.Caption:='Parametrizz.';
         Label7.Caption:='File';
         edtData1.Visible:=True;
         edtData2.Visible:=True;
         edtParametrizzazione.Visible:=True;
         edtFilePdf.Visible:=True;
       end;
    2: begin
         Label3.Caption:='Matricola';
         Label4.Caption:='Data rif.';
         Label5.Caption:='Data nascita fam.';
         Label6.Caption:='Causale';
         Label7.Caption:='';
         edtData1.Visible:=True;
         edtData2.Visible:=True;
         edtParametrizzazione.Visible:=True;
         edtFilePdf.Visible:=False;
       end;
    3: begin
         Label3.Caption:='Matricola';
         Label4.Caption:='Data rif.';
         Label5.Caption:='';
         Label6.Caption:='';
         Label7.Caption:='';
         edtData1.Visible:=True;
         edtData2.Visible:=False;
         edtParametrizzazione.Visible:=False;
         edtFilePdf.Visible:=False;
       end;
    4..5: begin
         Label3.Caption:='Valore double';
         Label4.Caption:='';
         Label5.Caption:='';
         Label6.Caption:='';
         Label7.Caption:='';
         edtData1.Visible:=False;
         edtData2.Visible:=False;
         edtParametrizzazione.Visible:=False;
         edtFilePdf.Visible:=False;
       end;
  end;
  GetParRich(rgpTipoRichiesta.ItemIndex);
end;

procedure TForm1.GetParRich(Index: Integer);
var
  Pref: String;
begin
  Pref:='0' + IntToStr(Index) + '_';
  edtAzienda.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT1','');
  edtDatabase.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT2','');
  edtMatricolaProgressivo.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT3','');
  edtData1.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT4','');
  edtData2.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT5','');
  edtParametrizzazione.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT6','');
  edtFilePdf.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT7','');
  (*
           edtAzienda.Text:='AZIN';
         edtDatabase.Text:='IMPERIA_ASL1';
         edtMatricolaProgressivo.Text:='390731';
         edtData1.Text:='01/01/2022';
         edtData2.Text:='31/01/2022';
         edtParametrizzazione.Text:='STD';
         edtFilePdf.Text:='C:\TEMP\B020.PDF';
  *)
end;

procedure TForm1.GetParametri;
begin
  rgpTipoRichiesta.ItemIndex:=StrToInt(R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020','RGPTIPORICHIESTA','0'));
  chkWebService.Checked:=R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020','CHKWEBSERVICE','S') = 'S';
  chkNormale.Checked:=R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020','CHKNORMALE','N') = 'S';
  SpinEdit1.Value:=StrToInt(R180GetRegistro(HKEY_LOCAL_MACHINE,'TestB020','NUMELAB','1'));

  GetParRich(rgpTipoRichiesta.ItemIndex);
end;

procedure TForm1.PutParametri;
var
  Pref: String;
begin
  // salva i parametri nel registro
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020','RGPTIPORICHIESTA',IntToStr(rgpTipoRichiesta.ItemIndex));
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020','CHKWEBSERVICE',IfThen(chkWebService.Checked,'S','N'));
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020','CHKNORMALE',IfThen(chkNormale.Checked,'S','N'));
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020','NUMELAB',IntToStr(SpinEdit1.Value));

  Pref:='0' + IntToStr(rgpTipoRichiesta.ItemIndex) + '_';
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT1',edtAzienda.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT2',edtDatabase.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT3',edtMatricolaProgressivo.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT4',edtData1.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT5',edtData2.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT6',edtParametrizzazione.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,'TestB020',Pref + 'EDIT7',edtFilePdf.Text);
end;

//______________________________________________________________________________

function TForm1.GeneraErrore(Codice,Descrizione: String): WideString;
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

function TForm1.GeneraRispostaOk(Xml: WideString): WideString;
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

function TForm1.GetSessioneOracle(LogonDB,LogonUsr:String; LogonPwd:TStringList):Integer;
var i,k:Integer;
begin
  Result:=-1;
  for i:=0 to High(B020FIrisWebSvc01Dtm.lstSessioniOracle) do
    if (B020FIrisWebSvc01Dtm.lstSessioniOracle[i].LogonDatabase = LogonDB) and
       (B020FIrisWebSvc01Dtm.lstSessioniOracle[i].LogonUserName = LogonUsr) then
       //(B020FIrisWebSvc01Dtm.lstSessioniOracle[i].LogonPassword = LogonPwd) then
    begin
      Result:=i;
      Break;
    end;
  if Result = -1 then
  begin
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
      if B020FIrisWebSvc01Dtm.lstSessioniOracle[k].CheckConnection(False) = ccError then
        for i:=0 to LogonPwd.Count - 1 do
        begin
          B020FIrisWebSvc01Dtm.lstSessioniOracle[k].LogonPassword:=LogonPwd[i];
          //B020FIrisWebSvc01Dtm.lstSessioniOracle[k].Logon;
          if B020FIrisWebSvc01Dtm.lstSessioniOracle[k].CheckConnection(True) <> ccError then
            Break;
        end;
    except
      A000LogonDBOracle(B020FIrisWebSvc01Dtm.lstSessioniOracle[k]);
    end;
  end;
end;

function TForm1.EstraiSessioneOracle(const DB, Azienda: WideString): Integer;
var
  x: Integer;
  LogonDB,LogonUsr:WideString;
  LogonPwd:TStringList;
begin
  //Cerco la sessione oracle corrispondente a DB e Azienda specificati
  LogonDB:=DB;
  if LogonDB = '' then
    LogonDB:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B020','Database','IRIS');
  LogonUsr:='MONDOEDP';
  LogonPwd:=A000GetPassword(A000FilePwdApplication);
  try
    R180ScriviMsgLog('B020.log',Format('SessioneMONDOEDP:%s %s %s ',[LogonDB,LogonUsr,LogonPwd.Text]));
    x:=GetSessioneOracle(LogonDB,LogonUsr,LogonPwd);
    if x = -1 then
      raise Exception.Create('Connessione al db MONDOEDP non riuscita');
    with TOracleQuery.Create(nil) do
    try
      Session:=B020FIrisWebSvc01Dtm.lstSessioniOracle[x];
      SQL.Text:='select UTENTE,PAROLACHIAVE from I090_ENTI where AZIENDA = ''' + Azienda + '''';
      Execute;
      LogonUsr:=FieldAsString(0);
      LogonPwd.Clear;
      LogonPwd.Add(R180Decripta(FieldAsString(1),21041974));
    finally
      Free;
    end;
    R180ScriviMsgLog('B020.log',Format('SessioneOracle:%s %s %s ',[LogonDB,LogonUsr,LogonPwd.Text]));
    Result:=GetSessioneOracle(LogonDB,LogonUsr,LogonPwd);
    R180ScriviMsgLog('B020.log',Format('SessioneOracle[%d]',[Result]));
  finally
    LogonPwd.Free;
  end;
end;

//______________________________________________________________________________
function TForm1.CreaCartellinoPDF(SessioneOracleB020:TOracleSession; pMatricola,pDal,pAl,Parametrizzazione,FilePdf,CartelliniChiusi: WideString): WideString;
{Stessa procedura utilizzata in IrisWEB in W019UStampaCartellino}
var DataI,DataF:TDateTime;
    A,M,G,A2,M2,G2:Word;
    iSQL:Integer;
    S,SQLText:String;
    CodiceT950:String;
    //URL_Stampa:String;
    lst:TStringList;
    Parametri:TParametri;
begin
  Result:='';
  Parametri.WEBCartelliniDataMin:=0;
  Parametri.WEBCartelliniMMPrec:=-1;
  Parametri.WEBCartelliniMMSucc:=-1;
  W009FStampaCartellinoDtm.Sessione:=SessioneOracleB020;
  W009FStampaCartellinoDtm.selAnagrafeW:=W009FStampaCartellinoDtm.selAnagrafeApp;
  W009FStampaCartellinoDtm.selAnagrafeW.Session:=SessioneOracleB020;
  W009FStampaCartellinoDtm.CartelliniChiusi:=CartelliniChiusi = 'S';
  W009FStampaCartellinoDtm.Stampa:=True;
  W009FStampaCartellinoDtm.RegLog:=False;
  W009FStampaCartellinoDtm.RaveProjectFile:=A000GetHomePath + 'wwwroot\report\W009StampaCartellino.rav';
  W009FStampaCartellinoDtm.NomeFile:=FilePDF;
  W009FStampaCartellinoDtm.RaveOutputFileName:=FilePDF;
  DataI:=StrToDate(pDal);
  DataF:=StrToDate(pAl);
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
    Result:=Format('Non 柰ossibile elaborare il cartellino prima del %s!',[DateToStr(Parametri.WEBCartelliniDataMin)]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMPrec >= 0) and (R180AddMesi(R180InizioMese(DataI),Parametri.WEBCartelliniMMPrec) < R180InizioMese(Date)) then
  begin
    Result:=Format('Non 柰ossibile elaborare il cartellino antecedente di %d mesi!',[Parametri.WEBCartelliniMMPrec]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMSucc >= 0) and (R180InizioMese(DataF) > R180AddMesi(R180InizioMese(Date),Parametri.WEBCartelliniMMSucc)) then
  begin
    Result:=Format('Non 柰ossibile elaborare il cartellino successivo a %d mesi!',[Parametri.WEBCartelliniMMSucc]);
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
    W009FStampaCartellinoDtm.CreazioneR400(SessioneOracleB020);
  except
    on E:Exception do
    begin
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
        iSQL:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');//Pos('FROM ',UpperCase(S));
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
        //Devo gi�vere l'elenco dei dati liberi 2001
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
        R180ScriviMsgLog('B020.log',Format('FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1)',['']));
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R600DtM1);
      end;
      try
       if W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0 then
       begin
         W009FStampaCartellinoDtM.W009CSStampa:=CSStampa;//B020FIrisWebSvc01Dtm.CSStampa;
         W009FStampaCartellinoDtm.RPDefine_DataID('B020');
         R180ScriviMsgLog('B020.log',Format('W009FStampaCartellinoDtM.EsecuzioneStampa',[]));
         S:=W009FStampaCartellinoDtM.EsecuzioneStampa;
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
        R180ScriviMsgLog('B020.log',Format('FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM)',['']));
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM);
      end;
      //W009FStampaCartellinoDtm.selAnagrafeW.Open;
      W009FStampaCartellinoDtM.DistruggiLstRaveComp;
      R180ScriviMsgLog('B020.log',Format('FreeAndNil(W009FStampaCartellinoDtm)',[]));
      FreeAndNil(W009FStampaCartellinoDtm);
    end;
  except
    on E:Exception do
      Result:=E.Message;
  end;
end;

function TForm1.CartellinoPDF(const DB,Azienda,Matricola,Dal,Al,Parametrizzazione,FilePdf: WideString): WideString; stdcall;
{Valorizzare le seguenti chiavi di registro in HKLM:
 - IrisWIN.HOME = c:\IrisWEB                (dove risiede il W009.rav)
 - IrisWIN.PATH_LOG = c:\IrisWEB\Archivi    (dove scrivere B020.log)
 - IrisWIN\B020.Database = IRIS             (database di default)
 - IrisWIN\B020.URL = http://server/        (per eseguire B020PTest)
}
var
  k:Integer;
  DataTemp: TDateTime;
begin
  try
    TipoRichiesta:='CartellinoPdf';
    Result:='';
    R180ScriviMsgLog('B020.log','-----------------');
    R180ScriviMsgLog('B020.log',Format('TB020IrisWebSvc01.CartellinoPDF:%s %s %s %s %s %s %s',[DB,Azienda,Matricola,Dal,Al,Parametrizzazione,FilePdf]));

    // controllo parametri
    if Trim(Matricola) = '' then
    begin
      Result:=GeneraErrore('Parametro errato','Matricola non specificata!');
      Exit;
    end;
    try
      DataTemp:=StrToDate(Dal);
    except
      on E: Exception do
      begin
        Result:=GeneraErrore('Parametro errato','Data inizio errata ' + Dal + ': ' + E.Message);
        Exit;
      end;
    end;
    try
      DataTemp:=StrToDate(Al);
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
      R180ScriviMsgLog('B020.log',Format('TW009FStampaCartellinoDtm.Create',[]));
      W009FStampaCartellinoDtm:=TW009FStampaCartellinoDtm.Create(B020FIrisWebSvc01Dtm.lstSessioniOracle[k]);
      Result:=CreaCartellinoPDF(B020FIrisWebSvc01Dtm.lstSessioniOracle[k],Matricola,Dal,Al,Parametrizzazione,FilePdf,'N');
      if Result <> '' then
      begin
        R180ScriviMsgLog('B020.log',Format('CartellinoPDF.Result=%s',[Result]));
        Result:=GeneraErrore('Errore cartellino',Result);
      end;
    finally
      FreeAndNil(W009FStampaCartellinoDtm);
      CSStampaCartellino.Leave;
      R180ScriviMsgLog('B020.log','TB020IrisWebSvc01.CartellinoPDF: FINE');
    end;
  except
    on E:Exception do
    begin
      Result:=GeneraErrore(E.ClassName,E.Message);
      R180ScriviMsgLog('B020.log',Format('CartellinoPDF.exception=%s',[E.Message]));
    end;
  end;
end;

function TForm1.R600GetAssenze(const DB,Azienda,Matricola,DataRiferimento,Causale,DataNasFam: WideString): WideString;
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
begin
  try
    TipoRichiesta:='DatiAssenze';
    Result:='';
    R180ScriviMsgLog('B020.log','-----------------');
    R180ScriviMsgLog('B020.log',Format('TB020IrisWebSvc01.R600GetAssenze:%s %s %s %s %s %s',[DB,Azienda,Matricola,DataRiferimento,Causale,DataNasFam]));

    // controllo parametri
    if Trim(Matricola) = '' then
    begin
      Result:=GeneraErrore('Parametro errato','Matricola errata');
      Exit;
    end;
    try
      DataRif:=StrToDate(DataRiferimento);
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
        DataNas:=StrToDateTime(DataNasFam);
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
      R180ScriviMsgLog('B020.log',Format('R600DtM.Create',[]));
      G.Inserimento:=False;
      G.Modo:='I';
      G.Causale:=Caus;
      R600DtM:=TR600Dtm1.Create(B020FIrisWebSvc01Dtm.lstSessioniOracle[k]);
      try
        R600DtM.GetAssenze(Progressivo,DataRif,DataRif,DataNas,G,False);
        XmlStr:='<UnitaMisura>' + R600DtM.UMisura + '</UnitaMisura>' + #13#10 +
                '<Competenze>' + R600DtM.GetCompTot + '</Competenze>' + #13#10 +
                '<Fruito>' + R600DtM.GetFruitoTot + '</Fruito>' + #13#10 +
                '<Residuo>' + R600DtM.GetResiduo + '</Residuo>';
        R180ScriviMsgLog('B020.log',Format('R600GetAssenze.Result=%s',[StringReplace(StringReplace(XmlStr,#13,'',[rfReplaceAll]),#10,'',[rfReplaceAll])]));
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
      R180ScriviMsgLog('B020.log','TB020IrisWebSvc01.R600GetAssenze: FINE');
    end;
  except
    on E:Exception do
    begin
      Result:=GeneraErrore('Errore generico',E.Message);
      R180ScriviMsgLog('B020.log',Format('R600GetAssenze.exception=%s',[E.Message]));
    end;
  end;
end;

function TForm1.R502Conteggi(const DB,Azienda,Matricola,DataRiferimento: WideString): WideString;
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
begin
  try
    TipoRichiesta:='Conteggi';
    Result:='';
    R180ScriviMsgLog('B020.log','-----------------');
    R180ScriviMsgLog('B020.log',Format('TB020IrisWebSvc01.R502Conteggi:%s %s %s %s',[DB,Azienda,Matricola,DataRiferimento]));

    // controllo parametri
    if Trim(Matricola) = '' then
    begin
      Result:=GeneraErrore('Parametro errato','Matricola mancante');
      Exit;
    end;
    try
      DataRif:=StrToDate(DataRiferimento);
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
        R180ScriviMsgLog('B020.log',Format('R502Conteggi.Result=%s',[StringReplace(StringReplace(XmlStr,#13,'',[rfReplaceAll]),#10,'',[rfReplaceAll])]));
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
      R180ScriviMsgLog('B020.log','TB020IrisWebSvc01.R502Conteggi:FINE');
    end;
  except
    on E:Exception do
    begin
      Result:=GeneraErrore('Errore generico',E.Message);
      R180ScriviMsgLog('B020.log',Format('R502Conteggi.exception=%s',[E.Message]));
    end;
  end;
end;

procedure TForm1.chkWebServiceClick(Sender: TObject);
begin
  if (chkWebService.Checked) and (chkNormale.Checked) then
  begin
    lblConfronto.Visible:=True;
    edtConfronto.Visible:=True;
  end
  else
  begin
    lblConfronto.Visible:=False;
    edtConfronto.Visible:=False;
  end;
end;

initialization
{ Invokable classes must be registered }
   CSStampa:=TMedpCriticalSection.Create;
   CSStampaCartellino:=TMedpCriticalSection.Create;

finalization
   CSStampa.Free;
   CSStampaCartellino.Free;

end.

